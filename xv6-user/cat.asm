
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
  14:	97890913          	addi	s2,s2,-1672 # 988 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	3c6080e7          	jalr	966(ra) # 3e6 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
        if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	3ba080e7          	jalr	954(ra) # 3ee <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
            fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	8d858593          	addi	a1,a1,-1832 # 918 <malloc+0xec>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	6f4080e7          	jalr	1780(ra) # 73e <fprintf>
            exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	37a080e7          	jalr	890(ra) # 3ce <exit>
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
  72:	8c258593          	addi	a1,a1,-1854 # 930 <malloc+0x104>
  76:	4509                	li	a0,2
  78:	00000097          	auipc	ra,0x0
  7c:	6c6080e7          	jalr	1734(ra) # 73e <fprintf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	34c080e7          	jalr	844(ra) # 3ce <exit>

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
  9a:	8b250513          	addi	a0,a0,-1870 # 948 <malloc+0x11c>
  9e:	00000097          	auipc	ra,0x0
  a2:	370080e7          	jalr	880(ra) # 40e <open>
  a6:	84aa                	mv	s1,a0
    fprintf(2,"fd=%d\n",fd);
  a8:	862a                	mv	a2,a0
  aa:	00001597          	auipc	a1,0x1
  ae:	8ae58593          	addi	a1,a1,-1874 # 958 <malloc+0x12c>
  b2:	4509                	li	a0,2
  b4:	00000097          	auipc	ra,0x0
  b8:	68a080e7          	jalr	1674(ra) # 73e <fprintf>
    char buf[256];
    int size = read(fd, buf, 256);
  bc:	10000613          	li	a2,256
  c0:	ee040593          	addi	a1,s0,-288
  c4:	8526                	mv	a0,s1
  c6:	00000097          	auipc	ra,0x0
  ca:	320080e7          	jalr	800(ra) # 3e6 <read>
    if (size < 0) {
        size = 0;
  ce:	fff54793          	not	a5,a0
  d2:	97fd                	srai	a5,a5,0x3f
    }
    write(1, buf, size);
  d4:	00f57633          	and	a2,a0,a5
  d8:	ee040593          	addi	a1,s0,-288
  dc:	4505                	li	a0,1
  de:	00000097          	auipc	ra,0x0
  e2:	310080e7          	jalr	784(ra) # 3ee <write>
    close(fd);
  e6:	8526                	mv	a0,s1
  e8:	00000097          	auipc	ra,0x0
  ec:	30e080e7          	jalr	782(ra) # 3f6 <close>
    exit(0);
  f0:	4501                	li	a0,0
  f2:	00000097          	auipc	ra,0x0
  f6:	2dc080e7          	jalr	732(ra) # 3ce <exit>

00000000000000fa <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e422                	sd	s0,8(sp)
  fe:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 100:	87aa                	mv	a5,a0
 102:	0585                	addi	a1,a1,1
 104:	0785                	addi	a5,a5,1
 106:	fff5c703          	lbu	a4,-1(a1)
 10a:	fee78fa3          	sb	a4,-1(a5)
 10e:	fb75                	bnez	a4,102 <strcpy+0x8>
    ;
  return os;
}
 110:	6422                	ld	s0,8(sp)
 112:	0141                	addi	sp,sp,16
 114:	8082                	ret

0000000000000116 <strcat>:

char*
strcat(char *s, const char *t)
{
 116:	1141                	addi	sp,sp,-16
 118:	e422                	sd	s0,8(sp)
 11a:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 11c:	00054783          	lbu	a5,0(a0)
 120:	c385                	beqz	a5,140 <strcat+0x2a>
 122:	87aa                	mv	a5,a0
    s++;
 124:	0785                	addi	a5,a5,1
  while(*s)
 126:	0007c703          	lbu	a4,0(a5)
 12a:	ff6d                	bnez	a4,124 <strcat+0xe>
  while((*s++ = *t++))
 12c:	0585                	addi	a1,a1,1
 12e:	0785                	addi	a5,a5,1
 130:	fff5c703          	lbu	a4,-1(a1)
 134:	fee78fa3          	sb	a4,-1(a5)
 138:	fb75                	bnez	a4,12c <strcat+0x16>
    ;
  return os;
}
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	addi	sp,sp,16
 13e:	8082                	ret
  while(*s)
 140:	87aa                	mv	a5,a0
 142:	b7ed                	j	12c <strcat+0x16>

0000000000000144 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 144:	1141                	addi	sp,sp,-16
 146:	e422                	sd	s0,8(sp)
 148:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 14a:	00054783          	lbu	a5,0(a0)
 14e:	cf91                	beqz	a5,16a <strcmp+0x26>
 150:	0005c703          	lbu	a4,0(a1)
 154:	00f71b63          	bne	a4,a5,16a <strcmp+0x26>
    p++, q++;
 158:	0505                	addi	a0,a0,1
 15a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 15c:	00054783          	lbu	a5,0(a0)
 160:	c789                	beqz	a5,16a <strcmp+0x26>
 162:	0005c703          	lbu	a4,0(a1)
 166:	fef709e3          	beq	a4,a5,158 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 16a:	0005c503          	lbu	a0,0(a1)
}
 16e:	40a7853b          	subw	a0,a5,a0
 172:	6422                	ld	s0,8(sp)
 174:	0141                	addi	sp,sp,16
 176:	8082                	ret

