
xv6-user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <readline>:
/**
 * len:    include the 0 in the end.
 * return: the number of bytes that read successfully (0 in the end is not included)
 */
int readline(int fd, char *buf, int len)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  12:	89aa                	mv	s3,a0
  14:	892e                	mv	s2,a1
    char *p = buf;
  16:	84ae                	mv	s1,a1
    while (read(fd, p, 1) != 0 && p < buf + len) {
  18:	00c58a33          	add	s4,a1,a2
        if (*p == '\n') {
  1c:	4aa9                	li	s5,10
    while (read(fd, p, 1) != 0 && p < buf + len) {
  1e:	a011                	j	22 <readline+0x22>
                continue;
            }
            *p = '\0';
            break;
        }
        p++;
  20:	0485                	addi	s1,s1,1
    while (read(fd, p, 1) != 0 && p < buf + len) {
  22:	4605                	li	a2,1
  24:	85a6                	mv	a1,s1
  26:	854e                	mv	a0,s3
  28:	00000097          	auipc	ra,0x0
  2c:	456080e7          	jalr	1110(ra) # 47e <read>
  30:	c905                	beqz	a0,60 <readline+0x60>
  32:	0344f763          	bgeu	s1,s4,60 <readline+0x60>
        if (*p == '\n') {
  36:	0004c783          	lbu	a5,0(s1)
  3a:	ff5793e3          	bne	a5,s5,20 <readline+0x20>
            if (p == buf) {     // ignore empty line
  3e:	01248f63          	beq	s1,s2,5c <readline+0x5c>
            *p = '\0';
  42:	00048023          	sb	zero,0(s1)
    }
    if (p == buf) {
        return 0;
    }
    return p - buf;
  46:	4124853b          	subw	a0,s1,s2
}
  4a:	70e2                	ld	ra,56(sp)
  4c:	7442                	ld	s0,48(sp)
  4e:	74a2                	ld	s1,40(sp)
  50:	7902                	ld	s2,32(sp)
  52:	69e2                	ld	s3,24(sp)
  54:	6a42                	ld	s4,16(sp)
  56:	6aa2                	ld	s5,8(sp)
  58:	6121                	addi	sp,sp,64
  5a:	8082                	ret
  5c:	84ca                	mv	s1,s2
  5e:	b7d1                	j	22 <readline+0x22>
        return 0;
  60:	4501                	li	a0,0
    if (p == buf) {
  62:	ff2484e3          	beq	s1,s2,4a <readline+0x4a>
  66:	b7c5                	j	46 <readline+0x46>

0000000000000068 <main>:

int main(int argc, char *argv[])
{
  68:	7161                	addi	sp,sp,-432
  6a:	f706                	sd	ra,424(sp)
  6c:	f322                	sd	s0,416(sp)
  6e:	ef26                	sd	s1,408(sp)
  70:	eb4a                	sd	s2,400(sp)
  72:	e74e                	sd	s3,392(sp)
  74:	1b00                	addi	s0,sp,432
    if (argc < 2) {
  76:	4785                	li	a5,1
  78:	08a7dd63          	bge	a5,a0,112 <main+0xaa>
  7c:	84aa                	mv	s1,a0
  7e:	892e                	mv	s2,a1
  80:	00858713          	addi	a4,a1,8
  84:	ed040793          	addi	a5,s0,-304
  88:	0005059b          	sext.w	a1,a0
  8c:	ffe5061b          	addiw	a2,a0,-2
  90:	1602                	slli	a2,a2,0x20
  92:	9201                	srli	a2,a2,0x20
  94:	060e                	slli	a2,a2,0x3
  96:	ed840693          	addi	a3,s0,-296
  9a:	9636                	add	a2,a2,a3
    }
    char *argvs[MAXARG];
    char buf[128];
    int i;
    for (i = 1; i < argc; i++) {
        argvs[i - 1] = argv[i];         // argvs[0] = COMMAND
  9c:	6314                	ld	a3,0(a4)
  9e:	e394                	sd	a3,0(a5)
    for (i = 1; i < argc; i++) {
  a0:	0721                	addi	a4,a4,8
  a2:	07a1                	addi	a5,a5,8
  a4:	fec79ce3          	bne	a5,a2,9c <main+0x34>
  a8:	fff5899b          	addiw	s3,a1,-1
    }
    i--;
    if (readline(0, buf, 128) == 0) {   // if there is no input
  ac:	08000613          	li	a2,128
  b0:	e5040593          	addi	a1,s0,-432
  b4:	4501                	li	a0,0
  b6:	00000097          	auipc	ra,0x0
  ba:	f4a080e7          	jalr	-182(ra) # 0 <readline>
  be:	c925                	beqz	a0,12e <main+0xc6>
            printf("xargs: exec %s fail\n", argv[1]);
            exit(0);
        }
        wait(0);
    } else {
        argvs[i] = buf;
  c0:	00399593          	slli	a1,s3,0x3
  c4:	fd040793          	addi	a5,s0,-48
  c8:	95be                	add	a1,a1,a5
  ca:	e5040793          	addi	a5,s0,-432
  ce:	f0f5b023          	sd	a5,-256(a1)
        argvs[i + 1] = 0;
  d2:	048e                	slli	s1,s1,0x3
  d4:	fd040793          	addi	a5,s0,-48
  d8:	94be                	add	s1,s1,a5
  da:	f004b023          	sd	zero,-256(s1)
                exec(argv[1], argvs);
                printf("xargs: exec %s fail\n", argv[1]);
                exit(0);
            }
            wait(0);
        } while (readline(0, buf, 128) != 0);
  de:	e5040493          	addi	s1,s0,-432
            if (fork() == 0) {
  e2:	00000097          	auipc	ra,0x0
  e6:	37c080e7          	jalr	892(ra) # 45e <fork>
  ea:	c959                	beqz	a0,180 <main+0x118>
            wait(0);
  ec:	4501                	li	a0,0
  ee:	00000097          	auipc	ra,0x0
  f2:	380080e7          	jalr	896(ra) # 46e <wait>
        } while (readline(0, buf, 128) != 0);
  f6:	08000613          	li	a2,128
  fa:	85a6                	mv	a1,s1
  fc:	4501                	li	a0,0
  fe:	00000097          	auipc	ra,0x0
 102:	f02080e7          	jalr	-254(ra) # 0 <readline>
 106:	fd71                	bnez	a0,e2 <main+0x7a>
    }
    exit(0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	35c080e7          	jalr	860(ra) # 466 <exit>
        fprintf(2, "Usage: xargs COMMAND [INITIAL-ARGS]...\n");
 112:	00001597          	auipc	a1,0x1
 116:	89e58593          	addi	a1,a1,-1890 # 9b0 <malloc+0xee>
 11a:	4509                	li	a0,2
 11c:	00000097          	auipc	ra,0x0
 120:	6ba080e7          	jalr	1722(ra) # 7d6 <fprintf>
        exit(-1);
 124:	557d                	li	a0,-1
 126:	00000097          	auipc	ra,0x0
 12a:	340080e7          	jalr	832(ra) # 466 <exit>
        argvs[i] = 0;
 12e:	00399593          	slli	a1,s3,0x3
 132:	fd040793          	addi	a5,s0,-48
 136:	95be                	add	a1,a1,a5
 138:	f005b023          	sd	zero,-256(a1)
        if (fork() == 0) {
 13c:	00000097          	auipc	ra,0x0
 140:	322080e7          	jalr	802(ra) # 45e <fork>
 144:	e905                	bnez	a0,174 <main+0x10c>
            exec(argv[1], argvs);
 146:	ed040593          	addi	a1,s0,-304
 14a:	00893503          	ld	a0,8(s2)
 14e:	00000097          	auipc	ra,0x0
 152:	350080e7          	jalr	848(ra) # 49e <exec>
            printf("xargs: exec %s fail\n", argv[1]);
 156:	00893583          	ld	a1,8(s2)
 15a:	00001517          	auipc	a0,0x1
 15e:	87e50513          	addi	a0,a0,-1922 # 9d8 <malloc+0x116>
 162:	00000097          	auipc	ra,0x0
 166:	6a2080e7          	jalr	1698(ra) # 804 <printf>
            exit(0);
 16a:	4501                	li	a0,0
 16c:	00000097          	auipc	ra,0x0
 170:	2fa080e7          	jalr	762(ra) # 466 <exit>
        wait(0);
 174:	4501                	li	a0,0
 176:	00000097          	auipc	ra,0x0
 17a:	2f8080e7          	jalr	760(ra) # 46e <wait>
 17e:	b769                	j	108 <main+0xa0>
                exec(argv[1], argvs);
 180:	ed040593          	addi	a1,s0,-304
 184:	00893503          	ld	a0,8(s2)
 188:	00000097          	auipc	ra,0x0
 18c:	316080e7          	jalr	790(ra) # 49e <exec>
                printf("xargs: exec %s fail\n", argv[1]);
 190:	00893583          	ld	a1,8(s2)
 194:	00001517          	auipc	a0,0x1
 198:	84450513          	addi	a0,a0,-1980 # 9d8 <malloc+0x116>
 19c:	00000097          	auipc	ra,0x0
 1a0:	668080e7          	jalr	1640(ra) # 804 <printf>
                exit(0);
 1a4:	4501                	li	a0,0
 1a6:	00000097          	auipc	ra,0x0
 1aa:	2c0080e7          	jalr	704(ra) # 466 <exit>

00000000000001ae <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
 1ae:	1141                	addi	sp,sp,-16
 1b0:	e422                	sd	s0,8(sp)
 1b2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b4:	87aa                	mv	a5,a0
 1b6:	0585                	addi	a1,a1,1
 1b8:	0785                	addi	a5,a5,1
 1ba:	fff5c703          	lbu	a4,-1(a1)
 1be:	fee78fa3          	sb	a4,-1(a5)
 1c2:	fb75                	bnez	a4,1b6 <strcpy+0x8>
    ;
  return os;
}
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <strcat>:

char*
strcat(char *s, const char *t)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 1d0:	00054783          	lbu	a5,0(a0)
 1d4:	c385                	beqz	a5,1f4 <strcat+0x2a>
 1d6:	87aa                	mv	a5,a0
    s++;
 1d8:	0785                	addi	a5,a5,1
  while(*s)
 1da:	0007c703          	lbu	a4,0(a5)
 1de:	ff6d                	bnez	a4,1d8 <strcat+0xe>
  while((*s++ = *t++))
 1e0:	0585                	addi	a1,a1,1
 1e2:	0785                	addi	a5,a5,1
 1e4:	fff5c703          	lbu	a4,-1(a1)
 1e8:	fee78fa3          	sb	a4,-1(a5)
 1ec:	fb75                	bnez	a4,1e0 <strcat+0x16>
    ;
  return os;
}
 1ee:	6422                	ld	s0,8(sp)
 1f0:	0141                	addi	sp,sp,16
 1f2:	8082                	ret
  while(*s)
 1f4:	87aa                	mv	a5,a0
 1f6:	b7ed                	j	1e0 <strcat+0x16>

00000000000001f8 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 1f8:	1141                	addi	sp,sp,-16
 1fa:	e422                	sd	s0,8(sp)
 1fc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1fe:	00054783          	lbu	a5,0(a0)
 202:	cb91                	beqz	a5,216 <strcmp+0x1e>
 204:	0005c703          	lbu	a4,0(a1)
 208:	00f71763          	bne	a4,a5,216 <strcmp+0x1e>
    p++, q++;
 20c:	0505                	addi	a0,a0,1
 20e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 210:	00054783          	lbu	a5,0(a0)
 214:	fbe5                	bnez	a5,204 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 216:	0005c503          	lbu	a0,0(a1)
}
 21a:	40a7853b          	subw	a0,a5,a0
 21e:	6422                	ld	s0,8(sp)
 220:	0141                	addi	sp,sp,16
 222:	8082                	ret

0000000000000224 <strlen>:

uint
strlen(const char *s)
{
 224:	1141                	addi	sp,sp,-16
 226:	e422                	sd	s0,8(sp)
 228:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 22a:	00054783          	lbu	a5,0(a0)
 22e:	cf91                	beqz	a5,24a <strlen+0x26>
 230:	0505                	addi	a0,a0,1
 232:	87aa                	mv	a5,a0
 234:	4685                	li	a3,1
 236:	9e89                	subw	a3,a3,a0
 238:	00f6853b          	addw	a0,a3,a5
 23c:	0785                	addi	a5,a5,1
 23e:	fff7c703          	lbu	a4,-1(a5)
 242:	fb7d                	bnez	a4,238 <strlen+0x14>
    ;
  return n;
}
 244:	6422                	ld	s0,8(sp)
 246:	0141                	addi	sp,sp,16
 248:	8082                	ret
  for(n = 0; s[n]; n++)
 24a:	4501                	li	a0,0
 24c:	bfe5                	j	244 <strlen+0x20>

000000000000024e <memset>:

void*
memset(void *dst, int c, uint n)
{
 24e:	1141                	addi	sp,sp,-16
 250:	e422                	sd	s0,8(sp)
 252:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 254:	ca19                	beqz	a2,26a <memset+0x1c>
 256:	87aa                	mv	a5,a0
 258:	1602                	slli	a2,a2,0x20
 25a:	9201                	srli	a2,a2,0x20
 25c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 260:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 264:	0785                	addi	a5,a5,1
 266:	fee79de3          	bne	a5,a4,260 <memset+0x12>
  }
  return dst;
}
 26a:	6422                	ld	s0,8(sp)
 26c:	0141                	addi	sp,sp,16
 26e:	8082                	ret

