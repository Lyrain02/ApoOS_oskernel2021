
xv6-user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
    int n;

    while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	95090913          	addi	s2,s2,-1712 # 960 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	3a8080e7          	jalr	936(ra) # 3c8 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
        if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	39c080e7          	jalr	924(ra) # 3d0 <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
            fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	8b858593          	addi	a1,a1,-1864 # 8f8 <malloc+0xec>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	6d6080e7          	jalr	1750(ra) # 720 <fprintf>
            exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	35c080e7          	jalr	860(ra) # 3b0 <exit>
        }
    }
    if(n < 0){
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
        fprintf(2, "cat: read error\n");
        exit(1);
    }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	addi	sp,sp,48
  6c:	8082                	ret
        fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	8a258593          	addi	a1,a1,-1886 # 910 <malloc+0x104>
  76:	4509                	li	a0,2
  78:	00000097          	auipc	ra,0x0
  7c:	6a8080e7          	jalr	1704(ra) # 720 <fprintf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	32e080e7          	jalr	814(ra) # 3b0 <exit>

000000000000008a <main>:

int
main(int argc, char *argv[])
{
  8a:	712d                	addi	sp,sp,-288
  8c:	ee06                	sd	ra,280(sp)
  8e:	ea22                	sd	s0,272(sp)
  90:	e626                	sd	s1,264(sp)
  92:	1200                	addi	s0,sp,288
//    }
//    cat(fd);
//    close(fd);
//    exit(0);

    int fd = open("./text.txt", 0);
  94:	4581                	li	a1,0
  96:	00001517          	auipc	a0,0x1
  9a:	89250513          	addi	a0,a0,-1902 # 928 <malloc+0x11c>
  9e:	00000097          	auipc	ra,0x0
  a2:	352080e7          	jalr	850(ra) # 3f0 <open>
  a6:	84aa                	mv	s1,a0
    fprintf(2,"fd=%d\n",fd);
  a8:	862a                	mv	a2,a0
  aa:	00001597          	auipc	a1,0x1
  ae:	88e58593          	addi	a1,a1,-1906 # 938 <malloc+0x12c>
  b2:	4509                	li	a0,2
  b4:	00000097          	auipc	ra,0x0
  b8:	66c080e7          	jalr	1644(ra) # 720 <fprintf>
    char buf[256];
    int size = read(fd, buf, 256);
  bc:	10000613          	li	a2,256
  c0:	ee040593          	addi	a1,s0,-288
  c4:	8526                	mv	a0,s1
  c6:	00000097          	auipc	ra,0x0
  ca:	302080e7          	jalr	770(ra) # 3c8 <read>
    if (size < 0) {
        size = 0;
  ce:	fff54613          	not	a2,a0
  d2:	967d                	srai	a2,a2,0x3f
    }
    write(1, buf, size);
  d4:	8e69                	and	a2,a2,a0
  d6:	ee040593          	addi	a1,s0,-288
  da:	4505                	li	a0,1
  dc:	00000097          	auipc	ra,0x0
  e0:	2f4080e7          	jalr	756(ra) # 3d0 <write>
    close(fd);
  e4:	8526                	mv	a0,s1
  e6:	00000097          	auipc	ra,0x0
  ea:	2f2080e7          	jalr	754(ra) # 3d8 <close>
    exit(0);
  ee:	4501                	li	a0,0
  f0:	00000097          	auipc	ra,0x0
  f4:	2c0080e7          	jalr	704(ra) # 3b0 <exit>

00000000000000f8 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fe:	87aa                	mv	a5,a0
 100:	0585                	addi	a1,a1,1
 102:	0785                	addi	a5,a5,1
 104:	fff5c703          	lbu	a4,-1(a1)
 108:	fee78fa3          	sb	a4,-1(a5)
 10c:	fb75                	bnez	a4,100 <strcpy+0x8>
    ;
  return os;
}
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret

0000000000000114 <strcat>:

char*
strcat(char *s, const char *t)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	c385                	beqz	a5,13e <strcat+0x2a>
 120:	87aa                	mv	a5,a0
    s++;
 122:	0785                	addi	a5,a5,1
  while(*s)
 124:	0007c703          	lbu	a4,0(a5)
 128:	ff6d                	bnez	a4,122 <strcat+0xe>
  while((*s++ = *t++))
 12a:	0585                	addi	a1,a1,1
 12c:	0785                	addi	a5,a5,1
 12e:	fff5c703          	lbu	a4,-1(a1)
 132:	fee78fa3          	sb	a4,-1(a5)
 136:	fb75                	bnez	a4,12a <strcat+0x16>
    ;
  return os;
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret
  while(*s)
 13e:	87aa                	mv	a5,a0
 140:	b7ed                	j	12a <strcat+0x16>

