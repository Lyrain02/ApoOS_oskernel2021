
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
  14:	24e080e7          	jalr	590(ra) # 25e <strlen>
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
  36:	a5698993          	addi	s3,s3,-1450 # a88 <buf.1124>
  3a:	8626                	mv	a2,s1
  3c:	85ca                	mv	a1,s2
  3e:	854e                	mv	a0,s3
  40:	00000097          	auipc	ra,0x0
  44:	3b2080e7          	jalr	946(ra) # 3f2 <memmove>
  memset(buf + len, ' ', STAT_MAX_NAME - len);
  48:	02000613          	li	a2,32
  4c:	9e05                	subw	a2,a2,s1
  4e:	02000593          	li	a1,32
  52:	00998533          	add	a0,s3,s1
  56:	00000097          	auipc	ra,0x0
  5a:	232080e7          	jalr	562(ra) # 288 <memset>
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
  7e:	97e78793          	addi	a5,a5,-1666 # 9f8 <malloc+0xe6>
  82:	f8f43423          	sd	a5,-120(s0)
  86:	00001797          	auipc	a5,0x1
  8a:	97a78793          	addi	a5,a5,-1670 # a00 <malloc+0xee>
  8e:	f8f43823          	sd	a5,-112(s0)
    [T_DIR]   "DIR ",
    [T_FILE]  "FILE",
  };

  if((fd = open(path, 0)) < 0){
  92:	4581                	li	a1,0
  94:	00000097          	auipc	ra,0x0
  98:	460080e7          	jalr	1120(ra) # 4f4 <open>
  9c:	06054563          	bltz	a0,106 <ls+0xa0>
  a0:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  a2:	f9840593          	addi	a1,s0,-104
  a6:	00000097          	auipc	ra,0x0
  aa:	456080e7          	jalr	1110(ra) # 4fc <fstat>
  ae:	06054763          	bltz	a0,11c <ls+0xb6>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  if (st.type == T_DIR){
  b2:	fc041703          	lh	a4,-64(s0)
  b6:	4785                	li	a5,1
  b8:	08f71263          	bne	a4,a5,13c <ls+0xd6>
    while(readdir(fd, &st) == 1){
  bc:	4905                	li	s2,1
      printf("%s %s\t%d\n", fmtname(st.name), types[st.type], st.size);
  be:	00001997          	auipc	s3,0x1
  c2:	97a98993          	addi	s3,s3,-1670 # a38 <malloc+0x126>
    while(readdir(fd, &st) == 1){
  c6:	f9840593          	addi	a1,s0,-104
  ca:	8526                	mv	a0,s1
  cc:	00000097          	auipc	ra,0x0
  d0:	480080e7          	jalr	1152(ra) # 54c <readdir>
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
 100:	756080e7          	jalr	1878(ra) # 852 <printf>
 104:	b7c9                	j	c6 <ls+0x60>
    fprintf(2, "ls: cannot open %s\n", path);
 106:	864a                	mv	a2,s2
 108:	00001597          	auipc	a1,0x1
 10c:	90058593          	addi	a1,a1,-1792 # a08 <malloc+0xf6>
 110:	4509                	li	a0,2
 112:	00000097          	auipc	ra,0x0
 116:	712080e7          	jalr	1810(ra) # 824 <fprintf>
    return;
 11a:	a8b9                	j	178 <ls+0x112>
    fprintf(2, "ls: cannot stat %s\n", path);
 11c:	864a                	mv	a2,s2
 11e:	00001597          	auipc	a1,0x1
 122:	90258593          	addi	a1,a1,-1790 # a20 <malloc+0x10e>
 126:	4509                	li	a0,2
 128:	00000097          	auipc	ra,0x0
 12c:	6fc080e7          	jalr	1788(ra) # 824 <fprintf>
    close(fd);
 130:	8526                	mv	a0,s1
 132:	00000097          	auipc	ra,0x0
 136:	3aa080e7          	jalr	938(ra) # 4dc <close>
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
 162:	8ea50513          	addi	a0,a0,-1814 # a48 <malloc+0x136>
 166:	00000097          	auipc	ra,0x0
 16a:	6ec080e7          	jalr	1772(ra) # 852 <printf>
  }
  close(fd);
 16e:	8526                	mv	a0,s1
 170:	00000097          	auipc	ra,0x0
 174:	36c080e7          	jalr	876(ra) # 4dc <close>
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
 1c2:	2f6080e7          	jalr	758(ra) # 4b4 <exit>
    ls(".");
 1c6:	00001517          	auipc	a0,0x1
 1ca:	89250513          	addi	a0,a0,-1902 # a58 <malloc+0x146>
 1ce:	00000097          	auipc	ra,0x0
 1d2:	e98080e7          	jalr	-360(ra) # 66 <ls>
    exit(0);
 1d6:	4501                	li	a0,0
 1d8:	00000097          	auipc	ra,0x0
 1dc:	2dc080e7          	jalr	732(ra) # 4b4 <exit>

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

00000000000001fc <strcat>:

char*
strcat(char *s, const char *t)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 202:	00054783          	lbu	a5,0(a0)
 206:	c385                	beqz	a5,226 <strcat+0x2a>
 208:	87aa                	mv	a5,a0
    s++;
 20a:	0785                	addi	a5,a5,1
  while(*s)
 20c:	0007c703          	lbu	a4,0(a5)
 210:	ff6d                	bnez	a4,20a <strcat+0xe>
  while((*s++ = *t++))
 212:	0585                	addi	a1,a1,1
 214:	0785                	addi	a5,a5,1
 216:	fff5c703          	lbu	a4,-1(a1)
 21a:	fee78fa3          	sb	a4,-1(a5)
 21e:	fb75                	bnez	a4,212 <strcat+0x16>
    ;
  return os;
}
 220:	6422                	ld	s0,8(sp)
 222:	0141                	addi	sp,sp,16
 224:	8082                	ret
  while(*s)
 226:	87aa                	mv	a5,a0
 228:	b7ed                	j	212 <strcat+0x16>

000000000000022a <strcmp>:


int
strcmp(const char *p, const char *q)
{
 22a:	1141                	addi	sp,sp,-16
 22c:	e422                	sd	s0,8(sp)
 22e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 230:	00054783          	lbu	a5,0(a0)
 234:	cf91                	beqz	a5,250 <strcmp+0x26>
 236:	0005c703          	lbu	a4,0(a1)
 23a:	00f71b63          	bne	a4,a5,250 <strcmp+0x26>
    p++, q++;
 23e:	0505                	addi	a0,a0,1
 240:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 242:	00054783          	lbu	a5,0(a0)
 246:	c789                	beqz	a5,250 <strcmp+0x26>
 248:	0005c703          	lbu	a4,0(a1)
 24c:	fef709e3          	beq	a4,a5,23e <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 250:	0005c503          	lbu	a0,0(a1)
}
 254:	40a7853b          	subw	a0,a5,a0
 258:	6422                	ld	s0,8(sp)
 25a:	0141                	addi	sp,sp,16
 25c:	8082                	ret

000000000000025e <strlen>:

uint
strlen(const char *s)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 264:	00054783          	lbu	a5,0(a0)
 268:	cf91                	beqz	a5,284 <strlen+0x26>
 26a:	0505                	addi	a0,a0,1
 26c:	87aa                	mv	a5,a0
 26e:	4685                	li	a3,1
 270:	9e89                	subw	a3,a3,a0
    ;
 272:	00f6853b          	addw	a0,a3,a5
 276:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 278:	fff7c703          	lbu	a4,-1(a5)
 27c:	fb7d                	bnez	a4,272 <strlen+0x14>
  return n;
}
 27e:	6422                	ld	s0,8(sp)
 280:	0141                	addi	sp,sp,16
 282:	8082                	ret
  for(n = 0; s[n]; n++)
 284:	4501                	li	a0,0
 286:	bfe5                	j	27e <strlen+0x20>

0000000000000288 <memset>:

void*
memset(void *dst, int c, uint n)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 28e:	ce09                	beqz	a2,2a8 <memset+0x20>
 290:	87aa                	mv	a5,a0
 292:	fff6071b          	addiw	a4,a2,-1
 296:	1702                	slli	a4,a4,0x20
 298:	9301                	srli	a4,a4,0x20
 29a:	0705                	addi	a4,a4,1
 29c:	972a                	add	a4,a4,a0
    cdst[i] = c;
 29e:	00b78023          	sb	a1,0(a5)
 2a2:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 2a4:	fee79de3          	bne	a5,a4,29e <memset+0x16>
  }
  return dst;
}
 2a8:	6422                	ld	s0,8(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <strchr>:

char*
strchr(const char *s, char c)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e422                	sd	s0,8(sp)
 2b2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2b4:	00054783          	lbu	a5,0(a0)
 2b8:	cf91                	beqz	a5,2d4 <strchr+0x26>
    if(*s == c)
 2ba:	00f58a63          	beq	a1,a5,2ce <strchr+0x20>
  for(; *s; s++)
 2be:	0505                	addi	a0,a0,1
 2c0:	00054783          	lbu	a5,0(a0)
 2c4:	c781                	beqz	a5,2cc <strchr+0x1e>
    if(*s == c)
 2c6:	feb79ce3          	bne	a5,a1,2be <strchr+0x10>
 2ca:	a011                	j	2ce <strchr+0x20>
      return (char*)s;
  return 0;
 2cc:	4501                	li	a0,0
}
 2ce:	6422                	ld	s0,8(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret
  return 0;
 2d4:	4501                	li	a0,0
 2d6:	bfe5                	j	2ce <strchr+0x20>

00000000000002d8 <gets>:

char*
gets(char *buf, int max)
{
 2d8:	711d                	addi	sp,sp,-96
 2da:	ec86                	sd	ra,88(sp)
 2dc:	e8a2                	sd	s0,80(sp)
 2de:	e4a6                	sd	s1,72(sp)
 2e0:	e0ca                	sd	s2,64(sp)
 2e2:	fc4e                	sd	s3,56(sp)
 2e4:	f852                	sd	s4,48(sp)
 2e6:	f456                	sd	s5,40(sp)
 2e8:	f05a                	sd	s6,32(sp)
 2ea:	ec5e                	sd	s7,24(sp)
 2ec:	1080                	addi	s0,sp,96
 2ee:	8baa                	mv	s7,a0
 2f0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f2:	892a                	mv	s2,a0
 2f4:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2f6:	4aa9                	li	s5,10
 2f8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2fa:	0019849b          	addiw	s1,s3,1
 2fe:	0344d863          	bge	s1,s4,32e <gets+0x56>
    cc = read(0, &c, 1);
 302:	4605                	li	a2,1
 304:	faf40593          	addi	a1,s0,-81
 308:	4501                	li	a0,0
 30a:	00000097          	auipc	ra,0x0
 30e:	1c2080e7          	jalr	450(ra) # 4cc <read>
    if(cc < 1)
 312:	00a05e63          	blez	a0,32e <gets+0x56>
    buf[i++] = c;
 316:	faf44783          	lbu	a5,-81(s0)
 31a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 31e:	01578763          	beq	a5,s5,32c <gets+0x54>
 322:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 324:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 326:	fd679ae3          	bne	a5,s6,2fa <gets+0x22>
 32a:	a011                	j	32e <gets+0x56>
  for(i=0; i+1 < max; ){
 32c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 32e:	99de                	add	s3,s3,s7
 330:	00098023          	sb	zero,0(s3)
  return buf;
}
 334:	855e                	mv	a0,s7
 336:	60e6                	ld	ra,88(sp)
 338:	6446                	ld	s0,80(sp)
 33a:	64a6                	ld	s1,72(sp)
 33c:	6906                	ld	s2,64(sp)
 33e:	79e2                	ld	s3,56(sp)
 340:	7a42                	ld	s4,48(sp)
 342:	7aa2                	ld	s5,40(sp)
 344:	7b02                	ld	s6,32(sp)
 346:	6be2                	ld	s7,24(sp)
 348:	6125                	addi	sp,sp,96
 34a:	8082                	ret

000000000000034c <stat>:

int
stat(const char *n, struct stat *st)
{
 34c:	1101                	addi	sp,sp,-32
 34e:	ec06                	sd	ra,24(sp)
 350:	e822                	sd	s0,16(sp)
 352:	e426                	sd	s1,8(sp)
 354:	e04a                	sd	s2,0(sp)
 356:	1000                	addi	s0,sp,32
 358:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 35a:	4581                	li	a1,0
 35c:	00000097          	auipc	ra,0x0
 360:	198080e7          	jalr	408(ra) # 4f4 <open>
  if(fd < 0)
 364:	02054563          	bltz	a0,38e <stat+0x42>
 368:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 36a:	85ca                	mv	a1,s2
 36c:	00000097          	auipc	ra,0x0
 370:	190080e7          	jalr	400(ra) # 4fc <fstat>
 374:	892a                	mv	s2,a0
  close(fd);
 376:	8526                	mv	a0,s1
 378:	00000097          	auipc	ra,0x0
 37c:	164080e7          	jalr	356(ra) # 4dc <close>
  return r;
}
 380:	854a                	mv	a0,s2
 382:	60e2                	ld	ra,24(sp)
 384:	6442                	ld	s0,16(sp)
 386:	64a2                	ld	s1,8(sp)
 388:	6902                	ld	s2,0(sp)
 38a:	6105                	addi	sp,sp,32
 38c:	8082                	ret
    return -1;
 38e:	597d                	li	s2,-1
 390:	bfc5                	j	380 <stat+0x34>

0000000000000392 <atoi>:

int
atoi(const char *s)
{
 392:	1141                	addi	sp,sp,-16
 394:	e422                	sd	s0,8(sp)
 396:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 398:	00054703          	lbu	a4,0(a0)
 39c:	02d00793          	li	a5,45
  int neg = 1;
 3a0:	4805                	li	a6,1
  if (*s == '-') {
 3a2:	04f70363          	beq	a4,a5,3e8 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 3a6:	00054683          	lbu	a3,0(a0)
 3aa:	fd06879b          	addiw	a5,a3,-48
 3ae:	0ff7f793          	andi	a5,a5,255
 3b2:	4725                	li	a4,9
 3b4:	02f76d63          	bltu	a4,a5,3ee <atoi+0x5c>
  n = 0;
 3b8:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 3ba:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3bc:	0505                	addi	a0,a0,1
 3be:	0026179b          	slliw	a5,a2,0x2
 3c2:	9fb1                	addw	a5,a5,a2
 3c4:	0017979b          	slliw	a5,a5,0x1
 3c8:	9fb5                	addw	a5,a5,a3
 3ca:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 3ce:	00054683          	lbu	a3,0(a0)
 3d2:	fd06871b          	addiw	a4,a3,-48
 3d6:	0ff77713          	andi	a4,a4,255
 3da:	fee5f1e3          	bgeu	a1,a4,3bc <atoi+0x2a>
  return n * neg;
}
 3de:	02c8053b          	mulw	a0,a6,a2
 3e2:	6422                	ld	s0,8(sp)
 3e4:	0141                	addi	sp,sp,16
 3e6:	8082                	ret
    s++;
 3e8:	0505                	addi	a0,a0,1
    neg = -1;
 3ea:	587d                	li	a6,-1
 3ec:	bf6d                	j	3a6 <atoi+0x14>
  n = 0;
 3ee:	4601                	li	a2,0
 3f0:	b7fd                	j	3de <atoi+0x4c>

00000000000003f2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f2:	1141                	addi	sp,sp,-16
 3f4:	e422                	sd	s0,8(sp)
 3f6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3f8:	02b57663          	bgeu	a0,a1,424 <memmove+0x32>
    while(n-- > 0)
 3fc:	02c05163          	blez	a2,41e <memmove+0x2c>
 400:	fff6079b          	addiw	a5,a2,-1
 404:	1782                	slli	a5,a5,0x20
 406:	9381                	srli	a5,a5,0x20
 408:	0785                	addi	a5,a5,1
 40a:	97aa                	add	a5,a5,a0
  dst = vdst;
 40c:	872a                	mv	a4,a0
      *dst++ = *src++;
 40e:	0585                	addi	a1,a1,1
 410:	0705                	addi	a4,a4,1
 412:	fff5c683          	lbu	a3,-1(a1)
 416:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 41a:	fee79ae3          	bne	a5,a4,40e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 41e:	6422                	ld	s0,8(sp)
 420:	0141                	addi	sp,sp,16
 422:	8082                	ret
    dst += n;
 424:	00c50733          	add	a4,a0,a2
    src += n;
 428:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 42a:	fec05ae3          	blez	a2,41e <memmove+0x2c>
 42e:	fff6079b          	addiw	a5,a2,-1
 432:	1782                	slli	a5,a5,0x20
 434:	9381                	srli	a5,a5,0x20
 436:	fff7c793          	not	a5,a5
 43a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 43c:	15fd                	addi	a1,a1,-1
 43e:	177d                	addi	a4,a4,-1
 440:	0005c683          	lbu	a3,0(a1)
 444:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 448:	fef71ae3          	bne	a4,a5,43c <memmove+0x4a>
 44c:	bfc9                	j	41e <memmove+0x2c>

000000000000044e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 44e:	1141                	addi	sp,sp,-16
 450:	e422                	sd	s0,8(sp)
 452:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 454:	ce15                	beqz	a2,490 <memcmp+0x42>
 456:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 45a:	00054783          	lbu	a5,0(a0)
 45e:	0005c703          	lbu	a4,0(a1)
 462:	02e79063          	bne	a5,a4,482 <memcmp+0x34>
 466:	1682                	slli	a3,a3,0x20
 468:	9281                	srli	a3,a3,0x20
 46a:	0685                	addi	a3,a3,1
 46c:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 46e:	0505                	addi	a0,a0,1
    p2++;
 470:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 472:	00d50d63          	beq	a0,a3,48c <memcmp+0x3e>
    if (*p1 != *p2) {
 476:	00054783          	lbu	a5,0(a0)
 47a:	0005c703          	lbu	a4,0(a1)
 47e:	fee788e3          	beq	a5,a4,46e <memcmp+0x20>
      return *p1 - *p2;
 482:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 486:	6422                	ld	s0,8(sp)
 488:	0141                	addi	sp,sp,16
 48a:	8082                	ret
  return 0;
 48c:	4501                	li	a0,0
 48e:	bfe5                	j	486 <memcmp+0x38>
 490:	4501                	li	a0,0
 492:	bfd5                	j	486 <memcmp+0x38>

0000000000000494 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 494:	1141                	addi	sp,sp,-16
 496:	e406                	sd	ra,8(sp)
 498:	e022                	sd	s0,0(sp)
 49a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 49c:	00000097          	auipc	ra,0x0
 4a0:	f56080e7          	jalr	-170(ra) # 3f2 <memmove>
}
 4a4:	60a2                	ld	ra,8(sp)
 4a6:	6402                	ld	s0,0(sp)
 4a8:	0141                	addi	sp,sp,16
 4aa:	8082                	ret

00000000000004ac <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 4ac:	4885                	li	a7,1
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4b4:	4889                	li	a7,2
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <wait>:
.global wait
wait:
 li a7, SYS_wait
 4bc:	488d                	li	a7,3
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4c4:	4891                	li	a7,4
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <read>:
.global read
read:
 li a7, SYS_read
 4cc:	4895                	li	a7,5
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <write>:
.global write
write:
 li a7, SYS_write
 4d4:	48c1                	li	a7,16
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <close>:
.global close
close:
 li a7, SYS_close
 4dc:	48d5                	li	a7,21
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4e4:	4899                	li	a7,6
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <exec>:
.global exec
exec:
 li a7, SYS_exec
 4ec:	489d                	li	a7,7
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <open>:
.global open
open:
 li a7, SYS_open
 4f4:	48bd                	li	a7,15
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4fc:	48a1                	li	a7,8
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 504:	48d1                	li	a7,20
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 50c:	48a5                	li	a7,9
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <dup>:
.global dup
dup:
 li a7, SYS_dup
 514:	48a9                	li	a7,10
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 51c:	48ad                	li	a7,11
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 524:	48b1                	li	a7,12
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 52c:	48b5                	li	a7,13
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 534:	48b9                	li	a7,14
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 53c:	48d9                	li	a7,22
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <dev>:
.global dev
dev:
 li a7, SYS_dev
 544:	48dd                	li	a7,23
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 54c:	48e1                	li	a7,24
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 554:	48e5                	li	a7,25
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <remove>:
.global remove
remove:
 li a7, SYS_remove
 55c:	48c5                	li	a7,17
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <trace>:
.global trace
trace:
 li a7, SYS_trace
 564:	48c9                	li	a7,18
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 56c:	48cd                	li	a7,19
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <rename>:
.global rename
rename:
 li a7, SYS_rename
 574:	48e9                	li	a7,26
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 57c:	1101                	addi	sp,sp,-32
 57e:	ec06                	sd	ra,24(sp)
 580:	e822                	sd	s0,16(sp)
 582:	1000                	addi	s0,sp,32
 584:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 588:	4605                	li	a2,1
 58a:	fef40593          	addi	a1,s0,-17
 58e:	00000097          	auipc	ra,0x0
 592:	f46080e7          	jalr	-186(ra) # 4d4 <write>
}
 596:	60e2                	ld	ra,24(sp)
 598:	6442                	ld	s0,16(sp)
 59a:	6105                	addi	sp,sp,32
 59c:	8082                	ret

000000000000059e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 59e:	7139                	addi	sp,sp,-64
 5a0:	fc06                	sd	ra,56(sp)
 5a2:	f822                	sd	s0,48(sp)
 5a4:	f426                	sd	s1,40(sp)
 5a6:	f04a                	sd	s2,32(sp)
 5a8:	ec4e                	sd	s3,24(sp)
 5aa:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5ac:	c299                	beqz	a3,5b2 <printint+0x14>
 5ae:	0005cd63          	bltz	a1,5c8 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5b2:	2581                	sext.w	a1,a1
  neg = 0;
 5b4:	4301                	li	t1,0
 5b6:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 5ba:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 5bc:	2601                	sext.w	a2,a2
 5be:	00000897          	auipc	a7,0x0
 5c2:	4a288893          	addi	a7,a7,1186 # a60 <digits>
 5c6:	a039                	j	5d4 <printint+0x36>
    x = -xx;
 5c8:	40b005bb          	negw	a1,a1
    neg = 1;
 5cc:	4305                	li	t1,1
    x = -xx;
 5ce:	b7e5                	j	5b6 <printint+0x18>
  }while((x /= base) != 0);
 5d0:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 5d2:	8836                	mv	a6,a3
 5d4:	0018069b          	addiw	a3,a6,1
 5d8:	02c5f7bb          	remuw	a5,a1,a2
 5dc:	1782                	slli	a5,a5,0x20
 5de:	9381                	srli	a5,a5,0x20
 5e0:	97c6                	add	a5,a5,a7
 5e2:	0007c783          	lbu	a5,0(a5)
 5e6:	00f70023          	sb	a5,0(a4)
 5ea:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 5ec:	02c5d7bb          	divuw	a5,a1,a2
 5f0:	fec5f0e3          	bgeu	a1,a2,5d0 <printint+0x32>
  if(neg)
 5f4:	00030b63          	beqz	t1,60a <printint+0x6c>
    buf[i++] = '-';
 5f8:	fd040793          	addi	a5,s0,-48
 5fc:	96be                	add	a3,a3,a5
 5fe:	02d00793          	li	a5,45
 602:	fef68823          	sb	a5,-16(a3)
 606:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 60a:	02d05963          	blez	a3,63c <printint+0x9e>
 60e:	89aa                	mv	s3,a0
 610:	fc040793          	addi	a5,s0,-64
 614:	00d784b3          	add	s1,a5,a3
 618:	fff78913          	addi	s2,a5,-1
 61c:	9936                	add	s2,s2,a3
 61e:	36fd                	addiw	a3,a3,-1
 620:	1682                	slli	a3,a3,0x20
 622:	9281                	srli	a3,a3,0x20
 624:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 628:	fff4c583          	lbu	a1,-1(s1)
 62c:	854e                	mv	a0,s3
 62e:	00000097          	auipc	ra,0x0
 632:	f4e080e7          	jalr	-178(ra) # 57c <putc>
 636:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 638:	ff2498e3          	bne	s1,s2,628 <printint+0x8a>
}
 63c:	70e2                	ld	ra,56(sp)
 63e:	7442                	ld	s0,48(sp)
 640:	74a2                	ld	s1,40(sp)
 642:	7902                	ld	s2,32(sp)
 644:	69e2                	ld	s3,24(sp)
 646:	6121                	addi	sp,sp,64
 648:	8082                	ret