0000000000000178 <strlen>:

uint
strlen(const char *s)
{
 178:	1141                	addi	sp,sp,-16
 17a:	e422                	sd	s0,8(sp)
 17c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 17e:	00054783          	lbu	a5,0(a0)
 182:	cf91                	beqz	a5,19e <strlen+0x26>
 184:	0505                	addi	a0,a0,1
 186:	87aa                	mv	a5,a0
 188:	4685                	li	a3,1
 18a:	9e89                	subw	a3,a3,a0
    ;
 18c:	00f6853b          	addw	a0,a3,a5
 190:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 192:	fff7c703          	lbu	a4,-1(a5)
 196:	fb7d                	bnez	a4,18c <strlen+0x14>
  return n;
}
 198:	6422                	ld	s0,8(sp)
 19a:	0141                	addi	sp,sp,16
 19c:	8082                	ret
  for(n = 0; s[n]; n++)
 19e:	4501                	li	a0,0
 1a0:	bfe5                	j	198 <strlen+0x20>

00000000000001a2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a2:	1141                	addi	sp,sp,-16
 1a4:	e422                	sd	s0,8(sp)
 1a6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1a8:	ce09                	beqz	a2,1c2 <memset+0x20>
 1aa:	87aa                	mv	a5,a0
 1ac:	fff6071b          	addiw	a4,a2,-1
 1b0:	1702                	slli	a4,a4,0x20
 1b2:	9301                	srli	a4,a4,0x20
 1b4:	0705                	addi	a4,a4,1
 1b6:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1b8:	00b78023          	sb	a1,0(a5)
 1bc:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 1be:	fee79de3          	bne	a5,a4,1b8 <memset+0x16>
  }
  return dst;
}
 1c2:	6422                	ld	s0,8(sp)
 1c4:	0141                	addi	sp,sp,16
 1c6:	8082                	ret

00000000000001c8 <strchr>:

char*
strchr(const char *s, char c)
{
 1c8:	1141                	addi	sp,sp,-16
 1ca:	e422                	sd	s0,8(sp)
 1cc:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ce:	00054783          	lbu	a5,0(a0)
 1d2:	cf91                	beqz	a5,1ee <strchr+0x26>
    if(*s == c)
 1d4:	00f58a63          	beq	a1,a5,1e8 <strchr+0x20>
  for(; *s; s++)
 1d8:	0505                	addi	a0,a0,1
 1da:	00054783          	lbu	a5,0(a0)
 1de:	c781                	beqz	a5,1e6 <strchr+0x1e>
    if(*s == c)
 1e0:	feb79ce3          	bne	a5,a1,1d8 <strchr+0x10>
 1e4:	a011                	j	1e8 <strchr+0x20>
      return (char*)s;
  return 0;
 1e6:	4501                	li	a0,0
}
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret
  return 0;
 1ee:	4501                	li	a0,0
 1f0:	bfe5                	j	1e8 <strchr+0x20>

00000000000001f2 <gets>:

