
xv6-user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/include/stat.h"
#include "xv6-user/user.h"

char*
fmtname(char *name)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	892a                	mv	s2,a0
  static char buf[STAT_MAX_NAME+1];
  int len = strlen(name);
  10:	00000097          	auipc	ra,0x0
  14:	220080e7          	jalr	544(ra) # 230 <strlen>
  18:	0005049b          	sext.w	s1,a0

  // Return blank-padded name.
  if(len >= STAT_MAX_NAME)
  1c:	47fd                	li	a5,31
  1e:	0097da63          	bge	a5,s1,32 <fmtname+0x32>
    return name;
  memmove(buf, name, len);
  memset(buf + len, ' ', STAT_MAX_NAME - len);
  buf[STAT_MAX_NAME] = '\0';
  return buf;
}
  22:	854a                	mv	a0,s2
  24:	70a2                	ld	ra,40(sp)
  26:	7402                	ld	s0,32(sp)
  28:	64e2                	ld	s1,24(sp)
  2a:	6942                	ld	s2,16(sp)
  2c:	69a2                	ld	s3,8(sp)
  2e:	6145                	addi	sp,sp,48
  30:	8082                	ret
  memmove(buf, name, len);
  32:	00001997          	auipc	s3,0x1
  36:	a0e98993          	addi	s3,s3,-1522 # a40 <buf.1120>
  3a:	8626                	mv	a2,s1
  3c:	85ca                	mv	a1,s2
  3e:	854e                	mv	a0,s3
  40:	00000097          	auipc	ra,0x0
  44:	36e080e7          	jalr	878(ra) # 3ae <memmove>
  memset(buf + len, ' ', STAT_MAX_NAME - len);
  48:	02000613          	li	a2,32
  4c:	9e05                	subw	a2,a2,s1
  4e:	02000593          	li	a1,32
  52:	00998533          	add	a0,s3,s1
  56:	00000097          	auipc	ra,0x0
  5a:	204080e7          	jalr	516(ra) # 25a <memset>
  buf[STAT_MAX_NAME] = '\0';
  5e:	02098023          	sb	zero,32(s3)
  return buf;
  62:	894e                	mv	s2,s3
  64:	bf7d                	j	22 <fmtname+0x22>

0000000000000066 <ls>:

