
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
  14:	24c080e7          	jalr	588(ra) # 25c <strlen>
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
  36:	a3e98993          	addi	s3,s3,-1474 # a70 <buf.0>
  3a:	8626                	mv	a2,s1
  3c:	85ca                	mv	a1,s2
  3e:	854e                	mv	a0,s3
  40:	00000097          	auipc	ra,0x0
  44:	3ac080e7          	jalr	940(ra) # 3ec <memmove>
  memset(buf + len, ' ', STAT_MAX_NAME - len);
  48:	02000613          	li	a2,32
  4c:	9e05                	subw	a2,a2,s1
  4e:	02000593          	li	a1,32
  52:	00998533          	add	a0,s3,s1
  56:	00000097          	auipc	ra,0x0
  5a:	230080e7          	jalr	560(ra) # 286 <memset>
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
  72:	e8d2                	sd	s4,80(sp)
  74:	0100                	addi	s0,sp,128
  76:	892a                	mv	s2,a0
  int fd;
  struct stat st;
  char *types[] = {
  78:	f8043023          	sd	zero,-128(s0)
  7c:	00001797          	auipc	a5,0x1
  80:	96c78793          	addi	a5,a5,-1684 # 9e8 <malloc+0xee>
  84:	f8f43423          	sd	a5,-120(s0)
  88:	00001797          	auipc	a5,0x1
  8c:	96878793          	addi	a5,a5,-1688 # 9f0 <malloc+0xf6>
  90:	f8f43823          	sd	a5,-112(s0)
    [T_DIR]   "DIR ",
    [T_FILE]  "FILE",
  };

  if((fd = open(path, 0)) < 0){
  94:	4581                	li	a1,0
  96:	00000097          	auipc	ra,0x0
  9a:	448080e7          	jalr	1096(ra) # 4de <open>
  9e:	02054863          	bltz	a0,ce <ls+0x68>
  a2:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  a4:	f9840593          	addi	a1,s0,-104
  a8:	00000097          	auipc	ra,0x0
  ac:	43e080e7          	jalr	1086(ra) # 4e6 <fstat>
  b0:	02054a63          	bltz	a0,e4 <ls+0x7e>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  if (st.type == T_DIR){
  b4:	fc041703          	lh	a4,-64(s0)
  b8:	4785                	li	a5,1
  ba:	08f71f63          	bne	a4,a5,158 <ls+0xf2>
    while(readdir(fd, &st) == 1){
  be:	f9840913          	addi	s2,s0,-104
  c2:	4985                	li	s3,1
      printf("%s %s\t%d\n", fmtname(st.name), types[st.type], st.size);
  c4:	00001a17          	auipc	s4,0x1
  c8:	964a0a13          	addi	s4,s4,-1692 # a28 <malloc+0x12e>
  cc:	a08d                	j	12e <ls+0xc8>
    fprintf(2, "ls: cannot open %s\n", path);
  ce:	864a                	mv	a2,s2
  d0:	00001597          	auipc	a1,0x1
  d4:	92858593          	addi	a1,a1,-1752 # 9f8 <malloc+0xfe>
  d8:	4509                	li	a0,2
  da:	00000097          	auipc	ra,0x0
  de:	734080e7          	jalr	1844(ra) # 80e <fprintf>
    return;
  e2:	a09d                	j	148 <ls+0xe2>
    fprintf(2, "ls: cannot stat %s\n", path);
  e4:	864a                	mv	a2,s2
  e6:	00001597          	auipc	a1,0x1
  ea:	92a58593          	addi	a1,a1,-1750 # a10 <malloc+0x116>
  ee:	4509                	li	a0,2
  f0:	00000097          	auipc	ra,0x0
  f4:	71e080e7          	jalr	1822(ra) # 80e <fprintf>
    close(fd);
  f8:	8526                	mv	a0,s1
  fa:	00000097          	auipc	ra,0x0
  fe:	3cc080e7          	jalr	972(ra) # 4c6 <close>
    return;
 102:	a099                	j	148 <ls+0xe2>
      printf("%s %s\t%d\n", fmtname(st.name), types[st.type], st.size);
 104:	854a                	mv	a0,s2
 106:	00000097          	auipc	ra,0x0
 10a:	efa080e7          	jalr	-262(ra) # 0 <fmtname>
 10e:	85aa                	mv	a1,a0
 110:	fc041783          	lh	a5,-64(s0)
 114:	078e                	slli	a5,a5,0x3
 116:	fd040713          	addi	a4,s0,-48
 11a:	97ba                	add	a5,a5,a4
 11c:	fc843683          	ld	a3,-56(s0)
 120:	fb07b603          	ld	a2,-80(a5)
 124:	8552                	mv	a0,s4
 126:	00000097          	auipc	ra,0x0
 12a:	716080e7          	jalr	1814(ra) # 83c <printf>
    while(readdir(fd, &st) == 1){
 12e:	85ca                	mv	a1,s2
 130:	8526                	mv	a0,s1
 132:	00000097          	auipc	ra,0x0
 136:	404080e7          	jalr	1028(ra) # 536 <readdir>
 13a:	fd3505e3          	beq	a0,s3,104 <ls+0x9e>
    }
  } else {
    printf("%s %s\t%l\n", fmtname(st.name), types[st.type], st.size);
  }
  close(fd);
 13e:	8526                	mv	a0,s1
 140:	00000097          	auipc	ra,0x0
 144:	386080e7          	jalr	902(ra) # 4c6 <close>
}
 148:	70e6                	ld	ra,120(sp)
 14a:	7446                	ld	s0,112(sp)
 14c:	74a6                	ld	s1,104(sp)
 14e:	7906                	ld	s2,96(sp)
 150:	69e6                	ld	s3,88(sp)
 152:	6a46                	ld	s4,80(sp)
 154:	6109                	addi	sp,sp,128
 156:	8082                	ret
    printf("%s %s\t%l\n", fmtname(st.name), types[st.type], st.size);
 158:	f9840513          	addi	a0,s0,-104
 15c:	00000097          	auipc	ra,0x0
 160:	ea4080e7          	jalr	-348(ra) # 0 <fmtname>
 164:	85aa                	mv	a1,a0
 166:	fc041783          	lh	a5,-64(s0)
 16a:	078e                	slli	a5,a5,0x3
 16c:	fd040713          	addi	a4,s0,-48
 170:	97ba                	add	a5,a5,a4
 172:	fc843683          	ld	a3,-56(s0)
 176:	fb07b603          	ld	a2,-80(a5)
 17a:	00001517          	auipc	a0,0x1
 17e:	8be50513          	addi	a0,a0,-1858 # a38 <malloc+0x13e>
 182:	00000097          	auipc	ra,0x0
 186:	6ba080e7          	jalr	1722(ra) # 83c <printf>
 18a:	bf55                	j	13e <ls+0xd8>

000000000000018c <main>:

int
main(int argc, char *argv[])
{
 18c:	1101                	addi	sp,sp,-32
 18e:	ec06                	sd	ra,24(sp)
 190:	e822                	sd	s0,16(sp)
 192:	e426                	sd	s1,8(sp)
 194:	e04a                	sd	s2,0(sp)
 196:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 198:	4785                	li	a5,1
 19a:	02a7d963          	bge	a5,a0,1cc <main+0x40>
 19e:	00858493          	addi	s1,a1,8
 1a2:	ffe5091b          	addiw	s2,a0,-2
 1a6:	1902                	slli	s2,s2,0x20
 1a8:	02095913          	srli	s2,s2,0x20
 1ac:	090e                	slli	s2,s2,0x3
 1ae:	05c1                	addi	a1,a1,16
 1b0:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 1b2:	6088                	ld	a0,0(s1)
 1b4:	00000097          	auipc	ra,0x0
 1b8:	eb2080e7          	jalr	-334(ra) # 66 <ls>
  for(i=1; i<argc; i++)
 1bc:	04a1                	addi	s1,s1,8
 1be:	ff249ae3          	bne	s1,s2,1b2 <main+0x26>
  exit(0);
 1c2:	4501                	li	a0,0
 1c4:	00000097          	auipc	ra,0x0
 1c8:	2da080e7          	jalr	730(ra) # 49e <exit>
    ls(".");
 1cc:	00001517          	auipc	a0,0x1
 1d0:	87c50513          	addi	a0,a0,-1924 # a48 <malloc+0x14e>
 1d4:	00000097          	auipc	ra,0x0
 1d8:	e92080e7          	jalr	-366(ra) # 66 <ls>
    exit(0);
 1dc:	4501                	li	a0,0
 1de:	00000097          	auipc	ra,0x0
 1e2:	2c0080e7          	jalr	704(ra) # 49e <exit>

00000000000001e6 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ec:	87aa                	mv	a5,a0
 1ee:	0585                	addi	a1,a1,1
 1f0:	0785                	addi	a5,a5,1
 1f2:	fff5c703          	lbu	a4,-1(a1)
 1f6:	fee78fa3          	sb	a4,-1(a5)
 1fa:	fb75                	bnez	a4,1ee <strcpy+0x8>
    ;
  return os;
}
 1fc:	6422                	ld	s0,8(sp)
 1fe:	0141                	addi	sp,sp,16
 200:	8082                	ret

0000000000000202 <strcat>:

char*
strcat(char *s, const char *t)
{
 202:	1141                	addi	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 208:	00054783          	lbu	a5,0(a0)
 20c:	c385                	beqz	a5,22c <strcat+0x2a>
 20e:	87aa                	mv	a5,a0
    s++;
 210:	0785                	addi	a5,a5,1
  while(*s)
 212:	0007c703          	lbu	a4,0(a5)
 216:	ff6d                	bnez	a4,210 <strcat+0xe>
  while((*s++ = *t++))
 218:	0585                	addi	a1,a1,1
 21a:	0785                	addi	a5,a5,1
 21c:	fff5c703          	lbu	a4,-1(a1)
 220:	fee78fa3          	sb	a4,-1(a5)
 224:	fb75                	bnez	a4,218 <strcat+0x16>
    ;
  return os;
}
 226:	6422                	ld	s0,8(sp)
 228:	0141                	addi	sp,sp,16
 22a:	8082                	ret
  while(*s)
 22c:	87aa                	mv	a5,a0
 22e:	b7ed                	j	218 <strcat+0x16>

0000000000000230 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 236:	00054783          	lbu	a5,0(a0)
 23a:	cb91                	beqz	a5,24e <strcmp+0x1e>
 23c:	0005c703          	lbu	a4,0(a1)
 240:	00f71763          	bne	a4,a5,24e <strcmp+0x1e>
    p++, q++;
 244:	0505                	addi	a0,a0,1
 246:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 248:	00054783          	lbu	a5,0(a0)
 24c:	fbe5                	bnez	a5,23c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 24e:	0005c503          	lbu	a0,0(a1)
}
 252:	40a7853b          	subw	a0,a5,a0
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret

000000000000025c <strlen>:

uint
strlen(const char *s)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 262:	00054783          	lbu	a5,0(a0)
 266:	cf91                	beqz	a5,282 <strlen+0x26>
 268:	0505                	addi	a0,a0,1
 26a:	87aa                	mv	a5,a0
 26c:	4685                	li	a3,1
 26e:	9e89                	subw	a3,a3,a0
 270:	00f6853b          	addw	a0,a3,a5
 274:	0785                	addi	a5,a5,1
 276:	fff7c703          	lbu	a4,-1(a5)
 27a:	fb7d                	bnez	a4,270 <strlen+0x14>
    ;
  return n;
}
 27c:	6422                	ld	s0,8(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret
  for(n = 0; s[n]; n++)
 282:	4501                	li	a0,0
 284:	bfe5                	j	27c <strlen+0x20>

0000000000000286 <memset>:

void*
memset(void *dst, int c, uint n)
{
 286:	1141                	addi	sp,sp,-16
 288:	e422                	sd	s0,8(sp)
 28a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 28c:	ca19                	beqz	a2,2a2 <memset+0x1c>
 28e:	87aa                	mv	a5,a0
 290:	1602                	slli	a2,a2,0x20
 292:	9201                	srli	a2,a2,0x20
 294:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 298:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 29c:	0785                	addi	a5,a5,1
 29e:	fee79de3          	bne	a5,a4,298 <memset+0x12>
  }
  return dst;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret

00000000000002a8 <strchr>:

char*
strchr(const char *s, char c)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	cb99                	beqz	a5,2c8 <strchr+0x20>
    if(*s == c)
 2b4:	00f58763          	beq	a1,a5,2c2 <strchr+0x1a>
  for(; *s; s++)
 2b8:	0505                	addi	a0,a0,1
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	fbfd                	bnez	a5,2b4 <strchr+0xc>
      return (char*)s;
  return 0;
 2c0:	4501                	li	a0,0
}
 2c2:	6422                	ld	s0,8(sp)
 2c4:	0141                	addi	sp,sp,16
 2c6:	8082                	ret
  return 0;
 2c8:	4501                	li	a0,0
 2ca:	bfe5                	j	2c2 <strchr+0x1a>

