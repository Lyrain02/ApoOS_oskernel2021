// init: The initial user-level program

#include "xv6-user/user.h"

const int test_c = 31;

char *test_name[] = {"write","getcwd","getpid","brk","chdir","execve","clone","open","pipe","read","close","openat","dup","exit","fork","getdents","getppid","gettimeofday","mkdir_","mmap","mount","munmap","times","umount","uname","unlink","wait","waitpid","yield","fstat","dup2"};

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
