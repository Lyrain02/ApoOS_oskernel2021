
xv6-user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <test>:

const int test_c = 31;

char *test_name[] = {"write","getcwd","getpid","brk","chdir","execve","clone","open","pipe","read","close","openat","dup","exit","fork","getdents","getppid","gettimeofday","mkdir_","mmap","mount","munmap","times","umount","uname","unlink","wait","waitpid","yield","fstat","dup2"};

void test(char* name) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
  int pid = fork();
   c:	00000097          	auipc	ra,0x0
  10:	3c8080e7          	jalr	968(ra) # 3d4 <fork>
  char *argv[2];
  if (pid == 0) {
  14:	ed19                	bnez	a0,32 <test+0x32>
    argv[0] = name;
  16:	fc943823          	sd	s1,-48(s0)
    exec(name, argv);
  1a:	fd040593          	addi	a1,s0,-48
  1e:	8526                	mv	a0,s1
  20:	00000097          	auipc	ra,0x0
  24:	3fe080e7          	jalr	1022(ra) # 41e <exec>
  } else {
    wait(0);
  }
}
  28:	70a2                	ld	ra,40(sp)
  2a:	7402                	ld	s0,32(sp)
  2c:	64e2                	ld	s1,24(sp)
  2e:	6145                	addi	sp,sp,48
  30:	8082                	ret
    wait(0);
  32:	4501                	li	a0,0
  34:	00000097          	auipc	ra,0x0
  38:	3b2080e7          	jalr	946(ra) # 3e6 <wait>
}
  3c:	b7f5                	j	28 <test+0x28>

000000000000003e <main>:

int
main(void)
{
  3e:	1101                	addi	sp,sp,-32
  40:	ec06                	sd	ra,24(sp)
  42:	e822                	sd	s0,16(sp)
  44:	e426                	sd	s1,8(sp)
  46:	e04a                	sd	s2,0(sp)
  48:	1000                	addi	s0,sp,32
  dev(O_RDWR, 1, 0);
  4a:	4601                	li	a2,0
  4c:	4585                	li	a1,1
  4e:	4509                	li	a0,2
  50:	00000097          	auipc	ra,0x0
  54:	42c080e7          	jalr	1068(ra) # 47c <dev>
  dup(0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	3f0080e7          	jalr	1008(ra) # 44a <dup>
  dup(0);
  62:	4501                	li	a0,0
  64:	00000097          	auipc	ra,0x0
  68:	3e6080e7          	jalr	998(ra) # 44a <dup>

  int i;
  for (i = 0; i < test_c; i++) {
  6c:	00001497          	auipc	s1,0x1
  70:	9f448493          	addi	s1,s1,-1548 # a60 <test_name>
  74:	00001917          	auipc	s2,0x1
  78:	ae490913          	addi	s2,s2,-1308 # b58 <test_c>
    test(test_name[i]);
  7c:	6088                	ld	a0,0(s1)
  7e:	00000097          	auipc	ra,0x0
  82:	f82080e7          	jalr	-126(ra) # 0 <test>
  86:	04a1                	addi	s1,s1,8
  for (i = 0; i < test_c; i++) {
  88:	ff249ae3          	bne	s1,s2,7c <main+0x3e>
  }

  for(;;);
  8c:	a001                	j	8c <main+0x4e>

000000000000008e <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e422                	sd	s0,8(sp)
  92:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  94:	87aa                	mv	a5,a0
  96:	0585                	addi	a1,a1,1
  98:	0785                	addi	a5,a5,1
  9a:	fff5c703          	lbu	a4,-1(a1)
  9e:	fee78fa3          	sb	a4,-1(a5)
  a2:	fb75                	bnez	a4,96 <strcpy+0x8>
    ;
  return os;
}
  a4:	6422                	ld	s0,8(sp)
  a6:	0141                	addi	sp,sp,16
  a8:	8082                	ret

00000000000000aa <strcat>:

char*
strcat(char *s, const char *t)
{
  aa:	1141                	addi	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  b0:	00054783          	lbu	a5,0(a0)
  b4:	c385                	beqz	a5,d4 <strcat+0x2a>
  b6:	87aa                	mv	a5,a0
    s++;
  b8:	0785                	addi	a5,a5,1
  while(*s)
  ba:	0007c703          	lbu	a4,0(a5)
  be:	ff6d                	bnez	a4,b8 <strcat+0xe>
  while((*s++ = *t++))
  c0:	0585                	addi	a1,a1,1
  c2:	0785                	addi	a5,a5,1
  c4:	fff5c703          	lbu	a4,-1(a1)
  c8:	fee78fa3          	sb	a4,-1(a5)
  cc:	fb75                	bnez	a4,c0 <strcat+0x16>
    ;
  return os;
}
  ce:	6422                	ld	s0,8(sp)
  d0:	0141                	addi	sp,sp,16
  d2:	8082                	ret
  while(*s)
  d4:	87aa                	mv	a5,a0
  d6:	b7ed                	j	c0 <strcat+0x16>

00000000000000d8 <strcmp>:


int
strcmp(const char *p, const char *q)
{
  d8:	1141                	addi	sp,sp,-16
  da:	e422                	sd	s0,8(sp)
  dc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  de:	00054783          	lbu	a5,0(a0)
  e2:	cf91                	beqz	a5,fe <strcmp+0x26>
  e4:	0005c703          	lbu	a4,0(a1)
  e8:	00f71b63          	bne	a4,a5,fe <strcmp+0x26>
    p++, q++;
  ec:	0505                	addi	a0,a0,1
  ee:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  f0:	00054783          	lbu	a5,0(a0)
  f4:	c789                	beqz	a5,fe <strcmp+0x26>
  f6:	0005c703          	lbu	a4,0(a1)
  fa:	fef709e3          	beq	a4,a5,ec <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  fe:	0005c503          	lbu	a0,0(a1)
}
 102:	40a7853b          	subw	a0,a5,a0
 106:	6422                	ld	s0,8(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret

000000000000010c <strlen>:

uint
strlen(const char *s)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 112:	00054783          	lbu	a5,0(a0)
 116:	cf91                	beqz	a5,132 <strlen+0x26>
 118:	0505                	addi	a0,a0,1
 11a:	87aa                	mv	a5,a0
 11c:	4685                	li	a3,1
 11e:	9e89                	subw	a3,a3,a0
    ;
 120:	00f6853b          	addw	a0,a3,a5
 124:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 126:	fff7c703          	lbu	a4,-1(a5)
 12a:	fb7d                	bnez	a4,120 <strlen+0x14>
  return n;
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret
  for(n = 0; s[n]; n++)
 132:	4501                	li	a0,0
 134:	bfe5                	j	12c <strlen+0x20>

0000000000000136 <memset>:

void*
memset(void *dst, int c, uint n)
{
 136:	1141                	addi	sp,sp,-16
 138:	e422                	sd	s0,8(sp)
 13a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 13c:	ce09                	beqz	a2,156 <memset+0x20>
 13e:	87aa                	mv	a5,a0
 140:	fff6071b          	addiw	a4,a2,-1
 144:	1702                	slli	a4,a4,0x20
 146:	9301                	srli	a4,a4,0x20
 148:	0705                	addi	a4,a4,1
 14a:	972a                	add	a4,a4,a0
    cdst[i] = c;
 14c:	00b78023          	sb	a1,0(a5)
 150:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 152:	fee79de3          	bne	a5,a4,14c <memset+0x16>
  }
  return dst;
}
 156:	6422                	ld	s0,8(sp)
 158:	0141                	addi	sp,sp,16
 15a:	8082                	ret

000000000000015c <strchr>:

char*
strchr(const char *s, char c)
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e422                	sd	s0,8(sp)
 160:	0800                	addi	s0,sp,16
  for(; *s; s++)
 162:	00054783          	lbu	a5,0(a0)
 166:	cf91                	beqz	a5,182 <strchr+0x26>
    if(*s == c)
 168:	00f58a63          	beq	a1,a5,17c <strchr+0x20>
  for(; *s; s++)
 16c:	0505                	addi	a0,a0,1
 16e:	00054783          	lbu	a5,0(a0)
 172:	c781                	beqz	a5,17a <strchr+0x1e>
    if(*s == c)
 174:	feb79ce3          	bne	a5,a1,16c <strchr+0x10>
 178:	a011                	j	17c <strchr+0x20>
      return (char*)s;
  return 0;
 17a:	4501                	li	a0,0
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret
  return 0;
 182:	4501                	li	a0,0
 184:	bfe5                	j	17c <strchr+0x20>

0000000000000186 <gets>:

char*
gets(char *buf, int max)
{
 186:	711d                	addi	sp,sp,-96
 188:	ec86                	sd	ra,88(sp)
 18a:	e8a2                	sd	s0,80(sp)
 18c:	e4a6                	sd	s1,72(sp)
 18e:	e0ca                	sd	s2,64(sp)
 190:	fc4e                	sd	s3,56(sp)
 192:	f852                	sd	s4,48(sp)
 194:	f456                	sd	s5,40(sp)
 196:	f05a                	sd	s6,32(sp)
 198:	ec5e                	sd	s7,24(sp)
 19a:	1080                	addi	s0,sp,96
 19c:	8baa                	mv	s7,a0
 19e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a0:	892a                	mv	s2,a0
 1a2:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1a4:	4aa9                	li	s5,10
 1a6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1a8:	0019849b          	addiw	s1,s3,1
 1ac:	0344d863          	bge	s1,s4,1dc <gets+0x56>
    cc = read(0, &c, 1);
 1b0:	4605                	li	a2,1
 1b2:	faf40593          	addi	a1,s0,-81
 1b6:	4501                	li	a0,0
 1b8:	00000097          	auipc	ra,0x0
 1bc:	240080e7          	jalr	576(ra) # 3f8 <read>
    if(cc < 1)
 1c0:	00a05e63          	blez	a0,1dc <gets+0x56>
    buf[i++] = c;
 1c4:	faf44783          	lbu	a5,-81(s0)
 1c8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1cc:	01578763          	beq	a5,s5,1da <gets+0x54>
 1d0:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 1d2:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 1d4:	fd679ae3          	bne	a5,s6,1a8 <gets+0x22>
 1d8:	a011                	j	1dc <gets+0x56>
  for(i=0; i+1 < max; ){
 1da:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1dc:	99de                	add	s3,s3,s7
 1de:	00098023          	sb	zero,0(s3)
  return buf;
}
 1e2:	855e                	mv	a0,s7
 1e4:	60e6                	ld	ra,88(sp)
 1e6:	6446                	ld	s0,80(sp)
 1e8:	64a6                	ld	s1,72(sp)
 1ea:	6906                	ld	s2,64(sp)
 1ec:	79e2                	ld	s3,56(sp)
 1ee:	7a42                	ld	s4,48(sp)
 1f0:	7aa2                	ld	s5,40(sp)
 1f2:	7b02                	ld	s6,32(sp)
 1f4:	6be2                	ld	s7,24(sp)
 1f6:	6125                	addi	sp,sp,96
 1f8:	8082                	ret

00000000000001fa <fgets>:

char*
fgets(int fd, char *buf, int max)
{
 1fa:	711d                	addi	sp,sp,-96
 1fc:	ec86                	sd	ra,88(sp)
 1fe:	e8a2                	sd	s0,80(sp)
 200:	e4a6                	sd	s1,72(sp)
 202:	e0ca                	sd	s2,64(sp)
 204:	fc4e                	sd	s3,56(sp)
 206:	f852                	sd	s4,48(sp)
 208:	f456                	sd	s5,40(sp)
 20a:	f05a                	sd	s6,32(sp)
 20c:	ec5e                	sd	s7,24(sp)
 20e:	e862                	sd	s8,16(sp)
 210:	1080                	addi	s0,sp,96
 212:	8aaa                	mv	s5,a0
 214:	8c2e                	mv	s8,a1
 216:	8a32                	mv	s4,a2
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 218:	892e                	mv	s2,a1
 21a:	4981                	li	s3,0
    cc = read(fd, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 21c:	4b29                	li	s6,10
 21e:	4bb5                	li	s7,13
  for(i=0; i+1 < max; ){
 220:	0019849b          	addiw	s1,s3,1
 224:	0344d863          	bge	s1,s4,254 <fgets+0x5a>
    cc = read(fd, &c, 1);
 228:	4605                	li	a2,1
 22a:	faf40593          	addi	a1,s0,-81
 22e:	8556                	mv	a0,s5
 230:	00000097          	auipc	ra,0x0
 234:	1c8080e7          	jalr	456(ra) # 3f8 <read>
    if(cc < 1)
 238:	00a05e63          	blez	a0,254 <fgets+0x5a>
    buf[i++] = c;
 23c:	faf44783          	lbu	a5,-81(s0)
 240:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 244:	01678763          	beq	a5,s6,252 <fgets+0x58>
 248:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 24a:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 24c:	fd779ae3          	bne	a5,s7,220 <fgets+0x26>
 250:	a011                	j	254 <fgets+0x5a>
  for(i=0; i+1 < max; ){
 252:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 254:	99e2                	add	s3,s3,s8
 256:	00098023          	sb	zero,0(s3)
  return buf;
}
 25a:	8562                	mv	a0,s8
 25c:	60e6                	ld	ra,88(sp)
 25e:	6446                	ld	s0,80(sp)
 260:	64a6                	ld	s1,72(sp)
 262:	6906                	ld	s2,64(sp)
 264:	79e2                	ld	s3,56(sp)
 266:	7a42                	ld	s4,48(sp)
 268:	7aa2                	ld	s5,40(sp)
 26a:	7b02                	ld	s6,32(sp)
 26c:	6be2                	ld	s7,24(sp)
 26e:	6c42                	ld	s8,16(sp)
 270:	6125                	addi	sp,sp,96
 272:	8082                	ret

0000000000000274 <stat>:


int
stat(const char *n, struct stat *st)
{
 274:	1101                	addi	sp,sp,-32
 276:	ec06                	sd	ra,24(sp)
 278:	e822                	sd	s0,16(sp)
 27a:	e426                	sd	s1,8(sp)
 27c:	e04a                	sd	s2,0(sp)
 27e:	1000                	addi	s0,sp,32
 280:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 282:	4581                	li	a1,0
 284:	00000097          	auipc	ra,0x0
 288:	1a2080e7          	jalr	418(ra) # 426 <open>
  if(fd < 0)
 28c:	02054563          	bltz	a0,2b6 <stat+0x42>
 290:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 292:	85ca                	mv	a1,s2
 294:	00000097          	auipc	ra,0x0
 298:	19a080e7          	jalr	410(ra) # 42e <fstat>
 29c:	892a                	mv	s2,a0
  close(fd);
 29e:	8526                	mv	a0,s1
 2a0:	00000097          	auipc	ra,0x0
 2a4:	16c080e7          	jalr	364(ra) # 40c <close>
  return r;
}
 2a8:	854a                	mv	a0,s2
 2aa:	60e2                	ld	ra,24(sp)
 2ac:	6442                	ld	s0,16(sp)
 2ae:	64a2                	ld	s1,8(sp)
 2b0:	6902                	ld	s2,0(sp)
 2b2:	6105                	addi	sp,sp,32
 2b4:	8082                	ret
    return -1;
 2b6:	597d                	li	s2,-1
 2b8:	bfc5                	j	2a8 <stat+0x34>

00000000000002ba <atoi>:

int
atoi(const char *s)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 2c0:	00054703          	lbu	a4,0(a0)
 2c4:	02d00793          	li	a5,45
  int neg = 1;
 2c8:	4805                	li	a6,1
  if (*s == '-') {
 2ca:	04f70363          	beq	a4,a5,310 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 2ce:	00054683          	lbu	a3,0(a0)
 2d2:	fd06879b          	addiw	a5,a3,-48
 2d6:	0ff7f793          	andi	a5,a5,255
 2da:	4725                	li	a4,9
 2dc:	02f76d63          	bltu	a4,a5,316 <atoi+0x5c>
  n = 0;
 2e0:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 2e2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2e4:	0505                	addi	a0,a0,1
 2e6:	0026179b          	slliw	a5,a2,0x2
 2ea:	9fb1                	addw	a5,a5,a2
 2ec:	0017979b          	slliw	a5,a5,0x1
 2f0:	9fb5                	addw	a5,a5,a3
 2f2:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 2f6:	00054683          	lbu	a3,0(a0)
 2fa:	fd06871b          	addiw	a4,a3,-48
 2fe:	0ff77713          	andi	a4,a4,255
 302:	fee5f1e3          	bgeu	a1,a4,2e4 <atoi+0x2a>
  return n * neg;
}
 306:	02c8053b          	mulw	a0,a6,a2
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    s++;
 310:	0505                	addi	a0,a0,1
    neg = -1;
 312:	587d                	li	a6,-1
 314:	bf6d                	j	2ce <atoi+0x14>
  n = 0;
 316:	4601                	li	a2,0
 318:	b7fd                	j	306 <atoi+0x4c>

000000000000031a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 31a:	1141                	addi	sp,sp,-16
 31c:	e422                	sd	s0,8(sp)
 31e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 320:	02b57663          	bgeu	a0,a1,34c <memmove+0x32>
    while(n-- > 0)
 324:	02c05163          	blez	a2,346 <memmove+0x2c>
 328:	fff6079b          	addiw	a5,a2,-1
 32c:	1782                	slli	a5,a5,0x20
 32e:	9381                	srli	a5,a5,0x20
 330:	0785                	addi	a5,a5,1
 332:	97aa                	add	a5,a5,a0
  dst = vdst;
 334:	872a                	mv	a4,a0
      *dst++ = *src++;
 336:	0585                	addi	a1,a1,1
 338:	0705                	addi	a4,a4,1
 33a:	fff5c683          	lbu	a3,-1(a1)
 33e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 342:	fee79ae3          	bne	a5,a4,336 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret
    dst += n;
 34c:	00c50733          	add	a4,a0,a2
    src += n;
 350:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 352:	fec05ae3          	blez	a2,346 <memmove+0x2c>
 356:	fff6079b          	addiw	a5,a2,-1
 35a:	1782                	slli	a5,a5,0x20
 35c:	9381                	srli	a5,a5,0x20
 35e:	fff7c793          	not	a5,a5
 362:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 364:	15fd                	addi	a1,a1,-1
 366:	177d                	addi	a4,a4,-1
 368:	0005c683          	lbu	a3,0(a1)
 36c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 370:	fef71ae3          	bne	a4,a5,364 <memmove+0x4a>
 374:	bfc9                	j	346 <memmove+0x2c>

0000000000000376 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 376:	1141                	addi	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 37c:	ce15                	beqz	a2,3b8 <memcmp+0x42>
 37e:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 382:	00054783          	lbu	a5,0(a0)
 386:	0005c703          	lbu	a4,0(a1)
 38a:	02e79063          	bne	a5,a4,3aa <memcmp+0x34>
 38e:	1682                	slli	a3,a3,0x20
 390:	9281                	srli	a3,a3,0x20
 392:	0685                	addi	a3,a3,1
 394:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 396:	0505                	addi	a0,a0,1
    p2++;
 398:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 39a:	00d50d63          	beq	a0,a3,3b4 <memcmp+0x3e>
    if (*p1 != *p2) {
 39e:	00054783          	lbu	a5,0(a0)
 3a2:	0005c703          	lbu	a4,0(a1)
 3a6:	fee788e3          	beq	a5,a4,396 <memcmp+0x20>
      return *p1 - *p2;
 3aa:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 3ae:	6422                	ld	s0,8(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret
  return 0;
 3b4:	4501                	li	a0,0
 3b6:	bfe5                	j	3ae <memcmp+0x38>
 3b8:	4501                	li	a0,0
 3ba:	bfd5                	j	3ae <memcmp+0x38>

00000000000003bc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3bc:	1141                	addi	sp,sp,-16
 3be:	e406                	sd	ra,8(sp)
 3c0:	e022                	sd	s0,0(sp)
 3c2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3c4:	00000097          	auipc	ra,0x0
 3c8:	f56080e7          	jalr	-170(ra) # 31a <memmove>
}
 3cc:	60a2                	ld	ra,8(sp)
 3ce:	6402                	ld	s0,0(sp)
 3d0:	0141                	addi	sp,sp,16
 3d2:	8082                	ret

00000000000003d4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 3d4:	4885                	li	a7,1
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3dc:	05d00893          	li	a7,93
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e6:	488d                	li	a7,3
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ee:	03b00893          	li	a7,59
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <read>:
.global read
read:
 li a7, SYS_read
 3f8:	03f00893          	li	a7,63
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <write>:
.global write
write:
 li a7, SYS_write
 402:	04000893          	li	a7,64
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <close>:
.global close
close:
 li a7, SYS_close
 40c:	03900893          	li	a7,57
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <kill>:
.global kill
kill:
 li a7, SYS_kill
 416:	4899                	li	a7,6
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <exec>:
.global exec
exec:
 li a7, SYS_exec
 41e:	489d                	li	a7,7
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <open>:
.global open
open:
 li a7, SYS_open
 426:	48bd                	li	a7,15
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 42e:	05000893          	li	a7,80
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 438:	48d1                	li	a7,20
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 440:	03100893          	li	a7,49
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <dup>:
.global dup
dup:
 li a7, SYS_dup
 44a:	48dd                	li	a7,23
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 452:	0ac00893          	li	a7,172
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 45c:	48b1                	li	a7,12
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 464:	48b5                	li	a7,13
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 46c:	48b9                	li	a7,14
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 474:	48d9                	li	a7,22
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <dev>:
.global dev
dev:
 li a7, SYS_dev
 47c:	06500893          	li	a7,101
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 486:	06400893          	li	a7,100
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 490:	48c5                	li	a7,17
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <remove>:
.global remove
remove:
 li a7, SYS_remove
 498:	48e5                	li	a7,25
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <trace>:
.global trace
trace:
 li a7, SYS_trace
 4a0:	48c9                	li	a7,18
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 4a8:	48cd                	li	a7,19
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <rename>:
.global rename
rename:
 li a7, SYS_rename
 4b0:	48e9                	li	a7,26
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4b8:	1101                	addi	sp,sp,-32
 4ba:	ec06                	sd	ra,24(sp)
 4bc:	e822                	sd	s0,16(sp)
 4be:	1000                	addi	s0,sp,32
 4c0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c4:	4605                	li	a2,1
 4c6:	fef40593          	addi	a1,s0,-17
 4ca:	00000097          	auipc	ra,0x0
 4ce:	f38080e7          	jalr	-200(ra) # 402 <write>
}
 4d2:	60e2                	ld	ra,24(sp)
 4d4:	6442                	ld	s0,16(sp)
 4d6:	6105                	addi	sp,sp,32
 4d8:	8082                	ret

00000000000004da <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4da:	7139                	addi	sp,sp,-64
 4dc:	fc06                	sd	ra,56(sp)
 4de:	f822                	sd	s0,48(sp)
 4e0:	f426                	sd	s1,40(sp)
 4e2:	f04a                	sd	s2,32(sp)
 4e4:	ec4e                	sd	s3,24(sp)
 4e6:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e8:	c299                	beqz	a3,4ee <printint+0x14>
 4ea:	0005cd63          	bltz	a1,504 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ee:	2581                	sext.w	a1,a1
  neg = 0;
 4f0:	4301                	li	t1,0
 4f2:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4f6:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4f8:	2601                	sext.w	a2,a2
 4fa:	00000897          	auipc	a7,0x0
 4fe:	54688893          	addi	a7,a7,1350 # a40 <digits>
 502:	a039                	j	510 <printint+0x36>
    x = -xx;
 504:	40b005bb          	negw	a1,a1
    neg = 1;
 508:	4305                	li	t1,1
    x = -xx;
 50a:	b7e5                	j	4f2 <printint+0x18>
  }while((x /= base) != 0);
 50c:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 50e:	8836                	mv	a6,a3
 510:	0018069b          	addiw	a3,a6,1
 514:	02c5f7bb          	remuw	a5,a1,a2
 518:	1782                	slli	a5,a5,0x20
 51a:	9381                	srli	a5,a5,0x20
 51c:	97c6                	add	a5,a5,a7
 51e:	0007c783          	lbu	a5,0(a5)
 522:	00f70023          	sb	a5,0(a4)
 526:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 528:	02c5d7bb          	divuw	a5,a1,a2
 52c:	fec5f0e3          	bgeu	a1,a2,50c <printint+0x32>
  if(neg)
 530:	00030b63          	beqz	t1,546 <printint+0x6c>
    buf[i++] = '-';
 534:	fd040793          	addi	a5,s0,-48
 538:	96be                	add	a3,a3,a5
 53a:	02d00793          	li	a5,45
 53e:	fef68823          	sb	a5,-16(a3)
 542:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 546:	02d05963          	blez	a3,578 <printint+0x9e>
 54a:	89aa                	mv	s3,a0
 54c:	fc040793          	addi	a5,s0,-64
 550:	00d784b3          	add	s1,a5,a3
 554:	fff78913          	addi	s2,a5,-1
 558:	9936                	add	s2,s2,a3
 55a:	36fd                	addiw	a3,a3,-1
 55c:	1682                	slli	a3,a3,0x20
 55e:	9281                	srli	a3,a3,0x20
 560:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 564:	fff4c583          	lbu	a1,-1(s1)
 568:	854e                	mv	a0,s3
 56a:	00000097          	auipc	ra,0x0
 56e:	f4e080e7          	jalr	-178(ra) # 4b8 <putc>
 572:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 574:	ff2498e3          	bne	s1,s2,564 <printint+0x8a>
}
 578:	70e2                	ld	ra,56(sp)
 57a:	7442                	ld	s0,48(sp)
 57c:	74a2                	ld	s1,40(sp)
 57e:	7902                	ld	s2,32(sp)
 580:	69e2                	ld	s3,24(sp)
 582:	6121                	addi	sp,sp,64
 584:	8082                	ret

0000000000000586 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 586:	7119                	addi	sp,sp,-128
 588:	fc86                	sd	ra,120(sp)
 58a:	f8a2                	sd	s0,112(sp)
 58c:	f4a6                	sd	s1,104(sp)
 58e:	f0ca                	sd	s2,96(sp)
 590:	ecce                	sd	s3,88(sp)
 592:	e8d2                	sd	s4,80(sp)
 594:	e4d6                	sd	s5,72(sp)
 596:	e0da                	sd	s6,64(sp)
 598:	fc5e                	sd	s7,56(sp)
 59a:	f862                	sd	s8,48(sp)
 59c:	f466                	sd	s9,40(sp)
 59e:	f06a                	sd	s10,32(sp)
 5a0:	ec6e                	sd	s11,24(sp)
 5a2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5a4:	0005c483          	lbu	s1,0(a1)
 5a8:	18048d63          	beqz	s1,742 <vprintf+0x1bc>
 5ac:	8aaa                	mv	s5,a0
 5ae:	8b32                	mv	s6,a2
 5b0:	00158913          	addi	s2,a1,1
  state = 0;
 5b4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b6:	02500a13          	li	s4,37
      if(c == 'd'){
 5ba:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5be:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5c2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5c6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ca:	00000b97          	auipc	s7,0x0
 5ce:	476b8b93          	addi	s7,s7,1142 # a40 <digits>
 5d2:	a839                	j	5f0 <vprintf+0x6a>
        putc(fd, c);
 5d4:	85a6                	mv	a1,s1
 5d6:	8556                	mv	a0,s5
 5d8:	00000097          	auipc	ra,0x0
 5dc:	ee0080e7          	jalr	-288(ra) # 4b8 <putc>
 5e0:	a019                	j	5e6 <vprintf+0x60>
    } else if(state == '%'){
 5e2:	01498f63          	beq	s3,s4,600 <vprintf+0x7a>
 5e6:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 5e8:	fff94483          	lbu	s1,-1(s2)
 5ec:	14048b63          	beqz	s1,742 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 5f0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5f4:	fe0997e3          	bnez	s3,5e2 <vprintf+0x5c>
      if(c == '%'){
 5f8:	fd479ee3          	bne	a5,s4,5d4 <vprintf+0x4e>
        state = '%';
 5fc:	89be                	mv	s3,a5
 5fe:	b7e5                	j	5e6 <vprintf+0x60>
      if(c == 'd'){
 600:	05878063          	beq	a5,s8,640 <vprintf+0xba>
      } else if(c == 'l') {
 604:	05978c63          	beq	a5,s9,65c <vprintf+0xd6>
      } else if(c == 'x') {
 608:	07a78863          	beq	a5,s10,678 <vprintf+0xf2>
      } else if(c == 'p') {
 60c:	09b78463          	beq	a5,s11,694 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 610:	07300713          	li	a4,115
 614:	0ce78563          	beq	a5,a4,6de <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 618:	06300713          	li	a4,99
 61c:	0ee78c63          	beq	a5,a4,714 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 620:	11478663          	beq	a5,s4,72c <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 624:	85d2                	mv	a1,s4
 626:	8556                	mv	a0,s5
 628:	00000097          	auipc	ra,0x0
 62c:	e90080e7          	jalr	-368(ra) # 4b8 <putc>
        putc(fd, c);
 630:	85a6                	mv	a1,s1
 632:	8556                	mv	a0,s5
 634:	00000097          	auipc	ra,0x0
 638:	e84080e7          	jalr	-380(ra) # 4b8 <putc>
      }
      state = 0;
 63c:	4981                	li	s3,0
 63e:	b765                	j	5e6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 640:	008b0493          	addi	s1,s6,8
 644:	4685                	li	a3,1
 646:	4629                	li	a2,10
 648:	000b2583          	lw	a1,0(s6)
 64c:	8556                	mv	a0,s5
 64e:	00000097          	auipc	ra,0x0
 652:	e8c080e7          	jalr	-372(ra) # 4da <printint>
 656:	8b26                	mv	s6,s1
      state = 0;
 658:	4981                	li	s3,0
 65a:	b771                	j	5e6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 65c:	008b0493          	addi	s1,s6,8
 660:	4681                	li	a3,0
 662:	4629                	li	a2,10
 664:	000b2583          	lw	a1,0(s6)
 668:	8556                	mv	a0,s5
 66a:	00000097          	auipc	ra,0x0
 66e:	e70080e7          	jalr	-400(ra) # 4da <printint>
 672:	8b26                	mv	s6,s1
      state = 0;
 674:	4981                	li	s3,0
 676:	bf85                	j	5e6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 678:	008b0493          	addi	s1,s6,8
 67c:	4681                	li	a3,0
 67e:	4641                	li	a2,16
 680:	000b2583          	lw	a1,0(s6)
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	e54080e7          	jalr	-428(ra) # 4da <printint>
 68e:	8b26                	mv	s6,s1
      state = 0;
 690:	4981                	li	s3,0
 692:	bf91                	j	5e6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 694:	008b0793          	addi	a5,s6,8
 698:	f8f43423          	sd	a5,-120(s0)
 69c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6a0:	03000593          	li	a1,48
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	e12080e7          	jalr	-494(ra) # 4b8 <putc>
  putc(fd, 'x');
 6ae:	85ea                	mv	a1,s10
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	e06080e7          	jalr	-506(ra) # 4b8 <putc>
 6ba:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6bc:	03c9d793          	srli	a5,s3,0x3c
 6c0:	97de                	add	a5,a5,s7
 6c2:	0007c583          	lbu	a1,0(a5)
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	df0080e7          	jalr	-528(ra) # 4b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6d0:	0992                	slli	s3,s3,0x4
 6d2:	34fd                	addiw	s1,s1,-1
 6d4:	f4e5                	bnez	s1,6bc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6d6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	b729                	j	5e6 <vprintf+0x60>
        s = va_arg(ap, char*);
 6de:	008b0993          	addi	s3,s6,8
 6e2:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 6e6:	c085                	beqz	s1,706 <vprintf+0x180>
        while(*s != 0){
 6e8:	0004c583          	lbu	a1,0(s1)
 6ec:	c9a1                	beqz	a1,73c <vprintf+0x1b6>
          putc(fd, *s);
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	dc8080e7          	jalr	-568(ra) # 4b8 <putc>
          s++;
 6f8:	0485                	addi	s1,s1,1
        while(*s != 0){
 6fa:	0004c583          	lbu	a1,0(s1)
 6fe:	f9e5                	bnez	a1,6ee <vprintf+0x168>
        s = va_arg(ap, char*);
 700:	8b4e                	mv	s6,s3
      state = 0;
 702:	4981                	li	s3,0
 704:	b5cd                	j	5e6 <vprintf+0x60>
          s = "(null)";
 706:	00000497          	auipc	s1,0x0
 70a:	35248493          	addi	s1,s1,850 # a58 <digits+0x18>
        while(*s != 0){
 70e:	02800593          	li	a1,40
 712:	bff1                	j	6ee <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 714:	008b0493          	addi	s1,s6,8
 718:	000b4583          	lbu	a1,0(s6)
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	d9a080e7          	jalr	-614(ra) # 4b8 <putc>
 726:	8b26                	mv	s6,s1
      state = 0;
 728:	4981                	li	s3,0
 72a:	bd75                	j	5e6 <vprintf+0x60>
        putc(fd, c);
 72c:	85d2                	mv	a1,s4
 72e:	8556                	mv	a0,s5
 730:	00000097          	auipc	ra,0x0
 734:	d88080e7          	jalr	-632(ra) # 4b8 <putc>
      state = 0;
 738:	4981                	li	s3,0
 73a:	b575                	j	5e6 <vprintf+0x60>
        s = va_arg(ap, char*);
 73c:	8b4e                	mv	s6,s3
      state = 0;
 73e:	4981                	li	s3,0
 740:	b55d                	j	5e6 <vprintf+0x60>
    }
  }
}
 742:	70e6                	ld	ra,120(sp)
 744:	7446                	ld	s0,112(sp)
 746:	74a6                	ld	s1,104(sp)
 748:	7906                	ld	s2,96(sp)
 74a:	69e6                	ld	s3,88(sp)
 74c:	6a46                	ld	s4,80(sp)
 74e:	6aa6                	ld	s5,72(sp)
 750:	6b06                	ld	s6,64(sp)
 752:	7be2                	ld	s7,56(sp)
 754:	7c42                	ld	s8,48(sp)
 756:	7ca2                	ld	s9,40(sp)
 758:	7d02                	ld	s10,32(sp)
 75a:	6de2                	ld	s11,24(sp)
 75c:	6109                	addi	sp,sp,128
 75e:	8082                	ret

0000000000000760 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 760:	715d                	addi	sp,sp,-80
 762:	ec06                	sd	ra,24(sp)
 764:	e822                	sd	s0,16(sp)
 766:	1000                	addi	s0,sp,32
 768:	e010                	sd	a2,0(s0)
 76a:	e414                	sd	a3,8(s0)
 76c:	e818                	sd	a4,16(s0)
 76e:	ec1c                	sd	a5,24(s0)
 770:	03043023          	sd	a6,32(s0)
 774:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 778:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 77c:	8622                	mv	a2,s0
 77e:	00000097          	auipc	ra,0x0
 782:	e08080e7          	jalr	-504(ra) # 586 <vprintf>
}
 786:	60e2                	ld	ra,24(sp)
 788:	6442                	ld	s0,16(sp)
 78a:	6161                	addi	sp,sp,80
 78c:	8082                	ret

000000000000078e <printf>:

void
printf(const char *fmt, ...)
{
 78e:	711d                	addi	sp,sp,-96
 790:	ec06                	sd	ra,24(sp)
 792:	e822                	sd	s0,16(sp)
 794:	1000                	addi	s0,sp,32
 796:	e40c                	sd	a1,8(s0)
 798:	e810                	sd	a2,16(s0)
 79a:	ec14                	sd	a3,24(s0)
 79c:	f018                	sd	a4,32(s0)
 79e:	f41c                	sd	a5,40(s0)
 7a0:	03043823          	sd	a6,48(s0)
 7a4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a8:	00840613          	addi	a2,s0,8
 7ac:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b0:	85aa                	mv	a1,a0
 7b2:	4505                	li	a0,1
 7b4:	00000097          	auipc	ra,0x0
 7b8:	dd2080e7          	jalr	-558(ra) # 586 <vprintf>
}
 7bc:	60e2                	ld	ra,24(sp)
 7be:	6442                	ld	s0,16(sp)
 7c0:	6125                	addi	sp,sp,96
 7c2:	8082                	ret

00000000000007c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c4:	1141                	addi	sp,sp,-16
 7c6:	e422                	sd	s0,8(sp)
 7c8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ca:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ce:	00000797          	auipc	a5,0x0
 7d2:	39278793          	addi	a5,a5,914 # b60 <freep>
 7d6:	639c                	ld	a5,0(a5)
 7d8:	a805                	j	808 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7da:	4618                	lw	a4,8(a2)
 7dc:	9db9                	addw	a1,a1,a4
 7de:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e2:	6398                	ld	a4,0(a5)
 7e4:	6318                	ld	a4,0(a4)
 7e6:	fee53823          	sd	a4,-16(a0)
 7ea:	a091                	j	82e <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ec:	ff852703          	lw	a4,-8(a0)
 7f0:	9e39                	addw	a2,a2,a4
 7f2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7f4:	ff053703          	ld	a4,-16(a0)
 7f8:	e398                	sd	a4,0(a5)
 7fa:	a099                	j	840 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fc:	6398                	ld	a4,0(a5)
 7fe:	00e7e463          	bltu	a5,a4,806 <free+0x42>
 802:	00e6ea63          	bltu	a3,a4,816 <free+0x52>
{
 806:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 808:	fed7fae3          	bgeu	a5,a3,7fc <free+0x38>
 80c:	6398                	ld	a4,0(a5)
 80e:	00e6e463          	bltu	a3,a4,816 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 812:	fee7eae3          	bltu	a5,a4,806 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 816:	ff852583          	lw	a1,-8(a0)
 81a:	6390                	ld	a2,0(a5)
 81c:	02059713          	slli	a4,a1,0x20
 820:	9301                	srli	a4,a4,0x20
 822:	0712                	slli	a4,a4,0x4
 824:	9736                	add	a4,a4,a3
 826:	fae60ae3          	beq	a2,a4,7da <free+0x16>
    bp->s.ptr = p->s.ptr;
 82a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 82e:	4790                	lw	a2,8(a5)
 830:	02061713          	slli	a4,a2,0x20
 834:	9301                	srli	a4,a4,0x20
 836:	0712                	slli	a4,a4,0x4
 838:	973e                	add	a4,a4,a5
 83a:	fae689e3          	beq	a3,a4,7ec <free+0x28>
  } else
    p->s.ptr = bp;
 83e:	e394                	sd	a3,0(a5)
  freep = p;
 840:	00000717          	auipc	a4,0x0
 844:	32f73023          	sd	a5,800(a4) # b60 <freep>
}
 848:	6422                	ld	s0,8(sp)
 84a:	0141                	addi	sp,sp,16
 84c:	8082                	ret

000000000000084e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 84e:	7139                	addi	sp,sp,-64
 850:	fc06                	sd	ra,56(sp)
 852:	f822                	sd	s0,48(sp)
 854:	f426                	sd	s1,40(sp)
 856:	f04a                	sd	s2,32(sp)
 858:	ec4e                	sd	s3,24(sp)
 85a:	e852                	sd	s4,16(sp)
 85c:	e456                	sd	s5,8(sp)
 85e:	e05a                	sd	s6,0(sp)
 860:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 862:	02051993          	slli	s3,a0,0x20
 866:	0209d993          	srli	s3,s3,0x20
 86a:	09bd                	addi	s3,s3,15
 86c:	0049d993          	srli	s3,s3,0x4
 870:	2985                	addiw	s3,s3,1
 872:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 876:	00000797          	auipc	a5,0x0
 87a:	2ea78793          	addi	a5,a5,746 # b60 <freep>
 87e:	6388                	ld	a0,0(a5)
 880:	c515                	beqz	a0,8ac <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 882:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 884:	4798                	lw	a4,8(a5)
 886:	03277f63          	bgeu	a4,s2,8c4 <malloc+0x76>
 88a:	8a4e                	mv	s4,s3
 88c:	0009871b          	sext.w	a4,s3
 890:	6685                	lui	a3,0x1
 892:	00d77363          	bgeu	a4,a3,898 <malloc+0x4a>
 896:	6a05                	lui	s4,0x1
 898:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 89c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8a0:	00000497          	auipc	s1,0x0
 8a4:	2c048493          	addi	s1,s1,704 # b60 <freep>
  if(p == (char*)-1)
 8a8:	5b7d                	li	s6,-1
 8aa:	a885                	j	91a <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8ac:	00000797          	auipc	a5,0x0
 8b0:	2bc78793          	addi	a5,a5,700 # b68 <base>
 8b4:	00000717          	auipc	a4,0x0
 8b8:	2af73623          	sd	a5,684(a4) # b60 <freep>
 8bc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8be:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8c2:	b7e1                	j	88a <malloc+0x3c>
      if(p->s.size == nunits)
 8c4:	02e90b63          	beq	s2,a4,8fa <malloc+0xac>
        p->s.size -= nunits;
 8c8:	4137073b          	subw	a4,a4,s3
 8cc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8ce:	1702                	slli	a4,a4,0x20
 8d0:	9301                	srli	a4,a4,0x20
 8d2:	0712                	slli	a4,a4,0x4
 8d4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8d6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8da:	00000717          	auipc	a4,0x0
 8de:	28a73323          	sd	a0,646(a4) # b60 <freep>
      return (void*)(p + 1);
 8e2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8e6:	70e2                	ld	ra,56(sp)
 8e8:	7442                	ld	s0,48(sp)
 8ea:	74a2                	ld	s1,40(sp)
 8ec:	7902                	ld	s2,32(sp)
 8ee:	69e2                	ld	s3,24(sp)
 8f0:	6a42                	ld	s4,16(sp)
 8f2:	6aa2                	ld	s5,8(sp)
 8f4:	6b02                	ld	s6,0(sp)
 8f6:	6121                	addi	sp,sp,64
 8f8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8fa:	6398                	ld	a4,0(a5)
 8fc:	e118                	sd	a4,0(a0)
 8fe:	bff1                	j	8da <malloc+0x8c>
  hp->s.size = nu;
 900:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 904:	0541                	addi	a0,a0,16
 906:	00000097          	auipc	ra,0x0
 90a:	ebe080e7          	jalr	-322(ra) # 7c4 <free>
  return freep;
 90e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 910:	d979                	beqz	a0,8e6 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 912:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 914:	4798                	lw	a4,8(a5)
 916:	fb2777e3          	bgeu	a4,s2,8c4 <malloc+0x76>
    if(p == freep)
 91a:	6098                	ld	a4,0(s1)
 91c:	853e                	mv	a0,a5
 91e:	fef71ae3          	bne	a4,a5,912 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 922:	8552                	mv	a0,s4
 924:	00000097          	auipc	ra,0x0
 928:	b38080e7          	jalr	-1224(ra) # 45c <sbrk>
  if(p == (char*)-1)
 92c:	fd651ae3          	bne	a0,s6,900 <malloc+0xb2>
        return 0;
 930:	4501                	li	a0,0
 932:	bf55                	j	8e6 <malloc+0x98>