char*
gets(char *buf, int max)
{
 1f2:	711d                	addi	sp,sp,-96
 1f4:	ec86                	sd	ra,88(sp)
 1f6:	e8a2                	sd	s0,80(sp)
 1f8:	e4a6                	sd	s1,72(sp)
 1fa:	e0ca                	sd	s2,64(sp)
 1fc:	fc4e                	sd	s3,56(sp)
 1fe:	f852                	sd	s4,48(sp)
 200:	f456                	sd	s5,40(sp)
 202:	f05a                	sd	s6,32(sp)
 204:	ec5e                	sd	s7,24(sp)
 206:	1080                	addi	s0,sp,96
 208:	8baa                	mv	s7,a0
 20a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20c:	892a                	mv	s2,a0
 20e:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 210:	4aa9                	li	s5,10
 212:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 214:	0019849b          	addiw	s1,s3,1
 218:	0344d863          	bge	s1,s4,248 <gets+0x56>
    cc = read(0, &c, 1);
 21c:	4605                	li	a2,1
 21e:	faf40593          	addi	a1,s0,-81
 222:	4501                	li	a0,0
 224:	00000097          	auipc	ra,0x0
 228:	1c2080e7          	jalr	450(ra) # 3e6 <read>
    if(cc < 1)
 22c:	00a05e63          	blez	a0,248 <gets+0x56>
    buf[i++] = c;
 230:	faf44783          	lbu	a5,-81(s0)
 234:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 238:	01578763          	beq	a5,s5,246 <gets+0x54>
 23c:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 23e:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 240:	fd679ae3          	bne	a5,s6,214 <gets+0x22>
 244:	a011                	j	248 <gets+0x56>
  for(i=0; i+1 < max; ){
 246:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 248:	99de                	add	s3,s3,s7
 24a:	00098023          	sb	zero,0(s3)
  return buf;
}
 24e:	855e                	mv	a0,s7
 250:	60e6                	ld	ra,88(sp)
 252:	6446                	ld	s0,80(sp)
 254:	64a6                	ld	s1,72(sp)
 256:	6906                	ld	s2,64(sp)
 258:	79e2                	ld	s3,56(sp)
 25a:	7a42                	ld	s4,48(sp)
 25c:	7aa2                	ld	s5,40(sp)
 25e:	7b02                	ld	s6,32(sp)
 260:	6be2                	ld	s7,24(sp)
 262:	6125                	addi	sp,sp,96
 264:	8082                	ret

0000000000000266 <stat>:

int
stat(const char *n, struct stat *st)
{
 266:	1101                	addi	sp,sp,-32
 268:	ec06                	sd	ra,24(sp)
 26a:	e822                	sd	s0,16(sp)
 26c:	e426                	sd	s1,8(sp)
 26e:	e04a                	sd	s2,0(sp)
 270:	1000                	addi	s0,sp,32
 272:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 274:	4581                	li	a1,0
 276:	00000097          	auipc	ra,0x0
 27a:	198080e7          	jalr	408(ra) # 40e <open>
  if(fd < 0)
 27e:	02054563          	bltz	a0,2a8 <stat+0x42>
 282:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 284:	85ca                	mv	a1,s2
 286:	00000097          	auipc	ra,0x0
 28a:	190080e7          	jalr	400(ra) # 416 <fstat>
 28e:	892a                	mv	s2,a0
  close(fd);
 290:	8526                	mv	a0,s1
 292:	00000097          	auipc	ra,0x0
 296:	164080e7          	jalr	356(ra) # 3f6 <close>
  return r;
}
 29a:	854a                	mv	a0,s2
 29c:	60e2                	ld	ra,24(sp)
 29e:	6442                	ld	s0,16(sp)
 2a0:	64a2                	ld	s1,8(sp)
 2a2:	6902                	ld	s2,0(sp)
 2a4:	6105                	addi	sp,sp,32
 2a6:	8082                	ret
    return -1;
 2a8:	597d                	li	s2,-1
 2aa:	bfc5                	j	29a <stat+0x34>

00000000000002ac <atoi>:

int
atoi(const char *s)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e422                	sd	s0,8(sp)
 2b0:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 2b2:	00054703          	lbu	a4,0(a0)
 2b6:	02d00793          	li	a5,45
  int neg = 1;
 2ba:	4805                	li	a6,1
  if (*s == '-') {
 2bc:	04f70363          	beq	a4,a5,302 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 2c0:	00054683          	lbu	a3,0(a0)
 2c4:	fd06879b          	addiw	a5,a3,-48
 2c8:	0ff7f793          	andi	a5,a5,255
 2cc:	4725                	li	a4,9
 2ce:	02f76d63          	bltu	a4,a5,308 <atoi+0x5c>
  n = 0;
 2d2:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 2d4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2d6:	0505                	addi	a0,a0,1
 2d8:	0026179b          	slliw	a5,a2,0x2
 2dc:	9fb1                	addw	a5,a5,a2
 2de:	0017979b          	slliw	a5,a5,0x1
 2e2:	9fb5                	addw	a5,a5,a3
 2e4:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 2e8:	00054683          	lbu	a3,0(a0)
 2ec:	fd06871b          	addiw	a4,a3,-48
 2f0:	0ff77713          	andi	a4,a4,255
 2f4:	fee5f1e3          	bgeu	a1,a4,2d6 <atoi+0x2a>
  return n * neg;
}
 2f8:	02c8053b          	mulw	a0,a6,a2
 2fc:	6422                	ld	s0,8(sp)
 2fe:	0141                	addi	sp,sp,16
 300:	8082                	ret
    s++;
 302:	0505                	addi	a0,a0,1
    neg = -1;
 304:	587d                	li	a6,-1
 306:	bf6d                	j	2c0 <atoi+0x14>
  n = 0;
 308:	4601                	li	a2,0
 30a:	b7fd                	j	2f8 <atoi+0x4c>

000000000000030c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 312:	02b57663          	bgeu	a0,a1,33e <memmove+0x32>
    while(n-- > 0)
 316:	02c05163          	blez	a2,338 <memmove+0x2c>
 31a:	fff6079b          	addiw	a5,a2,-1
 31e:	1782                	slli	a5,a5,0x20
 320:	9381                	srli	a5,a5,0x20
 322:	0785                	addi	a5,a5,1
 324:	97aa                	add	a5,a5,a0
  dst = vdst;
 326:	872a                	mv	a4,a0
      *dst++ = *src++;
 328:	0585                	addi	a1,a1,1
 32a:	0705                	addi	a4,a4,1
 32c:	fff5c683          	lbu	a3,-1(a1)
 330:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 334:	fee79ae3          	bne	a5,a4,328 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret
    dst += n;
 33e:	00c50733          	add	a4,a0,a2
    src += n;
 342:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 344:	fec05ae3          	blez	a2,338 <memmove+0x2c>
 348:	fff6079b          	addiw	a5,a2,-1
 34c:	1782                	slli	a5,a5,0x20
 34e:	9381                	srli	a5,a5,0x20
 350:	fff7c793          	not	a5,a5
 354:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 356:	15fd                	addi	a1,a1,-1
 358:	177d                	addi	a4,a4,-1
 35a:	0005c683          	lbu	a3,0(a1)
 35e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 362:	fef71ae3          	bne	a4,a5,356 <memmove+0x4a>
 366:	bfc9                	j	338 <memmove+0x2c>

0000000000000368 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 368:	1141                	addi	sp,sp,-16
 36a:	e422                	sd	s0,8(sp)
 36c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 36e:	ce15                	beqz	a2,3aa <memcmp+0x42>
 370:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 374:	00054783          	lbu	a5,0(a0)
 378:	0005c703          	lbu	a4,0(a1)
 37c:	02e79063          	bne	a5,a4,39c <memcmp+0x34>
 380:	1682                	slli	a3,a3,0x20
 382:	9281                	srli	a3,a3,0x20
 384:	0685                	addi	a3,a3,1
 386:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 388:	0505                	addi	a0,a0,1
    p2++;
 38a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 38c:	00d50d63          	beq	a0,a3,3a6 <memcmp+0x3e>
    if (*p1 != *p2) {
 390:	00054783          	lbu	a5,0(a0)
 394:	0005c703          	lbu	a4,0(a1)
 398:	fee788e3          	beq	a5,a4,388 <memcmp+0x20>
      return *p1 - *p2;
 39c:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 3a0:	6422                	ld	s0,8(sp)
 3a2:	0141                	addi	sp,sp,16
 3a4:	8082                	ret
  return 0;
 3a6:	4501                	li	a0,0
 3a8:	bfe5                	j	3a0 <memcmp+0x38>
 3aa:	4501                	li	a0,0
 3ac:	bfd5                	j	3a0 <memcmp+0x38>

00000000000003ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e406                	sd	ra,8(sp)
 3b2:	e022                	sd	s0,0(sp)
 3b4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3b6:	00000097          	auipc	ra,0x0
 3ba:	f56080e7          	jalr	-170(ra) # 30c <memmove>
}
 3be:	60a2                	ld	ra,8(sp)
 3c0:	6402                	ld	s0,0(sp)
 3c2:	0141                	addi	sp,sp,16
 3c4:	8082                	ret

00000000000003c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 3c6:	4885                	li	a7,1
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ce:	4889                	li	a7,2
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3d6:	488d                	li	a7,3
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3de:	4891                	li	a7,4
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <read>:
.global read
read:
 li a7, SYS_read
 3e6:	4895                	li	a7,5
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <write>:
.global write
write:
 li a7, SYS_write
 3ee:	48c1                	li	a7,16
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <close>:
.global close
close:
 li a7, SYS_close
 3f6:	48d5                	li	a7,21
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 3fe:	4899                	li	a7,6
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <exec>:
.global exec
exec:
 li a7, SYS_exec
 406:	489d                	li	a7,7
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <open>:
.global open
open:
 li a7, SYS_open
 40e:	48bd                	li	a7,15
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 416:	48a1                	li	a7,8
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41e:	48d1                	li	a7,20
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 426:	48a5                	li	a7,9
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <dup>:
.global dup
dup:
 li a7, SYS_dup
 42e:	48a9                	li	a7,10
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 436:	48ad                	li	a7,11
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 43e:	48b1                	li	a7,12
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 446:	48b5                	li	a7,13
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44e:	48b9                	li	a7,14
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 456:	48d9                	li	a7,22
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <dev>:
.global dev
dev:
 li a7, SYS_dev
 45e:	48dd                	li	a7,23
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 466:	48e1                	li	a7,24
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 46e:	48e5                	li	a7,25
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <remove>:
.global remove
remove:
 li a7, SYS_remove
 476:	48c5                	li	a7,17
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <trace>:
.global trace
trace:
 li a7, SYS_trace
 47e:	48c9                	li	a7,18
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 486:	48cd                	li	a7,19
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <rename>:
.global rename
rename:
 li a7, SYS_rename
 48e:	48e9                	li	a7,26
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 496:	1101                	addi	sp,sp,-32
 498:	ec06                	sd	ra,24(sp)
 49a:	e822                	sd	s0,16(sp)
 49c:	1000                	addi	s0,sp,32
 49e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4a2:	4605                	li	a2,1
 4a4:	fef40593          	addi	a1,s0,-17
 4a8:	00000097          	auipc	ra,0x0
 4ac:	f46080e7          	jalr	-186(ra) # 3ee <write>
}
 4b0:	60e2                	ld	ra,24(sp)
 4b2:	6442                	ld	s0,16(sp)
 4b4:	6105                	addi	sp,sp,32
 4b6:	8082                	ret

