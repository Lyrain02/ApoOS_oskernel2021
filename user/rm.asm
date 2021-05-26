
xv6-user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
  int i;

  if(argc < 2){
   e:	4785                	li	a5,1
  10:	02a7d163          	bge	a5,a0,32 <main+0x32>
  14:	00858493          	addi	s1,a1,8
  18:	ffe5091b          	addiw	s2,a0,-2
  1c:	1902                	slli	s2,s2,0x20
  1e:	02095913          	srli	s2,s2,0x20
  22:	090e                	slli	s2,s2,0x3
  24:	05c1                	addi	a1,a1,16
  26:	992e                	add	s2,s2,a1
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(remove(argv[i]) < 0){
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  28:	00001997          	auipc	s3,0x1
  2c:	86898993          	addi	s3,s3,-1944 # 890 <malloc+0x100>
  30:	a015                	j	54 <main+0x54>
    fprintf(2, "Usage: rm files...\n");
  32:	00001597          	auipc	a1,0x1
  36:	84658593          	addi	a1,a1,-1978 # 878 <malloc+0xe8>
  3a:	4509                	li	a0,2
  3c:	00000097          	auipc	ra,0x0
  40:	668080e7          	jalr	1640(ra) # 6a4 <fprintf>
    exit(1);
  44:	4505                	li	a0,1
  46:	00000097          	auipc	ra,0x0
  4a:	2ee080e7          	jalr	750(ra) # 334 <exit>
  for(i = 1; i < argc; i++){
  4e:	04a1                	addi	s1,s1,8
  50:	03248163          	beq	s1,s2,72 <main+0x72>
    if(remove(argv[i]) < 0){
  54:	6088                	ld	a0,0(s1)
  56:	00000097          	auipc	ra,0x0
  5a:	386080e7          	jalr	902(ra) # 3dc <remove>
  5e:	fe0558e3          	bgez	a0,4e <main+0x4e>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  62:	6090                	ld	a2,0(s1)
  64:	85ce                	mv	a1,s3
  66:	4509                	li	a0,2
  68:	00000097          	auipc	ra,0x0
  6c:	63c080e7          	jalr	1596(ra) # 6a4 <fprintf>
  70:	bff9                	j	4e <main+0x4e>
    }
  }

  exit(0);
  72:	4501                	li	a0,0
  74:	00000097          	auipc	ra,0x0
  78:	2c0080e7          	jalr	704(ra) # 334 <exit>

000000000000007c <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e422                	sd	s0,8(sp)
  80:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  82:	87aa                	mv	a5,a0
  84:	0585                	addi	a1,a1,1
  86:	0785                	addi	a5,a5,1
  88:	fff5c703          	lbu	a4,-1(a1)
  8c:	fee78fa3          	sb	a4,-1(a5)
  90:	fb75                	bnez	a4,84 <strcpy+0x8>
    ;
  return os;
}
  92:	6422                	ld	s0,8(sp)
  94:	0141                	addi	sp,sp,16
  96:	8082                	ret

0000000000000098 <strcat>:

char*
strcat(char *s, const char *t)
{
  98:	1141                	addi	sp,sp,-16
  9a:	e422                	sd	s0,8(sp)
  9c:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  9e:	00054783          	lbu	a5,0(a0)
  a2:	c385                	beqz	a5,c2 <strcat+0x2a>
  a4:	87aa                	mv	a5,a0
    s++;
  a6:	0785                	addi	a5,a5,1
  while(*s)
  a8:	0007c703          	lbu	a4,0(a5)
  ac:	ff6d                	bnez	a4,a6 <strcat+0xe>
  while((*s++ = *t++))
  ae:	0585                	addi	a1,a1,1
  b0:	0785                	addi	a5,a5,1
  b2:	fff5c703          	lbu	a4,-1(a1)
  b6:	fee78fa3          	sb	a4,-1(a5)
  ba:	fb75                	bnez	a4,ae <strcat+0x16>
    ;
  return os;
}
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret
  while(*s)
  c2:	87aa                	mv	a5,a0
  c4:	b7ed                	j	ae <strcat+0x16>

00000000000000c6 <strcmp>:


int
strcmp(const char *p, const char *q)
{
  c6:	1141                	addi	sp,sp,-16
  c8:	e422                	sd	s0,8(sp)
  ca:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  cc:	00054783          	lbu	a5,0(a0)
  d0:	cb91                	beqz	a5,e4 <strcmp+0x1e>
  d2:	0005c703          	lbu	a4,0(a1)
  d6:	00f71763          	bne	a4,a5,e4 <strcmp+0x1e>
    p++, q++;
  da:	0505                	addi	a0,a0,1
  dc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  de:	00054783          	lbu	a5,0(a0)
  e2:	fbe5                	bnez	a5,d2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  e4:	0005c503          	lbu	a0,0(a1)
}
  e8:	40a7853b          	subw	a0,a5,a0
  ec:	6422                	ld	s0,8(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret

00000000000000f2 <strlen>:

uint
strlen(const char *s)
{
  f2:	1141                	addi	sp,sp,-16
  f4:	e422                	sd	s0,8(sp)
  f6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f8:	00054783          	lbu	a5,0(a0)
  fc:	cf91                	beqz	a5,118 <strlen+0x26>
  fe:	0505                	addi	a0,a0,1
 100:	87aa                	mv	a5,a0
 102:	4685                	li	a3,1
 104:	9e89                	subw	a3,a3,a0
 106:	00f6853b          	addw	a0,a3,a5
 10a:	0785                	addi	a5,a5,1
 10c:	fff7c703          	lbu	a4,-1(a5)
 110:	fb7d                	bnez	a4,106 <strlen+0x14>
    ;
  return n;
}
 112:	6422                	ld	s0,8(sp)
 114:	0141                	addi	sp,sp,16
 116:	8082                	ret
  for(n = 0; s[n]; n++)
 118:	4501                	li	a0,0
 11a:	bfe5                	j	112 <strlen+0x20>

000000000000011c <memset>:

void*
memset(void *dst, int c, uint n)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e422                	sd	s0,8(sp)
 120:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 122:	ca19                	beqz	a2,138 <memset+0x1c>
 124:	87aa                	mv	a5,a0
 126:	1602                	slli	a2,a2,0x20
 128:	9201                	srli	a2,a2,0x20
 12a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 12e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 132:	0785                	addi	a5,a5,1
 134:	fee79de3          	bne	a5,a4,12e <memset+0x12>
  }
  return dst;
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret

000000000000013e <strchr>:

char*
strchr(const char *s, char c)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
  for(; *s; s++)
 144:	00054783          	lbu	a5,0(a0)
 148:	cb99                	beqz	a5,15e <strchr+0x20>
    if(*s == c)
 14a:	00f58763          	beq	a1,a5,158 <strchr+0x1a>
  for(; *s; s++)
 14e:	0505                	addi	a0,a0,1
 150:	00054783          	lbu	a5,0(a0)
 154:	fbfd                	bnez	a5,14a <strchr+0xc>
      return (char*)s;
  return 0;
 156:	4501                	li	a0,0
}
 158:	6422                	ld	s0,8(sp)
 15a:	0141                	addi	sp,sp,16
 15c:	8082                	ret
  return 0;
 15e:	4501                	li	a0,0
 160:	bfe5                	j	158 <strchr+0x1a>

