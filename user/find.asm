
xv6-user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "xv6-user/user.h"

static char path[512];

void find(char *filename)
{
   0:	7175                	addi	sp,sp,-144
   2:	e506                	sd	ra,136(sp)
   4:	e122                	sd	s0,128(sp)
   6:	fca6                	sd	s1,120(sp)
   8:	f8ca                	sd	s2,112(sp)
   a:	f4ce                	sd	s3,104(sp)
   c:	f0d2                	sd	s4,96(sp)
   e:	ecd6                	sd	s5,88(sp)
  10:	e8da                	sd	s6,80(sp)
  12:	e4de                	sd	s7,72(sp)
  14:	e0e2                	sd	s8,64(sp)
  16:	0900                	addi	s0,sp,144
  18:	8a2a                	mv	s4,a0
    int fd;
    struct stat st;
    if ((fd = open(path, O_RDONLY)) < 0) {
  1a:	4581                	li	a1,0
  1c:	00001517          	auipc	a0,0x1
  20:	a8c50513          	addi	a0,a0,-1396 # aa8 <path>
  24:	00000097          	auipc	ra,0x0
  28:	4da080e7          	jalr	1242(ra) # 4fe <open>
  2c:	04054163          	bltz	a0,6e <find+0x6e>
  30:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    if (fstat(fd, &st) < 0) {
  32:	f7840593          	addi	a1,s0,-136
  36:	00000097          	auipc	ra,0x0
  3a:	4d0080e7          	jalr	1232(ra) # 506 <fstat>
  3e:	04054663          	bltz	a0,8a <find+0x8a>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    if (st.type != T_DIR) {
  42:	fa041703          	lh	a4,-96(s0)
  46:	4785                	li	a5,1
  48:	06f70463          	beq	a4,a5,b0 <find+0xb0>
        close(fd);
  4c:	8526                	mv	a0,s1
  4e:	00000097          	auipc	ra,0x0
  52:	498080e7          	jalr	1176(ra) # 4e6 <close>
        }
        find(filename);
    }
    close(fd);
    return;
}
  56:	60aa                	ld	ra,136(sp)
  58:	640a                	ld	s0,128(sp)
  5a:	74e6                	ld	s1,120(sp)
  5c:	7946                	ld	s2,112(sp)
  5e:	79a6                	ld	s3,104(sp)
  60:	7a06                	ld	s4,96(sp)
  62:	6ae6                	ld	s5,88(sp)
  64:	6b46                	ld	s6,80(sp)
  66:	6ba6                	ld	s7,72(sp)
  68:	6c06                	ld	s8,64(sp)
  6a:	6149                	addi	sp,sp,144
  6c:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
  6e:	00001617          	auipc	a2,0x1
  72:	a3a60613          	addi	a2,a2,-1478 # aa8 <path>
  76:	00001597          	auipc	a1,0x1
  7a:	99258593          	addi	a1,a1,-1646 # a08 <malloc+0xee>
  7e:	4509                	li	a0,2
  80:	00000097          	auipc	ra,0x0
  84:	7ae080e7          	jalr	1966(ra) # 82e <fprintf>
        return;
  88:	b7f9                	j	56 <find+0x56>
        fprintf(2, "find: cannot stat %s\n", path);
  8a:	00001617          	auipc	a2,0x1
  8e:	a1e60613          	addi	a2,a2,-1506 # aa8 <path>
  92:	00001597          	auipc	a1,0x1
  96:	98e58593          	addi	a1,a1,-1650 # a20 <malloc+0x106>
  9a:	4509                	li	a0,2
  9c:	00000097          	auipc	ra,0x0
  a0:	792080e7          	jalr	1938(ra) # 82e <fprintf>
        close(fd);
  a4:	8526                	mv	a0,s1
  a6:	00000097          	auipc	ra,0x0
  aa:	440080e7          	jalr	1088(ra) # 4e6 <close>
        return;
  ae:	b765                	j	56 <find+0x56>
    if (strlen(path) + 255 + 2 > sizeof(path)) {
  b0:	00001517          	auipc	a0,0x1
  b4:	9f850513          	addi	a0,a0,-1544 # aa8 <path>
  b8:	00000097          	auipc	ra,0x0
  bc:	1c4080e7          	jalr	452(ra) # 27c <strlen>
  c0:	1015051b          	addiw	a0,a0,257
  c4:	20000793          	li	a5,512
  c8:	0aa7e863          	bltu	a5,a0,178 <find+0x178>
    char *p = path + strlen(path) - 1;
  cc:	00001917          	auipc	s2,0x1
  d0:	9dc90913          	addi	s2,s2,-1572 # aa8 <path>
  d4:	854a                	mv	a0,s2
  d6:	00000097          	auipc	ra,0x0
  da:	1a6080e7          	jalr	422(ra) # 27c <strlen>
  de:	1502                	slli	a0,a0,0x20
  e0:	9101                	srli	a0,a0,0x20
  e2:	fff50793          	addi	a5,a0,-1
  e6:	993e                	add	s2,s2,a5
    if (*p != '/') {
  e8:	00094703          	lbu	a4,0(s2)
  ec:	02f00793          	li	a5,47
  f0:	00f70963          	beq	a4,a5,102 <find+0x102>
        *++p = '/';
  f4:	00f900a3          	sb	a5,1(s2)
  f8:	00001917          	auipc	s2,0x1
  fc:	9b090913          	addi	s2,s2,-1616 # aa8 <path>
 100:	992a                	add	s2,s2,a0
    p++;
 102:	0905                	addi	s2,s2,1
    while (readdir(fd, &st)) {
 104:	f7840993          	addi	s3,s0,-136
        if (strcmp(p, ".") == 0 || strcmp(p, "..") == 0) {
 108:	00001a97          	auipc	s5,0x1
 10c:	948a8a93          	addi	s5,s5,-1720 # a50 <malloc+0x136>
 110:	00001b17          	auipc	s6,0x1
 114:	948b0b13          	addi	s6,s6,-1720 # a58 <malloc+0x13e>
            fprintf(1, "%s\n", path);
 118:	00001c17          	auipc	s8,0x1
 11c:	990c0c13          	addi	s8,s8,-1648 # aa8 <path>
 120:	00001b97          	auipc	s7,0x1
 124:	940b8b93          	addi	s7,s7,-1728 # a60 <malloc+0x146>
    while (readdir(fd, &st)) {
 128:	85ce                	mv	a1,s3
 12a:	8526                	mv	a0,s1
 12c:	00000097          	auipc	ra,0x0
 130:	42a080e7          	jalr	1066(ra) # 556 <readdir>
 134:	c92d                	beqz	a0,1a6 <find+0x1a6>
        strcpy(p, st.name);
 136:	85ce                	mv	a1,s3
 138:	854a                	mv	a0,s2
 13a:	00000097          	auipc	ra,0x0
 13e:	0cc080e7          	jalr	204(ra) # 206 <strcpy>
        if (strcmp(p, ".") == 0 || strcmp(p, "..") == 0) {
 142:	85d6                	mv	a1,s5
 144:	854a                	mv	a0,s2
 146:	00000097          	auipc	ra,0x0
 14a:	10a080e7          	jalr	266(ra) # 250 <strcmp>
 14e:	dd69                	beqz	a0,128 <find+0x128>
 150:	85da                	mv	a1,s6
 152:	854a                	mv	a0,s2
 154:	00000097          	auipc	ra,0x0
 158:	0fc080e7          	jalr	252(ra) # 250 <strcmp>
 15c:	d571                	beqz	a0,128 <find+0x128>
        if (strcmp(p, filename) == 0) {
 15e:	85d2                	mv	a1,s4
 160:	854a                	mv	a0,s2
 162:	00000097          	auipc	ra,0x0
 166:	0ee080e7          	jalr	238(ra) # 250 <strcmp>
 16a:	c515                	beqz	a0,196 <find+0x196>
        find(filename);
 16c:	8552                	mv	a0,s4
 16e:	00000097          	auipc	ra,0x0
 172:	e92080e7          	jalr	-366(ra) # 0 <find>
 176:	bf4d                	j	128 <find+0x128>
        fprintf(2, "find: path too long\n");
 178:	00001597          	auipc	a1,0x1
 17c:	8c058593          	addi	a1,a1,-1856 # a38 <malloc+0x11e>
 180:	4509                	li	a0,2
 182:	00000097          	auipc	ra,0x0
 186:	6ac080e7          	jalr	1708(ra) # 82e <fprintf>
        close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	35a080e7          	jalr	858(ra) # 4e6 <close>
        return;
 194:	b5c9                	j	56 <find+0x56>
            fprintf(1, "%s\n", path);
 196:	8662                	mv	a2,s8
 198:	85de                	mv	a1,s7
 19a:	4505                	li	a0,1
 19c:	00000097          	auipc	ra,0x0
 1a0:	692080e7          	jalr	1682(ra) # 82e <fprintf>
 1a4:	b7e1                	j	16c <find+0x16c>
    close(fd);
 1a6:	8526                	mv	a0,s1
 1a8:	00000097          	auipc	ra,0x0
 1ac:	33e080e7          	jalr	830(ra) # 4e6 <close>
    return;
 1b0:	b55d                	j	56 <find+0x56>

00000000000001b2 <main>:


int main(int argc, char *argv[])
{
 1b2:	1101                	addi	sp,sp,-32
 1b4:	ec06                	sd	ra,24(sp)
 1b6:	e822                	sd	s0,16(sp)
 1b8:	e426                	sd	s1,8(sp)
 1ba:	1000                	addi	s0,sp,32
    if (argc < 3) {
 1bc:	4789                	li	a5,2
 1be:	02a7c063          	blt	a5,a0,1de <main+0x2c>
        fprintf(2, "Usage: find DIR FILENAME\n");
 1c2:	00001597          	auipc	a1,0x1
 1c6:	8a658593          	addi	a1,a1,-1882 # a68 <malloc+0x14e>
 1ca:	4509                	li	a0,2
 1cc:	00000097          	auipc	ra,0x0
 1d0:	662080e7          	jalr	1634(ra) # 82e <fprintf>
        exit(0);
 1d4:	4501                	li	a0,0
 1d6:	00000097          	auipc	ra,0x0
 1da:	2e8080e7          	jalr	744(ra) # 4be <exit>
 1de:	84ae                	mv	s1,a1
    } else {
        strcpy(path, argv[1]);
 1e0:	658c                	ld	a1,8(a1)
 1e2:	00001517          	auipc	a0,0x1
 1e6:	8c650513          	addi	a0,a0,-1850 # aa8 <path>
 1ea:	00000097          	auipc	ra,0x0
 1ee:	01c080e7          	jalr	28(ra) # 206 <strcpy>
        find(argv[2]);
 1f2:	6888                	ld	a0,16(s1)
 1f4:	00000097          	auipc	ra,0x0
 1f8:	e0c080e7          	jalr	-500(ra) # 0 <find>
    }
    exit(0);
 1fc:	4501                	li	a0,0
 1fe:	00000097          	auipc	ra,0x0
 202:	2c0080e7          	jalr	704(ra) # 4be <exit>

0000000000000206 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
 206:	1141                	addi	sp,sp,-16
 208:	e422                	sd	s0,8(sp)
 20a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 20c:	87aa                	mv	a5,a0
 20e:	0585                	addi	a1,a1,1
 210:	0785                	addi	a5,a5,1
 212:	fff5c703          	lbu	a4,-1(a1)
 216:	fee78fa3          	sb	a4,-1(a5)
 21a:	fb75                	bnez	a4,20e <strcpy+0x8>
    ;
  return os;
}
 21c:	6422                	ld	s0,8(sp)
 21e:	0141                	addi	sp,sp,16
 220:	8082                	ret

0000000000000222 <strcat>:

char*
strcat(char *s, const char *t)
{
 222:	1141                	addi	sp,sp,-16
 224:	e422                	sd	s0,8(sp)
 226:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
 228:	00054783          	lbu	a5,0(a0)
 22c:	c385                	beqz	a5,24c <strcat+0x2a>
 22e:	87aa                	mv	a5,a0
    s++;
 230:	0785                	addi	a5,a5,1
  while(*s)
 232:	0007c703          	lbu	a4,0(a5)
 236:	ff6d                	bnez	a4,230 <strcat+0xe>
  while((*s++ = *t++))
 238:	0585                	addi	a1,a1,1
 23a:	0785                	addi	a5,a5,1
 23c:	fff5c703          	lbu	a4,-1(a1)
 240:	fee78fa3          	sb	a4,-1(a5)
 244:	fb75                	bnez	a4,238 <strcat+0x16>
    ;
  return os;
}
 246:	6422                	ld	s0,8(sp)
 248:	0141                	addi	sp,sp,16
 24a:	8082                	ret
  while(*s)
 24c:	87aa                	mv	a5,a0
 24e:	b7ed                	j	238 <strcat+0x16>

0000000000000250 <strcmp>:


int
strcmp(const char *p, const char *q)
{
 250:	1141                	addi	sp,sp,-16
 252:	e422                	sd	s0,8(sp)
 254:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 256:	00054783          	lbu	a5,0(a0)
 25a:	cb91                	beqz	a5,26e <strcmp+0x1e>
 25c:	0005c703          	lbu	a4,0(a1)
 260:	00f71763          	bne	a4,a5,26e <strcmp+0x1e>
    p++, q++;
 264:	0505                	addi	a0,a0,1
 266:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 268:	00054783          	lbu	a5,0(a0)
 26c:	fbe5                	bnez	a5,25c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 26e:	0005c503          	lbu	a0,0(a1)
}
 272:	40a7853b          	subw	a0,a5,a0
 276:	6422                	ld	s0,8(sp)
 278:	0141                	addi	sp,sp,16
 27a:	8082                	ret

000000000000027c <strlen>:

uint
strlen(const char *s)
{
 27c:	1141                	addi	sp,sp,-16
 27e:	e422                	sd	s0,8(sp)
 280:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 282:	00054783          	lbu	a5,0(a0)
 286:	cf91                	beqz	a5,2a2 <strlen+0x26>
 288:	0505                	addi	a0,a0,1
 28a:	87aa                	mv	a5,a0
 28c:	4685                	li	a3,1
 28e:	9e89                	subw	a3,a3,a0
 290:	00f6853b          	addw	a0,a3,a5
 294:	0785                	addi	a5,a5,1
 296:	fff7c703          	lbu	a4,-1(a5)
 29a:	fb7d                	bnez	a4,290 <strlen+0x14>
    ;
  return n;
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
  for(n = 0; s[n]; n++)
 2a2:	4501                	li	a0,0
 2a4:	bfe5                	j	29c <strlen+0x20>

00000000000002a6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2ac:	ca19                	beqz	a2,2c2 <memset+0x1c>
 2ae:	87aa                	mv	a5,a0
 2b0:	1602                	slli	a2,a2,0x20
 2b2:	9201                	srli	a2,a2,0x20
 2b4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2b8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2bc:	0785                	addi	a5,a5,1
 2be:	fee79de3          	bne	a5,a4,2b8 <memset+0x12>
  }
  return dst;
}
 2c2:	6422                	ld	s0,8(sp)
 2c4:	0141                	addi	sp,sp,16
 2c6:	8082                	ret

00000000000002c8 <strchr>:

char*
strchr(const char *s, char c)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e422                	sd	s0,8(sp)
 2cc:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2ce:	00054783          	lbu	a5,0(a0)
 2d2:	cb99                	beqz	a5,2e8 <strchr+0x20>
    if(*s == c)
 2d4:	00f58763          	beq	a1,a5,2e2 <strchr+0x1a>
  for(; *s; s++)
 2d8:	0505                	addi	a0,a0,1
 2da:	00054783          	lbu	a5,0(a0)
 2de:	fbfd                	bnez	a5,2d4 <strchr+0xc>
      return (char*)s;
  return 0;
 2e0:	4501                	li	a0,0
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret
  return 0;
 2e8:	4501                	li	a0,0
 2ea:	bfe5                	j	2e2 <strchr+0x1a>

00000000000002ec <gets>:

char*
gets(char *buf, int max)
{
 2ec:	711d                	addi	sp,sp,-96
 2ee:	ec86                	sd	ra,88(sp)
 2f0:	e8a2                	sd	s0,80(sp)
 2f2:	e4a6                	sd	s1,72(sp)
 2f4:	e0ca                	sd	s2,64(sp)
 2f6:	fc4e                	sd	s3,56(sp)
 2f8:	f852                	sd	s4,48(sp)
 2fa:	f456                	sd	s5,40(sp)
 2fc:	f05a                	sd	s6,32(sp)
 2fe:	ec5e                	sd	s7,24(sp)
 300:	e862                	sd	s8,16(sp)
 302:	1080                	addi	s0,sp,96
 304:	8baa                	mv	s7,a0
 306:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 308:	892a                	mv	s2,a0
 30a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 30c:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 310:	4b29                	li	s6,10
 312:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 314:	89a6                	mv	s3,s1
 316:	2485                	addiw	s1,s1,1
 318:	0344d763          	bge	s1,s4,346 <gets+0x5a>
    cc = read(0, &c, 1);
 31c:	4605                	li	a2,1
 31e:	85d6                	mv	a1,s5
 320:	4501                	li	a0,0
 322:	00000097          	auipc	ra,0x0
 326:	1b4080e7          	jalr	436(ra) # 4d6 <read>
    if(cc < 1)
 32a:	00a05e63          	blez	a0,346 <gets+0x5a>
    buf[i++] = c;
 32e:	faf44783          	lbu	a5,-81(s0)
 332:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 336:	01678763          	beq	a5,s6,344 <gets+0x58>
 33a:	0905                	addi	s2,s2,1
 33c:	fd879ce3          	bne	a5,s8,314 <gets+0x28>
  for(i=0; i+1 < max; ){
 340:	89a6                	mv	s3,s1
 342:	a011                	j	346 <gets+0x5a>
 344:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 346:	99de                	add	s3,s3,s7
 348:	00098023          	sb	zero,0(s3)
  return buf;
}
 34c:	855e                	mv	a0,s7
 34e:	60e6                	ld	ra,88(sp)
 350:	6446                	ld	s0,80(sp)
 352:	64a6                	ld	s1,72(sp)
 354:	6906                	ld	s2,64(sp)
 356:	79e2                	ld	s3,56(sp)
 358:	7a42                	ld	s4,48(sp)
 35a:	7aa2                	ld	s5,40(sp)
 35c:	7b02                	ld	s6,32(sp)
 35e:	6be2                	ld	s7,24(sp)
 360:	6c42                	ld	s8,16(sp)
 362:	6125                	addi	sp,sp,96
 364:	8082                	ret

0000000000000366 <stat>:

int
stat(const char *n, struct stat *st)
{
 366:	1101                	addi	sp,sp,-32
 368:	ec06                	sd	ra,24(sp)
 36a:	e822                	sd	s0,16(sp)
 36c:	e426                	sd	s1,8(sp)
 36e:	e04a                	sd	s2,0(sp)
 370:	1000                	addi	s0,sp,32
 372:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 374:	4581                	li	a1,0
 376:	00000097          	auipc	ra,0x0
 37a:	188080e7          	jalr	392(ra) # 4fe <open>
  if(fd < 0)
 37e:	02054563          	bltz	a0,3a8 <stat+0x42>
 382:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 384:	85ca                	mv	a1,s2
 386:	00000097          	auipc	ra,0x0
 38a:	180080e7          	jalr	384(ra) # 506 <fstat>
 38e:	892a                	mv	s2,a0
  close(fd);
 390:	8526                	mv	a0,s1
 392:	00000097          	auipc	ra,0x0
 396:	154080e7          	jalr	340(ra) # 4e6 <close>
  return r;
}
 39a:	854a                	mv	a0,s2
 39c:	60e2                	ld	ra,24(sp)
 39e:	6442                	ld	s0,16(sp)
 3a0:	64a2                	ld	s1,8(sp)
 3a2:	6902                	ld	s2,0(sp)
 3a4:	6105                	addi	sp,sp,32
 3a6:	8082                	ret
    return -1;
 3a8:	597d                	li	s2,-1
 3aa:	bfc5                	j	39a <stat+0x34>

00000000000003ac <atoi>:

int
atoi(const char *s)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
 3b2:	00054703          	lbu	a4,0(a0)
 3b6:	02d00793          	li	a5,45
  int neg = 1;
 3ba:	4805                	li	a6,1
  if (*s == '-') {
 3bc:	04f70363          	beq	a4,a5,402 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
 3c0:	00054683          	lbu	a3,0(a0)
 3c4:	fd06879b          	addiw	a5,a3,-48
 3c8:	0ff7f793          	andi	a5,a5,255
 3cc:	4725                	li	a4,9
 3ce:	02f76d63          	bltu	a4,a5,408 <atoi+0x5c>
  n = 0;
 3d2:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
 3d4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3d6:	0505                	addi	a0,a0,1
 3d8:	0026179b          	slliw	a5,a2,0x2
 3dc:	9fb1                	addw	a5,a5,a2
 3de:	0017979b          	slliw	a5,a5,0x1
 3e2:	9fb5                	addw	a5,a5,a3
 3e4:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
 3e8:	00054683          	lbu	a3,0(a0)
 3ec:	fd06871b          	addiw	a4,a3,-48
 3f0:	0ff77713          	andi	a4,a4,255
 3f4:	fee5f1e3          	bgeu	a1,a4,3d6 <atoi+0x2a>
  return n * neg;
}
 3f8:	02c8053b          	mulw	a0,a6,a2
 3fc:	6422                	ld	s0,8(sp)
 3fe:	0141                	addi	sp,sp,16
 400:	8082                	ret
    s++;
 402:	0505                	addi	a0,a0,1
    neg = -1;
 404:	587d                	li	a6,-1
 406:	bf6d                	j	3c0 <atoi+0x14>
  n = 0;
 408:	4601                	li	a2,0
 40a:	b7fd                	j	3f8 <atoi+0x4c>

000000000000040c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 40c:	1141                	addi	sp,sp,-16
 40e:	e422                	sd	s0,8(sp)
 410:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 412:	02b57463          	bgeu	a0,a1,43a <memmove+0x2e>
    while(n-- > 0)
 416:	00c05f63          	blez	a2,434 <memmove+0x28>
 41a:	1602                	slli	a2,a2,0x20
 41c:	9201                	srli	a2,a2,0x20
 41e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 422:	872a                	mv	a4,a0
      *dst++ = *src++;
 424:	0585                	addi	a1,a1,1
 426:	0705                	addi	a4,a4,1
 428:	fff5c683          	lbu	a3,-1(a1)
 42c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 430:	fee79ae3          	bne	a5,a4,424 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 434:	6422                	ld	s0,8(sp)
 436:	0141                	addi	sp,sp,16
 438:	8082                	ret
    dst += n;
 43a:	00c50733          	add	a4,a0,a2
    src += n;
 43e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 440:	fec05ae3          	blez	a2,434 <memmove+0x28>
 444:	fff6079b          	addiw	a5,a2,-1
 448:	1782                	slli	a5,a5,0x20
 44a:	9381                	srli	a5,a5,0x20
 44c:	fff7c793          	not	a5,a5
 450:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 452:	15fd                	addi	a1,a1,-1
 454:	177d                	addi	a4,a4,-1
 456:	0005c683          	lbu	a3,0(a1)
 45a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 45e:	fee79ae3          	bne	a5,a4,452 <memmove+0x46>
 462:	bfc9                	j	434 <memmove+0x28>

0000000000000464 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 464:	1141                	addi	sp,sp,-16
 466:	e422                	sd	s0,8(sp)
 468:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 46a:	ca05                	beqz	a2,49a <memcmp+0x36>
 46c:	fff6069b          	addiw	a3,a2,-1
 470:	1682                	slli	a3,a3,0x20
 472:	9281                	srli	a3,a3,0x20
 474:	0685                	addi	a3,a3,1
 476:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 478:	00054783          	lbu	a5,0(a0)
 47c:	0005c703          	lbu	a4,0(a1)
 480:	00e79863          	bne	a5,a4,490 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 484:	0505                	addi	a0,a0,1
    p2++;
 486:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 488:	fed518e3          	bne	a0,a3,478 <memcmp+0x14>
  }
  return 0;
 48c:	4501                	li	a0,0
 48e:	a019                	j	494 <memcmp+0x30>
      return *p1 - *p2;
 490:	40e7853b          	subw	a0,a5,a4
}
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret
  return 0;
 49a:	4501                	li	a0,0
 49c:	bfe5                	j	494 <memcmp+0x30>

000000000000049e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 49e:	1141                	addi	sp,sp,-16
 4a0:	e406                	sd	ra,8(sp)
 4a2:	e022                	sd	s0,0(sp)
 4a4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4a6:	00000097          	auipc	ra,0x0
 4aa:	f66080e7          	jalr	-154(ra) # 40c <memmove>
}
 4ae:	60a2                	ld	ra,8(sp)
 4b0:	6402                	ld	s0,0(sp)
 4b2:	0141                	addi	sp,sp,16
 4b4:	8082                	ret

00000000000004b6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
 4b6:	4885                	li	a7,1
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <exit>:
.global exit
exit:
 li a7, SYS_exit
 4be:	4889                	li	a7,2
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4c6:	488d                	li	a7,3
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4ce:	4891                	li	a7,4
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <read>:
.global read
read:
 li a7, SYS_read
 4d6:	4895                	li	a7,5
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <write>:
.global write
write:
 li a7, SYS_write
 4de:	48c1                	li	a7,16
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <close>:
.global close
close:
 li a7, SYS_close
 4e6:	48d5                	li	a7,21
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <kill>:
.global kill
kill:
 li a7, SYS_kill
 4ee:	4899                	li	a7,6
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4f6:	489d                	li	a7,7
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <open>:
.global open
open:
 li a7, SYS_open
 4fe:	48bd                	li	a7,15
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 506:	48a1                	li	a7,8
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 50e:	48d1                	li	a7,20
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 516:	48a5                	li	a7,9
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <dup>:
.global dup
dup:
 li a7, SYS_dup
 51e:	48a9                	li	a7,10
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 526:	48ad                	li	a7,11
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 52e:	48b1                	li	a7,12
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 536:	48b5                	li	a7,13
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 53e:	48b9                	li	a7,14
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
 546:	48d9                	li	a7,22
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <dev>:
.global dev
dev:
 li a7, SYS_dev
 54e:	48dd                	li	a7,23
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
 556:	48e1                	li	a7,24
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 55e:	48e5                	li	a7,25
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <remove>:
.global remove
remove:
 li a7, SYS_remove
 566:	48c5                	li	a7,17
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <trace>:
.global trace
trace:
 li a7, SYS_trace
 56e:	48c9                	li	a7,18
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 576:	48cd                	li	a7,19
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <rename>:
.global rename
rename:
 li a7, SYS_rename
 57e:	48e9                	li	a7,26
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 586:	1101                	addi	sp,sp,-32
 588:	ec06                	sd	ra,24(sp)
 58a:	e822                	sd	s0,16(sp)
 58c:	1000                	addi	s0,sp,32
 58e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 592:	4605                	li	a2,1
 594:	fef40593          	addi	a1,s0,-17
 598:	00000097          	auipc	ra,0x0
 59c:	f46080e7          	jalr	-186(ra) # 4de <write>
}
 5a0:	60e2                	ld	ra,24(sp)
 5a2:	6442                	ld	s0,16(sp)
 5a4:	6105                	addi	sp,sp,32
 5a6:	8082                	ret

00000000000005a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5a8:	7139                	addi	sp,sp,-64
 5aa:	fc06                	sd	ra,56(sp)
 5ac:	f822                	sd	s0,48(sp)
 5ae:	f426                	sd	s1,40(sp)
 5b0:	f04a                	sd	s2,32(sp)
 5b2:	ec4e                	sd	s3,24(sp)
 5b4:	0080                	addi	s0,sp,64
 5b6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5b8:	c299                	beqz	a3,5be <printint+0x16>
 5ba:	0805c763          	bltz	a1,648 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5be:	2581                	sext.w	a1,a1
  neg = 0;
 5c0:	4881                	li	a7,0
  }

  i = 0;
 5c2:	fc040993          	addi	s3,s0,-64
  neg = 0;
 5c6:	86ce                	mv	a3,s3
  i = 0;
 5c8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ca:	2601                	sext.w	a2,a2
 5cc:	00000517          	auipc	a0,0x0
 5d0:	4c450513          	addi	a0,a0,1220 # a90 <digits>
 5d4:	883a                	mv	a6,a4
 5d6:	2705                	addiw	a4,a4,1
 5d8:	02c5f7bb          	remuw	a5,a1,a2
 5dc:	1782                	slli	a5,a5,0x20
 5de:	9381                	srli	a5,a5,0x20
 5e0:	97aa                	add	a5,a5,a0
 5e2:	0007c783          	lbu	a5,0(a5)
 5e6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5ea:	0005879b          	sext.w	a5,a1
 5ee:	02c5d5bb          	divuw	a1,a1,a2
 5f2:	0685                	addi	a3,a3,1
 5f4:	fec7f0e3          	bgeu	a5,a2,5d4 <printint+0x2c>
  if(neg)
 5f8:	00088b63          	beqz	a7,60e <printint+0x66>
    buf[i++] = '-';
 5fc:	fd040793          	addi	a5,s0,-48
 600:	973e                	add	a4,a4,a5
 602:	02d00793          	li	a5,45
 606:	fef70823          	sb	a5,-16(a4)
 60a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 60e:	02e05663          	blez	a4,63a <printint+0x92>
 612:	fc040913          	addi	s2,s0,-64
 616:	993a                	add	s2,s2,a4
 618:	19fd                	addi	s3,s3,-1
 61a:	99ba                	add	s3,s3,a4
 61c:	377d                	addiw	a4,a4,-1
 61e:	1702                	slli	a4,a4,0x20
 620:	9301                	srli	a4,a4,0x20
 622:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 626:	fff94583          	lbu	a1,-1(s2)
 62a:	8526                	mv	a0,s1
 62c:	00000097          	auipc	ra,0x0
 630:	f5a080e7          	jalr	-166(ra) # 586 <putc>
  while(--i >= 0)
 634:	197d                	addi	s2,s2,-1
 636:	ff3918e3          	bne	s2,s3,626 <printint+0x7e>
}
 63a:	70e2                	ld	ra,56(sp)
 63c:	7442                	ld	s0,48(sp)
 63e:	74a2                	ld	s1,40(sp)
 640:	7902                	ld	s2,32(sp)
 642:	69e2                	ld	s3,24(sp)
 644:	6121                	addi	sp,sp,64
 646:	8082                	ret
    x = -xx;
 648:	40b005bb          	negw	a1,a1
    neg = 1;
 64c:	4885                	li	a7,1
    x = -xx;
 64e:	bf95                	j	5c2 <printint+0x1a>

0000000000000650 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 650:	7119                	addi	sp,sp,-128
 652:	fc86                	sd	ra,120(sp)
 654:	f8a2                	sd	s0,112(sp)
 656:	f4a6                	sd	s1,104(sp)
 658:	f0ca                	sd	s2,96(sp)
 65a:	ecce                	sd	s3,88(sp)
 65c:	e8d2                	sd	s4,80(sp)
 65e:	e4d6                	sd	s5,72(sp)
 660:	e0da                	sd	s6,64(sp)
 662:	fc5e                	sd	s7,56(sp)
 664:	f862                	sd	s8,48(sp)
 666:	f466                	sd	s9,40(sp)
 668:	f06a                	sd	s10,32(sp)
 66a:	ec6e                	sd	s11,24(sp)
 66c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 66e:	0005c903          	lbu	s2,0(a1)
 672:	18090f63          	beqz	s2,810 <vprintf+0x1c0>
 676:	8aaa                	mv	s5,a0
 678:	8b32                	mv	s6,a2
 67a:	00158493          	addi	s1,a1,1
  state = 0;
 67e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 680:	02500a13          	li	s4,37
      if(c == 'd'){
 684:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 688:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 68c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 690:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 694:	00000b97          	auipc	s7,0x0
 698:	3fcb8b93          	addi	s7,s7,1020 # a90 <digits>
 69c:	a839                	j	6ba <vprintf+0x6a>
        putc(fd, c);
 69e:	85ca                	mv	a1,s2
 6a0:	8556                	mv	a0,s5
 6a2:	00000097          	auipc	ra,0x0
 6a6:	ee4080e7          	jalr	-284(ra) # 586 <putc>
 6aa:	a019                	j	6b0 <vprintf+0x60>
    } else if(state == '%'){
 6ac:	01498f63          	beq	s3,s4,6ca <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6b0:	0485                	addi	s1,s1,1
 6b2:	fff4c903          	lbu	s2,-1(s1)
 6b6:	14090d63          	beqz	s2,810 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6ba:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6be:	fe0997e3          	bnez	s3,6ac <vprintf+0x5c>
      if(c == '%'){
 6c2:	fd479ee3          	bne	a5,s4,69e <vprintf+0x4e>
        state = '%';
 6c6:	89be                	mv	s3,a5
 6c8:	b7e5                	j	6b0 <vprintf+0x60>
      if(c == 'd'){
 6ca:	05878063          	beq	a5,s8,70a <vprintf+0xba>
      } else if(c == 'l') {
 6ce:	05978c63          	beq	a5,s9,726 <vprintf+0xd6>
      } else if(c == 'x') {
 6d2:	07a78863          	beq	a5,s10,742 <vprintf+0xf2>
      } else if(c == 'p') {
 6d6:	09b78463          	beq	a5,s11,75e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6da:	07300713          	li	a4,115
 6de:	0ce78663          	beq	a5,a4,7aa <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6e2:	06300713          	li	a4,99
 6e6:	0ee78e63          	beq	a5,a4,7e2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6ea:	11478863          	beq	a5,s4,7fa <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ee:	85d2                	mv	a1,s4
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	e94080e7          	jalr	-364(ra) # 586 <putc>
        putc(fd, c);
 6fa:	85ca                	mv	a1,s2
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	e88080e7          	jalr	-376(ra) # 586 <putc>
      }
      state = 0;
 706:	4981                	li	s3,0
 708:	b765                	j	6b0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 70a:	008b0913          	addi	s2,s6,8
 70e:	4685                	li	a3,1
 710:	4629                	li	a2,10
 712:	000b2583          	lw	a1,0(s6)
 716:	8556                	mv	a0,s5
 718:	00000097          	auipc	ra,0x0
 71c:	e90080e7          	jalr	-368(ra) # 5a8 <printint>
 720:	8b4a                	mv	s6,s2
      state = 0;
 722:	4981                	li	s3,0
 724:	b771                	j	6b0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 726:	008b0913          	addi	s2,s6,8
 72a:	4681                	li	a3,0
 72c:	4629                	li	a2,10
 72e:	000b2583          	lw	a1,0(s6)
 732:	8556                	mv	a0,s5
 734:	00000097          	auipc	ra,0x0
 738:	e74080e7          	jalr	-396(ra) # 5a8 <printint>
 73c:	8b4a                	mv	s6,s2
      state = 0;
 73e:	4981                	li	s3,0
 740:	bf85                	j	6b0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 742:	008b0913          	addi	s2,s6,8
 746:	4681                	li	a3,0
 748:	4641                	li	a2,16
 74a:	000b2583          	lw	a1,0(s6)
 74e:	8556                	mv	a0,s5
 750:	00000097          	auipc	ra,0x0
 754:	e58080e7          	jalr	-424(ra) # 5a8 <printint>
 758:	8b4a                	mv	s6,s2
      state = 0;
 75a:	4981                	li	s3,0
 75c:	bf91                	j	6b0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 75e:	008b0793          	addi	a5,s6,8
 762:	f8f43423          	sd	a5,-120(s0)
 766:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 76a:	03000593          	li	a1,48
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e16080e7          	jalr	-490(ra) # 586 <putc>
  putc(fd, 'x');
 778:	85ea                	mv	a1,s10
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	e0a080e7          	jalr	-502(ra) # 586 <putc>
 784:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 786:	03c9d793          	srli	a5,s3,0x3c
 78a:	97de                	add	a5,a5,s7
 78c:	0007c583          	lbu	a1,0(a5)
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	df4080e7          	jalr	-524(ra) # 586 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 79a:	0992                	slli	s3,s3,0x4
 79c:	397d                	addiw	s2,s2,-1
 79e:	fe0914e3          	bnez	s2,786 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7a2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	b721                	j	6b0 <vprintf+0x60>
        s = va_arg(ap, char*);
 7aa:	008b0993          	addi	s3,s6,8
 7ae:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7b2:	02090163          	beqz	s2,7d4 <vprintf+0x184>
        while(*s != 0){
 7b6:	00094583          	lbu	a1,0(s2)
 7ba:	c9a1                	beqz	a1,80a <vprintf+0x1ba>
          putc(fd, *s);
 7bc:	8556                	mv	a0,s5
 7be:	00000097          	auipc	ra,0x0
 7c2:	dc8080e7          	jalr	-568(ra) # 586 <putc>
          s++;
 7c6:	0905                	addi	s2,s2,1
        while(*s != 0){
 7c8:	00094583          	lbu	a1,0(s2)
 7cc:	f9e5                	bnez	a1,7bc <vprintf+0x16c>
        s = va_arg(ap, char*);
 7ce:	8b4e                	mv	s6,s3
      state = 0;
 7d0:	4981                	li	s3,0
 7d2:	bdf9                	j	6b0 <vprintf+0x60>
          s = "(null)";
 7d4:	00000917          	auipc	s2,0x0
 7d8:	2b490913          	addi	s2,s2,692 # a88 <malloc+0x16e>
        while(*s != 0){
 7dc:	02800593          	li	a1,40
 7e0:	bff1                	j	7bc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7e2:	008b0913          	addi	s2,s6,8
 7e6:	000b4583          	lbu	a1,0(s6)
 7ea:	8556                	mv	a0,s5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	d9a080e7          	jalr	-614(ra) # 586 <putc>
 7f4:	8b4a                	mv	s6,s2
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	bd65                	j	6b0 <vprintf+0x60>
        putc(fd, c);
 7fa:	85d2                	mv	a1,s4
 7fc:	8556                	mv	a0,s5
 7fe:	00000097          	auipc	ra,0x0
 802:	d88080e7          	jalr	-632(ra) # 586 <putc>
      state = 0;
 806:	4981                	li	s3,0
 808:	b565                	j	6b0 <vprintf+0x60>
        s = va_arg(ap, char*);
 80a:	8b4e                	mv	s6,s3
      state = 0;
 80c:	4981                	li	s3,0
 80e:	b54d                	j	6b0 <vprintf+0x60>
    }
  }
}
 810:	70e6                	ld	ra,120(sp)
 812:	7446                	ld	s0,112(sp)
 814:	74a6                	ld	s1,104(sp)
 816:	7906                	ld	s2,96(sp)
 818:	69e6                	ld	s3,88(sp)
 81a:	6a46                	ld	s4,80(sp)
 81c:	6aa6                	ld	s5,72(sp)
 81e:	6b06                	ld	s6,64(sp)
 820:	7be2                	ld	s7,56(sp)
 822:	7c42                	ld	s8,48(sp)
 824:	7ca2                	ld	s9,40(sp)
 826:	7d02                	ld	s10,32(sp)
 828:	6de2                	ld	s11,24(sp)
 82a:	6109                	addi	sp,sp,128
 82c:	8082                	ret

000000000000082e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 82e:	715d                	addi	sp,sp,-80
 830:	ec06                	sd	ra,24(sp)
 832:	e822                	sd	s0,16(sp)
 834:	1000                	addi	s0,sp,32
 836:	e010                	sd	a2,0(s0)
 838:	e414                	sd	a3,8(s0)
 83a:	e818                	sd	a4,16(s0)
 83c:	ec1c                	sd	a5,24(s0)
 83e:	03043023          	sd	a6,32(s0)
 842:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 846:	8622                	mv	a2,s0
 848:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 84c:	00000097          	auipc	ra,0x0
 850:	e04080e7          	jalr	-508(ra) # 650 <vprintf>
}
 854:	60e2                	ld	ra,24(sp)
 856:	6442                	ld	s0,16(sp)
 858:	6161                	addi	sp,sp,80
 85a:	8082                	ret

000000000000085c <printf>:

void
printf(const char *fmt, ...)
{
 85c:	711d                	addi	sp,sp,-96
 85e:	ec06                	sd	ra,24(sp)
 860:	e822                	sd	s0,16(sp)
 862:	1000                	addi	s0,sp,32
 864:	e40c                	sd	a1,8(s0)
 866:	e810                	sd	a2,16(s0)
 868:	ec14                	sd	a3,24(s0)
 86a:	f018                	sd	a4,32(s0)
 86c:	f41c                	sd	a5,40(s0)
 86e:	03043823          	sd	a6,48(s0)
 872:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 876:	00840613          	addi	a2,s0,8
 87a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 87e:	85aa                	mv	a1,a0
 880:	4505                	li	a0,1
 882:	00000097          	auipc	ra,0x0
 886:	dce080e7          	jalr	-562(ra) # 650 <vprintf>
}
 88a:	60e2                	ld	ra,24(sp)
 88c:	6442                	ld	s0,16(sp)
 88e:	6125                	addi	sp,sp,96
 890:	8082                	ret

0000000000000892 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 892:	1141                	addi	sp,sp,-16
 894:	e422                	sd	s0,8(sp)
 896:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 898:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89c:	00000797          	auipc	a5,0x0
 8a0:	40c7b783          	ld	a5,1036(a5) # ca8 <freep>
 8a4:	a805                	j	8d4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a6:	4618                	lw	a4,8(a2)
 8a8:	9db9                	addw	a1,a1,a4
 8aa:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ae:	6398                	ld	a4,0(a5)
 8b0:	6318                	ld	a4,0(a4)
 8b2:	fee53823          	sd	a4,-16(a0)
 8b6:	a091                	j	8fa <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b8:	ff852703          	lw	a4,-8(a0)
 8bc:	9e39                	addw	a2,a2,a4
 8be:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8c0:	ff053703          	ld	a4,-16(a0)
 8c4:	e398                	sd	a4,0(a5)
 8c6:	a099                	j	90c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c8:	6398                	ld	a4,0(a5)
 8ca:	00e7e463          	bltu	a5,a4,8d2 <free+0x40>
 8ce:	00e6ea63          	bltu	a3,a4,8e2 <free+0x50>
{
 8d2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d4:	fed7fae3          	bgeu	a5,a3,8c8 <free+0x36>
 8d8:	6398                	ld	a4,0(a5)
 8da:	00e6e463          	bltu	a3,a4,8e2 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8de:	fee7eae3          	bltu	a5,a4,8d2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8e2:	ff852583          	lw	a1,-8(a0)
 8e6:	6390                	ld	a2,0(a5)
 8e8:	02059713          	slli	a4,a1,0x20
 8ec:	9301                	srli	a4,a4,0x20
 8ee:	0712                	slli	a4,a4,0x4
 8f0:	9736                	add	a4,a4,a3
 8f2:	fae60ae3          	beq	a2,a4,8a6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 8f6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8fa:	4790                	lw	a2,8(a5)
 8fc:	02061713          	slli	a4,a2,0x20
 900:	9301                	srli	a4,a4,0x20
 902:	0712                	slli	a4,a4,0x4
 904:	973e                	add	a4,a4,a5
 906:	fae689e3          	beq	a3,a4,8b8 <free+0x26>
  } else
    p->s.ptr = bp;
 90a:	e394                	sd	a3,0(a5)
  freep = p;
 90c:	00000717          	auipc	a4,0x0
 910:	38f73e23          	sd	a5,924(a4) # ca8 <freep>
}
 914:	6422                	ld	s0,8(sp)
 916:	0141                	addi	sp,sp,16
 918:	8082                	ret

000000000000091a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 91a:	7139                	addi	sp,sp,-64
 91c:	fc06                	sd	ra,56(sp)
 91e:	f822                	sd	s0,48(sp)
 920:	f426                	sd	s1,40(sp)
 922:	f04a                	sd	s2,32(sp)
 924:	ec4e                	sd	s3,24(sp)
 926:	e852                	sd	s4,16(sp)
 928:	e456                	sd	s5,8(sp)
 92a:	e05a                	sd	s6,0(sp)
 92c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 92e:	02051493          	slli	s1,a0,0x20
 932:	9081                	srli	s1,s1,0x20
 934:	04bd                	addi	s1,s1,15
 936:	8091                	srli	s1,s1,0x4
 938:	0014899b          	addiw	s3,s1,1
 93c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 93e:	00000517          	auipc	a0,0x0
 942:	36a53503          	ld	a0,874(a0) # ca8 <freep>
 946:	c515                	beqz	a0,972 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 948:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 94a:	4798                	lw	a4,8(a5)
 94c:	04977163          	bgeu	a4,s1,98e <malloc+0x74>
 950:	8a4e                	mv	s4,s3
 952:	0009871b          	sext.w	a4,s3
 956:	6685                	lui	a3,0x1
 958:	00d77363          	bgeu	a4,a3,95e <malloc+0x44>
 95c:	6a05                	lui	s4,0x1
 95e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 962:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 966:	00000917          	auipc	s2,0x0
 96a:	34290913          	addi	s2,s2,834 # ca8 <freep>
  if(p == (char*)-1)
 96e:	5afd                	li	s5,-1
 970:	a89d                	j	9e6 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 972:	00000797          	auipc	a5,0x0
 976:	33678793          	addi	a5,a5,822 # ca8 <freep>
 97a:	00000717          	auipc	a4,0x0
 97e:	33670713          	addi	a4,a4,822 # cb0 <base>
 982:	e398                	sd	a4,0(a5)
 984:	e798                	sd	a4,8(a5)
    base.s.size = 0;
 986:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 98a:	87ba                	mv	a5,a4
 98c:	b7d1                	j	950 <malloc+0x36>
      if(p->s.size == nunits)
 98e:	02e48b63          	beq	s1,a4,9c4 <malloc+0xaa>
        p->s.size -= nunits;
 992:	4137073b          	subw	a4,a4,s3
 996:	c798                	sw	a4,8(a5)
        p += p->s.size;
 998:	1702                	slli	a4,a4,0x20
 99a:	9301                	srli	a4,a4,0x20
 99c:	0712                	slli	a4,a4,0x4
 99e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9a0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a4:	00000717          	auipc	a4,0x0
 9a8:	30a73223          	sd	a0,772(a4) # ca8 <freep>
      return (void*)(p + 1);
 9ac:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9b0:	70e2                	ld	ra,56(sp)
 9b2:	7442                	ld	s0,48(sp)
 9b4:	74a2                	ld	s1,40(sp)
 9b6:	7902                	ld	s2,32(sp)
 9b8:	69e2                	ld	s3,24(sp)
 9ba:	6a42                	ld	s4,16(sp)
 9bc:	6aa2                	ld	s5,8(sp)
 9be:	6b02                	ld	s6,0(sp)
 9c0:	6121                	addi	sp,sp,64
 9c2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9c4:	6398                	ld	a4,0(a5)
 9c6:	e118                	sd	a4,0(a0)
 9c8:	bff1                	j	9a4 <malloc+0x8a>
  hp->s.size = nu;
 9ca:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ce:	0541                	addi	a0,a0,16
 9d0:	00000097          	auipc	ra,0x0
 9d4:	ec2080e7          	jalr	-318(ra) # 892 <free>
  return freep;
 9d8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9dc:	d971                	beqz	a0,9b0 <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9de:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e0:	4798                	lw	a4,8(a5)
 9e2:	fa9776e3          	bgeu	a4,s1,98e <malloc+0x74>
    if(p == freep)
 9e6:	00093703          	ld	a4,0(s2)
 9ea:	853e                	mv	a0,a5
 9ec:	fef719e3          	bne	a4,a5,9de <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 9f0:	8552                	mv	a0,s4
 9f2:	00000097          	auipc	ra,0x0
 9f6:	b3c080e7          	jalr	-1220(ra) # 52e <sbrk>
  if(p == (char*)-1)
 9fa:	fd5518e3          	bne	a0,s5,9ca <malloc+0xb0>
        return 0;
 9fe:	4501                	li	a0,0
 a00:	bf45                	j	9b0 <malloc+0x96>
