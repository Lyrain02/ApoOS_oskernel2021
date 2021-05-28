
xv6-user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	711d                	addi	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	e862                	sd	s8,16(sp)
 130:	e466                	sd	s9,8(sp)
 132:	1080                	addi	s0,sp,96
 134:	89aa                	mv	s3,a0
 136:	8bae                	mv	s7,a1
  m = 0;
 138:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 13a:	3ff00b13          	li	s6,1023
 13e:	00001a97          	auipc	s5,0x1
 142:	9e2a8a93          	addi	s5,s5,-1566 # b20 <buf>
    p = buf;
 146:	8cd6                	mv	s9,s5
 148:	8c56                	mv	s8,s5
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 14a:	a0a1                	j	192 <grep+0x78>
        *q = '\n';
 14c:	47a9                	li	a5,10
 14e:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 152:	00148613          	addi	a2,s1,1
 156:	4126063b          	subw	a2,a2,s2
 15a:	85ca                	mv	a1,s2
 15c:	4505                	li	a0,1
 15e:	00000097          	auipc	ra,0x0
 162:	43c080e7          	jalr	1084(ra) # 59a <write>
      p = q+1;
 166:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 16a:	45a9                	li	a1,10
 16c:	854a                	mv	a0,s2
 16e:	00000097          	auipc	ra,0x0
 172:	206080e7          	jalr	518(ra) # 374 <strchr>
 176:	84aa                	mv	s1,a0
 178:	c919                	beqz	a0,18e <grep+0x74>
      *q = 0;
 17a:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 17e:	85ca                	mv	a1,s2
 180:	854e                	mv	a0,s3
 182:	00000097          	auipc	ra,0x0
 186:	f4a080e7          	jalr	-182(ra) # cc <match>
 18a:	dd71                	beqz	a0,166 <grep+0x4c>
 18c:	b7c1                	j	14c <grep+0x32>
    if(m > 0){
 18e:	03404563          	bgtz	s4,1b8 <grep+0x9e>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 192:	414b063b          	subw	a2,s6,s4
 196:	014a85b3          	add	a1,s5,s4
 19a:	855e                	mv	a0,s7
 19c:	00000097          	auipc	ra,0x0
 1a0:	3f6080e7          	jalr	1014(ra) # 592 <read>
 1a4:	02a05663          	blez	a0,1d0 <grep+0xb6>
    m += n;
 1a8:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1ac:	014a87b3          	add	a5,s5,s4
 1b0:	00078023          	sb	zero,0(a5)
    p = buf;
 1b4:	8962                	mv	s2,s8
    while((q = strchr(p, '\n')) != 0){
 1b6:	bf55                	j	16a <grep+0x50>
      m -= p - buf;
 1b8:	415907b3          	sub	a5,s2,s5
 1bc:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1c0:	8652                	mv	a2,s4
 1c2:	85ca                	mv	a1,s2
 1c4:	8566                	mv	a0,s9
 1c6:	00000097          	auipc	ra,0x0
 1ca:	2f2080e7          	jalr	754(ra) # 4b8 <memmove>
 1ce:	b7d1                	j	192 <grep+0x78>
}
 1d0:	60e6                	ld	ra,88(sp)
 1d2:	6446                	ld	s0,80(sp)
 1d4:	64a6                	ld	s1,72(sp)
 1d6:	6906                	ld	s2,64(sp)
 1d8:	79e2                	ld	s3,56(sp)
 1da:	7a42                	ld	s4,48(sp)
 1dc:	7aa2                	ld	s5,40(sp)
 1de:	7b02                	ld	s6,32(sp)
 1e0:	6be2                	ld	s7,24(sp)
 1e2:	6c42                	ld	s8,16(sp)
 1e4:	6ca2                	ld	s9,8(sp)
 1e6:	6125                	addi	sp,sp,96
 1e8:	8082                	ret

00000000000001ea <main>:
{
 1ea:	7139                	addi	sp,sp,-64
 1ec:	fc06                	sd	ra,56(sp)
 1ee:	f822                	sd	s0,48(sp)
 1f0:	f426                	sd	s1,40(sp)
 1f2:	f04a                	sd	s2,32(sp)
 1f4:	ec4e                	sd	s3,24(sp)
 1f6:	e852                	sd	s4,16(sp)
 1f8:	e456                	sd	s5,8(sp)
 1fa:	0080                	addi	s0,sp,64
  if(argc <= 1){
 1fc:	4785                	li	a5,1
 1fe:	04a7dd63          	bge	a5,a0,258 <main+0x6e>
  pattern = argv[1];
 202:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 206:	4789                	li	a5,2
 208:	06a7d663          	bge	a5,a0,274 <main+0x8a>
 20c:	01058493          	addi	s1,a1,16
 210:	ffd5099b          	addiw	s3,a0,-3
 214:	1982                	slli	s3,s3,0x20
 216:	0209d993          	srli	s3,s3,0x20
 21a:	098e                	slli	s3,s3,0x3
 21c:	05e1                	addi	a1,a1,24
 21e:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 220:	4581                	li	a1,0
 222:	6088                	ld	a0,0(s1)
 224:	00000097          	auipc	ra,0x0
 228:	396080e7          	jalr	918(ra) # 5ba <open>
 22c:	892a                	mv	s2,a0
 22e:	04054e63          	bltz	a0,28a <main+0xa0>
    grep(pattern, fd);
 232:	85aa                	mv	a1,a0
 234:	8552                	mv	a0,s4
 236:	00000097          	auipc	ra,0x0
 23a:	ee4080e7          	jalr	-284(ra) # 11a <grep>
    close(fd);
 23e:	854a                	mv	a0,s2
 240:	00000097          	auipc	ra,0x0
 244:	362080e7          	jalr	866(ra) # 5a2 <close>
 248:	04a1                	addi	s1,s1,8
  for(i = 2; i < argc; i++){
 24a:	fd349be3          	bne	s1,s3,220 <main+0x36>
  exit(0);
 24e:	4501                	li	a0,0
 250:	00000097          	auipc	ra,0x0
 254:	32a080e7          	jalr	810(ra) # 57a <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 258:	00001597          	auipc	a1,0x1
 25c:	86858593          	addi	a1,a1,-1944 # ac0 <malloc+0xe8>
 260:	4509                	li	a0,2
 262:	00000097          	auipc	ra,0x0
 266:	688080e7          	jalr	1672(ra) # 8ea <fprintf>
    exit(1);
 26a:	4505                	li	a0,1
 26c:	00000097          	auipc	ra,0x0
 270:	30e080e7          	jalr	782(ra) # 57a <exit>
    grep(pattern, 0);
 274:	4581                	li	a1,0
 276:	8552                	mv	a0,s4
 278:	00000097          	auipc	ra,0x0
 27c:	ea2080e7          	jalr	-350(ra) # 11a <grep>
    exit(0);
 280:	4501                	li	a0,0
 282:	00000097          	auipc	ra,0x0
 286:	2f8080e7          	jalr	760(ra) # 57a <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28a:	608c                	ld	a1,0(s1)
 28c:	00001517          	auipc	a0,0x1
 290:	85450513          	addi	a0,a0,-1964 # ae0 <malloc+0x108>
 294:	00000097          	auipc	ra,0x0
 298:	684080e7          	jalr	1668(ra) # 918 <printf>
      exit(1);
 29c:	4505                	li	a0,1
 29e:	00000097          	auipc	ra,0x0
 2a2:	2dc080e7          	jalr	732(ra) # 57a <exit>

00000000000002a6 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ac:	87aa                	mv	a5,a0
 2ae:	0585                	addi	a1,a1,1
 2b0:	0785                	addi	a5,a5,1
 2b2:	fff5c703          	lbu	a4,-1(a1)
 2b6:	fee78fa3          	sb	a4,-1(a5)
 2ba:	fb75                	bnez	a4,2ae <strcpy+0x8>
    ;
  return os;
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret

00000000000002c2 <strcat>:

char*
strcat(char *s, const char *t)
{
 2c2:	1141                	addi	sp,sp,-16
 2c4:	e422                	sd	s0,8(sp)
 2c6:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 2c8:	00054783          	lbu	a5,0(a0)
 2cc:	c385                	beqz	a5,2ec <strcat+0x2a>
 2ce:	87aa                	mv	a5,a0
    s++;
 2d0:	0785                	addi	a5,a5,1
  while(*s)
 2d2:	0007c703          	lbu	a4,0(a5)
 2d6:	ff6d                	bnez	a4,2d0 <strcat+0xe>
  while((*s++ = *t++))
 2d8:	0585                	addi	a1,a1,1
 2da:	0785                	addi	a5,a5,1
 2dc:	fff5c703          	lbu	a4,-1(a1)
 2e0:	fee78fa3          	sb	a4,-1(a5)
 2e4:	fb75                	bnez	a4,2d8 <strcat+0x16>
    ;
  return os;
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret
  while(*s)
 2ec:	87aa                	mv	a5,a0
 2ee:	b7ed                	j	2d8 <strcat+0x16>

00000000000002f0 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e422                	sd	s0,8(sp)
 2f4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2f6:	00054783          	lbu	a5,0(a0)
 2fa:	cf91                	beqz	a5,316 <strcmp+0x26>
 2fc:	0005c703          	lbu	a4,0(a1)
 300:	00f71b63          	bne	a4,a5,316 <strcmp+0x26>
    p++, q++;
 304:	0505                	addi	a0,a0,1
 306:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 308:	00054783          	lbu	a5,0(a0)
 30c:	c789                	beqz	a5,316 <strcmp+0x26>
 30e:	0005c703          	lbu	a4,0(a1)
 312:	fef709e3          	beq	a4,a5,304 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 316:	0005c503          	lbu	a0,0(a1)
}
 31a:	40a7853b          	subw	a0,a5,a0
 31e:	6422                	ld	s0,8(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret

0000000000000324 <strlen>:

uint
strlen(const char *s)
{
 324:	1141                	addi	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 32a:	00054783          	lbu	a5,0(a0)
 32e:	cf91                	beqz	a5,34a <strlen+0x26>
 330:	0505                	addi	a0,a0,1
 332:	87aa                	mv	a5,a0
 334:	4685                	li	a3,1
 336:	9e89                	subw	a3,a3,a0
    ;
 338:	00f6853b          	addw	a0,a3,a5
 33c:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 33e:	fff7c703          	lbu	a4,-1(a5)
 342:	fb7d                	bnez	a4,338 <strlen+0x14>
  return n;
}
 344:	6422                	ld	s0,8(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret
  for(n = 0; s[n]; n++)
 34a:	4501                	li	a0,0
 34c:	bfe5                	j	344 <strlen+0x20>

000000000000034e <memset>:

void*
memset(void *dst, int c, uint n)
{
 34e:	1141                	addi	sp,sp,-16
 350:	e422                	sd	s0,8(sp)
 352:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 354:	ce09                	beqz	a2,36e <memset+0x20>
 356:	87aa                	mv	a5,a0
 358:	fff6071b          	addiw	a4,a2,-1
 35c:	1702                	slli	a4,a4,0x20
 35e:	9301                	srli	a4,a4,0x20
 360:	0705                	addi	a4,a4,1
 362:	972a                	add	a4,a4,a0
    cdst[i] = c;
 364:	00b78023          	sb	a1,0(a5)
 368:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 36a:	fee79de3          	bne	a5,a4,364 <memset+0x16>
  }
  return dst;
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret

0000000000000374 <strchr>:

char*
strchr(const char *s, char c)
{
 374:	1141                	addi	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	addi	s0,sp,16
  for(; *s; s++)
 37a:	00054783          	lbu	a5,0(a0)
 37e:	cf91                	beqz	a5,39a <strchr+0x26>
    if(*s == c)
 380:	00f58a63          	beq	a1,a5,394 <strchr+0x20>
  for(; *s; s++)
 384:	0505                	addi	a0,a0,1
 386:	00054783          	lbu	a5,0(a0)
 38a:	c781                	beqz	a5,392 <strchr+0x1e>
    if(*s == c)
 38c:	feb79ce3          	bne	a5,a1,384 <strchr+0x10>
 390:	a011                	j	394 <strchr+0x20>
      return (char*)s;
  return 0;
 392:	4501                	li	a0,0
}
 394:	6422                	ld	s0,8(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret
  return 0;
 39a:	4501                	li	a0,0
 39c:	bfe5                	j	394 <strchr+0x20>

000000000000039e <gets>:

char*
gets(char *buf, int max)
{
 39e:	711d                	addi	sp,sp,-96
 3a0:	ec86                	sd	ra,88(sp)
 3a2:	e8a2                	sd	s0,80(sp)
 3a4:	e4a6                	sd	s1,72(sp)
 3a6:	e0ca                	sd	s2,64(sp)
 3a8:	fc4e                	sd	s3,56(sp)
 3aa:	f852                	sd	s4,48(sp)
 3ac:	f456                	sd	s5,40(sp)
 3ae:	f05a                	sd	s6,32(sp)
 3b0:	ec5e                	sd	s7,24(sp)
 3b2:	1080                	addi	s0,sp,96
 3b4:	8baa                	mv	s7,a0
 3b6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b8:	892a                	mv	s2,a0
 3ba:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3bc:	4aa9                	li	s5,10
 3be:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3c0:	0019849b          	addiw	s1,s3,1
 3c4:	0344d863          	bge	s1,s4,3f4 <gets+0x56>
    cc = read(0, &c, 1);
 3c8:	4605                	li	a2,1
 3ca:	faf40593          	addi	a1,s0,-81
 3ce:	4501                	li	a0,0
 3d0:	00000097          	auipc	ra,0x0
 3d4:	1c2080e7          	jalr	450(ra) # 592 <read>
    if(cc < 1)
 3d8:	00a05e63          	blez	a0,3f4 <gets+0x56>
    buf[i++] = c;
 3dc:	faf44783          	lbu	a5,-81(s0)
 3e0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3e4:	01578763          	beq	a5,s5,3f2 <gets+0x54>
 3e8:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 3ea:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 3ec:	fd679ae3          	bne	a5,s6,3c0 <gets+0x22>
 3f0:	a011                	j	3f4 <gets+0x56>
  for(i=0; i+1 < max; ){
 3f2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3f4:	99de                	add	s3,s3,s7
 3f6:	00098023          	sb	zero,0(s3)
  return buf;
}
 3fa:	855e                	mv	a0,s7
 3fc:	60e6                	ld	ra,88(sp)
 3fe:	6446                	ld	s0,80(sp)
 400:	64a6                	ld	s1,72(sp)
 402:	6906                	ld	s2,64(sp)
 404:	79e2                	ld	s3,56(sp)
 406:	7a42                	ld	s4,48(sp)
 408:	7aa2                	ld	s5,40(sp)
 40a:	7b02                	ld	s6,32(sp)
 40c:	6be2                	ld	s7,24(sp)
 40e:	6125                	addi	sp,sp,96
 410:	8082                	ret

0000000000000412 <stat>:

int
stat(const char *n, struct stat *st)
{
 412:	1101                	addi	sp,sp,-32
 414:	ec06                	sd	ra,24(sp)
 416:	e822                	sd	s0,16(sp)
 418:	e426                	sd	s1,8(sp)
 41a:	e04a                	sd	s2,0(sp)
 41c:	1000                	addi	s0,sp,32
 41e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 420:	4581                	li	a1,0
 422:	00000097          	auipc	ra,0x0
 426:	198080e7          	jalr	408(ra) # 5ba <open>
  if(fd < 0)
 42a:	02054563          	bltz	a0,454 <stat+0x42>
 42e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 430:	85ca                	mv	a1,s2
 432:	00000097          	auipc	ra,0x0
 436:	190080e7          	jalr	400(ra) # 5c2 <fstat>
 43a:	892a                	mv	s2,a0
  close(fd);
 43c:	8526                	mv	a0,s1
 43e:	00000097          	auipc	ra,0x0
 442:	164080e7          	jalr	356(ra) # 5a2 <close>
  return r;
}
 446:	854a                	mv	a0,s2
 448:	60e2                	ld	ra,24(sp)
 44a:	6442                	ld	s0,16(sp)
 44c:	64a2                	ld	s1,8(sp)
 44e:	6902                	ld	s2,0(sp)
 450:	6105                	addi	sp,sp,32
 452:	8082                	ret
    return -1;
 454:	597d                	li	s2,-1
 456:	bfc5                	j	446 <stat+0x34>

0000000000000458 <atoi>:

int
atoi(const char *s)
{
 458:	1141                	addi	sp,sp,-16
 45a:	e422                	sd	s0,8(sp)
 45c:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 45e:	00054703          	lbu	a4,0(a0)
 462:	02d00793          	li	a5,45
  int neg = 1;
 466:	4805                	li	a6,1
  if (*s == '-') {
 468:	04f70363          	beq	a4,a5,4ae <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 46c:	00054683          	lbu	a3,0(a0)
 470:	fd06879b          	addiw	a5,a3,-48
 474:	0ff7f793          	andi	a5,a5,255
 478:	4725                	li	a4,9
 47a:	02f76d63          	bltu	a4,a5,4b4 <atoi+0x5c>
  n = 0;
 47e:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 480:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 482:	0505                	addi	a0,a0,1
 484:	0026179b          	slliw	a5,a2,0x2
 488:	9fb1                	addw	a5,a5,a2
 48a:	0017979b          	slliw	a5,a5,0x1
 48e:	9fb5                	addw	a5,a5,a3
 490:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 494:	00054683          	lbu	a3,0(a0)
 498:	fd06871b          	addiw	a4,a3,-48
 49c:	0ff77713          	andi	a4,a4,255
 4a0:	fee5f1e3          	bgeu	a1,a4,482 <atoi+0x2a>
  return n * neg;
}
 4a4:	02c8053b          	mulw	a0,a6,a2
 4a8:	6422                	ld	s0,8(sp)
 4aa:	0141                	addi	sp,sp,16
 4ac:	8082                	ret
    s++;
 4ae:	0505                	addi	a0,a0,1
    neg = -1;
 4b0:	587d                	li	a6,-1
 4b2:	bf6d                	j	46c <atoi+0x14>
  n = 0;
 4b4:	4601                	li	a2,0
 4b6:	b7fd                	j	4a4 <atoi+0x4c>

00000000000004b8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4b8:	1141                	addi	sp,sp,-16
 4ba:	e422                	sd	s0,8(sp)
 4bc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4be:	02b57663          	bgeu	a0,a1,4ea <memmove+0x32>
    while(n-- > 0)
 4c2:	02c05163          	blez	a2,4e4 <memmove+0x2c>
 4c6:	fff6079b          	addiw	a5,a2,-1
 4ca:	1782                	slli	a5,a5,0x20
 4cc:	9381                	srli	a5,a5,0x20
 4ce:	0785                	addi	a5,a5,1
 4d0:	97aa                	add	a5,a5,a0
  dst = vdst;
 4d2:	872a                	mv	a4,a0
      *dst++ = *src++;
 4d4:	0585                	addi	a1,a1,1
 4d6:	0705                	addi	a4,a4,1
 4d8:	fff5c683          	lbu	a3,-1(a1)
 4dc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4e0:	fee79ae3          	bne	a5,a4,4d4 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4e4:	6422                	ld	s0,8(sp)
 4e6:	0141                	addi	sp,sp,16
 4e8:	8082                	ret
    dst += n;
 4ea:	00c50733          	add	a4,a0,a2
    src += n;
 4ee:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4f0:	fec05ae3          	blez	a2,4e4 <memmove+0x2c>
 4f4:	fff6079b          	addiw	a5,a2,-1
 4f8:	1782                	slli	a5,a5,0x20
 4fa:	9381                	srli	a5,a5,0x20
 4fc:	fff7c793          	not	a5,a5
 500:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 502:	15fd                	addi	a1,a1,-1
 504:	177d                	addi	a4,a4,-1
 506:	0005c683          	lbu	a3,0(a1)
 50a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 50e:	fef71ae3          	bne	a4,a5,502 <memmove+0x4a>
 512:	bfc9                	j	4e4 <memmove+0x2c>

0000000000000514 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 514:	1141                	addi	sp,sp,-16
 516:	e422                	sd	s0,8(sp)
 518:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 51a:	ce15                	beqz	a2,556 <memcmp+0x42>
 51c:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 520:	00054783          	lbu	a5,0(a0)
 524:	0005c703          	lbu	a4,0(a1)
 528:	02e79063          	bne	a5,a4,548 <memcmp+0x34>
 52c:	1682                	slli	a3,a3,0x20
 52e:	9281                	srli	a3,a3,0x20
 530:	0685                	addi	a3,a3,1
 532:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 534:	0505                	addi	a0,a0,1
    p2++;
 536:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 538:	00d50d63          	beq	a0,a3,552 <memcmp+0x3e>
    if (*p1 != *p2) {
 53c:	00054783          	lbu	a5,0(a0)
 540:	0005c703          	lbu	a4,0(a1)
 544:	fee788e3          	beq	a5,a4,534 <memcmp+0x20>
      return *p1 - *p2;
 548:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 54c:	6422                	ld	s0,8(sp)
 54e:	0141                	addi	sp,sp,16
 550:	8082                	ret
  return 0;
 552:	4501                	li	a0,0
 554:	bfe5                	j	54c <memcmp+0x38>
 556:	4501                	li	a0,0
 558:	bfd5                	j	54c <memcmp+0x38>

000000000000055a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 55a:	1141                	addi	sp,sp,-16
 55c:	e406                	sd	ra,8(sp)
 55e:	e022                	sd	s0,0(sp)
 560:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 562:	00000097          	auipc	ra,0x0
 566:	f56080e7          	jalr	-170(ra) # 4b8 <memmove>
}
 56a:	60a2                	ld	ra,8(sp)
 56c:	6402                	ld	s0,0(sp)
 56e:	0141                	addi	sp,sp,16
 570:	8082                	ret

0000000000000572 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 572:	4885                	li	a7,1
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <exit>:
.global exit
exit:
 li a7, SYS_exit
 57a:	4889                	li	a7,2
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <wait>:
.global wait
wait:
 li a7, SYS_wait
 582:	488d                	li	a7,3
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 58a:	4891                	li	a7,4
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <read>:
.global read
read:
 li a7, SYS_read
 592:	4895                	li	a7,5
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <write>:
.global write
write:
 li a7, SYS_write
 59a:	48c1                	li	a7,16
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <close>:
.global close
close:
 li a7, SYS_close
 5a2:	48d5                	li	a7,21
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <kill>:
.global kill
kill:
 li a7, SYS_kill
 5aa:	4899                	li	a7,6
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5b2:	489d                	li	a7,7
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <open>:
.global open
open:
 li a7, SYS_open
 5ba:	48bd                	li	a7,15
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5c2:	48a1                	li	a7,8
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ca:	48d1                	li	a7,20
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5d2:	48a5                	li	a7,9
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <dup>:
.global dup
dup:
 li a7, SYS_dup
 5da:	48a9                	li	a7,10
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5e2:	48ad                	li	a7,11
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ea:	48b1                	li	a7,12
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5f2:	48b5                	li	a7,13
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5fa:	48b9                	li	a7,14
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 602:	48d9                	li	a7,22
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <dev>:
.global dev
dev:
 li a7, SYS_dev
 60a:	48dd                	li	a7,23
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 612:	48e1                	li	a7,24
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 61a:	48e5                	li	a7,25
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <remove>:
.global remove
remove:
 li a7, SYS_remove
 622:	48c5                	li	a7,17
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <trace>:
.global trace
trace:
 li a7, SYS_trace
 62a:	48c9                	li	a7,18
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 632:	48cd                	li	a7,19
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <rename>:
.global rename
rename:
 li a7, SYS_rename
 63a:	48e9                	li	a7,26
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 642:	1101                	addi	sp,sp,-32
 644:	ec06                	sd	ra,24(sp)
 646:	e822                	sd	s0,16(sp)
 648:	1000                	addi	s0,sp,32
 64a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 64e:	4605                	li	a2,1
 650:	fef40593          	addi	a1,s0,-17
 654:	00000097          	auipc	ra,0x0
 658:	f46080e7          	jalr	-186(ra) # 59a <write>
}
 65c:	60e2                	ld	ra,24(sp)
 65e:	6442                	ld	s0,16(sp)
 660:	6105                	addi	sp,sp,32
 662:	8082                	ret

0000000000000664 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 664:	7139                	addi	sp,sp,-64
 666:	fc06                	sd	ra,56(sp)
 668:	f822                	sd	s0,48(sp)
 66a:	f426                	sd	s1,40(sp)
 66c:	f04a                	sd	s2,32(sp)
 66e:	ec4e                	sd	s3,24(sp)
 670:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 672:	c299                	beqz	a3,678 <printint+0x14>
 674:	0005cd63          	bltz	a1,68e <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 678:	2581                	sext.w	a1,a1
  neg = 0;
 67a:	4301                	li	t1,0
 67c:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 680:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 682:	2601                	sext.w	a2,a2
 684:	00000897          	auipc	a7,0x0
 688:	47488893          	addi	a7,a7,1140 # af8 <digits>
 68c:	a039                	j	69a <printint+0x36>
    x = -xx;
 68e:	40b005bb          	negw	a1,a1
    neg = 1;
 692:	4305                	li	t1,1
    x = -xx;
 694:	b7e5                	j	67c <printint+0x18>
  }while((x /= base) != 0);
 696:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 698:	8836                	mv	a6,a3
 69a:	0018069b          	addiw	a3,a6,1
 69e:	02c5f7bb          	remuw	a5,a1,a2
 6a2:	1782                	slli	a5,a5,0x20
 6a4:	9381                	srli	a5,a5,0x20
 6a6:	97c6                	add	a5,a5,a7
 6a8:	0007c783          	lbu	a5,0(a5)
 6ac:	00f70023          	sb	a5,0(a4)
 6b0:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 6b2:	02c5d7bb          	divuw	a5,a1,a2
 6b6:	fec5f0e3          	bgeu	a1,a2,696 <printint+0x32>
  if(neg)
 6ba:	00030b63          	beqz	t1,6d0 <printint+0x6c>
    buf[i++] = '-';
 6be:	fd040793          	addi	a5,s0,-48
 6c2:	96be                	add	a3,a3,a5
 6c4:	02d00793          	li	a5,45
 6c8:	fef68823          	sb	a5,-16(a3)
 6cc:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 6d0:	02d05963          	blez	a3,702 <printint+0x9e>
 6d4:	89aa                	mv	s3,a0
 6d6:	fc040793          	addi	a5,s0,-64
 6da:	00d784b3          	add	s1,a5,a3
 6de:	fff78913          	addi	s2,a5,-1
 6e2:	9936                	add	s2,s2,a3
 6e4:	36fd                	addiw	a3,a3,-1
 6e6:	1682                	slli	a3,a3,0x20
 6e8:	9281                	srli	a3,a3,0x20
 6ea:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 6ee:	fff4c583          	lbu	a1,-1(s1)
 6f2:	854e                	mv	a0,s3
 6f4:	00000097          	auipc	ra,0x0
 6f8:	f4e080e7          	jalr	-178(ra) # 642 <putc>
 6fc:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 6fe:	ff2498e3          	bne	s1,s2,6ee <printint+0x8a>
}
 702:	70e2                	ld	ra,56(sp)
 704:	7442                	ld	s0,48(sp)
 706:	74a2                	ld	s1,40(sp)
 708:	7902                	ld	s2,32(sp)
 70a:	69e2                	ld	s3,24(sp)
 70c:	6121                	addi	sp,sp,64
 70e:	8082                	ret

0000000000000710 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 710:	7119                	addi	sp,sp,-128
 712:	fc86                	sd	ra,120(sp)
 714:	f8a2                	sd	s0,112(sp)
 716:	f4a6                	sd	s1,104(sp)
 718:	f0ca                	sd	s2,96(sp)
 71a:	ecce                	sd	s3,88(sp)
 71c:	e8d2                	sd	s4,80(sp)
 71e:	e4d6                	sd	s5,72(sp)
 720:	e0da                	sd	s6,64(sp)
 722:	fc5e                	sd	s7,56(sp)
 724:	f862                	sd	s8,48(sp)
 726:	f466                	sd	s9,40(sp)
 728:	f06a                	sd	s10,32(sp)
 72a:	ec6e                	sd	s11,24(sp)
 72c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 72e:	0005c483          	lbu	s1,0(a1)
 732:	18048d63          	beqz	s1,8cc <vprintf+0x1bc>
 736:	8aaa                	mv	s5,a0
 738:	8b32                	mv	s6,a2
 73a:	00158913          	addi	s2,a1,1
  state = 0;
 73e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 740:	02500a13          	li	s4,37
      if(c == 'd'){
 744:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 748:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 74c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 750:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 754:	00000b97          	auipc	s7,0x0
 758:	3a4b8b93          	addi	s7,s7,932 # af8 <digits>
 75c:	a839                	j	77a <vprintf+0x6a>
        putc(fd, c);
 75e:	85a6                	mv	a1,s1
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	ee0080e7          	jalr	-288(ra) # 642 <putc>
 76a:	a019                	j	770 <vprintf+0x60>
    } else if(state == '%'){
 76c:	01498f63          	beq	s3,s4,78a <vprintf+0x7a>
 770:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 772:	fff94483          	lbu	s1,-1(s2)
 776:	14048b63          	beqz	s1,8cc <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 77a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 77e:	fe0997e3          	bnez	s3,76c <vprintf+0x5c>
      if(c == '%'){
 782:	fd479ee3          	bne	a5,s4,75e <vprintf+0x4e>
        state = '%';
 786:	89be                	mv	s3,a5
 788:	b7e5                	j	770 <vprintf+0x60>
      if(c == 'd'){
 78a:	05878063          	beq	a5,s8,7ca <vprintf+0xba>
      } else if(c == 'l') {
 78e:	05978c63          	beq	a5,s9,7e6 <vprintf+0xd6>
      } else if(c == 'x') {
 792:	07a78863          	beq	a5,s10,802 <vprintf+0xf2>
      } else if(c == 'p') {
 796:	09b78463          	beq	a5,s11,81e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 79a:	07300713          	li	a4,115
 79e:	0ce78563          	beq	a5,a4,868 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7a2:	06300713          	li	a4,99
 7a6:	0ee78c63          	beq	a5,a4,89e <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7aa:	11478663          	beq	a5,s4,8b6 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7ae:	85d2                	mv	a1,s4
 7b0:	8556                	mv	a0,s5
 7b2:	00000097          	auipc	ra,0x0
 7b6:	e90080e7          	jalr	-368(ra) # 642 <putc>
        putc(fd, c);
 7ba:	85a6                	mv	a1,s1
 7bc:	8556                	mv	a0,s5
 7be:	00000097          	auipc	ra,0x0
 7c2:	e84080e7          	jalr	-380(ra) # 642 <putc>
      }
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	b765                	j	770 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7ca:	008b0493          	addi	s1,s6,8
 7ce:	4685                	li	a3,1
 7d0:	4629                	li	a2,10
 7d2:	000b2583          	lw	a1,0(s6)
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	e8c080e7          	jalr	-372(ra) # 664 <printint>
 7e0:	8b26                	mv	s6,s1
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	b771                	j	770 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7e6:	008b0493          	addi	s1,s6,8
 7ea:	4681                	li	a3,0
 7ec:	4629                	li	a2,10
 7ee:	000b2583          	lw	a1,0(s6)
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	e70080e7          	jalr	-400(ra) # 664 <printint>
 7fc:	8b26                	mv	s6,s1
      state = 0;
 7fe:	4981                	li	s3,0
 800:	bf85                	j	770 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 802:	008b0493          	addi	s1,s6,8
 806:	4681                	li	a3,0
 808:	4641                	li	a2,16
 80a:	000b2583          	lw	a1,0(s6)
 80e:	8556                	mv	a0,s5
 810:	00000097          	auipc	ra,0x0
 814:	e54080e7          	jalr	-428(ra) # 664 <printint>
 818:	8b26                	mv	s6,s1
      state = 0;
 81a:	4981                	li	s3,0
 81c:	bf91                	j	770 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 81e:	008b0793          	addi	a5,s6,8
 822:	f8f43423          	sd	a5,-120(s0)
 826:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 82a:	03000593          	li	a1,48
 82e:	8556                	mv	a0,s5
 830:	00000097          	auipc	ra,0x0
 834:	e12080e7          	jalr	-494(ra) # 642 <putc>
  putc(fd, 'x');
 838:	85ea                	mv	a1,s10
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	e06080e7          	jalr	-506(ra) # 642 <putc>
 844:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 846:	03c9d793          	srli	a5,s3,0x3c
 84a:	97de                	add	a5,a5,s7
 84c:	0007c583          	lbu	a1,0(a5)
 850:	8556                	mv	a0,s5
 852:	00000097          	auipc	ra,0x0
 856:	df0080e7          	jalr	-528(ra) # 642 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 85a:	0992                	slli	s3,s3,0x4
 85c:	34fd                	addiw	s1,s1,-1
 85e:	f4e5                	bnez	s1,846 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 860:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 864:	4981                	li	s3,0
 866:	b729                	j	770 <vprintf+0x60>
        s = va_arg(ap, char*);
 868:	008b0993          	addi	s3,s6,8
 86c:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 870:	c085                	beqz	s1,890 <vprintf+0x180>
        while(*s != 0){
 872:	0004c583          	lbu	a1,0(s1)
 876:	c9a1                	beqz	a1,8c6 <vprintf+0x1b6>
          putc(fd, *s);
 878:	8556                	mv	a0,s5
 87a:	00000097          	auipc	ra,0x0
 87e:	dc8080e7          	jalr	-568(ra) # 642 <putc>
          s++;
 882:	0485                	addi	s1,s1,1
        while(*s != 0){
 884:	0004c583          	lbu	a1,0(s1)
 888:	f9e5                	bnez	a1,878 <vprintf+0x168>
        s = va_arg(ap, char*);
 88a:	8b4e                	mv	s6,s3
      state = 0;
 88c:	4981                	li	s3,0
 88e:	b5cd                	j	770 <vprintf+0x60>
          s = "(null)";
 890:	00000497          	auipc	s1,0x0
 894:	28048493          	addi	s1,s1,640 # b10 <digits+0x18>
        while(*s != 0){
 898:	02800593          	li	a1,40
 89c:	bff1                	j	878 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 89e:	008b0493          	addi	s1,s6,8
 8a2:	000b4583          	lbu	a1,0(s6)
 8a6:	8556                	mv	a0,s5
 8a8:	00000097          	auipc	ra,0x0
 8ac:	d9a080e7          	jalr	-614(ra) # 642 <putc>
 8b0:	8b26                	mv	s6,s1
      state = 0;
 8b2:	4981                	li	s3,0
 8b4:	bd75                	j	770 <vprintf+0x60>
        putc(fd, c);
 8b6:	85d2                	mv	a1,s4
 8b8:	8556                	mv	a0,s5
 8ba:	00000097          	auipc	ra,0x0
 8be:	d88080e7          	jalr	-632(ra) # 642 <putc>
      state = 0;
 8c2:	4981                	li	s3,0
 8c4:	b575                	j	770 <vprintf+0x60>
        s = va_arg(ap, char*);
 8c6:	8b4e                	mv	s6,s3
      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	b55d                	j	770 <vprintf+0x60>
    }
  }
}
 8cc:	70e6                	ld	ra,120(sp)
 8ce:	7446                	ld	s0,112(sp)
 8d0:	74a6                	ld	s1,104(sp)
 8d2:	7906                	ld	s2,96(sp)
 8d4:	69e6                	ld	s3,88(sp)
 8d6:	6a46                	ld	s4,80(sp)
 8d8:	6aa6                	ld	s5,72(sp)
 8da:	6b06                	ld	s6,64(sp)
 8dc:	7be2                	ld	s7,56(sp)
 8de:	7c42                	ld	s8,48(sp)
 8e0:	7ca2                	ld	s9,40(sp)
 8e2:	7d02                	ld	s10,32(sp)
 8e4:	6de2                	ld	s11,24(sp)
 8e6:	6109                	addi	sp,sp,128
 8e8:	8082                	ret

00000000000008ea <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8ea:	715d                	addi	sp,sp,-80
 8ec:	ec06                	sd	ra,24(sp)
 8ee:	e822                	sd	s0,16(sp)
 8f0:	1000                	addi	s0,sp,32
 8f2:	e010                	sd	a2,0(s0)
 8f4:	e414                	sd	a3,8(s0)
 8f6:	e818                	sd	a4,16(s0)
 8f8:	ec1c                	sd	a5,24(s0)
 8fa:	03043023          	sd	a6,32(s0)
 8fe:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 902:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 906:	8622                	mv	a2,s0
 908:	00000097          	auipc	ra,0x0
 90c:	e08080e7          	jalr	-504(ra) # 710 <vprintf>
}
 910:	60e2                	ld	ra,24(sp)
 912:	6442                	ld	s0,16(sp)
 914:	6161                	addi	sp,sp,80
 916:	8082                	ret

0000000000000918 <printf>:

void
printf(const char *fmt, ...)
{
 918:	711d                	addi	sp,sp,-96
 91a:	ec06                	sd	ra,24(sp)
 91c:	e822                	sd	s0,16(sp)
 91e:	1000                	addi	s0,sp,32
 920:	e40c                	sd	a1,8(s0)
 922:	e810                	sd	a2,16(s0)
 924:	ec14                	sd	a3,24(s0)
 926:	f018                	sd	a4,32(s0)
 928:	f41c                	sd	a5,40(s0)
 92a:	03043823          	sd	a6,48(s0)
 92e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 932:	00840613          	addi	a2,s0,8
 936:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 93a:	85aa                	mv	a1,a0
 93c:	4505                	li	a0,1
 93e:	00000097          	auipc	ra,0x0
 942:	dd2080e7          	jalr	-558(ra) # 710 <vprintf>
}
 946:	60e2                	ld	ra,24(sp)
 948:	6442                	ld	s0,16(sp)
 94a:	6125                	addi	sp,sp,96
 94c:	8082                	ret

000000000000094e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 94e:	1141                	addi	sp,sp,-16
 950:	e422                	sd	s0,8(sp)
 952:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 954:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 958:	00000797          	auipc	a5,0x0
 95c:	1c078793          	addi	a5,a5,448 # b18 <__DATA_BEGIN__>
 960:	639c                	ld	a5,0(a5)
 962:	a805                	j	992 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 964:	4618                	lw	a4,8(a2)
 966:	9db9                	addw	a1,a1,a4
 968:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 96c:	6398                	ld	a4,0(a5)
 96e:	6318                	ld	a4,0(a4)
 970:	fee53823          	sd	a4,-16(a0)
 974:	a091                	j	9b8 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 976:	ff852703          	lw	a4,-8(a0)
 97a:	9e39                	addw	a2,a2,a4
 97c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 97e:	ff053703          	ld	a4,-16(a0)
 982:	e398                	sd	a4,0(a5)
 984:	a099                	j	9ca <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 986:	6398                	ld	a4,0(a5)
 988:	00e7e463          	bltu	a5,a4,990 <free+0x42>
 98c:	00e6ea63          	bltu	a3,a4,9a0 <free+0x52>
{
 990:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 992:	fed7fae3          	bgeu	a5,a3,986 <free+0x38>
 996:	6398                	ld	a4,0(a5)
 998:	00e6e463          	bltu	a3,a4,9a0 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 99c:	fee7eae3          	bltu	a5,a4,990 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 9a0:	ff852583          	lw	a1,-8(a0)
 9a4:	6390                	ld	a2,0(a5)
 9a6:	02059713          	slli	a4,a1,0x20
 9aa:	9301                	srli	a4,a4,0x20
 9ac:	0712                	slli	a4,a4,0x4
 9ae:	9736                	add	a4,a4,a3
 9b0:	fae60ae3          	beq	a2,a4,964 <free+0x16>
    bp->s.ptr = p->s.ptr;
 9b4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9b8:	4790                	lw	a2,8(a5)
 9ba:	02061713          	slli	a4,a2,0x20
 9be:	9301                	srli	a4,a4,0x20
 9c0:	0712                	slli	a4,a4,0x4
 9c2:	973e                	add	a4,a4,a5
 9c4:	fae689e3          	beq	a3,a4,976 <free+0x28>
  } else
    p->s.ptr = bp;
 9c8:	e394                	sd	a3,0(a5)
  freep = p;
 9ca:	00000717          	auipc	a4,0x0
 9ce:	14f73723          	sd	a5,334(a4) # b18 <__DATA_BEGIN__>
}
 9d2:	6422                	ld	s0,8(sp)
 9d4:	0141                	addi	sp,sp,16
 9d6:	8082                	ret

00000000000009d8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9d8:	7139                	addi	sp,sp,-64
 9da:	fc06                	sd	ra,56(sp)
 9dc:	f822                	sd	s0,48(sp)
 9de:	f426                	sd	s1,40(sp)
 9e0:	f04a                	sd	s2,32(sp)
 9e2:	ec4e                	sd	s3,24(sp)
 9e4:	e852                	sd	s4,16(sp)
 9e6:	e456                	sd	s5,8(sp)
 9e8:	e05a                	sd	s6,0(sp)
 9ea:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ec:	02051993          	slli	s3,a0,0x20
 9f0:	0209d993          	srli	s3,s3,0x20
 9f4:	09bd                	addi	s3,s3,15
 9f6:	0049d993          	srli	s3,s3,0x4
 9fa:	2985                	addiw	s3,s3,1
 9fc:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 a00:	00000797          	auipc	a5,0x0
 a04:	11878793          	addi	a5,a5,280 # b18 <__DATA_BEGIN__>
 a08:	6388                	ld	a0,0(a5)
 a0a:	c515                	beqz	a0,a36 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a0c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a0e:	4798                	lw	a4,8(a5)
 a10:	03277f63          	bgeu	a4,s2,a4e <malloc+0x76>
 a14:	8a4e                	mv	s4,s3
 a16:	0009871b          	sext.w	a4,s3
 a1a:	6685                	lui	a3,0x1
 a1c:	00d77363          	bgeu	a4,a3,a22 <malloc+0x4a>
 a20:	6a05                	lui	s4,0x1
 a22:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 a26:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a2a:	00000497          	auipc	s1,0x0
 a2e:	0ee48493          	addi	s1,s1,238 # b18 <__DATA_BEGIN__>
  if(p == (char*)-1)
 a32:	5b7d                	li	s6,-1
 a34:	a885                	j	aa4 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 a36:	00000797          	auipc	a5,0x0
 a3a:	4ea78793          	addi	a5,a5,1258 # f20 <base>
 a3e:	00000717          	auipc	a4,0x0
 a42:	0cf73d23          	sd	a5,218(a4) # b18 <__DATA_BEGIN__>
 a46:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a48:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a4c:	b7e1                	j	a14 <malloc+0x3c>
      if(p->s.size == nunits)
 a4e:	02e90b63          	beq	s2,a4,a84 <malloc+0xac>
        p->s.size -= nunits;
 a52:	4137073b          	subw	a4,a4,s3
 a56:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a58:	1702                	slli	a4,a4,0x20
 a5a:	9301                	srli	a4,a4,0x20
 a5c:	0712                	slli	a4,a4,0x4
 a5e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a60:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a64:	00000717          	auipc	a4,0x0
 a68:	0aa73a23          	sd	a0,180(a4) # b18 <__DATA_BEGIN__>
      return (void*)(p + 1);
 a6c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a70:	70e2                	ld	ra,56(sp)
 a72:	7442                	ld	s0,48(sp)
 a74:	74a2                	ld	s1,40(sp)
 a76:	7902                	ld	s2,32(sp)
 a78:	69e2                	ld	s3,24(sp)
 a7a:	6a42                	ld	s4,16(sp)
 a7c:	6aa2                	ld	s5,8(sp)
 a7e:	6b02                	ld	s6,0(sp)
 a80:	6121                	addi	sp,sp,64
 a82:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a84:	6398                	ld	a4,0(a5)
 a86:	e118                	sd	a4,0(a0)
 a88:	bff1                	j	a64 <malloc+0x8c>
  hp->s.size = nu;
 a8a:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 a8e:	0541                	addi	a0,a0,16
 a90:	00000097          	auipc	ra,0x0
 a94:	ebe080e7          	jalr	-322(ra) # 94e <free>
  return freep;
 a98:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a9a:	d979                	beqz	a0,a70 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a9c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a9e:	4798                	lw	a4,8(a5)
 aa0:	fb2777e3          	bgeu	a4,s2,a4e <malloc+0x76>
    if(p == freep)
 aa4:	6098                	ld	a4,0(s1)
 aa6:	853e                	mv	a0,a5
 aa8:	fef71ae3          	bne	a4,a5,a9c <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 aac:	8552                	mv	a0,s4
 aae:	00000097          	auipc	ra,0x0
 ab2:	b3c080e7          	jalr	-1220(ra) # 5ea <sbrk>
  if(p == (char*)-1)
 ab6:	fd651ae3          	bne	a0,s6,a8a <malloc+0xb2>
        return 0;
 aba:	4501                	li	a0,0
 abc:	bf55                	j	a70 <malloc+0x98>
