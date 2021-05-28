
xv6-user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  fprintf(2, "%s@xv6-riscv:%s$ ", platform, mycwd);
      10:	00001697          	auipc	a3,0x1
      14:	4d068693          	addi	a3,a3,1232 # 14e0 <mycwd>
      18:	00001617          	auipc	a2,0x1
      1c:	4b860613          	addi	a2,a2,1208 # 14d0 <platform>
      20:	00001597          	auipc	a1,0x1
      24:	36858593          	addi	a1,a1,872 # 1388 <malloc+0x11a>
      28:	4509                	li	a0,2
      2a:	00001097          	auipc	ra,0x1
      2e:	156080e7          	jalr	342(ra) # 1180 <fprintf>
  memset(buf, 0, nbuf);
      32:	864a                	mv	a2,s2
      34:	4581                	li	a1,0
      36:	8526                	mv	a0,s1
      38:	00001097          	auipc	ra,0x1
      3c:	bca080e7          	jalr	-1078(ra) # c02 <memset>
  gets(buf, nbuf);
      40:	85ca                	mv	a1,s2
      42:	8526                	mv	a0,s1
      44:	00001097          	auipc	ra,0x1
      48:	c0e080e7          	jalr	-1010(ra) # c52 <gets>
  if(buf[0] == 0) // EOF
      4c:	0004c503          	lbu	a0,0(s1)
      50:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      54:	40a00533          	neg	a0,a0
      58:	60e2                	ld	ra,24(sp)
      5a:	6442                	ld	s0,16(sp)
      5c:	64a2                	ld	s1,8(sp)
      5e:	6902                	ld	s2,0(sp)
      60:	6105                	addi	sp,sp,32
      62:	8082                	ret

0000000000000064 <panic>:
  exit(0);
}

void
panic(char *s)
{
      64:	1141                	addi	sp,sp,-16
      66:	e406                	sd	ra,8(sp)
      68:	e022                	sd	s0,0(sp)
      6a:	0800                	addi	s0,sp,16
  fprintf(2, "%s\n", s);
      6c:	862a                	mv	a2,a0
      6e:	00001597          	auipc	a1,0x1
      72:	33258593          	addi	a1,a1,818 # 13a0 <malloc+0x132>
      76:	4509                	li	a0,2
      78:	00001097          	auipc	ra,0x1
      7c:	108080e7          	jalr	264(ra) # 1180 <fprintf>
  exit(1);
      80:	4505                	li	a0,1
      82:	00001097          	auipc	ra,0x1
      86:	d96080e7          	jalr	-618(ra) # e18 <exit>

000000000000008a <fork1>:
}

int
fork1(void)
{
      8a:	1141                	addi	sp,sp,-16
      8c:	e406                	sd	ra,8(sp)
      8e:	e022                	sd	s0,0(sp)
      90:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      92:	00001097          	auipc	ra,0x1
      96:	d7e080e7          	jalr	-642(ra) # e10 <fork>
  if(pid == -1)
      9a:	57fd                	li	a5,-1
      9c:	00f50663          	beq	a0,a5,a8 <fork1+0x1e>
    panic("fork");
  return pid;
}
      a0:	60a2                	ld	ra,8(sp)
      a2:	6402                	ld	s0,0(sp)
      a4:	0141                	addi	sp,sp,16
      a6:	8082                	ret
    panic("fork");
      a8:	00001517          	auipc	a0,0x1
      ac:	30050513          	addi	a0,a0,768 # 13a8 <malloc+0x13a>
      b0:	00000097          	auipc	ra,0x0
      b4:	fb4080e7          	jalr	-76(ra) # 64 <panic>