void
ls(char *path)
{
  66:	7119                	addi	sp,sp,-128
  68:	fc86                	sd	ra,120(sp)
  6a:	f8a2                	sd	s0,112(sp)
  6c:	f4a6                	sd	s1,104(sp)
  6e:	f0ca                	sd	s2,96(sp)
  70:	ecce                	sd	s3,88(sp)
  72:	0100                	addi	s0,sp,128
  74:	892a                	mv	s2,a0
  int fd;
  struct stat st;
  char *types[] = {
  76:	f8043023          	sd	zero,-128(s0)
  7a:	00001797          	auipc	a5,0x1
  7e:	93678793          	addi	a5,a5,-1738 # 9b0 <malloc+0xea>
  82:	f8f43423          	sd	a5,-120(s0)
  86:	00001797          	auipc	a5,0x1
  8a:	93278793          	addi	a5,a5,-1742 # 9b8 <malloc+0xf2>
  8e:	f8f43823          	sd	a5,-112(s0)
    [T_DIR]   "DIR ",
    [T_FILE]  "FILE",
  };

  if((fd = open(path, 0)) < 0){
  92:	4581                	li	a1,0
  94:	00000097          	auipc	ra,0x0
  98:	41c080e7          	jalr	1052(ra) # 4b0 <open>
  9c:	06054563          	bltz	a0,106 <ls+0xa0>
  a0:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  a2:	f9840593          	addi	a1,s0,-104
  a6:	00000097          	auipc	ra,0x0
  aa:	422080e7          	jalr	1058(ra) # 4c8 <fstat>
  ae:	06054763          	bltz	a0,11c <ls+0xb6>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  if (st.type == T_DIR){
  b2:	fc041703          	lh	a4,-64(s0)
  b6:	4785                	li	a5,1
  b8:	08f71263          	bne	a4,a5,13c <ls+0xd6>
    while(dir(fd, &st) == 1){
  bc:	4905                	li	s2,1
      printf("%s %s\t%d\n", fmtname(st.name), types[st.type], st.size);
  be:	00001997          	auipc	s3,0x1
  c2:	93298993          	addi	s3,s3,-1742 # 9f0 <malloc+0x12a>
    while(dir(fd, &st) == 1){
  c6:	f9840593          	addi	a1,s0,-104
  ca:	8526                	mv	a0,s1
  cc:	00000097          	auipc	ra,0x0
  d0:	454080e7          	jalr	1108(ra) # 520 <dir>
  d4:	09251d63          	bne	a0,s2,16e <ls+0x108>
      printf("%s %s\t%d\n", fmtname(st.name), types[st.type], st.size);
  d8:	f9840513          	addi	a0,s0,-104
  dc:	00000097          	auipc	ra,0x0
  e0:	f24080e7          	jalr	-220(ra) # 0 <fmtname>
  e4:	fc041783          	lh	a5,-64(s0)
  e8:	078e                	slli	a5,a5,0x3
  ea:	fd040713          	addi	a4,s0,-48
  ee:	97ba                	add	a5,a5,a4
  f0:	fc843683          	ld	a3,-56(s0)
  f4:	fb07b603          	ld	a2,-80(a5)
  f8:	85aa                	mv	a1,a0
  fa:	854e                	mv	a0,s3
  fc:	00000097          	auipc	ra,0x0
 100:	70a080e7          	jalr	1802(ra) # 806 <printf>
 104:	b7c9                	j	c6 <ls+0x60>
    fprintf(2, "ls: cannot open %s\n", path);
 106:	864a                	mv	a2,s2
 108:	00001597          	auipc	a1,0x1
 10c:	8b858593          	addi	a1,a1,-1864 # 9c0 <malloc+0xfa>
 110:	4509                	li	a0,2
 112:	00000097          	auipc	ra,0x0
 116:	6c6080e7          	jalr	1734(ra) # 7d8 <fprintf>
    return;
 11a:	a8b9                	j	178 <ls+0x112>
    fprintf(2, "ls: cannot stat %s\n", path);
 11c:	864a                	mv	a2,s2
 11e:	00001597          	auipc	a1,0x1
 122:	8ba58593          	addi	a1,a1,-1862 # 9d8 <malloc+0x112>
 126:	4509                	li	a0,2
 128:	00000097          	auipc	ra,0x0
 12c:	6b0080e7          	jalr	1712(ra) # 7d8 <fprintf>
    close(fd);
 130:	8526                	mv	a0,s1
 132:	00000097          	auipc	ra,0x0
 136:	366080e7          	jalr	870(ra) # 498 <close>
    return;
 13a:	a83d                	j	178 <ls+0x112>
    }
  } else {
    printf("%s %s\t%l\n", fmtname(st.name), types[st.type], st.size);
 13c:	f9840513          	addi	a0,s0,-104
 140:	00000097          	auipc	ra,0x0
 144:	ec0080e7          	jalr	-320(ra) # 0 <fmtname>
 148:	fc041783          	lh	a5,-64(s0)
 14c:	078e                	slli	a5,a5,0x3
 14e:	fd040713          	addi	a4,s0,-48
 152:	97ba                	add	a5,a5,a4
 154:	fc843683          	ld	a3,-56(s0)
 158:	fb07b603          	ld	a2,-80(a5)
 15c:	85aa                	mv	a1,a0
 15e:	00001517          	auipc	a0,0x1
 162:	8a250513          	addi	a0,a0,-1886 # a00 <malloc+0x13a>
 166:	00000097          	auipc	ra,0x0
 16a:	6a0080e7          	jalr	1696(ra) # 806 <printf>
  }
  close(fd);
 16e:	8526                	mv	a0,s1
 170:	00000097          	auipc	ra,0x0
 174:	328080e7          	jalr	808(ra) # 498 <close>
}
 178:	70e6                	ld	ra,120(sp)
 17a:	7446                	ld	s0,112(sp)
 17c:	74a6                	ld	s1,104(sp)
 17e:	7906                	ld	s2,96(sp)
 180:	69e6                	ld	s3,88(sp)
 182:	6109                	addi	sp,sp,128
 184:	8082                	ret

0000000000000186 <main>:

int
main(int argc, char *argv[])
{
 186:	1101                	addi	sp,sp,-32
 188:	ec06                	sd	ra,24(sp)
 18a:	e822                	sd	s0,16(sp)
 18c:	e426                	sd	s1,8(sp)
 18e:	e04a                	sd	s2,0(sp)
 190:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 192:	4785                	li	a5,1
 194:	02a7d963          	bge	a5,a0,1c6 <main+0x40>
 198:	00858493          	addi	s1,a1,8
 19c:	ffe5091b          	addiw	s2,a0,-2
 1a0:	1902                	slli	s2,s2,0x20
 1a2:	02095913          	srli	s2,s2,0x20
 1a6:	090e                	slli	s2,s2,0x3
 1a8:	05c1                	addi	a1,a1,16
 1aa:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 1ac:	6088                	ld	a0,0(s1)
 1ae:	00000097          	auipc	ra,0x0
 1b2:	eb8080e7          	jalr	-328(ra) # 66 <ls>
 1b6:	04a1                	addi	s1,s1,8
  for(i=1; i<argc; i++)
 1b8:	ff249ae3          	bne	s1,s2,1ac <main+0x26>
  exit(0);
 1bc:	4501                	li	a0,0
 1be:	00000097          	auipc	ra,0x0
 1c2:	2b2080e7          	jalr	690(ra) # 470 <exit>
    ls(".");
 1c6:	00001517          	auipc	a0,0x1
 1ca:	84a50513          	addi	a0,a0,-1974 # a10 <malloc+0x14a>
 1ce:	00000097          	auipc	ra,0x0
 1d2:	e98080e7          	jalr	-360(ra) # 66 <ls>
    exit(0);
 1d6:	4501                	li	a0,0
 1d8:	00000097          	auipc	ra,0x0
 1dc:	298080e7          	jalr	664(ra) # 470 <exit>

00000000000001e0 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
 1e0:	1141                	addi	sp,sp,-16
 1e2:	e422                	sd	s0,8(sp)
 1e4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1e6:	87aa                	mv	a5,a0
 1e8:	0585                	addi	a1,a1,1
 1ea:	0785                	addi	a5,a5,1
 1ec:	fff5c703          	lbu	a4,-1(a1)
 1f0:	fee78fa3          	sb	a4,-1(a5)
 1f4:	fb75                	bnez	a4,1e8 <strcpy+0x8>
    ;
  return os;
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret

00000000000001fc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 202:	00054783          	lbu	a5,0(a0)
 206:	cf91                	beqz	a5,222 <strcmp+0x26>
 208:	0005c703          	lbu	a4,0(a1)
 20c:	00f71b63          	bne	a4,a5,222 <strcmp+0x26>
    p++, q++;
 210:	0505                	addi	a0,a0,1
 212:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 214:	00054783          	lbu	a5,0(a0)
 218:	c789                	beqz	a5,222 <strcmp+0x26>
 21a:	0005c703          	lbu	a4,0(a1)
 21e:	fef709e3          	beq	a4,a5,210 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 222:	0005c503          	lbu	a0,0(a1)
}
 226:	40a7853b          	subw	a0,a5,a0
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret

0000000000000230 <strlen>:

uint
strlen(const char *s)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 236:	00054783          	lbu	a5,0(a0)
 23a:	cf91                	beqz	a5,256 <strlen+0x26>
 23c:	0505                	addi	a0,a0,1
 23e:	87aa                	mv	a5,a0
 240:	4685                	li	a3,1
 242:	9e89                	subw	a3,a3,a0
    ;
 244:	00f6853b          	addw	a0,a3,a5
 248:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 24a:	fff7c703          	lbu	a4,-1(a5)
 24e:	fb7d                	bnez	a4,244 <strlen+0x14>
  return n;
}
 250:	6422                	ld	s0,8(sp)
 252:	0141                	addi	sp,sp,16
 254:	8082                	ret
  for(n = 0; s[n]; n++)
 256:	4501                	li	a0,0
 258:	bfe5                	j	250 <strlen+0x20>

000000000000025a <memset>:

void*
memset(void *dst, int c, uint n)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 260:	ce09                	beqz	a2,27a <memset+0x20>
 262:	87aa                	mv	a5,a0
 264:	fff6071b          	addiw	a4,a2,-1
 268:	1702                	slli	a4,a4,0x20
 26a:	9301                	srli	a4,a4,0x20
 26c:	0705                	addi	a4,a4,1
 26e:	972a                	add	a4,a4,a0
    cdst[i] = c;
 270:	00b78023          	sb	a1,0(a5)
 274:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 276:	fee79de3          	bne	a5,a4,270 <memset+0x16>
  }
  return dst;
}
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret

0000000000000280 <strchr>:

char*
strchr(const char *s, char c)
{
 280:	1141                	addi	sp,sp,-16
 282:	e422                	sd	s0,8(sp)
 284:	0800                	addi	s0,sp,16
  for(; *s; s++)
 286:	00054783          	lbu	a5,0(a0)
 28a:	cf91                	beqz	a5,2a6 <strchr+0x26>
    if(*s == c)
 28c:	00f58a63          	beq	a1,a5,2a0 <strchr+0x20>
  for(; *s; s++)
 290:	0505                	addi	a0,a0,1
 292:	00054783          	lbu	a5,0(a0)
 296:	c781                	beqz	a5,29e <strchr+0x1e>
    if(*s == c)
 298:	feb79ce3          	bne	a5,a1,290 <strchr+0x10>
 29c:	a011                	j	2a0 <strchr+0x20>
      return (char*)s;
  return 0;
 29e:	4501                	li	a0,0
}
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret
  return 0;
 2a6:	4501                	li	a0,0
 2a8:	bfe5                	j	2a0 <strchr+0x20>

00000000000002aa <gets>:

char*
gets(char *buf, int max)
{
 2aa:	711d                	addi	sp,sp,-96
 2ac:	ec86                	sd	ra,88(sp)
 2ae:	e8a2                	sd	s0,80(sp)
 2b0:	e4a6                	sd	s1,72(sp)
 2b2:	e0ca                	sd	s2,64(sp)
 2b4:	fc4e                	sd	s3,56(sp)
 2b6:	f852                	sd	s4,48(sp)
 2b8:	f456                	sd	s5,40(sp)
 2ba:	f05a                	sd	s6,32(sp)
 2bc:	ec5e                	sd	s7,24(sp)
 2be:	1080                	addi	s0,sp,96
 2c0:	8baa                	mv	s7,a0
 2c2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c4:	892a                	mv	s2,a0
 2c6:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2c8:	4aa9                	li	s5,10
 2ca:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2cc:	0019849b          	addiw	s1,s3,1
 2d0:	0344d863          	bge	s1,s4,300 <gets+0x56>
    cc = read(0, &c, 1);
 2d4:	4605                	li	a2,1
 2d6:	faf40593          	addi	a1,s0,-81
 2da:	4501                	li	a0,0
 2dc:	00000097          	auipc	ra,0x0
 2e0:	1ac080e7          	jalr	428(ra) # 488 <read>
    if(cc < 1)
 2e4:	00a05e63          	blez	a0,300 <gets+0x56>
    buf[i++] = c;
 2e8:	faf44783          	lbu	a5,-81(s0)
 2ec:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2f0:	01578763          	beq	a5,s5,2fe <gets+0x54>
 2f4:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 2f6:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 2f8:	fd679ae3          	bne	a5,s6,2cc <gets+0x22>
 2fc:	a011                	j	300 <gets+0x56>
  for(i=0; i+1 < max; ){
 2fe:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 300:	99de                	add	s3,s3,s7
 302:	00098023          	sb	zero,0(s3)
  return buf;
}
 306:	855e                	mv	a0,s7
 308:	60e6                	ld	ra,88(sp)
 30a:	6446                	ld	s0,80(sp)
 30c:	64a6                	ld	s1,72(sp)
 30e:	6906                	ld	s2,64(sp)
 310:	79e2                	ld	s3,56(sp)
 312:	7a42                	ld	s4,48(sp)
 314:	7aa2                	ld	s5,40(sp)
 316:	7b02                	ld	s6,32(sp)
 318:	6be2                	ld	s7,24(sp)
 31a:	6125                	addi	sp,sp,96
 31c:	8082                	ret

000000000000031e <stat>:

int
stat(const char *n, struct stat *st)
{
 31e:	1101                	addi	sp,sp,-32
 320:	ec06                	sd	ra,24(sp)
 322:	e822                	sd	s0,16(sp)
 324:	e426                	sd	s1,8(sp)
 326:	e04a                	sd	s2,0(sp)
 328:	1000                	addi	s0,sp,32
 32a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 32c:	4581                	li	a1,0
 32e:	00000097          	auipc	ra,0x0
 332:	182080e7          	jalr	386(ra) # 4b0 <open>
  if(fd < 0)
 336:	02054563          	bltz	a0,360 <stat+0x42>
 33a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 33c:	85ca                	mv	a1,s2
 33e:	00000097          	auipc	ra,0x0
 342:	18a080e7          	jalr	394(ra) # 4c8 <fstat>
 346:	892a                	mv	s2,a0
  close(fd);
 348:	8526                	mv	a0,s1
 34a:	00000097          	auipc	ra,0x0
 34e:	14e080e7          	jalr	334(ra) # 498 <close>
  return r;
}
 352:	854a                	mv	a0,s2
 354:	60e2                	ld	ra,24(sp)
 356:	6442                	ld	s0,16(sp)
 358:	64a2                	ld	s1,8(sp)
 35a:	6902                	ld	s2,0(sp)
 35c:	6105                	addi	sp,sp,32
 35e:	8082                	ret
    return -1;
 360:	597d                	li	s2,-1
 362:	bfc5                	j	352 <stat+0x34>

0000000000000364 <atoi>:

int
atoi(const char *s)
{
 364:	1141                	addi	sp,sp,-16
 366:	e422                	sd	s0,8(sp)
 368:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 36a:	00054683          	lbu	a3,0(a0)
 36e:	fd06879b          	addiw	a5,a3,-48
 372:	0ff7f793          	andi	a5,a5,255
 376:	4725                	li	a4,9
 378:	02f76963          	bltu	a4,a5,3aa <atoi+0x46>
 37c:	862a                	mv	a2,a0
  n = 0;
 37e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 380:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 382:	0605                	addi	a2,a2,1
 384:	0025179b          	slliw	a5,a0,0x2
 388:	9fa9                	addw	a5,a5,a0
 38a:	0017979b          	slliw	a5,a5,0x1
 38e:	9fb5                	addw	a5,a5,a3
 390:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 394:	00064683          	lbu	a3,0(a2)
 398:	fd06871b          	addiw	a4,a3,-48
 39c:	0ff77713          	andi	a4,a4,255
 3a0:	fee5f1e3          	bgeu	a1,a4,382 <atoi+0x1e>
  return n;
}
 3a4:	6422                	ld	s0,8(sp)
 3a6:	0141                	addi	sp,sp,16
 3a8:	8082                	ret
  n = 0;
 3aa:	4501                	li	a0,0
 3ac:	bfe5                	j	3a4 <atoi+0x40>

00000000000003ae <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e422                	sd	s0,8(sp)
 3b2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3b4:	02b57663          	bgeu	a0,a1,3e0 <memmove+0x32>
    while(n-- > 0)
 3b8:	02c05163          	blez	a2,3da <memmove+0x2c>
 3bc:	fff6079b          	addiw	a5,a2,-1
 3c0:	1782                	slli	a5,a5,0x20
 3c2:	9381                	srli	a5,a5,0x20
 3c4:	0785                	addi	a5,a5,1
 3c6:	97aa                	add	a5,a5,a0
  dst = vdst;
 3c8:	872a                	mv	a4,a0
      *dst++ = *src++;
 3ca:	0585                	addi	a1,a1,1
 3cc:	0705                	addi	a4,a4,1
 3ce:	fff5c683          	lbu	a3,-1(a1)
 3d2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3d6:	fee79ae3          	bne	a5,a4,3ca <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3da:	6422                	ld	s0,8(sp)
 3dc:	0141                	addi	sp,sp,16
 3de:	8082                	ret
    dst += n;
 3e0:	00c50733          	add	a4,a0,a2
    src += n;
 3e4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3e6:	fec05ae3          	blez	a2,3da <memmove+0x2c>
 3ea:	fff6079b          	addiw	a5,a2,-1
 3ee:	1782                	slli	a5,a5,0x20
 3f0:	9381                	srli	a5,a5,0x20
 3f2:	fff7c793          	not	a5,a5
 3f6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3f8:	15fd                	addi	a1,a1,-1
 3fa:	177d                	addi	a4,a4,-1
 3fc:	0005c683          	lbu	a3,0(a1)
 400:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 404:	fef71ae3          	bne	a4,a5,3f8 <memmove+0x4a>
 408:	bfc9                	j	3da <memmove+0x2c>

000000000000040a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 40a:	1141                	addi	sp,sp,-16
 40c:	e422                	sd	s0,8(sp)
 40e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 410:	ce15                	beqz	a2,44c <memcmp+0x42>
 412:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 416:	00054783          	lbu	a5,0(a0)
 41a:	0005c703          	lbu	a4,0(a1)
 41e:	02e79063          	bne	a5,a4,43e <memcmp+0x34>
 422:	1682                	slli	a3,a3,0x20
 424:	9281                	srli	a3,a3,0x20
 426:	0685                	addi	a3,a3,1
 428:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 42a:	0505                	addi	a0,a0,1
    p2++;
 42c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 42e:	00d50d63          	beq	a0,a3,448 <memcmp+0x3e>
    if (*p1 != *p2) {
 432:	00054783          	lbu	a5,0(a0)
 436:	0005c703          	lbu	a4,0(a1)
 43a:	fee788e3          	beq	a5,a4,42a <memcmp+0x20>
      return *p1 - *p2;
 43e:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 442:	6422                	ld	s0,8(sp)
 444:	0141                	addi	sp,sp,16
 446:	8082                	ret
  return 0;
 448:	4501                	li	a0,0
 44a:	bfe5                	j	442 <memcmp+0x38>
 44c:	4501                	li	a0,0
 44e:	bfd5                	j	442 <memcmp+0x38>

0000000000000450 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 450:	1141                	addi	sp,sp,-16
 452:	e406                	sd	ra,8(sp)
 454:	e022                	sd	s0,0(sp)
 456:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 458:	00000097          	auipc	ra,0x0
 45c:	f56080e7          	jalr	-170(ra) # 3ae <memmove>
}
 460:	60a2                	ld	ra,8(sp)
 462:	6402                	ld	s0,0(sp)
 464:	0141                	addi	sp,sp,16
 466:	8082                	ret

0000000000000468 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 468:	4885                	li	a7,1
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <exit>:
.global exit
exit:
 li a7, SYS_exit
 470:	4889                	li	a7,2
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <wait>:
.global wait
wait:
 li a7, SYS_wait
 478:	488d                	li	a7,3
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 480:	4891                	li	a7,4
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <read>:
.global read
read:
 li a7, SYS_read
 488:	4895                	li	a7,5
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <write>:
.global write
write:
 li a7, SYS_write
 490:	48c1                	li	a7,16
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <close>:
.global close
close:
 li a7, SYS_close
 498:	48d5                	li	a7,21
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4a0:	4899                	li	a7,6
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4a8:	489d                	li	a7,7
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <open>:
.global open
open:
 li a7, SYS_open
 4b0:	48bd                	li	a7,15
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4b8:	48c5                	li	a7,17
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4c0:	48c9                	li	a7,18
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4c8:	48a1                	li	a7,8
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <link>:
.global link
link:
 li a7, SYS_link
 4d0:	48cd                	li	a7,19
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4d8:	48d1                	li	a7,20
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4e0:	48a5                	li	a7,9
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4e8:	48a9                	li	a7,10
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4f0:	48ad                	li	a7,11
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4f8:	48b1                	li	a7,12
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 500:	48b5                	li	a7,13
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 508:	48b9                	li	a7,14
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 510:	48d9                	li	a7,22
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <dev>:
.global dev
dev:
 li a7, SYS_dev
 518:	48dd                	li	a7,23
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <dir>:
.global dir
dir:
 li a7, SYS_dir
 520:	48e1                	li	a7,24
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 528:	48e5                	li	a7,25
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 530:	1101                	addi	sp,sp,-32
 532:	ec06                	sd	ra,24(sp)
 534:	e822                	sd	s0,16(sp)
 536:	1000                	addi	s0,sp,32
 538:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 53c:	4605                	li	a2,1
 53e:	fef40593          	addi	a1,s0,-17
 542:	00000097          	auipc	ra,0x0
 546:	f4e080e7          	jalr	-178(ra) # 490 <write>
}
 54a:	60e2                	ld	ra,24(sp)
 54c:	6442                	ld	s0,16(sp)
 54e:	6105                	addi	sp,sp,32
 550:	8082                	ret

