
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
 11a:	715d                	addi	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	0880                	addi	s0,sp,80
 130:	89aa                	mv	s3,a0
 132:	8b2e                	mv	s6,a1
  m = 0;
 134:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 136:	3ff00b93          	li	s7,1023
 13a:	00001a97          	auipc	s5,0x1
 13e:	9bea8a93          	addi	s5,s5,-1602 # af8 <buf>
 142:	a0a1                	j	18a <grep+0x70>
      p = q+1;
 144:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 148:	45a9                	li	a1,10
 14a:	854a                	mv	a0,s2
 14c:	00000097          	auipc	ra,0x0
 150:	214080e7          	jalr	532(ra) # 360 <strchr>
 154:	84aa                	mv	s1,a0
 156:	c905                	beqz	a0,186 <grep+0x6c>
      *q = 0;
 158:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 15c:	85ca                	mv	a1,s2
 15e:	854e                	mv	a0,s3
 160:	00000097          	auipc	ra,0x0
 164:	f6c080e7          	jalr	-148(ra) # cc <match>
 168:	dd71                	beqz	a0,144 <grep+0x2a>
        *q = '\n';
 16a:	47a9                	li	a5,10
 16c:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 170:	00148613          	addi	a2,s1,1
 174:	4126063b          	subw	a2,a2,s2
 178:	85ca                	mv	a1,s2
 17a:	4505                	li	a0,1
 17c:	00000097          	auipc	ra,0x0
 180:	3fa080e7          	jalr	1018(ra) # 576 <write>
 184:	b7c1                	j	144 <grep+0x2a>
    if(m > 0){
 186:	03404563          	bgtz	s4,1b0 <grep+0x96>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18a:	414b863b          	subw	a2,s7,s4
 18e:	014a85b3          	add	a1,s5,s4
 192:	855a                	mv	a0,s6
 194:	00000097          	auipc	ra,0x0
 198:	3da080e7          	jalr	986(ra) # 56e <read>
 19c:	02a05663          	blez	a0,1c8 <grep+0xae>
    m += n;
 1a0:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1a4:	014a87b3          	add	a5,s5,s4
 1a8:	00078023          	sb	zero,0(a5)
    p = buf;
 1ac:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 1ae:	bf69                	j	148 <grep+0x2e>
      m -= p - buf;
 1b0:	415907b3          	sub	a5,s2,s5
 1b4:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1b8:	8652                	mv	a2,s4
 1ba:	85ca                	mv	a1,s2
 1bc:	8556                	mv	a0,s5
 1be:	00000097          	auipc	ra,0x0
 1c2:	2e6080e7          	jalr	742(ra) # 4a4 <memmove>
 1c6:	b7d1                	j	18a <grep+0x70>
}
 1c8:	60a6                	ld	ra,72(sp)
 1ca:	6406                	ld	s0,64(sp)
 1cc:	74e2                	ld	s1,56(sp)
 1ce:	7942                	ld	s2,48(sp)
 1d0:	79a2                	ld	s3,40(sp)
 1d2:	7a02                	ld	s4,32(sp)
 1d4:	6ae2                	ld	s5,24(sp)
 1d6:	6b42                	ld	s6,16(sp)
 1d8:	6ba2                	ld	s7,8(sp)
 1da:	6161                	addi	sp,sp,80
 1dc:	8082                	ret

