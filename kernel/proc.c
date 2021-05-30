
#include "include/types.h"
#include "include/param.h"
#include "include/memlayout.h"
#include "include/riscv.h"
#include "include/spinlock.h"
#include "include/proc.h"
#include "include/intr.h"
#include "include/kalloc.h"
#include "include/printf.h"
#include "include/string.h"
#include "include/fat32.h"
#include "include/file.h"
#include "include/trap.h"
#include "include/vm.h"


struct cpu cpus[NCPU];

struct proc proc[NPROC];

struct proc *initproc;

int nextpid = 1;
struct spinlock pid_lock;

extern void forkret(void);
extern void swtch(struct context*, struct context*);
static void wakeup1(struct proc *chan);
static void freeproc(struct proc *p);

extern char trampoline[]; // trampoline.S

void reg_info(void) {
  printf("register info: {\n");
  printf("sstatus: %p\n", r_sstatus());
  printf("sip: %p\n", r_sip());
  printf("sie: %p\n", r_sie());
  printf("sepc: %p\n", r_sepc());
  printf("stvec: %p\n", r_stvec());
  printf("satp: %p\n", r_satp());
  printf("scause: %p\n", r_scause());
  printf("stval: %p\n", r_stval());
  printf("sp: %p\n", r_sp());
  printf("tp: %p\n", r_tp());
  printf("ra: %p\n", r_ra());
  printf("}\n");
}

// initialize the proc table at boot time.
void
procinit(void)
{
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
  for(p = proc; p < &proc[NPROC]; p++) {
      initlock(&p->lock, "proc");

      // Allocate a page for the process's kernel stack.
      // Map it high in memory, followed by an invalid
      // guard page.
      // char *pa = kalloc();
      // // printf("[procinit]kernel stack: %p\n", (uint64)pa);
      // if(pa == 0)
      //   panic("kalloc");
      // uint64 va = KSTACK((int) (p - proc));
      // // printf("[procinit]kvmmap va %p to pa %p\n", va, (uint64)pa);
      // kvmmap(va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
      // p->kstack = va;
  }
  //kvminithart();

  memset(cpus, 0, sizeof(cpus));
  #ifdef DEBUG
  printf("procinit\n");
  #endif
}

// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
  int id = r_tp();
  return id;
}

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
  int id = cpuid();
  struct cpu *c = &cpus[id];
  
  return c;
}

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
  push_off();
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
  pop_off();
  return p;
}

int
allocpid() {
  int pid;
  
  acquire(&pid_lock);
  pid = nextpid;
  nextpid = nextpid + 1;
  release(&pid_lock);

  return pid;
}

// Look in the process table for an UNUSED proc.
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    acquire(&p->lock);
    if(p->state == UNUSED) {
      goto found;
    } else {
      release(&p->lock);
    }
  }
  return NULL;

found:
  p->pid = allocpid();

  // Allocate a trapframe page.
  if((p->trapframe = (struct trapframe *)kalloc()) == NULL){
    release(&p->lock);
    return NULL;
  }

  // An empty user page table.
  // And an identical kernel page table for this proc.
  if ((p->pagetable = proc_pagetable(p)) == NULL ||
      (p->kpagetable = proc_kpagetable()) == NULL) {
    freeproc(p);
    release(&p->lock);
    return NULL;
  }

  p->kstack = VKSTACK;

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
  p->context.ra = (uint64)forkret;
  p->context.sp = p->kstack + PGSIZE;

  return p;
}

// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
  if(p->trapframe)
    kfree((void*)p->trapframe);
  p->trapframe = 0;
  if (p->kpagetable) {
    kvmfree(p->kpagetable, 1);
  }
  p->kpagetable = 0;
  if(p->pagetable)
    proc_freepagetable(p->pagetable, p->sz);
  p->pagetable = 0;
  p->sz = 0;
  p->pid = 0;
  p->parent = 0;
  p->name[0] = 0;
  p->chan = 0;
  p->killed = 0;
  p->xstate = 0;
  p->state = UNUSED;
}

// Create a user page table for a given process,
// with no user memory, but with trampoline pages.
pagetable_t
proc_pagetable(struct proc *p)
{
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
  if(pagetable == 0)
    return NULL;

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    return NULL;
  }

  // map the trapframe just below TRAMPOLINE, for trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    vmunmap(pagetable, TRAMPOLINE, 1, 0);
    uvmfree(pagetable, 0);
    return NULL;
  }

  return pagetable;
}

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
  vmunmap(pagetable, TRAMPOLINE, 1, 0);
  vmunmap(pagetable, TRAPFRAME, 1, 0);
  uvmfree(pagetable, sz);
}

// a user program that calls exec("/init")
// od -t xC initcode
// uchar initcode[] = {
//   0x17, 0x05, 0x00, 0x00, 0x13, 0x05, 0x45, 0x02,
//   0x97, 0x05, 0x00, 0x00, 0x93, 0x85, 0x35, 0x02,
//   0x93, 0x08, 0x70, 0x00, 0x73, 0x00, 0x00, 0x00,
//   0x93, 0x08, 0x20, 0x00, 0x73, 0x00, 0x00, 0x00,
//   0xef, 0xf0, 0x9f, 0xff, 0x2f, 0x69, 0x6e, 0x69,
//   0x74, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00,
//   0x00, 0x00, 0x00, 0x00
// };