00000000000002cc <gets>:

char*
gets(char *buf, int max)
{
 2cc:	711d                	addi	sp,sp,-96
 2ce:	ec86                	sd	ra,88(sp)
 2d0:	e8a2                	sd	s0,80(sp)
 2d2:	e4a6                	sd	s1,72(sp)
 2d4:	e0ca                	sd	s2,64(sp)
 2d6:	fc4e                	sd	s3,56(sp)
 2d8:	f852                	sd	s4,48(sp)
 2da:	f456                	sd	s5,40(sp)
 2dc:	f05a                	sd	s6,32(sp)
 2de:	ec5e                	sd	s7,24(sp)
 2e0:	e862                	sd	s8,16(sp)
 2e2:	1080                	addi	s0,sp,96
 2e4:	8baa                	mv	s7,a0
 2e6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e8:	892a                	mv	s2,a0
 2ea:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2ec:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2f0:	4b29                	li	s6,10
 2f2:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 2f4:	89a6                	mv	s3,s1
 2f6:	2485                	addiw	s1,s1,1
 2f8:	0344d763          	bge	s1,s4,326 <gets+0x5a>
    cc = read(0, &c, 1);
 2fc:	4605                	li	a2,1
 2fe:	85d6                	mv	a1,s5
 300:	4501                	li	a0,0
 302:	00000097          	auipc	ra,0x0
 306:	1b4080e7          	jalr	436(ra) # 4b6 <read>
    if(cc < 1)
 30a:	00a05e63          	blez	a0,326 <gets+0x5a>
    buf[i++] = c;
 30e:	faf44783          	lbu	a5,-81(s0)
 312:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 316:	01678763          	beq	a5,s6,324 <gets+0x58>
 31a:	0905                	addi	s2,s2,1
 31c:	fd879ce3          	bne	a5,s8,2f4 <gets+0x28>
  for(i=0; i+1 < max; ){
 320:	89a6                	mv	s3,s1
 322:	a011                	j	326 <gets+0x5a>
 324:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 326:	99de                	add	s3,s3,s7
 328:	00098023          	sb	zero,0(s3)
  return buf;
}
 32c:	855e                	mv	a0,s7
 32e:	60e6                	ld	ra,88(sp)
 330:	6446                	ld	s0,80(sp)
 332:	64a6                	ld	s1,72(sp)
 334:	6906                	ld	s2,64(sp)
 336:	79e2                	ld	s3,56(sp)
 338:	7a42                	ld	s4,48(sp)
 33a:	7aa2                	ld	s5,40(sp)
 33c:	7b02                	ld	s6,32(sp)
 33e:	6be2                	ld	s7,24(sp)
 340:	6c42                	ld	s8,16(sp)
 342:	6125                	addi	sp,sp,96
 344:	8082                	ret

0000000000000346 <stat>:

int
stat(const char *n, struct stat *st)
{
 346:	1101                	addi	sp,sp,-32
 348:	ec06                	sd	ra,24(sp)
 34a:	e822                	sd	s0,16(sp)
 34c:	e426                	sd	s1,8(sp)
 34e:	e04a                	sd	s2,0(sp)
 350:	1000                	addi	s0,sp,32
 352:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 354:	4581                	li	a1,0
 356:	00000097          	auipc	ra,0x0
 35a:	188080e7          	jalr	392(ra) # 4de <open>
  if(fd < 0)
 35e:	02054563          	bltz	a0,388 <stat+0x42>
 362:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 364:	85ca                	mv	a1,s2
 366:	00000097          	auipc	ra,0x0
 36a:	180080e7          	jalr	384(ra) # 4e6 <fstat>
 36e:	892a                	mv	s2,a0
  close(fd);
 370:	8526                	mv	a0,s1
 372:	00000097          	auipc	ra,0x0
 376:	154080e7          	jalr	340(ra) # 4c6 <close>
  return r;
}
 37a:	854a                	mv	a0,s2
 37c:	60e2                	ld	ra,24(sp)
 37e:	6442                	ld	s0,16(sp)
 380:	64a2                	ld	s1,8(sp)
 382:	6902                	ld	s2,0(sp)
 384:	6105                	addi	sp,sp,32
 386:	8082                	ret
    return -1;
 388:	597d                	li	s2,-1
 38a:	bfc5                	j	37a <stat+0x34>

000000000000038c <atoi>:

int
atoi(const char *s)
{
 38c:	1141                	addi	sp,sp,-16
 38e:	e422                	sd	s0,8(sp)
 390:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 392:	00054703          	lbu	a4,0(a0)
 396:	02d00793          	li	a5,45
  int neg = 1;
 39a:	4805                	li	a6,1
  if (*s == '-') {
 39c:	04f70363          	beq	a4,a5,3e2 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 3a0:	00054683          	lbu	a3,0(a0)
 3a4:	fd06879b          	addiw	a5,a3,-48
 3a8:	0ff7f793          	andi	a5,a5,255
 3ac:	4725                	li	a4,9
 3ae:	02f76d63          	bltu	a4,a5,3e8 <atoi+0x5c>
  n = 0;
 3b2:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 3b4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3b6:	0505                	addi	a0,a0,1
 3b8:	0026179b          	slliw	a5,a2,0x2
 3bc:	9fb1                	addw	a5,a5,a2
 3be:	0017979b          	slliw	a5,a5,0x1
 3c2:	9fb5                	addw	a5,a5,a3
 3c4:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 3c8:	00054683          	lbu	a3,0(a0)
 3cc:	fd06871b          	addiw	a4,a3,-48
 3d0:	0ff77713          	andi	a4,a4,255
 3d4:	fee5f1e3          	bgeu	a1,a4,3b6 <atoi+0x2a>
  return n * neg;
}
 3d8:	02c8053b          	mulw	a0,a6,a2
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	addi	sp,sp,16
 3e0:	8082                	ret
    s++;
 3e2:	0505                	addi	a0,a0,1
    neg = -1;
 3e4:	587d                	li	a6,-1
 3e6:	bf6d                	j	3a0 <atoi+0x14>
  n = 0;
 3e8:	4601                	li	a2,0
 3ea:	b7fd                	j	3d8 <atoi+0x4c>

00000000000003ec <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ec:	1141                	addi	sp,sp,-16
 3ee:	e422                	sd	s0,8(sp)
 3f0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3f2:	02b57463          	bgeu	a0,a1,41a <memmove+0x2e>
    while(n-- > 0)
 3f6:	00c05f63          	blez	a2,414 <memmove+0x28>
 3fa:	1602                	slli	a2,a2,0x20
 3fc:	9201                	srli	a2,a2,0x20
 3fe:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 402:	872a                	mv	a4,a0
      *dst++ = *src++;
 404:	0585                	addi	a1,a1,1
 406:	0705                	addi	a4,a4,1
 408:	fff5c683          	lbu	a3,-1(a1)
 40c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 410:	fee79ae3          	bne	a5,a4,404 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 414:	6422                	ld	s0,8(sp)
 416:	0141                	addi	sp,sp,16
 418:	8082                	ret
    dst += n;
 41a:	00c50733          	add	a4,a0,a2
    src += n;
 41e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 420:	fec05ae3          	blez	a2,414 <memmove+0x28>
 424:	fff6079b          	addiw	a5,a2,-1
 428:	1782                	slli	a5,a5,0x20
 42a:	9381                	srli	a5,a5,0x20
 42c:	fff7c793          	not	a5,a5
 430:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 432:	15fd                	addi	a1,a1,-1
 434:	177d                	addi	a4,a4,-1
 436:	0005c683          	lbu	a3,0(a1)
 43a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 43e:	fee79ae3          	bne	a5,a4,432 <memmove+0x46>
 442:	bfc9                	j	414 <memmove+0x28>

0000000000000444 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 444:	1141                	addi	sp,sp,-16
 446:	e422                	sd	s0,8(sp)
 448:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 44a:	ca05                	beqz	a2,47a <memcmp+0x36>
 44c:	fff6069b          	addiw	a3,a2,-1
 450:	1682                	slli	a3,a3,0x20
 452:	9281                	srli	a3,a3,0x20
 454:	0685                	addi	a3,a3,1
 456:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 458:	00054783          	lbu	a5,0(a0)
 45c:	0005c703          	lbu	a4,0(a1)
 460:	00e79863          	bne	a5,a4,470 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 464:	0505                	addi	a0,a0,1
    p2++;
 466:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 468:	fed518e3          	bne	a0,a3,458 <memcmp+0x14>
  }
  return 0;
 46c:	4501                	li	a0,0
 46e:	a019                	j	474 <memcmp+0x30>
      return *p1 - *p2;
 470:	40e7853b          	subw	a0,a5,a4
}
 474:	6422                	ld	s0,8(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret
  return 0;
 47a:	4501                	li	a0,0
 47c:	bfe5                	j	474 <memcmp+0x30>

000000000000047e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e406                	sd	ra,8(sp)
 482:	e022                	sd	s0,0(sp)
 484:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 486:	00000097          	auipc	ra,0x0
 48a:	f66080e7          	jalr	-154(ra) # 3ec <memmove>
}
 48e:	60a2                	ld	ra,8(sp)
 490:	6402                	ld	s0,0(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret

0000000000000496 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 496:	4885                	li	a7,1
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <exit>:
.global exit
exit:
 li a7, SYS_exit
 49e:	4889                	li	a7,2
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4a6:	488d                	li	a7,3
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4ae:	4891                	li	a7,4
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <read>:
.global read
read:
 li a7, SYS_read
 4b6:	4895                	li	a7,5
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <write>:
.global write
write:
 li a7, SYS_write
 4be:	48c1                	li	a7,16
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <close>:
.global close
close:
 li a7, SYS_close
 4c6:	48d5                	li	a7,21
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <kill>:
.global kill
kill:
 li a7, SYS_kill
 4ce:	4899                	li	a7,6
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4d6:	489d                	li	a7,7
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <open>:
.global open
open:
 li a7, SYS_open
 4de:	48bd                	li	a7,15
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4e6:	48a1                	li	a7,8
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ee:	48d1                	li	a7,20
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4f6:	48a5                	li	a7,9
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <dup>:
.global dup
dup:
 li a7, SYS_dup
 4fe:	48a9                	li	a7,10
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 506:	48ad                	li	a7,11
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 50e:	48b1                	li	a7,12
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 516:	48b5                	li	a7,13
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 51e:	48b9                	li	a7,14
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 526:	48d9                	li	a7,22
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <dev>:
.global dev
dev:
 li a7, SYS_dev
 52e:	48dd                	li	a7,23
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 536:	48e1                	li	a7,24
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 53e:	48e5                	li	a7,25
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <remove>:
.global remove
remove:
 li a7, SYS_remove
 546:	48c5                	li	a7,17
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <trace>:
.global trace
trace:
 li a7, SYS_trace
 54e:	48c9                	li	a7,18
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 556:	48cd                	li	a7,19
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <rename>:
.global rename
rename:
 li a7, SYS_rename
 55e:	48e9                	li	a7,26
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 566:	1101                	addi	sp,sp,-32
 568:	ec06                	sd	ra,24(sp)
 56a:	e822                	sd	s0,16(sp)
 56c:	1000                	addi	s0,sp,32
 56e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 572:	4605                	li	a2,1
 574:	fef40593          	addi	a1,s0,-17
 578:	00000097          	auipc	ra,0x0
 57c:	f46080e7          	jalr	-186(ra) # 4be <write>
}
 580:	60e2                	ld	ra,24(sp)
 582:	6442                	ld	s0,16(sp)
 584:	6105                	addi	sp,sp,32
 586:	8082                	ret