00000000000004b8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b8:	7139                	addi	sp,sp,-64
 4ba:	fc06                	sd	ra,56(sp)
 4bc:	f822                	sd	s0,48(sp)
 4be:	f426                	sd	s1,40(sp)
 4c0:	f04a                	sd	s2,32(sp)
 4c2:	ec4e                	sd	s3,24(sp)
 4c4:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4c6:	c299                	beqz	a3,4cc <printint+0x14>
 4c8:	0005cd63          	bltz	a1,4e2 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4cc:	2581                	sext.w	a1,a1
  neg = 0;
 4ce:	4301                	li	t1,0
 4d0:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4d4:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4d6:	2601                	sext.w	a2,a2
 4d8:	00000897          	auipc	a7,0x0
 4dc:	48888893          	addi	a7,a7,1160 # 960 <digits>
 4e0:	a039                	j	4ee <printint+0x36>
    x = -xx;
 4e2:	40b005bb          	negw	a1,a1
    neg = 1;
 4e6:	4305                	li	t1,1
    x = -xx;
 4e8:	b7e5                	j	4d0 <printint+0x18>
  }while((x /= base) != 0);
 4ea:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 4ec:	8836                	mv	a6,a3
 4ee:	0018069b          	addiw	a3,a6,1
 4f2:	02c5f7bb          	remuw	a5,a1,a2
 4f6:	1782                	slli	a5,a5,0x20
 4f8:	9381                	srli	a5,a5,0x20
 4fa:	97c6                	add	a5,a5,a7
 4fc:	0007c783          	lbu	a5,0(a5)
 500:	00f70023          	sb	a5,0(a4)
 504:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 506:	02c5d7bb          	divuw	a5,a1,a2
 50a:	fec5f0e3          	bgeu	a1,a2,4ea <printint+0x32>
  if(neg)
 50e:	00030b63          	beqz	t1,524 <printint+0x6c>
    buf[i++] = '-';
 512:	fd040793          	addi	a5,s0,-48
 516:	96be                	add	a3,a3,a5
 518:	02d00793          	li	a5,45
 51c:	fef68823          	sb	a5,-16(a3)
 520:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 524:	02d05963          	blez	a3,556 <printint+0x9e>
 528:	89aa                	mv	s3,a0
 52a:	fc040793          	addi	a5,s0,-64
 52e:	00d784b3          	add	s1,a5,a3
 532:	fff78913          	addi	s2,a5,-1
 536:	9936                	add	s2,s2,a3
 538:	36fd                	addiw	a3,a3,-1
 53a:	1682                	slli	a3,a3,0x20
 53c:	9281                	srli	a3,a3,0x20
 53e:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 542:	fff4c583          	lbu	a1,-1(s1)
 546:	854e                	mv	a0,s3
 548:	00000097          	auipc	ra,0x0
 54c:	f4e080e7          	jalr	-178(ra) # 496 <putc>
 550:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 552:	ff2498e3          	bne	s1,s2,542 <printint+0x8a>
}
 556:	70e2                	ld	ra,56(sp)
 558:	7442                	ld	s0,48(sp)
 55a:	74a2                	ld	s1,40(sp)
 55c:	7902                	ld	s2,32(sp)
 55e:	69e2                	ld	s3,24(sp)
 560:	6121                	addi	sp,sp,64
 562:	8082                	ret