00000000000001de <main>:
{
 1de:	7139                	addi	sp,sp,-64
 1e0:	fc06                	sd	ra,56(sp)
 1e2:	f822                	sd	s0,48(sp)
 1e4:	f426                	sd	s1,40(sp)
 1e6:	f04a                	sd	s2,32(sp)
 1e8:	ec4e                	sd	s3,24(sp)
 1ea:	e852                	sd	s4,16(sp)
 1ec:	e456                	sd	s5,8(sp)
 1ee:	0080                	addi	s0,sp,64
  if(argc <= 1){
 1f0:	4785                	li	a5,1
 1f2:	04a7de63          	bge	a5,a0,24e <main+0x70>
  pattern = argv[1];
 1f6:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1fa:	4789                	li	a5,2
 1fc:	06a7d763          	bge	a5,a0,26a <main+0x8c>
 200:	01058913          	addi	s2,a1,16
 204:	ffd5099b          	addiw	s3,a0,-3
 208:	1982                	slli	s3,s3,0x20
 20a:	0209d993          	srli	s3,s3,0x20
 20e:	098e                	slli	s3,s3,0x3
 210:	05e1                	addi	a1,a1,24
 212:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 214:	4581                	li	a1,0
 216:	00093503          	ld	a0,0(s2)
 21a:	00000097          	auipc	ra,0x0
 21e:	37c080e7          	jalr	892(ra) # 596 <open>
 222:	84aa                	mv	s1,a0
 224:	04054e63          	bltz	a0,280 <main+0xa2>
    grep(pattern, fd);
 228:	85aa                	mv	a1,a0
 22a:	8552                	mv	a0,s4
 22c:	00000097          	auipc	ra,0x0
 230:	eee080e7          	jalr	-274(ra) # 11a <grep>
    close(fd);
 234:	8526                	mv	a0,s1
 236:	00000097          	auipc	ra,0x0
 23a:	348080e7          	jalr	840(ra) # 57e <close>
  for(i = 2; i < argc; i++){
 23e:	0921                	addi	s2,s2,8
 240:	fd391ae3          	bne	s2,s3,214 <main+0x36>
  exit(0);
 244:	4501                	li	a0,0
 246:	00000097          	auipc	ra,0x0
 24a:	310080e7          	jalr	784(ra) # 556 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 24e:	00001597          	auipc	a1,0x1
 252:	85258593          	addi	a1,a1,-1966 # aa0 <malloc+0xee>
 256:	4509                	li	a0,2
 258:	00000097          	auipc	ra,0x0
 25c:	66e080e7          	jalr	1646(ra) # 8c6 <fprintf>
    exit(1);
 260:	4505                	li	a0,1
 262:	00000097          	auipc	ra,0x0
 266:	2f4080e7          	jalr	756(ra) # 556 <exit>
    grep(pattern, 0);
 26a:	4581                	li	a1,0
 26c:	8552                	mv	a0,s4
 26e:	00000097          	auipc	ra,0x0
 272:	eac080e7          	jalr	-340(ra) # 11a <grep>
    exit(0);
 276:	4501                	li	a0,0
 278:	00000097          	auipc	ra,0x0
 27c:	2de080e7          	jalr	734(ra) # 556 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 280:	00093583          	ld	a1,0(s2)
 284:	00001517          	auipc	a0,0x1
 288:	83c50513          	addi	a0,a0,-1988 # ac0 <malloc+0x10e>
 28c:	00000097          	auipc	ra,0x0
 290:	668080e7          	jalr	1640(ra) # 8f4 <printf>
      exit(1);
 294:	4505                	li	a0,1
 296:	00000097          	auipc	ra,0x0
 29a:	2c0080e7          	jalr	704(ra) # 556 <exit>

000000000000029e <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e422                	sd	s0,8(sp)
 2a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2a4:	87aa                	mv	a5,a0
 2a6:	0585                	addi	a1,a1,1
 2a8:	0785                	addi	a5,a5,1
 2aa:	fff5c703          	lbu	a4,-1(a1)
 2ae:	fee78fa3          	sb	a4,-1(a5)
 2b2:	fb75                	bnez	a4,2a6 <strcpy+0x8>
    ;
  return os;
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <strcat>:

char*
strcat(char *s, const char *t)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 2c0:	00054783          	lbu	a5,0(a0)
 2c4:	c385                	beqz	a5,2e4 <strcat+0x2a>
 2c6:	87aa                	mv	a5,a0
    s++;
 2c8:	0785                	addi	a5,a5,1
  while(*s)
 2ca:	0007c703          	lbu	a4,0(a5)
 2ce:	ff6d                	bnez	a4,2c8 <strcat+0xe>
  while((*s++ = *t++))
 2d0:	0585                	addi	a1,a1,1
 2d2:	0785                	addi	a5,a5,1
 2d4:	fff5c703          	lbu	a4,-1(a1)
 2d8:	fee78fa3          	sb	a4,-1(a5)
 2dc:	fb75                	bnez	a4,2d0 <strcat+0x16>
    ;
  return os;
}
 2de:	6422                	ld	s0,8(sp)
 2e0:	0141                	addi	sp,sp,16
 2e2:	8082                	ret
  while(*s)
 2e4:	87aa                	mv	a5,a0
 2e6:	b7ed                	j	2d0 <strcat+0x16>

00000000000002e8 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2ee:	00054783          	lbu	a5,0(a0)
 2f2:	cb91                	beqz	a5,306 <strcmp+0x1e>
 2f4:	0005c703          	lbu	a4,0(a1)
 2f8:	00f71763          	bne	a4,a5,306 <strcmp+0x1e>
    p++, q++;
 2fc:	0505                	addi	a0,a0,1
 2fe:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 300:	00054783          	lbu	a5,0(a0)
 304:	fbe5                	bnez	a5,2f4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 306:	0005c503          	lbu	a0,0(a1)
}
 30a:	40a7853b          	subw	a0,a5,a0
 30e:	6422                	ld	s0,8(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret

0000000000000314 <strlen>:

uint
strlen(const char *s)
{
 314:	1141                	addi	sp,sp,-16
 316:	e422                	sd	s0,8(sp)
 318:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 31a:	00054783          	lbu	a5,0(a0)
 31e:	cf91                	beqz	a5,33a <strlen+0x26>
 320:	0505                	addi	a0,a0,1
 322:	87aa                	mv	a5,a0
 324:	4685                	li	a3,1
 326:	9e89                	subw	a3,a3,a0
 328:	00f6853b          	addw	a0,a3,a5
 32c:	0785                	addi	a5,a5,1
 32e:	fff7c703          	lbu	a4,-1(a5)
 332:	fb7d                	bnez	a4,328 <strlen+0x14>
    ;
  return n;
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret
  for(n = 0; s[n]; n++)
 33a:	4501                	li	a0,0
 33c:	bfe5                	j	334 <strlen+0x20>

000000000000033e <memset>:

void*
memset(void *dst, int c, uint n)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e422                	sd	s0,8(sp)
 342:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 344:	ca19                	beqz	a2,35a <memset+0x1c>
 346:	87aa                	mv	a5,a0
 348:	1602                	slli	a2,a2,0x20
 34a:	9201                	srli	a2,a2,0x20
 34c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 350:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 354:	0785                	addi	a5,a5,1
 356:	fee79de3          	bne	a5,a4,350 <memset+0x12>
  }
  return dst;
}
 35a:	6422                	ld	s0,8(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret

0000000000000360 <strchr>:

char*
strchr(const char *s, char c)
{
 360:	1141                	addi	sp,sp,-16
 362:	e422                	sd	s0,8(sp)
 364:	0800                	addi	s0,sp,16
  for(; *s; s++)
 366:	00054783          	lbu	a5,0(a0)
 36a:	cb99                	beqz	a5,380 <strchr+0x20>
    if(*s == c)
 36c:	00f58763          	beq	a1,a5,37a <strchr+0x1a>
  for(; *s; s++)
 370:	0505                	addi	a0,a0,1
 372:	00054783          	lbu	a5,0(a0)
 376:	fbfd                	bnez	a5,36c <strchr+0xc>
      return (char*)s;
  return 0;
 378:	4501                	li	a0,0
}
 37a:	6422                	ld	s0,8(sp)
 37c:	0141                	addi	sp,sp,16
 37e:	8082                	ret
  return 0;
 380:	4501                	li	a0,0
 382:	bfe5                	j	37a <strchr+0x1a>

0000000000000384 <gets>:

char*
gets(char *buf, int max)
{
 384:	711d                	addi	sp,sp,-96
 386:	ec86                	sd	ra,88(sp)
 388:	e8a2                	sd	s0,80(sp)
 38a:	e4a6                	sd	s1,72(sp)
 38c:	e0ca                	sd	s2,64(sp)
 38e:	fc4e                	sd	s3,56(sp)
 390:	f852                	sd	s4,48(sp)
 392:	f456                	sd	s5,40(sp)
 394:	f05a                	sd	s6,32(sp)
 396:	ec5e                	sd	s7,24(sp)
 398:	e862                	sd	s8,16(sp)
 39a:	1080                	addi	s0,sp,96
 39c:	8baa                	mv	s7,a0
 39e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3a0:	892a                	mv	s2,a0
 3a2:	4481                	li	s1,0
    cc = read(0, &c, 1);
 3a4:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3a8:	4b29                	li	s6,10
 3aa:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 3ac:	89a6                	mv	s3,s1
 3ae:	2485                	addiw	s1,s1,1
 3b0:	0344d763          	bge	s1,s4,3de <gets+0x5a>
    cc = read(0, &c, 1);
 3b4:	4605                	li	a2,1
 3b6:	85d6                	mv	a1,s5
 3b8:	4501                	li	a0,0
 3ba:	00000097          	auipc	ra,0x0
 3be:	1b4080e7          	jalr	436(ra) # 56e <read>
    if(cc < 1)
 3c2:	00a05e63          	blez	a0,3de <gets+0x5a>
    buf[i++] = c;
 3c6:	faf44783          	lbu	a5,-81(s0)
 3ca:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ce:	01678763          	beq	a5,s6,3dc <gets+0x58>
 3d2:	0905                	addi	s2,s2,1
 3d4:	fd879ce3          	bne	a5,s8,3ac <gets+0x28>
  for(i=0; i+1 < max; ){
 3d8:	89a6                	mv	s3,s1
 3da:	a011                	j	3de <gets+0x5a>
 3dc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3de:	99de                	add	s3,s3,s7
 3e0:	00098023          	sb	zero,0(s3)
  return buf;
}
 3e4:	855e                	mv	a0,s7
 3e6:	60e6                	ld	ra,88(sp)
 3e8:	6446                	ld	s0,80(sp)
 3ea:	64a6                	ld	s1,72(sp)
 3ec:	6906                	ld	s2,64(sp)
 3ee:	79e2                	ld	s3,56(sp)
 3f0:	7a42                	ld	s4,48(sp)
 3f2:	7aa2                	ld	s5,40(sp)
 3f4:	7b02                	ld	s6,32(sp)
 3f6:	6be2                	ld	s7,24(sp)
 3f8:	6c42                	ld	s8,16(sp)
 3fa:	6125                	addi	sp,sp,96
 3fc:	8082                	ret

00000000000003fe <stat>:

int
stat(const char *n, struct stat *st)
{
 3fe:	1101                	addi	sp,sp,-32
 400:	ec06                	sd	ra,24(sp)
 402:	e822                	sd	s0,16(sp)
 404:	e426                	sd	s1,8(sp)
 406:	e04a                	sd	s2,0(sp)
 408:	1000                	addi	s0,sp,32
 40a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 40c:	4581                	li	a1,0
 40e:	00000097          	auipc	ra,0x0
 412:	188080e7          	jalr	392(ra) # 596 <open>
  if(fd < 0)
 416:	02054563          	bltz	a0,440 <stat+0x42>
 41a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 41c:	85ca                	mv	a1,s2
 41e:	00000097          	auipc	ra,0x0
 422:	180080e7          	jalr	384(ra) # 59e <fstat>
 426:	892a                	mv	s2,a0
  close(fd);
 428:	8526                	mv	a0,s1
 42a:	00000097          	auipc	ra,0x0
 42e:	154080e7          	jalr	340(ra) # 57e <close>
  return r;
}
 432:	854a                	mv	a0,s2
 434:	60e2                	ld	ra,24(sp)
 436:	6442                	ld	s0,16(sp)
 438:	64a2                	ld	s1,8(sp)
 43a:	6902                	ld	s2,0(sp)
 43c:	6105                	addi	sp,sp,32
 43e:	8082                	ret
    return -1;
 440:	597d                	li	s2,-1
 442:	bfc5                	j	432 <stat+0x34>

0000000000000444 <atoi>:

int
atoi(const char *s)
{
 444:	1141                	addi	sp,sp,-16
 446:	e422                	sd	s0,8(sp)
 448:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 44a:	00054703          	lbu	a4,0(a0)
 44e:	02d00793          	li	a5,45
  int neg = 1;
 452:	4805                	li	a6,1
  if (*s == '-') {
 454:	04f70363          	beq	a4,a5,49a <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 458:	00054683          	lbu	a3,0(a0)
 45c:	fd06879b          	addiw	a5,a3,-48
 460:	0ff7f793          	andi	a5,a5,255
 464:	4725                	li	a4,9
 466:	02f76d63          	bltu	a4,a5,4a0 <atoi+0x5c>
  n = 0;
 46a:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 46c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 46e:	0505                	addi	a0,a0,1
 470:	0026179b          	slliw	a5,a2,0x2
 474:	9fb1                	addw	a5,a5,a2
 476:	0017979b          	slliw	a5,a5,0x1
 47a:	9fb5                	addw	a5,a5,a3
 47c:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 480:	00054683          	lbu	a3,0(a0)
 484:	fd06871b          	addiw	a4,a3,-48
 488:	0ff77713          	andi	a4,a4,255
 48c:	fee5f1e3          	bgeu	a1,a4,46e <atoi+0x2a>
  return n * neg;
}
 490:	02c8053b          	mulw	a0,a6,a2
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret
    s++;
 49a:	0505                	addi	a0,a0,1
    neg = -1;
 49c:	587d                	li	a6,-1
 49e:	bf6d                	j	458 <atoi+0x14>
  n = 0;
 4a0:	4601                	li	a2,0
 4a2:	b7fd                	j	490 <atoi+0x4c>

00000000000004a4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4a4:	1141                	addi	sp,sp,-16
 4a6:	e422                	sd	s0,8(sp)
 4a8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4aa:	02b57463          	bgeu	a0,a1,4d2 <memmove+0x2e>
    while(n-- > 0)
 4ae:	00c05f63          	blez	a2,4cc <memmove+0x28>
 4b2:	1602                	slli	a2,a2,0x20
 4b4:	9201                	srli	a2,a2,0x20
 4b6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4ba:	872a                	mv	a4,a0
      *dst++ = *src++;
 4bc:	0585                	addi	a1,a1,1
 4be:	0705                	addi	a4,a4,1
 4c0:	fff5c683          	lbu	a3,-1(a1)
 4c4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4c8:	fee79ae3          	bne	a5,a4,4bc <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4cc:	6422                	ld	s0,8(sp)
 4ce:	0141                	addi	sp,sp,16
 4d0:	8082                	ret
    dst += n;
 4d2:	00c50733          	add	a4,a0,a2
    src += n;
 4d6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4d8:	fec05ae3          	blez	a2,4cc <memmove+0x28>
 4dc:	fff6079b          	addiw	a5,a2,-1
 4e0:	1782                	slli	a5,a5,0x20
 4e2:	9381                	srli	a5,a5,0x20
 4e4:	fff7c793          	not	a5,a5
 4e8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4ea:	15fd                	addi	a1,a1,-1
 4ec:	177d                	addi	a4,a4,-1
 4ee:	0005c683          	lbu	a3,0(a1)
 4f2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4f6:	fee79ae3          	bne	a5,a4,4ea <memmove+0x46>
 4fa:	bfc9                	j	4cc <memmove+0x28>

00000000000004fc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4fc:	1141                	addi	sp,sp,-16
 4fe:	e422                	sd	s0,8(sp)
 500:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 502:	ca05                	beqz	a2,532 <memcmp+0x36>
 504:	fff6069b          	addiw	a3,a2,-1
 508:	1682                	slli	a3,a3,0x20
 50a:	9281                	srli	a3,a3,0x20
 50c:	0685                	addi	a3,a3,1
 50e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 510:	00054783          	lbu	a5,0(a0)
 514:	0005c703          	lbu	a4,0(a1)
 518:	00e79863          	bne	a5,a4,528 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 51c:	0505                	addi	a0,a0,1
    p2++;
 51e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 520:	fed518e3          	bne	a0,a3,510 <memcmp+0x14>
  }
  return 0;
 524:	4501                	li	a0,0
 526:	a019                	j	52c <memcmp+0x30>
      return *p1 - *p2;
 528:	40e7853b          	subw	a0,a5,a4
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret
  return 0;
 532:	4501                	li	a0,0
 534:	bfe5                	j	52c <memcmp+0x30>

0000000000000536 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 536:	1141                	addi	sp,sp,-16
 538:	e406                	sd	ra,8(sp)
 53a:	e022                	sd	s0,0(sp)
 53c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 53e:	00000097          	auipc	ra,0x0
 542:	f66080e7          	jalr	-154(ra) # 4a4 <memmove>
}
 546:	60a2                	ld	ra,8(sp)
 548:	6402                	ld	s0,0(sp)
 54a:	0141                	addi	sp,sp,16
 54c:	8082                	ret

000000000000054e <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 54e:	4885                	li	a7,1
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <exit>:
.global exit
exit:
 li a7, SYS_exit
 556:	4889                	li	a7,2
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <wait>:
.global wait
wait:
 li a7, SYS_wait
 55e:	488d                	li	a7,3
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 566:	4891                	li	a7,4
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <read>:
.global read
read:
 li a7, SYS_read
 56e:	4895                	li	a7,5
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <write>:
.global write
write:
 li a7, SYS_write
 576:	48c1                	li	a7,16
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <close>:
.global close
close:
 li a7, SYS_close
 57e:	48d5                	li	a7,21
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <kill>:
.global kill
kill:
 li a7, SYS_kill
 586:	4899                	li	a7,6
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <exec>:
.global exec
exec:
 li a7, SYS_exec
 58e:	489d                	li	a7,7
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <open>:
.global open
open:
 li a7, SYS_open
 596:	48bd                	li	a7,15
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 59e:	48a1                	li	a7,8
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5a6:	48d1                	li	a7,20
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5ae:	48a5                	li	a7,9
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5b6:	48a9                	li	a7,10
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5be:	48ad                	li	a7,11
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5c6:	48b1                	li	a7,12
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ce:	48b5                	li	a7,13
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5d6:	48b9                	li	a7,14
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 5de:	48d9                	li	a7,22
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <dev>:
.global dev
dev:
 li a7, SYS_dev
 5e6:	48dd                	li	a7,23
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 5ee:	48e1                	li	a7,24
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 5f6:	48e5                	li	a7,25
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <remove>:
.global remove
remove:
 li a7, SYS_remove
 5fe:	48c5                	li	a7,17
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <trace>:
.global trace
trace:
 li a7, SYS_trace
 606:	48c9                	li	a7,18
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 60e:	48cd                	li	a7,19
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <rename>:
.global rename
rename:
 li a7, SYS_rename
 616:	48e9                	li	a7,26
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 61e:	1101                	addi	sp,sp,-32
 620:	ec06                	sd	ra,24(sp)
 622:	e822                	sd	s0,16(sp)
 624:	1000                	addi	s0,sp,32
 626:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 62a:	4605                	li	a2,1
 62c:	fef40593          	addi	a1,s0,-17
 630:	00000097          	auipc	ra,0x0
 634:	f46080e7          	jalr	-186(ra) # 576 <write>
}
 638:	60e2                	ld	ra,24(sp)
 63a:	6442                	ld	s0,16(sp)
 63c:	6105                	addi	sp,sp,32
 63e:	8082                	ret

0000000000000640 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 640:	7139                	addi	sp,sp,-64
 642:	fc06                	sd	ra,56(sp)
 644:	f822                	sd	s0,48(sp)
 646:	f426                	sd	s1,40(sp)
 648:	f04a                	sd	s2,32(sp)
 64a:	ec4e                	sd	s3,24(sp)
 64c:	0080                	addi	s0,sp,64
 64e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 650:	c299                	beqz	a3,656 <printint+0x16>
 652:	0805c763          	bltz	a1,6e0 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 656:	2581                	sext.w	a1,a1
  neg = 0;
 658:	4881                	li	a7,0
  }

  i = 0;
 65a:	fc040993          	addi	s3,s0,-64
  neg = 0;
 65e:	86ce                	mv	a3,s3
  i = 0;
 660:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 662:	2601                	sext.w	a2,a2
 664:	00000517          	auipc	a0,0x0
 668:	47c50513          	addi	a0,a0,1148 # ae0 <digits>
 66c:	883a                	mv	a6,a4
 66e:	2705                	addiw	a4,a4,1
 670:	02c5f7bb          	remuw	a5,a1,a2
 674:	1782                	slli	a5,a5,0x20
 676:	9381                	srli	a5,a5,0x20
 678:	97aa                	add	a5,a5,a0
 67a:	0007c783          	lbu	a5,0(a5)
 67e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 682:	0005879b          	sext.w	a5,a1
 686:	02c5d5bb          	divuw	a1,a1,a2
 68a:	0685                	addi	a3,a3,1
 68c:	fec7f0e3          	bgeu	a5,a2,66c <printint+0x2c>
  if(neg)
 690:	00088b63          	beqz	a7,6a6 <printint+0x66>
    buf[i++] = '-';
 694:	fd040793          	addi	a5,s0,-48
 698:	973e                	add	a4,a4,a5
 69a:	02d00793          	li	a5,45
 69e:	fef70823          	sb	a5,-16(a4)
 6a2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6a6:	02e05663          	blez	a4,6d2 <printint+0x92>
 6aa:	fc040913          	addi	s2,s0,-64
 6ae:	993a                	add	s2,s2,a4
 6b0:	19fd                	addi	s3,s3,-1
 6b2:	99ba                	add	s3,s3,a4
 6b4:	377d                	addiw	a4,a4,-1
 6b6:	1702                	slli	a4,a4,0x20
 6b8:	9301                	srli	a4,a4,0x20
 6ba:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6be:	fff94583          	lbu	a1,-1(s2)
 6c2:	8526                	mv	a0,s1
 6c4:	00000097          	auipc	ra,0x0
 6c8:	f5a080e7          	jalr	-166(ra) # 61e <putc>
  while(--i >= 0)
 6cc:	197d                	addi	s2,s2,-1
 6ce:	ff3918e3          	bne	s2,s3,6be <printint+0x7e>
}
 6d2:	70e2                	ld	ra,56(sp)
 6d4:	7442                	ld	s0,48(sp)
 6d6:	74a2                	ld	s1,40(sp)
 6d8:	7902                	ld	s2,32(sp)
 6da:	69e2                	ld	s3,24(sp)
 6dc:	6121                	addi	sp,sp,64
 6de:	8082                	ret
    x = -xx;
 6e0:	40b005bb          	negw	a1,a1
    neg = 1;
 6e4:	4885                	li	a7,1
    x = -xx;
 6e6:	bf95                	j	65a <printint+0x1a>