0000000000000552 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 552:	7139                	addi	sp,sp,-64
 554:	fc06                	sd	ra,56(sp)
 556:	f822                	sd	s0,48(sp)
 558:	f426                	sd	s1,40(sp)
 55a:	f04a                	sd	s2,32(sp)
 55c:	ec4e                	sd	s3,24(sp)
 55e:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 560:	c299                	beqz	a3,566 <printint+0x14>
 562:	0005cd63          	bltz	a1,57c <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 566:	2581                	sext.w	a1,a1
  neg = 0;
 568:	4301                	li	t1,0
 56a:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 56e:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 570:	2601                	sext.w	a2,a2
 572:	00000897          	auipc	a7,0x0
 576:	4a688893          	addi	a7,a7,1190 # a18 <digits>
 57a:	a039                	j	588 <printint+0x36>
    x = -xx;
 57c:	40b005bb          	negw	a1,a1
    neg = 1;
 580:	4305                	li	t1,1
    x = -xx;
 582:	b7e5                	j	56a <printint+0x18>
  }while((x /= base) != 0);
 584:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 586:	8836                	mv	a6,a3
 588:	0018069b          	addiw	a3,a6,1
 58c:	02c5f7bb          	remuw	a5,a1,a2
 590:	1782                	slli	a5,a5,0x20
 592:	9381                	srli	a5,a5,0x20
 594:	97c6                	add	a5,a5,a7
 596:	0007c783          	lbu	a5,0(a5)
 59a:	00f70023          	sb	a5,0(a4)
 59e:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 5a0:	02c5d7bb          	divuw	a5,a1,a2
 5a4:	fec5f0e3          	bgeu	a1,a2,584 <printint+0x32>
  if(neg)
 5a8:	00030b63          	beqz	t1,5be <printint+0x6c>
    buf[i++] = '-';
 5ac:	fd040793          	addi	a5,s0,-48
 5b0:	96be                	add	a3,a3,a5
 5b2:	02d00793          	li	a5,45
 5b6:	fef68823          	sb	a5,-16(a3)
 5ba:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 5be:	02d05963          	blez	a3,5f0 <printint+0x9e>
 5c2:	89aa                	mv	s3,a0
 5c4:	fc040793          	addi	a5,s0,-64
 5c8:	00d784b3          	add	s1,a5,a3
 5cc:	fff78913          	addi	s2,a5,-1
 5d0:	9936                	add	s2,s2,a3
 5d2:	36fd                	addiw	a3,a3,-1
 5d4:	1682                	slli	a3,a3,0x20
 5d6:	9281                	srli	a3,a3,0x20
 5d8:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 5dc:	fff4c583          	lbu	a1,-1(s1)
 5e0:	854e                	mv	a0,s3
 5e2:	00000097          	auipc	ra,0x0
 5e6:	f4e080e7          	jalr	-178(ra) # 530 <putc>
 5ea:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 5ec:	ff2498e3          	bne	s1,s2,5dc <printint+0x8a>
}
 5f0:	70e2                	ld	ra,56(sp)
 5f2:	7442                	ld	s0,48(sp)
 5f4:	74a2                	ld	s1,40(sp)
 5f6:	7902                	ld	s2,32(sp)
 5f8:	69e2                	ld	s3,24(sp)
 5fa:	6121                	addi	sp,sp,64
 5fc:	8082                	ret

