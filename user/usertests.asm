
xv6-user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00005097          	auipc	ra,0x5
      14:	938080e7          	jalr	-1736(ra) # 4948 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00005097          	auipc	ra,0x5
      26:	926080e7          	jalr	-1754(ra) # 4948 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00005517          	auipc	a0,0x5
      42:	0da50513          	addi	a0,a0,218 # 5118 <malloc+0x3b4>
      46:	00005097          	auipc	ra,0x5
      4a:	c60080e7          	jalr	-928(ra) # 4ca6 <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00005097          	auipc	ra,0x5
      54:	8b8080e7          	jalr	-1864(ra) # 4908 <exit>

0000000000000058 <validatetest>:
  } 
}

void
validatetest(char *s)
{
      58:	7139                	addi	sp,sp,-64
      5a:	fc06                	sd	ra,56(sp)
      5c:	f822                	sd	s0,48(sp)
      5e:	f426                	sd	s1,40(sp)
      60:	f04a                	sd	s2,32(sp)
      62:	ec4e                	sd	s3,24(sp)
      64:	e852                	sd	s4,16(sp)
      66:	e456                	sd	s5,8(sp)
      68:	e05a                	sd	s6,0(sp)
      6a:	0080                	addi	s0,sp,64
      6c:	8b2a                	mv	s6,a0
  int hi;
  uint64 p;

  hi = 1100*1024;
  for(p = 0; p <= (uint)hi; p += PGSIZE){
      6e:	4481                	li	s1,0
    // try to crash the kernel by passing in a bad string pointer
    if(open((char*)p, O_RDONLY) != -1){
      70:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
      72:	6a05                	lui	s4,0x1
      74:	001149b7          	lui	s3,0x114
    if(open((char*)p, O_RDONLY) != -1){
      78:	4581                	li	a1,0
      7a:	8526                	mv	a0,s1
      7c:	00005097          	auipc	ra,0x5
      80:	8cc080e7          	jalr	-1844(ra) # 4948 <open>
      84:	01251f63          	bne	a0,s2,a2 <validatetest+0x4a>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
      88:	94d2                	add	s1,s1,s4
      8a:	ff3497e3          	bne	s1,s3,78 <validatetest+0x20>
      printf("%s: link should not succeed\n", s);
      printf("bad string:[%s]\n", (char*)p);
      exit(1);
    }
  }
}
      8e:	70e2                	ld	ra,56(sp)
      90:	7442                	ld	s0,48(sp)
      92:	74a2                	ld	s1,40(sp)
      94:	7902                	ld	s2,32(sp)
      96:	69e2                	ld	s3,24(sp)
      98:	6a42                	ld	s4,16(sp)
      9a:	6aa2                	ld	s5,8(sp)
      9c:	6b02                	ld	s6,0(sp)
      9e:	6121                	addi	sp,sp,64
      a0:	8082                	ret
      printf("%s: link should not succeed\n", s);
      a2:	85da                	mv	a1,s6
      a4:	00005517          	auipc	a0,0x5
      a8:	09450513          	addi	a0,a0,148 # 5138 <malloc+0x3d4>
      ac:	00005097          	auipc	ra,0x5
      b0:	bfa080e7          	jalr	-1030(ra) # 4ca6 <printf>
      printf("bad string:[%s]\n", (char*)p);
      b4:	85a6                	mv	a1,s1
      b6:	00005517          	auipc	a0,0x5
      ba:	0a250513          	addi	a0,a0,162 # 5158 <malloc+0x3f4>
      be:	00005097          	auipc	ra,0x5
      c2:	be8080e7          	jalr	-1048(ra) # 4ca6 <printf>
      exit(1);
      c6:	4505                	li	a0,1
      c8:	00005097          	auipc	ra,0x5
      cc:	840080e7          	jalr	-1984(ra) # 4908 <exit>

00000000000000d0 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      d0:	00008797          	auipc	a5,0x8
      d4:	04078793          	addi	a5,a5,64 # 8110 <uninit>
      d8:	0000a697          	auipc	a3,0xa
      dc:	74868693          	addi	a3,a3,1864 # a820 <buf>
    if(uninit[i] != '\0'){
      e0:	0007c703          	lbu	a4,0(a5)
      e4:	e709                	bnez	a4,ee <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      e6:	0785                	addi	a5,a5,1
      e8:	fed79ce3          	bne	a5,a3,e0 <bsstest+0x10>
      ec:	8082                	ret
{
      ee:	1141                	addi	sp,sp,-16
      f0:	e406                	sd	ra,8(sp)
      f2:	e022                	sd	s0,0(sp)
      f4:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      f6:	85aa                	mv	a1,a0
      f8:	00005517          	auipc	a0,0x5
      fc:	07850513          	addi	a0,a0,120 # 5170 <malloc+0x40c>
     100:	00005097          	auipc	ra,0x5
     104:	ba6080e7          	jalr	-1114(ra) # 4ca6 <printf>
      exit(1);
     108:	4505                	li	a0,1
     10a:	00004097          	auipc	ra,0x4
     10e:	7fe080e7          	jalr	2046(ra) # 4908 <exit>

0000000000000112 <opentest>:
{
     112:	1101                	addi	sp,sp,-32
     114:	ec06                	sd	ra,24(sp)
     116:	e822                	sd	s0,16(sp)
     118:	e426                	sd	s1,8(sp)
     11a:	1000                	addi	s0,sp,32
     11c:	84aa                	mv	s1,a0
  fd = open("echo", 0);
     11e:	4581                	li	a1,0
     120:	00005517          	auipc	a0,0x5
     124:	06850513          	addi	a0,a0,104 # 5188 <malloc+0x424>
     128:	00005097          	auipc	ra,0x5
     12c:	820080e7          	jalr	-2016(ra) # 4948 <open>
  if(fd < 0){
     130:	02054663          	bltz	a0,15c <opentest+0x4a>
  close(fd);
     134:	00004097          	auipc	ra,0x4
     138:	7fc080e7          	jalr	2044(ra) # 4930 <close>
  fd = open("doesnotexist", 0);
     13c:	4581                	li	a1,0
     13e:	00005517          	auipc	a0,0x5
     142:	06a50513          	addi	a0,a0,106 # 51a8 <malloc+0x444>
     146:	00005097          	auipc	ra,0x5
     14a:	802080e7          	jalr	-2046(ra) # 4948 <open>
  if(fd >= 0){
     14e:	02055563          	bgez	a0,178 <opentest+0x66>
}
     152:	60e2                	ld	ra,24(sp)
     154:	6442                	ld	s0,16(sp)
     156:	64a2                	ld	s1,8(sp)
     158:	6105                	addi	sp,sp,32
     15a:	8082                	ret
    printf("%s: open echo failed!\n", s);
     15c:	85a6                	mv	a1,s1
     15e:	00005517          	auipc	a0,0x5
     162:	03250513          	addi	a0,a0,50 # 5190 <malloc+0x42c>
     166:	00005097          	auipc	ra,0x5
     16a:	b40080e7          	jalr	-1216(ra) # 4ca6 <printf>
    exit(1);
     16e:	4505                	li	a0,1
     170:	00004097          	auipc	ra,0x4
     174:	798080e7          	jalr	1944(ra) # 4908 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     178:	85a6                	mv	a1,s1
     17a:	00005517          	auipc	a0,0x5
     17e:	03e50513          	addi	a0,a0,62 # 51b8 <malloc+0x454>
     182:	00005097          	auipc	ra,0x5
     186:	b24080e7          	jalr	-1244(ra) # 4ca6 <printf>
    exit(1);
     18a:	4505                	li	a0,1
     18c:	00004097          	auipc	ra,0x4
     190:	77c080e7          	jalr	1916(ra) # 4908 <exit>

0000000000000194 <truncate2>:
{
     194:	7179                	addi	sp,sp,-48
     196:	f406                	sd	ra,40(sp)
     198:	f022                	sd	s0,32(sp)
     19a:	ec26                	sd	s1,24(sp)
     19c:	e84a                	sd	s2,16(sp)
     19e:	e44e                	sd	s3,8(sp)
     1a0:	1800                	addi	s0,sp,48
     1a2:	89aa                	mv	s3,a0
  remove("truncfile");
     1a4:	00005517          	auipc	a0,0x5
     1a8:	03c50513          	addi	a0,a0,60 # 51e0 <malloc+0x47c>
     1ac:	00005097          	auipc	ra,0x5
     1b0:	804080e7          	jalr	-2044(ra) # 49b0 <remove>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     1b4:	60100593          	li	a1,1537
     1b8:	00005517          	auipc	a0,0x5
     1bc:	02850513          	addi	a0,a0,40 # 51e0 <malloc+0x47c>
     1c0:	00004097          	auipc	ra,0x4
     1c4:	788080e7          	jalr	1928(ra) # 4948 <open>
     1c8:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     1ca:	4611                	li	a2,4
     1cc:	00005597          	auipc	a1,0x5
     1d0:	02458593          	addi	a1,a1,36 # 51f0 <malloc+0x48c>
     1d4:	00004097          	auipc	ra,0x4
     1d8:	754080e7          	jalr	1876(ra) # 4928 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     1dc:	40100593          	li	a1,1025
     1e0:	00005517          	auipc	a0,0x5
     1e4:	00050513          	mv	a0,a0
     1e8:	00004097          	auipc	ra,0x4
     1ec:	760080e7          	jalr	1888(ra) # 4948 <open>
     1f0:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     1f2:	4605                	li	a2,1
     1f4:	00005597          	auipc	a1,0x5
     1f8:	00458593          	addi	a1,a1,4 # 51f8 <malloc+0x494>
     1fc:	8526                	mv	a0,s1
     1fe:	00004097          	auipc	ra,0x4
     202:	72a080e7          	jalr	1834(ra) # 4928 <write>
  if(n != -1){
     206:	57fd                	li	a5,-1
     208:	02f51b63          	bne	a0,a5,23e <truncate2+0xaa>
  remove("truncfile");
     20c:	00005517          	auipc	a0,0x5
     210:	fd450513          	addi	a0,a0,-44 # 51e0 <malloc+0x47c>
     214:	00004097          	auipc	ra,0x4
     218:	79c080e7          	jalr	1948(ra) # 49b0 <remove>
  close(fd1);
     21c:	8526                	mv	a0,s1
     21e:	00004097          	auipc	ra,0x4
     222:	712080e7          	jalr	1810(ra) # 4930 <close>
  close(fd2);
     226:	854a                	mv	a0,s2
     228:	00004097          	auipc	ra,0x4
     22c:	708080e7          	jalr	1800(ra) # 4930 <close>
}
     230:	70a2                	ld	ra,40(sp)
     232:	7402                	ld	s0,32(sp)
     234:	64e2                	ld	s1,24(sp)
     236:	6942                	ld	s2,16(sp)
     238:	69a2                	ld	s3,8(sp)
     23a:	6145                	addi	sp,sp,48
     23c:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     23e:	862a                	mv	a2,a0
     240:	85ce                	mv	a1,s3
     242:	00005517          	auipc	a0,0x5
     246:	fbe50513          	addi	a0,a0,-66 # 5200 <malloc+0x49c>
     24a:	00005097          	auipc	ra,0x5
     24e:	a5c080e7          	jalr	-1444(ra) # 4ca6 <printf>
    exit(1);
     252:	4505                	li	a0,1
     254:	00004097          	auipc	ra,0x4
     258:	6b4080e7          	jalr	1716(ra) # 4908 <exit>

000000000000025c <createtest>:
{
     25c:	7179                	addi	sp,sp,-48
     25e:	f406                	sd	ra,40(sp)
     260:	f022                	sd	s0,32(sp)
     262:	ec26                	sd	s1,24(sp)
     264:	e84a                	sd	s2,16(sp)
     266:	e44e                	sd	s3,8(sp)
     268:	1800                	addi	s0,sp,48
  name[0] = 'a';
     26a:	00007797          	auipc	a5,0x7
     26e:	d9678793          	addi	a5,a5,-618 # 7000 <name>
     272:	06100713          	li	a4,97
     276:	00e78023          	sb	a4,0(a5)
  name[2] = '\0';
     27a:	00078123          	sb	zero,2(a5)
     27e:	03000493          	li	s1,48
    name[1] = '0' + i;
     282:	893e                	mv	s2,a5
  for(i = 0; i < N; i++){
     284:	06400993          	li	s3,100
    name[1] = '0' + i;
     288:	009900a3          	sb	s1,1(s2)
    fd = open(name, O_CREATE|O_RDWR);
     28c:	20200593          	li	a1,514
     290:	854a                	mv	a0,s2
     292:	00004097          	auipc	ra,0x4
     296:	6b6080e7          	jalr	1718(ra) # 4948 <open>
    close(fd);
     29a:	00004097          	auipc	ra,0x4
     29e:	696080e7          	jalr	1686(ra) # 4930 <close>
  for(i = 0; i < N; i++){
     2a2:	2485                	addiw	s1,s1,1
     2a4:	0ff4f493          	andi	s1,s1,255
     2a8:	ff3490e3          	bne	s1,s3,288 <createtest+0x2c>
  name[0] = 'a';
     2ac:	00007797          	auipc	a5,0x7
     2b0:	d5478793          	addi	a5,a5,-684 # 7000 <name>
     2b4:	06100713          	li	a4,97
     2b8:	00e78023          	sb	a4,0(a5)
  name[2] = '\0';
     2bc:	00078123          	sb	zero,2(a5)
     2c0:	03000493          	li	s1,48
    name[1] = '0' + i;
     2c4:	893e                	mv	s2,a5
  for(i = 0; i < N; i++){
     2c6:	06400993          	li	s3,100
    name[1] = '0' + i;
     2ca:	009900a3          	sb	s1,1(s2)
    remove(name);
     2ce:	854a                	mv	a0,s2
     2d0:	00004097          	auipc	ra,0x4
     2d4:	6e0080e7          	jalr	1760(ra) # 49b0 <remove>
  for(i = 0; i < N; i++){
     2d8:	2485                	addiw	s1,s1,1
     2da:	0ff4f493          	andi	s1,s1,255
     2de:	ff3496e3          	bne	s1,s3,2ca <createtest+0x6e>
}
     2e2:	70a2                	ld	ra,40(sp)
     2e4:	7402                	ld	s0,32(sp)
     2e6:	64e2                	ld	s1,24(sp)
     2e8:	6942                	ld	s2,16(sp)
     2ea:	69a2                	ld	s3,8(sp)
     2ec:	6145                	addi	sp,sp,48
     2ee:	8082                	ret

00000000000002f0 <bigwrite>:
{
     2f0:	715d                	addi	sp,sp,-80
     2f2:	e486                	sd	ra,72(sp)
     2f4:	e0a2                	sd	s0,64(sp)
     2f6:	fc26                	sd	s1,56(sp)
     2f8:	f84a                	sd	s2,48(sp)
     2fa:	f44e                	sd	s3,40(sp)
     2fc:	f052                	sd	s4,32(sp)
     2fe:	ec56                	sd	s5,24(sp)
     300:	e85a                	sd	s6,16(sp)
     302:	e45e                	sd	s7,8(sp)
     304:	0880                	addi	s0,sp,80
     306:	8baa                	mv	s7,a0
  remove("bigwrite");
     308:	00005517          	auipc	a0,0x5
     30c:	cd850513          	addi	a0,a0,-808 # 4fe0 <malloc+0x27c>
     310:	00004097          	auipc	ra,0x4
     314:	6a0080e7          	jalr	1696(ra) # 49b0 <remove>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     318:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     31c:	00005a97          	auipc	s5,0x5
     320:	cc4a8a93          	addi	s5,s5,-828 # 4fe0 <malloc+0x27c>
      int cc = write(fd, buf, sz);
     324:	0000aa17          	auipc	s4,0xa
     328:	4fca0a13          	addi	s4,s4,1276 # a820 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     32c:	6b09                	lui	s6,0x2
     32e:	807b0b13          	addi	s6,s6,-2041 # 1807 <forkfork+0x45>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     332:	20200593          	li	a1,514
     336:	8556                	mv	a0,s5
     338:	00004097          	auipc	ra,0x4
     33c:	610080e7          	jalr	1552(ra) # 4948 <open>
     340:	892a                	mv	s2,a0
    if(fd < 0){
     342:	04054d63          	bltz	a0,39c <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     346:	8626                	mv	a2,s1
     348:	85d2                	mv	a1,s4
     34a:	00004097          	auipc	ra,0x4
     34e:	5de080e7          	jalr	1502(ra) # 4928 <write>
     352:	89aa                	mv	s3,a0
      if(cc != sz){
     354:	06a49463          	bne	s1,a0,3bc <bigwrite+0xcc>
      int cc = write(fd, buf, sz);
     358:	8626                	mv	a2,s1
     35a:	85d2                	mv	a1,s4
     35c:	854a                	mv	a0,s2
     35e:	00004097          	auipc	ra,0x4
     362:	5ca080e7          	jalr	1482(ra) # 4928 <write>
      if(cc != sz){
     366:	04951963          	bne	a0,s1,3b8 <bigwrite+0xc8>
    close(fd);
     36a:	854a                	mv	a0,s2
     36c:	00004097          	auipc	ra,0x4
     370:	5c4080e7          	jalr	1476(ra) # 4930 <close>
    remove("bigwrite");
     374:	8556                	mv	a0,s5
     376:	00004097          	auipc	ra,0x4
     37a:	63a080e7          	jalr	1594(ra) # 49b0 <remove>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     37e:	1d74849b          	addiw	s1,s1,471
     382:	fb6498e3          	bne	s1,s6,332 <bigwrite+0x42>
}
     386:	60a6                	ld	ra,72(sp)
     388:	6406                	ld	s0,64(sp)
     38a:	74e2                	ld	s1,56(sp)
     38c:	7942                	ld	s2,48(sp)
     38e:	79a2                	ld	s3,40(sp)
     390:	7a02                	ld	s4,32(sp)
     392:	6ae2                	ld	s5,24(sp)
     394:	6b42                	ld	s6,16(sp)
     396:	6ba2                	ld	s7,8(sp)
     398:	6161                	addi	sp,sp,80
     39a:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     39c:	85de                	mv	a1,s7
     39e:	00005517          	auipc	a0,0x5
     3a2:	e8a50513          	addi	a0,a0,-374 # 5228 <malloc+0x4c4>
     3a6:	00005097          	auipc	ra,0x5
     3aa:	900080e7          	jalr	-1792(ra) # 4ca6 <printf>
      exit(1);
     3ae:	4505                	li	a0,1
     3b0:	00004097          	auipc	ra,0x4
     3b4:	558080e7          	jalr	1368(ra) # 4908 <exit>
     3b8:	84ce                	mv	s1,s3
      int cc = write(fd, buf, sz);
     3ba:	89aa                	mv	s3,a0
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     3bc:	86ce                	mv	a3,s3
     3be:	8626                	mv	a2,s1
     3c0:	85de                	mv	a1,s7
     3c2:	00005517          	auipc	a0,0x5
     3c6:	e8650513          	addi	a0,a0,-378 # 5248 <malloc+0x4e4>
     3ca:	00005097          	auipc	ra,0x5
     3ce:	8dc080e7          	jalr	-1828(ra) # 4ca6 <printf>
        exit(1);
     3d2:	4505                	li	a0,1
     3d4:	00004097          	auipc	ra,0x4
     3d8:	534080e7          	jalr	1332(ra) # 4908 <exit>

00000000000003dc <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     3dc:	7179                	addi	sp,sp,-48
     3de:	f406                	sd	ra,40(sp)
     3e0:	f022                	sd	s0,32(sp)
     3e2:	ec26                	sd	s1,24(sp)
     3e4:	e84a                	sd	s2,16(sp)
     3e6:	e44e                	sd	s3,8(sp)
     3e8:	e052                	sd	s4,0(sp)
     3ea:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  remove("junk");
     3ec:	00005517          	auipc	a0,0x5
     3f0:	e7450513          	addi	a0,a0,-396 # 5260 <malloc+0x4fc>
     3f4:	00004097          	auipc	ra,0x4
     3f8:	5bc080e7          	jalr	1468(ra) # 49b0 <remove>
     3fc:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     400:	00005997          	auipc	s3,0x5
     404:	e6098993          	addi	s3,s3,-416 # 5260 <malloc+0x4fc>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     408:	5a7d                	li	s4,-1
     40a:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     40e:	20100593          	li	a1,513
     412:	854e                	mv	a0,s3
     414:	00004097          	auipc	ra,0x4
     418:	534080e7          	jalr	1332(ra) # 4948 <open>
     41c:	84aa                	mv	s1,a0
    if(fd < 0){
     41e:	06054b63          	bltz	a0,494 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
     422:	4605                	li	a2,1
     424:	85d2                	mv	a1,s4
     426:	00004097          	auipc	ra,0x4
     42a:	502080e7          	jalr	1282(ra) # 4928 <write>
    close(fd);
     42e:	8526                	mv	a0,s1
     430:	00004097          	auipc	ra,0x4
     434:	500080e7          	jalr	1280(ra) # 4930 <close>
    remove("junk");
     438:	854e                	mv	a0,s3
     43a:	00004097          	auipc	ra,0x4
     43e:	576080e7          	jalr	1398(ra) # 49b0 <remove>
  for(int i = 0; i < assumed_free; i++){
     442:	397d                	addiw	s2,s2,-1
     444:	fc0915e3          	bnez	s2,40e <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     448:	20100593          	li	a1,513
     44c:	00005517          	auipc	a0,0x5
     450:	e1450513          	addi	a0,a0,-492 # 5260 <malloc+0x4fc>
     454:	00004097          	auipc	ra,0x4
     458:	4f4080e7          	jalr	1268(ra) # 4948 <open>
     45c:	84aa                	mv	s1,a0
  if(fd < 0){
     45e:	04054863          	bltz	a0,4ae <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     462:	4605                	li	a2,1
     464:	00005597          	auipc	a1,0x5
     468:	d9458593          	addi	a1,a1,-620 # 51f8 <malloc+0x494>
     46c:	00004097          	auipc	ra,0x4
     470:	4bc080e7          	jalr	1212(ra) # 4928 <write>
     474:	4785                	li	a5,1
     476:	04f50963          	beq	a0,a5,4c8 <badwrite+0xec>
    printf("write failed\n");
     47a:	00005517          	auipc	a0,0x5
     47e:	e0650513          	addi	a0,a0,-506 # 5280 <malloc+0x51c>
     482:	00005097          	auipc	ra,0x5
     486:	824080e7          	jalr	-2012(ra) # 4ca6 <printf>
    exit(1);
     48a:	4505                	li	a0,1
     48c:	00004097          	auipc	ra,0x4
     490:	47c080e7          	jalr	1148(ra) # 4908 <exit>
      printf("open junk failed\n");
     494:	00005517          	auipc	a0,0x5
     498:	dd450513          	addi	a0,a0,-556 # 5268 <malloc+0x504>
     49c:	00005097          	auipc	ra,0x5
     4a0:	80a080e7          	jalr	-2038(ra) # 4ca6 <printf>
      exit(1);
     4a4:	4505                	li	a0,1
     4a6:	00004097          	auipc	ra,0x4
     4aa:	462080e7          	jalr	1122(ra) # 4908 <exit>
    printf("open junk failed\n");
     4ae:	00005517          	auipc	a0,0x5
     4b2:	dba50513          	addi	a0,a0,-582 # 5268 <malloc+0x504>
     4b6:	00004097          	auipc	ra,0x4
     4ba:	7f0080e7          	jalr	2032(ra) # 4ca6 <printf>
    exit(1);
     4be:	4505                	li	a0,1
     4c0:	00004097          	auipc	ra,0x4
     4c4:	448080e7          	jalr	1096(ra) # 4908 <exit>
  }
  close(fd);
     4c8:	8526                	mv	a0,s1
     4ca:	00004097          	auipc	ra,0x4
     4ce:	466080e7          	jalr	1126(ra) # 4930 <close>
  remove("junk");
     4d2:	00005517          	auipc	a0,0x5
     4d6:	d8e50513          	addi	a0,a0,-626 # 5260 <malloc+0x4fc>
     4da:	00004097          	auipc	ra,0x4
     4de:	4d6080e7          	jalr	1238(ra) # 49b0 <remove>

  exit(0);
     4e2:	4501                	li	a0,0
     4e4:	00004097          	auipc	ra,0x4
     4e8:	424080e7          	jalr	1060(ra) # 4908 <exit>

00000000000004ec <copyin>:
{
     4ec:	7159                	addi	sp,sp,-112
     4ee:	f486                	sd	ra,104(sp)
     4f0:	f0a2                	sd	s0,96(sp)
     4f2:	eca6                	sd	s1,88(sp)
     4f4:	e8ca                	sd	s2,80(sp)
     4f6:	e4ce                	sd	s3,72(sp)
     4f8:	e0d2                	sd	s4,64(sp)
     4fa:	fc56                	sd	s5,56(sp)
     4fc:	1880                	addi	s0,sp,112
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     4fe:	4785                	li	a5,1
     500:	07fe                	slli	a5,a5,0x1f
     502:	faf43823          	sd	a5,-80(s0)
     506:	57fd                	li	a5,-1
     508:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     50c:	fb040913          	addi	s2,s0,-80
     510:	fc040793          	addi	a5,s0,-64
     514:	f8f43c23          	sd	a5,-104(s0)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     518:	00005a17          	auipc	s4,0x5
     51c:	d78a0a13          	addi	s4,s4,-648 # 5290 <malloc+0x52c>
    if(pipe(fds) < 0){
     520:	fa840a93          	addi	s5,s0,-88
    uint64 addr = addrs[ai];
     524:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     528:	20100593          	li	a1,513
     52c:	8552                	mv	a0,s4
     52e:	00004097          	auipc	ra,0x4
     532:	41a080e7          	jalr	1050(ra) # 4948 <open>
     536:	84aa                	mv	s1,a0
    if(fd < 0){
     538:	08054863          	bltz	a0,5c8 <copyin+0xdc>
    int n = write(fd, (void*)addr, 8192);
     53c:	6609                	lui	a2,0x2
     53e:	85ce                	mv	a1,s3
     540:	00004097          	auipc	ra,0x4
     544:	3e8080e7          	jalr	1000(ra) # 4928 <write>
    if(n >= 0){
     548:	08055d63          	bgez	a0,5e2 <copyin+0xf6>
    close(fd);
     54c:	8526                	mv	a0,s1
     54e:	00004097          	auipc	ra,0x4
     552:	3e2080e7          	jalr	994(ra) # 4930 <close>
    remove("copyin1");
     556:	8552                	mv	a0,s4
     558:	00004097          	auipc	ra,0x4
     55c:	458080e7          	jalr	1112(ra) # 49b0 <remove>
    n = write(1, (char*)addr, 8192);
     560:	6609                	lui	a2,0x2
     562:	85ce                	mv	a1,s3
     564:	4505                	li	a0,1
     566:	00004097          	auipc	ra,0x4
     56a:	3c2080e7          	jalr	962(ra) # 4928 <write>
    if(n > 0){
     56e:	08a04963          	bgtz	a0,600 <copyin+0x114>
    if(pipe(fds) < 0){
     572:	8556                	mv	a0,s5
     574:	00004097          	auipc	ra,0x4
     578:	3a4080e7          	jalr	932(ra) # 4918 <pipe>
     57c:	0a054163          	bltz	a0,61e <copyin+0x132>
    n = write(fds[1], (char*)addr, 8192);
     580:	6609                	lui	a2,0x2
     582:	85ce                	mv	a1,s3
     584:	fac42503          	lw	a0,-84(s0)
     588:	00004097          	auipc	ra,0x4
     58c:	3a0080e7          	jalr	928(ra) # 4928 <write>
    if(n > 0){
     590:	0aa04463          	bgtz	a0,638 <copyin+0x14c>
    close(fds[0]);
     594:	fa842503          	lw	a0,-88(s0)
     598:	00004097          	auipc	ra,0x4
     59c:	398080e7          	jalr	920(ra) # 4930 <close>
    close(fds[1]);
     5a0:	fac42503          	lw	a0,-84(s0)
     5a4:	00004097          	auipc	ra,0x4
     5a8:	38c080e7          	jalr	908(ra) # 4930 <close>
  for(int ai = 0; ai < 2; ai++){
     5ac:	0921                	addi	s2,s2,8
     5ae:	f9843783          	ld	a5,-104(s0)
     5b2:	f6f919e3          	bne	s2,a5,524 <copyin+0x38>
}
     5b6:	70a6                	ld	ra,104(sp)
     5b8:	7406                	ld	s0,96(sp)
     5ba:	64e6                	ld	s1,88(sp)
     5bc:	6946                	ld	s2,80(sp)
     5be:	69a6                	ld	s3,72(sp)
     5c0:	6a06                	ld	s4,64(sp)
     5c2:	7ae2                	ld	s5,56(sp)
     5c4:	6165                	addi	sp,sp,112
     5c6:	8082                	ret
      printf("open(copyin1) failed\n");
     5c8:	00005517          	auipc	a0,0x5
     5cc:	cd050513          	addi	a0,a0,-816 # 5298 <malloc+0x534>
     5d0:	00004097          	auipc	ra,0x4
     5d4:	6d6080e7          	jalr	1750(ra) # 4ca6 <printf>
      exit(1);
     5d8:	4505                	li	a0,1
     5da:	00004097          	auipc	ra,0x4
     5de:	32e080e7          	jalr	814(ra) # 4908 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     5e2:	862a                	mv	a2,a0
     5e4:	85ce                	mv	a1,s3
     5e6:	00005517          	auipc	a0,0x5
     5ea:	cca50513          	addi	a0,a0,-822 # 52b0 <malloc+0x54c>
     5ee:	00004097          	auipc	ra,0x4
     5f2:	6b8080e7          	jalr	1720(ra) # 4ca6 <printf>
      exit(1);
     5f6:	4505                	li	a0,1
     5f8:	00004097          	auipc	ra,0x4
     5fc:	310080e7          	jalr	784(ra) # 4908 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     600:	862a                	mv	a2,a0
     602:	85ce                	mv	a1,s3
     604:	00005517          	auipc	a0,0x5
     608:	cdc50513          	addi	a0,a0,-804 # 52e0 <malloc+0x57c>
     60c:	00004097          	auipc	ra,0x4
     610:	69a080e7          	jalr	1690(ra) # 4ca6 <printf>
      exit(1);
     614:	4505                	li	a0,1
     616:	00004097          	auipc	ra,0x4
     61a:	2f2080e7          	jalr	754(ra) # 4908 <exit>
      printf("pipe() failed\n");
     61e:	00005517          	auipc	a0,0x5
     622:	cf250513          	addi	a0,a0,-782 # 5310 <malloc+0x5ac>
     626:	00004097          	auipc	ra,0x4
     62a:	680080e7          	jalr	1664(ra) # 4ca6 <printf>
      exit(1);
     62e:	4505                	li	a0,1
     630:	00004097          	auipc	ra,0x4
     634:	2d8080e7          	jalr	728(ra) # 4908 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     638:	862a                	mv	a2,a0
     63a:	85ce                	mv	a1,s3
     63c:	00005517          	auipc	a0,0x5
     640:	ce450513          	addi	a0,a0,-796 # 5320 <malloc+0x5bc>
     644:	00004097          	auipc	ra,0x4
     648:	662080e7          	jalr	1634(ra) # 4ca6 <printf>
      exit(1);
     64c:	4505                	li	a0,1
     64e:	00004097          	auipc	ra,0x4
     652:	2ba080e7          	jalr	698(ra) # 4908 <exit>

0000000000000656 <copyout>:
{
     656:	7159                	addi	sp,sp,-112
     658:	f486                	sd	ra,104(sp)
     65a:	f0a2                	sd	s0,96(sp)
     65c:	eca6                	sd	s1,88(sp)
     65e:	e8ca                	sd	s2,80(sp)
     660:	e4ce                	sd	s3,72(sp)
     662:	e0d2                	sd	s4,64(sp)
     664:	fc56                	sd	s5,56(sp)
     666:	f85a                	sd	s6,48(sp)
     668:	1880                	addi	s0,sp,112
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     66a:	4785                	li	a5,1
     66c:	07fe                	slli	a5,a5,0x1f
     66e:	faf43823          	sd	a5,-80(s0)
     672:	57fd                	li	a5,-1
     674:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     678:	fb040913          	addi	s2,s0,-80
     67c:	fc040793          	addi	a5,s0,-64
     680:	f8f43c23          	sd	a5,-104(s0)
    int fd = open("README", 0);
     684:	00005a97          	auipc	s5,0x5
     688:	ccca8a93          	addi	s5,s5,-820 # 5350 <malloc+0x5ec>
    if(pipe(fds) < 0){
     68c:	fa840a13          	addi	s4,s0,-88
    n = write(fds[1], "x", 1);
     690:	00005b17          	auipc	s6,0x5
     694:	b68b0b13          	addi	s6,s6,-1176 # 51f8 <malloc+0x494>
    uint64 addr = addrs[ai];
     698:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     69c:	4581                	li	a1,0
     69e:	8556                	mv	a0,s5
     6a0:	00004097          	auipc	ra,0x4
     6a4:	2a8080e7          	jalr	680(ra) # 4948 <open>
     6a8:	84aa                	mv	s1,a0
    if(fd < 0){
     6aa:	08054663          	bltz	a0,736 <copyout+0xe0>
    int n = read(fd, (void*)addr, 8192);
     6ae:	6609                	lui	a2,0x2
     6b0:	85ce                	mv	a1,s3
     6b2:	00004097          	auipc	ra,0x4
     6b6:	26e080e7          	jalr	622(ra) # 4920 <read>
    if(n > 0){
     6ba:	08a04b63          	bgtz	a0,750 <copyout+0xfa>
    close(fd);
     6be:	8526                	mv	a0,s1
     6c0:	00004097          	auipc	ra,0x4
     6c4:	270080e7          	jalr	624(ra) # 4930 <close>
    if(pipe(fds) < 0){
     6c8:	8552                	mv	a0,s4
     6ca:	00004097          	auipc	ra,0x4
     6ce:	24e080e7          	jalr	590(ra) # 4918 <pipe>
     6d2:	08054e63          	bltz	a0,76e <copyout+0x118>
    n = write(fds[1], "x", 1);
     6d6:	4605                	li	a2,1
     6d8:	85da                	mv	a1,s6
     6da:	fac42503          	lw	a0,-84(s0)
     6de:	00004097          	auipc	ra,0x4
     6e2:	24a080e7          	jalr	586(ra) # 4928 <write>
    if(n != 1){
     6e6:	4785                	li	a5,1
     6e8:	0af51063          	bne	a0,a5,788 <copyout+0x132>
    n = read(fds[0], (void*)addr, 8192);
     6ec:	6609                	lui	a2,0x2
     6ee:	85ce                	mv	a1,s3
     6f0:	fa842503          	lw	a0,-88(s0)
     6f4:	00004097          	auipc	ra,0x4
     6f8:	22c080e7          	jalr	556(ra) # 4920 <read>
    if(n > 0){
     6fc:	0aa04363          	bgtz	a0,7a2 <copyout+0x14c>
    close(fds[0]);
     700:	fa842503          	lw	a0,-88(s0)
     704:	00004097          	auipc	ra,0x4
     708:	22c080e7          	jalr	556(ra) # 4930 <close>
    close(fds[1]);
     70c:	fac42503          	lw	a0,-84(s0)
     710:	00004097          	auipc	ra,0x4
     714:	220080e7          	jalr	544(ra) # 4930 <close>
  for(int ai = 0; ai < 2; ai++){
     718:	0921                	addi	s2,s2,8
     71a:	f9843783          	ld	a5,-104(s0)
     71e:	f6f91de3          	bne	s2,a5,698 <copyout+0x42>
}
     722:	70a6                	ld	ra,104(sp)
     724:	7406                	ld	s0,96(sp)
     726:	64e6                	ld	s1,88(sp)
     728:	6946                	ld	s2,80(sp)
     72a:	69a6                	ld	s3,72(sp)
     72c:	6a06                	ld	s4,64(sp)
     72e:	7ae2                	ld	s5,56(sp)
     730:	7b42                	ld	s6,48(sp)
     732:	6165                	addi	sp,sp,112
     734:	8082                	ret
      printf("open(README) failed\n");
     736:	00005517          	auipc	a0,0x5
     73a:	c2250513          	addi	a0,a0,-990 # 5358 <malloc+0x5f4>
     73e:	00004097          	auipc	ra,0x4
     742:	568080e7          	jalr	1384(ra) # 4ca6 <printf>
      exit(1);
     746:	4505                	li	a0,1
     748:	00004097          	auipc	ra,0x4
     74c:	1c0080e7          	jalr	448(ra) # 4908 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     750:	862a                	mv	a2,a0
     752:	85ce                	mv	a1,s3
     754:	00005517          	auipc	a0,0x5
     758:	c1c50513          	addi	a0,a0,-996 # 5370 <malloc+0x60c>
     75c:	00004097          	auipc	ra,0x4
     760:	54a080e7          	jalr	1354(ra) # 4ca6 <printf>
      exit(1);
     764:	4505                	li	a0,1
     766:	00004097          	auipc	ra,0x4
     76a:	1a2080e7          	jalr	418(ra) # 4908 <exit>
      printf("pipe() failed\n");
     76e:	00005517          	auipc	a0,0x5
     772:	ba250513          	addi	a0,a0,-1118 # 5310 <malloc+0x5ac>
     776:	00004097          	auipc	ra,0x4
     77a:	530080e7          	jalr	1328(ra) # 4ca6 <printf>
      exit(1);
     77e:	4505                	li	a0,1
     780:	00004097          	auipc	ra,0x4
     784:	188080e7          	jalr	392(ra) # 4908 <exit>
      printf("pipe write failed\n");
     788:	00005517          	auipc	a0,0x5
     78c:	c1850513          	addi	a0,a0,-1000 # 53a0 <malloc+0x63c>
     790:	00004097          	auipc	ra,0x4
     794:	516080e7          	jalr	1302(ra) # 4ca6 <printf>
      exit(1);
     798:	4505                	li	a0,1
     79a:	00004097          	auipc	ra,0x4
     79e:	16e080e7          	jalr	366(ra) # 4908 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7a2:	862a                	mv	a2,a0
     7a4:	85ce                	mv	a1,s3
     7a6:	00005517          	auipc	a0,0x5
     7aa:	c1250513          	addi	a0,a0,-1006 # 53b8 <malloc+0x654>
     7ae:	00004097          	auipc	ra,0x4
     7b2:	4f8080e7          	jalr	1272(ra) # 4ca6 <printf>
      exit(1);
     7b6:	4505                	li	a0,1
     7b8:	00004097          	auipc	ra,0x4
     7bc:	150080e7          	jalr	336(ra) # 4908 <exit>

00000000000007c0 <truncate1>:
{
     7c0:	711d                	addi	sp,sp,-96
     7c2:	ec86                	sd	ra,88(sp)
     7c4:	e8a2                	sd	s0,80(sp)
     7c6:	e4a6                	sd	s1,72(sp)
     7c8:	e0ca                	sd	s2,64(sp)
     7ca:	fc4e                	sd	s3,56(sp)
     7cc:	f852                	sd	s4,48(sp)
     7ce:	f456                	sd	s5,40(sp)
     7d0:	1080                	addi	s0,sp,96
     7d2:	8aaa                	mv	s5,a0
  remove("truncfile");
     7d4:	00005517          	auipc	a0,0x5
     7d8:	a0c50513          	addi	a0,a0,-1524 # 51e0 <malloc+0x47c>
     7dc:	00004097          	auipc	ra,0x4
     7e0:	1d4080e7          	jalr	468(ra) # 49b0 <remove>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     7e4:	60100593          	li	a1,1537
     7e8:	00005517          	auipc	a0,0x5
     7ec:	9f850513          	addi	a0,a0,-1544 # 51e0 <malloc+0x47c>
     7f0:	00004097          	auipc	ra,0x4
     7f4:	158080e7          	jalr	344(ra) # 4948 <open>
     7f8:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     7fa:	4611                	li	a2,4
     7fc:	00005597          	auipc	a1,0x5
     800:	9f458593          	addi	a1,a1,-1548 # 51f0 <malloc+0x48c>
     804:	00004097          	auipc	ra,0x4
     808:	124080e7          	jalr	292(ra) # 4928 <write>
  close(fd1);
     80c:	8526                	mv	a0,s1
     80e:	00004097          	auipc	ra,0x4
     812:	122080e7          	jalr	290(ra) # 4930 <close>
  int fd2 = open("truncfile", O_RDONLY);
     816:	4581                	li	a1,0
     818:	00005517          	auipc	a0,0x5
     81c:	9c850513          	addi	a0,a0,-1592 # 51e0 <malloc+0x47c>
     820:	00004097          	auipc	ra,0x4
     824:	128080e7          	jalr	296(ra) # 4948 <open>
     828:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     82a:	02000613          	li	a2,32
     82e:	fa040593          	addi	a1,s0,-96
     832:	00004097          	auipc	ra,0x4
     836:	0ee080e7          	jalr	238(ra) # 4920 <read>
  if(n != 4){
     83a:	4791                	li	a5,4
     83c:	0cf51e63          	bne	a0,a5,918 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     840:	40100593          	li	a1,1025
     844:	00005517          	auipc	a0,0x5
     848:	99c50513          	addi	a0,a0,-1636 # 51e0 <malloc+0x47c>
     84c:	00004097          	auipc	ra,0x4
     850:	0fc080e7          	jalr	252(ra) # 4948 <open>
     854:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     856:	4581                	li	a1,0
     858:	00005517          	auipc	a0,0x5
     85c:	98850513          	addi	a0,a0,-1656 # 51e0 <malloc+0x47c>
     860:	00004097          	auipc	ra,0x4
     864:	0e8080e7          	jalr	232(ra) # 4948 <open>
     868:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     86a:	02000613          	li	a2,32
     86e:	fa040593          	addi	a1,s0,-96
     872:	00004097          	auipc	ra,0x4
     876:	0ae080e7          	jalr	174(ra) # 4920 <read>
     87a:	8a2a                	mv	s4,a0
  if(n != 0){
     87c:	ed4d                	bnez	a0,936 <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     87e:	02000613          	li	a2,32
     882:	fa040593          	addi	a1,s0,-96
     886:	8526                	mv	a0,s1
     888:	00004097          	auipc	ra,0x4
     88c:	098080e7          	jalr	152(ra) # 4920 <read>
     890:	8a2a                	mv	s4,a0
  if(n != 0){
     892:	e971                	bnez	a0,966 <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     894:	4619                	li	a2,6
     896:	00005597          	auipc	a1,0x5
     89a:	bb258593          	addi	a1,a1,-1102 # 5448 <malloc+0x6e4>
     89e:	854e                	mv	a0,s3
     8a0:	00004097          	auipc	ra,0x4
     8a4:	088080e7          	jalr	136(ra) # 4928 <write>
  n = read(fd3, buf, sizeof(buf));
     8a8:	02000613          	li	a2,32
     8ac:	fa040593          	addi	a1,s0,-96
     8b0:	854a                	mv	a0,s2
     8b2:	00004097          	auipc	ra,0x4
     8b6:	06e080e7          	jalr	110(ra) # 4920 <read>
  if(n != 6){
     8ba:	4799                	li	a5,6
     8bc:	0cf51d63          	bne	a0,a5,996 <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     8c0:	02000613          	li	a2,32
     8c4:	fa040593          	addi	a1,s0,-96
     8c8:	8526                	mv	a0,s1
     8ca:	00004097          	auipc	ra,0x4
     8ce:	056080e7          	jalr	86(ra) # 4920 <read>
  if(n != 2){
     8d2:	4789                	li	a5,2
     8d4:	0ef51063          	bne	a0,a5,9b4 <truncate1+0x1f4>
  remove("truncfile");
     8d8:	00005517          	auipc	a0,0x5
     8dc:	90850513          	addi	a0,a0,-1784 # 51e0 <malloc+0x47c>
     8e0:	00004097          	auipc	ra,0x4
     8e4:	0d0080e7          	jalr	208(ra) # 49b0 <remove>
  close(fd1);
     8e8:	854e                	mv	a0,s3
     8ea:	00004097          	auipc	ra,0x4
     8ee:	046080e7          	jalr	70(ra) # 4930 <close>
  close(fd2);
     8f2:	8526                	mv	a0,s1
     8f4:	00004097          	auipc	ra,0x4
     8f8:	03c080e7          	jalr	60(ra) # 4930 <close>
  close(fd3);
     8fc:	854a                	mv	a0,s2
     8fe:	00004097          	auipc	ra,0x4
     902:	032080e7          	jalr	50(ra) # 4930 <close>
}
     906:	60e6                	ld	ra,88(sp)
     908:	6446                	ld	s0,80(sp)
     90a:	64a6                	ld	s1,72(sp)
     90c:	6906                	ld	s2,64(sp)
     90e:	79e2                	ld	s3,56(sp)
     910:	7a42                	ld	s4,48(sp)
     912:	7aa2                	ld	s5,40(sp)
     914:	6125                	addi	sp,sp,96
     916:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     918:	862a                	mv	a2,a0
     91a:	85d6                	mv	a1,s5
     91c:	00005517          	auipc	a0,0x5
     920:	acc50513          	addi	a0,a0,-1332 # 53e8 <malloc+0x684>
     924:	00004097          	auipc	ra,0x4
     928:	382080e7          	jalr	898(ra) # 4ca6 <printf>
    exit(1);
     92c:	4505                	li	a0,1
     92e:	00004097          	auipc	ra,0x4
     932:	fda080e7          	jalr	-38(ra) # 4908 <exit>
    printf("aaa fd3=%d\n", fd3);
     936:	85ca                	mv	a1,s2
     938:	00005517          	auipc	a0,0x5
     93c:	ad050513          	addi	a0,a0,-1328 # 5408 <malloc+0x6a4>
     940:	00004097          	auipc	ra,0x4
     944:	366080e7          	jalr	870(ra) # 4ca6 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     948:	8652                	mv	a2,s4
     94a:	85d6                	mv	a1,s5
     94c:	00005517          	auipc	a0,0x5
     950:	acc50513          	addi	a0,a0,-1332 # 5418 <malloc+0x6b4>
     954:	00004097          	auipc	ra,0x4
     958:	352080e7          	jalr	850(ra) # 4ca6 <printf>
    exit(1);
     95c:	4505                	li	a0,1
     95e:	00004097          	auipc	ra,0x4
     962:	faa080e7          	jalr	-86(ra) # 4908 <exit>
    printf("bbb fd2=%d\n", fd2);
     966:	85a6                	mv	a1,s1
     968:	00005517          	auipc	a0,0x5
     96c:	ad050513          	addi	a0,a0,-1328 # 5438 <malloc+0x6d4>
     970:	00004097          	auipc	ra,0x4
     974:	336080e7          	jalr	822(ra) # 4ca6 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     978:	8652                	mv	a2,s4
     97a:	85d6                	mv	a1,s5
     97c:	00005517          	auipc	a0,0x5
     980:	a9c50513          	addi	a0,a0,-1380 # 5418 <malloc+0x6b4>
     984:	00004097          	auipc	ra,0x4
     988:	322080e7          	jalr	802(ra) # 4ca6 <printf>
    exit(1);
     98c:	4505                	li	a0,1
     98e:	00004097          	auipc	ra,0x4
     992:	f7a080e7          	jalr	-134(ra) # 4908 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     996:	862a                	mv	a2,a0
     998:	85d6                	mv	a1,s5
     99a:	00005517          	auipc	a0,0x5
     99e:	ab650513          	addi	a0,a0,-1354 # 5450 <malloc+0x6ec>
     9a2:	00004097          	auipc	ra,0x4
     9a6:	304080e7          	jalr	772(ra) # 4ca6 <printf>
    exit(1);
     9aa:	4505                	li	a0,1
     9ac:	00004097          	auipc	ra,0x4
     9b0:	f5c080e7          	jalr	-164(ra) # 4908 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     9b4:	862a                	mv	a2,a0
     9b6:	85d6                	mv	a1,s5
     9b8:	00005517          	auipc	a0,0x5
     9bc:	ab850513          	addi	a0,a0,-1352 # 5470 <malloc+0x70c>
     9c0:	00004097          	auipc	ra,0x4
     9c4:	2e6080e7          	jalr	742(ra) # 4ca6 <printf>
    exit(1);
     9c8:	4505                	li	a0,1
     9ca:	00004097          	auipc	ra,0x4
     9ce:	f3e080e7          	jalr	-194(ra) # 4908 <exit>

00000000000009d2 <writetest>:
{
     9d2:	7139                	addi	sp,sp,-64
     9d4:	fc06                	sd	ra,56(sp)
     9d6:	f822                	sd	s0,48(sp)
     9d8:	f426                	sd	s1,40(sp)
     9da:	f04a                	sd	s2,32(sp)
     9dc:	ec4e                	sd	s3,24(sp)
     9de:	e852                	sd	s4,16(sp)
     9e0:	e456                	sd	s5,8(sp)
     9e2:	e05a                	sd	s6,0(sp)
     9e4:	0080                	addi	s0,sp,64
     9e6:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     9e8:	20200593          	li	a1,514
     9ec:	00005517          	auipc	a0,0x5
     9f0:	aa450513          	addi	a0,a0,-1372 # 5490 <malloc+0x72c>
     9f4:	00004097          	auipc	ra,0x4
     9f8:	f54080e7          	jalr	-172(ra) # 4948 <open>
  if(fd < 0){
     9fc:	0a054d63          	bltz	a0,ab6 <writetest+0xe4>
     a00:	892a                	mv	s2,a0
     a02:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a04:	00005997          	auipc	s3,0x5
     a08:	ab498993          	addi	s3,s3,-1356 # 54b8 <malloc+0x754>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a0c:	00005a97          	auipc	s5,0x5
     a10:	ae4a8a93          	addi	s5,s5,-1308 # 54f0 <malloc+0x78c>
  for(i = 0; i < N; i++){
     a14:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a18:	4629                	li	a2,10
     a1a:	85ce                	mv	a1,s3
     a1c:	854a                	mv	a0,s2
     a1e:	00004097          	auipc	ra,0x4
     a22:	f0a080e7          	jalr	-246(ra) # 4928 <write>
     a26:	47a9                	li	a5,10
     a28:	0af51563          	bne	a0,a5,ad2 <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a2c:	4629                	li	a2,10
     a2e:	85d6                	mv	a1,s5
     a30:	854a                	mv	a0,s2
     a32:	00004097          	auipc	ra,0x4
     a36:	ef6080e7          	jalr	-266(ra) # 4928 <write>
     a3a:	47a9                	li	a5,10
     a3c:	0af51963          	bne	a0,a5,aee <writetest+0x11c>
  for(i = 0; i < N; i++){
     a40:	2485                	addiw	s1,s1,1
     a42:	fd449be3          	bne	s1,s4,a18 <writetest+0x46>
  close(fd);
     a46:	854a                	mv	a0,s2
     a48:	00004097          	auipc	ra,0x4
     a4c:	ee8080e7          	jalr	-280(ra) # 4930 <close>
  fd = open("small", O_RDONLY);
     a50:	4581                	li	a1,0
     a52:	00005517          	auipc	a0,0x5
     a56:	a3e50513          	addi	a0,a0,-1474 # 5490 <malloc+0x72c>
     a5a:	00004097          	auipc	ra,0x4
     a5e:	eee080e7          	jalr	-274(ra) # 4948 <open>
     a62:	84aa                	mv	s1,a0
  if(fd < 0){
     a64:	0a054363          	bltz	a0,b0a <writetest+0x138>
  i = read(fd, buf, N*SZ*2);
     a68:	7d000613          	li	a2,2000
     a6c:	0000a597          	auipc	a1,0xa
     a70:	db458593          	addi	a1,a1,-588 # a820 <buf>
     a74:	00004097          	auipc	ra,0x4
     a78:	eac080e7          	jalr	-340(ra) # 4920 <read>
  if(i != N*SZ*2){
     a7c:	7d000793          	li	a5,2000
     a80:	0af51363          	bne	a0,a5,b26 <writetest+0x154>
  close(fd);
     a84:	8526                	mv	a0,s1
     a86:	00004097          	auipc	ra,0x4
     a8a:	eaa080e7          	jalr	-342(ra) # 4930 <close>
  if(remove("small") < 0){
     a8e:	00005517          	auipc	a0,0x5
     a92:	a0250513          	addi	a0,a0,-1534 # 5490 <malloc+0x72c>
     a96:	00004097          	auipc	ra,0x4
     a9a:	f1a080e7          	jalr	-230(ra) # 49b0 <remove>
     a9e:	0a054263          	bltz	a0,b42 <writetest+0x170>
}
     aa2:	70e2                	ld	ra,56(sp)
     aa4:	7442                	ld	s0,48(sp)
     aa6:	74a2                	ld	s1,40(sp)
     aa8:	7902                	ld	s2,32(sp)
     aaa:	69e2                	ld	s3,24(sp)
     aac:	6a42                	ld	s4,16(sp)
     aae:	6aa2                	ld	s5,8(sp)
     ab0:	6b02                	ld	s6,0(sp)
     ab2:	6121                	addi	sp,sp,64
     ab4:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     ab6:	85da                	mv	a1,s6
     ab8:	00005517          	auipc	a0,0x5
     abc:	9e050513          	addi	a0,a0,-1568 # 5498 <malloc+0x734>
     ac0:	00004097          	auipc	ra,0x4
     ac4:	1e6080e7          	jalr	486(ra) # 4ca6 <printf>
    exit(1);
     ac8:	4505                	li	a0,1
     aca:	00004097          	auipc	ra,0x4
     ace:	e3e080e7          	jalr	-450(ra) # 4908 <exit>
      printf("%s: error: write aa %d new file failed\n", i);
     ad2:	85a6                	mv	a1,s1
     ad4:	00005517          	auipc	a0,0x5
     ad8:	9f450513          	addi	a0,a0,-1548 # 54c8 <malloc+0x764>
     adc:	00004097          	auipc	ra,0x4
     ae0:	1ca080e7          	jalr	458(ra) # 4ca6 <printf>
      exit(1);
     ae4:	4505                	li	a0,1
     ae6:	00004097          	auipc	ra,0x4
     aea:	e22080e7          	jalr	-478(ra) # 4908 <exit>
      printf("%s: error: write bb %d new file failed\n", i);
     aee:	85a6                	mv	a1,s1
     af0:	00005517          	auipc	a0,0x5
     af4:	a1050513          	addi	a0,a0,-1520 # 5500 <malloc+0x79c>
     af8:	00004097          	auipc	ra,0x4
     afc:	1ae080e7          	jalr	430(ra) # 4ca6 <printf>
      exit(1);
     b00:	4505                	li	a0,1
     b02:	00004097          	auipc	ra,0x4
     b06:	e06080e7          	jalr	-506(ra) # 4908 <exit>
    printf("%s: error: open small failed!\n", s);
     b0a:	85da                	mv	a1,s6
     b0c:	00005517          	auipc	a0,0x5
     b10:	a1c50513          	addi	a0,a0,-1508 # 5528 <malloc+0x7c4>
     b14:	00004097          	auipc	ra,0x4
     b18:	192080e7          	jalr	402(ra) # 4ca6 <printf>
    exit(1);
     b1c:	4505                	li	a0,1
     b1e:	00004097          	auipc	ra,0x4
     b22:	dea080e7          	jalr	-534(ra) # 4908 <exit>
    printf("%s: read failed\n", s);
     b26:	85da                	mv	a1,s6
     b28:	00005517          	auipc	a0,0x5
     b2c:	a2050513          	addi	a0,a0,-1504 # 5548 <malloc+0x7e4>
     b30:	00004097          	auipc	ra,0x4
     b34:	176080e7          	jalr	374(ra) # 4ca6 <printf>
    exit(1);
     b38:	4505                	li	a0,1
     b3a:	00004097          	auipc	ra,0x4
     b3e:	dce080e7          	jalr	-562(ra) # 4908 <exit>
    printf("%s: remove small failed\n", s);
     b42:	85da                	mv	a1,s6
     b44:	00005517          	auipc	a0,0x5
     b48:	a1c50513          	addi	a0,a0,-1508 # 5560 <malloc+0x7fc>
     b4c:	00004097          	auipc	ra,0x4
     b50:	15a080e7          	jalr	346(ra) # 4ca6 <printf>
    exit(1);
     b54:	4505                	li	a0,1
     b56:	00004097          	auipc	ra,0x4
     b5a:	db2080e7          	jalr	-590(ra) # 4908 <exit>

0000000000000b5e <writebig>:
{
     b5e:	7179                	addi	sp,sp,-48
     b60:	f406                	sd	ra,40(sp)
     b62:	f022                	sd	s0,32(sp)
     b64:	ec26                	sd	s1,24(sp)
     b66:	e84a                	sd	s2,16(sp)
     b68:	e44e                	sd	s3,8(sp)
     b6a:	e052                	sd	s4,0(sp)
     b6c:	1800                	addi	s0,sp,48
     b6e:	8a2a                	mv	s4,a0
  fd = open("big", O_CREATE|O_RDWR);
     b70:	20200593          	li	a1,514
     b74:	00005517          	auipc	a0,0x5
     b78:	a0c50513          	addi	a0,a0,-1524 # 5580 <malloc+0x81c>
     b7c:	00004097          	auipc	ra,0x4
     b80:	dcc080e7          	jalr	-564(ra) # 4948 <open>
     b84:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     b86:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     b88:	0000a917          	auipc	s2,0xa
     b8c:	c9890913          	addi	s2,s2,-872 # a820 <buf>
  if(fd < 0){
     b90:	06054e63          	bltz	a0,c0c <writebig+0xae>
    ((int*)buf)[0] = i;
     b94:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     b98:	20000613          	li	a2,512
     b9c:	85ca                	mv	a1,s2
     b9e:	854e                	mv	a0,s3
     ba0:	00004097          	auipc	ra,0x4
     ba4:	d88080e7          	jalr	-632(ra) # 4928 <write>
     ba8:	20000793          	li	a5,512
     bac:	06f51e63          	bne	a0,a5,c28 <writebig+0xca>
  for(i = 0; i < MAXFILE; i++){
     bb0:	2485                	addiw	s1,s1,1
     bb2:	20000793          	li	a5,512
     bb6:	fcf49fe3          	bne	s1,a5,b94 <writebig+0x36>
  close(fd);
     bba:	854e                	mv	a0,s3
     bbc:	00004097          	auipc	ra,0x4
     bc0:	d74080e7          	jalr	-652(ra) # 4930 <close>
  fd = open("big", O_RDONLY);
     bc4:	4581                	li	a1,0
     bc6:	00005517          	auipc	a0,0x5
     bca:	9ba50513          	addi	a0,a0,-1606 # 5580 <malloc+0x81c>
     bce:	00004097          	auipc	ra,0x4
     bd2:	d7a080e7          	jalr	-646(ra) # 4948 <open>
     bd6:	89aa                	mv	s3,a0
  n = 0;
     bd8:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     bda:	0000a917          	auipc	s2,0xa
     bde:	c4690913          	addi	s2,s2,-954 # a820 <buf>
  if(fd < 0){
     be2:	06054163          	bltz	a0,c44 <writebig+0xe6>
    i = read(fd, buf, BSIZE);
     be6:	20000613          	li	a2,512
     bea:	85ca                	mv	a1,s2
     bec:	854e                	mv	a0,s3
     bee:	00004097          	auipc	ra,0x4
     bf2:	d32080e7          	jalr	-718(ra) # 4920 <read>
    if(i == 0){
     bf6:	c52d                	beqz	a0,c60 <writebig+0x102>
    } else if(i != BSIZE){
     bf8:	20000793          	li	a5,512
     bfc:	0af51c63          	bne	a0,a5,cb4 <writebig+0x156>
    if(((int*)buf)[0] != n){
     c00:	00092603          	lw	a2,0(s2)
     c04:	0c961663          	bne	a2,s1,cd0 <writebig+0x172>
    n++;
     c08:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c0a:	bff1                	j	be6 <writebig+0x88>
    printf("%s: error: creat big failed!\n", s);
     c0c:	85d2                	mv	a1,s4
     c0e:	00005517          	auipc	a0,0x5
     c12:	97a50513          	addi	a0,a0,-1670 # 5588 <malloc+0x824>
     c16:	00004097          	auipc	ra,0x4
     c1a:	090080e7          	jalr	144(ra) # 4ca6 <printf>
    exit(1);
     c1e:	4505                	li	a0,1
     c20:	00004097          	auipc	ra,0x4
     c24:	ce8080e7          	jalr	-792(ra) # 4908 <exit>
      printf("%s: error: write big file failed\n", i);
     c28:	85a6                	mv	a1,s1
     c2a:	00005517          	auipc	a0,0x5
     c2e:	97e50513          	addi	a0,a0,-1666 # 55a8 <malloc+0x844>
     c32:	00004097          	auipc	ra,0x4
     c36:	074080e7          	jalr	116(ra) # 4ca6 <printf>
      exit(1);
     c3a:	4505                	li	a0,1
     c3c:	00004097          	auipc	ra,0x4
     c40:	ccc080e7          	jalr	-820(ra) # 4908 <exit>
    printf("%s: error: open big failed!\n", s);
     c44:	85d2                	mv	a1,s4
     c46:	00005517          	auipc	a0,0x5
     c4a:	98a50513          	addi	a0,a0,-1654 # 55d0 <malloc+0x86c>
     c4e:	00004097          	auipc	ra,0x4
     c52:	058080e7          	jalr	88(ra) # 4ca6 <printf>
    exit(1);
     c56:	4505                	li	a0,1
     c58:	00004097          	auipc	ra,0x4
     c5c:	cb0080e7          	jalr	-848(ra) # 4908 <exit>
      if(n == MAXFILE - 1){
     c60:	1ff00793          	li	a5,511
     c64:	02f48963          	beq	s1,a5,c96 <writebig+0x138>
  close(fd);
     c68:	854e                	mv	a0,s3
     c6a:	00004097          	auipc	ra,0x4
     c6e:	cc6080e7          	jalr	-826(ra) # 4930 <close>
  if(remove("big") < 0){
     c72:	00005517          	auipc	a0,0x5
     c76:	90e50513          	addi	a0,a0,-1778 # 5580 <malloc+0x81c>
     c7a:	00004097          	auipc	ra,0x4
     c7e:	d36080e7          	jalr	-714(ra) # 49b0 <remove>
     c82:	06054563          	bltz	a0,cec <writebig+0x18e>
}
     c86:	70a2                	ld	ra,40(sp)
     c88:	7402                	ld	s0,32(sp)
     c8a:	64e2                	ld	s1,24(sp)
     c8c:	6942                	ld	s2,16(sp)
     c8e:	69a2                	ld	s3,8(sp)
     c90:	6a02                	ld	s4,0(sp)
     c92:	6145                	addi	sp,sp,48
     c94:	8082                	ret
        printf("%s: read only %d blocks from big", n);
     c96:	1ff00593          	li	a1,511
     c9a:	00005517          	auipc	a0,0x5
     c9e:	95650513          	addi	a0,a0,-1706 # 55f0 <malloc+0x88c>
     ca2:	00004097          	auipc	ra,0x4
     ca6:	004080e7          	jalr	4(ra) # 4ca6 <printf>
        exit(1);
     caa:	4505                	li	a0,1
     cac:	00004097          	auipc	ra,0x4
     cb0:	c5c080e7          	jalr	-932(ra) # 4908 <exit>
      printf("%s: read failed %d\n", i);
     cb4:	85aa                	mv	a1,a0
     cb6:	00005517          	auipc	a0,0x5
     cba:	96250513          	addi	a0,a0,-1694 # 5618 <malloc+0x8b4>
     cbe:	00004097          	auipc	ra,0x4
     cc2:	fe8080e7          	jalr	-24(ra) # 4ca6 <printf>
      exit(1);
     cc6:	4505                	li	a0,1
     cc8:	00004097          	auipc	ra,0x4
     ccc:	c40080e7          	jalr	-960(ra) # 4908 <exit>
      printf("%s: read content of block %d is %d\n",
     cd0:	85a6                	mv	a1,s1
     cd2:	00005517          	auipc	a0,0x5
     cd6:	95e50513          	addi	a0,a0,-1698 # 5630 <malloc+0x8cc>
     cda:	00004097          	auipc	ra,0x4
     cde:	fcc080e7          	jalr	-52(ra) # 4ca6 <printf>
      exit(1);
     ce2:	4505                	li	a0,1
     ce4:	00004097          	auipc	ra,0x4
     ce8:	c24080e7          	jalr	-988(ra) # 4908 <exit>
    printf("%s: remove big failed\n", s);
     cec:	85d2                	mv	a1,s4
     cee:	00005517          	auipc	a0,0x5
     cf2:	96a50513          	addi	a0,a0,-1686 # 5658 <malloc+0x8f4>
     cf6:	00004097          	auipc	ra,0x4
     cfa:	fb0080e7          	jalr	-80(ra) # 4ca6 <printf>
    exit(1);
     cfe:	4505                	li	a0,1
     d00:	00004097          	auipc	ra,0x4
     d04:	c08080e7          	jalr	-1016(ra) # 4908 <exit>

0000000000000d08 <removeread>:
{
     d08:	7179                	addi	sp,sp,-48
     d0a:	f406                	sd	ra,40(sp)
     d0c:	f022                	sd	s0,32(sp)
     d0e:	ec26                	sd	s1,24(sp)
     d10:	e84a                	sd	s2,16(sp)
     d12:	e44e                	sd	s3,8(sp)
     d14:	1800                	addi	s0,sp,48
     d16:	89aa                	mv	s3,a0
  fd = open("removeread", O_CREATE | O_RDWR);
     d18:	20200593          	li	a1,514
     d1c:	00004517          	auipc	a0,0x4
     d20:	26c50513          	addi	a0,a0,620 # 4f88 <malloc+0x224>
     d24:	00004097          	auipc	ra,0x4
     d28:	c24080e7          	jalr	-988(ra) # 4948 <open>
  if(fd < 0){
     d2c:	0e054763          	bltz	a0,e1a <removeread+0x112>
     d30:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d32:	4615                	li	a2,5
     d34:	00005597          	auipc	a1,0x5
     d38:	95c58593          	addi	a1,a1,-1700 # 5690 <malloc+0x92c>
     d3c:	00004097          	auipc	ra,0x4
     d40:	bec080e7          	jalr	-1044(ra) # 4928 <write>
  close(fd);
     d44:	8526                	mv	a0,s1
     d46:	00004097          	auipc	ra,0x4
     d4a:	bea080e7          	jalr	-1046(ra) # 4930 <close>
  fd = open("removeread", O_RDWR);
     d4e:	4589                	li	a1,2
     d50:	00004517          	auipc	a0,0x4
     d54:	23850513          	addi	a0,a0,568 # 4f88 <malloc+0x224>
     d58:	00004097          	auipc	ra,0x4
     d5c:	bf0080e7          	jalr	-1040(ra) # 4948 <open>
     d60:	84aa                	mv	s1,a0
  if(fd < 0){
     d62:	0c054a63          	bltz	a0,e36 <removeread+0x12e>
  if(remove("removeread") != 0){
     d66:	00004517          	auipc	a0,0x4
     d6a:	22250513          	addi	a0,a0,546 # 4f88 <malloc+0x224>
     d6e:	00004097          	auipc	ra,0x4
     d72:	c42080e7          	jalr	-958(ra) # 49b0 <remove>
     d76:	ed71                	bnez	a0,e52 <removeread+0x14a>
  fd1 = open("removeread", O_CREATE | O_RDWR);
     d78:	20200593          	li	a1,514
     d7c:	00004517          	auipc	a0,0x4
     d80:	20c50513          	addi	a0,a0,524 # 4f88 <malloc+0x224>
     d84:	00004097          	auipc	ra,0x4
     d88:	bc4080e7          	jalr	-1084(ra) # 4948 <open>
     d8c:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     d8e:	460d                	li	a2,3
     d90:	00005597          	auipc	a1,0x5
     d94:	94858593          	addi	a1,a1,-1720 # 56d8 <malloc+0x974>
     d98:	00004097          	auipc	ra,0x4
     d9c:	b90080e7          	jalr	-1136(ra) # 4928 <write>
  close(fd1);
     da0:	854a                	mv	a0,s2
     da2:	00004097          	auipc	ra,0x4
     da6:	b8e080e7          	jalr	-1138(ra) # 4930 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     daa:	6609                	lui	a2,0x2
     dac:	80060613          	addi	a2,a2,-2048 # 1800 <forkfork+0x3e>
     db0:	0000a597          	auipc	a1,0xa
     db4:	a7058593          	addi	a1,a1,-1424 # a820 <buf>
     db8:	8526                	mv	a0,s1
     dba:	00004097          	auipc	ra,0x4
     dbe:	b66080e7          	jalr	-1178(ra) # 4920 <read>
     dc2:	4795                	li	a5,5
     dc4:	0af51563          	bne	a0,a5,e6e <removeread+0x166>
  if(buf[0] != 'h'){
     dc8:	0000a717          	auipc	a4,0xa
     dcc:	a5874703          	lbu	a4,-1448(a4) # a820 <buf>
     dd0:	06800793          	li	a5,104
     dd4:	0af71b63          	bne	a4,a5,e8a <removeread+0x182>
  if(write(fd, buf, 10) != 10){
     dd8:	4629                	li	a2,10
     dda:	0000a597          	auipc	a1,0xa
     dde:	a4658593          	addi	a1,a1,-1466 # a820 <buf>
     de2:	8526                	mv	a0,s1
     de4:	00004097          	auipc	ra,0x4
     de8:	b44080e7          	jalr	-1212(ra) # 4928 <write>
     dec:	47a9                	li	a5,10
     dee:	0af51c63          	bne	a0,a5,ea6 <removeread+0x19e>
  close(fd);
     df2:	8526                	mv	a0,s1
     df4:	00004097          	auipc	ra,0x4
     df8:	b3c080e7          	jalr	-1220(ra) # 4930 <close>
  remove("removeread");
     dfc:	00004517          	auipc	a0,0x4
     e00:	18c50513          	addi	a0,a0,396 # 4f88 <malloc+0x224>
     e04:	00004097          	auipc	ra,0x4
     e08:	bac080e7          	jalr	-1108(ra) # 49b0 <remove>
}
     e0c:	70a2                	ld	ra,40(sp)
     e0e:	7402                	ld	s0,32(sp)
     e10:	64e2                	ld	s1,24(sp)
     e12:	6942                	ld	s2,16(sp)
     e14:	69a2                	ld	s3,8(sp)
     e16:	6145                	addi	sp,sp,48
     e18:	8082                	ret
    printf("%s: create removeread failed\n", s);
     e1a:	85ce                	mv	a1,s3
     e1c:	00005517          	auipc	a0,0x5
     e20:	85450513          	addi	a0,a0,-1964 # 5670 <malloc+0x90c>
     e24:	00004097          	auipc	ra,0x4
     e28:	e82080e7          	jalr	-382(ra) # 4ca6 <printf>
    exit(1);
     e2c:	4505                	li	a0,1
     e2e:	00004097          	auipc	ra,0x4
     e32:	ada080e7          	jalr	-1318(ra) # 4908 <exit>
    printf("%s: open removeread failed\n", s);
     e36:	85ce                	mv	a1,s3
     e38:	00005517          	auipc	a0,0x5
     e3c:	86050513          	addi	a0,a0,-1952 # 5698 <malloc+0x934>
     e40:	00004097          	auipc	ra,0x4
     e44:	e66080e7          	jalr	-410(ra) # 4ca6 <printf>
    exit(1);
     e48:	4505                	li	a0,1
     e4a:	00004097          	auipc	ra,0x4
     e4e:	abe080e7          	jalr	-1346(ra) # 4908 <exit>
    printf("%s: remove removeread failed\n", s);
     e52:	85ce                	mv	a1,s3
     e54:	00005517          	auipc	a0,0x5
     e58:	86450513          	addi	a0,a0,-1948 # 56b8 <malloc+0x954>
     e5c:	00004097          	auipc	ra,0x4
     e60:	e4a080e7          	jalr	-438(ra) # 4ca6 <printf>
    exit(1);
     e64:	4505                	li	a0,1
     e66:	00004097          	auipc	ra,0x4
     e6a:	aa2080e7          	jalr	-1374(ra) # 4908 <exit>
    printf("%s: removeread read failed", s);
     e6e:	85ce                	mv	a1,s3
     e70:	00005517          	auipc	a0,0x5
     e74:	87050513          	addi	a0,a0,-1936 # 56e0 <malloc+0x97c>
     e78:	00004097          	auipc	ra,0x4
     e7c:	e2e080e7          	jalr	-466(ra) # 4ca6 <printf>
    exit(1);
     e80:	4505                	li	a0,1
     e82:	00004097          	auipc	ra,0x4
     e86:	a86080e7          	jalr	-1402(ra) # 4908 <exit>
    printf("%s: removeread wrong data\n", s);
     e8a:	85ce                	mv	a1,s3
     e8c:	00005517          	auipc	a0,0x5
     e90:	87450513          	addi	a0,a0,-1932 # 5700 <malloc+0x99c>
     e94:	00004097          	auipc	ra,0x4
     e98:	e12080e7          	jalr	-494(ra) # 4ca6 <printf>
    exit(1);
     e9c:	4505                	li	a0,1
     e9e:	00004097          	auipc	ra,0x4
     ea2:	a6a080e7          	jalr	-1430(ra) # 4908 <exit>
    printf("%s: removeread write failed\n", s);
     ea6:	85ce                	mv	a1,s3
     ea8:	00005517          	auipc	a0,0x5
     eac:	87850513          	addi	a0,a0,-1928 # 5720 <malloc+0x9bc>
     eb0:	00004097          	auipc	ra,0x4
     eb4:	df6080e7          	jalr	-522(ra) # 4ca6 <printf>
    exit(1);
     eb8:	4505                	li	a0,1
     eba:	00004097          	auipc	ra,0x4
     ebe:	a4e080e7          	jalr	-1458(ra) # 4908 <exit>

0000000000000ec2 <pgbug>:
{
     ec2:	7179                	addi	sp,sp,-48
     ec4:	f406                	sd	ra,40(sp)
     ec6:	f022                	sd	s0,32(sp)
     ec8:	ec26                	sd	s1,24(sp)
     eca:	1800                	addi	s0,sp,48
  argv[0] = 0;
     ecc:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
     ed0:	00006497          	auipc	s1,0x6
     ed4:	da04b483          	ld	s1,-608(s1) # 6c70 <malloc+0x1f0c>
     ed8:	fd840593          	addi	a1,s0,-40
     edc:	8526                	mv	a0,s1
     ede:	00004097          	auipc	ra,0x4
     ee2:	a62080e7          	jalr	-1438(ra) # 4940 <exec>
  pipe((int*)0xeaeb0b5b00002f5e);
     ee6:	8526                	mv	a0,s1
     ee8:	00004097          	auipc	ra,0x4
     eec:	a30080e7          	jalr	-1488(ra) # 4918 <pipe>
  exit(0);
     ef0:	4501                	li	a0,0
     ef2:	00004097          	auipc	ra,0x4
     ef6:	a16080e7          	jalr	-1514(ra) # 4908 <exit>

0000000000000efa <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
     efa:	7139                	addi	sp,sp,-64
     efc:	fc06                	sd	ra,56(sp)
     efe:	f822                	sd	s0,48(sp)
     f00:	f426                	sd	s1,40(sp)
     f02:	f04a                	sd	s2,32(sp)
     f04:	ec4e                	sd	s3,24(sp)
     f06:	e852                	sd	s4,16(sp)
     f08:	0080                	addi	s0,sp,64
     f0a:	64b1                	lui	s1,0xc
     f0c:	35048493          	addi	s1,s1,848 # c350 <__BSS_END__+0x318>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
     f10:	597d                	li	s2,-1
     f12:	02095913          	srli	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
     f16:	fc040a13          	addi	s4,s0,-64
     f1a:	00004997          	auipc	s3,0x4
     f1e:	26e98993          	addi	s3,s3,622 # 5188 <malloc+0x424>
    argv[0] = (char*)0xffffffff;
     f22:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
     f26:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
     f2a:	85d2                	mv	a1,s4
     f2c:	854e                	mv	a0,s3
     f2e:	00004097          	auipc	ra,0x4
     f32:	a12080e7          	jalr	-1518(ra) # 4940 <exec>
  for(int i = 0; i < 50000; i++){
     f36:	34fd                	addiw	s1,s1,-1
     f38:	f4ed                	bnez	s1,f22 <badarg+0x28>
  }
  
  exit(0);
     f3a:	4501                	li	a0,0
     f3c:	00004097          	auipc	ra,0x4
     f40:	9cc080e7          	jalr	-1588(ra) # 4908 <exit>

0000000000000f44 <copyinstr2>:
{
     f44:	714d                	addi	sp,sp,-336
     f46:	e686                	sd	ra,328(sp)
     f48:	e2a2                	sd	s0,320(sp)
     f4a:	0a80                	addi	s0,sp,336
  for(int i = 0; i < MAXPATH; i++)
     f4c:	ee840793          	addi	a5,s0,-280
     f50:	fec40693          	addi	a3,s0,-20
    b[i] = 'x';
     f54:	07800713          	li	a4,120
     f58:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
     f5c:	0785                	addi	a5,a5,1
     f5e:	fed79de3          	bne	a5,a3,f58 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
     f62:	fe040623          	sb	zero,-20(s0)
  int ret = remove(b);
     f66:	ee840513          	addi	a0,s0,-280
     f6a:	00004097          	auipc	ra,0x4
     f6e:	a46080e7          	jalr	-1466(ra) # 49b0 <remove>
  if(ret != -1){
     f72:	57fd                	li	a5,-1
     f74:	0cf51663          	bne	a0,a5,1040 <copyinstr2+0xfc>
  int fd = open(b, O_CREATE | O_WRONLY);
     f78:	20100593          	li	a1,513
     f7c:	ee840513          	addi	a0,s0,-280
     f80:	00004097          	auipc	ra,0x4
     f84:	9c8080e7          	jalr	-1592(ra) # 4948 <open>
  if(fd != -1){
     f88:	57fd                	li	a5,-1
     f8a:	0cf51b63          	bne	a0,a5,1060 <copyinstr2+0x11c>
  char *args[] = { "xx", 0 };
     f8e:	00005797          	auipc	a5,0x5
     f92:	3c278793          	addi	a5,a5,962 # 6350 <malloc+0x15ec>
     f96:	ecf43c23          	sd	a5,-296(s0)
     f9a:	ee043023          	sd	zero,-288(s0)
  ret = exec(b, args);
     f9e:	ed840593          	addi	a1,s0,-296
     fa2:	ee840513          	addi	a0,s0,-280
     fa6:	00004097          	auipc	ra,0x4
     faa:	99a080e7          	jalr	-1638(ra) # 4940 <exec>
  if(ret != -1){
     fae:	57fd                	li	a5,-1
     fb0:	0cf51863          	bne	a0,a5,1080 <copyinstr2+0x13c>
  int pid = fork();
     fb4:	00004097          	auipc	ra,0x4
     fb8:	94c080e7          	jalr	-1716(ra) # 4900 <fork>
  if(pid < 0){
     fbc:	0e054263          	bltz	a0,10a0 <copyinstr2+0x15c>
  if(pid == 0){
     fc0:	10051363          	bnez	a0,10c6 <copyinstr2+0x182>
     fc4:	00006797          	auipc	a5,0x6
     fc8:	14478793          	addi	a5,a5,324 # 7108 <big.0>
     fcc:	00007697          	auipc	a3,0x7
     fd0:	13c68693          	addi	a3,a3,316 # 8108 <__global_pointer$+0x908>
      big[i] = 'x';
     fd4:	07800713          	li	a4,120
     fd8:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
     fdc:	0785                	addi	a5,a5,1
     fde:	fed79de3          	bne	a5,a3,fd8 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
     fe2:	00007797          	auipc	a5,0x7
     fe6:	12078323          	sb	zero,294(a5) # 8108 <__global_pointer$+0x908>
    char *args2[] = { big, big, big, 0 };
     fea:	00006797          	auipc	a5,0x6
     fee:	cae78793          	addi	a5,a5,-850 # 6c98 <__DATA_BEGIN__>
     ff2:	6390                	ld	a2,0(a5)
     ff4:	6794                	ld	a3,8(a5)
     ff6:	6b98                	ld	a4,16(a5)
     ff8:	6f9c                	ld	a5,24(a5)
     ffa:	eac43823          	sd	a2,-336(s0)
     ffe:	ead43c23          	sd	a3,-328(s0)
    1002:	ece43023          	sd	a4,-320(s0)
    1006:	ecf43423          	sd	a5,-312(s0)
    ret = exec("echo", args2);
    100a:	eb040593          	addi	a1,s0,-336
    100e:	00004517          	auipc	a0,0x4
    1012:	17a50513          	addi	a0,a0,378 # 5188 <malloc+0x424>
    1016:	00004097          	auipc	ra,0x4
    101a:	92a080e7          	jalr	-1750(ra) # 4940 <exec>
    if(ret != -1){
    101e:	57fd                	li	a5,-1
    1020:	08f50d63          	beq	a0,a5,10ba <copyinstr2+0x176>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    1024:	55fd                	li	a1,-1
    1026:	00004517          	auipc	a0,0x4
    102a:	77a50513          	addi	a0,a0,1914 # 57a0 <malloc+0xa3c>
    102e:	00004097          	auipc	ra,0x4
    1032:	c78080e7          	jalr	-904(ra) # 4ca6 <printf>
      exit(1);
    1036:	4505                	li	a0,1
    1038:	00004097          	auipc	ra,0x4
    103c:	8d0080e7          	jalr	-1840(ra) # 4908 <exit>
    printf("remove(%s) returned %d, not -1\n", b, ret);
    1040:	862a                	mv	a2,a0
    1042:	ee840593          	addi	a1,s0,-280
    1046:	00004517          	auipc	a0,0x4
    104a:	6fa50513          	addi	a0,a0,1786 # 5740 <malloc+0x9dc>
    104e:	00004097          	auipc	ra,0x4
    1052:	c58080e7          	jalr	-936(ra) # 4ca6 <printf>
    exit(1);
    1056:	4505                	li	a0,1
    1058:	00004097          	auipc	ra,0x4
    105c:	8b0080e7          	jalr	-1872(ra) # 4908 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1060:	862a                	mv	a2,a0
    1062:	ee840593          	addi	a1,s0,-280
    1066:	00004517          	auipc	a0,0x4
    106a:	6fa50513          	addi	a0,a0,1786 # 5760 <malloc+0x9fc>
    106e:	00004097          	auipc	ra,0x4
    1072:	c38080e7          	jalr	-968(ra) # 4ca6 <printf>
    exit(1);
    1076:	4505                	li	a0,1
    1078:	00004097          	auipc	ra,0x4
    107c:	890080e7          	jalr	-1904(ra) # 4908 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1080:	567d                	li	a2,-1
    1082:	ee840593          	addi	a1,s0,-280
    1086:	00004517          	auipc	a0,0x4
    108a:	6fa50513          	addi	a0,a0,1786 # 5780 <malloc+0xa1c>
    108e:	00004097          	auipc	ra,0x4
    1092:	c18080e7          	jalr	-1000(ra) # 4ca6 <printf>
    exit(1);
    1096:	4505                	li	a0,1
    1098:	00004097          	auipc	ra,0x4
    109c:	870080e7          	jalr	-1936(ra) # 4908 <exit>
    printf("fork failed\n");
    10a0:	00005517          	auipc	a0,0x5
    10a4:	ad850513          	addi	a0,a0,-1320 # 5b78 <malloc+0xe14>
    10a8:	00004097          	auipc	ra,0x4
    10ac:	bfe080e7          	jalr	-1026(ra) # 4ca6 <printf>
    exit(1);
    10b0:	4505                	li	a0,1
    10b2:	00004097          	auipc	ra,0x4
    10b6:	856080e7          	jalr	-1962(ra) # 4908 <exit>
    exit(747); // OK
    10ba:	2eb00513          	li	a0,747
    10be:	00004097          	auipc	ra,0x4
    10c2:	84a080e7          	jalr	-1974(ra) # 4908 <exit>
  int st = 0;
    10c6:	ec042a23          	sw	zero,-300(s0)
  wait(&st);
    10ca:	ed440513          	addi	a0,s0,-300
    10ce:	00004097          	auipc	ra,0x4
    10d2:	842080e7          	jalr	-1982(ra) # 4910 <wait>
  if(st != 747){
    10d6:	ed442703          	lw	a4,-300(s0)
    10da:	2eb00793          	li	a5,747
    10de:	00f71663          	bne	a4,a5,10ea <copyinstr2+0x1a6>
}
    10e2:	60b6                	ld	ra,328(sp)
    10e4:	6416                	ld	s0,320(sp)
    10e6:	6171                	addi	sp,sp,336
    10e8:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    10ea:	00004517          	auipc	a0,0x4
    10ee:	6de50513          	addi	a0,a0,1758 # 57c8 <malloc+0xa64>
    10f2:	00004097          	auipc	ra,0x4
    10f6:	bb4080e7          	jalr	-1100(ra) # 4ca6 <printf>
    exit(1);
    10fa:	4505                	li	a0,1
    10fc:	00004097          	auipc	ra,0x4
    1100:	80c080e7          	jalr	-2036(ra) # 4908 <exit>

0000000000001104 <truncate3>:
{
    1104:	7159                	addi	sp,sp,-112
    1106:	f486                	sd	ra,104(sp)
    1108:	f0a2                	sd	s0,96(sp)
    110a:	eca6                	sd	s1,88(sp)
    110c:	e8ca                	sd	s2,80(sp)
    110e:	e4ce                	sd	s3,72(sp)
    1110:	e0d2                	sd	s4,64(sp)
    1112:	fc56                	sd	s5,56(sp)
    1114:	f85a                	sd	s6,48(sp)
    1116:	1880                	addi	s0,sp,112
    1118:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    111a:	60100593          	li	a1,1537
    111e:	00004517          	auipc	a0,0x4
    1122:	0c250513          	addi	a0,a0,194 # 51e0 <malloc+0x47c>
    1126:	00004097          	auipc	ra,0x4
    112a:	822080e7          	jalr	-2014(ra) # 4948 <open>
    112e:	00004097          	auipc	ra,0x4
    1132:	802080e7          	jalr	-2046(ra) # 4930 <close>
  pid = fork();
    1136:	00003097          	auipc	ra,0x3
    113a:	7ca080e7          	jalr	1994(ra) # 4900 <fork>
  if(pid < 0){
    113e:	08054163          	bltz	a0,11c0 <truncate3+0xbc>
  if(pid == 0){
    1142:	e971                	bnez	a0,1216 <truncate3+0x112>
    1144:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    1148:	00004a17          	auipc	s4,0x4
    114c:	098a0a13          	addi	s4,s4,152 # 51e0 <malloc+0x47c>
      int n = write(fd, "1234567890", 10);
    1150:	00004a97          	auipc	s5,0x4
    1154:	6d8a8a93          	addi	s5,s5,1752 # 5828 <malloc+0xac4>
      read(fd, buf, sizeof(buf));
    1158:	f9840b13          	addi	s6,s0,-104
      int fd = open("truncfile", O_WRONLY);
    115c:	4585                	li	a1,1
    115e:	8552                	mv	a0,s4
    1160:	00003097          	auipc	ra,0x3
    1164:	7e8080e7          	jalr	2024(ra) # 4948 <open>
    1168:	84aa                	mv	s1,a0
      if(fd < 0){
    116a:	06054963          	bltz	a0,11dc <truncate3+0xd8>
      int n = write(fd, "1234567890", 10);
    116e:	4629                	li	a2,10
    1170:	85d6                	mv	a1,s5
    1172:	00003097          	auipc	ra,0x3
    1176:	7b6080e7          	jalr	1974(ra) # 4928 <write>
      if(n != 10){
    117a:	47a9                	li	a5,10
    117c:	06f51e63          	bne	a0,a5,11f8 <truncate3+0xf4>
      close(fd);
    1180:	8526                	mv	a0,s1
    1182:	00003097          	auipc	ra,0x3
    1186:	7ae080e7          	jalr	1966(ra) # 4930 <close>
      fd = open("truncfile", O_RDONLY);
    118a:	4581                	li	a1,0
    118c:	8552                	mv	a0,s4
    118e:	00003097          	auipc	ra,0x3
    1192:	7ba080e7          	jalr	1978(ra) # 4948 <open>
    1196:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1198:	02000613          	li	a2,32
    119c:	85da                	mv	a1,s6
    119e:	00003097          	auipc	ra,0x3
    11a2:	782080e7          	jalr	1922(ra) # 4920 <read>
      close(fd);
    11a6:	8526                	mv	a0,s1
    11a8:	00003097          	auipc	ra,0x3
    11ac:	788080e7          	jalr	1928(ra) # 4930 <close>
    for(int i = 0; i < 100; i++){
    11b0:	39fd                	addiw	s3,s3,-1
    11b2:	fa0995e3          	bnez	s3,115c <truncate3+0x58>
    exit(0);
    11b6:	4501                	li	a0,0
    11b8:	00003097          	auipc	ra,0x3
    11bc:	750080e7          	jalr	1872(ra) # 4908 <exit>
    printf("%s: fork failed\n", s);
    11c0:	85ca                	mv	a1,s2
    11c2:	00004517          	auipc	a0,0x4
    11c6:	63650513          	addi	a0,a0,1590 # 57f8 <malloc+0xa94>
    11ca:	00004097          	auipc	ra,0x4
    11ce:	adc080e7          	jalr	-1316(ra) # 4ca6 <printf>
    exit(1);
    11d2:	4505                	li	a0,1
    11d4:	00003097          	auipc	ra,0x3
    11d8:	734080e7          	jalr	1844(ra) # 4908 <exit>
        printf("%s: open failed\n", s);
    11dc:	85ca                	mv	a1,s2
    11de:	00004517          	auipc	a0,0x4
    11e2:	63250513          	addi	a0,a0,1586 # 5810 <malloc+0xaac>
    11e6:	00004097          	auipc	ra,0x4
    11ea:	ac0080e7          	jalr	-1344(ra) # 4ca6 <printf>
        exit(1);
    11ee:	4505                	li	a0,1
    11f0:	00003097          	auipc	ra,0x3
    11f4:	718080e7          	jalr	1816(ra) # 4908 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    11f8:	862a                	mv	a2,a0
    11fa:	85ca                	mv	a1,s2
    11fc:	00004517          	auipc	a0,0x4
    1200:	63c50513          	addi	a0,a0,1596 # 5838 <malloc+0xad4>
    1204:	00004097          	auipc	ra,0x4
    1208:	aa2080e7          	jalr	-1374(ra) # 4ca6 <printf>
        exit(1);
    120c:	4505                	li	a0,1
    120e:	00003097          	auipc	ra,0x3
    1212:	6fa080e7          	jalr	1786(ra) # 4908 <exit>
    1216:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    121a:	00004a17          	auipc	s4,0x4
    121e:	fc6a0a13          	addi	s4,s4,-58 # 51e0 <malloc+0x47c>
    int n = write(fd, "xxx", 3);
    1222:	00004a97          	auipc	s5,0x4
    1226:	636a8a93          	addi	s5,s5,1590 # 5858 <malloc+0xaf4>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    122a:	60100593          	li	a1,1537
    122e:	8552                	mv	a0,s4
    1230:	00003097          	auipc	ra,0x3
    1234:	718080e7          	jalr	1816(ra) # 4948 <open>
    1238:	84aa                	mv	s1,a0
    if(fd < 0){
    123a:	04054763          	bltz	a0,1288 <truncate3+0x184>
    int n = write(fd, "xxx", 3);
    123e:	460d                	li	a2,3
    1240:	85d6                	mv	a1,s5
    1242:	00003097          	auipc	ra,0x3
    1246:	6e6080e7          	jalr	1766(ra) # 4928 <write>
    if(n != 3){
    124a:	478d                	li	a5,3
    124c:	04f51c63          	bne	a0,a5,12a4 <truncate3+0x1a0>
    close(fd);
    1250:	8526                	mv	a0,s1
    1252:	00003097          	auipc	ra,0x3
    1256:	6de080e7          	jalr	1758(ra) # 4930 <close>
  for(int i = 0; i < 150; i++){
    125a:	39fd                	addiw	s3,s3,-1
    125c:	fc0997e3          	bnez	s3,122a <truncate3+0x126>
  wait(&xstatus);
    1260:	fbc40513          	addi	a0,s0,-68
    1264:	00003097          	auipc	ra,0x3
    1268:	6ac080e7          	jalr	1708(ra) # 4910 <wait>
  remove("truncfile");
    126c:	00004517          	auipc	a0,0x4
    1270:	f7450513          	addi	a0,a0,-140 # 51e0 <malloc+0x47c>
    1274:	00003097          	auipc	ra,0x3
    1278:	73c080e7          	jalr	1852(ra) # 49b0 <remove>
  exit(xstatus);
    127c:	fbc42503          	lw	a0,-68(s0)
    1280:	00003097          	auipc	ra,0x3
    1284:	688080e7          	jalr	1672(ra) # 4908 <exit>
      printf("%s: open failed\n", s);
    1288:	85ca                	mv	a1,s2
    128a:	00004517          	auipc	a0,0x4
    128e:	58650513          	addi	a0,a0,1414 # 5810 <malloc+0xaac>
    1292:	00004097          	auipc	ra,0x4
    1296:	a14080e7          	jalr	-1516(ra) # 4ca6 <printf>
      exit(1);
    129a:	4505                	li	a0,1
    129c:	00003097          	auipc	ra,0x3
    12a0:	66c080e7          	jalr	1644(ra) # 4908 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    12a4:	862a                	mv	a2,a0
    12a6:	85ca                	mv	a1,s2
    12a8:	00004517          	auipc	a0,0x4
    12ac:	5b850513          	addi	a0,a0,1464 # 5860 <malloc+0xafc>
    12b0:	00004097          	auipc	ra,0x4
    12b4:	9f6080e7          	jalr	-1546(ra) # 4ca6 <printf>
      exit(1);
    12b8:	4505                	li	a0,1
    12ba:	00003097          	auipc	ra,0x3
    12be:	64e080e7          	jalr	1614(ra) # 4908 <exit>

00000000000012c2 <exectest>:
{
    12c2:	715d                	addi	sp,sp,-80
    12c4:	e486                	sd	ra,72(sp)
    12c6:	e0a2                	sd	s0,64(sp)
    12c8:	fc26                	sd	s1,56(sp)
    12ca:	f84a                	sd	s2,48(sp)
    12cc:	0880                	addi	s0,sp,80
    12ce:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    12d0:	00004797          	auipc	a5,0x4
    12d4:	eb878793          	addi	a5,a5,-328 # 5188 <malloc+0x424>
    12d8:	fcf43023          	sd	a5,-64(s0)
    12dc:	00004797          	auipc	a5,0x4
    12e0:	5a478793          	addi	a5,a5,1444 # 5880 <malloc+0xb1c>
    12e4:	fcf43423          	sd	a5,-56(s0)
    12e8:	fc043823          	sd	zero,-48(s0)
  remove("echo-ok");
    12ec:	00004517          	auipc	a0,0x4
    12f0:	59c50513          	addi	a0,a0,1436 # 5888 <malloc+0xb24>
    12f4:	00003097          	auipc	ra,0x3
    12f8:	6bc080e7          	jalr	1724(ra) # 49b0 <remove>
  pid = fork();
    12fc:	00003097          	auipc	ra,0x3
    1300:	604080e7          	jalr	1540(ra) # 4900 <fork>
  if(pid < 0) {
    1304:	04054663          	bltz	a0,1350 <exectest+0x8e>
    1308:	84aa                	mv	s1,a0
  if(pid == 0) {
    130a:	e959                	bnez	a0,13a0 <exectest+0xde>
    close(1);
    130c:	4505                	li	a0,1
    130e:	00003097          	auipc	ra,0x3
    1312:	622080e7          	jalr	1570(ra) # 4930 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1316:	20100593          	li	a1,513
    131a:	00004517          	auipc	a0,0x4
    131e:	56e50513          	addi	a0,a0,1390 # 5888 <malloc+0xb24>
    1322:	00003097          	auipc	ra,0x3
    1326:	626080e7          	jalr	1574(ra) # 4948 <open>
    if(fd < 0) {
    132a:	04054163          	bltz	a0,136c <exectest+0xaa>
    if(fd != 1) {
    132e:	4785                	li	a5,1
    1330:	04f50c63          	beq	a0,a5,1388 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    1334:	85ca                	mv	a1,s2
    1336:	00004517          	auipc	a0,0x4
    133a:	57250513          	addi	a0,a0,1394 # 58a8 <malloc+0xb44>
    133e:	00004097          	auipc	ra,0x4
    1342:	968080e7          	jalr	-1688(ra) # 4ca6 <printf>
      exit(1);
    1346:	4505                	li	a0,1
    1348:	00003097          	auipc	ra,0x3
    134c:	5c0080e7          	jalr	1472(ra) # 4908 <exit>
     printf("%s: fork failed\n", s);
    1350:	85ca                	mv	a1,s2
    1352:	00004517          	auipc	a0,0x4
    1356:	4a650513          	addi	a0,a0,1190 # 57f8 <malloc+0xa94>
    135a:	00004097          	auipc	ra,0x4
    135e:	94c080e7          	jalr	-1716(ra) # 4ca6 <printf>
     exit(1);
    1362:	4505                	li	a0,1
    1364:	00003097          	auipc	ra,0x3
    1368:	5a4080e7          	jalr	1444(ra) # 4908 <exit>
      printf("%s: create failed\n", s);
    136c:	85ca                	mv	a1,s2
    136e:	00004517          	auipc	a0,0x4
    1372:	52250513          	addi	a0,a0,1314 # 5890 <malloc+0xb2c>
    1376:	00004097          	auipc	ra,0x4
    137a:	930080e7          	jalr	-1744(ra) # 4ca6 <printf>
      exit(1);
    137e:	4505                	li	a0,1
    1380:	00003097          	auipc	ra,0x3
    1384:	588080e7          	jalr	1416(ra) # 4908 <exit>
    if(exec("echo", echoargv) < 0){
    1388:	fc040593          	addi	a1,s0,-64
    138c:	00004517          	auipc	a0,0x4
    1390:	dfc50513          	addi	a0,a0,-516 # 5188 <malloc+0x424>
    1394:	00003097          	auipc	ra,0x3
    1398:	5ac080e7          	jalr	1452(ra) # 4940 <exec>
    139c:	02054163          	bltz	a0,13be <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    13a0:	fdc40513          	addi	a0,s0,-36
    13a4:	00003097          	auipc	ra,0x3
    13a8:	56c080e7          	jalr	1388(ra) # 4910 <wait>
    13ac:	02951763          	bne	a0,s1,13da <exectest+0x118>
  if(xstatus != 0)
    13b0:	fdc42503          	lw	a0,-36(s0)
    13b4:	cd0d                	beqz	a0,13ee <exectest+0x12c>
    exit(xstatus);
    13b6:	00003097          	auipc	ra,0x3
    13ba:	552080e7          	jalr	1362(ra) # 4908 <exit>
      printf("%s: exec echo failed\n", s);
    13be:	85ca                	mv	a1,s2
    13c0:	00004517          	auipc	a0,0x4
    13c4:	4f850513          	addi	a0,a0,1272 # 58b8 <malloc+0xb54>
    13c8:	00004097          	auipc	ra,0x4
    13cc:	8de080e7          	jalr	-1826(ra) # 4ca6 <printf>
      exit(1);
    13d0:	4505                	li	a0,1
    13d2:	00003097          	auipc	ra,0x3
    13d6:	536080e7          	jalr	1334(ra) # 4908 <exit>
    printf("%s: wait failed!\n", s);
    13da:	85ca                	mv	a1,s2
    13dc:	00004517          	auipc	a0,0x4
    13e0:	4f450513          	addi	a0,a0,1268 # 58d0 <malloc+0xb6c>
    13e4:	00004097          	auipc	ra,0x4
    13e8:	8c2080e7          	jalr	-1854(ra) # 4ca6 <printf>
    13ec:	b7d1                	j	13b0 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    13ee:	4581                	li	a1,0
    13f0:	00004517          	auipc	a0,0x4
    13f4:	49850513          	addi	a0,a0,1176 # 5888 <malloc+0xb24>
    13f8:	00003097          	auipc	ra,0x3
    13fc:	550080e7          	jalr	1360(ra) # 4948 <open>
  if(fd < 0) {
    1400:	02054a63          	bltz	a0,1434 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    1404:	4609                	li	a2,2
    1406:	fb840593          	addi	a1,s0,-72
    140a:	00003097          	auipc	ra,0x3
    140e:	516080e7          	jalr	1302(ra) # 4920 <read>
    1412:	4789                	li	a5,2
    1414:	02f50e63          	beq	a0,a5,1450 <exectest+0x18e>
    printf("%s: read failed\n", s);
    1418:	85ca                	mv	a1,s2
    141a:	00004517          	auipc	a0,0x4
    141e:	12e50513          	addi	a0,a0,302 # 5548 <malloc+0x7e4>
    1422:	00004097          	auipc	ra,0x4
    1426:	884080e7          	jalr	-1916(ra) # 4ca6 <printf>
    exit(1);
    142a:	4505                	li	a0,1
    142c:	00003097          	auipc	ra,0x3
    1430:	4dc080e7          	jalr	1244(ra) # 4908 <exit>
    printf("%s: open failed\n", s);
    1434:	85ca                	mv	a1,s2
    1436:	00004517          	auipc	a0,0x4
    143a:	3da50513          	addi	a0,a0,986 # 5810 <malloc+0xaac>
    143e:	00004097          	auipc	ra,0x4
    1442:	868080e7          	jalr	-1944(ra) # 4ca6 <printf>
    exit(1);
    1446:	4505                	li	a0,1
    1448:	00003097          	auipc	ra,0x3
    144c:	4c0080e7          	jalr	1216(ra) # 4908 <exit>
  remove("echo-ok");
    1450:	00004517          	auipc	a0,0x4
    1454:	43850513          	addi	a0,a0,1080 # 5888 <malloc+0xb24>
    1458:	00003097          	auipc	ra,0x3
    145c:	558080e7          	jalr	1368(ra) # 49b0 <remove>
  if(buf[0] == 'O' && buf[1] == 'K')
    1460:	fb844703          	lbu	a4,-72(s0)
    1464:	04f00793          	li	a5,79
    1468:	00f71863          	bne	a4,a5,1478 <exectest+0x1b6>
    146c:	fb944703          	lbu	a4,-71(s0)
    1470:	04b00793          	li	a5,75
    1474:	02f70063          	beq	a4,a5,1494 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    1478:	85ca                	mv	a1,s2
    147a:	00004517          	auipc	a0,0x4
    147e:	46e50513          	addi	a0,a0,1134 # 58e8 <malloc+0xb84>
    1482:	00004097          	auipc	ra,0x4
    1486:	824080e7          	jalr	-2012(ra) # 4ca6 <printf>
    exit(1);
    148a:	4505                	li	a0,1
    148c:	00003097          	auipc	ra,0x3
    1490:	47c080e7          	jalr	1148(ra) # 4908 <exit>
    exit(0);
    1494:	4501                	li	a0,0
    1496:	00003097          	auipc	ra,0x3
    149a:	472080e7          	jalr	1138(ra) # 4908 <exit>

000000000000149e <pipe1>:
{
    149e:	711d                	addi	sp,sp,-96
    14a0:	ec86                	sd	ra,88(sp)
    14a2:	e8a2                	sd	s0,80(sp)
    14a4:	e4a6                	sd	s1,72(sp)
    14a6:	e0ca                	sd	s2,64(sp)
    14a8:	fc4e                	sd	s3,56(sp)
    14aa:	f852                	sd	s4,48(sp)
    14ac:	f456                	sd	s5,40(sp)
    14ae:	f05a                	sd	s6,32(sp)
    14b0:	ec5e                	sd	s7,24(sp)
    14b2:	1080                	addi	s0,sp,96
    14b4:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    14b6:	fa840513          	addi	a0,s0,-88
    14ba:	00003097          	auipc	ra,0x3
    14be:	45e080e7          	jalr	1118(ra) # 4918 <pipe>
    14c2:	ed35                	bnez	a0,153e <pipe1+0xa0>
    14c4:	84aa                	mv	s1,a0
  pid = fork();
    14c6:	00003097          	auipc	ra,0x3
    14ca:	43a080e7          	jalr	1082(ra) # 4900 <fork>
    14ce:	8a2a                	mv	s4,a0
  if(pid == 0){
    14d0:	c549                	beqz	a0,155a <pipe1+0xbc>
  } else if(pid > 0){
    14d2:	18a05063          	blez	a0,1652 <pipe1+0x1b4>
    close(fds[1]);
    14d6:	fac42503          	lw	a0,-84(s0)
    14da:	00003097          	auipc	ra,0x3
    14de:	456080e7          	jalr	1110(ra) # 4930 <close>
    total = 0;
    14e2:	8aa6                	mv	s5,s1
    cc = 1;
    14e4:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    14e6:	00009b17          	auipc	s6,0x9
    14ea:	33ab0b13          	addi	s6,s6,826 # a820 <buf>
      if(cc > sizeof(buf))
    14ee:	6a09                	lui	s4,0x2
    14f0:	800a0a13          	addi	s4,s4,-2048 # 1800 <forkfork+0x3e>
    while((n = read(fds[0], buf, cc)) > 0){
    14f4:	864e                	mv	a2,s3
    14f6:	85da                	mv	a1,s6
    14f8:	fa842503          	lw	a0,-88(s0)
    14fc:	00003097          	auipc	ra,0x3
    1500:	424080e7          	jalr	1060(ra) # 4920 <read>
    1504:	10a05263          	blez	a0,1608 <pipe1+0x16a>
      for(i = 0; i < n; i++){
    1508:	00009717          	auipc	a4,0x9
    150c:	31870713          	addi	a4,a4,792 # a820 <buf>
    1510:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1514:	00074683          	lbu	a3,0(a4)
    1518:	0ff4f793          	andi	a5,s1,255
    151c:	2485                	addiw	s1,s1,1
    151e:	0cf69163          	bne	a3,a5,15e0 <pipe1+0x142>
      for(i = 0; i < n; i++){
    1522:	0705                	addi	a4,a4,1
    1524:	fec498e3          	bne	s1,a2,1514 <pipe1+0x76>
      total += n;
    1528:	00aa8abb          	addw	s5,s5,a0
      cc = cc * 2;
    152c:	0019979b          	slliw	a5,s3,0x1
    1530:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    1534:	013a7363          	bgeu	s4,s3,153a <pipe1+0x9c>
        cc = sizeof(buf);
    1538:	89d2                	mv	s3,s4
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    153a:	84b2                	mv	s1,a2
    153c:	bf65                	j	14f4 <pipe1+0x56>
    printf("%s: pipe() failed\n", s);
    153e:	85ca                	mv	a1,s2
    1540:	00004517          	auipc	a0,0x4
    1544:	3c050513          	addi	a0,a0,960 # 5900 <malloc+0xb9c>
    1548:	00003097          	auipc	ra,0x3
    154c:	75e080e7          	jalr	1886(ra) # 4ca6 <printf>
    exit(1);
    1550:	4505                	li	a0,1
    1552:	00003097          	auipc	ra,0x3
    1556:	3b6080e7          	jalr	950(ra) # 4908 <exit>
    close(fds[0]);
    155a:	fa842503          	lw	a0,-88(s0)
    155e:	00003097          	auipc	ra,0x3
    1562:	3d2080e7          	jalr	978(ra) # 4930 <close>
    for(n = 0; n < N; n++){
    1566:	00009b17          	auipc	s6,0x9
    156a:	2bab0b13          	addi	s6,s6,698 # a820 <buf>
    156e:	416004bb          	negw	s1,s6
    1572:	0ff4f493          	andi	s1,s1,255
    1576:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    157a:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    157c:	6a85                	lui	s5,0x1
    157e:	42da8a93          	addi	s5,s5,1069 # 142d <exectest+0x16b>
{
    1582:	87da                	mv	a5,s6
        buf[i] = seq++;
    1584:	0097873b          	addw	a4,a5,s1
    1588:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    158c:	0785                	addi	a5,a5,1
    158e:	fef99be3          	bne	s3,a5,1584 <pipe1+0xe6>
        buf[i] = seq++;
    1592:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1596:	40900613          	li	a2,1033
    159a:	85de                	mv	a1,s7
    159c:	fac42503          	lw	a0,-84(s0)
    15a0:	00003097          	auipc	ra,0x3
    15a4:	388080e7          	jalr	904(ra) # 4928 <write>
    15a8:	40900793          	li	a5,1033
    15ac:	00f51c63          	bne	a0,a5,15c4 <pipe1+0x126>
    for(n = 0; n < N; n++){
    15b0:	24a5                	addiw	s1,s1,9
    15b2:	0ff4f493          	andi	s1,s1,255
    15b6:	fd5a16e3          	bne	s4,s5,1582 <pipe1+0xe4>
    exit(0);
    15ba:	4501                	li	a0,0
    15bc:	00003097          	auipc	ra,0x3
    15c0:	34c080e7          	jalr	844(ra) # 4908 <exit>
        printf("%s: pipe1 oops 1\n", s);
    15c4:	85ca                	mv	a1,s2
    15c6:	00004517          	auipc	a0,0x4
    15ca:	35250513          	addi	a0,a0,850 # 5918 <malloc+0xbb4>
    15ce:	00003097          	auipc	ra,0x3
    15d2:	6d8080e7          	jalr	1752(ra) # 4ca6 <printf>
        exit(1);
    15d6:	4505                	li	a0,1
    15d8:	00003097          	auipc	ra,0x3
    15dc:	330080e7          	jalr	816(ra) # 4908 <exit>
          printf("%s: pipe1 oops 2\n", s);
    15e0:	85ca                	mv	a1,s2
    15e2:	00004517          	auipc	a0,0x4
    15e6:	34e50513          	addi	a0,a0,846 # 5930 <malloc+0xbcc>
    15ea:	00003097          	auipc	ra,0x3
    15ee:	6bc080e7          	jalr	1724(ra) # 4ca6 <printf>
}
    15f2:	60e6                	ld	ra,88(sp)
    15f4:	6446                	ld	s0,80(sp)
    15f6:	64a6                	ld	s1,72(sp)
    15f8:	6906                	ld	s2,64(sp)
    15fa:	79e2                	ld	s3,56(sp)
    15fc:	7a42                	ld	s4,48(sp)
    15fe:	7aa2                	ld	s5,40(sp)
    1600:	7b02                	ld	s6,32(sp)
    1602:	6be2                	ld	s7,24(sp)
    1604:	6125                	addi	sp,sp,96
    1606:	8082                	ret
    if(total != N * SZ){
    1608:	6785                	lui	a5,0x1
    160a:	42d78793          	addi	a5,a5,1069 # 142d <exectest+0x16b>
    160e:	02fa8063          	beq	s5,a5,162e <pipe1+0x190>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1612:	85d6                	mv	a1,s5
    1614:	00004517          	auipc	a0,0x4
    1618:	33450513          	addi	a0,a0,820 # 5948 <malloc+0xbe4>
    161c:	00003097          	auipc	ra,0x3
    1620:	68a080e7          	jalr	1674(ra) # 4ca6 <printf>
      exit(1);
    1624:	4505                	li	a0,1
    1626:	00003097          	auipc	ra,0x3
    162a:	2e2080e7          	jalr	738(ra) # 4908 <exit>
    close(fds[0]);
    162e:	fa842503          	lw	a0,-88(s0)
    1632:	00003097          	auipc	ra,0x3
    1636:	2fe080e7          	jalr	766(ra) # 4930 <close>
    wait(&xstatus);
    163a:	fa440513          	addi	a0,s0,-92
    163e:	00003097          	auipc	ra,0x3
    1642:	2d2080e7          	jalr	722(ra) # 4910 <wait>
    exit(xstatus);
    1646:	fa442503          	lw	a0,-92(s0)
    164a:	00003097          	auipc	ra,0x3
    164e:	2be080e7          	jalr	702(ra) # 4908 <exit>
    printf("%s: fork() failed\n", s);
    1652:	85ca                	mv	a1,s2
    1654:	00004517          	auipc	a0,0x4
    1658:	31450513          	addi	a0,a0,788 # 5968 <malloc+0xc04>
    165c:	00003097          	auipc	ra,0x3
    1660:	64a080e7          	jalr	1610(ra) # 4ca6 <printf>
    exit(1);
    1664:	4505                	li	a0,1
    1666:	00003097          	auipc	ra,0x3
    166a:	2a2080e7          	jalr	674(ra) # 4908 <exit>

000000000000166e <exitwait>:
{
    166e:	715d                	addi	sp,sp,-80
    1670:	e486                	sd	ra,72(sp)
    1672:	e0a2                	sd	s0,64(sp)
    1674:	fc26                	sd	s1,56(sp)
    1676:	f84a                	sd	s2,48(sp)
    1678:	f44e                	sd	s3,40(sp)
    167a:	f052                	sd	s4,32(sp)
    167c:	ec56                	sd	s5,24(sp)
    167e:	0880                	addi	s0,sp,80
    1680:	8aaa                	mv	s5,a0
  for(i = 0; i < 100; i++){
    1682:	4901                	li	s2,0
      if(wait(&xstate) != pid){
    1684:	fbc40993          	addi	s3,s0,-68
  for(i = 0; i < 100; i++){
    1688:	06400a13          	li	s4,100
    pid = fork();
    168c:	00003097          	auipc	ra,0x3
    1690:	274080e7          	jalr	628(ra) # 4900 <fork>
    1694:	84aa                	mv	s1,a0
    if(pid < 0){
    1696:	02054a63          	bltz	a0,16ca <exitwait+0x5c>
    if(pid){
    169a:	c151                	beqz	a0,171e <exitwait+0xb0>
      if(wait(&xstate) != pid){
    169c:	854e                	mv	a0,s3
    169e:	00003097          	auipc	ra,0x3
    16a2:	272080e7          	jalr	626(ra) # 4910 <wait>
    16a6:	04951063          	bne	a0,s1,16e6 <exitwait+0x78>
      if(i != xstate) {
    16aa:	fbc42783          	lw	a5,-68(s0)
    16ae:	05279a63          	bne	a5,s2,1702 <exitwait+0x94>
  for(i = 0; i < 100; i++){
    16b2:	2905                	addiw	s2,s2,1
    16b4:	fd491ce3          	bne	s2,s4,168c <exitwait+0x1e>
}
    16b8:	60a6                	ld	ra,72(sp)
    16ba:	6406                	ld	s0,64(sp)
    16bc:	74e2                	ld	s1,56(sp)
    16be:	7942                	ld	s2,48(sp)
    16c0:	79a2                	ld	s3,40(sp)
    16c2:	7a02                	ld	s4,32(sp)
    16c4:	6ae2                	ld	s5,24(sp)
    16c6:	6161                	addi	sp,sp,80
    16c8:	8082                	ret
      printf("%s: fork failed\n", s);
    16ca:	85d6                	mv	a1,s5
    16cc:	00004517          	auipc	a0,0x4
    16d0:	12c50513          	addi	a0,a0,300 # 57f8 <malloc+0xa94>
    16d4:	00003097          	auipc	ra,0x3
    16d8:	5d2080e7          	jalr	1490(ra) # 4ca6 <printf>
      exit(1);
    16dc:	4505                	li	a0,1
    16de:	00003097          	auipc	ra,0x3
    16e2:	22a080e7          	jalr	554(ra) # 4908 <exit>
        printf("%s: wait wrong pid\n", s);
    16e6:	85d6                	mv	a1,s5
    16e8:	00004517          	auipc	a0,0x4
    16ec:	29850513          	addi	a0,a0,664 # 5980 <malloc+0xc1c>
    16f0:	00003097          	auipc	ra,0x3
    16f4:	5b6080e7          	jalr	1462(ra) # 4ca6 <printf>
        exit(1);
    16f8:	4505                	li	a0,1
    16fa:	00003097          	auipc	ra,0x3
    16fe:	20e080e7          	jalr	526(ra) # 4908 <exit>
        printf("%s: wait wrong exit status\n", s);
    1702:	85d6                	mv	a1,s5
    1704:	00004517          	auipc	a0,0x4
    1708:	29450513          	addi	a0,a0,660 # 5998 <malloc+0xc34>
    170c:	00003097          	auipc	ra,0x3
    1710:	59a080e7          	jalr	1434(ra) # 4ca6 <printf>
        exit(1);
    1714:	4505                	li	a0,1
    1716:	00003097          	auipc	ra,0x3
    171a:	1f2080e7          	jalr	498(ra) # 4908 <exit>
      exit(i);
    171e:	854a                	mv	a0,s2
    1720:	00003097          	auipc	ra,0x3
    1724:	1e8080e7          	jalr	488(ra) # 4908 <exit>

0000000000001728 <twochildren>:
{
    1728:	1101                	addi	sp,sp,-32
    172a:	ec06                	sd	ra,24(sp)
    172c:	e822                	sd	s0,16(sp)
    172e:	e426                	sd	s1,8(sp)
    1730:	e04a                	sd	s2,0(sp)
    1732:	1000                	addi	s0,sp,32
    1734:	892a                	mv	s2,a0
    1736:	3e800493          	li	s1,1000
    int pid1 = fork();
    173a:	00003097          	auipc	ra,0x3
    173e:	1c6080e7          	jalr	454(ra) # 4900 <fork>
    if(pid1 < 0){
    1742:	02054c63          	bltz	a0,177a <twochildren+0x52>
    if(pid1 == 0){
    1746:	c921                	beqz	a0,1796 <twochildren+0x6e>
      int pid2 = fork();
    1748:	00003097          	auipc	ra,0x3
    174c:	1b8080e7          	jalr	440(ra) # 4900 <fork>
      if(pid2 < 0){
    1750:	04054763          	bltz	a0,179e <twochildren+0x76>
      if(pid2 == 0){
    1754:	c13d                	beqz	a0,17ba <twochildren+0x92>
        wait(0);
    1756:	4501                	li	a0,0
    1758:	00003097          	auipc	ra,0x3
    175c:	1b8080e7          	jalr	440(ra) # 4910 <wait>
        wait(0);
    1760:	4501                	li	a0,0
    1762:	00003097          	auipc	ra,0x3
    1766:	1ae080e7          	jalr	430(ra) # 4910 <wait>
  for(int i = 0; i < 1000; i++){
    176a:	34fd                	addiw	s1,s1,-1
    176c:	f4f9                	bnez	s1,173a <twochildren+0x12>
}
    176e:	60e2                	ld	ra,24(sp)
    1770:	6442                	ld	s0,16(sp)
    1772:	64a2                	ld	s1,8(sp)
    1774:	6902                	ld	s2,0(sp)
    1776:	6105                	addi	sp,sp,32
    1778:	8082                	ret
      printf("%s: fork failed\n", s);
    177a:	85ca                	mv	a1,s2
    177c:	00004517          	auipc	a0,0x4
    1780:	07c50513          	addi	a0,a0,124 # 57f8 <malloc+0xa94>
    1784:	00003097          	auipc	ra,0x3
    1788:	522080e7          	jalr	1314(ra) # 4ca6 <printf>
      exit(1);
    178c:	4505                	li	a0,1
    178e:	00003097          	auipc	ra,0x3
    1792:	17a080e7          	jalr	378(ra) # 4908 <exit>
      exit(0);
    1796:	00003097          	auipc	ra,0x3
    179a:	172080e7          	jalr	370(ra) # 4908 <exit>
        printf("%s: fork failed\n", s);
    179e:	85ca                	mv	a1,s2
    17a0:	00004517          	auipc	a0,0x4
    17a4:	05850513          	addi	a0,a0,88 # 57f8 <malloc+0xa94>
    17a8:	00003097          	auipc	ra,0x3
    17ac:	4fe080e7          	jalr	1278(ra) # 4ca6 <printf>
        exit(1);
    17b0:	4505                	li	a0,1
    17b2:	00003097          	auipc	ra,0x3
    17b6:	156080e7          	jalr	342(ra) # 4908 <exit>
        exit(0);
    17ba:	00003097          	auipc	ra,0x3
    17be:	14e080e7          	jalr	334(ra) # 4908 <exit>

00000000000017c2 <forkfork>:
{
    17c2:	7179                	addi	sp,sp,-48
    17c4:	f406                	sd	ra,40(sp)
    17c6:	f022                	sd	s0,32(sp)
    17c8:	ec26                	sd	s1,24(sp)
    17ca:	1800                	addi	s0,sp,48
    17cc:	84aa                	mv	s1,a0
    int pid = fork();
    17ce:	00003097          	auipc	ra,0x3
    17d2:	132080e7          	jalr	306(ra) # 4900 <fork>
    if(pid < 0){
    17d6:	04054163          	bltz	a0,1818 <forkfork+0x56>
    if(pid == 0){
    17da:	cd29                	beqz	a0,1834 <forkfork+0x72>
    int pid = fork();
    17dc:	00003097          	auipc	ra,0x3
    17e0:	124080e7          	jalr	292(ra) # 4900 <fork>
    if(pid < 0){
    17e4:	02054a63          	bltz	a0,1818 <forkfork+0x56>
    if(pid == 0){
    17e8:	c531                	beqz	a0,1834 <forkfork+0x72>
    wait(&xstatus);
    17ea:	fdc40513          	addi	a0,s0,-36
    17ee:	00003097          	auipc	ra,0x3
    17f2:	122080e7          	jalr	290(ra) # 4910 <wait>
    if(xstatus != 0) {
    17f6:	fdc42783          	lw	a5,-36(s0)
    17fa:	ebbd                	bnez	a5,1870 <forkfork+0xae>
    wait(&xstatus);
    17fc:	fdc40513          	addi	a0,s0,-36
    1800:	00003097          	auipc	ra,0x3
    1804:	110080e7          	jalr	272(ra) # 4910 <wait>
    if(xstatus != 0) {
    1808:	fdc42783          	lw	a5,-36(s0)
    180c:	e3b5                	bnez	a5,1870 <forkfork+0xae>
}
    180e:	70a2                	ld	ra,40(sp)
    1810:	7402                	ld	s0,32(sp)
    1812:	64e2                	ld	s1,24(sp)
    1814:	6145                	addi	sp,sp,48
    1816:	8082                	ret
      printf("%s: fork failed", s);
    1818:	85a6                	mv	a1,s1
    181a:	00004517          	auipc	a0,0x4
    181e:	19e50513          	addi	a0,a0,414 # 59b8 <malloc+0xc54>
    1822:	00003097          	auipc	ra,0x3
    1826:	484080e7          	jalr	1156(ra) # 4ca6 <printf>
      exit(1);
    182a:	4505                	li	a0,1
    182c:	00003097          	auipc	ra,0x3
    1830:	0dc080e7          	jalr	220(ra) # 4908 <exit>
{
    1834:	0c800493          	li	s1,200
        int pid1 = fork();
    1838:	00003097          	auipc	ra,0x3
    183c:	0c8080e7          	jalr	200(ra) # 4900 <fork>
        if(pid1 < 0){
    1840:	00054f63          	bltz	a0,185e <forkfork+0x9c>
        if(pid1 == 0){
    1844:	c115                	beqz	a0,1868 <forkfork+0xa6>
        wait(0);
    1846:	4501                	li	a0,0
    1848:	00003097          	auipc	ra,0x3
    184c:	0c8080e7          	jalr	200(ra) # 4910 <wait>
      for(int j = 0; j < 200; j++){
    1850:	34fd                	addiw	s1,s1,-1
    1852:	f0fd                	bnez	s1,1838 <forkfork+0x76>
      exit(0);
    1854:	4501                	li	a0,0
    1856:	00003097          	auipc	ra,0x3
    185a:	0b2080e7          	jalr	178(ra) # 4908 <exit>
          exit(1);
    185e:	4505                	li	a0,1
    1860:	00003097          	auipc	ra,0x3
    1864:	0a8080e7          	jalr	168(ra) # 4908 <exit>
          exit(0);
    1868:	00003097          	auipc	ra,0x3
    186c:	0a0080e7          	jalr	160(ra) # 4908 <exit>
      printf("%s: fork in child failed", s);
    1870:	85a6                	mv	a1,s1
    1872:	00004517          	auipc	a0,0x4
    1876:	15650513          	addi	a0,a0,342 # 59c8 <malloc+0xc64>
    187a:	00003097          	auipc	ra,0x3
    187e:	42c080e7          	jalr	1068(ra) # 4ca6 <printf>
      exit(1);
    1882:	4505                	li	a0,1
    1884:	00003097          	auipc	ra,0x3
    1888:	084080e7          	jalr	132(ra) # 4908 <exit>

000000000000188c <reparent2>:
{
    188c:	1101                	addi	sp,sp,-32
    188e:	ec06                	sd	ra,24(sp)
    1890:	e822                	sd	s0,16(sp)
    1892:	e426                	sd	s1,8(sp)
    1894:	1000                	addi	s0,sp,32
    1896:	32000493          	li	s1,800
    int pid1 = fork();
    189a:	00003097          	auipc	ra,0x3
    189e:	066080e7          	jalr	102(ra) # 4900 <fork>
    if(pid1 < 0){
    18a2:	00054f63          	bltz	a0,18c0 <reparent2+0x34>
    if(pid1 == 0){
    18a6:	c915                	beqz	a0,18da <reparent2+0x4e>
    wait(0);
    18a8:	4501                	li	a0,0
    18aa:	00003097          	auipc	ra,0x3
    18ae:	066080e7          	jalr	102(ra) # 4910 <wait>
  for(int i = 0; i < 800; i++){
    18b2:	34fd                	addiw	s1,s1,-1
    18b4:	f0fd                	bnez	s1,189a <reparent2+0xe>
  exit(0);
    18b6:	4501                	li	a0,0
    18b8:	00003097          	auipc	ra,0x3
    18bc:	050080e7          	jalr	80(ra) # 4908 <exit>
      printf("fork failed\n");
    18c0:	00004517          	auipc	a0,0x4
    18c4:	2b850513          	addi	a0,a0,696 # 5b78 <malloc+0xe14>
    18c8:	00003097          	auipc	ra,0x3
    18cc:	3de080e7          	jalr	990(ra) # 4ca6 <printf>
      exit(1);
    18d0:	4505                	li	a0,1
    18d2:	00003097          	auipc	ra,0x3
    18d6:	036080e7          	jalr	54(ra) # 4908 <exit>
      fork();
    18da:	00003097          	auipc	ra,0x3
    18de:	026080e7          	jalr	38(ra) # 4900 <fork>
      fork();
    18e2:	00003097          	auipc	ra,0x3
    18e6:	01e080e7          	jalr	30(ra) # 4900 <fork>
      exit(0);
    18ea:	4501                	li	a0,0
    18ec:	00003097          	auipc	ra,0x3
    18f0:	01c080e7          	jalr	28(ra) # 4908 <exit>

00000000000018f4 <forktest>:
{
    18f4:	7179                	addi	sp,sp,-48
    18f6:	f406                	sd	ra,40(sp)
    18f8:	f022                	sd	s0,32(sp)
    18fa:	ec26                	sd	s1,24(sp)
    18fc:	e84a                	sd	s2,16(sp)
    18fe:	e44e                	sd	s3,8(sp)
    1900:	1800                	addi	s0,sp,48
    1902:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1904:	4481                	li	s1,0
    1906:	3e800913          	li	s2,1000
    pid = fork();
    190a:	00003097          	auipc	ra,0x3
    190e:	ff6080e7          	jalr	-10(ra) # 4900 <fork>
    if(pid < 0)
    1912:	02054863          	bltz	a0,1942 <forktest+0x4e>
    if(pid == 0)
    1916:	c115                	beqz	a0,193a <forktest+0x46>
  for(n=0; n<N; n++){
    1918:	2485                	addiw	s1,s1,1
    191a:	ff2498e3          	bne	s1,s2,190a <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    191e:	85ce                	mv	a1,s3
    1920:	00004517          	auipc	a0,0x4
    1924:	0e050513          	addi	a0,a0,224 # 5a00 <malloc+0xc9c>
    1928:	00003097          	auipc	ra,0x3
    192c:	37e080e7          	jalr	894(ra) # 4ca6 <printf>
    exit(1);
    1930:	4505                	li	a0,1
    1932:	00003097          	auipc	ra,0x3
    1936:	fd6080e7          	jalr	-42(ra) # 4908 <exit>
      exit(0);
    193a:	00003097          	auipc	ra,0x3
    193e:	fce080e7          	jalr	-50(ra) # 4908 <exit>
  if (n == 0) {
    1942:	cc9d                	beqz	s1,1980 <forktest+0x8c>
  if(n == N){
    1944:	3e800793          	li	a5,1000
    1948:	fcf48be3          	beq	s1,a5,191e <forktest+0x2a>
  for(; n > 0; n--){
    194c:	00905b63          	blez	s1,1962 <forktest+0x6e>
    if(wait(0) < 0){
    1950:	4501                	li	a0,0
    1952:	00003097          	auipc	ra,0x3
    1956:	fbe080e7          	jalr	-66(ra) # 4910 <wait>
    195a:	04054163          	bltz	a0,199c <forktest+0xa8>
  for(; n > 0; n--){
    195e:	34fd                	addiw	s1,s1,-1
    1960:	f8e5                	bnez	s1,1950 <forktest+0x5c>
  if(wait(0) != -1){
    1962:	4501                	li	a0,0
    1964:	00003097          	auipc	ra,0x3
    1968:	fac080e7          	jalr	-84(ra) # 4910 <wait>
    196c:	57fd                	li	a5,-1
    196e:	04f51563          	bne	a0,a5,19b8 <forktest+0xc4>
}
    1972:	70a2                	ld	ra,40(sp)
    1974:	7402                	ld	s0,32(sp)
    1976:	64e2                	ld	s1,24(sp)
    1978:	6942                	ld	s2,16(sp)
    197a:	69a2                	ld	s3,8(sp)
    197c:	6145                	addi	sp,sp,48
    197e:	8082                	ret
    printf("%s: no fork at all!\n", s);
    1980:	85ce                	mv	a1,s3
    1982:	00004517          	auipc	a0,0x4
    1986:	06650513          	addi	a0,a0,102 # 59e8 <malloc+0xc84>
    198a:	00003097          	auipc	ra,0x3
    198e:	31c080e7          	jalr	796(ra) # 4ca6 <printf>
    exit(1);
    1992:	4505                	li	a0,1
    1994:	00003097          	auipc	ra,0x3
    1998:	f74080e7          	jalr	-140(ra) # 4908 <exit>
      printf("%s: wait stopped early\n", s);
    199c:	85ce                	mv	a1,s3
    199e:	00004517          	auipc	a0,0x4
    19a2:	08a50513          	addi	a0,a0,138 # 5a28 <malloc+0xcc4>
    19a6:	00003097          	auipc	ra,0x3
    19aa:	300080e7          	jalr	768(ra) # 4ca6 <printf>
      exit(1);
    19ae:	4505                	li	a0,1
    19b0:	00003097          	auipc	ra,0x3
    19b4:	f58080e7          	jalr	-168(ra) # 4908 <exit>
    printf("%s: wait got too many\n", s);
    19b8:	85ce                	mv	a1,s3
    19ba:	00004517          	auipc	a0,0x4
    19be:	08650513          	addi	a0,a0,134 # 5a40 <malloc+0xcdc>
    19c2:	00003097          	auipc	ra,0x3
    19c6:	2e4080e7          	jalr	740(ra) # 4ca6 <printf>
    exit(1);
    19ca:	4505                	li	a0,1
    19cc:	00003097          	auipc	ra,0x3
    19d0:	f3c080e7          	jalr	-196(ra) # 4908 <exit>

00000000000019d4 <kernmem>:
{
    19d4:	715d                	addi	sp,sp,-80
    19d6:	e486                	sd	ra,72(sp)
    19d8:	e0a2                	sd	s0,64(sp)
    19da:	fc26                	sd	s1,56(sp)
    19dc:	f84a                	sd	s2,48(sp)
    19de:	f44e                	sd	s3,40(sp)
    19e0:	f052                	sd	s4,32(sp)
    19e2:	ec56                	sd	s5,24(sp)
    19e4:	e85a                	sd	s6,16(sp)
    19e6:	0880                	addi	s0,sp,80
    19e8:	8b2a                	mv	s6,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    19ea:	040014b7          	lui	s1,0x4001
    19ee:	0496                	slli	s1,s1,0x5
    wait(&xstatus);
    19f0:	fbc40a93          	addi	s5,s0,-68
    if(xstatus != -1)  // did kernel kill child?
    19f4:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    19f6:	69b1                	lui	s3,0xc
    19f8:	35098993          	addi	s3,s3,848 # c350 <__BSS_END__+0x318>
    19fc:	10041937          	lui	s2,0x10041
    1a00:	090e                	slli	s2,s2,0x3
    1a02:	48090913          	addi	s2,s2,1152 # 10041480 <__BSS_END__+0x10035448>
    pid = fork();
    1a06:	00003097          	auipc	ra,0x3
    1a0a:	efa080e7          	jalr	-262(ra) # 4900 <fork>
    if(pid < 0){
    1a0e:	02054963          	bltz	a0,1a40 <kernmem+0x6c>
    if(pid == 0){
    1a12:	c529                	beqz	a0,1a5c <kernmem+0x88>
    wait(&xstatus);
    1a14:	8556                	mv	a0,s5
    1a16:	00003097          	auipc	ra,0x3
    1a1a:	efa080e7          	jalr	-262(ra) # 4910 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1a1e:	fbc42783          	lw	a5,-68(s0)
    1a22:	05479d63          	bne	a5,s4,1a7c <kernmem+0xa8>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1a26:	94ce                	add	s1,s1,s3
    1a28:	fd249fe3          	bne	s1,s2,1a06 <kernmem+0x32>
}
    1a2c:	60a6                	ld	ra,72(sp)
    1a2e:	6406                	ld	s0,64(sp)
    1a30:	74e2                	ld	s1,56(sp)
    1a32:	7942                	ld	s2,48(sp)
    1a34:	79a2                	ld	s3,40(sp)
    1a36:	7a02                	ld	s4,32(sp)
    1a38:	6ae2                	ld	s5,24(sp)
    1a3a:	6b42                	ld	s6,16(sp)
    1a3c:	6161                	addi	sp,sp,80
    1a3e:	8082                	ret
      printf("%s: fork failed\n", s);
    1a40:	85da                	mv	a1,s6
    1a42:	00004517          	auipc	a0,0x4
    1a46:	db650513          	addi	a0,a0,-586 # 57f8 <malloc+0xa94>
    1a4a:	00003097          	auipc	ra,0x3
    1a4e:	25c080e7          	jalr	604(ra) # 4ca6 <printf>
      exit(1);
    1a52:	4505                	li	a0,1
    1a54:	00003097          	auipc	ra,0x3
    1a58:	eb4080e7          	jalr	-332(ra) # 4908 <exit>
      printf("%s: oops could read %x = %x\n", a, *a);
    1a5c:	0004c603          	lbu	a2,0(s1) # 4001000 <__BSS_END__+0x3ff4fc8>
    1a60:	85a6                	mv	a1,s1
    1a62:	00004517          	auipc	a0,0x4
    1a66:	ff650513          	addi	a0,a0,-10 # 5a58 <malloc+0xcf4>
    1a6a:	00003097          	auipc	ra,0x3
    1a6e:	23c080e7          	jalr	572(ra) # 4ca6 <printf>
      exit(1);
    1a72:	4505                	li	a0,1
    1a74:	00003097          	auipc	ra,0x3
    1a78:	e94080e7          	jalr	-364(ra) # 4908 <exit>
      exit(1);
    1a7c:	4505                	li	a0,1
    1a7e:	00003097          	auipc	ra,0x3
    1a82:	e8a080e7          	jalr	-374(ra) # 4908 <exit>

0000000000001a86 <bigargtest>:
{
    1a86:	7179                	addi	sp,sp,-48
    1a88:	f406                	sd	ra,40(sp)
    1a8a:	f022                	sd	s0,32(sp)
    1a8c:	ec26                	sd	s1,24(sp)
    1a8e:	1800                	addi	s0,sp,48
    1a90:	84aa                	mv	s1,a0
  remove("bigarg-ok");
    1a92:	00004517          	auipc	a0,0x4
    1a96:	fe650513          	addi	a0,a0,-26 # 5a78 <malloc+0xd14>
    1a9a:	00003097          	auipc	ra,0x3
    1a9e:	f16080e7          	jalr	-234(ra) # 49b0 <remove>
  pid = fork();
    1aa2:	00003097          	auipc	ra,0x3
    1aa6:	e5e080e7          	jalr	-418(ra) # 4900 <fork>
  if(pid == 0){
    1aaa:	c921                	beqz	a0,1afa <bigargtest+0x74>
  } else if(pid < 0){
    1aac:	0a054a63          	bltz	a0,1b60 <bigargtest+0xda>
  wait(&xstatus);
    1ab0:	fdc40513          	addi	a0,s0,-36
    1ab4:	00003097          	auipc	ra,0x3
    1ab8:	e5c080e7          	jalr	-420(ra) # 4910 <wait>
  if(xstatus != 0)
    1abc:	fdc42503          	lw	a0,-36(s0)
    1ac0:	ed55                	bnez	a0,1b7c <bigargtest+0xf6>
  fd = open("bigarg-ok", 0);
    1ac2:	4581                	li	a1,0
    1ac4:	00004517          	auipc	a0,0x4
    1ac8:	fb450513          	addi	a0,a0,-76 # 5a78 <malloc+0xd14>
    1acc:	00003097          	auipc	ra,0x3
    1ad0:	e7c080e7          	jalr	-388(ra) # 4948 <open>
  if(fd < 0){
    1ad4:	0a054863          	bltz	a0,1b84 <bigargtest+0xfe>
  close(fd);
    1ad8:	00003097          	auipc	ra,0x3
    1adc:	e58080e7          	jalr	-424(ra) # 4930 <close>
  remove("bigarg-ok");
    1ae0:	00004517          	auipc	a0,0x4
    1ae4:	f9850513          	addi	a0,a0,-104 # 5a78 <malloc+0xd14>
    1ae8:	00003097          	auipc	ra,0x3
    1aec:	ec8080e7          	jalr	-312(ra) # 49b0 <remove>
}
    1af0:	70a2                	ld	ra,40(sp)
    1af2:	7402                	ld	s0,32(sp)
    1af4:	64e2                	ld	s1,24(sp)
    1af6:	6145                	addi	sp,sp,48
    1af8:	8082                	ret
    1afa:	00005797          	auipc	a5,0x5
    1afe:	50e78793          	addi	a5,a5,1294 # 7008 <args.1>
    1b02:	00005697          	auipc	a3,0x5
    1b06:	5fe68693          	addi	a3,a3,1534 # 7100 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    1b0a:	00004717          	auipc	a4,0x4
    1b0e:	f7e70713          	addi	a4,a4,-130 # 5a88 <malloc+0xd24>
    1b12:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    1b14:	07a1                	addi	a5,a5,8
    1b16:	fed79ee3          	bne	a5,a3,1b12 <bigargtest+0x8c>
    args[MAXARG-1] = 0;
    1b1a:	00005797          	auipc	a5,0x5
    1b1e:	5e07b323          	sd	zero,1510(a5) # 7100 <args.1+0xf8>
    exec("echo", args);
    1b22:	00005597          	auipc	a1,0x5
    1b26:	4e658593          	addi	a1,a1,1254 # 7008 <args.1>
    1b2a:	00003517          	auipc	a0,0x3
    1b2e:	65e50513          	addi	a0,a0,1630 # 5188 <malloc+0x424>
    1b32:	00003097          	auipc	ra,0x3
    1b36:	e0e080e7          	jalr	-498(ra) # 4940 <exec>
    fd = open("bigarg-ok", O_CREATE);
    1b3a:	20000593          	li	a1,512
    1b3e:	00004517          	auipc	a0,0x4
    1b42:	f3a50513          	addi	a0,a0,-198 # 5a78 <malloc+0xd14>
    1b46:	00003097          	auipc	ra,0x3
    1b4a:	e02080e7          	jalr	-510(ra) # 4948 <open>
    close(fd);
    1b4e:	00003097          	auipc	ra,0x3
    1b52:	de2080e7          	jalr	-542(ra) # 4930 <close>
    exit(0);
    1b56:	4501                	li	a0,0
    1b58:	00003097          	auipc	ra,0x3
    1b5c:	db0080e7          	jalr	-592(ra) # 4908 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    1b60:	85a6                	mv	a1,s1
    1b62:	00004517          	auipc	a0,0x4
    1b66:	00650513          	addi	a0,a0,6 # 5b68 <malloc+0xe04>
    1b6a:	00003097          	auipc	ra,0x3
    1b6e:	13c080e7          	jalr	316(ra) # 4ca6 <printf>
    exit(1);
    1b72:	4505                	li	a0,1
    1b74:	00003097          	auipc	ra,0x3
    1b78:	d94080e7          	jalr	-620(ra) # 4908 <exit>
    exit(xstatus);
    1b7c:	00003097          	auipc	ra,0x3
    1b80:	d8c080e7          	jalr	-628(ra) # 4908 <exit>
    printf("%s: bigarg test failed!\n", s);
    1b84:	85a6                	mv	a1,s1
    1b86:	00004517          	auipc	a0,0x4
    1b8a:	00250513          	addi	a0,a0,2 # 5b88 <malloc+0xe24>
    1b8e:	00003097          	auipc	ra,0x3
    1b92:	118080e7          	jalr	280(ra) # 4ca6 <printf>
    exit(1);
    1b96:	4505                	li	a0,1
    1b98:	00003097          	auipc	ra,0x3
    1b9c:	d70080e7          	jalr	-656(ra) # 4908 <exit>

0000000000001ba0 <stacktest>:
{
    1ba0:	7179                	addi	sp,sp,-48
    1ba2:	f406                	sd	ra,40(sp)
    1ba4:	f022                	sd	s0,32(sp)
    1ba6:	ec26                	sd	s1,24(sp)
    1ba8:	1800                	addi	s0,sp,48
    1baa:	84aa                	mv	s1,a0
  pid = fork();
    1bac:	00003097          	auipc	ra,0x3
    1bb0:	d54080e7          	jalr	-684(ra) # 4900 <fork>
  if(pid == 0) {
    1bb4:	c115                	beqz	a0,1bd8 <stacktest+0x38>
  } else if(pid < 0){
    1bb6:	04054363          	bltz	a0,1bfc <stacktest+0x5c>
  wait(&xstatus);
    1bba:	fdc40513          	addi	a0,s0,-36
    1bbe:	00003097          	auipc	ra,0x3
    1bc2:	d52080e7          	jalr	-686(ra) # 4910 <wait>
  if(xstatus == -1)  // kernel killed child?
    1bc6:	fdc42503          	lw	a0,-36(s0)
    1bca:	57fd                	li	a5,-1
    1bcc:	04f50663          	beq	a0,a5,1c18 <stacktest+0x78>
    exit(xstatus);
    1bd0:	00003097          	auipc	ra,0x3
    1bd4:	d38080e7          	jalr	-712(ra) # 4908 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    1bd8:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", *sp);
    1bda:	77fd                	lui	a5,0xfffff
    1bdc:	97ba                	add	a5,a5,a4
    1bde:	0007c583          	lbu	a1,0(a5) # fffffffffffff000 <__BSS_END__+0xffffffffffff2fc8>
    1be2:	00004517          	auipc	a0,0x4
    1be6:	fc650513          	addi	a0,a0,-58 # 5ba8 <malloc+0xe44>
    1bea:	00003097          	auipc	ra,0x3
    1bee:	0bc080e7          	jalr	188(ra) # 4ca6 <printf>
    exit(1);
    1bf2:	4505                	li	a0,1
    1bf4:	00003097          	auipc	ra,0x3
    1bf8:	d14080e7          	jalr	-748(ra) # 4908 <exit>
    printf("%s: fork failed\n", s);
    1bfc:	85a6                	mv	a1,s1
    1bfe:	00004517          	auipc	a0,0x4
    1c02:	bfa50513          	addi	a0,a0,-1030 # 57f8 <malloc+0xa94>
    1c06:	00003097          	auipc	ra,0x3
    1c0a:	0a0080e7          	jalr	160(ra) # 4ca6 <printf>
    exit(1);
    1c0e:	4505                	li	a0,1
    1c10:	00003097          	auipc	ra,0x3
    1c14:	cf8080e7          	jalr	-776(ra) # 4908 <exit>
    exit(0);
    1c18:	4501                	li	a0,0
    1c1a:	00003097          	auipc	ra,0x3
    1c1e:	cee080e7          	jalr	-786(ra) # 4908 <exit>

0000000000001c22 <copyinstr3>:
{
    1c22:	7179                	addi	sp,sp,-48
    1c24:	f406                	sd	ra,40(sp)
    1c26:	f022                	sd	s0,32(sp)
    1c28:	ec26                	sd	s1,24(sp)
    1c2a:	1800                	addi	s0,sp,48
  sbrk(8192);
    1c2c:	6509                	lui	a0,0x2
    1c2e:	00003097          	auipc	ra,0x3
    1c32:	d4a080e7          	jalr	-694(ra) # 4978 <sbrk>
  uint64 top = (uint64) sbrk(0);
    1c36:	4501                	li	a0,0
    1c38:	00003097          	auipc	ra,0x3
    1c3c:	d40080e7          	jalr	-704(ra) # 4978 <sbrk>
  if((top % PGSIZE) != 0){
    1c40:	03451793          	slli	a5,a0,0x34
    1c44:	eba5                	bnez	a5,1cb4 <copyinstr3+0x92>
  top = (uint64) sbrk(0);
    1c46:	4501                	li	a0,0
    1c48:	00003097          	auipc	ra,0x3
    1c4c:	d30080e7          	jalr	-720(ra) # 4978 <sbrk>
  if(top % PGSIZE){
    1c50:	03451793          	slli	a5,a0,0x34
    1c54:	ebb5                	bnez	a5,1cc8 <copyinstr3+0xa6>
  char *b = (char *) (top - 1);
    1c56:	fff50493          	addi	s1,a0,-1 # 1fff <sbrkmuch+0x13f>
  *b = 'x';
    1c5a:	07800793          	li	a5,120
    1c5e:	fef50fa3          	sb	a5,-1(a0)
  int ret = remove(b);
    1c62:	8526                	mv	a0,s1
    1c64:	00003097          	auipc	ra,0x3
    1c68:	d4c080e7          	jalr	-692(ra) # 49b0 <remove>
  if(ret != -1){
    1c6c:	57fd                	li	a5,-1
    1c6e:	06f51a63          	bne	a0,a5,1ce2 <copyinstr3+0xc0>
  int fd = open(b, O_CREATE | O_WRONLY);
    1c72:	20100593          	li	a1,513
    1c76:	8526                	mv	a0,s1
    1c78:	00003097          	auipc	ra,0x3
    1c7c:	cd0080e7          	jalr	-816(ra) # 4948 <open>
  if(fd != -1){
    1c80:	57fd                	li	a5,-1
    1c82:	06f51f63          	bne	a0,a5,1d00 <copyinstr3+0xde>
  char *args[] = { "xx", 0 };
    1c86:	00004797          	auipc	a5,0x4
    1c8a:	6ca78793          	addi	a5,a5,1738 # 6350 <malloc+0x15ec>
    1c8e:	fcf43823          	sd	a5,-48(s0)
    1c92:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    1c96:	fd040593          	addi	a1,s0,-48
    1c9a:	8526                	mv	a0,s1
    1c9c:	00003097          	auipc	ra,0x3
    1ca0:	ca4080e7          	jalr	-860(ra) # 4940 <exec>
  if(ret != -1){
    1ca4:	57fd                	li	a5,-1
    1ca6:	06f51c63          	bne	a0,a5,1d1e <copyinstr3+0xfc>
}
    1caa:	70a2                	ld	ra,40(sp)
    1cac:	7402                	ld	s0,32(sp)
    1cae:	64e2                	ld	s1,24(sp)
    1cb0:	6145                	addi	sp,sp,48
    1cb2:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    1cb4:	0347d513          	srli	a0,a5,0x34
    1cb8:	6785                	lui	a5,0x1
    1cba:	40a7853b          	subw	a0,a5,a0
    1cbe:	00003097          	auipc	ra,0x3
    1cc2:	cba080e7          	jalr	-838(ra) # 4978 <sbrk>
    1cc6:	b741                	j	1c46 <copyinstr3+0x24>
    printf("oops\n");
    1cc8:	00004517          	auipc	a0,0x4
    1ccc:	f0850513          	addi	a0,a0,-248 # 5bd0 <malloc+0xe6c>
    1cd0:	00003097          	auipc	ra,0x3
    1cd4:	fd6080e7          	jalr	-42(ra) # 4ca6 <printf>
    exit(1);
    1cd8:	4505                	li	a0,1
    1cda:	00003097          	auipc	ra,0x3
    1cde:	c2e080e7          	jalr	-978(ra) # 4908 <exit>
    printf("remove(%s) returned %d, not -1\n", b, ret);
    1ce2:	862a                	mv	a2,a0
    1ce4:	85a6                	mv	a1,s1
    1ce6:	00004517          	auipc	a0,0x4
    1cea:	a5a50513          	addi	a0,a0,-1446 # 5740 <malloc+0x9dc>
    1cee:	00003097          	auipc	ra,0x3
    1cf2:	fb8080e7          	jalr	-72(ra) # 4ca6 <printf>
    exit(1);
    1cf6:	4505                	li	a0,1
    1cf8:	00003097          	auipc	ra,0x3
    1cfc:	c10080e7          	jalr	-1008(ra) # 4908 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1d00:	862a                	mv	a2,a0
    1d02:	85a6                	mv	a1,s1
    1d04:	00004517          	auipc	a0,0x4
    1d08:	a5c50513          	addi	a0,a0,-1444 # 5760 <malloc+0x9fc>
    1d0c:	00003097          	auipc	ra,0x3
    1d10:	f9a080e7          	jalr	-102(ra) # 4ca6 <printf>
    exit(1);
    1d14:	4505                	li	a0,1
    1d16:	00003097          	auipc	ra,0x3
    1d1a:	bf2080e7          	jalr	-1038(ra) # 4908 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1d1e:	567d                	li	a2,-1
    1d20:	85a6                	mv	a1,s1
    1d22:	00004517          	auipc	a0,0x4
    1d26:	a5e50513          	addi	a0,a0,-1442 # 5780 <malloc+0xa1c>
    1d2a:	00003097          	auipc	ra,0x3
    1d2e:	f7c080e7          	jalr	-132(ra) # 4ca6 <printf>
    exit(1);
    1d32:	4505                	li	a0,1
    1d34:	00003097          	auipc	ra,0x3
    1d38:	bd4080e7          	jalr	-1068(ra) # 4908 <exit>

0000000000001d3c <sbrkbasic>:
{
    1d3c:	7139                	addi	sp,sp,-64
    1d3e:	fc06                	sd	ra,56(sp)
    1d40:	f822                	sd	s0,48(sp)
    1d42:	f426                	sd	s1,40(sp)
    1d44:	f04a                	sd	s2,32(sp)
    1d46:	ec4e                	sd	s3,24(sp)
    1d48:	e852                	sd	s4,16(sp)
    1d4a:	0080                	addi	s0,sp,64
    1d4c:	8a2a                	mv	s4,a0
  pid = fork();
    1d4e:	00003097          	auipc	ra,0x3
    1d52:	bb2080e7          	jalr	-1102(ra) # 4900 <fork>
  if(pid < 0){
    1d56:	02054c63          	bltz	a0,1d8e <sbrkbasic+0x52>
  if(pid == 0){
    1d5a:	ed21                	bnez	a0,1db2 <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    1d5c:	40000537          	lui	a0,0x40000
    1d60:	00003097          	auipc	ra,0x3
    1d64:	c18080e7          	jalr	-1000(ra) # 4978 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    1d68:	57fd                	li	a5,-1
    1d6a:	02f50f63          	beq	a0,a5,1da8 <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    1d6e:	400007b7          	lui	a5,0x40000
    1d72:	97aa                	add	a5,a5,a0
      *b = 99;
    1d74:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    1d78:	6705                	lui	a4,0x1
      *b = 99;
    1d7a:	00d50023          	sb	a3,0(a0) # 40000000 <__BSS_END__+0x3fff3fc8>
    for(b = a; b < a+TOOMUCH; b += 4096){
    1d7e:	953a                	add	a0,a0,a4
    1d80:	fef51de3          	bne	a0,a5,1d7a <sbrkbasic+0x3e>
    exit(1);
    1d84:	4505                	li	a0,1
    1d86:	00003097          	auipc	ra,0x3
    1d8a:	b82080e7          	jalr	-1150(ra) # 4908 <exit>
    printf("fork failed in sbrkbasic\n");
    1d8e:	00004517          	auipc	a0,0x4
    1d92:	e4a50513          	addi	a0,a0,-438 # 5bd8 <malloc+0xe74>
    1d96:	00003097          	auipc	ra,0x3
    1d9a:	f10080e7          	jalr	-240(ra) # 4ca6 <printf>
    exit(1);
    1d9e:	4505                	li	a0,1
    1da0:	00003097          	auipc	ra,0x3
    1da4:	b68080e7          	jalr	-1176(ra) # 4908 <exit>
      exit(0);
    1da8:	4501                	li	a0,0
    1daa:	00003097          	auipc	ra,0x3
    1dae:	b5e080e7          	jalr	-1186(ra) # 4908 <exit>
  wait(&xstatus);
    1db2:	fcc40513          	addi	a0,s0,-52
    1db6:	00003097          	auipc	ra,0x3
    1dba:	b5a080e7          	jalr	-1190(ra) # 4910 <wait>
  if(xstatus == 1){
    1dbe:	fcc42703          	lw	a4,-52(s0)
    1dc2:	4785                	li	a5,1
    1dc4:	00f70d63          	beq	a4,a5,1dde <sbrkbasic+0xa2>
  a = sbrk(0);
    1dc8:	4501                	li	a0,0
    1dca:	00003097          	auipc	ra,0x3
    1dce:	bae080e7          	jalr	-1106(ra) # 4978 <sbrk>
    1dd2:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    1dd4:	4901                	li	s2,0
    1dd6:	6985                	lui	s3,0x1
    1dd8:	38898993          	addi	s3,s3,904 # 1388 <exectest+0xc6>
    1ddc:	a005                	j	1dfc <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    1dde:	85d2                	mv	a1,s4
    1de0:	00004517          	auipc	a0,0x4
    1de4:	e1850513          	addi	a0,a0,-488 # 5bf8 <malloc+0xe94>
    1de8:	00003097          	auipc	ra,0x3
    1dec:	ebe080e7          	jalr	-322(ra) # 4ca6 <printf>
    exit(1);
    1df0:	4505                	li	a0,1
    1df2:	00003097          	auipc	ra,0x3
    1df6:	b16080e7          	jalr	-1258(ra) # 4908 <exit>
    a = b + 1;
    1dfa:	84be                	mv	s1,a5
    b = sbrk(1);
    1dfc:	4505                	li	a0,1
    1dfe:	00003097          	auipc	ra,0x3
    1e02:	b7a080e7          	jalr	-1158(ra) # 4978 <sbrk>
    if(b != a){
    1e06:	04951c63          	bne	a0,s1,1e5e <sbrkbasic+0x122>
    *b = 1;
    1e0a:	4785                	li	a5,1
    1e0c:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    1e10:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    1e14:	2905                	addiw	s2,s2,1
    1e16:	ff3912e3          	bne	s2,s3,1dfa <sbrkbasic+0xbe>
  pid = fork();
    1e1a:	00003097          	auipc	ra,0x3
    1e1e:	ae6080e7          	jalr	-1306(ra) # 4900 <fork>
    1e22:	892a                	mv	s2,a0
  if(pid < 0){
    1e24:	04054d63          	bltz	a0,1e7e <sbrkbasic+0x142>
  c = sbrk(1);
    1e28:	4505                	li	a0,1
    1e2a:	00003097          	auipc	ra,0x3
    1e2e:	b4e080e7          	jalr	-1202(ra) # 4978 <sbrk>
  c = sbrk(1);
    1e32:	4505                	li	a0,1
    1e34:	00003097          	auipc	ra,0x3
    1e38:	b44080e7          	jalr	-1212(ra) # 4978 <sbrk>
  if(c != a + 1){
    1e3c:	0489                	addi	s1,s1,2
    1e3e:	04a48e63          	beq	s1,a0,1e9a <sbrkbasic+0x15e>
    printf("%s: sbrk test failed post-fork\n", s);
    1e42:	85d2                	mv	a1,s4
    1e44:	00004517          	auipc	a0,0x4
    1e48:	e1450513          	addi	a0,a0,-492 # 5c58 <malloc+0xef4>
    1e4c:	00003097          	auipc	ra,0x3
    1e50:	e5a080e7          	jalr	-422(ra) # 4ca6 <printf>
    exit(1);
    1e54:	4505                	li	a0,1
    1e56:	00003097          	auipc	ra,0x3
    1e5a:	ab2080e7          	jalr	-1358(ra) # 4908 <exit>
      printf("%s: sbrk test failed %d %x %x\n", i, a, b);
    1e5e:	86aa                	mv	a3,a0
    1e60:	8626                	mv	a2,s1
    1e62:	85ca                	mv	a1,s2
    1e64:	00004517          	auipc	a0,0x4
    1e68:	db450513          	addi	a0,a0,-588 # 5c18 <malloc+0xeb4>
    1e6c:	00003097          	auipc	ra,0x3
    1e70:	e3a080e7          	jalr	-454(ra) # 4ca6 <printf>
      exit(1);
    1e74:	4505                	li	a0,1
    1e76:	00003097          	auipc	ra,0x3
    1e7a:	a92080e7          	jalr	-1390(ra) # 4908 <exit>
    printf("%s: sbrk test fork failed\n", s);
    1e7e:	85d2                	mv	a1,s4
    1e80:	00004517          	auipc	a0,0x4
    1e84:	db850513          	addi	a0,a0,-584 # 5c38 <malloc+0xed4>
    1e88:	00003097          	auipc	ra,0x3
    1e8c:	e1e080e7          	jalr	-482(ra) # 4ca6 <printf>
    exit(1);
    1e90:	4505                	li	a0,1
    1e92:	00003097          	auipc	ra,0x3
    1e96:	a76080e7          	jalr	-1418(ra) # 4908 <exit>
  if(pid == 0)
    1e9a:	00091763          	bnez	s2,1ea8 <sbrkbasic+0x16c>
    exit(0);
    1e9e:	4501                	li	a0,0
    1ea0:	00003097          	auipc	ra,0x3
    1ea4:	a68080e7          	jalr	-1432(ra) # 4908 <exit>
  wait(&xstatus);
    1ea8:	fcc40513          	addi	a0,s0,-52
    1eac:	00003097          	auipc	ra,0x3
    1eb0:	a64080e7          	jalr	-1436(ra) # 4910 <wait>
  exit(xstatus);
    1eb4:	fcc42503          	lw	a0,-52(s0)
    1eb8:	00003097          	auipc	ra,0x3
    1ebc:	a50080e7          	jalr	-1456(ra) # 4908 <exit>

0000000000001ec0 <sbrkmuch>:
{
    1ec0:	7179                	addi	sp,sp,-48
    1ec2:	f406                	sd	ra,40(sp)
    1ec4:	f022                	sd	s0,32(sp)
    1ec6:	ec26                	sd	s1,24(sp)
    1ec8:	e84a                	sd	s2,16(sp)
    1eca:	e44e                	sd	s3,8(sp)
    1ecc:	e052                	sd	s4,0(sp)
    1ece:	1800                	addi	s0,sp,48
    1ed0:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    1ed2:	4501                	li	a0,0
    1ed4:	00003097          	auipc	ra,0x3
    1ed8:	aa4080e7          	jalr	-1372(ra) # 4978 <sbrk>
    1edc:	892a                	mv	s2,a0
  a = sbrk(0);
    1ede:	4501                	li	a0,0
    1ee0:	00003097          	auipc	ra,0x3
    1ee4:	a98080e7          	jalr	-1384(ra) # 4978 <sbrk>
    1ee8:	84aa                	mv	s1,a0
  p = sbrk(amt);
    1eea:	00300537          	lui	a0,0x300
    1eee:	9d05                	subw	a0,a0,s1
    1ef0:	00003097          	auipc	ra,0x3
    1ef4:	a88080e7          	jalr	-1400(ra) # 4978 <sbrk>
  if (p != a) {
    1ef8:	0ca49863          	bne	s1,a0,1fc8 <sbrkmuch+0x108>
  char *eee = sbrk(0);
    1efc:	4501                	li	a0,0
    1efe:	00003097          	auipc	ra,0x3
    1f02:	a7a080e7          	jalr	-1414(ra) # 4978 <sbrk>
    1f06:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    1f08:	00a4f963          	bgeu	s1,a0,1f1a <sbrkmuch+0x5a>
    *pp = 1;
    1f0c:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    1f0e:	6705                	lui	a4,0x1
    *pp = 1;
    1f10:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    1f14:	94ba                	add	s1,s1,a4
    1f16:	fef4ede3          	bltu	s1,a5,1f10 <sbrkmuch+0x50>
  *lastaddr = 99;
    1f1a:	003007b7          	lui	a5,0x300
    1f1e:	06300713          	li	a4,99
    1f22:	fee78fa3          	sb	a4,-1(a5) # 2fffff <__BSS_END__+0x2f3fc7>
  a = sbrk(0);
    1f26:	4501                	li	a0,0
    1f28:	00003097          	auipc	ra,0x3
    1f2c:	a50080e7          	jalr	-1456(ra) # 4978 <sbrk>
    1f30:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    1f32:	757d                	lui	a0,0xfffff
    1f34:	00003097          	auipc	ra,0x3
    1f38:	a44080e7          	jalr	-1468(ra) # 4978 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    1f3c:	57fd                	li	a5,-1
    1f3e:	0af50363          	beq	a0,a5,1fe4 <sbrkmuch+0x124>
  c = sbrk(0);
    1f42:	4501                	li	a0,0
    1f44:	00003097          	auipc	ra,0x3
    1f48:	a34080e7          	jalr	-1484(ra) # 4978 <sbrk>
  if(c != a - PGSIZE){
    1f4c:	77fd                	lui	a5,0xfffff
    1f4e:	97a6                	add	a5,a5,s1
    1f50:	0af51863          	bne	a0,a5,2000 <sbrkmuch+0x140>
  a = sbrk(0);
    1f54:	4501                	li	a0,0
    1f56:	00003097          	auipc	ra,0x3
    1f5a:	a22080e7          	jalr	-1502(ra) # 4978 <sbrk>
    1f5e:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    1f60:	6505                	lui	a0,0x1
    1f62:	00003097          	auipc	ra,0x3
    1f66:	a16080e7          	jalr	-1514(ra) # 4978 <sbrk>
    1f6a:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    1f6c:	0aa49963          	bne	s1,a0,201e <sbrkmuch+0x15e>
    1f70:	4501                	li	a0,0
    1f72:	00003097          	auipc	ra,0x3
    1f76:	a06080e7          	jalr	-1530(ra) # 4978 <sbrk>
    1f7a:	6785                	lui	a5,0x1
    1f7c:	97a6                	add	a5,a5,s1
    1f7e:	0af51063          	bne	a0,a5,201e <sbrkmuch+0x15e>
  if(*lastaddr == 99){
    1f82:	003007b7          	lui	a5,0x300
    1f86:	fff7c703          	lbu	a4,-1(a5) # 2fffff <__BSS_END__+0x2f3fc7>
    1f8a:	06300793          	li	a5,99
    1f8e:	0af70763          	beq	a4,a5,203c <sbrkmuch+0x17c>
  a = sbrk(0);
    1f92:	4501                	li	a0,0
    1f94:	00003097          	auipc	ra,0x3
    1f98:	9e4080e7          	jalr	-1564(ra) # 4978 <sbrk>
    1f9c:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    1f9e:	4501                	li	a0,0
    1fa0:	00003097          	auipc	ra,0x3
    1fa4:	9d8080e7          	jalr	-1576(ra) # 4978 <sbrk>
    1fa8:	40a9053b          	subw	a0,s2,a0
    1fac:	00003097          	auipc	ra,0x3
    1fb0:	9cc080e7          	jalr	-1588(ra) # 4978 <sbrk>
  if(c != a){
    1fb4:	0aa49263          	bne	s1,a0,2058 <sbrkmuch+0x198>
}
    1fb8:	70a2                	ld	ra,40(sp)
    1fba:	7402                	ld	s0,32(sp)
    1fbc:	64e2                	ld	s1,24(sp)
    1fbe:	6942                	ld	s2,16(sp)
    1fc0:	69a2                	ld	s3,8(sp)
    1fc2:	6a02                	ld	s4,0(sp)
    1fc4:	6145                	addi	sp,sp,48
    1fc6:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    1fc8:	85ce                	mv	a1,s3
    1fca:	00004517          	auipc	a0,0x4
    1fce:	cae50513          	addi	a0,a0,-850 # 5c78 <malloc+0xf14>
    1fd2:	00003097          	auipc	ra,0x3
    1fd6:	cd4080e7          	jalr	-812(ra) # 4ca6 <printf>
    exit(1);
    1fda:	4505                	li	a0,1
    1fdc:	00003097          	auipc	ra,0x3
    1fe0:	92c080e7          	jalr	-1748(ra) # 4908 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    1fe4:	85ce                	mv	a1,s3
    1fe6:	00004517          	auipc	a0,0x4
    1fea:	cda50513          	addi	a0,a0,-806 # 5cc0 <malloc+0xf5c>
    1fee:	00003097          	auipc	ra,0x3
    1ff2:	cb8080e7          	jalr	-840(ra) # 4ca6 <printf>
    exit(1);
    1ff6:	4505                	li	a0,1
    1ff8:	00003097          	auipc	ra,0x3
    1ffc:	910080e7          	jalr	-1776(ra) # 4908 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    2000:	862a                	mv	a2,a0
    2002:	85a6                	mv	a1,s1
    2004:	00004517          	auipc	a0,0x4
    2008:	cdc50513          	addi	a0,a0,-804 # 5ce0 <malloc+0xf7c>
    200c:	00003097          	auipc	ra,0x3
    2010:	c9a080e7          	jalr	-870(ra) # 4ca6 <printf>
    exit(1);
    2014:	4505                	li	a0,1
    2016:	00003097          	auipc	ra,0x3
    201a:	8f2080e7          	jalr	-1806(ra) # 4908 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", a, c);
    201e:	8652                	mv	a2,s4
    2020:	85a6                	mv	a1,s1
    2022:	00004517          	auipc	a0,0x4
    2026:	cfe50513          	addi	a0,a0,-770 # 5d20 <malloc+0xfbc>
    202a:	00003097          	auipc	ra,0x3
    202e:	c7c080e7          	jalr	-900(ra) # 4ca6 <printf>
    exit(1);
    2032:	4505                	li	a0,1
    2034:	00003097          	auipc	ra,0x3
    2038:	8d4080e7          	jalr	-1836(ra) # 4908 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    203c:	85ce                	mv	a1,s3
    203e:	00004517          	auipc	a0,0x4
    2042:	d1250513          	addi	a0,a0,-750 # 5d50 <malloc+0xfec>
    2046:	00003097          	auipc	ra,0x3
    204a:	c60080e7          	jalr	-928(ra) # 4ca6 <printf>
    exit(1);
    204e:	4505                	li	a0,1
    2050:	00003097          	auipc	ra,0x3
    2054:	8b8080e7          	jalr	-1864(ra) # 4908 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", a, c);
    2058:	862a                	mv	a2,a0
    205a:	85a6                	mv	a1,s1
    205c:	00004517          	auipc	a0,0x4
    2060:	d2c50513          	addi	a0,a0,-724 # 5d88 <malloc+0x1024>
    2064:	00003097          	auipc	ra,0x3
    2068:	c42080e7          	jalr	-958(ra) # 4ca6 <printf>
    exit(1);
    206c:	4505                	li	a0,1
    206e:	00003097          	auipc	ra,0x3
    2072:	89a080e7          	jalr	-1894(ra) # 4908 <exit>

0000000000002076 <sbrkarg>:
{
    2076:	7179                	addi	sp,sp,-48
    2078:	f406                	sd	ra,40(sp)
    207a:	f022                	sd	s0,32(sp)
    207c:	ec26                	sd	s1,24(sp)
    207e:	e84a                	sd	s2,16(sp)
    2080:	e44e                	sd	s3,8(sp)
    2082:	1800                	addi	s0,sp,48
    2084:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2086:	6505                	lui	a0,0x1
    2088:	00003097          	auipc	ra,0x3
    208c:	8f0080e7          	jalr	-1808(ra) # 4978 <sbrk>
    2090:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2092:	20100593          	li	a1,513
    2096:	00004517          	auipc	a0,0x4
    209a:	d1a50513          	addi	a0,a0,-742 # 5db0 <malloc+0x104c>
    209e:	00003097          	auipc	ra,0x3
    20a2:	8aa080e7          	jalr	-1878(ra) # 4948 <open>
    20a6:	84aa                	mv	s1,a0
  remove("sbrk");
    20a8:	00004517          	auipc	a0,0x4
    20ac:	d0850513          	addi	a0,a0,-760 # 5db0 <malloc+0x104c>
    20b0:	00003097          	auipc	ra,0x3
    20b4:	900080e7          	jalr	-1792(ra) # 49b0 <remove>
  if(fd < 0)  {
    20b8:	0404c163          	bltz	s1,20fa <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    20bc:	6605                	lui	a2,0x1
    20be:	85ca                	mv	a1,s2
    20c0:	8526                	mv	a0,s1
    20c2:	00003097          	auipc	ra,0x3
    20c6:	866080e7          	jalr	-1946(ra) # 4928 <write>
    20ca:	04054663          	bltz	a0,2116 <sbrkarg+0xa0>
  close(fd);
    20ce:	8526                	mv	a0,s1
    20d0:	00003097          	auipc	ra,0x3
    20d4:	860080e7          	jalr	-1952(ra) # 4930 <close>
  a = sbrk(PGSIZE);
    20d8:	6505                	lui	a0,0x1
    20da:	00003097          	auipc	ra,0x3
    20de:	89e080e7          	jalr	-1890(ra) # 4978 <sbrk>
  if(pipe((int *) a) != 0){
    20e2:	00003097          	auipc	ra,0x3
    20e6:	836080e7          	jalr	-1994(ra) # 4918 <pipe>
    20ea:	e521                	bnez	a0,2132 <sbrkarg+0xbc>
}
    20ec:	70a2                	ld	ra,40(sp)
    20ee:	7402                	ld	s0,32(sp)
    20f0:	64e2                	ld	s1,24(sp)
    20f2:	6942                	ld	s2,16(sp)
    20f4:	69a2                	ld	s3,8(sp)
    20f6:	6145                	addi	sp,sp,48
    20f8:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    20fa:	85ce                	mv	a1,s3
    20fc:	00004517          	auipc	a0,0x4
    2100:	cbc50513          	addi	a0,a0,-836 # 5db8 <malloc+0x1054>
    2104:	00003097          	auipc	ra,0x3
    2108:	ba2080e7          	jalr	-1118(ra) # 4ca6 <printf>
    exit(1);
    210c:	4505                	li	a0,1
    210e:	00002097          	auipc	ra,0x2
    2112:	7fa080e7          	jalr	2042(ra) # 4908 <exit>
    printf("%s: write sbrk failed\n", s);
    2116:	85ce                	mv	a1,s3
    2118:	00004517          	auipc	a0,0x4
    211c:	cb850513          	addi	a0,a0,-840 # 5dd0 <malloc+0x106c>
    2120:	00003097          	auipc	ra,0x3
    2124:	b86080e7          	jalr	-1146(ra) # 4ca6 <printf>
    exit(1);
    2128:	4505                	li	a0,1
    212a:	00002097          	auipc	ra,0x2
    212e:	7de080e7          	jalr	2014(ra) # 4908 <exit>
    printf("%s: pipe() failed\n", s);
    2132:	85ce                	mv	a1,s3
    2134:	00003517          	auipc	a0,0x3
    2138:	7cc50513          	addi	a0,a0,1996 # 5900 <malloc+0xb9c>
    213c:	00003097          	auipc	ra,0x3
    2140:	b6a080e7          	jalr	-1174(ra) # 4ca6 <printf>
    exit(1);
    2144:	4505                	li	a0,1
    2146:	00002097          	auipc	ra,0x2
    214a:	7c2080e7          	jalr	1986(ra) # 4908 <exit>

000000000000214e <argptest>:
{
    214e:	1101                	addi	sp,sp,-32
    2150:	ec06                	sd	ra,24(sp)
    2152:	e822                	sd	s0,16(sp)
    2154:	e426                	sd	s1,8(sp)
    2156:	e04a                	sd	s2,0(sp)
    2158:	1000                	addi	s0,sp,32
    215a:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    215c:	4581                	li	a1,0
    215e:	00004517          	auipc	a0,0x4
    2162:	c8a50513          	addi	a0,a0,-886 # 5de8 <malloc+0x1084>
    2166:	00002097          	auipc	ra,0x2
    216a:	7e2080e7          	jalr	2018(ra) # 4948 <open>
  if (fd < 0) {
    216e:	02054b63          	bltz	a0,21a4 <argptest+0x56>
    2172:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2174:	4501                	li	a0,0
    2176:	00003097          	auipc	ra,0x3
    217a:	802080e7          	jalr	-2046(ra) # 4978 <sbrk>
    217e:	567d                	li	a2,-1
    2180:	fff50593          	addi	a1,a0,-1
    2184:	8526                	mv	a0,s1
    2186:	00002097          	auipc	ra,0x2
    218a:	79a080e7          	jalr	1946(ra) # 4920 <read>
  close(fd);
    218e:	8526                	mv	a0,s1
    2190:	00002097          	auipc	ra,0x2
    2194:	7a0080e7          	jalr	1952(ra) # 4930 <close>
}
    2198:	60e2                	ld	ra,24(sp)
    219a:	6442                	ld	s0,16(sp)
    219c:	64a2                	ld	s1,8(sp)
    219e:	6902                	ld	s2,0(sp)
    21a0:	6105                	addi	sp,sp,32
    21a2:	8082                	ret
    printf("%s: open failed\n", s);
    21a4:	85ca                	mv	a1,s2
    21a6:	00003517          	auipc	a0,0x3
    21aa:	66a50513          	addi	a0,a0,1642 # 5810 <malloc+0xaac>
    21ae:	00003097          	auipc	ra,0x3
    21b2:	af8080e7          	jalr	-1288(ra) # 4ca6 <printf>
    exit(1);
    21b6:	4505                	li	a0,1
    21b8:	00002097          	auipc	ra,0x2
    21bc:	750080e7          	jalr	1872(ra) # 4908 <exit>

00000000000021c0 <sbrkbugs>:
{
    21c0:	1141                	addi	sp,sp,-16
    21c2:	e406                	sd	ra,8(sp)
    21c4:	e022                	sd	s0,0(sp)
    21c6:	0800                	addi	s0,sp,16
  int pid = fork();
    21c8:	00002097          	auipc	ra,0x2
    21cc:	738080e7          	jalr	1848(ra) # 4900 <fork>
  if(pid < 0){
    21d0:	02054263          	bltz	a0,21f4 <sbrkbugs+0x34>
  if(pid == 0){
    21d4:	ed0d                	bnez	a0,220e <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    21d6:	00002097          	auipc	ra,0x2
    21da:	7a2080e7          	jalr	1954(ra) # 4978 <sbrk>
    sbrk(-sz);
    21de:	40a0053b          	negw	a0,a0
    21e2:	00002097          	auipc	ra,0x2
    21e6:	796080e7          	jalr	1942(ra) # 4978 <sbrk>
    exit(0);
    21ea:	4501                	li	a0,0
    21ec:	00002097          	auipc	ra,0x2
    21f0:	71c080e7          	jalr	1820(ra) # 4908 <exit>
    printf("fork failed\n");
    21f4:	00004517          	auipc	a0,0x4
    21f8:	98450513          	addi	a0,a0,-1660 # 5b78 <malloc+0xe14>
    21fc:	00003097          	auipc	ra,0x3
    2200:	aaa080e7          	jalr	-1366(ra) # 4ca6 <printf>
    exit(1);
    2204:	4505                	li	a0,1
    2206:	00002097          	auipc	ra,0x2
    220a:	702080e7          	jalr	1794(ra) # 4908 <exit>
  wait(0);
    220e:	4501                	li	a0,0
    2210:	00002097          	auipc	ra,0x2
    2214:	700080e7          	jalr	1792(ra) # 4910 <wait>
  pid = fork();
    2218:	00002097          	auipc	ra,0x2
    221c:	6e8080e7          	jalr	1768(ra) # 4900 <fork>
  if(pid < 0){
    2220:	02054563          	bltz	a0,224a <sbrkbugs+0x8a>
  if(pid == 0){
    2224:	e121                	bnez	a0,2264 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2226:	00002097          	auipc	ra,0x2
    222a:	752080e7          	jalr	1874(ra) # 4978 <sbrk>
    sbrk(-(sz - 3500));
    222e:	6785                	lui	a5,0x1
    2230:	dac7879b          	addiw	a5,a5,-596
    2234:	40a7853b          	subw	a0,a5,a0
    2238:	00002097          	auipc	ra,0x2
    223c:	740080e7          	jalr	1856(ra) # 4978 <sbrk>
    exit(0);
    2240:	4501                	li	a0,0
    2242:	00002097          	auipc	ra,0x2
    2246:	6c6080e7          	jalr	1734(ra) # 4908 <exit>
    printf("fork failed\n");
    224a:	00004517          	auipc	a0,0x4
    224e:	92e50513          	addi	a0,a0,-1746 # 5b78 <malloc+0xe14>
    2252:	00003097          	auipc	ra,0x3
    2256:	a54080e7          	jalr	-1452(ra) # 4ca6 <printf>
    exit(1);
    225a:	4505                	li	a0,1
    225c:	00002097          	auipc	ra,0x2
    2260:	6ac080e7          	jalr	1708(ra) # 4908 <exit>
  wait(0);
    2264:	4501                	li	a0,0
    2266:	00002097          	auipc	ra,0x2
    226a:	6aa080e7          	jalr	1706(ra) # 4910 <wait>
  pid = fork();
    226e:	00002097          	auipc	ra,0x2
    2272:	692080e7          	jalr	1682(ra) # 4900 <fork>
  if(pid < 0){
    2276:	02054a63          	bltz	a0,22aa <sbrkbugs+0xea>
  if(pid == 0){
    227a:	e529                	bnez	a0,22c4 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    227c:	00002097          	auipc	ra,0x2
    2280:	6fc080e7          	jalr	1788(ra) # 4978 <sbrk>
    2284:	67ad                	lui	a5,0xb
    2286:	8007879b          	addiw	a5,a5,-2048
    228a:	40a7853b          	subw	a0,a5,a0
    228e:	00002097          	auipc	ra,0x2
    2292:	6ea080e7          	jalr	1770(ra) # 4978 <sbrk>
    sbrk(-10);
    2296:	5559                	li	a0,-10
    2298:	00002097          	auipc	ra,0x2
    229c:	6e0080e7          	jalr	1760(ra) # 4978 <sbrk>
    exit(0);
    22a0:	4501                	li	a0,0
    22a2:	00002097          	auipc	ra,0x2
    22a6:	666080e7          	jalr	1638(ra) # 4908 <exit>
    printf("fork failed\n");
    22aa:	00004517          	auipc	a0,0x4
    22ae:	8ce50513          	addi	a0,a0,-1842 # 5b78 <malloc+0xe14>
    22b2:	00003097          	auipc	ra,0x3
    22b6:	9f4080e7          	jalr	-1548(ra) # 4ca6 <printf>
    exit(1);
    22ba:	4505                	li	a0,1
    22bc:	00002097          	auipc	ra,0x2
    22c0:	64c080e7          	jalr	1612(ra) # 4908 <exit>
  wait(0);
    22c4:	4501                	li	a0,0
    22c6:	00002097          	auipc	ra,0x2
    22ca:	64a080e7          	jalr	1610(ra) # 4910 <wait>
  exit(0);
    22ce:	4501                	li	a0,0
    22d0:	00002097          	auipc	ra,0x2
    22d4:	638080e7          	jalr	1592(ra) # 4908 <exit>

00000000000022d8 <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    22d8:	715d                	addi	sp,sp,-80
    22da:	e486                	sd	ra,72(sp)
    22dc:	e0a2                	sd	s0,64(sp)
    22de:	fc26                	sd	s1,56(sp)
    22e0:	f84a                	sd	s2,48(sp)
    22e2:	f44e                	sd	s3,40(sp)
    22e4:	f052                	sd	s4,32(sp)
    22e6:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    22e8:	4901                	li	s2,0
    22ea:	49bd                	li	s3,15
    int pid = fork();
    22ec:	00002097          	auipc	ra,0x2
    22f0:	614080e7          	jalr	1556(ra) # 4900 <fork>
    22f4:	84aa                	mv	s1,a0
    if(pid < 0){
    22f6:	02054063          	bltz	a0,2316 <execout+0x3e>
      printf("fork failed\n");
      exit(1);
    } else if(pid == 0){
    22fa:	c91d                	beqz	a0,2330 <execout+0x58>
      close(1);
      char *args[] = { "echo", "x", 0 };
      exec("echo", args);
      exit(0);
    } else {
      wait((int*)0);
    22fc:	4501                	li	a0,0
    22fe:	00002097          	auipc	ra,0x2
    2302:	612080e7          	jalr	1554(ra) # 4910 <wait>
  for(int avail = 0; avail < 15; avail++){
    2306:	2905                	addiw	s2,s2,1
    2308:	ff3912e3          	bne	s2,s3,22ec <execout+0x14>
    }
  }

  exit(0);
    230c:	4501                	li	a0,0
    230e:	00002097          	auipc	ra,0x2
    2312:	5fa080e7          	jalr	1530(ra) # 4908 <exit>
      printf("fork failed\n");
    2316:	00004517          	auipc	a0,0x4
    231a:	86250513          	addi	a0,a0,-1950 # 5b78 <malloc+0xe14>
    231e:	00003097          	auipc	ra,0x3
    2322:	988080e7          	jalr	-1656(ra) # 4ca6 <printf>
      exit(1);
    2326:	4505                	li	a0,1
    2328:	00002097          	auipc	ra,0x2
    232c:	5e0080e7          	jalr	1504(ra) # 4908 <exit>
        if(a == 0xffffffffffffffffLL)
    2330:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2332:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2334:	6505                	lui	a0,0x1
    2336:	00002097          	auipc	ra,0x2
    233a:	642080e7          	jalr	1602(ra) # 4978 <sbrk>
        if(a == 0xffffffffffffffffLL)
    233e:	01350763          	beq	a0,s3,234c <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2342:	6785                	lui	a5,0x1
    2344:	953e                	add	a0,a0,a5
    2346:	ff450fa3          	sb	s4,-1(a0) # fff <copyinstr2+0xbb>
      while(1){
    234a:	b7ed                	j	2334 <execout+0x5c>
      for(int i = 0; i < avail; i++)
    234c:	01205a63          	blez	s2,2360 <execout+0x88>
        sbrk(-4096);
    2350:	757d                	lui	a0,0xfffff
    2352:	00002097          	auipc	ra,0x2
    2356:	626080e7          	jalr	1574(ra) # 4978 <sbrk>
      for(int i = 0; i < avail; i++)
    235a:	2485                	addiw	s1,s1,1
    235c:	ff249ae3          	bne	s1,s2,2350 <execout+0x78>
      close(1);
    2360:	4505                	li	a0,1
    2362:	00002097          	auipc	ra,0x2
    2366:	5ce080e7          	jalr	1486(ra) # 4930 <close>
      char *args[] = { "echo", "x", 0 };
    236a:	00003517          	auipc	a0,0x3
    236e:	e1e50513          	addi	a0,a0,-482 # 5188 <malloc+0x424>
    2372:	faa43c23          	sd	a0,-72(s0)
    2376:	00003797          	auipc	a5,0x3
    237a:	e8278793          	addi	a5,a5,-382 # 51f8 <malloc+0x494>
    237e:	fcf43023          	sd	a5,-64(s0)
    2382:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    2386:	fb840593          	addi	a1,s0,-72
    238a:	00002097          	auipc	ra,0x2
    238e:	5b6080e7          	jalr	1462(ra) # 4940 <exec>
      exit(0);
    2392:	4501                	li	a0,0
    2394:	00002097          	auipc	ra,0x2
    2398:	574080e7          	jalr	1396(ra) # 4908 <exit>

000000000000239c <iputtest>:
{
    239c:	1101                	addi	sp,sp,-32
    239e:	ec06                	sd	ra,24(sp)
    23a0:	e822                	sd	s0,16(sp)
    23a2:	e426                	sd	s1,8(sp)
    23a4:	1000                	addi	s0,sp,32
    23a6:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    23a8:	00004517          	auipc	a0,0x4
    23ac:	a4850513          	addi	a0,a0,-1464 # 5df0 <malloc+0x108c>
    23b0:	00002097          	auipc	ra,0x2
    23b4:	5a8080e7          	jalr	1448(ra) # 4958 <mkdir>
    23b8:	04054563          	bltz	a0,2402 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    23bc:	00004517          	auipc	a0,0x4
    23c0:	a3450513          	addi	a0,a0,-1484 # 5df0 <malloc+0x108c>
    23c4:	00002097          	auipc	ra,0x2
    23c8:	59c080e7          	jalr	1436(ra) # 4960 <chdir>
    23cc:	04054963          	bltz	a0,241e <iputtest+0x82>
  if(remove("../iputdir") < 0){
    23d0:	00004517          	auipc	a0,0x4
    23d4:	a6050513          	addi	a0,a0,-1440 # 5e30 <malloc+0x10cc>
    23d8:	00002097          	auipc	ra,0x2
    23dc:	5d8080e7          	jalr	1496(ra) # 49b0 <remove>
    23e0:	04054d63          	bltz	a0,243a <iputtest+0x9e>
  if(chdir("/") < 0){
    23e4:	00004517          	auipc	a0,0x4
    23e8:	a7c50513          	addi	a0,a0,-1412 # 5e60 <malloc+0x10fc>
    23ec:	00002097          	auipc	ra,0x2
    23f0:	574080e7          	jalr	1396(ra) # 4960 <chdir>
    23f4:	06054163          	bltz	a0,2456 <iputtest+0xba>
}
    23f8:	60e2                	ld	ra,24(sp)
    23fa:	6442                	ld	s0,16(sp)
    23fc:	64a2                	ld	s1,8(sp)
    23fe:	6105                	addi	sp,sp,32
    2400:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2402:	85a6                	mv	a1,s1
    2404:	00004517          	auipc	a0,0x4
    2408:	9f450513          	addi	a0,a0,-1548 # 5df8 <malloc+0x1094>
    240c:	00003097          	auipc	ra,0x3
    2410:	89a080e7          	jalr	-1894(ra) # 4ca6 <printf>
    exit(1);
    2414:	4505                	li	a0,1
    2416:	00002097          	auipc	ra,0x2
    241a:	4f2080e7          	jalr	1266(ra) # 4908 <exit>
    printf("%s: chdir iputdir failed\n", s);
    241e:	85a6                	mv	a1,s1
    2420:	00004517          	auipc	a0,0x4
    2424:	9f050513          	addi	a0,a0,-1552 # 5e10 <malloc+0x10ac>
    2428:	00003097          	auipc	ra,0x3
    242c:	87e080e7          	jalr	-1922(ra) # 4ca6 <printf>
    exit(1);
    2430:	4505                	li	a0,1
    2432:	00002097          	auipc	ra,0x2
    2436:	4d6080e7          	jalr	1238(ra) # 4908 <exit>
    printf("%s: remove ../iputdir failed\n", s);
    243a:	85a6                	mv	a1,s1
    243c:	00004517          	auipc	a0,0x4
    2440:	a0450513          	addi	a0,a0,-1532 # 5e40 <malloc+0x10dc>
    2444:	00003097          	auipc	ra,0x3
    2448:	862080e7          	jalr	-1950(ra) # 4ca6 <printf>
    exit(1);
    244c:	4505                	li	a0,1
    244e:	00002097          	auipc	ra,0x2
    2452:	4ba080e7          	jalr	1210(ra) # 4908 <exit>
    printf("%s: chdir / failed\n", s);
    2456:	85a6                	mv	a1,s1
    2458:	00004517          	auipc	a0,0x4
    245c:	a1050513          	addi	a0,a0,-1520 # 5e68 <malloc+0x1104>
    2460:	00003097          	auipc	ra,0x3
    2464:	846080e7          	jalr	-1978(ra) # 4ca6 <printf>
    exit(1);
    2468:	4505                	li	a0,1
    246a:	00002097          	auipc	ra,0x2
    246e:	49e080e7          	jalr	1182(ra) # 4908 <exit>

0000000000002472 <exitiputtest>:
{
    2472:	7179                	addi	sp,sp,-48
    2474:	f406                	sd	ra,40(sp)
    2476:	f022                	sd	s0,32(sp)
    2478:	ec26                	sd	s1,24(sp)
    247a:	1800                	addi	s0,sp,48
    247c:	84aa                	mv	s1,a0
  pid = fork();
    247e:	00002097          	auipc	ra,0x2
    2482:	482080e7          	jalr	1154(ra) # 4900 <fork>
  if(pid < 0){
    2486:	04054663          	bltz	a0,24d2 <exitiputtest+0x60>
  if(pid == 0){
    248a:	ed45                	bnez	a0,2542 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    248c:	00004517          	auipc	a0,0x4
    2490:	96450513          	addi	a0,a0,-1692 # 5df0 <malloc+0x108c>
    2494:	00002097          	auipc	ra,0x2
    2498:	4c4080e7          	jalr	1220(ra) # 4958 <mkdir>
    249c:	04054963          	bltz	a0,24ee <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    24a0:	00004517          	auipc	a0,0x4
    24a4:	95050513          	addi	a0,a0,-1712 # 5df0 <malloc+0x108c>
    24a8:	00002097          	auipc	ra,0x2
    24ac:	4b8080e7          	jalr	1208(ra) # 4960 <chdir>
    24b0:	04054d63          	bltz	a0,250a <exitiputtest+0x98>
    if(remove("../iputdir") < 0){
    24b4:	00004517          	auipc	a0,0x4
    24b8:	97c50513          	addi	a0,a0,-1668 # 5e30 <malloc+0x10cc>
    24bc:	00002097          	auipc	ra,0x2
    24c0:	4f4080e7          	jalr	1268(ra) # 49b0 <remove>
    24c4:	06054163          	bltz	a0,2526 <exitiputtest+0xb4>
    exit(0);
    24c8:	4501                	li	a0,0
    24ca:	00002097          	auipc	ra,0x2
    24ce:	43e080e7          	jalr	1086(ra) # 4908 <exit>
    printf("%s: fork failed\n", s);
    24d2:	85a6                	mv	a1,s1
    24d4:	00003517          	auipc	a0,0x3
    24d8:	32450513          	addi	a0,a0,804 # 57f8 <malloc+0xa94>
    24dc:	00002097          	auipc	ra,0x2
    24e0:	7ca080e7          	jalr	1994(ra) # 4ca6 <printf>
    exit(1);
    24e4:	4505                	li	a0,1
    24e6:	00002097          	auipc	ra,0x2
    24ea:	422080e7          	jalr	1058(ra) # 4908 <exit>
      printf("%s: mkdir failed\n", s);
    24ee:	85a6                	mv	a1,s1
    24f0:	00004517          	auipc	a0,0x4
    24f4:	90850513          	addi	a0,a0,-1784 # 5df8 <malloc+0x1094>
    24f8:	00002097          	auipc	ra,0x2
    24fc:	7ae080e7          	jalr	1966(ra) # 4ca6 <printf>
      exit(1);
    2500:	4505                	li	a0,1
    2502:	00002097          	auipc	ra,0x2
    2506:	406080e7          	jalr	1030(ra) # 4908 <exit>
      printf("%s: child chdir failed\n", s);
    250a:	85a6                	mv	a1,s1
    250c:	00004517          	auipc	a0,0x4
    2510:	97450513          	addi	a0,a0,-1676 # 5e80 <malloc+0x111c>
    2514:	00002097          	auipc	ra,0x2
    2518:	792080e7          	jalr	1938(ra) # 4ca6 <printf>
      exit(1);
    251c:	4505                	li	a0,1
    251e:	00002097          	auipc	ra,0x2
    2522:	3ea080e7          	jalr	1002(ra) # 4908 <exit>
      printf("%s: remove ../iputdir failed\n", s);
    2526:	85a6                	mv	a1,s1
    2528:	00004517          	auipc	a0,0x4
    252c:	91850513          	addi	a0,a0,-1768 # 5e40 <malloc+0x10dc>
    2530:	00002097          	auipc	ra,0x2
    2534:	776080e7          	jalr	1910(ra) # 4ca6 <printf>
      exit(1);
    2538:	4505                	li	a0,1
    253a:	00002097          	auipc	ra,0x2
    253e:	3ce080e7          	jalr	974(ra) # 4908 <exit>
  wait(&xstatus);
    2542:	fdc40513          	addi	a0,s0,-36
    2546:	00002097          	auipc	ra,0x2
    254a:	3ca080e7          	jalr	970(ra) # 4910 <wait>
  exit(xstatus);
    254e:	fdc42503          	lw	a0,-36(s0)
    2552:	00002097          	auipc	ra,0x2
    2556:	3b6080e7          	jalr	950(ra) # 4908 <exit>

000000000000255a <subdir>:
{
    255a:	1101                	addi	sp,sp,-32
    255c:	ec06                	sd	ra,24(sp)
    255e:	e822                	sd	s0,16(sp)
    2560:	e426                	sd	s1,8(sp)
    2562:	e04a                	sd	s2,0(sp)
    2564:	1000                	addi	s0,sp,32
    2566:	892a                	mv	s2,a0
  remove("ff");
    2568:	00004517          	auipc	a0,0x4
    256c:	93050513          	addi	a0,a0,-1744 # 5e98 <malloc+0x1134>
    2570:	00002097          	auipc	ra,0x2
    2574:	440080e7          	jalr	1088(ra) # 49b0 <remove>
  if(mkdir("dd") != 0){
    2578:	00004517          	auipc	a0,0x4
    257c:	92850513          	addi	a0,a0,-1752 # 5ea0 <malloc+0x113c>
    2580:	00002097          	auipc	ra,0x2
    2584:	3d8080e7          	jalr	984(ra) # 4958 <mkdir>
    2588:	24051363          	bnez	a0,27ce <subdir+0x274>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    258c:	20200593          	li	a1,514
    2590:	00004517          	auipc	a0,0x4
    2594:	93050513          	addi	a0,a0,-1744 # 5ec0 <malloc+0x115c>
    2598:	00002097          	auipc	ra,0x2
    259c:	3b0080e7          	jalr	944(ra) # 4948 <open>
    25a0:	84aa                	mv	s1,a0
  if(fd < 0){
    25a2:	24054463          	bltz	a0,27ea <subdir+0x290>
  write(fd, "ff", 2);
    25a6:	4609                	li	a2,2
    25a8:	00004597          	auipc	a1,0x4
    25ac:	8f058593          	addi	a1,a1,-1808 # 5e98 <malloc+0x1134>
    25b0:	00002097          	auipc	ra,0x2
    25b4:	378080e7          	jalr	888(ra) # 4928 <write>
  close(fd);
    25b8:	8526                	mv	a0,s1
    25ba:	00002097          	auipc	ra,0x2
    25be:	376080e7          	jalr	886(ra) # 4930 <close>
  if(remove("dd") >= 0){
    25c2:	00004517          	auipc	a0,0x4
    25c6:	8de50513          	addi	a0,a0,-1826 # 5ea0 <malloc+0x113c>
    25ca:	00002097          	auipc	ra,0x2
    25ce:	3e6080e7          	jalr	998(ra) # 49b0 <remove>
    25d2:	22055a63          	bgez	a0,2806 <subdir+0x2ac>
  if(mkdir("/dd/dd") != 0){
    25d6:	00004517          	auipc	a0,0x4
    25da:	94250513          	addi	a0,a0,-1726 # 5f18 <malloc+0x11b4>
    25de:	00002097          	auipc	ra,0x2
    25e2:	37a080e7          	jalr	890(ra) # 4958 <mkdir>
    25e6:	22051e63          	bnez	a0,2822 <subdir+0x2c8>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    25ea:	20200593          	li	a1,514
    25ee:	00004517          	auipc	a0,0x4
    25f2:	95250513          	addi	a0,a0,-1710 # 5f40 <malloc+0x11dc>
    25f6:	00002097          	auipc	ra,0x2
    25fa:	352080e7          	jalr	850(ra) # 4948 <open>
    25fe:	84aa                	mv	s1,a0
  if(fd < 0){
    2600:	22054f63          	bltz	a0,283e <subdir+0x2e4>
  write(fd, "FF", 2);
    2604:	4609                	li	a2,2
    2606:	00004597          	auipc	a1,0x4
    260a:	96a58593          	addi	a1,a1,-1686 # 5f70 <malloc+0x120c>
    260e:	00002097          	auipc	ra,0x2
    2612:	31a080e7          	jalr	794(ra) # 4928 <write>
  close(fd);
    2616:	8526                	mv	a0,s1
    2618:	00002097          	auipc	ra,0x2
    261c:	318080e7          	jalr	792(ra) # 4930 <close>
  fd = open("dd/dd/../ff", 0);
    2620:	4581                	li	a1,0
    2622:	00004517          	auipc	a0,0x4
    2626:	95650513          	addi	a0,a0,-1706 # 5f78 <malloc+0x1214>
    262a:	00002097          	auipc	ra,0x2
    262e:	31e080e7          	jalr	798(ra) # 4948 <open>
    2632:	84aa                	mv	s1,a0
  if(fd < 0){
    2634:	22054363          	bltz	a0,285a <subdir+0x300>
  cc = read(fd, buf, sizeof(buf));
    2638:	6609                	lui	a2,0x2
    263a:	80060613          	addi	a2,a2,-2048 # 1800 <forkfork+0x3e>
    263e:	00008597          	auipc	a1,0x8
    2642:	1e258593          	addi	a1,a1,482 # a820 <buf>
    2646:	00002097          	auipc	ra,0x2
    264a:	2da080e7          	jalr	730(ra) # 4920 <read>
  if(cc != 2 || buf[0] != 'f'){
    264e:	4789                	li	a5,2
    2650:	22f51363          	bne	a0,a5,2876 <subdir+0x31c>
    2654:	00008717          	auipc	a4,0x8
    2658:	1cc74703          	lbu	a4,460(a4) # a820 <buf>
    265c:	06600793          	li	a5,102
    2660:	20f71b63          	bne	a4,a5,2876 <subdir+0x31c>
  close(fd);
    2664:	8526                	mv	a0,s1
    2666:	00002097          	auipc	ra,0x2
    266a:	2ca080e7          	jalr	714(ra) # 4930 <close>
  if(remove("dd/dd/ff") != 0){
    266e:	00004517          	auipc	a0,0x4
    2672:	8d250513          	addi	a0,a0,-1838 # 5f40 <malloc+0x11dc>
    2676:	00002097          	auipc	ra,0x2
    267a:	33a080e7          	jalr	826(ra) # 49b0 <remove>
    267e:	20051a63          	bnez	a0,2892 <subdir+0x338>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2682:	4581                	li	a1,0
    2684:	00004517          	auipc	a0,0x4
    2688:	8bc50513          	addi	a0,a0,-1860 # 5f40 <malloc+0x11dc>
    268c:	00002097          	auipc	ra,0x2
    2690:	2bc080e7          	jalr	700(ra) # 4948 <open>
    2694:	20055d63          	bgez	a0,28ae <subdir+0x354>
  if(chdir("dd") != 0){
    2698:	00004517          	auipc	a0,0x4
    269c:	80850513          	addi	a0,a0,-2040 # 5ea0 <malloc+0x113c>
    26a0:	00002097          	auipc	ra,0x2
    26a4:	2c0080e7          	jalr	704(ra) # 4960 <chdir>
    26a8:	22051163          	bnez	a0,28ca <subdir+0x370>
  if(chdir("dd/../../dd") != 0){
    26ac:	00004517          	auipc	a0,0x4
    26b0:	97c50513          	addi	a0,a0,-1668 # 6028 <malloc+0x12c4>
    26b4:	00002097          	auipc	ra,0x2
    26b8:	2ac080e7          	jalr	684(ra) # 4960 <chdir>
    26bc:	22051563          	bnez	a0,28e6 <subdir+0x38c>
  if(chdir("dd/../../../dd") != 0){
    26c0:	00004517          	auipc	a0,0x4
    26c4:	99850513          	addi	a0,a0,-1640 # 6058 <malloc+0x12f4>
    26c8:	00002097          	auipc	ra,0x2
    26cc:	298080e7          	jalr	664(ra) # 4960 <chdir>
    26d0:	22051963          	bnez	a0,2902 <subdir+0x3a8>
  if(chdir("./..") != 0){
    26d4:	00004517          	auipc	a0,0x4
    26d8:	9b450513          	addi	a0,a0,-1612 # 6088 <malloc+0x1324>
    26dc:	00002097          	auipc	ra,0x2
    26e0:	284080e7          	jalr	644(ra) # 4960 <chdir>
    26e4:	22051d63          	bnez	a0,291e <subdir+0x3c4>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    26e8:	4581                	li	a1,0
    26ea:	00004517          	auipc	a0,0x4
    26ee:	85650513          	addi	a0,a0,-1962 # 5f40 <malloc+0x11dc>
    26f2:	00002097          	auipc	ra,0x2
    26f6:	256080e7          	jalr	598(ra) # 4948 <open>
    26fa:	24055063          	bgez	a0,293a <subdir+0x3e0>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    26fe:	20200593          	li	a1,514
    2702:	00004517          	auipc	a0,0x4
    2706:	9d650513          	addi	a0,a0,-1578 # 60d8 <malloc+0x1374>
    270a:	00002097          	auipc	ra,0x2
    270e:	23e080e7          	jalr	574(ra) # 4948 <open>
    2712:	24055263          	bgez	a0,2956 <subdir+0x3fc>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2716:	20200593          	li	a1,514
    271a:	00004517          	auipc	a0,0x4
    271e:	9ee50513          	addi	a0,a0,-1554 # 6108 <malloc+0x13a4>
    2722:	00002097          	auipc	ra,0x2
    2726:	226080e7          	jalr	550(ra) # 4948 <open>
    272a:	24055463          	bgez	a0,2972 <subdir+0x418>
  if(open("dd", O_CREATE) >= 0){
    272e:	20000593          	li	a1,512
    2732:	00003517          	auipc	a0,0x3
    2736:	76e50513          	addi	a0,a0,1902 # 5ea0 <malloc+0x113c>
    273a:	00002097          	auipc	ra,0x2
    273e:	20e080e7          	jalr	526(ra) # 4948 <open>
    2742:	24055663          	bgez	a0,298e <subdir+0x434>
  if(open("dd", O_RDWR) >= 0){
    2746:	4589                	li	a1,2
    2748:	00003517          	auipc	a0,0x3
    274c:	75850513          	addi	a0,a0,1880 # 5ea0 <malloc+0x113c>
    2750:	00002097          	auipc	ra,0x2
    2754:	1f8080e7          	jalr	504(ra) # 4948 <open>
    2758:	24055963          	bgez	a0,29aa <subdir+0x450>
  if(open("dd", O_WRONLY) >= 0){
    275c:	4585                	li	a1,1
    275e:	00003517          	auipc	a0,0x3
    2762:	74250513          	addi	a0,a0,1858 # 5ea0 <malloc+0x113c>
    2766:	00002097          	auipc	ra,0x2
    276a:	1e2080e7          	jalr	482(ra) # 4948 <open>
    276e:	24055c63          	bgez	a0,29c6 <subdir+0x46c>
  if(remove("dd/ff") != 0){
    2772:	00003517          	auipc	a0,0x3
    2776:	74e50513          	addi	a0,a0,1870 # 5ec0 <malloc+0x115c>
    277a:	00002097          	auipc	ra,0x2
    277e:	236080e7          	jalr	566(ra) # 49b0 <remove>
    2782:	26051063          	bnez	a0,29e2 <subdir+0x488>
  if(remove("dd") == 0){
    2786:	00003517          	auipc	a0,0x3
    278a:	71a50513          	addi	a0,a0,1818 # 5ea0 <malloc+0x113c>
    278e:	00002097          	auipc	ra,0x2
    2792:	222080e7          	jalr	546(ra) # 49b0 <remove>
    2796:	26050463          	beqz	a0,29fe <subdir+0x4a4>
  if(remove("dd/dd") < 0){
    279a:	00004517          	auipc	a0,0x4
    279e:	a4650513          	addi	a0,a0,-1466 # 61e0 <malloc+0x147c>
    27a2:	00002097          	auipc	ra,0x2
    27a6:	20e080e7          	jalr	526(ra) # 49b0 <remove>
    27aa:	26054863          	bltz	a0,2a1a <subdir+0x4c0>
  if(remove("dd") < 0){
    27ae:	00003517          	auipc	a0,0x3
    27b2:	6f250513          	addi	a0,a0,1778 # 5ea0 <malloc+0x113c>
    27b6:	00002097          	auipc	ra,0x2
    27ba:	1fa080e7          	jalr	506(ra) # 49b0 <remove>
    27be:	26054c63          	bltz	a0,2a36 <subdir+0x4dc>
}
    27c2:	60e2                	ld	ra,24(sp)
    27c4:	6442                	ld	s0,16(sp)
    27c6:	64a2                	ld	s1,8(sp)
    27c8:	6902                	ld	s2,0(sp)
    27ca:	6105                	addi	sp,sp,32
    27cc:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    27ce:	85ca                	mv	a1,s2
    27d0:	00003517          	auipc	a0,0x3
    27d4:	6d850513          	addi	a0,a0,1752 # 5ea8 <malloc+0x1144>
    27d8:	00002097          	auipc	ra,0x2
    27dc:	4ce080e7          	jalr	1230(ra) # 4ca6 <printf>
    exit(1);
    27e0:	4505                	li	a0,1
    27e2:	00002097          	auipc	ra,0x2
    27e6:	126080e7          	jalr	294(ra) # 4908 <exit>
    printf("%s: create dd/ff failed\n", s);
    27ea:	85ca                	mv	a1,s2
    27ec:	00003517          	auipc	a0,0x3
    27f0:	6dc50513          	addi	a0,a0,1756 # 5ec8 <malloc+0x1164>
    27f4:	00002097          	auipc	ra,0x2
    27f8:	4b2080e7          	jalr	1202(ra) # 4ca6 <printf>
    exit(1);
    27fc:	4505                	li	a0,1
    27fe:	00002097          	auipc	ra,0x2
    2802:	10a080e7          	jalr	266(ra) # 4908 <exit>
    printf("%s: remove dd (non-empty dir) succeeded!\n", s);
    2806:	85ca                	mv	a1,s2
    2808:	00003517          	auipc	a0,0x3
    280c:	6e050513          	addi	a0,a0,1760 # 5ee8 <malloc+0x1184>
    2810:	00002097          	auipc	ra,0x2
    2814:	496080e7          	jalr	1174(ra) # 4ca6 <printf>
    exit(1);
    2818:	4505                	li	a0,1
    281a:	00002097          	auipc	ra,0x2
    281e:	0ee080e7          	jalr	238(ra) # 4908 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    2822:	85ca                	mv	a1,s2
    2824:	00003517          	auipc	a0,0x3
    2828:	6fc50513          	addi	a0,a0,1788 # 5f20 <malloc+0x11bc>
    282c:	00002097          	auipc	ra,0x2
    2830:	47a080e7          	jalr	1146(ra) # 4ca6 <printf>
    exit(1);
    2834:	4505                	li	a0,1
    2836:	00002097          	auipc	ra,0x2
    283a:	0d2080e7          	jalr	210(ra) # 4908 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    283e:	85ca                	mv	a1,s2
    2840:	00003517          	auipc	a0,0x3
    2844:	71050513          	addi	a0,a0,1808 # 5f50 <malloc+0x11ec>
    2848:	00002097          	auipc	ra,0x2
    284c:	45e080e7          	jalr	1118(ra) # 4ca6 <printf>
    exit(1);
    2850:	4505                	li	a0,1
    2852:	00002097          	auipc	ra,0x2
    2856:	0b6080e7          	jalr	182(ra) # 4908 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    285a:	85ca                	mv	a1,s2
    285c:	00003517          	auipc	a0,0x3
    2860:	72c50513          	addi	a0,a0,1836 # 5f88 <malloc+0x1224>
    2864:	00002097          	auipc	ra,0x2
    2868:	442080e7          	jalr	1090(ra) # 4ca6 <printf>
    exit(1);
    286c:	4505                	li	a0,1
    286e:	00002097          	auipc	ra,0x2
    2872:	09a080e7          	jalr	154(ra) # 4908 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2876:	85ca                	mv	a1,s2
    2878:	00003517          	auipc	a0,0x3
    287c:	73050513          	addi	a0,a0,1840 # 5fa8 <malloc+0x1244>
    2880:	00002097          	auipc	ra,0x2
    2884:	426080e7          	jalr	1062(ra) # 4ca6 <printf>
    exit(1);
    2888:	4505                	li	a0,1
    288a:	00002097          	auipc	ra,0x2
    288e:	07e080e7          	jalr	126(ra) # 4908 <exit>
    printf("%s: remove dd/dd/ff failed\n", s);
    2892:	85ca                	mv	a1,s2
    2894:	00003517          	auipc	a0,0x3
    2898:	73450513          	addi	a0,a0,1844 # 5fc8 <malloc+0x1264>
    289c:	00002097          	auipc	ra,0x2
    28a0:	40a080e7          	jalr	1034(ra) # 4ca6 <printf>
    exit(1);
    28a4:	4505                	li	a0,1
    28a6:	00002097          	auipc	ra,0x2
    28aa:	062080e7          	jalr	98(ra) # 4908 <exit>
    printf("%s: open (removeed) dd/dd/ff succeeded\n", s);
    28ae:	85ca                	mv	a1,s2
    28b0:	00003517          	auipc	a0,0x3
    28b4:	73850513          	addi	a0,a0,1848 # 5fe8 <malloc+0x1284>
    28b8:	00002097          	auipc	ra,0x2
    28bc:	3ee080e7          	jalr	1006(ra) # 4ca6 <printf>
    exit(1);
    28c0:	4505                	li	a0,1
    28c2:	00002097          	auipc	ra,0x2
    28c6:	046080e7          	jalr	70(ra) # 4908 <exit>
    printf("%s: chdir dd failed\n", s);
    28ca:	85ca                	mv	a1,s2
    28cc:	00003517          	auipc	a0,0x3
    28d0:	74450513          	addi	a0,a0,1860 # 6010 <malloc+0x12ac>
    28d4:	00002097          	auipc	ra,0x2
    28d8:	3d2080e7          	jalr	978(ra) # 4ca6 <printf>
    exit(1);
    28dc:	4505                	li	a0,1
    28de:	00002097          	auipc	ra,0x2
    28e2:	02a080e7          	jalr	42(ra) # 4908 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    28e6:	85ca                	mv	a1,s2
    28e8:	00003517          	auipc	a0,0x3
    28ec:	75050513          	addi	a0,a0,1872 # 6038 <malloc+0x12d4>
    28f0:	00002097          	auipc	ra,0x2
    28f4:	3b6080e7          	jalr	950(ra) # 4ca6 <printf>
    exit(1);
    28f8:	4505                	li	a0,1
    28fa:	00002097          	auipc	ra,0x2
    28fe:	00e080e7          	jalr	14(ra) # 4908 <exit>
    printf("chdir dd/../../dd failed\n", s);
    2902:	85ca                	mv	a1,s2
    2904:	00003517          	auipc	a0,0x3
    2908:	76450513          	addi	a0,a0,1892 # 6068 <malloc+0x1304>
    290c:	00002097          	auipc	ra,0x2
    2910:	39a080e7          	jalr	922(ra) # 4ca6 <printf>
    exit(1);
    2914:	4505                	li	a0,1
    2916:	00002097          	auipc	ra,0x2
    291a:	ff2080e7          	jalr	-14(ra) # 4908 <exit>
    printf("%s: chdir ./.. failed\n", s);
    291e:	85ca                	mv	a1,s2
    2920:	00003517          	auipc	a0,0x3
    2924:	77050513          	addi	a0,a0,1904 # 6090 <malloc+0x132c>
    2928:	00002097          	auipc	ra,0x2
    292c:	37e080e7          	jalr	894(ra) # 4ca6 <printf>
    exit(1);
    2930:	4505                	li	a0,1
    2932:	00002097          	auipc	ra,0x2
    2936:	fd6080e7          	jalr	-42(ra) # 4908 <exit>
    printf("%s: open (removeed) dd/dd/ff succeeded!\n", s);
    293a:	85ca                	mv	a1,s2
    293c:	00003517          	auipc	a0,0x3
    2940:	76c50513          	addi	a0,a0,1900 # 60a8 <malloc+0x1344>
    2944:	00002097          	auipc	ra,0x2
    2948:	362080e7          	jalr	866(ra) # 4ca6 <printf>
    exit(1);
    294c:	4505                	li	a0,1
    294e:	00002097          	auipc	ra,0x2
    2952:	fba080e7          	jalr	-70(ra) # 4908 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    2956:	85ca                	mv	a1,s2
    2958:	00003517          	auipc	a0,0x3
    295c:	79050513          	addi	a0,a0,1936 # 60e8 <malloc+0x1384>
    2960:	00002097          	auipc	ra,0x2
    2964:	346080e7          	jalr	838(ra) # 4ca6 <printf>
    exit(1);
    2968:	4505                	li	a0,1
    296a:	00002097          	auipc	ra,0x2
    296e:	f9e080e7          	jalr	-98(ra) # 4908 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    2972:	85ca                	mv	a1,s2
    2974:	00003517          	auipc	a0,0x3
    2978:	7a450513          	addi	a0,a0,1956 # 6118 <malloc+0x13b4>
    297c:	00002097          	auipc	ra,0x2
    2980:	32a080e7          	jalr	810(ra) # 4ca6 <printf>
    exit(1);
    2984:	4505                	li	a0,1
    2986:	00002097          	auipc	ra,0x2
    298a:	f82080e7          	jalr	-126(ra) # 4908 <exit>
    printf("%s: create dd succeeded!\n", s);
    298e:	85ca                	mv	a1,s2
    2990:	00003517          	auipc	a0,0x3
    2994:	7a850513          	addi	a0,a0,1960 # 6138 <malloc+0x13d4>
    2998:	00002097          	auipc	ra,0x2
    299c:	30e080e7          	jalr	782(ra) # 4ca6 <printf>
    exit(1);
    29a0:	4505                	li	a0,1
    29a2:	00002097          	auipc	ra,0x2
    29a6:	f66080e7          	jalr	-154(ra) # 4908 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    29aa:	85ca                	mv	a1,s2
    29ac:	00003517          	auipc	a0,0x3
    29b0:	7ac50513          	addi	a0,a0,1964 # 6158 <malloc+0x13f4>
    29b4:	00002097          	auipc	ra,0x2
    29b8:	2f2080e7          	jalr	754(ra) # 4ca6 <printf>
    exit(1);
    29bc:	4505                	li	a0,1
    29be:	00002097          	auipc	ra,0x2
    29c2:	f4a080e7          	jalr	-182(ra) # 4908 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    29c6:	85ca                	mv	a1,s2
    29c8:	00003517          	auipc	a0,0x3
    29cc:	7b050513          	addi	a0,a0,1968 # 6178 <malloc+0x1414>
    29d0:	00002097          	auipc	ra,0x2
    29d4:	2d6080e7          	jalr	726(ra) # 4ca6 <printf>
    exit(1);
    29d8:	4505                	li	a0,1
    29da:	00002097          	auipc	ra,0x2
    29de:	f2e080e7          	jalr	-210(ra) # 4908 <exit>
    printf("%s: remove dd/ff failed\n", s);
    29e2:	85ca                	mv	a1,s2
    29e4:	00003517          	auipc	a0,0x3
    29e8:	7b450513          	addi	a0,a0,1972 # 6198 <malloc+0x1434>
    29ec:	00002097          	auipc	ra,0x2
    29f0:	2ba080e7          	jalr	698(ra) # 4ca6 <printf>
    exit(1);
    29f4:	4505                	li	a0,1
    29f6:	00002097          	auipc	ra,0x2
    29fa:	f12080e7          	jalr	-238(ra) # 4908 <exit>
    printf("%s: remove non-empty dd succeeded!\n", s);
    29fe:	85ca                	mv	a1,s2
    2a00:	00003517          	auipc	a0,0x3
    2a04:	7b850513          	addi	a0,a0,1976 # 61b8 <malloc+0x1454>
    2a08:	00002097          	auipc	ra,0x2
    2a0c:	29e080e7          	jalr	670(ra) # 4ca6 <printf>
    exit(1);
    2a10:	4505                	li	a0,1
    2a12:	00002097          	auipc	ra,0x2
    2a16:	ef6080e7          	jalr	-266(ra) # 4908 <exit>
    printf("%s: remove dd/dd failed\n", s);
    2a1a:	85ca                	mv	a1,s2
    2a1c:	00003517          	auipc	a0,0x3
    2a20:	7cc50513          	addi	a0,a0,1996 # 61e8 <malloc+0x1484>
    2a24:	00002097          	auipc	ra,0x2
    2a28:	282080e7          	jalr	642(ra) # 4ca6 <printf>
    exit(1);
    2a2c:	4505                	li	a0,1
    2a2e:	00002097          	auipc	ra,0x2
    2a32:	eda080e7          	jalr	-294(ra) # 4908 <exit>
    printf("%s: remove dd failed\n", s);
    2a36:	85ca                	mv	a1,s2
    2a38:	00003517          	auipc	a0,0x3
    2a3c:	7d050513          	addi	a0,a0,2000 # 6208 <malloc+0x14a4>
    2a40:	00002097          	auipc	ra,0x2
    2a44:	266080e7          	jalr	614(ra) # 4ca6 <printf>
    exit(1);
    2a48:	4505                	li	a0,1
    2a4a:	00002097          	auipc	ra,0x2
    2a4e:	ebe080e7          	jalr	-322(ra) # 4908 <exit>

0000000000002a52 <rmdot>:
{
    2a52:	1101                	addi	sp,sp,-32
    2a54:	ec06                	sd	ra,24(sp)
    2a56:	e822                	sd	s0,16(sp)
    2a58:	e426                	sd	s1,8(sp)
    2a5a:	1000                	addi	s0,sp,32
    2a5c:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    2a5e:	00003517          	auipc	a0,0x3
    2a62:	7c250513          	addi	a0,a0,1986 # 6220 <malloc+0x14bc>
    2a66:	00002097          	auipc	ra,0x2
    2a6a:	ef2080e7          	jalr	-270(ra) # 4958 <mkdir>
    2a6e:	e549                	bnez	a0,2af8 <rmdot+0xa6>
  if(chdir("dots") != 0){
    2a70:	00003517          	auipc	a0,0x3
    2a74:	7b050513          	addi	a0,a0,1968 # 6220 <malloc+0x14bc>
    2a78:	00002097          	auipc	ra,0x2
    2a7c:	ee8080e7          	jalr	-280(ra) # 4960 <chdir>
    2a80:	e951                	bnez	a0,2b14 <rmdot+0xc2>
  if(remove(".") == 0){
    2a82:	00003517          	auipc	a0,0x3
    2a86:	7d650513          	addi	a0,a0,2006 # 6258 <malloc+0x14f4>
    2a8a:	00002097          	auipc	ra,0x2
    2a8e:	f26080e7          	jalr	-218(ra) # 49b0 <remove>
    2a92:	cd59                	beqz	a0,2b30 <rmdot+0xde>
  if(remove("..") == 0){
    2a94:	00003517          	auipc	a0,0x3
    2a98:	7e450513          	addi	a0,a0,2020 # 6278 <malloc+0x1514>
    2a9c:	00002097          	auipc	ra,0x2
    2aa0:	f14080e7          	jalr	-236(ra) # 49b0 <remove>
    2aa4:	c545                	beqz	a0,2b4c <rmdot+0xfa>
  if(chdir("/") != 0){
    2aa6:	00003517          	auipc	a0,0x3
    2aaa:	3ba50513          	addi	a0,a0,954 # 5e60 <malloc+0x10fc>
    2aae:	00002097          	auipc	ra,0x2
    2ab2:	eb2080e7          	jalr	-334(ra) # 4960 <chdir>
    2ab6:	e94d                	bnez	a0,2b68 <rmdot+0x116>
  if(remove("dots/.") == 0){
    2ab8:	00003517          	auipc	a0,0x3
    2abc:	7e050513          	addi	a0,a0,2016 # 6298 <malloc+0x1534>
    2ac0:	00002097          	auipc	ra,0x2
    2ac4:	ef0080e7          	jalr	-272(ra) # 49b0 <remove>
    2ac8:	cd55                	beqz	a0,2b84 <rmdot+0x132>
  if(remove("dots/..") == 0){
    2aca:	00003517          	auipc	a0,0x3
    2ace:	7f650513          	addi	a0,a0,2038 # 62c0 <malloc+0x155c>
    2ad2:	00002097          	auipc	ra,0x2
    2ad6:	ede080e7          	jalr	-290(ra) # 49b0 <remove>
    2ada:	c179                	beqz	a0,2ba0 <rmdot+0x14e>
  if(remove("dots") != 0){
    2adc:	00003517          	auipc	a0,0x3
    2ae0:	74450513          	addi	a0,a0,1860 # 6220 <malloc+0x14bc>
    2ae4:	00002097          	auipc	ra,0x2
    2ae8:	ecc080e7          	jalr	-308(ra) # 49b0 <remove>
    2aec:	e961                	bnez	a0,2bbc <rmdot+0x16a>
}
    2aee:	60e2                	ld	ra,24(sp)
    2af0:	6442                	ld	s0,16(sp)
    2af2:	64a2                	ld	s1,8(sp)
    2af4:	6105                	addi	sp,sp,32
    2af6:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    2af8:	85a6                	mv	a1,s1
    2afa:	00003517          	auipc	a0,0x3
    2afe:	72e50513          	addi	a0,a0,1838 # 6228 <malloc+0x14c4>
    2b02:	00002097          	auipc	ra,0x2
    2b06:	1a4080e7          	jalr	420(ra) # 4ca6 <printf>
    exit(1);
    2b0a:	4505                	li	a0,1
    2b0c:	00002097          	auipc	ra,0x2
    2b10:	dfc080e7          	jalr	-516(ra) # 4908 <exit>
    printf("%s: chdir dots failed\n", s);
    2b14:	85a6                	mv	a1,s1
    2b16:	00003517          	auipc	a0,0x3
    2b1a:	72a50513          	addi	a0,a0,1834 # 6240 <malloc+0x14dc>
    2b1e:	00002097          	auipc	ra,0x2
    2b22:	188080e7          	jalr	392(ra) # 4ca6 <printf>
    exit(1);
    2b26:	4505                	li	a0,1
    2b28:	00002097          	auipc	ra,0x2
    2b2c:	de0080e7          	jalr	-544(ra) # 4908 <exit>
    printf("%s: rm . worked!\n", s);
    2b30:	85a6                	mv	a1,s1
    2b32:	00003517          	auipc	a0,0x3
    2b36:	72e50513          	addi	a0,a0,1838 # 6260 <malloc+0x14fc>
    2b3a:	00002097          	auipc	ra,0x2
    2b3e:	16c080e7          	jalr	364(ra) # 4ca6 <printf>
    exit(1);
    2b42:	4505                	li	a0,1
    2b44:	00002097          	auipc	ra,0x2
    2b48:	dc4080e7          	jalr	-572(ra) # 4908 <exit>
    printf("%s: rm .. worked!\n", s);
    2b4c:	85a6                	mv	a1,s1
    2b4e:	00003517          	auipc	a0,0x3
    2b52:	73250513          	addi	a0,a0,1842 # 6280 <malloc+0x151c>
    2b56:	00002097          	auipc	ra,0x2
    2b5a:	150080e7          	jalr	336(ra) # 4ca6 <printf>
    exit(1);
    2b5e:	4505                	li	a0,1
    2b60:	00002097          	auipc	ra,0x2
    2b64:	da8080e7          	jalr	-600(ra) # 4908 <exit>
    printf("%s: chdir / failed\n", s);
    2b68:	85a6                	mv	a1,s1
    2b6a:	00003517          	auipc	a0,0x3
    2b6e:	2fe50513          	addi	a0,a0,766 # 5e68 <malloc+0x1104>
    2b72:	00002097          	auipc	ra,0x2
    2b76:	134080e7          	jalr	308(ra) # 4ca6 <printf>
    exit(1);
    2b7a:	4505                	li	a0,1
    2b7c:	00002097          	auipc	ra,0x2
    2b80:	d8c080e7          	jalr	-628(ra) # 4908 <exit>
    printf("%s: remove dots/. worked!\n", s);
    2b84:	85a6                	mv	a1,s1
    2b86:	00003517          	auipc	a0,0x3
    2b8a:	71a50513          	addi	a0,a0,1818 # 62a0 <malloc+0x153c>
    2b8e:	00002097          	auipc	ra,0x2
    2b92:	118080e7          	jalr	280(ra) # 4ca6 <printf>
    exit(1);
    2b96:	4505                	li	a0,1
    2b98:	00002097          	auipc	ra,0x2
    2b9c:	d70080e7          	jalr	-656(ra) # 4908 <exit>
    printf("%s: remove dots/.. worked!\n", s);
    2ba0:	85a6                	mv	a1,s1
    2ba2:	00003517          	auipc	a0,0x3
    2ba6:	72650513          	addi	a0,a0,1830 # 62c8 <malloc+0x1564>
    2baa:	00002097          	auipc	ra,0x2
    2bae:	0fc080e7          	jalr	252(ra) # 4ca6 <printf>
    exit(1);
    2bb2:	4505                	li	a0,1
    2bb4:	00002097          	auipc	ra,0x2
    2bb8:	d54080e7          	jalr	-684(ra) # 4908 <exit>
    printf("%s: remove dots failed!\n", s);
    2bbc:	85a6                	mv	a1,s1
    2bbe:	00003517          	auipc	a0,0x3
    2bc2:	72a50513          	addi	a0,a0,1834 # 62e8 <malloc+0x1584>
    2bc6:	00002097          	auipc	ra,0x2
    2bca:	0e0080e7          	jalr	224(ra) # 4ca6 <printf>
    exit(1);
    2bce:	4505                	li	a0,1
    2bd0:	00002097          	auipc	ra,0x2
    2bd4:	d38080e7          	jalr	-712(ra) # 4908 <exit>

0000000000002bd8 <dirfile>:
{
    2bd8:	1101                	addi	sp,sp,-32
    2bda:	ec06                	sd	ra,24(sp)
    2bdc:	e822                	sd	s0,16(sp)
    2bde:	e426                	sd	s1,8(sp)
    2be0:	e04a                	sd	s2,0(sp)
    2be2:	1000                	addi	s0,sp,32
    2be4:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    2be6:	20000593          	li	a1,512
    2bea:	00002517          	auipc	a0,0x2
    2bee:	50e50513          	addi	a0,a0,1294 # 50f8 <malloc+0x394>
    2bf2:	00002097          	auipc	ra,0x2
    2bf6:	d56080e7          	jalr	-682(ra) # 4948 <open>
  if(fd < 0){
    2bfa:	0c054d63          	bltz	a0,2cd4 <dirfile+0xfc>
  close(fd);
    2bfe:	00002097          	auipc	ra,0x2
    2c02:	d32080e7          	jalr	-718(ra) # 4930 <close>
  if(chdir("dirfile") == 0){
    2c06:	00002517          	auipc	a0,0x2
    2c0a:	4f250513          	addi	a0,a0,1266 # 50f8 <malloc+0x394>
    2c0e:	00002097          	auipc	ra,0x2
    2c12:	d52080e7          	jalr	-686(ra) # 4960 <chdir>
    2c16:	cd69                	beqz	a0,2cf0 <dirfile+0x118>
  fd = open("dirfile/xx", 0);
    2c18:	4581                	li	a1,0
    2c1a:	00003517          	auipc	a0,0x3
    2c1e:	72e50513          	addi	a0,a0,1838 # 6348 <malloc+0x15e4>
    2c22:	00002097          	auipc	ra,0x2
    2c26:	d26080e7          	jalr	-730(ra) # 4948 <open>
  if(fd >= 0){
    2c2a:	0e055163          	bgez	a0,2d0c <dirfile+0x134>
  fd = open("dirfile/xx", O_CREATE);
    2c2e:	20000593          	li	a1,512
    2c32:	00003517          	auipc	a0,0x3
    2c36:	71650513          	addi	a0,a0,1814 # 6348 <malloc+0x15e4>
    2c3a:	00002097          	auipc	ra,0x2
    2c3e:	d0e080e7          	jalr	-754(ra) # 4948 <open>
  if(fd >= 0){
    2c42:	0e055363          	bgez	a0,2d28 <dirfile+0x150>
  if(mkdir("dirfile/xx") == 0){
    2c46:	00003517          	auipc	a0,0x3
    2c4a:	70250513          	addi	a0,a0,1794 # 6348 <malloc+0x15e4>
    2c4e:	00002097          	auipc	ra,0x2
    2c52:	d0a080e7          	jalr	-758(ra) # 4958 <mkdir>
    2c56:	c57d                	beqz	a0,2d44 <dirfile+0x16c>
  if(remove("dirfile/xx") == 0){
    2c58:	00003517          	auipc	a0,0x3
    2c5c:	6f050513          	addi	a0,a0,1776 # 6348 <malloc+0x15e4>
    2c60:	00002097          	auipc	ra,0x2
    2c64:	d50080e7          	jalr	-688(ra) # 49b0 <remove>
    2c68:	cd65                	beqz	a0,2d60 <dirfile+0x188>
  if(remove("dirfile") != 0){
    2c6a:	00002517          	auipc	a0,0x2
    2c6e:	48e50513          	addi	a0,a0,1166 # 50f8 <malloc+0x394>
    2c72:	00002097          	auipc	ra,0x2
    2c76:	d3e080e7          	jalr	-706(ra) # 49b0 <remove>
    2c7a:	10051163          	bnez	a0,2d7c <dirfile+0x1a4>
  fd = open(".", O_RDWR);
    2c7e:	4589                	li	a1,2
    2c80:	00003517          	auipc	a0,0x3
    2c84:	5d850513          	addi	a0,a0,1496 # 6258 <malloc+0x14f4>
    2c88:	00002097          	auipc	ra,0x2
    2c8c:	cc0080e7          	jalr	-832(ra) # 4948 <open>
  if(fd >= 0){
    2c90:	10055463          	bgez	a0,2d98 <dirfile+0x1c0>
  fd = open(".", 0);
    2c94:	4581                	li	a1,0
    2c96:	00003517          	auipc	a0,0x3
    2c9a:	5c250513          	addi	a0,a0,1474 # 6258 <malloc+0x14f4>
    2c9e:	00002097          	auipc	ra,0x2
    2ca2:	caa080e7          	jalr	-854(ra) # 4948 <open>
    2ca6:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    2ca8:	4605                	li	a2,1
    2caa:	00002597          	auipc	a1,0x2
    2cae:	54e58593          	addi	a1,a1,1358 # 51f8 <malloc+0x494>
    2cb2:	00002097          	auipc	ra,0x2
    2cb6:	c76080e7          	jalr	-906(ra) # 4928 <write>
    2cba:	0ea04d63          	bgtz	a0,2db4 <dirfile+0x1dc>
  close(fd);
    2cbe:	8526                	mv	a0,s1
    2cc0:	00002097          	auipc	ra,0x2
    2cc4:	c70080e7          	jalr	-912(ra) # 4930 <close>
}
    2cc8:	60e2                	ld	ra,24(sp)
    2cca:	6442                	ld	s0,16(sp)
    2ccc:	64a2                	ld	s1,8(sp)
    2cce:	6902                	ld	s2,0(sp)
    2cd0:	6105                	addi	sp,sp,32
    2cd2:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    2cd4:	85ca                	mv	a1,s2
    2cd6:	00003517          	auipc	a0,0x3
    2cda:	63250513          	addi	a0,a0,1586 # 6308 <malloc+0x15a4>
    2cde:	00002097          	auipc	ra,0x2
    2ce2:	fc8080e7          	jalr	-56(ra) # 4ca6 <printf>
    exit(1);
    2ce6:	4505                	li	a0,1
    2ce8:	00002097          	auipc	ra,0x2
    2cec:	c20080e7          	jalr	-992(ra) # 4908 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    2cf0:	85ca                	mv	a1,s2
    2cf2:	00003517          	auipc	a0,0x3
    2cf6:	63650513          	addi	a0,a0,1590 # 6328 <malloc+0x15c4>
    2cfa:	00002097          	auipc	ra,0x2
    2cfe:	fac080e7          	jalr	-84(ra) # 4ca6 <printf>
    exit(1);
    2d02:	4505                	li	a0,1
    2d04:	00002097          	auipc	ra,0x2
    2d08:	c04080e7          	jalr	-1020(ra) # 4908 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    2d0c:	85ca                	mv	a1,s2
    2d0e:	00003517          	auipc	a0,0x3
    2d12:	64a50513          	addi	a0,a0,1610 # 6358 <malloc+0x15f4>
    2d16:	00002097          	auipc	ra,0x2
    2d1a:	f90080e7          	jalr	-112(ra) # 4ca6 <printf>
    exit(1);
    2d1e:	4505                	li	a0,1
    2d20:	00002097          	auipc	ra,0x2
    2d24:	be8080e7          	jalr	-1048(ra) # 4908 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    2d28:	85ca                	mv	a1,s2
    2d2a:	00003517          	auipc	a0,0x3
    2d2e:	62e50513          	addi	a0,a0,1582 # 6358 <malloc+0x15f4>
    2d32:	00002097          	auipc	ra,0x2
    2d36:	f74080e7          	jalr	-140(ra) # 4ca6 <printf>
    exit(1);
    2d3a:	4505                	li	a0,1
    2d3c:	00002097          	auipc	ra,0x2
    2d40:	bcc080e7          	jalr	-1076(ra) # 4908 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    2d44:	85ca                	mv	a1,s2
    2d46:	00003517          	auipc	a0,0x3
    2d4a:	63a50513          	addi	a0,a0,1594 # 6380 <malloc+0x161c>
    2d4e:	00002097          	auipc	ra,0x2
    2d52:	f58080e7          	jalr	-168(ra) # 4ca6 <printf>
    exit(1);
    2d56:	4505                	li	a0,1
    2d58:	00002097          	auipc	ra,0x2
    2d5c:	bb0080e7          	jalr	-1104(ra) # 4908 <exit>
    printf("%s: remove dirfile/xx succeeded!\n", s);
    2d60:	85ca                	mv	a1,s2
    2d62:	00003517          	auipc	a0,0x3
    2d66:	64650513          	addi	a0,a0,1606 # 63a8 <malloc+0x1644>
    2d6a:	00002097          	auipc	ra,0x2
    2d6e:	f3c080e7          	jalr	-196(ra) # 4ca6 <printf>
    exit(1);
    2d72:	4505                	li	a0,1
    2d74:	00002097          	auipc	ra,0x2
    2d78:	b94080e7          	jalr	-1132(ra) # 4908 <exit>
    printf("%s: remove dirfile failed!\n", s);
    2d7c:	85ca                	mv	a1,s2
    2d7e:	00003517          	auipc	a0,0x3
    2d82:	65250513          	addi	a0,a0,1618 # 63d0 <malloc+0x166c>
    2d86:	00002097          	auipc	ra,0x2
    2d8a:	f20080e7          	jalr	-224(ra) # 4ca6 <printf>
    exit(1);
    2d8e:	4505                	li	a0,1
    2d90:	00002097          	auipc	ra,0x2
    2d94:	b78080e7          	jalr	-1160(ra) # 4908 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    2d98:	85ca                	mv	a1,s2
    2d9a:	00003517          	auipc	a0,0x3
    2d9e:	65650513          	addi	a0,a0,1622 # 63f0 <malloc+0x168c>
    2da2:	00002097          	auipc	ra,0x2
    2da6:	f04080e7          	jalr	-252(ra) # 4ca6 <printf>
    exit(1);
    2daa:	4505                	li	a0,1
    2dac:	00002097          	auipc	ra,0x2
    2db0:	b5c080e7          	jalr	-1188(ra) # 4908 <exit>
    printf("%s: write . succeeded!\n", s);
    2db4:	85ca                	mv	a1,s2
    2db6:	00003517          	auipc	a0,0x3
    2dba:	66250513          	addi	a0,a0,1634 # 6418 <malloc+0x16b4>
    2dbe:	00002097          	auipc	ra,0x2
    2dc2:	ee8080e7          	jalr	-280(ra) # 4ca6 <printf>
    exit(1);
    2dc6:	4505                	li	a0,1
    2dc8:	00002097          	auipc	ra,0x2
    2dcc:	b40080e7          	jalr	-1216(ra) # 4908 <exit>

0000000000002dd0 <iref>:
{
    2dd0:	7139                	addi	sp,sp,-64
    2dd2:	fc06                	sd	ra,56(sp)
    2dd4:	f822                	sd	s0,48(sp)
    2dd6:	f426                	sd	s1,40(sp)
    2dd8:	f04a                	sd	s2,32(sp)
    2dda:	ec4e                	sd	s3,24(sp)
    2ddc:	e852                	sd	s4,16(sp)
    2dde:	e456                	sd	s5,8(sp)
    2de0:	0080                	addi	s0,sp,64
    2de2:	8aaa                	mv	s5,a0
    2de4:	02e00493          	li	s1,46
    if(mkdir("irefd") != 0){
    2de8:	00003917          	auipc	s2,0x3
    2dec:	64890913          	addi	s2,s2,1608 # 6430 <malloc+0x16cc>
    mkdir("");
    2df0:	00003a17          	auipc	s4,0x3
    2df4:	2e0a0a13          	addi	s4,s4,736 # 60d0 <malloc+0x136c>
    fd = open("xx", O_CREATE);
    2df8:	00003997          	auipc	s3,0x3
    2dfc:	55898993          	addi	s3,s3,1368 # 6350 <malloc+0x15ec>
    2e00:	a889                	j	2e52 <iref+0x82>
      printf("%s: mkdir irefd failed\n", s);
    2e02:	85d6                	mv	a1,s5
    2e04:	00003517          	auipc	a0,0x3
    2e08:	63450513          	addi	a0,a0,1588 # 6438 <malloc+0x16d4>
    2e0c:	00002097          	auipc	ra,0x2
    2e10:	e9a080e7          	jalr	-358(ra) # 4ca6 <printf>
      exit(1);
    2e14:	4505                	li	a0,1
    2e16:	00002097          	auipc	ra,0x2
    2e1a:	af2080e7          	jalr	-1294(ra) # 4908 <exit>
      printf("%s: chdir irefd failed\n", s);
    2e1e:	85d6                	mv	a1,s5
    2e20:	00003517          	auipc	a0,0x3
    2e24:	63050513          	addi	a0,a0,1584 # 6450 <malloc+0x16ec>
    2e28:	00002097          	auipc	ra,0x2
    2e2c:	e7e080e7          	jalr	-386(ra) # 4ca6 <printf>
      exit(1);
    2e30:	4505                	li	a0,1
    2e32:	00002097          	auipc	ra,0x2
    2e36:	ad6080e7          	jalr	-1322(ra) # 4908 <exit>
      close(fd);
    2e3a:	00002097          	auipc	ra,0x2
    2e3e:	af6080e7          	jalr	-1290(ra) # 4930 <close>
    2e42:	a091                	j	2e86 <iref+0xb6>
    remove("xx");
    2e44:	854e                	mv	a0,s3
    2e46:	00002097          	auipc	ra,0x2
    2e4a:	b6a080e7          	jalr	-1174(ra) # 49b0 <remove>
  for(i = 0; i < NINODE - 4; i++){
    2e4e:	34fd                	addiw	s1,s1,-1
    2e50:	c8a9                	beqz	s1,2ea2 <iref+0xd2>
    if(mkdir("irefd") != 0){
    2e52:	854a                	mv	a0,s2
    2e54:	00002097          	auipc	ra,0x2
    2e58:	b04080e7          	jalr	-1276(ra) # 4958 <mkdir>
    2e5c:	f15d                	bnez	a0,2e02 <iref+0x32>
    if(chdir("irefd") != 0){
    2e5e:	854a                	mv	a0,s2
    2e60:	00002097          	auipc	ra,0x2
    2e64:	b00080e7          	jalr	-1280(ra) # 4960 <chdir>
    2e68:	f95d                	bnez	a0,2e1e <iref+0x4e>
    mkdir("");
    2e6a:	8552                	mv	a0,s4
    2e6c:	00002097          	auipc	ra,0x2
    2e70:	aec080e7          	jalr	-1300(ra) # 4958 <mkdir>
    fd = open("", O_CREATE);
    2e74:	20000593          	li	a1,512
    2e78:	8552                	mv	a0,s4
    2e7a:	00002097          	auipc	ra,0x2
    2e7e:	ace080e7          	jalr	-1330(ra) # 4948 <open>
    if(fd >= 0)
    2e82:	fa055ce3          	bgez	a0,2e3a <iref+0x6a>
    fd = open("xx", O_CREATE);
    2e86:	20000593          	li	a1,512
    2e8a:	854e                	mv	a0,s3
    2e8c:	00002097          	auipc	ra,0x2
    2e90:	abc080e7          	jalr	-1348(ra) # 4948 <open>
    if(fd >= 0)
    2e94:	fa0548e3          	bltz	a0,2e44 <iref+0x74>
      close(fd);
    2e98:	00002097          	auipc	ra,0x2
    2e9c:	a98080e7          	jalr	-1384(ra) # 4930 <close>
    2ea0:	b755                	j	2e44 <iref+0x74>
    2ea2:	03300493          	li	s1,51
    chdir("..");
    2ea6:	00003997          	auipc	s3,0x3
    2eaa:	3d298993          	addi	s3,s3,978 # 6278 <malloc+0x1514>
    remove("irefd");
    2eae:	00003917          	auipc	s2,0x3
    2eb2:	58290913          	addi	s2,s2,1410 # 6430 <malloc+0x16cc>
    chdir("..");
    2eb6:	854e                	mv	a0,s3
    2eb8:	00002097          	auipc	ra,0x2
    2ebc:	aa8080e7          	jalr	-1368(ra) # 4960 <chdir>
    remove("irefd");
    2ec0:	854a                	mv	a0,s2
    2ec2:	00002097          	auipc	ra,0x2
    2ec6:	aee080e7          	jalr	-1298(ra) # 49b0 <remove>
  for(i = 0; i < NINODE + 1; i++){
    2eca:	34fd                	addiw	s1,s1,-1
    2ecc:	f4ed                	bnez	s1,2eb6 <iref+0xe6>
  chdir("/");
    2ece:	00003517          	auipc	a0,0x3
    2ed2:	f9250513          	addi	a0,a0,-110 # 5e60 <malloc+0x10fc>
    2ed6:	00002097          	auipc	ra,0x2
    2eda:	a8a080e7          	jalr	-1398(ra) # 4960 <chdir>
}
    2ede:	70e2                	ld	ra,56(sp)
    2ee0:	7442                	ld	s0,48(sp)
    2ee2:	74a2                	ld	s1,40(sp)
    2ee4:	7902                	ld	s2,32(sp)
    2ee6:	69e2                	ld	s3,24(sp)
    2ee8:	6a42                	ld	s4,16(sp)
    2eea:	6aa2                	ld	s5,8(sp)
    2eec:	6121                	addi	sp,sp,64
    2eee:	8082                	ret

0000000000002ef0 <openiputtest>:
{
    2ef0:	7179                	addi	sp,sp,-48
    2ef2:	f406                	sd	ra,40(sp)
    2ef4:	f022                	sd	s0,32(sp)
    2ef6:	ec26                	sd	s1,24(sp)
    2ef8:	1800                	addi	s0,sp,48
    2efa:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    2efc:	00003517          	auipc	a0,0x3
    2f00:	56c50513          	addi	a0,a0,1388 # 6468 <malloc+0x1704>
    2f04:	00002097          	auipc	ra,0x2
    2f08:	a54080e7          	jalr	-1452(ra) # 4958 <mkdir>
    2f0c:	04054263          	bltz	a0,2f50 <openiputtest+0x60>
  pid = fork();
    2f10:	00002097          	auipc	ra,0x2
    2f14:	9f0080e7          	jalr	-1552(ra) # 4900 <fork>
  if(pid < 0){
    2f18:	04054a63          	bltz	a0,2f6c <openiputtest+0x7c>
  if(pid == 0){
    2f1c:	e93d                	bnez	a0,2f92 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    2f1e:	4589                	li	a1,2
    2f20:	00003517          	auipc	a0,0x3
    2f24:	54850513          	addi	a0,a0,1352 # 6468 <malloc+0x1704>
    2f28:	00002097          	auipc	ra,0x2
    2f2c:	a20080e7          	jalr	-1504(ra) # 4948 <open>
    if(fd >= 0){
    2f30:	04054c63          	bltz	a0,2f88 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    2f34:	85a6                	mv	a1,s1
    2f36:	00003517          	auipc	a0,0x3
    2f3a:	55250513          	addi	a0,a0,1362 # 6488 <malloc+0x1724>
    2f3e:	00002097          	auipc	ra,0x2
    2f42:	d68080e7          	jalr	-664(ra) # 4ca6 <printf>
      exit(1);
    2f46:	4505                	li	a0,1
    2f48:	00002097          	auipc	ra,0x2
    2f4c:	9c0080e7          	jalr	-1600(ra) # 4908 <exit>
    printf("%s: mkdir oidir failed\n", s);
    2f50:	85a6                	mv	a1,s1
    2f52:	00003517          	auipc	a0,0x3
    2f56:	51e50513          	addi	a0,a0,1310 # 6470 <malloc+0x170c>
    2f5a:	00002097          	auipc	ra,0x2
    2f5e:	d4c080e7          	jalr	-692(ra) # 4ca6 <printf>
    exit(1);
    2f62:	4505                	li	a0,1
    2f64:	00002097          	auipc	ra,0x2
    2f68:	9a4080e7          	jalr	-1628(ra) # 4908 <exit>
    printf("%s: fork failed\n", s);
    2f6c:	85a6                	mv	a1,s1
    2f6e:	00003517          	auipc	a0,0x3
    2f72:	88a50513          	addi	a0,a0,-1910 # 57f8 <malloc+0xa94>
    2f76:	00002097          	auipc	ra,0x2
    2f7a:	d30080e7          	jalr	-720(ra) # 4ca6 <printf>
    exit(1);
    2f7e:	4505                	li	a0,1
    2f80:	00002097          	auipc	ra,0x2
    2f84:	988080e7          	jalr	-1656(ra) # 4908 <exit>
    exit(0);
    2f88:	4501                	li	a0,0
    2f8a:	00002097          	auipc	ra,0x2
    2f8e:	97e080e7          	jalr	-1666(ra) # 4908 <exit>
  sleep(1);
    2f92:	4505                	li	a0,1
    2f94:	00002097          	auipc	ra,0x2
    2f98:	9ec080e7          	jalr	-1556(ra) # 4980 <sleep>
  if(remove("oidir") != 0){
    2f9c:	00003517          	auipc	a0,0x3
    2fa0:	4cc50513          	addi	a0,a0,1228 # 6468 <malloc+0x1704>
    2fa4:	00002097          	auipc	ra,0x2
    2fa8:	a0c080e7          	jalr	-1524(ra) # 49b0 <remove>
    2fac:	cd19                	beqz	a0,2fca <openiputtest+0xda>
    printf("%s: remove failed\n", s);
    2fae:	85a6                	mv	a1,s1
    2fb0:	00003517          	auipc	a0,0x3
    2fb4:	50050513          	addi	a0,a0,1280 # 64b0 <malloc+0x174c>
    2fb8:	00002097          	auipc	ra,0x2
    2fbc:	cee080e7          	jalr	-786(ra) # 4ca6 <printf>
    exit(1);
    2fc0:	4505                	li	a0,1
    2fc2:	00002097          	auipc	ra,0x2
    2fc6:	946080e7          	jalr	-1722(ra) # 4908 <exit>
  wait(&xstatus);
    2fca:	fdc40513          	addi	a0,s0,-36
    2fce:	00002097          	auipc	ra,0x2
    2fd2:	942080e7          	jalr	-1726(ra) # 4910 <wait>
  exit(xstatus);
    2fd6:	fdc42503          	lw	a0,-36(s0)
    2fda:	00002097          	auipc	ra,0x2
    2fde:	92e080e7          	jalr	-1746(ra) # 4908 <exit>

0000000000002fe2 <forkforkfork>:
{
    2fe2:	1101                	addi	sp,sp,-32
    2fe4:	ec06                	sd	ra,24(sp)
    2fe6:	e822                	sd	s0,16(sp)
    2fe8:	e426                	sd	s1,8(sp)
    2fea:	1000                	addi	s0,sp,32
    2fec:	84aa                	mv	s1,a0
  remove("stopforking");
    2fee:	00003517          	auipc	a0,0x3
    2ff2:	4da50513          	addi	a0,a0,1242 # 64c8 <malloc+0x1764>
    2ff6:	00002097          	auipc	ra,0x2
    2ffa:	9ba080e7          	jalr	-1606(ra) # 49b0 <remove>
  int pid = fork();
    2ffe:	00002097          	auipc	ra,0x2
    3002:	902080e7          	jalr	-1790(ra) # 4900 <fork>
  if(pid < 0){
    3006:	04054d63          	bltz	a0,3060 <forkforkfork+0x7e>
  if(pid == 0){
    300a:	c92d                	beqz	a0,307c <forkforkfork+0x9a>
  sleep(20); // two seconds
    300c:	4551                	li	a0,20
    300e:	00002097          	auipc	ra,0x2
    3012:	972080e7          	jalr	-1678(ra) # 4980 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    3016:	20200593          	li	a1,514
    301a:	00003517          	auipc	a0,0x3
    301e:	4ae50513          	addi	a0,a0,1198 # 64c8 <malloc+0x1764>
    3022:	00002097          	auipc	ra,0x2
    3026:	926080e7          	jalr	-1754(ra) # 4948 <open>
    302a:	00002097          	auipc	ra,0x2
    302e:	906080e7          	jalr	-1786(ra) # 4930 <close>
  wait(0);
    3032:	4501                	li	a0,0
    3034:	00002097          	auipc	ra,0x2
    3038:	8dc080e7          	jalr	-1828(ra) # 4910 <wait>
  sleep(10); // one second
    303c:	4529                	li	a0,10
    303e:	00002097          	auipc	ra,0x2
    3042:	942080e7          	jalr	-1726(ra) # 4980 <sleep>
  remove("stopforking");
    3046:	00003517          	auipc	a0,0x3
    304a:	48250513          	addi	a0,a0,1154 # 64c8 <malloc+0x1764>
    304e:	00002097          	auipc	ra,0x2
    3052:	962080e7          	jalr	-1694(ra) # 49b0 <remove>
}
    3056:	60e2                	ld	ra,24(sp)
    3058:	6442                	ld	s0,16(sp)
    305a:	64a2                	ld	s1,8(sp)
    305c:	6105                	addi	sp,sp,32
    305e:	8082                	ret
    printf("%s: fork failed", s);
    3060:	85a6                	mv	a1,s1
    3062:	00003517          	auipc	a0,0x3
    3066:	95650513          	addi	a0,a0,-1706 # 59b8 <malloc+0xc54>
    306a:	00002097          	auipc	ra,0x2
    306e:	c3c080e7          	jalr	-964(ra) # 4ca6 <printf>
    exit(1);
    3072:	4505                	li	a0,1
    3074:	00002097          	auipc	ra,0x2
    3078:	894080e7          	jalr	-1900(ra) # 4908 <exit>
      int fd = open("stopforking", 0);
    307c:	00003497          	auipc	s1,0x3
    3080:	44c48493          	addi	s1,s1,1100 # 64c8 <malloc+0x1764>
    3084:	4581                	li	a1,0
    3086:	8526                	mv	a0,s1
    3088:	00002097          	auipc	ra,0x2
    308c:	8c0080e7          	jalr	-1856(ra) # 4948 <open>
      if(fd >= 0){
    3090:	02055463          	bgez	a0,30b8 <forkforkfork+0xd6>
      if(fork() < 0){
    3094:	00002097          	auipc	ra,0x2
    3098:	86c080e7          	jalr	-1940(ra) # 4900 <fork>
    309c:	fe0554e3          	bgez	a0,3084 <forkforkfork+0xa2>
        close(open("stopforking", O_CREATE|O_RDWR));
    30a0:	20200593          	li	a1,514
    30a4:	8526                	mv	a0,s1
    30a6:	00002097          	auipc	ra,0x2
    30aa:	8a2080e7          	jalr	-1886(ra) # 4948 <open>
    30ae:	00002097          	auipc	ra,0x2
    30b2:	882080e7          	jalr	-1918(ra) # 4930 <close>
    30b6:	b7f9                	j	3084 <forkforkfork+0xa2>
        exit(0);
    30b8:	4501                	li	a0,0
    30ba:	00002097          	auipc	ra,0x2
    30be:	84e080e7          	jalr	-1970(ra) # 4908 <exit>

00000000000030c2 <preempt>:
{
    30c2:	7139                	addi	sp,sp,-64
    30c4:	fc06                	sd	ra,56(sp)
    30c6:	f822                	sd	s0,48(sp)
    30c8:	f426                	sd	s1,40(sp)
    30ca:	f04a                	sd	s2,32(sp)
    30cc:	ec4e                	sd	s3,24(sp)
    30ce:	e852                	sd	s4,16(sp)
    30d0:	0080                	addi	s0,sp,64
    30d2:	892a                	mv	s2,a0
  pid1 = fork();
    30d4:	00002097          	auipc	ra,0x2
    30d8:	82c080e7          	jalr	-2004(ra) # 4900 <fork>
  if(pid1 < 0) {
    30dc:	00054563          	bltz	a0,30e6 <preempt+0x24>
    30e0:	84aa                	mv	s1,a0
  if(pid1 == 0)
    30e2:	ed19                	bnez	a0,3100 <preempt+0x3e>
    for(;;)
    30e4:	a001                	j	30e4 <preempt+0x22>
    printf("%s: fork failed");
    30e6:	00003517          	auipc	a0,0x3
    30ea:	8d250513          	addi	a0,a0,-1838 # 59b8 <malloc+0xc54>
    30ee:	00002097          	auipc	ra,0x2
    30f2:	bb8080e7          	jalr	-1096(ra) # 4ca6 <printf>
    exit(1);
    30f6:	4505                	li	a0,1
    30f8:	00002097          	auipc	ra,0x2
    30fc:	810080e7          	jalr	-2032(ra) # 4908 <exit>
  pid2 = fork();
    3100:	00002097          	auipc	ra,0x2
    3104:	800080e7          	jalr	-2048(ra) # 4900 <fork>
    3108:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    310a:	00054463          	bltz	a0,3112 <preempt+0x50>
  if(pid2 == 0)
    310e:	e105                	bnez	a0,312e <preempt+0x6c>
    for(;;)
    3110:	a001                	j	3110 <preempt+0x4e>
    printf("%s: fork failed\n", s);
    3112:	85ca                	mv	a1,s2
    3114:	00002517          	auipc	a0,0x2
    3118:	6e450513          	addi	a0,a0,1764 # 57f8 <malloc+0xa94>
    311c:	00002097          	auipc	ra,0x2
    3120:	b8a080e7          	jalr	-1142(ra) # 4ca6 <printf>
    exit(1);
    3124:	4505                	li	a0,1
    3126:	00001097          	auipc	ra,0x1
    312a:	7e2080e7          	jalr	2018(ra) # 4908 <exit>
  pipe(pfds);
    312e:	fc840513          	addi	a0,s0,-56
    3132:	00001097          	auipc	ra,0x1
    3136:	7e6080e7          	jalr	2022(ra) # 4918 <pipe>
  pid3 = fork();
    313a:	00001097          	auipc	ra,0x1
    313e:	7c6080e7          	jalr	1990(ra) # 4900 <fork>
    3142:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    3144:	02054e63          	bltz	a0,3180 <preempt+0xbe>
  if(pid3 == 0){
    3148:	e13d                	bnez	a0,31ae <preempt+0xec>
    close(pfds[0]);
    314a:	fc842503          	lw	a0,-56(s0)
    314e:	00001097          	auipc	ra,0x1
    3152:	7e2080e7          	jalr	2018(ra) # 4930 <close>
    if(write(pfds[1], "x", 1) != 1)
    3156:	4605                	li	a2,1
    3158:	00002597          	auipc	a1,0x2
    315c:	0a058593          	addi	a1,a1,160 # 51f8 <malloc+0x494>
    3160:	fcc42503          	lw	a0,-52(s0)
    3164:	00001097          	auipc	ra,0x1
    3168:	7c4080e7          	jalr	1988(ra) # 4928 <write>
    316c:	4785                	li	a5,1
    316e:	02f51763          	bne	a0,a5,319c <preempt+0xda>
    close(pfds[1]);
    3172:	fcc42503          	lw	a0,-52(s0)
    3176:	00001097          	auipc	ra,0x1
    317a:	7ba080e7          	jalr	1978(ra) # 4930 <close>
    for(;;)
    317e:	a001                	j	317e <preempt+0xbc>
     printf("%s: fork failed\n", s);
    3180:	85ca                	mv	a1,s2
    3182:	00002517          	auipc	a0,0x2
    3186:	67650513          	addi	a0,a0,1654 # 57f8 <malloc+0xa94>
    318a:	00002097          	auipc	ra,0x2
    318e:	b1c080e7          	jalr	-1252(ra) # 4ca6 <printf>
     exit(1);
    3192:	4505                	li	a0,1
    3194:	00001097          	auipc	ra,0x1
    3198:	774080e7          	jalr	1908(ra) # 4908 <exit>
      printf("%s: preempt write error");
    319c:	00003517          	auipc	a0,0x3
    31a0:	33c50513          	addi	a0,a0,828 # 64d8 <malloc+0x1774>
    31a4:	00002097          	auipc	ra,0x2
    31a8:	b02080e7          	jalr	-1278(ra) # 4ca6 <printf>
    31ac:	b7d9                	j	3172 <preempt+0xb0>
  close(pfds[1]);
    31ae:	fcc42503          	lw	a0,-52(s0)
    31b2:	00001097          	auipc	ra,0x1
    31b6:	77e080e7          	jalr	1918(ra) # 4930 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    31ba:	6609                	lui	a2,0x2
    31bc:	80060613          	addi	a2,a2,-2048 # 1800 <forkfork+0x3e>
    31c0:	00007597          	auipc	a1,0x7
    31c4:	66058593          	addi	a1,a1,1632 # a820 <buf>
    31c8:	fc842503          	lw	a0,-56(s0)
    31cc:	00001097          	auipc	ra,0x1
    31d0:	754080e7          	jalr	1876(ra) # 4920 <read>
    31d4:	4785                	li	a5,1
    31d6:	02f50263          	beq	a0,a5,31fa <preempt+0x138>
    printf("%s: preempt read error");
    31da:	00003517          	auipc	a0,0x3
    31de:	31650513          	addi	a0,a0,790 # 64f0 <malloc+0x178c>
    31e2:	00002097          	auipc	ra,0x2
    31e6:	ac4080e7          	jalr	-1340(ra) # 4ca6 <printf>
}
    31ea:	70e2                	ld	ra,56(sp)
    31ec:	7442                	ld	s0,48(sp)
    31ee:	74a2                	ld	s1,40(sp)
    31f0:	7902                	ld	s2,32(sp)
    31f2:	69e2                	ld	s3,24(sp)
    31f4:	6a42                	ld	s4,16(sp)
    31f6:	6121                	addi	sp,sp,64
    31f8:	8082                	ret
  close(pfds[0]);
    31fa:	fc842503          	lw	a0,-56(s0)
    31fe:	00001097          	auipc	ra,0x1
    3202:	732080e7          	jalr	1842(ra) # 4930 <close>
  printf("kill... ");
    3206:	00003517          	auipc	a0,0x3
    320a:	30250513          	addi	a0,a0,770 # 6508 <malloc+0x17a4>
    320e:	00002097          	auipc	ra,0x2
    3212:	a98080e7          	jalr	-1384(ra) # 4ca6 <printf>
  kill(pid1);
    3216:	8526                	mv	a0,s1
    3218:	00001097          	auipc	ra,0x1
    321c:	720080e7          	jalr	1824(ra) # 4938 <kill>
  kill(pid2);
    3220:	854e                	mv	a0,s3
    3222:	00001097          	auipc	ra,0x1
    3226:	716080e7          	jalr	1814(ra) # 4938 <kill>
  kill(pid3);
    322a:	8552                	mv	a0,s4
    322c:	00001097          	auipc	ra,0x1
    3230:	70c080e7          	jalr	1804(ra) # 4938 <kill>
  printf("wait... ");
    3234:	00003517          	auipc	a0,0x3
    3238:	2e450513          	addi	a0,a0,740 # 6518 <malloc+0x17b4>
    323c:	00002097          	auipc	ra,0x2
    3240:	a6a080e7          	jalr	-1430(ra) # 4ca6 <printf>
  wait(0);
    3244:	4501                	li	a0,0
    3246:	00001097          	auipc	ra,0x1
    324a:	6ca080e7          	jalr	1738(ra) # 4910 <wait>
  wait(0);
    324e:	4501                	li	a0,0
    3250:	00001097          	auipc	ra,0x1
    3254:	6c0080e7          	jalr	1728(ra) # 4910 <wait>
  wait(0);
    3258:	4501                	li	a0,0
    325a:	00001097          	auipc	ra,0x1
    325e:	6b6080e7          	jalr	1718(ra) # 4910 <wait>
    3262:	b761                	j	31ea <preempt+0x128>

0000000000003264 <sbrkfail>:
{
    3264:	7119                	addi	sp,sp,-128
    3266:	fc86                	sd	ra,120(sp)
    3268:	f8a2                	sd	s0,112(sp)
    326a:	f4a6                	sd	s1,104(sp)
    326c:	f0ca                	sd	s2,96(sp)
    326e:	ecce                	sd	s3,88(sp)
    3270:	e8d2                	sd	s4,80(sp)
    3272:	e4d6                	sd	s5,72(sp)
    3274:	e0da                	sd	s6,64(sp)
    3276:	0100                	addi	s0,sp,128
    3278:	8b2a                	mv	s6,a0
  if(pipe(fds) != 0){
    327a:	fb040513          	addi	a0,s0,-80
    327e:	00001097          	auipc	ra,0x1
    3282:	69a080e7          	jalr	1690(ra) # 4918 <pipe>
    3286:	e911                	bnez	a0,329a <sbrkfail+0x36>
    3288:	f8040493          	addi	s1,s0,-128
    328c:	fa840993          	addi	s3,s0,-88
    3290:	8926                	mv	s2,s1
    if(pids[i] != -1)
    3292:	5a7d                	li	s4,-1
      read(fds[0], &scratch, 1);
    3294:	faf40a93          	addi	s5,s0,-81
    3298:	a085                	j	32f8 <sbrkfail+0x94>
    printf("%s: pipe() failed\n", s);
    329a:	85da                	mv	a1,s6
    329c:	00002517          	auipc	a0,0x2
    32a0:	66450513          	addi	a0,a0,1636 # 5900 <malloc+0xb9c>
    32a4:	00002097          	auipc	ra,0x2
    32a8:	a02080e7          	jalr	-1534(ra) # 4ca6 <printf>
    exit(1);
    32ac:	4505                	li	a0,1
    32ae:	00001097          	auipc	ra,0x1
    32b2:	65a080e7          	jalr	1626(ra) # 4908 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    32b6:	00001097          	auipc	ra,0x1
    32ba:	6c2080e7          	jalr	1730(ra) # 4978 <sbrk>
    32be:	064007b7          	lui	a5,0x6400
    32c2:	40a7853b          	subw	a0,a5,a0
    32c6:	00001097          	auipc	ra,0x1
    32ca:	6b2080e7          	jalr	1714(ra) # 4978 <sbrk>
      write(fds[1], "x", 1);
    32ce:	4605                	li	a2,1
    32d0:	00002597          	auipc	a1,0x2
    32d4:	f2858593          	addi	a1,a1,-216 # 51f8 <malloc+0x494>
    32d8:	fb442503          	lw	a0,-76(s0)
    32dc:	00001097          	auipc	ra,0x1
    32e0:	64c080e7          	jalr	1612(ra) # 4928 <write>
      for(;;) sleep(1000);
    32e4:	3e800513          	li	a0,1000
    32e8:	00001097          	auipc	ra,0x1
    32ec:	698080e7          	jalr	1688(ra) # 4980 <sleep>
    32f0:	bfd5                	j	32e4 <sbrkfail+0x80>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    32f2:	0911                	addi	s2,s2,4
    32f4:	03390463          	beq	s2,s3,331c <sbrkfail+0xb8>
    if((pids[i] = fork()) == 0){
    32f8:	00001097          	auipc	ra,0x1
    32fc:	608080e7          	jalr	1544(ra) # 4900 <fork>
    3300:	00a92023          	sw	a0,0(s2)
    3304:	d94d                	beqz	a0,32b6 <sbrkfail+0x52>
    if(pids[i] != -1)
    3306:	ff4506e3          	beq	a0,s4,32f2 <sbrkfail+0x8e>
      read(fds[0], &scratch, 1);
    330a:	4605                	li	a2,1
    330c:	85d6                	mv	a1,s5
    330e:	fb042503          	lw	a0,-80(s0)
    3312:	00001097          	auipc	ra,0x1
    3316:	60e080e7          	jalr	1550(ra) # 4920 <read>
    331a:	bfe1                	j	32f2 <sbrkfail+0x8e>
  c = sbrk(PGSIZE);
    331c:	6505                	lui	a0,0x1
    331e:	00001097          	auipc	ra,0x1
    3322:	65a080e7          	jalr	1626(ra) # 4978 <sbrk>
    3326:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    3328:	597d                	li	s2,-1
    332a:	a021                	j	3332 <sbrkfail+0xce>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    332c:	0491                	addi	s1,s1,4
    332e:	01348f63          	beq	s1,s3,334c <sbrkfail+0xe8>
    if(pids[i] == -1)
    3332:	4088                	lw	a0,0(s1)
    3334:	ff250ce3          	beq	a0,s2,332c <sbrkfail+0xc8>
    kill(pids[i]);
    3338:	00001097          	auipc	ra,0x1
    333c:	600080e7          	jalr	1536(ra) # 4938 <kill>
    wait(0);
    3340:	4501                	li	a0,0
    3342:	00001097          	auipc	ra,0x1
    3346:	5ce080e7          	jalr	1486(ra) # 4910 <wait>
    334a:	b7cd                	j	332c <sbrkfail+0xc8>
  if(c == (char*)0xffffffffffffffffL){
    334c:	57fd                	li	a5,-1
    334e:	04fa0263          	beq	s4,a5,3392 <sbrkfail+0x12e>
  pid = fork();
    3352:	00001097          	auipc	ra,0x1
    3356:	5ae080e7          	jalr	1454(ra) # 4900 <fork>
    335a:	84aa                	mv	s1,a0
  if(pid < 0){
    335c:	04054963          	bltz	a0,33ae <sbrkfail+0x14a>
  if(pid == 0){
    3360:	c52d                	beqz	a0,33ca <sbrkfail+0x166>
  wait(&xstatus);
    3362:	fbc40513          	addi	a0,s0,-68
    3366:	00001097          	auipc	ra,0x1
    336a:	5aa080e7          	jalr	1450(ra) # 4910 <wait>
  if(xstatus != -1 && xstatus != 2)
    336e:	fbc42783          	lw	a5,-68(s0)
    3372:	577d                	li	a4,-1
    3374:	00e78563          	beq	a5,a4,337e <sbrkfail+0x11a>
    3378:	4709                	li	a4,2
    337a:	08e79d63          	bne	a5,a4,3414 <sbrkfail+0x1b0>
}
    337e:	70e6                	ld	ra,120(sp)
    3380:	7446                	ld	s0,112(sp)
    3382:	74a6                	ld	s1,104(sp)
    3384:	7906                	ld	s2,96(sp)
    3386:	69e6                	ld	s3,88(sp)
    3388:	6a46                	ld	s4,80(sp)
    338a:	6aa6                	ld	s5,72(sp)
    338c:	6b06                	ld	s6,64(sp)
    338e:	6109                	addi	sp,sp,128
    3390:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    3392:	85da                	mv	a1,s6
    3394:	00003517          	auipc	a0,0x3
    3398:	19450513          	addi	a0,a0,404 # 6528 <malloc+0x17c4>
    339c:	00002097          	auipc	ra,0x2
    33a0:	90a080e7          	jalr	-1782(ra) # 4ca6 <printf>
    exit(1);
    33a4:	4505                	li	a0,1
    33a6:	00001097          	auipc	ra,0x1
    33aa:	562080e7          	jalr	1378(ra) # 4908 <exit>
    printf("%s: fork failed\n", s);
    33ae:	85da                	mv	a1,s6
    33b0:	00002517          	auipc	a0,0x2
    33b4:	44850513          	addi	a0,a0,1096 # 57f8 <malloc+0xa94>
    33b8:	00002097          	auipc	ra,0x2
    33bc:	8ee080e7          	jalr	-1810(ra) # 4ca6 <printf>
    exit(1);
    33c0:	4505                	li	a0,1
    33c2:	00001097          	auipc	ra,0x1
    33c6:	546080e7          	jalr	1350(ra) # 4908 <exit>
    a = sbrk(0);
    33ca:	4501                	li	a0,0
    33cc:	00001097          	auipc	ra,0x1
    33d0:	5ac080e7          	jalr	1452(ra) # 4978 <sbrk>
    33d4:	892a                	mv	s2,a0
    sbrk(10*BIG);
    33d6:	3e800537          	lui	a0,0x3e800
    33da:	00001097          	auipc	ra,0x1
    33de:	59e080e7          	jalr	1438(ra) # 4978 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    33e2:	87ca                	mv	a5,s2
    33e4:	3e800737          	lui	a4,0x3e800
    33e8:	993a                	add	s2,s2,a4
    33ea:	6705                	lui	a4,0x1
      n += *(a+i);
    33ec:	0007c683          	lbu	a3,0(a5) # 6400000 <__BSS_END__+0x63f3fc8>
    33f0:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    33f2:	97ba                	add	a5,a5,a4
    33f4:	ff279ce3          	bne	a5,s2,33ec <sbrkfail+0x188>
    printf("%s: allocate a lot of memory succeeded %d\n", n);
    33f8:	85a6                	mv	a1,s1
    33fa:	00003517          	auipc	a0,0x3
    33fe:	14e50513          	addi	a0,a0,334 # 6548 <malloc+0x17e4>
    3402:	00002097          	auipc	ra,0x2
    3406:	8a4080e7          	jalr	-1884(ra) # 4ca6 <printf>
    exit(1);
    340a:	4505                	li	a0,1
    340c:	00001097          	auipc	ra,0x1
    3410:	4fc080e7          	jalr	1276(ra) # 4908 <exit>
    exit(1);
    3414:	4505                	li	a0,1
    3416:	00001097          	auipc	ra,0x1
    341a:	4f2080e7          	jalr	1266(ra) # 4908 <exit>

000000000000341e <reparent>:
{
    341e:	7179                	addi	sp,sp,-48
    3420:	f406                	sd	ra,40(sp)
    3422:	f022                	sd	s0,32(sp)
    3424:	ec26                	sd	s1,24(sp)
    3426:	e84a                	sd	s2,16(sp)
    3428:	e44e                	sd	s3,8(sp)
    342a:	e052                	sd	s4,0(sp)
    342c:	1800                	addi	s0,sp,48
    342e:	89aa                	mv	s3,a0
  int master_pid = getpid();
    3430:	00001097          	auipc	ra,0x1
    3434:	540080e7          	jalr	1344(ra) # 4970 <getpid>
    3438:	8a2a                	mv	s4,a0
    343a:	0c800913          	li	s2,200
    int pid = fork();
    343e:	00001097          	auipc	ra,0x1
    3442:	4c2080e7          	jalr	1218(ra) # 4900 <fork>
    3446:	84aa                	mv	s1,a0
    if(pid < 0){
    3448:	02054263          	bltz	a0,346c <reparent+0x4e>
    if(pid){
    344c:	cd21                	beqz	a0,34a4 <reparent+0x86>
      if(wait(0) != pid){
    344e:	4501                	li	a0,0
    3450:	00001097          	auipc	ra,0x1
    3454:	4c0080e7          	jalr	1216(ra) # 4910 <wait>
    3458:	02951863          	bne	a0,s1,3488 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    345c:	397d                	addiw	s2,s2,-1
    345e:	fe0910e3          	bnez	s2,343e <reparent+0x20>
  exit(0);
    3462:	4501                	li	a0,0
    3464:	00001097          	auipc	ra,0x1
    3468:	4a4080e7          	jalr	1188(ra) # 4908 <exit>
      printf("%s: fork failed\n", s);
    346c:	85ce                	mv	a1,s3
    346e:	00002517          	auipc	a0,0x2
    3472:	38a50513          	addi	a0,a0,906 # 57f8 <malloc+0xa94>
    3476:	00002097          	auipc	ra,0x2
    347a:	830080e7          	jalr	-2000(ra) # 4ca6 <printf>
      exit(1);
    347e:	4505                	li	a0,1
    3480:	00001097          	auipc	ra,0x1
    3484:	488080e7          	jalr	1160(ra) # 4908 <exit>
        printf("%s: wait wrong pid\n", s);
    3488:	85ce                	mv	a1,s3
    348a:	00002517          	auipc	a0,0x2
    348e:	4f650513          	addi	a0,a0,1270 # 5980 <malloc+0xc1c>
    3492:	00002097          	auipc	ra,0x2
    3496:	814080e7          	jalr	-2028(ra) # 4ca6 <printf>
        exit(1);
    349a:	4505                	li	a0,1
    349c:	00001097          	auipc	ra,0x1
    34a0:	46c080e7          	jalr	1132(ra) # 4908 <exit>
      int pid2 = fork();
    34a4:	00001097          	auipc	ra,0x1
    34a8:	45c080e7          	jalr	1116(ra) # 4900 <fork>
      if(pid2 < 0){
    34ac:	00054763          	bltz	a0,34ba <reparent+0x9c>
      exit(0);
    34b0:	4501                	li	a0,0
    34b2:	00001097          	auipc	ra,0x1
    34b6:	456080e7          	jalr	1110(ra) # 4908 <exit>
        kill(master_pid);
    34ba:	8552                	mv	a0,s4
    34bc:	00001097          	auipc	ra,0x1
    34c0:	47c080e7          	jalr	1148(ra) # 4938 <kill>
        exit(1);
    34c4:	4505                	li	a0,1
    34c6:	00001097          	auipc	ra,0x1
    34ca:	442080e7          	jalr	1090(ra) # 4908 <exit>

00000000000034ce <mem>:
{
    34ce:	7139                	addi	sp,sp,-64
    34d0:	fc06                	sd	ra,56(sp)
    34d2:	f822                	sd	s0,48(sp)
    34d4:	f426                	sd	s1,40(sp)
    34d6:	f04a                	sd	s2,32(sp)
    34d8:	ec4e                	sd	s3,24(sp)
    34da:	0080                	addi	s0,sp,64
    34dc:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    34de:	00001097          	auipc	ra,0x1
    34e2:	422080e7          	jalr	1058(ra) # 4900 <fork>
    m1 = 0;
    34e6:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    34e8:	6909                	lui	s2,0x2
    34ea:	71190913          	addi	s2,s2,1809 # 2711 <subdir+0x1b7>
  if((pid = fork()) == 0){
    34ee:	c115                	beqz	a0,3512 <mem+0x44>
    wait(&xstatus);
    34f0:	fcc40513          	addi	a0,s0,-52
    34f4:	00001097          	auipc	ra,0x1
    34f8:	41c080e7          	jalr	1052(ra) # 4910 <wait>
    if(xstatus == -1){
    34fc:	fcc42503          	lw	a0,-52(s0)
    3500:	57fd                	li	a5,-1
    3502:	06f50363          	beq	a0,a5,3568 <mem+0x9a>
    exit(xstatus);
    3506:	00001097          	auipc	ra,0x1
    350a:	402080e7          	jalr	1026(ra) # 4908 <exit>
      *(char**)m2 = m1;
    350e:	e104                	sd	s1,0(a0)
      m1 = m2;
    3510:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    3512:	854a                	mv	a0,s2
    3514:	00002097          	auipc	ra,0x2
    3518:	850080e7          	jalr	-1968(ra) # 4d64 <malloc>
    351c:	f96d                	bnez	a0,350e <mem+0x40>
    while(m1){
    351e:	c881                	beqz	s1,352e <mem+0x60>
      m2 = *(char**)m1;
    3520:	8526                	mv	a0,s1
    3522:	6084                	ld	s1,0(s1)
      free(m1);
    3524:	00001097          	auipc	ra,0x1
    3528:	7b8080e7          	jalr	1976(ra) # 4cdc <free>
    while(m1){
    352c:	f8f5                	bnez	s1,3520 <mem+0x52>
    m1 = malloc(1024*20);
    352e:	6515                	lui	a0,0x5
    3530:	00002097          	auipc	ra,0x2
    3534:	834080e7          	jalr	-1996(ra) # 4d64 <malloc>
    if(m1 == 0){
    3538:	c911                	beqz	a0,354c <mem+0x7e>
    free(m1);
    353a:	00001097          	auipc	ra,0x1
    353e:	7a2080e7          	jalr	1954(ra) # 4cdc <free>
    exit(0);
    3542:	4501                	li	a0,0
    3544:	00001097          	auipc	ra,0x1
    3548:	3c4080e7          	jalr	964(ra) # 4908 <exit>
      printf("couldn't allocate mem?!!\n", s);
    354c:	85ce                	mv	a1,s3
    354e:	00003517          	auipc	a0,0x3
    3552:	02a50513          	addi	a0,a0,42 # 6578 <malloc+0x1814>
    3556:	00001097          	auipc	ra,0x1
    355a:	750080e7          	jalr	1872(ra) # 4ca6 <printf>
      exit(1);
    355e:	4505                	li	a0,1
    3560:	00001097          	auipc	ra,0x1
    3564:	3a8080e7          	jalr	936(ra) # 4908 <exit>
      exit(0);
    3568:	4501                	li	a0,0
    356a:	00001097          	auipc	ra,0x1
    356e:	39e080e7          	jalr	926(ra) # 4908 <exit>

0000000000003572 <sharedfd>:
{
    3572:	7159                	addi	sp,sp,-112
    3574:	f486                	sd	ra,104(sp)
    3576:	f0a2                	sd	s0,96(sp)
    3578:	eca6                	sd	s1,88(sp)
    357a:	e8ca                	sd	s2,80(sp)
    357c:	e4ce                	sd	s3,72(sp)
    357e:	e0d2                	sd	s4,64(sp)
    3580:	fc56                	sd	s5,56(sp)
    3582:	f85a                	sd	s6,48(sp)
    3584:	f45e                	sd	s7,40(sp)
    3586:	f062                	sd	s8,32(sp)
    3588:	1880                	addi	s0,sp,112
    358a:	8aaa                	mv	s5,a0
  remove("sharedfd");
    358c:	00002517          	auipc	a0,0x2
    3590:	a2450513          	addi	a0,a0,-1500 # 4fb0 <malloc+0x24c>
    3594:	00001097          	auipc	ra,0x1
    3598:	41c080e7          	jalr	1052(ra) # 49b0 <remove>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    359c:	20200593          	li	a1,514
    35a0:	00002517          	auipc	a0,0x2
    35a4:	a1050513          	addi	a0,a0,-1520 # 4fb0 <malloc+0x24c>
    35a8:	00001097          	auipc	ra,0x1
    35ac:	3a0080e7          	jalr	928(ra) # 4948 <open>
  if(fd < 0){
    35b0:	04054b63          	bltz	a0,3606 <sharedfd+0x94>
    35b4:	892a                	mv	s2,a0
  pid = fork();
    35b6:	00001097          	auipc	ra,0x1
    35ba:	34a080e7          	jalr	842(ra) # 4900 <fork>
    35be:	8a2a                	mv	s4,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    35c0:	06300593          	li	a1,99
    35c4:	c119                	beqz	a0,35ca <sharedfd+0x58>
    35c6:	07000593          	li	a1,112
    35ca:	4629                	li	a2,10
    35cc:	fa040513          	addi	a0,s0,-96
    35d0:	00001097          	auipc	ra,0x1
    35d4:	120080e7          	jalr	288(ra) # 46f0 <memset>
    35d8:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    35dc:	fa040993          	addi	s3,s0,-96
    35e0:	4629                	li	a2,10
    35e2:	85ce                	mv	a1,s3
    35e4:	854a                	mv	a0,s2
    35e6:	00001097          	auipc	ra,0x1
    35ea:	342080e7          	jalr	834(ra) # 4928 <write>
    35ee:	47a9                	li	a5,10
    35f0:	02f51963          	bne	a0,a5,3622 <sharedfd+0xb0>
  for(i = 0; i < N; i++){
    35f4:	34fd                	addiw	s1,s1,-1
    35f6:	f4ed                	bnez	s1,35e0 <sharedfd+0x6e>
  if(pid == 0) {
    35f8:	040a1363          	bnez	s4,363e <sharedfd+0xcc>
    exit(0);
    35fc:	4501                	li	a0,0
    35fe:	00001097          	auipc	ra,0x1
    3602:	30a080e7          	jalr	778(ra) # 4908 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    3606:	85d6                	mv	a1,s5
    3608:	00003517          	auipc	a0,0x3
    360c:	f9050513          	addi	a0,a0,-112 # 6598 <malloc+0x1834>
    3610:	00001097          	auipc	ra,0x1
    3614:	696080e7          	jalr	1686(ra) # 4ca6 <printf>
    exit(1);
    3618:	4505                	li	a0,1
    361a:	00001097          	auipc	ra,0x1
    361e:	2ee080e7          	jalr	750(ra) # 4908 <exit>
      printf("%s: write sharedfd failed\n", s);
    3622:	85d6                	mv	a1,s5
    3624:	00003517          	auipc	a0,0x3
    3628:	f9c50513          	addi	a0,a0,-100 # 65c0 <malloc+0x185c>
    362c:	00001097          	auipc	ra,0x1
    3630:	67a080e7          	jalr	1658(ra) # 4ca6 <printf>
      exit(1);
    3634:	4505                	li	a0,1
    3636:	00001097          	auipc	ra,0x1
    363a:	2d2080e7          	jalr	722(ra) # 4908 <exit>
    wait(&xstatus);
    363e:	f9c40513          	addi	a0,s0,-100
    3642:	00001097          	auipc	ra,0x1
    3646:	2ce080e7          	jalr	718(ra) # 4910 <wait>
    if(xstatus != 0)
    364a:	f9c42983          	lw	s3,-100(s0)
    364e:	00098763          	beqz	s3,365c <sharedfd+0xea>
      exit(xstatus);
    3652:	854e                	mv	a0,s3
    3654:	00001097          	auipc	ra,0x1
    3658:	2b4080e7          	jalr	692(ra) # 4908 <exit>
  close(fd);
    365c:	854a                	mv	a0,s2
    365e:	00001097          	auipc	ra,0x1
    3662:	2d2080e7          	jalr	722(ra) # 4930 <close>
  fd = open("sharedfd", 0);
    3666:	4581                	li	a1,0
    3668:	00002517          	auipc	a0,0x2
    366c:	94850513          	addi	a0,a0,-1720 # 4fb0 <malloc+0x24c>
    3670:	00001097          	auipc	ra,0x1
    3674:	2d8080e7          	jalr	728(ra) # 4948 <open>
    3678:	8baa                	mv	s7,a0
  nc = np = 0;
    367a:	8a4e                	mv	s4,s3
  if(fd < 0){
    367c:	02054663          	bltz	a0,36a8 <sharedfd+0x136>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3680:	fa040c13          	addi	s8,s0,-96
    3684:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    3688:	06300493          	li	s1,99
      if(buf[i] == 'p')
    368c:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3690:	4629                	li	a2,10
    3692:	85e2                	mv	a1,s8
    3694:	855e                	mv	a0,s7
    3696:	00001097          	auipc	ra,0x1
    369a:	28a080e7          	jalr	650(ra) # 4920 <read>
    369e:	02a05f63          	blez	a0,36dc <sharedfd+0x16a>
    36a2:	fa040793          	addi	a5,s0,-96
    36a6:	a01d                	j	36cc <sharedfd+0x15a>
    printf("%s: cannot open sharedfd for reading\n", s);
    36a8:	85d6                	mv	a1,s5
    36aa:	00003517          	auipc	a0,0x3
    36ae:	f3650513          	addi	a0,a0,-202 # 65e0 <malloc+0x187c>
    36b2:	00001097          	auipc	ra,0x1
    36b6:	5f4080e7          	jalr	1524(ra) # 4ca6 <printf>
    exit(1);
    36ba:	4505                	li	a0,1
    36bc:	00001097          	auipc	ra,0x1
    36c0:	24c080e7          	jalr	588(ra) # 4908 <exit>
        nc++;
    36c4:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    36c6:	0785                	addi	a5,a5,1
    36c8:	fd2784e3          	beq	a5,s2,3690 <sharedfd+0x11e>
      if(buf[i] == 'c')
    36cc:	0007c703          	lbu	a4,0(a5)
    36d0:	fe970ae3          	beq	a4,s1,36c4 <sharedfd+0x152>
      if(buf[i] == 'p')
    36d4:	ff6719e3          	bne	a4,s6,36c6 <sharedfd+0x154>
        np++;
    36d8:	2a05                	addiw	s4,s4,1
    36da:	b7f5                	j	36c6 <sharedfd+0x154>
  close(fd);
    36dc:	855e                	mv	a0,s7
    36de:	00001097          	auipc	ra,0x1
    36e2:	252080e7          	jalr	594(ra) # 4930 <close>
  remove("sharedfd");
    36e6:	00002517          	auipc	a0,0x2
    36ea:	8ca50513          	addi	a0,a0,-1846 # 4fb0 <malloc+0x24c>
    36ee:	00001097          	auipc	ra,0x1
    36f2:	2c2080e7          	jalr	706(ra) # 49b0 <remove>
  if(nc == N*SZ && np == N*SZ){
    36f6:	6789                	lui	a5,0x2
    36f8:	71078793          	addi	a5,a5,1808 # 2710 <subdir+0x1b6>
    36fc:	00f99763          	bne	s3,a5,370a <sharedfd+0x198>
    3700:	6789                	lui	a5,0x2
    3702:	71078793          	addi	a5,a5,1808 # 2710 <subdir+0x1b6>
    3706:	02fa0063          	beq	s4,a5,3726 <sharedfd+0x1b4>
    printf("%s: nc/np test fails\n", s);
    370a:	85d6                	mv	a1,s5
    370c:	00003517          	auipc	a0,0x3
    3710:	efc50513          	addi	a0,a0,-260 # 6608 <malloc+0x18a4>
    3714:	00001097          	auipc	ra,0x1
    3718:	592080e7          	jalr	1426(ra) # 4ca6 <printf>
    exit(1);
    371c:	4505                	li	a0,1
    371e:	00001097          	auipc	ra,0x1
    3722:	1ea080e7          	jalr	490(ra) # 4908 <exit>
    exit(0);
    3726:	4501                	li	a0,0
    3728:	00001097          	auipc	ra,0x1
    372c:	1e0080e7          	jalr	480(ra) # 4908 <exit>

0000000000003730 <fourfiles>:
{
    3730:	7171                	addi	sp,sp,-176
    3732:	f506                	sd	ra,168(sp)
    3734:	f122                	sd	s0,160(sp)
    3736:	ed26                	sd	s1,152(sp)
    3738:	e94a                	sd	s2,144(sp)
    373a:	e54e                	sd	s3,136(sp)
    373c:	e152                	sd	s4,128(sp)
    373e:	fcd6                	sd	s5,120(sp)
    3740:	f8da                	sd	s6,112(sp)
    3742:	f4de                	sd	s7,104(sp)
    3744:	f0e2                	sd	s8,96(sp)
    3746:	ece6                	sd	s9,88(sp)
    3748:	e8ea                	sd	s10,80(sp)
    374a:	e4ee                	sd	s11,72(sp)
    374c:	1900                	addi	s0,sp,176
    374e:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = { "f0", "f1", "f2", "f3" };
    3752:	00001797          	auipc	a5,0x1
    3756:	6fe78793          	addi	a5,a5,1790 # 4e50 <malloc+0xec>
    375a:	f6f43823          	sd	a5,-144(s0)
    375e:	00001797          	auipc	a5,0x1
    3762:	6fa78793          	addi	a5,a5,1786 # 4e58 <malloc+0xf4>
    3766:	f6f43c23          	sd	a5,-136(s0)
    376a:	00001797          	auipc	a5,0x1
    376e:	6f678793          	addi	a5,a5,1782 # 4e60 <malloc+0xfc>
    3772:	f8f43023          	sd	a5,-128(s0)
    3776:	00001797          	auipc	a5,0x1
    377a:	6f278793          	addi	a5,a5,1778 # 4e68 <malloc+0x104>
    377e:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3782:	f7040c93          	addi	s9,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    3786:	8966                	mv	s2,s9
  for(pi = 0; pi < NCHILD; pi++){
    3788:	4481                	li	s1,0
    378a:	4a11                	li	s4,4
    fname = names[pi];
    378c:	00093983          	ld	s3,0(s2)
    remove(fname);
    3790:	854e                	mv	a0,s3
    3792:	00001097          	auipc	ra,0x1
    3796:	21e080e7          	jalr	542(ra) # 49b0 <remove>
    pid = fork();
    379a:	00001097          	auipc	ra,0x1
    379e:	166080e7          	jalr	358(ra) # 4900 <fork>
    if(pid < 0){
    37a2:	04054a63          	bltz	a0,37f6 <fourfiles+0xc6>
    if(pid == 0){
    37a6:	c53d                	beqz	a0,3814 <fourfiles+0xe4>
  for(pi = 0; pi < NCHILD; pi++){
    37a8:	2485                	addiw	s1,s1,1
    37aa:	0921                	addi	s2,s2,8
    37ac:	ff4490e3          	bne	s1,s4,378c <fourfiles+0x5c>
    37b0:	4491                	li	s1,4
    wait(&xstatus);
    37b2:	f6c40913          	addi	s2,s0,-148
    37b6:	854a                	mv	a0,s2
    37b8:	00001097          	auipc	ra,0x1
    37bc:	158080e7          	jalr	344(ra) # 4910 <wait>
    if(xstatus != 0)
    37c0:	f6c42b83          	lw	s7,-148(s0)
    37c4:	0e0b9363          	bnez	s7,38aa <fourfiles+0x17a>
  for(pi = 0; pi < NCHILD; pi++){
    37c8:	34fd                	addiw	s1,s1,-1
    37ca:	f4f5                	bnez	s1,37b6 <fourfiles+0x86>
    37cc:	03000c13          	li	s8,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    37d0:	6a09                	lui	s4,0x2
    37d2:	800a0a13          	addi	s4,s4,-2048 # 1800 <forkfork+0x3e>
    37d6:	00007a97          	auipc	s5,0x7
    37da:	04aa8a93          	addi	s5,s5,74 # a820 <buf>
    37de:	00007b17          	auipc	s6,0x7
    37e2:	043b0b13          	addi	s6,s6,67 # a821 <buf+0x1>
    if(total != N*SZ){
    37e6:	6785                	lui	a5,0x1
    37e8:	77078793          	addi	a5,a5,1904 # 1770 <twochildren+0x48>
    37ec:	f4f43823          	sd	a5,-176(s0)
  for(i = 0; i < NCHILD; i++){
    37f0:	03400d93          	li	s11,52
    37f4:	aa2d                	j	392e <fourfiles+0x1fe>
      printf("fork failed\n", s);
    37f6:	f5843583          	ld	a1,-168(s0)
    37fa:	00002517          	auipc	a0,0x2
    37fe:	37e50513          	addi	a0,a0,894 # 5b78 <malloc+0xe14>
    3802:	00001097          	auipc	ra,0x1
    3806:	4a4080e7          	jalr	1188(ra) # 4ca6 <printf>
      exit(1);
    380a:	4505                	li	a0,1
    380c:	00001097          	auipc	ra,0x1
    3810:	0fc080e7          	jalr	252(ra) # 4908 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3814:	20200593          	li	a1,514
    3818:	854e                	mv	a0,s3
    381a:	00001097          	auipc	ra,0x1
    381e:	12e080e7          	jalr	302(ra) # 4948 <open>
    3822:	892a                	mv	s2,a0
      if(fd < 0){
    3824:	04054763          	bltz	a0,3872 <fourfiles+0x142>
      memset(buf, '0'+pi, SZ);
    3828:	1f400613          	li	a2,500
    382c:	0304859b          	addiw	a1,s1,48
    3830:	00007517          	auipc	a0,0x7
    3834:	ff050513          	addi	a0,a0,-16 # a820 <buf>
    3838:	00001097          	auipc	ra,0x1
    383c:	eb8080e7          	jalr	-328(ra) # 46f0 <memset>
    3840:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    3842:	00007997          	auipc	s3,0x7
    3846:	fde98993          	addi	s3,s3,-34 # a820 <buf>
    384a:	1f400613          	li	a2,500
    384e:	85ce                	mv	a1,s3
    3850:	854a                	mv	a0,s2
    3852:	00001097          	auipc	ra,0x1
    3856:	0d6080e7          	jalr	214(ra) # 4928 <write>
    385a:	85aa                	mv	a1,a0
    385c:	1f400793          	li	a5,500
    3860:	02f51863          	bne	a0,a5,3890 <fourfiles+0x160>
      for(i = 0; i < N; i++){
    3864:	34fd                	addiw	s1,s1,-1
    3866:	f0f5                	bnez	s1,384a <fourfiles+0x11a>
      exit(0);
    3868:	4501                	li	a0,0
    386a:	00001097          	auipc	ra,0x1
    386e:	09e080e7          	jalr	158(ra) # 4908 <exit>
        printf("create failed\n", s);
    3872:	f5843583          	ld	a1,-168(s0)
    3876:	00003517          	auipc	a0,0x3
    387a:	daa50513          	addi	a0,a0,-598 # 6620 <malloc+0x18bc>
    387e:	00001097          	auipc	ra,0x1
    3882:	428080e7          	jalr	1064(ra) # 4ca6 <printf>
        exit(1);
    3886:	4505                	li	a0,1
    3888:	00001097          	auipc	ra,0x1
    388c:	080080e7          	jalr	128(ra) # 4908 <exit>
          printf("write failed %d\n", n);
    3890:	00003517          	auipc	a0,0x3
    3894:	da050513          	addi	a0,a0,-608 # 6630 <malloc+0x18cc>
    3898:	00001097          	auipc	ra,0x1
    389c:	40e080e7          	jalr	1038(ra) # 4ca6 <printf>
          exit(1);
    38a0:	4505                	li	a0,1
    38a2:	00001097          	auipc	ra,0x1
    38a6:	066080e7          	jalr	102(ra) # 4908 <exit>
      exit(xstatus);
    38aa:	855e                	mv	a0,s7
    38ac:	00001097          	auipc	ra,0x1
    38b0:	05c080e7          	jalr	92(ra) # 4908 <exit>
          printf("wrong char\n", s);
    38b4:	f5843583          	ld	a1,-168(s0)
    38b8:	00003517          	auipc	a0,0x3
    38bc:	d9050513          	addi	a0,a0,-624 # 6648 <malloc+0x18e4>
    38c0:	00001097          	auipc	ra,0x1
    38c4:	3e6080e7          	jalr	998(ra) # 4ca6 <printf>
          exit(1);
    38c8:	4505                	li	a0,1
    38ca:	00001097          	auipc	ra,0x1
    38ce:	03e080e7          	jalr	62(ra) # 4908 <exit>
      total += n;
    38d2:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    38d6:	8652                	mv	a2,s4
    38d8:	85d6                	mv	a1,s5
    38da:	854e                	mv	a0,s3
    38dc:	00001097          	auipc	ra,0x1
    38e0:	044080e7          	jalr	68(ra) # 4920 <read>
    38e4:	02a05363          	blez	a0,390a <fourfiles+0x1da>
    38e8:	00007797          	auipc	a5,0x7
    38ec:	f3878793          	addi	a5,a5,-200 # a820 <buf>
    38f0:	fff5069b          	addiw	a3,a0,-1
    38f4:	1682                	slli	a3,a3,0x20
    38f6:	9281                	srli	a3,a3,0x20
    38f8:	96da                	add	a3,a3,s6
        if(buf[j] != '0'+i){
    38fa:	0007c703          	lbu	a4,0(a5)
    38fe:	fa971be3          	bne	a4,s1,38b4 <fourfiles+0x184>
      for(j = 0; j < n; j++){
    3902:	0785                	addi	a5,a5,1
    3904:	fed79be3          	bne	a5,a3,38fa <fourfiles+0x1ca>
    3908:	b7e9                	j	38d2 <fourfiles+0x1a2>
    close(fd);
    390a:	854e                	mv	a0,s3
    390c:	00001097          	auipc	ra,0x1
    3910:	024080e7          	jalr	36(ra) # 4930 <close>
    if(total != N*SZ){
    3914:	f5043783          	ld	a5,-176(s0)
    3918:	02f91863          	bne	s2,a5,3948 <fourfiles+0x218>
    remove(fname);
    391c:	856a                	mv	a0,s10
    391e:	00001097          	auipc	ra,0x1
    3922:	092080e7          	jalr	146(ra) # 49b0 <remove>
  for(i = 0; i < NCHILD; i++){
    3926:	0ca1                	addi	s9,s9,8
    3928:	2c05                	addiw	s8,s8,1
    392a:	03bc0d63          	beq	s8,s11,3964 <fourfiles+0x234>
    fname = names[i];
    392e:	000cbd03          	ld	s10,0(s9)
    fd = open(fname, 0);
    3932:	4581                	li	a1,0
    3934:	856a                	mv	a0,s10
    3936:	00001097          	auipc	ra,0x1
    393a:	012080e7          	jalr	18(ra) # 4948 <open>
    393e:	89aa                	mv	s3,a0
    total = 0;
    3940:	895e                	mv	s2,s7
        if(buf[j] != '0'+i){
    3942:	000c049b          	sext.w	s1,s8
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3946:	bf41                	j	38d6 <fourfiles+0x1a6>
      printf("wrong length %d\n", total);
    3948:	85ca                	mv	a1,s2
    394a:	00003517          	auipc	a0,0x3
    394e:	d0e50513          	addi	a0,a0,-754 # 6658 <malloc+0x18f4>
    3952:	00001097          	auipc	ra,0x1
    3956:	354080e7          	jalr	852(ra) # 4ca6 <printf>
      exit(1);
    395a:	4505                	li	a0,1
    395c:	00001097          	auipc	ra,0x1
    3960:	fac080e7          	jalr	-84(ra) # 4908 <exit>
}
    3964:	70aa                	ld	ra,168(sp)
    3966:	740a                	ld	s0,160(sp)
    3968:	64ea                	ld	s1,152(sp)
    396a:	694a                	ld	s2,144(sp)
    396c:	69aa                	ld	s3,136(sp)
    396e:	6a0a                	ld	s4,128(sp)
    3970:	7ae6                	ld	s5,120(sp)
    3972:	7b46                	ld	s6,112(sp)
    3974:	7ba6                	ld	s7,104(sp)
    3976:	7c06                	ld	s8,96(sp)
    3978:	6ce6                	ld	s9,88(sp)
    397a:	6d46                	ld	s10,80(sp)
    397c:	6da6                	ld	s11,72(sp)
    397e:	614d                	addi	sp,sp,176
    3980:	8082                	ret

0000000000003982 <bigfile>:
{
    3982:	7139                	addi	sp,sp,-64
    3984:	fc06                	sd	ra,56(sp)
    3986:	f822                	sd	s0,48(sp)
    3988:	f426                	sd	s1,40(sp)
    398a:	f04a                	sd	s2,32(sp)
    398c:	ec4e                	sd	s3,24(sp)
    398e:	e852                	sd	s4,16(sp)
    3990:	e456                	sd	s5,8(sp)
    3992:	0080                	addi	s0,sp,64
    3994:	8aaa                	mv	s5,a0
  remove("bigfile.dat");
    3996:	00003517          	auipc	a0,0x3
    399a:	cda50513          	addi	a0,a0,-806 # 6670 <malloc+0x190c>
    399e:	00001097          	auipc	ra,0x1
    39a2:	012080e7          	jalr	18(ra) # 49b0 <remove>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    39a6:	20200593          	li	a1,514
    39aa:	00003517          	auipc	a0,0x3
    39ae:	cc650513          	addi	a0,a0,-826 # 6670 <malloc+0x190c>
    39b2:	00001097          	auipc	ra,0x1
    39b6:	f96080e7          	jalr	-106(ra) # 4948 <open>
    39ba:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    39bc:	4481                	li	s1,0
    memset(buf, i, SZ);
    39be:	00007917          	auipc	s2,0x7
    39c2:	e6290913          	addi	s2,s2,-414 # a820 <buf>
  for(i = 0; i < N; i++){
    39c6:	4a51                	li	s4,20
  if(fd < 0){
    39c8:	0a054063          	bltz	a0,3a68 <bigfile+0xe6>
    memset(buf, i, SZ);
    39cc:	25800613          	li	a2,600
    39d0:	85a6                	mv	a1,s1
    39d2:	854a                	mv	a0,s2
    39d4:	00001097          	auipc	ra,0x1
    39d8:	d1c080e7          	jalr	-740(ra) # 46f0 <memset>
    if(write(fd, buf, SZ) != SZ){
    39dc:	25800613          	li	a2,600
    39e0:	85ca                	mv	a1,s2
    39e2:	854e                	mv	a0,s3
    39e4:	00001097          	auipc	ra,0x1
    39e8:	f44080e7          	jalr	-188(ra) # 4928 <write>
    39ec:	25800793          	li	a5,600
    39f0:	08f51a63          	bne	a0,a5,3a84 <bigfile+0x102>
  for(i = 0; i < N; i++){
    39f4:	2485                	addiw	s1,s1,1
    39f6:	fd449be3          	bne	s1,s4,39cc <bigfile+0x4a>
  close(fd);
    39fa:	854e                	mv	a0,s3
    39fc:	00001097          	auipc	ra,0x1
    3a00:	f34080e7          	jalr	-204(ra) # 4930 <close>
  fd = open("bigfile.dat", 0);
    3a04:	4581                	li	a1,0
    3a06:	00003517          	auipc	a0,0x3
    3a0a:	c6a50513          	addi	a0,a0,-918 # 6670 <malloc+0x190c>
    3a0e:	00001097          	auipc	ra,0x1
    3a12:	f3a080e7          	jalr	-198(ra) # 4948 <open>
    3a16:	8a2a                	mv	s4,a0
  total = 0;
    3a18:	4981                	li	s3,0
  for(i = 0; ; i++){
    3a1a:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    3a1c:	00007917          	auipc	s2,0x7
    3a20:	e0490913          	addi	s2,s2,-508 # a820 <buf>
  if(fd < 0){
    3a24:	06054e63          	bltz	a0,3aa0 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    3a28:	12c00613          	li	a2,300
    3a2c:	85ca                	mv	a1,s2
    3a2e:	8552                	mv	a0,s4
    3a30:	00001097          	auipc	ra,0x1
    3a34:	ef0080e7          	jalr	-272(ra) # 4920 <read>
    if(cc < 0){
    3a38:	08054263          	bltz	a0,3abc <bigfile+0x13a>
    if(cc == 0)
    3a3c:	c971                	beqz	a0,3b10 <bigfile+0x18e>
    if(cc != SZ/2){
    3a3e:	12c00793          	li	a5,300
    3a42:	08f51b63          	bne	a0,a5,3ad8 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    3a46:	01f4d79b          	srliw	a5,s1,0x1f
    3a4a:	9fa5                	addw	a5,a5,s1
    3a4c:	4017d79b          	sraiw	a5,a5,0x1
    3a50:	00094703          	lbu	a4,0(s2)
    3a54:	0af71063          	bne	a4,a5,3af4 <bigfile+0x172>
    3a58:	12b94703          	lbu	a4,299(s2)
    3a5c:	08f71c63          	bne	a4,a5,3af4 <bigfile+0x172>
    total += cc;
    3a60:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    3a64:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    3a66:	b7c9                	j	3a28 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    3a68:	85d6                	mv	a1,s5
    3a6a:	00003517          	auipc	a0,0x3
    3a6e:	c1650513          	addi	a0,a0,-1002 # 6680 <malloc+0x191c>
    3a72:	00001097          	auipc	ra,0x1
    3a76:	234080e7          	jalr	564(ra) # 4ca6 <printf>
    exit(1);
    3a7a:	4505                	li	a0,1
    3a7c:	00001097          	auipc	ra,0x1
    3a80:	e8c080e7          	jalr	-372(ra) # 4908 <exit>
      printf("%s: write bigfile failed\n", s);
    3a84:	85d6                	mv	a1,s5
    3a86:	00003517          	auipc	a0,0x3
    3a8a:	c1a50513          	addi	a0,a0,-998 # 66a0 <malloc+0x193c>
    3a8e:	00001097          	auipc	ra,0x1
    3a92:	218080e7          	jalr	536(ra) # 4ca6 <printf>
      exit(1);
    3a96:	4505                	li	a0,1
    3a98:	00001097          	auipc	ra,0x1
    3a9c:	e70080e7          	jalr	-400(ra) # 4908 <exit>
    printf("%s: cannot open bigfile\n", s);
    3aa0:	85d6                	mv	a1,s5
    3aa2:	00003517          	auipc	a0,0x3
    3aa6:	c1e50513          	addi	a0,a0,-994 # 66c0 <malloc+0x195c>
    3aaa:	00001097          	auipc	ra,0x1
    3aae:	1fc080e7          	jalr	508(ra) # 4ca6 <printf>
    exit(1);
    3ab2:	4505                	li	a0,1
    3ab4:	00001097          	auipc	ra,0x1
    3ab8:	e54080e7          	jalr	-428(ra) # 4908 <exit>
      printf("%s: read bigfile failed\n", s);
    3abc:	85d6                	mv	a1,s5
    3abe:	00003517          	auipc	a0,0x3
    3ac2:	c2250513          	addi	a0,a0,-990 # 66e0 <malloc+0x197c>
    3ac6:	00001097          	auipc	ra,0x1
    3aca:	1e0080e7          	jalr	480(ra) # 4ca6 <printf>
      exit(1);
    3ace:	4505                	li	a0,1
    3ad0:	00001097          	auipc	ra,0x1
    3ad4:	e38080e7          	jalr	-456(ra) # 4908 <exit>
      printf("%s: short read bigfile\n", s);
    3ad8:	85d6                	mv	a1,s5
    3ada:	00003517          	auipc	a0,0x3
    3ade:	c2650513          	addi	a0,a0,-986 # 6700 <malloc+0x199c>
    3ae2:	00001097          	auipc	ra,0x1
    3ae6:	1c4080e7          	jalr	452(ra) # 4ca6 <printf>
      exit(1);
    3aea:	4505                	li	a0,1
    3aec:	00001097          	auipc	ra,0x1
    3af0:	e1c080e7          	jalr	-484(ra) # 4908 <exit>
      printf("%s: read bigfile wrong data\n", s);
    3af4:	85d6                	mv	a1,s5
    3af6:	00003517          	auipc	a0,0x3
    3afa:	c2250513          	addi	a0,a0,-990 # 6718 <malloc+0x19b4>
    3afe:	00001097          	auipc	ra,0x1
    3b02:	1a8080e7          	jalr	424(ra) # 4ca6 <printf>
      exit(1);
    3b06:	4505                	li	a0,1
    3b08:	00001097          	auipc	ra,0x1
    3b0c:	e00080e7          	jalr	-512(ra) # 4908 <exit>
  close(fd);
    3b10:	8552                	mv	a0,s4
    3b12:	00001097          	auipc	ra,0x1
    3b16:	e1e080e7          	jalr	-482(ra) # 4930 <close>
  if(total != N*SZ){
    3b1a:	678d                	lui	a5,0x3
    3b1c:	ee078793          	addi	a5,a5,-288 # 2ee0 <iref+0x110>
    3b20:	02f99363          	bne	s3,a5,3b46 <bigfile+0x1c4>
  remove("bigfile.dat");
    3b24:	00003517          	auipc	a0,0x3
    3b28:	b4c50513          	addi	a0,a0,-1204 # 6670 <malloc+0x190c>
    3b2c:	00001097          	auipc	ra,0x1
    3b30:	e84080e7          	jalr	-380(ra) # 49b0 <remove>
}
    3b34:	70e2                	ld	ra,56(sp)
    3b36:	7442                	ld	s0,48(sp)
    3b38:	74a2                	ld	s1,40(sp)
    3b3a:	7902                	ld	s2,32(sp)
    3b3c:	69e2                	ld	s3,24(sp)
    3b3e:	6a42                	ld	s4,16(sp)
    3b40:	6aa2                	ld	s5,8(sp)
    3b42:	6121                	addi	sp,sp,64
    3b44:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    3b46:	85d6                	mv	a1,s5
    3b48:	00003517          	auipc	a0,0x3
    3b4c:	bf050513          	addi	a0,a0,-1040 # 6738 <malloc+0x19d4>
    3b50:	00001097          	auipc	ra,0x1
    3b54:	156080e7          	jalr	342(ra) # 4ca6 <printf>
    exit(1);
    3b58:	4505                	li	a0,1
    3b5a:	00001097          	auipc	ra,0x1
    3b5e:	dae080e7          	jalr	-594(ra) # 4908 <exit>

0000000000003b62 <createdelete>:
{
    3b62:	7171                	addi	sp,sp,-176
    3b64:	f506                	sd	ra,168(sp)
    3b66:	f122                	sd	s0,160(sp)
    3b68:	ed26                	sd	s1,152(sp)
    3b6a:	e94a                	sd	s2,144(sp)
    3b6c:	e54e                	sd	s3,136(sp)
    3b6e:	e152                	sd	s4,128(sp)
    3b70:	fcd6                	sd	s5,120(sp)
    3b72:	f8da                	sd	s6,112(sp)
    3b74:	f4de                	sd	s7,104(sp)
    3b76:	f0e2                	sd	s8,96(sp)
    3b78:	ece6                	sd	s9,88(sp)
    3b7a:	e8ea                	sd	s10,80(sp)
    3b7c:	e4ee                	sd	s11,72(sp)
    3b7e:	1900                	addi	s0,sp,176
    3b80:	8daa                	mv	s11,a0
  char illegal[] = { '\"', '*', '/', ':', '<', '>', '?', '\\', '|', 0 };
    3b82:	00003797          	auipc	a5,0x3
    3b86:	c3e78793          	addi	a5,a5,-962 # 67c0 <malloc+0x1a5c>
    3b8a:	6398                	ld	a4,0(a5)
    3b8c:	f6e43023          	sd	a4,-160(s0)
    3b90:	0087d783          	lhu	a5,8(a5)
    3b94:	f6f41423          	sh	a5,-152(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3b98:	4901                	li	s2,0
    3b9a:	4991                	li	s3,4
    pid = fork();
    3b9c:	00001097          	auipc	ra,0x1
    3ba0:	d64080e7          	jalr	-668(ra) # 4900 <fork>
    3ba4:	84aa                	mv	s1,a0
    if(pid < 0){
    3ba6:	04054263          	bltz	a0,3bea <createdelete+0x88>
    if(pid == 0){
    3baa:	cd31                	beqz	a0,3c06 <createdelete+0xa4>
  for(pi = 0; pi < NCHILD; pi++){
    3bac:	2905                	addiw	s2,s2,1
    3bae:	ff3917e3          	bne	s2,s3,3b9c <createdelete+0x3a>
    3bb2:	4491                	li	s1,4
    wait(&xstatus);
    3bb4:	f5c40913          	addi	s2,s0,-164
    3bb8:	854a                	mv	a0,s2
    3bba:	00001097          	auipc	ra,0x1
    3bbe:	d56080e7          	jalr	-682(ra) # 4910 <wait>
    if(xstatus != 0)
    3bc2:	f5c42983          	lw	s3,-164(s0)
    3bc6:	10099963          	bnez	s3,3cd8 <createdelete+0x176>
  for(pi = 0; pi < NCHILD; pi++){
    3bca:	34fd                	addiw	s1,s1,-1
    3bcc:	f4f5                	bnez	s1,3bb8 <createdelete+0x56>
  name[0] = name[1] = name[2] = 0;
    3bce:	f6040923          	sb	zero,-142(s0)
    3bd2:	03000913          	li	s2,48
    3bd6:	5b7d                	li	s6,-1
    3bd8:	07000c93          	li	s9,112
      if (strchr(illegal, name[1]) != 0) { continue; }
    3bdc:	f6040a93          	addi	s5,s0,-160
      fd = open(name, 0);
    3be0:	f7040c13          	addi	s8,s0,-144
      } else if((i >= 1 && i < N/2) && fd >= 0){
    3be4:	4ba1                	li	s7,8
      if((i == 0 || i >= N/2) && fd < 0){
    3be6:	4d25                	li	s10,9
    3be8:	aa71                	j	3d84 <createdelete+0x222>
      printf("fork failed\n", s);
    3bea:	85ee                	mv	a1,s11
    3bec:	00002517          	auipc	a0,0x2
    3bf0:	f8c50513          	addi	a0,a0,-116 # 5b78 <malloc+0xe14>
    3bf4:	00001097          	auipc	ra,0x1
    3bf8:	0b2080e7          	jalr	178(ra) # 4ca6 <printf>
      exit(1);
    3bfc:	4505                	li	a0,1
    3bfe:	00001097          	auipc	ra,0x1
    3c02:	d0a080e7          	jalr	-758(ra) # 4908 <exit>
      name[0] = 'p' + pi;
    3c06:	0709091b          	addiw	s2,s2,112
    3c0a:	f7240823          	sb	s2,-144(s0)
      name[2] = '\0';
    3c0e:	f6040923          	sb	zero,-142(s0)
        if (strchr(illegal, name[1]) == 0) {
    3c12:	f6040913          	addi	s2,s0,-160
          fd = open(name, O_CREATE | O_RDWR);
    3c16:	f7040a13          	addi	s4,s0,-144
      for(i = 0; i < N; i++){
    3c1a:	49d1                	li	s3,20
    3c1c:	a091                	j	3c60 <createdelete+0xfe>
          fd = open(name, O_CREATE | O_RDWR);
    3c1e:	20200593          	li	a1,514
    3c22:	8552                	mv	a0,s4
    3c24:	00001097          	auipc	ra,0x1
    3c28:	d24080e7          	jalr	-732(ra) # 4948 <open>
          if(fd < 0){
    3c2c:	00054763          	bltz	a0,3c3a <createdelete+0xd8>
          close(fd);
    3c30:	00001097          	auipc	ra,0x1
    3c34:	d00080e7          	jalr	-768(ra) # 4930 <close>
    3c38:	a081                	j	3c78 <createdelete+0x116>
            printf("%s: create %s failed\n", s, name);
    3c3a:	f7040613          	addi	a2,s0,-144
    3c3e:	85ee                	mv	a1,s11
    3c40:	00003517          	auipc	a0,0x3
    3c44:	b1850513          	addi	a0,a0,-1256 # 6758 <malloc+0x19f4>
    3c48:	00001097          	auipc	ra,0x1
    3c4c:	05e080e7          	jalr	94(ra) # 4ca6 <printf>
            exit(1);
    3c50:	4505                	li	a0,1
    3c52:	00001097          	auipc	ra,0x1
    3c56:	cb6080e7          	jalr	-842(ra) # 4908 <exit>
      for(i = 0; i < N; i++){
    3c5a:	2485                	addiw	s1,s1,1
    3c5c:	07348963          	beq	s1,s3,3cce <createdelete+0x16c>
        name[1] = '0' + i;
    3c60:	0304859b          	addiw	a1,s1,48
    3c64:	0ff5f593          	andi	a1,a1,255
    3c68:	f6b408a3          	sb	a1,-143(s0)
        if (strchr(illegal, name[1]) == 0) {
    3c6c:	854a                	mv	a0,s2
    3c6e:	00001097          	auipc	ra,0x1
    3c72:	aa4080e7          	jalr	-1372(ra) # 4712 <strchr>
    3c76:	d545                	beqz	a0,3c1e <createdelete+0xbc>
        if(i > 0 && (i % 2 ) == 0){
    3c78:	fe9051e3          	blez	s1,3c5a <createdelete+0xf8>
    3c7c:	0014f793          	andi	a5,s1,1
    3c80:	ffe9                	bnez	a5,3c5a <createdelete+0xf8>
          name[1] = '0' + (i / 2);
    3c82:	01f4d59b          	srliw	a1,s1,0x1f
    3c86:	9da5                	addw	a1,a1,s1
    3c88:	4015d59b          	sraiw	a1,a1,0x1
    3c8c:	0305859b          	addiw	a1,a1,48
    3c90:	0ff5f593          	andi	a1,a1,255
    3c94:	f6b408a3          	sb	a1,-143(s0)
          if (strchr(illegal, name[1]) == 0) {
    3c98:	854a                	mv	a0,s2
    3c9a:	00001097          	auipc	ra,0x1
    3c9e:	a78080e7          	jalr	-1416(ra) # 4712 <strchr>
    3ca2:	fd45                	bnez	a0,3c5a <createdelete+0xf8>
            if(remove(name) < 0){
    3ca4:	8552                	mv	a0,s4
    3ca6:	00001097          	auipc	ra,0x1
    3caa:	d0a080e7          	jalr	-758(ra) # 49b0 <remove>
    3cae:	fa0556e3          	bgez	a0,3c5a <createdelete+0xf8>
              printf("%s: remove failed\n", s);
    3cb2:	85ee                	mv	a1,s11
    3cb4:	00002517          	auipc	a0,0x2
    3cb8:	7fc50513          	addi	a0,a0,2044 # 64b0 <malloc+0x174c>
    3cbc:	00001097          	auipc	ra,0x1
    3cc0:	fea080e7          	jalr	-22(ra) # 4ca6 <printf>
              exit(1);
    3cc4:	4505                	li	a0,1
    3cc6:	00001097          	auipc	ra,0x1
    3cca:	c42080e7          	jalr	-958(ra) # 4908 <exit>
      exit(0);
    3cce:	4501                	li	a0,0
    3cd0:	00001097          	auipc	ra,0x1
    3cd4:	c38080e7          	jalr	-968(ra) # 4908 <exit>
      exit(1);
    3cd8:	4505                	li	a0,1
    3cda:	00001097          	auipc	ra,0x1
    3cde:	c2e080e7          	jalr	-978(ra) # 4908 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    3ce2:	f7040613          	addi	a2,s0,-144
    3ce6:	85ee                	mv	a1,s11
    3ce8:	00003517          	auipc	a0,0x3
    3cec:	a8850513          	addi	a0,a0,-1400 # 6770 <malloc+0x1a0c>
    3cf0:	00001097          	auipc	ra,0x1
    3cf4:	fb6080e7          	jalr	-74(ra) # 4ca6 <printf>
        exit(1);
    3cf8:	4505                	li	a0,1
    3cfa:	00001097          	auipc	ra,0x1
    3cfe:	c0e080e7          	jalr	-1010(ra) # 4908 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    3d02:	056bf763          	bgeu	s7,s6,3d50 <createdelete+0x1ee>
      if(fd >= 0)
    3d06:	04055063          	bgez	a0,3d46 <createdelete+0x1e4>
    for(pi = 0; pi < NCHILD; pi++){
    3d0a:	2485                	addiw	s1,s1,1
    3d0c:	0ff4f493          	andi	s1,s1,255
    3d10:	07448263          	beq	s1,s4,3d74 <createdelete+0x212>
      name[0] = 'p' + pi;
    3d14:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    3d18:	f72408a3          	sb	s2,-143(s0)
      if (strchr(illegal, name[1]) != 0) { continue; }
    3d1c:	85ca                	mv	a1,s2
    3d1e:	8556                	mv	a0,s5
    3d20:	00001097          	auipc	ra,0x1
    3d24:	9f2080e7          	jalr	-1550(ra) # 4712 <strchr>
    3d28:	f16d                	bnez	a0,3d0a <createdelete+0x1a8>
      fd = open(name, 0);
    3d2a:	4581                	li	a1,0
    3d2c:	8562                	mv	a0,s8
    3d2e:	00001097          	auipc	ra,0x1
    3d32:	c1a080e7          	jalr	-998(ra) # 4948 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    3d36:	00098463          	beqz	s3,3d3e <createdelete+0x1dc>
    3d3a:	fd3d54e3          	bge	s10,s3,3d02 <createdelete+0x1a0>
    3d3e:	fa0542e3          	bltz	a0,3ce2 <createdelete+0x180>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    3d42:	016bf963          	bgeu	s7,s6,3d54 <createdelete+0x1f2>
        close(fd);
    3d46:	00001097          	auipc	ra,0x1
    3d4a:	bea080e7          	jalr	-1046(ra) # 4930 <close>
    3d4e:	bf75                	j	3d0a <createdelete+0x1a8>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    3d50:	fa054de3          	bltz	a0,3d0a <createdelete+0x1a8>
        printf("%s: oops createdelete %s did exist\n", s, name);
    3d54:	f7040613          	addi	a2,s0,-144
    3d58:	85ee                	mv	a1,s11
    3d5a:	00003517          	auipc	a0,0x3
    3d5e:	a3e50513          	addi	a0,a0,-1474 # 6798 <malloc+0x1a34>
    3d62:	00001097          	auipc	ra,0x1
    3d66:	f44080e7          	jalr	-188(ra) # 4ca6 <printf>
        exit(1);
    3d6a:	4505                	li	a0,1
    3d6c:	00001097          	auipc	ra,0x1
    3d70:	b9c080e7          	jalr	-1124(ra) # 4908 <exit>
  for(i = 0; i < N; i++){
    3d74:	2985                	addiw	s3,s3,1
    3d76:	2b05                	addiw	s6,s6,1
    3d78:	2905                	addiw	s2,s2,1
    3d7a:	0ff97913          	andi	s2,s2,255
    3d7e:	47d1                	li	a5,20
    3d80:	02f98b63          	beq	s3,a5,3db6 <createdelete+0x254>
    for(pi = 0; pi < NCHILD; pi++){
    3d84:	84e6                	mv	s1,s9
    3d86:	07400a13          	li	s4,116
    3d8a:	b769                	j	3d14 <createdelete+0x1b2>
  for(i = 0; i < N; i++){
    3d8c:	2905                	addiw	s2,s2,1
    3d8e:	0ff97913          	andi	s2,s2,255
    3d92:	03590d63          	beq	s2,s5,3dcc <createdelete+0x26a>
  name[0] = name[1] = name[2] = 0;
    3d96:	84da                	mv	s1,s6
      name[0] = 'p' + pi;
    3d98:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    3d9c:	f72408a3          	sb	s2,-143(s0)
      remove(name);
    3da0:	8552                	mv	a0,s4
    3da2:	00001097          	auipc	ra,0x1
    3da6:	c0e080e7          	jalr	-1010(ra) # 49b0 <remove>
    for(pi = 0; pi < NCHILD; pi++){
    3daa:	2485                	addiw	s1,s1,1
    3dac:	0ff4f493          	andi	s1,s1,255
    3db0:	ff3494e3          	bne	s1,s3,3d98 <createdelete+0x236>
    3db4:	bfe1                	j	3d8c <createdelete+0x22a>
    3db6:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    3dba:	07000b13          	li	s6,112
      remove(name);
    3dbe:	f7040a13          	addi	s4,s0,-144
    for(pi = 0; pi < NCHILD; pi++){
    3dc2:	07400993          	li	s3,116
  for(i = 0; i < N; i++){
    3dc6:	04400a93          	li	s5,68
    3dca:	b7f1                	j	3d96 <createdelete+0x234>
}
    3dcc:	70aa                	ld	ra,168(sp)
    3dce:	740a                	ld	s0,160(sp)
    3dd0:	64ea                	ld	s1,152(sp)
    3dd2:	694a                	ld	s2,144(sp)
    3dd4:	69aa                	ld	s3,136(sp)
    3dd6:	6a0a                	ld	s4,128(sp)
    3dd8:	7ae6                	ld	s5,120(sp)
    3dda:	7b46                	ld	s6,112(sp)
    3ddc:	7ba6                	ld	s7,104(sp)
    3dde:	7c06                	ld	s8,96(sp)
    3de0:	6ce6                	ld	s9,88(sp)
    3de2:	6d46                	ld	s10,80(sp)
    3de4:	6da6                	ld	s11,72(sp)
    3de6:	614d                	addi	sp,sp,176
    3de8:	8082                	ret

0000000000003dea <dirtest>:
{
    3dea:	1101                	addi	sp,sp,-32
    3dec:	ec06                	sd	ra,24(sp)
    3dee:	e822                	sd	s0,16(sp)
    3df0:	e426                	sd	s1,8(sp)
    3df2:	1000                	addi	s0,sp,32
    3df4:	84aa                	mv	s1,a0
  printf("mkdir test\n");
    3df6:	00003517          	auipc	a0,0x3
    3dfa:	9da50513          	addi	a0,a0,-1574 # 67d0 <malloc+0x1a6c>
    3dfe:	00001097          	auipc	ra,0x1
    3e02:	ea8080e7          	jalr	-344(ra) # 4ca6 <printf>
  if(mkdir("dir0") < 0){
    3e06:	00003517          	auipc	a0,0x3
    3e0a:	9da50513          	addi	a0,a0,-1574 # 67e0 <malloc+0x1a7c>
    3e0e:	00001097          	auipc	ra,0x1
    3e12:	b4a080e7          	jalr	-1206(ra) # 4958 <mkdir>
    3e16:	04054d63          	bltz	a0,3e70 <dirtest+0x86>
  if(chdir("dir0") < 0){
    3e1a:	00003517          	auipc	a0,0x3
    3e1e:	9c650513          	addi	a0,a0,-1594 # 67e0 <malloc+0x1a7c>
    3e22:	00001097          	auipc	ra,0x1
    3e26:	b3e080e7          	jalr	-1218(ra) # 4960 <chdir>
    3e2a:	06054163          	bltz	a0,3e8c <dirtest+0xa2>
  if(chdir("..") < 0){
    3e2e:	00002517          	auipc	a0,0x2
    3e32:	44a50513          	addi	a0,a0,1098 # 6278 <malloc+0x1514>
    3e36:	00001097          	auipc	ra,0x1
    3e3a:	b2a080e7          	jalr	-1238(ra) # 4960 <chdir>
    3e3e:	06054563          	bltz	a0,3ea8 <dirtest+0xbe>
  if(remove("dir0") < 0){
    3e42:	00003517          	auipc	a0,0x3
    3e46:	99e50513          	addi	a0,a0,-1634 # 67e0 <malloc+0x1a7c>
    3e4a:	00001097          	auipc	ra,0x1
    3e4e:	b66080e7          	jalr	-1178(ra) # 49b0 <remove>
    3e52:	06054963          	bltz	a0,3ec4 <dirtest+0xda>
  printf("%s: mkdir test ok\n");
    3e56:	00003517          	auipc	a0,0x3
    3e5a:	9da50513          	addi	a0,a0,-1574 # 6830 <malloc+0x1acc>
    3e5e:	00001097          	auipc	ra,0x1
    3e62:	e48080e7          	jalr	-440(ra) # 4ca6 <printf>
}
    3e66:	60e2                	ld	ra,24(sp)
    3e68:	6442                	ld	s0,16(sp)
    3e6a:	64a2                	ld	s1,8(sp)
    3e6c:	6105                	addi	sp,sp,32
    3e6e:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3e70:	85a6                	mv	a1,s1
    3e72:	00002517          	auipc	a0,0x2
    3e76:	f8650513          	addi	a0,a0,-122 # 5df8 <malloc+0x1094>
    3e7a:	00001097          	auipc	ra,0x1
    3e7e:	e2c080e7          	jalr	-468(ra) # 4ca6 <printf>
    exit(1);
    3e82:	4505                	li	a0,1
    3e84:	00001097          	auipc	ra,0x1
    3e88:	a84080e7          	jalr	-1404(ra) # 4908 <exit>
    printf("%s: chdir dir0 failed\n", s);
    3e8c:	85a6                	mv	a1,s1
    3e8e:	00003517          	auipc	a0,0x3
    3e92:	95a50513          	addi	a0,a0,-1702 # 67e8 <malloc+0x1a84>
    3e96:	00001097          	auipc	ra,0x1
    3e9a:	e10080e7          	jalr	-496(ra) # 4ca6 <printf>
    exit(1);
    3e9e:	4505                	li	a0,1
    3ea0:	00001097          	auipc	ra,0x1
    3ea4:	a68080e7          	jalr	-1432(ra) # 4908 <exit>
    printf("%s: chdir .. failed\n", s);
    3ea8:	85a6                	mv	a1,s1
    3eaa:	00003517          	auipc	a0,0x3
    3eae:	95650513          	addi	a0,a0,-1706 # 6800 <malloc+0x1a9c>
    3eb2:	00001097          	auipc	ra,0x1
    3eb6:	df4080e7          	jalr	-524(ra) # 4ca6 <printf>
    exit(1);
    3eba:	4505                	li	a0,1
    3ebc:	00001097          	auipc	ra,0x1
    3ec0:	a4c080e7          	jalr	-1460(ra) # 4908 <exit>
    printf("%s: remove dir0 failed\n", s);
    3ec4:	85a6                	mv	a1,s1
    3ec6:	00003517          	auipc	a0,0x3
    3eca:	95250513          	addi	a0,a0,-1710 # 6818 <malloc+0x1ab4>
    3ece:	00001097          	auipc	ra,0x1
    3ed2:	dd8080e7          	jalr	-552(ra) # 4ca6 <printf>
    exit(1);
    3ed6:	4505                	li	a0,1
    3ed8:	00001097          	auipc	ra,0x1
    3edc:	a30080e7          	jalr	-1488(ra) # 4908 <exit>

0000000000003ee0 <fourteen>:
{
    3ee0:	1101                	addi	sp,sp,-32
    3ee2:	ec06                	sd	ra,24(sp)
    3ee4:	e822                	sd	s0,16(sp)
    3ee6:	e426                	sd	s1,8(sp)
    3ee8:	1000                	addi	s0,sp,32
    3eea:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    3eec:	00003517          	auipc	a0,0x3
    3ef0:	b2c50513          	addi	a0,a0,-1236 # 6a18 <malloc+0x1cb4>
    3ef4:	00001097          	auipc	ra,0x1
    3ef8:	a64080e7          	jalr	-1436(ra) # 4958 <mkdir>
    3efc:	e165                	bnez	a0,3fdc <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    3efe:	00003517          	auipc	a0,0x3
    3f02:	97250513          	addi	a0,a0,-1678 # 6870 <malloc+0x1b0c>
    3f06:	00001097          	auipc	ra,0x1
    3f0a:	a52080e7          	jalr	-1454(ra) # 4958 <mkdir>
    3f0e:	e56d                	bnez	a0,3ff8 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    3f10:	20000593          	li	a1,512
    3f14:	00003517          	auipc	a0,0x3
    3f18:	9b450513          	addi	a0,a0,-1612 # 68c8 <malloc+0x1b64>
    3f1c:	00001097          	auipc	ra,0x1
    3f20:	a2c080e7          	jalr	-1492(ra) # 4948 <open>
  if(fd < 0){
    3f24:	0e054863          	bltz	a0,4014 <fourteen+0x134>
  close(fd);
    3f28:	00001097          	auipc	ra,0x1
    3f2c:	a08080e7          	jalr	-1528(ra) # 4930 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    3f30:	4581                	li	a1,0
    3f32:	00003517          	auipc	a0,0x3
    3f36:	a0e50513          	addi	a0,a0,-1522 # 6940 <malloc+0x1bdc>
    3f3a:	00001097          	auipc	ra,0x1
    3f3e:	a0e080e7          	jalr	-1522(ra) # 4948 <open>
  if(fd < 0){
    3f42:	0e054763          	bltz	a0,4030 <fourteen+0x150>
  close(fd);
    3f46:	00001097          	auipc	ra,0x1
    3f4a:	9ea080e7          	jalr	-1558(ra) # 4930 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    3f4e:	00003517          	auipc	a0,0x3
    3f52:	a6250513          	addi	a0,a0,-1438 # 69b0 <malloc+0x1c4c>
    3f56:	00001097          	auipc	ra,0x1
    3f5a:	a02080e7          	jalr	-1534(ra) # 4958 <mkdir>
    3f5e:	c57d                	beqz	a0,404c <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    3f60:	00003517          	auipc	a0,0x3
    3f64:	aa850513          	addi	a0,a0,-1368 # 6a08 <malloc+0x1ca4>
    3f68:	00001097          	auipc	ra,0x1
    3f6c:	9f0080e7          	jalr	-1552(ra) # 4958 <mkdir>
    3f70:	cd65                	beqz	a0,4068 <fourteen+0x188>
  remove("123456789012345/12345678901234");
    3f72:	00003517          	auipc	a0,0x3
    3f76:	a9650513          	addi	a0,a0,-1386 # 6a08 <malloc+0x1ca4>
    3f7a:	00001097          	auipc	ra,0x1
    3f7e:	a36080e7          	jalr	-1482(ra) # 49b0 <remove>
  remove("12345678901234/12345678901234");
    3f82:	00003517          	auipc	a0,0x3
    3f86:	a2e50513          	addi	a0,a0,-1490 # 69b0 <malloc+0x1c4c>
    3f8a:	00001097          	auipc	ra,0x1
    3f8e:	a26080e7          	jalr	-1498(ra) # 49b0 <remove>
  remove("12345678901234/12345678901234/12345678901234");
    3f92:	00003517          	auipc	a0,0x3
    3f96:	9ae50513          	addi	a0,a0,-1618 # 6940 <malloc+0x1bdc>
    3f9a:	00001097          	auipc	ra,0x1
    3f9e:	a16080e7          	jalr	-1514(ra) # 49b0 <remove>
  remove("123456789012345/123456789012345/123456789012345");
    3fa2:	00003517          	auipc	a0,0x3
    3fa6:	92650513          	addi	a0,a0,-1754 # 68c8 <malloc+0x1b64>
    3faa:	00001097          	auipc	ra,0x1
    3fae:	a06080e7          	jalr	-1530(ra) # 49b0 <remove>
  remove("12345678901234/123456789012345");
    3fb2:	00003517          	auipc	a0,0x3
    3fb6:	8be50513          	addi	a0,a0,-1858 # 6870 <malloc+0x1b0c>
    3fba:	00001097          	auipc	ra,0x1
    3fbe:	9f6080e7          	jalr	-1546(ra) # 49b0 <remove>
  remove("12345678901234");
    3fc2:	00003517          	auipc	a0,0x3
    3fc6:	a5650513          	addi	a0,a0,-1450 # 6a18 <malloc+0x1cb4>
    3fca:	00001097          	auipc	ra,0x1
    3fce:	9e6080e7          	jalr	-1562(ra) # 49b0 <remove>
}
    3fd2:	60e2                	ld	ra,24(sp)
    3fd4:	6442                	ld	s0,16(sp)
    3fd6:	64a2                	ld	s1,8(sp)
    3fd8:	6105                	addi	sp,sp,32
    3fda:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    3fdc:	85a6                	mv	a1,s1
    3fde:	00003517          	auipc	a0,0x3
    3fe2:	86a50513          	addi	a0,a0,-1942 # 6848 <malloc+0x1ae4>
    3fe6:	00001097          	auipc	ra,0x1
    3fea:	cc0080e7          	jalr	-832(ra) # 4ca6 <printf>
    exit(1);
    3fee:	4505                	li	a0,1
    3ff0:	00001097          	auipc	ra,0x1
    3ff4:	918080e7          	jalr	-1768(ra) # 4908 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    3ff8:	85a6                	mv	a1,s1
    3ffa:	00003517          	auipc	a0,0x3
    3ffe:	89650513          	addi	a0,a0,-1898 # 6890 <malloc+0x1b2c>
    4002:	00001097          	auipc	ra,0x1
    4006:	ca4080e7          	jalr	-860(ra) # 4ca6 <printf>
    exit(1);
    400a:	4505                	li	a0,1
    400c:	00001097          	auipc	ra,0x1
    4010:	8fc080e7          	jalr	-1796(ra) # 4908 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    4014:	85a6                	mv	a1,s1
    4016:	00003517          	auipc	a0,0x3
    401a:	8e250513          	addi	a0,a0,-1822 # 68f8 <malloc+0x1b94>
    401e:	00001097          	auipc	ra,0x1
    4022:	c88080e7          	jalr	-888(ra) # 4ca6 <printf>
    exit(1);
    4026:	4505                	li	a0,1
    4028:	00001097          	auipc	ra,0x1
    402c:	8e0080e7          	jalr	-1824(ra) # 4908 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    4030:	85a6                	mv	a1,s1
    4032:	00003517          	auipc	a0,0x3
    4036:	93e50513          	addi	a0,a0,-1730 # 6970 <malloc+0x1c0c>
    403a:	00001097          	auipc	ra,0x1
    403e:	c6c080e7          	jalr	-916(ra) # 4ca6 <printf>
    exit(1);
    4042:	4505                	li	a0,1
    4044:	00001097          	auipc	ra,0x1
    4048:	8c4080e7          	jalr	-1852(ra) # 4908 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    404c:	85a6                	mv	a1,s1
    404e:	00003517          	auipc	a0,0x3
    4052:	98250513          	addi	a0,a0,-1662 # 69d0 <malloc+0x1c6c>
    4056:	00001097          	auipc	ra,0x1
    405a:	c50080e7          	jalr	-944(ra) # 4ca6 <printf>
    exit(1);
    405e:	4505                	li	a0,1
    4060:	00001097          	auipc	ra,0x1
    4064:	8a8080e7          	jalr	-1880(ra) # 4908 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    4068:	85a6                	mv	a1,s1
    406a:	00003517          	auipc	a0,0x3
    406e:	9be50513          	addi	a0,a0,-1602 # 6a28 <malloc+0x1cc4>
    4072:	00001097          	auipc	ra,0x1
    4076:	c34080e7          	jalr	-972(ra) # 4ca6 <printf>
    exit(1);
    407a:	4505                	li	a0,1
    407c:	00001097          	auipc	ra,0x1
    4080:	88c080e7          	jalr	-1908(ra) # 4908 <exit>

0000000000004084 <fsfull>:
{
    4084:	7171                	addi	sp,sp,-176
    4086:	f506                	sd	ra,168(sp)
    4088:	f122                	sd	s0,160(sp)
    408a:	ed26                	sd	s1,152(sp)
    408c:	e94a                	sd	s2,144(sp)
    408e:	e54e                	sd	s3,136(sp)
    4090:	e152                	sd	s4,128(sp)
    4092:	fcd6                	sd	s5,120(sp)
    4094:	f8da                	sd	s6,112(sp)
    4096:	f4de                	sd	s7,104(sp)
    4098:	f0e2                	sd	s8,96(sp)
    409a:	ece6                	sd	s9,88(sp)
    409c:	e8ea                	sd	s10,80(sp)
    409e:	e4ee                	sd	s11,72(sp)
    40a0:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    40a2:	00003517          	auipc	a0,0x3
    40a6:	9be50513          	addi	a0,a0,-1602 # 6a60 <malloc+0x1cfc>
    40aa:	00001097          	auipc	ra,0x1
    40ae:	bfc080e7          	jalr	-1028(ra) # 4ca6 <printf>
  for(nfiles = 0; ; nfiles++){
    40b2:	4481                	li	s1,0
    name[0] = 'f';
    40b4:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    40b8:	3e800c93          	li	s9,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    40bc:	06400c13          	li	s8,100
    name[3] = '0' + (nfiles % 100) / 10;
    40c0:	4ba9                	li	s7,10
    printf("%s: writing %s\n", name);
    40c2:	f5040b13          	addi	s6,s0,-176
    40c6:	00003d17          	auipc	s10,0x3
    40ca:	9aad0d13          	addi	s10,s10,-1622 # 6a70 <malloc+0x1d0c>
      int cc = write(fd, buf, BSIZE);
    40ce:	00006a17          	auipc	s4,0x6
    40d2:	752a0a13          	addi	s4,s4,1874 # a820 <buf>
    name[0] = 'f';
    40d6:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    40da:	0394c7bb          	divw	a5,s1,s9
    40de:	0307879b          	addiw	a5,a5,48
    40e2:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    40e6:	0394e7bb          	remw	a5,s1,s9
    40ea:	0387c7bb          	divw	a5,a5,s8
    40ee:	0307879b          	addiw	a5,a5,48
    40f2:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    40f6:	0384e7bb          	remw	a5,s1,s8
    40fa:	0377c7bb          	divw	a5,a5,s7
    40fe:	0307879b          	addiw	a5,a5,48
    4102:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4106:	0374e7bb          	remw	a5,s1,s7
    410a:	0307879b          	addiw	a5,a5,48
    410e:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4112:	f4040aa3          	sb	zero,-171(s0)
    printf("%s: writing %s\n", name);
    4116:	85da                	mv	a1,s6
    4118:	856a                	mv	a0,s10
    411a:	00001097          	auipc	ra,0x1
    411e:	b8c080e7          	jalr	-1140(ra) # 4ca6 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4122:	20200593          	li	a1,514
    4126:	855a                	mv	a0,s6
    4128:	00001097          	auipc	ra,0x1
    412c:	820080e7          	jalr	-2016(ra) # 4948 <open>
    4130:	892a                	mv	s2,a0
    if(fd < 0){
    4132:	0a055763          	bgez	a0,41e0 <fsfull+0x15c>
      printf("%s: open %s failed\n", name);
    4136:	f5040593          	addi	a1,s0,-176
    413a:	00003517          	auipc	a0,0x3
    413e:	94650513          	addi	a0,a0,-1722 # 6a80 <malloc+0x1d1c>
    4142:	00001097          	auipc	ra,0x1
    4146:	b64080e7          	jalr	-1180(ra) # 4ca6 <printf>
  while(nfiles >= 0){
    414a:	0604c463          	bltz	s1,41b2 <fsfull+0x12e>
    name[0] = 'f';
    414e:	06600b93          	li	s7,102
    name[1] = '0' + nfiles / 1000;
    4152:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4156:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    415a:	4929                	li	s2,10
    remove(name);
    415c:	f5040b13          	addi	s6,s0,-176
  while(nfiles >= 0){
    4160:	5afd                	li	s5,-1
    name[0] = 'f';
    4162:	f5740823          	sb	s7,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4166:	0344c7bb          	divw	a5,s1,s4
    416a:	0307879b          	addiw	a5,a5,48
    416e:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4172:	0344e7bb          	remw	a5,s1,s4
    4176:	0337c7bb          	divw	a5,a5,s3
    417a:	0307879b          	addiw	a5,a5,48
    417e:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4182:	0334e7bb          	remw	a5,s1,s3
    4186:	0327c7bb          	divw	a5,a5,s2
    418a:	0307879b          	addiw	a5,a5,48
    418e:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4192:	0324e7bb          	remw	a5,s1,s2
    4196:	0307879b          	addiw	a5,a5,48
    419a:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    419e:	f4040aa3          	sb	zero,-171(s0)
    remove(name);
    41a2:	855a                	mv	a0,s6
    41a4:	00001097          	auipc	ra,0x1
    41a8:	80c080e7          	jalr	-2036(ra) # 49b0 <remove>
    nfiles--;
    41ac:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    41ae:	fb549ae3          	bne	s1,s5,4162 <fsfull+0xde>
  printf("fsfull test finished\n");
    41b2:	00003517          	auipc	a0,0x3
    41b6:	8fe50513          	addi	a0,a0,-1794 # 6ab0 <malloc+0x1d4c>
    41ba:	00001097          	auipc	ra,0x1
    41be:	aec080e7          	jalr	-1300(ra) # 4ca6 <printf>
}
    41c2:	70aa                	ld	ra,168(sp)
    41c4:	740a                	ld	s0,160(sp)
    41c6:	64ea                	ld	s1,152(sp)
    41c8:	694a                	ld	s2,144(sp)
    41ca:	69aa                	ld	s3,136(sp)
    41cc:	6a0a                	ld	s4,128(sp)
    41ce:	7ae6                	ld	s5,120(sp)
    41d0:	7b46                	ld	s6,112(sp)
    41d2:	7ba6                	ld	s7,104(sp)
    41d4:	7c06                	ld	s8,96(sp)
    41d6:	6ce6                	ld	s9,88(sp)
    41d8:	6d46                	ld	s10,80(sp)
    41da:	6da6                	ld	s11,72(sp)
    41dc:	614d                	addi	sp,sp,176
    41de:	8082                	ret
    int total = 0;
    41e0:	4981                	li	s3,0
      if(cc < BSIZE)
    41e2:	1ff00a93          	li	s5,511
      int cc = write(fd, buf, BSIZE);
    41e6:	20000613          	li	a2,512
    41ea:	85d2                	mv	a1,s4
    41ec:	854a                	mv	a0,s2
    41ee:	00000097          	auipc	ra,0x0
    41f2:	73a080e7          	jalr	1850(ra) # 4928 <write>
      if(cc < BSIZE)
    41f6:	00aad563          	bge	s5,a0,4200 <fsfull+0x17c>
      total += cc;
    41fa:	00a989bb          	addw	s3,s3,a0
    while(1){
    41fe:	b7e5                	j	41e6 <fsfull+0x162>
    printf("%s: wrote %d bytes\n", total);
    4200:	85ce                	mv	a1,s3
    4202:	00003517          	auipc	a0,0x3
    4206:	89650513          	addi	a0,a0,-1898 # 6a98 <malloc+0x1d34>
    420a:	00001097          	auipc	ra,0x1
    420e:	a9c080e7          	jalr	-1380(ra) # 4ca6 <printf>
    close(fd);
    4212:	854a                	mv	a0,s2
    4214:	00000097          	auipc	ra,0x0
    4218:	71c080e7          	jalr	1820(ra) # 4930 <close>
    if(total == 0)
    421c:	f20987e3          	beqz	s3,414a <fsfull+0xc6>
  for(nfiles = 0; ; nfiles++){
    4220:	2485                	addiw	s1,s1,1
    4222:	bd55                	j	40d6 <fsfull+0x52>

0000000000004224 <rand>:
{
    4224:	1141                	addi	sp,sp,-16
    4226:	e422                	sd	s0,8(sp)
    4228:	0800                	addi	s0,sp,16
  randstate = randstate * 1664525 + 1013904223;
    422a:	00003717          	auipc	a4,0x3
    422e:	a6e70713          	addi	a4,a4,-1426 # 6c98 <__DATA_BEGIN__>
    4232:	7308                	ld	a0,32(a4)
    4234:	001967b7          	lui	a5,0x196
    4238:	60d78793          	addi	a5,a5,1549 # 19660d <__BSS_END__+0x18a5d5>
    423c:	02f50533          	mul	a0,a0,a5
    4240:	3c6ef7b7          	lui	a5,0x3c6ef
    4244:	35f78793          	addi	a5,a5,863 # 3c6ef35f <__BSS_END__+0x3c6e3327>
    4248:	953e                	add	a0,a0,a5
    424a:	f308                	sd	a0,32(a4)
}
    424c:	2501                	sext.w	a0,a0
    424e:	6422                	ld	s0,8(sp)
    4250:	0141                	addi	sp,sp,16
    4252:	8082                	ret

0000000000004254 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    4254:	7139                	addi	sp,sp,-64
    4256:	fc06                	sd	ra,56(sp)
    4258:	f822                	sd	s0,48(sp)
    425a:	f426                	sd	s1,40(sp)
    425c:	f04a                	sd	s2,32(sp)
    425e:	ec4e                	sd	s3,24(sp)
    4260:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    4262:	fc840513          	addi	a0,s0,-56
    4266:	00000097          	auipc	ra,0x0
    426a:	6b2080e7          	jalr	1714(ra) # 4918 <pipe>
    426e:	06054763          	bltz	a0,42dc <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    4272:	00000097          	auipc	ra,0x0
    4276:	68e080e7          	jalr	1678(ra) # 4900 <fork>

  if(pid < 0){
    427a:	06054e63          	bltz	a0,42f6 <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    427e:	ed51                	bnez	a0,431a <countfree+0xc6>
    close(fds[0]);
    4280:	fc842503          	lw	a0,-56(s0)
    4284:	00000097          	auipc	ra,0x0
    4288:	6ac080e7          	jalr	1708(ra) # 4930 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    428c:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    428e:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    4290:	00001997          	auipc	s3,0x1
    4294:	f6898993          	addi	s3,s3,-152 # 51f8 <malloc+0x494>
      uint64 a = (uint64) sbrk(4096);
    4298:	6505                	lui	a0,0x1
    429a:	00000097          	auipc	ra,0x0
    429e:	6de080e7          	jalr	1758(ra) # 4978 <sbrk>
      if(a == 0xffffffffffffffff){
    42a2:	07250763          	beq	a0,s2,4310 <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    42a6:	6785                	lui	a5,0x1
    42a8:	953e                	add	a0,a0,a5
    42aa:	fe950fa3          	sb	s1,-1(a0) # fff <copyinstr2+0xbb>
      if(write(fds[1], "x", 1) != 1){
    42ae:	8626                	mv	a2,s1
    42b0:	85ce                	mv	a1,s3
    42b2:	fcc42503          	lw	a0,-52(s0)
    42b6:	00000097          	auipc	ra,0x0
    42ba:	672080e7          	jalr	1650(ra) # 4928 <write>
    42be:	fc950de3          	beq	a0,s1,4298 <countfree+0x44>
        printf("write() failed in countfree()\n");
    42c2:	00003517          	auipc	a0,0x3
    42c6:	84650513          	addi	a0,a0,-1978 # 6b08 <malloc+0x1da4>
    42ca:	00001097          	auipc	ra,0x1
    42ce:	9dc080e7          	jalr	-1572(ra) # 4ca6 <printf>
        exit(1);
    42d2:	4505                	li	a0,1
    42d4:	00000097          	auipc	ra,0x0
    42d8:	634080e7          	jalr	1588(ra) # 4908 <exit>
    printf("pipe() failed in countfree()\n");
    42dc:	00002517          	auipc	a0,0x2
    42e0:	7ec50513          	addi	a0,a0,2028 # 6ac8 <malloc+0x1d64>
    42e4:	00001097          	auipc	ra,0x1
    42e8:	9c2080e7          	jalr	-1598(ra) # 4ca6 <printf>
    exit(1);
    42ec:	4505                	li	a0,1
    42ee:	00000097          	auipc	ra,0x0
    42f2:	61a080e7          	jalr	1562(ra) # 4908 <exit>
    printf("fork failed in countfree()\n");
    42f6:	00002517          	auipc	a0,0x2
    42fa:	7f250513          	addi	a0,a0,2034 # 6ae8 <malloc+0x1d84>
    42fe:	00001097          	auipc	ra,0x1
    4302:	9a8080e7          	jalr	-1624(ra) # 4ca6 <printf>
    exit(1);
    4306:	4505                	li	a0,1
    4308:	00000097          	auipc	ra,0x0
    430c:	600080e7          	jalr	1536(ra) # 4908 <exit>
      }
    }

    exit(0);
    4310:	4501                	li	a0,0
    4312:	00000097          	auipc	ra,0x0
    4316:	5f6080e7          	jalr	1526(ra) # 4908 <exit>
  }

  close(fds[1]);
    431a:	fcc42503          	lw	a0,-52(s0)
    431e:	00000097          	auipc	ra,0x0
    4322:	612080e7          	jalr	1554(ra) # 4930 <close>

  int n = 0;
    4326:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    4328:	fc740913          	addi	s2,s0,-57
    432c:	4605                	li	a2,1
    432e:	85ca                	mv	a1,s2
    4330:	fc842503          	lw	a0,-56(s0)
    4334:	00000097          	auipc	ra,0x0
    4338:	5ec080e7          	jalr	1516(ra) # 4920 <read>
    if(cc < 0){
    433c:	00054563          	bltz	a0,4346 <countfree+0xf2>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    4340:	c105                	beqz	a0,4360 <countfree+0x10c>
      break;
    n += 1;
    4342:	2485                	addiw	s1,s1,1
  while(1){
    4344:	b7e5                	j	432c <countfree+0xd8>
      printf("read() failed in countfree()\n");
    4346:	00002517          	auipc	a0,0x2
    434a:	7e250513          	addi	a0,a0,2018 # 6b28 <malloc+0x1dc4>
    434e:	00001097          	auipc	ra,0x1
    4352:	958080e7          	jalr	-1704(ra) # 4ca6 <printf>
      exit(1);
    4356:	4505                	li	a0,1
    4358:	00000097          	auipc	ra,0x0
    435c:	5b0080e7          	jalr	1456(ra) # 4908 <exit>
  }

  close(fds[0]);
    4360:	fc842503          	lw	a0,-56(s0)
    4364:	00000097          	auipc	ra,0x0
    4368:	5cc080e7          	jalr	1484(ra) # 4930 <close>
  wait((int*)0);
    436c:	4501                	li	a0,0
    436e:	00000097          	auipc	ra,0x0
    4372:	5a2080e7          	jalr	1442(ra) # 4910 <wait>
  
  return n;
}
    4376:	8526                	mv	a0,s1
    4378:	70e2                	ld	ra,56(sp)
    437a:	7442                	ld	s0,48(sp)
    437c:	74a2                	ld	s1,40(sp)
    437e:	7902                	ld	s2,32(sp)
    4380:	69e2                	ld	s3,24(sp)
    4382:	6121                	addi	sp,sp,64
    4384:	8082                	ret

0000000000004386 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    4386:	7179                	addi	sp,sp,-48
    4388:	f406                	sd	ra,40(sp)
    438a:	f022                	sd	s0,32(sp)
    438c:	ec26                	sd	s1,24(sp)
    438e:	e84a                	sd	s2,16(sp)
    4390:	1800                	addi	s0,sp,48
    4392:	84aa                	mv	s1,a0
    4394:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    4396:	00002517          	auipc	a0,0x2
    439a:	7b250513          	addi	a0,a0,1970 # 6b48 <malloc+0x1de4>
    439e:	00001097          	auipc	ra,0x1
    43a2:	908080e7          	jalr	-1784(ra) # 4ca6 <printf>
  if((pid = fork()) < 0) {
    43a6:	00000097          	auipc	ra,0x0
    43aa:	55a080e7          	jalr	1370(ra) # 4900 <fork>
    43ae:	02054e63          	bltz	a0,43ea <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    43b2:	c929                	beqz	a0,4404 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    43b4:	fdc40513          	addi	a0,s0,-36
    43b8:	00000097          	auipc	ra,0x0
    43bc:	558080e7          	jalr	1368(ra) # 4910 <wait>
    if(xstatus != 0) 
    43c0:	fdc42783          	lw	a5,-36(s0)
    43c4:	c7b9                	beqz	a5,4412 <run+0x8c>
      printf("FAILED\n");
    43c6:	00002517          	auipc	a0,0x2
    43ca:	7aa50513          	addi	a0,a0,1962 # 6b70 <malloc+0x1e0c>
    43ce:	00001097          	auipc	ra,0x1
    43d2:	8d8080e7          	jalr	-1832(ra) # 4ca6 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    43d6:	fdc42503          	lw	a0,-36(s0)
  }
}
    43da:	00153513          	seqz	a0,a0
    43de:	70a2                	ld	ra,40(sp)
    43e0:	7402                	ld	s0,32(sp)
    43e2:	64e2                	ld	s1,24(sp)
    43e4:	6942                	ld	s2,16(sp)
    43e6:	6145                	addi	sp,sp,48
    43e8:	8082                	ret
    printf("runtest: fork error\n");
    43ea:	00002517          	auipc	a0,0x2
    43ee:	76e50513          	addi	a0,a0,1902 # 6b58 <malloc+0x1df4>
    43f2:	00001097          	auipc	ra,0x1
    43f6:	8b4080e7          	jalr	-1868(ra) # 4ca6 <printf>
    exit(1);
    43fa:	4505                	li	a0,1
    43fc:	00000097          	auipc	ra,0x0
    4400:	50c080e7          	jalr	1292(ra) # 4908 <exit>
    f(s);
    4404:	854a                	mv	a0,s2
    4406:	9482                	jalr	s1
    exit(0);
    4408:	4501                	li	a0,0
    440a:	00000097          	auipc	ra,0x0
    440e:	4fe080e7          	jalr	1278(ra) # 4908 <exit>
      printf("OK\n");
    4412:	00002517          	auipc	a0,0x2
    4416:	76650513          	addi	a0,a0,1894 # 6b78 <malloc+0x1e14>
    441a:	00001097          	auipc	ra,0x1
    441e:	88c080e7          	jalr	-1908(ra) # 4ca6 <printf>
    4422:	bf55                	j	43d6 <run+0x50>

0000000000004424 <main>:

int
main(int argc, char *argv[])
{
    4424:	c8010113          	addi	sp,sp,-896
    4428:	36113c23          	sd	ra,888(sp)
    442c:	36813823          	sd	s0,880(sp)
    4430:	36913423          	sd	s1,872(sp)
    4434:	37213023          	sd	s2,864(sp)
    4438:	35313c23          	sd	s3,856(sp)
    443c:	35413823          	sd	s4,848(sp)
    4440:	35513423          	sd	s5,840(sp)
    4444:	35613023          	sd	s6,832(sp)
    4448:	0700                	addi	s0,sp,896
    444a:	89aa                	mv	s3,a0
  int continuous = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    444c:	4789                	li	a5,2
    444e:	08f50763          	beq	a0,a5,44dc <main+0xb8>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    4452:	4785                	li	a5,1
  char *justone = 0;
    4454:	4901                	li	s2,0
  } else if(argc > 1){
    4456:	0ca7c163          	blt	a5,a0,4518 <main+0xf4>
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    445a:	00003797          	auipc	a5,0x3
    445e:	86678793          	addi	a5,a5,-1946 # 6cc0 <randstate+0x8>
    4462:	c8040713          	addi	a4,s0,-896
    4466:	00003817          	auipc	a6,0x3
    446a:	b9a80813          	addi	a6,a6,-1126 # 7000 <name>
    446e:	6388                	ld	a0,0(a5)
    4470:	678c                	ld	a1,8(a5)
    4472:	6b90                	ld	a2,16(a5)
    4474:	6f94                	ld	a3,24(a5)
    4476:	e308                	sd	a0,0(a4)
    4478:	e70c                	sd	a1,8(a4)
    447a:	eb10                	sd	a2,16(a4)
    447c:	ef14                	sd	a3,24(a4)
    447e:	02078793          	addi	a5,a5,32
    4482:	02070713          	addi	a4,a4,32
    4486:	ff0794e3          	bne	a5,a6,446e <main+0x4a>
          exit(1);
      }
    }
  }

  printf("usertests starting\n");
    448a:	00002517          	auipc	a0,0x2
    448e:	7a650513          	addi	a0,a0,1958 # 6c30 <malloc+0x1ecc>
    4492:	00001097          	auipc	ra,0x1
    4496:	814080e7          	jalr	-2028(ra) # 4ca6 <printf>
  int free0 = countfree();
    449a:	00000097          	auipc	ra,0x0
    449e:	dba080e7          	jalr	-582(ra) # 4254 <countfree>
    44a2:	8a2a                	mv	s4,a0
  int free1 = 0;
  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    44a4:	c8843503          	ld	a0,-888(s0)
    44a8:	c8040493          	addi	s1,s0,-896
  int fail = 0;
    44ac:	4981                	li	s3,0
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s))
        fail = 1;
    44ae:	4a85                	li	s5,1
  for (struct test *t = tests; t->s != 0; t++) {
    44b0:	e55d                	bnez	a0,455e <main+0x13a>
  }

  if(fail){
    printf("SOME TESTS FAILED\n");
    exit(1);
  } else if((free1 = countfree()) < free0){
    44b2:	00000097          	auipc	ra,0x0
    44b6:	da2080e7          	jalr	-606(ra) # 4254 <countfree>
    44ba:	85aa                	mv	a1,a0
    44bc:	0f455163          	bge	a0,s4,459e <main+0x17a>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    44c0:	8652                	mv	a2,s4
    44c2:	00002517          	auipc	a0,0x2
    44c6:	72650513          	addi	a0,a0,1830 # 6be8 <malloc+0x1e84>
    44ca:	00000097          	auipc	ra,0x0
    44ce:	7dc080e7          	jalr	2012(ra) # 4ca6 <printf>
    exit(1);
    44d2:	4505                	li	a0,1
    44d4:	00000097          	auipc	ra,0x0
    44d8:	434080e7          	jalr	1076(ra) # 4908 <exit>
    44dc:	84ae                	mv	s1,a1
  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    44de:	00002597          	auipc	a1,0x2
    44e2:	6a258593          	addi	a1,a1,1698 # 6b80 <malloc+0x1e1c>
    44e6:	6488                	ld	a0,8(s1)
    44e8:	00000097          	auipc	ra,0x0
    44ec:	1b2080e7          	jalr	434(ra) # 469a <strcmp>
    44f0:	10050563          	beqz	a0,45fa <main+0x1d6>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    44f4:	00002597          	auipc	a1,0x2
    44f8:	77458593          	addi	a1,a1,1908 # 6c68 <malloc+0x1f04>
    44fc:	6488                	ld	a0,8(s1)
    44fe:	00000097          	auipc	ra,0x0
    4502:	19c080e7          	jalr	412(ra) # 469a <strcmp>
    4506:	c97d                	beqz	a0,45fc <main+0x1d8>
  } else if(argc == 2 && argv[1][0] != '-'){
    4508:	0084b903          	ld	s2,8(s1)
    450c:	00094703          	lbu	a4,0(s2)
    4510:	02d00793          	li	a5,45
    4514:	f4f713e3          	bne	a4,a5,445a <main+0x36>
    printf("Usage: usertests [-c] [testname]\n");
    4518:	00002517          	auipc	a0,0x2
    451c:	67050513          	addi	a0,a0,1648 # 6b88 <malloc+0x1e24>
    4520:	00000097          	auipc	ra,0x0
    4524:	786080e7          	jalr	1926(ra) # 4ca6 <printf>
    exit(1);
    4528:	4505                	li	a0,1
    452a:	00000097          	auipc	ra,0x0
    452e:	3de080e7          	jalr	990(ra) # 4908 <exit>
          exit(1);
    4532:	4505                	li	a0,1
    4534:	00000097          	auipc	ra,0x0
    4538:	3d4080e7          	jalr	980(ra) # 4908 <exit>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    453c:	40a905bb          	subw	a1,s2,a0
    4540:	855a                	mv	a0,s6
    4542:	00000097          	auipc	ra,0x0
    4546:	764080e7          	jalr	1892(ra) # 4ca6 <printf>
        if(continuous != 2)
    454a:	09498463          	beq	s3,s4,45d2 <main+0x1ae>
          exit(1);
    454e:	4505                	li	a0,1
    4550:	00000097          	auipc	ra,0x0
    4554:	3b8080e7          	jalr	952(ra) # 4908 <exit>
  for (struct test *t = tests; t->s != 0; t++) {
    4558:	04c1                	addi	s1,s1,16
    455a:	6488                	ld	a0,8(s1)
    455c:	c115                	beqz	a0,4580 <main+0x15c>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    455e:	00090863          	beqz	s2,456e <main+0x14a>
    4562:	85ca                	mv	a1,s2
    4564:	00000097          	auipc	ra,0x0
    4568:	136080e7          	jalr	310(ra) # 469a <strcmp>
    456c:	f575                	bnez	a0,4558 <main+0x134>
      if(!run(t->f, t->s))
    456e:	648c                	ld	a1,8(s1)
    4570:	6088                	ld	a0,0(s1)
    4572:	00000097          	auipc	ra,0x0
    4576:	e14080e7          	jalr	-492(ra) # 4386 <run>
    457a:	fd79                	bnez	a0,4558 <main+0x134>
        fail = 1;
    457c:	89d6                	mv	s3,s5
    457e:	bfe9                	j	4558 <main+0x134>
  if(fail){
    4580:	f20989e3          	beqz	s3,44b2 <main+0x8e>
    printf("SOME TESTS FAILED\n");
    4584:	00002517          	auipc	a0,0x2
    4588:	64c50513          	addi	a0,a0,1612 # 6bd0 <malloc+0x1e6c>
    458c:	00000097          	auipc	ra,0x0
    4590:	71a080e7          	jalr	1818(ra) # 4ca6 <printf>
    exit(1);
    4594:	4505                	li	a0,1
    4596:	00000097          	auipc	ra,0x0
    459a:	372080e7          	jalr	882(ra) # 4908 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    459e:	00002517          	auipc	a0,0x2
    45a2:	67a50513          	addi	a0,a0,1658 # 6c18 <malloc+0x1eb4>
    45a6:	00000097          	auipc	ra,0x0
    45aa:	700080e7          	jalr	1792(ra) # 4ca6 <printf>
    exit(0);
    45ae:	4501                	li	a0,0
    45b0:	00000097          	auipc	ra,0x0
    45b4:	358080e7          	jalr	856(ra) # 4908 <exit>
        printf("SOME TESTS FAILED\n");
    45b8:	8556                	mv	a0,s5
    45ba:	00000097          	auipc	ra,0x0
    45be:	6ec080e7          	jalr	1772(ra) # 4ca6 <printf>
        if(continuous != 2)
    45c2:	f74998e3          	bne	s3,s4,4532 <main+0x10e>
      int free1 = countfree();
    45c6:	00000097          	auipc	ra,0x0
    45ca:	c8e080e7          	jalr	-882(ra) # 4254 <countfree>
      if(free1 < free0){
    45ce:	f72547e3          	blt	a0,s2,453c <main+0x118>
      int free0 = countfree();
    45d2:	00000097          	auipc	ra,0x0
    45d6:	c82080e7          	jalr	-894(ra) # 4254 <countfree>
    45da:	892a                	mv	s2,a0
      for (struct test *t = tests; t->s != 0; t++) {
    45dc:	c8843583          	ld	a1,-888(s0)
    45e0:	d1fd                	beqz	a1,45c6 <main+0x1a2>
    45e2:	c8040493          	addi	s1,s0,-896
        if(!run(t->f, t->s)){
    45e6:	6088                	ld	a0,0(s1)
    45e8:	00000097          	auipc	ra,0x0
    45ec:	d9e080e7          	jalr	-610(ra) # 4386 <run>
    45f0:	d561                	beqz	a0,45b8 <main+0x194>
      for (struct test *t = tests; t->s != 0; t++) {
    45f2:	04c1                	addi	s1,s1,16
    45f4:	648c                	ld	a1,8(s1)
    45f6:	f9e5                	bnez	a1,45e6 <main+0x1c2>
    45f8:	b7f9                	j	45c6 <main+0x1a2>
    continuous = 1;
    45fa:	4985                	li	s3,1
  } tests[] = {
    45fc:	00002797          	auipc	a5,0x2
    4600:	6c478793          	addi	a5,a5,1732 # 6cc0 <randstate+0x8>
    4604:	c8040713          	addi	a4,s0,-896
    4608:	00003817          	auipc	a6,0x3
    460c:	9f880813          	addi	a6,a6,-1544 # 7000 <name>
    4610:	6388                	ld	a0,0(a5)
    4612:	678c                	ld	a1,8(a5)
    4614:	6b90                	ld	a2,16(a5)
    4616:	6f94                	ld	a3,24(a5)
    4618:	e308                	sd	a0,0(a4)
    461a:	e70c                	sd	a1,8(a4)
    461c:	eb10                	sd	a2,16(a4)
    461e:	ef14                	sd	a3,24(a4)
    4620:	02078793          	addi	a5,a5,32
    4624:	02070713          	addi	a4,a4,32
    4628:	ff0794e3          	bne	a5,a6,4610 <main+0x1ec>
    printf("continuous usertests starting\n");
    462c:	00002517          	auipc	a0,0x2
    4630:	61c50513          	addi	a0,a0,1564 # 6c48 <malloc+0x1ee4>
    4634:	00000097          	auipc	ra,0x0
    4638:	672080e7          	jalr	1650(ra) # 4ca6 <printf>
        printf("SOME TESTS FAILED\n");
    463c:	00002a97          	auipc	s5,0x2
    4640:	594a8a93          	addi	s5,s5,1428 # 6bd0 <malloc+0x1e6c>
        if(continuous != 2)
    4644:	4a09                	li	s4,2
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    4646:	00002b17          	auipc	s6,0x2
    464a:	56ab0b13          	addi	s6,s6,1386 # 6bb0 <malloc+0x1e4c>
    464e:	b751                	j	45d2 <main+0x1ae>

0000000000004650 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
    4650:	1141                	addi	sp,sp,-16
    4652:	e422                	sd	s0,8(sp)
    4654:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    4656:	87aa                	mv	a5,a0
    4658:	0585                	addi	a1,a1,1
    465a:	0785                	addi	a5,a5,1
    465c:	fff5c703          	lbu	a4,-1(a1)
    4660:	fee78fa3          	sb	a4,-1(a5)
    4664:	fb75                	bnez	a4,4658 <strcpy+0x8>
    ;
  return os;
}
    4666:	6422                	ld	s0,8(sp)
    4668:	0141                	addi	sp,sp,16
    466a:	8082                	ret

000000000000466c <strcat>:

char*
strcat(char *s, const char *t)
{
    466c:	1141                	addi	sp,sp,-16
    466e:	e422                	sd	s0,8(sp)
    4670:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
    4672:	00054783          	lbu	a5,0(a0)
    4676:	c385                	beqz	a5,4696 <strcat+0x2a>
    4678:	87aa                	mv	a5,a0
    s++;
    467a:	0785                	addi	a5,a5,1
  while(*s)
    467c:	0007c703          	lbu	a4,0(a5)
    4680:	ff6d                	bnez	a4,467a <strcat+0xe>
  while((*s++ = *t++))
    4682:	0585                	addi	a1,a1,1
    4684:	0785                	addi	a5,a5,1
    4686:	fff5c703          	lbu	a4,-1(a1)
    468a:	fee78fa3          	sb	a4,-1(a5)
    468e:	fb75                	bnez	a4,4682 <strcat+0x16>
    ;
  return os;
}
    4690:	6422                	ld	s0,8(sp)
    4692:	0141                	addi	sp,sp,16
    4694:	8082                	ret
  while(*s)
    4696:	87aa                	mv	a5,a0
    4698:	b7ed                	j	4682 <strcat+0x16>

000000000000469a <strcmp>:


int
strcmp(const char *p, const char *q)
{
    469a:	1141                	addi	sp,sp,-16
    469c:	e422                	sd	s0,8(sp)
    469e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    46a0:	00054783          	lbu	a5,0(a0)
    46a4:	cb91                	beqz	a5,46b8 <strcmp+0x1e>
    46a6:	0005c703          	lbu	a4,0(a1)
    46aa:	00f71763          	bne	a4,a5,46b8 <strcmp+0x1e>
    p++, q++;
    46ae:	0505                	addi	a0,a0,1
    46b0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    46b2:	00054783          	lbu	a5,0(a0)
    46b6:	fbe5                	bnez	a5,46a6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    46b8:	0005c503          	lbu	a0,0(a1)
}
    46bc:	40a7853b          	subw	a0,a5,a0
    46c0:	6422                	ld	s0,8(sp)
    46c2:	0141                	addi	sp,sp,16
    46c4:	8082                	ret

00000000000046c6 <strlen>:

uint
strlen(const char *s)
{
    46c6:	1141                	addi	sp,sp,-16
    46c8:	e422                	sd	s0,8(sp)
    46ca:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    46cc:	00054783          	lbu	a5,0(a0)
    46d0:	cf91                	beqz	a5,46ec <strlen+0x26>
    46d2:	0505                	addi	a0,a0,1
    46d4:	87aa                	mv	a5,a0
    46d6:	4685                	li	a3,1
    46d8:	9e89                	subw	a3,a3,a0
    46da:	00f6853b          	addw	a0,a3,a5
    46de:	0785                	addi	a5,a5,1
    46e0:	fff7c703          	lbu	a4,-1(a5)
    46e4:	fb7d                	bnez	a4,46da <strlen+0x14>
    ;
  return n;
}
    46e6:	6422                	ld	s0,8(sp)
    46e8:	0141                	addi	sp,sp,16
    46ea:	8082                	ret
  for(n = 0; s[n]; n++)
    46ec:	4501                	li	a0,0
    46ee:	bfe5                	j	46e6 <strlen+0x20>

00000000000046f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    46f0:	1141                	addi	sp,sp,-16
    46f2:	e422                	sd	s0,8(sp)
    46f4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    46f6:	ca19                	beqz	a2,470c <memset+0x1c>
    46f8:	87aa                	mv	a5,a0
    46fa:	1602                	slli	a2,a2,0x20
    46fc:	9201                	srli	a2,a2,0x20
    46fe:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    4702:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    4706:	0785                	addi	a5,a5,1
    4708:	fee79de3          	bne	a5,a4,4702 <memset+0x12>
  }
  return dst;
}
    470c:	6422                	ld	s0,8(sp)
    470e:	0141                	addi	sp,sp,16
    4710:	8082                	ret

0000000000004712 <strchr>:

char*
strchr(const char *s, char c)
{
    4712:	1141                	addi	sp,sp,-16
    4714:	e422                	sd	s0,8(sp)
    4716:	0800                	addi	s0,sp,16
  for(; *s; s++)
    4718:	00054783          	lbu	a5,0(a0)
    471c:	cb99                	beqz	a5,4732 <strchr+0x20>
    if(*s == c)
    471e:	00f58763          	beq	a1,a5,472c <strchr+0x1a>
  for(; *s; s++)
    4722:	0505                	addi	a0,a0,1
    4724:	00054783          	lbu	a5,0(a0)
    4728:	fbfd                	bnez	a5,471e <strchr+0xc>
      return (char*)s;
  return 0;
    472a:	4501                	li	a0,0
}
    472c:	6422                	ld	s0,8(sp)
    472e:	0141                	addi	sp,sp,16
    4730:	8082                	ret
  return 0;
    4732:	4501                	li	a0,0
    4734:	bfe5                	j	472c <strchr+0x1a>

0000000000004736 <gets>:

char*
gets(char *buf, int max)
{
    4736:	711d                	addi	sp,sp,-96
    4738:	ec86                	sd	ra,88(sp)
    473a:	e8a2                	sd	s0,80(sp)
    473c:	e4a6                	sd	s1,72(sp)
    473e:	e0ca                	sd	s2,64(sp)
    4740:	fc4e                	sd	s3,56(sp)
    4742:	f852                	sd	s4,48(sp)
    4744:	f456                	sd	s5,40(sp)
    4746:	f05a                	sd	s6,32(sp)
    4748:	ec5e                	sd	s7,24(sp)
    474a:	e862                	sd	s8,16(sp)
    474c:	1080                	addi	s0,sp,96
    474e:	8baa                	mv	s7,a0
    4750:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4752:	892a                	mv	s2,a0
    4754:	4481                	li	s1,0
    cc = read(0, &c, 1);
    4756:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    475a:	4b29                	li	s6,10
    475c:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
    475e:	89a6                	mv	s3,s1
    4760:	2485                	addiw	s1,s1,1
    4762:	0344d763          	bge	s1,s4,4790 <gets+0x5a>
    cc = read(0, &c, 1);
    4766:	4605                	li	a2,1
    4768:	85d6                	mv	a1,s5
    476a:	4501                	li	a0,0
    476c:	00000097          	auipc	ra,0x0
    4770:	1b4080e7          	jalr	436(ra) # 4920 <read>
    if(cc < 1)
    4774:	00a05e63          	blez	a0,4790 <gets+0x5a>
    buf[i++] = c;
    4778:	faf44783          	lbu	a5,-81(s0)
    477c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    4780:	01678763          	beq	a5,s6,478e <gets+0x58>
    4784:	0905                	addi	s2,s2,1
    4786:	fd879ce3          	bne	a5,s8,475e <gets+0x28>
  for(i=0; i+1 < max; ){
    478a:	89a6                	mv	s3,s1
    478c:	a011                	j	4790 <gets+0x5a>
    478e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    4790:	99de                	add	s3,s3,s7
    4792:	00098023          	sb	zero,0(s3)
  return buf;
}
    4796:	855e                	mv	a0,s7
    4798:	60e6                	ld	ra,88(sp)
    479a:	6446                	ld	s0,80(sp)
    479c:	64a6                	ld	s1,72(sp)
    479e:	6906                	ld	s2,64(sp)
    47a0:	79e2                	ld	s3,56(sp)
    47a2:	7a42                	ld	s4,48(sp)
    47a4:	7aa2                	ld	s5,40(sp)
    47a6:	7b02                	ld	s6,32(sp)
    47a8:	6be2                	ld	s7,24(sp)
    47aa:	6c42                	ld	s8,16(sp)
    47ac:	6125                	addi	sp,sp,96
    47ae:	8082                	ret

00000000000047b0 <stat>:

int
stat(const char *n, struct stat *st)
{
    47b0:	1101                	addi	sp,sp,-32
    47b2:	ec06                	sd	ra,24(sp)
    47b4:	e822                	sd	s0,16(sp)
    47b6:	e426                	sd	s1,8(sp)
    47b8:	e04a                	sd	s2,0(sp)
    47ba:	1000                	addi	s0,sp,32
    47bc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    47be:	4581                	li	a1,0
    47c0:	00000097          	auipc	ra,0x0
    47c4:	188080e7          	jalr	392(ra) # 4948 <open>
  if(fd < 0)
    47c8:	02054563          	bltz	a0,47f2 <stat+0x42>
    47cc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    47ce:	85ca                	mv	a1,s2
    47d0:	00000097          	auipc	ra,0x0
    47d4:	180080e7          	jalr	384(ra) # 4950 <fstat>
    47d8:	892a                	mv	s2,a0
  close(fd);
    47da:	8526                	mv	a0,s1
    47dc:	00000097          	auipc	ra,0x0
    47e0:	154080e7          	jalr	340(ra) # 4930 <close>
  return r;
}
    47e4:	854a                	mv	a0,s2
    47e6:	60e2                	ld	ra,24(sp)
    47e8:	6442                	ld	s0,16(sp)
    47ea:	64a2                	ld	s1,8(sp)
    47ec:	6902                	ld	s2,0(sp)
    47ee:	6105                	addi	sp,sp,32
    47f0:	8082                	ret
    return -1;
    47f2:	597d                	li	s2,-1
    47f4:	bfc5                	j	47e4 <stat+0x34>

00000000000047f6 <atoi>:

int
atoi(const char *s)
{
    47f6:	1141                	addi	sp,sp,-16
    47f8:	e422                	sd	s0,8(sp)
    47fa:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
    47fc:	00054703          	lbu	a4,0(a0)
    4800:	02d00793          	li	a5,45
  int neg = 1;
    4804:	4805                	li	a6,1
  if (*s == '-') {
    4806:	04f70363          	beq	a4,a5,484c <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
    480a:	00054683          	lbu	a3,0(a0)
    480e:	fd06879b          	addiw	a5,a3,-48
    4812:	0ff7f793          	andi	a5,a5,255
    4816:	4725                	li	a4,9
    4818:	02f76d63          	bltu	a4,a5,4852 <atoi+0x5c>
  n = 0;
    481c:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
    481e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    4820:	0505                	addi	a0,a0,1
    4822:	0026179b          	slliw	a5,a2,0x2
    4826:	9fb1                	addw	a5,a5,a2
    4828:	0017979b          	slliw	a5,a5,0x1
    482c:	9fb5                	addw	a5,a5,a3
    482e:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
    4832:	00054683          	lbu	a3,0(a0)
    4836:	fd06871b          	addiw	a4,a3,-48
    483a:	0ff77713          	andi	a4,a4,255
    483e:	fee5f1e3          	bgeu	a1,a4,4820 <atoi+0x2a>
  return n * neg;
}
    4842:	02c8053b          	mulw	a0,a6,a2
    4846:	6422                	ld	s0,8(sp)
    4848:	0141                	addi	sp,sp,16
    484a:	8082                	ret
    s++;
    484c:	0505                	addi	a0,a0,1
    neg = -1;
    484e:	587d                	li	a6,-1
    4850:	bf6d                	j	480a <atoi+0x14>
  n = 0;
    4852:	4601                	li	a2,0
    4854:	b7fd                	j	4842 <atoi+0x4c>

0000000000004856 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    4856:	1141                	addi	sp,sp,-16
    4858:	e422                	sd	s0,8(sp)
    485a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    485c:	02b57463          	bgeu	a0,a1,4884 <memmove+0x2e>
    while(n-- > 0)
    4860:	00c05f63          	blez	a2,487e <memmove+0x28>
    4864:	1602                	slli	a2,a2,0x20
    4866:	9201                	srli	a2,a2,0x20
    4868:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    486c:	872a                	mv	a4,a0
      *dst++ = *src++;
    486e:	0585                	addi	a1,a1,1
    4870:	0705                	addi	a4,a4,1
    4872:	fff5c683          	lbu	a3,-1(a1)
    4876:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    487a:	fee79ae3          	bne	a5,a4,486e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    487e:	6422                	ld	s0,8(sp)
    4880:	0141                	addi	sp,sp,16
    4882:	8082                	ret
    dst += n;
    4884:	00c50733          	add	a4,a0,a2
    src += n;
    4888:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    488a:	fec05ae3          	blez	a2,487e <memmove+0x28>
    488e:	fff6079b          	addiw	a5,a2,-1
    4892:	1782                	slli	a5,a5,0x20
    4894:	9381                	srli	a5,a5,0x20
    4896:	fff7c793          	not	a5,a5
    489a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    489c:	15fd                	addi	a1,a1,-1
    489e:	177d                	addi	a4,a4,-1
    48a0:	0005c683          	lbu	a3,0(a1)
    48a4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    48a8:	fee79ae3          	bne	a5,a4,489c <memmove+0x46>
    48ac:	bfc9                	j	487e <memmove+0x28>

00000000000048ae <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    48ae:	1141                	addi	sp,sp,-16
    48b0:	e422                	sd	s0,8(sp)
    48b2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    48b4:	ca05                	beqz	a2,48e4 <memcmp+0x36>
    48b6:	fff6069b          	addiw	a3,a2,-1
    48ba:	1682                	slli	a3,a3,0x20
    48bc:	9281                	srli	a3,a3,0x20
    48be:	0685                	addi	a3,a3,1
    48c0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    48c2:	00054783          	lbu	a5,0(a0)
    48c6:	0005c703          	lbu	a4,0(a1)
    48ca:	00e79863          	bne	a5,a4,48da <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    48ce:	0505                	addi	a0,a0,1
    p2++;
    48d0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    48d2:	fed518e3          	bne	a0,a3,48c2 <memcmp+0x14>
  }
  return 0;
    48d6:	4501                	li	a0,0
    48d8:	a019                	j	48de <memcmp+0x30>
      return *p1 - *p2;
    48da:	40e7853b          	subw	a0,a5,a4
}
    48de:	6422                	ld	s0,8(sp)
    48e0:	0141                	addi	sp,sp,16
    48e2:	8082                	ret
  return 0;
    48e4:	4501                	li	a0,0
    48e6:	bfe5                	j	48de <memcmp+0x30>

00000000000048e8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    48e8:	1141                	addi	sp,sp,-16
    48ea:	e406                	sd	ra,8(sp)
    48ec:	e022                	sd	s0,0(sp)
    48ee:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    48f0:	00000097          	auipc	ra,0x0
    48f4:	f66080e7          	jalr	-154(ra) # 4856 <memmove>
}
    48f8:	60a2                	ld	ra,8(sp)
    48fa:	6402                	ld	s0,0(sp)
    48fc:	0141                	addi	sp,sp,16
    48fe:	8082                	ret

0000000000004900 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
    4900:	4885                	li	a7,1
 ecall
    4902:	00000073          	ecall
 ret
    4906:	8082                	ret

0000000000004908 <exit>:
.global exit
exit:
 li a7, SYS_exit
    4908:	4889                	li	a7,2
 ecall
    490a:	00000073          	ecall
 ret
    490e:	8082                	ret

0000000000004910 <wait>:
.global wait
wait:
 li a7, SYS_wait
    4910:	488d                	li	a7,3
 ecall
    4912:	00000073          	ecall
 ret
    4916:	8082                	ret

0000000000004918 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    4918:	4891                	li	a7,4
 ecall
    491a:	00000073          	ecall
 ret
    491e:	8082                	ret

0000000000004920 <read>:
.global read
read:
 li a7, SYS_read
    4920:	4895                	li	a7,5
 ecall
    4922:	00000073          	ecall
 ret
    4926:	8082                	ret

0000000000004928 <write>:
.global write
write:
 li a7, SYS_write
    4928:	48c1                	li	a7,16
 ecall
    492a:	00000073          	ecall
 ret
    492e:	8082                	ret

0000000000004930 <close>:
.global close
close:
 li a7, SYS_close
    4930:	48d5                	li	a7,21
 ecall
    4932:	00000073          	ecall
 ret
    4936:	8082                	ret

0000000000004938 <kill>:
.global kill
kill:
 li a7, SYS_kill
    4938:	4899                	li	a7,6
 ecall
    493a:	00000073          	ecall
 ret
    493e:	8082                	ret

0000000000004940 <exec>:
.global exec
exec:
 li a7, SYS_exec
    4940:	489d                	li	a7,7
 ecall
    4942:	00000073          	ecall
 ret
    4946:	8082                	ret

0000000000004948 <open>:
.global open
open:
 li a7, SYS_open
    4948:	48bd                	li	a7,15
 ecall
    494a:	00000073          	ecall
 ret
    494e:	8082                	ret

0000000000004950 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    4950:	48a1                	li	a7,8
 ecall
    4952:	00000073          	ecall
 ret
    4956:	8082                	ret

0000000000004958 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    4958:	48d1                	li	a7,20
 ecall
    495a:	00000073          	ecall
 ret
    495e:	8082                	ret

0000000000004960 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    4960:	48a5                	li	a7,9
 ecall
    4962:	00000073          	ecall
 ret
    4966:	8082                	ret

0000000000004968 <dup>:
.global dup
dup:
 li a7, SYS_dup
    4968:	48a9                	li	a7,10
 ecall
    496a:	00000073          	ecall
 ret
    496e:	8082                	ret

0000000000004970 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    4970:	48ad                	li	a7,11
 ecall
    4972:	00000073          	ecall
 ret
    4976:	8082                	ret

0000000000004978 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    4978:	48b1                	li	a7,12
 ecall
    497a:	00000073          	ecall
 ret
    497e:	8082                	ret

0000000000004980 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    4980:	48b5                	li	a7,13
 ecall
    4982:	00000073          	ecall
 ret
    4986:	8082                	ret

0000000000004988 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    4988:	48b9                	li	a7,14
 ecall
    498a:	00000073          	ecall
 ret
    498e:	8082                	ret

0000000000004990 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
    4990:	48d9                	li	a7,22
 ecall
    4992:	00000073          	ecall
 ret
    4996:	8082                	ret

0000000000004998 <dev>:
.global dev
dev:
 li a7, SYS_dev
    4998:	48dd                	li	a7,23
 ecall
    499a:	00000073          	ecall
 ret
    499e:	8082                	ret

00000000000049a0 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
    49a0:	48e1                	li	a7,24
 ecall
    49a2:	00000073          	ecall
 ret
    49a6:	8082                	ret

00000000000049a8 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
    49a8:	48e5                	li	a7,25
 ecall
    49aa:	00000073          	ecall
 ret
    49ae:	8082                	ret

00000000000049b0 <remove>:
.global remove
remove:
 li a7, SYS_remove
    49b0:	48c5                	li	a7,17
 ecall
    49b2:	00000073          	ecall
 ret
    49b6:	8082                	ret

00000000000049b8 <trace>:
.global trace
trace:
 li a7, SYS_trace
    49b8:	48c9                	li	a7,18
 ecall
    49ba:	00000073          	ecall
 ret
    49be:	8082                	ret

00000000000049c0 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
    49c0:	48cd                	li	a7,19
 ecall
    49c2:	00000073          	ecall
 ret
    49c6:	8082                	ret

00000000000049c8 <rename>:
.global rename
rename:
 li a7, SYS_rename
    49c8:	48e9                	li	a7,26
 ecall
    49ca:	00000073          	ecall
 ret
    49ce:	8082                	ret

00000000000049d0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    49d0:	1101                	addi	sp,sp,-32
    49d2:	ec06                	sd	ra,24(sp)
    49d4:	e822                	sd	s0,16(sp)
    49d6:	1000                	addi	s0,sp,32
    49d8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    49dc:	4605                	li	a2,1
    49de:	fef40593          	addi	a1,s0,-17
    49e2:	00000097          	auipc	ra,0x0
    49e6:	f46080e7          	jalr	-186(ra) # 4928 <write>
}
    49ea:	60e2                	ld	ra,24(sp)
    49ec:	6442                	ld	s0,16(sp)
    49ee:	6105                	addi	sp,sp,32
    49f0:	8082                	ret

00000000000049f2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    49f2:	7139                	addi	sp,sp,-64
    49f4:	fc06                	sd	ra,56(sp)
    49f6:	f822                	sd	s0,48(sp)
    49f8:	f426                	sd	s1,40(sp)
    49fa:	f04a                	sd	s2,32(sp)
    49fc:	ec4e                	sd	s3,24(sp)
    49fe:	0080                	addi	s0,sp,64
    4a00:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4a02:	c299                	beqz	a3,4a08 <printint+0x16>
    4a04:	0805c763          	bltz	a1,4a92 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    4a08:	2581                	sext.w	a1,a1
  neg = 0;
    4a0a:	4881                	li	a7,0
  }

  i = 0;
    4a0c:	fc040993          	addi	s3,s0,-64
  neg = 0;
    4a10:	86ce                	mv	a3,s3
  i = 0;
    4a12:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    4a14:	2601                	sext.w	a2,a2
    4a16:	00002517          	auipc	a0,0x2
    4a1a:	26a50513          	addi	a0,a0,618 # 6c80 <digits>
    4a1e:	883a                	mv	a6,a4
    4a20:	2705                	addiw	a4,a4,1
    4a22:	02c5f7bb          	remuw	a5,a1,a2
    4a26:	1782                	slli	a5,a5,0x20
    4a28:	9381                	srli	a5,a5,0x20
    4a2a:	97aa                	add	a5,a5,a0
    4a2c:	0007c783          	lbu	a5,0(a5)
    4a30:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    4a34:	0005879b          	sext.w	a5,a1
    4a38:	02c5d5bb          	divuw	a1,a1,a2
    4a3c:	0685                	addi	a3,a3,1
    4a3e:	fec7f0e3          	bgeu	a5,a2,4a1e <printint+0x2c>
  if(neg)
    4a42:	00088b63          	beqz	a7,4a58 <printint+0x66>
    buf[i++] = '-';
    4a46:	fd040793          	addi	a5,s0,-48
    4a4a:	973e                	add	a4,a4,a5
    4a4c:	02d00793          	li	a5,45
    4a50:	fef70823          	sb	a5,-16(a4)
    4a54:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    4a58:	02e05663          	blez	a4,4a84 <printint+0x92>
    4a5c:	fc040913          	addi	s2,s0,-64
    4a60:	993a                	add	s2,s2,a4
    4a62:	19fd                	addi	s3,s3,-1
    4a64:	99ba                	add	s3,s3,a4
    4a66:	377d                	addiw	a4,a4,-1
    4a68:	1702                	slli	a4,a4,0x20
    4a6a:	9301                	srli	a4,a4,0x20
    4a6c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    4a70:	fff94583          	lbu	a1,-1(s2)
    4a74:	8526                	mv	a0,s1
    4a76:	00000097          	auipc	ra,0x0
    4a7a:	f5a080e7          	jalr	-166(ra) # 49d0 <putc>
  while(--i >= 0)
    4a7e:	197d                	addi	s2,s2,-1
    4a80:	ff3918e3          	bne	s2,s3,4a70 <printint+0x7e>
}
    4a84:	70e2                	ld	ra,56(sp)
    4a86:	7442                	ld	s0,48(sp)
    4a88:	74a2                	ld	s1,40(sp)
    4a8a:	7902                	ld	s2,32(sp)
    4a8c:	69e2                	ld	s3,24(sp)
    4a8e:	6121                	addi	sp,sp,64
    4a90:	8082                	ret
    x = -xx;
    4a92:	40b005bb          	negw	a1,a1
    neg = 1;
    4a96:	4885                	li	a7,1
    x = -xx;
    4a98:	bf95                	j	4a0c <printint+0x1a>

0000000000004a9a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    4a9a:	7119                	addi	sp,sp,-128
    4a9c:	fc86                	sd	ra,120(sp)
    4a9e:	f8a2                	sd	s0,112(sp)
    4aa0:	f4a6                	sd	s1,104(sp)
    4aa2:	f0ca                	sd	s2,96(sp)
    4aa4:	ecce                	sd	s3,88(sp)
    4aa6:	e8d2                	sd	s4,80(sp)
    4aa8:	e4d6                	sd	s5,72(sp)
    4aaa:	e0da                	sd	s6,64(sp)
    4aac:	fc5e                	sd	s7,56(sp)
    4aae:	f862                	sd	s8,48(sp)
    4ab0:	f466                	sd	s9,40(sp)
    4ab2:	f06a                	sd	s10,32(sp)
    4ab4:	ec6e                	sd	s11,24(sp)
    4ab6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    4ab8:	0005c903          	lbu	s2,0(a1)
    4abc:	18090f63          	beqz	s2,4c5a <vprintf+0x1c0>
    4ac0:	8aaa                	mv	s5,a0
    4ac2:	8b32                	mv	s6,a2
    4ac4:	00158493          	addi	s1,a1,1
  state = 0;
    4ac8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    4aca:	02500a13          	li	s4,37
      if(c == 'd'){
    4ace:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    4ad2:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    4ad6:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    4ada:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    4ade:	00002b97          	auipc	s7,0x2
    4ae2:	1a2b8b93          	addi	s7,s7,418 # 6c80 <digits>
    4ae6:	a839                	j	4b04 <vprintf+0x6a>
        putc(fd, c);
    4ae8:	85ca                	mv	a1,s2
    4aea:	8556                	mv	a0,s5
    4aec:	00000097          	auipc	ra,0x0
    4af0:	ee4080e7          	jalr	-284(ra) # 49d0 <putc>
    4af4:	a019                	j	4afa <vprintf+0x60>
    } else if(state == '%'){
    4af6:	01498f63          	beq	s3,s4,4b14 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    4afa:	0485                	addi	s1,s1,1
    4afc:	fff4c903          	lbu	s2,-1(s1)
    4b00:	14090d63          	beqz	s2,4c5a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    4b04:	0009079b          	sext.w	a5,s2
    if(state == 0){
    4b08:	fe0997e3          	bnez	s3,4af6 <vprintf+0x5c>
      if(c == '%'){
    4b0c:	fd479ee3          	bne	a5,s4,4ae8 <vprintf+0x4e>
        state = '%';
    4b10:	89be                	mv	s3,a5
    4b12:	b7e5                	j	4afa <vprintf+0x60>
      if(c == 'd'){
    4b14:	05878063          	beq	a5,s8,4b54 <vprintf+0xba>
      } else if(c == 'l') {
    4b18:	05978c63          	beq	a5,s9,4b70 <vprintf+0xd6>
      } else if(c == 'x') {
    4b1c:	07a78863          	beq	a5,s10,4b8c <vprintf+0xf2>
      } else if(c == 'p') {
    4b20:	09b78463          	beq	a5,s11,4ba8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    4b24:	07300713          	li	a4,115
    4b28:	0ce78663          	beq	a5,a4,4bf4 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4b2c:	06300713          	li	a4,99
    4b30:	0ee78e63          	beq	a5,a4,4c2c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    4b34:	11478863          	beq	a5,s4,4c44 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4b38:	85d2                	mv	a1,s4
    4b3a:	8556                	mv	a0,s5
    4b3c:	00000097          	auipc	ra,0x0
    4b40:	e94080e7          	jalr	-364(ra) # 49d0 <putc>
        putc(fd, c);
    4b44:	85ca                	mv	a1,s2
    4b46:	8556                	mv	a0,s5
    4b48:	00000097          	auipc	ra,0x0
    4b4c:	e88080e7          	jalr	-376(ra) # 49d0 <putc>
      }
      state = 0;
    4b50:	4981                	li	s3,0
    4b52:	b765                	j	4afa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    4b54:	008b0913          	addi	s2,s6,8
    4b58:	4685                	li	a3,1
    4b5a:	4629                	li	a2,10
    4b5c:	000b2583          	lw	a1,0(s6)
    4b60:	8556                	mv	a0,s5
    4b62:	00000097          	auipc	ra,0x0
    4b66:	e90080e7          	jalr	-368(ra) # 49f2 <printint>
    4b6a:	8b4a                	mv	s6,s2
      state = 0;
    4b6c:	4981                	li	s3,0
    4b6e:	b771                	j	4afa <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    4b70:	008b0913          	addi	s2,s6,8
    4b74:	4681                	li	a3,0
    4b76:	4629                	li	a2,10
    4b78:	000b2583          	lw	a1,0(s6)
    4b7c:	8556                	mv	a0,s5
    4b7e:	00000097          	auipc	ra,0x0
    4b82:	e74080e7          	jalr	-396(ra) # 49f2 <printint>
    4b86:	8b4a                	mv	s6,s2
      state = 0;
    4b88:	4981                	li	s3,0
    4b8a:	bf85                	j	4afa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    4b8c:	008b0913          	addi	s2,s6,8
    4b90:	4681                	li	a3,0
    4b92:	4641                	li	a2,16
    4b94:	000b2583          	lw	a1,0(s6)
    4b98:	8556                	mv	a0,s5
    4b9a:	00000097          	auipc	ra,0x0
    4b9e:	e58080e7          	jalr	-424(ra) # 49f2 <printint>
    4ba2:	8b4a                	mv	s6,s2
      state = 0;
    4ba4:	4981                	li	s3,0
    4ba6:	bf91                	j	4afa <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    4ba8:	008b0793          	addi	a5,s6,8
    4bac:	f8f43423          	sd	a5,-120(s0)
    4bb0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    4bb4:	03000593          	li	a1,48
    4bb8:	8556                	mv	a0,s5
    4bba:	00000097          	auipc	ra,0x0
    4bbe:	e16080e7          	jalr	-490(ra) # 49d0 <putc>
  putc(fd, 'x');
    4bc2:	85ea                	mv	a1,s10
    4bc4:	8556                	mv	a0,s5
    4bc6:	00000097          	auipc	ra,0x0
    4bca:	e0a080e7          	jalr	-502(ra) # 49d0 <putc>
    4bce:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    4bd0:	03c9d793          	srli	a5,s3,0x3c
    4bd4:	97de                	add	a5,a5,s7
    4bd6:	0007c583          	lbu	a1,0(a5)
    4bda:	8556                	mv	a0,s5
    4bdc:	00000097          	auipc	ra,0x0
    4be0:	df4080e7          	jalr	-524(ra) # 49d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    4be4:	0992                	slli	s3,s3,0x4
    4be6:	397d                	addiw	s2,s2,-1
    4be8:	fe0914e3          	bnez	s2,4bd0 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    4bec:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    4bf0:	4981                	li	s3,0
    4bf2:	b721                	j	4afa <vprintf+0x60>
        s = va_arg(ap, char*);
    4bf4:	008b0993          	addi	s3,s6,8
    4bf8:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    4bfc:	02090163          	beqz	s2,4c1e <vprintf+0x184>
        while(*s != 0){
    4c00:	00094583          	lbu	a1,0(s2)
    4c04:	c9a1                	beqz	a1,4c54 <vprintf+0x1ba>
          putc(fd, *s);
    4c06:	8556                	mv	a0,s5
    4c08:	00000097          	auipc	ra,0x0
    4c0c:	dc8080e7          	jalr	-568(ra) # 49d0 <putc>
          s++;
    4c10:	0905                	addi	s2,s2,1
        while(*s != 0){
    4c12:	00094583          	lbu	a1,0(s2)
    4c16:	f9e5                	bnez	a1,4c06 <vprintf+0x16c>
        s = va_arg(ap, char*);
    4c18:	8b4e                	mv	s6,s3
      state = 0;
    4c1a:	4981                	li	s3,0
    4c1c:	bdf9                	j	4afa <vprintf+0x60>
          s = "(null)";
    4c1e:	00002917          	auipc	s2,0x2
    4c22:	05a90913          	addi	s2,s2,90 # 6c78 <malloc+0x1f14>
        while(*s != 0){
    4c26:	02800593          	li	a1,40
    4c2a:	bff1                	j	4c06 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    4c2c:	008b0913          	addi	s2,s6,8
    4c30:	000b4583          	lbu	a1,0(s6)
    4c34:	8556                	mv	a0,s5
    4c36:	00000097          	auipc	ra,0x0
    4c3a:	d9a080e7          	jalr	-614(ra) # 49d0 <putc>
    4c3e:	8b4a                	mv	s6,s2
      state = 0;
    4c40:	4981                	li	s3,0
    4c42:	bd65                	j	4afa <vprintf+0x60>
        putc(fd, c);
    4c44:	85d2                	mv	a1,s4
    4c46:	8556                	mv	a0,s5
    4c48:	00000097          	auipc	ra,0x0
    4c4c:	d88080e7          	jalr	-632(ra) # 49d0 <putc>
      state = 0;
    4c50:	4981                	li	s3,0
    4c52:	b565                	j	4afa <vprintf+0x60>
        s = va_arg(ap, char*);
    4c54:	8b4e                	mv	s6,s3
      state = 0;
    4c56:	4981                	li	s3,0
    4c58:	b54d                	j	4afa <vprintf+0x60>
    }
  }
}
    4c5a:	70e6                	ld	ra,120(sp)
    4c5c:	7446                	ld	s0,112(sp)
    4c5e:	74a6                	ld	s1,104(sp)
    4c60:	7906                	ld	s2,96(sp)
    4c62:	69e6                	ld	s3,88(sp)
    4c64:	6a46                	ld	s4,80(sp)
    4c66:	6aa6                	ld	s5,72(sp)
    4c68:	6b06                	ld	s6,64(sp)
    4c6a:	7be2                	ld	s7,56(sp)
    4c6c:	7c42                	ld	s8,48(sp)
    4c6e:	7ca2                	ld	s9,40(sp)
    4c70:	7d02                	ld	s10,32(sp)
    4c72:	6de2                	ld	s11,24(sp)
    4c74:	6109                	addi	sp,sp,128
    4c76:	8082                	ret

0000000000004c78 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    4c78:	715d                	addi	sp,sp,-80
    4c7a:	ec06                	sd	ra,24(sp)
    4c7c:	e822                	sd	s0,16(sp)
    4c7e:	1000                	addi	s0,sp,32
    4c80:	e010                	sd	a2,0(s0)
    4c82:	e414                	sd	a3,8(s0)
    4c84:	e818                	sd	a4,16(s0)
    4c86:	ec1c                	sd	a5,24(s0)
    4c88:	03043023          	sd	a6,32(s0)
    4c8c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    4c90:	8622                	mv	a2,s0
    4c92:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    4c96:	00000097          	auipc	ra,0x0
    4c9a:	e04080e7          	jalr	-508(ra) # 4a9a <vprintf>
}
    4c9e:	60e2                	ld	ra,24(sp)
    4ca0:	6442                	ld	s0,16(sp)
    4ca2:	6161                	addi	sp,sp,80
    4ca4:	8082                	ret

0000000000004ca6 <printf>:

void
printf(const char *fmt, ...)
{
    4ca6:	711d                	addi	sp,sp,-96
    4ca8:	ec06                	sd	ra,24(sp)
    4caa:	e822                	sd	s0,16(sp)
    4cac:	1000                	addi	s0,sp,32
    4cae:	e40c                	sd	a1,8(s0)
    4cb0:	e810                	sd	a2,16(s0)
    4cb2:	ec14                	sd	a3,24(s0)
    4cb4:	f018                	sd	a4,32(s0)
    4cb6:	f41c                	sd	a5,40(s0)
    4cb8:	03043823          	sd	a6,48(s0)
    4cbc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    4cc0:	00840613          	addi	a2,s0,8
    4cc4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    4cc8:	85aa                	mv	a1,a0
    4cca:	4505                	li	a0,1
    4ccc:	00000097          	auipc	ra,0x0
    4cd0:	dce080e7          	jalr	-562(ra) # 4a9a <vprintf>
}
    4cd4:	60e2                	ld	ra,24(sp)
    4cd6:	6442                	ld	s0,16(sp)
    4cd8:	6125                	addi	sp,sp,96
    4cda:	8082                	ret

0000000000004cdc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4cdc:	1141                	addi	sp,sp,-16
    4cde:	e422                	sd	s0,8(sp)
    4ce0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4ce2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4ce6:	00007797          	auipc	a5,0x7
    4cea:	33a7b783          	ld	a5,826(a5) # c020 <freep>
    4cee:	a805                	j	4d1e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    4cf0:	4618                	lw	a4,8(a2)
    4cf2:	9db9                	addw	a1,a1,a4
    4cf4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    4cf8:	6398                	ld	a4,0(a5)
    4cfa:	6318                	ld	a4,0(a4)
    4cfc:	fee53823          	sd	a4,-16(a0)
    4d00:	a091                	j	4d44 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    4d02:	ff852703          	lw	a4,-8(a0)
    4d06:	9e39                	addw	a2,a2,a4
    4d08:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    4d0a:	ff053703          	ld	a4,-16(a0)
    4d0e:	e398                	sd	a4,0(a5)
    4d10:	a099                	j	4d56 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4d12:	6398                	ld	a4,0(a5)
    4d14:	00e7e463          	bltu	a5,a4,4d1c <free+0x40>
    4d18:	00e6ea63          	bltu	a3,a4,4d2c <free+0x50>
{
    4d1c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4d1e:	fed7fae3          	bgeu	a5,a3,4d12 <free+0x36>
    4d22:	6398                	ld	a4,0(a5)
    4d24:	00e6e463          	bltu	a3,a4,4d2c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4d28:	fee7eae3          	bltu	a5,a4,4d1c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    4d2c:	ff852583          	lw	a1,-8(a0)
    4d30:	6390                	ld	a2,0(a5)
    4d32:	02059713          	slli	a4,a1,0x20
    4d36:	9301                	srli	a4,a4,0x20
    4d38:	0712                	slli	a4,a4,0x4
    4d3a:	9736                	add	a4,a4,a3
    4d3c:	fae60ae3          	beq	a2,a4,4cf0 <free+0x14>
    bp->s.ptr = p->s.ptr;
    4d40:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    4d44:	4790                	lw	a2,8(a5)
    4d46:	02061713          	slli	a4,a2,0x20
    4d4a:	9301                	srli	a4,a4,0x20
    4d4c:	0712                	slli	a4,a4,0x4
    4d4e:	973e                	add	a4,a4,a5
    4d50:	fae689e3          	beq	a3,a4,4d02 <free+0x26>
  } else
    p->s.ptr = bp;
    4d54:	e394                	sd	a3,0(a5)
  freep = p;
    4d56:	00007717          	auipc	a4,0x7
    4d5a:	2cf73523          	sd	a5,714(a4) # c020 <freep>
}
    4d5e:	6422                	ld	s0,8(sp)
    4d60:	0141                	addi	sp,sp,16
    4d62:	8082                	ret

0000000000004d64 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4d64:	7139                	addi	sp,sp,-64
    4d66:	fc06                	sd	ra,56(sp)
    4d68:	f822                	sd	s0,48(sp)
    4d6a:	f426                	sd	s1,40(sp)
    4d6c:	f04a                	sd	s2,32(sp)
    4d6e:	ec4e                	sd	s3,24(sp)
    4d70:	e852                	sd	s4,16(sp)
    4d72:	e456                	sd	s5,8(sp)
    4d74:	e05a                	sd	s6,0(sp)
    4d76:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4d78:	02051493          	slli	s1,a0,0x20
    4d7c:	9081                	srli	s1,s1,0x20
    4d7e:	04bd                	addi	s1,s1,15
    4d80:	8091                	srli	s1,s1,0x4
    4d82:	0014899b          	addiw	s3,s1,1
    4d86:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    4d88:	00007517          	auipc	a0,0x7
    4d8c:	29853503          	ld	a0,664(a0) # c020 <freep>
    4d90:	c515                	beqz	a0,4dbc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4d92:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4d94:	4798                	lw	a4,8(a5)
    4d96:	04977163          	bgeu	a4,s1,4dd8 <malloc+0x74>
    4d9a:	8a4e                	mv	s4,s3
    4d9c:	0009871b          	sext.w	a4,s3
    4da0:	6685                	lui	a3,0x1
    4da2:	00d77363          	bgeu	a4,a3,4da8 <malloc+0x44>
    4da6:	6a05                	lui	s4,0x1
    4da8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    4dac:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    4db0:	00007917          	auipc	s2,0x7
    4db4:	27090913          	addi	s2,s2,624 # c020 <freep>
  if(p == (char*)-1)
    4db8:	5afd                	li	s5,-1
    4dba:	a89d                	j	4e30 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
    4dbc:	00007797          	auipc	a5,0x7
    4dc0:	26478793          	addi	a5,a5,612 # c020 <freep>
    4dc4:	00007717          	auipc	a4,0x7
    4dc8:	26470713          	addi	a4,a4,612 # c028 <base>
    4dcc:	e398                	sd	a4,0(a5)
    4dce:	e798                	sd	a4,8(a5)
    base.s.size = 0;
    4dd0:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4dd4:	87ba                	mv	a5,a4
    4dd6:	b7d1                	j	4d9a <malloc+0x36>
      if(p->s.size == nunits)
    4dd8:	02e48b63          	beq	s1,a4,4e0e <malloc+0xaa>
        p->s.size -= nunits;
    4ddc:	4137073b          	subw	a4,a4,s3
    4de0:	c798                	sw	a4,8(a5)
        p += p->s.size;
    4de2:	1702                	slli	a4,a4,0x20
    4de4:	9301                	srli	a4,a4,0x20
    4de6:	0712                	slli	a4,a4,0x4
    4de8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    4dea:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    4dee:	00007717          	auipc	a4,0x7
    4df2:	22a73923          	sd	a0,562(a4) # c020 <freep>
      return (void*)(p + 1);
    4df6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    4dfa:	70e2                	ld	ra,56(sp)
    4dfc:	7442                	ld	s0,48(sp)
    4dfe:	74a2                	ld	s1,40(sp)
    4e00:	7902                	ld	s2,32(sp)
    4e02:	69e2                	ld	s3,24(sp)
    4e04:	6a42                	ld	s4,16(sp)
    4e06:	6aa2                	ld	s5,8(sp)
    4e08:	6b02                	ld	s6,0(sp)
    4e0a:	6121                	addi	sp,sp,64
    4e0c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    4e0e:	6398                	ld	a4,0(a5)
    4e10:	e118                	sd	a4,0(a0)
    4e12:	bff1                	j	4dee <malloc+0x8a>
  hp->s.size = nu;
    4e14:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    4e18:	0541                	addi	a0,a0,16
    4e1a:	00000097          	auipc	ra,0x0
    4e1e:	ec2080e7          	jalr	-318(ra) # 4cdc <free>
  return freep;
    4e22:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    4e26:	d971                	beqz	a0,4dfa <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4e28:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4e2a:	4798                	lw	a4,8(a5)
    4e2c:	fa9776e3          	bgeu	a4,s1,4dd8 <malloc+0x74>
    if(p == freep)
    4e30:	00093703          	ld	a4,0(s2)
    4e34:	853e                	mv	a0,a5
    4e36:	fef719e3          	bne	a4,a5,4e28 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
    4e3a:	8552                	mv	a0,s4
    4e3c:	00000097          	auipc	ra,0x0
    4e40:	b3c080e7          	jalr	-1220(ra) # 4978 <sbrk>
  if(p == (char*)-1)
    4e44:	fd5518e3          	bne	a0,s5,4e14 <malloc+0xb0>
        return 0;
    4e48:	4501                	li	a0,0
    4e4a:	bf45                	j	4dfa <malloc+0x96>