000000000000064a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 64a:	7119                	addi	sp,sp,-128
 64c:	fc86                	sd	ra,120(sp)
 64e:	f8a2                	sd	s0,112(sp)
 650:	f4a6                	sd	s1,104(sp)
 652:	f0ca                	sd	s2,96(sp)
 654:	ecce                	sd	s3,88(sp)
 656:	e8d2                	sd	s4,80(sp)
 658:	e4d6                	sd	s5,72(sp)
 65a:	e0da                	sd	s6,64(sp)
 65c:	fc5e                	sd	s7,56(sp)
 65e:	f862                	sd	s8,48(sp)
 660:	f466                	sd	s9,40(sp)
 662:	f06a                	sd	s10,32(sp)
 664:	ec6e                	sd	s11,24(sp)
 666:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 668:	0005c483          	lbu	s1,0(a1)
 66c:	18048d63          	beqz	s1,806 <vprintf+0x1bc>
 670:	8aaa                	mv	s5,a0
 672:	8b32                	mv	s6,a2
 674:	00158913          	addi	s2,a1,1
  state = 0;
 678:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 67a:	02500a13          	li	s4,37
      if(c == 'd'){
 67e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 682:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 686:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 68a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 68e:	00000b97          	auipc	s7,0x0
 692:	3d2b8b93          	addi	s7,s7,978 # a60 <digits>
 696:	a839                	j	6b4 <vprintf+0x6a>
        putc(fd, c);
 698:	85a6                	mv	a1,s1
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	ee0080e7          	jalr	-288(ra) # 57c <putc>
 6a4:	a019                	j	6aa <vprintf+0x60>
    } else if(state == '%'){
 6a6:	01498f63          	beq	s3,s4,6c4 <vprintf+0x7a>
 6aa:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 6ac:	fff94483          	lbu	s1,-1(s2)
 6b0:	14048b63          	beqz	s1,806 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 6b4:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6b8:	fe0997e3          	bnez	s3,6a6 <vprintf+0x5c>
      if(c == '%'){
 6bc:	fd479ee3          	bne	a5,s4,698 <vprintf+0x4e>
        state = '%';
 6c0:	89be                	mv	s3,a5
 6c2:	b7e5                	j	6aa <vprintf+0x60>
      if(c == 'd'){
 6c4:	05878063          	beq	a5,s8,704 <vprintf+0xba>
      } else if(c == 'l') {
 6c8:	05978c63          	beq	a5,s9,720 <vprintf+0xd6>
      } else if(c == 'x') {
 6cc:	07a78863          	beq	a5,s10,73c <vprintf+0xf2>
      } else if(c == 'p') {
 6d0:	09b78463          	beq	a5,s11,758 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6d4:	07300713          	li	a4,115
 6d8:	0ce78563          	beq	a5,a4,7a2 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6dc:	06300713          	li	a4,99
 6e0:	0ee78c63          	beq	a5,a4,7d8 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6e4:	11478663          	beq	a5,s4,7f0 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6e8:	85d2                	mv	a1,s4
 6ea:	8556                	mv	a0,s5
 6ec:	00000097          	auipc	ra,0x0
 6f0:	e90080e7          	jalr	-368(ra) # 57c <putc>
        putc(fd, c);
 6f4:	85a6                	mv	a1,s1
 6f6:	8556                	mv	a0,s5
 6f8:	00000097          	auipc	ra,0x0
 6fc:	e84080e7          	jalr	-380(ra) # 57c <putc>
      }
      state = 0;
 700:	4981                	li	s3,0
 702:	b765                	j	6aa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 704:	008b0493          	addi	s1,s6,8
 708:	4685                	li	a3,1
 70a:	4629                	li	a2,10
 70c:	000b2583          	lw	a1,0(s6)
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	e8c080e7          	jalr	-372(ra) # 59e <printint>
 71a:	8b26                	mv	s6,s1
      state = 0;
 71c:	4981                	li	s3,0
 71e:	b771                	j	6aa <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 720:	008b0493          	addi	s1,s6,8
 724:	4681                	li	a3,0
 726:	4629                	li	a2,10
 728:	000b2583          	lw	a1,0(s6)
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	e70080e7          	jalr	-400(ra) # 59e <printint>
 736:	8b26                	mv	s6,s1
      state = 0;
 738:	4981                	li	s3,0
 73a:	bf85                	j	6aa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 73c:	008b0493          	addi	s1,s6,8
 740:	4681                	li	a3,0
 742:	4641                	li	a2,16
 744:	000b2583          	lw	a1,0(s6)
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	e54080e7          	jalr	-428(ra) # 59e <printint>
 752:	8b26                	mv	s6,s1
      state = 0;
 754:	4981                	li	s3,0
 756:	bf91                	j	6aa <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 758:	008b0793          	addi	a5,s6,8
 75c:	f8f43423          	sd	a5,-120(s0)
 760:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 764:	03000593          	li	a1,48
 768:	8556                	mv	a0,s5
 76a:	00000097          	auipc	ra,0x0
 76e:	e12080e7          	jalr	-494(ra) # 57c <putc>
  putc(fd, 'x');
 772:	85ea                	mv	a1,s10
 774:	8556                	mv	a0,s5
 776:	00000097          	auipc	ra,0x0
 77a:	e06080e7          	jalr	-506(ra) # 57c <putc>
 77e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 780:	03c9d793          	srli	a5,s3,0x3c
 784:	97de                	add	a5,a5,s7
 786:	0007c583          	lbu	a1,0(a5)
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	df0080e7          	jalr	-528(ra) # 57c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 794:	0992                	slli	s3,s3,0x4
 796:	34fd                	addiw	s1,s1,-1
 798:	f4e5                	bnez	s1,780 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 79a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	b729                	j	6aa <vprintf+0x60>
        s = va_arg(ap, char*);
 7a2:	008b0993          	addi	s3,s6,8
 7a6:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 7aa:	c085                	beqz	s1,7ca <vprintf+0x180>
        while(*s != 0){
 7ac:	0004c583          	lbu	a1,0(s1)
 7b0:	c9a1                	beqz	a1,800 <vprintf+0x1b6>
          putc(fd, *s);
 7b2:	8556                	mv	a0,s5
 7b4:	00000097          	auipc	ra,0x0
 7b8:	dc8080e7          	jalr	-568(ra) # 57c <putc>
          s++;
 7bc:	0485                	addi	s1,s1,1
        while(*s != 0){
 7be:	0004c583          	lbu	a1,0(s1)
 7c2:	f9e5                	bnez	a1,7b2 <vprintf+0x168>
        s = va_arg(ap, char*);
 7c4:	8b4e                	mv	s6,s3
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	b5cd                	j	6aa <vprintf+0x60>
          s = "(null)";
 7ca:	00000497          	auipc	s1,0x0
 7ce:	2ae48493          	addi	s1,s1,686 # a78 <digits+0x18>
        while(*s != 0){
 7d2:	02800593          	li	a1,40
 7d6:	bff1                	j	7b2 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 7d8:	008b0493          	addi	s1,s6,8
 7dc:	000b4583          	lbu	a1,0(s6)
 7e0:	8556                	mv	a0,s5
 7e2:	00000097          	auipc	ra,0x0
 7e6:	d9a080e7          	jalr	-614(ra) # 57c <putc>
 7ea:	8b26                	mv	s6,s1
      state = 0;
 7ec:	4981                	li	s3,0
 7ee:	bd75                	j	6aa <vprintf+0x60>
        putc(fd, c);
 7f0:	85d2                	mv	a1,s4
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	d88080e7          	jalr	-632(ra) # 57c <putc>
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	b575                	j	6aa <vprintf+0x60>
        s = va_arg(ap, char*);
 800:	8b4e                	mv	s6,s3
      state = 0;
 802:	4981                	li	s3,0
 804:	b55d                	j	6aa <vprintf+0x60>
    }
  }
}
 806:	70e6                	ld	ra,120(sp)
 808:	7446                	ld	s0,112(sp)
 80a:	74a6                	ld	s1,104(sp)
 80c:	7906                	ld	s2,96(sp)
 80e:	69e6                	ld	s3,88(sp)
 810:	6a46                	ld	s4,80(sp)
 812:	6aa6                	ld	s5,72(sp)
 814:	6b06                	ld	s6,64(sp)
 816:	7be2                	ld	s7,56(sp)
 818:	7c42                	ld	s8,48(sp)
 81a:	7ca2                	ld	s9,40(sp)
 81c:	7d02                	ld	s10,32(sp)
 81e:	6de2                	ld	s11,24(sp)
 820:	6109                	addi	sp,sp,128
 822:	8082                	ret

0000000000000824 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 824:	715d                	addi	sp,sp,-80
 826:	ec06                	sd	ra,24(sp)
 828:	e822                	sd	s0,16(sp)
 82a:	1000                	addi	s0,sp,32
 82c:	e010                	sd	a2,0(s0)
 82e:	e414                	sd	a3,8(s0)
 830:	e818                	sd	a4,16(s0)
 832:	ec1c                	sd	a5,24(s0)
 834:	03043023          	sd	a6,32(s0)
 838:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 83c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 840:	8622                	mv	a2,s0
 842:	00000097          	auipc	ra,0x0
 846:	e08080e7          	jalr	-504(ra) # 64a <vprintf>
}
 84a:	60e2                	ld	ra,24(sp)
 84c:	6442                	ld	s0,16(sp)
 84e:	6161                	addi	sp,sp,80
 850:	8082                	ret

0000000000000852 <printf>:

void
printf(const char *fmt, ...)
{
 852:	711d                	addi	sp,sp,-96
 854:	ec06                	sd	ra,24(sp)
 856:	e822                	sd	s0,16(sp)
 858:	1000                	addi	s0,sp,32
 85a:	e40c                	sd	a1,8(s0)
 85c:	e810                	sd	a2,16(s0)
 85e:	ec14                	sd	a3,24(s0)
 860:	f018                	sd	a4,32(s0)
 862:	f41c                	sd	a5,40(s0)
 864:	03043823          	sd	a6,48(s0)
 868:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 86c:	00840613          	addi	a2,s0,8
 870:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 874:	85aa                	mv	a1,a0
 876:	4505                	li	a0,1
 878:	00000097          	auipc	ra,0x0
 87c:	dd2080e7          	jalr	-558(ra) # 64a <vprintf>
}
 880:	60e2                	ld	ra,24(sp)
 882:	6442                	ld	s0,16(sp)
 884:	6125                	addi	sp,sp,96
 886:	8082                	ret

0000000000000888 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 888:	1141                	addi	sp,sp,-16
 88a:	e422                	sd	s0,8(sp)
 88c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 88e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 892:	00000797          	auipc	a5,0x0
 896:	1ee78793          	addi	a5,a5,494 # a80 <__DATA_BEGIN__>
 89a:	639c                	ld	a5,0(a5)
 89c:	a805                	j	8cc <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 89e:	4618                	lw	a4,8(a2)
 8a0:	9db9                	addw	a1,a1,a4
 8a2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a6:	6398                	ld	a4,0(a5)
 8a8:	6318                	ld	a4,0(a4)
 8aa:	fee53823          	sd	a4,-16(a0)
 8ae:	a091                	j	8f2 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b0:	ff852703          	lw	a4,-8(a0)
 8b4:	9e39                	addw	a2,a2,a4
 8b6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8b8:	ff053703          	ld	a4,-16(a0)
 8bc:	e398                	sd	a4,0(a5)
 8be:	a099                	j	904 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c0:	6398                	ld	a4,0(a5)
 8c2:	00e7e463          	bltu	a5,a4,8ca <free+0x42>
 8c6:	00e6ea63          	bltu	a3,a4,8da <free+0x52>
{
 8ca:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8cc:	fed7fae3          	bgeu	a5,a3,8c0 <free+0x38>
 8d0:	6398                	ld	a4,0(a5)
 8d2:	00e6e463          	bltu	a3,a4,8da <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d6:	fee7eae3          	bltu	a5,a4,8ca <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 8da:	ff852583          	lw	a1,-8(a0)
 8de:	6390                	ld	a2,0(a5)
 8e0:	02059713          	slli	a4,a1,0x20
 8e4:	9301                	srli	a4,a4,0x20
 8e6:	0712                	slli	a4,a4,0x4
 8e8:	9736                	add	a4,a4,a3
 8ea:	fae60ae3          	beq	a2,a4,89e <free+0x16>
    bp->s.ptr = p->s.ptr;
 8ee:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f2:	4790                	lw	a2,8(a5)
 8f4:	02061713          	slli	a4,a2,0x20
 8f8:	9301                	srli	a4,a4,0x20
 8fa:	0712                	slli	a4,a4,0x4
 8fc:	973e                	add	a4,a4,a5
 8fe:	fae689e3          	beq	a3,a4,8b0 <free+0x28>
  } else
    p->s.ptr = bp;
 902:	e394                	sd	a3,0(a5)
  freep = p;
 904:	00000717          	auipc	a4,0x0
 908:	16f73e23          	sd	a5,380(a4) # a80 <__DATA_BEGIN__>
}
 90c:	6422                	ld	s0,8(sp)
 90e:	0141                	addi	sp,sp,16
 910:	8082                	ret

