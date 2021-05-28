
xv6-user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <checkenvname>:

char mycwd[128];

int
checkenvname(char* s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
       6:	88aa                	mv	a7,a0
  if((*s >= 'A' && *s <= 'Z') ||
       8:	00054703          	lbu	a4,0(a0)
       c:	fdf77793          	andi	a5,a4,-33
      10:	fbf7879b          	addiw	a5,a5,-65
      14:	0ff7f793          	andi	a5,a5,255
      18:	46e5                	li	a3,25
      1a:	00f6f763          	bgeu	a3,a5,28 <checkenvname+0x28>
     (*s >= 'a' && *s <= 'z') ||
      1e:	05f00793          	li	a5,95
      *s == '_')
    ;
  else
    return 0;
      22:	4501                	li	a0,0
     (*s >= 'a' && *s <= 'z') ||
      24:	02f71e63          	bne	a4,a5,60 <checkenvname+0x60>
  char *tmp = s + 1;
      28:	00188713          	addi	a4,a7,1
  while((*tmp >= 'A' && *tmp <= 'Z') ||
      2c:	4665                	li	a2,25
        (*tmp >= 'a' && *tmp <= 'z') ||
      2e:	45a5                	li	a1,9
        (*tmp >= '0' && *tmp <= '9') ||
      30:	05f00813          	li	a6,95
  while((*tmp >= 'A' && *tmp <= 'Z') ||
      34:	a011                	j	38 <checkenvname+0x38>
         *tmp == '_')
    tmp++;
      36:	0705                	addi	a4,a4,1
  while((*tmp >= 'A' && *tmp <= 'Z') ||
      38:	00074683          	lbu	a3,0(a4)
      3c:	fdf6f793          	andi	a5,a3,-33
      40:	fbf7879b          	addiw	a5,a5,-65
      44:	0ff7f793          	andi	a5,a5,255
      48:	fef677e3          	bgeu	a2,a5,36 <checkenvname+0x36>
        (*tmp >= '0' && *tmp <= '9') ||
      4c:	fd06879b          	addiw	a5,a3,-48
        (*tmp >= 'a' && *tmp <= 'z') ||
      50:	0ff7f793          	andi	a5,a5,255
      54:	fef5f1e3          	bgeu	a1,a5,36 <checkenvname+0x36>
        (*tmp >= '0' && *tmp <= '9') ||
      58:	fd068fe3          	beq	a3,a6,36 <checkenvname+0x36>
  return (int)(tmp - s);
      5c:	4117053b          	subw	a0,a4,a7
}
      60:	6422                	ld	s0,8(sp)
      62:	0141                	addi	sp,sp,16
      64:	8082                	ret

0000000000000066 <export>:

int
export(char *argv[])
{
      66:	7131                	addi	sp,sp,-192
      68:	fd06                	sd	ra,184(sp)
      6a:	f922                	sd	s0,176(sp)
      6c:	f526                	sd	s1,168(sp)
      6e:	f14a                	sd	s2,160(sp)
      70:	ed4e                	sd	s3,152(sp)
      72:	e952                	sd	s4,144(sp)
      74:	e556                	sd	s5,136(sp)
      76:	e15a                	sd	s6,128(sp)
      78:	0180                	addi	s0,sp,192
      7a:	84aa                	mv	s1,a0
  if(!strcmp(argv[1], "-p"))
      7c:	00001597          	auipc	a1,0x1
      80:	7b458593          	addi	a1,a1,1972 # 1830 <malloc+0xec>
      84:	6508                	ld	a0,8(a0)
      86:	00001097          	auipc	ra,0x1
      8a:	ff4080e7          	jalr	-12(ra) # 107a <strcmp>
      8e:	e12d                	bnez	a0,f0 <export+0x8a>
      90:	89aa                	mv	s3,a0
  { // print all the env vars
    if(!nenv)
      92:	00002b17          	auipc	s6,0x2
      96:	9aeb2b03          	lw	s6,-1618(s6) # 1a40 <nenv>
      9a:	040b0163          	beqz	s6,dc <export+0x76>
    {
      printf("NO env var exported\n");
      return 0;
    }
    for(int i=0; i<nenv; i++)
      9e:	00002497          	auipc	s1,0x2
      a2:	a9248493          	addi	s1,s1,-1390 # 1b30 <envs>
      a6:	892a                	mv	s2,a0
      printf("export %s=%s\n", envs[i].name, envs[i].value);
      a8:	00001a97          	auipc	s5,0x1
      ac:	7a8a8a93          	addi	s5,s5,1960 # 1850 <malloc+0x10c>
    for(int i=0; i<nenv; i++)
      b0:	00002a17          	auipc	s4,0x2
      b4:	990a0a13          	addi	s4,s4,-1648 # 1a40 <nenv>
      b8:	0f605c63          	blez	s6,1b0 <export+0x14a>
      printf("export %s=%s\n", envs[i].name, envs[i].value);
      bc:	02048613          	addi	a2,s1,32
      c0:	85a6                	mv	a1,s1
      c2:	8556                	mv	a0,s5
      c4:	00001097          	auipc	ra,0x1
      c8:	5c2080e7          	jalr	1474(ra) # 1686 <printf>
    for(int i=0; i<nenv; i++)
      cc:	2905                	addiw	s2,s2,1
      ce:	08048493          	addi	s1,s1,128
      d2:	000a2783          	lw	a5,0(s4)
      d6:	fef943e3          	blt	s2,a5,bc <export+0x56>
      da:	a8d9                	j	1b0 <export+0x14a>
      printf("NO env var exported\n");
      dc:	00001517          	auipc	a0,0x1
      e0:	75c50513          	addi	a0,a0,1884 # 1838 <malloc+0xf4>
      e4:	00001097          	auipc	ra,0x1
      e8:	5a2080e7          	jalr	1442(ra) # 1686 <printf>
      return 0;
      ec:	89da                	mv	s3,s6
      ee:	a0c9                	j	1b0 <export+0x14a>
    return 0;
  }
  else if(nenv == NENVS)
      f0:	00002997          	auipc	s3,0x2
      f4:	9509a983          	lw	s3,-1712(s3) # 1a40 <nenv>
      f8:	47c1                	li	a5,16
      fa:	0cf98663          	beq	s3,a5,1c6 <export+0x160>
  {
    fprintf(2, "too many env vars\n");
    return -1;
  }
  char name[32], value[96];
  char *s = argv[1], *t = name;
      fe:	0084b903          	ld	s2,8(s1)

  for(s=argv[1], t=name; (*t=*s++)!='='; t++)
     102:	00190493          	addi	s1,s2,1
     106:	00094783          	lbu	a5,0(s2)
     10a:	faf40023          	sb	a5,-96(s0)
     10e:	03d00713          	li	a4,61
     112:	0ce78563          	beq	a5,a4,1dc <export+0x176>
     116:	fa040793          	addi	a5,s0,-96
     11a:	03d00693          	li	a3,61
     11e:	0785                	addi	a5,a5,1
     120:	0485                	addi	s1,s1,1
     122:	fff4c703          	lbu	a4,-1(s1)
     126:	00e78023          	sb	a4,0(a5)
     12a:	fed71ae3          	bne	a4,a3,11e <export+0xb8>
    ;
  *t = 0;
     12e:	00078023          	sb	zero,0(a5)

  if(checkenvname(name) != ((s - argv[1]) - 1))
     132:	fa040513          	addi	a0,s0,-96
     136:	00000097          	auipc	ra,0x0
     13a:	eca080e7          	jalr	-310(ra) # 0 <checkenvname>
     13e:	41248933          	sub	s2,s1,s2
     142:	197d                	addi	s2,s2,-1
     144:	09251f63          	bne	a0,s2,1e2 <export+0x17c>
  {
    fprintf(2, "Invalid NAME!\n");
    return -1;
  }
  for(t=value; (*t=*s); s++, t++)
     148:	0004c703          	lbu	a4,0(s1)
     14c:	f4e40023          	sb	a4,-192(s0)
     150:	f4040793          	addi	a5,s0,-192
     154:	cb01                	beqz	a4,164 <export+0xfe>
     156:	0485                	addi	s1,s1,1
     158:	0785                	addi	a5,a5,1
     15a:	0004c703          	lbu	a4,0(s1)
     15e:	00e78023          	sb	a4,0(a5)
     162:	fb75                	bnez	a4,156 <export+0xf0>
    ;
  if(*--t == '/')
     164:	fff7c683          	lbu	a3,-1(a5)
     168:	02f00713          	li	a4,47
     16c:	08e68663          	beq	a3,a4,1f8 <export+0x192>
    *t = 0;
  
  strcpy(envs[nenv].name, name);
     170:	00799513          	slli	a0,s3,0x7
     174:	00002917          	auipc	s2,0x2
     178:	9bc90913          	addi	s2,s2,-1604 # 1b30 <envs>
     17c:	fa040593          	addi	a1,s0,-96
     180:	954a                	add	a0,a0,s2
     182:	00001097          	auipc	ra,0x1
     186:	eae080e7          	jalr	-338(ra) # 1030 <strcpy>
  strcpy(envs[nenv].value, value);
     18a:	00002497          	auipc	s1,0x2
     18e:	8b648493          	addi	s1,s1,-1866 # 1a40 <nenv>
     192:	4088                	lw	a0,0(s1)
     194:	051e                	slli	a0,a0,0x7
     196:	02050513          	addi	a0,a0,32
     19a:	f4040593          	addi	a1,s0,-192
     19e:	954a                	add	a0,a0,s2
     1a0:	00001097          	auipc	ra,0x1
     1a4:	e90080e7          	jalr	-368(ra) # 1030 <strcpy>
  nenv++;
     1a8:	409c                	lw	a5,0(s1)
     1aa:	2785                	addiw	a5,a5,1
     1ac:	c09c                	sw	a5,0(s1)
  return 0;
     1ae:	4981                	li	s3,0
}
     1b0:	854e                	mv	a0,s3
     1b2:	70ea                	ld	ra,184(sp)
     1b4:	744a                	ld	s0,176(sp)
     1b6:	74aa                	ld	s1,168(sp)
     1b8:	790a                	ld	s2,160(sp)
     1ba:	69ea                	ld	s3,152(sp)
     1bc:	6a4a                	ld	s4,144(sp)
     1be:	6aaa                	ld	s5,136(sp)
     1c0:	6b0a                	ld	s6,128(sp)
     1c2:	6129                	addi	sp,sp,192
     1c4:	8082                	ret
    fprintf(2, "too many env vars\n");
     1c6:	00001597          	auipc	a1,0x1
     1ca:	69a58593          	addi	a1,a1,1690 # 1860 <malloc+0x11c>
     1ce:	4509                	li	a0,2
     1d0:	00001097          	auipc	ra,0x1
     1d4:	488080e7          	jalr	1160(ra) # 1658 <fprintf>
    return -1;
     1d8:	59fd                	li	s3,-1
     1da:	bfd9                	j	1b0 <export+0x14a>
  for(s=argv[1], t=name; (*t=*s++)!='='; t++)
     1dc:	fa040793          	addi	a5,s0,-96
     1e0:	b7b9                	j	12e <export+0xc8>
    fprintf(2, "Invalid NAME!\n");
     1e2:	00001597          	auipc	a1,0x1
     1e6:	69658593          	addi	a1,a1,1686 # 1878 <malloc+0x134>
     1ea:	4509                	li	a0,2
     1ec:	00001097          	auipc	ra,0x1
     1f0:	46c080e7          	jalr	1132(ra) # 1658 <fprintf>
    return -1;
     1f4:	59fd                	li	s3,-1
     1f6:	bf6d                	j	1b0 <export+0x14a>
    *t = 0;
     1f8:	fe078fa3          	sb	zero,-1(a5)
     1fc:	bf95                	j	170 <export+0x10a>

00000000000001fe <replace>:

int
replace(char *buf)
{
     1fe:	7111                	addi	sp,sp,-256
     200:	fd86                	sd	ra,248(sp)
     202:	f9a2                	sd	s0,240(sp)
     204:	f5a6                	sd	s1,232(sp)
     206:	f1ca                	sd	s2,224(sp)
     208:	edce                	sd	s3,216(sp)
     20a:	e9d2                	sd	s4,208(sp)
     20c:	e5d6                	sd	s5,200(sp)
     20e:	e1da                	sd	s6,192(sp)
     210:	fd5e                	sd	s7,184(sp)
     212:	f962                	sd	s8,176(sp)
     214:	f566                	sd	s9,168(sp)
     216:	f16a                	sd	s10,160(sp)
     218:	ed6e                	sd	s11,152(sp)
     21a:	0200                	addi	s0,sp,256
     21c:	89aa                	mv	s3,a0
  char raw[100], name[32], *s, *t, *tmp;
  int n = 0;
  strcpy(raw, buf);
     21e:	85aa                	mv	a1,a0
     220:	f2840513          	addi	a0,s0,-216
     224:	00001097          	auipc	ra,0x1
     228:	e0c080e7          	jalr	-500(ra) # 1030 <strcpy>
  for(s=raw, t=buf; (*t=*s); t++)
     22c:	f2844783          	lbu	a5,-216(s0)
     230:	00f98023          	sb	a5,0(s3)
     234:	c7f5                	beqz	a5,320 <replace+0x122>
  int n = 0;
     236:	4c81                	li	s9,0
  for(s=raw, t=buf; (*t=*s); t++)
     238:	f2840713          	addi	a4,s0,-216
  {
    if(*s++ == '$'){
     23c:	02400c13          	li	s8,36
      tmp = name;
      if((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || *s == '_')
     240:	4965                	li	s2,25
      {
        *tmp++ = *s++;
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
     242:	4a25                	li	s4,9
     244:	05f00a93          	li	s5,95
          *tmp++ = *s++;
        *tmp = 0;
        for(int i=0; i<nenv; i++)
     248:	00001b17          	auipc	s6,0x1
     24c:	7f8b0b13          	addi	s6,s6,2040 # 1a40 <nenv>
          if(!strcmp(name, envs[i].name))
     250:	f0840b93          	addi	s7,s0,-248
     254:	a03d                	j	282 <replace+0x84>
      if((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || *s == '_')
     256:	00174683          	lbu	a3,1(a4)
     25a:	fdf6f793          	andi	a5,a3,-33
     25e:	fbf7879b          	addiw	a5,a5,-65
     262:	0ff7f793          	andi	a5,a5,255
     266:	02f97563          	bgeu	s2,a5,290 <replace+0x92>
     26a:	03568363          	beq	a3,s5,290 <replace+0x92>
            for(tmp=envs[i].value; (*t=*tmp); t++, tmp++)
              ;
        t--;
      }
      n++;
     26e:	2c85                	addiw	s9,s9,1
     270:	86ce                	mv	a3,s3
     272:	8726                	mv	a4,s1
  for(s=raw, t=buf; (*t=*s); t++)
     274:	00168993          	addi	s3,a3,1
     278:	00074783          	lbu	a5,0(a4)
     27c:	00f680a3          	sb	a5,1(a3)
     280:	c3cd                	beqz	a5,322 <replace+0x124>
    if(*s++ == '$'){
     282:	00170493          	addi	s1,a4,1
     286:	fd8788e3          	beq	a5,s8,256 <replace+0x58>
     28a:	86ce                	mv	a3,s3
     28c:	8726                	mv	a4,s1
     28e:	b7dd                	j	274 <replace+0x76>
        *tmp++ = *s++;
     290:	00270493          	addi	s1,a4,2
     294:	f0d40423          	sb	a3,-248(s0)
     298:	f0940693          	addi	a3,s0,-247
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
     29c:	a029                	j	2a6 <replace+0xa8>
          *tmp++ = *s++;
     29e:	0485                	addi	s1,s1,1
     2a0:	0685                	addi	a3,a3,1
     2a2:	fee68fa3          	sb	a4,-1(a3)
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
     2a6:	0004c703          	lbu	a4,0(s1)
     2aa:	fdf77793          	andi	a5,a4,-33
     2ae:	fbf7879b          	addiw	a5,a5,-65
     2b2:	0ff7f793          	andi	a5,a5,255
     2b6:	fef974e3          	bgeu	s2,a5,29e <replace+0xa0>
     2ba:	fd07079b          	addiw	a5,a4,-48
     2be:	0ff7f793          	andi	a5,a5,255
     2c2:	fcfa7ee3          	bgeu	s4,a5,29e <replace+0xa0>
     2c6:	fd570ce3          	beq	a4,s5,29e <replace+0xa0>
        *tmp = 0;
     2ca:	00068023          	sb	zero,0(a3)
        for(int i=0; i<nenv; i++)
     2ce:	000b2783          	lw	a5,0(s6)
     2d2:	04f05563          	blez	a5,31c <replace+0x11e>
     2d6:	00002d17          	auipc	s10,0x2
     2da:	87ad0d13          	addi	s10,s10,-1926 # 1b50 <envs+0x20>
     2de:	4d81                	li	s11,0
     2e0:	a801                	j	2f0 <replace+0xf2>
     2e2:	2d85                	addiw	s11,s11,1
     2e4:	080d0d13          	addi	s10,s10,128
     2e8:	000b2783          	lw	a5,0(s6)
     2ec:	02fdd863          	bge	s11,a5,31c <replace+0x11e>
          if(!strcmp(name, envs[i].name))
     2f0:	fe0d0593          	addi	a1,s10,-32
     2f4:	855e                	mv	a0,s7
     2f6:	00001097          	auipc	ra,0x1
     2fa:	d84080e7          	jalr	-636(ra) # 107a <strcmp>
     2fe:	f175                	bnez	a0,2e2 <replace+0xe4>
            for(tmp=envs[i].value; (*t=*tmp); t++, tmp++)
     300:	87ea                	mv	a5,s10
     302:	000d4703          	lbu	a4,0(s10)
     306:	00e98023          	sb	a4,0(s3)
     30a:	df61                	beqz	a4,2e2 <replace+0xe4>
     30c:	0985                	addi	s3,s3,1
     30e:	0785                	addi	a5,a5,1
     310:	0007c703          	lbu	a4,0(a5)
     314:	00e98023          	sb	a4,0(s3)
     318:	fb75                	bnez	a4,30c <replace+0x10e>
     31a:	b7e1                	j	2e2 <replace+0xe4>
        t--;
     31c:	19fd                	addi	s3,s3,-1
     31e:	bf81                	j	26e <replace+0x70>
  int n = 0;
     320:	4c81                	li	s9,0
    }
  }
  return n;
}
     322:	8566                	mv	a0,s9
     324:	70ee                	ld	ra,248(sp)
     326:	744e                	ld	s0,240(sp)
     328:	74ae                	ld	s1,232(sp)
     32a:	790e                	ld	s2,224(sp)
     32c:	69ee                	ld	s3,216(sp)
     32e:	6a4e                	ld	s4,208(sp)
     330:	6aae                	ld	s5,200(sp)
     332:	6b0e                	ld	s6,192(sp)
     334:	7bea                	ld	s7,184(sp)
     336:	7c4a                	ld	s8,176(sp)
     338:	7caa                	ld	s9,168(sp)
     33a:	7d0a                	ld	s10,160(sp)
     33c:	6dea                	ld	s11,152(sp)
     33e:	6111                	addi	sp,sp,256
     340:	8082                	ret

0000000000000342 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
     342:	1101                	addi	sp,sp,-32
     344:	ec06                	sd	ra,24(sp)
     346:	e822                	sd	s0,16(sp)
     348:	e426                	sd	s1,8(sp)
     34a:	e04a                	sd	s2,0(sp)
     34c:	1000                	addi	s0,sp,32
     34e:	84aa                	mv	s1,a0
     350:	892e                	mv	s2,a1
  fprintf(2, "-> %s $ ", mycwd);
     352:	00001617          	auipc	a2,0x1
     356:	6f660613          	addi	a2,a2,1782 # 1a48 <mycwd>
     35a:	00001597          	auipc	a1,0x1
     35e:	52e58593          	addi	a1,a1,1326 # 1888 <malloc+0x144>
     362:	4509                	li	a0,2
     364:	00001097          	auipc	ra,0x1
     368:	2f4080e7          	jalr	756(ra) # 1658 <fprintf>
  memset(buf, 0, nbuf);
     36c:	864a                	mv	a2,s2
     36e:	4581                	li	a1,0
     370:	8526                	mv	a0,s1
     372:	00001097          	auipc	ra,0x1
     376:	d5e080e7          	jalr	-674(ra) # 10d0 <memset>
  gets(buf, nbuf);
     37a:	85ca                	mv	a1,s2
     37c:	8526                	mv	a0,s1
     37e:	00001097          	auipc	ra,0x1
     382:	d98080e7          	jalr	-616(ra) # 1116 <gets>
  if(buf[0] == 0) // EOF
     386:	0004c503          	lbu	a0,0(s1)
     38a:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
     38e:	40a00533          	neg	a0,a0
     392:	60e2                	ld	ra,24(sp)
     394:	6442                	ld	s0,16(sp)
     396:	64a2                	ld	s1,8(sp)
     398:	6902                	ld	s2,0(sp)
     39a:	6105                	addi	sp,sp,32
     39c:	8082                	ret

000000000000039e <panic>:
  exit(0);
}

void
panic(char *s)
{
     39e:	1141                	addi	sp,sp,-16
     3a0:	e406                	sd	ra,8(sp)
     3a2:	e022                	sd	s0,0(sp)
     3a4:	0800                	addi	s0,sp,16
     3a6:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
     3a8:	00001597          	auipc	a1,0x1
     3ac:	4f058593          	addi	a1,a1,1264 # 1898 <malloc+0x154>
     3b0:	4509                	li	a0,2
     3b2:	00001097          	auipc	ra,0x1
     3b6:	2a6080e7          	jalr	678(ra) # 1658 <fprintf>
  exit(1);
     3ba:	4505                	li	a0,1
     3bc:	00001097          	auipc	ra,0x1
     3c0:	f2c080e7          	jalr	-212(ra) # 12e8 <exit>

00000000000003c4 <fork1>:
}

int
fork1(void)
{
     3c4:	1141                	addi	sp,sp,-16
     3c6:	e406                	sd	ra,8(sp)
     3c8:	e022                	sd	s0,0(sp)
     3ca:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
     3cc:	00001097          	auipc	ra,0x1
     3d0:	f14080e7          	jalr	-236(ra) # 12e0 <fork>
  if(pid == -1)
     3d4:	57fd                	li	a5,-1
     3d6:	00f50663          	beq	a0,a5,3e2 <fork1+0x1e>
    panic("fork");
  return pid;
}
     3da:	60a2                	ld	ra,8(sp)
     3dc:	6402                	ld	s0,0(sp)
     3de:	0141                	addi	sp,sp,16
     3e0:	8082                	ret
    panic("fork");
     3e2:	00001517          	auipc	a0,0x1
     3e6:	4be50513          	addi	a0,a0,1214 # 18a0 <malloc+0x15c>
     3ea:	00000097          	auipc	ra,0x0
     3ee:	fb4080e7          	jalr	-76(ra) # 39e <panic>

00000000000003f2 <runcmd>:
{
     3f2:	7135                	addi	sp,sp,-160
     3f4:	ed06                	sd	ra,152(sp)
     3f6:	e922                	sd	s0,144(sp)
     3f8:	e526                	sd	s1,136(sp)
     3fa:	e14a                	sd	s2,128(sp)
     3fc:	fcce                	sd	s3,120(sp)
     3fe:	f8d2                	sd	s4,112(sp)
     400:	f4d6                	sd	s5,104(sp)
     402:	f0da                	sd	s6,96(sp)
     404:	ecde                	sd	s7,88(sp)
     406:	1100                	addi	s0,sp,160
  if(cmd == 0)
     408:	c10d                	beqz	a0,42a <runcmd+0x38>
     40a:	84aa                	mv	s1,a0
  switch(cmd->type){
     40c:	4118                	lw	a4,0(a0)
     40e:	4795                	li	a5,5
     410:	02e7e263          	bltu	a5,a4,434 <runcmd+0x42>
     414:	00056783          	lwu	a5,0(a0)
     418:	078a                	slli	a5,a5,0x2
     41a:	00001717          	auipc	a4,0x1
     41e:	5c670713          	addi	a4,a4,1478 # 19e0 <malloc+0x29c>
     422:	97ba                	add	a5,a5,a4
     424:	439c                	lw	a5,0(a5)
     426:	97ba                	add	a5,a5,a4
     428:	8782                	jr	a5
    exit(1);
     42a:	4505                	li	a0,1
     42c:	00001097          	auipc	ra,0x1
     430:	ebc080e7          	jalr	-324(ra) # 12e8 <exit>
    panic("runcmd");
     434:	00001517          	auipc	a0,0x1
     438:	47450513          	addi	a0,a0,1140 # 18a8 <malloc+0x164>
     43c:	00000097          	auipc	ra,0x0
     440:	f62080e7          	jalr	-158(ra) # 39e <panic>
    if(ecmd->argv[0] == 0)
     444:	6508                	ld	a0,8(a0)
     446:	c155                	beqz	a0,4ea <runcmd+0xf8>
    exec(ecmd->argv[0], ecmd->argv);
     448:	00848a13          	addi	s4,s1,8
     44c:	85d2                	mv	a1,s4
     44e:	00001097          	auipc	ra,0x1
     452:	ed2080e7          	jalr	-302(ra) # 1320 <exec>
    for(i=0; i<nenv; i++)
     456:	00001797          	auipc	a5,0x1
     45a:	5ea7a783          	lw	a5,1514(a5) # 1a40 <nenv>
     45e:	06f05763          	blez	a5,4cc <runcmd+0xda>
     462:	00001917          	auipc	s2,0x1
     466:	6ef90913          	addi	s2,s2,1775 # 1b51 <envs+0x21>
     46a:	4981                	li	s3,0
      *s_tmp++ = '/';
     46c:	02f00b93          	li	s7,47
      exec(env_cmd, ecmd->argv);
     470:	f6840b13          	addi	s6,s0,-152
    for(i=0; i<nenv; i++)
     474:	00001a97          	auipc	s5,0x1
     478:	5cca8a93          	addi	s5,s5,1484 # 1a40 <nenv>
      while((*s_tmp = *d_tmp++))
     47c:	874a                	mv	a4,s2
     47e:	fff94783          	lbu	a5,-1(s2)
     482:	f6f40423          	sb	a5,-152(s0)
     486:	c7bd                	beqz	a5,4f4 <runcmd+0x102>
      char *s_tmp = env_cmd;
     488:	f6840793          	addi	a5,s0,-152
        s_tmp++;
     48c:	0785                	addi	a5,a5,1
      while((*s_tmp = *d_tmp++))
     48e:	0705                	addi	a4,a4,1
     490:	fff74683          	lbu	a3,-1(a4)
     494:	00d78023          	sb	a3,0(a5)
     498:	faf5                	bnez	a3,48c <runcmd+0x9a>
      *s_tmp++ = '/';
     49a:	00178713          	addi	a4,a5,1
     49e:	01778023          	sb	s7,0(a5)
      d_tmp = ecmd->argv[0];
     4a2:	649c                	ld	a5,8(s1)
      while((*s_tmp++ = *d_tmp++))
     4a4:	0785                	addi	a5,a5,1
     4a6:	0705                	addi	a4,a4,1
     4a8:	fff7c683          	lbu	a3,-1(a5)
     4ac:	fed70fa3          	sb	a3,-1(a4)
     4b0:	faf5                	bnez	a3,4a4 <runcmd+0xb2>
      exec(env_cmd, ecmd->argv);
     4b2:	85d2                	mv	a1,s4
     4b4:	855a                	mv	a0,s6
     4b6:	00001097          	auipc	ra,0x1
     4ba:	e6a080e7          	jalr	-406(ra) # 1320 <exec>
    for(i=0; i<nenv; i++)
     4be:	2985                	addiw	s3,s3,1
     4c0:	08090913          	addi	s2,s2,128
     4c4:	000aa783          	lw	a5,0(s5)
     4c8:	faf9cae3          	blt	s3,a5,47c <runcmd+0x8a>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     4cc:	6490                	ld	a2,8(s1)
     4ce:	00001597          	auipc	a1,0x1
     4d2:	3e258593          	addi	a1,a1,994 # 18b0 <malloc+0x16c>
     4d6:	4509                	li	a0,2
     4d8:	00001097          	auipc	ra,0x1
     4dc:	180080e7          	jalr	384(ra) # 1658 <fprintf>
  exit(0);
     4e0:	4501                	li	a0,0
     4e2:	00001097          	auipc	ra,0x1
     4e6:	e06080e7          	jalr	-506(ra) # 12e8 <exit>
      exit(1);
     4ea:	4505                	li	a0,1
     4ec:	00001097          	auipc	ra,0x1
     4f0:	dfc080e7          	jalr	-516(ra) # 12e8 <exit>
      char *s_tmp = env_cmd;
     4f4:	f6840793          	addi	a5,s0,-152
     4f8:	b74d                	j	49a <runcmd+0xa8>
    close(rcmd->fd);
     4fa:	5148                	lw	a0,36(a0)
     4fc:	00001097          	auipc	ra,0x1
     500:	e14080e7          	jalr	-492(ra) # 1310 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     504:	508c                	lw	a1,32(s1)
     506:	6888                	ld	a0,16(s1)
     508:	00001097          	auipc	ra,0x1
     50c:	e20080e7          	jalr	-480(ra) # 1328 <open>
     510:	00054763          	bltz	a0,51e <runcmd+0x12c>
    runcmd(rcmd->cmd);
     514:	6488                	ld	a0,8(s1)
     516:	00000097          	auipc	ra,0x0
     51a:	edc080e7          	jalr	-292(ra) # 3f2 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     51e:	6890                	ld	a2,16(s1)
     520:	00001597          	auipc	a1,0x1
     524:	3a058593          	addi	a1,a1,928 # 18c0 <malloc+0x17c>
     528:	4509                	li	a0,2
     52a:	00001097          	auipc	ra,0x1
     52e:	12e080e7          	jalr	302(ra) # 1658 <fprintf>
      exit(1);
     532:	4505                	li	a0,1
     534:	00001097          	auipc	ra,0x1
     538:	db4080e7          	jalr	-588(ra) # 12e8 <exit>
    if(fork1() == 0)
     53c:	00000097          	auipc	ra,0x0
     540:	e88080e7          	jalr	-376(ra) # 3c4 <fork1>
     544:	c919                	beqz	a0,55a <runcmd+0x168>
    wait(0);
     546:	4501                	li	a0,0
     548:	00001097          	auipc	ra,0x1
     54c:	da8080e7          	jalr	-600(ra) # 12f0 <wait>
    runcmd(lcmd->right);
     550:	6888                	ld	a0,16(s1)
     552:	00000097          	auipc	ra,0x0
     556:	ea0080e7          	jalr	-352(ra) # 3f2 <runcmd>
      runcmd(lcmd->left);
     55a:	6488                	ld	a0,8(s1)
     55c:	00000097          	auipc	ra,0x0
     560:	e96080e7          	jalr	-362(ra) # 3f2 <runcmd>
    if(pipe(p) < 0)
     564:	fa840513          	addi	a0,s0,-88
     568:	00001097          	auipc	ra,0x1
     56c:	d90080e7          	jalr	-624(ra) # 12f8 <pipe>
     570:	04054363          	bltz	a0,5b6 <runcmd+0x1c4>
    if(fork1() == 0){
     574:	00000097          	auipc	ra,0x0
     578:	e50080e7          	jalr	-432(ra) # 3c4 <fork1>
     57c:	c529                	beqz	a0,5c6 <runcmd+0x1d4>
    if(fork1() == 0){
     57e:	00000097          	auipc	ra,0x0
     582:	e46080e7          	jalr	-442(ra) # 3c4 <fork1>
     586:	cd25                	beqz	a0,5fe <runcmd+0x20c>
    close(p[0]);
     588:	fa842503          	lw	a0,-88(s0)
     58c:	00001097          	auipc	ra,0x1
     590:	d84080e7          	jalr	-636(ra) # 1310 <close>
    close(p[1]);
     594:	fac42503          	lw	a0,-84(s0)
     598:	00001097          	auipc	ra,0x1
     59c:	d78080e7          	jalr	-648(ra) # 1310 <close>
    wait(0);
     5a0:	4501                	li	a0,0
     5a2:	00001097          	auipc	ra,0x1
     5a6:	d4e080e7          	jalr	-690(ra) # 12f0 <wait>
    wait(0);
     5aa:	4501                	li	a0,0
     5ac:	00001097          	auipc	ra,0x1
     5b0:	d44080e7          	jalr	-700(ra) # 12f0 <wait>
    break;
     5b4:	b735                	j	4e0 <runcmd+0xee>
      panic("pipe");
     5b6:	00001517          	auipc	a0,0x1
     5ba:	31a50513          	addi	a0,a0,794 # 18d0 <malloc+0x18c>
     5be:	00000097          	auipc	ra,0x0
     5c2:	de0080e7          	jalr	-544(ra) # 39e <panic>
      close(1);
     5c6:	4505                	li	a0,1
     5c8:	00001097          	auipc	ra,0x1
     5cc:	d48080e7          	jalr	-696(ra) # 1310 <close>
      dup(p[1]);
     5d0:	fac42503          	lw	a0,-84(s0)
     5d4:	00001097          	auipc	ra,0x1
     5d8:	d74080e7          	jalr	-652(ra) # 1348 <dup>
      close(p[0]);
     5dc:	fa842503          	lw	a0,-88(s0)
     5e0:	00001097          	auipc	ra,0x1
     5e4:	d30080e7          	jalr	-720(ra) # 1310 <close>
      close(p[1]);
     5e8:	fac42503          	lw	a0,-84(s0)
     5ec:	00001097          	auipc	ra,0x1
     5f0:	d24080e7          	jalr	-732(ra) # 1310 <close>
      runcmd(pcmd->left);
     5f4:	6488                	ld	a0,8(s1)
     5f6:	00000097          	auipc	ra,0x0
     5fa:	dfc080e7          	jalr	-516(ra) # 3f2 <runcmd>
      close(0);
     5fe:	00001097          	auipc	ra,0x1
     602:	d12080e7          	jalr	-750(ra) # 1310 <close>
      dup(p[0]);
     606:	fa842503          	lw	a0,-88(s0)
     60a:	00001097          	auipc	ra,0x1
     60e:	d3e080e7          	jalr	-706(ra) # 1348 <dup>
      close(p[0]);
     612:	fa842503          	lw	a0,-88(s0)
     616:	00001097          	auipc	ra,0x1
     61a:	cfa080e7          	jalr	-774(ra) # 1310 <close>
      close(p[1]);
     61e:	fac42503          	lw	a0,-84(s0)
     622:	00001097          	auipc	ra,0x1
     626:	cee080e7          	jalr	-786(ra) # 1310 <close>
      runcmd(pcmd->right);
     62a:	6888                	ld	a0,16(s1)
     62c:	00000097          	auipc	ra,0x0
     630:	dc6080e7          	jalr	-570(ra) # 3f2 <runcmd>
    if(fork1() == 0)
     634:	00000097          	auipc	ra,0x0
     638:	d90080e7          	jalr	-624(ra) # 3c4 <fork1>
     63c:	ea0512e3          	bnez	a0,4e0 <runcmd+0xee>
      runcmd(bcmd->cmd);
     640:	6488                	ld	a0,8(s1)
     642:	00000097          	auipc	ra,0x0
     646:	db0080e7          	jalr	-592(ra) # 3f2 <runcmd>

000000000000064a <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     64a:	1101                	addi	sp,sp,-32
     64c:	ec06                	sd	ra,24(sp)
     64e:	e822                	sd	s0,16(sp)
     650:	e426                	sd	s1,8(sp)
     652:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     654:	0a800513          	li	a0,168
     658:	00001097          	auipc	ra,0x1
     65c:	0ec080e7          	jalr	236(ra) # 1744 <malloc>
     660:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     662:	0a800613          	li	a2,168
     666:	4581                	li	a1,0
     668:	00001097          	auipc	ra,0x1
     66c:	a68080e7          	jalr	-1432(ra) # 10d0 <memset>
  cmd->type = EXEC;
     670:	4785                	li	a5,1
     672:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     674:	8526                	mv	a0,s1
     676:	60e2                	ld	ra,24(sp)
     678:	6442                	ld	s0,16(sp)
     67a:	64a2                	ld	s1,8(sp)
     67c:	6105                	addi	sp,sp,32
     67e:	8082                	ret

0000000000000680 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     680:	7139                	addi	sp,sp,-64
     682:	fc06                	sd	ra,56(sp)
     684:	f822                	sd	s0,48(sp)
     686:	f426                	sd	s1,40(sp)
     688:	f04a                	sd	s2,32(sp)
     68a:	ec4e                	sd	s3,24(sp)
     68c:	e852                	sd	s4,16(sp)
     68e:	e456                	sd	s5,8(sp)
     690:	e05a                	sd	s6,0(sp)
     692:	0080                	addi	s0,sp,64
     694:	8b2a                	mv	s6,a0
     696:	8aae                	mv	s5,a1
     698:	8a32                	mv	s4,a2
     69a:	89b6                	mv	s3,a3
     69c:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     69e:	02800513          	li	a0,40
     6a2:	00001097          	auipc	ra,0x1
     6a6:	0a2080e7          	jalr	162(ra) # 1744 <malloc>
     6aa:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     6ac:	02800613          	li	a2,40
     6b0:	4581                	li	a1,0
     6b2:	00001097          	auipc	ra,0x1
     6b6:	a1e080e7          	jalr	-1506(ra) # 10d0 <memset>
  cmd->type = REDIR;
     6ba:	4789                	li	a5,2
     6bc:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     6be:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     6c2:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     6c6:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     6ca:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     6ce:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     6d2:	8526                	mv	a0,s1
     6d4:	70e2                	ld	ra,56(sp)
     6d6:	7442                	ld	s0,48(sp)
     6d8:	74a2                	ld	s1,40(sp)
     6da:	7902                	ld	s2,32(sp)
     6dc:	69e2                	ld	s3,24(sp)
     6de:	6a42                	ld	s4,16(sp)
     6e0:	6aa2                	ld	s5,8(sp)
     6e2:	6b02                	ld	s6,0(sp)
     6e4:	6121                	addi	sp,sp,64
     6e6:	8082                	ret

00000000000006e8 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     6e8:	7179                	addi	sp,sp,-48
     6ea:	f406                	sd	ra,40(sp)
     6ec:	f022                	sd	s0,32(sp)
     6ee:	ec26                	sd	s1,24(sp)
     6f0:	e84a                	sd	s2,16(sp)
     6f2:	e44e                	sd	s3,8(sp)
     6f4:	1800                	addi	s0,sp,48
     6f6:	89aa                	mv	s3,a0
     6f8:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6fa:	4561                	li	a0,24
     6fc:	00001097          	auipc	ra,0x1
     700:	048080e7          	jalr	72(ra) # 1744 <malloc>
     704:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     706:	4661                	li	a2,24
     708:	4581                	li	a1,0
     70a:	00001097          	auipc	ra,0x1
     70e:	9c6080e7          	jalr	-1594(ra) # 10d0 <memset>
  cmd->type = PIPE;
     712:	478d                	li	a5,3
     714:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     716:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     71a:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     71e:	8526                	mv	a0,s1
     720:	70a2                	ld	ra,40(sp)
     722:	7402                	ld	s0,32(sp)
     724:	64e2                	ld	s1,24(sp)
     726:	6942                	ld	s2,16(sp)
     728:	69a2                	ld	s3,8(sp)
     72a:	6145                	addi	sp,sp,48
     72c:	8082                	ret

000000000000072e <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     72e:	7179                	addi	sp,sp,-48
     730:	f406                	sd	ra,40(sp)
     732:	f022                	sd	s0,32(sp)
     734:	ec26                	sd	s1,24(sp)
     736:	e84a                	sd	s2,16(sp)
     738:	e44e                	sd	s3,8(sp)
     73a:	1800                	addi	s0,sp,48
     73c:	89aa                	mv	s3,a0
     73e:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     740:	4561                	li	a0,24
     742:	00001097          	auipc	ra,0x1
     746:	002080e7          	jalr	2(ra) # 1744 <malloc>
     74a:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     74c:	4661                	li	a2,24
     74e:	4581                	li	a1,0
     750:	00001097          	auipc	ra,0x1
     754:	980080e7          	jalr	-1664(ra) # 10d0 <memset>
  cmd->type = LIST;
     758:	4791                	li	a5,4
     75a:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     75c:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     760:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     764:	8526                	mv	a0,s1
     766:	70a2                	ld	ra,40(sp)
     768:	7402                	ld	s0,32(sp)
     76a:	64e2                	ld	s1,24(sp)
     76c:	6942                	ld	s2,16(sp)
     76e:	69a2                	ld	s3,8(sp)
     770:	6145                	addi	sp,sp,48
     772:	8082                	ret

0000000000000774 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     774:	1101                	addi	sp,sp,-32
     776:	ec06                	sd	ra,24(sp)
     778:	e822                	sd	s0,16(sp)
     77a:	e426                	sd	s1,8(sp)
     77c:	e04a                	sd	s2,0(sp)
     77e:	1000                	addi	s0,sp,32
     780:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     782:	4541                	li	a0,16
     784:	00001097          	auipc	ra,0x1
     788:	fc0080e7          	jalr	-64(ra) # 1744 <malloc>
     78c:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     78e:	4641                	li	a2,16
     790:	4581                	li	a1,0
     792:	00001097          	auipc	ra,0x1
     796:	93e080e7          	jalr	-1730(ra) # 10d0 <memset>
  cmd->type = BACK;
     79a:	4795                	li	a5,5
     79c:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     79e:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     7a2:	8526                	mv	a0,s1
     7a4:	60e2                	ld	ra,24(sp)
     7a6:	6442                	ld	s0,16(sp)
     7a8:	64a2                	ld	s1,8(sp)
     7aa:	6902                	ld	s2,0(sp)
     7ac:	6105                	addi	sp,sp,32
     7ae:	8082                	ret

00000000000007b0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     7b0:	7139                	addi	sp,sp,-64
     7b2:	fc06                	sd	ra,56(sp)
     7b4:	f822                	sd	s0,48(sp)
     7b6:	f426                	sd	s1,40(sp)
     7b8:	f04a                	sd	s2,32(sp)
     7ba:	ec4e                	sd	s3,24(sp)
     7bc:	e852                	sd	s4,16(sp)
     7be:	e456                	sd	s5,8(sp)
     7c0:	e05a                	sd	s6,0(sp)
     7c2:	0080                	addi	s0,sp,64
     7c4:	8a2a                	mv	s4,a0
     7c6:	892e                	mv	s2,a1
     7c8:	8ab2                	mv	s5,a2
     7ca:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     7cc:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     7ce:	00001997          	auipc	s3,0x1
     7d2:	26298993          	addi	s3,s3,610 # 1a30 <whitespace>
     7d6:	00b4fd63          	bgeu	s1,a1,7f0 <gettoken+0x40>
     7da:	0004c583          	lbu	a1,0(s1)
     7de:	854e                	mv	a0,s3
     7e0:	00001097          	auipc	ra,0x1
     7e4:	912080e7          	jalr	-1774(ra) # 10f2 <strchr>
     7e8:	c501                	beqz	a0,7f0 <gettoken+0x40>
    s++;
     7ea:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     7ec:	fe9917e3          	bne	s2,s1,7da <gettoken+0x2a>
  if(q)
     7f0:	000a8463          	beqz	s5,7f8 <gettoken+0x48>
    *q = s;
     7f4:	009ab023          	sd	s1,0(s5)
  ret = *s;
     7f8:	0004c783          	lbu	a5,0(s1)
     7fc:	00078a9b          	sext.w	s5,a5
  switch(*s){
     800:	03c00713          	li	a4,60
     804:	06f76563          	bltu	a4,a5,86e <gettoken+0xbe>
     808:	03a00713          	li	a4,58
     80c:	00f76e63          	bltu	a4,a5,828 <gettoken+0x78>
     810:	cf89                	beqz	a5,82a <gettoken+0x7a>
     812:	02600713          	li	a4,38
     816:	00e78963          	beq	a5,a4,828 <gettoken+0x78>
     81a:	fd87879b          	addiw	a5,a5,-40
     81e:	0ff7f793          	andi	a5,a5,255
     822:	4705                	li	a4,1
     824:	06f76c63          	bltu	a4,a5,89c <gettoken+0xec>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     828:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     82a:	000b0463          	beqz	s6,832 <gettoken+0x82>
    *eq = s;
     82e:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     832:	00001997          	auipc	s3,0x1
     836:	1fe98993          	addi	s3,s3,510 # 1a30 <whitespace>
     83a:	0124fd63          	bgeu	s1,s2,854 <gettoken+0xa4>
     83e:	0004c583          	lbu	a1,0(s1)
     842:	854e                	mv	a0,s3
     844:	00001097          	auipc	ra,0x1
     848:	8ae080e7          	jalr	-1874(ra) # 10f2 <strchr>
     84c:	c501                	beqz	a0,854 <gettoken+0xa4>
    s++;
     84e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     850:	fe9917e3          	bne	s2,s1,83e <gettoken+0x8e>
  *ps = s;
     854:	009a3023          	sd	s1,0(s4)
  return ret;
}
     858:	8556                	mv	a0,s5
     85a:	70e2                	ld	ra,56(sp)
     85c:	7442                	ld	s0,48(sp)
     85e:	74a2                	ld	s1,40(sp)
     860:	7902                	ld	s2,32(sp)
     862:	69e2                	ld	s3,24(sp)
     864:	6a42                	ld	s4,16(sp)
     866:	6aa2                	ld	s5,8(sp)
     868:	6b02                	ld	s6,0(sp)
     86a:	6121                	addi	sp,sp,64
     86c:	8082                	ret
  switch(*s){
     86e:	03e00713          	li	a4,62
     872:	02e79163          	bne	a5,a4,894 <gettoken+0xe4>
    s++;
     876:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     87a:	0014c703          	lbu	a4,1(s1)
     87e:	03e00793          	li	a5,62
      s++;
     882:	0489                	addi	s1,s1,2
      ret = '+';
     884:	02b00a93          	li	s5,43
    if(*s == '>'){
     888:	faf701e3          	beq	a4,a5,82a <gettoken+0x7a>
    s++;
     88c:	84b6                	mv	s1,a3
  ret = *s;
     88e:	03e00a93          	li	s5,62
     892:	bf61                	j	82a <gettoken+0x7a>
  switch(*s){
     894:	07c00713          	li	a4,124
     898:	f8e788e3          	beq	a5,a4,828 <gettoken+0x78>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     89c:	00001997          	auipc	s3,0x1
     8a0:	19498993          	addi	s3,s3,404 # 1a30 <whitespace>
     8a4:	00001a97          	auipc	s5,0x1
     8a8:	194a8a93          	addi	s5,s5,404 # 1a38 <symbols>
     8ac:	0324f563          	bgeu	s1,s2,8d6 <gettoken+0x126>
     8b0:	0004c583          	lbu	a1,0(s1)
     8b4:	854e                	mv	a0,s3
     8b6:	00001097          	auipc	ra,0x1
     8ba:	83c080e7          	jalr	-1988(ra) # 10f2 <strchr>
     8be:	e505                	bnez	a0,8e6 <gettoken+0x136>
     8c0:	0004c583          	lbu	a1,0(s1)
     8c4:	8556                	mv	a0,s5
     8c6:	00001097          	auipc	ra,0x1
     8ca:	82c080e7          	jalr	-2004(ra) # 10f2 <strchr>
     8ce:	e909                	bnez	a0,8e0 <gettoken+0x130>
      s++;
     8d0:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     8d2:	fc991fe3          	bne	s2,s1,8b0 <gettoken+0x100>
  if(eq)
     8d6:	06100a93          	li	s5,97
     8da:	f40b1ae3          	bnez	s6,82e <gettoken+0x7e>
     8de:	bf9d                	j	854 <gettoken+0xa4>
    ret = 'a';
     8e0:	06100a93          	li	s5,97
     8e4:	b799                	j	82a <gettoken+0x7a>
     8e6:	06100a93          	li	s5,97
     8ea:	b781                	j	82a <gettoken+0x7a>

00000000000008ec <peek>:

int
peek(char **ps, char *es, char *toks)
{
     8ec:	7139                	addi	sp,sp,-64
     8ee:	fc06                	sd	ra,56(sp)
     8f0:	f822                	sd	s0,48(sp)
     8f2:	f426                	sd	s1,40(sp)
     8f4:	f04a                	sd	s2,32(sp)
     8f6:	ec4e                	sd	s3,24(sp)
     8f8:	e852                	sd	s4,16(sp)
     8fa:	e456                	sd	s5,8(sp)
     8fc:	0080                	addi	s0,sp,64
     8fe:	8a2a                	mv	s4,a0
     900:	892e                	mv	s2,a1
     902:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     904:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     906:	00001997          	auipc	s3,0x1
     90a:	12a98993          	addi	s3,s3,298 # 1a30 <whitespace>
     90e:	00b4fd63          	bgeu	s1,a1,928 <peek+0x3c>
     912:	0004c583          	lbu	a1,0(s1)
     916:	854e                	mv	a0,s3
     918:	00000097          	auipc	ra,0x0
     91c:	7da080e7          	jalr	2010(ra) # 10f2 <strchr>
     920:	c501                	beqz	a0,928 <peek+0x3c>
    s++;
     922:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     924:	fe9917e3          	bne	s2,s1,912 <peek+0x26>
  *ps = s;
     928:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     92c:	0004c583          	lbu	a1,0(s1)
     930:	4501                	li	a0,0
     932:	e991                	bnez	a1,946 <peek+0x5a>
}
     934:	70e2                	ld	ra,56(sp)
     936:	7442                	ld	s0,48(sp)
     938:	74a2                	ld	s1,40(sp)
     93a:	7902                	ld	s2,32(sp)
     93c:	69e2                	ld	s3,24(sp)
     93e:	6a42                	ld	s4,16(sp)
     940:	6aa2                	ld	s5,8(sp)
     942:	6121                	addi	sp,sp,64
     944:	8082                	ret
  return *s && strchr(toks, *s);
     946:	8556                	mv	a0,s5
     948:	00000097          	auipc	ra,0x0
     94c:	7aa080e7          	jalr	1962(ra) # 10f2 <strchr>
     950:	00a03533          	snez	a0,a0
     954:	b7c5                	j	934 <peek+0x48>

0000000000000956 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     956:	7119                	addi	sp,sp,-128
     958:	fc86                	sd	ra,120(sp)
     95a:	f8a2                	sd	s0,112(sp)
     95c:	f4a6                	sd	s1,104(sp)
     95e:	f0ca                	sd	s2,96(sp)
     960:	ecce                	sd	s3,88(sp)
     962:	e8d2                	sd	s4,80(sp)
     964:	e4d6                	sd	s5,72(sp)
     966:	e0da                	sd	s6,64(sp)
     968:	fc5e                	sd	s7,56(sp)
     96a:	f862                	sd	s8,48(sp)
     96c:	f466                	sd	s9,40(sp)
     96e:	f06a                	sd	s10,32(sp)
     970:	ec6e                	sd	s11,24(sp)
     972:	0100                	addi	s0,sp,128
     974:	8a2a                	mv	s4,a0
     976:	89ae                	mv	s3,a1
     978:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     97a:	00001b97          	auipc	s7,0x1
     97e:	f7eb8b93          	addi	s7,s7,-130 # 18f8 <malloc+0x1b4>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     982:	f8040d13          	addi	s10,s0,-128
     986:	f8840c93          	addi	s9,s0,-120
     98a:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     98e:	03c00d93          	li	s11,60
  while(peek(ps, es, "<>")){
     992:	a02d                	j	9bc <parseredirs+0x66>
      panic("missing file for redirection");
     994:	00001517          	auipc	a0,0x1
     998:	f4450513          	addi	a0,a0,-188 # 18d8 <malloc+0x194>
     99c:	00000097          	auipc	ra,0x0
     9a0:	a02080e7          	jalr	-1534(ra) # 39e <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     9a4:	4701                	li	a4,0
     9a6:	4681                	li	a3,0
     9a8:	f8043603          	ld	a2,-128(s0)
     9ac:	f8843583          	ld	a1,-120(s0)
     9b0:	8552                	mv	a0,s4
     9b2:	00000097          	auipc	ra,0x0
     9b6:	cce080e7          	jalr	-818(ra) # 680 <redircmd>
     9ba:	8a2a                	mv	s4,a0
    switch(tok){
     9bc:	03e00b13          	li	s6,62
     9c0:	02b00a93          	li	s5,43
  while(peek(ps, es, "<>")){
     9c4:	865e                	mv	a2,s7
     9c6:	85ca                	mv	a1,s2
     9c8:	854e                	mv	a0,s3
     9ca:	00000097          	auipc	ra,0x0
     9ce:	f22080e7          	jalr	-222(ra) # 8ec <peek>
     9d2:	c535                	beqz	a0,a3e <parseredirs+0xe8>
    tok = gettoken(ps, es, 0, 0);
     9d4:	4681                	li	a3,0
     9d6:	4601                	li	a2,0
     9d8:	85ca                	mv	a1,s2
     9da:	854e                	mv	a0,s3
     9dc:	00000097          	auipc	ra,0x0
     9e0:	dd4080e7          	jalr	-556(ra) # 7b0 <gettoken>
     9e4:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     9e6:	86ea                	mv	a3,s10
     9e8:	8666                	mv	a2,s9
     9ea:	85ca                	mv	a1,s2
     9ec:	854e                	mv	a0,s3
     9ee:	00000097          	auipc	ra,0x0
     9f2:	dc2080e7          	jalr	-574(ra) # 7b0 <gettoken>
     9f6:	f9851fe3          	bne	a0,s8,994 <parseredirs+0x3e>
    switch(tok){
     9fa:	fbb485e3          	beq	s1,s11,9a4 <parseredirs+0x4e>
     9fe:	03648263          	beq	s1,s6,a22 <parseredirs+0xcc>
     a02:	fd5491e3          	bne	s1,s5,9c4 <parseredirs+0x6e>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_APPEND, 1);
     a06:	4705                	li	a4,1
     a08:	04500693          	li	a3,69
     a0c:	f8043603          	ld	a2,-128(s0)
     a10:	f8843583          	ld	a1,-120(s0)
     a14:	8552                	mv	a0,s4
     a16:	00000097          	auipc	ra,0x0
     a1a:	c6a080e7          	jalr	-918(ra) # 680 <redircmd>
     a1e:	8a2a                	mv	s4,a0
      break;
     a20:	bf71                	j	9bc <parseredirs+0x66>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     a22:	4705                	li	a4,1
     a24:	44100693          	li	a3,1089
     a28:	f8043603          	ld	a2,-128(s0)
     a2c:	f8843583          	ld	a1,-120(s0)
     a30:	8552                	mv	a0,s4
     a32:	00000097          	auipc	ra,0x0
     a36:	c4e080e7          	jalr	-946(ra) # 680 <redircmd>
     a3a:	8a2a                	mv	s4,a0
      break;
     a3c:	b741                	j	9bc <parseredirs+0x66>
    }
  }
  return cmd;
}
     a3e:	8552                	mv	a0,s4
     a40:	70e6                	ld	ra,120(sp)
     a42:	7446                	ld	s0,112(sp)
     a44:	74a6                	ld	s1,104(sp)
     a46:	7906                	ld	s2,96(sp)
     a48:	69e6                	ld	s3,88(sp)
     a4a:	6a46                	ld	s4,80(sp)
     a4c:	6aa6                	ld	s5,72(sp)
     a4e:	6b06                	ld	s6,64(sp)
     a50:	7be2                	ld	s7,56(sp)
     a52:	7c42                	ld	s8,48(sp)
     a54:	7ca2                	ld	s9,40(sp)
     a56:	7d02                	ld	s10,32(sp)
     a58:	6de2                	ld	s11,24(sp)
     a5a:	6109                	addi	sp,sp,128
     a5c:	8082                	ret

0000000000000a5e <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     a5e:	7119                	addi	sp,sp,-128
     a60:	fc86                	sd	ra,120(sp)
     a62:	f8a2                	sd	s0,112(sp)
     a64:	f4a6                	sd	s1,104(sp)
     a66:	f0ca                	sd	s2,96(sp)
     a68:	ecce                	sd	s3,88(sp)
     a6a:	e8d2                	sd	s4,80(sp)
     a6c:	e4d6                	sd	s5,72(sp)
     a6e:	e0da                	sd	s6,64(sp)
     a70:	fc5e                	sd	s7,56(sp)
     a72:	f862                	sd	s8,48(sp)
     a74:	f466                	sd	s9,40(sp)
     a76:	f06a                	sd	s10,32(sp)
     a78:	ec6e                	sd	s11,24(sp)
     a7a:	0100                	addi	s0,sp,128
     a7c:	8a2a                	mv	s4,a0
     a7e:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     a80:	00001617          	auipc	a2,0x1
     a84:	e8060613          	addi	a2,a2,-384 # 1900 <malloc+0x1bc>
     a88:	00000097          	auipc	ra,0x0
     a8c:	e64080e7          	jalr	-412(ra) # 8ec <peek>
     a90:	ed05                	bnez	a0,ac8 <parseexec+0x6a>
     a92:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     a94:	00000097          	auipc	ra,0x0
     a98:	bb6080e7          	jalr	-1098(ra) # 64a <execcmd>
     a9c:	8daa                	mv	s11,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     a9e:	8656                	mv	a2,s5
     aa0:	85d2                	mv	a1,s4
     aa2:	00000097          	auipc	ra,0x0
     aa6:	eb4080e7          	jalr	-332(ra) # 956 <parseredirs>
     aaa:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     aac:	008d8913          	addi	s2,s11,8
     ab0:	00001b17          	auipc	s6,0x1
     ab4:	e70b0b13          	addi	s6,s6,-400 # 1920 <malloc+0x1dc>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     ab8:	f8040c13          	addi	s8,s0,-128
     abc:	f8840b93          	addi	s7,s0,-120
      break;
    if(tok != 'a')
     ac0:	06100d13          	li	s10,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     ac4:	4ca9                	li	s9,10
  while(!peek(ps, es, "|)&;")){
     ac6:	a881                	j	b16 <parseexec+0xb8>
    return parseblock(ps, es);
     ac8:	85d6                	mv	a1,s5
     aca:	8552                	mv	a0,s4
     acc:	00000097          	auipc	ra,0x0
     ad0:	1bc080e7          	jalr	444(ra) # c88 <parseblock>
     ad4:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     ad6:	8526                	mv	a0,s1
     ad8:	70e6                	ld	ra,120(sp)
     ada:	7446                	ld	s0,112(sp)
     adc:	74a6                	ld	s1,104(sp)
     ade:	7906                	ld	s2,96(sp)
     ae0:	69e6                	ld	s3,88(sp)
     ae2:	6a46                	ld	s4,80(sp)
     ae4:	6aa6                	ld	s5,72(sp)
     ae6:	6b06                	ld	s6,64(sp)
     ae8:	7be2                	ld	s7,56(sp)
     aea:	7c42                	ld	s8,48(sp)
     aec:	7ca2                	ld	s9,40(sp)
     aee:	7d02                	ld	s10,32(sp)
     af0:	6de2                	ld	s11,24(sp)
     af2:	6109                	addi	sp,sp,128
     af4:	8082                	ret
      panic("syntax");
     af6:	00001517          	auipc	a0,0x1
     afa:	e1250513          	addi	a0,a0,-494 # 1908 <malloc+0x1c4>
     afe:	00000097          	auipc	ra,0x0
     b02:	8a0080e7          	jalr	-1888(ra) # 39e <panic>
    ret = parseredirs(ret, ps, es);
     b06:	8656                	mv	a2,s5
     b08:	85d2                	mv	a1,s4
     b0a:	8526                	mv	a0,s1
     b0c:	00000097          	auipc	ra,0x0
     b10:	e4a080e7          	jalr	-438(ra) # 956 <parseredirs>
     b14:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     b16:	865a                	mv	a2,s6
     b18:	85d6                	mv	a1,s5
     b1a:	8552                	mv	a0,s4
     b1c:	00000097          	auipc	ra,0x0
     b20:	dd0080e7          	jalr	-560(ra) # 8ec <peek>
     b24:	e121                	bnez	a0,b64 <parseexec+0x106>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     b26:	86e2                	mv	a3,s8
     b28:	865e                	mv	a2,s7
     b2a:	85d6                	mv	a1,s5
     b2c:	8552                	mv	a0,s4
     b2e:	00000097          	auipc	ra,0x0
     b32:	c82080e7          	jalr	-894(ra) # 7b0 <gettoken>
     b36:	c51d                	beqz	a0,b64 <parseexec+0x106>
    if(tok != 'a')
     b38:	fba51fe3          	bne	a0,s10,af6 <parseexec+0x98>
    cmd->argv[argc] = q;
     b3c:	f8843783          	ld	a5,-120(s0)
     b40:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     b44:	f8043783          	ld	a5,-128(s0)
     b48:	04f93823          	sd	a5,80(s2)
    argc++;
     b4c:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     b4e:	0921                	addi	s2,s2,8
     b50:	fb999be3          	bne	s3,s9,b06 <parseexec+0xa8>
      panic("too many args");
     b54:	00001517          	auipc	a0,0x1
     b58:	dbc50513          	addi	a0,a0,-580 # 1910 <malloc+0x1cc>
     b5c:	00000097          	auipc	ra,0x0
     b60:	842080e7          	jalr	-1982(ra) # 39e <panic>
  cmd->argv[argc] = 0;
     b64:	098e                	slli	s3,s3,0x3
     b66:	99ee                	add	s3,s3,s11
     b68:	0009b423          	sd	zero,8(s3)
  cmd->eargv[argc] = 0;
     b6c:	0409bc23          	sd	zero,88(s3)
  return ret;
     b70:	b79d                	j	ad6 <parseexec+0x78>

0000000000000b72 <parsepipe>:
{
     b72:	7179                	addi	sp,sp,-48
     b74:	f406                	sd	ra,40(sp)
     b76:	f022                	sd	s0,32(sp)
     b78:	ec26                	sd	s1,24(sp)
     b7a:	e84a                	sd	s2,16(sp)
     b7c:	e44e                	sd	s3,8(sp)
     b7e:	1800                	addi	s0,sp,48
     b80:	892a                	mv	s2,a0
     b82:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     b84:	00000097          	auipc	ra,0x0
     b88:	eda080e7          	jalr	-294(ra) # a5e <parseexec>
     b8c:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     b8e:	00001617          	auipc	a2,0x1
     b92:	d9a60613          	addi	a2,a2,-614 # 1928 <malloc+0x1e4>
     b96:	85ce                	mv	a1,s3
     b98:	854a                	mv	a0,s2
     b9a:	00000097          	auipc	ra,0x0
     b9e:	d52080e7          	jalr	-686(ra) # 8ec <peek>
     ba2:	e909                	bnez	a0,bb4 <parsepipe+0x42>
}
     ba4:	8526                	mv	a0,s1
     ba6:	70a2                	ld	ra,40(sp)
     ba8:	7402                	ld	s0,32(sp)
     baa:	64e2                	ld	s1,24(sp)
     bac:	6942                	ld	s2,16(sp)
     bae:	69a2                	ld	s3,8(sp)
     bb0:	6145                	addi	sp,sp,48
     bb2:	8082                	ret
    gettoken(ps, es, 0, 0);
     bb4:	4681                	li	a3,0
     bb6:	4601                	li	a2,0
     bb8:	85ce                	mv	a1,s3
     bba:	854a                	mv	a0,s2
     bbc:	00000097          	auipc	ra,0x0
     bc0:	bf4080e7          	jalr	-1036(ra) # 7b0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     bc4:	85ce                	mv	a1,s3
     bc6:	854a                	mv	a0,s2
     bc8:	00000097          	auipc	ra,0x0
     bcc:	faa080e7          	jalr	-86(ra) # b72 <parsepipe>
     bd0:	85aa                	mv	a1,a0
     bd2:	8526                	mv	a0,s1
     bd4:	00000097          	auipc	ra,0x0
     bd8:	b14080e7          	jalr	-1260(ra) # 6e8 <pipecmd>
     bdc:	84aa                	mv	s1,a0
  return cmd;
     bde:	b7d9                	j	ba4 <parsepipe+0x32>

0000000000000be0 <parseline>:
{
     be0:	7179                	addi	sp,sp,-48
     be2:	f406                	sd	ra,40(sp)
     be4:	f022                	sd	s0,32(sp)
     be6:	ec26                	sd	s1,24(sp)
     be8:	e84a                	sd	s2,16(sp)
     bea:	e44e                	sd	s3,8(sp)
     bec:	e052                	sd	s4,0(sp)
     bee:	1800                	addi	s0,sp,48
     bf0:	892a                	mv	s2,a0
     bf2:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     bf4:	00000097          	auipc	ra,0x0
     bf8:	f7e080e7          	jalr	-130(ra) # b72 <parsepipe>
     bfc:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     bfe:	00001a17          	auipc	s4,0x1
     c02:	d32a0a13          	addi	s4,s4,-718 # 1930 <malloc+0x1ec>
     c06:	a839                	j	c24 <parseline+0x44>
    gettoken(ps, es, 0, 0);
     c08:	4681                	li	a3,0
     c0a:	4601                	li	a2,0
     c0c:	85ce                	mv	a1,s3
     c0e:	854a                	mv	a0,s2
     c10:	00000097          	auipc	ra,0x0
     c14:	ba0080e7          	jalr	-1120(ra) # 7b0 <gettoken>
    cmd = backcmd(cmd);
     c18:	8526                	mv	a0,s1
     c1a:	00000097          	auipc	ra,0x0
     c1e:	b5a080e7          	jalr	-1190(ra) # 774 <backcmd>
     c22:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     c24:	8652                	mv	a2,s4
     c26:	85ce                	mv	a1,s3
     c28:	854a                	mv	a0,s2
     c2a:	00000097          	auipc	ra,0x0
     c2e:	cc2080e7          	jalr	-830(ra) # 8ec <peek>
     c32:	f979                	bnez	a0,c08 <parseline+0x28>
  if(peek(ps, es, ";")){
     c34:	00001617          	auipc	a2,0x1
     c38:	d0460613          	addi	a2,a2,-764 # 1938 <malloc+0x1f4>
     c3c:	85ce                	mv	a1,s3
     c3e:	854a                	mv	a0,s2
     c40:	00000097          	auipc	ra,0x0
     c44:	cac080e7          	jalr	-852(ra) # 8ec <peek>
     c48:	e911                	bnez	a0,c5c <parseline+0x7c>
}
     c4a:	8526                	mv	a0,s1
     c4c:	70a2                	ld	ra,40(sp)
     c4e:	7402                	ld	s0,32(sp)
     c50:	64e2                	ld	s1,24(sp)
     c52:	6942                	ld	s2,16(sp)
     c54:	69a2                	ld	s3,8(sp)
     c56:	6a02                	ld	s4,0(sp)
     c58:	6145                	addi	sp,sp,48
     c5a:	8082                	ret
    gettoken(ps, es, 0, 0);
     c5c:	4681                	li	a3,0
     c5e:	4601                	li	a2,0
     c60:	85ce                	mv	a1,s3
     c62:	854a                	mv	a0,s2
     c64:	00000097          	auipc	ra,0x0
     c68:	b4c080e7          	jalr	-1204(ra) # 7b0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     c6c:	85ce                	mv	a1,s3
     c6e:	854a                	mv	a0,s2
     c70:	00000097          	auipc	ra,0x0
     c74:	f70080e7          	jalr	-144(ra) # be0 <parseline>
     c78:	85aa                	mv	a1,a0
     c7a:	8526                	mv	a0,s1
     c7c:	00000097          	auipc	ra,0x0
     c80:	ab2080e7          	jalr	-1358(ra) # 72e <listcmd>
     c84:	84aa                	mv	s1,a0
  return cmd;
     c86:	b7d1                	j	c4a <parseline+0x6a>

0000000000000c88 <parseblock>:
{
     c88:	7179                	addi	sp,sp,-48
     c8a:	f406                	sd	ra,40(sp)
     c8c:	f022                	sd	s0,32(sp)
     c8e:	ec26                	sd	s1,24(sp)
     c90:	e84a                	sd	s2,16(sp)
     c92:	e44e                	sd	s3,8(sp)
     c94:	1800                	addi	s0,sp,48
     c96:	84aa                	mv	s1,a0
     c98:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     c9a:	00001617          	auipc	a2,0x1
     c9e:	c6660613          	addi	a2,a2,-922 # 1900 <malloc+0x1bc>
     ca2:	00000097          	auipc	ra,0x0
     ca6:	c4a080e7          	jalr	-950(ra) # 8ec <peek>
     caa:	c12d                	beqz	a0,d0c <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     cac:	4681                	li	a3,0
     cae:	4601                	li	a2,0
     cb0:	85ca                	mv	a1,s2
     cb2:	8526                	mv	a0,s1
     cb4:	00000097          	auipc	ra,0x0
     cb8:	afc080e7          	jalr	-1284(ra) # 7b0 <gettoken>
  cmd = parseline(ps, es);
     cbc:	85ca                	mv	a1,s2
     cbe:	8526                	mv	a0,s1
     cc0:	00000097          	auipc	ra,0x0
     cc4:	f20080e7          	jalr	-224(ra) # be0 <parseline>
     cc8:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     cca:	00001617          	auipc	a2,0x1
     cce:	c8660613          	addi	a2,a2,-890 # 1950 <malloc+0x20c>
     cd2:	85ca                	mv	a1,s2
     cd4:	8526                	mv	a0,s1
     cd6:	00000097          	auipc	ra,0x0
     cda:	c16080e7          	jalr	-1002(ra) # 8ec <peek>
     cde:	cd1d                	beqz	a0,d1c <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     ce0:	4681                	li	a3,0
     ce2:	4601                	li	a2,0
     ce4:	85ca                	mv	a1,s2
     ce6:	8526                	mv	a0,s1
     ce8:	00000097          	auipc	ra,0x0
     cec:	ac8080e7          	jalr	-1336(ra) # 7b0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     cf0:	864a                	mv	a2,s2
     cf2:	85a6                	mv	a1,s1
     cf4:	854e                	mv	a0,s3
     cf6:	00000097          	auipc	ra,0x0
     cfa:	c60080e7          	jalr	-928(ra) # 956 <parseredirs>
}
     cfe:	70a2                	ld	ra,40(sp)
     d00:	7402                	ld	s0,32(sp)
     d02:	64e2                	ld	s1,24(sp)
     d04:	6942                	ld	s2,16(sp)
     d06:	69a2                	ld	s3,8(sp)
     d08:	6145                	addi	sp,sp,48
     d0a:	8082                	ret
    panic("parseblock");
     d0c:	00001517          	auipc	a0,0x1
     d10:	c3450513          	addi	a0,a0,-972 # 1940 <malloc+0x1fc>
     d14:	fffff097          	auipc	ra,0xfffff
     d18:	68a080e7          	jalr	1674(ra) # 39e <panic>
    panic("syntax - missing )");
     d1c:	00001517          	auipc	a0,0x1
     d20:	c3c50513          	addi	a0,a0,-964 # 1958 <malloc+0x214>
     d24:	fffff097          	auipc	ra,0xfffff
     d28:	67a080e7          	jalr	1658(ra) # 39e <panic>

0000000000000d2c <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     d2c:	1101                	addi	sp,sp,-32
     d2e:	ec06                	sd	ra,24(sp)
     d30:	e822                	sd	s0,16(sp)
     d32:	e426                	sd	s1,8(sp)
     d34:	1000                	addi	s0,sp,32
     d36:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     d38:	c521                	beqz	a0,d80 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     d3a:	4118                	lw	a4,0(a0)
     d3c:	4795                	li	a5,5
     d3e:	04e7e163          	bltu	a5,a4,d80 <nulterminate+0x54>
     d42:	00056783          	lwu	a5,0(a0)
     d46:	078a                	slli	a5,a5,0x2
     d48:	00001717          	auipc	a4,0x1
     d4c:	cb070713          	addi	a4,a4,-848 # 19f8 <malloc+0x2b4>
     d50:	97ba                	add	a5,a5,a4
     d52:	439c                	lw	a5,0(a5)
     d54:	97ba                	add	a5,a5,a4
     d56:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     d58:	651c                	ld	a5,8(a0)
     d5a:	c39d                	beqz	a5,d80 <nulterminate+0x54>
     d5c:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     d60:	67b8                	ld	a4,72(a5)
     d62:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     d66:	07a1                	addi	a5,a5,8
     d68:	ff87b703          	ld	a4,-8(a5)
     d6c:	fb75                	bnez	a4,d60 <nulterminate+0x34>
     d6e:	a809                	j	d80 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     d70:	6508                	ld	a0,8(a0)
     d72:	00000097          	auipc	ra,0x0
     d76:	fba080e7          	jalr	-70(ra) # d2c <nulterminate>
    *rcmd->efile = 0;
     d7a:	6c9c                	ld	a5,24(s1)
     d7c:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
     d80:	8526                	mv	a0,s1
     d82:	60e2                	ld	ra,24(sp)
     d84:	6442                	ld	s0,16(sp)
     d86:	64a2                	ld	s1,8(sp)
     d88:	6105                	addi	sp,sp,32
     d8a:	8082                	ret
    nulterminate(pcmd->left);
     d8c:	6508                	ld	a0,8(a0)
     d8e:	00000097          	auipc	ra,0x0
     d92:	f9e080e7          	jalr	-98(ra) # d2c <nulterminate>
    nulterminate(pcmd->right);
     d96:	6888                	ld	a0,16(s1)
     d98:	00000097          	auipc	ra,0x0
     d9c:	f94080e7          	jalr	-108(ra) # d2c <nulterminate>
    break;
     da0:	b7c5                	j	d80 <nulterminate+0x54>
    nulterminate(lcmd->left);
     da2:	6508                	ld	a0,8(a0)
     da4:	00000097          	auipc	ra,0x0
     da8:	f88080e7          	jalr	-120(ra) # d2c <nulterminate>
    nulterminate(lcmd->right);
     dac:	6888                	ld	a0,16(s1)
     dae:	00000097          	auipc	ra,0x0
     db2:	f7e080e7          	jalr	-130(ra) # d2c <nulterminate>
    break;
     db6:	b7e9                	j	d80 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     db8:	6508                	ld	a0,8(a0)
     dba:	00000097          	auipc	ra,0x0
     dbe:	f72080e7          	jalr	-142(ra) # d2c <nulterminate>
    break;
     dc2:	bf7d                	j	d80 <nulterminate+0x54>

0000000000000dc4 <parsecmd>:
{
     dc4:	7139                	addi	sp,sp,-64
     dc6:	fc06                	sd	ra,56(sp)
     dc8:	f822                	sd	s0,48(sp)
     dca:	f426                	sd	s1,40(sp)
     dcc:	f04a                	sd	s2,32(sp)
     dce:	ec4e                	sd	s3,24(sp)
     dd0:	0080                	addi	s0,sp,64
     dd2:	fca43423          	sd	a0,-56(s0)
  es = s + strlen(s);
     dd6:	84aa                	mv	s1,a0
     dd8:	00000097          	auipc	ra,0x0
     ddc:	2ce080e7          	jalr	718(ra) # 10a6 <strlen>
     de0:	1502                	slli	a0,a0,0x20
     de2:	9101                	srli	a0,a0,0x20
     de4:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     de6:	85a6                	mv	a1,s1
     de8:	fc840913          	addi	s2,s0,-56
     dec:	854a                	mv	a0,s2
     dee:	00000097          	auipc	ra,0x0
     df2:	df2080e7          	jalr	-526(ra) # be0 <parseline>
     df6:	89aa                	mv	s3,a0
  peek(&s, es, "");
     df8:	00001617          	auipc	a2,0x1
     dfc:	bd060613          	addi	a2,a2,-1072 # 19c8 <malloc+0x284>
     e00:	85a6                	mv	a1,s1
     e02:	854a                	mv	a0,s2
     e04:	00000097          	auipc	ra,0x0
     e08:	ae8080e7          	jalr	-1304(ra) # 8ec <peek>
  if(s != es){
     e0c:	fc843603          	ld	a2,-56(s0)
     e10:	00961f63          	bne	a2,s1,e2e <parsecmd+0x6a>
  nulterminate(cmd);
     e14:	854e                	mv	a0,s3
     e16:	00000097          	auipc	ra,0x0
     e1a:	f16080e7          	jalr	-234(ra) # d2c <nulterminate>
}
     e1e:	854e                	mv	a0,s3
     e20:	70e2                	ld	ra,56(sp)
     e22:	7442                	ld	s0,48(sp)
     e24:	74a2                	ld	s1,40(sp)
     e26:	7902                	ld	s2,32(sp)
     e28:	69e2                	ld	s3,24(sp)
     e2a:	6121                	addi	sp,sp,64
     e2c:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     e2e:	00001597          	auipc	a1,0x1
     e32:	b4258593          	addi	a1,a1,-1214 # 1970 <malloc+0x22c>
     e36:	4509                	li	a0,2
     e38:	00001097          	auipc	ra,0x1
     e3c:	820080e7          	jalr	-2016(ra) # 1658 <fprintf>
    panic("syntax");
     e40:	00001517          	auipc	a0,0x1
     e44:	ac850513          	addi	a0,a0,-1336 # 1908 <malloc+0x1c4>
     e48:	fffff097          	auipc	ra,0xfffff
     e4c:	556080e7          	jalr	1366(ra) # 39e <panic>

0000000000000e50 <main>:
{
     e50:	711d                	addi	sp,sp,-96
     e52:	ec86                	sd	ra,88(sp)
     e54:	e8a2                	sd	s0,80(sp)
     e56:	e4a6                	sd	s1,72(sp)
     e58:	e0ca                	sd	s2,64(sp)
     e5a:	fc4e                	sd	s3,56(sp)
     e5c:	f852                	sd	s4,48(sp)
     e5e:	f456                	sd	s5,40(sp)
     e60:	f05a                	sd	s6,32(sp)
     e62:	ec5e                	sd	s7,24(sp)
     e64:	e862                	sd	s8,16(sp)
     e66:	e466                	sd	s9,8(sp)
     e68:	1080                	addi	s0,sp,96
  while((fd = dev(O_RDWR, 1, 0)) >= 0){
     e6a:	4601                	li	a2,0
     e6c:	4585                	li	a1,1
     e6e:	4509                	li	a0,2
     e70:	00000097          	auipc	ra,0x0
     e74:	508080e7          	jalr	1288(ra) # 1378 <dev>
     e78:	00054963          	bltz	a0,e8a <main+0x3a>
    if(fd >= 3){
     e7c:	4789                	li	a5,2
     e7e:	fea7d6e3          	bge	a5,a0,e6a <main+0x1a>
      close(fd);
     e82:	00000097          	auipc	ra,0x0
     e86:	48e080e7          	jalr	1166(ra) # 1310 <close>
  strcpy(envs[nenv].name, "SHELL");
     e8a:	00001497          	auipc	s1,0x1
     e8e:	bb648493          	addi	s1,s1,-1098 # 1a40 <nenv>
     e92:	4088                	lw	a0,0(s1)
     e94:	051e                	slli	a0,a0,0x7
     e96:	00001917          	auipc	s2,0x1
     e9a:	c9a90913          	addi	s2,s2,-870 # 1b30 <envs>
     e9e:	00001597          	auipc	a1,0x1
     ea2:	ae258593          	addi	a1,a1,-1310 # 1980 <malloc+0x23c>
     ea6:	954a                	add	a0,a0,s2
     ea8:	00000097          	auipc	ra,0x0
     eac:	188080e7          	jalr	392(ra) # 1030 <strcpy>
  strcpy(envs[nenv].value, "/bin");
     eb0:	4088                	lw	a0,0(s1)
     eb2:	051e                	slli	a0,a0,0x7
     eb4:	02050513          	addi	a0,a0,32
     eb8:	00001597          	auipc	a1,0x1
     ebc:	ad058593          	addi	a1,a1,-1328 # 1988 <malloc+0x244>
     ec0:	954a                	add	a0,a0,s2
     ec2:	00000097          	auipc	ra,0x0
     ec6:	16e080e7          	jalr	366(ra) # 1030 <strcpy>
  nenv++;
     eca:	409c                	lw	a5,0(s1)
     ecc:	2785                	addiw	a5,a5,1
     ece:	c09c                	sw	a5,0(s1)
  getcwd(mycwd);
     ed0:	00001517          	auipc	a0,0x1
     ed4:	b7850513          	addi	a0,a0,-1160 # 1a48 <mycwd>
     ed8:	00000097          	auipc	ra,0x0
     edc:	4b0080e7          	jalr	1200(ra) # 1388 <getcwd>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ee0:	00001917          	auipc	s2,0x1
     ee4:	be890913          	addi	s2,s2,-1048 # 1ac8 <buf.0>
    replace(buf);
     ee8:	89a6                	mv	s3,s1
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     eea:	06300a13          	li	s4,99
      else if(!strcmp(ecmd->argv[0], "export"))
     eee:	00001a97          	auipc	s5,0x1
     ef2:	ab2a8a93          	addi	s5,s5,-1358 # 19a0 <malloc+0x25c>
          fprintf(2, "export failed\n");
     ef6:	00001b97          	auipc	s7,0x1
     efa:	adab8b93          	addi	s7,s7,-1318 # 19d0 <malloc+0x28c>
          fprintf(2, "Usage: export [-p] [NAME=VALUE]\n");
     efe:	00001b17          	auipc	s6,0x1
     f02:	aaab0b13          	addi	s6,s6,-1366 # 19a8 <malloc+0x264>
      if(chdir(buf+3) < 0)
     f06:	00001c17          	auipc	s8,0x1
     f0a:	bc5c0c13          	addi	s8,s8,-1083 # 1acb <buf.0+0x3>
      getcwd(mycwd);
     f0e:	00001c97          	auipc	s9,0x1
     f12:	b3ac8c93          	addi	s9,s9,-1222 # 1a48 <mycwd>
  while(getcmd(buf, sizeof(buf)) >= 0){
     f16:	a8a5                	j	f8e <main+0x13e>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     f18:	08a9c703          	lbu	a4,138(s3)
     f1c:	02000793          	li	a5,32
     f20:	08f71f63          	bne	a4,a5,fbe <main+0x16e>
      buf[strlen(buf)-1] = 0;  // chop \n
     f24:	854a                	mv	a0,s2
     f26:	00000097          	auipc	ra,0x0
     f2a:	180080e7          	jalr	384(ra) # 10a6 <strlen>
     f2e:	fff5079b          	addiw	a5,a0,-1
     f32:	1782                	slli	a5,a5,0x20
     f34:	9381                	srli	a5,a5,0x20
     f36:	97ce                	add	a5,a5,s3
     f38:	08078423          	sb	zero,136(a5)
      if(chdir(buf+3) < 0)
     f3c:	8562                	mv	a0,s8
     f3e:	00000097          	auipc	ra,0x0
     f42:	402080e7          	jalr	1026(ra) # 1340 <chdir>
     f46:	00054863          	bltz	a0,f56 <main+0x106>
      getcwd(mycwd);
     f4a:	8566                	mv	a0,s9
     f4c:	00000097          	auipc	ra,0x0
     f50:	43c080e7          	jalr	1084(ra) # 1388 <getcwd>
     f54:	a82d                	j	f8e <main+0x13e>
        fprintf(2, "cannot cd %s\n", buf+3);
     f56:	8662                	mv	a2,s8
     f58:	00001597          	auipc	a1,0x1
     f5c:	a3858593          	addi	a1,a1,-1480 # 1990 <malloc+0x24c>
     f60:	4509                	li	a0,2
     f62:	00000097          	auipc	ra,0x0
     f66:	6f6080e7          	jalr	1782(ra) # 1658 <fprintf>
     f6a:	b7c5                	j	f4a <main+0xfa>
        free(cmd);
     f6c:	8526                	mv	a0,s1
     f6e:	00000097          	auipc	ra,0x0
     f72:	74e080e7          	jalr	1870(ra) # 16bc <free>
        continue;
     f76:	a821                	j	f8e <main+0x13e>
          fprintf(2, "Usage: export [-p] [NAME=VALUE]\n");
     f78:	85da                	mv	a1,s6
     f7a:	4509                	li	a0,2
     f7c:	00000097          	auipc	ra,0x0
     f80:	6dc080e7          	jalr	1756(ra) # 1658 <fprintf>
        free(cmd);
     f84:	8526                	mv	a0,s1
     f86:	00000097          	auipc	ra,0x0
     f8a:	736080e7          	jalr	1846(ra) # 16bc <free>
  while(getcmd(buf, sizeof(buf)) >= 0){
     f8e:	06400593          	li	a1,100
     f92:	854a                	mv	a0,s2
     f94:	fffff097          	auipc	ra,0xfffff
     f98:	3ae080e7          	jalr	942(ra) # 342 <getcmd>
     f9c:	08054563          	bltz	a0,1026 <main+0x1d6>
    replace(buf);
     fa0:	854a                	mv	a0,s2
     fa2:	fffff097          	auipc	ra,0xfffff
     fa6:	25c080e7          	jalr	604(ra) # 1fe <replace>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     faa:	0889c783          	lbu	a5,136(s3)
     fae:	01479863          	bne	a5,s4,fbe <main+0x16e>
     fb2:	0899c703          	lbu	a4,137(s3)
     fb6:	06400793          	li	a5,100
     fba:	f4f70fe3          	beq	a4,a5,f18 <main+0xc8>
      struct cmd *cmd = parsecmd(buf);
     fbe:	854a                	mv	a0,s2
     fc0:	00000097          	auipc	ra,0x0
     fc4:	e04080e7          	jalr	-508(ra) # dc4 <parsecmd>
     fc8:	84aa                	mv	s1,a0
      if(ecmd->argv[0] == 0) {
     fca:	6508                	ld	a0,8(a0)
     fcc:	d145                	beqz	a0,f6c <main+0x11c>
      else if(!strcmp(ecmd->argv[0], "export"))
     fce:	85d6                	mv	a1,s5
     fd0:	00000097          	auipc	ra,0x0
     fd4:	0aa080e7          	jalr	170(ra) # 107a <strcmp>
     fd8:	e115                	bnez	a0,ffc <main+0x1ac>
        if(ecmd->argv[1] == NULL)
     fda:	689c                	ld	a5,16(s1)
     fdc:	dfd1                	beqz	a5,f78 <main+0x128>
        else if(export(ecmd->argv) < 0)
     fde:	00848513          	addi	a0,s1,8
     fe2:	fffff097          	auipc	ra,0xfffff
     fe6:	084080e7          	jalr	132(ra) # 66 <export>
     fea:	f8055de3          	bgez	a0,f84 <main+0x134>
          fprintf(2, "export failed\n");
     fee:	85de                	mv	a1,s7
     ff0:	4509                	li	a0,2
     ff2:	00000097          	auipc	ra,0x0
     ff6:	666080e7          	jalr	1638(ra) # 1658 <fprintf>
     ffa:	b769                	j	f84 <main+0x134>
      else if(fork1() == 0) 
     ffc:	fffff097          	auipc	ra,0xfffff
    1000:	3c8080e7          	jalr	968(ra) # 3c4 <fork1>
    1004:	cd01                	beqz	a0,101c <main+0x1cc>
      wait(0);
    1006:	4501                	li	a0,0
    1008:	00000097          	auipc	ra,0x0
    100c:	2e8080e7          	jalr	744(ra) # 12f0 <wait>
      free(cmd);
    1010:	8526                	mv	a0,s1
    1012:	00000097          	auipc	ra,0x0
    1016:	6aa080e7          	jalr	1706(ra) # 16bc <free>
    101a:	bf95                	j	f8e <main+0x13e>
        runcmd(cmd);
    101c:	8526                	mv	a0,s1
    101e:	fffff097          	auipc	ra,0xfffff
    1022:	3d4080e7          	jalr	980(ra) # 3f2 <runcmd>
  exit(0);
    1026:	4501                	li	a0,0
    1028:	00000097          	auipc	ra,0x0
    102c:	2c0080e7          	jalr	704(ra) # 12e8 <exit>

0000000000001030 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
    1030:	1141                	addi	sp,sp,-16
    1032:	e422                	sd	s0,8(sp)
    1034:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1036:	87aa                	mv	a5,a0
    1038:	0585                	addi	a1,a1,1
    103a:	0785                	addi	a5,a5,1
    103c:	fff5c703          	lbu	a4,-1(a1)
    1040:	fee78fa3          	sb	a4,-1(a5)
    1044:	fb75                	bnez	a4,1038 <strcpy+0x8>
    ;
  return os;
}
    1046:	6422                	ld	s0,8(sp)
    1048:	0141                	addi	sp,sp,16
    104a:	8082                	ret

000000000000104c <strcat>:

char*
strcat(char *s, const char *t)
{
    104c:	1141                	addi	sp,sp,-16
    104e:	e422                	sd	s0,8(sp)
    1050:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
    1052:	00054783          	lbu	a5,0(a0)
    1056:	c385                	beqz	a5,1076 <strcat+0x2a>
    1058:	87aa                	mv	a5,a0
    s++;
    105a:	0785                	addi	a5,a5,1
  while(*s)
    105c:	0007c703          	lbu	a4,0(a5)
    1060:	ff6d                	bnez	a4,105a <strcat+0xe>
  while((*s++ = *t++))
    1062:	0585                	addi	a1,a1,1
    1064:	0785                	addi	a5,a5,1
    1066:	fff5c703          	lbu	a4,-1(a1)
    106a:	fee78fa3          	sb	a4,-1(a5)
    106e:	fb75                	bnez	a4,1062 <strcat+0x16>
    ;
  return os;
}
    1070:	6422                	ld	s0,8(sp)
    1072:	0141                	addi	sp,sp,16
    1074:	8082                	ret
  while(*s)
    1076:	87aa                	mv	a5,a0
    1078:	b7ed                	j	1062 <strcat+0x16>

000000000000107a <strcmp>:


int
strcmp(const char *p, const char *q)
{
    107a:	1141                	addi	sp,sp,-16
    107c:	e422                	sd	s0,8(sp)
    107e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    1080:	00054783          	lbu	a5,0(a0)
    1084:	cb91                	beqz	a5,1098 <strcmp+0x1e>
    1086:	0005c703          	lbu	a4,0(a1)
    108a:	00f71763          	bne	a4,a5,1098 <strcmp+0x1e>
    p++, q++;
    108e:	0505                	addi	a0,a0,1
    1090:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    1092:	00054783          	lbu	a5,0(a0)
    1096:	fbe5                	bnez	a5,1086 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    1098:	0005c503          	lbu	a0,0(a1)
}
    109c:	40a7853b          	subw	a0,a5,a0
    10a0:	6422                	ld	s0,8(sp)
    10a2:	0141                	addi	sp,sp,16
    10a4:	8082                	ret

00000000000010a6 <strlen>:

uint
strlen(const char *s)
{
    10a6:	1141                	addi	sp,sp,-16
    10a8:	e422                	sd	s0,8(sp)
    10aa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    10ac:	00054783          	lbu	a5,0(a0)
    10b0:	cf91                	beqz	a5,10cc <strlen+0x26>
    10b2:	0505                	addi	a0,a0,1
    10b4:	87aa                	mv	a5,a0
    10b6:	4685                	li	a3,1
    10b8:	9e89                	subw	a3,a3,a0
    10ba:	00f6853b          	addw	a0,a3,a5
    10be:	0785                	addi	a5,a5,1
    10c0:	fff7c703          	lbu	a4,-1(a5)
    10c4:	fb7d                	bnez	a4,10ba <strlen+0x14>
    ;
  return n;
}
    10c6:	6422                	ld	s0,8(sp)
    10c8:	0141                	addi	sp,sp,16
    10ca:	8082                	ret
  for(n = 0; s[n]; n++)
    10cc:	4501                	li	a0,0
    10ce:	bfe5                	j	10c6 <strlen+0x20>

00000000000010d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10d0:	1141                	addi	sp,sp,-16
    10d2:	e422                	sd	s0,8(sp)
    10d4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    10d6:	ca19                	beqz	a2,10ec <memset+0x1c>
    10d8:	87aa                	mv	a5,a0
    10da:	1602                	slli	a2,a2,0x20
    10dc:	9201                	srli	a2,a2,0x20
    10de:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    10e2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    10e6:	0785                	addi	a5,a5,1
    10e8:	fee79de3          	bne	a5,a4,10e2 <memset+0x12>
  }
  return dst;
}
    10ec:	6422                	ld	s0,8(sp)
    10ee:	0141                	addi	sp,sp,16
    10f0:	8082                	ret

00000000000010f2 <strchr>:

char*
strchr(const char *s, char c)
{
    10f2:	1141                	addi	sp,sp,-16
    10f4:	e422                	sd	s0,8(sp)
    10f6:	0800                	addi	s0,sp,16
  for(; *s; s++)
    10f8:	00054783          	lbu	a5,0(a0)
    10fc:	cb99                	beqz	a5,1112 <strchr+0x20>
    if(*s == c)
    10fe:	00f58763          	beq	a1,a5,110c <strchr+0x1a>
  for(; *s; s++)
    1102:	0505                	addi	a0,a0,1
    1104:	00054783          	lbu	a5,0(a0)
    1108:	fbfd                	bnez	a5,10fe <strchr+0xc>
      return (char*)s;
  return 0;
    110a:	4501                	li	a0,0
}
    110c:	6422                	ld	s0,8(sp)
    110e:	0141                	addi	sp,sp,16
    1110:	8082                	ret
  return 0;
    1112:	4501                	li	a0,0
    1114:	bfe5                	j	110c <strchr+0x1a>

0000000000001116 <gets>:

char*
gets(char *buf, int max)
{
    1116:	711d                	addi	sp,sp,-96
    1118:	ec86                	sd	ra,88(sp)
    111a:	e8a2                	sd	s0,80(sp)
    111c:	e4a6                	sd	s1,72(sp)
    111e:	e0ca                	sd	s2,64(sp)
    1120:	fc4e                	sd	s3,56(sp)
    1122:	f852                	sd	s4,48(sp)
    1124:	f456                	sd	s5,40(sp)
    1126:	f05a                	sd	s6,32(sp)
    1128:	ec5e                	sd	s7,24(sp)
    112a:	e862                	sd	s8,16(sp)
    112c:	1080                	addi	s0,sp,96
    112e:	8baa                	mv	s7,a0
    1130:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1132:	892a                	mv	s2,a0
    1134:	4481                	li	s1,0
    cc = read(0, &c, 1);
    1136:	faf40a93          	addi	s5,s0,-81
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    113a:	4b29                	li	s6,10
    113c:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
    113e:	89a6                	mv	s3,s1
    1140:	2485                	addiw	s1,s1,1
    1142:	0344d763          	bge	s1,s4,1170 <gets+0x5a>
    cc = read(0, &c, 1);
    1146:	4605                	li	a2,1
    1148:	85d6                	mv	a1,s5
    114a:	4501                	li	a0,0
    114c:	00000097          	auipc	ra,0x0
    1150:	1b4080e7          	jalr	436(ra) # 1300 <read>
    if(cc < 1)
    1154:	00a05e63          	blez	a0,1170 <gets+0x5a>
    buf[i++] = c;
    1158:	faf44783          	lbu	a5,-81(s0)
    115c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    1160:	01678763          	beq	a5,s6,116e <gets+0x58>
    1164:	0905                	addi	s2,s2,1
    1166:	fd879ce3          	bne	a5,s8,113e <gets+0x28>
  for(i=0; i+1 < max; ){
    116a:	89a6                	mv	s3,s1
    116c:	a011                	j	1170 <gets+0x5a>
    116e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    1170:	99de                	add	s3,s3,s7
    1172:	00098023          	sb	zero,0(s3)
  return buf;
}
    1176:	855e                	mv	a0,s7
    1178:	60e6                	ld	ra,88(sp)
    117a:	6446                	ld	s0,80(sp)
    117c:	64a6                	ld	s1,72(sp)
    117e:	6906                	ld	s2,64(sp)
    1180:	79e2                	ld	s3,56(sp)
    1182:	7a42                	ld	s4,48(sp)
    1184:	7aa2                	ld	s5,40(sp)
    1186:	7b02                	ld	s6,32(sp)
    1188:	6be2                	ld	s7,24(sp)
    118a:	6c42                	ld	s8,16(sp)
    118c:	6125                	addi	sp,sp,96
    118e:	8082                	ret

0000000000001190 <stat>:

int
stat(const char *n, struct stat *st)
{
    1190:	1101                	addi	sp,sp,-32
    1192:	ec06                	sd	ra,24(sp)
    1194:	e822                	sd	s0,16(sp)
    1196:	e426                	sd	s1,8(sp)
    1198:	e04a                	sd	s2,0(sp)
    119a:	1000                	addi	s0,sp,32
    119c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    119e:	4581                	li	a1,0
    11a0:	00000097          	auipc	ra,0x0
    11a4:	188080e7          	jalr	392(ra) # 1328 <open>
  if(fd < 0)
    11a8:	02054563          	bltz	a0,11d2 <stat+0x42>
    11ac:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    11ae:	85ca                	mv	a1,s2
    11b0:	00000097          	auipc	ra,0x0
    11b4:	180080e7          	jalr	384(ra) # 1330 <fstat>
    11b8:	892a                	mv	s2,a0
  close(fd);
    11ba:	8526                	mv	a0,s1
    11bc:	00000097          	auipc	ra,0x0
    11c0:	154080e7          	jalr	340(ra) # 1310 <close>
  return r;
}
    11c4:	854a                	mv	a0,s2
    11c6:	60e2                	ld	ra,24(sp)
    11c8:	6442                	ld	s0,16(sp)
    11ca:	64a2                	ld	s1,8(sp)
    11cc:	6902                	ld	s2,0(sp)
    11ce:	6105                	addi	sp,sp,32
    11d0:	8082                	ret
    return -1;
    11d2:	597d                	li	s2,-1
    11d4:	bfc5                	j	11c4 <stat+0x34>

00000000000011d6 <atoi>:

int
atoi(const char *s)
{
    11d6:	1141                	addi	sp,sp,-16
    11d8:	e422                	sd	s0,8(sp)
    11da:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
    11dc:	00054703          	lbu	a4,0(a0)
    11e0:	02d00793          	li	a5,45
  int neg = 1;
    11e4:	4805                	li	a6,1
  if (*s == '-') {
    11e6:	04f70363          	beq	a4,a5,122c <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
    11ea:	00054683          	lbu	a3,0(a0)
    11ee:	fd06879b          	addiw	a5,a3,-48
    11f2:	0ff7f793          	andi	a5,a5,255
    11f6:	4725                	li	a4,9
    11f8:	02f76d63          	bltu	a4,a5,1232 <atoi+0x5c>
  n = 0;
    11fc:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
    11fe:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    1200:	0505                	addi	a0,a0,1
    1202:	0026179b          	slliw	a5,a2,0x2
    1206:	9fb1                	addw	a5,a5,a2
    1208:	0017979b          	slliw	a5,a5,0x1
    120c:	9fb5                	addw	a5,a5,a3
    120e:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
    1212:	00054683          	lbu	a3,0(a0)
    1216:	fd06871b          	addiw	a4,a3,-48
    121a:	0ff77713          	andi	a4,a4,255
    121e:	fee5f1e3          	bgeu	a1,a4,1200 <atoi+0x2a>
  return n * neg;
}
    1222:	02c8053b          	mulw	a0,a6,a2
    1226:	6422                	ld	s0,8(sp)
    1228:	0141                	addi	sp,sp,16
    122a:	8082                	ret
    s++;
    122c:	0505                	addi	a0,a0,1
    neg = -1;
    122e:	587d                	li	a6,-1
    1230:	bf6d                	j	11ea <atoi+0x14>
  n = 0;
    1232:	4601                	li	a2,0
    1234:	b7fd                	j	1222 <atoi+0x4c>

0000000000001236 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1236:	1141                	addi	sp,sp,-16
    1238:	e422                	sd	s0,8(sp)
    123a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    123c:	02b57463          	bgeu	a0,a1,1264 <memmove+0x2e>
    while(n-- > 0)
    1240:	00c05f63          	blez	a2,125e <memmove+0x28>
    1244:	1602                	slli	a2,a2,0x20
    1246:	9201                	srli	a2,a2,0x20
    1248:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    124c:	872a                	mv	a4,a0
      *dst++ = *src++;
    124e:	0585                	addi	a1,a1,1
    1250:	0705                	addi	a4,a4,1
    1252:	fff5c683          	lbu	a3,-1(a1)
    1256:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    125a:	fee79ae3          	bne	a5,a4,124e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    125e:	6422                	ld	s0,8(sp)
    1260:	0141                	addi	sp,sp,16
    1262:	8082                	ret
    dst += n;
    1264:	00c50733          	add	a4,a0,a2
    src += n;
    1268:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    126a:	fec05ae3          	blez	a2,125e <memmove+0x28>
    126e:	fff6079b          	addiw	a5,a2,-1
    1272:	1782                	slli	a5,a5,0x20
    1274:	9381                	srli	a5,a5,0x20
    1276:	fff7c793          	not	a5,a5
    127a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    127c:	15fd                	addi	a1,a1,-1
    127e:	177d                	addi	a4,a4,-1
    1280:	0005c683          	lbu	a3,0(a1)
    1284:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    1288:	fee79ae3          	bne	a5,a4,127c <memmove+0x46>
    128c:	bfc9                	j	125e <memmove+0x28>

000000000000128e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    128e:	1141                	addi	sp,sp,-16
    1290:	e422                	sd	s0,8(sp)
    1292:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    1294:	ca05                	beqz	a2,12c4 <memcmp+0x36>
    1296:	fff6069b          	addiw	a3,a2,-1
    129a:	1682                	slli	a3,a3,0x20
    129c:	9281                	srli	a3,a3,0x20
    129e:	0685                	addi	a3,a3,1
    12a0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    12a2:	00054783          	lbu	a5,0(a0)
    12a6:	0005c703          	lbu	a4,0(a1)
    12aa:	00e79863          	bne	a5,a4,12ba <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    12ae:	0505                	addi	a0,a0,1
    p2++;
    12b0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    12b2:	fed518e3          	bne	a0,a3,12a2 <memcmp+0x14>
  }
  return 0;
    12b6:	4501                	li	a0,0
    12b8:	a019                	j	12be <memcmp+0x30>
      return *p1 - *p2;
    12ba:	40e7853b          	subw	a0,a5,a4
}
    12be:	6422                	ld	s0,8(sp)
    12c0:	0141                	addi	sp,sp,16
    12c2:	8082                	ret
  return 0;
    12c4:	4501                	li	a0,0
    12c6:	bfe5                	j	12be <memcmp+0x30>

00000000000012c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    12c8:	1141                	addi	sp,sp,-16
    12ca:	e406                	sd	ra,8(sp)
    12cc:	e022                	sd	s0,0(sp)
    12ce:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    12d0:	00000097          	auipc	ra,0x0
    12d4:	f66080e7          	jalr	-154(ra) # 1236 <memmove>
}
    12d8:	60a2                	ld	ra,8(sp)
    12da:	6402                	ld	s0,0(sp)
    12dc:	0141                	addi	sp,sp,16
    12de:	8082                	ret

00000000000012e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
    12e0:	4885                	li	a7,1
 ecall
    12e2:	00000073          	ecall
 ret
    12e6:	8082                	ret

00000000000012e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
    12e8:	4889                	li	a7,2
 ecall
    12ea:	00000073          	ecall
 ret
    12ee:	8082                	ret

00000000000012f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
    12f0:	488d                	li	a7,3
 ecall
    12f2:	00000073          	ecall
 ret
    12f6:	8082                	ret

00000000000012f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    12f8:	4891                	li	a7,4
 ecall
    12fa:	00000073          	ecall
 ret
    12fe:	8082                	ret

0000000000001300 <read>:
.global read
read:
 li a7, SYS_read
    1300:	4895                	li	a7,5
 ecall
    1302:	00000073          	ecall
 ret
    1306:	8082                	ret

0000000000001308 <write>:
.global write
write:
 li a7, SYS_write
    1308:	48c1                	li	a7,16
 ecall
    130a:	00000073          	ecall
 ret
    130e:	8082                	ret

0000000000001310 <close>:
.global close
close:
 li a7, SYS_close
    1310:	48d5                	li	a7,21
 ecall
    1312:	00000073          	ecall
 ret
    1316:	8082                	ret

0000000000001318 <kill>:
.global kill
kill:
 li a7, SYS_kill
    1318:	4899                	li	a7,6
 ecall
    131a:	00000073          	ecall
 ret
    131e:	8082                	ret

0000000000001320 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1320:	489d                	li	a7,7
 ecall
    1322:	00000073          	ecall
 ret
    1326:	8082                	ret

0000000000001328 <open>:
.global open
open:
 li a7, SYS_open
    1328:	48bd                	li	a7,15
 ecall
    132a:	00000073          	ecall
 ret
    132e:	8082                	ret

0000000000001330 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1330:	48a1                	li	a7,8
 ecall
    1332:	00000073          	ecall
 ret
    1336:	8082                	ret

0000000000001338 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1338:	48d1                	li	a7,20
 ecall
    133a:	00000073          	ecall
 ret
    133e:	8082                	ret

0000000000001340 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1340:	48a5                	li	a7,9
 ecall
    1342:	00000073          	ecall
 ret
    1346:	8082                	ret

0000000000001348 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1348:	48a9                	li	a7,10
 ecall
    134a:	00000073          	ecall
 ret
    134e:	8082                	ret

0000000000001350 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1350:	48ad                	li	a7,11
 ecall
    1352:	00000073          	ecall
 ret
    1356:	8082                	ret

0000000000001358 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1358:	48b1                	li	a7,12
 ecall
    135a:	00000073          	ecall
 ret
    135e:	8082                	ret

0000000000001360 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1360:	48b5                	li	a7,13
 ecall
    1362:	00000073          	ecall
 ret
    1366:	8082                	ret

0000000000001368 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1368:	48b9                	li	a7,14
 ecall
    136a:	00000073          	ecall
 ret
    136e:	8082                	ret

0000000000001370 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
    1370:	48d9                	li	a7,22
 ecall
    1372:	00000073          	ecall
 ret
    1376:	8082                	ret

0000000000001378 <dev>:
.global dev
dev:
 li a7, SYS_dev
    1378:	48dd                	li	a7,23
 ecall
    137a:	00000073          	ecall
 ret
    137e:	8082                	ret

0000000000001380 <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
    1380:	48e1                	li	a7,24
 ecall
    1382:	00000073          	ecall
 ret
    1386:	8082                	ret

0000000000001388 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
    1388:	48e5                	li	a7,25
 ecall
    138a:	00000073          	ecall
 ret
    138e:	8082                	ret

0000000000001390 <remove>:
.global remove
remove:
 li a7, SYS_remove
    1390:	48c5                	li	a7,17
 ecall
    1392:	00000073          	ecall
 ret
    1396:	8082                	ret

0000000000001398 <trace>:
.global trace
trace:
 li a7, SYS_trace
    1398:	48c9                	li	a7,18
 ecall
    139a:	00000073          	ecall
 ret
    139e:	8082                	ret

00000000000013a0 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
    13a0:	48cd                	li	a7,19
 ecall
    13a2:	00000073          	ecall
 ret
    13a6:	8082                	ret

00000000000013a8 <rename>:
.global rename
rename:
 li a7, SYS_rename
    13a8:	48e9                	li	a7,26
 ecall
    13aa:	00000073          	ecall
 ret
    13ae:	8082                	ret

00000000000013b0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    13b0:	1101                	addi	sp,sp,-32
    13b2:	ec06                	sd	ra,24(sp)
    13b4:	e822                	sd	s0,16(sp)
    13b6:	1000                	addi	s0,sp,32
    13b8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    13bc:	4605                	li	a2,1
    13be:	fef40593          	addi	a1,s0,-17
    13c2:	00000097          	auipc	ra,0x0
    13c6:	f46080e7          	jalr	-186(ra) # 1308 <write>
}
    13ca:	60e2                	ld	ra,24(sp)
    13cc:	6442                	ld	s0,16(sp)
    13ce:	6105                	addi	sp,sp,32
    13d0:	8082                	ret

00000000000013d2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13d2:	7139                	addi	sp,sp,-64
    13d4:	fc06                	sd	ra,56(sp)
    13d6:	f822                	sd	s0,48(sp)
    13d8:	f426                	sd	s1,40(sp)
    13da:	f04a                	sd	s2,32(sp)
    13dc:	ec4e                	sd	s3,24(sp)
    13de:	0080                	addi	s0,sp,64
    13e0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13e2:	c299                	beqz	a3,13e8 <printint+0x16>
    13e4:	0805c763          	bltz	a1,1472 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    13e8:	2581                	sext.w	a1,a1
  neg = 0;
    13ea:	4881                	li	a7,0
  }

  i = 0;
    13ec:	fc040993          	addi	s3,s0,-64
  neg = 0;
    13f0:	86ce                	mv	a3,s3
  i = 0;
    13f2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    13f4:	2601                	sext.w	a2,a2
    13f6:	00000517          	auipc	a0,0x0
    13fa:	62250513          	addi	a0,a0,1570 # 1a18 <digits>
    13fe:	883a                	mv	a6,a4
    1400:	2705                	addiw	a4,a4,1
    1402:	02c5f7bb          	remuw	a5,a1,a2
    1406:	1782                	slli	a5,a5,0x20
    1408:	9381                	srli	a5,a5,0x20
    140a:	97aa                	add	a5,a5,a0
    140c:	0007c783          	lbu	a5,0(a5)
    1410:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    1414:	0005879b          	sext.w	a5,a1
    1418:	02c5d5bb          	divuw	a1,a1,a2
    141c:	0685                	addi	a3,a3,1
    141e:	fec7f0e3          	bgeu	a5,a2,13fe <printint+0x2c>
  if(neg)
    1422:	00088b63          	beqz	a7,1438 <printint+0x66>
    buf[i++] = '-';
    1426:	fd040793          	addi	a5,s0,-48
    142a:	973e                	add	a4,a4,a5
    142c:	02d00793          	li	a5,45
    1430:	fef70823          	sb	a5,-16(a4)
    1434:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    1438:	02e05663          	blez	a4,1464 <printint+0x92>
    143c:	fc040913          	addi	s2,s0,-64
    1440:	993a                	add	s2,s2,a4
    1442:	19fd                	addi	s3,s3,-1
    1444:	99ba                	add	s3,s3,a4
    1446:	377d                	addiw	a4,a4,-1
    1448:	1702                	slli	a4,a4,0x20
    144a:	9301                	srli	a4,a4,0x20
    144c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1450:	fff94583          	lbu	a1,-1(s2)
    1454:	8526                	mv	a0,s1
    1456:	00000097          	auipc	ra,0x0
    145a:	f5a080e7          	jalr	-166(ra) # 13b0 <putc>
  while(--i >= 0)
    145e:	197d                	addi	s2,s2,-1
    1460:	ff3918e3          	bne	s2,s3,1450 <printint+0x7e>
}
    1464:	70e2                	ld	ra,56(sp)
    1466:	7442                	ld	s0,48(sp)
    1468:	74a2                	ld	s1,40(sp)
    146a:	7902                	ld	s2,32(sp)
    146c:	69e2                	ld	s3,24(sp)
    146e:	6121                	addi	sp,sp,64
    1470:	8082                	ret
    x = -xx;
    1472:	40b005bb          	negw	a1,a1
    neg = 1;
    1476:	4885                	li	a7,1
    x = -xx;
    1478:	bf95                	j	13ec <printint+0x1a>

000000000000147a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    147a:	7119                	addi	sp,sp,-128
    147c:	fc86                	sd	ra,120(sp)
    147e:	f8a2                	sd	s0,112(sp)
    1480:	f4a6                	sd	s1,104(sp)
    1482:	f0ca                	sd	s2,96(sp)
    1484:	ecce                	sd	s3,88(sp)
    1486:	e8d2                	sd	s4,80(sp)
    1488:	e4d6                	sd	s5,72(sp)
    148a:	e0da                	sd	s6,64(sp)
    148c:	fc5e                	sd	s7,56(sp)
    148e:	f862                	sd	s8,48(sp)
    1490:	f466                	sd	s9,40(sp)
    1492:	f06a                	sd	s10,32(sp)
    1494:	ec6e                	sd	s11,24(sp)
    1496:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1498:	0005c903          	lbu	s2,0(a1)
    149c:	18090f63          	beqz	s2,163a <vprintf+0x1c0>
    14a0:	8aaa                	mv	s5,a0
    14a2:	8b32                	mv	s6,a2
    14a4:	00158493          	addi	s1,a1,1
  state = 0;
    14a8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    14aa:	02500a13          	li	s4,37
      if(c == 'd'){
    14ae:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    14b2:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    14b6:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    14ba:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    14be:	00000b97          	auipc	s7,0x0
    14c2:	55ab8b93          	addi	s7,s7,1370 # 1a18 <digits>
    14c6:	a839                	j	14e4 <vprintf+0x6a>
        putc(fd, c);
    14c8:	85ca                	mv	a1,s2
    14ca:	8556                	mv	a0,s5
    14cc:	00000097          	auipc	ra,0x0
    14d0:	ee4080e7          	jalr	-284(ra) # 13b0 <putc>
    14d4:	a019                	j	14da <vprintf+0x60>
    } else if(state == '%'){
    14d6:	01498f63          	beq	s3,s4,14f4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    14da:	0485                	addi	s1,s1,1
    14dc:	fff4c903          	lbu	s2,-1(s1)
    14e0:	14090d63          	beqz	s2,163a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    14e4:	0009079b          	sext.w	a5,s2
    if(state == 0){
    14e8:	fe0997e3          	bnez	s3,14d6 <vprintf+0x5c>
      if(c == '%'){
    14ec:	fd479ee3          	bne	a5,s4,14c8 <vprintf+0x4e>
        state = '%';
    14f0:	89be                	mv	s3,a5
    14f2:	b7e5                	j	14da <vprintf+0x60>
      if(c == 'd'){
    14f4:	05878063          	beq	a5,s8,1534 <vprintf+0xba>
      } else if(c == 'l') {
    14f8:	05978c63          	beq	a5,s9,1550 <vprintf+0xd6>
      } else if(c == 'x') {
    14fc:	07a78863          	beq	a5,s10,156c <vprintf+0xf2>
      } else if(c == 'p') {
    1500:	09b78463          	beq	a5,s11,1588 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    1504:	07300713          	li	a4,115
    1508:	0ce78663          	beq	a5,a4,15d4 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    150c:	06300713          	li	a4,99
    1510:	0ee78e63          	beq	a5,a4,160c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    1514:	11478863          	beq	a5,s4,1624 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1518:	85d2                	mv	a1,s4
    151a:	8556                	mv	a0,s5
    151c:	00000097          	auipc	ra,0x0
    1520:	e94080e7          	jalr	-364(ra) # 13b0 <putc>
        putc(fd, c);
    1524:	85ca                	mv	a1,s2
    1526:	8556                	mv	a0,s5
    1528:	00000097          	auipc	ra,0x0
    152c:	e88080e7          	jalr	-376(ra) # 13b0 <putc>
      }
      state = 0;
    1530:	4981                	li	s3,0
    1532:	b765                	j	14da <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    1534:	008b0913          	addi	s2,s6,8
    1538:	4685                	li	a3,1
    153a:	4629                	li	a2,10
    153c:	000b2583          	lw	a1,0(s6)
    1540:	8556                	mv	a0,s5
    1542:	00000097          	auipc	ra,0x0
    1546:	e90080e7          	jalr	-368(ra) # 13d2 <printint>
    154a:	8b4a                	mv	s6,s2
      state = 0;
    154c:	4981                	li	s3,0
    154e:	b771                	j	14da <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1550:	008b0913          	addi	s2,s6,8
    1554:	4681                	li	a3,0
    1556:	4629                	li	a2,10
    1558:	000b2583          	lw	a1,0(s6)
    155c:	8556                	mv	a0,s5
    155e:	00000097          	auipc	ra,0x0
    1562:	e74080e7          	jalr	-396(ra) # 13d2 <printint>
    1566:	8b4a                	mv	s6,s2
      state = 0;
    1568:	4981                	li	s3,0
    156a:	bf85                	j	14da <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    156c:	008b0913          	addi	s2,s6,8
    1570:	4681                	li	a3,0
    1572:	4641                	li	a2,16
    1574:	000b2583          	lw	a1,0(s6)
    1578:	8556                	mv	a0,s5
    157a:	00000097          	auipc	ra,0x0
    157e:	e58080e7          	jalr	-424(ra) # 13d2 <printint>
    1582:	8b4a                	mv	s6,s2
      state = 0;
    1584:	4981                	li	s3,0
    1586:	bf91                	j	14da <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    1588:	008b0793          	addi	a5,s6,8
    158c:	f8f43423          	sd	a5,-120(s0)
    1590:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    1594:	03000593          	li	a1,48
    1598:	8556                	mv	a0,s5
    159a:	00000097          	auipc	ra,0x0
    159e:	e16080e7          	jalr	-490(ra) # 13b0 <putc>
  putc(fd, 'x');
    15a2:	85ea                	mv	a1,s10
    15a4:	8556                	mv	a0,s5
    15a6:	00000097          	auipc	ra,0x0
    15aa:	e0a080e7          	jalr	-502(ra) # 13b0 <putc>
    15ae:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    15b0:	03c9d793          	srli	a5,s3,0x3c
    15b4:	97de                	add	a5,a5,s7
    15b6:	0007c583          	lbu	a1,0(a5)
    15ba:	8556                	mv	a0,s5
    15bc:	00000097          	auipc	ra,0x0
    15c0:	df4080e7          	jalr	-524(ra) # 13b0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    15c4:	0992                	slli	s3,s3,0x4
    15c6:	397d                	addiw	s2,s2,-1
    15c8:	fe0914e3          	bnez	s2,15b0 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    15cc:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    15d0:	4981                	li	s3,0
    15d2:	b721                	j	14da <vprintf+0x60>
        s = va_arg(ap, char*);
    15d4:	008b0993          	addi	s3,s6,8
    15d8:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    15dc:	02090163          	beqz	s2,15fe <vprintf+0x184>
        while(*s != 0){
    15e0:	00094583          	lbu	a1,0(s2)
    15e4:	c9a1                	beqz	a1,1634 <vprintf+0x1ba>
          putc(fd, *s);
    15e6:	8556                	mv	a0,s5
    15e8:	00000097          	auipc	ra,0x0
    15ec:	dc8080e7          	jalr	-568(ra) # 13b0 <putc>
          s++;
    15f0:	0905                	addi	s2,s2,1
        while(*s != 0){
    15f2:	00094583          	lbu	a1,0(s2)
    15f6:	f9e5                	bnez	a1,15e6 <vprintf+0x16c>
        s = va_arg(ap, char*);
    15f8:	8b4e                	mv	s6,s3
      state = 0;
    15fa:	4981                	li	s3,0
    15fc:	bdf9                	j	14da <vprintf+0x60>
          s = "(null)";
    15fe:	00000917          	auipc	s2,0x0
    1602:	41290913          	addi	s2,s2,1042 # 1a10 <malloc+0x2cc>
        while(*s != 0){
    1606:	02800593          	li	a1,40
    160a:	bff1                	j	15e6 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    160c:	008b0913          	addi	s2,s6,8
    1610:	000b4583          	lbu	a1,0(s6)
    1614:	8556                	mv	a0,s5
    1616:	00000097          	auipc	ra,0x0
    161a:	d9a080e7          	jalr	-614(ra) # 13b0 <putc>
    161e:	8b4a                	mv	s6,s2
      state = 0;
    1620:	4981                	li	s3,0
    1622:	bd65                	j	14da <vprintf+0x60>
        putc(fd, c);
    1624:	85d2                	mv	a1,s4
    1626:	8556                	mv	a0,s5
    1628:	00000097          	auipc	ra,0x0
    162c:	d88080e7          	jalr	-632(ra) # 13b0 <putc>
      state = 0;
    1630:	4981                	li	s3,0
    1632:	b565                	j	14da <vprintf+0x60>
        s = va_arg(ap, char*);
    1634:	8b4e                	mv	s6,s3
      state = 0;
    1636:	4981                	li	s3,0
    1638:	b54d                	j	14da <vprintf+0x60>
    }
  }
}
    163a:	70e6                	ld	ra,120(sp)
    163c:	7446                	ld	s0,112(sp)
    163e:	74a6                	ld	s1,104(sp)
    1640:	7906                	ld	s2,96(sp)
    1642:	69e6                	ld	s3,88(sp)
    1644:	6a46                	ld	s4,80(sp)
    1646:	6aa6                	ld	s5,72(sp)
    1648:	6b06                	ld	s6,64(sp)
    164a:	7be2                	ld	s7,56(sp)
    164c:	7c42                	ld	s8,48(sp)
    164e:	7ca2                	ld	s9,40(sp)
    1650:	7d02                	ld	s10,32(sp)
    1652:	6de2                	ld	s11,24(sp)
    1654:	6109                	addi	sp,sp,128
    1656:	8082                	ret

0000000000001658 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1658:	715d                	addi	sp,sp,-80
    165a:	ec06                	sd	ra,24(sp)
    165c:	e822                	sd	s0,16(sp)
    165e:	1000                	addi	s0,sp,32
    1660:	e010                	sd	a2,0(s0)
    1662:	e414                	sd	a3,8(s0)
    1664:	e818                	sd	a4,16(s0)
    1666:	ec1c                	sd	a5,24(s0)
    1668:	03043023          	sd	a6,32(s0)
    166c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1670:	8622                	mv	a2,s0
    1672:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1676:	00000097          	auipc	ra,0x0
    167a:	e04080e7          	jalr	-508(ra) # 147a <vprintf>
}
    167e:	60e2                	ld	ra,24(sp)
    1680:	6442                	ld	s0,16(sp)
    1682:	6161                	addi	sp,sp,80
    1684:	8082                	ret

0000000000001686 <printf>:

void
printf(const char *fmt, ...)
{
    1686:	711d                	addi	sp,sp,-96
    1688:	ec06                	sd	ra,24(sp)
    168a:	e822                	sd	s0,16(sp)
    168c:	1000                	addi	s0,sp,32
    168e:	e40c                	sd	a1,8(s0)
    1690:	e810                	sd	a2,16(s0)
    1692:	ec14                	sd	a3,24(s0)
    1694:	f018                	sd	a4,32(s0)
    1696:	f41c                	sd	a5,40(s0)
    1698:	03043823          	sd	a6,48(s0)
    169c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    16a0:	00840613          	addi	a2,s0,8
    16a4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    16a8:	85aa                	mv	a1,a0
    16aa:	4505                	li	a0,1
    16ac:	00000097          	auipc	ra,0x0
    16b0:	dce080e7          	jalr	-562(ra) # 147a <vprintf>
}
    16b4:	60e2                	ld	ra,24(sp)
    16b6:	6442                	ld	s0,16(sp)
    16b8:	6125                	addi	sp,sp,96
    16ba:	8082                	ret

00000000000016bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16bc:	1141                	addi	sp,sp,-16
    16be:	e422                	sd	s0,8(sp)
    16c0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16c2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16c6:	00001797          	auipc	a5,0x1
    16ca:	c6a7b783          	ld	a5,-918(a5) # 2330 <freep>
    16ce:	a805                	j	16fe <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    16d0:	4618                	lw	a4,8(a2)
    16d2:	9db9                	addw	a1,a1,a4
    16d4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    16d8:	6398                	ld	a4,0(a5)
    16da:	6318                	ld	a4,0(a4)
    16dc:	fee53823          	sd	a4,-16(a0)
    16e0:	a091                	j	1724 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    16e2:	ff852703          	lw	a4,-8(a0)
    16e6:	9e39                	addw	a2,a2,a4
    16e8:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    16ea:	ff053703          	ld	a4,-16(a0)
    16ee:	e398                	sd	a4,0(a5)
    16f0:	a099                	j	1736 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16f2:	6398                	ld	a4,0(a5)
    16f4:	00e7e463          	bltu	a5,a4,16fc <free+0x40>
    16f8:	00e6ea63          	bltu	a3,a4,170c <free+0x50>
{
    16fc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16fe:	fed7fae3          	bgeu	a5,a3,16f2 <free+0x36>
    1702:	6398                	ld	a4,0(a5)
    1704:	00e6e463          	bltu	a3,a4,170c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1708:	fee7eae3          	bltu	a5,a4,16fc <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    170c:	ff852583          	lw	a1,-8(a0)
    1710:	6390                	ld	a2,0(a5)
    1712:	02059713          	slli	a4,a1,0x20
    1716:	9301                	srli	a4,a4,0x20
    1718:	0712                	slli	a4,a4,0x4
    171a:	9736                	add	a4,a4,a3
    171c:	fae60ae3          	beq	a2,a4,16d0 <free+0x14>
    bp->s.ptr = p->s.ptr;
    1720:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1724:	4790                	lw	a2,8(a5)
    1726:	02061713          	slli	a4,a2,0x20
    172a:	9301                	srli	a4,a4,0x20
    172c:	0712                	slli	a4,a4,0x4
    172e:	973e                	add	a4,a4,a5
    1730:	fae689e3          	beq	a3,a4,16e2 <free+0x26>
  } else
    p->s.ptr = bp;
    1734:	e394                	sd	a3,0(a5)
  freep = p;
    1736:	00001717          	auipc	a4,0x1
    173a:	bef73d23          	sd	a5,-1030(a4) # 2330 <freep>
}
    173e:	6422                	ld	s0,8(sp)
    1740:	0141                	addi	sp,sp,16
    1742:	8082                	ret

0000000000001744 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1744:	7139                	addi	sp,sp,-64
    1746:	fc06                	sd	ra,56(sp)
    1748:	f822                	sd	s0,48(sp)
    174a:	f426                	sd	s1,40(sp)
    174c:	f04a                	sd	s2,32(sp)
    174e:	ec4e                	sd	s3,24(sp)
    1750:	e852                	sd	s4,16(sp)
    1752:	e456                	sd	s5,8(sp)
    1754:	e05a                	sd	s6,0(sp)
    1756:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1758:	02051493          	slli	s1,a0,0x20
    175c:	9081                	srli	s1,s1,0x20
    175e:	04bd                	addi	s1,s1,15
    1760:	8091                	srli	s1,s1,0x4
    1762:	0014899b          	addiw	s3,s1,1
    1766:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1768:	00001517          	auipc	a0,0x1
    176c:	bc853503          	ld	a0,-1080(a0) # 2330 <freep>
    1770:	c515                	beqz	a0,179c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1772:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1774:	4798                	lw	a4,8(a5)
    1776:	04977163          	bgeu	a4,s1,17b8 <malloc+0x74>
    177a:	8a4e                	mv	s4,s3
    177c:	0009871b          	sext.w	a4,s3
    1780:	6685                	lui	a3,0x1
    1782:	00d77363          	bgeu	a4,a3,1788 <malloc+0x44>
    1786:	6a05                	lui	s4,0x1
    1788:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    178c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1790:	00001917          	auipc	s2,0x1
    1794:	ba090913          	addi	s2,s2,-1120 # 2330 <freep>
  if(p == (char*)-1)
    1798:	5afd                	li	s5,-1
    179a:	a89d                	j	1810 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
    179c:	00001797          	auipc	a5,0x1
    17a0:	b9478793          	addi	a5,a5,-1132 # 2330 <freep>
    17a4:	00001717          	auipc	a4,0x1
    17a8:	b9470713          	addi	a4,a4,-1132 # 2338 <base>
    17ac:	e398                	sd	a4,0(a5)
    17ae:	e798                	sd	a4,8(a5)
    base.s.size = 0;
    17b0:	0007a823          	sw	zero,16(a5)
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17b4:	87ba                	mv	a5,a4
    17b6:	b7d1                	j	177a <malloc+0x36>
      if(p->s.size == nunits)
    17b8:	02e48b63          	beq	s1,a4,17ee <malloc+0xaa>
        p->s.size -= nunits;
    17bc:	4137073b          	subw	a4,a4,s3
    17c0:	c798                	sw	a4,8(a5)
        p += p->s.size;
    17c2:	1702                	slli	a4,a4,0x20
    17c4:	9301                	srli	a4,a4,0x20
    17c6:	0712                	slli	a4,a4,0x4
    17c8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    17ca:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    17ce:	00001717          	auipc	a4,0x1
    17d2:	b6a73123          	sd	a0,-1182(a4) # 2330 <freep>
      return (void*)(p + 1);
    17d6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    17da:	70e2                	ld	ra,56(sp)
    17dc:	7442                	ld	s0,48(sp)
    17de:	74a2                	ld	s1,40(sp)
    17e0:	7902                	ld	s2,32(sp)
    17e2:	69e2                	ld	s3,24(sp)
    17e4:	6a42                	ld	s4,16(sp)
    17e6:	6aa2                	ld	s5,8(sp)
    17e8:	6b02                	ld	s6,0(sp)
    17ea:	6121                	addi	sp,sp,64
    17ec:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    17ee:	6398                	ld	a4,0(a5)
    17f0:	e118                	sd	a4,0(a0)
    17f2:	bff1                	j	17ce <malloc+0x8a>
  hp->s.size = nu;
    17f4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    17f8:	0541                	addi	a0,a0,16
    17fa:	00000097          	auipc	ra,0x0
    17fe:	ec2080e7          	jalr	-318(ra) # 16bc <free>
  return freep;
    1802:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1806:	d971                	beqz	a0,17da <malloc+0x96>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1808:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    180a:	4798                	lw	a4,8(a5)
    180c:	fa9776e3          	bgeu	a4,s1,17b8 <malloc+0x74>
    if(p == freep)
    1810:	00093703          	ld	a4,0(s2)
    1814:	853e                	mv	a0,a5
    1816:	fef719e3          	bne	a4,a5,1808 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
    181a:	8552                	mv	a0,s4
    181c:	00000097          	auipc	ra,0x0
    1820:	b3c080e7          	jalr	-1220(ra) # 1358 <sbrk>
  if(p == (char*)-1)
    1824:	fd5518e3          	bne	a0,s5,17f4 <malloc+0xb0>
        return 0;
    1828:	4501                	li	a0,0
    182a:	bf45                	j	17da <malloc+0x96>
