// init: The initial user-level program

#include "xv6-user/user.h"

const int test_c = 31;

char *test_name[] = {"fork","execve","getcwd","getpid","getppid","pipe","dup","exit","open","read","write","brk","mkdir_","chdir","openat","munmap","getdents","gettimeofday","times","close","umount","uname","unlink","yield","fstat","dup2","clone","wait","waitpid","mmap","mount"};

void test(char* name) {
  int pid = fork();
  char *argv[2];
  if (pid == 0) {
    argv[0] = name;
    exec(name, argv);
  } else {
    wait(0);
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