0000000000000588 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 588:	7139                	addi	sp,sp,-64
 58a:	fc06                	sd	ra,56(sp)
 58c:	f822                	sd	s0,48(sp)
 58e:	f426                	sd	s1,40(sp)
 590:	f04a                	sd	s2,32(sp)
 592:	ec4e                	sd	s3,24(sp)
 594:	0080                	addi	s0,sp,64
 596:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 598:	c299                	beqz	a3,59e <printint+0x16>
 59a:	0805c763          	bltz	a1,628 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 59e:	2581                	sext.w	a1,a1
  neg = 0;
 5a0:	4881                	li	a7,0
  }

  i = 0;
 5a2:	fc040993          	addi	s3,s0,-64
  neg = 0;
 5a6:	86ce                	mv	a3,s3
  i = 0;
 5a8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5aa:	2601                	sext.w	a2,a2
 5ac:	00000517          	auipc	a0,0x0
 5b0:	4ac50513          	addi	a0,a0,1196 # a58 <digits>
 5b4:	883a                	mv	a6,a4
 5b6:	2705                	addiw	a4,a4,1
 5b8:	02c5f7bb          	remuw	a5,a1,a2
 5bc:	1782                	slli	a5,a5,0x20
 5be:	9381                	srli	a5,a5,0x20
 5c0:	97aa                	add	a5,a5,a0
 5c2:	0007c783          	lbu	a5,0(a5)
 5c6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5ca:	0005879b          	sext.w	a5,a1
 5ce:	02c5d5bb          	divuw	a1,a1,a2
 5d2:	0685                	addi	a3,a3,1
 5d4:	fec7f0e3          	bgeu	a5,a2,5b4 <printint+0x2c>
  if(neg)
 5d8:	00088b63          	beqz	a7,5ee <printint+0x66>
    buf[i++] = '-';
 5dc:	fd040793          	addi	a5,s0,-48
 5e0:	973e                	add	a4,a4,a5
 5e2:	02d00793          	li	a5,45
 5e6:	fef70823          	sb	a5,-16(a4)
 5ea:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5ee:	02e05663          	blez	a4,61a <printint+0x92>
 5f2:	fc040913          	addi	s2,s0,-64
 5f6:	993a                	add	s2,s2,a4
 5f8:	19fd                	addi	s3,s3,-1
 5fa:	99ba                	add	s3,s3,a4
 5fc:	377d                	addiw	a4,a4,-1
 5fe:	1702                	slli	a4,a4,0x20
 600:	9301                	srli	a4,a4,0x20
 602:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 606:	fff94583          	lbu	a1,-1(s2)
 60a:	8526                	mv	a0,s1
 60c:	00000097          	auipc	ra,0x0
 610:	f5a080e7          	jalr	-166(ra) # 566 <putc>
  while(--i >= 0)
 614:	197d                	addi	s2,s2,-1
 616:	ff3918e3          	bne	s2,s3,606 <printint+0x7e>
}
 61a:	70e2                	ld	ra,56(sp)
 61c:	7442                	ld	s0,48(sp)
 61e:	74a2                	ld	s1,40(sp)
 620:	7902                	ld	s2,32(sp)
 622:	69e2                	ld	s3,24(sp)
 624:	6121                	addi	sp,sp,64
 626:	8082                	ret
    x = -xx;
 628:	40b005bb          	negw	a1,a1
    neg = 1;
 62c:	4885                	li	a7,1
    x = -xx;
 62e:	bf95                	j	5a2 <printint+0x1a>

