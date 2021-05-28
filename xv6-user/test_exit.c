#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/sysinfo.h"
#include "xv6-user/user.h"
#include <stddef.h>
#include <assert.h>
/*
 * 测试成功则输出：
 * "exit OK."
 * 测试失败则输出：
 * "exit ERR."
 */
void test_exit(void){
    //TEST_START(__func__);
    int cpid;
    cpid = fork();
    //assert(cpid != -1);
    if(cpid==-1){
        exit(0);
    }
    if(cpid == 0){
        exit(0);
    }else{
        printf("%d\n",wait(NULL));
        if(wait(NULL) != cpid) printf("exit OK.\n");
        else printf("exit ERR.\n");
    }
    //TEST_END(__func__);
}

int main(void){
    test_exit();
    return 0;
}