0000000000000162 <gets>:

char*
gets(char *buf, int max)
{
 162:	711d                	addi	sp,sp,-96
 164:	ec86                	sd	ra,88(sp)
 166:	e8a2                	sd	s0,80(sp)
 168:	e4a6                	sd	s1,72(sp)
 16a:	e0ca                	sd	s2,64(sp)
 16c:	fc4e                	sd	s3,56(sp)
 16e:	f852                	sd	s4,48(sp)
 170:	f456                	sd	s5,40(sp)
 172:	f05a                	sd	s6,32(sp)
 174:	ec5e                	sd	s7,24(sp)
 176:	e862                	sd	s8,16(sp)
 178:	1080                	addi	s0,sp,96
 17a:	8baa                	mv	s7,a0
 17c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17e:	892a                	mv	s2,a0
 180:	4481                	li	s1,0
    cc = read(0, &c, 1);
 182:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 186:	4b29                	li	s6,10
 188:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 18a:	89a6                	mv	s3,s1
 18c:	2485                	addiw	s1,s1,1
 18e:	0344d763          	bge	s1,s4,1bc <gets+0x5a>
    cc = read(0, &c, 1);
 192:	4605                	li	a2,1
 194:	85d6                	mv	a1,s5
 196:	4501                	li	a0,0
 198:	00000097          	auipc	ra,0x0
 19c:	1b4080e7          	jalr	436(ra) # 34c <read>
    if(cc < 1)
 1a0:	00a05e63          	blez	a0,1bc <gets+0x5a>
    buf[i++] = c;
 1a4:	faf44783          	lbu	a5,-81(s0)
 1a8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ac:	01678763          	beq	a5,s6,1ba <gets+0x58>
 1b0:	0905                	addi	s2,s2,1
 1b2:	fd879ce3          	bne	a5,s8,18a <gets+0x28>
  for(i=0; i+1 < max; ){
 1b6:	89a6                	mv	s3,s1
 1b8:	a011                	j	1bc <gets+0x5a>
 1ba:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1bc:	99de                	add	s3,s3,s7
 1be:	00098023          	sb	zero,0(s3)
  return buf;
}
 1c2:	855e                	mv	a0,s7
 1c4:	60e6                	ld	ra,88(sp)
 1c6:	6446                	ld	s0,80(sp)
 1c8:	64a6                	ld	s1,72(sp)
 1ca:	6906                	ld	s2,64(sp)
 1cc:	79e2                	ld	s3,56(sp)
 1ce:	7a42                	ld	s4,48(sp)
 1d0:	7aa2                	ld	s5,40(sp)
 1d2:	7b02                	ld	s6,32(sp)
 1d4:	6be2                	ld	s7,24(sp)
 1d6:	6c42                	ld	s8,16(sp)
 1d8:	6125                	addi	sp,sp,96
 1da:	8082                	ret

00000000000001dc <stat>:

int
stat(const char *n, struct stat *st)
{
 1dc:	1101                	addi	sp,sp,-32
 1de:	ec06                	sd	ra,24(sp)
 1e0:	e822                	sd	s0,16(sp)
 1e2:	e426                	sd	s1,8(sp)
 1e4:	e04a                	sd	s2,0(sp)
 1e6:	1000                	addi	s0,sp,32
 1e8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ea:	4581                	li	a1,0
 1ec:	00000097          	auipc	ra,0x0
 1f0:	188080e7          	jalr	392(ra) # 374 <open>
  if(fd < 0)
 1f4:	02054563          	bltz	a0,21e <stat+0x42>
 1f8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1fa:	85ca                	mv	a1,s2
 1fc:	00000097          	auipc	ra,0x0
 200:	180080e7          	jalr	384(ra) # 37c <fstat>
 204:	892a                	mv	s2,a0
  close(fd);
 206:	8526                	mv	a0,s1
 208:	00000097          	auipc	ra,0x0
 20c:	154080e7          	jalr	340(ra) # 35c <close>
  return r;
}
 210:	854a                	mv	a0,s2
 212:	60e2                	ld	ra,24(sp)
 214:	6442                	ld	s0,16(sp)
 216:	64a2                	ld	s1,8(sp)
 218:	6902                	ld	s2,0(sp)
 21a:	6105                	addi	sp,sp,32
 21c:	8082                	ret
    return -1;
 21e:	597d                	li	s2,-1
 220:	bfc5                	j	210 <stat+0x34>

0000000000000222 <atoi>:

int
atoi(const char *s)
{
 222:	1141                	addi	sp,sp,-16
 224:	e422                	sd	s0,8(sp)
 226:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 228:	00054703          	lbu	a4,0(a0)
 22c:	02d00793          	li	a5,45
  int neg = 1;
 230:	4805                	li	a6,1
  if (*s == '-') {
 232:	04f70363          	beq	a4,a5,278 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 236:	00054683          	lbu	a3,0(a0)
 23a:	fd06879b          	addiw	a5,a3,-48
 23e:	0ff7f793          	andi	a5,a5,255
 242:	4725                	li	a4,9
 244:	02f76d63          	bltu	a4,a5,27e <atoi+0x5c>
  n = 0;
 248:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 24a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 24c:	0505                	addi	a0,a0,1
 24e:	0026179b          	slliw	a5,a2,0x2
 252:	9fb1                	addw	a5,a5,a2
 254:	0017979b          	slliw	a5,a5,0x1
 258:	9fb5                	addw	a5,a5,a3
 25a:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 25e:	00054683          	lbu	a3,0(a0)
 262:	fd06871b          	addiw	a4,a3,-48
 266:	0ff77713          	andi	a4,a4,255
 26a:	fee5f1e3          	bgeu	a1,a4,24c <atoi+0x2a>
  return n * neg;
}
 26e:	02c8053b          	mulw	a0,a6,a2
 272:	6422                	ld	s0,8(sp)
 274:	0141                	addi	sp,sp,16
 276:	8082                	ret
    s++;
 278:	0505                	addi	a0,a0,1
    neg = -1;
 27a:	587d                	li	a6,-1
 27c:	bf6d                	j	236 <atoi+0x14>
  n = 0;
 27e:	4601                	li	a2,0
 280:	b7fd                	j	26e <atoi+0x4c>

0000000000000282 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 282:	1141                	addi	sp,sp,-16
 284:	e422                	sd	s0,8(sp)
 286:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 288:	02b57463          	bgeu	a0,a1,2b0 <memmove+0x2e>
    while(n-- > 0)
 28c:	00c05f63          	blez	a2,2aa <memmove+0x28>
 290:	1602                	slli	a2,a2,0x20
 292:	9201                	srli	a2,a2,0x20
 294:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 298:	872a                	mv	a4,a0
      *dst++ = *src++;
 29a:	0585                	addi	a1,a1,1
 29c:	0705                	addi	a4,a4,1
 29e:	fff5c683          	lbu	a3,-1(a1)
 2a2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2a6:	fee79ae3          	bne	a5,a4,29a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2aa:	6422                	ld	s0,8(sp)
 2ac:	0141                	addi	sp,sp,16
 2ae:	8082                	ret
    dst += n;
 2b0:	00c50733          	add	a4,a0,a2
    src += n;
 2b4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2b6:	fec05ae3          	blez	a2,2aa <memmove+0x28>
 2ba:	fff6079b          	addiw	a5,a2,-1
 2be:	1782                	slli	a5,a5,0x20
 2c0:	9381                	srli	a5,a5,0x20
 2c2:	fff7c793          	not	a5,a5
 2c6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c8:	15fd                	addi	a1,a1,-1
 2ca:	177d                	addi	a4,a4,-1
 2cc:	0005c683          	lbu	a3,0(a1)
 2d0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2d4:	fee79ae3          	bne	a5,a4,2c8 <memmove+0x46>
 2d8:	bfc9                	j	2aa <memmove+0x28>

00000000000002da <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2da:	1141                	addi	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2e0:	ca05                	beqz	a2,310 <memcmp+0x36>
 2e2:	fff6069b          	addiw	a3,a2,-1
 2e6:	1682                	slli	a3,a3,0x20
 2e8:	9281                	srli	a3,a3,0x20
 2ea:	0685                	addi	a3,a3,1
 2ec:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ee:	00054783          	lbu	a5,0(a0)
 2f2:	0005c703          	lbu	a4,0(a1)
 2f6:	00e79863          	bne	a5,a4,306 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2fa:	0505                	addi	a0,a0,1
    p2++;
 2fc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2fe:	fed518e3          	bne	a0,a3,2ee <memcmp+0x14>
  }
  return 0;
 302:	4501                	li	a0,0
 304:	a019                	j	30a <memcmp+0x30>
      return *p1 - *p2;
 306:	40e7853b          	subw	a0,a5,a4
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
  return 0;
 310:	4501                	li	a0,0
 312:	bfe5                	j	30a <memcmp+0x30>

0000000000000314 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 314:	1141                	addi	sp,sp,-16
 316:	e406                	sd	ra,8(sp)
 318:	e022                	sd	s0,0(sp)
 31a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 31c:	00000097          	auipc	ra,0x0
 320:	f66080e7          	jalr	-154(ra) # 282 <memmove>
}
 324:	60a2                	ld	ra,8(sp)
 326:	6402                	ld	s0,0(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 32c:	4885                	li	a7,1
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <exit>:
.global exit
exit:
 li a7, SYS_exit
 334:	4889                	li	a7,2
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <wait>:
.global wait
wait:
 li a7, SYS_wait
 33c:	488d                	li	a7,3
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 344:	4891                	li	a7,4
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <read>:
.global read
read:
 li a7, SYS_read
 34c:	4895                	li	a7,5
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <write>:
.global write
write:
 li a7, SYS_write
 354:	48c1                	li	a7,16
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <close>:
.global close
close:
 li a7, SYS_close
 35c:	48d5                	li	a7,21
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <kill>:
.global kill
kill:
 li a7, SYS_kill
 364:	4899                	li	a7,6
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <exec>:
.global exec
exec:
 li a7, SYS_exec
 36c:	489d                	li	a7,7
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <open>:
.global open
open:
 li a7, SYS_open
 374:	48bd                	li	a7,15
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 37c:	48a1                	li	a7,8
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 384:	48d1                	li	a7,20
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 38c:	48a5                	li	a7,9
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <dup>:
.global dup
dup:
 li a7, SYS_dup
 394:	48a9                	li	a7,10
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 39c:	48ad                	li	a7,11
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a4:	48b1                	li	a7,12
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ac:	48b5                	li	a7,13
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b4:	48b9                	li	a7,14
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3bc:	48d9                	li	a7,22
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <dev>:
.global dev
dev:
 li a7, SYS_dev
 3c4:	48dd                	li	a7,23
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3cc:	48e1                	li	a7,24
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3d4:	48e5                	li	a7,25
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <remove>:
.global remove
remove:
 li a7, SYS_remove
 3dc:	48c5                	li	a7,17
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3e4:	48c9                	li	a7,18
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3ec:	48cd                	li	a7,19
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <rename>:
.global rename
rename:
 li a7, SYS_rename
 3f4:	48e9                	li	a7,26
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3fc:	1101                	addi	sp,sp,-32
 3fe:	ec06                	sd	ra,24(sp)
 400:	e822                	sd	s0,16(sp)
 402:	1000                	addi	s0,sp,32
 404:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 408:	4605                	li	a2,1
 40a:	fef40593          	addi	a1,s0,-17
 40e:	00000097          	auipc	ra,0x0
 412:	f46080e7          	jalr	-186(ra) # 354 <write>
}
 416:	60e2                	ld	ra,24(sp)
 418:	6442                	ld	s0,16(sp)
 41a:	6105                	addi	sp,sp,32
 41c:	8082                	ret