0000000000000142 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 142:	1141                	addi	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	cb91                	beqz	a5,160 <strcmp+0x1e>
 14e:	0005c703          	lbu	a4,0(a1)
 152:	00f71763          	bne	a4,a5,160 <strcmp+0x1e>
    p++, q++;
 156:	0505                	addi	a0,a0,1
 158:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	fbe5                	bnez	a5,14e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 160:	0005c503          	lbu	a0,0(a1)
}
 164:	40a7853b          	subw	a0,a5,a0
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	addi	sp,sp,16
 16c:	8082                	ret

000000000000016e <strlen>:

uint
strlen(const char *s)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf91                	beqz	a5,194 <strlen+0x26>
 17a:	0505                	addi	a0,a0,1
 17c:	87aa                	mv	a5,a0
 17e:	4685                	li	a3,1
 180:	9e89                	subw	a3,a3,a0
 182:	00f6853b          	addw	a0,a3,a5
 186:	0785                	addi	a5,a5,1
 188:	fff7c703          	lbu	a4,-1(a5)
 18c:	fb7d                	bnez	a4,182 <strlen+0x14>
    ;
  return n;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret
  for(n = 0; s[n]; n++)
 194:	4501                	li	a0,0
 196:	bfe5                	j	18e <strlen+0x20>

0000000000000198 <memset>:

void*
memset(void *dst, int c, uint n)
{
 198:	1141                	addi	sp,sp,-16
 19a:	e422                	sd	s0,8(sp)
 19c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19e:	ca19                	beqz	a2,1b4 <memset+0x1c>
 1a0:	87aa                	mv	a5,a0
 1a2:	1602                	slli	a2,a2,0x20
 1a4:	9201                	srli	a2,a2,0x20
 1a6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ae:	0785                	addi	a5,a5,1
 1b0:	fee79de3          	bne	a5,a4,1aa <memset+0x12>
  }
  return dst;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strchr>:

char*
strchr(const char *s, char c)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb99                	beqz	a5,1da <strchr+0x20>
    if(*s == c)
 1c6:	00f58763          	beq	a1,a5,1d4 <strchr+0x1a>
  for(; *s; s++)
 1ca:	0505                	addi	a0,a0,1
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	fbfd                	bnez	a5,1c6 <strchr+0xc>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x1a>

00000000000001de <gets>:

char*
gets(char *buf, int max)
{
 1de:	711d                	addi	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	e862                	sd	s8,16(sp)
 1f4:	1080                	addi	s0,sp,96
 1f6:	8baa                	mv	s7,a0
 1f8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fa:	892a                	mv	s2,a0
 1fc:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1fe:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 202:	4b29                	li	s6,10
 204:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 206:	89a6                	mv	s3,s1
 208:	2485                	addiw	s1,s1,1
 20a:	0344d763          	bge	s1,s4,238 <gets+0x5a>
    cc = read(0, &c, 1);
 20e:	4605                	li	a2,1
 210:	85d6                	mv	a1,s5
 212:	4501                	li	a0,0
 214:	00000097          	auipc	ra,0x0
 218:	1b4080e7          	jalr	436(ra) # 3c8 <read>
    if(cc < 1)
 21c:	00a05e63          	blez	a0,238 <gets+0x5a>
    buf[i++] = c;
 220:	faf44783          	lbu	a5,-81(s0)
 224:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 228:	01678763          	beq	a5,s6,236 <gets+0x58>
 22c:	0905                	addi	s2,s2,1
 22e:	fd879ce3          	bne	a5,s8,206 <gets+0x28>
  for(i=0; i+1 < max; ){
 232:	89a6                	mv	s3,s1
 234:	a011                	j	238 <gets+0x5a>
 236:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 238:	99de                	add	s3,s3,s7
 23a:	00098023          	sb	zero,0(s3)
  return buf;
}
 23e:	855e                	mv	a0,s7
 240:	60e6                	ld	ra,88(sp)
 242:	6446                	ld	s0,80(sp)
 244:	64a6                	ld	s1,72(sp)
 246:	6906                	ld	s2,64(sp)
 248:	79e2                	ld	s3,56(sp)
 24a:	7a42                	ld	s4,48(sp)
 24c:	7aa2                	ld	s5,40(sp)
 24e:	7b02                	ld	s6,32(sp)
 250:	6be2                	ld	s7,24(sp)
 252:	6c42                	ld	s8,16(sp)
 254:	6125                	addi	sp,sp,96
 256:	8082                	ret

0000000000000258 <stat>:

int
stat(const char *n, struct stat *st)
{
 258:	1101                	addi	sp,sp,-32
 25a:	ec06                	sd	ra,24(sp)
 25c:	e822                	sd	s0,16(sp)
 25e:	e426                	sd	s1,8(sp)
 260:	e04a                	sd	s2,0(sp)
 262:	1000                	addi	s0,sp,32
 264:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 266:	4581                	li	a1,0
 268:	00000097          	auipc	ra,0x0
 26c:	188080e7          	jalr	392(ra) # 3f0 <open>
  if(fd < 0)
 270:	02054563          	bltz	a0,29a <stat+0x42>
 274:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 276:	85ca                	mv	a1,s2
 278:	00000097          	auipc	ra,0x0
 27c:	180080e7          	jalr	384(ra) # 3f8 <fstat>
 280:	892a                	mv	s2,a0
  close(fd);
 282:	8526                	mv	a0,s1
 284:	00000097          	auipc	ra,0x0
 288:	154080e7          	jalr	340(ra) # 3d8 <close>
  return r;
}
 28c:	854a                	mv	a0,s2
 28e:	60e2                	ld	ra,24(sp)
 290:	6442                	ld	s0,16(sp)
 292:	64a2                	ld	s1,8(sp)
 294:	6902                	ld	s2,0(sp)
 296:	6105                	addi	sp,sp,32
 298:	8082                	ret
    return -1;
 29a:	597d                	li	s2,-1
 29c:	bfc5                	j	28c <stat+0x34>

000000000000029e <atoi>:

int
atoi(const char *s)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e422                	sd	s0,8(sp)
 2a2:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 2a4:	00054703          	lbu	a4,0(a0)
 2a8:	02d00793          	li	a5,45
  int neg = 1;
 2ac:	4805                	li	a6,1
  if (*s == '-') {
 2ae:	04f70363          	beq	a4,a5,2f4 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 2b2:	00054683          	lbu	a3,0(a0)
 2b6:	fd06879b          	addiw	a5,a3,-48
 2ba:	0ff7f793          	andi	a5,a5,255
 2be:	4725                	li	a4,9
 2c0:	02f76d63          	bltu	a4,a5,2fa <atoi+0x5c>
  n = 0;
 2c4:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 2c6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2c8:	0505                	addi	a0,a0,1
 2ca:	0026179b          	slliw	a5,a2,0x2
 2ce:	9fb1                	addw	a5,a5,a2
 2d0:	0017979b          	slliw	a5,a5,0x1
 2d4:	9fb5                	addw	a5,a5,a3
 2d6:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 2da:	00054683          	lbu	a3,0(a0)
 2de:	fd06871b          	addiw	a4,a3,-48
 2e2:	0ff77713          	andi	a4,a4,255
 2e6:	fee5f1e3          	bgeu	a1,a4,2c8 <atoi+0x2a>
  return n * neg;
}
 2ea:	02c8053b          	mulw	a0,a6,a2
 2ee:	6422                	ld	s0,8(sp)
 2f0:	0141                	addi	sp,sp,16
 2f2:	8082                	ret
    s++;
 2f4:	0505                	addi	a0,a0,1
    neg = -1;
 2f6:	587d                	li	a6,-1
 2f8:	bf6d                	j	2b2 <atoi+0x14>
  n = 0;
 2fa:	4601                	li	a2,0
 2fc:	b7fd                	j	2ea <atoi+0x4c>

00000000000002fe <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2fe:	1141                	addi	sp,sp,-16
 300:	e422                	sd	s0,8(sp)
 302:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 304:	02b57463          	bgeu	a0,a1,32c <memmove+0x2e>
    while(n-- > 0)
 308:	00c05f63          	blez	a2,326 <memmove+0x28>
 30c:	1602                	slli	a2,a2,0x20
 30e:	9201                	srli	a2,a2,0x20
 310:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 314:	872a                	mv	a4,a0
      *dst++ = *src++;
 316:	0585                	addi	a1,a1,1
 318:	0705                	addi	a4,a4,1
 31a:	fff5c683          	lbu	a3,-1(a1)
 31e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 322:	fee79ae3          	bne	a5,a4,316 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 326:	6422                	ld	s0,8(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret
    dst += n;
 32c:	00c50733          	add	a4,a0,a2
    src += n;
 330:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 332:	fec05ae3          	blez	a2,326 <memmove+0x28>
 336:	fff6079b          	addiw	a5,a2,-1
 33a:	1782                	slli	a5,a5,0x20
 33c:	9381                	srli	a5,a5,0x20
 33e:	fff7c793          	not	a5,a5
 342:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 344:	15fd                	addi	a1,a1,-1
 346:	177d                	addi	a4,a4,-1
 348:	0005c683          	lbu	a3,0(a1)
 34c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 350:	fee79ae3          	bne	a5,a4,344 <memmove+0x46>
 354:	bfc9                	j	326 <memmove+0x28>

0000000000000356 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 356:	1141                	addi	sp,sp,-16
 358:	e422                	sd	s0,8(sp)
 35a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 35c:	ca05                	beqz	a2,38c <memcmp+0x36>
 35e:	fff6069b          	addiw	a3,a2,-1
 362:	1682                	slli	a3,a3,0x20
 364:	9281                	srli	a3,a3,0x20
 366:	0685                	addi	a3,a3,1
 368:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 36a:	00054783          	lbu	a5,0(a0)
 36e:	0005c703          	lbu	a4,0(a1)
 372:	00e79863          	bne	a5,a4,382 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 376:	0505                	addi	a0,a0,1
    p2++;
 378:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 37a:	fed518e3          	bne	a0,a3,36a <memcmp+0x14>
  }
  return 0;
 37e:	4501                	li	a0,0
 380:	a019                	j	386 <memcmp+0x30>
      return *p1 - *p2;
 382:	40e7853b          	subw	a0,a5,a4
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret
  return 0;
 38c:	4501                	li	a0,0
 38e:	bfe5                	j	386 <memcmp+0x30>

0000000000000390 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 390:	1141                	addi	sp,sp,-16
 392:	e406                	sd	ra,8(sp)
 394:	e022                	sd	s0,0(sp)
 396:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 398:	00000097          	auipc	ra,0x0
 39c:	f66080e7          	jalr	-154(ra) # 2fe <memmove>
}
 3a0:	60a2                	ld	ra,8(sp)
 3a2:	6402                	ld	s0,0(sp)
 3a4:	0141                	addi	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 3a8:	4885                	li	a7,1
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b0:	4889                	li	a7,2
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3b8:	488d                	li	a7,3
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c0:	4891                	li	a7,4
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <read>:
.global read
read:
 li a7, SYS_read
 3c8:	4895                	li	a7,5
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <write>:
.global write
write:
 li a7, SYS_write
 3d0:	48c1                	li	a7,16
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <close>:
.global close
close:
 li a7, SYS_close
 3d8:	48d5                	li	a7,21
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e0:	4899                	li	a7,6
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3e8:	489d                	li	a7,7
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <open>:
.global open
open:
 li a7, SYS_open
 3f0:	48bd                	li	a7,15
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3f8:	48a1                	li	a7,8
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 400:	48d1                	li	a7,20
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 408:	48a5                	li	a7,9
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <dup>:
.global dup
dup:
 li a7, SYS_dup
 410:	48a9                	li	a7,10
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 418:	48ad                	li	a7,11
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 420:	48b1                	li	a7,12
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 428:	48b5                	li	a7,13
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 430:	48b9                	li	a7,14
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 438:	48d9                	li	a7,22
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <dev>:
.global dev
dev:
 li a7, SYS_dev
 440:	48dd                	li	a7,23
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 448:	48e1                	li	a7,24
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 450:	48e5                	li	a7,25
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <remove>:
.global remove
remove:
 li a7, SYS_remove
 458:	48c5                	li	a7,17
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <trace>:
.global trace
trace:
 li a7, SYS_trace
 460:	48c9                	li	a7,18
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 468:	48cd                	li	a7,19
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <rename>:
.global rename
rename:
 li a7, SYS_rename
 470:	48e9                	li	a7,26
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 478:	1101                	addi	sp,sp,-32
 47a:	ec06                	sd	ra,24(sp)
 47c:	e822                	sd	s0,16(sp)
 47e:	1000                	addi	s0,sp,32
 480:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 484:	4605                	li	a2,1
 486:	fef40593          	addi	a1,s0,-17
 48a:	00000097          	auipc	ra,0x0
 48e:	f46080e7          	jalr	-186(ra) # 3d0 <write>
}
 492:	60e2                	ld	ra,24(sp)
 494:	6442                	ld	s0,16(sp)
 496:	6105                	addi	sp,sp,32
 498:	8082                	ret