0000000000000630 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 630:	7119                	addi	sp,sp,-128
 632:	fc86                	sd	ra,120(sp)
 634:	f8a2                	sd	s0,112(sp)
 636:	f4a6                	sd	s1,104(sp)
 638:	f0ca                	sd	s2,96(sp)
 63a:	ecce                	sd	s3,88(sp)
 63c:	e8d2                	sd	s4,80(sp)
 63e:	e4d6                	sd	s5,72(sp)
 640:	e0da                	sd	s6,64(sp)
 642:	fc5e                	sd	s7,56(sp)
 644:	f862                	sd	s8,48(sp)
 646:	f466                	sd	s9,40(sp)
 648:	f06a                	sd	s10,32(sp)
 64a:	ec6e                	sd	s11,24(sp)
 64c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 64e:	0005c903          	lbu	s2,0(a1)
 652:	18090f63          	beqz	s2,7f0 <vprintf+0x1c0>
 656:	8aaa                	mv	s5,a0
 658:	8b32                	mv	s6,a2
 65a:	00158493          	addi	s1,a1,1
  state = 0;
 65e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 660:	02500a13          	li	s4,37
      if(c == 'd'){
 664:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 668:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 66c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 670:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 674:	00000b97          	auipc	s7,0x0
 678:	3e4b8b93          	addi	s7,s7,996 # a58 <digits>
 67c:	a839                	j	69a <vprintf+0x6a>
        putc(fd, c);
 67e:	85ca                	mv	a1,s2
 680:	8556                	mv	a0,s5
 682:	00000097          	auipc	ra,0x0
 686:	ee4080e7          	jalr	-284(ra) # 566 <putc>
 68a:	a019                	j	690 <vprintf+0x60>
    } else if(state == '%'){
 68c:	01498f63          	beq	s3,s4,6aa <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 690:	0485                	addi	s1,s1,1
 692:	fff4c903          	lbu	s2,-1(s1)
 696:	14090d63          	beqz	s2,7f0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 69a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 69e:	fe0997e3          	bnez	s3,68c <vprintf+0x5c>
      if(c == '%'){
 6a2:	fd479ee3          	bne	a5,s4,67e <vprintf+0x4e>
        state = '%';
 6a6:	89be                	mv	s3,a5
 6a8:	b7e5                	j	690 <vprintf+0x60>
      if(c == 'd'){
 6aa:	05878063          	beq	a5,s8,6ea <vprintf+0xba>
      } else if(c == 'l') {
 6ae:	05978c63          	beq	a5,s9,706 <vprintf+0xd6>
      } else if(c == 'x') {
 6b2:	07a78863          	beq	a5,s10,722 <vprintf+0xf2>
      } else if(c == 'p') {
 6b6:	09b78463          	beq	a5,s11,73e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6ba:	07300713          	li	a4,115
 6be:	0ce78663          	beq	a5,a4,78a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6c2:	06300713          	li	a4,99
 6c6:	0ee78e63          	beq	a5,a4,7c2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6ca:	11478863          	beq	a5,s4,7da <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ce:	85d2                	mv	a1,s4
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	e94080e7          	jalr	-364(ra) # 566 <putc>
        putc(fd, c);
 6da:	85ca                	mv	a1,s2
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	e88080e7          	jalr	-376(ra) # 566 <putc>
      }
      state = 0;
 6e6:	4981                	li	s3,0
 6e8:	b765                	j	690 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6ea:	008b0913          	addi	s2,s6,8
 6ee:	4685                	li	a3,1
 6f0:	4629                	li	a2,10
 6f2:	000b2583          	lw	a1,0(s6)
 6f6:	8556                	mv	a0,s5
 6f8:	00000097          	auipc	ra,0x0
 6fc:	e90080e7          	jalr	-368(ra) # 588 <printint>
 700:	8b4a                	mv	s6,s2
      state = 0;
 702:	4981                	li	s3,0
 704:	b771                	j	690 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 706:	008b0913          	addi	s2,s6,8
 70a:	4681                	li	a3,0
 70c:	4629                	li	a2,10
 70e:	000b2583          	lw	a1,0(s6)
 712:	8556                	mv	a0,s5
 714:	00000097          	auipc	ra,0x0
 718:	e74080e7          	jalr	-396(ra) # 588 <printint>
 71c:	8b4a                	mv	s6,s2
      state = 0;
 71e:	4981                	li	s3,0
 720:	bf85                	j	690 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 722:	008b0913          	addi	s2,s6,8
 726:	4681                	li	a3,0
 728:	4641                	li	a2,16
 72a:	000b2583          	lw	a1,0(s6)
 72e:	8556                	mv	a0,s5
 730:	00000097          	auipc	ra,0x0
 734:	e58080e7          	jalr	-424(ra) # 588 <printint>
 738:	8b4a                	mv	s6,s2
      state = 0;
 73a:	4981                	li	s3,0
 73c:	bf91                	j	690 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 73e:	008b0793          	addi	a5,s6,8
 742:	f8f43423          	sd	a5,-120(s0)
 746:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 74a:	03000593          	li	a1,48
 74e:	8556                	mv	a0,s5
 750:	00000097          	auipc	ra,0x0
 754:	e16080e7          	jalr	-490(ra) # 566 <putc>
  putc(fd, 'x');
 758:	85ea                	mv	a1,s10
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	e0a080e7          	jalr	-502(ra) # 566 <putc>
 764:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 766:	03c9d793          	srli	a5,s3,0x3c
 76a:	97de                	add	a5,a5,s7
 76c:	0007c583          	lbu	a1,0(a5)
 770:	8556                	mv	a0,s5
 772:	00000097          	auipc	ra,0x0
 776:	df4080e7          	jalr	-524(ra) # 566 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 77a:	0992                	slli	s3,s3,0x4
 77c:	397d                	addiw	s2,s2,-1
 77e:	fe0914e3          	bnez	s2,766 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 782:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 786:	4981                	li	s3,0
 788:	b721                	j	690 <vprintf+0x60>
        s = va_arg(ap, char*);
 78a:	008b0993          	addi	s3,s6,8
 78e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 792:	02090163          	beqz	s2,7b4 <vprintf+0x184>
        while(*s != 0){
 796:	00094583          	lbu	a1,0(s2)
 79a:	c9a1                	beqz	a1,7ea <vprintf+0x1ba>
          putc(fd, *s);
 79c:	8556                	mv	a0,s5
 79e:	00000097          	auipc	ra,0x0
 7a2:	dc8080e7          	jalr	-568(ra) # 566 <putc>
          s++;
 7a6:	0905                	addi	s2,s2,1
        while(*s != 0){
 7a8:	00094583          	lbu	a1,0(s2)
 7ac:	f9e5                	bnez	a1,79c <vprintf+0x16c>
        s = va_arg(ap, char*);
 7ae:	8b4e                	mv	s6,s3
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	bdf9                	j	690 <vprintf+0x60>
          s = "(null)";
 7b4:	00000917          	auipc	s2,0x0
 7b8:	29c90913          	addi	s2,s2,668 # a50 <malloc+0x156>
        while(*s != 0){
 7bc:	02800593          	li	a1,40
 7c0:	bff1                	j	79c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7c2:	008b0913          	addi	s2,s6,8
 7c6:	000b4583          	lbu	a1,0(s6)
 7ca:	8556                	mv	a0,s5
 7cc:	00000097          	auipc	ra,0x0
 7d0:	d9a080e7          	jalr	-614(ra) # 566 <putc>
 7d4:	8b4a                	mv	s6,s2
      state = 0;
 7d6:	4981                	li	s3,0
 7d8:	bd65                	j	690 <vprintf+0x60>
        putc(fd, c);
 7da:	85d2                	mv	a1,s4
 7dc:	8556                	mv	a0,s5
 7de:	00000097          	auipc	ra,0x0
 7e2:	d88080e7          	jalr	-632(ra) # 566 <putc>
      state = 0;
 7e6:	4981                	li	s3,0
 7e8:	b565                	j	690 <vprintf+0x60>
        s = va_arg(ap, char*);
 7ea:	8b4e                	mv	s6,s3
      state = 0;
 7ec:	4981                	li	s3,0
 7ee:	b54d                	j	690 <vprintf+0x60>
    }
  }
}
 7f0:	70e6                	ld	ra,120(sp)
 7f2:	7446                	ld	s0,112(sp)
 7f4:	74a6                	ld	s1,104(sp)
 7f6:	7906                	ld	s2,96(sp)
 7f8:	69e6                	ld	s3,88(sp)
 7fa:	6a46                	ld	s4,80(sp)
 7fc:	6aa6                	ld	s5,72(sp)
 7fe:	6b06                	ld	s6,64(sp)
 800:	7be2                	ld	s7,56(sp)
 802:	7c42                	ld	s8,48(sp)
 804:	7ca2                	ld	s9,40(sp)
 806:	7d02                	ld	s10,32(sp)
 808:	6de2                	ld	s11,24(sp)
 80a:	6109                	addi	sp,sp,128
 80c:	8082                	ret

000000000000080e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 80e:	715d                	addi	sp,sp,-80
 810:	ec06                	sd	ra,24(sp)
 812:	e822                	sd	s0,16(sp)
 814:	1000                	addi	s0,sp,32
 816:	e010                	sd	a2,0(s0)
 818:	e414                	sd	a3,8(s0)
 81a:	e818                	sd	a4,16(s0)
 81c:	ec1c                	sd	a5,24(s0)
 81e:	03043023          	sd	a6,32(s0)
 822:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 826:	8622                	mv	a2,s0
 828:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 82c:	00000097          	auipc	ra,0x0
 830:	e04080e7          	jalr	-508(ra) # 630 <vprintf>
}
 834:	60e2                	ld	ra,24(sp)
 836:	6442                	ld	s0,16(sp)
 838:	6161                	addi	sp,sp,80
 83a:	8082                	ret

000000000000083c <printf>:

void
printf(const char *fmt, ...)
{
 83c:	711d                	addi	sp,sp,-96
 83e:	ec06                	sd	ra,24(sp)
 840:	e822                	sd	s0,16(sp)
 842:	1000                	addi	s0,sp,32
 844:	e40c                	sd	a1,8(s0)
 846:	e810                	sd	a2,16(s0)
 848:	ec14                	sd	a3,24(s0)
 84a:	f018                	sd	a4,32(s0)
 84c:	f41c                	sd	a5,40(s0)
 84e:	03043823          	sd	a6,48(s0)
 852:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 856:	00840613          	addi	a2,s0,8
 85a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 85e:	85aa                	mv	a1,a0
 860:	4505                	li	a0,1
 862:	00000097          	auipc	ra,0x0
 866:	dce080e7          	jalr	-562(ra) # 630 <vprintf>
}
 86a:	60e2                	ld	ra,24(sp)
 86c:	6442                	ld	s0,16(sp)
 86e:	6125                	addi	sp,sp,96
 870:	8082                	ret

0000000000000872 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 872:	1141                	addi	sp,sp,-16
 874:	e422                	sd	s0,8(sp)
 876:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 878:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 87c:	00000797          	auipc	a5,0x0
 880:	21c7b783          	ld	a5,540(a5) # a98 <freep>
 884:	a805                	j	8b4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 886:	4618                	lw	a4,8(a2)
 888:	9db9                	addw	a1,a1,a4
 88a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 88e:	6398                	ld	a4,0(a5)
 890:	6318                	ld	a4,0(a4)
 892:	fee53823          	sd	a4,-16(a0)
 896:	a091                	j	8da <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 898:	ff852703          	lw	a4,-8(a0)
 89c:	9e39                	addw	a2,a2,a4
 89e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8a0:	ff053703          	ld	a4,-16(a0)
 8a4:	e398                	sd	a4,0(a5)
 8a6:	a099                	j	8ec <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a8:	6398                	ld	a4,0(a5)
 8aa:	00e7e463          	bltu	a5,a4,8b2 <free+0x40>
 8ae:	00e6ea63          	bltu	a3,a4,8c2 <free+0x50>
{
 8b2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b4:	fed7fae3          	bgeu	a5,a3,8a8 <free+0x36>
 8b8:	6398                	ld	a4,0(a5)
 8ba:	00e6e463          	bltu	a3,a4,8c2 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8be:	fee7eae3          	bltu	a5,a4,8b2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8c2:	ff852583          	lw	a1,-8(a0)
 8c6:	6390                	ld	a2,0(a5)
 8c8:	02059713          	slli	a4,a1,0x20
 8cc:	9301                	srli	a4,a4,0x20
 8ce:	0712                	slli	a4,a4,0x4
 8d0:	9736                	add	a4,a4,a3
 8d2:	fae60ae3          	beq	a2,a4,886 <free+0x14>
    bp->s.ptr = p->s.ptr;
 8d6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8da:	4790                	lw	a2,8(a5)
 8dc:	02061713          	slli	a4,a2,0x20
 8e0:	9301                	srli	a4,a4,0x20
 8e2:	0712                	slli	a4,a4,0x4
 8e4:	973e                	add	a4,a4,a5
 8e6:	fae689e3          	beq	a3,a4,898 <free+0x26>
  } else
    p->s.ptr = bp;
 8ea:	e394                	sd	a3,0(a5)
  freep = p;
 8ec:	00000717          	auipc	a4,0x0
 8f0:	1af73623          	sd	a5,428(a4) # a98 <freep>
}
 8f4:	6422                	ld	s0,8(sp)
 8f6:	0141                	addi	sp,sp,16
 8f8:	8082                	ret