uchar initcode[] = {
0x79,0x71,0x06,0xf4,0x22,0xf0,0x26,0xec,0x00,0x18,0xaa,0x84,0x97,0x00,0x00,0x00,
0xe7,0x80,0x80,0x3c,0x19,0xed,0x23,0x38,0x94,0xfc,0x93,0x05,0x04,0xfd,0x26,0x85,
0x97,0x00,0x00,0x00,0xe7,0x80,0xe0,0x3f,0xa2,0x70,0x02,0x74,0xe2,0x64,0x45,0x61,
0x82,0x80,0x01,0x45,0x97,0x00,0x00,0x00,0xe7,0x80,0x20,0x3b,0xf5,0xb7,0x01,0x11,
0x06,0xec,0x22,0xe8,0x26,0xe4,0x4a,0xe0,0x00,0x10,0x01,0x46,0x85,0x45,0x09,0x45,
0x97,0x00,0x00,0x00,0xe7,0x80,0xc0,0x42,0x01,0x45,0x97,0x00,0x00,0x00,0xe7,0x80,
0x00,0x3f,0x01,0x45,0x97,0x00,0x00,0x00,0xe7,0x80,0x60,0x3e,0x97,0x14,0x00,0x00,
0x93,0x84,0x44,0x9f,0x17,0x19,0x00,0x00,0x13,0x09,0x49,0xae,0x88,0x60,0x97,0x00,
0x00,0x00,0xe7,0x80,0x20,0xf8,0xa1,0x04,0xe3,0x9a,0x24,0xff,0x01,0xa0,0x41,0x11,
0x22,0xe4,0x00,0x08,0xaa,0x87,0x85,0x05,0x85,0x07,0x03,0xc7,0xf5,0xff,0xa3,0x8f,
0xe7,0xfe,0x75,0xfb,0x22,0x64,0x41,0x01,0x82,0x80,0x41,0x11,0x22,0xe4,0x00,0x08,
0x83,0x47,0x05,0x00,0x85,0xc3,0xaa,0x87,0x85,0x07,0x03,0xc7,0x07,0x00,0x6d,0xff,
0x85,0x05,0x85,0x07,0x03,0xc7,0xf5,0xff,0xa3,0x8f,0xe7,0xfe,0x75,0xfb,0x22,0x64,
0x41,0x01,0x82,0x80,0xaa,0x87,0xed,0xb7,0x41,0x11,0x22,0xe4,0x00,0x08,0x83,0x47,
0x05,0x00,0x91,0xcf,0x03,0xc7,0x05,0x00,0x63,0x1b,0xf7,0x00,0x05,0x05,0x85,0x05,
0x83,0x47,0x05,0x00,0x89,0xc7,0x03,0xc7,0x05,0x00,0xe3,0x09,0xf7,0xfe,0x03,0xc5,
0x05,0x00,0x3b,0x85,0xa7,0x40,0x22,0x64,0x41,0x01,0x82,0x80,0x41,0x11,0x22,0xe4,
0x00,0x08,0x83,0x47,0x05,0x00,0x91,0xcf,0x05,0x05,0xaa,0x87,0x85,0x46,0x89,0x9e,
0x3b,0x85,0xf6,0x00,0x85,0x07,0x03,0xc7,0xf7,0xff,0x7d,0xfb,0x22,0x64,0x41,0x01,
0x82,0x80,0x01,0x45,0xe5,0xbf,0x41,0x11,0x22,0xe4,0x00,0x08,0x09,0xce,0xaa,0x87,
0x1b,0x07,0xf6,0xff,0x02,0x17,0x01,0x93,0x05,0x07,0x2a,0x97,0x23,0x80,0xb7,0x00,
0x85,0x07,0xe3,0x9d,0xe7,0xfe,0x22,0x64,0x41,0x01,0x82,0x80,0x41,0x11,0x22,0xe4,
0x00,0x08,0x83,0x47,0x05,0x00,0x91,0xcf,0x63,0x8a,0xf5,0x00,0x05,0x05,0x83,0x47,
0x05,0x00,0x81,0xc7,0xe3,0x9c,0xb7,0xfe,0x11,0xa0,0x01,0x45,0x22,0x64,0x41,0x01,
0x82,0x80,0x01,0x45,0xe5,0xbf,0x1d,0x71,0x86,0xec,0xa2,0xe8,0xa6,0xe4,0xca,0xe0,
0x4e,0xfc,0x52,0xf8,0x56,0xf4,0x5a,0xf0,0x5e,0xec,0x80,0x10,0xaa,0x8b,0x2e,0x8a,
0x2a,0x89,0x81,0x49,0xa9,0x4a,0x35,0x4b,0x9b,0x84,0x19,0x00,0x63,0xd8,0x44,0x03,
0x05,0x46,0x93,0x05,0xf4,0xfa,0x01,0x45,0x97,0x00,0x00,0x00,0xe7,0x80,0x00,0x24,
0x63,0x5e,0xa0,0x00,0x83,0x47,0xf4,0xfa,0x23,0x00,0xf9,0x00,0x63,0x87,0x57,0x01,
0x05,0x09,0xa6,0x89,0xe3,0x9a,0x67,0xfd,0x11,0xa0,0xa6,0x89,0xde,0x99,0x23,0x80,
0x09,0x00,0x5e,0x85,0xe6,0x60,0x46,0x64,0xa6,0x64,0x06,0x69,0xe2,0x79,0x42,0x7a,
0xa2,0x7a,0x02,0x7b,0xe2,0x6b,0x25,0x61,0x82,0x80,0x1d,0x71,0x86,0xec,0xa2,0xe8,
0xa6,0xe4,0xca,0xe0,0x4e,0xfc,0x52,0xf8,0x56,0xf4,0x5a,0xf0,0x5e,0xec,0x62,0xe8,
0x80,0x10,0xaa,0x8a,0x2e,0x8c,0x32,0x8a,0x2e,0x89,0x81,0x49,0x29,0x4b,0xb5,0x4b,
0x9b,0x84,0x19,0x00,0x63,0xd8,0x44,0x03,0x05,0x46,0x93,0x05,0xf4,0xfa,0x56,0x85,
0x97,0x00,0x00,0x00,0xe7,0x80,0x80,0x1c,0x63,0x5e,0xa0,0x00,0x83,0x47,0xf4,0xfa,
0x23,0x00,0xf9,0x00,0x63,0x87,0x67,0x01,0x05,0x09,0xa6,0x89,0xe3,0x9a,0x77,0xfd,
0x11,0xa0,0xa6,0x89,0xe2,0x99,0x23,0x80,0x09,0x00,0x62,0x85,0xe6,0x60,0x46,0x64,
0xa6,0x64,0x06,0x69,0xe2,0x79,0x42,0x7a,0xa2,0x7a,0x02,0x7b,0xe2,0x6b,0x42,0x6c,
0x25,0x61,0x82,0x80,0x01,0x11,0x06,0xec,0x22,0xe8,0x26,0xe4,0x4a,0xe0,0x00,0x10,
0x2e,0x89,0x81,0x45,0x97,0x00,0x00,0x00,0xe7,0x80,0x20,0x1a,0x63,0x45,0x05,0x02,
0xaa,0x84,0xca,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,0xa0,0x19,0x2a,0x89,0x26,0x85,
0x97,0x00,0x00,0x00,0xe7,0x80,0xc0,0x16,0x4a,0x85,0xe2,0x60,0x42,0x64,0xa2,0x64,
0x02,0x69,0x05,0x61,0x82,0x80,0x7d,0x59,0xc5,0xbf,0x41,0x11,0x22,0xe4,0x00,0x08,
0x03,0x47,0x05,0x00,0x93,0x07,0xd0,0x02,0x05,0x48,0x63,0x03,0xf7,0x04,0x83,0x46,
0x05,0x00,0x9b,0x87,0x06,0xfd,0x93,0xf7,0xf7,0x0f,0x25,0x47,0x63,0x6d,0xf7,0x02,
0x01,0x46,0xa5,0x45,0x05,0x05,0x9b,0x17,0x26,0x00,0xb1,0x9f,0x9b,0x97,0x17,0x00,
0xb5,0x9f,0x1b,0x86,0x07,0xfd,0x83,0x46,0x05,0x00,0x1b,0x87,0x06,0xfd,0x13,0x77,
0xf7,0x0f,0xe3,0xf1,0xe5,0xfe,0x3b,0x05,0xc8,0x02,0x22,0x64,0x41,0x01,0x82,0x80,
0x05,0x05,0x7d,0x58,0x6d,0xbf,0x01,0x46,0xfd,0xb7,0x41,0x11,0x22,0xe4,0x00,0x08,
0x63,0x76,0xb5,0x02,0x63,0x51,0xc0,0x02,0x9b,0x07,0xf6,0xff,0x82,0x17,0x81,0x93,
0x85,0x07,0xaa,0x97,0x2a,0x87,0x85,0x05,0x05,0x07,0x83,0xc6,0xf5,0xff,0xa3,0x0f,
0xd7,0xfe,0xe3,0x9a,0xe7,0xfe,0x22,0x64,0x41,0x01,0x82,0x80,0x33,0x07,0xc5,0x00,
0xb2,0x95,0xe3,0x5a,0xc0,0xfe,0x9b,0x07,0xf6,0xff,0x82,0x17,0x81,0x93,0x93,0xc7,
0xf7,0xff,0xba,0x97,0xfd,0x15,0x7d,0x17,0x83,0xc6,0x05,0x00,0x23,0x00,0xd7,0x00,
0xe3,0x1a,0xf7,0xfe,0xc9,0xbf,0x41,0x11,0x22,0xe4,0x00,0x08,0x15,0xce,0x9b,0x06,
0xf6,0xff,0x83,0x47,0x05,0x00,0x03,0xc7,0x05,0x00,0x63,0x90,0xe7,0x02,0x82,0x16,
0x81,0x92,0x85,0x06,0xaa,0x96,0x05,0x05,0x85,0x05,0x63,0x0d,0xd5,0x00,0x83,0x47,
0x05,0x00,0x03,0xc7,0x05,0x00,0xe3,0x88,0xe7,0xfe,0x3b,0x85,0xe7,0x40,0x22,0x64,
0x41,0x01,0x82,0x80,0x01,0x45,0xe5,0xbf,0x01,0x45,0xd5,0xbf,0x41,0x11,0x06,0xe4,
0x22,0xe0,0x00,0x08,0x97,0x00,0x00,0x00,0xe7,0x80,0x60,0xf5,0xa2,0x60,0x02,0x64,
0x41,0x01,0x82,0x80,0x85,0x48,0x73,0x00,0x00,0x00,0x82,0x80,0x93,0x08,0xd0,0x05,
0x73,0x00,0x00,0x00,0x82,0x80,0x8d,0x48,0x73,0x00,0x00,0x00,0x82,0x80,0x93,0x08,
0xb0,0x03,0x73,0x00,0x00,0x00,0x82,0x80,0x93,0x08,0xf0,0x03,0x73,0x00,0x00,0x00,
0x82,0x80,0x93,0x08,0x00,0x04,0x73,0x00,0x00,0x00,0x82,0x80,0x93,0x08,0x90,0x03,
0x73,0x00,0x00,0x00,0x82,0x80,0x99,0x48,0x73,0x00,0x00,0x00,0x82,0x80,0x9d,0x48,
0x73,0x00,0x00,0x00,0x82,0x80,0xbd,0x48,0x73,0x00,0x00,0x00,0x82,0x80,0x93,0x08,
0x00,0x05,0x73,0x00,0x00,0x00,0x82,0x80,0xd1,0x48,0x73,0x00,0x00,0x00,0x82,0x80,
0x93,0x08,0x10,0x03,0x73,0x00,0x00,0x00,0x82,0x80,0xdd,0x48,0x73,0x00,0x00,0x00,
0x82,0x80,0x93,0x08,0xc0,0x0a,0x73,0x00,0x00,0x00,0x82,0x80,0xb1,0x48,0x73,0x00,
0x00,0x00,0x82,0x80,0xb5,0x48,0x73,0x00,0x00,0x00,0x82,0x80,0xb9,0x48,0x73,0x00,
0x00,0x00,0x82,0x80,0xd9,0x48,0x73,0x00,0x00,0x00,0x82,0x80,0x93,0x08,0x50,0x06,
0x73,0x00,0x00,0x00,0x82,0x80,0x93,0x08,0x40,0x06,0x73,0x00,0x00,0x00,0x82,0x80,
0xc5,0x48,0x73,0x00,0x00,0x00,0x82,0x80,0xe5,0x48,0x73,0x00,0x00,0x00,0x82,0x80,
0xc9,0x48,0x73,0x00,0x00,0x00,0x82,0x80,0xcd,0x48,0x73,0x00,0x00,0x00,0x82,0x80,
0xe9,0x48,0x73,0x00,0x00,0x00,0x82,0x80,0x01,0x11,0x06,0xec,0x22,0xe8,0x00,0x10,
0xa3,0x07,0xb4,0xfe,0x05,0x46,0x93,0x05,0xf4,0xfe,0x97,0x00,0x00,0x00,0xe7,0x80,
0x80,0xf3,0xe2,0x60,0x42,0x64,0x05,0x61,0x82,0x80,0x39,0x71,0x06,0xfc,0x22,0xf8,
0x26,0xf4,0x4a,0xf0,0x4e,0xec,0x80,0x00,0x99,0xc2,0x63,0xcd,0x05,0x00,0x81,0x25,
0x01,0x43,0x13,0x07,0x04,0xfc,0x01,0x48,0x01,0x26,0x97,0x08,0x00,0x00,0x93,0x88,
0x68,0x54,0x39,0xa0,0xbb,0x05,0xb0,0x40,0x05,0x43,0xe5,0xb7,0xbe,0x85,0x36,0x88,
0x9b,0x06,0x18,0x00,0xbb,0xf7,0xc5,0x02,0x82,0x17,0x81,0x93,0xc6,0x97,0x83,0xc7,
0x07,0x00,0x23,0x00,0xf7,0x00,0x05,0x07,0xbb,0xd7,0xc5,0x02,0xe3,0xf0,0xc5,0xfe,
0x63,0x0b,0x03,0x00,0x93,0x07,0x04,0xfd,0xbe,0x96,0x93,0x07,0xd0,0x02,0x23,0x88,
0xf6,0xfe,0x9b,0x06,0x28,0x00,0x63,0x59,0xd0,0x02,0xaa,0x89,0x93,0x07,0x04,0xfc,
0xb3,0x84,0xd7,0x00,0x13,0x89,0xf7,0xff,0x36,0x99,0xfd,0x36,0x82,0x16,0x81,0x92,
0x33,0x09,0xd9,0x40,0x83,0xc5,0xf4,0xff,0x4e,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,
0xe0,0xf4,0xfd,0x14,0xe3,0x98,0x24,0xff,0xe2,0x70,0x42,0x74,0xa2,0x74,0x02,0x79,
0xe2,0x69,0x21,0x61,0x82,0x80,0x19,0x71,0x86,0xfc,0xa2,0xf8,0xa6,0xf4,0xca,0xf0,
0xce,0xec,0xd2,0xe8,0xd6,0xe4,0xda,0xe0,0x5e,0xfc,0x62,0xf8,0x66,0xf4,0x6a,0xf0,
0x6e,0xec,0x00,0x01,0x83,0xc4,0x05,0x00,0x63,0x8d,0x04,0x18,0xaa,0x8a,0x32,0x8b,
0x13,0x89,0x15,0x00,0x81,0x49,0x13,0x0a,0x50,0x02,0x13,0x0c,0x40,0x06,0x93,0x0c,
0xc0,0x06,0x13,0x0d,0x80,0x07,0x93,0x0d,0x00,0x07,0x97,0x0b,0x00,0x00,0x93,0x8b,
0x6b,0x47,0x39,0xa8,0xa6,0x85,0x56,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,0x00,0xee,
0x19,0xa0,0x63,0x8f,0x49,0x01,0x05,0x09,0x83,0x44,0xf9,0xff,0x63,0x8b,0x04,0x14,
0x9b,0x87,0x04,0x00,0xe3,0x97,0x09,0xfe,0xe3,0x9e,0x47,0xfd,0xbe,0x89,0xe5,0xb7,
0x63,0x80,0x87,0x05,0x63,0x8c,0x97,0x05,0x63,0x88,0xa7,0x07,0x63,0x84,0xb7,0x09,
0x13,0x07,0x30,0x07,0x63,0x85,0xe7,0x0c,0x13,0x07,0x30,0x06,0x63,0x8c,0xe7,0x0e,
0x63,0x86,0x47,0x11,0xd2,0x85,0x56,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,0x00,0xe9,
0xa6,0x85,0x56,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,0x40,0xe8,0x81,0x49,0x65,0xb7,
0x93,0x04,0x8b,0x00,0x85,0x46,0x29,0x46,0x83,0x25,0x0b,0x00,0x56,0x85,0x97,0x00,
0x00,0x00,0xe7,0x80,0xc0,0xe8,0x26,0x8b,0x81,0x49,0x71,0xb7,0x93,0x04,0x8b,0x00,
0x81,0x46,0x29,0x46,0x83,0x25,0x0b,0x00,0x56,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,
0x00,0xe7,0x26,0x8b,0x81,0x49,0x85,0xbf,0x93,0x04,0x8b,0x00,0x81,0x46,0x41,0x46,
0x83,0x25,0x0b,0x00,0x56,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,0x40,0xe5,0x26,0x8b,
0x81,0x49,0x91,0xbf,0x93,0x07,0x8b,0x00,0x23,0x34,0xf4,0xf8,0x83,0x39,0x0b,0x00,
0x93,0x05,0x00,0x03,0x56,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,0x20,0xe1,0xea,0x85,
0x56,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,0x60,0xe0,0xc1,0x44,0x93,0xd7,0xc9,0x03,
0xde,0x97,0x83,0xc5,0x07,0x00,0x56,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,0x00,0xdf,
0x92,0x09,0xfd,0x34,0xe5,0xf4,0x03,0x3b,0x84,0xf8,0x81,0x49,0x29,0xb7,0x93,0x09,
0x8b,0x00,0x83,0x34,0x0b,0x00,0x85,0xc0,0x83,0xc5,0x04,0x00,0xa1,0xc9,0x56,0x85,
0x97,0x00,0x00,0x00,0xe7,0x80,0x80,0xdc,0x85,0x04,0x83,0xc5,0x04,0x00,0xe5,0xf9,
0x4e,0x8b,0x81,0x49,0xcd,0xb5,0x97,0x04,0x00,0x00,0x93,0x84,0x24,0x35,0x93,0x05,
0x80,0x02,0xf1,0xbf,0x93,0x04,0x8b,0x00,0x83,0x45,0x0b,0x00,0x56,0x85,0x97,0x00,
0x00,0x00,0xe7,0x80,0xa0,0xd9,0x26,0x8b,0x81,0x49,0x75,0xbd,0xd2,0x85,0x56,0x85,
0x97,0x00,0x00,0x00,0xe7,0x80,0x80,0xd8,0x81,0x49,0x75,0xb5,0x4e,0x8b,0x81,0x49,
0x5d,0xb5,0xe6,0x70,0x46,0x74,0xa6,0x74,0x06,0x79,0xe6,0x69,0x46,0x6a,0xa6,0x6a,
0x06,0x6b,0xe2,0x7b,0x42,0x7c,0xa2,0x7c,0x02,0x7d,0xe2,0x6d,0x09,0x61,0x82,0x80,
0x5d,0x71,0x06,0xec,0x22,0xe8,0x00,0x10,0x10,0xe0,0x14,0xe4,0x18,0xe8,0x1c,0xec,
0x23,0x30,0x04,0x03,0x23,0x34,0x14,0x03,0x23,0x34,0x84,0xfe,0x22,0x86,0x97,0x00,
0x00,0x00,0xe7,0x80,0x80,0xe0,0xe2,0x60,0x42,0x64,0x61,0x61,0x82,0x80,0x1d,0x71,
0x06,0xec,0x22,0xe8,0x00,0x10,0x0c,0xe4,0x10,0xe8,0x14,0xec,0x18,0xf0,0x1c,0xf4,
0x23,0x38,0x04,0x03,0x23,0x3c,0x14,0x03,0x13,0x06,0x84,0x00,0x23,0x34,0xc4,0xfe,
0xaa,0x85,0x05,0x45,0x97,0x00,0x00,0x00,0xe7,0x80,0x20,0xdd,0xe2,0x60,0x42,0x64,
0x25,0x61,0x82,0x80,0x41,0x11,0x22,0xe4,0x00,0x08,0x93,0x06,0x05,0xff,0x97,0x07,
0x00,0x00,0x93,0x87,0x27,0x39,0x9c,0x63,0x05,0xa8,0x18,0x46,0xb9,0x9d,0x23,0x2c,
0xb5,0xfe,0x98,0x63,0x18,0x63,0x23,0x38,0xe5,0xfe,0x91,0xa0,0x03,0x27,0x85,0xff,
0x39,0x9e,0x90,0xc7,0x03,0x37,0x05,0xff,0x98,0xe3,0x99,0xa0,0x98,0x63,0x63,0xe4,
0xe7,0x00,0x63,0xea,0xe6,0x00,0xba,0x87,0xe3,0xfa,0xd7,0xfe,0x98,0x63,0x63,0xe4,
0xe6,0x00,0xe3,0xea,0xe7,0xfe,0x83,0x25,0x85,0xff,0x90,0x63,0x13,0x97,0x05,0x02,
0x01,0x93,0x12,0x07,0x36,0x97,0xe3,0x0a,0xe6,0xfa,0x23,0x38,0xc5,0xfe,0x90,0x47,
0x13,0x17,0x06,0x02,0x01,0x93,0x12,0x07,0x3e,0x97,0xe3,0x89,0xe6,0xfa,0x94,0xe3,
0x17,0x07,0x00,0x00,0x23,0x30,0xf7,0x32,0x22,0x64,0x41,0x01,0x82,0x80,0x39,0x71,
0x06,0xfc,0x22,0xf8,0x26,0xf4,0x4a,0xf0,0x4e,0xec,0x52,0xe8,0x56,0xe4,0x5a,0xe0,
0x80,0x00,0x93,0x19,0x05,0x02,0x93,0xd9,0x09,0x02,0xbd,0x09,0x93,0xd9,0x49,0x00,
0x85,0x29,0x1b,0x89,0x09,0x00,0x97,0x07,0x00,0x00,0x93,0x87,0xa7,0x2e,0x88,0x63,
0x15,0xc5,0x1c,0x61,0x98,0x47,0x63,0x7f,0x27,0x03,0x4e,0x8a,0x1b,0x87,0x09,0x00,
0x85,0x66,0x63,0x73,0xd7,0x00,0x05,0x6a,0x9b,0x0a,0x0a,0x00,0x1b,0x1a,0x4a,0x00,
0x97,0x04,0x00,0x00,0x93,0x84,0x04,0x2c,0x7d,0x5b,0x85,0xa8,0x97,0x07,0x00,0x00,
0x93,0x87,0xc7,0x2b,0x17,0x07,0x00,0x00,0x23,0x36,0xf7,0x2a,0x9c,0xe3,0x23,0xa4,
0x07,0x00,0xe1,0xb7,0x63,0x0b,0xe9,0x02,0x3b,0x07,0x37,0x41,0x98,0xc7,0x02,0x17,
0x01,0x93,0x12,0x07,0xba,0x97,0x23,0xa4,0x37,0x01,0x17,0x07,0x00,0x00,0x23,0x33,
0xa7,0x28,0x13,0x85,0x07,0x01,0xe2,0x70,0x42,0x74,0xa2,0x74,0x02,0x79,0xe2,0x69,
0x42,0x6a,0xa2,0x6a,0x02,0x6b,0x21,0x61,0x82,0x80,0x98,0x63,0x18,0xe1,0xf1,0xbf,
0x23,0x24,0x55,0x01,0x41,0x05,0x97,0x00,0x00,0x00,0xe7,0x80,0xe0,0xeb,0x88,0x60,
0x79,0xd9,0x1c,0x61,0x98,0x47,0xe3,0x77,0x27,0xfb,0x98,0x60,0x3e,0x85,0xe3,0x1a,
0xf7,0xfe,0x52,0x85,0x97,0x00,0x00,0x00,0xe7,0x80,0x80,0xb3,0xe3,0x1a,0x65,0xfd,
0x01,0x45,0x55,0xbf,0x00,0x00,0x00,0x00,0x67,0x65,0x74,0x64,0x65,0x6e,0x74,0x73,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x66,0x73,0x74,0x61,0x74,0x00,0x00,0x00,
0x6f,0x70,0x65,0x6e,0x61,0x74,0x00,0x00,0x6d,0x6b,0x64,0x69,0x72,0x5f,0x00,0x00,
0x72,0x65,0x61,0x64,0x00,0x00,0x00,0x00,0x77,0x72,0x69,0x74,0x65,0x00,0x00,0x00,
0x67,0x65,0x74,0x63,0x77,0x64,0x00,0x00,0x67,0x65,0x74,0x70,0x69,0x64,0x00,0x00,
0x67,0x65,0x74,0x70,0x70,0x69,0x64,0x00,0x6f,0x70,0x65,0x6e,0x00,0x00,0x00,0x00,
0x70,0x69,0x70,0x65,0x00,0x00,0x00,0x00,0x66,0x6f,0x72,0x6b,0x00,0x00,0x00,0x00,
0x64,0x75,0x70,0x00,0x00,0x00,0x00,0x00,0x64,0x75,0x70,0x32,0x00,0x00,0x00,0x00,
0x65,0x78,0x69,0x74,0x00,0x00,0x00,0x00,0x65,0x78,0x65,0x63,0x76,0x65,0x00,0x00,
0x62,0x72,0x6b,0x00,0x00,0x00,0x00,0x00,0x63,0x6c,0x6f,0x73,0x65,0x00,0x00,0x00,
0x63,0x6c,0x6f,0x6e,0x65,0x00,0x00,0x00,0x63,0x68,0x64,0x69,0x72,0x00,0x00,0x00,
0x77,0x61,0x69,0x74,0x00,0x00,0x00,0x00,0x77,0x61,0x69,0x74,0x70,0x69,0x64,0x00,
0x79,0x69,0x65,0x6c,0x64,0x00,0x00,0x00,0x74,0x69,0x6d,0x65,0x73,0x00,0x00,0x00,
0x75,0x6d,0x6f,0x75,0x6e,0x74,0x00,0x00,0x75,0x6e,0x61,0x6d,0x65,0x00,0x00,0x00,
0x75,0x6e,0x6c,0x69,0x6e,0x6b,0x00,0x00,0x67,0x65,0x74,0x74,0x69,0x6d,0x65,0x6f,
0x66,0x64,0x61,0x79,0x00,0x00,0x00,0x00,0x6d,0x6d,0x61,0x70,0x00,0x00,0x00,0x00,
0x6d,0x6f,0x75,0x6e,0x74,0x00,0x00,0x00,0x6d,0x75,0x6e,0x6d,0x61,0x70,0x00,0x00,
0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x41,0x42,0x43,0x44,0x45,0x46,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x28,0x6e,0x75,0x6c,0x6c,0x29,0x00,0x00,
0x38,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0x48,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0x50,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0x58,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0x60,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0x68,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0x70,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0x78,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0x80,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0x88,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0x90,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0x98,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0xa0,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0xa8,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0xb0,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0xb8,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0xc0,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0xc8,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0xd0,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0xd8,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0xe0,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0xe8,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0xf0,0x09,0x00,0x00,0x00,0x00,0x00,0x00,0xf8,0x09,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x0a,0x00,0x00,0x00,0x00,0x00,0x00,0x08,0x0a,0x00,0x00,0x00,0x00,0x00,0x00,
0x10,0x0a,0x00,0x00,0x00,0x00,0x00,0x00,0x18,0x0a,0x00,0x00,0x00,0x00,0x00,0x00,
0x28,0x0a,0x00,0x00,0x00,0x00,0x00,0x00,0x30,0x0a,0x00,0x00,0x00,0x00,0x00,0x00,
0x38,0x0a,0x00,0x00,0x00,0x00,0x00,0x00,0x1f,0x00,0x00,0x00
};