0000000000000564 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 564:	7119                	addi	sp,sp,-128
 566:	fc86                	sd	ra,120(sp)
 568:	f8a2                	sd	s0,112(sp)
 56a:	f4a6                	sd	s1,104(sp)
 56c:	f0ca                	sd	s2,96(sp)
 56e:	ecce                	sd	s3,88(sp)
 570:	e8d2                	sd	s4,80(sp)
 572:	e4d6                	sd	s5,72(sp)
 574:	e0da                	sd	s6,64(sp)
 576:	fc5e                	sd	s7,56(sp)
 578:	f862                	sd	s8,48(sp)
 57a:	f466                	sd	s9,40(sp)
 57c:	f06a                	sd	s10,32(sp)
 57e:	ec6e                	sd	s11,24(sp)
 580:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 582:	0005c483          	lbu	s1,0(a1)
 586:	18048d63          	beqz	s1,720 <vprintf+0x1bc>
 58a:	8aaa                	mv	s5,a0
 58c:	8b32                	mv	s6,a2
 58e:	00158913          	addi	s2,a1,1
  state = 0;
 592:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 594:	02500a13          	li	s4,37
      if(c == 'd'){
 598:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 59c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5a0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5a4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5a8:	00000b97          	auipc	s7,0x0
 5ac:	3b8b8b93          	addi	s7,s7,952 # 960 <digits>
 5b0:	a839                	j	5ce <vprintf+0x6a>
        putc(fd, c);
 5b2:	85a6                	mv	a1,s1
 5b4:	8556                	mv	a0,s5
 5b6:	00000097          	auipc	ra,0x0
 5ba:	ee0080e7          	jalr	-288(ra) # 496 <putc>
 5be:	a019                	j	5c4 <vprintf+0x60>
    } else if(state == '%'){
 5c0:	01498f63          	beq	s3,s4,5de <vprintf+0x7a>
 5c4:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 5c6:	fff94483          	lbu	s1,-1(s2)
 5ca:	14048b63          	beqz	s1,720 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 5ce:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5d2:	fe0997e3          	bnez	s3,5c0 <vprintf+0x5c>
      if(c == '%'){
 5d6:	fd479ee3          	bne	a5,s4,5b2 <vprintf+0x4e>
        state = '%';
 5da:	89be                	mv	s3,a5
 5dc:	b7e5                	j	5c4 <vprintf+0x60>
      if(c == 'd'){
 5de:	05878063          	beq	a5,s8,61e <vprintf+0xba>
      } else if(c == 'l') {
 5e2:	05978c63          	beq	a5,s9,63a <vprintf+0xd6>
      } else if(c == 'x') {
 5e6:	07a78863          	beq	a5,s10,656 <vprintf+0xf2>
      } else if(c == 'p') {
 5ea:	09b78463          	beq	a5,s11,672 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5ee:	07300713          	li	a4,115
 5f2:	0ce78563          	beq	a5,a4,6bc <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5f6:	06300713          	li	a4,99
 5fa:	0ee78c63          	beq	a5,a4,6f2 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5fe:	11478663          	beq	a5,s4,70a <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 602:	85d2                	mv	a1,s4
 604:	8556                	mv	a0,s5
 606:	00000097          	auipc	ra,0x0
 60a:	e90080e7          	jalr	-368(ra) # 496 <putc>
        putc(fd, c);
 60e:	85a6                	mv	a1,s1
 610:	8556                	mv	a0,s5
 612:	00000097          	auipc	ra,0x0
 616:	e84080e7          	jalr	-380(ra) # 496 <putc>
      }
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b765                	j	5c4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 61e:	008b0493          	addi	s1,s6,8
 622:	4685                	li	a3,1
 624:	4629                	li	a2,10
 626:	000b2583          	lw	a1,0(s6)
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e8c080e7          	jalr	-372(ra) # 4b8 <printint>
 634:	8b26                	mv	s6,s1
      state = 0;
 636:	4981                	li	s3,0
 638:	b771                	j	5c4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 63a:	008b0493          	addi	s1,s6,8
 63e:	4681                	li	a3,0
 640:	4629                	li	a2,10
 642:	000b2583          	lw	a1,0(s6)
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	e70080e7          	jalr	-400(ra) # 4b8 <printint>
 650:	8b26                	mv	s6,s1
      state = 0;
 652:	4981                	li	s3,0
 654:	bf85                	j	5c4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 656:	008b0493          	addi	s1,s6,8
 65a:	4681                	li	a3,0
 65c:	4641                	li	a2,16
 65e:	000b2583          	lw	a1,0(s6)
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e54080e7          	jalr	-428(ra) # 4b8 <printint>
 66c:	8b26                	mv	s6,s1
      state = 0;
 66e:	4981                	li	s3,0
 670:	bf91                	j	5c4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 672:	008b0793          	addi	a5,s6,8
 676:	f8f43423          	sd	a5,-120(s0)
 67a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 67e:	03000593          	li	a1,48
 682:	8556                	mv	a0,s5
 684:	00000097          	auipc	ra,0x0
 688:	e12080e7          	jalr	-494(ra) # 496 <putc>
  putc(fd, 'x');
 68c:	85ea                	mv	a1,s10
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	e06080e7          	jalr	-506(ra) # 496 <putc>
 698:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 69a:	03c9d793          	srli	a5,s3,0x3c
 69e:	97de                	add	a5,a5,s7
 6a0:	0007c583          	lbu	a1,0(a5)
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	df0080e7          	jalr	-528(ra) # 496 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ae:	0992                	slli	s3,s3,0x4
 6b0:	34fd                	addiw	s1,s1,-1
 6b2:	f4e5                	bnez	s1,69a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6b4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	b729                	j	5c4 <vprintf+0x60>
        s = va_arg(ap, char*);
 6bc:	008b0993          	addi	s3,s6,8
 6c0:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 6c4:	c085                	beqz	s1,6e4 <vprintf+0x180>
        while(*s != 0){
 6c6:	0004c583          	lbu	a1,0(s1)
 6ca:	c9a1                	beqz	a1,71a <vprintf+0x1b6>
          putc(fd, *s);
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	dc8080e7          	jalr	-568(ra) # 496 <putc>
          s++;
 6d6:	0485                	addi	s1,s1,1
        while(*s != 0){
 6d8:	0004c583          	lbu	a1,0(s1)
 6dc:	f9e5                	bnez	a1,6cc <vprintf+0x168>
        s = va_arg(ap, char*);
 6de:	8b4e                	mv	s6,s3
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b5cd                	j	5c4 <vprintf+0x60>
          s = "(null)";
 6e4:	00000497          	auipc	s1,0x0
 6e8:	29448493          	addi	s1,s1,660 # 978 <digits+0x18>
        while(*s != 0){
 6ec:	02800593          	li	a1,40
 6f0:	bff1                	j	6cc <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 6f2:	008b0493          	addi	s1,s6,8
 6f6:	000b4583          	lbu	a1,0(s6)
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	d9a080e7          	jalr	-614(ra) # 496 <putc>
 704:	8b26                	mv	s6,s1
      state = 0;
 706:	4981                	li	s3,0
 708:	bd75                	j	5c4 <vprintf+0x60>
        putc(fd, c);
 70a:	85d2                	mv	a1,s4
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	d88080e7          	jalr	-632(ra) # 496 <putc>
      state = 0;
 716:	4981                	li	s3,0
 718:	b575                	j	5c4 <vprintf+0x60>
        s = va_arg(ap, char*);
 71a:	8b4e                	mv	s6,s3
      state = 0;
 71c:	4981                	li	s3,0
 71e:	b55d                	j	5c4 <vprintf+0x60>
    }
  }
}
 720:	70e6                	ld	ra,120(sp)
 722:	7446                	ld	s0,112(sp)
 724:	74a6                	ld	s1,104(sp)
 726:	7906                	ld	s2,96(sp)
 728:	69e6                	ld	s3,88(sp)
 72a:	6a46                	ld	s4,80(sp)
 72c:	6aa6                	ld	s5,72(sp)
 72e:	6b06                	ld	s6,64(sp)
 730:	7be2                	ld	s7,56(sp)
 732:	7c42                	ld	s8,48(sp)
 734:	7ca2                	ld	s9,40(sp)
 736:	7d02                	ld	s10,32(sp)
 738:	6de2                	ld	s11,24(sp)
 73a:	6109                	addi	sp,sp,128
 73c:	8082                	ret

000000000000073e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 73e:	715d                	addi	sp,sp,-80
 740:	ec06                	sd	ra,24(sp)
 742:	e822                	sd	s0,16(sp)
 744:	1000                	addi	s0,sp,32
 746:	e010                	sd	a2,0(s0)
 748:	e414                	sd	a3,8(s0)
 74a:	e818                	sd	a4,16(s0)
 74c:	ec1c                	sd	a5,24(s0)
 74e:	03043023          	sd	a6,32(s0)
 752:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 756:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 75a:	8622                	mv	a2,s0
 75c:	00000097          	auipc	ra,0x0
 760:	e08080e7          	jalr	-504(ra) # 564 <vprintf>
}
 764:	60e2                	ld	ra,24(sp)
 766:	6442                	ld	s0,16(sp)
 768:	6161                	addi	sp,sp,80
 76a:	8082                	ret

000000000000076c <printf>:

void
printf(const char *fmt, ...)
{
 76c:	711d                	addi	sp,sp,-96
 76e:	ec06                	sd	ra,24(sp)
 770:	e822                	sd	s0,16(sp)
 772:	1000                	addi	s0,sp,32
 774:	e40c                	sd	a1,8(s0)
 776:	e810                	sd	a2,16(s0)
 778:	ec14                	sd	a3,24(s0)
 77a:	f018                	sd	a4,32(s0)
 77c:	f41c                	sd	a5,40(s0)
 77e:	03043823          	sd	a6,48(s0)
 782:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 786:	00840613          	addi	a2,s0,8
 78a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 78e:	85aa                	mv	a1,a0
 790:	4505                	li	a0,1
 792:	00000097          	auipc	ra,0x0
 796:	dd2080e7          	jalr	-558(ra) # 564 <vprintf>
}
 79a:	60e2                	ld	ra,24(sp)
 79c:	6442                	ld	s0,16(sp)
 79e:	6125                	addi	sp,sp,96
 7a0:	8082                	ret

00000000000007a2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a2:	1141                	addi	sp,sp,-16
 7a4:	e422                	sd	s0,8(sp)
 7a6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7a8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ac:	00000797          	auipc	a5,0x0
 7b0:	1d478793          	addi	a5,a5,468 # 980 <__DATA_BEGIN__>
 7b4:	639c                	ld	a5,0(a5)
 7b6:	a805                	j	7e6 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7b8:	4618                	lw	a4,8(a2)
 7ba:	9db9                	addw	a1,a1,a4
 7bc:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c0:	6398                	ld	a4,0(a5)
 7c2:	6318                	ld	a4,0(a4)
 7c4:	fee53823          	sd	a4,-16(a0)
 7c8:	a091                	j	80c <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ca:	ff852703          	lw	a4,-8(a0)
 7ce:	9e39                	addw	a2,a2,a4
 7d0:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7d2:	ff053703          	ld	a4,-16(a0)
 7d6:	e398                	sd	a4,0(a5)
 7d8:	a099                	j	81e <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7da:	6398                	ld	a4,0(a5)
 7dc:	00e7e463          	bltu	a5,a4,7e4 <free+0x42>
 7e0:	00e6ea63          	bltu	a3,a4,7f4 <free+0x52>
{
 7e4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e6:	fed7fae3          	bgeu	a5,a3,7da <free+0x38>
 7ea:	6398                	ld	a4,0(a5)
 7ec:	00e6e463          	bltu	a3,a4,7f4 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f0:	fee7eae3          	bltu	a5,a4,7e4 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 7f4:	ff852583          	lw	a1,-8(a0)
 7f8:	6390                	ld	a2,0(a5)
 7fa:	02059713          	slli	a4,a1,0x20
 7fe:	9301                	srli	a4,a4,0x20
 800:	0712                	slli	a4,a4,0x4
 802:	9736                	add	a4,a4,a3
 804:	fae60ae3          	beq	a2,a4,7b8 <free+0x16>
    bp->s.ptr = p->s.ptr;
 808:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 80c:	4790                	lw	a2,8(a5)
 80e:	02061713          	slli	a4,a2,0x20
 812:	9301                	srli	a4,a4,0x20
 814:	0712                	slli	a4,a4,0x4
 816:	973e                	add	a4,a4,a5
 818:	fae689e3          	beq	a3,a4,7ca <free+0x28>
  } else
    p->s.ptr = bp;
 81c:	e394                	sd	a3,0(a5)
  freep = p;
 81e:	00000717          	auipc	a4,0x0
 822:	16f73123          	sd	a5,354(a4) # 980 <__DATA_BEGIN__>
}
 826:	6422                	ld	s0,8(sp)
 828:	0141                	addi	sp,sp,16
 82a:	8082                	ret

