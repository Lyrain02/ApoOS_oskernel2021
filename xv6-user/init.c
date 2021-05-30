// init: The initial user-level program

#include "xv6-user/user.h"

const int test_c = 31;

char *test_name[] = {"read","write","getcwd","getpid","getppid","open","pipe","fork","dup","dup2","exit","execve","brk","openat","close","chdir","getdents","mkdir_","times","umount","uname","unlink","clone","wait","waitpid","yield","fstat","gettimeofday","mmap","mount","munmap"};

void test(char* name) {
  int pid = fork();
  char *argv[2];
  if (pid == 0) {
    argv[0] = name;
    exec(name, argv);
  } else {
    wait(pid);
  }
}

int
main(void)
{
  dev(O_RDWR, 1, 0);
  dup(0);
  dup(0);

  int i;
  for (i = 0; i < test_c; i++) {
    test(test_name[i]);
  }

  for(;;);
}
