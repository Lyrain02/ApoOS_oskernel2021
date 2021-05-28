
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
  10:	3de080e7          	jalr	990(ra) # 3ea <sysinfo>
  14:	02054c63          	bltz	a0,4c <main+0x4c>
        printf("sysinfo fail!\n");
    } else {
        printf("memory left: %d KB\n", info.freemem >> 10);
  18:	fe043583          	ld	a1,-32(s0)
  1c:	81a9                	srli	a1,a1,0xa
  1e:	00001517          	auipc	a0,0x1
  22:	86a50513          	addi	a0,a0,-1942 # 888 <malloc+0xf8>
  26:	00000097          	auipc	ra,0x0
  2a:	6aa080e7          	jalr	1706(ra) # 6d0 <printf>
        printf("process amount: %d\n", info.nproc);
  2e:	fe843583          	ld	a1,-24(s0)
  32:	00001517          	auipc	a0,0x1
  36:	86e50513          	addi	a0,a0,-1938 # 8a0 <malloc+0x110>
  3a:	00000097          	auipc	ra,0x0
  3e:	696080e7          	jalr	1686(ra) # 6d0 <printf>
    }
    exit(0);
  42:	4501                	li	a0,0
  44:	00000097          	auipc	ra,0x0
  48:	2ee080e7          	jalr	750(ra) # 332 <exit>
        printf("sysinfo fail!\n");
  4c:	00001517          	auipc	a0,0x1
  50:	82c50513          	addi	a0,a0,-2004 # 878 <malloc+0xe8>
  54:	00000097          	auipc	ra,0x0
  58:	67c080e7          	jalr	1660(ra) # 6d0 <printf>
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
  b2:	cf91                	beqz	a5,ce <strcmp+0x26>
  b4:	0005c703          	lbu	a4,0(a1)
  b8:	00f71b63          	bne	a4,a5,ce <strcmp+0x26>
    p++, q++;
  bc:	0505                	addi	a0,a0,1
  be:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	c789                	beqz	a5,ce <strcmp+0x26>
  c6:	0005c703          	lbu	a4,0(a1)
  ca:	fef709e3          	beq	a4,a5,bc <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  ce:	0005c503          	lbu	a0,0(a1)
}
  d2:	40a7853b          	subw	a0,a5,a0
  d6:	6422                	ld	s0,8(sp)
  d8:	0141                	addi	sp,sp,16
  da:	8082                	ret

00000000000000dc <strlen>:

uint
strlen(const char *s)
{
  dc:	1141                	addi	sp,sp,-16
  de:	e422                	sd	s0,8(sp)
  e0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e2:	00054783          	lbu	a5,0(a0)
  e6:	cf91                	beqz	a5,102 <strlen+0x26>
  e8:	0505                	addi	a0,a0,1
  ea:	87aa                	mv	a5,a0
  ec:	4685                	li	a3,1
  ee:	9e89                	subw	a3,a3,a0
    ;
  f0:	00f6853b          	addw	a0,a3,a5
  f4:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  f6:	fff7c703          	lbu	a4,-1(a5)
  fa:	fb7d                	bnez	a4,f0 <strlen+0x14>
  return n;
}
  fc:	6422                	ld	s0,8(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret
  for(n = 0; s[n]; n++)
 102:	4501                	li	a0,0
 104:	bfe5                	j	fc <strlen+0x20>

0000000000000106 <memset>:

void*
memset(void *dst, int c, uint n)
{
 106:	1141                	addi	sp,sp,-16
 108:	e422                	sd	s0,8(sp)
 10a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 10c:	ce09                	beqz	a2,126 <memset+0x20>
 10e:	87aa                	mv	a5,a0
 110:	fff6071b          	addiw	a4,a2,-1
 114:	1702                	slli	a4,a4,0x20
 116:	9301                	srli	a4,a4,0x20
 118:	0705                	addi	a4,a4,1
 11a:	972a                	add	a4,a4,a0
    cdst[i] = c;
 11c:	00b78023          	sb	a1,0(a5)
 120:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 122:	fee79de3          	bne	a5,a4,11c <memset+0x16>
  }
  return dst;
}
 126:	6422                	ld	s0,8(sp)
 128:	0141                	addi	sp,sp,16
 12a:	8082                	ret

000000000000012c <strchr>:

char*
strchr(const char *s, char c)
{
 12c:	1141                	addi	sp,sp,-16
 12e:	e422                	sd	s0,8(sp)
 130:	0800                	addi	s0,sp,16
  for(; *s; s++)
 132:	00054783          	lbu	a5,0(a0)
 136:	cf91                	beqz	a5,152 <strchr+0x26>
    if(*s == c)
 138:	00f58a63          	beq	a1,a5,14c <strchr+0x20>
  for(; *s; s++)
 13c:	0505                	addi	a0,a0,1
 13e:	00054783          	lbu	a5,0(a0)
 142:	c781                	beqz	a5,14a <strchr+0x1e>
    if(*s == c)
 144:	feb79ce3          	bne	a5,a1,13c <strchr+0x10>
 148:	a011                	j	14c <strchr+0x20>
      return (char*)s;
  return 0;
 14a:	4501                	li	a0,0
}
 14c:	6422                	ld	s0,8(sp)
 14e:	0141                	addi	sp,sp,16
 150:	8082                	ret
  return 0;
 152:	4501                	li	a0,0
 154:	bfe5                	j	14c <strchr+0x20>

0000000000000156 <gets>:

char*
gets(char *buf, int max)
{
 156:	711d                	addi	sp,sp,-96
 158:	ec86                	sd	ra,88(sp)
 15a:	e8a2                	sd	s0,80(sp)
 15c:	e4a6                	sd	s1,72(sp)
 15e:	e0ca                	sd	s2,64(sp)
 160:	fc4e                	sd	s3,56(sp)
 162:	f852                	sd	s4,48(sp)
 164:	f456                	sd	s5,40(sp)
 166:	f05a                	sd	s6,32(sp)
 168:	ec5e                	sd	s7,24(sp)
 16a:	1080                	addi	s0,sp,96
 16c:	8baa                	mv	s7,a0
 16e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 170:	892a                	mv	s2,a0
 172:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 174:	4aa9                	li	s5,10
 176:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 178:	0019849b          	addiw	s1,s3,1
 17c:	0344d863          	bge	s1,s4,1ac <gets+0x56>
    cc = read(0, &c, 1);
 180:	4605                	li	a2,1
 182:	faf40593          	addi	a1,s0,-81
 186:	4501                	li	a0,0
 188:	00000097          	auipc	ra,0x0
 18c:	1c2080e7          	jalr	450(ra) # 34a <read>
    if(cc < 1)
 190:	00a05e63          	blez	a0,1ac <gets+0x56>
    buf[i++] = c;
 194:	faf44783          	lbu	a5,-81(s0)
 198:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 19c:	01578763          	beq	a5,s5,1aa <gets+0x54>
 1a0:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 1a2:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 1a4:	fd679ae3          	bne	a5,s6,178 <gets+0x22>
 1a8:	a011                	j	1ac <gets+0x56>
  for(i=0; i+1 < max; ){
 1aa:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1ac:	99de                	add	s3,s3,s7
 1ae:	00098023          	sb	zero,0(s3)
  return buf;
}
 1b2:	855e                	mv	a0,s7
 1b4:	60e6                	ld	ra,88(sp)
 1b6:	6446                	ld	s0,80(sp)
 1b8:	64a6                	ld	s1,72(sp)
 1ba:	6906                	ld	s2,64(sp)
 1bc:	79e2                	ld	s3,56(sp)
 1be:	7a42                	ld	s4,48(sp)
 1c0:	7aa2                	ld	s5,40(sp)
 1c2:	7b02                	ld	s6,32(sp)
 1c4:	6be2                	ld	s7,24(sp)
 1c6:	6125                	addi	sp,sp,96
 1c8:	8082                	ret

00000000000001ca <stat>:

int
stat(const char *n, struct stat *st)
{
 1ca:	1101                	addi	sp,sp,-32
 1cc:	ec06                	sd	ra,24(sp)
 1ce:	e822                	sd	s0,16(sp)
 1d0:	e426                	sd	s1,8(sp)
 1d2:	e04a                	sd	s2,0(sp)
 1d4:	1000                	addi	s0,sp,32
 1d6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d8:	4581                	li	a1,0
 1da:	00000097          	auipc	ra,0x0
 1de:	198080e7          	jalr	408(ra) # 372 <open>
  if(fd < 0)
 1e2:	02054563          	bltz	a0,20c <stat+0x42>
 1e6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1e8:	85ca                	mv	a1,s2
 1ea:	00000097          	auipc	ra,0x0
 1ee:	190080e7          	jalr	400(ra) # 37a <fstat>
 1f2:	892a                	mv	s2,a0
  close(fd);
 1f4:	8526                	mv	a0,s1
 1f6:	00000097          	auipc	ra,0x0
 1fa:	164080e7          	jalr	356(ra) # 35a <close>
  return r;
}
 1fe:	854a                	mv	a0,s2
 200:	60e2                	ld	ra,24(sp)
 202:	6442                	ld	s0,16(sp)
 204:	64a2                	ld	s1,8(sp)
 206:	6902                	ld	s2,0(sp)
 208:	6105                	addi	sp,sp,32
 20a:	8082                	ret
    return -1;
 20c:	597d                	li	s2,-1
 20e:	bfc5                	j	1fe <stat+0x34>

0000000000000210 <atoi>:

int
atoi(const char *s)
{
 210:	1141                	addi	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 216:	00054703          	lbu	a4,0(a0)
 21a:	02d00793          	li	a5,45
  int neg = 1;
 21e:	4805                	li	a6,1
  if (*s == '-') {
 220:	04f70363          	beq	a4,a5,266 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 224:	00054683          	lbu	a3,0(a0)
 228:	fd06879b          	addiw	a5,a3,-48
 22c:	0ff7f793          	andi	a5,a5,255
 230:	4725                	li	a4,9
 232:	02f76d63          	bltu	a4,a5,26c <atoi+0x5c>
  n = 0;
 236:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 238:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 23a:	0505                	addi	a0,a0,1
 23c:	0026179b          	slliw	a5,a2,0x2
 240:	9fb1                	addw	a5,a5,a2
 242:	0017979b          	slliw	a5,a5,0x1
 246:	9fb5                	addw	a5,a5,a3
 248:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 24c:	00054683          	lbu	a3,0(a0)
 250:	fd06871b          	addiw	a4,a3,-48
 254:	0ff77713          	andi	a4,a4,255
 258:	fee5f1e3          	bgeu	a1,a4,23a <atoi+0x2a>
  return n * neg;
}
 25c:	02c8053b          	mulw	a0,a6,a2
 260:	6422                	ld	s0,8(sp)
 262:	0141                	addi	sp,sp,16
 264:	8082                	ret
    s++;
 266:	0505                	addi	a0,a0,1
    neg = -1;
 268:	587d                	li	a6,-1
 26a:	bf6d                	j	224 <atoi+0x14>
  n = 0;
 26c:	4601                	li	a2,0
 26e:	b7fd                	j	25c <atoi+0x4c>

0000000000000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 276:	02b57663          	bgeu	a0,a1,2a2 <memmove+0x32>
    while(n-- > 0)
 27a:	02c05163          	blez	a2,29c <memmove+0x2c>
 27e:	fff6079b          	addiw	a5,a2,-1
 282:	1782                	slli	a5,a5,0x20
 284:	9381                	srli	a5,a5,0x20
 286:	0785                	addi	a5,a5,1
 288:	97aa                	add	a5,a5,a0
  dst = vdst;
 28a:	872a                	mv	a4,a0
      *dst++ = *src++;
 28c:	0585                	addi	a1,a1,1
 28e:	0705                	addi	a4,a4,1
 290:	fff5c683          	lbu	a3,-1(a1)
 294:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 298:	fee79ae3          	bne	a5,a4,28c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
    dst += n;
 2a2:	00c50733          	add	a4,a0,a2
    src += n;
 2a6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2a8:	fec05ae3          	blez	a2,29c <memmove+0x2c>
 2ac:	fff6079b          	addiw	a5,a2,-1
 2b0:	1782                	slli	a5,a5,0x20
 2b2:	9381                	srli	a5,a5,0x20
 2b4:	fff7c793          	not	a5,a5
 2b8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ba:	15fd                	addi	a1,a1,-1
 2bc:	177d                	addi	a4,a4,-1
 2be:	0005c683          	lbu	a3,0(a1)
 2c2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c6:	fef71ae3          	bne	a4,a5,2ba <memmove+0x4a>
 2ca:	bfc9                	j	29c <memmove+0x2c>

00000000000002cc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2cc:	1141                	addi	sp,sp,-16
 2ce:	e422                	sd	s0,8(sp)
 2d0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d2:	ce15                	beqz	a2,30e <memcmp+0x42>
 2d4:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 2d8:	00054783          	lbu	a5,0(a0)
 2dc:	0005c703          	lbu	a4,0(a1)
 2e0:	02e79063          	bne	a5,a4,300 <memcmp+0x34>
 2e4:	1682                	slli	a3,a3,0x20
 2e6:	9281                	srli	a3,a3,0x20
 2e8:	0685                	addi	a3,a3,1
 2ea:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 2ec:	0505                	addi	a0,a0,1
    p2++;
 2ee:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2f0:	00d50d63          	beq	a0,a3,30a <memcmp+0x3e>
    if (*p1 != *p2) {
 2f4:	00054783          	lbu	a5,0(a0)
 2f8:	0005c703          	lbu	a4,0(a1)
 2fc:	fee788e3          	beq	a5,a4,2ec <memcmp+0x20>
      return *p1 - *p2;
 300:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 304:	6422                	ld	s0,8(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret
  return 0;
 30a:	4501                	li	a0,0
 30c:	bfe5                	j	304 <memcmp+0x38>
 30e:	4501                	li	a0,0
 310:	bfd5                	j	304 <memcmp+0x38>

0000000000000312 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 312:	1141                	addi	sp,sp,-16
 314:	e406                	sd	ra,8(sp)
 316:	e022                	sd	s0,0(sp)
 318:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 31a:	00000097          	auipc	ra,0x0
 31e:	f56080e7          	jalr	-170(ra) # 270 <memmove>
}
 322:	60a2                	ld	ra,8(sp)
 324:	6402                	ld	s0,0(sp)
 326:	0141                	addi	sp,sp,16
 328:	8082                	ret

000000000000032a <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 32a:	4885                	li	a7,1
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <exit>:
.global exit
exit:
 li a7, SYS_exit
 332:	4889                	li	a7,2
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <wait>:
.global wait
wait:
 li a7, SYS_wait
 33a:	488d                	li	a7,3
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 342:	4891                	li	a7,4
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <read>:
.global read
read:
 li a7, SYS_read
 34a:	4895                	li	a7,5
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <write>:
.global write
write:
 li a7, SYS_write
 352:	48c1                	li	a7,16
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <close>:
.global close
close:
 li a7, SYS_close
 35a:	48d5                	li	a7,21
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <kill>:
.global kill
kill:
 li a7, SYS_kill
 362:	4899                	li	a7,6
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <exec>:
.global exec
exec:
 li a7, SYS_exec
 36a:	489d                	li	a7,7
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <open>:
.global open
open:
 li a7, SYS_open
 372:	48bd                	li	a7,15
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 37a:	48a1                	li	a7,8
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 382:	48d1                	li	a7,20
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 38a:	48a5                	li	a7,9
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <dup>:
.global dup
dup:
 li a7, SYS_dup
 392:	48a9                	li	a7,10
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 39a:	48ad                	li	a7,11
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a2:	48b1                	li	a7,12
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3aa:	48b5                	li	a7,13
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b2:	48b9                	li	a7,14
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3ba:	48d9                	li	a7,22
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <dev>:
.global dev
dev:
 li a7, SYS_dev
 3c2:	48dd                	li	a7,23
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3ca:	48e1                	li	a7,24
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3d2:	48e5                	li	a7,25
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <remove>:
.global remove
remove:
 li a7, SYS_remove
 3da:	48c5                	li	a7,17
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3e2:	48c9                	li	a7,18
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3ea:	48cd                	li	a7,19
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <rename>:
.global rename
rename:
 li a7, SYS_rename
 3f2:	48e9                	li	a7,26
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3fa:	1101                	addi	sp,sp,-32
 3fc:	ec06                	sd	ra,24(sp)
 3fe:	e822                	sd	s0,16(sp)
 400:	1000                	addi	s0,sp,32
 402:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 406:	4605                	li	a2,1
 408:	fef40593          	addi	a1,s0,-17
 40c:	00000097          	auipc	ra,0x0
 410:	f46080e7          	jalr	-186(ra) # 352 <write>
}
 414:	60e2                	ld	ra,24(sp)
 416:	6442                	ld	s0,16(sp)
 418:	6105                	addi	sp,sp,32
 41a:	8082                	ret

000000000000041c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41c:	7139                	addi	sp,sp,-64
 41e:	fc06                	sd	ra,56(sp)
 420:	f822                	sd	s0,48(sp)
 422:	f426                	sd	s1,40(sp)
 424:	f04a                	sd	s2,32(sp)
 426:	ec4e                	sd	s3,24(sp)
 428:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42a:	c299                	beqz	a3,430 <printint+0x14>
 42c:	0005cd63          	bltz	a1,446 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 430:	2581                	sext.w	a1,a1
  neg = 0;
 432:	4301                	li	t1,0
 434:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 438:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 43a:	2601                	sext.w	a2,a2
 43c:	00000897          	auipc	a7,0x0
 440:	47c88893          	addi	a7,a7,1148 # 8b8 <digits>
 444:	a039                	j	452 <printint+0x36>
    x = -xx;
 446:	40b005bb          	negw	a1,a1
    neg = 1;
 44a:	4305                	li	t1,1
    x = -xx;
 44c:	b7e5                	j	434 <printint+0x18>
  }while((x /= base) != 0);
 44e:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 450:	8836                	mv	a6,a3
 452:	0018069b          	addiw	a3,a6,1
 456:	02c5f7bb          	remuw	a5,a1,a2
 45a:	1782                	slli	a5,a5,0x20
 45c:	9381                	srli	a5,a5,0x20
 45e:	97c6                	add	a5,a5,a7
 460:	0007c783          	lbu	a5,0(a5)
 464:	00f70023          	sb	a5,0(a4)
 468:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 46a:	02c5d7bb          	divuw	a5,a1,a2
 46e:	fec5f0e3          	bgeu	a1,a2,44e <printint+0x32>
  if(neg)
 472:	00030b63          	beqz	t1,488 <printint+0x6c>
    buf[i++] = '-';
 476:	fd040793          	addi	a5,s0,-48
 47a:	96be                	add	a3,a3,a5
 47c:	02d00793          	li	a5,45
 480:	fef68823          	sb	a5,-16(a3)
 484:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 488:	02d05963          	blez	a3,4ba <printint+0x9e>
 48c:	89aa                	mv	s3,a0
 48e:	fc040793          	addi	a5,s0,-64
 492:	00d784b3          	add	s1,a5,a3
 496:	fff78913          	addi	s2,a5,-1
 49a:	9936                	add	s2,s2,a3
 49c:	36fd                	addiw	a3,a3,-1
 49e:	1682                	slli	a3,a3,0x20
 4a0:	9281                	srli	a3,a3,0x20
 4a2:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 4a6:	fff4c583          	lbu	a1,-1(s1)
 4aa:	854e                	mv	a0,s3
 4ac:	00000097          	auipc	ra,0x0
 4b0:	f4e080e7          	jalr	-178(ra) # 3fa <putc>
 4b4:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 4b6:	ff2498e3          	bne	s1,s2,4a6 <printint+0x8a>
}
 4ba:	70e2                	ld	ra,56(sp)
 4bc:	7442                	ld	s0,48(sp)
 4be:	74a2                	ld	s1,40(sp)
 4c0:	7902                	ld	s2,32(sp)
 4c2:	69e2                	ld	s3,24(sp)
 4c4:	6121                	addi	sp,sp,64
 4c6:	8082                	ret