0000000000000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
  for(; *s; s++)
 276:	00054783          	lbu	a5,0(a0)
 27a:	cb99                	beqz	a5,290 <strchr+0x20>
    if(*s == c)
 27c:	00f58763          	beq	a1,a5,28a <strchr+0x1a>
  for(; *s; s++)
 280:	0505                	addi	a0,a0,1
 282:	00054783          	lbu	a5,0(a0)
 286:	fbfd                	bnez	a5,27c <strchr+0xc>
      return (char*)s;
  return 0;
 288:	4501                	li	a0,0
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret
  return 0;
 290:	4501                	li	a0,0
 292:	bfe5                	j	28a <strchr+0x1a>

0000000000000294 <gets>:

char*
gets(char *buf, int max)
{
 294:	711d                	addi	sp,sp,-96
 296:	ec86                	sd	ra,88(sp)
 298:	e8a2                	sd	s0,80(sp)
 29a:	e4a6                	sd	s1,72(sp)
 29c:	e0ca                	sd	s2,64(sp)
 29e:	fc4e                	sd	s3,56(sp)
 2a0:	f852                	sd	s4,48(sp)
 2a2:	f456                	sd	s5,40(sp)
 2a4:	f05a                	sd	s6,32(sp)
 2a6:	ec5e                	sd	s7,24(sp)
 2a8:	e862                	sd	s8,16(sp)
 2aa:	1080                	addi	s0,sp,96
 2ac:	8baa                	mv	s7,a0
 2ae:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b0:	892a                	mv	s2,a0
 2b2:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2b4:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2b8:	4b29                	li	s6,10
 2ba:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 2bc:	89a6                	mv	s3,s1
 2be:	2485                	addiw	s1,s1,1
 2c0:	0344d763          	bge	s1,s4,2ee <gets+0x5a>
    cc = read(0, &c, 1);
 2c4:	4605                	li	a2,1
 2c6:	85d6                	mv	a1,s5
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	1b4080e7          	jalr	436(ra) # 47e <read>
    if(cc < 1)
 2d2:	00a05e63          	blez	a0,2ee <gets+0x5a>
    buf[i++] = c;
 2d6:	faf44783          	lbu	a5,-81(s0)
 2da:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2de:	01678763          	beq	a5,s6,2ec <gets+0x58>
 2e2:	0905                	addi	s2,s2,1
 2e4:	fd879ce3          	bne	a5,s8,2bc <gets+0x28>
  for(i=0; i+1 < max; ){
 2e8:	89a6                	mv	s3,s1
 2ea:	a011                	j	2ee <gets+0x5a>
 2ec:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2ee:	99de                	add	s3,s3,s7
 2f0:	00098023          	sb	zero,0(s3)
  return buf;
}
 2f4:	855e                	mv	a0,s7
 2f6:	60e6                	ld	ra,88(sp)
 2f8:	6446                	ld	s0,80(sp)
 2fa:	64a6                	ld	s1,72(sp)
 2fc:	6906                	ld	s2,64(sp)
 2fe:	79e2                	ld	s3,56(sp)
 300:	7a42                	ld	s4,48(sp)
 302:	7aa2                	ld	s5,40(sp)
 304:	7b02                	ld	s6,32(sp)
 306:	6be2                	ld	s7,24(sp)
 308:	6c42                	ld	s8,16(sp)
 30a:	6125                	addi	sp,sp,96
 30c:	8082                	ret

000000000000030e <stat>:

int
stat(const char *n, struct stat *st)
{
 30e:	1101                	addi	sp,sp,-32
 310:	ec06                	sd	ra,24(sp)
 312:	e822                	sd	s0,16(sp)
 314:	e426                	sd	s1,8(sp)
 316:	e04a                	sd	s2,0(sp)
 318:	1000                	addi	s0,sp,32
 31a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 31c:	4581                	li	a1,0
 31e:	00000097          	auipc	ra,0x0
 322:	188080e7          	jalr	392(ra) # 4a6 <open>
  if(fd < 0)
 326:	02054563          	bltz	a0,350 <stat+0x42>
 32a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 32c:	85ca                	mv	a1,s2
 32e:	00000097          	auipc	ra,0x0
 332:	180080e7          	jalr	384(ra) # 4ae <fstat>
 336:	892a                	mv	s2,a0
  close(fd);
 338:	8526                	mv	a0,s1
 33a:	00000097          	auipc	ra,0x0
 33e:	154080e7          	jalr	340(ra) # 48e <close>
  return r;
}
 342:	854a                	mv	a0,s2
 344:	60e2                	ld	ra,24(sp)
 346:	6442                	ld	s0,16(sp)
 348:	64a2                	ld	s1,8(sp)
 34a:	6902                	ld	s2,0(sp)
 34c:	6105                	addi	sp,sp,32
 34e:	8082                	ret
    return -1;
 350:	597d                	li	s2,-1
 352:	bfc5                	j	342 <stat+0x34>

0000000000000354 <atoi>:

int
atoi(const char *s)
{
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 35a:	00054703          	lbu	a4,0(a0)
 35e:	02d00793          	li	a5,45
  int neg = 1;
 362:	4805                	li	a6,1
  if (*s == '-') {
 364:	04f70363          	beq	a4,a5,3aa <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 368:	00054683          	lbu	a3,0(a0)
 36c:	fd06879b          	addiw	a5,a3,-48
 370:	0ff7f793          	andi	a5,a5,255
 374:	4725                	li	a4,9
 376:	02f76d63          	bltu	a4,a5,3b0 <atoi+0x5c>
  n = 0;
 37a:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 37c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 37e:	0505                	addi	a0,a0,1
 380:	0026179b          	slliw	a5,a2,0x2
 384:	9fb1                	addw	a5,a5,a2
 386:	0017979b          	slliw	a5,a5,0x1
 38a:	9fb5                	addw	a5,a5,a3
 38c:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 390:	00054683          	lbu	a3,0(a0)
 394:	fd06871b          	addiw	a4,a3,-48
 398:	0ff77713          	andi	a4,a4,255
 39c:	fee5f1e3          	bgeu	a1,a4,37e <atoi+0x2a>
  return n * neg;
}
 3a0:	02c8053b          	mulw	a0,a6,a2
 3a4:	6422                	ld	s0,8(sp)
 3a6:	0141                	addi	sp,sp,16
 3a8:	8082                	ret
    s++;
 3aa:	0505                	addi	a0,a0,1
    neg = -1;
 3ac:	587d                	li	a6,-1
 3ae:	bf6d                	j	368 <atoi+0x14>
  n = 0;
 3b0:	4601                	li	a2,0
 3b2:	b7fd                	j	3a0 <atoi+0x4c>

00000000000003b4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b4:	1141                	addi	sp,sp,-16
 3b6:	e422                	sd	s0,8(sp)
 3b8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3ba:	02b57463          	bgeu	a0,a1,3e2 <memmove+0x2e>
    while(n-- > 0)
 3be:	00c05f63          	blez	a2,3dc <memmove+0x28>
 3c2:	1602                	slli	a2,a2,0x20
 3c4:	9201                	srli	a2,a2,0x20
 3c6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3ca:	872a                	mv	a4,a0
      *dst++ = *src++;
 3cc:	0585                	addi	a1,a1,1
 3ce:	0705                	addi	a4,a4,1
 3d0:	fff5c683          	lbu	a3,-1(a1)
 3d4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3d8:	fee79ae3          	bne	a5,a4,3cc <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	addi	sp,sp,16
 3e0:	8082                	ret
    dst += n;
 3e2:	00c50733          	add	a4,a0,a2
    src += n;
 3e6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3e8:	fec05ae3          	blez	a2,3dc <memmove+0x28>
 3ec:	fff6079b          	addiw	a5,a2,-1
 3f0:	1782                	slli	a5,a5,0x20
 3f2:	9381                	srli	a5,a5,0x20
 3f4:	fff7c793          	not	a5,a5
 3f8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3fa:	15fd                	addi	a1,a1,-1
 3fc:	177d                	addi	a4,a4,-1
 3fe:	0005c683          	lbu	a3,0(a1)
 402:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 406:	fee79ae3          	bne	a5,a4,3fa <memmove+0x46>
 40a:	bfc9                	j	3dc <memmove+0x28>

000000000000040c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 40c:	1141                	addi	sp,sp,-16
 40e:	e422                	sd	s0,8(sp)
 410:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 412:	ca05                	beqz	a2,442 <memcmp+0x36>
 414:	fff6069b          	addiw	a3,a2,-1
 418:	1682                	slli	a3,a3,0x20
 41a:	9281                	srli	a3,a3,0x20
 41c:	0685                	addi	a3,a3,1
 41e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 420:	00054783          	lbu	a5,0(a0)
 424:	0005c703          	lbu	a4,0(a1)
 428:	00e79863          	bne	a5,a4,438 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 42c:	0505                	addi	a0,a0,1
    p2++;
 42e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 430:	fed518e3          	bne	a0,a3,420 <memcmp+0x14>
  }
  return 0;
 434:	4501                	li	a0,0
 436:	a019                	j	43c <memcmp+0x30>
      return *p1 - *p2;
 438:	40e7853b          	subw	a0,a5,a4
}
 43c:	6422                	ld	s0,8(sp)
 43e:	0141                	addi	sp,sp,16
 440:	8082                	ret
  return 0;
 442:	4501                	li	a0,0
 444:	bfe5                	j	43c <memcmp+0x30>

