
xv6-user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4981                	li	s3,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  2e:	00001d97          	auipc	s11,0x1
  32:	9fbd8d93          	addi	s11,s11,-1541 # a29 <buf+0x1>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	970a0a13          	addi	s4,s4,-1680 # 9a8 <malloc+0xec>
        inword = 0;
  40:	4b01                	li	s6,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	224080e7          	jalr	548(ra) # 26a <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	89da                	mv	s3,s6
    for(i=0; i<n; i++){
  52:	0485                	addi	s1,s1,1
  54:	01248d63          	beq	s1,s2,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2b85                	addiw	s7,s7,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0997e3          	bnez	s3,52 <wc+0x52>
        w++;
  68:	2c05                	addiw	s8,s8,1
        inword = 1;
  6a:	4985                	li	s3,1
  6c:	b7dd                	j	52 <wc+0x52>
      c++;
  6e:	01ac8cbb          	addw	s9,s9,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	00001597          	auipc	a1,0x1
  7a:	9b258593          	addi	a1,a1,-1614 # a28 <buf>
  7e:	f8843503          	ld	a0,-120(s0)
  82:	00000097          	auipc	ra,0x0
  86:	3f6080e7          	jalr	1014(ra) # 478 <read>
  8a:	00a05f63          	blez	a0,a8 <wc+0xa8>
    for(i=0; i<n; i++){
  8e:	00001497          	auipc	s1,0x1
  92:	99a48493          	addi	s1,s1,-1638 # a28 <buf>
  96:	00050d1b          	sext.w	s10,a0
  9a:	fff5091b          	addiw	s2,a0,-1
  9e:	1902                	slli	s2,s2,0x20
  a0:	02095913          	srli	s2,s2,0x20
  a4:	996e                	add	s2,s2,s11
  a6:	bf4d                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  a8:	02054e63          	bltz	a0,e4 <wc+0xe4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d\t%d\t%d\t%s\n", l, w, c, name);
  ac:	f8043703          	ld	a4,-128(s0)
  b0:	86e6                	mv	a3,s9
  b2:	8662                	mv	a2,s8
  b4:	85de                	mv	a1,s7
  b6:	00001517          	auipc	a0,0x1
  ba:	90a50513          	addi	a0,a0,-1782 # 9c0 <malloc+0x104>
  be:	00000097          	auipc	ra,0x0
  c2:	740080e7          	jalr	1856(ra) # 7fe <printf>
}
  c6:	70e6                	ld	ra,120(sp)
  c8:	7446                	ld	s0,112(sp)
  ca:	74a6                	ld	s1,104(sp)
  cc:	7906                	ld	s2,96(sp)
  ce:	69e6                	ld	s3,88(sp)
  d0:	6a46                	ld	s4,80(sp)
  d2:	6aa6                	ld	s5,72(sp)
  d4:	6b06                	ld	s6,64(sp)
  d6:	7be2                	ld	s7,56(sp)
  d8:	7c42                	ld	s8,48(sp)
  da:	7ca2                	ld	s9,40(sp)
  dc:	7d02                	ld	s10,32(sp)
  de:	6de2                	ld	s11,24(sp)
  e0:	6109                	addi	sp,sp,128
  e2:	8082                	ret
    printf("wc: read error\n");
  e4:	00001517          	auipc	a0,0x1
  e8:	8cc50513          	addi	a0,a0,-1844 # 9b0 <malloc+0xf4>
  ec:	00000097          	auipc	ra,0x0
  f0:	712080e7          	jalr	1810(ra) # 7fe <printf>
    exit(1);
  f4:	4505                	li	a0,1
  f6:	00000097          	auipc	ra,0x0
  fa:	36a080e7          	jalr	874(ra) # 460 <exit>

00000000000000fe <main>:

int
main(int argc, char *argv[])
{
  fe:	7179                	addi	sp,sp,-48
 100:	f406                	sd	ra,40(sp)
 102:	f022                	sd	s0,32(sp)
 104:	ec26                	sd	s1,24(sp)
 106:	e84a                	sd	s2,16(sp)
 108:	e44e                	sd	s3,8(sp)
 10a:	e052                	sd	s4,0(sp)
 10c:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
 10e:	4785                	li	a5,1
 110:	06a7d063          	bge	a5,a0,170 <main+0x72>
 114:	89aa                	mv	s3,a0
 116:	8a2e                	mv	s4,a1
    wc(0, "");
    exit(0);
  }

  printf("LINE\tWORD\tBYTE\tFILE\n");
 118:	00001517          	auipc	a0,0x1
 11c:	8c050513          	addi	a0,a0,-1856 # 9d8 <malloc+0x11c>
 120:	00000097          	auipc	ra,0x0
 124:	6de080e7          	jalr	1758(ra) # 7fe <printf>
  for(i = 1; i < argc; i++){
 128:	008a0493          	addi	s1,s4,8
 12c:	39f9                	addiw	s3,s3,-2
 12e:	1982                	slli	s3,s3,0x20
 130:	0209d993          	srli	s3,s3,0x20
 134:	098e                	slli	s3,s3,0x3
 136:	0a41                	addi	s4,s4,16
 138:	99d2                	add	s3,s3,s4
    if((fd = open(argv[i], 0)) < 0){
 13a:	4581                	li	a1,0
 13c:	6088                	ld	a0,0(s1)
 13e:	00000097          	auipc	ra,0x0
 142:	362080e7          	jalr	866(ra) # 4a0 <open>
 146:	892a                	mv	s2,a0
 148:	04054263          	bltz	a0,18c <main+0x8e>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 14c:	608c                	ld	a1,0(s1)
 14e:	00000097          	auipc	ra,0x0
 152:	eb2080e7          	jalr	-334(ra) # 0 <wc>
    close(fd);
 156:	854a                	mv	a0,s2
 158:	00000097          	auipc	ra,0x0
 15c:	330080e7          	jalr	816(ra) # 488 <close>
  for(i = 1; i < argc; i++){
 160:	04a1                	addi	s1,s1,8
 162:	fd349ce3          	bne	s1,s3,13a <main+0x3c>
  }
  exit(0);
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	2f8080e7          	jalr	760(ra) # 460 <exit>
    wc(0, "");
 170:	00001597          	auipc	a1,0x1
 174:	86058593          	addi	a1,a1,-1952 # 9d0 <malloc+0x114>
 178:	4501                	li	a0,0
 17a:	00000097          	auipc	ra,0x0
 17e:	e86080e7          	jalr	-378(ra) # 0 <wc>
    exit(0);
 182:	4501                	li	a0,0
 184:	00000097          	auipc	ra,0x0
 188:	2dc080e7          	jalr	732(ra) # 460 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 18c:	608c                	ld	a1,0(s1)
 18e:	00001517          	auipc	a0,0x1
 192:	86250513          	addi	a0,a0,-1950 # 9f0 <malloc+0x134>
 196:	00000097          	auipc	ra,0x0
 19a:	668080e7          	jalr	1640(ra) # 7fe <printf>
      exit(1);
 19e:	4505                	li	a0,1
 1a0:	00000097          	auipc	ra,0x0
 1a4:	2c0080e7          	jalr	704(ra) # 460 <exit>

00000000000001a8 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
 1a8:	1141                	addi	sp,sp,-16
 1aa:	e422                	sd	s0,8(sp)
 1ac:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ae:	87aa                	mv	a5,a0
 1b0:	0585                	addi	a1,a1,1
 1b2:	0785                	addi	a5,a5,1
 1b4:	fff5c703          	lbu	a4,-1(a1)
 1b8:	fee78fa3          	sb	a4,-1(a5)
 1bc:	fb75                	bnez	a4,1b0 <strcpy+0x8>
    ;
  return os;
}
 1be:	6422                	ld	s0,8(sp)
 1c0:	0141                	addi	sp,sp,16
 1c2:	8082                	ret

00000000000001c4 <strcat>:

char*
strcat(char *s, const char *t)
{
 1c4:	1141                	addi	sp,sp,-16
 1c6:	e422                	sd	s0,8(sp)
 1c8:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	c385                	beqz	a5,1ee <strcat+0x2a>
 1d0:	87aa                	mv	a5,a0
    s++;
 1d2:	0785                	addi	a5,a5,1
  while(*s)
 1d4:	0007c703          	lbu	a4,0(a5)
 1d8:	ff6d                	bnez	a4,1d2 <strcat+0xe>
  while((*s++ = *t++))
 1da:	0585                	addi	a1,a1,1
 1dc:	0785                	addi	a5,a5,1
 1de:	fff5c703          	lbu	a4,-1(a1)
 1e2:	fee78fa3          	sb	a4,-1(a5)
 1e6:	fb75                	bnez	a4,1da <strcat+0x16>
    ;
  return os;
}
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret
  while(*s)
 1ee:	87aa                	mv	a5,a0
 1f0:	b7ed                	j	1da <strcat+0x16>

00000000000001f2 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 1f2:	1141                	addi	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1f8:	00054783          	lbu	a5,0(a0)
 1fc:	cb91                	beqz	a5,210 <strcmp+0x1e>
 1fe:	0005c703          	lbu	a4,0(a1)
 202:	00f71763          	bne	a4,a5,210 <strcmp+0x1e>
    p++, q++;
 206:	0505                	addi	a0,a0,1
 208:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 20a:	00054783          	lbu	a5,0(a0)
 20e:	fbe5                	bnez	a5,1fe <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 210:	0005c503          	lbu	a0,0(a1)
}
 214:	40a7853b          	subw	a0,a5,a0
 218:	6422                	ld	s0,8(sp)
 21a:	0141                	addi	sp,sp,16
 21c:	8082                	ret

000000000000021e <strlen>:

uint
strlen(const char *s)
{
 21e:	1141                	addi	sp,sp,-16
 220:	e422                	sd	s0,8(sp)
 222:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 224:	00054783          	lbu	a5,0(a0)
 228:	cf91                	beqz	a5,244 <strlen+0x26>
 22a:	0505                	addi	a0,a0,1
 22c:	87aa                	mv	a5,a0
 22e:	4685                	li	a3,1
 230:	9e89                	subw	a3,a3,a0
 232:	00f6853b          	addw	a0,a3,a5
 236:	0785                	addi	a5,a5,1
 238:	fff7c703          	lbu	a4,-1(a5)
 23c:	fb7d                	bnez	a4,232 <strlen+0x14>
    ;
  return n;
}
 23e:	6422                	ld	s0,8(sp)
 240:	0141                	addi	sp,sp,16
 242:	8082                	ret
  for(n = 0; s[n]; n++)
 244:	4501                	li	a0,0
 246:	bfe5                	j	23e <strlen+0x20>

0000000000000248 <memset>:

void*
memset(void *dst, int c, uint n)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 24e:	ca19                	beqz	a2,264 <memset+0x1c>
 250:	87aa                	mv	a5,a0
 252:	1602                	slli	a2,a2,0x20
 254:	9201                	srli	a2,a2,0x20
 256:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 25a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 25e:	0785                	addi	a5,a5,1
 260:	fee79de3          	bne	a5,a4,25a <memset+0x12>
  }
  return dst;
}
 264:	6422                	ld	s0,8(sp)
 266:	0141                	addi	sp,sp,16
 268:	8082                	ret

