// init: The initial user-level program

#include "xv6-user/user.h"

const int test_c = 31;

char *test_name[] = {"getcwd","getpid","getppid","pipe","clone","uname","execve","fork","wait","waitpid","write","dup","brk","exit","yield","times","sleep","dup2","open","openat","mkdir_","chdir","close","gettimeofday","fstat","getdents","mmap","mount","munmap","read","umount","unlink"};

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
