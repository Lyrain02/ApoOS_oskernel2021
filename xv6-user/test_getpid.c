#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/sysinfo.h"
#include "xv6-user/user.h"

/*
理想结果：得到进程 pid，注意要关注 pid 是否符合内核逻辑，不要单纯以 Test OK! 作为判断。
*/

int test_getpid()
{
    //TEST_START(__func__);
    int pid = getpid();
    if(pid < 0){
        exit(0);
    }
    printf("getpid success.\npid = %d\n", pid);
    //exit(0);
    return 0;
    //TEST_END(__func__);
}

int main(void) {
	//test_getpid();
    //printf("....\n");
    exit(0);
	return 0;
}