000000000000082c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 82c:	7139                	addi	sp,sp,-64
 82e:	fc06                	sd	ra,56(sp)
 830:	f822                	sd	s0,48(sp)
 832:	f426                	sd	s1,40(sp)
 834:	f04a                	sd	s2,32(sp)
 836:	ec4e                	sd	s3,24(sp)
 838:	e852                	sd	s4,16(sp)
 83a:	e456                	sd	s5,8(sp)
 83c:	e05a                	sd	s6,0(sp)
 83e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 840:	02051993          	slli	s3,a0,0x20
 844:	0209d993          	srli	s3,s3,0x20
 848:	09bd                	addi	s3,s3,15
 84a:	0049d993          	srli	s3,s3,0x4
 84e:	2985                	addiw	s3,s3,1
 850:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 854:	00000797          	auipc	a5,0x0
 858:	12c78793          	addi	a5,a5,300 # 980 <__DATA_BEGIN__>
 85c:	6388                	ld	a0,0(a5)
 85e:	c515                	beqz	a0,88a <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 862:	4798                	lw	a4,8(a5)
 864:	03277f63          	bgeu	a4,s2,8a2 <malloc+0x76>
 868:	8a4e                	mv	s4,s3
 86a:	0009871b          	sext.w	a4,s3
 86e:	6685                	lui	a3,0x1
 870:	00d77363          	bgeu	a4,a3,876 <malloc+0x4a>
 874:	6a05                	lui	s4,0x1
 876:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 87a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 87e:	00000497          	auipc	s1,0x0
 882:	10248493          	addi	s1,s1,258 # 980 <__DATA_BEGIN__>
  if(p == (char*)-1)
 886:	5b7d                	li	s6,-1
 888:	a885                	j	8f8 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 88a:	00000797          	auipc	a5,0x0
 88e:	2fe78793          	addi	a5,a5,766 # b88 <base>
 892:	00000717          	auipc	a4,0x0
 896:	0ef73723          	sd	a5,238(a4) # 980 <__DATA_BEGIN__>
 89a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 89c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8a0:	b7e1                	j	868 <malloc+0x3c>
      if(p->s.size == nunits)
 8a2:	02e90b63          	beq	s2,a4,8d8 <malloc+0xac>
        p->s.size -= nunits;
 8a6:	4137073b          	subw	a4,a4,s3
 8aa:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8ac:	1702                	slli	a4,a4,0x20
 8ae:	9301                	srli	a4,a4,0x20
 8b0:	0712                	slli	a4,a4,0x4
 8b2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8b4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b8:	00000717          	auipc	a4,0x0
 8bc:	0ca73423          	sd	a0,200(a4) # 980 <__DATA_BEGIN__>
      return (void*)(p + 1);
 8c0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8c4:	70e2                	ld	ra,56(sp)
 8c6:	7442                	ld	s0,48(sp)
 8c8:	74a2                	ld	s1,40(sp)
 8ca:	7902                	ld	s2,32(sp)
 8cc:	69e2                	ld	s3,24(sp)
 8ce:	6a42                	ld	s4,16(sp)
 8d0:	6aa2                	ld	s5,8(sp)
 8d2:	6b02                	ld	s6,0(sp)
 8d4:	6121                	addi	sp,sp,64
 8d6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8d8:	6398                	ld	a4,0(a5)
 8da:	e118                	sd	a4,0(a0)
 8dc:	bff1                	j	8b8 <malloc+0x8c>
  hp->s.size = nu;
 8de:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 8e2:	0541                	addi	a0,a0,16
 8e4:	00000097          	auipc	ra,0x0
 8e8:	ebe080e7          	jalr	-322(ra) # 7a2 <free>
  return freep;
 8ec:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8ee:	d979                	beqz	a0,8c4 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f2:	4798                	lw	a4,8(a5)
 8f4:	fb2777e3          	bgeu	a4,s2,8a2 <malloc+0x76>
    if(p == freep)
 8f8:	6098                	ld	a4,0(s1)
 8fa:	853e                	mv	a0,a5
 8fc:	fef71ae3          	bne	a4,a5,8f0 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 900:	8552                	mv	a0,s4
 902:	00000097          	auipc	ra,0x0
 906:	b3c080e7          	jalr	-1220(ra) # 43e <sbrk>
  if(p == (char*)-1)
 90a:	fd651ae3          	bne	a0,s6,8de <malloc+0xb2>
        return 0;
 90e:	4501                	li	a0,0
 910:	bf55                	j	8c4 <malloc+0x98>