000000000000026a <strchr>:

char*
strchr(const char *s, char c)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e422                	sd	s0,8(sp)
 26e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 270:	00054783          	lbu	a5,0(a0)
 274:	cb99                	beqz	a5,28a <strchr+0x20>
    if(*s == c)
 276:	00f58763          	beq	a1,a5,284 <strchr+0x1a>
  for(; *s; s++)
 27a:	0505                	addi	a0,a0,1
 27c:	00054783          	lbu	a5,0(a0)
 280:	fbfd                	bnez	a5,276 <strchr+0xc>
      return (char*)s;
  return 0;
 282:	4501                	li	a0,0
}
 284:	6422                	ld	s0,8(sp)
 286:	0141                	addi	sp,sp,16
 288:	8082                	ret
  return 0;
 28a:	4501                	li	a0,0
 28c:	bfe5                	j	284 <strchr+0x1a>

000000000000028e <gets>:

char*
gets(char *buf, int max)
{
 28e:	711d                	addi	sp,sp,-96
 290:	ec86                	sd	ra,88(sp)
 292:	e8a2                	sd	s0,80(sp)
 294:	e4a6                	sd	s1,72(sp)
 296:	e0ca                	sd	s2,64(sp)
 298:	fc4e                	sd	s3,56(sp)
 29a:	f852                	sd	s4,48(sp)
 29c:	f456                	sd	s5,40(sp)
 29e:	f05a                	sd	s6,32(sp)
 2a0:	ec5e                	sd	s7,24(sp)
 2a2:	e862                	sd	s8,16(sp)
 2a4:	1080                	addi	s0,sp,96
 2a6:	8baa                	mv	s7,a0
 2a8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2aa:	892a                	mv	s2,a0
 2ac:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2ae:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2b2:	4b29                	li	s6,10
 2b4:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 2b6:	89a6                	mv	s3,s1
 2b8:	2485                	addiw	s1,s1,1
 2ba:	0344d763          	bge	s1,s4,2e8 <gets+0x5a>
    cc = read(0, &c, 1);
 2be:	4605                	li	a2,1
 2c0:	85d6                	mv	a1,s5
 2c2:	4501                	li	a0,0
 2c4:	00000097          	auipc	ra,0x0
 2c8:	1b4080e7          	jalr	436(ra) # 478 <read>
    if(cc < 1)
 2cc:	00a05e63          	blez	a0,2e8 <gets+0x5a>
    buf[i++] = c;
 2d0:	faf44783          	lbu	a5,-81(s0)
 2d4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2d8:	01678763          	beq	a5,s6,2e6 <gets+0x58>
 2dc:	0905                	addi	s2,s2,1
 2de:	fd879ce3          	bne	a5,s8,2b6 <gets+0x28>
  for(i=0; i+1 < max; ){
 2e2:	89a6                	mv	s3,s1
 2e4:	a011                	j	2e8 <gets+0x5a>
 2e6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2e8:	99de                	add	s3,s3,s7
 2ea:	00098023          	sb	zero,0(s3)
  return buf;
}
 2ee:	855e                	mv	a0,s7
 2f0:	60e6                	ld	ra,88(sp)
 2f2:	6446                	ld	s0,80(sp)
 2f4:	64a6                	ld	s1,72(sp)
 2f6:	6906                	ld	s2,64(sp)
 2f8:	79e2                	ld	s3,56(sp)
 2fa:	7a42                	ld	s4,48(sp)
 2fc:	7aa2                	ld	s5,40(sp)
 2fe:	7b02                	ld	s6,32(sp)
 300:	6be2                	ld	s7,24(sp)
 302:	6c42                	ld	s8,16(sp)
 304:	6125                	addi	sp,sp,96
 306:	8082                	ret

0000000000000308 <stat>:

int
stat(const char *n, struct stat *st)
{
 308:	1101                	addi	sp,sp,-32
 30a:	ec06                	sd	ra,24(sp)
 30c:	e822                	sd	s0,16(sp)
 30e:	e426                	sd	s1,8(sp)
 310:	e04a                	sd	s2,0(sp)
 312:	1000                	addi	s0,sp,32
 314:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 316:	4581                	li	a1,0
 318:	00000097          	auipc	ra,0x0
 31c:	188080e7          	jalr	392(ra) # 4a0 <open>
  if(fd < 0)
 320:	02054563          	bltz	a0,34a <stat+0x42>
 324:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 326:	85ca                	mv	a1,s2
 328:	00000097          	auipc	ra,0x0
 32c:	180080e7          	jalr	384(ra) # 4a8 <fstat>
 330:	892a                	mv	s2,a0
  close(fd);
 332:	8526                	mv	a0,s1
 334:	00000097          	auipc	ra,0x0
 338:	154080e7          	jalr	340(ra) # 488 <close>
  return r;
}
 33c:	854a                	mv	a0,s2
 33e:	60e2                	ld	ra,24(sp)
 340:	6442                	ld	s0,16(sp)
 342:	64a2                	ld	s1,8(sp)
 344:	6902                	ld	s2,0(sp)
 346:	6105                	addi	sp,sp,32
 348:	8082                	ret
    return -1;
 34a:	597d                	li	s2,-1
 34c:	bfc5                	j	33c <stat+0x34>

000000000000034e <atoi>:

int
atoi(const char *s)
{
 34e:	1141                	addi	sp,sp,-16
 350:	e422                	sd	s0,8(sp)
 352:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 354:	00054703          	lbu	a4,0(a0)
 358:	02d00793          	li	a5,45
  int neg = 1;
 35c:	4805                	li	a6,1
  if (*s == '-') {
 35e:	04f70363          	beq	a4,a5,3a4 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 362:	00054683          	lbu	a3,0(a0)
 366:	fd06879b          	addiw	a5,a3,-48
 36a:	0ff7f793          	andi	a5,a5,255
 36e:	4725                	li	a4,9
 370:	02f76d63          	bltu	a4,a5,3aa <atoi+0x5c>
  n = 0;
 374:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 376:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 378:	0505                	addi	a0,a0,1
 37a:	0026179b          	slliw	a5,a2,0x2
 37e:	9fb1                	addw	a5,a5,a2
 380:	0017979b          	slliw	a5,a5,0x1
 384:	9fb5                	addw	a5,a5,a3
 386:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 38a:	00054683          	lbu	a3,0(a0)
 38e:	fd06871b          	addiw	a4,a3,-48
 392:	0ff77713          	andi	a4,a4,255
 396:	fee5f1e3          	bgeu	a1,a4,378 <atoi+0x2a>
  return n * neg;
}
 39a:	02c8053b          	mulw	a0,a6,a2
 39e:	6422                	ld	s0,8(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret
    s++;
 3a4:	0505                	addi	a0,a0,1
    neg = -1;
 3a6:	587d                	li	a6,-1
 3a8:	bf6d                	j	362 <atoi+0x14>
  n = 0;
 3aa:	4601                	li	a2,0
 3ac:	b7fd                	j	39a <atoi+0x4c>

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
 3b4:	02b57463          	bgeu	a0,a1,3dc <memmove+0x2e>
    while(n-- > 0)
 3b8:	00c05f63          	blez	a2,3d6 <memmove+0x28>
 3bc:	1602                	slli	a2,a2,0x20
 3be:	9201                	srli	a2,a2,0x20
 3c0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3c4:	872a                	mv	a4,a0
      *dst++ = *src++;
 3c6:	0585                	addi	a1,a1,1
 3c8:	0705                	addi	a4,a4,1
 3ca:	fff5c683          	lbu	a3,-1(a1)
 3ce:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3d2:	fee79ae3          	bne	a5,a4,3c6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3d6:	6422                	ld	s0,8(sp)
 3d8:	0141                	addi	sp,sp,16
 3da:	8082                	ret
    dst += n;
 3dc:	00c50733          	add	a4,a0,a2
    src += n;
 3e0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3e2:	fec05ae3          	blez	a2,3d6 <memmove+0x28>
 3e6:	fff6079b          	addiw	a5,a2,-1
 3ea:	1782                	slli	a5,a5,0x20
 3ec:	9381                	srli	a5,a5,0x20
 3ee:	fff7c793          	not	a5,a5
 3f2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3f4:	15fd                	addi	a1,a1,-1
 3f6:	177d                	addi	a4,a4,-1
 3f8:	0005c683          	lbu	a3,0(a1)
 3fc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 400:	fee79ae3          	bne	a5,a4,3f4 <memmove+0x46>
 404:	bfc9                	j	3d6 <memmove+0x28>

0000000000000406 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 406:	1141                	addi	sp,sp,-16
 408:	e422                	sd	s0,8(sp)
 40a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 40c:	ca05                	beqz	a2,43c <memcmp+0x36>
 40e:	fff6069b          	addiw	a3,a2,-1
 412:	1682                	slli	a3,a3,0x20
 414:	9281                	srli	a3,a3,0x20
 416:	0685                	addi	a3,a3,1
 418:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 41a:	00054783          	lbu	a5,0(a0)
 41e:	0005c703          	lbu	a4,0(a1)
 422:	00e79863          	bne	a5,a4,432 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 426:	0505                	addi	a0,a0,1
    p2++;
 428:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 42a:	fed518e3          	bne	a0,a3,41a <memcmp+0x14>
  }
  return 0;
 42e:	4501                	li	a0,0
 430:	a019                	j	436 <memcmp+0x30>
      return *p1 - *p2;
 432:	40e7853b          	subw	a0,a5,a4
}
 436:	6422                	ld	s0,8(sp)
 438:	0141                	addi	sp,sp,16
 43a:	8082                	ret
  return 0;
 43c:	4501                	li	a0,0
 43e:	bfe5                	j	436 <memcmp+0x30>

0000000000000440 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 440:	1141                	addi	sp,sp,-16
 442:	e406                	sd	ra,8(sp)
 444:	e022                	sd	s0,0(sp)
 446:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 448:	00000097          	auipc	ra,0x0
 44c:	f66080e7          	jalr	-154(ra) # 3ae <memmove>
}
 450:	60a2                	ld	ra,8(sp)
 452:	6402                	ld	s0,0(sp)
 454:	0141                	addi	sp,sp,16
 456:	8082                	ret

