#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/sysinfo.h"
#include "xv6-user/user.h"
/*
 * 测试成功则输出：
 * "  I am test_echo."
 * 测试失败则输出：
 * "  execve error."
 */
void test_execve(void){
    //TEST_START(__func__);
    char *newargv[] = {NULL, NULL};
    char *newenviron[] = {NULL};
    execve(*newargv, newenviron);
    printf("  execve error.\n");
    //TEST_END(__func__);
}

int main(void){
    test_execve();
    return 0;
}