00000000000005fe <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5fe:	7119                	addi	sp,sp,-128
 600:	fc86                	sd	ra,120(sp)
 602:	f8a2                	sd	s0,112(sp)
 604:	f4a6                	sd	s1,104(sp)
 606:	f0ca                	sd	s2,96(sp)
 608:	ecce                	sd	s3,88(sp)
 60a:	e8d2                	sd	s4,80(sp)
 60c:	e4d6                	sd	s5,72(sp)
 60e:	e0da                	sd	s6,64(sp)
 610:	fc5e                	sd	s7,56(sp)
 612:	f862                	sd	s8,48(sp)
 614:	f466                	sd	s9,40(sp)
 616:	f06a                	sd	s10,32(sp)
 618:	ec6e                	sd	s11,24(sp)
 61a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 61c:	0005c483          	lbu	s1,0(a1)
 620:	18048d63          	beqz	s1,7ba <vprintf+0x1bc>
 624:	8aaa                	mv	s5,a0
 626:	8b32                	mv	s6,a2
 628:	00158913          	addi	s2,a1,1
  state = 0;
 62c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 62e:	02500a13          	li	s4,37
      if(c == 'd'){
 632:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 636:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 63a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 63e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 642:	00000b97          	auipc	s7,0x0
 646:	3d6b8b93          	addi	s7,s7,982 # a18 <digits>
 64a:	a839                	j	668 <vprintf+0x6a>
        putc(fd, c);
 64c:	85a6                	mv	a1,s1
 64e:	8556                	mv	a0,s5
 650:	00000097          	auipc	ra,0x0
 654:	ee0080e7          	jalr	-288(ra) # 530 <putc>
 658:	a019                	j	65e <vprintf+0x60>
    } else if(state == '%'){
 65a:	01498f63          	beq	s3,s4,678 <vprintf+0x7a>
 65e:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 660:	fff94483          	lbu	s1,-1(s2)
 664:	14048b63          	beqz	s1,7ba <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 668:	0004879b          	sext.w	a5,s1
    if(state == 0){
 66c:	fe0997e3          	bnez	s3,65a <vprintf+0x5c>
      if(c == '%'){
 670:	fd479ee3          	bne	a5,s4,64c <vprintf+0x4e>
        state = '%';
 674:	89be                	mv	s3,a5
 676:	b7e5                	j	65e <vprintf+0x60>
      if(c == 'd'){
 678:	05878063          	beq	a5,s8,6b8 <vprintf+0xba>
      } else if(c == 'l') {
 67c:	05978c63          	beq	a5,s9,6d4 <vprintf+0xd6>
      } else if(c == 'x') {
 680:	07a78863          	beq	a5,s10,6f0 <vprintf+0xf2>
      } else if(c == 'p') {
 684:	09b78463          	beq	a5,s11,70c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 688:	07300713          	li	a4,115
 68c:	0ce78563          	beq	a5,a4,756 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 690:	06300713          	li	a4,99
 694:	0ee78c63          	beq	a5,a4,78c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 698:	11478663          	beq	a5,s4,7a4 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 69c:	85d2                	mv	a1,s4
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	e90080e7          	jalr	-368(ra) # 530 <putc>
        putc(fd, c);
 6a8:	85a6                	mv	a1,s1
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	e84080e7          	jalr	-380(ra) # 530 <putc>
      }
      state = 0;
 6b4:	4981                	li	s3,0
 6b6:	b765                	j	65e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6b8:	008b0493          	addi	s1,s6,8
 6bc:	4685                	li	a3,1
 6be:	4629                	li	a2,10
 6c0:	000b2583          	lw	a1,0(s6)
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	e8c080e7          	jalr	-372(ra) # 552 <printint>
 6ce:	8b26                	mv	s6,s1
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	b771                	j	65e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d4:	008b0493          	addi	s1,s6,8
 6d8:	4681                	li	a3,0
 6da:	4629                	li	a2,10
 6dc:	000b2583          	lw	a1,0(s6)
 6e0:	8556                	mv	a0,s5
 6e2:	00000097          	auipc	ra,0x0
 6e6:	e70080e7          	jalr	-400(ra) # 552 <printint>
 6ea:	8b26                	mv	s6,s1
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bf85                	j	65e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6f0:	008b0493          	addi	s1,s6,8
 6f4:	4681                	li	a3,0
 6f6:	4641                	li	a2,16
 6f8:	000b2583          	lw	a1,0(s6)
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	e54080e7          	jalr	-428(ra) # 552 <printint>
 706:	8b26                	mv	s6,s1
      state = 0;
 708:	4981                	li	s3,0
 70a:	bf91                	j	65e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 70c:	008b0793          	addi	a5,s6,8
 710:	f8f43423          	sd	a5,-120(s0)
 714:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 718:	03000593          	li	a1,48
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	e12080e7          	jalr	-494(ra) # 530 <putc>
  putc(fd, 'x');
 726:	85ea                	mv	a1,s10
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	e06080e7          	jalr	-506(ra) # 530 <putc>
 732:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 734:	03c9d793          	srli	a5,s3,0x3c
 738:	97de                	add	a5,a5,s7
 73a:	0007c583          	lbu	a1,0(a5)
 73e:	8556                	mv	a0,s5
 740:	00000097          	auipc	ra,0x0
 744:	df0080e7          	jalr	-528(ra) # 530 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 748:	0992                	slli	s3,s3,0x4
 74a:	34fd                	addiw	s1,s1,-1
 74c:	f4e5                	bnez	s1,734 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 74e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 752:	4981                	li	s3,0
 754:	b729                	j	65e <vprintf+0x60>
        s = va_arg(ap, char*);
 756:	008b0993          	addi	s3,s6,8
 75a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 75e:	c085                	beqz	s1,77e <vprintf+0x180>
        while(*s != 0){
 760:	0004c583          	lbu	a1,0(s1)
 764:	c9a1                	beqz	a1,7b4 <vprintf+0x1b6>
          putc(fd, *s);
 766:	8556                	mv	a0,s5
 768:	00000097          	auipc	ra,0x0
 76c:	dc8080e7          	jalr	-568(ra) # 530 <putc>
          s++;
 770:	0485                	addi	s1,s1,1
        while(*s != 0){
 772:	0004c583          	lbu	a1,0(s1)
 776:	f9e5                	bnez	a1,766 <vprintf+0x168>
        s = va_arg(ap, char*);
 778:	8b4e                	mv	s6,s3
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b5cd                	j	65e <vprintf+0x60>
          s = "(null)";
 77e:	00000497          	auipc	s1,0x0
 782:	2b248493          	addi	s1,s1,690 # a30 <digits+0x18>
        while(*s != 0){
 786:	02800593          	li	a1,40
 78a:	bff1                	j	766 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 78c:	008b0493          	addi	s1,s6,8
 790:	000b4583          	lbu	a1,0(s6)
 794:	8556                	mv	a0,s5
 796:	00000097          	auipc	ra,0x0
 79a:	d9a080e7          	jalr	-614(ra) # 530 <putc>
 79e:	8b26                	mv	s6,s1
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	bd75                	j	65e <vprintf+0x60>
        putc(fd, c);
 7a4:	85d2                	mv	a1,s4
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	d88080e7          	jalr	-632(ra) # 530 <putc>
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	b575                	j	65e <vprintf+0x60>
        s = va_arg(ap, char*);
 7b4:	8b4e                	mv	s6,s3
      state = 0;
 7b6:	4981                	li	s3,0
 7b8:	b55d                	j	65e <vprintf+0x60>
    }
  }
}
 7ba:	70e6                	ld	ra,120(sp)
 7bc:	7446                	ld	s0,112(sp)
 7be:	74a6                	ld	s1,104(sp)
 7c0:	7906                	ld	s2,96(sp)
 7c2:	69e6                	ld	s3,88(sp)
 7c4:	6a46                	ld	s4,80(sp)
 7c6:	6aa6                	ld	s5,72(sp)
 7c8:	6b06                	ld	s6,64(sp)
 7ca:	7be2                	ld	s7,56(sp)
 7cc:	7c42                	ld	s8,48(sp)
 7ce:	7ca2                	ld	s9,40(sp)
 7d0:	7d02                	ld	s10,32(sp)
 7d2:	6de2                	ld	s11,24(sp)
 7d4:	6109                	addi	sp,sp,128
 7d6:	8082                	ret

00000000000007d8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7d8:	715d                	addi	sp,sp,-80
 7da:	ec06                	sd	ra,24(sp)
 7dc:	e822                	sd	s0,16(sp)
 7de:	1000                	addi	s0,sp,32
 7e0:	e010                	sd	a2,0(s0)
 7e2:	e414                	sd	a3,8(s0)
 7e4:	e818                	sd	a4,16(s0)
 7e6:	ec1c                	sd	a5,24(s0)
 7e8:	03043023          	sd	a6,32(s0)
 7ec:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7f0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7f4:	8622                	mv	a2,s0
 7f6:	00000097          	auipc	ra,0x0
 7fa:	e08080e7          	jalr	-504(ra) # 5fe <vprintf>
}
 7fe:	60e2                	ld	ra,24(sp)
 800:	6442                	ld	s0,16(sp)
 802:	6161                	addi	sp,sp,80
 804:	8082                	ret

0000000000000806 <printf>:

void
printf(const char *fmt, ...)
{
 806:	711d                	addi	sp,sp,-96
 808:	ec06                	sd	ra,24(sp)
 80a:	e822                	sd	s0,16(sp)
 80c:	1000                	addi	s0,sp,32
 80e:	e40c                	sd	a1,8(s0)
 810:	e810                	sd	a2,16(s0)
 812:	ec14                	sd	a3,24(s0)
 814:	f018                	sd	a4,32(s0)
 816:	f41c                	sd	a5,40(s0)
 818:	03043823          	sd	a6,48(s0)
 81c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 820:	00840613          	addi	a2,s0,8
 824:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 828:	85aa                	mv	a1,a0
 82a:	4505                	li	a0,1
 82c:	00000097          	auipc	ra,0x0
 830:	dd2080e7          	jalr	-558(ra) # 5fe <vprintf>
}
 834:	60e2                	ld	ra,24(sp)
 836:	6442                	ld	s0,16(sp)
 838:	6125                	addi	sp,sp,96
 83a:	8082                	ret

000000000000083c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 83c:	1141                	addi	sp,sp,-16
 83e:	e422                	sd	s0,8(sp)
 840:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 842:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 846:	00000797          	auipc	a5,0x0
 84a:	1f278793          	addi	a5,a5,498 # a38 <__DATA_BEGIN__>
 84e:	639c                	ld	a5,0(a5)
 850:	a805                	j	880 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 852:	4618                	lw	a4,8(a2)
 854:	9db9                	addw	a1,a1,a4
 856:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 85a:	6398                	ld	a4,0(a5)
 85c:	6318                	ld	a4,0(a4)
 85e:	fee53823          	sd	a4,-16(a0)
 862:	a091                	j	8a6 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 864:	ff852703          	lw	a4,-8(a0)
 868:	9e39                	addw	a2,a2,a4
 86a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 86c:	ff053703          	ld	a4,-16(a0)
 870:	e398                	sd	a4,0(a5)
 872:	a099                	j	8b8 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 874:	6398                	ld	a4,0(a5)
 876:	00e7e463          	bltu	a5,a4,87e <free+0x42>
 87a:	00e6ea63          	bltu	a3,a4,88e <free+0x52>
{
 87e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 880:	fed7fae3          	bgeu	a5,a3,874 <free+0x38>
 884:	6398                	ld	a4,0(a5)
 886:	00e6e463          	bltu	a3,a4,88e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88a:	fee7eae3          	bltu	a5,a4,87e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 88e:	ff852583          	lw	a1,-8(a0)
 892:	6390                	ld	a2,0(a5)
 894:	02059713          	slli	a4,a1,0x20
 898:	9301                	srli	a4,a4,0x20
 89a:	0712                	slli	a4,a4,0x4
 89c:	9736                	add	a4,a4,a3
 89e:	fae60ae3          	beq	a2,a4,852 <free+0x16>
    bp->s.ptr = p->s.ptr;
 8a2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8a6:	4790                	lw	a2,8(a5)
 8a8:	02061713          	slli	a4,a2,0x20
 8ac:	9301                	srli	a4,a4,0x20
 8ae:	0712                	slli	a4,a4,0x4
 8b0:	973e                	add	a4,a4,a5
 8b2:	fae689e3          	beq	a3,a4,864 <free+0x28>
  } else
    p->s.ptr = bp;
 8b6:	e394                	sd	a3,0(a5)
  freep = p;
 8b8:	00000717          	auipc	a4,0x0
 8bc:	18f73023          	sd	a5,384(a4) # a38 <__DATA_BEGIN__>
}
 8c0:	6422                	ld	s0,8(sp)
 8c2:	0141                	addi	sp,sp,16
 8c4:	8082                	ret

00000000000008c6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8c6:	7139                	addi	sp,sp,-64
 8c8:	fc06                	sd	ra,56(sp)
 8ca:	f822                	sd	s0,48(sp)
 8cc:	f426                	sd	s1,40(sp)
 8ce:	f04a                	sd	s2,32(sp)
 8d0:	ec4e                	sd	s3,24(sp)
 8d2:	e852                	sd	s4,16(sp)
 8d4:	e456                	sd	s5,8(sp)
 8d6:	e05a                	sd	s6,0(sp)
 8d8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8da:	02051993          	slli	s3,a0,0x20
 8de:	0209d993          	srli	s3,s3,0x20
 8e2:	09bd                	addi	s3,s3,15
 8e4:	0049d993          	srli	s3,s3,0x4
 8e8:	2985                	addiw	s3,s3,1
 8ea:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8ee:	00000797          	auipc	a5,0x0
 8f2:	14a78793          	addi	a5,a5,330 # a38 <__DATA_BEGIN__>
 8f6:	6388                	ld	a0,0(a5)
 8f8:	c515                	beqz	a0,924 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8fc:	4798                	lw	a4,8(a5)
 8fe:	03277f63          	bgeu	a4,s2,93c <malloc+0x76>
 902:	8a4e                	mv	s4,s3
 904:	0009871b          	sext.w	a4,s3
 908:	6685                	lui	a3,0x1
 90a:	00d77363          	bgeu	a4,a3,910 <malloc+0x4a>
 90e:	6a05                	lui	s4,0x1
 910:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 914:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 918:	00000497          	auipc	s1,0x0
 91c:	12048493          	addi	s1,s1,288 # a38 <__DATA_BEGIN__>
  if(p == (char*)-1)
 920:	5b7d                	li	s6,-1
 922:	a885                	j	992 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 924:	00000797          	auipc	a5,0x0
 928:	14478793          	addi	a5,a5,324 # a68 <base>
 92c:	00000717          	auipc	a4,0x0
 930:	10f73623          	sd	a5,268(a4) # a38 <__DATA_BEGIN__>
 934:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 936:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 93a:	b7e1                	j	902 <malloc+0x3c>
      if(p->s.size == nunits)
 93c:	02e90b63          	beq	s2,a4,972 <malloc+0xac>
        p->s.size -= nunits;
 940:	4137073b          	subw	a4,a4,s3
 944:	c798                	sw	a4,8(a5)
        p += p->s.size;
 946:	1702                	slli	a4,a4,0x20
 948:	9301                	srli	a4,a4,0x20
 94a:	0712                	slli	a4,a4,0x4
 94c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 94e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 952:	00000717          	auipc	a4,0x0
 956:	0ea73323          	sd	a0,230(a4) # a38 <__DATA_BEGIN__>
      return (void*)(p + 1);
 95a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 95e:	70e2                	ld	ra,56(sp)
 960:	7442                	ld	s0,48(sp)
 962:	74a2                	ld	s1,40(sp)
 964:	7902                	ld	s2,32(sp)
 966:	69e2                	ld	s3,24(sp)
 968:	6a42                	ld	s4,16(sp)
 96a:	6aa2                	ld	s5,8(sp)
 96c:	6b02                	ld	s6,0(sp)
 96e:	6121                	addi	sp,sp,64
 970:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 972:	6398                	ld	a4,0(a5)
 974:	e118                	sd	a4,0(a0)
 976:	bff1                	j	952 <malloc+0x8c>
  hp->s.size = nu;
 978:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 97c:	0541                	addi	a0,a0,16
 97e:	00000097          	auipc	ra,0x0
 982:	ebe080e7          	jalr	-322(ra) # 83c <free>
  return freep;
 986:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 988:	d979                	beqz	a0,95e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 98a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 98c:	4798                	lw	a4,8(a5)
 98e:	fb2777e3          	bgeu	a4,s2,93c <malloc+0x76>
    if(p == freep)
 992:	6098                	ld	a4,0(s1)
 994:	853e                	mv	a0,a5
 996:	fef71ae3          	bne	a4,a5,98a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 99a:	8552                	mv	a0,s4
 99c:	00000097          	auipc	ra,0x0
 9a0:	b5c080e7          	jalr	-1188(ra) # 4f8 <sbrk>
  if(p == (char*)-1)
 9a4:	fd651ae3          	bne	a0,s6,978 <malloc+0xb2>
        return 0;
 9a8:	4501                	li	a0,0
 9aa:	bf55                	j	95e <malloc+0x98>
