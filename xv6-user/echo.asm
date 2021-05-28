
xv6-user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/include/stat.h"
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
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	bge	a5,a0,7a <main+0x7a>
  16:	00858493          	addi	s1,a1,8
  1a:	ffe5099b          	addiw	s3,a0,-2
  1e:	1982                	slli	s3,s3,0x20
  20:	0209d993          	srli	s3,s3,0x20
  24:	098e                	slli	s3,s3,0x3
  26:	05c1                	addi	a1,a1,16
  28:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2a:	00001a17          	auipc	s4,0x1
  2e:	876a0a13          	addi	s4,s4,-1930 # 8a0 <malloc+0xea>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	0ca080e7          	jalr	202(ra) # 102 <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	330080e7          	jalr	816(ra) # 378 <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	31c080e7          	jalr	796(ra) # 378 <write>
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	84058593          	addi	a1,a1,-1984 # 8a8 <malloc+0xf2>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	306080e7          	jalr	774(ra) # 378 <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	2dc080e7          	jalr	732(ra) # 358 <exit>

0000000000000084 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
  84:	1141                	addi	sp,sp,-16
  86:	e422                	sd	s0,8(sp)
  88:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	87aa                	mv	a5,a0
  8c:	0585                	addi	a1,a1,1
  8e:	0785                	addi	a5,a5,1
  90:	fff5c703          	lbu	a4,-1(a1)
  94:	fee78fa3          	sb	a4,-1(a5)
  98:	fb75                	bnez	a4,8c <strcpy+0x8>
    ;
  return os;
}
  9a:	6422                	ld	s0,8(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret

00000000000000a0 <strcat>:

char*
strcat(char *s, const char *t)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
  a6:	00054783          	lbu	a5,0(a0)
  aa:	c385                	beqz	a5,ca <strcat+0x2a>
  ac:	87aa                	mv	a5,a0
    s++;
  ae:	0785                	addi	a5,a5,1
  while(*s)
  b0:	0007c703          	lbu	a4,0(a5)
  b4:	ff6d                	bnez	a4,ae <strcat+0xe>
  while((*s++ = *t++))
  b6:	0585                	addi	a1,a1,1
  b8:	0785                	addi	a5,a5,1
  ba:	fff5c703          	lbu	a4,-1(a1)
  be:	fee78fa3          	sb	a4,-1(a5)
  c2:	fb75                	bnez	a4,b6 <strcat+0x16>
    ;
  return os;
}
  c4:	6422                	ld	s0,8(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret
  while(*s)
  ca:	87aa                	mv	a5,a0
  cc:	b7ed                	j	b6 <strcat+0x16>

00000000000000ce <strcmp>:


int
strcmp(const char *p, const char *q)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e422                	sd	s0,8(sp)
  d2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  d4:	00054783          	lbu	a5,0(a0)
  d8:	cf91                	beqz	a5,f4 <strcmp+0x26>
  da:	0005c703          	lbu	a4,0(a1)
  de:	00f71b63          	bne	a4,a5,f4 <strcmp+0x26>
    p++, q++;
  e2:	0505                	addi	a0,a0,1
  e4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  e6:	00054783          	lbu	a5,0(a0)
  ea:	c789                	beqz	a5,f4 <strcmp+0x26>
  ec:	0005c703          	lbu	a4,0(a1)
  f0:	fef709e3          	beq	a4,a5,e2 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  f4:	0005c503          	lbu	a0,0(a1)
}
  f8:	40a7853b          	subw	a0,a5,a0
  fc:	6422                	ld	s0,8(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret

0000000000000102 <strlen>:

uint
strlen(const char *s)
{
 102:	1141                	addi	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 108:	00054783          	lbu	a5,0(a0)
 10c:	cf91                	beqz	a5,128 <strlen+0x26>
 10e:	0505                	addi	a0,a0,1
 110:	87aa                	mv	a5,a0
 112:	4685                	li	a3,1
 114:	9e89                	subw	a3,a3,a0
    ;
 116:	00f6853b          	addw	a0,a3,a5
 11a:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 11c:	fff7c703          	lbu	a4,-1(a5)
 120:	fb7d                	bnez	a4,116 <strlen+0x14>
  return n;
}
 122:	6422                	ld	s0,8(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret
  for(n = 0; s[n]; n++)
 128:	4501                	li	a0,0
 12a:	bfe5                	j	122 <strlen+0x20>

000000000000012c <memset>:

void*
memset(void *dst, int c, uint n)
{
 12c:	1141                	addi	sp,sp,-16
 12e:	e422                	sd	s0,8(sp)
 130:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 132:	ce09                	beqz	a2,14c <memset+0x20>
 134:	87aa                	mv	a5,a0
 136:	fff6071b          	addiw	a4,a2,-1
 13a:	1702                	slli	a4,a4,0x20
 13c:	9301                	srli	a4,a4,0x20
 13e:	0705                	addi	a4,a4,1
 140:	972a                	add	a4,a4,a0
    cdst[i] = c;
 142:	00b78023          	sb	a1,0(a5)
 146:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 148:	fee79de3          	bne	a5,a4,142 <memset+0x16>
  }
  return dst;
}
 14c:	6422                	ld	s0,8(sp)
 14e:	0141                	addi	sp,sp,16
 150:	8082                	ret

0000000000000152 <strchr>:

char*
strchr(const char *s, char c)
{
 152:	1141                	addi	sp,sp,-16
 154:	e422                	sd	s0,8(sp)
 156:	0800                	addi	s0,sp,16
  for(; *s; s++)
 158:	00054783          	lbu	a5,0(a0)
 15c:	cf91                	beqz	a5,178 <strchr+0x26>
    if(*s == c)
 15e:	00f58a63          	beq	a1,a5,172 <strchr+0x20>
  for(; *s; s++)
 162:	0505                	addi	a0,a0,1
 164:	00054783          	lbu	a5,0(a0)
 168:	c781                	beqz	a5,170 <strchr+0x1e>
    if(*s == c)
 16a:	feb79ce3          	bne	a5,a1,162 <strchr+0x10>
 16e:	a011                	j	172 <strchr+0x20>
      return (char*)s;
  return 0;
 170:	4501                	li	a0,0
}
 172:	6422                	ld	s0,8(sp)
 174:	0141                	addi	sp,sp,16
 176:	8082                	ret
  return 0;
 178:	4501                	li	a0,0
 17a:	bfe5                	j	172 <strchr+0x20>

000000000000017c <gets>:

char*
gets(char *buf, int max)
{
 17c:	711d                	addi	sp,sp,-96
 17e:	ec86                	sd	ra,88(sp)
 180:	e8a2                	sd	s0,80(sp)
 182:	e4a6                	sd	s1,72(sp)
 184:	e0ca                	sd	s2,64(sp)
 186:	fc4e                	sd	s3,56(sp)
 188:	f852                	sd	s4,48(sp)
 18a:	f456                	sd	s5,40(sp)
 18c:	f05a                	sd	s6,32(sp)
 18e:	ec5e                	sd	s7,24(sp)
 190:	1080                	addi	s0,sp,96
 192:	8baa                	mv	s7,a0
 194:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 196:	892a                	mv	s2,a0
 198:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 19a:	4aa9                	li	s5,10
 19c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 19e:	0019849b          	addiw	s1,s3,1
 1a2:	0344d863          	bge	s1,s4,1d2 <gets+0x56>
    cc = read(0, &c, 1);
 1a6:	4605                	li	a2,1
 1a8:	faf40593          	addi	a1,s0,-81
 1ac:	4501                	li	a0,0
 1ae:	00000097          	auipc	ra,0x0
 1b2:	1c2080e7          	jalr	450(ra) # 370 <read>
    if(cc < 1)
 1b6:	00a05e63          	blez	a0,1d2 <gets+0x56>
    buf[i++] = c;
 1ba:	faf44783          	lbu	a5,-81(s0)
 1be:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1c2:	01578763          	beq	a5,s5,1d0 <gets+0x54>
 1c6:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 1c8:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 1ca:	fd679ae3          	bne	a5,s6,19e <gets+0x22>
 1ce:	a011                	j	1d2 <gets+0x56>
  for(i=0; i+1 < max; ){
 1d0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1d2:	99de                	add	s3,s3,s7
 1d4:	00098023          	sb	zero,0(s3)
  return buf;
}
 1d8:	855e                	mv	a0,s7
 1da:	60e6                	ld	ra,88(sp)
 1dc:	6446                	ld	s0,80(sp)
 1de:	64a6                	ld	s1,72(sp)
 1e0:	6906                	ld	s2,64(sp)
 1e2:	79e2                	ld	s3,56(sp)
 1e4:	7a42                	ld	s4,48(sp)
 1e6:	7aa2                	ld	s5,40(sp)
 1e8:	7b02                	ld	s6,32(sp)
 1ea:	6be2                	ld	s7,24(sp)
 1ec:	6125                	addi	sp,sp,96
 1ee:	8082                	ret

00000000000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	1101                	addi	sp,sp,-32
 1f2:	ec06                	sd	ra,24(sp)
 1f4:	e822                	sd	s0,16(sp)
 1f6:	e426                	sd	s1,8(sp)
 1f8:	e04a                	sd	s2,0(sp)
 1fa:	1000                	addi	s0,sp,32
 1fc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fe:	4581                	li	a1,0
 200:	00000097          	auipc	ra,0x0
 204:	198080e7          	jalr	408(ra) # 398 <open>
  if(fd < 0)
 208:	02054563          	bltz	a0,232 <stat+0x42>
 20c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 20e:	85ca                	mv	a1,s2
 210:	00000097          	auipc	ra,0x0
 214:	190080e7          	jalr	400(ra) # 3a0 <fstat>
 218:	892a                	mv	s2,a0
  close(fd);
 21a:	8526                	mv	a0,s1
 21c:	00000097          	auipc	ra,0x0
 220:	164080e7          	jalr	356(ra) # 380 <close>
  return r;
}
 224:	854a                	mv	a0,s2
 226:	60e2                	ld	ra,24(sp)
 228:	6442                	ld	s0,16(sp)
 22a:	64a2                	ld	s1,8(sp)
 22c:	6902                	ld	s2,0(sp)
 22e:	6105                	addi	sp,sp,32
 230:	8082                	ret
    return -1;
 232:	597d                	li	s2,-1
 234:	bfc5                	j	224 <stat+0x34>

0000000000000236 <atoi>:

int
atoi(const char *s)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 23c:	00054703          	lbu	a4,0(a0)
 240:	02d00793          	li	a5,45
  int neg = 1;
 244:	4805                	li	a6,1
  if (*s == '-') {
 246:	04f70363          	beq	a4,a5,28c <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 24a:	00054683          	lbu	a3,0(a0)
 24e:	fd06879b          	addiw	a5,a3,-48
 252:	0ff7f793          	andi	a5,a5,255
 256:	4725                	li	a4,9
 258:	02f76d63          	bltu	a4,a5,292 <atoi+0x5c>
  n = 0;
 25c:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 25e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 260:	0505                	addi	a0,a0,1
 262:	0026179b          	slliw	a5,a2,0x2
 266:	9fb1                	addw	a5,a5,a2
 268:	0017979b          	slliw	a5,a5,0x1
 26c:	9fb5                	addw	a5,a5,a3
 26e:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 272:	00054683          	lbu	a3,0(a0)
 276:	fd06871b          	addiw	a4,a3,-48
 27a:	0ff77713          	andi	a4,a4,255
 27e:	fee5f1e3          	bgeu	a1,a4,260 <atoi+0x2a>
  return n * neg;
}
 282:	02c8053b          	mulw	a0,a6,a2
 286:	6422                	ld	s0,8(sp)
 288:	0141                	addi	sp,sp,16
 28a:	8082                	ret
    s++;
 28c:	0505                	addi	a0,a0,1
    neg = -1;
 28e:	587d                	li	a6,-1
 290:	bf6d                	j	24a <atoi+0x14>
  n = 0;
 292:	4601                	li	a2,0
 294:	b7fd                	j	282 <atoi+0x4c>

0000000000000296 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 296:	1141                	addi	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 29c:	02b57663          	bgeu	a0,a1,2c8 <memmove+0x32>
    while(n-- > 0)
 2a0:	02c05163          	blez	a2,2c2 <memmove+0x2c>
 2a4:	fff6079b          	addiw	a5,a2,-1
 2a8:	1782                	slli	a5,a5,0x20
 2aa:	9381                	srli	a5,a5,0x20
 2ac:	0785                	addi	a5,a5,1
 2ae:	97aa                	add	a5,a5,a0
  dst = vdst;
 2b0:	872a                	mv	a4,a0
      *dst++ = *src++;
 2b2:	0585                	addi	a1,a1,1
 2b4:	0705                	addi	a4,a4,1
 2b6:	fff5c683          	lbu	a3,-1(a1)
 2ba:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2be:	fee79ae3          	bne	a5,a4,2b2 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2c2:	6422                	ld	s0,8(sp)
 2c4:	0141                	addi	sp,sp,16
 2c6:	8082                	ret
    dst += n;
 2c8:	00c50733          	add	a4,a0,a2
    src += n;
 2cc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2ce:	fec05ae3          	blez	a2,2c2 <memmove+0x2c>
 2d2:	fff6079b          	addiw	a5,a2,-1
 2d6:	1782                	slli	a5,a5,0x20
 2d8:	9381                	srli	a5,a5,0x20
 2da:	fff7c793          	not	a5,a5
 2de:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2e0:	15fd                	addi	a1,a1,-1
 2e2:	177d                	addi	a4,a4,-1
 2e4:	0005c683          	lbu	a3,0(a1)
 2e8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ec:	fef71ae3          	bne	a4,a5,2e0 <memmove+0x4a>
 2f0:	bfc9                	j	2c2 <memmove+0x2c>

00000000000002f2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2f8:	ce15                	beqz	a2,334 <memcmp+0x42>
 2fa:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 2fe:	00054783          	lbu	a5,0(a0)
 302:	0005c703          	lbu	a4,0(a1)
 306:	02e79063          	bne	a5,a4,326 <memcmp+0x34>
 30a:	1682                	slli	a3,a3,0x20
 30c:	9281                	srli	a3,a3,0x20
 30e:	0685                	addi	a3,a3,1
 310:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 312:	0505                	addi	a0,a0,1
    p2++;
 314:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 316:	00d50d63          	beq	a0,a3,330 <memcmp+0x3e>
    if (*p1 != *p2) {
 31a:	00054783          	lbu	a5,0(a0)
 31e:	0005c703          	lbu	a4,0(a1)
 322:	fee788e3          	beq	a5,a4,312 <memcmp+0x20>
      return *p1 - *p2;
 326:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret
  return 0;
 330:	4501                	li	a0,0
 332:	bfe5                	j	32a <memcmp+0x38>
 334:	4501                	li	a0,0
 336:	bfd5                	j	32a <memcmp+0x38>

0000000000000338 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 338:	1141                	addi	sp,sp,-16
 33a:	e406                	sd	ra,8(sp)
 33c:	e022                	sd	s0,0(sp)
 33e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 340:	00000097          	auipc	ra,0x0
 344:	f56080e7          	jalr	-170(ra) # 296 <memmove>
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 350:	4885                	li	a7,1
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <exit>:
.global exit
exit:
 li a7, SYS_exit
 358:	4889                	li	a7,2
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <wait>:
.global wait
wait:
 li a7, SYS_wait
 360:	488d                	li	a7,3
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 368:	4891                	li	a7,4
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <read>:
.global read
read:
 li a7, SYS_read
 370:	4895                	li	a7,5
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <write>:
.global write
write:
 li a7, SYS_write
 378:	48c1                	li	a7,16
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <close>:
.global close
close:
 li a7, SYS_close
 380:	48d5                	li	a7,21
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <kill>:
.global kill
kill:
 li a7, SYS_kill
 388:	4899                	li	a7,6
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <exec>:
.global exec
exec:
 li a7, SYS_exec
 390:	489d                	li	a7,7
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <open>:
.global open
open:
 li a7, SYS_open
 398:	48bd                	li	a7,15
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3a0:	48a1                	li	a7,8
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3a8:	48d1                	li	a7,20
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b0:	48a5                	li	a7,9
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3b8:	48a9                	li	a7,10
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c0:	48ad                	li	a7,11
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3c8:	48b1                	li	a7,12
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3d0:	48b5                	li	a7,13
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3d8:	48b9                	li	a7,14
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 3e0:	48d9                	li	a7,22
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <dev>:
.global dev
dev:
 li a7, SYS_dev
 3e8:	48dd                	li	a7,23
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 3f0:	48e1                	li	a7,24
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3f8:	48e5                	li	a7,25
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <remove>:
.global remove
remove:
 li a7, SYS_remove
 400:	48c5                	li	a7,17
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <trace>:
.global trace
trace:
 li a7, SYS_trace
 408:	48c9                	li	a7,18
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 410:	48cd                	li	a7,19
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <rename>:
.global rename
rename:
 li a7, SYS_rename
 418:	48e9                	li	a7,26
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 420:	1101                	addi	sp,sp,-32
 422:	ec06                	sd	ra,24(sp)
 424:	e822                	sd	s0,16(sp)
 426:	1000                	addi	s0,sp,32
 428:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 42c:	4605                	li	a2,1
 42e:	fef40593          	addi	a1,s0,-17
 432:	00000097          	auipc	ra,0x0
 436:	f46080e7          	jalr	-186(ra) # 378 <write>
}
 43a:	60e2                	ld	ra,24(sp)
 43c:	6442                	ld	s0,16(sp)
 43e:	6105                	addi	sp,sp,32
 440:	8082                	ret

0000000000000442 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 442:	7139                	addi	sp,sp,-64
 444:	fc06                	sd	ra,56(sp)
 446:	f822                	sd	s0,48(sp)
 448:	f426                	sd	s1,40(sp)
 44a:	f04a                	sd	s2,32(sp)
 44c:	ec4e                	sd	s3,24(sp)
 44e:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 450:	c299                	beqz	a3,456 <printint+0x14>
 452:	0005cd63          	bltz	a1,46c <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 456:	2581                	sext.w	a1,a1
  neg = 0;
 458:	4301                	li	t1,0
 45a:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 45e:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 460:	2601                	sext.w	a2,a2
 462:	00000897          	auipc	a7,0x0
 466:	44e88893          	addi	a7,a7,1102 # 8b0 <digits>
 46a:	a039                	j	478 <printint+0x36>
    x = -xx;
 46c:	40b005bb          	negw	a1,a1
    neg = 1;
 470:	4305                	li	t1,1
    x = -xx;
 472:	b7e5                	j	45a <printint+0x18>
  }while((x /= base) != 0);
 474:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 476:	8836                	mv	a6,a3
 478:	0018069b          	addiw	a3,a6,1
 47c:	02c5f7bb          	remuw	a5,a1,a2
 480:	1782                	slli	a5,a5,0x20
 482:	9381                	srli	a5,a5,0x20
 484:	97c6                	add	a5,a5,a7
 486:	0007c783          	lbu	a5,0(a5)
 48a:	00f70023          	sb	a5,0(a4)
 48e:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 490:	02c5d7bb          	divuw	a5,a1,a2
 494:	fec5f0e3          	bgeu	a1,a2,474 <printint+0x32>
  if(neg)
 498:	00030b63          	beqz	t1,4ae <printint+0x6c>
    buf[i++] = '-';
 49c:	fd040793          	addi	a5,s0,-48
 4a0:	96be                	add	a3,a3,a5
 4a2:	02d00793          	li	a5,45
 4a6:	fef68823          	sb	a5,-16(a3)
 4aa:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 4ae:	02d05963          	blez	a3,4e0 <printint+0x9e>
 4b2:	89aa                	mv	s3,a0
 4b4:	fc040793          	addi	a5,s0,-64
 4b8:	00d784b3          	add	s1,a5,a3
 4bc:	fff78913          	addi	s2,a5,-1
 4c0:	9936                	add	s2,s2,a3
 4c2:	36fd                	addiw	a3,a3,-1
 4c4:	1682                	slli	a3,a3,0x20
 4c6:	9281                	srli	a3,a3,0x20
 4c8:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 4cc:	fff4c583          	lbu	a1,-1(s1)
 4d0:	854e                	mv	a0,s3
 4d2:	00000097          	auipc	ra,0x0
 4d6:	f4e080e7          	jalr	-178(ra) # 420 <putc>
 4da:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 4dc:	ff2498e3          	bne	s1,s2,4cc <printint+0x8a>
}
 4e0:	70e2                	ld	ra,56(sp)
 4e2:	7442                	ld	s0,48(sp)
 4e4:	74a2                	ld	s1,40(sp)
 4e6:	7902                	ld	s2,32(sp)
 4e8:	69e2                	ld	s3,24(sp)
 4ea:	6121                	addi	sp,sp,64
 4ec:	8082                	ret