// Set up first user process.
void
userinit(void)
{
  struct proc *p;

  p = allocproc();
  initproc = p;
  
  // allocate one user page and copy init's instructions
  // and data into it.
  uvminit(p->pagetable , p->kpagetable, initcode, sizeof(initcode));
  p->sz = PGSIZE;

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0x3E;      // user program counter
  p->trapframe->sp = PGSIZE;  // user stack pointer

  safestrcpy(p->name, "initcode", sizeof(p->name));

  p->state = RUNNABLE;

  p->tmask = 0;

  release(&p->lock);
  #ifdef DEBUG
  printf("userinit\n");
  #endif
}

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *p = myproc();

  sz = p->sz;
  if(n > 0){
    if((sz = uvmalloc(p->pagetable, p->kpagetable, sz, sz + n)) == 0) {
      return -1;
    }
  } else if(n < 0){
    sz = uvmdealloc(p->pagetable, p->kpagetable, sz, sz + n);
  }
  p->sz = sz;
  return 0;
}

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
  return clone(SIGCHLD,0);
}

// Create a new process, copying the parent,can choose stack
int
clone(int flag, uint64 stack)
{
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();

  // Allocate process.
  if((np = allocproc()) == NULL){
    return -1;
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, np->kpagetable, p->sz) < 0){
    freeproc(np);
    release(&np->lock);
    return -1;
  }
  np->sz = p->sz;

  np->parent = p;

  // copy tracing mask from parent.
  np->tmask = p->tmask;

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
  if(stack!=0)
    np->trapframe->sp = stack;

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    if(p->ofile[i])
      np->ofile[i] = filedup(p->ofile[i]);
  np->cwd = edup(p->cwd);

  safestrcpy(np->name, p->name, sizeof(p->name));

  pid = np->pid;

  np->state = RUNNABLE;

  release(&np->lock);

  return pid;
}