0000000000000458 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 458:	4885                	li	a7,1
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <exit>:
.global exit
exit:
 li a7, SYS_exit
 460:	4889                	li	a7,2
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <wait>:
.global wait
wait:
 li a7, SYS_wait
 468:	488d                	li	a7,3
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 470:	4891                	li	a7,4
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <read>:
.global read
read:
 li a7, SYS_read
 478:	4895                	li	a7,5
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <write>:
.global write
write:
 li a7, SYS_write
 480:	48c1                	li	a7,16
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <close>:
.global close
close:
 li a7, SYS_close
 488:	48d5                	li	a7,21
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <kill>:
.global kill
kill:
 li a7, SYS_kill
 490:	4899                	li	a7,6
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <exec>:
.global exec
exec:
 li a7, SYS_exec
 498:	489d                	li	a7,7
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <open>:
.global open
open:
 li a7, SYS_open
 4a0:	48bd                	li	a7,15
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4a8:	48a1                	li	a7,8
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4b0:	48d1                	li	a7,20
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b8:	48a5                	li	a7,9
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4c0:	48a9                	li	a7,10
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c8:	48ad                	li	a7,11
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4d0:	48b1                	li	a7,12
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4d8:	48b5                	li	a7,13
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4e0:	48b9                	li	a7,14
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 4e8:	48d9                	li	a7,22
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <dev>:
.global dev
dev:
 li a7, SYS_dev
 4f0:	48dd                	li	a7,23
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 4f8:	48e1                	li	a7,24
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 500:	48e5                	li	a7,25
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <remove>:
.global remove
remove:
 li a7, SYS_remove
 508:	48c5                	li	a7,17
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <trace>:
.global trace
trace:
 li a7, SYS_trace
 510:	48c9                	li	a7,18
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 518:	48cd                	li	a7,19
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <rename>:
.global rename
rename:
 li a7, SYS_rename
 520:	48e9                	li	a7,26
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 528:	1101                	addi	sp,sp,-32
 52a:	ec06                	sd	ra,24(sp)
 52c:	e822                	sd	s0,16(sp)
 52e:	1000                	addi	s0,sp,32
 530:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 534:	4605                	li	a2,1
 536:	fef40593          	addi	a1,s0,-17
 53a:	00000097          	auipc	ra,0x0
 53e:	f46080e7          	jalr	-186(ra) # 480 <write>
}
 542:	60e2                	ld	ra,24(sp)
 544:	6442                	ld	s0,16(sp)
 546:	6105                	addi	sp,sp,32
 548:	8082                	ret