000000000000041e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41e:	7139                	addi	sp,sp,-64
 420:	fc06                	sd	ra,56(sp)
 422:	f822                	sd	s0,48(sp)
 424:	f426                	sd	s1,40(sp)
 426:	f04a                	sd	s2,32(sp)
 428:	ec4e                	sd	s3,24(sp)
 42a:	0080                	addi	s0,sp,64
 42c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42e:	c299                	beqz	a3,434 <printint+0x16>
 430:	0805c763          	bltz	a1,4be <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 434:	2581                	sext.w	a1,a1
  neg = 0;
 436:	4881                	li	a7,0
  }

  i = 0;
 438:	fc040993          	addi	s3,s0,-64
  neg = 0;
 43c:	86ce                	mv	a3,s3
  i = 0;
 43e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 440:	2601                	sext.w	a2,a2
 442:	00000517          	auipc	a0,0x0
 446:	47650513          	addi	a0,a0,1142 # 8b8 <digits>
 44a:	883a                	mv	a6,a4
 44c:	2705                	addiw	a4,a4,1
 44e:	02c5f7bb          	remuw	a5,a1,a2
 452:	1782                	slli	a5,a5,0x20
 454:	9381                	srli	a5,a5,0x20
 456:	97aa                	add	a5,a5,a0
 458:	0007c783          	lbu	a5,0(a5)
 45c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 460:	0005879b          	sext.w	a5,a1
 464:	02c5d5bb          	divuw	a1,a1,a2
 468:	0685                	addi	a3,a3,1
 46a:	fec7f0e3          	bgeu	a5,a2,44a <printint+0x2c>
  if(neg)
 46e:	00088b63          	beqz	a7,484 <printint+0x66>
    buf[i++] = '-';
 472:	fd040793          	addi	a5,s0,-48
 476:	973e                	add	a4,a4,a5
 478:	02d00793          	li	a5,45
 47c:	fef70823          	sb	a5,-16(a4)
 480:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 484:	02e05663          	blez	a4,4b0 <printint+0x92>
 488:	fc040913          	addi	s2,s0,-64
 48c:	993a                	add	s2,s2,a4
 48e:	19fd                	addi	s3,s3,-1
 490:	99ba                	add	s3,s3,a4
 492:	377d                	addiw	a4,a4,-1
 494:	1702                	slli	a4,a4,0x20
 496:	9301                	srli	a4,a4,0x20
 498:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 49c:	fff94583          	lbu	a1,-1(s2)
 4a0:	8526                	mv	a0,s1
 4a2:	00000097          	auipc	ra,0x0
 4a6:	f5a080e7          	jalr	-166(ra) # 3fc <putc>
  while(--i >= 0)
 4aa:	197d                	addi	s2,s2,-1
 4ac:	ff3918e3          	bne	s2,s3,49c <printint+0x7e>
}
 4b0:	70e2                	ld	ra,56(sp)
 4b2:	7442                	ld	s0,48(sp)
 4b4:	74a2                	ld	s1,40(sp)
 4b6:	7902                	ld	s2,32(sp)
 4b8:	69e2                	ld	s3,24(sp)
 4ba:	6121                	addi	sp,sp,64
 4bc:	8082                	ret
    x = -xx;
 4be:	40b005bb          	negw	a1,a1
    neg = 1;
 4c2:	4885                	li	a7,1
    x = -xx;
 4c4:	bf95                	j	438 <printint+0x1a>

