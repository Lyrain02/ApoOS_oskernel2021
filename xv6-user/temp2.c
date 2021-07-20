#include "kernel/include/types.h"
#include "xv6-user/user.h"
//#include "kernel/include/stat.h"
#include "kernel/include/file.h"
#include "kernel/include/fcntl.h"
void print_success(char **argv);
void test(char *name, char **argv);
void print_success(char **argv)
{
    printf("testcase busybox ");
    for (int i = 1; argv[i]; i++)
        printf("%s ", argv[i]);
    printf("success\n");
}

void test(char *name, char **argv)
{
//    int wpid;
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
                // the shell exited; restart it
                break;
            } else if(wpid < 0){
//                printf("init: wait returned an error\n");
                exit(1);
            } else {
                // it was a parentless process; do nothing.
            }
        }
    }
}
//
//char *echo_args[] = {"/busybox","echo", "\"#### independent command test\"", 0};
//char *ash_args[] = {"/busybox","ash", "-c", "exit", 0};
//char *sh_args[] = {"/busybox","sh", "-c", "exit", 0};
//char *basename_args[] = {"/busybox","basename", "/aaa/bbb", 0};
//char *cal_args[] = {"/busybox","cal", 0};
//char *clear_args[] = {"/busybox","clear", 0};
//char *date_args[] = {"/busybox","date", 0};
//char *df_args[] = {"/busybox","df", 0};
//char *dirname_args[] = {"/busybox","dirname", "/aaa/bbb", 0};
//char *dmesg_args[] = {"/busybox","dmesg", 0};
//char *du_args[] = {"/busybox","du", 0};
//char *expr_args[] = {"/busybox","expr", "1", "+", "1", 0};
//char *false_args[] = {"/busybox","false", 0};
//char *true_args[] = {"/busybox","true", 0};
//char *which_args[] = {"/busybox","which", "ls", 0};
//char *uname_args[] = {"/busybox","uname", 0};
//char *uptime_args[] = {"/busybox","uptime", 0};
//char *printf_args[] = {"/busybox","printf","abc\\n", 0};
//char *ps_args[] = {"/busybox","ps", 0};
//char *pwd_args[] = {"/busybox","pwd", 0};
//char *free_args[] = {"/busybox","free", 0};
//char *hwclock_args[] = {"/busybox","hwclock", 0};
//char *kill_args[] = {"/busybox","kill", "10", 0};
//char *ls_args[] = {"/busybox","ls", 0};
//char *sleep_args[] = {"/busybox","sleep", "1", 0};
//char *echo1_args[] = {"/busybox","echo", "\"#### file operation test\"", 0};
//char *touch_args[] = {"/busybox","touch", "test.txt", 0};
//char *echo2_args[] = {"/busybox","echo", "\"hello world\"", ">", "test.txt", 0};
//char *cat_args[] = {"/busybox", "cat", "test.txt", 0};
//char *cut_args[] = {"/busybox", "-c", "3", "test.txt", 0};
//char *od_args[] = {"/busybox", "od", "test.txt", 0};
//char *head_args[] = {"/busybox", "head", "test.txt", 0};
//char *tail_args[] = {"/busybox", "tail", "test.txt", 0};
//char *hexdump_args[] = {"/busybox", "hexdump", "-C", "test.txt", 0};
//char *md5sum_args[] = {"/busybox", "md5sum", "test.txt", 0};
//char *echo3_args[] = {"/busybox","echo", "\"ccccccc\"", ">>", "test.txt", 0};
//char *echo4_args[] = {"/busybox","echo", "\"bbbbbbb\"", ">>", "test.txt", 0};
//char *echo5_args[] = {"/busybox","echo", "\"aaaaaaa\"", ">>", "test.txt", 0};
//char *echo6_args[] = {"/busybox","echo", "\"2222222\"", ">>", "test.txt", 0};
//char *echo7_args[] = {"/busybox","echo", "\"1111111\"", ">>", "test.txt", 0};
//char *echo8_args[] = {"/busybox","echo", "\"bbbbbbb\"", ">>", "test.txt", 0};
//char *sort_args[] = {"/busybox", "sort", "test.txt", "|", "./busybox", "uniq", 0};
//char *stat_args[] = {"/busybox", "stat", "test.txt", 0};
//char *strings_args[] = {"/busybox", "strings", "test.txt", 0};
//char *wc_args[] = {"/busybox", "wc", "test.txt", 0};
//char *busybox_f_args[] = {"/busybox", "[", "-f", "test.txt", "]", 0};
//char *more_args[] = {"/busybox", "more", "test.txt", 0};
//char *rm_args[] = {"/busybox", "rm", "test.txt", 0};
//char *mkdir_args[] = {"/busybox", "mkdir", "test_dir", 0};
//char *mv_args[] = {"/busybox", "mv", "test_dir", "test", 0};
//char *rmdir_args[] = {"/busybox", "rmdir", "test", 0};
//char *grep_args[] = {"/busybox", "grep", "-hello", "busybox_cmd.txt", 0};
//char *cp_args[] = {"/busybox", "cp", "busybox_cmd.txt", "busybox_cmd.bak", 0};
//char *rm1_args[] = {"/busybox", "rm", "busybox_cmd.bak", 0};
//char *find_args[] = {"/busybox", "find", "-name", "busybox_cmd.txt", 0};
//
//
//char *call_names[] = {"/brk", "/chdir", "/clone", "/close", "/dup",
//                      "/dup2", "/execve", "/exit", "/fork", "/fstat",
//                      "/getcwd", "/getdents", "/getpid", "/getppid", "/gettimeofday",
//                      "/mkdir_", "/mmap", "/mount", "/munmap", "/unlink",
//                      "/open", "/openat", "/pipe", "/read", "/sleep",
//                      "/times", "/umount", "/uname", "/wait", "/waitpid",
//                      "/write", "/yield"};
//char** test_args[57] = {echo_args,ash_args,sh_args,basename_args,cal_args,clear_args,date_args,df_args,dirname_args,dmesg_args,du_args,expr_args,false_args,true_args,which_args,uname_args,uptime_args,printf_args,ps_args,pwd_args,free_args,hwclock_args,kill_args,ls_args,sleep_args,echo1_args,touch_args,echo2_args,cat_args,cut_args,od_args,head_args,tail_args,hexdump_args,md5sum_args,echo3_args,echo4_args,echo5_args,echo6_args,echo7_args,echo8_args,sort_args,stat_args,strings_args,wc_args,busybox_f_args,more_args,rm_args,mkdir_args,mv_args,rmdir_args,grep_args,cp_args,rm1_args,find_args};