00000000000004ee <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4ee:	7119                	addi	sp,sp,-128
 4f0:	fc86                	sd	ra,120(sp)
 4f2:	f8a2                	sd	s0,112(sp)
 4f4:	f4a6                	sd	s1,104(sp)
 4f6:	f0ca                	sd	s2,96(sp)
 4f8:	ecce                	sd	s3,88(sp)
 4fa:	e8d2                	sd	s4,80(sp)
 4fc:	e4d6                	sd	s5,72(sp)
 4fe:	e0da                	sd	s6,64(sp)
 500:	fc5e                	sd	s7,56(sp)
 502:	f862                	sd	s8,48(sp)
 504:	f466                	sd	s9,40(sp)
 506:	f06a                	sd	s10,32(sp)
 508:	ec6e                	sd	s11,24(sp)
 50a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 50c:	0005c483          	lbu	s1,0(a1)
 510:	18048d63          	beqz	s1,6aa <vprintf+0x1bc>
 514:	8aaa                	mv	s5,a0
 516:	8b32                	mv	s6,a2
 518:	00158913          	addi	s2,a1,1
  state = 0;
 51c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 51e:	02500a13          	li	s4,37
      if(c == 'd'){
 522:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 526:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 52a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 52e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 532:	00000b97          	auipc	s7,0x0
 536:	37eb8b93          	addi	s7,s7,894 # 8b0 <digits>
 53a:	a839                	j	558 <vprintf+0x6a>
        putc(fd, c);
 53c:	85a6                	mv	a1,s1
 53e:	8556                	mv	a0,s5
 540:	00000097          	auipc	ra,0x0
 544:	ee0080e7          	jalr	-288(ra) # 420 <putc>
 548:	a019                	j	54e <vprintf+0x60>
    } else if(state == '%'){
 54a:	01498f63          	beq	s3,s4,568 <vprintf+0x7a>
 54e:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 550:	fff94483          	lbu	s1,-1(s2)
 554:	14048b63          	beqz	s1,6aa <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 558:	0004879b          	sext.w	a5,s1
    if(state == 0){
 55c:	fe0997e3          	bnez	s3,54a <vprintf+0x5c>
      if(c == '%'){
 560:	fd479ee3          	bne	a5,s4,53c <vprintf+0x4e>
        state = '%';
 564:	89be                	mv	s3,a5
 566:	b7e5                	j	54e <vprintf+0x60>
      if(c == 'd'){
 568:	05878063          	beq	a5,s8,5a8 <vprintf+0xba>
      } else if(c == 'l') {
 56c:	05978c63          	beq	a5,s9,5c4 <vprintf+0xd6>
      } else if(c == 'x') {
 570:	07a78863          	beq	a5,s10,5e0 <vprintf+0xf2>
      } else if(c == 'p') {
 574:	09b78463          	beq	a5,s11,5fc <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 578:	07300713          	li	a4,115
 57c:	0ce78563          	beq	a5,a4,646 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 580:	06300713          	li	a4,99
 584:	0ee78c63          	beq	a5,a4,67c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 588:	11478663          	beq	a5,s4,694 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 58c:	85d2                	mv	a1,s4
 58e:	8556                	mv	a0,s5
 590:	00000097          	auipc	ra,0x0
 594:	e90080e7          	jalr	-368(ra) # 420 <putc>
        putc(fd, c);
 598:	85a6                	mv	a1,s1
 59a:	8556                	mv	a0,s5
 59c:	00000097          	auipc	ra,0x0
 5a0:	e84080e7          	jalr	-380(ra) # 420 <putc>
      }
      state = 0;
 5a4:	4981                	li	s3,0
 5a6:	b765                	j	54e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5a8:	008b0493          	addi	s1,s6,8
 5ac:	4685                	li	a3,1
 5ae:	4629                	li	a2,10
 5b0:	000b2583          	lw	a1,0(s6)
 5b4:	8556                	mv	a0,s5
 5b6:	00000097          	auipc	ra,0x0
 5ba:	e8c080e7          	jalr	-372(ra) # 442 <printint>
 5be:	8b26                	mv	s6,s1
      state = 0;
 5c0:	4981                	li	s3,0
 5c2:	b771                	j	54e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5c4:	008b0493          	addi	s1,s6,8
 5c8:	4681                	li	a3,0
 5ca:	4629                	li	a2,10
 5cc:	000b2583          	lw	a1,0(s6)
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	e70080e7          	jalr	-400(ra) # 442 <printint>
 5da:	8b26                	mv	s6,s1
      state = 0;
 5dc:	4981                	li	s3,0
 5de:	bf85                	j	54e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5e0:	008b0493          	addi	s1,s6,8
 5e4:	4681                	li	a3,0
 5e6:	4641                	li	a2,16
 5e8:	000b2583          	lw	a1,0(s6)
 5ec:	8556                	mv	a0,s5
 5ee:	00000097          	auipc	ra,0x0
 5f2:	e54080e7          	jalr	-428(ra) # 442 <printint>
 5f6:	8b26                	mv	s6,s1
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	bf91                	j	54e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5fc:	008b0793          	addi	a5,s6,8
 600:	f8f43423          	sd	a5,-120(s0)
 604:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 608:	03000593          	li	a1,48
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	e12080e7          	jalr	-494(ra) # 420 <putc>
  putc(fd, 'x');
 616:	85ea                	mv	a1,s10
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	e06080e7          	jalr	-506(ra) # 420 <putc>
 622:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 624:	03c9d793          	srli	a5,s3,0x3c
 628:	97de                	add	a5,a5,s7
 62a:	0007c583          	lbu	a1,0(a5)
 62e:	8556                	mv	a0,s5
 630:	00000097          	auipc	ra,0x0
 634:	df0080e7          	jalr	-528(ra) # 420 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 638:	0992                	slli	s3,s3,0x4
 63a:	34fd                	addiw	s1,s1,-1
 63c:	f4e5                	bnez	s1,624 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 63e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 642:	4981                	li	s3,0
 644:	b729                	j	54e <vprintf+0x60>
        s = va_arg(ap, char*);
 646:	008b0993          	addi	s3,s6,8
 64a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 64e:	c085                	beqz	s1,66e <vprintf+0x180>
        while(*s != 0){
 650:	0004c583          	lbu	a1,0(s1)
 654:	c9a1                	beqz	a1,6a4 <vprintf+0x1b6>
          putc(fd, *s);
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	dc8080e7          	jalr	-568(ra) # 420 <putc>
          s++;
 660:	0485                	addi	s1,s1,1
        while(*s != 0){
 662:	0004c583          	lbu	a1,0(s1)
 666:	f9e5                	bnez	a1,656 <vprintf+0x168>
        s = va_arg(ap, char*);
 668:	8b4e                	mv	s6,s3
      state = 0;
 66a:	4981                	li	s3,0
 66c:	b5cd                	j	54e <vprintf+0x60>
          s = "(null)";
 66e:	00000497          	auipc	s1,0x0
 672:	25a48493          	addi	s1,s1,602 # 8c8 <digits+0x18>
        while(*s != 0){
 676:	02800593          	li	a1,40
 67a:	bff1                	j	656 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 67c:	008b0493          	addi	s1,s6,8
 680:	000b4583          	lbu	a1,0(s6)
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	d9a080e7          	jalr	-614(ra) # 420 <putc>
 68e:	8b26                	mv	s6,s1
      state = 0;
 690:	4981                	li	s3,0
 692:	bd75                	j	54e <vprintf+0x60>
        putc(fd, c);
 694:	85d2                	mv	a1,s4
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	d88080e7          	jalr	-632(ra) # 420 <putc>
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	b575                	j	54e <vprintf+0x60>
        s = va_arg(ap, char*);
 6a4:	8b4e                	mv	s6,s3
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	b55d                	j	54e <vprintf+0x60>
    }
  }
}
 6aa:	70e6                	ld	ra,120(sp)
 6ac:	7446                	ld	s0,112(sp)
 6ae:	74a6                	ld	s1,104(sp)
 6b0:	7906                	ld	s2,96(sp)
 6b2:	69e6                	ld	s3,88(sp)
 6b4:	6a46                	ld	s4,80(sp)
 6b6:	6aa6                	ld	s5,72(sp)
 6b8:	6b06                	ld	s6,64(sp)
 6ba:	7be2                	ld	s7,56(sp)
 6bc:	7c42                	ld	s8,48(sp)
 6be:	7ca2                	ld	s9,40(sp)
 6c0:	7d02                	ld	s10,32(sp)
 6c2:	6de2                	ld	s11,24(sp)
 6c4:	6109                	addi	sp,sp,128
 6c6:	8082                	ret

00000000000006c8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6c8:	715d                	addi	sp,sp,-80
 6ca:	ec06                	sd	ra,24(sp)
 6cc:	e822                	sd	s0,16(sp)
 6ce:	1000                	addi	s0,sp,32
 6d0:	e010                	sd	a2,0(s0)
 6d2:	e414                	sd	a3,8(s0)
 6d4:	e818                	sd	a4,16(s0)
 6d6:	ec1c                	sd	a5,24(s0)
 6d8:	03043023          	sd	a6,32(s0)
 6dc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6e0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6e4:	8622                	mv	a2,s0
 6e6:	00000097          	auipc	ra,0x0
 6ea:	e08080e7          	jalr	-504(ra) # 4ee <vprintf>
}
 6ee:	60e2                	ld	ra,24(sp)
 6f0:	6442                	ld	s0,16(sp)
 6f2:	6161                	addi	sp,sp,80
 6f4:	8082                	ret

00000000000006f6 <printf>:

void
printf(const char *fmt, ...)
{
 6f6:	711d                	addi	sp,sp,-96
 6f8:	ec06                	sd	ra,24(sp)
 6fa:	e822                	sd	s0,16(sp)
 6fc:	1000                	addi	s0,sp,32
 6fe:	e40c                	sd	a1,8(s0)
 700:	e810                	sd	a2,16(s0)
 702:	ec14                	sd	a3,24(s0)
 704:	f018                	sd	a4,32(s0)
 706:	f41c                	sd	a5,40(s0)
 708:	03043823          	sd	a6,48(s0)
 70c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 710:	00840613          	addi	a2,s0,8
 714:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 718:	85aa                	mv	a1,a0
 71a:	4505                	li	a0,1
 71c:	00000097          	auipc	ra,0x0
 720:	dd2080e7          	jalr	-558(ra) # 4ee <vprintf>
}
 724:	60e2                	ld	ra,24(sp)
 726:	6442                	ld	s0,16(sp)
 728:	6125                	addi	sp,sp,96
 72a:	8082                	ret

000000000000072c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 72c:	1141                	addi	sp,sp,-16
 72e:	e422                	sd	s0,8(sp)
 730:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 732:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 736:	00000797          	auipc	a5,0x0
 73a:	19a78793          	addi	a5,a5,410 # 8d0 <__DATA_BEGIN__>
 73e:	639c                	ld	a5,0(a5)
 740:	a805                	j	770 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 742:	4618                	lw	a4,8(a2)
 744:	9db9                	addw	a1,a1,a4
 746:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 74a:	6398                	ld	a4,0(a5)
 74c:	6318                	ld	a4,0(a4)
 74e:	fee53823          	sd	a4,-16(a0)
 752:	a091                	j	796 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 754:	ff852703          	lw	a4,-8(a0)
 758:	9e39                	addw	a2,a2,a4
 75a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 75c:	ff053703          	ld	a4,-16(a0)
 760:	e398                	sd	a4,0(a5)
 762:	a099                	j	7a8 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 764:	6398                	ld	a4,0(a5)
 766:	00e7e463          	bltu	a5,a4,76e <free+0x42>
 76a:	00e6ea63          	bltu	a3,a4,77e <free+0x52>
{
 76e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 770:	fed7fae3          	bgeu	a5,a3,764 <free+0x38>
 774:	6398                	ld	a4,0(a5)
 776:	00e6e463          	bltu	a3,a4,77e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77a:	fee7eae3          	bltu	a5,a4,76e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 77e:	ff852583          	lw	a1,-8(a0)
 782:	6390                	ld	a2,0(a5)
 784:	02059713          	slli	a4,a1,0x20
 788:	9301                	srli	a4,a4,0x20
 78a:	0712                	slli	a4,a4,0x4
 78c:	9736                	add	a4,a4,a3
 78e:	fae60ae3          	beq	a2,a4,742 <free+0x16>
    bp->s.ptr = p->s.ptr;
 792:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 796:	4790                	lw	a2,8(a5)
 798:	02061713          	slli	a4,a2,0x20
 79c:	9301                	srli	a4,a4,0x20
 79e:	0712                	slli	a4,a4,0x4
 7a0:	973e                	add	a4,a4,a5
 7a2:	fae689e3          	beq	a3,a4,754 <free+0x28>
  } else
    p->s.ptr = bp;
 7a6:	e394                	sd	a3,0(a5)
  freep = p;
 7a8:	00000717          	auipc	a4,0x0
 7ac:	12f73423          	sd	a5,296(a4) # 8d0 <__DATA_BEGIN__>
}
 7b0:	6422                	ld	s0,8(sp)
 7b2:	0141                	addi	sp,sp,16
 7b4:	8082                	ret

00000000000007b6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b6:	7139                	addi	sp,sp,-64
 7b8:	fc06                	sd	ra,56(sp)
 7ba:	f822                	sd	s0,48(sp)
 7bc:	f426                	sd	s1,40(sp)
 7be:	f04a                	sd	s2,32(sp)
 7c0:	ec4e                	sd	s3,24(sp)
 7c2:	e852                	sd	s4,16(sp)
 7c4:	e456                	sd	s5,8(sp)
 7c6:	e05a                	sd	s6,0(sp)
 7c8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ca:	02051993          	slli	s3,a0,0x20
 7ce:	0209d993          	srli	s3,s3,0x20
 7d2:	09bd                	addi	s3,s3,15
 7d4:	0049d993          	srli	s3,s3,0x4
 7d8:	2985                	addiw	s3,s3,1
 7da:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 7de:	00000797          	auipc	a5,0x0
 7e2:	0f278793          	addi	a5,a5,242 # 8d0 <__DATA_BEGIN__>
 7e6:	6388                	ld	a0,0(a5)
 7e8:	c515                	beqz	a0,814 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ea:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7ec:	4798                	lw	a4,8(a5)
 7ee:	03277f63          	bgeu	a4,s2,82c <malloc+0x76>
 7f2:	8a4e                	mv	s4,s3
 7f4:	0009871b          	sext.w	a4,s3
 7f8:	6685                	lui	a3,0x1
 7fa:	00d77363          	bgeu	a4,a3,800 <malloc+0x4a>
 7fe:	6a05                	lui	s4,0x1
 800:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 804:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 808:	00000497          	auipc	s1,0x0
 80c:	0c848493          	addi	s1,s1,200 # 8d0 <__DATA_BEGIN__>
  if(p == (char*)-1)
 810:	5b7d                	li	s6,-1
 812:	a885                	j	882 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 814:	00000797          	auipc	a5,0x0
 818:	0c478793          	addi	a5,a5,196 # 8d8 <base>
 81c:	00000717          	auipc	a4,0x0
 820:	0af73a23          	sd	a5,180(a4) # 8d0 <__DATA_BEGIN__>
 824:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 826:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 82a:	b7e1                	j	7f2 <malloc+0x3c>
      if(p->s.size == nunits)
 82c:	02e90b63          	beq	s2,a4,862 <malloc+0xac>
        p->s.size -= nunits;
 830:	4137073b          	subw	a4,a4,s3
 834:	c798                	sw	a4,8(a5)
        p += p->s.size;
 836:	1702                	slli	a4,a4,0x20
 838:	9301                	srli	a4,a4,0x20
 83a:	0712                	slli	a4,a4,0x4
 83c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 83e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 842:	00000717          	auipc	a4,0x0
 846:	08a73723          	sd	a0,142(a4) # 8d0 <__DATA_BEGIN__>
      return (void*)(p + 1);
 84a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 84e:	70e2                	ld	ra,56(sp)
 850:	7442                	ld	s0,48(sp)
 852:	74a2                	ld	s1,40(sp)
 854:	7902                	ld	s2,32(sp)
 856:	69e2                	ld	s3,24(sp)
 858:	6a42                	ld	s4,16(sp)
 85a:	6aa2                	ld	s5,8(sp)
 85c:	6b02                	ld	s6,0(sp)
 85e:	6121                	addi	sp,sp,64
 860:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 862:	6398                	ld	a4,0(a5)
 864:	e118                	sd	a4,0(a0)
 866:	bff1                	j	842 <malloc+0x8c>
  hp->s.size = nu;
 868:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 86c:	0541                	addi	a0,a0,16
 86e:	00000097          	auipc	ra,0x0
 872:	ebe080e7          	jalr	-322(ra) # 72c <free>
  return freep;
 876:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 878:	d979                	beqz	a0,84e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 87c:	4798                	lw	a4,8(a5)
 87e:	fb2777e3          	bgeu	a4,s2,82c <malloc+0x76>
    if(p == freep)
 882:	6098                	ld	a4,0(s1)
 884:	853e                	mv	a0,a5
 886:	fef71ae3          	bne	a4,a5,87a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 88a:	8552                	mv	a0,s4
 88c:	00000097          	auipc	ra,0x0
 890:	b3c080e7          	jalr	-1220(ra) # 3c8 <sbrk>
  if(p == (char*)-1)
 894:	fd651ae3          	bne	a0,s6,868 <malloc+0xb2>
        return 0;
 898:	4501                	li	a0,0
 89a:	bf55                	j	84e <malloc+0x98>
