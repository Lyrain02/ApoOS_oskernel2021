#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "xv6-user/user.h"

char buf[512];

void
cat(int fd)
{
    int n;

    while((n = read(fd, buf, sizeof(buf))) > 0) {
        if (write(1, buf, n) != n) {
            fprintf(2, "cat: write error\n");
            exit(1);
        }
    }
    if(n < 0){
        fprintf(2, "cat: read error\n");
        exit(1);
    }
}

int
main(int argc, char *argv[])
{
//    int fd;
//    if((fd = open("./text.txt", 0)) < 0){
//        fprintf(2, "cat: cannot open %s\n", "./text.txt");
//        exit(1);
//    }
//    cat(fd);
//    close(fd);
//    exit(0);

    int fd = open("./text.txt", 0);
    fprintf(2,"fd=%d\n",fd);
    char buf[256];
    int size = read(fd, buf, 256);
    if (size < 0) {
        size = 0;
    }
    write(1, buf, size);
    close(fd);
    exit(0);
}