00000000000004c8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c8:	7119                	addi	sp,sp,-128
 4ca:	fc86                	sd	ra,120(sp)
 4cc:	f8a2                	sd	s0,112(sp)
 4ce:	f4a6                	sd	s1,104(sp)
 4d0:	f0ca                	sd	s2,96(sp)
 4d2:	ecce                	sd	s3,88(sp)
 4d4:	e8d2                	sd	s4,80(sp)
 4d6:	e4d6                	sd	s5,72(sp)
 4d8:	e0da                	sd	s6,64(sp)
 4da:	fc5e                	sd	s7,56(sp)
 4dc:	f862                	sd	s8,48(sp)
 4de:	f466                	sd	s9,40(sp)
 4e0:	f06a                	sd	s10,32(sp)
 4e2:	ec6e                	sd	s11,24(sp)
 4e4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4e6:	0005c483          	lbu	s1,0(a1)
 4ea:	18048d63          	beqz	s1,684 <vprintf+0x1bc>
 4ee:	8aaa                	mv	s5,a0
 4f0:	8b32                	mv	s6,a2
 4f2:	00158913          	addi	s2,a1,1
  state = 0;
 4f6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f8:	02500a13          	li	s4,37
      if(c == 'd'){
 4fc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 500:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 504:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 508:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 50c:	00000b97          	auipc	s7,0x0
 510:	3acb8b93          	addi	s7,s7,940 # 8b8 <digits>
 514:	a839                	j	532 <vprintf+0x6a>
        putc(fd, c);
 516:	85a6                	mv	a1,s1
 518:	8556                	mv	a0,s5
 51a:	00000097          	auipc	ra,0x0
 51e:	ee0080e7          	jalr	-288(ra) # 3fa <putc>
 522:	a019                	j	528 <vprintf+0x60>
    } else if(state == '%'){
 524:	01498f63          	beq	s3,s4,542 <vprintf+0x7a>
 528:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 52a:	fff94483          	lbu	s1,-1(s2)
 52e:	14048b63          	beqz	s1,684 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 532:	0004879b          	sext.w	a5,s1
    if(state == 0){
 536:	fe0997e3          	bnez	s3,524 <vprintf+0x5c>
      if(c == '%'){
 53a:	fd479ee3          	bne	a5,s4,516 <vprintf+0x4e>
        state = '%';
 53e:	89be                	mv	s3,a5
 540:	b7e5                	j	528 <vprintf+0x60>
      if(c == 'd'){
 542:	05878063          	beq	a5,s8,582 <vprintf+0xba>
      } else if(c == 'l') {
 546:	05978c63          	beq	a5,s9,59e <vprintf+0xd6>
      } else if(c == 'x') {
 54a:	07a78863          	beq	a5,s10,5ba <vprintf+0xf2>
      } else if(c == 'p') {
 54e:	09b78463          	beq	a5,s11,5d6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 552:	07300713          	li	a4,115
 556:	0ce78563          	beq	a5,a4,620 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 55a:	06300713          	li	a4,99
 55e:	0ee78c63          	beq	a5,a4,656 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 562:	11478663          	beq	a5,s4,66e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 566:	85d2                	mv	a1,s4
 568:	8556                	mv	a0,s5
 56a:	00000097          	auipc	ra,0x0
 56e:	e90080e7          	jalr	-368(ra) # 3fa <putc>
        putc(fd, c);
 572:	85a6                	mv	a1,s1
 574:	8556                	mv	a0,s5
 576:	00000097          	auipc	ra,0x0
 57a:	e84080e7          	jalr	-380(ra) # 3fa <putc>
      }
      state = 0;
 57e:	4981                	li	s3,0
 580:	b765                	j	528 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 582:	008b0493          	addi	s1,s6,8
 586:	4685                	li	a3,1
 588:	4629                	li	a2,10
 58a:	000b2583          	lw	a1,0(s6)
 58e:	8556                	mv	a0,s5
 590:	00000097          	auipc	ra,0x0
 594:	e8c080e7          	jalr	-372(ra) # 41c <printint>
 598:	8b26                	mv	s6,s1
      state = 0;
 59a:	4981                	li	s3,0
 59c:	b771                	j	528 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 59e:	008b0493          	addi	s1,s6,8
 5a2:	4681                	li	a3,0
 5a4:	4629                	li	a2,10
 5a6:	000b2583          	lw	a1,0(s6)
 5aa:	8556                	mv	a0,s5
 5ac:	00000097          	auipc	ra,0x0
 5b0:	e70080e7          	jalr	-400(ra) # 41c <printint>
 5b4:	8b26                	mv	s6,s1
      state = 0;
 5b6:	4981                	li	s3,0
 5b8:	bf85                	j	528 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5ba:	008b0493          	addi	s1,s6,8
 5be:	4681                	li	a3,0
 5c0:	4641                	li	a2,16
 5c2:	000b2583          	lw	a1,0(s6)
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	e54080e7          	jalr	-428(ra) # 41c <printint>
 5d0:	8b26                	mv	s6,s1
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	bf91                	j	528 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5d6:	008b0793          	addi	a5,s6,8
 5da:	f8f43423          	sd	a5,-120(s0)
 5de:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5e2:	03000593          	li	a1,48
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	e12080e7          	jalr	-494(ra) # 3fa <putc>
  putc(fd, 'x');
 5f0:	85ea                	mv	a1,s10
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	e06080e7          	jalr	-506(ra) # 3fa <putc>
 5fc:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5fe:	03c9d793          	srli	a5,s3,0x3c
 602:	97de                	add	a5,a5,s7
 604:	0007c583          	lbu	a1,0(a5)
 608:	8556                	mv	a0,s5
 60a:	00000097          	auipc	ra,0x0
 60e:	df0080e7          	jalr	-528(ra) # 3fa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 612:	0992                	slli	s3,s3,0x4
 614:	34fd                	addiw	s1,s1,-1
 616:	f4e5                	bnez	s1,5fe <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 618:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 61c:	4981                	li	s3,0
 61e:	b729                	j	528 <vprintf+0x60>
        s = va_arg(ap, char*);
 620:	008b0993          	addi	s3,s6,8
 624:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 628:	c085                	beqz	s1,648 <vprintf+0x180>
        while(*s != 0){
 62a:	0004c583          	lbu	a1,0(s1)
 62e:	c9a1                	beqz	a1,67e <vprintf+0x1b6>
          putc(fd, *s);
 630:	8556                	mv	a0,s5
 632:	00000097          	auipc	ra,0x0
 636:	dc8080e7          	jalr	-568(ra) # 3fa <putc>
          s++;
 63a:	0485                	addi	s1,s1,1
        while(*s != 0){
 63c:	0004c583          	lbu	a1,0(s1)
 640:	f9e5                	bnez	a1,630 <vprintf+0x168>
        s = va_arg(ap, char*);
 642:	8b4e                	mv	s6,s3
      state = 0;
 644:	4981                	li	s3,0
 646:	b5cd                	j	528 <vprintf+0x60>
          s = "(null)";
 648:	00000497          	auipc	s1,0x0
 64c:	28848493          	addi	s1,s1,648 # 8d0 <digits+0x18>
        while(*s != 0){
 650:	02800593          	li	a1,40
 654:	bff1                	j	630 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 656:	008b0493          	addi	s1,s6,8
 65a:	000b4583          	lbu	a1,0(s6)
 65e:	8556                	mv	a0,s5
 660:	00000097          	auipc	ra,0x0
 664:	d9a080e7          	jalr	-614(ra) # 3fa <putc>
 668:	8b26                	mv	s6,s1
      state = 0;
 66a:	4981                	li	s3,0
 66c:	bd75                	j	528 <vprintf+0x60>
        putc(fd, c);
 66e:	85d2                	mv	a1,s4
 670:	8556                	mv	a0,s5
 672:	00000097          	auipc	ra,0x0
 676:	d88080e7          	jalr	-632(ra) # 3fa <putc>
      state = 0;
 67a:	4981                	li	s3,0
 67c:	b575                	j	528 <vprintf+0x60>
        s = va_arg(ap, char*);
 67e:	8b4e                	mv	s6,s3
      state = 0;
 680:	4981                	li	s3,0
 682:	b55d                	j	528 <vprintf+0x60>
    }
  }
}
 684:	70e6                	ld	ra,120(sp)
 686:	7446                	ld	s0,112(sp)
 688:	74a6                	ld	s1,104(sp)
 68a:	7906                	ld	s2,96(sp)
 68c:	69e6                	ld	s3,88(sp)
 68e:	6a46                	ld	s4,80(sp)
 690:	6aa6                	ld	s5,72(sp)
 692:	6b06                	ld	s6,64(sp)
 694:	7be2                	ld	s7,56(sp)
 696:	7c42                	ld	s8,48(sp)
 698:	7ca2                	ld	s9,40(sp)
 69a:	7d02                	ld	s10,32(sp)
 69c:	6de2                	ld	s11,24(sp)
 69e:	6109                	addi	sp,sp,128
 6a0:	8082                	ret

00000000000006a2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6a2:	715d                	addi	sp,sp,-80
 6a4:	ec06                	sd	ra,24(sp)
 6a6:	e822                	sd	s0,16(sp)
 6a8:	1000                	addi	s0,sp,32
 6aa:	e010                	sd	a2,0(s0)
 6ac:	e414                	sd	a3,8(s0)
 6ae:	e818                	sd	a4,16(s0)
 6b0:	ec1c                	sd	a5,24(s0)
 6b2:	03043023          	sd	a6,32(s0)
 6b6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6ba:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6be:	8622                	mv	a2,s0
 6c0:	00000097          	auipc	ra,0x0
 6c4:	e08080e7          	jalr	-504(ra) # 4c8 <vprintf>
}
 6c8:	60e2                	ld	ra,24(sp)
 6ca:	6442                	ld	s0,16(sp)
 6cc:	6161                	addi	sp,sp,80
 6ce:	8082                	ret

00000000000006d0 <printf>:

void
printf(const char *fmt, ...)
{
 6d0:	711d                	addi	sp,sp,-96
 6d2:	ec06                	sd	ra,24(sp)
 6d4:	e822                	sd	s0,16(sp)
 6d6:	1000                	addi	s0,sp,32
 6d8:	e40c                	sd	a1,8(s0)
 6da:	e810                	sd	a2,16(s0)
 6dc:	ec14                	sd	a3,24(s0)
 6de:	f018                	sd	a4,32(s0)
 6e0:	f41c                	sd	a5,40(s0)
 6e2:	03043823          	sd	a6,48(s0)
 6e6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6ea:	00840613          	addi	a2,s0,8
 6ee:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6f2:	85aa                	mv	a1,a0
 6f4:	4505                	li	a0,1
 6f6:	00000097          	auipc	ra,0x0
 6fa:	dd2080e7          	jalr	-558(ra) # 4c8 <vprintf>
}
 6fe:	60e2                	ld	ra,24(sp)
 700:	6442                	ld	s0,16(sp)
 702:	6125                	addi	sp,sp,96
 704:	8082                	ret

0000000000000706 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 706:	1141                	addi	sp,sp,-16
 708:	e422                	sd	s0,8(sp)
 70a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 70c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 710:	00000797          	auipc	a5,0x0
 714:	1c878793          	addi	a5,a5,456 # 8d8 <__DATA_BEGIN__>
 718:	639c                	ld	a5,0(a5)
 71a:	a805                	j	74a <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 71c:	4618                	lw	a4,8(a2)
 71e:	9db9                	addw	a1,a1,a4
 720:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 724:	6398                	ld	a4,0(a5)
 726:	6318                	ld	a4,0(a4)
 728:	fee53823          	sd	a4,-16(a0)
 72c:	a091                	j	770 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 72e:	ff852703          	lw	a4,-8(a0)
 732:	9e39                	addw	a2,a2,a4
 734:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 736:	ff053703          	ld	a4,-16(a0)
 73a:	e398                	sd	a4,0(a5)
 73c:	a099                	j	782 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73e:	6398                	ld	a4,0(a5)
 740:	00e7e463          	bltu	a5,a4,748 <free+0x42>
 744:	00e6ea63          	bltu	a3,a4,758 <free+0x52>
{
 748:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	fed7fae3          	bgeu	a5,a3,73e <free+0x38>
 74e:	6398                	ld	a4,0(a5)
 750:	00e6e463          	bltu	a3,a4,758 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	fee7eae3          	bltu	a5,a4,748 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 758:	ff852583          	lw	a1,-8(a0)
 75c:	6390                	ld	a2,0(a5)
 75e:	02059713          	slli	a4,a1,0x20
 762:	9301                	srli	a4,a4,0x20
 764:	0712                	slli	a4,a4,0x4
 766:	9736                	add	a4,a4,a3
 768:	fae60ae3          	beq	a2,a4,71c <free+0x16>
    bp->s.ptr = p->s.ptr;
 76c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 770:	4790                	lw	a2,8(a5)
 772:	02061713          	slli	a4,a2,0x20
 776:	9301                	srli	a4,a4,0x20
 778:	0712                	slli	a4,a4,0x4
 77a:	973e                	add	a4,a4,a5
 77c:	fae689e3          	beq	a3,a4,72e <free+0x28>
  } else
    p->s.ptr = bp;
 780:	e394                	sd	a3,0(a5)
  freep = p;
 782:	00000717          	auipc	a4,0x0
 786:	14f73b23          	sd	a5,342(a4) # 8d8 <__DATA_BEGIN__>
}
 78a:	6422                	ld	s0,8(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret

0000000000000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	7139                	addi	sp,sp,-64
 792:	fc06                	sd	ra,56(sp)
 794:	f822                	sd	s0,48(sp)
 796:	f426                	sd	s1,40(sp)
 798:	f04a                	sd	s2,32(sp)
 79a:	ec4e                	sd	s3,24(sp)
 79c:	e852                	sd	s4,16(sp)
 79e:	e456                	sd	s5,8(sp)
 7a0:	e05a                	sd	s6,0(sp)
 7a2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a4:	02051993          	slli	s3,a0,0x20
 7a8:	0209d993          	srli	s3,s3,0x20
 7ac:	09bd                	addi	s3,s3,15
 7ae:	0049d993          	srli	s3,s3,0x4
 7b2:	2985                	addiw	s3,s3,1
 7b4:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 7b8:	00000797          	auipc	a5,0x0
 7bc:	12078793          	addi	a5,a5,288 # 8d8 <__DATA_BEGIN__>
 7c0:	6388                	ld	a0,0(a5)
 7c2:	c515                	beqz	a0,7ee <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c6:	4798                	lw	a4,8(a5)
 7c8:	03277f63          	bgeu	a4,s2,806 <malloc+0x76>
 7cc:	8a4e                	mv	s4,s3
 7ce:	0009871b          	sext.w	a4,s3
 7d2:	6685                	lui	a3,0x1
 7d4:	00d77363          	bgeu	a4,a3,7da <malloc+0x4a>
 7d8:	6a05                	lui	s4,0x1
 7da:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 7de:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e2:	00000497          	auipc	s1,0x0
 7e6:	0f648493          	addi	s1,s1,246 # 8d8 <__DATA_BEGIN__>
  if(p == (char*)-1)
 7ea:	5b7d                	li	s6,-1
 7ec:	a885                	j	85c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7ee:	00000797          	auipc	a5,0x0
 7f2:	0f278793          	addi	a5,a5,242 # 8e0 <base>
 7f6:	00000717          	auipc	a4,0x0
 7fa:	0ef73123          	sd	a5,226(a4) # 8d8 <__DATA_BEGIN__>
 7fe:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 800:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 804:	b7e1                	j	7cc <malloc+0x3c>
      if(p->s.size == nunits)
 806:	02e90b63          	beq	s2,a4,83c <malloc+0xac>
        p->s.size -= nunits;
 80a:	4137073b          	subw	a4,a4,s3
 80e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 810:	1702                	slli	a4,a4,0x20
 812:	9301                	srli	a4,a4,0x20
 814:	0712                	slli	a4,a4,0x4
 816:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 818:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 81c:	00000717          	auipc	a4,0x0
 820:	0aa73e23          	sd	a0,188(a4) # 8d8 <__DATA_BEGIN__>
      return (void*)(p + 1);
 824:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 828:	70e2                	ld	ra,56(sp)
 82a:	7442                	ld	s0,48(sp)
 82c:	74a2                	ld	s1,40(sp)
 82e:	7902                	ld	s2,32(sp)
 830:	69e2                	ld	s3,24(sp)
 832:	6a42                	ld	s4,16(sp)
 834:	6aa2                	ld	s5,8(sp)
 836:	6b02                	ld	s6,0(sp)
 838:	6121                	addi	sp,sp,64
 83a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 83c:	6398                	ld	a4,0(a5)
 83e:	e118                	sd	a4,0(a0)
 840:	bff1                	j	81c <malloc+0x8c>
  hp->s.size = nu;
 842:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 846:	0541                	addi	a0,a0,16
 848:	00000097          	auipc	ra,0x0
 84c:	ebe080e7          	jalr	-322(ra) # 706 <free>
  return freep;
 850:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 852:	d979                	beqz	a0,828 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 854:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 856:	4798                	lw	a4,8(a5)
 858:	fb2777e3          	bgeu	a4,s2,806 <malloc+0x76>
    if(p == freep)
 85c:	6098                	ld	a4,0(s1)
 85e:	853e                	mv	a0,a5
 860:	fef71ae3          	bne	a4,a5,854 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 864:	8552                	mv	a0,s4
 866:	00000097          	auipc	ra,0x0
 86a:	b3c080e7          	jalr	-1220(ra) # 3a2 <sbrk>
  if(p == (char*)-1)
 86e:	fd651ae3          	bne	a0,s6,842 <malloc+0xb2>
        return 0;
 872:	4501                	li	a0,0
 874:	bf55                	j	828 <malloc+0x98>