// Pass p's abandoned children to init.
// Caller must hold p->lock.
void
reparent(struct proc *p)
{
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    // this code uses pp->parent without holding pp->lock.
    // acquiring the lock first could cause a deadlock
    // if pp or a child of pp were also in exit()
    // and about to try to lock p.
    if(pp->parent == p){
      // pp->parent can't change between the check and the acquire()
      // because only the parent changes it, and we're the parent.
      acquire(&pp->lock);
      pp->parent = initproc;
      // we should wake up init here, but that would require
      // initproc->lock, which would be a deadlock, since we hold
      // the lock on one of init's children (pp). this is why
      // exit() always wakes init (before acquiring any locks).
      release(&pp->lock);
    }
  }
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
  struct proc *p = myproc();

  if(p == initproc)
    panic("init exiting");

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    if(p->ofile[fd]){
      struct file *f = p->ofile[fd];
      fileclose(f);
      p->ofile[fd] = 0;
    }
  }

  eput(p->cwd);
  p->cwd = 0;

  // we might re-parent a child to init. we can't be precise about
  // waking up init, since we can't acquire its lock once we've
  // acquired any other proc lock. so wake up init whether that's
  // necessary or not. init may miss this wakeup, but that seems
  // harmless.
  acquire(&initproc->lock);
  wakeup1(initproc);
  release(&initproc->lock);

  // grab a copy of p->parent, to ensure that we unlock the same
  // parent we locked. in case our parent gives us away to init while
  // we're waiting for the parent lock. we may then race with an
  // exiting parent, but the result will be a harmless spurious wakeup
  // to a dead or wrong process; proc structs are never re-allocated
  // as anything else.
  acquire(&p->lock);
  struct proc *original_parent = p->parent;
  release(&p->lock);
  
  // we need the parent's lock in order to wake it up from wait().
  // the parent-then-child rule says we have to lock it first.
  acquire(&original_parent->lock);

  acquire(&p->lock);

  // Give any children to init.
  reparent(p);

  // Parent might be sleeping in wait().
  wakeup1(original_parent);

  p->xstate = status;
  p->state = ZOMBIE;

  release(&original_parent->lock);

  // Jump into the scheduler, never to return.
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
  return wait4(-1,addr,WCONTINUED);
}