0000000000000912 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 912:	7139                	addi	sp,sp,-64
 914:	fc06                	sd	ra,56(sp)
 916:	f822                	sd	s0,48(sp)
 918:	f426                	sd	s1,40(sp)
 91a:	f04a                	sd	s2,32(sp)
 91c:	ec4e                	sd	s3,24(sp)
 91e:	e852                	sd	s4,16(sp)
 920:	e456                	sd	s5,8(sp)
 922:	e05a                	sd	s6,0(sp)
 924:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 926:	02051993          	slli	s3,a0,0x20
 92a:	0209d993          	srli	s3,s3,0x20
 92e:	09bd                	addi	s3,s3,15
 930:	0049d993          	srli	s3,s3,0x4
 934:	2985                	addiw	s3,s3,1
 936:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 93a:	00000797          	auipc	a5,0x0
 93e:	14678793          	addi	a5,a5,326 # a80 <__DATA_BEGIN__>
 942:	6388                	ld	a0,0(a5)
 944:	c515                	beqz	a0,970 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 946:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 948:	4798                	lw	a4,8(a5)
 94a:	03277f63          	bgeu	a4,s2,988 <malloc+0x76>
 94e:	8a4e                	mv	s4,s3
 950:	0009871b          	sext.w	a4,s3
 954:	6685                	lui	a3,0x1
 956:	00d77363          	bgeu	a4,a3,95c <malloc+0x4a>
 95a:	6a05                	lui	s4,0x1
 95c:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 960:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 964:	00000497          	auipc	s1,0x0
 968:	11c48493          	addi	s1,s1,284 # a80 <__DATA_BEGIN__>
  if(p == (char*)-1)
 96c:	5b7d                	li	s6,-1
 96e:	a885                	j	9de <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 970:	00000797          	auipc	a5,0x0
 974:	14078793          	addi	a5,a5,320 # ab0 <base>
 978:	00000717          	auipc	a4,0x0
 97c:	10f73423          	sd	a5,264(a4) # a80 <__DATA_BEGIN__>
 980:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 982:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 986:	b7e1                	j	94e <malloc+0x3c>
      if(p->s.size == nunits)
 988:	02e90b63          	beq	s2,a4,9be <malloc+0xac>
        p->s.size -= nunits;
 98c:	4137073b          	subw	a4,a4,s3
 990:	c798                	sw	a4,8(a5)
        p += p->s.size;
 992:	1702                	slli	a4,a4,0x20
 994:	9301                	srli	a4,a4,0x20
 996:	0712                	slli	a4,a4,0x4
 998:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 99a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 99e:	00000717          	auipc	a4,0x0
 9a2:	0ea73123          	sd	a0,226(a4) # a80 <__DATA_BEGIN__>
      return (void*)(p + 1);
 9a6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9aa:	70e2                	ld	ra,56(sp)
 9ac:	7442                	ld	s0,48(sp)
 9ae:	74a2                	ld	s1,40(sp)
 9b0:	7902                	ld	s2,32(sp)
 9b2:	69e2                	ld	s3,24(sp)
 9b4:	6a42                	ld	s4,16(sp)
 9b6:	6aa2                	ld	s5,8(sp)
 9b8:	6b02                	ld	s6,0(sp)
 9ba:	6121                	addi	sp,sp,64
 9bc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9be:	6398                	ld	a4,0(a5)
 9c0:	e118                	sd	a4,0(a0)
 9c2:	bff1                	j	99e <malloc+0x8c>
  hp->s.size = nu;
 9c4:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 9c8:	0541                	addi	a0,a0,16
 9ca:	00000097          	auipc	ra,0x0
 9ce:	ebe080e7          	jalr	-322(ra) # 888 <free>
  return freep;
 9d2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9d4:	d979                	beqz	a0,9aa <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d8:	4798                	lw	a4,8(a5)
 9da:	fb2777e3          	bgeu	a4,s2,988 <malloc+0x76>
    if(p == freep)
 9de:	6098                	ld	a4,0(s1)
 9e0:	853e                	mv	a0,a5
 9e2:	fef71ae3          	bne	a4,a5,9d6 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 9e6:	8552                	mv	a0,s4
 9e8:	00000097          	auipc	ra,0x0
 9ec:	b3c080e7          	jalr	-1220(ra) # 524 <sbrk>
  if(p == (char*)-1)
 9f0:	fd651ae3          	bne	a0,s6,9c4 <malloc+0xb2>
        return 0;
 9f4:	4501                	li	a0,0
 9f6:	bf55                	j	9aa <malloc+0x98>
