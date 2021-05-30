
target/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080020000 <_start>:
    80020000:	00150293          	addi	t0,a0,1
    80020004:	02ba                	slli	t0,t0,0xe
    80020006:	0000f117          	auipc	sp,0xf
    8002000a:	ffa10113          	addi	sp,sp,-6 # 8002f000 <boot_stack>
    8002000e:	9116                	add	sp,sp,t0
    80020010:	20b000ef          	jal	ra,80020a1a <main>

0000000080020014 <loop>:
    80020014:	a001                	j	80020014 <loop>

0000000080020016 <printint>:
    }
}

static void
printint(int xx, int base, int sign)
{
    80020016:	7179                	addi	sp,sp,-48
    80020018:	f406                	sd	ra,40(sp)
    8002001a:	f022                	sd	s0,32(sp)
    8002001c:	ec26                	sd	s1,24(sp)
    8002001e:	e84a                	sd	s2,16(sp)
    80020020:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80020022:	c219                	beqz	a2,80020028 <printint+0x12>
    80020024:	00054d63          	bltz	a0,8002003e <printint+0x28>
    x = -xx;
  else
    x = xx;
    80020028:	2501                	sext.w	a0,a0
    8002002a:	4881                	li	a7,0
    8002002c:	fd040713          	addi	a4,s0,-48

  i = 0;
    80020030:	4601                	li	a2,0
  do {
    buf[i++] = digits[x % base];
    80020032:	2581                	sext.w	a1,a1
    80020034:	0000b817          	auipc	a6,0xb
    80020038:	fcc80813          	addi	a6,a6,-52 # 8002b000 <etext>
    8002003c:	a039                	j	8002004a <printint+0x34>
    x = -xx;
    8002003e:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80020042:	4885                	li	a7,1
    x = -xx;
    80020044:	b7e5                	j	8002002c <printint+0x16>
  } while((x /= base) != 0);
    80020046:	853e                	mv	a0,a5
    buf[i++] = digits[x % base];
    80020048:	8636                	mv	a2,a3
    8002004a:	0016069b          	addiw	a3,a2,1
    8002004e:	02b577bb          	remuw	a5,a0,a1
    80020052:	1782                	slli	a5,a5,0x20
    80020054:	9381                	srli	a5,a5,0x20
    80020056:	97c2                	add	a5,a5,a6
    80020058:	0007c783          	lbu	a5,0(a5)
    8002005c:	00f70023          	sb	a5,0(a4)
    80020060:	0705                	addi	a4,a4,1
  } while((x /= base) != 0);
    80020062:	02b557bb          	divuw	a5,a0,a1
    80020066:	feb570e3          	bgeu	a0,a1,80020046 <printint+0x30>

  if(sign)
    8002006a:	00088b63          	beqz	a7,80020080 <printint+0x6a>
    buf[i++] = '-';
    8002006e:	fe040793          	addi	a5,s0,-32
    80020072:	96be                	add	a3,a3,a5
    80020074:	02d00793          	li	a5,45
    80020078:	fef68823          	sb	a5,-16(a3)
    8002007c:	0026069b          	addiw	a3,a2,2

  while(--i >= 0)
    80020080:	02d05763          	blez	a3,800200ae <printint+0x98>
    80020084:	fd040793          	addi	a5,s0,-48
    80020088:	00d784b3          	add	s1,a5,a3
    8002008c:	fff78913          	addi	s2,a5,-1
    80020090:	9936                	add	s2,s2,a3
    80020092:	36fd                	addiw	a3,a3,-1
    80020094:	1682                	slli	a3,a3,0x20
    80020096:	9281                	srli	a3,a3,0x20
    80020098:	40d90933          	sub	s2,s2,a3
    consputc(buf[i]);
    8002009c:	fff4c503          	lbu	a0,-1(s1)
    800200a0:	00007097          	auipc	ra,0x7
    800200a4:	df2080e7          	jalr	-526(ra) # 80026e92 <consputc>
    800200a8:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
    800200aa:	ff2499e3          	bne	s1,s2,8002009c <printint+0x86>
}
    800200ae:	70a2                	ld	ra,40(sp)
    800200b0:	7402                	ld	s0,32(sp)
    800200b2:	64e2                	ld	s1,24(sp)
    800200b4:	6942                	ld	s2,16(sp)
    800200b6:	6145                	addi	sp,sp,48
    800200b8:	8082                	ret

00000000800200ba <printstring>:
void printstring(const char* s) {
    800200ba:	1101                	addi	sp,sp,-32
    800200bc:	ec06                	sd	ra,24(sp)
    800200be:	e822                	sd	s0,16(sp)
    800200c0:	e426                	sd	s1,8(sp)
    800200c2:	1000                	addi	s0,sp,32
    800200c4:	84aa                	mv	s1,a0
    while (*s)
    800200c6:	00054503          	lbu	a0,0(a0)
    800200ca:	c909                	beqz	a0,800200dc <printstring+0x22>
        consputc(*s++);
    800200cc:	0485                	addi	s1,s1,1
    800200ce:	00007097          	auipc	ra,0x7
    800200d2:	dc4080e7          	jalr	-572(ra) # 80026e92 <consputc>
    while (*s)
    800200d6:	0004c503          	lbu	a0,0(s1)
    800200da:	f96d                	bnez	a0,800200cc <printstring+0x12>
}
    800200dc:	60e2                	ld	ra,24(sp)
    800200de:	6442                	ld	s0,16(sp)
    800200e0:	64a2                	ld	s1,8(sp)
    800200e2:	6105                	addi	sp,sp,32
    800200e4:	8082                	ret

00000000800200e6 <backtrace>:
  for(;;)
    ;
}

void backtrace()
{
    800200e6:	7179                	addi	sp,sp,-48
    800200e8:	f406                	sd	ra,40(sp)
    800200ea:	f022                	sd	s0,32(sp)
    800200ec:	ec26                	sd	s1,24(sp)
    800200ee:	e84a                	sd	s2,16(sp)
    800200f0:	e44e                	sd	s3,8(sp)
    800200f2:	1800                	addi	s0,sp,48

static inline uint64
r_fp()
{
  uint64 x;
  asm volatile("mv %0, s0" : "=r" (x) );
    800200f4:	8922                	mv	s2,s0
  uint64 *fp = (uint64 *)r_fp();
    800200f6:	84ca                	mv	s1,s2
  uint64 *bottom = (uint64 *)PGROUNDUP((uint64)fp);
    800200f8:	6785                	lui	a5,0x1
    800200fa:	17fd                	addi	a5,a5,-1
    800200fc:	993e                	add	s2,s2,a5
    800200fe:	77fd                	lui	a5,0xfffff
    80020100:	00f97933          	and	s2,s2,a5
  printf("backtrace:\n");
    80020104:	0000b517          	auipc	a0,0xb
    80020108:	f1450513          	addi	a0,a0,-236 # 8002b018 <etext+0x18>
    8002010c:	00000097          	auipc	ra,0x0
    80020110:	084080e7          	jalr	132(ra) # 80020190 <printf>
  while (fp < bottom) {
    80020114:	0324f263          	bgeu	s1,s2,80020138 <backtrace+0x52>
    uint64 ra = *(fp - 1);
    printf("%p\n", ra - 4);
    80020118:	0000b997          	auipc	s3,0xb
    8002011c:	40098993          	addi	s3,s3,1024 # 8002b518 <states.1756+0xb0>
    80020120:	ff84b583          	ld	a1,-8(s1)
    80020124:	15f1                	addi	a1,a1,-4
    80020126:	854e                	mv	a0,s3
    80020128:	00000097          	auipc	ra,0x0
    8002012c:	068080e7          	jalr	104(ra) # 80020190 <printf>
    fp = (uint64 *)*(fp - 2);
    80020130:	ff04b483          	ld	s1,-16(s1)
  while (fp < bottom) {
    80020134:	ff24e6e3          	bltu	s1,s2,80020120 <backtrace+0x3a>
  }
}
    80020138:	70a2                	ld	ra,40(sp)
    8002013a:	7402                	ld	s0,32(sp)
    8002013c:	64e2                	ld	s1,24(sp)
    8002013e:	6942                	ld	s2,16(sp)
    80020140:	69a2                	ld	s3,8(sp)
    80020142:	6145                	addi	sp,sp,48
    80020144:	8082                	ret

0000000080020146 <panic>:
{
    80020146:	1101                	addi	sp,sp,-32
    80020148:	ec06                	sd	ra,24(sp)
    8002014a:	e822                	sd	s0,16(sp)
    8002014c:	e426                	sd	s1,8(sp)
    8002014e:	1000                	addi	s0,sp,32
    80020150:	84aa                	mv	s1,a0
  printf("panic: ");
    80020152:	0000b517          	auipc	a0,0xb
    80020156:	ed650513          	addi	a0,a0,-298 # 8002b028 <etext+0x28>
    8002015a:	00000097          	auipc	ra,0x0
    8002015e:	036080e7          	jalr	54(ra) # 80020190 <printf>
  printf(s);
    80020162:	8526                	mv	a0,s1
    80020164:	00000097          	auipc	ra,0x0
    80020168:	02c080e7          	jalr	44(ra) # 80020190 <printf>
  printf("\n");
    8002016c:	0000c517          	auipc	a0,0xc
    80020170:	7bc50513          	addi	a0,a0,1980 # 8002c928 <syscalls+0x870>
    80020174:	00000097          	auipc	ra,0x0
    80020178:	01c080e7          	jalr	28(ra) # 80020190 <printf>
  backtrace();
    8002017c:	00000097          	auipc	ra,0x0
    80020180:	f6a080e7          	jalr	-150(ra) # 800200e6 <backtrace>
  panicked = 1; // freeze uart output from other CPUs
    80020184:	4785                	li	a5,1
    80020186:	00017717          	auipc	a4,0x17
    8002018a:	e8f72d23          	sw	a5,-358(a4) # 80037020 <panicked>
    ;
    8002018e:	a001                	j	8002018e <panic+0x48>

0000000080020190 <printf>:
{
    80020190:	7131                	addi	sp,sp,-192
    80020192:	fc86                	sd	ra,120(sp)
    80020194:	f8a2                	sd	s0,112(sp)
    80020196:	f4a6                	sd	s1,104(sp)
    80020198:	f0ca                	sd	s2,96(sp)
    8002019a:	ecce                	sd	s3,88(sp)
    8002019c:	e8d2                	sd	s4,80(sp)
    8002019e:	e4d6                	sd	s5,72(sp)
    800201a0:	e0da                	sd	s6,64(sp)
    800201a2:	fc5e                	sd	s7,56(sp)
    800201a4:	f862                	sd	s8,48(sp)
    800201a6:	f466                	sd	s9,40(sp)
    800201a8:	f06a                	sd	s10,32(sp)
    800201aa:	ec6e                	sd	s11,24(sp)
    800201ac:	0100                	addi	s0,sp,128
    800201ae:	8aaa                	mv	s5,a0
    800201b0:	e40c                	sd	a1,8(s0)
    800201b2:	e810                	sd	a2,16(s0)
    800201b4:	ec14                	sd	a3,24(s0)
    800201b6:	f018                	sd	a4,32(s0)
    800201b8:	f41c                	sd	a5,40(s0)
    800201ba:	03043823          	sd	a6,48(s0)
    800201be:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800201c2:	00017797          	auipc	a5,0x17
    800201c6:	e3e78793          	addi	a5,a5,-450 # 80037000 <boot_stack_top>
    800201ca:	0187ad83          	lw	s11,24(a5)
  if(locking)
    800201ce:	020d9b63          	bnez	s11,80020204 <printf+0x74>
  if (fmt == 0)
    800201d2:	020a8f63          	beqz	s5,80020210 <printf+0x80>
  va_start(ap, fmt);
    800201d6:	00840793          	addi	a5,s0,8
    800201da:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800201de:	000ac503          	lbu	a0,0(s5)
    800201e2:	16050063          	beqz	a0,80020342 <printf+0x1b2>
    800201e6:	4481                	li	s1,0
    if(c != '%'){
    800201e8:	02500a13          	li	s4,37
    switch(c){
    800201ec:	07000b13          	li	s6,112
  consputc('x');
    800201f0:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800201f2:	0000bb97          	auipc	s7,0xb
    800201f6:	e0eb8b93          	addi	s7,s7,-498 # 8002b000 <etext>
    switch(c){
    800201fa:	07300c93          	li	s9,115
    800201fe:	06400c13          	li	s8,100
    80020202:	a815                	j	80020236 <printf+0xa6>
    acquire(&pr.lock);
    80020204:	853e                	mv	a0,a5
    80020206:	00000097          	auipc	ra,0x0
    8002020a:	4ba080e7          	jalr	1210(ra) # 800206c0 <acquire>
    8002020e:	b7d1                	j	800201d2 <printf+0x42>
    panic("null fmt");
    80020210:	0000b517          	auipc	a0,0xb
    80020214:	e2850513          	addi	a0,a0,-472 # 8002b038 <etext+0x38>
    80020218:	00000097          	auipc	ra,0x0
    8002021c:	f2e080e7          	jalr	-210(ra) # 80020146 <panic>
      consputc(c);
    80020220:	00007097          	auipc	ra,0x7
    80020224:	c72080e7          	jalr	-910(ra) # 80026e92 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80020228:	2485                	addiw	s1,s1,1
    8002022a:	009a87b3          	add	a5,s5,s1
    8002022e:	0007c503          	lbu	a0,0(a5)
    80020232:	10050863          	beqz	a0,80020342 <printf+0x1b2>
    if(c != '%'){
    80020236:	ff4515e3          	bne	a0,s4,80020220 <printf+0x90>
    c = fmt[++i] & 0xff;
    8002023a:	2485                	addiw	s1,s1,1
    8002023c:	009a87b3          	add	a5,s5,s1
    80020240:	0007c783          	lbu	a5,0(a5)
    80020244:	0007891b          	sext.w	s2,a5
    if(c == 0)
    80020248:	0e090d63          	beqz	s2,80020342 <printf+0x1b2>
    switch(c){
    8002024c:	05678a63          	beq	a5,s6,800202a0 <printf+0x110>
    80020250:	02fb7663          	bgeu	s6,a5,8002027c <printf+0xec>
    80020254:	09978963          	beq	a5,s9,800202e6 <printf+0x156>
    80020258:	07800713          	li	a4,120
    8002025c:	0ce79863          	bne	a5,a4,8002032c <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    80020260:	f8843783          	ld	a5,-120(s0)
    80020264:	00878713          	addi	a4,a5,8
    80020268:	f8e43423          	sd	a4,-120(s0)
    8002026c:	4605                	li	a2,1
    8002026e:	85ea                	mv	a1,s10
    80020270:	4388                	lw	a0,0(a5)
    80020272:	00000097          	auipc	ra,0x0
    80020276:	da4080e7          	jalr	-604(ra) # 80020016 <printint>
      break;
    8002027a:	b77d                	j	80020228 <printf+0x98>
    switch(c){
    8002027c:	0b478263          	beq	a5,s4,80020320 <printf+0x190>
    80020280:	0b879663          	bne	a5,s8,8002032c <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    80020284:	f8843783          	ld	a5,-120(s0)
    80020288:	00878713          	addi	a4,a5,8
    8002028c:	f8e43423          	sd	a4,-120(s0)
    80020290:	4605                	li	a2,1
    80020292:	45a9                	li	a1,10
    80020294:	4388                	lw	a0,0(a5)
    80020296:	00000097          	auipc	ra,0x0
    8002029a:	d80080e7          	jalr	-640(ra) # 80020016 <printint>
      break;
    8002029e:	b769                	j	80020228 <printf+0x98>
      printptr(va_arg(ap, uint64));
    800202a0:	f8843783          	ld	a5,-120(s0)
    800202a4:	00878713          	addi	a4,a5,8
    800202a8:	f8e43423          	sd	a4,-120(s0)
    800202ac:	0007b983          	ld	s3,0(a5)
  consputc('0');
    800202b0:	03000513          	li	a0,48
    800202b4:	00007097          	auipc	ra,0x7
    800202b8:	bde080e7          	jalr	-1058(ra) # 80026e92 <consputc>
  consputc('x');
    800202bc:	07800513          	li	a0,120
    800202c0:	00007097          	auipc	ra,0x7
    800202c4:	bd2080e7          	jalr	-1070(ra) # 80026e92 <consputc>
    800202c8:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800202ca:	03c9d793          	srli	a5,s3,0x3c
    800202ce:	97de                	add	a5,a5,s7
    800202d0:	0007c503          	lbu	a0,0(a5)
    800202d4:	00007097          	auipc	ra,0x7
    800202d8:	bbe080e7          	jalr	-1090(ra) # 80026e92 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800202dc:	0992                	slli	s3,s3,0x4
    800202de:	397d                	addiw	s2,s2,-1
    800202e0:	fe0915e3          	bnez	s2,800202ca <printf+0x13a>
    800202e4:	b791                	j	80020228 <printf+0x98>
      if((s = va_arg(ap, char*)) == 0)
    800202e6:	f8843783          	ld	a5,-120(s0)
    800202ea:	00878713          	addi	a4,a5,8
    800202ee:	f8e43423          	sd	a4,-120(s0)
    800202f2:	0007b903          	ld	s2,0(a5)
    800202f6:	00090e63          	beqz	s2,80020312 <printf+0x182>
      for(; *s; s++)
    800202fa:	00094503          	lbu	a0,0(s2)
    800202fe:	d50d                	beqz	a0,80020228 <printf+0x98>
        consputc(*s);
    80020300:	00007097          	auipc	ra,0x7
    80020304:	b92080e7          	jalr	-1134(ra) # 80026e92 <consputc>
      for(; *s; s++)
    80020308:	0905                	addi	s2,s2,1
    8002030a:	00094503          	lbu	a0,0(s2)
    8002030e:	f96d                	bnez	a0,80020300 <printf+0x170>
    80020310:	bf21                	j	80020228 <printf+0x98>
        s = "(null)";
    80020312:	0000b917          	auipc	s2,0xb
    80020316:	d1e90913          	addi	s2,s2,-738 # 8002b030 <etext+0x30>
      for(; *s; s++)
    8002031a:	02800513          	li	a0,40
    8002031e:	b7cd                	j	80020300 <printf+0x170>
      consputc('%');
    80020320:	8552                	mv	a0,s4
    80020322:	00007097          	auipc	ra,0x7
    80020326:	b70080e7          	jalr	-1168(ra) # 80026e92 <consputc>
      break;
    8002032a:	bdfd                	j	80020228 <printf+0x98>
      consputc('%');
    8002032c:	8552                	mv	a0,s4
    8002032e:	00007097          	auipc	ra,0x7
    80020332:	b64080e7          	jalr	-1180(ra) # 80026e92 <consputc>
      consputc(c);
    80020336:	854a                	mv	a0,s2
    80020338:	00007097          	auipc	ra,0x7
    8002033c:	b5a080e7          	jalr	-1190(ra) # 80026e92 <consputc>
      break;
    80020340:	b5e5                	j	80020228 <printf+0x98>
  if(locking)
    80020342:	020d9163          	bnez	s11,80020364 <printf+0x1d4>
}
    80020346:	70e6                	ld	ra,120(sp)
    80020348:	7446                	ld	s0,112(sp)
    8002034a:	74a6                	ld	s1,104(sp)
    8002034c:	7906                	ld	s2,96(sp)
    8002034e:	69e6                	ld	s3,88(sp)
    80020350:	6a46                	ld	s4,80(sp)
    80020352:	6aa6                	ld	s5,72(sp)
    80020354:	6b06                	ld	s6,64(sp)
    80020356:	7be2                	ld	s7,56(sp)
    80020358:	7c42                	ld	s8,48(sp)
    8002035a:	7ca2                	ld	s9,40(sp)
    8002035c:	7d02                	ld	s10,32(sp)
    8002035e:	6de2                	ld	s11,24(sp)
    80020360:	6129                	addi	sp,sp,192
    80020362:	8082                	ret
    release(&pr.lock);
    80020364:	00017517          	auipc	a0,0x17
    80020368:	c9c50513          	addi	a0,a0,-868 # 80037000 <boot_stack_top>
    8002036c:	00000097          	auipc	ra,0x0
    80020370:	3a8080e7          	jalr	936(ra) # 80020714 <release>
}
    80020374:	bfc9                	j	80020346 <printf+0x1b6>

0000000080020376 <printfinit>:

void
printfinit(void)
{
    80020376:	1101                	addi	sp,sp,-32
    80020378:	ec06                	sd	ra,24(sp)
    8002037a:	e822                	sd	s0,16(sp)
    8002037c:	e426                	sd	s1,8(sp)
    8002037e:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80020380:	00017497          	auipc	s1,0x17
    80020384:	c8048493          	addi	s1,s1,-896 # 80037000 <boot_stack_top>
    80020388:	0000b597          	auipc	a1,0xb
    8002038c:	cc058593          	addi	a1,a1,-832 # 8002b048 <etext+0x48>
    80020390:	8526                	mv	a0,s1
    80020392:	00000097          	auipc	ra,0x0
    80020396:	2ea080e7          	jalr	746(ra) # 8002067c <initlock>
  pr.locking = 1;   // changed, used to be 1
    8002039a:	4785                	li	a5,1
    8002039c:	cc9c                	sw	a5,24(s1)
}
    8002039e:	60e2                	ld	ra,24(sp)
    800203a0:	6442                	ld	s0,16(sp)
    800203a2:	64a2                	ld	s1,8(sp)
    800203a4:	6105                	addi	sp,sp,32
    800203a6:	8082                	ret

00000000800203a8 <print_logo>:
    printf("  .'    \\_)    \\     /__)' \\  |  |  '------'   |  | |  |   |  .--'   |  |   |  |  |  | | `-' /\n");
    printf(" /  .'.  \\      \\   /    \\  `'  /              '  '-'  '-. |  `---.  |  |   |  | ('  '-'(_.-'\n");
    printf("'--'   '--'      `-'      `----'                `-----'--' `------'  `--'   `--'   `-----'\n");
}
#else
void print_logo() {
    800203a8:	1141                	addi	sp,sp,-16
    800203aa:	e406                	sd	ra,8(sp)
    800203ac:	e022                	sd	s0,0(sp)
    800203ae:	0800                	addi	s0,sp,16
    printf(" (`-')           (`-')                   <-.(`-')\n");
    800203b0:	0000b517          	auipc	a0,0xb
    800203b4:	ca050513          	addi	a0,a0,-864 # 8002b050 <etext+0x50>
    800203b8:	00000097          	auipc	ra,0x0
    800203bc:	dd8080e7          	jalr	-552(ra) # 80020190 <printf>
    printf(" (OO )_.->      _(OO )                    __( OO)\n");
    800203c0:	0000b517          	auipc	a0,0xb
    800203c4:	cc850513          	addi	a0,a0,-824 # 8002b088 <etext+0x88>
    800203c8:	00000097          	auipc	ra,0x0
    800203cc:	dc8080e7          	jalr	-568(ra) # 80020190 <printf>
    printf(" (_| \\_)--.,--.(_/,-.\\  ,--.    (`-')    '-'. ,--.  .----.   .--.   .----.\n");
    800203d0:	0000b517          	auipc	a0,0xb
    800203d4:	cf050513          	addi	a0,a0,-784 # 8002b0c0 <etext+0xc0>
    800203d8:	00000097          	auipc	ra,0x0
    800203dc:	db8080e7          	jalr	-584(ra) # 80020190 <printf>
    printf(" \\  `.'  / \\   \\ / (_/ /  .'    ( OO).-> |  .'   / \\_,-.  | /_  |  /  ..  \\\n");
    800203e0:	0000b517          	auipc	a0,0xb
    800203e4:	d3050513          	addi	a0,a0,-720 # 8002b110 <etext+0x110>
    800203e8:	00000097          	auipc	ra,0x0
    800203ec:	da8080e7          	jalr	-600(ra) # 80020190 <printf>
    printf("  \\    .')  \\   /   / .  / -.  (,------. |      /)    .' .'  |  | |  /  \\  .\n");
    800203f0:	0000b517          	auipc	a0,0xb
    800203f4:	d7050513          	addi	a0,a0,-656 # 8002b160 <etext+0x160>
    800203f8:	00000097          	auipc	ra,0x0
    800203fc:	d98080e7          	jalr	-616(ra) # 80020190 <printf>
    printf("  .'    \\  _ \\     /_)'  .-. \\  `------' |  .   '   .'  /_   |  | '  \\  /  '\n");
    80020400:	0000b517          	auipc	a0,0xb
    80020404:	db050513          	addi	a0,a0,-592 # 8002b1b0 <etext+0x1b0>
    80020408:	00000097          	auipc	ra,0x0
    8002040c:	d88080e7          	jalr	-632(ra) # 80020190 <printf>
    printf(" /  .'.  \\ \\-'\\   /   \\  `-' /           |  |\\   \\ |      |  |  |  \\  `'  /\n");
    80020410:	0000b517          	auipc	a0,0xb
    80020414:	df050513          	addi	a0,a0,-528 # 8002b200 <etext+0x200>
    80020418:	00000097          	auipc	ra,0x0
    8002041c:	d78080e7          	jalr	-648(ra) # 80020190 <printf>
    printf("`--'   '--'    `-'     `----'            `--' '--' `------'  `--'   `---''\n");
    80020420:	0000b517          	auipc	a0,0xb
    80020424:	e3050513          	addi	a0,a0,-464 # 8002b250 <etext+0x250>
    80020428:	00000097          	auipc	ra,0x0
    8002042c:	d68080e7          	jalr	-664(ra) # 80020190 <printf>
}
    80020430:	60a2                	ld	ra,8(sp)
    80020432:	6402                	ld	s0,0(sp)
    80020434:	0141                	addi	sp,sp,16
    80020436:	8082                	ret

0000000080020438 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80020438:	1101                	addi	sp,sp,-32
    8002043a:	ec06                	sd	ra,24(sp)
    8002043c:	e822                	sd	s0,16(sp)
    8002043e:	e426                	sd	s1,8(sp)
    80020440:	e04a                	sd	s2,0(sp)
    80020442:	1000                	addi	s0,sp,32
  struct run *r;
  
  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < kernel_end || (uint64)pa >= PHYSTOP)
    80020444:	03451793          	slli	a5,a0,0x34
    80020448:	e3ad                	bnez	a5,800204aa <kfree+0x72>
    8002044a:	84aa                	mv	s1,a0
    8002044c:	00026797          	auipc	a5,0x26
    80020450:	bb478793          	addi	a5,a5,-1100 # 80046000 <kernel_end>
    80020454:	04f56b63          	bltu	a0,a5,800204aa <kfree+0x72>
    80020458:	40300793          	li	a5,1027
    8002045c:	07d6                	slli	a5,a5,0x15
    8002045e:	04f57663          	bgeu	a0,a5,800204aa <kfree+0x72>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80020462:	6605                	lui	a2,0x1
    80020464:	4585                	li	a1,1
    80020466:	00000097          	auipc	ra,0x0
    8002046a:	2f6080e7          	jalr	758(ra) # 8002075c <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    8002046e:	00017917          	auipc	s2,0x17
    80020472:	bba90913          	addi	s2,s2,-1094 # 80037028 <kmem>
    80020476:	854a                	mv	a0,s2
    80020478:	00000097          	auipc	ra,0x0
    8002047c:	248080e7          	jalr	584(ra) # 800206c0 <acquire>
  r->next = kmem.freelist;
    80020480:	01893783          	ld	a5,24(s2)
    80020484:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80020486:	00993c23          	sd	s1,24(s2)
  kmem.npage++;
    8002048a:	02093783          	ld	a5,32(s2)
    8002048e:	0785                	addi	a5,a5,1
    80020490:	02f93023          	sd	a5,32(s2)
  release(&kmem.lock);
    80020494:	854a                	mv	a0,s2
    80020496:	00000097          	auipc	ra,0x0
    8002049a:	27e080e7          	jalr	638(ra) # 80020714 <release>
}
    8002049e:	60e2                	ld	ra,24(sp)
    800204a0:	6442                	ld	s0,16(sp)
    800204a2:	64a2                	ld	s1,8(sp)
    800204a4:	6902                	ld	s2,0(sp)
    800204a6:	6105                	addi	sp,sp,32
    800204a8:	8082                	ret
    panic("kfree");
    800204aa:	0000b517          	auipc	a0,0xb
    800204ae:	df650513          	addi	a0,a0,-522 # 8002b2a0 <etext+0x2a0>
    800204b2:	00000097          	auipc	ra,0x0
    800204b6:	c94080e7          	jalr	-876(ra) # 80020146 <panic>

00000000800204ba <freerange>:
{
    800204ba:	7179                	addi	sp,sp,-48
    800204bc:	f406                	sd	ra,40(sp)
    800204be:	f022                	sd	s0,32(sp)
    800204c0:	ec26                	sd	s1,24(sp)
    800204c2:	e84a                	sd	s2,16(sp)
    800204c4:	e44e                	sd	s3,8(sp)
    800204c6:	e052                	sd	s4,0(sp)
    800204c8:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800204ca:	6705                	lui	a4,0x1
    800204cc:	fff70793          	addi	a5,a4,-1 # fff <BASE_ADDRESS-0x8001f001>
    800204d0:	00f504b3          	add	s1,a0,a5
    800204d4:	77fd                	lui	a5,0xfffff
    800204d6:	8cfd                	and	s1,s1,a5
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800204d8:	94ba                	add	s1,s1,a4
    800204da:	0095ee63          	bltu	a1,s1,800204f6 <freerange+0x3c>
    800204de:	892e                	mv	s2,a1
    kfree(p);
    800204e0:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800204e2:	6985                	lui	s3,0x1
    kfree(p);
    800204e4:	01448533          	add	a0,s1,s4
    800204e8:	00000097          	auipc	ra,0x0
    800204ec:	f50080e7          	jalr	-176(ra) # 80020438 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800204f0:	94ce                	add	s1,s1,s3
    800204f2:	fe9979e3          	bgeu	s2,s1,800204e4 <freerange+0x2a>
}
    800204f6:	70a2                	ld	ra,40(sp)
    800204f8:	7402                	ld	s0,32(sp)
    800204fa:	64e2                	ld	s1,24(sp)
    800204fc:	6942                	ld	s2,16(sp)
    800204fe:	69a2                	ld	s3,8(sp)
    80020500:	6a02                	ld	s4,0(sp)
    80020502:	6145                	addi	sp,sp,48
    80020504:	8082                	ret

0000000080020506 <kinit>:
{
    80020506:	1101                	addi	sp,sp,-32
    80020508:	ec06                	sd	ra,24(sp)
    8002050a:	e822                	sd	s0,16(sp)
    8002050c:	e426                	sd	s1,8(sp)
    8002050e:	1000                	addi	s0,sp,32
  initlock(&kmem.lock, "kmem");
    80020510:	00017497          	auipc	s1,0x17
    80020514:	b1848493          	addi	s1,s1,-1256 # 80037028 <kmem>
    80020518:	0000b597          	auipc	a1,0xb
    8002051c:	d9058593          	addi	a1,a1,-624 # 8002b2a8 <etext+0x2a8>
    80020520:	8526                	mv	a0,s1
    80020522:	00000097          	auipc	ra,0x0
    80020526:	15a080e7          	jalr	346(ra) # 8002067c <initlock>
  kmem.freelist = 0;
    8002052a:	0004bc23          	sd	zero,24(s1)
  kmem.npage = 0;
    8002052e:	0204b023          	sd	zero,32(s1)
  freerange(kernel_end, (void*)PHYSTOP);
    80020532:	40300593          	li	a1,1027
    80020536:	05d6                	slli	a1,a1,0x15
    80020538:	00026517          	auipc	a0,0x26
    8002053c:	ac850513          	addi	a0,a0,-1336 # 80046000 <kernel_end>
    80020540:	00000097          	auipc	ra,0x0
    80020544:	f7a080e7          	jalr	-134(ra) # 800204ba <freerange>
}
    80020548:	60e2                	ld	ra,24(sp)
    8002054a:	6442                	ld	s0,16(sp)
    8002054c:	64a2                	ld	s1,8(sp)
    8002054e:	6105                	addi	sp,sp,32
    80020550:	8082                	ret

0000000080020552 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80020552:	1101                	addi	sp,sp,-32
    80020554:	ec06                	sd	ra,24(sp)
    80020556:	e822                	sd	s0,16(sp)
    80020558:	e426                	sd	s1,8(sp)
    8002055a:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    8002055c:	00017497          	auipc	s1,0x17
    80020560:	acc48493          	addi	s1,s1,-1332 # 80037028 <kmem>
    80020564:	8526                	mv	a0,s1
    80020566:	00000097          	auipc	ra,0x0
    8002056a:	15a080e7          	jalr	346(ra) # 800206c0 <acquire>
  r = kmem.freelist;
    8002056e:	6c84                	ld	s1,24(s1)
  if(r) {
    80020570:	c89d                	beqz	s1,800205a6 <kalloc+0x54>
    kmem.freelist = r->next;
    80020572:	609c                	ld	a5,0(s1)
    80020574:	00017517          	auipc	a0,0x17
    80020578:	ab450513          	addi	a0,a0,-1356 # 80037028 <kmem>
    8002057c:	ed1c                	sd	a5,24(a0)
    kmem.npage--;
    8002057e:	711c                	ld	a5,32(a0)
    80020580:	17fd                	addi	a5,a5,-1
    80020582:	f11c                	sd	a5,32(a0)
  }
  release(&kmem.lock);
    80020584:	00000097          	auipc	ra,0x0
    80020588:	190080e7          	jalr	400(ra) # 80020714 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8002058c:	6605                	lui	a2,0x1
    8002058e:	4595                	li	a1,5
    80020590:	8526                	mv	a0,s1
    80020592:	00000097          	auipc	ra,0x0
    80020596:	1ca080e7          	jalr	458(ra) # 8002075c <memset>
  return (void*)r;
}
    8002059a:	8526                	mv	a0,s1
    8002059c:	60e2                	ld	ra,24(sp)
    8002059e:	6442                	ld	s0,16(sp)
    800205a0:	64a2                	ld	s1,8(sp)
    800205a2:	6105                	addi	sp,sp,32
    800205a4:	8082                	ret
  release(&kmem.lock);
    800205a6:	00017517          	auipc	a0,0x17
    800205aa:	a8250513          	addi	a0,a0,-1406 # 80037028 <kmem>
    800205ae:	00000097          	auipc	ra,0x0
    800205b2:	166080e7          	jalr	358(ra) # 80020714 <release>
  if(r)
    800205b6:	b7d5                	j	8002059a <kalloc+0x48>

00000000800205b8 <freemem_amount>:

uint64
freemem_amount(void)
{
    800205b8:	1141                	addi	sp,sp,-16
    800205ba:	e422                	sd	s0,8(sp)
    800205bc:	0800                	addi	s0,sp,16
  return kmem.npage << PGSHIFT;
    800205be:	00017797          	auipc	a5,0x17
    800205c2:	a6a78793          	addi	a5,a5,-1430 # 80037028 <kmem>
    800205c6:	7388                	ld	a0,32(a5)
}
    800205c8:	0532                	slli	a0,a0,0xc
    800205ca:	6422                	ld	s0,8(sp)
    800205cc:	0141                	addi	sp,sp,16
    800205ce:	8082                	ret

00000000800205d0 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800205d0:	1101                	addi	sp,sp,-32
    800205d2:	ec06                	sd	ra,24(sp)
    800205d4:	e822                	sd	s0,16(sp)
    800205d6:	e426                	sd	s1,8(sp)
    800205d8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800205da:	100024f3          	csrr	s1,sstatus
    800205de:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800205e2:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800205e4:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  //printf("\e[32mpush_off()\e[0m: cpuid(): %d\n", cpuid());
  if(mycpu()->noff == 0)
    800205e8:	00001097          	auipc	ra,0x1
    800205ec:	57e080e7          	jalr	1406(ra) # 80021b66 <mycpu>
    800205f0:	5d3c                	lw	a5,120(a0)
    800205f2:	cf89                	beqz	a5,8002060c <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800205f4:	00001097          	auipc	ra,0x1
    800205f8:	572080e7          	jalr	1394(ra) # 80021b66 <mycpu>
    800205fc:	5d3c                	lw	a5,120(a0)
    800205fe:	2785                	addiw	a5,a5,1
    80020600:	dd3c                	sw	a5,120(a0)
}
    80020602:	60e2                	ld	ra,24(sp)
    80020604:	6442                	ld	s0,16(sp)
    80020606:	64a2                	ld	s1,8(sp)
    80020608:	6105                	addi	sp,sp,32
    8002060a:	8082                	ret
    mycpu()->intena = old;
    8002060c:	00001097          	auipc	ra,0x1
    80020610:	55a080e7          	jalr	1370(ra) # 80021b66 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80020614:	8085                	srli	s1,s1,0x1
    80020616:	8885                	andi	s1,s1,1
    80020618:	dd64                	sw	s1,124(a0)
    8002061a:	bfe9                	j	800205f4 <push_off+0x24>

000000008002061c <pop_off>:

void
pop_off(void)
{
    8002061c:	1141                	addi	sp,sp,-16
    8002061e:	e406                	sd	ra,8(sp)
    80020620:	e022                	sd	s0,0(sp)
    80020622:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80020624:	00001097          	auipc	ra,0x1
    80020628:	542080e7          	jalr	1346(ra) # 80021b66 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002062c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80020630:	8b89                	andi	a5,a5,2

  //printf("\e[31mpop_off()\e[0m: cpuid(): %d\n", cpuid());
  if(intr_get())
    80020632:	e78d                	bnez	a5,8002065c <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1) {
    80020634:	5d3c                	lw	a5,120(a0)
    80020636:	02f05b63          	blez	a5,8002066c <pop_off+0x50>
    //printf("c->noff = %d\n", c->noff);
    panic("pop_off");
  }
  //printf("c->noff: %d\n", c->noff);
  //printf("c: %x\n", c);
  c->noff -= 1;
    8002063a:	37fd                	addiw	a5,a5,-1
    8002063c:	0007871b          	sext.w	a4,a5
    80020640:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80020642:	eb09                	bnez	a4,80020654 <pop_off+0x38>
    80020644:	5d7c                	lw	a5,124(a0)
    80020646:	c799                	beqz	a5,80020654 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80020648:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8002064c:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80020650:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80020654:	60a2                	ld	ra,8(sp)
    80020656:	6402                	ld	s0,0(sp)
    80020658:	0141                	addi	sp,sp,16
    8002065a:	8082                	ret
    panic("pop_off - interruptible");
    8002065c:	0000b517          	auipc	a0,0xb
    80020660:	c5450513          	addi	a0,a0,-940 # 8002b2b0 <etext+0x2b0>
    80020664:	00000097          	auipc	ra,0x0
    80020668:	ae2080e7          	jalr	-1310(ra) # 80020146 <panic>
    panic("pop_off");
    8002066c:	0000b517          	auipc	a0,0xb
    80020670:	c5c50513          	addi	a0,a0,-932 # 8002b2c8 <etext+0x2c8>
    80020674:	00000097          	auipc	ra,0x0
    80020678:	ad2080e7          	jalr	-1326(ra) # 80020146 <panic>

000000008002067c <initlock>:
#include "include/intr.h"
#include "include/printf.h"

void
initlock(struct spinlock *lk, char *name)
{
    8002067c:	1141                	addi	sp,sp,-16
    8002067e:	e422                	sd	s0,8(sp)
    80020680:	0800                	addi	s0,sp,16
  lk->name = name;
    80020682:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80020684:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80020688:	00053823          	sd	zero,16(a0)
}
    8002068c:	6422                	ld	s0,8(sp)
    8002068e:	0141                	addi	sp,sp,16
    80020690:	8082                	ret

0000000080020692 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80020692:	411c                	lw	a5,0(a0)
    80020694:	e399                	bnez	a5,8002069a <holding+0x8>
    80020696:	4501                	li	a0,0
  return r;
}
    80020698:	8082                	ret
{
    8002069a:	1101                	addi	sp,sp,-32
    8002069c:	ec06                	sd	ra,24(sp)
    8002069e:	e822                	sd	s0,16(sp)
    800206a0:	e426                	sd	s1,8(sp)
    800206a2:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800206a4:	6904                	ld	s1,16(a0)
    800206a6:	00001097          	auipc	ra,0x1
    800206aa:	4c0080e7          	jalr	1216(ra) # 80021b66 <mycpu>
    800206ae:	40a48533          	sub	a0,s1,a0
    800206b2:	00153513          	seqz	a0,a0
}
    800206b6:	60e2                	ld	ra,24(sp)
    800206b8:	6442                	ld	s0,16(sp)
    800206ba:	64a2                	ld	s1,8(sp)
    800206bc:	6105                	addi	sp,sp,32
    800206be:	8082                	ret

00000000800206c0 <acquire>:
{
    800206c0:	1101                	addi	sp,sp,-32
    800206c2:	ec06                	sd	ra,24(sp)
    800206c4:	e822                	sd	s0,16(sp)
    800206c6:	e426                	sd	s1,8(sp)
    800206c8:	1000                	addi	s0,sp,32
    800206ca:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    800206cc:	00000097          	auipc	ra,0x0
    800206d0:	f04080e7          	jalr	-252(ra) # 800205d0 <push_off>
  if(holding(lk))
    800206d4:	8526                	mv	a0,s1
    800206d6:	00000097          	auipc	ra,0x0
    800206da:	fbc080e7          	jalr	-68(ra) # 80020692 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800206de:	4705                	li	a4,1
  if(holding(lk))
    800206e0:	e115                	bnez	a0,80020704 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800206e2:	87ba                	mv	a5,a4
    800206e4:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800206e8:	2781                	sext.w	a5,a5
    800206ea:	ffe5                	bnez	a5,800206e2 <acquire+0x22>
  __sync_synchronize();
    800206ec:	0ff0000f          	fence
  lk->cpu = mycpu();
    800206f0:	00001097          	auipc	ra,0x1
    800206f4:	476080e7          	jalr	1142(ra) # 80021b66 <mycpu>
    800206f8:	e888                	sd	a0,16(s1)
}
    800206fa:	60e2                	ld	ra,24(sp)
    800206fc:	6442                	ld	s0,16(sp)
    800206fe:	64a2                	ld	s1,8(sp)
    80020700:	6105                	addi	sp,sp,32
    80020702:	8082                	ret
    panic("acquire");
    80020704:	0000b517          	auipc	a0,0xb
    80020708:	bcc50513          	addi	a0,a0,-1076 # 8002b2d0 <etext+0x2d0>
    8002070c:	00000097          	auipc	ra,0x0
    80020710:	a3a080e7          	jalr	-1478(ra) # 80020146 <panic>

0000000080020714 <release>:
{
    80020714:	1101                	addi	sp,sp,-32
    80020716:	ec06                	sd	ra,24(sp)
    80020718:	e822                	sd	s0,16(sp)
    8002071a:	e426                	sd	s1,8(sp)
    8002071c:	1000                	addi	s0,sp,32
    8002071e:	84aa                	mv	s1,a0
  if(!holding(lk))
    80020720:	00000097          	auipc	ra,0x0
    80020724:	f72080e7          	jalr	-142(ra) # 80020692 <holding>
    80020728:	c115                	beqz	a0,8002074c <release+0x38>
  lk->cpu = 0;
    8002072a:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    8002072e:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80020732:	0f50000f          	fence	iorw,ow
    80020736:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    8002073a:	00000097          	auipc	ra,0x0
    8002073e:	ee2080e7          	jalr	-286(ra) # 8002061c <pop_off>
}
    80020742:	60e2                	ld	ra,24(sp)
    80020744:	6442                	ld	s0,16(sp)
    80020746:	64a2                	ld	s1,8(sp)
    80020748:	6105                	addi	sp,sp,32
    8002074a:	8082                	ret
    panic("release");
    8002074c:	0000b517          	auipc	a0,0xb
    80020750:	b8c50513          	addi	a0,a0,-1140 # 8002b2d8 <etext+0x2d8>
    80020754:	00000097          	auipc	ra,0x0
    80020758:	9f2080e7          	jalr	-1550(ra) # 80020146 <panic>

000000008002075c <memset>:
#include "include/types.h"

void*
memset(void *dst, int c, uint n)
{
    8002075c:	1141                	addi	sp,sp,-16
    8002075e:	e422                	sd	s0,8(sp)
    80020760:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80020762:	ce09                	beqz	a2,8002077c <memset+0x20>
    80020764:	87aa                	mv	a5,a0
    80020766:	fff6071b          	addiw	a4,a2,-1
    8002076a:	1702                	slli	a4,a4,0x20
    8002076c:	9301                	srli	a4,a4,0x20
    8002076e:	0705                	addi	a4,a4,1
    80020770:	972a                	add	a4,a4,a0
    cdst[i] = c;
    80020772:	00b78023          	sb	a1,0(a5)
    80020776:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
    80020778:	fee79de3          	bne	a5,a4,80020772 <memset+0x16>
  }
  return dst;
}
    8002077c:	6422                	ld	s0,8(sp)
    8002077e:	0141                	addi	sp,sp,16
    80020780:	8082                	ret

0000000080020782 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80020782:	1141                	addi	sp,sp,-16
    80020784:	e422                	sd	s0,8(sp)
    80020786:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80020788:	ce15                	beqz	a2,800207c4 <memcmp+0x42>
    8002078a:	fff6069b          	addiw	a3,a2,-1
    if(*s1 != *s2)
    8002078e:	00054783          	lbu	a5,0(a0)
    80020792:	0005c703          	lbu	a4,0(a1)
    80020796:	02e79063          	bne	a5,a4,800207b6 <memcmp+0x34>
    8002079a:	1682                	slli	a3,a3,0x20
    8002079c:	9281                	srli	a3,a3,0x20
    8002079e:	0685                	addi	a3,a3,1
    800207a0:	96aa                	add	a3,a3,a0
      return *s1 - *s2;
    s1++, s2++;
    800207a2:	0505                	addi	a0,a0,1
    800207a4:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800207a6:	00d50d63          	beq	a0,a3,800207c0 <memcmp+0x3e>
    if(*s1 != *s2)
    800207aa:	00054783          	lbu	a5,0(a0)
    800207ae:	0005c703          	lbu	a4,0(a1)
    800207b2:	fee788e3          	beq	a5,a4,800207a2 <memcmp+0x20>
      return *s1 - *s2;
    800207b6:	40e7853b          	subw	a0,a5,a4
  }

  return 0;
}
    800207ba:	6422                	ld	s0,8(sp)
    800207bc:	0141                	addi	sp,sp,16
    800207be:	8082                	ret
  return 0;
    800207c0:	4501                	li	a0,0
    800207c2:	bfe5                	j	800207ba <memcmp+0x38>
    800207c4:	4501                	li	a0,0
    800207c6:	bfd5                	j	800207ba <memcmp+0x38>

00000000800207c8 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800207c8:	1141                	addi	sp,sp,-16
    800207ca:	e422                	sd	s0,8(sp)
    800207cc:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
    800207ce:	02a5e563          	bltu	a1,a0,800207f8 <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800207d2:	fff6069b          	addiw	a3,a2,-1
    800207d6:	ce11                	beqz	a2,800207f2 <memmove+0x2a>
    800207d8:	1682                	slli	a3,a3,0x20
    800207da:	9281                	srli	a3,a3,0x20
    800207dc:	0685                	addi	a3,a3,1
    800207de:	96ae                	add	a3,a3,a1
    800207e0:	87aa                	mv	a5,a0
      *d++ = *s++;
    800207e2:	0585                	addi	a1,a1,1
    800207e4:	0785                	addi	a5,a5,1
    800207e6:	fff5c703          	lbu	a4,-1(a1)
    800207ea:	fee78fa3          	sb	a4,-1(a5)
    while(n-- > 0)
    800207ee:	fed59ae3          	bne	a1,a3,800207e2 <memmove+0x1a>

  return dst;
}
    800207f2:	6422                	ld	s0,8(sp)
    800207f4:	0141                	addi	sp,sp,16
    800207f6:	8082                	ret
  if(s < d && s + n > d){
    800207f8:	02061713          	slli	a4,a2,0x20
    800207fc:	9301                	srli	a4,a4,0x20
    800207fe:	00e587b3          	add	a5,a1,a4
    80020802:	fcf578e3          	bgeu	a0,a5,800207d2 <memmove+0xa>
    d += n;
    80020806:	972a                	add	a4,a4,a0
    while(n-- > 0)
    80020808:	fff6069b          	addiw	a3,a2,-1
    8002080c:	d27d                	beqz	a2,800207f2 <memmove+0x2a>
    8002080e:	02069613          	slli	a2,a3,0x20
    80020812:	9201                	srli	a2,a2,0x20
    80020814:	fff64613          	not	a2,a2
    80020818:	963e                	add	a2,a2,a5
      *--d = *--s;
    8002081a:	17fd                	addi	a5,a5,-1
    8002081c:	177d                	addi	a4,a4,-1
    8002081e:	0007c683          	lbu	a3,0(a5)
    80020822:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    80020826:	fef61ae3          	bne	a2,a5,8002081a <memmove+0x52>
    8002082a:	b7e1                	j	800207f2 <memmove+0x2a>

000000008002082c <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    8002082c:	1141                	addi	sp,sp,-16
    8002082e:	e406                	sd	ra,8(sp)
    80020830:	e022                	sd	s0,0(sp)
    80020832:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80020834:	00000097          	auipc	ra,0x0
    80020838:	f94080e7          	jalr	-108(ra) # 800207c8 <memmove>
}
    8002083c:	60a2                	ld	ra,8(sp)
    8002083e:	6402                	ld	s0,0(sp)
    80020840:	0141                	addi	sp,sp,16
    80020842:	8082                	ret

0000000080020844 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80020844:	1141                	addi	sp,sp,-16
    80020846:	e422                	sd	s0,8(sp)
    80020848:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8002084a:	c229                	beqz	a2,8002088c <strncmp+0x48>
    8002084c:	00054783          	lbu	a5,0(a0)
    80020850:	c795                	beqz	a5,8002087c <strncmp+0x38>
    80020852:	0005c703          	lbu	a4,0(a1)
    80020856:	02f71363          	bne	a4,a5,8002087c <strncmp+0x38>
    8002085a:	fff6071b          	addiw	a4,a2,-1
    8002085e:	1702                	slli	a4,a4,0x20
    80020860:	9301                	srli	a4,a4,0x20
    80020862:	0705                	addi	a4,a4,1
    80020864:	972a                	add	a4,a4,a0
    n--, p++, q++;
    80020866:	0505                	addi	a0,a0,1
    80020868:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8002086a:	02e50363          	beq	a0,a4,80020890 <strncmp+0x4c>
    8002086e:	00054783          	lbu	a5,0(a0)
    80020872:	c789                	beqz	a5,8002087c <strncmp+0x38>
    80020874:	0005c683          	lbu	a3,0(a1)
    80020878:	fef687e3          	beq	a3,a5,80020866 <strncmp+0x22>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
    8002087c:	00054503          	lbu	a0,0(a0)
    80020880:	0005c783          	lbu	a5,0(a1)
    80020884:	9d1d                	subw	a0,a0,a5
}
    80020886:	6422                	ld	s0,8(sp)
    80020888:	0141                	addi	sp,sp,16
    8002088a:	8082                	ret
    return 0;
    8002088c:	4501                	li	a0,0
    8002088e:	bfe5                	j	80020886 <strncmp+0x42>
    80020890:	4501                	li	a0,0
    80020892:	bfd5                	j	80020886 <strncmp+0x42>

0000000080020894 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80020894:	1141                	addi	sp,sp,-16
    80020896:	e422                	sd	s0,8(sp)
    80020898:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    8002089a:	872a                	mv	a4,a0
    8002089c:	a011                	j	800208a0 <strncpy+0xc>
    8002089e:	8642                	mv	a2,a6
    800208a0:	fff6081b          	addiw	a6,a2,-1
    800208a4:	00c05963          	blez	a2,800208b6 <strncpy+0x22>
    800208a8:	0705                	addi	a4,a4,1
    800208aa:	0005c783          	lbu	a5,0(a1)
    800208ae:	fef70fa3          	sb	a5,-1(a4)
    800208b2:	0585                	addi	a1,a1,1
    800208b4:	f7ed                	bnez	a5,8002089e <strncpy+0xa>
    ;
  while(n-- > 0)
    800208b6:	86ba                	mv	a3,a4
    800208b8:	01005b63          	blez	a6,800208ce <strncpy+0x3a>
    *s++ = 0;
    800208bc:	0685                	addi	a3,a3,1
    800208be:	fe068fa3          	sb	zero,-1(a3)
    800208c2:	fff6c793          	not	a5,a3
    800208c6:	9fb9                	addw	a5,a5,a4
  while(n-- > 0)
    800208c8:	9fb1                	addw	a5,a5,a2
    800208ca:	fef049e3          	bgtz	a5,800208bc <strncpy+0x28>
  return os;
}
    800208ce:	6422                	ld	s0,8(sp)
    800208d0:	0141                	addi	sp,sp,16
    800208d2:	8082                	ret

00000000800208d4 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800208d4:	1141                	addi	sp,sp,-16
    800208d6:	e422                	sd	s0,8(sp)
    800208d8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800208da:	02c05363          	blez	a2,80020900 <safestrcpy+0x2c>
    800208de:	fff6069b          	addiw	a3,a2,-1
    800208e2:	1682                	slli	a3,a3,0x20
    800208e4:	9281                	srli	a3,a3,0x20
    800208e6:	96ae                	add	a3,a3,a1
    800208e8:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800208ea:	00d58963          	beq	a1,a3,800208fc <safestrcpy+0x28>
    800208ee:	0585                	addi	a1,a1,1
    800208f0:	0785                	addi	a5,a5,1
    800208f2:	fff5c703          	lbu	a4,-1(a1)
    800208f6:	fee78fa3          	sb	a4,-1(a5)
    800208fa:	fb65                	bnez	a4,800208ea <safestrcpy+0x16>
    ;
  *s = 0;
    800208fc:	00078023          	sb	zero,0(a5)
  return os;
}
    80020900:	6422                	ld	s0,8(sp)
    80020902:	0141                	addi	sp,sp,16
    80020904:	8082                	ret

0000000080020906 <strlen>:

int
strlen(const char *s)
{
    80020906:	1141                	addi	sp,sp,-16
    80020908:	e422                	sd	s0,8(sp)
    8002090a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    8002090c:	00054783          	lbu	a5,0(a0)
    80020910:	cf91                	beqz	a5,8002092c <strlen+0x26>
    80020912:	0505                	addi	a0,a0,1
    80020914:	87aa                	mv	a5,a0
    80020916:	4685                	li	a3,1
    80020918:	9e89                	subw	a3,a3,a0
    ;
    8002091a:	00f6853b          	addw	a0,a3,a5
    8002091e:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
    80020920:	fff7c703          	lbu	a4,-1(a5)
    80020924:	fb7d                	bnez	a4,8002091a <strlen+0x14>
  return n;
}
    80020926:	6422                	ld	s0,8(sp)
    80020928:	0141                	addi	sp,sp,16
    8002092a:	8082                	ret
  for(n = 0; s[n]; n++)
    8002092c:	4501                	li	a0,0
    8002092e:	bfe5                	j	80020926 <strlen+0x20>

0000000080020930 <wnstr>:

// convert uchar string into wide char string 
void wnstr(wchar *dst, char const *src, int len) {
    80020930:	1141                	addi	sp,sp,-16
    80020932:	e422                	sd	s0,8(sp)
    80020934:	0800                	addi	s0,sp,16
  while (len -- && *src) {
    80020936:	ca15                	beqz	a2,8002096a <wnstr+0x3a>
    80020938:	0005c783          	lbu	a5,0(a1)
    8002093c:	cb8d                	beqz	a5,8002096e <wnstr+0x3e>
    8002093e:	fff6071b          	addiw	a4,a2,-1
    80020942:	1702                	slli	a4,a4,0x20
    80020944:	9301                	srli	a4,a4,0x20
    80020946:	0705                	addi	a4,a4,1
    80020948:	0706                	slli	a4,a4,0x1
    8002094a:	972a                	add	a4,a4,a0
    *(uchar*)dst = *src++;
    8002094c:	0585                	addi	a1,a1,1
    8002094e:	00f50023          	sb	a5,0(a0)
    dst ++;
    80020952:	0509                	addi	a0,a0,2
  while (len -- && *src) {
    80020954:	00e50663          	beq	a0,a4,80020960 <wnstr+0x30>
    80020958:	0005c783          	lbu	a5,0(a1)
    8002095c:	fbe5                	bnez	a5,8002094c <wnstr+0x1c>
    dst ++;
    8002095e:	872a                	mv	a4,a0
  }

  *dst = 0;
    80020960:	00071023          	sh	zero,0(a4)
}
    80020964:	6422                	ld	s0,8(sp)
    80020966:	0141                	addi	sp,sp,16
    80020968:	8082                	ret
  while (len -- && *src) {
    8002096a:	872a                	mv	a4,a0
    8002096c:	bfd5                	j	80020960 <wnstr+0x30>
    8002096e:	872a                	mv	a4,a0
    80020970:	bfc5                	j	80020960 <wnstr+0x30>

0000000080020972 <snstr>:

// convert wide char string into uchar string 
void snstr(char *dst, wchar const *src, int len) {
    80020972:	1141                	addi	sp,sp,-16
    80020974:	e422                	sd	s0,8(sp)
    80020976:	0800                	addi	s0,sp,16
  while (len -- && *src) {
    80020978:	c229                	beqz	a2,800209ba <snstr+0x48>
    8002097a:	fff6071b          	addiw	a4,a2,-1
    8002097e:	0005d783          	lhu	a5,0(a1)
    80020982:	cf99                	beqz	a5,800209a0 <snstr+0x2e>
    80020984:	3679                	addiw	a2,a2,-2
    80020986:	56fd                	li	a3,-1
    *dst++ = (uchar)(*src & 0xff);
    80020988:	0505                	addi	a0,a0,1
    8002098a:	fef50fa3          	sb	a5,-1(a0)
    src ++;
    8002098e:	0589                	addi	a1,a1,2
  while (len -- && *src) {
    80020990:	0006071b          	sext.w	a4,a2
    80020994:	02d60363          	beq	a2,a3,800209ba <snstr+0x48>
    80020998:	0005d783          	lhu	a5,0(a1)
    8002099c:	367d                	addiw	a2,a2,-1
    8002099e:	f7ed                	bnez	a5,80020988 <snstr+0x16>
  }
  while(len-- > 0)
    800209a0:	00e05d63          	blez	a4,800209ba <snstr+0x48>
    800209a4:	fff7079b          	addiw	a5,a4,-1
    800209a8:	1782                	slli	a5,a5,0x20
    800209aa:	9381                	srli	a5,a5,0x20
    800209ac:	0785                	addi	a5,a5,1
    800209ae:	97aa                	add	a5,a5,a0
    *dst++ = 0;
    800209b0:	0505                	addi	a0,a0,1
    800209b2:	fe050fa3          	sb	zero,-1(a0)
  while(len-- > 0)
    800209b6:	fea79de3          	bne	a5,a0,800209b0 <snstr+0x3e>
}
    800209ba:	6422                	ld	s0,8(sp)
    800209bc:	0141                	addi	sp,sp,16
    800209be:	8082                	ret

00000000800209c0 <wcsncmp>:

int wcsncmp(wchar const *s1, wchar const *s2, int len) {
    800209c0:	1141                	addi	sp,sp,-16
    800209c2:	e422                	sd	s0,8(sp)
    800209c4:	0800                	addi	s0,sp,16
  int ret = 0;

  while (len-- && *s1) {
    800209c6:	1602                	slli	a2,a2,0x20
    800209c8:	9201                	srli	a2,a2,0x20
    800209ca:	0606                	slli	a2,a2,0x1
    800209cc:	962e                	add	a2,a2,a1
    800209ce:	00c58c63          	beq	a1,a2,800209e6 <wcsncmp+0x26>
    800209d2:	00055783          	lhu	a5,0(a0)
    800209d6:	cb89                	beqz	a5,800209e8 <wcsncmp+0x28>
    ret = (int)(*s1++ - *s2++);
    800209d8:	0509                	addi	a0,a0,2
    800209da:	0589                	addi	a1,a1,2
    800209dc:	ffe5d703          	lhu	a4,-2(a1)
    800209e0:	9f99                	subw	a5,a5,a4
    if (ret) break;
    800209e2:	d7f5                	beqz	a5,800209ce <wcsncmp+0xe>
    800209e4:	a011                	j	800209e8 <wcsncmp+0x28>
    800209e6:	4781                	li	a5,0
  }

  return ret;
}
    800209e8:	853e                	mv	a0,a5
    800209ea:	6422                	ld	s0,8(sp)
    800209ec:	0141                	addi	sp,sp,16
    800209ee:	8082                	ret

00000000800209f0 <strchr>:

char*
strchr(const char *s, char c)
{
    800209f0:	1141                	addi	sp,sp,-16
    800209f2:	e422                	sd	s0,8(sp)
    800209f4:	0800                	addi	s0,sp,16
  for(; *s; s++)
    800209f6:	00054783          	lbu	a5,0(a0)
    800209fa:	cf91                	beqz	a5,80020a16 <strchr+0x26>
    if(*s == c)
    800209fc:	00f58a63          	beq	a1,a5,80020a10 <strchr+0x20>
  for(; *s; s++)
    80020a00:	0505                	addi	a0,a0,1
    80020a02:	00054783          	lbu	a5,0(a0)
    80020a06:	c781                	beqz	a5,80020a0e <strchr+0x1e>
    if(*s == c)
    80020a08:	feb79ce3          	bne	a5,a1,80020a00 <strchr+0x10>
    80020a0c:	a011                	j	80020a10 <strchr+0x20>
      return (char*)s;
  return 0;
    80020a0e:	4501                	li	a0,0
    80020a10:	6422                	ld	s0,8(sp)
    80020a12:	0141                	addi	sp,sp,16
    80020a14:	8082                	ret
  return 0;
    80020a16:	4501                	li	a0,0
    80020a18:	bfe5                	j	80020a10 <strchr+0x20>

0000000080020a1a <main>:

volatile static int started = 0;

void
main(unsigned long hartid, unsigned long dtb_pa)
{
    80020a1a:	1101                	addi	sp,sp,-32
    80020a1c:	ec06                	sd	ra,24(sp)
    80020a1e:	e822                	sd	s0,16(sp)
    80020a20:	1000                	addi	s0,sp,32
  asm volatile("mv tp, %0" : : "r" (hartid & 0x1));
    80020a22:	00157793          	andi	a5,a0,1
    80020a26:	823e                	mv	tp,a5
    started = 1;
  }
  else
  {
    // hart 1
    while (started == 0)
    80020a28:	00016717          	auipc	a4,0x16
    80020a2c:	62870713          	addi	a4,a4,1576 # 80037050 <started>
  if (hartid == 0) {
    80020a30:	cd15                	beqz	a0,80020a6c <main+0x52>
    while (started == 0)
    80020a32:	431c                	lw	a5,0(a4)
    80020a34:	2781                	sext.w	a5,a5
    80020a36:	dff5                	beqz	a5,80020a32 <main+0x18>
      ;
    __sync_synchronize();
    80020a38:	0ff0000f          	fence
    #ifdef DEBUG
    printf("hart %d enter main()...\n", hartid);
    #endif
    kvminithart();
    80020a3c:	00000097          	auipc	ra,0x0
    80020a40:	11e080e7          	jalr	286(ra) # 80020b5a <kvminithart>
    trapinithart();
    80020a44:	00002097          	auipc	ra,0x2
    80020a48:	e4c080e7          	jalr	-436(ra) # 80022890 <trapinithart>
    plicinithart();  // ask PLIC for device interrupts
    80020a4c:	00006097          	auipc	ra,0x6
    80020a50:	21a080e7          	jalr	538(ra) # 80026c66 <plicinithart>
    printf("hart 1 init done\n");
    80020a54:	0000b517          	auipc	a0,0xb
    80020a58:	8a450513          	addi	a0,a0,-1884 # 8002b2f8 <etext+0x2f8>
    80020a5c:	fffff097          	auipc	ra,0xfffff
    80020a60:	734080e7          	jalr	1844(ra) # 80020190 <printf>
  }
  scheduler();
    80020a64:	00001097          	auipc	ra,0x1
    80020a68:	6cc080e7          	jalr	1740(ra) # 80022130 <scheduler>
    consoleinit();
    80020a6c:	00006097          	auipc	ra,0x6
    80020a70:	5e8080e7          	jalr	1512(ra) # 80027054 <consoleinit>
    printfinit();   // init a lock for printf 
    80020a74:	00000097          	auipc	ra,0x0
    80020a78:	902080e7          	jalr	-1790(ra) # 80020376 <printfinit>
    print_logo();
    80020a7c:	00000097          	auipc	ra,0x0
    80020a80:	92c080e7          	jalr	-1748(ra) # 800203a8 <print_logo>
    kinit();         // physical page allocator
    80020a84:	00000097          	auipc	ra,0x0
    80020a88:	a82080e7          	jalr	-1406(ra) # 80020506 <kinit>
    kvminit();       // create kernel page table
    80020a8c:	00000097          	auipc	ra,0x0
    80020a90:	31a080e7          	jalr	794(ra) # 80020da6 <kvminit>
    kvminithart();   // turn on paging
    80020a94:	00000097          	auipc	ra,0x0
    80020a98:	0c6080e7          	jalr	198(ra) # 80020b5a <kvminithart>
    timerinit();     // init a lock for timer
    80020a9c:	00004097          	auipc	ra,0x4
    80020aa0:	772080e7          	jalr	1906(ra) # 8002520e <timerinit>
    trapinithart();  // install kernel trap vector, including interrupt handler
    80020aa4:	00002097          	auipc	ra,0x2
    80020aa8:	dec080e7          	jalr	-532(ra) # 80022890 <trapinithart>
    procinit();
    80020aac:	00001097          	auipc	ra,0x1
    80020ab0:	034080e7          	jalr	52(ra) # 80021ae0 <procinit>
    plicinit();
    80020ab4:	00006097          	auipc	ra,0x6
    80020ab8:	198080e7          	jalr	408(ra) # 80026c4c <plicinit>
    plicinithart();
    80020abc:	00006097          	auipc	ra,0x6
    80020ac0:	1aa080e7          	jalr	426(ra) # 80026c66 <plicinithart>
    fpioa_pin_init();
    80020ac4:	00007097          	auipc	ra,0x7
    80020ac8:	4d8080e7          	jalr	1240(ra) # 80027f9c <fpioa_pin_init>
    fpioa_set_function(27, FUNC_SPI0_SCLK); 
    80020acc:	45c5                	li	a1,17
    80020ace:	456d                	li	a0,27
    80020ad0:	00007097          	auipc	ra,0x7
    80020ad4:	3e0080e7          	jalr	992(ra) # 80027eb0 <fpioa_set_function>
    fpioa_set_function(28, FUNC_SPI0_D0); 
    80020ad8:	4591                	li	a1,4
    80020ada:	4571                	li	a0,28
    80020adc:	00007097          	auipc	ra,0x7
    80020ae0:	3d4080e7          	jalr	980(ra) # 80027eb0 <fpioa_set_function>
    fpioa_set_function(26, FUNC_SPI0_D1); 
    80020ae4:	4595                	li	a1,5
    80020ae6:	4569                	li	a0,26
    80020ae8:	00007097          	auipc	ra,0x7
    80020aec:	3c8080e7          	jalr	968(ra) # 80027eb0 <fpioa_set_function>
    fpioa_set_function(29, FUNC_SPI0_SS0); 
    80020af0:	45b1                	li	a1,12
    80020af2:	4575                	li	a0,29
    80020af4:	00007097          	auipc	ra,0x7
    80020af8:	3bc080e7          	jalr	956(ra) # 80027eb0 <fpioa_set_function>
    dmac_init();
    80020afc:	00008097          	auipc	ra,0x8
    80020b00:	12c080e7          	jalr	300(ra) # 80028c28 <dmac_init>
    disk_init();
    80020b04:	00004097          	auipc	ra,0x4
    80020b08:	7a6080e7          	jalr	1958(ra) # 800252aa <disk_init>
    binit();         // buffer cache
    80020b0c:	00003097          	auipc	ra,0x3
    80020b10:	a58080e7          	jalr	-1448(ra) # 80023564 <binit>
    fileinit();      // file table
    80020b14:	00003097          	auipc	ra,0x3
    80020b18:	e6e080e7          	jalr	-402(ra) # 80023982 <fileinit>
    userinit();      // first user process
    80020b1c:	00001097          	auipc	ra,0x1
    80020b20:	376080e7          	jalr	886(ra) # 80021e92 <userinit>
    printf("hart 0 init done\n");
    80020b24:	0000a517          	auipc	a0,0xa
    80020b28:	7bc50513          	addi	a0,a0,1980 # 8002b2e0 <etext+0x2e0>
    80020b2c:	fffff097          	auipc	ra,0xfffff
    80020b30:	664080e7          	jalr	1636(ra) # 80020190 <printf>
      unsigned long mask = 1 << i;
    80020b34:	4789                	li	a5,2
    80020b36:	fef43423          	sd	a5,-24(s0)
	SBI_CALL_0(SBI_CLEAR_IPI);
}

static inline void sbi_send_ipi(const unsigned long *hart_mask)
{
	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
    80020b3a:	fe840513          	addi	a0,s0,-24
    80020b3e:	4581                	li	a1,0
    80020b40:	4601                	li	a2,0
    80020b42:	4681                	li	a3,0
    80020b44:	4891                	li	a7,4
    80020b46:	00000073          	ecall
    __sync_synchronize();
    80020b4a:	0ff0000f          	fence
    started = 1;
    80020b4e:	4785                	li	a5,1
    80020b50:	00016717          	auipc	a4,0x16
    80020b54:	50f72023          	sw	a5,1280(a4) # 80037050 <started>
    80020b58:	b731                	j	80020a64 <main+0x4a>

0000000080020b5a <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80020b5a:	1141                	addi	sp,sp,-16
    80020b5c:	e422                	sd	s0,8(sp)
    80020b5e:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80020b60:	00016797          	auipc	a5,0x16
    80020b64:	4f878793          	addi	a5,a5,1272 # 80037058 <kernel_pagetable>
    80020b68:	639c                	ld	a5,0(a5)
    80020b6a:	83b1                	srli	a5,a5,0xc
    80020b6c:	577d                	li	a4,-1
    80020b6e:	177e                	slli	a4,a4,0x3f
    80020b70:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80020b72:	18079073          	csrw	satp,a5
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  // asm volatile("sfence.vma zero, zero");
  asm volatile("sfence.vma");
    80020b76:	12000073          	sfence.vma
  // reg_info();
  sfence_vma();
  #ifdef DEBUG
  printf("kvminithart\n");
  #endif
}
    80020b7a:	6422                	ld	s0,8(sp)
    80020b7c:	0141                	addi	sp,sp,16
    80020b7e:	8082                	ret

0000000080020b80 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80020b80:	7139                	addi	sp,sp,-64
    80020b82:	fc06                	sd	ra,56(sp)
    80020b84:	f822                	sd	s0,48(sp)
    80020b86:	f426                	sd	s1,40(sp)
    80020b88:	f04a                	sd	s2,32(sp)
    80020b8a:	ec4e                	sd	s3,24(sp)
    80020b8c:	e852                	sd	s4,16(sp)
    80020b8e:	e456                	sd	s5,8(sp)
    80020b90:	e05a                	sd	s6,0(sp)
    80020b92:	0080                	addi	s0,sp,64
    80020b94:	84aa                	mv	s1,a0
    80020b96:	89ae                	mv	s3,a1
    80020b98:	8b32                	mv	s6,a2
  
  if(va >= MAXVA)
    80020b9a:	57fd                	li	a5,-1
    80020b9c:	83e9                	srli	a5,a5,0x1a
    80020b9e:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80020ba0:	4ab1                	li	s5,12
  if(va >= MAXVA)
    80020ba2:	04b7f263          	bgeu	a5,a1,80020be6 <walk+0x66>
    panic("walk");
    80020ba6:	0000a517          	auipc	a0,0xa
    80020baa:	76a50513          	addi	a0,a0,1898 # 8002b310 <etext+0x310>
    80020bae:	fffff097          	auipc	ra,0xfffff
    80020bb2:	598080e7          	jalr	1432(ra) # 80020146 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == NULL)
    80020bb6:	060b0663          	beqz	s6,80020c22 <walk+0xa2>
    80020bba:	00000097          	auipc	ra,0x0
    80020bbe:	998080e7          	jalr	-1640(ra) # 80020552 <kalloc>
    80020bc2:	84aa                	mv	s1,a0
    80020bc4:	c529                	beqz	a0,80020c0e <walk+0x8e>
        return NULL;
      memset(pagetable, 0, PGSIZE);
    80020bc6:	6605                	lui	a2,0x1
    80020bc8:	4581                	li	a1,0
    80020bca:	00000097          	auipc	ra,0x0
    80020bce:	b92080e7          	jalr	-1134(ra) # 8002075c <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80020bd2:	00c4d793          	srli	a5,s1,0xc
    80020bd6:	07aa                	slli	a5,a5,0xa
    80020bd8:	0017e793          	ori	a5,a5,1
    80020bdc:	00f93023          	sd	a5,0(s2)
    80020be0:	3a5d                	addiw	s4,s4,-9
  for(int level = 2; level > 0; level--) {
    80020be2:	035a0063          	beq	s4,s5,80020c02 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80020be6:	0149d933          	srl	s2,s3,s4
    80020bea:	1ff97913          	andi	s2,s2,511
    80020bee:	090e                	slli	s2,s2,0x3
    80020bf0:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80020bf2:	00093483          	ld	s1,0(s2)
    80020bf6:	0014f793          	andi	a5,s1,1
    80020bfa:	dfd5                	beqz	a5,80020bb6 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80020bfc:	80a9                	srli	s1,s1,0xa
    80020bfe:	04b2                	slli	s1,s1,0xc
    80020c00:	b7c5                	j	80020be0 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80020c02:	00c9d513          	srli	a0,s3,0xc
    80020c06:	1ff57513          	andi	a0,a0,511
    80020c0a:	050e                	slli	a0,a0,0x3
    80020c0c:	9526                	add	a0,a0,s1
}
    80020c0e:	70e2                	ld	ra,56(sp)
    80020c10:	7442                	ld	s0,48(sp)
    80020c12:	74a2                	ld	s1,40(sp)
    80020c14:	7902                	ld	s2,32(sp)
    80020c16:	69e2                	ld	s3,24(sp)
    80020c18:	6a42                	ld	s4,16(sp)
    80020c1a:	6aa2                	ld	s5,8(sp)
    80020c1c:	6b02                	ld	s6,0(sp)
    80020c1e:	6121                	addi	sp,sp,64
    80020c20:	8082                	ret
        return NULL;
    80020c22:	4501                	li	a0,0
    80020c24:	b7ed                	j	80020c0e <walk+0x8e>

0000000080020c26 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80020c26:	57fd                	li	a5,-1
    80020c28:	83e9                	srli	a5,a5,0x1a
    80020c2a:	00b7f463          	bgeu	a5,a1,80020c32 <walkaddr+0xc>
    return NULL;
    80020c2e:	4501                	li	a0,0
    return NULL;
  if((*pte & PTE_U) == 0)
    return NULL;
  pa = PTE2PA(*pte);
  return pa;
}
    80020c30:	8082                	ret
{
    80020c32:	1141                	addi	sp,sp,-16
    80020c34:	e406                	sd	ra,8(sp)
    80020c36:	e022                	sd	s0,0(sp)
    80020c38:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80020c3a:	4601                	li	a2,0
    80020c3c:	00000097          	auipc	ra,0x0
    80020c40:	f44080e7          	jalr	-188(ra) # 80020b80 <walk>
  if(pte == 0)
    80020c44:	c105                	beqz	a0,80020c64 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80020c46:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80020c48:	0117f693          	andi	a3,a5,17
    80020c4c:	4745                	li	a4,17
    return NULL;
    80020c4e:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80020c50:	00e68663          	beq	a3,a4,80020c5c <walkaddr+0x36>
}
    80020c54:	60a2                	ld	ra,8(sp)
    80020c56:	6402                	ld	s0,0(sp)
    80020c58:	0141                	addi	sp,sp,16
    80020c5a:	8082                	ret
  pa = PTE2PA(*pte);
    80020c5c:	00a7d513          	srli	a0,a5,0xa
    80020c60:	0532                	slli	a0,a0,0xc
  return pa;
    80020c62:	bfcd                	j	80020c54 <walkaddr+0x2e>
    return NULL;
    80020c64:	4501                	li	a0,0
    80020c66:	b7fd                	j	80020c54 <walkaddr+0x2e>

0000000080020c68 <kwalkaddr>:
  return kwalkaddr(kernel_pagetable, va);
}

uint64
kwalkaddr(pagetable_t kpt, uint64 va)
{
    80020c68:	1101                	addi	sp,sp,-32
    80020c6a:	ec06                	sd	ra,24(sp)
    80020c6c:	e822                	sd	s0,16(sp)
    80020c6e:	e426                	sd	s1,8(sp)
    80020c70:	1000                	addi	s0,sp,32
  uint64 off = va % PGSIZE;
    80020c72:	03459493          	slli	s1,a1,0x34
  pte_t *pte;
  uint64 pa;
  
  pte = walk(kpt, va, 0);
    80020c76:	4601                	li	a2,0
    80020c78:	00000097          	auipc	ra,0x0
    80020c7c:	f08080e7          	jalr	-248(ra) # 80020b80 <walk>
  if(pte == 0)
    80020c80:	cd11                	beqz	a0,80020c9c <kwalkaddr+0x34>
    80020c82:	90d1                	srli	s1,s1,0x34
    panic("kvmpa");
  if((*pte & PTE_V) == 0)
    80020c84:	6108                	ld	a0,0(a0)
    80020c86:	00157793          	andi	a5,a0,1
    80020c8a:	c38d                	beqz	a5,80020cac <kwalkaddr+0x44>
    panic("kvmpa");
  pa = PTE2PA(*pte);
    80020c8c:	8129                	srli	a0,a0,0xa
    80020c8e:	0532                	slli	a0,a0,0xc
  return pa+off;
}
    80020c90:	9526                	add	a0,a0,s1
    80020c92:	60e2                	ld	ra,24(sp)
    80020c94:	6442                	ld	s0,16(sp)
    80020c96:	64a2                	ld	s1,8(sp)
    80020c98:	6105                	addi	sp,sp,32
    80020c9a:	8082                	ret
    panic("kvmpa");
    80020c9c:	0000a517          	auipc	a0,0xa
    80020ca0:	67c50513          	addi	a0,a0,1660 # 8002b318 <etext+0x318>
    80020ca4:	fffff097          	auipc	ra,0xfffff
    80020ca8:	4a2080e7          	jalr	1186(ra) # 80020146 <panic>
    panic("kvmpa");
    80020cac:	0000a517          	auipc	a0,0xa
    80020cb0:	66c50513          	addi	a0,a0,1644 # 8002b318 <etext+0x318>
    80020cb4:	fffff097          	auipc	ra,0xfffff
    80020cb8:	492080e7          	jalr	1170(ra) # 80020146 <panic>

0000000080020cbc <kvmpa>:
{
    80020cbc:	1141                	addi	sp,sp,-16
    80020cbe:	e406                	sd	ra,8(sp)
    80020cc0:	e022                	sd	s0,0(sp)
    80020cc2:	0800                	addi	s0,sp,16
  return kwalkaddr(kernel_pagetable, va);
    80020cc4:	85aa                	mv	a1,a0
    80020cc6:	00016797          	auipc	a5,0x16
    80020cca:	39278793          	addi	a5,a5,914 # 80037058 <kernel_pagetable>
    80020cce:	6388                	ld	a0,0(a5)
    80020cd0:	00000097          	auipc	ra,0x0
    80020cd4:	f98080e7          	jalr	-104(ra) # 80020c68 <kwalkaddr>
}
    80020cd8:	60a2                	ld	ra,8(sp)
    80020cda:	6402                	ld	s0,0(sp)
    80020cdc:	0141                	addi	sp,sp,16
    80020cde:	8082                	ret

0000000080020ce0 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80020ce0:	715d                	addi	sp,sp,-80
    80020ce2:	e486                	sd	ra,72(sp)
    80020ce4:	e0a2                	sd	s0,64(sp)
    80020ce6:	fc26                	sd	s1,56(sp)
    80020ce8:	f84a                	sd	s2,48(sp)
    80020cea:	f44e                	sd	s3,40(sp)
    80020cec:	f052                	sd	s4,32(sp)
    80020cee:	ec56                	sd	s5,24(sp)
    80020cf0:	e85a                	sd	s6,16(sp)
    80020cf2:	e45e                	sd	s7,8(sp)
    80020cf4:	0880                	addi	s0,sp,80
    80020cf6:	8aaa                	mv	s5,a0
    80020cf8:	8b3a                	mv	s6,a4
  uint64 a, last;
  pte_t *pte;

  a = PGROUNDDOWN(va);
    80020cfa:	79fd                	lui	s3,0xfffff
    80020cfc:	0135fa33          	and	s4,a1,s3
  last = PGROUNDDOWN(va + size - 1);
    80020d00:	167d                	addi	a2,a2,-1
    80020d02:	962e                	add	a2,a2,a1
    80020d04:	013679b3          	and	s3,a2,s3
  a = PGROUNDDOWN(va);
    80020d08:	8952                	mv	s2,s4
    80020d0a:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80020d0e:	6b85                	lui	s7,0x1
    80020d10:	a811                	j	80020d24 <mappages+0x44>
      panic("remap");
    80020d12:	0000a517          	auipc	a0,0xa
    80020d16:	60e50513          	addi	a0,a0,1550 # 8002b320 <etext+0x320>
    80020d1a:	fffff097          	auipc	ra,0xfffff
    80020d1e:	42c080e7          	jalr	1068(ra) # 80020146 <panic>
    a += PGSIZE;
    80020d22:	995e                	add	s2,s2,s7
    pa += PGSIZE;
    80020d24:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == NULL)
    80020d28:	4605                	li	a2,1
    80020d2a:	85ca                	mv	a1,s2
    80020d2c:	8556                	mv	a0,s5
    80020d2e:	00000097          	auipc	ra,0x0
    80020d32:	e52080e7          	jalr	-430(ra) # 80020b80 <walk>
    80020d36:	cd19                	beqz	a0,80020d54 <mappages+0x74>
    if(*pte & PTE_V)
    80020d38:	611c                	ld	a5,0(a0)
    80020d3a:	8b85                	andi	a5,a5,1
    80020d3c:	fbf9                	bnez	a5,80020d12 <mappages+0x32>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80020d3e:	80b1                	srli	s1,s1,0xc
    80020d40:	04aa                	slli	s1,s1,0xa
    80020d42:	0164e4b3          	or	s1,s1,s6
    80020d46:	0014e493          	ori	s1,s1,1
    80020d4a:	e104                	sd	s1,0(a0)
    if(a == last)
    80020d4c:	fd391be3          	bne	s2,s3,80020d22 <mappages+0x42>
  }
  return 0;
    80020d50:	4501                	li	a0,0
    80020d52:	a011                	j	80020d56 <mappages+0x76>
      return -1;
    80020d54:	557d                	li	a0,-1
}
    80020d56:	60a6                	ld	ra,72(sp)
    80020d58:	6406                	ld	s0,64(sp)
    80020d5a:	74e2                	ld	s1,56(sp)
    80020d5c:	7942                	ld	s2,48(sp)
    80020d5e:	79a2                	ld	s3,40(sp)
    80020d60:	7a02                	ld	s4,32(sp)
    80020d62:	6ae2                	ld	s5,24(sp)
    80020d64:	6b42                	ld	s6,16(sp)
    80020d66:	6ba2                	ld	s7,8(sp)
    80020d68:	6161                	addi	sp,sp,80
    80020d6a:	8082                	ret

0000000080020d6c <kvmmap>:
{
    80020d6c:	1141                	addi	sp,sp,-16
    80020d6e:	e406                	sd	ra,8(sp)
    80020d70:	e022                	sd	s0,0(sp)
    80020d72:	0800                	addi	s0,sp,16
  if(mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    80020d74:	8736                	mv	a4,a3
    80020d76:	86ae                	mv	a3,a1
    80020d78:	85aa                	mv	a1,a0
    80020d7a:	00016797          	auipc	a5,0x16
    80020d7e:	2de78793          	addi	a5,a5,734 # 80037058 <kernel_pagetable>
    80020d82:	6388                	ld	a0,0(a5)
    80020d84:	00000097          	auipc	ra,0x0
    80020d88:	f5c080e7          	jalr	-164(ra) # 80020ce0 <mappages>
    80020d8c:	e509                	bnez	a0,80020d96 <kvmmap+0x2a>
}
    80020d8e:	60a2                	ld	ra,8(sp)
    80020d90:	6402                	ld	s0,0(sp)
    80020d92:	0141                	addi	sp,sp,16
    80020d94:	8082                	ret
    panic("kvmmap");
    80020d96:	0000a517          	auipc	a0,0xa
    80020d9a:	59250513          	addi	a0,a0,1426 # 8002b328 <etext+0x328>
    80020d9e:	fffff097          	auipc	ra,0xfffff
    80020da2:	3a8080e7          	jalr	936(ra) # 80020146 <panic>

0000000080020da6 <kvminit>:
{
    80020da6:	1101                	addi	sp,sp,-32
    80020da8:	ec06                	sd	ra,24(sp)
    80020daa:	e822                	sd	s0,16(sp)
    80020dac:	e426                	sd	s1,8(sp)
    80020dae:	1000                	addi	s0,sp,32
  kernel_pagetable = (pagetable_t) kalloc();
    80020db0:	fffff097          	auipc	ra,0xfffff
    80020db4:	7a2080e7          	jalr	1954(ra) # 80020552 <kalloc>
    80020db8:	00016797          	auipc	a5,0x16
    80020dbc:	2aa7b023          	sd	a0,672(a5) # 80037058 <kernel_pagetable>
  memset(kernel_pagetable, 0, PGSIZE);
    80020dc0:	6605                	lui	a2,0x1
    80020dc2:	4581                	li	a1,0
    80020dc4:	00000097          	auipc	ra,0x0
    80020dc8:	998080e7          	jalr	-1640(ra) # 8002075c <memset>
  kvmmap(UART_V, UART, PGSIZE, PTE_R | PTE_W);
    80020dcc:	4699                	li	a3,6
    80020dce:	6605                	lui	a2,0x1
    80020dd0:	380005b7          	lui	a1,0x38000
    80020dd4:	7e700513          	li	a0,2023
    80020dd8:	056e                	slli	a0,a0,0x1b
    80020dda:	00000097          	auipc	ra,0x0
    80020dde:	f92080e7          	jalr	-110(ra) # 80020d6c <kvmmap>
  kvmmap(CLINT_V, CLINT, 0x10000, PTE_R | PTE_W);
    80020de2:	4699                	li	a3,6
    80020de4:	6641                	lui	a2,0x10
    80020de6:	020005b7          	lui	a1,0x2000
    80020dea:	01f81537          	lui	a0,0x1f81
    80020dee:	0536                	slli	a0,a0,0xd
    80020df0:	00000097          	auipc	ra,0x0
    80020df4:	f7c080e7          	jalr	-132(ra) # 80020d6c <kvmmap>
  kvmmap(PLIC_V, PLIC, 0x4000, PTE_R | PTE_W);
    80020df8:	4699                	li	a3,6
    80020dfa:	6611                	lui	a2,0x4
    80020dfc:	0c0005b7          	lui	a1,0xc000
    80020e00:	00fc3537          	lui	a0,0xfc3
    80020e04:	053a                	slli	a0,a0,0xe
    80020e06:	00000097          	auipc	ra,0x0
    80020e0a:	f66080e7          	jalr	-154(ra) # 80020d6c <kvmmap>
  kvmmap(PLIC_V + 0x200000, PLIC + 0x200000, 0x4000, PTE_R | PTE_W);
    80020e0e:	4699                	li	a3,6
    80020e10:	6611                	lui	a2,0x4
    80020e12:	0c2005b7          	lui	a1,0xc200
    80020e16:	1f861537          	lui	a0,0x1f861
    80020e1a:	0526                	slli	a0,a0,0x9
    80020e1c:	00000097          	auipc	ra,0x0
    80020e20:	f50080e7          	jalr	-176(ra) # 80020d6c <kvmmap>
  kvmmap(GPIOHS_V, GPIOHS, 0x1000, PTE_R | PTE_W);
    80020e24:	4699                	li	a3,6
    80020e26:	6605                	lui	a2,0x1
    80020e28:	380015b7          	lui	a1,0x38001
    80020e2c:	03f38537          	lui	a0,0x3f38
    80020e30:	0505                	addi	a0,a0,1
    80020e32:	0532                	slli	a0,a0,0xc
    80020e34:	00000097          	auipc	ra,0x0
    80020e38:	f38080e7          	jalr	-200(ra) # 80020d6c <kvmmap>
  kvmmap(DMAC_V, DMAC, 0x1000, PTE_R | PTE_W);
    80020e3c:	4699                	li	a3,6
    80020e3e:	6605                	lui	a2,0x1
    80020e40:	500005b7          	lui	a1,0x50000
    80020e44:	3f500513          	li	a0,1013
    80020e48:	0572                	slli	a0,a0,0x1c
    80020e4a:	00000097          	auipc	ra,0x0
    80020e4e:	f22080e7          	jalr	-222(ra) # 80020d6c <kvmmap>
  kvmmap(SPI_SLAVE_V, SPI_SLAVE, 0x1000, PTE_R | PTE_W);
    80020e52:	4699                	li	a3,6
    80020e54:	6605                	lui	a2,0x1
    80020e56:	502405b7          	lui	a1,0x50240
    80020e5a:	000fd4b7          	lui	s1,0xfd
    80020e5e:	40948513          	addi	a0,s1,1033 # fd409 <BASE_ADDRESS-0x7ff22bf7>
    80020e62:	054a                	slli	a0,a0,0x12
    80020e64:	00000097          	auipc	ra,0x0
    80020e68:	f08080e7          	jalr	-248(ra) # 80020d6c <kvmmap>
  kvmmap(FPIOA_V, FPIOA, 0x1000, PTE_R | PTE_W);
    80020e6c:	4699                	li	a3,6
    80020e6e:	6605                	lui	a2,0x1
    80020e70:	502b05b7          	lui	a1,0x502b0
    80020e74:	003f5537          	lui	a0,0x3f5
    80020e78:	02b50513          	addi	a0,a0,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80020e7c:	0542                	slli	a0,a0,0x10
    80020e7e:	00000097          	auipc	ra,0x0
    80020e82:	eee080e7          	jalr	-274(ra) # 80020d6c <kvmmap>
  kvmmap(SPI0_V, SPI0, 0x1000, PTE_R | PTE_W);
    80020e86:	4699                	li	a3,6
    80020e88:	6605                	lui	a2,0x1
    80020e8a:	520005b7          	lui	a1,0x52000
    80020e8e:	01fa9537          	lui	a0,0x1fa9
    80020e92:	0536                	slli	a0,a0,0xd
    80020e94:	00000097          	auipc	ra,0x0
    80020e98:	ed8080e7          	jalr	-296(ra) # 80020d6c <kvmmap>
  kvmmap(SPI1_V, SPI1, 0x1000, PTE_R | PTE_W);
    80020e9c:	4699                	li	a3,6
    80020e9e:	6605                	lui	a2,0x1
    80020ea0:	530005b7          	lui	a1,0x53000
    80020ea4:	03f53537          	lui	a0,0x3f53
    80020ea8:	0532                	slli	a0,a0,0xc
    80020eaa:	00000097          	auipc	ra,0x0
    80020eae:	ec2080e7          	jalr	-318(ra) # 80020d6c <kvmmap>
  kvmmap(SPI2_V, SPI2, 0x1000, PTE_R | PTE_W);
    80020eb2:	4699                	li	a3,6
    80020eb4:	6605                	lui	a2,0x1
    80020eb6:	540005b7          	lui	a1,0x54000
    80020eba:	00fd5537          	lui	a0,0xfd5
    80020ebe:	053a                	slli	a0,a0,0xe
    80020ec0:	00000097          	auipc	ra,0x0
    80020ec4:	eac080e7          	jalr	-340(ra) # 80020d6c <kvmmap>
  kvmmap(SYSCTL_V, SYSCTL, 0x1000, PTE_R | PTE_W);
    80020ec8:	4699                	li	a3,6
    80020eca:	6605                	lui	a2,0x1
    80020ecc:	504405b7          	lui	a1,0x50440
    80020ed0:	41148513          	addi	a0,s1,1041
    80020ed4:	054a                	slli	a0,a0,0x12
    80020ed6:	00000097          	auipc	ra,0x0
    80020eda:	e96080e7          	jalr	-362(ra) # 80020d6c <kvmmap>
  kvmmap(KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);
    80020ede:	0000a497          	auipc	s1,0xa
    80020ee2:	12248493          	addi	s1,s1,290 # 8002b000 <etext>
    80020ee6:	46a9                	li	a3,10
    80020ee8:	fbfff637          	lui	a2,0xfbfff
    80020eec:	0616                	slli	a2,a2,0x5
    80020eee:	9626                	add	a2,a2,s1
    80020ef0:	040015b7          	lui	a1,0x4001
    80020ef4:	0596                	slli	a1,a1,0x5
    80020ef6:	852e                	mv	a0,a1
    80020ef8:	00000097          	auipc	ra,0x0
    80020efc:	e74080e7          	jalr	-396(ra) # 80020d6c <kvmmap>
  kvmmap((uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext, PTE_R | PTE_W);
    80020f00:	4699                	li	a3,6
    80020f02:	40300613          	li	a2,1027
    80020f06:	0656                	slli	a2,a2,0x15
    80020f08:	8e05                	sub	a2,a2,s1
    80020f0a:	85a6                	mv	a1,s1
    80020f0c:	8526                	mv	a0,s1
    80020f0e:	00000097          	auipc	ra,0x0
    80020f12:	e5e080e7          	jalr	-418(ra) # 80020d6c <kvmmap>
  kvmmap(TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80020f16:	46a9                	li	a3,10
    80020f18:	6605                	lui	a2,0x1
    80020f1a:	00009597          	auipc	a1,0x9
    80020f1e:	0e658593          	addi	a1,a1,230 # 8002a000 <_trampoline>
    80020f22:	04000537          	lui	a0,0x4000
    80020f26:	157d                	addi	a0,a0,-1
    80020f28:	0532                	slli	a0,a0,0xc
    80020f2a:	00000097          	auipc	ra,0x0
    80020f2e:	e42080e7          	jalr	-446(ra) # 80020d6c <kvmmap>
}
    80020f32:	60e2                	ld	ra,24(sp)
    80020f34:	6442                	ld	s0,16(sp)
    80020f36:	64a2                	ld	s1,8(sp)
    80020f38:	6105                	addi	sp,sp,32
    80020f3a:	8082                	ret

0000000080020f3c <vmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
vmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80020f3c:	715d                	addi	sp,sp,-80
    80020f3e:	e486                	sd	ra,72(sp)
    80020f40:	e0a2                	sd	s0,64(sp)
    80020f42:	fc26                	sd	s1,56(sp)
    80020f44:	f84a                	sd	s2,48(sp)
    80020f46:	f44e                	sd	s3,40(sp)
    80020f48:	f052                	sd	s4,32(sp)
    80020f4a:	ec56                	sd	s5,24(sp)
    80020f4c:	e85a                	sd	s6,16(sp)
    80020f4e:	e45e                	sd	s7,8(sp)
    80020f50:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80020f52:	03459793          	slli	a5,a1,0x34
    80020f56:	e795                	bnez	a5,80020f82 <vmunmap+0x46>
    80020f58:	8a2a                	mv	s4,a0
    80020f5a:	84ae                	mv	s1,a1
    80020f5c:	8ab6                	mv	s5,a3
    panic("vmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020f5e:	0632                	slli	a2,a2,0xc
    80020f60:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("vmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("vmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80020f64:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020f66:	6b05                	lui	s6,0x1
    80020f68:	0735e863          	bltu	a1,s3,80020fd8 <vmunmap+0x9c>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80020f6c:	60a6                	ld	ra,72(sp)
    80020f6e:	6406                	ld	s0,64(sp)
    80020f70:	74e2                	ld	s1,56(sp)
    80020f72:	7942                	ld	s2,48(sp)
    80020f74:	79a2                	ld	s3,40(sp)
    80020f76:	7a02                	ld	s4,32(sp)
    80020f78:	6ae2                	ld	s5,24(sp)
    80020f7a:	6b42                	ld	s6,16(sp)
    80020f7c:	6ba2                	ld	s7,8(sp)
    80020f7e:	6161                	addi	sp,sp,80
    80020f80:	8082                	ret
    panic("vmunmap: not aligned");
    80020f82:	0000a517          	auipc	a0,0xa
    80020f86:	3ae50513          	addi	a0,a0,942 # 8002b330 <etext+0x330>
    80020f8a:	fffff097          	auipc	ra,0xfffff
    80020f8e:	1bc080e7          	jalr	444(ra) # 80020146 <panic>
      panic("vmunmap: walk");
    80020f92:	0000a517          	auipc	a0,0xa
    80020f96:	3b650513          	addi	a0,a0,950 # 8002b348 <etext+0x348>
    80020f9a:	fffff097          	auipc	ra,0xfffff
    80020f9e:	1ac080e7          	jalr	428(ra) # 80020146 <panic>
      panic("vmunmap: not mapped");
    80020fa2:	0000a517          	auipc	a0,0xa
    80020fa6:	3b650513          	addi	a0,a0,950 # 8002b358 <etext+0x358>
    80020faa:	fffff097          	auipc	ra,0xfffff
    80020fae:	19c080e7          	jalr	412(ra) # 80020146 <panic>
      panic("vmunmap: not a leaf");
    80020fb2:	0000a517          	auipc	a0,0xa
    80020fb6:	3be50513          	addi	a0,a0,958 # 8002b370 <etext+0x370>
    80020fba:	fffff097          	auipc	ra,0xfffff
    80020fbe:	18c080e7          	jalr	396(ra) # 80020146 <panic>
      uint64 pa = PTE2PA(*pte);
    80020fc2:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80020fc4:	0532                	slli	a0,a0,0xc
    80020fc6:	fffff097          	auipc	ra,0xfffff
    80020fca:	472080e7          	jalr	1138(ra) # 80020438 <kfree>
    *pte = 0;
    80020fce:	00093023          	sd	zero,0(s2)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020fd2:	94da                	add	s1,s1,s6
    80020fd4:	f934fce3          	bgeu	s1,s3,80020f6c <vmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80020fd8:	4601                	li	a2,0
    80020fda:	85a6                	mv	a1,s1
    80020fdc:	8552                	mv	a0,s4
    80020fde:	00000097          	auipc	ra,0x0
    80020fe2:	ba2080e7          	jalr	-1118(ra) # 80020b80 <walk>
    80020fe6:	892a                	mv	s2,a0
    80020fe8:	d54d                	beqz	a0,80020f92 <vmunmap+0x56>
    if((*pte & PTE_V) == 0)
    80020fea:	6108                	ld	a0,0(a0)
    80020fec:	00157793          	andi	a5,a0,1
    80020ff0:	dbcd                	beqz	a5,80020fa2 <vmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    80020ff2:	3ff57793          	andi	a5,a0,1023
    80020ff6:	fb778ee3          	beq	a5,s7,80020fb2 <vmunmap+0x76>
    if(do_free){
    80020ffa:	fc0a8ae3          	beqz	s5,80020fce <vmunmap+0x92>
    80020ffe:	b7d1                	j	80020fc2 <vmunmap+0x86>

0000000080021000 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80021000:	1101                	addi	sp,sp,-32
    80021002:	ec06                	sd	ra,24(sp)
    80021004:	e822                	sd	s0,16(sp)
    80021006:	e426                	sd	s1,8(sp)
    80021008:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    8002100a:	fffff097          	auipc	ra,0xfffff
    8002100e:	548080e7          	jalr	1352(ra) # 80020552 <kalloc>
    80021012:	84aa                	mv	s1,a0
  if(pagetable == NULL)
    80021014:	c519                	beqz	a0,80021022 <uvmcreate+0x22>
    return NULL;
  memset(pagetable, 0, PGSIZE);
    80021016:	6605                	lui	a2,0x1
    80021018:	4581                	li	a1,0
    8002101a:	fffff097          	auipc	ra,0xfffff
    8002101e:	742080e7          	jalr	1858(ra) # 8002075c <memset>
  return pagetable;
}
    80021022:	8526                	mv	a0,s1
    80021024:	60e2                	ld	ra,24(sp)
    80021026:	6442                	ld	s0,16(sp)
    80021028:	64a2                	ld	s1,8(sp)
    8002102a:	6105                	addi	sp,sp,32
    8002102c:	8082                	ret

000000008002102e <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, pagetable_t kpagetable, uchar *src, uint sz)
{
    8002102e:	7139                	addi	sp,sp,-64
    80021030:	fc06                	sd	ra,56(sp)
    80021032:	f822                	sd	s0,48(sp)
    80021034:	f426                	sd	s1,40(sp)
    80021036:	f04a                	sd	s2,32(sp)
    80021038:	ec4e                	sd	s3,24(sp)
    8002103a:	e852                	sd	s4,16(sp)
    8002103c:	e456                	sd	s5,8(sp)
    8002103e:	0080                	addi	s0,sp,64
  char *mem;

  if(sz >= PGSIZE)
    80021040:	6785                	lui	a5,0x1
    80021042:	06f6f363          	bgeu	a3,a5,800210a8 <uvminit+0x7a>
    80021046:	8aaa                	mv	s5,a0
    80021048:	8a2e                	mv	s4,a1
    8002104a:	89b2                	mv	s3,a2
    8002104c:	8936                	mv	s2,a3
    panic("inituvm: more than a page");
  mem = kalloc();
    8002104e:	fffff097          	auipc	ra,0xfffff
    80021052:	504080e7          	jalr	1284(ra) # 80020552 <kalloc>
    80021056:	84aa                	mv	s1,a0
  // printf("[uvminit]kalloc: %p\n", mem);
  memset(mem, 0, PGSIZE);
    80021058:	6605                	lui	a2,0x1
    8002105a:	4581                	li	a1,0
    8002105c:	fffff097          	auipc	ra,0xfffff
    80021060:	700080e7          	jalr	1792(ra) # 8002075c <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80021064:	4779                	li	a4,30
    80021066:	86a6                	mv	a3,s1
    80021068:	6605                	lui	a2,0x1
    8002106a:	4581                	li	a1,0
    8002106c:	8556                	mv	a0,s5
    8002106e:	00000097          	auipc	ra,0x0
    80021072:	c72080e7          	jalr	-910(ra) # 80020ce0 <mappages>
  mappages(kpagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X);
    80021076:	4739                	li	a4,14
    80021078:	86a6                	mv	a3,s1
    8002107a:	6605                	lui	a2,0x1
    8002107c:	4581                	li	a1,0
    8002107e:	8552                	mv	a0,s4
    80021080:	00000097          	auipc	ra,0x0
    80021084:	c60080e7          	jalr	-928(ra) # 80020ce0 <mappages>
  memmove(mem, src, sz);
    80021088:	864a                	mv	a2,s2
    8002108a:	85ce                	mv	a1,s3
    8002108c:	8526                	mv	a0,s1
    8002108e:	fffff097          	auipc	ra,0xfffff
    80021092:	73a080e7          	jalr	1850(ra) # 800207c8 <memmove>
  // for (int i = 0; i < sz; i ++) {
  //   printf("[uvminit]mem: %p, %x\n", mem + i, mem[i]);
  // }
}
    80021096:	70e2                	ld	ra,56(sp)
    80021098:	7442                	ld	s0,48(sp)
    8002109a:	74a2                	ld	s1,40(sp)
    8002109c:	7902                	ld	s2,32(sp)
    8002109e:	69e2                	ld	s3,24(sp)
    800210a0:	6a42                	ld	s4,16(sp)
    800210a2:	6aa2                	ld	s5,8(sp)
    800210a4:	6121                	addi	sp,sp,64
    800210a6:	8082                	ret
    panic("inituvm: more than a page");
    800210a8:	0000a517          	auipc	a0,0xa
    800210ac:	2e050513          	addi	a0,a0,736 # 8002b388 <etext+0x388>
    800210b0:	fffff097          	auipc	ra,0xfffff
    800210b4:	096080e7          	jalr	150(ra) # 80020146 <panic>

00000000800210b8 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, pagetable_t kpagetable, uint64 oldsz, uint64 newsz)
{
    800210b8:	7179                	addi	sp,sp,-48
    800210ba:	f406                	sd	ra,40(sp)
    800210bc:	f022                	sd	s0,32(sp)
    800210be:	ec26                	sd	s1,24(sp)
    800210c0:	e84a                	sd	s2,16(sp)
    800210c2:	e44e                	sd	s3,8(sp)
    800210c4:	e052                	sd	s4,0(sp)
    800210c6:	1800                	addi	s0,sp,48
  if(newsz >= oldsz)
    return oldsz;
    800210c8:	8932                	mv	s2,a2
  if(newsz >= oldsz)
    800210ca:	02c6f063          	bgeu	a3,a2,800210ea <uvmdealloc+0x32>
    800210ce:	8a2a                	mv	s4,a0
    800210d0:	852e                	mv	a0,a1
    800210d2:	8936                	mv	s2,a3

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800210d4:	6785                	lui	a5,0x1
    800210d6:	17fd                	addi	a5,a5,-1
    800210d8:	00f689b3          	add	s3,a3,a5
    800210dc:	777d                	lui	a4,0xfffff
    800210de:	00e9f9b3          	and	s3,s3,a4
    800210e2:	963e                	add	a2,a2,a5
    800210e4:	8e79                	and	a2,a2,a4
    800210e6:	00c9eb63          	bltu	s3,a2,800210fc <uvmdealloc+0x44>
    vmunmap(kpagetable, PGROUNDUP(newsz), npages, 0);
    vmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800210ea:	854a                	mv	a0,s2
    800210ec:	70a2                	ld	ra,40(sp)
    800210ee:	7402                	ld	s0,32(sp)
    800210f0:	64e2                	ld	s1,24(sp)
    800210f2:	6942                	ld	s2,16(sp)
    800210f4:	69a2                	ld	s3,8(sp)
    800210f6:	6a02                	ld	s4,0(sp)
    800210f8:	6145                	addi	sp,sp,48
    800210fa:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800210fc:	413604b3          	sub	s1,a2,s3
    80021100:	80b1                	srli	s1,s1,0xc
    vmunmap(kpagetable, PGROUNDUP(newsz), npages, 0);
    80021102:	2481                	sext.w	s1,s1
    80021104:	4681                	li	a3,0
    80021106:	8626                	mv	a2,s1
    80021108:	85ce                	mv	a1,s3
    8002110a:	00000097          	auipc	ra,0x0
    8002110e:	e32080e7          	jalr	-462(ra) # 80020f3c <vmunmap>
    vmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80021112:	4685                	li	a3,1
    80021114:	8626                	mv	a2,s1
    80021116:	85ce                	mv	a1,s3
    80021118:	8552                	mv	a0,s4
    8002111a:	00000097          	auipc	ra,0x0
    8002111e:	e22080e7          	jalr	-478(ra) # 80020f3c <vmunmap>
    80021122:	b7e1                	j	800210ea <uvmdealloc+0x32>

0000000080021124 <uvmalloc>:
  if(newsz < oldsz)
    80021124:	0ec6e763          	bltu	a3,a2,80021212 <uvmalloc+0xee>
{
    80021128:	7139                	addi	sp,sp,-64
    8002112a:	fc06                	sd	ra,56(sp)
    8002112c:	f822                	sd	s0,48(sp)
    8002112e:	f426                	sd	s1,40(sp)
    80021130:	f04a                	sd	s2,32(sp)
    80021132:	ec4e                	sd	s3,24(sp)
    80021134:	e852                	sd	s4,16(sp)
    80021136:	e456                	sd	s5,8(sp)
    80021138:	e05a                	sd	s6,0(sp)
    8002113a:	0080                	addi	s0,sp,64
  oldsz = PGROUNDUP(oldsz);
    8002113c:	6a05                	lui	s4,0x1
    8002113e:	1a7d                	addi	s4,s4,-1
    80021140:	9652                	add	a2,a2,s4
    80021142:	7a7d                	lui	s4,0xfffff
    80021144:	01467a33          	and	s4,a2,s4
  for(a = oldsz; a < newsz; a += PGSIZE){
    80021148:	0cda7763          	bgeu	s4,a3,80021216 <uvmalloc+0xf2>
    8002114c:	89b6                	mv	s3,a3
    8002114e:	8b2e                	mv	s6,a1
    80021150:	8aaa                	mv	s5,a0
    80021152:	84d2                	mv	s1,s4
    mem = kalloc();
    80021154:	fffff097          	auipc	ra,0xfffff
    80021158:	3fe080e7          	jalr	1022(ra) # 80020552 <kalloc>
    8002115c:	892a                	mv	s2,a0
    if(mem == NULL){
    8002115e:	c129                	beqz	a0,800211a0 <uvmalloc+0x7c>
    memset(mem, 0, PGSIZE);
    80021160:	6605                	lui	a2,0x1
    80021162:	4581                	li	a1,0
    80021164:	fffff097          	auipc	ra,0xfffff
    80021168:	5f8080e7          	jalr	1528(ra) # 8002075c <memset>
    if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0) {
    8002116c:	4779                	li	a4,30
    8002116e:	86ca                	mv	a3,s2
    80021170:	6605                	lui	a2,0x1
    80021172:	85a6                	mv	a1,s1
    80021174:	8556                	mv	a0,s5
    80021176:	00000097          	auipc	ra,0x0
    8002117a:	b6a080e7          	jalr	-1174(ra) # 80020ce0 <mappages>
    8002117e:	e521                	bnez	a0,800211c6 <uvmalloc+0xa2>
    if (mappages(kpagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R) != 0){
    80021180:	4739                	li	a4,14
    80021182:	86ca                	mv	a3,s2
    80021184:	6605                	lui	a2,0x1
    80021186:	85a6                	mv	a1,s1
    80021188:	855a                	mv	a0,s6
    8002118a:	00000097          	auipc	ra,0x0
    8002118e:	b56080e7          	jalr	-1194(ra) # 80020ce0 <mappages>
    80021192:	e929                	bnez	a0,800211e4 <uvmalloc+0xc0>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80021194:	6785                	lui	a5,0x1
    80021196:	94be                	add	s1,s1,a5
    80021198:	fb34eee3          	bltu	s1,s3,80021154 <uvmalloc+0x30>
  return newsz;
    8002119c:	854e                	mv	a0,s3
    8002119e:	a811                	j	800211b2 <uvmalloc+0x8e>
      uvmdealloc(pagetable, kpagetable, a, oldsz);
    800211a0:	86d2                	mv	a3,s4
    800211a2:	8626                	mv	a2,s1
    800211a4:	85da                	mv	a1,s6
    800211a6:	8556                	mv	a0,s5
    800211a8:	00000097          	auipc	ra,0x0
    800211ac:	f10080e7          	jalr	-240(ra) # 800210b8 <uvmdealloc>
      return 0;
    800211b0:	4501                	li	a0,0
}
    800211b2:	70e2                	ld	ra,56(sp)
    800211b4:	7442                	ld	s0,48(sp)
    800211b6:	74a2                	ld	s1,40(sp)
    800211b8:	7902                	ld	s2,32(sp)
    800211ba:	69e2                	ld	s3,24(sp)
    800211bc:	6a42                	ld	s4,16(sp)
    800211be:	6aa2                	ld	s5,8(sp)
    800211c0:	6b02                	ld	s6,0(sp)
    800211c2:	6121                	addi	sp,sp,64
    800211c4:	8082                	ret
      kfree(mem);
    800211c6:	854a                	mv	a0,s2
    800211c8:	fffff097          	auipc	ra,0xfffff
    800211cc:	270080e7          	jalr	624(ra) # 80020438 <kfree>
      uvmdealloc(pagetable, kpagetable, a, oldsz);
    800211d0:	86d2                	mv	a3,s4
    800211d2:	8626                	mv	a2,s1
    800211d4:	85da                	mv	a1,s6
    800211d6:	8556                	mv	a0,s5
    800211d8:	00000097          	auipc	ra,0x0
    800211dc:	ee0080e7          	jalr	-288(ra) # 800210b8 <uvmdealloc>
      return 0;
    800211e0:	4501                	li	a0,0
    800211e2:	bfc1                	j	800211b2 <uvmalloc+0x8e>
      int npages = (a - oldsz) / PGSIZE;
    800211e4:	414484b3          	sub	s1,s1,s4
    800211e8:	80b1                	srli	s1,s1,0xc
    800211ea:	2481                	sext.w	s1,s1
      vmunmap(pagetable, oldsz, npages + 1, 1);   // plus the page allocated above.
    800211ec:	4685                	li	a3,1
    800211ee:	0014861b          	addiw	a2,s1,1
    800211f2:	85d2                	mv	a1,s4
    800211f4:	8556                	mv	a0,s5
    800211f6:	00000097          	auipc	ra,0x0
    800211fa:	d46080e7          	jalr	-698(ra) # 80020f3c <vmunmap>
      vmunmap(kpagetable, oldsz, npages, 0);
    800211fe:	4681                	li	a3,0
    80021200:	8626                	mv	a2,s1
    80021202:	85d2                	mv	a1,s4
    80021204:	855a                	mv	a0,s6
    80021206:	00000097          	auipc	ra,0x0
    8002120a:	d36080e7          	jalr	-714(ra) # 80020f3c <vmunmap>
      return 0;
    8002120e:	4501                	li	a0,0
    80021210:	b74d                	j	800211b2 <uvmalloc+0x8e>
    return oldsz;
    80021212:	8532                	mv	a0,a2
}
    80021214:	8082                	ret
  return newsz;
    80021216:	8536                	mv	a0,a3
    80021218:	bf69                	j	800211b2 <uvmalloc+0x8e>

000000008002121a <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8002121a:	7179                	addi	sp,sp,-48
    8002121c:	f406                	sd	ra,40(sp)
    8002121e:	f022                	sd	s0,32(sp)
    80021220:	ec26                	sd	s1,24(sp)
    80021222:	e84a                	sd	s2,16(sp)
    80021224:	e44e                	sd	s3,8(sp)
    80021226:	e052                	sd	s4,0(sp)
    80021228:	1800                	addi	s0,sp,48
    8002122a:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    8002122c:	84aa                	mv	s1,a0
    8002122e:	6905                	lui	s2,0x1
    80021230:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80021232:	4985                	li	s3,1
    80021234:	a821                	j	8002124c <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80021236:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    80021238:	0532                	slli	a0,a0,0xc
    8002123a:	00000097          	auipc	ra,0x0
    8002123e:	fe0080e7          	jalr	-32(ra) # 8002121a <freewalk>
      pagetable[i] = 0;
    80021242:	0004b023          	sd	zero,0(s1)
    80021246:	04a1                	addi	s1,s1,8
  for(int i = 0; i < 512; i++){
    80021248:	03248163          	beq	s1,s2,8002126a <freewalk+0x50>
    pte_t pte = pagetable[i];
    8002124c:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8002124e:	00f57793          	andi	a5,a0,15
    80021252:	ff3782e3          	beq	a5,s3,80021236 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80021256:	8905                	andi	a0,a0,1
    80021258:	d57d                	beqz	a0,80021246 <freewalk+0x2c>
      panic("freewalk: leaf");
    8002125a:	0000a517          	auipc	a0,0xa
    8002125e:	14e50513          	addi	a0,a0,334 # 8002b3a8 <etext+0x3a8>
    80021262:	fffff097          	auipc	ra,0xfffff
    80021266:	ee4080e7          	jalr	-284(ra) # 80020146 <panic>
    }
  }
  kfree((void*)pagetable);
    8002126a:	8552                	mv	a0,s4
    8002126c:	fffff097          	auipc	ra,0xfffff
    80021270:	1cc080e7          	jalr	460(ra) # 80020438 <kfree>
}
    80021274:	70a2                	ld	ra,40(sp)
    80021276:	7402                	ld	s0,32(sp)
    80021278:	64e2                	ld	s1,24(sp)
    8002127a:	6942                	ld	s2,16(sp)
    8002127c:	69a2                	ld	s3,8(sp)
    8002127e:	6a02                	ld	s4,0(sp)
    80021280:	6145                	addi	sp,sp,48
    80021282:	8082                	ret

0000000080021284 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80021284:	1101                	addi	sp,sp,-32
    80021286:	ec06                	sd	ra,24(sp)
    80021288:	e822                	sd	s0,16(sp)
    8002128a:	e426                	sd	s1,8(sp)
    8002128c:	1000                	addi	s0,sp,32
    8002128e:	84aa                	mv	s1,a0
  if(sz > 0)
    80021290:	e999                	bnez	a1,800212a6 <uvmfree+0x22>
    vmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80021292:	8526                	mv	a0,s1
    80021294:	00000097          	auipc	ra,0x0
    80021298:	f86080e7          	jalr	-122(ra) # 8002121a <freewalk>
}
    8002129c:	60e2                	ld	ra,24(sp)
    8002129e:	6442                	ld	s0,16(sp)
    800212a0:	64a2                	ld	s1,8(sp)
    800212a2:	6105                	addi	sp,sp,32
    800212a4:	8082                	ret
    vmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    800212a6:	6605                	lui	a2,0x1
    800212a8:	167d                	addi	a2,a2,-1
    800212aa:	962e                	add	a2,a2,a1
    800212ac:	4685                	li	a3,1
    800212ae:	8231                	srli	a2,a2,0xc
    800212b0:	4581                	li	a1,0
    800212b2:	00000097          	auipc	ra,0x0
    800212b6:	c8a080e7          	jalr	-886(ra) # 80020f3c <vmunmap>
    800212ba:	bfe1                	j	80021292 <uvmfree+0xe>

00000000800212bc <uvmcopy>:
  pte_t *pte;
  uint64 pa, i = 0, ki = 0;
  uint flags;
  char *mem;

  while (i < sz){
    800212bc:	10068563          	beqz	a3,800213c6 <uvmcopy+0x10a>
{
    800212c0:	715d                	addi	sp,sp,-80
    800212c2:	e486                	sd	ra,72(sp)
    800212c4:	e0a2                	sd	s0,64(sp)
    800212c6:	fc26                	sd	s1,56(sp)
    800212c8:	f84a                	sd	s2,48(sp)
    800212ca:	f44e                	sd	s3,40(sp)
    800212cc:	f052                	sd	s4,32(sp)
    800212ce:	ec56                	sd	s5,24(sp)
    800212d0:	e85a                	sd	s6,16(sp)
    800212d2:	e45e                	sd	s7,8(sp)
    800212d4:	e062                	sd	s8,0(sp)
    800212d6:	0880                	addi	s0,sp,80
    800212d8:	8b36                	mv	s6,a3
    800212da:	8bb2                	mv	s7,a2
    800212dc:	8aae                	mv	s5,a1
    800212de:	8c2a                	mv	s8,a0
  uint64 pa, i = 0, ki = 0;
    800212e0:	4901                	li	s2,0
    800212e2:	a011                	j	800212e6 <uvmcopy+0x2a>
    memmove(mem, (char*)pa, PGSIZE);
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) {
      kfree(mem);
      goto err;
    }
    i += PGSIZE;
    800212e4:	8952                	mv	s2,s4
    if((pte = walk(old, i, 0)) == NULL)
    800212e6:	4601                	li	a2,0
    800212e8:	85ca                	mv	a1,s2
    800212ea:	8562                	mv	a0,s8
    800212ec:	00000097          	auipc	ra,0x0
    800212f0:	894080e7          	jalr	-1900(ra) # 80020b80 <walk>
    800212f4:	c135                	beqz	a0,80021358 <uvmcopy+0x9c>
    if((*pte & PTE_V) == 0)
    800212f6:	6118                	ld	a4,0(a0)
    800212f8:	00177793          	andi	a5,a4,1
    800212fc:	c7b5                	beqz	a5,80021368 <uvmcopy+0xac>
    pa = PTE2PA(*pte);
    800212fe:	00a75593          	srli	a1,a4,0xa
    80021302:	00c59a13          	slli	s4,a1,0xc
    flags = PTE_FLAGS(*pte);
    80021306:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == NULL)
    8002130a:	fffff097          	auipc	ra,0xfffff
    8002130e:	248080e7          	jalr	584(ra) # 80020552 <kalloc>
    80021312:	89aa                	mv	s3,a0
    80021314:	c92d                	beqz	a0,80021386 <uvmcopy+0xca>
    memmove(mem, (char*)pa, PGSIZE);
    80021316:	6605                	lui	a2,0x1
    80021318:	85d2                	mv	a1,s4
    8002131a:	fffff097          	auipc	ra,0xfffff
    8002131e:	4ae080e7          	jalr	1198(ra) # 800207c8 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) {
    80021322:	2481                	sext.w	s1,s1
    80021324:	8726                	mv	a4,s1
    80021326:	86ce                	mv	a3,s3
    80021328:	6605                	lui	a2,0x1
    8002132a:	85ca                	mv	a1,s2
    8002132c:	8556                	mv	a0,s5
    8002132e:	00000097          	auipc	ra,0x0
    80021332:	9b2080e7          	jalr	-1614(ra) # 80020ce0 <mappages>
    80021336:	e129                	bnez	a0,80021378 <uvmcopy+0xbc>
    i += PGSIZE;
    80021338:	6a05                	lui	s4,0x1
    8002133a:	9a4a                	add	s4,s4,s2
    if(mappages(knew, ki, PGSIZE, (uint64)mem, flags & ~PTE_U) != 0){
    8002133c:	3ef4f713          	andi	a4,s1,1007
    80021340:	86ce                	mv	a3,s3
    80021342:	6605                	lui	a2,0x1
    80021344:	85ca                	mv	a1,s2
    80021346:	855e                	mv	a0,s7
    80021348:	00000097          	auipc	ra,0x0
    8002134c:	998080e7          	jalr	-1640(ra) # 80020ce0 <mappages>
    80021350:	ed05                	bnez	a0,80021388 <uvmcopy+0xcc>
  while (i < sz){
    80021352:	f96a69e3          	bltu	s4,s6,800212e4 <uvmcopy+0x28>
    80021356:	a8a1                	j	800213ae <uvmcopy+0xf2>
      panic("uvmcopy: pte should exist");
    80021358:	0000a517          	auipc	a0,0xa
    8002135c:	06050513          	addi	a0,a0,96 # 8002b3b8 <etext+0x3b8>
    80021360:	fffff097          	auipc	ra,0xfffff
    80021364:	de6080e7          	jalr	-538(ra) # 80020146 <panic>
      panic("uvmcopy: page not present");
    80021368:	0000a517          	auipc	a0,0xa
    8002136c:	07050513          	addi	a0,a0,112 # 8002b3d8 <etext+0x3d8>
    80021370:	fffff097          	auipc	ra,0xfffff
    80021374:	dd6080e7          	jalr	-554(ra) # 80020146 <panic>
      kfree(mem);
    80021378:	854e                	mv	a0,s3
    8002137a:	fffff097          	auipc	ra,0xfffff
    8002137e:	0be080e7          	jalr	190(ra) # 80020438 <kfree>
      goto err;
    80021382:	8a4a                	mv	s4,s2
    80021384:	a011                	j	80021388 <uvmcopy+0xcc>
    80021386:	8a4a                	mv	s4,s2
    ki += PGSIZE;
  }
  return 0;

 err:
  vmunmap(knew, 0, ki / PGSIZE, 0);
    80021388:	4681                	li	a3,0
    8002138a:	00c95613          	srli	a2,s2,0xc
    8002138e:	4581                	li	a1,0
    80021390:	855e                	mv	a0,s7
    80021392:	00000097          	auipc	ra,0x0
    80021396:	baa080e7          	jalr	-1110(ra) # 80020f3c <vmunmap>
  vmunmap(new, 0, i / PGSIZE, 1);
    8002139a:	4685                	li	a3,1
    8002139c:	00ca5613          	srli	a2,s4,0xc
    800213a0:	4581                	li	a1,0
    800213a2:	8556                	mv	a0,s5
    800213a4:	00000097          	auipc	ra,0x0
    800213a8:	b98080e7          	jalr	-1128(ra) # 80020f3c <vmunmap>
  return -1;
    800213ac:	557d                	li	a0,-1
}
    800213ae:	60a6                	ld	ra,72(sp)
    800213b0:	6406                	ld	s0,64(sp)
    800213b2:	74e2                	ld	s1,56(sp)
    800213b4:	7942                	ld	s2,48(sp)
    800213b6:	79a2                	ld	s3,40(sp)
    800213b8:	7a02                	ld	s4,32(sp)
    800213ba:	6ae2                	ld	s5,24(sp)
    800213bc:	6b42                	ld	s6,16(sp)
    800213be:	6ba2                	ld	s7,8(sp)
    800213c0:	6c02                	ld	s8,0(sp)
    800213c2:	6161                	addi	sp,sp,80
    800213c4:	8082                	ret
  return 0;
    800213c6:	4501                	li	a0,0
}
    800213c8:	8082                	ret

00000000800213ca <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    800213ca:	1141                	addi	sp,sp,-16
    800213cc:	e406                	sd	ra,8(sp)
    800213ce:	e022                	sd	s0,0(sp)
    800213d0:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    800213d2:	4601                	li	a2,0
    800213d4:	fffff097          	auipc	ra,0xfffff
    800213d8:	7ac080e7          	jalr	1964(ra) # 80020b80 <walk>
  if(pte == NULL)
    800213dc:	c901                	beqz	a0,800213ec <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    800213de:	611c                	ld	a5,0(a0)
    800213e0:	9bbd                	andi	a5,a5,-17
    800213e2:	e11c                	sd	a5,0(a0)
}
    800213e4:	60a2                	ld	ra,8(sp)
    800213e6:	6402                	ld	s0,0(sp)
    800213e8:	0141                	addi	sp,sp,16
    800213ea:	8082                	ret
    panic("uvmclear");
    800213ec:	0000a517          	auipc	a0,0xa
    800213f0:	00c50513          	addi	a0,a0,12 # 8002b3f8 <etext+0x3f8>
    800213f4:	fffff097          	auipc	ra,0xfffff
    800213f8:	d52080e7          	jalr	-686(ra) # 80020146 <panic>

00000000800213fc <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800213fc:	c6bd                	beqz	a3,8002146a <copyout+0x6e>
{
    800213fe:	715d                	addi	sp,sp,-80
    80021400:	e486                	sd	ra,72(sp)
    80021402:	e0a2                	sd	s0,64(sp)
    80021404:	fc26                	sd	s1,56(sp)
    80021406:	f84a                	sd	s2,48(sp)
    80021408:	f44e                	sd	s3,40(sp)
    8002140a:	f052                	sd	s4,32(sp)
    8002140c:	ec56                	sd	s5,24(sp)
    8002140e:	e85a                	sd	s6,16(sp)
    80021410:	e45e                	sd	s7,8(sp)
    80021412:	e062                	sd	s8,0(sp)
    80021414:	0880                	addi	s0,sp,80
    80021416:	8baa                	mv	s7,a0
    80021418:	8a2e                	mv	s4,a1
    8002141a:	8ab2                	mv	s5,a2
    8002141c:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    8002141e:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == NULL)
      return -1;
    n = PGSIZE - (dstva - va0);
    80021420:	6b05                	lui	s6,0x1
    80021422:	a015                	j	80021446 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80021424:	9552                	add	a0,a0,s4
    80021426:	0004861b          	sext.w	a2,s1
    8002142a:	85d6                	mv	a1,s5
    8002142c:	41250533          	sub	a0,a0,s2
    80021430:	fffff097          	auipc	ra,0xfffff
    80021434:	398080e7          	jalr	920(ra) # 800207c8 <memmove>

    len -= n;
    80021438:	409989b3          	sub	s3,s3,s1
    src += n;
    8002143c:	9aa6                	add	s5,s5,s1
    dstva = va0 + PGSIZE;
    8002143e:	01690a33          	add	s4,s2,s6
  while(len > 0){
    80021442:	02098263          	beqz	s3,80021466 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80021446:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    8002144a:	85ca                	mv	a1,s2
    8002144c:	855e                	mv	a0,s7
    8002144e:	fffff097          	auipc	ra,0xfffff
    80021452:	7d8080e7          	jalr	2008(ra) # 80020c26 <walkaddr>
    if(pa0 == NULL)
    80021456:	cd01                	beqz	a0,8002146e <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80021458:	414904b3          	sub	s1,s2,s4
    8002145c:	94da                	add	s1,s1,s6
    if(n > len)
    8002145e:	fc99f3e3          	bgeu	s3,s1,80021424 <copyout+0x28>
    80021462:	84ce                	mv	s1,s3
    80021464:	b7c1                	j	80021424 <copyout+0x28>
  }
  return 0;
    80021466:	4501                	li	a0,0
    80021468:	a021                	j	80021470 <copyout+0x74>
    8002146a:	4501                	li	a0,0
}
    8002146c:	8082                	ret
      return -1;
    8002146e:	557d                	li	a0,-1
}
    80021470:	60a6                	ld	ra,72(sp)
    80021472:	6406                	ld	s0,64(sp)
    80021474:	74e2                	ld	s1,56(sp)
    80021476:	7942                	ld	s2,48(sp)
    80021478:	79a2                	ld	s3,40(sp)
    8002147a:	7a02                	ld	s4,32(sp)
    8002147c:	6ae2                	ld	s5,24(sp)
    8002147e:	6b42                	ld	s6,16(sp)
    80021480:	6ba2                	ld	s7,8(sp)
    80021482:	6c02                	ld	s8,0(sp)
    80021484:	6161                	addi	sp,sp,80
    80021486:	8082                	ret

0000000080021488 <copyout2>:

int
copyout2(uint64 dstva, char *src, uint64 len)
{
    80021488:	7179                	addi	sp,sp,-48
    8002148a:	f406                	sd	ra,40(sp)
    8002148c:	f022                	sd	s0,32(sp)
    8002148e:	ec26                	sd	s1,24(sp)
    80021490:	e84a                	sd	s2,16(sp)
    80021492:	e44e                	sd	s3,8(sp)
    80021494:	1800                	addi	s0,sp,48
    80021496:	84aa                	mv	s1,a0
    80021498:	89ae                	mv	s3,a1
    8002149a:	8932                	mv	s2,a2
  uint64 sz = myproc()->sz;
    8002149c:	00000097          	auipc	ra,0x0
    800214a0:	6e6080e7          	jalr	1766(ra) # 80021b82 <myproc>
    800214a4:	653c                	ld	a5,72(a0)
  if (dstva + len > sz || dstva >= sz) {
    800214a6:	01248733          	add	a4,s1,s2
    800214aa:	02e7e463          	bltu	a5,a4,800214d2 <copyout2+0x4a>
    800214ae:	02f4f463          	bgeu	s1,a5,800214d6 <copyout2+0x4e>
    return -1;
  }
  memmove((void *)dstva, src, len);
    800214b2:	0009061b          	sext.w	a2,s2
    800214b6:	85ce                	mv	a1,s3
    800214b8:	8526                	mv	a0,s1
    800214ba:	fffff097          	auipc	ra,0xfffff
    800214be:	30e080e7          	jalr	782(ra) # 800207c8 <memmove>
  return 0;
    800214c2:	4501                	li	a0,0
}
    800214c4:	70a2                	ld	ra,40(sp)
    800214c6:	7402                	ld	s0,32(sp)
    800214c8:	64e2                	ld	s1,24(sp)
    800214ca:	6942                	ld	s2,16(sp)
    800214cc:	69a2                	ld	s3,8(sp)
    800214ce:	6145                	addi	sp,sp,48
    800214d0:	8082                	ret
    return -1;
    800214d2:	557d                	li	a0,-1
    800214d4:	bfc5                	j	800214c4 <copyout2+0x3c>
    800214d6:	557d                	li	a0,-1
    800214d8:	b7f5                	j	800214c4 <copyout2+0x3c>

00000000800214da <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800214da:	caa5                	beqz	a3,8002154a <copyin+0x70>
{
    800214dc:	715d                	addi	sp,sp,-80
    800214de:	e486                	sd	ra,72(sp)
    800214e0:	e0a2                	sd	s0,64(sp)
    800214e2:	fc26                	sd	s1,56(sp)
    800214e4:	f84a                	sd	s2,48(sp)
    800214e6:	f44e                	sd	s3,40(sp)
    800214e8:	f052                	sd	s4,32(sp)
    800214ea:	ec56                	sd	s5,24(sp)
    800214ec:	e85a                	sd	s6,16(sp)
    800214ee:	e45e                	sd	s7,8(sp)
    800214f0:	e062                	sd	s8,0(sp)
    800214f2:	0880                	addi	s0,sp,80
    800214f4:	8baa                	mv	s7,a0
    800214f6:	8aae                	mv	s5,a1
    800214f8:	8a32                	mv	s4,a2
    800214fa:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    800214fc:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == NULL)
      return -1;
    n = PGSIZE - (srcva - va0);
    800214fe:	6b05                	lui	s6,0x1
    80021500:	a01d                	j	80021526 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80021502:	014505b3          	add	a1,a0,s4
    80021506:	0004861b          	sext.w	a2,s1
    8002150a:	412585b3          	sub	a1,a1,s2
    8002150e:	8556                	mv	a0,s5
    80021510:	fffff097          	auipc	ra,0xfffff
    80021514:	2b8080e7          	jalr	696(ra) # 800207c8 <memmove>

    len -= n;
    80021518:	409989b3          	sub	s3,s3,s1
    dst += n;
    8002151c:	9aa6                	add	s5,s5,s1
    srcva = va0 + PGSIZE;
    8002151e:	01690a33          	add	s4,s2,s6
  while(len > 0){
    80021522:	02098263          	beqz	s3,80021546 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80021526:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    8002152a:	85ca                	mv	a1,s2
    8002152c:	855e                	mv	a0,s7
    8002152e:	fffff097          	auipc	ra,0xfffff
    80021532:	6f8080e7          	jalr	1784(ra) # 80020c26 <walkaddr>
    if(pa0 == NULL)
    80021536:	cd01                	beqz	a0,8002154e <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80021538:	414904b3          	sub	s1,s2,s4
    8002153c:	94da                	add	s1,s1,s6
    if(n > len)
    8002153e:	fc99f2e3          	bgeu	s3,s1,80021502 <copyin+0x28>
    80021542:	84ce                	mv	s1,s3
    80021544:	bf7d                	j	80021502 <copyin+0x28>
  }
  return 0;
    80021546:	4501                	li	a0,0
    80021548:	a021                	j	80021550 <copyin+0x76>
    8002154a:	4501                	li	a0,0
}
    8002154c:	8082                	ret
      return -1;
    8002154e:	557d                	li	a0,-1
}
    80021550:	60a6                	ld	ra,72(sp)
    80021552:	6406                	ld	s0,64(sp)
    80021554:	74e2                	ld	s1,56(sp)
    80021556:	7942                	ld	s2,48(sp)
    80021558:	79a2                	ld	s3,40(sp)
    8002155a:	7a02                	ld	s4,32(sp)
    8002155c:	6ae2                	ld	s5,24(sp)
    8002155e:	6b42                	ld	s6,16(sp)
    80021560:	6ba2                	ld	s7,8(sp)
    80021562:	6c02                	ld	s8,0(sp)
    80021564:	6161                	addi	sp,sp,80
    80021566:	8082                	ret

0000000080021568 <copyin2>:

int
copyin2(char *dst, uint64 srcva, uint64 len)
{
    80021568:	7179                	addi	sp,sp,-48
    8002156a:	f406                	sd	ra,40(sp)
    8002156c:	f022                	sd	s0,32(sp)
    8002156e:	ec26                	sd	s1,24(sp)
    80021570:	e84a                	sd	s2,16(sp)
    80021572:	e44e                	sd	s3,8(sp)
    80021574:	1800                	addi	s0,sp,48
    80021576:	89aa                	mv	s3,a0
    80021578:	84ae                	mv	s1,a1
    8002157a:	8932                	mv	s2,a2
  uint64 sz = myproc()->sz;
    8002157c:	00000097          	auipc	ra,0x0
    80021580:	606080e7          	jalr	1542(ra) # 80021b82 <myproc>
    80021584:	653c                	ld	a5,72(a0)
  if (srcva + len > sz || srcva >= sz) {
    80021586:	01248733          	add	a4,s1,s2
    8002158a:	02e7e463          	bltu	a5,a4,800215b2 <copyin2+0x4a>
    8002158e:	02f4f463          	bgeu	s1,a5,800215b6 <copyin2+0x4e>
    return -1;
  }
  memmove(dst, (void *)srcva, len);
    80021592:	0009061b          	sext.w	a2,s2
    80021596:	85a6                	mv	a1,s1
    80021598:	854e                	mv	a0,s3
    8002159a:	fffff097          	auipc	ra,0xfffff
    8002159e:	22e080e7          	jalr	558(ra) # 800207c8 <memmove>
  return 0;
    800215a2:	4501                	li	a0,0
}
    800215a4:	70a2                	ld	ra,40(sp)
    800215a6:	7402                	ld	s0,32(sp)
    800215a8:	64e2                	ld	s1,24(sp)
    800215aa:	6942                	ld	s2,16(sp)
    800215ac:	69a2                	ld	s3,8(sp)
    800215ae:	6145                	addi	sp,sp,48
    800215b0:	8082                	ret
    return -1;
    800215b2:	557d                	li	a0,-1
    800215b4:	bfc5                	j	800215a4 <copyin2+0x3c>
    800215b6:	557d                	li	a0,-1
    800215b8:	b7f5                	j	800215a4 <copyin2+0x3c>

00000000800215ba <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    800215ba:	cecd                	beqz	a3,80021674 <copyinstr+0xba>
{
    800215bc:	715d                	addi	sp,sp,-80
    800215be:	e486                	sd	ra,72(sp)
    800215c0:	e0a2                	sd	s0,64(sp)
    800215c2:	fc26                	sd	s1,56(sp)
    800215c4:	f84a                	sd	s2,48(sp)
    800215c6:	f44e                	sd	s3,40(sp)
    800215c8:	f052                	sd	s4,32(sp)
    800215ca:	ec56                	sd	s5,24(sp)
    800215cc:	e85a                	sd	s6,16(sp)
    800215ce:	e45e                	sd	s7,8(sp)
    800215d0:	e062                	sd	s8,0(sp)
    800215d2:	0880                	addi	s0,sp,80
    800215d4:	8aaa                	mv	s5,a0
    800215d6:	84ae                	mv	s1,a1
    800215d8:	8c32                	mv	s8,a2
    800215da:	8bb6                	mv	s7,a3
    va0 = PGROUNDDOWN(srcva);
    800215dc:	7a7d                	lui	s4,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == NULL)
      return -1;
    n = PGSIZE - (srcva - va0);
    800215de:	6985                	lui	s3,0x1
    800215e0:	4b05                	li	s6,1
    800215e2:	a801                	j	800215f2 <copyinstr+0x38>
    if(n > max)
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
    800215e4:	87a6                	mv	a5,s1
    800215e6:	a085                	j	80021646 <copyinstr+0x8c>
        *dst = *p;
      }
      --n;
      --max;
      p++;
      dst++;
    800215e8:	84b2                	mv	s1,a2
    }

    srcva = va0 + PGSIZE;
    800215ea:	01390c33          	add	s8,s2,s3
  while(got_null == 0 && max > 0){
    800215ee:	060b8f63          	beqz	s7,8002166c <copyinstr+0xb2>
    va0 = PGROUNDDOWN(srcva);
    800215f2:	014c7933          	and	s2,s8,s4
    pa0 = walkaddr(pagetable, va0);
    800215f6:	85ca                	mv	a1,s2
    800215f8:	8556                	mv	a0,s5
    800215fa:	fffff097          	auipc	ra,0xfffff
    800215fe:	62c080e7          	jalr	1580(ra) # 80020c26 <walkaddr>
    if(pa0 == NULL)
    80021602:	c53d                	beqz	a0,80021670 <copyinstr+0xb6>
    n = PGSIZE - (srcva - va0);
    80021604:	41890633          	sub	a2,s2,s8
    80021608:	964e                	add	a2,a2,s3
    if(n > max)
    8002160a:	00cbf363          	bgeu	s7,a2,80021610 <copyinstr+0x56>
    8002160e:	865e                	mv	a2,s7
    char *p = (char *) (pa0 + (srcva - va0));
    80021610:	9562                	add	a0,a0,s8
    80021612:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80021616:	da71                	beqz	a2,800215ea <copyinstr+0x30>
      if(*p == '\0'){
    80021618:	00054703          	lbu	a4,0(a0)
    8002161c:	d761                	beqz	a4,800215e4 <copyinstr+0x2a>
    8002161e:	9626                	add	a2,a2,s1
    80021620:	87a6                	mv	a5,s1
    80021622:	1bfd                	addi	s7,s7,-1
    80021624:	009b86b3          	add	a3,s7,s1
    80021628:	409b04b3          	sub	s1,s6,s1
    8002162c:	94aa                	add	s1,s1,a0
        *dst = *p;
    8002162e:	00e78023          	sb	a4,0(a5) # 1000 <BASE_ADDRESS-0x8001f000>
      --max;
    80021632:	40f68bb3          	sub	s7,a3,a5
      p++;
    80021636:	00f48733          	add	a4,s1,a5
      dst++;
    8002163a:	0785                	addi	a5,a5,1
    while(n > 0){
    8002163c:	faf606e3          	beq	a2,a5,800215e8 <copyinstr+0x2e>
      if(*p == '\0'){
    80021640:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <kernel_end+0xffffffff7ffb9000>
    80021644:	f76d                	bnez	a4,8002162e <copyinstr+0x74>
        *dst = '\0';
    80021646:	00078023          	sb	zero,0(a5)
    8002164a:	4785                	li	a5,1
  }
  if(got_null){
    8002164c:	0017b793          	seqz	a5,a5
    80021650:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80021654:	60a6                	ld	ra,72(sp)
    80021656:	6406                	ld	s0,64(sp)
    80021658:	74e2                	ld	s1,56(sp)
    8002165a:	7942                	ld	s2,48(sp)
    8002165c:	79a2                	ld	s3,40(sp)
    8002165e:	7a02                	ld	s4,32(sp)
    80021660:	6ae2                	ld	s5,24(sp)
    80021662:	6b42                	ld	s6,16(sp)
    80021664:	6ba2                	ld	s7,8(sp)
    80021666:	6c02                	ld	s8,0(sp)
    80021668:	6161                	addi	sp,sp,80
    8002166a:	8082                	ret
    8002166c:	4781                	li	a5,0
    8002166e:	bff9                	j	8002164c <copyinstr+0x92>
      return -1;
    80021670:	557d                	li	a0,-1
    80021672:	b7cd                	j	80021654 <copyinstr+0x9a>
  int got_null = 0;
    80021674:	4781                	li	a5,0
  if(got_null){
    80021676:	0017b793          	seqz	a5,a5
    8002167a:	40f00533          	neg	a0,a5
}
    8002167e:	8082                	ret

0000000080021680 <copyinstr2>:

int
copyinstr2(char *dst, uint64 srcva, uint64 max)
{
    80021680:	7179                	addi	sp,sp,-48
    80021682:	f406                	sd	ra,40(sp)
    80021684:	f022                	sd	s0,32(sp)
    80021686:	ec26                	sd	s1,24(sp)
    80021688:	e84a                	sd	s2,16(sp)
    8002168a:	e44e                	sd	s3,8(sp)
    8002168c:	1800                	addi	s0,sp,48
    8002168e:	89aa                	mv	s3,a0
    80021690:	84ae                	mv	s1,a1
    80021692:	8932                	mv	s2,a2
  int got_null = 0;
  uint64 sz = myproc()->sz;
    80021694:	00000097          	auipc	ra,0x0
    80021698:	4ee080e7          	jalr	1262(ra) # 80021b82 <myproc>
    8002169c:	6534                	ld	a3,72(a0)
  while(srcva < sz && max > 0){
    8002169e:	04d4f863          	bgeu	s1,a3,800216ee <copyinstr2+0x6e>
    800216a2:	04090863          	beqz	s2,800216f2 <copyinstr2+0x72>
    char *p = (char *)srcva;
    if(*p == '\0'){
    800216a6:	0004c703          	lbu	a4,0(s1)
    800216aa:	cf15                	beqz	a4,800216e6 <copyinstr2+0x66>
    800216ac:	8e85                	sub	a3,a3,s1
    800216ae:	96ce                	add	a3,a3,s3
    800216b0:	01298633          	add	a2,s3,s2
    800216b4:	87ce                	mv	a5,s3
    800216b6:	413485b3          	sub	a1,s1,s3
      *dst = '\0';
      got_null = 1;
      break;
    } else {
      *dst = *p;
    800216ba:	00e78023          	sb	a4,0(a5)
    }
    --max;
    srcva++;
    dst++;
    800216be:	0785                	addi	a5,a5,1
  while(srcva < sz && max > 0){
    800216c0:	02f68b63          	beq	a3,a5,800216f6 <copyinstr2+0x76>
    800216c4:	02c78363          	beq	a5,a2,800216ea <copyinstr2+0x6a>
    if(*p == '\0'){
    800216c8:	00b78733          	add	a4,a5,a1
    800216cc:	00074703          	lbu	a4,0(a4)
    800216d0:	f76d                	bnez	a4,800216ba <copyinstr2+0x3a>
      *dst = '\0';
    800216d2:	00078023          	sb	zero,0(a5)
  }
  if(got_null){
    return 0;
    800216d6:	4501                	li	a0,0
  } else {
    return -1;
  }
}
    800216d8:	70a2                	ld	ra,40(sp)
    800216da:	7402                	ld	s0,32(sp)
    800216dc:	64e2                	ld	s1,24(sp)
    800216de:	6942                	ld	s2,16(sp)
    800216e0:	69a2                	ld	s3,8(sp)
    800216e2:	6145                	addi	sp,sp,48
    800216e4:	8082                	ret
    if(*p == '\0'){
    800216e6:	87ce                	mv	a5,s3
    800216e8:	b7ed                	j	800216d2 <copyinstr2+0x52>
    return -1;
    800216ea:	557d                	li	a0,-1
    800216ec:	b7f5                	j	800216d8 <copyinstr2+0x58>
    800216ee:	557d                	li	a0,-1
    800216f0:	b7e5                	j	800216d8 <copyinstr2+0x58>
    800216f2:	557d                	li	a0,-1
    800216f4:	b7d5                	j	800216d8 <copyinstr2+0x58>
    800216f6:	557d                	li	a0,-1
    800216f8:	b7c5                	j	800216d8 <copyinstr2+0x58>

00000000800216fa <kfreewalk>:
}

// only free page table, not physical pages
void
kfreewalk(pagetable_t kpt)
{
    800216fa:	7179                	addi	sp,sp,-48
    800216fc:	f406                	sd	ra,40(sp)
    800216fe:	f022                	sd	s0,32(sp)
    80021700:	ec26                	sd	s1,24(sp)
    80021702:	e84a                	sd	s2,16(sp)
    80021704:	e44e                	sd	s3,8(sp)
    80021706:	e052                	sd	s4,0(sp)
    80021708:	1800                	addi	s0,sp,48
    8002170a:	8a2a                	mv	s4,a0
  for (int i = 0; i < 512; i++) {
    8002170c:	84aa                	mv	s1,a0
    8002170e:	6905                	lui	s2,0x1
    80021710:	992a                	add	s2,s2,a0
    pte_t pte = kpt[i];
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    80021712:	4985                	li	s3,1
    80021714:	a821                	j	8002172c <kfreewalk+0x32>
      kfreewalk((pagetable_t) PTE2PA(pte));
    80021716:	8129                	srli	a0,a0,0xa
    80021718:	0532                	slli	a0,a0,0xc
    8002171a:	00000097          	auipc	ra,0x0
    8002171e:	fe0080e7          	jalr	-32(ra) # 800216fa <kfreewalk>
      kpt[i] = 0;
    80021722:	0004b023          	sd	zero,0(s1)
    80021726:	04a1                	addi	s1,s1,8
  for (int i = 0; i < 512; i++) {
    80021728:	01248963          	beq	s1,s2,8002173a <kfreewalk+0x40>
    pte_t pte = kpt[i];
    8002172c:	6088                	ld	a0,0(s1)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    8002172e:	00f57793          	andi	a5,a0,15
    80021732:	ff3782e3          	beq	a5,s3,80021716 <kfreewalk+0x1c>
    } else if (pte & PTE_V) {
    80021736:	8905                	andi	a0,a0,1
    80021738:	d57d                	beqz	a0,80021726 <kfreewalk+0x2c>
      break;
    }
  }
  kfree((void *) kpt);
    8002173a:	8552                	mv	a0,s4
    8002173c:	fffff097          	auipc	ra,0xfffff
    80021740:	cfc080e7          	jalr	-772(ra) # 80020438 <kfree>
}
    80021744:	70a2                	ld	ra,40(sp)
    80021746:	7402                	ld	s0,32(sp)
    80021748:	64e2                	ld	s1,24(sp)
    8002174a:	6942                	ld	s2,16(sp)
    8002174c:	69a2                	ld	s3,8(sp)
    8002174e:	6a02                	ld	s4,0(sp)
    80021750:	6145                	addi	sp,sp,48
    80021752:	8082                	ret

0000000080021754 <kvmfreeusr>:

void
kvmfreeusr(pagetable_t kpt)
{
    80021754:	1101                	addi	sp,sp,-32
    80021756:	ec06                	sd	ra,24(sp)
    80021758:	e822                	sd	s0,16(sp)
    8002175a:	e426                	sd	s1,8(sp)
    8002175c:	1000                	addi	s0,sp,32
    8002175e:	84aa                	mv	s1,a0
  pte_t pte;
  for (int i = 0; i < PX(2, MAXUVA); i++) {
    pte = kpt[i];
    80021760:	6108                	ld	a0,0(a0)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    80021762:	00f57713          	andi	a4,a0,15
    80021766:	4785                	li	a5,1
    80021768:	00f70d63          	beq	a4,a5,80021782 <kvmfreeusr+0x2e>
    pte = kpt[i];
    8002176c:	6488                	ld	a0,8(s1)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    8002176e:	00f57713          	andi	a4,a0,15
    80021772:	4785                	li	a5,1
    80021774:	02f70063          	beq	a4,a5,80021794 <kvmfreeusr+0x40>
      kfreewalk((pagetable_t) PTE2PA(pte));
      kpt[i] = 0;
    }
  }
}
    80021778:	60e2                	ld	ra,24(sp)
    8002177a:	6442                	ld	s0,16(sp)
    8002177c:	64a2                	ld	s1,8(sp)
    8002177e:	6105                	addi	sp,sp,32
    80021780:	8082                	ret
      kfreewalk((pagetable_t) PTE2PA(pte));
    80021782:	8129                	srli	a0,a0,0xa
    80021784:	0532                	slli	a0,a0,0xc
    80021786:	00000097          	auipc	ra,0x0
    8002178a:	f74080e7          	jalr	-140(ra) # 800216fa <kfreewalk>
      kpt[i] = 0;
    8002178e:	0004b023          	sd	zero,0(s1)
    80021792:	bfe9                	j	8002176c <kvmfreeusr+0x18>
      kfreewalk((pagetable_t) PTE2PA(pte));
    80021794:	8129                	srli	a0,a0,0xa
    80021796:	0532                	slli	a0,a0,0xc
    80021798:	00000097          	auipc	ra,0x0
    8002179c:	f62080e7          	jalr	-158(ra) # 800216fa <kfreewalk>
      kpt[i] = 0;
    800217a0:	0004b423          	sd	zero,8(s1)
}
    800217a4:	bfd1                	j	80021778 <kvmfreeusr+0x24>

00000000800217a6 <kvmfree>:

void
kvmfree(pagetable_t kpt, int stack_free)
{
    800217a6:	1101                	addi	sp,sp,-32
    800217a8:	ec06                	sd	ra,24(sp)
    800217aa:	e822                	sd	s0,16(sp)
    800217ac:	e426                	sd	s1,8(sp)
    800217ae:	1000                	addi	s0,sp,32
    800217b0:	84aa                	mv	s1,a0
  if (stack_free) {
    800217b2:	e185                	bnez	a1,800217d2 <kvmfree+0x2c>
    pte_t pte = kpt[PX(2, VKSTACK)];
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
      kfreewalk((pagetable_t) PTE2PA(pte));
    }
  }
  kvmfreeusr(kpt);
    800217b4:	8526                	mv	a0,s1
    800217b6:	00000097          	auipc	ra,0x0
    800217ba:	f9e080e7          	jalr	-98(ra) # 80021754 <kvmfreeusr>
  kfree(kpt);
    800217be:	8526                	mv	a0,s1
    800217c0:	fffff097          	auipc	ra,0xfffff
    800217c4:	c78080e7          	jalr	-904(ra) # 80020438 <kfree>
}
    800217c8:	60e2                	ld	ra,24(sp)
    800217ca:	6442                	ld	s0,16(sp)
    800217cc:	64a2                	ld	s1,8(sp)
    800217ce:	6105                	addi	sp,sp,32
    800217d0:	8082                	ret
    vmunmap(kpt, VKSTACK, 1, 1);
    800217d2:	4685                	li	a3,1
    800217d4:	4605                	li	a2,1
    800217d6:	0fb00593          	li	a1,251
    800217da:	05fa                	slli	a1,a1,0x1e
    800217dc:	fffff097          	auipc	ra,0xfffff
    800217e0:	760080e7          	jalr	1888(ra) # 80020f3c <vmunmap>
    pte_t pte = kpt[PX(2, VKSTACK)];
    800217e4:	7d84b503          	ld	a0,2008(s1)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    800217e8:	00f57713          	andi	a4,a0,15
    800217ec:	4785                	li	a5,1
    800217ee:	fcf713e3          	bne	a4,a5,800217b4 <kvmfree+0xe>
      kfreewalk((pagetable_t) PTE2PA(pte));
    800217f2:	8129                	srli	a0,a0,0xa
    800217f4:	0532                	slli	a0,a0,0xc
    800217f6:	00000097          	auipc	ra,0x0
    800217fa:	f04080e7          	jalr	-252(ra) # 800216fa <kfreewalk>
    800217fe:	bf5d                	j	800217b4 <kvmfree+0xe>

0000000080021800 <proc_kpagetable>:
{
    80021800:	1101                	addi	sp,sp,-32
    80021802:	ec06                	sd	ra,24(sp)
    80021804:	e822                	sd	s0,16(sp)
    80021806:	e426                	sd	s1,8(sp)
    80021808:	1000                	addi	s0,sp,32
  pagetable_t kpt = (pagetable_t) kalloc();
    8002180a:	fffff097          	auipc	ra,0xfffff
    8002180e:	d48080e7          	jalr	-696(ra) # 80020552 <kalloc>
    80021812:	84aa                	mv	s1,a0
  if (kpt == NULL)
    80021814:	cd05                	beqz	a0,8002184c <proc_kpagetable+0x4c>
  memmove(kpt, kernel_pagetable, PGSIZE);
    80021816:	6605                	lui	a2,0x1
    80021818:	00016797          	auipc	a5,0x16
    8002181c:	84078793          	addi	a5,a5,-1984 # 80037058 <kernel_pagetable>
    80021820:	638c                	ld	a1,0(a5)
    80021822:	fffff097          	auipc	ra,0xfffff
    80021826:	fa6080e7          	jalr	-90(ra) # 800207c8 <memmove>
  char *pstack = kalloc();
    8002182a:	fffff097          	auipc	ra,0xfffff
    8002182e:	d28080e7          	jalr	-728(ra) # 80020552 <kalloc>
  if(pstack == NULL)
    80021832:	c11d                	beqz	a0,80021858 <proc_kpagetable+0x58>
  if (mappages(kpt, VKSTACK, PGSIZE, (uint64)pstack, PTE_R | PTE_W) != 0)
    80021834:	4719                	li	a4,6
    80021836:	86aa                	mv	a3,a0
    80021838:	6605                	lui	a2,0x1
    8002183a:	0fb00593          	li	a1,251
    8002183e:	05fa                	slli	a1,a1,0x1e
    80021840:	8526                	mv	a0,s1
    80021842:	fffff097          	auipc	ra,0xfffff
    80021846:	49e080e7          	jalr	1182(ra) # 80020ce0 <mappages>
    8002184a:	e519                	bnez	a0,80021858 <proc_kpagetable+0x58>
}
    8002184c:	8526                	mv	a0,s1
    8002184e:	60e2                	ld	ra,24(sp)
    80021850:	6442                	ld	s0,16(sp)
    80021852:	64a2                	ld	s1,8(sp)
    80021854:	6105                	addi	sp,sp,32
    80021856:	8082                	ret
  kvmfree(kpt, 1);
    80021858:	4585                	li	a1,1
    8002185a:	8526                	mv	a0,s1
    8002185c:	00000097          	auipc	ra,0x0
    80021860:	f4a080e7          	jalr	-182(ra) # 800217a6 <kvmfree>
  return NULL;
    80021864:	4481                	li	s1,0
    80021866:	b7dd                	j	8002184c <proc_kpagetable+0x4c>

0000000080021868 <vmprint>:

void vmprint(pagetable_t pagetable)
{
    80021868:	7119                	addi	sp,sp,-128
    8002186a:	fc86                	sd	ra,120(sp)
    8002186c:	f8a2                	sd	s0,112(sp)
    8002186e:	f4a6                	sd	s1,104(sp)
    80021870:	f0ca                	sd	s2,96(sp)
    80021872:	ecce                	sd	s3,88(sp)
    80021874:	e8d2                	sd	s4,80(sp)
    80021876:	e4d6                	sd	s5,72(sp)
    80021878:	e0da                	sd	s6,64(sp)
    8002187a:	fc5e                	sd	s7,56(sp)
    8002187c:	f862                	sd	s8,48(sp)
    8002187e:	f466                	sd	s9,40(sp)
    80021880:	f06a                	sd	s10,32(sp)
    80021882:	ec6e                	sd	s11,24(sp)
    80021884:	0100                	addi	s0,sp,128
    80021886:	8baa                	mv	s7,a0
    80021888:	f8a43023          	sd	a0,-128(s0)
  const int capacity = 512;
  printf("page table %p\n", pagetable);
    8002188c:	85aa                	mv	a1,a0
    8002188e:	0000a517          	auipc	a0,0xa
    80021892:	b7a50513          	addi	a0,a0,-1158 # 8002b408 <etext+0x408>
    80021896:	fffff097          	auipc	ra,0xfffff
    8002189a:	8fa080e7          	jalr	-1798(ra) # 80020190 <printf>
  for (pte_t *pte = (pte_t *) pagetable; pte < pagetable + capacity; pte++) {
    8002189e:	6d05                	lui	s10,0x1
    800218a0:	9d5e                	add	s10,s10,s7
    800218a2:	6c05                	lui	s8,0x1

      for (pte_t *pte2 = (pte_t *) pt2; pte2 < pt2 + capacity; pte2++) {
        if (*pte2 & PTE_V)
        {
          pagetable_t pt3 = (pagetable_t) PTE2PA(*pte2);
          printf(".. ..%d: pte %p pa %p\n", pte2 - pt2, *pte2, pt3);
    800218a4:	0000ad97          	auipc	s11,0xa
    800218a8:	b8cd8d93          	addi	s11,s11,-1140 # 8002b430 <etext+0x430>
    800218ac:	20000793          	li	a5,512
    800218b0:	f8f43423          	sd	a5,-120(s0)

          for (pte_t *pte3 = (pte_t *) pt3; pte3 < pt3 + capacity; pte3++)
            if (*pte3 & PTE_V)
              printf(".. .. ..%d: pte %p pa %p\n", pte3 - pt3, *pte3, PTE2PA(*pte3));
    800218b4:	0000aa17          	auipc	s4,0xa
    800218b8:	b94a0a13          	addi	s4,s4,-1132 # 8002b448 <etext+0x448>
    800218bc:	a88d                	j	8002192e <vmprint+0xc6>
    800218be:	00a65693          	srli	a3,a2,0xa
    800218c2:	413485b3          	sub	a1,s1,s3
    800218c6:	06b2                	slli	a3,a3,0xc
    800218c8:	858d                	srai	a1,a1,0x3
    800218ca:	8552                	mv	a0,s4
    800218cc:	fffff097          	auipc	ra,0xfffff
    800218d0:	8c4080e7          	jalr	-1852(ra) # 80020190 <printf>
          for (pte_t *pte3 = (pte_t *) pt3; pte3 < pt3 + capacity; pte3++)
    800218d4:	04a1                	addi	s1,s1,8
    800218d6:	01248763          	beq	s1,s2,800218e4 <vmprint+0x7c>
            if (*pte3 & PTE_V)
    800218da:	6090                	ld	a2,0(s1)
    800218dc:	00167793          	andi	a5,a2,1
    800218e0:	dbf5                	beqz	a5,800218d4 <vmprint+0x6c>
    800218e2:	bff1                	j	800218be <vmprint+0x56>
      for (pte_t *pte2 = (pte_t *) pt2; pte2 < pt2 + capacity; pte2++) {
    800218e4:	0aa1                	addi	s5,s5,8
    800218e6:	056a8163          	beq	s5,s6,80021928 <vmprint+0xc0>
        if (*pte2 & PTE_V)
    800218ea:	000ab603          	ld	a2,0(s5)
    800218ee:	00167793          	andi	a5,a2,1
    800218f2:	dbed                	beqz	a5,800218e4 <vmprint+0x7c>
          pagetable_t pt3 = (pagetable_t) PTE2PA(*pte2);
    800218f4:	00a65493          	srli	s1,a2,0xa
    800218f8:	04b2                	slli	s1,s1,0xc
    800218fa:	89a6                	mv	s3,s1
          printf(".. ..%d: pte %p pa %p\n", pte2 - pt2, *pte2, pt3);
    800218fc:	419a85b3          	sub	a1,s5,s9
    80021900:	86a6                	mv	a3,s1
    80021902:	858d                	srai	a1,a1,0x3
    80021904:	856e                	mv	a0,s11
    80021906:	fffff097          	auipc	ra,0xfffff
    8002190a:	88a080e7          	jalr	-1910(ra) # 80020190 <printf>
          for (pte_t *pte3 = (pte_t *) pt3; pte3 < pt3 + capacity; pte3++)
    8002190e:	00848693          	addi	a3,s1,8
    80021912:	01848733          	add	a4,s1,s8
    80021916:	f8843783          	ld	a5,-120(s0)
    8002191a:	00d77363          	bgeu	a4,a3,80021920 <vmprint+0xb8>
    8002191e:	4785                	li	a5,1
    80021920:	078e                	slli	a5,a5,0x3
    80021922:	00978933          	add	s2,a5,s1
    80021926:	bf55                	j	800218da <vmprint+0x72>
  for (pte_t *pte = (pte_t *) pagetable; pte < pagetable + capacity; pte++) {
    80021928:	0ba1                	addi	s7,s7,8
    8002192a:	05ab8763          	beq	s7,s10,80021978 <vmprint+0x110>
    if (*pte & PTE_V)
    8002192e:	000bb603          	ld	a2,0(s7) # 1000 <BASE_ADDRESS-0x8001f000>
    80021932:	00167793          	andi	a5,a2,1
    80021936:	dbed                	beqz	a5,80021928 <vmprint+0xc0>
      pagetable_t pt2 = (pagetable_t) PTE2PA(*pte); 
    80021938:	00a65a93          	srli	s5,a2,0xa
    8002193c:	0ab2                	slli	s5,s5,0xc
    8002193e:	8cd6                	mv	s9,s5
      printf("..%d: pte %p pa %p\n", pte - pagetable, *pte, pt2);
    80021940:	f8043783          	ld	a5,-128(s0)
    80021944:	40fb87b3          	sub	a5,s7,a5
    80021948:	86d6                	mv	a3,s5
    8002194a:	4037d593          	srai	a1,a5,0x3
    8002194e:	0000a517          	auipc	a0,0xa
    80021952:	aca50513          	addi	a0,a0,-1334 # 8002b418 <etext+0x418>
    80021956:	fffff097          	auipc	ra,0xfffff
    8002195a:	83a080e7          	jalr	-1990(ra) # 80020190 <printf>
      for (pte_t *pte2 = (pte_t *) pt2; pte2 < pt2 + capacity; pte2++) {
    8002195e:	018a86b3          	add	a3,s5,s8
    80021962:	008a8713          	addi	a4,s5,8
    80021966:	20000793          	li	a5,512
    8002196a:	00e6f363          	bgeu	a3,a4,80021970 <vmprint+0x108>
    8002196e:	4785                	li	a5,1
    80021970:	078e                	slli	a5,a5,0x3
    80021972:	01578b33          	add	s6,a5,s5
    80021976:	bf95                	j	800218ea <vmprint+0x82>
        }
      }
    }
  }
  return;
    80021978:	70e6                	ld	ra,120(sp)
    8002197a:	7446                	ld	s0,112(sp)
    8002197c:	74a6                	ld	s1,104(sp)
    8002197e:	7906                	ld	s2,96(sp)
    80021980:	69e6                	ld	s3,88(sp)
    80021982:	6a46                	ld	s4,80(sp)
    80021984:	6aa6                	ld	s5,72(sp)
    80021986:	6b06                	ld	s6,64(sp)
    80021988:	7be2                	ld	s7,56(sp)
    8002198a:	7c42                	ld	s8,48(sp)
    8002198c:	7ca2                	ld	s9,40(sp)
    8002198e:	7d02                	ld	s10,32(sp)
    80021990:	6de2                	ld	s11,24(sp)
    80021992:	6109                	addi	sp,sp,128
    80021994:	8082                	ret

0000000080021996 <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    80021996:	1101                	addi	sp,sp,-32
    80021998:	ec06                	sd	ra,24(sp)
    8002199a:	e822                	sd	s0,16(sp)
    8002199c:	e426                	sd	s1,8(sp)
    8002199e:	1000                	addi	s0,sp,32
    800219a0:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800219a2:	fffff097          	auipc	ra,0xfffff
    800219a6:	cf0080e7          	jalr	-784(ra) # 80020692 <holding>
    800219aa:	c909                	beqz	a0,800219bc <wakeup1+0x26>
    panic("wakeup1");
  if(p->chan == p && p->state == SLEEPING) {
    800219ac:	749c                	ld	a5,40(s1)
    800219ae:	00978f63          	beq	a5,s1,800219cc <wakeup1+0x36>
    p->state = RUNNABLE;
  }
}
    800219b2:	60e2                	ld	ra,24(sp)
    800219b4:	6442                	ld	s0,16(sp)
    800219b6:	64a2                	ld	s1,8(sp)
    800219b8:	6105                	addi	sp,sp,32
    800219ba:	8082                	ret
    panic("wakeup1");
    800219bc:	0000a517          	auipc	a0,0xa
    800219c0:	ad450513          	addi	a0,a0,-1324 # 8002b490 <states.1756+0x28>
    800219c4:	ffffe097          	auipc	ra,0xffffe
    800219c8:	782080e7          	jalr	1922(ra) # 80020146 <panic>
  if(p->chan == p && p->state == SLEEPING) {
    800219cc:	4c98                	lw	a4,24(s1)
    800219ce:	4785                	li	a5,1
    800219d0:	fef711e3          	bne	a4,a5,800219b2 <wakeup1+0x1c>
    p->state = RUNNABLE;
    800219d4:	4789                	li	a5,2
    800219d6:	cc9c                	sw	a5,24(s1)
}
    800219d8:	bfe9                	j	800219b2 <wakeup1+0x1c>

00000000800219da <reg_info>:
void reg_info(void) {
    800219da:	1141                	addi	sp,sp,-16
    800219dc:	e406                	sd	ra,8(sp)
    800219de:	e022                	sd	s0,0(sp)
    800219e0:	0800                	addi	s0,sp,16
  printf("register info: {\n");
    800219e2:	0000a517          	auipc	a0,0xa
    800219e6:	ab650513          	addi	a0,a0,-1354 # 8002b498 <states.1756+0x30>
    800219ea:	ffffe097          	auipc	ra,0xffffe
    800219ee:	7a6080e7          	jalr	1958(ra) # 80020190 <printf>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800219f2:	100025f3          	csrr	a1,sstatus
  printf("sstatus: %p\n", r_sstatus());
    800219f6:	0000a517          	auipc	a0,0xa
    800219fa:	aba50513          	addi	a0,a0,-1350 # 8002b4b0 <states.1756+0x48>
    800219fe:	ffffe097          	auipc	ra,0xffffe
    80021a02:	792080e7          	jalr	1938(ra) # 80020190 <printf>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80021a06:	144025f3          	csrr	a1,sip
  printf("sip: %p\n", r_sip());
    80021a0a:	0000a517          	auipc	a0,0xa
    80021a0e:	ab650513          	addi	a0,a0,-1354 # 8002b4c0 <states.1756+0x58>
    80021a12:	ffffe097          	auipc	ra,0xffffe
    80021a16:	77e080e7          	jalr	1918(ra) # 80020190 <printf>
  asm volatile("csrr %0, sie" : "=r" (x) );
    80021a1a:	104025f3          	csrr	a1,sie
  printf("sie: %p\n", r_sie());
    80021a1e:	0000a517          	auipc	a0,0xa
    80021a22:	ab250513          	addi	a0,a0,-1358 # 8002b4d0 <states.1756+0x68>
    80021a26:	ffffe097          	auipc	ra,0xffffe
    80021a2a:	76a080e7          	jalr	1898(ra) # 80020190 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80021a2e:	141025f3          	csrr	a1,sepc
  printf("sepc: %p\n", r_sepc());
    80021a32:	0000a517          	auipc	a0,0xa
    80021a36:	aae50513          	addi	a0,a0,-1362 # 8002b4e0 <states.1756+0x78>
    80021a3a:	ffffe097          	auipc	ra,0xffffe
    80021a3e:	756080e7          	jalr	1878(ra) # 80020190 <printf>
  asm volatile("csrr %0, stvec" : "=r" (x) );
    80021a42:	105025f3          	csrr	a1,stvec
  printf("stvec: %p\n", r_stvec());
    80021a46:	0000a517          	auipc	a0,0xa
    80021a4a:	aaa50513          	addi	a0,a0,-1366 # 8002b4f0 <states.1756+0x88>
    80021a4e:	ffffe097          	auipc	ra,0xffffe
    80021a52:	742080e7          	jalr	1858(ra) # 80020190 <printf>
  asm volatile("csrr %0, satp" : "=r" (x) );
    80021a56:	180025f3          	csrr	a1,satp
  printf("satp: %p\n", r_satp());
    80021a5a:	0000a517          	auipc	a0,0xa
    80021a5e:	aa650513          	addi	a0,a0,-1370 # 8002b500 <states.1756+0x98>
    80021a62:	ffffe097          	auipc	ra,0xffffe
    80021a66:	72e080e7          	jalr	1838(ra) # 80020190 <printf>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80021a6a:	142025f3          	csrr	a1,scause
  printf("scause: %p\n", r_scause());
    80021a6e:	0000a517          	auipc	a0,0xa
    80021a72:	aa250513          	addi	a0,a0,-1374 # 8002b510 <states.1756+0xa8>
    80021a76:	ffffe097          	auipc	ra,0xffffe
    80021a7a:	71a080e7          	jalr	1818(ra) # 80020190 <printf>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80021a7e:	143025f3          	csrr	a1,stval
  printf("stval: %p\n", r_stval());
    80021a82:	0000a517          	auipc	a0,0xa
    80021a86:	a9e50513          	addi	a0,a0,-1378 # 8002b520 <states.1756+0xb8>
    80021a8a:	ffffe097          	auipc	ra,0xffffe
    80021a8e:	706080e7          	jalr	1798(ra) # 80020190 <printf>
  asm volatile("mv %0, sp" : "=r" (x) );
    80021a92:	858a                	mv	a1,sp
  printf("sp: %p\n", r_sp());
    80021a94:	0000a517          	auipc	a0,0xa
    80021a98:	a9c50513          	addi	a0,a0,-1380 # 8002b530 <states.1756+0xc8>
    80021a9c:	ffffe097          	auipc	ra,0xffffe
    80021aa0:	6f4080e7          	jalr	1780(ra) # 80020190 <printf>
  asm volatile("mv %0, tp" : "=r" (x) );
    80021aa4:	8592                	mv	a1,tp
  printf("tp: %p\n", r_tp());
    80021aa6:	0000a517          	auipc	a0,0xa
    80021aaa:	a9250513          	addi	a0,a0,-1390 # 8002b538 <states.1756+0xd0>
    80021aae:	ffffe097          	auipc	ra,0xffffe
    80021ab2:	6e2080e7          	jalr	1762(ra) # 80020190 <printf>
  asm volatile("mv %0, ra" : "=r" (x) );
    80021ab6:	8586                	mv	a1,ra
  printf("ra: %p\n", r_ra());
    80021ab8:	0000a517          	auipc	a0,0xa
    80021abc:	a8850513          	addi	a0,a0,-1400 # 8002b540 <states.1756+0xd8>
    80021ac0:	ffffe097          	auipc	ra,0xffffe
    80021ac4:	6d0080e7          	jalr	1744(ra) # 80020190 <printf>
  printf("}\n");
    80021ac8:	0000a517          	auipc	a0,0xa
    80021acc:	a8050513          	addi	a0,a0,-1408 # 8002b548 <states.1756+0xe0>
    80021ad0:	ffffe097          	auipc	ra,0xffffe
    80021ad4:	6c0080e7          	jalr	1728(ra) # 80020190 <printf>
}
    80021ad8:	60a2                	ld	ra,8(sp)
    80021ada:	6402                	ld	s0,0(sp)
    80021adc:	0141                	addi	sp,sp,16
    80021ade:	8082                	ret

0000000080021ae0 <procinit>:
{
    80021ae0:	7179                	addi	sp,sp,-48
    80021ae2:	f406                	sd	ra,40(sp)
    80021ae4:	f022                	sd	s0,32(sp)
    80021ae6:	ec26                	sd	s1,24(sp)
    80021ae8:	e84a                	sd	s2,16(sp)
    80021aea:	e44e                	sd	s3,8(sp)
    80021aec:	1800                	addi	s0,sp,48
  initlock(&pid_lock, "nextpid");
    80021aee:	0000a597          	auipc	a1,0xa
    80021af2:	a6258593          	addi	a1,a1,-1438 # 8002b550 <states.1756+0xe8>
    80021af6:	00015517          	auipc	a0,0x15
    80021afa:	56a50513          	addi	a0,a0,1386 # 80037060 <pid_lock>
    80021afe:	fffff097          	auipc	ra,0xfffff
    80021b02:	b7e080e7          	jalr	-1154(ra) # 8002067c <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80021b06:	00015497          	auipc	s1,0x15
    80021b0a:	67248493          	addi	s1,s1,1650 # 80037178 <proc>
      initlock(&p->lock, "proc");
    80021b0e:	0000a997          	auipc	s3,0xa
    80021b12:	a4a98993          	addi	s3,s3,-1462 # 8002b558 <states.1756+0xf0>
  for(p = proc; p < &proc[NPROC]; p++) {
    80021b16:	0001a917          	auipc	s2,0x1a
    80021b1a:	fd290913          	addi	s2,s2,-46 # 8003bae8 <initproc>
      initlock(&p->lock, "proc");
    80021b1e:	85ce                	mv	a1,s3
    80021b20:	8526                	mv	a0,s1
    80021b22:	fffff097          	auipc	ra,0xfffff
    80021b26:	b5a080e7          	jalr	-1190(ra) # 8002067c <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80021b2a:	17848493          	addi	s1,s1,376
    80021b2e:	ff2498e3          	bne	s1,s2,80021b1e <procinit+0x3e>
  memset(cpus, 0, sizeof(cpus));
    80021b32:	10000613          	li	a2,256
    80021b36:	4581                	li	a1,0
    80021b38:	00015517          	auipc	a0,0x15
    80021b3c:	54050513          	addi	a0,a0,1344 # 80037078 <cpus>
    80021b40:	fffff097          	auipc	ra,0xfffff
    80021b44:	c1c080e7          	jalr	-996(ra) # 8002075c <memset>
}
    80021b48:	70a2                	ld	ra,40(sp)
    80021b4a:	7402                	ld	s0,32(sp)
    80021b4c:	64e2                	ld	s1,24(sp)
    80021b4e:	6942                	ld	s2,16(sp)
    80021b50:	69a2                	ld	s3,8(sp)
    80021b52:	6145                	addi	sp,sp,48
    80021b54:	8082                	ret

0000000080021b56 <cpuid>:
{
    80021b56:	1141                	addi	sp,sp,-16
    80021b58:	e422                	sd	s0,8(sp)
    80021b5a:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80021b5c:	8512                	mv	a0,tp
}
    80021b5e:	2501                	sext.w	a0,a0
    80021b60:	6422                	ld	s0,8(sp)
    80021b62:	0141                	addi	sp,sp,16
    80021b64:	8082                	ret

0000000080021b66 <mycpu>:
mycpu(void) {
    80021b66:	1141                	addi	sp,sp,-16
    80021b68:	e422                	sd	s0,8(sp)
    80021b6a:	0800                	addi	s0,sp,16
    80021b6c:	8792                	mv	a5,tp
  struct cpu *c = &cpus[id];
    80021b6e:	2781                	sext.w	a5,a5
    80021b70:	079e                	slli	a5,a5,0x7
}
    80021b72:	00015517          	auipc	a0,0x15
    80021b76:	50650513          	addi	a0,a0,1286 # 80037078 <cpus>
    80021b7a:	953e                	add	a0,a0,a5
    80021b7c:	6422                	ld	s0,8(sp)
    80021b7e:	0141                	addi	sp,sp,16
    80021b80:	8082                	ret

0000000080021b82 <myproc>:
myproc(void) {
    80021b82:	1101                	addi	sp,sp,-32
    80021b84:	ec06                	sd	ra,24(sp)
    80021b86:	e822                	sd	s0,16(sp)
    80021b88:	e426                	sd	s1,8(sp)
    80021b8a:	1000                	addi	s0,sp,32
  push_off();
    80021b8c:	fffff097          	auipc	ra,0xfffff
    80021b90:	a44080e7          	jalr	-1468(ra) # 800205d0 <push_off>
    80021b94:	8792                	mv	a5,tp
  struct proc *p = c->proc;
    80021b96:	2781                	sext.w	a5,a5
    80021b98:	079e                	slli	a5,a5,0x7
    80021b9a:	00015717          	auipc	a4,0x15
    80021b9e:	4c670713          	addi	a4,a4,1222 # 80037060 <pid_lock>
    80021ba2:	97ba                	add	a5,a5,a4
    80021ba4:	6f84                	ld	s1,24(a5)
  pop_off();
    80021ba6:	fffff097          	auipc	ra,0xfffff
    80021baa:	a76080e7          	jalr	-1418(ra) # 8002061c <pop_off>
}
    80021bae:	8526                	mv	a0,s1
    80021bb0:	60e2                	ld	ra,24(sp)
    80021bb2:	6442                	ld	s0,16(sp)
    80021bb4:	64a2                	ld	s1,8(sp)
    80021bb6:	6105                	addi	sp,sp,32
    80021bb8:	8082                	ret

0000000080021bba <forkret>:
{
    80021bba:	1101                	addi	sp,sp,-32
    80021bbc:	ec06                	sd	ra,24(sp)
    80021bbe:	e822                	sd	s0,16(sp)
    80021bc0:	e426                	sd	s1,8(sp)
    80021bc2:	1000                	addi	s0,sp,32
  release(&myproc()->lock);
    80021bc4:	00000097          	auipc	ra,0x0
    80021bc8:	fbe080e7          	jalr	-66(ra) # 80021b82 <myproc>
    80021bcc:	fffff097          	auipc	ra,0xfffff
    80021bd0:	b48080e7          	jalr	-1208(ra) # 80020714 <release>
  if (first) {
    80021bd4:	0000d797          	auipc	a5,0xd
    80021bd8:	f9c78793          	addi	a5,a5,-100 # 8002eb70 <first.1718>
    80021bdc:	439c                	lw	a5,0(a5)
    80021bde:	eb91                	bnez	a5,80021bf2 <forkret+0x38>
  usertrapret();
    80021be0:	00001097          	auipc	ra,0x1
    80021be4:	cec080e7          	jalr	-788(ra) # 800228cc <usertrapret>
}
    80021be8:	60e2                	ld	ra,24(sp)
    80021bea:	6442                	ld	s0,16(sp)
    80021bec:	64a2                	ld	s1,8(sp)
    80021bee:	6105                	addi	sp,sp,32
    80021bf0:	8082                	ret
    first = 0;
    80021bf2:	0000d797          	auipc	a5,0xd
    80021bf6:	f607af23          	sw	zero,-130(a5) # 8002eb70 <first.1718>
    fat32_init();
    80021bfa:	00004097          	auipc	ra,0x4
    80021bfe:	dde080e7          	jalr	-546(ra) # 800259d8 <fat32_init>
    myproc()->cwd = ename("/");
    80021c02:	00000097          	auipc	ra,0x0
    80021c06:	f80080e7          	jalr	-128(ra) # 80021b82 <myproc>
    80021c0a:	84aa                	mv	s1,a0
    80021c0c:	0000a517          	auipc	a0,0xa
    80021c10:	95450513          	addi	a0,a0,-1708 # 8002b560 <states.1756+0xf8>
    80021c14:	00005097          	auipc	ra,0x5
    80021c18:	ffe080e7          	jalr	-2(ra) # 80026c12 <ename>
    80021c1c:	14a4bc23          	sd	a0,344(s1)
    80021c20:	b7c1                	j	80021be0 <forkret+0x26>

0000000080021c22 <allocpid>:
allocpid() {
    80021c22:	1101                	addi	sp,sp,-32
    80021c24:	ec06                	sd	ra,24(sp)
    80021c26:	e822                	sd	s0,16(sp)
    80021c28:	e426                	sd	s1,8(sp)
    80021c2a:	e04a                	sd	s2,0(sp)
    80021c2c:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80021c2e:	00015917          	auipc	s2,0x15
    80021c32:	43290913          	addi	s2,s2,1074 # 80037060 <pid_lock>
    80021c36:	854a                	mv	a0,s2
    80021c38:	fffff097          	auipc	ra,0xfffff
    80021c3c:	a88080e7          	jalr	-1400(ra) # 800206c0 <acquire>
  pid = nextpid;
    80021c40:	0000d797          	auipc	a5,0xd
    80021c44:	f3478793          	addi	a5,a5,-204 # 8002eb74 <nextpid>
    80021c48:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80021c4a:	0014871b          	addiw	a4,s1,1
    80021c4e:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80021c50:	854a                	mv	a0,s2
    80021c52:	fffff097          	auipc	ra,0xfffff
    80021c56:	ac2080e7          	jalr	-1342(ra) # 80020714 <release>
}
    80021c5a:	8526                	mv	a0,s1
    80021c5c:	60e2                	ld	ra,24(sp)
    80021c5e:	6442                	ld	s0,16(sp)
    80021c60:	64a2                	ld	s1,8(sp)
    80021c62:	6902                	ld	s2,0(sp)
    80021c64:	6105                	addi	sp,sp,32
    80021c66:	8082                	ret

0000000080021c68 <proc_pagetable>:
{
    80021c68:	1101                	addi	sp,sp,-32
    80021c6a:	ec06                	sd	ra,24(sp)
    80021c6c:	e822                	sd	s0,16(sp)
    80021c6e:	e426                	sd	s1,8(sp)
    80021c70:	e04a                	sd	s2,0(sp)
    80021c72:	1000                	addi	s0,sp,32
    80021c74:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80021c76:	fffff097          	auipc	ra,0xfffff
    80021c7a:	38a080e7          	jalr	906(ra) # 80021000 <uvmcreate>
    80021c7e:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80021c80:	c121                	beqz	a0,80021cc0 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80021c82:	4729                	li	a4,10
    80021c84:	00008697          	auipc	a3,0x8
    80021c88:	37c68693          	addi	a3,a3,892 # 8002a000 <_trampoline>
    80021c8c:	6605                	lui	a2,0x1
    80021c8e:	040005b7          	lui	a1,0x4000
    80021c92:	15fd                	addi	a1,a1,-1
    80021c94:	05b2                	slli	a1,a1,0xc
    80021c96:	fffff097          	auipc	ra,0xfffff
    80021c9a:	04a080e7          	jalr	74(ra) # 80020ce0 <mappages>
    80021c9e:	02054863          	bltz	a0,80021cce <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80021ca2:	4719                	li	a4,6
    80021ca4:	06093683          	ld	a3,96(s2)
    80021ca8:	6605                	lui	a2,0x1
    80021caa:	020005b7          	lui	a1,0x2000
    80021cae:	15fd                	addi	a1,a1,-1
    80021cb0:	05b6                	slli	a1,a1,0xd
    80021cb2:	8526                	mv	a0,s1
    80021cb4:	fffff097          	auipc	ra,0xfffff
    80021cb8:	02c080e7          	jalr	44(ra) # 80020ce0 <mappages>
    80021cbc:	02054163          	bltz	a0,80021cde <proc_pagetable+0x76>
}
    80021cc0:	8526                	mv	a0,s1
    80021cc2:	60e2                	ld	ra,24(sp)
    80021cc4:	6442                	ld	s0,16(sp)
    80021cc6:	64a2                	ld	s1,8(sp)
    80021cc8:	6902                	ld	s2,0(sp)
    80021cca:	6105                	addi	sp,sp,32
    80021ccc:	8082                	ret
    uvmfree(pagetable, 0);
    80021cce:	4581                	li	a1,0
    80021cd0:	8526                	mv	a0,s1
    80021cd2:	fffff097          	auipc	ra,0xfffff
    80021cd6:	5b2080e7          	jalr	1458(ra) # 80021284 <uvmfree>
    return NULL;
    80021cda:	4481                	li	s1,0
    80021cdc:	b7d5                	j	80021cc0 <proc_pagetable+0x58>
    vmunmap(pagetable, TRAMPOLINE, 1, 0);
    80021cde:	4681                	li	a3,0
    80021ce0:	4605                	li	a2,1
    80021ce2:	040005b7          	lui	a1,0x4000
    80021ce6:	15fd                	addi	a1,a1,-1
    80021ce8:	05b2                	slli	a1,a1,0xc
    80021cea:	8526                	mv	a0,s1
    80021cec:	fffff097          	auipc	ra,0xfffff
    80021cf0:	250080e7          	jalr	592(ra) # 80020f3c <vmunmap>
    uvmfree(pagetable, 0);
    80021cf4:	4581                	li	a1,0
    80021cf6:	8526                	mv	a0,s1
    80021cf8:	fffff097          	auipc	ra,0xfffff
    80021cfc:	58c080e7          	jalr	1420(ra) # 80021284 <uvmfree>
    return NULL;
    80021d00:	4481                	li	s1,0
    80021d02:	bf7d                	j	80021cc0 <proc_pagetable+0x58>

0000000080021d04 <proc_freepagetable>:
{
    80021d04:	1101                	addi	sp,sp,-32
    80021d06:	ec06                	sd	ra,24(sp)
    80021d08:	e822                	sd	s0,16(sp)
    80021d0a:	e426                	sd	s1,8(sp)
    80021d0c:	e04a                	sd	s2,0(sp)
    80021d0e:	1000                	addi	s0,sp,32
    80021d10:	84aa                	mv	s1,a0
    80021d12:	892e                	mv	s2,a1
  vmunmap(pagetable, TRAMPOLINE, 1, 0);
    80021d14:	4681                	li	a3,0
    80021d16:	4605                	li	a2,1
    80021d18:	040005b7          	lui	a1,0x4000
    80021d1c:	15fd                	addi	a1,a1,-1
    80021d1e:	05b2                	slli	a1,a1,0xc
    80021d20:	fffff097          	auipc	ra,0xfffff
    80021d24:	21c080e7          	jalr	540(ra) # 80020f3c <vmunmap>
  vmunmap(pagetable, TRAPFRAME, 1, 0);
    80021d28:	4681                	li	a3,0
    80021d2a:	4605                	li	a2,1
    80021d2c:	020005b7          	lui	a1,0x2000
    80021d30:	15fd                	addi	a1,a1,-1
    80021d32:	05b6                	slli	a1,a1,0xd
    80021d34:	8526                	mv	a0,s1
    80021d36:	fffff097          	auipc	ra,0xfffff
    80021d3a:	206080e7          	jalr	518(ra) # 80020f3c <vmunmap>
  uvmfree(pagetable, sz);
    80021d3e:	85ca                	mv	a1,s2
    80021d40:	8526                	mv	a0,s1
    80021d42:	fffff097          	auipc	ra,0xfffff
    80021d46:	542080e7          	jalr	1346(ra) # 80021284 <uvmfree>
}
    80021d4a:	60e2                	ld	ra,24(sp)
    80021d4c:	6442                	ld	s0,16(sp)
    80021d4e:	64a2                	ld	s1,8(sp)
    80021d50:	6902                	ld	s2,0(sp)
    80021d52:	6105                	addi	sp,sp,32
    80021d54:	8082                	ret

0000000080021d56 <freeproc>:
{
    80021d56:	1101                	addi	sp,sp,-32
    80021d58:	ec06                	sd	ra,24(sp)
    80021d5a:	e822                	sd	s0,16(sp)
    80021d5c:	e426                	sd	s1,8(sp)
    80021d5e:	1000                	addi	s0,sp,32
    80021d60:	84aa                	mv	s1,a0
  if(p->trapframe)
    80021d62:	7128                	ld	a0,96(a0)
    80021d64:	c509                	beqz	a0,80021d6e <freeproc+0x18>
    kfree((void*)p->trapframe);
    80021d66:	ffffe097          	auipc	ra,0xffffe
    80021d6a:	6d2080e7          	jalr	1746(ra) # 80020438 <kfree>
  p->trapframe = 0;
    80021d6e:	0604b023          	sd	zero,96(s1)
  if (p->kpagetable) {
    80021d72:	6ca8                	ld	a0,88(s1)
    80021d74:	c511                	beqz	a0,80021d80 <freeproc+0x2a>
    kvmfree(p->kpagetable, 1);
    80021d76:	4585                	li	a1,1
    80021d78:	00000097          	auipc	ra,0x0
    80021d7c:	a2e080e7          	jalr	-1490(ra) # 800217a6 <kvmfree>
  p->kpagetable = 0;
    80021d80:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80021d84:	68a8                	ld	a0,80(s1)
    80021d86:	c511                	beqz	a0,80021d92 <freeproc+0x3c>
    proc_freepagetable(p->pagetable, p->sz);
    80021d88:	64ac                	ld	a1,72(s1)
    80021d8a:	00000097          	auipc	ra,0x0
    80021d8e:	f7a080e7          	jalr	-134(ra) # 80021d04 <proc_freepagetable>
  p->pagetable = 0;
    80021d92:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80021d96:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80021d9a:	0204ac23          	sw	zero,56(s1)
  p->parent = 0;
    80021d9e:	0204b023          	sd	zero,32(s1)
  p->name[0] = 0;
    80021da2:	16048023          	sb	zero,352(s1)
  p->chan = 0;
    80021da6:	0204b423          	sd	zero,40(s1)
  p->killed = 0;
    80021daa:	0204a823          	sw	zero,48(s1)
  p->xstate = 0;
    80021dae:	0204aa23          	sw	zero,52(s1)
  p->state = UNUSED;
    80021db2:	0004ac23          	sw	zero,24(s1)
}
    80021db6:	60e2                	ld	ra,24(sp)
    80021db8:	6442                	ld	s0,16(sp)
    80021dba:	64a2                	ld	s1,8(sp)
    80021dbc:	6105                	addi	sp,sp,32
    80021dbe:	8082                	ret

0000000080021dc0 <allocproc>:
{
    80021dc0:	1101                	addi	sp,sp,-32
    80021dc2:	ec06                	sd	ra,24(sp)
    80021dc4:	e822                	sd	s0,16(sp)
    80021dc6:	e426                	sd	s1,8(sp)
    80021dc8:	e04a                	sd	s2,0(sp)
    80021dca:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80021dcc:	00015497          	auipc	s1,0x15
    80021dd0:	3ac48493          	addi	s1,s1,940 # 80037178 <proc>
    80021dd4:	0001a917          	auipc	s2,0x1a
    80021dd8:	d1490913          	addi	s2,s2,-748 # 8003bae8 <initproc>
    acquire(&p->lock);
    80021ddc:	8526                	mv	a0,s1
    80021dde:	fffff097          	auipc	ra,0xfffff
    80021de2:	8e2080e7          	jalr	-1822(ra) # 800206c0 <acquire>
    if(p->state == UNUSED) {
    80021de6:	4c9c                	lw	a5,24(s1)
    80021de8:	cf81                	beqz	a5,80021e00 <allocproc+0x40>
      release(&p->lock);
    80021dea:	8526                	mv	a0,s1
    80021dec:	fffff097          	auipc	ra,0xfffff
    80021df0:	928080e7          	jalr	-1752(ra) # 80020714 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80021df4:	17848493          	addi	s1,s1,376
    80021df8:	ff2492e3          	bne	s1,s2,80021ddc <allocproc+0x1c>
  return NULL;
    80021dfc:	4481                	li	s1,0
    80021dfe:	a085                	j	80021e5e <allocproc+0x9e>
  p->pid = allocpid();
    80021e00:	00000097          	auipc	ra,0x0
    80021e04:	e22080e7          	jalr	-478(ra) # 80021c22 <allocpid>
    80021e08:	dc88                	sw	a0,56(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == NULL){
    80021e0a:	ffffe097          	auipc	ra,0xffffe
    80021e0e:	748080e7          	jalr	1864(ra) # 80020552 <kalloc>
    80021e12:	892a                	mv	s2,a0
    80021e14:	f0a8                	sd	a0,96(s1)
    80021e16:	c939                	beqz	a0,80021e6c <allocproc+0xac>
  if ((p->pagetable = proc_pagetable(p)) == NULL ||
    80021e18:	8526                	mv	a0,s1
    80021e1a:	00000097          	auipc	ra,0x0
    80021e1e:	e4e080e7          	jalr	-434(ra) # 80021c68 <proc_pagetable>
    80021e22:	e8a8                	sd	a0,80(s1)
    80021e24:	c939                	beqz	a0,80021e7a <allocproc+0xba>
      (p->kpagetable = proc_kpagetable()) == NULL) {
    80021e26:	00000097          	auipc	ra,0x0
    80021e2a:	9da080e7          	jalr	-1574(ra) # 80021800 <proc_kpagetable>
    80021e2e:	eca8                	sd	a0,88(s1)
  if ((p->pagetable = proc_pagetable(p)) == NULL ||
    80021e30:	c529                	beqz	a0,80021e7a <allocproc+0xba>
  p->kstack = VKSTACK;
    80021e32:	0fb00793          	li	a5,251
    80021e36:	07fa                	slli	a5,a5,0x1e
    80021e38:	e0bc                	sd	a5,64(s1)
  memset(&p->context, 0, sizeof(p->context));
    80021e3a:	07000613          	li	a2,112
    80021e3e:	4581                	li	a1,0
    80021e40:	06848513          	addi	a0,s1,104
    80021e44:	fffff097          	auipc	ra,0xfffff
    80021e48:	918080e7          	jalr	-1768(ra) # 8002075c <memset>
  p->context.ra = (uint64)forkret;
    80021e4c:	00000797          	auipc	a5,0x0
    80021e50:	d6e78793          	addi	a5,a5,-658 # 80021bba <forkret>
    80021e54:	f4bc                	sd	a5,104(s1)
  p->context.sp = p->kstack + PGSIZE;
    80021e56:	60bc                	ld	a5,64(s1)
    80021e58:	6705                	lui	a4,0x1
    80021e5a:	97ba                	add	a5,a5,a4
    80021e5c:	f8bc                	sd	a5,112(s1)
}
    80021e5e:	8526                	mv	a0,s1
    80021e60:	60e2                	ld	ra,24(sp)
    80021e62:	6442                	ld	s0,16(sp)
    80021e64:	64a2                	ld	s1,8(sp)
    80021e66:	6902                	ld	s2,0(sp)
    80021e68:	6105                	addi	sp,sp,32
    80021e6a:	8082                	ret
    release(&p->lock);
    80021e6c:	8526                	mv	a0,s1
    80021e6e:	fffff097          	auipc	ra,0xfffff
    80021e72:	8a6080e7          	jalr	-1882(ra) # 80020714 <release>
    return NULL;
    80021e76:	84ca                	mv	s1,s2
    80021e78:	b7dd                	j	80021e5e <allocproc+0x9e>
    freeproc(p);
    80021e7a:	8526                	mv	a0,s1
    80021e7c:	00000097          	auipc	ra,0x0
    80021e80:	eda080e7          	jalr	-294(ra) # 80021d56 <freeproc>
    release(&p->lock);
    80021e84:	8526                	mv	a0,s1
    80021e86:	fffff097          	auipc	ra,0xfffff
    80021e8a:	88e080e7          	jalr	-1906(ra) # 80020714 <release>
    return NULL;
    80021e8e:	4481                	li	s1,0
    80021e90:	b7f9                	j	80021e5e <allocproc+0x9e>

0000000080021e92 <userinit>:
{
    80021e92:	1101                	addi	sp,sp,-32
    80021e94:	ec06                	sd	ra,24(sp)
    80021e96:	e822                	sd	s0,16(sp)
    80021e98:	e426                	sd	s1,8(sp)
    80021e9a:	e04a                	sd	s2,0(sp)
    80021e9c:	1000                	addi	s0,sp,32
  p = allocproc();
    80021e9e:	00000097          	auipc	ra,0x0
    80021ea2:	f22080e7          	jalr	-222(ra) # 80021dc0 <allocproc>
    80021ea6:	84aa                	mv	s1,a0
  initproc = p;
    80021ea8:	0001a797          	auipc	a5,0x1a
    80021eac:	c4a7b023          	sd	a0,-960(a5) # 8003bae8 <initproc>
  uvminit(p->pagetable , p->kpagetable, initcode, sizeof(initcode));
    80021eb0:	6905                	lui	s2,0x1
    80021eb2:	b5c90693          	addi	a3,s2,-1188 # b5c <BASE_ADDRESS-0x8001f4a4>
    80021eb6:	0000c617          	auipc	a2,0xc
    80021eba:	14a60613          	addi	a2,a2,330 # 8002e000 <initcode>
    80021ebe:	6d2c                	ld	a1,88(a0)
    80021ec0:	6928                	ld	a0,80(a0)
    80021ec2:	fffff097          	auipc	ra,0xfffff
    80021ec6:	16c080e7          	jalr	364(ra) # 8002102e <uvminit>
  p->sz = PGSIZE;
    80021eca:	0524b423          	sd	s2,72(s1)
  p->trapframe->epc = 0x3E;      // user program counter
    80021ece:	70bc                	ld	a5,96(s1)
    80021ed0:	03e00713          	li	a4,62
    80021ed4:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80021ed6:	70bc                	ld	a5,96(s1)
    80021ed8:	0327b823          	sd	s2,48(a5)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80021edc:	4641                	li	a2,16
    80021ede:	00009597          	auipc	a1,0x9
    80021ee2:	68a58593          	addi	a1,a1,1674 # 8002b568 <states.1756+0x100>
    80021ee6:	16048513          	addi	a0,s1,352
    80021eea:	fffff097          	auipc	ra,0xfffff
    80021eee:	9ea080e7          	jalr	-1558(ra) # 800208d4 <safestrcpy>
  p->state = RUNNABLE;
    80021ef2:	4789                	li	a5,2
    80021ef4:	cc9c                	sw	a5,24(s1)
  p->tmask = 0;
    80021ef6:	1604a823          	sw	zero,368(s1)
  release(&p->lock);
    80021efa:	8526                	mv	a0,s1
    80021efc:	fffff097          	auipc	ra,0xfffff
    80021f00:	818080e7          	jalr	-2024(ra) # 80020714 <release>
}
    80021f04:	60e2                	ld	ra,24(sp)
    80021f06:	6442                	ld	s0,16(sp)
    80021f08:	64a2                	ld	s1,8(sp)
    80021f0a:	6902                	ld	s2,0(sp)
    80021f0c:	6105                	addi	sp,sp,32
    80021f0e:	8082                	ret

0000000080021f10 <growproc>:
{
    80021f10:	1101                	addi	sp,sp,-32
    80021f12:	ec06                	sd	ra,24(sp)
    80021f14:	e822                	sd	s0,16(sp)
    80021f16:	e426                	sd	s1,8(sp)
    80021f18:	e04a                	sd	s2,0(sp)
    80021f1a:	1000                	addi	s0,sp,32
    80021f1c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80021f1e:	00000097          	auipc	ra,0x0
    80021f22:	c64080e7          	jalr	-924(ra) # 80021b82 <myproc>
    80021f26:	892a                	mv	s2,a0
  sz = p->sz;
    80021f28:	6530                	ld	a2,72(a0)
    80021f2a:	0006051b          	sext.w	a0,a2
  if(n > 0){
    80021f2e:	00904f63          	bgtz	s1,80021f4c <growproc+0x3c>
  } else if(n < 0){
    80021f32:	0204cf63          	bltz	s1,80021f70 <growproc+0x60>
  p->sz = sz;
    80021f36:	1502                	slli	a0,a0,0x20
    80021f38:	9101                	srli	a0,a0,0x20
    80021f3a:	04a93423          	sd	a0,72(s2)
  return 0;
    80021f3e:	4501                	li	a0,0
}
    80021f40:	60e2                	ld	ra,24(sp)
    80021f42:	6442                	ld	s0,16(sp)
    80021f44:	64a2                	ld	s1,8(sp)
    80021f46:	6902                	ld	s2,0(sp)
    80021f48:	6105                	addi	sp,sp,32
    80021f4a:	8082                	ret
    if((sz = uvmalloc(p->pagetable, p->kpagetable, sz, sz + n)) == 0) {
    80021f4c:	00a486bb          	addw	a3,s1,a0
    80021f50:	1682                	slli	a3,a3,0x20
    80021f52:	9281                	srli	a3,a3,0x20
    80021f54:	1602                	slli	a2,a2,0x20
    80021f56:	9201                	srli	a2,a2,0x20
    80021f58:	05893583          	ld	a1,88(s2)
    80021f5c:	05093503          	ld	a0,80(s2)
    80021f60:	fffff097          	auipc	ra,0xfffff
    80021f64:	1c4080e7          	jalr	452(ra) # 80021124 <uvmalloc>
    80021f68:	2501                	sext.w	a0,a0
    80021f6a:	f571                	bnez	a0,80021f36 <growproc+0x26>
      return -1;
    80021f6c:	557d                	li	a0,-1
    80021f6e:	bfc9                	j	80021f40 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, p->kpagetable, sz, sz + n);
    80021f70:	00a486bb          	addw	a3,s1,a0
    80021f74:	1682                	slli	a3,a3,0x20
    80021f76:	9281                	srli	a3,a3,0x20
    80021f78:	1602                	slli	a2,a2,0x20
    80021f7a:	9201                	srli	a2,a2,0x20
    80021f7c:	05893583          	ld	a1,88(s2)
    80021f80:	05093503          	ld	a0,80(s2)
    80021f84:	fffff097          	auipc	ra,0xfffff
    80021f88:	134080e7          	jalr	308(ra) # 800210b8 <uvmdealloc>
    80021f8c:	2501                	sext.w	a0,a0
    80021f8e:	b765                	j	80021f36 <growproc+0x26>

0000000080021f90 <clone>:
{
    80021f90:	7179                	addi	sp,sp,-48
    80021f92:	f406                	sd	ra,40(sp)
    80021f94:	f022                	sd	s0,32(sp)
    80021f96:	ec26                	sd	s1,24(sp)
    80021f98:	e84a                	sd	s2,16(sp)
    80021f9a:	e44e                	sd	s3,8(sp)
    80021f9c:	e052                	sd	s4,0(sp)
    80021f9e:	1800                	addi	s0,sp,48
    80021fa0:	84ae                	mv	s1,a1
  struct proc *p = myproc();
    80021fa2:	00000097          	auipc	ra,0x0
    80021fa6:	be0080e7          	jalr	-1056(ra) # 80021b82 <myproc>
    80021faa:	892a                	mv	s2,a0
  if((np = allocproc()) == NULL){
    80021fac:	00000097          	auipc	ra,0x0
    80021fb0:	e14080e7          	jalr	-492(ra) # 80021dc0 <allocproc>
    80021fb4:	c97d                	beqz	a0,800220aa <clone+0x11a>
    80021fb6:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, np->kpagetable, p->sz) < 0){
    80021fb8:	04893683          	ld	a3,72(s2)
    80021fbc:	6d30                	ld	a2,88(a0)
    80021fbe:	692c                	ld	a1,80(a0)
    80021fc0:	05093503          	ld	a0,80(s2)
    80021fc4:	fffff097          	auipc	ra,0xfffff
    80021fc8:	2f8080e7          	jalr	760(ra) # 800212bc <uvmcopy>
    80021fcc:	06054063          	bltz	a0,8002202c <clone+0x9c>
  np->sz = p->sz;
    80021fd0:	04893783          	ld	a5,72(s2)
    80021fd4:	04f9b423          	sd	a5,72(s3)
  np->parent = p;
    80021fd8:	0329b023          	sd	s2,32(s3)
  np->tmask = p->tmask;
    80021fdc:	17092783          	lw	a5,368(s2)
    80021fe0:	16f9a823          	sw	a5,368(s3)
  *(np->trapframe) = *(p->trapframe);
    80021fe4:	06093683          	ld	a3,96(s2)
    80021fe8:	87b6                	mv	a5,a3
    80021fea:	0609b703          	ld	a4,96(s3)
    80021fee:	12068693          	addi	a3,a3,288
    80021ff2:	0007b803          	ld	a6,0(a5)
    80021ff6:	6788                	ld	a0,8(a5)
    80021ff8:	6b8c                	ld	a1,16(a5)
    80021ffa:	6f90                	ld	a2,24(a5)
    80021ffc:	01073023          	sd	a6,0(a4) # 1000 <BASE_ADDRESS-0x8001f000>
    80022000:	e708                	sd	a0,8(a4)
    80022002:	eb0c                	sd	a1,16(a4)
    80022004:	ef10                	sd	a2,24(a4)
    80022006:	02078793          	addi	a5,a5,32
    8002200a:	02070713          	addi	a4,a4,32
    8002200e:	fed792e3          	bne	a5,a3,80021ff2 <clone+0x62>
  np->trapframe->a0 = 0;
    80022012:	0609b783          	ld	a5,96(s3)
    80022016:	0607b823          	sd	zero,112(a5)
  if(stack!=0)
    8002201a:	c481                	beqz	s1,80022022 <clone+0x92>
    np->trapframe->sp = stack;
    8002201c:	0609b783          	ld	a5,96(s3)
    80022020:	fb84                	sd	s1,48(a5)
{
    80022022:	0d800493          	li	s1,216
  for(i = 0; i < NOFILE; i++)
    80022026:	15800a13          	li	s4,344
    8002202a:	a03d                	j	80022058 <clone+0xc8>
    freeproc(np);
    8002202c:	854e                	mv	a0,s3
    8002202e:	00000097          	auipc	ra,0x0
    80022032:	d28080e7          	jalr	-728(ra) # 80021d56 <freeproc>
    release(&np->lock);
    80022036:	854e                	mv	a0,s3
    80022038:	ffffe097          	auipc	ra,0xffffe
    8002203c:	6dc080e7          	jalr	1756(ra) # 80020714 <release>
    return -1;
    80022040:	54fd                	li	s1,-1
    80022042:	a899                	j	80022098 <clone+0x108>
      np->ofile[i] = filedup(p->ofile[i]);
    80022044:	00002097          	auipc	ra,0x2
    80022048:	a14080e7          	jalr	-1516(ra) # 80023a58 <filedup>
    8002204c:	009987b3          	add	a5,s3,s1
    80022050:	e388                	sd	a0,0(a5)
    80022052:	04a1                	addi	s1,s1,8
  for(i = 0; i < NOFILE; i++)
    80022054:	01448763          	beq	s1,s4,80022062 <clone+0xd2>
    if(p->ofile[i])
    80022058:	009907b3          	add	a5,s2,s1
    8002205c:	6388                	ld	a0,0(a5)
    8002205e:	f17d                	bnez	a0,80022044 <clone+0xb4>
    80022060:	bfcd                	j	80022052 <clone+0xc2>
  np->cwd = edup(p->cwd);
    80022062:	15893503          	ld	a0,344(s2)
    80022066:	00004097          	auipc	ra,0x4
    8002206a:	1b6080e7          	jalr	438(ra) # 8002621c <edup>
    8002206e:	14a9bc23          	sd	a0,344(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80022072:	4641                	li	a2,16
    80022074:	16090593          	addi	a1,s2,352
    80022078:	16098513          	addi	a0,s3,352
    8002207c:	fffff097          	auipc	ra,0xfffff
    80022080:	858080e7          	jalr	-1960(ra) # 800208d4 <safestrcpy>
  pid = np->pid;
    80022084:	0389a483          	lw	s1,56(s3)
  np->state = RUNNABLE;
    80022088:	4789                	li	a5,2
    8002208a:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    8002208e:	854e                	mv	a0,s3
    80022090:	ffffe097          	auipc	ra,0xffffe
    80022094:	684080e7          	jalr	1668(ra) # 80020714 <release>
}
    80022098:	8526                	mv	a0,s1
    8002209a:	70a2                	ld	ra,40(sp)
    8002209c:	7402                	ld	s0,32(sp)
    8002209e:	64e2                	ld	s1,24(sp)
    800220a0:	6942                	ld	s2,16(sp)
    800220a2:	69a2                	ld	s3,8(sp)
    800220a4:	6a02                	ld	s4,0(sp)
    800220a6:	6145                	addi	sp,sp,48
    800220a8:	8082                	ret
    return -1;
    800220aa:	54fd                	li	s1,-1
    800220ac:	b7f5                	j	80022098 <clone+0x108>

00000000800220ae <fork>:
{
    800220ae:	1141                	addi	sp,sp,-16
    800220b0:	e406                	sd	ra,8(sp)
    800220b2:	e022                	sd	s0,0(sp)
    800220b4:	0800                	addi	s0,sp,16
  return clone(SIGCHLD,0);
    800220b6:	4581                	li	a1,0
    800220b8:	4505                	li	a0,1
    800220ba:	00000097          	auipc	ra,0x0
    800220be:	ed6080e7          	jalr	-298(ra) # 80021f90 <clone>
}
    800220c2:	60a2                	ld	ra,8(sp)
    800220c4:	6402                	ld	s0,0(sp)
    800220c6:	0141                	addi	sp,sp,16
    800220c8:	8082                	ret

00000000800220ca <reparent>:
{
    800220ca:	7179                	addi	sp,sp,-48
    800220cc:	f406                	sd	ra,40(sp)
    800220ce:	f022                	sd	s0,32(sp)
    800220d0:	ec26                	sd	s1,24(sp)
    800220d2:	e84a                	sd	s2,16(sp)
    800220d4:	e44e                	sd	s3,8(sp)
    800220d6:	e052                	sd	s4,0(sp)
    800220d8:	1800                	addi	s0,sp,48
    800220da:	89aa                	mv	s3,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800220dc:	00015497          	auipc	s1,0x15
    800220e0:	09c48493          	addi	s1,s1,156 # 80037178 <proc>
      pp->parent = initproc;
    800220e4:	0001aa17          	auipc	s4,0x1a
    800220e8:	a04a0a13          	addi	s4,s4,-1532 # 8003bae8 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800220ec:	0001a917          	auipc	s2,0x1a
    800220f0:	9fc90913          	addi	s2,s2,-1540 # 8003bae8 <initproc>
    800220f4:	a029                	j	800220fe <reparent+0x34>
    800220f6:	17848493          	addi	s1,s1,376
    800220fa:	03248363          	beq	s1,s2,80022120 <reparent+0x56>
    if(pp->parent == p){
    800220fe:	709c                	ld	a5,32(s1)
    80022100:	ff379be3          	bne	a5,s3,800220f6 <reparent+0x2c>
      acquire(&pp->lock);
    80022104:	8526                	mv	a0,s1
    80022106:	ffffe097          	auipc	ra,0xffffe
    8002210a:	5ba080e7          	jalr	1466(ra) # 800206c0 <acquire>
      pp->parent = initproc;
    8002210e:	000a3783          	ld	a5,0(s4)
    80022112:	f09c                	sd	a5,32(s1)
      release(&pp->lock);
    80022114:	8526                	mv	a0,s1
    80022116:	ffffe097          	auipc	ra,0xffffe
    8002211a:	5fe080e7          	jalr	1534(ra) # 80020714 <release>
    8002211e:	bfe1                	j	800220f6 <reparent+0x2c>
}
    80022120:	70a2                	ld	ra,40(sp)
    80022122:	7402                	ld	s0,32(sp)
    80022124:	64e2                	ld	s1,24(sp)
    80022126:	6942                	ld	s2,16(sp)
    80022128:	69a2                	ld	s3,8(sp)
    8002212a:	6a02                	ld	s4,0(sp)
    8002212c:	6145                	addi	sp,sp,48
    8002212e:	8082                	ret

0000000080022130 <scheduler>:
{
    80022130:	715d                	addi	sp,sp,-80
    80022132:	e486                	sd	ra,72(sp)
    80022134:	e0a2                	sd	s0,64(sp)
    80022136:	fc26                	sd	s1,56(sp)
    80022138:	f84a                	sd	s2,48(sp)
    8002213a:	f44e                	sd	s3,40(sp)
    8002213c:	f052                	sd	s4,32(sp)
    8002213e:	ec56                	sd	s5,24(sp)
    80022140:	e85a                	sd	s6,16(sp)
    80022142:	e45e                	sd	s7,8(sp)
    80022144:	e062                	sd	s8,0(sp)
    80022146:	0880                	addi	s0,sp,80
    80022148:	8792                	mv	a5,tp
  int id = r_tp();
    8002214a:	2781                	sext.w	a5,a5
  c->proc = 0;
    8002214c:	00779b13          	slli	s6,a5,0x7
    80022150:	00015717          	auipc	a4,0x15
    80022154:	f1070713          	addi	a4,a4,-240 # 80037060 <pid_lock>
    80022158:	975a                	add	a4,a4,s6
    8002215a:	00073c23          	sd	zero,24(a4)
        swtch(&c->context, &p->context);
    8002215e:	00015717          	auipc	a4,0x15
    80022162:	f2270713          	addi	a4,a4,-222 # 80037080 <cpus+0x8>
    80022166:	9b3a                	add	s6,s6,a4
        c->proc = p;
    80022168:	079e                	slli	a5,a5,0x7
    8002216a:	00015a97          	auipc	s5,0x15
    8002216e:	ef6a8a93          	addi	s5,s5,-266 # 80037060 <pid_lock>
    80022172:	9abe                	add	s5,s5,a5
        w_satp(MAKE_SATP(p->kpagetable));
    80022174:	5a7d                	li	s4,-1
    80022176:	1a7e                	slli	s4,s4,0x3f
        w_satp(MAKE_SATP(kernel_pagetable));
    80022178:	00015b97          	auipc	s7,0x15
    8002217c:	ee0b8b93          	addi	s7,s7,-288 # 80037058 <kernel_pagetable>
    80022180:	a8a5                	j	800221f8 <scheduler+0xc8>
        p->state = RUNNING;
    80022182:	478d                	li	a5,3
    80022184:	cc9c                	sw	a5,24(s1)
        c->proc = p;
    80022186:	009abc23          	sd	s1,24(s5)
        w_satp(MAKE_SATP(p->kpagetable));
    8002218a:	6cbc                	ld	a5,88(s1)
    8002218c:	83b1                	srli	a5,a5,0xc
    8002218e:	0147e7b3          	or	a5,a5,s4
  asm volatile("csrw satp, %0" : : "r" (x));
    80022192:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    80022196:	12000073          	sfence.vma
        swtch(&c->context, &p->context);
    8002219a:	06848593          	addi	a1,s1,104
    8002219e:	855a                	mv	a0,s6
    800221a0:	00000097          	auipc	ra,0x0
    800221a4:	686080e7          	jalr	1670(ra) # 80022826 <swtch>
        w_satp(MAKE_SATP(kernel_pagetable));
    800221a8:	000bb783          	ld	a5,0(s7)
    800221ac:	83b1                	srli	a5,a5,0xc
    800221ae:	0147e7b3          	or	a5,a5,s4
  asm volatile("csrw satp, %0" : : "r" (x));
    800221b2:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    800221b6:	12000073          	sfence.vma
        c->proc = 0;
    800221ba:	000abc23          	sd	zero,24(s5)
        found = 1;
    800221be:	4c05                	li	s8,1
      release(&p->lock);
    800221c0:	8526                	mv	a0,s1
    800221c2:	ffffe097          	auipc	ra,0xffffe
    800221c6:	552080e7          	jalr	1362(ra) # 80020714 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800221ca:	17848493          	addi	s1,s1,376
    800221ce:	01248b63          	beq	s1,s2,800221e4 <scheduler+0xb4>
      acquire(&p->lock);
    800221d2:	8526                	mv	a0,s1
    800221d4:	ffffe097          	auipc	ra,0xffffe
    800221d8:	4ec080e7          	jalr	1260(ra) # 800206c0 <acquire>
      if(p->state == RUNNABLE) {
    800221dc:	4c9c                	lw	a5,24(s1)
    800221de:	ff3791e3          	bne	a5,s3,800221c0 <scheduler+0x90>
    800221e2:	b745                	j	80022182 <scheduler+0x52>
    if(found == 0) {
    800221e4:	000c1a63          	bnez	s8,800221f8 <scheduler+0xc8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800221e8:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800221ec:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800221f0:	10079073          	csrw	sstatus,a5
      asm volatile("wfi");
    800221f4:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800221f8:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800221fc:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022200:	10079073          	csrw	sstatus,a5
    int found = 0;
    80022204:	4c01                	li	s8,0
    for(p = proc; p < &proc[NPROC]; p++) {
    80022206:	00015497          	auipc	s1,0x15
    8002220a:	f7248493          	addi	s1,s1,-142 # 80037178 <proc>
      if(p->state == RUNNABLE) {
    8002220e:	4989                	li	s3,2
    for(p = proc; p < &proc[NPROC]; p++) {
    80022210:	0001a917          	auipc	s2,0x1a
    80022214:	8d890913          	addi	s2,s2,-1832 # 8003bae8 <initproc>
    80022218:	bf6d                	j	800221d2 <scheduler+0xa2>

000000008002221a <sched>:
{
    8002221a:	7179                	addi	sp,sp,-48
    8002221c:	f406                	sd	ra,40(sp)
    8002221e:	f022                	sd	s0,32(sp)
    80022220:	ec26                	sd	s1,24(sp)
    80022222:	e84a                	sd	s2,16(sp)
    80022224:	e44e                	sd	s3,8(sp)
    80022226:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80022228:	00000097          	auipc	ra,0x0
    8002222c:	95a080e7          	jalr	-1702(ra) # 80021b82 <myproc>
    80022230:	892a                	mv	s2,a0
  if(!holding(&p->lock))
    80022232:	ffffe097          	auipc	ra,0xffffe
    80022236:	460080e7          	jalr	1120(ra) # 80020692 <holding>
    8002223a:	cd25                	beqz	a0,800222b2 <sched+0x98>
  asm volatile("mv %0, tp" : "=r" (x) );
    8002223c:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8002223e:	2781                	sext.w	a5,a5
    80022240:	079e                	slli	a5,a5,0x7
    80022242:	00015717          	auipc	a4,0x15
    80022246:	e1e70713          	addi	a4,a4,-482 # 80037060 <pid_lock>
    8002224a:	97ba                	add	a5,a5,a4
    8002224c:	0907a703          	lw	a4,144(a5)
    80022250:	4785                	li	a5,1
    80022252:	06f71863          	bne	a4,a5,800222c2 <sched+0xa8>
  if(p->state == RUNNING)
    80022256:	01892703          	lw	a4,24(s2)
    8002225a:	478d                	li	a5,3
    8002225c:	06f70b63          	beq	a4,a5,800222d2 <sched+0xb8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022260:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80022264:	8b89                	andi	a5,a5,2
  if(intr_get())
    80022266:	efb5                	bnez	a5,800222e2 <sched+0xc8>
  asm volatile("mv %0, tp" : "=r" (x) );
    80022268:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    8002226a:	00015497          	auipc	s1,0x15
    8002226e:	df648493          	addi	s1,s1,-522 # 80037060 <pid_lock>
    80022272:	2781                	sext.w	a5,a5
    80022274:	079e                	slli	a5,a5,0x7
    80022276:	97a6                	add	a5,a5,s1
    80022278:	0947a983          	lw	s3,148(a5)
    8002227c:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    8002227e:	2781                	sext.w	a5,a5
    80022280:	079e                	slli	a5,a5,0x7
    80022282:	00015597          	auipc	a1,0x15
    80022286:	dfe58593          	addi	a1,a1,-514 # 80037080 <cpus+0x8>
    8002228a:	95be                	add	a1,a1,a5
    8002228c:	06890513          	addi	a0,s2,104
    80022290:	00000097          	auipc	ra,0x0
    80022294:	596080e7          	jalr	1430(ra) # 80022826 <swtch>
    80022298:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    8002229a:	2781                	sext.w	a5,a5
    8002229c:	079e                	slli	a5,a5,0x7
    8002229e:	97a6                	add	a5,a5,s1
    800222a0:	0937aa23          	sw	s3,148(a5)
}
    800222a4:	70a2                	ld	ra,40(sp)
    800222a6:	7402                	ld	s0,32(sp)
    800222a8:	64e2                	ld	s1,24(sp)
    800222aa:	6942                	ld	s2,16(sp)
    800222ac:	69a2                	ld	s3,8(sp)
    800222ae:	6145                	addi	sp,sp,48
    800222b0:	8082                	ret
    panic("sched p->lock");
    800222b2:	00009517          	auipc	a0,0x9
    800222b6:	2c650513          	addi	a0,a0,710 # 8002b578 <states.1756+0x110>
    800222ba:	ffffe097          	auipc	ra,0xffffe
    800222be:	e8c080e7          	jalr	-372(ra) # 80020146 <panic>
    panic("sched locks");
    800222c2:	00009517          	auipc	a0,0x9
    800222c6:	2c650513          	addi	a0,a0,710 # 8002b588 <states.1756+0x120>
    800222ca:	ffffe097          	auipc	ra,0xffffe
    800222ce:	e7c080e7          	jalr	-388(ra) # 80020146 <panic>
    panic("sched running");
    800222d2:	00009517          	auipc	a0,0x9
    800222d6:	2c650513          	addi	a0,a0,710 # 8002b598 <states.1756+0x130>
    800222da:	ffffe097          	auipc	ra,0xffffe
    800222de:	e6c080e7          	jalr	-404(ra) # 80020146 <panic>
    panic("sched interruptible");
    800222e2:	00009517          	auipc	a0,0x9
    800222e6:	2c650513          	addi	a0,a0,710 # 8002b5a8 <states.1756+0x140>
    800222ea:	ffffe097          	auipc	ra,0xffffe
    800222ee:	e5c080e7          	jalr	-420(ra) # 80020146 <panic>

00000000800222f2 <exit>:
{
    800222f2:	7179                	addi	sp,sp,-48
    800222f4:	f406                	sd	ra,40(sp)
    800222f6:	f022                	sd	s0,32(sp)
    800222f8:	ec26                	sd	s1,24(sp)
    800222fa:	e84a                	sd	s2,16(sp)
    800222fc:	e44e                	sd	s3,8(sp)
    800222fe:	e052                	sd	s4,0(sp)
    80022300:	1800                	addi	s0,sp,48
    80022302:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80022304:	00000097          	auipc	ra,0x0
    80022308:	87e080e7          	jalr	-1922(ra) # 80021b82 <myproc>
    8002230c:	89aa                	mv	s3,a0
  if(p == initproc)
    8002230e:	00019797          	auipc	a5,0x19
    80022312:	7da78793          	addi	a5,a5,2010 # 8003bae8 <initproc>
    80022316:	639c                	ld	a5,0(a5)
    80022318:	0d850493          	addi	s1,a0,216
    8002231c:	15850913          	addi	s2,a0,344
    80022320:	02a79363          	bne	a5,a0,80022346 <exit+0x54>
    panic("init exiting");
    80022324:	00009517          	auipc	a0,0x9
    80022328:	29c50513          	addi	a0,a0,668 # 8002b5c0 <states.1756+0x158>
    8002232c:	ffffe097          	auipc	ra,0xffffe
    80022330:	e1a080e7          	jalr	-486(ra) # 80020146 <panic>
      fileclose(f);
    80022334:	00001097          	auipc	ra,0x1
    80022338:	776080e7          	jalr	1910(ra) # 80023aaa <fileclose>
      p->ofile[fd] = 0;
    8002233c:	0004b023          	sd	zero,0(s1)
    80022340:	04a1                	addi	s1,s1,8
  for(int fd = 0; fd < NOFILE; fd++){
    80022342:	01248563          	beq	s1,s2,8002234c <exit+0x5a>
    if(p->ofile[fd]){
    80022346:	6088                	ld	a0,0(s1)
    80022348:	f575                	bnez	a0,80022334 <exit+0x42>
    8002234a:	bfdd                	j	80022340 <exit+0x4e>
  eput(p->cwd);
    8002234c:	1589b503          	ld	a0,344(s3)
    80022350:	00004097          	auipc	ra,0x4
    80022354:	1a0080e7          	jalr	416(ra) # 800264f0 <eput>
  p->cwd = 0;
    80022358:	1409bc23          	sd	zero,344(s3)
  acquire(&initproc->lock);
    8002235c:	00019497          	auipc	s1,0x19
    80022360:	78c48493          	addi	s1,s1,1932 # 8003bae8 <initproc>
    80022364:	6088                	ld	a0,0(s1)
    80022366:	ffffe097          	auipc	ra,0xffffe
    8002236a:	35a080e7          	jalr	858(ra) # 800206c0 <acquire>
  wakeup1(initproc);
    8002236e:	6088                	ld	a0,0(s1)
    80022370:	fffff097          	auipc	ra,0xfffff
    80022374:	626080e7          	jalr	1574(ra) # 80021996 <wakeup1>
  release(&initproc->lock);
    80022378:	6088                	ld	a0,0(s1)
    8002237a:	ffffe097          	auipc	ra,0xffffe
    8002237e:	39a080e7          	jalr	922(ra) # 80020714 <release>
  acquire(&p->lock);
    80022382:	854e                	mv	a0,s3
    80022384:	ffffe097          	auipc	ra,0xffffe
    80022388:	33c080e7          	jalr	828(ra) # 800206c0 <acquire>
  struct proc *original_parent = p->parent;
    8002238c:	0209b483          	ld	s1,32(s3)
  release(&p->lock);
    80022390:	854e                	mv	a0,s3
    80022392:	ffffe097          	auipc	ra,0xffffe
    80022396:	382080e7          	jalr	898(ra) # 80020714 <release>
  acquire(&original_parent->lock);
    8002239a:	8526                	mv	a0,s1
    8002239c:	ffffe097          	auipc	ra,0xffffe
    800223a0:	324080e7          	jalr	804(ra) # 800206c0 <acquire>
  acquire(&p->lock);
    800223a4:	854e                	mv	a0,s3
    800223a6:	ffffe097          	auipc	ra,0xffffe
    800223aa:	31a080e7          	jalr	794(ra) # 800206c0 <acquire>
  reparent(p);
    800223ae:	854e                	mv	a0,s3
    800223b0:	00000097          	auipc	ra,0x0
    800223b4:	d1a080e7          	jalr	-742(ra) # 800220ca <reparent>
  wakeup1(original_parent);
    800223b8:	8526                	mv	a0,s1
    800223ba:	fffff097          	auipc	ra,0xfffff
    800223be:	5dc080e7          	jalr	1500(ra) # 80021996 <wakeup1>
  p->xstate = status;
    800223c2:	0349aa23          	sw	s4,52(s3)
  p->state = ZOMBIE;
    800223c6:	4791                	li	a5,4
    800223c8:	00f9ac23          	sw	a5,24(s3)
  release(&original_parent->lock);
    800223cc:	8526                	mv	a0,s1
    800223ce:	ffffe097          	auipc	ra,0xffffe
    800223d2:	346080e7          	jalr	838(ra) # 80020714 <release>
  sched();
    800223d6:	00000097          	auipc	ra,0x0
    800223da:	e44080e7          	jalr	-444(ra) # 8002221a <sched>
  panic("zombie exit");
    800223de:	00009517          	auipc	a0,0x9
    800223e2:	1f250513          	addi	a0,a0,498 # 8002b5d0 <states.1756+0x168>
    800223e6:	ffffe097          	auipc	ra,0xffffe
    800223ea:	d60080e7          	jalr	-672(ra) # 80020146 <panic>

00000000800223ee <yield>:
{
    800223ee:	1101                	addi	sp,sp,-32
    800223f0:	ec06                	sd	ra,24(sp)
    800223f2:	e822                	sd	s0,16(sp)
    800223f4:	e426                	sd	s1,8(sp)
    800223f6:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800223f8:	fffff097          	auipc	ra,0xfffff
    800223fc:	78a080e7          	jalr	1930(ra) # 80021b82 <myproc>
    80022400:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80022402:	ffffe097          	auipc	ra,0xffffe
    80022406:	2be080e7          	jalr	702(ra) # 800206c0 <acquire>
  p->state = RUNNABLE;
    8002240a:	4789                	li	a5,2
    8002240c:	cc9c                	sw	a5,24(s1)
  sched();
    8002240e:	00000097          	auipc	ra,0x0
    80022412:	e0c080e7          	jalr	-500(ra) # 8002221a <sched>
  release(&p->lock);
    80022416:	8526                	mv	a0,s1
    80022418:	ffffe097          	auipc	ra,0xffffe
    8002241c:	2fc080e7          	jalr	764(ra) # 80020714 <release>
}
    80022420:	60e2                	ld	ra,24(sp)
    80022422:	6442                	ld	s0,16(sp)
    80022424:	64a2                	ld	s1,8(sp)
    80022426:	6105                	addi	sp,sp,32
    80022428:	8082                	ret

000000008002242a <sleep>:
{
    8002242a:	7179                	addi	sp,sp,-48
    8002242c:	f406                	sd	ra,40(sp)
    8002242e:	f022                	sd	s0,32(sp)
    80022430:	ec26                	sd	s1,24(sp)
    80022432:	e84a                	sd	s2,16(sp)
    80022434:	e44e                	sd	s3,8(sp)
    80022436:	1800                	addi	s0,sp,48
    80022438:	89aa                	mv	s3,a0
    8002243a:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8002243c:	fffff097          	auipc	ra,0xfffff
    80022440:	746080e7          	jalr	1862(ra) # 80021b82 <myproc>
    80022444:	84aa                	mv	s1,a0
  if(lk != &p->lock){  //DOC: sleeplock0
    80022446:	05250663          	beq	a0,s2,80022492 <sleep+0x68>
    acquire(&p->lock);  //DOC: sleeplock1
    8002244a:	ffffe097          	auipc	ra,0xffffe
    8002244e:	276080e7          	jalr	630(ra) # 800206c0 <acquire>
    release(lk);
    80022452:	854a                	mv	a0,s2
    80022454:	ffffe097          	auipc	ra,0xffffe
    80022458:	2c0080e7          	jalr	704(ra) # 80020714 <release>
  p->chan = chan;
    8002245c:	0334b423          	sd	s3,40(s1)
  p->state = SLEEPING;
    80022460:	4785                	li	a5,1
    80022462:	cc9c                	sw	a5,24(s1)
  sched();
    80022464:	00000097          	auipc	ra,0x0
    80022468:	db6080e7          	jalr	-586(ra) # 8002221a <sched>
  p->chan = 0;
    8002246c:	0204b423          	sd	zero,40(s1)
    release(&p->lock);
    80022470:	8526                	mv	a0,s1
    80022472:	ffffe097          	auipc	ra,0xffffe
    80022476:	2a2080e7          	jalr	674(ra) # 80020714 <release>
    acquire(lk);
    8002247a:	854a                	mv	a0,s2
    8002247c:	ffffe097          	auipc	ra,0xffffe
    80022480:	244080e7          	jalr	580(ra) # 800206c0 <acquire>
}
    80022484:	70a2                	ld	ra,40(sp)
    80022486:	7402                	ld	s0,32(sp)
    80022488:	64e2                	ld	s1,24(sp)
    8002248a:	6942                	ld	s2,16(sp)
    8002248c:	69a2                	ld	s3,8(sp)
    8002248e:	6145                	addi	sp,sp,48
    80022490:	8082                	ret
  p->chan = chan;
    80022492:	03353423          	sd	s3,40(a0)
  p->state = SLEEPING;
    80022496:	4785                	li	a5,1
    80022498:	cd1c                	sw	a5,24(a0)
  sched();
    8002249a:	00000097          	auipc	ra,0x0
    8002249e:	d80080e7          	jalr	-640(ra) # 8002221a <sched>
  p->chan = 0;
    800224a2:	0204b423          	sd	zero,40(s1)
  if(lk != &p->lock){
    800224a6:	bff9                	j	80022484 <sleep+0x5a>

00000000800224a8 <wait4>:
{
    800224a8:	7159                	addi	sp,sp,-112
    800224aa:	f486                	sd	ra,104(sp)
    800224ac:	f0a2                	sd	s0,96(sp)
    800224ae:	eca6                	sd	s1,88(sp)
    800224b0:	e8ca                	sd	s2,80(sp)
    800224b2:	e4ce                	sd	s3,72(sp)
    800224b4:	e0d2                	sd	s4,64(sp)
    800224b6:	fc56                	sd	s5,56(sp)
    800224b8:	f85a                	sd	s6,48(sp)
    800224ba:	f45e                	sd	s7,40(sp)
    800224bc:	f062                	sd	s8,32(sp)
    800224be:	ec66                	sd	s9,24(sp)
    800224c0:	e86a                	sd	s10,16(sp)
    800224c2:	1880                	addi	s0,sp,112
  if(pid != -1 && pid <= 0)
    800224c4:	57fd                	li	a5,-1
    800224c6:	02f50463          	beq	a0,a5,800224ee <wait4+0x46>
    return -1;
    800224ca:	5bfd                	li	s7,-1
  if(pid != -1 && pid <= 0)
    800224cc:	02a04163          	bgtz	a0,800224ee <wait4+0x46>
}
    800224d0:	855e                	mv	a0,s7
    800224d2:	70a6                	ld	ra,104(sp)
    800224d4:	7406                	ld	s0,96(sp)
    800224d6:	64e6                	ld	s1,88(sp)
    800224d8:	6946                	ld	s2,80(sp)
    800224da:	69a6                	ld	s3,72(sp)
    800224dc:	6a06                	ld	s4,64(sp)
    800224de:	7ae2                	ld	s5,56(sp)
    800224e0:	7b42                	ld	s6,48(sp)
    800224e2:	7ba2                	ld	s7,40(sp)
    800224e4:	7c02                	ld	s8,32(sp)
    800224e6:	6ce2                	ld	s9,24(sp)
    800224e8:	6d42                	ld	s10,16(sp)
    800224ea:	6165                	addi	sp,sp,112
    800224ec:	8082                	ret
    800224ee:	8c32                	mv	s8,a2
    800224f0:	8cae                	mv	s9,a1
    800224f2:	89aa                	mv	s3,a0
  struct proc *p = myproc();
    800224f4:	fffff097          	auipc	ra,0xfffff
    800224f8:	68e080e7          	jalr	1678(ra) # 80021b82 <myproc>
    800224fc:	892a                	mv	s2,a0
  acquire(&p->lock);
    800224fe:	8d2a                	mv	s10,a0
    80022500:	ffffe097          	auipc	ra,0xffffe
    80022504:	1c0080e7          	jalr	448(ra) # 800206c0 <acquire>
      if(pid != -1 && np->pid !=pid)
    80022508:	5afd                	li	s5,-1
      if(np->state == ZOMBIE){
    8002250a:	4b11                	li	s6,4
    for(np = proc; np < &proc[NPROC]; np++){
    8002250c:	00019a17          	auipc	s4,0x19
    80022510:	5dca0a13          	addi	s4,s4,1500 # 8003bae8 <initproc>
    if(options & WNOHANG)
    80022514:	001c7c13          	andi	s8,s8,1
    havekids = 0;
    80022518:	4701                	li	a4,0
    for(np = proc; np < &proc[NPROC]; np++){
    8002251a:	00015497          	auipc	s1,0x15
    8002251e:	c5e48493          	addi	s1,s1,-930 # 80037178 <proc>
      havekids = 1;
    80022522:	4b85                	li	s7,1
    80022524:	a01d                	j	8002254a <wait4+0xa2>
      acquire(&np->lock);
    80022526:	8526                	mv	a0,s1
    80022528:	ffffe097          	auipc	ra,0xffffe
    8002252c:	198080e7          	jalr	408(ra) # 800206c0 <acquire>
      if(np->state == ZOMBIE){
    80022530:	4c9c                	lw	a5,24(s1)
    80022532:	03678563          	beq	a5,s6,8002255c <wait4+0xb4>
      release(&np->lock);
    80022536:	8526                	mv	a0,s1
    80022538:	ffffe097          	auipc	ra,0xffffe
    8002253c:	1dc080e7          	jalr	476(ra) # 80020714 <release>
      havekids = 1;
    80022540:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    80022542:	17848493          	addi	s1,s1,376
    80022546:	07448863          	beq	s1,s4,800225b6 <wait4+0x10e>
      if(np->parent != p)
    8002254a:	709c                	ld	a5,32(s1)
    8002254c:	ff279be3          	bne	a5,s2,80022542 <wait4+0x9a>
      if(pid != -1 && np->pid !=pid)
    80022550:	fd598be3          	beq	s3,s5,80022526 <wait4+0x7e>
    80022554:	5c9c                	lw	a5,56(s1)
    80022556:	fd3788e3          	beq	a5,s3,80022526 <wait4+0x7e>
    8002255a:	b7e5                	j	80022542 <wait4+0x9a>
        res_pid = np->pid;
    8002255c:	0384ab83          	lw	s7,56(s1)
        res_status = np->xstate;
    80022560:	58dc                	lw	a5,52(s1)
    80022562:	f8f42e23          	sw	a5,-100(s0)
        if(addr != 0 && copyout2(addr, (char *)&res_status, sizeof(res_status)) < 0) {
    80022566:	000c8c63          	beqz	s9,8002257e <wait4+0xd6>
    8002256a:	4611                	li	a2,4
    8002256c:	f9c40593          	addi	a1,s0,-100
    80022570:	8566                	mv	a0,s9
    80022572:	fffff097          	auipc	ra,0xfffff
    80022576:	f16080e7          	jalr	-234(ra) # 80021488 <copyout2>
    8002257a:	02054263          	bltz	a0,8002259e <wait4+0xf6>
        freeproc(np);
    8002257e:	8526                	mv	a0,s1
    80022580:	fffff097          	auipc	ra,0xfffff
    80022584:	7d6080e7          	jalr	2006(ra) # 80021d56 <freeproc>
        release(&np->lock);
    80022588:	8526                	mv	a0,s1
    8002258a:	ffffe097          	auipc	ra,0xffffe
    8002258e:	18a080e7          	jalr	394(ra) # 80020714 <release>
        release(&p->lock);
    80022592:	854a                	mv	a0,s2
    80022594:	ffffe097          	auipc	ra,0xffffe
    80022598:	180080e7          	jalr	384(ra) # 80020714 <release>
        return res_pid;
    8002259c:	bf15                	j	800224d0 <wait4+0x28>
          release(&np->lock);
    8002259e:	8526                	mv	a0,s1
    800225a0:	ffffe097          	auipc	ra,0xffffe
    800225a4:	174080e7          	jalr	372(ra) # 80020714 <release>
          release(&p->lock);
    800225a8:	854a                	mv	a0,s2
    800225aa:	ffffe097          	auipc	ra,0xffffe
    800225ae:	16a080e7          	jalr	362(ra) # 80020714 <release>
          return -1;
    800225b2:	5bfd                	li	s7,-1
    800225b4:	bf31                	j	800224d0 <wait4+0x28>
    if(!havekids || p->killed){
    800225b6:	cf11                	beqz	a4,800225d2 <wait4+0x12a>
    800225b8:	03092b83          	lw	s7,48(s2)
    800225bc:	000b9b63          	bnez	s7,800225d2 <wait4+0x12a>
    if(options & WNOHANG)
    800225c0:	f00c18e3          	bnez	s8,800224d0 <wait4+0x28>
    sleep(p, &p->lock);  //DOC: wait-sleep
    800225c4:	85ea                	mv	a1,s10
    800225c6:	854a                	mv	a0,s2
    800225c8:	00000097          	auipc	ra,0x0
    800225cc:	e62080e7          	jalr	-414(ra) # 8002242a <sleep>
    havekids = 0;
    800225d0:	b7a1                	j	80022518 <wait4+0x70>
      release(&p->lock);
    800225d2:	854a                	mv	a0,s2
    800225d4:	ffffe097          	auipc	ra,0xffffe
    800225d8:	140080e7          	jalr	320(ra) # 80020714 <release>
      return -1;
    800225dc:	5bfd                	li	s7,-1
    800225de:	bdcd                	j	800224d0 <wait4+0x28>

00000000800225e0 <wait>:
{
    800225e0:	1141                	addi	sp,sp,-16
    800225e2:	e406                	sd	ra,8(sp)
    800225e4:	e022                	sd	s0,0(sp)
    800225e6:	0800                	addi	s0,sp,16
  return wait4(-1,addr,WCONTINUED);
    800225e8:	4611                	li	a2,4
    800225ea:	85aa                	mv	a1,a0
    800225ec:	557d                	li	a0,-1
    800225ee:	00000097          	auipc	ra,0x0
    800225f2:	eba080e7          	jalr	-326(ra) # 800224a8 <wait4>
}
    800225f6:	60a2                	ld	ra,8(sp)
    800225f8:	6402                	ld	s0,0(sp)
    800225fa:	0141                	addi	sp,sp,16
    800225fc:	8082                	ret

00000000800225fe <wakeup>:
{
    800225fe:	7139                	addi	sp,sp,-64
    80022600:	fc06                	sd	ra,56(sp)
    80022602:	f822                	sd	s0,48(sp)
    80022604:	f426                	sd	s1,40(sp)
    80022606:	f04a                	sd	s2,32(sp)
    80022608:	ec4e                	sd	s3,24(sp)
    8002260a:	e852                	sd	s4,16(sp)
    8002260c:	e456                	sd	s5,8(sp)
    8002260e:	0080                	addi	s0,sp,64
    80022610:	8a2a                	mv	s4,a0
  for(p = proc; p < &proc[NPROC]; p++) {
    80022612:	00015497          	auipc	s1,0x15
    80022616:	b6648493          	addi	s1,s1,-1178 # 80037178 <proc>
    if(p->state == SLEEPING && p->chan == chan) {
    8002261a:	4985                	li	s3,1
      p->state = RUNNABLE;
    8002261c:	4a89                	li	s5,2
  for(p = proc; p < &proc[NPROC]; p++) {
    8002261e:	00019917          	auipc	s2,0x19
    80022622:	4ca90913          	addi	s2,s2,1226 # 8003bae8 <initproc>
    80022626:	a821                	j	8002263e <wakeup+0x40>
      p->state = RUNNABLE;
    80022628:	0154ac23          	sw	s5,24(s1)
    release(&p->lock);
    8002262c:	8526                	mv	a0,s1
    8002262e:	ffffe097          	auipc	ra,0xffffe
    80022632:	0e6080e7          	jalr	230(ra) # 80020714 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80022636:	17848493          	addi	s1,s1,376
    8002263a:	01248e63          	beq	s1,s2,80022656 <wakeup+0x58>
    acquire(&p->lock);
    8002263e:	8526                	mv	a0,s1
    80022640:	ffffe097          	auipc	ra,0xffffe
    80022644:	080080e7          	jalr	128(ra) # 800206c0 <acquire>
    if(p->state == SLEEPING && p->chan == chan) {
    80022648:	4c9c                	lw	a5,24(s1)
    8002264a:	ff3791e3          	bne	a5,s3,8002262c <wakeup+0x2e>
    8002264e:	749c                	ld	a5,40(s1)
    80022650:	fd479ee3          	bne	a5,s4,8002262c <wakeup+0x2e>
    80022654:	bfd1                	j	80022628 <wakeup+0x2a>
}
    80022656:	70e2                	ld	ra,56(sp)
    80022658:	7442                	ld	s0,48(sp)
    8002265a:	74a2                	ld	s1,40(sp)
    8002265c:	7902                	ld	s2,32(sp)
    8002265e:	69e2                	ld	s3,24(sp)
    80022660:	6a42                	ld	s4,16(sp)
    80022662:	6aa2                	ld	s5,8(sp)
    80022664:	6121                	addi	sp,sp,64
    80022666:	8082                	ret

0000000080022668 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80022668:	7179                	addi	sp,sp,-48
    8002266a:	f406                	sd	ra,40(sp)
    8002266c:	f022                	sd	s0,32(sp)
    8002266e:	ec26                	sd	s1,24(sp)
    80022670:	e84a                	sd	s2,16(sp)
    80022672:	e44e                	sd	s3,8(sp)
    80022674:	1800                	addi	s0,sp,48
    80022676:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80022678:	00015497          	auipc	s1,0x15
    8002267c:	b0048493          	addi	s1,s1,-1280 # 80037178 <proc>
    80022680:	00019997          	auipc	s3,0x19
    80022684:	46898993          	addi	s3,s3,1128 # 8003bae8 <initproc>
    acquire(&p->lock);
    80022688:	8526                	mv	a0,s1
    8002268a:	ffffe097          	auipc	ra,0xffffe
    8002268e:	036080e7          	jalr	54(ra) # 800206c0 <acquire>
    if(p->pid == pid){
    80022692:	5c9c                	lw	a5,56(s1)
    80022694:	01278d63          	beq	a5,s2,800226ae <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80022698:	8526                	mv	a0,s1
    8002269a:	ffffe097          	auipc	ra,0xffffe
    8002269e:	07a080e7          	jalr	122(ra) # 80020714 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800226a2:	17848493          	addi	s1,s1,376
    800226a6:	ff3491e3          	bne	s1,s3,80022688 <kill+0x20>
  }
  return -1;
    800226aa:	557d                	li	a0,-1
    800226ac:	a821                	j	800226c4 <kill+0x5c>
      p->killed = 1;
    800226ae:	4785                	li	a5,1
    800226b0:	d89c                	sw	a5,48(s1)
      if(p->state == SLEEPING){
    800226b2:	4c98                	lw	a4,24(s1)
    800226b4:	00f70f63          	beq	a4,a5,800226d2 <kill+0x6a>
      release(&p->lock);
    800226b8:	8526                	mv	a0,s1
    800226ba:	ffffe097          	auipc	ra,0xffffe
    800226be:	05a080e7          	jalr	90(ra) # 80020714 <release>
      return 0;
    800226c2:	4501                	li	a0,0
}
    800226c4:	70a2                	ld	ra,40(sp)
    800226c6:	7402                	ld	s0,32(sp)
    800226c8:	64e2                	ld	s1,24(sp)
    800226ca:	6942                	ld	s2,16(sp)
    800226cc:	69a2                	ld	s3,8(sp)
    800226ce:	6145                	addi	sp,sp,48
    800226d0:	8082                	ret
        p->state = RUNNABLE;
    800226d2:	4789                	li	a5,2
    800226d4:	cc9c                	sw	a5,24(s1)
    800226d6:	b7cd                	j	800226b8 <kill+0x50>

00000000800226d8 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800226d8:	1101                	addi	sp,sp,-32
    800226da:	ec06                	sd	ra,24(sp)
    800226dc:	e822                	sd	s0,16(sp)
    800226de:	e426                	sd	s1,8(sp)
    800226e0:	1000                	addi	s0,sp,32
    800226e2:	84aa                	mv	s1,a0
    800226e4:	852e                	mv	a0,a1
    800226e6:	85b2                	mv	a1,a2
  // struct proc *p = myproc();
  if(user_dst){
    800226e8:	c899                	beqz	s1,800226fe <either_copyout+0x26>
    // return copyout(p->pagetable, dst, src, len);
    return copyout2(dst, src, len);
    800226ea:	8636                	mv	a2,a3
    800226ec:	fffff097          	auipc	ra,0xfffff
    800226f0:	d9c080e7          	jalr	-612(ra) # 80021488 <copyout2>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800226f4:	60e2                	ld	ra,24(sp)
    800226f6:	6442                	ld	s0,16(sp)
    800226f8:	64a2                	ld	s1,8(sp)
    800226fa:	6105                	addi	sp,sp,32
    800226fc:	8082                	ret
    memmove((char *)dst, src, len);
    800226fe:	0006861b          	sext.w	a2,a3
    80022702:	ffffe097          	auipc	ra,0xffffe
    80022706:	0c6080e7          	jalr	198(ra) # 800207c8 <memmove>
    return 0;
    8002270a:	8526                	mv	a0,s1
    8002270c:	b7e5                	j	800226f4 <either_copyout+0x1c>

000000008002270e <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8002270e:	1101                	addi	sp,sp,-32
    80022710:	ec06                	sd	ra,24(sp)
    80022712:	e822                	sd	s0,16(sp)
    80022714:	e426                	sd	s1,8(sp)
    80022716:	1000                	addi	s0,sp,32
    80022718:	84ae                	mv	s1,a1
    8002271a:	85b2                	mv	a1,a2
  // struct proc *p = myproc();
  if(user_src){
    8002271c:	c899                	beqz	s1,80022732 <either_copyin+0x24>
    // return copyin(p->pagetable, dst, src, len);
    return copyin2(dst, src, len);
    8002271e:	8636                	mv	a2,a3
    80022720:	fffff097          	auipc	ra,0xfffff
    80022724:	e48080e7          	jalr	-440(ra) # 80021568 <copyin2>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80022728:	60e2                	ld	ra,24(sp)
    8002272a:	6442                	ld	s0,16(sp)
    8002272c:	64a2                	ld	s1,8(sp)
    8002272e:	6105                	addi	sp,sp,32
    80022730:	8082                	ret
    memmove(dst, (char*)src, len);
    80022732:	0006861b          	sext.w	a2,a3
    80022736:	ffffe097          	auipc	ra,0xffffe
    8002273a:	092080e7          	jalr	146(ra) # 800207c8 <memmove>
    return 0;
    8002273e:	8526                	mv	a0,s1
    80022740:	b7e5                	j	80022728 <either_copyin+0x1a>

0000000080022742 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80022742:	715d                	addi	sp,sp,-80
    80022744:	e486                	sd	ra,72(sp)
    80022746:	e0a2                	sd	s0,64(sp)
    80022748:	fc26                	sd	s1,56(sp)
    8002274a:	f84a                	sd	s2,48(sp)
    8002274c:	f44e                	sd	s3,40(sp)
    8002274e:	f052                	sd	s4,32(sp)
    80022750:	ec56                	sd	s5,24(sp)
    80022752:	e85a                	sd	s6,16(sp)
    80022754:	e45e                	sd	s7,8(sp)
    80022756:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\nPID\tSTATE\tNAME\tMEM\n");
    80022758:	00009517          	auipc	a0,0x9
    8002275c:	e9050513          	addi	a0,a0,-368 # 8002b5e8 <states.1756+0x180>
    80022760:	ffffe097          	auipc	ra,0xffffe
    80022764:	a30080e7          	jalr	-1488(ra) # 80020190 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80022768:	00015497          	auipc	s1,0x15
    8002276c:	b7048493          	addi	s1,s1,-1168 # 800372d8 <proc+0x160>
    80022770:	00019917          	auipc	s2,0x19
    80022774:	4d890913          	addi	s2,s2,1240 # 8003bc48 <bcache+0x158>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80022778:	4b11                	li	s6,4
      state = states[p->state];
    else
      state = "???";
    8002277a:	00009997          	auipc	s3,0x9
    8002277e:	e6698993          	addi	s3,s3,-410 # 8002b5e0 <states.1756+0x178>
    printf("%d\t%s\t%s\t%d", p->pid, state, p->name, p->sz);
    80022782:	00009a97          	auipc	s5,0x9
    80022786:	e7ea8a93          	addi	s5,s5,-386 # 8002b600 <states.1756+0x198>
    printf("\n");
    8002278a:	0000aa17          	auipc	s4,0xa
    8002278e:	19ea0a13          	addi	s4,s4,414 # 8002c928 <syscalls+0x870>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80022792:	00009b97          	auipc	s7,0x9
    80022796:	cd6b8b93          	addi	s7,s7,-810 # 8002b468 <states.1756>
    8002279a:	a025                	j	800227c2 <procdump+0x80>
    printf("%d\t%s\t%s\t%d", p->pid, state, p->name, p->sz);
    8002279c:	ee85b703          	ld	a4,-280(a1)
    800227a0:	86ae                	mv	a3,a1
    800227a2:	ed85a583          	lw	a1,-296(a1)
    800227a6:	8556                	mv	a0,s5
    800227a8:	ffffe097          	auipc	ra,0xffffe
    800227ac:	9e8080e7          	jalr	-1560(ra) # 80020190 <printf>
    printf("\n");
    800227b0:	8552                	mv	a0,s4
    800227b2:	ffffe097          	auipc	ra,0xffffe
    800227b6:	9de080e7          	jalr	-1570(ra) # 80020190 <printf>
    800227ba:	17848493          	addi	s1,s1,376
  for(p = proc; p < &proc[NPROC]; p++){
    800227be:	03248163          	beq	s1,s2,800227e0 <procdump+0x9e>
    if(p->state == UNUSED)
    800227c2:	85a6                	mv	a1,s1
    800227c4:	eb84a783          	lw	a5,-328(s1)
    800227c8:	dbed                	beqz	a5,800227ba <procdump+0x78>
      state = "???";
    800227ca:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800227cc:	fcfb68e3          	bltu	s6,a5,8002279c <procdump+0x5a>
    800227d0:	1782                	slli	a5,a5,0x20
    800227d2:	9381                	srli	a5,a5,0x20
    800227d4:	078e                	slli	a5,a5,0x3
    800227d6:	97de                	add	a5,a5,s7
    800227d8:	6390                	ld	a2,0(a5)
    800227da:	f269                	bnez	a2,8002279c <procdump+0x5a>
      state = "???";
    800227dc:	864e                	mv	a2,s3
    800227de:	bf7d                	j	8002279c <procdump+0x5a>
  }
}
    800227e0:	60a6                	ld	ra,72(sp)
    800227e2:	6406                	ld	s0,64(sp)
    800227e4:	74e2                	ld	s1,56(sp)
    800227e6:	7942                	ld	s2,48(sp)
    800227e8:	79a2                	ld	s3,40(sp)
    800227ea:	7a02                	ld	s4,32(sp)
    800227ec:	6ae2                	ld	s5,24(sp)
    800227ee:	6b42                	ld	s6,16(sp)
    800227f0:	6ba2                	ld	s7,8(sp)
    800227f2:	6161                	addi	sp,sp,80
    800227f4:	8082                	ret

00000000800227f6 <procnum>:

uint64
procnum(void)
{
    800227f6:	1141                	addi	sp,sp,-16
    800227f8:	e422                	sd	s0,8(sp)
    800227fa:	0800                	addi	s0,sp,16
  int num = 0;
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++) {
    800227fc:	00015797          	auipc	a5,0x15
    80022800:	97c78793          	addi	a5,a5,-1668 # 80037178 <proc>
  int num = 0;
    80022804:	4501                	li	a0,0
  for (p = proc; p < &proc[NPROC]; p++) {
    80022806:	00019697          	auipc	a3,0x19
    8002280a:	2e268693          	addi	a3,a3,738 # 8003bae8 <initproc>
    8002280e:	a029                	j	80022818 <procnum+0x22>
    80022810:	17878793          	addi	a5,a5,376
    80022814:	00d78663          	beq	a5,a3,80022820 <procnum+0x2a>
    if (p->state != UNUSED) {
    80022818:	4f98                	lw	a4,24(a5)
    8002281a:	db7d                	beqz	a4,80022810 <procnum+0x1a>
      num++;
    8002281c:	2505                	addiw	a0,a0,1
    8002281e:	bfcd                	j	80022810 <procnum+0x1a>
    }
  }

  return num;
}
    80022820:	6422                	ld	s0,8(sp)
    80022822:	0141                	addi	sp,sp,16
    80022824:	8082                	ret

0000000080022826 <swtch>:
    80022826:	00153023          	sd	ra,0(a0)
    8002282a:	00253423          	sd	sp,8(a0)
    8002282e:	e900                	sd	s0,16(a0)
    80022830:	ed04                	sd	s1,24(a0)
    80022832:	03253023          	sd	s2,32(a0)
    80022836:	03353423          	sd	s3,40(a0)
    8002283a:	03453823          	sd	s4,48(a0)
    8002283e:	03553c23          	sd	s5,56(a0)
    80022842:	05653023          	sd	s6,64(a0)
    80022846:	05753423          	sd	s7,72(a0)
    8002284a:	05853823          	sd	s8,80(a0)
    8002284e:	05953c23          	sd	s9,88(a0)
    80022852:	07a53023          	sd	s10,96(a0)
    80022856:	07b53423          	sd	s11,104(a0)
    8002285a:	0005b083          	ld	ra,0(a1)
    8002285e:	0085b103          	ld	sp,8(a1)
    80022862:	6980                	ld	s0,16(a1)
    80022864:	6d84                	ld	s1,24(a1)
    80022866:	0205b903          	ld	s2,32(a1)
    8002286a:	0285b983          	ld	s3,40(a1)
    8002286e:	0305ba03          	ld	s4,48(a1)
    80022872:	0385ba83          	ld	s5,56(a1)
    80022876:	0405bb03          	ld	s6,64(a1)
    8002287a:	0485bb83          	ld	s7,72(a1)
    8002287e:	0505bc03          	ld	s8,80(a1)
    80022882:	0585bc83          	ld	s9,88(a1)
    80022886:	0605bd03          	ld	s10,96(a1)
    8002288a:	0685bd83          	ld	s11,104(a1)
    8002288e:	8082                	ret

0000000080022890 <trapinithart>:
// }

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80022890:	1141                	addi	sp,sp,-16
    80022892:	e406                	sd	ra,8(sp)
    80022894:	e022                	sd	s0,0(sp)
    80022896:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80022898:	00003797          	auipc	a5,0x3
    8002289c:	8e878793          	addi	a5,a5,-1816 # 80025180 <kernelvec>
    800228a0:	10579073          	csrw	stvec,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800228a4:	100027f3          	csrr	a5,sstatus
  w_stvec((uint64)kernelvec);
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800228a8:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800228ac:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800228b0:	104027f3          	csrr	a5,sie
  // enable supervisor-mode timer interrupts.
  w_sie(r_sie() | SIE_SEIE | SIE_SSIE | SIE_STIE);
    800228b4:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800228b8:	10479073          	csrw	sie,a5
  set_next_timeout();
    800228bc:	00003097          	auipc	ra,0x3
    800228c0:	97a080e7          	jalr	-1670(ra) # 80025236 <set_next_timeout>
  #ifdef DEBUG
  printf("trapinithart\n");
  #endif
}
    800228c4:	60a2                	ld	ra,8(sp)
    800228c6:	6402                	ld	s0,0(sp)
    800228c8:	0141                	addi	sp,sp,16
    800228ca:	8082                	ret

00000000800228cc <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    800228cc:	1141                	addi	sp,sp,-16
    800228ce:	e406                	sd	ra,8(sp)
    800228d0:	e022                	sd	s0,0(sp)
    800228d2:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800228d4:	fffff097          	auipc	ra,0xfffff
    800228d8:	2ae080e7          	jalr	686(ra) # 80021b82 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800228dc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800228e0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800228e2:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    800228e6:	00007617          	auipc	a2,0x7
    800228ea:	71a60613          	addi	a2,a2,1818 # 8002a000 <_trampoline>
    800228ee:	00007697          	auipc	a3,0x7
    800228f2:	71268693          	addi	a3,a3,1810 # 8002a000 <_trampoline>
    800228f6:	8e91                	sub	a3,a3,a2
    800228f8:	040007b7          	lui	a5,0x4000
    800228fc:	17fd                	addi	a5,a5,-1
    800228fe:	07b2                	slli	a5,a5,0xc
    80022900:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80022902:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80022906:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80022908:	180026f3          	csrr	a3,satp
    8002290c:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    8002290e:	7138                	ld	a4,96(a0)
    80022910:	6134                	ld	a3,64(a0)
    80022912:	6585                	lui	a1,0x1
    80022914:	96ae                	add	a3,a3,a1
    80022916:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80022918:	7138                	ld	a4,96(a0)
    8002291a:	00000697          	auipc	a3,0x0
    8002291e:	11a68693          	addi	a3,a3,282 # 80022a34 <usertrap>
    80022922:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80022924:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80022926:	8692                	mv	a3,tp
    80022928:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002292a:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    8002292e:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80022932:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022936:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    8002293a:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    8002293c:	6f18                	ld	a4,24(a4)
    8002293e:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  // printf("[usertrapret]p->pagetable: %p\n", p->pagetable);
  uint64 satp = MAKE_SATP(p->pagetable);
    80022942:	692c                	ld	a1,80(a0)
    80022944:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80022946:	00007717          	auipc	a4,0x7
    8002294a:	74a70713          	addi	a4,a4,1866 # 8002a090 <userret>
    8002294e:	8f11                	sub	a4,a4,a2
    80022950:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80022952:	577d                	li	a4,-1
    80022954:	177e                	slli	a4,a4,0x3f
    80022956:	8dd9                	or	a1,a1,a4
    80022958:	02000537          	lui	a0,0x2000
    8002295c:	157d                	addi	a0,a0,-1
    8002295e:	0536                	slli	a0,a0,0xd
    80022960:	9782                	jalr	a5
}
    80022962:	60a2                	ld	ra,8(sp)
    80022964:	6402                	ld	s0,0(sp)
    80022966:	0141                	addi	sp,sp,16
    80022968:	8082                	ret

000000008002296a <devintr>:
// Check if it's an external/software interrupt, 
// and handle it. 
// returns  2 if timer interrupt, 
//          1 if other device, 
//          0 if not recognized. 
int devintr(void) {
    8002296a:	1101                	addi	sp,sp,-32
    8002296c:	ec06                	sd	ra,24(sp)
    8002296e:	e822                	sd	s0,16(sp)
    80022970:	e426                	sd	s1,8(sp)
    80022972:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022974:	14202773          	csrr	a4,scause
	if ((0x8000000000000000L & scause) && 9 == (scause & 0xff)) 
	#else 
	// on k210, supervisor software interrupt is used 
	// in alternative to supervisor external interrupt, 
	// which is not available on k210. 
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    80022978:	57fd                	li	a5,-1
    8002297a:	17fe                	slli	a5,a5,0x3f
    8002297c:	0785                	addi	a5,a5,1
    8002297e:	00f70d63          	beq	a4,a5,80022998 <devintr+0x2e>
		sbi_set_mie();
		#endif 

		return 1;
	}
	else if (0x8000000000000005L == scause) {
    80022982:	57fd                	li	a5,-1
    80022984:	17fe                	slli	a5,a5,0x3f
    80022986:	0795                	addi	a5,a5,5
		timer_tick();
		return 2;
	}
	else { return 0;}
    80022988:	4501                	li	a0,0
	else if (0x8000000000000005L == scause) {
    8002298a:	08f70f63          	beq	a4,a5,80022a28 <devintr+0xbe>
}
    8002298e:	60e2                	ld	ra,24(sp)
    80022990:	6442                	ld	s0,16(sp)
    80022992:	64a2                	ld	s1,8(sp)
    80022994:	6105                	addi	sp,sp,32
    80022996:	8082                	ret
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022998:	14302773          	csrr	a4,stval
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    8002299c:	47a5                	li	a5,9
	else { return 0;}
    8002299e:	4501                	li	a0,0
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    800229a0:	fef717e3          	bne	a4,a5,8002298e <devintr+0x24>
		int irq = plic_claim();
    800229a4:	00004097          	auipc	ra,0x4
    800229a8:	2fa080e7          	jalr	762(ra) # 80026c9e <plic_claim>
    800229ac:	84aa                	mv	s1,a0
		if (UART_IRQ == irq) {
    800229ae:	02100793          	li	a5,33
    800229b2:	02f50663          	beq	a0,a5,800229de <devintr+0x74>
		else if (DISK_IRQ == irq) {
    800229b6:	47ed                	li	a5,27
    800229b8:	04f50963          	beq	a0,a5,80022a0a <devintr+0xa0>
		else if (irq) {
    800229bc:	ed21                	bnez	a0,80022a14 <devintr+0xaa>
  asm volatile("csrr %0, sip" : "=r" (x) );
    800229be:	144027f3          	csrr	a5,sip
		w_sip(r_sip() & ~2);    // clear pending bit
    800229c2:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    800229c4:	14479073          	csrw	sip,a5
	asm volatile("mv a6, %0" : : "r" (0x210));
	SBI_CALL_1(0x0A000004, func_pointer);
}

static inline void sbi_set_mie(void) {
	SBI_CALL_0(0x0A000005);
    800229c8:	4501                	li	a0,0
    800229ca:	4581                	li	a1,0
    800229cc:	4601                	li	a2,0
    800229ce:	4681                	li	a3,0
    800229d0:	0a0008b7          	lui	a7,0xa000
    800229d4:	0895                	addi	a7,a7,5
    800229d6:	00000073          	ecall
		return 1;
    800229da:	4505                	li	a0,1
    800229dc:	bf4d                	j	8002298e <devintr+0x24>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
    800229de:	4501                	li	a0,0
    800229e0:	4581                	li	a1,0
    800229e2:	4601                	li	a2,0
    800229e4:	4681                	li	a3,0
    800229e6:	4889                	li	a7,2
    800229e8:	00000073          	ecall
    800229ec:	2501                	sext.w	a0,a0
			if (-1 != c) {
    800229ee:	57fd                	li	a5,-1
    800229f0:	00f51863          	bne	a0,a5,80022a00 <devintr+0x96>
		if (irq) { plic_complete(irq);}
    800229f4:	8526                	mv	a0,s1
    800229f6:	00004097          	auipc	ra,0x4
    800229fa:	2ce080e7          	jalr	718(ra) # 80026cc4 <plic_complete>
    800229fe:	b7c1                	j	800229be <devintr+0x54>
				consoleintr(c);
    80022a00:	00004097          	auipc	ra,0x4
    80022a04:	4d0080e7          	jalr	1232(ra) # 80026ed0 <consoleintr>
    80022a08:	b7f5                	j	800229f4 <devintr+0x8a>
			disk_intr();
    80022a0a:	00003097          	auipc	ra,0x3
    80022a0e:	8f4080e7          	jalr	-1804(ra) # 800252fe <disk_intr>
    80022a12:	b7cd                	j	800229f4 <devintr+0x8a>
			printf("unexpected interrupt irq = %d\n", irq);
    80022a14:	85aa                	mv	a1,a0
    80022a16:	00009517          	auipc	a0,0x9
    80022a1a:	c2250513          	addi	a0,a0,-990 # 8002b638 <states.1756+0x1d0>
    80022a1e:	ffffd097          	auipc	ra,0xffffd
    80022a22:	772080e7          	jalr	1906(ra) # 80020190 <printf>
    80022a26:	b7f9                	j	800229f4 <devintr+0x8a>
		timer_tick();
    80022a28:	00003097          	auipc	ra,0x3
    80022a2c:	834080e7          	jalr	-1996(ra) # 8002525c <timer_tick>
		return 2;
    80022a30:	4509                	li	a0,2
    80022a32:	bfb1                	j	8002298e <devintr+0x24>

0000000080022a34 <usertrap>:
{
    80022a34:	1101                	addi	sp,sp,-32
    80022a36:	ec06                	sd	ra,24(sp)
    80022a38:	e822                	sd	s0,16(sp)
    80022a3a:	e426                	sd	s1,8(sp)
    80022a3c:	e04a                	sd	s2,0(sp)
    80022a3e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022a40:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80022a44:	1007f793          	andi	a5,a5,256
    80022a48:	e3ad                	bnez	a5,80022aaa <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80022a4a:	00002797          	auipc	a5,0x2
    80022a4e:	73678793          	addi	a5,a5,1846 # 80025180 <kernelvec>
    80022a52:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80022a56:	fffff097          	auipc	ra,0xfffff
    80022a5a:	12c080e7          	jalr	300(ra) # 80021b82 <myproc>
    80022a5e:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80022a60:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022a62:	14102773          	csrr	a4,sepc
    80022a66:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022a68:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80022a6c:	47a1                	li	a5,8
    80022a6e:	04f71c63          	bne	a4,a5,80022ac6 <usertrap+0x92>
    if(p->killed)
    80022a72:	591c                	lw	a5,48(a0)
    80022a74:	e3b9                	bnez	a5,80022aba <usertrap+0x86>
    p->trapframe->epc += 4;
    80022a76:	70b8                	ld	a4,96(s1)
    80022a78:	6f1c                	ld	a5,24(a4)
    80022a7a:	0791                	addi	a5,a5,4
    80022a7c:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022a7e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80022a82:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022a86:	10079073          	csrw	sstatus,a5
    syscall();
    80022a8a:	00000097          	auipc	ra,0x0
    80022a8e:	5d4080e7          	jalr	1492(ra) # 8002305e <syscall>
  if(p->killed)
    80022a92:	589c                	lw	a5,48(s1)
    80022a94:	ebd1                	bnez	a5,80022b28 <usertrap+0xf4>
  usertrapret();
    80022a96:	00000097          	auipc	ra,0x0
    80022a9a:	e36080e7          	jalr	-458(ra) # 800228cc <usertrapret>
}
    80022a9e:	60e2                	ld	ra,24(sp)
    80022aa0:	6442                	ld	s0,16(sp)
    80022aa2:	64a2                	ld	s1,8(sp)
    80022aa4:	6902                	ld	s2,0(sp)
    80022aa6:	6105                	addi	sp,sp,32
    80022aa8:	8082                	ret
    panic("usertrap: not from user mode");
    80022aaa:	00009517          	auipc	a0,0x9
    80022aae:	bae50513          	addi	a0,a0,-1106 # 8002b658 <states.1756+0x1f0>
    80022ab2:	ffffd097          	auipc	ra,0xffffd
    80022ab6:	694080e7          	jalr	1684(ra) # 80020146 <panic>
      exit(-1);
    80022aba:	557d                	li	a0,-1
    80022abc:	00000097          	auipc	ra,0x0
    80022ac0:	836080e7          	jalr	-1994(ra) # 800222f2 <exit>
    80022ac4:	bf4d                	j	80022a76 <usertrap+0x42>
  else if((which_dev = devintr()) != 0){
    80022ac6:	00000097          	auipc	ra,0x0
    80022aca:	ea4080e7          	jalr	-348(ra) # 8002296a <devintr>
    80022ace:	892a                	mv	s2,a0
    80022ad0:	c501                	beqz	a0,80022ad8 <usertrap+0xa4>
  if(p->killed)
    80022ad2:	589c                	lw	a5,48(s1)
    80022ad4:	c3b1                	beqz	a5,80022b18 <usertrap+0xe4>
    80022ad6:	a825                	j	80022b0e <usertrap+0xda>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022ad8:	142025f3          	csrr	a1,scause
    printf("\nusertrap(): unexpected scause %p pid=%d %s\n", r_scause(), p->pid, p->name);
    80022adc:	16048693          	addi	a3,s1,352
    80022ae0:	5c90                	lw	a2,56(s1)
    80022ae2:	00009517          	auipc	a0,0x9
    80022ae6:	b9650513          	addi	a0,a0,-1130 # 8002b678 <states.1756+0x210>
    80022aea:	ffffd097          	auipc	ra,0xffffd
    80022aee:	6a6080e7          	jalr	1702(ra) # 80020190 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022af2:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022af6:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80022afa:	00009517          	auipc	a0,0x9
    80022afe:	bae50513          	addi	a0,a0,-1106 # 8002b6a8 <states.1756+0x240>
    80022b02:	ffffd097          	auipc	ra,0xffffd
    80022b06:	68e080e7          	jalr	1678(ra) # 80020190 <printf>
    p->killed = 1;
    80022b0a:	4785                	li	a5,1
    80022b0c:	d89c                	sw	a5,48(s1)
    exit(-1);
    80022b0e:	557d                	li	a0,-1
    80022b10:	fffff097          	auipc	ra,0xfffff
    80022b14:	7e2080e7          	jalr	2018(ra) # 800222f2 <exit>
  if(which_dev == 2)
    80022b18:	4789                	li	a5,2
    80022b1a:	f6f91ee3          	bne	s2,a5,80022a96 <usertrap+0x62>
    yield();
    80022b1e:	00000097          	auipc	ra,0x0
    80022b22:	8d0080e7          	jalr	-1840(ra) # 800223ee <yield>
    80022b26:	bf85                	j	80022a96 <usertrap+0x62>
  int which_dev = 0;
    80022b28:	4901                	li	s2,0
    80022b2a:	b7d5                	j	80022b0e <usertrap+0xda>

0000000080022b2c <kerneltrap>:
kerneltrap() {
    80022b2c:	7179                	addi	sp,sp,-48
    80022b2e:	f406                	sd	ra,40(sp)
    80022b30:	f022                	sd	s0,32(sp)
    80022b32:	ec26                	sd	s1,24(sp)
    80022b34:	e84a                	sd	s2,16(sp)
    80022b36:	e44e                	sd	s3,8(sp)
    80022b38:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022b3a:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022b3e:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022b42:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80022b46:	1004f793          	andi	a5,s1,256
    80022b4a:	cb85                	beqz	a5,80022b7a <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022b4c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80022b50:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80022b52:	ef85                	bnez	a5,80022b8a <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80022b54:	00000097          	auipc	ra,0x0
    80022b58:	e16080e7          	jalr	-490(ra) # 8002296a <devintr>
    80022b5c:	cd1d                	beqz	a0,80022b9a <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    80022b5e:	4789                	li	a5,2
    80022b60:	08f50b63          	beq	a0,a5,80022bf6 <kerneltrap+0xca>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80022b64:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022b68:	10049073          	csrw	sstatus,s1
}
    80022b6c:	70a2                	ld	ra,40(sp)
    80022b6e:	7402                	ld	s0,32(sp)
    80022b70:	64e2                	ld	s1,24(sp)
    80022b72:	6942                	ld	s2,16(sp)
    80022b74:	69a2                	ld	s3,8(sp)
    80022b76:	6145                	addi	sp,sp,48
    80022b78:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80022b7a:	00009517          	auipc	a0,0x9
    80022b7e:	b4e50513          	addi	a0,a0,-1202 # 8002b6c8 <states.1756+0x260>
    80022b82:	ffffd097          	auipc	ra,0xffffd
    80022b86:	5c4080e7          	jalr	1476(ra) # 80020146 <panic>
    panic("kerneltrap: interrupts enabled");
    80022b8a:	00009517          	auipc	a0,0x9
    80022b8e:	b6650513          	addi	a0,a0,-1178 # 8002b6f0 <states.1756+0x288>
    80022b92:	ffffd097          	auipc	ra,0xffffd
    80022b96:	5b4080e7          	jalr	1460(ra) # 80020146 <panic>
    printf("\nscause %p\n", scause);
    80022b9a:	85ce                	mv	a1,s3
    80022b9c:	00009517          	auipc	a0,0x9
    80022ba0:	b7450513          	addi	a0,a0,-1164 # 8002b710 <states.1756+0x2a8>
    80022ba4:	ffffd097          	auipc	ra,0xffffd
    80022ba8:	5ec080e7          	jalr	1516(ra) # 80020190 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022bac:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022bb0:	14302673          	csrr	a2,stval
  asm volatile("mv %0, tp" : "=r" (x) );
    80022bb4:	8692                	mv	a3,tp
    printf("sepc=%p stval=%p hart=%d\n", r_sepc(), r_stval(), r_tp());
    80022bb6:	00009517          	auipc	a0,0x9
    80022bba:	b6a50513          	addi	a0,a0,-1174 # 8002b720 <states.1756+0x2b8>
    80022bbe:	ffffd097          	auipc	ra,0xffffd
    80022bc2:	5d2080e7          	jalr	1490(ra) # 80020190 <printf>
    struct proc *p = myproc();
    80022bc6:	fffff097          	auipc	ra,0xfffff
    80022bca:	fbc080e7          	jalr	-68(ra) # 80021b82 <myproc>
    if (p != 0) {
    80022bce:	cd01                	beqz	a0,80022be6 <kerneltrap+0xba>
      printf("pid: %d, name: %s\n", p->pid, p->name);
    80022bd0:	16050613          	addi	a2,a0,352
    80022bd4:	5d0c                	lw	a1,56(a0)
    80022bd6:	00009517          	auipc	a0,0x9
    80022bda:	b6a50513          	addi	a0,a0,-1174 # 8002b740 <states.1756+0x2d8>
    80022bde:	ffffd097          	auipc	ra,0xffffd
    80022be2:	5b2080e7          	jalr	1458(ra) # 80020190 <printf>
    panic("kerneltrap");
    80022be6:	00009517          	auipc	a0,0x9
    80022bea:	b7250513          	addi	a0,a0,-1166 # 8002b758 <states.1756+0x2f0>
    80022bee:	ffffd097          	auipc	ra,0xffffd
    80022bf2:	558080e7          	jalr	1368(ra) # 80020146 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    80022bf6:	fffff097          	auipc	ra,0xfffff
    80022bfa:	f8c080e7          	jalr	-116(ra) # 80021b82 <myproc>
    80022bfe:	d13d                	beqz	a0,80022b64 <kerneltrap+0x38>
    80022c00:	fffff097          	auipc	ra,0xfffff
    80022c04:	f82080e7          	jalr	-126(ra) # 80021b82 <myproc>
    80022c08:	4d18                	lw	a4,24(a0)
    80022c0a:	478d                	li	a5,3
    80022c0c:	f4f71ce3          	bne	a4,a5,80022b64 <kerneltrap+0x38>
    yield();
    80022c10:	fffff097          	auipc	ra,0xfffff
    80022c14:	7de080e7          	jalr	2014(ra) # 800223ee <yield>
    80022c18:	b7b1                	j	80022b64 <kerneltrap+0x38>

0000000080022c1a <trapframedump>:

void trapframedump(struct trapframe *tf)
{
    80022c1a:	1101                	addi	sp,sp,-32
    80022c1c:	ec06                	sd	ra,24(sp)
    80022c1e:	e822                	sd	s0,16(sp)
    80022c20:	e426                	sd	s1,8(sp)
    80022c22:	1000                	addi	s0,sp,32
    80022c24:	84aa                	mv	s1,a0
  printf("a0: %p\t", tf->a0);
    80022c26:	792c                	ld	a1,112(a0)
    80022c28:	00009517          	auipc	a0,0x9
    80022c2c:	b4050513          	addi	a0,a0,-1216 # 8002b768 <states.1756+0x300>
    80022c30:	ffffd097          	auipc	ra,0xffffd
    80022c34:	560080e7          	jalr	1376(ra) # 80020190 <printf>
  printf("a1: %p\t", tf->a1);
    80022c38:	7cac                	ld	a1,120(s1)
    80022c3a:	00009517          	auipc	a0,0x9
    80022c3e:	b3650513          	addi	a0,a0,-1226 # 8002b770 <states.1756+0x308>
    80022c42:	ffffd097          	auipc	ra,0xffffd
    80022c46:	54e080e7          	jalr	1358(ra) # 80020190 <printf>
  printf("a2: %p\t", tf->a2);
    80022c4a:	60cc                	ld	a1,128(s1)
    80022c4c:	00009517          	auipc	a0,0x9
    80022c50:	b2c50513          	addi	a0,a0,-1236 # 8002b778 <states.1756+0x310>
    80022c54:	ffffd097          	auipc	ra,0xffffd
    80022c58:	53c080e7          	jalr	1340(ra) # 80020190 <printf>
  printf("a3: %p\n", tf->a3);
    80022c5c:	64cc                	ld	a1,136(s1)
    80022c5e:	00009517          	auipc	a0,0x9
    80022c62:	b2250513          	addi	a0,a0,-1246 # 8002b780 <states.1756+0x318>
    80022c66:	ffffd097          	auipc	ra,0xffffd
    80022c6a:	52a080e7          	jalr	1322(ra) # 80020190 <printf>
  printf("a4: %p\t", tf->a4);
    80022c6e:	68cc                	ld	a1,144(s1)
    80022c70:	00009517          	auipc	a0,0x9
    80022c74:	b1850513          	addi	a0,a0,-1256 # 8002b788 <states.1756+0x320>
    80022c78:	ffffd097          	auipc	ra,0xffffd
    80022c7c:	518080e7          	jalr	1304(ra) # 80020190 <printf>
  printf("a5: %p\t", tf->a5);
    80022c80:	6ccc                	ld	a1,152(s1)
    80022c82:	00009517          	auipc	a0,0x9
    80022c86:	b0e50513          	addi	a0,a0,-1266 # 8002b790 <states.1756+0x328>
    80022c8a:	ffffd097          	auipc	ra,0xffffd
    80022c8e:	506080e7          	jalr	1286(ra) # 80020190 <printf>
  printf("a6: %p\t", tf->a6);
    80022c92:	70cc                	ld	a1,160(s1)
    80022c94:	00009517          	auipc	a0,0x9
    80022c98:	b0450513          	addi	a0,a0,-1276 # 8002b798 <states.1756+0x330>
    80022c9c:	ffffd097          	auipc	ra,0xffffd
    80022ca0:	4f4080e7          	jalr	1268(ra) # 80020190 <printf>
  printf("a7: %p\n", tf->a7);
    80022ca4:	74cc                	ld	a1,168(s1)
    80022ca6:	00009517          	auipc	a0,0x9
    80022caa:	afa50513          	addi	a0,a0,-1286 # 8002b7a0 <states.1756+0x338>
    80022cae:	ffffd097          	auipc	ra,0xffffd
    80022cb2:	4e2080e7          	jalr	1250(ra) # 80020190 <printf>
  printf("t0: %p\t", tf->t0);
    80022cb6:	64ac                	ld	a1,72(s1)
    80022cb8:	00009517          	auipc	a0,0x9
    80022cbc:	af050513          	addi	a0,a0,-1296 # 8002b7a8 <states.1756+0x340>
    80022cc0:	ffffd097          	auipc	ra,0xffffd
    80022cc4:	4d0080e7          	jalr	1232(ra) # 80020190 <printf>
  printf("t1: %p\t", tf->t1);
    80022cc8:	68ac                	ld	a1,80(s1)
    80022cca:	00009517          	auipc	a0,0x9
    80022cce:	ae650513          	addi	a0,a0,-1306 # 8002b7b0 <states.1756+0x348>
    80022cd2:	ffffd097          	auipc	ra,0xffffd
    80022cd6:	4be080e7          	jalr	1214(ra) # 80020190 <printf>
  printf("t2: %p\t", tf->t2);
    80022cda:	6cac                	ld	a1,88(s1)
    80022cdc:	00009517          	auipc	a0,0x9
    80022ce0:	adc50513          	addi	a0,a0,-1316 # 8002b7b8 <states.1756+0x350>
    80022ce4:	ffffd097          	auipc	ra,0xffffd
    80022ce8:	4ac080e7          	jalr	1196(ra) # 80020190 <printf>
  printf("t3: %p\n", tf->t3);
    80022cec:	1004b583          	ld	a1,256(s1)
    80022cf0:	00009517          	auipc	a0,0x9
    80022cf4:	ad050513          	addi	a0,a0,-1328 # 8002b7c0 <states.1756+0x358>
    80022cf8:	ffffd097          	auipc	ra,0xffffd
    80022cfc:	498080e7          	jalr	1176(ra) # 80020190 <printf>
  printf("t4: %p\t", tf->t4);
    80022d00:	1084b583          	ld	a1,264(s1)
    80022d04:	00009517          	auipc	a0,0x9
    80022d08:	ac450513          	addi	a0,a0,-1340 # 8002b7c8 <states.1756+0x360>
    80022d0c:	ffffd097          	auipc	ra,0xffffd
    80022d10:	484080e7          	jalr	1156(ra) # 80020190 <printf>
  printf("t5: %p\t", tf->t5);
    80022d14:	1104b583          	ld	a1,272(s1)
    80022d18:	00009517          	auipc	a0,0x9
    80022d1c:	ab850513          	addi	a0,a0,-1352 # 8002b7d0 <states.1756+0x368>
    80022d20:	ffffd097          	auipc	ra,0xffffd
    80022d24:	470080e7          	jalr	1136(ra) # 80020190 <printf>
  printf("t6: %p\t", tf->t6);
    80022d28:	1184b583          	ld	a1,280(s1)
    80022d2c:	00009517          	auipc	a0,0x9
    80022d30:	aac50513          	addi	a0,a0,-1364 # 8002b7d8 <states.1756+0x370>
    80022d34:	ffffd097          	auipc	ra,0xffffd
    80022d38:	45c080e7          	jalr	1116(ra) # 80020190 <printf>
  printf("s0: %p\n", tf->s0);
    80022d3c:	70ac                	ld	a1,96(s1)
    80022d3e:	00009517          	auipc	a0,0x9
    80022d42:	aa250513          	addi	a0,a0,-1374 # 8002b7e0 <states.1756+0x378>
    80022d46:	ffffd097          	auipc	ra,0xffffd
    80022d4a:	44a080e7          	jalr	1098(ra) # 80020190 <printf>
  printf("s1: %p\t", tf->s1);
    80022d4e:	74ac                	ld	a1,104(s1)
    80022d50:	00009517          	auipc	a0,0x9
    80022d54:	a9850513          	addi	a0,a0,-1384 # 8002b7e8 <states.1756+0x380>
    80022d58:	ffffd097          	auipc	ra,0xffffd
    80022d5c:	438080e7          	jalr	1080(ra) # 80020190 <printf>
  printf("s2: %p\t", tf->s2);
    80022d60:	78cc                	ld	a1,176(s1)
    80022d62:	00009517          	auipc	a0,0x9
    80022d66:	a8e50513          	addi	a0,a0,-1394 # 8002b7f0 <states.1756+0x388>
    80022d6a:	ffffd097          	auipc	ra,0xffffd
    80022d6e:	426080e7          	jalr	1062(ra) # 80020190 <printf>
  printf("s3: %p\t", tf->s3);
    80022d72:	7ccc                	ld	a1,184(s1)
    80022d74:	00009517          	auipc	a0,0x9
    80022d78:	a8450513          	addi	a0,a0,-1404 # 8002b7f8 <states.1756+0x390>
    80022d7c:	ffffd097          	auipc	ra,0xffffd
    80022d80:	414080e7          	jalr	1044(ra) # 80020190 <printf>
  printf("s4: %p\n", tf->s4);
    80022d84:	60ec                	ld	a1,192(s1)
    80022d86:	00009517          	auipc	a0,0x9
    80022d8a:	a7a50513          	addi	a0,a0,-1414 # 8002b800 <states.1756+0x398>
    80022d8e:	ffffd097          	auipc	ra,0xffffd
    80022d92:	402080e7          	jalr	1026(ra) # 80020190 <printf>
  printf("s5: %p\t", tf->s5);
    80022d96:	64ec                	ld	a1,200(s1)
    80022d98:	00009517          	auipc	a0,0x9
    80022d9c:	a7050513          	addi	a0,a0,-1424 # 8002b808 <states.1756+0x3a0>
    80022da0:	ffffd097          	auipc	ra,0xffffd
    80022da4:	3f0080e7          	jalr	1008(ra) # 80020190 <printf>
  printf("s6: %p\t", tf->s6);
    80022da8:	68ec                	ld	a1,208(s1)
    80022daa:	00009517          	auipc	a0,0x9
    80022dae:	a6650513          	addi	a0,a0,-1434 # 8002b810 <states.1756+0x3a8>
    80022db2:	ffffd097          	auipc	ra,0xffffd
    80022db6:	3de080e7          	jalr	990(ra) # 80020190 <printf>
  printf("s7: %p\t", tf->s7);
    80022dba:	6cec                	ld	a1,216(s1)
    80022dbc:	00009517          	auipc	a0,0x9
    80022dc0:	a5c50513          	addi	a0,a0,-1444 # 8002b818 <states.1756+0x3b0>
    80022dc4:	ffffd097          	auipc	ra,0xffffd
    80022dc8:	3cc080e7          	jalr	972(ra) # 80020190 <printf>
  printf("s8: %p\n", tf->s8);
    80022dcc:	70ec                	ld	a1,224(s1)
    80022dce:	00009517          	auipc	a0,0x9
    80022dd2:	a5250513          	addi	a0,a0,-1454 # 8002b820 <states.1756+0x3b8>
    80022dd6:	ffffd097          	auipc	ra,0xffffd
    80022dda:	3ba080e7          	jalr	954(ra) # 80020190 <printf>
  printf("s9: %p\t", tf->s9);
    80022dde:	74ec                	ld	a1,232(s1)
    80022de0:	00009517          	auipc	a0,0x9
    80022de4:	a4850513          	addi	a0,a0,-1464 # 8002b828 <states.1756+0x3c0>
    80022de8:	ffffd097          	auipc	ra,0xffffd
    80022dec:	3a8080e7          	jalr	936(ra) # 80020190 <printf>
  printf("s10: %p\t", tf->s10);
    80022df0:	78ec                	ld	a1,240(s1)
    80022df2:	00009517          	auipc	a0,0x9
    80022df6:	a3e50513          	addi	a0,a0,-1474 # 8002b830 <states.1756+0x3c8>
    80022dfa:	ffffd097          	auipc	ra,0xffffd
    80022dfe:	396080e7          	jalr	918(ra) # 80020190 <printf>
  printf("s11: %p\t", tf->s11);
    80022e02:	7cec                	ld	a1,248(s1)
    80022e04:	00009517          	auipc	a0,0x9
    80022e08:	a3c50513          	addi	a0,a0,-1476 # 8002b840 <states.1756+0x3d8>
    80022e0c:	ffffd097          	auipc	ra,0xffffd
    80022e10:	384080e7          	jalr	900(ra) # 80020190 <printf>
  printf("ra: %p\n", tf->ra);
    80022e14:	748c                	ld	a1,40(s1)
    80022e16:	00008517          	auipc	a0,0x8
    80022e1a:	72a50513          	addi	a0,a0,1834 # 8002b540 <states.1756+0xd8>
    80022e1e:	ffffd097          	auipc	ra,0xffffd
    80022e22:	372080e7          	jalr	882(ra) # 80020190 <printf>
  printf("sp: %p\t", tf->sp);
    80022e26:	788c                	ld	a1,48(s1)
    80022e28:	00009517          	auipc	a0,0x9
    80022e2c:	a2850513          	addi	a0,a0,-1496 # 8002b850 <states.1756+0x3e8>
    80022e30:	ffffd097          	auipc	ra,0xffffd
    80022e34:	360080e7          	jalr	864(ra) # 80020190 <printf>
  printf("gp: %p\t", tf->gp);
    80022e38:	7c8c                	ld	a1,56(s1)
    80022e3a:	00009517          	auipc	a0,0x9
    80022e3e:	a1e50513          	addi	a0,a0,-1506 # 8002b858 <states.1756+0x3f0>
    80022e42:	ffffd097          	auipc	ra,0xffffd
    80022e46:	34e080e7          	jalr	846(ra) # 80020190 <printf>
  printf("tp: %p\t", tf->tp);
    80022e4a:	60ac                	ld	a1,64(s1)
    80022e4c:	00009517          	auipc	a0,0x9
    80022e50:	a1450513          	addi	a0,a0,-1516 # 8002b860 <states.1756+0x3f8>
    80022e54:	ffffd097          	auipc	ra,0xffffd
    80022e58:	33c080e7          	jalr	828(ra) # 80020190 <printf>
  printf("epc: %p\n", tf->epc);
    80022e5c:	6c8c                	ld	a1,24(s1)
    80022e5e:	00009517          	auipc	a0,0x9
    80022e62:	a0a50513          	addi	a0,a0,-1526 # 8002b868 <states.1756+0x400>
    80022e66:	ffffd097          	auipc	ra,0xffffd
    80022e6a:	32a080e7          	jalr	810(ra) # 80020190 <printf>
}
    80022e6e:	60e2                	ld	ra,24(sp)
    80022e70:	6442                	ld	s0,16(sp)
    80022e72:	64a2                	ld	s1,8(sp)
    80022e74:	6105                	addi	sp,sp,32
    80022e76:	8082                	ret

0000000080022e78 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80022e78:	1101                	addi	sp,sp,-32
    80022e7a:	ec06                	sd	ra,24(sp)
    80022e7c:	e822                	sd	s0,16(sp)
    80022e7e:	e426                	sd	s1,8(sp)
    80022e80:	1000                	addi	s0,sp,32
    80022e82:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80022e84:	fffff097          	auipc	ra,0xfffff
    80022e88:	cfe080e7          	jalr	-770(ra) # 80021b82 <myproc>
  switch (n) {
    80022e8c:	4795                	li	a5,5
    80022e8e:	0497e163          	bltu	a5,s1,80022ed0 <argraw+0x58>
    80022e92:	048a                	slli	s1,s1,0x2
    80022e94:	00009717          	auipc	a4,0x9
    80022e98:	9e470713          	addi	a4,a4,-1564 # 8002b878 <states.1756+0x410>
    80022e9c:	94ba                	add	s1,s1,a4
    80022e9e:	409c                	lw	a5,0(s1)
    80022ea0:	97ba                	add	a5,a5,a4
    80022ea2:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80022ea4:	713c                	ld	a5,96(a0)
    80022ea6:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80022ea8:	60e2                	ld	ra,24(sp)
    80022eaa:	6442                	ld	s0,16(sp)
    80022eac:	64a2                	ld	s1,8(sp)
    80022eae:	6105                	addi	sp,sp,32
    80022eb0:	8082                	ret
    return p->trapframe->a1;
    80022eb2:	713c                	ld	a5,96(a0)
    80022eb4:	7fa8                	ld	a0,120(a5)
    80022eb6:	bfcd                	j	80022ea8 <argraw+0x30>
    return p->trapframe->a2;
    80022eb8:	713c                	ld	a5,96(a0)
    80022eba:	63c8                	ld	a0,128(a5)
    80022ebc:	b7f5                	j	80022ea8 <argraw+0x30>
    return p->trapframe->a3;
    80022ebe:	713c                	ld	a5,96(a0)
    80022ec0:	67c8                	ld	a0,136(a5)
    80022ec2:	b7dd                	j	80022ea8 <argraw+0x30>
    return p->trapframe->a4;
    80022ec4:	713c                	ld	a5,96(a0)
    80022ec6:	6bc8                	ld	a0,144(a5)
    80022ec8:	b7c5                	j	80022ea8 <argraw+0x30>
    return p->trapframe->a5;
    80022eca:	713c                	ld	a5,96(a0)
    80022ecc:	6fc8                	ld	a0,152(a5)
    80022ece:	bfe9                	j	80022ea8 <argraw+0x30>
  panic("argraw");
    80022ed0:	0000a517          	auipc	a0,0xa
    80022ed4:	a1050513          	addi	a0,a0,-1520 # 8002c8e0 <syscalls+0x828>
    80022ed8:	ffffd097          	auipc	ra,0xffffd
    80022edc:	26e080e7          	jalr	622(ra) # 80020146 <panic>

0000000080022ee0 <sys_sysinfo>:
    return 0;
}

uint64
sys_sysinfo(void)
{
    80022ee0:	7179                	addi	sp,sp,-48
    80022ee2:	f406                	sd	ra,40(sp)
    80022ee4:	f022                	sd	s0,32(sp)
    80022ee6:	ec26                	sd	s1,24(sp)
    80022ee8:	1800                	addi	s0,sp,48
  *ip = argraw(n);
    80022eea:	4501                	li	a0,0
    80022eec:	00000097          	auipc	ra,0x0
    80022ef0:	f8c080e7          	jalr	-116(ra) # 80022e78 <argraw>
    80022ef4:	84aa                	mv	s1,a0
  if (argaddr(0, &addr) < 0) {
    return -1;
  }

  struct sysinfo info;
  info.freemem = freemem_amount();
    80022ef6:	ffffd097          	auipc	ra,0xffffd
    80022efa:	6c2080e7          	jalr	1730(ra) # 800205b8 <freemem_amount>
    80022efe:	fca43823          	sd	a0,-48(s0)
  info.nproc = procnum();
    80022f02:	00000097          	auipc	ra,0x0
    80022f06:	8f4080e7          	jalr	-1804(ra) # 800227f6 <procnum>
    80022f0a:	fca43c23          	sd	a0,-40(s0)

  // if (copyout(p->pagetable, addr, (char *)&info, sizeof(info)) < 0) {
  if (copyout2(addr, (char *)&info, sizeof(info)) < 0) {
    80022f0e:	4641                	li	a2,16
    80022f10:	fd040593          	addi	a1,s0,-48
    80022f14:	8526                	mv	a0,s1
    80022f16:	ffffe097          	auipc	ra,0xffffe
    80022f1a:	572080e7          	jalr	1394(ra) # 80021488 <copyout2>
    return -1;
  }

  return 0;
    80022f1e:	957d                	srai	a0,a0,0x3f
    80022f20:	70a2                	ld	ra,40(sp)
    80022f22:	7402                	ld	s0,32(sp)
    80022f24:	64e2                	ld	s1,24(sp)
    80022f26:	6145                	addi	sp,sp,48
    80022f28:	8082                	ret

0000000080022f2a <fetchaddr>:
{
    80022f2a:	1101                	addi	sp,sp,-32
    80022f2c:	ec06                	sd	ra,24(sp)
    80022f2e:	e822                	sd	s0,16(sp)
    80022f30:	e426                	sd	s1,8(sp)
    80022f32:	e04a                	sd	s2,0(sp)
    80022f34:	1000                	addi	s0,sp,32
    80022f36:	84aa                	mv	s1,a0
    80022f38:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80022f3a:	fffff097          	auipc	ra,0xfffff
    80022f3e:	c48080e7          	jalr	-952(ra) # 80021b82 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80022f42:	653c                	ld	a5,72(a0)
    80022f44:	02f4f763          	bgeu	s1,a5,80022f72 <fetchaddr+0x48>
    80022f48:	00848713          	addi	a4,s1,8
    80022f4c:	02e7e563          	bltu	a5,a4,80022f76 <fetchaddr+0x4c>
  if(copyin2((char *)ip, addr, sizeof(*ip)) != 0)
    80022f50:	4621                	li	a2,8
    80022f52:	85a6                	mv	a1,s1
    80022f54:	854a                	mv	a0,s2
    80022f56:	ffffe097          	auipc	ra,0xffffe
    80022f5a:	612080e7          	jalr	1554(ra) # 80021568 <copyin2>
    80022f5e:	00a03533          	snez	a0,a0
    80022f62:	40a00533          	neg	a0,a0
}
    80022f66:	60e2                	ld	ra,24(sp)
    80022f68:	6442                	ld	s0,16(sp)
    80022f6a:	64a2                	ld	s1,8(sp)
    80022f6c:	6902                	ld	s2,0(sp)
    80022f6e:	6105                	addi	sp,sp,32
    80022f70:	8082                	ret
    return -1;
    80022f72:	557d                	li	a0,-1
    80022f74:	bfcd                	j	80022f66 <fetchaddr+0x3c>
    80022f76:	557d                	li	a0,-1
    80022f78:	b7fd                	j	80022f66 <fetchaddr+0x3c>

0000000080022f7a <fetchstr>:
{
    80022f7a:	1101                	addi	sp,sp,-32
    80022f7c:	ec06                	sd	ra,24(sp)
    80022f7e:	e822                	sd	s0,16(sp)
    80022f80:	e426                	sd	s1,8(sp)
    80022f82:	1000                	addi	s0,sp,32
    80022f84:	84ae                	mv	s1,a1
  int err = copyinstr2(buf, addr, max);
    80022f86:	85aa                	mv	a1,a0
    80022f88:	8526                	mv	a0,s1
    80022f8a:	ffffe097          	auipc	ra,0xffffe
    80022f8e:	6f6080e7          	jalr	1782(ra) # 80021680 <copyinstr2>
  if(err < 0)
    80022f92:	00054763          	bltz	a0,80022fa0 <fetchstr+0x26>
  return strlen(buf);
    80022f96:	8526                	mv	a0,s1
    80022f98:	ffffe097          	auipc	ra,0xffffe
    80022f9c:	96e080e7          	jalr	-1682(ra) # 80020906 <strlen>
}
    80022fa0:	60e2                	ld	ra,24(sp)
    80022fa2:	6442                	ld	s0,16(sp)
    80022fa4:	64a2                	ld	s1,8(sp)
    80022fa6:	6105                	addi	sp,sp,32
    80022fa8:	8082                	ret

0000000080022faa <argint>:
{
    80022faa:	1101                	addi	sp,sp,-32
    80022fac:	ec06                	sd	ra,24(sp)
    80022fae:	e822                	sd	s0,16(sp)
    80022fb0:	e426                	sd	s1,8(sp)
    80022fb2:	1000                	addi	s0,sp,32
    80022fb4:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80022fb6:	00000097          	auipc	ra,0x0
    80022fba:	ec2080e7          	jalr	-318(ra) # 80022e78 <argraw>
    80022fbe:	c088                	sw	a0,0(s1)
}
    80022fc0:	4501                	li	a0,0
    80022fc2:	60e2                	ld	ra,24(sp)
    80022fc4:	6442                	ld	s0,16(sp)
    80022fc6:	64a2                	ld	s1,8(sp)
    80022fc8:	6105                	addi	sp,sp,32
    80022fca:	8082                	ret

0000000080022fcc <sys_test_proc>:
sys_test_proc(void) {
    80022fcc:	1101                	addi	sp,sp,-32
    80022fce:	ec06                	sd	ra,24(sp)
    80022fd0:	e822                	sd	s0,16(sp)
    80022fd2:	1000                	addi	s0,sp,32
    argint(0, &n);
    80022fd4:	fec40593          	addi	a1,s0,-20
    80022fd8:	4501                	li	a0,0
    80022fda:	00000097          	auipc	ra,0x0
    80022fde:	fd0080e7          	jalr	-48(ra) # 80022faa <argint>
    printf("hello world from proc %d, hart %d, arg %d\n", myproc()->pid, r_tp(), n);
    80022fe2:	fffff097          	auipc	ra,0xfffff
    80022fe6:	ba0080e7          	jalr	-1120(ra) # 80021b82 <myproc>
    80022fea:	8612                	mv	a2,tp
    80022fec:	fec42683          	lw	a3,-20(s0)
    80022ff0:	5d0c                	lw	a1,56(a0)
    80022ff2:	0000a517          	auipc	a0,0xa
    80022ff6:	8f650513          	addi	a0,a0,-1802 # 8002c8e8 <syscalls+0x830>
    80022ffa:	ffffd097          	auipc	ra,0xffffd
    80022ffe:	196080e7          	jalr	406(ra) # 80020190 <printf>
}
    80023002:	4501                	li	a0,0
    80023004:	60e2                	ld	ra,24(sp)
    80023006:	6442                	ld	s0,16(sp)
    80023008:	6105                	addi	sp,sp,32
    8002300a:	8082                	ret

000000008002300c <argaddr>:
{
    8002300c:	1101                	addi	sp,sp,-32
    8002300e:	ec06                	sd	ra,24(sp)
    80023010:	e822                	sd	s0,16(sp)
    80023012:	e426                	sd	s1,8(sp)
    80023014:	1000                	addi	s0,sp,32
    80023016:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80023018:	00000097          	auipc	ra,0x0
    8002301c:	e60080e7          	jalr	-416(ra) # 80022e78 <argraw>
    80023020:	e088                	sd	a0,0(s1)
}
    80023022:	4501                	li	a0,0
    80023024:	60e2                	ld	ra,24(sp)
    80023026:	6442                	ld	s0,16(sp)
    80023028:	64a2                	ld	s1,8(sp)
    8002302a:	6105                	addi	sp,sp,32
    8002302c:	8082                	ret

000000008002302e <argstr>:
{
    8002302e:	1101                	addi	sp,sp,-32
    80023030:	ec06                	sd	ra,24(sp)
    80023032:	e822                	sd	s0,16(sp)
    80023034:	e426                	sd	s1,8(sp)
    80023036:	e04a                	sd	s2,0(sp)
    80023038:	1000                	addi	s0,sp,32
    8002303a:	84ae                	mv	s1,a1
    8002303c:	8932                	mv	s2,a2
  *ip = argraw(n);
    8002303e:	00000097          	auipc	ra,0x0
    80023042:	e3a080e7          	jalr	-454(ra) # 80022e78 <argraw>
  return fetchstr(addr, buf, max);
    80023046:	864a                	mv	a2,s2
    80023048:	85a6                	mv	a1,s1
    8002304a:	00000097          	auipc	ra,0x0
    8002304e:	f30080e7          	jalr	-208(ra) # 80022f7a <fetchstr>
}
    80023052:	60e2                	ld	ra,24(sp)
    80023054:	6442                	ld	s0,16(sp)
    80023056:	64a2                	ld	s1,8(sp)
    80023058:	6902                	ld	s2,0(sp)
    8002305a:	6105                	addi	sp,sp,32
    8002305c:	8082                	ret

000000008002305e <syscall>:
{
    8002305e:	7179                	addi	sp,sp,-48
    80023060:	f406                	sd	ra,40(sp)
    80023062:	f022                	sd	s0,32(sp)
    80023064:	ec26                	sd	s1,24(sp)
    80023066:	e84a                	sd	s2,16(sp)
    80023068:	e44e                	sd	s3,8(sp)
    8002306a:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8002306c:	fffff097          	auipc	ra,0xfffff
    80023070:	b16080e7          	jalr	-1258(ra) # 80021b82 <myproc>
    80023074:	84aa                	mv	s1,a0
  num = p->trapframe->a7;
    80023076:	06053983          	ld	s3,96(a0)
    8002307a:	0a89b783          	ld	a5,168(s3)
    8002307e:	0007891b          	sext.w	s2,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80023082:	37fd                	addiw	a5,a5,-1
    80023084:	10300713          	li	a4,259
    80023088:	04f76863          	bltu	a4,a5,800230d8 <syscall+0x7a>
    8002308c:	00391713          	slli	a4,s2,0x3
    80023090:	00009797          	auipc	a5,0x9
    80023094:	02878793          	addi	a5,a5,40 # 8002c0b8 <syscalls>
    80023098:	97ba                	add	a5,a5,a4
    8002309a:	639c                	ld	a5,0(a5)
    8002309c:	cf95                	beqz	a5,800230d8 <syscall+0x7a>
    p->trapframe->a0 = syscalls[num]();
    8002309e:	9782                	jalr	a5
    800230a0:	06a9b823          	sd	a0,112(s3)
    if ((p->tmask & (1 << num)) != 0) {
    800230a4:	1704a783          	lw	a5,368(s1)
    800230a8:	4127d7bb          	sraw	a5,a5,s2
    800230ac:	8b85                	andi	a5,a5,1
    800230ae:	c7a1                	beqz	a5,800230f6 <syscall+0x98>
      printf("pid %d: %s -> %d\n", p->pid, sysnames[num], p->trapframe->a0);
    800230b0:	70b8                	ld	a4,96(s1)
    800230b2:	090e                	slli	s2,s2,0x3
    800230b4:	00008797          	auipc	a5,0x8
    800230b8:	7dc78793          	addi	a5,a5,2012 # 8002b890 <sysnames>
    800230bc:	993e                	add	s2,s2,a5
    800230be:	7b34                	ld	a3,112(a4)
    800230c0:	00093603          	ld	a2,0(s2)
    800230c4:	5c8c                	lw	a1,56(s1)
    800230c6:	0000a517          	auipc	a0,0xa
    800230ca:	85250513          	addi	a0,a0,-1966 # 8002c918 <syscalls+0x860>
    800230ce:	ffffd097          	auipc	ra,0xffffd
    800230d2:	0c2080e7          	jalr	194(ra) # 80020190 <printf>
    800230d6:	a005                	j	800230f6 <syscall+0x98>
    printf("pid %d %s: unknown sys call %d\n",
    800230d8:	86ca                	mv	a3,s2
    800230da:	16048613          	addi	a2,s1,352
    800230de:	5c8c                	lw	a1,56(s1)
    800230e0:	0000a517          	auipc	a0,0xa
    800230e4:	85050513          	addi	a0,a0,-1968 # 8002c930 <syscalls+0x878>
    800230e8:	ffffd097          	auipc	ra,0xffffd
    800230ec:	0a8080e7          	jalr	168(ra) # 80020190 <printf>
    p->trapframe->a0 = -1;
    800230f0:	70bc                	ld	a5,96(s1)
    800230f2:	577d                	li	a4,-1
    800230f4:	fbb8                	sd	a4,112(a5)
}
    800230f6:	70a2                	ld	ra,40(sp)
    800230f8:	7402                	ld	s0,32(sp)
    800230fa:	64e2                	ld	s1,24(sp)
    800230fc:	6942                	ld	s2,16(sp)
    800230fe:	69a2                	ld	s3,8(sp)
    80023100:	6145                	addi	sp,sp,48
    80023102:	8082                	ret

0000000080023104 <sys_exec>:

extern int exec(char *path, char **argv);

uint64
sys_exec(void)
{
    80023104:	da010113          	addi	sp,sp,-608
    80023108:	24113c23          	sd	ra,600(sp)
    8002310c:	24813823          	sd	s0,592(sp)
    80023110:	24913423          	sd	s1,584(sp)
    80023114:	25213023          	sd	s2,576(sp)
    80023118:	23313c23          	sd	s3,568(sp)
    8002311c:	23413823          	sd	s4,560(sp)
    80023120:	23513423          	sd	s5,552(sp)
    80023124:	1480                	addi	s0,sp,608
  char path[FAT32_MAX_PATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argaddr(1, &uargv) < 0){
    80023126:	10400613          	li	a2,260
    8002312a:	eb840593          	addi	a1,s0,-328
    8002312e:	4501                	li	a0,0
    80023130:	00000097          	auipc	ra,0x0
    80023134:	efe080e7          	jalr	-258(ra) # 8002302e <argstr>
    return -1;
    80023138:	597d                	li	s2,-1
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argaddr(1, &uargv) < 0){
    8002313a:	0e054c63          	bltz	a0,80023232 <sys_exec+0x12e>
    8002313e:	db040593          	addi	a1,s0,-592
    80023142:	4505                	li	a0,1
    80023144:	00000097          	auipc	ra,0x0
    80023148:	ec8080e7          	jalr	-312(ra) # 8002300c <argaddr>
    8002314c:	0e054363          	bltz	a0,80023232 <sys_exec+0x12e>
  }
  memset(argv, 0, sizeof(argv));
    80023150:	db840913          	addi	s2,s0,-584
    80023154:	10000613          	li	a2,256
    80023158:	4581                	li	a1,0
    8002315a:	854a                	mv	a0,s2
    8002315c:	ffffd097          	auipc	ra,0xffffd
    80023160:	600080e7          	jalr	1536(ra) # 8002075c <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80023164:	89ca                	mv	s3,s2
  memset(argv, 0, sizeof(argv));
    80023166:	4481                	li	s1,0
    if(i >= NELEM(argv)){
    80023168:	02000a93          	li	s5,32
    8002316c:	00048a1b          	sext.w	s4,s1
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80023170:	00349513          	slli	a0,s1,0x3
    80023174:	da840593          	addi	a1,s0,-600
    80023178:	db043783          	ld	a5,-592(s0)
    8002317c:	953e                	add	a0,a0,a5
    8002317e:	00000097          	auipc	ra,0x0
    80023182:	dac080e7          	jalr	-596(ra) # 80022f2a <fetchaddr>
    80023186:	02054a63          	bltz	a0,800231ba <sys_exec+0xb6>
      goto bad;
    }
    if(uarg == 0){
    8002318a:	da843783          	ld	a5,-600(s0)
    8002318e:	cfa9                	beqz	a5,800231e8 <sys_exec+0xe4>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80023190:	ffffd097          	auipc	ra,0xffffd
    80023194:	3c2080e7          	jalr	962(ra) # 80020552 <kalloc>
    80023198:	00a93023          	sd	a0,0(s2)
    if(argv[i] == 0)
    8002319c:	cd19                	beqz	a0,800231ba <sys_exec+0xb6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8002319e:	6605                	lui	a2,0x1
    800231a0:	85aa                	mv	a1,a0
    800231a2:	da843503          	ld	a0,-600(s0)
    800231a6:	00000097          	auipc	ra,0x0
    800231aa:	dd4080e7          	jalr	-556(ra) # 80022f7a <fetchstr>
    800231ae:	00054663          	bltz	a0,800231ba <sys_exec+0xb6>
    if(i >= NELEM(argv)){
    800231b2:	0485                	addi	s1,s1,1
    800231b4:	0921                	addi	s2,s2,8
    800231b6:	fb549be3          	bne	s1,s5,8002316c <sys_exec+0x68>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800231ba:	db843503          	ld	a0,-584(s0)
    kfree(argv[i]);
  return -1;
    800231be:	597d                	li	s2,-1
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800231c0:	c92d                	beqz	a0,80023232 <sys_exec+0x12e>
    kfree(argv[i]);
    800231c2:	ffffd097          	auipc	ra,0xffffd
    800231c6:	276080e7          	jalr	630(ra) # 80020438 <kfree>
    800231ca:	dc040493          	addi	s1,s0,-576
    800231ce:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800231d2:	6088                	ld	a0,0(s1)
    800231d4:	cd31                	beqz	a0,80023230 <sys_exec+0x12c>
    kfree(argv[i]);
    800231d6:	ffffd097          	auipc	ra,0xffffd
    800231da:	262080e7          	jalr	610(ra) # 80020438 <kfree>
    800231de:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800231e0:	ff3499e3          	bne	s1,s3,800231d2 <sys_exec+0xce>
  return -1;
    800231e4:	597d                	li	s2,-1
    800231e6:	a0b1                	j	80023232 <sys_exec+0x12e>
      argv[i] = 0;
    800231e8:	0a0e                	slli	s4,s4,0x3
    800231ea:	fc040793          	addi	a5,s0,-64
    800231ee:	9a3e                	add	s4,s4,a5
    800231f0:	de0a3c23          	sd	zero,-520(s4)
  int ret = exec(path, argv);
    800231f4:	db840593          	addi	a1,s0,-584
    800231f8:	eb840513          	addi	a0,s0,-328
    800231fc:	00001097          	auipc	ra,0x1
    80023200:	f86080e7          	jalr	-122(ra) # 80024182 <exec>
    80023204:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80023206:	db843503          	ld	a0,-584(s0)
    8002320a:	c505                	beqz	a0,80023232 <sys_exec+0x12e>
    kfree(argv[i]);
    8002320c:	ffffd097          	auipc	ra,0xffffd
    80023210:	22c080e7          	jalr	556(ra) # 80020438 <kfree>
    80023214:	dc040493          	addi	s1,s0,-576
    80023218:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002321c:	6088                	ld	a0,0(s1)
    8002321e:	c911                	beqz	a0,80023232 <sys_exec+0x12e>
    kfree(argv[i]);
    80023220:	ffffd097          	auipc	ra,0xffffd
    80023224:	218080e7          	jalr	536(ra) # 80020438 <kfree>
    80023228:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002322a:	ff3499e3          	bne	s1,s3,8002321c <sys_exec+0x118>
    8002322e:	a011                	j	80023232 <sys_exec+0x12e>
  return -1;
    80023230:	597d                	li	s2,-1
}
    80023232:	854a                	mv	a0,s2
    80023234:	25813083          	ld	ra,600(sp)
    80023238:	25013403          	ld	s0,592(sp)
    8002323c:	24813483          	ld	s1,584(sp)
    80023240:	24013903          	ld	s2,576(sp)
    80023244:	23813983          	ld	s3,568(sp)
    80023248:	23013a03          	ld	s4,560(sp)
    8002324c:	22813a83          	ld	s5,552(sp)
    80023250:	26010113          	addi	sp,sp,608
    80023254:	8082                	ret

0000000080023256 <sys_exit>:

uint64
sys_exit(void)
{
    80023256:	1101                	addi	sp,sp,-32
    80023258:	ec06                	sd	ra,24(sp)
    8002325a:	e822                	sd	s0,16(sp)
    8002325c:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    8002325e:	fec40593          	addi	a1,s0,-20
    80023262:	4501                	li	a0,0
    80023264:	00000097          	auipc	ra,0x0
    80023268:	d46080e7          	jalr	-698(ra) # 80022faa <argint>
    return -1;
    8002326c:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8002326e:	00054963          	bltz	a0,80023280 <sys_exit+0x2a>
  exit(n);
    80023272:	fec42503          	lw	a0,-20(s0)
    80023276:	fffff097          	auipc	ra,0xfffff
    8002327a:	07c080e7          	jalr	124(ra) # 800222f2 <exit>
  return 0;  // not reached
    8002327e:	4781                	li	a5,0
}
    80023280:	853e                	mv	a0,a5
    80023282:	60e2                	ld	ra,24(sp)
    80023284:	6442                	ld	s0,16(sp)
    80023286:	6105                	addi	sp,sp,32
    80023288:	8082                	ret

000000008002328a <sys_getpid>:

uint64
sys_getpid(void)
{
    8002328a:	1141                	addi	sp,sp,-16
    8002328c:	e406                	sd	ra,8(sp)
    8002328e:	e022                	sd	s0,0(sp)
    80023290:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80023292:	fffff097          	auipc	ra,0xfffff
    80023296:	8f0080e7          	jalr	-1808(ra) # 80021b82 <myproc>
}
    8002329a:	5d08                	lw	a0,56(a0)
    8002329c:	60a2                	ld	ra,8(sp)
    8002329e:	6402                	ld	s0,0(sp)
    800232a0:	0141                	addi	sp,sp,16
    800232a2:	8082                	ret

00000000800232a4 <sys_getppid>:

uint64
sys_getppid(void)
{
    800232a4:	1141                	addi	sp,sp,-16
    800232a6:	e406                	sd	ra,8(sp)
    800232a8:	e022                	sd	s0,0(sp)
    800232aa:	0800                	addi	s0,sp,16
  return myproc()->parent->pid;
    800232ac:	fffff097          	auipc	ra,0xfffff
    800232b0:	8d6080e7          	jalr	-1834(ra) # 80021b82 <myproc>
    800232b4:	711c                	ld	a5,32(a0)
}
    800232b6:	5f88                	lw	a0,56(a5)
    800232b8:	60a2                	ld	ra,8(sp)
    800232ba:	6402                	ld	s0,0(sp)
    800232bc:	0141                	addi	sp,sp,16
    800232be:	8082                	ret

00000000800232c0 <sys_fork>:

uint64
sys_fork(void)
{
    800232c0:	1141                	addi	sp,sp,-16
    800232c2:	e406                	sd	ra,8(sp)
    800232c4:	e022                	sd	s0,0(sp)
    800232c6:	0800                	addi	s0,sp,16
  return fork();
    800232c8:	fffff097          	auipc	ra,0xfffff
    800232cc:	de6080e7          	jalr	-538(ra) # 800220ae <fork>
}
    800232d0:	60a2                	ld	ra,8(sp)
    800232d2:	6402                	ld	s0,0(sp)
    800232d4:	0141                	addi	sp,sp,16
    800232d6:	8082                	ret

00000000800232d8 <sys_clone>:
 
uint64
sys_clone(void)
{
    800232d8:	1101                	addi	sp,sp,-32
    800232da:	ec06                	sd	ra,24(sp)
    800232dc:	e822                	sd	s0,16(sp)
    800232de:	1000                	addi	s0,sp,32
  int flag;
  uint64 stack;

  if(argint(0,&flag)<0 || argaddr(1,&stack) <0)
    800232e0:	fec40593          	addi	a1,s0,-20
    800232e4:	4501                	li	a0,0
    800232e6:	00000097          	auipc	ra,0x0
    800232ea:	cc4080e7          	jalr	-828(ra) # 80022faa <argint>
    return -1; 
    800232ee:	57fd                	li	a5,-1
  if(argint(0,&flag)<0 || argaddr(1,&stack) <0)
    800232f0:	02054563          	bltz	a0,8002331a <sys_clone+0x42>
    800232f4:	fe040593          	addi	a1,s0,-32
    800232f8:	4505                	li	a0,1
    800232fa:	00000097          	auipc	ra,0x0
    800232fe:	d12080e7          	jalr	-750(ra) # 8002300c <argaddr>
    return -1; 
    80023302:	57fd                	li	a5,-1
  if(argint(0,&flag)<0 || argaddr(1,&stack) <0)
    80023304:	00054b63          	bltz	a0,8002331a <sys_clone+0x42>

  return clone(flag,stack);
    80023308:	fe043583          	ld	a1,-32(s0)
    8002330c:	fec42503          	lw	a0,-20(s0)
    80023310:	fffff097          	auipc	ra,0xfffff
    80023314:	c80080e7          	jalr	-896(ra) # 80021f90 <clone>
    80023318:	87aa                	mv	a5,a0
}
    8002331a:	853e                	mv	a0,a5
    8002331c:	60e2                	ld	ra,24(sp)
    8002331e:	6442                	ld	s0,16(sp)
    80023320:	6105                	addi	sp,sp,32
    80023322:	8082                	ret

0000000080023324 <sys_wait>:

uint64
sys_wait(void)
{
    80023324:	1101                	addi	sp,sp,-32
    80023326:	ec06                	sd	ra,24(sp)
    80023328:	e822                	sd	s0,16(sp)
    8002332a:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    8002332c:	fe840593          	addi	a1,s0,-24
    80023330:	4501                	li	a0,0
    80023332:	00000097          	auipc	ra,0x0
    80023336:	cda080e7          	jalr	-806(ra) # 8002300c <argaddr>
    return -1;
    8002333a:	57fd                	li	a5,-1
  if(argaddr(0, &p) < 0)
    8002333c:	00054963          	bltz	a0,8002334e <sys_wait+0x2a>
  return wait(p);
    80023340:	fe843503          	ld	a0,-24(s0)
    80023344:	fffff097          	auipc	ra,0xfffff
    80023348:	29c080e7          	jalr	668(ra) # 800225e0 <wait>
    8002334c:	87aa                	mv	a5,a0
}
    8002334e:	853e                	mv	a0,a5
    80023350:	60e2                	ld	ra,24(sp)
    80023352:	6442                	ld	s0,16(sp)
    80023354:	6105                	addi	sp,sp,32
    80023356:	8082                	ret

0000000080023358 <sys_wait4>:

uint64
sys_wait4(void)
{
    80023358:	1101                	addi	sp,sp,-32
    8002335a:	ec06                	sd	ra,24(sp)
    8002335c:	e822                	sd	s0,16(sp)
    8002335e:	1000                	addi	s0,sp,32
  int pid, options;
  uint64 status;
  if(argint(0, &pid) < 0 || argaddr(1, &status)<0 || argint(2,&options)<0)
    80023360:	fec40593          	addi	a1,s0,-20
    80023364:	4501                	li	a0,0
    80023366:	00000097          	auipc	ra,0x0
    8002336a:	c44080e7          	jalr	-956(ra) # 80022faa <argint>
    return -1;
    8002336e:	57fd                	li	a5,-1
  if(argint(0, &pid) < 0 || argaddr(1, &status)<0 || argint(2,&options)<0)
    80023370:	04054163          	bltz	a0,800233b2 <sys_wait4+0x5a>
    80023374:	fe040593          	addi	a1,s0,-32
    80023378:	4505                	li	a0,1
    8002337a:	00000097          	auipc	ra,0x0
    8002337e:	c92080e7          	jalr	-878(ra) # 8002300c <argaddr>
    return -1;
    80023382:	57fd                	li	a5,-1
  if(argint(0, &pid) < 0 || argaddr(1, &status)<0 || argint(2,&options)<0)
    80023384:	02054763          	bltz	a0,800233b2 <sys_wait4+0x5a>
    80023388:	fe840593          	addi	a1,s0,-24
    8002338c:	4509                	li	a0,2
    8002338e:	00000097          	auipc	ra,0x0
    80023392:	c1c080e7          	jalr	-996(ra) # 80022faa <argint>
    return -1;
    80023396:	57fd                	li	a5,-1
  if(argint(0, &pid) < 0 || argaddr(1, &status)<0 || argint(2,&options)<0)
    80023398:	00054d63          	bltz	a0,800233b2 <sys_wait4+0x5a>
   
  return wait4(pid,status,options);
    8002339c:	fe842603          	lw	a2,-24(s0)
    800233a0:	fe043583          	ld	a1,-32(s0)
    800233a4:	fec42503          	lw	a0,-20(s0)
    800233a8:	fffff097          	auipc	ra,0xfffff
    800233ac:	100080e7          	jalr	256(ra) # 800224a8 <wait4>
    800233b0:	87aa                	mv	a5,a0
}
    800233b2:	853e                	mv	a0,a5
    800233b4:	60e2                	ld	ra,24(sp)
    800233b6:	6442                	ld	s0,16(sp)
    800233b8:	6105                	addi	sp,sp,32
    800233ba:	8082                	ret

00000000800233bc <sys_sbrk>:



uint64
sys_sbrk(void)
{
    800233bc:	7179                	addi	sp,sp,-48
    800233be:	f406                	sd	ra,40(sp)
    800233c0:	f022                	sd	s0,32(sp)
    800233c2:	ec26                	sd	s1,24(sp)
    800233c4:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    800233c6:	fdc40593          	addi	a1,s0,-36
    800233ca:	4501                	li	a0,0
    800233cc:	00000097          	auipc	ra,0x0
    800233d0:	bde080e7          	jalr	-1058(ra) # 80022faa <argint>
    return -1;
    800233d4:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    800233d6:	00054f63          	bltz	a0,800233f4 <sys_sbrk+0x38>
  addr = myproc()->sz;
    800233da:	ffffe097          	auipc	ra,0xffffe
    800233de:	7a8080e7          	jalr	1960(ra) # 80021b82 <myproc>
    800233e2:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    800233e4:	fdc42503          	lw	a0,-36(s0)
    800233e8:	fffff097          	auipc	ra,0xfffff
    800233ec:	b28080e7          	jalr	-1240(ra) # 80021f10 <growproc>
    800233f0:	00054863          	bltz	a0,80023400 <sys_sbrk+0x44>
    return -1;
  return addr;
}
    800233f4:	8526                	mv	a0,s1
    800233f6:	70a2                	ld	ra,40(sp)
    800233f8:	7402                	ld	s0,32(sp)
    800233fa:	64e2                	ld	s1,24(sp)
    800233fc:	6145                	addi	sp,sp,48
    800233fe:	8082                	ret
    return -1;
    80023400:	54fd                	li	s1,-1
    80023402:	bfcd                	j	800233f4 <sys_sbrk+0x38>

0000000080023404 <sys_sleep>:

uint64
sys_sleep(void)
{
    80023404:	7139                	addi	sp,sp,-64
    80023406:	fc06                	sd	ra,56(sp)
    80023408:	f822                	sd	s0,48(sp)
    8002340a:	f426                	sd	s1,40(sp)
    8002340c:	f04a                	sd	s2,32(sp)
    8002340e:	ec4e                	sd	s3,24(sp)
    80023410:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80023412:	fcc40593          	addi	a1,s0,-52
    80023416:	4501                	li	a0,0
    80023418:	00000097          	auipc	ra,0x0
    8002341c:	b92080e7          	jalr	-1134(ra) # 80022faa <argint>
    return -1;
    80023420:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80023422:	06054763          	bltz	a0,80023490 <sys_sleep+0x8c>
  acquire(&tickslock);
    80023426:	0001e517          	auipc	a0,0x1e
    8002342a:	fe250513          	addi	a0,a0,-30 # 80041408 <tickslock>
    8002342e:	ffffd097          	auipc	ra,0xffffd
    80023432:	292080e7          	jalr	658(ra) # 800206c0 <acquire>
  ticks0 = ticks;
    80023436:	0001e797          	auipc	a5,0x1e
    8002343a:	fea78793          	addi	a5,a5,-22 # 80041420 <ticks>
    8002343e:	0007a903          	lw	s2,0(a5)
  while(ticks - ticks0 < n){
    80023442:	fcc42783          	lw	a5,-52(s0)
    80023446:	cf85                	beqz	a5,8002347e <sys_sleep+0x7a>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80023448:	0001e997          	auipc	s3,0x1e
    8002344c:	fc098993          	addi	s3,s3,-64 # 80041408 <tickslock>
    80023450:	0001e497          	auipc	s1,0x1e
    80023454:	fd048493          	addi	s1,s1,-48 # 80041420 <ticks>
    if(myproc()->killed){
    80023458:	ffffe097          	auipc	ra,0xffffe
    8002345c:	72a080e7          	jalr	1834(ra) # 80021b82 <myproc>
    80023460:	591c                	lw	a5,48(a0)
    80023462:	ef9d                	bnez	a5,800234a0 <sys_sleep+0x9c>
    sleep(&ticks, &tickslock);
    80023464:	85ce                	mv	a1,s3
    80023466:	8526                	mv	a0,s1
    80023468:	fffff097          	auipc	ra,0xfffff
    8002346c:	fc2080e7          	jalr	-62(ra) # 8002242a <sleep>
  while(ticks - ticks0 < n){
    80023470:	409c                	lw	a5,0(s1)
    80023472:	412787bb          	subw	a5,a5,s2
    80023476:	fcc42703          	lw	a4,-52(s0)
    8002347a:	fce7efe3          	bltu	a5,a4,80023458 <sys_sleep+0x54>
  }
  release(&tickslock);
    8002347e:	0001e517          	auipc	a0,0x1e
    80023482:	f8a50513          	addi	a0,a0,-118 # 80041408 <tickslock>
    80023486:	ffffd097          	auipc	ra,0xffffd
    8002348a:	28e080e7          	jalr	654(ra) # 80020714 <release>
  return 0;
    8002348e:	4781                	li	a5,0
}
    80023490:	853e                	mv	a0,a5
    80023492:	70e2                	ld	ra,56(sp)
    80023494:	7442                	ld	s0,48(sp)
    80023496:	74a2                	ld	s1,40(sp)
    80023498:	7902                	ld	s2,32(sp)
    8002349a:	69e2                	ld	s3,24(sp)
    8002349c:	6121                	addi	sp,sp,64
    8002349e:	8082                	ret
      release(&tickslock);
    800234a0:	0001e517          	auipc	a0,0x1e
    800234a4:	f6850513          	addi	a0,a0,-152 # 80041408 <tickslock>
    800234a8:	ffffd097          	auipc	ra,0xffffd
    800234ac:	26c080e7          	jalr	620(ra) # 80020714 <release>
      return -1;
    800234b0:	57fd                	li	a5,-1
    800234b2:	bff9                	j	80023490 <sys_sleep+0x8c>

00000000800234b4 <sys_kill>:

uint64
sys_kill(void)
{
    800234b4:	1101                	addi	sp,sp,-32
    800234b6:	ec06                	sd	ra,24(sp)
    800234b8:	e822                	sd	s0,16(sp)
    800234ba:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    800234bc:	fec40593          	addi	a1,s0,-20
    800234c0:	4501                	li	a0,0
    800234c2:	00000097          	auipc	ra,0x0
    800234c6:	ae8080e7          	jalr	-1304(ra) # 80022faa <argint>
    return -1;
    800234ca:	57fd                	li	a5,-1
  if(argint(0, &pid) < 0)
    800234cc:	00054963          	bltz	a0,800234de <sys_kill+0x2a>
  return kill(pid);
    800234d0:	fec42503          	lw	a0,-20(s0)
    800234d4:	fffff097          	auipc	ra,0xfffff
    800234d8:	194080e7          	jalr	404(ra) # 80022668 <kill>
    800234dc:	87aa                	mv	a5,a0
}
    800234de:	853e                	mv	a0,a5
    800234e0:	60e2                	ld	ra,24(sp)
    800234e2:	6442                	ld	s0,16(sp)
    800234e4:	6105                	addi	sp,sp,32
    800234e6:	8082                	ret

00000000800234e8 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800234e8:	1101                	addi	sp,sp,-32
    800234ea:	ec06                	sd	ra,24(sp)
    800234ec:	e822                	sd	s0,16(sp)
    800234ee:	e426                	sd	s1,8(sp)
    800234f0:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800234f2:	0001e517          	auipc	a0,0x1e
    800234f6:	f1650513          	addi	a0,a0,-234 # 80041408 <tickslock>
    800234fa:	ffffd097          	auipc	ra,0xffffd
    800234fe:	1c6080e7          	jalr	454(ra) # 800206c0 <acquire>
  xticks = ticks;
    80023502:	0001e797          	auipc	a5,0x1e
    80023506:	f1e78793          	addi	a5,a5,-226 # 80041420 <ticks>
    8002350a:	4384                	lw	s1,0(a5)
  release(&tickslock);
    8002350c:	0001e517          	auipc	a0,0x1e
    80023510:	efc50513          	addi	a0,a0,-260 # 80041408 <tickslock>
    80023514:	ffffd097          	auipc	ra,0xffffd
    80023518:	200080e7          	jalr	512(ra) # 80020714 <release>
  return xticks;
}
    8002351c:	02049513          	slli	a0,s1,0x20
    80023520:	9101                	srli	a0,a0,0x20
    80023522:	60e2                	ld	ra,24(sp)
    80023524:	6442                	ld	s0,16(sp)
    80023526:	64a2                	ld	s1,8(sp)
    80023528:	6105                	addi	sp,sp,32
    8002352a:	8082                	ret

000000008002352c <sys_trace>:

uint64
sys_trace(void)
{
    8002352c:	1101                	addi	sp,sp,-32
    8002352e:	ec06                	sd	ra,24(sp)
    80023530:	e822                	sd	s0,16(sp)
    80023532:	1000                	addi	s0,sp,32
  int mask;
  if(argint(0, &mask) < 0) {
    80023534:	fec40593          	addi	a1,s0,-20
    80023538:	4501                	li	a0,0
    8002353a:	00000097          	auipc	ra,0x0
    8002353e:	a70080e7          	jalr	-1424(ra) # 80022faa <argint>
    return -1;
    80023542:	57fd                	li	a5,-1
  if(argint(0, &mask) < 0) {
    80023544:	00054b63          	bltz	a0,8002355a <sys_trace+0x2e>
  }
  myproc()->tmask = mask;
    80023548:	ffffe097          	auipc	ra,0xffffe
    8002354c:	63a080e7          	jalr	1594(ra) # 80021b82 <myproc>
    80023550:	fec42783          	lw	a5,-20(s0)
    80023554:	16f52823          	sw	a5,368(a0)
  return 0;
    80023558:	4781                	li	a5,0
    8002355a:	853e                	mv	a0,a5
    8002355c:	60e2                	ld	ra,24(sp)
    8002355e:	6442                	ld	s0,16(sp)
    80023560:	6105                	addi	sp,sp,32
    80023562:	8082                	ret

0000000080023564 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80023564:	7139                	addi	sp,sp,-64
    80023566:	fc06                	sd	ra,56(sp)
    80023568:	f822                	sd	s0,48(sp)
    8002356a:	f426                	sd	s1,40(sp)
    8002356c:	f04a                	sd	s2,32(sp)
    8002356e:	ec4e                	sd	s3,24(sp)
    80023570:	e852                	sd	s4,16(sp)
    80023572:	e456                	sd	s5,8(sp)
    80023574:	0080                	addi	s0,sp,64
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80023576:	00009597          	auipc	a1,0x9
    8002357a:	4ba58593          	addi	a1,a1,1210 # 8002ca30 <syscalls+0x978>
    8002357e:	00018517          	auipc	a0,0x18
    80023582:	57250513          	addi	a0,a0,1394 # 8003baf0 <bcache>
    80023586:	ffffd097          	auipc	ra,0xffffd
    8002358a:	0f6080e7          	jalr	246(ra) # 8002067c <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8002358e:	0001c797          	auipc	a5,0x1c
    80023592:	56278793          	addi	a5,a5,1378 # 8003faf0 <bcache+0x4000>
    80023596:	0001d717          	auipc	a4,0x1d
    8002359a:	bc270713          	addi	a4,a4,-1086 # 80040158 <bcache+0x4668>
    8002359e:	6ae7b823          	sd	a4,1712(a5)
  bcache.head.next = &bcache.head;
    800235a2:	6ae7bc23          	sd	a4,1720(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800235a6:	00018497          	auipc	s1,0x18
    800235aa:	56248493          	addi	s1,s1,1378 # 8003bb08 <bcache+0x18>
    b->refcnt = 0;
    b->sectorno = ~0;
    800235ae:	5a7d                	li	s4,-1
    b->dev = ~0;
    b->next = bcache.head.next;
    800235b0:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    800235b2:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    800235b4:	00009a97          	auipc	s5,0x9
    800235b8:	484a8a93          	addi	s5,s5,1156 # 8002ca38 <syscalls+0x980>
    b->refcnt = 0;
    800235bc:	0404a023          	sw	zero,64(s1)
    b->sectorno = ~0;
    800235c0:	0144a623          	sw	s4,12(s1)
    b->dev = ~0;
    800235c4:	0144a423          	sw	s4,8(s1)
    b->next = bcache.head.next;
    800235c8:	6b893783          	ld	a5,1720(s2)
    800235cc:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    800235ce:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    800235d2:	85d6                	mv	a1,s5
    800235d4:	01048513          	addi	a0,s1,16
    800235d8:	00000097          	auipc	ra,0x0
    800235dc:	280080e7          	jalr	640(ra) # 80023858 <initsleeplock>
    bcache.head.next->prev = b;
    800235e0:	6b893783          	ld	a5,1720(s2)
    800235e4:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    800235e6:	6a993c23          	sd	s1,1720(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800235ea:	25848493          	addi	s1,s1,600
    800235ee:	fd3497e3          	bne	s1,s3,800235bc <binit+0x58>
  }
  #ifdef DEBUG
  printf("binit\n");
  #endif
}
    800235f2:	70e2                	ld	ra,56(sp)
    800235f4:	7442                	ld	s0,48(sp)
    800235f6:	74a2                	ld	s1,40(sp)
    800235f8:	7902                	ld	s2,32(sp)
    800235fa:	69e2                	ld	s3,24(sp)
    800235fc:	6a42                	ld	s4,16(sp)
    800235fe:	6aa2                	ld	s5,8(sp)
    80023600:	6121                	addi	sp,sp,64
    80023602:	8082                	ret

0000000080023604 <bread>:
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf* 
bread(uint dev, uint sectorno) {
    80023604:	7179                	addi	sp,sp,-48
    80023606:	f406                	sd	ra,40(sp)
    80023608:	f022                	sd	s0,32(sp)
    8002360a:	ec26                	sd	s1,24(sp)
    8002360c:	e84a                	sd	s2,16(sp)
    8002360e:	e44e                	sd	s3,8(sp)
    80023610:	1800                	addi	s0,sp,48
    80023612:	89aa                	mv	s3,a0
    80023614:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    80023616:	00018517          	auipc	a0,0x18
    8002361a:	4da50513          	addi	a0,a0,1242 # 8003baf0 <bcache>
    8002361e:	ffffd097          	auipc	ra,0xffffd
    80023622:	0a2080e7          	jalr	162(ra) # 800206c0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80023626:	0001c797          	auipc	a5,0x1c
    8002362a:	4ca78793          	addi	a5,a5,1226 # 8003faf0 <bcache+0x4000>
    8002362e:	6b87b483          	ld	s1,1720(a5)
    80023632:	0001d797          	auipc	a5,0x1d
    80023636:	b2678793          	addi	a5,a5,-1242 # 80040158 <bcache+0x4668>
    8002363a:	02f48f63          	beq	s1,a5,80023678 <bread+0x74>
    8002363e:	873e                	mv	a4,a5
    80023640:	a021                	j	80023648 <bread+0x44>
    80023642:	68a4                	ld	s1,80(s1)
    80023644:	02e48a63          	beq	s1,a4,80023678 <bread+0x74>
    if(b->dev == dev && b->sectorno == sectorno){
    80023648:	449c                	lw	a5,8(s1)
    8002364a:	ff379ce3          	bne	a5,s3,80023642 <bread+0x3e>
    8002364e:	44dc                	lw	a5,12(s1)
    80023650:	ff2799e3          	bne	a5,s2,80023642 <bread+0x3e>
      b->refcnt++;
    80023654:	40bc                	lw	a5,64(s1)
    80023656:	2785                	addiw	a5,a5,1
    80023658:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8002365a:	00018517          	auipc	a0,0x18
    8002365e:	49650513          	addi	a0,a0,1174 # 8003baf0 <bcache>
    80023662:	ffffd097          	auipc	ra,0xffffd
    80023666:	0b2080e7          	jalr	178(ra) # 80020714 <release>
      acquiresleep(&b->lock);
    8002366a:	01048513          	addi	a0,s1,16
    8002366e:	00000097          	auipc	ra,0x0
    80023672:	224080e7          	jalr	548(ra) # 80023892 <acquiresleep>
      return b;
    80023676:	a8b1                	j	800236d2 <bread+0xce>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80023678:	0001c797          	auipc	a5,0x1c
    8002367c:	47878793          	addi	a5,a5,1144 # 8003faf0 <bcache+0x4000>
    80023680:	6b07b483          	ld	s1,1712(a5)
    80023684:	0001d797          	auipc	a5,0x1d
    80023688:	ad478793          	addi	a5,a5,-1324 # 80040158 <bcache+0x4668>
    8002368c:	04f48d63          	beq	s1,a5,800236e6 <bread+0xe2>
    if(b->refcnt == 0) {
    80023690:	40bc                	lw	a5,64(s1)
    80023692:	cb91                	beqz	a5,800236a6 <bread+0xa2>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80023694:	0001d717          	auipc	a4,0x1d
    80023698:	ac470713          	addi	a4,a4,-1340 # 80040158 <bcache+0x4668>
    8002369c:	64a4                	ld	s1,72(s1)
    8002369e:	04e48463          	beq	s1,a4,800236e6 <bread+0xe2>
    if(b->refcnt == 0) {
    800236a2:	40bc                	lw	a5,64(s1)
    800236a4:	ffe5                	bnez	a5,8002369c <bread+0x98>
      b->dev = dev;
    800236a6:	0134a423          	sw	s3,8(s1)
      b->sectorno = sectorno;
    800236aa:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    800236ae:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800236b2:	4785                	li	a5,1
    800236b4:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800236b6:	00018517          	auipc	a0,0x18
    800236ba:	43a50513          	addi	a0,a0,1082 # 8003baf0 <bcache>
    800236be:	ffffd097          	auipc	ra,0xffffd
    800236c2:	056080e7          	jalr	86(ra) # 80020714 <release>
      acquiresleep(&b->lock);
    800236c6:	01048513          	addi	a0,s1,16
    800236ca:	00000097          	auipc	ra,0x0
    800236ce:	1c8080e7          	jalr	456(ra) # 80023892 <acquiresleep>
  struct buf *b;

  b = bget(dev, sectorno);
  if (!b->valid) {
    800236d2:	409c                	lw	a5,0(s1)
    800236d4:	c38d                	beqz	a5,800236f6 <bread+0xf2>
    disk_read(b);
    b->valid = 1;
  }

  return b;
}
    800236d6:	8526                	mv	a0,s1
    800236d8:	70a2                	ld	ra,40(sp)
    800236da:	7402                	ld	s0,32(sp)
    800236dc:	64e2                	ld	s1,24(sp)
    800236de:	6942                	ld	s2,16(sp)
    800236e0:	69a2                	ld	s3,8(sp)
    800236e2:	6145                	addi	sp,sp,48
    800236e4:	8082                	ret
  panic("bget: no buffers");
    800236e6:	00009517          	auipc	a0,0x9
    800236ea:	35a50513          	addi	a0,a0,858 # 8002ca40 <syscalls+0x988>
    800236ee:	ffffd097          	auipc	ra,0xffffd
    800236f2:	a58080e7          	jalr	-1448(ra) # 80020146 <panic>
    disk_read(b);
    800236f6:	8526                	mv	a0,s1
    800236f8:	00002097          	auipc	ra,0x2
    800236fc:	bca080e7          	jalr	-1078(ra) # 800252c2 <disk_read>
    b->valid = 1;
    80023700:	4785                	li	a5,1
    80023702:	c09c                	sw	a5,0(s1)
  return b;
    80023704:	bfc9                	j	800236d6 <bread+0xd2>

0000000080023706 <bwrite>:

// Write b's contents to disk.  Must be locked.
void 
bwrite(struct buf *b) {
    80023706:	1101                	addi	sp,sp,-32
    80023708:	ec06                	sd	ra,24(sp)
    8002370a:	e822                	sd	s0,16(sp)
    8002370c:	e426                	sd	s1,8(sp)
    8002370e:	1000                	addi	s0,sp,32
    80023710:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80023712:	0541                	addi	a0,a0,16
    80023714:	00000097          	auipc	ra,0x0
    80023718:	218080e7          	jalr	536(ra) # 8002392c <holdingsleep>
    8002371c:	c919                	beqz	a0,80023732 <bwrite+0x2c>
    panic("bwrite");
  disk_write(b);
    8002371e:	8526                	mv	a0,s1
    80023720:	00002097          	auipc	ra,0x2
    80023724:	bc0080e7          	jalr	-1088(ra) # 800252e0 <disk_write>
}
    80023728:	60e2                	ld	ra,24(sp)
    8002372a:	6442                	ld	s0,16(sp)
    8002372c:	64a2                	ld	s1,8(sp)
    8002372e:	6105                	addi	sp,sp,32
    80023730:	8082                	ret
    panic("bwrite");
    80023732:	00009517          	auipc	a0,0x9
    80023736:	32650513          	addi	a0,a0,806 # 8002ca58 <syscalls+0x9a0>
    8002373a:	ffffd097          	auipc	ra,0xffffd
    8002373e:	a0c080e7          	jalr	-1524(ra) # 80020146 <panic>

0000000080023742 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80023742:	1101                	addi	sp,sp,-32
    80023744:	ec06                	sd	ra,24(sp)
    80023746:	e822                	sd	s0,16(sp)
    80023748:	e426                	sd	s1,8(sp)
    8002374a:	e04a                	sd	s2,0(sp)
    8002374c:	1000                	addi	s0,sp,32
    8002374e:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80023750:	01050913          	addi	s2,a0,16
    80023754:	854a                	mv	a0,s2
    80023756:	00000097          	auipc	ra,0x0
    8002375a:	1d6080e7          	jalr	470(ra) # 8002392c <holdingsleep>
    8002375e:	c92d                	beqz	a0,800237d0 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80023760:	854a                	mv	a0,s2
    80023762:	00000097          	auipc	ra,0x0
    80023766:	186080e7          	jalr	390(ra) # 800238e8 <releasesleep>

  acquire(&bcache.lock);
    8002376a:	00018517          	auipc	a0,0x18
    8002376e:	38650513          	addi	a0,a0,902 # 8003baf0 <bcache>
    80023772:	ffffd097          	auipc	ra,0xffffd
    80023776:	f4e080e7          	jalr	-178(ra) # 800206c0 <acquire>
  b->refcnt--;
    8002377a:	40bc                	lw	a5,64(s1)
    8002377c:	37fd                	addiw	a5,a5,-1
    8002377e:	0007871b          	sext.w	a4,a5
    80023782:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80023784:	eb05                	bnez	a4,800237b4 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80023786:	68bc                	ld	a5,80(s1)
    80023788:	64b8                	ld	a4,72(s1)
    8002378a:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8002378c:	64bc                	ld	a5,72(s1)
    8002378e:	68b8                	ld	a4,80(s1)
    80023790:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80023792:	0001c797          	auipc	a5,0x1c
    80023796:	35e78793          	addi	a5,a5,862 # 8003faf0 <bcache+0x4000>
    8002379a:	6b87b703          	ld	a4,1720(a5)
    8002379e:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800237a0:	0001d717          	auipc	a4,0x1d
    800237a4:	9b870713          	addi	a4,a4,-1608 # 80040158 <bcache+0x4668>
    800237a8:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800237aa:	6b87b703          	ld	a4,1720(a5)
    800237ae:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800237b0:	6a97bc23          	sd	s1,1720(a5)
  }
  
  release(&bcache.lock);
    800237b4:	00018517          	auipc	a0,0x18
    800237b8:	33c50513          	addi	a0,a0,828 # 8003baf0 <bcache>
    800237bc:	ffffd097          	auipc	ra,0xffffd
    800237c0:	f58080e7          	jalr	-168(ra) # 80020714 <release>
}
    800237c4:	60e2                	ld	ra,24(sp)
    800237c6:	6442                	ld	s0,16(sp)
    800237c8:	64a2                	ld	s1,8(sp)
    800237ca:	6902                	ld	s2,0(sp)
    800237cc:	6105                	addi	sp,sp,32
    800237ce:	8082                	ret
    panic("brelse");
    800237d0:	00009517          	auipc	a0,0x9
    800237d4:	29050513          	addi	a0,a0,656 # 8002ca60 <syscalls+0x9a8>
    800237d8:	ffffd097          	auipc	ra,0xffffd
    800237dc:	96e080e7          	jalr	-1682(ra) # 80020146 <panic>

00000000800237e0 <bpin>:

void
bpin(struct buf *b) {
    800237e0:	1101                	addi	sp,sp,-32
    800237e2:	ec06                	sd	ra,24(sp)
    800237e4:	e822                	sd	s0,16(sp)
    800237e6:	e426                	sd	s1,8(sp)
    800237e8:	1000                	addi	s0,sp,32
    800237ea:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800237ec:	00018517          	auipc	a0,0x18
    800237f0:	30450513          	addi	a0,a0,772 # 8003baf0 <bcache>
    800237f4:	ffffd097          	auipc	ra,0xffffd
    800237f8:	ecc080e7          	jalr	-308(ra) # 800206c0 <acquire>
  b->refcnt++;
    800237fc:	40bc                	lw	a5,64(s1)
    800237fe:	2785                	addiw	a5,a5,1
    80023800:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80023802:	00018517          	auipc	a0,0x18
    80023806:	2ee50513          	addi	a0,a0,750 # 8003baf0 <bcache>
    8002380a:	ffffd097          	auipc	ra,0xffffd
    8002380e:	f0a080e7          	jalr	-246(ra) # 80020714 <release>
}
    80023812:	60e2                	ld	ra,24(sp)
    80023814:	6442                	ld	s0,16(sp)
    80023816:	64a2                	ld	s1,8(sp)
    80023818:	6105                	addi	sp,sp,32
    8002381a:	8082                	ret

000000008002381c <bunpin>:

void
bunpin(struct buf *b) {
    8002381c:	1101                	addi	sp,sp,-32
    8002381e:	ec06                	sd	ra,24(sp)
    80023820:	e822                	sd	s0,16(sp)
    80023822:	e426                	sd	s1,8(sp)
    80023824:	1000                	addi	s0,sp,32
    80023826:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80023828:	00018517          	auipc	a0,0x18
    8002382c:	2c850513          	addi	a0,a0,712 # 8003baf0 <bcache>
    80023830:	ffffd097          	auipc	ra,0xffffd
    80023834:	e90080e7          	jalr	-368(ra) # 800206c0 <acquire>
  b->refcnt--;
    80023838:	40bc                	lw	a5,64(s1)
    8002383a:	37fd                	addiw	a5,a5,-1
    8002383c:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8002383e:	00018517          	auipc	a0,0x18
    80023842:	2b250513          	addi	a0,a0,690 # 8003baf0 <bcache>
    80023846:	ffffd097          	auipc	ra,0xffffd
    8002384a:	ece080e7          	jalr	-306(ra) # 80020714 <release>
}
    8002384e:	60e2                	ld	ra,24(sp)
    80023850:	6442                	ld	s0,16(sp)
    80023852:	64a2                	ld	s1,8(sp)
    80023854:	6105                	addi	sp,sp,32
    80023856:	8082                	ret

0000000080023858 <initsleeplock>:
#include "include/proc.h"
#include "include/sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80023858:	1101                	addi	sp,sp,-32
    8002385a:	ec06                	sd	ra,24(sp)
    8002385c:	e822                	sd	s0,16(sp)
    8002385e:	e426                	sd	s1,8(sp)
    80023860:	e04a                	sd	s2,0(sp)
    80023862:	1000                	addi	s0,sp,32
    80023864:	84aa                	mv	s1,a0
    80023866:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80023868:	00009597          	auipc	a1,0x9
    8002386c:	20058593          	addi	a1,a1,512 # 8002ca68 <syscalls+0x9b0>
    80023870:	0521                	addi	a0,a0,8
    80023872:	ffffd097          	auipc	ra,0xffffd
    80023876:	e0a080e7          	jalr	-502(ra) # 8002067c <initlock>
  lk->name = name;
    8002387a:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8002387e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80023882:	0204a423          	sw	zero,40(s1)
}
    80023886:	60e2                	ld	ra,24(sp)
    80023888:	6442                	ld	s0,16(sp)
    8002388a:	64a2                	ld	s1,8(sp)
    8002388c:	6902                	ld	s2,0(sp)
    8002388e:	6105                	addi	sp,sp,32
    80023890:	8082                	ret

0000000080023892 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80023892:	1101                	addi	sp,sp,-32
    80023894:	ec06                	sd	ra,24(sp)
    80023896:	e822                	sd	s0,16(sp)
    80023898:	e426                	sd	s1,8(sp)
    8002389a:	e04a                	sd	s2,0(sp)
    8002389c:	1000                	addi	s0,sp,32
    8002389e:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800238a0:	00850913          	addi	s2,a0,8
    800238a4:	854a                	mv	a0,s2
    800238a6:	ffffd097          	auipc	ra,0xffffd
    800238aa:	e1a080e7          	jalr	-486(ra) # 800206c0 <acquire>
  while (lk->locked) {
    800238ae:	409c                	lw	a5,0(s1)
    800238b0:	cb89                	beqz	a5,800238c2 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    800238b2:	85ca                	mv	a1,s2
    800238b4:	8526                	mv	a0,s1
    800238b6:	fffff097          	auipc	ra,0xfffff
    800238ba:	b74080e7          	jalr	-1164(ra) # 8002242a <sleep>
  while (lk->locked) {
    800238be:	409c                	lw	a5,0(s1)
    800238c0:	fbed                	bnez	a5,800238b2 <acquiresleep+0x20>
  }
  lk->locked = 1;
    800238c2:	4785                	li	a5,1
    800238c4:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800238c6:	ffffe097          	auipc	ra,0xffffe
    800238ca:	2bc080e7          	jalr	700(ra) # 80021b82 <myproc>
    800238ce:	5d1c                	lw	a5,56(a0)
    800238d0:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800238d2:	854a                	mv	a0,s2
    800238d4:	ffffd097          	auipc	ra,0xffffd
    800238d8:	e40080e7          	jalr	-448(ra) # 80020714 <release>
}
    800238dc:	60e2                	ld	ra,24(sp)
    800238de:	6442                	ld	s0,16(sp)
    800238e0:	64a2                	ld	s1,8(sp)
    800238e2:	6902                	ld	s2,0(sp)
    800238e4:	6105                	addi	sp,sp,32
    800238e6:	8082                	ret

00000000800238e8 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800238e8:	1101                	addi	sp,sp,-32
    800238ea:	ec06                	sd	ra,24(sp)
    800238ec:	e822                	sd	s0,16(sp)
    800238ee:	e426                	sd	s1,8(sp)
    800238f0:	e04a                	sd	s2,0(sp)
    800238f2:	1000                	addi	s0,sp,32
    800238f4:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800238f6:	00850913          	addi	s2,a0,8
    800238fa:	854a                	mv	a0,s2
    800238fc:	ffffd097          	auipc	ra,0xffffd
    80023900:	dc4080e7          	jalr	-572(ra) # 800206c0 <acquire>
  lk->locked = 0;
    80023904:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80023908:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    8002390c:	8526                	mv	a0,s1
    8002390e:	fffff097          	auipc	ra,0xfffff
    80023912:	cf0080e7          	jalr	-784(ra) # 800225fe <wakeup>
  release(&lk->lk);
    80023916:	854a                	mv	a0,s2
    80023918:	ffffd097          	auipc	ra,0xffffd
    8002391c:	dfc080e7          	jalr	-516(ra) # 80020714 <release>
}
    80023920:	60e2                	ld	ra,24(sp)
    80023922:	6442                	ld	s0,16(sp)
    80023924:	64a2                	ld	s1,8(sp)
    80023926:	6902                	ld	s2,0(sp)
    80023928:	6105                	addi	sp,sp,32
    8002392a:	8082                	ret

000000008002392c <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    8002392c:	7179                	addi	sp,sp,-48
    8002392e:	f406                	sd	ra,40(sp)
    80023930:	f022                	sd	s0,32(sp)
    80023932:	ec26                	sd	s1,24(sp)
    80023934:	e84a                	sd	s2,16(sp)
    80023936:	e44e                	sd	s3,8(sp)
    80023938:	1800                	addi	s0,sp,48
    8002393a:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    8002393c:	00850913          	addi	s2,a0,8
    80023940:	854a                	mv	a0,s2
    80023942:	ffffd097          	auipc	ra,0xffffd
    80023946:	d7e080e7          	jalr	-642(ra) # 800206c0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    8002394a:	409c                	lw	a5,0(s1)
    8002394c:	ef99                	bnez	a5,8002396a <holdingsleep+0x3e>
    8002394e:	4481                	li	s1,0
  release(&lk->lk);
    80023950:	854a                	mv	a0,s2
    80023952:	ffffd097          	auipc	ra,0xffffd
    80023956:	dc2080e7          	jalr	-574(ra) # 80020714 <release>
  return r;
}
    8002395a:	8526                	mv	a0,s1
    8002395c:	70a2                	ld	ra,40(sp)
    8002395e:	7402                	ld	s0,32(sp)
    80023960:	64e2                	ld	s1,24(sp)
    80023962:	6942                	ld	s2,16(sp)
    80023964:	69a2                	ld	s3,8(sp)
    80023966:	6145                	addi	sp,sp,48
    80023968:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    8002396a:	0284a983          	lw	s3,40(s1)
    8002396e:	ffffe097          	auipc	ra,0xffffe
    80023972:	214080e7          	jalr	532(ra) # 80021b82 <myproc>
    80023976:	5d04                	lw	s1,56(a0)
    80023978:	413484b3          	sub	s1,s1,s3
    8002397c:	0014b493          	seqz	s1,s1
    80023980:	bfc1                	j	80023950 <holdingsleep+0x24>

0000000080023982 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80023982:	1101                	addi	sp,sp,-32
    80023984:	ec06                	sd	ra,24(sp)
    80023986:	e822                	sd	s0,16(sp)
    80023988:	e426                	sd	s1,8(sp)
    8002398a:	e04a                	sd	s2,0(sp)
    8002398c:	1000                	addi	s0,sp,32
  initlock(&ftable.lock, "ftable");
    8002398e:	00009597          	auipc	a1,0x9
    80023992:	0ea58593          	addi	a1,a1,234 # 8002ca78 <syscalls+0x9c0>
    80023996:	0001d517          	auipc	a0,0x1d
    8002399a:	aba50513          	addi	a0,a0,-1350 # 80040450 <ftable>
    8002399e:	ffffd097          	auipc	ra,0xffffd
    800239a2:	cde080e7          	jalr	-802(ra) # 8002067c <initlock>
  struct file *f;
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800239a6:	0001d497          	auipc	s1,0x1d
    800239aa:	ac248493          	addi	s1,s1,-1342 # 80040468 <ftable+0x18>
    800239ae:	0001e917          	auipc	s2,0x1e
    800239b2:	a5a90913          	addi	s2,s2,-1446 # 80041408 <tickslock>
    memset(f, 0, sizeof(struct file));
    800239b6:	02800613          	li	a2,40
    800239ba:	4581                	li	a1,0
    800239bc:	8526                	mv	a0,s1
    800239be:	ffffd097          	auipc	ra,0xffffd
    800239c2:	d9e080e7          	jalr	-610(ra) # 8002075c <memset>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800239c6:	02848493          	addi	s1,s1,40
    800239ca:	ff2496e3          	bne	s1,s2,800239b6 <fileinit+0x34>
  }
  #ifdef DEBUG
  printf("fileinit\n");
  #endif
}
    800239ce:	60e2                	ld	ra,24(sp)
    800239d0:	6442                	ld	s0,16(sp)
    800239d2:	64a2                	ld	s1,8(sp)
    800239d4:	6902                	ld	s2,0(sp)
    800239d6:	6105                	addi	sp,sp,32
    800239d8:	8082                	ret

00000000800239da <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800239da:	1101                	addi	sp,sp,-32
    800239dc:	ec06                	sd	ra,24(sp)
    800239de:	e822                	sd	s0,16(sp)
    800239e0:	e426                	sd	s1,8(sp)
    800239e2:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800239e4:	0001d517          	auipc	a0,0x1d
    800239e8:	a6c50513          	addi	a0,a0,-1428 # 80040450 <ftable>
    800239ec:	ffffd097          	auipc	ra,0xffffd
    800239f0:	cd4080e7          	jalr	-812(ra) # 800206c0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
    800239f4:	0001d797          	auipc	a5,0x1d
    800239f8:	a5c78793          	addi	a5,a5,-1444 # 80040450 <ftable>
    800239fc:	4fdc                	lw	a5,28(a5)
    800239fe:	cb8d                	beqz	a5,80023a30 <filealloc+0x56>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80023a00:	0001d497          	auipc	s1,0x1d
    80023a04:	a9048493          	addi	s1,s1,-1392 # 80040490 <ftable+0x40>
    80023a08:	0001e717          	auipc	a4,0x1e
    80023a0c:	a0070713          	addi	a4,a4,-1536 # 80041408 <tickslock>
    if(f->ref == 0){
    80023a10:	40dc                	lw	a5,4(s1)
    80023a12:	c39d                	beqz	a5,80023a38 <filealloc+0x5e>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80023a14:	02848493          	addi	s1,s1,40
    80023a18:	fee49ce3          	bne	s1,a4,80023a10 <filealloc+0x36>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80023a1c:	0001d517          	auipc	a0,0x1d
    80023a20:	a3450513          	addi	a0,a0,-1484 # 80040450 <ftable>
    80023a24:	ffffd097          	auipc	ra,0xffffd
    80023a28:	cf0080e7          	jalr	-784(ra) # 80020714 <release>
  return NULL;
    80023a2c:	4481                	li	s1,0
    80023a2e:	a839                	j	80023a4c <filealloc+0x72>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80023a30:	0001d497          	auipc	s1,0x1d
    80023a34:	a3848493          	addi	s1,s1,-1480 # 80040468 <ftable+0x18>
      f->ref = 1;
    80023a38:	4785                	li	a5,1
    80023a3a:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80023a3c:	0001d517          	auipc	a0,0x1d
    80023a40:	a1450513          	addi	a0,a0,-1516 # 80040450 <ftable>
    80023a44:	ffffd097          	auipc	ra,0xffffd
    80023a48:	cd0080e7          	jalr	-816(ra) # 80020714 <release>
}
    80023a4c:	8526                	mv	a0,s1
    80023a4e:	60e2                	ld	ra,24(sp)
    80023a50:	6442                	ld	s0,16(sp)
    80023a52:	64a2                	ld	s1,8(sp)
    80023a54:	6105                	addi	sp,sp,32
    80023a56:	8082                	ret

0000000080023a58 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80023a58:	1101                	addi	sp,sp,-32
    80023a5a:	ec06                	sd	ra,24(sp)
    80023a5c:	e822                	sd	s0,16(sp)
    80023a5e:	e426                	sd	s1,8(sp)
    80023a60:	1000                	addi	s0,sp,32
    80023a62:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80023a64:	0001d517          	auipc	a0,0x1d
    80023a68:	9ec50513          	addi	a0,a0,-1556 # 80040450 <ftable>
    80023a6c:	ffffd097          	auipc	ra,0xffffd
    80023a70:	c54080e7          	jalr	-940(ra) # 800206c0 <acquire>
  if(f->ref < 1)
    80023a74:	40dc                	lw	a5,4(s1)
    80023a76:	02f05263          	blez	a5,80023a9a <filedup+0x42>
    panic("filedup");
  f->ref++;
    80023a7a:	2785                	addiw	a5,a5,1
    80023a7c:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80023a7e:	0001d517          	auipc	a0,0x1d
    80023a82:	9d250513          	addi	a0,a0,-1582 # 80040450 <ftable>
    80023a86:	ffffd097          	auipc	ra,0xffffd
    80023a8a:	c8e080e7          	jalr	-882(ra) # 80020714 <release>
  return f;
}
    80023a8e:	8526                	mv	a0,s1
    80023a90:	60e2                	ld	ra,24(sp)
    80023a92:	6442                	ld	s0,16(sp)
    80023a94:	64a2                	ld	s1,8(sp)
    80023a96:	6105                	addi	sp,sp,32
    80023a98:	8082                	ret
    panic("filedup");
    80023a9a:	00009517          	auipc	a0,0x9
    80023a9e:	fe650513          	addi	a0,a0,-26 # 8002ca80 <syscalls+0x9c8>
    80023aa2:	ffffc097          	auipc	ra,0xffffc
    80023aa6:	6a4080e7          	jalr	1700(ra) # 80020146 <panic>

0000000080023aaa <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80023aaa:	7139                	addi	sp,sp,-64
    80023aac:	fc06                	sd	ra,56(sp)
    80023aae:	f822                	sd	s0,48(sp)
    80023ab0:	f426                	sd	s1,40(sp)
    80023ab2:	f04a                	sd	s2,32(sp)
    80023ab4:	ec4e                	sd	s3,24(sp)
    80023ab6:	e852                	sd	s4,16(sp)
    80023ab8:	e456                	sd	s5,8(sp)
    80023aba:	0080                	addi	s0,sp,64
    80023abc:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80023abe:	0001d517          	auipc	a0,0x1d
    80023ac2:	99250513          	addi	a0,a0,-1646 # 80040450 <ftable>
    80023ac6:	ffffd097          	auipc	ra,0xffffd
    80023aca:	bfa080e7          	jalr	-1030(ra) # 800206c0 <acquire>
  if(f->ref < 1)
    80023ace:	40dc                	lw	a5,4(s1)
    80023ad0:	04f05863          	blez	a5,80023b20 <fileclose+0x76>
    panic("fileclose");
  if(--f->ref > 0){
    80023ad4:	37fd                	addiw	a5,a5,-1
    80023ad6:	0007871b          	sext.w	a4,a5
    80023ada:	c0dc                	sw	a5,4(s1)
    80023adc:	04e04a63          	bgtz	a4,80023b30 <fileclose+0x86>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80023ae0:	0004a903          	lw	s2,0(s1)
    80023ae4:	0094ca03          	lbu	s4,9(s1)
    80023ae8:	0104b983          	ld	s3,16(s1)
    80023aec:	0184ba83          	ld	s5,24(s1)
  f->ref = 0;
    80023af0:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80023af4:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80023af8:	0001d517          	auipc	a0,0x1d
    80023afc:	95850513          	addi	a0,a0,-1704 # 80040450 <ftable>
    80023b00:	ffffd097          	auipc	ra,0xffffd
    80023b04:	c14080e7          	jalr	-1004(ra) # 80020714 <release>

  if(ff.type == FD_PIPE){
    80023b08:	4785                	li	a5,1
    80023b0a:	04f90463          	beq	s2,a5,80023b52 <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_ENTRY){
    80023b0e:	4789                	li	a5,2
    80023b10:	02f91863          	bne	s2,a5,80023b40 <fileclose+0x96>
    eput(ff.ep);
    80023b14:	8556                	mv	a0,s5
    80023b16:	00003097          	auipc	ra,0x3
    80023b1a:	9da080e7          	jalr	-1574(ra) # 800264f0 <eput>
    80023b1e:	a00d                	j	80023b40 <fileclose+0x96>
    panic("fileclose");
    80023b20:	00009517          	auipc	a0,0x9
    80023b24:	f6850513          	addi	a0,a0,-152 # 8002ca88 <syscalls+0x9d0>
    80023b28:	ffffc097          	auipc	ra,0xffffc
    80023b2c:	61e080e7          	jalr	1566(ra) # 80020146 <panic>
    release(&ftable.lock);
    80023b30:	0001d517          	auipc	a0,0x1d
    80023b34:	92050513          	addi	a0,a0,-1760 # 80040450 <ftable>
    80023b38:	ffffd097          	auipc	ra,0xffffd
    80023b3c:	bdc080e7          	jalr	-1060(ra) # 80020714 <release>
  } else if (ff.type == FD_DEVICE) {

  }
}
    80023b40:	70e2                	ld	ra,56(sp)
    80023b42:	7442                	ld	s0,48(sp)
    80023b44:	74a2                	ld	s1,40(sp)
    80023b46:	7902                	ld	s2,32(sp)
    80023b48:	69e2                	ld	s3,24(sp)
    80023b4a:	6a42                	ld	s4,16(sp)
    80023b4c:	6aa2                	ld	s5,8(sp)
    80023b4e:	6121                	addi	sp,sp,64
    80023b50:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80023b52:	85d2                	mv	a1,s4
    80023b54:	854e                	mv	a0,s3
    80023b56:	00000097          	auipc	ra,0x0
    80023b5a:	396080e7          	jalr	918(ra) # 80023eec <pipeclose>
    80023b5e:	b7cd                	j	80023b40 <fileclose+0x96>

0000000080023b60 <filestat>:
filestat(struct file *f, uint64 addr)
{
  // struct proc *p = myproc();
  struct stat st;
  
  if(f->type == FD_ENTRY){
    80023b60:	4118                	lw	a4,0(a0)
    80023b62:	4789                	li	a5,2
    80023b64:	04f71c63          	bne	a4,a5,80023bbc <filestat+0x5c>
{
    80023b68:	711d                	addi	sp,sp,-96
    80023b6a:	ec86                	sd	ra,88(sp)
    80023b6c:	e8a2                	sd	s0,80(sp)
    80023b6e:	e4a6                	sd	s1,72(sp)
    80023b70:	e0ca                	sd	s2,64(sp)
    80023b72:	1080                	addi	s0,sp,96
    80023b74:	892e                	mv	s2,a1
    80023b76:	84aa                	mv	s1,a0
    elock(f->ep);
    80023b78:	6d08                	ld	a0,24(a0)
    80023b7a:	00003097          	auipc	ra,0x3
    80023b7e:	8f2080e7          	jalr	-1806(ra) # 8002646c <elock>
    estat(f->ep, &st);
    80023b82:	fa840593          	addi	a1,s0,-88
    80023b86:	6c88                	ld	a0,24(s1)
    80023b88:	00003097          	auipc	ra,0x3
    80023b8c:	aa0080e7          	jalr	-1376(ra) # 80026628 <estat>
    eunlock(f->ep);
    80023b90:	6c88                	ld	a0,24(s1)
    80023b92:	00003097          	auipc	ra,0x3
    80023b96:	910080e7          	jalr	-1776(ra) # 800264a2 <eunlock>
    // if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    80023b9a:	03800613          	li	a2,56
    80023b9e:	fa840593          	addi	a1,s0,-88
    80023ba2:	854a                	mv	a0,s2
    80023ba4:	ffffe097          	auipc	ra,0xffffe
    80023ba8:	8e4080e7          	jalr	-1820(ra) # 80021488 <copyout2>
    80023bac:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80023bb0:	60e6                	ld	ra,88(sp)
    80023bb2:	6446                	ld	s0,80(sp)
    80023bb4:	64a6                	ld	s1,72(sp)
    80023bb6:	6906                	ld	s2,64(sp)
    80023bb8:	6125                	addi	sp,sp,96
    80023bba:	8082                	ret
  return -1;
    80023bbc:	557d                	li	a0,-1
}
    80023bbe:	8082                	ret

0000000080023bc0 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80023bc0:	7179                	addi	sp,sp,-48
    80023bc2:	f406                	sd	ra,40(sp)
    80023bc4:	f022                	sd	s0,32(sp)
    80023bc6:	ec26                	sd	s1,24(sp)
    80023bc8:	e84a                	sd	s2,16(sp)
    80023bca:	e44e                	sd	s3,8(sp)
    80023bcc:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80023bce:	00854783          	lbu	a5,8(a0)
    80023bd2:	c3d5                	beqz	a5,80023c76 <fileread+0xb6>
    80023bd4:	89b2                	mv	s3,a2
    80023bd6:	892e                	mv	s2,a1
    80023bd8:	84aa                	mv	s1,a0
    return -1;

  switch (f->type) {
    80023bda:	411c                	lw	a5,0(a0)
    80023bdc:	4709                	li	a4,2
    80023bde:	06e78263          	beq	a5,a4,80023c42 <fileread+0x82>
    80023be2:	470d                	li	a4,3
    80023be4:	02e78b63          	beq	a5,a4,80023c1a <fileread+0x5a>
    80023be8:	4705                	li	a4,1
    80023bea:	00e78a63          	beq	a5,a4,80023bfe <fileread+0x3e>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
            f->off += r;
        eunlock(f->ep);
        break;
    default:
      panic("fileread");
    80023bee:	00009517          	auipc	a0,0x9
    80023bf2:	eaa50513          	addi	a0,a0,-342 # 8002ca98 <syscalls+0x9e0>
    80023bf6:	ffffc097          	auipc	ra,0xffffc
    80023bfa:	550080e7          	jalr	1360(ra) # 80020146 <panic>
        r = piperead(f->pipe, addr, n);
    80023bfe:	6908                	ld	a0,16(a0)
    80023c00:	00000097          	auipc	ra,0x0
    80023c04:	488080e7          	jalr	1160(ra) # 80024088 <piperead>
    80023c08:	892a                	mv	s2,a0
  }

  return r;
}
    80023c0a:	854a                	mv	a0,s2
    80023c0c:	70a2                	ld	ra,40(sp)
    80023c0e:	7402                	ld	s0,32(sp)
    80023c10:	64e2                	ld	s1,24(sp)
    80023c12:	6942                	ld	s2,16(sp)
    80023c14:	69a2                	ld	s3,8(sp)
    80023c16:	6145                	addi	sp,sp,48
    80023c18:	8082                	ret
        if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80023c1a:	02451783          	lh	a5,36(a0)
    80023c1e:	03079693          	slli	a3,a5,0x30
    80023c22:	92c1                	srli	a3,a3,0x30
    80023c24:	4725                	li	a4,9
    80023c26:	04d76a63          	bltu	a4,a3,80023c7a <fileread+0xba>
    80023c2a:	0792                	slli	a5,a5,0x4
    80023c2c:	0001c717          	auipc	a4,0x1c
    80023c30:	78470713          	addi	a4,a4,1924 # 800403b0 <devsw>
    80023c34:	97ba                	add	a5,a5,a4
    80023c36:	639c                	ld	a5,0(a5)
    80023c38:	c3b9                	beqz	a5,80023c7e <fileread+0xbe>
        r = devsw[f->major].read(1, addr, n);
    80023c3a:	4505                	li	a0,1
    80023c3c:	9782                	jalr	a5
    80023c3e:	892a                	mv	s2,a0
        break;
    80023c40:	b7e9                	j	80023c0a <fileread+0x4a>
        elock(f->ep);
    80023c42:	6d08                	ld	a0,24(a0)
    80023c44:	00003097          	auipc	ra,0x3
    80023c48:	828080e7          	jalr	-2008(ra) # 8002646c <elock>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
    80023c4c:	874e                	mv	a4,s3
    80023c4e:	5094                	lw	a3,32(s1)
    80023c50:	864a                	mv	a2,s2
    80023c52:	4585                	li	a1,1
    80023c54:	6c88                	ld	a0,24(s1)
    80023c56:	00002097          	auipc	ra,0x2
    80023c5a:	f48080e7          	jalr	-184(ra) # 80025b9e <eread>
    80023c5e:	892a                	mv	s2,a0
    80023c60:	00a05563          	blez	a0,80023c6a <fileread+0xaa>
            f->off += r;
    80023c64:	509c                	lw	a5,32(s1)
    80023c66:	9fa9                	addw	a5,a5,a0
    80023c68:	d09c                	sw	a5,32(s1)
        eunlock(f->ep);
    80023c6a:	6c88                	ld	a0,24(s1)
    80023c6c:	00003097          	auipc	ra,0x3
    80023c70:	836080e7          	jalr	-1994(ra) # 800264a2 <eunlock>
        break;
    80023c74:	bf59                	j	80023c0a <fileread+0x4a>
    return -1;
    80023c76:	597d                	li	s2,-1
    80023c78:	bf49                	j	80023c0a <fileread+0x4a>
          return -1;
    80023c7a:	597d                	li	s2,-1
    80023c7c:	b779                	j	80023c0a <fileread+0x4a>
    80023c7e:	597d                	li	s2,-1
    80023c80:	b769                	j	80023c0a <fileread+0x4a>

0000000080023c82 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80023c82:	7179                	addi	sp,sp,-48
    80023c84:	f406                	sd	ra,40(sp)
    80023c86:	f022                	sd	s0,32(sp)
    80023c88:	ec26                	sd	s1,24(sp)
    80023c8a:	e84a                	sd	s2,16(sp)
    80023c8c:	e44e                	sd	s3,8(sp)
    80023c8e:	e052                	sd	s4,0(sp)
    80023c90:	1800                	addi	s0,sp,48
  int ret = 0;

  if(f->writable == 0)
    80023c92:	00954783          	lbu	a5,9(a0)
    80023c96:	cbcd                	beqz	a5,80023d48 <filewrite+0xc6>
    80023c98:	8932                	mv	s2,a2
    80023c9a:	89ae                	mv	s3,a1
    80023c9c:	84aa                	mv	s1,a0
    return -1;

  if(f->type == FD_PIPE){
    80023c9e:	411c                	lw	a5,0(a0)
    80023ca0:	4705                	li	a4,1
    80023ca2:	04e78963          	beq	a5,a4,80023cf4 <filewrite+0x72>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80023ca6:	470d                	li	a4,3
    80023ca8:	04e78d63          	beq	a5,a4,80023d02 <filewrite+0x80>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_ENTRY){
    80023cac:	4709                	li	a4,2
    80023cae:	08e79563          	bne	a5,a4,80023d38 <filewrite+0xb6>
    elock(f->ep);
    80023cb2:	6d08                	ld	a0,24(a0)
    80023cb4:	00002097          	auipc	ra,0x2
    80023cb8:	7b8080e7          	jalr	1976(ra) # 8002646c <elock>
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    80023cbc:	00090a1b          	sext.w	s4,s2
    80023cc0:	8752                	mv	a4,s4
    80023cc2:	5094                	lw	a3,32(s1)
    80023cc4:	864e                	mv	a2,s3
    80023cc6:	4585                	li	a1,1
    80023cc8:	6c88                	ld	a0,24(s1)
    80023cca:	00002097          	auipc	ra,0x2
    80023cce:	fcc080e7          	jalr	-52(ra) # 80025c96 <ewrite>
      ret = n;
      f->off += n;
    } else {
      ret = -1;
    80023cd2:	59fd                	li	s3,-1
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    80023cd4:	05250b63          	beq	a0,s2,80023d2a <filewrite+0xa8>
    }
    eunlock(f->ep);
    80023cd8:	6c88                	ld	a0,24(s1)
    80023cda:	00002097          	auipc	ra,0x2
    80023cde:	7c8080e7          	jalr	1992(ra) # 800264a2 <eunlock>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80023ce2:	854e                	mv	a0,s3
    80023ce4:	70a2                	ld	ra,40(sp)
    80023ce6:	7402                	ld	s0,32(sp)
    80023ce8:	64e2                	ld	s1,24(sp)
    80023cea:	6942                	ld	s2,16(sp)
    80023cec:	69a2                	ld	s3,8(sp)
    80023cee:	6a02                	ld	s4,0(sp)
    80023cf0:	6145                	addi	sp,sp,48
    80023cf2:	8082                	ret
    ret = pipewrite(f->pipe, addr, n);
    80023cf4:	6908                	ld	a0,16(a0)
    80023cf6:	00000097          	auipc	ra,0x0
    80023cfa:	266080e7          	jalr	614(ra) # 80023f5c <pipewrite>
    80023cfe:	89aa                	mv	s3,a0
    80023d00:	b7cd                	j	80023ce2 <filewrite+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80023d02:	02451783          	lh	a5,36(a0)
    80023d06:	03079693          	slli	a3,a5,0x30
    80023d0a:	92c1                	srli	a3,a3,0x30
    80023d0c:	4725                	li	a4,9
    80023d0e:	02d76f63          	bltu	a4,a3,80023d4c <filewrite+0xca>
    80023d12:	0792                	slli	a5,a5,0x4
    80023d14:	0001c717          	auipc	a4,0x1c
    80023d18:	69c70713          	addi	a4,a4,1692 # 800403b0 <devsw>
    80023d1c:	97ba                	add	a5,a5,a4
    80023d1e:	679c                	ld	a5,8(a5)
    80023d20:	cb85                	beqz	a5,80023d50 <filewrite+0xce>
    ret = devsw[f->major].write(1, addr, n);
    80023d22:	4505                	li	a0,1
    80023d24:	9782                	jalr	a5
    80023d26:	89aa                	mv	s3,a0
    80023d28:	bf6d                	j	80023ce2 <filewrite+0x60>
      f->off += n;
    80023d2a:	509c                	lw	a5,32(s1)
    80023d2c:	01478a3b          	addw	s4,a5,s4
    80023d30:	0344a023          	sw	s4,32(s1)
      ret = n;
    80023d34:	89ca                	mv	s3,s2
    80023d36:	b74d                	j	80023cd8 <filewrite+0x56>
    panic("filewrite");
    80023d38:	00009517          	auipc	a0,0x9
    80023d3c:	d7050513          	addi	a0,a0,-656 # 8002caa8 <syscalls+0x9f0>
    80023d40:	ffffc097          	auipc	ra,0xffffc
    80023d44:	406080e7          	jalr	1030(ra) # 80020146 <panic>
    return -1;
    80023d48:	59fd                	li	s3,-1
    80023d4a:	bf61                	j	80023ce2 <filewrite+0x60>
      return -1;
    80023d4c:	59fd                	li	s3,-1
    80023d4e:	bf51                	j	80023ce2 <filewrite+0x60>
    80023d50:	59fd                	li	s3,-1
    80023d52:	bf41                	j	80023ce2 <filewrite+0x60>

0000000080023d54 <dirnext>:
int
dirnext(struct file *f, uint64 addr)
{
  // struct proc *p = myproc();

  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    80023d54:	00854783          	lbu	a5,8(a0)
    80023d58:	cbd5                	beqz	a5,80023e0c <dirnext+0xb8>
    80023d5a:	6d14                	ld	a3,24(a0)
    80023d5c:	1006c703          	lbu	a4,256(a3)
    80023d60:	8b41                	andi	a4,a4,16
    return -1;
    80023d62:	57fd                	li	a5,-1
  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    80023d64:	c74d                	beqz	a4,80023e0e <dirnext+0xba>
{
    80023d66:	7105                	addi	sp,sp,-480
    80023d68:	ef86                	sd	ra,472(sp)
    80023d6a:	eba2                	sd	s0,464(sp)
    80023d6c:	e7a6                	sd	s1,456(sp)
    80023d6e:	e3ca                	sd	s2,448(sp)
    80023d70:	ff4e                	sd	s3,440(sp)
    80023d72:	1380                	addi	s0,sp,480
    80023d74:	89ae                	mv	s3,a1
    80023d76:	84aa                	mv	s1,a0

  struct dirent de;
  struct stat st;
  int count = 0;
    80023d78:	e2042623          	sw	zero,-468(s0)
  int ret;
  elock(f->ep);
    80023d7c:	8536                	mv	a0,a3
    80023d7e:	00002097          	auipc	ra,0x2
    80023d82:	6ee080e7          	jalr	1774(ra) # 8002646c <elock>
  while ((ret = enext(f->ep, &de, f->off, &count)) == 0) {  // skip empty entry
    80023d86:	e2c40693          	addi	a3,s0,-468
    80023d8a:	5090                	lw	a2,32(s1)
    80023d8c:	e6840593          	addi	a1,s0,-408
    80023d90:	6c88                	ld	a0,24(s1)
    80023d92:	00003097          	auipc	ra,0x3
    80023d96:	8de080e7          	jalr	-1826(ra) # 80026670 <enext>
    80023d9a:	892a                	mv	s2,a0
    80023d9c:	e909                	bnez	a0,80023dae <dirnext+0x5a>
    f->off += count * 32;
    80023d9e:	e2c42783          	lw	a5,-468(s0)
    80023da2:	0057971b          	slliw	a4,a5,0x5
    80023da6:	509c                	lw	a5,32(s1)
    80023da8:	9fb9                	addw	a5,a5,a4
    80023daa:	d09c                	sw	a5,32(s1)
    80023dac:	bfe9                	j	80023d86 <dirnext+0x32>
  }
  eunlock(f->ep);
    80023dae:	6c88                	ld	a0,24(s1)
    80023db0:	00002097          	auipc	ra,0x2
    80023db4:	6f2080e7          	jalr	1778(ra) # 800264a2 <eunlock>
  if (ret == -1)
    80023db8:	577d                	li	a4,-1
    return 0;
    80023dba:	4781                	li	a5,0
  if (ret == -1)
    80023dbc:	04e90063          	beq	s2,a4,80023dfc <dirnext+0xa8>

  f->off += count * 32;
    80023dc0:	e2c42783          	lw	a5,-468(s0)
    80023dc4:	0057971b          	slliw	a4,a5,0x5
    80023dc8:	509c                	lw	a5,32(s1)
    80023dca:	9fb9                	addw	a5,a5,a4
    80023dcc:	d09c                	sw	a5,32(s1)
  estat(&de, &st);
    80023dce:	e3040593          	addi	a1,s0,-464
    80023dd2:	e6840513          	addi	a0,s0,-408
    80023dd6:	00003097          	auipc	ra,0x3
    80023dda:	852080e7          	jalr	-1966(ra) # 80026628 <estat>
  // if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
  if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    80023dde:	03800613          	li	a2,56
    80023de2:	e3040593          	addi	a1,s0,-464
    80023de6:	854e                	mv	a0,s3
    80023de8:	ffffd097          	auipc	ra,0xffffd
    80023dec:	6a0080e7          	jalr	1696(ra) # 80021488 <copyout2>
    return -1;
    80023df0:	fff54513          	not	a0,a0
    80023df4:	43f55793          	srai	a5,a0,0x3f
    80023df8:	8b89                	andi	a5,a5,2
    80023dfa:	17fd                	addi	a5,a5,-1

  return 1;
    80023dfc:	853e                	mv	a0,a5
    80023dfe:	60fe                	ld	ra,472(sp)
    80023e00:	645e                	ld	s0,464(sp)
    80023e02:	64be                	ld	s1,456(sp)
    80023e04:	691e                	ld	s2,448(sp)
    80023e06:	79fa                	ld	s3,440(sp)
    80023e08:	613d                	addi	sp,sp,480
    80023e0a:	8082                	ret
    return -1;
    80023e0c:	57fd                	li	a5,-1
    80023e0e:	853e                	mv	a0,a5
    80023e10:	8082                	ret

0000000080023e12 <pipealloc>:
#include "include/kalloc.h"
#include "include/vm.h"

int
pipealloc(struct file **f0, struct file **f1)
{
    80023e12:	7179                	addi	sp,sp,-48
    80023e14:	f406                	sd	ra,40(sp)
    80023e16:	f022                	sd	s0,32(sp)
    80023e18:	ec26                	sd	s1,24(sp)
    80023e1a:	e84a                	sd	s2,16(sp)
    80023e1c:	e44e                	sd	s3,8(sp)
    80023e1e:	e052                	sd	s4,0(sp)
    80023e20:	1800                	addi	s0,sp,48
    80023e22:	84aa                	mv	s1,a0
    80023e24:	892e                	mv	s2,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80023e26:	0005b023          	sd	zero,0(a1)
    80023e2a:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == NULL || (*f1 = filealloc()) == NULL)
    80023e2e:	00000097          	auipc	ra,0x0
    80023e32:	bac080e7          	jalr	-1108(ra) # 800239da <filealloc>
    80023e36:	e088                	sd	a0,0(s1)
    80023e38:	c551                	beqz	a0,80023ec4 <pipealloc+0xb2>
    80023e3a:	00000097          	auipc	ra,0x0
    80023e3e:	ba0080e7          	jalr	-1120(ra) # 800239da <filealloc>
    80023e42:	00a93023          	sd	a0,0(s2)
    80023e46:	c92d                	beqz	a0,80023eb8 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == NULL)
    80023e48:	ffffc097          	auipc	ra,0xffffc
    80023e4c:	70a080e7          	jalr	1802(ra) # 80020552 <kalloc>
    80023e50:	89aa                	mv	s3,a0
    80023e52:	c125                	beqz	a0,80023eb2 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80023e54:	4a05                	li	s4,1
    80023e56:	23452023          	sw	s4,544(a0)
  pi->writeopen = 1;
    80023e5a:	23452223          	sw	s4,548(a0)
  pi->nwrite = 0;
    80023e5e:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80023e62:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80023e66:	00009597          	auipc	a1,0x9
    80023e6a:	b8258593          	addi	a1,a1,-1150 # 8002c9e8 <syscalls+0x930>
    80023e6e:	ffffd097          	auipc	ra,0xffffd
    80023e72:	80e080e7          	jalr	-2034(ra) # 8002067c <initlock>
  (*f0)->type = FD_PIPE;
    80023e76:	609c                	ld	a5,0(s1)
    80023e78:	0147a023          	sw	s4,0(a5)
  (*f0)->readable = 1;
    80023e7c:	609c                	ld	a5,0(s1)
    80023e7e:	01478423          	sb	s4,8(a5)
  (*f0)->writable = 0;
    80023e82:	609c                	ld	a5,0(s1)
    80023e84:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80023e88:	609c                	ld	a5,0(s1)
    80023e8a:	0137b823          	sd	s3,16(a5)
  (*f1)->type = FD_PIPE;
    80023e8e:	00093783          	ld	a5,0(s2)
    80023e92:	0147a023          	sw	s4,0(a5)
  (*f1)->readable = 0;
    80023e96:	00093783          	ld	a5,0(s2)
    80023e9a:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80023e9e:	00093783          	ld	a5,0(s2)
    80023ea2:	014784a3          	sb	s4,9(a5)
  (*f1)->pipe = pi;
    80023ea6:	00093783          	ld	a5,0(s2)
    80023eaa:	0137b823          	sd	s3,16(a5)
  return 0;
    80023eae:	4501                	li	a0,0
    80023eb0:	a025                	j	80023ed8 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80023eb2:	6088                	ld	a0,0(s1)
    80023eb4:	e501                	bnez	a0,80023ebc <pipealloc+0xaa>
    80023eb6:	a039                	j	80023ec4 <pipealloc+0xb2>
    80023eb8:	6088                	ld	a0,0(s1)
    80023eba:	c51d                	beqz	a0,80023ee8 <pipealloc+0xd6>
    fileclose(*f0);
    80023ebc:	00000097          	auipc	ra,0x0
    80023ec0:	bee080e7          	jalr	-1042(ra) # 80023aaa <fileclose>
  if(*f1)
    80023ec4:	00093783          	ld	a5,0(s2)
    fileclose(*f1);
  return -1;
    80023ec8:	557d                	li	a0,-1
  if(*f1)
    80023eca:	c799                	beqz	a5,80023ed8 <pipealloc+0xc6>
    fileclose(*f1);
    80023ecc:	853e                	mv	a0,a5
    80023ece:	00000097          	auipc	ra,0x0
    80023ed2:	bdc080e7          	jalr	-1060(ra) # 80023aaa <fileclose>
  return -1;
    80023ed6:	557d                	li	a0,-1
}
    80023ed8:	70a2                	ld	ra,40(sp)
    80023eda:	7402                	ld	s0,32(sp)
    80023edc:	64e2                	ld	s1,24(sp)
    80023ede:	6942                	ld	s2,16(sp)
    80023ee0:	69a2                	ld	s3,8(sp)
    80023ee2:	6a02                	ld	s4,0(sp)
    80023ee4:	6145                	addi	sp,sp,48
    80023ee6:	8082                	ret
  return -1;
    80023ee8:	557d                	li	a0,-1
    80023eea:	b7fd                	j	80023ed8 <pipealloc+0xc6>

0000000080023eec <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80023eec:	1101                	addi	sp,sp,-32
    80023eee:	ec06                	sd	ra,24(sp)
    80023ef0:	e822                	sd	s0,16(sp)
    80023ef2:	e426                	sd	s1,8(sp)
    80023ef4:	e04a                	sd	s2,0(sp)
    80023ef6:	1000                	addi	s0,sp,32
    80023ef8:	84aa                	mv	s1,a0
    80023efa:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80023efc:	ffffc097          	auipc	ra,0xffffc
    80023f00:	7c4080e7          	jalr	1988(ra) # 800206c0 <acquire>
  if(writable){
    80023f04:	02090d63          	beqz	s2,80023f3e <pipeclose+0x52>
    pi->writeopen = 0;
    80023f08:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80023f0c:	21848513          	addi	a0,s1,536
    80023f10:	ffffe097          	auipc	ra,0xffffe
    80023f14:	6ee080e7          	jalr	1774(ra) # 800225fe <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80023f18:	2204b783          	ld	a5,544(s1)
    80023f1c:	eb95                	bnez	a5,80023f50 <pipeclose+0x64>
    release(&pi->lock);
    80023f1e:	8526                	mv	a0,s1
    80023f20:	ffffc097          	auipc	ra,0xffffc
    80023f24:	7f4080e7          	jalr	2036(ra) # 80020714 <release>
    kfree((char*)pi);
    80023f28:	8526                	mv	a0,s1
    80023f2a:	ffffc097          	auipc	ra,0xffffc
    80023f2e:	50e080e7          	jalr	1294(ra) # 80020438 <kfree>
  } else
    release(&pi->lock);
}
    80023f32:	60e2                	ld	ra,24(sp)
    80023f34:	6442                	ld	s0,16(sp)
    80023f36:	64a2                	ld	s1,8(sp)
    80023f38:	6902                	ld	s2,0(sp)
    80023f3a:	6105                	addi	sp,sp,32
    80023f3c:	8082                	ret
    pi->readopen = 0;
    80023f3e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80023f42:	21c48513          	addi	a0,s1,540
    80023f46:	ffffe097          	auipc	ra,0xffffe
    80023f4a:	6b8080e7          	jalr	1720(ra) # 800225fe <wakeup>
    80023f4e:	b7e9                	j	80023f18 <pipeclose+0x2c>
    release(&pi->lock);
    80023f50:	8526                	mv	a0,s1
    80023f52:	ffffc097          	auipc	ra,0xffffc
    80023f56:	7c2080e7          	jalr	1986(ra) # 80020714 <release>
}
    80023f5a:	bfe1                	j	80023f32 <pipeclose+0x46>

0000000080023f5c <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80023f5c:	7119                	addi	sp,sp,-128
    80023f5e:	fc86                	sd	ra,120(sp)
    80023f60:	f8a2                	sd	s0,112(sp)
    80023f62:	f4a6                	sd	s1,104(sp)
    80023f64:	f0ca                	sd	s2,96(sp)
    80023f66:	ecce                	sd	s3,88(sp)
    80023f68:	e8d2                	sd	s4,80(sp)
    80023f6a:	e4d6                	sd	s5,72(sp)
    80023f6c:	e0da                	sd	s6,64(sp)
    80023f6e:	fc5e                	sd	s7,56(sp)
    80023f70:	f862                	sd	s8,48(sp)
    80023f72:	f466                	sd	s9,40(sp)
    80023f74:	f06a                	sd	s10,32(sp)
    80023f76:	ec6e                	sd	s11,24(sp)
    80023f78:	0100                	addi	s0,sp,128
    80023f7a:	84aa                	mv	s1,a0
    80023f7c:	8d2e                	mv	s10,a1
    80023f7e:	8b32                	mv	s6,a2
  int i;
  char ch;
  struct proc *pr = myproc();
    80023f80:	ffffe097          	auipc	ra,0xffffe
    80023f84:	c02080e7          	jalr	-1022(ra) # 80021b82 <myproc>
    80023f88:	892a                	mv	s2,a0

  acquire(&pi->lock);
    80023f8a:	8526                	mv	a0,s1
    80023f8c:	ffffc097          	auipc	ra,0xffffc
    80023f90:	734080e7          	jalr	1844(ra) # 800206c0 <acquire>
  for(i = 0; i < n; i++){
    80023f94:	0d605d63          	blez	s6,8002406e <pipewrite+0x112>
    80023f98:	89a6                	mv	s3,s1
    80023f9a:	3b7d                	addiw	s6,s6,-1
    80023f9c:	1b02                	slli	s6,s6,0x20
    80023f9e:	020b5b13          	srli	s6,s6,0x20
    80023fa2:	4b81                	li	s7,0
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || pr->killed){
        release(&pi->lock);
        return -1;
      }
      wakeup(&pi->nread);
    80023fa4:	21848a93          	addi	s5,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80023fa8:	21c48a13          	addi	s4,s1,540
    }
    // if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    if(copyin2(&ch, addr + i, 1) == -1)
    80023fac:	5dfd                	li	s11,-1
    80023fae:	000b8c9b          	sext.w	s9,s7
    80023fb2:	8c66                	mv	s8,s9
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023fb4:	2184a783          	lw	a5,536(s1)
    80023fb8:	21c4a703          	lw	a4,540(s1)
    80023fbc:	2007879b          	addiw	a5,a5,512
    80023fc0:	06f71763          	bne	a4,a5,8002402e <pipewrite+0xd2>
      if(pi->readopen == 0 || pr->killed){
    80023fc4:	2204a783          	lw	a5,544(s1)
    80023fc8:	cf8d                	beqz	a5,80024002 <pipewrite+0xa6>
    80023fca:	03092783          	lw	a5,48(s2)
    80023fce:	eb95                	bnez	a5,80024002 <pipewrite+0xa6>
      wakeup(&pi->nread);
    80023fd0:	8556                	mv	a0,s5
    80023fd2:	ffffe097          	auipc	ra,0xffffe
    80023fd6:	62c080e7          	jalr	1580(ra) # 800225fe <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80023fda:	85ce                	mv	a1,s3
    80023fdc:	8552                	mv	a0,s4
    80023fde:	ffffe097          	auipc	ra,0xffffe
    80023fe2:	44c080e7          	jalr	1100(ra) # 8002242a <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023fe6:	2184a783          	lw	a5,536(s1)
    80023fea:	21c4a703          	lw	a4,540(s1)
    80023fee:	2007879b          	addiw	a5,a5,512
    80023ff2:	02f71e63          	bne	a4,a5,8002402e <pipewrite+0xd2>
      if(pi->readopen == 0 || pr->killed){
    80023ff6:	2204a783          	lw	a5,544(s1)
    80023ffa:	c781                	beqz	a5,80024002 <pipewrite+0xa6>
    80023ffc:	03092783          	lw	a5,48(s2)
    80024000:	dbe1                	beqz	a5,80023fd0 <pipewrite+0x74>
        release(&pi->lock);
    80024002:	8526                	mv	a0,s1
    80024004:	ffffc097          	auipc	ra,0xffffc
    80024008:	710080e7          	jalr	1808(ra) # 80020714 <release>
        return -1;
    8002400c:	5c7d                	li	s8,-1
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
  }
  wakeup(&pi->nread);
  release(&pi->lock);
  return i;
}
    8002400e:	8562                	mv	a0,s8
    80024010:	70e6                	ld	ra,120(sp)
    80024012:	7446                	ld	s0,112(sp)
    80024014:	74a6                	ld	s1,104(sp)
    80024016:	7906                	ld	s2,96(sp)
    80024018:	69e6                	ld	s3,88(sp)
    8002401a:	6a46                	ld	s4,80(sp)
    8002401c:	6aa6                	ld	s5,72(sp)
    8002401e:	6b06                	ld	s6,64(sp)
    80024020:	7be2                	ld	s7,56(sp)
    80024022:	7c42                	ld	s8,48(sp)
    80024024:	7ca2                	ld	s9,40(sp)
    80024026:	7d02                	ld	s10,32(sp)
    80024028:	6de2                	ld	s11,24(sp)
    8002402a:	6109                	addi	sp,sp,128
    8002402c:	8082                	ret
    if(copyin2(&ch, addr + i, 1) == -1)
    8002402e:	4605                	li	a2,1
    80024030:	01ab85b3          	add	a1,s7,s10
    80024034:	f8f40513          	addi	a0,s0,-113
    80024038:	ffffd097          	auipc	ra,0xffffd
    8002403c:	530080e7          	jalr	1328(ra) # 80021568 <copyin2>
    80024040:	03b50863          	beq	a0,s11,80024070 <pipewrite+0x114>
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80024044:	21c4a783          	lw	a5,540(s1)
    80024048:	0017871b          	addiw	a4,a5,1
    8002404c:	20e4ae23          	sw	a4,540(s1)
    80024050:	1ff7f793          	andi	a5,a5,511
    80024054:	97a6                	add	a5,a5,s1
    80024056:	f8f44703          	lbu	a4,-113(s0)
    8002405a:	00e78c23          	sb	a4,24(a5)
    8002405e:	001c8c1b          	addiw	s8,s9,1
    80024062:	001b8793          	addi	a5,s7,1
  for(i = 0; i < n; i++){
    80024066:	016b8563          	beq	s7,s6,80024070 <pipewrite+0x114>
    8002406a:	8bbe                	mv	s7,a5
    8002406c:	b789                	j	80023fae <pipewrite+0x52>
    8002406e:	4c01                	li	s8,0
  wakeup(&pi->nread);
    80024070:	21848513          	addi	a0,s1,536
    80024074:	ffffe097          	auipc	ra,0xffffe
    80024078:	58a080e7          	jalr	1418(ra) # 800225fe <wakeup>
  release(&pi->lock);
    8002407c:	8526                	mv	a0,s1
    8002407e:	ffffc097          	auipc	ra,0xffffc
    80024082:	696080e7          	jalr	1686(ra) # 80020714 <release>
  return i;
    80024086:	b761                	j	8002400e <pipewrite+0xb2>

0000000080024088 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80024088:	715d                	addi	sp,sp,-80
    8002408a:	e486                	sd	ra,72(sp)
    8002408c:	e0a2                	sd	s0,64(sp)
    8002408e:	fc26                	sd	s1,56(sp)
    80024090:	f84a                	sd	s2,48(sp)
    80024092:	f44e                	sd	s3,40(sp)
    80024094:	f052                	sd	s4,32(sp)
    80024096:	ec56                	sd	s5,24(sp)
    80024098:	e85a                	sd	s6,16(sp)
    8002409a:	0880                	addi	s0,sp,80
    8002409c:	84aa                	mv	s1,a0
    8002409e:	89ae                	mv	s3,a1
    800240a0:	8a32                	mv	s4,a2
  int i;
  struct proc *pr = myproc();
    800240a2:	ffffe097          	auipc	ra,0xffffe
    800240a6:	ae0080e7          	jalr	-1312(ra) # 80021b82 <myproc>
    800240aa:	892a                	mv	s2,a0
  char ch;

  acquire(&pi->lock);
    800240ac:	8526                	mv	a0,s1
    800240ae:	ffffc097          	auipc	ra,0xffffc
    800240b2:	612080e7          	jalr	1554(ra) # 800206c0 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800240b6:	2184a703          	lw	a4,536(s1)
    800240ba:	21c4a783          	lw	a5,540(s1)
    800240be:	06f71b63          	bne	a4,a5,80024134 <piperead+0xac>
    800240c2:	8aa6                	mv	s5,s1
    800240c4:	2244a783          	lw	a5,548(s1)
    800240c8:	cf9d                	beqz	a5,80024106 <piperead+0x7e>
    if(pr->killed){
    800240ca:	03092783          	lw	a5,48(s2)
    800240ce:	e78d                	bnez	a5,800240f8 <piperead+0x70>
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800240d0:	21848b13          	addi	s6,s1,536
    800240d4:	85d6                	mv	a1,s5
    800240d6:	855a                	mv	a0,s6
    800240d8:	ffffe097          	auipc	ra,0xffffe
    800240dc:	352080e7          	jalr	850(ra) # 8002242a <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800240e0:	2184a703          	lw	a4,536(s1)
    800240e4:	21c4a783          	lw	a5,540(s1)
    800240e8:	04f71663          	bne	a4,a5,80024134 <piperead+0xac>
    800240ec:	2244a783          	lw	a5,548(s1)
    800240f0:	cb99                	beqz	a5,80024106 <piperead+0x7e>
    if(pr->killed){
    800240f2:	03092783          	lw	a5,48(s2)
    800240f6:	dff9                	beqz	a5,800240d4 <piperead+0x4c>
      release(&pi->lock);
    800240f8:	8526                	mv	a0,s1
    800240fa:	ffffc097          	auipc	ra,0xffffc
    800240fe:	61a080e7          	jalr	1562(ra) # 80020714 <release>
      return -1;
    80024102:	597d                	li	s2,-1
    80024104:	a829                	j	8002411e <piperead+0x96>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(pi->nread == pi->nwrite)
    80024106:	4901                	li	s2,0
    ch = pi->data[pi->nread++ % PIPESIZE];
    // if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    if(copyout2(addr + i, &ch, 1) == -1)
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80024108:	21c48513          	addi	a0,s1,540
    8002410c:	ffffe097          	auipc	ra,0xffffe
    80024110:	4f2080e7          	jalr	1266(ra) # 800225fe <wakeup>
  release(&pi->lock);
    80024114:	8526                	mv	a0,s1
    80024116:	ffffc097          	auipc	ra,0xffffc
    8002411a:	5fe080e7          	jalr	1534(ra) # 80020714 <release>
  return i;
}
    8002411e:	854a                	mv	a0,s2
    80024120:	60a6                	ld	ra,72(sp)
    80024122:	6406                	ld	s0,64(sp)
    80024124:	74e2                	ld	s1,56(sp)
    80024126:	7942                	ld	s2,48(sp)
    80024128:	79a2                	ld	s3,40(sp)
    8002412a:	7a02                	ld	s4,32(sp)
    8002412c:	6ae2                	ld	s5,24(sp)
    8002412e:	6b42                	ld	s6,16(sp)
    80024130:	6161                	addi	sp,sp,80
    80024132:	8082                	ret
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80024134:	4901                	li	s2,0
    80024136:	fd4059e3          	blez	s4,80024108 <piperead+0x80>
    if(pi->nread == pi->nwrite)
    8002413a:	2184a783          	lw	a5,536(s1)
    8002413e:	4901                	li	s2,0
    if(copyout2(addr + i, &ch, 1) == -1)
    80024140:	5afd                	li	s5,-1
    ch = pi->data[pi->nread++ % PIPESIZE];
    80024142:	0017871b          	addiw	a4,a5,1
    80024146:	20e4ac23          	sw	a4,536(s1)
    8002414a:	1ff7f793          	andi	a5,a5,511
    8002414e:	97a6                	add	a5,a5,s1
    80024150:	0187c783          	lbu	a5,24(a5)
    80024154:	faf40fa3          	sb	a5,-65(s0)
    if(copyout2(addr + i, &ch, 1) == -1)
    80024158:	4605                	li	a2,1
    8002415a:	fbf40593          	addi	a1,s0,-65
    8002415e:	854e                	mv	a0,s3
    80024160:	ffffd097          	auipc	ra,0xffffd
    80024164:	328080e7          	jalr	808(ra) # 80021488 <copyout2>
    80024168:	fb5500e3          	beq	a0,s5,80024108 <piperead+0x80>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8002416c:	2905                	addiw	s2,s2,1
    8002416e:	f92a0de3          	beq	s4,s2,80024108 <piperead+0x80>
    if(pi->nread == pi->nwrite)
    80024172:	2184a783          	lw	a5,536(s1)
    80024176:	0985                	addi	s3,s3,1
    80024178:	21c4a703          	lw	a4,540(s1)
    8002417c:	fcf713e3          	bne	a4,a5,80024142 <piperead+0xba>
    80024180:	b761                	j	80024108 <piperead+0x80>

0000000080024182 <exec>:
  return 0;
}


int exec(char *path, char **argv)
{
    80024182:	dd010113          	addi	sp,sp,-560
    80024186:	22113423          	sd	ra,552(sp)
    8002418a:	22813023          	sd	s0,544(sp)
    8002418e:	20913c23          	sd	s1,536(sp)
    80024192:	21213823          	sd	s2,528(sp)
    80024196:	21313423          	sd	s3,520(sp)
    8002419a:	21413023          	sd	s4,512(sp)
    8002419e:	ffd6                	sd	s5,504(sp)
    800241a0:	fbda                	sd	s6,496(sp)
    800241a2:	f7de                	sd	s7,488(sp)
    800241a4:	f3e2                	sd	s8,480(sp)
    800241a6:	efe6                	sd	s9,472(sp)
    800241a8:	ebea                	sd	s10,464(sp)
    800241aa:	e7ee                	sd	s11,456(sp)
    800241ac:	1c00                	addi	s0,sp,560
    800241ae:	892a                	mv	s2,a0
    800241b0:	dea43023          	sd	a0,-544(s0)
    800241b4:	deb43423          	sd	a1,-536(s0)
  struct elfhdr elf;
  struct dirent *ep;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  pagetable_t kpagetable = 0, oldkpagetable;
  struct proc *p = myproc();
    800241b8:	ffffe097          	auipc	ra,0xffffe
    800241bc:	9ca080e7          	jalr	-1590(ra) # 80021b82 <myproc>
    800241c0:	84aa                	mv	s1,a0

  // Make a copy of p->kpt without old user space, 
  // but with the same kstack we are using now, which can't be changed
  if ((kpagetable = (pagetable_t)kalloc()) == NULL) {
    800241c2:	ffffc097          	auipc	ra,0xffffc
    800241c6:	390080e7          	jalr	912(ra) # 80020552 <kalloc>
    800241ca:	2a050363          	beqz	a0,80024470 <exec+0x2ee>
    800241ce:	8aaa                	mv	s5,a0
    return -1;
  }
  memmove(kpagetable, p->kpagetable, PGSIZE);
    800241d0:	6605                	lui	a2,0x1
    800241d2:	6cac                	ld	a1,88(s1)
    800241d4:	ffffc097          	auipc	ra,0xffffc
    800241d8:	5f4080e7          	jalr	1524(ra) # 800207c8 <memmove>
  for (int i = 0; i < PX(2, MAXUVA); i++) {
    kpagetable[i] = 0;
    800241dc:	000ab023          	sd	zero,0(s5)
    800241e0:	000ab423          	sd	zero,8(s5)
  }

  if((ep = ename(path)) == NULL) {
    800241e4:	854a                	mv	a0,s2
    800241e6:	00003097          	auipc	ra,0x3
    800241ea:	a2c080e7          	jalr	-1492(ra) # 80026c12 <ename>
    800241ee:	8a2a                	mv	s4,a0
    800241f0:	3a050963          	beqz	a0,800245a2 <exec+0x420>
    #ifdef DEBUG
    printf("[exec] %s not found\n", path);
    #endif
    goto bad;
  }
  elock(ep);
    800241f4:	00002097          	auipc	ra,0x2
    800241f8:	278080e7          	jalr	632(ra) # 8002646c <elock>

  // Check ELF header
  if(eread(ep, 0, (uint64) &elf, 0, sizeof(elf)) != sizeof(elf))
    800241fc:	04000713          	li	a4,64
    80024200:	4681                	li	a3,0
    80024202:	e4840613          	addi	a2,s0,-440
    80024206:	4581                	li	a1,0
    80024208:	8552                	mv	a0,s4
    8002420a:	00002097          	auipc	ra,0x2
    8002420e:	994080e7          	jalr	-1644(ra) # 80025b9e <eread>
    80024212:	04000793          	li	a5,64
    80024216:	00f51a63          	bne	a0,a5,8002422a <exec+0xa8>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    8002421a:	e4842703          	lw	a4,-440(s0)
    8002421e:	464c47b7          	lui	a5,0x464c4
    80024222:	57f78793          	addi	a5,a5,1407 # 464c457f <BASE_ADDRESS-0x39b5ba81>
    80024226:	00f70963          	beq	a4,a5,80024238 <exec+0xb6>
  printf("[exec] reach bad\n");
  #endif
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(kpagetable)
    kvmfree(kpagetable, 0);
    8002422a:	4581                	li	a1,0
    8002422c:	8556                	mv	a0,s5
    8002422e:	ffffd097          	auipc	ra,0xffffd
    80024232:	578080e7          	jalr	1400(ra) # 800217a6 <kvmfree>
  if(ep){
    80024236:	a495                	j	8002449a <exec+0x318>
  if((pagetable = proc_pagetable(p)) == NULL)
    80024238:	8526                	mv	a0,s1
    8002423a:	ffffe097          	auipc	ra,0xffffe
    8002423e:	a2e080e7          	jalr	-1490(ra) # 80021c68 <proc_pagetable>
    80024242:	e0a43423          	sd	a0,-504(s0)
    80024246:	d175                	beqz	a0,8002422a <exec+0xa8>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80024248:	e6842783          	lw	a5,-408(s0)
    8002424c:	e8045703          	lhu	a4,-384(s0)
    80024250:	c73d                	beqz	a4,800242be <exec+0x13c>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    80024252:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80024254:	e0043023          	sd	zero,-512(s0)
    if(ph.vaddr % PGSIZE != 0)
    80024258:	6b05                	lui	s6,0x1
    8002425a:	fffb0713          	addi	a4,s6,-1 # fff <BASE_ADDRESS-0x8001f001>
    8002425e:	dce43c23          	sd	a4,-552(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80024262:	6d85                	lui	s11,0x1
    80024264:	7d7d                	lui	s10,0xfffff
    80024266:	a4c1                	j	80024526 <exec+0x3a4>
      panic("loadseg: address should exist");
    80024268:	00009517          	auipc	a0,0x9
    8002426c:	85050513          	addi	a0,a0,-1968 # 8002cab8 <syscalls+0xa00>
    80024270:	ffffc097          	auipc	ra,0xffffc
    80024274:	ed6080e7          	jalr	-298(ra) # 80020146 <panic>
    if(eread(ep, 0, (uint64)pa, offset+i, n) != n)
    80024278:	874e                	mv	a4,s3
    8002427a:	009c86bb          	addw	a3,s9,s1
    8002427e:	4581                	li	a1,0
    80024280:	8552                	mv	a0,s4
    80024282:	00002097          	auipc	ra,0x2
    80024286:	91c080e7          	jalr	-1764(ra) # 80025b9e <eread>
    8002428a:	2501                	sext.w	a0,a0
    8002428c:	1ea99663          	bne	s3,a0,80024478 <exec+0x2f6>
  for(i = 0; i < sz; i += PGSIZE){
    80024290:	009d84bb          	addw	s1,s11,s1
    80024294:	012d093b          	addw	s2,s10,s2
    80024298:	2774f763          	bgeu	s1,s7,80024506 <exec+0x384>
    pa = walkaddr(pagetable, va + i);
    8002429c:	02049593          	slli	a1,s1,0x20
    800242a0:	9181                	srli	a1,a1,0x20
    800242a2:	95e2                	add	a1,a1,s8
    800242a4:	e0843503          	ld	a0,-504(s0)
    800242a8:	ffffd097          	auipc	ra,0xffffd
    800242ac:	97e080e7          	jalr	-1666(ra) # 80020c26 <walkaddr>
    800242b0:	862a                	mv	a2,a0
    if(pa == NULL)
    800242b2:	d95d                	beqz	a0,80024268 <exec+0xe6>
      n = PGSIZE;
    800242b4:	89da                	mv	s3,s6
    if(sz - i < PGSIZE)
    800242b6:	fd6971e3          	bgeu	s2,s6,80024278 <exec+0xf6>
      n = sz - i;
    800242ba:	89ca                	mv	s3,s2
    800242bc:	bf75                	j	80024278 <exec+0xf6>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    800242be:	4481                	li	s1,0
  eunlock(ep);
    800242c0:	8552                	mv	a0,s4
    800242c2:	00002097          	auipc	ra,0x2
    800242c6:	1e0080e7          	jalr	480(ra) # 800264a2 <eunlock>
  eput(ep);
    800242ca:	8552                	mv	a0,s4
    800242cc:	00002097          	auipc	ra,0x2
    800242d0:	224080e7          	jalr	548(ra) # 800264f0 <eput>
  p = myproc();
    800242d4:	ffffe097          	auipc	ra,0xffffe
    800242d8:	8ae080e7          	jalr	-1874(ra) # 80021b82 <myproc>
    800242dc:	8b2a                	mv	s6,a0
  uint64 oldsz = p->sz;
    800242de:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    800242e2:	6785                	lui	a5,0x1
    800242e4:	17fd                	addi	a5,a5,-1
    800242e6:	94be                	add	s1,s1,a5
    800242e8:	77fd                	lui	a5,0xfffff
    800242ea:	8fe5                	and	a5,a5,s1
    800242ec:	def43823          	sd	a5,-528(s0)
  if((sz1 = uvmalloc(pagetable, kpagetable, sz, sz + 2*PGSIZE)) == 0)
    800242f0:	6689                	lui	a3,0x2
    800242f2:	96be                	add	a3,a3,a5
    800242f4:	863e                	mv	a2,a5
    800242f6:	85d6                	mv	a1,s5
    800242f8:	e0843483          	ld	s1,-504(s0)
    800242fc:	8526                	mv	a0,s1
    800242fe:	ffffd097          	auipc	ra,0xffffd
    80024302:	e26080e7          	jalr	-474(ra) # 80021124 <uvmalloc>
    80024306:	8caa                	mv	s9,a0
  ep = 0;
    80024308:	4a01                	li	s4,0
  if((sz1 = uvmalloc(pagetable, kpagetable, sz, sz + 2*PGSIZE)) == 0)
    8002430a:	16050763          	beqz	a0,80024478 <exec+0x2f6>
  uvmclear(pagetable, sz-2*PGSIZE);
    8002430e:	75f9                	lui	a1,0xffffe
    80024310:	95aa                	add	a1,a1,a0
    80024312:	8526                	mv	a0,s1
    80024314:	ffffd097          	auipc	ra,0xffffd
    80024318:	0b6080e7          	jalr	182(ra) # 800213ca <uvmclear>
  stackbase = sp - PGSIZE;
    8002431c:	7bfd                	lui	s7,0xfffff
    8002431e:	9be6                	add	s7,s7,s9
  for(argc = 0; argv[argc]; argc++) {
    80024320:	de843783          	ld	a5,-536(s0)
    80024324:	6388                	ld	a0,0(a5)
    80024326:	c925                	beqz	a0,80024396 <exec+0x214>
    80024328:	e8840993          	addi	s3,s0,-376
    8002432c:	f8840c13          	addi	s8,s0,-120
  sp = sz;
    80024330:	8966                	mv	s2,s9
  for(argc = 0; argv[argc]; argc++) {
    80024332:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80024334:	ffffc097          	auipc	ra,0xffffc
    80024338:	5d2080e7          	jalr	1490(ra) # 80020906 <strlen>
    8002433c:	2505                	addiw	a0,a0,1
    8002433e:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80024342:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80024346:	1b796463          	bltu	s2,s7,800244ee <exec+0x36c>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    8002434a:	de843d83          	ld	s11,-536(s0)
    8002434e:	000dba03          	ld	s4,0(s11) # 1000 <BASE_ADDRESS-0x8001f000>
    80024352:	8552                	mv	a0,s4
    80024354:	ffffc097          	auipc	ra,0xffffc
    80024358:	5b2080e7          	jalr	1458(ra) # 80020906 <strlen>
    8002435c:	0015069b          	addiw	a3,a0,1
    80024360:	8652                	mv	a2,s4
    80024362:	85ca                	mv	a1,s2
    80024364:	e0843503          	ld	a0,-504(s0)
    80024368:	ffffd097          	auipc	ra,0xffffd
    8002436c:	094080e7          	jalr	148(ra) # 800213fc <copyout>
    80024370:	18054363          	bltz	a0,800244f6 <exec+0x374>
    ustack[argc] = sp;
    80024374:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80024378:	0485                	addi	s1,s1,1
    8002437a:	008d8793          	addi	a5,s11,8
    8002437e:	def43423          	sd	a5,-536(s0)
    80024382:	008db503          	ld	a0,8(s11)
    80024386:	c911                	beqz	a0,8002439a <exec+0x218>
    if(argc >= MAXARG)
    80024388:	09a1                	addi	s3,s3,8
    8002438a:	fb3c15e3          	bne	s8,s3,80024334 <exec+0x1b2>
  sz = sz1;
    8002438e:	df943823          	sd	s9,-528(s0)
  ep = 0;
    80024392:	4a01                	li	s4,0
    80024394:	a0d5                	j	80024478 <exec+0x2f6>
  sp = sz;
    80024396:	8966                	mv	s2,s9
  for(argc = 0; argv[argc]; argc++) {
    80024398:	4481                	li	s1,0
  ustack[argc] = 0;
    8002439a:	00349793          	slli	a5,s1,0x3
    8002439e:	f9040713          	addi	a4,s0,-112
    800243a2:	97ba                	add	a5,a5,a4
    800243a4:	ee07bc23          	sd	zero,-264(a5) # ffffffffffffeef8 <kernel_end+0xffffffff7ffb8ef8>
  sp -= (argc+1) * sizeof(uint64);
    800243a8:	00148693          	addi	a3,s1,1
    800243ac:	068e                	slli	a3,a3,0x3
    800243ae:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    800243b2:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    800243b6:	01797663          	bgeu	s2,s7,800243c2 <exec+0x240>
  sz = sz1;
    800243ba:	df943823          	sd	s9,-528(s0)
  ep = 0;
    800243be:	4a01                	li	s4,0
    800243c0:	a865                	j	80024478 <exec+0x2f6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800243c2:	e8840613          	addi	a2,s0,-376
    800243c6:	85ca                	mv	a1,s2
    800243c8:	e0843503          	ld	a0,-504(s0)
    800243cc:	ffffd097          	auipc	ra,0xffffd
    800243d0:	030080e7          	jalr	48(ra) # 800213fc <copyout>
    800243d4:	12054563          	bltz	a0,800244fe <exec+0x37c>
  p->trapframe->a1 = sp;
    800243d8:	060b3783          	ld	a5,96(s6)
    800243dc:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800243e0:	de043783          	ld	a5,-544(s0)
    800243e4:	0007c703          	lbu	a4,0(a5)
    800243e8:	cf11                	beqz	a4,80024404 <exec+0x282>
    800243ea:	0785                	addi	a5,a5,1
    if(*s == '/')
    800243ec:	02f00693          	li	a3,47
    800243f0:	a029                	j	800243fa <exec+0x278>
    800243f2:	0785                	addi	a5,a5,1
  for(last=s=path; *s; s++)
    800243f4:	fff7c703          	lbu	a4,-1(a5)
    800243f8:	c711                	beqz	a4,80024404 <exec+0x282>
    if(*s == '/')
    800243fa:	fed71ce3          	bne	a4,a3,800243f2 <exec+0x270>
      last = s+1;
    800243fe:	def43023          	sd	a5,-544(s0)
    80024402:	bfc5                	j	800243f2 <exec+0x270>
  safestrcpy(p->name, last, sizeof(p->name));
    80024404:	4641                	li	a2,16
    80024406:	de043583          	ld	a1,-544(s0)
    8002440a:	160b0513          	addi	a0,s6,352
    8002440e:	ffffc097          	auipc	ra,0xffffc
    80024412:	4c6080e7          	jalr	1222(ra) # 800208d4 <safestrcpy>
  oldpagetable = p->pagetable;
    80024416:	050b3503          	ld	a0,80(s6)
  oldkpagetable = p->kpagetable;
    8002441a:	058b3983          	ld	s3,88(s6)
  p->pagetable = pagetable;
    8002441e:	e0843783          	ld	a5,-504(s0)
    80024422:	04fb3823          	sd	a5,80(s6)
  p->kpagetable = kpagetable;
    80024426:	055b3c23          	sd	s5,88(s6)
  p->sz = sz;
    8002442a:	059b3423          	sd	s9,72(s6)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8002442e:	060b3783          	ld	a5,96(s6)
    80024432:	e6043703          	ld	a4,-416(s0)
    80024436:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80024438:	060b3783          	ld	a5,96(s6)
    8002443c:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80024440:	85ea                	mv	a1,s10
    80024442:	ffffe097          	auipc	ra,0xffffe
    80024446:	8c2080e7          	jalr	-1854(ra) # 80021d04 <proc_freepagetable>
  w_satp(MAKE_SATP(p->kpagetable));
    8002444a:	058b3783          	ld	a5,88(s6)
    8002444e:	83b1                	srli	a5,a5,0xc
    80024450:	577d                	li	a4,-1
    80024452:	177e                	slli	a4,a4,0x3f
    80024454:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80024456:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    8002445a:	12000073          	sfence.vma
  kvmfree(oldkpagetable, 0);
    8002445e:	4581                	li	a1,0
    80024460:	854e                	mv	a0,s3
    80024462:	ffffd097          	auipc	ra,0xffffd
    80024466:	344080e7          	jalr	836(ra) # 800217a6 <kvmfree>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    8002446a:	0004851b          	sext.w	a0,s1
    8002446e:	a089                	j	800244b0 <exec+0x32e>
    return -1;
    80024470:	557d                	li	a0,-1
    80024472:	a83d                	j	800244b0 <exec+0x32e>
    80024474:	de943823          	sd	s1,-528(s0)
    proc_freepagetable(pagetable, sz);
    80024478:	df043583          	ld	a1,-528(s0)
    8002447c:	e0843503          	ld	a0,-504(s0)
    80024480:	ffffe097          	auipc	ra,0xffffe
    80024484:	884080e7          	jalr	-1916(ra) # 80021d04 <proc_freepagetable>
    kvmfree(kpagetable, 0);
    80024488:	4581                	li	a1,0
    8002448a:	8556                	mv	a0,s5
    8002448c:	ffffd097          	auipc	ra,0xffffd
    80024490:	31a080e7          	jalr	794(ra) # 800217a6 <kvmfree>
    eunlock(ep);
    eput(ep);
  }
  return -1;
    80024494:	557d                	li	a0,-1
  if(ep){
    80024496:	000a0d63          	beqz	s4,800244b0 <exec+0x32e>
    eunlock(ep);
    8002449a:	8552                	mv	a0,s4
    8002449c:	00002097          	auipc	ra,0x2
    800244a0:	006080e7          	jalr	6(ra) # 800264a2 <eunlock>
    eput(ep);
    800244a4:	8552                	mv	a0,s4
    800244a6:	00002097          	auipc	ra,0x2
    800244aa:	04a080e7          	jalr	74(ra) # 800264f0 <eput>
  return -1;
    800244ae:	557d                	li	a0,-1
}
    800244b0:	22813083          	ld	ra,552(sp)
    800244b4:	22013403          	ld	s0,544(sp)
    800244b8:	21813483          	ld	s1,536(sp)
    800244bc:	21013903          	ld	s2,528(sp)
    800244c0:	20813983          	ld	s3,520(sp)
    800244c4:	20013a03          	ld	s4,512(sp)
    800244c8:	7afe                	ld	s5,504(sp)
    800244ca:	7b5e                	ld	s6,496(sp)
    800244cc:	7bbe                	ld	s7,488(sp)
    800244ce:	7c1e                	ld	s8,480(sp)
    800244d0:	6cfe                	ld	s9,472(sp)
    800244d2:	6d5e                	ld	s10,464(sp)
    800244d4:	6dbe                	ld	s11,456(sp)
    800244d6:	23010113          	addi	sp,sp,560
    800244da:	8082                	ret
    800244dc:	de943823          	sd	s1,-528(s0)
    800244e0:	bf61                	j	80024478 <exec+0x2f6>
    800244e2:	de943823          	sd	s1,-528(s0)
    800244e6:	bf49                	j	80024478 <exec+0x2f6>
    800244e8:	de943823          	sd	s1,-528(s0)
    800244ec:	b771                	j	80024478 <exec+0x2f6>
  sz = sz1;
    800244ee:	df943823          	sd	s9,-528(s0)
  ep = 0;
    800244f2:	4a01                	li	s4,0
    800244f4:	b751                	j	80024478 <exec+0x2f6>
  sz = sz1;
    800244f6:	df943823          	sd	s9,-528(s0)
  ep = 0;
    800244fa:	4a01                	li	s4,0
    800244fc:	bfb5                	j	80024478 <exec+0x2f6>
  sz = sz1;
    800244fe:	df943823          	sd	s9,-528(s0)
  ep = 0;
    80024502:	4a01                	li	s4,0
    80024504:	bf95                	j	80024478 <exec+0x2f6>
    if((sz1 = uvmalloc(pagetable, kpagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80024506:	df043483          	ld	s1,-528(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8002450a:	e0043783          	ld	a5,-512(s0)
    8002450e:	0017869b          	addiw	a3,a5,1
    80024512:	e0d43023          	sd	a3,-512(s0)
    80024516:	df843783          	ld	a5,-520(s0)
    8002451a:	0387879b          	addiw	a5,a5,56
    8002451e:	e8045703          	lhu	a4,-384(s0)
    80024522:	d8e6dfe3          	bge	a3,a4,800242c0 <exec+0x13e>
    if(eread(ep, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80024526:	2781                	sext.w	a5,a5
    80024528:	def43c23          	sd	a5,-520(s0)
    8002452c:	03800713          	li	a4,56
    80024530:	86be                	mv	a3,a5
    80024532:	e1040613          	addi	a2,s0,-496
    80024536:	4581                	li	a1,0
    80024538:	8552                	mv	a0,s4
    8002453a:	00001097          	auipc	ra,0x1
    8002453e:	664080e7          	jalr	1636(ra) # 80025b9e <eread>
    80024542:	03800793          	li	a5,56
    80024546:	f2f517e3          	bne	a0,a5,80024474 <exec+0x2f2>
    if(ph.type != ELF_PROG_LOAD)
    8002454a:	e1042783          	lw	a5,-496(s0)
    8002454e:	4705                	li	a4,1
    80024550:	fae79de3          	bne	a5,a4,8002450a <exec+0x388>
    if(ph.memsz < ph.filesz)
    80024554:	e3843683          	ld	a3,-456(s0)
    80024558:	e3043783          	ld	a5,-464(s0)
    8002455c:	f8f6e0e3          	bltu	a3,a5,800244dc <exec+0x35a>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80024560:	e2043783          	ld	a5,-480(s0)
    80024564:	96be                	add	a3,a3,a5
    80024566:	f6f6eee3          	bltu	a3,a5,800244e2 <exec+0x360>
    if((sz1 = uvmalloc(pagetable, kpagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8002456a:	8626                	mv	a2,s1
    8002456c:	85d6                	mv	a1,s5
    8002456e:	e0843503          	ld	a0,-504(s0)
    80024572:	ffffd097          	auipc	ra,0xffffd
    80024576:	bb2080e7          	jalr	-1102(ra) # 80021124 <uvmalloc>
    8002457a:	dea43823          	sd	a0,-528(s0)
    8002457e:	d52d                	beqz	a0,800244e8 <exec+0x366>
    if(ph.vaddr % PGSIZE != 0)
    80024580:	e2043c03          	ld	s8,-480(s0)
    80024584:	dd843783          	ld	a5,-552(s0)
    80024588:	00fc77b3          	and	a5,s8,a5
    8002458c:	ee0796e3          	bnez	a5,80024478 <exec+0x2f6>
    if(loadseg(pagetable, ph.vaddr, ep, ph.off, ph.filesz) < 0)
    80024590:	e1842c83          	lw	s9,-488(s0)
    80024594:	e3042b83          	lw	s7,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80024598:	f60b87e3          	beqz	s7,80024506 <exec+0x384>
    8002459c:	895e                	mv	s2,s7
    8002459e:	4481                	li	s1,0
    800245a0:	b9f5                	j	8002429c <exec+0x11a>
    kvmfree(kpagetable, 0);
    800245a2:	4581                	li	a1,0
    800245a4:	8556                	mv	a0,s5
    800245a6:	ffffd097          	auipc	ra,0xffffd
    800245aa:	200080e7          	jalr	512(ra) # 800217a6 <kvmfree>
  return -1;
    800245ae:	557d                	li	a0,-1
    800245b0:	b701                	j	800244b0 <exec+0x32e>

00000000800245b2 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    800245b2:	7179                	addi	sp,sp,-48
    800245b4:	f406                	sd	ra,40(sp)
    800245b6:	f022                	sd	s0,32(sp)
    800245b8:	ec26                	sd	s1,24(sp)
    800245ba:	e84a                	sd	s2,16(sp)
    800245bc:	1800                	addi	s0,sp,48
    800245be:	892e                	mv	s2,a1
    800245c0:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    800245c2:	fdc40593          	addi	a1,s0,-36
    800245c6:	fffff097          	auipc	ra,0xfffff
    800245ca:	9e4080e7          	jalr	-1564(ra) # 80022faa <argint>
    800245ce:	04054063          	bltz	a0,8002460e <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == NULL)
    800245d2:	fdc42703          	lw	a4,-36(s0)
    800245d6:	47bd                	li	a5,15
    800245d8:	02e7ed63          	bltu	a5,a4,80024612 <argfd+0x60>
    800245dc:	ffffd097          	auipc	ra,0xffffd
    800245e0:	5a6080e7          	jalr	1446(ra) # 80021b82 <myproc>
    800245e4:	fdc42703          	lw	a4,-36(s0)
    800245e8:	01a70793          	addi	a5,a4,26
    800245ec:	078e                	slli	a5,a5,0x3
    800245ee:	953e                	add	a0,a0,a5
    800245f0:	651c                	ld	a5,8(a0)
    800245f2:	c395                	beqz	a5,80024616 <argfd+0x64>
    return -1;
  if(pfd)
    800245f4:	00090463          	beqz	s2,800245fc <argfd+0x4a>
    *pfd = fd;
    800245f8:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800245fc:	4501                	li	a0,0
  if(pf)
    800245fe:	c091                	beqz	s1,80024602 <argfd+0x50>
    *pf = f;
    80024600:	e09c                	sd	a5,0(s1)
}
    80024602:	70a2                	ld	ra,40(sp)
    80024604:	7402                	ld	s0,32(sp)
    80024606:	64e2                	ld	s1,24(sp)
    80024608:	6942                	ld	s2,16(sp)
    8002460a:	6145                	addi	sp,sp,48
    8002460c:	8082                	ret
    return -1;
    8002460e:	557d                	li	a0,-1
    80024610:	bfcd                	j	80024602 <argfd+0x50>
    return -1;
    80024612:	557d                	li	a0,-1
    80024614:	b7fd                	j	80024602 <argfd+0x50>
    80024616:	557d                	li	a0,-1
    80024618:	b7ed                	j	80024602 <argfd+0x50>

000000008002461a <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    8002461a:	1101                	addi	sp,sp,-32
    8002461c:	ec06                	sd	ra,24(sp)
    8002461e:	e822                	sd	s0,16(sp)
    80024620:	e426                	sd	s1,8(sp)
    80024622:	1000                	addi	s0,sp,32
    80024624:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80024626:	ffffd097          	auipc	ra,0xffffd
    8002462a:	55c080e7          	jalr	1372(ra) # 80021b82 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(p->ofile[fd] == 0){
    8002462e:	6d7c                	ld	a5,216(a0)
    80024630:	c395                	beqz	a5,80024654 <fdalloc+0x3a>
    80024632:	0e050713          	addi	a4,a0,224
  for(fd = 0; fd < NOFILE; fd++){
    80024636:	4785                	li	a5,1
    80024638:	4641                	li	a2,16
    if(p->ofile[fd] == 0){
    8002463a:	6314                	ld	a3,0(a4)
    8002463c:	ce89                	beqz	a3,80024656 <fdalloc+0x3c>
  for(fd = 0; fd < NOFILE; fd++){
    8002463e:	2785                	addiw	a5,a5,1
    80024640:	0721                	addi	a4,a4,8
    80024642:	fec79ce3          	bne	a5,a2,8002463a <fdalloc+0x20>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80024646:	57fd                	li	a5,-1
}
    80024648:	853e                	mv	a0,a5
    8002464a:	60e2                	ld	ra,24(sp)
    8002464c:	6442                	ld	s0,16(sp)
    8002464e:	64a2                	ld	s1,8(sp)
    80024650:	6105                	addi	sp,sp,32
    80024652:	8082                	ret
  for(fd = 0; fd < NOFILE; fd++){
    80024654:	4781                	li	a5,0
      p->ofile[fd] = f;
    80024656:	01a78713          	addi	a4,a5,26
    8002465a:	070e                	slli	a4,a4,0x3
    8002465c:	953a                	add	a0,a0,a4
    8002465e:	e504                	sd	s1,8(a0)
      return fd;
    80024660:	b7e5                	j	80024648 <fdalloc+0x2e>

0000000080024662 <create>:
  return filestat(f, st);
}

static struct dirent*
create(char *path, short type, int mode)
{
    80024662:	7169                	addi	sp,sp,-304
    80024664:	f606                	sd	ra,296(sp)
    80024666:	f222                	sd	s0,288(sp)
    80024668:	ee26                	sd	s1,280(sp)
    8002466a:	ea4a                	sd	s2,272(sp)
    8002466c:	e64e                	sd	s3,264(sp)
    8002466e:	1a00                	addi	s0,sp,304
    80024670:	89ae                	mv	s3,a1
  struct dirent *ep, *dp;
  char name[FAT32_MAX_FILENAME + 1];

  if((dp = enameparent(path, name)) == NULL)
    80024672:	ed040593          	addi	a1,s0,-304
    80024676:	00002097          	auipc	ra,0x2
    8002467a:	5ba080e7          	jalr	1466(ra) # 80026c30 <enameparent>
    8002467e:	84aa                	mv	s1,a0
    80024680:	cd3d                	beqz	a0,800246fe <create+0x9c>
    return NULL;

  if (type == T_DIR) {
    80024682:	0009879b          	sext.w	a5,s3
    80024686:	4705                	li	a4,1
    80024688:	06e78d63          	beq	a5,a4,80024702 <create+0xa0>
    mode = ATTR_READ_ONLY;
  } else {
    mode = 0;  
  }

  elock(dp);
    8002468c:	00002097          	auipc	ra,0x2
    80024690:	de0080e7          	jalr	-544(ra) # 8002646c <elock>
  if ((ep = ealloc(dp, name, mode)) == NULL) {
    80024694:	4601                	li	a2,0
    80024696:	ed040593          	addi	a1,s0,-304
    8002469a:	8526                	mv	a0,s1
    8002469c:	00002097          	auipc	ra,0x2
    800246a0:	2b8080e7          	jalr	696(ra) # 80026954 <ealloc>
    800246a4:	892a                	mv	s2,a0
    800246a6:	c121                	beqz	a0,800246e6 <create+0x84>
    eunlock(dp);
    eput(dp);
    return NULL;
  }
  
  if ((type == T_DIR && !(ep->attribute & ATTR_DIRECTORY)) ||
    800246a8:	2981                	sext.w	s3,s3
    800246aa:	4789                	li	a5,2
    800246ac:	00f99663          	bne	s3,a5,800246b8 <create+0x56>
      (type == T_FILE && (ep->attribute & ATTR_DIRECTORY))) {
    800246b0:	10094783          	lbu	a5,256(s2)
    800246b4:	8bc1                	andi	a5,a5,16
    800246b6:	eba5                	bnez	a5,80024726 <create+0xc4>
    eput(ep);
    eput(dp);
    return NULL;
  }

  eunlock(dp);
    800246b8:	8526                	mv	a0,s1
    800246ba:	00002097          	auipc	ra,0x2
    800246be:	de8080e7          	jalr	-536(ra) # 800264a2 <eunlock>
  eput(dp);
    800246c2:	8526                	mv	a0,s1
    800246c4:	00002097          	auipc	ra,0x2
    800246c8:	e2c080e7          	jalr	-468(ra) # 800264f0 <eput>

  elock(ep);
    800246cc:	854a                	mv	a0,s2
    800246ce:	00002097          	auipc	ra,0x2
    800246d2:	d9e080e7          	jalr	-610(ra) # 8002646c <elock>
  return ep;
}
    800246d6:	854a                	mv	a0,s2
    800246d8:	70b2                	ld	ra,296(sp)
    800246da:	7412                	ld	s0,288(sp)
    800246dc:	64f2                	ld	s1,280(sp)
    800246de:	6952                	ld	s2,272(sp)
    800246e0:	69b2                	ld	s3,264(sp)
    800246e2:	6155                	addi	sp,sp,304
    800246e4:	8082                	ret
    eunlock(dp);
    800246e6:	8526                	mv	a0,s1
    800246e8:	00002097          	auipc	ra,0x2
    800246ec:	dba080e7          	jalr	-582(ra) # 800264a2 <eunlock>
    eput(dp);
    800246f0:	8526                	mv	a0,s1
    800246f2:	00002097          	auipc	ra,0x2
    800246f6:	dfe080e7          	jalr	-514(ra) # 800264f0 <eput>
    return NULL;
    800246fa:	4901                	li	s2,0
    800246fc:	bfe9                	j	800246d6 <create+0x74>
    return NULL;
    800246fe:	892a                	mv	s2,a0
    80024700:	bfd9                	j	800246d6 <create+0x74>
  elock(dp);
    80024702:	00002097          	auipc	ra,0x2
    80024706:	d6a080e7          	jalr	-662(ra) # 8002646c <elock>
  if ((ep = ealloc(dp, name, mode)) == NULL) {
    8002470a:	4641                	li	a2,16
    8002470c:	ed040593          	addi	a1,s0,-304
    80024710:	8526                	mv	a0,s1
    80024712:	00002097          	auipc	ra,0x2
    80024716:	242080e7          	jalr	578(ra) # 80026954 <ealloc>
    8002471a:	892a                	mv	s2,a0
    8002471c:	d569                	beqz	a0,800246e6 <create+0x84>
  if ((type == T_DIR && !(ep->attribute & ATTR_DIRECTORY)) ||
    8002471e:	10094783          	lbu	a5,256(s2)
    80024722:	8bc1                	andi	a5,a5,16
    80024724:	fbd1                	bnez	a5,800246b8 <create+0x56>
    eunlock(dp);
    80024726:	8526                	mv	a0,s1
    80024728:	00002097          	auipc	ra,0x2
    8002472c:	d7a080e7          	jalr	-646(ra) # 800264a2 <eunlock>
    eput(ep);
    80024730:	854a                	mv	a0,s2
    80024732:	00002097          	auipc	ra,0x2
    80024736:	dbe080e7          	jalr	-578(ra) # 800264f0 <eput>
    eput(dp);
    8002473a:	8526                	mv	a0,s1
    8002473c:	00002097          	auipc	ra,0x2
    80024740:	db4080e7          	jalr	-588(ra) # 800264f0 <eput>
    return NULL;
    80024744:	4901                	li	s2,0
    80024746:	bf41                	j	800246d6 <create+0x74>

0000000080024748 <sys_dup>:
{
    80024748:	7179                	addi	sp,sp,-48
    8002474a:	f406                	sd	ra,40(sp)
    8002474c:	f022                	sd	s0,32(sp)
    8002474e:	ec26                	sd	s1,24(sp)
    80024750:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80024752:	fd840613          	addi	a2,s0,-40
    80024756:	4581                	li	a1,0
    80024758:	4501                	li	a0,0
    8002475a:	00000097          	auipc	ra,0x0
    8002475e:	e58080e7          	jalr	-424(ra) # 800245b2 <argfd>
    return -1;
    80024762:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80024764:	02054363          	bltz	a0,8002478a <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80024768:	fd843503          	ld	a0,-40(s0)
    8002476c:	00000097          	auipc	ra,0x0
    80024770:	eae080e7          	jalr	-338(ra) # 8002461a <fdalloc>
    80024774:	84aa                	mv	s1,a0
    return -1;
    80024776:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80024778:	00054963          	bltz	a0,8002478a <sys_dup+0x42>
  filedup(f);
    8002477c:	fd843503          	ld	a0,-40(s0)
    80024780:	fffff097          	auipc	ra,0xfffff
    80024784:	2d8080e7          	jalr	728(ra) # 80023a58 <filedup>
  return fd;
    80024788:	87a6                	mv	a5,s1
}
    8002478a:	853e                	mv	a0,a5
    8002478c:	70a2                	ld	ra,40(sp)
    8002478e:	7402                	ld	s0,32(sp)
    80024790:	64e2                	ld	s1,24(sp)
    80024792:	6145                	addi	sp,sp,48
    80024794:	8082                	ret

0000000080024796 <sys_read>:
{
    80024796:	7179                	addi	sp,sp,-48
    80024798:	f406                	sd	ra,40(sp)
    8002479a:	f022                	sd	s0,32(sp)
    8002479c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002479e:	fe840613          	addi	a2,s0,-24
    800247a2:	4581                	li	a1,0
    800247a4:	4501                	li	a0,0
    800247a6:	00000097          	auipc	ra,0x0
    800247aa:	e0c080e7          	jalr	-500(ra) # 800245b2 <argfd>
    return -1;
    800247ae:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800247b0:	04054163          	bltz	a0,800247f2 <sys_read+0x5c>
    800247b4:	fe440593          	addi	a1,s0,-28
    800247b8:	4509                	li	a0,2
    800247ba:	ffffe097          	auipc	ra,0xffffe
    800247be:	7f0080e7          	jalr	2032(ra) # 80022faa <argint>
    return -1;
    800247c2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800247c4:	02054763          	bltz	a0,800247f2 <sys_read+0x5c>
    800247c8:	fd840593          	addi	a1,s0,-40
    800247cc:	4505                	li	a0,1
    800247ce:	fffff097          	auipc	ra,0xfffff
    800247d2:	83e080e7          	jalr	-1986(ra) # 8002300c <argaddr>
    return -1;
    800247d6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800247d8:	00054d63          	bltz	a0,800247f2 <sys_read+0x5c>
  return fileread(f, p, n);
    800247dc:	fe442603          	lw	a2,-28(s0)
    800247e0:	fd843583          	ld	a1,-40(s0)
    800247e4:	fe843503          	ld	a0,-24(s0)
    800247e8:	fffff097          	auipc	ra,0xfffff
    800247ec:	3d8080e7          	jalr	984(ra) # 80023bc0 <fileread>
    800247f0:	87aa                	mv	a5,a0
}
    800247f2:	853e                	mv	a0,a5
    800247f4:	70a2                	ld	ra,40(sp)
    800247f6:	7402                	ld	s0,32(sp)
    800247f8:	6145                	addi	sp,sp,48
    800247fa:	8082                	ret

00000000800247fc <sys_write>:
{
    800247fc:	7179                	addi	sp,sp,-48
    800247fe:	f406                	sd	ra,40(sp)
    80024800:	f022                	sd	s0,32(sp)
    80024802:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80024804:	fe840613          	addi	a2,s0,-24
    80024808:	4581                	li	a1,0
    8002480a:	4501                	li	a0,0
    8002480c:	00000097          	auipc	ra,0x0
    80024810:	da6080e7          	jalr	-602(ra) # 800245b2 <argfd>
    return -1;
    80024814:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80024816:	04054163          	bltz	a0,80024858 <sys_write+0x5c>
    8002481a:	fe440593          	addi	a1,s0,-28
    8002481e:	4509                	li	a0,2
    80024820:	ffffe097          	auipc	ra,0xffffe
    80024824:	78a080e7          	jalr	1930(ra) # 80022faa <argint>
    return -1;
    80024828:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002482a:	02054763          	bltz	a0,80024858 <sys_write+0x5c>
    8002482e:	fd840593          	addi	a1,s0,-40
    80024832:	4505                	li	a0,1
    80024834:	ffffe097          	auipc	ra,0xffffe
    80024838:	7d8080e7          	jalr	2008(ra) # 8002300c <argaddr>
    return -1;
    8002483c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002483e:	00054d63          	bltz	a0,80024858 <sys_write+0x5c>
  return filewrite(f, p, n);
    80024842:	fe442603          	lw	a2,-28(s0)
    80024846:	fd843583          	ld	a1,-40(s0)
    8002484a:	fe843503          	ld	a0,-24(s0)
    8002484e:	fffff097          	auipc	ra,0xfffff
    80024852:	434080e7          	jalr	1076(ra) # 80023c82 <filewrite>
    80024856:	87aa                	mv	a5,a0
}
    80024858:	853e                	mv	a0,a5
    8002485a:	70a2                	ld	ra,40(sp)
    8002485c:	7402                	ld	s0,32(sp)
    8002485e:	6145                	addi	sp,sp,48
    80024860:	8082                	ret

0000000080024862 <sys_close>:
{
    80024862:	1101                	addi	sp,sp,-32
    80024864:	ec06                	sd	ra,24(sp)
    80024866:	e822                	sd	s0,16(sp)
    80024868:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    8002486a:	fe040613          	addi	a2,s0,-32
    8002486e:	fec40593          	addi	a1,s0,-20
    80024872:	4501                	li	a0,0
    80024874:	00000097          	auipc	ra,0x0
    80024878:	d3e080e7          	jalr	-706(ra) # 800245b2 <argfd>
    return -1;
    8002487c:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    8002487e:	02054463          	bltz	a0,800248a6 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80024882:	ffffd097          	auipc	ra,0xffffd
    80024886:	300080e7          	jalr	768(ra) # 80021b82 <myproc>
    8002488a:	fec42783          	lw	a5,-20(s0)
    8002488e:	07e9                	addi	a5,a5,26
    80024890:	078e                	slli	a5,a5,0x3
    80024892:	953e                	add	a0,a0,a5
    80024894:	00053423          	sd	zero,8(a0)
  fileclose(f);
    80024898:	fe043503          	ld	a0,-32(s0)
    8002489c:	fffff097          	auipc	ra,0xfffff
    800248a0:	20e080e7          	jalr	526(ra) # 80023aaa <fileclose>
  return 0;
    800248a4:	4781                	li	a5,0
}
    800248a6:	853e                	mv	a0,a5
    800248a8:	60e2                	ld	ra,24(sp)
    800248aa:	6442                	ld	s0,16(sp)
    800248ac:	6105                	addi	sp,sp,32
    800248ae:	8082                	ret

00000000800248b0 <sys_fstat>:
{
    800248b0:	1101                	addi	sp,sp,-32
    800248b2:	ec06                	sd	ra,24(sp)
    800248b4:	e822                	sd	s0,16(sp)
    800248b6:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800248b8:	fe840613          	addi	a2,s0,-24
    800248bc:	4581                	li	a1,0
    800248be:	4501                	li	a0,0
    800248c0:	00000097          	auipc	ra,0x0
    800248c4:	cf2080e7          	jalr	-782(ra) # 800245b2 <argfd>
    return -1;
    800248c8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800248ca:	02054563          	bltz	a0,800248f4 <sys_fstat+0x44>
    800248ce:	fe040593          	addi	a1,s0,-32
    800248d2:	4505                	li	a0,1
    800248d4:	ffffe097          	auipc	ra,0xffffe
    800248d8:	738080e7          	jalr	1848(ra) # 8002300c <argaddr>
    return -1;
    800248dc:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800248de:	00054b63          	bltz	a0,800248f4 <sys_fstat+0x44>
  return filestat(f, st);
    800248e2:	fe043583          	ld	a1,-32(s0)
    800248e6:	fe843503          	ld	a0,-24(s0)
    800248ea:	fffff097          	auipc	ra,0xfffff
    800248ee:	276080e7          	jalr	630(ra) # 80023b60 <filestat>
    800248f2:	87aa                	mv	a5,a0
}
    800248f4:	853e                	mv	a0,a5
    800248f6:	60e2                	ld	ra,24(sp)
    800248f8:	6442                	ld	s0,16(sp)
    800248fa:	6105                	addi	sp,sp,32
    800248fc:	8082                	ret

00000000800248fe <sys_open>:

uint64
sys_open(void)
{
    800248fe:	7129                	addi	sp,sp,-320
    80024900:	fe06                	sd	ra,312(sp)
    80024902:	fa22                	sd	s0,304(sp)
    80024904:	f626                	sd	s1,296(sp)
    80024906:	f24a                	sd	s2,288(sp)
    80024908:	ee4e                	sd	s3,280(sp)
    8002490a:	0280                	addi	s0,sp,320
  char path[FAT32_MAX_PATH];
  int fd, omode;
  struct file *f;
  struct dirent *ep;

  if(argstr(1, path, FAT32_MAX_PATH) < 0 || argint(2, &omode) < 0)
    8002490c:	10400613          	li	a2,260
    80024910:	ec840593          	addi	a1,s0,-312
    80024914:	4505                	li	a0,1
    80024916:	ffffe097          	auipc	ra,0xffffe
    8002491a:	718080e7          	jalr	1816(ra) # 8002302e <argstr>
    return -1;
    8002491e:	54fd                	li	s1,-1
  if(argstr(1, path, FAT32_MAX_PATH) < 0 || argint(2, &omode) < 0)
    80024920:	08054d63          	bltz	a0,800249ba <sys_open+0xbc>
    80024924:	ec440593          	addi	a1,s0,-316
    80024928:	4509                	li	a0,2
    8002492a:	ffffe097          	auipc	ra,0xffffe
    8002492e:	680080e7          	jalr	1664(ra) # 80022faa <argint>
    80024932:	0e054163          	bltz	a0,80024a14 <sys_open+0x116>

  if(omode & O_CREATE){
    80024936:	ec442603          	lw	a2,-316(s0)
    8002493a:	20067793          	andi	a5,a2,512
    8002493e:	c7d1                	beqz	a5,800249ca <sys_open+0xcc>
    ep = create(path, T_FILE, omode);
    80024940:	4589                	li	a1,2
    80024942:	ec840513          	addi	a0,s0,-312
    80024946:	00000097          	auipc	ra,0x0
    8002494a:	d1c080e7          	jalr	-740(ra) # 80024662 <create>
    8002494e:	892a                	mv	s2,a0
    if(ep == NULL){
    80024950:	c561                	beqz	a0,80024a18 <sys_open+0x11a>
      eput(ep);
      return -1;
    }
  }

  if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    80024952:	fffff097          	auipc	ra,0xfffff
    80024956:	088080e7          	jalr	136(ra) # 800239da <filealloc>
    8002495a:	89aa                	mv	s3,a0
    8002495c:	c579                	beqz	a0,80024a2a <sys_open+0x12c>
    8002495e:	00000097          	auipc	ra,0x0
    80024962:	cbc080e7          	jalr	-836(ra) # 8002461a <fdalloc>
    80024966:	84aa                	mv	s1,a0
    80024968:	0a054c63          	bltz	a0,80024a20 <sys_open+0x122>
    eunlock(ep);
    eput(ep);
    return -1;
  }

  if(!(ep->attribute & ATTR_DIRECTORY) && (omode & O_TRUNC)){
    8002496c:	10094783          	lbu	a5,256(s2)
    80024970:	8bc1                	andi	a5,a5,16
    80024972:	e791                	bnez	a5,8002497e <sys_open+0x80>
    80024974:	ec442783          	lw	a5,-316(s0)
    80024978:	4007f793          	andi	a5,a5,1024
    8002497c:	e7d1                	bnez	a5,80024a08 <sys_open+0x10a>
    etrunc(ep);
  }

  f->type = FD_ENTRY;
    8002497e:	4789                	li	a5,2
    80024980:	00f9a023          	sw	a5,0(s3)
  f->off = (omode & O_APPEND) ? ep->file_size : 0;
    80024984:	ec442783          	lw	a5,-316(s0)
    80024988:	0047f693          	andi	a3,a5,4
    8002498c:	4701                	li	a4,0
    8002498e:	c299                	beqz	a3,80024994 <sys_open+0x96>
    80024990:	10892703          	lw	a4,264(s2)
    80024994:	02e9a023          	sw	a4,32(s3)
  f->ep = ep;
    80024998:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    8002499c:	0017c713          	xori	a4,a5,1
    800249a0:	8b05                	andi	a4,a4,1
    800249a2:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    800249a6:	8b8d                	andi	a5,a5,3
    800249a8:	00f037b3          	snez	a5,a5
    800249ac:	00f984a3          	sb	a5,9(s3)

  eunlock(ep);
    800249b0:	854a                	mv	a0,s2
    800249b2:	00002097          	auipc	ra,0x2
    800249b6:	af0080e7          	jalr	-1296(ra) # 800264a2 <eunlock>

  return fd;
}
    800249ba:	8526                	mv	a0,s1
    800249bc:	70f2                	ld	ra,312(sp)
    800249be:	7452                	ld	s0,304(sp)
    800249c0:	74b2                	ld	s1,296(sp)
    800249c2:	7912                	ld	s2,288(sp)
    800249c4:	69f2                	ld	s3,280(sp)
    800249c6:	6131                	addi	sp,sp,320
    800249c8:	8082                	ret
    if((ep = ename(path)) == NULL){
    800249ca:	ec840513          	addi	a0,s0,-312
    800249ce:	00002097          	auipc	ra,0x2
    800249d2:	244080e7          	jalr	580(ra) # 80026c12 <ename>
    800249d6:	892a                	mv	s2,a0
    800249d8:	c131                	beqz	a0,80024a1c <sys_open+0x11e>
    elock(ep);
    800249da:	00002097          	auipc	ra,0x2
    800249de:	a92080e7          	jalr	-1390(ra) # 8002646c <elock>
    if((ep->attribute & ATTR_DIRECTORY) && omode != O_RDONLY){
    800249e2:	10094783          	lbu	a5,256(s2)
    800249e6:	8bc1                	andi	a5,a5,16
    800249e8:	d7ad                	beqz	a5,80024952 <sys_open+0x54>
    800249ea:	ec442783          	lw	a5,-316(s0)
    800249ee:	d3b5                	beqz	a5,80024952 <sys_open+0x54>
      eunlock(ep);
    800249f0:	854a                	mv	a0,s2
    800249f2:	00002097          	auipc	ra,0x2
    800249f6:	ab0080e7          	jalr	-1360(ra) # 800264a2 <eunlock>
      eput(ep);
    800249fa:	854a                	mv	a0,s2
    800249fc:	00002097          	auipc	ra,0x2
    80024a00:	af4080e7          	jalr	-1292(ra) # 800264f0 <eput>
      return -1;
    80024a04:	54fd                	li	s1,-1
    80024a06:	bf55                	j	800249ba <sys_open+0xbc>
    etrunc(ep);
    80024a08:	854a                	mv	a0,s2
    80024a0a:	00002097          	auipc	ra,0x2
    80024a0e:	9fa080e7          	jalr	-1542(ra) # 80026404 <etrunc>
    80024a12:	b7b5                	j	8002497e <sys_open+0x80>
    return -1;
    80024a14:	54fd                	li	s1,-1
    80024a16:	b755                	j	800249ba <sys_open+0xbc>
      return -1;
    80024a18:	54fd                	li	s1,-1
    80024a1a:	b745                	j	800249ba <sys_open+0xbc>
      return -1;
    80024a1c:	54fd                	li	s1,-1
    80024a1e:	bf71                	j	800249ba <sys_open+0xbc>
      fileclose(f);
    80024a20:	854e                	mv	a0,s3
    80024a22:	fffff097          	auipc	ra,0xfffff
    80024a26:	088080e7          	jalr	136(ra) # 80023aaa <fileclose>
    eunlock(ep);
    80024a2a:	854a                	mv	a0,s2
    80024a2c:	00002097          	auipc	ra,0x2
    80024a30:	a76080e7          	jalr	-1418(ra) # 800264a2 <eunlock>
    eput(ep);
    80024a34:	854a                	mv	a0,s2
    80024a36:	00002097          	auipc	ra,0x2
    80024a3a:	aba080e7          	jalr	-1350(ra) # 800264f0 <eput>
    return -1;
    80024a3e:	54fd                	li	s1,-1
    80024a40:	bfad                	j	800249ba <sys_open+0xbc>

0000000080024a42 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80024a42:	7169                	addi	sp,sp,-304
    80024a44:	f606                	sd	ra,296(sp)
    80024a46:	f222                	sd	s0,288(sp)
    80024a48:	ee26                	sd	s1,280(sp)
    80024a4a:	1a00                	addi	s0,sp,304
  char path[FAT32_MAX_PATH];
  struct dirent *ep;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR, 0)) == 0){
    80024a4c:	10400613          	li	a2,260
    80024a50:	ed840593          	addi	a1,s0,-296
    80024a54:	4501                	li	a0,0
    80024a56:	ffffe097          	auipc	ra,0xffffe
    80024a5a:	5d8080e7          	jalr	1496(ra) # 8002302e <argstr>
    return -1;
    80024a5e:	57fd                	li	a5,-1
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR, 0)) == 0){
    80024a60:	02054663          	bltz	a0,80024a8c <sys_mkdir+0x4a>
    80024a64:	4601                	li	a2,0
    80024a66:	4585                	li	a1,1
    80024a68:	ed840513          	addi	a0,s0,-296
    80024a6c:	00000097          	auipc	ra,0x0
    80024a70:	bf6080e7          	jalr	-1034(ra) # 80024662 <create>
    80024a74:	84aa                	mv	s1,a0
    80024a76:	c10d                	beqz	a0,80024a98 <sys_mkdir+0x56>
  }
  eunlock(ep);
    80024a78:	00002097          	auipc	ra,0x2
    80024a7c:	a2a080e7          	jalr	-1494(ra) # 800264a2 <eunlock>
  eput(ep);
    80024a80:	8526                	mv	a0,s1
    80024a82:	00002097          	auipc	ra,0x2
    80024a86:	a6e080e7          	jalr	-1426(ra) # 800264f0 <eput>
  return 0;
    80024a8a:	4781                	li	a5,0
}
    80024a8c:	853e                	mv	a0,a5
    80024a8e:	70b2                	ld	ra,296(sp)
    80024a90:	7412                	ld	s0,288(sp)
    80024a92:	64f2                	ld	s1,280(sp)
    80024a94:	6155                	addi	sp,sp,304
    80024a96:	8082                	ret
    return -1;
    80024a98:	57fd                	li	a5,-1
    80024a9a:	bfcd                	j	80024a8c <sys_mkdir+0x4a>

0000000080024a9c <sys_chdir>:

uint64
sys_chdir(void)
{
    80024a9c:	7169                	addi	sp,sp,-304
    80024a9e:	f606                	sd	ra,296(sp)
    80024aa0:	f222                	sd	s0,288(sp)
    80024aa2:	ee26                	sd	s1,280(sp)
    80024aa4:	ea4a                	sd	s2,272(sp)
    80024aa6:	1a00                	addi	s0,sp,304
  char path[FAT32_MAX_PATH];
  struct dirent *ep;
  struct proc *p = myproc();
    80024aa8:	ffffd097          	auipc	ra,0xffffd
    80024aac:	0da080e7          	jalr	218(ra) # 80021b82 <myproc>
    80024ab0:	892a                	mv	s2,a0
  
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = ename(path)) == NULL){
    80024ab2:	10400613          	li	a2,260
    80024ab6:	ed840593          	addi	a1,s0,-296
    80024aba:	4501                	li	a0,0
    80024abc:	ffffe097          	auipc	ra,0xffffe
    80024ac0:	572080e7          	jalr	1394(ra) # 8002302e <argstr>
    return -1;
    80024ac4:	57fd                	li	a5,-1
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = ename(path)) == NULL){
    80024ac6:	04054063          	bltz	a0,80024b06 <sys_chdir+0x6a>
    80024aca:	ed840513          	addi	a0,s0,-296
    80024ace:	00002097          	auipc	ra,0x2
    80024ad2:	144080e7          	jalr	324(ra) # 80026c12 <ename>
    80024ad6:	84aa                	mv	s1,a0
    80024ad8:	c931                	beqz	a0,80024b2c <sys_chdir+0x90>
  }
  elock(ep);
    80024ada:	00002097          	auipc	ra,0x2
    80024ade:	992080e7          	jalr	-1646(ra) # 8002646c <elock>
  if(!(ep->attribute & ATTR_DIRECTORY)){
    80024ae2:	1004c783          	lbu	a5,256(s1)
    80024ae6:	8bc1                	andi	a5,a5,16
    80024ae8:	c795                	beqz	a5,80024b14 <sys_chdir+0x78>
    eunlock(ep);
    eput(ep);
    return -1;
  }
  eunlock(ep);
    80024aea:	8526                	mv	a0,s1
    80024aec:	00002097          	auipc	ra,0x2
    80024af0:	9b6080e7          	jalr	-1610(ra) # 800264a2 <eunlock>
  eput(p->cwd);
    80024af4:	15893503          	ld	a0,344(s2)
    80024af8:	00002097          	auipc	ra,0x2
    80024afc:	9f8080e7          	jalr	-1544(ra) # 800264f0 <eput>
  p->cwd = ep;
    80024b00:	14993c23          	sd	s1,344(s2)
  return 0;
    80024b04:	4781                	li	a5,0
}
    80024b06:	853e                	mv	a0,a5
    80024b08:	70b2                	ld	ra,296(sp)
    80024b0a:	7412                	ld	s0,288(sp)
    80024b0c:	64f2                	ld	s1,280(sp)
    80024b0e:	6952                	ld	s2,272(sp)
    80024b10:	6155                	addi	sp,sp,304
    80024b12:	8082                	ret
    eunlock(ep);
    80024b14:	8526                	mv	a0,s1
    80024b16:	00002097          	auipc	ra,0x2
    80024b1a:	98c080e7          	jalr	-1652(ra) # 800264a2 <eunlock>
    eput(ep);
    80024b1e:	8526                	mv	a0,s1
    80024b20:	00002097          	auipc	ra,0x2
    80024b24:	9d0080e7          	jalr	-1584(ra) # 800264f0 <eput>
    return -1;
    80024b28:	57fd                	li	a5,-1
    80024b2a:	bff1                	j	80024b06 <sys_chdir+0x6a>
    return -1;
    80024b2c:	57fd                	li	a5,-1
    80024b2e:	bfe1                	j	80024b06 <sys_chdir+0x6a>

0000000080024b30 <sys_pipe>:

uint64
sys_pipe(void)
{
    80024b30:	7139                	addi	sp,sp,-64
    80024b32:	fc06                	sd	ra,56(sp)
    80024b34:	f822                	sd	s0,48(sp)
    80024b36:	f426                	sd	s1,40(sp)
    80024b38:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80024b3a:	ffffd097          	auipc	ra,0xffffd
    80024b3e:	048080e7          	jalr	72(ra) # 80021b82 <myproc>
    80024b42:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80024b44:	fd840593          	addi	a1,s0,-40
    80024b48:	4501                	li	a0,0
    80024b4a:	ffffe097          	auipc	ra,0xffffe
    80024b4e:	4c2080e7          	jalr	1218(ra) # 8002300c <argaddr>
    return -1;
    80024b52:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80024b54:	0c054d63          	bltz	a0,80024c2e <sys_pipe+0xfe>
  if(pipealloc(&rf, &wf) < 0)
    80024b58:	fc840593          	addi	a1,s0,-56
    80024b5c:	fd040513          	addi	a0,s0,-48
    80024b60:	fffff097          	auipc	ra,0xfffff
    80024b64:	2b2080e7          	jalr	690(ra) # 80023e12 <pipealloc>
    return -1;
    80024b68:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80024b6a:	0c054263          	bltz	a0,80024c2e <sys_pipe+0xfe>
  fd0 = -1;
    80024b6e:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80024b72:	fd043503          	ld	a0,-48(s0)
    80024b76:	00000097          	auipc	ra,0x0
    80024b7a:	aa4080e7          	jalr	-1372(ra) # 8002461a <fdalloc>
    80024b7e:	fca42223          	sw	a0,-60(s0)
    80024b82:	08054963          	bltz	a0,80024c14 <sys_pipe+0xe4>
    80024b86:	fc843503          	ld	a0,-56(s0)
    80024b8a:	00000097          	auipc	ra,0x0
    80024b8e:	a90080e7          	jalr	-1392(ra) # 8002461a <fdalloc>
    80024b92:	fca42023          	sw	a0,-64(s0)
    80024b96:	06054663          	bltz	a0,80024c02 <sys_pipe+0xd2>
    fileclose(wf);
    return -1;
  }
  // if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
  //    copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
  if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80024b9a:	4611                	li	a2,4
    80024b9c:	fc440593          	addi	a1,s0,-60
    80024ba0:	fd843503          	ld	a0,-40(s0)
    80024ba4:	ffffd097          	auipc	ra,0xffffd
    80024ba8:	8e4080e7          	jalr	-1820(ra) # 80021488 <copyout2>
    80024bac:	00054f63          	bltz	a0,80024bca <sys_pipe+0x9a>
     copyout2(fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80024bb0:	4611                	li	a2,4
    80024bb2:	fc040593          	addi	a1,s0,-64
    80024bb6:	fd843503          	ld	a0,-40(s0)
    80024bba:	0511                	addi	a0,a0,4
    80024bbc:	ffffd097          	auipc	ra,0xffffd
    80024bc0:	8cc080e7          	jalr	-1844(ra) # 80021488 <copyout2>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80024bc4:	4781                	li	a5,0
  if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80024bc6:	06055463          	bgez	a0,80024c2e <sys_pipe+0xfe>
    p->ofile[fd0] = 0;
    80024bca:	fc442783          	lw	a5,-60(s0)
    80024bce:	07e9                	addi	a5,a5,26
    80024bd0:	078e                	slli	a5,a5,0x3
    80024bd2:	97a6                	add	a5,a5,s1
    80024bd4:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80024bd8:	fc042783          	lw	a5,-64(s0)
    80024bdc:	07e9                	addi	a5,a5,26
    80024bde:	078e                	slli	a5,a5,0x3
    80024be0:	94be                	add	s1,s1,a5
    80024be2:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80024be6:	fd043503          	ld	a0,-48(s0)
    80024bea:	fffff097          	auipc	ra,0xfffff
    80024bee:	ec0080e7          	jalr	-320(ra) # 80023aaa <fileclose>
    fileclose(wf);
    80024bf2:	fc843503          	ld	a0,-56(s0)
    80024bf6:	fffff097          	auipc	ra,0xfffff
    80024bfa:	eb4080e7          	jalr	-332(ra) # 80023aaa <fileclose>
    return -1;
    80024bfe:	57fd                	li	a5,-1
    80024c00:	a03d                	j	80024c2e <sys_pipe+0xfe>
    if(fd0 >= 0)
    80024c02:	fc442783          	lw	a5,-60(s0)
    80024c06:	0007c763          	bltz	a5,80024c14 <sys_pipe+0xe4>
      p->ofile[fd0] = 0;
    80024c0a:	07e9                	addi	a5,a5,26
    80024c0c:	078e                	slli	a5,a5,0x3
    80024c0e:	94be                	add	s1,s1,a5
    80024c10:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80024c14:	fd043503          	ld	a0,-48(s0)
    80024c18:	fffff097          	auipc	ra,0xfffff
    80024c1c:	e92080e7          	jalr	-366(ra) # 80023aaa <fileclose>
    fileclose(wf);
    80024c20:	fc843503          	ld	a0,-56(s0)
    80024c24:	fffff097          	auipc	ra,0xfffff
    80024c28:	e86080e7          	jalr	-378(ra) # 80023aaa <fileclose>
    return -1;
    80024c2c:	57fd                	li	a5,-1
}
    80024c2e:	853e                	mv	a0,a5
    80024c30:	70e2                	ld	ra,56(sp)
    80024c32:	7442                	ld	s0,48(sp)
    80024c34:	74a2                	ld	s1,40(sp)
    80024c36:	6121                	addi	sp,sp,64
    80024c38:	8082                	ret

0000000080024c3a <sys_dev>:

// To open console device.
uint64
sys_dev(void)
{
    80024c3a:	7179                	addi	sp,sp,-48
    80024c3c:	f406                	sd	ra,40(sp)
    80024c3e:	f022                	sd	s0,32(sp)
    80024c40:	ec26                	sd	s1,24(sp)
    80024c42:	1800                	addi	s0,sp,48
  int fd, omode;
  int major, minor;
  struct file *f;

  if(argint(0, &omode) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0){
    80024c44:	fdc40593          	addi	a1,s0,-36
    80024c48:	4501                	li	a0,0
    80024c4a:	ffffe097          	auipc	ra,0xffffe
    80024c4e:	360080e7          	jalr	864(ra) # 80022faa <argint>
    80024c52:	08054a63          	bltz	a0,80024ce6 <sys_dev+0xac>
    80024c56:	fd840593          	addi	a1,s0,-40
    80024c5a:	4505                	li	a0,1
    80024c5c:	ffffe097          	auipc	ra,0xffffe
    80024c60:	34e080e7          	jalr	846(ra) # 80022faa <argint>
    80024c64:	08054763          	bltz	a0,80024cf2 <sys_dev+0xb8>
    80024c68:	fd440593          	addi	a1,s0,-44
    80024c6c:	4509                	li	a0,2
    80024c6e:	ffffe097          	auipc	ra,0xffffe
    80024c72:	33c080e7          	jalr	828(ra) # 80022faa <argint>
    80024c76:	08054063          	bltz	a0,80024cf6 <sys_dev+0xbc>
    return -1;
  }

  if(omode & O_CREATE){
    80024c7a:	fdc42783          	lw	a5,-36(s0)
    80024c7e:	2007f793          	andi	a5,a5,512
    80024c82:	ebb1                	bnez	a5,80024cd6 <sys_dev+0x9c>
    panic("dev file on FAT");
  }

  if(major < 0 || major >= NDEV)
    80024c84:	fd842703          	lw	a4,-40(s0)
    80024c88:	47a5                	li	a5,9
    return -1;
    80024c8a:	557d                	li	a0,-1
  if(major < 0 || major >= NDEV)
    80024c8c:	04e7ee63          	bltu	a5,a4,80024ce8 <sys_dev+0xae>

  if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    80024c90:	fffff097          	auipc	ra,0xfffff
    80024c94:	d4a080e7          	jalr	-694(ra) # 800239da <filealloc>
    80024c98:	84aa                	mv	s1,a0
    80024c9a:	c125                	beqz	a0,80024cfa <sys_dev+0xc0>
    80024c9c:	00000097          	auipc	ra,0x0
    80024ca0:	97e080e7          	jalr	-1666(ra) # 8002461a <fdalloc>
    80024ca4:	04054d63          	bltz	a0,80024cfe <sys_dev+0xc4>
    if(f)
      fileclose(f);
    return -1;
  }

  f->type = FD_DEVICE;
    80024ca8:	478d                	li	a5,3
    80024caa:	c09c                	sw	a5,0(s1)
  f->off = 0;
    80024cac:	0204a023          	sw	zero,32(s1)
  f->ep = 0;
    80024cb0:	0004bc23          	sd	zero,24(s1)
  f->major = major;
    80024cb4:	fd842783          	lw	a5,-40(s0)
    80024cb8:	02f49223          	sh	a5,36(s1)
  f->readable = !(omode & O_WRONLY);
    80024cbc:	fdc42783          	lw	a5,-36(s0)
    80024cc0:	0017c713          	xori	a4,a5,1
    80024cc4:	8b05                	andi	a4,a4,1
    80024cc6:	00e48423          	sb	a4,8(s1)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80024cca:	8b8d                	andi	a5,a5,3
    80024ccc:	00f037b3          	snez	a5,a5
    80024cd0:	00f484a3          	sb	a5,9(s1)

  return fd;
    80024cd4:	a811                	j	80024ce8 <sys_dev+0xae>
    panic("dev file on FAT");
    80024cd6:	00008517          	auipc	a0,0x8
    80024cda:	e0250513          	addi	a0,a0,-510 # 8002cad8 <syscalls+0xa20>
    80024cde:	ffffb097          	auipc	ra,0xffffb
    80024ce2:	468080e7          	jalr	1128(ra) # 80020146 <panic>
    return -1;
    80024ce6:	557d                	li	a0,-1
}
    80024ce8:	70a2                	ld	ra,40(sp)
    80024cea:	7402                	ld	s0,32(sp)
    80024cec:	64e2                	ld	s1,24(sp)
    80024cee:	6145                	addi	sp,sp,48
    80024cf0:	8082                	ret
    return -1;
    80024cf2:	557d                	li	a0,-1
    80024cf4:	bfd5                	j	80024ce8 <sys_dev+0xae>
    80024cf6:	557d                	li	a0,-1
    80024cf8:	bfc5                	j	80024ce8 <sys_dev+0xae>
    return -1;
    80024cfa:	557d                	li	a0,-1
    80024cfc:	b7f5                	j	80024ce8 <sys_dev+0xae>
      fileclose(f);
    80024cfe:	8526                	mv	a0,s1
    80024d00:	fffff097          	auipc	ra,0xfffff
    80024d04:	daa080e7          	jalr	-598(ra) # 80023aaa <fileclose>
    return -1;
    80024d08:	557d                	li	a0,-1
    80024d0a:	bff9                	j	80024ce8 <sys_dev+0xae>

0000000080024d0c <sys_readdir>:

// To support ls command
uint64
sys_readdir(void)
{
    80024d0c:	1101                	addi	sp,sp,-32
    80024d0e:	ec06                	sd	ra,24(sp)
    80024d10:	e822                	sd	s0,16(sp)
    80024d12:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024d14:	fe840613          	addi	a2,s0,-24
    80024d18:	4581                	li	a1,0
    80024d1a:	4501                	li	a0,0
    80024d1c:	00000097          	auipc	ra,0x0
    80024d20:	896080e7          	jalr	-1898(ra) # 800245b2 <argfd>
    return -1;
    80024d24:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024d26:	02054563          	bltz	a0,80024d50 <sys_readdir+0x44>
    80024d2a:	fe040593          	addi	a1,s0,-32
    80024d2e:	4505                	li	a0,1
    80024d30:	ffffe097          	auipc	ra,0xffffe
    80024d34:	2dc080e7          	jalr	732(ra) # 8002300c <argaddr>
    return -1;
    80024d38:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024d3a:	00054b63          	bltz	a0,80024d50 <sys_readdir+0x44>
  return dirnext(f, p);
    80024d3e:	fe043583          	ld	a1,-32(s0)
    80024d42:	fe843503          	ld	a0,-24(s0)
    80024d46:	fffff097          	auipc	ra,0xfffff
    80024d4a:	00e080e7          	jalr	14(ra) # 80023d54 <dirnext>
    80024d4e:	87aa                	mv	a5,a0
}
    80024d50:	853e                	mv	a0,a5
    80024d52:	60e2                	ld	ra,24(sp)
    80024d54:	6442                	ld	s0,16(sp)
    80024d56:	6105                	addi	sp,sp,32
    80024d58:	8082                	ret

0000000080024d5a <sys_getcwd>:

// get absolute cwd string
uint64
sys_getcwd(void)
{
    80024d5a:	714d                	addi	sp,sp,-336
    80024d5c:	e686                	sd	ra,328(sp)
    80024d5e:	e2a2                	sd	s0,320(sp)
    80024d60:	fe26                	sd	s1,312(sp)
    80024d62:	fa4a                	sd	s2,304(sp)
    80024d64:	f64e                	sd	s3,296(sp)
    80024d66:	f252                	sd	s4,288(sp)
    80024d68:	ee56                	sd	s5,280(sp)
    80024d6a:	0a80                	addi	s0,sp,336
  uint64 addr;
  if (argaddr(0, &addr) < 0)
    80024d6c:	fb840593          	addi	a1,s0,-72
    80024d70:	4501                	li	a0,0
    80024d72:	ffffe097          	auipc	ra,0xffffe
    80024d76:	29a080e7          	jalr	666(ra) # 8002300c <argaddr>
    return -1;
    80024d7a:	57fd                	li	a5,-1
  if (argaddr(0, &addr) < 0)
    80024d7c:	08054063          	bltz	a0,80024dfc <sys_getcwd+0xa2>

  struct dirent *de = myproc()->cwd;
    80024d80:	ffffd097          	auipc	ra,0xffffd
    80024d84:	e02080e7          	jalr	-510(ra) # 80021b82 <myproc>
    80024d88:	15853483          	ld	s1,344(a0)
  char path[FAT32_MAX_PATH];
  char *s;
  int len;

  if (de->parent == NULL) {
    80024d8c:	1204b783          	ld	a5,288(s1)
    80024d90:	c3c1                	beqz	a5,80024e10 <sys_getcwd+0xb6>
    s = "/";
  } else {
    s = path + FAT32_MAX_PATH - 1;
    *s = '\0';
    80024d92:	fa0409a3          	sb	zero,-77(s0)
    s = path + FAT32_MAX_PATH - 1;
    80024d96:	fb340993          	addi	s3,s0,-77
    while (de->parent) {
      len = strlen(de->filename);
      s -= len;
      if (s <= path)          // can't reach root "/"
    80024d9a:	eb040a13          	addi	s4,s0,-336
        return -1;
      strncpy(s, de->filename, len);
      *--s = '/';
    80024d9e:	02f00a93          	li	s5,47
      len = strlen(de->filename);
    80024da2:	8526                	mv	a0,s1
    80024da4:	ffffc097          	auipc	ra,0xffffc
    80024da8:	b62080e7          	jalr	-1182(ra) # 80020906 <strlen>
      s -= len;
    80024dac:	40a98933          	sub	s2,s3,a0
      if (s <= path)          // can't reach root "/"
    80024db0:	072a7563          	bgeu	s4,s2,80024e1a <sys_getcwd+0xc0>
      strncpy(s, de->filename, len);
    80024db4:	862a                	mv	a2,a0
    80024db6:	85a6                	mv	a1,s1
    80024db8:	854a                	mv	a0,s2
    80024dba:	ffffc097          	auipc	ra,0xffffc
    80024dbe:	ada080e7          	jalr	-1318(ra) # 80020894 <strncpy>
      *--s = '/';
    80024dc2:	fff90993          	addi	s3,s2,-1
    80024dc6:	ff590fa3          	sb	s5,-1(s2)
      de = de->parent;
    80024dca:	1204b483          	ld	s1,288(s1)
    while (de->parent) {
    80024dce:	1204b783          	ld	a5,288(s1)
    80024dd2:	fbe1                	bnez	a5,80024da2 <sys_getcwd+0x48>
    }
  }

  // if (copyout(myproc()->pagetable, addr, s, strlen(s) + 1) < 0)
  if (copyout2(addr, s, strlen(s) + 1) < 0)
    80024dd4:	fb843483          	ld	s1,-72(s0)
    80024dd8:	854e                	mv	a0,s3
    80024dda:	ffffc097          	auipc	ra,0xffffc
    80024dde:	b2c080e7          	jalr	-1236(ra) # 80020906 <strlen>
    80024de2:	0015061b          	addiw	a2,a0,1
    80024de6:	85ce                	mv	a1,s3
    80024de8:	8526                	mv	a0,s1
    80024dea:	ffffc097          	auipc	ra,0xffffc
    80024dee:	69e080e7          	jalr	1694(ra) # 80021488 <copyout2>
    return NULL;
    80024df2:	4781                	li	a5,0
  if (copyout2(addr, s, strlen(s) + 1) < 0)
    80024df4:	00054463          	bltz	a0,80024dfc <sys_getcwd+0xa2>
  
  return addr;
    80024df8:	fb843783          	ld	a5,-72(s0)

}
    80024dfc:	853e                	mv	a0,a5
    80024dfe:	60b6                	ld	ra,328(sp)
    80024e00:	6416                	ld	s0,320(sp)
    80024e02:	74f2                	ld	s1,312(sp)
    80024e04:	7952                	ld	s2,304(sp)
    80024e06:	79b2                	ld	s3,296(sp)
    80024e08:	7a12                	ld	s4,288(sp)
    80024e0a:	6af2                	ld	s5,280(sp)
    80024e0c:	6171                	addi	sp,sp,336
    80024e0e:	8082                	ret
    s = "/";
    80024e10:	00006997          	auipc	s3,0x6
    80024e14:	75098993          	addi	s3,s3,1872 # 8002b560 <states.1756+0xf8>
    80024e18:	bf75                	j	80024dd4 <sys_getcwd+0x7a>
        return -1;
    80024e1a:	57fd                	li	a5,-1
    80024e1c:	b7c5                	j	80024dfc <sys_getcwd+0xa2>

0000000080024e1e <sys_remove>:
  return ret == -1;
}

uint64
sys_remove(void)
{
    80024e1e:	d6010113          	addi	sp,sp,-672
    80024e22:	28113c23          	sd	ra,664(sp)
    80024e26:	28813823          	sd	s0,656(sp)
    80024e2a:	28913423          	sd	s1,648(sp)
    80024e2e:	1500                	addi	s0,sp,672
  char path[FAT32_MAX_PATH];
  struct dirent *ep;
  int len;
  if((len = argstr(0, path, FAT32_MAX_PATH)) <= 0)
    80024e30:	10400613          	li	a2,260
    80024e34:	ed840593          	addi	a1,s0,-296
    80024e38:	4501                	li	a0,0
    80024e3a:	ffffe097          	auipc	ra,0xffffe
    80024e3e:	1f4080e7          	jalr	500(ra) # 8002302e <argstr>
    80024e42:	0ea05f63          	blez	a0,80024f40 <sys_remove+0x122>
    return -1;

  char *s = path + len - 1;
    80024e46:	ed840793          	addi	a5,s0,-296
    80024e4a:	157d                	addi	a0,a0,-1
    80024e4c:	953e                	add	a0,a0,a5
  while (s >= path && *s == '/') {
    80024e4e:	02f56c63          	bltu	a0,a5,80024e86 <sys_remove+0x68>
    80024e52:	00054703          	lbu	a4,0(a0)
    80024e56:	02f00793          	li	a5,47
    80024e5a:	02f71063          	bne	a4,a5,80024e7a <sys_remove+0x5c>
    80024e5e:	fff50793          	addi	a5,a0,-1
    80024e62:	ed740693          	addi	a3,s0,-297
    80024e66:	02f00613          	li	a2,47
    s--;
    80024e6a:	853e                	mv	a0,a5
  while (s >= path && *s == '/') {
    80024e6c:	00d78d63          	beq	a5,a3,80024e86 <sys_remove+0x68>
    80024e70:	17fd                	addi	a5,a5,-1
    80024e72:	0017c703          	lbu	a4,1(a5)
    80024e76:	fec70ae3          	beq	a4,a2,80024e6a <sys_remove+0x4c>
  }
  if (s >= path && *s == '.' && (s == path || *--s == '/')) {
    80024e7a:	00054703          	lbu	a4,0(a0)
    80024e7e:	02e00793          	li	a5,46
    80024e82:	08f70763          	beq	a4,a5,80024f10 <sys_remove+0xf2>
    return -1;
  }
  
  if((ep = ename(path)) == NULL){
    80024e86:	ed840513          	addi	a0,s0,-296
    80024e8a:	00002097          	auipc	ra,0x2
    80024e8e:	d88080e7          	jalr	-632(ra) # 80026c12 <ename>
    80024e92:	84aa                	mv	s1,a0
    80024e94:	c955                	beqz	a0,80024f48 <sys_remove+0x12a>
    return -1;
  }
  elock(ep);
    80024e96:	00001097          	auipc	ra,0x1
    80024e9a:	5d6080e7          	jalr	1494(ra) # 8002646c <elock>
  if((ep->attribute & ATTR_DIRECTORY) && !isdirempty(ep)){
    80024e9e:	1004c783          	lbu	a5,256(s1)
    80024ea2:	8bc1                	andi	a5,a5,16
    80024ea4:	c38d                	beqz	a5,80024ec6 <sys_remove+0xa8>
  ep.valid = 0;
    80024ea6:	e8041323          	sh	zero,-378(s0)
  ret = enext(dp, &ep, 2 * 32, &count);   // skip the "." and ".."
    80024eaa:	d6c40693          	addi	a3,s0,-660
    80024eae:	04000613          	li	a2,64
    80024eb2:	d7040593          	addi	a1,s0,-656
    80024eb6:	8526                	mv	a0,s1
    80024eb8:	00001097          	auipc	ra,0x1
    80024ebc:	7b8080e7          	jalr	1976(ra) # 80026670 <enext>
  if((ep->attribute & ATTR_DIRECTORY) && !isdirempty(ep)){
    80024ec0:	57fd                	li	a5,-1
    80024ec2:	06f51363          	bne	a0,a5,80024f28 <sys_remove+0x10a>
      eunlock(ep);
      eput(ep);
      return -1;
  }
  elock(ep->parent);      // Will this lead to deadlock?
    80024ec6:	1204b503          	ld	a0,288(s1)
    80024eca:	00001097          	auipc	ra,0x1
    80024ece:	5a2080e7          	jalr	1442(ra) # 8002646c <elock>
  eremove(ep);
    80024ed2:	8526                	mv	a0,s1
    80024ed4:	00001097          	auipc	ra,0x1
    80024ed8:	46c080e7          	jalr	1132(ra) # 80026340 <eremove>
  eunlock(ep->parent);
    80024edc:	1204b503          	ld	a0,288(s1)
    80024ee0:	00001097          	auipc	ra,0x1
    80024ee4:	5c2080e7          	jalr	1474(ra) # 800264a2 <eunlock>
  eunlock(ep);
    80024ee8:	8526                	mv	a0,s1
    80024eea:	00001097          	auipc	ra,0x1
    80024eee:	5b8080e7          	jalr	1464(ra) # 800264a2 <eunlock>
  eput(ep);
    80024ef2:	8526                	mv	a0,s1
    80024ef4:	00001097          	auipc	ra,0x1
    80024ef8:	5fc080e7          	jalr	1532(ra) # 800264f0 <eput>

  return 0;
    80024efc:	4501                	li	a0,0
}
    80024efe:	29813083          	ld	ra,664(sp)
    80024f02:	29013403          	ld	s0,656(sp)
    80024f06:	28813483          	ld	s1,648(sp)
    80024f0a:	2a010113          	addi	sp,sp,672
    80024f0e:	8082                	ret
  if (s >= path && *s == '.' && (s == path || *--s == '/')) {
    80024f10:	ed840793          	addi	a5,s0,-296
    80024f14:	02f50863          	beq	a0,a5,80024f44 <sys_remove+0x126>
    80024f18:	fff54703          	lbu	a4,-1(a0)
    80024f1c:	02f00793          	li	a5,47
    80024f20:	f6f713e3          	bne	a4,a5,80024e86 <sys_remove+0x68>
    return -1;
    80024f24:	557d                	li	a0,-1
    80024f26:	bfe1                	j	80024efe <sys_remove+0xe0>
      eunlock(ep);
    80024f28:	8526                	mv	a0,s1
    80024f2a:	00001097          	auipc	ra,0x1
    80024f2e:	578080e7          	jalr	1400(ra) # 800264a2 <eunlock>
      eput(ep);
    80024f32:	8526                	mv	a0,s1
    80024f34:	00001097          	auipc	ra,0x1
    80024f38:	5bc080e7          	jalr	1468(ra) # 800264f0 <eput>
      return -1;
    80024f3c:	557d                	li	a0,-1
    80024f3e:	b7c1                	j	80024efe <sys_remove+0xe0>
    return -1;
    80024f40:	557d                	li	a0,-1
    80024f42:	bf75                	j	80024efe <sys_remove+0xe0>
    return -1;
    80024f44:	557d                	li	a0,-1
    80024f46:	bf65                	j	80024efe <sys_remove+0xe0>
    return -1;
    80024f48:	557d                	li	a0,-1
    80024f4a:	bf55                	j	80024efe <sys_remove+0xe0>

0000000080024f4c <sys_rename>:

// Must hold too many locks at a time! It's possible to raise a deadlock.
// Because this op takes some steps, we can't promise
uint64
sys_rename(void)
{
    80024f4c:	c4010113          	addi	sp,sp,-960
    80024f50:	3a113c23          	sd	ra,952(sp)
    80024f54:	3a813823          	sd	s0,944(sp)
    80024f58:	3a913423          	sd	s1,936(sp)
    80024f5c:	3b213023          	sd	s2,928(sp)
    80024f60:	39313c23          	sd	s3,920(sp)
    80024f64:	39413823          	sd	s4,912(sp)
    80024f68:	0780                	addi	s0,sp,960
  char old[FAT32_MAX_PATH], new[FAT32_MAX_PATH];
  if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024f6a:	10400613          	li	a2,260
    80024f6e:	ec840593          	addi	a1,s0,-312
    80024f72:	4501                	li	a0,0
    80024f74:	ffffe097          	auipc	ra,0xffffe
    80024f78:	0ba080e7          	jalr	186(ra) # 8002302e <argstr>
      return -1;
    80024f7c:	57fd                	li	a5,-1
  if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024f7e:	0c054d63          	bltz	a0,80025058 <sys_rename+0x10c>
    80024f82:	10400613          	li	a2,260
    80024f86:	dc040593          	addi	a1,s0,-576
    80024f8a:	4505                	li	a0,1
    80024f8c:	ffffe097          	auipc	ra,0xffffe
    80024f90:	0a2080e7          	jalr	162(ra) # 8002302e <argstr>
      return -1;
    80024f94:	57fd                	li	a5,-1
  if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024f96:	0c054163          	bltz	a0,80025058 <sys_rename+0x10c>
  }

  struct dirent *src = NULL, *dst = NULL, *pdst = NULL;
  int srclock = 0;
  char *name;
  if ((src = ename(old)) == NULL || (pdst = enameparent(new, old)) == NULL
    80024f9a:	ec840513          	addi	a0,s0,-312
    80024f9e:	00002097          	auipc	ra,0x2
    80024fa2:	c74080e7          	jalr	-908(ra) # 80026c12 <ename>
    80024fa6:	84aa                	mv	s1,a0
    80024fa8:	1c050963          	beqz	a0,8002517a <sys_rename+0x22e>
    80024fac:	ec840593          	addi	a1,s0,-312
    80024fb0:	dc040513          	addi	a0,s0,-576
    80024fb4:	00002097          	auipc	ra,0x2
    80024fb8:	c7c080e7          	jalr	-900(ra) # 80026c30 <enameparent>
    80024fbc:	892a                	mv	s2,a0
    80024fbe:	cd35                	beqz	a0,8002503a <sys_rename+0xee>
      || (name = formatname(old)) == NULL) {
    80024fc0:	ec840513          	addi	a0,s0,-312
    80024fc4:	00001097          	auipc	ra,0x1
    80024fc8:	dfc080e7          	jalr	-516(ra) # 80025dc0 <formatname>
    80024fcc:	8a2a                	mv	s4,a0
    80024fce:	c535                	beqz	a0,8002503a <sys_rename+0xee>
    goto fail;          // src doesn't exist || dst parent doesn't exist || illegal new name
  }
  for (struct dirent *ep = pdst; ep != NULL; ep = ep->parent) {
    if (ep == src) {    // In what universe can we move a directory into its child?
    80024fd0:	07248563          	beq	s1,s2,8002503a <sys_rename+0xee>
  for (struct dirent *ep = pdst; ep != NULL; ep = ep->parent) {
    80024fd4:	87ca                	mv	a5,s2
    80024fd6:	1207b783          	ld	a5,288(a5)
    80024fda:	c781                	beqz	a5,80024fe2 <sys_rename+0x96>
    if (ep == src) {    // In what universe can we move a directory into its child?
    80024fdc:	fef49de3          	bne	s1,a5,80024fd6 <sys_rename+0x8a>
    80024fe0:	a8a9                	j	8002503a <sys_rename+0xee>
      goto fail;
    }
  }

  uint off;
  elock(src);     // must hold child's lock before acquiring parent's, because we do so in other similar cases
    80024fe2:	8526                	mv	a0,s1
    80024fe4:	00001097          	auipc	ra,0x1
    80024fe8:	488080e7          	jalr	1160(ra) # 8002646c <elock>
  srclock = 1;
  elock(pdst);
    80024fec:	854a                	mv	a0,s2
    80024fee:	00001097          	auipc	ra,0x1
    80024ff2:	47e080e7          	jalr	1150(ra) # 8002646c <elock>
  dst = dirlookup(pdst, name, &off);
    80024ff6:	dbc40613          	addi	a2,s0,-580
    80024ffa:	85d2                	mv	a1,s4
    80024ffc:	854a                	mv	a0,s2
    80024ffe:	00001097          	auipc	ra,0x1
    80025002:	7fe080e7          	jalr	2046(ra) # 800267fc <dirlookup>
    80025006:	89aa                	mv	s3,a0
  if (dst != NULL) {
    80025008:	cd45                	beqz	a0,800250c0 <sys_rename+0x174>
    eunlock(pdst);
    8002500a:	854a                	mv	a0,s2
    8002500c:	00001097          	auipc	ra,0x1
    80025010:	496080e7          	jalr	1174(ra) # 800264a2 <eunlock>
    if (src == dst) {
    80025014:	01348963          	beq	s1,s3,80025026 <sys_rename+0xda>
      goto fail;
    } else if (src->attribute & dst->attribute & ATTR_DIRECTORY) {
    80025018:	1004c783          	lbu	a5,256(s1)
    8002501c:	1009c703          	lbu	a4,256(s3)
    80025020:	8ff9                	and	a5,a5,a4
    80025022:	8bc1                	andi	a5,a5,16
    80025024:	ebb1                	bnez	a5,80025078 <sys_rename+0x12c>

  return 0;

fail:
  if (srclock)
    eunlock(src);
    80025026:	8526                	mv	a0,s1
    80025028:	00001097          	auipc	ra,0x1
    8002502c:	47a080e7          	jalr	1146(ra) # 800264a2 <eunlock>
  if (dst)
    eput(dst);
    80025030:	854e                	mv	a0,s3
    80025032:	00001097          	auipc	ra,0x1
    80025036:	4be080e7          	jalr	1214(ra) # 800264f0 <eput>
  if (pdst)
    8002503a:	00090763          	beqz	s2,80025048 <sys_rename+0xfc>
    eput(pdst);
    8002503e:	854a                	mv	a0,s2
    80025040:	00001097          	auipc	ra,0x1
    80025044:	4b0080e7          	jalr	1200(ra) # 800264f0 <eput>
  if (src)
    eput(src);
  return -1;
    80025048:	57fd                	li	a5,-1
  if (src)
    8002504a:	c499                	beqz	s1,80025058 <sys_rename+0x10c>
    eput(src);
    8002504c:	8526                	mv	a0,s1
    8002504e:	00001097          	auipc	ra,0x1
    80025052:	4a2080e7          	jalr	1186(ra) # 800264f0 <eput>
  return -1;
    80025056:	57fd                	li	a5,-1
}
    80025058:	853e                	mv	a0,a5
    8002505a:	3b813083          	ld	ra,952(sp)
    8002505e:	3b013403          	ld	s0,944(sp)
    80025062:	3a813483          	ld	s1,936(sp)
    80025066:	3a013903          	ld	s2,928(sp)
    8002506a:	39813983          	ld	s3,920(sp)
    8002506e:	39013a03          	ld	s4,912(sp)
    80025072:	3c010113          	addi	sp,sp,960
    80025076:	8082                	ret
      elock(dst);
    80025078:	854e                	mv	a0,s3
    8002507a:	00001097          	auipc	ra,0x1
    8002507e:	3f2080e7          	jalr	1010(ra) # 8002646c <elock>
  ep.valid = 0;
    80025082:	d6041323          	sh	zero,-666(s0)
  ret = enext(dp, &ep, 2 * 32, &count);   // skip the "." and ".."
    80025086:	c4c40693          	addi	a3,s0,-948
    8002508a:	04000613          	li	a2,64
    8002508e:	c5040593          	addi	a1,s0,-944
    80025092:	854e                	mv	a0,s3
    80025094:	00001097          	auipc	ra,0x1
    80025098:	5dc080e7          	jalr	1500(ra) # 80026670 <enext>
      if (!isdirempty(dst)) {    // it's ok to overwrite an empty dir
    8002509c:	57fd                	li	a5,-1
    8002509e:	0cf51863          	bne	a0,a5,8002516e <sys_rename+0x222>
      elock(pdst);
    800250a2:	854a                	mv	a0,s2
    800250a4:	00001097          	auipc	ra,0x1
    800250a8:	3c8080e7          	jalr	968(ra) # 8002646c <elock>
    eremove(dst);
    800250ac:	854e                	mv	a0,s3
    800250ae:	00001097          	auipc	ra,0x1
    800250b2:	292080e7          	jalr	658(ra) # 80026340 <eremove>
    eunlock(dst);
    800250b6:	854e                	mv	a0,s3
    800250b8:	00001097          	auipc	ra,0x1
    800250bc:	3ea080e7          	jalr	1002(ra) # 800264a2 <eunlock>
  memmove(src->filename, name, FAT32_MAX_FILENAME);
    800250c0:	0ff00613          	li	a2,255
    800250c4:	85d2                	mv	a1,s4
    800250c6:	8526                	mv	a0,s1
    800250c8:	ffffb097          	auipc	ra,0xffffb
    800250cc:	700080e7          	jalr	1792(ra) # 800207c8 <memmove>
  emake(pdst, src, off);
    800250d0:	dbc42603          	lw	a2,-580(s0)
    800250d4:	85a6                	mv	a1,s1
    800250d6:	854a                	mv	a0,s2
    800250d8:	00001097          	auipc	ra,0x1
    800250dc:	da8080e7          	jalr	-600(ra) # 80025e80 <emake>
  if (src->parent != pdst) {
    800250e0:	1204b783          	ld	a5,288(s1)
    800250e4:	01278d63          	beq	a5,s2,800250fe <sys_rename+0x1b2>
    eunlock(pdst);
    800250e8:	854a                	mv	a0,s2
    800250ea:	00001097          	auipc	ra,0x1
    800250ee:	3b8080e7          	jalr	952(ra) # 800264a2 <eunlock>
    elock(src->parent);
    800250f2:	1204b503          	ld	a0,288(s1)
    800250f6:	00001097          	auipc	ra,0x1
    800250fa:	376080e7          	jalr	886(ra) # 8002646c <elock>
  eremove(src);
    800250fe:	8526                	mv	a0,s1
    80025100:	00001097          	auipc	ra,0x1
    80025104:	240080e7          	jalr	576(ra) # 80026340 <eremove>
  eunlock(src->parent);
    80025108:	1204b503          	ld	a0,288(s1)
    8002510c:	00001097          	auipc	ra,0x1
    80025110:	396080e7          	jalr	918(ra) # 800264a2 <eunlock>
  struct dirent *psrc = src->parent;  // src must not be root, or it won't pass the for-loop test
    80025114:	1204ba03          	ld	s4,288(s1)
  src->parent = edup(pdst);
    80025118:	854a                	mv	a0,s2
    8002511a:	00001097          	auipc	ra,0x1
    8002511e:	102080e7          	jalr	258(ra) # 8002621c <edup>
    80025122:	12a4b023          	sd	a0,288(s1)
  src->off = off;
    80025126:	dbc42783          	lw	a5,-580(s0)
    8002512a:	10f4ae23          	sw	a5,284(s1)
  src->valid = 1;
    8002512e:	4785                	li	a5,1
    80025130:	10f49b23          	sh	a5,278(s1)
  eunlock(src);
    80025134:	8526                	mv	a0,s1
    80025136:	00001097          	auipc	ra,0x1
    8002513a:	36c080e7          	jalr	876(ra) # 800264a2 <eunlock>
  eput(psrc);
    8002513e:	8552                	mv	a0,s4
    80025140:	00001097          	auipc	ra,0x1
    80025144:	3b0080e7          	jalr	944(ra) # 800264f0 <eput>
  if (dst) {
    80025148:	00098763          	beqz	s3,80025156 <sys_rename+0x20a>
    eput(dst);
    8002514c:	854e                	mv	a0,s3
    8002514e:	00001097          	auipc	ra,0x1
    80025152:	3a2080e7          	jalr	930(ra) # 800264f0 <eput>
  eput(pdst);
    80025156:	854a                	mv	a0,s2
    80025158:	00001097          	auipc	ra,0x1
    8002515c:	398080e7          	jalr	920(ra) # 800264f0 <eput>
  eput(src);
    80025160:	8526                	mv	a0,s1
    80025162:	00001097          	auipc	ra,0x1
    80025166:	38e080e7          	jalr	910(ra) # 800264f0 <eput>
  return 0;
    8002516a:	4781                	li	a5,0
    8002516c:	b5f5                	j	80025058 <sys_rename+0x10c>
        eunlock(dst);
    8002516e:	854e                	mv	a0,s3
    80025170:	00001097          	auipc	ra,0x1
    80025174:	332080e7          	jalr	818(ra) # 800264a2 <eunlock>
        goto fail;
    80025178:	b57d                	j	80025026 <sys_rename+0xda>
  struct dirent *src = NULL, *dst = NULL, *pdst = NULL;
    8002517a:	892a                	mv	s2,a0
  if (dst)
    8002517c:	bd7d                	j	8002503a <sys_rename+0xee>
	...

0000000080025180 <kernelvec>:
    80025180:	7111                	addi	sp,sp,-256
    80025182:	e006                	sd	ra,0(sp)
    80025184:	e40a                	sd	sp,8(sp)
    80025186:	e80e                	sd	gp,16(sp)
    80025188:	ec12                	sd	tp,24(sp)
    8002518a:	f016                	sd	t0,32(sp)
    8002518c:	f41a                	sd	t1,40(sp)
    8002518e:	f81e                	sd	t2,48(sp)
    80025190:	fc22                	sd	s0,56(sp)
    80025192:	e0a6                	sd	s1,64(sp)
    80025194:	e4aa                	sd	a0,72(sp)
    80025196:	e8ae                	sd	a1,80(sp)
    80025198:	ecb2                	sd	a2,88(sp)
    8002519a:	f0b6                	sd	a3,96(sp)
    8002519c:	f4ba                	sd	a4,104(sp)
    8002519e:	f8be                	sd	a5,112(sp)
    800251a0:	fcc2                	sd	a6,120(sp)
    800251a2:	e146                	sd	a7,128(sp)
    800251a4:	e54a                	sd	s2,136(sp)
    800251a6:	e94e                	sd	s3,144(sp)
    800251a8:	ed52                	sd	s4,152(sp)
    800251aa:	f156                	sd	s5,160(sp)
    800251ac:	f55a                	sd	s6,168(sp)
    800251ae:	f95e                	sd	s7,176(sp)
    800251b0:	fd62                	sd	s8,184(sp)
    800251b2:	e1e6                	sd	s9,192(sp)
    800251b4:	e5ea                	sd	s10,200(sp)
    800251b6:	e9ee                	sd	s11,208(sp)
    800251b8:	edf2                	sd	t3,216(sp)
    800251ba:	f1f6                	sd	t4,224(sp)
    800251bc:	f5fa                	sd	t5,232(sp)
    800251be:	f9fe                	sd	t6,240(sp)
    800251c0:	96dfd0ef          	jal	ra,80022b2c <kerneltrap>
    800251c4:	6082                	ld	ra,0(sp)
    800251c6:	6122                	ld	sp,8(sp)
    800251c8:	61c2                	ld	gp,16(sp)
    800251ca:	7282                	ld	t0,32(sp)
    800251cc:	7322                	ld	t1,40(sp)
    800251ce:	73c2                	ld	t2,48(sp)
    800251d0:	7462                	ld	s0,56(sp)
    800251d2:	6486                	ld	s1,64(sp)
    800251d4:	6526                	ld	a0,72(sp)
    800251d6:	65c6                	ld	a1,80(sp)
    800251d8:	6666                	ld	a2,88(sp)
    800251da:	7686                	ld	a3,96(sp)
    800251dc:	7726                	ld	a4,104(sp)
    800251de:	77c6                	ld	a5,112(sp)
    800251e0:	7866                	ld	a6,120(sp)
    800251e2:	688a                	ld	a7,128(sp)
    800251e4:	692a                	ld	s2,136(sp)
    800251e6:	69ca                	ld	s3,144(sp)
    800251e8:	6a6a                	ld	s4,152(sp)
    800251ea:	7a8a                	ld	s5,160(sp)
    800251ec:	7b2a                	ld	s6,168(sp)
    800251ee:	7bca                	ld	s7,176(sp)
    800251f0:	7c6a                	ld	s8,184(sp)
    800251f2:	6c8e                	ld	s9,192(sp)
    800251f4:	6d2e                	ld	s10,200(sp)
    800251f6:	6dce                	ld	s11,208(sp)
    800251f8:	6e6e                	ld	t3,216(sp)
    800251fa:	7e8e                	ld	t4,224(sp)
    800251fc:	7f2e                	ld	t5,232(sp)
    800251fe:	7fce                	ld	t6,240(sp)
    80025200:	6111                	addi	sp,sp,256
    80025202:	10200073          	sret
	...

000000008002520e <timerinit>:
#include "include/proc.h"

struct spinlock tickslock;
uint ticks;

void timerinit() {
    8002520e:	1141                	addi	sp,sp,-16
    80025210:	e406                	sd	ra,8(sp)
    80025212:	e022                	sd	s0,0(sp)
    80025214:	0800                	addi	s0,sp,16
    initlock(&tickslock, "time");
    80025216:	00008597          	auipc	a1,0x8
    8002521a:	8d258593          	addi	a1,a1,-1838 # 8002cae8 <syscalls+0xa30>
    8002521e:	0001c517          	auipc	a0,0x1c
    80025222:	1ea50513          	addi	a0,a0,490 # 80041408 <tickslock>
    80025226:	ffffb097          	auipc	ra,0xffffb
    8002522a:	456080e7          	jalr	1110(ra) # 8002067c <initlock>
    #ifdef DEBUG
    printf("timerinit\n");
    #endif
}
    8002522e:	60a2                	ld	ra,8(sp)
    80025230:	6402                	ld	s0,0(sp)
    80025232:	0141                	addi	sp,sp,16
    80025234:	8082                	ret

0000000080025236 <set_next_timeout>:

void
set_next_timeout() {
    80025236:	1141                	addi	sp,sp,-16
    80025238:	e422                	sd	s0,8(sp)
    8002523a:	0800                	addi	s0,sp,16
  asm volatile("rdtime %0" : "=r" (x) );
    8002523c:	c0102573          	rdtime	a0
    // if comment the `printf` line below
    // the timer will not work.

    // this bug seems to disappear automatically
    // printf("");
    sbi_set_timer(r_time() + INTERVAL);
    80025240:	001dc7b7          	lui	a5,0x1dc
    80025244:	13078793          	addi	a5,a5,304 # 1dc130 <BASE_ADDRESS-0x7fe43ed0>
    80025248:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
    8002524a:	4581                	li	a1,0
    8002524c:	4601                	li	a2,0
    8002524e:	4681                	li	a3,0
    80025250:	4881                	li	a7,0
    80025252:	00000073          	ecall
}
    80025256:	6422                	ld	s0,8(sp)
    80025258:	0141                	addi	sp,sp,16
    8002525a:	8082                	ret

000000008002525c <timer_tick>:

void timer_tick() {
    8002525c:	1101                	addi	sp,sp,-32
    8002525e:	ec06                	sd	ra,24(sp)
    80025260:	e822                	sd	s0,16(sp)
    80025262:	e426                	sd	s1,8(sp)
    80025264:	1000                	addi	s0,sp,32
    acquire(&tickslock);
    80025266:	0001c497          	auipc	s1,0x1c
    8002526a:	1a248493          	addi	s1,s1,418 # 80041408 <tickslock>
    8002526e:	8526                	mv	a0,s1
    80025270:	ffffb097          	auipc	ra,0xffffb
    80025274:	450080e7          	jalr	1104(ra) # 800206c0 <acquire>
    ticks++;
    80025278:	0001c517          	auipc	a0,0x1c
    8002527c:	1a850513          	addi	a0,a0,424 # 80041420 <ticks>
    80025280:	411c                	lw	a5,0(a0)
    80025282:	2785                	addiw	a5,a5,1
    80025284:	c11c                	sw	a5,0(a0)
    wakeup(&ticks);
    80025286:	ffffd097          	auipc	ra,0xffffd
    8002528a:	378080e7          	jalr	888(ra) # 800225fe <wakeup>
    release(&tickslock);
    8002528e:	8526                	mv	a0,s1
    80025290:	ffffb097          	auipc	ra,0xffffb
    80025294:	484080e7          	jalr	1156(ra) # 80020714 <release>
    set_next_timeout();
    80025298:	00000097          	auipc	ra,0x0
    8002529c:	f9e080e7          	jalr	-98(ra) # 80025236 <set_next_timeout>
}
    800252a0:	60e2                	ld	ra,24(sp)
    800252a2:	6442                	ld	s0,16(sp)
    800252a4:	64a2                	ld	s1,8(sp)
    800252a6:	6105                	addi	sp,sp,32
    800252a8:	8082                	ret

00000000800252aa <disk_init>:
#else
#include "include/virtio.h"
#endif 

void disk_init(void)
{
    800252aa:	1141                	addi	sp,sp,-16
    800252ac:	e406                	sd	ra,8(sp)
    800252ae:	e022                	sd	s0,0(sp)
    800252b0:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_init();
	#else 
	sdcard_init();
    800252b2:	00003097          	auipc	ra,0x3
    800252b6:	f54080e7          	jalr	-172(ra) # 80028206 <sdcard_init>
    #endif
}
    800252ba:	60a2                	ld	ra,8(sp)
    800252bc:	6402                	ld	s0,0(sp)
    800252be:	0141                	addi	sp,sp,16
    800252c0:	8082                	ret

00000000800252c2 <disk_read>:

void disk_read(struct buf *b)
{
    800252c2:	1141                	addi	sp,sp,-16
    800252c4:	e406                	sd	ra,8(sp)
    800252c6:	e022                	sd	s0,0(sp)
    800252c8:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 0);
    #else 
	sdcard_read_sector(b->data, b->sectorno);
    800252ca:	454c                	lw	a1,12(a0)
    800252cc:	05850513          	addi	a0,a0,88
    800252d0:	00003097          	auipc	ra,0x3
    800252d4:	278080e7          	jalr	632(ra) # 80028548 <sdcard_read_sector>
	#endif
}
    800252d8:	60a2                	ld	ra,8(sp)
    800252da:	6402                	ld	s0,0(sp)
    800252dc:	0141                	addi	sp,sp,16
    800252de:	8082                	ret

00000000800252e0 <disk_write>:

void disk_write(struct buf *b)
{
    800252e0:	1141                	addi	sp,sp,-16
    800252e2:	e406                	sd	ra,8(sp)
    800252e4:	e022                	sd	s0,0(sp)
    800252e6:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 1);
    #else 
	sdcard_write_sector(b->data, b->sectorno);
    800252e8:	454c                	lw	a1,12(a0)
    800252ea:	05850513          	addi	a0,a0,88
    800252ee:	00003097          	auipc	ra,0x3
    800252f2:	35e080e7          	jalr	862(ra) # 8002864c <sdcard_write_sector>
	#endif
}
    800252f6:	60a2                	ld	ra,8(sp)
    800252f8:	6402                	ld	s0,0(sp)
    800252fa:	0141                	addi	sp,sp,16
    800252fc:	8082                	ret

00000000800252fe <disk_intr>:

void disk_intr(void)
{
    800252fe:	1141                	addi	sp,sp,-16
    80025300:	e406                	sd	ra,8(sp)
    80025302:	e022                	sd	s0,0(sp)
    80025304:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_intr();
    #else 
    dmac_intr(DMAC_CHANNEL0);
    80025306:	4501                	li	a0,0
    80025308:	00004097          	auipc	ra,0x4
    8002530c:	ae6080e7          	jalr	-1306(ra) # 80028dee <dmac_intr>
    #endif
}
    80025310:	60a2                	ld	ra,8(sp)
    80025312:	6402                	ld	s0,0(sp)
    80025314:	0141                	addi	sp,sp,16
    80025316:	8082                	ret

0000000080025318 <read_fat>:
/**
 * Read the FAT table content corresponded to the given cluster number.
 * @param   cluster     the number of cluster which you want to read its content in FAT table
 */
static uint32 read_fat(uint32 cluster)
{
    80025318:	1101                	addi	sp,sp,-32
    8002531a:	ec06                	sd	ra,24(sp)
    8002531c:	e822                	sd	s0,16(sp)
    8002531e:	e426                	sd	s1,8(sp)
    80025320:	e04a                	sd	s2,0(sp)
    80025322:	1000                	addi	s0,sp,32
    if (cluster >= FAT32_EOC) {
    80025324:	100007b7          	lui	a5,0x10000
    80025328:	17dd                	addi	a5,a5,-9
        return cluster;
    8002532a:	84aa                	mv	s1,a0
    if (cluster >= FAT32_EOC) {
    8002532c:	00a7eb63          	bltu	a5,a0,80025342 <read_fat+0x2a>
    }
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    80025330:	0001c797          	auipc	a5,0x1c
    80025334:	0f878793          	addi	a5,a5,248 # 80041428 <fat>
    80025338:	479c                	lw	a5,8(a5)
    8002533a:	2785                	addiw	a5,a5,1
        return 0;
    8002533c:	4481                	li	s1,0
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    8002533e:	00a7f963          	bgeu	a5,a0,80025350 <read_fat+0x38>
    // here should be a cache layer for FAT table, but not implemented yet.
    struct buf *b = bread(0, fat_sec);
    uint32 next_clus = *(uint32 *)(b->data + fat_offset_of_clus(cluster));
    brelse(b);
    return next_clus;
}
    80025342:	8526                	mv	a0,s1
    80025344:	60e2                	ld	ra,24(sp)
    80025346:	6442                	ld	s0,16(sp)
    80025348:	64a2                	ld	s1,8(sp)
    8002534a:	6902                	ld	s2,0(sp)
    8002534c:	6105                	addi	sp,sp,32
    8002534e:	8082                	ret
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    80025350:	0025149b          	slliw	s1,a0,0x2
    80025354:	0001c917          	auipc	s2,0x1c
    80025358:	0d490913          	addi	s2,s2,212 # 80041428 <fat>
    8002535c:	01095783          	lhu	a5,16(s2)
    80025360:	02f4d7bb          	divuw	a5,s1,a5
    80025364:	01495583          	lhu	a1,20(s2)
    struct buf *b = bread(0, fat_sec);
    80025368:	9dbd                	addw	a1,a1,a5
    8002536a:	4501                	li	a0,0
    8002536c:	ffffe097          	auipc	ra,0xffffe
    80025370:	298080e7          	jalr	664(ra) # 80023604 <bread>
    return (cluster << 2) % fat.bpb.byts_per_sec;
    80025374:	01095783          	lhu	a5,16(s2)
    80025378:	02f4f4bb          	remuw	s1,s1,a5
    uint32 next_clus = *(uint32 *)(b->data + fat_offset_of_clus(cluster));
    8002537c:	94aa                	add	s1,s1,a0
    8002537e:	4ca4                	lw	s1,88(s1)
    brelse(b);
    80025380:	ffffe097          	auipc	ra,0xffffe
    80025384:	3c2080e7          	jalr	962(ra) # 80023742 <brelse>
    return next_clus;
    80025388:	bf6d                	j	80025342 <read_fat+0x2a>

000000008002538a <alloc_clus>:
        brelse(b);
    }
}

static uint32 alloc_clus(uint8 dev)
{
    8002538a:	711d                	addi	sp,sp,-96
    8002538c:	ec86                	sd	ra,88(sp)
    8002538e:	e8a2                	sd	s0,80(sp)
    80025390:	e4a6                	sd	s1,72(sp)
    80025392:	e0ca                	sd	s2,64(sp)
    80025394:	fc4e                	sd	s3,56(sp)
    80025396:	f852                	sd	s4,48(sp)
    80025398:	f456                	sd	s5,40(sp)
    8002539a:	f05a                	sd	s6,32(sp)
    8002539c:	ec5e                	sd	s7,24(sp)
    8002539e:	e862                	sd	s8,16(sp)
    800253a0:	e466                	sd	s9,8(sp)
    800253a2:	1080                	addi	s0,sp,96
    // should we keep a free cluster list? instead of searching fat every time.
    struct buf *b;
    uint32 sec = fat.bpb.rsvd_sec_cnt;
    800253a4:	0001c797          	auipc	a5,0x1c
    800253a8:	08478793          	addi	a5,a5,132 # 80041428 <fat>
    800253ac:	0147db03          	lhu	s6,20(a5)
    uint32 const ent_per_sec = fat.bpb.byts_per_sec / sizeof(uint32);
    800253b0:	0107d903          	lhu	s2,16(a5)
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    800253b4:	539c                	lw	a5,32(a5)
    800253b6:	10078663          	beqz	a5,800254c2 <alloc_clus+0x138>
    800253ba:	0029591b          	srliw	s2,s2,0x2
    800253be:	0009099b          	sext.w	s3,s2
    800253c2:	4a81                	li	s5,0
        b = bread(dev, sec);
    800253c4:	00050b9b          	sext.w	s7,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    800253c8:	4c01                	li	s8,0
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    800253ca:	0001cc97          	auipc	s9,0x1c
    800253ce:	05ec8c93          	addi	s9,s9,94 # 80041428 <fat>
    800253d2:	a821                	j	800253ea <alloc_clus+0x60>
                uint32 clus = i * ent_per_sec + j;
                zero_clus(clus);
                return clus;
            }
        }
        brelse(b);
    800253d4:	8552                	mv	a0,s4
    800253d6:	ffffe097          	auipc	ra,0xffffe
    800253da:	36c080e7          	jalr	876(ra) # 80023742 <brelse>
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    800253de:	2a85                	addiw	s5,s5,1
    800253e0:	2b05                	addiw	s6,s6,1
    800253e2:	020ca783          	lw	a5,32(s9)
    800253e6:	0cfafe63          	bgeu	s5,a5,800254c2 <alloc_clus+0x138>
        b = bread(dev, sec);
    800253ea:	85da                	mv	a1,s6
    800253ec:	855e                	mv	a0,s7
    800253ee:	ffffe097          	auipc	ra,0xffffe
    800253f2:	216080e7          	jalr	534(ra) # 80023604 <bread>
    800253f6:	8a2a                	mv	s4,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    800253f8:	fc098ee3          	beqz	s3,800253d4 <alloc_clus+0x4a>
            if (((uint32 *)(b->data))[j] == 0) {
    800253fc:	05850693          	addi	a3,a0,88
    80025400:	4d24                	lw	s1,88(a0)
    80025402:	cc81                	beqz	s1,8002541a <alloc_clus+0x90>
    80025404:	05c50793          	addi	a5,a0,92
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80025408:	84e2                	mv	s1,s8
    8002540a:	2485                	addiw	s1,s1,1
    8002540c:	fc9984e3          	beq	s3,s1,800253d4 <alloc_clus+0x4a>
            if (((uint32 *)(b->data))[j] == 0) {
    80025410:	86be                	mv	a3,a5
    80025412:	0791                	addi	a5,a5,4
    80025414:	ffc7a703          	lw	a4,-4(a5)
    80025418:	fb6d                	bnez	a4,8002540a <alloc_clus+0x80>
                ((uint32 *)(b->data))[j] = FAT32_EOC + 7;
    8002541a:	100007b7          	lui	a5,0x10000
    8002541e:	17fd                	addi	a5,a5,-1
    80025420:	c29c                	sw	a5,0(a3)
                bwrite(b);
    80025422:	8552                	mv	a0,s4
    80025424:	ffffe097          	auipc	ra,0xffffe
    80025428:	2e2080e7          	jalr	738(ra) # 80023706 <bwrite>
                brelse(b);
    8002542c:	8552                	mv	a0,s4
    8002542e:	ffffe097          	auipc	ra,0xffffe
    80025432:	314080e7          	jalr	788(ra) # 80023742 <brelse>
                uint32 clus = i * ent_per_sec + j;
    80025436:	0359093b          	mulw	s2,s2,s5
    8002543a:	009904bb          	addw	s1,s2,s1
    8002543e:	00048a9b          	sext.w	s5,s1
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    80025442:	0001c717          	auipc	a4,0x1c
    80025446:	fe670713          	addi	a4,a4,-26 # 80041428 <fat>
    8002544a:	01274783          	lbu	a5,18(a4)
    8002544e:	34f9                	addiw	s1,s1,-2
    80025450:	02f489bb          	mulw	s3,s1,a5
    80025454:	4318                	lw	a4,0(a4)
    80025456:	00e989bb          	addw	s3,s3,a4
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    8002545a:	c7b1                	beqz	a5,800254a6 <alloc_clus+0x11c>
    8002545c:	4481                	li	s1,0
    8002545e:	0001ca17          	auipc	s4,0x1c
    80025462:	fcaa0a13          	addi	s4,s4,-54 # 80041428 <fat>
        b = bread(0, sec++);
    80025466:	013485bb          	addw	a1,s1,s3
    8002546a:	4501                	li	a0,0
    8002546c:	ffffe097          	auipc	ra,0xffffe
    80025470:	198080e7          	jalr	408(ra) # 80023604 <bread>
    80025474:	892a                	mv	s2,a0
        memset(b->data, 0, BSIZE);
    80025476:	20000613          	li	a2,512
    8002547a:	4581                	li	a1,0
    8002547c:	05850513          	addi	a0,a0,88
    80025480:	ffffb097          	auipc	ra,0xffffb
    80025484:	2dc080e7          	jalr	732(ra) # 8002075c <memset>
        bwrite(b);
    80025488:	854a                	mv	a0,s2
    8002548a:	ffffe097          	auipc	ra,0xffffe
    8002548e:	27c080e7          	jalr	636(ra) # 80023706 <bwrite>
        brelse(b);
    80025492:	854a                	mv	a0,s2
    80025494:	ffffe097          	auipc	ra,0xffffe
    80025498:	2ae080e7          	jalr	686(ra) # 80023742 <brelse>
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    8002549c:	2485                	addiw	s1,s1,1
    8002549e:	012a4783          	lbu	a5,18(s4)
    800254a2:	fcf4c2e3          	blt	s1,a5,80025466 <alloc_clus+0xdc>
    }
    panic("no clusters");
}
    800254a6:	8556                	mv	a0,s5
    800254a8:	60e6                	ld	ra,88(sp)
    800254aa:	6446                	ld	s0,80(sp)
    800254ac:	64a6                	ld	s1,72(sp)
    800254ae:	6906                	ld	s2,64(sp)
    800254b0:	79e2                	ld	s3,56(sp)
    800254b2:	7a42                	ld	s4,48(sp)
    800254b4:	7aa2                	ld	s5,40(sp)
    800254b6:	7b02                	ld	s6,32(sp)
    800254b8:	6be2                	ld	s7,24(sp)
    800254ba:	6c42                	ld	s8,16(sp)
    800254bc:	6ca2                	ld	s9,8(sp)
    800254be:	6125                	addi	sp,sp,96
    800254c0:	8082                	ret
    panic("no clusters");
    800254c2:	00007517          	auipc	a0,0x7
    800254c6:	62e50513          	addi	a0,a0,1582 # 8002caf0 <syscalls+0xa38>
    800254ca:	ffffb097          	auipc	ra,0xffffb
    800254ce:	c7c080e7          	jalr	-900(ra) # 80020146 <panic>

00000000800254d2 <write_fat>:
    if (cluster > fat.data_clus_cnt + 1) {
    800254d2:	0001c797          	auipc	a5,0x1c
    800254d6:	f5678793          	addi	a5,a5,-170 # 80041428 <fat>
    800254da:	479c                	lw	a5,8(a5)
    800254dc:	2785                	addiw	a5,a5,1
    800254de:	06a7e763          	bltu	a5,a0,8002554c <write_fat+0x7a>
{
    800254e2:	7179                	addi	sp,sp,-48
    800254e4:	f406                	sd	ra,40(sp)
    800254e6:	f022                	sd	s0,32(sp)
    800254e8:	ec26                	sd	s1,24(sp)
    800254ea:	e84a                	sd	s2,16(sp)
    800254ec:	e44e                	sd	s3,8(sp)
    800254ee:	e052                	sd	s4,0(sp)
    800254f0:	1800                	addi	s0,sp,48
    800254f2:	8a2e                	mv	s4,a1
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    800254f4:	0025149b          	slliw	s1,a0,0x2
    800254f8:	0001c917          	auipc	s2,0x1c
    800254fc:	f3090913          	addi	s2,s2,-208 # 80041428 <fat>
    80025500:	01095783          	lhu	a5,16(s2)
    80025504:	02f4d7bb          	divuw	a5,s1,a5
    80025508:	01495583          	lhu	a1,20(s2)
    struct buf *b = bread(0, fat_sec);
    8002550c:	9dbd                	addw	a1,a1,a5
    8002550e:	4501                	li	a0,0
    80025510:	ffffe097          	auipc	ra,0xffffe
    80025514:	0f4080e7          	jalr	244(ra) # 80023604 <bread>
    80025518:	89aa                	mv	s3,a0
    return (cluster << 2) % fat.bpb.byts_per_sec;
    8002551a:	01095783          	lhu	a5,16(s2)
    8002551e:	02f4f4bb          	remuw	s1,s1,a5
    *(uint32 *)(b->data + off) = content;
    80025522:	94aa                	add	s1,s1,a0
    80025524:	0544ac23          	sw	s4,88(s1)
    bwrite(b);
    80025528:	ffffe097          	auipc	ra,0xffffe
    8002552c:	1de080e7          	jalr	478(ra) # 80023706 <bwrite>
    brelse(b);
    80025530:	854e                	mv	a0,s3
    80025532:	ffffe097          	auipc	ra,0xffffe
    80025536:	210080e7          	jalr	528(ra) # 80023742 <brelse>
    return 0;
    8002553a:	4501                	li	a0,0
}
    8002553c:	70a2                	ld	ra,40(sp)
    8002553e:	7402                	ld	s0,32(sp)
    80025540:	64e2                	ld	s1,24(sp)
    80025542:	6942                	ld	s2,16(sp)
    80025544:	69a2                	ld	s3,8(sp)
    80025546:	6a02                	ld	s4,0(sp)
    80025548:	6145                	addi	sp,sp,48
    8002554a:	8082                	ret
        return -1;
    8002554c:	557d                	li	a0,-1
}
    8002554e:	8082                	ret

0000000080025550 <reloc_clus>:
 * @param   off         the offset from the beginning of the relative file
 * @param   alloc       whether alloc new cluster when meeting end of FAT chains
 * @return              the offset from the new cur_clus
 */
static int reloc_clus(struct dirent *entry, uint off, int alloc)
{
    80025550:	715d                	addi	sp,sp,-80
    80025552:	e486                	sd	ra,72(sp)
    80025554:	e0a2                	sd	s0,64(sp)
    80025556:	fc26                	sd	s1,56(sp)
    80025558:	f84a                	sd	s2,48(sp)
    8002555a:	f44e                	sd	s3,40(sp)
    8002555c:	f052                	sd	s4,32(sp)
    8002555e:	ec56                	sd	s5,24(sp)
    80025560:	e85a                	sd	s6,16(sp)
    80025562:	e45e                	sd	s7,8(sp)
    80025564:	0880                	addi	s0,sp,80
    80025566:	84aa                	mv	s1,a0
    80025568:	8a2e                	mv	s4,a1
    int clus_num = off / fat.byts_per_clus;
    8002556a:	0001c797          	auipc	a5,0x1c
    8002556e:	ebe78793          	addi	a5,a5,-322 # 80041428 <fat>
    80025572:	00c7ab83          	lw	s7,12(a5)
    80025576:	0375d9bb          	divuw	s3,a1,s7
    while (clus_num > entry->clus_cnt) {
    8002557a:	11052703          	lw	a4,272(a0)
    8002557e:	07377763          	bgeu	a4,s3,800255ec <reloc_clus+0x9c>
    80025582:	8b32                	mv	s6,a2
        int clus = read_fat(entry->cur_clus);
        if (clus >= FAT32_EOC) {
    80025584:	10000ab7          	lui	s5,0x10000
    80025588:	1add                	addi	s5,s5,-9
    8002558a:	a025                	j	800255b2 <reloc_clus+0x62>
            if (alloc) {
                clus = alloc_clus(entry->dev);
                write_fat(entry->cur_clus, clus);
            } else {
                entry->cur_clus = entry->first_clus;
    8002558c:	1044a783          	lw	a5,260(s1)
    80025590:	10f4a623          	sw	a5,268(s1)
                entry->clus_cnt = 0;
    80025594:	1004a823          	sw	zero,272(s1)
                return -1;
    80025598:	557d                	li	a0,-1
    8002559a:	a04d                	j	8002563c <reloc_clus+0xec>
            }
        }
        entry->cur_clus = clus;
    8002559c:	1124a623          	sw	s2,268(s1)
        entry->clus_cnt++;
    800255a0:	1104a783          	lw	a5,272(s1)
    800255a4:	2785                	addiw	a5,a5,1
    800255a6:	0007871b          	sext.w	a4,a5
    800255aa:	10f4a823          	sw	a5,272(s1)
    while (clus_num > entry->clus_cnt) {
    800255ae:	03377f63          	bgeu	a4,s3,800255ec <reloc_clus+0x9c>
        int clus = read_fat(entry->cur_clus);
    800255b2:	10c4a503          	lw	a0,268(s1)
    800255b6:	00000097          	auipc	ra,0x0
    800255ba:	d62080e7          	jalr	-670(ra) # 80025318 <read_fat>
    800255be:	0005091b          	sext.w	s2,a0
        if (clus >= FAT32_EOC) {
    800255c2:	fd2adde3          	bge	s5,s2,8002559c <reloc_clus+0x4c>
            if (alloc) {
    800255c6:	fc0b03e3          	beqz	s6,8002558c <reloc_clus+0x3c>
                clus = alloc_clus(entry->dev);
    800255ca:	1144c503          	lbu	a0,276(s1)
    800255ce:	00000097          	auipc	ra,0x0
    800255d2:	dbc080e7          	jalr	-580(ra) # 8002538a <alloc_clus>
    800255d6:	0005059b          	sext.w	a1,a0
    800255da:	0005891b          	sext.w	s2,a1
                write_fat(entry->cur_clus, clus);
    800255de:	10c4a503          	lw	a0,268(s1)
    800255e2:	00000097          	auipc	ra,0x0
    800255e6:	ef0080e7          	jalr	-272(ra) # 800254d2 <write_fat>
    800255ea:	bf4d                	j	8002559c <reloc_clus+0x4c>
    }
    if (clus_num < entry->clus_cnt) {
    800255ec:	04e9f163          	bgeu	s3,a4,8002562e <reloc_clus+0xde>
        entry->cur_clus = entry->first_clus;
    800255f0:	1044a783          	lw	a5,260(s1)
    800255f4:	10f4a623          	sw	a5,268(s1)
        entry->clus_cnt = 0;
    800255f8:	1004a823          	sw	zero,272(s1)
        while (entry->clus_cnt < clus_num) {
    800255fc:	037a6963          	bltu	s4,s7,8002562e <reloc_clus+0xde>
            entry->cur_clus = read_fat(entry->cur_clus);
            if (entry->cur_clus >= FAT32_EOC) {
    80025600:	10000937          	lui	s2,0x10000
    80025604:	195d                	addi	s2,s2,-9
            entry->cur_clus = read_fat(entry->cur_clus);
    80025606:	10c4a503          	lw	a0,268(s1)
    8002560a:	00000097          	auipc	ra,0x0
    8002560e:	d0e080e7          	jalr	-754(ra) # 80025318 <read_fat>
    80025612:	2501                	sext.w	a0,a0
    80025614:	10a4a623          	sw	a0,268(s1)
            if (entry->cur_clus >= FAT32_EOC) {
    80025618:	02a96d63          	bltu	s2,a0,80025652 <reloc_clus+0x102>
                panic("reloc_clus");
            }
            entry->clus_cnt++;
    8002561c:	1104a783          	lw	a5,272(s1)
    80025620:	2785                	addiw	a5,a5,1
    80025622:	0007871b          	sext.w	a4,a5
    80025626:	10f4a823          	sw	a5,272(s1)
        while (entry->clus_cnt < clus_num) {
    8002562a:	fd376ee3          	bltu	a4,s3,80025606 <reloc_clus+0xb6>
        }
    }
    return off % fat.byts_per_clus;
    8002562e:	0001c797          	auipc	a5,0x1c
    80025632:	dfa78793          	addi	a5,a5,-518 # 80041428 <fat>
    80025636:	47c8                	lw	a0,12(a5)
    80025638:	02aa753b          	remuw	a0,s4,a0
}
    8002563c:	60a6                	ld	ra,72(sp)
    8002563e:	6406                	ld	s0,64(sp)
    80025640:	74e2                	ld	s1,56(sp)
    80025642:	7942                	ld	s2,48(sp)
    80025644:	79a2                	ld	s3,40(sp)
    80025646:	7a02                	ld	s4,32(sp)
    80025648:	6ae2                	ld	s5,24(sp)
    8002564a:	6b42                	ld	s6,16(sp)
    8002564c:	6ba2                	ld	s7,8(sp)
    8002564e:	6161                	addi	sp,sp,80
    80025650:	8082                	ret
                panic("reloc_clus");
    80025652:	00007517          	auipc	a0,0x7
    80025656:	4ae50513          	addi	a0,a0,1198 # 8002cb00 <syscalls+0xa48>
    8002565a:	ffffb097          	auipc	ra,0xffffb
    8002565e:	aec080e7          	jalr	-1300(ra) # 80020146 <panic>

0000000080025662 <rw_clus>:
{
    80025662:	7119                	addi	sp,sp,-128
    80025664:	fc86                	sd	ra,120(sp)
    80025666:	f8a2                	sd	s0,112(sp)
    80025668:	f4a6                	sd	s1,104(sp)
    8002566a:	f0ca                	sd	s2,96(sp)
    8002566c:	ecce                	sd	s3,88(sp)
    8002566e:	e8d2                	sd	s4,80(sp)
    80025670:	e4d6                	sd	s5,72(sp)
    80025672:	e0da                	sd	s6,64(sp)
    80025674:	fc5e                	sd	s7,56(sp)
    80025676:	f862                	sd	s8,48(sp)
    80025678:	f466                	sd	s9,40(sp)
    8002567a:	f06a                	sd	s10,32(sp)
    8002567c:	ec6e                	sd	s11,24(sp)
    8002567e:	0100                	addi	s0,sp,128
    80025680:	f8c43423          	sd	a2,-120(s0)
    80025684:	8b36                	mv	s6,a3
    80025686:	8bbe                	mv	s7,a5
    if (off + n > fat.byts_per_clus)
    80025688:	00f706bb          	addw	a3,a4,a5
    8002568c:	0001c797          	auipc	a5,0x1c
    80025690:	d9c78793          	addi	a5,a5,-612 # 80041428 <fat>
    80025694:	47dc                	lw	a5,12(a5)
    80025696:	02d7ef63          	bltu	a5,a3,800256d4 <rw_clus+0x72>
    8002569a:	8d2e                	mv	s10,a1
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    8002569c:	0001c797          	auipc	a5,0x1c
    800256a0:	d8c78793          	addi	a5,a5,-628 # 80041428 <fat>
    800256a4:	0107da03          	lhu	s4,16(a5)
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    800256a8:	ffe5099b          	addiw	s3,a0,-2
    800256ac:	0127c503          	lbu	a0,18(a5)
    800256b0:	02a989bb          	mulw	s3,s3,a0
    800256b4:	4388                	lw	a0,0(a5)
    800256b6:	00a989bb          	addw	s3,s3,a0
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    800256ba:	034757bb          	divuw	a5,a4,s4
    800256be:	00f989bb          	addw	s3,s3,a5
    off = off % fat.bpb.byts_per_sec;
    800256c2:	03477a3b          	remuw	s4,a4,s4
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    800256c6:	0e0b8363          	beqz	s7,800257ac <rw_clus+0x14a>
    800256ca:	4901                	li	s2,0
        m = BSIZE - off % BSIZE;
    800256cc:	20000d93          	li	s11,512
        if (bad == -1) {
    800256d0:	5cfd                	li	s9,-1
    800256d2:	a095                	j	80025736 <rw_clus+0xd4>
        panic("offset out of range");
    800256d4:	00007517          	auipc	a0,0x7
    800256d8:	43c50513          	addi	a0,a0,1084 # 8002cb10 <syscalls+0xa58>
    800256dc:	ffffb097          	auipc	ra,0xffffb
    800256e0:	a6a080e7          	jalr	-1430(ra) # 80020146 <panic>
                bwrite(bp);
    800256e4:	8556                	mv	a0,s5
    800256e6:	ffffe097          	auipc	ra,0xffffe
    800256ea:	020080e7          	jalr	32(ra) # 80023706 <bwrite>
        brelse(bp);
    800256ee:	8556                	mv	a0,s5
    800256f0:	ffffe097          	auipc	ra,0xffffe
    800256f4:	052080e7          	jalr	82(ra) # 80023742 <brelse>
        if (bad == -1) {
    800256f8:	a02d                	j	80025722 <rw_clus+0xc0>
            bad = either_copyout(user, data, bp->data + (off % BSIZE), m);
    800256fa:	058a8613          	addi	a2,s5,88 # 10000058 <BASE_ADDRESS-0x7001ffa8>
    800256fe:	1682                	slli	a3,a3,0x20
    80025700:	9281                	srli	a3,a3,0x20
    80025702:	963a                	add	a2,a2,a4
    80025704:	85da                	mv	a1,s6
    80025706:	f8843503          	ld	a0,-120(s0)
    8002570a:	ffffd097          	auipc	ra,0xffffd
    8002570e:	fce080e7          	jalr	-50(ra) # 800226d8 <either_copyout>
    80025712:	8c2a                	mv	s8,a0
        brelse(bp);
    80025714:	8556                	mv	a0,s5
    80025716:	ffffe097          	auipc	ra,0xffffe
    8002571a:	02c080e7          	jalr	44(ra) # 80023742 <brelse>
        if (bad == -1) {
    8002571e:	079c0763          	beq	s8,s9,8002578c <rw_clus+0x12a>
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    80025722:	0124893b          	addw	s2,s1,s2
    80025726:	01448a3b          	addw	s4,s1,s4
    8002572a:	1482                	slli	s1,s1,0x20
    8002572c:	9081                	srli	s1,s1,0x20
    8002572e:	9b26                	add	s6,s6,s1
    80025730:	2985                	addiw	s3,s3,1
    80025732:	05797d63          	bgeu	s2,s7,8002578c <rw_clus+0x12a>
        bp = bread(0, sec);
    80025736:	85ce                	mv	a1,s3
    80025738:	4501                	li	a0,0
    8002573a:	ffffe097          	auipc	ra,0xffffe
    8002573e:	eca080e7          	jalr	-310(ra) # 80023604 <bread>
    80025742:	8aaa                	mv	s5,a0
        m = BSIZE - off % BSIZE;
    80025744:	1ffa7713          	andi	a4,s4,511
    80025748:	40ed863b          	subw	a2,s11,a4
        if (n - tot < m) {
    8002574c:	412b87bb          	subw	a5,s7,s2
    80025750:	86be                	mv	a3,a5
    80025752:	2781                	sext.w	a5,a5
    80025754:	0006059b          	sext.w	a1,a2
    80025758:	00f5f363          	bgeu	a1,a5,8002575e <rw_clus+0xfc>
    8002575c:	86b2                	mv	a3,a2
    8002575e:	0006849b          	sext.w	s1,a3
        if (write) {
    80025762:	f80d0ce3          	beqz	s10,800256fa <rw_clus+0x98>
            if ((bad = either_copyin(bp->data + (off % BSIZE), user, data, m)) != -1) {
    80025766:	058a8513          	addi	a0,s5,88
    8002576a:	1682                	slli	a3,a3,0x20
    8002576c:	9281                	srli	a3,a3,0x20
    8002576e:	865a                	mv	a2,s6
    80025770:	f8843583          	ld	a1,-120(s0)
    80025774:	953a                	add	a0,a0,a4
    80025776:	ffffd097          	auipc	ra,0xffffd
    8002577a:	f98080e7          	jalr	-104(ra) # 8002270e <either_copyin>
    8002577e:	f79513e3          	bne	a0,s9,800256e4 <rw_clus+0x82>
        brelse(bp);
    80025782:	8556                	mv	a0,s5
    80025784:	ffffe097          	auipc	ra,0xffffe
    80025788:	fbe080e7          	jalr	-66(ra) # 80023742 <brelse>
}
    8002578c:	854a                	mv	a0,s2
    8002578e:	70e6                	ld	ra,120(sp)
    80025790:	7446                	ld	s0,112(sp)
    80025792:	74a6                	ld	s1,104(sp)
    80025794:	7906                	ld	s2,96(sp)
    80025796:	69e6                	ld	s3,88(sp)
    80025798:	6a46                	ld	s4,80(sp)
    8002579a:	6aa6                	ld	s5,72(sp)
    8002579c:	6b06                	ld	s6,64(sp)
    8002579e:	7be2                	ld	s7,56(sp)
    800257a0:	7c42                	ld	s8,48(sp)
    800257a2:	7ca2                	ld	s9,40(sp)
    800257a4:	7d02                	ld	s10,32(sp)
    800257a6:	6de2                	ld	s11,24(sp)
    800257a8:	6109                	addi	sp,sp,128
    800257aa:	8082                	ret
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    800257ac:	895e                	mv	s2,s7
    800257ae:	bff9                	j	8002578c <rw_clus+0x12a>

00000000800257b0 <eget>:
// by their whole path. But when parsing a path, we open all the directories through it, 
// which forms a linked list from the final file to the root. Thus, we use the "parent" pointer 
// to recognize whether an entry with the "name" as given is really the file we want in the right path.
// Should never get root by eget, it's easy to understand.
static struct dirent *eget(struct dirent *parent, char *name)
{
    800257b0:	7139                	addi	sp,sp,-64
    800257b2:	fc06                	sd	ra,56(sp)
    800257b4:	f822                	sd	s0,48(sp)
    800257b6:	f426                	sd	s1,40(sp)
    800257b8:	f04a                	sd	s2,32(sp)
    800257ba:	ec4e                	sd	s3,24(sp)
    800257bc:	e852                	sd	s4,16(sp)
    800257be:	e456                	sd	s5,8(sp)
    800257c0:	0080                	addi	s0,sp,64
    800257c2:	8a2a                	mv	s4,a0
    800257c4:	8aae                	mv	s5,a1
    struct dirent *ep;
    acquire(&ecache.lock);
    800257c6:	0001c517          	auipc	a0,0x1c
    800257ca:	df250513          	addi	a0,a0,-526 # 800415b8 <ecache>
    800257ce:	ffffb097          	auipc	ra,0xffffb
    800257d2:	ef2080e7          	jalr	-270(ra) # 800206c0 <acquire>
    if (name) {
    800257d6:	060a8d63          	beqz	s5,80025850 <eget+0xa0>
        for (ep = root.next; ep != &root; ep = ep->next) {          // LRU algo
    800257da:	0001c797          	auipc	a5,0x1c
    800257de:	c4e78793          	addi	a5,a5,-946 # 80041428 <fat>
    800257e2:	1507b483          	ld	s1,336(a5)
    800257e6:	0001c797          	auipc	a5,0x1c
    800257ea:	c6a78793          	addi	a5,a5,-918 # 80041450 <root>
    800257ee:	06f48163          	beq	s1,a5,80025850 <eget+0xa0>
            if (ep->valid == 1 && ep->parent == parent
    800257f2:	4905                	li	s2,1
        for (ep = root.next; ep != &root; ep = ep->next) {          // LRU algo
    800257f4:	89be                	mv	s3,a5
    800257f6:	a029                	j	80025800 <eget+0x50>
    800257f8:	1284b483          	ld	s1,296(s1)
    800257fc:	05348a63          	beq	s1,s3,80025850 <eget+0xa0>
            if (ep->valid == 1 && ep->parent == parent
    80025800:	11649783          	lh	a5,278(s1)
    80025804:	ff279ae3          	bne	a5,s2,800257f8 <eget+0x48>
    80025808:	1204b783          	ld	a5,288(s1)
    8002580c:	ff4796e3          	bne	a5,s4,800257f8 <eget+0x48>
                && strncmp(ep->filename, name, FAT32_MAX_FILENAME) == 0) {
    80025810:	0ff00613          	li	a2,255
    80025814:	85d6                	mv	a1,s5
    80025816:	8526                	mv	a0,s1
    80025818:	ffffb097          	auipc	ra,0xffffb
    8002581c:	02c080e7          	jalr	44(ra) # 80020844 <strncmp>
    80025820:	fd61                	bnez	a0,800257f8 <eget+0x48>
                if (ep->ref++ == 0) {
    80025822:	1184a783          	lw	a5,280(s1)
    80025826:	0017871b          	addiw	a4,a5,1
    8002582a:	10e4ac23          	sw	a4,280(s1)
    8002582e:	eb81                	bnez	a5,8002583e <eget+0x8e>
                    ep->parent->ref++;
    80025830:	1204b703          	ld	a4,288(s1)
    80025834:	11872783          	lw	a5,280(a4)
    80025838:	2785                	addiw	a5,a5,1
    8002583a:	10f72c23          	sw	a5,280(a4)
                }
                release(&ecache.lock);
    8002583e:	0001c517          	auipc	a0,0x1c
    80025842:	d7a50513          	addi	a0,a0,-646 # 800415b8 <ecache>
    80025846:	ffffb097          	auipc	ra,0xffffb
    8002584a:	ece080e7          	jalr	-306(ra) # 80020714 <release>
                // edup(ep->parent);
                return ep;
    8002584e:	a085                	j	800258ae <eget+0xfe>
            }
        }
    }
    for (ep = root.prev; ep != &root; ep = ep->prev) {              // LRU algo
    80025850:	0001c797          	auipc	a5,0x1c
    80025854:	bd878793          	addi	a5,a5,-1064 # 80041428 <fat>
    80025858:	1587b483          	ld	s1,344(a5)
    8002585c:	0001c797          	auipc	a5,0x1c
    80025860:	bf478793          	addi	a5,a5,-1036 # 80041450 <root>
    80025864:	04f48f63          	beq	s1,a5,800258c2 <eget+0x112>
        if (ep->ref == 0) {
    80025868:	1184a783          	lw	a5,280(s1)
    8002586c:	cf81                	beqz	a5,80025884 <eget+0xd4>
    for (ep = root.prev; ep != &root; ep = ep->prev) {              // LRU algo
    8002586e:	0001c717          	auipc	a4,0x1c
    80025872:	be270713          	addi	a4,a4,-1054 # 80041450 <root>
    80025876:	1304b483          	ld	s1,304(s1)
    8002587a:	04e48463          	beq	s1,a4,800258c2 <eget+0x112>
        if (ep->ref == 0) {
    8002587e:	1184a783          	lw	a5,280(s1)
    80025882:	fbf5                	bnez	a5,80025876 <eget+0xc6>
            ep->ref = 1;
    80025884:	4785                	li	a5,1
    80025886:	10f4ac23          	sw	a5,280(s1)
            ep->dev = parent->dev;
    8002588a:	114a4783          	lbu	a5,276(s4)
    8002588e:	10f48a23          	sb	a5,276(s1)
            ep->off = 0;
    80025892:	1004ae23          	sw	zero,284(s1)
            ep->valid = 0;
    80025896:	10049b23          	sh	zero,278(s1)
            ep->dirty = 0;
    8002589a:	10048aa3          	sb	zero,277(s1)
            release(&ecache.lock);
    8002589e:	0001c517          	auipc	a0,0x1c
    800258a2:	d1a50513          	addi	a0,a0,-742 # 800415b8 <ecache>
    800258a6:	ffffb097          	auipc	ra,0xffffb
    800258aa:	e6e080e7          	jalr	-402(ra) # 80020714 <release>
            return ep;
        }
    }
    panic("eget: insufficient ecache");
    return 0;
}
    800258ae:	8526                	mv	a0,s1
    800258b0:	70e2                	ld	ra,56(sp)
    800258b2:	7442                	ld	s0,48(sp)
    800258b4:	74a2                	ld	s1,40(sp)
    800258b6:	7902                	ld	s2,32(sp)
    800258b8:	69e2                	ld	s3,24(sp)
    800258ba:	6a42                	ld	s4,16(sp)
    800258bc:	6aa2                	ld	s5,8(sp)
    800258be:	6121                	addi	sp,sp,64
    800258c0:	8082                	ret
    panic("eget: insufficient ecache");
    800258c2:	00007517          	auipc	a0,0x7
    800258c6:	26650513          	addi	a0,a0,614 # 8002cb28 <syscalls+0xa70>
    800258ca:	ffffb097          	auipc	ra,0xffffb
    800258ce:	87c080e7          	jalr	-1924(ra) # 80020146 <panic>

00000000800258d2 <read_entry_name>:
 * @param   buffer      pointer to the array that stores the name
 * @param   raw_entry   pointer to the entry in a sector buffer
 * @param   islong      if non-zero, read as l-n-e, otherwise s-n-e.
 */
static void read_entry_name(char *buffer, union dentry *d)
{
    800258d2:	7179                	addi	sp,sp,-48
    800258d4:	f406                	sd	ra,40(sp)
    800258d6:	f022                	sd	s0,32(sp)
    800258d8:	ec26                	sd	s1,24(sp)
    800258da:	e84a                	sd	s2,16(sp)
    800258dc:	1800                	addi	s0,sp,48
    800258de:	892a                	mv	s2,a0
    800258e0:	84ae                	mv	s1,a1
    if (d->lne.attr == ATTR_LONG_NAME) {                       // long entry branch
    800258e2:	00b5c703          	lbu	a4,11(a1)
    800258e6:	47bd                	li	a5,15
    800258e8:	0af70363          	beq	a4,a5,8002598e <read_entry_name+0xbc>
        snstr(buffer, d->lne.name2, NELEM(d->lne.name2));
        buffer += NELEM(d->lne.name2);
        snstr(buffer, d->lne.name3, NELEM(d->lne.name3));
    } else {
        // assert: only "." and ".." will enter this branch
        memset(buffer, 0, CHAR_SHORT_NAME + 2); // plus '.' and '\0'
    800258ec:	4635                	li	a2,13
    800258ee:	4581                	li	a1,0
    800258f0:	ffffb097          	auipc	ra,0xffffb
    800258f4:	e6c080e7          	jalr	-404(ra) # 8002075c <memset>
        int i;
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    800258f8:	0004c703          	lbu	a4,0(s1)
    800258fc:	02000793          	li	a5,32
    80025900:	0cf70a63          	beq	a4,a5,800259d4 <read_entry_name+0x102>
    80025904:	4785                	li	a5,1
    80025906:	02000613          	li	a2,32
    8002590a:	45a5                	li	a1,9
            buffer[i] = d->sne.name[i];
    8002590c:	00f906b3          	add	a3,s2,a5
    80025910:	fee68fa3          	sb	a4,-1(a3) # 1fff <BASE_ADDRESS-0x8001e001>
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    80025914:	0007869b          	sext.w	a3,a5
    80025918:	00f48733          	add	a4,s1,a5
    8002591c:	00074703          	lbu	a4,0(a4)
    80025920:	00c70563          	beq	a4,a2,8002592a <read_entry_name+0x58>
    80025924:	0785                	addi	a5,a5,1
    80025926:	feb793e3          	bne	a5,a1,8002590c <read_entry_name+0x3a>
        }
        if (d->sne.name[8] != ' ') {
    8002592a:	0084c703          	lbu	a4,8(s1)
    8002592e:	02000793          	li	a5,32
    80025932:	04f70863          	beq	a4,a5,80025982 <read_entry_name+0xb0>
            buffer[i++] = '.';
    80025936:	0016871b          	addiw	a4,a3,1
    8002593a:	00d907b3          	add	a5,s2,a3
    8002593e:	02e00613          	li	a2,46
    80025942:	00c78023          	sb	a2,0(a5)
        }
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
            if (d->sne.name[j] == ' ') { break; }
    80025946:	0084c783          	lbu	a5,8(s1)
    8002594a:	02000613          	li	a2,32
    8002594e:	02c78a63          	beq	a5,a2,80025982 <read_entry_name+0xb0>
            buffer[i] = d->sne.name[j];
    80025952:	974a                	add	a4,a4,s2
    80025954:	00f70023          	sb	a5,0(a4)
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
    80025958:	0026879b          	addiw	a5,a3,2
            if (d->sne.name[j] == ' ') { break; }
    8002595c:	0094c703          	lbu	a4,9(s1)
    80025960:	02000613          	li	a2,32
    80025964:	00c70f63          	beq	a4,a2,80025982 <read_entry_name+0xb0>
            buffer[i] = d->sne.name[j];
    80025968:	97ca                	add	a5,a5,s2
    8002596a:	00e78023          	sb	a4,0(a5)
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
    8002596e:	268d                	addiw	a3,a3,3
            if (d->sne.name[j] == ' ') { break; }
    80025970:	00a4c783          	lbu	a5,10(s1)
    80025974:	02000713          	li	a4,32
    80025978:	00e78563          	beq	a5,a4,80025982 <read_entry_name+0xb0>
            buffer[i] = d->sne.name[j];
    8002597c:	96ca                	add	a3,a3,s2
    8002597e:	00f68023          	sb	a5,0(a3)
        }
    }
}
    80025982:	70a2                	ld	ra,40(sp)
    80025984:	7402                	ld	s0,32(sp)
    80025986:	64e2                	ld	s1,24(sp)
    80025988:	6942                	ld	s2,16(sp)
    8002598a:	6145                	addi	sp,sp,48
    8002598c:	8082                	ret
        memmove(temp, d->lne.name1, sizeof(temp));
    8002598e:	4629                	li	a2,10
    80025990:	0585                	addi	a1,a1,1
    80025992:	fd040513          	addi	a0,s0,-48
    80025996:	ffffb097          	auipc	ra,0xffffb
    8002599a:	e32080e7          	jalr	-462(ra) # 800207c8 <memmove>
        snstr(buffer, temp, NELEM(d->lne.name1));
    8002599e:	4615                	li	a2,5
    800259a0:	fd040593          	addi	a1,s0,-48
    800259a4:	854a                	mv	a0,s2
    800259a6:	ffffb097          	auipc	ra,0xffffb
    800259aa:	fcc080e7          	jalr	-52(ra) # 80020972 <snstr>
        snstr(buffer, d->lne.name2, NELEM(d->lne.name2));
    800259ae:	4619                	li	a2,6
    800259b0:	00e48593          	addi	a1,s1,14
    800259b4:	00590513          	addi	a0,s2,5 # 10000005 <BASE_ADDRESS-0x7001fffb>
    800259b8:	ffffb097          	auipc	ra,0xffffb
    800259bc:	fba080e7          	jalr	-70(ra) # 80020972 <snstr>
        snstr(buffer, d->lne.name3, NELEM(d->lne.name3));
    800259c0:	4609                	li	a2,2
    800259c2:	01c48593          	addi	a1,s1,28
    800259c6:	00b90513          	addi	a0,s2,11
    800259ca:	ffffb097          	auipc	ra,0xffffb
    800259ce:	fa8080e7          	jalr	-88(ra) # 80020972 <snstr>
    800259d2:	bf45                	j	80025982 <read_entry_name+0xb0>
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    800259d4:	4681                	li	a3,0
    800259d6:	bf91                	j	8002592a <read_entry_name+0x58>

00000000800259d8 <fat32_init>:
{
    800259d8:	7139                	addi	sp,sp,-64
    800259da:	fc06                	sd	ra,56(sp)
    800259dc:	f822                	sd	s0,48(sp)
    800259de:	f426                	sd	s1,40(sp)
    800259e0:	f04a                	sd	s2,32(sp)
    800259e2:	ec4e                	sd	s3,24(sp)
    800259e4:	e852                	sd	s4,16(sp)
    800259e6:	e456                	sd	s5,8(sp)
    800259e8:	0080                	addi	s0,sp,64
    struct buf *b = bread(0, 0);
    800259ea:	4581                	li	a1,0
    800259ec:	4501                	li	a0,0
    800259ee:	ffffe097          	auipc	ra,0xffffe
    800259f2:	c16080e7          	jalr	-1002(ra) # 80023604 <bread>
    800259f6:	892a                	mv	s2,a0
    if (strncmp((char const*)(b->data + 82), "FAT32", 5))
    800259f8:	4615                	li	a2,5
    800259fa:	00007597          	auipc	a1,0x7
    800259fe:	14e58593          	addi	a1,a1,334 # 8002cb48 <syscalls+0xa90>
    80025a02:	0aa50513          	addi	a0,a0,170
    80025a06:	ffffb097          	auipc	ra,0xffffb
    80025a0a:	e3e080e7          	jalr	-450(ra) # 80020844 <strncmp>
    80025a0e:	16051863          	bnez	a0,80025b7e <fat32_init+0x1a6>
    memmove(&fat.bpb.byts_per_sec, b->data + 11, 2);            // avoid misaligned load on k210
    80025a12:	0001c497          	auipc	s1,0x1c
    80025a16:	a1648493          	addi	s1,s1,-1514 # 80041428 <fat>
    80025a1a:	4609                	li	a2,2
    80025a1c:	06390593          	addi	a1,s2,99
    80025a20:	0001c517          	auipc	a0,0x1c
    80025a24:	a1850513          	addi	a0,a0,-1512 # 80041438 <fat+0x10>
    80025a28:	ffffb097          	auipc	ra,0xffffb
    80025a2c:	da0080e7          	jalr	-608(ra) # 800207c8 <memmove>
    fat.bpb.sec_per_clus = *(b->data + 13);
    80025a30:	06594683          	lbu	a3,101(s2)
    80025a34:	00d48923          	sb	a3,18(s1)
    fat.bpb.rsvd_sec_cnt = *(uint16 *)(b->data + 14);
    80025a38:	06695603          	lhu	a2,102(s2)
    80025a3c:	00c49a23          	sh	a2,20(s1)
    fat.bpb.fat_cnt = *(b->data + 16);
    80025a40:	06894703          	lbu	a4,104(s2)
    80025a44:	00e48b23          	sb	a4,22(s1)
    fat.bpb.hidd_sec = *(uint32 *)(b->data + 28);
    80025a48:	07492783          	lw	a5,116(s2)
    80025a4c:	cc9c                	sw	a5,24(s1)
    fat.bpb.tot_sec = *(uint32 *)(b->data + 32);
    80025a4e:	07892783          	lw	a5,120(s2)
    80025a52:	ccdc                	sw	a5,28(s1)
    fat.bpb.fat_sz = *(uint32 *)(b->data + 36);
    80025a54:	07c92583          	lw	a1,124(s2)
    80025a58:	d08c                	sw	a1,32(s1)
    fat.bpb.root_clus = *(uint32 *)(b->data + 44);
    80025a5a:	08492503          	lw	a0,132(s2)
    80025a5e:	d0c8                	sw	a0,36(s1)
    fat.first_data_sec = fat.bpb.rsvd_sec_cnt + fat.bpb.fat_cnt * fat.bpb.fat_sz;
    80025a60:	02b7073b          	mulw	a4,a4,a1
    80025a64:	9f31                	addw	a4,a4,a2
    80025a66:	c098                	sw	a4,0(s1)
    fat.data_sec_cnt = fat.bpb.tot_sec - fat.first_data_sec;
    80025a68:	9f99                	subw	a5,a5,a4
    80025a6a:	c0dc                	sw	a5,4(s1)
    fat.data_clus_cnt = fat.data_sec_cnt / fat.bpb.sec_per_clus;
    80025a6c:	02d7d7bb          	divuw	a5,a5,a3
    80025a70:	c49c                	sw	a5,8(s1)
    fat.byts_per_clus = fat.bpb.sec_per_clus * fat.bpb.byts_per_sec;
    80025a72:	0104d783          	lhu	a5,16(s1)
    80025a76:	02d787bb          	mulw	a5,a5,a3
    80025a7a:	c4dc                	sw	a5,12(s1)
    brelse(b);
    80025a7c:	854a                	mv	a0,s2
    80025a7e:	ffffe097          	auipc	ra,0xffffe
    80025a82:	cc4080e7          	jalr	-828(ra) # 80023742 <brelse>
    if (BSIZE != fat.bpb.byts_per_sec) 
    80025a86:	0104d703          	lhu	a4,16(s1)
    80025a8a:	20000793          	li	a5,512
    80025a8e:	10f71063          	bne	a4,a5,80025b8e <fat32_init+0x1b6>
    initlock(&ecache.lock, "ecache");
    80025a92:	00007597          	auipc	a1,0x7
    80025a96:	0ee58593          	addi	a1,a1,238 # 8002cb80 <syscalls+0xac8>
    80025a9a:	0001c517          	auipc	a0,0x1c
    80025a9e:	b1e50513          	addi	a0,a0,-1250 # 800415b8 <ecache>
    80025aa2:	ffffb097          	auipc	ra,0xffffb
    80025aa6:	bda080e7          	jalr	-1062(ra) # 8002067c <initlock>
    memset(&root, 0, sizeof(root));
    80025aaa:	0001c497          	auipc	s1,0x1c
    80025aae:	97e48493          	addi	s1,s1,-1666 # 80041428 <fat>
    80025ab2:	0001c917          	auipc	s2,0x1c
    80025ab6:	99e90913          	addi	s2,s2,-1634 # 80041450 <root>
    80025aba:	16800613          	li	a2,360
    80025abe:	4581                	li	a1,0
    80025ac0:	854a                	mv	a0,s2
    80025ac2:	ffffb097          	auipc	ra,0xffffb
    80025ac6:	c9a080e7          	jalr	-870(ra) # 8002075c <memset>
    initsleeplock(&root.lock, "entry");
    80025aca:	00007597          	auipc	a1,0x7
    80025ace:	0be58593          	addi	a1,a1,190 # 8002cb88 <syscalls+0xad0>
    80025ad2:	0001c517          	auipc	a0,0x1c
    80025ad6:	ab650513          	addi	a0,a0,-1354 # 80041588 <root+0x138>
    80025ada:	ffffe097          	auipc	ra,0xffffe
    80025ade:	d7e080e7          	jalr	-642(ra) # 80023858 <initsleeplock>
    root.attribute = (ATTR_DIRECTORY | ATTR_SYSTEM);
    80025ae2:	47d1                	li	a5,20
    80025ae4:	12f48423          	sb	a5,296(s1)
    root.first_clus = root.cur_clus = fat.bpb.root_clus;
    80025ae8:	50dc                	lw	a5,36(s1)
    80025aea:	12f4aa23          	sw	a5,308(s1)
    80025aee:	12f4a623          	sw	a5,300(s1)
    root.valid = 1;
    80025af2:	4785                	li	a5,1
    80025af4:	12f49f23          	sh	a5,318(s1)
    root.prev = &root;
    80025af8:	1524bc23          	sd	s2,344(s1)
    root.next = &root;
    80025afc:	1524b823          	sd	s2,336(s1)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    80025b00:	0001c497          	auipc	s1,0x1c
    80025b04:	ad048493          	addi	s1,s1,-1328 # 800415d0 <ecache+0x18>
        de->next = root.next;
    80025b08:	0001c917          	auipc	s2,0x1c
    80025b0c:	92090913          	addi	s2,s2,-1760 # 80041428 <fat>
        de->prev = &root;
    80025b10:	0001ca97          	auipc	s5,0x1c
    80025b14:	940a8a93          	addi	s5,s5,-1728 # 80041450 <root>
        initsleeplock(&de->lock, "entry");
    80025b18:	00007a17          	auipc	s4,0x7
    80025b1c:	070a0a13          	addi	s4,s4,112 # 8002cb88 <syscalls+0xad0>
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    80025b20:	00020997          	auipc	s3,0x20
    80025b24:	10098993          	addi	s3,s3,256 # 80045c20 <cons>
        de->dev = 0;
    80025b28:	10048a23          	sb	zero,276(s1)
        de->valid = 0;
    80025b2c:	10049b23          	sh	zero,278(s1)
        de->ref = 0;
    80025b30:	1004ac23          	sw	zero,280(s1)
        de->dirty = 0;
    80025b34:	10048aa3          	sb	zero,277(s1)
        de->parent = 0;
    80025b38:	1204b023          	sd	zero,288(s1)
        de->next = root.next;
    80025b3c:	15093783          	ld	a5,336(s2)
    80025b40:	12f4b423          	sd	a5,296(s1)
        de->prev = &root;
    80025b44:	1354b823          	sd	s5,304(s1)
        initsleeplock(&de->lock, "entry");
    80025b48:	85d2                	mv	a1,s4
    80025b4a:	13848513          	addi	a0,s1,312
    80025b4e:	ffffe097          	auipc	ra,0xffffe
    80025b52:	d0a080e7          	jalr	-758(ra) # 80023858 <initsleeplock>
        root.next->prev = de;
    80025b56:	15093783          	ld	a5,336(s2)
    80025b5a:	1297b823          	sd	s1,304(a5)
        root.next = de;
    80025b5e:	14993823          	sd	s1,336(s2)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    80025b62:	16848493          	addi	s1,s1,360
    80025b66:	fd3491e3          	bne	s1,s3,80025b28 <fat32_init+0x150>
}
    80025b6a:	4501                	li	a0,0
    80025b6c:	70e2                	ld	ra,56(sp)
    80025b6e:	7442                	ld	s0,48(sp)
    80025b70:	74a2                	ld	s1,40(sp)
    80025b72:	7902                	ld	s2,32(sp)
    80025b74:	69e2                	ld	s3,24(sp)
    80025b76:	6a42                	ld	s4,16(sp)
    80025b78:	6aa2                	ld	s5,8(sp)
    80025b7a:	6121                	addi	sp,sp,64
    80025b7c:	8082                	ret
        panic("not FAT32 volume");
    80025b7e:	00007517          	auipc	a0,0x7
    80025b82:	fd250513          	addi	a0,a0,-46 # 8002cb50 <syscalls+0xa98>
    80025b86:	ffffa097          	auipc	ra,0xffffa
    80025b8a:	5c0080e7          	jalr	1472(ra) # 80020146 <panic>
        panic("byts_per_sec != BSIZE");
    80025b8e:	00007517          	auipc	a0,0x7
    80025b92:	fda50513          	addi	a0,a0,-38 # 8002cb68 <syscalls+0xab0>
    80025b96:	ffffa097          	auipc	ra,0xffffa
    80025b9a:	5b0080e7          	jalr	1456(ra) # 80020146 <panic>

0000000080025b9e <eread>:
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025b9e:	10852783          	lw	a5,264(a0)
    80025ba2:	0ed7e863          	bltu	a5,a3,80025c92 <eread+0xf4>
{
    80025ba6:	711d                	addi	sp,sp,-96
    80025ba8:	ec86                	sd	ra,88(sp)
    80025baa:	e8a2                	sd	s0,80(sp)
    80025bac:	e4a6                	sd	s1,72(sp)
    80025bae:	e0ca                	sd	s2,64(sp)
    80025bb0:	fc4e                	sd	s3,56(sp)
    80025bb2:	f852                	sd	s4,48(sp)
    80025bb4:	f456                	sd	s5,40(sp)
    80025bb6:	f05a                	sd	s6,32(sp)
    80025bb8:	ec5e                	sd	s7,24(sp)
    80025bba:	e862                	sd	s8,16(sp)
    80025bbc:	e466                	sd	s9,8(sp)
    80025bbe:	e06a                	sd	s10,0(sp)
    80025bc0:	1080                	addi	s0,sp,96
    80025bc2:	8a2a                	mv	s4,a0
    80025bc4:	8bae                	mv	s7,a1
    80025bc6:	8ab2                	mv	s5,a2
    80025bc8:	8936                	mv	s2,a3
    80025bca:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025bcc:	9eb9                	addw	a3,a3,a4
        return 0;
    80025bce:	4501                	li	a0,0
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025bd0:	0b26e163          	bltu	a3,s2,80025c72 <eread+0xd4>
    80025bd4:	100a4703          	lbu	a4,256(s4)
    80025bd8:	8b41                	andi	a4,a4,16
    80025bda:	ef41                	bnez	a4,80025c72 <eread+0xd4>
    if (off + n > entry->file_size) {
    80025bdc:	00d7f463          	bgeu	a5,a3,80025be4 <eread+0x46>
        n = entry->file_size - off;
    80025be0:	41278b3b          	subw	s6,a5,s2
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025be4:	10ca2703          	lw	a4,268(s4)
    80025be8:	100007b7          	lui	a5,0x10000
    80025bec:	17dd                	addi	a5,a5,-9
    80025bee:	06e7ef63          	bltu	a5,a4,80025c6c <eread+0xce>
    80025bf2:	080b0e63          	beqz	s6,80025c8e <eread+0xf0>
    80025bf6:	4981                	li	s3,0
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025bf8:	0001cc97          	auipc	s9,0x1c
    80025bfc:	830c8c93          	addi	s9,s9,-2000 # 80041428 <fat>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025c00:	8c3e                	mv	s8,a5
    80025c02:	a82d                	j	80025c3c <eread+0x9e>
    80025c04:	00048d1b          	sext.w	s10,s1
        if (rw_clus(entry->cur_clus, 0, user_dst, dst, off % fat.byts_per_clus, m) != m) {
    80025c08:	87ea                	mv	a5,s10
    80025c0a:	86d6                	mv	a3,s5
    80025c0c:	865e                	mv	a2,s7
    80025c0e:	4581                	li	a1,0
    80025c10:	10ca2503          	lw	a0,268(s4)
    80025c14:	00000097          	auipc	ra,0x0
    80025c18:	a4e080e7          	jalr	-1458(ra) # 80025662 <rw_clus>
    80025c1c:	2501                	sext.w	a0,a0
    80025c1e:	05a51863          	bne	a0,s10,80025c6e <eread+0xd0>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025c22:	013489bb          	addw	s3,s1,s3
    80025c26:	0124893b          	addw	s2,s1,s2
    80025c2a:	1482                	slli	s1,s1,0x20
    80025c2c:	9081                	srli	s1,s1,0x20
    80025c2e:	9aa6                	add	s5,s5,s1
    80025c30:	10ca2783          	lw	a5,268(s4)
    80025c34:	02fc6d63          	bltu	s8,a5,80025c6e <eread+0xd0>
    80025c38:	0369fb63          	bgeu	s3,s6,80025c6e <eread+0xd0>
        reloc_clus(entry, off, 0);
    80025c3c:	4601                	li	a2,0
    80025c3e:	85ca                	mv	a1,s2
    80025c40:	8552                	mv	a0,s4
    80025c42:	00000097          	auipc	ra,0x0
    80025c46:	90e080e7          	jalr	-1778(ra) # 80025550 <reloc_clus>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025c4a:	00cca783          	lw	a5,12(s9)
    80025c4e:	02f976bb          	remuw	a3,s2,a5
    80025c52:	0006871b          	sext.w	a4,a3
    80025c56:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    80025c58:	413b06bb          	subw	a3,s6,s3
    80025c5c:	84b6                	mv	s1,a3
    80025c5e:	2681                	sext.w	a3,a3
    80025c60:	0007861b          	sext.w	a2,a5
    80025c64:	fad670e3          	bgeu	a2,a3,80025c04 <eread+0x66>
    80025c68:	84be                	mv	s1,a5
    80025c6a:	bf69                	j	80025c04 <eread+0x66>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025c6c:	4981                	li	s3,0
    return tot;
    80025c6e:	0009851b          	sext.w	a0,s3
}
    80025c72:	60e6                	ld	ra,88(sp)
    80025c74:	6446                	ld	s0,80(sp)
    80025c76:	64a6                	ld	s1,72(sp)
    80025c78:	6906                	ld	s2,64(sp)
    80025c7a:	79e2                	ld	s3,56(sp)
    80025c7c:	7a42                	ld	s4,48(sp)
    80025c7e:	7aa2                	ld	s5,40(sp)
    80025c80:	7b02                	ld	s6,32(sp)
    80025c82:	6be2                	ld	s7,24(sp)
    80025c84:	6c42                	ld	s8,16(sp)
    80025c86:	6ca2                	ld	s9,8(sp)
    80025c88:	6d02                	ld	s10,0(sp)
    80025c8a:	6125                	addi	sp,sp,96
    80025c8c:	8082                	ret
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025c8e:	89da                	mv	s3,s6
    80025c90:	bff9                	j	80025c6e <eread+0xd0>
        return 0;
    80025c92:	4501                	li	a0,0
}
    80025c94:	8082                	ret

0000000080025c96 <ewrite>:
    if (off > entry->file_size || off + n < off || (uint64)off + n > 0xffffffff
    80025c96:	10852783          	lw	a5,264(a0)
    80025c9a:	0ed7e363          	bltu	a5,a3,80025d80 <ewrite+0xea>
{
    80025c9e:	711d                	addi	sp,sp,-96
    80025ca0:	ec86                	sd	ra,88(sp)
    80025ca2:	e8a2                	sd	s0,80(sp)
    80025ca4:	e4a6                	sd	s1,72(sp)
    80025ca6:	e0ca                	sd	s2,64(sp)
    80025ca8:	fc4e                	sd	s3,56(sp)
    80025caa:	f852                	sd	s4,48(sp)
    80025cac:	f456                	sd	s5,40(sp)
    80025cae:	f05a                	sd	s6,32(sp)
    80025cb0:	ec5e                	sd	s7,24(sp)
    80025cb2:	e862                	sd	s8,16(sp)
    80025cb4:	e466                	sd	s9,8(sp)
    80025cb6:	1080                	addi	s0,sp,96
    80025cb8:	8aaa                	mv	s5,a0
    80025cba:	8bae                	mv	s7,a1
    80025cbc:	8a32                	mv	s4,a2
    80025cbe:	8936                	mv	s2,a3
    80025cc0:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (uint64)off + n > 0xffffffff
    80025cc2:	00e687bb          	addw	a5,a3,a4
    80025cc6:	0ad7ef63          	bltu	a5,a3,80025d84 <ewrite+0xee>
    80025cca:	02069793          	slli	a5,a3,0x20
    80025cce:	9381                	srli	a5,a5,0x20
    80025cd0:	1702                	slli	a4,a4,0x20
    80025cd2:	9301                	srli	a4,a4,0x20
    80025cd4:	97ba                	add	a5,a5,a4
    80025cd6:	577d                	li	a4,-1
    80025cd8:	9301                	srli	a4,a4,0x20
    80025cda:	0af76763          	bltu	a4,a5,80025d88 <ewrite+0xf2>
        || (entry->attribute & ATTR_READ_ONLY)) {
    80025cde:	10054783          	lbu	a5,256(a0)
    80025ce2:	8b85                	andi	a5,a5,1
    80025ce4:	e7c5                	bnez	a5,80025d8c <ewrite+0xf6>
    if (entry->first_clus == 0) {   // so file_size if 0 too, which requests off == 0
    80025ce6:	10452783          	lw	a5,260(a0)
    80025cea:	cb91                	beqz	a5,80025cfe <ewrite+0x68>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025cec:	4981                	li	s3,0
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025cee:	0001bc17          	auipc	s8,0x1b
    80025cf2:	73ac0c13          	addi	s8,s8,1850 # 80041428 <fat>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025cf6:	040b1d63          	bnez	s6,80025d50 <ewrite+0xba>
    80025cfa:	89da                	mv	s3,s6
    80025cfc:	a05d                	j	80025da2 <ewrite+0x10c>
        entry->cur_clus = entry->first_clus = alloc_clus(entry->dev);
    80025cfe:	11454503          	lbu	a0,276(a0)
    80025d02:	fffff097          	auipc	ra,0xfffff
    80025d06:	688080e7          	jalr	1672(ra) # 8002538a <alloc_clus>
    80025d0a:	2501                	sext.w	a0,a0
    80025d0c:	10aaa223          	sw	a0,260(s5)
    80025d10:	10aaa623          	sw	a0,268(s5)
        entry->clus_cnt = 0;
    80025d14:	100aa823          	sw	zero,272(s5)
        entry->dirty = 1;
    80025d18:	4785                	li	a5,1
    80025d1a:	10fa8aa3          	sb	a5,277(s5)
    80025d1e:	b7f9                	j	80025cec <ewrite+0x56>
    80025d20:	00048c9b          	sext.w	s9,s1
        if (rw_clus(entry->cur_clus, 1, user_src, src, off % fat.byts_per_clus, m) != m) {
    80025d24:	87e6                	mv	a5,s9
    80025d26:	86d2                	mv	a3,s4
    80025d28:	865e                	mv	a2,s7
    80025d2a:	4585                	li	a1,1
    80025d2c:	10caa503          	lw	a0,268(s5)
    80025d30:	00000097          	auipc	ra,0x0
    80025d34:	932080e7          	jalr	-1742(ra) # 80025662 <rw_clus>
    80025d38:	2501                	sext.w	a0,a0
    80025d3a:	04ac9b63          	bne	s9,a0,80025d90 <ewrite+0xfa>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025d3e:	013489bb          	addw	s3,s1,s3
    80025d42:	0124893b          	addw	s2,s1,s2
    80025d46:	1482                	slli	s1,s1,0x20
    80025d48:	9081                	srli	s1,s1,0x20
    80025d4a:	9a26                	add	s4,s4,s1
    80025d4c:	0569f263          	bgeu	s3,s6,80025d90 <ewrite+0xfa>
        reloc_clus(entry, off, 1);
    80025d50:	4605                	li	a2,1
    80025d52:	85ca                	mv	a1,s2
    80025d54:	8556                	mv	a0,s5
    80025d56:	fffff097          	auipc	ra,0xfffff
    80025d5a:	7fa080e7          	jalr	2042(ra) # 80025550 <reloc_clus>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025d5e:	00cc2783          	lw	a5,12(s8)
    80025d62:	02f976bb          	remuw	a3,s2,a5
    80025d66:	0006871b          	sext.w	a4,a3
    80025d6a:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    80025d6c:	413b06bb          	subw	a3,s6,s3
    80025d70:	84b6                	mv	s1,a3
    80025d72:	2681                	sext.w	a3,a3
    80025d74:	0007861b          	sext.w	a2,a5
    80025d78:	fad674e3          	bgeu	a2,a3,80025d20 <ewrite+0x8a>
    80025d7c:	84be                	mv	s1,a5
    80025d7e:	b74d                	j	80025d20 <ewrite+0x8a>
        return -1;
    80025d80:	557d                	li	a0,-1
}
    80025d82:	8082                	ret
        return -1;
    80025d84:	557d                	li	a0,-1
    80025d86:	a005                	j	80025da6 <ewrite+0x110>
    80025d88:	557d                	li	a0,-1
    80025d8a:	a831                	j	80025da6 <ewrite+0x110>
    80025d8c:	557d                	li	a0,-1
    80025d8e:	a821                	j	80025da6 <ewrite+0x110>
        if(off > entry->file_size) {
    80025d90:	108aa783          	lw	a5,264(s5)
    80025d94:	0127f763          	bgeu	a5,s2,80025da2 <ewrite+0x10c>
            entry->file_size = off;
    80025d98:	112aa423          	sw	s2,264(s5)
            entry->dirty = 1;
    80025d9c:	4785                	li	a5,1
    80025d9e:	10fa8aa3          	sb	a5,277(s5)
    return tot;
    80025da2:	0009851b          	sext.w	a0,s3
}
    80025da6:	60e6                	ld	ra,88(sp)
    80025da8:	6446                	ld	s0,80(sp)
    80025daa:	64a6                	ld	s1,72(sp)
    80025dac:	6906                	ld	s2,64(sp)
    80025dae:	79e2                	ld	s3,56(sp)
    80025db0:	7a42                	ld	s4,48(sp)
    80025db2:	7aa2                	ld	s5,40(sp)
    80025db4:	7b02                	ld	s6,32(sp)
    80025db6:	6be2                	ld	s7,24(sp)
    80025db8:	6c42                	ld	s8,16(sp)
    80025dba:	6ca2                	ld	s9,8(sp)
    80025dbc:	6125                	addi	sp,sp,96
    80025dbe:	8082                	ret

0000000080025dc0 <formatname>:
{
    80025dc0:	7179                	addi	sp,sp,-48
    80025dc2:	f406                	sd	ra,40(sp)
    80025dc4:	f022                	sd	s0,32(sp)
    80025dc6:	ec26                	sd	s1,24(sp)
    80025dc8:	e84a                	sd	s2,16(sp)
    80025dca:	e44e                	sd	s3,8(sp)
    80025dcc:	e052                	sd	s4,0(sp)
    80025dce:	1800                	addi	s0,sp,48
    80025dd0:	84aa                	mv	s1,a0
    while (*name == ' ' || *name == '.') { name++; }
    80025dd2:	02000793          	li	a5,32
    80025dd6:	02e00713          	li	a4,46
    80025dda:	a011                	j	80025dde <formatname+0x1e>
    80025ddc:	0485                	addi	s1,s1,1
    80025dde:	0004c583          	lbu	a1,0(s1)
    80025de2:	fef58de3          	beq	a1,a5,80025ddc <formatname+0x1c>
    80025de6:	fee58be3          	beq	a1,a4,80025ddc <formatname+0x1c>
    for (p = name; *p; p++) {
    80025dea:	c5b9                	beqz	a1,80025e38 <formatname+0x78>
        if (c < 0x20 || strchr(illegal, c)) {
    80025dec:	47fd                	li	a5,31
    80025dee:	04b7f763          	bgeu	a5,a1,80025e3c <formatname+0x7c>
    80025df2:	8926                	mv	s2,s1
    80025df4:	00009997          	auipc	s3,0x9
    80025df8:	d6c98993          	addi	s3,s3,-660 # 8002eb60 <illegal.1662>
    80025dfc:	4a7d                	li	s4,31
    80025dfe:	854e                	mv	a0,s3
    80025e00:	ffffb097          	auipc	ra,0xffffb
    80025e04:	bf0080e7          	jalr	-1040(ra) # 800209f0 <strchr>
    80025e08:	ed05                	bnez	a0,80025e40 <formatname+0x80>
    for (p = name; *p; p++) {
    80025e0a:	0905                	addi	s2,s2,1
    80025e0c:	00094583          	lbu	a1,0(s2)
    80025e10:	c581                	beqz	a1,80025e18 <formatname+0x58>
        if (c < 0x20 || strchr(illegal, c)) {
    80025e12:	feba66e3          	bltu	s4,a1,80025dfe <formatname+0x3e>
    80025e16:	a035                	j	80025e42 <formatname+0x82>
        if (*p != ' ') {
    80025e18:	02000693          	li	a3,32
    80025e1c:	874a                	mv	a4,s2
    while (p-- > name) {
    80025e1e:	0124fb63          	bgeu	s1,s2,80025e34 <formatname+0x74>
        if (*p != ' ') {
    80025e22:	197d                	addi	s2,s2,-1
    80025e24:	00094783          	lbu	a5,0(s2)
    80025e28:	fed78ae3          	beq	a5,a3,80025e1c <formatname+0x5c>
            p[1] = '\0';
    80025e2c:	00070023          	sb	zero,0(a4)
            break;
    80025e30:	8526                	mv	a0,s1
    80025e32:	a801                	j	80025e42 <formatname+0x82>
    80025e34:	8526                	mv	a0,s1
    80025e36:	a031                	j	80025e42 <formatname+0x82>
    for (p = name; *p; p++) {
    80025e38:	8526                	mv	a0,s1
    80025e3a:	a021                	j	80025e42 <formatname+0x82>
            return 0;
    80025e3c:	4501                	li	a0,0
    80025e3e:	a011                	j	80025e42 <formatname+0x82>
    80025e40:	4501                	li	a0,0
}
    80025e42:	70a2                	ld	ra,40(sp)
    80025e44:	7402                	ld	s0,32(sp)
    80025e46:	64e2                	ld	s1,24(sp)
    80025e48:	6942                	ld	s2,16(sp)
    80025e4a:	69a2                	ld	s3,8(sp)
    80025e4c:	6a02                	ld	s4,0(sp)
    80025e4e:	6145                	addi	sp,sp,48
    80025e50:	8082                	ret

0000000080025e52 <cal_checksum>:
{
    80025e52:	1141                	addi	sp,sp,-16
    80025e54:	e422                	sd	s0,8(sp)
    80025e56:	0800                	addi	s0,sp,16
    for (int i = CHAR_SHORT_NAME; i != 0; i--) {
    80025e58:	00b50613          	addi	a2,a0,11
    uint8 sum = 0;
    80025e5c:	4781                	li	a5,0
        sum = ((sum & 1) ? 0x80 : 0) + (sum >> 1) + *shortname++;
    80025e5e:	0077971b          	slliw	a4,a5,0x7
    80025e62:	0505                	addi	a0,a0,1
    80025e64:	0017d79b          	srliw	a5,a5,0x1
    80025e68:	fff54683          	lbu	a3,-1(a0)
    80025e6c:	9fb5                	addw	a5,a5,a3
    80025e6e:	97ba                	add	a5,a5,a4
    80025e70:	0ff7f793          	andi	a5,a5,255
    for (int i = CHAR_SHORT_NAME; i != 0; i--) {
    80025e74:	fea615e3          	bne	a2,a0,80025e5e <cal_checksum+0xc>
}
    80025e78:	853e                	mv	a0,a5
    80025e7a:	6422                	ld	s0,8(sp)
    80025e7c:	0141                	addi	sp,sp,16
    80025e7e:	8082                	ret

0000000080025e80 <emake>:
{
    80025e80:	7171                	addi	sp,sp,-176
    80025e82:	f506                	sd	ra,168(sp)
    80025e84:	f122                	sd	s0,160(sp)
    80025e86:	ed26                	sd	s1,152(sp)
    80025e88:	e94a                	sd	s2,144(sp)
    80025e8a:	e54e                	sd	s3,136(sp)
    80025e8c:	e152                	sd	s4,128(sp)
    80025e8e:	fcd6                	sd	s5,120(sp)
    80025e90:	f8da                	sd	s6,112(sp)
    80025e92:	f4de                	sd	s7,104(sp)
    80025e94:	f0e2                	sd	s8,96(sp)
    80025e96:	ece6                	sd	s9,88(sp)
    80025e98:	e8ea                	sd	s10,80(sp)
    80025e9a:	e4ee                	sd	s11,72(sp)
    80025e9c:	1900                	addi	s0,sp,176
    if (!(dp->attribute & ATTR_DIRECTORY))
    80025e9e:	10054783          	lbu	a5,256(a0)
    80025ea2:	8bc1                	andi	a5,a5,16
    80025ea4:	c3d5                	beqz	a5,80025f48 <emake+0xc8>
    80025ea6:	89aa                	mv	s3,a0
    80025ea8:	8aae                	mv	s5,a1
    80025eaa:	8932                	mv	s2,a2
    if (off % sizeof(union dentry))
    80025eac:	01f67793          	andi	a5,a2,31
    80025eb0:	e7c5                	bnez	a5,80025f58 <emake+0xd8>
    memset(&de, 0, sizeof(de));
    80025eb2:	02000613          	li	a2,32
    80025eb6:	4581                	li	a1,0
    80025eb8:	f7040513          	addi	a0,s0,-144
    80025ebc:	ffffb097          	auipc	ra,0xffffb
    80025ec0:	8a0080e7          	jalr	-1888(ra) # 8002075c <memset>
    if (off <= 32) {
    80025ec4:	02000793          	li	a5,32
    80025ec8:	0b27ec63          	bltu	a5,s2,80025f80 <emake+0x100>
        if (off == 0) {
    80025ecc:	08091e63          	bnez	s2,80025f68 <emake+0xe8>
            strncpy(de.sne.name, ".          ", sizeof(de.sne.name));
    80025ed0:	462d                	li	a2,11
    80025ed2:	00007597          	auipc	a1,0x7
    80025ed6:	ce658593          	addi	a1,a1,-794 # 8002cbb8 <syscalls+0xb00>
    80025eda:	f7040513          	addi	a0,s0,-144
    80025ede:	ffffb097          	auipc	ra,0xffffb
    80025ee2:	9b6080e7          	jalr	-1610(ra) # 80020894 <strncpy>
        de.sne.attr = ATTR_DIRECTORY;
    80025ee6:	47c1                	li	a5,16
    80025ee8:	f6f40da3          	sb	a5,-133(s0)
        de.sne.fst_clus_hi = (uint16)(ep->first_clus >> 16);        // first clus high 16 bits
    80025eec:	104aa783          	lw	a5,260(s5)
    80025ef0:	0107d71b          	srliw	a4,a5,0x10
    80025ef4:	f8e41223          	sh	a4,-124(s0)
        de.sne.fst_clus_lo = (uint16)(ep->first_clus & 0xffff);       // low 16 bits
    80025ef8:	f8f41523          	sh	a5,-118(s0)
        de.sne.file_size = 0;                                       // filesize is updated in eupdate()
    80025efc:	f8042623          	sw	zero,-116(s0)
        off = reloc_clus(dp, off, 1);
    80025f00:	4605                	li	a2,1
    80025f02:	85ca                	mv	a1,s2
    80025f04:	854e                	mv	a0,s3
    80025f06:	fffff097          	auipc	ra,0xfffff
    80025f0a:	64a080e7          	jalr	1610(ra) # 80025550 <reloc_clus>
        rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    80025f0e:	02000793          	li	a5,32
    80025f12:	0005071b          	sext.w	a4,a0
    80025f16:	f7040693          	addi	a3,s0,-144
    80025f1a:	4601                	li	a2,0
    80025f1c:	4585                	li	a1,1
    80025f1e:	10c9a503          	lw	a0,268(s3)
    80025f22:	fffff097          	auipc	ra,0xfffff
    80025f26:	740080e7          	jalr	1856(ra) # 80025662 <rw_clus>
}
    80025f2a:	70aa                	ld	ra,168(sp)
    80025f2c:	740a                	ld	s0,160(sp)
    80025f2e:	64ea                	ld	s1,152(sp)
    80025f30:	694a                	ld	s2,144(sp)
    80025f32:	69aa                	ld	s3,136(sp)
    80025f34:	6a0a                	ld	s4,128(sp)
    80025f36:	7ae6                	ld	s5,120(sp)
    80025f38:	7b46                	ld	s6,112(sp)
    80025f3a:	7ba6                	ld	s7,104(sp)
    80025f3c:	7c06                	ld	s8,96(sp)
    80025f3e:	6ce6                	ld	s9,88(sp)
    80025f40:	6d46                	ld	s10,80(sp)
    80025f42:	6da6                	ld	s11,72(sp)
    80025f44:	614d                	addi	sp,sp,176
    80025f46:	8082                	ret
        panic("emake: not dir");
    80025f48:	00007517          	auipc	a0,0x7
    80025f4c:	c4850513          	addi	a0,a0,-952 # 8002cb90 <syscalls+0xad8>
    80025f50:	ffffa097          	auipc	ra,0xffffa
    80025f54:	1f6080e7          	jalr	502(ra) # 80020146 <panic>
        panic("emake: not aligned");
    80025f58:	00007517          	auipc	a0,0x7
    80025f5c:	c4850513          	addi	a0,a0,-952 # 8002cba0 <syscalls+0xae8>
    80025f60:	ffffa097          	auipc	ra,0xffffa
    80025f64:	1e6080e7          	jalr	486(ra) # 80020146 <panic>
            strncpy(de.sne.name, "..         ", sizeof(de.sne.name));
    80025f68:	462d                	li	a2,11
    80025f6a:	00007597          	auipc	a1,0x7
    80025f6e:	c5e58593          	addi	a1,a1,-930 # 8002cbc8 <syscalls+0xb10>
    80025f72:	f7040513          	addi	a0,s0,-144
    80025f76:	ffffb097          	auipc	ra,0xffffb
    80025f7a:	91e080e7          	jalr	-1762(ra) # 80020894 <strncpy>
    80025f7e:	b7a5                	j	80025ee6 <emake+0x66>
        int entcnt = (strlen(ep->filename) + CHAR_LONG_NAME - 1) / CHAR_LONG_NAME;   // count of l-n-entries, rounds up
    80025f80:	8cd6                	mv	s9,s5
    80025f82:	8556                	mv	a0,s5
    80025f84:	ffffb097          	auipc	ra,0xffffb
    80025f88:	982080e7          	jalr	-1662(ra) # 80020906 <strlen>
    80025f8c:	f4a43c23          	sd	a0,-168(s0)
    80025f90:	00c5071b          	addiw	a4,a0,12
    80025f94:	47b5                	li	a5,13
    80025f96:	02f747bb          	divw	a5,a4,a5
    80025f9a:	f4f42a23          	sw	a5,-172(s0)
    80025f9e:	00078b1b          	sext.w	s6,a5
        memset(shortname, 0, sizeof(shortname));
    80025fa2:	4631                	li	a2,12
    80025fa4:	4581                	li	a1,0
    80025fa6:	f6040513          	addi	a0,s0,-160
    80025faa:	ffffa097          	auipc	ra,0xffffa
    80025fae:	7b2080e7          	jalr	1970(ra) # 8002075c <memset>
    for (int j = strlen(name) - 1; j >= 0; j--) {
    80025fb2:	8556                	mv	a0,s5
    80025fb4:	ffffb097          	auipc	ra,0xffffb
    80025fb8:	952080e7          	jalr	-1710(ra) # 80020906 <strlen>
    80025fbc:	fff5079b          	addiw	a5,a0,-1
    80025fc0:	0207cf63          	bltz	a5,80025ffe <emake+0x17e>
        if (name[j] == '.') {
    80025fc4:	00fa8733          	add	a4,s5,a5
    80025fc8:	00074603          	lbu	a2,0(a4)
    80025fcc:	02e00693          	li	a3,46
    80025fd0:	04d60363          	beq	a2,a3,80026016 <emake+0x196>
    80025fd4:	17fd                	addi	a5,a5,-1
    80025fd6:	97d6                	add	a5,a5,s5
    80025fd8:	ffea8693          	addi	a3,s5,-2
    80025fdc:	96aa                	add	a3,a3,a0
    80025fde:	fff5071b          	addiw	a4,a0,-1
    80025fe2:	1702                	slli	a4,a4,0x20
    80025fe4:	9301                	srli	a4,a4,0x20
    80025fe6:	8e99                	sub	a3,a3,a4
    80025fe8:	02e00613          	li	a2,46
    for (int j = strlen(name) - 1; j >= 0; j--) {
    80025fec:	00d78963          	beq	a5,a3,80025ffe <emake+0x17e>
        if (name[j] == '.') {
    80025ff0:	85be                	mv	a1,a5
    80025ff2:	17fd                	addi	a5,a5,-1
    80025ff4:	0017c703          	lbu	a4,1(a5) # 10000001 <BASE_ADDRESS-0x7001ffff>
    80025ff8:	fec71ae3          	bne	a4,a2,80025fec <emake+0x16c>
    80025ffc:	8cae                	mv	s9,a1
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025ffe:	001a8b93          	addi	s7,s5,1
    80026002:	000aca03          	lbu	s4,0(s5)
    80026006:	4481                	li	s1,0
    80026008:	000a0963          	beqz	s4,8002601a <emake+0x19a>
        if (i == 8 && p) {
    8002600c:	4c21                	li	s8,8
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    8002600e:	4d29                	li	s10,10
        if (c == '.') {
    80026010:	02e00d93          	li	s11,46
    80026014:	a0e1                	j	800260dc <emake+0x25c>
        if (name[j] == '.') {
    80026016:	8cba                	mv	s9,a4
    80026018:	b7dd                	j	80025ffe <emake+0x17e>
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    8002601a:	4481                	li	s1,0
    8002601c:	a039                	j	8002602a <emake+0x1aa>
        if (i == 8 && p) {
    8002601e:	1e0c8963          	beqz	s9,80026210 <emake+0x390>
            if (p + 1 < name) { break; }            // no '.'
    80026022:	001c8793          	addi	a5,s9,1
    80026026:	0777fd63          	bgeu	a5,s7,800260a0 <emake+0x220>
    8002602a:	f6040793          	addi	a5,s0,-160
    8002602e:	97a6                	add	a5,a5,s1
        shortname[i++] = ' ';
    80026030:	02000693          	li	a3,32
    while (i < CHAR_SHORT_NAME) {
    80026034:	4729                	li	a4,10
        shortname[i++] = ' ';
    80026036:	2485                	addiw	s1,s1,1
    80026038:	00d78023          	sb	a3,0(a5)
    8002603c:	0785                	addi	a5,a5,1
    while (i < CHAR_SHORT_NAME) {
    8002603e:	fe975ce3          	bge	a4,s1,80026036 <emake+0x1b6>
        de.lne.checksum = cal_checksum((uchar *)shortname);
    80026042:	f6040513          	addi	a0,s0,-160
    80026046:	00000097          	auipc	ra,0x0
    8002604a:	e0c080e7          	jalr	-500(ra) # 80025e52 <cal_checksum>
    8002604e:	f6a40ea3          	sb	a0,-131(s0)
        de.lne.attr = ATTR_LONG_NAME;
    80026052:	47bd                	li	a5,15
    80026054:	f6f40da3          	sb	a5,-133(s0)
        for (int i = entcnt; i > 0; i--) {
    80026058:	f5843783          	ld	a5,-168(s0)
    8002605c:	0cf05363          	blez	a5,80026122 <emake+0x2a2>
    80026060:	f5442783          	lw	a5,-172(s0)
    80026064:	37fd                	addiw	a5,a5,-1
    80026066:	00179c1b          	slliw	s8,a5,0x1
    8002606a:	00fc0c3b          	addw	s8,s8,a5
    8002606e:	002c1c1b          	slliw	s8,s8,0x2
    80026072:	00fc0c3b          	addw	s8,s8,a5
    80026076:	9c56                	add	s8,s8,s5
    80026078:	8bda                	mv	s7,s6
            int end = 0;
    8002607a:	4c81                	li	s9,0
                    *w++ = 0xff;            // on k210, unaligned reading is illegal
    8002607c:	5a7d                	li	s4,-1
                switch (j) {
    8002607e:	44ad                	li	s1,11
    80026080:	aa8d                	j	800261f2 <emake+0x372>
            if (name > p) {                    // last '.'
    80026082:	057cf463          	bgeu	s9,s7,800260ca <emake+0x24a>
                memset(shortname + i, ' ', 8 - i);
    80026086:	4621                	li	a2,8
    80026088:	9e05                	subw	a2,a2,s1
    8002608a:	02000593          	li	a1,32
    8002608e:	f6040793          	addi	a5,s0,-160
    80026092:	00978533          	add	a0,a5,s1
    80026096:	ffffa097          	auipc	ra,0xffffa
    8002609a:	6c6080e7          	jalr	1734(ra) # 8002075c <memset>
    8002609e:	87de                	mv	a5,s7
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    800260a0:	84e2                	mv	s1,s8
    800260a2:	4c81                	li	s9,0
    800260a4:	a035                	j	800260d0 <emake+0x250>
            if (strchr(illegal, c) != NULL) {
    800260a6:	85d2                	mv	a1,s4
    800260a8:	00009517          	auipc	a0,0x9
    800260ac:	ad050513          	addi	a0,a0,-1328 # 8002eb78 <illegal.1678>
    800260b0:	ffffb097          	auipc	ra,0xffffb
    800260b4:	940080e7          	jalr	-1728(ra) # 800209f0 <strchr>
    800260b8:	c119                	beqz	a0,800260be <emake+0x23e>
                c = '_';
    800260ba:	05f00a13          	li	s4,95
        shortname[i++] = c;
    800260be:	f9040793          	addi	a5,s0,-112
    800260c2:	97a6                	add	a5,a5,s1
    800260c4:	fd478823          	sb	s4,-48(a5)
    800260c8:	2485                	addiw	s1,s1,1
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    800260ca:	f69d4ce3          	blt	s10,s1,80026042 <emake+0x1c2>
    800260ce:	87de                	mv	a5,s7
    800260d0:	00178b93          	addi	s7,a5,1
    800260d4:	0007ca03          	lbu	s4,0(a5)
    800260d8:	f40a09e3          	beqz	s4,8002602a <emake+0x1aa>
        if (i == 8 && p) {
    800260dc:	f58481e3          	beq	s1,s8,8002601e <emake+0x19e>
        if (c == ' ') { continue; }
    800260e0:	02000793          	li	a5,32
    800260e4:	fefa03e3          	beq	s4,a5,800260ca <emake+0x24a>
        if (c == '.') {
    800260e8:	f9ba0de3          	beq	s4,s11,80026082 <emake+0x202>
        if (c >= 'a' && c <= 'z') {
    800260ec:	f9fa079b          	addiw	a5,s4,-97
    800260f0:	0ff7f793          	andi	a5,a5,255
    800260f4:	4765                	li	a4,25
    800260f6:	faf768e3          	bltu	a4,a5,800260a6 <emake+0x226>
            c += 'A' - 'a';
    800260fa:	3a01                	addiw	s4,s4,-32
    800260fc:	0ffa7a13          	andi	s4,s4,255
    80026100:	bf7d                	j	800260be <emake+0x23e>
                de.lne.order |= LAST_LONG_ENTRY;
    80026102:	0407e793          	ori	a5,a5,64
    80026106:	f6f40823          	sb	a5,-144(s0)
    8002610a:	a8d5                	j	800261fe <emake+0x37e>
                    if ((*w++ = *p++) == 0) {
    8002610c:	0005c683          	lbu	a3,0(a1)
    80026110:	00d78023          	sb	a3,0(a5)
                        end = 1;
    80026114:	0016b693          	seqz	a3,a3
                    *w++ = 0;
    80026118:	000780a3          	sb	zero,1(a5)
    8002611c:	0789                	addi	a5,a5,2
                    if ((*w++ = *p++) == 0) {
    8002611e:	0585                	addi	a1,a1,1
    80026120:	a079                	j	800261ae <emake+0x32e>
        memset(&de, 0, sizeof(de));
    80026122:	02000613          	li	a2,32
    80026126:	4581                	li	a1,0
    80026128:	f7040513          	addi	a0,s0,-144
    8002612c:	ffffa097          	auipc	ra,0xffffa
    80026130:	630080e7          	jalr	1584(ra) # 8002075c <memset>
        strncpy(de.sne.name, shortname, sizeof(de.sne.name));
    80026134:	462d                	li	a2,11
    80026136:	f6040593          	addi	a1,s0,-160
    8002613a:	f7040513          	addi	a0,s0,-144
    8002613e:	ffffa097          	auipc	ra,0xffffa
    80026142:	756080e7          	jalr	1878(ra) # 80020894 <strncpy>
        de.sne.attr = ep->attribute;
    80026146:	100ac783          	lbu	a5,256(s5)
    8002614a:	f6f40da3          	sb	a5,-133(s0)
        de.sne.fst_clus_hi = (uint16)(ep->first_clus >> 16);      // first clus high 16 bits
    8002614e:	104aa783          	lw	a5,260(s5)
    80026152:	0107d71b          	srliw	a4,a5,0x10
    80026156:	f8e41223          	sh	a4,-124(s0)
        de.sne.fst_clus_lo = (uint16)(ep->first_clus & 0xffff);     // low 16 bits
    8002615a:	f8f41523          	sh	a5,-118(s0)
        de.sne.file_size = ep->file_size;                         // filesize is updated in eupdate()
    8002615e:	108aa783          	lw	a5,264(s5)
    80026162:	f8f42623          	sw	a5,-116(s0)
        off = reloc_clus(dp, off, 1);
    80026166:	4605                	li	a2,1
    80026168:	85ca                	mv	a1,s2
    8002616a:	854e                	mv	a0,s3
    8002616c:	fffff097          	auipc	ra,0xfffff
    80026170:	3e4080e7          	jalr	996(ra) # 80025550 <reloc_clus>
        rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    80026174:	02000793          	li	a5,32
    80026178:	0005071b          	sext.w	a4,a0
    8002617c:	f7040693          	addi	a3,s0,-144
    80026180:	4601                	li	a2,0
    80026182:	4585                	li	a1,1
    80026184:	10c9a503          	lw	a0,268(s3)
    80026188:	fffff097          	auipc	ra,0xfffff
    8002618c:	4da080e7          	jalr	1242(ra) # 80025662 <rw_clus>
}
    80026190:	bb69                	j	80025f2a <emake+0xaa>
                    case 5:     w = (uint8 *)de.lne.name2; break;
    80026192:	f7e40793          	addi	a5,s0,-130
    80026196:	a019                	j	8002619c <emake+0x31c>
                    case 11:    w = (uint8 *)de.lne.name3; break;
    80026198:	f8c40793          	addi	a5,s0,-116
    8002619c:	2705                	addiw	a4,a4,1
    8002619e:	fff7061b          	addiw	a2,a4,-1
                if (end) {
    800261a2:	d6ad                	beqz	a3,8002610c <emake+0x28c>
                    *w++ = 0xff;            // on k210, unaligned reading is illegal
    800261a4:	01478023          	sb	s4,0(a5)
                    *w++ = 0xff;
    800261a8:	014780a3          	sb	s4,1(a5)
    800261ac:	0789                	addi	a5,a5,2
                switch (j) {
    800261ae:	fea602e3          	beq	a2,a0,80026192 <emake+0x312>
    800261b2:	fe9603e3          	beq	a2,s1,80026198 <emake+0x318>
            for (int j = 1; j <= CHAR_LONG_NAME; j++) {
    800261b6:	0007061b          	sext.w	a2,a4
    800261ba:	fec851e3          	bge	a6,a2,8002619c <emake+0x31c>
            uint off2 = reloc_clus(dp, off, 1);
    800261be:	4605                	li	a2,1
    800261c0:	85ca                	mv	a1,s2
    800261c2:	854e                	mv	a0,s3
    800261c4:	fffff097          	auipc	ra,0xfffff
    800261c8:	38c080e7          	jalr	908(ra) # 80025550 <reloc_clus>
            rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off2, sizeof(de));
    800261cc:	02000793          	li	a5,32
    800261d0:	0005071b          	sext.w	a4,a0
    800261d4:	f7040693          	addi	a3,s0,-144
    800261d8:	8666                	mv	a2,s9
    800261da:	4585                	li	a1,1
    800261dc:	10c9a503          	lw	a0,268(s3)
    800261e0:	fffff097          	auipc	ra,0xfffff
    800261e4:	482080e7          	jalr	1154(ra) # 80025662 <rw_clus>
            off += sizeof(de);
    800261e8:	0209091b          	addiw	s2,s2,32
    800261ec:	1c4d                	addi	s8,s8,-13
        for (int i = entcnt; i > 0; i--) {
    800261ee:	f3705ae3          	blez	s7,80026122 <emake+0x2a2>
            if ((de.lne.order = i) == entcnt) {
    800261f2:	0ffbf793          	andi	a5,s7,255
    800261f6:	f0fb06e3          	beq	s6,a5,80026102 <emake+0x282>
    800261fa:	f6f40823          	sb	a5,-144(s0)
            char *p = ep->filename + (i - 1) * CHAR_LONG_NAME;
    800261fe:	3bfd                	addiw	s7,s7,-1
    80026200:	85e2                	mv	a1,s8
    80026202:	4709                	li	a4,2
            int end = 0;
    80026204:	86e6                	mv	a3,s9
            uint8 *w = (uint8 *)de.lne.name1;
    80026206:	f7140793          	addi	a5,s0,-143
                switch (j) {
    8002620a:	4515                	li	a0,5
            for (int j = 1; j <= CHAR_LONG_NAME; j++) {
    8002620c:	4835                	li	a6,13
    8002620e:	bf41                	j	8002619e <emake+0x31e>
        if (c == ' ') { continue; }
    80026210:	02000793          	li	a5,32
    80026214:	ecfa1ae3          	bne	s4,a5,800260e8 <emake+0x268>
    80026218:	87de                	mv	a5,s7
    8002621a:	bd5d                	j	800260d0 <emake+0x250>

000000008002621c <edup>:
{
    8002621c:	1101                	addi	sp,sp,-32
    8002621e:	ec06                	sd	ra,24(sp)
    80026220:	e822                	sd	s0,16(sp)
    80026222:	e426                	sd	s1,8(sp)
    80026224:	1000                	addi	s0,sp,32
    80026226:	84aa                	mv	s1,a0
    if (entry != 0) {
    80026228:	c515                	beqz	a0,80026254 <edup+0x38>
        acquire(&ecache.lock);
    8002622a:	0001b517          	auipc	a0,0x1b
    8002622e:	38e50513          	addi	a0,a0,910 # 800415b8 <ecache>
    80026232:	ffffa097          	auipc	ra,0xffffa
    80026236:	48e080e7          	jalr	1166(ra) # 800206c0 <acquire>
        entry->ref++;
    8002623a:	1184a783          	lw	a5,280(s1)
    8002623e:	2785                	addiw	a5,a5,1
    80026240:	10f4ac23          	sw	a5,280(s1)
        release(&ecache.lock);
    80026244:	0001b517          	auipc	a0,0x1b
    80026248:	37450513          	addi	a0,a0,884 # 800415b8 <ecache>
    8002624c:	ffffa097          	auipc	ra,0xffffa
    80026250:	4c8080e7          	jalr	1224(ra) # 80020714 <release>
}
    80026254:	8526                	mv	a0,s1
    80026256:	60e2                	ld	ra,24(sp)
    80026258:	6442                	ld	s0,16(sp)
    8002625a:	64a2                	ld	s1,8(sp)
    8002625c:	6105                	addi	sp,sp,32
    8002625e:	8082                	ret

0000000080026260 <eupdate>:
    if (!entry->dirty || entry->valid != 1) { return; }
    80026260:	11554783          	lbu	a5,277(a0)
    80026264:	c791                	beqz	a5,80026270 <eupdate+0x10>
    80026266:	11651703          	lh	a4,278(a0)
    8002626a:	4785                	li	a5,1
    8002626c:	00f70363          	beq	a4,a5,80026272 <eupdate+0x12>
    80026270:	8082                	ret
{
    80026272:	715d                	addi	sp,sp,-80
    80026274:	e486                	sd	ra,72(sp)
    80026276:	e0a2                	sd	s0,64(sp)
    80026278:	fc26                	sd	s1,56(sp)
    8002627a:	f84a                	sd	s2,48(sp)
    8002627c:	0880                	addi	s0,sp,80
    8002627e:	84aa                	mv	s1,a0
    uint entcnt = 0;
    80026280:	fc042e23          	sw	zero,-36(s0)
    uint32 off = reloc_clus(entry->parent, entry->off, 0);
    80026284:	4601                	li	a2,0
    80026286:	11c52583          	lw	a1,284(a0)
    8002628a:	12053503          	ld	a0,288(a0)
    8002628e:	fffff097          	auipc	ra,0xfffff
    80026292:	2c2080e7          	jalr	706(ra) # 80025550 <reloc_clus>
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64) &entcnt, off, 1);
    80026296:	1204b803          	ld	a6,288(s1)
    8002629a:	4785                	li	a5,1
    8002629c:	0005071b          	sext.w	a4,a0
    800262a0:	fdc40693          	addi	a3,s0,-36
    800262a4:	4601                	li	a2,0
    800262a6:	4581                	li	a1,0
    800262a8:	10c82503          	lw	a0,268(a6)
    800262ac:	fffff097          	auipc	ra,0xfffff
    800262b0:	3b6080e7          	jalr	950(ra) # 80025662 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    800262b4:	fdc42583          	lw	a1,-36(s0)
    800262b8:	fbf5f593          	andi	a1,a1,-65
    800262bc:	fcb42e23          	sw	a1,-36(s0)
    off = reloc_clus(entry->parent, entry->off + (entcnt << 5), 0);
    800262c0:	0055959b          	slliw	a1,a1,0x5
    800262c4:	11c4a783          	lw	a5,284(s1)
    800262c8:	4601                	li	a2,0
    800262ca:	9dbd                	addw	a1,a1,a5
    800262cc:	1204b503          	ld	a0,288(s1)
    800262d0:	fffff097          	auipc	ra,0xfffff
    800262d4:	280080e7          	jalr	640(ra) # 80025550 <reloc_clus>
    800262d8:	0005091b          	sext.w	s2,a0
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64)&de, off, sizeof(de));
    800262dc:	1204b503          	ld	a0,288(s1)
    800262e0:	02000793          	li	a5,32
    800262e4:	874a                	mv	a4,s2
    800262e6:	fb840693          	addi	a3,s0,-72
    800262ea:	4601                	li	a2,0
    800262ec:	4581                	li	a1,0
    800262ee:	10c52503          	lw	a0,268(a0)
    800262f2:	fffff097          	auipc	ra,0xfffff
    800262f6:	370080e7          	jalr	880(ra) # 80025662 <rw_clus>
    de.sne.fst_clus_hi = (uint16)(entry->first_clus >> 16);
    800262fa:	1044a783          	lw	a5,260(s1)
    800262fe:	0107d71b          	srliw	a4,a5,0x10
    80026302:	fce41623          	sh	a4,-52(s0)
    de.sne.fst_clus_lo = (uint16)(entry->first_clus & 0xffff);
    80026306:	fcf41923          	sh	a5,-46(s0)
    de.sne.file_size = entry->file_size;
    8002630a:	1084a783          	lw	a5,264(s1)
    8002630e:	fcf42a23          	sw	a5,-44(s0)
    rw_clus(entry->parent->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    80026312:	1204b503          	ld	a0,288(s1)
    80026316:	02000793          	li	a5,32
    8002631a:	874a                	mv	a4,s2
    8002631c:	fb840693          	addi	a3,s0,-72
    80026320:	4601                	li	a2,0
    80026322:	4585                	li	a1,1
    80026324:	10c52503          	lw	a0,268(a0)
    80026328:	fffff097          	auipc	ra,0xfffff
    8002632c:	33a080e7          	jalr	826(ra) # 80025662 <rw_clus>
    entry->dirty = 0;
    80026330:	10048aa3          	sb	zero,277(s1)
}
    80026334:	60a6                	ld	ra,72(sp)
    80026336:	6406                	ld	s0,64(sp)
    80026338:	74e2                	ld	s1,56(sp)
    8002633a:	7942                	ld	s2,48(sp)
    8002633c:	6161                	addi	sp,sp,80
    8002633e:	8082                	ret

0000000080026340 <eremove>:
    if (entry->valid != 1) { return; }
    80026340:	11651703          	lh	a4,278(a0)
    80026344:	4785                	li	a5,1
    80026346:	00f70363          	beq	a4,a5,8002634c <eremove+0xc>
    8002634a:	8082                	ret
{
    8002634c:	7139                	addi	sp,sp,-64
    8002634e:	fc06                	sd	ra,56(sp)
    80026350:	f822                	sd	s0,48(sp)
    80026352:	f426                	sd	s1,40(sp)
    80026354:	f04a                	sd	s2,32(sp)
    80026356:	ec4e                	sd	s3,24(sp)
    80026358:	e852                	sd	s4,16(sp)
    8002635a:	0080                	addi	s0,sp,64
    8002635c:	84aa                	mv	s1,a0
    uint entcnt = 0;
    8002635e:	fc042623          	sw	zero,-52(s0)
    uint32 off = entry->off;
    80026362:	11c52903          	lw	s2,284(a0)
    uint32 off2 = reloc_clus(entry->parent, off, 0);
    80026366:	4601                	li	a2,0
    80026368:	85ca                	mv	a1,s2
    8002636a:	12053503          	ld	a0,288(a0)
    8002636e:	fffff097          	auipc	ra,0xfffff
    80026372:	1e2080e7          	jalr	482(ra) # 80025550 <reloc_clus>
    80026376:	0005099b          	sext.w	s3,a0
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64) &entcnt, off2, 1);
    8002637a:	1204b503          	ld	a0,288(s1)
    8002637e:	4785                	li	a5,1
    80026380:	874e                	mv	a4,s3
    80026382:	fcc40693          	addi	a3,s0,-52
    80026386:	4601                	li	a2,0
    80026388:	4581                	li	a1,0
    8002638a:	10c52503          	lw	a0,268(a0)
    8002638e:	fffff097          	auipc	ra,0xfffff
    80026392:	2d4080e7          	jalr	724(ra) # 80025662 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    80026396:	fcc42783          	lw	a5,-52(s0)
    8002639a:	fbf7f793          	andi	a5,a5,-65
    8002639e:	fcf42623          	sw	a5,-52(s0)
    uint8 flag = EMPTY_ENTRY;
    800263a2:	5795                	li	a5,-27
    800263a4:	fcf405a3          	sb	a5,-53(s0)
    for (int i = 0; i <= entcnt; i++) {
    800263a8:	4a01                	li	s4,0
        rw_clus(entry->parent->cur_clus, 1, 0, (uint64) &flag, off2, 1);
    800263aa:	1204b503          	ld	a0,288(s1)
    800263ae:	4785                	li	a5,1
    800263b0:	874e                	mv	a4,s3
    800263b2:	fcb40693          	addi	a3,s0,-53
    800263b6:	4601                	li	a2,0
    800263b8:	4585                	li	a1,1
    800263ba:	10c52503          	lw	a0,268(a0)
    800263be:	fffff097          	auipc	ra,0xfffff
    800263c2:	2a4080e7          	jalr	676(ra) # 80025662 <rw_clus>
        off += 32;
    800263c6:	0209091b          	addiw	s2,s2,32
        off2 = reloc_clus(entry->parent, off, 0);
    800263ca:	4601                	li	a2,0
    800263cc:	85ca                	mv	a1,s2
    800263ce:	1204b503          	ld	a0,288(s1)
    800263d2:	fffff097          	auipc	ra,0xfffff
    800263d6:	17e080e7          	jalr	382(ra) # 80025550 <reloc_clus>
    800263da:	0005099b          	sext.w	s3,a0
    for (int i = 0; i <= entcnt; i++) {
    800263de:	001a079b          	addiw	a5,s4,1
    800263e2:	00078a1b          	sext.w	s4,a5
    800263e6:	fcc42703          	lw	a4,-52(s0)
    800263ea:	fd4770e3          	bgeu	a4,s4,800263aa <eremove+0x6a>
    entry->valid = -1;
    800263ee:	57fd                	li	a5,-1
    800263f0:	10f49b23          	sh	a5,278(s1)
}
    800263f4:	70e2                	ld	ra,56(sp)
    800263f6:	7442                	ld	s0,48(sp)
    800263f8:	74a2                	ld	s1,40(sp)
    800263fa:	7902                	ld	s2,32(sp)
    800263fc:	69e2                	ld	s3,24(sp)
    800263fe:	6a42                	ld	s4,16(sp)
    80026400:	6121                	addi	sp,sp,64
    80026402:	8082                	ret

0000000080026404 <etrunc>:
{
    80026404:	7179                	addi	sp,sp,-48
    80026406:	f406                	sd	ra,40(sp)
    80026408:	f022                	sd	s0,32(sp)
    8002640a:	ec26                	sd	s1,24(sp)
    8002640c:	e84a                	sd	s2,16(sp)
    8002640e:	e44e                	sd	s3,8(sp)
    80026410:	e052                	sd	s4,0(sp)
    80026412:	1800                	addi	s0,sp,48
    80026414:	8a2a                	mv	s4,a0
    for (uint32 clus = entry->first_clus; clus >= 2 && clus < FAT32_EOC; ) {
    80026416:	10452903          	lw	s2,260(a0)
    8002641a:	ffe9071b          	addiw	a4,s2,-2
    8002641e:	100007b7          	lui	a5,0x10000
    80026422:	17d5                	addi	a5,a5,-11
    80026424:	02e7e563          	bltu	a5,a4,8002644e <etrunc+0x4a>
    80026428:	89be                	mv	s3,a5
        uint32 next = read_fat(clus);
    8002642a:	854a                	mv	a0,s2
    8002642c:	fffff097          	auipc	ra,0xfffff
    80026430:	eec080e7          	jalr	-276(ra) # 80025318 <read_fat>
    80026434:	0005049b          	sext.w	s1,a0
    write_fat(cluster, 0);
    80026438:	4581                	li	a1,0
    8002643a:	854a                	mv	a0,s2
    8002643c:	fffff097          	auipc	ra,0xfffff
    80026440:	096080e7          	jalr	150(ra) # 800254d2 <write_fat>
        clus = next;
    80026444:	0004891b          	sext.w	s2,s1
    for (uint32 clus = entry->first_clus; clus >= 2 && clus < FAT32_EOC; ) {
    80026448:	34f9                	addiw	s1,s1,-2
    8002644a:	fe99f0e3          	bgeu	s3,s1,8002642a <etrunc+0x26>
    entry->file_size = 0;
    8002644e:	100a2423          	sw	zero,264(s4)
    entry->first_clus = 0;
    80026452:	100a2223          	sw	zero,260(s4)
    entry->dirty = 1;
    80026456:	4785                	li	a5,1
    80026458:	10fa0aa3          	sb	a5,277(s4)
}
    8002645c:	70a2                	ld	ra,40(sp)
    8002645e:	7402                	ld	s0,32(sp)
    80026460:	64e2                	ld	s1,24(sp)
    80026462:	6942                	ld	s2,16(sp)
    80026464:	69a2                	ld	s3,8(sp)
    80026466:	6a02                	ld	s4,0(sp)
    80026468:	6145                	addi	sp,sp,48
    8002646a:	8082                	ret

000000008002646c <elock>:
{
    8002646c:	1141                	addi	sp,sp,-16
    8002646e:	e406                	sd	ra,8(sp)
    80026470:	e022                	sd	s0,0(sp)
    80026472:	0800                	addi	s0,sp,16
    if (entry == 0 || entry->ref < 1)
    80026474:	cd19                	beqz	a0,80026492 <elock+0x26>
    80026476:	11852783          	lw	a5,280(a0)
    8002647a:	00f05c63          	blez	a5,80026492 <elock+0x26>
    acquiresleep(&entry->lock);
    8002647e:	13850513          	addi	a0,a0,312
    80026482:	ffffd097          	auipc	ra,0xffffd
    80026486:	410080e7          	jalr	1040(ra) # 80023892 <acquiresleep>
}
    8002648a:	60a2                	ld	ra,8(sp)
    8002648c:	6402                	ld	s0,0(sp)
    8002648e:	0141                	addi	sp,sp,16
    80026490:	8082                	ret
        panic("elock");
    80026492:	00006517          	auipc	a0,0x6
    80026496:	74650513          	addi	a0,a0,1862 # 8002cbd8 <syscalls+0xb20>
    8002649a:	ffffa097          	auipc	ra,0xffffa
    8002649e:	cac080e7          	jalr	-852(ra) # 80020146 <panic>

00000000800264a2 <eunlock>:
{
    800264a2:	1101                	addi	sp,sp,-32
    800264a4:	ec06                	sd	ra,24(sp)
    800264a6:	e822                	sd	s0,16(sp)
    800264a8:	e426                	sd	s1,8(sp)
    800264aa:	e04a                	sd	s2,0(sp)
    800264ac:	1000                	addi	s0,sp,32
    if (entry == 0 || !holdingsleep(&entry->lock) || entry->ref < 1)
    800264ae:	c90d                	beqz	a0,800264e0 <eunlock+0x3e>
    800264b0:	84aa                	mv	s1,a0
    800264b2:	13850913          	addi	s2,a0,312
    800264b6:	854a                	mv	a0,s2
    800264b8:	ffffd097          	auipc	ra,0xffffd
    800264bc:	474080e7          	jalr	1140(ra) # 8002392c <holdingsleep>
    800264c0:	c105                	beqz	a0,800264e0 <eunlock+0x3e>
    800264c2:	1184a783          	lw	a5,280(s1)
    800264c6:	00f05d63          	blez	a5,800264e0 <eunlock+0x3e>
    releasesleep(&entry->lock);
    800264ca:	854a                	mv	a0,s2
    800264cc:	ffffd097          	auipc	ra,0xffffd
    800264d0:	41c080e7          	jalr	1052(ra) # 800238e8 <releasesleep>
}
    800264d4:	60e2                	ld	ra,24(sp)
    800264d6:	6442                	ld	s0,16(sp)
    800264d8:	64a2                	ld	s1,8(sp)
    800264da:	6902                	ld	s2,0(sp)
    800264dc:	6105                	addi	sp,sp,32
    800264de:	8082                	ret
        panic("eunlock");
    800264e0:	00006517          	auipc	a0,0x6
    800264e4:	70050513          	addi	a0,a0,1792 # 8002cbe0 <syscalls+0xb28>
    800264e8:	ffffa097          	auipc	ra,0xffffa
    800264ec:	c5e080e7          	jalr	-930(ra) # 80020146 <panic>

00000000800264f0 <eput>:
{
    800264f0:	1101                	addi	sp,sp,-32
    800264f2:	ec06                	sd	ra,24(sp)
    800264f4:	e822                	sd	s0,16(sp)
    800264f6:	e426                	sd	s1,8(sp)
    800264f8:	e04a                	sd	s2,0(sp)
    800264fa:	1000                	addi	s0,sp,32
    800264fc:	84aa                	mv	s1,a0
    acquire(&ecache.lock);
    800264fe:	0001b517          	auipc	a0,0x1b
    80026502:	0ba50513          	addi	a0,a0,186 # 800415b8 <ecache>
    80026506:	ffffa097          	auipc	ra,0xffffa
    8002650a:	1ba080e7          	jalr	442(ra) # 800206c0 <acquire>
    if (entry != &root && entry->valid != 0 && entry->ref == 1) {
    8002650e:	0001b797          	auipc	a5,0x1b
    80026512:	f4278793          	addi	a5,a5,-190 # 80041450 <root>
    80026516:	00f48a63          	beq	s1,a5,8002652a <eput+0x3a>
    8002651a:	11649783          	lh	a5,278(s1)
    8002651e:	c791                	beqz	a5,8002652a <eput+0x3a>
    80026520:	1184a703          	lw	a4,280(s1)
    80026524:	4785                	li	a5,1
    80026526:	02f70563          	beq	a4,a5,80026550 <eput+0x60>
    entry->ref--;
    8002652a:	1184a783          	lw	a5,280(s1)
    8002652e:	37fd                	addiw	a5,a5,-1
    80026530:	10f4ac23          	sw	a5,280(s1)
    release(&ecache.lock);
    80026534:	0001b517          	auipc	a0,0x1b
    80026538:	08450513          	addi	a0,a0,132 # 800415b8 <ecache>
    8002653c:	ffffa097          	auipc	ra,0xffffa
    80026540:	1d8080e7          	jalr	472(ra) # 80020714 <release>
}
    80026544:	60e2                	ld	ra,24(sp)
    80026546:	6442                	ld	s0,16(sp)
    80026548:	64a2                	ld	s1,8(sp)
    8002654a:	6902                	ld	s2,0(sp)
    8002654c:	6105                	addi	sp,sp,32
    8002654e:	8082                	ret
        acquiresleep(&entry->lock);
    80026550:	13848913          	addi	s2,s1,312
    80026554:	854a                	mv	a0,s2
    80026556:	ffffd097          	auipc	ra,0xffffd
    8002655a:	33c080e7          	jalr	828(ra) # 80023892 <acquiresleep>
        entry->next->prev = entry->prev;
    8002655e:	1284b703          	ld	a4,296(s1)
    80026562:	1304b783          	ld	a5,304(s1)
    80026566:	12f73823          	sd	a5,304(a4)
        entry->prev->next = entry->next;
    8002656a:	1284b703          	ld	a4,296(s1)
    8002656e:	12e7b423          	sd	a4,296(a5)
        entry->next = root.next;
    80026572:	0001b797          	auipc	a5,0x1b
    80026576:	eb678793          	addi	a5,a5,-330 # 80041428 <fat>
    8002657a:	1507b703          	ld	a4,336(a5)
    8002657e:	12e4b423          	sd	a4,296(s1)
        entry->prev = &root;
    80026582:	0001b697          	auipc	a3,0x1b
    80026586:	ece68693          	addi	a3,a3,-306 # 80041450 <root>
    8002658a:	12d4b823          	sd	a3,304(s1)
        root.next->prev = entry;
    8002658e:	12973823          	sd	s1,304(a4)
        root.next = entry;
    80026592:	1497b823          	sd	s1,336(a5)
        release(&ecache.lock);
    80026596:	0001b517          	auipc	a0,0x1b
    8002659a:	02250513          	addi	a0,a0,34 # 800415b8 <ecache>
    8002659e:	ffffa097          	auipc	ra,0xffffa
    800265a2:	176080e7          	jalr	374(ra) # 80020714 <release>
        if (entry->valid == -1) {       // this means some one has called eremove()
    800265a6:	11649703          	lh	a4,278(s1)
    800265aa:	57fd                	li	a5,-1
    800265ac:	06f70863          	beq	a4,a5,8002661c <eput+0x12c>
            elock(entry->parent);
    800265b0:	1204b503          	ld	a0,288(s1)
    800265b4:	00000097          	auipc	ra,0x0
    800265b8:	eb8080e7          	jalr	-328(ra) # 8002646c <elock>
            eupdate(entry);
    800265bc:	8526                	mv	a0,s1
    800265be:	00000097          	auipc	ra,0x0
    800265c2:	ca2080e7          	jalr	-862(ra) # 80026260 <eupdate>
            eunlock(entry->parent);
    800265c6:	1204b503          	ld	a0,288(s1)
    800265ca:	00000097          	auipc	ra,0x0
    800265ce:	ed8080e7          	jalr	-296(ra) # 800264a2 <eunlock>
        releasesleep(&entry->lock);
    800265d2:	854a                	mv	a0,s2
    800265d4:	ffffd097          	auipc	ra,0xffffd
    800265d8:	314080e7          	jalr	788(ra) # 800238e8 <releasesleep>
        struct dirent *eparent = entry->parent;
    800265dc:	1204b903          	ld	s2,288(s1)
        acquire(&ecache.lock);
    800265e0:	0001b517          	auipc	a0,0x1b
    800265e4:	fd850513          	addi	a0,a0,-40 # 800415b8 <ecache>
    800265e8:	ffffa097          	auipc	ra,0xffffa
    800265ec:	0d8080e7          	jalr	216(ra) # 800206c0 <acquire>
        entry->ref--;
    800265f0:	1184a783          	lw	a5,280(s1)
    800265f4:	37fd                	addiw	a5,a5,-1
    800265f6:	10f4ac23          	sw	a5,280(s1)
        release(&ecache.lock);
    800265fa:	0001b517          	auipc	a0,0x1b
    800265fe:	fbe50513          	addi	a0,a0,-66 # 800415b8 <ecache>
    80026602:	ffffa097          	auipc	ra,0xffffa
    80026606:	112080e7          	jalr	274(ra) # 80020714 <release>
        if (entry->ref == 0) {
    8002660a:	1184a783          	lw	a5,280(s1)
    8002660e:	fb9d                	bnez	a5,80026544 <eput+0x54>
            eput(eparent);
    80026610:	854a                	mv	a0,s2
    80026612:	00000097          	auipc	ra,0x0
    80026616:	ede080e7          	jalr	-290(ra) # 800264f0 <eput>
    8002661a:	b72d                	j	80026544 <eput+0x54>
            etrunc(entry);
    8002661c:	8526                	mv	a0,s1
    8002661e:	00000097          	auipc	ra,0x0
    80026622:	de6080e7          	jalr	-538(ra) # 80026404 <etrunc>
    80026626:	b775                	j	800265d2 <eput+0xe2>

0000000080026628 <estat>:
{
    80026628:	1101                	addi	sp,sp,-32
    8002662a:	ec06                	sd	ra,24(sp)
    8002662c:	e822                	sd	s0,16(sp)
    8002662e:	e426                	sd	s1,8(sp)
    80026630:	e04a                	sd	s2,0(sp)
    80026632:	1000                	addi	s0,sp,32
    80026634:	892a                	mv	s2,a0
    80026636:	84ae                	mv	s1,a1
    strncpy(st->name, de->filename, STAT_MAX_NAME);
    80026638:	02000613          	li	a2,32
    8002663c:	85aa                	mv	a1,a0
    8002663e:	8526                	mv	a0,s1
    80026640:	ffffa097          	auipc	ra,0xffffa
    80026644:	254080e7          	jalr	596(ra) # 80020894 <strncpy>
    st->type = (de->attribute & ATTR_DIRECTORY) ? T_DIR : T_FILE;
    80026648:	10094783          	lbu	a5,256(s2)
    8002664c:	8bc1                	andi	a5,a5,16
    8002664e:	0017b793          	seqz	a5,a5
    80026652:	0785                	addi	a5,a5,1
    80026654:	02f49423          	sh	a5,40(s1)
    st->dev = de->dev;
    80026658:	11494783          	lbu	a5,276(s2)
    8002665c:	d0dc                	sw	a5,36(s1)
    st->size = de->file_size;
    8002665e:	10896783          	lwu	a5,264(s2)
    80026662:	f89c                	sd	a5,48(s1)
}
    80026664:	60e2                	ld	ra,24(sp)
    80026666:	6442                	ld	s0,16(sp)
    80026668:	64a2                	ld	s1,8(sp)
    8002666a:	6902                	ld	s2,0(sp)
    8002666c:	6105                	addi	sp,sp,32
    8002666e:	8082                	ret

0000000080026670 <enext>:
 * @return  -1      meet the end of dir
 *          0       find empty slots
 *          1       find a file with all its entries
 */
int enext(struct dirent *dp, struct dirent *ep, uint off, int *count)
{
    80026670:	7119                	addi	sp,sp,-128
    80026672:	fc86                	sd	ra,120(sp)
    80026674:	f8a2                	sd	s0,112(sp)
    80026676:	f4a6                	sd	s1,104(sp)
    80026678:	f0ca                	sd	s2,96(sp)
    8002667a:	ecce                	sd	s3,88(sp)
    8002667c:	e8d2                	sd	s4,80(sp)
    8002667e:	e4d6                	sd	s5,72(sp)
    80026680:	e0da                	sd	s6,64(sp)
    80026682:	fc5e                	sd	s7,56(sp)
    80026684:	f862                	sd	s8,48(sp)
    80026686:	f466                	sd	s9,40(sp)
    80026688:	0100                	addi	s0,sp,128
    if (!(dp->attribute & ATTR_DIRECTORY))
    8002668a:	10054783          	lbu	a5,256(a0)
    8002668e:	8bc1                	andi	a5,a5,16
    80026690:	cf95                	beqz	a5,800266cc <enext+0x5c>
    80026692:	892a                	mv	s2,a0
    80026694:	8bae                	mv	s7,a1
    80026696:	84b2                	mv	s1,a2
    80026698:	8ab6                	mv	s5,a3
        panic("enext not dir");
    if (ep->valid)
    8002669a:	11659783          	lh	a5,278(a1)
    8002669e:	ef9d                	bnez	a5,800266dc <enext+0x6c>
        panic("enext ep valid");
    if (off % 32)
    800266a0:	01f67793          	andi	a5,a2,31
    800266a4:	e7a1                	bnez	a5,800266ec <enext+0x7c>
        panic("enext not align");
    if (dp->valid != 1) { return -1; }
    800266a6:	11651703          	lh	a4,278(a0)
    800266aa:	4785                	li	a5,1
    800266ac:	557d                	li	a0,-1
    800266ae:	04f70763          	beq	a4,a5,800266fc <enext+0x8c>
            read_entry_info(ep, &de);
            return 1;
        }
    }
    return -1;
}
    800266b2:	70e6                	ld	ra,120(sp)
    800266b4:	7446                	ld	s0,112(sp)
    800266b6:	74a6                	ld	s1,104(sp)
    800266b8:	7906                	ld	s2,96(sp)
    800266ba:	69e6                	ld	s3,88(sp)
    800266bc:	6a46                	ld	s4,80(sp)
    800266be:	6aa6                	ld	s5,72(sp)
    800266c0:	6b06                	ld	s6,64(sp)
    800266c2:	7be2                	ld	s7,56(sp)
    800266c4:	7c42                	ld	s8,48(sp)
    800266c6:	7ca2                	ld	s9,40(sp)
    800266c8:	6109                	addi	sp,sp,128
    800266ca:	8082                	ret
        panic("enext not dir");
    800266cc:	00006517          	auipc	a0,0x6
    800266d0:	51c50513          	addi	a0,a0,1308 # 8002cbe8 <syscalls+0xb30>
    800266d4:	ffffa097          	auipc	ra,0xffffa
    800266d8:	a72080e7          	jalr	-1422(ra) # 80020146 <panic>
        panic("enext ep valid");
    800266dc:	00006517          	auipc	a0,0x6
    800266e0:	51c50513          	addi	a0,a0,1308 # 8002cbf8 <syscalls+0xb40>
    800266e4:	ffffa097          	auipc	ra,0xffffa
    800266e8:	a62080e7          	jalr	-1438(ra) # 80020146 <panic>
        panic("enext not align");
    800266ec:	00006517          	auipc	a0,0x6
    800266f0:	51c50513          	addi	a0,a0,1308 # 8002cc08 <syscalls+0xb50>
    800266f4:	ffffa097          	auipc	ra,0xffffa
    800266f8:	a52080e7          	jalr	-1454(ra) # 80020146 <panic>
    memset(ep->filename, 0, FAT32_MAX_FILENAME + 1);
    800266fc:	8cae                	mv	s9,a1
    800266fe:	10000613          	li	a2,256
    80026702:	4581                	li	a1,0
    80026704:	855e                	mv	a0,s7
    80026706:	ffffa097          	auipc	ra,0xffffa
    8002670a:	056080e7          	jalr	86(ra) # 8002075c <memset>
    int cnt = 0;
    8002670e:	4981                	li	s3,0
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    80026710:	5a7d                	li	s4,-1
        if (de.lne.order == EMPTY_ENTRY) {
    80026712:	0e500b13          	li	s6,229
        if (de.lne.attr == ATTR_LONG_NAME) {
    80026716:	4c3d                	li	s8,15
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    80026718:	a805                	j	80026748 <enext+0xd8>
            cnt++;
    8002671a:	2985                	addiw	s3,s3,1
            continue;
    8002671c:	a025                	j	80026744 <enext+0xd4>
            *count = cnt;
    8002671e:	013aa023          	sw	s3,0(s5)
            return 0;
    80026722:	4501                	li	a0,0
    80026724:	b779                	j	800266b2 <enext+0x42>
            read_entry_name(ep->filename + (lcnt - 1) * CHAR_LONG_NAME, &de);
    80026726:	fff5079b          	addiw	a5,a0,-1
    8002672a:	0017951b          	slliw	a0,a5,0x1
    8002672e:	9d3d                	addw	a0,a0,a5
    80026730:	0025151b          	slliw	a0,a0,0x2
    80026734:	9d3d                	addw	a0,a0,a5
    80026736:	f8040593          	addi	a1,s0,-128
    8002673a:	9566                	add	a0,a0,s9
    8002673c:	fffff097          	auipc	ra,0xfffff
    80026740:	196080e7          	jalr	406(ra) # 800258d2 <read_entry_name>
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    80026744:	0204849b          	addiw	s1,s1,32
    80026748:	4601                	li	a2,0
    8002674a:	85a6                	mv	a1,s1
    8002674c:	854a                	mv	a0,s2
    8002674e:	fffff097          	auipc	ra,0xfffff
    80026752:	e02080e7          	jalr	-510(ra) # 80025550 <reloc_clus>
    80026756:	f5450ee3          	beq	a0,s4,800266b2 <enext+0x42>
        if (rw_clus(dp->cur_clus, 0, 0, (uint64)&de, off2, 32) != 32 || de.lne.order == END_OF_ENTRY) {
    8002675a:	02000793          	li	a5,32
    8002675e:	0005071b          	sext.w	a4,a0
    80026762:	f8040693          	addi	a3,s0,-128
    80026766:	4601                	li	a2,0
    80026768:	4581                	li	a1,0
    8002676a:	10c92503          	lw	a0,268(s2)
    8002676e:	fffff097          	auipc	ra,0xfffff
    80026772:	ef4080e7          	jalr	-268(ra) # 80025662 <rw_clus>
    80026776:	2501                	sext.w	a0,a0
    80026778:	02000793          	li	a5,32
    8002677c:	06f51c63          	bne	a0,a5,800267f4 <enext+0x184>
    80026780:	f8044783          	lbu	a5,-128(s0)
    80026784:	cbb5                	beqz	a5,800267f8 <enext+0x188>
        if (de.lne.order == EMPTY_ENTRY) {
    80026786:	f9678ae3          	beq	a5,s6,8002671a <enext+0xaa>
        } else if (cnt) {
    8002678a:	f8099ae3          	bnez	s3,8002671e <enext+0xae>
        if (de.lne.attr == ATTR_LONG_NAME) {
    8002678e:	f8b44703          	lbu	a4,-117(s0)
    80026792:	01871d63          	bne	a4,s8,800267ac <enext+0x13c>
            int lcnt = de.lne.order & ~LAST_LONG_ENTRY;
    80026796:	0bf7f513          	andi	a0,a5,191
            if (de.lne.order & LAST_LONG_ENTRY) {
    8002679a:	0407f793          	andi	a5,a5,64
    8002679e:	d7c1                	beqz	a5,80026726 <enext+0xb6>
                *count = lcnt + 1;                              // plus the s-n-e;
    800267a0:	0015079b          	addiw	a5,a0,1
    800267a4:	00faa023          	sw	a5,0(s5)
                count = 0;
    800267a8:	4a81                	li	s5,0
    800267aa:	bfb5                	j	80026726 <enext+0xb6>
            if (count) {
    800267ac:	000a8c63          	beqz	s5,800267c4 <enext+0x154>
                *count = 1;
    800267b0:	4785                	li	a5,1
    800267b2:	00faa023          	sw	a5,0(s5)
                read_entry_name(ep->filename, &de);
    800267b6:	f8040593          	addi	a1,s0,-128
    800267ba:	855e                	mv	a0,s7
    800267bc:	fffff097          	auipc	ra,0xfffff
    800267c0:	116080e7          	jalr	278(ra) # 800258d2 <read_entry_name>
    entry->attribute = d->sne.attr;
    800267c4:	f8b44783          	lbu	a5,-117(s0)
    800267c8:	10fb8023          	sb	a5,256(s7) # fffffffffffff100 <kernel_end+0xffffffff7ffb9100>
    entry->first_clus = ((uint32)d->sne.fst_clus_hi << 16) | d->sne.fst_clus_lo;
    800267cc:	f9445783          	lhu	a5,-108(s0)
    800267d0:	0107979b          	slliw	a5,a5,0x10
    800267d4:	f9a45703          	lhu	a4,-102(s0)
    800267d8:	8fd9                	or	a5,a5,a4
    800267da:	2781                	sext.w	a5,a5
    800267dc:	10fba223          	sw	a5,260(s7)
    entry->file_size = d->sne.file_size;
    800267e0:	f9c42703          	lw	a4,-100(s0)
    800267e4:	10eba423          	sw	a4,264(s7)
    entry->cur_clus = entry->first_clus;
    800267e8:	10fba623          	sw	a5,268(s7)
    entry->clus_cnt = 0;
    800267ec:	100ba823          	sw	zero,272(s7)
            return 1;
    800267f0:	4505                	li	a0,1
    800267f2:	b5c1                	j	800266b2 <enext+0x42>
            return -1;
    800267f4:	557d                	li	a0,-1
    800267f6:	bd75                	j	800266b2 <enext+0x42>
    800267f8:	557d                	li	a0,-1
    800267fa:	bd65                	j	800266b2 <enext+0x42>

00000000800267fc <dirlookup>:
 * @param   dp          entry of a directory file
 * @param   filename    target filename
 * @param   poff        offset of proper empty entry slots from the beginning of the dir
 */
struct dirent *dirlookup(struct dirent *dp, char *filename, uint *poff)
{
    800267fc:	715d                	addi	sp,sp,-80
    800267fe:	e486                	sd	ra,72(sp)
    80026800:	e0a2                	sd	s0,64(sp)
    80026802:	fc26                	sd	s1,56(sp)
    80026804:	f84a                	sd	s2,48(sp)
    80026806:	f44e                	sd	s3,40(sp)
    80026808:	f052                	sd	s4,32(sp)
    8002680a:	ec56                	sd	s5,24(sp)
    8002680c:	e85a                	sd	s6,16(sp)
    8002680e:	0880                	addi	s0,sp,80
    if (!(dp->attribute & ATTR_DIRECTORY))
    80026810:	10054783          	lbu	a5,256(a0)
    80026814:	8bc1                	andi	a5,a5,16
    80026816:	cbb1                	beqz	a5,8002686a <dirlookup+0x6e>
    80026818:	892a                	mv	s2,a0
    8002681a:	89ae                	mv	s3,a1
    8002681c:	8b32                	mv	s6,a2
        panic("dirlookup not DIR");
    if (strncmp(filename, ".", FAT32_MAX_FILENAME) == 0) {
    8002681e:	0ff00613          	li	a2,255
    80026822:	00006597          	auipc	a1,0x6
    80026826:	40e58593          	addi	a1,a1,1038 # 8002cc30 <syscalls+0xb78>
    8002682a:	854e                	mv	a0,s3
    8002682c:	ffffa097          	auipc	ra,0xffffa
    80026830:	018080e7          	jalr	24(ra) # 80020844 <strncmp>
    80026834:	c139                	beqz	a0,8002687a <dirlookup+0x7e>
        return edup(dp);
    } else if (strncmp(filename, "..", FAT32_MAX_FILENAME) == 0) {
    80026836:	0ff00613          	li	a2,255
    8002683a:	00006597          	auipc	a1,0x6
    8002683e:	3fe58593          	addi	a1,a1,1022 # 8002cc38 <syscalls+0xb80>
    80026842:	854e                	mv	a0,s3
    80026844:	ffffa097          	auipc	ra,0xffffa
    80026848:	000080e7          	jalr	ra # 80020844 <strncmp>
    8002684c:	ed39                	bnez	a0,800268aa <dirlookup+0xae>
        if (dp == &root) {
    8002684e:	0001b797          	auipc	a5,0x1b
    80026852:	c0278793          	addi	a5,a5,-1022 # 80041450 <root>
    80026856:	04f90363          	beq	s2,a5,8002689c <dirlookup+0xa0>
            return edup(&root);
        }
        return edup(dp->parent);
    8002685a:	12093503          	ld	a0,288(s2)
    8002685e:	00000097          	auipc	ra,0x0
    80026862:	9be080e7          	jalr	-1602(ra) # 8002621c <edup>
    80026866:	84aa                	mv	s1,a0
    80026868:	a839                	j	80026886 <dirlookup+0x8a>
        panic("dirlookup not DIR");
    8002686a:	00006517          	auipc	a0,0x6
    8002686e:	3ae50513          	addi	a0,a0,942 # 8002cc18 <syscalls+0xb60>
    80026872:	ffffa097          	auipc	ra,0xffffa
    80026876:	8d4080e7          	jalr	-1836(ra) # 80020146 <panic>
        return edup(dp);
    8002687a:	854a                	mv	a0,s2
    8002687c:	00000097          	auipc	ra,0x0
    80026880:	9a0080e7          	jalr	-1632(ra) # 8002621c <edup>
    80026884:	84aa                	mv	s1,a0
    if (poff) {
        *poff = off;
    }
    eput(ep);
    return NULL;
}
    80026886:	8526                	mv	a0,s1
    80026888:	60a6                	ld	ra,72(sp)
    8002688a:	6406                	ld	s0,64(sp)
    8002688c:	74e2                	ld	s1,56(sp)
    8002688e:	7942                	ld	s2,48(sp)
    80026890:	79a2                	ld	s3,40(sp)
    80026892:	7a02                	ld	s4,32(sp)
    80026894:	6ae2                	ld	s5,24(sp)
    80026896:	6b42                	ld	s6,16(sp)
    80026898:	6161                	addi	sp,sp,80
    8002689a:	8082                	ret
            return edup(&root);
    8002689c:	853e                	mv	a0,a5
    8002689e:	00000097          	auipc	ra,0x0
    800268a2:	97e080e7          	jalr	-1666(ra) # 8002621c <edup>
    800268a6:	84aa                	mv	s1,a0
    800268a8:	bff9                	j	80026886 <dirlookup+0x8a>
    if (dp->valid != 1) {
    800268aa:	11691703          	lh	a4,278(s2)
    800268ae:	4785                	li	a5,1
        return NULL;
    800268b0:	4481                	li	s1,0
    if (dp->valid != 1) {
    800268b2:	fcf71ae3          	bne	a4,a5,80026886 <dirlookup+0x8a>
    struct dirent *ep = eget(dp, filename);
    800268b6:	85ce                	mv	a1,s3
    800268b8:	854a                	mv	a0,s2
    800268ba:	fffff097          	auipc	ra,0xfffff
    800268be:	ef6080e7          	jalr	-266(ra) # 800257b0 <eget>
    800268c2:	84aa                	mv	s1,a0
    if (ep->valid == 1) { return ep; }                               // ecache hits
    800268c4:	11651703          	lh	a4,278(a0)
    800268c8:	4785                	li	a5,1
    800268ca:	faf70ee3          	beq	a4,a5,80026886 <dirlookup+0x8a>
    int len = strlen(filename);
    800268ce:	854e                	mv	a0,s3
    800268d0:	ffffa097          	auipc	ra,0xffffa
    800268d4:	036080e7          	jalr	54(ra) # 80020906 <strlen>
    int count = 0;
    800268d8:	fa042e23          	sw	zero,-68(s0)
    reloc_clus(dp, 0, 0);
    800268dc:	4601                	li	a2,0
    800268de:	4581                	li	a1,0
    800268e0:	854a                	mv	a0,s2
    800268e2:	fffff097          	auipc	ra,0xfffff
    800268e6:	c6e080e7          	jalr	-914(ra) # 80025550 <reloc_clus>
    uint off = 0;
    800268ea:	4a01                	li	s4,0
    while ((type = enext(dp, ep, off, &count) != -1)) {
    800268ec:	5afd                	li	s5,-1
    800268ee:	fbc40693          	addi	a3,s0,-68
    800268f2:	8652                	mv	a2,s4
    800268f4:	85a6                	mv	a1,s1
    800268f6:	854a                	mv	a0,s2
    800268f8:	00000097          	auipc	ra,0x0
    800268fc:	d78080e7          	jalr	-648(ra) # 80026670 <enext>
    80026900:	03550f63          	beq	a0,s5,8002693e <dirlookup+0x142>
        } else if (strncmp(filename, ep->filename, FAT32_MAX_FILENAME) == 0) {
    80026904:	0ff00613          	li	a2,255
    80026908:	85a6                	mv	a1,s1
    8002690a:	854e                	mv	a0,s3
    8002690c:	ffffa097          	auipc	ra,0xffffa
    80026910:	f38080e7          	jalr	-200(ra) # 80020844 <strncmp>
    80026914:	c901                	beqz	a0,80026924 <dirlookup+0x128>
        off += count << 5;
    80026916:	fbc42783          	lw	a5,-68(s0)
    8002691a:	0057979b          	slliw	a5,a5,0x5
    8002691e:	01478a3b          	addw	s4,a5,s4
    80026922:	b7f1                	j	800268ee <dirlookup+0xf2>
            ep->parent = edup(dp);
    80026924:	854a                	mv	a0,s2
    80026926:	00000097          	auipc	ra,0x0
    8002692a:	8f6080e7          	jalr	-1802(ra) # 8002621c <edup>
    8002692e:	12a4b023          	sd	a0,288(s1)
            ep->off = off;
    80026932:	1144ae23          	sw	s4,284(s1)
            ep->valid = 1;
    80026936:	4785                	li	a5,1
    80026938:	10f49b23          	sh	a5,278(s1)
            return ep;
    8002693c:	b7a9                	j	80026886 <dirlookup+0x8a>
    if (poff) {
    8002693e:	000b0463          	beqz	s6,80026946 <dirlookup+0x14a>
        *poff = off;
    80026942:	014b2023          	sw	s4,0(s6)
    eput(ep);
    80026946:	8526                	mv	a0,s1
    80026948:	00000097          	auipc	ra,0x0
    8002694c:	ba8080e7          	jalr	-1112(ra) # 800264f0 <eput>
    return NULL;
    80026950:	4481                	li	s1,0
    80026952:	bf15                	j	80026886 <dirlookup+0x8a>

0000000080026954 <ealloc>:
{
    80026954:	7139                	addi	sp,sp,-64
    80026956:	fc06                	sd	ra,56(sp)
    80026958:	f822                	sd	s0,48(sp)
    8002695a:	f426                	sd	s1,40(sp)
    8002695c:	f04a                	sd	s2,32(sp)
    8002695e:	ec4e                	sd	s3,24(sp)
    80026960:	e852                	sd	s4,16(sp)
    80026962:	0080                	addi	s0,sp,64
    if (!(dp->attribute & ATTR_DIRECTORY)) {
    80026964:	10054783          	lbu	a5,256(a0)
    80026968:	8bc1                	andi	a5,a5,16
    8002696a:	c7b1                	beqz	a5,800269b6 <ealloc+0x62>
    8002696c:	892a                	mv	s2,a0
    8002696e:	8a32                	mv	s4,a2
    if (dp->valid != 1 || !(name = formatname(name))) {        // detect illegal character
    80026970:	11651703          	lh	a4,278(a0)
    80026974:	4785                	li	a5,1
        return NULL;
    80026976:	4481                	li	s1,0
    if (dp->valid != 1 || !(name = formatname(name))) {        // detect illegal character
    80026978:	02f71663          	bne	a4,a5,800269a4 <ealloc+0x50>
    8002697c:	852e                	mv	a0,a1
    8002697e:	fffff097          	auipc	ra,0xfffff
    80026982:	442080e7          	jalr	1090(ra) # 80025dc0 <formatname>
    80026986:	89aa                	mv	s3,a0
    80026988:	10050663          	beqz	a0,80026a94 <ealloc+0x140>
    uint off = 0;
    8002698c:	fc042623          	sw	zero,-52(s0)
    if ((ep = dirlookup(dp, name, &off)) != 0) {      // entry exists
    80026990:	fcc40613          	addi	a2,s0,-52
    80026994:	85aa                	mv	a1,a0
    80026996:	854a                	mv	a0,s2
    80026998:	00000097          	auipc	ra,0x0
    8002699c:	e64080e7          	jalr	-412(ra) # 800267fc <dirlookup>
    800269a0:	84aa                	mv	s1,a0
    800269a2:	c115                	beqz	a0,800269c6 <ealloc+0x72>
}
    800269a4:	8526                	mv	a0,s1
    800269a6:	70e2                	ld	ra,56(sp)
    800269a8:	7442                	ld	s0,48(sp)
    800269aa:	74a2                	ld	s1,40(sp)
    800269ac:	7902                	ld	s2,32(sp)
    800269ae:	69e2                	ld	s3,24(sp)
    800269b0:	6a42                	ld	s4,16(sp)
    800269b2:	6121                	addi	sp,sp,64
    800269b4:	8082                	ret
        panic("ealloc not dir");
    800269b6:	00006517          	auipc	a0,0x6
    800269ba:	28a50513          	addi	a0,a0,650 # 8002cc40 <syscalls+0xb88>
    800269be:	ffff9097          	auipc	ra,0xffff9
    800269c2:	788080e7          	jalr	1928(ra) # 80020146 <panic>
    ep = eget(dp, name);
    800269c6:	85ce                	mv	a1,s3
    800269c8:	854a                	mv	a0,s2
    800269ca:	fffff097          	auipc	ra,0xfffff
    800269ce:	de6080e7          	jalr	-538(ra) # 800257b0 <eget>
    800269d2:	84aa                	mv	s1,a0
    elock(ep);
    800269d4:	00000097          	auipc	ra,0x0
    800269d8:	a98080e7          	jalr	-1384(ra) # 8002646c <elock>
    ep->attribute = attr;
    800269dc:	11448023          	sb	s4,256(s1)
    ep->file_size = 0;
    800269e0:	1004a423          	sw	zero,264(s1)
    ep->first_clus = 0;
    800269e4:	1004a223          	sw	zero,260(s1)
    ep->parent = edup(dp);
    800269e8:	854a                	mv	a0,s2
    800269ea:	00000097          	auipc	ra,0x0
    800269ee:	832080e7          	jalr	-1998(ra) # 8002621c <edup>
    800269f2:	12a4b023          	sd	a0,288(s1)
    ep->off = off;
    800269f6:	fcc42783          	lw	a5,-52(s0)
    800269fa:	10f4ae23          	sw	a5,284(s1)
    ep->clus_cnt = 0;
    800269fe:	1004a823          	sw	zero,272(s1)
    ep->cur_clus = 0;
    80026a02:	1004a623          	sw	zero,268(s1)
    ep->dirty = 0;
    80026a06:	10048aa3          	sb	zero,277(s1)
    strncpy(ep->filename, name, FAT32_MAX_FILENAME);
    80026a0a:	0ff00613          	li	a2,255
    80026a0e:	85ce                	mv	a1,s3
    80026a10:	8526                	mv	a0,s1
    80026a12:	ffffa097          	auipc	ra,0xffffa
    80026a16:	e82080e7          	jalr	-382(ra) # 80020894 <strncpy>
    ep->filename[FAT32_MAX_FILENAME] = '\0';
    80026a1a:	0e048fa3          	sb	zero,255(s1)
    if (attr == ATTR_DIRECTORY) {    // generate "." and ".." for ep
    80026a1e:	47c1                	li	a5,16
    80026a20:	02fa0963          	beq	s4,a5,80026a52 <ealloc+0xfe>
        ep->attribute |= ATTR_ARCHIVE;
    80026a24:	1004c783          	lbu	a5,256(s1)
    80026a28:	0207e793          	ori	a5,a5,32
    80026a2c:	10f48023          	sb	a5,256(s1)
    emake(dp, ep, off);
    80026a30:	fcc42603          	lw	a2,-52(s0)
    80026a34:	85a6                	mv	a1,s1
    80026a36:	854a                	mv	a0,s2
    80026a38:	fffff097          	auipc	ra,0xfffff
    80026a3c:	448080e7          	jalr	1096(ra) # 80025e80 <emake>
    ep->valid = 1;
    80026a40:	4785                	li	a5,1
    80026a42:	10f49b23          	sh	a5,278(s1)
    eunlock(ep);
    80026a46:	8526                	mv	a0,s1
    80026a48:	00000097          	auipc	ra,0x0
    80026a4c:	a5a080e7          	jalr	-1446(ra) # 800264a2 <eunlock>
    return ep;
    80026a50:	bf91                	j	800269a4 <ealloc+0x50>
        ep->attribute |= ATTR_DIRECTORY;
    80026a52:	1004c783          	lbu	a5,256(s1)
    80026a56:	0107e793          	ori	a5,a5,16
    80026a5a:	10f48023          	sb	a5,256(s1)
        ep->cur_clus = ep->first_clus = alloc_clus(dp->dev);
    80026a5e:	11494503          	lbu	a0,276(s2)
    80026a62:	fffff097          	auipc	ra,0xfffff
    80026a66:	928080e7          	jalr	-1752(ra) # 8002538a <alloc_clus>
    80026a6a:	2501                	sext.w	a0,a0
    80026a6c:	10a4a223          	sw	a0,260(s1)
    80026a70:	10a4a623          	sw	a0,268(s1)
        emake(ep, ep, 0);
    80026a74:	4601                	li	a2,0
    80026a76:	85a6                	mv	a1,s1
    80026a78:	8526                	mv	a0,s1
    80026a7a:	fffff097          	auipc	ra,0xfffff
    80026a7e:	406080e7          	jalr	1030(ra) # 80025e80 <emake>
        emake(ep, dp, 32);
    80026a82:	02000613          	li	a2,32
    80026a86:	85ca                	mv	a1,s2
    80026a88:	8526                	mv	a0,s1
    80026a8a:	fffff097          	auipc	ra,0xfffff
    80026a8e:	3f6080e7          	jalr	1014(ra) # 80025e80 <emake>
    80026a92:	bf79                	j	80026a30 <ealloc+0xdc>
        return NULL;
    80026a94:	84aa                	mv	s1,a0
    80026a96:	b739                	j	800269a4 <ealloc+0x50>

0000000080026a98 <lookup_path>:
    return path;
}

// FAT32 version of namex in xv6's original file system.
static struct dirent *lookup_path(char *path, int parent, char *name)
{
    80026a98:	715d                	addi	sp,sp,-80
    80026a9a:	e486                	sd	ra,72(sp)
    80026a9c:	e0a2                	sd	s0,64(sp)
    80026a9e:	fc26                	sd	s1,56(sp)
    80026aa0:	f84a                	sd	s2,48(sp)
    80026aa2:	f44e                	sd	s3,40(sp)
    80026aa4:	f052                	sd	s4,32(sp)
    80026aa6:	ec56                	sd	s5,24(sp)
    80026aa8:	e85a                	sd	s6,16(sp)
    80026aaa:	e45e                	sd	s7,8(sp)
    80026aac:	e062                	sd	s8,0(sp)
    80026aae:	0880                	addi	s0,sp,80
    80026ab0:	84aa                	mv	s1,a0
    80026ab2:	8aae                	mv	s5,a1
    80026ab4:	8a32                	mv	s4,a2
    struct dirent *entry, *next;
    if (*path == '/') {
    80026ab6:	00054783          	lbu	a5,0(a0)
    80026aba:	02f00713          	li	a4,47
    80026abe:	02e78663          	beq	a5,a4,80026aea <lookup_path+0x52>
        entry = edup(&root);
    } else if (*path != '\0') {
        entry = edup(myproc()->cwd);
    } else {
        return NULL;
    80026ac2:	4901                	li	s2,0
    } else if (*path != '\0') {
    80026ac4:	cba1                	beqz	a5,80026b14 <lookup_path+0x7c>
        entry = edup(myproc()->cwd);
    80026ac6:	ffffb097          	auipc	ra,0xffffb
    80026aca:	0bc080e7          	jalr	188(ra) # 80021b82 <myproc>
    80026ace:	15853503          	ld	a0,344(a0)
    80026ad2:	fffff097          	auipc	ra,0xfffff
    80026ad6:	74a080e7          	jalr	1866(ra) # 8002621c <edup>
    80026ada:	892a                	mv	s2,a0
    while (*path == '/') {
    80026adc:	02f00993          	li	s3,47
    80026ae0:	0ff00b13          	li	s6,255
    80026ae4:	0ff00b93          	li	s7,255
    80026ae8:	a0d5                	j	80026bcc <lookup_path+0x134>
        entry = edup(&root);
    80026aea:	0001b517          	auipc	a0,0x1b
    80026aee:	96650513          	addi	a0,a0,-1690 # 80041450 <root>
    80026af2:	fffff097          	auipc	ra,0xfffff
    80026af6:	72a080e7          	jalr	1834(ra) # 8002621c <edup>
    80026afa:	892a                	mv	s2,a0
    80026afc:	b7c5                	j	80026adc <lookup_path+0x44>
    }
    while ((path = skipelem(path, name)) != 0) {
        elock(entry);
        if (!(entry->attribute & ATTR_DIRECTORY)) {
            eunlock(entry);
    80026afe:	854a                	mv	a0,s2
    80026b00:	00000097          	auipc	ra,0x0
    80026b04:	9a2080e7          	jalr	-1630(ra) # 800264a2 <eunlock>
            eput(entry);
    80026b08:	854a                	mv	a0,s2
    80026b0a:	00000097          	auipc	ra,0x0
    80026b0e:	9e6080e7          	jalr	-1562(ra) # 800264f0 <eput>
            return NULL;
    80026b12:	4901                	li	s2,0
    if (parent) {
        eput(entry);
        return NULL;
    }
    return entry;
}
    80026b14:	854a                	mv	a0,s2
    80026b16:	60a6                	ld	ra,72(sp)
    80026b18:	6406                	ld	s0,64(sp)
    80026b1a:	74e2                	ld	s1,56(sp)
    80026b1c:	7942                	ld	s2,48(sp)
    80026b1e:	79a2                	ld	s3,40(sp)
    80026b20:	7a02                	ld	s4,32(sp)
    80026b22:	6ae2                	ld	s5,24(sp)
    80026b24:	6b42                	ld	s6,16(sp)
    80026b26:	6ba2                	ld	s7,8(sp)
    80026b28:	6c02                	ld	s8,0(sp)
    80026b2a:	6161                	addi	sp,sp,80
    80026b2c:	8082                	ret
            eunlock(entry);
    80026b2e:	854a                	mv	a0,s2
    80026b30:	00000097          	auipc	ra,0x0
    80026b34:	972080e7          	jalr	-1678(ra) # 800264a2 <eunlock>
            return entry;
    80026b38:	bff1                	j	80026b14 <lookup_path+0x7c>
            eunlock(entry);
    80026b3a:	854a                	mv	a0,s2
    80026b3c:	00000097          	auipc	ra,0x0
    80026b40:	966080e7          	jalr	-1690(ra) # 800264a2 <eunlock>
            eput(entry);
    80026b44:	854a                	mv	a0,s2
    80026b46:	00000097          	auipc	ra,0x0
    80026b4a:	9aa080e7          	jalr	-1622(ra) # 800264f0 <eput>
            return NULL;
    80026b4e:	8962                	mv	s2,s8
    80026b50:	b7d1                	j	80026b14 <lookup_path+0x7c>
        path++;
    80026b52:	85a6                	mv	a1,s1
    int len = path - s;
    80026b54:	40b487bb          	subw	a5,s1,a1
    if (len > FAT32_MAX_FILENAME) {
    80026b58:	863e                	mv	a2,a5
    80026b5a:	00fb5363          	bge	s6,a5,80026b60 <lookup_path+0xc8>
    80026b5e:	865e                	mv	a2,s7
    80026b60:	0006079b          	sext.w	a5,a2
    name[len] = 0;
    80026b64:	97d2                	add	a5,a5,s4
    80026b66:	00078023          	sb	zero,0(a5)
    memmove(name, s, len);
    80026b6a:	2601                	sext.w	a2,a2
    80026b6c:	8552                	mv	a0,s4
    80026b6e:	ffffa097          	auipc	ra,0xffffa
    80026b72:	c5a080e7          	jalr	-934(ra) # 800207c8 <memmove>
    while (*path == '/') {
    80026b76:	0004c783          	lbu	a5,0(s1)
    80026b7a:	01379763          	bne	a5,s3,80026b88 <lookup_path+0xf0>
        path++;
    80026b7e:	0485                	addi	s1,s1,1
    while (*path == '/') {
    80026b80:	0004c783          	lbu	a5,0(s1)
    80026b84:	ff378de3          	beq	a5,s3,80026b7e <lookup_path+0xe6>
        elock(entry);
    80026b88:	854a                	mv	a0,s2
    80026b8a:	00000097          	auipc	ra,0x0
    80026b8e:	8e2080e7          	jalr	-1822(ra) # 8002646c <elock>
        if (!(entry->attribute & ATTR_DIRECTORY)) {
    80026b92:	10094783          	lbu	a5,256(s2)
    80026b96:	8bc1                	andi	a5,a5,16
    80026b98:	d3bd                	beqz	a5,80026afe <lookup_path+0x66>
        if (parent && *path == '\0') {
    80026b9a:	000a8563          	beqz	s5,80026ba4 <lookup_path+0x10c>
    80026b9e:	0004c783          	lbu	a5,0(s1)
    80026ba2:	d7d1                	beqz	a5,80026b2e <lookup_path+0x96>
        if ((next = dirlookup(entry, name, 0)) == 0) {
    80026ba4:	4601                	li	a2,0
    80026ba6:	85d2                	mv	a1,s4
    80026ba8:	854a                	mv	a0,s2
    80026baa:	00000097          	auipc	ra,0x0
    80026bae:	c52080e7          	jalr	-942(ra) # 800267fc <dirlookup>
    80026bb2:	8c2a                	mv	s8,a0
    80026bb4:	d159                	beqz	a0,80026b3a <lookup_path+0xa2>
        eunlock(entry);
    80026bb6:	854a                	mv	a0,s2
    80026bb8:	00000097          	auipc	ra,0x0
    80026bbc:	8ea080e7          	jalr	-1814(ra) # 800264a2 <eunlock>
        eput(entry);
    80026bc0:	854a                	mv	a0,s2
    80026bc2:	00000097          	auipc	ra,0x0
    80026bc6:	92e080e7          	jalr	-1746(ra) # 800264f0 <eput>
        entry = next;
    80026bca:	8962                	mv	s2,s8
    while (*path == '/') {
    80026bcc:	0004c783          	lbu	a5,0(s1)
    80026bd0:	03379e63          	bne	a5,s3,80026c0c <lookup_path+0x174>
        path++;
    80026bd4:	0485                	addi	s1,s1,1
    while (*path == '/') {
    80026bd6:	0004c783          	lbu	a5,0(s1)
    80026bda:	ff378de3          	beq	a5,s3,80026bd4 <lookup_path+0x13c>
    if (*path == 0) { return NULL; }
    80026bde:	cf91                	beqz	a5,80026bfa <lookup_path+0x162>
    while (*path != '/' && *path != 0) {
    80026be0:	f73789e3          	beq	a5,s3,80026b52 <lookup_path+0xba>
    80026be4:	cb89                	beqz	a5,80026bf6 <lookup_path+0x15e>
        path++;
    80026be6:	85a6                	mv	a1,s1
        path++;
    80026be8:	0485                	addi	s1,s1,1
    while (*path != '/' && *path != 0) {
    80026bea:	0004c783          	lbu	a5,0(s1)
    80026bee:	f73783e3          	beq	a5,s3,80026b54 <lookup_path+0xbc>
    80026bf2:	fbfd                	bnez	a5,80026be8 <lookup_path+0x150>
    80026bf4:	b785                	j	80026b54 <lookup_path+0xbc>
        path++;
    80026bf6:	85a6                	mv	a1,s1
    80026bf8:	bfb1                	j	80026b54 <lookup_path+0xbc>
    if (parent) {
    80026bfa:	f00a8de3          	beqz	s5,80026b14 <lookup_path+0x7c>
        eput(entry);
    80026bfe:	854a                	mv	a0,s2
    80026c00:	00000097          	auipc	ra,0x0
    80026c04:	8f0080e7          	jalr	-1808(ra) # 800264f0 <eput>
        return NULL;
    80026c08:	4901                	li	s2,0
    80026c0a:	b729                	j	80026b14 <lookup_path+0x7c>
    if (*path == 0) { return NULL; }
    80026c0c:	d7fd                	beqz	a5,80026bfa <lookup_path+0x162>
    80026c0e:	85a6                	mv	a1,s1
    80026c10:	bfe1                	j	80026be8 <lookup_path+0x150>

0000000080026c12 <ename>:

struct dirent *ename(char *path)
{
    80026c12:	716d                	addi	sp,sp,-272
    80026c14:	e606                	sd	ra,264(sp)
    80026c16:	e222                	sd	s0,256(sp)
    80026c18:	0a00                	addi	s0,sp,272
    char name[FAT32_MAX_FILENAME + 1];
    return lookup_path(path, 0, name);
    80026c1a:	ef040613          	addi	a2,s0,-272
    80026c1e:	4581                	li	a1,0
    80026c20:	00000097          	auipc	ra,0x0
    80026c24:	e78080e7          	jalr	-392(ra) # 80026a98 <lookup_path>
}
    80026c28:	60b2                	ld	ra,264(sp)
    80026c2a:	6412                	ld	s0,256(sp)
    80026c2c:	6151                	addi	sp,sp,272
    80026c2e:	8082                	ret

0000000080026c30 <enameparent>:

struct dirent *enameparent(char *path, char *name)
{
    80026c30:	1141                	addi	sp,sp,-16
    80026c32:	e406                	sd	ra,8(sp)
    80026c34:	e022                	sd	s0,0(sp)
    80026c36:	0800                	addi	s0,sp,16
    return lookup_path(path, 1, name);
    80026c38:	862e                	mv	a2,a1
    80026c3a:	4585                	li	a1,1
    80026c3c:	00000097          	auipc	ra,0x0
    80026c40:	e5c080e7          	jalr	-420(ra) # 80026a98 <lookup_path>
}
    80026c44:	60a2                	ld	ra,8(sp)
    80026c46:	6402                	ld	s0,0(sp)
    80026c48:	0141                	addi	sp,sp,16
    80026c4a:	8082                	ret

0000000080026c4c <plicinit>:

//
// the riscv Platform Level Interrupt Controller (PLIC).
//

void plicinit(void) {
    80026c4c:	1141                	addi	sp,sp,-16
    80026c4e:	e422                	sd	s0,8(sp)
    80026c50:	0800                	addi	s0,sp,16
	writed(1, PLIC_V + DISK_IRQ * sizeof(uint32));
    80026c52:	00fc37b7          	lui	a5,0xfc3
    80026c56:	07ba                	slli	a5,a5,0xe
    80026c58:	4705                	li	a4,1
    80026c5a:	d7f8                	sw	a4,108(a5)
	writed(1, PLIC_V + UART_IRQ * sizeof(uint32));
    80026c5c:	08e7a223          	sw	a4,132(a5) # fc3084 <BASE_ADDRESS-0x7f05cf7c>

	#ifdef DEBUG 
	printf("plicinit\n");
	#endif 
}
    80026c60:	6422                	ld	s0,8(sp)
    80026c62:	0141                	addi	sp,sp,16
    80026c64:	8082                	ret

0000000080026c66 <plicinithart>:

void
plicinithart(void)
{
    80026c66:	1141                	addi	sp,sp,-16
    80026c68:	e406                	sd	ra,8(sp)
    80026c6a:	e022                	sd	s0,0(sp)
    80026c6c:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80026c6e:	ffffb097          	auipc	ra,0xffffb
    80026c72:	ee8080e7          	jalr	-280(ra) # 80021b56 <cpuid>
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART_IRQ) | (1 << DISK_IRQ);
  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
  #else
  uint32 *hart_m_enable = (uint32*)PLIC_MENABLE(hart);
    80026c76:	0085151b          	slliw	a0,a0,0x8
    80026c7a:	01f867b7          	lui	a5,0x1f86
    80026c7e:	0785                	addi	a5,a5,1
    80026c80:	07b6                	slli	a5,a5,0xd
    80026c82:	953e                	add	a0,a0,a5
  *(hart_m_enable) = readd(hart_m_enable) | (1 << DISK_IRQ);
    80026c84:	411c                	lw	a5,0(a0)
    80026c86:	08000737          	lui	a4,0x8000
    80026c8a:	8fd9                	or	a5,a5,a4
    80026c8c:	c11c                	sw	a5,0(a0)
  uint32 *hart0_m_int_enable_hi = hart_m_enable + 1;
  *(hart0_m_int_enable_hi) = readd(hart0_m_int_enable_hi) | (1 << (UART_IRQ % 32));
    80026c8e:	415c                	lw	a5,4(a0)
    80026c90:	0027e793          	ori	a5,a5,2
    80026c94:	c15c                	sw	a5,4(a0)
  #endif
  #ifdef DEBUG
  printf("plicinithart\n");
  #endif
}
    80026c96:	60a2                	ld	ra,8(sp)
    80026c98:	6402                	ld	s0,0(sp)
    80026c9a:	0141                	addi	sp,sp,16
    80026c9c:	8082                	ret

0000000080026c9e <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80026c9e:	1141                	addi	sp,sp,-16
    80026ca0:	e406                	sd	ra,8(sp)
    80026ca2:	e022                	sd	s0,0(sp)
    80026ca4:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80026ca6:	ffffb097          	auipc	ra,0xffffb
    80026caa:	eb0080e7          	jalr	-336(ra) # 80021b56 <cpuid>
  int irq;
  #ifndef QEMU
  irq = *(uint32*)PLIC_MCLAIM(hart);
    80026cae:	00d5151b          	slliw	a0,a0,0xd
    80026cb2:	1f8617b7          	lui	a5,0x1f861
    80026cb6:	07a6                	slli	a5,a5,0x9
    80026cb8:	97aa                	add	a5,a5,a0
  #else
  irq = *(uint32*)PLIC_SCLAIM(hart);
  #endif
  return irq;
}
    80026cba:	43c8                	lw	a0,4(a5)
    80026cbc:	60a2                	ld	ra,8(sp)
    80026cbe:	6402                	ld	s0,0(sp)
    80026cc0:	0141                	addi	sp,sp,16
    80026cc2:	8082                	ret

0000000080026cc4 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80026cc4:	1101                	addi	sp,sp,-32
    80026cc6:	ec06                	sd	ra,24(sp)
    80026cc8:	e822                	sd	s0,16(sp)
    80026cca:	e426                	sd	s1,8(sp)
    80026ccc:	1000                	addi	s0,sp,32
    80026cce:	84aa                	mv	s1,a0
  int hart = cpuid();
    80026cd0:	ffffb097          	auipc	ra,0xffffb
    80026cd4:	e86080e7          	jalr	-378(ra) # 80021b56 <cpuid>
  #ifndef QEMU
  *(uint32*)PLIC_MCLAIM(hart) = irq;
    80026cd8:	00d5151b          	slliw	a0,a0,0xd
    80026cdc:	1f8617b7          	lui	a5,0x1f861
    80026ce0:	07a6                	slli	a5,a5,0x9
    80026ce2:	97aa                	add	a5,a5,a0
    80026ce4:	c3c4                	sw	s1,4(a5)
  #else
  *(uint32*)PLIC_SCLAIM(hart) = irq;
  #endif
}
    80026ce6:	60e2                	ld	ra,24(sp)
    80026ce8:	6442                	ld	s0,16(sp)
    80026cea:	64a2                	ld	s1,8(sp)
    80026cec:	6105                	addi	sp,sp,32
    80026cee:	8082                	ret

0000000080026cf0 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80026cf0:	715d                	addi	sp,sp,-80
    80026cf2:	e486                	sd	ra,72(sp)
    80026cf4:	e0a2                	sd	s0,64(sp)
    80026cf6:	fc26                	sd	s1,56(sp)
    80026cf8:	f84a                	sd	s2,48(sp)
    80026cfa:	f44e                	sd	s3,40(sp)
    80026cfc:	f052                	sd	s4,32(sp)
    80026cfe:	ec56                	sd	s5,24(sp)
    80026d00:	0880                	addi	s0,sp,80
    80026d02:	8a2a                	mv	s4,a0
    80026d04:	892e                	mv	s2,a1
    80026d06:	89b2                	mv	s3,a2
  int i;

  acquire(&cons.lock);
    80026d08:	0001f517          	auipc	a0,0x1f
    80026d0c:	f1850513          	addi	a0,a0,-232 # 80045c20 <cons>
    80026d10:	ffffa097          	auipc	ra,0xffffa
    80026d14:	9b0080e7          	jalr	-1616(ra) # 800206c0 <acquire>
  for(i = 0; i < n; i++){
    80026d18:	05305d63          	blez	s3,80026d72 <consolewrite+0x82>
    80026d1c:	4481                	li	s1,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80026d1e:	5afd                	li	s5,-1
    80026d20:	4685                	li	a3,1
    80026d22:	864a                	mv	a2,s2
    80026d24:	85d2                	mv	a1,s4
    80026d26:	fbf40513          	addi	a0,s0,-65
    80026d2a:	ffffc097          	auipc	ra,0xffffc
    80026d2e:	9e4080e7          	jalr	-1564(ra) # 8002270e <either_copyin>
    80026d32:	01550e63          	beq	a0,s5,80026d4e <consolewrite+0x5e>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
    80026d36:	fbf44503          	lbu	a0,-65(s0)
    80026d3a:	4581                	li	a1,0
    80026d3c:	4601                	li	a2,0
    80026d3e:	4681                	li	a3,0
    80026d40:	4885                	li	a7,1
    80026d42:	00000073          	ecall
  for(i = 0; i < n; i++){
    80026d46:	2485                	addiw	s1,s1,1
    80026d48:	0905                	addi	s2,s2,1
    80026d4a:	fc999be3          	bne	s3,s1,80026d20 <consolewrite+0x30>
      break;
    sbi_console_putchar(c);
  }
  release(&cons.lock);
    80026d4e:	0001f517          	auipc	a0,0x1f
    80026d52:	ed250513          	addi	a0,a0,-302 # 80045c20 <cons>
    80026d56:	ffffa097          	auipc	ra,0xffffa
    80026d5a:	9be080e7          	jalr	-1602(ra) # 80020714 <release>

  return i;
}
    80026d5e:	8526                	mv	a0,s1
    80026d60:	60a6                	ld	ra,72(sp)
    80026d62:	6406                	ld	s0,64(sp)
    80026d64:	74e2                	ld	s1,56(sp)
    80026d66:	7942                	ld	s2,48(sp)
    80026d68:	79a2                	ld	s3,40(sp)
    80026d6a:	7a02                	ld	s4,32(sp)
    80026d6c:	6ae2                	ld	s5,24(sp)
    80026d6e:	6161                	addi	sp,sp,80
    80026d70:	8082                	ret
  for(i = 0; i < n; i++){
    80026d72:	4481                	li	s1,0
    80026d74:	bfe9                	j	80026d4e <consolewrite+0x5e>

0000000080026d76 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80026d76:	7119                	addi	sp,sp,-128
    80026d78:	fc86                	sd	ra,120(sp)
    80026d7a:	f8a2                	sd	s0,112(sp)
    80026d7c:	f4a6                	sd	s1,104(sp)
    80026d7e:	f0ca                	sd	s2,96(sp)
    80026d80:	ecce                	sd	s3,88(sp)
    80026d82:	e8d2                	sd	s4,80(sp)
    80026d84:	e4d6                	sd	s5,72(sp)
    80026d86:	e0da                	sd	s6,64(sp)
    80026d88:	fc5e                	sd	s7,56(sp)
    80026d8a:	f862                	sd	s8,48(sp)
    80026d8c:	f466                	sd	s9,40(sp)
    80026d8e:	f06a                	sd	s10,32(sp)
    80026d90:	ec6e                	sd	s11,24(sp)
    80026d92:	0100                	addi	s0,sp,128
    80026d94:	8caa                	mv	s9,a0
    80026d96:	8aae                	mv	s5,a1
    80026d98:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80026d9a:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80026d9e:	0001f517          	auipc	a0,0x1f
    80026da2:	e8250513          	addi	a0,a0,-382 # 80045c20 <cons>
    80026da6:	ffffa097          	auipc	ra,0xffffa
    80026daa:	91a080e7          	jalr	-1766(ra) # 800206c0 <acquire>
  while(n > 0){
    80026dae:	09405663          	blez	s4,80026e3a <consoleread+0xc4>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80026db2:	0001f497          	auipc	s1,0x1f
    80026db6:	e6e48493          	addi	s1,s1,-402 # 80045c20 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80026dba:	89a6                	mv	s3,s1
    80026dbc:	0001f917          	auipc	s2,0x1f
    80026dc0:	efc90913          	addi	s2,s2,-260 # 80045cb8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    80026dc4:	4c11                	li	s8,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80026dc6:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80026dc8:	4da9                	li	s11,10
    while(cons.r == cons.w){
    80026dca:	0984a783          	lw	a5,152(s1)
    80026dce:	09c4a703          	lw	a4,156(s1)
    80026dd2:	02f71463          	bne	a4,a5,80026dfa <consoleread+0x84>
      if(myproc()->killed){
    80026dd6:	ffffb097          	auipc	ra,0xffffb
    80026dda:	dac080e7          	jalr	-596(ra) # 80021b82 <myproc>
    80026dde:	591c                	lw	a5,48(a0)
    80026de0:	eba5                	bnez	a5,80026e50 <consoleread+0xda>
      sleep(&cons.r, &cons.lock);
    80026de2:	85ce                	mv	a1,s3
    80026de4:	854a                	mv	a0,s2
    80026de6:	ffffb097          	auipc	ra,0xffffb
    80026dea:	644080e7          	jalr	1604(ra) # 8002242a <sleep>
    while(cons.r == cons.w){
    80026dee:	0984a783          	lw	a5,152(s1)
    80026df2:	09c4a703          	lw	a4,156(s1)
    80026df6:	fef700e3          	beq	a4,a5,80026dd6 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF];
    80026dfa:	0017871b          	addiw	a4,a5,1
    80026dfe:	08e4ac23          	sw	a4,152(s1)
    80026e02:	07f7f713          	andi	a4,a5,127
    80026e06:	9726                	add	a4,a4,s1
    80026e08:	01874703          	lbu	a4,24(a4) # 8000018 <BASE_ADDRESS-0x7801ffe8>
    80026e0c:	00070b9b          	sext.w	s7,a4
    if(c == C('D')){  // end-of-file
    80026e10:	078b8863          	beq	s7,s8,80026e80 <consoleread+0x10a>
    cbuf = c;
    80026e14:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80026e18:	4685                	li	a3,1
    80026e1a:	f8f40613          	addi	a2,s0,-113
    80026e1e:	85d6                	mv	a1,s5
    80026e20:	8566                	mv	a0,s9
    80026e22:	ffffc097          	auipc	ra,0xffffc
    80026e26:	8b6080e7          	jalr	-1866(ra) # 800226d8 <either_copyout>
    80026e2a:	01a50863          	beq	a0,s10,80026e3a <consoleread+0xc4>
    dst++;
    80026e2e:	0a85                	addi	s5,s5,1
    --n;
    80026e30:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80026e32:	01bb8463          	beq	s7,s11,80026e3a <consoleread+0xc4>
  while(n > 0){
    80026e36:	f80a1ae3          	bnez	s4,80026dca <consoleread+0x54>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80026e3a:	0001f517          	auipc	a0,0x1f
    80026e3e:	de650513          	addi	a0,a0,-538 # 80045c20 <cons>
    80026e42:	ffffa097          	auipc	ra,0xffffa
    80026e46:	8d2080e7          	jalr	-1838(ra) # 80020714 <release>

  return target - n;
    80026e4a:	414b053b          	subw	a0,s6,s4
    80026e4e:	a811                	j	80026e62 <consoleread+0xec>
        release(&cons.lock);
    80026e50:	0001f517          	auipc	a0,0x1f
    80026e54:	dd050513          	addi	a0,a0,-560 # 80045c20 <cons>
    80026e58:	ffffa097          	auipc	ra,0xffffa
    80026e5c:	8bc080e7          	jalr	-1860(ra) # 80020714 <release>
        return -1;
    80026e60:	557d                	li	a0,-1
}
    80026e62:	70e6                	ld	ra,120(sp)
    80026e64:	7446                	ld	s0,112(sp)
    80026e66:	74a6                	ld	s1,104(sp)
    80026e68:	7906                	ld	s2,96(sp)
    80026e6a:	69e6                	ld	s3,88(sp)
    80026e6c:	6a46                	ld	s4,80(sp)
    80026e6e:	6aa6                	ld	s5,72(sp)
    80026e70:	6b06                	ld	s6,64(sp)
    80026e72:	7be2                	ld	s7,56(sp)
    80026e74:	7c42                	ld	s8,48(sp)
    80026e76:	7ca2                	ld	s9,40(sp)
    80026e78:	7d02                	ld	s10,32(sp)
    80026e7a:	6de2                	ld	s11,24(sp)
    80026e7c:	6109                	addi	sp,sp,128
    80026e7e:	8082                	ret
      if(n < target){
    80026e80:	000a071b          	sext.w	a4,s4
    80026e84:	fb677be3          	bgeu	a4,s6,80026e3a <consoleread+0xc4>
        cons.r--;
    80026e88:	0001f717          	auipc	a4,0x1f
    80026e8c:	e2f72823          	sw	a5,-464(a4) # 80045cb8 <cons+0x98>
    80026e90:	b76d                	j	80026e3a <consoleread+0xc4>

0000000080026e92 <consputc>:
void consputc(int c) {
    80026e92:	1141                	addi	sp,sp,-16
    80026e94:	e422                	sd	s0,8(sp)
    80026e96:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80026e98:	10000793          	li	a5,256
    80026e9c:	00f50b63          	beq	a0,a5,80026eb2 <consputc+0x20>
    80026ea0:	4581                	li	a1,0
    80026ea2:	4601                	li	a2,0
    80026ea4:	4681                	li	a3,0
    80026ea6:	4885                	li	a7,1
    80026ea8:	00000073          	ecall
}
    80026eac:	6422                	ld	s0,8(sp)
    80026eae:	0141                	addi	sp,sp,16
    80026eb0:	8082                	ret
    80026eb2:	4521                	li	a0,8
    80026eb4:	4581                	li	a1,0
    80026eb6:	4601                	li	a2,0
    80026eb8:	4681                	li	a3,0
    80026eba:	4885                	li	a7,1
    80026ebc:	00000073          	ecall
    80026ec0:	02000513          	li	a0,32
    80026ec4:	00000073          	ecall
    80026ec8:	4521                	li	a0,8
    80026eca:	00000073          	ecall
    80026ece:	bff9                	j	80026eac <consputc+0x1a>

0000000080026ed0 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80026ed0:	1101                	addi	sp,sp,-32
    80026ed2:	ec06                	sd	ra,24(sp)
    80026ed4:	e822                	sd	s0,16(sp)
    80026ed6:	e426                	sd	s1,8(sp)
    80026ed8:	e04a                	sd	s2,0(sp)
    80026eda:	1000                	addi	s0,sp,32
    80026edc:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80026ede:	0001f517          	auipc	a0,0x1f
    80026ee2:	d4250513          	addi	a0,a0,-702 # 80045c20 <cons>
    80026ee6:	ffff9097          	auipc	ra,0xffff9
    80026eea:	7da080e7          	jalr	2010(ra) # 800206c0 <acquire>

  switch(c){
    80026eee:	47c1                	li	a5,16
    80026ef0:	14f48063          	beq	s1,a5,80027030 <consoleintr+0x160>
    80026ef4:	0297df63          	bge	a5,s1,80026f32 <consoleintr+0x62>
    80026ef8:	47d5                	li	a5,21
    80026efa:	0cf48463          	beq	s1,a5,80026fc2 <consoleintr+0xf2>
    80026efe:	07f00793          	li	a5,127
    80026f02:	02f49b63          	bne	s1,a5,80026f38 <consoleintr+0x68>
      consputc(BACKSPACE);
    }
    break;
  case C('H'): // Backspace
  case '\x7f':
    if(cons.e != cons.w){
    80026f06:	0001f717          	auipc	a4,0x1f
    80026f0a:	d1a70713          	addi	a4,a4,-742 # 80045c20 <cons>
    80026f0e:	0a072783          	lw	a5,160(a4)
    80026f12:	09c72703          	lw	a4,156(a4)
    80026f16:	12f70163          	beq	a4,a5,80027038 <consoleintr+0x168>
      cons.e--;
    80026f1a:	37fd                	addiw	a5,a5,-1
    80026f1c:	0001f717          	auipc	a4,0x1f
    80026f20:	daf72223          	sw	a5,-604(a4) # 80045cc0 <cons+0xa0>
      consputc(BACKSPACE);
    80026f24:	10000513          	li	a0,256
    80026f28:	00000097          	auipc	ra,0x0
    80026f2c:	f6a080e7          	jalr	-150(ra) # 80026e92 <consputc>
    80026f30:	a221                	j	80027038 <consoleintr+0x168>
  switch(c){
    80026f32:	47a1                	li	a5,8
    80026f34:	fcf489e3          	beq	s1,a5,80026f06 <consoleintr+0x36>
    }
    break;
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80026f38:	10048063          	beqz	s1,80027038 <consoleintr+0x168>
    80026f3c:	0001f717          	auipc	a4,0x1f
    80026f40:	ce470713          	addi	a4,a4,-796 # 80045c20 <cons>
    80026f44:	0a072783          	lw	a5,160(a4)
    80026f48:	09872703          	lw	a4,152(a4)
    80026f4c:	9f99                	subw	a5,a5,a4
    80026f4e:	07f00713          	li	a4,127
    80026f52:	0ef76363          	bltu	a4,a5,80027038 <consoleintr+0x168>
      #ifndef QEMU
      if (c == '\r') break;     // on k210, "enter" will input \n and \r
    80026f56:	47b5                	li	a5,13
    80026f58:	0ef48063          	beq	s1,a5,80027038 <consoleintr+0x168>
      #else
      c = (c == '\r') ? '\n' : c;
      #endif
      // echo back to the user.
      consputc(c);
    80026f5c:	8526                	mv	a0,s1
    80026f5e:	00000097          	auipc	ra,0x0
    80026f62:	f34080e7          	jalr	-204(ra) # 80026e92 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80026f66:	0001f797          	auipc	a5,0x1f
    80026f6a:	cba78793          	addi	a5,a5,-838 # 80045c20 <cons>
    80026f6e:	0a07a703          	lw	a4,160(a5)
    80026f72:	0017069b          	addiw	a3,a4,1
    80026f76:	0006861b          	sext.w	a2,a3
    80026f7a:	0ad7a023          	sw	a3,160(a5)
    80026f7e:	07f77713          	andi	a4,a4,127
    80026f82:	97ba                	add	a5,a5,a4
    80026f84:	00978c23          	sb	s1,24(a5)

      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80026f88:	47a9                	li	a5,10
    80026f8a:	00f48f63          	beq	s1,a5,80026fa8 <consoleintr+0xd8>
    80026f8e:	4791                	li	a5,4
    80026f90:	00f48c63          	beq	s1,a5,80026fa8 <consoleintr+0xd8>
    80026f94:	0001f797          	auipc	a5,0x1f
    80026f98:	c8c78793          	addi	a5,a5,-884 # 80045c20 <cons>
    80026f9c:	0987a783          	lw	a5,152(a5)
    80026fa0:	0807879b          	addiw	a5,a5,128
    80026fa4:	08c79a63          	bne	a5,a2,80027038 <consoleintr+0x168>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80026fa8:	0001f797          	auipc	a5,0x1f
    80026fac:	d0d7aa23          	sw	a3,-748(a5) # 80045cbc <cons+0x9c>
        wakeup(&cons.r);
    80026fb0:	0001f517          	auipc	a0,0x1f
    80026fb4:	d0850513          	addi	a0,a0,-760 # 80045cb8 <cons+0x98>
    80026fb8:	ffffb097          	auipc	ra,0xffffb
    80026fbc:	646080e7          	jalr	1606(ra) # 800225fe <wakeup>
    80026fc0:	a8a5                	j	80027038 <consoleintr+0x168>
    while(cons.e != cons.w &&
    80026fc2:	0001f717          	auipc	a4,0x1f
    80026fc6:	c5e70713          	addi	a4,a4,-930 # 80045c20 <cons>
    80026fca:	0a072783          	lw	a5,160(a4)
    80026fce:	09c72703          	lw	a4,156(a4)
    80026fd2:	06f70363          	beq	a4,a5,80027038 <consoleintr+0x168>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80026fd6:	37fd                	addiw	a5,a5,-1
    80026fd8:	0007871b          	sext.w	a4,a5
    80026fdc:	07f7f793          	andi	a5,a5,127
    80026fe0:	0001f697          	auipc	a3,0x1f
    80026fe4:	c4068693          	addi	a3,a3,-960 # 80045c20 <cons>
    80026fe8:	97b6                	add	a5,a5,a3
    while(cons.e != cons.w &&
    80026fea:	0187c683          	lbu	a3,24(a5)
    80026fee:	47a9                	li	a5,10
      cons.e--;
    80026ff0:	0001f497          	auipc	s1,0x1f
    80026ff4:	c3048493          	addi	s1,s1,-976 # 80045c20 <cons>
    while(cons.e != cons.w &&
    80026ff8:	4929                	li	s2,10
    80026ffa:	02f68f63          	beq	a3,a5,80027038 <consoleintr+0x168>
      cons.e--;
    80026ffe:	0ae4a023          	sw	a4,160(s1)
      consputc(BACKSPACE);
    80027002:	10000513          	li	a0,256
    80027006:	00000097          	auipc	ra,0x0
    8002700a:	e8c080e7          	jalr	-372(ra) # 80026e92 <consputc>
    while(cons.e != cons.w &&
    8002700e:	0a04a783          	lw	a5,160(s1)
    80027012:	09c4a703          	lw	a4,156(s1)
    80027016:	02f70163          	beq	a4,a5,80027038 <consoleintr+0x168>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    8002701a:	37fd                	addiw	a5,a5,-1
    8002701c:	0007871b          	sext.w	a4,a5
    80027020:	07f7f793          	andi	a5,a5,127
    80027024:	97a6                	add	a5,a5,s1
    while(cons.e != cons.w &&
    80027026:	0187c783          	lbu	a5,24(a5)
    8002702a:	fd279ae3          	bne	a5,s2,80026ffe <consoleintr+0x12e>
    8002702e:	a029                	j	80027038 <consoleintr+0x168>
    procdump();
    80027030:	ffffb097          	auipc	ra,0xffffb
    80027034:	712080e7          	jalr	1810(ra) # 80022742 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80027038:	0001f517          	auipc	a0,0x1f
    8002703c:	be850513          	addi	a0,a0,-1048 # 80045c20 <cons>
    80027040:	ffff9097          	auipc	ra,0xffff9
    80027044:	6d4080e7          	jalr	1748(ra) # 80020714 <release>
}
    80027048:	60e2                	ld	ra,24(sp)
    8002704a:	6442                	ld	s0,16(sp)
    8002704c:	64a2                	ld	s1,8(sp)
    8002704e:	6902                	ld	s2,0(sp)
    80027050:	6105                	addi	sp,sp,32
    80027052:	8082                	ret

0000000080027054 <consoleinit>:

void
consoleinit(void)
{
    80027054:	1101                	addi	sp,sp,-32
    80027056:	ec06                	sd	ra,24(sp)
    80027058:	e822                	sd	s0,16(sp)
    8002705a:	e426                	sd	s1,8(sp)
    8002705c:	1000                	addi	s0,sp,32
  initlock(&cons.lock, "cons");
    8002705e:	0001f497          	auipc	s1,0x1f
    80027062:	bc248493          	addi	s1,s1,-1086 # 80045c20 <cons>
    80027066:	00006597          	auipc	a1,0x6
    8002706a:	bea58593          	addi	a1,a1,-1046 # 8002cc50 <syscalls+0xb98>
    8002706e:	8526                	mv	a0,s1
    80027070:	ffff9097          	auipc	ra,0xffff9
    80027074:	60c080e7          	jalr	1548(ra) # 8002067c <initlock>

  cons.e = cons.w = cons.r = 0;
    80027078:	0804ac23          	sw	zero,152(s1)
    8002707c:	0804ae23          	sw	zero,156(s1)
    80027080:	0a04a023          	sw	zero,160(s1)
  
  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80027084:	00019797          	auipc	a5,0x19
    80027088:	32c78793          	addi	a5,a5,812 # 800403b0 <devsw>
    8002708c:	00000717          	auipc	a4,0x0
    80027090:	cea70713          	addi	a4,a4,-790 # 80026d76 <consoleread>
    80027094:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80027096:	00000717          	auipc	a4,0x0
    8002709a:	c5a70713          	addi	a4,a4,-934 # 80026cf0 <consolewrite>
    8002709e:	ef98                	sd	a4,24(a5)
}
    800270a0:	60e2                	ld	ra,24(sp)
    800270a2:	6442                	ld	s0,16(sp)
    800270a4:	64a2                	ld	s1,8(sp)
    800270a6:	6105                	addi	sp,sp,32
    800270a8:	8082                	ret

00000000800270aa <spi_set_tmod>:
    spi_adapter->endian = endian;
}


static void spi_set_tmod(uint8 spi_num, uint32 tmod)
{
    800270aa:	1141                	addi	sp,sp,-16
    800270ac:	e406                	sd	ra,8(sp)
    800270ae:	e022                	sd	s0,0(sp)
    800270b0:	0800                	addi	s0,sp,16
    800270b2:	872a                	mv	a4,a0
    // configASSERT(spi_num < SPI_DEVICE_MAX);
    volatile spi_t *spi_handle = spi[spi_num];
    800270b4:	00351693          	slli	a3,a0,0x3
    800270b8:	00006797          	auipc	a5,0x6
    800270bc:	ba078793          	addi	a5,a5,-1120 # 8002cc58 <spi>
    800270c0:	97b6                	add	a5,a5,a3
    800270c2:	6388                	ld	a0,0(a5)
    uint8 tmod_offset = 0;
    switch(spi_num)
    800270c4:	4689                	li	a3,2
    {
        case 0:
        case 1:
        case 2:
            tmod_offset = 8;
    800270c6:	47a1                	li	a5,8
    switch(spi_num)
    800270c8:	00e6f363          	bgeu	a3,a4,800270ce <spi_set_tmod+0x24>
            break;
        case 3:
        default:
            tmod_offset = 10;
    800270cc:	47a9                	li	a5,10
            break;
    }
    set_bit(&spi_handle->ctrlr0, 3 << tmod_offset, tmod << tmod_offset);
    800270ce:	2781                	sext.w	a5,a5
    800270d0:	00f5963b          	sllw	a2,a1,a5
    800270d4:	458d                	li	a1,3
    800270d6:	00f595bb          	sllw	a1,a1,a5
    800270da:	00001097          	auipc	ra,0x1
    800270de:	f10080e7          	jalr	-240(ra) # 80027fea <set_bit>
}
    800270e2:	60a2                	ld	ra,8(sp)
    800270e4:	6402                	ld	s0,0(sp)
    800270e6:	0141                	addi	sp,sp,16
    800270e8:	8082                	ret

00000000800270ea <spi_init>:
{
    800270ea:	1141                	addi	sp,sp,-16
    800270ec:	e422                	sd	s0,8(sp)
    800270ee:	0800                	addi	s0,sp,16
    switch(spi_num)
    800270f0:	4785                	li	a5,1
    800270f2:	06a7f463          	bgeu	a5,a0,8002715a <spi_init+0x70>
    800270f6:	4789                	li	a5,2
    800270f8:	06f50563          	beq	a0,a5,80027162 <spi_init+0x78>
            work_mode_offset = 8;
    800270fc:	4321                	li	t1,8
            frf_offset = 22;
    800270fe:	48d9                	li	a7,22
            dfs_offset = 0;
    80027100:	4801                	li	a6,0
    volatile spi_t *spi_adapter = spi[spi_num];
    80027102:	1502                	slli	a0,a0,0x20
    80027104:	9101                	srli	a0,a0,0x20
    80027106:	050e                	slli	a0,a0,0x3
    80027108:	00006797          	auipc	a5,0x6
    8002710c:	b5078793          	addi	a5,a5,-1200 # 8002cc58 <spi>
    80027110:	953e                	add	a0,a0,a5
    80027112:	611c                	ld	a5,0(a0)
    if(spi_adapter->baudr == 0)
    80027114:	4bc8                	lw	a0,20(a5)
    80027116:	2501                	sext.w	a0,a0
    80027118:	e119                	bnez	a0,8002711e <spi_init+0x34>
        spi_adapter->baudr = 0x14;
    8002711a:	4551                	li	a0,20
    8002711c:	cbc8                	sw	a0,20(a5)
    spi_adapter->imr = 0x00;
    8002711e:	0207a623          	sw	zero,44(a5)
    spi_adapter->dmacr = 0x00;
    80027122:	0407a623          	sw	zero,76(a5)
    spi_adapter->dmatdlr = 0x10;
    80027126:	4541                	li	a0,16
    80027128:	cba8                	sw	a0,80(a5)
    spi_adapter->dmardlr = 0x00;
    8002712a:	0407aa23          	sw	zero,84(a5)
    spi_adapter->ser = 0x00;
    8002712e:	0007a823          	sw	zero,16(a5)
    spi_adapter->ssienr = 0x00;
    80027132:	0007a423          	sw	zero,8(a5)
    spi_adapter->ctrlr0 = (work_mode << work_mode_offset) | (frame_format << frf_offset) | ((data_bit_length - 1) << dfs_offset);
    80027136:	006595bb          	sllw	a1,a1,t1
    8002713a:	0116163b          	sllw	a2,a2,a7
    8002713e:	8dd1                	or	a1,a1,a2
    80027140:	16fd                	addi	a3,a3,-1
    80027142:	010696b3          	sll	a3,a3,a6
    80027146:	8dd5                	or	a1,a1,a3
    80027148:	2581                	sext.w	a1,a1
    8002714a:	c38c                	sw	a1,0(a5)
    spi_adapter->spi_ctrlr0 = 0;
    8002714c:	0e07aa23          	sw	zero,244(a5)
    spi_adapter->endian = endian;
    80027150:	10e7ac23          	sw	a4,280(a5)
}
    80027154:	6422                	ld	s0,8(sp)
    80027156:	0141                	addi	sp,sp,16
    80027158:	8082                	ret
            work_mode_offset = 6;
    8002715a:	4319                	li	t1,6
            frf_offset = 21;
    8002715c:	48d5                	li	a7,21
            dfs_offset = 16;
    8002715e:	4841                	li	a6,16
    80027160:	b74d                	j	80027102 <spi_init+0x18>
    uint8 work_mode_offset = 0;
    80027162:	4301                	li	t1,0
    uint8 frf_offset = 0;
    80027164:	4881                	li	a7,0
    uint8 dfs_offset = 0;
    80027166:	4801                	li	a6,0
    80027168:	bf69                	j	80027102 <spi_init+0x18>

000000008002716a <spi_send_data_normal>:
        return SPI_TRANS_SHORT;
    return SPI_TRANS_INT;
}

void spi_send_data_normal(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *tx_buff, uint64 tx_len)
{
    8002716a:	7119                	addi	sp,sp,-128
    8002716c:	fc86                	sd	ra,120(sp)
    8002716e:	f8a2                	sd	s0,112(sp)
    80027170:	f4a6                	sd	s1,104(sp)
    80027172:	f0ca                	sd	s2,96(sp)
    80027174:	ecce                	sd	s3,88(sp)
    80027176:	e8d2                	sd	s4,80(sp)
    80027178:	e4d6                	sd	s5,72(sp)
    8002717a:	e0da                	sd	s6,64(sp)
    8002717c:	fc5e                	sd	s7,56(sp)
    8002717e:	f862                	sd	s8,48(sp)
    80027180:	f466                	sd	s9,40(sp)
    80027182:	f06a                	sd	s10,32(sp)
    80027184:	ec6e                	sd	s11,24(sp)
    80027186:	0100                	addi	s0,sp,128
    80027188:	84aa                	mv	s1,a0
    8002718a:	8aae                	mv	s5,a1
    8002718c:	89b2                	mv	s3,a2
    8002718e:	8a36                	mv	s4,a3
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    uint64 index, fifo_len;
    spi_set_tmod(spi_num, SPI_TMOD_TRANS);
    80027190:	4585                	li	a1,1
    80027192:	0ff57513          	andi	a0,a0,255
    80027196:	00000097          	auipc	ra,0x0
    8002719a:	f14080e7          	jalr	-236(ra) # 800270aa <spi_set_tmod>

    volatile spi_t *spi_handle = spi[spi_num];
    8002719e:	02049793          	slli	a5,s1,0x20
    800271a2:	9381                	srli	a5,a5,0x20
    800271a4:	00379713          	slli	a4,a5,0x3
    800271a8:	00006797          	auipc	a5,0x6
    800271ac:	ab078793          	addi	a5,a5,-1360 # 8002cc58 <spi>
    800271b0:	97ba                	add	a5,a5,a4
    800271b2:	0007b903          	ld	s2,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    800271b6:	0024b493          	sltiu	s1,s1,2
    800271ba:	0492                	slli	s1,s1,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    800271bc:	00092783          	lw	a5,0(s2)
    800271c0:	0097d4bb          	srlw	s1,a5,s1
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    800271c4:	88fd                	andi	s1,s1,31
    if(data_bit_length < 8)
    800271c6:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    800271c8:	4b85                	li	s7,1
    if(data_bit_length < 8)
    800271ca:	0097f663          	bgeu	a5,s1,800271d6 <spi_send_data_normal+0x6c>
    else if(data_bit_length < 16)
    800271ce:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    800271d0:	4b91                	li	s7,4
    else if(data_bit_length < 16)
    800271d2:	0297f863          	bgeu	a5,s1,80027202 <spi_send_data_normal+0x98>

    uint8 v_misalign_flag = 0;
    uint32 v_send_data;
    if((uintptr_t)tx_buff % frame_width)
    800271d6:	020b9c93          	slli	s9,s7,0x20
    800271da:	020cdc93          	srli	s9,s9,0x20
    800271de:	0399fcb3          	remu	s9,s3,s9
        v_misalign_flag = 1;

    spi_handle->ssienr = 0x01;
    800271e2:	4785                	li	a5,1
    800271e4:	00f92423          	sw	a5,8(s2)
    spi_handle->ser = 1U << chip_select;
    800271e8:	4585                	li	a1,1
    800271ea:	015595bb          	sllw	a1,a1,s5
    800271ee:	00b92823          	sw	a1,16(s2)
    uint32 i = 0;
    while(tx_len)
    800271f2:	120a0a63          	beqz	s4,80027326 <spi_send_data_normal+0x1bc>
    uint32 i = 0;
    800271f6:	4481                	li	s1,0
    {
        fifo_len = 32 - spi_handle->txflr;
    800271f8:	02000c13          	li	s8,32
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
        switch(frame_width)
    800271fc:	4b09                	li	s6,2
    800271fe:	4a91                	li	s5,4
    80027200:	a0b5                	j	8002726c <spi_send_data_normal+0x102>
        return SPI_TRANS_SHORT;
    80027202:	4b89                	li	s7,2
    80027204:	bfc9                	j	800271d6 <spi_send_data_normal+0x6c>
        {
            case SPI_TRANS_INT:
                fifo_len = fifo_len / 4 * 4;
    80027206:	ffc77d13          	andi	s10,a4,-4
                if(v_misalign_flag)
    8002720a:	020c9763          	bnez	s9,80027238 <spi_send_data_normal+0xce>
                        spi_handle->dr[0] = v_send_data;
                        i += 4;
                    }
                } else
                {
                    for(index = 0; index < fifo_len / 4; index++)
    8002720e:	8309                	srli	a4,a4,0x2
    80027210:	009705bb          	addw	a1,a4,s1
    80027214:	87a6                	mv	a5,s1
    80027216:	c739                	beqz	a4,80027264 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint32 *)tx_buff)[i++];
    80027218:	0017869b          	addiw	a3,a5,1
    8002721c:	0006861b          	sext.w	a2,a3
    80027220:	1782                	slli	a5,a5,0x20
    80027222:	9381                	srli	a5,a5,0x20
    80027224:	078a                	slli	a5,a5,0x2
    80027226:	97ce                	add	a5,a5,s3
    80027228:	439c                	lw	a5,0(a5)
    8002722a:	06f92023          	sw	a5,96(s2)
    8002722e:	87b2                	mv	a5,a2
                    for(index = 0; index < fifo_len / 4; index++)
    80027230:	fec594e3          	bne	a1,a2,80027218 <spi_send_data_normal+0xae>
    80027234:	9cb9                	addw	s1,s1,a4
    80027236:	a03d                	j	80027264 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 4)
    80027238:	020d0663          	beqz	s10,80027264 <spi_send_data_normal+0xfa>
    8002723c:	4d81                	li	s11,0
                        memmove(&v_send_data, tx_buff + i, 4);
    8002723e:	02049593          	slli	a1,s1,0x20
    80027242:	9181                	srli	a1,a1,0x20
    80027244:	8656                	mv	a2,s5
    80027246:	95ce                	add	a1,a1,s3
    80027248:	f8c40513          	addi	a0,s0,-116
    8002724c:	ffff9097          	auipc	ra,0xffff9
    80027250:	57c080e7          	jalr	1404(ra) # 800207c8 <memmove>
                        spi_handle->dr[0] = v_send_data;
    80027254:	f8c42783          	lw	a5,-116(s0)
    80027258:	06f92023          	sw	a5,96(s2)
                        i += 4;
    8002725c:	2491                	addiw	s1,s1,4
                    for(index = 0; index < fifo_len; index += 4)
    8002725e:	0d91                	addi	s11,s11,4
    80027260:	fdadefe3          	bltu	s11,s10,8002723e <spi_send_data_normal+0xd4>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = tx_buff[i++];
                break;
        }
        tx_len -= fifo_len;
    80027264:	41aa0a33          	sub	s4,s4,s10
    while(tx_len)
    80027268:	0a0a0f63          	beqz	s4,80027326 <spi_send_data_normal+0x1bc>
        fifo_len = 32 - spi_handle->txflr;
    8002726c:	02092703          	lw	a4,32(s2)
    80027270:	40ec073b          	subw	a4,s8,a4
    80027274:	1702                	slli	a4,a4,0x20
    80027276:	9301                	srli	a4,a4,0x20
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    80027278:	00ea7363          	bgeu	s4,a4,8002727e <spi_send_data_normal+0x114>
    8002727c:	8752                	mv	a4,s4
        switch(frame_width)
    8002727e:	036b8a63          	beq	s7,s6,800272b2 <spi_send_data_normal+0x148>
    80027282:	f95b82e3          	beq	s7,s5,80027206 <spi_send_data_normal+0x9c>
    80027286:	009705bb          	addw	a1,a4,s1
                for(index = 0; index < fifo_len; index++)
    8002728a:	87a6                	mv	a5,s1
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    8002728c:	8d3a                	mv	s10,a4
                for(index = 0; index < fifo_len; index++)
    8002728e:	db79                	beqz	a4,80027264 <spi_send_data_normal+0xfa>
                    spi_handle->dr[0] = tx_buff[i++];
    80027290:	0017869b          	addiw	a3,a5,1
    80027294:	0006861b          	sext.w	a2,a3
    80027298:	1782                	slli	a5,a5,0x20
    8002729a:	9381                	srli	a5,a5,0x20
    8002729c:	97ce                	add	a5,a5,s3
    8002729e:	0007c783          	lbu	a5,0(a5)
    800272a2:	06f92023          	sw	a5,96(s2)
    800272a6:	87b2                	mv	a5,a2
                for(index = 0; index < fifo_len; index++)
    800272a8:	fec594e3          	bne	a1,a2,80027290 <spi_send_data_normal+0x126>
    800272ac:	9cb9                	addw	s1,s1,a4
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    800272ae:	8d3a                	mv	s10,a4
    800272b0:	bf55                	j	80027264 <spi_send_data_normal+0xfa>
                fifo_len = fifo_len / 2 * 2;
    800272b2:	ffe77d13          	andi	s10,a4,-2
                if(v_misalign_flag)
    800272b6:	020c9863          	bnez	s9,800272e6 <spi_send_data_normal+0x17c>
                    for(index = 0; index < fifo_len / 2; index++)
    800272ba:	8305                	srli	a4,a4,0x1
    800272bc:	009705bb          	addw	a1,a4,s1
    800272c0:	87a6                	mv	a5,s1
    800272c2:	d34d                	beqz	a4,80027264 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint16 *)tx_buff)[i++];
    800272c4:	0017869b          	addiw	a3,a5,1
    800272c8:	0006861b          	sext.w	a2,a3
    800272cc:	1782                	slli	a5,a5,0x20
    800272ce:	9381                	srli	a5,a5,0x20
    800272d0:	0786                	slli	a5,a5,0x1
    800272d2:	97ce                	add	a5,a5,s3
    800272d4:	0007d783          	lhu	a5,0(a5)
    800272d8:	06f92023          	sw	a5,96(s2)
    800272dc:	87b2                	mv	a5,a2
                    for(index = 0; index < fifo_len / 2; index++)
    800272de:	fec593e3          	bne	a1,a2,800272c4 <spi_send_data_normal+0x15a>
    800272e2:	9cb9                	addw	s1,s1,a4
    800272e4:	b741                	j	80027264 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 2)
    800272e6:	f60d0fe3          	beqz	s10,80027264 <spi_send_data_normal+0xfa>
    800272ea:	fffd0d93          	addi	s11,s10,-1 # ffffffffffffefff <kernel_end+0xffffffff7ffb8fff>
    800272ee:	001ddd93          	srli	s11,s11,0x1
    800272f2:	001d9d9b          	slliw	s11,s11,0x1
    800272f6:	0024879b          	addiw	a5,s1,2
    800272fa:	00fd8dbb          	addw	s11,s11,a5
                        memmove(&v_send_data, tx_buff + i, 2);
    800272fe:	02049593          	slli	a1,s1,0x20
    80027302:	9181                	srli	a1,a1,0x20
    80027304:	865a                	mv	a2,s6
    80027306:	95ce                	add	a1,a1,s3
    80027308:	f8c40513          	addi	a0,s0,-116
    8002730c:	ffff9097          	auipc	ra,0xffff9
    80027310:	4bc080e7          	jalr	1212(ra) # 800207c8 <memmove>
                        spi_handle->dr[0] = v_send_data;
    80027314:	f8c42783          	lw	a5,-116(s0)
    80027318:	06f92023          	sw	a5,96(s2)
                        i += 2;
    8002731c:	2489                	addiw	s1,s1,2
                    for(index = 0; index < fifo_len; index += 2)
    8002731e:	fe9d90e3          	bne	s11,s1,800272fe <spi_send_data_normal+0x194>
                        i += 2;
    80027322:	84ee                	mv	s1,s11
    80027324:	b781                	j	80027264 <spi_send_data_normal+0xfa>
    }
    while((spi_handle->sr & 0x05) != 0x04)
    80027326:	4711                	li	a4,4
    80027328:	02892783          	lw	a5,40(s2)
    8002732c:	8b95                	andi	a5,a5,5
    8002732e:	fee79de3          	bne	a5,a4,80027328 <spi_send_data_normal+0x1be>
        ;
    spi_handle->ser = 0x00;
    80027332:	00092823          	sw	zero,16(s2)
    spi_handle->ssienr = 0x00;
    80027336:	00092423          	sw	zero,8(s2)
}
    8002733a:	70e6                	ld	ra,120(sp)
    8002733c:	7446                	ld	s0,112(sp)
    8002733e:	74a6                	ld	s1,104(sp)
    80027340:	7906                	ld	s2,96(sp)
    80027342:	69e6                	ld	s3,88(sp)
    80027344:	6a46                	ld	s4,80(sp)
    80027346:	6aa6                	ld	s5,72(sp)
    80027348:	6b06                	ld	s6,64(sp)
    8002734a:	7be2                	ld	s7,56(sp)
    8002734c:	7c42                	ld	s8,48(sp)
    8002734e:	7ca2                	ld	s9,40(sp)
    80027350:	7d02                	ld	s10,32(sp)
    80027352:	6de2                	ld	s11,24(sp)
    80027354:	6109                	addi	sp,sp,128
    80027356:	8082                	ret

0000000080027358 <spi_send_data_standard>:

void spi_send_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                            uint64 cmd_len, const uint8 *tx_buff, uint64 tx_len)
{
    80027358:	715d                	addi	sp,sp,-80
    8002735a:	e486                	sd	ra,72(sp)
    8002735c:	e0a2                	sd	s0,64(sp)
    8002735e:	fc26                	sd	s1,56(sp)
    80027360:	f84a                	sd	s2,48(sp)
    80027362:	f44e                	sd	s3,40(sp)
    80027364:	f052                	sd	s4,32(sp)
    80027366:	ec56                	sd	s5,24(sp)
    80027368:	e85a                	sd	s6,16(sp)
    8002736a:	e45e                	sd	s7,8(sp)
    8002736c:	0880                	addi	s0,sp,80
    8002736e:	8a2a                	mv	s4,a0
    80027370:	8aae                	mv	s5,a1
    80027372:	8bb2                	mv	s7,a2
    80027374:	8936                	mv	s2,a3
    80027376:	8b3a                	mv	s6,a4
    80027378:	89be                	mv	s3,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    // uint8 *v_buf = malloc(cmd_len + tx_len);
    uint8 *v_buf = kalloc();
    8002737a:	ffff9097          	auipc	ra,0xffff9
    8002737e:	1d8080e7          	jalr	472(ra) # 80020552 <kalloc>
    80027382:	84aa                	mv	s1,a0
    uint64 i;
    for(i = 0; i < cmd_len; i++)
    80027384:	00090e63          	beqz	s2,800273a0 <spi_send_data_standard+0x48>
    80027388:	87de                	mv	a5,s7
    8002738a:	872a                	mv	a4,a0
    8002738c:	012b8633          	add	a2,s7,s2
        v_buf[i] = cmd_buff[i];
    80027390:	0007c683          	lbu	a3,0(a5)
    80027394:	00d70023          	sb	a3,0(a4)
    80027398:	0785                	addi	a5,a5,1
    8002739a:	0705                	addi	a4,a4,1
    for(i = 0; i < cmd_len; i++)
    8002739c:	fec79ae3          	bne	a5,a2,80027390 <spi_send_data_standard+0x38>
    for(i = 0; i < tx_len; i++)
    800273a0:	00098f63          	beqz	s3,800273be <spi_send_data_standard+0x66>
    800273a4:	87da                	mv	a5,s6
    800273a6:	012486b3          	add	a3,s1,s2
    800273aa:	013b0733          	add	a4,s6,s3
        v_buf[cmd_len + i] = tx_buff[i];
    800273ae:	0007c603          	lbu	a2,0(a5)
    800273b2:	00c68023          	sb	a2,0(a3)
    800273b6:	0785                	addi	a5,a5,1
    800273b8:	0685                	addi	a3,a3,1
    for(i = 0; i < tx_len; i++)
    800273ba:	fee79ae3          	bne	a5,a4,800273ae <spi_send_data_standard+0x56>

    spi_send_data_normal(spi_num, chip_select, v_buf, cmd_len + tx_len);
    800273be:	013906b3          	add	a3,s2,s3
    800273c2:	8626                	mv	a2,s1
    800273c4:	85d6                	mv	a1,s5
    800273c6:	8552                	mv	a0,s4
    800273c8:	00000097          	auipc	ra,0x0
    800273cc:	da2080e7          	jalr	-606(ra) # 8002716a <spi_send_data_normal>
    // free((void *)v_buf);
    kfree((void *)v_buf);
    800273d0:	8526                	mv	a0,s1
    800273d2:	ffff9097          	auipc	ra,0xffff9
    800273d6:	066080e7          	jalr	102(ra) # 80020438 <kfree>
}
    800273da:	60a6                	ld	ra,72(sp)
    800273dc:	6406                	ld	s0,64(sp)
    800273de:	74e2                	ld	s1,56(sp)
    800273e0:	7942                	ld	s2,48(sp)
    800273e2:	79a2                	ld	s3,40(sp)
    800273e4:	7a02                	ld	s4,32(sp)
    800273e6:	6ae2                	ld	s5,24(sp)
    800273e8:	6b42                	ld	s6,16(sp)
    800273ea:	6ba2                	ld	s7,8(sp)
    800273ec:	6161                	addi	sp,sp,80
    800273ee:	8082                	ret

00000000800273f0 <spi_receive_data_standard>:

void spi_receive_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                               uint64 cmd_len, uint8 *rx_buff, uint64 rx_len)
{
    800273f0:	7139                	addi	sp,sp,-64
    800273f2:	fc06                	sd	ra,56(sp)
    800273f4:	f822                	sd	s0,48(sp)
    800273f6:	f426                	sd	s1,40(sp)
    800273f8:	f04a                	sd	s2,32(sp)
    800273fa:	ec4e                	sd	s3,24(sp)
    800273fc:	e852                	sd	s4,16(sp)
    800273fe:	e456                	sd	s5,8(sp)
    80027400:	e05a                	sd	s6,0(sp)
    80027402:	0080                	addi	s0,sp,64
    80027404:	89aa                	mv	s3,a0
    80027406:	8aae                	mv	s5,a1
    80027408:	8932                	mv	s2,a2
    8002740a:	8a36                	mv	s4,a3
    8002740c:	84ba                	mv	s1,a4
    8002740e:	8b3e                	mv	s6,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    uint64 index, fifo_len;
    if(cmd_len == 0)
    80027410:	eab5                	bnez	a3,80027484 <spi_receive_data_standard+0x94>
        spi_set_tmod(spi_num, SPI_TMOD_RECV);
    80027412:	4589                	li	a1,2
    80027414:	0ff57513          	andi	a0,a0,255
    80027418:	00000097          	auipc	ra,0x0
    8002741c:	c92080e7          	jalr	-878(ra) # 800270aa <spi_set_tmod>
    else
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    volatile spi_t *spi_handle = spi[spi_num];
    80027420:	02099793          	slli	a5,s3,0x20
    80027424:	9381                	srli	a5,a5,0x20
    80027426:	00379713          	slli	a4,a5,0x3
    8002742a:	00006797          	auipc	a5,0x6
    8002742e:	82e78793          	addi	a5,a5,-2002 # 8002cc58 <spi>
    80027432:	97ba                	add	a5,a5,a4
    80027434:	6398                	ld	a4,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80027436:	0029b993          	sltiu	s3,s3,2
    8002743a:	0992                	slli	s3,s3,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    8002743c:	431c                	lw	a5,0(a4)
    8002743e:	0137d9bb          	srlw	s3,a5,s3
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80027442:	01f9f993          	andi	s3,s3,31
    if(data_bit_length < 8)
    80027446:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    80027448:	4605                	li	a2,1
    if(data_bit_length < 8)
    8002744a:	0137f663          	bgeu	a5,s3,80027456 <spi_receive_data_standard+0x66>
    else if(data_bit_length < 16)
    8002744e:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    80027450:	4611                	li	a2,4
    else if(data_bit_length < 16)
    80027452:	0537f163          	bgeu	a5,s3,80027494 <spi_receive_data_standard+0xa4>

    uint32 i = 0;
    uint64 v_cmd_len = cmd_len / frame_width;
    80027456:	02061793          	slli	a5,a2,0x20
    8002745a:	9381                	srli	a5,a5,0x20
    8002745c:	02fa58b3          	divu	a7,s4,a5
    uint32 v_rx_len = rx_len / frame_width;
    80027460:	02fb56b3          	divu	a3,s6,a5
    80027464:	2681                	sext.w	a3,a3

    spi_handle->ctrlr1 = (uint32)(v_rx_len - 1);
    80027466:	fff6859b          	addiw	a1,a3,-1
    8002746a:	c34c                	sw	a1,4(a4)
    spi_handle->ssienr = 0x01;
    8002746c:	4585                	li	a1,1
    8002746e:	c70c                	sw	a1,8(a4)

    while(v_cmd_len)
    80027470:	0cfa6163          	bltu	s4,a5,80027532 <spi_receive_data_standard+0x142>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = cmd_buff[i++];
                break;
        }
        spi_handle->ser = 1U << chip_select;
    80027474:	015595bb          	sllw	a1,a1,s5
    uint32 i = 0;
    80027478:	4301                	li	t1,0
        fifo_len = 32 - spi_handle->txflr;
    8002747a:	02000f13          	li	t5,32
        switch(frame_width)
    8002747e:	4e89                	li	t4,2
    80027480:	4e11                	li	t3,4
    80027482:	a0a1                	j	800274ca <spi_receive_data_standard+0xda>
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    80027484:	458d                	li	a1,3
    80027486:	0ff57513          	andi	a0,a0,255
    8002748a:	00000097          	auipc	ra,0x0
    8002748e:	c20080e7          	jalr	-992(ra) # 800270aa <spi_set_tmod>
    80027492:	b779                	j	80027420 <spi_receive_data_standard+0x30>
        return SPI_TRANS_SHORT;
    80027494:	4609                	li	a2,2
    80027496:	b7c1                	j	80027456 <spi_receive_data_standard+0x66>
    80027498:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    8002749c:	879a                	mv	a5,t1
    8002749e:	c10d                	beqz	a0,800274c0 <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = ((uint16 *)cmd_buff)[i++];
    800274a0:	0017881b          	addiw	a6,a5,1
    800274a4:	00080f9b          	sext.w	t6,a6
    800274a8:	1782                	slli	a5,a5,0x20
    800274aa:	9381                	srli	a5,a5,0x20
    800274ac:	0786                	slli	a5,a5,0x1
    800274ae:	97ca                	add	a5,a5,s2
    800274b0:	0007d783          	lhu	a5,0(a5)
    800274b4:	d33c                	sw	a5,96(a4)
    800274b6:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    800274b8:	fff294e3          	bne	t0,t6,800274a0 <spi_receive_data_standard+0xb0>
    800274bc:	00a3033b          	addw	t1,t1,a0
        spi_handle->ser = 1U << chip_select;
    800274c0:	cb0c                	sw	a1,16(a4)
        v_cmd_len -= fifo_len;
    800274c2:	40a888b3          	sub	a7,a7,a0
    while(v_cmd_len)
    800274c6:	06088e63          	beqz	a7,80027542 <spi_receive_data_standard+0x152>
        fifo_len = 32 - spi_handle->txflr;
    800274ca:	5308                	lw	a0,32(a4)
    800274cc:	40af053b          	subw	a0,t5,a0
    800274d0:	1502                	slli	a0,a0,0x20
    800274d2:	9101                	srli	a0,a0,0x20
        fifo_len = fifo_len < v_cmd_len ? fifo_len : v_cmd_len;
    800274d4:	00a8f363          	bgeu	a7,a0,800274da <spi_receive_data_standard+0xea>
    800274d8:	8546                	mv	a0,a7
        switch(frame_width)
    800274da:	fbd60fe3          	beq	a2,t4,80027498 <spi_receive_data_standard+0xa8>
    800274de:	03c61663          	bne	a2,t3,8002750a <spi_receive_data_standard+0x11a>
    800274e2:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    800274e6:	879a                	mv	a5,t1
    800274e8:	dd61                	beqz	a0,800274c0 <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = ((uint32 *)cmd_buff)[i++];
    800274ea:	0017881b          	addiw	a6,a5,1
    800274ee:	00080f9b          	sext.w	t6,a6
    800274f2:	1782                	slli	a5,a5,0x20
    800274f4:	9381                	srli	a5,a5,0x20
    800274f6:	078a                	slli	a5,a5,0x2
    800274f8:	97ca                	add	a5,a5,s2
    800274fa:	439c                	lw	a5,0(a5)
    800274fc:	d33c                	sw	a5,96(a4)
    800274fe:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    80027500:	fff295e3          	bne	t0,t6,800274ea <spi_receive_data_standard+0xfa>
    80027504:	00a3033b          	addw	t1,t1,a0
    80027508:	bf65                	j	800274c0 <spi_receive_data_standard+0xd0>
    8002750a:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    8002750e:	879a                	mv	a5,t1
    80027510:	d945                	beqz	a0,800274c0 <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = cmd_buff[i++];
    80027512:	0017881b          	addiw	a6,a5,1
    80027516:	00080f9b          	sext.w	t6,a6
    8002751a:	1782                	slli	a5,a5,0x20
    8002751c:	9381                	srli	a5,a5,0x20
    8002751e:	97ca                	add	a5,a5,s2
    80027520:	0007c783          	lbu	a5,0(a5)
    80027524:	d33c                	sw	a5,96(a4)
    80027526:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    80027528:	fff295e3          	bne	t0,t6,80027512 <spi_receive_data_standard+0x122>
    8002752c:	00a3033b          	addw	t1,t1,a0
    80027530:	bf41                	j	800274c0 <spi_receive_data_standard+0xd0>
    }

    if(cmd_len == 0)
    80027532:	000a1863          	bnez	s4,80027542 <spi_receive_data_standard+0x152>
    {
        spi_handle->dr[0] = 0xffffffff;
    80027536:	57fd                	li	a5,-1
    80027538:	d33c                	sw	a5,96(a4)
        spi_handle->ser = 1U << chip_select;
    8002753a:	4585                	li	a1,1
    8002753c:	015595bb          	sllw	a1,a1,s5
    80027540:	cb0c                	sw	a1,16(a4)
    }

    i = 0;
    while(v_rx_len)
    80027542:	c6c5                	beqz	a3,800275ea <spi_receive_data_standard+0x1fa>
    80027544:	4301                	li	t1,0
    {
        fifo_len = spi_handle->rxflr;
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
        switch(frame_width)
    80027546:	4e89                	li	t4,2
    80027548:	4e11                	li	t3,4
    8002754a:	a805                	j	8002757a <spi_receive_data_standard+0x18a>
    8002754c:	00650f3b          	addw	t5,a0,t1
            case SPI_TRANS_INT:
                for(index = 0; index < fifo_len; index++)
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
                break;
            case SPI_TRANS_SHORT:
                for(index = 0; index < fifo_len; index++)
    80027550:	879a                	mv	a5,t1
    80027552:	c115                	beqz	a0,80027576 <spi_receive_data_standard+0x186>
                    ((uint16 *)rx_buff)[i++] = (uint16)spi_handle->dr[0];
    80027554:	06072883          	lw	a7,96(a4)
    80027558:	0017859b          	addiw	a1,a5,1
    8002755c:	0005881b          	sext.w	a6,a1
    80027560:	1782                	slli	a5,a5,0x20
    80027562:	9381                	srli	a5,a5,0x20
    80027564:	0786                	slli	a5,a5,0x1
    80027566:	97a6                	add	a5,a5,s1
    80027568:	01179023          	sh	a7,0(a5)
    8002756c:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    8002756e:	ff0f13e3          	bne	t5,a6,80027554 <spi_receive_data_standard+0x164>
    80027572:	00a3033b          	addw	t1,t1,a0
                for(index = 0; index < fifo_len; index++)
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
                break;
        }

        v_rx_len -= fifo_len;
    80027576:	9e89                	subw	a3,a3,a0
    while(v_rx_len)
    80027578:	caad                	beqz	a3,800275ea <spi_receive_data_standard+0x1fa>
        fifo_len = spi_handle->rxflr;
    8002757a:	535c                	lw	a5,36(a4)
    8002757c:	1782                	slli	a5,a5,0x20
    8002757e:	9381                	srli	a5,a5,0x20
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
    80027580:	02069513          	slli	a0,a3,0x20
    80027584:	9101                	srli	a0,a0,0x20
    80027586:	00a7f363          	bgeu	a5,a0,8002758c <spi_receive_data_standard+0x19c>
    8002758a:	853e                	mv	a0,a5
        switch(frame_width)
    8002758c:	fdd600e3          	beq	a2,t4,8002754c <spi_receive_data_standard+0x15c>
    80027590:	03c61863          	bne	a2,t3,800275c0 <spi_receive_data_standard+0x1d0>
    80027594:	00650f3b          	addw	t5,a0,t1
                for(index = 0; index < fifo_len; index++)
    80027598:	879a                	mv	a5,t1
    8002759a:	dd71                	beqz	a0,80027576 <spi_receive_data_standard+0x186>
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
    8002759c:	0017859b          	addiw	a1,a5,1
    800275a0:	0005881b          	sext.w	a6,a1
    800275a4:	06072883          	lw	a7,96(a4)
    800275a8:	1782                	slli	a5,a5,0x20
    800275aa:	9381                	srli	a5,a5,0x20
    800275ac:	078a                	slli	a5,a5,0x2
    800275ae:	97a6                	add	a5,a5,s1
    800275b0:	0117a023          	sw	a7,0(a5)
    800275b4:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    800275b6:	ff0f13e3          	bne	t5,a6,8002759c <spi_receive_data_standard+0x1ac>
    800275ba:	00a3033b          	addw	t1,t1,a0
    800275be:	bf65                	j	80027576 <spi_receive_data_standard+0x186>
    800275c0:	00650f3b          	addw	t5,a0,t1
                for(index = 0; index < fifo_len; index++)
    800275c4:	879a                	mv	a5,t1
    800275c6:	d945                	beqz	a0,80027576 <spi_receive_data_standard+0x186>
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
    800275c8:	06072883          	lw	a7,96(a4)
    800275cc:	0017859b          	addiw	a1,a5,1
    800275d0:	0005881b          	sext.w	a6,a1
    800275d4:	1782                	slli	a5,a5,0x20
    800275d6:	9381                	srli	a5,a5,0x20
    800275d8:	97a6                	add	a5,a5,s1
    800275da:	01178023          	sb	a7,0(a5)
    800275de:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    800275e0:	ff0f14e3          	bne	t5,a6,800275c8 <spi_receive_data_standard+0x1d8>
    800275e4:	00a3033b          	addw	t1,t1,a0
    800275e8:	b779                	j	80027576 <spi_receive_data_standard+0x186>
    }

    spi_handle->ser = 0x00;
    800275ea:	00072823          	sw	zero,16(a4)
    spi_handle->ssienr = 0x00;
    800275ee:	00072423          	sw	zero,8(a4)
}
    800275f2:	70e2                	ld	ra,56(sp)
    800275f4:	7442                	ld	s0,48(sp)
    800275f6:	74a2                	ld	s1,40(sp)
    800275f8:	7902                	ld	s2,32(sp)
    800275fa:	69e2                	ld	s3,24(sp)
    800275fc:	6a42                	ld	s4,16(sp)
    800275fe:	6aa2                	ld	s5,8(sp)
    80027600:	6b02                	ld	s6,0(sp)
    80027602:	6121                	addi	sp,sp,64
    80027604:	8082                	ret

0000000080027606 <spi_receive_data_normal_dma>:

void spi_receive_data_normal_dma(dmac_channel_number_t dma_send_channel_num,
                                 dmac_channel_number_t dma_receive_channel_num,
                                 spi_device_num_t spi_num, spi_chip_select_t chip_select, const void *cmd_buff,
                                 uint64 cmd_len, void *rx_buff, uint64 rx_len)
{
    80027606:	711d                	addi	sp,sp,-96
    80027608:	ec86                	sd	ra,88(sp)
    8002760a:	e8a2                	sd	s0,80(sp)
    8002760c:	e4a6                	sd	s1,72(sp)
    8002760e:	e0ca                	sd	s2,64(sp)
    80027610:	fc4e                	sd	s3,56(sp)
    80027612:	f852                	sd	s4,48(sp)
    80027614:	f456                	sd	s5,40(sp)
    80027616:	f05a                	sd	s6,32(sp)
    80027618:	ec5e                	sd	s7,24(sp)
    8002761a:	e862                	sd	s8,16(sp)
    8002761c:	e466                	sd	s9,8(sp)
    8002761e:	1080                	addi	s0,sp,96
    80027620:	89ae                	mv	s3,a1
    80027622:	8932                	mv	s2,a2
    80027624:	8b36                	mv	s6,a3
    80027626:	8ac2                	mv	s5,a6
    80027628:	8a46                	mv	s4,a7
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    if(cmd_len == 0)
    8002762a:	e7c1                	bnez	a5,800276b2 <spi_receive_data_normal_dma+0xac>
        spi_set_tmod(spi_num, SPI_TMOD_RECV);
    8002762c:	4589                	li	a1,2
    8002762e:	0ff67513          	andi	a0,a2,255
    80027632:	00000097          	auipc	ra,0x0
    80027636:	a78080e7          	jalr	-1416(ra) # 800270aa <spi_set_tmod>
    else
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);

    volatile spi_t *spi_handle = spi[spi_num];
    8002763a:	02091793          	slli	a5,s2,0x20
    8002763e:	9381                	srli	a5,a5,0x20
    80027640:	00379713          	slli	a4,a5,0x3
    80027644:	00005797          	auipc	a5,0x5
    80027648:	61478793          	addi	a5,a5,1556 # 8002cc58 <spi>
    8002764c:	97ba                	add	a5,a5,a4
    8002764e:	6384                	ld	s1,0(a5)

    spi_handle->ctrlr1 = (uint32)(rx_len - 1);
    80027650:	fffa079b          	addiw	a5,s4,-1
    80027654:	c0dc                	sw	a5,4(s1)
    spi_handle->dmacr = 0x3;
    80027656:	478d                	li	a5,3
    80027658:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    8002765a:	4b85                	li	s7,1
    8002765c:	0174a423          	sw	s7,8(s1)
    if(cmd_len)
        sysctl_dma_select((sysctl_dma_channel_t)dma_send_channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    sysctl_dma_select((sysctl_dma_channel_t)dma_receive_channel_num, SYSCTL_DMA_SELECT_SSI0_RX_REQ + spi_num * 2);
    80027660:	0019159b          	slliw	a1,s2,0x1
    80027664:	854e                	mv	a0,s3
    80027666:	00002097          	auipc	ra,0x2
    8002766a:	be4080e7          	jalr	-1052(ra) # 8002924a <sysctl_dma_select>

    dmac_set_single_mode(dma_receive_channel_num, (void *)(&spi_handle->dr[0]), rx_buff, DMAC_ADDR_NOCHANGE, DMAC_ADDR_INCREMENT,
    8002766e:	88d2                	mv	a7,s4
    80027670:	4809                	li	a6,2
    80027672:	4781                	li	a5,0
    80027674:	4701                	li	a4,0
    80027676:	4685                	li	a3,1
    80027678:	8656                	mv	a2,s5
    8002767a:	06048593          	addi	a1,s1,96
    8002767e:	854e                	mv	a0,s3
    80027680:	00001097          	auipc	ra,0x1
    80027684:	6aa080e7          	jalr	1706(ra) # 80028d2a <dmac_set_single_mode>
            frf_offset = 21;
    80027688:	47d5                	li	a5,21
    switch(spi_num)
    8002768a:	012bf763          	bgeu	s7,s2,80027698 <spi_receive_data_normal_dma+0x92>
    8002768e:	4709                	li	a4,2
    uint8 frf_offset = 0;
    80027690:	4781                	li	a5,0
    switch(spi_num)
    80027692:	00e90363          	beq	s2,a4,80027698 <spi_receive_data_normal_dma+0x92>
            frf_offset = 22;
    80027696:	47d9                	li	a5,22
    return ((spi_adapter->ctrlr0 >> frf_offset) & 0x3);
    80027698:	4098                	lw	a4,0(s1)
    8002769a:	00f757bb          	srlw	a5,a4,a5
                         DMAC_MSIZE_1, DMAC_TRANS_WIDTH_32, rx_len);
    if(cmd_len)
        dmac_set_single_mode(dma_send_channel_num, cmd_buff, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
                             DMAC_MSIZE_4, DMAC_TRANS_WIDTH_32, cmd_len);
    if(cmd_len == 0 && spi_get_frame_format(spi_num) == SPI_FF_STANDARD)
    8002769e:	8b8d                	andi	a5,a5,3
    800276a0:	e399                	bnez	a5,800276a6 <spi_receive_data_normal_dma+0xa0>
        spi[spi_num]->dr[0] = 0xffffffff;
    800276a2:	57fd                	li	a5,-1
    800276a4:	d0bc                	sw	a5,96(s1)
    spi_handle->ser = 1U << chip_select;
    800276a6:	4785                	li	a5,1
    800276a8:	01679b3b          	sllw	s6,a5,s6
    800276ac:	0164a823          	sw	s6,16(s1)
    if(cmd_len)
    800276b0:	a04d                	j	80027752 <spi_receive_data_normal_dma+0x14c>
    800276b2:	8baa                	mv	s7,a0
    800276b4:	8cba                	mv	s9,a4
    800276b6:	8c3e                	mv	s8,a5
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    800276b8:	458d                	li	a1,3
    800276ba:	0ff67513          	andi	a0,a2,255
    800276be:	00000097          	auipc	ra,0x0
    800276c2:	9ec080e7          	jalr	-1556(ra) # 800270aa <spi_set_tmod>
    volatile spi_t *spi_handle = spi[spi_num];
    800276c6:	02091793          	slli	a5,s2,0x20
    800276ca:	9381                	srli	a5,a5,0x20
    800276cc:	00379713          	slli	a4,a5,0x3
    800276d0:	00005797          	auipc	a5,0x5
    800276d4:	58878793          	addi	a5,a5,1416 # 8002cc58 <spi>
    800276d8:	97ba                	add	a5,a5,a4
    800276da:	6384                	ld	s1,0(a5)
    spi_handle->ctrlr1 = (uint32)(rx_len - 1);
    800276dc:	fffa079b          	addiw	a5,s4,-1
    800276e0:	c0dc                	sw	a5,4(s1)
    spi_handle->dmacr = 0x3;
    800276e2:	478d                	li	a5,3
    800276e4:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    800276e6:	4785                	li	a5,1
    800276e8:	c49c                	sw	a5,8(s1)
        sysctl_dma_select((sysctl_dma_channel_t)dma_send_channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    800276ea:	0019159b          	slliw	a1,s2,0x1
    800276ee:	0005891b          	sext.w	s2,a1
    800276f2:	2585                	addiw	a1,a1,1
    800276f4:	855e                	mv	a0,s7
    800276f6:	00002097          	auipc	ra,0x2
    800276fa:	b54080e7          	jalr	-1196(ra) # 8002924a <sysctl_dma_select>
    sysctl_dma_select((sysctl_dma_channel_t)dma_receive_channel_num, SYSCTL_DMA_SELECT_SSI0_RX_REQ + spi_num * 2);
    800276fe:	85ca                	mv	a1,s2
    80027700:	854e                	mv	a0,s3
    80027702:	00002097          	auipc	ra,0x2
    80027706:	b48080e7          	jalr	-1208(ra) # 8002924a <sysctl_dma_select>
    dmac_set_single_mode(dma_receive_channel_num, (void *)(&spi_handle->dr[0]), rx_buff, DMAC_ADDR_NOCHANGE, DMAC_ADDR_INCREMENT,
    8002770a:	06048913          	addi	s2,s1,96
    8002770e:	88d2                	mv	a7,s4
    80027710:	4809                	li	a6,2
    80027712:	4781                	li	a5,0
    80027714:	4701                	li	a4,0
    80027716:	4685                	li	a3,1
    80027718:	8656                	mv	a2,s5
    8002771a:	85ca                	mv	a1,s2
    8002771c:	854e                	mv	a0,s3
    8002771e:	00001097          	auipc	ra,0x1
    80027722:	60c080e7          	jalr	1548(ra) # 80028d2a <dmac_set_single_mode>
        dmac_set_single_mode(dma_send_channel_num, cmd_buff, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    80027726:	88e2                	mv	a7,s8
    80027728:	4809                	li	a6,2
    8002772a:	4785                	li	a5,1
    8002772c:	4705                	li	a4,1
    8002772e:	4681                	li	a3,0
    80027730:	864a                	mv	a2,s2
    80027732:	85e6                	mv	a1,s9
    80027734:	855e                	mv	a0,s7
    80027736:	00001097          	auipc	ra,0x1
    8002773a:	5f4080e7          	jalr	1524(ra) # 80028d2a <dmac_set_single_mode>
    spi_handle->ser = 1U << chip_select;
    8002773e:	4785                	li	a5,1
    80027740:	01679b3b          	sllw	s6,a5,s6
    80027744:	0164a823          	sw	s6,16(s1)
        dmac_wait_done(dma_send_channel_num);
    80027748:	855e                	mv	a0,s7
    8002774a:	00001097          	auipc	ra,0x1
    8002774e:	68c080e7          	jalr	1676(ra) # 80028dd6 <dmac_wait_done>
    dmac_wait_done(dma_receive_channel_num);
    80027752:	854e                	mv	a0,s3
    80027754:	00001097          	auipc	ra,0x1
    80027758:	682080e7          	jalr	1666(ra) # 80028dd6 <dmac_wait_done>

    spi_handle->ser = 0x00;
    8002775c:	0004a823          	sw	zero,16(s1)
    spi_handle->ssienr = 0x00;
    80027760:	0004a423          	sw	zero,8(s1)
}
    80027764:	60e6                	ld	ra,88(sp)
    80027766:	6446                	ld	s0,80(sp)
    80027768:	64a6                	ld	s1,72(sp)
    8002776a:	6906                	ld	s2,64(sp)
    8002776c:	79e2                	ld	s3,56(sp)
    8002776e:	7a42                	ld	s4,48(sp)
    80027770:	7aa2                	ld	s5,40(sp)
    80027772:	7b02                	ld	s6,32(sp)
    80027774:	6be2                	ld	s7,24(sp)
    80027776:	6c42                	ld	s8,16(sp)
    80027778:	6ca2                	ld	s9,8(sp)
    8002777a:	6125                	addi	sp,sp,96
    8002777c:	8082                	ret

000000008002777e <spi_send_data_normal_dma>:

void spi_send_data_normal_dma(dmac_channel_number_t channel_num, spi_device_num_t spi_num,
                              spi_chip_select_t chip_select,
                              const void *tx_buff, uint64 tx_len, spi_transfer_width_t spi_transfer_width)
{
    8002777e:	715d                	addi	sp,sp,-80
    80027780:	e486                	sd	ra,72(sp)
    80027782:	e0a2                	sd	s0,64(sp)
    80027784:	fc26                	sd	s1,56(sp)
    80027786:	f84a                	sd	s2,48(sp)
    80027788:	f44e                	sd	s3,40(sp)
    8002778a:	f052                	sd	s4,32(sp)
    8002778c:	ec56                	sd	s5,24(sp)
    8002778e:	e85a                	sd	s6,16(sp)
    80027790:	e45e                	sd	s7,8(sp)
    80027792:	0880                	addi	s0,sp,80
    80027794:	8a2a                	mv	s4,a0
    80027796:	89ae                	mv	s3,a1
    80027798:	8b32                	mv	s6,a2
    8002779a:	8936                	mv	s2,a3
    8002779c:	8aba                	mv	s5,a4
    8002779e:	8bbe                	mv	s7,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    spi_set_tmod(spi_num, SPI_TMOD_TRANS);
    800277a0:	4585                	li	a1,1
    800277a2:	0ff9f513          	andi	a0,s3,255
    800277a6:	00000097          	auipc	ra,0x0
    800277aa:	904080e7          	jalr	-1788(ra) # 800270aa <spi_set_tmod>
    volatile spi_t *spi_handle = spi[spi_num];
    800277ae:	02099793          	slli	a5,s3,0x20
    800277b2:	9381                	srli	a5,a5,0x20
    800277b4:	00379713          	slli	a4,a5,0x3
    800277b8:	00005797          	auipc	a5,0x5
    800277bc:	4a078793          	addi	a5,a5,1184 # 8002cc58 <spi>
    800277c0:	97ba                	add	a5,a5,a4
    800277c2:	6384                	ld	s1,0(a5)
    uint32 *buf;
    int i;
    switch(spi_transfer_width)
    800277c4:	4789                	li	a5,2
    800277c6:	0afb8263          	beq	s7,a5,8002786a <spi_send_data_normal_dma+0xec>
    800277ca:	4791                	li	a5,4
    800277cc:	02fb8563          	beq	s7,a5,800277f6 <spi_send_data_normal_dma+0x78>
        case SPI_TRANS_INT:
            buf = (uint32 *)tx_buff;
            break;
        case SPI_TRANS_CHAR:
        default:
            buf = kalloc();
    800277d0:	ffff9097          	auipc	ra,0xffff9
    800277d4:	d82080e7          	jalr	-638(ra) # 80020552 <kalloc>
            for(i = 0; i < tx_len; i++)
    800277d8:	100a8563          	beqz	s5,800278e2 <spi_send_data_normal_dma+0x164>
    800277dc:	86ca                	mv	a3,s2
    800277de:	87aa                	mv	a5,a0
    800277e0:	002a9613          	slli	a2,s5,0x2
    800277e4:	962a                	add	a2,a2,a0
                buf[i] = ((uint8 *)tx_buff)[i];
    800277e6:	0006c703          	lbu	a4,0(a3)
    800277ea:	c398                	sw	a4,0(a5)
    800277ec:	0685                	addi	a3,a3,1
    800277ee:	0791                	addi	a5,a5,4
            for(i = 0; i < tx_len; i++)
    800277f0:	fec79be3          	bne	a5,a2,800277e6 <spi_send_data_normal_dma+0x68>
            buf = kalloc();
    800277f4:	892a                	mv	s2,a0
            break;
    }
    spi_handle->dmacr = 0x2; /*enable dma transmit*/
    800277f6:	4789                	li	a5,2
    800277f8:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    800277fa:	4785                	li	a5,1
    800277fc:	c49c                	sw	a5,8(s1)

    sysctl_dma_select((sysctl_dma_channel_t)channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    800277fe:	0019959b          	slliw	a1,s3,0x1
    80027802:	2585                	addiw	a1,a1,1
    80027804:	8552                	mv	a0,s4
    80027806:	00002097          	auipc	ra,0x2
    8002780a:	a44080e7          	jalr	-1468(ra) # 8002924a <sysctl_dma_select>
    dmac_set_single_mode(channel_num, buf, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    8002780e:	88d6                	mv	a7,s5
    80027810:	4809                	li	a6,2
    80027812:	4785                	li	a5,1
    80027814:	4705                	li	a4,1
    80027816:	4681                	li	a3,0
    80027818:	06048613          	addi	a2,s1,96
    8002781c:	85ca                	mv	a1,s2
    8002781e:	8552                	mv	a0,s4
    80027820:	00001097          	auipc	ra,0x1
    80027824:	50a080e7          	jalr	1290(ra) # 80028d2a <dmac_set_single_mode>
                         DMAC_MSIZE_4, DMAC_TRANS_WIDTH_32, tx_len);
    spi_handle->ser = 1U << chip_select;
    80027828:	4785                	li	a5,1
    8002782a:	01679b3b          	sllw	s6,a5,s6
    8002782e:	0164a823          	sw	s6,16(s1)
    dmac_wait_done(channel_num);
    80027832:	8552                	mv	a0,s4
    80027834:	00001097          	auipc	ra,0x1
    80027838:	5a2080e7          	jalr	1442(ra) # 80028dd6 <dmac_wait_done>
    if(spi_transfer_width != SPI_TRANS_INT)
    8002783c:	4791                	li	a5,4
    8002783e:	0afb9463          	bne	s7,a5,800278e6 <spi_send_data_normal_dma+0x168>
        kfree((void *)buf);

    while((spi_handle->sr & 0x05) != 0x04)
    80027842:	4711                	li	a4,4
    80027844:	549c                	lw	a5,40(s1)
    80027846:	8b95                	andi	a5,a5,5
    80027848:	fee79ee3          	bne	a5,a4,80027844 <spi_send_data_normal_dma+0xc6>
        ;
    spi_handle->ser = 0x00;
    8002784c:	0004a823          	sw	zero,16(s1)
    spi_handle->ssienr = 0x00;
    80027850:	0004a423          	sw	zero,8(s1)
}
    80027854:	60a6                	ld	ra,72(sp)
    80027856:	6406                	ld	s0,64(sp)
    80027858:	74e2                	ld	s1,56(sp)
    8002785a:	7942                	ld	s2,48(sp)
    8002785c:	79a2                	ld	s3,40(sp)
    8002785e:	7a02                	ld	s4,32(sp)
    80027860:	6ae2                	ld	s5,24(sp)
    80027862:	6b42                	ld	s6,16(sp)
    80027864:	6ba2                	ld	s7,8(sp)
    80027866:	6161                	addi	sp,sp,80
    80027868:	8082                	ret
            buf = kalloc();
    8002786a:	ffff9097          	auipc	ra,0xffff9
    8002786e:	ce8080e7          	jalr	-792(ra) # 80020552 <kalloc>
    80027872:	8baa                	mv	s7,a0
            for(i = 0; i < tx_len; i++)
    80027874:	000a8e63          	beqz	s5,80027890 <spi_send_data_normal_dma+0x112>
    80027878:	87ca                	mv	a5,s2
    8002787a:	872a                	mv	a4,a0
    8002787c:	001a9693          	slli	a3,s5,0x1
    80027880:	96ca                	add	a3,a3,s2
                buf[i] = ((uint16 *)tx_buff)[i];
    80027882:	0007d603          	lhu	a2,0(a5)
    80027886:	c310                	sw	a2,0(a4)
    80027888:	0789                	addi	a5,a5,2
    8002788a:	0711                	addi	a4,a4,4
            for(i = 0; i < tx_len; i++)
    8002788c:	fed79be3          	bne	a5,a3,80027882 <spi_send_data_normal_dma+0x104>
    spi_handle->dmacr = 0x2; /*enable dma transmit*/
    80027890:	4789                	li	a5,2
    80027892:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    80027894:	4785                	li	a5,1
    80027896:	c49c                	sw	a5,8(s1)
    sysctl_dma_select((sysctl_dma_channel_t)channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    80027898:	0019959b          	slliw	a1,s3,0x1
    8002789c:	2585                	addiw	a1,a1,1
    8002789e:	8552                	mv	a0,s4
    800278a0:	00002097          	auipc	ra,0x2
    800278a4:	9aa080e7          	jalr	-1622(ra) # 8002924a <sysctl_dma_select>
    dmac_set_single_mode(channel_num, buf, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    800278a8:	88d6                	mv	a7,s5
    800278aa:	4809                	li	a6,2
    800278ac:	4785                	li	a5,1
    800278ae:	4705                	li	a4,1
    800278b0:	4681                	li	a3,0
    800278b2:	06048613          	addi	a2,s1,96
    800278b6:	85de                	mv	a1,s7
    800278b8:	8552                	mv	a0,s4
    800278ba:	00001097          	auipc	ra,0x1
    800278be:	470080e7          	jalr	1136(ra) # 80028d2a <dmac_set_single_mode>
    spi_handle->ser = 1U << chip_select;
    800278c2:	4785                	li	a5,1
    800278c4:	01679b3b          	sllw	s6,a5,s6
    800278c8:	0164a823          	sw	s6,16(s1)
    dmac_wait_done(channel_num);
    800278cc:	8552                	mv	a0,s4
    800278ce:	00001097          	auipc	ra,0x1
    800278d2:	508080e7          	jalr	1288(ra) # 80028dd6 <dmac_wait_done>
        kfree((void *)buf);
    800278d6:	855e                	mv	a0,s7
    800278d8:	ffff9097          	auipc	ra,0xffff9
    800278dc:	b60080e7          	jalr	-1184(ra) # 80020438 <kfree>
    800278e0:	b78d                	j	80027842 <spi_send_data_normal_dma+0xc4>
            buf = kalloc();
    800278e2:	892a                	mv	s2,a0
    800278e4:	bf09                	j	800277f6 <spi_send_data_normal_dma+0x78>
    800278e6:	8bca                	mv	s7,s2
    800278e8:	b7fd                	j	800278d6 <spi_send_data_normal_dma+0x158>

00000000800278ea <spi_receive_data_standard_dma>:

void spi_receive_data_standard_dma(dmac_channel_number_t dma_send_channel_num,
                                   dmac_channel_number_t dma_receive_channel_num,
                                   spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                                   uint64 cmd_len, uint8 *rx_buff, uint64 rx_len)
{
    800278ea:	711d                	addi	sp,sp,-96
    800278ec:	ec86                	sd	ra,88(sp)
    800278ee:	e8a2                	sd	s0,80(sp)
    800278f0:	e4a6                	sd	s1,72(sp)
    800278f2:	e0ca                	sd	s2,64(sp)
    800278f4:	fc4e                	sd	s3,56(sp)
    800278f6:	f852                	sd	s4,48(sp)
    800278f8:	f456                	sd	s5,40(sp)
    800278fa:	f05a                	sd	s6,32(sp)
    800278fc:	ec5e                	sd	s7,24(sp)
    800278fe:	e862                	sd	s8,16(sp)
    80027900:	e466                	sd	s9,8(sp)
    80027902:	1080                	addi	s0,sp,96
    80027904:	8b2a                	mv	s6,a0
    80027906:	8bae                	mv	s7,a1
    80027908:	8a32                	mv	s4,a2
    8002790a:	8c36                	mv	s8,a3
    8002790c:	8cba                	mv	s9,a4
    8002790e:	893e                	mv	s2,a5
    80027910:	84c2                	mv	s1,a6
    80027912:	8ac6                	mv	s5,a7
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    volatile spi_t *spi_handle = spi[spi_num];
    80027914:	02061793          	slli	a5,a2,0x20
    80027918:	9381                	srli	a5,a5,0x20
    8002791a:	00379713          	slli	a4,a5,0x3
    8002791e:	00005797          	auipc	a5,0x5
    80027922:	33a78793          	addi	a5,a5,826 # 8002cc58 <spi>
    80027926:	97ba                	add	a5,a5,a4
    80027928:	639c                	ld	a5,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    8002792a:	00263713          	sltiu	a4,a2,2
    8002792e:	0712                	slli	a4,a4,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    80027930:	439c                	lw	a5,0(a5)
    80027932:	00e7d7bb          	srlw	a5,a5,a4
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80027936:	8bfd                	andi	a5,a5,31
    if(data_bit_length < 8)
    80027938:	471d                	li	a4,7
    8002793a:	08f77863          	bgeu	a4,a5,800279ca <spi_receive_data_standard_dma+0xe0>
    else if(data_bit_length < 16)
    8002793e:	473d                	li	a4,15
    80027940:	0ef77863          	bgeu	a4,a5,80027a30 <spi_receive_data_standard_dma+0x146>
    uint64 v_recv_len;
    uint64 v_cmd_len;
    switch(frame_width)
    {
        case SPI_TRANS_INT:
            write_cmd = kalloc();
    80027944:	ffff9097          	auipc	ra,0xffff9
    80027948:	c0e080e7          	jalr	-1010(ra) # 80020552 <kalloc>
    8002794c:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 4; i++)
    8002794e:	00295793          	srli	a5,s2,0x2
    80027952:	458d                	li	a1,3
    80027954:	8766                	mv	a4,s9
    80027956:	862a                	mv	a2,a0
    80027958:	4681                	li	a3,0
    8002795a:	0d25f963          	bgeu	a1,s2,80027a2c <spi_receive_data_standard_dma+0x142>
                write_cmd[i] = ((uint32 *)cmd_buff)[i];
    8002795e:	430c                	lw	a1,0(a4)
    80027960:	c20c                	sw	a1,0(a2)
            for(i = 0; i < cmd_len / 4; i++)
    80027962:	0685                	addi	a3,a3,1
    80027964:	0711                	addi	a4,a4,4
    80027966:	0611                	addi	a2,a2,4
    80027968:	fef6ebe3          	bltu	a3,a5,8002795e <spi_receive_data_standard_dma+0x74>
            read_buf = &write_cmd[i];
    8002796c:	068a                	slli	a3,a3,0x2
    8002796e:	00d98933          	add	s2,s3,a3
            v_recv_len = rx_len / 4;
    80027972:	002adc93          	srli	s9,s5,0x2
            v_recv_len = rx_len;
            v_cmd_len = cmd_len;
            break;
    }

    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    80027976:	88e6                	mv	a7,s9
    80027978:	884a                	mv	a6,s2
    8002797a:	874e                	mv	a4,s3
    8002797c:	86e2                	mv	a3,s8
    8002797e:	8652                	mv	a2,s4
    80027980:	85de                	mv	a1,s7
    80027982:	855a                	mv	a0,s6
    80027984:	00000097          	auipc	ra,0x0
    80027988:	c82080e7          	jalr	-894(ra) # 80027606 <spi_receive_data_normal_dma>

    switch(frame_width)
    {
        case SPI_TRANS_INT:
            for(i = 0; i < v_recv_len; i++)
    8002798c:	470d                	li	a4,3
    8002798e:	884a                	mv	a6,s2
    80027990:	4781                	li	a5,0
    80027992:	01577a63          	bgeu	a4,s5,800279a6 <spi_receive_data_standard_dma+0xbc>
                ((uint32 *)rx_buff)[i] = read_buf[i];
    80027996:	00082703          	lw	a4,0(a6)
    8002799a:	c098                	sw	a4,0(s1)
            for(i = 0; i < v_recv_len; i++)
    8002799c:	0785                	addi	a5,a5,1
    8002799e:	0811                	addi	a6,a6,4
    800279a0:	0491                	addi	s1,s1,4
    800279a2:	ff97eae3          	bltu	a5,s9,80027996 <spi_receive_data_standard_dma+0xac>
            for(i = 0; i < v_recv_len; i++)
                rx_buff[i] = read_buf[i];
            break;
    }

    kfree(write_cmd);
    800279a6:	854e                	mv	a0,s3
    800279a8:	ffff9097          	auipc	ra,0xffff9
    800279ac:	a90080e7          	jalr	-1392(ra) # 80020438 <kfree>
}
    800279b0:	60e6                	ld	ra,88(sp)
    800279b2:	6446                	ld	s0,80(sp)
    800279b4:	64a6                	ld	s1,72(sp)
    800279b6:	6906                	ld	s2,64(sp)
    800279b8:	79e2                	ld	s3,56(sp)
    800279ba:	7a42                	ld	s4,48(sp)
    800279bc:	7aa2                	ld	s5,40(sp)
    800279be:	7b02                	ld	s6,32(sp)
    800279c0:	6be2                	ld	s7,24(sp)
    800279c2:	6c42                	ld	s8,16(sp)
    800279c4:	6ca2                	ld	s9,8(sp)
    800279c6:	6125                	addi	sp,sp,96
    800279c8:	8082                	ret
            write_cmd = kalloc();
    800279ca:	ffff9097          	auipc	ra,0xffff9
    800279ce:	b88080e7          	jalr	-1144(ra) # 80020552 <kalloc>
    800279d2:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len; i++)
    800279d4:	04090a63          	beqz	s2,80027a28 <spi_receive_data_standard_dma+0x13e>
    800279d8:	8766                	mv	a4,s9
    800279da:	87ce                	mv	a5,s3
    800279dc:	00291613          	slli	a2,s2,0x2
    800279e0:	964e                	add	a2,a2,s3
                write_cmd[i] = cmd_buff[i];
    800279e2:	00074683          	lbu	a3,0(a4)
    800279e6:	c394                	sw	a3,0(a5)
    800279e8:	0705                	addi	a4,a4,1
    800279ea:	0791                	addi	a5,a5,4
            for(i = 0; i < cmd_len; i++)
    800279ec:	fef61be3          	bne	a2,a5,800279e2 <spi_receive_data_standard_dma+0xf8>
    800279f0:	8cca                	mv	s9,s2
            read_buf = &write_cmd[i];
    800279f2:	0c8a                	slli	s9,s9,0x2
    800279f4:	9cce                	add	s9,s9,s3
    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    800279f6:	88d6                	mv	a7,s5
    800279f8:	8866                	mv	a6,s9
    800279fa:	87ca                	mv	a5,s2
    800279fc:	874e                	mv	a4,s3
    800279fe:	86e2                	mv	a3,s8
    80027a00:	8652                	mv	a2,s4
    80027a02:	85de                	mv	a1,s7
    80027a04:	855a                	mv	a0,s6
    80027a06:	00000097          	auipc	ra,0x0
    80027a0a:	c00080e7          	jalr	-1024(ra) # 80027606 <spi_receive_data_normal_dma>
            for(i = 0; i < v_recv_len; i++)
    80027a0e:	f80a8ce3          	beqz	s5,800279a6 <spi_receive_data_standard_dma+0xbc>
    80027a12:	87e6                	mv	a5,s9
    80027a14:	0a8a                	slli	s5,s5,0x2
    80027a16:	9ae6                	add	s5,s5,s9
                rx_buff[i] = read_buf[i];
    80027a18:	4398                	lw	a4,0(a5)
    80027a1a:	00e48023          	sb	a4,0(s1)
    80027a1e:	0791                	addi	a5,a5,4
    80027a20:	0485                	addi	s1,s1,1
            for(i = 0; i < v_recv_len; i++)
    80027a22:	ff579be3          	bne	a5,s5,80027a18 <spi_receive_data_standard_dma+0x12e>
    80027a26:	b741                	j	800279a6 <spi_receive_data_standard_dma+0xbc>
            for(i = 0; i < cmd_len; i++)
    80027a28:	8cca                	mv	s9,s2
    80027a2a:	b7e1                	j	800279f2 <spi_receive_data_standard_dma+0x108>
            for(i = 0; i < cmd_len / 4; i++)
    80027a2c:	4781                	li	a5,0
    80027a2e:	bf3d                	j	8002796c <spi_receive_data_standard_dma+0x82>
            write_cmd = kalloc();
    80027a30:	ffff9097          	auipc	ra,0xffff9
    80027a34:	b22080e7          	jalr	-1246(ra) # 80020552 <kalloc>
    80027a38:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 2; i++)
    80027a3a:	00195793          	srli	a5,s2,0x1
    80027a3e:	4585                	li	a1,1
    80027a40:	8766                	mv	a4,s9
    80027a42:	862a                	mv	a2,a0
    80027a44:	4681                	li	a3,0
    80027a46:	0525f963          	bgeu	a1,s2,80027a98 <spi_receive_data_standard_dma+0x1ae>
                write_cmd[i] = ((uint16 *)cmd_buff)[i];
    80027a4a:	00075583          	lhu	a1,0(a4)
    80027a4e:	c20c                	sw	a1,0(a2)
            for(i = 0; i < cmd_len / 2; i++)
    80027a50:	0685                	addi	a3,a3,1
    80027a52:	0709                	addi	a4,a4,2
    80027a54:	0611                	addi	a2,a2,4
    80027a56:	fef6eae3          	bltu	a3,a5,80027a4a <spi_receive_data_standard_dma+0x160>
            read_buf = &write_cmd[i];
    80027a5a:	068a                	slli	a3,a3,0x2
    80027a5c:	00d98933          	add	s2,s3,a3
            v_recv_len = rx_len / 2;
    80027a60:	001adc93          	srli	s9,s5,0x1
    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    80027a64:	88e6                	mv	a7,s9
    80027a66:	884a                	mv	a6,s2
    80027a68:	874e                	mv	a4,s3
    80027a6a:	86e2                	mv	a3,s8
    80027a6c:	8652                	mv	a2,s4
    80027a6e:	85de                	mv	a1,s7
    80027a70:	855a                	mv	a0,s6
    80027a72:	00000097          	auipc	ra,0x0
    80027a76:	b94080e7          	jalr	-1132(ra) # 80027606 <spi_receive_data_normal_dma>
            for(i = 0; i < v_recv_len; i++)
    80027a7a:	4705                	li	a4,1
    80027a7c:	884a                	mv	a6,s2
    80027a7e:	4781                	li	a5,0
    80027a80:	f35773e3          	bgeu	a4,s5,800279a6 <spi_receive_data_standard_dma+0xbc>
                ((uint16 *)rx_buff)[i] = read_buf[i];
    80027a84:	00082703          	lw	a4,0(a6)
    80027a88:	00e49023          	sh	a4,0(s1)
            for(i = 0; i < v_recv_len; i++)
    80027a8c:	0785                	addi	a5,a5,1
    80027a8e:	0811                	addi	a6,a6,4
    80027a90:	0489                	addi	s1,s1,2
    80027a92:	ff97e9e3          	bltu	a5,s9,80027a84 <spi_receive_data_standard_dma+0x19a>
    80027a96:	bf01                	j	800279a6 <spi_receive_data_standard_dma+0xbc>
            for(i = 0; i < cmd_len / 2; i++)
    80027a98:	4781                	li	a5,0
    80027a9a:	b7c1                	j	80027a5a <spi_receive_data_standard_dma+0x170>

0000000080027a9c <spi_send_data_standard_dma>:

void spi_send_data_standard_dma(dmac_channel_number_t channel_num, spi_device_num_t spi_num,
                                spi_chip_select_t chip_select,
                                const uint8 *cmd_buff, uint64 cmd_len, const uint8 *tx_buff, uint64 tx_len)
{
    80027a9c:	715d                	addi	sp,sp,-80
    80027a9e:	e486                	sd	ra,72(sp)
    80027aa0:	e0a2                	sd	s0,64(sp)
    80027aa2:	fc26                	sd	s1,56(sp)
    80027aa4:	f84a                	sd	s2,48(sp)
    80027aa6:	f44e                	sd	s3,40(sp)
    80027aa8:	f052                	sd	s4,32(sp)
    80027aaa:	ec56                	sd	s5,24(sp)
    80027aac:	e85a                	sd	s6,16(sp)
    80027aae:	e45e                	sd	s7,8(sp)
    80027ab0:	e062                	sd	s8,0(sp)
    80027ab2:	0880                	addi	s0,sp,80
    80027ab4:	8b2a                	mv	s6,a0
    80027ab6:	8a2e                	mv	s4,a1
    80027ab8:	8bb2                	mv	s7,a2
    80027aba:	8c36                	mv	s8,a3
    80027abc:	893a                	mv	s2,a4
    80027abe:	84be                	mv	s1,a5
    80027ac0:	8ac2                	mv	s5,a6
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    volatile spi_t *spi_handle = spi[spi_num];
    80027ac2:	02059793          	slli	a5,a1,0x20
    80027ac6:	9381                	srli	a5,a5,0x20
    80027ac8:	00379713          	slli	a4,a5,0x3
    80027acc:	00005797          	auipc	a5,0x5
    80027ad0:	18c78793          	addi	a5,a5,396 # 8002cc58 <spi>
    80027ad4:	97ba                	add	a5,a5,a4
    80027ad6:	639c                	ld	a5,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80027ad8:	0025b713          	sltiu	a4,a1,2
    80027adc:	0712                	slli	a4,a4,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    80027ade:	439c                	lw	a5,0(a5)
    80027ae0:	00e7d7bb          	srlw	a5,a5,a4
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80027ae4:	8bfd                	andi	a5,a5,31
    if(data_bit_length < 8)
    80027ae6:	471d                	li	a4,7
    80027ae8:	08f77763          	bgeu	a4,a5,80027b76 <spi_send_data_standard_dma+0xda>
    else if(data_bit_length < 16)
    80027aec:	473d                	li	a4,15
    80027aee:	0cf77863          	bgeu	a4,a5,80027bbe <spi_send_data_standard_dma+0x122>
    uint64 v_send_len;
    int i;
    switch(frame_width)
    {
        case SPI_TRANS_INT:
            buf = kalloc();
    80027af2:	ffff9097          	auipc	ra,0xffff9
    80027af6:	a60080e7          	jalr	-1440(ra) # 80020552 <kalloc>
    80027afa:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 4; i++)
    80027afc:	00295793          	srli	a5,s2,0x2
    80027b00:	458d                	li	a1,3
    80027b02:	86e2                	mv	a3,s8
    80027b04:	862a                	mv	a2,a0
    80027b06:	4701                	li	a4,0
    80027b08:	0725f563          	bgeu	a1,s2,80027b72 <spi_send_data_standard_dma+0xd6>
                buf[i] = ((uint32 *)cmd_buff)[i];
    80027b0c:	428c                	lw	a1,0(a3)
    80027b0e:	c20c                	sw	a1,0(a2)
    80027b10:	0705                	addi	a4,a4,1
    80027b12:	0691                	addi	a3,a3,4
    80027b14:	0611                	addi	a2,a2,4
            for(i = 0; i < cmd_len / 4; i++)
    80027b16:	fef76be3          	bltu	a4,a5,80027b0c <spi_send_data_standard_dma+0x70>
            for(i = 0; i < tx_len / 4; i++)
    80027b1a:	002ad613          	srli	a2,s5,0x2
    80027b1e:	470d                	li	a4,3
    80027b20:	01577c63          	bgeu	a4,s5,80027b38 <spi_send_data_standard_dma+0x9c>
    80027b24:	078a                	slli	a5,a5,0x2
    80027b26:	97ce                	add	a5,a5,s3
    80027b28:	4701                	li	a4,0
                buf[cmd_len / 4 + i] = ((uint32 *)tx_buff)[i];
    80027b2a:	4094                	lw	a3,0(s1)
    80027b2c:	c394                	sw	a3,0(a5)
    80027b2e:	0705                	addi	a4,a4,1
    80027b30:	0491                	addi	s1,s1,4
    80027b32:	0791                	addi	a5,a5,4
            for(i = 0; i < tx_len / 4; i++)
    80027b34:	fec76be3          	bltu	a4,a2,80027b2a <spi_send_data_standard_dma+0x8e>
            v_send_len = (cmd_len + tx_len) / 4;
    80027b38:	9956                	add	s2,s2,s5
    80027b3a:	00295713          	srli	a4,s2,0x2
                buf[cmd_len + i] = tx_buff[i];
            v_send_len = cmd_len + tx_len;
            break;
    }

    spi_send_data_normal_dma(channel_num, spi_num, chip_select, buf, v_send_len, SPI_TRANS_INT);
    80027b3e:	4791                	li	a5,4
    80027b40:	86ce                	mv	a3,s3
    80027b42:	865e                	mv	a2,s7
    80027b44:	85d2                	mv	a1,s4
    80027b46:	855a                	mv	a0,s6
    80027b48:	00000097          	auipc	ra,0x0
    80027b4c:	c36080e7          	jalr	-970(ra) # 8002777e <spi_send_data_normal_dma>

    kfree((void *)buf);
    80027b50:	854e                	mv	a0,s3
    80027b52:	ffff9097          	auipc	ra,0xffff9
    80027b56:	8e6080e7          	jalr	-1818(ra) # 80020438 <kfree>
    80027b5a:	60a6                	ld	ra,72(sp)
    80027b5c:	6406                	ld	s0,64(sp)
    80027b5e:	74e2                	ld	s1,56(sp)
    80027b60:	7942                	ld	s2,48(sp)
    80027b62:	79a2                	ld	s3,40(sp)
    80027b64:	7a02                	ld	s4,32(sp)
    80027b66:	6ae2                	ld	s5,24(sp)
    80027b68:	6b42                	ld	s6,16(sp)
    80027b6a:	6ba2                	ld	s7,8(sp)
    80027b6c:	6c02                	ld	s8,0(sp)
    80027b6e:	6161                	addi	sp,sp,80
    80027b70:	8082                	ret
            for(i = 0; i < cmd_len / 4; i++)
    80027b72:	4781                	li	a5,0
    80027b74:	b75d                	j	80027b1a <spi_send_data_standard_dma+0x7e>
            buf = kalloc();
    80027b76:	ffff9097          	auipc	ra,0xffff9
    80027b7a:	9dc080e7          	jalr	-1572(ra) # 80020552 <kalloc>
    80027b7e:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len; i++)
    80027b80:	00090e63          	beqz	s2,80027b9c <spi_send_data_standard_dma+0x100>
    80027b84:	86e2                	mv	a3,s8
    80027b86:	87ce                	mv	a5,s3
    80027b88:	00291613          	slli	a2,s2,0x2
    80027b8c:	964e                	add	a2,a2,s3
                buf[i] = cmd_buff[i];
    80027b8e:	0006c703          	lbu	a4,0(a3)
    80027b92:	c398                	sw	a4,0(a5)
    80027b94:	0685                	addi	a3,a3,1
    80027b96:	0791                	addi	a5,a5,4
            for(i = 0; i < cmd_len; i++)
    80027b98:	fec79be3          	bne	a5,a2,80027b8e <spi_send_data_standard_dma+0xf2>
            for(i = 0; i < tx_len; i++)
    80027b9c:	000a8e63          	beqz	s5,80027bb8 <spi_send_data_standard_dma+0x11c>
    80027ba0:	87a6                	mv	a5,s1
    80027ba2:	00291713          	slli	a4,s2,0x2
    80027ba6:	974e                	add	a4,a4,s3
    80027ba8:	94d6                	add	s1,s1,s5
                buf[cmd_len + i] = tx_buff[i];
    80027baa:	0007c683          	lbu	a3,0(a5)
    80027bae:	c314                	sw	a3,0(a4)
    80027bb0:	0785                	addi	a5,a5,1
    80027bb2:	0711                	addi	a4,a4,4
            for(i = 0; i < tx_len; i++)
    80027bb4:	fe979be3          	bne	a5,s1,80027baa <spi_send_data_standard_dma+0x10e>
            v_send_len = cmd_len + tx_len;
    80027bb8:	01590733          	add	a4,s2,s5
            break;
    80027bbc:	b749                	j	80027b3e <spi_send_data_standard_dma+0xa2>
            buf = kalloc();
    80027bbe:	ffff9097          	auipc	ra,0xffff9
    80027bc2:	994080e7          	jalr	-1644(ra) # 80020552 <kalloc>
    80027bc6:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 2; i++)
    80027bc8:	00195793          	srli	a5,s2,0x1
    80027bcc:	4585                	li	a1,1
    80027bce:	86e2                	mv	a3,s8
    80027bd0:	862a                	mv	a2,a0
    80027bd2:	4701                	li	a4,0
    80027bd4:	0325fe63          	bgeu	a1,s2,80027c10 <spi_send_data_standard_dma+0x174>
                buf[i] = ((uint16 *)cmd_buff)[i];
    80027bd8:	0006d583          	lhu	a1,0(a3)
    80027bdc:	c20c                	sw	a1,0(a2)
    80027bde:	0705                	addi	a4,a4,1
    80027be0:	0689                	addi	a3,a3,2
    80027be2:	0611                	addi	a2,a2,4
            for(i = 0; i < cmd_len / 2; i++)
    80027be4:	fef76ae3          	bltu	a4,a5,80027bd8 <spi_send_data_standard_dma+0x13c>
            for(i = 0; i < tx_len / 2; i++)
    80027be8:	001ad613          	srli	a2,s5,0x1
    80027bec:	4705                	li	a4,1
    80027bee:	01577d63          	bgeu	a4,s5,80027c08 <spi_send_data_standard_dma+0x16c>
    80027bf2:	078a                	slli	a5,a5,0x2
    80027bf4:	97ce                	add	a5,a5,s3
    80027bf6:	4701                	li	a4,0
                buf[cmd_len / 2 + i] = ((uint16 *)tx_buff)[i];
    80027bf8:	0004d683          	lhu	a3,0(s1)
    80027bfc:	c394                	sw	a3,0(a5)
    80027bfe:	0705                	addi	a4,a4,1
    80027c00:	0489                	addi	s1,s1,2
    80027c02:	0791                	addi	a5,a5,4
            for(i = 0; i < tx_len / 2; i++)
    80027c04:	fec76ae3          	bltu	a4,a2,80027bf8 <spi_send_data_standard_dma+0x15c>
            v_send_len = (cmd_len + tx_len) / 2;
    80027c08:	9956                	add	s2,s2,s5
    80027c0a:	00195713          	srli	a4,s2,0x1
            break;
    80027c0e:	bf05                	j	80027b3e <spi_send_data_standard_dma+0xa2>
            for(i = 0; i < cmd_len / 2; i++)
    80027c10:	4781                	li	a5,0
    80027c12:	bfd9                	j	80027be8 <spi_send_data_standard_dma+0x14c>

0000000080027c14 <gpiohs_set_drive_mode>:
// } gpiohs_pin_instance_t;

// static gpiohs_pin_instance_t pin_instance[32];

void gpiohs_set_drive_mode(uint8 pin, gpio_drive_mode_t mode)
{
    80027c14:	1101                	addi	sp,sp,-32
    80027c16:	ec06                	sd	ra,24(sp)
    80027c18:	e822                	sd	s0,16(sp)
    80027c1a:	e426                	sd	s1,8(sp)
    80027c1c:	e04a                	sd	s2,0(sp)
    80027c1e:	1000                	addi	s0,sp,32
    80027c20:	892a                	mv	s2,a0
    80027c22:	84ae                	mv	s1,a1
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    int io_number = fpioa_get_io_by_function(FUNC_GPIOHS0 + pin);
    80027c24:	0561                	addi	a0,a0,24
    80027c26:	00000097          	auipc	ra,0x0
    80027c2a:	32c080e7          	jalr	812(ra) # 80027f52 <fpioa_get_io_by_function>
    // configASSERT(io_number >= 0);

    fpioa_pull_t pull = FPIOA_PULL_NONE;
    uint32 dir = 0;

    switch(mode)
    80027c2e:	4789                	li	a5,2
    80027c30:	02f48e63          	beq	s1,a5,80027c6c <gpiohs_set_drive_mode+0x58>
    80027c34:	478d                	li	a5,3
    80027c36:	00f48b63          	beq	s1,a5,80027c4c <gpiohs_set_drive_mode+0x38>
    80027c3a:	4785                	li	a5,1
    80027c3c:	02f48863          	beq	s1,a5,80027c6c <gpiohs_set_drive_mode+0x58>
        default:
            // configASSERT(!"GPIO drive mode is not supported.") 
            break;
    }

    fpioa_set_io_pull(io_number, pull);
    80027c40:	4581                	li	a1,0
    80027c42:	00000097          	auipc	ra,0x0
    80027c46:	094080e7          	jalr	148(ra) # 80027cd6 <fpioa_set_io_pull>
    volatile uint32 *reg = dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027c4a:	a035                	j	80027c76 <gpiohs_set_drive_mode+0x62>
    fpioa_set_io_pull(io_number, pull);
    80027c4c:	4585                	li	a1,1
    80027c4e:	00000097          	auipc	ra,0x0
    80027c52:	088080e7          	jalr	136(ra) # 80027cd6 <fpioa_set_io_pull>
    80027c56:	00005797          	auipc	a5,0x5
    80027c5a:	7fa78793          	addi	a5,a5,2042 # 8002d450 <get_select_pll2+0x10>
    80027c5e:	6384                	ld	s1,0(a5)
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027c60:	00005797          	auipc	a5,0x5
    80027c64:	7e878793          	addi	a5,a5,2024 # 8002d448 <get_select_pll2+0x8>
    80027c68:	6388                	ld	a0,0(a5)
    80027c6a:	a005                	j	80027c8a <gpiohs_set_drive_mode+0x76>
    fpioa_set_io_pull(io_number, pull);
    80027c6c:	85a6                	mv	a1,s1
    80027c6e:	00000097          	auipc	ra,0x0
    80027c72:	068080e7          	jalr	104(ra) # 80027cd6 <fpioa_set_io_pull>
{
    80027c76:	00005797          	auipc	a5,0x5
    80027c7a:	7d278793          	addi	a5,a5,2002 # 8002d448 <get_select_pll2+0x8>
    80027c7e:	6384                	ld	s1,0(a5)
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027c80:	00005797          	auipc	a5,0x5
    80027c84:	7d078793          	addi	a5,a5,2000 # 8002d450 <get_select_pll2+0x10>
    80027c88:	6388                	ld	a0,0(a5)
    set_gpio_bit(reg_d, pin, 0);
    80027c8a:	4601                	li	a2,0
    80027c8c:	85ca                	mv	a1,s2
    80027c8e:	00000097          	auipc	ra,0x0
    80027c92:	398080e7          	jalr	920(ra) # 80028026 <set_gpio_bit>
    set_gpio_bit(reg, pin, 1);
    80027c96:	4605                	li	a2,1
    80027c98:	85ca                	mv	a1,s2
    80027c9a:	8526                	mv	a0,s1
    80027c9c:	00000097          	auipc	ra,0x0
    80027ca0:	38a080e7          	jalr	906(ra) # 80028026 <set_gpio_bit>
}
    80027ca4:	60e2                	ld	ra,24(sp)
    80027ca6:	6442                	ld	s0,16(sp)
    80027ca8:	64a2                	ld	s1,8(sp)
    80027caa:	6902                	ld	s2,0(sp)
    80027cac:	6105                	addi	sp,sp,32
    80027cae:	8082                	ret

0000000080027cb0 <gpiohs_set_pin>:
//     // configASSERT(pin < GPIOHS_MAX_PINNO);
//     return get_gpio_bit(gpiohs->input_val.u32, pin);
// }

void gpiohs_set_pin(uint8 pin, gpio_pin_value_t value)
{
    80027cb0:	1141                	addi	sp,sp,-16
    80027cb2:	e406                	sd	ra,8(sp)
    80027cb4:	e022                	sd	s0,0(sp)
    80027cb6:	0800                	addi	s0,sp,16
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    set_gpio_bit(gpiohs->output_val.u32, pin, value);
    80027cb8:	862e                	mv	a2,a1
    80027cba:	85aa                	mv	a1,a0
    80027cbc:	00005797          	auipc	a5,0x5
    80027cc0:	79c78793          	addi	a5,a5,1948 # 8002d458 <get_select_pll2+0x18>
    80027cc4:	6388                	ld	a0,0(a5)
    80027cc6:	00000097          	auipc	ra,0x0
    80027cca:	360080e7          	jalr	864(ra) # 80028026 <set_gpio_bit>
}
    80027cce:	60a2                	ld	ra,8(sp)
    80027cd0:	6402                	ld	s0,0(sp)
    80027cd2:	0141                	addi	sp,sp,16
    80027cd4:	8082                	ret

0000000080027cd6 <fpioa_set_io_pull>:
//     fpioa->io[number] = *cfg;
//     return 0;
// }

int fpioa_set_io_pull(int number, fpioa_pull_t pull)
{
    80027cd6:	1141                	addi	sp,sp,-16
    80027cd8:	e422                	sd	s0,8(sp)
    80027cda:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || pull >= FPIOA_PULL_MAX)
    80027cdc:	02f00793          	li	a5,47
    80027ce0:	06a7ef63          	bltu	a5,a0,80027d5e <fpioa_set_io_pull+0x88>
    80027ce4:	862a                	mv	a2,a0
    80027ce6:	4789                	li	a5,2
    80027ce8:	06b7ed63          	bltu	a5,a1,80027d62 <fpioa_set_io_pull+0x8c>
        return -1;

    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80027cec:	003f5737          	lui	a4,0x3f5
    80027cf0:	00251793          	slli	a5,a0,0x2
    80027cf4:	02b70713          	addi	a4,a4,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027cf8:	0742                	slli	a4,a4,0x10
    80027cfa:	97ba                	add	a5,a5,a4
    80027cfc:	439c                	lw	a5,0(a5)
    80027cfe:	0107d69b          	srliw	a3,a5,0x10
    80027d02:	8a85                	andi	a3,a3,1
    80027d04:	0117d71b          	srliw	a4,a5,0x11
    80027d08:	8b05                	andi	a4,a4,1

    switch(pull)
    80027d0a:	4505                	li	a0,1
    80027d0c:	04a58063          	beq	a1,a0,80027d4c <fpioa_set_io_pull+0x76>
    80027d10:	c1a9                	beqz	a1,80027d52 <fpioa_set_io_pull+0x7c>
    80027d12:	4509                	li	a0,2
    80027d14:	04a58263          	beq	a1,a0,80027d58 <fpioa_set_io_pull+0x82>
            break;
        default:
            break;
    }
    /* Atomic write register */
    fpioa->io[number] = cfg;
    80027d18:	8a85                	andi	a3,a3,1
    80027d1a:	0106969b          	slliw	a3,a3,0x10
    80027d1e:	75c1                	lui	a1,0xffff0
    80027d20:	15fd                	addi	a1,a1,-1
    80027d22:	8fed                	and	a5,a5,a1
    80027d24:	8fd5                	or	a5,a5,a3
    80027d26:	8b05                	andi	a4,a4,1
    80027d28:	0117171b          	slliw	a4,a4,0x11
    80027d2c:	7681                	lui	a3,0xfffe0
    80027d2e:	16fd                	addi	a3,a3,-1
    80027d30:	8ff5                	and	a5,a5,a3
    80027d32:	8fd9                	or	a5,a5,a4
    80027d34:	003f5537          	lui	a0,0x3f5
    80027d38:	060a                	slli	a2,a2,0x2
    80027d3a:	02b50513          	addi	a0,a0,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027d3e:	0542                	slli	a0,a0,0x10
    80027d40:	9532                	add	a0,a0,a2
    80027d42:	c11c                	sw	a5,0(a0)
    return 0;
    80027d44:	4501                	li	a0,0
}
    80027d46:	6422                	ld	s0,8(sp)
    80027d48:	0141                	addi	sp,sp,16
    80027d4a:	8082                	ret
            cfg.pd = 1;
    80027d4c:	4705                	li	a4,1
            cfg.pu = 0;
    80027d4e:	4681                	li	a3,0
    80027d50:	b7e1                	j	80027d18 <fpioa_set_io_pull+0x42>
            cfg.pd = 0;
    80027d52:	4701                	li	a4,0
            cfg.pu = 0;
    80027d54:	4681                	li	a3,0
    80027d56:	b7c9                	j	80027d18 <fpioa_set_io_pull+0x42>
            cfg.pd = 0;
    80027d58:	4701                	li	a4,0
            cfg.pu = 1;
    80027d5a:	4685                	li	a3,1
    80027d5c:	bf75                	j	80027d18 <fpioa_set_io_pull+0x42>
        return -1;
    80027d5e:	557d                	li	a0,-1
    80027d60:	b7dd                	j	80027d46 <fpioa_set_io_pull+0x70>
    80027d62:	557d                	li	a0,-1
    80027d64:	b7cd                	j	80027d46 <fpioa_set_io_pull+0x70>

0000000080027d66 <fpioa_set_function_raw>:

//     return fpioa->io[number].ds;
// }

int fpioa_set_function_raw(int number, fpioa_function_t function)
{
    80027d66:	1141                	addi	sp,sp,-16
    80027d68:	e422                	sd	s0,8(sp)
    80027d6a:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027d6c:	02f00793          	li	a5,47
    80027d70:	12a7ec63          	bltu	a5,a0,80027ea8 <fpioa_set_function_raw+0x142>
    80027d74:	882a                	mv	a6,a0
    80027d76:	0ff00793          	li	a5,255
    80027d7a:	12b7e963          	bltu	a5,a1,80027eac <fpioa_set_function_raw+0x146>
        return -1;
    /* Atomic write register */
    fpioa->io[number] = (const fpioa_io_config_t){
        .ch_sel = function_config[function].ch_sel,
    80027d7e:	1582                	slli	a1,a1,0x20
    80027d80:	9181                	srli	a1,a1,0x20
    80027d82:	058a                	slli	a1,a1,0x2
    80027d84:	00005397          	auipc	t2,0x5
    80027d88:	ef438393          	addi	t2,t2,-268 # 8002cc78 <function_config>
    80027d8c:	93ae                	add	t2,t2,a1
        .ds = function_config[function].ds,
    80027d8e:	0003a583          	lw	a1,0(t2)
    80027d92:	0085d61b          	srliw	a2,a1,0x8
        .oe_en = function_config[function].oe_en,
    80027d96:	00c5d69b          	srliw	a3,a1,0xc
        .oe_inv = function_config[function].oe_inv,
    80027d9a:	00d5df9b          	srliw	t6,a1,0xd
        .do_sel = function_config[function].do_sel,
    80027d9e:	00e5df1b          	srliw	t5,a1,0xe
        .do_inv = function_config[function].do_inv,
    80027da2:	00f5d71b          	srliw	a4,a1,0xf
        .pu = function_config[function].pu,
    80027da6:	0105de9b          	srliw	t4,a1,0x10
        .pd = function_config[function].pd,
    80027daa:	0115de1b          	srliw	t3,a1,0x11
        .sl = function_config[function].sl,
    80027dae:	0135d79b          	srliw	a5,a1,0x13
        .ie_en = function_config[function].ie_en,
    80027db2:	0145d31b          	srliw	t1,a1,0x14
        .ie_inv = function_config[function].ie_inv,
    80027db6:	0155d89b          	srliw	a7,a1,0x15
        .di_inv = function_config[function].di_inv,
    80027dba:	0165d51b          	srliw	a0,a1,0x16
        .st = function_config[function].st,
    80027dbe:	0175d59b          	srliw	a1,a1,0x17
    fpioa->io[number] = (const fpioa_io_config_t){
    80027dc2:	8a3d                	andi	a2,a2,15
    80027dc4:	0086129b          	slliw	t0,a2,0x8
    80027dc8:	0003c603          	lbu	a2,0(t2)
    80027dcc:	00566633          	or	a2,a2,t0
    80027dd0:	8a85                	andi	a3,a3,1
    80027dd2:	00c6969b          	slliw	a3,a3,0xc
    80027dd6:	72fd                	lui	t0,0xfffff
    80027dd8:	12fd                	addi	t0,t0,-1
    80027dda:	00567633          	and	a2,a2,t0
    80027dde:	8e55                	or	a2,a2,a3
    80027de0:	001fff93          	andi	t6,t6,1
    80027de4:	00df9f9b          	slliw	t6,t6,0xd
    80027de8:	76f9                	lui	a3,0xffffe
    80027dea:	16fd                	addi	a3,a3,-1
    80027dec:	8ef1                	and	a3,a3,a2
    80027dee:	01f6e633          	or	a2,a3,t6
    80027df2:	001f7693          	andi	a3,t5,1
    80027df6:	00e69f1b          	slliw	t5,a3,0xe
    80027dfa:	76f1                	lui	a3,0xffffc
    80027dfc:	16fd                	addi	a3,a3,-1
    80027dfe:	8ef1                	and	a3,a3,a2
    80027e00:	01e6e6b3          	or	a3,a3,t5
    80027e04:	8b05                	andi	a4,a4,1
    80027e06:	00f7171b          	slliw	a4,a4,0xf
    80027e0a:	7661                	lui	a2,0xffff8
    80027e0c:	167d                	addi	a2,a2,-1
    80027e0e:	8ef1                	and	a3,a3,a2
    80027e10:	8ed9                	or	a3,a3,a4
    80027e12:	001ef613          	andi	a2,t4,1
    80027e16:	0106161b          	slliw	a2,a2,0x10
    80027e1a:	7741                	lui	a4,0xffff0
    80027e1c:	177d                	addi	a4,a4,-1
    80027e1e:	8f75                	and	a4,a4,a3
    80027e20:	00c766b3          	or	a3,a4,a2
    80027e24:	001e7713          	andi	a4,t3,1
    80027e28:	0117161b          	slliw	a2,a4,0x11
    80027e2c:	7701                	lui	a4,0xfffe0
    80027e2e:	177d                	addi	a4,a4,-1
    80027e30:	8f75                	and	a4,a4,a3
    80027e32:	8f51                	or	a4,a4,a2
    80027e34:	8b85                	andi	a5,a5,1
    80027e36:	0137979b          	slliw	a5,a5,0x13
    80027e3a:	fff806b7          	lui	a3,0xfff80
    80027e3e:	16fd                	addi	a3,a3,-1
    80027e40:	8f75                	and	a4,a4,a3
    80027e42:	8f5d                	or	a4,a4,a5
    80027e44:	00137693          	andi	a3,t1,1
    80027e48:	0146969b          	slliw	a3,a3,0x14
    80027e4c:	fff007b7          	lui	a5,0xfff00
    80027e50:	17fd                	addi	a5,a5,-1
    80027e52:	8ff9                	and	a5,a5,a4
    80027e54:	00d7e733          	or	a4,a5,a3
    80027e58:	0018f793          	andi	a5,a7,1
    80027e5c:	0157969b          	slliw	a3,a5,0x15
    80027e60:	ffe007b7          	lui	a5,0xffe00
    80027e64:	17fd                	addi	a5,a5,-1
    80027e66:	8ff9                	and	a5,a5,a4
    80027e68:	8fd5                	or	a5,a5,a3
    80027e6a:	00157713          	andi	a4,a0,1
    80027e6e:	0167171b          	slliw	a4,a4,0x16
    80027e72:	ffc006b7          	lui	a3,0xffc00
    80027e76:	16fd                	addi	a3,a3,-1
    80027e78:	8ff5                	and	a5,a5,a3
    80027e7a:	8fd9                	or	a5,a5,a4
    80027e7c:	8985                	andi	a1,a1,1
    80027e7e:	0175959b          	slliw	a1,a1,0x17
    80027e82:	ff800737          	lui	a4,0xff800
    80027e86:	177d                	addi	a4,a4,-1
    80027e88:	8ff9                	and	a5,a5,a4
    80027e8a:	8fcd                	or	a5,a5,a1
    80027e8c:	003f5737          	lui	a4,0x3f5
    80027e90:	00281693          	slli	a3,a6,0x2
    80027e94:	02b70813          	addi	a6,a4,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027e98:	0842                	slli	a6,a6,0x10
    80027e9a:	9836                	add	a6,a6,a3
    80027e9c:	00f82023          	sw	a5,0(a6)
        /* resv and pad_di do not need initialization */
    };
    return 0;
    80027ea0:	4501                	li	a0,0
}
    80027ea2:	6422                	ld	s0,8(sp)
    80027ea4:	0141                	addi	sp,sp,16
    80027ea6:	8082                	ret
        return -1;
    80027ea8:	557d                	li	a0,-1
    80027eaa:	bfe5                	j	80027ea2 <fpioa_set_function_raw+0x13c>
    80027eac:	557d                	li	a0,-1
    80027eae:	bfd5                	j	80027ea2 <fpioa_set_function_raw+0x13c>

0000000080027eb0 <fpioa_set_function>:

int fpioa_set_function(int number, fpioa_function_t function)
{
    uint8 index = 0;
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027eb0:	02f00793          	li	a5,47
    80027eb4:	08a7eb63          	bltu	a5,a0,80027f4a <fpioa_set_function+0x9a>
{
    80027eb8:	7139                	addi	sp,sp,-64
    80027eba:	fc06                	sd	ra,56(sp)
    80027ebc:	f822                	sd	s0,48(sp)
    80027ebe:	f426                	sd	s1,40(sp)
    80027ec0:	f04a                	sd	s2,32(sp)
    80027ec2:	ec4e                	sd	s3,24(sp)
    80027ec4:	e852                	sd	s4,16(sp)
    80027ec6:	e456                	sd	s5,8(sp)
    80027ec8:	0080                	addi	s0,sp,64
    80027eca:	8aaa                	mv	s5,a0
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027ecc:	0ff00793          	li	a5,255
    80027ed0:	06b7ef63          	bltu	a5,a1,80027f4e <fpioa_set_function+0x9e>
    80027ed4:	892e                	mv	s2,a1
        return -1;
    if(function == FUNC_RESV0)
    80027ed6:	07800793          	li	a5,120
    80027eda:	4481                	li	s1,0
    80027edc:	00f58a63          	beq	a1,a5,80027ef0 <fpioa_set_function+0x40>
        return 0;
    }
    /* Compare all IO */
    for(index = 0; index < FPIOA_NUM_IO; index++)
    {
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80027ee0:	003f59b7          	lui	s3,0x3f5
    80027ee4:	02b98993          	addi	s3,s3,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027ee8:	09c2                	slli	s3,s3,0x10
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027eea:	03000a13          	li	s4,48
    80027eee:	a821                	j	80027f06 <fpioa_set_function+0x56>
        fpioa_set_function_raw(number, FUNC_RESV0);
    80027ef0:	07800593          	li	a1,120
    80027ef4:	00000097          	auipc	ra,0x0
    80027ef8:	e72080e7          	jalr	-398(ra) # 80027d66 <fpioa_set_function_raw>
        return 0;
    80027efc:	4501                	li	a0,0
    80027efe:	a82d                	j	80027f38 <fpioa_set_function+0x88>
    80027f00:	2485                	addiw	s1,s1,1
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027f02:	03448463          	beq	s1,s4,80027f2a <fpioa_set_function+0x7a>
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80027f06:	0004851b          	sext.w	a0,s1
    80027f0a:	00251793          	slli	a5,a0,0x2
    80027f0e:	97ce                	add	a5,a5,s3
    80027f10:	0007c783          	lbu	a5,0(a5) # ffffffffffe00000 <kernel_end+0xffffffff7fdba000>
    80027f14:	fef916e3          	bne	s2,a5,80027f00 <fpioa_set_function+0x50>
    80027f18:	ff5504e3          	beq	a0,s5,80027f00 <fpioa_set_function+0x50>
            fpioa_set_function_raw(index, FUNC_RESV0);
    80027f1c:	07800593          	li	a1,120
    80027f20:	00000097          	auipc	ra,0x0
    80027f24:	e46080e7          	jalr	-442(ra) # 80027d66 <fpioa_set_function_raw>
    80027f28:	bfe1                	j	80027f00 <fpioa_set_function+0x50>
    }
    fpioa_set_function_raw(number, function);
    80027f2a:	85ca                	mv	a1,s2
    80027f2c:	8556                	mv	a0,s5
    80027f2e:	00000097          	auipc	ra,0x0
    80027f32:	e38080e7          	jalr	-456(ra) # 80027d66 <fpioa_set_function_raw>
    return 0;
    80027f36:	4501                	li	a0,0
}
    80027f38:	70e2                	ld	ra,56(sp)
    80027f3a:	7442                	ld	s0,48(sp)
    80027f3c:	74a2                	ld	s1,40(sp)
    80027f3e:	7902                	ld	s2,32(sp)
    80027f40:	69e2                	ld	s3,24(sp)
    80027f42:	6a42                	ld	s4,16(sp)
    80027f44:	6aa2                	ld	s5,8(sp)
    80027f46:	6121                	addi	sp,sp,64
    80027f48:	8082                	ret
        return -1;
    80027f4a:	557d                	li	a0,-1
}
    80027f4c:	8082                	ret
        return -1;
    80027f4e:	557d                	li	a0,-1
    80027f50:	b7e5                	j	80027f38 <fpioa_set_function+0x88>

0000000080027f52 <fpioa_get_io_by_function>:
//         fpioa->tie.val[function / 32] &= (~(1UL << (function % 32)));
//     return 0;
// }

int fpioa_get_io_by_function(fpioa_function_t function)
{
    80027f52:	1141                	addi	sp,sp,-16
    80027f54:	e422                	sd	s0,8(sp)
    80027f56:	0800                	addi	s0,sp,16
    int index = 0;
    for(index = 0; index < FPIOA_NUM_IO; index++)
    {
        if(fpioa->io[index].ch_sel == function)
    80027f58:	003f57b7          	lui	a5,0x3f5
    80027f5c:	02b78793          	addi	a5,a5,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027f60:	07c2                	slli	a5,a5,0x10
    80027f62:	0007c783          	lbu	a5,0(a5)
    80027f66:	02f50963          	beq	a0,a5,80027f98 <fpioa_get_io_by_function+0x46>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027f6a:	4785                	li	a5,1
        if(fpioa->io[index].ch_sel == function)
    80027f6c:	003f56b7          	lui	a3,0x3f5
    80027f70:	02b68693          	addi	a3,a3,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027f74:	06c2                	slli	a3,a3,0x10
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027f76:	03000613          	li	a2,48
        if(fpioa->io[index].ch_sel == function)
    80027f7a:	00279713          	slli	a4,a5,0x2
    80027f7e:	9736                	add	a4,a4,a3
    80027f80:	00074703          	lbu	a4,0(a4)
    80027f84:	00e50663          	beq	a0,a4,80027f90 <fpioa_get_io_by_function+0x3e>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027f88:	2785                	addiw	a5,a5,1
    80027f8a:	fec798e3          	bne	a5,a2,80027f7a <fpioa_get_io_by_function+0x28>
            return index;
    }

    return -1;
    80027f8e:	57fd                	li	a5,-1
}
    80027f90:	853e                	mv	a0,a5
    80027f92:	6422                	ld	s0,8(sp)
    80027f94:	0141                	addi	sp,sp,16
    80027f96:	8082                	ret
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027f98:	4781                	li	a5,0
    80027f9a:	bfdd                	j	80027f90 <fpioa_get_io_by_function+0x3e>

0000000080027f9c <fpioa_pin_init>:

void fpioa_pin_init() {
    80027f9c:	1141                	addi	sp,sp,-16
    80027f9e:	e406                	sd	ra,8(sp)
    80027fa0:	e022                	sd	s0,0(sp)
    80027fa2:	0800                	addi	s0,sp,16
    fpioa_set_function(27, FUNC_SPI0_SCLK);
    80027fa4:	45c5                	li	a1,17
    80027fa6:	456d                	li	a0,27
    80027fa8:	00000097          	auipc	ra,0x0
    80027fac:	f08080e7          	jalr	-248(ra) # 80027eb0 <fpioa_set_function>
    fpioa_set_function(28, FUNC_SPI0_D0);
    80027fb0:	4591                	li	a1,4
    80027fb2:	4571                	li	a0,28
    80027fb4:	00000097          	auipc	ra,0x0
    80027fb8:	efc080e7          	jalr	-260(ra) # 80027eb0 <fpioa_set_function>
    fpioa_set_function(26, FUNC_SPI0_D1);
    80027fbc:	4595                	li	a1,5
    80027fbe:	4569                	li	a0,26
    80027fc0:	00000097          	auipc	ra,0x0
    80027fc4:	ef0080e7          	jalr	-272(ra) # 80027eb0 <fpioa_set_function>
	fpioa_set_function(32, FUNC_GPIOHS7);
    80027fc8:	45fd                	li	a1,31
    80027fca:	02000513          	li	a0,32
    80027fce:	00000097          	auipc	ra,0x0
    80027fd2:	ee2080e7          	jalr	-286(ra) # 80027eb0 <fpioa_set_function>
    fpioa_set_function(29, FUNC_SPI0_SS3);
    80027fd6:	45bd                	li	a1,15
    80027fd8:	4575                	li	a0,29
    80027fda:	00000097          	auipc	ra,0x0
    80027fde:	ed6080e7          	jalr	-298(ra) # 80027eb0 <fpioa_set_function>
    #ifdef DEBUG
    printf("fpioa_pin_init\n");
    #endif
    80027fe2:	60a2                	ld	ra,8(sp)
    80027fe4:	6402                	ld	s0,0(sp)
    80027fe6:	0141                	addi	sp,sp,16
    80027fe8:	8082                	ret

0000000080027fea <set_bit>:
#include "include/types.h"
#include "include/utils.h"

void set_bit(volatile uint32 *bits, uint32 mask, uint32 value)
{
    80027fea:	1141                	addi	sp,sp,-16
    80027fec:	e422                	sd	s0,8(sp)
    80027fee:	0800                	addi	s0,sp,16
    uint32 org = (*bits) & ~mask;
    80027ff0:	411c                	lw	a5,0(a0)
    80027ff2:	2781                	sext.w	a5,a5
    *bits = org | (value & mask);
    80027ff4:	8e3d                	xor	a2,a2,a5
    80027ff6:	8df1                	and	a1,a1,a2
    80027ff8:	8fad                	xor	a5,a5,a1
    80027ffa:	c11c                	sw	a5,0(a0)
}
    80027ffc:	6422                	ld	s0,8(sp)
    80027ffe:	0141                	addi	sp,sp,16
    80028000:	8082                	ret

0000000080028002 <set_bit_offset>:

void set_bit_offset(volatile uint32 *bits, uint32 mask, uint64 offset, uint32 value)
{
    80028002:	1141                	addi	sp,sp,-16
    80028004:	e422                	sd	s0,8(sp)
    80028006:	0800                	addi	s0,sp,16
    set_bit(bits, mask << offset, value << offset);
    80028008:	2601                	sext.w	a2,a2
    uint32 org = (*bits) & ~mask;
    8002800a:	411c                	lw	a5,0(a0)
    8002800c:	2781                	sext.w	a5,a5
    set_bit(bits, mask << offset, value << offset);
    8002800e:	00c696bb          	sllw	a3,a3,a2
    *bits = org | (value & mask);
    80028012:	8ebd                	xor	a3,a3,a5
    set_bit(bits, mask << offset, value << offset);
    80028014:	00c595bb          	sllw	a1,a1,a2
    *bits = org | (value & mask);
    80028018:	8eed                	and	a3,a3,a1
    8002801a:	8fb5                	xor	a5,a5,a3
    8002801c:	2781                	sext.w	a5,a5
    8002801e:	c11c                	sw	a5,0(a0)
}
    80028020:	6422                	ld	s0,8(sp)
    80028022:	0141                	addi	sp,sp,16
    80028024:	8082                	ret

0000000080028026 <set_gpio_bit>:

void set_gpio_bit(volatile uint32 *bits, uint64 offset, uint32 value)
{
    80028026:	1141                	addi	sp,sp,-16
    80028028:	e406                	sd	ra,8(sp)
    8002802a:	e022                	sd	s0,0(sp)
    8002802c:	0800                	addi	s0,sp,16
    set_bit_offset(bits, 1, offset, value);
    8002802e:	86b2                	mv	a3,a2
    80028030:	862e                	mv	a2,a1
    80028032:	4585                	li	a1,1
    80028034:	00000097          	auipc	ra,0x0
    80028038:	fce080e7          	jalr	-50(ra) # 80028002 <set_bit_offset>
}
    8002803c:	60a2                	ld	ra,8(sp)
    8002803e:	6402                	ld	s0,0(sp)
    80028040:	0141                	addi	sp,sp,16
    80028042:	8082                	ret

0000000080028044 <get_bit>:

uint32 get_bit(volatile uint32 *bits, uint32 mask, uint64 offset)
{
    80028044:	1141                	addi	sp,sp,-16
    80028046:	e422                	sd	s0,8(sp)
    80028048:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    8002804a:	411c                	lw	a5,0(a0)
    8002804c:	2781                	sext.w	a5,a5
    8002804e:	2601                	sext.w	a2,a2
    80028050:	00c595bb          	sllw	a1,a1,a2
    80028054:	8fed                	and	a5,a5,a1
}
    80028056:	00c7d53b          	srlw	a0,a5,a2
    8002805a:	6422                	ld	s0,8(sp)
    8002805c:	0141                	addi	sp,sp,16
    8002805e:	8082                	ret

0000000080028060 <get_gpio_bit>:

uint32 get_gpio_bit(volatile uint32 *bits, uint64 offset)
{
    80028060:	1141                	addi	sp,sp,-16
    80028062:	e422                	sd	s0,8(sp)
    80028064:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    80028066:	411c                	lw	a5,0(a0)
    80028068:	2781                	sext.w	a5,a5
    8002806a:	2581                	sext.w	a1,a1
    8002806c:	4705                	li	a4,1
    8002806e:	00b7173b          	sllw	a4,a4,a1
    80028072:	8ff9                	and	a5,a5,a4
    return get_bit(bits, 1, offset);
}
    80028074:	00b7d53b          	srlw	a0,a5,a1
    80028078:	6422                	ld	s0,8(sp)
    8002807a:	0141                	addi	sp,sp,16
    8002807c:	8082                	ret

000000008002807e <sd_write_data>:
static void sd_lowlevel_init(uint8 spi_index) {
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    // spi_set_clk_rate(SPI_DEVICE_0, 200000);     /*set clk rate*/
}

static void sd_write_data(uint8 const *data_buff, uint32 length) {
    8002807e:	1101                	addi	sp,sp,-32
    80028080:	ec06                	sd	ra,24(sp)
    80028082:	e822                	sd	s0,16(sp)
    80028084:	e426                	sd	s1,8(sp)
    80028086:	e04a                	sd	s2,0(sp)
    80028088:	1000                	addi	s0,sp,32
    8002808a:	84aa                	mv	s1,a0
    8002808c:	892e                	mv	s2,a1
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    8002808e:	4701                	li	a4,0
    80028090:	46a1                	li	a3,8
    80028092:	4601                	li	a2,0
    80028094:	4581                	li	a1,0
    80028096:	4501                	li	a0,0
    80028098:	fffff097          	auipc	ra,0xfffff
    8002809c:	052080e7          	jalr	82(ra) # 800270ea <spi_init>
    spi_send_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    800280a0:	02091793          	slli	a5,s2,0x20
    800280a4:	9381                	srli	a5,a5,0x20
    800280a6:	8726                	mv	a4,s1
    800280a8:	4681                	li	a3,0
    800280aa:	4601                	li	a2,0
    800280ac:	4581                	li	a1,0
    800280ae:	4501                	li	a0,0
    800280b0:	fffff097          	auipc	ra,0xfffff
    800280b4:	2a8080e7          	jalr	680(ra) # 80027358 <spi_send_data_standard>
}
    800280b8:	60e2                	ld	ra,24(sp)
    800280ba:	6442                	ld	s0,16(sp)
    800280bc:	64a2                	ld	s1,8(sp)
    800280be:	6902                	ld	s2,0(sp)
    800280c0:	6105                	addi	sp,sp,32
    800280c2:	8082                	ret

00000000800280c4 <sd_read_data>:

static void sd_read_data(uint8 *data_buff, uint32 length) {
    800280c4:	1101                	addi	sp,sp,-32
    800280c6:	ec06                	sd	ra,24(sp)
    800280c8:	e822                	sd	s0,16(sp)
    800280ca:	e426                	sd	s1,8(sp)
    800280cc:	e04a                	sd	s2,0(sp)
    800280ce:	1000                	addi	s0,sp,32
    800280d0:	84aa                	mv	s1,a0
    800280d2:	892e                	mv	s2,a1
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    800280d4:	4701                	li	a4,0
    800280d6:	46a1                	li	a3,8
    800280d8:	4601                	li	a2,0
    800280da:	4581                	li	a1,0
    800280dc:	4501                	li	a0,0
    800280de:	fffff097          	auipc	ra,0xfffff
    800280e2:	00c080e7          	jalr	12(ra) # 800270ea <spi_init>
    spi_receive_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    800280e6:	02091793          	slli	a5,s2,0x20
    800280ea:	9381                	srli	a5,a5,0x20
    800280ec:	8726                	mv	a4,s1
    800280ee:	4681                	li	a3,0
    800280f0:	4601                	li	a2,0
    800280f2:	4581                	li	a1,0
    800280f4:	4501                	li	a0,0
    800280f6:	fffff097          	auipc	ra,0xfffff
    800280fa:	2fa080e7          	jalr	762(ra) # 800273f0 <spi_receive_data_standard>
}
    800280fe:	60e2                	ld	ra,24(sp)
    80028100:	6442                	ld	s0,16(sp)
    80028102:	64a2                	ld	s1,8(sp)
    80028104:	6902                	ld	s2,0(sp)
    80028106:	6105                	addi	sp,sp,32
    80028108:	8082                	ret

000000008002810a <sd_get_response_R1>:
#define SD_CMD13 	13 		// SEND_STATUS

/*
 * Read sdcard response in R1 type. 
 */
static uint8 sd_get_response_R1(void) {
    8002810a:	7179                	addi	sp,sp,-48
    8002810c:	f406                	sd	ra,40(sp)
    8002810e:	f022                	sd	s0,32(sp)
    80028110:	ec26                	sd	s1,24(sp)
    80028112:	e84a                	sd	s2,16(sp)
    80028114:	1800                	addi	s0,sp,48
    80028116:	0ff00493          	li	s1,255
	uint8 result;
	uint16 timeout = 0xff;

	while (timeout--) {
		sd_read_data(&result, 1);
		if (result != 0xff)
    8002811a:	0ff00913          	li	s2,255
		sd_read_data(&result, 1);
    8002811e:	4585                	li	a1,1
    80028120:	fdf40513          	addi	a0,s0,-33
    80028124:	00000097          	auipc	ra,0x0
    80028128:	fa0080e7          	jalr	-96(ra) # 800280c4 <sd_read_data>
		if (result != 0xff)
    8002812c:	fdf44503          	lbu	a0,-33(s0)
    80028130:	01251663          	bne	a0,s2,8002813c <sd_get_response_R1+0x32>
    80028134:	34fd                	addiw	s1,s1,-1
    80028136:	14c2                	slli	s1,s1,0x30
    80028138:	90c1                	srli	s1,s1,0x30
	while (timeout--) {
    8002813a:	f0f5                	bnez	s1,8002811e <sd_get_response_R1+0x14>
			return result;
	}

	// timeout!
	return 0xff;
}
    8002813c:	70a2                	ld	ra,40(sp)
    8002813e:	7402                	ld	s0,32(sp)
    80028140:	64e2                	ld	s1,24(sp)
    80028142:	6942                	ld	s2,16(sp)
    80028144:	6145                	addi	sp,sp,48
    80028146:	8082                	ret

0000000080028148 <SD_CS_HIGH>:
void SD_CS_HIGH(void) {
    80028148:	1141                	addi	sp,sp,-16
    8002814a:	e406                	sd	ra,8(sp)
    8002814c:	e022                	sd	s0,0(sp)
    8002814e:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_HIGH);
    80028150:	4585                	li	a1,1
    80028152:	451d                	li	a0,7
    80028154:	00000097          	auipc	ra,0x0
    80028158:	b5c080e7          	jalr	-1188(ra) # 80027cb0 <gpiohs_set_pin>
}
    8002815c:	60a2                	ld	ra,8(sp)
    8002815e:	6402                	ld	s0,0(sp)
    80028160:	0141                	addi	sp,sp,16
    80028162:	8082                	ret

0000000080028164 <sd_end_cmd>:
static void sd_end_cmd(void) {
    80028164:	1101                	addi	sp,sp,-32
    80028166:	ec06                	sd	ra,24(sp)
    80028168:	e822                	sd	s0,16(sp)
    8002816a:	1000                	addi	s0,sp,32
	uint8 frame[1] = {0xFF};
    8002816c:	57fd                	li	a5,-1
    8002816e:	fef40423          	sb	a5,-24(s0)
	SD_CS_HIGH();
    80028172:	00000097          	auipc	ra,0x0
    80028176:	fd6080e7          	jalr	-42(ra) # 80028148 <SD_CS_HIGH>
	sd_write_data(frame, 1);
    8002817a:	4585                	li	a1,1
    8002817c:	fe840513          	addi	a0,s0,-24
    80028180:	00000097          	auipc	ra,0x0
    80028184:	efe080e7          	jalr	-258(ra) # 8002807e <sd_write_data>
}
    80028188:	60e2                	ld	ra,24(sp)
    8002818a:	6442                	ld	s0,16(sp)
    8002818c:	6105                	addi	sp,sp,32
    8002818e:	8082                	ret

0000000080028190 <SD_CS_LOW>:
void SD_CS_LOW(void) {
    80028190:	1141                	addi	sp,sp,-16
    80028192:	e406                	sd	ra,8(sp)
    80028194:	e022                	sd	s0,0(sp)
    80028196:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_LOW);
    80028198:	4581                	li	a1,0
    8002819a:	451d                	li	a0,7
    8002819c:	00000097          	auipc	ra,0x0
    800281a0:	b14080e7          	jalr	-1260(ra) # 80027cb0 <gpiohs_set_pin>
}
    800281a4:	60a2                	ld	ra,8(sp)
    800281a6:	6402                	ld	s0,0(sp)
    800281a8:	0141                	addi	sp,sp,16
    800281aa:	8082                	ret

00000000800281ac <sd_send_cmd>:
static void sd_send_cmd(uint8 cmd, uint32 arg, uint8 crc) {
    800281ac:	1101                	addi	sp,sp,-32
    800281ae:	ec06                	sd	ra,24(sp)
    800281b0:	e822                	sd	s0,16(sp)
    800281b2:	1000                	addi	s0,sp,32
	frame[0] = (cmd | 0x40);
    800281b4:	04056513          	ori	a0,a0,64
    800281b8:	fea40423          	sb	a0,-24(s0)
	frame[1] = (uint8)(arg >> 24);
    800281bc:	0185d79b          	srliw	a5,a1,0x18
    800281c0:	fef404a3          	sb	a5,-23(s0)
	frame[2] = (uint8)(arg >> 16);
    800281c4:	0105d79b          	srliw	a5,a1,0x10
    800281c8:	fef40523          	sb	a5,-22(s0)
	frame[3] = (uint8)(arg >> 8);
    800281cc:	0085d79b          	srliw	a5,a1,0x8
    800281d0:	fef405a3          	sb	a5,-21(s0)
	frame[4] = (uint8)(arg);
    800281d4:	feb40623          	sb	a1,-20(s0)
	frame[5] = (crc);
    800281d8:	fec406a3          	sb	a2,-19(s0)
	SD_CS_LOW();
    800281dc:	00000097          	auipc	ra,0x0
    800281e0:	fb4080e7          	jalr	-76(ra) # 80028190 <SD_CS_LOW>
	sd_write_data(frame, 6);
    800281e4:	4599                	li	a1,6
    800281e6:	fe840513          	addi	a0,s0,-24
    800281ea:	00000097          	auipc	ra,0x0
    800281ee:	e94080e7          	jalr	-364(ra) # 8002807e <sd_write_data>
}
    800281f2:	60e2                	ld	ra,24(sp)
    800281f4:	6442                	ld	s0,16(sp)
    800281f6:	6105                	addi	sp,sp,32
    800281f8:	8082                	ret

00000000800281fa <SD_HIGH_SPEED_ENABLE>:
void SD_HIGH_SPEED_ENABLE(void) {
    800281fa:	1141                	addi	sp,sp,-16
    800281fc:	e422                	sd	s0,8(sp)
    800281fe:	0800                	addi	s0,sp,16
}
    80028200:	6422                	ld	s0,8(sp)
    80028202:	0141                	addi	sp,sp,16
    80028204:	8082                	ret

0000000080028206 <sdcard_init>:
	return 0;
}

static struct sleeplock sdcard_lock;

void sdcard_init(void) {
    80028206:	715d                	addi	sp,sp,-80
    80028208:	e486                	sd	ra,72(sp)
    8002820a:	e0a2                	sd	s0,64(sp)
    8002820c:	fc26                	sd	s1,56(sp)
    8002820e:	f84a                	sd	s2,48(sp)
    80028210:	f44e                	sd	s3,40(sp)
    80028212:	0880                	addi	s0,sp,80
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    80028214:	458d                	li	a1,3
    80028216:	451d                	li	a0,7
    80028218:	00000097          	auipc	ra,0x0
    8002821c:	9fc080e7          	jalr	-1540(ra) # 80027c14 <gpiohs_set_drive_mode>
	SD_CS_LOW();
    80028220:	00000097          	auipc	ra,0x0
    80028224:	f70080e7          	jalr	-144(ra) # 80028190 <SD_CS_LOW>
	for (int i = 0; i < 10; i ++) 
    80028228:	fc040793          	addi	a5,s0,-64
    8002822c:	fca40693          	addi	a3,s0,-54
		frame[i] = 0xff;
    80028230:	577d                	li	a4,-1
    80028232:	00e78023          	sb	a4,0(a5)
    80028236:	0785                	addi	a5,a5,1
	for (int i = 0; i < 10; i ++) 
    80028238:	fef69de3          	bne	a3,a5,80028232 <sdcard_init+0x2c>
	sd_write_data(frame, 10);
    8002823c:	45a9                	li	a1,10
    8002823e:	fc040513          	addi	a0,s0,-64
    80028242:	00000097          	auipc	ra,0x0
    80028246:	e3c080e7          	jalr	-452(ra) # 8002807e <sd_write_data>
    8002824a:	0fe00493          	li	s1,254
		if (0x01 == result) break;
    8002824e:	4905                	li	s2,1
		sd_send_cmd(SD_CMD0, 0, 0x95);
    80028250:	09500613          	li	a2,149
    80028254:	4581                	li	a1,0
    80028256:	4501                	li	a0,0
    80028258:	00000097          	auipc	ra,0x0
    8002825c:	f54080e7          	jalr	-172(ra) # 800281ac <sd_send_cmd>
		uint64 result = sd_get_response_R1();
    80028260:	00000097          	auipc	ra,0x0
    80028264:	eaa080e7          	jalr	-342(ra) # 8002810a <sd_get_response_R1>
    80028268:	89aa                	mv	s3,a0
		sd_end_cmd();
    8002826a:	00000097          	auipc	ra,0x0
    8002826e:	efa080e7          	jalr	-262(ra) # 80028164 <sd_end_cmd>
		if (0x01 == result) break;
    80028272:	25298a63          	beq	s3,s2,800284c6 <sdcard_init+0x2c0>
    80028276:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    80028278:	fce1                	bnez	s1,80028250 <sdcard_init+0x4a>
		printf("SD_CMD0 failed\n");
    8002827a:	00005517          	auipc	a0,0x5
    8002827e:	f4650513          	addi	a0,a0,-186 # 8002d1c0 <function_config+0x548>
    80028282:	ffff8097          	auipc	ra,0xffff8
    80028286:	f0e080e7          	jalr	-242(ra) # 80020190 <printf>
		return 0xff;
    8002828a:	ac59                	j	80028520 <sdcard_init+0x31a>
		printf("invalid CRC for CMD8\n");
    8002828c:	00005517          	auipc	a0,0x5
    80028290:	dec50513          	addi	a0,a0,-532 # 8002d078 <function_config+0x400>
    80028294:	ffff8097          	auipc	ra,0xffff8
    80028298:	efc080e7          	jalr	-260(ra) # 80020190 <printf>
		return 0xff;
    8002829c:	a451                	j	80028520 <sdcard_init+0x31a>
	else if (0x01 == result && 0x01 == (frame[2] & 0x0f) && 0xaa == frame[3]) {
    8002829e:	fbb44703          	lbu	a4,-69(s0)
    800282a2:	0aa00793          	li	a5,170
    800282a6:	26f71563          	bne	a4,a5,80028510 <sdcard_init+0x30a>
    800282aa:	0ff00493          	li	s1,255
	uint64 result=0;
    800282ae:	4901                	li	s2,0
		if (
    800282b0:	4985                	li	s3,1
    800282b2:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    800282b4:	14048163          	beqz	s1,800283f6 <sdcard_init+0x1f0>
		sd_send_cmd(SD_CMD58, 0, 0);
    800282b8:	4601                	li	a2,0
    800282ba:	4581                	li	a1,0
    800282bc:	03a00513          	li	a0,58
    800282c0:	00000097          	auipc	ra,0x0
    800282c4:	eec080e7          	jalr	-276(ra) # 800281ac <sd_send_cmd>
		result = sd_get_response_R1();
    800282c8:	00000097          	auipc	ra,0x0
    800282cc:	e42080e7          	jalr	-446(ra) # 8002810a <sd_get_response_R1>
    800282d0:	892a                	mv	s2,a0
	sd_read_data(frame, 4);
    800282d2:	4591                	li	a1,4
    800282d4:	fb840513          	addi	a0,s0,-72
    800282d8:	00000097          	auipc	ra,0x0
    800282dc:	dec080e7          	jalr	-532(ra) # 800280c4 <sd_read_data>
		sd_end_cmd();
    800282e0:	00000097          	auipc	ra,0x0
    800282e4:	e84080e7          	jalr	-380(ra) # 80028164 <sd_end_cmd>
		if (
    800282e8:	fd3915e3          	bne	s2,s3,800282b2 <sdcard_init+0xac>
			0x01 == result && // R1 response in idle status 
    800282ec:	fb944783          	lbu	a5,-71(s0)
    800282f0:	8bfd                	andi	a5,a5,31
    800282f2:	d3e1                	beqz	a5,800282b2 <sdcard_init+0xac>
			(ocr[1] & 0x1f) && (ocr[2] & 0x80) 	// voltage range valid 
    800282f4:	fba40783          	lb	a5,-70(s0)
    800282f8:	fa07dde3          	bgez	a5,800282b2 <sdcard_init+0xac>
    800282fc:	6485                	lui	s1,0x1
    800282fe:	14fd                	addi	s1,s1,-1
	uint8 result = 0xff;
    80028300:	0ff00913          	li	s2,255
		if (0x01 != result) {
    80028304:	4985                	li	s3,1
    80028306:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    80028308:	12048463          	beqz	s1,80028430 <sdcard_init+0x22a>
		sd_send_cmd(SD_CMD55, 0, 0);
    8002830c:	4601                	li	a2,0
    8002830e:	4581                	li	a1,0
    80028310:	03700513          	li	a0,55
    80028314:	00000097          	auipc	ra,0x0
    80028318:	e98080e7          	jalr	-360(ra) # 800281ac <sd_send_cmd>
		result = sd_get_response_R1();
    8002831c:	00000097          	auipc	ra,0x0
    80028320:	dee080e7          	jalr	-530(ra) # 8002810a <sd_get_response_R1>
    80028324:	892a                	mv	s2,a0
		sd_end_cmd();
    80028326:	00000097          	auipc	ra,0x0
    8002832a:	e3e080e7          	jalr	-450(ra) # 80028164 <sd_end_cmd>
		if (0x01 != result) {
    8002832e:	0f391663          	bne	s2,s3,8002841a <sdcard_init+0x214>
		sd_send_cmd(SD_ACMD41, 0x40000000, 0);
    80028332:	4601                	li	a2,0
    80028334:	400005b7          	lui	a1,0x40000
    80028338:	02900513          	li	a0,41
    8002833c:	00000097          	auipc	ra,0x0
    80028340:	e70080e7          	jalr	-400(ra) # 800281ac <sd_send_cmd>
		result = sd_get_response_R1();
    80028344:	00000097          	auipc	ra,0x0
    80028348:	dc6080e7          	jalr	-570(ra) # 8002810a <sd_get_response_R1>
    8002834c:	892a                	mv	s2,a0
		sd_end_cmd();
    8002834e:	00000097          	auipc	ra,0x0
    80028352:	e16080e7          	jalr	-490(ra) # 80028164 <sd_end_cmd>
		if (0 == result) {
    80028356:	fa0918e3          	bnez	s2,80028306 <sdcard_init+0x100>
    8002835a:	10000493          	li	s1,256
	uint8 result = 0xff;
    8002835e:	0ff00913          	li	s2,255
    80028362:	34fd                	addiw	s1,s1,-1
	while (timeout --) {
    80028364:	10048663          	beqz	s1,80028470 <sdcard_init+0x26a>
		sd_send_cmd(SD_CMD58, 0, 0);
    80028368:	4601                	li	a2,0
    8002836a:	4581                	li	a1,0
    8002836c:	03a00513          	li	a0,58
    80028370:	00000097          	auipc	ra,0x0
    80028374:	e3c080e7          	jalr	-452(ra) # 800281ac <sd_send_cmd>
		result = sd_get_response_R1();
    80028378:	00000097          	auipc	ra,0x0
    8002837c:	d92080e7          	jalr	-622(ra) # 8002810a <sd_get_response_R1>
    80028380:	892a                	mv	s2,a0
	sd_read_data(frame, 4);
    80028382:	4591                	li	a1,4
    80028384:	fb840513          	addi	a0,s0,-72
    80028388:	00000097          	auipc	ra,0x0
    8002838c:	d3c080e7          	jalr	-708(ra) # 800280c4 <sd_read_data>
		sd_end_cmd();
    80028390:	00000097          	auipc	ra,0x0
    80028394:	dd4080e7          	jalr	-556(ra) # 80028164 <sd_end_cmd>
		if (0 == result) {
    80028398:	fc0915e3          	bnez	s2,80028362 <sdcard_init+0x15c>
			if (ocr[0] & 0x40) {
    8002839c:	fb844783          	lbu	a5,-72(s0)
    800283a0:	0407f793          	andi	a5,a5,64
    800283a4:	ebcd                	bnez	a5,80028456 <sdcard_init+0x250>
				printf("SDSC detected, setting block size\n");
    800283a6:	00005517          	auipc	a0,0x5
    800283aa:	d9250513          	addi	a0,a0,-622 # 8002d138 <function_config+0x4c0>
    800283ae:	ffff8097          	auipc	ra,0xffff8
    800283b2:	de2080e7          	jalr	-542(ra) # 80020190 <printf>
    800283b6:	0fe00493          	li	s1,254
					sd_send_cmd(SD_CMD16, BSIZE, 0);
    800283ba:	4601                	li	a2,0
    800283bc:	20000593          	li	a1,512
    800283c0:	4541                	li	a0,16
    800283c2:	00000097          	auipc	ra,0x0
    800283c6:	dea080e7          	jalr	-534(ra) # 800281ac <sd_send_cmd>
					result = sd_get_response_R1();
    800283ca:	00000097          	auipc	ra,0x0
    800283ce:	d40080e7          	jalr	-704(ra) # 8002810a <sd_get_response_R1>
    800283d2:	892a                	mv	s2,a0
					sd_end_cmd();
    800283d4:	00000097          	auipc	ra,0x0
    800283d8:	d90080e7          	jalr	-624(ra) # 80028164 <sd_end_cmd>
					if (0 == result) break;
    800283dc:	0a090d63          	beqz	s2,80028496 <sdcard_init+0x290>
    800283e0:	34fd                	addiw	s1,s1,-1
				while (--timeout) {
    800283e2:	fce1                	bnez	s1,800283ba <sdcard_init+0x1b4>
					printf("check_OCR(): fail to set block size");
    800283e4:	00005517          	auipc	a0,0x5
    800283e8:	db450513          	addi	a0,a0,-588 # 8002d198 <function_config+0x520>
    800283ec:	ffff8097          	auipc	ra,0xffff8
    800283f0:	da4080e7          	jalr	-604(ra) # 80020190 <printf>
					return 0xff;
    800283f4:	a235                	j	80028520 <sdcard_init+0x31a>
	printf("read_OCR() timeout!\n");
    800283f6:	00005517          	auipc	a0,0x5
    800283fa:	cc250513          	addi	a0,a0,-830 # 8002d0b8 <function_config+0x440>
    800283fe:	ffff8097          	auipc	ra,0xffff8
    80028402:	d92080e7          	jalr	-622(ra) # 80020190 <printf>
	printf("result = %d\n", result);
    80028406:	85ca                	mv	a1,s2
    80028408:	00005517          	auipc	a0,0x5
    8002840c:	cc850513          	addi	a0,a0,-824 # 8002d0d0 <function_config+0x458>
    80028410:	ffff8097          	auipc	ra,0xffff8
    80028414:	d80080e7          	jalr	-640(ra) # 80020190 <printf>
	return 0xff;
    80028418:	a221                	j	80028520 <sdcard_init+0x31a>
			printf("SD_CMD55 fail! result = %d\n", result);
    8002841a:	0009059b          	sext.w	a1,s2
    8002841e:	00005517          	auipc	a0,0x5
    80028422:	cc250513          	addi	a0,a0,-830 # 8002d0e0 <function_config+0x468>
    80028426:	ffff8097          	auipc	ra,0xffff8
    8002842a:	d6a080e7          	jalr	-662(ra) # 80020190 <printf>
			return 0xff;
    8002842e:	a8cd                	j	80028520 <sdcard_init+0x31a>
	printf("set_SDXC_capacity() timeout!\n");
    80028430:	00005517          	auipc	a0,0x5
    80028434:	cd050513          	addi	a0,a0,-816 # 8002d100 <function_config+0x488>
    80028438:	ffff8097          	auipc	ra,0xffff8
    8002843c:	d58080e7          	jalr	-680(ra) # 80020190 <printf>
	printf("result = %d\n", result);
    80028440:	0009059b          	sext.w	a1,s2
    80028444:	00005517          	auipc	a0,0x5
    80028448:	c8c50513          	addi	a0,a0,-884 # 8002d0d0 <function_config+0x458>
    8002844c:	ffff8097          	auipc	ra,0xffff8
    80028450:	d44080e7          	jalr	-700(ra) # 80020190 <printf>
	return 0xff;
    80028454:	a0f1                	j	80028520 <sdcard_init+0x31a>
				printf("SDHC/SDXC detected\n");
    80028456:	00005517          	auipc	a0,0x5
    8002845a:	cca50513          	addi	a0,a0,-822 # 8002d120 <function_config+0x4a8>
    8002845e:	ffff8097          	auipc	ra,0xffff8
    80028462:	d32080e7          	jalr	-718(ra) # 80020190 <printf>
				is_standard_sd = 0;
    80028466:	0001e797          	auipc	a5,0x1e
    8002846a:	8807a923          	sw	zero,-1902(a5) # 80045cf8 <is_standard_sd>
    8002846e:	a80d                	j	800284a0 <sdcard_init+0x29a>
	printf("check_OCR() timeout!\n");
    80028470:	00005517          	auipc	a0,0x5
    80028474:	cf050513          	addi	a0,a0,-784 # 8002d160 <function_config+0x4e8>
    80028478:	ffff8097          	auipc	ra,0xffff8
    8002847c:	d18080e7          	jalr	-744(ra) # 80020190 <printf>
	printf("result = %d\n", result);
    80028480:	0009059b          	sext.w	a1,s2
    80028484:	00005517          	auipc	a0,0x5
    80028488:	c4c50513          	addi	a0,a0,-948 # 8002d0d0 <function_config+0x458>
    8002848c:	ffff8097          	auipc	ra,0xffff8
    80028490:	d04080e7          	jalr	-764(ra) # 80020190 <printf>
	return 0xff;
    80028494:	a071                	j	80028520 <sdcard_init+0x31a>
				is_standard_sd = 1;
    80028496:	4785                	li	a5,1
    80028498:	0001e717          	auipc	a4,0x1e
    8002849c:	86f72023          	sw	a5,-1952(a4) # 80045cf8 <is_standard_sd>
	int result = sd_init();
	initsleeplock(&sdcard_lock, "sdcard");
    800284a0:	00005597          	auipc	a1,0x5
    800284a4:	cd858593          	addi	a1,a1,-808 # 8002d178 <function_config+0x500>
    800284a8:	0001e517          	auipc	a0,0x1e
    800284ac:	82050513          	addi	a0,a0,-2016 # 80045cc8 <sdcard_lock>
    800284b0:	ffffb097          	auipc	ra,0xffffb
    800284b4:	3a8080e7          	jalr	936(ra) # 80023858 <initsleeplock>
		panic("sdcard_init failed");
	}
	#ifdef DEBUG
	printf("sdcard_init\n");
	#endif
}
    800284b8:	60a6                	ld	ra,72(sp)
    800284ba:	6406                	ld	s0,64(sp)
    800284bc:	74e2                	ld	s1,56(sp)
    800284be:	7942                	ld	s2,48(sp)
    800284c0:	79a2                	ld	s3,40(sp)
    800284c2:	6161                	addi	sp,sp,80
    800284c4:	8082                	ret
	sd_send_cmd(SD_CMD8, 0x01aa, 0x87);
    800284c6:	08700613          	li	a2,135
    800284ca:	1aa00593          	li	a1,426
    800284ce:	4521                	li	a0,8
    800284d0:	00000097          	auipc	ra,0x0
    800284d4:	cdc080e7          	jalr	-804(ra) # 800281ac <sd_send_cmd>
	result = sd_get_response_R1();
    800284d8:	00000097          	auipc	ra,0x0
    800284dc:	c32080e7          	jalr	-974(ra) # 8002810a <sd_get_response_R1>
    800284e0:	84aa                	mv	s1,a0
	sd_read_data(frame, 4);
    800284e2:	4591                	li	a1,4
    800284e4:	fb840513          	addi	a0,s0,-72
    800284e8:	00000097          	auipc	ra,0x0
    800284ec:	bdc080e7          	jalr	-1060(ra) # 800280c4 <sd_read_data>
	sd_end_cmd();
    800284f0:	00000097          	auipc	ra,0x0
    800284f4:	c74080e7          	jalr	-908(ra) # 80028164 <sd_end_cmd>
	if (0x09 == result) {
    800284f8:	47a5                	li	a5,9
    800284fa:	d8f489e3          	beq	s1,a5,8002828c <sdcard_init+0x86>
	else if (0x01 == result && 0x01 == (frame[2] & 0x0f) && 0xaa == frame[3]) {
    800284fe:	4785                	li	a5,1
    80028500:	00f49863          	bne	s1,a5,80028510 <sdcard_init+0x30a>
    80028504:	fba44783          	lbu	a5,-70(s0)
    80028508:	8bbd                	andi	a5,a5,15
    8002850a:	4705                	li	a4,1
    8002850c:	d8e789e3          	beq	a5,a4,8002829e <sdcard_init+0x98>
	printf("verify_operation_condition() fail!\n");
    80028510:	00005517          	auipc	a0,0x5
    80028514:	b8050513          	addi	a0,a0,-1152 # 8002d090 <function_config+0x418>
    80028518:	ffff8097          	auipc	ra,0xffff8
    8002851c:	c78080e7          	jalr	-904(ra) # 80020190 <printf>
	initsleeplock(&sdcard_lock, "sdcard");
    80028520:	00005597          	auipc	a1,0x5
    80028524:	c5858593          	addi	a1,a1,-936 # 8002d178 <function_config+0x500>
    80028528:	0001d517          	auipc	a0,0x1d
    8002852c:	7a050513          	addi	a0,a0,1952 # 80045cc8 <sdcard_lock>
    80028530:	ffffb097          	auipc	ra,0xffffb
    80028534:	328080e7          	jalr	808(ra) # 80023858 <initsleeplock>
		panic("sdcard_init failed");
    80028538:	00005517          	auipc	a0,0x5
    8002853c:	c4850513          	addi	a0,a0,-952 # 8002d180 <function_config+0x508>
    80028540:	ffff8097          	auipc	ra,0xffff8
    80028544:	c06080e7          	jalr	-1018(ra) # 80020146 <panic>

0000000080028548 <sdcard_read_sector>:

void sdcard_read_sector(uint8 *buf, int sectorno) {
    80028548:	7139                	addi	sp,sp,-64
    8002854a:	fc06                	sd	ra,56(sp)
    8002854c:	f822                	sd	s0,48(sp)
    8002854e:	f426                	sd	s1,40(sp)
    80028550:	f04a                	sd	s2,32(sp)
    80028552:	ec4e                	sd	s3,24(sp)
    80028554:	0080                	addi	s0,sp,64
    80028556:	89aa                	mv	s3,a0

	#ifdef DEBUG
	printf("sdcard_read_sector()\n");
	#endif

	if (is_standard_sd) {
    80028558:	0001d797          	auipc	a5,0x1d
    8002855c:	7a078793          	addi	a5,a5,1952 # 80045cf8 <is_standard_sd>
    80028560:	439c                	lw	a5,0(a5)
		address = sectorno << 9;
	}
	else {
		address = sectorno;
    80028562:	0005849b          	sext.w	s1,a1
	if (is_standard_sd) {
    80028566:	c399                	beqz	a5,8002856c <sdcard_read_sector+0x24>
		address = sectorno << 9;
    80028568:	0095949b          	slliw	s1,a1,0x9
	}

	// enter critical section!
	acquiresleep(&sdcard_lock);
    8002856c:	0001d517          	auipc	a0,0x1d
    80028570:	75c50513          	addi	a0,a0,1884 # 80045cc8 <sdcard_lock>
    80028574:	ffffb097          	auipc	ra,0xffffb
    80028578:	31e080e7          	jalr	798(ra) # 80023892 <acquiresleep>

	sd_send_cmd(SD_CMD17, address, 0);
    8002857c:	4601                	li	a2,0
    8002857e:	85a6                	mv	a1,s1
    80028580:	4545                	li	a0,17
    80028582:	00000097          	auipc	ra,0x0
    80028586:	c2a080e7          	jalr	-982(ra) # 800281ac <sd_send_cmd>
	result = sd_get_response_R1();
    8002858a:	00000097          	auipc	ra,0x0
    8002858e:	b80080e7          	jalr	-1152(ra) # 8002810a <sd_get_response_R1>
    80028592:	fca407a3          	sb	a0,-49(s0)

	if (0 != result) {
    80028596:	010004b7          	lui	s1,0x1000
    8002859a:	14f9                	addi	s1,s1,-2
	}

	int timeout = 0xffffff;
	while (--timeout) {
		sd_read_data(&result, 1);
		if (0xfe == result) break;
    8002859c:	0fe00913          	li	s2,254
	if (0 != result) {
    800285a0:	e515                	bnez	a0,800285cc <sdcard_read_sector+0x84>
		sd_read_data(&result, 1);
    800285a2:	4585                	li	a1,1
    800285a4:	fcf40513          	addi	a0,s0,-49
    800285a8:	00000097          	auipc	ra,0x0
    800285ac:	b1c080e7          	jalr	-1252(ra) # 800280c4 <sd_read_data>
		if (0xfe == result) break;
    800285b0:	fcf44783          	lbu	a5,-49(s0)
    800285b4:	03278c63          	beq	a5,s2,800285ec <sdcard_read_sector+0xa4>
    800285b8:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    800285ba:	f4e5                	bnez	s1,800285a2 <sdcard_read_sector+0x5a>
	}
	if (0 == timeout) {
		panic("sdcard: timeout waiting for reading");
    800285bc:	00005517          	auipc	a0,0x5
    800285c0:	c2c50513          	addi	a0,a0,-980 # 8002d1e8 <function_config+0x570>
    800285c4:	ffff8097          	auipc	ra,0xffff8
    800285c8:	b82080e7          	jalr	-1150(ra) # 80020146 <panic>
		releasesleep(&sdcard_lock);
    800285cc:	0001d517          	auipc	a0,0x1d
    800285d0:	6fc50513          	addi	a0,a0,1788 # 80045cc8 <sdcard_lock>
    800285d4:	ffffb097          	auipc	ra,0xffffb
    800285d8:	314080e7          	jalr	788(ra) # 800238e8 <releasesleep>
		panic("sdcard: fail to read");
    800285dc:	00005517          	auipc	a0,0x5
    800285e0:	bf450513          	addi	a0,a0,-1036 # 8002d1d0 <function_config+0x558>
    800285e4:	ffff8097          	auipc	ra,0xffff8
    800285e8:	b62080e7          	jalr	-1182(ra) # 80020146 <panic>
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    800285ec:	4701                	li	a4,0
    800285ee:	46a1                	li	a3,8
    800285f0:	4601                	li	a2,0
    800285f2:	4581                	li	a1,0
    800285f4:	4501                	li	a0,0
    800285f6:	fffff097          	auipc	ra,0xfffff
    800285fa:	af4080e7          	jalr	-1292(ra) # 800270ea <spi_init>
	spi_receive_data_standard_dma(-1, DMAC_CHANNEL0, SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    800285fe:	20000893          	li	a7,512
    80028602:	884e                	mv	a6,s3
    80028604:	4781                	li	a5,0
    80028606:	4701                	li	a4,0
    80028608:	4681                	li	a3,0
    8002860a:	4601                	li	a2,0
    8002860c:	4581                	li	a1,0
    8002860e:	557d                	li	a0,-1
    80028610:	fffff097          	auipc	ra,0xfffff
    80028614:	2da080e7          	jalr	730(ra) # 800278ea <spi_receive_data_standard_dma>
	}
	sd_read_data_dma(buf, BSIZE);
	sd_read_data(dummy_crc, 2);
    80028618:	4589                	li	a1,2
    8002861a:	fc840513          	addi	a0,s0,-56
    8002861e:	00000097          	auipc	ra,0x0
    80028622:	aa6080e7          	jalr	-1370(ra) # 800280c4 <sd_read_data>

	sd_end_cmd();
    80028626:	00000097          	auipc	ra,0x0
    8002862a:	b3e080e7          	jalr	-1218(ra) # 80028164 <sd_end_cmd>

	releasesleep(&sdcard_lock);
    8002862e:	0001d517          	auipc	a0,0x1d
    80028632:	69a50513          	addi	a0,a0,1690 # 80045cc8 <sdcard_lock>
    80028636:	ffffb097          	auipc	ra,0xffffb
    8002863a:	2b2080e7          	jalr	690(ra) # 800238e8 <releasesleep>
	// leave critical section!
}
    8002863e:	70e2                	ld	ra,56(sp)
    80028640:	7442                	ld	s0,48(sp)
    80028642:	74a2                	ld	s1,40(sp)
    80028644:	7902                	ld	s2,32(sp)
    80028646:	69e2                	ld	s3,24(sp)
    80028648:	6121                	addi	sp,sp,64
    8002864a:	8082                	ret

000000008002864c <sdcard_write_sector>:

void sdcard_write_sector(uint8 *buf, int sectorno) {
    8002864c:	7179                	addi	sp,sp,-48
    8002864e:	f406                	sd	ra,40(sp)
    80028650:	f022                	sd	s0,32(sp)
    80028652:	ec26                	sd	s1,24(sp)
    80028654:	e84a                	sd	s2,16(sp)
    80028656:	1800                	addi	s0,sp,48
    80028658:	892a                	mv	s2,a0
	uint32 address;
	static uint8 const START_BLOCK_TOKEN = 0xfe;
	uint8 dummy_crc[2] = {0xff, 0xff};
    8002865a:	57fd                	li	a5,-1
    8002865c:	fcf40c23          	sb	a5,-40(s0)
    80028660:	fcf40ca3          	sb	a5,-39(s0)

	#ifdef DEBUG
	printf("sdcard_write_sector()\n");
	#endif

	if (is_standard_sd) {
    80028664:	0001d797          	auipc	a5,0x1d
    80028668:	69478793          	addi	a5,a5,1684 # 80045cf8 <is_standard_sd>
    8002866c:	439c                	lw	a5,0(a5)
		address = sectorno << 9;
	}
	else {
		address = sectorno;
    8002866e:	0005849b          	sext.w	s1,a1
	if (is_standard_sd) {
    80028672:	c399                	beqz	a5,80028678 <sdcard_write_sector+0x2c>
		address = sectorno << 9;
    80028674:	0095949b          	slliw	s1,a1,0x9
	}

	// enter critical section!
	acquiresleep(&sdcard_lock);
    80028678:	0001d517          	auipc	a0,0x1d
    8002867c:	65050513          	addi	a0,a0,1616 # 80045cc8 <sdcard_lock>
    80028680:	ffffb097          	auipc	ra,0xffffb
    80028684:	212080e7          	jalr	530(ra) # 80023892 <acquiresleep>

	sd_send_cmd(SD_CMD24, address, 0);
    80028688:	4601                	li	a2,0
    8002868a:	85a6                	mv	a1,s1
    8002868c:	4561                	li	a0,24
    8002868e:	00000097          	auipc	ra,0x0
    80028692:	b1e080e7          	jalr	-1250(ra) # 800281ac <sd_send_cmd>
	if (0 != sd_get_response_R1()) {
    80028696:	00000097          	auipc	ra,0x0
    8002869a:	a74080e7          	jalr	-1420(ra) # 8002810a <sd_get_response_R1>
    8002869e:	e559                	bnez	a0,8002872c <sdcard_write_sector+0xe0>
		releasesleep(&sdcard_lock);
		panic("sdcard: fail to write");
	}

	// sending data to be written 
	sd_write_data(&START_BLOCK_TOKEN, 1);
    800286a0:	4585                	li	a1,1
    800286a2:	00005517          	auipc	a0,0x5
    800286a6:	d6e50513          	addi	a0,a0,-658 # 8002d410 <START_BLOCK_TOKEN.2204>
    800286aa:	00000097          	auipc	ra,0x0
    800286ae:	9d4080e7          	jalr	-1580(ra) # 8002807e <sd_write_data>
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    800286b2:	4701                	li	a4,0
    800286b4:	46a1                	li	a3,8
    800286b6:	4601                	li	a2,0
    800286b8:	4581                	li	a1,0
    800286ba:	4501                	li	a0,0
    800286bc:	fffff097          	auipc	ra,0xfffff
    800286c0:	a2e080e7          	jalr	-1490(ra) # 800270ea <spi_init>
	spi_send_data_standard_dma(DMAC_CHANNEL0, SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    800286c4:	20000813          	li	a6,512
    800286c8:	87ca                	mv	a5,s2
    800286ca:	4701                	li	a4,0
    800286cc:	4681                	li	a3,0
    800286ce:	4601                	li	a2,0
    800286d0:	4581                	li	a1,0
    800286d2:	4501                	li	a0,0
    800286d4:	fffff097          	auipc	ra,0xfffff
    800286d8:	3c8080e7          	jalr	968(ra) # 80027a9c <spi_send_data_standard_dma>
	sd_write_data_dma(buf, BSIZE);
	sd_write_data(dummy_crc, 2);
    800286dc:	4589                	li	a1,2
    800286de:	fd840513          	addi	a0,s0,-40
    800286e2:	00000097          	auipc	ra,0x0
    800286e6:	99c080e7          	jalr	-1636(ra) # 8002807e <sd_write_data>
    800286ea:	6485                	lui	s1,0x1
    800286ec:	14f9                	addi	s1,s1,-2
	// waiting for sdcard to finish programming 
	uint8 result;
	int timeout = 0xfff;
	while (--timeout) {
		sd_read_data(&result, 1);
		if (0x05 == (result & 0x1f)) {
    800286ee:	4915                	li	s2,5
		sd_read_data(&result, 1);
    800286f0:	4585                	li	a1,1
    800286f2:	fd740513          	addi	a0,s0,-41
    800286f6:	00000097          	auipc	ra,0x0
    800286fa:	9ce080e7          	jalr	-1586(ra) # 800280c4 <sd_read_data>
		if (0x05 == (result & 0x1f)) {
    800286fe:	fd744783          	lbu	a5,-41(s0)
    80028702:	8bfd                	andi	a5,a5,31
    80028704:	05278463          	beq	a5,s2,8002874c <sdcard_write_sector+0x100>
    80028708:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    8002870a:	f0fd                	bnez	s1,800286f0 <sdcard_write_sector+0xa4>
			break;
		}
	}
	if (0 == timeout) {
		releasesleep(&sdcard_lock);
    8002870c:	0001d517          	auipc	a0,0x1d
    80028710:	5bc50513          	addi	a0,a0,1468 # 80045cc8 <sdcard_lock>
    80028714:	ffffb097          	auipc	ra,0xffffb
    80028718:	1d4080e7          	jalr	468(ra) # 800238e8 <releasesleep>
		panic("sdcard: invalid response token");
    8002871c:	00005517          	auipc	a0,0x5
    80028720:	b7c50513          	addi	a0,a0,-1156 # 8002d298 <function_config+0x620>
    80028724:	ffff8097          	auipc	ra,0xffff8
    80028728:	a22080e7          	jalr	-1502(ra) # 80020146 <panic>
		releasesleep(&sdcard_lock);
    8002872c:	0001d517          	auipc	a0,0x1d
    80028730:	59c50513          	addi	a0,a0,1436 # 80045cc8 <sdcard_lock>
    80028734:	ffffb097          	auipc	ra,0xffffb
    80028738:	1b4080e7          	jalr	436(ra) # 800238e8 <releasesleep>
		panic("sdcard: fail to write");
    8002873c:	00005517          	auipc	a0,0x5
    80028740:	ad450513          	addi	a0,a0,-1324 # 8002d210 <function_config+0x598>
    80028744:	ffff8097          	auipc	ra,0xffff8
    80028748:	a02080e7          	jalr	-1534(ra) # 80020146 <panic>
    8002874c:	010004b7          	lui	s1,0x1000
    80028750:	14fd                	addi	s1,s1,-1
    80028752:	34fd                	addiw	s1,s1,-1
	}
	
	timeout = 0xffffff;
	while (--timeout) {
    80028754:	c0f1                	beqz	s1,80028818 <sdcard_write_sector+0x1cc>
		sd_read_data(&result, 1);
    80028756:	4585                	li	a1,1
    80028758:	fd740513          	addi	a0,s0,-41
    8002875c:	00000097          	auipc	ra,0x0
    80028760:	968080e7          	jalr	-1688(ra) # 800280c4 <sd_read_data>
		if (0 != result) break;
    80028764:	fd744783          	lbu	a5,-41(s0)
    80028768:	d7ed                	beqz	a5,80028752 <sdcard_write_sector+0x106>
	}
	if (0 == timeout) {
		releasesleep(&sdcard_lock);
		panic("sdcard: timeout waiting for response");
	}
	sd_end_cmd();
    8002876a:	00000097          	auipc	ra,0x0
    8002876e:	9fa080e7          	jalr	-1542(ra) # 80028164 <sd_end_cmd>

	// send SD_CMD13 to check if writing is correctly done 
	uint8 error_code = 0xff;
    80028772:	57fd                	li	a5,-1
    80028774:	fcf40b23          	sb	a5,-42(s0)
	sd_send_cmd(SD_CMD13, 0, 0);
    80028778:	4601                	li	a2,0
    8002877a:	4581                	li	a1,0
    8002877c:	4535                	li	a0,13
    8002877e:	00000097          	auipc	ra,0x0
    80028782:	a2e080e7          	jalr	-1490(ra) # 800281ac <sd_send_cmd>
	result = sd_get_response_R1();
    80028786:	00000097          	auipc	ra,0x0
    8002878a:	984080e7          	jalr	-1660(ra) # 8002810a <sd_get_response_R1>
    8002878e:	fca40ba3          	sb	a0,-41(s0)
	sd_read_data(&error_code, 1);
    80028792:	4585                	li	a1,1
    80028794:	fd640513          	addi	a0,s0,-42
    80028798:	00000097          	auipc	ra,0x0
    8002879c:	92c080e7          	jalr	-1748(ra) # 800280c4 <sd_read_data>
	sd_end_cmd();
    800287a0:	00000097          	auipc	ra,0x0
    800287a4:	9c4080e7          	jalr	-1596(ra) # 80028164 <sd_end_cmd>
	if (0 != result || 0 != error_code) {
    800287a8:	fd744783          	lbu	a5,-41(s0)
    800287ac:	fd644703          	lbu	a4,-42(s0)
    800287b0:	8fd9                	or	a5,a5,a4
    800287b2:	ef99                	bnez	a5,800287d0 <sdcard_write_sector+0x184>
		printf("result: %x\n", result);
		printf("error_code: %x\n", error_code);
		panic("sdcard: an error occurs when writing");
	}

	releasesleep(&sdcard_lock);
    800287b4:	0001d517          	auipc	a0,0x1d
    800287b8:	51450513          	addi	a0,a0,1300 # 80045cc8 <sdcard_lock>
    800287bc:	ffffb097          	auipc	ra,0xffffb
    800287c0:	12c080e7          	jalr	300(ra) # 800238e8 <releasesleep>
	// leave critical section!
}
    800287c4:	70a2                	ld	ra,40(sp)
    800287c6:	7402                	ld	s0,32(sp)
    800287c8:	64e2                	ld	s1,24(sp)
    800287ca:	6942                	ld	s2,16(sp)
    800287cc:	6145                	addi	sp,sp,48
    800287ce:	8082                	ret
		releasesleep(&sdcard_lock);
    800287d0:	0001d517          	auipc	a0,0x1d
    800287d4:	4f850513          	addi	a0,a0,1272 # 80045cc8 <sdcard_lock>
    800287d8:	ffffb097          	auipc	ra,0xffffb
    800287dc:	110080e7          	jalr	272(ra) # 800238e8 <releasesleep>
		printf("result: %x\n", result);
    800287e0:	fd744583          	lbu	a1,-41(s0)
    800287e4:	00005517          	auipc	a0,0x5
    800287e8:	a4450513          	addi	a0,a0,-1468 # 8002d228 <function_config+0x5b0>
    800287ec:	ffff8097          	auipc	ra,0xffff8
    800287f0:	9a4080e7          	jalr	-1628(ra) # 80020190 <printf>
		printf("error_code: %x\n", error_code);
    800287f4:	fd644583          	lbu	a1,-42(s0)
    800287f8:	00005517          	auipc	a0,0x5
    800287fc:	a4050513          	addi	a0,a0,-1472 # 8002d238 <function_config+0x5c0>
    80028800:	ffff8097          	auipc	ra,0xffff8
    80028804:	990080e7          	jalr	-1648(ra) # 80020190 <printf>
		panic("sdcard: an error occurs when writing");
    80028808:	00005517          	auipc	a0,0x5
    8002880c:	a4050513          	addi	a0,a0,-1472 # 8002d248 <function_config+0x5d0>
    80028810:	ffff8097          	auipc	ra,0xffff8
    80028814:	936080e7          	jalr	-1738(ra) # 80020146 <panic>
		releasesleep(&sdcard_lock);
    80028818:	0001d517          	auipc	a0,0x1d
    8002881c:	4b050513          	addi	a0,a0,1200 # 80045cc8 <sdcard_lock>
    80028820:	ffffb097          	auipc	ra,0xffffb
    80028824:	0c8080e7          	jalr	200(ra) # 800238e8 <releasesleep>
		panic("sdcard: timeout waiting for response");
    80028828:	00005517          	auipc	a0,0x5
    8002882c:	a4850513          	addi	a0,a0,-1464 # 8002d270 <function_config+0x5f8>
    80028830:	ffff8097          	auipc	ra,0xffff8
    80028834:	916080e7          	jalr	-1770(ra) # 80020146 <panic>

0000000080028838 <test_sdcard>:

// A simple test for sdcard read/write test 
void test_sdcard(void) {
    80028838:	da010113          	addi	sp,sp,-608
    8002883c:	24113c23          	sd	ra,600(sp)
    80028840:	24813823          	sd	s0,592(sp)
    80028844:	24913423          	sd	s1,584(sp)
    80028848:	25213023          	sd	s2,576(sp)
    8002884c:	23313c23          	sd	s3,568(sp)
    80028850:	23413823          	sd	s4,560(sp)
    80028854:	23513423          	sd	s5,552(sp)
    80028858:	23613023          	sd	s6,544(sp)
    8002885c:	21713c23          	sd	s7,536(sp)
    80028860:	21813823          	sd	s8,528(sp)
    80028864:	21913423          	sd	s9,520(sp)
    80028868:	21a13023          	sd	s10,512(sp)
    8002886c:	1480                	addi	s0,sp,608
	uint8 buf[BSIZE];

	for (int sec = 0; sec < 5; sec ++) {
    8002886e:	4c81                	li	s9,0
    80028870:	fa040993          	addi	s3,s0,-96
		for (int i = 0; i < BSIZE; i ++) {
			buf[i] = 0xaa;		// data to be written 
    80028874:	faa00b93          	li	s7,-86
		}

		sdcard_write_sector(buf, sec);

		for (int i = 0; i < BSIZE; i ++) {
			buf[i] = 0xff;		// fill in junk
    80028878:	5b7d                	li	s6,-1
		}

		sdcard_read_sector(buf, sec);
		for (int i = 0; i < BSIZE; i ++) {
    8002887a:	4d01                	li	s10,0
			if (0 == i % 16) {
				printf("\n");
    8002887c:	00004c17          	auipc	s8,0x4
    80028880:	0acc0c13          	addi	s8,s8,172 # 8002c928 <syscalls+0x870>
			}

			printf("%x ", buf[i]);
    80028884:	00005a97          	auipc	s5,0x5
    80028888:	a34a8a93          	addi	s5,s5,-1484 # 8002d2b8 <function_config+0x640>
		for (int i = 0; i < BSIZE; i ++) {
    8002888c:	20000a13          	li	s4,512
    80028890:	a835                	j	800288cc <test_sdcard+0x94>
			printf("%x ", buf[i]);
    80028892:	00094583          	lbu	a1,0(s2)
    80028896:	8556                	mv	a0,s5
    80028898:	ffff8097          	auipc	ra,0xffff8
    8002889c:	8f8080e7          	jalr	-1800(ra) # 80020190 <printf>
		for (int i = 0; i < BSIZE; i ++) {
    800288a0:	2485                	addiw	s1,s1,1
    800288a2:	0905                	addi	s2,s2,1
    800288a4:	01448b63          	beq	s1,s4,800288ba <test_sdcard+0x82>
			if (0 == i % 16) {
    800288a8:	00f4f793          	andi	a5,s1,15
    800288ac:	f3fd                	bnez	a5,80028892 <test_sdcard+0x5a>
				printf("\n");
    800288ae:	8562                	mv	a0,s8
    800288b0:	ffff8097          	auipc	ra,0xffff8
    800288b4:	8e0080e7          	jalr	-1824(ra) # 80020190 <printf>
    800288b8:	bfe9                	j	80028892 <test_sdcard+0x5a>
		}
		printf("\n");
    800288ba:	8562                	mv	a0,s8
    800288bc:	ffff8097          	auipc	ra,0xffff8
    800288c0:	8d4080e7          	jalr	-1836(ra) # 80020190 <printf>
	for (int sec = 0; sec < 5; sec ++) {
    800288c4:	2c85                	addiw	s9,s9,1
    800288c6:	4795                	li	a5,5
    800288c8:	04fc8063          	beq	s9,a5,80028908 <test_sdcard+0xd0>
    800288cc:	da040913          	addi	s2,s0,-608
void test_sdcard(void) {
    800288d0:	87ca                	mv	a5,s2
			buf[i] = 0xaa;		// data to be written 
    800288d2:	01778023          	sb	s7,0(a5)
    800288d6:	0785                	addi	a5,a5,1
		for (int i = 0; i < BSIZE; i ++) {
    800288d8:	ff379de3          	bne	a5,s3,800288d2 <test_sdcard+0x9a>
		sdcard_write_sector(buf, sec);
    800288dc:	85e6                	mv	a1,s9
    800288de:	da040513          	addi	a0,s0,-608
    800288e2:	00000097          	auipc	ra,0x0
    800288e6:	d6a080e7          	jalr	-662(ra) # 8002864c <sdcard_write_sector>
    800288ea:	87ca                	mv	a5,s2
			buf[i] = 0xff;		// fill in junk
    800288ec:	01678023          	sb	s6,0(a5)
    800288f0:	0785                	addi	a5,a5,1
		for (int i = 0; i < BSIZE; i ++) {
    800288f2:	ff379de3          	bne	a5,s3,800288ec <test_sdcard+0xb4>
		sdcard_read_sector(buf, sec);
    800288f6:	85e6                	mv	a1,s9
    800288f8:	da040513          	addi	a0,s0,-608
    800288fc:	00000097          	auipc	ra,0x0
    80028900:	c4c080e7          	jalr	-948(ra) # 80028548 <sdcard_read_sector>
		for (int i = 0; i < BSIZE; i ++) {
    80028904:	84ea                	mv	s1,s10
    80028906:	b74d                	j	800288a8 <test_sdcard+0x70>
	}

	while (1) ;
    80028908:	a001                	j	80028908 <test_sdcard+0xd0>

000000008002890a <dmac_enable>:
{
    return dmac->channel[channel_num].axi_id;
}

static void dmac_enable(void)
{
    8002890a:	1141                	addi	sp,sp,-16
    8002890c:	e422                	sd	s0,8(sp)
    8002890e:	0800                	addi	s0,sp,16
    dmac_cfg_u_t dmac_cfg;

    dmac_cfg.data = readq(&dmac->cfg);
    80028910:	3f500793          	li	a5,1013
    80028914:	07f2                	slli	a5,a5,0x1c
    80028916:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 1;
    dmac_cfg.cfg.int_en = 1;
    80028918:	00376713          	ori	a4,a4,3
    writeq(dmac_cfg.data, &dmac->cfg);
    8002891c:	eb98                	sd	a4,16(a5)
}
    8002891e:	6422                	ld	s0,8(sp)
    80028920:	0141                	addi	sp,sp,16
    80028922:	8082                	ret

0000000080028924 <dmac_read_id>:
{
    80028924:	1141                	addi	sp,sp,-16
    80028926:	e422                	sd	s0,8(sp)
    80028928:	0800                	addi	s0,sp,16
    return dmac->id;
    8002892a:	3f500793          	li	a5,1013
    8002892e:	07f2                	slli	a5,a5,0x1c
    80028930:	6388                	ld	a0,0(a5)
}
    80028932:	6422                	ld	s0,8(sp)
    80028934:	0141                	addi	sp,sp,16
    80028936:	8082                	ret

0000000080028938 <dmac_read_version>:
{
    80028938:	1141                	addi	sp,sp,-16
    8002893a:	e422                	sd	s0,8(sp)
    8002893c:	0800                	addi	s0,sp,16
    return dmac->compver;
    8002893e:	3f500793          	li	a5,1013
    80028942:	07f2                	slli	a5,a5,0x1c
    80028944:	6788                	ld	a0,8(a5)
}
    80028946:	6422                	ld	s0,8(sp)
    80028948:	0141                	addi	sp,sp,16
    8002894a:	8082                	ret

000000008002894c <dmac_read_channel_id>:
{
    8002894c:	1141                	addi	sp,sp,-16
    8002894e:	e422                	sd	s0,8(sp)
    80028950:	0800                	addi	s0,sp,16
    return dmac->channel[channel_num].axi_id;
    80028952:	1502                	slli	a0,a0,0x20
    80028954:	9101                	srli	a0,a0,0x20
    80028956:	00851793          	slli	a5,a0,0x8
    8002895a:	3f500513          	li	a0,1013
    8002895e:	0572                	slli	a0,a0,0x1c
    80028960:	953e                	add	a0,a0,a5
    80028962:	15053503          	ld	a0,336(a0)
}
    80028966:	6422                	ld	s0,8(sp)
    80028968:	0141                	addi	sp,sp,16
    8002896a:	8082                	ret

000000008002896c <dmac_disable>:

void dmac_disable(void)
{
    8002896c:	1141                	addi	sp,sp,-16
    8002896e:	e422                	sd	s0,8(sp)
    80028970:	0800                	addi	s0,sp,16
    dmac_cfg_u_t dmac_cfg;

    dmac_cfg.data = readq(&dmac->cfg);
    80028972:	3f500793          	li	a5,1013
    80028976:	07f2                	slli	a5,a5,0x1c
    80028978:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 0;
    dmac_cfg.cfg.int_en = 0;
    8002897a:	9b71                	andi	a4,a4,-4
    writeq(dmac_cfg.data, &dmac->cfg);
    8002897c:	eb98                	sd	a4,16(a5)
}
    8002897e:	6422                	ld	s0,8(sp)
    80028980:	0141                	addi	sp,sp,16
    80028982:	8082                	ret

0000000080028984 <dmac_channel_enable>:

void dmac_channel_enable(dmac_channel_number_t channel_num)
{
    80028984:	1141                	addi	sp,sp,-16
    80028986:	e422                	sd	s0,8(sp)
    80028988:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;

    chen.data = readq(&dmac->chen);
    8002898a:	3f500793          	li	a5,1013
    8002898e:	07f2                	slli	a5,a5,0x1c
    80028990:	6f9c                	ld	a5,24(a5)

    switch(channel_num)
    80028992:	4715                	li	a4,5
    80028994:	00a76d63          	bltu	a4,a0,800289ae <dmac_channel_enable+0x2a>
    80028998:	050a                	slli	a0,a0,0x2
    8002899a:	00005697          	auipc	a3,0x5
    8002899e:	92668693          	addi	a3,a3,-1754 # 8002d2c0 <function_config+0x648>
    800289a2:	9536                	add	a0,a0,a3
    800289a4:	4118                	lw	a4,0(a0)
    800289a6:	9736                	add	a4,a4,a3
    800289a8:	8702                	jr	a4
    {
        case DMAC_CHANNEL0:
            chen.dmac_chen.ch1_en = 1;
            chen.dmac_chen.ch1_en_we = 1;
    800289aa:	1017e793          	ori	a5,a5,257
            break;
        default:
            break;
    }

    writeq(chen.data, &dmac->chen);
    800289ae:	3f500713          	li	a4,1013
    800289b2:	0772                	slli	a4,a4,0x1c
    800289b4:	ef1c                	sd	a5,24(a4)
}
    800289b6:	6422                	ld	s0,8(sp)
    800289b8:	0141                	addi	sp,sp,16
    800289ba:	8082                	ret
            chen.dmac_chen.ch2_en_we = 1;
    800289bc:	2027e793          	ori	a5,a5,514
            break;
    800289c0:	b7fd                	j	800289ae <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch3_en_we = 1;
    800289c2:	4047e793          	ori	a5,a5,1028
            break;
    800289c6:	b7e5                	j	800289ae <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch4_en = 1;
    800289c8:	0087e793          	ori	a5,a5,8
            chen.dmac_chen.ch4_en_we = 1;
    800289cc:	6705                	lui	a4,0x1
    800289ce:	80070713          	addi	a4,a4,-2048 # 800 <BASE_ADDRESS-0x8001f800>
    800289d2:	8fd9                	or	a5,a5,a4
            break;
    800289d4:	bfe9                	j	800289ae <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch5_en = 1;
    800289d6:	0107e793          	ori	a5,a5,16
            chen.dmac_chen.ch5_en_we = 1;
    800289da:	6705                	lui	a4,0x1
    800289dc:	8fd9                	or	a5,a5,a4
            break;
    800289de:	bfc1                	j	800289ae <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch6_en = 1;
    800289e0:	0207e793          	ori	a5,a5,32
            chen.dmac_chen.ch6_en_we = 1;
    800289e4:	6709                	lui	a4,0x2
    800289e6:	8fd9                	or	a5,a5,a4
            break;
    800289e8:	b7d9                	j	800289ae <dmac_channel_enable+0x2a>

00000000800289ea <dmac_channel_disable>:

void dmac_channel_disable(dmac_channel_number_t channel_num)
{
    800289ea:	1141                	addi	sp,sp,-16
    800289ec:	e422                	sd	s0,8(sp)
    800289ee:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;

    chen.data = readq(&dmac->chen);
    800289f0:	3f500793          	li	a5,1013
    800289f4:	07f2                	slli	a5,a5,0x1c
    800289f6:	6f9c                	ld	a5,24(a5)

    switch(channel_num)
    800289f8:	4715                	li	a4,5
    800289fa:	00a76e63          	bltu	a4,a0,80028a16 <dmac_channel_disable+0x2c>
    800289fe:	050a                	slli	a0,a0,0x2
    80028a00:	00005697          	auipc	a3,0x5
    80028a04:	8d868693          	addi	a3,a3,-1832 # 8002d2d8 <function_config+0x660>
    80028a08:	9536                	add	a0,a0,a3
    80028a0a:	4118                	lw	a4,0(a0)
    80028a0c:	9736                	add	a4,a4,a3
    80028a0e:	8702                	jr	a4
    {
        case DMAC_CHANNEL0:
            chen.dmac_chen.ch1_en = 0;
    80028a10:	9bf9                	andi	a5,a5,-2
            chen.dmac_chen.ch1_en_we = 1;
    80028a12:	1007e793          	ori	a5,a5,256
            break;
        default:
            break;
    }

    writeq(chen.data, &dmac->chen);
    80028a16:	3f500713          	li	a4,1013
    80028a1a:	0772                	slli	a4,a4,0x1c
    80028a1c:	ef1c                	sd	a5,24(a4)
}
    80028a1e:	6422                	ld	s0,8(sp)
    80028a20:	0141                	addi	sp,sp,16
    80028a22:	8082                	ret
            chen.dmac_chen.ch2_en = 0;
    80028a24:	9bf5                	andi	a5,a5,-3
            chen.dmac_chen.ch2_en_we = 1;
    80028a26:	2007e793          	ori	a5,a5,512
            break;
    80028a2a:	b7f5                	j	80028a16 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch3_en = 0;
    80028a2c:	9bed                	andi	a5,a5,-5
            chen.dmac_chen.ch3_en_we = 1;
    80028a2e:	4007e793          	ori	a5,a5,1024
            break;
    80028a32:	b7d5                	j	80028a16 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch4_en = 0;
    80028a34:	9bdd                	andi	a5,a5,-9
            chen.dmac_chen.ch4_en_we = 1;
    80028a36:	6705                	lui	a4,0x1
    80028a38:	80070713          	addi	a4,a4,-2048 # 800 <BASE_ADDRESS-0x8001f800>
    80028a3c:	8fd9                	or	a5,a5,a4
            break;
    80028a3e:	bfe1                	j	80028a16 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch5_en = 0;
    80028a40:	9bbd                	andi	a5,a5,-17
            chen.dmac_chen.ch5_en_we = 1;
    80028a42:	6705                	lui	a4,0x1
    80028a44:	8fd9                	or	a5,a5,a4
            break;
    80028a46:	bfc1                	j	80028a16 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch6_en = 0;
    80028a48:	fdf7f793          	andi	a5,a5,-33
            chen.dmac_chen.ch6_en_we = 1;
    80028a4c:	6709                	lui	a4,0x2
    80028a4e:	8fd9                	or	a5,a5,a4
            break;
    80028a50:	b7d9                	j	80028a16 <dmac_channel_disable+0x2c>

0000000080028a52 <dmac_enable_common_interrupt_status>:

void dmac_enable_common_interrupt_status(void)
{
    80028a52:	1141                	addi	sp,sp,-16
    80028a54:	e422                	sd	s0,8(sp)
    80028a56:	0800                	addi	s0,sp,16
    dmac_commonreg_intstatus_enable_u_t intstatus;

    intstatus.data = readq(&dmac->com_intstatus_en);
    80028a58:	3f500793          	li	a5,1013
    80028a5c:	07f2                	slli	a5,a5,0x1c
    80028a5e:	63b8                	ld	a4,64(a5)
    intstatus.intstatus_enable.enable_slvif_dec_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_wr2ro_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_rd2wo_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_wronhold_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_undefinedreg_dec_err_intstat = 1;
    80028a60:	10f76713          	ori	a4,a4,271

    writeq(intstatus.data, &dmac->com_intstatus_en);
    80028a64:	e3b8                	sd	a4,64(a5)
}
    80028a66:	6422                	ld	s0,8(sp)
    80028a68:	0141                	addi	sp,sp,16
    80028a6a:	8082                	ret

0000000080028a6c <dmac_enable_common_interrupt_signal>:

void dmac_enable_common_interrupt_signal(void)
{
    80028a6c:	1141                	addi	sp,sp,-16
    80028a6e:	e422                	sd	s0,8(sp)
    80028a70:	0800                	addi	s0,sp,16
    dmac_commonreg_intsignal_enable_u_t intsignal;

    intsignal.data = readq(&dmac->com_intsignal_en);
    80028a72:	3f500793          	li	a5,1013
    80028a76:	07f2                	slli	a5,a5,0x1c
    80028a78:	67b8                	ld	a4,72(a5)
    intsignal.intsignal_enable.enable_slvif_dec_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_wr2ro_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_rd2wo_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_wronhold_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_undefinedreg_dec_err_intsignal = 1;
    80028a7a:	10f76713          	ori	a4,a4,271

    writeq(intsignal.data, &dmac->com_intsignal_en);
    80028a7e:	e7b8                	sd	a4,72(a5)
}
    80028a80:	6422                	ld	s0,8(sp)
    80028a82:	0141                	addi	sp,sp,16
    80028a84:	8082                	ret

0000000080028a86 <dmac_disable_channel_interrupt>:
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    writeq(0x2, &dmac->channel[channel_num].intstatus_en);
}

void dmac_disable_channel_interrupt(dmac_channel_number_t channel_num)
{
    80028a86:	1141                	addi	sp,sp,-16
    80028a88:	e422                	sd	s0,8(sp)
    80028a8a:	0800                	addi	s0,sp,16
    writeq(0, &dmac->channel[channel_num].intstatus_en);
    80028a8c:	1502                	slli	a0,a0,0x20
    80028a8e:	9101                	srli	a0,a0,0x20
    80028a90:	00851793          	slli	a5,a0,0x8
    80028a94:	3f500513          	li	a0,1013
    80028a98:	0572                	slli	a0,a0,0x1c
    80028a9a:	953e                	add	a0,a0,a5
    80028a9c:	18053023          	sd	zero,384(a0)
}
    80028aa0:	6422                	ld	s0,8(sp)
    80028aa2:	0141                	addi	sp,sp,16
    80028aa4:	8082                	ret

0000000080028aa6 <dmac_set_channel_param>:
int dmac_set_channel_param(dmac_channel_number_t channel_num,
                           const void *src, void *dest, dmac_address_increment_t src_inc, dmac_address_increment_t dest_inc,
                           dmac_burst_trans_length_t dmac_burst_size,
                           dmac_transfer_width_t dmac_trans_width,
                           uint32 blockSize)
{
    80028aa6:	1141                	addi	sp,sp,-16
    80028aa8:	e422                	sd	s0,8(sp)
    80028aaa:	0800                	addi	s0,sp,16
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028aac:	80000e37          	lui	t3,0x80000
    80028ab0:	9e2e                	add	t3,t3,a1
    80028ab2:	00600337          	lui	t1,0x600
    80028ab6:	046e6663          	bltu	t3,t1,80028b02 <dmac_set_channel_param+0x5c>
    80028aba:	c0000337          	lui	t1,0xc0000
    80028abe:	932e                	add	t1,t1,a1
    80028ac0:	00800e37          	lui	t3,0x800
    80028ac4:	03c36f63          	bltu	t1,t3,80028b02 <dmac_set_channel_param+0x5c>
    80028ac8:	afbb02b7          	lui	t0,0xafbb0
    80028acc:	fc028293          	addi	t0,t0,-64 # ffffffffafbaffc0 <kernel_end+0xffffffff2fb69fc0>
    80028ad0:	92ae                	add	t0,t0,a1
    80028ad2:	0012b293          	seqz	t0,t0
    dmac_ch_ctl_u_t ctl;
    dmac_ch_cfg_u_t cfg_u;

    int mem_type_src = is_memory((uintptr_t)src), mem_type_dest = is_memory((uintptr_t)dest);
    80028ad6:	8fb2                	mv	t6,a2
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028ad8:	80000337          	lui	t1,0x80000
    80028adc:	9332                	add	t1,t1,a2
    80028ade:	00600e37          	lui	t3,0x600
    80028ae2:	4f05                	li	t5,1
    80028ae4:	03c37863          	bgeu	t1,t3,80028b14 <dmac_set_channel_param+0x6e>
    {
        flow_control = DMAC_PRF2PRF_DMA;
    } else if(mem_type_src == 1 && mem_type_dest == 0)
        flow_control = DMAC_MEM2PRF_DMA;
    else if(mem_type_src == 0 && mem_type_dest == 1)
        flow_control = DMAC_PRF2MEM_DMA;
    80028ae8:	4309                	li	t1,2
    } else if(mem_type_src == 1 && mem_type_dest == 0)
    80028aea:	04028963          	beqz	t0,80028b3c <dmac_set_channel_param+0x96>
    80028aee:	a039                	j	80028afc <dmac_set_channel_param+0x56>
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028af0:	8f32                	mv	t5,a2
    80028af2:	bfdd                	j	80028ae8 <dmac_set_channel_param+0x42>
    80028af4:	4f05                	li	t5,1
    80028af6:	bfcd                	j	80028ae8 <dmac_set_channel_param+0x42>
    80028af8:	4f05                	li	t5,1
    80028afa:	4285                	li	t0,1
        flow_control = DMAC_PRF2PRF_DMA;
    80028afc:	001f3313          	seqz	t1,t5
    80028b00:	a835                	j	80028b3c <dmac_set_channel_param+0x96>
    int mem_type_src = is_memory((uintptr_t)src), mem_type_dest = is_memory((uintptr_t)dest);
    80028b02:	8fb2                	mv	t6,a2
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028b04:	80000337          	lui	t1,0x80000
    80028b08:	9332                	add	t1,t1,a2
    80028b0a:	00600e37          	lui	t3,0x600
    80028b0e:	4285                	li	t0,1
    80028b10:	ffc364e3          	bltu	t1,t3,80028af8 <dmac_set_channel_param+0x52>
    80028b14:	c0000337          	lui	t1,0xc0000
    80028b18:	937e                	add	t1,t1,t6
    80028b1a:	00800e37          	lui	t3,0x800
    80028b1e:	fdc36be3          	bltu	t1,t3,80028af4 <dmac_set_channel_param+0x4e>
    80028b22:	afbb0337          	lui	t1,0xafbb0
    80028b26:	fc030313          	addi	t1,t1,-64 # ffffffffafbaffc0 <kernel_end+0xffffffff2fb69fc0>
    80028b2a:	961a                	add	a2,a2,t1
    80028b2c:	00163613          	seqz	a2,a2
    if(mem_type_src == 0 && mem_type_dest == 0)
    80028b30:	00566f33          	or	t5,a2,t0
    80028b34:	2f01                	sext.w	t5,t5
        flow_control = DMAC_PRF2PRF_DMA;
    80028b36:	430d                	li	t1,3
    if(mem_type_src == 0 && mem_type_dest == 0)
    80028b38:	fa0f1ce3          	bnez	t5,80028af0 <dmac_set_channel_param+0x4a>

    /**
     * cfg register must configure before ts_block and
     * sar dar register
     */
    cfg_u.data = readq(&dmac->channel[channel_num].cfg);
    80028b3c:	02051e93          	slli	t4,a0,0x20
    80028b40:	020ede93          	srli	t4,t4,0x20
    80028b44:	008e9613          	slli	a2,t4,0x8
    80028b48:	3f500e93          	li	t4,1013
    80028b4c:	0ef2                	slli	t4,t4,0x1c
    80028b4e:	9eb2                	add	t4,t4,a2
    80028b50:	120ebe03          	ld	t3,288(t4)

    cfg_u.ch_cfg.tt_fc = flow_control;
    80028b54:	02031613          	slli	a2,t1,0x20
    80028b58:	5365                	li	t1,-7
    80028b5a:	1302                	slli	t1,t1,0x20
    80028b5c:	137d                	addi	t1,t1,-1
    80028b5e:	006e7333          	and	t1,t3,t1
    80028b62:	00c36333          	or	t1,t1,a2
    cfg_u.ch_cfg.hs_sel_src = mem_type_src ? DMAC_HS_SOFTWARE : DMAC_HS_HARDWARE;
    80028b66:	128e                	slli	t0,t0,0x23
    80028b68:	567d                	li	a2,-1
    80028b6a:	02361e13          	slli	t3,a2,0x23
    80028b6e:	1e7d                	addi	t3,t3,-1
    80028b70:	01c37333          	and	t1,t1,t3
    80028b74:	00536333          	or	t1,t1,t0
    cfg_u.ch_cfg.hs_sel_dst = mem_type_dest ? DMAC_HS_SOFTWARE : DMAC_HS_HARDWARE;
    80028b78:	01e03f33          	snez	t5,t5
    80028b7c:	1f12                	slli	t5,t5,0x24
    80028b7e:	1612                	slli	a2,a2,0x24
    80028b80:	167d                	addi	a2,a2,-1
    80028b82:	00c37333          	and	t1,t1,a2
    80028b86:	01e36333          	or	t1,t1,t5
    cfg_u.ch_cfg.src_per = channel_num;
    80028b8a:	893d                	andi	a0,a0,15
    80028b8c:	02751f13          	slli	t5,a0,0x27
    80028b90:	5645                	li	a2,-15
    80028b92:	02761e13          	slli	t3,a2,0x27
    80028b96:	1e7d                	addi	t3,t3,-1
    80028b98:	01c37333          	and	t1,t1,t3
    80028b9c:	01e36333          	or	t1,t1,t5
    cfg_u.ch_cfg.dst_per = channel_num;
    80028ba0:	02c51e13          	slli	t3,a0,0x2c
    80028ba4:	02c61513          	slli	a0,a2,0x2c
    80028ba8:	157d                	addi	a0,a0,-1
    80028baa:	00a37533          	and	a0,t1,a0
    80028bae:	01c56533          	or	a0,a0,t3
    cfg_u.ch_cfg.src_multblk_type = 0;
    cfg_u.ch_cfg.dst_multblk_type = 0;
    80028bb2:	9941                	andi	a0,a0,-16

    writeq(cfg_u.data, &dmac->channel[channel_num].cfg);
    80028bb4:	12aeb023          	sd	a0,288(t4)

    dmac->channel[channel_num].sar = (uint64)src;
    80028bb8:	10beb023          	sd	a1,256(t4)
    dmac->channel[channel_num].dar = (uint64)dest;
    80028bbc:	11feb423          	sd	t6,264(t4)

    ctl.data = readq(&dmac->channel[channel_num].ctl);
    80028bc0:	118eb603          	ld	a2,280(t4)
    ctl.ch_ctl.sms = DMAC_MASTER1;
    ctl.ch_ctl.dms = DMAC_MASTER2;
    80028bc4:	9a39                	andi	a2,a2,-18
    /* master select */
    ctl.ch_ctl.sinc = src_inc;
    80028bc6:	8a85                	andi	a3,a3,1
    80028bc8:	0692                	slli	a3,a3,0x4
    80028bca:	00466613          	ori	a2,a2,4
    80028bce:	8e55                	or	a2,a2,a3
    ctl.ch_ctl.dinc = dest_inc;
    80028bd0:	8b05                	andi	a4,a4,1
    80028bd2:	071a                	slli	a4,a4,0x6
    80028bd4:	8be67613          	andi	a2,a2,-1858
    /* address incrememt */
    ctl.ch_ctl.src_tr_width = dmac_trans_width;
    80028bd8:	00787813          	andi	a6,a6,7
    80028bdc:	00881693          	slli	a3,a6,0x8
    80028be0:	8e59                	or	a2,a2,a4
    80028be2:	8e55                	or	a2,a2,a3
    ctl.ch_ctl.dst_tr_width = dmac_trans_width;
    80028be4:	082e                	slli	a6,a6,0xb
    80028be6:	7771                	lui	a4,0xffffc
    80028be8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffc7ff <kernel_end+0xffffffff7ffb67ff>
    80028bec:	8e79                	and	a2,a2,a4
    80028bee:	01066633          	or	a2,a2,a6
    /* transfer width */
    ctl.ch_ctl.src_msize = dmac_burst_size;
    80028bf2:	00f7f713          	andi	a4,a5,15
    80028bf6:	00e71693          	slli	a3,a4,0xe
    80028bfa:	fffc47b7          	lui	a5,0xfffc4
    80028bfe:	17fd                	addi	a5,a5,-1
    80028c00:	8ff1                	and	a5,a5,a2
    80028c02:	8fd5                	or	a5,a5,a3
    ctl.ch_ctl.dst_msize = dmac_burst_size;
    80028c04:	074a                	slli	a4,a4,0x12
    80028c06:	ffc40637          	lui	a2,0xffc40
    80028c0a:	167d                	addi	a2,a2,-1
    80028c0c:	8ff1                	and	a5,a5,a2
    80028c0e:	8fd9                	or	a5,a5,a4

    writeq(ctl.data, &dmac->channel[channel_num].ctl);
    80028c10:	10febc23          	sd	a5,280(t4)

    writeq(blockSize - 1, &dmac->channel[channel_num].block_ts);
    80028c14:	38fd                	addiw	a7,a7,-1
    80028c16:	1882                	slli	a7,a7,0x20
    80028c18:	0208d893          	srli	a7,a7,0x20
    80028c1c:	111eb823          	sd	a7,272(t4)
    /*the number of (blcok_ts +1) data of width SRC_TR_WIDTF to be */
    /* transferred in a dma block transfer */
    return 0;
}
    80028c20:	4501                	li	a0,0
    80028c22:	6422                	ld	s0,8(sp)
    80028c24:	0141                	addi	sp,sp,16
    80028c26:	8082                	ret

0000000080028c28 <dmac_init>:

void dmac_init(void)
{
    80028c28:	1141                	addi	sp,sp,-16
    80028c2a:	e406                	sd	ra,8(sp)
    80028c2c:	e022                	sd	s0,0(sp)
    80028c2e:	0800                	addi	s0,sp,16
    uint64 tmp;
    dmac_commonreg_intclear_u_t intclear;
    dmac_cfg_u_t dmac_cfg;
    dmac_reset_u_t dmac_reset;

    sysctl_clock_enable(SYSCTL_CLOCK_DMA);
    80028c30:	4529                	li	a0,10
    80028c32:	00000097          	auipc	ra,0x0
    80028c36:	220080e7          	jalr	544(ra) # 80028e52 <sysctl_clock_enable>
    // printf("[dmac_init] dma clk=%d\n", sysctl_clock_get_freq(SYSCTL_CLOCK_DMA));

    dmac_reset.data = readq(&dmac->reset);
    80028c3a:	3f500793          	li	a5,1013
    80028c3e:	07f2                	slli	a5,a5,0x1c
    80028c40:	6fb8                	ld	a4,88(a5)
    dmac_reset.reset.rst = 1;
    80028c42:	00176713          	ori	a4,a4,1
    writeq(dmac_reset.data, &dmac->reset);
    80028c46:	efb8                	sd	a4,88(a5)
    while(dmac_reset.reset.rst)
        dmac_reset.data = readq(&dmac->reset);
    80028c48:	873e                	mv	a4,a5
    80028c4a:	6f3c                	ld	a5,88(a4)
    while(dmac_reset.reset.rst)
    80028c4c:	8b85                	andi	a5,a5,1
    80028c4e:	fff5                	bnez	a5,80028c4a <dmac_init+0x22>

    /*reset dmac */

    intclear.data = readq(&dmac->com_intclear);
    80028c50:	3f500793          	li	a5,1013
    80028c54:	07f2                	slli	a5,a5,0x1c
    80028c56:	7f98                	ld	a4,56(a5)
    intclear.com_intclear.clear_slvif_dec_err_intstat = 1;
    intclear.com_intclear.clear_slvif_wr2ro_err_intstat = 1;
    intclear.com_intclear.clear_slvif_rd2wo_err_intstat = 1;
    intclear.com_intclear.clear_slvif_wronhold_err_intstat = 1;
    intclear.com_intclear.clear_slvif_undefinedreg_dec_err_intstat = 1;
    80028c58:	10f76713          	ori	a4,a4,271
    writeq(intclear.data, &dmac->com_intclear);
    80028c5c:	ff98                	sd	a4,56(a5)
    /* clear common register interrupt */

    dmac_cfg.data = readq(&dmac->cfg);
    80028c5e:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 0;
    dmac_cfg.cfg.int_en = 0;
    80028c60:	9b71                	andi	a4,a4,-4
    writeq(dmac_cfg.data, &dmac->cfg);
    80028c62:	eb98                	sd	a4,16(a5)
    /* disable dmac and disable interrupt */

    while(readq(&dmac->cfg))
    80028c64:	873e                	mv	a4,a5
    80028c66:	6b1c                	ld	a5,16(a4)
    80028c68:	fffd                	bnez	a5,80028c66 <dmac_init+0x3e>
        ;
    tmp = readq(&dmac->chen);
    80028c6a:	3f500793          	li	a5,1013
    80028c6e:	07f2                	slli	a5,a5,0x1c
    80028c70:	6f98                	ld	a4,24(a5)
    tmp &= ~0xf;
    80028c72:	9b41                	andi	a4,a4,-16
    writeq(tmp, &dmac->chen);
    80028c74:	ef98                	sd	a4,24(a5)
    /* disable all channel before configure */
    dmac_enable();
    80028c76:	00000097          	auipc	ra,0x0
    80028c7a:	c94080e7          	jalr	-876(ra) # 8002890a <dmac_enable>
}
    80028c7e:	60a2                	ld	ra,8(sp)
    80028c80:	6402                	ld	s0,0(sp)
    80028c82:	0141                	addi	sp,sp,16
    80028c84:	8082                	ret

0000000080028c86 <dmac_is_done>:
    dmac_enable_channel_interrupt(channel_num);
    dmac_channel_enable(channel_num);
}

int dmac_is_done(dmac_channel_number_t channel_num)
{
    80028c86:	1141                	addi	sp,sp,-16
    80028c88:	e422                	sd	s0,8(sp)
    80028c8a:	0800                	addi	s0,sp,16
    if(readq(&dmac->channel[channel_num].intstatus) & 0x2)
    80028c8c:	1502                	slli	a0,a0,0x20
    80028c8e:	9101                	srli	a0,a0,0x20
    80028c90:	00851793          	slli	a5,a0,0x8
    80028c94:	3f500513          	li	a0,1013
    80028c98:	0572                	slli	a0,a0,0x1c
    80028c9a:	953e                	add	a0,a0,a5
    80028c9c:	18853503          	ld	a0,392(a0)
    80028ca0:	8105                	srli	a0,a0,0x1
        return 1;
    else
        return 0;
}
    80028ca2:	8905                	andi	a0,a0,1
    80028ca4:	6422                	ld	s0,8(sp)
    80028ca6:	0141                	addi	sp,sp,16
    80028ca8:	8082                	ret

0000000080028caa <dmac_is_idle>:
{
    dmac_wait_idle(channel_num);
}

int dmac_is_idle(dmac_channel_number_t channel_num)
{
    80028caa:	1141                	addi	sp,sp,-16
    80028cac:	e422                	sd	s0,8(sp)
    80028cae:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;
    chen.data = readq(&dmac->chen);
    80028cb0:	3f500793          	li	a5,1013
    80028cb4:	07f2                	slli	a5,a5,0x1c
    80028cb6:	6f9c                	ld	a5,24(a5)
    if((chen.data >> channel_num) & 0x1UL)
    80028cb8:	00a7d533          	srl	a0,a5,a0
    80028cbc:	00154513          	xori	a0,a0,1
        return 0;
    else
        return 1;
}
    80028cc0:	8905                	andi	a0,a0,1
    80028cc2:	6422                	ld	s0,8(sp)
    80028cc4:	0141                	addi	sp,sp,16
    80028cc6:	8082                	ret

0000000080028cc8 <dmac_wait_idle>:

static void *dmac_chan = (void *) DMAC_V;

void dmac_wait_idle(dmac_channel_number_t channel_num)
{
    80028cc8:	1101                	addi	sp,sp,-32
    80028cca:	ec06                	sd	ra,24(sp)
    80028ccc:	e822                	sd	s0,16(sp)
    80028cce:	e426                	sd	s1,8(sp)
    80028cd0:	e04a                	sd	s2,0(sp)
    80028cd2:	1000                	addi	s0,sp,32
    80028cd4:	892a                	mv	s2,a0
    while(!dmac_is_idle(channel_num)) {
        acquire(&myproc()->lock);
        sleep(dmac_chan, &myproc()->lock);
    80028cd6:	3f500493          	li	s1,1013
    80028cda:	04f2                	slli	s1,s1,0x1c
    while(!dmac_is_idle(channel_num)) {
    80028cdc:	854a                	mv	a0,s2
    80028cde:	00000097          	auipc	ra,0x0
    80028ce2:	fcc080e7          	jalr	-52(ra) # 80028caa <dmac_is_idle>
    80028ce6:	ed05                	bnez	a0,80028d1e <dmac_wait_idle+0x56>
        acquire(&myproc()->lock);
    80028ce8:	ffff9097          	auipc	ra,0xffff9
    80028cec:	e9a080e7          	jalr	-358(ra) # 80021b82 <myproc>
    80028cf0:	ffff8097          	auipc	ra,0xffff8
    80028cf4:	9d0080e7          	jalr	-1584(ra) # 800206c0 <acquire>
        sleep(dmac_chan, &myproc()->lock);
    80028cf8:	ffff9097          	auipc	ra,0xffff9
    80028cfc:	e8a080e7          	jalr	-374(ra) # 80021b82 <myproc>
    80028d00:	85aa                	mv	a1,a0
    80028d02:	8526                	mv	a0,s1
    80028d04:	ffff9097          	auipc	ra,0xffff9
    80028d08:	726080e7          	jalr	1830(ra) # 8002242a <sleep>
        release(&myproc()->lock);
    80028d0c:	ffff9097          	auipc	ra,0xffff9
    80028d10:	e76080e7          	jalr	-394(ra) # 80021b82 <myproc>
    80028d14:	ffff8097          	auipc	ra,0xffff8
    80028d18:	a00080e7          	jalr	-1536(ra) # 80020714 <release>
    80028d1c:	b7c1                	j	80028cdc <dmac_wait_idle+0x14>
    }
}
    80028d1e:	60e2                	ld	ra,24(sp)
    80028d20:	6442                	ld	s0,16(sp)
    80028d22:	64a2                	ld	s1,8(sp)
    80028d24:	6902                	ld	s2,0(sp)
    80028d26:	6105                	addi	sp,sp,32
    80028d28:	8082                	ret

0000000080028d2a <dmac_set_single_mode>:
{
    80028d2a:	711d                	addi	sp,sp,-96
    80028d2c:	ec86                	sd	ra,88(sp)
    80028d2e:	e8a2                	sd	s0,80(sp)
    80028d30:	e4a6                	sd	s1,72(sp)
    80028d32:	e0ca                	sd	s2,64(sp)
    80028d34:	fc4e                	sd	s3,56(sp)
    80028d36:	f852                	sd	s4,48(sp)
    80028d38:	f456                	sd	s5,40(sp)
    80028d3a:	f05a                	sd	s6,32(sp)
    80028d3c:	ec5e                	sd	s7,24(sp)
    80028d3e:	e862                	sd	s8,16(sp)
    80028d40:	e466                	sd	s9,8(sp)
    80028d42:	e06a                	sd	s10,0(sp)
    80028d44:	1080                	addi	s0,sp,96
    80028d46:	892a                	mv	s2,a0
    80028d48:	8a2e                	mv	s4,a1
    80028d4a:	8ab2                	mv	s5,a2
    80028d4c:	8b36                	mv	s6,a3
    80028d4e:	8bba                	mv	s7,a4
    80028d50:	8c3e                	mv	s8,a5
    80028d52:	8cc2                	mv	s9,a6
    80028d54:	8d46                	mv	s10,a7
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028d56:	02051493          	slli	s1,a0,0x20
    80028d5a:	9081                	srli	s1,s1,0x20
    80028d5c:	00849793          	slli	a5,s1,0x8
    80028d60:	3f500493          	li	s1,1013
    80028d64:	04f2                	slli	s1,s1,0x1c
    80028d66:	94be                	add	s1,s1,a5
    80028d68:	59fd                	li	s3,-1
    80028d6a:	0209d993          	srli	s3,s3,0x20
    80028d6e:	1934bc23          	sd	s3,408(s1) # 1000198 <BASE_ADDRESS-0x7f01fe68>
    dmac_channel_disable(channel_num);
    80028d72:	00000097          	auipc	ra,0x0
    80028d76:	c78080e7          	jalr	-904(ra) # 800289ea <dmac_channel_disable>
    dmac_wait_idle(channel_num);
    80028d7a:	854a                	mv	a0,s2
    80028d7c:	00000097          	auipc	ra,0x0
    80028d80:	f4c080e7          	jalr	-180(ra) # 80028cc8 <dmac_wait_idle>
    dmac_set_channel_param(channel_num, src, dest, src_inc, dest_inc,
    80028d84:	000d089b          	sext.w	a7,s10
    80028d88:	8866                	mv	a6,s9
    80028d8a:	87e2                	mv	a5,s8
    80028d8c:	875e                	mv	a4,s7
    80028d8e:	86da                	mv	a3,s6
    80028d90:	8656                	mv	a2,s5
    80028d92:	85d2                	mv	a1,s4
    80028d94:	854a                	mv	a0,s2
    80028d96:	00000097          	auipc	ra,0x0
    80028d9a:	d10080e7          	jalr	-752(ra) # 80028aa6 <dmac_set_channel_param>
    dmac_enable();
    80028d9e:	00000097          	auipc	ra,0x0
    80028da2:	b6c080e7          	jalr	-1172(ra) # 8002890a <dmac_enable>
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028da6:	1934bc23          	sd	s3,408(s1)
    writeq(0x2, &dmac->channel[channel_num].intstatus_en);
    80028daa:	4789                	li	a5,2
    80028dac:	18f4b023          	sd	a5,384(s1)
    dmac_channel_enable(channel_num);
    80028db0:	854a                	mv	a0,s2
    80028db2:	00000097          	auipc	ra,0x0
    80028db6:	bd2080e7          	jalr	-1070(ra) # 80028984 <dmac_channel_enable>
}
    80028dba:	60e6                	ld	ra,88(sp)
    80028dbc:	6446                	ld	s0,80(sp)
    80028dbe:	64a6                	ld	s1,72(sp)
    80028dc0:	6906                	ld	s2,64(sp)
    80028dc2:	79e2                	ld	s3,56(sp)
    80028dc4:	7a42                	ld	s4,48(sp)
    80028dc6:	7aa2                	ld	s5,40(sp)
    80028dc8:	7b02                	ld	s6,32(sp)
    80028dca:	6be2                	ld	s7,24(sp)
    80028dcc:	6c42                	ld	s8,16(sp)
    80028dce:	6ca2                	ld	s9,8(sp)
    80028dd0:	6d02                	ld	s10,0(sp)
    80028dd2:	6125                	addi	sp,sp,96
    80028dd4:	8082                	ret

0000000080028dd6 <dmac_wait_done>:
{
    80028dd6:	1141                	addi	sp,sp,-16
    80028dd8:	e406                	sd	ra,8(sp)
    80028dda:	e022                	sd	s0,0(sp)
    80028ddc:	0800                	addi	s0,sp,16
    dmac_wait_idle(channel_num);
    80028dde:	00000097          	auipc	ra,0x0
    80028de2:	eea080e7          	jalr	-278(ra) # 80028cc8 <dmac_wait_idle>
}
    80028de6:	60a2                	ld	ra,8(sp)
    80028de8:	6402                	ld	s0,0(sp)
    80028dea:	0141                	addi	sp,sp,16
    80028dec:	8082                	ret

0000000080028dee <dmac_intr>:

void dmac_intr(dmac_channel_number_t channel_num)
{
    80028dee:	1141                	addi	sp,sp,-16
    80028df0:	e406                	sd	ra,8(sp)
    80028df2:	e022                	sd	s0,0(sp)
    80028df4:	0800                	addi	s0,sp,16
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028df6:	3f500793          	li	a5,1013
    80028dfa:	07f2                	slli	a5,a5,0x1c
    80028dfc:	1502                	slli	a0,a0,0x20
    80028dfe:	9101                	srli	a0,a0,0x20
    80028e00:	0522                	slli	a0,a0,0x8
    80028e02:	953e                	add	a0,a0,a5
    80028e04:	577d                	li	a4,-1
    80028e06:	9301                	srli	a4,a4,0x20
    80028e08:	18e53c23          	sd	a4,408(a0)
    dmac_chanel_interrupt_clear(channel_num);
    wakeup(dmac_chan);
    80028e0c:	853e                	mv	a0,a5
    80028e0e:	ffff9097          	auipc	ra,0xffff9
    80028e12:	7f0080e7          	jalr	2032(ra) # 800225fe <wakeup>
    80028e16:	60a2                	ld	ra,8(sp)
    80028e18:	6402                	ld	s0,0(sp)
    80028e1a:	0141                	addi	sp,sp,16
    80028e1c:	8082                	ret

0000000080028e1e <sysctl_get_git_id>:
};

volatile sysctl_t *const sysctl = (volatile sysctl_t *)SYSCTL_V;

uint32 sysctl_get_git_id(void)
{
    80028e1e:	1141                	addi	sp,sp,-16
    80028e20:	e422                	sd	s0,8(sp)
    80028e22:	0800                	addi	s0,sp,16
    return sysctl->git_id.git_id;
    80028e24:	000fd7b7          	lui	a5,0xfd
    80028e28:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e2c:	07ca                	slli	a5,a5,0x12
    80028e2e:	4388                	lw	a0,0(a5)
}
    80028e30:	2501                	sext.w	a0,a0
    80028e32:	6422                	ld	s0,8(sp)
    80028e34:	0141                	addi	sp,sp,16
    80028e36:	8082                	ret

0000000080028e38 <sysctl_get_freq>:

uint32 sysctl_get_freq(void)
{
    80028e38:	1141                	addi	sp,sp,-16
    80028e3a:	e422                	sd	s0,8(sp)
    80028e3c:	0800                	addi	s0,sp,16
    return sysctl->clk_freq.clk_freq;
    80028e3e:	000fd7b7          	lui	a5,0xfd
    80028e42:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e46:	07ca                	slli	a5,a5,0x12
    80028e48:	43c8                	lw	a0,4(a5)
}
    80028e4a:	2501                	sext.w	a0,a0
    80028e4c:	6422                	ld	s0,8(sp)
    80028e4e:	0141                	addi	sp,sp,16
    80028e50:	8082                	ret

0000000080028e52 <sysctl_clock_enable>:

    return 0;
}

int sysctl_clock_enable(sysctl_clock_t clock)
{
    80028e52:	1141                	addi	sp,sp,-16
    80028e54:	e422                	sd	s0,8(sp)
    80028e56:	0800                	addi	s0,sp,16
    if(clock >= SYSCTL_CLOCK_MAX)
    80028e58:	02a00793          	li	a5,42
    80028e5c:	3ea7e363          	bltu	a5,a0,80029242 <sysctl_clock_enable+0x3f0>
        switch(clock)
    80028e60:	ff25079b          	addiw	a5,a0,-14
    80028e64:	0007869b          	sext.w	a3,a5
    80028e68:	475d                	li	a4,23
    80028e6a:	02d76663          	bltu	a4,a3,80028e96 <sysctl_clock_enable+0x44>
    80028e6e:	1782                	slli	a5,a5,0x20
    80028e70:	9381                	srli	a5,a5,0x20
    80028e72:	078a                	slli	a5,a5,0x2
    80028e74:	00004717          	auipc	a4,0x4
    80028e78:	47c70713          	addi	a4,a4,1148 # 8002d2f0 <function_config+0x678>
    80028e7c:	97ba                	add	a5,a5,a4
    80028e7e:	439c                	lw	a5,0(a5)
    80028e80:	97ba                	add	a5,a5,a4
    80028e82:	8782                	jr	a5
                sysctl->clk_en_cent.apb0_clk_en = en;
    80028e84:	000fd7b7          	lui	a5,0xfd
    80028e88:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e8c:	07ca                	slli	a5,a5,0x12
    80028e8e:	5798                	lw	a4,40(a5)
    80028e90:	00876713          	ori	a4,a4,8
    80028e94:	d798                	sw	a4,40(a5)
    switch(clock)
    80028e96:	02500793          	li	a5,37
    80028e9a:	3aa7e663          	bltu	a5,a0,80029246 <sysctl_clock_enable+0x3f4>
    80028e9e:	050a                	slli	a0,a0,0x2
    80028ea0:	00004717          	auipc	a4,0x4
    80028ea4:	4b070713          	addi	a4,a4,1200 # 8002d350 <function_config+0x6d8>
    80028ea8:	953a                	add	a0,a0,a4
    80028eaa:	411c                	lw	a5,0(a0)
    80028eac:	97ba                	add	a5,a5,a4
    80028eae:	8782                	jr	a5
                sysctl->clk_en_cent.apb1_clk_en = en;
    80028eb0:	000fd7b7          	lui	a5,0xfd
    80028eb4:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028eb8:	07ca                	slli	a5,a5,0x12
    80028eba:	5798                	lw	a4,40(a5)
    80028ebc:	01076713          	ori	a4,a4,16
    80028ec0:	d798                	sw	a4,40(a5)
                break;
    80028ec2:	bfd1                	j	80028e96 <sysctl_clock_enable+0x44>
                sysctl->clk_en_cent.apb2_clk_en = en;
    80028ec4:	000fd7b7          	lui	a5,0xfd
    80028ec8:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028ecc:	07ca                	slli	a5,a5,0x12
    80028ece:	5798                	lw	a4,40(a5)
    80028ed0:	02076713          	ori	a4,a4,32
    80028ed4:	d798                	sw	a4,40(a5)
                break;
    80028ed6:	b7c1                	j	80028e96 <sysctl_clock_enable+0x44>
            sysctl->pll0.pll_out_en0 = en;
    80028ed8:	000fd7b7          	lui	a5,0xfd
    80028edc:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028ee0:	07ca                	slli	a5,a5,0x12
    80028ee2:	4798                	lw	a4,8(a5)
    80028ee4:	020006b7          	lui	a3,0x2000
    80028ee8:	8f55                	or	a4,a4,a3
    80028eea:	c798                	sw	a4,8(a5)
        return -1;
    sysctl_clock_bus_en(clock, 1);
    sysctl_clock_device_en(clock, 1);
    return 0;
    80028eec:	4501                	li	a0,0
}
    80028eee:	6422                	ld	s0,8(sp)
    80028ef0:	0141                	addi	sp,sp,16
    80028ef2:	8082                	ret
            sysctl->pll1.pll_out_en1 = en;
    80028ef4:	000fd7b7          	lui	a5,0xfd
    80028ef8:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028efc:	07ca                	slli	a5,a5,0x12
    80028efe:	47d8                	lw	a4,12(a5)
    80028f00:	020006b7          	lui	a3,0x2000
    80028f04:	8f55                	or	a4,a4,a3
    80028f06:	c7d8                	sw	a4,12(a5)
    return 0;
    80028f08:	4501                	li	a0,0
    80028f0a:	b7d5                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->pll2.pll_out_en2 = en;
    80028f0c:	000fd7b7          	lui	a5,0xfd
    80028f10:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f14:	07ca                	slli	a5,a5,0x12
    80028f16:	4b98                	lw	a4,16(a5)
    80028f18:	020006b7          	lui	a3,0x2000
    80028f1c:	8f55                	or	a4,a4,a3
    80028f1e:	cb98                	sw	a4,16(a5)
    return 0;
    80028f20:	4501                	li	a0,0
    80028f22:	b7f1                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.cpu_clk_en = en;
    80028f24:	000fd7b7          	lui	a5,0xfd
    80028f28:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f2c:	07ca                	slli	a5,a5,0x12
    80028f2e:	5798                	lw	a4,40(a5)
    80028f30:	00176713          	ori	a4,a4,1
    80028f34:	d798                	sw	a4,40(a5)
    return 0;
    80028f36:	4501                	li	a0,0
    80028f38:	bf5d                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.sram0_clk_en = en;
    80028f3a:	000fd7b7          	lui	a5,0xfd
    80028f3e:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f42:	07ca                	slli	a5,a5,0x12
    80028f44:	5798                	lw	a4,40(a5)
    80028f46:	00276713          	ori	a4,a4,2
    80028f4a:	d798                	sw	a4,40(a5)
    return 0;
    80028f4c:	4501                	li	a0,0
    80028f4e:	b745                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.sram1_clk_en = en;
    80028f50:	000fd7b7          	lui	a5,0xfd
    80028f54:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f58:	07ca                	slli	a5,a5,0x12
    80028f5a:	5798                	lw	a4,40(a5)
    80028f5c:	00476713          	ori	a4,a4,4
    80028f60:	d798                	sw	a4,40(a5)
    return 0;
    80028f62:	4501                	li	a0,0
    80028f64:	b769                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb0_clk_en = en;
    80028f66:	000fd7b7          	lui	a5,0xfd
    80028f6a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f6e:	07ca                	slli	a5,a5,0x12
    80028f70:	5798                	lw	a4,40(a5)
    80028f72:	00876713          	ori	a4,a4,8
    80028f76:	d798                	sw	a4,40(a5)
    return 0;
    80028f78:	4501                	li	a0,0
    80028f7a:	bf95                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb1_clk_en = en;
    80028f7c:	000fd7b7          	lui	a5,0xfd
    80028f80:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f84:	07ca                	slli	a5,a5,0x12
    80028f86:	5798                	lw	a4,40(a5)
    80028f88:	01076713          	ori	a4,a4,16
    80028f8c:	d798                	sw	a4,40(a5)
    return 0;
    80028f8e:	4501                	li	a0,0
    80028f90:	bfb9                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb2_clk_en = en;
    80028f92:	000fd7b7          	lui	a5,0xfd
    80028f96:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f9a:	07ca                	slli	a5,a5,0x12
    80028f9c:	5798                	lw	a4,40(a5)
    80028f9e:	02076713          	ori	a4,a4,32
    80028fa2:	d798                	sw	a4,40(a5)
    return 0;
    80028fa4:	4501                	li	a0,0
    80028fa6:	b7a1                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.rom_clk_en = en;
    80028fa8:	000fd7b7          	lui	a5,0xfd
    80028fac:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fb0:	07ca                	slli	a5,a5,0x12
    80028fb2:	57d8                	lw	a4,44(a5)
    80028fb4:	00176713          	ori	a4,a4,1
    80028fb8:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fba:	4501                	li	a0,0
    80028fbc:	bf0d                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.dma_clk_en = en;
    80028fbe:	000fd7b7          	lui	a5,0xfd
    80028fc2:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fc6:	07ca                	slli	a5,a5,0x12
    80028fc8:	57d8                	lw	a4,44(a5)
    80028fca:	00276713          	ori	a4,a4,2
    80028fce:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fd0:	4501                	li	a0,0
    80028fd2:	bf31                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.ai_clk_en = en;
    80028fd4:	000fd7b7          	lui	a5,0xfd
    80028fd8:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fdc:	07ca                	slli	a5,a5,0x12
    80028fde:	57d8                	lw	a4,44(a5)
    80028fe0:	00476713          	ori	a4,a4,4
    80028fe4:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fe6:	4501                	li	a0,0
    80028fe8:	b719                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.dvp_clk_en = en;
    80028fea:	000fd7b7          	lui	a5,0xfd
    80028fee:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028ff2:	07ca                	slli	a5,a5,0x12
    80028ff4:	57d8                	lw	a4,44(a5)
    80028ff6:	00876713          	ori	a4,a4,8
    80028ffa:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ffc:	4501                	li	a0,0
    80028ffe:	bdc5                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.fft_clk_en = en;
    80029000:	000fd7b7          	lui	a5,0xfd
    80029004:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029008:	07ca                	slli	a5,a5,0x12
    8002900a:	57d8                	lw	a4,44(a5)
    8002900c:	01076713          	ori	a4,a4,16
    80029010:	d7d8                	sw	a4,44(a5)
    return 0;
    80029012:	4501                	li	a0,0
    80029014:	bde9                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi3_clk_en = en;
    80029016:	000fd7b7          	lui	a5,0xfd
    8002901a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002901e:	07ca                	slli	a5,a5,0x12
    80029020:	57d8                	lw	a4,44(a5)
    80029022:	20076713          	ori	a4,a4,512
    80029026:	d7d8                	sw	a4,44(a5)
    return 0;
    80029028:	4501                	li	a0,0
    8002902a:	b5d1                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.gpio_clk_en = en;
    8002902c:	000fd7b7          	lui	a5,0xfd
    80029030:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029034:	07ca                	slli	a5,a5,0x12
    80029036:	57d8                	lw	a4,44(a5)
    80029038:	02076713          	ori	a4,a4,32
    8002903c:	d7d8                	sw	a4,44(a5)
    return 0;
    8002903e:	4501                	li	a0,0
    80029040:	b57d                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi2_clk_en = en;
    80029042:	000fd7b7          	lui	a5,0xfd
    80029046:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002904a:	07ca                	slli	a5,a5,0x12
    8002904c:	57d8                	lw	a4,44(a5)
    8002904e:	10076713          	ori	a4,a4,256
    80029052:	d7d8                	sw	a4,44(a5)
    return 0;
    80029054:	4501                	li	a0,0
    80029056:	bd61                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s0_clk_en = en;
    80029058:	000fd7b7          	lui	a5,0xfd
    8002905c:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029060:	07ca                	slli	a5,a5,0x12
    80029062:	57d8                	lw	a4,44(a5)
    80029064:	40076713          	ori	a4,a4,1024
    80029068:	d7d8                	sw	a4,44(a5)
    return 0;
    8002906a:	4501                	li	a0,0
    8002906c:	b549                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s1_clk_en = en;
    8002906e:	000fd7b7          	lui	a5,0xfd
    80029072:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029076:	07ca                	slli	a5,a5,0x12
    80029078:	57d8                	lw	a4,44(a5)
    8002907a:	6685                	lui	a3,0x1
    8002907c:	80068693          	addi	a3,a3,-2048 # 800 <BASE_ADDRESS-0x8001f800>
    80029080:	8f55                	or	a4,a4,a3
    80029082:	d7d8                	sw	a4,44(a5)
    return 0;
    80029084:	4501                	li	a0,0
    80029086:	b5a5                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s2_clk_en = en;
    80029088:	000fd7b7          	lui	a5,0xfd
    8002908c:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029090:	07ca                	slli	a5,a5,0x12
    80029092:	57d8                	lw	a4,44(a5)
    80029094:	6685                	lui	a3,0x1
    80029096:	8f55                	or	a4,a4,a3
    80029098:	d7d8                	sw	a4,44(a5)
    return 0;
    8002909a:	4501                	li	a0,0
    8002909c:	bd89                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c0_clk_en = en;
    8002909e:	000fd7b7          	lui	a5,0xfd
    800290a2:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290a6:	07ca                	slli	a5,a5,0x12
    800290a8:	57d8                	lw	a4,44(a5)
    800290aa:	6689                	lui	a3,0x2
    800290ac:	8f55                	or	a4,a4,a3
    800290ae:	d7d8                	sw	a4,44(a5)
    return 0;
    800290b0:	4501                	li	a0,0
    800290b2:	bd35                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c1_clk_en = en;
    800290b4:	000fd7b7          	lui	a5,0xfd
    800290b8:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290bc:	07ca                	slli	a5,a5,0x12
    800290be:	57d8                	lw	a4,44(a5)
    800290c0:	6691                	lui	a3,0x4
    800290c2:	8f55                	or	a4,a4,a3
    800290c4:	d7d8                	sw	a4,44(a5)
    return 0;
    800290c6:	4501                	li	a0,0
    800290c8:	b51d                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c2_clk_en = en;
    800290ca:	000fd7b7          	lui	a5,0xfd
    800290ce:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290d2:	07ca                	slli	a5,a5,0x12
    800290d4:	57d8                	lw	a4,44(a5)
    800290d6:	66a1                	lui	a3,0x8
    800290d8:	8f55                	or	a4,a4,a3
    800290da:	d7d8                	sw	a4,44(a5)
    return 0;
    800290dc:	4501                	li	a0,0
    800290de:	bd01                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart1_clk_en = en;
    800290e0:	000fd7b7          	lui	a5,0xfd
    800290e4:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290e8:	07ca                	slli	a5,a5,0x12
    800290ea:	57d8                	lw	a4,44(a5)
    800290ec:	66c1                	lui	a3,0x10
    800290ee:	8f55                	or	a4,a4,a3
    800290f0:	d7d8                	sw	a4,44(a5)
    return 0;
    800290f2:	4501                	li	a0,0
    800290f4:	bbed                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart2_clk_en = en;
    800290f6:	000fd7b7          	lui	a5,0xfd
    800290fa:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290fe:	07ca                	slli	a5,a5,0x12
    80029100:	57d8                	lw	a4,44(a5)
    80029102:	000206b7          	lui	a3,0x20
    80029106:	8f55                	or	a4,a4,a3
    80029108:	d7d8                	sw	a4,44(a5)
    return 0;
    8002910a:	4501                	li	a0,0
    8002910c:	b3cd                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart3_clk_en = en;
    8002910e:	000fd7b7          	lui	a5,0xfd
    80029112:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029116:	07ca                	slli	a5,a5,0x12
    80029118:	57d8                	lw	a4,44(a5)
    8002911a:	000406b7          	lui	a3,0x40
    8002911e:	8f55                	or	a4,a4,a3
    80029120:	d7d8                	sw	a4,44(a5)
    return 0;
    80029122:	4501                	li	a0,0
    80029124:	b3e9                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.fpioa_clk_en = en;
    80029126:	000fd7b7          	lui	a5,0xfd
    8002912a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002912e:	07ca                	slli	a5,a5,0x12
    80029130:	57d8                	lw	a4,44(a5)
    80029132:	001006b7          	lui	a3,0x100
    80029136:	8f55                	or	a4,a4,a3
    80029138:	d7d8                	sw	a4,44(a5)
    return 0;
    8002913a:	4501                	li	a0,0
    8002913c:	bb4d                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer0_clk_en = en;
    8002913e:	000fd7b7          	lui	a5,0xfd
    80029142:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029146:	07ca                	slli	a5,a5,0x12
    80029148:	57d8                	lw	a4,44(a5)
    8002914a:	002006b7          	lui	a3,0x200
    8002914e:	8f55                	or	a4,a4,a3
    80029150:	d7d8                	sw	a4,44(a5)
    return 0;
    80029152:	4501                	li	a0,0
    80029154:	bb69                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer1_clk_en = en;
    80029156:	000fd7b7          	lui	a5,0xfd
    8002915a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002915e:	07ca                	slli	a5,a5,0x12
    80029160:	57d8                	lw	a4,44(a5)
    80029162:	004006b7          	lui	a3,0x400
    80029166:	8f55                	or	a4,a4,a3
    80029168:	d7d8                	sw	a4,44(a5)
    return 0;
    8002916a:	4501                	li	a0,0
    8002916c:	b349                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer2_clk_en = en;
    8002916e:	000fd7b7          	lui	a5,0xfd
    80029172:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029176:	07ca                	slli	a5,a5,0x12
    80029178:	57d8                	lw	a4,44(a5)
    8002917a:	008006b7          	lui	a3,0x800
    8002917e:	8f55                	or	a4,a4,a3
    80029180:	d7d8                	sw	a4,44(a5)
    return 0;
    80029182:	4501                	li	a0,0
    80029184:	b3ad                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.sha_clk_en = en;
    80029186:	000fd7b7          	lui	a5,0xfd
    8002918a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002918e:	07ca                	slli	a5,a5,0x12
    80029190:	57d8                	lw	a4,44(a5)
    80029192:	040006b7          	lui	a3,0x4000
    80029196:	8f55                	or	a4,a4,a3
    80029198:	d7d8                	sw	a4,44(a5)
    return 0;
    8002919a:	4501                	li	a0,0
    8002919c:	bb89                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.aes_clk_en = en;
    8002919e:	000fd7b7          	lui	a5,0xfd
    800291a2:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800291a6:	07ca                	slli	a5,a5,0x12
    800291a8:	57d8                	lw	a4,44(a5)
    800291aa:	000806b7          	lui	a3,0x80
    800291ae:	8f55                	or	a4,a4,a3
    800291b0:	d7d8                	sw	a4,44(a5)
    return 0;
    800291b2:	4501                	li	a0,0
    800291b4:	bb2d                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.wdt0_clk_en = en;
    800291b6:	000fd7b7          	lui	a5,0xfd
    800291ba:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800291be:	07ca                	slli	a5,a5,0x12
    800291c0:	57d8                	lw	a4,44(a5)
    800291c2:	010006b7          	lui	a3,0x1000
    800291c6:	8f55                	or	a4,a4,a3
    800291c8:	d7d8                	sw	a4,44(a5)
    return 0;
    800291ca:	4501                	li	a0,0
    800291cc:	b30d                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.wdt1_clk_en = en;
    800291ce:	000fd7b7          	lui	a5,0xfd
    800291d2:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800291d6:	07ca                	slli	a5,a5,0x12
    800291d8:	57d8                	lw	a4,44(a5)
    800291da:	020006b7          	lui	a3,0x2000
    800291de:	8f55                	or	a4,a4,a3
    800291e0:	d7d8                	sw	a4,44(a5)
    return 0;
    800291e2:	4501                	li	a0,0
    800291e4:	b329                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.otp_clk_en = en;
    800291e6:	000fd7b7          	lui	a5,0xfd
    800291ea:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800291ee:	07ca                	slli	a5,a5,0x12
    800291f0:	57d8                	lw	a4,44(a5)
    800291f2:	080006b7          	lui	a3,0x8000
    800291f6:	8f55                	or	a4,a4,a3
    800291f8:	d7d8                	sw	a4,44(a5)
    return 0;
    800291fa:	4501                	li	a0,0
    800291fc:	b9cd                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.rtc_clk_en = en;
    800291fe:	000fd7b7          	lui	a5,0xfd
    80029202:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029206:	07ca                	slli	a5,a5,0x12
    80029208:	57d8                	lw	a4,44(a5)
    8002920a:	200006b7          	lui	a3,0x20000
    8002920e:	8f55                	or	a4,a4,a3
    80029210:	d7d8                	sw	a4,44(a5)
    return 0;
    80029212:	4501                	li	a0,0
    80029214:	b9e9                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi0_clk_en = en;
    80029216:	000fd7b7          	lui	a5,0xfd
    8002921a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002921e:	07ca                	slli	a5,a5,0x12
    80029220:	57d8                	lw	a4,44(a5)
    80029222:	04076713          	ori	a4,a4,64
    80029226:	d7d8                	sw	a4,44(a5)
    return 0;
    80029228:	4501                	li	a0,0
    8002922a:	b1d1                	j	80028eee <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi1_clk_en = en;
    8002922c:	000fd7b7          	lui	a5,0xfd
    80029230:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029234:	07ca                	slli	a5,a5,0x12
    80029236:	57d8                	lw	a4,44(a5)
    80029238:	08076713          	ori	a4,a4,128
    8002923c:	d7d8                	sw	a4,44(a5)
    return 0;
    8002923e:	4501                	li	a0,0
    80029240:	b17d                	j	80028eee <sysctl_clock_enable+0x9c>
        return -1;
    80029242:	557d                	li	a0,-1
    80029244:	b16d                	j	80028eee <sysctl_clock_enable+0x9c>
    return 0;
    80029246:	4501                	li	a0,0
    80029248:	b15d                	j	80028eee <sysctl_clock_enable+0x9c>

000000008002924a <sysctl_dma_select>:

int sysctl_dma_select(sysctl_dma_channel_t channel, sysctl_dma_select_t select)
{
    8002924a:	1141                	addi	sp,sp,-16
    8002924c:	e422                	sd	s0,8(sp)
    8002924e:	0800                	addi	s0,sp,16
    sysctl_dma_sel0_t dma_sel0;
    sysctl_dma_sel1_t dma_sel1;

    /* Read register from bus */
    dma_sel0 = sysctl->dma_sel0;
    80029250:	000fd637          	lui	a2,0xfd
    80029254:	41160613          	addi	a2,a2,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029258:	064a                	slli	a2,a2,0x12
    8002925a:	5274                	lw	a3,100(a2)
    8002925c:	0186d81b          	srliw	a6,a3,0x18
    dma_sel1 = sysctl->dma_sel1;
    80029260:	5630                	lw	a2,104(a2)
    switch(channel)
    80029262:	4e95                	li	t4,5
    80029264:	0aaeee63          	bltu	t4,a0,80029320 <sysctl_dma_select+0xd6>
    80029268:	03f6f793          	andi	a5,a3,63
    8002926c:	0066d71b          	srliw	a4,a3,0x6
    80029270:	03f77713          	andi	a4,a4,63
    80029274:	00c6d31b          	srliw	t1,a3,0xc
    80029278:	03f37313          	andi	t1,t1,63
    8002927c:	0126d89b          	srliw	a7,a3,0x12
    80029280:	03f8f893          	andi	a7,a7,63
    80029284:	03f87813          	andi	a6,a6,63
    80029288:	03f67e13          	andi	t3,a2,63
    8002928c:	050a                	slli	a0,a0,0x2
    8002928e:	00004e97          	auipc	t4,0x4
    80029292:	15ae8e93          	addi	t4,t4,346 # 8002d3e8 <function_config+0x770>
    80029296:	9576                	add	a0,a0,t4
    80029298:	4108                	lw	a0,0(a0)
    8002929a:	9576                	add	a0,a0,t4
    8002929c:	8502                	jr	a0
    {
        case SYSCTL_DMA_CHANNEL_0:
            dma_sel0.dma_sel0 = select;
    8002929e:	03f5f793          	andi	a5,a1,63
        default:
            return -1;
    }

    /* Write register back to bus */
    sysctl->dma_sel0 = dma_sel0;
    800292a2:	fc06f693          	andi	a3,a3,-64
    800292a6:	8edd                	or	a3,a3,a5
    800292a8:	0067179b          	slliw	a5,a4,0x6
    800292ac:	777d                	lui	a4,0xfffff
    800292ae:	03f70713          	addi	a4,a4,63 # fffffffffffff03f <kernel_end+0xffffffff7ffb903f>
    800292b2:	8f75                	and	a4,a4,a3
    800292b4:	8f5d                	or	a4,a4,a5
    800292b6:	00c3179b          	slliw	a5,t1,0xc
    800292ba:	fffc16b7          	lui	a3,0xfffc1
    800292be:	16fd                	addi	a3,a3,-1
    800292c0:	8f75                	and	a4,a4,a3
    800292c2:	8f5d                	or	a4,a4,a5
    800292c4:	0128989b          	slliw	a7,a7,0x12
    800292c8:	ff0407b7          	lui	a5,0xff040
    800292cc:	17fd                	addi	a5,a5,-1
    800292ce:	8ff9                	and	a5,a5,a4
    800292d0:	0117e7b3          	or	a5,a5,a7
    800292d4:	0188181b          	slliw	a6,a6,0x18
    800292d8:	c1000737          	lui	a4,0xc1000
    800292dc:	177d                	addi	a4,a4,-1
    800292de:	8ff9                	and	a5,a5,a4
    800292e0:	0107e7b3          	or	a5,a5,a6
    800292e4:	000fd737          	lui	a4,0xfd
    800292e8:	41170713          	addi	a4,a4,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800292ec:	074a                	slli	a4,a4,0x12
    800292ee:	d37c                	sw	a5,100(a4)
    sysctl->dma_sel1 = dma_sel1;
    800292f0:	fc067613          	andi	a2,a2,-64
    800292f4:	00ce6633          	or	a2,t3,a2
    800292f8:	d730                	sw	a2,104(a4)

    return 0;
    800292fa:	4501                	li	a0,0
}
    800292fc:	6422                	ld	s0,8(sp)
    800292fe:	0141                	addi	sp,sp,16
    80029300:	8082                	ret
            dma_sel0.dma_sel1 = select;
    80029302:	03f5f713          	andi	a4,a1,63
            break;
    80029306:	bf71                	j	800292a2 <sysctl_dma_select+0x58>
            dma_sel0.dma_sel2 = select;
    80029308:	03f5f313          	andi	t1,a1,63
            break;
    8002930c:	bf59                	j	800292a2 <sysctl_dma_select+0x58>
            dma_sel0.dma_sel3 = select;
    8002930e:	03f5f893          	andi	a7,a1,63
            break;
    80029312:	bf41                	j	800292a2 <sysctl_dma_select+0x58>
            dma_sel0.dma_sel4 = select;
    80029314:	03f5f813          	andi	a6,a1,63
            break;
    80029318:	b769                	j	800292a2 <sysctl_dma_select+0x58>
            dma_sel1.dma_sel5 = select;
    8002931a:	03f5fe13          	andi	t3,a1,63
            break;
    8002931e:	b751                	j	800292a2 <sysctl_dma_select+0x58>
            return -1;
    80029320:	557d                	li	a0,-1
    80029322:	bfe9                	j	800292fc <sysctl_dma_select+0xb2>
	...

000000008002a000 <_trampoline>:
    8002a000:	14051573          	csrrw	a0,sscratch,a0
    8002a004:	02153423          	sd	ra,40(a0)
    8002a008:	02253823          	sd	sp,48(a0)
    8002a00c:	02353c23          	sd	gp,56(a0)
    8002a010:	04453023          	sd	tp,64(a0)
    8002a014:	04553423          	sd	t0,72(a0)
    8002a018:	04653823          	sd	t1,80(a0)
    8002a01c:	04753c23          	sd	t2,88(a0)
    8002a020:	f120                	sd	s0,96(a0)
    8002a022:	f524                	sd	s1,104(a0)
    8002a024:	fd2c                	sd	a1,120(a0)
    8002a026:	e150                	sd	a2,128(a0)
    8002a028:	e554                	sd	a3,136(a0)
    8002a02a:	e958                	sd	a4,144(a0)
    8002a02c:	ed5c                	sd	a5,152(a0)
    8002a02e:	0b053023          	sd	a6,160(a0)
    8002a032:	0b153423          	sd	a7,168(a0)
    8002a036:	0b253823          	sd	s2,176(a0)
    8002a03a:	0b353c23          	sd	s3,184(a0)
    8002a03e:	0d453023          	sd	s4,192(a0)
    8002a042:	0d553423          	sd	s5,200(a0)
    8002a046:	0d653823          	sd	s6,208(a0)
    8002a04a:	0d753c23          	sd	s7,216(a0)
    8002a04e:	0f853023          	sd	s8,224(a0)
    8002a052:	0f953423          	sd	s9,232(a0)
    8002a056:	0fa53823          	sd	s10,240(a0)
    8002a05a:	0fb53c23          	sd	s11,248(a0)
    8002a05e:	11c53023          	sd	t3,256(a0)
    8002a062:	11d53423          	sd	t4,264(a0)
    8002a066:	11e53823          	sd	t5,272(a0)
    8002a06a:	11f53c23          	sd	t6,280(a0)
    8002a06e:	140022f3          	csrr	t0,sscratch
    8002a072:	06553823          	sd	t0,112(a0)
    8002a076:	00853103          	ld	sp,8(a0)
    8002a07a:	02053203          	ld	tp,32(a0)
    8002a07e:	01053283          	ld	t0,16(a0)
    8002a082:	00053303          	ld	t1,0(a0)
    8002a086:	18031073          	csrw	satp,t1
    8002a08a:	12000073          	sfence.vma
    8002a08e:	8282                	jr	t0

000000008002a090 <userret>:
    8002a090:	18059073          	csrw	satp,a1
    8002a094:	12000073          	sfence.vma
    8002a098:	07053283          	ld	t0,112(a0)
    8002a09c:	14029073          	csrw	sscratch,t0
    8002a0a0:	02853083          	ld	ra,40(a0)
    8002a0a4:	03053103          	ld	sp,48(a0)
    8002a0a8:	03853183          	ld	gp,56(a0)
    8002a0ac:	04053203          	ld	tp,64(a0)
    8002a0b0:	04853283          	ld	t0,72(a0)
    8002a0b4:	05053303          	ld	t1,80(a0)
    8002a0b8:	05853383          	ld	t2,88(a0)
    8002a0bc:	7120                	ld	s0,96(a0)
    8002a0be:	7524                	ld	s1,104(a0)
    8002a0c0:	7d2c                	ld	a1,120(a0)
    8002a0c2:	6150                	ld	a2,128(a0)
    8002a0c4:	6554                	ld	a3,136(a0)
    8002a0c6:	6958                	ld	a4,144(a0)
    8002a0c8:	6d5c                	ld	a5,152(a0)
    8002a0ca:	0a053803          	ld	a6,160(a0)
    8002a0ce:	0a853883          	ld	a7,168(a0)
    8002a0d2:	0b053903          	ld	s2,176(a0)
    8002a0d6:	0b853983          	ld	s3,184(a0)
    8002a0da:	0c053a03          	ld	s4,192(a0)
    8002a0de:	0c853a83          	ld	s5,200(a0)
    8002a0e2:	0d053b03          	ld	s6,208(a0)
    8002a0e6:	0d853b83          	ld	s7,216(a0)
    8002a0ea:	0e053c03          	ld	s8,224(a0)
    8002a0ee:	0e853c83          	ld	s9,232(a0)
    8002a0f2:	0f053d03          	ld	s10,240(a0)
    8002a0f6:	0f853d83          	ld	s11,248(a0)
    8002a0fa:	10053e03          	ld	t3,256(a0)
    8002a0fe:	10853e83          	ld	t4,264(a0)
    8002a102:	11053f03          	ld	t5,272(a0)
    8002a106:	11853f83          	ld	t6,280(a0)
    8002a10a:	14051573          	csrrw	a0,sscratch,a0
    8002a10e:	10200073          	sret
	...