// Wait for pid process to exit and return its pid.
// if pid =-1, wait for any child process to return.
//if options = WNOHANG, and child's status not change, return 0 
int
wait4(int pid, uint64 addr,int options)
{
  if(pid != -1 && pid <= 0)
    return -1;
  
  struct proc *np;
  int havekids,res_status,res_pid;
  struct proc *p = myproc();

  // hold p->lock for the whole time to avoid lost
  // wakeups from a child's exit().
  acquire(&p->lock);

  while(1){
    // Scan through table looking for exited children.
    havekids = 0;
    for(np = proc; np < &proc[NPROC]; np++){
      // this code uses np->parent without holding np->lock.
      // acquiring the lock first would cause a deadlock,
      // since np might be an ancestor, and we already hold p->lock.
      if(np->parent != p)
        continue;
      if(pid != -1 && np->pid !=pid)
        continue;
    
      // np->parent can't change between the check and the acquire()
      // because only the parent changes it, and we're the parent.
      acquire(&np->lock);
      havekids = 1;
      if(np->state == ZOMBIE){
        // Found one.
        res_pid = np->pid;
        res_status = np->xstate;
        if(addr != 0 && copyout2(addr, (char *)&res_status, sizeof(res_status)) < 0) {
          release(&np->lock);
          release(&p->lock);
          return -1;
        }
        freeproc(np);
        release(&np->lock);
        release(&p->lock);
        return res_pid;
      }
      release(&np->lock);
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
      release(&p->lock);
      return -1;
    }
    
    if(options & WNOHANG)
      return 0;
    // Wait for a child to exit.
    sleep(p, &p->lock);  //DOC: wait-sleep
  }
}

// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run.
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  extern pagetable_t kernel_pagetable;

  c->proc = 0;
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    
    int found = 0;
    for(p = proc; p < &proc[NPROC]; p++) {
      acquire(&p->lock);
      if(p->state == RUNNABLE) {
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        // printf("[scheduler]found runnable proc with pid: %d\n", p->pid);
        p->state = RUNNING;
        c->proc = p;
        w_satp(MAKE_SATP(p->kpagetable));
        sfence_vma();
        swtch(&c->context, &p->context);
        w_satp(MAKE_SATP(kernel_pagetable));
        sfence_vma();
        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;

        found = 1;
      }
      release(&p->lock);
    }
    if(found == 0) {
      intr_on();
      asm volatile("wfi");
    }
  }
}

// Switch to scheduler.  Must hold only p->lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&p->lock))
    panic("sched p->lock");
  if(mycpu()->noff != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(intr_get())
    panic("sched interruptible");

  intena = mycpu()->intena;
  swtch(&p->context, &mycpu()->context);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  struct proc *p = myproc();
  acquire(&p->lock);
  p->state = RUNNABLE;
  sched();
  release(&p->lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
  // printf("run in forkret\n");
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);

  if (first) {
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    // printf("[forkret]first scheduling\n");
    first = 0;
    fat32_init();
    myproc()->cwd = ename("/",AT_FDCWD);
  }

  usertrapret();
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  // Must acquire p->lock in order to
  // change p->state and then call sched.
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.
  if(lk != &p->lock){  //DOC: sleeplock0
    acquire(&p->lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &p->lock){
    release(&p->lock);
    acquire(lk);
  }
}

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    acquire(&p->lock);
    if(p->state == SLEEPING && p->chan == chan) {
      p->state = RUNNABLE;
    }
    release(&p->lock);
  }
}

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
  if(!holding(&p->lock))
    panic("wakeup1");
  if(p->chan == p && p->state == SLEEPING) {
    p->state = RUNNABLE;
  }
}

// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    acquire(&p->lock);
    if(p->pid == pid){
      p->killed = 1;
      if(p->state == SLEEPING){
        // Wake process from sleep().
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
  }
  return -1;
}

// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
  // struct proc *p = myproc();
  if(user_dst){
    // return copyout(p->pagetable, dst, src, len);
    return copyout2(dst, src, len);
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}

// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
  // struct proc *p = myproc();
  if(user_src){
    // return copyin(p->pagetable, dst, src, len);
    return copyin2(dst, src, len);
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\nPID\tSTATE\tNAME\tMEM\n");
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    printf("%d\t%s\t%s\t%d", p->pid, state, p->name, p->sz);
    printf("\n");
  }
}

uint64
procnum(void)
{
  int num = 0;
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++) {
    if (p->state != UNUSED) {
      num++;
    }
  }

  return num;
}

