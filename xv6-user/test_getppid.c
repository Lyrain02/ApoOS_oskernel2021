#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "kernel/include/sysinfo.h"
#include "xv6-user/user.h"


/*
 * 能通过测试则输出：
 * "  getppid success. ppid : [num]"
 * 不能通过测试则输出：
 * "  getppid error."
 */

int test_getppid()
{
    //TEST_START(__func__);
    //printf("1");
    uint64 ppid = getppid();
    if(ppid > 0) printf("  getppid success. ppid : %d\n", ppid);
    else printf("  getppid error.\n");
    //TEST_END(__func__);
    return 0;
}

int main(void) {
	test_getppid();
	return 0;
}
