
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
  if((*s >= 'A' && *s <= 'Z') ||
       6:	00054683          	lbu	a3,0(a0)
       a:	fdf6f793          	andi	a5,a3,-33
       e:	fbf7879b          	addiw	a5,a5,-65
      12:	0ff7f793          	andi	a5,a5,255
      16:	4765                	li	a4,25
      18:	00f77763          	bgeu	a4,a5,26 <checkenvname+0x26>
     (*s >= 'a' && *s <= 'z') ||
      1c:	05f00793          	li	a5,95
      *s == '_')
    ;
  else
    return 0;
      20:	4701                	li	a4,0
     (*s >= 'a' && *s <= 'z') ||
      22:	02f69d63          	bne	a3,a5,5c <checkenvname+0x5c>
  char *tmp = s + 1;
      26:	00150713          	addi	a4,a0,1
  while((*tmp >= 'A' && *tmp <= 'Z') ||
      2a:	4665                	li	a2,25
        (*tmp >= 'a' && *tmp <= 'z') ||
      2c:	45a5                	li	a1,9
        (*tmp >= '0' && *tmp <= '9') ||
      2e:	05f00813          	li	a6,95
  while((*tmp >= 'A' && *tmp <= 'Z') ||
      32:	a011                	j	36 <checkenvname+0x36>
         *tmp == '_')
    tmp++;
      34:	0705                	addi	a4,a4,1
  while((*tmp >= 'A' && *tmp <= 'Z') ||
      36:	00074683          	lbu	a3,0(a4)
      3a:	fdf6f793          	andi	a5,a3,-33
      3e:	fbf7879b          	addiw	a5,a5,-65
      42:	0ff7f793          	andi	a5,a5,255
      46:	fef677e3          	bgeu	a2,a5,34 <checkenvname+0x34>
        (*tmp >= '0' && *tmp <= '9') ||
      4a:	fd06879b          	addiw	a5,a3,-48
        (*tmp >= 'a' && *tmp <= 'z') ||
      4e:	0ff7f793          	andi	a5,a5,255
      52:	fef5f1e3          	bgeu	a1,a5,34 <checkenvname+0x34>
        (*tmp >= '0' && *tmp <= '9') ||
      56:	fd068fe3          	beq	a3,a6,34 <checkenvname+0x34>
  return (int)(tmp - s);
      5a:	9f09                	subw	a4,a4,a0
}
      5c:	853a                	mv	a0,a4
      5e:	6422                	ld	s0,8(sp)
      60:	0141                	addi	sp,sp,16
      62:	8082                	ret

0000000000000064 <export>:

int
export(char *argv[])
{
      64:	7131                	addi	sp,sp,-192
      66:	fd06                	sd	ra,184(sp)
      68:	f922                	sd	s0,176(sp)
      6a:	f526                	sd	s1,168(sp)
      6c:	f14a                	sd	s2,160(sp)
      6e:	ed4e                	sd	s3,152(sp)
      70:	e952                	sd	s4,144(sp)
      72:	e556                	sd	s5,136(sp)
      74:	e15a                	sd	s6,128(sp)
      76:	0180                	addi	s0,sp,192
      78:	84aa                	mv	s1,a0
  if(!strcmp(argv[1], "-p"))
      7a:	00001597          	auipc	a1,0x1
      7e:	7de58593          	addi	a1,a1,2014 # 1858 <malloc+0x118>
      82:	6508                	ld	a0,8(a0)
      84:	00001097          	auipc	ra,0x1
      88:	fd4080e7          	jalr	-44(ra) # 1058 <strcmp>
      8c:	e125                	bnez	a0,ec <export+0x88>
      8e:	89aa                	mv	s3,a0
  { // print all the env vars
    if(!nenv)
      90:	00002797          	auipc	a5,0x2
      94:	9a878793          	addi	a5,a5,-1624 # 1a38 <nenv>
      98:	0007ab03          	lw	s6,0(a5)
      9c:	020b0e63          	beqz	s6,d8 <export+0x74>
      a0:	00002497          	auipc	s1,0x2
      a4:	a9048493          	addi	s1,s1,-1392 # 1b30 <envs>
    {
      printf("NO env var exported\n");
      return 0;
    }
    for(int i=0; i<nenv; i++)
      a8:	892a                	mv	s2,a0
      printf("export %s=%s\n", envs[i].name, envs[i].value);
      aa:	00001a97          	auipc	s5,0x1
      ae:	7cea8a93          	addi	s5,s5,1998 # 1878 <malloc+0x138>
    for(int i=0; i<nenv; i++)
      b2:	8a3e                	mv	s4,a5
      b4:	0f605e63          	blez	s6,1b0 <export+0x14c>
      printf("export %s=%s\n", envs[i].name, envs[i].value);
      b8:	02048613          	addi	a2,s1,32
      bc:	85a6                	mv	a1,s1
      be:	8556                	mv	a0,s5
      c0:	00001097          	auipc	ra,0x1
      c4:	5c0080e7          	jalr	1472(ra) # 1680 <printf>
    for(int i=0; i<nenv; i++)
      c8:	2905                	addiw	s2,s2,1
      ca:	08048493          	addi	s1,s1,128
      ce:	000a2783          	lw	a5,0(s4)
      d2:	fef943e3          	blt	s2,a5,b8 <export+0x54>
      d6:	a8e9                	j	1b0 <export+0x14c>
      printf("NO env var exported\n");
      d8:	00001517          	auipc	a0,0x1
      dc:	78850513          	addi	a0,a0,1928 # 1860 <malloc+0x120>
      e0:	00001097          	auipc	ra,0x1
      e4:	5a0080e7          	jalr	1440(ra) # 1680 <printf>
      return 0;
      e8:	89da                	mv	s3,s6
      ea:	a0d9                	j	1b0 <export+0x14c>
    return 0;
  }
  else if(nenv == NENVS)
      ec:	00002797          	auipc	a5,0x2
      f0:	94c78793          	addi	a5,a5,-1716 # 1a38 <nenv>
      f4:	0007a983          	lw	s3,0(a5)
      f8:	47c1                	li	a5,16
      fa:	0cf98663          	beq	s3,a5,1c6 <export+0x162>
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
     112:	0ce78563          	beq	a5,a4,1dc <export+0x178>
     116:	fa040793          	addi	a5,s0,-96
     11a:	03d00693          	li	a3,61
     11e:	0785                	addi	a5,a5,1
     120:	0485                	addi	s1,s1,1
     122:	fff4c703          	lbu	a4,-1(s1)
     126:	00e78023          	sb	a4,0(a5)
     12a:	fed71ae3          	bne	a4,a3,11e <export+0xba>
    ;
  *t = 0;
     12e:	00078023          	sb	zero,0(a5)

  if(checkenvname(name) != ((s - argv[1]) - 1))
     132:	fa040513          	addi	a0,s0,-96
     136:	00000097          	auipc	ra,0x0
     13a:	eca080e7          	jalr	-310(ra) # 0 <checkenvname>
     13e:	41248933          	sub	s2,s1,s2
     142:	197d                	addi	s2,s2,-1
     144:	09251f63          	bne	a0,s2,1e2 <export+0x17e>
  {
    fprintf(2, "Invalid NAME!\n");
    return -1;
  }
  for(t=value; (*t=*s); s++, t++)
     148:	0004c703          	lbu	a4,0(s1)
     14c:	f4e40023          	sb	a4,-192(s0)
     150:	f4040793          	addi	a5,s0,-192
     154:	cb01                	beqz	a4,164 <export+0x100>
     156:	0485                	addi	s1,s1,1
     158:	0785                	addi	a5,a5,1
     15a:	0004c703          	lbu	a4,0(s1)
     15e:	00e78023          	sb	a4,0(a5)
     162:	fb75                	bnez	a4,156 <export+0xf2>
    ;
  if(*--t == '/')
     164:	fff7c683          	lbu	a3,-1(a5)
     168:	02f00713          	li	a4,47
     16c:	08e68663          	beq	a3,a4,1f8 <export+0x194>
    *t = 0;
  
  strcpy(envs[nenv].name, name);
     170:	00799513          	slli	a0,s3,0x7
     174:	00002917          	auipc	s2,0x2
     178:	9bc90913          	addi	s2,s2,-1604 # 1b30 <envs>
     17c:	fa040593          	addi	a1,s0,-96
     180:	954a                	add	a0,a0,s2
     182:	00001097          	auipc	ra,0x1
     186:	e8c080e7          	jalr	-372(ra) # 100e <strcpy>
  strcpy(envs[nenv].value, value);
     18a:	00002497          	auipc	s1,0x2
     18e:	8ae48493          	addi	s1,s1,-1874 # 1a38 <nenv>
     192:	4088                	lw	a0,0(s1)
     194:	051e                	slli	a0,a0,0x7
     196:	02050513          	addi	a0,a0,32
     19a:	f4040593          	addi	a1,s0,-192
     19e:	954a                	add	a0,a0,s2
     1a0:	00001097          	auipc	ra,0x1
     1a4:	e6e080e7          	jalr	-402(ra) # 100e <strcpy>
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
     1ca:	6c258593          	addi	a1,a1,1730 # 1888 <malloc+0x148>
     1ce:	4509                	li	a0,2
     1d0:	00001097          	auipc	ra,0x1
     1d4:	482080e7          	jalr	1154(ra) # 1652 <fprintf>
    return -1;
     1d8:	59fd                	li	s3,-1
     1da:	bfd9                	j	1b0 <export+0x14c>
  for(s=argv[1], t=name; (*t=*s++)!='='; t++)
     1dc:	fa040793          	addi	a5,s0,-96
     1e0:	b7b9                	j	12e <export+0xca>
    fprintf(2, "Invalid NAME!\n");
     1e2:	00001597          	auipc	a1,0x1
     1e6:	6be58593          	addi	a1,a1,1726 # 18a0 <malloc+0x160>
     1ea:	4509                	li	a0,2
     1ec:	00001097          	auipc	ra,0x1
     1f0:	466080e7          	jalr	1126(ra) # 1652 <fprintf>
    return -1;
     1f4:	59fd                	li	s3,-1
     1f6:	bf6d                	j	1b0 <export+0x14c>
    *t = 0;
     1f8:	fe078fa3          	sb	zero,-1(a5)
     1fc:	bf95                	j	170 <export+0x10c>

00000000000001fe <replace>:

int
replace(char *buf)
{
     1fe:	7151                	addi	sp,sp,-240
     200:	f586                	sd	ra,232(sp)
     202:	f1a2                	sd	s0,224(sp)
     204:	eda6                	sd	s1,216(sp)
     206:	e9ca                	sd	s2,208(sp)
     208:	e5ce                	sd	s3,200(sp)
     20a:	e1d2                	sd	s4,192(sp)
     20c:	fd56                	sd	s5,184(sp)
     20e:	f95a                	sd	s6,176(sp)
     210:	f55e                	sd	s7,168(sp)
     212:	f162                	sd	s8,160(sp)
     214:	ed66                	sd	s9,152(sp)
     216:	e96a                	sd	s10,144(sp)
     218:	1980                	addi	s0,sp,240
     21a:	89aa                	mv	s3,a0
  char raw[100], name[32], *s, *t, *tmp;
  int n = 0;
  strcpy(raw, buf);
     21c:	85aa                	mv	a1,a0
     21e:	f3840513          	addi	a0,s0,-200
     222:	00001097          	auipc	ra,0x1
     226:	dec080e7          	jalr	-532(ra) # 100e <strcpy>
  for(s=raw, t=buf; (*t=*s); t++)
     22a:	f3844783          	lbu	a5,-200(s0)
     22e:	00f98023          	sb	a5,0(s3)
     232:	c7ed                	beqz	a5,31c <replace+0x11e>
  int n = 0;
     234:	4c01                	li	s8,0
  for(s=raw, t=buf; (*t=*s); t++)
     236:	f3840713          	addi	a4,s0,-200
  {
    if(*s++ == '$'){
     23a:	02400b93          	li	s7,36
      tmp = name;
      if((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || *s == '_')
     23e:	4965                	li	s2,25
      {
        *tmp++ = *s++;
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
     240:	4a25                	li	s4,9
     242:	05f00a93          	li	s5,95
          *tmp++ = *s++;
        *tmp = 0;
        for(int i=0; i<nenv; i++)
     246:	00001b17          	auipc	s6,0x1
     24a:	7f2b0b13          	addi	s6,s6,2034 # 1a38 <nenv>
     24e:	a03d                	j	27c <replace+0x7e>
      if((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || *s == '_')
     250:	00174683          	lbu	a3,1(a4)
     254:	fdf6f793          	andi	a5,a3,-33
     258:	fbf7879b          	addiw	a5,a5,-65
     25c:	0ff7f793          	andi	a5,a5,255
     260:	02f97563          	bgeu	s2,a5,28a <replace+0x8c>
     264:	03568363          	beq	a3,s5,28a <replace+0x8c>
          if(!strcmp(name, envs[i].name))
            for(tmp=envs[i].value; (*t=*tmp); t++, tmp++)
              ;
        t--;
      }
      n++;
     268:	2c05                	addiw	s8,s8,1
     26a:	86ce                	mv	a3,s3
     26c:	8726                	mv	a4,s1
  for(s=raw, t=buf; (*t=*s); t++)
     26e:	00168993          	addi	s3,a3,1
     272:	00074783          	lbu	a5,0(a4)
     276:	00f680a3          	sb	a5,1(a3)
     27a:	c3d5                	beqz	a5,31e <replace+0x120>
    if(*s++ == '$'){
     27c:	00170493          	addi	s1,a4,1
     280:	fd7788e3          	beq	a5,s7,250 <replace+0x52>
     284:	86ce                	mv	a3,s3
     286:	8726                	mv	a4,s1
     288:	b7dd                	j	26e <replace+0x70>
        *tmp++ = *s++;
     28a:	00270493          	addi	s1,a4,2
     28e:	f0d40c23          	sb	a3,-232(s0)
     292:	f1940693          	addi	a3,s0,-231
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
     296:	a029                	j	2a0 <replace+0xa2>
          *tmp++ = *s++;
     298:	0485                	addi	s1,s1,1
     29a:	0685                	addi	a3,a3,1
     29c:	fee68fa3          	sb	a4,-1(a3)
        while((*s >= 'A' && *s <= 'Z') || (*s >= 'a' && *s <= 'z') || (*s >= '0' && *s <= '9') || *s == '_')
     2a0:	0004c703          	lbu	a4,0(s1)
     2a4:	fdf77793          	andi	a5,a4,-33
     2a8:	fbf7879b          	addiw	a5,a5,-65
     2ac:	0ff7f793          	andi	a5,a5,255
     2b0:	fef974e3          	bgeu	s2,a5,298 <replace+0x9a>
     2b4:	fd07079b          	addiw	a5,a4,-48
     2b8:	0ff7f793          	andi	a5,a5,255
     2bc:	fcfa7ee3          	bgeu	s4,a5,298 <replace+0x9a>
     2c0:	fd570ce3          	beq	a4,s5,298 <replace+0x9a>
        *tmp = 0;
     2c4:	00068023          	sb	zero,0(a3)
        for(int i=0; i<nenv; i++)
     2c8:	000b2783          	lw	a5,0(s6)
     2cc:	04f05663          	blez	a5,318 <replace+0x11a>
     2d0:	00002c97          	auipc	s9,0x2
     2d4:	860c8c93          	addi	s9,s9,-1952 # 1b30 <envs>
     2d8:	4d01                	li	s10,0
     2da:	a801                	j	2ea <replace+0xec>
     2dc:	2d05                	addiw	s10,s10,1
     2de:	080c8c93          	addi	s9,s9,128
     2e2:	000b2783          	lw	a5,0(s6)
     2e6:	02fd5963          	bge	s10,a5,318 <replace+0x11a>
          if(!strcmp(name, envs[i].name))
     2ea:	85e6                	mv	a1,s9
     2ec:	f1840513          	addi	a0,s0,-232
     2f0:	00001097          	auipc	ra,0x1
     2f4:	d68080e7          	jalr	-664(ra) # 1058 <strcmp>
     2f8:	f175                	bnez	a0,2dc <replace+0xde>
            for(tmp=envs[i].value; (*t=*tmp); t++, tmp++)
     2fa:	020c8793          	addi	a5,s9,32
     2fe:	020cc703          	lbu	a4,32(s9)
     302:	00e98023          	sb	a4,0(s3)
     306:	db79                	beqz	a4,2dc <replace+0xde>
     308:	0985                	addi	s3,s3,1
     30a:	0785                	addi	a5,a5,1
     30c:	0007c703          	lbu	a4,0(a5)
     310:	00e98023          	sb	a4,0(s3)
     314:	fb75                	bnez	a4,308 <replace+0x10a>
     316:	b7d9                	j	2dc <replace+0xde>
        t--;
     318:	19fd                	addi	s3,s3,-1
     31a:	b7b9                	j	268 <replace+0x6a>
  int n = 0;
     31c:	4c01                	li	s8,0
    }
  }
  return n;
}
     31e:	8562                	mv	a0,s8
     320:	70ae                	ld	ra,232(sp)
     322:	740e                	ld	s0,224(sp)
     324:	64ee                	ld	s1,216(sp)
     326:	694e                	ld	s2,208(sp)
     328:	69ae                	ld	s3,200(sp)
     32a:	6a0e                	ld	s4,192(sp)
     32c:	7aea                	ld	s5,184(sp)
     32e:	7b4a                	ld	s6,176(sp)
     330:	7baa                	ld	s7,168(sp)
     332:	7c0a                	ld	s8,160(sp)
     334:	6cea                	ld	s9,152(sp)
     336:	6d4a                	ld	s10,144(sp)
     338:	616d                	addi	sp,sp,240
     33a:	8082                	ret

000000000000033c <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
     33c:	1101                	addi	sp,sp,-32
     33e:	ec06                	sd	ra,24(sp)
     340:	e822                	sd	s0,16(sp)
     342:	e426                	sd	s1,8(sp)
     344:	e04a                	sd	s2,0(sp)
     346:	1000                	addi	s0,sp,32
     348:	84aa                	mv	s1,a0
     34a:	892e                	mv	s2,a1
  fprintf(2, "-> %s $ ", mycwd);
     34c:	00001617          	auipc	a2,0x1
     350:	6fc60613          	addi	a2,a2,1788 # 1a48 <mycwd>
     354:	00001597          	auipc	a1,0x1
     358:	55c58593          	addi	a1,a1,1372 # 18b0 <malloc+0x170>
     35c:	4509                	li	a0,2
     35e:	00001097          	auipc	ra,0x1
     362:	2f4080e7          	jalr	756(ra) # 1652 <fprintf>
  memset(buf, 0, nbuf);
     366:	864a                	mv	a2,s2
     368:	4581                	li	a1,0
     36a:	8526                	mv	a0,s1
     36c:	00001097          	auipc	ra,0x1
     370:	d4a080e7          	jalr	-694(ra) # 10b6 <memset>
  gets(buf, nbuf);
     374:	85ca                	mv	a1,s2
     376:	8526                	mv	a0,s1
     378:	00001097          	auipc	ra,0x1
     37c:	d8e080e7          	jalr	-626(ra) # 1106 <gets>
  if(buf[0] == 0) // EOF
     380:	0004c503          	lbu	a0,0(s1)
     384:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
     388:	40a00533          	neg	a0,a0
     38c:	60e2                	ld	ra,24(sp)
     38e:	6442                	ld	s0,16(sp)
     390:	64a2                	ld	s1,8(sp)
     392:	6902                	ld	s2,0(sp)
     394:	6105                	addi	sp,sp,32
     396:	8082                	ret

0000000000000398 <panic>:
  exit(0);
}

void
panic(char *s)
{
     398:	1141                	addi	sp,sp,-16
     39a:	e406                	sd	ra,8(sp)
     39c:	e022                	sd	s0,0(sp)
     39e:	0800                	addi	s0,sp,16
  fprintf(2, "%s\n", s);
     3a0:	862a                	mv	a2,a0
     3a2:	00001597          	auipc	a1,0x1
     3a6:	51e58593          	addi	a1,a1,1310 # 18c0 <malloc+0x180>
     3aa:	4509                	li	a0,2
     3ac:	00001097          	auipc	ra,0x1
     3b0:	2a6080e7          	jalr	678(ra) # 1652 <fprintf>
  exit(1);
     3b4:	4505                	li	a0,1
     3b6:	00001097          	auipc	ra,0x1
     3ba:	f2c080e7          	jalr	-212(ra) # 12e2 <exit>

00000000000003be <fork1>:
}

int
fork1(void)
{
     3be:	1141                	addi	sp,sp,-16
     3c0:	e406                	sd	ra,8(sp)
     3c2:	e022                	sd	s0,0(sp)
     3c4:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
     3c6:	00001097          	auipc	ra,0x1
     3ca:	f14080e7          	jalr	-236(ra) # 12da <fork>
  if(pid == -1)
     3ce:	57fd                	li	a5,-1
     3d0:	00f50663          	beq	a0,a5,3dc <fork1+0x1e>
    panic("fork");
  return pid;
}
     3d4:	60a2                	ld	ra,8(sp)
     3d6:	6402                	ld	s0,0(sp)
     3d8:	0141                	addi	sp,sp,16
     3da:	8082                	ret
    panic("fork");
     3dc:	00001517          	auipc	a0,0x1
     3e0:	4ec50513          	addi	a0,a0,1260 # 18c8 <malloc+0x188>
     3e4:	00000097          	auipc	ra,0x0
     3e8:	fb4080e7          	jalr	-76(ra) # 398 <panic>

00000000000003ec <runcmd>:
{
     3ec:	7175                	addi	sp,sp,-144
     3ee:	e506                	sd	ra,136(sp)
     3f0:	e122                	sd	s0,128(sp)
     3f2:	fca6                	sd	s1,120(sp)
     3f4:	f8ca                	sd	s2,112(sp)
     3f6:	f4ce                	sd	s3,104(sp)
     3f8:	f0d2                	sd	s4,96(sp)
     3fa:	ecd6                	sd	s5,88(sp)
     3fc:	e8da                	sd	s6,80(sp)
     3fe:	0900                	addi	s0,sp,144
  if(cmd == 0)
     400:	c10d                	beqz	a0,422 <runcmd+0x36>
     402:	84aa                	mv	s1,a0
  switch(cmd->type){
     404:	4118                	lw	a4,0(a0)
     406:	4795                	li	a5,5
     408:	02e7e263          	bltu	a5,a4,42c <runcmd+0x40>
     40c:	00056783          	lwu	a5,0(a0)
     410:	078a                	slli	a5,a5,0x2
     412:	00001717          	auipc	a4,0x1
     416:	41670713          	addi	a4,a4,1046 # 1828 <malloc+0xe8>
     41a:	97ba                	add	a5,a5,a4
     41c:	439c                	lw	a5,0(a5)
     41e:	97ba                	add	a5,a5,a4
     420:	8782                	jr	a5
    exit(1);
     422:	4505                	li	a0,1
     424:	00001097          	auipc	ra,0x1
     428:	ebe080e7          	jalr	-322(ra) # 12e2 <exit>
    panic("runcmd");
     42c:	00001517          	auipc	a0,0x1
     430:	4a450513          	addi	a0,a0,1188 # 18d0 <malloc+0x190>
     434:	00000097          	auipc	ra,0x0
     438:	f64080e7          	jalr	-156(ra) # 398 <panic>
    if(ecmd->argv[0] == 0)
     43c:	6508                	ld	a0,8(a0)
     43e:	c155                	beqz	a0,4e2 <runcmd+0xf6>
    exec(ecmd->argv[0], ecmd->argv);
     440:	00848a13          	addi	s4,s1,8
     444:	85d2                	mv	a1,s4
     446:	00001097          	auipc	ra,0x1
     44a:	ed4080e7          	jalr	-300(ra) # 131a <exec>
    for(i=0; i<nenv; i++)
     44e:	00001797          	auipc	a5,0x1
     452:	5ea78793          	addi	a5,a5,1514 # 1a38 <nenv>
     456:	439c                	lw	a5,0(a5)
     458:	06f05663          	blez	a5,4c4 <runcmd+0xd8>
     45c:	00001917          	auipc	s2,0x1
     460:	6f590913          	addi	s2,s2,1781 # 1b51 <envs+0x21>
     464:	4981                	li	s3,0
      *s_tmp++ = '/';
     466:	02f00b13          	li	s6,47
    for(i=0; i<nenv; i++)
     46a:	00001a97          	auipc	s5,0x1
     46e:	5cea8a93          	addi	s5,s5,1486 # 1a38 <nenv>
      while((*s_tmp = *d_tmp++))
     472:	874a                	mv	a4,s2
     474:	fff94783          	lbu	a5,-1(s2)
     478:	f6f40c23          	sb	a5,-136(s0)
     47c:	cba5                	beqz	a5,4ec <runcmd+0x100>
      char *s_tmp = env_cmd;
     47e:	f7840793          	addi	a5,s0,-136
        s_tmp++;
     482:	0785                	addi	a5,a5,1
      while((*s_tmp = *d_tmp++))
     484:	0705                	addi	a4,a4,1
     486:	fff74683          	lbu	a3,-1(a4)
     48a:	00d78023          	sb	a3,0(a5)
     48e:	faf5                	bnez	a3,482 <runcmd+0x96>
      *s_tmp++ = '/';
     490:	00178713          	addi	a4,a5,1
     494:	01678023          	sb	s6,0(a5)
      d_tmp = ecmd->argv[0];
     498:	649c                	ld	a5,8(s1)
      while((*s_tmp++ = *d_tmp++))
     49a:	0785                	addi	a5,a5,1
     49c:	0705                	addi	a4,a4,1
     49e:	fff7c683          	lbu	a3,-1(a5)
     4a2:	fed70fa3          	sb	a3,-1(a4)
     4a6:	faf5                	bnez	a3,49a <runcmd+0xae>
      exec(env_cmd, ecmd->argv);
     4a8:	85d2                	mv	a1,s4
     4aa:	f7840513          	addi	a0,s0,-136
     4ae:	00001097          	auipc	ra,0x1
     4b2:	e6c080e7          	jalr	-404(ra) # 131a <exec>
    for(i=0; i<nenv; i++)
     4b6:	2985                	addiw	s3,s3,1
     4b8:	08090913          	addi	s2,s2,128
     4bc:	000aa783          	lw	a5,0(s5)
     4c0:	faf9c9e3          	blt	s3,a5,472 <runcmd+0x86>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     4c4:	6490                	ld	a2,8(s1)
     4c6:	00001597          	auipc	a1,0x1
     4ca:	41258593          	addi	a1,a1,1042 # 18d8 <malloc+0x198>
     4ce:	4509                	li	a0,2
     4d0:	00001097          	auipc	ra,0x1
     4d4:	182080e7          	jalr	386(ra) # 1652 <fprintf>
  exit(0);
     4d8:	4501                	li	a0,0
     4da:	00001097          	auipc	ra,0x1
     4de:	e08080e7          	jalr	-504(ra) # 12e2 <exit>
      exit(1);
     4e2:	4505                	li	a0,1
     4e4:	00001097          	auipc	ra,0x1
     4e8:	dfe080e7          	jalr	-514(ra) # 12e2 <exit>
      char *s_tmp = env_cmd;
     4ec:	f7840793          	addi	a5,s0,-136
     4f0:	b745                	j	490 <runcmd+0xa4>
    close(rcmd->fd);
     4f2:	5148                	lw	a0,36(a0)
     4f4:	00001097          	auipc	ra,0x1
     4f8:	e16080e7          	jalr	-490(ra) # 130a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     4fc:	508c                	lw	a1,32(s1)
     4fe:	6888                	ld	a0,16(s1)
     500:	00001097          	auipc	ra,0x1
     504:	e22080e7          	jalr	-478(ra) # 1322 <open>
     508:	00054763          	bltz	a0,516 <runcmd+0x12a>
    runcmd(rcmd->cmd);
     50c:	6488                	ld	a0,8(s1)
     50e:	00000097          	auipc	ra,0x0
     512:	ede080e7          	jalr	-290(ra) # 3ec <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     516:	6890                	ld	a2,16(s1)
     518:	00001597          	auipc	a1,0x1
     51c:	3d058593          	addi	a1,a1,976 # 18e8 <malloc+0x1a8>
     520:	4509                	li	a0,2
     522:	00001097          	auipc	ra,0x1
     526:	130080e7          	jalr	304(ra) # 1652 <fprintf>
      exit(1);
     52a:	4505                	li	a0,1
     52c:	00001097          	auipc	ra,0x1
     530:	db6080e7          	jalr	-586(ra) # 12e2 <exit>
    if(fork1() == 0)
     534:	00000097          	auipc	ra,0x0
     538:	e8a080e7          	jalr	-374(ra) # 3be <fork1>
     53c:	c919                	beqz	a0,552 <runcmd+0x166>
    wait(0);
     53e:	4501                	li	a0,0
     540:	00001097          	auipc	ra,0x1
     544:	daa080e7          	jalr	-598(ra) # 12ea <wait>
    runcmd(lcmd->right);
     548:	6888                	ld	a0,16(s1)
     54a:	00000097          	auipc	ra,0x0
     54e:	ea2080e7          	jalr	-350(ra) # 3ec <runcmd>
      runcmd(lcmd->left);
     552:	6488                	ld	a0,8(s1)
     554:	00000097          	auipc	ra,0x0
     558:	e98080e7          	jalr	-360(ra) # 3ec <runcmd>
    if(pipe(p) < 0)
     55c:	fb840513          	addi	a0,s0,-72
     560:	00001097          	auipc	ra,0x1
     564:	d92080e7          	jalr	-622(ra) # 12f2 <pipe>
     568:	04054363          	bltz	a0,5ae <runcmd+0x1c2>
    if(fork1() == 0){
     56c:	00000097          	auipc	ra,0x0
     570:	e52080e7          	jalr	-430(ra) # 3be <fork1>
     574:	c529                	beqz	a0,5be <runcmd+0x1d2>
    if(fork1() == 0){
     576:	00000097          	auipc	ra,0x0
     57a:	e48080e7          	jalr	-440(ra) # 3be <fork1>
     57e:	cd25                	beqz	a0,5f6 <runcmd+0x20a>
    close(p[0]);
     580:	fb842503          	lw	a0,-72(s0)
     584:	00001097          	auipc	ra,0x1
     588:	d86080e7          	jalr	-634(ra) # 130a <close>
    close(p[1]);
     58c:	fbc42503          	lw	a0,-68(s0)
     590:	00001097          	auipc	ra,0x1
     594:	d7a080e7          	jalr	-646(ra) # 130a <close>
    wait(0);
     598:	4501                	li	a0,0
     59a:	00001097          	auipc	ra,0x1
     59e:	d50080e7          	jalr	-688(ra) # 12ea <wait>
    wait(0);
     5a2:	4501                	li	a0,0
     5a4:	00001097          	auipc	ra,0x1
     5a8:	d46080e7          	jalr	-698(ra) # 12ea <wait>
    break;
     5ac:	b735                	j	4d8 <runcmd+0xec>
      panic("pipe");
     5ae:	00001517          	auipc	a0,0x1
     5b2:	34a50513          	addi	a0,a0,842 # 18f8 <malloc+0x1b8>
     5b6:	00000097          	auipc	ra,0x0
     5ba:	de2080e7          	jalr	-542(ra) # 398 <panic>
      close(1);
     5be:	4505                	li	a0,1
     5c0:	00001097          	auipc	ra,0x1
     5c4:	d4a080e7          	jalr	-694(ra) # 130a <close>
      dup(p[1]);
     5c8:	fbc42503          	lw	a0,-68(s0)
     5cc:	00001097          	auipc	ra,0x1
     5d0:	d76080e7          	jalr	-650(ra) # 1342 <dup>
      close(p[0]);
     5d4:	fb842503          	lw	a0,-72(s0)
     5d8:	00001097          	auipc	ra,0x1
     5dc:	d32080e7          	jalr	-718(ra) # 130a <close>
      close(p[1]);
     5e0:	fbc42503          	lw	a0,-68(s0)
     5e4:	00001097          	auipc	ra,0x1
     5e8:	d26080e7          	jalr	-730(ra) # 130a <close>
      runcmd(pcmd->left);
     5ec:	6488                	ld	a0,8(s1)
     5ee:	00000097          	auipc	ra,0x0
     5f2:	dfe080e7          	jalr	-514(ra) # 3ec <runcmd>
      close(0);
     5f6:	00001097          	auipc	ra,0x1
     5fa:	d14080e7          	jalr	-748(ra) # 130a <close>
      dup(p[0]);
     5fe:	fb842503          	lw	a0,-72(s0)
     602:	00001097          	auipc	ra,0x1
     606:	d40080e7          	jalr	-704(ra) # 1342 <dup>
      close(p[0]);
     60a:	fb842503          	lw	a0,-72(s0)
     60e:	00001097          	auipc	ra,0x1
     612:	cfc080e7          	jalr	-772(ra) # 130a <close>
      close(p[1]);
     616:	fbc42503          	lw	a0,-68(s0)
     61a:	00001097          	auipc	ra,0x1
     61e:	cf0080e7          	jalr	-784(ra) # 130a <close>
      runcmd(pcmd->right);
     622:	6888                	ld	a0,16(s1)
     624:	00000097          	auipc	ra,0x0
     628:	dc8080e7          	jalr	-568(ra) # 3ec <runcmd>
    if(fork1() == 0)
     62c:	00000097          	auipc	ra,0x0
     630:	d92080e7          	jalr	-622(ra) # 3be <fork1>
     634:	ea0512e3          	bnez	a0,4d8 <runcmd+0xec>
      runcmd(bcmd->cmd);
     638:	6488                	ld	a0,8(s1)
     63a:	00000097          	auipc	ra,0x0
     63e:	db2080e7          	jalr	-590(ra) # 3ec <runcmd>

0000000000000642 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     642:	1101                	addi	sp,sp,-32
     644:	ec06                	sd	ra,24(sp)
     646:	e822                	sd	s0,16(sp)
     648:	e426                	sd	s1,8(sp)
     64a:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     64c:	0a800513          	li	a0,168
     650:	00001097          	auipc	ra,0x1
     654:	0f0080e7          	jalr	240(ra) # 1740 <malloc>
     658:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     65a:	0a800613          	li	a2,168
     65e:	4581                	li	a1,0
     660:	00001097          	auipc	ra,0x1
     664:	a56080e7          	jalr	-1450(ra) # 10b6 <memset>
  cmd->type = EXEC;
     668:	4785                	li	a5,1
     66a:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     66c:	8526                	mv	a0,s1
     66e:	60e2                	ld	ra,24(sp)
     670:	6442                	ld	s0,16(sp)
     672:	64a2                	ld	s1,8(sp)
     674:	6105                	addi	sp,sp,32
     676:	8082                	ret

0000000000000678 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     678:	7139                	addi	sp,sp,-64
     67a:	fc06                	sd	ra,56(sp)
     67c:	f822                	sd	s0,48(sp)
     67e:	f426                	sd	s1,40(sp)
     680:	f04a                	sd	s2,32(sp)
     682:	ec4e                	sd	s3,24(sp)
     684:	e852                	sd	s4,16(sp)
     686:	e456                	sd	s5,8(sp)
     688:	e05a                	sd	s6,0(sp)
     68a:	0080                	addi	s0,sp,64
     68c:	8b2a                	mv	s6,a0
     68e:	8aae                	mv	s5,a1
     690:	8a32                	mv	s4,a2
     692:	89b6                	mv	s3,a3
     694:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     696:	02800513          	li	a0,40
     69a:	00001097          	auipc	ra,0x1
     69e:	0a6080e7          	jalr	166(ra) # 1740 <malloc>
     6a2:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     6a4:	02800613          	li	a2,40
     6a8:	4581                	li	a1,0
     6aa:	00001097          	auipc	ra,0x1
     6ae:	a0c080e7          	jalr	-1524(ra) # 10b6 <memset>
  cmd->type = REDIR;
     6b2:	4789                	li	a5,2
     6b4:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     6b6:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     6ba:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     6be:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     6c2:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     6c6:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     6ca:	8526                	mv	a0,s1
     6cc:	70e2                	ld	ra,56(sp)
     6ce:	7442                	ld	s0,48(sp)
     6d0:	74a2                	ld	s1,40(sp)
     6d2:	7902                	ld	s2,32(sp)
     6d4:	69e2                	ld	s3,24(sp)
     6d6:	6a42                	ld	s4,16(sp)
     6d8:	6aa2                	ld	s5,8(sp)
     6da:	6b02                	ld	s6,0(sp)
     6dc:	6121                	addi	sp,sp,64
     6de:	8082                	ret

00000000000006e0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     6e0:	7179                	addi	sp,sp,-48
     6e2:	f406                	sd	ra,40(sp)
     6e4:	f022                	sd	s0,32(sp)
     6e6:	ec26                	sd	s1,24(sp)
     6e8:	e84a                	sd	s2,16(sp)
     6ea:	e44e                	sd	s3,8(sp)
     6ec:	1800                	addi	s0,sp,48
     6ee:	89aa                	mv	s3,a0
     6f0:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6f2:	4561                	li	a0,24
     6f4:	00001097          	auipc	ra,0x1
     6f8:	04c080e7          	jalr	76(ra) # 1740 <malloc>
     6fc:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     6fe:	4661                	li	a2,24
     700:	4581                	li	a1,0
     702:	00001097          	auipc	ra,0x1
     706:	9b4080e7          	jalr	-1612(ra) # 10b6 <memset>
  cmd->type = PIPE;
     70a:	478d                	li	a5,3
     70c:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     70e:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     712:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     716:	8526                	mv	a0,s1
     718:	70a2                	ld	ra,40(sp)
     71a:	7402                	ld	s0,32(sp)
     71c:	64e2                	ld	s1,24(sp)
     71e:	6942                	ld	s2,16(sp)
     720:	69a2                	ld	s3,8(sp)
     722:	6145                	addi	sp,sp,48
     724:	8082                	ret

0000000000000726 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     726:	7179                	addi	sp,sp,-48
     728:	f406                	sd	ra,40(sp)
     72a:	f022                	sd	s0,32(sp)
     72c:	ec26                	sd	s1,24(sp)
     72e:	e84a                	sd	s2,16(sp)
     730:	e44e                	sd	s3,8(sp)
     732:	1800                	addi	s0,sp,48
     734:	89aa                	mv	s3,a0
     736:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     738:	4561                	li	a0,24
     73a:	00001097          	auipc	ra,0x1
     73e:	006080e7          	jalr	6(ra) # 1740 <malloc>
     742:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     744:	4661                	li	a2,24
     746:	4581                	li	a1,0
     748:	00001097          	auipc	ra,0x1
     74c:	96e080e7          	jalr	-1682(ra) # 10b6 <memset>
  cmd->type = LIST;
     750:	4791                	li	a5,4
     752:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     754:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     758:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     75c:	8526                	mv	a0,s1
     75e:	70a2                	ld	ra,40(sp)
     760:	7402                	ld	s0,32(sp)
     762:	64e2                	ld	s1,24(sp)
     764:	6942                	ld	s2,16(sp)
     766:	69a2                	ld	s3,8(sp)
     768:	6145                	addi	sp,sp,48
     76a:	8082                	ret

000000000000076c <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     76c:	1101                	addi	sp,sp,-32
     76e:	ec06                	sd	ra,24(sp)
     770:	e822                	sd	s0,16(sp)
     772:	e426                	sd	s1,8(sp)
     774:	e04a                	sd	s2,0(sp)
     776:	1000                	addi	s0,sp,32
     778:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     77a:	4541                	li	a0,16
     77c:	00001097          	auipc	ra,0x1
     780:	fc4080e7          	jalr	-60(ra) # 1740 <malloc>
     784:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     786:	4641                	li	a2,16
     788:	4581                	li	a1,0
     78a:	00001097          	auipc	ra,0x1
     78e:	92c080e7          	jalr	-1748(ra) # 10b6 <memset>
  cmd->type = BACK;
     792:	4795                	li	a5,5
     794:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     796:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     79a:	8526                	mv	a0,s1
     79c:	60e2                	ld	ra,24(sp)
     79e:	6442                	ld	s0,16(sp)
     7a0:	64a2                	ld	s1,8(sp)
     7a2:	6902                	ld	s2,0(sp)
     7a4:	6105                	addi	sp,sp,32
     7a6:	8082                	ret

00000000000007a8 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     7a8:	7139                	addi	sp,sp,-64
     7aa:	fc06                	sd	ra,56(sp)
     7ac:	f822                	sd	s0,48(sp)
     7ae:	f426                	sd	s1,40(sp)
     7b0:	f04a                	sd	s2,32(sp)
     7b2:	ec4e                	sd	s3,24(sp)
     7b4:	e852                	sd	s4,16(sp)
     7b6:	e456                	sd	s5,8(sp)
     7b8:	e05a                	sd	s6,0(sp)
     7ba:	0080                	addi	s0,sp,64
     7bc:	8a2a                	mv	s4,a0
     7be:	892e                	mv	s2,a1
     7c0:	8ab2                	mv	s5,a2
     7c2:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     7c4:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     7c6:	00001997          	auipc	s3,0x1
     7ca:	26a98993          	addi	s3,s3,618 # 1a30 <whitespace>
     7ce:	00b4fd63          	bgeu	s1,a1,7e8 <gettoken+0x40>
     7d2:	0004c583          	lbu	a1,0(s1)
     7d6:	854e                	mv	a0,s3
     7d8:	00001097          	auipc	ra,0x1
     7dc:	904080e7          	jalr	-1788(ra) # 10dc <strchr>
     7e0:	c501                	beqz	a0,7e8 <gettoken+0x40>
    s++;
     7e2:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     7e4:	fe9917e3          	bne	s2,s1,7d2 <gettoken+0x2a>
  if(q)
     7e8:	000a8463          	beqz	s5,7f0 <gettoken+0x48>
    *q = s;
     7ec:	009ab023          	sd	s1,0(s5)
  ret = *s;
     7f0:	0004c783          	lbu	a5,0(s1)
     7f4:	00078a9b          	sext.w	s5,a5
  switch(*s){
     7f8:	02900713          	li	a4,41
     7fc:	08f76f63          	bltu	a4,a5,89a <gettoken+0xf2>
     800:	02800713          	li	a4,40
     804:	0ae7f863          	bgeu	a5,a4,8b4 <gettoken+0x10c>
     808:	e3b9                	bnez	a5,84e <gettoken+0xa6>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     80a:	000b0463          	beqz	s6,812 <gettoken+0x6a>
    *eq = s;
     80e:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     812:	00001997          	auipc	s3,0x1
     816:	21e98993          	addi	s3,s3,542 # 1a30 <whitespace>
     81a:	0124fd63          	bgeu	s1,s2,834 <gettoken+0x8c>
     81e:	0004c583          	lbu	a1,0(s1)
     822:	854e                	mv	a0,s3
     824:	00001097          	auipc	ra,0x1
     828:	8b8080e7          	jalr	-1864(ra) # 10dc <strchr>
     82c:	c501                	beqz	a0,834 <gettoken+0x8c>
    s++;
     82e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     830:	fe9917e3          	bne	s2,s1,81e <gettoken+0x76>
  *ps = s;
     834:	009a3023          	sd	s1,0(s4)
  return ret;
}
     838:	8556                	mv	a0,s5
     83a:	70e2                	ld	ra,56(sp)
     83c:	7442                	ld	s0,48(sp)
     83e:	74a2                	ld	s1,40(sp)
     840:	7902                	ld	s2,32(sp)
     842:	69e2                	ld	s3,24(sp)
     844:	6a42                	ld	s4,16(sp)
     846:	6aa2                	ld	s5,8(sp)
     848:	6b02                	ld	s6,0(sp)
     84a:	6121                	addi	sp,sp,64
     84c:	8082                	ret
  switch(*s){
     84e:	02600713          	li	a4,38
     852:	06e78163          	beq	a5,a4,8b4 <gettoken+0x10c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     856:	00001997          	auipc	s3,0x1
     85a:	1da98993          	addi	s3,s3,474 # 1a30 <whitespace>
     85e:	00001a97          	auipc	s5,0x1
     862:	1caa8a93          	addi	s5,s5,458 # 1a28 <symbols>
     866:	0324f563          	bgeu	s1,s2,890 <gettoken+0xe8>
     86a:	0004c583          	lbu	a1,0(s1)
     86e:	854e                	mv	a0,s3
     870:	00001097          	auipc	ra,0x1
     874:	86c080e7          	jalr	-1940(ra) # 10dc <strchr>
     878:	e53d                	bnez	a0,8e6 <gettoken+0x13e>
     87a:	0004c583          	lbu	a1,0(s1)
     87e:	8556                	mv	a0,s5
     880:	00001097          	auipc	ra,0x1
     884:	85c080e7          	jalr	-1956(ra) # 10dc <strchr>
     888:	ed21                	bnez	a0,8e0 <gettoken+0x138>
      s++;
     88a:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     88c:	fc991fe3          	bne	s2,s1,86a <gettoken+0xc2>
  if(eq)
     890:	06100a93          	li	s5,97
     894:	f60b1de3          	bnez	s6,80e <gettoken+0x66>
     898:	bf71                	j	834 <gettoken+0x8c>
  switch(*s){
     89a:	03e00713          	li	a4,62
     89e:	02e78263          	beq	a5,a4,8c2 <gettoken+0x11a>
     8a2:	00f76b63          	bltu	a4,a5,8b8 <gettoken+0x110>
     8a6:	fc57879b          	addiw	a5,a5,-59
     8aa:	0ff7f793          	andi	a5,a5,255
     8ae:	4705                	li	a4,1
     8b0:	faf763e3          	bltu	a4,a5,856 <gettoken+0xae>
    s++;
     8b4:	0485                	addi	s1,s1,1
    break;
     8b6:	bf91                	j	80a <gettoken+0x62>
  switch(*s){
     8b8:	07c00713          	li	a4,124
     8bc:	fee78ce3          	beq	a5,a4,8b4 <gettoken+0x10c>
     8c0:	bf59                	j	856 <gettoken+0xae>
    s++;
     8c2:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     8c6:	0014c703          	lbu	a4,1(s1)
     8ca:	03e00793          	li	a5,62
      s++;
     8ce:	0489                	addi	s1,s1,2
      ret = '+';
     8d0:	02b00a93          	li	s5,43
    if(*s == '>'){
     8d4:	f2f70be3          	beq	a4,a5,80a <gettoken+0x62>
    s++;
     8d8:	84b6                	mv	s1,a3
  ret = *s;
     8da:	03e00a93          	li	s5,62
     8de:	b735                	j	80a <gettoken+0x62>
    ret = 'a';
     8e0:	06100a93          	li	s5,97
     8e4:	b71d                	j	80a <gettoken+0x62>
     8e6:	06100a93          	li	s5,97
     8ea:	b705                	j	80a <gettoken+0x62>

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
     91c:	7c4080e7          	jalr	1988(ra) # 10dc <strchr>
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
     94c:	794080e7          	jalr	1940(ra) # 10dc <strchr>
     950:	00a03533          	snez	a0,a0
     954:	b7c5                	j	934 <peek+0x48>

0000000000000956 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     956:	7159                	addi	sp,sp,-112
     958:	f486                	sd	ra,104(sp)
     95a:	f0a2                	sd	s0,96(sp)
     95c:	eca6                	sd	s1,88(sp)
     95e:	e8ca                	sd	s2,80(sp)
     960:	e4ce                	sd	s3,72(sp)
     962:	e0d2                	sd	s4,64(sp)
     964:	fc56                	sd	s5,56(sp)
     966:	f85a                	sd	s6,48(sp)
     968:	f45e                	sd	s7,40(sp)
     96a:	f062                	sd	s8,32(sp)
     96c:	ec66                	sd	s9,24(sp)
     96e:	1880                	addi	s0,sp,112
     970:	8b2a                	mv	s6,a0
     972:	89ae                	mv	s3,a1
     974:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     976:	00001b97          	auipc	s7,0x1
     97a:	faab8b93          	addi	s7,s7,-86 # 1920 <malloc+0x1e0>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     97e:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     982:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     986:	a02d                	j	9b0 <parseredirs+0x5a>
      panic("missing file for redirection");
     988:	00001517          	auipc	a0,0x1
     98c:	f7850513          	addi	a0,a0,-136 # 1900 <malloc+0x1c0>
     990:	00000097          	auipc	ra,0x0
     994:	a08080e7          	jalr	-1528(ra) # 398 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     998:	4701                	li	a4,0
     99a:	4681                	li	a3,0
     99c:	f9043603          	ld	a2,-112(s0)
     9a0:	f9843583          	ld	a1,-104(s0)
     9a4:	855a                	mv	a0,s6
     9a6:	00000097          	auipc	ra,0x0
     9aa:	cd2080e7          	jalr	-814(ra) # 678 <redircmd>
     9ae:	8b2a                	mv	s6,a0
    switch(tok){
     9b0:	03e00a93          	li	s5,62
     9b4:	02b00a13          	li	s4,43
  while(peek(ps, es, "<>")){
     9b8:	865e                	mv	a2,s7
     9ba:	85ca                	mv	a1,s2
     9bc:	854e                	mv	a0,s3
     9be:	00000097          	auipc	ra,0x0
     9c2:	f2e080e7          	jalr	-210(ra) # 8ec <peek>
     9c6:	c925                	beqz	a0,a36 <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     9c8:	4681                	li	a3,0
     9ca:	4601                	li	a2,0
     9cc:	85ca                	mv	a1,s2
     9ce:	854e                	mv	a0,s3
     9d0:	00000097          	auipc	ra,0x0
     9d4:	dd8080e7          	jalr	-552(ra) # 7a8 <gettoken>
     9d8:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     9da:	f9040693          	addi	a3,s0,-112
     9de:	f9840613          	addi	a2,s0,-104
     9e2:	85ca                	mv	a1,s2
     9e4:	854e                	mv	a0,s3
     9e6:	00000097          	auipc	ra,0x0
     9ea:	dc2080e7          	jalr	-574(ra) # 7a8 <gettoken>
     9ee:	f9851de3          	bne	a0,s8,988 <parseredirs+0x32>
    switch(tok){
     9f2:	fb9483e3          	beq	s1,s9,998 <parseredirs+0x42>
     9f6:	03548263          	beq	s1,s5,a1a <parseredirs+0xc4>
     9fa:	fb449fe3          	bne	s1,s4,9b8 <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_APPEND, 1);
     9fe:	4705                	li	a4,1
     a00:	04500693          	li	a3,69
     a04:	f9043603          	ld	a2,-112(s0)
     a08:	f9843583          	ld	a1,-104(s0)
     a0c:	855a                	mv	a0,s6
     a0e:	00000097          	auipc	ra,0x0
     a12:	c6a080e7          	jalr	-918(ra) # 678 <redircmd>
     a16:	8b2a                	mv	s6,a0
      break;
     a18:	bf61                	j	9b0 <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     a1a:	4705                	li	a4,1
     a1c:	44100693          	li	a3,1089
     a20:	f9043603          	ld	a2,-112(s0)
     a24:	f9843583          	ld	a1,-104(s0)
     a28:	855a                	mv	a0,s6
     a2a:	00000097          	auipc	ra,0x0
     a2e:	c4e080e7          	jalr	-946(ra) # 678 <redircmd>
     a32:	8b2a                	mv	s6,a0
      break;
     a34:	bfb5                	j	9b0 <parseredirs+0x5a>
    }
  }
  return cmd;
}
     a36:	855a                	mv	a0,s6
     a38:	70a6                	ld	ra,104(sp)
     a3a:	7406                	ld	s0,96(sp)
     a3c:	64e6                	ld	s1,88(sp)
     a3e:	6946                	ld	s2,80(sp)
     a40:	69a6                	ld	s3,72(sp)
     a42:	6a06                	ld	s4,64(sp)
     a44:	7ae2                	ld	s5,56(sp)
     a46:	7b42                	ld	s6,48(sp)
     a48:	7ba2                	ld	s7,40(sp)
     a4a:	7c02                	ld	s8,32(sp)
     a4c:	6ce2                	ld	s9,24(sp)
     a4e:	6165                	addi	sp,sp,112
     a50:	8082                	ret

0000000000000a52 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     a52:	7159                	addi	sp,sp,-112
     a54:	f486                	sd	ra,104(sp)
     a56:	f0a2                	sd	s0,96(sp)
     a58:	eca6                	sd	s1,88(sp)
     a5a:	e8ca                	sd	s2,80(sp)
     a5c:	e4ce                	sd	s3,72(sp)
     a5e:	e0d2                	sd	s4,64(sp)
     a60:	fc56                	sd	s5,56(sp)
     a62:	f85a                	sd	s6,48(sp)
     a64:	f45e                	sd	s7,40(sp)
     a66:	f062                	sd	s8,32(sp)
     a68:	ec66                	sd	s9,24(sp)
     a6a:	1880                	addi	s0,sp,112
     a6c:	89aa                	mv	s3,a0
     a6e:	8a2e                	mv	s4,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     a70:	00001617          	auipc	a2,0x1
     a74:	eb860613          	addi	a2,a2,-328 # 1928 <malloc+0x1e8>
     a78:	00000097          	auipc	ra,0x0
     a7c:	e74080e7          	jalr	-396(ra) # 8ec <peek>
     a80:	e905                	bnez	a0,ab0 <parseexec+0x5e>
     a82:	892a                	mv	s2,a0
    return parseblock(ps, es);

  ret = execcmd();
     a84:	00000097          	auipc	ra,0x0
     a88:	bbe080e7          	jalr	-1090(ra) # 642 <execcmd>
     a8c:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     a8e:	8652                	mv	a2,s4
     a90:	85ce                	mv	a1,s3
     a92:	00000097          	auipc	ra,0x0
     a96:	ec4080e7          	jalr	-316(ra) # 956 <parseredirs>
     a9a:	8aaa                	mv	s5,a0
  while(!peek(ps, es, "|)&;")){
     a9c:	008c0493          	addi	s1,s8,8
     aa0:	00001b17          	auipc	s6,0x1
     aa4:	ea8b0b13          	addi	s6,s6,-344 # 1948 <malloc+0x208>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     aa8:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     aac:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     aae:	a0b1                	j	afa <parseexec+0xa8>
    return parseblock(ps, es);
     ab0:	85d2                	mv	a1,s4
     ab2:	854e                	mv	a0,s3
     ab4:	00000097          	auipc	ra,0x0
     ab8:	1b8080e7          	jalr	440(ra) # c6c <parseblock>
     abc:	8aaa                	mv	s5,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     abe:	8556                	mv	a0,s5
     ac0:	70a6                	ld	ra,104(sp)
     ac2:	7406                	ld	s0,96(sp)
     ac4:	64e6                	ld	s1,88(sp)
     ac6:	6946                	ld	s2,80(sp)
     ac8:	69a6                	ld	s3,72(sp)
     aca:	6a06                	ld	s4,64(sp)
     acc:	7ae2                	ld	s5,56(sp)
     ace:	7b42                	ld	s6,48(sp)
     ad0:	7ba2                	ld	s7,40(sp)
     ad2:	7c02                	ld	s8,32(sp)
     ad4:	6ce2                	ld	s9,24(sp)
     ad6:	6165                	addi	sp,sp,112
     ad8:	8082                	ret
      panic("syntax");
     ada:	00001517          	auipc	a0,0x1
     ade:	e5650513          	addi	a0,a0,-426 # 1930 <malloc+0x1f0>
     ae2:	00000097          	auipc	ra,0x0
     ae6:	8b6080e7          	jalr	-1866(ra) # 398 <panic>
    ret = parseredirs(ret, ps, es);
     aea:	8652                	mv	a2,s4
     aec:	85ce                	mv	a1,s3
     aee:	8556                	mv	a0,s5
     af0:	00000097          	auipc	ra,0x0
     af4:	e66080e7          	jalr	-410(ra) # 956 <parseredirs>
     af8:	8aaa                	mv	s5,a0
  while(!peek(ps, es, "|)&;")){
     afa:	865a                	mv	a2,s6
     afc:	85d2                	mv	a1,s4
     afe:	854e                	mv	a0,s3
     b00:	00000097          	auipc	ra,0x0
     b04:	dec080e7          	jalr	-532(ra) # 8ec <peek>
     b08:	e121                	bnez	a0,b48 <parseexec+0xf6>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     b0a:	f9040693          	addi	a3,s0,-112
     b0e:	f9840613          	addi	a2,s0,-104
     b12:	85d2                	mv	a1,s4
     b14:	854e                	mv	a0,s3
     b16:	00000097          	auipc	ra,0x0
     b1a:	c92080e7          	jalr	-878(ra) # 7a8 <gettoken>
     b1e:	c50d                	beqz	a0,b48 <parseexec+0xf6>
    if(tok != 'a')
     b20:	fb951de3          	bne	a0,s9,ada <parseexec+0x88>
    cmd->argv[argc] = q;
     b24:	f9843783          	ld	a5,-104(s0)
     b28:	e09c                	sd	a5,0(s1)
    cmd->eargv[argc] = eq;
     b2a:	f9043783          	ld	a5,-112(s0)
     b2e:	e8bc                	sd	a5,80(s1)
    argc++;
     b30:	2905                	addiw	s2,s2,1
    if(argc >= MAXARGS)
     b32:	04a1                	addi	s1,s1,8
     b34:	fb791be3          	bne	s2,s7,aea <parseexec+0x98>
      panic("too many args");
     b38:	00001517          	auipc	a0,0x1
     b3c:	e0050513          	addi	a0,a0,-512 # 1938 <malloc+0x1f8>
     b40:	00000097          	auipc	ra,0x0
     b44:	858080e7          	jalr	-1960(ra) # 398 <panic>
  cmd->argv[argc] = 0;
     b48:	090e                	slli	s2,s2,0x3
     b4a:	9962                	add	s2,s2,s8
     b4c:	00093423          	sd	zero,8(s2)
  cmd->eargv[argc] = 0;
     b50:	04093c23          	sd	zero,88(s2)
  return ret;
     b54:	b7ad                	j	abe <parseexec+0x6c>

0000000000000b56 <parsepipe>:
{
     b56:	7179                	addi	sp,sp,-48
     b58:	f406                	sd	ra,40(sp)
     b5a:	f022                	sd	s0,32(sp)
     b5c:	ec26                	sd	s1,24(sp)
     b5e:	e84a                	sd	s2,16(sp)
     b60:	e44e                	sd	s3,8(sp)
     b62:	1800                	addi	s0,sp,48
     b64:	892a                	mv	s2,a0
     b66:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     b68:	00000097          	auipc	ra,0x0
     b6c:	eea080e7          	jalr	-278(ra) # a52 <parseexec>
     b70:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     b72:	00001617          	auipc	a2,0x1
     b76:	dde60613          	addi	a2,a2,-546 # 1950 <malloc+0x210>
     b7a:	85ce                	mv	a1,s3
     b7c:	854a                	mv	a0,s2
     b7e:	00000097          	auipc	ra,0x0
     b82:	d6e080e7          	jalr	-658(ra) # 8ec <peek>
     b86:	e909                	bnez	a0,b98 <parsepipe+0x42>
}
     b88:	8526                	mv	a0,s1
     b8a:	70a2                	ld	ra,40(sp)
     b8c:	7402                	ld	s0,32(sp)
     b8e:	64e2                	ld	s1,24(sp)
     b90:	6942                	ld	s2,16(sp)
     b92:	69a2                	ld	s3,8(sp)
     b94:	6145                	addi	sp,sp,48
     b96:	8082                	ret
    gettoken(ps, es, 0, 0);
     b98:	4681                	li	a3,0
     b9a:	4601                	li	a2,0
     b9c:	85ce                	mv	a1,s3
     b9e:	854a                	mv	a0,s2
     ba0:	00000097          	auipc	ra,0x0
     ba4:	c08080e7          	jalr	-1016(ra) # 7a8 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     ba8:	85ce                	mv	a1,s3
     baa:	854a                	mv	a0,s2
     bac:	00000097          	auipc	ra,0x0
     bb0:	faa080e7          	jalr	-86(ra) # b56 <parsepipe>
     bb4:	85aa                	mv	a1,a0
     bb6:	8526                	mv	a0,s1
     bb8:	00000097          	auipc	ra,0x0
     bbc:	b28080e7          	jalr	-1240(ra) # 6e0 <pipecmd>
     bc0:	84aa                	mv	s1,a0
  return cmd;
     bc2:	b7d9                	j	b88 <parsepipe+0x32>

0000000000000bc4 <parseline>:
{
     bc4:	7179                	addi	sp,sp,-48
     bc6:	f406                	sd	ra,40(sp)
     bc8:	f022                	sd	s0,32(sp)
     bca:	ec26                	sd	s1,24(sp)
     bcc:	e84a                	sd	s2,16(sp)
     bce:	e44e                	sd	s3,8(sp)
     bd0:	e052                	sd	s4,0(sp)
     bd2:	1800                	addi	s0,sp,48
     bd4:	84aa                	mv	s1,a0
     bd6:	892e                	mv	s2,a1
  cmd = parsepipe(ps, es);
     bd8:	00000097          	auipc	ra,0x0
     bdc:	f7e080e7          	jalr	-130(ra) # b56 <parsepipe>
     be0:	89aa                	mv	s3,a0
  while(peek(ps, es, "&")){
     be2:	00001a17          	auipc	s4,0x1
     be6:	d76a0a13          	addi	s4,s4,-650 # 1958 <malloc+0x218>
     bea:	8652                	mv	a2,s4
     bec:	85ca                	mv	a1,s2
     bee:	8526                	mv	a0,s1
     bf0:	00000097          	auipc	ra,0x0
     bf4:	cfc080e7          	jalr	-772(ra) # 8ec <peek>
     bf8:	c105                	beqz	a0,c18 <parseline+0x54>
    gettoken(ps, es, 0, 0);
     bfa:	4681                	li	a3,0
     bfc:	4601                	li	a2,0
     bfe:	85ca                	mv	a1,s2
     c00:	8526                	mv	a0,s1
     c02:	00000097          	auipc	ra,0x0
     c06:	ba6080e7          	jalr	-1114(ra) # 7a8 <gettoken>
    cmd = backcmd(cmd);
     c0a:	854e                	mv	a0,s3
     c0c:	00000097          	auipc	ra,0x0
     c10:	b60080e7          	jalr	-1184(ra) # 76c <backcmd>
     c14:	89aa                	mv	s3,a0
     c16:	bfd1                	j	bea <parseline+0x26>
  if(peek(ps, es, ";")){
     c18:	00001617          	auipc	a2,0x1
     c1c:	d4860613          	addi	a2,a2,-696 # 1960 <malloc+0x220>
     c20:	85ca                	mv	a1,s2
     c22:	8526                	mv	a0,s1
     c24:	00000097          	auipc	ra,0x0
     c28:	cc8080e7          	jalr	-824(ra) # 8ec <peek>
     c2c:	e911                	bnez	a0,c40 <parseline+0x7c>
}
     c2e:	854e                	mv	a0,s3
     c30:	70a2                	ld	ra,40(sp)
     c32:	7402                	ld	s0,32(sp)
     c34:	64e2                	ld	s1,24(sp)
     c36:	6942                	ld	s2,16(sp)
     c38:	69a2                	ld	s3,8(sp)
     c3a:	6a02                	ld	s4,0(sp)
     c3c:	6145                	addi	sp,sp,48
     c3e:	8082                	ret
    gettoken(ps, es, 0, 0);
     c40:	4681                	li	a3,0
     c42:	4601                	li	a2,0
     c44:	85ca                	mv	a1,s2
     c46:	8526                	mv	a0,s1
     c48:	00000097          	auipc	ra,0x0
     c4c:	b60080e7          	jalr	-1184(ra) # 7a8 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     c50:	85ca                	mv	a1,s2
     c52:	8526                	mv	a0,s1
     c54:	00000097          	auipc	ra,0x0
     c58:	f70080e7          	jalr	-144(ra) # bc4 <parseline>
     c5c:	85aa                	mv	a1,a0
     c5e:	854e                	mv	a0,s3
     c60:	00000097          	auipc	ra,0x0
     c64:	ac6080e7          	jalr	-1338(ra) # 726 <listcmd>
     c68:	89aa                	mv	s3,a0
  return cmd;
     c6a:	b7d1                	j	c2e <parseline+0x6a>

0000000000000c6c <parseblock>:
{
     c6c:	7179                	addi	sp,sp,-48
     c6e:	f406                	sd	ra,40(sp)
     c70:	f022                	sd	s0,32(sp)
     c72:	ec26                	sd	s1,24(sp)
     c74:	e84a                	sd	s2,16(sp)
     c76:	e44e                	sd	s3,8(sp)
     c78:	1800                	addi	s0,sp,48
     c7a:	84aa                	mv	s1,a0
     c7c:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     c7e:	00001617          	auipc	a2,0x1
     c82:	caa60613          	addi	a2,a2,-854 # 1928 <malloc+0x1e8>
     c86:	00000097          	auipc	ra,0x0
     c8a:	c66080e7          	jalr	-922(ra) # 8ec <peek>
     c8e:	c12d                	beqz	a0,cf0 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     c90:	4681                	li	a3,0
     c92:	4601                	li	a2,0
     c94:	85ca                	mv	a1,s2
     c96:	8526                	mv	a0,s1
     c98:	00000097          	auipc	ra,0x0
     c9c:	b10080e7          	jalr	-1264(ra) # 7a8 <gettoken>
  cmd = parseline(ps, es);
     ca0:	85ca                	mv	a1,s2
     ca2:	8526                	mv	a0,s1
     ca4:	00000097          	auipc	ra,0x0
     ca8:	f20080e7          	jalr	-224(ra) # bc4 <parseline>
     cac:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     cae:	00001617          	auipc	a2,0x1
     cb2:	cca60613          	addi	a2,a2,-822 # 1978 <malloc+0x238>
     cb6:	85ca                	mv	a1,s2
     cb8:	8526                	mv	a0,s1
     cba:	00000097          	auipc	ra,0x0
     cbe:	c32080e7          	jalr	-974(ra) # 8ec <peek>
     cc2:	cd1d                	beqz	a0,d00 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     cc4:	4681                	li	a3,0
     cc6:	4601                	li	a2,0
     cc8:	85ca                	mv	a1,s2
     cca:	8526                	mv	a0,s1
     ccc:	00000097          	auipc	ra,0x0
     cd0:	adc080e7          	jalr	-1316(ra) # 7a8 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     cd4:	864a                	mv	a2,s2
     cd6:	85a6                	mv	a1,s1
     cd8:	854e                	mv	a0,s3
     cda:	00000097          	auipc	ra,0x0
     cde:	c7c080e7          	jalr	-900(ra) # 956 <parseredirs>
}
     ce2:	70a2                	ld	ra,40(sp)
     ce4:	7402                	ld	s0,32(sp)
     ce6:	64e2                	ld	s1,24(sp)
     ce8:	6942                	ld	s2,16(sp)
     cea:	69a2                	ld	s3,8(sp)
     cec:	6145                	addi	sp,sp,48
     cee:	8082                	ret
    panic("parseblock");
     cf0:	00001517          	auipc	a0,0x1
     cf4:	c7850513          	addi	a0,a0,-904 # 1968 <malloc+0x228>
     cf8:	fffff097          	auipc	ra,0xfffff
     cfc:	6a0080e7          	jalr	1696(ra) # 398 <panic>
    panic("syntax - missing )");
     d00:	00001517          	auipc	a0,0x1
     d04:	c8050513          	addi	a0,a0,-896 # 1980 <malloc+0x240>
     d08:	fffff097          	auipc	ra,0xfffff
     d0c:	690080e7          	jalr	1680(ra) # 398 <panic>

0000000000000d10 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     d10:	1101                	addi	sp,sp,-32
     d12:	ec06                	sd	ra,24(sp)
     d14:	e822                	sd	s0,16(sp)
     d16:	e426                	sd	s1,8(sp)
     d18:	1000                	addi	s0,sp,32
     d1a:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     d1c:	c521                	beqz	a0,d64 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     d1e:	4118                	lw	a4,0(a0)
     d20:	4795                	li	a5,5
     d22:	04e7e163          	bltu	a5,a4,d64 <nulterminate+0x54>
     d26:	00056783          	lwu	a5,0(a0)
     d2a:	078a                	slli	a5,a5,0x2
     d2c:	00001717          	auipc	a4,0x1
     d30:	b1470713          	addi	a4,a4,-1260 # 1840 <malloc+0x100>
     d34:	97ba                	add	a5,a5,a4
     d36:	439c                	lw	a5,0(a5)
     d38:	97ba                	add	a5,a5,a4
     d3a:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     d3c:	651c                	ld	a5,8(a0)
     d3e:	c39d                	beqz	a5,d64 <nulterminate+0x54>
     d40:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     d44:	67b8                	ld	a4,72(a5)
     d46:	00070023          	sb	zero,0(a4)
     d4a:	07a1                	addi	a5,a5,8
    for(i=0; ecmd->argv[i]; i++)
     d4c:	ff87b703          	ld	a4,-8(a5)
     d50:	fb75                	bnez	a4,d44 <nulterminate+0x34>
     d52:	a809                	j	d64 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     d54:	6508                	ld	a0,8(a0)
     d56:	00000097          	auipc	ra,0x0
     d5a:	fba080e7          	jalr	-70(ra) # d10 <nulterminate>
    *rcmd->efile = 0;
     d5e:	6c9c                	ld	a5,24(s1)
     d60:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
     d64:	8526                	mv	a0,s1
     d66:	60e2                	ld	ra,24(sp)
     d68:	6442                	ld	s0,16(sp)
     d6a:	64a2                	ld	s1,8(sp)
     d6c:	6105                	addi	sp,sp,32
     d6e:	8082                	ret
    nulterminate(pcmd->left);
     d70:	6508                	ld	a0,8(a0)
     d72:	00000097          	auipc	ra,0x0
     d76:	f9e080e7          	jalr	-98(ra) # d10 <nulterminate>
    nulterminate(pcmd->right);
     d7a:	6888                	ld	a0,16(s1)
     d7c:	00000097          	auipc	ra,0x0
     d80:	f94080e7          	jalr	-108(ra) # d10 <nulterminate>
    break;
     d84:	b7c5                	j	d64 <nulterminate+0x54>
    nulterminate(lcmd->left);
     d86:	6508                	ld	a0,8(a0)
     d88:	00000097          	auipc	ra,0x0
     d8c:	f88080e7          	jalr	-120(ra) # d10 <nulterminate>
    nulterminate(lcmd->right);
     d90:	6888                	ld	a0,16(s1)
     d92:	00000097          	auipc	ra,0x0
     d96:	f7e080e7          	jalr	-130(ra) # d10 <nulterminate>
    break;
     d9a:	b7e9                	j	d64 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     d9c:	6508                	ld	a0,8(a0)
     d9e:	00000097          	auipc	ra,0x0
     da2:	f72080e7          	jalr	-142(ra) # d10 <nulterminate>
    break;
     da6:	bf7d                	j	d64 <nulterminate+0x54>

0000000000000da8 <parsecmd>:
{
     da8:	7179                	addi	sp,sp,-48
     daa:	f406                	sd	ra,40(sp)
     dac:	f022                	sd	s0,32(sp)
     dae:	ec26                	sd	s1,24(sp)
     db0:	e84a                	sd	s2,16(sp)
     db2:	1800                	addi	s0,sp,48
     db4:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     db8:	84aa                	mv	s1,a0
     dba:	00000097          	auipc	ra,0x0
     dbe:	2d2080e7          	jalr	722(ra) # 108c <strlen>
     dc2:	1502                	slli	a0,a0,0x20
     dc4:	9101                	srli	a0,a0,0x20
     dc6:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     dc8:	85a6                	mv	a1,s1
     dca:	fd840513          	addi	a0,s0,-40
     dce:	00000097          	auipc	ra,0x0
     dd2:	df6080e7          	jalr	-522(ra) # bc4 <parseline>
     dd6:	892a                	mv	s2,a0
  peek(&s, es, "");
     dd8:	00001617          	auipc	a2,0x1
     ddc:	c1860613          	addi	a2,a2,-1000 # 19f0 <malloc+0x2b0>
     de0:	85a6                	mv	a1,s1
     de2:	fd840513          	addi	a0,s0,-40
     de6:	00000097          	auipc	ra,0x0
     dea:	b06080e7          	jalr	-1274(ra) # 8ec <peek>
  if(s != es){
     dee:	fd843603          	ld	a2,-40(s0)
     df2:	00961e63          	bne	a2,s1,e0e <parsecmd+0x66>
  nulterminate(cmd);
     df6:	854a                	mv	a0,s2
     df8:	00000097          	auipc	ra,0x0
     dfc:	f18080e7          	jalr	-232(ra) # d10 <nulterminate>
}
     e00:	854a                	mv	a0,s2
     e02:	70a2                	ld	ra,40(sp)
     e04:	7402                	ld	s0,32(sp)
     e06:	64e2                	ld	s1,24(sp)
     e08:	6942                	ld	s2,16(sp)
     e0a:	6145                	addi	sp,sp,48
     e0c:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     e0e:	00001597          	auipc	a1,0x1
     e12:	b8a58593          	addi	a1,a1,-1142 # 1998 <malloc+0x258>
     e16:	4509                	li	a0,2
     e18:	00001097          	auipc	ra,0x1
     e1c:	83a080e7          	jalr	-1990(ra) # 1652 <fprintf>
    panic("syntax");
     e20:	00001517          	auipc	a0,0x1
     e24:	b1050513          	addi	a0,a0,-1264 # 1930 <malloc+0x1f0>
     e28:	fffff097          	auipc	ra,0xfffff
     e2c:	570080e7          	jalr	1392(ra) # 398 <panic>

0000000000000e30 <main>:
{
     e30:	711d                	addi	sp,sp,-96
     e32:	ec86                	sd	ra,88(sp)
     e34:	e8a2                	sd	s0,80(sp)
     e36:	e4a6                	sd	s1,72(sp)
     e38:	e0ca                	sd	s2,64(sp)
     e3a:	fc4e                	sd	s3,56(sp)
     e3c:	f852                	sd	s4,48(sp)
     e3e:	f456                	sd	s5,40(sp)
     e40:	f05a                	sd	s6,32(sp)
     e42:	ec5e                	sd	s7,24(sp)
     e44:	e862                	sd	s8,16(sp)
     e46:	e466                	sd	s9,8(sp)
     e48:	1080                	addi	s0,sp,96
  while((fd = dev(O_RDWR, 1, 0)) >= 0){
     e4a:	4601                	li	a2,0
     e4c:	4585                	li	a1,1
     e4e:	4509                	li	a0,2
     e50:	00000097          	auipc	ra,0x0
     e54:	522080e7          	jalr	1314(ra) # 1372 <dev>
     e58:	00054963          	bltz	a0,e6a <main+0x3a>
    if(fd >= 3){
     e5c:	4789                	li	a5,2
     e5e:	fea7d6e3          	bge	a5,a0,e4a <main+0x1a>
      close(fd);
     e62:	00000097          	auipc	ra,0x0
     e66:	4a8080e7          	jalr	1192(ra) # 130a <close>
  strcpy(envs[nenv].name, "SHELL");
     e6a:	00001497          	auipc	s1,0x1
     e6e:	bce48493          	addi	s1,s1,-1074 # 1a38 <nenv>
     e72:	4088                	lw	a0,0(s1)
     e74:	051e                	slli	a0,a0,0x7
     e76:	00001917          	auipc	s2,0x1
     e7a:	cba90913          	addi	s2,s2,-838 # 1b30 <envs>
     e7e:	00001597          	auipc	a1,0x1
     e82:	b2a58593          	addi	a1,a1,-1238 # 19a8 <malloc+0x268>
     e86:	954a                	add	a0,a0,s2
     e88:	00000097          	auipc	ra,0x0
     e8c:	186080e7          	jalr	390(ra) # 100e <strcpy>
  strcpy(envs[nenv].value, "/bin");
     e90:	4088                	lw	a0,0(s1)
     e92:	051e                	slli	a0,a0,0x7
     e94:	02050513          	addi	a0,a0,32
     e98:	00001597          	auipc	a1,0x1
     e9c:	b1858593          	addi	a1,a1,-1256 # 19b0 <malloc+0x270>
     ea0:	954a                	add	a0,a0,s2
     ea2:	00000097          	auipc	ra,0x0
     ea6:	16c080e7          	jalr	364(ra) # 100e <strcpy>
  nenv++;
     eaa:	409c                	lw	a5,0(s1)
     eac:	2785                	addiw	a5,a5,1
     eae:	c09c                	sw	a5,0(s1)
  getcwd(mycwd);
     eb0:	00001517          	auipc	a0,0x1
     eb4:	b9850513          	addi	a0,a0,-1128 # 1a48 <mycwd>
     eb8:	00000097          	auipc	ra,0x0
     ebc:	4ca080e7          	jalr	1226(ra) # 1382 <getcwd>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ec0:	00001917          	auipc	s2,0x1
     ec4:	c0890913          	addi	s2,s2,-1016 # 1ac8 <buf.1239>
    replace(buf);
     ec8:	00001997          	auipc	s3,0x1
     ecc:	b8098993          	addi	s3,s3,-1152 # 1a48 <mycwd>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ed0:	06300a13          	li	s4,99
      else if(!strcmp(ecmd->argv[0], "export"))
     ed4:	00001a97          	auipc	s5,0x1
     ed8:	af4a8a93          	addi	s5,s5,-1292 # 19c8 <malloc+0x288>
          fprintf(2, "export failed\n");
     edc:	00001c17          	auipc	s8,0x1
     ee0:	b1cc0c13          	addi	s8,s8,-1252 # 19f8 <malloc+0x2b8>
          fprintf(2, "Usage: export [-p] [NAME=VALUE]\n");
     ee4:	00001b97          	auipc	s7,0x1
     ee8:	aecb8b93          	addi	s7,s7,-1300 # 19d0 <malloc+0x290>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     eec:	02000b13          	li	s6,32
      if(chdir(buf+3) < 0)
     ef0:	00001c97          	auipc	s9,0x1
     ef4:	bdbc8c93          	addi	s9,s9,-1061 # 1acb <buf.1239+0x3>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ef8:	a895                	j	f6c <main+0x13c>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     efa:	0829c783          	lbu	a5,130(s3)
     efe:	09679f63          	bne	a5,s6,f9c <main+0x16c>
      buf[strlen(buf)-1] = 0;  // chop \n
     f02:	854a                	mv	a0,s2
     f04:	00000097          	auipc	ra,0x0
     f08:	188080e7          	jalr	392(ra) # 108c <strlen>
     f0c:	fff5079b          	addiw	a5,a0,-1
     f10:	1782                	slli	a5,a5,0x20
     f12:	9381                	srli	a5,a5,0x20
     f14:	97ce                	add	a5,a5,s3
     f16:	08078023          	sb	zero,128(a5)
      if(chdir(buf+3) < 0)
     f1a:	8566                	mv	a0,s9
     f1c:	00000097          	auipc	ra,0x0
     f20:	41e080e7          	jalr	1054(ra) # 133a <chdir>
     f24:	00054863          	bltz	a0,f34 <main+0x104>
      getcwd(mycwd);
     f28:	854e                	mv	a0,s3
     f2a:	00000097          	auipc	ra,0x0
     f2e:	458080e7          	jalr	1112(ra) # 1382 <getcwd>
     f32:	a82d                	j	f6c <main+0x13c>
        fprintf(2, "cannot cd %s\n", buf+3);
     f34:	8666                	mv	a2,s9
     f36:	00001597          	auipc	a1,0x1
     f3a:	a8258593          	addi	a1,a1,-1406 # 19b8 <malloc+0x278>
     f3e:	4509                	li	a0,2
     f40:	00000097          	auipc	ra,0x0
     f44:	712080e7          	jalr	1810(ra) # 1652 <fprintf>
     f48:	b7c5                	j	f28 <main+0xf8>
        free(cmd);
     f4a:	8526                	mv	a0,s1
     f4c:	00000097          	auipc	ra,0x0
     f50:	76a080e7          	jalr	1898(ra) # 16b6 <free>
        continue;
     f54:	a821                	j	f6c <main+0x13c>
          fprintf(2, "Usage: export [-p] [NAME=VALUE]\n");
     f56:	85de                	mv	a1,s7
     f58:	4509                	li	a0,2
     f5a:	00000097          	auipc	ra,0x0
     f5e:	6f8080e7          	jalr	1784(ra) # 1652 <fprintf>
        free(cmd);
     f62:	8526                	mv	a0,s1
     f64:	00000097          	auipc	ra,0x0
     f68:	752080e7          	jalr	1874(ra) # 16b6 <free>
  while(getcmd(buf, sizeof(buf)) >= 0){
     f6c:	06400593          	li	a1,100
     f70:	854a                	mv	a0,s2
     f72:	fffff097          	auipc	ra,0xfffff
     f76:	3ca080e7          	jalr	970(ra) # 33c <getcmd>
     f7a:	08054563          	bltz	a0,1004 <main+0x1d4>
    replace(buf);
     f7e:	854a                	mv	a0,s2
     f80:	fffff097          	auipc	ra,0xfffff
     f84:	27e080e7          	jalr	638(ra) # 1fe <replace>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     f88:	0809c783          	lbu	a5,128(s3)
     f8c:	01479863          	bne	a5,s4,f9c <main+0x16c>
     f90:	0819c703          	lbu	a4,129(s3)
     f94:	06400793          	li	a5,100
     f98:	f6f701e3          	beq	a4,a5,efa <main+0xca>
      struct cmd *cmd = parsecmd(buf);
     f9c:	854a                	mv	a0,s2
     f9e:	00000097          	auipc	ra,0x0
     fa2:	e0a080e7          	jalr	-502(ra) # da8 <parsecmd>
     fa6:	84aa                	mv	s1,a0
      if(ecmd->argv[0] == 0) {
     fa8:	6508                	ld	a0,8(a0)
     faa:	d145                	beqz	a0,f4a <main+0x11a>
      else if(!strcmp(ecmd->argv[0], "export"))
     fac:	85d6                	mv	a1,s5
     fae:	00000097          	auipc	ra,0x0
     fb2:	0aa080e7          	jalr	170(ra) # 1058 <strcmp>
     fb6:	e115                	bnez	a0,fda <main+0x1aa>
        if(ecmd->argv[1] == NULL)
     fb8:	689c                	ld	a5,16(s1)
     fba:	dfd1                	beqz	a5,f56 <main+0x126>
        else if(export(ecmd->argv) < 0)
     fbc:	00848513          	addi	a0,s1,8
     fc0:	fffff097          	auipc	ra,0xfffff
     fc4:	0a4080e7          	jalr	164(ra) # 64 <export>
     fc8:	f8055de3          	bgez	a0,f62 <main+0x132>
          fprintf(2, "export failed\n");
     fcc:	85e2                	mv	a1,s8
     fce:	4509                	li	a0,2
     fd0:	00000097          	auipc	ra,0x0
     fd4:	682080e7          	jalr	1666(ra) # 1652 <fprintf>
     fd8:	b769                	j	f62 <main+0x132>
      else if(fork1() == 0) 
     fda:	fffff097          	auipc	ra,0xfffff
     fde:	3e4080e7          	jalr	996(ra) # 3be <fork1>
     fe2:	cd01                	beqz	a0,ffa <main+0x1ca>
      wait(0);
     fe4:	4501                	li	a0,0
     fe6:	00000097          	auipc	ra,0x0
     fea:	304080e7          	jalr	772(ra) # 12ea <wait>
      free(cmd);
     fee:	8526                	mv	a0,s1
     ff0:	00000097          	auipc	ra,0x0
     ff4:	6c6080e7          	jalr	1734(ra) # 16b6 <free>
     ff8:	bf95                	j	f6c <main+0x13c>
        runcmd(cmd);
     ffa:	8526                	mv	a0,s1
     ffc:	fffff097          	auipc	ra,0xfffff
    1000:	3f0080e7          	jalr	1008(ra) # 3ec <runcmd>
  exit(0);
    1004:	4501                	li	a0,0
    1006:	00000097          	auipc	ra,0x0
    100a:	2dc080e7          	jalr	732(ra) # 12e2 <exit>

000000000000100e <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
    100e:	1141                	addi	sp,sp,-16
    1010:	e422                	sd	s0,8(sp)
    1012:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1014:	87aa                	mv	a5,a0
    1016:	0585                	addi	a1,a1,1
    1018:	0785                	addi	a5,a5,1
    101a:	fff5c703          	lbu	a4,-1(a1)
    101e:	fee78fa3          	sb	a4,-1(a5)
    1022:	fb75                	bnez	a4,1016 <strcpy+0x8>
    ;
  return os;
}
    1024:	6422                	ld	s0,8(sp)
    1026:	0141                	addi	sp,sp,16
    1028:	8082                	ret

000000000000102a <strcat>:

char*
strcat(char *s, const char *t)
{
    102a:	1141                	addi	sp,sp,-16
    102c:	e422                	sd	s0,8(sp)
    102e:	0800                	addi	s0,sp,16
  char *os = s;
  while(*s)
    1030:	00054783          	lbu	a5,0(a0)
    1034:	c385                	beqz	a5,1054 <strcat+0x2a>
    1036:	87aa                	mv	a5,a0
    s++;
    1038:	0785                	addi	a5,a5,1
  while(*s)
    103a:	0007c703          	lbu	a4,0(a5)
    103e:	ff6d                	bnez	a4,1038 <strcat+0xe>
  while((*s++ = *t++))
    1040:	0585                	addi	a1,a1,1
    1042:	0785                	addi	a5,a5,1
    1044:	fff5c703          	lbu	a4,-1(a1)
    1048:	fee78fa3          	sb	a4,-1(a5)
    104c:	fb75                	bnez	a4,1040 <strcat+0x16>
    ;
  return os;
}
    104e:	6422                	ld	s0,8(sp)
    1050:	0141                	addi	sp,sp,16
    1052:	8082                	ret
  while(*s)
    1054:	87aa                	mv	a5,a0
    1056:	b7ed                	j	1040 <strcat+0x16>

0000000000001058 <strcmp>:


int
strcmp(const char *p, const char *q)
{
    1058:	1141                	addi	sp,sp,-16
    105a:	e422                	sd	s0,8(sp)
    105c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    105e:	00054783          	lbu	a5,0(a0)
    1062:	cf91                	beqz	a5,107e <strcmp+0x26>
    1064:	0005c703          	lbu	a4,0(a1)
    1068:	00f71b63          	bne	a4,a5,107e <strcmp+0x26>
    p++, q++;
    106c:	0505                	addi	a0,a0,1
    106e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    1070:	00054783          	lbu	a5,0(a0)
    1074:	c789                	beqz	a5,107e <strcmp+0x26>
    1076:	0005c703          	lbu	a4,0(a1)
    107a:	fef709e3          	beq	a4,a5,106c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
    107e:	0005c503          	lbu	a0,0(a1)
}
    1082:	40a7853b          	subw	a0,a5,a0
    1086:	6422                	ld	s0,8(sp)
    1088:	0141                	addi	sp,sp,16
    108a:	8082                	ret

000000000000108c <strlen>:

uint
strlen(const char *s)
{
    108c:	1141                	addi	sp,sp,-16
    108e:	e422                	sd	s0,8(sp)
    1090:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    1092:	00054783          	lbu	a5,0(a0)
    1096:	cf91                	beqz	a5,10b2 <strlen+0x26>
    1098:	0505                	addi	a0,a0,1
    109a:	87aa                	mv	a5,a0
    109c:	4685                	li	a3,1
    109e:	9e89                	subw	a3,a3,a0
    ;
    10a0:	00f6853b          	addw	a0,a3,a5
    10a4:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
    10a6:	fff7c703          	lbu	a4,-1(a5)
    10aa:	fb7d                	bnez	a4,10a0 <strlen+0x14>
  return n;
}
    10ac:	6422                	ld	s0,8(sp)
    10ae:	0141                	addi	sp,sp,16
    10b0:	8082                	ret
  for(n = 0; s[n]; n++)
    10b2:	4501                	li	a0,0
    10b4:	bfe5                	j	10ac <strlen+0x20>

00000000000010b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10b6:	1141                	addi	sp,sp,-16
    10b8:	e422                	sd	s0,8(sp)
    10ba:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    10bc:	ce09                	beqz	a2,10d6 <memset+0x20>
    10be:	87aa                	mv	a5,a0
    10c0:	fff6071b          	addiw	a4,a2,-1
    10c4:	1702                	slli	a4,a4,0x20
    10c6:	9301                	srli	a4,a4,0x20
    10c8:	0705                	addi	a4,a4,1
    10ca:	972a                	add	a4,a4,a0
    cdst[i] = c;
    10cc:	00b78023          	sb	a1,0(a5)
    10d0:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
    10d2:	fee79de3          	bne	a5,a4,10cc <memset+0x16>
  }
  return dst;
}
    10d6:	6422                	ld	s0,8(sp)
    10d8:	0141                	addi	sp,sp,16
    10da:	8082                	ret

00000000000010dc <strchr>:

char*
strchr(const char *s, char c)
{
    10dc:	1141                	addi	sp,sp,-16
    10de:	e422                	sd	s0,8(sp)
    10e0:	0800                	addi	s0,sp,16
  for(; *s; s++)
    10e2:	00054783          	lbu	a5,0(a0)
    10e6:	cf91                	beqz	a5,1102 <strchr+0x26>
    if(*s == c)
    10e8:	00f58a63          	beq	a1,a5,10fc <strchr+0x20>
  for(; *s; s++)
    10ec:	0505                	addi	a0,a0,1
    10ee:	00054783          	lbu	a5,0(a0)
    10f2:	c781                	beqz	a5,10fa <strchr+0x1e>
    if(*s == c)
    10f4:	feb79ce3          	bne	a5,a1,10ec <strchr+0x10>
    10f8:	a011                	j	10fc <strchr+0x20>
      return (char*)s;
  return 0;
    10fa:	4501                	li	a0,0
}
    10fc:	6422                	ld	s0,8(sp)
    10fe:	0141                	addi	sp,sp,16
    1100:	8082                	ret
  return 0;
    1102:	4501                	li	a0,0
    1104:	bfe5                	j	10fc <strchr+0x20>

0000000000001106 <gets>:

char*
gets(char *buf, int max)
{
    1106:	711d                	addi	sp,sp,-96
    1108:	ec86                	sd	ra,88(sp)
    110a:	e8a2                	sd	s0,80(sp)
    110c:	e4a6                	sd	s1,72(sp)
    110e:	e0ca                	sd	s2,64(sp)
    1110:	fc4e                	sd	s3,56(sp)
    1112:	f852                	sd	s4,48(sp)
    1114:	f456                	sd	s5,40(sp)
    1116:	f05a                	sd	s6,32(sp)
    1118:	ec5e                	sd	s7,24(sp)
    111a:	1080                	addi	s0,sp,96
    111c:	8baa                	mv	s7,a0
    111e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1120:	892a                	mv	s2,a0
    1122:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1124:	4aa9                	li	s5,10
    1126:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    1128:	0019849b          	addiw	s1,s3,1
    112c:	0344d863          	bge	s1,s4,115c <gets+0x56>
    cc = read(0, &c, 1);
    1130:	4605                	li	a2,1
    1132:	faf40593          	addi	a1,s0,-81
    1136:	4501                	li	a0,0
    1138:	00000097          	auipc	ra,0x0
    113c:	1c2080e7          	jalr	450(ra) # 12fa <read>
    if(cc < 1)
    1140:	00a05e63          	blez	a0,115c <gets+0x56>
    buf[i++] = c;
    1144:	faf44783          	lbu	a5,-81(s0)
    1148:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    114c:	01578763          	beq	a5,s5,115a <gets+0x54>
    1150:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
    1152:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
    1154:	fd679ae3          	bne	a5,s6,1128 <gets+0x22>
    1158:	a011                	j	115c <gets+0x56>
  for(i=0; i+1 < max; ){
    115a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    115c:	99de                	add	s3,s3,s7
    115e:	00098023          	sb	zero,0(s3)
  return buf;
}
    1162:	855e                	mv	a0,s7
    1164:	60e6                	ld	ra,88(sp)
    1166:	6446                	ld	s0,80(sp)
    1168:	64a6                	ld	s1,72(sp)
    116a:	6906                	ld	s2,64(sp)
    116c:	79e2                	ld	s3,56(sp)
    116e:	7a42                	ld	s4,48(sp)
    1170:	7aa2                	ld	s5,40(sp)
    1172:	7b02                	ld	s6,32(sp)
    1174:	6be2                	ld	s7,24(sp)
    1176:	6125                	addi	sp,sp,96
    1178:	8082                	ret

000000000000117a <stat>:

int
stat(const char *n, struct stat *st)
{
    117a:	1101                	addi	sp,sp,-32
    117c:	ec06                	sd	ra,24(sp)
    117e:	e822                	sd	s0,16(sp)
    1180:	e426                	sd	s1,8(sp)
    1182:	e04a                	sd	s2,0(sp)
    1184:	1000                	addi	s0,sp,32
    1186:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1188:	4581                	li	a1,0
    118a:	00000097          	auipc	ra,0x0
    118e:	198080e7          	jalr	408(ra) # 1322 <open>
  if(fd < 0)
    1192:	02054563          	bltz	a0,11bc <stat+0x42>
    1196:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    1198:	85ca                	mv	a1,s2
    119a:	00000097          	auipc	ra,0x0
    119e:	190080e7          	jalr	400(ra) # 132a <fstat>
    11a2:	892a                	mv	s2,a0
  close(fd);
    11a4:	8526                	mv	a0,s1
    11a6:	00000097          	auipc	ra,0x0
    11aa:	164080e7          	jalr	356(ra) # 130a <close>
  return r;
}
    11ae:	854a                	mv	a0,s2
    11b0:	60e2                	ld	ra,24(sp)
    11b2:	6442                	ld	s0,16(sp)
    11b4:	64a2                	ld	s1,8(sp)
    11b6:	6902                	ld	s2,0(sp)
    11b8:	6105                	addi	sp,sp,32
    11ba:	8082                	ret
    return -1;
    11bc:	597d                	li	s2,-1
    11be:	bfc5                	j	11ae <stat+0x34>

00000000000011c0 <atoi>:

int
atoi(const char *s)
{
    11c0:	1141                	addi	sp,sp,-16
    11c2:	e422                	sd	s0,8(sp)
    11c4:	0800                	addi	s0,sp,16
  int n;
  int neg = 1;
  if (*s == '-') {
    11c6:	00054703          	lbu	a4,0(a0)
    11ca:	02d00793          	li	a5,45
  int neg = 1;
    11ce:	4805                	li	a6,1
  if (*s == '-') {
    11d0:	04f70363          	beq	a4,a5,1216 <atoi+0x56>
    s++;
    neg = -1;
  }
  n = 0;
  while('0' <= *s && *s <= '9')
    11d4:	00054683          	lbu	a3,0(a0)
    11d8:	fd06879b          	addiw	a5,a3,-48
    11dc:	0ff7f793          	andi	a5,a5,255
    11e0:	4725                	li	a4,9
    11e2:	02f76d63          	bltu	a4,a5,121c <atoi+0x5c>
  n = 0;
    11e6:	4601                	li	a2,0
  while('0' <= *s && *s <= '9')
    11e8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    11ea:	0505                	addi	a0,a0,1
    11ec:	0026179b          	slliw	a5,a2,0x2
    11f0:	9fb1                	addw	a5,a5,a2
    11f2:	0017979b          	slliw	a5,a5,0x1
    11f6:	9fb5                	addw	a5,a5,a3
    11f8:	fd07861b          	addiw	a2,a5,-48
  while('0' <= *s && *s <= '9')
    11fc:	00054683          	lbu	a3,0(a0)
    1200:	fd06871b          	addiw	a4,a3,-48
    1204:	0ff77713          	andi	a4,a4,255
    1208:	fee5f1e3          	bgeu	a1,a4,11ea <atoi+0x2a>
  return n * neg;
}
    120c:	02c8053b          	mulw	a0,a6,a2
    1210:	6422                	ld	s0,8(sp)
    1212:	0141                	addi	sp,sp,16
    1214:	8082                	ret
    s++;
    1216:	0505                	addi	a0,a0,1
    neg = -1;
    1218:	587d                	li	a6,-1
    121a:	bf6d                	j	11d4 <atoi+0x14>
  n = 0;
    121c:	4601                	li	a2,0
    121e:	b7fd                	j	120c <atoi+0x4c>

0000000000001220 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1220:	1141                	addi	sp,sp,-16
    1222:	e422                	sd	s0,8(sp)
    1224:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    1226:	02b57663          	bgeu	a0,a1,1252 <memmove+0x32>
    while(n-- > 0)
    122a:	02c05163          	blez	a2,124c <memmove+0x2c>
    122e:	fff6079b          	addiw	a5,a2,-1
    1232:	1782                	slli	a5,a5,0x20
    1234:	9381                	srli	a5,a5,0x20
    1236:	0785                	addi	a5,a5,1
    1238:	97aa                	add	a5,a5,a0
  dst = vdst;
    123a:	872a                	mv	a4,a0
      *dst++ = *src++;
    123c:	0585                	addi	a1,a1,1
    123e:	0705                	addi	a4,a4,1
    1240:	fff5c683          	lbu	a3,-1(a1)
    1244:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    1248:	fee79ae3          	bne	a5,a4,123c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    124c:	6422                	ld	s0,8(sp)
    124e:	0141                	addi	sp,sp,16
    1250:	8082                	ret
    dst += n;
    1252:	00c50733          	add	a4,a0,a2
    src += n;
    1256:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    1258:	fec05ae3          	blez	a2,124c <memmove+0x2c>
    125c:	fff6079b          	addiw	a5,a2,-1
    1260:	1782                	slli	a5,a5,0x20
    1262:	9381                	srli	a5,a5,0x20
    1264:	fff7c793          	not	a5,a5
    1268:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    126a:	15fd                	addi	a1,a1,-1
    126c:	177d                	addi	a4,a4,-1
    126e:	0005c683          	lbu	a3,0(a1)
    1272:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    1276:	fef71ae3          	bne	a4,a5,126a <memmove+0x4a>
    127a:	bfc9                	j	124c <memmove+0x2c>

000000000000127c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    127c:	1141                	addi	sp,sp,-16
    127e:	e422                	sd	s0,8(sp)
    1280:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    1282:	ce15                	beqz	a2,12be <memcmp+0x42>
    1284:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
    1288:	00054783          	lbu	a5,0(a0)
    128c:	0005c703          	lbu	a4,0(a1)
    1290:	02e79063          	bne	a5,a4,12b0 <memcmp+0x34>
    1294:	1682                	slli	a3,a3,0x20
    1296:	9281                	srli	a3,a3,0x20
    1298:	0685                	addi	a3,a3,1
    129a:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
    129c:	0505                	addi	a0,a0,1
    p2++;
    129e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    12a0:	00d50d63          	beq	a0,a3,12ba <memcmp+0x3e>
    if (*p1 != *p2) {
    12a4:	00054783          	lbu	a5,0(a0)
    12a8:	0005c703          	lbu	a4,0(a1)
    12ac:	fee788e3          	beq	a5,a4,129c <memcmp+0x20>
      return *p1 - *p2;
    12b0:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
    12b4:	6422                	ld	s0,8(sp)
    12b6:	0141                	addi	sp,sp,16
    12b8:	8082                	ret
  return 0;
    12ba:	4501                	li	a0,0
    12bc:	bfe5                	j	12b4 <memcmp+0x38>
    12be:	4501                	li	a0,0
    12c0:	bfd5                	j	12b4 <memcmp+0x38>

00000000000012c2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    12c2:	1141                	addi	sp,sp,-16
    12c4:	e406                	sd	ra,8(sp)
    12c6:	e022                	sd	s0,0(sp)
    12c8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    12ca:	00000097          	auipc	ra,0x0
    12ce:	f56080e7          	jalr	-170(ra) # 1220 <memmove>
}
    12d2:	60a2                	ld	ra,8(sp)
    12d4:	6402                	ld	s0,0(sp)
    12d6:	0141                	addi	sp,sp,16
    12d8:	8082                	ret

00000000000012da <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/sysnum.h"
.global fork
fork:
 li a7, SYS_fork
    12da:	4885                	li	a7,1
 ecall
    12dc:	00000073          	ecall
 ret
    12e0:	8082                	ret

00000000000012e2 <exit>:
.global exit
exit:
 li a7, SYS_exit
    12e2:	4889                	li	a7,2
 ecall
    12e4:	00000073          	ecall
 ret
    12e8:	8082                	ret

00000000000012ea <wait>:
.global wait
wait:
 li a7, SYS_wait
    12ea:	488d                	li	a7,3
 ecall
    12ec:	00000073          	ecall
 ret
    12f0:	8082                	ret

00000000000012f2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    12f2:	4891                	li	a7,4
 ecall
    12f4:	00000073          	ecall
 ret
    12f8:	8082                	ret

00000000000012fa <read>:
.global read
read:
 li a7, SYS_read
    12fa:	4895                	li	a7,5
 ecall
    12fc:	00000073          	ecall
 ret
    1300:	8082                	ret

0000000000001302 <write>:
.global write
write:
 li a7, SYS_write
    1302:	48c1                	li	a7,16
 ecall
    1304:	00000073          	ecall
 ret
    1308:	8082                	ret

000000000000130a <close>:
.global close
close:
 li a7, SYS_close
    130a:	48d5                	li	a7,21
 ecall
    130c:	00000073          	ecall
 ret
    1310:	8082                	ret

0000000000001312 <kill>:
.global kill
kill:
 li a7, SYS_kill
    1312:	4899                	li	a7,6
 ecall
    1314:	00000073          	ecall
 ret
    1318:	8082                	ret

000000000000131a <exec>:
.global exec
exec:
 li a7, SYS_exec
    131a:	489d                	li	a7,7
 ecall
    131c:	00000073          	ecall
 ret
    1320:	8082                	ret

0000000000001322 <open>:
.global open
open:
 li a7, SYS_open
    1322:	48bd                	li	a7,15
 ecall
    1324:	00000073          	ecall
 ret
    1328:	8082                	ret

000000000000132a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    132a:	48a1                	li	a7,8
 ecall
    132c:	00000073          	ecall
 ret
    1330:	8082                	ret

0000000000001332 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1332:	48d1                	li	a7,20
 ecall
    1334:	00000073          	ecall
 ret
    1338:	8082                	ret

000000000000133a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    133a:	48a5                	li	a7,9
 ecall
    133c:	00000073          	ecall
 ret
    1340:	8082                	ret

0000000000001342 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1342:	48a9                	li	a7,10
 ecall
    1344:	00000073          	ecall
 ret
    1348:	8082                	ret

000000000000134a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    134a:	48ad                	li	a7,11
 ecall
    134c:	00000073          	ecall
 ret
    1350:	8082                	ret

0000000000001352 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1352:	48b1                	li	a7,12
 ecall
    1354:	00000073          	ecall
 ret
    1358:	8082                	ret

000000000000135a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    135a:	48b5                	li	a7,13
 ecall
    135c:	00000073          	ecall
 ret
    1360:	8082                	ret

0000000000001362 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1362:	48b9                	li	a7,14
 ecall
    1364:	00000073          	ecall
 ret
    1368:	8082                	ret

000000000000136a <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
    136a:	48d9                	li	a7,22
 ecall
    136c:	00000073          	ecall
 ret
    1370:	8082                	ret

0000000000001372 <dev>:
.global dev
dev:
 li a7, SYS_dev
    1372:	48dd                	li	a7,23
 ecall
    1374:	00000073          	ecall
 ret
    1378:	8082                	ret

000000000000137a <readdir>:
.global readdir
readdir:
 li a7, SYS_readdir
    137a:	48e1                	li	a7,24
 ecall
    137c:	00000073          	ecall
 ret
    1380:	8082                	ret

0000000000001382 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
    1382:	48e5                	li	a7,25
 ecall
    1384:	00000073          	ecall
 ret
    1388:	8082                	ret

000000000000138a <remove>:
.global remove
remove:
 li a7, SYS_remove
    138a:	48c5                	li	a7,17
 ecall
    138c:	00000073          	ecall
 ret
    1390:	8082                	ret

0000000000001392 <trace>:
.global trace
trace:
 li a7, SYS_trace
    1392:	48c9                	li	a7,18
 ecall
    1394:	00000073          	ecall
 ret
    1398:	8082                	ret

000000000000139a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
    139a:	48cd                	li	a7,19
 ecall
    139c:	00000073          	ecall
 ret
    13a0:	8082                	ret

00000000000013a2 <rename>:
.global rename
rename:
 li a7, SYS_rename
    13a2:	48e9                	li	a7,26
 ecall
    13a4:	00000073          	ecall
 ret
    13a8:	8082                	ret

00000000000013aa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    13aa:	1101                	addi	sp,sp,-32
    13ac:	ec06                	sd	ra,24(sp)
    13ae:	e822                	sd	s0,16(sp)
    13b0:	1000                	addi	s0,sp,32
    13b2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    13b6:	4605                	li	a2,1
    13b8:	fef40593          	addi	a1,s0,-17
    13bc:	00000097          	auipc	ra,0x0
    13c0:	f46080e7          	jalr	-186(ra) # 1302 <write>
}
    13c4:	60e2                	ld	ra,24(sp)
    13c6:	6442                	ld	s0,16(sp)
    13c8:	6105                	addi	sp,sp,32
    13ca:	8082                	ret

00000000000013cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13cc:	7139                	addi	sp,sp,-64
    13ce:	fc06                	sd	ra,56(sp)
    13d0:	f822                	sd	s0,48(sp)
    13d2:	f426                	sd	s1,40(sp)
    13d4:	f04a                	sd	s2,32(sp)
    13d6:	ec4e                	sd	s3,24(sp)
    13d8:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13da:	c299                	beqz	a3,13e0 <printint+0x14>
    13dc:	0005cd63          	bltz	a1,13f6 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    13e0:	2581                	sext.w	a1,a1
  neg = 0;
    13e2:	4301                	li	t1,0
    13e4:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
    13e8:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
    13ea:	2601                	sext.w	a2,a2
    13ec:	00000897          	auipc	a7,0x0
    13f0:	61c88893          	addi	a7,a7,1564 # 1a08 <digits>
    13f4:	a039                	j	1402 <printint+0x36>
    x = -xx;
    13f6:	40b005bb          	negw	a1,a1
    neg = 1;
    13fa:	4305                	li	t1,1
    x = -xx;
    13fc:	b7e5                	j	13e4 <printint+0x18>
  }while((x /= base) != 0);
    13fe:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
    1400:	8836                	mv	a6,a3
    1402:	0018069b          	addiw	a3,a6,1
    1406:	02c5f7bb          	remuw	a5,a1,a2
    140a:	1782                	slli	a5,a5,0x20
    140c:	9381                	srli	a5,a5,0x20
    140e:	97c6                	add	a5,a5,a7
    1410:	0007c783          	lbu	a5,0(a5)
    1414:	00f70023          	sb	a5,0(a4)
    1418:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
    141a:	02c5d7bb          	divuw	a5,a1,a2
    141e:	fec5f0e3          	bgeu	a1,a2,13fe <printint+0x32>
  if(neg)
    1422:	00030b63          	beqz	t1,1438 <printint+0x6c>
    buf[i++] = '-';
    1426:	fd040793          	addi	a5,s0,-48
    142a:	96be                	add	a3,a3,a5
    142c:	02d00793          	li	a5,45
    1430:	fef68823          	sb	a5,-16(a3)
    1434:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
    1438:	02d05963          	blez	a3,146a <printint+0x9e>
    143c:	89aa                	mv	s3,a0
    143e:	fc040793          	addi	a5,s0,-64
    1442:	00d784b3          	add	s1,a5,a3
    1446:	fff78913          	addi	s2,a5,-1
    144a:	9936                	add	s2,s2,a3
    144c:	36fd                	addiw	a3,a3,-1
    144e:	1682                	slli	a3,a3,0x20
    1450:	9281                	srli	a3,a3,0x20
    1452:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
    1456:	fff4c583          	lbu	a1,-1(s1)
    145a:	854e                	mv	a0,s3
    145c:	00000097          	auipc	ra,0x0
    1460:	f4e080e7          	jalr	-178(ra) # 13aa <putc>
    1464:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
    1466:	ff2498e3          	bne	s1,s2,1456 <printint+0x8a>
}
    146a:	70e2                	ld	ra,56(sp)
    146c:	7442                	ld	s0,48(sp)
    146e:	74a2                	ld	s1,40(sp)
    1470:	7902                	ld	s2,32(sp)
    1472:	69e2                	ld	s3,24(sp)
    1474:	6121                	addi	sp,sp,64
    1476:	8082                	ret

0000000000001478 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1478:	7119                	addi	sp,sp,-128
    147a:	fc86                	sd	ra,120(sp)
    147c:	f8a2                	sd	s0,112(sp)
    147e:	f4a6                	sd	s1,104(sp)
    1480:	f0ca                	sd	s2,96(sp)
    1482:	ecce                	sd	s3,88(sp)
    1484:	e8d2                	sd	s4,80(sp)
    1486:	e4d6                	sd	s5,72(sp)
    1488:	e0da                	sd	s6,64(sp)
    148a:	fc5e                	sd	s7,56(sp)
    148c:	f862                	sd	s8,48(sp)
    148e:	f466                	sd	s9,40(sp)
    1490:	f06a                	sd	s10,32(sp)
    1492:	ec6e                	sd	s11,24(sp)
    1494:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1496:	0005c483          	lbu	s1,0(a1)
    149a:	18048d63          	beqz	s1,1634 <vprintf+0x1bc>
    149e:	8aaa                	mv	s5,a0
    14a0:	8b32                	mv	s6,a2
    14a2:	00158913          	addi	s2,a1,1
  state = 0;
    14a6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    14a8:	02500a13          	li	s4,37
      if(c == 'd'){
    14ac:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    14b0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    14b4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    14b8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    14bc:	00000b97          	auipc	s7,0x0
    14c0:	54cb8b93          	addi	s7,s7,1356 # 1a08 <digits>
    14c4:	a839                	j	14e2 <vprintf+0x6a>
        putc(fd, c);
    14c6:	85a6                	mv	a1,s1
    14c8:	8556                	mv	a0,s5
    14ca:	00000097          	auipc	ra,0x0
    14ce:	ee0080e7          	jalr	-288(ra) # 13aa <putc>
    14d2:	a019                	j	14d8 <vprintf+0x60>
    } else if(state == '%'){
    14d4:	01498f63          	beq	s3,s4,14f2 <vprintf+0x7a>
    14d8:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
    14da:	fff94483          	lbu	s1,-1(s2)
    14de:	14048b63          	beqz	s1,1634 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
    14e2:	0004879b          	sext.w	a5,s1
    if(state == 0){
    14e6:	fe0997e3          	bnez	s3,14d4 <vprintf+0x5c>
      if(c == '%'){
    14ea:	fd479ee3          	bne	a5,s4,14c6 <vprintf+0x4e>
        state = '%';
    14ee:	89be                	mv	s3,a5
    14f0:	b7e5                	j	14d8 <vprintf+0x60>
      if(c == 'd'){
    14f2:	05878063          	beq	a5,s8,1532 <vprintf+0xba>
      } else if(c == 'l') {
    14f6:	05978c63          	beq	a5,s9,154e <vprintf+0xd6>
      } else if(c == 'x') {
    14fa:	07a78863          	beq	a5,s10,156a <vprintf+0xf2>
      } else if(c == 'p') {
    14fe:	09b78463          	beq	a5,s11,1586 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    1502:	07300713          	li	a4,115
    1506:	0ce78563          	beq	a5,a4,15d0 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    150a:	06300713          	li	a4,99
    150e:	0ee78c63          	beq	a5,a4,1606 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    1512:	11478663          	beq	a5,s4,161e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1516:	85d2                	mv	a1,s4
    1518:	8556                	mv	a0,s5
    151a:	00000097          	auipc	ra,0x0
    151e:	e90080e7          	jalr	-368(ra) # 13aa <putc>
        putc(fd, c);
    1522:	85a6                	mv	a1,s1
    1524:	8556                	mv	a0,s5
    1526:	00000097          	auipc	ra,0x0
    152a:	e84080e7          	jalr	-380(ra) # 13aa <putc>
      }
      state = 0;
    152e:	4981                	li	s3,0
    1530:	b765                	j	14d8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    1532:	008b0493          	addi	s1,s6,8
    1536:	4685                	li	a3,1
    1538:	4629                	li	a2,10
    153a:	000b2583          	lw	a1,0(s6)
    153e:	8556                	mv	a0,s5
    1540:	00000097          	auipc	ra,0x0
    1544:	e8c080e7          	jalr	-372(ra) # 13cc <printint>
    1548:	8b26                	mv	s6,s1
      state = 0;
    154a:	4981                	li	s3,0
    154c:	b771                	j	14d8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    154e:	008b0493          	addi	s1,s6,8
    1552:	4681                	li	a3,0
    1554:	4629                	li	a2,10
    1556:	000b2583          	lw	a1,0(s6)
    155a:	8556                	mv	a0,s5
    155c:	00000097          	auipc	ra,0x0
    1560:	e70080e7          	jalr	-400(ra) # 13cc <printint>
    1564:	8b26                	mv	s6,s1
      state = 0;
    1566:	4981                	li	s3,0
    1568:	bf85                	j	14d8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    156a:	008b0493          	addi	s1,s6,8
    156e:	4681                	li	a3,0
    1570:	4641                	li	a2,16
    1572:	000b2583          	lw	a1,0(s6)
    1576:	8556                	mv	a0,s5
    1578:	00000097          	auipc	ra,0x0
    157c:	e54080e7          	jalr	-428(ra) # 13cc <printint>
    1580:	8b26                	mv	s6,s1
      state = 0;
    1582:	4981                	li	s3,0
    1584:	bf91                	j	14d8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    1586:	008b0793          	addi	a5,s6,8
    158a:	f8f43423          	sd	a5,-120(s0)
    158e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    1592:	03000593          	li	a1,48
    1596:	8556                	mv	a0,s5
    1598:	00000097          	auipc	ra,0x0
    159c:	e12080e7          	jalr	-494(ra) # 13aa <putc>
  putc(fd, 'x');
    15a0:	85ea                	mv	a1,s10
    15a2:	8556                	mv	a0,s5
    15a4:	00000097          	auipc	ra,0x0
    15a8:	e06080e7          	jalr	-506(ra) # 13aa <putc>
    15ac:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    15ae:	03c9d793          	srli	a5,s3,0x3c
    15b2:	97de                	add	a5,a5,s7
    15b4:	0007c583          	lbu	a1,0(a5)
    15b8:	8556                	mv	a0,s5
    15ba:	00000097          	auipc	ra,0x0
    15be:	df0080e7          	jalr	-528(ra) # 13aa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    15c2:	0992                	slli	s3,s3,0x4
    15c4:	34fd                	addiw	s1,s1,-1
    15c6:	f4e5                	bnez	s1,15ae <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    15c8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    15cc:	4981                	li	s3,0
    15ce:	b729                	j	14d8 <vprintf+0x60>
        s = va_arg(ap, char*);
    15d0:	008b0993          	addi	s3,s6,8
    15d4:	000b3483          	ld	s1,0(s6)
        if(s == 0)
    15d8:	c085                	beqz	s1,15f8 <vprintf+0x180>
        while(*s != 0){
    15da:	0004c583          	lbu	a1,0(s1)
    15de:	c9a1                	beqz	a1,162e <vprintf+0x1b6>
          putc(fd, *s);
    15e0:	8556                	mv	a0,s5
    15e2:	00000097          	auipc	ra,0x0
    15e6:	dc8080e7          	jalr	-568(ra) # 13aa <putc>
          s++;
    15ea:	0485                	addi	s1,s1,1
        while(*s != 0){
    15ec:	0004c583          	lbu	a1,0(s1)
    15f0:	f9e5                	bnez	a1,15e0 <vprintf+0x168>
        s = va_arg(ap, char*);
    15f2:	8b4e                	mv	s6,s3
      state = 0;
    15f4:	4981                	li	s3,0
    15f6:	b5cd                	j	14d8 <vprintf+0x60>
          s = "(null)";
    15f8:	00000497          	auipc	s1,0x0
    15fc:	42848493          	addi	s1,s1,1064 # 1a20 <digits+0x18>
        while(*s != 0){
    1600:	02800593          	li	a1,40
    1604:	bff1                	j	15e0 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
    1606:	008b0493          	addi	s1,s6,8
    160a:	000b4583          	lbu	a1,0(s6)
    160e:	8556                	mv	a0,s5
    1610:	00000097          	auipc	ra,0x0
    1614:	d9a080e7          	jalr	-614(ra) # 13aa <putc>
    1618:	8b26                	mv	s6,s1
      state = 0;
    161a:	4981                	li	s3,0
    161c:	bd75                	j	14d8 <vprintf+0x60>
        putc(fd, c);
    161e:	85d2                	mv	a1,s4
    1620:	8556                	mv	a0,s5
    1622:	00000097          	auipc	ra,0x0
    1626:	d88080e7          	jalr	-632(ra) # 13aa <putc>
      state = 0;
    162a:	4981                	li	s3,0
    162c:	b575                	j	14d8 <vprintf+0x60>
        s = va_arg(ap, char*);
    162e:	8b4e                	mv	s6,s3
      state = 0;
    1630:	4981                	li	s3,0
    1632:	b55d                	j	14d8 <vprintf+0x60>
    }
  }
}
    1634:	70e6                	ld	ra,120(sp)
    1636:	7446                	ld	s0,112(sp)
    1638:	74a6                	ld	s1,104(sp)
    163a:	7906                	ld	s2,96(sp)
    163c:	69e6                	ld	s3,88(sp)
    163e:	6a46                	ld	s4,80(sp)
    1640:	6aa6                	ld	s5,72(sp)
    1642:	6b06                	ld	s6,64(sp)
    1644:	7be2                	ld	s7,56(sp)
    1646:	7c42                	ld	s8,48(sp)
    1648:	7ca2                	ld	s9,40(sp)
    164a:	7d02                	ld	s10,32(sp)
    164c:	6de2                	ld	s11,24(sp)
    164e:	6109                	addi	sp,sp,128
    1650:	8082                	ret

0000000000001652 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1652:	715d                	addi	sp,sp,-80
    1654:	ec06                	sd	ra,24(sp)
    1656:	e822                	sd	s0,16(sp)
    1658:	1000                	addi	s0,sp,32
    165a:	e010                	sd	a2,0(s0)
    165c:	e414                	sd	a3,8(s0)
    165e:	e818                	sd	a4,16(s0)
    1660:	ec1c                	sd	a5,24(s0)
    1662:	03043023          	sd	a6,32(s0)
    1666:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    166a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    166e:	8622                	mv	a2,s0
    1670:	00000097          	auipc	ra,0x0
    1674:	e08080e7          	jalr	-504(ra) # 1478 <vprintf>
}
    1678:	60e2                	ld	ra,24(sp)
    167a:	6442                	ld	s0,16(sp)
    167c:	6161                	addi	sp,sp,80
    167e:	8082                	ret

0000000000001680 <printf>:

void
printf(const char *fmt, ...)
{
    1680:	711d                	addi	sp,sp,-96
    1682:	ec06                	sd	ra,24(sp)
    1684:	e822                	sd	s0,16(sp)
    1686:	1000                	addi	s0,sp,32
    1688:	e40c                	sd	a1,8(s0)
    168a:	e810                	sd	a2,16(s0)
    168c:	ec14                	sd	a3,24(s0)
    168e:	f018                	sd	a4,32(s0)
    1690:	f41c                	sd	a5,40(s0)
    1692:	03043823          	sd	a6,48(s0)
    1696:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    169a:	00840613          	addi	a2,s0,8
    169e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    16a2:	85aa                	mv	a1,a0
    16a4:	4505                	li	a0,1
    16a6:	00000097          	auipc	ra,0x0
    16aa:	dd2080e7          	jalr	-558(ra) # 1478 <vprintf>
}
    16ae:	60e2                	ld	ra,24(sp)
    16b0:	6442                	ld	s0,16(sp)
    16b2:	6125                	addi	sp,sp,96
    16b4:	8082                	ret

00000000000016b6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16b6:	1141                	addi	sp,sp,-16
    16b8:	e422                	sd	s0,8(sp)
    16ba:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16bc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16c0:	00000797          	auipc	a5,0x0
    16c4:	38078793          	addi	a5,a5,896 # 1a40 <freep>
    16c8:	639c                	ld	a5,0(a5)
    16ca:	a805                	j	16fa <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    16cc:	4618                	lw	a4,8(a2)
    16ce:	9db9                	addw	a1,a1,a4
    16d0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    16d4:	6398                	ld	a4,0(a5)
    16d6:	6318                	ld	a4,0(a4)
    16d8:	fee53823          	sd	a4,-16(a0)
    16dc:	a091                	j	1720 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    16de:	ff852703          	lw	a4,-8(a0)
    16e2:	9e39                	addw	a2,a2,a4
    16e4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    16e6:	ff053703          	ld	a4,-16(a0)
    16ea:	e398                	sd	a4,0(a5)
    16ec:	a099                	j	1732 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16ee:	6398                	ld	a4,0(a5)
    16f0:	00e7e463          	bltu	a5,a4,16f8 <free+0x42>
    16f4:	00e6ea63          	bltu	a3,a4,1708 <free+0x52>
{
    16f8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16fa:	fed7fae3          	bgeu	a5,a3,16ee <free+0x38>
    16fe:	6398                	ld	a4,0(a5)
    1700:	00e6e463          	bltu	a3,a4,1708 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1704:	fee7eae3          	bltu	a5,a4,16f8 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    1708:	ff852583          	lw	a1,-8(a0)
    170c:	6390                	ld	a2,0(a5)
    170e:	02059713          	slli	a4,a1,0x20
    1712:	9301                	srli	a4,a4,0x20
    1714:	0712                	slli	a4,a4,0x4
    1716:	9736                	add	a4,a4,a3
    1718:	fae60ae3          	beq	a2,a4,16cc <free+0x16>
    bp->s.ptr = p->s.ptr;
    171c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1720:	4790                	lw	a2,8(a5)
    1722:	02061713          	slli	a4,a2,0x20
    1726:	9301                	srli	a4,a4,0x20
    1728:	0712                	slli	a4,a4,0x4
    172a:	973e                	add	a4,a4,a5
    172c:	fae689e3          	beq	a3,a4,16de <free+0x28>
  } else
    p->s.ptr = bp;
    1730:	e394                	sd	a3,0(a5)
  freep = p;
    1732:	00000717          	auipc	a4,0x0
    1736:	30f73723          	sd	a5,782(a4) # 1a40 <freep>
}
    173a:	6422                	ld	s0,8(sp)
    173c:	0141                	addi	sp,sp,16
    173e:	8082                	ret

0000000000001740 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1740:	7139                	addi	sp,sp,-64
    1742:	fc06                	sd	ra,56(sp)
    1744:	f822                	sd	s0,48(sp)
    1746:	f426                	sd	s1,40(sp)
    1748:	f04a                	sd	s2,32(sp)
    174a:	ec4e                	sd	s3,24(sp)
    174c:	e852                	sd	s4,16(sp)
    174e:	e456                	sd	s5,8(sp)
    1750:	e05a                	sd	s6,0(sp)
    1752:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1754:	02051993          	slli	s3,a0,0x20
    1758:	0209d993          	srli	s3,s3,0x20
    175c:	09bd                	addi	s3,s3,15
    175e:	0049d993          	srli	s3,s3,0x4
    1762:	2985                	addiw	s3,s3,1
    1764:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
    1768:	00000797          	auipc	a5,0x0
    176c:	2d878793          	addi	a5,a5,728 # 1a40 <freep>
    1770:	6388                	ld	a0,0(a5)
    1772:	c515                	beqz	a0,179e <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1774:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1776:	4798                	lw	a4,8(a5)
    1778:	03277f63          	bgeu	a4,s2,17b6 <malloc+0x76>
    177c:	8a4e                	mv	s4,s3
    177e:	0009871b          	sext.w	a4,s3
    1782:	6685                	lui	a3,0x1
    1784:	00d77363          	bgeu	a4,a3,178a <malloc+0x4a>
    1788:	6a05                	lui	s4,0x1
    178a:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
    178e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1792:	00000497          	auipc	s1,0x0
    1796:	2ae48493          	addi	s1,s1,686 # 1a40 <freep>
  if(p == (char*)-1)
    179a:	5b7d                	li	s6,-1
    179c:	a885                	j	180c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
    179e:	00001797          	auipc	a5,0x1
    17a2:	b9278793          	addi	a5,a5,-1134 # 2330 <base>
    17a6:	00000717          	auipc	a4,0x0
    17aa:	28f73d23          	sd	a5,666(a4) # 1a40 <freep>
    17ae:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    17b0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    17b4:	b7e1                	j	177c <malloc+0x3c>
      if(p->s.size == nunits)
    17b6:	02e90b63          	beq	s2,a4,17ec <malloc+0xac>
        p->s.size -= nunits;
    17ba:	4137073b          	subw	a4,a4,s3
    17be:	c798                	sw	a4,8(a5)
        p += p->s.size;
    17c0:	1702                	slli	a4,a4,0x20
    17c2:	9301                	srli	a4,a4,0x20
    17c4:	0712                	slli	a4,a4,0x4
    17c6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    17c8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    17cc:	00000717          	auipc	a4,0x0
    17d0:	26a73a23          	sd	a0,628(a4) # 1a40 <freep>
      return (void*)(p + 1);
    17d4:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    17d8:	70e2                	ld	ra,56(sp)
    17da:	7442                	ld	s0,48(sp)
    17dc:	74a2                	ld	s1,40(sp)
    17de:	7902                	ld	s2,32(sp)
    17e0:	69e2                	ld	s3,24(sp)
    17e2:	6a42                	ld	s4,16(sp)
    17e4:	6aa2                	ld	s5,8(sp)
    17e6:	6b02                	ld	s6,0(sp)
    17e8:	6121                	addi	sp,sp,64
    17ea:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    17ec:	6398                	ld	a4,0(a5)
    17ee:	e118                	sd	a4,0(a0)
    17f0:	bff1                	j	17cc <malloc+0x8c>
  hp->s.size = nu;
    17f2:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
    17f6:	0541                	addi	a0,a0,16
    17f8:	00000097          	auipc	ra,0x0
    17fc:	ebe080e7          	jalr	-322(ra) # 16b6 <free>
  return freep;
    1800:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    1802:	d979                	beqz	a0,17d8 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1804:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1806:	4798                	lw	a4,8(a5)
    1808:	fb2777e3          	bgeu	a4,s2,17b6 <malloc+0x76>
    if(p == freep)
    180c:	6098                	ld	a4,0(s1)
    180e:	853e                	mv	a0,a5
    1810:	fef71ae3          	bne	a4,a5,1804 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
    1814:	8552                	mv	a0,s4
    1816:	00000097          	auipc	ra,0x0
    181a:	b3c080e7          	jalr	-1220(ra) # 1352 <sbrk>
  if(p == (char*)-1)
    181e:	fd651ae3          	bne	a0,s6,17f2 <malloc+0xb2>
        return 0;
    1822:	4501                	li	a0,0
    1824:	bf55                	j	17d8 <malloc+0x98>
