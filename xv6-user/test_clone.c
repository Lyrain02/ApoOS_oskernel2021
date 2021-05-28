#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/sysinfo.h"
#include "xv6-user/user.h"
#include <stddef.h>
#include <assert.h>
size_t stack[1024] = {0};
static int child_pid;

static int child_func(void){
    printf("  Child says successfully!\n");
    return 0;
}

void test_clone(void){
    //TEST_START(__func__);
    int wstatus;
    printf("ok1");
    child_pid =  clone(child_func, NULL, stack, 1024, 17);
    //assert(child_pid != -1);
    printf("ok2");
    if(child_pid==-1)
    {
        printf("error\n");
        exit(0);
    }
    if (child_pid == 0){
	    printf("child pid = %d", child_pid);
    }else{
	    wait(&wstatus);
	    printf("clone process successfully.\npid:%d\n", child_pid);
    }

    //TEST_END(__func__);
}

int main(void){
    printf("ok");
    test_clone();
    return 0;
}