0000000000000446 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 446:	1141                	addi	sp,sp,-16
 448:	e406                	sd	ra,8(sp)
 44a:	e022                	sd	s0,0(sp)
 44c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 44e:	00000097          	auipc	ra,0x0
 452:	f66080e7          	jalr	-154(ra) # 3b4 <memmove>
}
 456:	60a2                	ld	ra,8(sp)
 458:	6402                	ld	s0,0(sp)
 45a:	0141                	addi	sp,sp,16
 45c:	8082                	ret

000000000000045e <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 45e:	4885                	li	a7,1
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <exit>:
.global exit
exit:
 li a7, SYS_exit
 466:	4889                	li	a7,2
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <wait>:
.global wait
wait:
 li a7, SYS_wait
 46e:	488d                	li	a7,3
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 476:	4891                	li	a7,4
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <read>:
.global read
read:
 li a7, SYS_read
 47e:	4895                	li	a7,5
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <write>:
.global write
write:
 li a7, SYS_write
 486:	48c1                	li	a7,16
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <close>:
.global close
close:
 li a7, SYS_close
 48e:	48d5                	li	a7,21
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <kill>:
.global kill
kill:
 li a7, SYS_kill
 496:	4899                	li	a7,6
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <exec>:
.global exec
exec:
 li a7, SYS_exec
 49e:	489d                	li	a7,7
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <open>:
.global open
open:
 li a7, SYS_open
 4a6:	48bd                	li	a7,15
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4ae:	48a1                	li	a7,8
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4b6:	48d1                	li	a7,20
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4be:	48a5                	li	a7,9
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4c6:	48a9                	li	a7,10
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4ce:	48ad                	li	a7,11
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4d6:	48b1                	li	a7,12
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4de:	48b5                	li	a7,13
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4e6:	48b9                	li	a7,14
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 4ee:	48d9                	li	a7,22
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <dev>:
.global dev
dev:
 li a7, SYS_dev
 4f6:	48dd                	li	a7,23
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 4fe:	48e1                	li	a7,24
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 506:	48e5                	li	a7,25
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <remove>:
.global remove
remove:
 li a7, SYS_remove
 50e:	48c5                	li	a7,17
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <trace>:
.global trace
trace:
 li a7, SYS_trace
 516:	48c9                	li	a7,18
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 51e:	48cd                	li	a7,19
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <rename>:
.global rename
rename:
 li a7, SYS_rename
 526:	48e9                	li	a7,26
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 52e:	1101                	addi	sp,sp,-32
 530:	ec06                	sd	ra,24(sp)
 532:	e822                	sd	s0,16(sp)
 534:	1000                	addi	s0,sp,32
 536:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 53a:	4605                	li	a2,1
 53c:	fef40593          	addi	a1,s0,-17
 540:	00000097          	auipc	ra,0x0
 544:	f46080e7          	jalr	-186(ra) # 486 <write>
}
 548:	60e2                	ld	ra,24(sp)
 54a:	6442                	ld	s0,16(sp)
 54c:	6105                	addi	sp,sp,32
 54e:	8082                	ret

