#include "kernel/include/types.h"
#include "xv6-user/user.h"
#include "kernel/include/file.h"
#include "kernel/include/fcntl.h"
#define NOWCHAR (*buf)

char arg0[9] = "/busybox";
char arg1[20],arg2[20],arg3[20],arg4[20],arg5[20];
char* argwhat[6] = {arg0,arg1,arg2,arg3,arg4,arg5};

void print_success(char **argv)
{
    printf("testcase busybox ");
    for (int i = 1; argv[i]; i++)
        printf("%s ", argv[i]);
    printf("success\n");
}

void test(char *name, char **argv)
{
    int pid = fork();
    if (pid == 0) {
        exec(name, argv);
    }
    else {
        for(;;){
            int ret;
            int wpid = wait(&ret);
            if (!ret)  print_success(argv);
            if(wpid == pid){
                break;
            } else if(wpid < 0){
                exit(1);
            } else {
            }
        }
    }
}

int main()
{
    dev(O_RDWR, CONSOLE, 0);
    dup(0);
    dup(0);
    int fd = open("/busybox_cmd.txt", 0);
    int findnew = 1;
    char buf[1];
    int consitent = 0;
    int argc = 1;
    char *nowarg = arg1;
    int n;
    int intr_num = 1;
    while((n = read(fd, buf, sizeof(buf))) > 0) {
        if (NOWCHAR == '\n') {
            if (!findnew) {
                *nowarg = 0;
                argc++;
            }
            char* argv[6];
            for (int i = 0; i < argc;i++) {
                argv[i] = argwhat[i];
            }
            argv[argc] = 0;
            if (intr_num != 2) {
                test(arg0, argv);
            }
            argc = 1;
            nowarg = argwhat[argc];
            findnew = 1;
            intr_num++;
        } else if (NOWCHAR == ' ') {
            if (!findnew && !consitent) {
                *nowarg = 0;
                argc++;
                nowarg = argwhat[argc];
                findnew = 1;
            }
        } else {
            findnew = 0;
            if (NOWCHAR == '\"') {
                consitent = 1 - consitent;
            }
            *nowarg = NOWCHAR;
            nowarg++;
        }

    }
    printf("end!!");
    while(1);
}




