#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/sysinfo.h"
#include "xv6-user/user.h"

/*
 * 测试通过时的输出：
 * "sleep success."
 * 测试失败时的输出：
 * "sleep error."
 */
void test_sleep() {
	//TEST_START(__func__);

	int time1 = get_time();
    if(time1<0){
        printf("error");
        exit(0);
    }
	int ret = sleep(1);
    if(ret!=0){
        printf("error");
        exit(0);
    }
	int time2 = get_time();
    if(time2<0){
        printf("error");
        exit(0);
    }
	if(time2 - time1 >= 1){	
		printf("sleep success.\n");
	}else{
		printf("sleep error.\n");
	}
	//TEST_END(__func__);
}

int main(void) {
	test_sleep();
	return 0;
}