00000000000004c6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c6:	7119                	addi	sp,sp,-128
 4c8:	fc86                	sd	ra,120(sp)
 4ca:	f8a2                	sd	s0,112(sp)
 4cc:	f4a6                	sd	s1,104(sp)
 4ce:	f0ca                	sd	s2,96(sp)
 4d0:	ecce                	sd	s3,88(sp)
 4d2:	e8d2                	sd	s4,80(sp)
 4d4:	e4d6                	sd	s5,72(sp)
 4d6:	e0da                	sd	s6,64(sp)
 4d8:	fc5e                	sd	s7,56(sp)
 4da:	f862                	sd	s8,48(sp)
 4dc:	f466                	sd	s9,40(sp)
 4de:	f06a                	sd	s10,32(sp)
 4e0:	ec6e                	sd	s11,24(sp)
 4e2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4e4:	0005c903          	lbu	s2,0(a1)
 4e8:	18090f63          	beqz	s2,686 <vprintf+0x1c0>
 4ec:	8aaa                	mv	s5,a0
 4ee:	8b32                	mv	s6,a2
 4f0:	00158493          	addi	s1,a1,1
  state = 0;
 4f4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f6:	02500a13          	li	s4,37
      if(c == 'd'){
 4fa:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4fe:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 502:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 506:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 50a:	00000b97          	auipc	s7,0x0
 50e:	3aeb8b93          	addi	s7,s7,942 # 8b8 <digits>
 512:	a839                	j	530 <vprintf+0x6a>
        putc(fd, c);
 514:	85ca                	mv	a1,s2
 516:	8556                	mv	a0,s5
 518:	00000097          	auipc	ra,0x0
 51c:	ee4080e7          	jalr	-284(ra) # 3fc <putc>
 520:	a019                	j	526 <vprintf+0x60>
    } else if(state == '%'){
 522:	01498f63          	beq	s3,s4,540 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 526:	0485                	addi	s1,s1,1
 528:	fff4c903          	lbu	s2,-1(s1)
 52c:	14090d63          	beqz	s2,686 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 530:	0009079b          	sext.w	a5,s2
    if(state == 0){
 534:	fe0997e3          	bnez	s3,522 <vprintf+0x5c>
      if(c == '%'){
 538:	fd479ee3          	bne	a5,s4,514 <vprintf+0x4e>
        state = '%';
 53c:	89be                	mv	s3,a5
 53e:	b7e5                	j	526 <vprintf+0x60>
      if(c == 'd'){
 540:	05878063          	beq	a5,s8,580 <vprintf+0xba>
      } else if(c == 'l') {
 544:	05978c63          	beq	a5,s9,59c <vprintf+0xd6>
      } else if(c == 'x') {
 548:	07a78863          	beq	a5,s10,5b8 <vprintf+0xf2>
      } else if(c == 'p') {
 54c:	09b78463          	beq	a5,s11,5d4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 550:	07300713          	li	a4,115
 554:	0ce78663          	beq	a5,a4,620 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 558:	06300713          	li	a4,99
 55c:	0ee78e63          	beq	a5,a4,658 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 560:	11478863          	beq	a5,s4,670 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 564:	85d2                	mv	a1,s4
 566:	8556                	mv	a0,s5
 568:	00000097          	auipc	ra,0x0
 56c:	e94080e7          	jalr	-364(ra) # 3fc <putc>
        putc(fd, c);
 570:	85ca                	mv	a1,s2
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	e88080e7          	jalr	-376(ra) # 3fc <putc>
      }
      state = 0;
 57c:	4981                	li	s3,0
 57e:	b765                	j	526 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 580:	008b0913          	addi	s2,s6,8
 584:	4685                	li	a3,1
 586:	4629                	li	a2,10
 588:	000b2583          	lw	a1,0(s6)
 58c:	8556                	mv	a0,s5
 58e:	00000097          	auipc	ra,0x0
 592:	e90080e7          	jalr	-368(ra) # 41e <printint>
 596:	8b4a                	mv	s6,s2
      state = 0;
 598:	4981                	li	s3,0
 59a:	b771                	j	526 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 59c:	008b0913          	addi	s2,s6,8
 5a0:	4681                	li	a3,0
 5a2:	4629                	li	a2,10
 5a4:	000b2583          	lw	a1,0(s6)
 5a8:	8556                	mv	a0,s5
 5aa:	00000097          	auipc	ra,0x0
 5ae:	e74080e7          	jalr	-396(ra) # 41e <printint>
 5b2:	8b4a                	mv	s6,s2
      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	bf85                	j	526 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5b8:	008b0913          	addi	s2,s6,8
 5bc:	4681                	li	a3,0
 5be:	4641                	li	a2,16
 5c0:	000b2583          	lw	a1,0(s6)
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	e58080e7          	jalr	-424(ra) # 41e <printint>
 5ce:	8b4a                	mv	s6,s2
      state = 0;
 5d0:	4981                	li	s3,0
 5d2:	bf91                	j	526 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5d4:	008b0793          	addi	a5,s6,8
 5d8:	f8f43423          	sd	a5,-120(s0)
 5dc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5e0:	03000593          	li	a1,48
 5e4:	8556                	mv	a0,s5
 5e6:	00000097          	auipc	ra,0x0
 5ea:	e16080e7          	jalr	-490(ra) # 3fc <putc>
  putc(fd, 'x');
 5ee:	85ea                	mv	a1,s10
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	e0a080e7          	jalr	-502(ra) # 3fc <putc>
 5fa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5fc:	03c9d793          	srli	a5,s3,0x3c
 600:	97de                	add	a5,a5,s7
 602:	0007c583          	lbu	a1,0(a5)
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	df4080e7          	jalr	-524(ra) # 3fc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 610:	0992                	slli	s3,s3,0x4
 612:	397d                	addiw	s2,s2,-1
 614:	fe0914e3          	bnez	s2,5fc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 618:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 61c:	4981                	li	s3,0
 61e:	b721                	j	526 <vprintf+0x60>
        s = va_arg(ap, char*);
 620:	008b0993          	addi	s3,s6,8
 624:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 628:	02090163          	beqz	s2,64a <vprintf+0x184>
        while(*s != 0){
 62c:	00094583          	lbu	a1,0(s2)
 630:	c9a1                	beqz	a1,680 <vprintf+0x1ba>
          putc(fd, *s);
 632:	8556                	mv	a0,s5
 634:	00000097          	auipc	ra,0x0
 638:	dc8080e7          	jalr	-568(ra) # 3fc <putc>
          s++;
 63c:	0905                	addi	s2,s2,1
        while(*s != 0){
 63e:	00094583          	lbu	a1,0(s2)
 642:	f9e5                	bnez	a1,632 <vprintf+0x16c>
        s = va_arg(ap, char*);
 644:	8b4e                	mv	s6,s3
      state = 0;
 646:	4981                	li	s3,0
 648:	bdf9                	j	526 <vprintf+0x60>
          s = "(null)";
 64a:	00000917          	auipc	s2,0x0
 64e:	26690913          	addi	s2,s2,614 # 8b0 <malloc+0x120>
        while(*s != 0){
 652:	02800593          	li	a1,40
 656:	bff1                	j	632 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 658:	008b0913          	addi	s2,s6,8
 65c:	000b4583          	lbu	a1,0(s6)
 660:	8556                	mv	a0,s5
 662:	00000097          	auipc	ra,0x0
 666:	d9a080e7          	jalr	-614(ra) # 3fc <putc>
 66a:	8b4a                	mv	s6,s2
      state = 0;
 66c:	4981                	li	s3,0
 66e:	bd65                	j	526 <vprintf+0x60>
        putc(fd, c);
 670:	85d2                	mv	a1,s4
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	d88080e7          	jalr	-632(ra) # 3fc <putc>
      state = 0;
 67c:	4981                	li	s3,0
 67e:	b565                	j	526 <vprintf+0x60>
        s = va_arg(ap, char*);
 680:	8b4e                	mv	s6,s3
      state = 0;
 682:	4981                	li	s3,0
 684:	b54d                	j	526 <vprintf+0x60>
    }
  }
}
 686:	70e6                	ld	ra,120(sp)
 688:	7446                	ld	s0,112(sp)
 68a:	74a6                	ld	s1,104(sp)
 68c:	7906                	ld	s2,96(sp)
 68e:	69e6                	ld	s3,88(sp)
 690:	6a46                	ld	s4,80(sp)
 692:	6aa6                	ld	s5,72(sp)
 694:	6b06                	ld	s6,64(sp)
 696:	7be2                	ld	s7,56(sp)
 698:	7c42                	ld	s8,48(sp)
 69a:	7ca2                	ld	s9,40(sp)
 69c:	7d02                	ld	s10,32(sp)
 69e:	6de2                	ld	s11,24(sp)
 6a0:	6109                	addi	sp,sp,128
 6a2:	8082                	ret

00000000000006a4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6a4:	715d                	addi	sp,sp,-80
 6a6:	ec06                	sd	ra,24(sp)
 6a8:	e822                	sd	s0,16(sp)
 6aa:	1000                	addi	s0,sp,32
 6ac:	e010                	sd	a2,0(s0)
 6ae:	e414                	sd	a3,8(s0)
 6b0:	e818                	sd	a4,16(s0)
 6b2:	ec1c                	sd	a5,24(s0)
 6b4:	03043023          	sd	a6,32(s0)
 6b8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6bc:	8622                	mv	a2,s0
 6be:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6c2:	00000097          	auipc	ra,0x0
 6c6:	e04080e7          	jalr	-508(ra) # 4c6 <vprintf>
}
 6ca:	60e2                	ld	ra,24(sp)
 6cc:	6442                	ld	s0,16(sp)
 6ce:	6161                	addi	sp,sp,80
 6d0:	8082                	ret

00000000000006d2 <printf>:

void
printf(const char *fmt, ...)
{
 6d2:	711d                	addi	sp,sp,-96
 6d4:	ec06                	sd	ra,24(sp)
 6d6:	e822                	sd	s0,16(sp)
 6d8:	1000                	addi	s0,sp,32
 6da:	e40c                	sd	a1,8(s0)
 6dc:	e810                	sd	a2,16(s0)
 6de:	ec14                	sd	a3,24(s0)
 6e0:	f018                	sd	a4,32(s0)
 6e2:	f41c                	sd	a5,40(s0)
 6e4:	03043823          	sd	a6,48(s0)
 6e8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6ec:	00840613          	addi	a2,s0,8
 6f0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6f4:	85aa                	mv	a1,a0
 6f6:	4505                	li	a0,1
 6f8:	00000097          	auipc	ra,0x0
 6fc:	dce080e7          	jalr	-562(ra) # 4c6 <vprintf>
}
 700:	60e2                	ld	ra,24(sp)
 702:	6442                	ld	s0,16(sp)
 704:	6125                	addi	sp,sp,96
 706:	8082                	ret

0000000000000708 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 708:	1141                	addi	sp,sp,-16
 70a:	e422                	sd	s0,8(sp)
 70c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 70e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 712:	00000797          	auipc	a5,0x0
 716:	1be7b783          	ld	a5,446(a5) # 8d0 <freep>
 71a:	a805                	j	74a <free+0x42>
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
 72c:	a091                	j	770 <free+0x68>
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
 73c:	a099                	j	782 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73e:	6398                	ld	a4,0(a5)
 740:	00e7e463          	bltu	a5,a4,748 <free+0x40>
 744:	00e6ea63          	bltu	a3,a4,758 <free+0x50>
{
 748:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	fed7fae3          	bgeu	a5,a3,73e <free+0x36>
 74e:	6398                	ld	a4,0(a5)
 750:	00e6e463          	bltu	a3,a4,758 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	fee7eae3          	bltu	a5,a4,748 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 758:	ff852583          	lw	a1,-8(a0)
 75c:	6390                	ld	a2,0(a5)
 75e:	02059713          	slli	a4,a1,0x20
 762:	9301                	srli	a4,a4,0x20
 764:	0712                	slli	a4,a4,0x4
 766:	9736                	add	a4,a4,a3
 768:	fae60ae3          	beq	a2,a4,71c <free+0x14>
    bp->s.ptr = p->s.ptr;
 76c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 770:	4790                	lw	a2,8(a5)
 772:	02061713          	slli	a4,a2,0x20
 776:	9301                	srli	a4,a4,0x20
 778:	0712                	slli	a4,a4,0x4
 77a:	973e                	add	a4,a4,a5
 77c:	fae689e3          	beq	a3,a4,72e <free+0x26>
  } else
    p->s.ptr = bp;
 780:	e394                	sd	a3,0(a5)
  freep = p;
 782:	00000717          	auipc	a4,0x0
 786:	14f73723          	sd	a5,334(a4) # 8d0 <freep>
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
 7a4:	02051493          	slli	s1,a0,0x20
 7a8:	9081                	srli	s1,s1,0x20
 7aa:	04bd                	addi	s1,s1,15
 7ac:	8091                	srli	s1,s1,0x4
 7ae:	0014899b          	addiw	s3,s1,1
 7b2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7b4:	00000517          	auipc	a0,0x0
 7b8:	11c53503          	ld	a0,284(a0) # 8d0 <freep>
 7bc:	c515                	beqz	a0,7e8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7be:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c0:	4798                	lw	a4,8(a5)
 7c2:	04977163          	bgeu	a4,s1,804 <malloc+0x74>
 7c6:	8a4e                	mv	s4,s3
 7c8:	0009871b          	sext.w	a4,s3
 7cc:	6685                	lui	a3,0x1
 7ce:	00d77363          	bgeu	a4,a3,7d4 <malloc+0x44>
 7d2:	6a05                	lui	s4,0x1
 7d4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7d8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7dc:	00000917          	auipc	s2,0x0
 7e0:	0f490913          	addi	s2,s2,244 # 8d0 <freep>
  if(p == (char*)-1)
 7e4:	5afd                	li	s5,-1
 7e6:	a89d                	j	85c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7e8:	00000797          	auipc	a5,0x0
 7ec:	0e878793          	addi	a5,a5,232 # 8d0 <freep>
 7f0:	00000717          	auipc	a4,0x0
 7f4:	0e870713          	addi	a4,a4,232 # 8d8 <base>
 7f8:	e398                	sd	a4,0(a5)
 7fa:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 7fc:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 800:	87ba                	mv	a5,a4
 802:	b7d1                	j	7c6 <malloc+0x36>
      if(p->s.size == nunits)
 804:	02e48b63          	beq	s1,a4,83a <malloc+0xaa>
        p->s.size -= nunits;
 808:	4137073b          	subw	a4,a4,s3
 80c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 80e:	1702                	slli	a4,a4,0x20
 810:	9301                	srli	a4,a4,0x20
 812:	0712                	slli	a4,a4,0x4
 814:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 816:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 81a:	00000717          	auipc	a4,0x0
 81e:	0aa73b23          	sd	a0,182(a4) # 8d0 <freep>
      return (void*)(p + 1);
 822:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 826:	70e2                	ld	ra,56(sp)
 828:	7442                	ld	s0,48(sp)
 82a:	74a2                	ld	s1,40(sp)
 82c:	7902                	ld	s2,32(sp)
 82e:	69e2                	ld	s3,24(sp)
 830:	6a42                	ld	s4,16(sp)
 832:	6aa2                	ld	s5,8(sp)
 834:	6b02                	ld	s6,0(sp)
 836:	6121                	addi	sp,sp,64
 838:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 83a:	6398                	ld	a4,0(a5)
 83c:	e118                	sd	a4,0(a0)
 83e:	bff1                	j	81a <malloc+0x8a>
  hp->s.size = nu;
 840:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 844:	0541                	addi	a0,a0,16
 846:	00000097          	auipc	ra,0x0
 84a:	ec2080e7          	jalr	-318(ra) # 708 <free>
  return freep;
 84e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 852:	d971                	beqz	a0,826 <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 854:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 856:	4798                	lw	a4,8(a5)
 858:	fa9776e3          	bgeu	a4,s1,804 <malloc+0x74>
    if(p == freep)
 85c:	00093703          	ld	a4,0(s2)
 860:	853e                	mv	a0,a5
 862:	fef719e3          	bne	a4,a5,854 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 866:	8552                	mv	a0,s4
 868:	00000097          	auipc	ra,0x0
 86c:	b3c080e7          	jalr	-1220(ra) # 3a4 <sbrk>
  if(p == (char*)-1)
 870:	fd5518e3          	bne	a0,s5,840 <malloc+0xb0>
        return 0;
 874:	4501                	li	a0,0
 876:	bf45                	j	826 <malloc+0x96>
