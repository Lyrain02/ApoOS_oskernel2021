
xv6-user/_test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/types.h"
#include "kernel/include/stat.h"
#include "xv6-user/user.h"

int main()
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	44a9                	li	s1,10
    for (int i = 0; i < 10; i++) {
        if (fork() == 0) {
            printf("printf from %d\n", getpid());
   e:	00001917          	auipc	s2,0x1
  12:	83290913          	addi	s2,s2,-1998 # 840 <malloc+0xea>
  16:	a00d                	j	38 <main+0x38>
  18:	00000097          	auipc	ra,0x0
  1c:	368080e7          	jalr	872(ra) # 380 <getpid>
  20:	85aa                	mv	a1,a0
  22:	854a                	mv	a0,s2
  24:	00000097          	auipc	ra,0x0
  28:	672080e7          	jalr	1650(ra) # 696 <printf>
            // while (1) {
                test_proc();
  2c:	00000097          	auipc	ra,0x0
  30:	374080e7          	jalr	884(ra) # 3a0 <test_proc>
  34:	34fd                	addiw	s1,s1,-1
    for (int i = 0; i < 10; i++) {
  36:	c499                	beqz	s1,44 <main+0x44>
        if (fork() == 0) {
  38:	00000097          	auipc	ra,0x0
  3c:	2c0080e7          	jalr	704(ra) # 2f8 <fork>
  40:	f975                	bnez	a0,34 <main+0x34>
  42:	bfd9                	j	18 <main+0x18>
            // }
        }
    }
    printf("printf from %d\n", getpid());
  44:	00000097          	auipc	ra,0x0
  48:	33c080e7          	jalr	828(ra) # 380 <getpid>
  4c:	85aa                	mv	a1,a0
  4e:	00000517          	auipc	a0,0x0
  52:	7f250513          	addi	a0,a0,2034 # 840 <malloc+0xea>
  56:	00000097          	auipc	ra,0x0
  5a:	640080e7          	jalr	1600(ra) # 696 <printf>
    // while (1) {
        test_proc();
  5e:	00000097          	auipc	ra,0x0
  62:	342080e7          	jalr	834(ra) # 3a0 <test_proc>
    // }

    exit(0);
  66:	4501                	li	a0,0
  68:	00000097          	auipc	ra,0x0
  6c:	298080e7          	jalr	664(ra) # 300 <exit>

0000000000000070 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
  70:	1141                	addi	sp,sp,-16
  72:	e422                	sd	s0,8(sp)
  74:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  76:	87aa                	mv	a5,a0
  78:	0585                	addi	a1,a1,1
  7a:	0785                	addi	a5,a5,1
  7c:	fff5c703          	lbu	a4,-1(a1)
  80:	fee78fa3          	sb	a4,-1(a5)
  84:	fb75                	bnez	a4,78 <strcpy+0x8>
    ;
  return os;
}
  86:	6422                	ld	s0,8(sp)
  88:	0141                	addi	sp,sp,16
  8a:	8082                	ret

000000000000008c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8c:	1141                	addi	sp,sp,-16
  8e:	e422                	sd	s0,8(sp)
  90:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  92:	00054783          	lbu	a5,0(a0)
  96:	cf91                	beqz	a5,b2 <strcmp+0x26>
  98:	0005c703          	lbu	a4,0(a1)
  9c:	00f71b63          	bne	a4,a5,b2 <strcmp+0x26>
    p++, q++;
  a0:	0505                	addi	a0,a0,1
  a2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a4:	00054783          	lbu	a5,0(a0)
  a8:	c789                	beqz	a5,b2 <strcmp+0x26>
  aa:	0005c703          	lbu	a4,0(a1)
  ae:	fef709e3          	beq	a4,a5,a0 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  b2:	0005c503          	lbu	a0,0(a1)
}
  b6:	40a7853b          	subw	a0,a5,a0
  ba:	6422                	ld	s0,8(sp)
  bc:	0141                	addi	sp,sp,16
  be:	8082                	ret

00000000000000c0 <strlen>:

uint
strlen(const char *s)
{
  c0:	1141                	addi	sp,sp,-16
  c2:	e422                	sd	s0,8(sp)
  c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c6:	00054783          	lbu	a5,0(a0)
  ca:	cf91                	beqz	a5,e6 <strlen+0x26>
  cc:	0505                	addi	a0,a0,1
  ce:	87aa                	mv	a5,a0
  d0:	4685                	li	a3,1
  d2:	9e89                	subw	a3,a3,a0
    ;
  d4:	00f6853b          	addw	a0,a3,a5
  d8:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  da:	fff7c703          	lbu	a4,-1(a5)
  de:	fb7d                	bnez	a4,d4 <strlen+0x14>
  return n;
}
  e0:	6422                	ld	s0,8(sp)
  e2:	0141                	addi	sp,sp,16
  e4:	8082                	ret
  for(n = 0; s[n]; n++)
  e6:	4501                	li	a0,0
  e8:	bfe5                	j	e0 <strlen+0x20>

