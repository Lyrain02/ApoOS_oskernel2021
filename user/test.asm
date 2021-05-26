
xv6-user/_test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/stat.h"
#include "kernel/include/sysinfo.h"
#include "xv6-user/user.h"

int main()
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
    struct sysinfo info;
    if (sysinfo(&info) < 0) {
   8:	fe040513          	addi	a0,s0,-32
   c:	00000097          	auipc	ra,0x0
  10:	3c2080e7          	jalr	962(ra) # 3ce <sysinfo>
  14:	02054c63          	bltz	a0,4c <main+0x4c>
        printf("sysinfo fail!\n");
    } else {
        printf("memory left: %d KB\n", info.freemem >> 10);
  18:	fe043583          	ld	a1,-32(s0)
  1c:	81a9                	srli	a1,a1,0xa
  1e:	00001517          	auipc	a0,0x1
  22:	85250513          	addi	a0,a0,-1966 # 870 <malloc+0xfe>
  26:	00000097          	auipc	ra,0x0
  2a:	68e080e7          	jalr	1678(ra) # 6b4 <printf>
        printf("process amount: %d\n", info.nproc);
  2e:	fe843583          	ld	a1,-24(s0)
  32:	00001517          	auipc	a0,0x1
  36:	85650513          	addi	a0,a0,-1962 # 888 <malloc+0x116>
  3a:	00000097          	auipc	ra,0x0
  3e:	67a080e7          	jalr	1658(ra) # 6b4 <printf>
    }
    exit(0);
  42:	4501                	li	a0,0
  44:	00000097          	auipc	ra,0x0
  48:	2d2080e7          	jalr	722(ra) # 316 <exit>
        printf("sysinfo fail!\n");
  4c:	00001517          	auipc	a0,0x1
  50:	81450513          	addi	a0,a0,-2028 # 860 <malloc+0xee>
  54:	00000097          	auipc	ra,0x0
  58:	660080e7          	jalr	1632(ra) # 6b4 <printf>
  5c:	b7dd                	j	42 <main+0x42>

000000000000005e <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
  5e:	1141                	addi	sp,sp,-16
  60:	e422                	sd	s0,8(sp)
  62:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  64:	87aa                	mv	a5,a0
  66:	0585                	addi	a1,a1,1
  68:	0785                	addi	a5,a5,1
  6a:	fff5c703          	lbu	a4,-1(a1)
  6e:	fee78fa3          	sb	a4,-1(a5)
  72:	fb75                	bnez	a4,66 <strcpy+0x8>
    ;
  return os;
}
  74:	6422                	ld	s0,8(sp)
  76:	0141                	addi	sp,sp,16
  78:	8082                	ret

000000000000007a <strcat>:

char*
strcat(char *s, const char *t)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  80:	00054783          	lbu	a5,0(a0)
  84:	c385                	beqz	a5,a4 <strcat+0x2a>
  86:	87aa                	mv	a5,a0
    s++;
  88:	0785                	addi	a5,a5,1
  while(*s)
  8a:	0007c703          	lbu	a4,0(a5)
  8e:	ff6d                	bnez	a4,88 <strcat+0xe>
  while((*s++ = *t++))
  90:	0585                	addi	a1,a1,1
  92:	0785                	addi	a5,a5,1
  94:	fff5c703          	lbu	a4,-1(a1)
  98:	fee78fa3          	sb	a4,-1(a5)
  9c:	fb75                	bnez	a4,90 <strcat+0x16>
    ;
  return os;
}
  9e:	6422                	ld	s0,8(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret
  while(*s)
  a4:	87aa                	mv	a5,a0
  a6:	b7ed                	j	90 <strcat+0x16>

00000000000000a8 <strcmp>:


int
strcmp(const char *p, const char *q)
{
  a8:	1141                	addi	sp,sp,-16
  aa:	e422                	sd	s0,8(sp)
  ac:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	cb91                	beqz	a5,c6 <strcmp+0x1e>
  b4:	0005c703          	lbu	a4,0(a1)
  b8:	00f71763          	bne	a4,a5,c6 <strcmp+0x1e>
    p++, q++;
  bc:	0505                	addi	a0,a0,1
  be:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	fbe5                	bnez	a5,b4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  c6:	0005c503          	lbu	a0,0(a1)
}
  ca:	40a7853b          	subw	a0,a5,a0
  ce:	6422                	ld	s0,8(sp)
  d0:	0141                	addi	sp,sp,16
  d2:	8082                	ret

00000000000000d4 <strlen>:

uint
strlen(const char *s)
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  da:	00054783          	lbu	a5,0(a0)
  de:	cf91                	beqz	a5,fa <strlen+0x26>
  e0:	0505                	addi	a0,a0,1
  e2:	87aa                	mv	a5,a0
  e4:	4685                	li	a3,1
  e6:	9e89                	subw	a3,a3,a0
  e8:	00f6853b          	addw	a0,a3,a5
  ec:	0785                	addi	a5,a5,1
  ee:	fff7c703          	lbu	a4,-1(a5)
  f2:	fb7d                	bnez	a4,e8 <strlen+0x14>
    ;
  return n;
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret
  for(n = 0; s[n]; n++)
  fa:	4501                	li	a0,0
  fc:	bfe5                	j	f4 <strlen+0x20>

00000000000000fe <memset>:

void*
memset(void *dst, int c, uint n)
{
  fe:	1141                	addi	sp,sp,-16
 100:	e422                	sd	s0,8(sp)
 102:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 104:	ca19                	beqz	a2,11a <memset+0x1c>
 106:	87aa                	mv	a5,a0
 108:	1602                	slli	a2,a2,0x20
 10a:	9201                	srli	a2,a2,0x20
 10c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 110:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 114:	0785                	addi	a5,a5,1
 116:	fee79de3          	bne	a5,a4,110 <memset+0x12>
  }
  return dst;
}
 11a:	6422                	ld	s0,8(sp)
 11c:	0141                	addi	sp,sp,16
 11e:	8082                	ret

