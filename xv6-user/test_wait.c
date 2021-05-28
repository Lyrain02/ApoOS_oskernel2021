#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/sysinfo.h"
#include "xv6-user/user.h"

void test_wait(void){
    //TEST_START(__func__);
    int cpid, wstatus;
    cpid = fork();
    if(cpid == 0){
	printf("This is child process\n");
        exit(0);
    }else{
	//if(cpid == wait(NULL)) printf("wait success.\n");
	//else printf("wait error.\n");

	int ret = wait(&wstatus);
	if(ret == -1){
        exit(0);
    }

	printf("wait child success.\nwstatus: %d\n", wstatus);
    }
    //TEST_END(__func__);
}

int main(void){
    test_wait();
    return 0;
}