000000000000049a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 49a:	7139                	addi	sp,sp,-64
 49c:	fc06                	sd	ra,56(sp)
 49e:	f822                	sd	s0,48(sp)
 4a0:	f426                	sd	s1,40(sp)
 4a2:	f04a                	sd	s2,32(sp)
 4a4:	ec4e                	sd	s3,24(sp)
 4a6:	0080                	addi	s0,sp,64
 4a8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4aa:	c299                	beqz	a3,4b0 <printint+0x16>
 4ac:	0805c763          	bltz	a1,53a <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4b0:	2581                	sext.w	a1,a1
  neg = 0;
 4b2:	4881                	li	a7,0
  }

  i = 0;
 4b4:	fc040993          	addi	s3,s0,-64
  neg = 0;
 4b8:	86ce                	mv	a3,s3
  i = 0;
 4ba:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4bc:	2601                	sext.w	a2,a2
 4be:	00000517          	auipc	a0,0x0
 4c2:	48a50513          	addi	a0,a0,1162 # 948 <digits>
 4c6:	883a                	mv	a6,a4
 4c8:	2705                	addiw	a4,a4,1
 4ca:	02c5f7bb          	remuw	a5,a1,a2
 4ce:	1782                	slli	a5,a5,0x20
 4d0:	9381                	srli	a5,a5,0x20
 4d2:	97aa                	add	a5,a5,a0
 4d4:	0007c783          	lbu	a5,0(a5)
 4d8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4dc:	0005879b          	sext.w	a5,a1
 4e0:	02c5d5bb          	divuw	a1,a1,a2
 4e4:	0685                	addi	a3,a3,1
 4e6:	fec7f0e3          	bgeu	a5,a2,4c6 <printint+0x2c>
  if(neg)
 4ea:	00088b63          	beqz	a7,500 <printint+0x66>
    buf[i++] = '-';
 4ee:	fd040793          	addi	a5,s0,-48
 4f2:	973e                	add	a4,a4,a5
 4f4:	02d00793          	li	a5,45
 4f8:	fef70823          	sb	a5,-16(a4)
 4fc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 500:	02e05663          	blez	a4,52c <printint+0x92>
 504:	fc040913          	addi	s2,s0,-64
 508:	993a                	add	s2,s2,a4
 50a:	19fd                	addi	s3,s3,-1
 50c:	99ba                	add	s3,s3,a4
 50e:	377d                	addiw	a4,a4,-1
 510:	1702                	slli	a4,a4,0x20
 512:	9301                	srli	a4,a4,0x20
 514:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 518:	fff94583          	lbu	a1,-1(s2)
 51c:	8526                	mv	a0,s1
 51e:	00000097          	auipc	ra,0x0
 522:	f5a080e7          	jalr	-166(ra) # 478 <putc>
  while(--i >= 0)
 526:	197d                	addi	s2,s2,-1
 528:	ff3918e3          	bne	s2,s3,518 <printint+0x7e>
}
 52c:	70e2                	ld	ra,56(sp)
 52e:	7442                	ld	s0,48(sp)
 530:	74a2                	ld	s1,40(sp)
 532:	7902                	ld	s2,32(sp)
 534:	69e2                	ld	s3,24(sp)
 536:	6121                	addi	sp,sp,64
 538:	8082                	ret
    x = -xx;
 53a:	40b005bb          	negw	a1,a1
    neg = 1;
 53e:	4885                	li	a7,1
    x = -xx;
 540:	bf95                	j	4b4 <printint+0x1a>