0000000000000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	1141                	addi	sp,sp,-16
 122:	e422                	sd	s0,8(sp)
 124:	0800                	addi	s0,sp,16
  for(; *s; s++)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cb99                	beqz	a5,140 <strchr+0x20>
    if(*s == c)
 12c:	00f58763          	beq	a1,a5,13a <strchr+0x1a>
  for(; *s; s++)
 130:	0505                	addi	a0,a0,1
 132:	00054783          	lbu	a5,0(a0)
 136:	fbfd                	bnez	a5,12c <strchr+0xc>
      return (char*)s;
  return 0;
 138:	4501                	li	a0,0
}
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	addi	sp,sp,16
 13e:	8082                	ret
  return 0;
 140:	4501                	li	a0,0
 142:	bfe5                	j	13a <strchr+0x1a>

0000000000000144 <gets>:

char*
gets(char *buf, int max)
{
 144:	711d                	addi	sp,sp,-96
 146:	ec86                	sd	ra,88(sp)
 148:	e8a2                	sd	s0,80(sp)
 14a:	e4a6                	sd	s1,72(sp)
 14c:	e0ca                	sd	s2,64(sp)
 14e:	fc4e                	sd	s3,56(sp)
 150:	f852                	sd	s4,48(sp)
 152:	f456                	sd	s5,40(sp)
 154:	f05a                	sd	s6,32(sp)
 156:	ec5e                	sd	s7,24(sp)
 158:	e862                	sd	s8,16(sp)
 15a:	1080                	addi	s0,sp,96
 15c:	8baa                	mv	s7,a0
 15e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 160:	892a                	mv	s2,a0
 162:	4481                	li	s1,0
    cc = read(0, &c, 1);
 164:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 168:	4b29                	li	s6,10
 16a:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 16c:	89a6                	mv	s3,s1
 16e:	2485                	addiw	s1,s1,1
 170:	0344d763          	bge	s1,s4,19e <gets+0x5a>
    cc = read(0, &c, 1);
 174:	4605                	li	a2,1
 176:	85d6                	mv	a1,s5
 178:	4501                	li	a0,0
 17a:	00000097          	auipc	ra,0x0
 17e:	1b4080e7          	jalr	436(ra) # 32e <read>
    if(cc < 1)
 182:	00a05e63          	blez	a0,19e <gets+0x5a>
    buf[i++] = c;
 186:	faf44783          	lbu	a5,-81(s0)
 18a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 18e:	01678763          	beq	a5,s6,19c <gets+0x58>
 192:	0905                	addi	s2,s2,1
 194:	fd879ce3          	bne	a5,s8,16c <gets+0x28>
  for(i=0; i+1 < max; ){
 198:	89a6                	mv	s3,s1
 19a:	a011                	j	19e <gets+0x5a>
 19c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 19e:	99de                	add	s3,s3,s7
 1a0:	00098023          	sb	zero,0(s3)
  return buf;
}
 1a4:	855e                	mv	a0,s7
 1a6:	60e6                	ld	ra,88(sp)
 1a8:	6446                	ld	s0,80(sp)
 1aa:	64a6                	ld	s1,72(sp)
 1ac:	6906                	ld	s2,64(sp)
 1ae:	79e2                	ld	s3,56(sp)
 1b0:	7a42                	ld	s4,48(sp)
 1b2:	7aa2                	ld	s5,40(sp)
 1b4:	7b02                	ld	s6,32(sp)
 1b6:	6be2                	ld	s7,24(sp)
 1b8:	6c42                	ld	s8,16(sp)
 1ba:	6125                	addi	sp,sp,96
 1bc:	8082                	ret

00000000000001be <stat>:

int
stat(const char *n, struct stat *st)
{
 1be:	1101                	addi	sp,sp,-32
 1c0:	ec06                	sd	ra,24(sp)
 1c2:	e822                	sd	s0,16(sp)
 1c4:	e426                	sd	s1,8(sp)
 1c6:	e04a                	sd	s2,0(sp)
 1c8:	1000                	addi	s0,sp,32
 1ca:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1cc:	4581                	li	a1,0
 1ce:	00000097          	auipc	ra,0x0
 1d2:	188080e7          	jalr	392(ra) # 356 <open>
  if(fd < 0)
 1d6:	02054563          	bltz	a0,200 <stat+0x42>
 1da:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1dc:	85ca                	mv	a1,s2
 1de:	00000097          	auipc	ra,0x0
 1e2:	180080e7          	jalr	384(ra) # 35e <fstat>
 1e6:	892a                	mv	s2,a0
  close(fd);
 1e8:	8526                	mv	a0,s1
 1ea:	00000097          	auipc	ra,0x0
 1ee:	154080e7          	jalr	340(ra) # 33e <close>
  return r;
}
 1f2:	854a                	mv	a0,s2
 1f4:	60e2                	ld	ra,24(sp)
 1f6:	6442                	ld	s0,16(sp)
 1f8:	64a2                	ld	s1,8(sp)
 1fa:	6902                	ld	s2,0(sp)
 1fc:	6105                	addi	sp,sp,32
 1fe:	8082                	ret
    return -1;
 200:	597d                	li	s2,-1
 202:	bfc5                	j	1f2 <stat+0x34>

0000000000000204 <atoi>:

int
atoi(const char *s)
{
 204:	1141                	addi	sp,sp,-16
 206:	e422                	sd	s0,8(sp)
 208:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 20a:	00054703          	lbu	a4,0(a0)
 20e:	02d00793          	li	a5,45
  int neg = 1;
 212:	4805                	li	a6,1
  if (*s == '-') {
 214:	04f70363          	beq	a4,a5,25a <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 218:	00054683          	lbu	a3,0(a0)
 21c:	fd06879b          	addiw	a5,a3,-48
 220:	0ff7f793          	andi	a5,a5,255
 224:	4725                	li	a4,9
 226:	02f76d63          	bltu	a4,a5,260 <atoi+0x5c>
  n = 0;
 22a:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 22c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 22e:	0505                	addi	a0,a0,1
 230:	0026179b          	slliw	a5,a2,0x2
 234:	9fb1                	addw	a5,a5,a2
 236:	0017979b          	slliw	a5,a5,0x1
 23a:	9fb5                	addw	a5,a5,a3
 23c:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 240:	00054683          	lbu	a3,0(a0)
 244:	fd06871b          	addiw	a4,a3,-48
 248:	0ff77713          	andi	a4,a4,255
 24c:	fee5f1e3          	bgeu	a1,a4,22e <atoi+0x2a>
  return n * neg;
}
 250:	02c8053b          	mulw	a0,a6,a2
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret
    s++;
 25a:	0505                	addi	a0,a0,1
    neg = -1;
 25c:	587d                	li	a6,-1
 25e:	bf6d                	j	218 <atoi+0x14>
  n = 0;
 260:	4601                	li	a2,0
 262:	b7fd                	j	250 <atoi+0x4c>

0000000000000264 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 264:	1141                	addi	sp,sp,-16
 266:	e422                	sd	s0,8(sp)
 268:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 26a:	02b57463          	bgeu	a0,a1,292 <memmove+0x2e>
    while(n-- > 0)
 26e:	00c05f63          	blez	a2,28c <memmove+0x28>
 272:	1602                	slli	a2,a2,0x20
 274:	9201                	srli	a2,a2,0x20
 276:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 27a:	872a                	mv	a4,a0
      *dst++ = *src++;
 27c:	0585                	addi	a1,a1,1
 27e:	0705                	addi	a4,a4,1
 280:	fff5c683          	lbu	a3,-1(a1)
 284:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 288:	fee79ae3          	bne	a5,a4,27c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28c:	6422                	ld	s0,8(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret
    dst += n;
 292:	00c50733          	add	a4,a0,a2
    src += n;
 296:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 298:	fec05ae3          	blez	a2,28c <memmove+0x28>
 29c:	fff6079b          	addiw	a5,a2,-1
 2a0:	1782                	slli	a5,a5,0x20
 2a2:	9381                	srli	a5,a5,0x20
 2a4:	fff7c793          	not	a5,a5
 2a8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2aa:	15fd                	addi	a1,a1,-1
 2ac:	177d                	addi	a4,a4,-1
 2ae:	0005c683          	lbu	a3,0(a1)
 2b2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b6:	fee79ae3          	bne	a5,a4,2aa <memmove+0x46>
 2ba:	bfc9                	j	28c <memmove+0x28>

00000000000002bc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c2:	ca05                	beqz	a2,2f2 <memcmp+0x36>
 2c4:	fff6069b          	addiw	a3,a2,-1
 2c8:	1682                	slli	a3,a3,0x20
 2ca:	9281                	srli	a3,a3,0x20
 2cc:	0685                	addi	a3,a3,1
 2ce:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2d0:	00054783          	lbu	a5,0(a0)
 2d4:	0005c703          	lbu	a4,0(a1)
 2d8:	00e79863          	bne	a5,a4,2e8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2dc:	0505                	addi	a0,a0,1
    p2++;
 2de:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2e0:	fed518e3          	bne	a0,a3,2d0 <memcmp+0x14>
  }
  return 0;
 2e4:	4501                	li	a0,0
 2e6:	a019                	j	2ec <memcmp+0x30>
      return *p1 - *p2;
 2e8:	40e7853b          	subw	a0,a5,a4
}
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	addi	sp,sp,16
 2f0:	8082                	ret
  return 0;
 2f2:	4501                	li	a0,0
 2f4:	bfe5                	j	2ec <memcmp+0x30>

00000000000002f6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e406                	sd	ra,8(sp)
 2fa:	e022                	sd	s0,0(sp)
 2fc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2fe:	00000097          	auipc	ra,0x0
 302:	f66080e7          	jalr	-154(ra) # 264 <memmove>
}
 306:	60a2                	ld	ra,8(sp)
 308:	6402                	ld	s0,0(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret

000000000000030e <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 30e:	4885                	li	a7,1
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <exit>:
.global exit
exit:
 li a7, SYS_exit
 316:	4889                	li	a7,2
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <wait>:
.global wait
wait:
 li a7, SYS_wait
 31e:	488d                	li	a7,3
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 326:	4891                	li	a7,4
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <read>:
.global read
read:
 li a7, SYS_read
 32e:	4895                	li	a7,5
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <write>:
.global write
write:
 li a7, SYS_write
 336:	48c1                	li	a7,16
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <close>:
.global close
close:
 li a7, SYS_close
 33e:	48d5                	li	a7,21
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <kill>:
.global kill
kill:
 li a7, SYS_kill
 346:	4899                	li	a7,6
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <exec>:
.global exec
exec:
 li a7, SYS_exec
 34e:	489d                	li	a7,7
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <open>:
.global open
open:
 li a7, SYS_open
 356:	48bd                	li	a7,15
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 35e:	48a1                	li	a7,8
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 366:	48d1                	li	a7,20
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 36e:	48a5                	li	a7,9
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <dup>:
.global dup
dup:
 li a7, SYS_dup
 376:	48a9                	li	a7,10
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 37e:	48ad                	li	a7,11
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 386:	48b1                	li	a7,12
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 38e:	48b5                	li	a7,13
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 396:	48b9                	li	a7,14
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 39e:	48d9                	li	a7,22
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <dev>:
.global dev
dev:
 li a7, SYS_dev
 3a6:	48dd                	li	a7,23
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3ae:	48e1                	li	a7,24
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3b6:	48e5                	li	a7,25
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <remove>:
.global remove
remove:
 li a7, SYS_remove
 3be:	48c5                	li	a7,17
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3c6:	48c9                	li	a7,18
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3ce:	48cd                	li	a7,19
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <rename>:
.global rename
rename:
 li a7, SYS_rename
 3d6:	48e9                	li	a7,26
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3de:	1101                	addi	sp,sp,-32
 3e0:	ec06                	sd	ra,24(sp)
 3e2:	e822                	sd	s0,16(sp)
 3e4:	1000                	addi	s0,sp,32
 3e6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3ea:	4605                	li	a2,1
 3ec:	fef40593          	addi	a1,s0,-17
 3f0:	00000097          	auipc	ra,0x0
 3f4:	f46080e7          	jalr	-186(ra) # 336 <write>
}
 3f8:	60e2                	ld	ra,24(sp)
 3fa:	6442                	ld	s0,16(sp)
 3fc:	6105                	addi	sp,sp,32
 3fe:	8082                	ret