00000000000008fa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8fa:	7139                	addi	sp,sp,-64
 8fc:	fc06                	sd	ra,56(sp)
 8fe:	f822                	sd	s0,48(sp)
 900:	f426                	sd	s1,40(sp)
 902:	f04a                	sd	s2,32(sp)
 904:	ec4e                	sd	s3,24(sp)
 906:	e852                	sd	s4,16(sp)
 908:	e456                	sd	s5,8(sp)
 90a:	e05a                	sd	s6,0(sp)
 90c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 90e:	02051493          	slli	s1,a0,0x20
 912:	9081                	srli	s1,s1,0x20
 914:	04bd                	addi	s1,s1,15
 916:	8091                	srli	s1,s1,0x4
 918:	0014899b          	addiw	s3,s1,1
 91c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 91e:	00000517          	auipc	a0,0x0
 922:	17a53503          	ld	a0,378(a0) # a98 <freep>
 926:	c515                	beqz	a0,952 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 928:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 92a:	4798                	lw	a4,8(a5)
 92c:	04977163          	bgeu	a4,s1,96e <malloc+0x74>
 930:	8a4e                	mv	s4,s3
 932:	0009871b          	sext.w	a4,s3
 936:	6685                	lui	a3,0x1
 938:	00d77363          	bgeu	a4,a3,93e <malloc+0x44>
 93c:	6a05                	lui	s4,0x1
 93e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 942:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 946:	00000917          	auipc	s2,0x0
 94a:	15290913          	addi	s2,s2,338 # a98 <freep>
  if(p == (char*)-1)
 94e:	5afd                	li	s5,-1
 950:	a89d                	j	9c6 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 952:	00000797          	auipc	a5,0x0
 956:	14678793          	addi	a5,a5,326 # a98 <freep>
 95a:	00000717          	auipc	a4,0x0
 95e:	14670713          	addi	a4,a4,326 # aa0 <base>
 962:	e398                	sd	a4,0(a5)
 964:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 966:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96a:	87ba                	mv	a5,a4
 96c:	b7d1                	j	930 <malloc+0x36>
      if(p->s.size == nunits)
 96e:	02e48b63          	beq	s1,a4,9a4 <malloc+0xaa>
        p->s.size -= nunits;
 972:	4137073b          	subw	a4,a4,s3
 976:	c798                	sw	a4,8(a5)
        p += p->s.size;
 978:	1702                	slli	a4,a4,0x20
 97a:	9301                	srli	a4,a4,0x20
 97c:	0712                	slli	a4,a4,0x4
 97e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 980:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 984:	00000717          	auipc	a4,0x0
 988:	10a73a23          	sd	a0,276(a4) # a98 <freep>
      return (void*)(p + 1);
 98c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 990:	70e2                	ld	ra,56(sp)
 992:	7442                	ld	s0,48(sp)
 994:	74a2                	ld	s1,40(sp)
 996:	7902                	ld	s2,32(sp)
 998:	69e2                	ld	s3,24(sp)
 99a:	6a42                	ld	s4,16(sp)
 99c:	6aa2                	ld	s5,8(sp)
 99e:	6b02                	ld	s6,0(sp)
 9a0:	6121                	addi	sp,sp,64
 9a2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9a4:	6398                	ld	a4,0(a5)
 9a6:	e118                	sd	a4,0(a0)
 9a8:	bff1                	j	984 <malloc+0x8a>
  hp->s.size = nu;
 9aa:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ae:	0541                	addi	a0,a0,16
 9b0:	00000097          	auipc	ra,0x0
 9b4:	ec2080e7          	jalr	-318(ra) # 872 <free>
  return freep;
 9b8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9bc:	d971                	beqz	a0,990 <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9be:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9c0:	4798                	lw	a4,8(a5)
 9c2:	fa9776e3          	bgeu	a4,s1,96e <malloc+0x74>
    if(p == freep)
 9c6:	00093703          	ld	a4,0(s2)
 9ca:	853e                	mv	a0,a5
 9cc:	fef719e3          	bne	a4,a5,9be <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 9d0:	8552                	mv	a0,s4
 9d2:	00000097          	auipc	ra,0x0
 9d6:	b3c080e7          	jalr	-1220(ra) # 50e <sbrk>
  if(p == (char*)-1)
 9da:	fd5518e3          	bne	a0,s5,9aa <malloc+0xb0>
        return 0;
 9de:	4501                	li	a0,0
 9e0:	bf45                	j	990 <malloc+0x96>