0000000000000542 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 542:	7119                	addi	sp,sp,-128
 544:	fc86                	sd	ra,120(sp)
 546:	f8a2                	sd	s0,112(sp)
 548:	f4a6                	sd	s1,104(sp)
 54a:	f0ca                	sd	s2,96(sp)
 54c:	ecce                	sd	s3,88(sp)
 54e:	e8d2                	sd	s4,80(sp)
 550:	e4d6                	sd	s5,72(sp)
 552:	e0da                	sd	s6,64(sp)
 554:	fc5e                	sd	s7,56(sp)
 556:	f862                	sd	s8,48(sp)
 558:	f466                	sd	s9,40(sp)
 55a:	f06a                	sd	s10,32(sp)
 55c:	ec6e                	sd	s11,24(sp)
 55e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 560:	0005c903          	lbu	s2,0(a1)
 564:	18090f63          	beqz	s2,702 <vprintf+0x1c0>
 568:	8aaa                	mv	s5,a0
 56a:	8b32                	mv	s6,a2
 56c:	00158493          	addi	s1,a1,1
  state = 0;
 570:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 572:	02500a13          	li	s4,37
      if(c == 'd'){
 576:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 57a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 57e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 582:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 586:	00000b97          	auipc	s7,0x0
 58a:	3c2b8b93          	addi	s7,s7,962 # 948 <digits>
 58e:	a839                	j	5ac <vprintf+0x6a>
        putc(fd, c);
 590:	85ca                	mv	a1,s2
 592:	8556                	mv	a0,s5
 594:	00000097          	auipc	ra,0x0
 598:	ee4080e7          	jalr	-284(ra) # 478 <putc>
 59c:	a019                	j	5a2 <vprintf+0x60>
    } else if(state == '%'){
 59e:	01498f63          	beq	s3,s4,5bc <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5a2:	0485                	addi	s1,s1,1
 5a4:	fff4c903          	lbu	s2,-1(s1)
 5a8:	14090d63          	beqz	s2,702 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 5ac:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5b0:	fe0997e3          	bnez	s3,59e <vprintf+0x5c>
      if(c == '%'){
 5b4:	fd479ee3          	bne	a5,s4,590 <vprintf+0x4e>
        state = '%';
 5b8:	89be                	mv	s3,a5
 5ba:	b7e5                	j	5a2 <vprintf+0x60>
      if(c == 'd'){
 5bc:	05878063          	beq	a5,s8,5fc <vprintf+0xba>
      } else if(c == 'l') {
 5c0:	05978c63          	beq	a5,s9,618 <vprintf+0xd6>
      } else if(c == 'x') {
 5c4:	07a78863          	beq	a5,s10,634 <vprintf+0xf2>
      } else if(c == 'p') {
 5c8:	09b78463          	beq	a5,s11,650 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5cc:	07300713          	li	a4,115
 5d0:	0ce78663          	beq	a5,a4,69c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d4:	06300713          	li	a4,99
 5d8:	0ee78e63          	beq	a5,a4,6d4 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5dc:	11478863          	beq	a5,s4,6ec <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e0:	85d2                	mv	a1,s4
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	e94080e7          	jalr	-364(ra) # 478 <putc>
        putc(fd, c);
 5ec:	85ca                	mv	a1,s2
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	e88080e7          	jalr	-376(ra) # 478 <putc>
      }
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	b765                	j	5a2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5fc:	008b0913          	addi	s2,s6,8
 600:	4685                	li	a3,1
 602:	4629                	li	a2,10
 604:	000b2583          	lw	a1,0(s6)
 608:	8556                	mv	a0,s5
 60a:	00000097          	auipc	ra,0x0
 60e:	e90080e7          	jalr	-368(ra) # 49a <printint>
 612:	8b4a                	mv	s6,s2
      state = 0;
 614:	4981                	li	s3,0
 616:	b771                	j	5a2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 618:	008b0913          	addi	s2,s6,8
 61c:	4681                	li	a3,0
 61e:	4629                	li	a2,10
 620:	000b2583          	lw	a1,0(s6)
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	e74080e7          	jalr	-396(ra) # 49a <printint>
 62e:	8b4a                	mv	s6,s2
      state = 0;
 630:	4981                	li	s3,0
 632:	bf85                	j	5a2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 634:	008b0913          	addi	s2,s6,8
 638:	4681                	li	a3,0
 63a:	4641                	li	a2,16
 63c:	000b2583          	lw	a1,0(s6)
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	e58080e7          	jalr	-424(ra) # 49a <printint>
 64a:	8b4a                	mv	s6,s2
      state = 0;
 64c:	4981                	li	s3,0
 64e:	bf91                	j	5a2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 650:	008b0793          	addi	a5,s6,8
 654:	f8f43423          	sd	a5,-120(s0)
 658:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 65c:	03000593          	li	a1,48
 660:	8556                	mv	a0,s5
 662:	00000097          	auipc	ra,0x0
 666:	e16080e7          	jalr	-490(ra) # 478 <putc>
  putc(fd, 'x');
 66a:	85ea                	mv	a1,s10
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	e0a080e7          	jalr	-502(ra) # 478 <putc>
 676:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 678:	03c9d793          	srli	a5,s3,0x3c
 67c:	97de                	add	a5,a5,s7
 67e:	0007c583          	lbu	a1,0(a5)
 682:	8556                	mv	a0,s5
 684:	00000097          	auipc	ra,0x0
 688:	df4080e7          	jalr	-524(ra) # 478 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 68c:	0992                	slli	s3,s3,0x4
 68e:	397d                	addiw	s2,s2,-1
 690:	fe0914e3          	bnez	s2,678 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 694:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 698:	4981                	li	s3,0
 69a:	b721                	j	5a2 <vprintf+0x60>
        s = va_arg(ap, char*);
 69c:	008b0993          	addi	s3,s6,8
 6a0:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 6a4:	02090163          	beqz	s2,6c6 <vprintf+0x184>
        while(*s != 0){
 6a8:	00094583          	lbu	a1,0(s2)
 6ac:	c9a1                	beqz	a1,6fc <vprintf+0x1ba>
          putc(fd, *s);
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	dc8080e7          	jalr	-568(ra) # 478 <putc>
          s++;
 6b8:	0905                	addi	s2,s2,1
        while(*s != 0){
 6ba:	00094583          	lbu	a1,0(s2)
 6be:	f9e5                	bnez	a1,6ae <vprintf+0x16c>
        s = va_arg(ap, char*);
 6c0:	8b4e                	mv	s6,s3
      state = 0;
 6c2:	4981                	li	s3,0
 6c4:	bdf9                	j	5a2 <vprintf+0x60>
          s = "(null)";
 6c6:	00000917          	auipc	s2,0x0
 6ca:	27a90913          	addi	s2,s2,634 # 940 <malloc+0x134>
        while(*s != 0){
 6ce:	02800593          	li	a1,40
 6d2:	bff1                	j	6ae <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 6d4:	008b0913          	addi	s2,s6,8
 6d8:	000b4583          	lbu	a1,0(s6)
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	d9a080e7          	jalr	-614(ra) # 478 <putc>
 6e6:	8b4a                	mv	s6,s2
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	bd65                	j	5a2 <vprintf+0x60>
        putc(fd, c);
 6ec:	85d2                	mv	a1,s4
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	d88080e7          	jalr	-632(ra) # 478 <putc>
      state = 0;
 6f8:	4981                	li	s3,0
 6fa:	b565                	j	5a2 <vprintf+0x60>
        s = va_arg(ap, char*);
 6fc:	8b4e                	mv	s6,s3
      state = 0;
 6fe:	4981                	li	s3,0
 700:	b54d                	j	5a2 <vprintf+0x60>
    }
  }
}
 702:	70e6                	ld	ra,120(sp)
 704:	7446                	ld	s0,112(sp)
 706:	74a6                	ld	s1,104(sp)
 708:	7906                	ld	s2,96(sp)
 70a:	69e6                	ld	s3,88(sp)
 70c:	6a46                	ld	s4,80(sp)
 70e:	6aa6                	ld	s5,72(sp)
 710:	6b06                	ld	s6,64(sp)
 712:	7be2                	ld	s7,56(sp)
 714:	7c42                	ld	s8,48(sp)
 716:	7ca2                	ld	s9,40(sp)
 718:	7d02                	ld	s10,32(sp)
 71a:	6de2                	ld	s11,24(sp)
 71c:	6109                	addi	sp,sp,128
 71e:	8082                	ret

0000000000000720 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 720:	715d                	addi	sp,sp,-80
 722:	ec06                	sd	ra,24(sp)
 724:	e822                	sd	s0,16(sp)
 726:	1000                	addi	s0,sp,32
 728:	e010                	sd	a2,0(s0)
 72a:	e414                	sd	a3,8(s0)
 72c:	e818                	sd	a4,16(s0)
 72e:	ec1c                	sd	a5,24(s0)
 730:	03043023          	sd	a6,32(s0)
 734:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 738:	8622                	mv	a2,s0
 73a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 73e:	00000097          	auipc	ra,0x0
 742:	e04080e7          	jalr	-508(ra) # 542 <vprintf>
}
 746:	60e2                	ld	ra,24(sp)
 748:	6442                	ld	s0,16(sp)
 74a:	6161                	addi	sp,sp,80
 74c:	8082                	ret

000000000000074e <printf>:

void
printf(const char *fmt, ...)
{
 74e:	711d                	addi	sp,sp,-96
 750:	ec06                	sd	ra,24(sp)
 752:	e822                	sd	s0,16(sp)
 754:	1000                	addi	s0,sp,32
 756:	e40c                	sd	a1,8(s0)
 758:	e810                	sd	a2,16(s0)
 75a:	ec14                	sd	a3,24(s0)
 75c:	f018                	sd	a4,32(s0)
 75e:	f41c                	sd	a5,40(s0)
 760:	03043823          	sd	a6,48(s0)
 764:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 768:	00840613          	addi	a2,s0,8
 76c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 770:	85aa                	mv	a1,a0
 772:	4505                	li	a0,1
 774:	00000097          	auipc	ra,0x0
 778:	dce080e7          	jalr	-562(ra) # 542 <vprintf>
}
 77c:	60e2                	ld	ra,24(sp)
 77e:	6442                	ld	s0,16(sp)
 780:	6125                	addi	sp,sp,96
 782:	8082                	ret

0000000000000784 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 784:	1141                	addi	sp,sp,-16
 786:	e422                	sd	s0,8(sp)
 788:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 78a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78e:	00000797          	auipc	a5,0x0
 792:	3d27b783          	ld	a5,978(a5) # b60 <freep>
 796:	a805                	j	7c6 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 798:	4618                	lw	a4,8(a2)
 79a:	9db9                	addw	a1,a1,a4
 79c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a0:	6398                	ld	a4,0(a5)
 7a2:	6318                	ld	a4,0(a4)
 7a4:	fee53823          	sd	a4,-16(a0)
 7a8:	a091                	j	7ec <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7aa:	ff852703          	lw	a4,-8(a0)
 7ae:	9e39                	addw	a2,a2,a4
 7b0:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7b2:	ff053703          	ld	a4,-16(a0)
 7b6:	e398                	sd	a4,0(a5)
 7b8:	a099                	j	7fe <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ba:	6398                	ld	a4,0(a5)
 7bc:	00e7e463          	bltu	a5,a4,7c4 <free+0x40>
 7c0:	00e6ea63          	bltu	a3,a4,7d4 <free+0x50>
{
 7c4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c6:	fed7fae3          	bgeu	a5,a3,7ba <free+0x36>
 7ca:	6398                	ld	a4,0(a5)
 7cc:	00e6e463          	bltu	a3,a4,7d4 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d0:	fee7eae3          	bltu	a5,a4,7c4 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 7d4:	ff852583          	lw	a1,-8(a0)
 7d8:	6390                	ld	a2,0(a5)
 7da:	02059713          	slli	a4,a1,0x20
 7de:	9301                	srli	a4,a4,0x20
 7e0:	0712                	slli	a4,a4,0x4
 7e2:	9736                	add	a4,a4,a3
 7e4:	fae60ae3          	beq	a2,a4,798 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7e8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7ec:	4790                	lw	a2,8(a5)
 7ee:	02061713          	slli	a4,a2,0x20
 7f2:	9301                	srli	a4,a4,0x20
 7f4:	0712                	slli	a4,a4,0x4
 7f6:	973e                	add	a4,a4,a5
 7f8:	fae689e3          	beq	a3,a4,7aa <free+0x26>
  } else
    p->s.ptr = bp;
 7fc:	e394                	sd	a3,0(a5)
  freep = p;
 7fe:	00000717          	auipc	a4,0x0
 802:	36f73123          	sd	a5,866(a4) # b60 <freep>
}
 806:	6422                	ld	s0,8(sp)
 808:	0141                	addi	sp,sp,16
 80a:	8082                	ret