0000000000000550 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 550:	7139                	addi	sp,sp,-64
 552:	fc06                	sd	ra,56(sp)
 554:	f822                	sd	s0,48(sp)
 556:	f426                	sd	s1,40(sp)
 558:	f04a                	sd	s2,32(sp)
 55a:	ec4e                	sd	s3,24(sp)
 55c:	0080                	addi	s0,sp,64
 55e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 560:	c299                	beqz	a3,566 <printint+0x16>
 562:	0805c763          	bltz	a1,5f0 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 566:	2581                	sext.w	a1,a1
  neg = 0;
 568:	4881                	li	a7,0
  }

  i = 0;
 56a:	fc040993          	addi	s3,s0,-64
  neg = 0;
 56e:	86ce                	mv	a3,s3
  i = 0;
 570:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 572:	2601                	sext.w	a2,a2
 574:	00000517          	auipc	a0,0x0
 578:	48450513          	addi	a0,a0,1156 # 9f8 <digits>
 57c:	883a                	mv	a6,a4
 57e:	2705                	addiw	a4,a4,1
 580:	02c5f7bb          	remuw	a5,a1,a2
 584:	1782                	slli	a5,a5,0x20
 586:	9381                	srli	a5,a5,0x20
 588:	97aa                	add	a5,a5,a0
 58a:	0007c783          	lbu	a5,0(a5)
 58e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 592:	0005879b          	sext.w	a5,a1
 596:	02c5d5bb          	divuw	a1,a1,a2
 59a:	0685                	addi	a3,a3,1
 59c:	fec7f0e3          	bgeu	a5,a2,57c <printint+0x2c>
  if(neg)
 5a0:	00088b63          	beqz	a7,5b6 <printint+0x66>
    buf[i++] = '-';
 5a4:	fd040793          	addi	a5,s0,-48
 5a8:	973e                	add	a4,a4,a5
 5aa:	02d00793          	li	a5,45
 5ae:	fef70823          	sb	a5,-16(a4)
 5b2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5b6:	02e05663          	blez	a4,5e2 <printint+0x92>
 5ba:	fc040913          	addi	s2,s0,-64
 5be:	993a                	add	s2,s2,a4
 5c0:	19fd                	addi	s3,s3,-1
 5c2:	99ba                	add	s3,s3,a4
 5c4:	377d                	addiw	a4,a4,-1
 5c6:	1702                	slli	a4,a4,0x20
 5c8:	9301                	srli	a4,a4,0x20
 5ca:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5ce:	fff94583          	lbu	a1,-1(s2)
 5d2:	8526                	mv	a0,s1
 5d4:	00000097          	auipc	ra,0x0
 5d8:	f5a080e7          	jalr	-166(ra) # 52e <putc>
  while(--i >= 0)
 5dc:	197d                	addi	s2,s2,-1
 5de:	ff3918e3          	bne	s2,s3,5ce <printint+0x7e>
}
 5e2:	70e2                	ld	ra,56(sp)
 5e4:	7442                	ld	s0,48(sp)
 5e6:	74a2                	ld	s1,40(sp)
 5e8:	7902                	ld	s2,32(sp)
 5ea:	69e2                	ld	s3,24(sp)
 5ec:	6121                	addi	sp,sp,64
 5ee:	8082                	ret
    x = -xx;
 5f0:	40b005bb          	negw	a1,a1
    neg = 1;
 5f4:	4885                	li	a7,1
    x = -xx;
 5f6:	bf95                	j	56a <printint+0x1a>