char arg0[9] = "/busybox";
char arg1[20],arg2[20],arg3[20],arg4[20],arg5[20];
char* argwhat[6] = {arg0,arg1,arg2,arg3,arg4,arg5};
#define NOWCHAR (*buf)
int main()
{

    dev(O_RDWR, CONSOLE, 0);
    dup(0);  // stdout
    dup(0);  // stderr
    int fd = open("/busybox_cmd.txt", 0);
    int findnew = 1;
    char buf[1];
    int consitent = 0;
    int argc = 1;
    char *nowarg = arg1;
    int n;
    int intr_num = 1;
    while((n = read(fd, buf, sizeof(buf))) > 0) {
//        printf("%s",buf);
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
//    for (int i = 0; i < 57; i++) {
//        test("/busybox", test_args[i]);
//    }
//    test("/busybox", stat_args);
//    test("/busybox", hwclock_args);
//    test("/busybox", cat_args);
//    test("/busybox", wc_args);
//    test("/busybox", sort_args);
//    test("/busybox", head_args);
//    test("/busybox", tail_args);
//    test("/busybox", hexdump_args);
//    test("/busybox", busybox_f_args);
//    test("/busybox", strings_args);
//    test("/busybox", cut_args);
//    test("/busybox", od_args);
//    test("/busybox", ps_args);
//    test("/busybox", df_args);
//    test("/busybox", touch_args);
//    test("/busybox", sleep_args);
//    test("/busybox", echo2_args);
//    test("/busybox", echo1_args);
//    test("/busybox", echo_args);
//    test("/busybox", clear_args);
//    test("/busybox", cal_args);
//    test("/busybox", uname_args);
//    test("/busybox", printf_args);
//    test("/busybox", false_args);
//    test("/busybox", true_args);
//    test("/busybox", date_args);
//    test("/busybox", du_args);
//    test("/busybox", uptime_args);
//    test("/busybox", dmesg_args);
//    test("/busybox", expr_args);
//    test("/busybox", pwd_args);
//    test("/busybox", echo_args);
//    test("/busybox", ash_args);
//    test("/busybox", sh_args);
//    test("/busybox", basename_args);
//    test("/busybox", dirname_args);
//    test("/busybox", which_args);
//    test("/busybox", kill_args);
//    test("/busybox", ls_args);
//    test("/busybox", echo1_args);
//    test("/busybox", echo2_args);
//    test("/busybox", echo3_args);
//    test("/busybox", echo4_args);
//    test("/busybox", echo5_args);
//    test("/busybox", echo6_args);
//    test("/busybox", echo7_args);
//    test("/busybox", echo8_args);
    printf("end!!");

    while(1);
}