00000000000006e8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6e8:	7119                	addi	sp,sp,-128
 6ea:	fc86                	sd	ra,120(sp)
 6ec:	f8a2                	sd	s0,112(sp)
 6ee:	f4a6                	sd	s1,104(sp)
 6f0:	f0ca                	sd	s2,96(sp)
 6f2:	ecce                	sd	s3,88(sp)
 6f4:	e8d2                	sd	s4,80(sp)
 6f6:	e4d6                	sd	s5,72(sp)
 6f8:	e0da                	sd	s6,64(sp)
 6fa:	fc5e                	sd	s7,56(sp)
 6fc:	f862                	sd	s8,48(sp)
 6fe:	f466                	sd	s9,40(sp)
 700:	f06a                	sd	s10,32(sp)
 702:	ec6e                	sd	s11,24(sp)
 704:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 706:	0005c903          	lbu	s2,0(a1)
 70a:	18090f63          	beqz	s2,8a8 <vprintf+0x1c0>
 70e:	8aaa                	mv	s5,a0
 710:	8b32                	mv	s6,a2
 712:	00158493          	addi	s1,a1,1
  state = 0;
 716:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 718:	02500a13          	li	s4,37
      if(c == 'd'){
 71c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 720:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 724:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 728:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 72c:	00000b97          	auipc	s7,0x0
 730:	3b4b8b93          	addi	s7,s7,948 # ae0 <digits>
 734:	a839                	j	752 <vprintf+0x6a>
        putc(fd, c);
 736:	85ca                	mv	a1,s2
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	ee4080e7          	jalr	-284(ra) # 61e <putc>
 742:	a019                	j	748 <vprintf+0x60>
    } else if(state == '%'){
 744:	01498f63          	beq	s3,s4,762 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 748:	0485                	addi	s1,s1,1
 74a:	fff4c903          	lbu	s2,-1(s1)
 74e:	14090d63          	beqz	s2,8a8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 752:	0009079b          	sext.w	a5,s2
    if(state == 0){
 756:	fe0997e3          	bnez	s3,744 <vprintf+0x5c>
      if(c == '%'){
 75a:	fd479ee3          	bne	a5,s4,736 <vprintf+0x4e>
        state = '%';
 75e:	89be                	mv	s3,a5
 760:	b7e5                	j	748 <vprintf+0x60>
      if(c == 'd'){
 762:	05878063          	beq	a5,s8,7a2 <vprintf+0xba>
      } else if(c == 'l') {
 766:	05978c63          	beq	a5,s9,7be <vprintf+0xd6>
      } else if(c == 'x') {
 76a:	07a78863          	beq	a5,s10,7da <vprintf+0xf2>
      } else if(c == 'p') {
 76e:	09b78463          	beq	a5,s11,7f6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 772:	07300713          	li	a4,115
 776:	0ce78663          	beq	a5,a4,842 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 77a:	06300713          	li	a4,99
 77e:	0ee78e63          	beq	a5,a4,87a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 782:	11478863          	beq	a5,s4,892 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 786:	85d2                	mv	a1,s4
 788:	8556                	mv	a0,s5
 78a:	00000097          	auipc	ra,0x0
 78e:	e94080e7          	jalr	-364(ra) # 61e <putc>
        putc(fd, c);
 792:	85ca                	mv	a1,s2
 794:	8556                	mv	a0,s5
 796:	00000097          	auipc	ra,0x0
 79a:	e88080e7          	jalr	-376(ra) # 61e <putc>
      }
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	b765                	j	748 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7a2:	008b0913          	addi	s2,s6,8
 7a6:	4685                	li	a3,1
 7a8:	4629                	li	a2,10
 7aa:	000b2583          	lw	a1,0(s6)
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	e90080e7          	jalr	-368(ra) # 640 <printint>
 7b8:	8b4a                	mv	s6,s2
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	b771                	j	748 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7be:	008b0913          	addi	s2,s6,8
 7c2:	4681                	li	a3,0
 7c4:	4629                	li	a2,10
 7c6:	000b2583          	lw	a1,0(s6)
 7ca:	8556                	mv	a0,s5
 7cc:	00000097          	auipc	ra,0x0
 7d0:	e74080e7          	jalr	-396(ra) # 640 <printint>
 7d4:	8b4a                	mv	s6,s2
      state = 0;
 7d6:	4981                	li	s3,0
 7d8:	bf85                	j	748 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7da:	008b0913          	addi	s2,s6,8
 7de:	4681                	li	a3,0
 7e0:	4641                	li	a2,16
 7e2:	000b2583          	lw	a1,0(s6)
 7e6:	8556                	mv	a0,s5
 7e8:	00000097          	auipc	ra,0x0
 7ec:	e58080e7          	jalr	-424(ra) # 640 <printint>
 7f0:	8b4a                	mv	s6,s2
      state = 0;
 7f2:	4981                	li	s3,0
 7f4:	bf91                	j	748 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7f6:	008b0793          	addi	a5,s6,8
 7fa:	f8f43423          	sd	a5,-120(s0)
 7fe:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 802:	03000593          	li	a1,48
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	e16080e7          	jalr	-490(ra) # 61e <putc>
  putc(fd, 'x');
 810:	85ea                	mv	a1,s10
 812:	8556                	mv	a0,s5
 814:	00000097          	auipc	ra,0x0
 818:	e0a080e7          	jalr	-502(ra) # 61e <putc>
 81c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 81e:	03c9d793          	srli	a5,s3,0x3c
 822:	97de                	add	a5,a5,s7
 824:	0007c583          	lbu	a1,0(a5)
 828:	8556                	mv	a0,s5
 82a:	00000097          	auipc	ra,0x0
 82e:	df4080e7          	jalr	-524(ra) # 61e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 832:	0992                	slli	s3,s3,0x4
 834:	397d                	addiw	s2,s2,-1
 836:	fe0914e3          	bnez	s2,81e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 83a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 83e:	4981                	li	s3,0
 840:	b721                	j	748 <vprintf+0x60>
        s = va_arg(ap, char*);
 842:	008b0993          	addi	s3,s6,8
 846:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 84a:	02090163          	beqz	s2,86c <vprintf+0x184>
        while(*s != 0){
 84e:	00094583          	lbu	a1,0(s2)
 852:	c9a1                	beqz	a1,8a2 <vprintf+0x1ba>
          putc(fd, *s);
 854:	8556                	mv	a0,s5
 856:	00000097          	auipc	ra,0x0
 85a:	dc8080e7          	jalr	-568(ra) # 61e <putc>
          s++;
 85e:	0905                	addi	s2,s2,1
        while(*s != 0){
 860:	00094583          	lbu	a1,0(s2)
 864:	f9e5                	bnez	a1,854 <vprintf+0x16c>
        s = va_arg(ap, char*);
 866:	8b4e                	mv	s6,s3
      state = 0;
 868:	4981                	li	s3,0
 86a:	bdf9                	j	748 <vprintf+0x60>
          s = "(null)";
 86c:	00000917          	auipc	s2,0x0
 870:	26c90913          	addi	s2,s2,620 # ad8 <malloc+0x126>
        while(*s != 0){
 874:	02800593          	li	a1,40
 878:	bff1                	j	854 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 87a:	008b0913          	addi	s2,s6,8
 87e:	000b4583          	lbu	a1,0(s6)
 882:	8556                	mv	a0,s5
 884:	00000097          	auipc	ra,0x0
 888:	d9a080e7          	jalr	-614(ra) # 61e <putc>
 88c:	8b4a                	mv	s6,s2
      state = 0;
 88e:	4981                	li	s3,0
 890:	bd65                	j	748 <vprintf+0x60>
        putc(fd, c);
 892:	85d2                	mv	a1,s4
 894:	8556                	mv	a0,s5
 896:	00000097          	auipc	ra,0x0
 89a:	d88080e7          	jalr	-632(ra) # 61e <putc>
      state = 0;
 89e:	4981                	li	s3,0
 8a0:	b565                	j	748 <vprintf+0x60>
        s = va_arg(ap, char*);
 8a2:	8b4e                	mv	s6,s3
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b54d                	j	748 <vprintf+0x60>
    }
  }
}
 8a8:	70e6                	ld	ra,120(sp)
 8aa:	7446                	ld	s0,112(sp)
 8ac:	74a6                	ld	s1,104(sp)
 8ae:	7906                	ld	s2,96(sp)
 8b0:	69e6                	ld	s3,88(sp)
 8b2:	6a46                	ld	s4,80(sp)
 8b4:	6aa6                	ld	s5,72(sp)
 8b6:	6b06                	ld	s6,64(sp)
 8b8:	7be2                	ld	s7,56(sp)
 8ba:	7c42                	ld	s8,48(sp)
 8bc:	7ca2                	ld	s9,40(sp)
 8be:	7d02                	ld	s10,32(sp)
 8c0:	6de2                	ld	s11,24(sp)
 8c2:	6109                	addi	sp,sp,128
 8c4:	8082                	ret

00000000000008c6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8c6:	715d                	addi	sp,sp,-80
 8c8:	ec06                	sd	ra,24(sp)
 8ca:	e822                	sd	s0,16(sp)
 8cc:	1000                	addi	s0,sp,32
 8ce:	e010                	sd	a2,0(s0)
 8d0:	e414                	sd	a3,8(s0)
 8d2:	e818                	sd	a4,16(s0)
 8d4:	ec1c                	sd	a5,24(s0)
 8d6:	03043023          	sd	a6,32(s0)
 8da:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8de:	8622                	mv	a2,s0
 8e0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8e4:	00000097          	auipc	ra,0x0
 8e8:	e04080e7          	jalr	-508(ra) # 6e8 <vprintf>
}
 8ec:	60e2                	ld	ra,24(sp)
 8ee:	6442                	ld	s0,16(sp)
 8f0:	6161                	addi	sp,sp,80
 8f2:	8082                	ret

00000000000008f4 <printf>:

void
printf(const char *fmt, ...)
{
 8f4:	711d                	addi	sp,sp,-96
 8f6:	ec06                	sd	ra,24(sp)
 8f8:	e822                	sd	s0,16(sp)
 8fa:	1000                	addi	s0,sp,32
 8fc:	e40c                	sd	a1,8(s0)
 8fe:	e810                	sd	a2,16(s0)
 900:	ec14                	sd	a3,24(s0)
 902:	f018                	sd	a4,32(s0)
 904:	f41c                	sd	a5,40(s0)
 906:	03043823          	sd	a6,48(s0)
 90a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 90e:	00840613          	addi	a2,s0,8
 912:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 916:	85aa                	mv	a1,a0
 918:	4505                	li	a0,1
 91a:	00000097          	auipc	ra,0x0
 91e:	dce080e7          	jalr	-562(ra) # 6e8 <vprintf>
}
 922:	60e2                	ld	ra,24(sp)
 924:	6442                	ld	s0,16(sp)
 926:	6125                	addi	sp,sp,96
 928:	8082                	ret

000000000000092a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 92a:	1141                	addi	sp,sp,-16
 92c:	e422                	sd	s0,8(sp)
 92e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 930:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 934:	00000797          	auipc	a5,0x0
 938:	5c47b783          	ld	a5,1476(a5) # ef8 <freep>
 93c:	a805                	j	96c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 93e:	4618                	lw	a4,8(a2)
 940:	9db9                	addw	a1,a1,a4
 942:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 946:	6398                	ld	a4,0(a5)
 948:	6318                	ld	a4,0(a4)
 94a:	fee53823          	sd	a4,-16(a0)
 94e:	a091                	j	992 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 950:	ff852703          	lw	a4,-8(a0)
 954:	9e39                	addw	a2,a2,a4
 956:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 958:	ff053703          	ld	a4,-16(a0)
 95c:	e398                	sd	a4,0(a5)
 95e:	a099                	j	9a4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 960:	6398                	ld	a4,0(a5)
 962:	00e7e463          	bltu	a5,a4,96a <free+0x40>
 966:	00e6ea63          	bltu	a3,a4,97a <free+0x50>
{
 96a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 96c:	fed7fae3          	bgeu	a5,a3,960 <free+0x36>
 970:	6398                	ld	a4,0(a5)
 972:	00e6e463          	bltu	a3,a4,97a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 976:	fee7eae3          	bltu	a5,a4,96a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 97a:	ff852583          	lw	a1,-8(a0)
 97e:	6390                	ld	a2,0(a5)
 980:	02059713          	slli	a4,a1,0x20
 984:	9301                	srli	a4,a4,0x20
 986:	0712                	slli	a4,a4,0x4
 988:	9736                	add	a4,a4,a3
 98a:	fae60ae3          	beq	a2,a4,93e <free+0x14>
    bp->s.ptr = p->s.ptr;
 98e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 992:	4790                	lw	a2,8(a5)
 994:	02061713          	slli	a4,a2,0x20
 998:	9301                	srli	a4,a4,0x20
 99a:	0712                	slli	a4,a4,0x4
 99c:	973e                	add	a4,a4,a5
 99e:	fae689e3          	beq	a3,a4,950 <free+0x26>
  } else
    p->s.ptr = bp;
 9a2:	e394                	sd	a3,0(a5)
  freep = p;
 9a4:	00000717          	auipc	a4,0x0
 9a8:	54f73a23          	sd	a5,1364(a4) # ef8 <freep>
}
 9ac:	6422                	ld	s0,8(sp)
 9ae:	0141                	addi	sp,sp,16
 9b0:	8082                	ret

00000000000009b2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b2:	7139                	addi	sp,sp,-64
 9b4:	fc06                	sd	ra,56(sp)
 9b6:	f822                	sd	s0,48(sp)
 9b8:	f426                	sd	s1,40(sp)
 9ba:	f04a                	sd	s2,32(sp)
 9bc:	ec4e                	sd	s3,24(sp)
 9be:	e852                	sd	s4,16(sp)
 9c0:	e456                	sd	s5,8(sp)
 9c2:	e05a                	sd	s6,0(sp)
 9c4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c6:	02051493          	slli	s1,a0,0x20
 9ca:	9081                	srli	s1,s1,0x20
 9cc:	04bd                	addi	s1,s1,15
 9ce:	8091                	srli	s1,s1,0x4
 9d0:	0014899b          	addiw	s3,s1,1
 9d4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9d6:	00000517          	auipc	a0,0x0
 9da:	52253503          	ld	a0,1314(a0) # ef8 <freep>
 9de:	c515                	beqz	a0,a0a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e2:	4798                	lw	a4,8(a5)
 9e4:	04977163          	bgeu	a4,s1,a26 <malloc+0x74>
 9e8:	8a4e                	mv	s4,s3
 9ea:	0009871b          	sext.w	a4,s3
 9ee:	6685                	lui	a3,0x1
 9f0:	00d77363          	bgeu	a4,a3,9f6 <malloc+0x44>
 9f4:	6a05                	lui	s4,0x1
 9f6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9fa:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9fe:	00000917          	auipc	s2,0x0
 a02:	4fa90913          	addi	s2,s2,1274 # ef8 <freep>
  if(p == (char*)-1)
 a06:	5afd                	li	s5,-1
 a08:	a89d                	j	a7e <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 a0a:	00000797          	auipc	a5,0x0
 a0e:	4ee78793          	addi	a5,a5,1262 # ef8 <freep>
 a12:	00000717          	auipc	a4,0x0
 a16:	4ee70713          	addi	a4,a4,1262 # f00 <base>
 a1a:	e398                	sd	a4,0(a5)
 a1c:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 a1e:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a22:	87ba                	mv	a5,a4
 a24:	b7d1                	j	9e8 <malloc+0x36>
      if(p->s.size == nunits)
 a26:	02e48b63          	beq	s1,a4,a5c <malloc+0xaa>
        p->s.size -= nunits;
 a2a:	4137073b          	subw	a4,a4,s3
 a2e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a30:	1702                	slli	a4,a4,0x20
 a32:	9301                	srli	a4,a4,0x20
 a34:	0712                	slli	a4,a4,0x4
 a36:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a38:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a3c:	00000717          	auipc	a4,0x0
 a40:	4aa73e23          	sd	a0,1212(a4) # ef8 <freep>
      return (void*)(p + 1);
 a44:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a48:	70e2                	ld	ra,56(sp)
 a4a:	7442                	ld	s0,48(sp)
 a4c:	74a2                	ld	s1,40(sp)
 a4e:	7902                	ld	s2,32(sp)
 a50:	69e2                	ld	s3,24(sp)
 a52:	6a42                	ld	s4,16(sp)
 a54:	6aa2                	ld	s5,8(sp)
 a56:	6b02                	ld	s6,0(sp)
 a58:	6121                	addi	sp,sp,64
 a5a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a5c:	6398                	ld	a4,0(a5)
 a5e:	e118                	sd	a4,0(a0)
 a60:	bff1                	j	a3c <malloc+0x8a>
  hp->s.size = nu;
 a62:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a66:	0541                	addi	a0,a0,16
 a68:	00000097          	auipc	ra,0x0
 a6c:	ec2080e7          	jalr	-318(ra) # 92a <free>
  return freep;
 a70:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a74:	d971                	beqz	a0,a48 <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a76:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a78:	4798                	lw	a4,8(a5)
 a7a:	fa9776e3          	bgeu	a4,s1,a26 <malloc+0x74>
    if(p == freep)
 a7e:	00093703          	ld	a4,0(s2)
 a82:	853e                	mv	a0,a5
 a84:	fef719e3          	bne	a4,a5,a76 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 a88:	8552                	mv	a0,s4
 a8a:	00000097          	auipc	ra,0x0
 a8e:	b3c080e7          	jalr	-1220(ra) # 5c6 <sbrk>
  if(p == (char*)-1)
 a92:	fd5518e3          	bne	a0,s5,a62 <malloc+0xb0>
        return 0;
 a96:	4501                	li	a0,0
 a98:	bf45                	j	a48 <malloc+0x96>