000000000000080c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 80c:	7139                	addi	sp,sp,-64
 80e:	fc06                	sd	ra,56(sp)
 810:	f822                	sd	s0,48(sp)
 812:	f426                	sd	s1,40(sp)
 814:	f04a                	sd	s2,32(sp)
 816:	ec4e                	sd	s3,24(sp)
 818:	e852                	sd	s4,16(sp)
 81a:	e456                	sd	s5,8(sp)
 81c:	e05a                	sd	s6,0(sp)
 81e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 820:	02051493          	slli	s1,a0,0x20
 824:	9081                	srli	s1,s1,0x20
 826:	04bd                	addi	s1,s1,15
 828:	8091                	srli	s1,s1,0x4
 82a:	0014899b          	addiw	s3,s1,1
 82e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 830:	00000517          	auipc	a0,0x0
 834:	33053503          	ld	a0,816(a0) # b60 <freep>
 838:	c515                	beqz	a0,864 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 83a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 83c:	4798                	lw	a4,8(a5)
 83e:	04977163          	bgeu	a4,s1,880 <malloc+0x74>
 842:	8a4e                	mv	s4,s3
 844:	0009871b          	sext.w	a4,s3
 848:	6685                	lui	a3,0x1
 84a:	00d77363          	bgeu	a4,a3,850 <malloc+0x44>
 84e:	6a05                	lui	s4,0x1
 850:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 854:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 858:	00000917          	auipc	s2,0x0
 85c:	30890913          	addi	s2,s2,776 # b60 <freep>
  if(p == (char*)-1)
 860:	5afd                	li	s5,-1
 862:	a89d                	j	8d8 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 864:	00000797          	auipc	a5,0x0
 868:	2fc78793          	addi	a5,a5,764 # b60 <freep>
 86c:	00000717          	auipc	a4,0x0
 870:	2fc70713          	addi	a4,a4,764 # b68 <base>
 874:	e398                	sd	a4,0(a5)
 876:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 878:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87c:	87ba                	mv	a5,a4
 87e:	b7d1                	j	842 <malloc+0x36>
      if(p->s.size == nunits)
 880:	02e48b63          	beq	s1,a4,8b6 <malloc+0xaa>
        p->s.size -= nunits;
 884:	4137073b          	subw	a4,a4,s3
 888:	c798                	sw	a4,8(a5)
        p += p->s.size;
 88a:	1702                	slli	a4,a4,0x20
 88c:	9301                	srli	a4,a4,0x20
 88e:	0712                	slli	a4,a4,0x4
 890:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 892:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 896:	00000717          	auipc	a4,0x0
 89a:	2ca73523          	sd	a0,714(a4) # b60 <freep>
      return (void*)(p + 1);
 89e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8a2:	70e2                	ld	ra,56(sp)
 8a4:	7442                	ld	s0,48(sp)
 8a6:	74a2                	ld	s1,40(sp)
 8a8:	7902                	ld	s2,32(sp)
 8aa:	69e2                	ld	s3,24(sp)
 8ac:	6a42                	ld	s4,16(sp)
 8ae:	6aa2                	ld	s5,8(sp)
 8b0:	6b02                	ld	s6,0(sp)
 8b2:	6121                	addi	sp,sp,64
 8b4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8b6:	6398                	ld	a4,0(a5)
 8b8:	e118                	sd	a4,0(a0)
 8ba:	bff1                	j	896 <malloc+0x8a>
  hp->s.size = nu;
 8bc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8c0:	0541                	addi	a0,a0,16
 8c2:	00000097          	auipc	ra,0x0
 8c6:	ec2080e7          	jalr	-318(ra) # 784 <free>
  return freep;
 8ca:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8ce:	d971                	beqz	a0,8a2 <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8d2:	4798                	lw	a4,8(a5)
 8d4:	fa9776e3          	bgeu	a4,s1,880 <malloc+0x74>
    if(p == freep)
 8d8:	00093703          	ld	a4,0(s2)
 8dc:	853e                	mv	a0,a5
 8de:	fef719e3          	bne	a4,a5,8d0 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 8e2:	8552                	mv	a0,s4
 8e4:	00000097          	auipc	ra,0x0
 8e8:	b3c080e7          	jalr	-1220(ra) # 420 <sbrk>
  if(p == (char*)-1)
 8ec:	fd5518e3          	bne	a0,s5,8bc <malloc+0xb0>
        return 0;
 8f0:	4501                	li	a0,0
 8f2:	bf45                	j	8a2 <malloc+0x96>