00000000000005f8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5f8:	7119                	addi	sp,sp,-128
 5fa:	fc86                	sd	ra,120(sp)
 5fc:	f8a2                	sd	s0,112(sp)
 5fe:	f4a6                	sd	s1,104(sp)
 600:	f0ca                	sd	s2,96(sp)
 602:	ecce                	sd	s3,88(sp)
 604:	e8d2                	sd	s4,80(sp)
 606:	e4d6                	sd	s5,72(sp)
 608:	e0da                	sd	s6,64(sp)
 60a:	fc5e                	sd	s7,56(sp)
 60c:	f862                	sd	s8,48(sp)
 60e:	f466                	sd	s9,40(sp)
 610:	f06a                	sd	s10,32(sp)
 612:	ec6e                	sd	s11,24(sp)
 614:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 616:	0005c903          	lbu	s2,0(a1)
 61a:	18090f63          	beqz	s2,7b8 <vprintf+0x1c0>
 61e:	8aaa                	mv	s5,a0
 620:	8b32                	mv	s6,a2
 622:	00158493          	addi	s1,a1,1
  state = 0;
 626:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 628:	02500a13          	li	s4,37
      if(c == 'd'){
 62c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 630:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 634:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 638:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 63c:	00000b97          	auipc	s7,0x0
 640:	3bcb8b93          	addi	s7,s7,956 # 9f8 <digits>
 644:	a839                	j	662 <vprintf+0x6a>
        putc(fd, c);
 646:	85ca                	mv	a1,s2
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	ee4080e7          	jalr	-284(ra) # 52e <putc>
 652:	a019                	j	658 <vprintf+0x60>
    } else if(state == '%'){
 654:	01498f63          	beq	s3,s4,672 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 658:	0485                	addi	s1,s1,1
 65a:	fff4c903          	lbu	s2,-1(s1)
 65e:	14090d63          	beqz	s2,7b8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 662:	0009079b          	sext.w	a5,s2
    if(state == 0){
 666:	fe0997e3          	bnez	s3,654 <vprintf+0x5c>
      if(c == '%'){
 66a:	fd479ee3          	bne	a5,s4,646 <vprintf+0x4e>
        state = '%';
 66e:	89be                	mv	s3,a5
 670:	b7e5                	j	658 <vprintf+0x60>
      if(c == 'd'){
 672:	05878063          	beq	a5,s8,6b2 <vprintf+0xba>
      } else if(c == 'l') {
 676:	05978c63          	beq	a5,s9,6ce <vprintf+0xd6>
      } else if(c == 'x') {
 67a:	07a78863          	beq	a5,s10,6ea <vprintf+0xf2>
      } else if(c == 'p') {
 67e:	09b78463          	beq	a5,s11,706 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 682:	07300713          	li	a4,115
 686:	0ce78663          	beq	a5,a4,752 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 68a:	06300713          	li	a4,99
 68e:	0ee78e63          	beq	a5,a4,78a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 692:	11478863          	beq	a5,s4,7a2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 696:	85d2                	mv	a1,s4
 698:	8556                	mv	a0,s5
 69a:	00000097          	auipc	ra,0x0
 69e:	e94080e7          	jalr	-364(ra) # 52e <putc>
        putc(fd, c);
 6a2:	85ca                	mv	a1,s2
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	e88080e7          	jalr	-376(ra) # 52e <putc>
      }
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	b765                	j	658 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6b2:	008b0913          	addi	s2,s6,8
 6b6:	4685                	li	a3,1
 6b8:	4629                	li	a2,10
 6ba:	000b2583          	lw	a1,0(s6)
 6be:	8556                	mv	a0,s5
 6c0:	00000097          	auipc	ra,0x0
 6c4:	e90080e7          	jalr	-368(ra) # 550 <printint>
 6c8:	8b4a                	mv	s6,s2
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	b771                	j	658 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ce:	008b0913          	addi	s2,s6,8
 6d2:	4681                	li	a3,0
 6d4:	4629                	li	a2,10
 6d6:	000b2583          	lw	a1,0(s6)
 6da:	8556                	mv	a0,s5
 6dc:	00000097          	auipc	ra,0x0
 6e0:	e74080e7          	jalr	-396(ra) # 550 <printint>
 6e4:	8b4a                	mv	s6,s2
      state = 0;
 6e6:	4981                	li	s3,0
 6e8:	bf85                	j	658 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6ea:	008b0913          	addi	s2,s6,8
 6ee:	4681                	li	a3,0
 6f0:	4641                	li	a2,16
 6f2:	000b2583          	lw	a1,0(s6)
 6f6:	8556                	mv	a0,s5
 6f8:	00000097          	auipc	ra,0x0
 6fc:	e58080e7          	jalr	-424(ra) # 550 <printint>
 700:	8b4a                	mv	s6,s2
      state = 0;
 702:	4981                	li	s3,0
 704:	bf91                	j	658 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 706:	008b0793          	addi	a5,s6,8
 70a:	f8f43423          	sd	a5,-120(s0)
 70e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 712:	03000593          	li	a1,48
 716:	8556                	mv	a0,s5
 718:	00000097          	auipc	ra,0x0
 71c:	e16080e7          	jalr	-490(ra) # 52e <putc>
  putc(fd, 'x');
 720:	85ea                	mv	a1,s10
 722:	8556                	mv	a0,s5
 724:	00000097          	auipc	ra,0x0
 728:	e0a080e7          	jalr	-502(ra) # 52e <putc>
 72c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 72e:	03c9d793          	srli	a5,s3,0x3c
 732:	97de                	add	a5,a5,s7
 734:	0007c583          	lbu	a1,0(a5)
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	df4080e7          	jalr	-524(ra) # 52e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 742:	0992                	slli	s3,s3,0x4
 744:	397d                	addiw	s2,s2,-1
 746:	fe0914e3          	bnez	s2,72e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 74a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 74e:	4981                	li	s3,0
 750:	b721                	j	658 <vprintf+0x60>
        s = va_arg(ap, char*);
 752:	008b0993          	addi	s3,s6,8
 756:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 75a:	02090163          	beqz	s2,77c <vprintf+0x184>
        while(*s != 0){
 75e:	00094583          	lbu	a1,0(s2)
 762:	c9a1                	beqz	a1,7b2 <vprintf+0x1ba>
          putc(fd, *s);
 764:	8556                	mv	a0,s5
 766:	00000097          	auipc	ra,0x0
 76a:	dc8080e7          	jalr	-568(ra) # 52e <putc>
          s++;
 76e:	0905                	addi	s2,s2,1
        while(*s != 0){
 770:	00094583          	lbu	a1,0(s2)
 774:	f9e5                	bnez	a1,764 <vprintf+0x16c>
        s = va_arg(ap, char*);
 776:	8b4e                	mv	s6,s3
      state = 0;
 778:	4981                	li	s3,0
 77a:	bdf9                	j	658 <vprintf+0x60>
          s = "(null)";
 77c:	00000917          	auipc	s2,0x0
 780:	27490913          	addi	s2,s2,628 # 9f0 <malloc+0x12e>
        while(*s != 0){
 784:	02800593          	li	a1,40
 788:	bff1                	j	764 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 78a:	008b0913          	addi	s2,s6,8
 78e:	000b4583          	lbu	a1,0(s6)
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	d9a080e7          	jalr	-614(ra) # 52e <putc>
 79c:	8b4a                	mv	s6,s2
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	bd65                	j	658 <vprintf+0x60>
        putc(fd, c);
 7a2:	85d2                	mv	a1,s4
 7a4:	8556                	mv	a0,s5
 7a6:	00000097          	auipc	ra,0x0
 7aa:	d88080e7          	jalr	-632(ra) # 52e <putc>
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	b565                	j	658 <vprintf+0x60>
        s = va_arg(ap, char*);
 7b2:	8b4e                	mv	s6,s3
      state = 0;
 7b4:	4981                	li	s3,0
 7b6:	b54d                	j	658 <vprintf+0x60>
    }
  }
}
 7b8:	70e6                	ld	ra,120(sp)
 7ba:	7446                	ld	s0,112(sp)
 7bc:	74a6                	ld	s1,104(sp)
 7be:	7906                	ld	s2,96(sp)
 7c0:	69e6                	ld	s3,88(sp)
 7c2:	6a46                	ld	s4,80(sp)
 7c4:	6aa6                	ld	s5,72(sp)
 7c6:	6b06                	ld	s6,64(sp)
 7c8:	7be2                	ld	s7,56(sp)
 7ca:	7c42                	ld	s8,48(sp)
 7cc:	7ca2                	ld	s9,40(sp)
 7ce:	7d02                	ld	s10,32(sp)
 7d0:	6de2                	ld	s11,24(sp)
 7d2:	6109                	addi	sp,sp,128
 7d4:	8082                	ret

00000000000007d6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7d6:	715d                	addi	sp,sp,-80
 7d8:	ec06                	sd	ra,24(sp)
 7da:	e822                	sd	s0,16(sp)
 7dc:	1000                	addi	s0,sp,32
 7de:	e010                	sd	a2,0(s0)
 7e0:	e414                	sd	a3,8(s0)
 7e2:	e818                	sd	a4,16(s0)
 7e4:	ec1c                	sd	a5,24(s0)
 7e6:	03043023          	sd	a6,32(s0)
 7ea:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ee:	8622                	mv	a2,s0
 7f0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7f4:	00000097          	auipc	ra,0x0
 7f8:	e04080e7          	jalr	-508(ra) # 5f8 <vprintf>
}
 7fc:	60e2                	ld	ra,24(sp)
 7fe:	6442                	ld	s0,16(sp)
 800:	6161                	addi	sp,sp,80
 802:	8082                	ret

0000000000000804 <printf>:

void
printf(const char *fmt, ...)
{
 804:	711d                	addi	sp,sp,-96
 806:	ec06                	sd	ra,24(sp)
 808:	e822                	sd	s0,16(sp)
 80a:	1000                	addi	s0,sp,32
 80c:	e40c                	sd	a1,8(s0)
 80e:	e810                	sd	a2,16(s0)
 810:	ec14                	sd	a3,24(s0)
 812:	f018                	sd	a4,32(s0)
 814:	f41c                	sd	a5,40(s0)
 816:	03043823          	sd	a6,48(s0)
 81a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 81e:	00840613          	addi	a2,s0,8
 822:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 826:	85aa                	mv	a1,a0
 828:	4505                	li	a0,1
 82a:	00000097          	auipc	ra,0x0
 82e:	dce080e7          	jalr	-562(ra) # 5f8 <vprintf>
}
 832:	60e2                	ld	ra,24(sp)
 834:	6442                	ld	s0,16(sp)
 836:	6125                	addi	sp,sp,96
 838:	8082                	ret

000000000000083a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 83a:	1141                	addi	sp,sp,-16
 83c:	e422                	sd	s0,8(sp)
 83e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 840:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 844:	00000797          	auipc	a5,0x0
 848:	1cc7b783          	ld	a5,460(a5) # a10 <freep>
 84c:	a805                	j	87c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 84e:	4618                	lw	a4,8(a2)
 850:	9db9                	addw	a1,a1,a4
 852:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 856:	6398                	ld	a4,0(a5)
 858:	6318                	ld	a4,0(a4)
 85a:	fee53823          	sd	a4,-16(a0)
 85e:	a091                	j	8a2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 860:	ff852703          	lw	a4,-8(a0)
 864:	9e39                	addw	a2,a2,a4
 866:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 868:	ff053703          	ld	a4,-16(a0)
 86c:	e398                	sd	a4,0(a5)
 86e:	a099                	j	8b4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 870:	6398                	ld	a4,0(a5)
 872:	00e7e463          	bltu	a5,a4,87a <free+0x40>
 876:	00e6ea63          	bltu	a3,a4,88a <free+0x50>
{
 87a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 87c:	fed7fae3          	bgeu	a5,a3,870 <free+0x36>
 880:	6398                	ld	a4,0(a5)
 882:	00e6e463          	bltu	a3,a4,88a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 886:	fee7eae3          	bltu	a5,a4,87a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 88a:	ff852583          	lw	a1,-8(a0)
 88e:	6390                	ld	a2,0(a5)
 890:	02059713          	slli	a4,a1,0x20
 894:	9301                	srli	a4,a4,0x20
 896:	0712                	slli	a4,a4,0x4
 898:	9736                	add	a4,a4,a3
 89a:	fae60ae3          	beq	a2,a4,84e <free+0x14>
    bp->s.ptr = p->s.ptr;
 89e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8a2:	4790                	lw	a2,8(a5)
 8a4:	02061713          	slli	a4,a2,0x20
 8a8:	9301                	srli	a4,a4,0x20
 8aa:	0712                	slli	a4,a4,0x4
 8ac:	973e                	add	a4,a4,a5
 8ae:	fae689e3          	beq	a3,a4,860 <free+0x26>
  } else
    p->s.ptr = bp;
 8b2:	e394                	sd	a3,0(a5)
  freep = p;
 8b4:	00000717          	auipc	a4,0x0
 8b8:	14f73e23          	sd	a5,348(a4) # a10 <freep>
}
 8bc:	6422                	ld	s0,8(sp)
 8be:	0141                	addi	sp,sp,16
 8c0:	8082                	ret

00000000000008c2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8c2:	7139                	addi	sp,sp,-64
 8c4:	fc06                	sd	ra,56(sp)
 8c6:	f822                	sd	s0,48(sp)
 8c8:	f426                	sd	s1,40(sp)
 8ca:	f04a                	sd	s2,32(sp)
 8cc:	ec4e                	sd	s3,24(sp)
 8ce:	e852                	sd	s4,16(sp)
 8d0:	e456                	sd	s5,8(sp)
 8d2:	e05a                	sd	s6,0(sp)
 8d4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d6:	02051493          	slli	s1,a0,0x20
 8da:	9081                	srli	s1,s1,0x20
 8dc:	04bd                	addi	s1,s1,15
 8de:	8091                	srli	s1,s1,0x4
 8e0:	0014899b          	addiw	s3,s1,1
 8e4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8e6:	00000517          	auipc	a0,0x0
 8ea:	12a53503          	ld	a0,298(a0) # a10 <freep>
 8ee:	c515                	beqz	a0,91a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f2:	4798                	lw	a4,8(a5)
 8f4:	04977163          	bgeu	a4,s1,936 <malloc+0x74>
 8f8:	8a4e                	mv	s4,s3
 8fa:	0009871b          	sext.w	a4,s3
 8fe:	6685                	lui	a3,0x1
 900:	00d77363          	bgeu	a4,a3,906 <malloc+0x44>
 904:	6a05                	lui	s4,0x1
 906:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 90a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 90e:	00000917          	auipc	s2,0x0
 912:	10290913          	addi	s2,s2,258 # a10 <freep>
  if(p == (char*)-1)
 916:	5afd                	li	s5,-1
 918:	a89d                	j	98e <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 91a:	00000797          	auipc	a5,0x0
 91e:	0f678793          	addi	a5,a5,246 # a10 <freep>
 922:	00000717          	auipc	a4,0x0
 926:	0f670713          	addi	a4,a4,246 # a18 <base>
 92a:	e398                	sd	a4,0(a5)
 92c:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 92e:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 932:	87ba                	mv	a5,a4
 934:	b7d1                	j	8f8 <malloc+0x36>
      if(p->s.size == nunits)
 936:	02e48b63          	beq	s1,a4,96c <malloc+0xaa>
        p->s.size -= nunits;
 93a:	4137073b          	subw	a4,a4,s3
 93e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 940:	1702                	slli	a4,a4,0x20
 942:	9301                	srli	a4,a4,0x20
 944:	0712                	slli	a4,a4,0x4
 946:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 948:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 94c:	00000717          	auipc	a4,0x0
 950:	0ca73223          	sd	a0,196(a4) # a10 <freep>
      return (void*)(p + 1);
 954:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 958:	70e2                	ld	ra,56(sp)
 95a:	7442                	ld	s0,48(sp)
 95c:	74a2                	ld	s1,40(sp)
 95e:	7902                	ld	s2,32(sp)
 960:	69e2                	ld	s3,24(sp)
 962:	6a42                	ld	s4,16(sp)
 964:	6aa2                	ld	s5,8(sp)
 966:	6b02                	ld	s6,0(sp)
 968:	6121                	addi	sp,sp,64
 96a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 96c:	6398                	ld	a4,0(a5)
 96e:	e118                	sd	a4,0(a0)
 970:	bff1                	j	94c <malloc+0x8a>
  hp->s.size = nu;
 972:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 976:	0541                	addi	a0,a0,16
 978:	00000097          	auipc	ra,0x0
 97c:	ec2080e7          	jalr	-318(ra) # 83a <free>
  return freep;
 980:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 984:	d971                	beqz	a0,958 <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 986:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 988:	4798                	lw	a4,8(a5)
 98a:	fa9776e3          	bgeu	a4,s1,936 <malloc+0x74>
    if(p == freep)
 98e:	00093703          	ld	a4,0(s2)
 992:	853e                	mv	a0,a5
 994:	fef719e3          	bne	a4,a5,986 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 998:	8552                	mv	a0,s4
 99a:	00000097          	auipc	ra,0x0
 99e:	b3c080e7          	jalr	-1220(ra) # 4d6 <sbrk>
  if(p == (char*)-1)
 9a2:	fd5518e3          	bne	a0,s5,972 <malloc+0xb0>
        return 0;
 9a6:	4501                	li	a0,0
 9a8:	bf45                	j	958 <malloc+0x96>