0000000000000400 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 400:	7139                	addi	sp,sp,-64
 402:	fc06                	sd	ra,56(sp)
 404:	f822                	sd	s0,48(sp)
 406:	f426                	sd	s1,40(sp)
 408:	f04a                	sd	s2,32(sp)
 40a:	ec4e                	sd	s3,24(sp)
 40c:	0080                	addi	s0,sp,64
 40e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 410:	c299                	beqz	a3,416 <printint+0x16>
 412:	0805c763          	bltz	a1,4a0 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 416:	2581                	sext.w	a1,a1
  neg = 0;
 418:	4881                	li	a7,0
  }

  i = 0;
 41a:	fc040993          	addi	s3,s0,-64
  neg = 0;
 41e:	86ce                	mv	a3,s3
  i = 0;
 420:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 422:	2601                	sext.w	a2,a2
 424:	00000517          	auipc	a0,0x0
 428:	48450513          	addi	a0,a0,1156 # 8a8 <digits>
 42c:	883a                	mv	a6,a4
 42e:	2705                	addiw	a4,a4,1
 430:	02c5f7bb          	remuw	a5,a1,a2
 434:	1782                	slli	a5,a5,0x20
 436:	9381                	srli	a5,a5,0x20
 438:	97aa                	add	a5,a5,a0
 43a:	0007c783          	lbu	a5,0(a5)
 43e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 442:	0005879b          	sext.w	a5,a1
 446:	02c5d5bb          	divuw	a1,a1,a2
 44a:	0685                	addi	a3,a3,1
 44c:	fec7f0e3          	bgeu	a5,a2,42c <printint+0x2c>
  if(neg)
 450:	00088b63          	beqz	a7,466 <printint+0x66>
    buf[i++] = '-';
 454:	fd040793          	addi	a5,s0,-48
 458:	973e                	add	a4,a4,a5
 45a:	02d00793          	li	a5,45
 45e:	fef70823          	sb	a5,-16(a4)
 462:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 466:	02e05663          	blez	a4,492 <printint+0x92>
 46a:	fc040913          	addi	s2,s0,-64
 46e:	993a                	add	s2,s2,a4
 470:	19fd                	addi	s3,s3,-1
 472:	99ba                	add	s3,s3,a4
 474:	377d                	addiw	a4,a4,-1
 476:	1702                	slli	a4,a4,0x20
 478:	9301                	srli	a4,a4,0x20
 47a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 47e:	fff94583          	lbu	a1,-1(s2)
 482:	8526                	mv	a0,s1
 484:	00000097          	auipc	ra,0x0
 488:	f5a080e7          	jalr	-166(ra) # 3de <putc>
  while(--i >= 0)
 48c:	197d                	addi	s2,s2,-1
 48e:	ff3918e3          	bne	s2,s3,47e <printint+0x7e>
}
 492:	70e2                	ld	ra,56(sp)
 494:	7442                	ld	s0,48(sp)
 496:	74a2                	ld	s1,40(sp)
 498:	7902                	ld	s2,32(sp)
 49a:	69e2                	ld	s3,24(sp)
 49c:	6121                	addi	sp,sp,64
 49e:	8082                	ret
    x = -xx;
 4a0:	40b005bb          	negw	a1,a1
    neg = 1;
 4a4:	4885                	li	a7,1
    x = -xx;
 4a6:	bf95                	j	41a <printint+0x1a>