00000000000000b8 <runcmd>:
{
      b8:	7179                	addi	sp,sp,-48
      ba:	f406                	sd	ra,40(sp)
      bc:	f022                	sd	s0,32(sp)
      be:	ec26                	sd	s1,24(sp)
      c0:	1800                	addi	s0,sp,48
  if(cmd == 0)
      c2:	c10d                	beqz	a0,e4 <runcmd+0x2c>
      c4:	84aa                	mv	s1,a0
  switch(cmd->type){
      c6:	4118                	lw	a4,0(a0)
      c8:	4795                	li	a5,5
      ca:	02e7e263          	bltu	a5,a4,ee <runcmd+0x36>
      ce:	00056783          	lwu	a5,0(a0)
      d2:	078a                	slli	a5,a5,0x2
      d4:	00001717          	auipc	a4,0x1
      d8:	28470713          	addi	a4,a4,644 # 1358 <malloc+0xea>
      dc:	97ba                	add	a5,a5,a4
      de:	439c                	lw	a5,0(a5)
      e0:	97ba                	add	a5,a5,a4
      e2:	8782                	jr	a5
    exit(1);
      e4:	4505                	li	a0,1
      e6:	00001097          	auipc	ra,0x1
      ea:	d32080e7          	jalr	-718(ra) # e18 <exit>
    panic("runcmd");
      ee:	00001517          	auipc	a0,0x1
      f2:	2c250513          	addi	a0,a0,706 # 13b0 <malloc+0x142>
      f6:	00000097          	auipc	ra,0x0
      fa:	f6e080e7          	jalr	-146(ra) # 64 <panic>
    if(ecmd->argv[0] == 0)
      fe:	6508                	ld	a0,8(a0)
     100:	c515                	beqz	a0,12c <runcmd+0x74>
    exec(ecmd->argv[0], ecmd->argv);
     102:	00848593          	addi	a1,s1,8
     106:	00001097          	auipc	ra,0x1
     10a:	d4a080e7          	jalr	-694(ra) # e50 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     10e:	6490                	ld	a2,8(s1)
     110:	00001597          	auipc	a1,0x1
     114:	2a858593          	addi	a1,a1,680 # 13b8 <malloc+0x14a>
     118:	4509                	li	a0,2
     11a:	00001097          	auipc	ra,0x1
     11e:	066080e7          	jalr	102(ra) # 1180 <fprintf>
  exit(0);
     122:	4501                	li	a0,0
     124:	00001097          	auipc	ra,0x1
     128:	cf4080e7          	jalr	-780(ra) # e18 <exit>
      exit(1);
     12c:	4505                	li	a0,1
     12e:	00001097          	auipc	ra,0x1
     132:	cea080e7          	jalr	-790(ra) # e18 <exit>
    close(rcmd->fd);
     136:	5148                	lw	a0,36(a0)
     138:	00001097          	auipc	ra,0x1
     13c:	d08080e7          	jalr	-760(ra) # e40 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     140:	508c                	lw	a1,32(s1)
     142:	6888                	ld	a0,16(s1)
     144:	00001097          	auipc	ra,0x1
     148:	d14080e7          	jalr	-748(ra) # e58 <open>
     14c:	00054763          	bltz	a0,15a <runcmd+0xa2>
    runcmd(rcmd->cmd);
     150:	6488                	ld	a0,8(s1)
     152:	00000097          	auipc	ra,0x0
     156:	f66080e7          	jalr	-154(ra) # b8 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     15a:	6890                	ld	a2,16(s1)
     15c:	00001597          	auipc	a1,0x1
     160:	26c58593          	addi	a1,a1,620 # 13c8 <malloc+0x15a>
     164:	4509                	li	a0,2
     166:	00001097          	auipc	ra,0x1
     16a:	01a080e7          	jalr	26(ra) # 1180 <fprintf>
      exit(1);
     16e:	4505                	li	a0,1
     170:	00001097          	auipc	ra,0x1
     174:	ca8080e7          	jalr	-856(ra) # e18 <exit>
    if(fork1() == 0)
     178:	00000097          	auipc	ra,0x0
     17c:	f12080e7          	jalr	-238(ra) # 8a <fork1>
     180:	c919                	beqz	a0,196 <runcmd+0xde>
    wait(0);
     182:	4501                	li	a0,0
     184:	00001097          	auipc	ra,0x1
     188:	c9c080e7          	jalr	-868(ra) # e20 <wait>
    runcmd(lcmd->right);
     18c:	6888                	ld	a0,16(s1)
     18e:	00000097          	auipc	ra,0x0
     192:	f2a080e7          	jalr	-214(ra) # b8 <runcmd>
      runcmd(lcmd->left);
     196:	6488                	ld	a0,8(s1)
     198:	00000097          	auipc	ra,0x0
     19c:	f20080e7          	jalr	-224(ra) # b8 <runcmd>
    if(pipe(p) < 0)
     1a0:	fd840513          	addi	a0,s0,-40
     1a4:	00001097          	auipc	ra,0x1
     1a8:	c84080e7          	jalr	-892(ra) # e28 <pipe>
     1ac:	04054363          	bltz	a0,1f2 <runcmd+0x13a>
    if(fork1() == 0){
     1b0:	00000097          	auipc	ra,0x0
     1b4:	eda080e7          	jalr	-294(ra) # 8a <fork1>
     1b8:	c529                	beqz	a0,202 <runcmd+0x14a>
    if(fork1() == 0){
     1ba:	00000097          	auipc	ra,0x0
     1be:	ed0080e7          	jalr	-304(ra) # 8a <fork1>
     1c2:	cd25                	beqz	a0,23a <runcmd+0x182>
    close(p[0]);
     1c4:	fd842503          	lw	a0,-40(s0)
     1c8:	00001097          	auipc	ra,0x1
     1cc:	c78080e7          	jalr	-904(ra) # e40 <close>
    close(p[1]);
     1d0:	fdc42503          	lw	a0,-36(s0)
     1d4:	00001097          	auipc	ra,0x1
     1d8:	c6c080e7          	jalr	-916(ra) # e40 <close>
    wait(0);
     1dc:	4501                	li	a0,0
     1de:	00001097          	auipc	ra,0x1
     1e2:	c42080e7          	jalr	-958(ra) # e20 <wait>
    wait(0);
     1e6:	4501                	li	a0,0
     1e8:	00001097          	auipc	ra,0x1
     1ec:	c38080e7          	jalr	-968(ra) # e20 <wait>
    break;
     1f0:	bf0d                	j	122 <runcmd+0x6a>
      panic("pipe");
     1f2:	00001517          	auipc	a0,0x1
     1f6:	1e650513          	addi	a0,a0,486 # 13d8 <malloc+0x16a>
     1fa:	00000097          	auipc	ra,0x0
     1fe:	e6a080e7          	jalr	-406(ra) # 64 <panic>
      close(1);
     202:	4505                	li	a0,1
     204:	00001097          	auipc	ra,0x1
     208:	c3c080e7          	jalr	-964(ra) # e40 <close>
      dup(p[1]);
     20c:	fdc42503          	lw	a0,-36(s0)
     210:	00001097          	auipc	ra,0x1
     214:	c80080e7          	jalr	-896(ra) # e90 <dup>
      close(p[0]);
     218:	fd842503          	lw	a0,-40(s0)
     21c:	00001097          	auipc	ra,0x1
     220:	c24080e7          	jalr	-988(ra) # e40 <close>
      close(p[1]);
     224:	fdc42503          	lw	a0,-36(s0)
     228:	00001097          	auipc	ra,0x1
     22c:	c18080e7          	jalr	-1000(ra) # e40 <close>
      runcmd(pcmd->left);
     230:	6488                	ld	a0,8(s1)
     232:	00000097          	auipc	ra,0x0
     236:	e86080e7          	jalr	-378(ra) # b8 <runcmd>
      close(0);
     23a:	00001097          	auipc	ra,0x1
     23e:	c06080e7          	jalr	-1018(ra) # e40 <close>
      dup(p[0]);
     242:	fd842503          	lw	a0,-40(s0)
     246:	00001097          	auipc	ra,0x1
     24a:	c4a080e7          	jalr	-950(ra) # e90 <dup>
      close(p[0]);
     24e:	fd842503          	lw	a0,-40(s0)
     252:	00001097          	auipc	ra,0x1
     256:	bee080e7          	jalr	-1042(ra) # e40 <close>
      close(p[1]);
     25a:	fdc42503          	lw	a0,-36(s0)
     25e:	00001097          	auipc	ra,0x1
     262:	be2080e7          	jalr	-1054(ra) # e40 <close>
      runcmd(pcmd->right);
     266:	6888                	ld	a0,16(s1)
     268:	00000097          	auipc	ra,0x0
     26c:	e50080e7          	jalr	-432(ra) # b8 <runcmd>
    if(fork1() == 0)
     270:	00000097          	auipc	ra,0x0
     274:	e1a080e7          	jalr	-486(ra) # 8a <fork1>
     278:	ea0515e3          	bnez	a0,122 <runcmd+0x6a>
      runcmd(bcmd->cmd);
     27c:	6488                	ld	a0,8(s1)
     27e:	00000097          	auipc	ra,0x0
     282:	e3a080e7          	jalr	-454(ra) # b8 <runcmd>

0000000000000286 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     286:	1101                	addi	sp,sp,-32
     288:	ec06                	sd	ra,24(sp)
     28a:	e822                	sd	s0,16(sp)
     28c:	e426                	sd	s1,8(sp)
     28e:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     290:	0a800513          	li	a0,168
     294:	00001097          	auipc	ra,0x1
     298:	fda080e7          	jalr	-38(ra) # 126e <malloc>
     29c:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     29e:	0a800613          	li	a2,168
     2a2:	4581                	li	a1,0
     2a4:	00001097          	auipc	ra,0x1
     2a8:	95e080e7          	jalr	-1698(ra) # c02 <memset>
  cmd->type = EXEC;
     2ac:	4785                	li	a5,1
     2ae:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     2b0:	8526                	mv	a0,s1
     2b2:	60e2                	ld	ra,24(sp)
     2b4:	6442                	ld	s0,16(sp)
     2b6:	64a2                	ld	s1,8(sp)
     2b8:	6105                	addi	sp,sp,32
     2ba:	8082                	ret

00000000000002bc <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2bc:	7139                	addi	sp,sp,-64
     2be:	fc06                	sd	ra,56(sp)
     2c0:	f822                	sd	s0,48(sp)
     2c2:	f426                	sd	s1,40(sp)
     2c4:	f04a                	sd	s2,32(sp)
     2c6:	ec4e                	sd	s3,24(sp)
     2c8:	e852                	sd	s4,16(sp)
     2ca:	e456                	sd	s5,8(sp)
     2cc:	e05a                	sd	s6,0(sp)
     2ce:	0080                	addi	s0,sp,64
     2d0:	8b2a                	mv	s6,a0
     2d2:	8aae                	mv	s5,a1
     2d4:	8a32                	mv	s4,a2
     2d6:	89b6                	mv	s3,a3
     2d8:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2da:	02800513          	li	a0,40
     2de:	00001097          	auipc	ra,0x1
     2e2:	f90080e7          	jalr	-112(ra) # 126e <malloc>
     2e6:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2e8:	02800613          	li	a2,40
     2ec:	4581                	li	a1,0
     2ee:	00001097          	auipc	ra,0x1
     2f2:	914080e7          	jalr	-1772(ra) # c02 <memset>
  cmd->type = REDIR;
     2f6:	4789                	li	a5,2
     2f8:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2fa:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     2fe:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     302:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     306:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     30a:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     30e:	8526                	mv	a0,s1
     310:	70e2                	ld	ra,56(sp)
     312:	7442                	ld	s0,48(sp)
     314:	74a2                	ld	s1,40(sp)
     316:	7902                	ld	s2,32(sp)
     318:	69e2                	ld	s3,24(sp)
     31a:	6a42                	ld	s4,16(sp)
     31c:	6aa2                	ld	s5,8(sp)
     31e:	6b02                	ld	s6,0(sp)
     320:	6121                	addi	sp,sp,64
     322:	8082                	ret

0000000000000324 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     324:	7179                	addi	sp,sp,-48
     326:	f406                	sd	ra,40(sp)
     328:	f022                	sd	s0,32(sp)
     32a:	ec26                	sd	s1,24(sp)
     32c:	e84a                	sd	s2,16(sp)
     32e:	e44e                	sd	s3,8(sp)
     330:	1800                	addi	s0,sp,48
     332:	89aa                	mv	s3,a0
     334:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     336:	4561                	li	a0,24
     338:	00001097          	auipc	ra,0x1
     33c:	f36080e7          	jalr	-202(ra) # 126e <malloc>
     340:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     342:	4661                	li	a2,24
     344:	4581                	li	a1,0
     346:	00001097          	auipc	ra,0x1
     34a:	8bc080e7          	jalr	-1860(ra) # c02 <memset>
  cmd->type = PIPE;
     34e:	478d                	li	a5,3
     350:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     352:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     356:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     35a:	8526                	mv	a0,s1
     35c:	70a2                	ld	ra,40(sp)
     35e:	7402                	ld	s0,32(sp)
     360:	64e2                	ld	s1,24(sp)
     362:	6942                	ld	s2,16(sp)
     364:	69a2                	ld	s3,8(sp)
     366:	6145                	addi	sp,sp,48
     368:	8082                	ret

000000000000036a <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     36a:	7179                	addi	sp,sp,-48
     36c:	f406                	sd	ra,40(sp)
     36e:	f022                	sd	s0,32(sp)
     370:	ec26                	sd	s1,24(sp)
     372:	e84a                	sd	s2,16(sp)
     374:	e44e                	sd	s3,8(sp)
     376:	1800                	addi	s0,sp,48
     378:	89aa                	mv	s3,a0
     37a:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     37c:	4561                	li	a0,24
     37e:	00001097          	auipc	ra,0x1
     382:	ef0080e7          	jalr	-272(ra) # 126e <malloc>
     386:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     388:	4661                	li	a2,24
     38a:	4581                	li	a1,0
     38c:	00001097          	auipc	ra,0x1
     390:	876080e7          	jalr	-1930(ra) # c02 <memset>
  cmd->type = LIST;
     394:	4791                	li	a5,4
     396:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     398:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     39c:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     3a0:	8526                	mv	a0,s1
     3a2:	70a2                	ld	ra,40(sp)
     3a4:	7402                	ld	s0,32(sp)
     3a6:	64e2                	ld	s1,24(sp)
     3a8:	6942                	ld	s2,16(sp)
     3aa:	69a2                	ld	s3,8(sp)
     3ac:	6145                	addi	sp,sp,48
     3ae:	8082                	ret

00000000000003b0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3b0:	1101                	addi	sp,sp,-32
     3b2:	ec06                	sd	ra,24(sp)
     3b4:	e822                	sd	s0,16(sp)
     3b6:	e426                	sd	s1,8(sp)
     3b8:	e04a                	sd	s2,0(sp)
     3ba:	1000                	addi	s0,sp,32
     3bc:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3be:	4541                	li	a0,16
     3c0:	00001097          	auipc	ra,0x1
     3c4:	eae080e7          	jalr	-338(ra) # 126e <malloc>
     3c8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3ca:	4641                	li	a2,16
     3cc:	4581                	li	a1,0
     3ce:	00001097          	auipc	ra,0x1
     3d2:	834080e7          	jalr	-1996(ra) # c02 <memset>
  cmd->type = BACK;
     3d6:	4795                	li	a5,5
     3d8:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     3da:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     3de:	8526                	mv	a0,s1
     3e0:	60e2                	ld	ra,24(sp)
     3e2:	6442                	ld	s0,16(sp)
     3e4:	64a2                	ld	s1,8(sp)
     3e6:	6902                	ld	s2,0(sp)
     3e8:	6105                	addi	sp,sp,32
     3ea:	8082                	ret

00000000000003ec <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3ec:	7139                	addi	sp,sp,-64
     3ee:	fc06                	sd	ra,56(sp)
     3f0:	f822                	sd	s0,48(sp)
     3f2:	f426                	sd	s1,40(sp)
     3f4:	f04a                	sd	s2,32(sp)
     3f6:	ec4e                	sd	s3,24(sp)
     3f8:	e852                	sd	s4,16(sp)
     3fa:	e456                	sd	s5,8(sp)
     3fc:	e05a                	sd	s6,0(sp)
     3fe:	0080                	addi	s0,sp,64
     400:	8a2a                	mv	s4,a0
     402:	892e                	mv	s2,a1
     404:	8ab2                	mv	s5,a2
     406:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     408:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     40a:	00001997          	auipc	s3,0x1
     40e:	0be98993          	addi	s3,s3,190 # 14c8 <whitespace>
     412:	00b4fd63          	bgeu	s1,a1,42c <gettoken+0x40>
     416:	0004c583          	lbu	a1,0(s1)
     41a:	854e                	mv	a0,s3
     41c:	00001097          	auipc	ra,0x1
     420:	80c080e7          	jalr	-2036(ra) # c28 <strchr>
     424:	c501                	beqz	a0,42c <gettoken+0x40>
    s++;
     426:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     428:	fe9917e3          	bne	s2,s1,416 <gettoken+0x2a>
  if(q)
     42c:	000a8463          	beqz	s5,434 <gettoken+0x48>
    *q = s;
     430:	009ab023          	sd	s1,0(s5)
  ret = *s;
     434:	0004c783          	lbu	a5,0(s1)
     438:	00078a9b          	sext.w	s5,a5
  switch(*s){
     43c:	02900713          	li	a4,41
     440:	08f76f63          	bltu	a4,a5,4de <gettoken+0xf2>
     444:	02800713          	li	a4,40
     448:	0ae7f863          	bgeu	a5,a4,4f8 <gettoken+0x10c>
     44c:	e3b9                	bnez	a5,492 <gettoken+0xa6>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     44e:	000b0463          	beqz	s6,456 <gettoken+0x6a>
    *eq = s;
     452:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     456:	00001997          	auipc	s3,0x1
     45a:	07298993          	addi	s3,s3,114 # 14c8 <whitespace>
     45e:	0124fd63          	bgeu	s1,s2,478 <gettoken+0x8c>
     462:	0004c583          	lbu	a1,0(s1)
     466:	854e                	mv	a0,s3
     468:	00000097          	auipc	ra,0x0
     46c:	7c0080e7          	jalr	1984(ra) # c28 <strchr>
     470:	c501                	beqz	a0,478 <gettoken+0x8c>
    s++;
     472:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     474:	fe9917e3          	bne	s2,s1,462 <gettoken+0x76>
  *ps = s;
     478:	009a3023          	sd	s1,0(s4)
  return ret;
}
     47c:	8556                	mv	a0,s5
     47e:	70e2                	ld	ra,56(sp)
     480:	7442                	ld	s0,48(sp)
     482:	74a2                	ld	s1,40(sp)
     484:	7902                	ld	s2,32(sp)
     486:	69e2                	ld	s3,24(sp)
     488:	6a42                	ld	s4,16(sp)
     48a:	6aa2                	ld	s5,8(sp)
     48c:	6b02                	ld	s6,0(sp)
     48e:	6121                	addi	sp,sp,64
     490:	8082                	ret
  switch(*s){
     492:	02600713          	li	a4,38
     496:	06e78163          	beq	a5,a4,4f8 <gettoken+0x10c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     49a:	00001997          	auipc	s3,0x1
     49e:	02e98993          	addi	s3,s3,46 # 14c8 <whitespace>
     4a2:	00001a97          	auipc	s5,0x1
     4a6:	01ea8a93          	addi	s5,s5,30 # 14c0 <symbols>
     4aa:	0324f563          	bgeu	s1,s2,4d4 <gettoken+0xe8>
     4ae:	0004c583          	lbu	a1,0(s1)
     4b2:	854e                	mv	a0,s3
     4b4:	00000097          	auipc	ra,0x0
     4b8:	774080e7          	jalr	1908(ra) # c28 <strchr>
     4bc:	e53d                	bnez	a0,52a <gettoken+0x13e>
     4be:	0004c583          	lbu	a1,0(s1)
     4c2:	8556                	mv	a0,s5
     4c4:	00000097          	auipc	ra,0x0
     4c8:	764080e7          	jalr	1892(ra) # c28 <strchr>
     4cc:	ed21                	bnez	a0,524 <gettoken+0x138>
      s++;
     4ce:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4d0:	fc991fe3          	bne	s2,s1,4ae <gettoken+0xc2>
  if(eq)
     4d4:	06100a93          	li	s5,97
     4d8:	f60b1de3          	bnez	s6,452 <gettoken+0x66>
     4dc:	bf71                	j	478 <gettoken+0x8c>
  switch(*s){
     4de:	03e00713          	li	a4,62
     4e2:	02e78263          	beq	a5,a4,506 <gettoken+0x11a>
     4e6:	00f76b63          	bltu	a4,a5,4fc <gettoken+0x110>
     4ea:	fc57879b          	addiw	a5,a5,-59
     4ee:	0ff7f793          	andi	a5,a5,255
     4f2:	4705                	li	a4,1
     4f4:	faf763e3          	bltu	a4,a5,49a <gettoken+0xae>
    s++;
     4f8:	0485                	addi	s1,s1,1
    break;
     4fa:	bf91                	j	44e <gettoken+0x62>
  switch(*s){
     4fc:	07c00713          	li	a4,124
     500:	fee78ce3          	beq	a5,a4,4f8 <gettoken+0x10c>
     504:	bf59                	j	49a <gettoken+0xae>
    s++;
     506:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     50a:	0014c703          	lbu	a4,1(s1)
     50e:	03e00793          	li	a5,62
      s++;
     512:	0489                	addi	s1,s1,2
      ret = '+';
     514:	02b00a93          	li	s5,43
    if(*s == '>'){
     518:	f2f70be3          	beq	a4,a5,44e <gettoken+0x62>
    s++;
     51c:	84b6                	mv	s1,a3
  ret = *s;
     51e:	03e00a93          	li	s5,62
     522:	b735                	j	44e <gettoken+0x62>
    ret = 'a';
     524:	06100a93          	li	s5,97
     528:	b71d                	j	44e <gettoken+0x62>
     52a:	06100a93          	li	s5,97
     52e:	b705                	j	44e <gettoken+0x62>

0000000000000530 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     530:	7139                	addi	sp,sp,-64
     532:	fc06                	sd	ra,56(sp)
     534:	f822                	sd	s0,48(sp)
     536:	f426                	sd	s1,40(sp)
     538:	f04a                	sd	s2,32(sp)
     53a:	ec4e                	sd	s3,24(sp)
     53c:	e852                	sd	s4,16(sp)
     53e:	e456                	sd	s5,8(sp)
     540:	0080                	addi	s0,sp,64
     542:	8a2a                	mv	s4,a0
     544:	892e                	mv	s2,a1
     546:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     548:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     54a:	00001997          	auipc	s3,0x1
     54e:	f7e98993          	addi	s3,s3,-130 # 14c8 <whitespace>
     552:	00b4fd63          	bgeu	s1,a1,56c <peek+0x3c>
     556:	0004c583          	lbu	a1,0(s1)
     55a:	854e                	mv	a0,s3
     55c:	00000097          	auipc	ra,0x0
     560:	6cc080e7          	jalr	1740(ra) # c28 <strchr>
     564:	c501                	beqz	a0,56c <peek+0x3c>
    s++;
     566:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     568:	fe9917e3          	bne	s2,s1,556 <peek+0x26>
  *ps = s;
     56c:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     570:	0004c583          	lbu	a1,0(s1)
     574:	4501                	li	a0,0
     576:	e991                	bnez	a1,58a <peek+0x5a>
}
     578:	70e2                	ld	ra,56(sp)
     57a:	7442                	ld	s0,48(sp)
     57c:	74a2                	ld	s1,40(sp)
     57e:	7902                	ld	s2,32(sp)
     580:	69e2                	ld	s3,24(sp)
     582:	6a42                	ld	s4,16(sp)
     584:	6aa2                	ld	s5,8(sp)
     586:	6121                	addi	sp,sp,64
     588:	8082                	ret
  return *s && strchr(toks, *s);
     58a:	8556                	mv	a0,s5
     58c:	00000097          	auipc	ra,0x0
     590:	69c080e7          	jalr	1692(ra) # c28 <strchr>
     594:	00a03533          	snez	a0,a0
     598:	b7c5                	j	578 <peek+0x48>

000000000000059a <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     59a:	7159                	addi	sp,sp,-112
     59c:	f486                	sd	ra,104(sp)
     59e:	f0a2                	sd	s0,96(sp)
     5a0:	eca6                	sd	s1,88(sp)
     5a2:	e8ca                	sd	s2,80(sp)
     5a4:	e4ce                	sd	s3,72(sp)
     5a6:	e0d2                	sd	s4,64(sp)
     5a8:	fc56                	sd	s5,56(sp)
     5aa:	f85a                	sd	s6,48(sp)
     5ac:	f45e                	sd	s7,40(sp)
     5ae:	f062                	sd	s8,32(sp)
     5b0:	ec66                	sd	s9,24(sp)
     5b2:	1880                	addi	s0,sp,112
     5b4:	8b2a                	mv	s6,a0
     5b6:	89ae                	mv	s3,a1
     5b8:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5ba:	00001b97          	auipc	s7,0x1
     5be:	e46b8b93          	addi	s7,s7,-442 # 1400 <malloc+0x192>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5c2:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     5c6:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     5ca:	a02d                	j	5f4 <parseredirs+0x5a>
      panic("missing file for redirection");
     5cc:	00001517          	auipc	a0,0x1
     5d0:	e1450513          	addi	a0,a0,-492 # 13e0 <malloc+0x172>
     5d4:	00000097          	auipc	ra,0x0
     5d8:	a90080e7          	jalr	-1392(ra) # 64 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5dc:	4701                	li	a4,0
     5de:	4681                	li	a3,0
     5e0:	f9043603          	ld	a2,-112(s0)
     5e4:	f9843583          	ld	a1,-104(s0)
     5e8:	855a                	mv	a0,s6
     5ea:	00000097          	auipc	ra,0x0
     5ee:	cd2080e7          	jalr	-814(ra) # 2bc <redircmd>
     5f2:	8b2a                	mv	s6,a0
    switch(tok){
     5f4:	03e00a93          	li	s5,62
     5f8:	02b00a13          	li	s4,43
  while(peek(ps, es, "<>")){
     5fc:	865e                	mv	a2,s7
     5fe:	85ca                	mv	a1,s2
     600:	854e                	mv	a0,s3
     602:	00000097          	auipc	ra,0x0
     606:	f2e080e7          	jalr	-210(ra) # 530 <peek>
     60a:	c925                	beqz	a0,67a <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     60c:	4681                	li	a3,0
     60e:	4601                	li	a2,0
     610:	85ca                	mv	a1,s2
     612:	854e                	mv	a0,s3
     614:	00000097          	auipc	ra,0x0
     618:	dd8080e7          	jalr	-552(ra) # 3ec <gettoken>
     61c:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     61e:	f9040693          	addi	a3,s0,-112
     622:	f9840613          	addi	a2,s0,-104
     626:	85ca                	mv	a1,s2
     628:	854e                	mv	a0,s3
     62a:	00000097          	auipc	ra,0x0
     62e:	dc2080e7          	jalr	-574(ra) # 3ec <gettoken>
     632:	f9851de3          	bne	a0,s8,5cc <parseredirs+0x32>
    switch(tok){
     636:	fb9483e3          	beq	s1,s9,5dc <parseredirs+0x42>
     63a:	03548263          	beq	s1,s5,65e <parseredirs+0xc4>
     63e:	fb449fe3          	bne	s1,s4,5fc <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     642:	4705                	li	a4,1
     644:	20100693          	li	a3,513
     648:	f9043603          	ld	a2,-112(s0)
     64c:	f9843583          	ld	a1,-104(s0)
     650:	855a                	mv	a0,s6
     652:	00000097          	auipc	ra,0x0
     656:	c6a080e7          	jalr	-918(ra) # 2bc <redircmd>
     65a:	8b2a                	mv	s6,a0
      break;
     65c:	bf61                	j	5f4 <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     65e:	4705                	li	a4,1
     660:	60100693          	li	a3,1537
     664:	f9043603          	ld	a2,-112(s0)
     668:	f9843583          	ld	a1,-104(s0)
     66c:	855a                	mv	a0,s6
     66e:	00000097          	auipc	ra,0x0
     672:	c4e080e7          	jalr	-946(ra) # 2bc <redircmd>
     676:	8b2a                	mv	s6,a0
      break;
     678:	bfb5                	j	5f4 <parseredirs+0x5a>
    }
  }
  return cmd;
}
     67a:	855a                	mv	a0,s6
     67c:	70a6                	ld	ra,104(sp)
     67e:	7406                	ld	s0,96(sp)
     680:	64e6                	ld	s1,88(sp)
     682:	6946                	ld	s2,80(sp)
     684:	69a6                	ld	s3,72(sp)
     686:	6a06                	ld	s4,64(sp)
     688:	7ae2                	ld	s5,56(sp)
     68a:	7b42                	ld	s6,48(sp)
     68c:	7ba2                	ld	s7,40(sp)
     68e:	7c02                	ld	s8,32(sp)
     690:	6ce2                	ld	s9,24(sp)
     692:	6165                	addi	sp,sp,112
     694:	8082                	ret

0000000000000696 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     696:	7159                	addi	sp,sp,-112
     698:	f486                	sd	ra,104(sp)
     69a:	f0a2                	sd	s0,96(sp)
     69c:	eca6                	sd	s1,88(sp)
     69e:	e8ca                	sd	s2,80(sp)
     6a0:	e4ce                	sd	s3,72(sp)
     6a2:	e0d2                	sd	s4,64(sp)
     6a4:	fc56                	sd	s5,56(sp)
     6a6:	f85a                	sd	s6,48(sp)
     6a8:	f45e                	sd	s7,40(sp)
     6aa:	f062                	sd	s8,32(sp)
     6ac:	ec66                	sd	s9,24(sp)
     6ae:	1880                	addi	s0,sp,112
     6b0:	89aa                	mv	s3,a0
     6b2:	8a2e                	mv	s4,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6b4:	00001617          	auipc	a2,0x1
     6b8:	d5460613          	addi	a2,a2,-684 # 1408 <malloc+0x19a>
     6bc:	00000097          	auipc	ra,0x0
     6c0:	e74080e7          	jalr	-396(ra) # 530 <peek>
     6c4:	e905                	bnez	a0,6f4 <parseexec+0x5e>
     6c6:	892a                	mv	s2,a0
    return parseblock(ps, es);

  ret = execcmd();
     6c8:	00000097          	auipc	ra,0x0
     6cc:	bbe080e7          	jalr	-1090(ra) # 286 <execcmd>
     6d0:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     6d2:	8652                	mv	a2,s4
     6d4:	85ce                	mv	a1,s3
     6d6:	00000097          	auipc	ra,0x0
     6da:	ec4080e7          	jalr	-316(ra) # 59a <parseredirs>
     6de:	8aaa                	mv	s5,a0
  while(!peek(ps, es, "|)&;")){
     6e0:	008c0493          	addi	s1,s8,8
     6e4:	00001b17          	auipc	s6,0x1
     6e8:	d44b0b13          	addi	s6,s6,-700 # 1428 <malloc+0x1ba>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     6ec:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     6f0:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     6f2:	a0b1                	j	73e <parseexec+0xa8>
    return parseblock(ps, es);
     6f4:	85d2                	mv	a1,s4
     6f6:	854e                	mv	a0,s3
     6f8:	00000097          	auipc	ra,0x0
     6fc:	1b8080e7          	jalr	440(ra) # 8b0 <parseblock>
     700:	8aaa                	mv	s5,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     702:	8556                	mv	a0,s5
     704:	70a6                	ld	ra,104(sp)
     706:	7406                	ld	s0,96(sp)
     708:	64e6                	ld	s1,88(sp)
     70a:	6946                	ld	s2,80(sp)
     70c:	69a6                	ld	s3,72(sp)
     70e:	6a06                	ld	s4,64(sp)
     710:	7ae2                	ld	s5,56(sp)
     712:	7b42                	ld	s6,48(sp)
     714:	7ba2                	ld	s7,40(sp)
     716:	7c02                	ld	s8,32(sp)
     718:	6ce2                	ld	s9,24(sp)
     71a:	6165                	addi	sp,sp,112
     71c:	8082                	ret
      panic("syntax");
     71e:	00001517          	auipc	a0,0x1
     722:	cf250513          	addi	a0,a0,-782 # 1410 <malloc+0x1a2>
     726:	00000097          	auipc	ra,0x0
     72a:	93e080e7          	jalr	-1730(ra) # 64 <panic>
    ret = parseredirs(ret, ps, es);
     72e:	8652                	mv	a2,s4
     730:	85ce                	mv	a1,s3
     732:	8556                	mv	a0,s5
     734:	00000097          	auipc	ra,0x0
     738:	e66080e7          	jalr	-410(ra) # 59a <parseredirs>
     73c:	8aaa                	mv	s5,a0
  while(!peek(ps, es, "|)&;")){
     73e:	865a                	mv	a2,s6
     740:	85d2                	mv	a1,s4
     742:	854e                	mv	a0,s3
     744:	00000097          	auipc	ra,0x0
     748:	dec080e7          	jalr	-532(ra) # 530 <peek>
     74c:	e121                	bnez	a0,78c <parseexec+0xf6>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     74e:	f9040693          	addi	a3,s0,-112
     752:	f9840613          	addi	a2,s0,-104
     756:	85d2                	mv	a1,s4
     758:	854e                	mv	a0,s3
     75a:	00000097          	auipc	ra,0x0
     75e:	c92080e7          	jalr	-878(ra) # 3ec <gettoken>
     762:	c50d                	beqz	a0,78c <parseexec+0xf6>
    if(tok != 'a')
     764:	fb951de3          	bne	a0,s9,71e <parseexec+0x88>
    cmd->argv[argc] = q;
     768:	f9843783          	ld	a5,-104(s0)
     76c:	e09c                	sd	a5,0(s1)
    cmd->eargv[argc] = eq;
     76e:	f9043783          	ld	a5,-112(s0)
     772:	e8bc                	sd	a5,80(s1)
    argc++;
     774:	2905                	addiw	s2,s2,1
    if(argc >= MAXARGS)
     776:	04a1                	addi	s1,s1,8
     778:	fb791be3          	bne	s2,s7,72e <parseexec+0x98>
      panic("too many args");
     77c:	00001517          	auipc	a0,0x1
     780:	c9c50513          	addi	a0,a0,-868 # 1418 <malloc+0x1aa>
     784:	00000097          	auipc	ra,0x0
     788:	8e0080e7          	jalr	-1824(ra) # 64 <panic>
  cmd->argv[argc] = 0;
     78c:	090e                	slli	s2,s2,0x3
     78e:	9962                	add	s2,s2,s8
     790:	00093423          	sd	zero,8(s2)
  cmd->eargv[argc] = 0;
     794:	04093c23          	sd	zero,88(s2)
  return ret;
     798:	b7ad                	j	702 <parseexec+0x6c>

000000000000079a <parsepipe>:
{
     79a:	7179                	addi	sp,sp,-48
     79c:	f406                	sd	ra,40(sp)
     79e:	f022                	sd	s0,32(sp)
     7a0:	ec26                	sd	s1,24(sp)
     7a2:	e84a                	sd	s2,16(sp)
     7a4:	e44e                	sd	s3,8(sp)
     7a6:	1800                	addi	s0,sp,48
     7a8:	892a                	mv	s2,a0
     7aa:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     7ac:	00000097          	auipc	ra,0x0
     7b0:	eea080e7          	jalr	-278(ra) # 696 <parseexec>
     7b4:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     7b6:	00001617          	auipc	a2,0x1
     7ba:	c7a60613          	addi	a2,a2,-902 # 1430 <malloc+0x1c2>
     7be:	85ce                	mv	a1,s3
     7c0:	854a                	mv	a0,s2
     7c2:	00000097          	auipc	ra,0x0
     7c6:	d6e080e7          	jalr	-658(ra) # 530 <peek>
     7ca:	e909                	bnez	a0,7dc <parsepipe+0x42>
}
     7cc:	8526                	mv	a0,s1
     7ce:	70a2                	ld	ra,40(sp)
     7d0:	7402                	ld	s0,32(sp)
     7d2:	64e2                	ld	s1,24(sp)
     7d4:	6942                	ld	s2,16(sp)
     7d6:	69a2                	ld	s3,8(sp)
     7d8:	6145                	addi	sp,sp,48
     7da:	8082                	ret
    gettoken(ps, es, 0, 0);
     7dc:	4681                	li	a3,0
     7de:	4601                	li	a2,0
     7e0:	85ce                	mv	a1,s3
     7e2:	854a                	mv	a0,s2
     7e4:	00000097          	auipc	ra,0x0
     7e8:	c08080e7          	jalr	-1016(ra) # 3ec <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     7ec:	85ce                	mv	a1,s3
     7ee:	854a                	mv	a0,s2
     7f0:	00000097          	auipc	ra,0x0
     7f4:	faa080e7          	jalr	-86(ra) # 79a <parsepipe>
     7f8:	85aa                	mv	a1,a0
     7fa:	8526                	mv	a0,s1
     7fc:	00000097          	auipc	ra,0x0
     800:	b28080e7          	jalr	-1240(ra) # 324 <pipecmd>
     804:	84aa                	mv	s1,a0
  return cmd;
     806:	b7d9                	j	7cc <parsepipe+0x32>

0000000000000808 <parseline>:
{
     808:	7179                	addi	sp,sp,-48
     80a:	f406                	sd	ra,40(sp)
     80c:	f022                	sd	s0,32(sp)
     80e:	ec26                	sd	s1,24(sp)
     810:	e84a                	sd	s2,16(sp)
     812:	e44e                	sd	s3,8(sp)
     814:	e052                	sd	s4,0(sp)
     816:	1800                	addi	s0,sp,48
     818:	84aa                	mv	s1,a0
     81a:	892e                	mv	s2,a1
  cmd = parsepipe(ps, es);
     81c:	00000097          	auipc	ra,0x0
     820:	f7e080e7          	jalr	-130(ra) # 79a <parsepipe>
     824:	89aa                	mv	s3,a0
  while(peek(ps, es, "&")){
     826:	00001a17          	auipc	s4,0x1
     82a:	c12a0a13          	addi	s4,s4,-1006 # 1438 <malloc+0x1ca>
     82e:	8652                	mv	a2,s4
     830:	85ca                	mv	a1,s2
     832:	8526                	mv	a0,s1
     834:	00000097          	auipc	ra,0x0
     838:	cfc080e7          	jalr	-772(ra) # 530 <peek>
     83c:	c105                	beqz	a0,85c <parseline+0x54>
    gettoken(ps, es, 0, 0);
     83e:	4681                	li	a3,0
     840:	4601                	li	a2,0
     842:	85ca                	mv	a1,s2
     844:	8526                	mv	a0,s1
     846:	00000097          	auipc	ra,0x0
     84a:	ba6080e7          	jalr	-1114(ra) # 3ec <gettoken>
    cmd = backcmd(cmd);
     84e:	854e                	mv	a0,s3
     850:	00000097          	auipc	ra,0x0
     854:	b60080e7          	jalr	-1184(ra) # 3b0 <backcmd>
     858:	89aa                	mv	s3,a0
     85a:	bfd1                	j	82e <parseline+0x26>
  if(peek(ps, es, ";")){
     85c:	00001617          	auipc	a2,0x1
     860:	be460613          	addi	a2,a2,-1052 # 1440 <malloc+0x1d2>
     864:	85ca                	mv	a1,s2
     866:	8526                	mv	a0,s1
     868:	00000097          	auipc	ra,0x0
     86c:	cc8080e7          	jalr	-824(ra) # 530 <peek>
     870:	e911                	bnez	a0,884 <parseline+0x7c>
}
     872:	854e                	mv	a0,s3
     874:	70a2                	ld	ra,40(sp)
     876:	7402                	ld	s0,32(sp)
     878:	64e2                	ld	s1,24(sp)
     87a:	6942                	ld	s2,16(sp)
     87c:	69a2                	ld	s3,8(sp)
     87e:	6a02                	ld	s4,0(sp)
     880:	6145                	addi	sp,sp,48
     882:	8082                	ret
    gettoken(ps, es, 0, 0);
     884:	4681                	li	a3,0
     886:	4601                	li	a2,0
     888:	85ca                	mv	a1,s2
     88a:	8526                	mv	a0,s1
     88c:	00000097          	auipc	ra,0x0
     890:	b60080e7          	jalr	-1184(ra) # 3ec <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     894:	85ca                	mv	a1,s2
     896:	8526                	mv	a0,s1
     898:	00000097          	auipc	ra,0x0
     89c:	f70080e7          	jalr	-144(ra) # 808 <parseline>
     8a0:	85aa                	mv	a1,a0
     8a2:	854e                	mv	a0,s3
     8a4:	00000097          	auipc	ra,0x0
     8a8:	ac6080e7          	jalr	-1338(ra) # 36a <listcmd>
     8ac:	89aa                	mv	s3,a0
  return cmd;
     8ae:	b7d1                	j	872 <parseline+0x6a>

00000000000008b0 <parseblock>:
{
     8b0:	7179                	addi	sp,sp,-48
     8b2:	f406                	sd	ra,40(sp)
     8b4:	f022                	sd	s0,32(sp)
     8b6:	ec26                	sd	s1,24(sp)
     8b8:	e84a                	sd	s2,16(sp)
     8ba:	e44e                	sd	s3,8(sp)
     8bc:	1800                	addi	s0,sp,48
     8be:	84aa                	mv	s1,a0
     8c0:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     8c2:	00001617          	auipc	a2,0x1
     8c6:	b4660613          	addi	a2,a2,-1210 # 1408 <malloc+0x19a>
     8ca:	00000097          	auipc	ra,0x0
     8ce:	c66080e7          	jalr	-922(ra) # 530 <peek>
     8d2:	c12d                	beqz	a0,934 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     8d4:	4681                	li	a3,0
     8d6:	4601                	li	a2,0
     8d8:	85ca                	mv	a1,s2
     8da:	8526                	mv	a0,s1
     8dc:	00000097          	auipc	ra,0x0
     8e0:	b10080e7          	jalr	-1264(ra) # 3ec <gettoken>
  cmd = parseline(ps, es);
     8e4:	85ca                	mv	a1,s2
     8e6:	8526                	mv	a0,s1
     8e8:	00000097          	auipc	ra,0x0
     8ec:	f20080e7          	jalr	-224(ra) # 808 <parseline>
     8f0:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     8f2:	00001617          	auipc	a2,0x1
     8f6:	b6660613          	addi	a2,a2,-1178 # 1458 <malloc+0x1ea>
     8fa:	85ca                	mv	a1,s2
     8fc:	8526                	mv	a0,s1
     8fe:	00000097          	auipc	ra,0x0
     902:	c32080e7          	jalr	-974(ra) # 530 <peek>
     906:	cd1d                	beqz	a0,944 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     908:	4681                	li	a3,0
     90a:	4601                	li	a2,0
     90c:	85ca                	mv	a1,s2
     90e:	8526                	mv	a0,s1
     910:	00000097          	auipc	ra,0x0
     914:	adc080e7          	jalr	-1316(ra) # 3ec <gettoken>
  cmd = parseredirs(cmd, ps, es);
     918:	864a                	mv	a2,s2
     91a:	85a6                	mv	a1,s1
     91c:	854e                	mv	a0,s3
     91e:	00000097          	auipc	ra,0x0
     922:	c7c080e7          	jalr	-900(ra) # 59a <parseredirs>
}
     926:	70a2                	ld	ra,40(sp)
     928:	7402                	ld	s0,32(sp)
     92a:	64e2                	ld	s1,24(sp)
     92c:	6942                	ld	s2,16(sp)
     92e:	69a2                	ld	s3,8(sp)
     930:	6145                	addi	sp,sp,48
     932:	8082                	ret
    panic("parseblock");
     934:	00001517          	auipc	a0,0x1
     938:	b1450513          	addi	a0,a0,-1260 # 1448 <malloc+0x1da>
     93c:	fffff097          	auipc	ra,0xfffff
     940:	728080e7          	jalr	1832(ra) # 64 <panic>
    panic("syntax - missing )");
     944:	00001517          	auipc	a0,0x1
     948:	b1c50513          	addi	a0,a0,-1252 # 1460 <malloc+0x1f2>
     94c:	fffff097          	auipc	ra,0xfffff
     950:	718080e7          	jalr	1816(ra) # 64 <panic>

0000000000000954 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     954:	1101                	addi	sp,sp,-32
     956:	ec06                	sd	ra,24(sp)
     958:	e822                	sd	s0,16(sp)
     95a:	e426                	sd	s1,8(sp)
     95c:	1000                	addi	s0,sp,32
     95e:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     960:	c521                	beqz	a0,9a8 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     962:	4118                	lw	a4,0(a0)
     964:	4795                	li	a5,5
     966:	04e7e163          	bltu	a5,a4,9a8 <nulterminate+0x54>
     96a:	00056783          	lwu	a5,0(a0)
     96e:	078a                	slli	a5,a5,0x2
     970:	00001717          	auipc	a4,0x1
     974:	a0070713          	addi	a4,a4,-1536 # 1370 <malloc+0x102>
     978:	97ba                	add	a5,a5,a4
     97a:	439c                	lw	a5,0(a5)
     97c:	97ba                	add	a5,a5,a4
     97e:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     980:	651c                	ld	a5,8(a0)
     982:	c39d                	beqz	a5,9a8 <nulterminate+0x54>
     984:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     988:	67b8                	ld	a4,72(a5)
     98a:	00070023          	sb	zero,0(a4)
     98e:	07a1                	addi	a5,a5,8
    for(i=0; ecmd->argv[i]; i++)
     990:	ff87b703          	ld	a4,-8(a5)
     994:	fb75                	bnez	a4,988 <nulterminate+0x34>
     996:	a809                	j	9a8 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     998:	6508                	ld	a0,8(a0)
     99a:	00000097          	auipc	ra,0x0
     99e:	fba080e7          	jalr	-70(ra) # 954 <nulterminate>
    *rcmd->efile = 0;
     9a2:	6c9c                	ld	a5,24(s1)
     9a4:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9a8:	8526                	mv	a0,s1
     9aa:	60e2                	ld	ra,24(sp)
     9ac:	6442                	ld	s0,16(sp)
     9ae:	64a2                	ld	s1,8(sp)
     9b0:	6105                	addi	sp,sp,32
     9b2:	8082                	ret
    nulterminate(pcmd->left);
     9b4:	6508                	ld	a0,8(a0)
     9b6:	00000097          	auipc	ra,0x0
     9ba:	f9e080e7          	jalr	-98(ra) # 954 <nulterminate>
    nulterminate(pcmd->right);
     9be:	6888                	ld	a0,16(s1)
     9c0:	00000097          	auipc	ra,0x0
     9c4:	f94080e7          	jalr	-108(ra) # 954 <nulterminate>
    break;
     9c8:	b7c5                	j	9a8 <nulterminate+0x54>
    nulterminate(lcmd->left);
     9ca:	6508                	ld	a0,8(a0)
     9cc:	00000097          	auipc	ra,0x0
     9d0:	f88080e7          	jalr	-120(ra) # 954 <nulterminate>
    nulterminate(lcmd->right);
     9d4:	6888                	ld	a0,16(s1)
     9d6:	00000097          	auipc	ra,0x0
     9da:	f7e080e7          	jalr	-130(ra) # 954 <nulterminate>
    break;
     9de:	b7e9                	j	9a8 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     9e0:	6508                	ld	a0,8(a0)
     9e2:	00000097          	auipc	ra,0x0
     9e6:	f72080e7          	jalr	-142(ra) # 954 <nulterminate>
    break;
     9ea:	bf7d                	j	9a8 <nulterminate+0x54>

00000000000009ec <parsecmd>:
{
     9ec:	7179                	addi	sp,sp,-48
     9ee:	f406                	sd	ra,40(sp)
     9f0:	f022                	sd	s0,32(sp)
     9f2:	ec26                	sd	s1,24(sp)
     9f4:	e84a                	sd	s2,16(sp)
     9f6:	1800                	addi	s0,sp,48
     9f8:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     9fc:	84aa                	mv	s1,a0
     9fe:	00000097          	auipc	ra,0x0
     a02:	1da080e7          	jalr	474(ra) # bd8 <strlen>
     a06:	1502                	slli	a0,a0,0x20
     a08:	9101                	srli	a0,a0,0x20
     a0a:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     a0c:	85a6                	mv	a1,s1
     a0e:	fd840513          	addi	a0,s0,-40
     a12:	00000097          	auipc	ra,0x0
     a16:	df6080e7          	jalr	-522(ra) # 808 <parseline>
     a1a:	892a                	mv	s2,a0
  peek(&s, es, "");
     a1c:	00001617          	auipc	a2,0x1
     a20:	a5c60613          	addi	a2,a2,-1444 # 1478 <malloc+0x20a>
     a24:	85a6                	mv	a1,s1
     a26:	fd840513          	addi	a0,s0,-40
     a2a:	00000097          	auipc	ra,0x0
     a2e:	b06080e7          	jalr	-1274(ra) # 530 <peek>
  if(s != es){
     a32:	fd843603          	ld	a2,-40(s0)
     a36:	00961e63          	bne	a2,s1,a52 <parsecmd+0x66>
  nulterminate(cmd);
     a3a:	854a                	mv	a0,s2
     a3c:	00000097          	auipc	ra,0x0
     a40:	f18080e7          	jalr	-232(ra) # 954 <nulterminate>
}
     a44:	854a                	mv	a0,s2
     a46:	70a2                	ld	ra,40(sp)
     a48:	7402                	ld	s0,32(sp)
     a4a:	64e2                	ld	s1,24(sp)
     a4c:	6942                	ld	s2,16(sp)
     a4e:	6145                	addi	sp,sp,48
     a50:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     a52:	00001597          	auipc	a1,0x1
     a56:	a2e58593          	addi	a1,a1,-1490 # 1480 <malloc+0x212>
     a5a:	4509                	li	a0,2
     a5c:	00000097          	auipc	ra,0x0
     a60:	724080e7          	jalr	1828(ra) # 1180 <fprintf>
    panic("syntax");
     a64:	00001517          	auipc	a0,0x1
     a68:	9ac50513          	addi	a0,a0,-1620 # 1410 <malloc+0x1a2>
     a6c:	fffff097          	auipc	ra,0xfffff
     a70:	5f8080e7          	jalr	1528(ra) # 64 <panic>

0000000000000a74 <main>:
{
     a74:	7139                	addi	sp,sp,-64
     a76:	fc06                	sd	ra,56(sp)
     a78:	f822                	sd	s0,48(sp)
     a7a:	f426                	sd	s1,40(sp)
     a7c:	f04a                	sd	s2,32(sp)
     a7e:	ec4e                	sd	s3,24(sp)
     a80:	e852                	sd	s4,16(sp)
     a82:	e456                	sd	s5,8(sp)
     a84:	e05a                	sd	s6,0(sp)
     a86:	0080                	addi	s0,sp,64
  while((fd = dev(O_RDWR, 1, 0)) >= 0){
     a88:	4601                	li	a2,0
     a8a:	4585                	li	a1,1
     a8c:	4509                	li	a0,2
     a8e:	00000097          	auipc	ra,0x0
     a92:	432080e7          	jalr	1074(ra) # ec0 <dev>
     a96:	00054963          	bltz	a0,aa8 <main+0x34>
    if(fd >= 3){
     a9a:	4789                	li	a5,2
     a9c:	fea7d6e3          	bge	a5,a0,a88 <main+0x14>
      close(fd);
     aa0:	00000097          	auipc	ra,0x0
     aa4:	3a0080e7          	jalr	928(ra) # e40 <close>
  getcwd(mycwd);
     aa8:	00001517          	auipc	a0,0x1
     aac:	a3850513          	addi	a0,a0,-1480 # 14e0 <mycwd>
     ab0:	00000097          	auipc	ra,0x0
     ab4:	420080e7          	jalr	1056(ra) # ed0 <getcwd>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ab8:	00001917          	auipc	s2,0x1
     abc:	aa890913          	addi	s2,s2,-1368 # 1560 <buf.1168>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ac0:	00001497          	auipc	s1,0x1
     ac4:	a2048493          	addi	s1,s1,-1504 # 14e0 <mycwd>
     ac8:	06300993          	li	s3,99
     acc:	02000a13          	li	s4,32
      if(chdir(buf+3) < 0)
     ad0:	00001a97          	auipc	s5,0x1
     ad4:	a93a8a93          	addi	s5,s5,-1389 # 1563 <buf.1168+0x3>
        fprintf(2, "cannot cd %s\n", buf+3);
     ad8:	00001b17          	auipc	s6,0x1
     adc:	9b8b0b13          	addi	s6,s6,-1608 # 1490 <malloc+0x222>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ae0:	a01d                	j	b06 <main+0x92>
        fprintf(2, "cannot cd %s\n", buf+3);
     ae2:	8656                	mv	a2,s5
     ae4:	85da                	mv	a1,s6
     ae6:	4509                	li	a0,2
     ae8:	00000097          	auipc	ra,0x0
     aec:	698080e7          	jalr	1688(ra) # 1180 <fprintf>
     af0:	a0ad                	j	b5a <main+0xe6>
    if(fork1() == 0)
     af2:	fffff097          	auipc	ra,0xfffff
     af6:	598080e7          	jalr	1432(ra) # 8a <fork1>
     afa:	c535                	beqz	a0,b66 <main+0xf2>
    wait(0);
     afc:	4501                	li	a0,0
     afe:	00000097          	auipc	ra,0x0
     b02:	322080e7          	jalr	802(ra) # e20 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     b06:	06400593          	li	a1,100
     b0a:	854a                	mv	a0,s2
     b0c:	fffff097          	auipc	ra,0xfffff
     b10:	4f4080e7          	jalr	1268(ra) # 0 <getcmd>
     b14:	06054563          	bltz	a0,b7e <main+0x10a>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     b18:	0804c783          	lbu	a5,128(s1)
     b1c:	fd379be3          	bne	a5,s3,af2 <main+0x7e>
     b20:	0814c703          	lbu	a4,129(s1)
     b24:	06400793          	li	a5,100
     b28:	fcf715e3          	bne	a4,a5,af2 <main+0x7e>
     b2c:	0824c783          	lbu	a5,130(s1)
     b30:	fd4791e3          	bne	a5,s4,af2 <main+0x7e>
      buf[strlen(buf)-1] = 0;  // chop \n
     b34:	854a                	mv	a0,s2
     b36:	00000097          	auipc	ra,0x0
     b3a:	0a2080e7          	jalr	162(ra) # bd8 <strlen>
     b3e:	fff5079b          	addiw	a5,a0,-1
     b42:	1782                	slli	a5,a5,0x20
     b44:	9381                	srli	a5,a5,0x20
     b46:	97a6                	add	a5,a5,s1
     b48:	08078023          	sb	zero,128(a5)
      if(chdir(buf+3) < 0)
     b4c:	8556                	mv	a0,s5
     b4e:	00000097          	auipc	ra,0x0
     b52:	33a080e7          	jalr	826(ra) # e88 <chdir>
     b56:	f80546e3          	bltz	a0,ae2 <main+0x6e>
      getcwd(mycwd);
     b5a:	8526                	mv	a0,s1
     b5c:	00000097          	auipc	ra,0x0
     b60:	374080e7          	jalr	884(ra) # ed0 <getcwd>
      continue;
     b64:	b74d                	j	b06 <main+0x92>
      runcmd(parsecmd(buf));
     b66:	00001517          	auipc	a0,0x1
     b6a:	9fa50513          	addi	a0,a0,-1542 # 1560 <buf.1168>
     b6e:	00000097          	auipc	ra,0x0
     b72:	e7e080e7          	jalr	-386(ra) # 9ec <parsecmd>
     b76:	fffff097          	auipc	ra,0xfffff
     b7a:	542080e7          	jalr	1346(ra) # b8 <runcmd>
  exit(0);
     b7e:	4501                	li	a0,0
     b80:	00000097          	auipc	ra,0x0
     b84:	298080e7          	jalr	664(ra) # e18 <exit>

0000000000000b88 <strcpy>:
#include "kernel/include/fcntl.h"
#include "xv6-user/user.h"

char*
strcpy(char *s, const char *t)
{
     b88:	1141                	addi	sp,sp,-16
     b8a:	e422                	sd	s0,8(sp)
     b8c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b8e:	87aa                	mv	a5,a0
     b90:	0585                	addi	a1,a1,1
     b92:	0785                	addi	a5,a5,1
     b94:	fff5c703          	lbu	a4,-1(a1)
     b98:	fee78fa3          	sb	a4,-1(a5)
     b9c:	fb75                	bnez	a4,b90 <strcpy+0x8>
    ;
  return os;
}
     b9e:	6422                	ld	s0,8(sp)
     ba0:	0141                	addi	sp,sp,16
     ba2:	8082                	ret

0000000000000ba4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     ba4:	1141                	addi	sp,sp,-16
     ba6:	e422                	sd	s0,8(sp)
     ba8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     baa:	00054783          	lbu	a5,0(a0)
     bae:	cf91                	beqz	a5,bca <strcmp+0x26>
     bb0:	0005c703          	lbu	a4,0(a1)
     bb4:	00f71b63          	bne	a4,a5,bca <strcmp+0x26>
    p++, q++;
     bb8:	0505                	addi	a0,a0,1
     bba:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     bbc:	00054783          	lbu	a5,0(a0)
     bc0:	c789                	beqz	a5,bca <strcmp+0x26>
     bc2:	0005c703          	lbu	a4,0(a1)
     bc6:	fef709e3          	beq	a4,a5,bb8 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
     bca:	0005c503          	lbu	a0,0(a1)
}
     bce:	40a7853b          	subw	a0,a5,a0
     bd2:	6422                	ld	s0,8(sp)
     bd4:	0141                	addi	sp,sp,16
     bd6:	8082                	ret

0000000000000bd8 <strlen>:

uint
strlen(const char *s)
{
     bd8:	1141                	addi	sp,sp,-16
     bda:	e422                	sd	s0,8(sp)
     bdc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     bde:	00054783          	lbu	a5,0(a0)
     be2:	cf91                	beqz	a5,bfe <strlen+0x26>
     be4:	0505                	addi	a0,a0,1
     be6:	87aa                	mv	a5,a0
     be8:	4685                	li	a3,1
     bea:	9e89                	subw	a3,a3,a0
    ;
     bec:	00f6853b          	addw	a0,a3,a5
     bf0:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
     bf2:	fff7c703          	lbu	a4,-1(a5)
     bf6:	fb7d                	bnez	a4,bec <strlen+0x14>
  return n;
}
     bf8:	6422                	ld	s0,8(sp)
     bfa:	0141                	addi	sp,sp,16
     bfc:	8082                	ret
  for(n = 0; s[n]; n++)
     bfe:	4501                	li	a0,0
     c00:	bfe5                	j	bf8 <strlen+0x20>

0000000000000c02 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c02:	1141                	addi	sp,sp,-16
     c04:	e422                	sd	s0,8(sp)
     c06:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c08:	ce09                	beqz	a2,c22 <memset+0x20>
     c0a:	87aa                	mv	a5,a0
     c0c:	fff6071b          	addiw	a4,a2,-1
     c10:	1702                	slli	a4,a4,0x20
     c12:	9301                	srli	a4,a4,0x20
     c14:	0705                	addi	a4,a4,1
     c16:	972a                	add	a4,a4,a0
    cdst[i] = c;
     c18:	00b78023          	sb	a1,0(a5)
     c1c:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
     c1e:	fee79de3          	bne	a5,a4,c18 <memset+0x16>
  }
  return dst;
}
     c22:	6422                	ld	s0,8(sp)
     c24:	0141                	addi	sp,sp,16
     c26:	8082                	ret

0000000000000c28 <strchr>:

char*
strchr(const char *s, char c)
{
     c28:	1141                	addi	sp,sp,-16
     c2a:	e422                	sd	s0,8(sp)
     c2c:	0800                	addi	s0,sp,16
  for(; *s; s++)
     c2e:	00054783          	lbu	a5,0(a0)
     c32:	cf91                	beqz	a5,c4e <strchr+0x26>
    if(*s == c)
     c34:	00f58a63          	beq	a1,a5,c48 <strchr+0x20>
  for(; *s; s++)
     c38:	0505                	addi	a0,a0,1
     c3a:	00054783          	lbu	a5,0(a0)
     c3e:	c781                	beqz	a5,c46 <strchr+0x1e>
    if(*s == c)
     c40:	feb79ce3          	bne	a5,a1,c38 <strchr+0x10>
     c44:	a011                	j	c48 <strchr+0x20>
      return (char*)s;
  return 0;
     c46:	4501                	li	a0,0
}
     c48:	6422                	ld	s0,8(sp)
     c4a:	0141                	addi	sp,sp,16
     c4c:	8082                	ret
  return 0;
     c4e:	4501                	li	a0,0
     c50:	bfe5                	j	c48 <strchr+0x20>

0000000000000c52 <gets>:

char*
gets(char *buf, int max)
{
     c52:	711d                	addi	sp,sp,-96
     c54:	ec86                	sd	ra,88(sp)
     c56:	e8a2                	sd	s0,80(sp)
     c58:	e4a6                	sd	s1,72(sp)
     c5a:	e0ca                	sd	s2,64(sp)
     c5c:	fc4e                	sd	s3,56(sp)
     c5e:	f852                	sd	s4,48(sp)
     c60:	f456                	sd	s5,40(sp)
     c62:	f05a                	sd	s6,32(sp)
     c64:	ec5e                	sd	s7,24(sp)
     c66:	1080                	addi	s0,sp,96
     c68:	8baa                	mv	s7,a0
     c6a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c6c:	892a                	mv	s2,a0
     c6e:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c70:	4aa9                	li	s5,10
     c72:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c74:	0019849b          	addiw	s1,s3,1
     c78:	0344d863          	bge	s1,s4,ca8 <gets+0x56>
    cc = read(0, &c, 1);
     c7c:	4605                	li	a2,1
     c7e:	faf40593          	addi	a1,s0,-81
     c82:	4501                	li	a0,0
     c84:	00000097          	auipc	ra,0x0
     c88:	1ac080e7          	jalr	428(ra) # e30 <read>
    if(cc < 1)
     c8c:	00a05e63          	blez	a0,ca8 <gets+0x56>
    buf[i++] = c;
     c90:	faf44783          	lbu	a5,-81(s0)
     c94:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     c98:	01578763          	beq	a5,s5,ca6 <gets+0x54>
     c9c:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
     c9e:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
     ca0:	fd679ae3          	bne	a5,s6,c74 <gets+0x22>
     ca4:	a011                	j	ca8 <gets+0x56>
  for(i=0; i+1 < max; ){
     ca6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     ca8:	99de                	add	s3,s3,s7
     caa:	00098023          	sb	zero,0(s3)
  return buf;
}
     cae:	855e                	mv	a0,s7
     cb0:	60e6                	ld	ra,88(sp)
     cb2:	6446                	ld	s0,80(sp)
     cb4:	64a6                	ld	s1,72(sp)
     cb6:	6906                	ld	s2,64(sp)
     cb8:	79e2                	ld	s3,56(sp)
     cba:	7a42                	ld	s4,48(sp)
     cbc:	7aa2                	ld	s5,40(sp)
     cbe:	7b02                	ld	s6,32(sp)
     cc0:	6be2                	ld	s7,24(sp)
     cc2:	6125                	addi	sp,sp,96
     cc4:	8082                	ret

0000000000000cc6 <stat>:

int
stat(const char *n, struct stat *st)
{
     cc6:	1101                	addi	sp,sp,-32
     cc8:	ec06                	sd	ra,24(sp)
     cca:	e822                	sd	s0,16(sp)
     ccc:	e426                	sd	s1,8(sp)
     cce:	e04a                	sd	s2,0(sp)
     cd0:	1000                	addi	s0,sp,32
     cd2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cd4:	4581                	li	a1,0
     cd6:	00000097          	auipc	ra,0x0
     cda:	182080e7          	jalr	386(ra) # e58 <open>
  if(fd < 0)
     cde:	02054563          	bltz	a0,d08 <stat+0x42>
     ce2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     ce4:	85ca                	mv	a1,s2
     ce6:	00000097          	auipc	ra,0x0
     cea:	18a080e7          	jalr	394(ra) # e70 <fstat>
     cee:	892a                	mv	s2,a0
  close(fd);
     cf0:	8526                	mv	a0,s1
     cf2:	00000097          	auipc	ra,0x0
     cf6:	14e080e7          	jalr	334(ra) # e40 <close>
  return r;
}
     cfa:	854a                	mv	a0,s2
     cfc:	60e2                	ld	ra,24(sp)
     cfe:	6442                	ld	s0,16(sp)
     d00:	64a2                	ld	s1,8(sp)
     d02:	6902                	ld	s2,0(sp)
     d04:	6105                	addi	sp,sp,32
     d06:	8082                	ret
    return -1;
     d08:	597d                	li	s2,-1
     d0a:	bfc5                	j	cfa <stat+0x34>

0000000000000d0c <atoi>:

int
atoi(const char *s)
{
     d0c:	1141                	addi	sp,sp,-16
     d0e:	e422                	sd	s0,8(sp)
     d10:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d12:	00054683          	lbu	a3,0(a0)
     d16:	fd06879b          	addiw	a5,a3,-48
     d1a:	0ff7f793          	andi	a5,a5,255
     d1e:	4725                	li	a4,9
     d20:	02f76963          	bltu	a4,a5,d52 <atoi+0x46>
     d24:	862a                	mv	a2,a0
  n = 0;
     d26:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     d28:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     d2a:	0605                	addi	a2,a2,1
     d2c:	0025179b          	slliw	a5,a0,0x2
     d30:	9fa9                	addw	a5,a5,a0
     d32:	0017979b          	slliw	a5,a5,0x1
     d36:	9fb5                	addw	a5,a5,a3
     d38:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d3c:	00064683          	lbu	a3,0(a2)
     d40:	fd06871b          	addiw	a4,a3,-48
     d44:	0ff77713          	andi	a4,a4,255
     d48:	fee5f1e3          	bgeu	a1,a4,d2a <atoi+0x1e>
  return n;
}
     d4c:	6422                	ld	s0,8(sp)
     d4e:	0141                	addi	sp,sp,16
     d50:	8082                	ret
  n = 0;
     d52:	4501                	li	a0,0
     d54:	bfe5                	j	d4c <atoi+0x40>

0000000000000d56 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d56:	1141                	addi	sp,sp,-16
     d58:	e422                	sd	s0,8(sp)
     d5a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d5c:	02b57663          	bgeu	a0,a1,d88 <memmove+0x32>
    while(n-- > 0)
     d60:	02c05163          	blez	a2,d82 <memmove+0x2c>
     d64:	fff6079b          	addiw	a5,a2,-1
     d68:	1782                	slli	a5,a5,0x20
     d6a:	9381                	srli	a5,a5,0x20
     d6c:	0785                	addi	a5,a5,1
     d6e:	97aa                	add	a5,a5,a0
  dst = vdst;
     d70:	872a                	mv	a4,a0
      *dst++ = *src++;
     d72:	0585                	addi	a1,a1,1
     d74:	0705                	addi	a4,a4,1
     d76:	fff5c683          	lbu	a3,-1(a1)
     d7a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     d7e:	fee79ae3          	bne	a5,a4,d72 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     d82:	6422                	ld	s0,8(sp)
     d84:	0141                	addi	sp,sp,16
     d86:	8082                	ret
    dst += n;
     d88:	00c50733          	add	a4,a0,a2
    src += n;
     d8c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     d8e:	fec05ae3          	blez	a2,d82 <memmove+0x2c>
     d92:	fff6079b          	addiw	a5,a2,-1
     d96:	1782                	slli	a5,a5,0x20
     d98:	9381                	srli	a5,a5,0x20
     d9a:	fff7c793          	not	a5,a5
     d9e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     da0:	15fd                	addi	a1,a1,-1
     da2:	177d                	addi	a4,a4,-1
     da4:	0005c683          	lbu	a3,0(a1)
     da8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     dac:	fef71ae3          	bne	a4,a5,da0 <memmove+0x4a>
     db0:	bfc9                	j	d82 <memmove+0x2c>

0000000000000db2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     db2:	1141                	addi	sp,sp,-16
     db4:	e422                	sd	s0,8(sp)
     db6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     db8:	ce15                	beqz	a2,df4 <memcmp+0x42>
     dba:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
     dbe:	00054783          	lbu	a5,0(a0)
     dc2:	0005c703          	lbu	a4,0(a1)
     dc6:	02e79063          	bne	a5,a4,de6 <memcmp+0x34>
     dca:	1682                	slli	a3,a3,0x20
     dcc:	9281                	srli	a3,a3,0x20
     dce:	0685                	addi	a3,a3,1
     dd0:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
     dd2:	0505                	addi	a0,a0,1
    p2++;
     dd4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     dd6:	00d50d63          	beq	a0,a3,df0 <memcmp+0x3e>
    if (*p1 != *p2) {
     dda:	00054783          	lbu	a5,0(a0)
     dde:	0005c703          	lbu	a4,0(a1)
     de2:	fee788e3          	beq	a5,a4,dd2 <memcmp+0x20>
      return *p1 - *p2;
     de6:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
     dea:	6422                	ld	s0,8(sp)
     dec:	0141                	addi	sp,sp,16
     dee:	8082                	ret
  return 0;
     df0:	4501                	li	a0,0
     df2:	bfe5                	j	dea <memcmp+0x38>
     df4:	4501                	li	a0,0
     df6:	bfd5                	j	dea <memcmp+0x38>

0000000000000df8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     df8:	1141                	addi	sp,sp,-16
     dfa:	e406                	sd	ra,8(sp)
     dfc:	e022                	sd	s0,0(sp)
     dfe:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     e00:	00000097          	auipc	ra,0x0
     e04:	f56080e7          	jalr	-170(ra) # d56 <memmove>
}
     e08:	60a2                	ld	ra,8(sp)
     e0a:	6402                	ld	s0,0(sp)
     e0c:	0141                	addi	sp,sp,16
     e0e:	8082                	ret

0000000000000e10 <fork>:
# generated by usys.pl - do not edit
#include "kernel/include/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e10:	4885                	li	a7,1
 ecall
     e12:	00000073          	ecall
 ret
     e16:	8082                	ret

0000000000000e18 <exit>:
.global exit
exit:
 li a7, SYS_exit
     e18:	4889                	li	a7,2
 ecall
     e1a:	00000073          	ecall
 ret
     e1e:	8082                	ret

0000000000000e20 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e20:	488d                	li	a7,3
 ecall
     e22:	00000073          	ecall
 ret
     e26:	8082                	ret

0000000000000e28 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e28:	4891                	li	a7,4
 ecall
     e2a:	00000073          	ecall
 ret
     e2e:	8082                	ret

0000000000000e30 <read>:
.global read
read:
 li a7, SYS_read
     e30:	4895                	li	a7,5
 ecall
     e32:	00000073          	ecall
 ret
     e36:	8082                	ret

0000000000000e38 <write>:
.global write
write:
 li a7, SYS_write
     e38:	48c1                	li	a7,16
 ecall
     e3a:	00000073          	ecall
 ret
     e3e:	8082                	ret

0000000000000e40 <close>:
.global close
close:
 li a7, SYS_close
     e40:	48d5                	li	a7,21
 ecall
     e42:	00000073          	ecall
 ret
     e46:	8082                	ret

0000000000000e48 <kill>:
.global kill
kill:
 li a7, SYS_kill
     e48:	4899                	li	a7,6
 ecall
     e4a:	00000073          	ecall
 ret
     e4e:	8082                	ret

0000000000000e50 <exec>:
.global exec
exec:
 li a7, SYS_exec
     e50:	489d                	li	a7,7
 ecall
     e52:	00000073          	ecall
 ret
     e56:	8082                	ret

0000000000000e58 <open>:
.global open
open:
 li a7, SYS_open
     e58:	48bd                	li	a7,15
 ecall
     e5a:	00000073          	ecall
 ret
     e5e:	8082                	ret

0000000000000e60 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e60:	48c5                	li	a7,17
 ecall
     e62:	00000073          	ecall
 ret
     e66:	8082                	ret

0000000000000e68 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e68:	48c9                	li	a7,18
 ecall
     e6a:	00000073          	ecall
 ret
     e6e:	8082                	ret

0000000000000e70 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e70:	48a1                	li	a7,8
 ecall
     e72:	00000073          	ecall
 ret
     e76:	8082                	ret

0000000000000e78 <link>:
.global link
link:
 li a7, SYS_link
     e78:	48cd                	li	a7,19
 ecall
     e7a:	00000073          	ecall
 ret
     e7e:	8082                	ret

0000000000000e80 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e80:	48d1                	li	a7,20
 ecall
     e82:	00000073          	ecall
 ret
     e86:	8082                	ret

0000000000000e88 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e88:	48a5                	li	a7,9
 ecall
     e8a:	00000073          	ecall
 ret
     e8e:	8082                	ret

0000000000000e90 <dup>:
.global dup
dup:
 li a7, SYS_dup
     e90:	48a9                	li	a7,10
 ecall
     e92:	00000073          	ecall
 ret
     e96:	8082                	ret

0000000000000e98 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     e98:	48ad                	li	a7,11
 ecall
     e9a:	00000073          	ecall
 ret
     e9e:	8082                	ret

0000000000000ea0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     ea0:	48b1                	li	a7,12
 ecall
     ea2:	00000073          	ecall
 ret
     ea6:	8082                	ret

0000000000000ea8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     ea8:	48b5                	li	a7,13
 ecall
     eaa:	00000073          	ecall
 ret
     eae:	8082                	ret

0000000000000eb0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     eb0:	48b9                	li	a7,14
 ecall
     eb2:	00000073          	ecall
 ret
     eb6:	8082                	ret

0000000000000eb8 <test_proc>:
.global test_proc
test_proc:
 li a7, SYS_test_proc
     eb8:	48d9                	li	a7,22
 ecall
     eba:	00000073          	ecall
 ret
     ebe:	8082                	ret

0000000000000ec0 <dev>:
.global dev
dev:
 li a7, SYS_dev
     ec0:	48dd                	li	a7,23
 ecall
     ec2:	00000073          	ecall
 ret
     ec6:	8082                	ret

0000000000000ec8 <dir>:
.global dir
dir:
 li a7, SYS_dir
     ec8:	48e1                	li	a7,24
 ecall
     eca:	00000073          	ecall
 ret
     ece:	8082                	ret

0000000000000ed0 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
     ed0:	48e5                	li	a7,25
 ecall
     ed2:	00000073          	ecall
 ret
     ed6:	8082                	ret

0000000000000ed8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     ed8:	1101                	addi	sp,sp,-32
     eda:	ec06                	sd	ra,24(sp)
     edc:	e822                	sd	s0,16(sp)
     ede:	1000                	addi	s0,sp,32
     ee0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ee4:	4605                	li	a2,1
     ee6:	fef40593          	addi	a1,s0,-17
     eea:	00000097          	auipc	ra,0x0
     eee:	f4e080e7          	jalr	-178(ra) # e38 <write>
}
     ef2:	60e2                	ld	ra,24(sp)
     ef4:	6442                	ld	s0,16(sp)
     ef6:	6105                	addi	sp,sp,32
     ef8:	8082                	ret

0000000000000efa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     efa:	7139                	addi	sp,sp,-64
     efc:	fc06                	sd	ra,56(sp)
     efe:	f822                	sd	s0,48(sp)
     f00:	f426                	sd	s1,40(sp)
     f02:	f04a                	sd	s2,32(sp)
     f04:	ec4e                	sd	s3,24(sp)
     f06:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f08:	c299                	beqz	a3,f0e <printint+0x14>
     f0a:	0005cd63          	bltz	a1,f24 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f0e:	2581                	sext.w	a1,a1
  neg = 0;
     f10:	4301                	li	t1,0
     f12:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
     f16:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
     f18:	2601                	sext.w	a2,a2
     f1a:	00000897          	auipc	a7,0x0
     f1e:	58688893          	addi	a7,a7,1414 # 14a0 <digits>
     f22:	a039                	j	f30 <printint+0x36>
    x = -xx;
     f24:	40b005bb          	negw	a1,a1
    neg = 1;
     f28:	4305                	li	t1,1
    x = -xx;
     f2a:	b7e5                	j	f12 <printint+0x18>
  }while((x /= base) != 0);
     f2c:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
     f2e:	8836                	mv	a6,a3
     f30:	0018069b          	addiw	a3,a6,1
     f34:	02c5f7bb          	remuw	a5,a1,a2
     f38:	1782                	slli	a5,a5,0x20
     f3a:	9381                	srli	a5,a5,0x20
     f3c:	97c6                	add	a5,a5,a7
     f3e:	0007c783          	lbu	a5,0(a5)
     f42:	00f70023          	sb	a5,0(a4)
     f46:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
     f48:	02c5d7bb          	divuw	a5,a1,a2
     f4c:	fec5f0e3          	bgeu	a1,a2,f2c <printint+0x32>
  if(neg)
     f50:	00030b63          	beqz	t1,f66 <printint+0x6c>
    buf[i++] = '-';
     f54:	fd040793          	addi	a5,s0,-48
     f58:	96be                	add	a3,a3,a5
     f5a:	02d00793          	li	a5,45
     f5e:	fef68823          	sb	a5,-16(a3)
     f62:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
     f66:	02d05963          	blez	a3,f98 <printint+0x9e>
     f6a:	89aa                	mv	s3,a0
     f6c:	fc040793          	addi	a5,s0,-64
     f70:	00d784b3          	add	s1,a5,a3
     f74:	fff78913          	addi	s2,a5,-1
     f78:	9936                	add	s2,s2,a3
     f7a:	36fd                	addiw	a3,a3,-1
     f7c:	1682                	slli	a3,a3,0x20
     f7e:	9281                	srli	a3,a3,0x20
     f80:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
     f84:	fff4c583          	lbu	a1,-1(s1)
     f88:	854e                	mv	a0,s3
     f8a:	00000097          	auipc	ra,0x0
     f8e:	f4e080e7          	jalr	-178(ra) # ed8 <putc>
     f92:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
     f94:	ff2498e3          	bne	s1,s2,f84 <printint+0x8a>
}
     f98:	70e2                	ld	ra,56(sp)
     f9a:	7442                	ld	s0,48(sp)
     f9c:	74a2                	ld	s1,40(sp)
     f9e:	7902                	ld	s2,32(sp)
     fa0:	69e2                	ld	s3,24(sp)
     fa2:	6121                	addi	sp,sp,64
     fa4:	8082                	ret

0000000000000fa6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     fa6:	7119                	addi	sp,sp,-128
     fa8:	fc86                	sd	ra,120(sp)
     faa:	f8a2                	sd	s0,112(sp)
     fac:	f4a6                	sd	s1,104(sp)
     fae:	f0ca                	sd	s2,96(sp)
     fb0:	ecce                	sd	s3,88(sp)
     fb2:	e8d2                	sd	s4,80(sp)
     fb4:	e4d6                	sd	s5,72(sp)
     fb6:	e0da                	sd	s6,64(sp)
     fb8:	fc5e                	sd	s7,56(sp)
     fba:	f862                	sd	s8,48(sp)
     fbc:	f466                	sd	s9,40(sp)
     fbe:	f06a                	sd	s10,32(sp)
     fc0:	ec6e                	sd	s11,24(sp)
     fc2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     fc4:	0005c483          	lbu	s1,0(a1)
     fc8:	18048d63          	beqz	s1,1162 <vprintf+0x1bc>
     fcc:	8aaa                	mv	s5,a0
     fce:	8b32                	mv	s6,a2
     fd0:	00158913          	addi	s2,a1,1
  state = 0;
     fd4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     fd6:	02500a13          	li	s4,37
      if(c == 'd'){
     fda:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
     fde:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
     fe2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
     fe6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     fea:	00000b97          	auipc	s7,0x0
     fee:	4b6b8b93          	addi	s7,s7,1206 # 14a0 <digits>
     ff2:	a839                	j	1010 <vprintf+0x6a>
        putc(fd, c);
     ff4:	85a6                	mv	a1,s1
     ff6:	8556                	mv	a0,s5
     ff8:	00000097          	auipc	ra,0x0
     ffc:	ee0080e7          	jalr	-288(ra) # ed8 <putc>
    1000:	a019                	j	1006 <vprintf+0x60>
    } else if(state == '%'){
    1002:	01498f63          	beq	s3,s4,1020 <vprintf+0x7a>
    1006:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
    1008:	fff94483          	lbu	s1,-1(s2)
    100c:	14048b63          	beqz	s1,1162 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
    1010:	0004879b          	sext.w	a5,s1
    if(state == 0){
    1014:	fe0997e3          	bnez	s3,1002 <vprintf+0x5c>
      if(c == '%'){
    1018:	fd479ee3          	bne	a5,s4,ff4 <vprintf+0x4e>
        state = '%';
    101c:	89be                	mv	s3,a5
    101e:	b7e5                	j	1006 <vprintf+0x60>
      if(c == 'd'){
    1020:	05878063          	beq	a5,s8,1060 <vprintf+0xba>
      } else if(c == 'l') {
    1024:	05978c63          	beq	a5,s9,107c <vprintf+0xd6>
      } else if(c == 'x') {
    1028:	07a78863          	beq	a5,s10,1098 <vprintf+0xf2>
      } else if(c == 'p') {
    102c:	09b78463          	beq	a5,s11,10b4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    1030:	07300713          	li	a4,115
    1034:	0ce78563          	beq	a5,a4,10fe <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1038:	06300713          	li	a4,99
    103c:	0ee78c63          	beq	a5,a4,1134 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    1040:	11478663          	beq	a5,s4,114c <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1044:	85d2                	mv	a1,s4
    1046:	8556                	mv	a0,s5
    1048:	00000097          	auipc	ra,0x0
    104c:	e90080e7          	jalr	-368(ra) # ed8 <putc>
        putc(fd, c);
    1050:	85a6                	mv	a1,s1
    1052:	8556                	mv	a0,s5
    1054:	00000097          	auipc	ra,0x0
    1058:	e84080e7          	jalr	-380(ra) # ed8 <putc>
      }
      state = 0;
    105c:	4981                	li	s3,0
    105e:	b765                	j	1006 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    1060:	008b0493          	addi	s1,s6,8
    1064:	4685                	li	a3,1
    1066:	4629                	li	a2,10
    1068:	000b2583          	lw	a1,0(s6)
    106c:	8556                	mv	a0,s5
    106e:	00000097          	auipc	ra,0x0
    1072:	e8c080e7          	jalr	-372(ra) # efa <printint>
    1076:	8b26                	mv	s6,s1
      state = 0;
    1078:	4981                	li	s3,0
    107a:	b771                	j	1006 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    107c:	008b0493          	addi	s1,s6,8
    1080:	4681                	li	a3,0
    1082:	4629                	li	a2,10
    1084:	000b2583          	lw	a1,0(s6)
    1088:	8556                	mv	a0,s5
    108a:	00000097          	auipc	ra,0x0
    108e:	e70080e7          	jalr	-400(ra) # efa <printint>
    1092:	8b26                	mv	s6,s1
      state = 0;
    1094:	4981                	li	s3,0
    1096:	bf85                	j	1006 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1098:	008b0493          	addi	s1,s6,8
    109c:	4681                	li	a3,0
    109e:	4641                	li	a2,16
    10a0:	000b2583          	lw	a1,0(s6)
    10a4:	8556                	mv	a0,s5
    10a6:	00000097          	auipc	ra,0x0
    10aa:	e54080e7          	jalr	-428(ra) # efa <printint>
    10ae:	8b26                	mv	s6,s1
      state = 0;
    10b0:	4981                	li	s3,0
    10b2:	bf91                	j	1006 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    10b4:	008b0793          	addi	a5,s6,8
    10b8:	f8f43423          	sd	a5,-120(s0)
    10bc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    10c0:	03000593          	li	a1,48
    10c4:	8556                	mv	a0,s5
    10c6:	00000097          	auipc	ra,0x0
    10ca:	e12080e7          	jalr	-494(ra) # ed8 <putc>
  putc(fd, 'x');
    10ce:	85ea                	mv	a1,s10
    10d0:	8556                	mv	a0,s5
    10d2:	00000097          	auipc	ra,0x0
    10d6:	e06080e7          	jalr	-506(ra) # ed8 <putc>
    10da:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10dc:	03c9d793          	srli	a5,s3,0x3c
    10e0:	97de                	add	a5,a5,s7
    10e2:	0007c583          	lbu	a1,0(a5)
    10e6:	8556                	mv	a0,s5
    10e8:	00000097          	auipc	ra,0x0
    10ec:	df0080e7          	jalr	-528(ra) # ed8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10f0:	0992                	slli	s3,s3,0x4
    10f2:	34fd                	addiw	s1,s1,-1
    10f4:	f4e5                	bnez	s1,10dc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    10f6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    10fa:	4981                	li	s3,0
    10fc:	b729                	j	1006 <vprintf+0x60>
        s = va_arg(ap, char*);
    10fe:	008b0993          	addi	s3,s6,8
    1102:	000b3483          	ld	s1,0(s6)
        if(s == 0)
    1106:	c085                	beqz	s1,1126 <vprintf+0x180>
        while(*s != 0){
    1108:	0004c583          	lbu	a1,0(s1)
    110c:	c9a1                	beqz	a1,115c <vprintf+0x1b6>
          putc(fd, *s);
    110e:	8556                	mv	a0,s5
    1110:	00000097          	auipc	ra,0x0
    1114:	dc8080e7          	jalr	-568(ra) # ed8 <putc>
          s++;
    1118:	0485                	addi	s1,s1,1
        while(*s != 0){
    111a:	0004c583          	lbu	a1,0(s1)
    111e:	f9e5                	bnez	a1,110e <vprintf+0x168>
        s = va_arg(ap, char*);
    1120:	8b4e                	mv	s6,s3
      state = 0;
    1122:	4981                	li	s3,0
    1124:	b5cd                	j	1006 <vprintf+0x60>
          s = "(null)";
    1126:	00000497          	auipc	s1,0x0
    112a:	39248493          	addi	s1,s1,914 # 14b8 <digits+0x18>
        while(*s != 0){
    112e:	02800593          	li	a1,40
    1132:	bff1                	j	110e <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
    1134:	008b0493          	addi	s1,s6,8
    1138:	000b4583          	lbu	a1,0(s6)
    113c:	8556                	mv	a0,s5
    113e:	00000097          	auipc	ra,0x0
    1142:	d9a080e7          	jalr	-614(ra) # ed8 <putc>
    1146:	8b26                	mv	s6,s1
      state = 0;
    1148:	4981                	li	s3,0
    114a:	bd75                	j	1006 <vprintf+0x60>
        putc(fd, c);
    114c:	85d2                	mv	a1,s4
    114e:	8556                	mv	a0,s5
    1150:	00000097          	auipc	ra,0x0
    1154:	d88080e7          	jalr	-632(ra) # ed8 <putc>
      state = 0;
    1158:	4981                	li	s3,0
    115a:	b575                	j	1006 <vprintf+0x60>
        s = va_arg(ap, char*);
    115c:	8b4e                	mv	s6,s3
      state = 0;
    115e:	4981                	li	s3,0
    1160:	b55d                	j	1006 <vprintf+0x60>
    }
  }
}
    1162:	70e6                	ld	ra,120(sp)
    1164:	7446                	ld	s0,112(sp)
    1166:	74a6                	ld	s1,104(sp)
    1168:	7906                	ld	s2,96(sp)
    116a:	69e6                	ld	s3,88(sp)
    116c:	6a46                	ld	s4,80(sp)
    116e:	6aa6                	ld	s5,72(sp)
    1170:	6b06                	ld	s6,64(sp)
    1172:	7be2                	ld	s7,56(sp)
    1174:	7c42                	ld	s8,48(sp)
    1176:	7ca2                	ld	s9,40(sp)
    1178:	7d02                	ld	s10,32(sp)
    117a:	6de2                	ld	s11,24(sp)
    117c:	6109                	addi	sp,sp,128
    117e:	8082                	ret

0000000000001180 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1180:	715d                	addi	sp,sp,-80
    1182:	ec06                	sd	ra,24(sp)
    1184:	e822                	sd	s0,16(sp)
    1186:	1000                	addi	s0,sp,32
    1188:	e010                	sd	a2,0(s0)
    118a:	e414                	sd	a3,8(s0)
    118c:	e818                	sd	a4,16(s0)
    118e:	ec1c                	sd	a5,24(s0)
    1190:	03043023          	sd	a6,32(s0)
    1194:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1198:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    119c:	8622                	mv	a2,s0
    119e:	00000097          	auipc	ra,0x0
    11a2:	e08080e7          	jalr	-504(ra) # fa6 <vprintf>
}
    11a6:	60e2                	ld	ra,24(sp)
    11a8:	6442                	ld	s0,16(sp)
    11aa:	6161                	addi	sp,sp,80
    11ac:	8082                	ret

00000000000011ae <printf>:

void
printf(const char *fmt, ...)
{
    11ae:	711d                	addi	sp,sp,-96
    11b0:	ec06                	sd	ra,24(sp)
    11b2:	e822                	sd	s0,16(sp)
    11b4:	1000                	addi	s0,sp,32
    11b6:	e40c                	sd	a1,8(s0)
    11b8:	e810                	sd	a2,16(s0)
    11ba:	ec14                	sd	a3,24(s0)
    11bc:	f018                	sd	a4,32(s0)
    11be:	f41c                	sd	a5,40(s0)
    11c0:	03043823          	sd	a6,48(s0)
    11c4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    11c8:	00840613          	addi	a2,s0,8
    11cc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    11d0:	85aa                	mv	a1,a0
    11d2:	4505                	li	a0,1
    11d4:	00000097          	auipc	ra,0x0
    11d8:	dd2080e7          	jalr	-558(ra) # fa6 <vprintf>
}
    11dc:	60e2                	ld	ra,24(sp)
    11de:	6442                	ld	s0,16(sp)
    11e0:	6125                	addi	sp,sp,96
    11e2:	8082                	ret

00000000000011e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11e4:	1141                	addi	sp,sp,-16
    11e6:	e422                	sd	s0,8(sp)
    11e8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11ea:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11ee:	00000797          	auipc	a5,0x0
    11f2:	2ea78793          	addi	a5,a5,746 # 14d8 <freep>
    11f6:	639c                	ld	a5,0(a5)
    11f8:	a805                	j	1228 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    11fa:	4618                	lw	a4,8(a2)
    11fc:	9db9                	addw	a1,a1,a4
    11fe:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1202:	6398                	ld	a4,0(a5)
    1204:	6318                	ld	a4,0(a4)
    1206:	fee53823          	sd	a4,-16(a0)
    120a:	a091                	j	124e <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    120c:	ff852703          	lw	a4,-8(a0)
    1210:	9e39                	addw	a2,a2,a4
    1212:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    1214:	ff053703          	ld	a4,-16(a0)
    1218:	e398                	sd	a4,0(a5)
    121a:	a099                	j	1260 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    121c:	6398                	ld	a4,0(a5)
    121e:	00e7e463          	bltu	a5,a4,1226 <free+0x42>
    1222:	00e6ea63          	bltu	a3,a4,1236 <free+0x52>
{
    1226:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1228:	fed7fae3          	bgeu	a5,a3,121c <free+0x38>
    122c:	6398                	ld	a4,0(a5)
    122e:	00e6e463          	bltu	a3,a4,1236 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1232:	fee7eae3          	bltu	a5,a4,1226 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    1236:	ff852583          	lw	a1,-8(a0)
    123a:	6390                	ld	a2,0(a5)
    123c:	02059713          	slli	a4,a1,0x20
    1240:	9301                	srli	a4,a4,0x20
    1242:	0712                	slli	a4,a4,0x4
    1244:	9736                	add	a4,a4,a3
    1246:	fae60ae3          	beq	a2,a4,11fa <free+0x16>
    bp->s.ptr = p->s.ptr;
    124a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    124e:	4790                	lw	a2,8(a5)
    1250:	02061713          	slli	a4,a2,0x20
    1254:	9301                	srli	a4,a4,0x20
    1256:	0712                	slli	a4,a4,0x4
    1258:	973e                	add	a4,a4,a5
    125a:	fae689e3          	beq	a3,a4,120c <free+0x28>
  } else
    p->s.ptr = bp;
    125e:	e394                	sd	a3,0(a5)
  freep = p;
    1260:	00000717          	auipc	a4,0x0
    1264:	26f73c23          	sd	a5,632(a4) # 14d8 <freep>
}
    1268:	6422                	ld	s0,8(sp)
    126a:	0141                	addi	sp,sp,16
    126c:	8082                	ret

000000000000126e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    126e:	7139                	addi	sp,sp,-64
    1270:	fc06                	sd	ra,56(sp)
    1272:	f822                	sd	s0,48(sp)
    1274:	f426                	sd	s1,40(sp)
    1276:	f04a                	sd	s2,32(sp)
    1278:	ec4e                	sd	s3,24(sp)
    127a:	e852                	sd	s4,16(sp)
    127c:	e456                	sd	s5,8(sp)
    127e:	e05a                	sd	s6,0(sp)
    1280:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1282:	02051993          	slli	s3,a0,0x20
    1286:	0209d993          	srli	s3,s3,0x20
    128a:	09bd                	addi	s3,s3,15
    128c:	0049d993          	srli	s3,s3,0x4
    1290:	2985                	addiw	s3,s3,1
    1292:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
    1296:	00000797          	auipc	a5,0x0
    129a:	24278793          	addi	a5,a5,578 # 14d8 <freep>
    129e:	6388                	ld	a0,0(a5)
    12a0:	c515                	beqz	a0,12cc <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    12a4:	4798                	lw	a4,8(a5)
    12a6:	03277f63          	bgeu	a4,s2,12e4 <malloc+0x76>
    12aa:	8a4e                	mv	s4,s3
    12ac:	0009871b          	sext.w	a4,s3
    12b0:	6685                	lui	a3,0x1
    12b2:	00d77363          	bgeu	a4,a3,12b8 <malloc+0x4a>
    12b6:	6a05                	lui	s4,0x1
    12b8:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
    12bc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12c0:	00000497          	auipc	s1,0x0
    12c4:	21848493          	addi	s1,s1,536 # 14d8 <freep>
  if(p == (char*)-1)
    12c8:	5b7d                	li	s6,-1
    12ca:	a885                	j	133a <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
    12cc:	00000797          	auipc	a5,0x0
    12d0:	2fc78793          	addi	a5,a5,764 # 15c8 <base>
    12d4:	00000717          	auipc	a4,0x0
    12d8:	20f73223          	sd	a5,516(a4) # 14d8 <freep>
    12dc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    12de:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    12e2:	b7e1                	j	12aa <malloc+0x3c>
      if(p->s.size == nunits)
    12e4:	02e90b63          	beq	s2,a4,131a <malloc+0xac>
        p->s.size -= nunits;
    12e8:	4137073b          	subw	a4,a4,s3
    12ec:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12ee:	1702                	slli	a4,a4,0x20
    12f0:	9301                	srli	a4,a4,0x20
    12f2:	0712                	slli	a4,a4,0x4
    12f4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    12f6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    12fa:	00000717          	auipc	a4,0x0
    12fe:	1ca73f23          	sd	a0,478(a4) # 14d8 <freep>
      return (void*)(p + 1);
    1302:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1306:	70e2                	ld	ra,56(sp)
    1308:	7442                	ld	s0,48(sp)
    130a:	74a2                	ld	s1,40(sp)
    130c:	7902                	ld	s2,32(sp)
    130e:	69e2                	ld	s3,24(sp)
    1310:	6a42                	ld	s4,16(sp)
    1312:	6aa2                	ld	s5,8(sp)
    1314:	6b02                	ld	s6,0(sp)
    1316:	6121                	addi	sp,sp,64
    1318:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    131a:	6398                	ld	a4,0(a5)
    131c:	e118                	sd	a4,0(a0)
    131e:	bff1                	j	12fa <malloc+0x8c>
  hp->s.size = nu;
    1320:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
    1324:	0541                	addi	a0,a0,16
    1326:	00000097          	auipc	ra,0x0
    132a:	ebe080e7          	jalr	-322(ra) # 11e4 <free>
  return freep;
    132e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    1330:	d979                	beqz	a0,1306 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1332:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1334:	4798                	lw	a4,8(a5)
    1336:	fb2777e3          	bgeu	a4,s2,12e4 <malloc+0x76>
    if(p == freep)
    133a:	6098                	ld	a4,0(s1)
    133c:	853e                	mv	a0,a5
    133e:	fef71ae3          	bne	a4,a5,1332 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
    1342:	8552                	mv	a0,s4
    1344:	00000097          	auipc	ra,0x0
    1348:	b5c080e7          	jalr	-1188(ra) # ea0 <sbrk>
  if(p == (char*)-1)
    134c:	fd651ae3          	bne	a0,s6,1320 <malloc+0xb2>
        return 0;
    1350:	4501                	li	a0,0
    1352:	bf55                	j	1306 <malloc+0x98>
