
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
  36:	ae698993          	addi	s3,s3,-1306 # b18 <buf.1128>
  3a:	8626                	mv	a2,s1
  3c:	85ca                	mv	a1,s2
  3e:	854e                	mv	a0,s3
  40:	00000097          	auipc	ra,0x0
  44:	42c080e7          	jalr	1068(ra) # 46c <memmove>
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
  7e:	a0e78793          	addi	a5,a5,-1522 # a88 <malloc+0xe8>
  82:	f8f43423          	sd	a5,-120(s0)
  86:	00001797          	auipc	a5,0x1
  8a:	a0a78793          	addi	a5,a5,-1526 # a90 <malloc+0xf0>
  8e:	f8f43823          	sd	a5,-112(s0)
    [T_DIR]   "DIR ",
    [T_FILE]  "FILE",
  };

  if((fd = open(path, 0)) < 0){
  92:	4581                	li	a1,0
  94:	00000097          	auipc	ra,0x0
  98:	4e4080e7          	jalr	1252(ra) # 578 <open>
  9c:	06054563          	bltz	a0,106 <ls+0xa0>
  a0:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  a2:	f9840593          	addi	a1,s0,-104
  a6:	00000097          	auipc	ra,0x0
  aa:	4da080e7          	jalr	1242(ra) # 580 <fstat>
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
  c2:	a0a98993          	addi	s3,s3,-1526 # ac8 <malloc+0x128>
    while(readdir(fd, &st) == 1){
  c6:	f9840593          	addi	a1,s0,-104
  ca:	8526                	mv	a0,s1
  cc:	00000097          	auipc	ra,0x0
  d0:	50c080e7          	jalr	1292(ra) # 5d8 <readdir>
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
 100:	7e4080e7          	jalr	2020(ra) # 8e0 <printf>
 104:	b7c9                	j	c6 <ls+0x60>
    fprintf(2, "ls: cannot open %s\n", path);
 106:	864a                	mv	a2,s2
 108:	00001597          	auipc	a1,0x1
 10c:	99058593          	addi	a1,a1,-1648 # a98 <malloc+0xf8>
 110:	4509                	li	a0,2
 112:	00000097          	auipc	ra,0x0
 116:	7a0080e7          	jalr	1952(ra) # 8b2 <fprintf>
    return;
 11a:	a8b9                	j	178 <ls+0x112>
    fprintf(2, "ls: cannot stat %s\n", path);
 11c:	864a                	mv	a2,s2
 11e:	00001597          	auipc	a1,0x1
 122:	99258593          	addi	a1,a1,-1646 # ab0 <malloc+0x110>
 126:	4509                	li	a0,2
 128:	00000097          	auipc	ra,0x0
 12c:	78a080e7          	jalr	1930(ra) # 8b2 <fprintf>
    close(fd);
 130:	8526                	mv	a0,s1
 132:	00000097          	auipc	ra,0x0
 136:	42c080e7          	jalr	1068(ra) # 55e <close>
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
 162:	97a50513          	addi	a0,a0,-1670 # ad8 <malloc+0x138>
 166:	00000097          	auipc	ra,0x0
 16a:	77a080e7          	jalr	1914(ra) # 8e0 <printf>
  }
  close(fd);
 16e:	8526                	mv	a0,s1
 170:	00000097          	auipc	ra,0x0
 174:	3ee080e7          	jalr	1006(ra) # 55e <close>
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
 1c2:	370080e7          	jalr	880(ra) # 52e <exit>
    ls(".");
 1c6:	00001517          	auipc	a0,0x1
 1ca:	92250513          	addi	a0,a0,-1758 # ae8 <malloc+0x148>
 1ce:	00000097          	auipc	ra,0x0
 1d2:	e98080e7          	jalr	-360(ra) # 66 <ls>
    exit(0);
 1d6:	4501                	li	a0,0
 1d8:	00000097          	auipc	ra,0x0
 1dc:	356080e7          	jalr	854(ra) # 52e <exit>

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
 30e:	240080e7          	jalr	576(ra) # 54a <read>
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

000000000000034c <fgets>:

char*
fgets(int fd, char *buf, int max)
{
 34c:	711d                	addi	sp,sp,-96
 34e:	ec86                	sd	ra,88(sp)
 350:	e8a2                	sd	s0,80(sp)
 352:	e4a6                	sd	s1,72(sp)
 354:	e0ca                	sd	s2,64(sp)
 356:	fc4e                	sd	s3,56(sp)
 358:	f852                	sd	s4,48(sp)
 35a:	f456                	sd	s5,40(sp)
 35c:	f05a                	sd	s6,32(sp)
 35e:	ec5e                	sd	s7,24(sp)
 360:	e862                	sd	s8,16(sp)
 362:	1080                	addi	s0,sp,96
 364:	8aaa                	mv	s5,a0
 366:	8c2e                	mv	s8,a1
 368:	8a32                	mv	s4,a2
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 36a:	892e                	mv	s2,a1
 36c:	4981                	li	s3,0
    cc = read(fd, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 36e:	4b29                	li	s6,10
 370:	4bb5                	li	s7,13
  for(i=0; i+1 < max; ){
 372:	0019849b          	addiw	s1,s3,1
 376:	0344d863          	bge	s1,s4,3a6 <fgets+0x5a>
    cc = read(fd, &c, 1);
 37a:	4605                	li	a2,1
 37c:	faf40593          	addi	a1,s0,-81
 380:	8556                	mv	a0,s5
 382:	00000097          	auipc	ra,0x0
 386:	1c8080e7          	jalr	456(ra) # 54a <read>
    if(cc < 1)
 38a:	00a05e63          	blez	a0,3a6 <fgets+0x5a>
    buf[i++] = c;
 38e:	faf44783          	lbu	a5,-81(s0)
 392:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 396:	01678763          	beq	a5,s6,3a4 <fgets+0x58>
 39a:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 39c:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 39e:	fd779ae3          	bne	a5,s7,372 <fgets+0x26>
 3a2:	a011                	j	3a6 <fgets+0x5a>
  for(i=0; i+1 < max; ){
 3a4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3a6:	99e2                	add	s3,s3,s8
 3a8:	00098023          	sb	zero,0(s3)
  return buf;
}
 3ac:	8562                	mv	a0,s8
 3ae:	60e6                	ld	ra,88(sp)
 3b0:	6446                	ld	s0,80(sp)
 3b2:	64a6                	ld	s1,72(sp)
 3b4:	6906                	ld	s2,64(sp)
 3b6:	79e2                	ld	s3,56(sp)
 3b8:	7a42                	ld	s4,48(sp)
 3ba:	7aa2                	ld	s5,40(sp)
 3bc:	7b02                	ld	s6,32(sp)
 3be:	6be2                	ld	s7,24(sp)
 3c0:	6c42                	ld	s8,16(sp)
 3c2:	6125                	addi	sp,sp,96
 3c4:	8082                	ret

00000000000003c6 <stat>:


int
stat(const char *n, struct stat *st)
{
 3c6:	1101                	addi	sp,sp,-32
 3c8:	ec06                	sd	ra,24(sp)
 3ca:	e822                	sd	s0,16(sp)
 3cc:	e426                	sd	s1,8(sp)
 3ce:	e04a                	sd	s2,0(sp)
 3d0:	1000                	addi	s0,sp,32
 3d2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d4:	4581                	li	a1,0
 3d6:	00000097          	auipc	ra,0x0
 3da:	1a2080e7          	jalr	418(ra) # 578 <open>
  if(fd < 0)
 3de:	02054563          	bltz	a0,408 <stat+0x42>
 3e2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3e4:	85ca                	mv	a1,s2
 3e6:	00000097          	auipc	ra,0x0
 3ea:	19a080e7          	jalr	410(ra) # 580 <fstat>
 3ee:	892a                	mv	s2,a0
  close(fd);
 3f0:	8526                	mv	a0,s1
 3f2:	00000097          	auipc	ra,0x0
 3f6:	16c080e7          	jalr	364(ra) # 55e <close>
  return r;
}
 3fa:	854a                	mv	a0,s2
 3fc:	60e2                	ld	ra,24(sp)
 3fe:	6442                	ld	s0,16(sp)
 400:	64a2                	ld	s1,8(sp)
 402:	6902                	ld	s2,0(sp)
 404:	6105                	addi	sp,sp,32
 406:	8082                	ret
    return -1;
 408:	597d                	li	s2,-1
 40a:	bfc5                	j	3fa <stat+0x34>

000000000000040c <atoi>:

int
atoi(const char *s)
{
 40c:	1141                	addi	sp,sp,-16
 40e:	e422                	sd	s0,8(sp)
 410:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 412:	00054703          	lbu	a4,0(a0)
 416:	02d00793          	li	a5,45
  int neg = 1;
 41a:	4805                	li	a6,1
  if (*s == '-') {
 41c:	04f70363          	beq	a4,a5,462 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 420:	00054683          	lbu	a3,0(a0)
 424:	fd06879b          	addiw	a5,a3,-48
 428:	0ff7f793          	andi	a5,a5,255
 42c:	4725                	li	a4,9
 42e:	02f76d63          	bltu	a4,a5,468 <atoi+0x5c>
  n = 0;
 432:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 434:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 436:	0505                	addi	a0,a0,1
 438:	0026179b          	slliw	a5,a2,0x2
 43c:	9fb1                	addw	a5,a5,a2
 43e:	0017979b          	slliw	a5,a5,0x1
 442:	9fb5                	addw	a5,a5,a3
 444:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 448:	00054683          	lbu	a3,0(a0)
 44c:	fd06871b          	addiw	a4,a3,-48
 450:	0ff77713          	andi	a4,a4,255
 454:	fee5f1e3          	bgeu	a1,a4,436 <atoi+0x2a>
  return n * neg;
}
 458:	02c8053b          	mulw	a0,a6,a2
 45c:	6422                	ld	s0,8(sp)
 45e:	0141                	addi	sp,sp,16
 460:	8082                	ret
    s++;
 462:	0505                	addi	a0,a0,1
    neg = -1;
 464:	587d                	li	a6,-1
 466:	bf6d                	j	420 <atoi+0x14>
  n = 0;
 468:	4601                	li	a2,0
 46a:	b7fd                	j	458 <atoi+0x4c>

000000000000046c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 46c:	1141                	addi	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 472:	02b57663          	bgeu	a0,a1,49e <memmove+0x32>
    while(n-- > 0)
 476:	02c05163          	blez	a2,498 <memmove+0x2c>
 47a:	fff6079b          	addiw	a5,a2,-1
 47e:	1782                	slli	a5,a5,0x20
 480:	9381                	srli	a5,a5,0x20
 482:	0785                	addi	a5,a5,1
 484:	97aa                	add	a5,a5,a0
  dst = vdst;
 486:	872a                	mv	a4,a0
      *dst++ = *src++;
 488:	0585                	addi	a1,a1,1
 48a:	0705                	addi	a4,a4,1
 48c:	fff5c683          	lbu	a3,-1(a1)
 490:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 494:	fee79ae3          	bne	a5,a4,488 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 498:	6422                	ld	s0,8(sp)
 49a:	0141                	addi	sp,sp,16
 49c:	8082                	ret
    dst += n;
 49e:	00c50733          	add	a4,a0,a2
    src += n;
 4a2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4a4:	fec05ae3          	blez	a2,498 <memmove+0x2c>
 4a8:	fff6079b          	addiw	a5,a2,-1
 4ac:	1782                	slli	a5,a5,0x20
 4ae:	9381                	srli	a5,a5,0x20
 4b0:	fff7c793          	not	a5,a5
 4b4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4b6:	15fd                	addi	a1,a1,-1
 4b8:	177d                	addi	a4,a4,-1
 4ba:	0005c683          	lbu	a3,0(a1)
 4be:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4c2:	fef71ae3          	bne	a4,a5,4b6 <memmove+0x4a>
 4c6:	bfc9                	j	498 <memmove+0x2c>

00000000000004c8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4c8:	1141                	addi	sp,sp,-16
 4ca:	e422                	sd	s0,8(sp)
 4cc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4ce:	ce15                	beqz	a2,50a <memcmp+0x42>
 4d0:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 4d4:	00054783          	lbu	a5,0(a0)
 4d8:	0005c703          	lbu	a4,0(a1)
 4dc:	02e79063          	bne	a5,a4,4fc <memcmp+0x34>
 4e0:	1682                	slli	a3,a3,0x20
 4e2:	9281                	srli	a3,a3,0x20
 4e4:	0685                	addi	a3,a3,1
 4e6:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 4e8:	0505                	addi	a0,a0,1
    p2++;
 4ea:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4ec:	00d50d63          	beq	a0,a3,506 <memcmp+0x3e>
    if (*p1 != *p2) {
 4f0:	00054783          	lbu	a5,0(a0)
 4f4:	0005c703          	lbu	a4,0(a1)
 4f8:	fee788e3          	beq	a5,a4,4e8 <memcmp+0x20>
      return *p1 - *p2;
 4fc:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 500:	6422                	ld	s0,8(sp)
 502:	0141                	addi	sp,sp,16
 504:	8082                	ret
  return 0;
 506:	4501                	li	a0,0
 508:	bfe5                	j	500 <memcmp+0x38>
 50a:	4501                	li	a0,0
 50c:	bfd5                	j	500 <memcmp+0x38>

000000000000050e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 50e:	1141                	addi	sp,sp,-16
 510:	e406                	sd	ra,8(sp)
 512:	e022                	sd	s0,0(sp)
 514:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 516:	00000097          	auipc	ra,0x0
 51a:	f56080e7          	jalr	-170(ra) # 46c <memmove>
}
 51e:	60a2                	ld	ra,8(sp)
 520:	6402                	ld	s0,0(sp)
 522:	0141                	addi	sp,sp,16
 524:	8082                	ret

0000000000000526 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 526:	4885                	li	a7,1
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <exit>:
.global exit
exit:
 li a7, SYS_exit
 52e:	05d00893          	li	a7,93
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <wait>:
.global wait
wait:
 li a7, SYS_wait
 538:	488d                	li	a7,3
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 540:	03b00893          	li	a7,59
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <read>:
.global read
read:
 li a7, SYS_read
 54a:	03f00893          	li	a7,63
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <write>:
.global write
write:
 li a7, SYS_write
 554:	04000893          	li	a7,64
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <close>:
.global close
close:
 li a7, SYS_close
 55e:	03900893          	li	a7,57
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <kill>:
.global kill
kill:
 li a7, SYS_kill
 568:	4899                	li	a7,6
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <exec>:
.global exec
exec:
 li a7, SYS_exec
 570:	489d                	li	a7,7
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <open>:
.global open
open:
 li a7, SYS_open
 578:	48bd                	li	a7,15
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 580:	05000893          	li	a7,80
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 58a:	48d1                	li	a7,20
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 592:	03100893          	li	a7,49
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <dup>:
.global dup
dup:
 li a7, SYS_dup
 59c:	48dd                	li	a7,23
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a4:	0ac00893          	li	a7,172
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ae:	48b1                	li	a7,12
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5b6:	48b5                	li	a7,13
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5be:	48b9                	li	a7,14
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 5c6:	48d9                	li	a7,22
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <dev>:
.global dev
dev:
 li a7, SYS_dev
 5ce:	06500893          	li	a7,101
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 5d8:	06400893          	li	a7,100
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 5e2:	48c5                	li	a7,17
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <remove>:
.global remove
remove:
 li a7, SYS_remove
 5ea:	48e5                	li	a7,25
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <trace>:
.global trace
trace:
 li a7, SYS_trace
 5f2:	48c9                	li	a7,18
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 5fa:	48cd                	li	a7,19
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <rename>:
.global rename
rename:
 li a7, SYS_rename
 602:	48e9                	li	a7,26
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 60a:	1101                	addi	sp,sp,-32
 60c:	ec06                	sd	ra,24(sp)
 60e:	e822                	sd	s0,16(sp)
 610:	1000                	addi	s0,sp,32
 612:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 616:	4605                	li	a2,1
 618:	fef40593          	addi	a1,s0,-17
 61c:	00000097          	auipc	ra,0x0
 620:	f38080e7          	jalr	-200(ra) # 554 <write>
}
 624:	60e2                	ld	ra,24(sp)
 626:	6442                	ld	s0,16(sp)
 628:	6105                	addi	sp,sp,32
 62a:	8082                	ret

000000000000062c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 62c:	7139                	addi	sp,sp,-64
 62e:	fc06                	sd	ra,56(sp)
 630:	f822                	sd	s0,48(sp)
 632:	f426                	sd	s1,40(sp)
 634:	f04a                	sd	s2,32(sp)
 636:	ec4e                	sd	s3,24(sp)
 638:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 63a:	c299                	beqz	a3,640 <printint+0x14>
 63c:	0005cd63          	bltz	a1,656 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 640:	2581                	sext.w	a1,a1
  neg = 0;
 642:	4301                	li	t1,0
 644:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 648:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 64a:	2601                	sext.w	a2,a2
 64c:	00000897          	auipc	a7,0x0
 650:	4a488893          	addi	a7,a7,1188 # af0 <digits>
 654:	a039                	j	662 <printint+0x36>
    x = -xx;
 656:	40b005bb          	negw	a1,a1
    neg = 1;
 65a:	4305                	li	t1,1
    x = -xx;
 65c:	b7e5                	j	644 <printint+0x18>
  }while((x /= base) != 0);
 65e:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 660:	8836                	mv	a6,a3
 662:	0018069b          	addiw	a3,a6,1
 666:	02c5f7bb          	remuw	a5,a1,a2
 66a:	1782                	slli	a5,a5,0x20
 66c:	9381                	srli	a5,a5,0x20
 66e:	97c6                	add	a5,a5,a7
 670:	0007c783          	lbu	a5,0(a5)
 674:	00f70023          	sb	a5,0(a4)
 678:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 67a:	02c5d7bb          	divuw	a5,a1,a2
 67e:	fec5f0e3          	bgeu	a1,a2,65e <printint+0x32>
  if(neg)
 682:	00030b63          	beqz	t1,698 <printint+0x6c>
    buf[i++] = '-';
 686:	fd040793          	addi	a5,s0,-48
 68a:	96be                	add	a3,a3,a5
 68c:	02d00793          	li	a5,45
 690:	fef68823          	sb	a5,-16(a3)
 694:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 698:	02d05963          	blez	a3,6ca <printint+0x9e>
 69c:	89aa                	mv	s3,a0
 69e:	fc040793          	addi	a5,s0,-64
 6a2:	00d784b3          	add	s1,a5,a3
 6a6:	fff78913          	addi	s2,a5,-1
 6aa:	9936                	add	s2,s2,a3
 6ac:	36fd                	addiw	a3,a3,-1
 6ae:	1682                	slli	a3,a3,0x20
 6b0:	9281                	srli	a3,a3,0x20
 6b2:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 6b6:	fff4c583          	lbu	a1,-1(s1)
 6ba:	854e                	mv	a0,s3
 6bc:	00000097          	auipc	ra,0x0
 6c0:	f4e080e7          	jalr	-178(ra) # 60a <putc>
 6c4:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 6c6:	ff2498e3          	bne	s1,s2,6b6 <printint+0x8a>
}
 6ca:	70e2                	ld	ra,56(sp)
 6cc:	7442                	ld	s0,48(sp)
 6ce:	74a2                	ld	s1,40(sp)
 6d0:	7902                	ld	s2,32(sp)
 6d2:	69e2                	ld	s3,24(sp)
 6d4:	6121                	addi	sp,sp,64
 6d6:	8082                	ret

00000000000006d8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6d8:	7119                	addi	sp,sp,-128
 6da:	fc86                	sd	ra,120(sp)
 6dc:	f8a2                	sd	s0,112(sp)
 6de:	f4a6                	sd	s1,104(sp)
 6e0:	f0ca                	sd	s2,96(sp)
 6e2:	ecce                	sd	s3,88(sp)
 6e4:	e8d2                	sd	s4,80(sp)
 6e6:	e4d6                	sd	s5,72(sp)
 6e8:	e0da                	sd	s6,64(sp)
 6ea:	fc5e                	sd	s7,56(sp)
 6ec:	f862                	sd	s8,48(sp)
 6ee:	f466                	sd	s9,40(sp)
 6f0:	f06a                	sd	s10,32(sp)
 6f2:	ec6e                	sd	s11,24(sp)
 6f4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6f6:	0005c483          	lbu	s1,0(a1)
 6fa:	18048d63          	beqz	s1,894 <vprintf+0x1bc>
 6fe:	8aaa                	mv	s5,a0
 700:	8b32                	mv	s6,a2
 702:	00158913          	addi	s2,a1,1
  state = 0;
 706:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 708:	02500a13          	li	s4,37
      if(c == 'd'){
 70c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 710:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 714:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 718:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 71c:	00000b97          	auipc	s7,0x0
 720:	3d4b8b93          	addi	s7,s7,980 # af0 <digits>
 724:	a839                	j	742 <vprintf+0x6a>
        putc(fd, c);
 726:	85a6                	mv	a1,s1
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	ee0080e7          	jalr	-288(ra) # 60a <putc>
 732:	a019                	j	738 <vprintf+0x60>
    } else if(state == '%'){
 734:	01498f63          	beq	s3,s4,752 <vprintf+0x7a>
 738:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 73a:	fff94483          	lbu	s1,-1(s2)
 73e:	14048b63          	beqz	s1,894 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 742:	0004879b          	sext.w	a5,s1
    if(state == 0){
 746:	fe0997e3          	bnez	s3,734 <vprintf+0x5c>
      if(c == '%'){
 74a:	fd479ee3          	bne	a5,s4,726 <vprintf+0x4e>
        state = '%';
 74e:	89be                	mv	s3,a5
 750:	b7e5                	j	738 <vprintf+0x60>
      if(c == 'd'){
 752:	05878063          	beq	a5,s8,792 <vprintf+0xba>
      } else if(c == 'l') {
 756:	05978c63          	beq	a5,s9,7ae <vprintf+0xd6>
      } else if(c == 'x') {
 75a:	07a78863          	beq	a5,s10,7ca <vprintf+0xf2>
      } else if(c == 'p') {
 75e:	09b78463          	beq	a5,s11,7e6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 762:	07300713          	li	a4,115
 766:	0ce78563          	beq	a5,a4,830 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 76a:	06300713          	li	a4,99
 76e:	0ee78c63          	beq	a5,a4,866 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 772:	11478663          	beq	a5,s4,87e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 776:	85d2                	mv	a1,s4
 778:	8556                	mv	a0,s5
 77a:	00000097          	auipc	ra,0x0
 77e:	e90080e7          	jalr	-368(ra) # 60a <putc>
        putc(fd, c);
 782:	85a6                	mv	a1,s1
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	e84080e7          	jalr	-380(ra) # 60a <putc>
      }
      state = 0;
 78e:	4981                	li	s3,0
 790:	b765                	j	738 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 792:	008b0493          	addi	s1,s6,8
 796:	4685                	li	a3,1
 798:	4629                	li	a2,10
 79a:	000b2583          	lw	a1,0(s6)
 79e:	8556                	mv	a0,s5
 7a0:	00000097          	auipc	ra,0x0
 7a4:	e8c080e7          	jalr	-372(ra) # 62c <printint>
 7a8:	8b26                	mv	s6,s1
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	b771                	j	738 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ae:	008b0493          	addi	s1,s6,8
 7b2:	4681                	li	a3,0
 7b4:	4629                	li	a2,10
 7b6:	000b2583          	lw	a1,0(s6)
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e70080e7          	jalr	-400(ra) # 62c <printint>
 7c4:	8b26                	mv	s6,s1
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	bf85                	j	738 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7ca:	008b0493          	addi	s1,s6,8
 7ce:	4681                	li	a3,0
 7d0:	4641                	li	a2,16
 7d2:	000b2583          	lw	a1,0(s6)
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	e54080e7          	jalr	-428(ra) # 62c <printint>
 7e0:	8b26                	mv	s6,s1
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	bf91                	j	738 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7e6:	008b0793          	addi	a5,s6,8
 7ea:	f8f43423          	sd	a5,-120(s0)
 7ee:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7f2:	03000593          	li	a1,48
 7f6:	8556                	mv	a0,s5
 7f8:	00000097          	auipc	ra,0x0
 7fc:	e12080e7          	jalr	-494(ra) # 60a <putc>
  putc(fd, 'x');
 800:	85ea                	mv	a1,s10
 802:	8556                	mv	a0,s5
 804:	00000097          	auipc	ra,0x0
 808:	e06080e7          	jalr	-506(ra) # 60a <putc>
 80c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 80e:	03c9d793          	srli	a5,s3,0x3c
 812:	97de                	add	a5,a5,s7
 814:	0007c583          	lbu	a1,0(a5)
 818:	8556                	mv	a0,s5
 81a:	00000097          	auipc	ra,0x0
 81e:	df0080e7          	jalr	-528(ra) # 60a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 822:	0992                	slli	s3,s3,0x4
 824:	34fd                	addiw	s1,s1,-1
 826:	f4e5                	bnez	s1,80e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 828:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 82c:	4981                	li	s3,0
 82e:	b729                	j	738 <vprintf+0x60>
        s = va_arg(ap, char*);
 830:	008b0993          	addi	s3,s6,8
 834:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 838:	c085                	beqz	s1,858 <vprintf+0x180>
        while(*s != 0){
 83a:	0004c583          	lbu	a1,0(s1)
 83e:	c9a1                	beqz	a1,88e <vprintf+0x1b6>
          putc(fd, *s);
 840:	8556                	mv	a0,s5
 842:	00000097          	auipc	ra,0x0
 846:	dc8080e7          	jalr	-568(ra) # 60a <putc>
          s++;
 84a:	0485                	addi	s1,s1,1
        while(*s != 0){
 84c:	0004c583          	lbu	a1,0(s1)
 850:	f9e5                	bnez	a1,840 <vprintf+0x168>
        s = va_arg(ap, char*);
 852:	8b4e                	mv	s6,s3
      state = 0;
 854:	4981                	li	s3,0
 856:	b5cd                	j	738 <vprintf+0x60>
          s = "(null)";
 858:	00000497          	auipc	s1,0x0
 85c:	2b048493          	addi	s1,s1,688 # b08 <digits+0x18>
        while(*s != 0){
 860:	02800593          	li	a1,40
 864:	bff1                	j	840 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 866:	008b0493          	addi	s1,s6,8
 86a:	000b4583          	lbu	a1,0(s6)
 86e:	8556                	mv	a0,s5
 870:	00000097          	auipc	ra,0x0
 874:	d9a080e7          	jalr	-614(ra) # 60a <putc>
 878:	8b26                	mv	s6,s1
      state = 0;
 87a:	4981                	li	s3,0
 87c:	bd75                	j	738 <vprintf+0x60>
        putc(fd, c);
 87e:	85d2                	mv	a1,s4
 880:	8556                	mv	a0,s5
 882:	00000097          	auipc	ra,0x0
 886:	d88080e7          	jalr	-632(ra) # 60a <putc>
      state = 0;
 88a:	4981                	li	s3,0
 88c:	b575                	j	738 <vprintf+0x60>
        s = va_arg(ap, char*);
 88e:	8b4e                	mv	s6,s3
      state = 0;
 890:	4981                	li	s3,0
 892:	b55d                	j	738 <vprintf+0x60>
    }
  }
}
 894:	70e6                	ld	ra,120(sp)
 896:	7446                	ld	s0,112(sp)
 898:	74a6                	ld	s1,104(sp)
 89a:	7906                	ld	s2,96(sp)
 89c:	69e6                	ld	s3,88(sp)
 89e:	6a46                	ld	s4,80(sp)
 8a0:	6aa6                	ld	s5,72(sp)
 8a2:	6b06                	ld	s6,64(sp)
 8a4:	7be2                	ld	s7,56(sp)
 8a6:	7c42                	ld	s8,48(sp)
 8a8:	7ca2                	ld	s9,40(sp)
 8aa:	7d02                	ld	s10,32(sp)
 8ac:	6de2                	ld	s11,24(sp)
 8ae:	6109                	addi	sp,sp,128
 8b0:	8082                	ret

00000000000008b2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8b2:	715d                	addi	sp,sp,-80
 8b4:	ec06                	sd	ra,24(sp)
 8b6:	e822                	sd	s0,16(sp)
 8b8:	1000                	addi	s0,sp,32
 8ba:	e010                	sd	a2,0(s0)
 8bc:	e414                	sd	a3,8(s0)
 8be:	e818                	sd	a4,16(s0)
 8c0:	ec1c                	sd	a5,24(s0)
 8c2:	03043023          	sd	a6,32(s0)
 8c6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8ca:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ce:	8622                	mv	a2,s0
 8d0:	00000097          	auipc	ra,0x0
 8d4:	e08080e7          	jalr	-504(ra) # 6d8 <vprintf>
}
 8d8:	60e2                	ld	ra,24(sp)
 8da:	6442                	ld	s0,16(sp)
 8dc:	6161                	addi	sp,sp,80
 8de:	8082                	ret

00000000000008e0 <printf>:

void
printf(const char *fmt, ...)
{
 8e0:	711d                	addi	sp,sp,-96
 8e2:	ec06                	sd	ra,24(sp)
 8e4:	e822                	sd	s0,16(sp)
 8e6:	1000                	addi	s0,sp,32
 8e8:	e40c                	sd	a1,8(s0)
 8ea:	e810                	sd	a2,16(s0)
 8ec:	ec14                	sd	a3,24(s0)
 8ee:	f018                	sd	a4,32(s0)
 8f0:	f41c                	sd	a5,40(s0)
 8f2:	03043823          	sd	a6,48(s0)
 8f6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8fa:	00840613          	addi	a2,s0,8
 8fe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 902:	85aa                	mv	a1,a0
 904:	4505                	li	a0,1
 906:	00000097          	auipc	ra,0x0
 90a:	dd2080e7          	jalr	-558(ra) # 6d8 <vprintf>
}
 90e:	60e2                	ld	ra,24(sp)
 910:	6442                	ld	s0,16(sp)
 912:	6125                	addi	sp,sp,96
 914:	8082                	ret

0000000000000916 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 916:	1141                	addi	sp,sp,-16
 918:	e422                	sd	s0,8(sp)
 91a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 91c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 920:	00000797          	auipc	a5,0x0
 924:	1f078793          	addi	a5,a5,496 # b10 <__DATA_BEGIN__>
 928:	639c                	ld	a5,0(a5)
 92a:	a805                	j	95a <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 92c:	4618                	lw	a4,8(a2)
 92e:	9db9                	addw	a1,a1,a4
 930:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 934:	6398                	ld	a4,0(a5)
 936:	6318                	ld	a4,0(a4)
 938:	fee53823          	sd	a4,-16(a0)
 93c:	a091                	j	980 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 93e:	ff852703          	lw	a4,-8(a0)
 942:	9e39                	addw	a2,a2,a4
 944:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 946:	ff053703          	ld	a4,-16(a0)
 94a:	e398                	sd	a4,0(a5)
 94c:	a099                	j	992 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 94e:	6398                	ld	a4,0(a5)
 950:	00e7e463          	bltu	a5,a4,958 <free+0x42>
 954:	00e6ea63          	bltu	a3,a4,968 <free+0x52>
{
 958:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 95a:	fed7fae3          	bgeu	a5,a3,94e <free+0x38>
 95e:	6398                	ld	a4,0(a5)
 960:	00e6e463          	bltu	a3,a4,968 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 964:	fee7eae3          	bltu	a5,a4,958 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 968:	ff852583          	lw	a1,-8(a0)
 96c:	6390                	ld	a2,0(a5)
 96e:	02059713          	slli	a4,a1,0x20
 972:	9301                	srli	a4,a4,0x20
 974:	0712                	slli	a4,a4,0x4
 976:	9736                	add	a4,a4,a3
 978:	fae60ae3          	beq	a2,a4,92c <free+0x16>
    bp->s.ptr = p->s.ptr;
 97c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 980:	4790                	lw	a2,8(a5)
 982:	02061713          	slli	a4,a2,0x20
 986:	9301                	srli	a4,a4,0x20
 988:	0712                	slli	a4,a4,0x4
 98a:	973e                	add	a4,a4,a5
 98c:	fae689e3          	beq	a3,a4,93e <free+0x28>
  } else
    p->s.ptr = bp;
 990:	e394                	sd	a3,0(a5)
  freep = p;
 992:	00000717          	auipc	a4,0x0
 996:	16f73f23          	sd	a5,382(a4) # b10 <__DATA_BEGIN__>
}
 99a:	6422                	ld	s0,8(sp)
 99c:	0141                	addi	sp,sp,16
 99e:	8082                	ret

00000000000009a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9a0:	7139                	addi	sp,sp,-64
 9a2:	fc06                	sd	ra,56(sp)
 9a4:	f822                	sd	s0,48(sp)
 9a6:	f426                	sd	s1,40(sp)
 9a8:	f04a                	sd	s2,32(sp)
 9aa:	ec4e                	sd	s3,24(sp)
 9ac:	e852                	sd	s4,16(sp)
 9ae:	e456                	sd	s5,8(sp)
 9b0:	e05a                	sd	s6,0(sp)
 9b2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9b4:	02051993          	slli	s3,a0,0x20
 9b8:	0209d993          	srli	s3,s3,0x20
 9bc:	09bd                	addi	s3,s3,15
 9be:	0049d993          	srli	s3,s3,0x4
 9c2:	2985                	addiw	s3,s3,1
 9c4:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 9c8:	00000797          	auipc	a5,0x0
 9cc:	14878793          	addi	a5,a5,328 # b10 <__DATA_BEGIN__>
 9d0:	6388                	ld	a0,0(a5)
 9d2:	c515                	beqz	a0,9fe <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d6:	4798                	lw	a4,8(a5)
 9d8:	03277f63          	bgeu	a4,s2,a16 <malloc+0x76>
 9dc:	8a4e                	mv	s4,s3
 9de:	0009871b          	sext.w	a4,s3
 9e2:	6685                	lui	a3,0x1
 9e4:	00d77363          	bgeu	a4,a3,9ea <malloc+0x4a>
 9e8:	6a05                	lui	s4,0x1
 9ea:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 9ee:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9f2:	00000497          	auipc	s1,0x0
 9f6:	11e48493          	addi	s1,s1,286 # b10 <__DATA_BEGIN__>
  if(p == (char*)-1)
 9fa:	5b7d                	li	s6,-1
 9fc:	a885                	j	a6c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 9fe:	00000797          	auipc	a5,0x0
 a02:	14278793          	addi	a5,a5,322 # b40 <base>
 a06:	00000717          	auipc	a4,0x0
 a0a:	10f73523          	sd	a5,266(a4) # b10 <__DATA_BEGIN__>
 a0e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a10:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a14:	b7e1                	j	9dc <malloc+0x3c>
      if(p->s.size == nunits)
 a16:	02e90b63          	beq	s2,a4,a4c <malloc+0xac>
        p->s.size -= nunits;
 a1a:	4137073b          	subw	a4,a4,s3
 a1e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a20:	1702                	slli	a4,a4,0x20
 a22:	9301                	srli	a4,a4,0x20
 a24:	0712                	slli	a4,a4,0x4
 a26:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a28:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a2c:	00000717          	auipc	a4,0x0
 a30:	0ea73223          	sd	a0,228(a4) # b10 <__DATA_BEGIN__>
      return (void*)(p + 1);
 a34:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a38:	70e2                	ld	ra,56(sp)
 a3a:	7442                	ld	s0,48(sp)
 a3c:	74a2                	ld	s1,40(sp)
 a3e:	7902                	ld	s2,32(sp)
 a40:	69e2                	ld	s3,24(sp)
 a42:	6a42                	ld	s4,16(sp)
 a44:	6aa2                	ld	s5,8(sp)
 a46:	6b02                	ld	s6,0(sp)
 a48:	6121                	addi	sp,sp,64
 a4a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a4c:	6398                	ld	a4,0(a5)
 a4e:	e118                	sd	a4,0(a0)
 a50:	bff1                	j	a2c <malloc+0x8c>
  hp->s.size = nu;
 a52:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 a56:	0541                	addi	a0,a0,16
 a58:	00000097          	auipc	ra,0x0
 a5c:	ebe080e7          	jalr	-322(ra) # 916 <free>
  return freep;
 a60:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a62:	d979                	beqz	a0,a38 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a64:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a66:	4798                	lw	a4,8(a5)
 a68:	fb2777e3          	bgeu	a4,s2,a16 <malloc+0x76>
    if(p == freep)
 a6c:	6098                	ld	a4,0(s1)
 a6e:	853e                	mv	a0,a5
 a70:	fef71ae3          	bne	a4,a5,a64 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 a74:	8552                	mv	a0,s4
 a76:	00000097          	auipc	ra,0x0
 a7a:	b38080e7          	jalr	-1224(ra) # 5ae <sbrk>
  if(p == (char*)-1)
 a7e:	fd651ae3          	bne	a0,s6,a52 <malloc+0xb2>
        return 0;
 a82:	4501                	li	a0,0
 a84:	bf55                	j	a38 <malloc+0x98>