00000000000004a8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4a8:	7119                	addi	sp,sp,-128
 4aa:	fc86                	sd	ra,120(sp)
 4ac:	f8a2                	sd	s0,112(sp)
 4ae:	f4a6                	sd	s1,104(sp)
 4b0:	f0ca                	sd	s2,96(sp)
 4b2:	ecce                	sd	s3,88(sp)
 4b4:	e8d2                	sd	s4,80(sp)
 4b6:	e4d6                	sd	s5,72(sp)
 4b8:	e0da                	sd	s6,64(sp)
 4ba:	fc5e                	sd	s7,56(sp)
 4bc:	f862                	sd	s8,48(sp)
 4be:	f466                	sd	s9,40(sp)
 4c0:	f06a                	sd	s10,32(sp)
 4c2:	ec6e                	sd	s11,24(sp)
 4c4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4c6:	0005c903          	lbu	s2,0(a1)
 4ca:	18090f63          	beqz	s2,668 <vprintf+0x1c0>
 4ce:	8aaa                	mv	s5,a0
 4d0:	8b32                	mv	s6,a2
 4d2:	00158493          	addi	s1,a1,1
  state = 0;
 4d6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4d8:	02500a13          	li	s4,37
      if(c == 'd'){
 4dc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4e0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4e4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4e8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4ec:	00000b97          	auipc	s7,0x0
 4f0:	3bcb8b93          	addi	s7,s7,956 # 8a8 <digits>
 4f4:	a839                	j	512 <vprintf+0x6a>
        putc(fd, c);
 4f6:	85ca                	mv	a1,s2
 4f8:	8556                	mv	a0,s5
 4fa:	00000097          	auipc	ra,0x0
 4fe:	ee4080e7          	jalr	-284(ra) # 3de <putc>
 502:	a019                	j	508 <vprintf+0x60>
    } else if(state == '%'){
 504:	01498f63          	beq	s3,s4,522 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 508:	0485                	addi	s1,s1,1
 50a:	fff4c903          	lbu	s2,-1(s1)
 50e:	14090d63          	beqz	s2,668 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 512:	0009079b          	sext.w	a5,s2
    if(state == 0){
 516:	fe0997e3          	bnez	s3,504 <vprintf+0x5c>
      if(c == '%'){
 51a:	fd479ee3          	bne	a5,s4,4f6 <vprintf+0x4e>
        state = '%';
 51e:	89be                	mv	s3,a5
 520:	b7e5                	j	508 <vprintf+0x60>
      if(c == 'd'){
 522:	05878063          	beq	a5,s8,562 <vprintf+0xba>
      } else if(c == 'l') {
 526:	05978c63          	beq	a5,s9,57e <vprintf+0xd6>
      } else if(c == 'x') {
 52a:	07a78863          	beq	a5,s10,59a <vprintf+0xf2>
      } else if(c == 'p') {
 52e:	09b78463          	beq	a5,s11,5b6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 532:	07300713          	li	a4,115
 536:	0ce78663          	beq	a5,a4,602 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 53a:	06300713          	li	a4,99
 53e:	0ee78e63          	beq	a5,a4,63a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 542:	11478863          	beq	a5,s4,652 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 546:	85d2                	mv	a1,s4
 548:	8556                	mv	a0,s5
 54a:	00000097          	auipc	ra,0x0
 54e:	e94080e7          	jalr	-364(ra) # 3de <putc>
        putc(fd, c);
 552:	85ca                	mv	a1,s2
 554:	8556                	mv	a0,s5
 556:	00000097          	auipc	ra,0x0
 55a:	e88080e7          	jalr	-376(ra) # 3de <putc>
      }
      state = 0;
 55e:	4981                	li	s3,0
 560:	b765                	j	508 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 562:	008b0913          	addi	s2,s6,8
 566:	4685                	li	a3,1
 568:	4629                	li	a2,10
 56a:	000b2583          	lw	a1,0(s6)
 56e:	8556                	mv	a0,s5
 570:	00000097          	auipc	ra,0x0
 574:	e90080e7          	jalr	-368(ra) # 400 <printint>
 578:	8b4a                	mv	s6,s2
      state = 0;
 57a:	4981                	li	s3,0
 57c:	b771                	j	508 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 57e:	008b0913          	addi	s2,s6,8
 582:	4681                	li	a3,0
 584:	4629                	li	a2,10
 586:	000b2583          	lw	a1,0(s6)
 58a:	8556                	mv	a0,s5
 58c:	00000097          	auipc	ra,0x0
 590:	e74080e7          	jalr	-396(ra) # 400 <printint>
 594:	8b4a                	mv	s6,s2
      state = 0;
 596:	4981                	li	s3,0
 598:	bf85                	j	508 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 59a:	008b0913          	addi	s2,s6,8
 59e:	4681                	li	a3,0
 5a0:	4641                	li	a2,16
 5a2:	000b2583          	lw	a1,0(s6)
 5a6:	8556                	mv	a0,s5
 5a8:	00000097          	auipc	ra,0x0
 5ac:	e58080e7          	jalr	-424(ra) # 400 <printint>
 5b0:	8b4a                	mv	s6,s2
      state = 0;
 5b2:	4981                	li	s3,0
 5b4:	bf91                	j	508 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5b6:	008b0793          	addi	a5,s6,8
 5ba:	f8f43423          	sd	a5,-120(s0)
 5be:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5c2:	03000593          	li	a1,48
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	e16080e7          	jalr	-490(ra) # 3de <putc>
  putc(fd, 'x');
 5d0:	85ea                	mv	a1,s10
 5d2:	8556                	mv	a0,s5
 5d4:	00000097          	auipc	ra,0x0
 5d8:	e0a080e7          	jalr	-502(ra) # 3de <putc>
 5dc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5de:	03c9d793          	srli	a5,s3,0x3c
 5e2:	97de                	add	a5,a5,s7
 5e4:	0007c583          	lbu	a1,0(a5)
 5e8:	8556                	mv	a0,s5
 5ea:	00000097          	auipc	ra,0x0
 5ee:	df4080e7          	jalr	-524(ra) # 3de <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5f2:	0992                	slli	s3,s3,0x4
 5f4:	397d                	addiw	s2,s2,-1
 5f6:	fe0914e3          	bnez	s2,5de <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5fa:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5fe:	4981                	li	s3,0
 600:	b721                	j	508 <vprintf+0x60>
        s = va_arg(ap, char*);
 602:	008b0993          	addi	s3,s6,8
 606:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 60a:	02090163          	beqz	s2,62c <vprintf+0x184>
        while(*s != 0){
 60e:	00094583          	lbu	a1,0(s2)
 612:	c9a1                	beqz	a1,662 <vprintf+0x1ba>
          putc(fd, *s);
 614:	8556                	mv	a0,s5
 616:	00000097          	auipc	ra,0x0
 61a:	dc8080e7          	jalr	-568(ra) # 3de <putc>
          s++;
 61e:	0905                	addi	s2,s2,1
        while(*s != 0){
 620:	00094583          	lbu	a1,0(s2)
 624:	f9e5                	bnez	a1,614 <vprintf+0x16c>
        s = va_arg(ap, char*);
 626:	8b4e                	mv	s6,s3
      state = 0;
 628:	4981                	li	s3,0
 62a:	bdf9                	j	508 <vprintf+0x60>
          s = "(null)";
 62c:	00000917          	auipc	s2,0x0
 630:	27490913          	addi	s2,s2,628 # 8a0 <malloc+0x12e>
        while(*s != 0){
 634:	02800593          	li	a1,40
 638:	bff1                	j	614 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 63a:	008b0913          	addi	s2,s6,8
 63e:	000b4583          	lbu	a1,0(s6)
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	d9a080e7          	jalr	-614(ra) # 3de <putc>
 64c:	8b4a                	mv	s6,s2
      state = 0;
 64e:	4981                	li	s3,0
 650:	bd65                	j	508 <vprintf+0x60>
        putc(fd, c);
 652:	85d2                	mv	a1,s4
 654:	8556                	mv	a0,s5
 656:	00000097          	auipc	ra,0x0
 65a:	d88080e7          	jalr	-632(ra) # 3de <putc>
      state = 0;
 65e:	4981                	li	s3,0
 660:	b565                	j	508 <vprintf+0x60>
        s = va_arg(ap, char*);
 662:	8b4e                	mv	s6,s3
      state = 0;
 664:	4981                	li	s3,0
 666:	b54d                	j	508 <vprintf+0x60>
    }
  }
}
 668:	70e6                	ld	ra,120(sp)
 66a:	7446                	ld	s0,112(sp)
 66c:	74a6                	ld	s1,104(sp)
 66e:	7906                	ld	s2,96(sp)
 670:	69e6                	ld	s3,88(sp)
 672:	6a46                	ld	s4,80(sp)
 674:	6aa6                	ld	s5,72(sp)
 676:	6b06                	ld	s6,64(sp)
 678:	7be2                	ld	s7,56(sp)
 67a:	7c42                	ld	s8,48(sp)
 67c:	7ca2                	ld	s9,40(sp)
 67e:	7d02                	ld	s10,32(sp)
 680:	6de2                	ld	s11,24(sp)
 682:	6109                	addi	sp,sp,128
 684:	8082                	ret

0000000000000686 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 686:	715d                	addi	sp,sp,-80
 688:	ec06                	sd	ra,24(sp)
 68a:	e822                	sd	s0,16(sp)
 68c:	1000                	addi	s0,sp,32
 68e:	e010                	sd	a2,0(s0)
 690:	e414                	sd	a3,8(s0)
 692:	e818                	sd	a4,16(s0)
 694:	ec1c                	sd	a5,24(s0)
 696:	03043023          	sd	a6,32(s0)
 69a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 69e:	8622                	mv	a2,s0
 6a0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6a4:	00000097          	auipc	ra,0x0
 6a8:	e04080e7          	jalr	-508(ra) # 4a8 <vprintf>
}
 6ac:	60e2                	ld	ra,24(sp)
 6ae:	6442                	ld	s0,16(sp)
 6b0:	6161                	addi	sp,sp,80
 6b2:	8082                	ret

00000000000006b4 <printf>:

void
printf(const char *fmt, ...)
{
 6b4:	711d                	addi	sp,sp,-96
 6b6:	ec06                	sd	ra,24(sp)
 6b8:	e822                	sd	s0,16(sp)
 6ba:	1000                	addi	s0,sp,32
 6bc:	e40c                	sd	a1,8(s0)
 6be:	e810                	sd	a2,16(s0)
 6c0:	ec14                	sd	a3,24(s0)
 6c2:	f018                	sd	a4,32(s0)
 6c4:	f41c                	sd	a5,40(s0)
 6c6:	03043823          	sd	a6,48(s0)
 6ca:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6ce:	00840613          	addi	a2,s0,8
 6d2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6d6:	85aa                	mv	a1,a0
 6d8:	4505                	li	a0,1
 6da:	00000097          	auipc	ra,0x0
 6de:	dce080e7          	jalr	-562(ra) # 4a8 <vprintf>
}
 6e2:	60e2                	ld	ra,24(sp)
 6e4:	6442                	ld	s0,16(sp)
 6e6:	6125                	addi	sp,sp,96
 6e8:	8082                	ret

00000000000006ea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ea:	1141                	addi	sp,sp,-16
 6ec:	e422                	sd	s0,8(sp)
 6ee:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6f0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f4:	00000797          	auipc	a5,0x0
 6f8:	1cc7b783          	ld	a5,460(a5) # 8c0 <freep>
 6fc:	a805                	j	72c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6fe:	4618                	lw	a4,8(a2)
 700:	9db9                	addw	a1,a1,a4
 702:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 706:	6398                	ld	a4,0(a5)
 708:	6318                	ld	a4,0(a4)
 70a:	fee53823          	sd	a4,-16(a0)
 70e:	a091                	j	752 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 710:	ff852703          	lw	a4,-8(a0)
 714:	9e39                	addw	a2,a2,a4
 716:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 718:	ff053703          	ld	a4,-16(a0)
 71c:	e398                	sd	a4,0(a5)
 71e:	a099                	j	764 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 720:	6398                	ld	a4,0(a5)
 722:	00e7e463          	bltu	a5,a4,72a <free+0x40>
 726:	00e6ea63          	bltu	a3,a4,73a <free+0x50>
{
 72a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72c:	fed7fae3          	bgeu	a5,a3,720 <free+0x36>
 730:	6398                	ld	a4,0(a5)
 732:	00e6e463          	bltu	a3,a4,73a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 736:	fee7eae3          	bltu	a5,a4,72a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 73a:	ff852583          	lw	a1,-8(a0)
 73e:	6390                	ld	a2,0(a5)
 740:	02059713          	slli	a4,a1,0x20
 744:	9301                	srli	a4,a4,0x20
 746:	0712                	slli	a4,a4,0x4
 748:	9736                	add	a4,a4,a3
 74a:	fae60ae3          	beq	a2,a4,6fe <free+0x14>
    bp->s.ptr = p->s.ptr;
 74e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 752:	4790                	lw	a2,8(a5)
 754:	02061713          	slli	a4,a2,0x20
 758:	9301                	srli	a4,a4,0x20
 75a:	0712                	slli	a4,a4,0x4
 75c:	973e                	add	a4,a4,a5
 75e:	fae689e3          	beq	a3,a4,710 <free+0x26>
  } else
    p->s.ptr = bp;
 762:	e394                	sd	a3,0(a5)
  freep = p;
 764:	00000717          	auipc	a4,0x0
 768:	14f73e23          	sd	a5,348(a4) # 8c0 <freep>
}
 76c:	6422                	ld	s0,8(sp)
 76e:	0141                	addi	sp,sp,16
 770:	8082                	ret

0000000000000772 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 772:	7139                	addi	sp,sp,-64
 774:	fc06                	sd	ra,56(sp)
 776:	f822                	sd	s0,48(sp)
 778:	f426                	sd	s1,40(sp)
 77a:	f04a                	sd	s2,32(sp)
 77c:	ec4e                	sd	s3,24(sp)
 77e:	e852                	sd	s4,16(sp)
 780:	e456                	sd	s5,8(sp)
 782:	e05a                	sd	s6,0(sp)
 784:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 786:	02051493          	slli	s1,a0,0x20
 78a:	9081                	srli	s1,s1,0x20
 78c:	04bd                	addi	s1,s1,15
 78e:	8091                	srli	s1,s1,0x4
 790:	0014899b          	addiw	s3,s1,1
 794:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 796:	00000517          	auipc	a0,0x0
 79a:	12a53503          	ld	a0,298(a0) # 8c0 <freep>
 79e:	c515                	beqz	a0,7ca <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7a2:	4798                	lw	a4,8(a5)
 7a4:	04977163          	bgeu	a4,s1,7e6 <malloc+0x74>
 7a8:	8a4e                	mv	s4,s3
 7aa:	0009871b          	sext.w	a4,s3
 7ae:	6685                	lui	a3,0x1
 7b0:	00d77363          	bgeu	a4,a3,7b6 <malloc+0x44>
 7b4:	6a05                	lui	s4,0x1
 7b6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7ba:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7be:	00000917          	auipc	s2,0x0
 7c2:	10290913          	addi	s2,s2,258 # 8c0 <freep>
  if(p == (char*)-1)
 7c6:	5afd                	li	s5,-1
 7c8:	a89d                	j	83e <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7ca:	00000797          	auipc	a5,0x0
 7ce:	0f678793          	addi	a5,a5,246 # 8c0 <freep>
 7d2:	00000717          	auipc	a4,0x0
 7d6:	0f670713          	addi	a4,a4,246 # 8c8 <base>
 7da:	e398                	sd	a4,0(a5)
 7dc:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 7de:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e2:	87ba                	mv	a5,a4
 7e4:	b7d1                	j	7a8 <malloc+0x36>
      if(p->s.size == nunits)
 7e6:	02e48b63          	beq	s1,a4,81c <malloc+0xaa>
        p->s.size -= nunits;
 7ea:	4137073b          	subw	a4,a4,s3
 7ee:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7f0:	1702                	slli	a4,a4,0x20
 7f2:	9301                	srli	a4,a4,0x20
 7f4:	0712                	slli	a4,a4,0x4
 7f6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7f8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7fc:	00000717          	auipc	a4,0x0
 800:	0ca73223          	sd	a0,196(a4) # 8c0 <freep>
      return (void*)(p + 1);
 804:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 808:	70e2                	ld	ra,56(sp)
 80a:	7442                	ld	s0,48(sp)
 80c:	74a2                	ld	s1,40(sp)
 80e:	7902                	ld	s2,32(sp)
 810:	69e2                	ld	s3,24(sp)
 812:	6a42                	ld	s4,16(sp)
 814:	6aa2                	ld	s5,8(sp)
 816:	6b02                	ld	s6,0(sp)
 818:	6121                	addi	sp,sp,64
 81a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 81c:	6398                	ld	a4,0(a5)
 81e:	e118                	sd	a4,0(a0)
 820:	bff1                	j	7fc <malloc+0x8a>
  hp->s.size = nu;
 822:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 826:	0541                	addi	a0,a0,16
 828:	00000097          	auipc	ra,0x0
 82c:	ec2080e7          	jalr	-318(ra) # 6ea <free>
  return freep;
 830:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 834:	d971                	beqz	a0,808 <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 836:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 838:	4798                	lw	a4,8(a5)
 83a:	fa9776e3          	bgeu	a4,s1,7e6 <malloc+0x74>
    if(p == freep)
 83e:	00093703          	ld	a4,0(s2)
 842:	853e                	mv	a0,a5
 844:	fef719e3          	bne	a4,a5,836 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 848:	8552                	mv	a0,s4
 84a:	00000097          	auipc	ra,0x0
 84e:	b3c080e7          	jalr	-1220(ra) # 386 <sbrk>
  if(p == (char*)-1)
 852:	fd5518e3          	bne	a0,s5,822 <malloc+0xb0>
        return 0;
 856:	4501                	li	a0,0
 858:	bf45                	j	808 <malloc+0x96>