00000000000000ea <memset>:

void*
memset(void *dst, int c, uint n)
{
  ea:	1141                	addi	sp,sp,-16
  ec:	e422                	sd	s0,8(sp)
  ee:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f0:	ce09                	beqz	a2,10a <memset+0x20>
  f2:	87aa                	mv	a5,a0
  f4:	fff6071b          	addiw	a4,a2,-1
  f8:	1702                	slli	a4,a4,0x20
  fa:	9301                	srli	a4,a4,0x20
  fc:	0705                	addi	a4,a4,1
  fe:	972a                	add	a4,a4,a0
    cdst[i] = c;
 100:	00b78023          	sb	a1,0(a5)
 104:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 106:	fee79de3          	bne	a5,a4,100 <memset+0x16>
  }
  return dst;
}
 10a:	6422                	ld	s0,8(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret

0000000000000110 <strchr>:

char*
strchr(const char *s, char c)
{
 110:	1141                	addi	sp,sp,-16
 112:	e422                	sd	s0,8(sp)
 114:	0800                	addi	s0,sp,16
  for(; *s; s++)
 116:	00054783          	lbu	a5,0(a0)
 11a:	cf91                	beqz	a5,136 <strchr+0x26>
    if(*s == c)
 11c:	00f58a63          	beq	a1,a5,130 <strchr+0x20>
  for(; *s; s++)
 120:	0505                	addi	a0,a0,1
 122:	00054783          	lbu	a5,0(a0)
 126:	c781                	beqz	a5,12e <strchr+0x1e>
    if(*s == c)
 128:	feb79ce3          	bne	a5,a1,120 <strchr+0x10>
 12c:	a011                	j	130 <strchr+0x20>
      return (char*)s;
  return 0;
 12e:	4501                	li	a0,0
}
 130:	6422                	ld	s0,8(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret
  return 0;
 136:	4501                	li	a0,0
 138:	bfe5                	j	130 <strchr+0x20>

000000000000013a <gets>:

char*
gets(char *buf, int max)
{
 13a:	711d                	addi	sp,sp,-96
 13c:	ec86                	sd	ra,88(sp)
 13e:	e8a2                	sd	s0,80(sp)
 140:	e4a6                	sd	s1,72(sp)
 142:	e0ca                	sd	s2,64(sp)
 144:	fc4e                	sd	s3,56(sp)
 146:	f852                	sd	s4,48(sp)
 148:	f456                	sd	s5,40(sp)
 14a:	f05a                	sd	s6,32(sp)
 14c:	ec5e                	sd	s7,24(sp)
 14e:	1080                	addi	s0,sp,96
 150:	8baa                	mv	s7,a0
 152:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 154:	892a                	mv	s2,a0
 156:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 158:	4aa9                	li	s5,10
 15a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 15c:	0019849b          	addiw	s1,s3,1
 160:	0344d863          	bge	s1,s4,190 <gets+0x56>
    cc = read(0, &c, 1);
 164:	4605                	li	a2,1
 166:	faf40593          	addi	a1,s0,-81
 16a:	4501                	li	a0,0
 16c:	00000097          	auipc	ra,0x0
 170:	1ac080e7          	jalr	428(ra) # 318 <read>
    if(cc < 1)
 174:	00a05e63          	blez	a0,190 <gets+0x56>
    buf[i++] = c;
 178:	faf44783          	lbu	a5,-81(s0)
 17c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 180:	01578763          	beq	a5,s5,18e <gets+0x54>
 184:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 186:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 188:	fd679ae3          	bne	a5,s6,15c <gets+0x22>
 18c:	a011                	j	190 <gets+0x56>
  for(i=0; i+1 < max; ){
 18e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 190:	99de                	add	s3,s3,s7
 192:	00098023          	sb	zero,0(s3)
  return buf;
}
 196:	855e                	mv	a0,s7
 198:	60e6                	ld	ra,88(sp)
 19a:	6446                	ld	s0,80(sp)
 19c:	64a6                	ld	s1,72(sp)
 19e:	6906                	ld	s2,64(sp)
 1a0:	79e2                	ld	s3,56(sp)
 1a2:	7a42                	ld	s4,48(sp)
 1a4:	7aa2                	ld	s5,40(sp)
 1a6:	7b02                	ld	s6,32(sp)
 1a8:	6be2                	ld	s7,24(sp)
 1aa:	6125                	addi	sp,sp,96
 1ac:	8082                	ret

00000000000001ae <stat>:

int
stat(const char *n, struct stat *st)
{
 1ae:	1101                	addi	sp,sp,-32
 1b0:	ec06                	sd	ra,24(sp)
 1b2:	e822                	sd	s0,16(sp)
 1b4:	e426                	sd	s1,8(sp)
 1b6:	e04a                	sd	s2,0(sp)
 1b8:	1000                	addi	s0,sp,32
 1ba:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1bc:	4581                	li	a1,0
 1be:	00000097          	auipc	ra,0x0
 1c2:	182080e7          	jalr	386(ra) # 340 <open>
  if(fd < 0)
 1c6:	02054563          	bltz	a0,1f0 <stat+0x42>
 1ca:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1cc:	85ca                	mv	a1,s2
 1ce:	00000097          	auipc	ra,0x0
 1d2:	18a080e7          	jalr	394(ra) # 358 <fstat>
 1d6:	892a                	mv	s2,a0
  close(fd);
 1d8:	8526                	mv	a0,s1
 1da:	00000097          	auipc	ra,0x0
 1de:	14e080e7          	jalr	334(ra) # 328 <close>
  return r;
}
 1e2:	854a                	mv	a0,s2
 1e4:	60e2                	ld	ra,24(sp)
 1e6:	6442                	ld	s0,16(sp)
 1e8:	64a2                	ld	s1,8(sp)
 1ea:	6902                	ld	s2,0(sp)
 1ec:	6105                	addi	sp,sp,32
 1ee:	8082                	ret
    return -1;
 1f0:	597d                	li	s2,-1
 1f2:	bfc5                	j	1e2 <stat+0x34>

00000000000001f4 <atoi>:

int
atoi(const char *s)
{
 1f4:	1141                	addi	sp,sp,-16
 1f6:	e422                	sd	s0,8(sp)
 1f8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1fa:	00054683          	lbu	a3,0(a0)
 1fe:	fd06879b          	addiw	a5,a3,-48
 202:	0ff7f793          	andi	a5,a5,255
 206:	4725                	li	a4,9
 208:	02f76963          	bltu	a4,a5,23a <atoi+0x46>
 20c:	862a                	mv	a2,a0
  n = 0;
 20e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 210:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 212:	0605                	addi	a2,a2,1
 214:	0025179b          	slliw	a5,a0,0x2
 218:	9fa9                	addw	a5,a5,a0
 21a:	0017979b          	slliw	a5,a5,0x1
 21e:	9fb5                	addw	a5,a5,a3
 220:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 224:	00064683          	lbu	a3,0(a2)
 228:	fd06871b          	addiw	a4,a3,-48
 22c:	0ff77713          	andi	a4,a4,255
 230:	fee5f1e3          	bgeu	a1,a4,212 <atoi+0x1e>
  return n;
}
 234:	6422                	ld	s0,8(sp)
 236:	0141                	addi	sp,sp,16
 238:	8082                	ret
  n = 0;
 23a:	4501                	li	a0,0
 23c:	bfe5                	j	234 <atoi+0x40>

000000000000023e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 244:	02b57663          	bgeu	a0,a1,270 <memmove+0x32>
    while(n-- > 0)
 248:	02c05163          	blez	a2,26a <memmove+0x2c>
 24c:	fff6079b          	addiw	a5,a2,-1
 250:	1782                	slli	a5,a5,0x20
 252:	9381                	srli	a5,a5,0x20
 254:	0785                	addi	a5,a5,1
 256:	97aa                	add	a5,a5,a0
  dst = vdst;
 258:	872a                	mv	a4,a0
      *dst++ = *src++;
 25a:	0585                	addi	a1,a1,1
 25c:	0705                	addi	a4,a4,1
 25e:	fff5c683          	lbu	a3,-1(a1)
 262:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 266:	fee79ae3          	bne	a5,a4,25a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 26a:	6422                	ld	s0,8(sp)
 26c:	0141                	addi	sp,sp,16
 26e:	8082                	ret
    dst += n;
 270:	00c50733          	add	a4,a0,a2
    src += n;
 274:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 276:	fec05ae3          	blez	a2,26a <memmove+0x2c>
 27a:	fff6079b          	addiw	a5,a2,-1
 27e:	1782                	slli	a5,a5,0x20
 280:	9381                	srli	a5,a5,0x20
 282:	fff7c793          	not	a5,a5
 286:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 288:	15fd                	addi	a1,a1,-1
 28a:	177d                	addi	a4,a4,-1
 28c:	0005c683          	lbu	a3,0(a1)
 290:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 294:	fef71ae3          	bne	a4,a5,288 <memmove+0x4a>
 298:	bfc9                	j	26a <memmove+0x2c>

000000000000029a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a0:	ce15                	beqz	a2,2dc <memcmp+0x42>
 2a2:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 2a6:	00054783          	lbu	a5,0(a0)
 2aa:	0005c703          	lbu	a4,0(a1)
 2ae:	02e79063          	bne	a5,a4,2ce <memcmp+0x34>
 2b2:	1682                	slli	a3,a3,0x20
 2b4:	9281                	srli	a3,a3,0x20
 2b6:	0685                	addi	a3,a3,1
 2b8:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 2ba:	0505                	addi	a0,a0,1
    p2++;
 2bc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2be:	00d50d63          	beq	a0,a3,2d8 <memcmp+0x3e>
    if (*p1 != *p2) {
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	0005c703          	lbu	a4,0(a1)
 2ca:	fee788e3          	beq	a5,a4,2ba <memcmp+0x20>
      return *p1 - *p2;
 2ce:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 2d2:	6422                	ld	s0,8(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret
  return 0;
 2d8:	4501                	li	a0,0
 2da:	bfe5                	j	2d2 <memcmp+0x38>
 2dc:	4501                	li	a0,0
 2de:	bfd5                	j	2d2 <memcmp+0x38>

00000000000002e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e406                	sd	ra,8(sp)
 2e4:	e022                	sd	s0,0(sp)
 2e6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2e8:	00000097          	auipc	ra,0x0
 2ec:	f56080e7          	jalr	-170(ra) # 23e <memmove>
}
 2f0:	60a2                	ld	ra,8(sp)
 2f2:	6402                	ld	s0,0(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret

00000000000002f8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2f8:	4885                	li	a7,1
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <exit>:
.global exit
exit:
 li a7, SYS_exit
 300:	4889                	li	a7,2
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <wait>:
.global wait
wait:
 li a7, SYS_wait
 308:	488d                	li	a7,3
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 310:	4891                	li	a7,4
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <read>:
.global read
read:
 li a7, SYS_read
 318:	4895                	li	a7,5
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <write>:
.global write
write:
 li a7, SYS_write
 320:	48c1                	li	a7,16
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <close>:
.global close
close:
 li a7, SYS_close
 328:	48d5                	li	a7,21
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <kill>:
.global kill
kill:
 li a7, SYS_kill
 330:	4899                	li	a7,6
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <exec>:
.global exec
exec:
 li a7, SYS_exec
 338:	489d                	li	a7,7
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <open>:
.global open
open:
 li a7, SYS_open
 340:	48bd                	li	a7,15
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 348:	48c5                	li	a7,17
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 350:	48c9                	li	a7,18
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 358:	48a1                	li	a7,8
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <link>:
.global link
link:
 li a7, SYS_link
 360:	48cd                	li	a7,19
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 368:	48d1                	li	a7,20
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 370:	48a5                	li	a7,9
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <dup>:
.global dup
dup:
 li a7, SYS_dup
 378:	48a9                	li	a7,10
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 380:	48ad                	li	a7,11
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 388:	48b1                	li	a7,12
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 390:	48b5                	li	a7,13
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 398:	48b9                	li	a7,14
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3a0:	48d9                	li	a7,22
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <dev>:
.global dev
dev:
 li a7, SYS_dev
 3a8:	48dd                	li	a7,23
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <dir>:
.global dir
dir:
 li a7, SYS_dir
 3b0:	48e1                	li	a7,24
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3b8:	48e5                	li	a7,25
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3c0:	1101                	addi	sp,sp,-32
 3c2:	ec06                	sd	ra,24(sp)
 3c4:	e822                	sd	s0,16(sp)
 3c6:	1000                	addi	s0,sp,32
 3c8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3cc:	4605                	li	a2,1
 3ce:	fef40593          	addi	a1,s0,-17
 3d2:	00000097          	auipc	ra,0x0
 3d6:	f4e080e7          	jalr	-178(ra) # 320 <write>
}
 3da:	60e2                	ld	ra,24(sp)
 3dc:	6442                	ld	s0,16(sp)
 3de:	6105                	addi	sp,sp,32
 3e0:	8082                	ret

00000000000003e2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e2:	7139                	addi	sp,sp,-64
 3e4:	fc06                	sd	ra,56(sp)
 3e6:	f822                	sd	s0,48(sp)
 3e8:	f426                	sd	s1,40(sp)
 3ea:	f04a                	sd	s2,32(sp)
 3ec:	ec4e                	sd	s3,24(sp)
 3ee:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3f0:	c299                	beqz	a3,3f6 <printint+0x14>
 3f2:	0005cd63          	bltz	a1,40c <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3f6:	2581                	sext.w	a1,a1
  neg = 0;
 3f8:	4301                	li	t1,0
 3fa:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 3fe:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 400:	2601                	sext.w	a2,a2
 402:	00000897          	auipc	a7,0x0
 406:	44e88893          	addi	a7,a7,1102 # 850 <digits>
 40a:	a039                	j	418 <printint+0x36>
    x = -xx;
 40c:	40b005bb          	negw	a1,a1
    neg = 1;
 410:	4305                	li	t1,1
    x = -xx;
 412:	b7e5                	j	3fa <printint+0x18>
  }while((x /= base) != 0);
 414:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 416:	8836                	mv	a6,a3
 418:	0018069b          	addiw	a3,a6,1
 41c:	02c5f7bb          	remuw	a5,a1,a2
 420:	1782                	slli	a5,a5,0x20
 422:	9381                	srli	a5,a5,0x20
 424:	97c6                	add	a5,a5,a7
 426:	0007c783          	lbu	a5,0(a5)
 42a:	00f70023          	sb	a5,0(a4)
 42e:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 430:	02c5d7bb          	divuw	a5,a1,a2
 434:	fec5f0e3          	bgeu	a1,a2,414 <printint+0x32>
  if(neg)
 438:	00030b63          	beqz	t1,44e <printint+0x6c>
    buf[i++] = '-';
 43c:	fd040793          	addi	a5,s0,-48
 440:	96be                	add	a3,a3,a5
 442:	02d00793          	li	a5,45
 446:	fef68823          	sb	a5,-16(a3)
 44a:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 44e:	02d05963          	blez	a3,480 <printint+0x9e>
 452:	89aa                	mv	s3,a0
 454:	fc040793          	addi	a5,s0,-64
 458:	00d784b3          	add	s1,a5,a3
 45c:	fff78913          	addi	s2,a5,-1
 460:	9936                	add	s2,s2,a3
 462:	36fd                	addiw	a3,a3,-1
 464:	1682                	slli	a3,a3,0x20
 466:	9281                	srli	a3,a3,0x20
 468:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 46c:	fff4c583          	lbu	a1,-1(s1)
 470:	854e                	mv	a0,s3
 472:	00000097          	auipc	ra,0x0
 476:	f4e080e7          	jalr	-178(ra) # 3c0 <putc>
 47a:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 47c:	ff2498e3          	bne	s1,s2,46c <printint+0x8a>
}
 480:	70e2                	ld	ra,56(sp)
 482:	7442                	ld	s0,48(sp)
 484:	74a2                	ld	s1,40(sp)
 486:	7902                	ld	s2,32(sp)
 488:	69e2                	ld	s3,24(sp)
 48a:	6121                	addi	sp,sp,64
 48c:	8082                	ret

000000000000048e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 48e:	7119                	addi	sp,sp,-128
 490:	fc86                	sd	ra,120(sp)
 492:	f8a2                	sd	s0,112(sp)
 494:	f4a6                	sd	s1,104(sp)
 496:	f0ca                	sd	s2,96(sp)
 498:	ecce                	sd	s3,88(sp)
 49a:	e8d2                	sd	s4,80(sp)
 49c:	e4d6                	sd	s5,72(sp)
 49e:	e0da                	sd	s6,64(sp)
 4a0:	fc5e                	sd	s7,56(sp)
 4a2:	f862                	sd	s8,48(sp)
 4a4:	f466                	sd	s9,40(sp)
 4a6:	f06a                	sd	s10,32(sp)
 4a8:	ec6e                	sd	s11,24(sp)
 4aa:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4ac:	0005c483          	lbu	s1,0(a1)
 4b0:	18048d63          	beqz	s1,64a <vprintf+0x1bc>
 4b4:	8aaa                	mv	s5,a0
 4b6:	8b32                	mv	s6,a2
 4b8:	00158913          	addi	s2,a1,1
  state = 0;
 4bc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4be:	02500a13          	li	s4,37
      if(c == 'd'){
 4c2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4c6:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4ca:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4ce:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4d2:	00000b97          	auipc	s7,0x0
 4d6:	37eb8b93          	addi	s7,s7,894 # 850 <digits>
 4da:	a839                	j	4f8 <vprintf+0x6a>
        putc(fd, c);
 4dc:	85a6                	mv	a1,s1
 4de:	8556                	mv	a0,s5
 4e0:	00000097          	auipc	ra,0x0
 4e4:	ee0080e7          	jalr	-288(ra) # 3c0 <putc>
 4e8:	a019                	j	4ee <vprintf+0x60>
    } else if(state == '%'){
 4ea:	01498f63          	beq	s3,s4,508 <vprintf+0x7a>
 4ee:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 4f0:	fff94483          	lbu	s1,-1(s2)
 4f4:	14048b63          	beqz	s1,64a <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 4f8:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4fc:	fe0997e3          	bnez	s3,4ea <vprintf+0x5c>
      if(c == '%'){
 500:	fd479ee3          	bne	a5,s4,4dc <vprintf+0x4e>
        state = '%';
 504:	89be                	mv	s3,a5
 506:	b7e5                	j	4ee <vprintf+0x60>
      if(c == 'd'){
 508:	05878063          	beq	a5,s8,548 <vprintf+0xba>
      } else if(c == 'l') {
 50c:	05978c63          	beq	a5,s9,564 <vprintf+0xd6>
      } else if(c == 'x') {
 510:	07a78863          	beq	a5,s10,580 <vprintf+0xf2>
      } else if(c == 'p') {
 514:	09b78463          	beq	a5,s11,59c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 518:	07300713          	li	a4,115
 51c:	0ce78563          	beq	a5,a4,5e6 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 520:	06300713          	li	a4,99
 524:	0ee78c63          	beq	a5,a4,61c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 528:	11478663          	beq	a5,s4,634 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 52c:	85d2                	mv	a1,s4
 52e:	8556                	mv	a0,s5
 530:	00000097          	auipc	ra,0x0
 534:	e90080e7          	jalr	-368(ra) # 3c0 <putc>
        putc(fd, c);
 538:	85a6                	mv	a1,s1
 53a:	8556                	mv	a0,s5
 53c:	00000097          	auipc	ra,0x0
 540:	e84080e7          	jalr	-380(ra) # 3c0 <putc>
      }
      state = 0;
 544:	4981                	li	s3,0
 546:	b765                	j	4ee <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 548:	008b0493          	addi	s1,s6,8
 54c:	4685                	li	a3,1
 54e:	4629                	li	a2,10
 550:	000b2583          	lw	a1,0(s6)
 554:	8556                	mv	a0,s5
 556:	00000097          	auipc	ra,0x0
 55a:	e8c080e7          	jalr	-372(ra) # 3e2 <printint>
 55e:	8b26                	mv	s6,s1
      state = 0;
 560:	4981                	li	s3,0
 562:	b771                	j	4ee <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 564:	008b0493          	addi	s1,s6,8
 568:	4681                	li	a3,0
 56a:	4629                	li	a2,10
 56c:	000b2583          	lw	a1,0(s6)
 570:	8556                	mv	a0,s5
 572:	00000097          	auipc	ra,0x0
 576:	e70080e7          	jalr	-400(ra) # 3e2 <printint>
 57a:	8b26                	mv	s6,s1
      state = 0;
 57c:	4981                	li	s3,0
 57e:	bf85                	j	4ee <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 580:	008b0493          	addi	s1,s6,8
 584:	4681                	li	a3,0
 586:	4641                	li	a2,16
 588:	000b2583          	lw	a1,0(s6)
 58c:	8556                	mv	a0,s5
 58e:	00000097          	auipc	ra,0x0
 592:	e54080e7          	jalr	-428(ra) # 3e2 <printint>
 596:	8b26                	mv	s6,s1
      state = 0;
 598:	4981                	li	s3,0
 59a:	bf91                	j	4ee <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 59c:	008b0793          	addi	a5,s6,8
 5a0:	f8f43423          	sd	a5,-120(s0)
 5a4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5a8:	03000593          	li	a1,48
 5ac:	8556                	mv	a0,s5
 5ae:	00000097          	auipc	ra,0x0
 5b2:	e12080e7          	jalr	-494(ra) # 3c0 <putc>
  putc(fd, 'x');
 5b6:	85ea                	mv	a1,s10
 5b8:	8556                	mv	a0,s5
 5ba:	00000097          	auipc	ra,0x0
 5be:	e06080e7          	jalr	-506(ra) # 3c0 <putc>
 5c2:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5c4:	03c9d793          	srli	a5,s3,0x3c
 5c8:	97de                	add	a5,a5,s7
 5ca:	0007c583          	lbu	a1,0(a5)
 5ce:	8556                	mv	a0,s5
 5d0:	00000097          	auipc	ra,0x0
 5d4:	df0080e7          	jalr	-528(ra) # 3c0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5d8:	0992                	slli	s3,s3,0x4
 5da:	34fd                	addiw	s1,s1,-1
 5dc:	f4e5                	bnez	s1,5c4 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5de:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5e2:	4981                	li	s3,0
 5e4:	b729                	j	4ee <vprintf+0x60>
        s = va_arg(ap, char*);
 5e6:	008b0993          	addi	s3,s6,8
 5ea:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 5ee:	c085                	beqz	s1,60e <vprintf+0x180>
        while(*s != 0){
 5f0:	0004c583          	lbu	a1,0(s1)
 5f4:	c9a1                	beqz	a1,644 <vprintf+0x1b6>
          putc(fd, *s);
 5f6:	8556                	mv	a0,s5
 5f8:	00000097          	auipc	ra,0x0
 5fc:	dc8080e7          	jalr	-568(ra) # 3c0 <putc>
          s++;
 600:	0485                	addi	s1,s1,1
        while(*s != 0){
 602:	0004c583          	lbu	a1,0(s1)
 606:	f9e5                	bnez	a1,5f6 <vprintf+0x168>
        s = va_arg(ap, char*);
 608:	8b4e                	mv	s6,s3
      state = 0;
 60a:	4981                	li	s3,0
 60c:	b5cd                	j	4ee <vprintf+0x60>
          s = "(null)";
 60e:	00000497          	auipc	s1,0x0
 612:	25a48493          	addi	s1,s1,602 # 868 <digits+0x18>
        while(*s != 0){
 616:	02800593          	li	a1,40
 61a:	bff1                	j	5f6 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 61c:	008b0493          	addi	s1,s6,8
 620:	000b4583          	lbu	a1,0(s6)
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	d9a080e7          	jalr	-614(ra) # 3c0 <putc>
 62e:	8b26                	mv	s6,s1
      state = 0;
 630:	4981                	li	s3,0
 632:	bd75                	j	4ee <vprintf+0x60>
        putc(fd, c);
 634:	85d2                	mv	a1,s4
 636:	8556                	mv	a0,s5
 638:	00000097          	auipc	ra,0x0
 63c:	d88080e7          	jalr	-632(ra) # 3c0 <putc>
      state = 0;
 640:	4981                	li	s3,0
 642:	b575                	j	4ee <vprintf+0x60>
        s = va_arg(ap, char*);
 644:	8b4e                	mv	s6,s3
      state = 0;
 646:	4981                	li	s3,0
 648:	b55d                	j	4ee <vprintf+0x60>
    }
  }
}
 64a:	70e6                	ld	ra,120(sp)
 64c:	7446                	ld	s0,112(sp)
 64e:	74a6                	ld	s1,104(sp)
 650:	7906                	ld	s2,96(sp)
 652:	69e6                	ld	s3,88(sp)
 654:	6a46                	ld	s4,80(sp)
 656:	6aa6                	ld	s5,72(sp)
 658:	6b06                	ld	s6,64(sp)
 65a:	7be2                	ld	s7,56(sp)
 65c:	7c42                	ld	s8,48(sp)
 65e:	7ca2                	ld	s9,40(sp)
 660:	7d02                	ld	s10,32(sp)
 662:	6de2                	ld	s11,24(sp)
 664:	6109                	addi	sp,sp,128
 666:	8082                	ret

0000000000000668 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 668:	715d                	addi	sp,sp,-80
 66a:	ec06                	sd	ra,24(sp)
 66c:	e822                	sd	s0,16(sp)
 66e:	1000                	addi	s0,sp,32
 670:	e010                	sd	a2,0(s0)
 672:	e414                	sd	a3,8(s0)
 674:	e818                	sd	a4,16(s0)
 676:	ec1c                	sd	a5,24(s0)
 678:	03043023          	sd	a6,32(s0)
 67c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 680:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 684:	8622                	mv	a2,s0
 686:	00000097          	auipc	ra,0x0
 68a:	e08080e7          	jalr	-504(ra) # 48e <vprintf>
}
 68e:	60e2                	ld	ra,24(sp)
 690:	6442                	ld	s0,16(sp)
 692:	6161                	addi	sp,sp,80
 694:	8082                	ret

0000000000000696 <printf>:

void
printf(const char *fmt, ...)
{
 696:	711d                	addi	sp,sp,-96
 698:	ec06                	sd	ra,24(sp)
 69a:	e822                	sd	s0,16(sp)
 69c:	1000                	addi	s0,sp,32
 69e:	e40c                	sd	a1,8(s0)
 6a0:	e810                	sd	a2,16(s0)
 6a2:	ec14                	sd	a3,24(s0)
 6a4:	f018                	sd	a4,32(s0)
 6a6:	f41c                	sd	a5,40(s0)
 6a8:	03043823          	sd	a6,48(s0)
 6ac:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6b0:	00840613          	addi	a2,s0,8
 6b4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6b8:	85aa                	mv	a1,a0
 6ba:	4505                	li	a0,1
 6bc:	00000097          	auipc	ra,0x0
 6c0:	dd2080e7          	jalr	-558(ra) # 48e <vprintf>
}
 6c4:	60e2                	ld	ra,24(sp)
 6c6:	6442                	ld	s0,16(sp)
 6c8:	6125                	addi	sp,sp,96
 6ca:	8082                	ret

00000000000006cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6cc:	1141                	addi	sp,sp,-16
 6ce:	e422                	sd	s0,8(sp)
 6d0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6d2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d6:	00000797          	auipc	a5,0x0
 6da:	19a78793          	addi	a5,a5,410 # 870 <__DATA_BEGIN__>
 6de:	639c                	ld	a5,0(a5)
 6e0:	a805                	j	710 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6e2:	4618                	lw	a4,8(a2)
 6e4:	9db9                	addw	a1,a1,a4
 6e6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ea:	6398                	ld	a4,0(a5)
 6ec:	6318                	ld	a4,0(a4)
 6ee:	fee53823          	sd	a4,-16(a0)
 6f2:	a091                	j	736 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6f4:	ff852703          	lw	a4,-8(a0)
 6f8:	9e39                	addw	a2,a2,a4
 6fa:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6fc:	ff053703          	ld	a4,-16(a0)
 700:	e398                	sd	a4,0(a5)
 702:	a099                	j	748 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 704:	6398                	ld	a4,0(a5)
 706:	00e7e463          	bltu	a5,a4,70e <free+0x42>
 70a:	00e6ea63          	bltu	a3,a4,71e <free+0x52>
{
 70e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 710:	fed7fae3          	bgeu	a5,a3,704 <free+0x38>
 714:	6398                	ld	a4,0(a5)
 716:	00e6e463          	bltu	a3,a4,71e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71a:	fee7eae3          	bltu	a5,a4,70e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 71e:	ff852583          	lw	a1,-8(a0)
 722:	6390                	ld	a2,0(a5)
 724:	02059713          	slli	a4,a1,0x20
 728:	9301                	srli	a4,a4,0x20
 72a:	0712                	slli	a4,a4,0x4
 72c:	9736                	add	a4,a4,a3
 72e:	fae60ae3          	beq	a2,a4,6e2 <free+0x16>
    bp->s.ptr = p->s.ptr;
 732:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 736:	4790                	lw	a2,8(a5)
 738:	02061713          	slli	a4,a2,0x20
 73c:	9301                	srli	a4,a4,0x20
 73e:	0712                	slli	a4,a4,0x4
 740:	973e                	add	a4,a4,a5
 742:	fae689e3          	beq	a3,a4,6f4 <free+0x28>
  } else
    p->s.ptr = bp;
 746:	e394                	sd	a3,0(a5)
  freep = p;
 748:	00000717          	auipc	a4,0x0
 74c:	12f73423          	sd	a5,296(a4) # 870 <__DATA_BEGIN__>
}
 750:	6422                	ld	s0,8(sp)
 752:	0141                	addi	sp,sp,16
 754:	8082                	ret

0000000000000756 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 756:	7139                	addi	sp,sp,-64
 758:	fc06                	sd	ra,56(sp)
 75a:	f822                	sd	s0,48(sp)
 75c:	f426                	sd	s1,40(sp)
 75e:	f04a                	sd	s2,32(sp)
 760:	ec4e                	sd	s3,24(sp)
 762:	e852                	sd	s4,16(sp)
 764:	e456                	sd	s5,8(sp)
 766:	e05a                	sd	s6,0(sp)
 768:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 76a:	02051993          	slli	s3,a0,0x20
 76e:	0209d993          	srli	s3,s3,0x20
 772:	09bd                	addi	s3,s3,15
 774:	0049d993          	srli	s3,s3,0x4
 778:	2985                	addiw	s3,s3,1
 77a:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 77e:	00000797          	auipc	a5,0x0
 782:	0f278793          	addi	a5,a5,242 # 870 <__DATA_BEGIN__>
 786:	6388                	ld	a0,0(a5)
 788:	c515                	beqz	a0,7b4 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 78a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 78c:	4798                	lw	a4,8(a5)
 78e:	03277f63          	bgeu	a4,s2,7cc <malloc+0x76>
 792:	8a4e                	mv	s4,s3
 794:	0009871b          	sext.w	a4,s3
 798:	6685                	lui	a3,0x1
 79a:	00d77363          	bgeu	a4,a3,7a0 <malloc+0x4a>
 79e:	6a05                	lui	s4,0x1
 7a0:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 7a4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a8:	00000497          	auipc	s1,0x0
 7ac:	0c848493          	addi	s1,s1,200 # 870 <__DATA_BEGIN__>
  if(p == (char*)-1)
 7b0:	5b7d                	li	s6,-1
 7b2:	a885                	j	822 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7b4:	00000797          	auipc	a5,0x0
 7b8:	0c478793          	addi	a5,a5,196 # 878 <base>
 7bc:	00000717          	auipc	a4,0x0
 7c0:	0af73a23          	sd	a5,180(a4) # 870 <__DATA_BEGIN__>
 7c4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7c6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7ca:	b7e1                	j	792 <malloc+0x3c>
      if(p->s.size == nunits)
 7cc:	02e90b63          	beq	s2,a4,802 <malloc+0xac>
        p->s.size -= nunits;
 7d0:	4137073b          	subw	a4,a4,s3
 7d4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7d6:	1702                	slli	a4,a4,0x20
 7d8:	9301                	srli	a4,a4,0x20
 7da:	0712                	slli	a4,a4,0x4
 7dc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7de:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7e2:	00000717          	auipc	a4,0x0
 7e6:	08a73723          	sd	a0,142(a4) # 870 <__DATA_BEGIN__>
      return (void*)(p + 1);
 7ea:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7ee:	70e2                	ld	ra,56(sp)
 7f0:	7442                	ld	s0,48(sp)
 7f2:	74a2                	ld	s1,40(sp)
 7f4:	7902                	ld	s2,32(sp)
 7f6:	69e2                	ld	s3,24(sp)
 7f8:	6a42                	ld	s4,16(sp)
 7fa:	6aa2                	ld	s5,8(sp)
 7fc:	6b02                	ld	s6,0(sp)
 7fe:	6121                	addi	sp,sp,64
 800:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 802:	6398                	ld	a4,0(a5)
 804:	e118                	sd	a4,0(a0)
 806:	bff1                	j	7e2 <malloc+0x8c>
  hp->s.size = nu;
 808:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 80c:	0541                	addi	a0,a0,16
 80e:	00000097          	auipc	ra,0x0
 812:	ebe080e7          	jalr	-322(ra) # 6cc <free>
  return freep;
 816:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 818:	d979                	beqz	a0,7ee <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 81c:	4798                	lw	a4,8(a5)
 81e:	fb2777e3          	bgeu	a4,s2,7cc <malloc+0x76>
    if(p == freep)
 822:	6098                	ld	a4,0(s1)
 824:	853e                	mv	a0,a5
 826:	fef71ae3          	bne	a4,a5,81a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 82a:	8552                	mv	a0,s4
 82c:	00000097          	auipc	ra,0x0
 830:	b5c080e7          	jalr	-1188(ra) # 388 <sbrk>
  if(p == (char*)-1)
 834:	fd651ae3          	bne	a0,s6,808 <malloc+0xb2>
        return 0;
 838:	4501                	li	a0,0
 83a:	bf55                	j	7ee <malloc+0x98>