000000000000054a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 54a:	7139                	addi	sp,sp,-64
 54c:	fc06                	sd	ra,56(sp)
 54e:	f822                	sd	s0,48(sp)
 550:	f426                	sd	s1,40(sp)
 552:	f04a                	sd	s2,32(sp)
 554:	ec4e                	sd	s3,24(sp)
 556:	0080                	addi	s0,sp,64
 558:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 55a:	c299                	beqz	a3,560 <printint+0x16>
 55c:	0805c763          	bltz	a1,5ea <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 560:	2581                	sext.w	a1,a1
  neg = 0;
 562:	4881                	li	a7,0
  }

  i = 0;
 564:	fc040993          	addi	s3,s0,-64
  neg = 0;
 568:	86ce                	mv	a3,s3
  i = 0;
 56a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 56c:	2601                	sext.w	a2,a2
 56e:	00000517          	auipc	a0,0x0
 572:	4a250513          	addi	a0,a0,1186 # a10 <digits>
 576:	883a                	mv	a6,a4
 578:	2705                	addiw	a4,a4,1
 57a:	02c5f7bb          	remuw	a5,a1,a2
 57e:	1782                	slli	a5,a5,0x20
 580:	9381                	srli	a5,a5,0x20
 582:	97aa                	add	a5,a5,a0
 584:	0007c783          	lbu	a5,0(a5)
 588:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 58c:	0005879b          	sext.w	a5,a1
 590:	02c5d5bb          	divuw	a1,a1,a2
 594:	0685                	addi	a3,a3,1
 596:	fec7f0e3          	bgeu	a5,a2,576 <printint+0x2c>
  if(neg)
 59a:	00088b63          	beqz	a7,5b0 <printint+0x66>
    buf[i++] = '-';
 59e:	fd040793          	addi	a5,s0,-48
 5a2:	973e                	add	a4,a4,a5
 5a4:	02d00793          	li	a5,45
 5a8:	fef70823          	sb	a5,-16(a4)
 5ac:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5b0:	02e05663          	blez	a4,5dc <printint+0x92>
 5b4:	fc040913          	addi	s2,s0,-64
 5b8:	993a                	add	s2,s2,a4
 5ba:	19fd                	addi	s3,s3,-1
 5bc:	99ba                	add	s3,s3,a4
 5be:	377d                	addiw	a4,a4,-1
 5c0:	1702                	slli	a4,a4,0x20
 5c2:	9301                	srli	a4,a4,0x20
 5c4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5c8:	fff94583          	lbu	a1,-1(s2)
 5cc:	8526                	mv	a0,s1
 5ce:	00000097          	auipc	ra,0x0
 5d2:	f5a080e7          	jalr	-166(ra) # 528 <putc>
  while(--i >= 0)
 5d6:	197d                	addi	s2,s2,-1
 5d8:	ff3918e3          	bne	s2,s3,5c8 <printint+0x7e>
}
 5dc:	70e2                	ld	ra,56(sp)
 5de:	7442                	ld	s0,48(sp)
 5e0:	74a2                	ld	s1,40(sp)
 5e2:	7902                	ld	s2,32(sp)
 5e4:	69e2                	ld	s3,24(sp)
 5e6:	6121                	addi	sp,sp,64
 5e8:	8082                	ret
    x = -xx;
 5ea:	40b005bb          	negw	a1,a1
    neg = 1;
 5ee:	4885                	li	a7,1
    x = -xx;
 5f0:	bf95                	j	564 <printint+0x1a>

00000000000005f2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5f2:	7119                	addi	sp,sp,-128
 5f4:	fc86                	sd	ra,120(sp)
 5f6:	f8a2                	sd	s0,112(sp)
 5f8:	f4a6                	sd	s1,104(sp)
 5fa:	f0ca                	sd	s2,96(sp)
 5fc:	ecce                	sd	s3,88(sp)
 5fe:	e8d2                	sd	s4,80(sp)
 600:	e4d6                	sd	s5,72(sp)
 602:	e0da                	sd	s6,64(sp)
 604:	fc5e                	sd	s7,56(sp)
 606:	f862                	sd	s8,48(sp)
 608:	f466                	sd	s9,40(sp)
 60a:	f06a                	sd	s10,32(sp)
 60c:	ec6e                	sd	s11,24(sp)
 60e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 610:	0005c903          	lbu	s2,0(a1)
 614:	18090f63          	beqz	s2,7b2 <vprintf+0x1c0>
 618:	8aaa                	mv	s5,a0
 61a:	8b32                	mv	s6,a2
 61c:	00158493          	addi	s1,a1,1
  state = 0;
 620:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 622:	02500a13          	li	s4,37
      if(c == 'd'){
 626:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 62a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 62e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 632:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 636:	00000b97          	auipc	s7,0x0
 63a:	3dab8b93          	addi	s7,s7,986 # a10 <digits>
 63e:	a839                	j	65c <vprintf+0x6a>
        putc(fd, c);
 640:	85ca                	mv	a1,s2
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	ee4080e7          	jalr	-284(ra) # 528 <putc>
 64c:	a019                	j	652 <vprintf+0x60>
    } else if(state == '%'){
 64e:	01498f63          	beq	s3,s4,66c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 652:	0485                	addi	s1,s1,1
 654:	fff4c903          	lbu	s2,-1(s1)
 658:	14090d63          	beqz	s2,7b2 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 65c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 660:	fe0997e3          	bnez	s3,64e <vprintf+0x5c>
      if(c == '%'){
 664:	fd479ee3          	bne	a5,s4,640 <vprintf+0x4e>
        state = '%';
 668:	89be                	mv	s3,a5
 66a:	b7e5                	j	652 <vprintf+0x60>
      if(c == 'd'){
 66c:	05878063          	beq	a5,s8,6ac <vprintf+0xba>
      } else if(c == 'l') {
 670:	05978c63          	beq	a5,s9,6c8 <vprintf+0xd6>
      } else if(c == 'x') {
 674:	07a78863          	beq	a5,s10,6e4 <vprintf+0xf2>
      } else if(c == 'p') {
 678:	09b78463          	beq	a5,s11,700 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 67c:	07300713          	li	a4,115
 680:	0ce78663          	beq	a5,a4,74c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 684:	06300713          	li	a4,99
 688:	0ee78e63          	beq	a5,a4,784 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 68c:	11478863          	beq	a5,s4,79c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 690:	85d2                	mv	a1,s4
 692:	8556                	mv	a0,s5
 694:	00000097          	auipc	ra,0x0
 698:	e94080e7          	jalr	-364(ra) # 528 <putc>
        putc(fd, c);
 69c:	85ca                	mv	a1,s2
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	e88080e7          	jalr	-376(ra) # 528 <putc>
      }
      state = 0;
 6a8:	4981                	li	s3,0
 6aa:	b765                	j	652 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6ac:	008b0913          	addi	s2,s6,8
 6b0:	4685                	li	a3,1
 6b2:	4629                	li	a2,10
 6b4:	000b2583          	lw	a1,0(s6)
 6b8:	8556                	mv	a0,s5
 6ba:	00000097          	auipc	ra,0x0
 6be:	e90080e7          	jalr	-368(ra) # 54a <printint>
 6c2:	8b4a                	mv	s6,s2
      state = 0;
 6c4:	4981                	li	s3,0
 6c6:	b771                	j	652 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c8:	008b0913          	addi	s2,s6,8
 6cc:	4681                	li	a3,0
 6ce:	4629                	li	a2,10
 6d0:	000b2583          	lw	a1,0(s6)
 6d4:	8556                	mv	a0,s5
 6d6:	00000097          	auipc	ra,0x0
 6da:	e74080e7          	jalr	-396(ra) # 54a <printint>
 6de:	8b4a                	mv	s6,s2
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	bf85                	j	652 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6e4:	008b0913          	addi	s2,s6,8
 6e8:	4681                	li	a3,0
 6ea:	4641                	li	a2,16
 6ec:	000b2583          	lw	a1,0(s6)
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	e58080e7          	jalr	-424(ra) # 54a <printint>
 6fa:	8b4a                	mv	s6,s2
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	bf91                	j	652 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 700:	008b0793          	addi	a5,s6,8
 704:	f8f43423          	sd	a5,-120(s0)
 708:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 70c:	03000593          	li	a1,48
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	e16080e7          	jalr	-490(ra) # 528 <putc>
  putc(fd, 'x');
 71a:	85ea                	mv	a1,s10
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	e0a080e7          	jalr	-502(ra) # 528 <putc>
 726:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 728:	03c9d793          	srli	a5,s3,0x3c
 72c:	97de                	add	a5,a5,s7
 72e:	0007c583          	lbu	a1,0(a5)
 732:	8556                	mv	a0,s5
 734:	00000097          	auipc	ra,0x0
 738:	df4080e7          	jalr	-524(ra) # 528 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 73c:	0992                	slli	s3,s3,0x4
 73e:	397d                	addiw	s2,s2,-1
 740:	fe0914e3          	bnez	s2,728 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 744:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 748:	4981                	li	s3,0
 74a:	b721                	j	652 <vprintf+0x60>
        s = va_arg(ap, char*);
 74c:	008b0993          	addi	s3,s6,8
 750:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 754:	02090163          	beqz	s2,776 <vprintf+0x184>
        while(*s != 0){
 758:	00094583          	lbu	a1,0(s2)
 75c:	c9a1                	beqz	a1,7ac <vprintf+0x1ba>
          putc(fd, *s);
 75e:	8556                	mv	a0,s5
 760:	00000097          	auipc	ra,0x0
 764:	dc8080e7          	jalr	-568(ra) # 528 <putc>
          s++;
 768:	0905                	addi	s2,s2,1
        while(*s != 0){
 76a:	00094583          	lbu	a1,0(s2)
 76e:	f9e5                	bnez	a1,75e <vprintf+0x16c>
        s = va_arg(ap, char*);
 770:	8b4e                	mv	s6,s3
      state = 0;
 772:	4981                	li	s3,0
 774:	bdf9                	j	652 <vprintf+0x60>
          s = "(null)";
 776:	00000917          	auipc	s2,0x0
 77a:	29290913          	addi	s2,s2,658 # a08 <malloc+0x14c>
        while(*s != 0){
 77e:	02800593          	li	a1,40
 782:	bff1                	j	75e <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 784:	008b0913          	addi	s2,s6,8
 788:	000b4583          	lbu	a1,0(s6)
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	d9a080e7          	jalr	-614(ra) # 528 <putc>
 796:	8b4a                	mv	s6,s2
      state = 0;
 798:	4981                	li	s3,0
 79a:	bd65                	j	652 <vprintf+0x60>
        putc(fd, c);
 79c:	85d2                	mv	a1,s4
 79e:	8556                	mv	a0,s5
 7a0:	00000097          	auipc	ra,0x0
 7a4:	d88080e7          	jalr	-632(ra) # 528 <putc>
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	b565                	j	652 <vprintf+0x60>
        s = va_arg(ap, char*);
 7ac:	8b4e                	mv	s6,s3
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	b54d                	j	652 <vprintf+0x60>
    }
  }
}
 7b2:	70e6                	ld	ra,120(sp)
 7b4:	7446                	ld	s0,112(sp)
 7b6:	74a6                	ld	s1,104(sp)
 7b8:	7906                	ld	s2,96(sp)
 7ba:	69e6                	ld	s3,88(sp)
 7bc:	6a46                	ld	s4,80(sp)
 7be:	6aa6                	ld	s5,72(sp)
 7c0:	6b06                	ld	s6,64(sp)
 7c2:	7be2                	ld	s7,56(sp)
 7c4:	7c42                	ld	s8,48(sp)
 7c6:	7ca2                	ld	s9,40(sp)
 7c8:	7d02                	ld	s10,32(sp)
 7ca:	6de2                	ld	s11,24(sp)
 7cc:	6109                	addi	sp,sp,128
 7ce:	8082                	ret

00000000000007d0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7d0:	715d                	addi	sp,sp,-80
 7d2:	ec06                	sd	ra,24(sp)
 7d4:	e822                	sd	s0,16(sp)
 7d6:	1000                	addi	s0,sp,32
 7d8:	e010                	sd	a2,0(s0)
 7da:	e414                	sd	a3,8(s0)
 7dc:	e818                	sd	a4,16(s0)
 7de:	ec1c                	sd	a5,24(s0)
 7e0:	03043023          	sd	a6,32(s0)
 7e4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7e8:	8622                	mv	a2,s0
 7ea:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7ee:	00000097          	auipc	ra,0x0
 7f2:	e04080e7          	jalr	-508(ra) # 5f2 <vprintf>
}
 7f6:	60e2                	ld	ra,24(sp)
 7f8:	6442                	ld	s0,16(sp)
 7fa:	6161                	addi	sp,sp,80
 7fc:	8082                	ret

00000000000007fe <printf>:

void
printf(const char *fmt, ...)
{
 7fe:	711d                	addi	sp,sp,-96
 800:	ec06                	sd	ra,24(sp)
 802:	e822                	sd	s0,16(sp)
 804:	1000                	addi	s0,sp,32
 806:	e40c                	sd	a1,8(s0)
 808:	e810                	sd	a2,16(s0)
 80a:	ec14                	sd	a3,24(s0)
 80c:	f018                	sd	a4,32(s0)
 80e:	f41c                	sd	a5,40(s0)
 810:	03043823          	sd	a6,48(s0)
 814:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 818:	00840613          	addi	a2,s0,8
 81c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 820:	85aa                	mv	a1,a0
 822:	4505                	li	a0,1
 824:	00000097          	auipc	ra,0x0
 828:	dce080e7          	jalr	-562(ra) # 5f2 <vprintf>
}
 82c:	60e2                	ld	ra,24(sp)
 82e:	6442                	ld	s0,16(sp)
 830:	6125                	addi	sp,sp,96
 832:	8082                	ret

0000000000000834 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 834:	1141                	addi	sp,sp,-16
 836:	e422                	sd	s0,8(sp)
 838:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 83a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83e:	00000797          	auipc	a5,0x0
 842:	3ea7b783          	ld	a5,1002(a5) # c28 <freep>
 846:	a805                	j	876 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 848:	4618                	lw	a4,8(a2)
 84a:	9db9                	addw	a1,a1,a4
 84c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 850:	6398                	ld	a4,0(a5)
 852:	6318                	ld	a4,0(a4)
 854:	fee53823          	sd	a4,-16(a0)
 858:	a091                	j	89c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 85a:	ff852703          	lw	a4,-8(a0)
 85e:	9e39                	addw	a2,a2,a4
 860:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 862:	ff053703          	ld	a4,-16(a0)
 866:	e398                	sd	a4,0(a5)
 868:	a099                	j	8ae <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86a:	6398                	ld	a4,0(a5)
 86c:	00e7e463          	bltu	a5,a4,874 <free+0x40>
 870:	00e6ea63          	bltu	a3,a4,884 <free+0x50>
{
 874:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 876:	fed7fae3          	bgeu	a5,a3,86a <free+0x36>
 87a:	6398                	ld	a4,0(a5)
 87c:	00e6e463          	bltu	a3,a4,884 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 880:	fee7eae3          	bltu	a5,a4,874 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 884:	ff852583          	lw	a1,-8(a0)
 888:	6390                	ld	a2,0(a5)
 88a:	02059713          	slli	a4,a1,0x20
 88e:	9301                	srli	a4,a4,0x20
 890:	0712                	slli	a4,a4,0x4
 892:	9736                	add	a4,a4,a3
 894:	fae60ae3          	beq	a2,a4,848 <free+0x14>
    bp->s.ptr = p->s.ptr;
 898:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 89c:	4790                	lw	a2,8(a5)
 89e:	02061713          	slli	a4,a2,0x20
 8a2:	9301                	srli	a4,a4,0x20
 8a4:	0712                	slli	a4,a4,0x4
 8a6:	973e                	add	a4,a4,a5
 8a8:	fae689e3          	beq	a3,a4,85a <free+0x26>
  } else
    p->s.ptr = bp;
 8ac:	e394                	sd	a3,0(a5)
  freep = p;
 8ae:	00000717          	auipc	a4,0x0
 8b2:	36f73d23          	sd	a5,890(a4) # c28 <freep>
}
 8b6:	6422                	ld	s0,8(sp)
 8b8:	0141                	addi	sp,sp,16
 8ba:	8082                	ret

00000000000008bc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8bc:	7139                	addi	sp,sp,-64
 8be:	fc06                	sd	ra,56(sp)
 8c0:	f822                	sd	s0,48(sp)
 8c2:	f426                	sd	s1,40(sp)
 8c4:	f04a                	sd	s2,32(sp)
 8c6:	ec4e                	sd	s3,24(sp)
 8c8:	e852                	sd	s4,16(sp)
 8ca:	e456                	sd	s5,8(sp)
 8cc:	e05a                	sd	s6,0(sp)
 8ce:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d0:	02051493          	slli	s1,a0,0x20
 8d4:	9081                	srli	s1,s1,0x20
 8d6:	04bd                	addi	s1,s1,15
 8d8:	8091                	srli	s1,s1,0x4
 8da:	0014899b          	addiw	s3,s1,1
 8de:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8e0:	00000517          	auipc	a0,0x0
 8e4:	34853503          	ld	a0,840(a0) # c28 <freep>
 8e8:	c515                	beqz	a0,914 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ea:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ec:	4798                	lw	a4,8(a5)
 8ee:	04977163          	bgeu	a4,s1,930 <malloc+0x74>
 8f2:	8a4e                	mv	s4,s3
 8f4:	0009871b          	sext.w	a4,s3
 8f8:	6685                	lui	a3,0x1
 8fa:	00d77363          	bgeu	a4,a3,900 <malloc+0x44>
 8fe:	6a05                	lui	s4,0x1
 900:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 904:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 908:	00000917          	auipc	s2,0x0
 90c:	32090913          	addi	s2,s2,800 # c28 <freep>
  if(p == (char*)-1)
 910:	5afd                	li	s5,-1
 912:	a89d                	j	988 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 914:	00000797          	auipc	a5,0x0
 918:	31478793          	addi	a5,a5,788 # c28 <freep>
 91c:	00000717          	auipc	a4,0x0
 920:	31470713          	addi	a4,a4,788 # c30 <base>
 924:	e398                	sd	a4,0(a5)
 926:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 928:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92c:	87ba                	mv	a5,a4
 92e:	b7d1                	j	8f2 <malloc+0x36>
      if(p->s.size == nunits)
 930:	02e48b63          	beq	s1,a4,966 <malloc+0xaa>
        p->s.size -= nunits;
 934:	4137073b          	subw	a4,a4,s3
 938:	c798                	sw	a4,8(a5)
        p += p->s.size;
 93a:	1702                	slli	a4,a4,0x20
 93c:	9301                	srli	a4,a4,0x20
 93e:	0712                	slli	a4,a4,0x4
 940:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 942:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 946:	00000717          	auipc	a4,0x0
 94a:	2ea73123          	sd	a0,738(a4) # c28 <freep>
      return (void*)(p + 1);
 94e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 952:	70e2                	ld	ra,56(sp)
 954:	7442                	ld	s0,48(sp)
 956:	74a2                	ld	s1,40(sp)
 958:	7902                	ld	s2,32(sp)
 95a:	69e2                	ld	s3,24(sp)
 95c:	6a42                	ld	s4,16(sp)
 95e:	6aa2                	ld	s5,8(sp)
 960:	6b02                	ld	s6,0(sp)
 962:	6121                	addi	sp,sp,64
 964:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 966:	6398                	ld	a4,0(a5)
 968:	e118                	sd	a4,0(a0)
 96a:	bff1                	j	946 <malloc+0x8a>
  hp->s.size = nu;
 96c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 970:	0541                	addi	a0,a0,16
 972:	00000097          	auipc	ra,0x0
 976:	ec2080e7          	jalr	-318(ra) # 834 <free>
  return freep;
 97a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 97e:	d971                	beqz	a0,952 <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 980:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 982:	4798                	lw	a4,8(a5)
 984:	fa9776e3          	bgeu	a4,s1,930 <malloc+0x74>
    if(p == freep)
 988:	00093703          	ld	a4,0(s2)
 98c:	853e                	mv	a0,a5
 98e:	fef719e3          	bne	a4,a5,980 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 992:	8552                	mv	a0,s4
 994:	00000097          	auipc	ra,0x0
 998:	b3c080e7          	jalr	-1220(ra) # 4d0 <sbrk>
  if(p == (char*)-1)
 99c:	fd5518e3          	bne	a0,s5,96c <malloc+0xb0>
        return 0;
 9a0:	4501                	li	a0,0
 9a2:	bf45                	j	952 <malloc+0x96>
