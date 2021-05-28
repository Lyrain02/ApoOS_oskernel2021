
target/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080020000 <_start>:
    80020000:	00150293          	addi	t0,a0,1
    80020004:	02ba                	slli	t0,t0,0xe
    80020006:	0000e117          	auipc	sp,0xe
    8002000a:	ffa10113          	addi	sp,sp,-6 # 8002e000 <boot_stack>
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
    800200a4:	c82080e7          	jalr	-894(ra) # 80026d22 <consputc>
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
    800200d2:	c54080e7          	jalr	-940(ra) # 80026d22 <consputc>
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
    8002011c:	40098993          	addi	s3,s3,1024 # 8002b518 <states.1738+0xb0>
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
    80020170:	06c50513          	addi	a0,a0,108 # 8002c1d8 <syscalls+0x870>
    80020174:	00000097          	auipc	ra,0x0
    80020178:	01c080e7          	jalr	28(ra) # 80020190 <printf>
  backtrace();
    8002017c:	00000097          	auipc	ra,0x0
    80020180:	f6a080e7          	jalr	-150(ra) # 800200e6 <backtrace>
  panicked = 1; // freeze uart output from other CPUs
    80020184:	4785                	li	a5,1
    80020186:	00016717          	auipc	a4,0x16
    8002018a:	e8f72d23          	sw	a5,-358(a4) # 80036020 <panicked>
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
    800201c2:	00016797          	auipc	a5,0x16
    800201c6:	e3e78793          	addi	a5,a5,-450 # 80036000 <boot_stack_top>
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
    80020224:	b02080e7          	jalr	-1278(ra) # 80026d22 <consputc>
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
    800202b8:	a6e080e7          	jalr	-1426(ra) # 80026d22 <consputc>
  consputc('x');
    800202bc:	07800513          	li	a0,120
    800202c0:	00007097          	auipc	ra,0x7
    800202c4:	a62080e7          	jalr	-1438(ra) # 80026d22 <consputc>
    800202c8:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800202ca:	03c9d793          	srli	a5,s3,0x3c
    800202ce:	97de                	add	a5,a5,s7
    800202d0:	0007c503          	lbu	a0,0(a5)
    800202d4:	00007097          	auipc	ra,0x7
    800202d8:	a4e080e7          	jalr	-1458(ra) # 80026d22 <consputc>
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
    80020304:	a22080e7          	jalr	-1502(ra) # 80026d22 <consputc>
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
    80020326:	a00080e7          	jalr	-1536(ra) # 80026d22 <consputc>
      break;
    8002032a:	bdfd                	j	80020228 <printf+0x98>
      consputc('%');
    8002032c:	8552                	mv	a0,s4
    8002032e:	00007097          	auipc	ra,0x7
    80020332:	9f4080e7          	jalr	-1548(ra) # 80026d22 <consputc>
      consputc(c);
    80020336:	854a                	mv	a0,s2
    80020338:	00007097          	auipc	ra,0x7
    8002033c:	9ea080e7          	jalr	-1558(ra) # 80026d22 <consputc>
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
    80020364:	00016517          	auipc	a0,0x16
    80020368:	c9c50513          	addi	a0,a0,-868 # 80036000 <boot_stack_top>
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
    80020380:	00016497          	auipc	s1,0x16
    80020384:	c8048493          	addi	s1,s1,-896 # 80036000 <boot_stack_top>
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
    8002044c:	00025797          	auipc	a5,0x25
    80020450:	bb478793          	addi	a5,a5,-1100 # 80045000 <kernel_end>
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
    8002046e:	00016917          	auipc	s2,0x16
    80020472:	bba90913          	addi	s2,s2,-1094 # 80036028 <kmem>
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
    80020510:	00016497          	auipc	s1,0x16
    80020514:	b1848493          	addi	s1,s1,-1256 # 80036028 <kmem>
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
    80020538:	00025517          	auipc	a0,0x25
    8002053c:	ac850513          	addi	a0,a0,-1336 # 80045000 <kernel_end>
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
    8002055c:	00016497          	auipc	s1,0x16
    80020560:	acc48493          	addi	s1,s1,-1332 # 80036028 <kmem>
    80020564:	8526                	mv	a0,s1
    80020566:	00000097          	auipc	ra,0x0
    8002056a:	15a080e7          	jalr	346(ra) # 800206c0 <acquire>
  r = kmem.freelist;
    8002056e:	6c84                	ld	s1,24(s1)
  if(r) {
    80020570:	c89d                	beqz	s1,800205a6 <kalloc+0x54>
    kmem.freelist = r->next;
    80020572:	609c                	ld	a5,0(s1)
    80020574:	00016517          	auipc	a0,0x16
    80020578:	ab450513          	addi	a0,a0,-1356 # 80036028 <kmem>
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
    800205a6:	00016517          	auipc	a0,0x16
    800205aa:	a8250513          	addi	a0,a0,-1406 # 80036028 <kmem>
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
    800205be:	00016797          	auipc	a5,0x16
    800205c2:	a6a78793          	addi	a5,a5,-1430 # 80036028 <kmem>
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
    800205ec:	54e080e7          	jalr	1358(ra) # 80021b36 <mycpu>
    800205f0:	5d3c                	lw	a5,120(a0)
    800205f2:	cf89                	beqz	a5,8002060c <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800205f4:	00001097          	auipc	ra,0x1
    800205f8:	542080e7          	jalr	1346(ra) # 80021b36 <mycpu>
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
    80020610:	52a080e7          	jalr	1322(ra) # 80021b36 <mycpu>
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
    80020628:	512080e7          	jalr	1298(ra) # 80021b36 <mycpu>
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
    800206aa:	490080e7          	jalr	1168(ra) # 80021b36 <mycpu>
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
    800206f4:	446080e7          	jalr	1094(ra) # 80021b36 <mycpu>
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
    80020a28:	00015717          	auipc	a4,0x15
    80020a2c:	62870713          	addi	a4,a4,1576 # 80036050 <started>
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
    80020a40:	0ee080e7          	jalr	238(ra) # 80020b2a <kvminithart>
    trapinithart();
    80020a44:	00002097          	auipc	ra,0x2
    80020a48:	da4080e7          	jalr	-604(ra) # 800227e8 <trapinithart>
    plicinithart();  // ask PLIC for device interrupts
    80020a4c:	00006097          	auipc	ra,0x6
    80020a50:	0aa080e7          	jalr	170(ra) # 80026af6 <plicinithart>
    printf("hart 1 init done\n");
    80020a54:	0000b517          	auipc	a0,0xb
    80020a58:	8a450513          	addi	a0,a0,-1884 # 8002b2f8 <etext+0x2f8>
    80020a5c:	fffff097          	auipc	ra,0xfffff
    80020a60:	734080e7          	jalr	1844(ra) # 80020190 <printf>
  }
  scheduler();
    80020a64:	00001097          	auipc	ra,0x1
    80020a68:	676080e7          	jalr	1654(ra) # 800220da <scheduler>
    consoleinit();
    80020a6c:	00006097          	auipc	ra,0x6
    80020a70:	478080e7          	jalr	1144(ra) # 80026ee4 <consoleinit>
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
    80020a90:	2ea080e7          	jalr	746(ra) # 80020d76 <kvminit>
    kvminithart();   // turn on paging
    80020a94:	00000097          	auipc	ra,0x0
    80020a98:	096080e7          	jalr	150(ra) # 80020b2a <kvminithart>
    timerinit();     // init a lock for timer
    80020a9c:	00004097          	auipc	ra,0x4
    80020aa0:	602080e7          	jalr	1538(ra) # 8002509e <timerinit>
    trapinithart();  // install kernel trap vector, including interrupt handler
    80020aa4:	00002097          	auipc	ra,0x2
    80020aa8:	d44080e7          	jalr	-700(ra) # 800227e8 <trapinithart>
    procinit();
    80020aac:	00001097          	auipc	ra,0x1
    80020ab0:	004080e7          	jalr	4(ra) # 80021ab0 <procinit>
    plicinit();
    80020ab4:	00006097          	auipc	ra,0x6
    80020ab8:	028080e7          	jalr	40(ra) # 80026adc <plicinit>
    plicinithart();
    80020abc:	00006097          	auipc	ra,0x6
    80020ac0:	03a080e7          	jalr	58(ra) # 80026af6 <plicinithart>
    fpioa_pin_init();
    80020ac4:	00007097          	auipc	ra,0x7
    80020ac8:	368080e7          	jalr	872(ra) # 80027e2c <fpioa_pin_init>
    dmac_init();
    80020acc:	00008097          	auipc	ra,0x8
    80020ad0:	fec080e7          	jalr	-20(ra) # 80028ab8 <dmac_init>
    disk_init();
    80020ad4:	00004097          	auipc	ra,0x4
    80020ad8:	666080e7          	jalr	1638(ra) # 8002513a <disk_init>
    binit();         // buffer cache
    80020adc:	00003097          	auipc	ra,0x3
    80020ae0:	914080e7          	jalr	-1772(ra) # 800233f0 <binit>
    fileinit();      // file table
    80020ae4:	00003097          	auipc	ra,0x3
    80020ae8:	d2a080e7          	jalr	-726(ra) # 8002380e <fileinit>
    userinit();      // first user process
    80020aec:	00001097          	auipc	ra,0x1
    80020af0:	376080e7          	jalr	886(ra) # 80021e62 <userinit>
    printf("hart 0 init done\n");
    80020af4:	0000a517          	auipc	a0,0xa
    80020af8:	7ec50513          	addi	a0,a0,2028 # 8002b2e0 <etext+0x2e0>
    80020afc:	fffff097          	auipc	ra,0xfffff
    80020b00:	694080e7          	jalr	1684(ra) # 80020190 <printf>
      unsigned long mask = 1 << i;
    80020b04:	4789                	li	a5,2
    80020b06:	fef43423          	sd	a5,-24(s0)
	SBI_CALL_0(SBI_CLEAR_IPI);
}

static inline void sbi_send_ipi(const unsigned long *hart_mask)
{
	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
    80020b0a:	fe840513          	addi	a0,s0,-24
    80020b0e:	4581                	li	a1,0
    80020b10:	4601                	li	a2,0
    80020b12:	4681                	li	a3,0
    80020b14:	4891                	li	a7,4
    80020b16:	00000073          	ecall
    __sync_synchronize();
    80020b1a:	0ff0000f          	fence
    started = 1;
    80020b1e:	4785                	li	a5,1
    80020b20:	00015717          	auipc	a4,0x15
    80020b24:	52f72823          	sw	a5,1328(a4) # 80036050 <started>
    80020b28:	bf35                	j	80020a64 <main+0x4a>

0000000080020b2a <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80020b2a:	1141                	addi	sp,sp,-16
    80020b2c:	e422                	sd	s0,8(sp)
    80020b2e:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80020b30:	00015797          	auipc	a5,0x15
    80020b34:	52878793          	addi	a5,a5,1320 # 80036058 <kernel_pagetable>
    80020b38:	639c                	ld	a5,0(a5)
    80020b3a:	83b1                	srli	a5,a5,0xc
    80020b3c:	577d                	li	a4,-1
    80020b3e:	177e                	slli	a4,a4,0x3f
    80020b40:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80020b42:	18079073          	csrw	satp,a5
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  // asm volatile("sfence.vma zero, zero");
  asm volatile("sfence.vma");
    80020b46:	12000073          	sfence.vma
  // reg_info();
  sfence_vma();
  #ifdef DEBUG
  printf("kvminithart\n");
  #endif
}
    80020b4a:	6422                	ld	s0,8(sp)
    80020b4c:	0141                	addi	sp,sp,16
    80020b4e:	8082                	ret

0000000080020b50 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80020b50:	7139                	addi	sp,sp,-64
    80020b52:	fc06                	sd	ra,56(sp)
    80020b54:	f822                	sd	s0,48(sp)
    80020b56:	f426                	sd	s1,40(sp)
    80020b58:	f04a                	sd	s2,32(sp)
    80020b5a:	ec4e                	sd	s3,24(sp)
    80020b5c:	e852                	sd	s4,16(sp)
    80020b5e:	e456                	sd	s5,8(sp)
    80020b60:	e05a                	sd	s6,0(sp)
    80020b62:	0080                	addi	s0,sp,64
    80020b64:	84aa                	mv	s1,a0
    80020b66:	89ae                	mv	s3,a1
    80020b68:	8b32                	mv	s6,a2
  
  if(va >= MAXVA)
    80020b6a:	57fd                	li	a5,-1
    80020b6c:	83e9                	srli	a5,a5,0x1a
    80020b6e:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80020b70:	4ab1                	li	s5,12
  if(va >= MAXVA)
    80020b72:	04b7f263          	bgeu	a5,a1,80020bb6 <walk+0x66>
    panic("walk");
    80020b76:	0000a517          	auipc	a0,0xa
    80020b7a:	79a50513          	addi	a0,a0,1946 # 8002b310 <etext+0x310>
    80020b7e:	fffff097          	auipc	ra,0xfffff
    80020b82:	5c8080e7          	jalr	1480(ra) # 80020146 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == NULL)
    80020b86:	060b0663          	beqz	s6,80020bf2 <walk+0xa2>
    80020b8a:	00000097          	auipc	ra,0x0
    80020b8e:	9c8080e7          	jalr	-1592(ra) # 80020552 <kalloc>
    80020b92:	84aa                	mv	s1,a0
    80020b94:	c529                	beqz	a0,80020bde <walk+0x8e>
        return NULL;
      memset(pagetable, 0, PGSIZE);
    80020b96:	6605                	lui	a2,0x1
    80020b98:	4581                	li	a1,0
    80020b9a:	00000097          	auipc	ra,0x0
    80020b9e:	bc2080e7          	jalr	-1086(ra) # 8002075c <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80020ba2:	00c4d793          	srli	a5,s1,0xc
    80020ba6:	07aa                	slli	a5,a5,0xa
    80020ba8:	0017e793          	ori	a5,a5,1
    80020bac:	00f93023          	sd	a5,0(s2)
    80020bb0:	3a5d                	addiw	s4,s4,-9
  for(int level = 2; level > 0; level--) {
    80020bb2:	035a0063          	beq	s4,s5,80020bd2 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80020bb6:	0149d933          	srl	s2,s3,s4
    80020bba:	1ff97913          	andi	s2,s2,511
    80020bbe:	090e                	slli	s2,s2,0x3
    80020bc0:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80020bc2:	00093483          	ld	s1,0(s2)
    80020bc6:	0014f793          	andi	a5,s1,1
    80020bca:	dfd5                	beqz	a5,80020b86 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80020bcc:	80a9                	srli	s1,s1,0xa
    80020bce:	04b2                	slli	s1,s1,0xc
    80020bd0:	b7c5                	j	80020bb0 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80020bd2:	00c9d513          	srli	a0,s3,0xc
    80020bd6:	1ff57513          	andi	a0,a0,511
    80020bda:	050e                	slli	a0,a0,0x3
    80020bdc:	9526                	add	a0,a0,s1
}
    80020bde:	70e2                	ld	ra,56(sp)
    80020be0:	7442                	ld	s0,48(sp)
    80020be2:	74a2                	ld	s1,40(sp)
    80020be4:	7902                	ld	s2,32(sp)
    80020be6:	69e2                	ld	s3,24(sp)
    80020be8:	6a42                	ld	s4,16(sp)
    80020bea:	6aa2                	ld	s5,8(sp)
    80020bec:	6b02                	ld	s6,0(sp)
    80020bee:	6121                	addi	sp,sp,64
    80020bf0:	8082                	ret
        return NULL;
    80020bf2:	4501                	li	a0,0
    80020bf4:	b7ed                	j	80020bde <walk+0x8e>

0000000080020bf6 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80020bf6:	57fd                	li	a5,-1
    80020bf8:	83e9                	srli	a5,a5,0x1a
    80020bfa:	00b7f463          	bgeu	a5,a1,80020c02 <walkaddr+0xc>
    return NULL;
    80020bfe:	4501                	li	a0,0
    return NULL;
  if((*pte & PTE_U) == 0)
    return NULL;
  pa = PTE2PA(*pte);
  return pa;
}
    80020c00:	8082                	ret
{
    80020c02:	1141                	addi	sp,sp,-16
    80020c04:	e406                	sd	ra,8(sp)
    80020c06:	e022                	sd	s0,0(sp)
    80020c08:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80020c0a:	4601                	li	a2,0
    80020c0c:	00000097          	auipc	ra,0x0
    80020c10:	f44080e7          	jalr	-188(ra) # 80020b50 <walk>
  if(pte == 0)
    80020c14:	c105                	beqz	a0,80020c34 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80020c16:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80020c18:	0117f693          	andi	a3,a5,17
    80020c1c:	4745                	li	a4,17
    return NULL;
    80020c1e:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80020c20:	00e68663          	beq	a3,a4,80020c2c <walkaddr+0x36>
}
    80020c24:	60a2                	ld	ra,8(sp)
    80020c26:	6402                	ld	s0,0(sp)
    80020c28:	0141                	addi	sp,sp,16
    80020c2a:	8082                	ret
  pa = PTE2PA(*pte);
    80020c2c:	00a7d513          	srli	a0,a5,0xa
    80020c30:	0532                	slli	a0,a0,0xc
  return pa;
    80020c32:	bfcd                	j	80020c24 <walkaddr+0x2e>
    return NULL;
    80020c34:	4501                	li	a0,0
    80020c36:	b7fd                	j	80020c24 <walkaddr+0x2e>

0000000080020c38 <kwalkaddr>:
  return kwalkaddr(kernel_pagetable, va);
}

uint64
kwalkaddr(pagetable_t kpt, uint64 va)
{
    80020c38:	1101                	addi	sp,sp,-32
    80020c3a:	ec06                	sd	ra,24(sp)
    80020c3c:	e822                	sd	s0,16(sp)
    80020c3e:	e426                	sd	s1,8(sp)
    80020c40:	1000                	addi	s0,sp,32
  uint64 off = va % PGSIZE;
    80020c42:	03459493          	slli	s1,a1,0x34
  pte_t *pte;
  uint64 pa;
  
  pte = walk(kpt, va, 0);
    80020c46:	4601                	li	a2,0
    80020c48:	00000097          	auipc	ra,0x0
    80020c4c:	f08080e7          	jalr	-248(ra) # 80020b50 <walk>
  if(pte == 0)
    80020c50:	cd11                	beqz	a0,80020c6c <kwalkaddr+0x34>
    80020c52:	90d1                	srli	s1,s1,0x34
    panic("kvmpa");
  if((*pte & PTE_V) == 0)
    80020c54:	6108                	ld	a0,0(a0)
    80020c56:	00157793          	andi	a5,a0,1
    80020c5a:	c38d                	beqz	a5,80020c7c <kwalkaddr+0x44>
    panic("kvmpa");
  pa = PTE2PA(*pte);
    80020c5c:	8129                	srli	a0,a0,0xa
    80020c5e:	0532                	slli	a0,a0,0xc
  return pa+off;
}
    80020c60:	9526                	add	a0,a0,s1
    80020c62:	60e2                	ld	ra,24(sp)
    80020c64:	6442                	ld	s0,16(sp)
    80020c66:	64a2                	ld	s1,8(sp)
    80020c68:	6105                	addi	sp,sp,32
    80020c6a:	8082                	ret
    panic("kvmpa");
    80020c6c:	0000a517          	auipc	a0,0xa
    80020c70:	6ac50513          	addi	a0,a0,1708 # 8002b318 <etext+0x318>
    80020c74:	fffff097          	auipc	ra,0xfffff
    80020c78:	4d2080e7          	jalr	1234(ra) # 80020146 <panic>
    panic("kvmpa");
    80020c7c:	0000a517          	auipc	a0,0xa
    80020c80:	69c50513          	addi	a0,a0,1692 # 8002b318 <etext+0x318>
    80020c84:	fffff097          	auipc	ra,0xfffff
    80020c88:	4c2080e7          	jalr	1218(ra) # 80020146 <panic>

0000000080020c8c <kvmpa>:
{
    80020c8c:	1141                	addi	sp,sp,-16
    80020c8e:	e406                	sd	ra,8(sp)
    80020c90:	e022                	sd	s0,0(sp)
    80020c92:	0800                	addi	s0,sp,16
  return kwalkaddr(kernel_pagetable, va);
    80020c94:	85aa                	mv	a1,a0
    80020c96:	00015797          	auipc	a5,0x15
    80020c9a:	3c278793          	addi	a5,a5,962 # 80036058 <kernel_pagetable>
    80020c9e:	6388                	ld	a0,0(a5)
    80020ca0:	00000097          	auipc	ra,0x0
    80020ca4:	f98080e7          	jalr	-104(ra) # 80020c38 <kwalkaddr>
}
    80020ca8:	60a2                	ld	ra,8(sp)
    80020caa:	6402                	ld	s0,0(sp)
    80020cac:	0141                	addi	sp,sp,16
    80020cae:	8082                	ret

0000000080020cb0 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80020cb0:	715d                	addi	sp,sp,-80
    80020cb2:	e486                	sd	ra,72(sp)
    80020cb4:	e0a2                	sd	s0,64(sp)
    80020cb6:	fc26                	sd	s1,56(sp)
    80020cb8:	f84a                	sd	s2,48(sp)
    80020cba:	f44e                	sd	s3,40(sp)
    80020cbc:	f052                	sd	s4,32(sp)
    80020cbe:	ec56                	sd	s5,24(sp)
    80020cc0:	e85a                	sd	s6,16(sp)
    80020cc2:	e45e                	sd	s7,8(sp)
    80020cc4:	0880                	addi	s0,sp,80
    80020cc6:	8aaa                	mv	s5,a0
    80020cc8:	8b3a                	mv	s6,a4
  uint64 a, last;
  pte_t *pte;

  a = PGROUNDDOWN(va);
    80020cca:	79fd                	lui	s3,0xfffff
    80020ccc:	0135fa33          	and	s4,a1,s3
  last = PGROUNDDOWN(va + size - 1);
    80020cd0:	167d                	addi	a2,a2,-1
    80020cd2:	962e                	add	a2,a2,a1
    80020cd4:	013679b3          	and	s3,a2,s3
  a = PGROUNDDOWN(va);
    80020cd8:	8952                	mv	s2,s4
    80020cda:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80020cde:	6b85                	lui	s7,0x1
    80020ce0:	a811                	j	80020cf4 <mappages+0x44>
      panic("remap");
    80020ce2:	0000a517          	auipc	a0,0xa
    80020ce6:	63e50513          	addi	a0,a0,1598 # 8002b320 <etext+0x320>
    80020cea:	fffff097          	auipc	ra,0xfffff
    80020cee:	45c080e7          	jalr	1116(ra) # 80020146 <panic>
    a += PGSIZE;
    80020cf2:	995e                	add	s2,s2,s7
    pa += PGSIZE;
    80020cf4:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == NULL)
    80020cf8:	4605                	li	a2,1
    80020cfa:	85ca                	mv	a1,s2
    80020cfc:	8556                	mv	a0,s5
    80020cfe:	00000097          	auipc	ra,0x0
    80020d02:	e52080e7          	jalr	-430(ra) # 80020b50 <walk>
    80020d06:	cd19                	beqz	a0,80020d24 <mappages+0x74>
    if(*pte & PTE_V)
    80020d08:	611c                	ld	a5,0(a0)
    80020d0a:	8b85                	andi	a5,a5,1
    80020d0c:	fbf9                	bnez	a5,80020ce2 <mappages+0x32>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80020d0e:	80b1                	srli	s1,s1,0xc
    80020d10:	04aa                	slli	s1,s1,0xa
    80020d12:	0164e4b3          	or	s1,s1,s6
    80020d16:	0014e493          	ori	s1,s1,1
    80020d1a:	e104                	sd	s1,0(a0)
    if(a == last)
    80020d1c:	fd391be3          	bne	s2,s3,80020cf2 <mappages+0x42>
  }
  return 0;
    80020d20:	4501                	li	a0,0
    80020d22:	a011                	j	80020d26 <mappages+0x76>
      return -1;
    80020d24:	557d                	li	a0,-1
}
    80020d26:	60a6                	ld	ra,72(sp)
    80020d28:	6406                	ld	s0,64(sp)
    80020d2a:	74e2                	ld	s1,56(sp)
    80020d2c:	7942                	ld	s2,48(sp)
    80020d2e:	79a2                	ld	s3,40(sp)
    80020d30:	7a02                	ld	s4,32(sp)
    80020d32:	6ae2                	ld	s5,24(sp)
    80020d34:	6b42                	ld	s6,16(sp)
    80020d36:	6ba2                	ld	s7,8(sp)
    80020d38:	6161                	addi	sp,sp,80
    80020d3a:	8082                	ret

0000000080020d3c <kvmmap>:
{
    80020d3c:	1141                	addi	sp,sp,-16
    80020d3e:	e406                	sd	ra,8(sp)
    80020d40:	e022                	sd	s0,0(sp)
    80020d42:	0800                	addi	s0,sp,16
  if(mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    80020d44:	8736                	mv	a4,a3
    80020d46:	86ae                	mv	a3,a1
    80020d48:	85aa                	mv	a1,a0
    80020d4a:	00015797          	auipc	a5,0x15
    80020d4e:	30e78793          	addi	a5,a5,782 # 80036058 <kernel_pagetable>
    80020d52:	6388                	ld	a0,0(a5)
    80020d54:	00000097          	auipc	ra,0x0
    80020d58:	f5c080e7          	jalr	-164(ra) # 80020cb0 <mappages>
    80020d5c:	e509                	bnez	a0,80020d66 <kvmmap+0x2a>
}
    80020d5e:	60a2                	ld	ra,8(sp)
    80020d60:	6402                	ld	s0,0(sp)
    80020d62:	0141                	addi	sp,sp,16
    80020d64:	8082                	ret
    panic("kvmmap");
    80020d66:	0000a517          	auipc	a0,0xa
    80020d6a:	5c250513          	addi	a0,a0,1474 # 8002b328 <etext+0x328>
    80020d6e:	fffff097          	auipc	ra,0xfffff
    80020d72:	3d8080e7          	jalr	984(ra) # 80020146 <panic>

0000000080020d76 <kvminit>:
{
    80020d76:	1101                	addi	sp,sp,-32
    80020d78:	ec06                	sd	ra,24(sp)
    80020d7a:	e822                	sd	s0,16(sp)
    80020d7c:	e426                	sd	s1,8(sp)
    80020d7e:	1000                	addi	s0,sp,32
  kernel_pagetable = (pagetable_t) kalloc();
    80020d80:	fffff097          	auipc	ra,0xfffff
    80020d84:	7d2080e7          	jalr	2002(ra) # 80020552 <kalloc>
    80020d88:	00015797          	auipc	a5,0x15
    80020d8c:	2ca7b823          	sd	a0,720(a5) # 80036058 <kernel_pagetable>
  memset(kernel_pagetable, 0, PGSIZE);
    80020d90:	6605                	lui	a2,0x1
    80020d92:	4581                	li	a1,0
    80020d94:	00000097          	auipc	ra,0x0
    80020d98:	9c8080e7          	jalr	-1592(ra) # 8002075c <memset>
  kvmmap(UART_V, UART, PGSIZE, PTE_R | PTE_W);
    80020d9c:	4699                	li	a3,6
    80020d9e:	6605                	lui	a2,0x1
    80020da0:	380005b7          	lui	a1,0x38000
    80020da4:	7e700513          	li	a0,2023
    80020da8:	056e                	slli	a0,a0,0x1b
    80020daa:	00000097          	auipc	ra,0x0
    80020dae:	f92080e7          	jalr	-110(ra) # 80020d3c <kvmmap>
  kvmmap(CLINT_V, CLINT, 0x10000, PTE_R | PTE_W);
    80020db2:	4699                	li	a3,6
    80020db4:	6641                	lui	a2,0x10
    80020db6:	020005b7          	lui	a1,0x2000
    80020dba:	01f81537          	lui	a0,0x1f81
    80020dbe:	0536                	slli	a0,a0,0xd
    80020dc0:	00000097          	auipc	ra,0x0
    80020dc4:	f7c080e7          	jalr	-132(ra) # 80020d3c <kvmmap>
  kvmmap(PLIC_V, PLIC, 0x4000, PTE_R | PTE_W);
    80020dc8:	4699                	li	a3,6
    80020dca:	6611                	lui	a2,0x4
    80020dcc:	0c0005b7          	lui	a1,0xc000
    80020dd0:	00fc3537          	lui	a0,0xfc3
    80020dd4:	053a                	slli	a0,a0,0xe
    80020dd6:	00000097          	auipc	ra,0x0
    80020dda:	f66080e7          	jalr	-154(ra) # 80020d3c <kvmmap>
  kvmmap(PLIC_V + 0x200000, PLIC + 0x200000, 0x4000, PTE_R | PTE_W);
    80020dde:	4699                	li	a3,6
    80020de0:	6611                	lui	a2,0x4
    80020de2:	0c2005b7          	lui	a1,0xc200
    80020de6:	1f861537          	lui	a0,0x1f861
    80020dea:	0526                	slli	a0,a0,0x9
    80020dec:	00000097          	auipc	ra,0x0
    80020df0:	f50080e7          	jalr	-176(ra) # 80020d3c <kvmmap>
  kvmmap(GPIOHS_V, GPIOHS, 0x1000, PTE_R | PTE_W);
    80020df4:	4699                	li	a3,6
    80020df6:	6605                	lui	a2,0x1
    80020df8:	380015b7          	lui	a1,0x38001
    80020dfc:	03f38537          	lui	a0,0x3f38
    80020e00:	0505                	addi	a0,a0,1
    80020e02:	0532                	slli	a0,a0,0xc
    80020e04:	00000097          	auipc	ra,0x0
    80020e08:	f38080e7          	jalr	-200(ra) # 80020d3c <kvmmap>
  kvmmap(DMAC_V, DMAC, 0x1000, PTE_R | PTE_W);
    80020e0c:	4699                	li	a3,6
    80020e0e:	6605                	lui	a2,0x1
    80020e10:	500005b7          	lui	a1,0x50000
    80020e14:	3f500513          	li	a0,1013
    80020e18:	0572                	slli	a0,a0,0x1c
    80020e1a:	00000097          	auipc	ra,0x0
    80020e1e:	f22080e7          	jalr	-222(ra) # 80020d3c <kvmmap>
  kvmmap(SPI_SLAVE_V, SPI_SLAVE, 0x1000, PTE_R | PTE_W);
    80020e22:	4699                	li	a3,6
    80020e24:	6605                	lui	a2,0x1
    80020e26:	502405b7          	lui	a1,0x50240
    80020e2a:	000fd4b7          	lui	s1,0xfd
    80020e2e:	40948513          	addi	a0,s1,1033 # fd409 <BASE_ADDRESS-0x7ff22bf7>
    80020e32:	054a                	slli	a0,a0,0x12
    80020e34:	00000097          	auipc	ra,0x0
    80020e38:	f08080e7          	jalr	-248(ra) # 80020d3c <kvmmap>
  kvmmap(FPIOA_V, FPIOA, 0x1000, PTE_R | PTE_W);
    80020e3c:	4699                	li	a3,6
    80020e3e:	6605                	lui	a2,0x1
    80020e40:	502b05b7          	lui	a1,0x502b0
    80020e44:	003f5537          	lui	a0,0x3f5
    80020e48:	02b50513          	addi	a0,a0,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80020e4c:	0542                	slli	a0,a0,0x10
    80020e4e:	00000097          	auipc	ra,0x0
    80020e52:	eee080e7          	jalr	-274(ra) # 80020d3c <kvmmap>
  kvmmap(SPI0_V, SPI0, 0x1000, PTE_R | PTE_W);
    80020e56:	4699                	li	a3,6
    80020e58:	6605                	lui	a2,0x1
    80020e5a:	520005b7          	lui	a1,0x52000
    80020e5e:	01fa9537          	lui	a0,0x1fa9
    80020e62:	0536                	slli	a0,a0,0xd
    80020e64:	00000097          	auipc	ra,0x0
    80020e68:	ed8080e7          	jalr	-296(ra) # 80020d3c <kvmmap>
  kvmmap(SPI1_V, SPI1, 0x1000, PTE_R | PTE_W);
    80020e6c:	4699                	li	a3,6
    80020e6e:	6605                	lui	a2,0x1
    80020e70:	530005b7          	lui	a1,0x53000
    80020e74:	03f53537          	lui	a0,0x3f53
    80020e78:	0532                	slli	a0,a0,0xc
    80020e7a:	00000097          	auipc	ra,0x0
    80020e7e:	ec2080e7          	jalr	-318(ra) # 80020d3c <kvmmap>
  kvmmap(SPI2_V, SPI2, 0x1000, PTE_R | PTE_W);
    80020e82:	4699                	li	a3,6
    80020e84:	6605                	lui	a2,0x1
    80020e86:	540005b7          	lui	a1,0x54000
    80020e8a:	00fd5537          	lui	a0,0xfd5
    80020e8e:	053a                	slli	a0,a0,0xe
    80020e90:	00000097          	auipc	ra,0x0
    80020e94:	eac080e7          	jalr	-340(ra) # 80020d3c <kvmmap>
  kvmmap(SYSCTL_V, SYSCTL, 0x1000, PTE_R | PTE_W);
    80020e98:	4699                	li	a3,6
    80020e9a:	6605                	lui	a2,0x1
    80020e9c:	504405b7          	lui	a1,0x50440
    80020ea0:	41148513          	addi	a0,s1,1041
    80020ea4:	054a                	slli	a0,a0,0x12
    80020ea6:	00000097          	auipc	ra,0x0
    80020eaa:	e96080e7          	jalr	-362(ra) # 80020d3c <kvmmap>
  kvmmap(KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);
    80020eae:	0000a497          	auipc	s1,0xa
    80020eb2:	15248493          	addi	s1,s1,338 # 8002b000 <etext>
    80020eb6:	46a9                	li	a3,10
    80020eb8:	fbfff637          	lui	a2,0xfbfff
    80020ebc:	0616                	slli	a2,a2,0x5
    80020ebe:	9626                	add	a2,a2,s1
    80020ec0:	040015b7          	lui	a1,0x4001
    80020ec4:	0596                	slli	a1,a1,0x5
    80020ec6:	852e                	mv	a0,a1
    80020ec8:	00000097          	auipc	ra,0x0
    80020ecc:	e74080e7          	jalr	-396(ra) # 80020d3c <kvmmap>
  kvmmap((uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext, PTE_R | PTE_W);
    80020ed0:	4699                	li	a3,6
    80020ed2:	40300613          	li	a2,1027
    80020ed6:	0656                	slli	a2,a2,0x15
    80020ed8:	8e05                	sub	a2,a2,s1
    80020eda:	85a6                	mv	a1,s1
    80020edc:	8526                	mv	a0,s1
    80020ede:	00000097          	auipc	ra,0x0
    80020ee2:	e5e080e7          	jalr	-418(ra) # 80020d3c <kvmmap>
  kvmmap(TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80020ee6:	46a9                	li	a3,10
    80020ee8:	6605                	lui	a2,0x1
    80020eea:	00009597          	auipc	a1,0x9
    80020eee:	11658593          	addi	a1,a1,278 # 8002a000 <_trampoline>
    80020ef2:	04000537          	lui	a0,0x4000
    80020ef6:	157d                	addi	a0,a0,-1
    80020ef8:	0532                	slli	a0,a0,0xc
    80020efa:	00000097          	auipc	ra,0x0
    80020efe:	e42080e7          	jalr	-446(ra) # 80020d3c <kvmmap>
}
    80020f02:	60e2                	ld	ra,24(sp)
    80020f04:	6442                	ld	s0,16(sp)
    80020f06:	64a2                	ld	s1,8(sp)
    80020f08:	6105                	addi	sp,sp,32
    80020f0a:	8082                	ret

0000000080020f0c <vmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
vmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80020f0c:	715d                	addi	sp,sp,-80
    80020f0e:	e486                	sd	ra,72(sp)
    80020f10:	e0a2                	sd	s0,64(sp)
    80020f12:	fc26                	sd	s1,56(sp)
    80020f14:	f84a                	sd	s2,48(sp)
    80020f16:	f44e                	sd	s3,40(sp)
    80020f18:	f052                	sd	s4,32(sp)
    80020f1a:	ec56                	sd	s5,24(sp)
    80020f1c:	e85a                	sd	s6,16(sp)
    80020f1e:	e45e                	sd	s7,8(sp)
    80020f20:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80020f22:	03459793          	slli	a5,a1,0x34
    80020f26:	e795                	bnez	a5,80020f52 <vmunmap+0x46>
    80020f28:	8a2a                	mv	s4,a0
    80020f2a:	84ae                	mv	s1,a1
    80020f2c:	8ab6                	mv	s5,a3
    panic("vmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020f2e:	0632                	slli	a2,a2,0xc
    80020f30:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("vmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("vmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80020f34:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020f36:	6b05                	lui	s6,0x1
    80020f38:	0735e863          	bltu	a1,s3,80020fa8 <vmunmap+0x9c>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80020f3c:	60a6                	ld	ra,72(sp)
    80020f3e:	6406                	ld	s0,64(sp)
    80020f40:	74e2                	ld	s1,56(sp)
    80020f42:	7942                	ld	s2,48(sp)
    80020f44:	79a2                	ld	s3,40(sp)
    80020f46:	7a02                	ld	s4,32(sp)
    80020f48:	6ae2                	ld	s5,24(sp)
    80020f4a:	6b42                	ld	s6,16(sp)
    80020f4c:	6ba2                	ld	s7,8(sp)
    80020f4e:	6161                	addi	sp,sp,80
    80020f50:	8082                	ret
    panic("vmunmap: not aligned");
    80020f52:	0000a517          	auipc	a0,0xa
    80020f56:	3de50513          	addi	a0,a0,990 # 8002b330 <etext+0x330>
    80020f5a:	fffff097          	auipc	ra,0xfffff
    80020f5e:	1ec080e7          	jalr	492(ra) # 80020146 <panic>
      panic("vmunmap: walk");
    80020f62:	0000a517          	auipc	a0,0xa
    80020f66:	3e650513          	addi	a0,a0,998 # 8002b348 <etext+0x348>
    80020f6a:	fffff097          	auipc	ra,0xfffff
    80020f6e:	1dc080e7          	jalr	476(ra) # 80020146 <panic>
      panic("vmunmap: not mapped");
    80020f72:	0000a517          	auipc	a0,0xa
    80020f76:	3e650513          	addi	a0,a0,998 # 8002b358 <etext+0x358>
    80020f7a:	fffff097          	auipc	ra,0xfffff
    80020f7e:	1cc080e7          	jalr	460(ra) # 80020146 <panic>
      panic("vmunmap: not a leaf");
    80020f82:	0000a517          	auipc	a0,0xa
    80020f86:	3ee50513          	addi	a0,a0,1006 # 8002b370 <etext+0x370>
    80020f8a:	fffff097          	auipc	ra,0xfffff
    80020f8e:	1bc080e7          	jalr	444(ra) # 80020146 <panic>
      uint64 pa = PTE2PA(*pte);
    80020f92:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80020f94:	0532                	slli	a0,a0,0xc
    80020f96:	fffff097          	auipc	ra,0xfffff
    80020f9a:	4a2080e7          	jalr	1186(ra) # 80020438 <kfree>
    *pte = 0;
    80020f9e:	00093023          	sd	zero,0(s2)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020fa2:	94da                	add	s1,s1,s6
    80020fa4:	f934fce3          	bgeu	s1,s3,80020f3c <vmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80020fa8:	4601                	li	a2,0
    80020faa:	85a6                	mv	a1,s1
    80020fac:	8552                	mv	a0,s4
    80020fae:	00000097          	auipc	ra,0x0
    80020fb2:	ba2080e7          	jalr	-1118(ra) # 80020b50 <walk>
    80020fb6:	892a                	mv	s2,a0
    80020fb8:	d54d                	beqz	a0,80020f62 <vmunmap+0x56>
    if((*pte & PTE_V) == 0)
    80020fba:	6108                	ld	a0,0(a0)
    80020fbc:	00157793          	andi	a5,a0,1
    80020fc0:	dbcd                	beqz	a5,80020f72 <vmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    80020fc2:	3ff57793          	andi	a5,a0,1023
    80020fc6:	fb778ee3          	beq	a5,s7,80020f82 <vmunmap+0x76>
    if(do_free){
    80020fca:	fc0a8ae3          	beqz	s5,80020f9e <vmunmap+0x92>
    80020fce:	b7d1                	j	80020f92 <vmunmap+0x86>

0000000080020fd0 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80020fd0:	1101                	addi	sp,sp,-32
    80020fd2:	ec06                	sd	ra,24(sp)
    80020fd4:	e822                	sd	s0,16(sp)
    80020fd6:	e426                	sd	s1,8(sp)
    80020fd8:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80020fda:	fffff097          	auipc	ra,0xfffff
    80020fde:	578080e7          	jalr	1400(ra) # 80020552 <kalloc>
    80020fe2:	84aa                	mv	s1,a0
  if(pagetable == NULL)
    80020fe4:	c519                	beqz	a0,80020ff2 <uvmcreate+0x22>
    return NULL;
  memset(pagetable, 0, PGSIZE);
    80020fe6:	6605                	lui	a2,0x1
    80020fe8:	4581                	li	a1,0
    80020fea:	fffff097          	auipc	ra,0xfffff
    80020fee:	772080e7          	jalr	1906(ra) # 8002075c <memset>
  return pagetable;
}
    80020ff2:	8526                	mv	a0,s1
    80020ff4:	60e2                	ld	ra,24(sp)
    80020ff6:	6442                	ld	s0,16(sp)
    80020ff8:	64a2                	ld	s1,8(sp)
    80020ffa:	6105                	addi	sp,sp,32
    80020ffc:	8082                	ret

0000000080020ffe <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, pagetable_t kpagetable, uchar *src, uint sz)
{
    80020ffe:	7139                	addi	sp,sp,-64
    80021000:	fc06                	sd	ra,56(sp)
    80021002:	f822                	sd	s0,48(sp)
    80021004:	f426                	sd	s1,40(sp)
    80021006:	f04a                	sd	s2,32(sp)
    80021008:	ec4e                	sd	s3,24(sp)
    8002100a:	e852                	sd	s4,16(sp)
    8002100c:	e456                	sd	s5,8(sp)
    8002100e:	0080                	addi	s0,sp,64
  char *mem;

  if(sz >= PGSIZE)
    80021010:	6785                	lui	a5,0x1
    80021012:	06f6f363          	bgeu	a3,a5,80021078 <uvminit+0x7a>
    80021016:	8aaa                	mv	s5,a0
    80021018:	8a2e                	mv	s4,a1
    8002101a:	89b2                	mv	s3,a2
    8002101c:	8936                	mv	s2,a3
    panic("inituvm: more than a page");
  mem = kalloc();
    8002101e:	fffff097          	auipc	ra,0xfffff
    80021022:	534080e7          	jalr	1332(ra) # 80020552 <kalloc>
    80021026:	84aa                	mv	s1,a0
  // printf("[uvminit]kalloc: %p\n", mem);
  memset(mem, 0, PGSIZE);
    80021028:	6605                	lui	a2,0x1
    8002102a:	4581                	li	a1,0
    8002102c:	fffff097          	auipc	ra,0xfffff
    80021030:	730080e7          	jalr	1840(ra) # 8002075c <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80021034:	4779                	li	a4,30
    80021036:	86a6                	mv	a3,s1
    80021038:	6605                	lui	a2,0x1
    8002103a:	4581                	li	a1,0
    8002103c:	8556                	mv	a0,s5
    8002103e:	00000097          	auipc	ra,0x0
    80021042:	c72080e7          	jalr	-910(ra) # 80020cb0 <mappages>
  mappages(kpagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X);
    80021046:	4739                	li	a4,14
    80021048:	86a6                	mv	a3,s1
    8002104a:	6605                	lui	a2,0x1
    8002104c:	4581                	li	a1,0
    8002104e:	8552                	mv	a0,s4
    80021050:	00000097          	auipc	ra,0x0
    80021054:	c60080e7          	jalr	-928(ra) # 80020cb0 <mappages>
  memmove(mem, src, sz);
    80021058:	864a                	mv	a2,s2
    8002105a:	85ce                	mv	a1,s3
    8002105c:	8526                	mv	a0,s1
    8002105e:	fffff097          	auipc	ra,0xfffff
    80021062:	76a080e7          	jalr	1898(ra) # 800207c8 <memmove>
  // for (int i = 0; i < sz; i ++) {
  //   printf("[uvminit]mem: %p, %x\n", mem + i, mem[i]);
  // }
}
    80021066:	70e2                	ld	ra,56(sp)
    80021068:	7442                	ld	s0,48(sp)
    8002106a:	74a2                	ld	s1,40(sp)
    8002106c:	7902                	ld	s2,32(sp)
    8002106e:	69e2                	ld	s3,24(sp)
    80021070:	6a42                	ld	s4,16(sp)
    80021072:	6aa2                	ld	s5,8(sp)
    80021074:	6121                	addi	sp,sp,64
    80021076:	8082                	ret
    panic("inituvm: more than a page");
    80021078:	0000a517          	auipc	a0,0xa
    8002107c:	31050513          	addi	a0,a0,784 # 8002b388 <etext+0x388>
    80021080:	fffff097          	auipc	ra,0xfffff
    80021084:	0c6080e7          	jalr	198(ra) # 80020146 <panic>

0000000080021088 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, pagetable_t kpagetable, uint64 oldsz, uint64 newsz)
{
    80021088:	7179                	addi	sp,sp,-48
    8002108a:	f406                	sd	ra,40(sp)
    8002108c:	f022                	sd	s0,32(sp)
    8002108e:	ec26                	sd	s1,24(sp)
    80021090:	e84a                	sd	s2,16(sp)
    80021092:	e44e                	sd	s3,8(sp)
    80021094:	e052                	sd	s4,0(sp)
    80021096:	1800                	addi	s0,sp,48
  if(newsz >= oldsz)
    return oldsz;
    80021098:	8932                	mv	s2,a2
  if(newsz >= oldsz)
    8002109a:	02c6f063          	bgeu	a3,a2,800210ba <uvmdealloc+0x32>
    8002109e:	8a2a                	mv	s4,a0
    800210a0:	852e                	mv	a0,a1
    800210a2:	8936                	mv	s2,a3

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800210a4:	6785                	lui	a5,0x1
    800210a6:	17fd                	addi	a5,a5,-1
    800210a8:	00f689b3          	add	s3,a3,a5
    800210ac:	777d                	lui	a4,0xfffff
    800210ae:	00e9f9b3          	and	s3,s3,a4
    800210b2:	963e                	add	a2,a2,a5
    800210b4:	8e79                	and	a2,a2,a4
    800210b6:	00c9eb63          	bltu	s3,a2,800210cc <uvmdealloc+0x44>
    vmunmap(kpagetable, PGROUNDUP(newsz), npages, 0);
    vmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800210ba:	854a                	mv	a0,s2
    800210bc:	70a2                	ld	ra,40(sp)
    800210be:	7402                	ld	s0,32(sp)
    800210c0:	64e2                	ld	s1,24(sp)
    800210c2:	6942                	ld	s2,16(sp)
    800210c4:	69a2                	ld	s3,8(sp)
    800210c6:	6a02                	ld	s4,0(sp)
    800210c8:	6145                	addi	sp,sp,48
    800210ca:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800210cc:	413604b3          	sub	s1,a2,s3
    800210d0:	80b1                	srli	s1,s1,0xc
    vmunmap(kpagetable, PGROUNDUP(newsz), npages, 0);
    800210d2:	2481                	sext.w	s1,s1
    800210d4:	4681                	li	a3,0
    800210d6:	8626                	mv	a2,s1
    800210d8:	85ce                	mv	a1,s3
    800210da:	00000097          	auipc	ra,0x0
    800210de:	e32080e7          	jalr	-462(ra) # 80020f0c <vmunmap>
    vmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800210e2:	4685                	li	a3,1
    800210e4:	8626                	mv	a2,s1
    800210e6:	85ce                	mv	a1,s3
    800210e8:	8552                	mv	a0,s4
    800210ea:	00000097          	auipc	ra,0x0
    800210ee:	e22080e7          	jalr	-478(ra) # 80020f0c <vmunmap>
    800210f2:	b7e1                	j	800210ba <uvmdealloc+0x32>

00000000800210f4 <uvmalloc>:
  if(newsz < oldsz)
    800210f4:	0ec6e763          	bltu	a3,a2,800211e2 <uvmalloc+0xee>
{
    800210f8:	7139                	addi	sp,sp,-64
    800210fa:	fc06                	sd	ra,56(sp)
    800210fc:	f822                	sd	s0,48(sp)
    800210fe:	f426                	sd	s1,40(sp)
    80021100:	f04a                	sd	s2,32(sp)
    80021102:	ec4e                	sd	s3,24(sp)
    80021104:	e852                	sd	s4,16(sp)
    80021106:	e456                	sd	s5,8(sp)
    80021108:	e05a                	sd	s6,0(sp)
    8002110a:	0080                	addi	s0,sp,64
  oldsz = PGROUNDUP(oldsz);
    8002110c:	6a05                	lui	s4,0x1
    8002110e:	1a7d                	addi	s4,s4,-1
    80021110:	9652                	add	a2,a2,s4
    80021112:	7a7d                	lui	s4,0xfffff
    80021114:	01467a33          	and	s4,a2,s4
  for(a = oldsz; a < newsz; a += PGSIZE){
    80021118:	0cda7763          	bgeu	s4,a3,800211e6 <uvmalloc+0xf2>
    8002111c:	89b6                	mv	s3,a3
    8002111e:	8b2e                	mv	s6,a1
    80021120:	8aaa                	mv	s5,a0
    80021122:	84d2                	mv	s1,s4
    mem = kalloc();
    80021124:	fffff097          	auipc	ra,0xfffff
    80021128:	42e080e7          	jalr	1070(ra) # 80020552 <kalloc>
    8002112c:	892a                	mv	s2,a0
    if(mem == NULL){
    8002112e:	c129                	beqz	a0,80021170 <uvmalloc+0x7c>
    memset(mem, 0, PGSIZE);
    80021130:	6605                	lui	a2,0x1
    80021132:	4581                	li	a1,0
    80021134:	fffff097          	auipc	ra,0xfffff
    80021138:	628080e7          	jalr	1576(ra) # 8002075c <memset>
    if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0) {
    8002113c:	4779                	li	a4,30
    8002113e:	86ca                	mv	a3,s2
    80021140:	6605                	lui	a2,0x1
    80021142:	85a6                	mv	a1,s1
    80021144:	8556                	mv	a0,s5
    80021146:	00000097          	auipc	ra,0x0
    8002114a:	b6a080e7          	jalr	-1174(ra) # 80020cb0 <mappages>
    8002114e:	e521                	bnez	a0,80021196 <uvmalloc+0xa2>
    if (mappages(kpagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R) != 0){
    80021150:	4739                	li	a4,14
    80021152:	86ca                	mv	a3,s2
    80021154:	6605                	lui	a2,0x1
    80021156:	85a6                	mv	a1,s1
    80021158:	855a                	mv	a0,s6
    8002115a:	00000097          	auipc	ra,0x0
    8002115e:	b56080e7          	jalr	-1194(ra) # 80020cb0 <mappages>
    80021162:	e929                	bnez	a0,800211b4 <uvmalloc+0xc0>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80021164:	6785                	lui	a5,0x1
    80021166:	94be                	add	s1,s1,a5
    80021168:	fb34eee3          	bltu	s1,s3,80021124 <uvmalloc+0x30>
  return newsz;
    8002116c:	854e                	mv	a0,s3
    8002116e:	a811                	j	80021182 <uvmalloc+0x8e>
      uvmdealloc(pagetable, kpagetable, a, oldsz);
    80021170:	86d2                	mv	a3,s4
    80021172:	8626                	mv	a2,s1
    80021174:	85da                	mv	a1,s6
    80021176:	8556                	mv	a0,s5
    80021178:	00000097          	auipc	ra,0x0
    8002117c:	f10080e7          	jalr	-240(ra) # 80021088 <uvmdealloc>
      return 0;
    80021180:	4501                	li	a0,0
}
    80021182:	70e2                	ld	ra,56(sp)
    80021184:	7442                	ld	s0,48(sp)
    80021186:	74a2                	ld	s1,40(sp)
    80021188:	7902                	ld	s2,32(sp)
    8002118a:	69e2                	ld	s3,24(sp)
    8002118c:	6a42                	ld	s4,16(sp)
    8002118e:	6aa2                	ld	s5,8(sp)
    80021190:	6b02                	ld	s6,0(sp)
    80021192:	6121                	addi	sp,sp,64
    80021194:	8082                	ret
      kfree(mem);
    80021196:	854a                	mv	a0,s2
    80021198:	fffff097          	auipc	ra,0xfffff
    8002119c:	2a0080e7          	jalr	672(ra) # 80020438 <kfree>
      uvmdealloc(pagetable, kpagetable, a, oldsz);
    800211a0:	86d2                	mv	a3,s4
    800211a2:	8626                	mv	a2,s1
    800211a4:	85da                	mv	a1,s6
    800211a6:	8556                	mv	a0,s5
    800211a8:	00000097          	auipc	ra,0x0
    800211ac:	ee0080e7          	jalr	-288(ra) # 80021088 <uvmdealloc>
      return 0;
    800211b0:	4501                	li	a0,0
    800211b2:	bfc1                	j	80021182 <uvmalloc+0x8e>
      int npages = (a - oldsz) / PGSIZE;
    800211b4:	414484b3          	sub	s1,s1,s4
    800211b8:	80b1                	srli	s1,s1,0xc
    800211ba:	2481                	sext.w	s1,s1
      vmunmap(pagetable, oldsz, npages + 1, 1);   // plus the page allocated above.
    800211bc:	4685                	li	a3,1
    800211be:	0014861b          	addiw	a2,s1,1
    800211c2:	85d2                	mv	a1,s4
    800211c4:	8556                	mv	a0,s5
    800211c6:	00000097          	auipc	ra,0x0
    800211ca:	d46080e7          	jalr	-698(ra) # 80020f0c <vmunmap>
      vmunmap(kpagetable, oldsz, npages, 0);
    800211ce:	4681                	li	a3,0
    800211d0:	8626                	mv	a2,s1
    800211d2:	85d2                	mv	a1,s4
    800211d4:	855a                	mv	a0,s6
    800211d6:	00000097          	auipc	ra,0x0
    800211da:	d36080e7          	jalr	-714(ra) # 80020f0c <vmunmap>
      return 0;
    800211de:	4501                	li	a0,0
    800211e0:	b74d                	j	80021182 <uvmalloc+0x8e>
    return oldsz;
    800211e2:	8532                	mv	a0,a2
}
    800211e4:	8082                	ret
  return newsz;
    800211e6:	8536                	mv	a0,a3
    800211e8:	bf69                	j	80021182 <uvmalloc+0x8e>

00000000800211ea <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800211ea:	7179                	addi	sp,sp,-48
    800211ec:	f406                	sd	ra,40(sp)
    800211ee:	f022                	sd	s0,32(sp)
    800211f0:	ec26                	sd	s1,24(sp)
    800211f2:	e84a                	sd	s2,16(sp)
    800211f4:	e44e                	sd	s3,8(sp)
    800211f6:	e052                	sd	s4,0(sp)
    800211f8:	1800                	addi	s0,sp,48
    800211fa:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800211fc:	84aa                	mv	s1,a0
    800211fe:	6905                	lui	s2,0x1
    80021200:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80021202:	4985                	li	s3,1
    80021204:	a821                	j	8002121c <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80021206:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    80021208:	0532                	slli	a0,a0,0xc
    8002120a:	00000097          	auipc	ra,0x0
    8002120e:	fe0080e7          	jalr	-32(ra) # 800211ea <freewalk>
      pagetable[i] = 0;
    80021212:	0004b023          	sd	zero,0(s1)
    80021216:	04a1                	addi	s1,s1,8
  for(int i = 0; i < 512; i++){
    80021218:	03248163          	beq	s1,s2,8002123a <freewalk+0x50>
    pte_t pte = pagetable[i];
    8002121c:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8002121e:	00f57793          	andi	a5,a0,15
    80021222:	ff3782e3          	beq	a5,s3,80021206 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80021226:	8905                	andi	a0,a0,1
    80021228:	d57d                	beqz	a0,80021216 <freewalk+0x2c>
      panic("freewalk: leaf");
    8002122a:	0000a517          	auipc	a0,0xa
    8002122e:	17e50513          	addi	a0,a0,382 # 8002b3a8 <etext+0x3a8>
    80021232:	fffff097          	auipc	ra,0xfffff
    80021236:	f14080e7          	jalr	-236(ra) # 80020146 <panic>
    }
  }
  kfree((void*)pagetable);
    8002123a:	8552                	mv	a0,s4
    8002123c:	fffff097          	auipc	ra,0xfffff
    80021240:	1fc080e7          	jalr	508(ra) # 80020438 <kfree>
}
    80021244:	70a2                	ld	ra,40(sp)
    80021246:	7402                	ld	s0,32(sp)
    80021248:	64e2                	ld	s1,24(sp)
    8002124a:	6942                	ld	s2,16(sp)
    8002124c:	69a2                	ld	s3,8(sp)
    8002124e:	6a02                	ld	s4,0(sp)
    80021250:	6145                	addi	sp,sp,48
    80021252:	8082                	ret

0000000080021254 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80021254:	1101                	addi	sp,sp,-32
    80021256:	ec06                	sd	ra,24(sp)
    80021258:	e822                	sd	s0,16(sp)
    8002125a:	e426                	sd	s1,8(sp)
    8002125c:	1000                	addi	s0,sp,32
    8002125e:	84aa                	mv	s1,a0
  if(sz > 0)
    80021260:	e999                	bnez	a1,80021276 <uvmfree+0x22>
    vmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80021262:	8526                	mv	a0,s1
    80021264:	00000097          	auipc	ra,0x0
    80021268:	f86080e7          	jalr	-122(ra) # 800211ea <freewalk>
}
    8002126c:	60e2                	ld	ra,24(sp)
    8002126e:	6442                	ld	s0,16(sp)
    80021270:	64a2                	ld	s1,8(sp)
    80021272:	6105                	addi	sp,sp,32
    80021274:	8082                	ret
    vmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80021276:	6605                	lui	a2,0x1
    80021278:	167d                	addi	a2,a2,-1
    8002127a:	962e                	add	a2,a2,a1
    8002127c:	4685                	li	a3,1
    8002127e:	8231                	srli	a2,a2,0xc
    80021280:	4581                	li	a1,0
    80021282:	00000097          	auipc	ra,0x0
    80021286:	c8a080e7          	jalr	-886(ra) # 80020f0c <vmunmap>
    8002128a:	bfe1                	j	80021262 <uvmfree+0xe>

000000008002128c <uvmcopy>:
  pte_t *pte;
  uint64 pa, i = 0, ki = 0;
  uint flags;
  char *mem;

  while (i < sz){
    8002128c:	10068563          	beqz	a3,80021396 <uvmcopy+0x10a>
{
    80021290:	715d                	addi	sp,sp,-80
    80021292:	e486                	sd	ra,72(sp)
    80021294:	e0a2                	sd	s0,64(sp)
    80021296:	fc26                	sd	s1,56(sp)
    80021298:	f84a                	sd	s2,48(sp)
    8002129a:	f44e                	sd	s3,40(sp)
    8002129c:	f052                	sd	s4,32(sp)
    8002129e:	ec56                	sd	s5,24(sp)
    800212a0:	e85a                	sd	s6,16(sp)
    800212a2:	e45e                	sd	s7,8(sp)
    800212a4:	e062                	sd	s8,0(sp)
    800212a6:	0880                	addi	s0,sp,80
    800212a8:	8b36                	mv	s6,a3
    800212aa:	8bb2                	mv	s7,a2
    800212ac:	8aae                	mv	s5,a1
    800212ae:	8c2a                	mv	s8,a0
  uint64 pa, i = 0, ki = 0;
    800212b0:	4901                	li	s2,0
    800212b2:	a011                	j	800212b6 <uvmcopy+0x2a>
    memmove(mem, (char*)pa, PGSIZE);
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) {
      kfree(mem);
      goto err;
    }
    i += PGSIZE;
    800212b4:	8952                	mv	s2,s4
    if((pte = walk(old, i, 0)) == NULL)
    800212b6:	4601                	li	a2,0
    800212b8:	85ca                	mv	a1,s2
    800212ba:	8562                	mv	a0,s8
    800212bc:	00000097          	auipc	ra,0x0
    800212c0:	894080e7          	jalr	-1900(ra) # 80020b50 <walk>
    800212c4:	c135                	beqz	a0,80021328 <uvmcopy+0x9c>
    if((*pte & PTE_V) == 0)
    800212c6:	6118                	ld	a4,0(a0)
    800212c8:	00177793          	andi	a5,a4,1
    800212cc:	c7b5                	beqz	a5,80021338 <uvmcopy+0xac>
    pa = PTE2PA(*pte);
    800212ce:	00a75593          	srli	a1,a4,0xa
    800212d2:	00c59a13          	slli	s4,a1,0xc
    flags = PTE_FLAGS(*pte);
    800212d6:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == NULL)
    800212da:	fffff097          	auipc	ra,0xfffff
    800212de:	278080e7          	jalr	632(ra) # 80020552 <kalloc>
    800212e2:	89aa                	mv	s3,a0
    800212e4:	c92d                	beqz	a0,80021356 <uvmcopy+0xca>
    memmove(mem, (char*)pa, PGSIZE);
    800212e6:	6605                	lui	a2,0x1
    800212e8:	85d2                	mv	a1,s4
    800212ea:	fffff097          	auipc	ra,0xfffff
    800212ee:	4de080e7          	jalr	1246(ra) # 800207c8 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) {
    800212f2:	2481                	sext.w	s1,s1
    800212f4:	8726                	mv	a4,s1
    800212f6:	86ce                	mv	a3,s3
    800212f8:	6605                	lui	a2,0x1
    800212fa:	85ca                	mv	a1,s2
    800212fc:	8556                	mv	a0,s5
    800212fe:	00000097          	auipc	ra,0x0
    80021302:	9b2080e7          	jalr	-1614(ra) # 80020cb0 <mappages>
    80021306:	e129                	bnez	a0,80021348 <uvmcopy+0xbc>
    i += PGSIZE;
    80021308:	6a05                	lui	s4,0x1
    8002130a:	9a4a                	add	s4,s4,s2
    if(mappages(knew, ki, PGSIZE, (uint64)mem, flags & ~PTE_U) != 0){
    8002130c:	3ef4f713          	andi	a4,s1,1007
    80021310:	86ce                	mv	a3,s3
    80021312:	6605                	lui	a2,0x1
    80021314:	85ca                	mv	a1,s2
    80021316:	855e                	mv	a0,s7
    80021318:	00000097          	auipc	ra,0x0
    8002131c:	998080e7          	jalr	-1640(ra) # 80020cb0 <mappages>
    80021320:	ed05                	bnez	a0,80021358 <uvmcopy+0xcc>
  while (i < sz){
    80021322:	f96a69e3          	bltu	s4,s6,800212b4 <uvmcopy+0x28>
    80021326:	a8a1                	j	8002137e <uvmcopy+0xf2>
      panic("uvmcopy: pte should exist");
    80021328:	0000a517          	auipc	a0,0xa
    8002132c:	09050513          	addi	a0,a0,144 # 8002b3b8 <etext+0x3b8>
    80021330:	fffff097          	auipc	ra,0xfffff
    80021334:	e16080e7          	jalr	-490(ra) # 80020146 <panic>
      panic("uvmcopy: page not present");
    80021338:	0000a517          	auipc	a0,0xa
    8002133c:	0a050513          	addi	a0,a0,160 # 8002b3d8 <etext+0x3d8>
    80021340:	fffff097          	auipc	ra,0xfffff
    80021344:	e06080e7          	jalr	-506(ra) # 80020146 <panic>
      kfree(mem);
    80021348:	854e                	mv	a0,s3
    8002134a:	fffff097          	auipc	ra,0xfffff
    8002134e:	0ee080e7          	jalr	238(ra) # 80020438 <kfree>
      goto err;
    80021352:	8a4a                	mv	s4,s2
    80021354:	a011                	j	80021358 <uvmcopy+0xcc>
    80021356:	8a4a                	mv	s4,s2
    ki += PGSIZE;
  }
  return 0;

 err:
  vmunmap(knew, 0, ki / PGSIZE, 0);
    80021358:	4681                	li	a3,0
    8002135a:	00c95613          	srli	a2,s2,0xc
    8002135e:	4581                	li	a1,0
    80021360:	855e                	mv	a0,s7
    80021362:	00000097          	auipc	ra,0x0
    80021366:	baa080e7          	jalr	-1110(ra) # 80020f0c <vmunmap>
  vmunmap(new, 0, i / PGSIZE, 1);
    8002136a:	4685                	li	a3,1
    8002136c:	00ca5613          	srli	a2,s4,0xc
    80021370:	4581                	li	a1,0
    80021372:	8556                	mv	a0,s5
    80021374:	00000097          	auipc	ra,0x0
    80021378:	b98080e7          	jalr	-1128(ra) # 80020f0c <vmunmap>
  return -1;
    8002137c:	557d                	li	a0,-1
}
    8002137e:	60a6                	ld	ra,72(sp)
    80021380:	6406                	ld	s0,64(sp)
    80021382:	74e2                	ld	s1,56(sp)
    80021384:	7942                	ld	s2,48(sp)
    80021386:	79a2                	ld	s3,40(sp)
    80021388:	7a02                	ld	s4,32(sp)
    8002138a:	6ae2                	ld	s5,24(sp)
    8002138c:	6b42                	ld	s6,16(sp)
    8002138e:	6ba2                	ld	s7,8(sp)
    80021390:	6c02                	ld	s8,0(sp)
    80021392:	6161                	addi	sp,sp,80
    80021394:	8082                	ret
  return 0;
    80021396:	4501                	li	a0,0
}
    80021398:	8082                	ret

000000008002139a <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8002139a:	1141                	addi	sp,sp,-16
    8002139c:	e406                	sd	ra,8(sp)
    8002139e:	e022                	sd	s0,0(sp)
    800213a0:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    800213a2:	4601                	li	a2,0
    800213a4:	fffff097          	auipc	ra,0xfffff
    800213a8:	7ac080e7          	jalr	1964(ra) # 80020b50 <walk>
  if(pte == NULL)
    800213ac:	c901                	beqz	a0,800213bc <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    800213ae:	611c                	ld	a5,0(a0)
    800213b0:	9bbd                	andi	a5,a5,-17
    800213b2:	e11c                	sd	a5,0(a0)
}
    800213b4:	60a2                	ld	ra,8(sp)
    800213b6:	6402                	ld	s0,0(sp)
    800213b8:	0141                	addi	sp,sp,16
    800213ba:	8082                	ret
    panic("uvmclear");
    800213bc:	0000a517          	auipc	a0,0xa
    800213c0:	03c50513          	addi	a0,a0,60 # 8002b3f8 <etext+0x3f8>
    800213c4:	fffff097          	auipc	ra,0xfffff
    800213c8:	d82080e7          	jalr	-638(ra) # 80020146 <panic>

00000000800213cc <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800213cc:	c6bd                	beqz	a3,8002143a <copyout+0x6e>
{
    800213ce:	715d                	addi	sp,sp,-80
    800213d0:	e486                	sd	ra,72(sp)
    800213d2:	e0a2                	sd	s0,64(sp)
    800213d4:	fc26                	sd	s1,56(sp)
    800213d6:	f84a                	sd	s2,48(sp)
    800213d8:	f44e                	sd	s3,40(sp)
    800213da:	f052                	sd	s4,32(sp)
    800213dc:	ec56                	sd	s5,24(sp)
    800213de:	e85a                	sd	s6,16(sp)
    800213e0:	e45e                	sd	s7,8(sp)
    800213e2:	e062                	sd	s8,0(sp)
    800213e4:	0880                	addi	s0,sp,80
    800213e6:	8baa                	mv	s7,a0
    800213e8:	8a2e                	mv	s4,a1
    800213ea:	8ab2                	mv	s5,a2
    800213ec:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    800213ee:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == NULL)
      return -1;
    n = PGSIZE - (dstva - va0);
    800213f0:	6b05                	lui	s6,0x1
    800213f2:	a015                	j	80021416 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    800213f4:	9552                	add	a0,a0,s4
    800213f6:	0004861b          	sext.w	a2,s1
    800213fa:	85d6                	mv	a1,s5
    800213fc:	41250533          	sub	a0,a0,s2
    80021400:	fffff097          	auipc	ra,0xfffff
    80021404:	3c8080e7          	jalr	968(ra) # 800207c8 <memmove>

    len -= n;
    80021408:	409989b3          	sub	s3,s3,s1
    src += n;
    8002140c:	9aa6                	add	s5,s5,s1
    dstva = va0 + PGSIZE;
    8002140e:	01690a33          	add	s4,s2,s6
  while(len > 0){
    80021412:	02098263          	beqz	s3,80021436 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80021416:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    8002141a:	85ca                	mv	a1,s2
    8002141c:	855e                	mv	a0,s7
    8002141e:	fffff097          	auipc	ra,0xfffff
    80021422:	7d8080e7          	jalr	2008(ra) # 80020bf6 <walkaddr>
    if(pa0 == NULL)
    80021426:	cd01                	beqz	a0,8002143e <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80021428:	414904b3          	sub	s1,s2,s4
    8002142c:	94da                	add	s1,s1,s6
    if(n > len)
    8002142e:	fc99f3e3          	bgeu	s3,s1,800213f4 <copyout+0x28>
    80021432:	84ce                	mv	s1,s3
    80021434:	b7c1                	j	800213f4 <copyout+0x28>
  }
  return 0;
    80021436:	4501                	li	a0,0
    80021438:	a021                	j	80021440 <copyout+0x74>
    8002143a:	4501                	li	a0,0
}
    8002143c:	8082                	ret
      return -1;
    8002143e:	557d                	li	a0,-1
}
    80021440:	60a6                	ld	ra,72(sp)
    80021442:	6406                	ld	s0,64(sp)
    80021444:	74e2                	ld	s1,56(sp)
    80021446:	7942                	ld	s2,48(sp)
    80021448:	79a2                	ld	s3,40(sp)
    8002144a:	7a02                	ld	s4,32(sp)
    8002144c:	6ae2                	ld	s5,24(sp)
    8002144e:	6b42                	ld	s6,16(sp)
    80021450:	6ba2                	ld	s7,8(sp)
    80021452:	6c02                	ld	s8,0(sp)
    80021454:	6161                	addi	sp,sp,80
    80021456:	8082                	ret

0000000080021458 <copyout2>:

int
copyout2(uint64 dstva, char *src, uint64 len)
{
    80021458:	7179                	addi	sp,sp,-48
    8002145a:	f406                	sd	ra,40(sp)
    8002145c:	f022                	sd	s0,32(sp)
    8002145e:	ec26                	sd	s1,24(sp)
    80021460:	e84a                	sd	s2,16(sp)
    80021462:	e44e                	sd	s3,8(sp)
    80021464:	1800                	addi	s0,sp,48
    80021466:	84aa                	mv	s1,a0
    80021468:	89ae                	mv	s3,a1
    8002146a:	8932                	mv	s2,a2
  uint64 sz = myproc()->sz;
    8002146c:	00000097          	auipc	ra,0x0
    80021470:	6e6080e7          	jalr	1766(ra) # 80021b52 <myproc>
    80021474:	653c                	ld	a5,72(a0)
  if (dstva + len > sz || dstva >= sz) {
    80021476:	01248733          	add	a4,s1,s2
    8002147a:	02e7e463          	bltu	a5,a4,800214a2 <copyout2+0x4a>
    8002147e:	02f4f463          	bgeu	s1,a5,800214a6 <copyout2+0x4e>
    return -1;
  }
  memmove((void *)dstva, src, len);
    80021482:	0009061b          	sext.w	a2,s2
    80021486:	85ce                	mv	a1,s3
    80021488:	8526                	mv	a0,s1
    8002148a:	fffff097          	auipc	ra,0xfffff
    8002148e:	33e080e7          	jalr	830(ra) # 800207c8 <memmove>
  return 0;
    80021492:	4501                	li	a0,0
}
    80021494:	70a2                	ld	ra,40(sp)
    80021496:	7402                	ld	s0,32(sp)
    80021498:	64e2                	ld	s1,24(sp)
    8002149a:	6942                	ld	s2,16(sp)
    8002149c:	69a2                	ld	s3,8(sp)
    8002149e:	6145                	addi	sp,sp,48
    800214a0:	8082                	ret
    return -1;
    800214a2:	557d                	li	a0,-1
    800214a4:	bfc5                	j	80021494 <copyout2+0x3c>
    800214a6:	557d                	li	a0,-1
    800214a8:	b7f5                	j	80021494 <copyout2+0x3c>

00000000800214aa <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800214aa:	caa5                	beqz	a3,8002151a <copyin+0x70>
{
    800214ac:	715d                	addi	sp,sp,-80
    800214ae:	e486                	sd	ra,72(sp)
    800214b0:	e0a2                	sd	s0,64(sp)
    800214b2:	fc26                	sd	s1,56(sp)
    800214b4:	f84a                	sd	s2,48(sp)
    800214b6:	f44e                	sd	s3,40(sp)
    800214b8:	f052                	sd	s4,32(sp)
    800214ba:	ec56                	sd	s5,24(sp)
    800214bc:	e85a                	sd	s6,16(sp)
    800214be:	e45e                	sd	s7,8(sp)
    800214c0:	e062                	sd	s8,0(sp)
    800214c2:	0880                	addi	s0,sp,80
    800214c4:	8baa                	mv	s7,a0
    800214c6:	8aae                	mv	s5,a1
    800214c8:	8a32                	mv	s4,a2
    800214ca:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    800214cc:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == NULL)
      return -1;
    n = PGSIZE - (srcva - va0);
    800214ce:	6b05                	lui	s6,0x1
    800214d0:	a01d                	j	800214f6 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    800214d2:	014505b3          	add	a1,a0,s4
    800214d6:	0004861b          	sext.w	a2,s1
    800214da:	412585b3          	sub	a1,a1,s2
    800214de:	8556                	mv	a0,s5
    800214e0:	fffff097          	auipc	ra,0xfffff
    800214e4:	2e8080e7          	jalr	744(ra) # 800207c8 <memmove>

    len -= n;
    800214e8:	409989b3          	sub	s3,s3,s1
    dst += n;
    800214ec:	9aa6                	add	s5,s5,s1
    srcva = va0 + PGSIZE;
    800214ee:	01690a33          	add	s4,s2,s6
  while(len > 0){
    800214f2:	02098263          	beqz	s3,80021516 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    800214f6:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    800214fa:	85ca                	mv	a1,s2
    800214fc:	855e                	mv	a0,s7
    800214fe:	fffff097          	auipc	ra,0xfffff
    80021502:	6f8080e7          	jalr	1784(ra) # 80020bf6 <walkaddr>
    if(pa0 == NULL)
    80021506:	cd01                	beqz	a0,8002151e <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80021508:	414904b3          	sub	s1,s2,s4
    8002150c:	94da                	add	s1,s1,s6
    if(n > len)
    8002150e:	fc99f2e3          	bgeu	s3,s1,800214d2 <copyin+0x28>
    80021512:	84ce                	mv	s1,s3
    80021514:	bf7d                	j	800214d2 <copyin+0x28>
  }
  return 0;
    80021516:	4501                	li	a0,0
    80021518:	a021                	j	80021520 <copyin+0x76>
    8002151a:	4501                	li	a0,0
}
    8002151c:	8082                	ret
      return -1;
    8002151e:	557d                	li	a0,-1
}
    80021520:	60a6                	ld	ra,72(sp)
    80021522:	6406                	ld	s0,64(sp)
    80021524:	74e2                	ld	s1,56(sp)
    80021526:	7942                	ld	s2,48(sp)
    80021528:	79a2                	ld	s3,40(sp)
    8002152a:	7a02                	ld	s4,32(sp)
    8002152c:	6ae2                	ld	s5,24(sp)
    8002152e:	6b42                	ld	s6,16(sp)
    80021530:	6ba2                	ld	s7,8(sp)
    80021532:	6c02                	ld	s8,0(sp)
    80021534:	6161                	addi	sp,sp,80
    80021536:	8082                	ret

0000000080021538 <copyin2>:

int
copyin2(char *dst, uint64 srcva, uint64 len)
{
    80021538:	7179                	addi	sp,sp,-48
    8002153a:	f406                	sd	ra,40(sp)
    8002153c:	f022                	sd	s0,32(sp)
    8002153e:	ec26                	sd	s1,24(sp)
    80021540:	e84a                	sd	s2,16(sp)
    80021542:	e44e                	sd	s3,8(sp)
    80021544:	1800                	addi	s0,sp,48
    80021546:	89aa                	mv	s3,a0
    80021548:	84ae                	mv	s1,a1
    8002154a:	8932                	mv	s2,a2
  uint64 sz = myproc()->sz;
    8002154c:	00000097          	auipc	ra,0x0
    80021550:	606080e7          	jalr	1542(ra) # 80021b52 <myproc>
    80021554:	653c                	ld	a5,72(a0)
  if (srcva + len > sz || srcva >= sz) {
    80021556:	01248733          	add	a4,s1,s2
    8002155a:	02e7e463          	bltu	a5,a4,80021582 <copyin2+0x4a>
    8002155e:	02f4f463          	bgeu	s1,a5,80021586 <copyin2+0x4e>
    return -1;
  }
  memmove(dst, (void *)srcva, len);
    80021562:	0009061b          	sext.w	a2,s2
    80021566:	85a6                	mv	a1,s1
    80021568:	854e                	mv	a0,s3
    8002156a:	fffff097          	auipc	ra,0xfffff
    8002156e:	25e080e7          	jalr	606(ra) # 800207c8 <memmove>
  return 0;
    80021572:	4501                	li	a0,0
}
    80021574:	70a2                	ld	ra,40(sp)
    80021576:	7402                	ld	s0,32(sp)
    80021578:	64e2                	ld	s1,24(sp)
    8002157a:	6942                	ld	s2,16(sp)
    8002157c:	69a2                	ld	s3,8(sp)
    8002157e:	6145                	addi	sp,sp,48
    80021580:	8082                	ret
    return -1;
    80021582:	557d                	li	a0,-1
    80021584:	bfc5                	j	80021574 <copyin2+0x3c>
    80021586:	557d                	li	a0,-1
    80021588:	b7f5                	j	80021574 <copyin2+0x3c>

000000008002158a <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    8002158a:	cecd                	beqz	a3,80021644 <copyinstr+0xba>
{
    8002158c:	715d                	addi	sp,sp,-80
    8002158e:	e486                	sd	ra,72(sp)
    80021590:	e0a2                	sd	s0,64(sp)
    80021592:	fc26                	sd	s1,56(sp)
    80021594:	f84a                	sd	s2,48(sp)
    80021596:	f44e                	sd	s3,40(sp)
    80021598:	f052                	sd	s4,32(sp)
    8002159a:	ec56                	sd	s5,24(sp)
    8002159c:	e85a                	sd	s6,16(sp)
    8002159e:	e45e                	sd	s7,8(sp)
    800215a0:	e062                	sd	s8,0(sp)
    800215a2:	0880                	addi	s0,sp,80
    800215a4:	8aaa                	mv	s5,a0
    800215a6:	84ae                	mv	s1,a1
    800215a8:	8c32                	mv	s8,a2
    800215aa:	8bb6                	mv	s7,a3
    va0 = PGROUNDDOWN(srcva);
    800215ac:	7a7d                	lui	s4,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == NULL)
      return -1;
    n = PGSIZE - (srcva - va0);
    800215ae:	6985                	lui	s3,0x1
    800215b0:	4b05                	li	s6,1
    800215b2:	a801                	j	800215c2 <copyinstr+0x38>
    if(n > max)
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
    800215b4:	87a6                	mv	a5,s1
    800215b6:	a085                	j	80021616 <copyinstr+0x8c>
        *dst = *p;
      }
      --n;
      --max;
      p++;
      dst++;
    800215b8:	84b2                	mv	s1,a2
    }

    srcva = va0 + PGSIZE;
    800215ba:	01390c33          	add	s8,s2,s3
  while(got_null == 0 && max > 0){
    800215be:	060b8f63          	beqz	s7,8002163c <copyinstr+0xb2>
    va0 = PGROUNDDOWN(srcva);
    800215c2:	014c7933          	and	s2,s8,s4
    pa0 = walkaddr(pagetable, va0);
    800215c6:	85ca                	mv	a1,s2
    800215c8:	8556                	mv	a0,s5
    800215ca:	fffff097          	auipc	ra,0xfffff
    800215ce:	62c080e7          	jalr	1580(ra) # 80020bf6 <walkaddr>
    if(pa0 == NULL)
    800215d2:	c53d                	beqz	a0,80021640 <copyinstr+0xb6>
    n = PGSIZE - (srcva - va0);
    800215d4:	41890633          	sub	a2,s2,s8
    800215d8:	964e                	add	a2,a2,s3
    if(n > max)
    800215da:	00cbf363          	bgeu	s7,a2,800215e0 <copyinstr+0x56>
    800215de:	865e                	mv	a2,s7
    char *p = (char *) (pa0 + (srcva - va0));
    800215e0:	9562                	add	a0,a0,s8
    800215e2:	41250533          	sub	a0,a0,s2
    while(n > 0){
    800215e6:	da71                	beqz	a2,800215ba <copyinstr+0x30>
      if(*p == '\0'){
    800215e8:	00054703          	lbu	a4,0(a0)
    800215ec:	d761                	beqz	a4,800215b4 <copyinstr+0x2a>
    800215ee:	9626                	add	a2,a2,s1
    800215f0:	87a6                	mv	a5,s1
    800215f2:	1bfd                	addi	s7,s7,-1
    800215f4:	009b86b3          	add	a3,s7,s1
    800215f8:	409b04b3          	sub	s1,s6,s1
    800215fc:	94aa                	add	s1,s1,a0
        *dst = *p;
    800215fe:	00e78023          	sb	a4,0(a5) # 1000 <BASE_ADDRESS-0x8001f000>
      --max;
    80021602:	40f68bb3          	sub	s7,a3,a5
      p++;
    80021606:	00f48733          	add	a4,s1,a5
      dst++;
    8002160a:	0785                	addi	a5,a5,1
    while(n > 0){
    8002160c:	faf606e3          	beq	a2,a5,800215b8 <copyinstr+0x2e>
      if(*p == '\0'){
    80021610:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <kernel_end+0xffffffff7ffba000>
    80021614:	f76d                	bnez	a4,800215fe <copyinstr+0x74>
        *dst = '\0';
    80021616:	00078023          	sb	zero,0(a5)
    8002161a:	4785                	li	a5,1
  }
  if(got_null){
    8002161c:	0017b793          	seqz	a5,a5
    80021620:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80021624:	60a6                	ld	ra,72(sp)
    80021626:	6406                	ld	s0,64(sp)
    80021628:	74e2                	ld	s1,56(sp)
    8002162a:	7942                	ld	s2,48(sp)
    8002162c:	79a2                	ld	s3,40(sp)
    8002162e:	7a02                	ld	s4,32(sp)
    80021630:	6ae2                	ld	s5,24(sp)
    80021632:	6b42                	ld	s6,16(sp)
    80021634:	6ba2                	ld	s7,8(sp)
    80021636:	6c02                	ld	s8,0(sp)
    80021638:	6161                	addi	sp,sp,80
    8002163a:	8082                	ret
    8002163c:	4781                	li	a5,0
    8002163e:	bff9                	j	8002161c <copyinstr+0x92>
      return -1;
    80021640:	557d                	li	a0,-1
    80021642:	b7cd                	j	80021624 <copyinstr+0x9a>
  int got_null = 0;
    80021644:	4781                	li	a5,0
  if(got_null){
    80021646:	0017b793          	seqz	a5,a5
    8002164a:	40f00533          	neg	a0,a5
}
    8002164e:	8082                	ret

0000000080021650 <copyinstr2>:

int
copyinstr2(char *dst, uint64 srcva, uint64 max)
{
    80021650:	7179                	addi	sp,sp,-48
    80021652:	f406                	sd	ra,40(sp)
    80021654:	f022                	sd	s0,32(sp)
    80021656:	ec26                	sd	s1,24(sp)
    80021658:	e84a                	sd	s2,16(sp)
    8002165a:	e44e                	sd	s3,8(sp)
    8002165c:	1800                	addi	s0,sp,48
    8002165e:	89aa                	mv	s3,a0
    80021660:	84ae                	mv	s1,a1
    80021662:	8932                	mv	s2,a2
  int got_null = 0;
  uint64 sz = myproc()->sz;
    80021664:	00000097          	auipc	ra,0x0
    80021668:	4ee080e7          	jalr	1262(ra) # 80021b52 <myproc>
    8002166c:	6534                	ld	a3,72(a0)
  while(srcva < sz && max > 0){
    8002166e:	04d4f863          	bgeu	s1,a3,800216be <copyinstr2+0x6e>
    80021672:	04090863          	beqz	s2,800216c2 <copyinstr2+0x72>
    char *p = (char *)srcva;
    if(*p == '\0'){
    80021676:	0004c703          	lbu	a4,0(s1)
    8002167a:	cf15                	beqz	a4,800216b6 <copyinstr2+0x66>
    8002167c:	8e85                	sub	a3,a3,s1
    8002167e:	96ce                	add	a3,a3,s3
    80021680:	01298633          	add	a2,s3,s2
    80021684:	87ce                	mv	a5,s3
    80021686:	413485b3          	sub	a1,s1,s3
      *dst = '\0';
      got_null = 1;
      break;
    } else {
      *dst = *p;
    8002168a:	00e78023          	sb	a4,0(a5)
    }
    --max;
    srcva++;
    dst++;
    8002168e:	0785                	addi	a5,a5,1
  while(srcva < sz && max > 0){
    80021690:	02f68b63          	beq	a3,a5,800216c6 <copyinstr2+0x76>
    80021694:	02c78363          	beq	a5,a2,800216ba <copyinstr2+0x6a>
    if(*p == '\0'){
    80021698:	00b78733          	add	a4,a5,a1
    8002169c:	00074703          	lbu	a4,0(a4)
    800216a0:	f76d                	bnez	a4,8002168a <copyinstr2+0x3a>
      *dst = '\0';
    800216a2:	00078023          	sb	zero,0(a5)
  }
  if(got_null){
    return 0;
    800216a6:	4501                	li	a0,0
  } else {
    return -1;
  }
}
    800216a8:	70a2                	ld	ra,40(sp)
    800216aa:	7402                	ld	s0,32(sp)
    800216ac:	64e2                	ld	s1,24(sp)
    800216ae:	6942                	ld	s2,16(sp)
    800216b0:	69a2                	ld	s3,8(sp)
    800216b2:	6145                	addi	sp,sp,48
    800216b4:	8082                	ret
    if(*p == '\0'){
    800216b6:	87ce                	mv	a5,s3
    800216b8:	b7ed                	j	800216a2 <copyinstr2+0x52>
    return -1;
    800216ba:	557d                	li	a0,-1
    800216bc:	b7f5                	j	800216a8 <copyinstr2+0x58>
    800216be:	557d                	li	a0,-1
    800216c0:	b7e5                	j	800216a8 <copyinstr2+0x58>
    800216c2:	557d                	li	a0,-1
    800216c4:	b7d5                	j	800216a8 <copyinstr2+0x58>
    800216c6:	557d                	li	a0,-1
    800216c8:	b7c5                	j	800216a8 <copyinstr2+0x58>

00000000800216ca <kfreewalk>:
}

// only free page table, not physical pages
void
kfreewalk(pagetable_t kpt)
{
    800216ca:	7179                	addi	sp,sp,-48
    800216cc:	f406                	sd	ra,40(sp)
    800216ce:	f022                	sd	s0,32(sp)
    800216d0:	ec26                	sd	s1,24(sp)
    800216d2:	e84a                	sd	s2,16(sp)
    800216d4:	e44e                	sd	s3,8(sp)
    800216d6:	e052                	sd	s4,0(sp)
    800216d8:	1800                	addi	s0,sp,48
    800216da:	8a2a                	mv	s4,a0
  for (int i = 0; i < 512; i++) {
    800216dc:	84aa                	mv	s1,a0
    800216de:	6905                	lui	s2,0x1
    800216e0:	992a                	add	s2,s2,a0
    pte_t pte = kpt[i];
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    800216e2:	4985                	li	s3,1
    800216e4:	a821                	j	800216fc <kfreewalk+0x32>
      kfreewalk((pagetable_t) PTE2PA(pte));
    800216e6:	8129                	srli	a0,a0,0xa
    800216e8:	0532                	slli	a0,a0,0xc
    800216ea:	00000097          	auipc	ra,0x0
    800216ee:	fe0080e7          	jalr	-32(ra) # 800216ca <kfreewalk>
      kpt[i] = 0;
    800216f2:	0004b023          	sd	zero,0(s1)
    800216f6:	04a1                	addi	s1,s1,8
  for (int i = 0; i < 512; i++) {
    800216f8:	01248963          	beq	s1,s2,8002170a <kfreewalk+0x40>
    pte_t pte = kpt[i];
    800216fc:	6088                	ld	a0,0(s1)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    800216fe:	00f57793          	andi	a5,a0,15
    80021702:	ff3782e3          	beq	a5,s3,800216e6 <kfreewalk+0x1c>
    } else if (pte & PTE_V) {
    80021706:	8905                	andi	a0,a0,1
    80021708:	d57d                	beqz	a0,800216f6 <kfreewalk+0x2c>
      break;
    }
  }
  kfree((void *) kpt);
    8002170a:	8552                	mv	a0,s4
    8002170c:	fffff097          	auipc	ra,0xfffff
    80021710:	d2c080e7          	jalr	-724(ra) # 80020438 <kfree>
}
    80021714:	70a2                	ld	ra,40(sp)
    80021716:	7402                	ld	s0,32(sp)
    80021718:	64e2                	ld	s1,24(sp)
    8002171a:	6942                	ld	s2,16(sp)
    8002171c:	69a2                	ld	s3,8(sp)
    8002171e:	6a02                	ld	s4,0(sp)
    80021720:	6145                	addi	sp,sp,48
    80021722:	8082                	ret

0000000080021724 <kvmfreeusr>:

void
kvmfreeusr(pagetable_t kpt)
{
    80021724:	1101                	addi	sp,sp,-32
    80021726:	ec06                	sd	ra,24(sp)
    80021728:	e822                	sd	s0,16(sp)
    8002172a:	e426                	sd	s1,8(sp)
    8002172c:	1000                	addi	s0,sp,32
    8002172e:	84aa                	mv	s1,a0
  pte_t pte;
  for (int i = 0; i < PX(2, MAXUVA); i++) {
    pte = kpt[i];
    80021730:	6108                	ld	a0,0(a0)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    80021732:	00f57713          	andi	a4,a0,15
    80021736:	4785                	li	a5,1
    80021738:	00f70d63          	beq	a4,a5,80021752 <kvmfreeusr+0x2e>
    pte = kpt[i];
    8002173c:	6488                	ld	a0,8(s1)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    8002173e:	00f57713          	andi	a4,a0,15
    80021742:	4785                	li	a5,1
    80021744:	02f70063          	beq	a4,a5,80021764 <kvmfreeusr+0x40>
      kfreewalk((pagetable_t) PTE2PA(pte));
      kpt[i] = 0;
    }
  }
}
    80021748:	60e2                	ld	ra,24(sp)
    8002174a:	6442                	ld	s0,16(sp)
    8002174c:	64a2                	ld	s1,8(sp)
    8002174e:	6105                	addi	sp,sp,32
    80021750:	8082                	ret
      kfreewalk((pagetable_t) PTE2PA(pte));
    80021752:	8129                	srli	a0,a0,0xa
    80021754:	0532                	slli	a0,a0,0xc
    80021756:	00000097          	auipc	ra,0x0
    8002175a:	f74080e7          	jalr	-140(ra) # 800216ca <kfreewalk>
      kpt[i] = 0;
    8002175e:	0004b023          	sd	zero,0(s1)
    80021762:	bfe9                	j	8002173c <kvmfreeusr+0x18>
      kfreewalk((pagetable_t) PTE2PA(pte));
    80021764:	8129                	srli	a0,a0,0xa
    80021766:	0532                	slli	a0,a0,0xc
    80021768:	00000097          	auipc	ra,0x0
    8002176c:	f62080e7          	jalr	-158(ra) # 800216ca <kfreewalk>
      kpt[i] = 0;
    80021770:	0004b423          	sd	zero,8(s1)
}
    80021774:	bfd1                	j	80021748 <kvmfreeusr+0x24>

0000000080021776 <kvmfree>:

void
kvmfree(pagetable_t kpt, int stack_free)
{
    80021776:	1101                	addi	sp,sp,-32
    80021778:	ec06                	sd	ra,24(sp)
    8002177a:	e822                	sd	s0,16(sp)
    8002177c:	e426                	sd	s1,8(sp)
    8002177e:	1000                	addi	s0,sp,32
    80021780:	84aa                	mv	s1,a0
  if (stack_free) {
    80021782:	e185                	bnez	a1,800217a2 <kvmfree+0x2c>
    pte_t pte = kpt[PX(2, VKSTACK)];
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
      kfreewalk((pagetable_t) PTE2PA(pte));
    }
  }
  kvmfreeusr(kpt);
    80021784:	8526                	mv	a0,s1
    80021786:	00000097          	auipc	ra,0x0
    8002178a:	f9e080e7          	jalr	-98(ra) # 80021724 <kvmfreeusr>
  kfree(kpt);
    8002178e:	8526                	mv	a0,s1
    80021790:	fffff097          	auipc	ra,0xfffff
    80021794:	ca8080e7          	jalr	-856(ra) # 80020438 <kfree>
}
    80021798:	60e2                	ld	ra,24(sp)
    8002179a:	6442                	ld	s0,16(sp)
    8002179c:	64a2                	ld	s1,8(sp)
    8002179e:	6105                	addi	sp,sp,32
    800217a0:	8082                	ret
    vmunmap(kpt, VKSTACK, 1, 1);
    800217a2:	4685                	li	a3,1
    800217a4:	4605                	li	a2,1
    800217a6:	0fb00593          	li	a1,251
    800217aa:	05fa                	slli	a1,a1,0x1e
    800217ac:	fffff097          	auipc	ra,0xfffff
    800217b0:	760080e7          	jalr	1888(ra) # 80020f0c <vmunmap>
    pte_t pte = kpt[PX(2, VKSTACK)];
    800217b4:	7d84b503          	ld	a0,2008(s1)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    800217b8:	00f57713          	andi	a4,a0,15
    800217bc:	4785                	li	a5,1
    800217be:	fcf713e3          	bne	a4,a5,80021784 <kvmfree+0xe>
      kfreewalk((pagetable_t) PTE2PA(pte));
    800217c2:	8129                	srli	a0,a0,0xa
    800217c4:	0532                	slli	a0,a0,0xc
    800217c6:	00000097          	auipc	ra,0x0
    800217ca:	f04080e7          	jalr	-252(ra) # 800216ca <kfreewalk>
    800217ce:	bf5d                	j	80021784 <kvmfree+0xe>

00000000800217d0 <proc_kpagetable>:
{
    800217d0:	1101                	addi	sp,sp,-32
    800217d2:	ec06                	sd	ra,24(sp)
    800217d4:	e822                	sd	s0,16(sp)
    800217d6:	e426                	sd	s1,8(sp)
    800217d8:	1000                	addi	s0,sp,32
  pagetable_t kpt = (pagetable_t) kalloc();
    800217da:	fffff097          	auipc	ra,0xfffff
    800217de:	d78080e7          	jalr	-648(ra) # 80020552 <kalloc>
    800217e2:	84aa                	mv	s1,a0
  if (kpt == NULL)
    800217e4:	cd05                	beqz	a0,8002181c <proc_kpagetable+0x4c>
  memmove(kpt, kernel_pagetable, PGSIZE);
    800217e6:	6605                	lui	a2,0x1
    800217e8:	00015797          	auipc	a5,0x15
    800217ec:	87078793          	addi	a5,a5,-1936 # 80036058 <kernel_pagetable>
    800217f0:	638c                	ld	a1,0(a5)
    800217f2:	fffff097          	auipc	ra,0xfffff
    800217f6:	fd6080e7          	jalr	-42(ra) # 800207c8 <memmove>
  char *pstack = kalloc();
    800217fa:	fffff097          	auipc	ra,0xfffff
    800217fe:	d58080e7          	jalr	-680(ra) # 80020552 <kalloc>
  if(pstack == NULL)
    80021802:	c11d                	beqz	a0,80021828 <proc_kpagetable+0x58>
  if (mappages(kpt, VKSTACK, PGSIZE, (uint64)pstack, PTE_R | PTE_W) != 0)
    80021804:	4719                	li	a4,6
    80021806:	86aa                	mv	a3,a0
    80021808:	6605                	lui	a2,0x1
    8002180a:	0fb00593          	li	a1,251
    8002180e:	05fa                	slli	a1,a1,0x1e
    80021810:	8526                	mv	a0,s1
    80021812:	fffff097          	auipc	ra,0xfffff
    80021816:	49e080e7          	jalr	1182(ra) # 80020cb0 <mappages>
    8002181a:	e519                	bnez	a0,80021828 <proc_kpagetable+0x58>
}
    8002181c:	8526                	mv	a0,s1
    8002181e:	60e2                	ld	ra,24(sp)
    80021820:	6442                	ld	s0,16(sp)
    80021822:	64a2                	ld	s1,8(sp)
    80021824:	6105                	addi	sp,sp,32
    80021826:	8082                	ret
  kvmfree(kpt, 1);
    80021828:	4585                	li	a1,1
    8002182a:	8526                	mv	a0,s1
    8002182c:	00000097          	auipc	ra,0x0
    80021830:	f4a080e7          	jalr	-182(ra) # 80021776 <kvmfree>
  return NULL;
    80021834:	4481                	li	s1,0
    80021836:	b7dd                	j	8002181c <proc_kpagetable+0x4c>

0000000080021838 <vmprint>:

void vmprint(pagetable_t pagetable)
{
    80021838:	7119                	addi	sp,sp,-128
    8002183a:	fc86                	sd	ra,120(sp)
    8002183c:	f8a2                	sd	s0,112(sp)
    8002183e:	f4a6                	sd	s1,104(sp)
    80021840:	f0ca                	sd	s2,96(sp)
    80021842:	ecce                	sd	s3,88(sp)
    80021844:	e8d2                	sd	s4,80(sp)
    80021846:	e4d6                	sd	s5,72(sp)
    80021848:	e0da                	sd	s6,64(sp)
    8002184a:	fc5e                	sd	s7,56(sp)
    8002184c:	f862                	sd	s8,48(sp)
    8002184e:	f466                	sd	s9,40(sp)
    80021850:	f06a                	sd	s10,32(sp)
    80021852:	ec6e                	sd	s11,24(sp)
    80021854:	0100                	addi	s0,sp,128
    80021856:	8baa                	mv	s7,a0
    80021858:	f8a43023          	sd	a0,-128(s0)
  const int capacity = 512;
  printf("page table %p\n", pagetable);
    8002185c:	85aa                	mv	a1,a0
    8002185e:	0000a517          	auipc	a0,0xa
    80021862:	baa50513          	addi	a0,a0,-1110 # 8002b408 <etext+0x408>
    80021866:	fffff097          	auipc	ra,0xfffff
    8002186a:	92a080e7          	jalr	-1750(ra) # 80020190 <printf>
  for (pte_t *pte = (pte_t *) pagetable; pte < pagetable + capacity; pte++) {
    8002186e:	6d05                	lui	s10,0x1
    80021870:	9d5e                	add	s10,s10,s7
    80021872:	6c05                	lui	s8,0x1

      for (pte_t *pte2 = (pte_t *) pt2; pte2 < pt2 + capacity; pte2++) {
        if (*pte2 & PTE_V)
        {
          pagetable_t pt3 = (pagetable_t) PTE2PA(*pte2);
          printf(".. ..%d: pte %p pa %p\n", pte2 - pt2, *pte2, pt3);
    80021874:	0000ad97          	auipc	s11,0xa
    80021878:	bbcd8d93          	addi	s11,s11,-1092 # 8002b430 <etext+0x430>
    8002187c:	20000793          	li	a5,512
    80021880:	f8f43423          	sd	a5,-120(s0)

          for (pte_t *pte3 = (pte_t *) pt3; pte3 < pt3 + capacity; pte3++)
            if (*pte3 & PTE_V)
              printf(".. .. ..%d: pte %p pa %p\n", pte3 - pt3, *pte3, PTE2PA(*pte3));
    80021884:	0000aa17          	auipc	s4,0xa
    80021888:	bc4a0a13          	addi	s4,s4,-1084 # 8002b448 <etext+0x448>
    8002188c:	a88d                	j	800218fe <vmprint+0xc6>
    8002188e:	00a65693          	srli	a3,a2,0xa
    80021892:	413485b3          	sub	a1,s1,s3
    80021896:	06b2                	slli	a3,a3,0xc
    80021898:	858d                	srai	a1,a1,0x3
    8002189a:	8552                	mv	a0,s4
    8002189c:	fffff097          	auipc	ra,0xfffff
    800218a0:	8f4080e7          	jalr	-1804(ra) # 80020190 <printf>
          for (pte_t *pte3 = (pte_t *) pt3; pte3 < pt3 + capacity; pte3++)
    800218a4:	04a1                	addi	s1,s1,8
    800218a6:	01248763          	beq	s1,s2,800218b4 <vmprint+0x7c>
            if (*pte3 & PTE_V)
    800218aa:	6090                	ld	a2,0(s1)
    800218ac:	00167793          	andi	a5,a2,1
    800218b0:	dbf5                	beqz	a5,800218a4 <vmprint+0x6c>
    800218b2:	bff1                	j	8002188e <vmprint+0x56>
      for (pte_t *pte2 = (pte_t *) pt2; pte2 < pt2 + capacity; pte2++) {
    800218b4:	0aa1                	addi	s5,s5,8
    800218b6:	056a8163          	beq	s5,s6,800218f8 <vmprint+0xc0>
        if (*pte2 & PTE_V)
    800218ba:	000ab603          	ld	a2,0(s5)
    800218be:	00167793          	andi	a5,a2,1
    800218c2:	dbed                	beqz	a5,800218b4 <vmprint+0x7c>
          pagetable_t pt3 = (pagetable_t) PTE2PA(*pte2);
    800218c4:	00a65493          	srli	s1,a2,0xa
    800218c8:	04b2                	slli	s1,s1,0xc
    800218ca:	89a6                	mv	s3,s1
          printf(".. ..%d: pte %p pa %p\n", pte2 - pt2, *pte2, pt3);
    800218cc:	419a85b3          	sub	a1,s5,s9
    800218d0:	86a6                	mv	a3,s1
    800218d2:	858d                	srai	a1,a1,0x3
    800218d4:	856e                	mv	a0,s11
    800218d6:	fffff097          	auipc	ra,0xfffff
    800218da:	8ba080e7          	jalr	-1862(ra) # 80020190 <printf>
          for (pte_t *pte3 = (pte_t *) pt3; pte3 < pt3 + capacity; pte3++)
    800218de:	00848693          	addi	a3,s1,8
    800218e2:	01848733          	add	a4,s1,s8
    800218e6:	f8843783          	ld	a5,-120(s0)
    800218ea:	00d77363          	bgeu	a4,a3,800218f0 <vmprint+0xb8>
    800218ee:	4785                	li	a5,1
    800218f0:	078e                	slli	a5,a5,0x3
    800218f2:	00978933          	add	s2,a5,s1
    800218f6:	bf55                	j	800218aa <vmprint+0x72>
  for (pte_t *pte = (pte_t *) pagetable; pte < pagetable + capacity; pte++) {
    800218f8:	0ba1                	addi	s7,s7,8
    800218fa:	05ab8763          	beq	s7,s10,80021948 <vmprint+0x110>
    if (*pte & PTE_V)
    800218fe:	000bb603          	ld	a2,0(s7) # 1000 <BASE_ADDRESS-0x8001f000>
    80021902:	00167793          	andi	a5,a2,1
    80021906:	dbed                	beqz	a5,800218f8 <vmprint+0xc0>
      pagetable_t pt2 = (pagetable_t) PTE2PA(*pte); 
    80021908:	00a65a93          	srli	s5,a2,0xa
    8002190c:	0ab2                	slli	s5,s5,0xc
    8002190e:	8cd6                	mv	s9,s5
      printf("..%d: pte %p pa %p\n", pte - pagetable, *pte, pt2);
    80021910:	f8043783          	ld	a5,-128(s0)
    80021914:	40fb87b3          	sub	a5,s7,a5
    80021918:	86d6                	mv	a3,s5
    8002191a:	4037d593          	srai	a1,a5,0x3
    8002191e:	0000a517          	auipc	a0,0xa
    80021922:	afa50513          	addi	a0,a0,-1286 # 8002b418 <etext+0x418>
    80021926:	fffff097          	auipc	ra,0xfffff
    8002192a:	86a080e7          	jalr	-1942(ra) # 80020190 <printf>
      for (pte_t *pte2 = (pte_t *) pt2; pte2 < pt2 + capacity; pte2++) {
    8002192e:	018a86b3          	add	a3,s5,s8
    80021932:	008a8713          	addi	a4,s5,8
    80021936:	20000793          	li	a5,512
    8002193a:	00e6f363          	bgeu	a3,a4,80021940 <vmprint+0x108>
    8002193e:	4785                	li	a5,1
    80021940:	078e                	slli	a5,a5,0x3
    80021942:	01578b33          	add	s6,a5,s5
    80021946:	bf95                	j	800218ba <vmprint+0x82>
        }
      }
    }
  }
  return;
    80021948:	70e6                	ld	ra,120(sp)
    8002194a:	7446                	ld	s0,112(sp)
    8002194c:	74a6                	ld	s1,104(sp)
    8002194e:	7906                	ld	s2,96(sp)
    80021950:	69e6                	ld	s3,88(sp)
    80021952:	6a46                	ld	s4,80(sp)
    80021954:	6aa6                	ld	s5,72(sp)
    80021956:	6b06                	ld	s6,64(sp)
    80021958:	7be2                	ld	s7,56(sp)
    8002195a:	7c42                	ld	s8,48(sp)
    8002195c:	7ca2                	ld	s9,40(sp)
    8002195e:	7d02                	ld	s10,32(sp)
    80021960:	6de2                	ld	s11,24(sp)
    80021962:	6109                	addi	sp,sp,128
    80021964:	8082                	ret

0000000080021966 <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    80021966:	1101                	addi	sp,sp,-32
    80021968:	ec06                	sd	ra,24(sp)
    8002196a:	e822                	sd	s0,16(sp)
    8002196c:	e426                	sd	s1,8(sp)
    8002196e:	1000                	addi	s0,sp,32
    80021970:	84aa                	mv	s1,a0
    if(!holding(&p->lock))
    80021972:	fffff097          	auipc	ra,0xfffff
    80021976:	d20080e7          	jalr	-736(ra) # 80020692 <holding>
    8002197a:	c909                	beqz	a0,8002198c <wakeup1+0x26>
        panic("wakeup1");
    if(p->chan == p && p->state == SLEEPING) {
    8002197c:	749c                	ld	a5,40(s1)
    8002197e:	00978f63          	beq	a5,s1,8002199c <wakeup1+0x36>
        p->state = RUNNABLE;
    }
}
    80021982:	60e2                	ld	ra,24(sp)
    80021984:	6442                	ld	s0,16(sp)
    80021986:	64a2                	ld	s1,8(sp)
    80021988:	6105                	addi	sp,sp,32
    8002198a:	8082                	ret
        panic("wakeup1");
    8002198c:	0000a517          	auipc	a0,0xa
    80021990:	b0450513          	addi	a0,a0,-1276 # 8002b490 <states.1738+0x28>
    80021994:	ffffe097          	auipc	ra,0xffffe
    80021998:	7b2080e7          	jalr	1970(ra) # 80020146 <panic>
    if(p->chan == p && p->state == SLEEPING) {
    8002199c:	4c98                	lw	a4,24(s1)
    8002199e:	4785                	li	a5,1
    800219a0:	fef711e3          	bne	a4,a5,80021982 <wakeup1+0x1c>
        p->state = RUNNABLE;
    800219a4:	4789                	li	a5,2
    800219a6:	cc9c                	sw	a5,24(s1)
}
    800219a8:	bfe9                	j	80021982 <wakeup1+0x1c>

00000000800219aa <reg_info>:
void reg_info(void) {
    800219aa:	1141                	addi	sp,sp,-16
    800219ac:	e406                	sd	ra,8(sp)
    800219ae:	e022                	sd	s0,0(sp)
    800219b0:	0800                	addi	s0,sp,16
    printf("register info: {\n");
    800219b2:	0000a517          	auipc	a0,0xa
    800219b6:	ae650513          	addi	a0,a0,-1306 # 8002b498 <states.1738+0x30>
    800219ba:	ffffe097          	auipc	ra,0xffffe
    800219be:	7d6080e7          	jalr	2006(ra) # 80020190 <printf>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800219c2:	100025f3          	csrr	a1,sstatus
    printf("sstatus: %p\n", r_sstatus());
    800219c6:	0000a517          	auipc	a0,0xa
    800219ca:	aea50513          	addi	a0,a0,-1302 # 8002b4b0 <states.1738+0x48>
    800219ce:	ffffe097          	auipc	ra,0xffffe
    800219d2:	7c2080e7          	jalr	1986(ra) # 80020190 <printf>
  asm volatile("csrr %0, sip" : "=r" (x) );
    800219d6:	144025f3          	csrr	a1,sip
    printf("sip: %p\n", r_sip());
    800219da:	0000a517          	auipc	a0,0xa
    800219de:	ae650513          	addi	a0,a0,-1306 # 8002b4c0 <states.1738+0x58>
    800219e2:	ffffe097          	auipc	ra,0xffffe
    800219e6:	7ae080e7          	jalr	1966(ra) # 80020190 <printf>
  asm volatile("csrr %0, sie" : "=r" (x) );
    800219ea:	104025f3          	csrr	a1,sie
    printf("sie: %p\n", r_sie());
    800219ee:	0000a517          	auipc	a0,0xa
    800219f2:	ae250513          	addi	a0,a0,-1310 # 8002b4d0 <states.1738+0x68>
    800219f6:	ffffe097          	auipc	ra,0xffffe
    800219fa:	79a080e7          	jalr	1946(ra) # 80020190 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800219fe:	141025f3          	csrr	a1,sepc
    printf("sepc: %p\n", r_sepc());
    80021a02:	0000a517          	auipc	a0,0xa
    80021a06:	ade50513          	addi	a0,a0,-1314 # 8002b4e0 <states.1738+0x78>
    80021a0a:	ffffe097          	auipc	ra,0xffffe
    80021a0e:	786080e7          	jalr	1926(ra) # 80020190 <printf>
  asm volatile("csrr %0, stvec" : "=r" (x) );
    80021a12:	105025f3          	csrr	a1,stvec
    printf("stvec: %p\n", r_stvec());
    80021a16:	0000a517          	auipc	a0,0xa
    80021a1a:	ada50513          	addi	a0,a0,-1318 # 8002b4f0 <states.1738+0x88>
    80021a1e:	ffffe097          	auipc	ra,0xffffe
    80021a22:	772080e7          	jalr	1906(ra) # 80020190 <printf>
  asm volatile("csrr %0, satp" : "=r" (x) );
    80021a26:	180025f3          	csrr	a1,satp
    printf("satp: %p\n", r_satp());
    80021a2a:	0000a517          	auipc	a0,0xa
    80021a2e:	ad650513          	addi	a0,a0,-1322 # 8002b500 <states.1738+0x98>
    80021a32:	ffffe097          	auipc	ra,0xffffe
    80021a36:	75e080e7          	jalr	1886(ra) # 80020190 <printf>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80021a3a:	142025f3          	csrr	a1,scause
    printf("scause: %p\n", r_scause());
    80021a3e:	0000a517          	auipc	a0,0xa
    80021a42:	ad250513          	addi	a0,a0,-1326 # 8002b510 <states.1738+0xa8>
    80021a46:	ffffe097          	auipc	ra,0xffffe
    80021a4a:	74a080e7          	jalr	1866(ra) # 80020190 <printf>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80021a4e:	143025f3          	csrr	a1,stval
    printf("stval: %p\n", r_stval());
    80021a52:	0000a517          	auipc	a0,0xa
    80021a56:	ace50513          	addi	a0,a0,-1330 # 8002b520 <states.1738+0xb8>
    80021a5a:	ffffe097          	auipc	ra,0xffffe
    80021a5e:	736080e7          	jalr	1846(ra) # 80020190 <printf>
  asm volatile("mv %0, sp" : "=r" (x) );
    80021a62:	858a                	mv	a1,sp
    printf("sp: %p\n", r_sp());
    80021a64:	0000a517          	auipc	a0,0xa
    80021a68:	acc50513          	addi	a0,a0,-1332 # 8002b530 <states.1738+0xc8>
    80021a6c:	ffffe097          	auipc	ra,0xffffe
    80021a70:	724080e7          	jalr	1828(ra) # 80020190 <printf>
  asm volatile("mv %0, tp" : "=r" (x) );
    80021a74:	8592                	mv	a1,tp
    printf("tp: %p\n", r_tp());
    80021a76:	0000a517          	auipc	a0,0xa
    80021a7a:	ac250513          	addi	a0,a0,-1342 # 8002b538 <states.1738+0xd0>
    80021a7e:	ffffe097          	auipc	ra,0xffffe
    80021a82:	712080e7          	jalr	1810(ra) # 80020190 <printf>
  asm volatile("mv %0, ra" : "=r" (x) );
    80021a86:	8586                	mv	a1,ra
    printf("ra: %p\n", r_ra());
    80021a88:	0000a517          	auipc	a0,0xa
    80021a8c:	ab850513          	addi	a0,a0,-1352 # 8002b540 <states.1738+0xd8>
    80021a90:	ffffe097          	auipc	ra,0xffffe
    80021a94:	700080e7          	jalr	1792(ra) # 80020190 <printf>
    printf("}\n");
    80021a98:	0000a517          	auipc	a0,0xa
    80021a9c:	ab050513          	addi	a0,a0,-1360 # 8002b548 <states.1738+0xe0>
    80021aa0:	ffffe097          	auipc	ra,0xffffe
    80021aa4:	6f0080e7          	jalr	1776(ra) # 80020190 <printf>
}
    80021aa8:	60a2                	ld	ra,8(sp)
    80021aaa:	6402                	ld	s0,0(sp)
    80021aac:	0141                	addi	sp,sp,16
    80021aae:	8082                	ret

0000000080021ab0 <procinit>:
{
    80021ab0:	7179                	addi	sp,sp,-48
    80021ab2:	f406                	sd	ra,40(sp)
    80021ab4:	f022                	sd	s0,32(sp)
    80021ab6:	ec26                	sd	s1,24(sp)
    80021ab8:	e84a                	sd	s2,16(sp)
    80021aba:	e44e                	sd	s3,8(sp)
    80021abc:	1800                	addi	s0,sp,48
    initlock(&pid_lock, "nextpid");
    80021abe:	0000a597          	auipc	a1,0xa
    80021ac2:	a9258593          	addi	a1,a1,-1390 # 8002b550 <states.1738+0xe8>
    80021ac6:	00014517          	auipc	a0,0x14
    80021aca:	59a50513          	addi	a0,a0,1434 # 80036060 <pid_lock>
    80021ace:	fffff097          	auipc	ra,0xfffff
    80021ad2:	bae080e7          	jalr	-1106(ra) # 8002067c <initlock>
    for(p = proc; p < &proc[NPROC]; p++) {
    80021ad6:	00014497          	auipc	s1,0x14
    80021ada:	6a248493          	addi	s1,s1,1698 # 80036178 <proc>
        initlock(&p->lock, "proc");
    80021ade:	0000a997          	auipc	s3,0xa
    80021ae2:	a7a98993          	addi	s3,s3,-1414 # 8002b558 <states.1738+0xf0>
    for(p = proc; p < &proc[NPROC]; p++) {
    80021ae6:	00019917          	auipc	s2,0x19
    80021aea:	00290913          	addi	s2,s2,2 # 8003aae8 <initproc>
        initlock(&p->lock, "proc");
    80021aee:	85ce                	mv	a1,s3
    80021af0:	8526                	mv	a0,s1
    80021af2:	fffff097          	auipc	ra,0xfffff
    80021af6:	b8a080e7          	jalr	-1142(ra) # 8002067c <initlock>
    for(p = proc; p < &proc[NPROC]; p++) {
    80021afa:	17848493          	addi	s1,s1,376
    80021afe:	ff2498e3          	bne	s1,s2,80021aee <procinit+0x3e>
    memset(cpus, 0, sizeof(cpus));
    80021b02:	10000613          	li	a2,256
    80021b06:	4581                	li	a1,0
    80021b08:	00014517          	auipc	a0,0x14
    80021b0c:	57050513          	addi	a0,a0,1392 # 80036078 <cpus>
    80021b10:	fffff097          	auipc	ra,0xfffff
    80021b14:	c4c080e7          	jalr	-948(ra) # 8002075c <memset>
}
    80021b18:	70a2                	ld	ra,40(sp)
    80021b1a:	7402                	ld	s0,32(sp)
    80021b1c:	64e2                	ld	s1,24(sp)
    80021b1e:	6942                	ld	s2,16(sp)
    80021b20:	69a2                	ld	s3,8(sp)
    80021b22:	6145                	addi	sp,sp,48
    80021b24:	8082                	ret

0000000080021b26 <cpuid>:
{
    80021b26:	1141                	addi	sp,sp,-16
    80021b28:	e422                	sd	s0,8(sp)
    80021b2a:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80021b2c:	8512                	mv	a0,tp
}
    80021b2e:	2501                	sext.w	a0,a0
    80021b30:	6422                	ld	s0,8(sp)
    80021b32:	0141                	addi	sp,sp,16
    80021b34:	8082                	ret

0000000080021b36 <mycpu>:
mycpu(void) {
    80021b36:	1141                	addi	sp,sp,-16
    80021b38:	e422                	sd	s0,8(sp)
    80021b3a:	0800                	addi	s0,sp,16
    80021b3c:	8792                	mv	a5,tp
    struct cpu *c = &cpus[id];
    80021b3e:	2781                	sext.w	a5,a5
    80021b40:	079e                	slli	a5,a5,0x7
}
    80021b42:	00014517          	auipc	a0,0x14
    80021b46:	53650513          	addi	a0,a0,1334 # 80036078 <cpus>
    80021b4a:	953e                	add	a0,a0,a5
    80021b4c:	6422                	ld	s0,8(sp)
    80021b4e:	0141                	addi	sp,sp,16
    80021b50:	8082                	ret

0000000080021b52 <myproc>:
myproc(void) {
    80021b52:	1101                	addi	sp,sp,-32
    80021b54:	ec06                	sd	ra,24(sp)
    80021b56:	e822                	sd	s0,16(sp)
    80021b58:	e426                	sd	s1,8(sp)
    80021b5a:	1000                	addi	s0,sp,32
    push_off();
    80021b5c:	fffff097          	auipc	ra,0xfffff
    80021b60:	a74080e7          	jalr	-1420(ra) # 800205d0 <push_off>
    80021b64:	8792                	mv	a5,tp
    struct proc *p = c->proc;
    80021b66:	2781                	sext.w	a5,a5
    80021b68:	079e                	slli	a5,a5,0x7
    80021b6a:	00014717          	auipc	a4,0x14
    80021b6e:	4f670713          	addi	a4,a4,1270 # 80036060 <pid_lock>
    80021b72:	97ba                	add	a5,a5,a4
    80021b74:	6f84                	ld	s1,24(a5)
    pop_off();
    80021b76:	fffff097          	auipc	ra,0xfffff
    80021b7a:	aa6080e7          	jalr	-1370(ra) # 8002061c <pop_off>
}
    80021b7e:	8526                	mv	a0,s1
    80021b80:	60e2                	ld	ra,24(sp)
    80021b82:	6442                	ld	s0,16(sp)
    80021b84:	64a2                	ld	s1,8(sp)
    80021b86:	6105                	addi	sp,sp,32
    80021b88:	8082                	ret

0000000080021b8a <forkret>:
{
    80021b8a:	1101                	addi	sp,sp,-32
    80021b8c:	ec06                	sd	ra,24(sp)
    80021b8e:	e822                	sd	s0,16(sp)
    80021b90:	e426                	sd	s1,8(sp)
    80021b92:	1000                	addi	s0,sp,32
    release(&myproc()->lock);
    80021b94:	00000097          	auipc	ra,0x0
    80021b98:	fbe080e7          	jalr	-66(ra) # 80021b52 <myproc>
    80021b9c:	fffff097          	auipc	ra,0xfffff
    80021ba0:	b78080e7          	jalr	-1160(ra) # 80020714 <release>
    if (first) {
    80021ba4:	0000c797          	auipc	a5,0xc
    80021ba8:	fcc78793          	addi	a5,a5,-52 # 8002db70 <first.1700>
    80021bac:	439c                	lw	a5,0(a5)
    80021bae:	eb91                	bnez	a5,80021bc2 <forkret+0x38>
    usertrapret();
    80021bb0:	00001097          	auipc	ra,0x1
    80021bb4:	c74080e7          	jalr	-908(ra) # 80022824 <usertrapret>
}
    80021bb8:	60e2                	ld	ra,24(sp)
    80021bba:	6442                	ld	s0,16(sp)
    80021bbc:	64a2                	ld	s1,8(sp)
    80021bbe:	6105                	addi	sp,sp,32
    80021bc0:	8082                	ret
        first = 0;
    80021bc2:	0000c797          	auipc	a5,0xc
    80021bc6:	fa07a723          	sw	zero,-82(a5) # 8002db70 <first.1700>
        fat32_init();
    80021bca:	00004097          	auipc	ra,0x4
    80021bce:	c9e080e7          	jalr	-866(ra) # 80025868 <fat32_init>
        myproc()->cwd = ename("/");
    80021bd2:	00000097          	auipc	ra,0x0
    80021bd6:	f80080e7          	jalr	-128(ra) # 80021b52 <myproc>
    80021bda:	84aa                	mv	s1,a0
    80021bdc:	0000a517          	auipc	a0,0xa
    80021be0:	98450513          	addi	a0,a0,-1660 # 8002b560 <states.1738+0xf8>
    80021be4:	00005097          	auipc	ra,0x5
    80021be8:	ebe080e7          	jalr	-322(ra) # 80026aa2 <ename>
    80021bec:	14a4bc23          	sd	a0,344(s1)
    80021bf0:	b7c1                	j	80021bb0 <forkret+0x26>

0000000080021bf2 <allocpid>:
allocpid() {
    80021bf2:	1101                	addi	sp,sp,-32
    80021bf4:	ec06                	sd	ra,24(sp)
    80021bf6:	e822                	sd	s0,16(sp)
    80021bf8:	e426                	sd	s1,8(sp)
    80021bfa:	e04a                	sd	s2,0(sp)
    80021bfc:	1000                	addi	s0,sp,32
    acquire(&pid_lock);
    80021bfe:	00014917          	auipc	s2,0x14
    80021c02:	46290913          	addi	s2,s2,1122 # 80036060 <pid_lock>
    80021c06:	854a                	mv	a0,s2
    80021c08:	fffff097          	auipc	ra,0xfffff
    80021c0c:	ab8080e7          	jalr	-1352(ra) # 800206c0 <acquire>
    pid = nextpid;
    80021c10:	0000c797          	auipc	a5,0xc
    80021c14:	f6478793          	addi	a5,a5,-156 # 8002db74 <nextpid>
    80021c18:	4384                	lw	s1,0(a5)
    nextpid = nextpid + 1;
    80021c1a:	0014871b          	addiw	a4,s1,1
    80021c1e:	c398                	sw	a4,0(a5)
    release(&pid_lock);
    80021c20:	854a                	mv	a0,s2
    80021c22:	fffff097          	auipc	ra,0xfffff
    80021c26:	af2080e7          	jalr	-1294(ra) # 80020714 <release>
}
    80021c2a:	8526                	mv	a0,s1
    80021c2c:	60e2                	ld	ra,24(sp)
    80021c2e:	6442                	ld	s0,16(sp)
    80021c30:	64a2                	ld	s1,8(sp)
    80021c32:	6902                	ld	s2,0(sp)
    80021c34:	6105                	addi	sp,sp,32
    80021c36:	8082                	ret

0000000080021c38 <proc_pagetable>:
{
    80021c38:	1101                	addi	sp,sp,-32
    80021c3a:	ec06                	sd	ra,24(sp)
    80021c3c:	e822                	sd	s0,16(sp)
    80021c3e:	e426                	sd	s1,8(sp)
    80021c40:	e04a                	sd	s2,0(sp)
    80021c42:	1000                	addi	s0,sp,32
    80021c44:	892a                	mv	s2,a0
    pagetable = uvmcreate();
    80021c46:	fffff097          	auipc	ra,0xfffff
    80021c4a:	38a080e7          	jalr	906(ra) # 80020fd0 <uvmcreate>
    80021c4e:	84aa                	mv	s1,a0
    if(pagetable == 0)
    80021c50:	c121                	beqz	a0,80021c90 <proc_pagetable+0x58>
    if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80021c52:	4729                	li	a4,10
    80021c54:	00008697          	auipc	a3,0x8
    80021c58:	3ac68693          	addi	a3,a3,940 # 8002a000 <_trampoline>
    80021c5c:	6605                	lui	a2,0x1
    80021c5e:	040005b7          	lui	a1,0x4000
    80021c62:	15fd                	addi	a1,a1,-1
    80021c64:	05b2                	slli	a1,a1,0xc
    80021c66:	fffff097          	auipc	ra,0xfffff
    80021c6a:	04a080e7          	jalr	74(ra) # 80020cb0 <mappages>
    80021c6e:	02054863          	bltz	a0,80021c9e <proc_pagetable+0x66>
    if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80021c72:	4719                	li	a4,6
    80021c74:	06093683          	ld	a3,96(s2)
    80021c78:	6605                	lui	a2,0x1
    80021c7a:	020005b7          	lui	a1,0x2000
    80021c7e:	15fd                	addi	a1,a1,-1
    80021c80:	05b6                	slli	a1,a1,0xd
    80021c82:	8526                	mv	a0,s1
    80021c84:	fffff097          	auipc	ra,0xfffff
    80021c88:	02c080e7          	jalr	44(ra) # 80020cb0 <mappages>
    80021c8c:	02054163          	bltz	a0,80021cae <proc_pagetable+0x76>
}
    80021c90:	8526                	mv	a0,s1
    80021c92:	60e2                	ld	ra,24(sp)
    80021c94:	6442                	ld	s0,16(sp)
    80021c96:	64a2                	ld	s1,8(sp)
    80021c98:	6902                	ld	s2,0(sp)
    80021c9a:	6105                	addi	sp,sp,32
    80021c9c:	8082                	ret
        uvmfree(pagetable, 0);
    80021c9e:	4581                	li	a1,0
    80021ca0:	8526                	mv	a0,s1
    80021ca2:	fffff097          	auipc	ra,0xfffff
    80021ca6:	5b2080e7          	jalr	1458(ra) # 80021254 <uvmfree>
        return NULL;
    80021caa:	4481                	li	s1,0
    80021cac:	b7d5                	j	80021c90 <proc_pagetable+0x58>
        vmunmap(pagetable, TRAMPOLINE, 1, 0);
    80021cae:	4681                	li	a3,0
    80021cb0:	4605                	li	a2,1
    80021cb2:	040005b7          	lui	a1,0x4000
    80021cb6:	15fd                	addi	a1,a1,-1
    80021cb8:	05b2                	slli	a1,a1,0xc
    80021cba:	8526                	mv	a0,s1
    80021cbc:	fffff097          	auipc	ra,0xfffff
    80021cc0:	250080e7          	jalr	592(ra) # 80020f0c <vmunmap>
        uvmfree(pagetable, 0);
    80021cc4:	4581                	li	a1,0
    80021cc6:	8526                	mv	a0,s1
    80021cc8:	fffff097          	auipc	ra,0xfffff
    80021ccc:	58c080e7          	jalr	1420(ra) # 80021254 <uvmfree>
        return NULL;
    80021cd0:	4481                	li	s1,0
    80021cd2:	bf7d                	j	80021c90 <proc_pagetable+0x58>

0000000080021cd4 <proc_freepagetable>:
{
    80021cd4:	1101                	addi	sp,sp,-32
    80021cd6:	ec06                	sd	ra,24(sp)
    80021cd8:	e822                	sd	s0,16(sp)
    80021cda:	e426                	sd	s1,8(sp)
    80021cdc:	e04a                	sd	s2,0(sp)
    80021cde:	1000                	addi	s0,sp,32
    80021ce0:	84aa                	mv	s1,a0
    80021ce2:	892e                	mv	s2,a1
    vmunmap(pagetable, TRAMPOLINE, 1, 0);
    80021ce4:	4681                	li	a3,0
    80021ce6:	4605                	li	a2,1
    80021ce8:	040005b7          	lui	a1,0x4000
    80021cec:	15fd                	addi	a1,a1,-1
    80021cee:	05b2                	slli	a1,a1,0xc
    80021cf0:	fffff097          	auipc	ra,0xfffff
    80021cf4:	21c080e7          	jalr	540(ra) # 80020f0c <vmunmap>
    vmunmap(pagetable, TRAPFRAME, 1, 0);
    80021cf8:	4681                	li	a3,0
    80021cfa:	4605                	li	a2,1
    80021cfc:	020005b7          	lui	a1,0x2000
    80021d00:	15fd                	addi	a1,a1,-1
    80021d02:	05b6                	slli	a1,a1,0xd
    80021d04:	8526                	mv	a0,s1
    80021d06:	fffff097          	auipc	ra,0xfffff
    80021d0a:	206080e7          	jalr	518(ra) # 80020f0c <vmunmap>
    uvmfree(pagetable, sz);
    80021d0e:	85ca                	mv	a1,s2
    80021d10:	8526                	mv	a0,s1
    80021d12:	fffff097          	auipc	ra,0xfffff
    80021d16:	542080e7          	jalr	1346(ra) # 80021254 <uvmfree>
}
    80021d1a:	60e2                	ld	ra,24(sp)
    80021d1c:	6442                	ld	s0,16(sp)
    80021d1e:	64a2                	ld	s1,8(sp)
    80021d20:	6902                	ld	s2,0(sp)
    80021d22:	6105                	addi	sp,sp,32
    80021d24:	8082                	ret

0000000080021d26 <freeproc>:
{
    80021d26:	1101                	addi	sp,sp,-32
    80021d28:	ec06                	sd	ra,24(sp)
    80021d2a:	e822                	sd	s0,16(sp)
    80021d2c:	e426                	sd	s1,8(sp)
    80021d2e:	1000                	addi	s0,sp,32
    80021d30:	84aa                	mv	s1,a0
    if(p->trapframe)
    80021d32:	7128                	ld	a0,96(a0)
    80021d34:	c509                	beqz	a0,80021d3e <freeproc+0x18>
        kfree((void*)p->trapframe);
    80021d36:	ffffe097          	auipc	ra,0xffffe
    80021d3a:	702080e7          	jalr	1794(ra) # 80020438 <kfree>
    p->trapframe = 0;
    80021d3e:	0604b023          	sd	zero,96(s1)
    if (p->kpagetable) {
    80021d42:	6ca8                	ld	a0,88(s1)
    80021d44:	c511                	beqz	a0,80021d50 <freeproc+0x2a>
        kvmfree(p->kpagetable, 1);
    80021d46:	4585                	li	a1,1
    80021d48:	00000097          	auipc	ra,0x0
    80021d4c:	a2e080e7          	jalr	-1490(ra) # 80021776 <kvmfree>
    p->kpagetable = 0;
    80021d50:	0404bc23          	sd	zero,88(s1)
    if(p->pagetable)
    80021d54:	68a8                	ld	a0,80(s1)
    80021d56:	c511                	beqz	a0,80021d62 <freeproc+0x3c>
        proc_freepagetable(p->pagetable, p->sz);
    80021d58:	64ac                	ld	a1,72(s1)
    80021d5a:	00000097          	auipc	ra,0x0
    80021d5e:	f7a080e7          	jalr	-134(ra) # 80021cd4 <proc_freepagetable>
    p->pagetable = 0;
    80021d62:	0404b823          	sd	zero,80(s1)
    p->sz = 0;
    80021d66:	0404b423          	sd	zero,72(s1)
    p->pid = 0;
    80021d6a:	0204ac23          	sw	zero,56(s1)
    p->parent = 0;
    80021d6e:	0204b023          	sd	zero,32(s1)
    p->name[0] = 0;
    80021d72:	16048023          	sb	zero,352(s1)
    p->chan = 0;
    80021d76:	0204b423          	sd	zero,40(s1)
    p->killed = 0;
    80021d7a:	0204a823          	sw	zero,48(s1)
    p->xstate = 0;
    80021d7e:	0204aa23          	sw	zero,52(s1)
    p->state = UNUSED;
    80021d82:	0004ac23          	sw	zero,24(s1)
}
    80021d86:	60e2                	ld	ra,24(sp)
    80021d88:	6442                	ld	s0,16(sp)
    80021d8a:	64a2                	ld	s1,8(sp)
    80021d8c:	6105                	addi	sp,sp,32
    80021d8e:	8082                	ret

0000000080021d90 <allocproc>:
{
    80021d90:	1101                	addi	sp,sp,-32
    80021d92:	ec06                	sd	ra,24(sp)
    80021d94:	e822                	sd	s0,16(sp)
    80021d96:	e426                	sd	s1,8(sp)
    80021d98:	e04a                	sd	s2,0(sp)
    80021d9a:	1000                	addi	s0,sp,32
    for(p = proc; p < &proc[NPROC]; p++) {
    80021d9c:	00014497          	auipc	s1,0x14
    80021da0:	3dc48493          	addi	s1,s1,988 # 80036178 <proc>
    80021da4:	00019917          	auipc	s2,0x19
    80021da8:	d4490913          	addi	s2,s2,-700 # 8003aae8 <initproc>
        acquire(&p->lock);
    80021dac:	8526                	mv	a0,s1
    80021dae:	fffff097          	auipc	ra,0xfffff
    80021db2:	912080e7          	jalr	-1774(ra) # 800206c0 <acquire>
        if(p->state == UNUSED) {
    80021db6:	4c9c                	lw	a5,24(s1)
    80021db8:	cf81                	beqz	a5,80021dd0 <allocproc+0x40>
            release(&p->lock);
    80021dba:	8526                	mv	a0,s1
    80021dbc:	fffff097          	auipc	ra,0xfffff
    80021dc0:	958080e7          	jalr	-1704(ra) # 80020714 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80021dc4:	17848493          	addi	s1,s1,376
    80021dc8:	ff2492e3          	bne	s1,s2,80021dac <allocproc+0x1c>
    return NULL;
    80021dcc:	4481                	li	s1,0
    80021dce:	a085                	j	80021e2e <allocproc+0x9e>
    p->pid = allocpid();
    80021dd0:	00000097          	auipc	ra,0x0
    80021dd4:	e22080e7          	jalr	-478(ra) # 80021bf2 <allocpid>
    80021dd8:	dc88                	sw	a0,56(s1)
    if((p->trapframe = (struct trapframe *)kalloc()) == NULL){
    80021dda:	ffffe097          	auipc	ra,0xffffe
    80021dde:	778080e7          	jalr	1912(ra) # 80020552 <kalloc>
    80021de2:	892a                	mv	s2,a0
    80021de4:	f0a8                	sd	a0,96(s1)
    80021de6:	c939                	beqz	a0,80021e3c <allocproc+0xac>
    if ((p->pagetable = proc_pagetable(p)) == NULL ||
    80021de8:	8526                	mv	a0,s1
    80021dea:	00000097          	auipc	ra,0x0
    80021dee:	e4e080e7          	jalr	-434(ra) # 80021c38 <proc_pagetable>
    80021df2:	e8a8                	sd	a0,80(s1)
    80021df4:	c939                	beqz	a0,80021e4a <allocproc+0xba>
        (p->kpagetable = proc_kpagetable()) == NULL) {
    80021df6:	00000097          	auipc	ra,0x0
    80021dfa:	9da080e7          	jalr	-1574(ra) # 800217d0 <proc_kpagetable>
    80021dfe:	eca8                	sd	a0,88(s1)
    if ((p->pagetable = proc_pagetable(p)) == NULL ||
    80021e00:	c529                	beqz	a0,80021e4a <allocproc+0xba>
    p->kstack = VKSTACK;
    80021e02:	0fb00793          	li	a5,251
    80021e06:	07fa                	slli	a5,a5,0x1e
    80021e08:	e0bc                	sd	a5,64(s1)
    memset(&p->context, 0, sizeof(p->context));
    80021e0a:	07000613          	li	a2,112
    80021e0e:	4581                	li	a1,0
    80021e10:	06848513          	addi	a0,s1,104
    80021e14:	fffff097          	auipc	ra,0xfffff
    80021e18:	948080e7          	jalr	-1720(ra) # 8002075c <memset>
    p->context.ra = (uint64)forkret;
    80021e1c:	00000797          	auipc	a5,0x0
    80021e20:	d6e78793          	addi	a5,a5,-658 # 80021b8a <forkret>
    80021e24:	f4bc                	sd	a5,104(s1)
    p->context.sp = p->kstack + PGSIZE;
    80021e26:	60bc                	ld	a5,64(s1)
    80021e28:	6705                	lui	a4,0x1
    80021e2a:	97ba                	add	a5,a5,a4
    80021e2c:	f8bc                	sd	a5,112(s1)
}
    80021e2e:	8526                	mv	a0,s1
    80021e30:	60e2                	ld	ra,24(sp)
    80021e32:	6442                	ld	s0,16(sp)
    80021e34:	64a2                	ld	s1,8(sp)
    80021e36:	6902                	ld	s2,0(sp)
    80021e38:	6105                	addi	sp,sp,32
    80021e3a:	8082                	ret
        release(&p->lock);
    80021e3c:	8526                	mv	a0,s1
    80021e3e:	fffff097          	auipc	ra,0xfffff
    80021e42:	8d6080e7          	jalr	-1834(ra) # 80020714 <release>
        return NULL;
    80021e46:	84ca                	mv	s1,s2
    80021e48:	b7dd                	j	80021e2e <allocproc+0x9e>
        freeproc(p);
    80021e4a:	8526                	mv	a0,s1
    80021e4c:	00000097          	auipc	ra,0x0
    80021e50:	eda080e7          	jalr	-294(ra) # 80021d26 <freeproc>
        release(&p->lock);
    80021e54:	8526                	mv	a0,s1
    80021e56:	fffff097          	auipc	ra,0xfffff
    80021e5a:	8be080e7          	jalr	-1858(ra) # 80020714 <release>
        return NULL;
    80021e5e:	4481                	li	s1,0
    80021e60:	b7f9                	j	80021e2e <allocproc+0x9e>

0000000080021e62 <userinit>:
{
    80021e62:	1101                	addi	sp,sp,-32
    80021e64:	ec06                	sd	ra,24(sp)
    80021e66:	e822                	sd	s0,16(sp)
    80021e68:	e426                	sd	s1,8(sp)
    80021e6a:	e04a                	sd	s2,0(sp)
    80021e6c:	1000                	addi	s0,sp,32
    p = allocproc();
    80021e6e:	00000097          	auipc	ra,0x0
    80021e72:	f22080e7          	jalr	-222(ra) # 80021d90 <allocproc>
    80021e76:	84aa                	mv	s1,a0
    initproc = p;
    80021e78:	00019797          	auipc	a5,0x19
    80021e7c:	c6a7b823          	sd	a0,-912(a5) # 8003aae8 <initproc>
    uvminit(p->pagetable , p->kpagetable, initcode, sizeof(initcode));
    80021e80:	6905                	lui	s2,0x1
    80021e82:	b5c90693          	addi	a3,s2,-1188 # b5c <BASE_ADDRESS-0x8001f4a4>
    80021e86:	0000b617          	auipc	a2,0xb
    80021e8a:	17a60613          	addi	a2,a2,378 # 8002d000 <initcode>
    80021e8e:	6d2c                	ld	a1,88(a0)
    80021e90:	6928                	ld	a0,80(a0)
    80021e92:	fffff097          	auipc	ra,0xfffff
    80021e96:	16c080e7          	jalr	364(ra) # 80020ffe <uvminit>
    p->sz = PGSIZE;
    80021e9a:	0524b423          	sd	s2,72(s1)
    p->trapframe->epc = 0x3E;      // user program counter
    80021e9e:	70bc                	ld	a5,96(s1)
    80021ea0:	03e00713          	li	a4,62
    80021ea4:	ef98                	sd	a4,24(a5)
    p->trapframe->sp = PGSIZE;  // user stack pointer
    80021ea6:	70bc                	ld	a5,96(s1)
    80021ea8:	0327b823          	sd	s2,48(a5)
    safestrcpy(p->name, "initcode", sizeof(p->name));
    80021eac:	4641                	li	a2,16
    80021eae:	00009597          	auipc	a1,0x9
    80021eb2:	6ba58593          	addi	a1,a1,1722 # 8002b568 <states.1738+0x100>
    80021eb6:	16048513          	addi	a0,s1,352
    80021eba:	fffff097          	auipc	ra,0xfffff
    80021ebe:	a1a080e7          	jalr	-1510(ra) # 800208d4 <safestrcpy>
    p->state = RUNNABLE;
    80021ec2:	4789                	li	a5,2
    80021ec4:	cc9c                	sw	a5,24(s1)
    p->tmask = 0;
    80021ec6:	1604a823          	sw	zero,368(s1)
    release(&p->lock);
    80021eca:	8526                	mv	a0,s1
    80021ecc:	fffff097          	auipc	ra,0xfffff
    80021ed0:	848080e7          	jalr	-1976(ra) # 80020714 <release>
}
    80021ed4:	60e2                	ld	ra,24(sp)
    80021ed6:	6442                	ld	s0,16(sp)
    80021ed8:	64a2                	ld	s1,8(sp)
    80021eda:	6902                	ld	s2,0(sp)
    80021edc:	6105                	addi	sp,sp,32
    80021ede:	8082                	ret

0000000080021ee0 <growproc>:
{
    80021ee0:	1101                	addi	sp,sp,-32
    80021ee2:	ec06                	sd	ra,24(sp)
    80021ee4:	e822                	sd	s0,16(sp)
    80021ee6:	e426                	sd	s1,8(sp)
    80021ee8:	e04a                	sd	s2,0(sp)
    80021eea:	1000                	addi	s0,sp,32
    80021eec:	84aa                	mv	s1,a0
    struct proc *p = myproc();
    80021eee:	00000097          	auipc	ra,0x0
    80021ef2:	c64080e7          	jalr	-924(ra) # 80021b52 <myproc>
    80021ef6:	892a                	mv	s2,a0
    sz = p->sz;
    80021ef8:	6530                	ld	a2,72(a0)
    80021efa:	0006051b          	sext.w	a0,a2
    if(n > 0){
    80021efe:	00904f63          	bgtz	s1,80021f1c <growproc+0x3c>
    } else if(n < 0){
    80021f02:	0204cf63          	bltz	s1,80021f40 <growproc+0x60>
    p->sz = sz;
    80021f06:	1502                	slli	a0,a0,0x20
    80021f08:	9101                	srli	a0,a0,0x20
    80021f0a:	04a93423          	sd	a0,72(s2)
    return 0;
    80021f0e:	4501                	li	a0,0
}
    80021f10:	60e2                	ld	ra,24(sp)
    80021f12:	6442                	ld	s0,16(sp)
    80021f14:	64a2                	ld	s1,8(sp)
    80021f16:	6902                	ld	s2,0(sp)
    80021f18:	6105                	addi	sp,sp,32
    80021f1a:	8082                	ret
        if((sz = uvmalloc(p->pagetable, p->kpagetable, sz, sz + n)) == 0) {
    80021f1c:	00a486bb          	addw	a3,s1,a0
    80021f20:	1682                	slli	a3,a3,0x20
    80021f22:	9281                	srli	a3,a3,0x20
    80021f24:	1602                	slli	a2,a2,0x20
    80021f26:	9201                	srli	a2,a2,0x20
    80021f28:	05893583          	ld	a1,88(s2)
    80021f2c:	05093503          	ld	a0,80(s2)
    80021f30:	fffff097          	auipc	ra,0xfffff
    80021f34:	1c4080e7          	jalr	452(ra) # 800210f4 <uvmalloc>
    80021f38:	2501                	sext.w	a0,a0
    80021f3a:	f571                	bnez	a0,80021f06 <growproc+0x26>
            return -1;
    80021f3c:	557d                	li	a0,-1
    80021f3e:	bfc9                	j	80021f10 <growproc+0x30>
        sz = uvmdealloc(p->pagetable, p->kpagetable, sz, sz + n);
    80021f40:	00a486bb          	addw	a3,s1,a0
    80021f44:	1682                	slli	a3,a3,0x20
    80021f46:	9281                	srli	a3,a3,0x20
    80021f48:	1602                	slli	a2,a2,0x20
    80021f4a:	9201                	srli	a2,a2,0x20
    80021f4c:	05893583          	ld	a1,88(s2)
    80021f50:	05093503          	ld	a0,80(s2)
    80021f54:	fffff097          	auipc	ra,0xfffff
    80021f58:	134080e7          	jalr	308(ra) # 80021088 <uvmdealloc>
    80021f5c:	2501                	sext.w	a0,a0
    80021f5e:	b765                	j	80021f06 <growproc+0x26>

0000000080021f60 <fork>:
{
    80021f60:	7179                	addi	sp,sp,-48
    80021f62:	f406                	sd	ra,40(sp)
    80021f64:	f022                	sd	s0,32(sp)
    80021f66:	ec26                	sd	s1,24(sp)
    80021f68:	e84a                	sd	s2,16(sp)
    80021f6a:	e44e                	sd	s3,8(sp)
    80021f6c:	e052                	sd	s4,0(sp)
    80021f6e:	1800                	addi	s0,sp,48
    struct proc *p = myproc();
    80021f70:	00000097          	auipc	ra,0x0
    80021f74:	be2080e7          	jalr	-1054(ra) # 80021b52 <myproc>
    80021f78:	892a                	mv	s2,a0
    if((np = allocproc()) == NULL){
    80021f7a:	00000097          	auipc	ra,0x0
    80021f7e:	e16080e7          	jalr	-490(ra) # 80021d90 <allocproc>
    80021f82:	c57d                	beqz	a0,80022070 <fork+0x110>
    80021f84:	89aa                	mv	s3,a0
    if(uvmcopy(p->pagetable, np->pagetable, np->kpagetable, p->sz) < 0){
    80021f86:	04893683          	ld	a3,72(s2)
    80021f8a:	6d30                	ld	a2,88(a0)
    80021f8c:	692c                	ld	a1,80(a0)
    80021f8e:	05093503          	ld	a0,80(s2)
    80021f92:	fffff097          	auipc	ra,0xfffff
    80021f96:	2fa080e7          	jalr	762(ra) # 8002128c <uvmcopy>
    80021f9a:	04054c63          	bltz	a0,80021ff2 <fork+0x92>
    np->sz = p->sz;
    80021f9e:	04893783          	ld	a5,72(s2)
    80021fa2:	04f9b423          	sd	a5,72(s3)
    np->parent = p;
    80021fa6:	0329b023          	sd	s2,32(s3)
    np->tmask = p->tmask;
    80021faa:	17092783          	lw	a5,368(s2)
    80021fae:	16f9a823          	sw	a5,368(s3)
    *(np->trapframe) = *(p->trapframe);
    80021fb2:	06093683          	ld	a3,96(s2)
    80021fb6:	87b6                	mv	a5,a3
    80021fb8:	0609b703          	ld	a4,96(s3)
    80021fbc:	12068693          	addi	a3,a3,288
    80021fc0:	0007b803          	ld	a6,0(a5)
    80021fc4:	6788                	ld	a0,8(a5)
    80021fc6:	6b8c                	ld	a1,16(a5)
    80021fc8:	6f90                	ld	a2,24(a5)
    80021fca:	01073023          	sd	a6,0(a4) # 1000 <BASE_ADDRESS-0x8001f000>
    80021fce:	e708                	sd	a0,8(a4)
    80021fd0:	eb0c                	sd	a1,16(a4)
    80021fd2:	ef10                	sd	a2,24(a4)
    80021fd4:	02078793          	addi	a5,a5,32
    80021fd8:	02070713          	addi	a4,a4,32
    80021fdc:	fed792e3          	bne	a5,a3,80021fc0 <fork+0x60>
    np->trapframe->a0 = 0;
    80021fe0:	0609b783          	ld	a5,96(s3)
    80021fe4:	0607b823          	sd	zero,112(a5)
    80021fe8:	0d800493          	li	s1,216
    for(i = 0; i < NOFILE; i++)
    80021fec:	15800a13          	li	s4,344
    80021ff0:	a03d                	j	8002201e <fork+0xbe>
        freeproc(np);
    80021ff2:	854e                	mv	a0,s3
    80021ff4:	00000097          	auipc	ra,0x0
    80021ff8:	d32080e7          	jalr	-718(ra) # 80021d26 <freeproc>
        release(&np->lock);
    80021ffc:	854e                	mv	a0,s3
    80021ffe:	ffffe097          	auipc	ra,0xffffe
    80022002:	716080e7          	jalr	1814(ra) # 80020714 <release>
        return -1;
    80022006:	54fd                	li	s1,-1
    80022008:	a899                	j	8002205e <fork+0xfe>
            np->ofile[i] = filedup(p->ofile[i]);
    8002200a:	00002097          	auipc	ra,0x2
    8002200e:	8da080e7          	jalr	-1830(ra) # 800238e4 <filedup>
    80022012:	009987b3          	add	a5,s3,s1
    80022016:	e388                	sd	a0,0(a5)
    80022018:	04a1                	addi	s1,s1,8
    for(i = 0; i < NOFILE; i++)
    8002201a:	01448763          	beq	s1,s4,80022028 <fork+0xc8>
        if(p->ofile[i])
    8002201e:	009907b3          	add	a5,s2,s1
    80022022:	6388                	ld	a0,0(a5)
    80022024:	f17d                	bnez	a0,8002200a <fork+0xaa>
    80022026:	bfcd                	j	80022018 <fork+0xb8>
    np->cwd = edup(p->cwd);
    80022028:	15893503          	ld	a0,344(s2)
    8002202c:	00004097          	auipc	ra,0x4
    80022030:	080080e7          	jalr	128(ra) # 800260ac <edup>
    80022034:	14a9bc23          	sd	a0,344(s3)
    safestrcpy(np->name, p->name, sizeof(p->name));
    80022038:	4641                	li	a2,16
    8002203a:	16090593          	addi	a1,s2,352
    8002203e:	16098513          	addi	a0,s3,352
    80022042:	fffff097          	auipc	ra,0xfffff
    80022046:	892080e7          	jalr	-1902(ra) # 800208d4 <safestrcpy>
    pid = np->pid;
    8002204a:	0389a483          	lw	s1,56(s3)
    np->state = RUNNABLE;
    8002204e:	4789                	li	a5,2
    80022050:	00f9ac23          	sw	a5,24(s3)
    release(&np->lock);
    80022054:	854e                	mv	a0,s3
    80022056:	ffffe097          	auipc	ra,0xffffe
    8002205a:	6be080e7          	jalr	1726(ra) # 80020714 <release>
}
    8002205e:	8526                	mv	a0,s1
    80022060:	70a2                	ld	ra,40(sp)
    80022062:	7402                	ld	s0,32(sp)
    80022064:	64e2                	ld	s1,24(sp)
    80022066:	6942                	ld	s2,16(sp)
    80022068:	69a2                	ld	s3,8(sp)
    8002206a:	6a02                	ld	s4,0(sp)
    8002206c:	6145                	addi	sp,sp,48
    8002206e:	8082                	ret
        return -1;
    80022070:	54fd                	li	s1,-1
    80022072:	b7f5                	j	8002205e <fork+0xfe>

0000000080022074 <reparent>:
{
    80022074:	7179                	addi	sp,sp,-48
    80022076:	f406                	sd	ra,40(sp)
    80022078:	f022                	sd	s0,32(sp)
    8002207a:	ec26                	sd	s1,24(sp)
    8002207c:	e84a                	sd	s2,16(sp)
    8002207e:	e44e                	sd	s3,8(sp)
    80022080:	e052                	sd	s4,0(sp)
    80022082:	1800                	addi	s0,sp,48
    80022084:	89aa                	mv	s3,a0
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80022086:	00014497          	auipc	s1,0x14
    8002208a:	0f248493          	addi	s1,s1,242 # 80036178 <proc>
            pp->parent = initproc;
    8002208e:	00019a17          	auipc	s4,0x19
    80022092:	a5aa0a13          	addi	s4,s4,-1446 # 8003aae8 <initproc>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80022096:	00019917          	auipc	s2,0x19
    8002209a:	a5290913          	addi	s2,s2,-1454 # 8003aae8 <initproc>
    8002209e:	a029                	j	800220a8 <reparent+0x34>
    800220a0:	17848493          	addi	s1,s1,376
    800220a4:	03248363          	beq	s1,s2,800220ca <reparent+0x56>
        if(pp->parent == p){
    800220a8:	709c                	ld	a5,32(s1)
    800220aa:	ff379be3          	bne	a5,s3,800220a0 <reparent+0x2c>
            acquire(&pp->lock);
    800220ae:	8526                	mv	a0,s1
    800220b0:	ffffe097          	auipc	ra,0xffffe
    800220b4:	610080e7          	jalr	1552(ra) # 800206c0 <acquire>
            pp->parent = initproc;
    800220b8:	000a3783          	ld	a5,0(s4)
    800220bc:	f09c                	sd	a5,32(s1)
            release(&pp->lock);
    800220be:	8526                	mv	a0,s1
    800220c0:	ffffe097          	auipc	ra,0xffffe
    800220c4:	654080e7          	jalr	1620(ra) # 80020714 <release>
    800220c8:	bfe1                	j	800220a0 <reparent+0x2c>
}
    800220ca:	70a2                	ld	ra,40(sp)
    800220cc:	7402                	ld	s0,32(sp)
    800220ce:	64e2                	ld	s1,24(sp)
    800220d0:	6942                	ld	s2,16(sp)
    800220d2:	69a2                	ld	s3,8(sp)
    800220d4:	6a02                	ld	s4,0(sp)
    800220d6:	6145                	addi	sp,sp,48
    800220d8:	8082                	ret

00000000800220da <scheduler>:
{
    800220da:	715d                	addi	sp,sp,-80
    800220dc:	e486                	sd	ra,72(sp)
    800220de:	e0a2                	sd	s0,64(sp)
    800220e0:	fc26                	sd	s1,56(sp)
    800220e2:	f84a                	sd	s2,48(sp)
    800220e4:	f44e                	sd	s3,40(sp)
    800220e6:	f052                	sd	s4,32(sp)
    800220e8:	ec56                	sd	s5,24(sp)
    800220ea:	e85a                	sd	s6,16(sp)
    800220ec:	e45e                	sd	s7,8(sp)
    800220ee:	e062                	sd	s8,0(sp)
    800220f0:	0880                	addi	s0,sp,80
    800220f2:	8792                	mv	a5,tp
    int id = r_tp();
    800220f4:	2781                	sext.w	a5,a5
    c->proc = 0;
    800220f6:	00779b13          	slli	s6,a5,0x7
    800220fa:	00014717          	auipc	a4,0x14
    800220fe:	f6670713          	addi	a4,a4,-154 # 80036060 <pid_lock>
    80022102:	975a                	add	a4,a4,s6
    80022104:	00073c23          	sd	zero,24(a4)
                swtch(&c->context, &p->context);
    80022108:	00014717          	auipc	a4,0x14
    8002210c:	f7870713          	addi	a4,a4,-136 # 80036080 <cpus+0x8>
    80022110:	9b3a                	add	s6,s6,a4
                c->proc = p;
    80022112:	079e                	slli	a5,a5,0x7
    80022114:	00014a97          	auipc	s5,0x14
    80022118:	f4ca8a93          	addi	s5,s5,-180 # 80036060 <pid_lock>
    8002211c:	9abe                	add	s5,s5,a5
                w_satp(MAKE_SATP(p->kpagetable));
    8002211e:	5a7d                	li	s4,-1
    80022120:	1a7e                	slli	s4,s4,0x3f
                w_satp(MAKE_SATP(kernel_pagetable));
    80022122:	00014b97          	auipc	s7,0x14
    80022126:	f36b8b93          	addi	s7,s7,-202 # 80036058 <kernel_pagetable>
    8002212a:	a8a5                	j	800221a2 <scheduler+0xc8>
                p->state = RUNNING;
    8002212c:	478d                	li	a5,3
    8002212e:	cc9c                	sw	a5,24(s1)
                c->proc = p;
    80022130:	009abc23          	sd	s1,24(s5)
                w_satp(MAKE_SATP(p->kpagetable));
    80022134:	6cbc                	ld	a5,88(s1)
    80022136:	83b1                	srli	a5,a5,0xc
    80022138:	0147e7b3          	or	a5,a5,s4
  asm volatile("csrw satp, %0" : : "r" (x));
    8002213c:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    80022140:	12000073          	sfence.vma
                swtch(&c->context, &p->context);
    80022144:	06848593          	addi	a1,s1,104
    80022148:	855a                	mv	a0,s6
    8002214a:	00000097          	auipc	ra,0x0
    8002214e:	634080e7          	jalr	1588(ra) # 8002277e <swtch>
                w_satp(MAKE_SATP(kernel_pagetable));
    80022152:	000bb783          	ld	a5,0(s7)
    80022156:	83b1                	srli	a5,a5,0xc
    80022158:	0147e7b3          	or	a5,a5,s4
  asm volatile("csrw satp, %0" : : "r" (x));
    8002215c:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    80022160:	12000073          	sfence.vma
                c->proc = 0;
    80022164:	000abc23          	sd	zero,24(s5)
                found = 1;
    80022168:	4c05                	li	s8,1
            release(&p->lock);
    8002216a:	8526                	mv	a0,s1
    8002216c:	ffffe097          	auipc	ra,0xffffe
    80022170:	5a8080e7          	jalr	1448(ra) # 80020714 <release>
        for(p = proc; p < &proc[NPROC]; p++) {
    80022174:	17848493          	addi	s1,s1,376
    80022178:	01248b63          	beq	s1,s2,8002218e <scheduler+0xb4>
            acquire(&p->lock);
    8002217c:	8526                	mv	a0,s1
    8002217e:	ffffe097          	auipc	ra,0xffffe
    80022182:	542080e7          	jalr	1346(ra) # 800206c0 <acquire>
            if(p->state == RUNNABLE) {
    80022186:	4c9c                	lw	a5,24(s1)
    80022188:	ff3791e3          	bne	a5,s3,8002216a <scheduler+0x90>
    8002218c:	b745                	j	8002212c <scheduler+0x52>
        if(found == 0) {
    8002218e:	000c1a63          	bnez	s8,800221a2 <scheduler+0xc8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022192:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80022196:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8002219a:	10079073          	csrw	sstatus,a5
            asm volatile("wfi");
    8002219e:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800221a2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800221a6:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800221aa:	10079073          	csrw	sstatus,a5
        int found = 0;
    800221ae:	4c01                	li	s8,0
        for(p = proc; p < &proc[NPROC]; p++) {
    800221b0:	00014497          	auipc	s1,0x14
    800221b4:	fc848493          	addi	s1,s1,-56 # 80036178 <proc>
            if(p->state == RUNNABLE) {
    800221b8:	4989                	li	s3,2
        for(p = proc; p < &proc[NPROC]; p++) {
    800221ba:	00019917          	auipc	s2,0x19
    800221be:	92e90913          	addi	s2,s2,-1746 # 8003aae8 <initproc>
    800221c2:	bf6d                	j	8002217c <scheduler+0xa2>

00000000800221c4 <sched>:
{
    800221c4:	7179                	addi	sp,sp,-48
    800221c6:	f406                	sd	ra,40(sp)
    800221c8:	f022                	sd	s0,32(sp)
    800221ca:	ec26                	sd	s1,24(sp)
    800221cc:	e84a                	sd	s2,16(sp)
    800221ce:	e44e                	sd	s3,8(sp)
    800221d0:	1800                	addi	s0,sp,48
    struct proc *p = myproc();
    800221d2:	00000097          	auipc	ra,0x0
    800221d6:	980080e7          	jalr	-1664(ra) # 80021b52 <myproc>
    800221da:	892a                	mv	s2,a0
    if(!holding(&p->lock))
    800221dc:	ffffe097          	auipc	ra,0xffffe
    800221e0:	4b6080e7          	jalr	1206(ra) # 80020692 <holding>
    800221e4:	cd25                	beqz	a0,8002225c <sched+0x98>
  asm volatile("mv %0, tp" : "=r" (x) );
    800221e6:	8792                	mv	a5,tp
    if(mycpu()->noff != 1)
    800221e8:	2781                	sext.w	a5,a5
    800221ea:	079e                	slli	a5,a5,0x7
    800221ec:	00014717          	auipc	a4,0x14
    800221f0:	e7470713          	addi	a4,a4,-396 # 80036060 <pid_lock>
    800221f4:	97ba                	add	a5,a5,a4
    800221f6:	0907a703          	lw	a4,144(a5)
    800221fa:	4785                	li	a5,1
    800221fc:	06f71863          	bne	a4,a5,8002226c <sched+0xa8>
    if(p->state == RUNNING)
    80022200:	01892703          	lw	a4,24(s2)
    80022204:	478d                	li	a5,3
    80022206:	06f70b63          	beq	a4,a5,8002227c <sched+0xb8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002220a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8002220e:	8b89                	andi	a5,a5,2
    if(intr_get())
    80022210:	efb5                	bnez	a5,8002228c <sched+0xc8>
  asm volatile("mv %0, tp" : "=r" (x) );
    80022212:	8792                	mv	a5,tp
    intena = mycpu()->intena;
    80022214:	00014497          	auipc	s1,0x14
    80022218:	e4c48493          	addi	s1,s1,-436 # 80036060 <pid_lock>
    8002221c:	2781                	sext.w	a5,a5
    8002221e:	079e                	slli	a5,a5,0x7
    80022220:	97a6                	add	a5,a5,s1
    80022222:	0947a983          	lw	s3,148(a5)
    80022226:	8792                	mv	a5,tp
    swtch(&p->context, &mycpu()->context);
    80022228:	2781                	sext.w	a5,a5
    8002222a:	079e                	slli	a5,a5,0x7
    8002222c:	00014597          	auipc	a1,0x14
    80022230:	e5458593          	addi	a1,a1,-428 # 80036080 <cpus+0x8>
    80022234:	95be                	add	a1,a1,a5
    80022236:	06890513          	addi	a0,s2,104
    8002223a:	00000097          	auipc	ra,0x0
    8002223e:	544080e7          	jalr	1348(ra) # 8002277e <swtch>
    80022242:	8792                	mv	a5,tp
    mycpu()->intena = intena;
    80022244:	2781                	sext.w	a5,a5
    80022246:	079e                	slli	a5,a5,0x7
    80022248:	97a6                	add	a5,a5,s1
    8002224a:	0937aa23          	sw	s3,148(a5)
}
    8002224e:	70a2                	ld	ra,40(sp)
    80022250:	7402                	ld	s0,32(sp)
    80022252:	64e2                	ld	s1,24(sp)
    80022254:	6942                	ld	s2,16(sp)
    80022256:	69a2                	ld	s3,8(sp)
    80022258:	6145                	addi	sp,sp,48
    8002225a:	8082                	ret
        panic("sched p->lock");
    8002225c:	00009517          	auipc	a0,0x9
    80022260:	31c50513          	addi	a0,a0,796 # 8002b578 <states.1738+0x110>
    80022264:	ffffe097          	auipc	ra,0xffffe
    80022268:	ee2080e7          	jalr	-286(ra) # 80020146 <panic>
        panic("sched locks");
    8002226c:	00009517          	auipc	a0,0x9
    80022270:	31c50513          	addi	a0,a0,796 # 8002b588 <states.1738+0x120>
    80022274:	ffffe097          	auipc	ra,0xffffe
    80022278:	ed2080e7          	jalr	-302(ra) # 80020146 <panic>
        panic("sched running");
    8002227c:	00009517          	auipc	a0,0x9
    80022280:	31c50513          	addi	a0,a0,796 # 8002b598 <states.1738+0x130>
    80022284:	ffffe097          	auipc	ra,0xffffe
    80022288:	ec2080e7          	jalr	-318(ra) # 80020146 <panic>
        panic("sched interruptible");
    8002228c:	00009517          	auipc	a0,0x9
    80022290:	31c50513          	addi	a0,a0,796 # 8002b5a8 <states.1738+0x140>
    80022294:	ffffe097          	auipc	ra,0xffffe
    80022298:	eb2080e7          	jalr	-334(ra) # 80020146 <panic>

000000008002229c <exit>:
{
    8002229c:	7179                	addi	sp,sp,-48
    8002229e:	f406                	sd	ra,40(sp)
    800222a0:	f022                	sd	s0,32(sp)
    800222a2:	ec26                	sd	s1,24(sp)
    800222a4:	e84a                	sd	s2,16(sp)
    800222a6:	e44e                	sd	s3,8(sp)
    800222a8:	e052                	sd	s4,0(sp)
    800222aa:	1800                	addi	s0,sp,48
    800222ac:	8a2a                	mv	s4,a0
    struct proc *p = myproc();
    800222ae:	00000097          	auipc	ra,0x0
    800222b2:	8a4080e7          	jalr	-1884(ra) # 80021b52 <myproc>
    800222b6:	89aa                	mv	s3,a0
    if(p == initproc)
    800222b8:	00019797          	auipc	a5,0x19
    800222bc:	83078793          	addi	a5,a5,-2000 # 8003aae8 <initproc>
    800222c0:	639c                	ld	a5,0(a5)
    800222c2:	0d850493          	addi	s1,a0,216
    800222c6:	15850913          	addi	s2,a0,344
    800222ca:	02a79363          	bne	a5,a0,800222f0 <exit+0x54>
        panic("init exiting");
    800222ce:	00009517          	auipc	a0,0x9
    800222d2:	2f250513          	addi	a0,a0,754 # 8002b5c0 <states.1738+0x158>
    800222d6:	ffffe097          	auipc	ra,0xffffe
    800222da:	e70080e7          	jalr	-400(ra) # 80020146 <panic>
            fileclose(f);
    800222de:	00001097          	auipc	ra,0x1
    800222e2:	658080e7          	jalr	1624(ra) # 80023936 <fileclose>
            p->ofile[fd] = 0;
    800222e6:	0004b023          	sd	zero,0(s1)
    800222ea:	04a1                	addi	s1,s1,8
    for(int fd = 0; fd < NOFILE; fd++){
    800222ec:	01248563          	beq	s1,s2,800222f6 <exit+0x5a>
        if(p->ofile[fd]){
    800222f0:	6088                	ld	a0,0(s1)
    800222f2:	f575                	bnez	a0,800222de <exit+0x42>
    800222f4:	bfdd                	j	800222ea <exit+0x4e>
    eput(p->cwd);
    800222f6:	1589b503          	ld	a0,344(s3)
    800222fa:	00004097          	auipc	ra,0x4
    800222fe:	086080e7          	jalr	134(ra) # 80026380 <eput>
    p->cwd = 0;
    80022302:	1409bc23          	sd	zero,344(s3)
    acquire(&initproc->lock);
    80022306:	00018497          	auipc	s1,0x18
    8002230a:	7e248493          	addi	s1,s1,2018 # 8003aae8 <initproc>
    8002230e:	6088                	ld	a0,0(s1)
    80022310:	ffffe097          	auipc	ra,0xffffe
    80022314:	3b0080e7          	jalr	944(ra) # 800206c0 <acquire>
    wakeup1(initproc);
    80022318:	6088                	ld	a0,0(s1)
    8002231a:	fffff097          	auipc	ra,0xfffff
    8002231e:	64c080e7          	jalr	1612(ra) # 80021966 <wakeup1>
    release(&initproc->lock);
    80022322:	6088                	ld	a0,0(s1)
    80022324:	ffffe097          	auipc	ra,0xffffe
    80022328:	3f0080e7          	jalr	1008(ra) # 80020714 <release>
    acquire(&p->lock);
    8002232c:	854e                	mv	a0,s3
    8002232e:	ffffe097          	auipc	ra,0xffffe
    80022332:	392080e7          	jalr	914(ra) # 800206c0 <acquire>
    struct proc *original_parent = p->parent;
    80022336:	0209b483          	ld	s1,32(s3)
    release(&p->lock);
    8002233a:	854e                	mv	a0,s3
    8002233c:	ffffe097          	auipc	ra,0xffffe
    80022340:	3d8080e7          	jalr	984(ra) # 80020714 <release>
    acquire(&original_parent->lock);
    80022344:	8526                	mv	a0,s1
    80022346:	ffffe097          	auipc	ra,0xffffe
    8002234a:	37a080e7          	jalr	890(ra) # 800206c0 <acquire>
    acquire(&p->lock);
    8002234e:	854e                	mv	a0,s3
    80022350:	ffffe097          	auipc	ra,0xffffe
    80022354:	370080e7          	jalr	880(ra) # 800206c0 <acquire>
    reparent(p);
    80022358:	854e                	mv	a0,s3
    8002235a:	00000097          	auipc	ra,0x0
    8002235e:	d1a080e7          	jalr	-742(ra) # 80022074 <reparent>
    wakeup1(original_parent);
    80022362:	8526                	mv	a0,s1
    80022364:	fffff097          	auipc	ra,0xfffff
    80022368:	602080e7          	jalr	1538(ra) # 80021966 <wakeup1>
    p->xstate = status;
    8002236c:	0349aa23          	sw	s4,52(s3)
    p->state = ZOMBIE;
    80022370:	4791                	li	a5,4
    80022372:	00f9ac23          	sw	a5,24(s3)
    release(&original_parent->lock);
    80022376:	8526                	mv	a0,s1
    80022378:	ffffe097          	auipc	ra,0xffffe
    8002237c:	39c080e7          	jalr	924(ra) # 80020714 <release>
    sched();
    80022380:	00000097          	auipc	ra,0x0
    80022384:	e44080e7          	jalr	-444(ra) # 800221c4 <sched>
    panic("zombie exit");
    80022388:	00009517          	auipc	a0,0x9
    8002238c:	24850513          	addi	a0,a0,584 # 8002b5d0 <states.1738+0x168>
    80022390:	ffffe097          	auipc	ra,0xffffe
    80022394:	db6080e7          	jalr	-586(ra) # 80020146 <panic>

0000000080022398 <yield>:
{
    80022398:	1101                	addi	sp,sp,-32
    8002239a:	ec06                	sd	ra,24(sp)
    8002239c:	e822                	sd	s0,16(sp)
    8002239e:	e426                	sd	s1,8(sp)
    800223a0:	1000                	addi	s0,sp,32
    struct proc *p = myproc();
    800223a2:	fffff097          	auipc	ra,0xfffff
    800223a6:	7b0080e7          	jalr	1968(ra) # 80021b52 <myproc>
    800223aa:	84aa                	mv	s1,a0
    acquire(&p->lock);
    800223ac:	ffffe097          	auipc	ra,0xffffe
    800223b0:	314080e7          	jalr	788(ra) # 800206c0 <acquire>
    p->state = RUNNABLE;
    800223b4:	4789                	li	a5,2
    800223b6:	cc9c                	sw	a5,24(s1)
    sched();
    800223b8:	00000097          	auipc	ra,0x0
    800223bc:	e0c080e7          	jalr	-500(ra) # 800221c4 <sched>
    release(&p->lock);
    800223c0:	8526                	mv	a0,s1
    800223c2:	ffffe097          	auipc	ra,0xffffe
    800223c6:	352080e7          	jalr	850(ra) # 80020714 <release>
}
    800223ca:	60e2                	ld	ra,24(sp)
    800223cc:	6442                	ld	s0,16(sp)
    800223ce:	64a2                	ld	s1,8(sp)
    800223d0:	6105                	addi	sp,sp,32
    800223d2:	8082                	ret

00000000800223d4 <sleep>:
{
    800223d4:	7179                	addi	sp,sp,-48
    800223d6:	f406                	sd	ra,40(sp)
    800223d8:	f022                	sd	s0,32(sp)
    800223da:	ec26                	sd	s1,24(sp)
    800223dc:	e84a                	sd	s2,16(sp)
    800223de:	e44e                	sd	s3,8(sp)
    800223e0:	1800                	addi	s0,sp,48
    800223e2:	89aa                	mv	s3,a0
    800223e4:	892e                	mv	s2,a1
    struct proc *p = myproc();
    800223e6:	fffff097          	auipc	ra,0xfffff
    800223ea:	76c080e7          	jalr	1900(ra) # 80021b52 <myproc>
    800223ee:	84aa                	mv	s1,a0
    if(lk != &p->lock){  //DOC: sleeplock0
    800223f0:	05250663          	beq	a0,s2,8002243c <sleep+0x68>
        acquire(&p->lock);  //DOC: sleeplock1
    800223f4:	ffffe097          	auipc	ra,0xffffe
    800223f8:	2cc080e7          	jalr	716(ra) # 800206c0 <acquire>
        release(lk);
    800223fc:	854a                	mv	a0,s2
    800223fe:	ffffe097          	auipc	ra,0xffffe
    80022402:	316080e7          	jalr	790(ra) # 80020714 <release>
    p->chan = chan;
    80022406:	0334b423          	sd	s3,40(s1)
    p->state = SLEEPING;
    8002240a:	4785                	li	a5,1
    8002240c:	cc9c                	sw	a5,24(s1)
    sched();
    8002240e:	00000097          	auipc	ra,0x0
    80022412:	db6080e7          	jalr	-586(ra) # 800221c4 <sched>
    p->chan = 0;
    80022416:	0204b423          	sd	zero,40(s1)
        release(&p->lock);
    8002241a:	8526                	mv	a0,s1
    8002241c:	ffffe097          	auipc	ra,0xffffe
    80022420:	2f8080e7          	jalr	760(ra) # 80020714 <release>
        acquire(lk);
    80022424:	854a                	mv	a0,s2
    80022426:	ffffe097          	auipc	ra,0xffffe
    8002242a:	29a080e7          	jalr	666(ra) # 800206c0 <acquire>
}
    8002242e:	70a2                	ld	ra,40(sp)
    80022430:	7402                	ld	s0,32(sp)
    80022432:	64e2                	ld	s1,24(sp)
    80022434:	6942                	ld	s2,16(sp)
    80022436:	69a2                	ld	s3,8(sp)
    80022438:	6145                	addi	sp,sp,48
    8002243a:	8082                	ret
    p->chan = chan;
    8002243c:	03353423          	sd	s3,40(a0)
    p->state = SLEEPING;
    80022440:	4785                	li	a5,1
    80022442:	cd1c                	sw	a5,24(a0)
    sched();
    80022444:	00000097          	auipc	ra,0x0
    80022448:	d80080e7          	jalr	-640(ra) # 800221c4 <sched>
    p->chan = 0;
    8002244c:	0204b423          	sd	zero,40(s1)
    if(lk != &p->lock){
    80022450:	bff9                	j	8002242e <sleep+0x5a>

0000000080022452 <wait>:
{
    80022452:	715d                	addi	sp,sp,-80
    80022454:	e486                	sd	ra,72(sp)
    80022456:	e0a2                	sd	s0,64(sp)
    80022458:	fc26                	sd	s1,56(sp)
    8002245a:	f84a                	sd	s2,48(sp)
    8002245c:	f44e                	sd	s3,40(sp)
    8002245e:	f052                	sd	s4,32(sp)
    80022460:	ec56                	sd	s5,24(sp)
    80022462:	e85a                	sd	s6,16(sp)
    80022464:	e45e                	sd	s7,8(sp)
    80022466:	e062                	sd	s8,0(sp)
    80022468:	0880                	addi	s0,sp,80
    8002246a:	8baa                	mv	s7,a0
    struct proc *p = myproc();
    8002246c:	fffff097          	auipc	ra,0xfffff
    80022470:	6e6080e7          	jalr	1766(ra) # 80021b52 <myproc>
    80022474:	892a                	mv	s2,a0
    acquire(&p->lock);
    80022476:	8c2a                	mv	s8,a0
    80022478:	ffffe097          	auipc	ra,0xffffe
    8002247c:	248080e7          	jalr	584(ra) # 800206c0 <acquire>
        havekids = 0;
    80022480:	4b01                	li	s6,0
                if(np->state == ZOMBIE){
    80022482:	4a11                	li	s4,4
        for(np = proc; np < &proc[NPROC]; np++){
    80022484:	00018997          	auipc	s3,0x18
    80022488:	66498993          	addi	s3,s3,1636 # 8003aae8 <initproc>
                havekids = 1;
    8002248c:	4a85                	li	s5,1
        havekids = 0;
    8002248e:	875a                	mv	a4,s6
        for(np = proc; np < &proc[NPROC]; np++){
    80022490:	00014497          	auipc	s1,0x14
    80022494:	ce848493          	addi	s1,s1,-792 # 80036178 <proc>
    80022498:	a8b9                	j	800224f6 <wait+0xa4>
                    pid = np->pid;
    8002249a:	0384a983          	lw	s3,56(s1)
                    if(addr != 0 && copyout2(addr, (char *)&np->xstate, sizeof(np->xstate)) < 0) {
    8002249e:	000b8c63          	beqz	s7,800224b6 <wait+0x64>
    800224a2:	4611                	li	a2,4
    800224a4:	03448593          	addi	a1,s1,52
    800224a8:	855e                	mv	a0,s7
    800224aa:	fffff097          	auipc	ra,0xfffff
    800224ae:	fae080e7          	jalr	-82(ra) # 80021458 <copyout2>
    800224b2:	02054263          	bltz	a0,800224d6 <wait+0x84>
                    freeproc(np);
    800224b6:	8526                	mv	a0,s1
    800224b8:	00000097          	auipc	ra,0x0
    800224bc:	86e080e7          	jalr	-1938(ra) # 80021d26 <freeproc>
                    release(&np->lock);
    800224c0:	8526                	mv	a0,s1
    800224c2:	ffffe097          	auipc	ra,0xffffe
    800224c6:	252080e7          	jalr	594(ra) # 80020714 <release>
                    release(&p->lock);
    800224ca:	854a                	mv	a0,s2
    800224cc:	ffffe097          	auipc	ra,0xffffe
    800224d0:	248080e7          	jalr	584(ra) # 80020714 <release>
                    return pid;
    800224d4:	a8a9                	j	8002252e <wait+0xdc>
                        release(&np->lock);
    800224d6:	8526                	mv	a0,s1
    800224d8:	ffffe097          	auipc	ra,0xffffe
    800224dc:	23c080e7          	jalr	572(ra) # 80020714 <release>
                        release(&p->lock);
    800224e0:	854a                	mv	a0,s2
    800224e2:	ffffe097          	auipc	ra,0xffffe
    800224e6:	232080e7          	jalr	562(ra) # 80020714 <release>
                        return -1;
    800224ea:	59fd                	li	s3,-1
    800224ec:	a089                	j	8002252e <wait+0xdc>
        for(np = proc; np < &proc[NPROC]; np++){
    800224ee:	17848493          	addi	s1,s1,376
    800224f2:	03348463          	beq	s1,s3,8002251a <wait+0xc8>
            if(np->parent == p){
    800224f6:	709c                	ld	a5,32(s1)
    800224f8:	ff279be3          	bne	a5,s2,800224ee <wait+0x9c>
                acquire(&np->lock);
    800224fc:	8526                	mv	a0,s1
    800224fe:	ffffe097          	auipc	ra,0xffffe
    80022502:	1c2080e7          	jalr	450(ra) # 800206c0 <acquire>
                if(np->state == ZOMBIE){
    80022506:	4c9c                	lw	a5,24(s1)
    80022508:	f94789e3          	beq	a5,s4,8002249a <wait+0x48>
                release(&np->lock);
    8002250c:	8526                	mv	a0,s1
    8002250e:	ffffe097          	auipc	ra,0xffffe
    80022512:	206080e7          	jalr	518(ra) # 80020714 <release>
                havekids = 1;
    80022516:	8756                	mv	a4,s5
    80022518:	bfd9                	j	800224ee <wait+0x9c>
        if(!havekids || p->killed){
    8002251a:	c701                	beqz	a4,80022522 <wait+0xd0>
    8002251c:	03092783          	lw	a5,48(s2)
    80022520:	c785                	beqz	a5,80022548 <wait+0xf6>
            release(&p->lock);
    80022522:	854a                	mv	a0,s2
    80022524:	ffffe097          	auipc	ra,0xffffe
    80022528:	1f0080e7          	jalr	496(ra) # 80020714 <release>
            return -1;
    8002252c:	59fd                	li	s3,-1
}
    8002252e:	854e                	mv	a0,s3
    80022530:	60a6                	ld	ra,72(sp)
    80022532:	6406                	ld	s0,64(sp)
    80022534:	74e2                	ld	s1,56(sp)
    80022536:	7942                	ld	s2,48(sp)
    80022538:	79a2                	ld	s3,40(sp)
    8002253a:	7a02                	ld	s4,32(sp)
    8002253c:	6ae2                	ld	s5,24(sp)
    8002253e:	6b42                	ld	s6,16(sp)
    80022540:	6ba2                	ld	s7,8(sp)
    80022542:	6c02                	ld	s8,0(sp)
    80022544:	6161                	addi	sp,sp,80
    80022546:	8082                	ret
        sleep(p, &p->lock);  //DOC: wait-sleep
    80022548:	85e2                	mv	a1,s8
    8002254a:	854a                	mv	a0,s2
    8002254c:	00000097          	auipc	ra,0x0
    80022550:	e88080e7          	jalr	-376(ra) # 800223d4 <sleep>
        havekids = 0;
    80022554:	bf2d                	j	8002248e <wait+0x3c>

0000000080022556 <wakeup>:
{
    80022556:	7139                	addi	sp,sp,-64
    80022558:	fc06                	sd	ra,56(sp)
    8002255a:	f822                	sd	s0,48(sp)
    8002255c:	f426                	sd	s1,40(sp)
    8002255e:	f04a                	sd	s2,32(sp)
    80022560:	ec4e                	sd	s3,24(sp)
    80022562:	e852                	sd	s4,16(sp)
    80022564:	e456                	sd	s5,8(sp)
    80022566:	0080                	addi	s0,sp,64
    80022568:	8a2a                	mv	s4,a0
    for(p = proc; p < &proc[NPROC]; p++) {
    8002256a:	00014497          	auipc	s1,0x14
    8002256e:	c0e48493          	addi	s1,s1,-1010 # 80036178 <proc>
        if(p->state == SLEEPING && p->chan == chan) {
    80022572:	4985                	li	s3,1
            p->state = RUNNABLE;
    80022574:	4a89                	li	s5,2
    for(p = proc; p < &proc[NPROC]; p++) {
    80022576:	00018917          	auipc	s2,0x18
    8002257a:	57290913          	addi	s2,s2,1394 # 8003aae8 <initproc>
    8002257e:	a821                	j	80022596 <wakeup+0x40>
            p->state = RUNNABLE;
    80022580:	0154ac23          	sw	s5,24(s1)
        release(&p->lock);
    80022584:	8526                	mv	a0,s1
    80022586:	ffffe097          	auipc	ra,0xffffe
    8002258a:	18e080e7          	jalr	398(ra) # 80020714 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    8002258e:	17848493          	addi	s1,s1,376
    80022592:	01248e63          	beq	s1,s2,800225ae <wakeup+0x58>
        acquire(&p->lock);
    80022596:	8526                	mv	a0,s1
    80022598:	ffffe097          	auipc	ra,0xffffe
    8002259c:	128080e7          	jalr	296(ra) # 800206c0 <acquire>
        if(p->state == SLEEPING && p->chan == chan) {
    800225a0:	4c9c                	lw	a5,24(s1)
    800225a2:	ff3791e3          	bne	a5,s3,80022584 <wakeup+0x2e>
    800225a6:	749c                	ld	a5,40(s1)
    800225a8:	fd479ee3          	bne	a5,s4,80022584 <wakeup+0x2e>
    800225ac:	bfd1                	j	80022580 <wakeup+0x2a>
}
    800225ae:	70e2                	ld	ra,56(sp)
    800225b0:	7442                	ld	s0,48(sp)
    800225b2:	74a2                	ld	s1,40(sp)
    800225b4:	7902                	ld	s2,32(sp)
    800225b6:	69e2                	ld	s3,24(sp)
    800225b8:	6a42                	ld	s4,16(sp)
    800225ba:	6aa2                	ld	s5,8(sp)
    800225bc:	6121                	addi	sp,sp,64
    800225be:	8082                	ret

00000000800225c0 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800225c0:	7179                	addi	sp,sp,-48
    800225c2:	f406                	sd	ra,40(sp)
    800225c4:	f022                	sd	s0,32(sp)
    800225c6:	ec26                	sd	s1,24(sp)
    800225c8:	e84a                	sd	s2,16(sp)
    800225ca:	e44e                	sd	s3,8(sp)
    800225cc:	1800                	addi	s0,sp,48
    800225ce:	892a                	mv	s2,a0
    struct proc *p;

    for(p = proc; p < &proc[NPROC]; p++){
    800225d0:	00014497          	auipc	s1,0x14
    800225d4:	ba848493          	addi	s1,s1,-1112 # 80036178 <proc>
    800225d8:	00018997          	auipc	s3,0x18
    800225dc:	51098993          	addi	s3,s3,1296 # 8003aae8 <initproc>
        acquire(&p->lock);
    800225e0:	8526                	mv	a0,s1
    800225e2:	ffffe097          	auipc	ra,0xffffe
    800225e6:	0de080e7          	jalr	222(ra) # 800206c0 <acquire>
        if(p->pid == pid){
    800225ea:	5c9c                	lw	a5,56(s1)
    800225ec:	01278d63          	beq	a5,s2,80022606 <kill+0x46>
                p->state = RUNNABLE;
            }
            release(&p->lock);
            return 0;
        }
        release(&p->lock);
    800225f0:	8526                	mv	a0,s1
    800225f2:	ffffe097          	auipc	ra,0xffffe
    800225f6:	122080e7          	jalr	290(ra) # 80020714 <release>
    for(p = proc; p < &proc[NPROC]; p++){
    800225fa:	17848493          	addi	s1,s1,376
    800225fe:	ff3491e3          	bne	s1,s3,800225e0 <kill+0x20>
    }
    return -1;
    80022602:	557d                	li	a0,-1
    80022604:	a821                	j	8002261c <kill+0x5c>
            p->killed = 1;
    80022606:	4785                	li	a5,1
    80022608:	d89c                	sw	a5,48(s1)
            if(p->state == SLEEPING){
    8002260a:	4c98                	lw	a4,24(s1)
    8002260c:	00f70f63          	beq	a4,a5,8002262a <kill+0x6a>
            release(&p->lock);
    80022610:	8526                	mv	a0,s1
    80022612:	ffffe097          	auipc	ra,0xffffe
    80022616:	102080e7          	jalr	258(ra) # 80020714 <release>
            return 0;
    8002261a:	4501                	li	a0,0
}
    8002261c:	70a2                	ld	ra,40(sp)
    8002261e:	7402                	ld	s0,32(sp)
    80022620:	64e2                	ld	s1,24(sp)
    80022622:	6942                	ld	s2,16(sp)
    80022624:	69a2                	ld	s3,8(sp)
    80022626:	6145                	addi	sp,sp,48
    80022628:	8082                	ret
                p->state = RUNNABLE;
    8002262a:	4789                	li	a5,2
    8002262c:	cc9c                	sw	a5,24(s1)
    8002262e:	b7cd                	j	80022610 <kill+0x50>

0000000080022630 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80022630:	1101                	addi	sp,sp,-32
    80022632:	ec06                	sd	ra,24(sp)
    80022634:	e822                	sd	s0,16(sp)
    80022636:	e426                	sd	s1,8(sp)
    80022638:	1000                	addi	s0,sp,32
    8002263a:	84aa                	mv	s1,a0
    8002263c:	852e                	mv	a0,a1
    8002263e:	85b2                	mv	a1,a2
    // struct proc *p = myproc();
    if(user_dst){
    80022640:	c899                	beqz	s1,80022656 <either_copyout+0x26>
        // return copyout(p->pagetable, dst, src, len);
        return copyout2(dst, src, len);
    80022642:	8636                	mv	a2,a3
    80022644:	fffff097          	auipc	ra,0xfffff
    80022648:	e14080e7          	jalr	-492(ra) # 80021458 <copyout2>
    } else {
        memmove((char *)dst, src, len);
        return 0;
    }
}
    8002264c:	60e2                	ld	ra,24(sp)
    8002264e:	6442                	ld	s0,16(sp)
    80022650:	64a2                	ld	s1,8(sp)
    80022652:	6105                	addi	sp,sp,32
    80022654:	8082                	ret
        memmove((char *)dst, src, len);
    80022656:	0006861b          	sext.w	a2,a3
    8002265a:	ffffe097          	auipc	ra,0xffffe
    8002265e:	16e080e7          	jalr	366(ra) # 800207c8 <memmove>
        return 0;
    80022662:	8526                	mv	a0,s1
    80022664:	b7e5                	j	8002264c <either_copyout+0x1c>

0000000080022666 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80022666:	1101                	addi	sp,sp,-32
    80022668:	ec06                	sd	ra,24(sp)
    8002266a:	e822                	sd	s0,16(sp)
    8002266c:	e426                	sd	s1,8(sp)
    8002266e:	1000                	addi	s0,sp,32
    80022670:	84ae                	mv	s1,a1
    80022672:	85b2                	mv	a1,a2
    // struct proc *p = myproc();
    if(user_src){
    80022674:	c899                	beqz	s1,8002268a <either_copyin+0x24>
        // return copyin(p->pagetable, dst, src, len);
        return copyin2(dst, src, len);
    80022676:	8636                	mv	a2,a3
    80022678:	fffff097          	auipc	ra,0xfffff
    8002267c:	ec0080e7          	jalr	-320(ra) # 80021538 <copyin2>
    } else {
        memmove(dst, (char*)src, len);
        return 0;
    }
}
    80022680:	60e2                	ld	ra,24(sp)
    80022682:	6442                	ld	s0,16(sp)
    80022684:	64a2                	ld	s1,8(sp)
    80022686:	6105                	addi	sp,sp,32
    80022688:	8082                	ret
        memmove(dst, (char*)src, len);
    8002268a:	0006861b          	sext.w	a2,a3
    8002268e:	ffffe097          	auipc	ra,0xffffe
    80022692:	13a080e7          	jalr	314(ra) # 800207c8 <memmove>
        return 0;
    80022696:	8526                	mv	a0,s1
    80022698:	b7e5                	j	80022680 <either_copyin+0x1a>

000000008002269a <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    8002269a:	715d                	addi	sp,sp,-80
    8002269c:	e486                	sd	ra,72(sp)
    8002269e:	e0a2                	sd	s0,64(sp)
    800226a0:	fc26                	sd	s1,56(sp)
    800226a2:	f84a                	sd	s2,48(sp)
    800226a4:	f44e                	sd	s3,40(sp)
    800226a6:	f052                	sd	s4,32(sp)
    800226a8:	ec56                	sd	s5,24(sp)
    800226aa:	e85a                	sd	s6,16(sp)
    800226ac:	e45e                	sd	s7,8(sp)
    800226ae:	0880                	addi	s0,sp,80
            [ZOMBIE]    "zombie"
    };
    struct proc *p;
    char *state;

    printf("\nPID\tSTATE\tNAME\tMEM\n");
    800226b0:	00009517          	auipc	a0,0x9
    800226b4:	f3850513          	addi	a0,a0,-200 # 8002b5e8 <states.1738+0x180>
    800226b8:	ffffe097          	auipc	ra,0xffffe
    800226bc:	ad8080e7          	jalr	-1320(ra) # 80020190 <printf>
    for(p = proc; p < &proc[NPROC]; p++){
    800226c0:	00014497          	auipc	s1,0x14
    800226c4:	c1848493          	addi	s1,s1,-1000 # 800362d8 <proc+0x160>
    800226c8:	00018917          	auipc	s2,0x18
    800226cc:	58090913          	addi	s2,s2,1408 # 8003ac48 <bcache+0x158>
        if(p->state == UNUSED)
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800226d0:	4b11                	li	s6,4
            state = states[p->state];
        else
            state = "???";
    800226d2:	00009997          	auipc	s3,0x9
    800226d6:	f0e98993          	addi	s3,s3,-242 # 8002b5e0 <states.1738+0x178>
        printf("%d\t%s\t%s\t%d", p->pid, state, p->name, p->sz);
    800226da:	00009a97          	auipc	s5,0x9
    800226de:	f26a8a93          	addi	s5,s5,-218 # 8002b600 <states.1738+0x198>
        printf("\n");
    800226e2:	0000aa17          	auipc	s4,0xa
    800226e6:	af6a0a13          	addi	s4,s4,-1290 # 8002c1d8 <syscalls+0x870>
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800226ea:	00009b97          	auipc	s7,0x9
    800226ee:	d7eb8b93          	addi	s7,s7,-642 # 8002b468 <states.1738>
    800226f2:	a025                	j	8002271a <procdump+0x80>
        printf("%d\t%s\t%s\t%d", p->pid, state, p->name, p->sz);
    800226f4:	ee85b703          	ld	a4,-280(a1)
    800226f8:	86ae                	mv	a3,a1
    800226fa:	ed85a583          	lw	a1,-296(a1)
    800226fe:	8556                	mv	a0,s5
    80022700:	ffffe097          	auipc	ra,0xffffe
    80022704:	a90080e7          	jalr	-1392(ra) # 80020190 <printf>
        printf("\n");
    80022708:	8552                	mv	a0,s4
    8002270a:	ffffe097          	auipc	ra,0xffffe
    8002270e:	a86080e7          	jalr	-1402(ra) # 80020190 <printf>
    80022712:	17848493          	addi	s1,s1,376
    for(p = proc; p < &proc[NPROC]; p++){
    80022716:	03248163          	beq	s1,s2,80022738 <procdump+0x9e>
        if(p->state == UNUSED)
    8002271a:	85a6                	mv	a1,s1
    8002271c:	eb84a783          	lw	a5,-328(s1)
    80022720:	dbed                	beqz	a5,80022712 <procdump+0x78>
            state = "???";
    80022722:	864e                	mv	a2,s3
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80022724:	fcfb68e3          	bltu	s6,a5,800226f4 <procdump+0x5a>
    80022728:	1782                	slli	a5,a5,0x20
    8002272a:	9381                	srli	a5,a5,0x20
    8002272c:	078e                	slli	a5,a5,0x3
    8002272e:	97de                	add	a5,a5,s7
    80022730:	6390                	ld	a2,0(a5)
    80022732:	f269                	bnez	a2,800226f4 <procdump+0x5a>
            state = "???";
    80022734:	864e                	mv	a2,s3
    80022736:	bf7d                	j	800226f4 <procdump+0x5a>
    }
}
    80022738:	60a6                	ld	ra,72(sp)
    8002273a:	6406                	ld	s0,64(sp)
    8002273c:	74e2                	ld	s1,56(sp)
    8002273e:	7942                	ld	s2,48(sp)
    80022740:	79a2                	ld	s3,40(sp)
    80022742:	7a02                	ld	s4,32(sp)
    80022744:	6ae2                	ld	s5,24(sp)
    80022746:	6b42                	ld	s6,16(sp)
    80022748:	6ba2                	ld	s7,8(sp)
    8002274a:	6161                	addi	sp,sp,80
    8002274c:	8082                	ret

000000008002274e <procnum>:

uint64
procnum(void)
{
    8002274e:	1141                	addi	sp,sp,-16
    80022750:	e422                	sd	s0,8(sp)
    80022752:	0800                	addi	s0,sp,16
    int num = 0;
    struct proc *p;

    for (p = proc; p < &proc[NPROC]; p++) {
    80022754:	00014797          	auipc	a5,0x14
    80022758:	a2478793          	addi	a5,a5,-1500 # 80036178 <proc>
    int num = 0;
    8002275c:	4501                	li	a0,0
    for (p = proc; p < &proc[NPROC]; p++) {
    8002275e:	00018697          	auipc	a3,0x18
    80022762:	38a68693          	addi	a3,a3,906 # 8003aae8 <initproc>
    80022766:	a029                	j	80022770 <procnum+0x22>
    80022768:	17878793          	addi	a5,a5,376
    8002276c:	00d78663          	beq	a5,a3,80022778 <procnum+0x2a>
        if (p->state != UNUSED) {
    80022770:	4f98                	lw	a4,24(a5)
    80022772:	db7d                	beqz	a4,80022768 <procnum+0x1a>
            num++;
    80022774:	2505                	addiw	a0,a0,1
    80022776:	bfcd                	j	80022768 <procnum+0x1a>
        }
    }

    return num;
}
    80022778:	6422                	ld	s0,8(sp)
    8002277a:	0141                	addi	sp,sp,16
    8002277c:	8082                	ret

000000008002277e <swtch>:
    8002277e:	00153023          	sd	ra,0(a0)
    80022782:	00253423          	sd	sp,8(a0)
    80022786:	e900                	sd	s0,16(a0)
    80022788:	ed04                	sd	s1,24(a0)
    8002278a:	03253023          	sd	s2,32(a0)
    8002278e:	03353423          	sd	s3,40(a0)
    80022792:	03453823          	sd	s4,48(a0)
    80022796:	03553c23          	sd	s5,56(a0)
    8002279a:	05653023          	sd	s6,64(a0)
    8002279e:	05753423          	sd	s7,72(a0)
    800227a2:	05853823          	sd	s8,80(a0)
    800227a6:	05953c23          	sd	s9,88(a0)
    800227aa:	07a53023          	sd	s10,96(a0)
    800227ae:	07b53423          	sd	s11,104(a0)
    800227b2:	0005b083          	ld	ra,0(a1)
    800227b6:	0085b103          	ld	sp,8(a1)
    800227ba:	6980                	ld	s0,16(a1)
    800227bc:	6d84                	ld	s1,24(a1)
    800227be:	0205b903          	ld	s2,32(a1)
    800227c2:	0285b983          	ld	s3,40(a1)
    800227c6:	0305ba03          	ld	s4,48(a1)
    800227ca:	0385ba83          	ld	s5,56(a1)
    800227ce:	0405bb03          	ld	s6,64(a1)
    800227d2:	0485bb83          	ld	s7,72(a1)
    800227d6:	0505bc03          	ld	s8,80(a1)
    800227da:	0585bc83          	ld	s9,88(a1)
    800227de:	0605bd03          	ld	s10,96(a1)
    800227e2:	0685bd83          	ld	s11,104(a1)
    800227e6:	8082                	ret

00000000800227e8 <trapinithart>:
// }

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800227e8:	1141                	addi	sp,sp,-16
    800227ea:	e406                	sd	ra,8(sp)
    800227ec:	e022                	sd	s0,0(sp)
    800227ee:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    800227f0:	00003797          	auipc	a5,0x3
    800227f4:	82078793          	addi	a5,a5,-2016 # 80025010 <kernelvec>
    800227f8:	10579073          	csrw	stvec,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800227fc:	100027f3          	csrr	a5,sstatus
  w_stvec((uint64)kernelvec);
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80022800:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022804:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80022808:	104027f3          	csrr	a5,sie
  // enable supervisor-mode timer interrupts.
  w_sie(r_sie() | SIE_SEIE | SIE_SSIE | SIE_STIE);
    8002280c:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80022810:	10479073          	csrw	sie,a5
  set_next_timeout();
    80022814:	00003097          	auipc	ra,0x3
    80022818:	8b2080e7          	jalr	-1870(ra) # 800250c6 <set_next_timeout>
  #ifdef DEBUG
  printf("trapinithart\n");
  #endif
}
    8002281c:	60a2                	ld	ra,8(sp)
    8002281e:	6402                	ld	s0,0(sp)
    80022820:	0141                	addi	sp,sp,16
    80022822:	8082                	ret

0000000080022824 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80022824:	1141                	addi	sp,sp,-16
    80022826:	e406                	sd	ra,8(sp)
    80022828:	e022                	sd	s0,0(sp)
    8002282a:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    8002282c:	fffff097          	auipc	ra,0xfffff
    80022830:	326080e7          	jalr	806(ra) # 80021b52 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022834:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80022838:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8002283a:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    8002283e:	00007617          	auipc	a2,0x7
    80022842:	7c260613          	addi	a2,a2,1986 # 8002a000 <_trampoline>
    80022846:	00007697          	auipc	a3,0x7
    8002284a:	7ba68693          	addi	a3,a3,1978 # 8002a000 <_trampoline>
    8002284e:	8e91                	sub	a3,a3,a2
    80022850:	040007b7          	lui	a5,0x4000
    80022854:	17fd                	addi	a5,a5,-1
    80022856:	07b2                	slli	a5,a5,0xc
    80022858:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    8002285a:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    8002285e:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80022860:	180026f3          	csrr	a3,satp
    80022864:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80022866:	7138                	ld	a4,96(a0)
    80022868:	6134                	ld	a3,64(a0)
    8002286a:	6585                	lui	a1,0x1
    8002286c:	96ae                	add	a3,a3,a1
    8002286e:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80022870:	7138                	ld	a4,96(a0)
    80022872:	00000697          	auipc	a3,0x0
    80022876:	11a68693          	addi	a3,a3,282 # 8002298c <usertrap>
    8002287a:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    8002287c:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    8002287e:	8692                	mv	a3,tp
    80022880:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022882:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80022886:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    8002288a:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8002288e:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80022892:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80022894:	6f18                	ld	a4,24(a4)
    80022896:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  // printf("[usertrapret]p->pagetable: %p\n", p->pagetable);
  uint64 satp = MAKE_SATP(p->pagetable);
    8002289a:	692c                	ld	a1,80(a0)
    8002289c:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    8002289e:	00007717          	auipc	a4,0x7
    800228a2:	7f270713          	addi	a4,a4,2034 # 8002a090 <userret>
    800228a6:	8f11                	sub	a4,a4,a2
    800228a8:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    800228aa:	577d                	li	a4,-1
    800228ac:	177e                	slli	a4,a4,0x3f
    800228ae:	8dd9                	or	a1,a1,a4
    800228b0:	02000537          	lui	a0,0x2000
    800228b4:	157d                	addi	a0,a0,-1
    800228b6:	0536                	slli	a0,a0,0xd
    800228b8:	9782                	jalr	a5
}
    800228ba:	60a2                	ld	ra,8(sp)
    800228bc:	6402                	ld	s0,0(sp)
    800228be:	0141                	addi	sp,sp,16
    800228c0:	8082                	ret

00000000800228c2 <devintr>:
// Check if it's an external/software interrupt, 
// and handle it. 
// returns  2 if timer interrupt, 
//          1 if other device, 
//          0 if not recognized. 
int devintr(void) {
    800228c2:	1101                	addi	sp,sp,-32
    800228c4:	ec06                	sd	ra,24(sp)
    800228c6:	e822                	sd	s0,16(sp)
    800228c8:	e426                	sd	s1,8(sp)
    800228ca:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    800228cc:	14202773          	csrr	a4,scause
	if ((0x8000000000000000L & scause) && 9 == (scause & 0xff)) 
	#else 
	// on k210, supervisor software interrupt is used 
	// in alternative to supervisor external interrupt, 
	// which is not available on k210. 
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    800228d0:	57fd                	li	a5,-1
    800228d2:	17fe                	slli	a5,a5,0x3f
    800228d4:	0785                	addi	a5,a5,1
    800228d6:	00f70d63          	beq	a4,a5,800228f0 <devintr+0x2e>
		sbi_set_mie();
		#endif 

		return 1;
	}
	else if (0x8000000000000005L == scause) {
    800228da:	57fd                	li	a5,-1
    800228dc:	17fe                	slli	a5,a5,0x3f
    800228de:	0795                	addi	a5,a5,5
		timer_tick();
		return 2;
	}
	else { return 0;}
    800228e0:	4501                	li	a0,0
	else if (0x8000000000000005L == scause) {
    800228e2:	08f70f63          	beq	a4,a5,80022980 <devintr+0xbe>
}
    800228e6:	60e2                	ld	ra,24(sp)
    800228e8:	6442                	ld	s0,16(sp)
    800228ea:	64a2                	ld	s1,8(sp)
    800228ec:	6105                	addi	sp,sp,32
    800228ee:	8082                	ret
  asm volatile("csrr %0, stval" : "=r" (x) );
    800228f0:	14302773          	csrr	a4,stval
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    800228f4:	47a5                	li	a5,9
	else { return 0;}
    800228f6:	4501                	li	a0,0
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    800228f8:	fef717e3          	bne	a4,a5,800228e6 <devintr+0x24>
		int irq = plic_claim();
    800228fc:	00004097          	auipc	ra,0x4
    80022900:	232080e7          	jalr	562(ra) # 80026b2e <plic_claim>
    80022904:	84aa                	mv	s1,a0
		if (UART_IRQ == irq) {
    80022906:	02100793          	li	a5,33
    8002290a:	02f50663          	beq	a0,a5,80022936 <devintr+0x74>
		else if (DISK_IRQ == irq) {
    8002290e:	47ed                	li	a5,27
    80022910:	04f50963          	beq	a0,a5,80022962 <devintr+0xa0>
		else if (irq) {
    80022914:	ed21                	bnez	a0,8002296c <devintr+0xaa>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80022916:	144027f3          	csrr	a5,sip
		w_sip(r_sip() & ~2);    // clear pending bit
    8002291a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    8002291c:	14479073          	csrw	sip,a5
	asm volatile("mv a6, %0" : : "r" (0x210));
	SBI_CALL_1(0x0A000004, func_pointer);
}

static inline void sbi_set_mie(void) {
	SBI_CALL_0(0x0A000005);
    80022920:	4501                	li	a0,0
    80022922:	4581                	li	a1,0
    80022924:	4601                	li	a2,0
    80022926:	4681                	li	a3,0
    80022928:	0a0008b7          	lui	a7,0xa000
    8002292c:	0895                	addi	a7,a7,5
    8002292e:	00000073          	ecall
		return 1;
    80022932:	4505                	li	a0,1
    80022934:	bf4d                	j	800228e6 <devintr+0x24>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
    80022936:	4501                	li	a0,0
    80022938:	4581                	li	a1,0
    8002293a:	4601                	li	a2,0
    8002293c:	4681                	li	a3,0
    8002293e:	4889                	li	a7,2
    80022940:	00000073          	ecall
    80022944:	2501                	sext.w	a0,a0
			if (-1 != c) {
    80022946:	57fd                	li	a5,-1
    80022948:	00f51863          	bne	a0,a5,80022958 <devintr+0x96>
		if (irq) { plic_complete(irq);}
    8002294c:	8526                	mv	a0,s1
    8002294e:	00004097          	auipc	ra,0x4
    80022952:	206080e7          	jalr	518(ra) # 80026b54 <plic_complete>
    80022956:	b7c1                	j	80022916 <devintr+0x54>
				consoleintr(c);
    80022958:	00004097          	auipc	ra,0x4
    8002295c:	408080e7          	jalr	1032(ra) # 80026d60 <consoleintr>
    80022960:	b7f5                	j	8002294c <devintr+0x8a>
			disk_intr();
    80022962:	00003097          	auipc	ra,0x3
    80022966:	82c080e7          	jalr	-2004(ra) # 8002518e <disk_intr>
    8002296a:	b7cd                	j	8002294c <devintr+0x8a>
			printf("unexpected interrupt irq = %d\n", irq);
    8002296c:	85aa                	mv	a1,a0
    8002296e:	00009517          	auipc	a0,0x9
    80022972:	cca50513          	addi	a0,a0,-822 # 8002b638 <states.1738+0x1d0>
    80022976:	ffffe097          	auipc	ra,0xffffe
    8002297a:	81a080e7          	jalr	-2022(ra) # 80020190 <printf>
    8002297e:	b7f9                	j	8002294c <devintr+0x8a>
		timer_tick();
    80022980:	00002097          	auipc	ra,0x2
    80022984:	76c080e7          	jalr	1900(ra) # 800250ec <timer_tick>
		return 2;
    80022988:	4509                	li	a0,2
    8002298a:	bfb1                	j	800228e6 <devintr+0x24>

000000008002298c <usertrap>:
{
    8002298c:	1101                	addi	sp,sp,-32
    8002298e:	ec06                	sd	ra,24(sp)
    80022990:	e822                	sd	s0,16(sp)
    80022992:	e426                	sd	s1,8(sp)
    80022994:	e04a                	sd	s2,0(sp)
    80022996:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022998:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    8002299c:	1007f793          	andi	a5,a5,256
    800229a0:	e3ad                	bnez	a5,80022a02 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    800229a2:	00002797          	auipc	a5,0x2
    800229a6:	66e78793          	addi	a5,a5,1646 # 80025010 <kernelvec>
    800229aa:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800229ae:	fffff097          	auipc	ra,0xfffff
    800229b2:	1a4080e7          	jalr	420(ra) # 80021b52 <myproc>
    800229b6:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    800229b8:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800229ba:	14102773          	csrr	a4,sepc
    800229be:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    800229c0:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    800229c4:	47a1                	li	a5,8
    800229c6:	04f71c63          	bne	a4,a5,80022a1e <usertrap+0x92>
    if(p->killed)
    800229ca:	591c                	lw	a5,48(a0)
    800229cc:	e3b9                	bnez	a5,80022a12 <usertrap+0x86>
    p->trapframe->epc += 4;
    800229ce:	70b8                	ld	a4,96(s1)
    800229d0:	6f1c                	ld	a5,24(a4)
    800229d2:	0791                	addi	a5,a5,4
    800229d4:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800229d6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800229da:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800229de:	10079073          	csrw	sstatus,a5
    syscall();
    800229e2:	00000097          	auipc	ra,0x0
    800229e6:	5d4080e7          	jalr	1492(ra) # 80022fb6 <syscall>
  if(p->killed)
    800229ea:	589c                	lw	a5,48(s1)
    800229ec:	ebd1                	bnez	a5,80022a80 <usertrap+0xf4>
  usertrapret();
    800229ee:	00000097          	auipc	ra,0x0
    800229f2:	e36080e7          	jalr	-458(ra) # 80022824 <usertrapret>
}
    800229f6:	60e2                	ld	ra,24(sp)
    800229f8:	6442                	ld	s0,16(sp)
    800229fa:	64a2                	ld	s1,8(sp)
    800229fc:	6902                	ld	s2,0(sp)
    800229fe:	6105                	addi	sp,sp,32
    80022a00:	8082                	ret
    panic("usertrap: not from user mode");
    80022a02:	00009517          	auipc	a0,0x9
    80022a06:	c5650513          	addi	a0,a0,-938 # 8002b658 <states.1738+0x1f0>
    80022a0a:	ffffd097          	auipc	ra,0xffffd
    80022a0e:	73c080e7          	jalr	1852(ra) # 80020146 <panic>
      exit(-1);
    80022a12:	557d                	li	a0,-1
    80022a14:	00000097          	auipc	ra,0x0
    80022a18:	888080e7          	jalr	-1912(ra) # 8002229c <exit>
    80022a1c:	bf4d                	j	800229ce <usertrap+0x42>
  else if((which_dev = devintr()) != 0){
    80022a1e:	00000097          	auipc	ra,0x0
    80022a22:	ea4080e7          	jalr	-348(ra) # 800228c2 <devintr>
    80022a26:	892a                	mv	s2,a0
    80022a28:	c501                	beqz	a0,80022a30 <usertrap+0xa4>
  if(p->killed)
    80022a2a:	589c                	lw	a5,48(s1)
    80022a2c:	c3b1                	beqz	a5,80022a70 <usertrap+0xe4>
    80022a2e:	a825                	j	80022a66 <usertrap+0xda>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022a30:	142025f3          	csrr	a1,scause
    printf("\nusertrap(): unexpected scause %p pid=%d %s\n", r_scause(), p->pid, p->name);
    80022a34:	16048693          	addi	a3,s1,352
    80022a38:	5c90                	lw	a2,56(s1)
    80022a3a:	00009517          	auipc	a0,0x9
    80022a3e:	c3e50513          	addi	a0,a0,-962 # 8002b678 <states.1738+0x210>
    80022a42:	ffffd097          	auipc	ra,0xffffd
    80022a46:	74e080e7          	jalr	1870(ra) # 80020190 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022a4a:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022a4e:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80022a52:	00009517          	auipc	a0,0x9
    80022a56:	c5650513          	addi	a0,a0,-938 # 8002b6a8 <states.1738+0x240>
    80022a5a:	ffffd097          	auipc	ra,0xffffd
    80022a5e:	736080e7          	jalr	1846(ra) # 80020190 <printf>
    p->killed = 1;
    80022a62:	4785                	li	a5,1
    80022a64:	d89c                	sw	a5,48(s1)
    exit(-1);
    80022a66:	557d                	li	a0,-1
    80022a68:	00000097          	auipc	ra,0x0
    80022a6c:	834080e7          	jalr	-1996(ra) # 8002229c <exit>
  if(which_dev == 2)
    80022a70:	4789                	li	a5,2
    80022a72:	f6f91ee3          	bne	s2,a5,800229ee <usertrap+0x62>
    yield();
    80022a76:	00000097          	auipc	ra,0x0
    80022a7a:	922080e7          	jalr	-1758(ra) # 80022398 <yield>
    80022a7e:	bf85                	j	800229ee <usertrap+0x62>
  int which_dev = 0;
    80022a80:	4901                	li	s2,0
    80022a82:	b7d5                	j	80022a66 <usertrap+0xda>

0000000080022a84 <kerneltrap>:
kerneltrap() {
    80022a84:	7179                	addi	sp,sp,-48
    80022a86:	f406                	sd	ra,40(sp)
    80022a88:	f022                	sd	s0,32(sp)
    80022a8a:	ec26                	sd	s1,24(sp)
    80022a8c:	e84a                	sd	s2,16(sp)
    80022a8e:	e44e                	sd	s3,8(sp)
    80022a90:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022a92:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022a96:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022a9a:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80022a9e:	1004f793          	andi	a5,s1,256
    80022aa2:	cb85                	beqz	a5,80022ad2 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022aa4:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80022aa8:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80022aaa:	ef85                	bnez	a5,80022ae2 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80022aac:	00000097          	auipc	ra,0x0
    80022ab0:	e16080e7          	jalr	-490(ra) # 800228c2 <devintr>
    80022ab4:	cd1d                	beqz	a0,80022af2 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    80022ab6:	4789                	li	a5,2
    80022ab8:	08f50b63          	beq	a0,a5,80022b4e <kerneltrap+0xca>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80022abc:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022ac0:	10049073          	csrw	sstatus,s1
}
    80022ac4:	70a2                	ld	ra,40(sp)
    80022ac6:	7402                	ld	s0,32(sp)
    80022ac8:	64e2                	ld	s1,24(sp)
    80022aca:	6942                	ld	s2,16(sp)
    80022acc:	69a2                	ld	s3,8(sp)
    80022ace:	6145                	addi	sp,sp,48
    80022ad0:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80022ad2:	00009517          	auipc	a0,0x9
    80022ad6:	bf650513          	addi	a0,a0,-1034 # 8002b6c8 <states.1738+0x260>
    80022ada:	ffffd097          	auipc	ra,0xffffd
    80022ade:	66c080e7          	jalr	1644(ra) # 80020146 <panic>
    panic("kerneltrap: interrupts enabled");
    80022ae2:	00009517          	auipc	a0,0x9
    80022ae6:	c0e50513          	addi	a0,a0,-1010 # 8002b6f0 <states.1738+0x288>
    80022aea:	ffffd097          	auipc	ra,0xffffd
    80022aee:	65c080e7          	jalr	1628(ra) # 80020146 <panic>
    printf("\nscause %p\n", scause);
    80022af2:	85ce                	mv	a1,s3
    80022af4:	00009517          	auipc	a0,0x9
    80022af8:	c1c50513          	addi	a0,a0,-996 # 8002b710 <states.1738+0x2a8>
    80022afc:	ffffd097          	auipc	ra,0xffffd
    80022b00:	694080e7          	jalr	1684(ra) # 80020190 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022b04:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022b08:	14302673          	csrr	a2,stval
  asm volatile("mv %0, tp" : "=r" (x) );
    80022b0c:	8692                	mv	a3,tp
    printf("sepc=%p stval=%p hart=%d\n", r_sepc(), r_stval(), r_tp());
    80022b0e:	00009517          	auipc	a0,0x9
    80022b12:	c1250513          	addi	a0,a0,-1006 # 8002b720 <states.1738+0x2b8>
    80022b16:	ffffd097          	auipc	ra,0xffffd
    80022b1a:	67a080e7          	jalr	1658(ra) # 80020190 <printf>
    struct proc *p = myproc();
    80022b1e:	fffff097          	auipc	ra,0xfffff
    80022b22:	034080e7          	jalr	52(ra) # 80021b52 <myproc>
    if (p != 0) {
    80022b26:	cd01                	beqz	a0,80022b3e <kerneltrap+0xba>
      printf("pid: %d, name: %s\n", p->pid, p->name);
    80022b28:	16050613          	addi	a2,a0,352
    80022b2c:	5d0c                	lw	a1,56(a0)
    80022b2e:	00009517          	auipc	a0,0x9
    80022b32:	c1250513          	addi	a0,a0,-1006 # 8002b740 <states.1738+0x2d8>
    80022b36:	ffffd097          	auipc	ra,0xffffd
    80022b3a:	65a080e7          	jalr	1626(ra) # 80020190 <printf>
    panic("kerneltrap");
    80022b3e:	00009517          	auipc	a0,0x9
    80022b42:	c1a50513          	addi	a0,a0,-998 # 8002b758 <states.1738+0x2f0>
    80022b46:	ffffd097          	auipc	ra,0xffffd
    80022b4a:	600080e7          	jalr	1536(ra) # 80020146 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    80022b4e:	fffff097          	auipc	ra,0xfffff
    80022b52:	004080e7          	jalr	4(ra) # 80021b52 <myproc>
    80022b56:	d13d                	beqz	a0,80022abc <kerneltrap+0x38>
    80022b58:	fffff097          	auipc	ra,0xfffff
    80022b5c:	ffa080e7          	jalr	-6(ra) # 80021b52 <myproc>
    80022b60:	4d18                	lw	a4,24(a0)
    80022b62:	478d                	li	a5,3
    80022b64:	f4f71ce3          	bne	a4,a5,80022abc <kerneltrap+0x38>
    yield();
    80022b68:	00000097          	auipc	ra,0x0
    80022b6c:	830080e7          	jalr	-2000(ra) # 80022398 <yield>
    80022b70:	b7b1                	j	80022abc <kerneltrap+0x38>

0000000080022b72 <trapframedump>:

void trapframedump(struct trapframe *tf)
{
    80022b72:	1101                	addi	sp,sp,-32
    80022b74:	ec06                	sd	ra,24(sp)
    80022b76:	e822                	sd	s0,16(sp)
    80022b78:	e426                	sd	s1,8(sp)
    80022b7a:	1000                	addi	s0,sp,32
    80022b7c:	84aa                	mv	s1,a0
  printf("a0: %p\t", tf->a0);
    80022b7e:	792c                	ld	a1,112(a0)
    80022b80:	00009517          	auipc	a0,0x9
    80022b84:	be850513          	addi	a0,a0,-1048 # 8002b768 <states.1738+0x300>
    80022b88:	ffffd097          	auipc	ra,0xffffd
    80022b8c:	608080e7          	jalr	1544(ra) # 80020190 <printf>
  printf("a1: %p\t", tf->a1);
    80022b90:	7cac                	ld	a1,120(s1)
    80022b92:	00009517          	auipc	a0,0x9
    80022b96:	bde50513          	addi	a0,a0,-1058 # 8002b770 <states.1738+0x308>
    80022b9a:	ffffd097          	auipc	ra,0xffffd
    80022b9e:	5f6080e7          	jalr	1526(ra) # 80020190 <printf>
  printf("a2: %p\t", tf->a2);
    80022ba2:	60cc                	ld	a1,128(s1)
    80022ba4:	00009517          	auipc	a0,0x9
    80022ba8:	bd450513          	addi	a0,a0,-1068 # 8002b778 <states.1738+0x310>
    80022bac:	ffffd097          	auipc	ra,0xffffd
    80022bb0:	5e4080e7          	jalr	1508(ra) # 80020190 <printf>
  printf("a3: %p\n", tf->a3);
    80022bb4:	64cc                	ld	a1,136(s1)
    80022bb6:	00009517          	auipc	a0,0x9
    80022bba:	bca50513          	addi	a0,a0,-1078 # 8002b780 <states.1738+0x318>
    80022bbe:	ffffd097          	auipc	ra,0xffffd
    80022bc2:	5d2080e7          	jalr	1490(ra) # 80020190 <printf>
  printf("a4: %p\t", tf->a4);
    80022bc6:	68cc                	ld	a1,144(s1)
    80022bc8:	00009517          	auipc	a0,0x9
    80022bcc:	bc050513          	addi	a0,a0,-1088 # 8002b788 <states.1738+0x320>
    80022bd0:	ffffd097          	auipc	ra,0xffffd
    80022bd4:	5c0080e7          	jalr	1472(ra) # 80020190 <printf>
  printf("a5: %p\t", tf->a5);
    80022bd8:	6ccc                	ld	a1,152(s1)
    80022bda:	00009517          	auipc	a0,0x9
    80022bde:	bb650513          	addi	a0,a0,-1098 # 8002b790 <states.1738+0x328>
    80022be2:	ffffd097          	auipc	ra,0xffffd
    80022be6:	5ae080e7          	jalr	1454(ra) # 80020190 <printf>
  printf("a6: %p\t", tf->a6);
    80022bea:	70cc                	ld	a1,160(s1)
    80022bec:	00009517          	auipc	a0,0x9
    80022bf0:	bac50513          	addi	a0,a0,-1108 # 8002b798 <states.1738+0x330>
    80022bf4:	ffffd097          	auipc	ra,0xffffd
    80022bf8:	59c080e7          	jalr	1436(ra) # 80020190 <printf>
  printf("a7: %p\n", tf->a7);
    80022bfc:	74cc                	ld	a1,168(s1)
    80022bfe:	00009517          	auipc	a0,0x9
    80022c02:	ba250513          	addi	a0,a0,-1118 # 8002b7a0 <states.1738+0x338>
    80022c06:	ffffd097          	auipc	ra,0xffffd
    80022c0a:	58a080e7          	jalr	1418(ra) # 80020190 <printf>
  printf("t0: %p\t", tf->t0);
    80022c0e:	64ac                	ld	a1,72(s1)
    80022c10:	00009517          	auipc	a0,0x9
    80022c14:	b9850513          	addi	a0,a0,-1128 # 8002b7a8 <states.1738+0x340>
    80022c18:	ffffd097          	auipc	ra,0xffffd
    80022c1c:	578080e7          	jalr	1400(ra) # 80020190 <printf>
  printf("t1: %p\t", tf->t1);
    80022c20:	68ac                	ld	a1,80(s1)
    80022c22:	00009517          	auipc	a0,0x9
    80022c26:	b8e50513          	addi	a0,a0,-1138 # 8002b7b0 <states.1738+0x348>
    80022c2a:	ffffd097          	auipc	ra,0xffffd
    80022c2e:	566080e7          	jalr	1382(ra) # 80020190 <printf>
  printf("t2: %p\t", tf->t2);
    80022c32:	6cac                	ld	a1,88(s1)
    80022c34:	00009517          	auipc	a0,0x9
    80022c38:	b8450513          	addi	a0,a0,-1148 # 8002b7b8 <states.1738+0x350>
    80022c3c:	ffffd097          	auipc	ra,0xffffd
    80022c40:	554080e7          	jalr	1364(ra) # 80020190 <printf>
  printf("t3: %p\n", tf->t3);
    80022c44:	1004b583          	ld	a1,256(s1)
    80022c48:	00009517          	auipc	a0,0x9
    80022c4c:	b7850513          	addi	a0,a0,-1160 # 8002b7c0 <states.1738+0x358>
    80022c50:	ffffd097          	auipc	ra,0xffffd
    80022c54:	540080e7          	jalr	1344(ra) # 80020190 <printf>
  printf("t4: %p\t", tf->t4);
    80022c58:	1084b583          	ld	a1,264(s1)
    80022c5c:	00009517          	auipc	a0,0x9
    80022c60:	b6c50513          	addi	a0,a0,-1172 # 8002b7c8 <states.1738+0x360>
    80022c64:	ffffd097          	auipc	ra,0xffffd
    80022c68:	52c080e7          	jalr	1324(ra) # 80020190 <printf>
  printf("t5: %p\t", tf->t5);
    80022c6c:	1104b583          	ld	a1,272(s1)
    80022c70:	00009517          	auipc	a0,0x9
    80022c74:	b6050513          	addi	a0,a0,-1184 # 8002b7d0 <states.1738+0x368>
    80022c78:	ffffd097          	auipc	ra,0xffffd
    80022c7c:	518080e7          	jalr	1304(ra) # 80020190 <printf>
  printf("t6: %p\t", tf->t6);
    80022c80:	1184b583          	ld	a1,280(s1)
    80022c84:	00009517          	auipc	a0,0x9
    80022c88:	b5450513          	addi	a0,a0,-1196 # 8002b7d8 <states.1738+0x370>
    80022c8c:	ffffd097          	auipc	ra,0xffffd
    80022c90:	504080e7          	jalr	1284(ra) # 80020190 <printf>
  printf("s0: %p\n", tf->s0);
    80022c94:	70ac                	ld	a1,96(s1)
    80022c96:	00009517          	auipc	a0,0x9
    80022c9a:	b4a50513          	addi	a0,a0,-1206 # 8002b7e0 <states.1738+0x378>
    80022c9e:	ffffd097          	auipc	ra,0xffffd
    80022ca2:	4f2080e7          	jalr	1266(ra) # 80020190 <printf>
  printf("s1: %p\t", tf->s1);
    80022ca6:	74ac                	ld	a1,104(s1)
    80022ca8:	00009517          	auipc	a0,0x9
    80022cac:	b4050513          	addi	a0,a0,-1216 # 8002b7e8 <states.1738+0x380>
    80022cb0:	ffffd097          	auipc	ra,0xffffd
    80022cb4:	4e0080e7          	jalr	1248(ra) # 80020190 <printf>
  printf("s2: %p\t", tf->s2);
    80022cb8:	78cc                	ld	a1,176(s1)
    80022cba:	00009517          	auipc	a0,0x9
    80022cbe:	b3650513          	addi	a0,a0,-1226 # 8002b7f0 <states.1738+0x388>
    80022cc2:	ffffd097          	auipc	ra,0xffffd
    80022cc6:	4ce080e7          	jalr	1230(ra) # 80020190 <printf>
  printf("s3: %p\t", tf->s3);
    80022cca:	7ccc                	ld	a1,184(s1)
    80022ccc:	00009517          	auipc	a0,0x9
    80022cd0:	b2c50513          	addi	a0,a0,-1236 # 8002b7f8 <states.1738+0x390>
    80022cd4:	ffffd097          	auipc	ra,0xffffd
    80022cd8:	4bc080e7          	jalr	1212(ra) # 80020190 <printf>
  printf("s4: %p\n", tf->s4);
    80022cdc:	60ec                	ld	a1,192(s1)
    80022cde:	00009517          	auipc	a0,0x9
    80022ce2:	b2250513          	addi	a0,a0,-1246 # 8002b800 <states.1738+0x398>
    80022ce6:	ffffd097          	auipc	ra,0xffffd
    80022cea:	4aa080e7          	jalr	1194(ra) # 80020190 <printf>
  printf("s5: %p\t", tf->s5);
    80022cee:	64ec                	ld	a1,200(s1)
    80022cf0:	00009517          	auipc	a0,0x9
    80022cf4:	b1850513          	addi	a0,a0,-1256 # 8002b808 <states.1738+0x3a0>
    80022cf8:	ffffd097          	auipc	ra,0xffffd
    80022cfc:	498080e7          	jalr	1176(ra) # 80020190 <printf>
  printf("s6: %p\t", tf->s6);
    80022d00:	68ec                	ld	a1,208(s1)
    80022d02:	00009517          	auipc	a0,0x9
    80022d06:	b0e50513          	addi	a0,a0,-1266 # 8002b810 <states.1738+0x3a8>
    80022d0a:	ffffd097          	auipc	ra,0xffffd
    80022d0e:	486080e7          	jalr	1158(ra) # 80020190 <printf>
  printf("s7: %p\t", tf->s7);
    80022d12:	6cec                	ld	a1,216(s1)
    80022d14:	00009517          	auipc	a0,0x9
    80022d18:	b0450513          	addi	a0,a0,-1276 # 8002b818 <states.1738+0x3b0>
    80022d1c:	ffffd097          	auipc	ra,0xffffd
    80022d20:	474080e7          	jalr	1140(ra) # 80020190 <printf>
  printf("s8: %p\n", tf->s8);
    80022d24:	70ec                	ld	a1,224(s1)
    80022d26:	00009517          	auipc	a0,0x9
    80022d2a:	afa50513          	addi	a0,a0,-1286 # 8002b820 <states.1738+0x3b8>
    80022d2e:	ffffd097          	auipc	ra,0xffffd
    80022d32:	462080e7          	jalr	1122(ra) # 80020190 <printf>
  printf("s9: %p\t", tf->s9);
    80022d36:	74ec                	ld	a1,232(s1)
    80022d38:	00009517          	auipc	a0,0x9
    80022d3c:	af050513          	addi	a0,a0,-1296 # 8002b828 <states.1738+0x3c0>
    80022d40:	ffffd097          	auipc	ra,0xffffd
    80022d44:	450080e7          	jalr	1104(ra) # 80020190 <printf>
  printf("s10: %p\t", tf->s10);
    80022d48:	78ec                	ld	a1,240(s1)
    80022d4a:	00009517          	auipc	a0,0x9
    80022d4e:	ae650513          	addi	a0,a0,-1306 # 8002b830 <states.1738+0x3c8>
    80022d52:	ffffd097          	auipc	ra,0xffffd
    80022d56:	43e080e7          	jalr	1086(ra) # 80020190 <printf>
  printf("s11: %p\t", tf->s11);
    80022d5a:	7cec                	ld	a1,248(s1)
    80022d5c:	00009517          	auipc	a0,0x9
    80022d60:	ae450513          	addi	a0,a0,-1308 # 8002b840 <states.1738+0x3d8>
    80022d64:	ffffd097          	auipc	ra,0xffffd
    80022d68:	42c080e7          	jalr	1068(ra) # 80020190 <printf>
  printf("ra: %p\n", tf->ra);
    80022d6c:	748c                	ld	a1,40(s1)
    80022d6e:	00008517          	auipc	a0,0x8
    80022d72:	7d250513          	addi	a0,a0,2002 # 8002b540 <states.1738+0xd8>
    80022d76:	ffffd097          	auipc	ra,0xffffd
    80022d7a:	41a080e7          	jalr	1050(ra) # 80020190 <printf>
  printf("sp: %p\t", tf->sp);
    80022d7e:	788c                	ld	a1,48(s1)
    80022d80:	00009517          	auipc	a0,0x9
    80022d84:	ad050513          	addi	a0,a0,-1328 # 8002b850 <states.1738+0x3e8>
    80022d88:	ffffd097          	auipc	ra,0xffffd
    80022d8c:	408080e7          	jalr	1032(ra) # 80020190 <printf>
  printf("gp: %p\t", tf->gp);
    80022d90:	7c8c                	ld	a1,56(s1)
    80022d92:	00009517          	auipc	a0,0x9
    80022d96:	ac650513          	addi	a0,a0,-1338 # 8002b858 <states.1738+0x3f0>
    80022d9a:	ffffd097          	auipc	ra,0xffffd
    80022d9e:	3f6080e7          	jalr	1014(ra) # 80020190 <printf>
  printf("tp: %p\t", tf->tp);
    80022da2:	60ac                	ld	a1,64(s1)
    80022da4:	00009517          	auipc	a0,0x9
    80022da8:	abc50513          	addi	a0,a0,-1348 # 8002b860 <states.1738+0x3f8>
    80022dac:	ffffd097          	auipc	ra,0xffffd
    80022db0:	3e4080e7          	jalr	996(ra) # 80020190 <printf>
  printf("epc: %p\n", tf->epc);
    80022db4:	6c8c                	ld	a1,24(s1)
    80022db6:	00009517          	auipc	a0,0x9
    80022dba:	ab250513          	addi	a0,a0,-1358 # 8002b868 <states.1738+0x400>
    80022dbe:	ffffd097          	auipc	ra,0xffffd
    80022dc2:	3d2080e7          	jalr	978(ra) # 80020190 <printf>
}
    80022dc6:	60e2                	ld	ra,24(sp)
    80022dc8:	6442                	ld	s0,16(sp)
    80022dca:	64a2                	ld	s1,8(sp)
    80022dcc:	6105                	addi	sp,sp,32
    80022dce:	8082                	ret

0000000080022dd0 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80022dd0:	1101                	addi	sp,sp,-32
    80022dd2:	ec06                	sd	ra,24(sp)
    80022dd4:	e822                	sd	s0,16(sp)
    80022dd6:	e426                	sd	s1,8(sp)
    80022dd8:	1000                	addi	s0,sp,32
    80022dda:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80022ddc:	fffff097          	auipc	ra,0xfffff
    80022de0:	d76080e7          	jalr	-650(ra) # 80021b52 <myproc>
  switch (n) {
    80022de4:	4795                	li	a5,5
    80022de6:	0497e163          	bltu	a5,s1,80022e28 <argraw+0x58>
    80022dea:	048a                	slli	s1,s1,0x2
    80022dec:	00009717          	auipc	a4,0x9
    80022df0:	a8c70713          	addi	a4,a4,-1396 # 8002b878 <states.1738+0x410>
    80022df4:	94ba                	add	s1,s1,a4
    80022df6:	409c                	lw	a5,0(s1)
    80022df8:	97ba                	add	a5,a5,a4
    80022dfa:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80022dfc:	713c                	ld	a5,96(a0)
    80022dfe:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80022e00:	60e2                	ld	ra,24(sp)
    80022e02:	6442                	ld	s0,16(sp)
    80022e04:	64a2                	ld	s1,8(sp)
    80022e06:	6105                	addi	sp,sp,32
    80022e08:	8082                	ret
    return p->trapframe->a1;
    80022e0a:	713c                	ld	a5,96(a0)
    80022e0c:	7fa8                	ld	a0,120(a5)
    80022e0e:	bfcd                	j	80022e00 <argraw+0x30>
    return p->trapframe->a2;
    80022e10:	713c                	ld	a5,96(a0)
    80022e12:	63c8                	ld	a0,128(a5)
    80022e14:	b7f5                	j	80022e00 <argraw+0x30>
    return p->trapframe->a3;
    80022e16:	713c                	ld	a5,96(a0)
    80022e18:	67c8                	ld	a0,136(a5)
    80022e1a:	b7dd                	j	80022e00 <argraw+0x30>
    return p->trapframe->a4;
    80022e1c:	713c                	ld	a5,96(a0)
    80022e1e:	6bc8                	ld	a0,144(a5)
    80022e20:	b7c5                	j	80022e00 <argraw+0x30>
    return p->trapframe->a5;
    80022e22:	713c                	ld	a5,96(a0)
    80022e24:	6fc8                	ld	a0,152(a5)
    80022e26:	bfe9                	j	80022e00 <argraw+0x30>
  panic("argraw");
    80022e28:	00009517          	auipc	a0,0x9
    80022e2c:	36850513          	addi	a0,a0,872 # 8002c190 <syscalls+0x828>
    80022e30:	ffffd097          	auipc	ra,0xffffd
    80022e34:	316080e7          	jalr	790(ra) # 80020146 <panic>

0000000080022e38 <sys_sysinfo>:
    return 0;
}

uint64
sys_sysinfo(void)
{
    80022e38:	7179                	addi	sp,sp,-48
    80022e3a:	f406                	sd	ra,40(sp)
    80022e3c:	f022                	sd	s0,32(sp)
    80022e3e:	ec26                	sd	s1,24(sp)
    80022e40:	1800                	addi	s0,sp,48
  *ip = argraw(n);
    80022e42:	4501                	li	a0,0
    80022e44:	00000097          	auipc	ra,0x0
    80022e48:	f8c080e7          	jalr	-116(ra) # 80022dd0 <argraw>
    80022e4c:	84aa                	mv	s1,a0
  if (argaddr(0, &addr) < 0) {
    return -1;
  }

  struct sysinfo info;
  info.freemem = freemem_amount();
    80022e4e:	ffffd097          	auipc	ra,0xffffd
    80022e52:	76a080e7          	jalr	1898(ra) # 800205b8 <freemem_amount>
    80022e56:	fca43823          	sd	a0,-48(s0)
  info.nproc = procnum();
    80022e5a:	00000097          	auipc	ra,0x0
    80022e5e:	8f4080e7          	jalr	-1804(ra) # 8002274e <procnum>
    80022e62:	fca43c23          	sd	a0,-40(s0)

  // if (copyout(p->pagetable, addr, (char *)&info, sizeof(info)) < 0) {
  if (copyout2(addr, (char *)&info, sizeof(info)) < 0) {
    80022e66:	4641                	li	a2,16
    80022e68:	fd040593          	addi	a1,s0,-48
    80022e6c:	8526                	mv	a0,s1
    80022e6e:	ffffe097          	auipc	ra,0xffffe
    80022e72:	5ea080e7          	jalr	1514(ra) # 80021458 <copyout2>
    return -1;
  }

  return 0;
    80022e76:	957d                	srai	a0,a0,0x3f
    80022e78:	70a2                	ld	ra,40(sp)
    80022e7a:	7402                	ld	s0,32(sp)
    80022e7c:	64e2                	ld	s1,24(sp)
    80022e7e:	6145                	addi	sp,sp,48
    80022e80:	8082                	ret

0000000080022e82 <fetchaddr>:
{
    80022e82:	1101                	addi	sp,sp,-32
    80022e84:	ec06                	sd	ra,24(sp)
    80022e86:	e822                	sd	s0,16(sp)
    80022e88:	e426                	sd	s1,8(sp)
    80022e8a:	e04a                	sd	s2,0(sp)
    80022e8c:	1000                	addi	s0,sp,32
    80022e8e:	84aa                	mv	s1,a0
    80022e90:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80022e92:	fffff097          	auipc	ra,0xfffff
    80022e96:	cc0080e7          	jalr	-832(ra) # 80021b52 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80022e9a:	653c                	ld	a5,72(a0)
    80022e9c:	02f4f763          	bgeu	s1,a5,80022eca <fetchaddr+0x48>
    80022ea0:	00848713          	addi	a4,s1,8
    80022ea4:	02e7e563          	bltu	a5,a4,80022ece <fetchaddr+0x4c>
  if(copyin2((char *)ip, addr, sizeof(*ip)) != 0)
    80022ea8:	4621                	li	a2,8
    80022eaa:	85a6                	mv	a1,s1
    80022eac:	854a                	mv	a0,s2
    80022eae:	ffffe097          	auipc	ra,0xffffe
    80022eb2:	68a080e7          	jalr	1674(ra) # 80021538 <copyin2>
    80022eb6:	00a03533          	snez	a0,a0
    80022eba:	40a00533          	neg	a0,a0
}
    80022ebe:	60e2                	ld	ra,24(sp)
    80022ec0:	6442                	ld	s0,16(sp)
    80022ec2:	64a2                	ld	s1,8(sp)
    80022ec4:	6902                	ld	s2,0(sp)
    80022ec6:	6105                	addi	sp,sp,32
    80022ec8:	8082                	ret
    return -1;
    80022eca:	557d                	li	a0,-1
    80022ecc:	bfcd                	j	80022ebe <fetchaddr+0x3c>
    80022ece:	557d                	li	a0,-1
    80022ed0:	b7fd                	j	80022ebe <fetchaddr+0x3c>

0000000080022ed2 <fetchstr>:
{
    80022ed2:	1101                	addi	sp,sp,-32
    80022ed4:	ec06                	sd	ra,24(sp)
    80022ed6:	e822                	sd	s0,16(sp)
    80022ed8:	e426                	sd	s1,8(sp)
    80022eda:	1000                	addi	s0,sp,32
    80022edc:	84ae                	mv	s1,a1
  int err = copyinstr2(buf, addr, max);
    80022ede:	85aa                	mv	a1,a0
    80022ee0:	8526                	mv	a0,s1
    80022ee2:	ffffe097          	auipc	ra,0xffffe
    80022ee6:	76e080e7          	jalr	1902(ra) # 80021650 <copyinstr2>
  if(err < 0)
    80022eea:	00054763          	bltz	a0,80022ef8 <fetchstr+0x26>
  return strlen(buf);
    80022eee:	8526                	mv	a0,s1
    80022ef0:	ffffe097          	auipc	ra,0xffffe
    80022ef4:	a16080e7          	jalr	-1514(ra) # 80020906 <strlen>
}
    80022ef8:	60e2                	ld	ra,24(sp)
    80022efa:	6442                	ld	s0,16(sp)
    80022efc:	64a2                	ld	s1,8(sp)
    80022efe:	6105                	addi	sp,sp,32
    80022f00:	8082                	ret

0000000080022f02 <argint>:
{
    80022f02:	1101                	addi	sp,sp,-32
    80022f04:	ec06                	sd	ra,24(sp)
    80022f06:	e822                	sd	s0,16(sp)
    80022f08:	e426                	sd	s1,8(sp)
    80022f0a:	1000                	addi	s0,sp,32
    80022f0c:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80022f0e:	00000097          	auipc	ra,0x0
    80022f12:	ec2080e7          	jalr	-318(ra) # 80022dd0 <argraw>
    80022f16:	c088                	sw	a0,0(s1)
}
    80022f18:	4501                	li	a0,0
    80022f1a:	60e2                	ld	ra,24(sp)
    80022f1c:	6442                	ld	s0,16(sp)
    80022f1e:	64a2                	ld	s1,8(sp)
    80022f20:	6105                	addi	sp,sp,32
    80022f22:	8082                	ret

0000000080022f24 <sys_test_proc>:
sys_test_proc(void) {
    80022f24:	1101                	addi	sp,sp,-32
    80022f26:	ec06                	sd	ra,24(sp)
    80022f28:	e822                	sd	s0,16(sp)
    80022f2a:	1000                	addi	s0,sp,32
    argint(0, &n);
    80022f2c:	fec40593          	addi	a1,s0,-20
    80022f30:	4501                	li	a0,0
    80022f32:	00000097          	auipc	ra,0x0
    80022f36:	fd0080e7          	jalr	-48(ra) # 80022f02 <argint>
    printf("hello world from proc %d, hart %d, arg %d\n", myproc()->pid, r_tp(), n);
    80022f3a:	fffff097          	auipc	ra,0xfffff
    80022f3e:	c18080e7          	jalr	-1000(ra) # 80021b52 <myproc>
    80022f42:	8612                	mv	a2,tp
    80022f44:	fec42683          	lw	a3,-20(s0)
    80022f48:	5d0c                	lw	a1,56(a0)
    80022f4a:	00009517          	auipc	a0,0x9
    80022f4e:	24e50513          	addi	a0,a0,590 # 8002c198 <syscalls+0x830>
    80022f52:	ffffd097          	auipc	ra,0xffffd
    80022f56:	23e080e7          	jalr	574(ra) # 80020190 <printf>
}
    80022f5a:	4501                	li	a0,0
    80022f5c:	60e2                	ld	ra,24(sp)
    80022f5e:	6442                	ld	s0,16(sp)
    80022f60:	6105                	addi	sp,sp,32
    80022f62:	8082                	ret

0000000080022f64 <argaddr>:
{
    80022f64:	1101                	addi	sp,sp,-32
    80022f66:	ec06                	sd	ra,24(sp)
    80022f68:	e822                	sd	s0,16(sp)
    80022f6a:	e426                	sd	s1,8(sp)
    80022f6c:	1000                	addi	s0,sp,32
    80022f6e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80022f70:	00000097          	auipc	ra,0x0
    80022f74:	e60080e7          	jalr	-416(ra) # 80022dd0 <argraw>
    80022f78:	e088                	sd	a0,0(s1)
}
    80022f7a:	4501                	li	a0,0
    80022f7c:	60e2                	ld	ra,24(sp)
    80022f7e:	6442                	ld	s0,16(sp)
    80022f80:	64a2                	ld	s1,8(sp)
    80022f82:	6105                	addi	sp,sp,32
    80022f84:	8082                	ret

0000000080022f86 <argstr>:
{
    80022f86:	1101                	addi	sp,sp,-32
    80022f88:	ec06                	sd	ra,24(sp)
    80022f8a:	e822                	sd	s0,16(sp)
    80022f8c:	e426                	sd	s1,8(sp)
    80022f8e:	e04a                	sd	s2,0(sp)
    80022f90:	1000                	addi	s0,sp,32
    80022f92:	84ae                	mv	s1,a1
    80022f94:	8932                	mv	s2,a2
  *ip = argraw(n);
    80022f96:	00000097          	auipc	ra,0x0
    80022f9a:	e3a080e7          	jalr	-454(ra) # 80022dd0 <argraw>
  return fetchstr(addr, buf, max);
    80022f9e:	864a                	mv	a2,s2
    80022fa0:	85a6                	mv	a1,s1
    80022fa2:	00000097          	auipc	ra,0x0
    80022fa6:	f30080e7          	jalr	-208(ra) # 80022ed2 <fetchstr>
}
    80022faa:	60e2                	ld	ra,24(sp)
    80022fac:	6442                	ld	s0,16(sp)
    80022fae:	64a2                	ld	s1,8(sp)
    80022fb0:	6902                	ld	s2,0(sp)
    80022fb2:	6105                	addi	sp,sp,32
    80022fb4:	8082                	ret

0000000080022fb6 <syscall>:
{
    80022fb6:	7179                	addi	sp,sp,-48
    80022fb8:	f406                	sd	ra,40(sp)
    80022fba:	f022                	sd	s0,32(sp)
    80022fbc:	ec26                	sd	s1,24(sp)
    80022fbe:	e84a                	sd	s2,16(sp)
    80022fc0:	e44e                	sd	s3,8(sp)
    80022fc2:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80022fc4:	fffff097          	auipc	ra,0xfffff
    80022fc8:	b8e080e7          	jalr	-1138(ra) # 80021b52 <myproc>
    80022fcc:	84aa                	mv	s1,a0
  num = p->trapframe->a7;
    80022fce:	06053983          	ld	s3,96(a0)
    80022fd2:	0a89b783          	ld	a5,168(s3)
    80022fd6:	0007891b          	sext.w	s2,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80022fda:	37fd                	addiw	a5,a5,-1
    80022fdc:	10300713          	li	a4,259
    80022fe0:	04f76863          	bltu	a4,a5,80023030 <syscall+0x7a>
    80022fe4:	00391713          	slli	a4,s2,0x3
    80022fe8:	00009797          	auipc	a5,0x9
    80022fec:	98078793          	addi	a5,a5,-1664 # 8002b968 <syscalls>
    80022ff0:	97ba                	add	a5,a5,a4
    80022ff2:	639c                	ld	a5,0(a5)
    80022ff4:	cf95                	beqz	a5,80023030 <syscall+0x7a>
    p->trapframe->a0 = syscalls[num]();
    80022ff6:	9782                	jalr	a5
    80022ff8:	06a9b823          	sd	a0,112(s3)
    if ((p->tmask & (1 << num)) != 0) {
    80022ffc:	1704a783          	lw	a5,368(s1)
    80023000:	4127d7bb          	sraw	a5,a5,s2
    80023004:	8b85                	andi	a5,a5,1
    80023006:	c7a1                	beqz	a5,8002304e <syscall+0x98>
      printf("pid %d: %s -> %d\n", p->pid, sysnames[num], p->trapframe->a0);
    80023008:	70b8                	ld	a4,96(s1)
    8002300a:	090e                	slli	s2,s2,0x3
    8002300c:	00009797          	auipc	a5,0x9
    80023010:	88478793          	addi	a5,a5,-1916 # 8002b890 <sysnames>
    80023014:	993e                	add	s2,s2,a5
    80023016:	7b34                	ld	a3,112(a4)
    80023018:	00093603          	ld	a2,0(s2)
    8002301c:	5c8c                	lw	a1,56(s1)
    8002301e:	00009517          	auipc	a0,0x9
    80023022:	1aa50513          	addi	a0,a0,426 # 8002c1c8 <syscalls+0x860>
    80023026:	ffffd097          	auipc	ra,0xffffd
    8002302a:	16a080e7          	jalr	362(ra) # 80020190 <printf>
    8002302e:	a005                	j	8002304e <syscall+0x98>
    printf("pid %d %s: unknown sys call %d\n",
    80023030:	86ca                	mv	a3,s2
    80023032:	16048613          	addi	a2,s1,352
    80023036:	5c8c                	lw	a1,56(s1)
    80023038:	00009517          	auipc	a0,0x9
    8002303c:	1a850513          	addi	a0,a0,424 # 8002c1e0 <syscalls+0x878>
    80023040:	ffffd097          	auipc	ra,0xffffd
    80023044:	150080e7          	jalr	336(ra) # 80020190 <printf>
    p->trapframe->a0 = -1;
    80023048:	70bc                	ld	a5,96(s1)
    8002304a:	577d                	li	a4,-1
    8002304c:	fbb8                	sd	a4,112(a5)
}
    8002304e:	70a2                	ld	ra,40(sp)
    80023050:	7402                	ld	s0,32(sp)
    80023052:	64e2                	ld	s1,24(sp)
    80023054:	6942                	ld	s2,16(sp)
    80023056:	69a2                	ld	s3,8(sp)
    80023058:	6145                	addi	sp,sp,48
    8002305a:	8082                	ret

000000008002305c <sys_exec>:

extern int exec(char *path, char **argv);

uint64
sys_exec(void)
{
    8002305c:	da010113          	addi	sp,sp,-608
    80023060:	24113c23          	sd	ra,600(sp)
    80023064:	24813823          	sd	s0,592(sp)
    80023068:	24913423          	sd	s1,584(sp)
    8002306c:	25213023          	sd	s2,576(sp)
    80023070:	23313c23          	sd	s3,568(sp)
    80023074:	23413823          	sd	s4,560(sp)
    80023078:	23513423          	sd	s5,552(sp)
    8002307c:	1480                	addi	s0,sp,608
  char path[FAT32_MAX_PATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argaddr(1, &uargv) < 0){
    8002307e:	10400613          	li	a2,260
    80023082:	eb840593          	addi	a1,s0,-328
    80023086:	4501                	li	a0,0
    80023088:	00000097          	auipc	ra,0x0
    8002308c:	efe080e7          	jalr	-258(ra) # 80022f86 <argstr>
    return -1;
    80023090:	597d                	li	s2,-1
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argaddr(1, &uargv) < 0){
    80023092:	0e054c63          	bltz	a0,8002318a <sys_exec+0x12e>
    80023096:	db040593          	addi	a1,s0,-592
    8002309a:	4505                	li	a0,1
    8002309c:	00000097          	auipc	ra,0x0
    800230a0:	ec8080e7          	jalr	-312(ra) # 80022f64 <argaddr>
    800230a4:	0e054363          	bltz	a0,8002318a <sys_exec+0x12e>
  }
  memset(argv, 0, sizeof(argv));
    800230a8:	db840913          	addi	s2,s0,-584
    800230ac:	10000613          	li	a2,256
    800230b0:	4581                	li	a1,0
    800230b2:	854a                	mv	a0,s2
    800230b4:	ffffd097          	auipc	ra,0xffffd
    800230b8:	6a8080e7          	jalr	1704(ra) # 8002075c <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800230bc:	89ca                	mv	s3,s2
  memset(argv, 0, sizeof(argv));
    800230be:	4481                	li	s1,0
    if(i >= NELEM(argv)){
    800230c0:	02000a93          	li	s5,32
    800230c4:	00048a1b          	sext.w	s4,s1
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800230c8:	00349513          	slli	a0,s1,0x3
    800230cc:	da840593          	addi	a1,s0,-600
    800230d0:	db043783          	ld	a5,-592(s0)
    800230d4:	953e                	add	a0,a0,a5
    800230d6:	00000097          	auipc	ra,0x0
    800230da:	dac080e7          	jalr	-596(ra) # 80022e82 <fetchaddr>
    800230de:	02054a63          	bltz	a0,80023112 <sys_exec+0xb6>
      goto bad;
    }
    if(uarg == 0){
    800230e2:	da843783          	ld	a5,-600(s0)
    800230e6:	cfa9                	beqz	a5,80023140 <sys_exec+0xe4>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800230e8:	ffffd097          	auipc	ra,0xffffd
    800230ec:	46a080e7          	jalr	1130(ra) # 80020552 <kalloc>
    800230f0:	00a93023          	sd	a0,0(s2)
    if(argv[i] == 0)
    800230f4:	cd19                	beqz	a0,80023112 <sys_exec+0xb6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800230f6:	6605                	lui	a2,0x1
    800230f8:	85aa                	mv	a1,a0
    800230fa:	da843503          	ld	a0,-600(s0)
    800230fe:	00000097          	auipc	ra,0x0
    80023102:	dd4080e7          	jalr	-556(ra) # 80022ed2 <fetchstr>
    80023106:	00054663          	bltz	a0,80023112 <sys_exec+0xb6>
    if(i >= NELEM(argv)){
    8002310a:	0485                	addi	s1,s1,1
    8002310c:	0921                	addi	s2,s2,8
    8002310e:	fb549be3          	bne	s1,s5,800230c4 <sys_exec+0x68>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80023112:	db843503          	ld	a0,-584(s0)
    kfree(argv[i]);
  return -1;
    80023116:	597d                	li	s2,-1
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80023118:	c92d                	beqz	a0,8002318a <sys_exec+0x12e>
    kfree(argv[i]);
    8002311a:	ffffd097          	auipc	ra,0xffffd
    8002311e:	31e080e7          	jalr	798(ra) # 80020438 <kfree>
    80023122:	dc040493          	addi	s1,s0,-576
    80023126:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002312a:	6088                	ld	a0,0(s1)
    8002312c:	cd31                	beqz	a0,80023188 <sys_exec+0x12c>
    kfree(argv[i]);
    8002312e:	ffffd097          	auipc	ra,0xffffd
    80023132:	30a080e7          	jalr	778(ra) # 80020438 <kfree>
    80023136:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80023138:	ff3499e3          	bne	s1,s3,8002312a <sys_exec+0xce>
  return -1;
    8002313c:	597d                	li	s2,-1
    8002313e:	a0b1                	j	8002318a <sys_exec+0x12e>
      argv[i] = 0;
    80023140:	0a0e                	slli	s4,s4,0x3
    80023142:	fc040793          	addi	a5,s0,-64
    80023146:	9a3e                	add	s4,s4,a5
    80023148:	de0a3c23          	sd	zero,-520(s4)
  int ret = exec(path, argv);
    8002314c:	db840593          	addi	a1,s0,-584
    80023150:	eb840513          	addi	a0,s0,-328
    80023154:	00001097          	auipc	ra,0x1
    80023158:	eba080e7          	jalr	-326(ra) # 8002400e <exec>
    8002315c:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002315e:	db843503          	ld	a0,-584(s0)
    80023162:	c505                	beqz	a0,8002318a <sys_exec+0x12e>
    kfree(argv[i]);
    80023164:	ffffd097          	auipc	ra,0xffffd
    80023168:	2d4080e7          	jalr	724(ra) # 80020438 <kfree>
    8002316c:	dc040493          	addi	s1,s0,-576
    80023170:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80023174:	6088                	ld	a0,0(s1)
    80023176:	c911                	beqz	a0,8002318a <sys_exec+0x12e>
    kfree(argv[i]);
    80023178:	ffffd097          	auipc	ra,0xffffd
    8002317c:	2c0080e7          	jalr	704(ra) # 80020438 <kfree>
    80023180:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80023182:	ff3499e3          	bne	s1,s3,80023174 <sys_exec+0x118>
    80023186:	a011                	j	8002318a <sys_exec+0x12e>
  return -1;
    80023188:	597d                	li	s2,-1
}
    8002318a:	854a                	mv	a0,s2
    8002318c:	25813083          	ld	ra,600(sp)
    80023190:	25013403          	ld	s0,592(sp)
    80023194:	24813483          	ld	s1,584(sp)
    80023198:	24013903          	ld	s2,576(sp)
    8002319c:	23813983          	ld	s3,568(sp)
    800231a0:	23013a03          	ld	s4,560(sp)
    800231a4:	22813a83          	ld	s5,552(sp)
    800231a8:	26010113          	addi	sp,sp,608
    800231ac:	8082                	ret

00000000800231ae <sys_exit>:

uint64
sys_exit(void)
{
    800231ae:	1101                	addi	sp,sp,-32
    800231b0:	ec06                	sd	ra,24(sp)
    800231b2:	e822                	sd	s0,16(sp)
    800231b4:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    800231b6:	fec40593          	addi	a1,s0,-20
    800231ba:	4501                	li	a0,0
    800231bc:	00000097          	auipc	ra,0x0
    800231c0:	d46080e7          	jalr	-698(ra) # 80022f02 <argint>
    return -1;
    800231c4:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800231c6:	00054963          	bltz	a0,800231d8 <sys_exit+0x2a>
  exit(n);
    800231ca:	fec42503          	lw	a0,-20(s0)
    800231ce:	fffff097          	auipc	ra,0xfffff
    800231d2:	0ce080e7          	jalr	206(ra) # 8002229c <exit>
  return 0;  // not reached
    800231d6:	4781                	li	a5,0
}
    800231d8:	853e                	mv	a0,a5
    800231da:	60e2                	ld	ra,24(sp)
    800231dc:	6442                	ld	s0,16(sp)
    800231de:	6105                	addi	sp,sp,32
    800231e0:	8082                	ret

00000000800231e2 <sys_getpid>:

uint64
sys_getpid(void)
{
    800231e2:	1141                	addi	sp,sp,-16
    800231e4:	e406                	sd	ra,8(sp)
    800231e6:	e022                	sd	s0,0(sp)
    800231e8:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800231ea:	fffff097          	auipc	ra,0xfffff
    800231ee:	968080e7          	jalr	-1688(ra) # 80021b52 <myproc>
}
    800231f2:	5d08                	lw	a0,56(a0)
    800231f4:	60a2                	ld	ra,8(sp)
    800231f6:	6402                	ld	s0,0(sp)
    800231f8:	0141                	addi	sp,sp,16
    800231fa:	8082                	ret

00000000800231fc <sys_fork>:

uint64
sys_fork(void)
{
    800231fc:	1141                	addi	sp,sp,-16
    800231fe:	e406                	sd	ra,8(sp)
    80023200:	e022                	sd	s0,0(sp)
    80023202:	0800                	addi	s0,sp,16
  return fork();
    80023204:	fffff097          	auipc	ra,0xfffff
    80023208:	d5c080e7          	jalr	-676(ra) # 80021f60 <fork>
}
    8002320c:	60a2                	ld	ra,8(sp)
    8002320e:	6402                	ld	s0,0(sp)
    80023210:	0141                	addi	sp,sp,16
    80023212:	8082                	ret

0000000080023214 <sys_wait>:

uint64
sys_wait(void)
{
    80023214:	1101                	addi	sp,sp,-32
    80023216:	ec06                	sd	ra,24(sp)
    80023218:	e822                	sd	s0,16(sp)
    8002321a:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    8002321c:	fe840593          	addi	a1,s0,-24
    80023220:	4501                	li	a0,0
    80023222:	00000097          	auipc	ra,0x0
    80023226:	d42080e7          	jalr	-702(ra) # 80022f64 <argaddr>
    return -1;
    8002322a:	57fd                	li	a5,-1
  if(argaddr(0, &p) < 0)
    8002322c:	00054963          	bltz	a0,8002323e <sys_wait+0x2a>
  return wait(p);
    80023230:	fe843503          	ld	a0,-24(s0)
    80023234:	fffff097          	auipc	ra,0xfffff
    80023238:	21e080e7          	jalr	542(ra) # 80022452 <wait>
    8002323c:	87aa                	mv	a5,a0
}
    8002323e:	853e                	mv	a0,a5
    80023240:	60e2                	ld	ra,24(sp)
    80023242:	6442                	ld	s0,16(sp)
    80023244:	6105                	addi	sp,sp,32
    80023246:	8082                	ret

0000000080023248 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80023248:	7179                	addi	sp,sp,-48
    8002324a:	f406                	sd	ra,40(sp)
    8002324c:	f022                	sd	s0,32(sp)
    8002324e:	ec26                	sd	s1,24(sp)
    80023250:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80023252:	fdc40593          	addi	a1,s0,-36
    80023256:	4501                	li	a0,0
    80023258:	00000097          	auipc	ra,0x0
    8002325c:	caa080e7          	jalr	-854(ra) # 80022f02 <argint>
    return -1;
    80023260:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    80023262:	00054f63          	bltz	a0,80023280 <sys_sbrk+0x38>
  addr = myproc()->sz;
    80023266:	fffff097          	auipc	ra,0xfffff
    8002326a:	8ec080e7          	jalr	-1812(ra) # 80021b52 <myproc>
    8002326e:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    80023270:	fdc42503          	lw	a0,-36(s0)
    80023274:	fffff097          	auipc	ra,0xfffff
    80023278:	c6c080e7          	jalr	-916(ra) # 80021ee0 <growproc>
    8002327c:	00054863          	bltz	a0,8002328c <sys_sbrk+0x44>
    return -1;
  return addr;
}
    80023280:	8526                	mv	a0,s1
    80023282:	70a2                	ld	ra,40(sp)
    80023284:	7402                	ld	s0,32(sp)
    80023286:	64e2                	ld	s1,24(sp)
    80023288:	6145                	addi	sp,sp,48
    8002328a:	8082                	ret
    return -1;
    8002328c:	54fd                	li	s1,-1
    8002328e:	bfcd                	j	80023280 <sys_sbrk+0x38>

0000000080023290 <sys_sleep>:

uint64
sys_sleep(void)
{
    80023290:	7139                	addi	sp,sp,-64
    80023292:	fc06                	sd	ra,56(sp)
    80023294:	f822                	sd	s0,48(sp)
    80023296:	f426                	sd	s1,40(sp)
    80023298:	f04a                	sd	s2,32(sp)
    8002329a:	ec4e                	sd	s3,24(sp)
    8002329c:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    8002329e:	fcc40593          	addi	a1,s0,-52
    800232a2:	4501                	li	a0,0
    800232a4:	00000097          	auipc	ra,0x0
    800232a8:	c5e080e7          	jalr	-930(ra) # 80022f02 <argint>
    return -1;
    800232ac:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800232ae:	06054763          	bltz	a0,8002331c <sys_sleep+0x8c>
  acquire(&tickslock);
    800232b2:	0001d517          	auipc	a0,0x1d
    800232b6:	15650513          	addi	a0,a0,342 # 80040408 <tickslock>
    800232ba:	ffffd097          	auipc	ra,0xffffd
    800232be:	406080e7          	jalr	1030(ra) # 800206c0 <acquire>
  ticks0 = ticks;
    800232c2:	0001d797          	auipc	a5,0x1d
    800232c6:	15e78793          	addi	a5,a5,350 # 80040420 <ticks>
    800232ca:	0007a903          	lw	s2,0(a5)
  while(ticks - ticks0 < n){
    800232ce:	fcc42783          	lw	a5,-52(s0)
    800232d2:	cf85                	beqz	a5,8002330a <sys_sleep+0x7a>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800232d4:	0001d997          	auipc	s3,0x1d
    800232d8:	13498993          	addi	s3,s3,308 # 80040408 <tickslock>
    800232dc:	0001d497          	auipc	s1,0x1d
    800232e0:	14448493          	addi	s1,s1,324 # 80040420 <ticks>
    if(myproc()->killed){
    800232e4:	fffff097          	auipc	ra,0xfffff
    800232e8:	86e080e7          	jalr	-1938(ra) # 80021b52 <myproc>
    800232ec:	591c                	lw	a5,48(a0)
    800232ee:	ef9d                	bnez	a5,8002332c <sys_sleep+0x9c>
    sleep(&ticks, &tickslock);
    800232f0:	85ce                	mv	a1,s3
    800232f2:	8526                	mv	a0,s1
    800232f4:	fffff097          	auipc	ra,0xfffff
    800232f8:	0e0080e7          	jalr	224(ra) # 800223d4 <sleep>
  while(ticks - ticks0 < n){
    800232fc:	409c                	lw	a5,0(s1)
    800232fe:	412787bb          	subw	a5,a5,s2
    80023302:	fcc42703          	lw	a4,-52(s0)
    80023306:	fce7efe3          	bltu	a5,a4,800232e4 <sys_sleep+0x54>
  }
  release(&tickslock);
    8002330a:	0001d517          	auipc	a0,0x1d
    8002330e:	0fe50513          	addi	a0,a0,254 # 80040408 <tickslock>
    80023312:	ffffd097          	auipc	ra,0xffffd
    80023316:	402080e7          	jalr	1026(ra) # 80020714 <release>
  return 0;
    8002331a:	4781                	li	a5,0
}
    8002331c:	853e                	mv	a0,a5
    8002331e:	70e2                	ld	ra,56(sp)
    80023320:	7442                	ld	s0,48(sp)
    80023322:	74a2                	ld	s1,40(sp)
    80023324:	7902                	ld	s2,32(sp)
    80023326:	69e2                	ld	s3,24(sp)
    80023328:	6121                	addi	sp,sp,64
    8002332a:	8082                	ret
      release(&tickslock);
    8002332c:	0001d517          	auipc	a0,0x1d
    80023330:	0dc50513          	addi	a0,a0,220 # 80040408 <tickslock>
    80023334:	ffffd097          	auipc	ra,0xffffd
    80023338:	3e0080e7          	jalr	992(ra) # 80020714 <release>
      return -1;
    8002333c:	57fd                	li	a5,-1
    8002333e:	bff9                	j	8002331c <sys_sleep+0x8c>

0000000080023340 <sys_kill>:

uint64
sys_kill(void)
{
    80023340:	1101                	addi	sp,sp,-32
    80023342:	ec06                	sd	ra,24(sp)
    80023344:	e822                	sd	s0,16(sp)
    80023346:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80023348:	fec40593          	addi	a1,s0,-20
    8002334c:	4501                	li	a0,0
    8002334e:	00000097          	auipc	ra,0x0
    80023352:	bb4080e7          	jalr	-1100(ra) # 80022f02 <argint>
    return -1;
    80023356:	57fd                	li	a5,-1
  if(argint(0, &pid) < 0)
    80023358:	00054963          	bltz	a0,8002336a <sys_kill+0x2a>
  return kill(pid);
    8002335c:	fec42503          	lw	a0,-20(s0)
    80023360:	fffff097          	auipc	ra,0xfffff
    80023364:	260080e7          	jalr	608(ra) # 800225c0 <kill>
    80023368:	87aa                	mv	a5,a0
}
    8002336a:	853e                	mv	a0,a5
    8002336c:	60e2                	ld	ra,24(sp)
    8002336e:	6442                	ld	s0,16(sp)
    80023370:	6105                	addi	sp,sp,32
    80023372:	8082                	ret

0000000080023374 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80023374:	1101                	addi	sp,sp,-32
    80023376:	ec06                	sd	ra,24(sp)
    80023378:	e822                	sd	s0,16(sp)
    8002337a:	e426                	sd	s1,8(sp)
    8002337c:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    8002337e:	0001d517          	auipc	a0,0x1d
    80023382:	08a50513          	addi	a0,a0,138 # 80040408 <tickslock>
    80023386:	ffffd097          	auipc	ra,0xffffd
    8002338a:	33a080e7          	jalr	826(ra) # 800206c0 <acquire>
  xticks = ticks;
    8002338e:	0001d797          	auipc	a5,0x1d
    80023392:	09278793          	addi	a5,a5,146 # 80040420 <ticks>
    80023396:	4384                	lw	s1,0(a5)
  release(&tickslock);
    80023398:	0001d517          	auipc	a0,0x1d
    8002339c:	07050513          	addi	a0,a0,112 # 80040408 <tickslock>
    800233a0:	ffffd097          	auipc	ra,0xffffd
    800233a4:	374080e7          	jalr	884(ra) # 80020714 <release>
  return xticks;
}
    800233a8:	02049513          	slli	a0,s1,0x20
    800233ac:	9101                	srli	a0,a0,0x20
    800233ae:	60e2                	ld	ra,24(sp)
    800233b0:	6442                	ld	s0,16(sp)
    800233b2:	64a2                	ld	s1,8(sp)
    800233b4:	6105                	addi	sp,sp,32
    800233b6:	8082                	ret

00000000800233b8 <sys_trace>:

uint64
sys_trace(void)
{
    800233b8:	1101                	addi	sp,sp,-32
    800233ba:	ec06                	sd	ra,24(sp)
    800233bc:	e822                	sd	s0,16(sp)
    800233be:	1000                	addi	s0,sp,32
  int mask;
  if(argint(0, &mask) < 0) {
    800233c0:	fec40593          	addi	a1,s0,-20
    800233c4:	4501                	li	a0,0
    800233c6:	00000097          	auipc	ra,0x0
    800233ca:	b3c080e7          	jalr	-1220(ra) # 80022f02 <argint>
    return -1;
    800233ce:	57fd                	li	a5,-1
  if(argint(0, &mask) < 0) {
    800233d0:	00054b63          	bltz	a0,800233e6 <sys_trace+0x2e>
  }
  myproc()->tmask = mask;
    800233d4:	ffffe097          	auipc	ra,0xffffe
    800233d8:	77e080e7          	jalr	1918(ra) # 80021b52 <myproc>
    800233dc:	fec42783          	lw	a5,-20(s0)
    800233e0:	16f52823          	sw	a5,368(a0)
  return 0;
    800233e4:	4781                	li	a5,0
    800233e6:	853e                	mv	a0,a5
    800233e8:	60e2                	ld	ra,24(sp)
    800233ea:	6442                	ld	s0,16(sp)
    800233ec:	6105                	addi	sp,sp,32
    800233ee:	8082                	ret

00000000800233f0 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800233f0:	7139                	addi	sp,sp,-64
    800233f2:	fc06                	sd	ra,56(sp)
    800233f4:	f822                	sd	s0,48(sp)
    800233f6:	f426                	sd	s1,40(sp)
    800233f8:	f04a                	sd	s2,32(sp)
    800233fa:	ec4e                	sd	s3,24(sp)
    800233fc:	e852                	sd	s4,16(sp)
    800233fe:	e456                	sd	s5,8(sp)
    80023400:	0080                	addi	s0,sp,64
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80023402:	00009597          	auipc	a1,0x9
    80023406:	ec658593          	addi	a1,a1,-314 # 8002c2c8 <syscalls+0x960>
    8002340a:	00017517          	auipc	a0,0x17
    8002340e:	6e650513          	addi	a0,a0,1766 # 8003aaf0 <bcache>
    80023412:	ffffd097          	auipc	ra,0xffffd
    80023416:	26a080e7          	jalr	618(ra) # 8002067c <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8002341a:	0001b797          	auipc	a5,0x1b
    8002341e:	6d678793          	addi	a5,a5,1750 # 8003eaf0 <bcache+0x4000>
    80023422:	0001c717          	auipc	a4,0x1c
    80023426:	d3670713          	addi	a4,a4,-714 # 8003f158 <bcache+0x4668>
    8002342a:	6ae7b823          	sd	a4,1712(a5)
  bcache.head.next = &bcache.head;
    8002342e:	6ae7bc23          	sd	a4,1720(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80023432:	00017497          	auipc	s1,0x17
    80023436:	6d648493          	addi	s1,s1,1750 # 8003ab08 <bcache+0x18>
    b->refcnt = 0;
    b->sectorno = ~0;
    8002343a:	5a7d                	li	s4,-1
    b->dev = ~0;
    b->next = bcache.head.next;
    8002343c:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    8002343e:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80023440:	00009a97          	auipc	s5,0x9
    80023444:	e90a8a93          	addi	s5,s5,-368 # 8002c2d0 <syscalls+0x968>
    b->refcnt = 0;
    80023448:	0404a023          	sw	zero,64(s1)
    b->sectorno = ~0;
    8002344c:	0144a623          	sw	s4,12(s1)
    b->dev = ~0;
    80023450:	0144a423          	sw	s4,8(s1)
    b->next = bcache.head.next;
    80023454:	6b893783          	ld	a5,1720(s2)
    80023458:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    8002345a:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8002345e:	85d6                	mv	a1,s5
    80023460:	01048513          	addi	a0,s1,16
    80023464:	00000097          	auipc	ra,0x0
    80023468:	280080e7          	jalr	640(ra) # 800236e4 <initsleeplock>
    bcache.head.next->prev = b;
    8002346c:	6b893783          	ld	a5,1720(s2)
    80023470:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80023472:	6a993c23          	sd	s1,1720(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80023476:	25848493          	addi	s1,s1,600
    8002347a:	fd3497e3          	bne	s1,s3,80023448 <binit+0x58>
  }
  #ifdef DEBUG
  printf("binit\n");
  #endif
}
    8002347e:	70e2                	ld	ra,56(sp)
    80023480:	7442                	ld	s0,48(sp)
    80023482:	74a2                	ld	s1,40(sp)
    80023484:	7902                	ld	s2,32(sp)
    80023486:	69e2                	ld	s3,24(sp)
    80023488:	6a42                	ld	s4,16(sp)
    8002348a:	6aa2                	ld	s5,8(sp)
    8002348c:	6121                	addi	sp,sp,64
    8002348e:	8082                	ret

0000000080023490 <bread>:
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf* 
bread(uint dev, uint sectorno) {
    80023490:	7179                	addi	sp,sp,-48
    80023492:	f406                	sd	ra,40(sp)
    80023494:	f022                	sd	s0,32(sp)
    80023496:	ec26                	sd	s1,24(sp)
    80023498:	e84a                	sd	s2,16(sp)
    8002349a:	e44e                	sd	s3,8(sp)
    8002349c:	1800                	addi	s0,sp,48
    8002349e:	89aa                	mv	s3,a0
    800234a0:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    800234a2:	00017517          	auipc	a0,0x17
    800234a6:	64e50513          	addi	a0,a0,1614 # 8003aaf0 <bcache>
    800234aa:	ffffd097          	auipc	ra,0xffffd
    800234ae:	216080e7          	jalr	534(ra) # 800206c0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800234b2:	0001b797          	auipc	a5,0x1b
    800234b6:	63e78793          	addi	a5,a5,1598 # 8003eaf0 <bcache+0x4000>
    800234ba:	6b87b483          	ld	s1,1720(a5)
    800234be:	0001c797          	auipc	a5,0x1c
    800234c2:	c9a78793          	addi	a5,a5,-870 # 8003f158 <bcache+0x4668>
    800234c6:	02f48f63          	beq	s1,a5,80023504 <bread+0x74>
    800234ca:	873e                	mv	a4,a5
    800234cc:	a021                	j	800234d4 <bread+0x44>
    800234ce:	68a4                	ld	s1,80(s1)
    800234d0:	02e48a63          	beq	s1,a4,80023504 <bread+0x74>
    if(b->dev == dev && b->sectorno == sectorno){
    800234d4:	449c                	lw	a5,8(s1)
    800234d6:	ff379ce3          	bne	a5,s3,800234ce <bread+0x3e>
    800234da:	44dc                	lw	a5,12(s1)
    800234dc:	ff2799e3          	bne	a5,s2,800234ce <bread+0x3e>
      b->refcnt++;
    800234e0:	40bc                	lw	a5,64(s1)
    800234e2:	2785                	addiw	a5,a5,1
    800234e4:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800234e6:	00017517          	auipc	a0,0x17
    800234ea:	60a50513          	addi	a0,a0,1546 # 8003aaf0 <bcache>
    800234ee:	ffffd097          	auipc	ra,0xffffd
    800234f2:	226080e7          	jalr	550(ra) # 80020714 <release>
      acquiresleep(&b->lock);
    800234f6:	01048513          	addi	a0,s1,16
    800234fa:	00000097          	auipc	ra,0x0
    800234fe:	224080e7          	jalr	548(ra) # 8002371e <acquiresleep>
      return b;
    80023502:	a8b1                	j	8002355e <bread+0xce>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80023504:	0001b797          	auipc	a5,0x1b
    80023508:	5ec78793          	addi	a5,a5,1516 # 8003eaf0 <bcache+0x4000>
    8002350c:	6b07b483          	ld	s1,1712(a5)
    80023510:	0001c797          	auipc	a5,0x1c
    80023514:	c4878793          	addi	a5,a5,-952 # 8003f158 <bcache+0x4668>
    80023518:	04f48d63          	beq	s1,a5,80023572 <bread+0xe2>
    if(b->refcnt == 0) {
    8002351c:	40bc                	lw	a5,64(s1)
    8002351e:	cb91                	beqz	a5,80023532 <bread+0xa2>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80023520:	0001c717          	auipc	a4,0x1c
    80023524:	c3870713          	addi	a4,a4,-968 # 8003f158 <bcache+0x4668>
    80023528:	64a4                	ld	s1,72(s1)
    8002352a:	04e48463          	beq	s1,a4,80023572 <bread+0xe2>
    if(b->refcnt == 0) {
    8002352e:	40bc                	lw	a5,64(s1)
    80023530:	ffe5                	bnez	a5,80023528 <bread+0x98>
      b->dev = dev;
    80023532:	0134a423          	sw	s3,8(s1)
      b->sectorno = sectorno;
    80023536:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    8002353a:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    8002353e:	4785                	li	a5,1
    80023540:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80023542:	00017517          	auipc	a0,0x17
    80023546:	5ae50513          	addi	a0,a0,1454 # 8003aaf0 <bcache>
    8002354a:	ffffd097          	auipc	ra,0xffffd
    8002354e:	1ca080e7          	jalr	458(ra) # 80020714 <release>
      acquiresleep(&b->lock);
    80023552:	01048513          	addi	a0,s1,16
    80023556:	00000097          	auipc	ra,0x0
    8002355a:	1c8080e7          	jalr	456(ra) # 8002371e <acquiresleep>
  struct buf *b;

  b = bget(dev, sectorno);
  if (!b->valid) {
    8002355e:	409c                	lw	a5,0(s1)
    80023560:	c38d                	beqz	a5,80023582 <bread+0xf2>
    disk_read(b);
    b->valid = 1;
  }

  return b;
}
    80023562:	8526                	mv	a0,s1
    80023564:	70a2                	ld	ra,40(sp)
    80023566:	7402                	ld	s0,32(sp)
    80023568:	64e2                	ld	s1,24(sp)
    8002356a:	6942                	ld	s2,16(sp)
    8002356c:	69a2                	ld	s3,8(sp)
    8002356e:	6145                	addi	sp,sp,48
    80023570:	8082                	ret
  panic("bget: no buffers");
    80023572:	00009517          	auipc	a0,0x9
    80023576:	d6650513          	addi	a0,a0,-666 # 8002c2d8 <syscalls+0x970>
    8002357a:	ffffd097          	auipc	ra,0xffffd
    8002357e:	bcc080e7          	jalr	-1076(ra) # 80020146 <panic>
    disk_read(b);
    80023582:	8526                	mv	a0,s1
    80023584:	00002097          	auipc	ra,0x2
    80023588:	bce080e7          	jalr	-1074(ra) # 80025152 <disk_read>
    b->valid = 1;
    8002358c:	4785                	li	a5,1
    8002358e:	c09c                	sw	a5,0(s1)
  return b;
    80023590:	bfc9                	j	80023562 <bread+0xd2>

0000000080023592 <bwrite>:

// Write b's contents to disk.  Must be locked.
void 
bwrite(struct buf *b) {
    80023592:	1101                	addi	sp,sp,-32
    80023594:	ec06                	sd	ra,24(sp)
    80023596:	e822                	sd	s0,16(sp)
    80023598:	e426                	sd	s1,8(sp)
    8002359a:	1000                	addi	s0,sp,32
    8002359c:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8002359e:	0541                	addi	a0,a0,16
    800235a0:	00000097          	auipc	ra,0x0
    800235a4:	218080e7          	jalr	536(ra) # 800237b8 <holdingsleep>
    800235a8:	c919                	beqz	a0,800235be <bwrite+0x2c>
    panic("bwrite");
  disk_write(b);
    800235aa:	8526                	mv	a0,s1
    800235ac:	00002097          	auipc	ra,0x2
    800235b0:	bc4080e7          	jalr	-1084(ra) # 80025170 <disk_write>
}
    800235b4:	60e2                	ld	ra,24(sp)
    800235b6:	6442                	ld	s0,16(sp)
    800235b8:	64a2                	ld	s1,8(sp)
    800235ba:	6105                	addi	sp,sp,32
    800235bc:	8082                	ret
    panic("bwrite");
    800235be:	00009517          	auipc	a0,0x9
    800235c2:	d3250513          	addi	a0,a0,-718 # 8002c2f0 <syscalls+0x988>
    800235c6:	ffffd097          	auipc	ra,0xffffd
    800235ca:	b80080e7          	jalr	-1152(ra) # 80020146 <panic>

00000000800235ce <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800235ce:	1101                	addi	sp,sp,-32
    800235d0:	ec06                	sd	ra,24(sp)
    800235d2:	e822                	sd	s0,16(sp)
    800235d4:	e426                	sd	s1,8(sp)
    800235d6:	e04a                	sd	s2,0(sp)
    800235d8:	1000                	addi	s0,sp,32
    800235da:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800235dc:	01050913          	addi	s2,a0,16
    800235e0:	854a                	mv	a0,s2
    800235e2:	00000097          	auipc	ra,0x0
    800235e6:	1d6080e7          	jalr	470(ra) # 800237b8 <holdingsleep>
    800235ea:	c92d                	beqz	a0,8002365c <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    800235ec:	854a                	mv	a0,s2
    800235ee:	00000097          	auipc	ra,0x0
    800235f2:	186080e7          	jalr	390(ra) # 80023774 <releasesleep>

  acquire(&bcache.lock);
    800235f6:	00017517          	auipc	a0,0x17
    800235fa:	4fa50513          	addi	a0,a0,1274 # 8003aaf0 <bcache>
    800235fe:	ffffd097          	auipc	ra,0xffffd
    80023602:	0c2080e7          	jalr	194(ra) # 800206c0 <acquire>
  b->refcnt--;
    80023606:	40bc                	lw	a5,64(s1)
    80023608:	37fd                	addiw	a5,a5,-1
    8002360a:	0007871b          	sext.w	a4,a5
    8002360e:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80023610:	eb05                	bnez	a4,80023640 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80023612:	68bc                	ld	a5,80(s1)
    80023614:	64b8                	ld	a4,72(s1)
    80023616:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80023618:	64bc                	ld	a5,72(s1)
    8002361a:	68b8                	ld	a4,80(s1)
    8002361c:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8002361e:	0001b797          	auipc	a5,0x1b
    80023622:	4d278793          	addi	a5,a5,1234 # 8003eaf0 <bcache+0x4000>
    80023626:	6b87b703          	ld	a4,1720(a5)
    8002362a:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    8002362c:	0001c717          	auipc	a4,0x1c
    80023630:	b2c70713          	addi	a4,a4,-1236 # 8003f158 <bcache+0x4668>
    80023634:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80023636:	6b87b703          	ld	a4,1720(a5)
    8002363a:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    8002363c:	6a97bc23          	sd	s1,1720(a5)
  }
  
  release(&bcache.lock);
    80023640:	00017517          	auipc	a0,0x17
    80023644:	4b050513          	addi	a0,a0,1200 # 8003aaf0 <bcache>
    80023648:	ffffd097          	auipc	ra,0xffffd
    8002364c:	0cc080e7          	jalr	204(ra) # 80020714 <release>
}
    80023650:	60e2                	ld	ra,24(sp)
    80023652:	6442                	ld	s0,16(sp)
    80023654:	64a2                	ld	s1,8(sp)
    80023656:	6902                	ld	s2,0(sp)
    80023658:	6105                	addi	sp,sp,32
    8002365a:	8082                	ret
    panic("brelse");
    8002365c:	00009517          	auipc	a0,0x9
    80023660:	c9c50513          	addi	a0,a0,-868 # 8002c2f8 <syscalls+0x990>
    80023664:	ffffd097          	auipc	ra,0xffffd
    80023668:	ae2080e7          	jalr	-1310(ra) # 80020146 <panic>

000000008002366c <bpin>:

void
bpin(struct buf *b) {
    8002366c:	1101                	addi	sp,sp,-32
    8002366e:	ec06                	sd	ra,24(sp)
    80023670:	e822                	sd	s0,16(sp)
    80023672:	e426                	sd	s1,8(sp)
    80023674:	1000                	addi	s0,sp,32
    80023676:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80023678:	00017517          	auipc	a0,0x17
    8002367c:	47850513          	addi	a0,a0,1144 # 8003aaf0 <bcache>
    80023680:	ffffd097          	auipc	ra,0xffffd
    80023684:	040080e7          	jalr	64(ra) # 800206c0 <acquire>
  b->refcnt++;
    80023688:	40bc                	lw	a5,64(s1)
    8002368a:	2785                	addiw	a5,a5,1
    8002368c:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8002368e:	00017517          	auipc	a0,0x17
    80023692:	46250513          	addi	a0,a0,1122 # 8003aaf0 <bcache>
    80023696:	ffffd097          	auipc	ra,0xffffd
    8002369a:	07e080e7          	jalr	126(ra) # 80020714 <release>
}
    8002369e:	60e2                	ld	ra,24(sp)
    800236a0:	6442                	ld	s0,16(sp)
    800236a2:	64a2                	ld	s1,8(sp)
    800236a4:	6105                	addi	sp,sp,32
    800236a6:	8082                	ret

00000000800236a8 <bunpin>:

void
bunpin(struct buf *b) {
    800236a8:	1101                	addi	sp,sp,-32
    800236aa:	ec06                	sd	ra,24(sp)
    800236ac:	e822                	sd	s0,16(sp)
    800236ae:	e426                	sd	s1,8(sp)
    800236b0:	1000                	addi	s0,sp,32
    800236b2:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800236b4:	00017517          	auipc	a0,0x17
    800236b8:	43c50513          	addi	a0,a0,1084 # 8003aaf0 <bcache>
    800236bc:	ffffd097          	auipc	ra,0xffffd
    800236c0:	004080e7          	jalr	4(ra) # 800206c0 <acquire>
  b->refcnt--;
    800236c4:	40bc                	lw	a5,64(s1)
    800236c6:	37fd                	addiw	a5,a5,-1
    800236c8:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800236ca:	00017517          	auipc	a0,0x17
    800236ce:	42650513          	addi	a0,a0,1062 # 8003aaf0 <bcache>
    800236d2:	ffffd097          	auipc	ra,0xffffd
    800236d6:	042080e7          	jalr	66(ra) # 80020714 <release>
}
    800236da:	60e2                	ld	ra,24(sp)
    800236dc:	6442                	ld	s0,16(sp)
    800236de:	64a2                	ld	s1,8(sp)
    800236e0:	6105                	addi	sp,sp,32
    800236e2:	8082                	ret

00000000800236e4 <initsleeplock>:
#include "include/proc.h"
#include "include/sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800236e4:	1101                	addi	sp,sp,-32
    800236e6:	ec06                	sd	ra,24(sp)
    800236e8:	e822                	sd	s0,16(sp)
    800236ea:	e426                	sd	s1,8(sp)
    800236ec:	e04a                	sd	s2,0(sp)
    800236ee:	1000                	addi	s0,sp,32
    800236f0:	84aa                	mv	s1,a0
    800236f2:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800236f4:	00009597          	auipc	a1,0x9
    800236f8:	c0c58593          	addi	a1,a1,-1012 # 8002c300 <syscalls+0x998>
    800236fc:	0521                	addi	a0,a0,8
    800236fe:	ffffd097          	auipc	ra,0xffffd
    80023702:	f7e080e7          	jalr	-130(ra) # 8002067c <initlock>
  lk->name = name;
    80023706:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8002370a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8002370e:	0204a423          	sw	zero,40(s1)
}
    80023712:	60e2                	ld	ra,24(sp)
    80023714:	6442                	ld	s0,16(sp)
    80023716:	64a2                	ld	s1,8(sp)
    80023718:	6902                	ld	s2,0(sp)
    8002371a:	6105                	addi	sp,sp,32
    8002371c:	8082                	ret

000000008002371e <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8002371e:	1101                	addi	sp,sp,-32
    80023720:	ec06                	sd	ra,24(sp)
    80023722:	e822                	sd	s0,16(sp)
    80023724:	e426                	sd	s1,8(sp)
    80023726:	e04a                	sd	s2,0(sp)
    80023728:	1000                	addi	s0,sp,32
    8002372a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8002372c:	00850913          	addi	s2,a0,8
    80023730:	854a                	mv	a0,s2
    80023732:	ffffd097          	auipc	ra,0xffffd
    80023736:	f8e080e7          	jalr	-114(ra) # 800206c0 <acquire>
  while (lk->locked) {
    8002373a:	409c                	lw	a5,0(s1)
    8002373c:	cb89                	beqz	a5,8002374e <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    8002373e:	85ca                	mv	a1,s2
    80023740:	8526                	mv	a0,s1
    80023742:	fffff097          	auipc	ra,0xfffff
    80023746:	c92080e7          	jalr	-878(ra) # 800223d4 <sleep>
  while (lk->locked) {
    8002374a:	409c                	lw	a5,0(s1)
    8002374c:	fbed                	bnez	a5,8002373e <acquiresleep+0x20>
  }
  lk->locked = 1;
    8002374e:	4785                	li	a5,1
    80023750:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80023752:	ffffe097          	auipc	ra,0xffffe
    80023756:	400080e7          	jalr	1024(ra) # 80021b52 <myproc>
    8002375a:	5d1c                	lw	a5,56(a0)
    8002375c:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8002375e:	854a                	mv	a0,s2
    80023760:	ffffd097          	auipc	ra,0xffffd
    80023764:	fb4080e7          	jalr	-76(ra) # 80020714 <release>
}
    80023768:	60e2                	ld	ra,24(sp)
    8002376a:	6442                	ld	s0,16(sp)
    8002376c:	64a2                	ld	s1,8(sp)
    8002376e:	6902                	ld	s2,0(sp)
    80023770:	6105                	addi	sp,sp,32
    80023772:	8082                	ret

0000000080023774 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80023774:	1101                	addi	sp,sp,-32
    80023776:	ec06                	sd	ra,24(sp)
    80023778:	e822                	sd	s0,16(sp)
    8002377a:	e426                	sd	s1,8(sp)
    8002377c:	e04a                	sd	s2,0(sp)
    8002377e:	1000                	addi	s0,sp,32
    80023780:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80023782:	00850913          	addi	s2,a0,8
    80023786:	854a                	mv	a0,s2
    80023788:	ffffd097          	auipc	ra,0xffffd
    8002378c:	f38080e7          	jalr	-200(ra) # 800206c0 <acquire>
  lk->locked = 0;
    80023790:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80023794:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80023798:	8526                	mv	a0,s1
    8002379a:	fffff097          	auipc	ra,0xfffff
    8002379e:	dbc080e7          	jalr	-580(ra) # 80022556 <wakeup>
  release(&lk->lk);
    800237a2:	854a                	mv	a0,s2
    800237a4:	ffffd097          	auipc	ra,0xffffd
    800237a8:	f70080e7          	jalr	-144(ra) # 80020714 <release>
}
    800237ac:	60e2                	ld	ra,24(sp)
    800237ae:	6442                	ld	s0,16(sp)
    800237b0:	64a2                	ld	s1,8(sp)
    800237b2:	6902                	ld	s2,0(sp)
    800237b4:	6105                	addi	sp,sp,32
    800237b6:	8082                	ret

00000000800237b8 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800237b8:	7179                	addi	sp,sp,-48
    800237ba:	f406                	sd	ra,40(sp)
    800237bc:	f022                	sd	s0,32(sp)
    800237be:	ec26                	sd	s1,24(sp)
    800237c0:	e84a                	sd	s2,16(sp)
    800237c2:	e44e                	sd	s3,8(sp)
    800237c4:	1800                	addi	s0,sp,48
    800237c6:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800237c8:	00850913          	addi	s2,a0,8
    800237cc:	854a                	mv	a0,s2
    800237ce:	ffffd097          	auipc	ra,0xffffd
    800237d2:	ef2080e7          	jalr	-270(ra) # 800206c0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800237d6:	409c                	lw	a5,0(s1)
    800237d8:	ef99                	bnez	a5,800237f6 <holdingsleep+0x3e>
    800237da:	4481                	li	s1,0
  release(&lk->lk);
    800237dc:	854a                	mv	a0,s2
    800237de:	ffffd097          	auipc	ra,0xffffd
    800237e2:	f36080e7          	jalr	-202(ra) # 80020714 <release>
  return r;
}
    800237e6:	8526                	mv	a0,s1
    800237e8:	70a2                	ld	ra,40(sp)
    800237ea:	7402                	ld	s0,32(sp)
    800237ec:	64e2                	ld	s1,24(sp)
    800237ee:	6942                	ld	s2,16(sp)
    800237f0:	69a2                	ld	s3,8(sp)
    800237f2:	6145                	addi	sp,sp,48
    800237f4:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800237f6:	0284a983          	lw	s3,40(s1)
    800237fa:	ffffe097          	auipc	ra,0xffffe
    800237fe:	358080e7          	jalr	856(ra) # 80021b52 <myproc>
    80023802:	5d04                	lw	s1,56(a0)
    80023804:	413484b3          	sub	s1,s1,s3
    80023808:	0014b493          	seqz	s1,s1
    8002380c:	bfc1                	j	800237dc <holdingsleep+0x24>

000000008002380e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8002380e:	1101                	addi	sp,sp,-32
    80023810:	ec06                	sd	ra,24(sp)
    80023812:	e822                	sd	s0,16(sp)
    80023814:	e426                	sd	s1,8(sp)
    80023816:	e04a                	sd	s2,0(sp)
    80023818:	1000                	addi	s0,sp,32
  initlock(&ftable.lock, "ftable");
    8002381a:	00009597          	auipc	a1,0x9
    8002381e:	af658593          	addi	a1,a1,-1290 # 8002c310 <syscalls+0x9a8>
    80023822:	0001c517          	auipc	a0,0x1c
    80023826:	c2e50513          	addi	a0,a0,-978 # 8003f450 <ftable>
    8002382a:	ffffd097          	auipc	ra,0xffffd
    8002382e:	e52080e7          	jalr	-430(ra) # 8002067c <initlock>
  struct file *f;
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80023832:	0001c497          	auipc	s1,0x1c
    80023836:	c3648493          	addi	s1,s1,-970 # 8003f468 <ftable+0x18>
    8002383a:	0001d917          	auipc	s2,0x1d
    8002383e:	bce90913          	addi	s2,s2,-1074 # 80040408 <tickslock>
    memset(f, 0, sizeof(struct file));
    80023842:	02800613          	li	a2,40
    80023846:	4581                	li	a1,0
    80023848:	8526                	mv	a0,s1
    8002384a:	ffffd097          	auipc	ra,0xffffd
    8002384e:	f12080e7          	jalr	-238(ra) # 8002075c <memset>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80023852:	02848493          	addi	s1,s1,40
    80023856:	ff2496e3          	bne	s1,s2,80023842 <fileinit+0x34>
  }
  #ifdef DEBUG
  printf("fileinit\n");
  #endif
}
    8002385a:	60e2                	ld	ra,24(sp)
    8002385c:	6442                	ld	s0,16(sp)
    8002385e:	64a2                	ld	s1,8(sp)
    80023860:	6902                	ld	s2,0(sp)
    80023862:	6105                	addi	sp,sp,32
    80023864:	8082                	ret

0000000080023866 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80023866:	1101                	addi	sp,sp,-32
    80023868:	ec06                	sd	ra,24(sp)
    8002386a:	e822                	sd	s0,16(sp)
    8002386c:	e426                	sd	s1,8(sp)
    8002386e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80023870:	0001c517          	auipc	a0,0x1c
    80023874:	be050513          	addi	a0,a0,-1056 # 8003f450 <ftable>
    80023878:	ffffd097          	auipc	ra,0xffffd
    8002387c:	e48080e7          	jalr	-440(ra) # 800206c0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
    80023880:	0001c797          	auipc	a5,0x1c
    80023884:	bd078793          	addi	a5,a5,-1072 # 8003f450 <ftable>
    80023888:	4fdc                	lw	a5,28(a5)
    8002388a:	cb8d                	beqz	a5,800238bc <filealloc+0x56>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8002388c:	0001c497          	auipc	s1,0x1c
    80023890:	c0448493          	addi	s1,s1,-1020 # 8003f490 <ftable+0x40>
    80023894:	0001d717          	auipc	a4,0x1d
    80023898:	b7470713          	addi	a4,a4,-1164 # 80040408 <tickslock>
    if(f->ref == 0){
    8002389c:	40dc                	lw	a5,4(s1)
    8002389e:	c39d                	beqz	a5,800238c4 <filealloc+0x5e>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800238a0:	02848493          	addi	s1,s1,40
    800238a4:	fee49ce3          	bne	s1,a4,8002389c <filealloc+0x36>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800238a8:	0001c517          	auipc	a0,0x1c
    800238ac:	ba850513          	addi	a0,a0,-1112 # 8003f450 <ftable>
    800238b0:	ffffd097          	auipc	ra,0xffffd
    800238b4:	e64080e7          	jalr	-412(ra) # 80020714 <release>
  return NULL;
    800238b8:	4481                	li	s1,0
    800238ba:	a839                	j	800238d8 <filealloc+0x72>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800238bc:	0001c497          	auipc	s1,0x1c
    800238c0:	bac48493          	addi	s1,s1,-1108 # 8003f468 <ftable+0x18>
      f->ref = 1;
    800238c4:	4785                	li	a5,1
    800238c6:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800238c8:	0001c517          	auipc	a0,0x1c
    800238cc:	b8850513          	addi	a0,a0,-1144 # 8003f450 <ftable>
    800238d0:	ffffd097          	auipc	ra,0xffffd
    800238d4:	e44080e7          	jalr	-444(ra) # 80020714 <release>
}
    800238d8:	8526                	mv	a0,s1
    800238da:	60e2                	ld	ra,24(sp)
    800238dc:	6442                	ld	s0,16(sp)
    800238de:	64a2                	ld	s1,8(sp)
    800238e0:	6105                	addi	sp,sp,32
    800238e2:	8082                	ret

00000000800238e4 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800238e4:	1101                	addi	sp,sp,-32
    800238e6:	ec06                	sd	ra,24(sp)
    800238e8:	e822                	sd	s0,16(sp)
    800238ea:	e426                	sd	s1,8(sp)
    800238ec:	1000                	addi	s0,sp,32
    800238ee:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800238f0:	0001c517          	auipc	a0,0x1c
    800238f4:	b6050513          	addi	a0,a0,-1184 # 8003f450 <ftable>
    800238f8:	ffffd097          	auipc	ra,0xffffd
    800238fc:	dc8080e7          	jalr	-568(ra) # 800206c0 <acquire>
  if(f->ref < 1)
    80023900:	40dc                	lw	a5,4(s1)
    80023902:	02f05263          	blez	a5,80023926 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80023906:	2785                	addiw	a5,a5,1
    80023908:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    8002390a:	0001c517          	auipc	a0,0x1c
    8002390e:	b4650513          	addi	a0,a0,-1210 # 8003f450 <ftable>
    80023912:	ffffd097          	auipc	ra,0xffffd
    80023916:	e02080e7          	jalr	-510(ra) # 80020714 <release>
  return f;
}
    8002391a:	8526                	mv	a0,s1
    8002391c:	60e2                	ld	ra,24(sp)
    8002391e:	6442                	ld	s0,16(sp)
    80023920:	64a2                	ld	s1,8(sp)
    80023922:	6105                	addi	sp,sp,32
    80023924:	8082                	ret
    panic("filedup");
    80023926:	00009517          	auipc	a0,0x9
    8002392a:	9f250513          	addi	a0,a0,-1550 # 8002c318 <syscalls+0x9b0>
    8002392e:	ffffd097          	auipc	ra,0xffffd
    80023932:	818080e7          	jalr	-2024(ra) # 80020146 <panic>

0000000080023936 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80023936:	7139                	addi	sp,sp,-64
    80023938:	fc06                	sd	ra,56(sp)
    8002393a:	f822                	sd	s0,48(sp)
    8002393c:	f426                	sd	s1,40(sp)
    8002393e:	f04a                	sd	s2,32(sp)
    80023940:	ec4e                	sd	s3,24(sp)
    80023942:	e852                	sd	s4,16(sp)
    80023944:	e456                	sd	s5,8(sp)
    80023946:	0080                	addi	s0,sp,64
    80023948:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    8002394a:	0001c517          	auipc	a0,0x1c
    8002394e:	b0650513          	addi	a0,a0,-1274 # 8003f450 <ftable>
    80023952:	ffffd097          	auipc	ra,0xffffd
    80023956:	d6e080e7          	jalr	-658(ra) # 800206c0 <acquire>
  if(f->ref < 1)
    8002395a:	40dc                	lw	a5,4(s1)
    8002395c:	04f05863          	blez	a5,800239ac <fileclose+0x76>
    panic("fileclose");
  if(--f->ref > 0){
    80023960:	37fd                	addiw	a5,a5,-1
    80023962:	0007871b          	sext.w	a4,a5
    80023966:	c0dc                	sw	a5,4(s1)
    80023968:	04e04a63          	bgtz	a4,800239bc <fileclose+0x86>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    8002396c:	0004a903          	lw	s2,0(s1)
    80023970:	0094ca03          	lbu	s4,9(s1)
    80023974:	0104b983          	ld	s3,16(s1)
    80023978:	0184ba83          	ld	s5,24(s1)
  f->ref = 0;
    8002397c:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80023980:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80023984:	0001c517          	auipc	a0,0x1c
    80023988:	acc50513          	addi	a0,a0,-1332 # 8003f450 <ftable>
    8002398c:	ffffd097          	auipc	ra,0xffffd
    80023990:	d88080e7          	jalr	-632(ra) # 80020714 <release>

  if(ff.type == FD_PIPE){
    80023994:	4785                	li	a5,1
    80023996:	04f90463          	beq	s2,a5,800239de <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_ENTRY){
    8002399a:	4789                	li	a5,2
    8002399c:	02f91863          	bne	s2,a5,800239cc <fileclose+0x96>
    eput(ff.ep);
    800239a0:	8556                	mv	a0,s5
    800239a2:	00003097          	auipc	ra,0x3
    800239a6:	9de080e7          	jalr	-1570(ra) # 80026380 <eput>
    800239aa:	a00d                	j	800239cc <fileclose+0x96>
    panic("fileclose");
    800239ac:	00009517          	auipc	a0,0x9
    800239b0:	97450513          	addi	a0,a0,-1676 # 8002c320 <syscalls+0x9b8>
    800239b4:	ffffc097          	auipc	ra,0xffffc
    800239b8:	792080e7          	jalr	1938(ra) # 80020146 <panic>
    release(&ftable.lock);
    800239bc:	0001c517          	auipc	a0,0x1c
    800239c0:	a9450513          	addi	a0,a0,-1388 # 8003f450 <ftable>
    800239c4:	ffffd097          	auipc	ra,0xffffd
    800239c8:	d50080e7          	jalr	-688(ra) # 80020714 <release>
  } else if (ff.type == FD_DEVICE) {

  }
}
    800239cc:	70e2                	ld	ra,56(sp)
    800239ce:	7442                	ld	s0,48(sp)
    800239d0:	74a2                	ld	s1,40(sp)
    800239d2:	7902                	ld	s2,32(sp)
    800239d4:	69e2                	ld	s3,24(sp)
    800239d6:	6a42                	ld	s4,16(sp)
    800239d8:	6aa2                	ld	s5,8(sp)
    800239da:	6121                	addi	sp,sp,64
    800239dc:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800239de:	85d2                	mv	a1,s4
    800239e0:	854e                	mv	a0,s3
    800239e2:	00000097          	auipc	ra,0x0
    800239e6:	396080e7          	jalr	918(ra) # 80023d78 <pipeclose>
    800239ea:	b7cd                	j	800239cc <fileclose+0x96>

00000000800239ec <filestat>:
filestat(struct file *f, uint64 addr)
{
  // struct proc *p = myproc();
  struct stat st;
  
  if(f->type == FD_ENTRY){
    800239ec:	4118                	lw	a4,0(a0)
    800239ee:	4789                	li	a5,2
    800239f0:	04f71c63          	bne	a4,a5,80023a48 <filestat+0x5c>
{
    800239f4:	711d                	addi	sp,sp,-96
    800239f6:	ec86                	sd	ra,88(sp)
    800239f8:	e8a2                	sd	s0,80(sp)
    800239fa:	e4a6                	sd	s1,72(sp)
    800239fc:	e0ca                	sd	s2,64(sp)
    800239fe:	1080                	addi	s0,sp,96
    80023a00:	892e                	mv	s2,a1
    80023a02:	84aa                	mv	s1,a0
    elock(f->ep);
    80023a04:	6d08                	ld	a0,24(a0)
    80023a06:	00003097          	auipc	ra,0x3
    80023a0a:	8f6080e7          	jalr	-1802(ra) # 800262fc <elock>
    estat(f->ep, &st);
    80023a0e:	fa840593          	addi	a1,s0,-88
    80023a12:	6c88                	ld	a0,24(s1)
    80023a14:	00003097          	auipc	ra,0x3
    80023a18:	aa4080e7          	jalr	-1372(ra) # 800264b8 <estat>
    eunlock(f->ep);
    80023a1c:	6c88                	ld	a0,24(s1)
    80023a1e:	00003097          	auipc	ra,0x3
    80023a22:	914080e7          	jalr	-1772(ra) # 80026332 <eunlock>
    // if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    80023a26:	03800613          	li	a2,56
    80023a2a:	fa840593          	addi	a1,s0,-88
    80023a2e:	854a                	mv	a0,s2
    80023a30:	ffffe097          	auipc	ra,0xffffe
    80023a34:	a28080e7          	jalr	-1496(ra) # 80021458 <copyout2>
    80023a38:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80023a3c:	60e6                	ld	ra,88(sp)
    80023a3e:	6446                	ld	s0,80(sp)
    80023a40:	64a6                	ld	s1,72(sp)
    80023a42:	6906                	ld	s2,64(sp)
    80023a44:	6125                	addi	sp,sp,96
    80023a46:	8082                	ret
  return -1;
    80023a48:	557d                	li	a0,-1
}
    80023a4a:	8082                	ret

0000000080023a4c <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80023a4c:	7179                	addi	sp,sp,-48
    80023a4e:	f406                	sd	ra,40(sp)
    80023a50:	f022                	sd	s0,32(sp)
    80023a52:	ec26                	sd	s1,24(sp)
    80023a54:	e84a                	sd	s2,16(sp)
    80023a56:	e44e                	sd	s3,8(sp)
    80023a58:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80023a5a:	00854783          	lbu	a5,8(a0)
    80023a5e:	c3d5                	beqz	a5,80023b02 <fileread+0xb6>
    80023a60:	89b2                	mv	s3,a2
    80023a62:	892e                	mv	s2,a1
    80023a64:	84aa                	mv	s1,a0
    return -1;

  switch (f->type) {
    80023a66:	411c                	lw	a5,0(a0)
    80023a68:	4709                	li	a4,2
    80023a6a:	06e78263          	beq	a5,a4,80023ace <fileread+0x82>
    80023a6e:	470d                	li	a4,3
    80023a70:	02e78b63          	beq	a5,a4,80023aa6 <fileread+0x5a>
    80023a74:	4705                	li	a4,1
    80023a76:	00e78a63          	beq	a5,a4,80023a8a <fileread+0x3e>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
            f->off += r;
        eunlock(f->ep);
        break;
    default:
      panic("fileread");
    80023a7a:	00009517          	auipc	a0,0x9
    80023a7e:	8b650513          	addi	a0,a0,-1866 # 8002c330 <syscalls+0x9c8>
    80023a82:	ffffc097          	auipc	ra,0xffffc
    80023a86:	6c4080e7          	jalr	1732(ra) # 80020146 <panic>
        r = piperead(f->pipe, addr, n);
    80023a8a:	6908                	ld	a0,16(a0)
    80023a8c:	00000097          	auipc	ra,0x0
    80023a90:	488080e7          	jalr	1160(ra) # 80023f14 <piperead>
    80023a94:	892a                	mv	s2,a0
  }

  return r;
}
    80023a96:	854a                	mv	a0,s2
    80023a98:	70a2                	ld	ra,40(sp)
    80023a9a:	7402                	ld	s0,32(sp)
    80023a9c:	64e2                	ld	s1,24(sp)
    80023a9e:	6942                	ld	s2,16(sp)
    80023aa0:	69a2                	ld	s3,8(sp)
    80023aa2:	6145                	addi	sp,sp,48
    80023aa4:	8082                	ret
        if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80023aa6:	02451783          	lh	a5,36(a0)
    80023aaa:	03079693          	slli	a3,a5,0x30
    80023aae:	92c1                	srli	a3,a3,0x30
    80023ab0:	4725                	li	a4,9
    80023ab2:	04d76a63          	bltu	a4,a3,80023b06 <fileread+0xba>
    80023ab6:	0792                	slli	a5,a5,0x4
    80023ab8:	0001c717          	auipc	a4,0x1c
    80023abc:	8f870713          	addi	a4,a4,-1800 # 8003f3b0 <devsw>
    80023ac0:	97ba                	add	a5,a5,a4
    80023ac2:	639c                	ld	a5,0(a5)
    80023ac4:	c3b9                	beqz	a5,80023b0a <fileread+0xbe>
        r = devsw[f->major].read(1, addr, n);
    80023ac6:	4505                	li	a0,1
    80023ac8:	9782                	jalr	a5
    80023aca:	892a                	mv	s2,a0
        break;
    80023acc:	b7e9                	j	80023a96 <fileread+0x4a>
        elock(f->ep);
    80023ace:	6d08                	ld	a0,24(a0)
    80023ad0:	00003097          	auipc	ra,0x3
    80023ad4:	82c080e7          	jalr	-2004(ra) # 800262fc <elock>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
    80023ad8:	874e                	mv	a4,s3
    80023ada:	5094                	lw	a3,32(s1)
    80023adc:	864a                	mv	a2,s2
    80023ade:	4585                	li	a1,1
    80023ae0:	6c88                	ld	a0,24(s1)
    80023ae2:	00002097          	auipc	ra,0x2
    80023ae6:	f4c080e7          	jalr	-180(ra) # 80025a2e <eread>
    80023aea:	892a                	mv	s2,a0
    80023aec:	00a05563          	blez	a0,80023af6 <fileread+0xaa>
            f->off += r;
    80023af0:	509c                	lw	a5,32(s1)
    80023af2:	9fa9                	addw	a5,a5,a0
    80023af4:	d09c                	sw	a5,32(s1)
        eunlock(f->ep);
    80023af6:	6c88                	ld	a0,24(s1)
    80023af8:	00003097          	auipc	ra,0x3
    80023afc:	83a080e7          	jalr	-1990(ra) # 80026332 <eunlock>
        break;
    80023b00:	bf59                	j	80023a96 <fileread+0x4a>
    return -1;
    80023b02:	597d                	li	s2,-1
    80023b04:	bf49                	j	80023a96 <fileread+0x4a>
          return -1;
    80023b06:	597d                	li	s2,-1
    80023b08:	b779                	j	80023a96 <fileread+0x4a>
    80023b0a:	597d                	li	s2,-1
    80023b0c:	b769                	j	80023a96 <fileread+0x4a>

0000000080023b0e <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80023b0e:	7179                	addi	sp,sp,-48
    80023b10:	f406                	sd	ra,40(sp)
    80023b12:	f022                	sd	s0,32(sp)
    80023b14:	ec26                	sd	s1,24(sp)
    80023b16:	e84a                	sd	s2,16(sp)
    80023b18:	e44e                	sd	s3,8(sp)
    80023b1a:	e052                	sd	s4,0(sp)
    80023b1c:	1800                	addi	s0,sp,48
  int ret = 0;

  if(f->writable == 0)
    80023b1e:	00954783          	lbu	a5,9(a0)
    80023b22:	cbcd                	beqz	a5,80023bd4 <filewrite+0xc6>
    80023b24:	8932                	mv	s2,a2
    80023b26:	89ae                	mv	s3,a1
    80023b28:	84aa                	mv	s1,a0
    return -1;

  if(f->type == FD_PIPE){
    80023b2a:	411c                	lw	a5,0(a0)
    80023b2c:	4705                	li	a4,1
    80023b2e:	04e78963          	beq	a5,a4,80023b80 <filewrite+0x72>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80023b32:	470d                	li	a4,3
    80023b34:	04e78d63          	beq	a5,a4,80023b8e <filewrite+0x80>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_ENTRY){
    80023b38:	4709                	li	a4,2
    80023b3a:	08e79563          	bne	a5,a4,80023bc4 <filewrite+0xb6>
    elock(f->ep);
    80023b3e:	6d08                	ld	a0,24(a0)
    80023b40:	00002097          	auipc	ra,0x2
    80023b44:	7bc080e7          	jalr	1980(ra) # 800262fc <elock>
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    80023b48:	00090a1b          	sext.w	s4,s2
    80023b4c:	8752                	mv	a4,s4
    80023b4e:	5094                	lw	a3,32(s1)
    80023b50:	864e                	mv	a2,s3
    80023b52:	4585                	li	a1,1
    80023b54:	6c88                	ld	a0,24(s1)
    80023b56:	00002097          	auipc	ra,0x2
    80023b5a:	fd0080e7          	jalr	-48(ra) # 80025b26 <ewrite>
      ret = n;
      f->off += n;
    } else {
      ret = -1;
    80023b5e:	59fd                	li	s3,-1
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    80023b60:	05250b63          	beq	a0,s2,80023bb6 <filewrite+0xa8>
    }
    eunlock(f->ep);
    80023b64:	6c88                	ld	a0,24(s1)
    80023b66:	00002097          	auipc	ra,0x2
    80023b6a:	7cc080e7          	jalr	1996(ra) # 80026332 <eunlock>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80023b6e:	854e                	mv	a0,s3
    80023b70:	70a2                	ld	ra,40(sp)
    80023b72:	7402                	ld	s0,32(sp)
    80023b74:	64e2                	ld	s1,24(sp)
    80023b76:	6942                	ld	s2,16(sp)
    80023b78:	69a2                	ld	s3,8(sp)
    80023b7a:	6a02                	ld	s4,0(sp)
    80023b7c:	6145                	addi	sp,sp,48
    80023b7e:	8082                	ret
    ret = pipewrite(f->pipe, addr, n);
    80023b80:	6908                	ld	a0,16(a0)
    80023b82:	00000097          	auipc	ra,0x0
    80023b86:	266080e7          	jalr	614(ra) # 80023de8 <pipewrite>
    80023b8a:	89aa                	mv	s3,a0
    80023b8c:	b7cd                	j	80023b6e <filewrite+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80023b8e:	02451783          	lh	a5,36(a0)
    80023b92:	03079693          	slli	a3,a5,0x30
    80023b96:	92c1                	srli	a3,a3,0x30
    80023b98:	4725                	li	a4,9
    80023b9a:	02d76f63          	bltu	a4,a3,80023bd8 <filewrite+0xca>
    80023b9e:	0792                	slli	a5,a5,0x4
    80023ba0:	0001c717          	auipc	a4,0x1c
    80023ba4:	81070713          	addi	a4,a4,-2032 # 8003f3b0 <devsw>
    80023ba8:	97ba                	add	a5,a5,a4
    80023baa:	679c                	ld	a5,8(a5)
    80023bac:	cb85                	beqz	a5,80023bdc <filewrite+0xce>
    ret = devsw[f->major].write(1, addr, n);
    80023bae:	4505                	li	a0,1
    80023bb0:	9782                	jalr	a5
    80023bb2:	89aa                	mv	s3,a0
    80023bb4:	bf6d                	j	80023b6e <filewrite+0x60>
      f->off += n;
    80023bb6:	509c                	lw	a5,32(s1)
    80023bb8:	01478a3b          	addw	s4,a5,s4
    80023bbc:	0344a023          	sw	s4,32(s1)
      ret = n;
    80023bc0:	89ca                	mv	s3,s2
    80023bc2:	b74d                	j	80023b64 <filewrite+0x56>
    panic("filewrite");
    80023bc4:	00008517          	auipc	a0,0x8
    80023bc8:	77c50513          	addi	a0,a0,1916 # 8002c340 <syscalls+0x9d8>
    80023bcc:	ffffc097          	auipc	ra,0xffffc
    80023bd0:	57a080e7          	jalr	1402(ra) # 80020146 <panic>
    return -1;
    80023bd4:	59fd                	li	s3,-1
    80023bd6:	bf61                	j	80023b6e <filewrite+0x60>
      return -1;
    80023bd8:	59fd                	li	s3,-1
    80023bda:	bf51                	j	80023b6e <filewrite+0x60>
    80023bdc:	59fd                	li	s3,-1
    80023bde:	bf41                	j	80023b6e <filewrite+0x60>

0000000080023be0 <dirnext>:
int
dirnext(struct file *f, uint64 addr)
{
  // struct proc *p = myproc();

  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    80023be0:	00854783          	lbu	a5,8(a0)
    80023be4:	cbd5                	beqz	a5,80023c98 <dirnext+0xb8>
    80023be6:	6d14                	ld	a3,24(a0)
    80023be8:	1006c703          	lbu	a4,256(a3)
    80023bec:	8b41                	andi	a4,a4,16
    return -1;
    80023bee:	57fd                	li	a5,-1
  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    80023bf0:	c74d                	beqz	a4,80023c9a <dirnext+0xba>
{
    80023bf2:	7105                	addi	sp,sp,-480
    80023bf4:	ef86                	sd	ra,472(sp)
    80023bf6:	eba2                	sd	s0,464(sp)
    80023bf8:	e7a6                	sd	s1,456(sp)
    80023bfa:	e3ca                	sd	s2,448(sp)
    80023bfc:	ff4e                	sd	s3,440(sp)
    80023bfe:	1380                	addi	s0,sp,480
    80023c00:	89ae                	mv	s3,a1
    80023c02:	84aa                	mv	s1,a0

  struct dirent de;
  struct stat st;
  int count = 0;
    80023c04:	e2042623          	sw	zero,-468(s0)
  int ret;
  elock(f->ep);
    80023c08:	8536                	mv	a0,a3
    80023c0a:	00002097          	auipc	ra,0x2
    80023c0e:	6f2080e7          	jalr	1778(ra) # 800262fc <elock>
  while ((ret = enext(f->ep, &de, f->off, &count)) == 0) {  // skip empty entry
    80023c12:	e2c40693          	addi	a3,s0,-468
    80023c16:	5090                	lw	a2,32(s1)
    80023c18:	e6840593          	addi	a1,s0,-408
    80023c1c:	6c88                	ld	a0,24(s1)
    80023c1e:	00003097          	auipc	ra,0x3
    80023c22:	8e2080e7          	jalr	-1822(ra) # 80026500 <enext>
    80023c26:	892a                	mv	s2,a0
    80023c28:	e909                	bnez	a0,80023c3a <dirnext+0x5a>
    f->off += count * 32;
    80023c2a:	e2c42783          	lw	a5,-468(s0)
    80023c2e:	0057971b          	slliw	a4,a5,0x5
    80023c32:	509c                	lw	a5,32(s1)
    80023c34:	9fb9                	addw	a5,a5,a4
    80023c36:	d09c                	sw	a5,32(s1)
    80023c38:	bfe9                	j	80023c12 <dirnext+0x32>
  }
  eunlock(f->ep);
    80023c3a:	6c88                	ld	a0,24(s1)
    80023c3c:	00002097          	auipc	ra,0x2
    80023c40:	6f6080e7          	jalr	1782(ra) # 80026332 <eunlock>
  if (ret == -1)
    80023c44:	577d                	li	a4,-1
    return 0;
    80023c46:	4781                	li	a5,0
  if (ret == -1)
    80023c48:	04e90063          	beq	s2,a4,80023c88 <dirnext+0xa8>

  f->off += count * 32;
    80023c4c:	e2c42783          	lw	a5,-468(s0)
    80023c50:	0057971b          	slliw	a4,a5,0x5
    80023c54:	509c                	lw	a5,32(s1)
    80023c56:	9fb9                	addw	a5,a5,a4
    80023c58:	d09c                	sw	a5,32(s1)
  estat(&de, &st);
    80023c5a:	e3040593          	addi	a1,s0,-464
    80023c5e:	e6840513          	addi	a0,s0,-408
    80023c62:	00003097          	auipc	ra,0x3
    80023c66:	856080e7          	jalr	-1962(ra) # 800264b8 <estat>
  // if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
  if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    80023c6a:	03800613          	li	a2,56
    80023c6e:	e3040593          	addi	a1,s0,-464
    80023c72:	854e                	mv	a0,s3
    80023c74:	ffffd097          	auipc	ra,0xffffd
    80023c78:	7e4080e7          	jalr	2020(ra) # 80021458 <copyout2>
    return -1;
    80023c7c:	fff54513          	not	a0,a0
    80023c80:	43f55793          	srai	a5,a0,0x3f
    80023c84:	8b89                	andi	a5,a5,2
    80023c86:	17fd                	addi	a5,a5,-1

  return 1;
    80023c88:	853e                	mv	a0,a5
    80023c8a:	60fe                	ld	ra,472(sp)
    80023c8c:	645e                	ld	s0,464(sp)
    80023c8e:	64be                	ld	s1,456(sp)
    80023c90:	691e                	ld	s2,448(sp)
    80023c92:	79fa                	ld	s3,440(sp)
    80023c94:	613d                	addi	sp,sp,480
    80023c96:	8082                	ret
    return -1;
    80023c98:	57fd                	li	a5,-1
    80023c9a:	853e                	mv	a0,a5
    80023c9c:	8082                	ret

0000000080023c9e <pipealloc>:
#include "include/kalloc.h"
#include "include/vm.h"

int
pipealloc(struct file **f0, struct file **f1)
{
    80023c9e:	7179                	addi	sp,sp,-48
    80023ca0:	f406                	sd	ra,40(sp)
    80023ca2:	f022                	sd	s0,32(sp)
    80023ca4:	ec26                	sd	s1,24(sp)
    80023ca6:	e84a                	sd	s2,16(sp)
    80023ca8:	e44e                	sd	s3,8(sp)
    80023caa:	e052                	sd	s4,0(sp)
    80023cac:	1800                	addi	s0,sp,48
    80023cae:	84aa                	mv	s1,a0
    80023cb0:	892e                	mv	s2,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80023cb2:	0005b023          	sd	zero,0(a1)
    80023cb6:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == NULL || (*f1 = filealloc()) == NULL)
    80023cba:	00000097          	auipc	ra,0x0
    80023cbe:	bac080e7          	jalr	-1108(ra) # 80023866 <filealloc>
    80023cc2:	e088                	sd	a0,0(s1)
    80023cc4:	c551                	beqz	a0,80023d50 <pipealloc+0xb2>
    80023cc6:	00000097          	auipc	ra,0x0
    80023cca:	ba0080e7          	jalr	-1120(ra) # 80023866 <filealloc>
    80023cce:	00a93023          	sd	a0,0(s2)
    80023cd2:	c92d                	beqz	a0,80023d44 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == NULL)
    80023cd4:	ffffd097          	auipc	ra,0xffffd
    80023cd8:	87e080e7          	jalr	-1922(ra) # 80020552 <kalloc>
    80023cdc:	89aa                	mv	s3,a0
    80023cde:	c125                	beqz	a0,80023d3e <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80023ce0:	4a05                	li	s4,1
    80023ce2:	23452023          	sw	s4,544(a0)
  pi->writeopen = 1;
    80023ce6:	23452223          	sw	s4,548(a0)
  pi->nwrite = 0;
    80023cea:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80023cee:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80023cf2:	00008597          	auipc	a1,0x8
    80023cf6:	52658593          	addi	a1,a1,1318 # 8002c218 <syscalls+0x8b0>
    80023cfa:	ffffd097          	auipc	ra,0xffffd
    80023cfe:	982080e7          	jalr	-1662(ra) # 8002067c <initlock>
  (*f0)->type = FD_PIPE;
    80023d02:	609c                	ld	a5,0(s1)
    80023d04:	0147a023          	sw	s4,0(a5)
  (*f0)->readable = 1;
    80023d08:	609c                	ld	a5,0(s1)
    80023d0a:	01478423          	sb	s4,8(a5)
  (*f0)->writable = 0;
    80023d0e:	609c                	ld	a5,0(s1)
    80023d10:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80023d14:	609c                	ld	a5,0(s1)
    80023d16:	0137b823          	sd	s3,16(a5)
  (*f1)->type = FD_PIPE;
    80023d1a:	00093783          	ld	a5,0(s2)
    80023d1e:	0147a023          	sw	s4,0(a5)
  (*f1)->readable = 0;
    80023d22:	00093783          	ld	a5,0(s2)
    80023d26:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80023d2a:	00093783          	ld	a5,0(s2)
    80023d2e:	014784a3          	sb	s4,9(a5)
  (*f1)->pipe = pi;
    80023d32:	00093783          	ld	a5,0(s2)
    80023d36:	0137b823          	sd	s3,16(a5)
  return 0;
    80023d3a:	4501                	li	a0,0
    80023d3c:	a025                	j	80023d64 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80023d3e:	6088                	ld	a0,0(s1)
    80023d40:	e501                	bnez	a0,80023d48 <pipealloc+0xaa>
    80023d42:	a039                	j	80023d50 <pipealloc+0xb2>
    80023d44:	6088                	ld	a0,0(s1)
    80023d46:	c51d                	beqz	a0,80023d74 <pipealloc+0xd6>
    fileclose(*f0);
    80023d48:	00000097          	auipc	ra,0x0
    80023d4c:	bee080e7          	jalr	-1042(ra) # 80023936 <fileclose>
  if(*f1)
    80023d50:	00093783          	ld	a5,0(s2)
    fileclose(*f1);
  return -1;
    80023d54:	557d                	li	a0,-1
  if(*f1)
    80023d56:	c799                	beqz	a5,80023d64 <pipealloc+0xc6>
    fileclose(*f1);
    80023d58:	853e                	mv	a0,a5
    80023d5a:	00000097          	auipc	ra,0x0
    80023d5e:	bdc080e7          	jalr	-1060(ra) # 80023936 <fileclose>
  return -1;
    80023d62:	557d                	li	a0,-1
}
    80023d64:	70a2                	ld	ra,40(sp)
    80023d66:	7402                	ld	s0,32(sp)
    80023d68:	64e2                	ld	s1,24(sp)
    80023d6a:	6942                	ld	s2,16(sp)
    80023d6c:	69a2                	ld	s3,8(sp)
    80023d6e:	6a02                	ld	s4,0(sp)
    80023d70:	6145                	addi	sp,sp,48
    80023d72:	8082                	ret
  return -1;
    80023d74:	557d                	li	a0,-1
    80023d76:	b7fd                	j	80023d64 <pipealloc+0xc6>

0000000080023d78 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80023d78:	1101                	addi	sp,sp,-32
    80023d7a:	ec06                	sd	ra,24(sp)
    80023d7c:	e822                	sd	s0,16(sp)
    80023d7e:	e426                	sd	s1,8(sp)
    80023d80:	e04a                	sd	s2,0(sp)
    80023d82:	1000                	addi	s0,sp,32
    80023d84:	84aa                	mv	s1,a0
    80023d86:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80023d88:	ffffd097          	auipc	ra,0xffffd
    80023d8c:	938080e7          	jalr	-1736(ra) # 800206c0 <acquire>
  if(writable){
    80023d90:	02090d63          	beqz	s2,80023dca <pipeclose+0x52>
    pi->writeopen = 0;
    80023d94:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80023d98:	21848513          	addi	a0,s1,536
    80023d9c:	ffffe097          	auipc	ra,0xffffe
    80023da0:	7ba080e7          	jalr	1978(ra) # 80022556 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80023da4:	2204b783          	ld	a5,544(s1)
    80023da8:	eb95                	bnez	a5,80023ddc <pipeclose+0x64>
    release(&pi->lock);
    80023daa:	8526                	mv	a0,s1
    80023dac:	ffffd097          	auipc	ra,0xffffd
    80023db0:	968080e7          	jalr	-1688(ra) # 80020714 <release>
    kfree((char*)pi);
    80023db4:	8526                	mv	a0,s1
    80023db6:	ffffc097          	auipc	ra,0xffffc
    80023dba:	682080e7          	jalr	1666(ra) # 80020438 <kfree>
  } else
    release(&pi->lock);
}
    80023dbe:	60e2                	ld	ra,24(sp)
    80023dc0:	6442                	ld	s0,16(sp)
    80023dc2:	64a2                	ld	s1,8(sp)
    80023dc4:	6902                	ld	s2,0(sp)
    80023dc6:	6105                	addi	sp,sp,32
    80023dc8:	8082                	ret
    pi->readopen = 0;
    80023dca:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80023dce:	21c48513          	addi	a0,s1,540
    80023dd2:	ffffe097          	auipc	ra,0xffffe
    80023dd6:	784080e7          	jalr	1924(ra) # 80022556 <wakeup>
    80023dda:	b7e9                	j	80023da4 <pipeclose+0x2c>
    release(&pi->lock);
    80023ddc:	8526                	mv	a0,s1
    80023dde:	ffffd097          	auipc	ra,0xffffd
    80023de2:	936080e7          	jalr	-1738(ra) # 80020714 <release>
}
    80023de6:	bfe1                	j	80023dbe <pipeclose+0x46>

0000000080023de8 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80023de8:	7119                	addi	sp,sp,-128
    80023dea:	fc86                	sd	ra,120(sp)
    80023dec:	f8a2                	sd	s0,112(sp)
    80023dee:	f4a6                	sd	s1,104(sp)
    80023df0:	f0ca                	sd	s2,96(sp)
    80023df2:	ecce                	sd	s3,88(sp)
    80023df4:	e8d2                	sd	s4,80(sp)
    80023df6:	e4d6                	sd	s5,72(sp)
    80023df8:	e0da                	sd	s6,64(sp)
    80023dfa:	fc5e                	sd	s7,56(sp)
    80023dfc:	f862                	sd	s8,48(sp)
    80023dfe:	f466                	sd	s9,40(sp)
    80023e00:	f06a                	sd	s10,32(sp)
    80023e02:	ec6e                	sd	s11,24(sp)
    80023e04:	0100                	addi	s0,sp,128
    80023e06:	84aa                	mv	s1,a0
    80023e08:	8d2e                	mv	s10,a1
    80023e0a:	8b32                	mv	s6,a2
  int i;
  char ch;
  struct proc *pr = myproc();
    80023e0c:	ffffe097          	auipc	ra,0xffffe
    80023e10:	d46080e7          	jalr	-698(ra) # 80021b52 <myproc>
    80023e14:	892a                	mv	s2,a0

  acquire(&pi->lock);
    80023e16:	8526                	mv	a0,s1
    80023e18:	ffffd097          	auipc	ra,0xffffd
    80023e1c:	8a8080e7          	jalr	-1880(ra) # 800206c0 <acquire>
  for(i = 0; i < n; i++){
    80023e20:	0d605d63          	blez	s6,80023efa <pipewrite+0x112>
    80023e24:	89a6                	mv	s3,s1
    80023e26:	3b7d                	addiw	s6,s6,-1
    80023e28:	1b02                	slli	s6,s6,0x20
    80023e2a:	020b5b13          	srli	s6,s6,0x20
    80023e2e:	4b81                	li	s7,0
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || pr->killed){
        release(&pi->lock);
        return -1;
      }
      wakeup(&pi->nread);
    80023e30:	21848a93          	addi	s5,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80023e34:	21c48a13          	addi	s4,s1,540
    }
    // if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    if(copyin2(&ch, addr + i, 1) == -1)
    80023e38:	5dfd                	li	s11,-1
    80023e3a:	000b8c9b          	sext.w	s9,s7
    80023e3e:	8c66                	mv	s8,s9
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023e40:	2184a783          	lw	a5,536(s1)
    80023e44:	21c4a703          	lw	a4,540(s1)
    80023e48:	2007879b          	addiw	a5,a5,512
    80023e4c:	06f71763          	bne	a4,a5,80023eba <pipewrite+0xd2>
      if(pi->readopen == 0 || pr->killed){
    80023e50:	2204a783          	lw	a5,544(s1)
    80023e54:	cf8d                	beqz	a5,80023e8e <pipewrite+0xa6>
    80023e56:	03092783          	lw	a5,48(s2)
    80023e5a:	eb95                	bnez	a5,80023e8e <pipewrite+0xa6>
      wakeup(&pi->nread);
    80023e5c:	8556                	mv	a0,s5
    80023e5e:	ffffe097          	auipc	ra,0xffffe
    80023e62:	6f8080e7          	jalr	1784(ra) # 80022556 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80023e66:	85ce                	mv	a1,s3
    80023e68:	8552                	mv	a0,s4
    80023e6a:	ffffe097          	auipc	ra,0xffffe
    80023e6e:	56a080e7          	jalr	1386(ra) # 800223d4 <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023e72:	2184a783          	lw	a5,536(s1)
    80023e76:	21c4a703          	lw	a4,540(s1)
    80023e7a:	2007879b          	addiw	a5,a5,512
    80023e7e:	02f71e63          	bne	a4,a5,80023eba <pipewrite+0xd2>
      if(pi->readopen == 0 || pr->killed){
    80023e82:	2204a783          	lw	a5,544(s1)
    80023e86:	c781                	beqz	a5,80023e8e <pipewrite+0xa6>
    80023e88:	03092783          	lw	a5,48(s2)
    80023e8c:	dbe1                	beqz	a5,80023e5c <pipewrite+0x74>
        release(&pi->lock);
    80023e8e:	8526                	mv	a0,s1
    80023e90:	ffffd097          	auipc	ra,0xffffd
    80023e94:	884080e7          	jalr	-1916(ra) # 80020714 <release>
        return -1;
    80023e98:	5c7d                	li	s8,-1
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
  }
  wakeup(&pi->nread);
  release(&pi->lock);
  return i;
}
    80023e9a:	8562                	mv	a0,s8
    80023e9c:	70e6                	ld	ra,120(sp)
    80023e9e:	7446                	ld	s0,112(sp)
    80023ea0:	74a6                	ld	s1,104(sp)
    80023ea2:	7906                	ld	s2,96(sp)
    80023ea4:	69e6                	ld	s3,88(sp)
    80023ea6:	6a46                	ld	s4,80(sp)
    80023ea8:	6aa6                	ld	s5,72(sp)
    80023eaa:	6b06                	ld	s6,64(sp)
    80023eac:	7be2                	ld	s7,56(sp)
    80023eae:	7c42                	ld	s8,48(sp)
    80023eb0:	7ca2                	ld	s9,40(sp)
    80023eb2:	7d02                	ld	s10,32(sp)
    80023eb4:	6de2                	ld	s11,24(sp)
    80023eb6:	6109                	addi	sp,sp,128
    80023eb8:	8082                	ret
    if(copyin2(&ch, addr + i, 1) == -1)
    80023eba:	4605                	li	a2,1
    80023ebc:	01ab85b3          	add	a1,s7,s10
    80023ec0:	f8f40513          	addi	a0,s0,-113
    80023ec4:	ffffd097          	auipc	ra,0xffffd
    80023ec8:	674080e7          	jalr	1652(ra) # 80021538 <copyin2>
    80023ecc:	03b50863          	beq	a0,s11,80023efc <pipewrite+0x114>
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80023ed0:	21c4a783          	lw	a5,540(s1)
    80023ed4:	0017871b          	addiw	a4,a5,1
    80023ed8:	20e4ae23          	sw	a4,540(s1)
    80023edc:	1ff7f793          	andi	a5,a5,511
    80023ee0:	97a6                	add	a5,a5,s1
    80023ee2:	f8f44703          	lbu	a4,-113(s0)
    80023ee6:	00e78c23          	sb	a4,24(a5)
    80023eea:	001c8c1b          	addiw	s8,s9,1
    80023eee:	001b8793          	addi	a5,s7,1
  for(i = 0; i < n; i++){
    80023ef2:	016b8563          	beq	s7,s6,80023efc <pipewrite+0x114>
    80023ef6:	8bbe                	mv	s7,a5
    80023ef8:	b789                	j	80023e3a <pipewrite+0x52>
    80023efa:	4c01                	li	s8,0
  wakeup(&pi->nread);
    80023efc:	21848513          	addi	a0,s1,536
    80023f00:	ffffe097          	auipc	ra,0xffffe
    80023f04:	656080e7          	jalr	1622(ra) # 80022556 <wakeup>
  release(&pi->lock);
    80023f08:	8526                	mv	a0,s1
    80023f0a:	ffffd097          	auipc	ra,0xffffd
    80023f0e:	80a080e7          	jalr	-2038(ra) # 80020714 <release>
  return i;
    80023f12:	b761                	j	80023e9a <pipewrite+0xb2>

0000000080023f14 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80023f14:	715d                	addi	sp,sp,-80
    80023f16:	e486                	sd	ra,72(sp)
    80023f18:	e0a2                	sd	s0,64(sp)
    80023f1a:	fc26                	sd	s1,56(sp)
    80023f1c:	f84a                	sd	s2,48(sp)
    80023f1e:	f44e                	sd	s3,40(sp)
    80023f20:	f052                	sd	s4,32(sp)
    80023f22:	ec56                	sd	s5,24(sp)
    80023f24:	e85a                	sd	s6,16(sp)
    80023f26:	0880                	addi	s0,sp,80
    80023f28:	84aa                	mv	s1,a0
    80023f2a:	89ae                	mv	s3,a1
    80023f2c:	8a32                	mv	s4,a2
  int i;
  struct proc *pr = myproc();
    80023f2e:	ffffe097          	auipc	ra,0xffffe
    80023f32:	c24080e7          	jalr	-988(ra) # 80021b52 <myproc>
    80023f36:	892a                	mv	s2,a0
  char ch;

  acquire(&pi->lock);
    80023f38:	8526                	mv	a0,s1
    80023f3a:	ffffc097          	auipc	ra,0xffffc
    80023f3e:	786080e7          	jalr	1926(ra) # 800206c0 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80023f42:	2184a703          	lw	a4,536(s1)
    80023f46:	21c4a783          	lw	a5,540(s1)
    80023f4a:	06f71b63          	bne	a4,a5,80023fc0 <piperead+0xac>
    80023f4e:	8aa6                	mv	s5,s1
    80023f50:	2244a783          	lw	a5,548(s1)
    80023f54:	cf9d                	beqz	a5,80023f92 <piperead+0x7e>
    if(pr->killed){
    80023f56:	03092783          	lw	a5,48(s2)
    80023f5a:	e78d                	bnez	a5,80023f84 <piperead+0x70>
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80023f5c:	21848b13          	addi	s6,s1,536
    80023f60:	85d6                	mv	a1,s5
    80023f62:	855a                	mv	a0,s6
    80023f64:	ffffe097          	auipc	ra,0xffffe
    80023f68:	470080e7          	jalr	1136(ra) # 800223d4 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80023f6c:	2184a703          	lw	a4,536(s1)
    80023f70:	21c4a783          	lw	a5,540(s1)
    80023f74:	04f71663          	bne	a4,a5,80023fc0 <piperead+0xac>
    80023f78:	2244a783          	lw	a5,548(s1)
    80023f7c:	cb99                	beqz	a5,80023f92 <piperead+0x7e>
    if(pr->killed){
    80023f7e:	03092783          	lw	a5,48(s2)
    80023f82:	dff9                	beqz	a5,80023f60 <piperead+0x4c>
      release(&pi->lock);
    80023f84:	8526                	mv	a0,s1
    80023f86:	ffffc097          	auipc	ra,0xffffc
    80023f8a:	78e080e7          	jalr	1934(ra) # 80020714 <release>
      return -1;
    80023f8e:	597d                	li	s2,-1
    80023f90:	a829                	j	80023faa <piperead+0x96>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(pi->nread == pi->nwrite)
    80023f92:	4901                	li	s2,0
    ch = pi->data[pi->nread++ % PIPESIZE];
    // if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    if(copyout2(addr + i, &ch, 1) == -1)
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80023f94:	21c48513          	addi	a0,s1,540
    80023f98:	ffffe097          	auipc	ra,0xffffe
    80023f9c:	5be080e7          	jalr	1470(ra) # 80022556 <wakeup>
  release(&pi->lock);
    80023fa0:	8526                	mv	a0,s1
    80023fa2:	ffffc097          	auipc	ra,0xffffc
    80023fa6:	772080e7          	jalr	1906(ra) # 80020714 <release>
  return i;
}
    80023faa:	854a                	mv	a0,s2
    80023fac:	60a6                	ld	ra,72(sp)
    80023fae:	6406                	ld	s0,64(sp)
    80023fb0:	74e2                	ld	s1,56(sp)
    80023fb2:	7942                	ld	s2,48(sp)
    80023fb4:	79a2                	ld	s3,40(sp)
    80023fb6:	7a02                	ld	s4,32(sp)
    80023fb8:	6ae2                	ld	s5,24(sp)
    80023fba:	6b42                	ld	s6,16(sp)
    80023fbc:	6161                	addi	sp,sp,80
    80023fbe:	8082                	ret
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80023fc0:	4901                	li	s2,0
    80023fc2:	fd4059e3          	blez	s4,80023f94 <piperead+0x80>
    if(pi->nread == pi->nwrite)
    80023fc6:	2184a783          	lw	a5,536(s1)
    80023fca:	4901                	li	s2,0
    if(copyout2(addr + i, &ch, 1) == -1)
    80023fcc:	5afd                	li	s5,-1
    ch = pi->data[pi->nread++ % PIPESIZE];
    80023fce:	0017871b          	addiw	a4,a5,1
    80023fd2:	20e4ac23          	sw	a4,536(s1)
    80023fd6:	1ff7f793          	andi	a5,a5,511
    80023fda:	97a6                	add	a5,a5,s1
    80023fdc:	0187c783          	lbu	a5,24(a5)
    80023fe0:	faf40fa3          	sb	a5,-65(s0)
    if(copyout2(addr + i, &ch, 1) == -1)
    80023fe4:	4605                	li	a2,1
    80023fe6:	fbf40593          	addi	a1,s0,-65
    80023fea:	854e                	mv	a0,s3
    80023fec:	ffffd097          	auipc	ra,0xffffd
    80023ff0:	46c080e7          	jalr	1132(ra) # 80021458 <copyout2>
    80023ff4:	fb5500e3          	beq	a0,s5,80023f94 <piperead+0x80>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80023ff8:	2905                	addiw	s2,s2,1
    80023ffa:	f92a0de3          	beq	s4,s2,80023f94 <piperead+0x80>
    if(pi->nread == pi->nwrite)
    80023ffe:	2184a783          	lw	a5,536(s1)
    80024002:	0985                	addi	s3,s3,1
    80024004:	21c4a703          	lw	a4,540(s1)
    80024008:	fcf713e3          	bne	a4,a5,80023fce <piperead+0xba>
    8002400c:	b761                	j	80023f94 <piperead+0x80>

000000008002400e <exec>:
  return 0;
}


int exec(char *path, char **argv)
{
    8002400e:	dd010113          	addi	sp,sp,-560
    80024012:	22113423          	sd	ra,552(sp)
    80024016:	22813023          	sd	s0,544(sp)
    8002401a:	20913c23          	sd	s1,536(sp)
    8002401e:	21213823          	sd	s2,528(sp)
    80024022:	21313423          	sd	s3,520(sp)
    80024026:	21413023          	sd	s4,512(sp)
    8002402a:	ffd6                	sd	s5,504(sp)
    8002402c:	fbda                	sd	s6,496(sp)
    8002402e:	f7de                	sd	s7,488(sp)
    80024030:	f3e2                	sd	s8,480(sp)
    80024032:	efe6                	sd	s9,472(sp)
    80024034:	ebea                	sd	s10,464(sp)
    80024036:	e7ee                	sd	s11,456(sp)
    80024038:	1c00                	addi	s0,sp,560
    8002403a:	892a                	mv	s2,a0
    8002403c:	dea43023          	sd	a0,-544(s0)
    80024040:	deb43423          	sd	a1,-536(s0)
  struct elfhdr elf;
  struct dirent *ep;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  pagetable_t kpagetable = 0, oldkpagetable;
  struct proc *p = myproc();
    80024044:	ffffe097          	auipc	ra,0xffffe
    80024048:	b0e080e7          	jalr	-1266(ra) # 80021b52 <myproc>
    8002404c:	84aa                	mv	s1,a0

  // Make a copy of p->kpt without old user space, 
  // but with the same kstack we are using now, which can't be changed
  if ((kpagetable = (pagetable_t)kalloc()) == NULL) {
    8002404e:	ffffc097          	auipc	ra,0xffffc
    80024052:	504080e7          	jalr	1284(ra) # 80020552 <kalloc>
    80024056:	2a050363          	beqz	a0,800242fc <exec+0x2ee>
    8002405a:	8aaa                	mv	s5,a0
    return -1;
  }
  memmove(kpagetable, p->kpagetable, PGSIZE);
    8002405c:	6605                	lui	a2,0x1
    8002405e:	6cac                	ld	a1,88(s1)
    80024060:	ffffc097          	auipc	ra,0xffffc
    80024064:	768080e7          	jalr	1896(ra) # 800207c8 <memmove>
  for (int i = 0; i < PX(2, MAXUVA); i++) {
    kpagetable[i] = 0;
    80024068:	000ab023          	sd	zero,0(s5)
    8002406c:	000ab423          	sd	zero,8(s5)
  }

  if((ep = ename(path)) == NULL) {
    80024070:	854a                	mv	a0,s2
    80024072:	00003097          	auipc	ra,0x3
    80024076:	a30080e7          	jalr	-1488(ra) # 80026aa2 <ename>
    8002407a:	8a2a                	mv	s4,a0
    8002407c:	3a050963          	beqz	a0,8002442e <exec+0x420>
    #ifdef DEBUG
    printf("[exec] %s not found\n", path);
    #endif
    goto bad;
  }
  elock(ep);
    80024080:	00002097          	auipc	ra,0x2
    80024084:	27c080e7          	jalr	636(ra) # 800262fc <elock>

  // Check ELF header
  if(eread(ep, 0, (uint64) &elf, 0, sizeof(elf)) != sizeof(elf))
    80024088:	04000713          	li	a4,64
    8002408c:	4681                	li	a3,0
    8002408e:	e4840613          	addi	a2,s0,-440
    80024092:	4581                	li	a1,0
    80024094:	8552                	mv	a0,s4
    80024096:	00002097          	auipc	ra,0x2
    8002409a:	998080e7          	jalr	-1640(ra) # 80025a2e <eread>
    8002409e:	04000793          	li	a5,64
    800240a2:	00f51a63          	bne	a0,a5,800240b6 <exec+0xa8>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    800240a6:	e4842703          	lw	a4,-440(s0)
    800240aa:	464c47b7          	lui	a5,0x464c4
    800240ae:	57f78793          	addi	a5,a5,1407 # 464c457f <BASE_ADDRESS-0x39b5ba81>
    800240b2:	00f70963          	beq	a4,a5,800240c4 <exec+0xb6>
  printf("[exec] reach bad\n");
  #endif
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(kpagetable)
    kvmfree(kpagetable, 0);
    800240b6:	4581                	li	a1,0
    800240b8:	8556                	mv	a0,s5
    800240ba:	ffffd097          	auipc	ra,0xffffd
    800240be:	6bc080e7          	jalr	1724(ra) # 80021776 <kvmfree>
  if(ep){
    800240c2:	a495                	j	80024326 <exec+0x318>
  if((pagetable = proc_pagetable(p)) == NULL)
    800240c4:	8526                	mv	a0,s1
    800240c6:	ffffe097          	auipc	ra,0xffffe
    800240ca:	b72080e7          	jalr	-1166(ra) # 80021c38 <proc_pagetable>
    800240ce:	e0a43423          	sd	a0,-504(s0)
    800240d2:	d175                	beqz	a0,800240b6 <exec+0xa8>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800240d4:	e6842783          	lw	a5,-408(s0)
    800240d8:	e8045703          	lhu	a4,-384(s0)
    800240dc:	c73d                	beqz	a4,8002414a <exec+0x13c>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    800240de:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800240e0:	e0043023          	sd	zero,-512(s0)
    if(ph.vaddr % PGSIZE != 0)
    800240e4:	6b05                	lui	s6,0x1
    800240e6:	fffb0713          	addi	a4,s6,-1 # fff <BASE_ADDRESS-0x8001f001>
    800240ea:	dce43c23          	sd	a4,-552(s0)
  for(i = 0; i < sz; i += PGSIZE){
    800240ee:	6d85                	lui	s11,0x1
    800240f0:	7d7d                	lui	s10,0xfffff
    800240f2:	a4c1                	j	800243b2 <exec+0x3a4>
      panic("loadseg: address should exist");
    800240f4:	00008517          	auipc	a0,0x8
    800240f8:	25c50513          	addi	a0,a0,604 # 8002c350 <syscalls+0x9e8>
    800240fc:	ffffc097          	auipc	ra,0xffffc
    80024100:	04a080e7          	jalr	74(ra) # 80020146 <panic>
    if(eread(ep, 0, (uint64)pa, offset+i, n) != n)
    80024104:	874e                	mv	a4,s3
    80024106:	009c86bb          	addw	a3,s9,s1
    8002410a:	4581                	li	a1,0
    8002410c:	8552                	mv	a0,s4
    8002410e:	00002097          	auipc	ra,0x2
    80024112:	920080e7          	jalr	-1760(ra) # 80025a2e <eread>
    80024116:	2501                	sext.w	a0,a0
    80024118:	1ea99663          	bne	s3,a0,80024304 <exec+0x2f6>
  for(i = 0; i < sz; i += PGSIZE){
    8002411c:	009d84bb          	addw	s1,s11,s1
    80024120:	012d093b          	addw	s2,s10,s2
    80024124:	2774f763          	bgeu	s1,s7,80024392 <exec+0x384>
    pa = walkaddr(pagetable, va + i);
    80024128:	02049593          	slli	a1,s1,0x20
    8002412c:	9181                	srli	a1,a1,0x20
    8002412e:	95e2                	add	a1,a1,s8
    80024130:	e0843503          	ld	a0,-504(s0)
    80024134:	ffffd097          	auipc	ra,0xffffd
    80024138:	ac2080e7          	jalr	-1342(ra) # 80020bf6 <walkaddr>
    8002413c:	862a                	mv	a2,a0
    if(pa == NULL)
    8002413e:	d95d                	beqz	a0,800240f4 <exec+0xe6>
      n = PGSIZE;
    80024140:	89da                	mv	s3,s6
    if(sz - i < PGSIZE)
    80024142:	fd6971e3          	bgeu	s2,s6,80024104 <exec+0xf6>
      n = sz - i;
    80024146:	89ca                	mv	s3,s2
    80024148:	bf75                	j	80024104 <exec+0xf6>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    8002414a:	4481                	li	s1,0
  eunlock(ep);
    8002414c:	8552                	mv	a0,s4
    8002414e:	00002097          	auipc	ra,0x2
    80024152:	1e4080e7          	jalr	484(ra) # 80026332 <eunlock>
  eput(ep);
    80024156:	8552                	mv	a0,s4
    80024158:	00002097          	auipc	ra,0x2
    8002415c:	228080e7          	jalr	552(ra) # 80026380 <eput>
  p = myproc();
    80024160:	ffffe097          	auipc	ra,0xffffe
    80024164:	9f2080e7          	jalr	-1550(ra) # 80021b52 <myproc>
    80024168:	8b2a                	mv	s6,a0
  uint64 oldsz = p->sz;
    8002416a:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    8002416e:	6785                	lui	a5,0x1
    80024170:	17fd                	addi	a5,a5,-1
    80024172:	94be                	add	s1,s1,a5
    80024174:	77fd                	lui	a5,0xfffff
    80024176:	8fe5                	and	a5,a5,s1
    80024178:	def43823          	sd	a5,-528(s0)
  if((sz1 = uvmalloc(pagetable, kpagetable, sz, sz + 2*PGSIZE)) == 0)
    8002417c:	6689                	lui	a3,0x2
    8002417e:	96be                	add	a3,a3,a5
    80024180:	863e                	mv	a2,a5
    80024182:	85d6                	mv	a1,s5
    80024184:	e0843483          	ld	s1,-504(s0)
    80024188:	8526                	mv	a0,s1
    8002418a:	ffffd097          	auipc	ra,0xffffd
    8002418e:	f6a080e7          	jalr	-150(ra) # 800210f4 <uvmalloc>
    80024192:	8caa                	mv	s9,a0
  ep = 0;
    80024194:	4a01                	li	s4,0
  if((sz1 = uvmalloc(pagetable, kpagetable, sz, sz + 2*PGSIZE)) == 0)
    80024196:	16050763          	beqz	a0,80024304 <exec+0x2f6>
  uvmclear(pagetable, sz-2*PGSIZE);
    8002419a:	75f9                	lui	a1,0xffffe
    8002419c:	95aa                	add	a1,a1,a0
    8002419e:	8526                	mv	a0,s1
    800241a0:	ffffd097          	auipc	ra,0xffffd
    800241a4:	1fa080e7          	jalr	506(ra) # 8002139a <uvmclear>
  stackbase = sp - PGSIZE;
    800241a8:	7bfd                	lui	s7,0xfffff
    800241aa:	9be6                	add	s7,s7,s9
  for(argc = 0; argv[argc]; argc++) {
    800241ac:	de843783          	ld	a5,-536(s0)
    800241b0:	6388                	ld	a0,0(a5)
    800241b2:	c925                	beqz	a0,80024222 <exec+0x214>
    800241b4:	e8840993          	addi	s3,s0,-376
    800241b8:	f8840c13          	addi	s8,s0,-120
  sp = sz;
    800241bc:	8966                	mv	s2,s9
  for(argc = 0; argv[argc]; argc++) {
    800241be:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    800241c0:	ffffc097          	auipc	ra,0xffffc
    800241c4:	746080e7          	jalr	1862(ra) # 80020906 <strlen>
    800241c8:	2505                	addiw	a0,a0,1
    800241ca:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800241ce:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    800241d2:	1b796463          	bltu	s2,s7,8002437a <exec+0x36c>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800241d6:	de843d83          	ld	s11,-536(s0)
    800241da:	000dba03          	ld	s4,0(s11) # 1000 <BASE_ADDRESS-0x8001f000>
    800241de:	8552                	mv	a0,s4
    800241e0:	ffffc097          	auipc	ra,0xffffc
    800241e4:	726080e7          	jalr	1830(ra) # 80020906 <strlen>
    800241e8:	0015069b          	addiw	a3,a0,1
    800241ec:	8652                	mv	a2,s4
    800241ee:	85ca                	mv	a1,s2
    800241f0:	e0843503          	ld	a0,-504(s0)
    800241f4:	ffffd097          	auipc	ra,0xffffd
    800241f8:	1d8080e7          	jalr	472(ra) # 800213cc <copyout>
    800241fc:	18054363          	bltz	a0,80024382 <exec+0x374>
    ustack[argc] = sp;
    80024200:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80024204:	0485                	addi	s1,s1,1
    80024206:	008d8793          	addi	a5,s11,8
    8002420a:	def43423          	sd	a5,-536(s0)
    8002420e:	008db503          	ld	a0,8(s11)
    80024212:	c911                	beqz	a0,80024226 <exec+0x218>
    if(argc >= MAXARG)
    80024214:	09a1                	addi	s3,s3,8
    80024216:	fb3c15e3          	bne	s8,s3,800241c0 <exec+0x1b2>
  sz = sz1;
    8002421a:	df943823          	sd	s9,-528(s0)
  ep = 0;
    8002421e:	4a01                	li	s4,0
    80024220:	a0d5                	j	80024304 <exec+0x2f6>
  sp = sz;
    80024222:	8966                	mv	s2,s9
  for(argc = 0; argv[argc]; argc++) {
    80024224:	4481                	li	s1,0
  ustack[argc] = 0;
    80024226:	00349793          	slli	a5,s1,0x3
    8002422a:	f9040713          	addi	a4,s0,-112
    8002422e:	97ba                	add	a5,a5,a4
    80024230:	ee07bc23          	sd	zero,-264(a5) # ffffffffffffeef8 <kernel_end+0xffffffff7ffb9ef8>
  sp -= (argc+1) * sizeof(uint64);
    80024234:	00148693          	addi	a3,s1,1
    80024238:	068e                	slli	a3,a3,0x3
    8002423a:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8002423e:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80024242:	01797663          	bgeu	s2,s7,8002424e <exec+0x240>
  sz = sz1;
    80024246:	df943823          	sd	s9,-528(s0)
  ep = 0;
    8002424a:	4a01                	li	s4,0
    8002424c:	a865                	j	80024304 <exec+0x2f6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8002424e:	e8840613          	addi	a2,s0,-376
    80024252:	85ca                	mv	a1,s2
    80024254:	e0843503          	ld	a0,-504(s0)
    80024258:	ffffd097          	auipc	ra,0xffffd
    8002425c:	174080e7          	jalr	372(ra) # 800213cc <copyout>
    80024260:	12054563          	bltz	a0,8002438a <exec+0x37c>
  p->trapframe->a1 = sp;
    80024264:	060b3783          	ld	a5,96(s6)
    80024268:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8002426c:	de043783          	ld	a5,-544(s0)
    80024270:	0007c703          	lbu	a4,0(a5)
    80024274:	cf11                	beqz	a4,80024290 <exec+0x282>
    80024276:	0785                	addi	a5,a5,1
    if(*s == '/')
    80024278:	02f00693          	li	a3,47
    8002427c:	a029                	j	80024286 <exec+0x278>
    8002427e:	0785                	addi	a5,a5,1
  for(last=s=path; *s; s++)
    80024280:	fff7c703          	lbu	a4,-1(a5)
    80024284:	c711                	beqz	a4,80024290 <exec+0x282>
    if(*s == '/')
    80024286:	fed71ce3          	bne	a4,a3,8002427e <exec+0x270>
      last = s+1;
    8002428a:	def43023          	sd	a5,-544(s0)
    8002428e:	bfc5                	j	8002427e <exec+0x270>
  safestrcpy(p->name, last, sizeof(p->name));
    80024290:	4641                	li	a2,16
    80024292:	de043583          	ld	a1,-544(s0)
    80024296:	160b0513          	addi	a0,s6,352
    8002429a:	ffffc097          	auipc	ra,0xffffc
    8002429e:	63a080e7          	jalr	1594(ra) # 800208d4 <safestrcpy>
  oldpagetable = p->pagetable;
    800242a2:	050b3503          	ld	a0,80(s6)
  oldkpagetable = p->kpagetable;
    800242a6:	058b3983          	ld	s3,88(s6)
  p->pagetable = pagetable;
    800242aa:	e0843783          	ld	a5,-504(s0)
    800242ae:	04fb3823          	sd	a5,80(s6)
  p->kpagetable = kpagetable;
    800242b2:	055b3c23          	sd	s5,88(s6)
  p->sz = sz;
    800242b6:	059b3423          	sd	s9,72(s6)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800242ba:	060b3783          	ld	a5,96(s6)
    800242be:	e6043703          	ld	a4,-416(s0)
    800242c2:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800242c4:	060b3783          	ld	a5,96(s6)
    800242c8:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800242cc:	85ea                	mv	a1,s10
    800242ce:	ffffe097          	auipc	ra,0xffffe
    800242d2:	a06080e7          	jalr	-1530(ra) # 80021cd4 <proc_freepagetable>
  w_satp(MAKE_SATP(p->kpagetable));
    800242d6:	058b3783          	ld	a5,88(s6)
    800242da:	83b1                	srli	a5,a5,0xc
    800242dc:	577d                	li	a4,-1
    800242de:	177e                	slli	a4,a4,0x3f
    800242e0:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800242e2:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    800242e6:	12000073          	sfence.vma
  kvmfree(oldkpagetable, 0);
    800242ea:	4581                	li	a1,0
    800242ec:	854e                	mv	a0,s3
    800242ee:	ffffd097          	auipc	ra,0xffffd
    800242f2:	488080e7          	jalr	1160(ra) # 80021776 <kvmfree>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800242f6:	0004851b          	sext.w	a0,s1
    800242fa:	a089                	j	8002433c <exec+0x32e>
    return -1;
    800242fc:	557d                	li	a0,-1
    800242fe:	a83d                	j	8002433c <exec+0x32e>
    80024300:	de943823          	sd	s1,-528(s0)
    proc_freepagetable(pagetable, sz);
    80024304:	df043583          	ld	a1,-528(s0)
    80024308:	e0843503          	ld	a0,-504(s0)
    8002430c:	ffffe097          	auipc	ra,0xffffe
    80024310:	9c8080e7          	jalr	-1592(ra) # 80021cd4 <proc_freepagetable>
    kvmfree(kpagetable, 0);
    80024314:	4581                	li	a1,0
    80024316:	8556                	mv	a0,s5
    80024318:	ffffd097          	auipc	ra,0xffffd
    8002431c:	45e080e7          	jalr	1118(ra) # 80021776 <kvmfree>
    eunlock(ep);
    eput(ep);
  }
  return -1;
    80024320:	557d                	li	a0,-1
  if(ep){
    80024322:	000a0d63          	beqz	s4,8002433c <exec+0x32e>
    eunlock(ep);
    80024326:	8552                	mv	a0,s4
    80024328:	00002097          	auipc	ra,0x2
    8002432c:	00a080e7          	jalr	10(ra) # 80026332 <eunlock>
    eput(ep);
    80024330:	8552                	mv	a0,s4
    80024332:	00002097          	auipc	ra,0x2
    80024336:	04e080e7          	jalr	78(ra) # 80026380 <eput>
  return -1;
    8002433a:	557d                	li	a0,-1
}
    8002433c:	22813083          	ld	ra,552(sp)
    80024340:	22013403          	ld	s0,544(sp)
    80024344:	21813483          	ld	s1,536(sp)
    80024348:	21013903          	ld	s2,528(sp)
    8002434c:	20813983          	ld	s3,520(sp)
    80024350:	20013a03          	ld	s4,512(sp)
    80024354:	7afe                	ld	s5,504(sp)
    80024356:	7b5e                	ld	s6,496(sp)
    80024358:	7bbe                	ld	s7,488(sp)
    8002435a:	7c1e                	ld	s8,480(sp)
    8002435c:	6cfe                	ld	s9,472(sp)
    8002435e:	6d5e                	ld	s10,464(sp)
    80024360:	6dbe                	ld	s11,456(sp)
    80024362:	23010113          	addi	sp,sp,560
    80024366:	8082                	ret
    80024368:	de943823          	sd	s1,-528(s0)
    8002436c:	bf61                	j	80024304 <exec+0x2f6>
    8002436e:	de943823          	sd	s1,-528(s0)
    80024372:	bf49                	j	80024304 <exec+0x2f6>
    80024374:	de943823          	sd	s1,-528(s0)
    80024378:	b771                	j	80024304 <exec+0x2f6>
  sz = sz1;
    8002437a:	df943823          	sd	s9,-528(s0)
  ep = 0;
    8002437e:	4a01                	li	s4,0
    80024380:	b751                	j	80024304 <exec+0x2f6>
  sz = sz1;
    80024382:	df943823          	sd	s9,-528(s0)
  ep = 0;
    80024386:	4a01                	li	s4,0
    80024388:	bfb5                	j	80024304 <exec+0x2f6>
  sz = sz1;
    8002438a:	df943823          	sd	s9,-528(s0)
  ep = 0;
    8002438e:	4a01                	li	s4,0
    80024390:	bf95                	j	80024304 <exec+0x2f6>
    if((sz1 = uvmalloc(pagetable, kpagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80024392:	df043483          	ld	s1,-528(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80024396:	e0043783          	ld	a5,-512(s0)
    8002439a:	0017869b          	addiw	a3,a5,1
    8002439e:	e0d43023          	sd	a3,-512(s0)
    800243a2:	df843783          	ld	a5,-520(s0)
    800243a6:	0387879b          	addiw	a5,a5,56
    800243aa:	e8045703          	lhu	a4,-384(s0)
    800243ae:	d8e6dfe3          	bge	a3,a4,8002414c <exec+0x13e>
    if(eread(ep, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800243b2:	2781                	sext.w	a5,a5
    800243b4:	def43c23          	sd	a5,-520(s0)
    800243b8:	03800713          	li	a4,56
    800243bc:	86be                	mv	a3,a5
    800243be:	e1040613          	addi	a2,s0,-496
    800243c2:	4581                	li	a1,0
    800243c4:	8552                	mv	a0,s4
    800243c6:	00001097          	auipc	ra,0x1
    800243ca:	668080e7          	jalr	1640(ra) # 80025a2e <eread>
    800243ce:	03800793          	li	a5,56
    800243d2:	f2f517e3          	bne	a0,a5,80024300 <exec+0x2f2>
    if(ph.type != ELF_PROG_LOAD)
    800243d6:	e1042783          	lw	a5,-496(s0)
    800243da:	4705                	li	a4,1
    800243dc:	fae79de3          	bne	a5,a4,80024396 <exec+0x388>
    if(ph.memsz < ph.filesz)
    800243e0:	e3843683          	ld	a3,-456(s0)
    800243e4:	e3043783          	ld	a5,-464(s0)
    800243e8:	f8f6e0e3          	bltu	a3,a5,80024368 <exec+0x35a>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800243ec:	e2043783          	ld	a5,-480(s0)
    800243f0:	96be                	add	a3,a3,a5
    800243f2:	f6f6eee3          	bltu	a3,a5,8002436e <exec+0x360>
    if((sz1 = uvmalloc(pagetable, kpagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800243f6:	8626                	mv	a2,s1
    800243f8:	85d6                	mv	a1,s5
    800243fa:	e0843503          	ld	a0,-504(s0)
    800243fe:	ffffd097          	auipc	ra,0xffffd
    80024402:	cf6080e7          	jalr	-778(ra) # 800210f4 <uvmalloc>
    80024406:	dea43823          	sd	a0,-528(s0)
    8002440a:	d52d                	beqz	a0,80024374 <exec+0x366>
    if(ph.vaddr % PGSIZE != 0)
    8002440c:	e2043c03          	ld	s8,-480(s0)
    80024410:	dd843783          	ld	a5,-552(s0)
    80024414:	00fc77b3          	and	a5,s8,a5
    80024418:	ee0796e3          	bnez	a5,80024304 <exec+0x2f6>
    if(loadseg(pagetable, ph.vaddr, ep, ph.off, ph.filesz) < 0)
    8002441c:	e1842c83          	lw	s9,-488(s0)
    80024420:	e3042b83          	lw	s7,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80024424:	f60b87e3          	beqz	s7,80024392 <exec+0x384>
    80024428:	895e                	mv	s2,s7
    8002442a:	4481                	li	s1,0
    8002442c:	b9f5                	j	80024128 <exec+0x11a>
    kvmfree(kpagetable, 0);
    8002442e:	4581                	li	a1,0
    80024430:	8556                	mv	a0,s5
    80024432:	ffffd097          	auipc	ra,0xffffd
    80024436:	344080e7          	jalr	836(ra) # 80021776 <kvmfree>
  return -1;
    8002443a:	557d                	li	a0,-1
    8002443c:	b701                	j	8002433c <exec+0x32e>

000000008002443e <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8002443e:	7179                	addi	sp,sp,-48
    80024440:	f406                	sd	ra,40(sp)
    80024442:	f022                	sd	s0,32(sp)
    80024444:	ec26                	sd	s1,24(sp)
    80024446:	e84a                	sd	s2,16(sp)
    80024448:	1800                	addi	s0,sp,48
    8002444a:	892e                	mv	s2,a1
    8002444c:	84b2                	mv	s1,a2
    int fd;
    struct file *f;

    if(argint(n, &fd) < 0)
    8002444e:	fdc40593          	addi	a1,s0,-36
    80024452:	fffff097          	auipc	ra,0xfffff
    80024456:	ab0080e7          	jalr	-1360(ra) # 80022f02 <argint>
    8002445a:	04054063          	bltz	a0,8002449a <argfd+0x5c>
        return -1;
    if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == NULL)
    8002445e:	fdc42703          	lw	a4,-36(s0)
    80024462:	47bd                	li	a5,15
    80024464:	02e7ed63          	bltu	a5,a4,8002449e <argfd+0x60>
    80024468:	ffffd097          	auipc	ra,0xffffd
    8002446c:	6ea080e7          	jalr	1770(ra) # 80021b52 <myproc>
    80024470:	fdc42703          	lw	a4,-36(s0)
    80024474:	01a70793          	addi	a5,a4,26
    80024478:	078e                	slli	a5,a5,0x3
    8002447a:	953e                	add	a0,a0,a5
    8002447c:	651c                	ld	a5,8(a0)
    8002447e:	c395                	beqz	a5,800244a2 <argfd+0x64>
        return -1;
    if(pfd)
    80024480:	00090463          	beqz	s2,80024488 <argfd+0x4a>
        *pfd = fd;
    80024484:	00e92023          	sw	a4,0(s2)
    if(pf)
        *pf = f;
    return 0;
    80024488:	4501                	li	a0,0
    if(pf)
    8002448a:	c091                	beqz	s1,8002448e <argfd+0x50>
        *pf = f;
    8002448c:	e09c                	sd	a5,0(s1)
}
    8002448e:	70a2                	ld	ra,40(sp)
    80024490:	7402                	ld	s0,32(sp)
    80024492:	64e2                	ld	s1,24(sp)
    80024494:	6942                	ld	s2,16(sp)
    80024496:	6145                	addi	sp,sp,48
    80024498:	8082                	ret
        return -1;
    8002449a:	557d                	li	a0,-1
    8002449c:	bfcd                	j	8002448e <argfd+0x50>
        return -1;
    8002449e:	557d                	li	a0,-1
    800244a0:	b7fd                	j	8002448e <argfd+0x50>
    800244a2:	557d                	li	a0,-1
    800244a4:	b7ed                	j	8002448e <argfd+0x50>

00000000800244a6 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800244a6:	1101                	addi	sp,sp,-32
    800244a8:	ec06                	sd	ra,24(sp)
    800244aa:	e822                	sd	s0,16(sp)
    800244ac:	e426                	sd	s1,8(sp)
    800244ae:	1000                	addi	s0,sp,32
    800244b0:	84aa                	mv	s1,a0
    int fd;
    struct proc *p = myproc();
    800244b2:	ffffd097          	auipc	ra,0xffffd
    800244b6:	6a0080e7          	jalr	1696(ra) # 80021b52 <myproc>

    for(fd = 0; fd < NOFILE; fd++){
        if(p->ofile[fd] == 0){
    800244ba:	6d7c                	ld	a5,216(a0)
    800244bc:	c395                	beqz	a5,800244e0 <fdalloc+0x3a>
    800244be:	0e050713          	addi	a4,a0,224
    for(fd = 0; fd < NOFILE; fd++){
    800244c2:	4785                	li	a5,1
    800244c4:	4641                	li	a2,16
        if(p->ofile[fd] == 0){
    800244c6:	6314                	ld	a3,0(a4)
    800244c8:	ce89                	beqz	a3,800244e2 <fdalloc+0x3c>
    for(fd = 0; fd < NOFILE; fd++){
    800244ca:	2785                	addiw	a5,a5,1
    800244cc:	0721                	addi	a4,a4,8
    800244ce:	fec79ce3          	bne	a5,a2,800244c6 <fdalloc+0x20>
            p->ofile[fd] = f;
            return fd;
        }
    }
    return -1;
    800244d2:	57fd                	li	a5,-1
}
    800244d4:	853e                	mv	a0,a5
    800244d6:	60e2                	ld	ra,24(sp)
    800244d8:	6442                	ld	s0,16(sp)
    800244da:	64a2                	ld	s1,8(sp)
    800244dc:	6105                	addi	sp,sp,32
    800244de:	8082                	ret
    for(fd = 0; fd < NOFILE; fd++){
    800244e0:	4781                	li	a5,0
            p->ofile[fd] = f;
    800244e2:	01a78713          	addi	a4,a5,26
    800244e6:	070e                	slli	a4,a4,0x3
    800244e8:	953a                	add	a0,a0,a4
    800244ea:	e504                	sd	s1,8(a0)
            return fd;
    800244ec:	b7e5                	j	800244d4 <fdalloc+0x2e>

00000000800244ee <create>:
    return filestat(f, st);
}

static struct dirent*
create(char *path, short type, int mode)
{
    800244ee:	7169                	addi	sp,sp,-304
    800244f0:	f606                	sd	ra,296(sp)
    800244f2:	f222                	sd	s0,288(sp)
    800244f4:	ee26                	sd	s1,280(sp)
    800244f6:	ea4a                	sd	s2,272(sp)
    800244f8:	e64e                	sd	s3,264(sp)
    800244fa:	1a00                	addi	s0,sp,304
    800244fc:	89ae                	mv	s3,a1
    struct dirent *ep, *dp;
    char name[FAT32_MAX_FILENAME + 1];

    if((dp = enameparent(path, name)) == NULL)
    800244fe:	ed040593          	addi	a1,s0,-304
    80024502:	00002097          	auipc	ra,0x2
    80024506:	5be080e7          	jalr	1470(ra) # 80026ac0 <enameparent>
    8002450a:	84aa                	mv	s1,a0
    8002450c:	cd3d                	beqz	a0,8002458a <create+0x9c>
        return NULL;

    if (type == T_DIR) {
    8002450e:	0009879b          	sext.w	a5,s3
    80024512:	4705                	li	a4,1
    80024514:	06e78d63          	beq	a5,a4,8002458e <create+0xa0>
        mode = ATTR_READ_ONLY;
    } else {
        mode = 0;
    }

    elock(dp);
    80024518:	00002097          	auipc	ra,0x2
    8002451c:	de4080e7          	jalr	-540(ra) # 800262fc <elock>
    if ((ep = ealloc(dp, name, mode)) == NULL) {
    80024520:	4601                	li	a2,0
    80024522:	ed040593          	addi	a1,s0,-304
    80024526:	8526                	mv	a0,s1
    80024528:	00002097          	auipc	ra,0x2
    8002452c:	2bc080e7          	jalr	700(ra) # 800267e4 <ealloc>
    80024530:	892a                	mv	s2,a0
    80024532:	c121                	beqz	a0,80024572 <create+0x84>
        eunlock(dp);
        eput(dp);
        return NULL;
    }

    if ((type == T_DIR && !(ep->attribute & ATTR_DIRECTORY)) ||
    80024534:	2981                	sext.w	s3,s3
    80024536:	4789                	li	a5,2
    80024538:	00f99663          	bne	s3,a5,80024544 <create+0x56>
        (type == T_FILE && (ep->attribute & ATTR_DIRECTORY))) {
    8002453c:	10094783          	lbu	a5,256(s2)
    80024540:	8bc1                	andi	a5,a5,16
    80024542:	eba5                	bnez	a5,800245b2 <create+0xc4>
        eput(ep);
        eput(dp);
        return NULL;
    }

    eunlock(dp);
    80024544:	8526                	mv	a0,s1
    80024546:	00002097          	auipc	ra,0x2
    8002454a:	dec080e7          	jalr	-532(ra) # 80026332 <eunlock>
    eput(dp);
    8002454e:	8526                	mv	a0,s1
    80024550:	00002097          	auipc	ra,0x2
    80024554:	e30080e7          	jalr	-464(ra) # 80026380 <eput>

    elock(ep);
    80024558:	854a                	mv	a0,s2
    8002455a:	00002097          	auipc	ra,0x2
    8002455e:	da2080e7          	jalr	-606(ra) # 800262fc <elock>
    return ep;
}
    80024562:	854a                	mv	a0,s2
    80024564:	70b2                	ld	ra,296(sp)
    80024566:	7412                	ld	s0,288(sp)
    80024568:	64f2                	ld	s1,280(sp)
    8002456a:	6952                	ld	s2,272(sp)
    8002456c:	69b2                	ld	s3,264(sp)
    8002456e:	6155                	addi	sp,sp,304
    80024570:	8082                	ret
        eunlock(dp);
    80024572:	8526                	mv	a0,s1
    80024574:	00002097          	auipc	ra,0x2
    80024578:	dbe080e7          	jalr	-578(ra) # 80026332 <eunlock>
        eput(dp);
    8002457c:	8526                	mv	a0,s1
    8002457e:	00002097          	auipc	ra,0x2
    80024582:	e02080e7          	jalr	-510(ra) # 80026380 <eput>
        return NULL;
    80024586:	4901                	li	s2,0
    80024588:	bfe9                	j	80024562 <create+0x74>
        return NULL;
    8002458a:	892a                	mv	s2,a0
    8002458c:	bfd9                	j	80024562 <create+0x74>
    elock(dp);
    8002458e:	00002097          	auipc	ra,0x2
    80024592:	d6e080e7          	jalr	-658(ra) # 800262fc <elock>
    if ((ep = ealloc(dp, name, mode)) == NULL) {
    80024596:	4641                	li	a2,16
    80024598:	ed040593          	addi	a1,s0,-304
    8002459c:	8526                	mv	a0,s1
    8002459e:	00002097          	auipc	ra,0x2
    800245a2:	246080e7          	jalr	582(ra) # 800267e4 <ealloc>
    800245a6:	892a                	mv	s2,a0
    800245a8:	d569                	beqz	a0,80024572 <create+0x84>
    if ((type == T_DIR && !(ep->attribute & ATTR_DIRECTORY)) ||
    800245aa:	10094783          	lbu	a5,256(s2)
    800245ae:	8bc1                	andi	a5,a5,16
    800245b0:	fbd1                	bnez	a5,80024544 <create+0x56>
        eunlock(dp);
    800245b2:	8526                	mv	a0,s1
    800245b4:	00002097          	auipc	ra,0x2
    800245b8:	d7e080e7          	jalr	-642(ra) # 80026332 <eunlock>
        eput(ep);
    800245bc:	854a                	mv	a0,s2
    800245be:	00002097          	auipc	ra,0x2
    800245c2:	dc2080e7          	jalr	-574(ra) # 80026380 <eput>
        eput(dp);
    800245c6:	8526                	mv	a0,s1
    800245c8:	00002097          	auipc	ra,0x2
    800245cc:	db8080e7          	jalr	-584(ra) # 80026380 <eput>
        return NULL;
    800245d0:	4901                	li	s2,0
    800245d2:	bf41                	j	80024562 <create+0x74>

00000000800245d4 <sys_dup>:
{
    800245d4:	7179                	addi	sp,sp,-48
    800245d6:	f406                	sd	ra,40(sp)
    800245d8:	f022                	sd	s0,32(sp)
    800245da:	ec26                	sd	s1,24(sp)
    800245dc:	1800                	addi	s0,sp,48
    if(argfd(0, 0, &f) < 0)
    800245de:	fd840613          	addi	a2,s0,-40
    800245e2:	4581                	li	a1,0
    800245e4:	4501                	li	a0,0
    800245e6:	00000097          	auipc	ra,0x0
    800245ea:	e58080e7          	jalr	-424(ra) # 8002443e <argfd>
        return -1;
    800245ee:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0)
    800245f0:	02054363          	bltz	a0,80024616 <sys_dup+0x42>
    if((fd=fdalloc(f)) < 0)
    800245f4:	fd843503          	ld	a0,-40(s0)
    800245f8:	00000097          	auipc	ra,0x0
    800245fc:	eae080e7          	jalr	-338(ra) # 800244a6 <fdalloc>
    80024600:	84aa                	mv	s1,a0
        return -1;
    80024602:	57fd                	li	a5,-1
    if((fd=fdalloc(f)) < 0)
    80024604:	00054963          	bltz	a0,80024616 <sys_dup+0x42>
    filedup(f);
    80024608:	fd843503          	ld	a0,-40(s0)
    8002460c:	fffff097          	auipc	ra,0xfffff
    80024610:	2d8080e7          	jalr	728(ra) # 800238e4 <filedup>
    return fd;
    80024614:	87a6                	mv	a5,s1
}
    80024616:	853e                	mv	a0,a5
    80024618:	70a2                	ld	ra,40(sp)
    8002461a:	7402                	ld	s0,32(sp)
    8002461c:	64e2                	ld	s1,24(sp)
    8002461e:	6145                	addi	sp,sp,48
    80024620:	8082                	ret

0000000080024622 <sys_read>:
{
    80024622:	7179                	addi	sp,sp,-48
    80024624:	f406                	sd	ra,40(sp)
    80024626:	f022                	sd	s0,32(sp)
    80024628:	1800                	addi	s0,sp,48
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002462a:	fe840613          	addi	a2,s0,-24
    8002462e:	4581                	li	a1,0
    80024630:	4501                	li	a0,0
    80024632:	00000097          	auipc	ra,0x0
    80024636:	e0c080e7          	jalr	-500(ra) # 8002443e <argfd>
        return -1;
    8002463a:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002463c:	04054163          	bltz	a0,8002467e <sys_read+0x5c>
    80024640:	fe440593          	addi	a1,s0,-28
    80024644:	4509                	li	a0,2
    80024646:	fffff097          	auipc	ra,0xfffff
    8002464a:	8bc080e7          	jalr	-1860(ra) # 80022f02 <argint>
        return -1;
    8002464e:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80024650:	02054763          	bltz	a0,8002467e <sys_read+0x5c>
    80024654:	fd840593          	addi	a1,s0,-40
    80024658:	4505                	li	a0,1
    8002465a:	fffff097          	auipc	ra,0xfffff
    8002465e:	90a080e7          	jalr	-1782(ra) # 80022f64 <argaddr>
        return -1;
    80024662:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80024664:	00054d63          	bltz	a0,8002467e <sys_read+0x5c>
    return fileread(f, p, n);
    80024668:	fe442603          	lw	a2,-28(s0)
    8002466c:	fd843583          	ld	a1,-40(s0)
    80024670:	fe843503          	ld	a0,-24(s0)
    80024674:	fffff097          	auipc	ra,0xfffff
    80024678:	3d8080e7          	jalr	984(ra) # 80023a4c <fileread>
    8002467c:	87aa                	mv	a5,a0
}
    8002467e:	853e                	mv	a0,a5
    80024680:	70a2                	ld	ra,40(sp)
    80024682:	7402                	ld	s0,32(sp)
    80024684:	6145                	addi	sp,sp,48
    80024686:	8082                	ret

0000000080024688 <sys_write>:
{
    80024688:	7179                	addi	sp,sp,-48
    8002468a:	f406                	sd	ra,40(sp)
    8002468c:	f022                	sd	s0,32(sp)
    8002468e:	1800                	addi	s0,sp,48
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80024690:	fe840613          	addi	a2,s0,-24
    80024694:	4581                	li	a1,0
    80024696:	4501                	li	a0,0
    80024698:	00000097          	auipc	ra,0x0
    8002469c:	da6080e7          	jalr	-602(ra) # 8002443e <argfd>
        return -1;
    800246a0:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800246a2:	04054163          	bltz	a0,800246e4 <sys_write+0x5c>
    800246a6:	fe440593          	addi	a1,s0,-28
    800246aa:	4509                	li	a0,2
    800246ac:	fffff097          	auipc	ra,0xfffff
    800246b0:	856080e7          	jalr	-1962(ra) # 80022f02 <argint>
        return -1;
    800246b4:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800246b6:	02054763          	bltz	a0,800246e4 <sys_write+0x5c>
    800246ba:	fd840593          	addi	a1,s0,-40
    800246be:	4505                	li	a0,1
    800246c0:	fffff097          	auipc	ra,0xfffff
    800246c4:	8a4080e7          	jalr	-1884(ra) # 80022f64 <argaddr>
        return -1;
    800246c8:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800246ca:	00054d63          	bltz	a0,800246e4 <sys_write+0x5c>
    return filewrite(f, p, n);
    800246ce:	fe442603          	lw	a2,-28(s0)
    800246d2:	fd843583          	ld	a1,-40(s0)
    800246d6:	fe843503          	ld	a0,-24(s0)
    800246da:	fffff097          	auipc	ra,0xfffff
    800246de:	434080e7          	jalr	1076(ra) # 80023b0e <filewrite>
    800246e2:	87aa                	mv	a5,a0
}
    800246e4:	853e                	mv	a0,a5
    800246e6:	70a2                	ld	ra,40(sp)
    800246e8:	7402                	ld	s0,32(sp)
    800246ea:	6145                	addi	sp,sp,48
    800246ec:	8082                	ret

00000000800246ee <sys_close>:
{
    800246ee:	1101                	addi	sp,sp,-32
    800246f0:	ec06                	sd	ra,24(sp)
    800246f2:	e822                	sd	s0,16(sp)
    800246f4:	1000                	addi	s0,sp,32
    if(argfd(0, &fd, &f) < 0)
    800246f6:	fe040613          	addi	a2,s0,-32
    800246fa:	fec40593          	addi	a1,s0,-20
    800246fe:	4501                	li	a0,0
    80024700:	00000097          	auipc	ra,0x0
    80024704:	d3e080e7          	jalr	-706(ra) # 8002443e <argfd>
        return -1;
    80024708:	57fd                	li	a5,-1
    if(argfd(0, &fd, &f) < 0)
    8002470a:	02054463          	bltz	a0,80024732 <sys_close+0x44>
    myproc()->ofile[fd] = 0;
    8002470e:	ffffd097          	auipc	ra,0xffffd
    80024712:	444080e7          	jalr	1092(ra) # 80021b52 <myproc>
    80024716:	fec42783          	lw	a5,-20(s0)
    8002471a:	07e9                	addi	a5,a5,26
    8002471c:	078e                	slli	a5,a5,0x3
    8002471e:	953e                	add	a0,a0,a5
    80024720:	00053423          	sd	zero,8(a0)
    fileclose(f);
    80024724:	fe043503          	ld	a0,-32(s0)
    80024728:	fffff097          	auipc	ra,0xfffff
    8002472c:	20e080e7          	jalr	526(ra) # 80023936 <fileclose>
    return 0;
    80024730:	4781                	li	a5,0
}
    80024732:	853e                	mv	a0,a5
    80024734:	60e2                	ld	ra,24(sp)
    80024736:	6442                	ld	s0,16(sp)
    80024738:	6105                	addi	sp,sp,32
    8002473a:	8082                	ret

000000008002473c <sys_fstat>:
{
    8002473c:	1101                	addi	sp,sp,-32
    8002473e:	ec06                	sd	ra,24(sp)
    80024740:	e822                	sd	s0,16(sp)
    80024742:	1000                	addi	s0,sp,32
    if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80024744:	fe840613          	addi	a2,s0,-24
    80024748:	4581                	li	a1,0
    8002474a:	4501                	li	a0,0
    8002474c:	00000097          	auipc	ra,0x0
    80024750:	cf2080e7          	jalr	-782(ra) # 8002443e <argfd>
        return -1;
    80024754:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80024756:	02054563          	bltz	a0,80024780 <sys_fstat+0x44>
    8002475a:	fe040593          	addi	a1,s0,-32
    8002475e:	4505                	li	a0,1
    80024760:	fffff097          	auipc	ra,0xfffff
    80024764:	804080e7          	jalr	-2044(ra) # 80022f64 <argaddr>
        return -1;
    80024768:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8002476a:	00054b63          	bltz	a0,80024780 <sys_fstat+0x44>
    return filestat(f, st);
    8002476e:	fe043583          	ld	a1,-32(s0)
    80024772:	fe843503          	ld	a0,-24(s0)
    80024776:	fffff097          	auipc	ra,0xfffff
    8002477a:	276080e7          	jalr	630(ra) # 800239ec <filestat>
    8002477e:	87aa                	mv	a5,a0
}
    80024780:	853e                	mv	a0,a5
    80024782:	60e2                	ld	ra,24(sp)
    80024784:	6442                	ld	s0,16(sp)
    80024786:	6105                	addi	sp,sp,32
    80024788:	8082                	ret

000000008002478a <sys_open>:

uint64
sys_open(void)
{
    8002478a:	7129                	addi	sp,sp,-320
    8002478c:	fe06                	sd	ra,312(sp)
    8002478e:	fa22                	sd	s0,304(sp)
    80024790:	f626                	sd	s1,296(sp)
    80024792:	f24a                	sd	s2,288(sp)
    80024794:	ee4e                	sd	s3,280(sp)
    80024796:	0280                	addi	s0,sp,320
    char path[FAT32_MAX_PATH];
    int fd, omode;
    struct file *f;
    struct dirent *ep;

    if(argstr(1, path, FAT32_MAX_PATH) < 0 || argint(2, &omode) < 0)
    80024798:	10400613          	li	a2,260
    8002479c:	ec840593          	addi	a1,s0,-312
    800247a0:	4505                	li	a0,1
    800247a2:	ffffe097          	auipc	ra,0xffffe
    800247a6:	7e4080e7          	jalr	2020(ra) # 80022f86 <argstr>
        return -1;
    800247aa:	54fd                	li	s1,-1
    if(argstr(1, path, FAT32_MAX_PATH) < 0 || argint(2, &omode) < 0)
    800247ac:	08054d63          	bltz	a0,80024846 <sys_open+0xbc>
    800247b0:	ec440593          	addi	a1,s0,-316
    800247b4:	4509                	li	a0,2
    800247b6:	ffffe097          	auipc	ra,0xffffe
    800247ba:	74c080e7          	jalr	1868(ra) # 80022f02 <argint>
    800247be:	0e054163          	bltz	a0,800248a0 <sys_open+0x116>

    if(omode & O_CREATE){
    800247c2:	ec442603          	lw	a2,-316(s0)
    800247c6:	04067793          	andi	a5,a2,64
    800247ca:	c7d1                	beqz	a5,80024856 <sys_open+0xcc>
        ep = create(path, T_FILE, omode);
    800247cc:	4589                	li	a1,2
    800247ce:	ec840513          	addi	a0,s0,-312
    800247d2:	00000097          	auipc	ra,0x0
    800247d6:	d1c080e7          	jalr	-740(ra) # 800244ee <create>
    800247da:	892a                	mv	s2,a0
        if(ep == NULL){
    800247dc:	c561                	beqz	a0,800248a4 <sys_open+0x11a>
            eput(ep);
            return -1;
        }
    }

    if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    800247de:	fffff097          	auipc	ra,0xfffff
    800247e2:	088080e7          	jalr	136(ra) # 80023866 <filealloc>
    800247e6:	89aa                	mv	s3,a0
    800247e8:	c579                	beqz	a0,800248b6 <sys_open+0x12c>
    800247ea:	00000097          	auipc	ra,0x0
    800247ee:	cbc080e7          	jalr	-836(ra) # 800244a6 <fdalloc>
    800247f2:	84aa                	mv	s1,a0
    800247f4:	0a054c63          	bltz	a0,800248ac <sys_open+0x122>
        eunlock(ep);
        eput(ep);
        return -1;
    }

    if(!(ep->attribute & ATTR_DIRECTORY) && (omode & O_TRUNC)){
    800247f8:	10094783          	lbu	a5,256(s2)
    800247fc:	8bc1                	andi	a5,a5,16
    800247fe:	e791                	bnez	a5,8002480a <sys_open+0x80>
    80024800:	ec442783          	lw	a5,-316(s0)
    80024804:	4007f793          	andi	a5,a5,1024
    80024808:	e7d1                	bnez	a5,80024894 <sys_open+0x10a>
        etrunc(ep);
    }

    f->type = FD_ENTRY;
    8002480a:	4789                	li	a5,2
    8002480c:	00f9a023          	sw	a5,0(s3)
    f->off = (omode & O_APPEND) ? ep->file_size : 0;
    80024810:	ec442783          	lw	a5,-316(s0)
    80024814:	0047f693          	andi	a3,a5,4
    80024818:	4701                	li	a4,0
    8002481a:	c299                	beqz	a3,80024820 <sys_open+0x96>
    8002481c:	10892703          	lw	a4,264(s2)
    80024820:	02e9a023          	sw	a4,32(s3)
    f->ep = ep;
    80024824:	0129bc23          	sd	s2,24(s3)
    f->readable = !(omode & O_WRONLY);
    80024828:	0017c713          	xori	a4,a5,1
    8002482c:	8b05                	andi	a4,a4,1
    8002482e:	00e98423          	sb	a4,8(s3)
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80024832:	8b8d                	andi	a5,a5,3
    80024834:	00f037b3          	snez	a5,a5
    80024838:	00f984a3          	sb	a5,9(s3)

    eunlock(ep);
    8002483c:	854a                	mv	a0,s2
    8002483e:	00002097          	auipc	ra,0x2
    80024842:	af4080e7          	jalr	-1292(ra) # 80026332 <eunlock>

    return fd;
}
    80024846:	8526                	mv	a0,s1
    80024848:	70f2                	ld	ra,312(sp)
    8002484a:	7452                	ld	s0,304(sp)
    8002484c:	74b2                	ld	s1,296(sp)
    8002484e:	7912                	ld	s2,288(sp)
    80024850:	69f2                	ld	s3,280(sp)
    80024852:	6131                	addi	sp,sp,320
    80024854:	8082                	ret
        if((ep = ename(path)) == NULL){
    80024856:	ec840513          	addi	a0,s0,-312
    8002485a:	00002097          	auipc	ra,0x2
    8002485e:	248080e7          	jalr	584(ra) # 80026aa2 <ename>
    80024862:	892a                	mv	s2,a0
    80024864:	c131                	beqz	a0,800248a8 <sys_open+0x11e>
        elock(ep);
    80024866:	00002097          	auipc	ra,0x2
    8002486a:	a96080e7          	jalr	-1386(ra) # 800262fc <elock>
        if((ep->attribute & ATTR_DIRECTORY) && omode != O_RDONLY){
    8002486e:	10094783          	lbu	a5,256(s2)
    80024872:	8bc1                	andi	a5,a5,16
    80024874:	d7ad                	beqz	a5,800247de <sys_open+0x54>
    80024876:	ec442783          	lw	a5,-316(s0)
    8002487a:	d3b5                	beqz	a5,800247de <sys_open+0x54>
            eunlock(ep);
    8002487c:	854a                	mv	a0,s2
    8002487e:	00002097          	auipc	ra,0x2
    80024882:	ab4080e7          	jalr	-1356(ra) # 80026332 <eunlock>
            eput(ep);
    80024886:	854a                	mv	a0,s2
    80024888:	00002097          	auipc	ra,0x2
    8002488c:	af8080e7          	jalr	-1288(ra) # 80026380 <eput>
            return -1;
    80024890:	54fd                	li	s1,-1
    80024892:	bf55                	j	80024846 <sys_open+0xbc>
        etrunc(ep);
    80024894:	854a                	mv	a0,s2
    80024896:	00002097          	auipc	ra,0x2
    8002489a:	9fe080e7          	jalr	-1538(ra) # 80026294 <etrunc>
    8002489e:	b7b5                	j	8002480a <sys_open+0x80>
        return -1;
    800248a0:	54fd                	li	s1,-1
    800248a2:	b755                	j	80024846 <sys_open+0xbc>
            return -1;
    800248a4:	54fd                	li	s1,-1
    800248a6:	b745                	j	80024846 <sys_open+0xbc>
            return -1;
    800248a8:	54fd                	li	s1,-1
    800248aa:	bf71                	j	80024846 <sys_open+0xbc>
            fileclose(f);
    800248ac:	854e                	mv	a0,s3
    800248ae:	fffff097          	auipc	ra,0xfffff
    800248b2:	088080e7          	jalr	136(ra) # 80023936 <fileclose>
        eunlock(ep);
    800248b6:	854a                	mv	a0,s2
    800248b8:	00002097          	auipc	ra,0x2
    800248bc:	a7a080e7          	jalr	-1414(ra) # 80026332 <eunlock>
        eput(ep);
    800248c0:	854a                	mv	a0,s2
    800248c2:	00002097          	auipc	ra,0x2
    800248c6:	abe080e7          	jalr	-1346(ra) # 80026380 <eput>
        return -1;
    800248ca:	54fd                	li	s1,-1
    800248cc:	bfad                	j	80024846 <sys_open+0xbc>

00000000800248ce <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800248ce:	7169                	addi	sp,sp,-304
    800248d0:	f606                	sd	ra,296(sp)
    800248d2:	f222                	sd	s0,288(sp)
    800248d4:	ee26                	sd	s1,280(sp)
    800248d6:	1a00                	addi	s0,sp,304
    char path[FAT32_MAX_PATH];
    struct dirent *ep;

    if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR, 0)) == 0){
    800248d8:	10400613          	li	a2,260
    800248dc:	ed840593          	addi	a1,s0,-296
    800248e0:	4501                	li	a0,0
    800248e2:	ffffe097          	auipc	ra,0xffffe
    800248e6:	6a4080e7          	jalr	1700(ra) # 80022f86 <argstr>
        return -1;
    800248ea:	57fd                	li	a5,-1
    if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR, 0)) == 0){
    800248ec:	02054663          	bltz	a0,80024918 <sys_mkdir+0x4a>
    800248f0:	4601                	li	a2,0
    800248f2:	4585                	li	a1,1
    800248f4:	ed840513          	addi	a0,s0,-296
    800248f8:	00000097          	auipc	ra,0x0
    800248fc:	bf6080e7          	jalr	-1034(ra) # 800244ee <create>
    80024900:	84aa                	mv	s1,a0
    80024902:	c10d                	beqz	a0,80024924 <sys_mkdir+0x56>
    }
    eunlock(ep);
    80024904:	00002097          	auipc	ra,0x2
    80024908:	a2e080e7          	jalr	-1490(ra) # 80026332 <eunlock>
    eput(ep);
    8002490c:	8526                	mv	a0,s1
    8002490e:	00002097          	auipc	ra,0x2
    80024912:	a72080e7          	jalr	-1422(ra) # 80026380 <eput>
    return 0;
    80024916:	4781                	li	a5,0
}
    80024918:	853e                	mv	a0,a5
    8002491a:	70b2                	ld	ra,296(sp)
    8002491c:	7412                	ld	s0,288(sp)
    8002491e:	64f2                	ld	s1,280(sp)
    80024920:	6155                	addi	sp,sp,304
    80024922:	8082                	ret
        return -1;
    80024924:	57fd                	li	a5,-1
    80024926:	bfcd                	j	80024918 <sys_mkdir+0x4a>

0000000080024928 <sys_chdir>:

uint64
sys_chdir(void)
{
    80024928:	7169                	addi	sp,sp,-304
    8002492a:	f606                	sd	ra,296(sp)
    8002492c:	f222                	sd	s0,288(sp)
    8002492e:	ee26                	sd	s1,280(sp)
    80024930:	ea4a                	sd	s2,272(sp)
    80024932:	1a00                	addi	s0,sp,304
    char path[FAT32_MAX_PATH];
    struct dirent *ep;
    struct proc *p = myproc();
    80024934:	ffffd097          	auipc	ra,0xffffd
    80024938:	21e080e7          	jalr	542(ra) # 80021b52 <myproc>
    8002493c:	892a                	mv	s2,a0

    if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = ename(path)) == NULL){
    8002493e:	10400613          	li	a2,260
    80024942:	ed840593          	addi	a1,s0,-296
    80024946:	4501                	li	a0,0
    80024948:	ffffe097          	auipc	ra,0xffffe
    8002494c:	63e080e7          	jalr	1598(ra) # 80022f86 <argstr>
        return -1;
    80024950:	57fd                	li	a5,-1
    if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = ename(path)) == NULL){
    80024952:	04054063          	bltz	a0,80024992 <sys_chdir+0x6a>
    80024956:	ed840513          	addi	a0,s0,-296
    8002495a:	00002097          	auipc	ra,0x2
    8002495e:	148080e7          	jalr	328(ra) # 80026aa2 <ename>
    80024962:	84aa                	mv	s1,a0
    80024964:	c931                	beqz	a0,800249b8 <sys_chdir+0x90>
    }
    elock(ep);
    80024966:	00002097          	auipc	ra,0x2
    8002496a:	996080e7          	jalr	-1642(ra) # 800262fc <elock>
    if(!(ep->attribute & ATTR_DIRECTORY)){
    8002496e:	1004c783          	lbu	a5,256(s1)
    80024972:	8bc1                	andi	a5,a5,16
    80024974:	c795                	beqz	a5,800249a0 <sys_chdir+0x78>
        eunlock(ep);
        eput(ep);
        return -1;
    }
    eunlock(ep);
    80024976:	8526                	mv	a0,s1
    80024978:	00002097          	auipc	ra,0x2
    8002497c:	9ba080e7          	jalr	-1606(ra) # 80026332 <eunlock>
    eput(p->cwd);
    80024980:	15893503          	ld	a0,344(s2)
    80024984:	00002097          	auipc	ra,0x2
    80024988:	9fc080e7          	jalr	-1540(ra) # 80026380 <eput>
    p->cwd = ep;
    8002498c:	14993c23          	sd	s1,344(s2)
    return 0;
    80024990:	4781                	li	a5,0
}
    80024992:	853e                	mv	a0,a5
    80024994:	70b2                	ld	ra,296(sp)
    80024996:	7412                	ld	s0,288(sp)
    80024998:	64f2                	ld	s1,280(sp)
    8002499a:	6952                	ld	s2,272(sp)
    8002499c:	6155                	addi	sp,sp,304
    8002499e:	8082                	ret
        eunlock(ep);
    800249a0:	8526                	mv	a0,s1
    800249a2:	00002097          	auipc	ra,0x2
    800249a6:	990080e7          	jalr	-1648(ra) # 80026332 <eunlock>
        eput(ep);
    800249aa:	8526                	mv	a0,s1
    800249ac:	00002097          	auipc	ra,0x2
    800249b0:	9d4080e7          	jalr	-1580(ra) # 80026380 <eput>
        return -1;
    800249b4:	57fd                	li	a5,-1
    800249b6:	bff1                	j	80024992 <sys_chdir+0x6a>
        return -1;
    800249b8:	57fd                	li	a5,-1
    800249ba:	bfe1                	j	80024992 <sys_chdir+0x6a>

00000000800249bc <sys_pipe>:

uint64
sys_pipe(void)
{
    800249bc:	7139                	addi	sp,sp,-64
    800249be:	fc06                	sd	ra,56(sp)
    800249c0:	f822                	sd	s0,48(sp)
    800249c2:	f426                	sd	s1,40(sp)
    800249c4:	0080                	addi	s0,sp,64
    uint64 fdarray; // user pointer to array of two integers
    struct file *rf, *wf;
    int fd0, fd1;
    struct proc *p = myproc();
    800249c6:	ffffd097          	auipc	ra,0xffffd
    800249ca:	18c080e7          	jalr	396(ra) # 80021b52 <myproc>
    800249ce:	84aa                	mv	s1,a0

    if(argaddr(0, &fdarray) < 0)
    800249d0:	fd840593          	addi	a1,s0,-40
    800249d4:	4501                	li	a0,0
    800249d6:	ffffe097          	auipc	ra,0xffffe
    800249da:	58e080e7          	jalr	1422(ra) # 80022f64 <argaddr>
        return -1;
    800249de:	57fd                	li	a5,-1
    if(argaddr(0, &fdarray) < 0)
    800249e0:	0c054d63          	bltz	a0,80024aba <sys_pipe+0xfe>
    if(pipealloc(&rf, &wf) < 0)
    800249e4:	fc840593          	addi	a1,s0,-56
    800249e8:	fd040513          	addi	a0,s0,-48
    800249ec:	fffff097          	auipc	ra,0xfffff
    800249f0:	2b2080e7          	jalr	690(ra) # 80023c9e <pipealloc>
        return -1;
    800249f4:	57fd                	li	a5,-1
    if(pipealloc(&rf, &wf) < 0)
    800249f6:	0c054263          	bltz	a0,80024aba <sys_pipe+0xfe>
    fd0 = -1;
    800249fa:	fcf42223          	sw	a5,-60(s0)
    if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800249fe:	fd043503          	ld	a0,-48(s0)
    80024a02:	00000097          	auipc	ra,0x0
    80024a06:	aa4080e7          	jalr	-1372(ra) # 800244a6 <fdalloc>
    80024a0a:	fca42223          	sw	a0,-60(s0)
    80024a0e:	08054963          	bltz	a0,80024aa0 <sys_pipe+0xe4>
    80024a12:	fc843503          	ld	a0,-56(s0)
    80024a16:	00000097          	auipc	ra,0x0
    80024a1a:	a90080e7          	jalr	-1392(ra) # 800244a6 <fdalloc>
    80024a1e:	fca42023          	sw	a0,-64(s0)
    80024a22:	06054663          	bltz	a0,80024a8e <sys_pipe+0xd2>
        fileclose(wf);
        return -1;
    }
    // if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    //    copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80024a26:	4611                	li	a2,4
    80024a28:	fc440593          	addi	a1,s0,-60
    80024a2c:	fd843503          	ld	a0,-40(s0)
    80024a30:	ffffd097          	auipc	ra,0xffffd
    80024a34:	a28080e7          	jalr	-1496(ra) # 80021458 <copyout2>
    80024a38:	00054f63          	bltz	a0,80024a56 <sys_pipe+0x9a>
       copyout2(fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80024a3c:	4611                	li	a2,4
    80024a3e:	fc040593          	addi	a1,s0,-64
    80024a42:	fd843503          	ld	a0,-40(s0)
    80024a46:	0511                	addi	a0,a0,4
    80024a48:	ffffd097          	auipc	ra,0xffffd
    80024a4c:	a10080e7          	jalr	-1520(ra) # 80021458 <copyout2>
        p->ofile[fd1] = 0;
        fileclose(rf);
        fileclose(wf);
        return -1;
    }
    return 0;
    80024a50:	4781                	li	a5,0
    if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80024a52:	06055463          	bgez	a0,80024aba <sys_pipe+0xfe>
        p->ofile[fd0] = 0;
    80024a56:	fc442783          	lw	a5,-60(s0)
    80024a5a:	07e9                	addi	a5,a5,26
    80024a5c:	078e                	slli	a5,a5,0x3
    80024a5e:	97a6                	add	a5,a5,s1
    80024a60:	0007b423          	sd	zero,8(a5)
        p->ofile[fd1] = 0;
    80024a64:	fc042783          	lw	a5,-64(s0)
    80024a68:	07e9                	addi	a5,a5,26
    80024a6a:	078e                	slli	a5,a5,0x3
    80024a6c:	94be                	add	s1,s1,a5
    80024a6e:	0004b423          	sd	zero,8(s1)
        fileclose(rf);
    80024a72:	fd043503          	ld	a0,-48(s0)
    80024a76:	fffff097          	auipc	ra,0xfffff
    80024a7a:	ec0080e7          	jalr	-320(ra) # 80023936 <fileclose>
        fileclose(wf);
    80024a7e:	fc843503          	ld	a0,-56(s0)
    80024a82:	fffff097          	auipc	ra,0xfffff
    80024a86:	eb4080e7          	jalr	-332(ra) # 80023936 <fileclose>
        return -1;
    80024a8a:	57fd                	li	a5,-1
    80024a8c:	a03d                	j	80024aba <sys_pipe+0xfe>
        if(fd0 >= 0)
    80024a8e:	fc442783          	lw	a5,-60(s0)
    80024a92:	0007c763          	bltz	a5,80024aa0 <sys_pipe+0xe4>
            p->ofile[fd0] = 0;
    80024a96:	07e9                	addi	a5,a5,26
    80024a98:	078e                	slli	a5,a5,0x3
    80024a9a:	94be                	add	s1,s1,a5
    80024a9c:	0004b423          	sd	zero,8(s1)
        fileclose(rf);
    80024aa0:	fd043503          	ld	a0,-48(s0)
    80024aa4:	fffff097          	auipc	ra,0xfffff
    80024aa8:	e92080e7          	jalr	-366(ra) # 80023936 <fileclose>
        fileclose(wf);
    80024aac:	fc843503          	ld	a0,-56(s0)
    80024ab0:	fffff097          	auipc	ra,0xfffff
    80024ab4:	e86080e7          	jalr	-378(ra) # 80023936 <fileclose>
        return -1;
    80024ab8:	57fd                	li	a5,-1
}
    80024aba:	853e                	mv	a0,a5
    80024abc:	70e2                	ld	ra,56(sp)
    80024abe:	7442                	ld	s0,48(sp)
    80024ac0:	74a2                	ld	s1,40(sp)
    80024ac2:	6121                	addi	sp,sp,64
    80024ac4:	8082                	ret

0000000080024ac6 <sys_dev>:

// To open console device.
uint64
sys_dev(void)
{
    80024ac6:	7179                	addi	sp,sp,-48
    80024ac8:	f406                	sd	ra,40(sp)
    80024aca:	f022                	sd	s0,32(sp)
    80024acc:	ec26                	sd	s1,24(sp)
    80024ace:	1800                	addi	s0,sp,48
    int fd, omode;
    int major, minor;
    struct file *f;

    if(argint(0, &omode) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0){
    80024ad0:	fdc40593          	addi	a1,s0,-36
    80024ad4:	4501                	li	a0,0
    80024ad6:	ffffe097          	auipc	ra,0xffffe
    80024ada:	42c080e7          	jalr	1068(ra) # 80022f02 <argint>
    80024ade:	08054a63          	bltz	a0,80024b72 <sys_dev+0xac>
    80024ae2:	fd840593          	addi	a1,s0,-40
    80024ae6:	4505                	li	a0,1
    80024ae8:	ffffe097          	auipc	ra,0xffffe
    80024aec:	41a080e7          	jalr	1050(ra) # 80022f02 <argint>
    80024af0:	08054763          	bltz	a0,80024b7e <sys_dev+0xb8>
    80024af4:	fd440593          	addi	a1,s0,-44
    80024af8:	4509                	li	a0,2
    80024afa:	ffffe097          	auipc	ra,0xffffe
    80024afe:	408080e7          	jalr	1032(ra) # 80022f02 <argint>
    80024b02:	08054063          	bltz	a0,80024b82 <sys_dev+0xbc>
        return -1;
    }

    if(omode & O_CREATE){
    80024b06:	fdc42783          	lw	a5,-36(s0)
    80024b0a:	0407f793          	andi	a5,a5,64
    80024b0e:	ebb1                	bnez	a5,80024b62 <sys_dev+0x9c>
        panic("dev file on FAT");
    }

    if(major < 0 || major >= NDEV)
    80024b10:	fd842703          	lw	a4,-40(s0)
    80024b14:	47a5                	li	a5,9
        return -1;
    80024b16:	557d                	li	a0,-1
    if(major < 0 || major >= NDEV)
    80024b18:	04e7ee63          	bltu	a5,a4,80024b74 <sys_dev+0xae>

    if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    80024b1c:	fffff097          	auipc	ra,0xfffff
    80024b20:	d4a080e7          	jalr	-694(ra) # 80023866 <filealloc>
    80024b24:	84aa                	mv	s1,a0
    80024b26:	c125                	beqz	a0,80024b86 <sys_dev+0xc0>
    80024b28:	00000097          	auipc	ra,0x0
    80024b2c:	97e080e7          	jalr	-1666(ra) # 800244a6 <fdalloc>
    80024b30:	04054d63          	bltz	a0,80024b8a <sys_dev+0xc4>
        if(f)
            fileclose(f);
        return -1;
    }

    f->type = FD_DEVICE;
    80024b34:	478d                	li	a5,3
    80024b36:	c09c                	sw	a5,0(s1)
    f->off = 0;
    80024b38:	0204a023          	sw	zero,32(s1)
    f->ep = 0;
    80024b3c:	0004bc23          	sd	zero,24(s1)
    f->major = major;
    80024b40:	fd842783          	lw	a5,-40(s0)
    80024b44:	02f49223          	sh	a5,36(s1)
    f->readable = !(omode & O_WRONLY);
    80024b48:	fdc42783          	lw	a5,-36(s0)
    80024b4c:	0017c713          	xori	a4,a5,1
    80024b50:	8b05                	andi	a4,a4,1
    80024b52:	00e48423          	sb	a4,8(s1)
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80024b56:	8b8d                	andi	a5,a5,3
    80024b58:	00f037b3          	snez	a5,a5
    80024b5c:	00f484a3          	sb	a5,9(s1)

    return fd;
    80024b60:	a811                	j	80024b74 <sys_dev+0xae>
        panic("dev file on FAT");
    80024b62:	00008517          	auipc	a0,0x8
    80024b66:	80e50513          	addi	a0,a0,-2034 # 8002c370 <syscalls+0xa08>
    80024b6a:	ffffb097          	auipc	ra,0xffffb
    80024b6e:	5dc080e7          	jalr	1500(ra) # 80020146 <panic>
        return -1;
    80024b72:	557d                	li	a0,-1
}
    80024b74:	70a2                	ld	ra,40(sp)
    80024b76:	7402                	ld	s0,32(sp)
    80024b78:	64e2                	ld	s1,24(sp)
    80024b7a:	6145                	addi	sp,sp,48
    80024b7c:	8082                	ret
        return -1;
    80024b7e:	557d                	li	a0,-1
    80024b80:	bfd5                	j	80024b74 <sys_dev+0xae>
    80024b82:	557d                	li	a0,-1
    80024b84:	bfc5                	j	80024b74 <sys_dev+0xae>
        return -1;
    80024b86:	557d                	li	a0,-1
    80024b88:	b7f5                	j	80024b74 <sys_dev+0xae>
            fileclose(f);
    80024b8a:	8526                	mv	a0,s1
    80024b8c:	fffff097          	auipc	ra,0xfffff
    80024b90:	daa080e7          	jalr	-598(ra) # 80023936 <fileclose>
        return -1;
    80024b94:	557d                	li	a0,-1
    80024b96:	bff9                	j	80024b74 <sys_dev+0xae>

0000000080024b98 <sys_readdir>:

// To support ls command
uint64
sys_readdir(void)
{
    80024b98:	1101                	addi	sp,sp,-32
    80024b9a:	ec06                	sd	ra,24(sp)
    80024b9c:	e822                	sd	s0,16(sp)
    80024b9e:	1000                	addi	s0,sp,32
    struct file *f;
    uint64 p;

    if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024ba0:	fe840613          	addi	a2,s0,-24
    80024ba4:	4581                	li	a1,0
    80024ba6:	4501                	li	a0,0
    80024ba8:	00000097          	auipc	ra,0x0
    80024bac:	896080e7          	jalr	-1898(ra) # 8002443e <argfd>
        return -1;
    80024bb0:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024bb2:	02054563          	bltz	a0,80024bdc <sys_readdir+0x44>
    80024bb6:	fe040593          	addi	a1,s0,-32
    80024bba:	4505                	li	a0,1
    80024bbc:	ffffe097          	auipc	ra,0xffffe
    80024bc0:	3a8080e7          	jalr	936(ra) # 80022f64 <argaddr>
        return -1;
    80024bc4:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024bc6:	00054b63          	bltz	a0,80024bdc <sys_readdir+0x44>
    return dirnext(f, p);
    80024bca:	fe043583          	ld	a1,-32(s0)
    80024bce:	fe843503          	ld	a0,-24(s0)
    80024bd2:	fffff097          	auipc	ra,0xfffff
    80024bd6:	00e080e7          	jalr	14(ra) # 80023be0 <dirnext>
    80024bda:	87aa                	mv	a5,a0
}
    80024bdc:	853e                	mv	a0,a5
    80024bde:	60e2                	ld	ra,24(sp)
    80024be0:	6442                	ld	s0,16(sp)
    80024be2:	6105                	addi	sp,sp,32
    80024be4:	8082                	ret

0000000080024be6 <sys_getcwd>:

// get absolute cwd string
uint64
sys_getcwd(void)
{
    80024be6:	714d                	addi	sp,sp,-336
    80024be8:	e686                	sd	ra,328(sp)
    80024bea:	e2a2                	sd	s0,320(sp)
    80024bec:	fe26                	sd	s1,312(sp)
    80024bee:	fa4a                	sd	s2,304(sp)
    80024bf0:	f64e                	sd	s3,296(sp)
    80024bf2:	f252                	sd	s4,288(sp)
    80024bf4:	ee56                	sd	s5,280(sp)
    80024bf6:	0a80                	addi	s0,sp,336
    uint64 addr;
    if (argaddr(0, &addr) < 0)
    80024bf8:	fb840593          	addi	a1,s0,-72
    80024bfc:	4501                	li	a0,0
    80024bfe:	ffffe097          	auipc	ra,0xffffe
    80024c02:	366080e7          	jalr	870(ra) # 80022f64 <argaddr>
        return -1;
    80024c06:	57fd                	li	a5,-1
    if (argaddr(0, &addr) < 0)
    80024c08:	08054063          	bltz	a0,80024c88 <sys_getcwd+0xa2>

    struct dirent *de = myproc()->cwd;
    80024c0c:	ffffd097          	auipc	ra,0xffffd
    80024c10:	f46080e7          	jalr	-186(ra) # 80021b52 <myproc>
    80024c14:	15853483          	ld	s1,344(a0)
    char path[FAT32_MAX_PATH];
    char *s;
    int len;

    if (de->parent == NULL) {
    80024c18:	1204b783          	ld	a5,288(s1)
    80024c1c:	c3c1                	beqz	a5,80024c9c <sys_getcwd+0xb6>
        s = "/";
    } else {
        s = path + FAT32_MAX_PATH - 1;
        *s = '\0';
    80024c1e:	fa0409a3          	sb	zero,-77(s0)
        s = path + FAT32_MAX_PATH - 1;
    80024c22:	fb340993          	addi	s3,s0,-77
        while (de->parent) {
            len = strlen(de->filename);
            s -= len;
            if (s <= path)          // can't reach root "/"
    80024c26:	eb040a13          	addi	s4,s0,-336
                return -1;
            strncpy(s, de->filename, len);
            *--s = '/';
    80024c2a:	02f00a93          	li	s5,47
            len = strlen(de->filename);
    80024c2e:	8526                	mv	a0,s1
    80024c30:	ffffc097          	auipc	ra,0xffffc
    80024c34:	cd6080e7          	jalr	-810(ra) # 80020906 <strlen>
            s -= len;
    80024c38:	40a98933          	sub	s2,s3,a0
            if (s <= path)          // can't reach root "/"
    80024c3c:	072a7563          	bgeu	s4,s2,80024ca6 <sys_getcwd+0xc0>
            strncpy(s, de->filename, len);
    80024c40:	862a                	mv	a2,a0
    80024c42:	85a6                	mv	a1,s1
    80024c44:	854a                	mv	a0,s2
    80024c46:	ffffc097          	auipc	ra,0xffffc
    80024c4a:	c4e080e7          	jalr	-946(ra) # 80020894 <strncpy>
            *--s = '/';
    80024c4e:	fff90993          	addi	s3,s2,-1
    80024c52:	ff590fa3          	sb	s5,-1(s2)
            de = de->parent;
    80024c56:	1204b483          	ld	s1,288(s1)
        while (de->parent) {
    80024c5a:	1204b783          	ld	a5,288(s1)
    80024c5e:	fbe1                	bnez	a5,80024c2e <sys_getcwd+0x48>
        }
    }

    // if (copyout(myproc()->pagetable, addr, s, strlen(s) + 1) < 0)
    if (copyout2(addr, s, strlen(s) + 1) < 0)
    80024c60:	fb843483          	ld	s1,-72(s0)
    80024c64:	854e                	mv	a0,s3
    80024c66:	ffffc097          	auipc	ra,0xffffc
    80024c6a:	ca0080e7          	jalr	-864(ra) # 80020906 <strlen>
    80024c6e:	0015061b          	addiw	a2,a0,1
    80024c72:	85ce                	mv	a1,s3
    80024c74:	8526                	mv	a0,s1
    80024c76:	ffffc097          	auipc	ra,0xffffc
    80024c7a:	7e2080e7          	jalr	2018(ra) # 80021458 <copyout2>
        return NULL;
    80024c7e:	4781                	li	a5,0
    if (copyout2(addr, s, strlen(s) + 1) < 0)
    80024c80:	00054463          	bltz	a0,80024c88 <sys_getcwd+0xa2>

    return addr;
    80024c84:	fb843783          	ld	a5,-72(s0)

}
    80024c88:	853e                	mv	a0,a5
    80024c8a:	60b6                	ld	ra,328(sp)
    80024c8c:	6416                	ld	s0,320(sp)
    80024c8e:	74f2                	ld	s1,312(sp)
    80024c90:	7952                	ld	s2,304(sp)
    80024c92:	79b2                	ld	s3,296(sp)
    80024c94:	7a12                	ld	s4,288(sp)
    80024c96:	6af2                	ld	s5,280(sp)
    80024c98:	6171                	addi	sp,sp,336
    80024c9a:	8082                	ret
        s = "/";
    80024c9c:	00007997          	auipc	s3,0x7
    80024ca0:	8c498993          	addi	s3,s3,-1852 # 8002b560 <states.1738+0xf8>
    80024ca4:	bf75                	j	80024c60 <sys_getcwd+0x7a>
                return -1;
    80024ca6:	57fd                	li	a5,-1
    80024ca8:	b7c5                	j	80024c88 <sys_getcwd+0xa2>

0000000080024caa <sys_remove>:
    return ret == -1;
}

uint64
sys_remove(void)
{
    80024caa:	d6010113          	addi	sp,sp,-672
    80024cae:	28113c23          	sd	ra,664(sp)
    80024cb2:	28813823          	sd	s0,656(sp)
    80024cb6:	28913423          	sd	s1,648(sp)
    80024cba:	1500                	addi	s0,sp,672
    char path[FAT32_MAX_PATH];
    struct dirent *ep;
    int len;
    if((len = argstr(0, path, FAT32_MAX_PATH)) <= 0)
    80024cbc:	10400613          	li	a2,260
    80024cc0:	ed840593          	addi	a1,s0,-296
    80024cc4:	4501                	li	a0,0
    80024cc6:	ffffe097          	auipc	ra,0xffffe
    80024cca:	2c0080e7          	jalr	704(ra) # 80022f86 <argstr>
    80024cce:	0ea05f63          	blez	a0,80024dcc <sys_remove+0x122>
        return -1;

    char *s = path + len - 1;
    80024cd2:	ed840793          	addi	a5,s0,-296
    80024cd6:	157d                	addi	a0,a0,-1
    80024cd8:	953e                	add	a0,a0,a5
    while (s >= path && *s == '/') {
    80024cda:	02f56c63          	bltu	a0,a5,80024d12 <sys_remove+0x68>
    80024cde:	00054703          	lbu	a4,0(a0)
    80024ce2:	02f00793          	li	a5,47
    80024ce6:	02f71063          	bne	a4,a5,80024d06 <sys_remove+0x5c>
    80024cea:	fff50793          	addi	a5,a0,-1
    80024cee:	ed740693          	addi	a3,s0,-297
    80024cf2:	02f00613          	li	a2,47
        s--;
    80024cf6:	853e                	mv	a0,a5
    while (s >= path && *s == '/') {
    80024cf8:	00d78d63          	beq	a5,a3,80024d12 <sys_remove+0x68>
    80024cfc:	17fd                	addi	a5,a5,-1
    80024cfe:	0017c703          	lbu	a4,1(a5)
    80024d02:	fec70ae3          	beq	a4,a2,80024cf6 <sys_remove+0x4c>
    }
    if (s >= path && *s == '.' && (s == path || *--s == '/')) {
    80024d06:	00054703          	lbu	a4,0(a0)
    80024d0a:	02e00793          	li	a5,46
    80024d0e:	08f70763          	beq	a4,a5,80024d9c <sys_remove+0xf2>
        return -1;
    }

    if((ep = ename(path)) == NULL){
    80024d12:	ed840513          	addi	a0,s0,-296
    80024d16:	00002097          	auipc	ra,0x2
    80024d1a:	d8c080e7          	jalr	-628(ra) # 80026aa2 <ename>
    80024d1e:	84aa                	mv	s1,a0
    80024d20:	c955                	beqz	a0,80024dd4 <sys_remove+0x12a>
        return -1;
    }
    elock(ep);
    80024d22:	00001097          	auipc	ra,0x1
    80024d26:	5da080e7          	jalr	1498(ra) # 800262fc <elock>
    if((ep->attribute & ATTR_DIRECTORY) && !isdirempty(ep)){
    80024d2a:	1004c783          	lbu	a5,256(s1)
    80024d2e:	8bc1                	andi	a5,a5,16
    80024d30:	c38d                	beqz	a5,80024d52 <sys_remove+0xa8>
    ep.valid = 0;
    80024d32:	e8041323          	sh	zero,-378(s0)
    ret = enext(dp, &ep, 2 * 32, &count);   // skip the "." and ".."
    80024d36:	d6c40693          	addi	a3,s0,-660
    80024d3a:	04000613          	li	a2,64
    80024d3e:	d7040593          	addi	a1,s0,-656
    80024d42:	8526                	mv	a0,s1
    80024d44:	00001097          	auipc	ra,0x1
    80024d48:	7bc080e7          	jalr	1980(ra) # 80026500 <enext>
    if((ep->attribute & ATTR_DIRECTORY) && !isdirempty(ep)){
    80024d4c:	57fd                	li	a5,-1
    80024d4e:	06f51363          	bne	a0,a5,80024db4 <sys_remove+0x10a>
        eunlock(ep);
        eput(ep);
        return -1;
    }
    elock(ep->parent);      // Will this lead to deadlock?
    80024d52:	1204b503          	ld	a0,288(s1)
    80024d56:	00001097          	auipc	ra,0x1
    80024d5a:	5a6080e7          	jalr	1446(ra) # 800262fc <elock>
    eremove(ep);
    80024d5e:	8526                	mv	a0,s1
    80024d60:	00001097          	auipc	ra,0x1
    80024d64:	470080e7          	jalr	1136(ra) # 800261d0 <eremove>
    eunlock(ep->parent);
    80024d68:	1204b503          	ld	a0,288(s1)
    80024d6c:	00001097          	auipc	ra,0x1
    80024d70:	5c6080e7          	jalr	1478(ra) # 80026332 <eunlock>
    eunlock(ep);
    80024d74:	8526                	mv	a0,s1
    80024d76:	00001097          	auipc	ra,0x1
    80024d7a:	5bc080e7          	jalr	1468(ra) # 80026332 <eunlock>
    eput(ep);
    80024d7e:	8526                	mv	a0,s1
    80024d80:	00001097          	auipc	ra,0x1
    80024d84:	600080e7          	jalr	1536(ra) # 80026380 <eput>

    return 0;
    80024d88:	4501                	li	a0,0
}
    80024d8a:	29813083          	ld	ra,664(sp)
    80024d8e:	29013403          	ld	s0,656(sp)
    80024d92:	28813483          	ld	s1,648(sp)
    80024d96:	2a010113          	addi	sp,sp,672
    80024d9a:	8082                	ret
    if (s >= path && *s == '.' && (s == path || *--s == '/')) {
    80024d9c:	ed840793          	addi	a5,s0,-296
    80024da0:	02f50863          	beq	a0,a5,80024dd0 <sys_remove+0x126>
    80024da4:	fff54703          	lbu	a4,-1(a0)
    80024da8:	02f00793          	li	a5,47
    80024dac:	f6f713e3          	bne	a4,a5,80024d12 <sys_remove+0x68>
        return -1;
    80024db0:	557d                	li	a0,-1
    80024db2:	bfe1                	j	80024d8a <sys_remove+0xe0>
        eunlock(ep);
    80024db4:	8526                	mv	a0,s1
    80024db6:	00001097          	auipc	ra,0x1
    80024dba:	57c080e7          	jalr	1404(ra) # 80026332 <eunlock>
        eput(ep);
    80024dbe:	8526                	mv	a0,s1
    80024dc0:	00001097          	auipc	ra,0x1
    80024dc4:	5c0080e7          	jalr	1472(ra) # 80026380 <eput>
        return -1;
    80024dc8:	557d                	li	a0,-1
    80024dca:	b7c1                	j	80024d8a <sys_remove+0xe0>
        return -1;
    80024dcc:	557d                	li	a0,-1
    80024dce:	bf75                	j	80024d8a <sys_remove+0xe0>
        return -1;
    80024dd0:	557d                	li	a0,-1
    80024dd2:	bf65                	j	80024d8a <sys_remove+0xe0>
        return -1;
    80024dd4:	557d                	li	a0,-1
    80024dd6:	bf55                	j	80024d8a <sys_remove+0xe0>

0000000080024dd8 <sys_rename>:

// Must hold too many locks at a time! It's possible to raise a deadlock.
// Because this op takes some steps, we can't promise
uint64
sys_rename(void)
{
    80024dd8:	c4010113          	addi	sp,sp,-960
    80024ddc:	3a113c23          	sd	ra,952(sp)
    80024de0:	3a813823          	sd	s0,944(sp)
    80024de4:	3a913423          	sd	s1,936(sp)
    80024de8:	3b213023          	sd	s2,928(sp)
    80024dec:	39313c23          	sd	s3,920(sp)
    80024df0:	39413823          	sd	s4,912(sp)
    80024df4:	0780                	addi	s0,sp,960
    char old[FAT32_MAX_PATH], new[FAT32_MAX_PATH];
    if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024df6:	10400613          	li	a2,260
    80024dfa:	ec840593          	addi	a1,s0,-312
    80024dfe:	4501                	li	a0,0
    80024e00:	ffffe097          	auipc	ra,0xffffe
    80024e04:	186080e7          	jalr	390(ra) # 80022f86 <argstr>
        return -1;
    80024e08:	57fd                	li	a5,-1
    if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024e0a:	0c054d63          	bltz	a0,80024ee4 <sys_rename+0x10c>
    80024e0e:	10400613          	li	a2,260
    80024e12:	dc040593          	addi	a1,s0,-576
    80024e16:	4505                	li	a0,1
    80024e18:	ffffe097          	auipc	ra,0xffffe
    80024e1c:	16e080e7          	jalr	366(ra) # 80022f86 <argstr>
        return -1;
    80024e20:	57fd                	li	a5,-1
    if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024e22:	0c054163          	bltz	a0,80024ee4 <sys_rename+0x10c>
    }

    struct dirent *src = NULL, *dst = NULL, *pdst = NULL;
    int srclock = 0;
    char *name;
    if ((src = ename(old)) == NULL || (pdst = enameparent(new, old)) == NULL
    80024e26:	ec840513          	addi	a0,s0,-312
    80024e2a:	00002097          	auipc	ra,0x2
    80024e2e:	c78080e7          	jalr	-904(ra) # 80026aa2 <ename>
    80024e32:	84aa                	mv	s1,a0
    80024e34:	1c050963          	beqz	a0,80025006 <sys_rename+0x22e>
    80024e38:	ec840593          	addi	a1,s0,-312
    80024e3c:	dc040513          	addi	a0,s0,-576
    80024e40:	00002097          	auipc	ra,0x2
    80024e44:	c80080e7          	jalr	-896(ra) # 80026ac0 <enameparent>
    80024e48:	892a                	mv	s2,a0
    80024e4a:	cd35                	beqz	a0,80024ec6 <sys_rename+0xee>
        || (name = formatname(old)) == NULL) {
    80024e4c:	ec840513          	addi	a0,s0,-312
    80024e50:	00001097          	auipc	ra,0x1
    80024e54:	e00080e7          	jalr	-512(ra) # 80025c50 <formatname>
    80024e58:	8a2a                	mv	s4,a0
    80024e5a:	c535                	beqz	a0,80024ec6 <sys_rename+0xee>
        goto fail;          // src doesn't exist || dst parent doesn't exist || illegal new name
    }
    for (struct dirent *ep = pdst; ep != NULL; ep = ep->parent) {
        if (ep == src) {    // In what universe can we move a directory into its child?
    80024e5c:	07248563          	beq	s1,s2,80024ec6 <sys_rename+0xee>
    for (struct dirent *ep = pdst; ep != NULL; ep = ep->parent) {
    80024e60:	87ca                	mv	a5,s2
    80024e62:	1207b783          	ld	a5,288(a5)
    80024e66:	c781                	beqz	a5,80024e6e <sys_rename+0x96>
        if (ep == src) {    // In what universe can we move a directory into its child?
    80024e68:	fef49de3          	bne	s1,a5,80024e62 <sys_rename+0x8a>
    80024e6c:	a8a9                	j	80024ec6 <sys_rename+0xee>
            goto fail;
        }
    }

    uint off;
    elock(src);     // must hold child's lock before acquiring parent's, because we do so in other similar cases
    80024e6e:	8526                	mv	a0,s1
    80024e70:	00001097          	auipc	ra,0x1
    80024e74:	48c080e7          	jalr	1164(ra) # 800262fc <elock>
    srclock = 1;
    elock(pdst);
    80024e78:	854a                	mv	a0,s2
    80024e7a:	00001097          	auipc	ra,0x1
    80024e7e:	482080e7          	jalr	1154(ra) # 800262fc <elock>
    dst = dirlookup(pdst, name, &off);
    80024e82:	dbc40613          	addi	a2,s0,-580
    80024e86:	85d2                	mv	a1,s4
    80024e88:	854a                	mv	a0,s2
    80024e8a:	00002097          	auipc	ra,0x2
    80024e8e:	802080e7          	jalr	-2046(ra) # 8002668c <dirlookup>
    80024e92:	89aa                	mv	s3,a0
    if (dst != NULL) {
    80024e94:	cd45                	beqz	a0,80024f4c <sys_rename+0x174>
        eunlock(pdst);
    80024e96:	854a                	mv	a0,s2
    80024e98:	00001097          	auipc	ra,0x1
    80024e9c:	49a080e7          	jalr	1178(ra) # 80026332 <eunlock>
        if (src == dst) {
    80024ea0:	01348963          	beq	s1,s3,80024eb2 <sys_rename+0xda>
            goto fail;
        } else if (src->attribute & dst->attribute & ATTR_DIRECTORY) {
    80024ea4:	1004c783          	lbu	a5,256(s1)
    80024ea8:	1009c703          	lbu	a4,256(s3)
    80024eac:	8ff9                	and	a5,a5,a4
    80024eae:	8bc1                	andi	a5,a5,16
    80024eb0:	ebb1                	bnez	a5,80024f04 <sys_rename+0x12c>

    return 0;

    fail:
    if (srclock)
        eunlock(src);
    80024eb2:	8526                	mv	a0,s1
    80024eb4:	00001097          	auipc	ra,0x1
    80024eb8:	47e080e7          	jalr	1150(ra) # 80026332 <eunlock>
    if (dst)
        eput(dst);
    80024ebc:	854e                	mv	a0,s3
    80024ebe:	00001097          	auipc	ra,0x1
    80024ec2:	4c2080e7          	jalr	1218(ra) # 80026380 <eput>
    if (pdst)
    80024ec6:	00090763          	beqz	s2,80024ed4 <sys_rename+0xfc>
        eput(pdst);
    80024eca:	854a                	mv	a0,s2
    80024ecc:	00001097          	auipc	ra,0x1
    80024ed0:	4b4080e7          	jalr	1204(ra) # 80026380 <eput>
    if (src)
        eput(src);
    return -1;
    80024ed4:	57fd                	li	a5,-1
    if (src)
    80024ed6:	c499                	beqz	s1,80024ee4 <sys_rename+0x10c>
        eput(src);
    80024ed8:	8526                	mv	a0,s1
    80024eda:	00001097          	auipc	ra,0x1
    80024ede:	4a6080e7          	jalr	1190(ra) # 80026380 <eput>
    return -1;
    80024ee2:	57fd                	li	a5,-1
}
    80024ee4:	853e                	mv	a0,a5
    80024ee6:	3b813083          	ld	ra,952(sp)
    80024eea:	3b013403          	ld	s0,944(sp)
    80024eee:	3a813483          	ld	s1,936(sp)
    80024ef2:	3a013903          	ld	s2,928(sp)
    80024ef6:	39813983          	ld	s3,920(sp)
    80024efa:	39013a03          	ld	s4,912(sp)
    80024efe:	3c010113          	addi	sp,sp,960
    80024f02:	8082                	ret
            elock(dst);
    80024f04:	854e                	mv	a0,s3
    80024f06:	00001097          	auipc	ra,0x1
    80024f0a:	3f6080e7          	jalr	1014(ra) # 800262fc <elock>
    ep.valid = 0;
    80024f0e:	d6041323          	sh	zero,-666(s0)
    ret = enext(dp, &ep, 2 * 32, &count);   // skip the "." and ".."
    80024f12:	c4c40693          	addi	a3,s0,-948
    80024f16:	04000613          	li	a2,64
    80024f1a:	c5040593          	addi	a1,s0,-944
    80024f1e:	854e                	mv	a0,s3
    80024f20:	00001097          	auipc	ra,0x1
    80024f24:	5e0080e7          	jalr	1504(ra) # 80026500 <enext>
            if (!isdirempty(dst)) {    // it's ok to overwrite an empty dir
    80024f28:	57fd                	li	a5,-1
    80024f2a:	0cf51863          	bne	a0,a5,80024ffa <sys_rename+0x222>
            elock(pdst);
    80024f2e:	854a                	mv	a0,s2
    80024f30:	00001097          	auipc	ra,0x1
    80024f34:	3cc080e7          	jalr	972(ra) # 800262fc <elock>
        eremove(dst);
    80024f38:	854e                	mv	a0,s3
    80024f3a:	00001097          	auipc	ra,0x1
    80024f3e:	296080e7          	jalr	662(ra) # 800261d0 <eremove>
        eunlock(dst);
    80024f42:	854e                	mv	a0,s3
    80024f44:	00001097          	auipc	ra,0x1
    80024f48:	3ee080e7          	jalr	1006(ra) # 80026332 <eunlock>
    memmove(src->filename, name, FAT32_MAX_FILENAME);
    80024f4c:	0ff00613          	li	a2,255
    80024f50:	85d2                	mv	a1,s4
    80024f52:	8526                	mv	a0,s1
    80024f54:	ffffc097          	auipc	ra,0xffffc
    80024f58:	874080e7          	jalr	-1932(ra) # 800207c8 <memmove>
    emake(pdst, src, off);
    80024f5c:	dbc42603          	lw	a2,-580(s0)
    80024f60:	85a6                	mv	a1,s1
    80024f62:	854a                	mv	a0,s2
    80024f64:	00001097          	auipc	ra,0x1
    80024f68:	dac080e7          	jalr	-596(ra) # 80025d10 <emake>
    if (src->parent != pdst) {
    80024f6c:	1204b783          	ld	a5,288(s1)
    80024f70:	01278d63          	beq	a5,s2,80024f8a <sys_rename+0x1b2>
        eunlock(pdst);
    80024f74:	854a                	mv	a0,s2
    80024f76:	00001097          	auipc	ra,0x1
    80024f7a:	3bc080e7          	jalr	956(ra) # 80026332 <eunlock>
        elock(src->parent);
    80024f7e:	1204b503          	ld	a0,288(s1)
    80024f82:	00001097          	auipc	ra,0x1
    80024f86:	37a080e7          	jalr	890(ra) # 800262fc <elock>
    eremove(src);
    80024f8a:	8526                	mv	a0,s1
    80024f8c:	00001097          	auipc	ra,0x1
    80024f90:	244080e7          	jalr	580(ra) # 800261d0 <eremove>
    eunlock(src->parent);
    80024f94:	1204b503          	ld	a0,288(s1)
    80024f98:	00001097          	auipc	ra,0x1
    80024f9c:	39a080e7          	jalr	922(ra) # 80026332 <eunlock>
    struct dirent *psrc = src->parent;  // src must not be root, or it won't pass the for-loop test
    80024fa0:	1204ba03          	ld	s4,288(s1)
    src->parent = edup(pdst);
    80024fa4:	854a                	mv	a0,s2
    80024fa6:	00001097          	auipc	ra,0x1
    80024faa:	106080e7          	jalr	262(ra) # 800260ac <edup>
    80024fae:	12a4b023          	sd	a0,288(s1)
    src->off = off;
    80024fb2:	dbc42783          	lw	a5,-580(s0)
    80024fb6:	10f4ae23          	sw	a5,284(s1)
    src->valid = 1;
    80024fba:	4785                	li	a5,1
    80024fbc:	10f49b23          	sh	a5,278(s1)
    eunlock(src);
    80024fc0:	8526                	mv	a0,s1
    80024fc2:	00001097          	auipc	ra,0x1
    80024fc6:	370080e7          	jalr	880(ra) # 80026332 <eunlock>
    eput(psrc);
    80024fca:	8552                	mv	a0,s4
    80024fcc:	00001097          	auipc	ra,0x1
    80024fd0:	3b4080e7          	jalr	948(ra) # 80026380 <eput>
    if (dst) {
    80024fd4:	00098763          	beqz	s3,80024fe2 <sys_rename+0x20a>
        eput(dst);
    80024fd8:	854e                	mv	a0,s3
    80024fda:	00001097          	auipc	ra,0x1
    80024fde:	3a6080e7          	jalr	934(ra) # 80026380 <eput>
    eput(pdst);
    80024fe2:	854a                	mv	a0,s2
    80024fe4:	00001097          	auipc	ra,0x1
    80024fe8:	39c080e7          	jalr	924(ra) # 80026380 <eput>
    eput(src);
    80024fec:	8526                	mv	a0,s1
    80024fee:	00001097          	auipc	ra,0x1
    80024ff2:	392080e7          	jalr	914(ra) # 80026380 <eput>
    return 0;
    80024ff6:	4781                	li	a5,0
    80024ff8:	b5f5                	j	80024ee4 <sys_rename+0x10c>
                eunlock(dst);
    80024ffa:	854e                	mv	a0,s3
    80024ffc:	00001097          	auipc	ra,0x1
    80025000:	336080e7          	jalr	822(ra) # 80026332 <eunlock>
                goto fail;
    80025004:	b57d                	j	80024eb2 <sys_rename+0xda>
    struct dirent *src = NULL, *dst = NULL, *pdst = NULL;
    80025006:	892a                	mv	s2,a0
    if (dst)
    80025008:	bd7d                	j	80024ec6 <sys_rename+0xee>
    8002500a:	0000                	unimp
    8002500c:	0000                	unimp
	...

0000000080025010 <kernelvec>:
    80025010:	7111                	addi	sp,sp,-256
    80025012:	e006                	sd	ra,0(sp)
    80025014:	e40a                	sd	sp,8(sp)
    80025016:	e80e                	sd	gp,16(sp)
    80025018:	ec12                	sd	tp,24(sp)
    8002501a:	f016                	sd	t0,32(sp)
    8002501c:	f41a                	sd	t1,40(sp)
    8002501e:	f81e                	sd	t2,48(sp)
    80025020:	fc22                	sd	s0,56(sp)
    80025022:	e0a6                	sd	s1,64(sp)
    80025024:	e4aa                	sd	a0,72(sp)
    80025026:	e8ae                	sd	a1,80(sp)
    80025028:	ecb2                	sd	a2,88(sp)
    8002502a:	f0b6                	sd	a3,96(sp)
    8002502c:	f4ba                	sd	a4,104(sp)
    8002502e:	f8be                	sd	a5,112(sp)
    80025030:	fcc2                	sd	a6,120(sp)
    80025032:	e146                	sd	a7,128(sp)
    80025034:	e54a                	sd	s2,136(sp)
    80025036:	e94e                	sd	s3,144(sp)
    80025038:	ed52                	sd	s4,152(sp)
    8002503a:	f156                	sd	s5,160(sp)
    8002503c:	f55a                	sd	s6,168(sp)
    8002503e:	f95e                	sd	s7,176(sp)
    80025040:	fd62                	sd	s8,184(sp)
    80025042:	e1e6                	sd	s9,192(sp)
    80025044:	e5ea                	sd	s10,200(sp)
    80025046:	e9ee                	sd	s11,208(sp)
    80025048:	edf2                	sd	t3,216(sp)
    8002504a:	f1f6                	sd	t4,224(sp)
    8002504c:	f5fa                	sd	t5,232(sp)
    8002504e:	f9fe                	sd	t6,240(sp)
    80025050:	a35fd0ef          	jal	ra,80022a84 <kerneltrap>
    80025054:	6082                	ld	ra,0(sp)
    80025056:	6122                	ld	sp,8(sp)
    80025058:	61c2                	ld	gp,16(sp)
    8002505a:	7282                	ld	t0,32(sp)
    8002505c:	7322                	ld	t1,40(sp)
    8002505e:	73c2                	ld	t2,48(sp)
    80025060:	7462                	ld	s0,56(sp)
    80025062:	6486                	ld	s1,64(sp)
    80025064:	6526                	ld	a0,72(sp)
    80025066:	65c6                	ld	a1,80(sp)
    80025068:	6666                	ld	a2,88(sp)
    8002506a:	7686                	ld	a3,96(sp)
    8002506c:	7726                	ld	a4,104(sp)
    8002506e:	77c6                	ld	a5,112(sp)
    80025070:	7866                	ld	a6,120(sp)
    80025072:	688a                	ld	a7,128(sp)
    80025074:	692a                	ld	s2,136(sp)
    80025076:	69ca                	ld	s3,144(sp)
    80025078:	6a6a                	ld	s4,152(sp)
    8002507a:	7a8a                	ld	s5,160(sp)
    8002507c:	7b2a                	ld	s6,168(sp)
    8002507e:	7bca                	ld	s7,176(sp)
    80025080:	7c6a                	ld	s8,184(sp)
    80025082:	6c8e                	ld	s9,192(sp)
    80025084:	6d2e                	ld	s10,200(sp)
    80025086:	6dce                	ld	s11,208(sp)
    80025088:	6e6e                	ld	t3,216(sp)
    8002508a:	7e8e                	ld	t4,224(sp)
    8002508c:	7f2e                	ld	t5,232(sp)
    8002508e:	7fce                	ld	t6,240(sp)
    80025090:	6111                	addi	sp,sp,256
    80025092:	10200073          	sret
	...

000000008002509e <timerinit>:
#include "include/proc.h"

struct spinlock tickslock;
uint ticks;

void timerinit() {
    8002509e:	1141                	addi	sp,sp,-16
    800250a0:	e406                	sd	ra,8(sp)
    800250a2:	e022                	sd	s0,0(sp)
    800250a4:	0800                	addi	s0,sp,16
    initlock(&tickslock, "time");
    800250a6:	00007597          	auipc	a1,0x7
    800250aa:	2da58593          	addi	a1,a1,730 # 8002c380 <syscalls+0xa18>
    800250ae:	0001b517          	auipc	a0,0x1b
    800250b2:	35a50513          	addi	a0,a0,858 # 80040408 <tickslock>
    800250b6:	ffffb097          	auipc	ra,0xffffb
    800250ba:	5c6080e7          	jalr	1478(ra) # 8002067c <initlock>
    #ifdef DEBUG
    printf("timerinit\n");
    #endif
}
    800250be:	60a2                	ld	ra,8(sp)
    800250c0:	6402                	ld	s0,0(sp)
    800250c2:	0141                	addi	sp,sp,16
    800250c4:	8082                	ret

00000000800250c6 <set_next_timeout>:

void
set_next_timeout() {
    800250c6:	1141                	addi	sp,sp,-16
    800250c8:	e422                	sd	s0,8(sp)
    800250ca:	0800                	addi	s0,sp,16
  asm volatile("rdtime %0" : "=r" (x) );
    800250cc:	c0102573          	rdtime	a0
    // if comment the `printf` line below
    // the timer will not work.

    // this bug seems to disappear automatically
    // printf("");
    sbi_set_timer(r_time() + INTERVAL);
    800250d0:	001dc7b7          	lui	a5,0x1dc
    800250d4:	13078793          	addi	a5,a5,304 # 1dc130 <BASE_ADDRESS-0x7fe43ed0>
    800250d8:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
    800250da:	4581                	li	a1,0
    800250dc:	4601                	li	a2,0
    800250de:	4681                	li	a3,0
    800250e0:	4881                	li	a7,0
    800250e2:	00000073          	ecall
}
    800250e6:	6422                	ld	s0,8(sp)
    800250e8:	0141                	addi	sp,sp,16
    800250ea:	8082                	ret

00000000800250ec <timer_tick>:

void timer_tick() {
    800250ec:	1101                	addi	sp,sp,-32
    800250ee:	ec06                	sd	ra,24(sp)
    800250f0:	e822                	sd	s0,16(sp)
    800250f2:	e426                	sd	s1,8(sp)
    800250f4:	1000                	addi	s0,sp,32
    acquire(&tickslock);
    800250f6:	0001b497          	auipc	s1,0x1b
    800250fa:	31248493          	addi	s1,s1,786 # 80040408 <tickslock>
    800250fe:	8526                	mv	a0,s1
    80025100:	ffffb097          	auipc	ra,0xffffb
    80025104:	5c0080e7          	jalr	1472(ra) # 800206c0 <acquire>
    ticks++;
    80025108:	0001b517          	auipc	a0,0x1b
    8002510c:	31850513          	addi	a0,a0,792 # 80040420 <ticks>
    80025110:	411c                	lw	a5,0(a0)
    80025112:	2785                	addiw	a5,a5,1
    80025114:	c11c                	sw	a5,0(a0)
    wakeup(&ticks);
    80025116:	ffffd097          	auipc	ra,0xffffd
    8002511a:	440080e7          	jalr	1088(ra) # 80022556 <wakeup>
    release(&tickslock);
    8002511e:	8526                	mv	a0,s1
    80025120:	ffffb097          	auipc	ra,0xffffb
    80025124:	5f4080e7          	jalr	1524(ra) # 80020714 <release>
    set_next_timeout();
    80025128:	00000097          	auipc	ra,0x0
    8002512c:	f9e080e7          	jalr	-98(ra) # 800250c6 <set_next_timeout>
}
    80025130:	60e2                	ld	ra,24(sp)
    80025132:	6442                	ld	s0,16(sp)
    80025134:	64a2                	ld	s1,8(sp)
    80025136:	6105                	addi	sp,sp,32
    80025138:	8082                	ret

000000008002513a <disk_init>:
#else
#include "include/virtio.h"
#endif 

void disk_init(void)
{
    8002513a:	1141                	addi	sp,sp,-16
    8002513c:	e406                	sd	ra,8(sp)
    8002513e:	e022                	sd	s0,0(sp)
    80025140:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_init();
	#else 
	sdcard_init();
    80025142:	00003097          	auipc	ra,0x3
    80025146:	f54080e7          	jalr	-172(ra) # 80028096 <sdcard_init>
    #endif
}
    8002514a:	60a2                	ld	ra,8(sp)
    8002514c:	6402                	ld	s0,0(sp)
    8002514e:	0141                	addi	sp,sp,16
    80025150:	8082                	ret

0000000080025152 <disk_read>:

void disk_read(struct buf *b)
{
    80025152:	1141                	addi	sp,sp,-16
    80025154:	e406                	sd	ra,8(sp)
    80025156:	e022                	sd	s0,0(sp)
    80025158:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 0);
    #else 
	sdcard_read_sector(b->data, b->sectorno);
    8002515a:	454c                	lw	a1,12(a0)
    8002515c:	05850513          	addi	a0,a0,88
    80025160:	00003097          	auipc	ra,0x3
    80025164:	278080e7          	jalr	632(ra) # 800283d8 <sdcard_read_sector>
	#endif
}
    80025168:	60a2                	ld	ra,8(sp)
    8002516a:	6402                	ld	s0,0(sp)
    8002516c:	0141                	addi	sp,sp,16
    8002516e:	8082                	ret

0000000080025170 <disk_write>:

void disk_write(struct buf *b)
{
    80025170:	1141                	addi	sp,sp,-16
    80025172:	e406                	sd	ra,8(sp)
    80025174:	e022                	sd	s0,0(sp)
    80025176:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 1);
    #else 
	sdcard_write_sector(b->data, b->sectorno);
    80025178:	454c                	lw	a1,12(a0)
    8002517a:	05850513          	addi	a0,a0,88
    8002517e:	00003097          	auipc	ra,0x3
    80025182:	35e080e7          	jalr	862(ra) # 800284dc <sdcard_write_sector>
	#endif
}
    80025186:	60a2                	ld	ra,8(sp)
    80025188:	6402                	ld	s0,0(sp)
    8002518a:	0141                	addi	sp,sp,16
    8002518c:	8082                	ret

000000008002518e <disk_intr>:

void disk_intr(void)
{
    8002518e:	1141                	addi	sp,sp,-16
    80025190:	e406                	sd	ra,8(sp)
    80025192:	e022                	sd	s0,0(sp)
    80025194:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_intr();
    #else 
    dmac_intr(DMAC_CHANNEL0);
    80025196:	4501                	li	a0,0
    80025198:	00004097          	auipc	ra,0x4
    8002519c:	ae6080e7          	jalr	-1306(ra) # 80028c7e <dmac_intr>
    #endif
}
    800251a0:	60a2                	ld	ra,8(sp)
    800251a2:	6402                	ld	s0,0(sp)
    800251a4:	0141                	addi	sp,sp,16
    800251a6:	8082                	ret

00000000800251a8 <read_fat>:
/**
 * Read the FAT table content corresponded to the given cluster number.
 * @param   cluster     the number of cluster which you want to read its content in FAT table
 */
static uint32 read_fat(uint32 cluster)
{
    800251a8:	1101                	addi	sp,sp,-32
    800251aa:	ec06                	sd	ra,24(sp)
    800251ac:	e822                	sd	s0,16(sp)
    800251ae:	e426                	sd	s1,8(sp)
    800251b0:	e04a                	sd	s2,0(sp)
    800251b2:	1000                	addi	s0,sp,32
    if (cluster >= FAT32_EOC) {
    800251b4:	100007b7          	lui	a5,0x10000
    800251b8:	17dd                	addi	a5,a5,-9
        return cluster;
    800251ba:	84aa                	mv	s1,a0
    if (cluster >= FAT32_EOC) {
    800251bc:	00a7eb63          	bltu	a5,a0,800251d2 <read_fat+0x2a>
    }
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    800251c0:	0001b797          	auipc	a5,0x1b
    800251c4:	26878793          	addi	a5,a5,616 # 80040428 <fat>
    800251c8:	479c                	lw	a5,8(a5)
    800251ca:	2785                	addiw	a5,a5,1
        return 0;
    800251cc:	4481                	li	s1,0
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    800251ce:	00a7f963          	bgeu	a5,a0,800251e0 <read_fat+0x38>
    // here should be a cache layer for FAT table, but not implemented yet.
    struct buf *b = bread(0, fat_sec);
    uint32 next_clus = *(uint32 *)(b->data + fat_offset_of_clus(cluster));
    brelse(b);
    return next_clus;
}
    800251d2:	8526                	mv	a0,s1
    800251d4:	60e2                	ld	ra,24(sp)
    800251d6:	6442                	ld	s0,16(sp)
    800251d8:	64a2                	ld	s1,8(sp)
    800251da:	6902                	ld	s2,0(sp)
    800251dc:	6105                	addi	sp,sp,32
    800251de:	8082                	ret
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    800251e0:	0025149b          	slliw	s1,a0,0x2
    800251e4:	0001b917          	auipc	s2,0x1b
    800251e8:	24490913          	addi	s2,s2,580 # 80040428 <fat>
    800251ec:	01095783          	lhu	a5,16(s2)
    800251f0:	02f4d7bb          	divuw	a5,s1,a5
    800251f4:	01495583          	lhu	a1,20(s2)
    struct buf *b = bread(0, fat_sec);
    800251f8:	9dbd                	addw	a1,a1,a5
    800251fa:	4501                	li	a0,0
    800251fc:	ffffe097          	auipc	ra,0xffffe
    80025200:	294080e7          	jalr	660(ra) # 80023490 <bread>
    return (cluster << 2) % fat.bpb.byts_per_sec;
    80025204:	01095783          	lhu	a5,16(s2)
    80025208:	02f4f4bb          	remuw	s1,s1,a5
    uint32 next_clus = *(uint32 *)(b->data + fat_offset_of_clus(cluster));
    8002520c:	94aa                	add	s1,s1,a0
    8002520e:	4ca4                	lw	s1,88(s1)
    brelse(b);
    80025210:	ffffe097          	auipc	ra,0xffffe
    80025214:	3be080e7          	jalr	958(ra) # 800235ce <brelse>
    return next_clus;
    80025218:	bf6d                	j	800251d2 <read_fat+0x2a>

000000008002521a <alloc_clus>:
        brelse(b);
    }
}

static uint32 alloc_clus(uint8 dev)
{
    8002521a:	711d                	addi	sp,sp,-96
    8002521c:	ec86                	sd	ra,88(sp)
    8002521e:	e8a2                	sd	s0,80(sp)
    80025220:	e4a6                	sd	s1,72(sp)
    80025222:	e0ca                	sd	s2,64(sp)
    80025224:	fc4e                	sd	s3,56(sp)
    80025226:	f852                	sd	s4,48(sp)
    80025228:	f456                	sd	s5,40(sp)
    8002522a:	f05a                	sd	s6,32(sp)
    8002522c:	ec5e                	sd	s7,24(sp)
    8002522e:	e862                	sd	s8,16(sp)
    80025230:	e466                	sd	s9,8(sp)
    80025232:	1080                	addi	s0,sp,96
    // should we keep a free cluster list? instead of searching fat every time.
    struct buf *b;
    uint32 sec = fat.bpb.rsvd_sec_cnt;
    80025234:	0001b797          	auipc	a5,0x1b
    80025238:	1f478793          	addi	a5,a5,500 # 80040428 <fat>
    8002523c:	0147db03          	lhu	s6,20(a5)
    uint32 const ent_per_sec = fat.bpb.byts_per_sec / sizeof(uint32);
    80025240:	0107d903          	lhu	s2,16(a5)
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    80025244:	539c                	lw	a5,32(a5)
    80025246:	10078663          	beqz	a5,80025352 <alloc_clus+0x138>
    8002524a:	0029591b          	srliw	s2,s2,0x2
    8002524e:	0009099b          	sext.w	s3,s2
    80025252:	4a81                	li	s5,0
        b = bread(dev, sec);
    80025254:	00050b9b          	sext.w	s7,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80025258:	4c01                	li	s8,0
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    8002525a:	0001bc97          	auipc	s9,0x1b
    8002525e:	1cec8c93          	addi	s9,s9,462 # 80040428 <fat>
    80025262:	a821                	j	8002527a <alloc_clus+0x60>
                uint32 clus = i * ent_per_sec + j;
                zero_clus(clus);
                return clus;
            }
        }
        brelse(b);
    80025264:	8552                	mv	a0,s4
    80025266:	ffffe097          	auipc	ra,0xffffe
    8002526a:	368080e7          	jalr	872(ra) # 800235ce <brelse>
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    8002526e:	2a85                	addiw	s5,s5,1
    80025270:	2b05                	addiw	s6,s6,1
    80025272:	020ca783          	lw	a5,32(s9)
    80025276:	0cfafe63          	bgeu	s5,a5,80025352 <alloc_clus+0x138>
        b = bread(dev, sec);
    8002527a:	85da                	mv	a1,s6
    8002527c:	855e                	mv	a0,s7
    8002527e:	ffffe097          	auipc	ra,0xffffe
    80025282:	212080e7          	jalr	530(ra) # 80023490 <bread>
    80025286:	8a2a                	mv	s4,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80025288:	fc098ee3          	beqz	s3,80025264 <alloc_clus+0x4a>
            if (((uint32 *)(b->data))[j] == 0) {
    8002528c:	05850693          	addi	a3,a0,88
    80025290:	4d24                	lw	s1,88(a0)
    80025292:	cc81                	beqz	s1,800252aa <alloc_clus+0x90>
    80025294:	05c50793          	addi	a5,a0,92
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80025298:	84e2                	mv	s1,s8
    8002529a:	2485                	addiw	s1,s1,1
    8002529c:	fc9984e3          	beq	s3,s1,80025264 <alloc_clus+0x4a>
            if (((uint32 *)(b->data))[j] == 0) {
    800252a0:	86be                	mv	a3,a5
    800252a2:	0791                	addi	a5,a5,4
    800252a4:	ffc7a703          	lw	a4,-4(a5)
    800252a8:	fb6d                	bnez	a4,8002529a <alloc_clus+0x80>
                ((uint32 *)(b->data))[j] = FAT32_EOC + 7;
    800252aa:	100007b7          	lui	a5,0x10000
    800252ae:	17fd                	addi	a5,a5,-1
    800252b0:	c29c                	sw	a5,0(a3)
                bwrite(b);
    800252b2:	8552                	mv	a0,s4
    800252b4:	ffffe097          	auipc	ra,0xffffe
    800252b8:	2de080e7          	jalr	734(ra) # 80023592 <bwrite>
                brelse(b);
    800252bc:	8552                	mv	a0,s4
    800252be:	ffffe097          	auipc	ra,0xffffe
    800252c2:	310080e7          	jalr	784(ra) # 800235ce <brelse>
                uint32 clus = i * ent_per_sec + j;
    800252c6:	0359093b          	mulw	s2,s2,s5
    800252ca:	009904bb          	addw	s1,s2,s1
    800252ce:	00048a9b          	sext.w	s5,s1
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    800252d2:	0001b717          	auipc	a4,0x1b
    800252d6:	15670713          	addi	a4,a4,342 # 80040428 <fat>
    800252da:	01274783          	lbu	a5,18(a4)
    800252de:	34f9                	addiw	s1,s1,-2
    800252e0:	02f489bb          	mulw	s3,s1,a5
    800252e4:	4318                	lw	a4,0(a4)
    800252e6:	00e989bb          	addw	s3,s3,a4
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    800252ea:	c7b1                	beqz	a5,80025336 <alloc_clus+0x11c>
    800252ec:	4481                	li	s1,0
    800252ee:	0001ba17          	auipc	s4,0x1b
    800252f2:	13aa0a13          	addi	s4,s4,314 # 80040428 <fat>
        b = bread(0, sec++);
    800252f6:	013485bb          	addw	a1,s1,s3
    800252fa:	4501                	li	a0,0
    800252fc:	ffffe097          	auipc	ra,0xffffe
    80025300:	194080e7          	jalr	404(ra) # 80023490 <bread>
    80025304:	892a                	mv	s2,a0
        memset(b->data, 0, BSIZE);
    80025306:	20000613          	li	a2,512
    8002530a:	4581                	li	a1,0
    8002530c:	05850513          	addi	a0,a0,88
    80025310:	ffffb097          	auipc	ra,0xffffb
    80025314:	44c080e7          	jalr	1100(ra) # 8002075c <memset>
        bwrite(b);
    80025318:	854a                	mv	a0,s2
    8002531a:	ffffe097          	auipc	ra,0xffffe
    8002531e:	278080e7          	jalr	632(ra) # 80023592 <bwrite>
        brelse(b);
    80025322:	854a                	mv	a0,s2
    80025324:	ffffe097          	auipc	ra,0xffffe
    80025328:	2aa080e7          	jalr	682(ra) # 800235ce <brelse>
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    8002532c:	2485                	addiw	s1,s1,1
    8002532e:	012a4783          	lbu	a5,18(s4)
    80025332:	fcf4c2e3          	blt	s1,a5,800252f6 <alloc_clus+0xdc>
    }
    panic("no clusters");
}
    80025336:	8556                	mv	a0,s5
    80025338:	60e6                	ld	ra,88(sp)
    8002533a:	6446                	ld	s0,80(sp)
    8002533c:	64a6                	ld	s1,72(sp)
    8002533e:	6906                	ld	s2,64(sp)
    80025340:	79e2                	ld	s3,56(sp)
    80025342:	7a42                	ld	s4,48(sp)
    80025344:	7aa2                	ld	s5,40(sp)
    80025346:	7b02                	ld	s6,32(sp)
    80025348:	6be2                	ld	s7,24(sp)
    8002534a:	6c42                	ld	s8,16(sp)
    8002534c:	6ca2                	ld	s9,8(sp)
    8002534e:	6125                	addi	sp,sp,96
    80025350:	8082                	ret
    panic("no clusters");
    80025352:	00007517          	auipc	a0,0x7
    80025356:	03650513          	addi	a0,a0,54 # 8002c388 <syscalls+0xa20>
    8002535a:	ffffb097          	auipc	ra,0xffffb
    8002535e:	dec080e7          	jalr	-532(ra) # 80020146 <panic>

0000000080025362 <write_fat>:
    if (cluster > fat.data_clus_cnt + 1) {
    80025362:	0001b797          	auipc	a5,0x1b
    80025366:	0c678793          	addi	a5,a5,198 # 80040428 <fat>
    8002536a:	479c                	lw	a5,8(a5)
    8002536c:	2785                	addiw	a5,a5,1
    8002536e:	06a7e763          	bltu	a5,a0,800253dc <write_fat+0x7a>
{
    80025372:	7179                	addi	sp,sp,-48
    80025374:	f406                	sd	ra,40(sp)
    80025376:	f022                	sd	s0,32(sp)
    80025378:	ec26                	sd	s1,24(sp)
    8002537a:	e84a                	sd	s2,16(sp)
    8002537c:	e44e                	sd	s3,8(sp)
    8002537e:	e052                	sd	s4,0(sp)
    80025380:	1800                	addi	s0,sp,48
    80025382:	8a2e                	mv	s4,a1
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    80025384:	0025149b          	slliw	s1,a0,0x2
    80025388:	0001b917          	auipc	s2,0x1b
    8002538c:	0a090913          	addi	s2,s2,160 # 80040428 <fat>
    80025390:	01095783          	lhu	a5,16(s2)
    80025394:	02f4d7bb          	divuw	a5,s1,a5
    80025398:	01495583          	lhu	a1,20(s2)
    struct buf *b = bread(0, fat_sec);
    8002539c:	9dbd                	addw	a1,a1,a5
    8002539e:	4501                	li	a0,0
    800253a0:	ffffe097          	auipc	ra,0xffffe
    800253a4:	0f0080e7          	jalr	240(ra) # 80023490 <bread>
    800253a8:	89aa                	mv	s3,a0
    return (cluster << 2) % fat.bpb.byts_per_sec;
    800253aa:	01095783          	lhu	a5,16(s2)
    800253ae:	02f4f4bb          	remuw	s1,s1,a5
    *(uint32 *)(b->data + off) = content;
    800253b2:	94aa                	add	s1,s1,a0
    800253b4:	0544ac23          	sw	s4,88(s1)
    bwrite(b);
    800253b8:	ffffe097          	auipc	ra,0xffffe
    800253bc:	1da080e7          	jalr	474(ra) # 80023592 <bwrite>
    brelse(b);
    800253c0:	854e                	mv	a0,s3
    800253c2:	ffffe097          	auipc	ra,0xffffe
    800253c6:	20c080e7          	jalr	524(ra) # 800235ce <brelse>
    return 0;
    800253ca:	4501                	li	a0,0
}
    800253cc:	70a2                	ld	ra,40(sp)
    800253ce:	7402                	ld	s0,32(sp)
    800253d0:	64e2                	ld	s1,24(sp)
    800253d2:	6942                	ld	s2,16(sp)
    800253d4:	69a2                	ld	s3,8(sp)
    800253d6:	6a02                	ld	s4,0(sp)
    800253d8:	6145                	addi	sp,sp,48
    800253da:	8082                	ret
        return -1;
    800253dc:	557d                	li	a0,-1
}
    800253de:	8082                	ret

00000000800253e0 <reloc_clus>:
 * @param   off         the offset from the beginning of the relative file
 * @param   alloc       whether alloc new cluster when meeting end of FAT chains
 * @return              the offset from the new cur_clus
 */
static int reloc_clus(struct dirent *entry, uint off, int alloc)
{
    800253e0:	715d                	addi	sp,sp,-80
    800253e2:	e486                	sd	ra,72(sp)
    800253e4:	e0a2                	sd	s0,64(sp)
    800253e6:	fc26                	sd	s1,56(sp)
    800253e8:	f84a                	sd	s2,48(sp)
    800253ea:	f44e                	sd	s3,40(sp)
    800253ec:	f052                	sd	s4,32(sp)
    800253ee:	ec56                	sd	s5,24(sp)
    800253f0:	e85a                	sd	s6,16(sp)
    800253f2:	e45e                	sd	s7,8(sp)
    800253f4:	0880                	addi	s0,sp,80
    800253f6:	84aa                	mv	s1,a0
    800253f8:	8a2e                	mv	s4,a1
    int clus_num = off / fat.byts_per_clus;
    800253fa:	0001b797          	auipc	a5,0x1b
    800253fe:	02e78793          	addi	a5,a5,46 # 80040428 <fat>
    80025402:	00c7ab83          	lw	s7,12(a5)
    80025406:	0375d9bb          	divuw	s3,a1,s7
    while (clus_num > entry->clus_cnt) {
    8002540a:	11052703          	lw	a4,272(a0)
    8002540e:	07377763          	bgeu	a4,s3,8002547c <reloc_clus+0x9c>
    80025412:	8b32                	mv	s6,a2
        int clus = read_fat(entry->cur_clus);
        if (clus >= FAT32_EOC) {
    80025414:	10000ab7          	lui	s5,0x10000
    80025418:	1add                	addi	s5,s5,-9
    8002541a:	a025                	j	80025442 <reloc_clus+0x62>
            if (alloc) {
                clus = alloc_clus(entry->dev);
                write_fat(entry->cur_clus, clus);
            } else {
                entry->cur_clus = entry->first_clus;
    8002541c:	1044a783          	lw	a5,260(s1)
    80025420:	10f4a623          	sw	a5,268(s1)
                entry->clus_cnt = 0;
    80025424:	1004a823          	sw	zero,272(s1)
                return -1;
    80025428:	557d                	li	a0,-1
    8002542a:	a04d                	j	800254cc <reloc_clus+0xec>
            }
        }
        entry->cur_clus = clus;
    8002542c:	1124a623          	sw	s2,268(s1)
        entry->clus_cnt++;
    80025430:	1104a783          	lw	a5,272(s1)
    80025434:	2785                	addiw	a5,a5,1
    80025436:	0007871b          	sext.w	a4,a5
    8002543a:	10f4a823          	sw	a5,272(s1)
    while (clus_num > entry->clus_cnt) {
    8002543e:	03377f63          	bgeu	a4,s3,8002547c <reloc_clus+0x9c>
        int clus = read_fat(entry->cur_clus);
    80025442:	10c4a503          	lw	a0,268(s1)
    80025446:	00000097          	auipc	ra,0x0
    8002544a:	d62080e7          	jalr	-670(ra) # 800251a8 <read_fat>
    8002544e:	0005091b          	sext.w	s2,a0
        if (clus >= FAT32_EOC) {
    80025452:	fd2adde3          	bge	s5,s2,8002542c <reloc_clus+0x4c>
            if (alloc) {
    80025456:	fc0b03e3          	beqz	s6,8002541c <reloc_clus+0x3c>
                clus = alloc_clus(entry->dev);
    8002545a:	1144c503          	lbu	a0,276(s1)
    8002545e:	00000097          	auipc	ra,0x0
    80025462:	dbc080e7          	jalr	-580(ra) # 8002521a <alloc_clus>
    80025466:	0005059b          	sext.w	a1,a0
    8002546a:	0005891b          	sext.w	s2,a1
                write_fat(entry->cur_clus, clus);
    8002546e:	10c4a503          	lw	a0,268(s1)
    80025472:	00000097          	auipc	ra,0x0
    80025476:	ef0080e7          	jalr	-272(ra) # 80025362 <write_fat>
    8002547a:	bf4d                	j	8002542c <reloc_clus+0x4c>
    }
    if (clus_num < entry->clus_cnt) {
    8002547c:	04e9f163          	bgeu	s3,a4,800254be <reloc_clus+0xde>
        entry->cur_clus = entry->first_clus;
    80025480:	1044a783          	lw	a5,260(s1)
    80025484:	10f4a623          	sw	a5,268(s1)
        entry->clus_cnt = 0;
    80025488:	1004a823          	sw	zero,272(s1)
        while (entry->clus_cnt < clus_num) {
    8002548c:	037a6963          	bltu	s4,s7,800254be <reloc_clus+0xde>
            entry->cur_clus = read_fat(entry->cur_clus);
            if (entry->cur_clus >= FAT32_EOC) {
    80025490:	10000937          	lui	s2,0x10000
    80025494:	195d                	addi	s2,s2,-9
            entry->cur_clus = read_fat(entry->cur_clus);
    80025496:	10c4a503          	lw	a0,268(s1)
    8002549a:	00000097          	auipc	ra,0x0
    8002549e:	d0e080e7          	jalr	-754(ra) # 800251a8 <read_fat>
    800254a2:	2501                	sext.w	a0,a0
    800254a4:	10a4a623          	sw	a0,268(s1)
            if (entry->cur_clus >= FAT32_EOC) {
    800254a8:	02a96d63          	bltu	s2,a0,800254e2 <reloc_clus+0x102>
                panic("reloc_clus");
            }
            entry->clus_cnt++;
    800254ac:	1104a783          	lw	a5,272(s1)
    800254b0:	2785                	addiw	a5,a5,1
    800254b2:	0007871b          	sext.w	a4,a5
    800254b6:	10f4a823          	sw	a5,272(s1)
        while (entry->clus_cnt < clus_num) {
    800254ba:	fd376ee3          	bltu	a4,s3,80025496 <reloc_clus+0xb6>
        }
    }
    return off % fat.byts_per_clus;
    800254be:	0001b797          	auipc	a5,0x1b
    800254c2:	f6a78793          	addi	a5,a5,-150 # 80040428 <fat>
    800254c6:	47c8                	lw	a0,12(a5)
    800254c8:	02aa753b          	remuw	a0,s4,a0
}
    800254cc:	60a6                	ld	ra,72(sp)
    800254ce:	6406                	ld	s0,64(sp)
    800254d0:	74e2                	ld	s1,56(sp)
    800254d2:	7942                	ld	s2,48(sp)
    800254d4:	79a2                	ld	s3,40(sp)
    800254d6:	7a02                	ld	s4,32(sp)
    800254d8:	6ae2                	ld	s5,24(sp)
    800254da:	6b42                	ld	s6,16(sp)
    800254dc:	6ba2                	ld	s7,8(sp)
    800254de:	6161                	addi	sp,sp,80
    800254e0:	8082                	ret
                panic("reloc_clus");
    800254e2:	00007517          	auipc	a0,0x7
    800254e6:	eb650513          	addi	a0,a0,-330 # 8002c398 <syscalls+0xa30>
    800254ea:	ffffb097          	auipc	ra,0xffffb
    800254ee:	c5c080e7          	jalr	-932(ra) # 80020146 <panic>

00000000800254f2 <rw_clus>:
{
    800254f2:	7119                	addi	sp,sp,-128
    800254f4:	fc86                	sd	ra,120(sp)
    800254f6:	f8a2                	sd	s0,112(sp)
    800254f8:	f4a6                	sd	s1,104(sp)
    800254fa:	f0ca                	sd	s2,96(sp)
    800254fc:	ecce                	sd	s3,88(sp)
    800254fe:	e8d2                	sd	s4,80(sp)
    80025500:	e4d6                	sd	s5,72(sp)
    80025502:	e0da                	sd	s6,64(sp)
    80025504:	fc5e                	sd	s7,56(sp)
    80025506:	f862                	sd	s8,48(sp)
    80025508:	f466                	sd	s9,40(sp)
    8002550a:	f06a                	sd	s10,32(sp)
    8002550c:	ec6e                	sd	s11,24(sp)
    8002550e:	0100                	addi	s0,sp,128
    80025510:	f8c43423          	sd	a2,-120(s0)
    80025514:	8b36                	mv	s6,a3
    80025516:	8bbe                	mv	s7,a5
    if (off + n > fat.byts_per_clus)
    80025518:	00f706bb          	addw	a3,a4,a5
    8002551c:	0001b797          	auipc	a5,0x1b
    80025520:	f0c78793          	addi	a5,a5,-244 # 80040428 <fat>
    80025524:	47dc                	lw	a5,12(a5)
    80025526:	02d7ef63          	bltu	a5,a3,80025564 <rw_clus+0x72>
    8002552a:	8d2e                	mv	s10,a1
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    8002552c:	0001b797          	auipc	a5,0x1b
    80025530:	efc78793          	addi	a5,a5,-260 # 80040428 <fat>
    80025534:	0107da03          	lhu	s4,16(a5)
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    80025538:	ffe5099b          	addiw	s3,a0,-2
    8002553c:	0127c503          	lbu	a0,18(a5)
    80025540:	02a989bb          	mulw	s3,s3,a0
    80025544:	4388                	lw	a0,0(a5)
    80025546:	00a989bb          	addw	s3,s3,a0
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    8002554a:	034757bb          	divuw	a5,a4,s4
    8002554e:	00f989bb          	addw	s3,s3,a5
    off = off % fat.bpb.byts_per_sec;
    80025552:	03477a3b          	remuw	s4,a4,s4
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    80025556:	0e0b8363          	beqz	s7,8002563c <rw_clus+0x14a>
    8002555a:	4901                	li	s2,0
        m = BSIZE - off % BSIZE;
    8002555c:	20000d93          	li	s11,512
        if (bad == -1) {
    80025560:	5cfd                	li	s9,-1
    80025562:	a095                	j	800255c6 <rw_clus+0xd4>
        panic("offset out of range");
    80025564:	00007517          	auipc	a0,0x7
    80025568:	e4450513          	addi	a0,a0,-444 # 8002c3a8 <syscalls+0xa40>
    8002556c:	ffffb097          	auipc	ra,0xffffb
    80025570:	bda080e7          	jalr	-1062(ra) # 80020146 <panic>
                bwrite(bp);
    80025574:	8556                	mv	a0,s5
    80025576:	ffffe097          	auipc	ra,0xffffe
    8002557a:	01c080e7          	jalr	28(ra) # 80023592 <bwrite>
        brelse(bp);
    8002557e:	8556                	mv	a0,s5
    80025580:	ffffe097          	auipc	ra,0xffffe
    80025584:	04e080e7          	jalr	78(ra) # 800235ce <brelse>
        if (bad == -1) {
    80025588:	a02d                	j	800255b2 <rw_clus+0xc0>
            bad = either_copyout(user, data, bp->data + (off % BSIZE), m);
    8002558a:	058a8613          	addi	a2,s5,88 # 10000058 <BASE_ADDRESS-0x7001ffa8>
    8002558e:	1682                	slli	a3,a3,0x20
    80025590:	9281                	srli	a3,a3,0x20
    80025592:	963a                	add	a2,a2,a4
    80025594:	85da                	mv	a1,s6
    80025596:	f8843503          	ld	a0,-120(s0)
    8002559a:	ffffd097          	auipc	ra,0xffffd
    8002559e:	096080e7          	jalr	150(ra) # 80022630 <either_copyout>
    800255a2:	8c2a                	mv	s8,a0
        brelse(bp);
    800255a4:	8556                	mv	a0,s5
    800255a6:	ffffe097          	auipc	ra,0xffffe
    800255aa:	028080e7          	jalr	40(ra) # 800235ce <brelse>
        if (bad == -1) {
    800255ae:	079c0763          	beq	s8,s9,8002561c <rw_clus+0x12a>
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    800255b2:	0124893b          	addw	s2,s1,s2
    800255b6:	01448a3b          	addw	s4,s1,s4
    800255ba:	1482                	slli	s1,s1,0x20
    800255bc:	9081                	srli	s1,s1,0x20
    800255be:	9b26                	add	s6,s6,s1
    800255c0:	2985                	addiw	s3,s3,1
    800255c2:	05797d63          	bgeu	s2,s7,8002561c <rw_clus+0x12a>
        bp = bread(0, sec);
    800255c6:	85ce                	mv	a1,s3
    800255c8:	4501                	li	a0,0
    800255ca:	ffffe097          	auipc	ra,0xffffe
    800255ce:	ec6080e7          	jalr	-314(ra) # 80023490 <bread>
    800255d2:	8aaa                	mv	s5,a0
        m = BSIZE - off % BSIZE;
    800255d4:	1ffa7713          	andi	a4,s4,511
    800255d8:	40ed863b          	subw	a2,s11,a4
        if (n - tot < m) {
    800255dc:	412b87bb          	subw	a5,s7,s2
    800255e0:	86be                	mv	a3,a5
    800255e2:	2781                	sext.w	a5,a5
    800255e4:	0006059b          	sext.w	a1,a2
    800255e8:	00f5f363          	bgeu	a1,a5,800255ee <rw_clus+0xfc>
    800255ec:	86b2                	mv	a3,a2
    800255ee:	0006849b          	sext.w	s1,a3
        if (write) {
    800255f2:	f80d0ce3          	beqz	s10,8002558a <rw_clus+0x98>
            if ((bad = either_copyin(bp->data + (off % BSIZE), user, data, m)) != -1) {
    800255f6:	058a8513          	addi	a0,s5,88
    800255fa:	1682                	slli	a3,a3,0x20
    800255fc:	9281                	srli	a3,a3,0x20
    800255fe:	865a                	mv	a2,s6
    80025600:	f8843583          	ld	a1,-120(s0)
    80025604:	953a                	add	a0,a0,a4
    80025606:	ffffd097          	auipc	ra,0xffffd
    8002560a:	060080e7          	jalr	96(ra) # 80022666 <either_copyin>
    8002560e:	f79513e3          	bne	a0,s9,80025574 <rw_clus+0x82>
        brelse(bp);
    80025612:	8556                	mv	a0,s5
    80025614:	ffffe097          	auipc	ra,0xffffe
    80025618:	fba080e7          	jalr	-70(ra) # 800235ce <brelse>
}
    8002561c:	854a                	mv	a0,s2
    8002561e:	70e6                	ld	ra,120(sp)
    80025620:	7446                	ld	s0,112(sp)
    80025622:	74a6                	ld	s1,104(sp)
    80025624:	7906                	ld	s2,96(sp)
    80025626:	69e6                	ld	s3,88(sp)
    80025628:	6a46                	ld	s4,80(sp)
    8002562a:	6aa6                	ld	s5,72(sp)
    8002562c:	6b06                	ld	s6,64(sp)
    8002562e:	7be2                	ld	s7,56(sp)
    80025630:	7c42                	ld	s8,48(sp)
    80025632:	7ca2                	ld	s9,40(sp)
    80025634:	7d02                	ld	s10,32(sp)
    80025636:	6de2                	ld	s11,24(sp)
    80025638:	6109                	addi	sp,sp,128
    8002563a:	8082                	ret
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    8002563c:	895e                	mv	s2,s7
    8002563e:	bff9                	j	8002561c <rw_clus+0x12a>

0000000080025640 <eget>:
// by their whole path. But when parsing a path, we open all the directories through it, 
// which forms a linked list from the final file to the root. Thus, we use the "parent" pointer 
// to recognize whether an entry with the "name" as given is really the file we want in the right path.
// Should never get root by eget, it's easy to understand.
static struct dirent *eget(struct dirent *parent, char *name)
{
    80025640:	7139                	addi	sp,sp,-64
    80025642:	fc06                	sd	ra,56(sp)
    80025644:	f822                	sd	s0,48(sp)
    80025646:	f426                	sd	s1,40(sp)
    80025648:	f04a                	sd	s2,32(sp)
    8002564a:	ec4e                	sd	s3,24(sp)
    8002564c:	e852                	sd	s4,16(sp)
    8002564e:	e456                	sd	s5,8(sp)
    80025650:	0080                	addi	s0,sp,64
    80025652:	8a2a                	mv	s4,a0
    80025654:	8aae                	mv	s5,a1
    struct dirent *ep;
    acquire(&ecache.lock);
    80025656:	0001b517          	auipc	a0,0x1b
    8002565a:	f6250513          	addi	a0,a0,-158 # 800405b8 <ecache>
    8002565e:	ffffb097          	auipc	ra,0xffffb
    80025662:	062080e7          	jalr	98(ra) # 800206c0 <acquire>
    if (name) {
    80025666:	060a8d63          	beqz	s5,800256e0 <eget+0xa0>
        for (ep = root.next; ep != &root; ep = ep->next) {          // LRU algo
    8002566a:	0001b797          	auipc	a5,0x1b
    8002566e:	dbe78793          	addi	a5,a5,-578 # 80040428 <fat>
    80025672:	1507b483          	ld	s1,336(a5)
    80025676:	0001b797          	auipc	a5,0x1b
    8002567a:	dda78793          	addi	a5,a5,-550 # 80040450 <root>
    8002567e:	06f48163          	beq	s1,a5,800256e0 <eget+0xa0>
            if (ep->valid == 1 && ep->parent == parent
    80025682:	4905                	li	s2,1
        for (ep = root.next; ep != &root; ep = ep->next) {          // LRU algo
    80025684:	89be                	mv	s3,a5
    80025686:	a029                	j	80025690 <eget+0x50>
    80025688:	1284b483          	ld	s1,296(s1)
    8002568c:	05348a63          	beq	s1,s3,800256e0 <eget+0xa0>
            if (ep->valid == 1 && ep->parent == parent
    80025690:	11649783          	lh	a5,278(s1)
    80025694:	ff279ae3          	bne	a5,s2,80025688 <eget+0x48>
    80025698:	1204b783          	ld	a5,288(s1)
    8002569c:	ff4796e3          	bne	a5,s4,80025688 <eget+0x48>
                && strncmp(ep->filename, name, FAT32_MAX_FILENAME) == 0) {
    800256a0:	0ff00613          	li	a2,255
    800256a4:	85d6                	mv	a1,s5
    800256a6:	8526                	mv	a0,s1
    800256a8:	ffffb097          	auipc	ra,0xffffb
    800256ac:	19c080e7          	jalr	412(ra) # 80020844 <strncmp>
    800256b0:	fd61                	bnez	a0,80025688 <eget+0x48>
                if (ep->ref++ == 0) {
    800256b2:	1184a783          	lw	a5,280(s1)
    800256b6:	0017871b          	addiw	a4,a5,1
    800256ba:	10e4ac23          	sw	a4,280(s1)
    800256be:	eb81                	bnez	a5,800256ce <eget+0x8e>
                    ep->parent->ref++;
    800256c0:	1204b703          	ld	a4,288(s1)
    800256c4:	11872783          	lw	a5,280(a4)
    800256c8:	2785                	addiw	a5,a5,1
    800256ca:	10f72c23          	sw	a5,280(a4)
                }
                release(&ecache.lock);
    800256ce:	0001b517          	auipc	a0,0x1b
    800256d2:	eea50513          	addi	a0,a0,-278 # 800405b8 <ecache>
    800256d6:	ffffb097          	auipc	ra,0xffffb
    800256da:	03e080e7          	jalr	62(ra) # 80020714 <release>
                // edup(ep->parent);
                return ep;
    800256de:	a085                	j	8002573e <eget+0xfe>
            }
        }
    }
    for (ep = root.prev; ep != &root; ep = ep->prev) {              // LRU algo
    800256e0:	0001b797          	auipc	a5,0x1b
    800256e4:	d4878793          	addi	a5,a5,-696 # 80040428 <fat>
    800256e8:	1587b483          	ld	s1,344(a5)
    800256ec:	0001b797          	auipc	a5,0x1b
    800256f0:	d6478793          	addi	a5,a5,-668 # 80040450 <root>
    800256f4:	04f48f63          	beq	s1,a5,80025752 <eget+0x112>
        if (ep->ref == 0) {
    800256f8:	1184a783          	lw	a5,280(s1)
    800256fc:	cf81                	beqz	a5,80025714 <eget+0xd4>
    for (ep = root.prev; ep != &root; ep = ep->prev) {              // LRU algo
    800256fe:	0001b717          	auipc	a4,0x1b
    80025702:	d5270713          	addi	a4,a4,-686 # 80040450 <root>
    80025706:	1304b483          	ld	s1,304(s1)
    8002570a:	04e48463          	beq	s1,a4,80025752 <eget+0x112>
        if (ep->ref == 0) {
    8002570e:	1184a783          	lw	a5,280(s1)
    80025712:	fbf5                	bnez	a5,80025706 <eget+0xc6>
            ep->ref = 1;
    80025714:	4785                	li	a5,1
    80025716:	10f4ac23          	sw	a5,280(s1)
            ep->dev = parent->dev;
    8002571a:	114a4783          	lbu	a5,276(s4)
    8002571e:	10f48a23          	sb	a5,276(s1)
            ep->off = 0;
    80025722:	1004ae23          	sw	zero,284(s1)
            ep->valid = 0;
    80025726:	10049b23          	sh	zero,278(s1)
            ep->dirty = 0;
    8002572a:	10048aa3          	sb	zero,277(s1)
            release(&ecache.lock);
    8002572e:	0001b517          	auipc	a0,0x1b
    80025732:	e8a50513          	addi	a0,a0,-374 # 800405b8 <ecache>
    80025736:	ffffb097          	auipc	ra,0xffffb
    8002573a:	fde080e7          	jalr	-34(ra) # 80020714 <release>
            return ep;
        }
    }
    panic("eget: insufficient ecache");
    return 0;
}
    8002573e:	8526                	mv	a0,s1
    80025740:	70e2                	ld	ra,56(sp)
    80025742:	7442                	ld	s0,48(sp)
    80025744:	74a2                	ld	s1,40(sp)
    80025746:	7902                	ld	s2,32(sp)
    80025748:	69e2                	ld	s3,24(sp)
    8002574a:	6a42                	ld	s4,16(sp)
    8002574c:	6aa2                	ld	s5,8(sp)
    8002574e:	6121                	addi	sp,sp,64
    80025750:	8082                	ret
    panic("eget: insufficient ecache");
    80025752:	00007517          	auipc	a0,0x7
    80025756:	c6e50513          	addi	a0,a0,-914 # 8002c3c0 <syscalls+0xa58>
    8002575a:	ffffb097          	auipc	ra,0xffffb
    8002575e:	9ec080e7          	jalr	-1556(ra) # 80020146 <panic>

0000000080025762 <read_entry_name>:
 * @param   buffer      pointer to the array that stores the name
 * @param   raw_entry   pointer to the entry in a sector buffer
 * @param   islong      if non-zero, read as l-n-e, otherwise s-n-e.
 */
static void read_entry_name(char *buffer, union dentry *d)
{
    80025762:	7179                	addi	sp,sp,-48
    80025764:	f406                	sd	ra,40(sp)
    80025766:	f022                	sd	s0,32(sp)
    80025768:	ec26                	sd	s1,24(sp)
    8002576a:	e84a                	sd	s2,16(sp)
    8002576c:	1800                	addi	s0,sp,48
    8002576e:	892a                	mv	s2,a0
    80025770:	84ae                	mv	s1,a1
    if (d->lne.attr == ATTR_LONG_NAME) {                       // long entry branch
    80025772:	00b5c703          	lbu	a4,11(a1)
    80025776:	47bd                	li	a5,15
    80025778:	0af70363          	beq	a4,a5,8002581e <read_entry_name+0xbc>
        snstr(buffer, d->lne.name2, NELEM(d->lne.name2));
        buffer += NELEM(d->lne.name2);
        snstr(buffer, d->lne.name3, NELEM(d->lne.name3));
    } else {
        // assert: only "." and ".." will enter this branch
        memset(buffer, 0, CHAR_SHORT_NAME + 2); // plus '.' and '\0'
    8002577c:	4635                	li	a2,13
    8002577e:	4581                	li	a1,0
    80025780:	ffffb097          	auipc	ra,0xffffb
    80025784:	fdc080e7          	jalr	-36(ra) # 8002075c <memset>
        int i;
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    80025788:	0004c703          	lbu	a4,0(s1)
    8002578c:	02000793          	li	a5,32
    80025790:	0cf70a63          	beq	a4,a5,80025864 <read_entry_name+0x102>
    80025794:	4785                	li	a5,1
    80025796:	02000613          	li	a2,32
    8002579a:	45a5                	li	a1,9
            buffer[i] = d->sne.name[i];
    8002579c:	00f906b3          	add	a3,s2,a5
    800257a0:	fee68fa3          	sb	a4,-1(a3) # 1fff <BASE_ADDRESS-0x8001e001>
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    800257a4:	0007869b          	sext.w	a3,a5
    800257a8:	00f48733          	add	a4,s1,a5
    800257ac:	00074703          	lbu	a4,0(a4)
    800257b0:	00c70563          	beq	a4,a2,800257ba <read_entry_name+0x58>
    800257b4:	0785                	addi	a5,a5,1
    800257b6:	feb793e3          	bne	a5,a1,8002579c <read_entry_name+0x3a>
        }
        if (d->sne.name[8] != ' ') {
    800257ba:	0084c703          	lbu	a4,8(s1)
    800257be:	02000793          	li	a5,32
    800257c2:	04f70863          	beq	a4,a5,80025812 <read_entry_name+0xb0>
            buffer[i++] = '.';
    800257c6:	0016871b          	addiw	a4,a3,1
    800257ca:	00d907b3          	add	a5,s2,a3
    800257ce:	02e00613          	li	a2,46
    800257d2:	00c78023          	sb	a2,0(a5)
        }
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
            if (d->sne.name[j] == ' ') { break; }
    800257d6:	0084c783          	lbu	a5,8(s1)
    800257da:	02000613          	li	a2,32
    800257de:	02c78a63          	beq	a5,a2,80025812 <read_entry_name+0xb0>
            buffer[i] = d->sne.name[j];
    800257e2:	974a                	add	a4,a4,s2
    800257e4:	00f70023          	sb	a5,0(a4)
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
    800257e8:	0026879b          	addiw	a5,a3,2
            if (d->sne.name[j] == ' ') { break; }
    800257ec:	0094c703          	lbu	a4,9(s1)
    800257f0:	02000613          	li	a2,32
    800257f4:	00c70f63          	beq	a4,a2,80025812 <read_entry_name+0xb0>
            buffer[i] = d->sne.name[j];
    800257f8:	97ca                	add	a5,a5,s2
    800257fa:	00e78023          	sb	a4,0(a5)
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
    800257fe:	268d                	addiw	a3,a3,3
            if (d->sne.name[j] == ' ') { break; }
    80025800:	00a4c783          	lbu	a5,10(s1)
    80025804:	02000713          	li	a4,32
    80025808:	00e78563          	beq	a5,a4,80025812 <read_entry_name+0xb0>
            buffer[i] = d->sne.name[j];
    8002580c:	96ca                	add	a3,a3,s2
    8002580e:	00f68023          	sb	a5,0(a3)
        }
    }
}
    80025812:	70a2                	ld	ra,40(sp)
    80025814:	7402                	ld	s0,32(sp)
    80025816:	64e2                	ld	s1,24(sp)
    80025818:	6942                	ld	s2,16(sp)
    8002581a:	6145                	addi	sp,sp,48
    8002581c:	8082                	ret
        memmove(temp, d->lne.name1, sizeof(temp));
    8002581e:	4629                	li	a2,10
    80025820:	0585                	addi	a1,a1,1
    80025822:	fd040513          	addi	a0,s0,-48
    80025826:	ffffb097          	auipc	ra,0xffffb
    8002582a:	fa2080e7          	jalr	-94(ra) # 800207c8 <memmove>
        snstr(buffer, temp, NELEM(d->lne.name1));
    8002582e:	4615                	li	a2,5
    80025830:	fd040593          	addi	a1,s0,-48
    80025834:	854a                	mv	a0,s2
    80025836:	ffffb097          	auipc	ra,0xffffb
    8002583a:	13c080e7          	jalr	316(ra) # 80020972 <snstr>
        snstr(buffer, d->lne.name2, NELEM(d->lne.name2));
    8002583e:	4619                	li	a2,6
    80025840:	00e48593          	addi	a1,s1,14
    80025844:	00590513          	addi	a0,s2,5 # 10000005 <BASE_ADDRESS-0x7001fffb>
    80025848:	ffffb097          	auipc	ra,0xffffb
    8002584c:	12a080e7          	jalr	298(ra) # 80020972 <snstr>
        snstr(buffer, d->lne.name3, NELEM(d->lne.name3));
    80025850:	4609                	li	a2,2
    80025852:	01c48593          	addi	a1,s1,28
    80025856:	00b90513          	addi	a0,s2,11
    8002585a:	ffffb097          	auipc	ra,0xffffb
    8002585e:	118080e7          	jalr	280(ra) # 80020972 <snstr>
    80025862:	bf45                	j	80025812 <read_entry_name+0xb0>
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    80025864:	4681                	li	a3,0
    80025866:	bf91                	j	800257ba <read_entry_name+0x58>

0000000080025868 <fat32_init>:
{
    80025868:	7139                	addi	sp,sp,-64
    8002586a:	fc06                	sd	ra,56(sp)
    8002586c:	f822                	sd	s0,48(sp)
    8002586e:	f426                	sd	s1,40(sp)
    80025870:	f04a                	sd	s2,32(sp)
    80025872:	ec4e                	sd	s3,24(sp)
    80025874:	e852                	sd	s4,16(sp)
    80025876:	e456                	sd	s5,8(sp)
    80025878:	0080                	addi	s0,sp,64
    struct buf *b = bread(0, 0);
    8002587a:	4581                	li	a1,0
    8002587c:	4501                	li	a0,0
    8002587e:	ffffe097          	auipc	ra,0xffffe
    80025882:	c12080e7          	jalr	-1006(ra) # 80023490 <bread>
    80025886:	892a                	mv	s2,a0
    if (strncmp((char const*)(b->data + 82), "FAT32", 5))
    80025888:	4615                	li	a2,5
    8002588a:	00007597          	auipc	a1,0x7
    8002588e:	b5658593          	addi	a1,a1,-1194 # 8002c3e0 <syscalls+0xa78>
    80025892:	0aa50513          	addi	a0,a0,170
    80025896:	ffffb097          	auipc	ra,0xffffb
    8002589a:	fae080e7          	jalr	-82(ra) # 80020844 <strncmp>
    8002589e:	16051863          	bnez	a0,80025a0e <fat32_init+0x1a6>
    memmove(&fat.bpb.byts_per_sec, b->data + 11, 2);            // avoid misaligned load on k210
    800258a2:	0001b497          	auipc	s1,0x1b
    800258a6:	b8648493          	addi	s1,s1,-1146 # 80040428 <fat>
    800258aa:	4609                	li	a2,2
    800258ac:	06390593          	addi	a1,s2,99
    800258b0:	0001b517          	auipc	a0,0x1b
    800258b4:	b8850513          	addi	a0,a0,-1144 # 80040438 <fat+0x10>
    800258b8:	ffffb097          	auipc	ra,0xffffb
    800258bc:	f10080e7          	jalr	-240(ra) # 800207c8 <memmove>
    fat.bpb.sec_per_clus = *(b->data + 13);
    800258c0:	06594683          	lbu	a3,101(s2)
    800258c4:	00d48923          	sb	a3,18(s1)
    fat.bpb.rsvd_sec_cnt = *(uint16 *)(b->data + 14);
    800258c8:	06695603          	lhu	a2,102(s2)
    800258cc:	00c49a23          	sh	a2,20(s1)
    fat.bpb.fat_cnt = *(b->data + 16);
    800258d0:	06894703          	lbu	a4,104(s2)
    800258d4:	00e48b23          	sb	a4,22(s1)
    fat.bpb.hidd_sec = *(uint32 *)(b->data + 28);
    800258d8:	07492783          	lw	a5,116(s2)
    800258dc:	cc9c                	sw	a5,24(s1)
    fat.bpb.tot_sec = *(uint32 *)(b->data + 32);
    800258de:	07892783          	lw	a5,120(s2)
    800258e2:	ccdc                	sw	a5,28(s1)
    fat.bpb.fat_sz = *(uint32 *)(b->data + 36);
    800258e4:	07c92583          	lw	a1,124(s2)
    800258e8:	d08c                	sw	a1,32(s1)
    fat.bpb.root_clus = *(uint32 *)(b->data + 44);
    800258ea:	08492503          	lw	a0,132(s2)
    800258ee:	d0c8                	sw	a0,36(s1)
    fat.first_data_sec = fat.bpb.rsvd_sec_cnt + fat.bpb.fat_cnt * fat.bpb.fat_sz;
    800258f0:	02b7073b          	mulw	a4,a4,a1
    800258f4:	9f31                	addw	a4,a4,a2
    800258f6:	c098                	sw	a4,0(s1)
    fat.data_sec_cnt = fat.bpb.tot_sec - fat.first_data_sec;
    800258f8:	9f99                	subw	a5,a5,a4
    800258fa:	c0dc                	sw	a5,4(s1)
    fat.data_clus_cnt = fat.data_sec_cnt / fat.bpb.sec_per_clus;
    800258fc:	02d7d7bb          	divuw	a5,a5,a3
    80025900:	c49c                	sw	a5,8(s1)
    fat.byts_per_clus = fat.bpb.sec_per_clus * fat.bpb.byts_per_sec;
    80025902:	0104d783          	lhu	a5,16(s1)
    80025906:	02d787bb          	mulw	a5,a5,a3
    8002590a:	c4dc                	sw	a5,12(s1)
    brelse(b);
    8002590c:	854a                	mv	a0,s2
    8002590e:	ffffe097          	auipc	ra,0xffffe
    80025912:	cc0080e7          	jalr	-832(ra) # 800235ce <brelse>
    if (BSIZE != fat.bpb.byts_per_sec) 
    80025916:	0104d703          	lhu	a4,16(s1)
    8002591a:	20000793          	li	a5,512
    8002591e:	10f71063          	bne	a4,a5,80025a1e <fat32_init+0x1b6>
    initlock(&ecache.lock, "ecache");
    80025922:	00007597          	auipc	a1,0x7
    80025926:	af658593          	addi	a1,a1,-1290 # 8002c418 <syscalls+0xab0>
    8002592a:	0001b517          	auipc	a0,0x1b
    8002592e:	c8e50513          	addi	a0,a0,-882 # 800405b8 <ecache>
    80025932:	ffffb097          	auipc	ra,0xffffb
    80025936:	d4a080e7          	jalr	-694(ra) # 8002067c <initlock>
    memset(&root, 0, sizeof(root));
    8002593a:	0001b497          	auipc	s1,0x1b
    8002593e:	aee48493          	addi	s1,s1,-1298 # 80040428 <fat>
    80025942:	0001b917          	auipc	s2,0x1b
    80025946:	b0e90913          	addi	s2,s2,-1266 # 80040450 <root>
    8002594a:	16800613          	li	a2,360
    8002594e:	4581                	li	a1,0
    80025950:	854a                	mv	a0,s2
    80025952:	ffffb097          	auipc	ra,0xffffb
    80025956:	e0a080e7          	jalr	-502(ra) # 8002075c <memset>
    initsleeplock(&root.lock, "entry");
    8002595a:	00007597          	auipc	a1,0x7
    8002595e:	ac658593          	addi	a1,a1,-1338 # 8002c420 <syscalls+0xab8>
    80025962:	0001b517          	auipc	a0,0x1b
    80025966:	c2650513          	addi	a0,a0,-986 # 80040588 <root+0x138>
    8002596a:	ffffe097          	auipc	ra,0xffffe
    8002596e:	d7a080e7          	jalr	-646(ra) # 800236e4 <initsleeplock>
    root.attribute = (ATTR_DIRECTORY | ATTR_SYSTEM);
    80025972:	47d1                	li	a5,20
    80025974:	12f48423          	sb	a5,296(s1)
    root.first_clus = root.cur_clus = fat.bpb.root_clus;
    80025978:	50dc                	lw	a5,36(s1)
    8002597a:	12f4aa23          	sw	a5,308(s1)
    8002597e:	12f4a623          	sw	a5,300(s1)
    root.valid = 1;
    80025982:	4785                	li	a5,1
    80025984:	12f49f23          	sh	a5,318(s1)
    root.prev = &root;
    80025988:	1524bc23          	sd	s2,344(s1)
    root.next = &root;
    8002598c:	1524b823          	sd	s2,336(s1)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    80025990:	0001b497          	auipc	s1,0x1b
    80025994:	c4048493          	addi	s1,s1,-960 # 800405d0 <ecache+0x18>
        de->next = root.next;
    80025998:	0001b917          	auipc	s2,0x1b
    8002599c:	a9090913          	addi	s2,s2,-1392 # 80040428 <fat>
        de->prev = &root;
    800259a0:	0001ba97          	auipc	s5,0x1b
    800259a4:	ab0a8a93          	addi	s5,s5,-1360 # 80040450 <root>
        initsleeplock(&de->lock, "entry");
    800259a8:	00007a17          	auipc	s4,0x7
    800259ac:	a78a0a13          	addi	s4,s4,-1416 # 8002c420 <syscalls+0xab8>
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    800259b0:	0001f997          	auipc	s3,0x1f
    800259b4:	27098993          	addi	s3,s3,624 # 80044c20 <cons>
        de->dev = 0;
    800259b8:	10048a23          	sb	zero,276(s1)
        de->valid = 0;
    800259bc:	10049b23          	sh	zero,278(s1)
        de->ref = 0;
    800259c0:	1004ac23          	sw	zero,280(s1)
        de->dirty = 0;
    800259c4:	10048aa3          	sb	zero,277(s1)
        de->parent = 0;
    800259c8:	1204b023          	sd	zero,288(s1)
        de->next = root.next;
    800259cc:	15093783          	ld	a5,336(s2)
    800259d0:	12f4b423          	sd	a5,296(s1)
        de->prev = &root;
    800259d4:	1354b823          	sd	s5,304(s1)
        initsleeplock(&de->lock, "entry");
    800259d8:	85d2                	mv	a1,s4
    800259da:	13848513          	addi	a0,s1,312
    800259de:	ffffe097          	auipc	ra,0xffffe
    800259e2:	d06080e7          	jalr	-762(ra) # 800236e4 <initsleeplock>
        root.next->prev = de;
    800259e6:	15093783          	ld	a5,336(s2)
    800259ea:	1297b823          	sd	s1,304(a5)
        root.next = de;
    800259ee:	14993823          	sd	s1,336(s2)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    800259f2:	16848493          	addi	s1,s1,360
    800259f6:	fd3491e3          	bne	s1,s3,800259b8 <fat32_init+0x150>
}
    800259fa:	4501                	li	a0,0
    800259fc:	70e2                	ld	ra,56(sp)
    800259fe:	7442                	ld	s0,48(sp)
    80025a00:	74a2                	ld	s1,40(sp)
    80025a02:	7902                	ld	s2,32(sp)
    80025a04:	69e2                	ld	s3,24(sp)
    80025a06:	6a42                	ld	s4,16(sp)
    80025a08:	6aa2                	ld	s5,8(sp)
    80025a0a:	6121                	addi	sp,sp,64
    80025a0c:	8082                	ret
        panic("not FAT32 volume");
    80025a0e:	00007517          	auipc	a0,0x7
    80025a12:	9da50513          	addi	a0,a0,-1574 # 8002c3e8 <syscalls+0xa80>
    80025a16:	ffffa097          	auipc	ra,0xffffa
    80025a1a:	730080e7          	jalr	1840(ra) # 80020146 <panic>
        panic("byts_per_sec != BSIZE");
    80025a1e:	00007517          	auipc	a0,0x7
    80025a22:	9e250513          	addi	a0,a0,-1566 # 8002c400 <syscalls+0xa98>
    80025a26:	ffffa097          	auipc	ra,0xffffa
    80025a2a:	720080e7          	jalr	1824(ra) # 80020146 <panic>

0000000080025a2e <eread>:
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025a2e:	10852783          	lw	a5,264(a0)
    80025a32:	0ed7e863          	bltu	a5,a3,80025b22 <eread+0xf4>
{
    80025a36:	711d                	addi	sp,sp,-96
    80025a38:	ec86                	sd	ra,88(sp)
    80025a3a:	e8a2                	sd	s0,80(sp)
    80025a3c:	e4a6                	sd	s1,72(sp)
    80025a3e:	e0ca                	sd	s2,64(sp)
    80025a40:	fc4e                	sd	s3,56(sp)
    80025a42:	f852                	sd	s4,48(sp)
    80025a44:	f456                	sd	s5,40(sp)
    80025a46:	f05a                	sd	s6,32(sp)
    80025a48:	ec5e                	sd	s7,24(sp)
    80025a4a:	e862                	sd	s8,16(sp)
    80025a4c:	e466                	sd	s9,8(sp)
    80025a4e:	e06a                	sd	s10,0(sp)
    80025a50:	1080                	addi	s0,sp,96
    80025a52:	8a2a                	mv	s4,a0
    80025a54:	8bae                	mv	s7,a1
    80025a56:	8ab2                	mv	s5,a2
    80025a58:	8936                	mv	s2,a3
    80025a5a:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025a5c:	9eb9                	addw	a3,a3,a4
        return 0;
    80025a5e:	4501                	li	a0,0
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025a60:	0b26e163          	bltu	a3,s2,80025b02 <eread+0xd4>
    80025a64:	100a4703          	lbu	a4,256(s4)
    80025a68:	8b41                	andi	a4,a4,16
    80025a6a:	ef41                	bnez	a4,80025b02 <eread+0xd4>
    if (off + n > entry->file_size) {
    80025a6c:	00d7f463          	bgeu	a5,a3,80025a74 <eread+0x46>
        n = entry->file_size - off;
    80025a70:	41278b3b          	subw	s6,a5,s2
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025a74:	10ca2703          	lw	a4,268(s4)
    80025a78:	100007b7          	lui	a5,0x10000
    80025a7c:	17dd                	addi	a5,a5,-9
    80025a7e:	06e7ef63          	bltu	a5,a4,80025afc <eread+0xce>
    80025a82:	080b0e63          	beqz	s6,80025b1e <eread+0xf0>
    80025a86:	4981                	li	s3,0
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025a88:	0001bc97          	auipc	s9,0x1b
    80025a8c:	9a0c8c93          	addi	s9,s9,-1632 # 80040428 <fat>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025a90:	8c3e                	mv	s8,a5
    80025a92:	a82d                	j	80025acc <eread+0x9e>
    80025a94:	00048d1b          	sext.w	s10,s1
        if (rw_clus(entry->cur_clus, 0, user_dst, dst, off % fat.byts_per_clus, m) != m) {
    80025a98:	87ea                	mv	a5,s10
    80025a9a:	86d6                	mv	a3,s5
    80025a9c:	865e                	mv	a2,s7
    80025a9e:	4581                	li	a1,0
    80025aa0:	10ca2503          	lw	a0,268(s4)
    80025aa4:	00000097          	auipc	ra,0x0
    80025aa8:	a4e080e7          	jalr	-1458(ra) # 800254f2 <rw_clus>
    80025aac:	2501                	sext.w	a0,a0
    80025aae:	05a51863          	bne	a0,s10,80025afe <eread+0xd0>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025ab2:	013489bb          	addw	s3,s1,s3
    80025ab6:	0124893b          	addw	s2,s1,s2
    80025aba:	1482                	slli	s1,s1,0x20
    80025abc:	9081                	srli	s1,s1,0x20
    80025abe:	9aa6                	add	s5,s5,s1
    80025ac0:	10ca2783          	lw	a5,268(s4)
    80025ac4:	02fc6d63          	bltu	s8,a5,80025afe <eread+0xd0>
    80025ac8:	0369fb63          	bgeu	s3,s6,80025afe <eread+0xd0>
        reloc_clus(entry, off, 0);
    80025acc:	4601                	li	a2,0
    80025ace:	85ca                	mv	a1,s2
    80025ad0:	8552                	mv	a0,s4
    80025ad2:	00000097          	auipc	ra,0x0
    80025ad6:	90e080e7          	jalr	-1778(ra) # 800253e0 <reloc_clus>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025ada:	00cca783          	lw	a5,12(s9)
    80025ade:	02f976bb          	remuw	a3,s2,a5
    80025ae2:	0006871b          	sext.w	a4,a3
    80025ae6:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    80025ae8:	413b06bb          	subw	a3,s6,s3
    80025aec:	84b6                	mv	s1,a3
    80025aee:	2681                	sext.w	a3,a3
    80025af0:	0007861b          	sext.w	a2,a5
    80025af4:	fad670e3          	bgeu	a2,a3,80025a94 <eread+0x66>
    80025af8:	84be                	mv	s1,a5
    80025afa:	bf69                	j	80025a94 <eread+0x66>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025afc:	4981                	li	s3,0
    return tot;
    80025afe:	0009851b          	sext.w	a0,s3
}
    80025b02:	60e6                	ld	ra,88(sp)
    80025b04:	6446                	ld	s0,80(sp)
    80025b06:	64a6                	ld	s1,72(sp)
    80025b08:	6906                	ld	s2,64(sp)
    80025b0a:	79e2                	ld	s3,56(sp)
    80025b0c:	7a42                	ld	s4,48(sp)
    80025b0e:	7aa2                	ld	s5,40(sp)
    80025b10:	7b02                	ld	s6,32(sp)
    80025b12:	6be2                	ld	s7,24(sp)
    80025b14:	6c42                	ld	s8,16(sp)
    80025b16:	6ca2                	ld	s9,8(sp)
    80025b18:	6d02                	ld	s10,0(sp)
    80025b1a:	6125                	addi	sp,sp,96
    80025b1c:	8082                	ret
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025b1e:	89da                	mv	s3,s6
    80025b20:	bff9                	j	80025afe <eread+0xd0>
        return 0;
    80025b22:	4501                	li	a0,0
}
    80025b24:	8082                	ret

0000000080025b26 <ewrite>:
    if (off > entry->file_size || off + n < off || (uint64)off + n > 0xffffffff
    80025b26:	10852783          	lw	a5,264(a0)
    80025b2a:	0ed7e363          	bltu	a5,a3,80025c10 <ewrite+0xea>
{
    80025b2e:	711d                	addi	sp,sp,-96
    80025b30:	ec86                	sd	ra,88(sp)
    80025b32:	e8a2                	sd	s0,80(sp)
    80025b34:	e4a6                	sd	s1,72(sp)
    80025b36:	e0ca                	sd	s2,64(sp)
    80025b38:	fc4e                	sd	s3,56(sp)
    80025b3a:	f852                	sd	s4,48(sp)
    80025b3c:	f456                	sd	s5,40(sp)
    80025b3e:	f05a                	sd	s6,32(sp)
    80025b40:	ec5e                	sd	s7,24(sp)
    80025b42:	e862                	sd	s8,16(sp)
    80025b44:	e466                	sd	s9,8(sp)
    80025b46:	1080                	addi	s0,sp,96
    80025b48:	8aaa                	mv	s5,a0
    80025b4a:	8bae                	mv	s7,a1
    80025b4c:	8a32                	mv	s4,a2
    80025b4e:	8936                	mv	s2,a3
    80025b50:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (uint64)off + n > 0xffffffff
    80025b52:	00e687bb          	addw	a5,a3,a4
    80025b56:	0ad7ef63          	bltu	a5,a3,80025c14 <ewrite+0xee>
    80025b5a:	02069793          	slli	a5,a3,0x20
    80025b5e:	9381                	srli	a5,a5,0x20
    80025b60:	1702                	slli	a4,a4,0x20
    80025b62:	9301                	srli	a4,a4,0x20
    80025b64:	97ba                	add	a5,a5,a4
    80025b66:	577d                	li	a4,-1
    80025b68:	9301                	srli	a4,a4,0x20
    80025b6a:	0af76763          	bltu	a4,a5,80025c18 <ewrite+0xf2>
        || (entry->attribute & ATTR_READ_ONLY)) {
    80025b6e:	10054783          	lbu	a5,256(a0)
    80025b72:	8b85                	andi	a5,a5,1
    80025b74:	e7c5                	bnez	a5,80025c1c <ewrite+0xf6>
    if (entry->first_clus == 0) {   // so file_size if 0 too, which requests off == 0
    80025b76:	10452783          	lw	a5,260(a0)
    80025b7a:	cb91                	beqz	a5,80025b8e <ewrite+0x68>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025b7c:	4981                	li	s3,0
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025b7e:	0001bc17          	auipc	s8,0x1b
    80025b82:	8aac0c13          	addi	s8,s8,-1878 # 80040428 <fat>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025b86:	040b1d63          	bnez	s6,80025be0 <ewrite+0xba>
    80025b8a:	89da                	mv	s3,s6
    80025b8c:	a05d                	j	80025c32 <ewrite+0x10c>
        entry->cur_clus = entry->first_clus = alloc_clus(entry->dev);
    80025b8e:	11454503          	lbu	a0,276(a0)
    80025b92:	fffff097          	auipc	ra,0xfffff
    80025b96:	688080e7          	jalr	1672(ra) # 8002521a <alloc_clus>
    80025b9a:	2501                	sext.w	a0,a0
    80025b9c:	10aaa223          	sw	a0,260(s5)
    80025ba0:	10aaa623          	sw	a0,268(s5)
        entry->clus_cnt = 0;
    80025ba4:	100aa823          	sw	zero,272(s5)
        entry->dirty = 1;
    80025ba8:	4785                	li	a5,1
    80025baa:	10fa8aa3          	sb	a5,277(s5)
    80025bae:	b7f9                	j	80025b7c <ewrite+0x56>
    80025bb0:	00048c9b          	sext.w	s9,s1
        if (rw_clus(entry->cur_clus, 1, user_src, src, off % fat.byts_per_clus, m) != m) {
    80025bb4:	87e6                	mv	a5,s9
    80025bb6:	86d2                	mv	a3,s4
    80025bb8:	865e                	mv	a2,s7
    80025bba:	4585                	li	a1,1
    80025bbc:	10caa503          	lw	a0,268(s5)
    80025bc0:	00000097          	auipc	ra,0x0
    80025bc4:	932080e7          	jalr	-1742(ra) # 800254f2 <rw_clus>
    80025bc8:	2501                	sext.w	a0,a0
    80025bca:	04ac9b63          	bne	s9,a0,80025c20 <ewrite+0xfa>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025bce:	013489bb          	addw	s3,s1,s3
    80025bd2:	0124893b          	addw	s2,s1,s2
    80025bd6:	1482                	slli	s1,s1,0x20
    80025bd8:	9081                	srli	s1,s1,0x20
    80025bda:	9a26                	add	s4,s4,s1
    80025bdc:	0569f263          	bgeu	s3,s6,80025c20 <ewrite+0xfa>
        reloc_clus(entry, off, 1);
    80025be0:	4605                	li	a2,1
    80025be2:	85ca                	mv	a1,s2
    80025be4:	8556                	mv	a0,s5
    80025be6:	fffff097          	auipc	ra,0xfffff
    80025bea:	7fa080e7          	jalr	2042(ra) # 800253e0 <reloc_clus>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025bee:	00cc2783          	lw	a5,12(s8)
    80025bf2:	02f976bb          	remuw	a3,s2,a5
    80025bf6:	0006871b          	sext.w	a4,a3
    80025bfa:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    80025bfc:	413b06bb          	subw	a3,s6,s3
    80025c00:	84b6                	mv	s1,a3
    80025c02:	2681                	sext.w	a3,a3
    80025c04:	0007861b          	sext.w	a2,a5
    80025c08:	fad674e3          	bgeu	a2,a3,80025bb0 <ewrite+0x8a>
    80025c0c:	84be                	mv	s1,a5
    80025c0e:	b74d                	j	80025bb0 <ewrite+0x8a>
        return -1;
    80025c10:	557d                	li	a0,-1
}
    80025c12:	8082                	ret
        return -1;
    80025c14:	557d                	li	a0,-1
    80025c16:	a005                	j	80025c36 <ewrite+0x110>
    80025c18:	557d                	li	a0,-1
    80025c1a:	a831                	j	80025c36 <ewrite+0x110>
    80025c1c:	557d                	li	a0,-1
    80025c1e:	a821                	j	80025c36 <ewrite+0x110>
        if(off > entry->file_size) {
    80025c20:	108aa783          	lw	a5,264(s5)
    80025c24:	0127f763          	bgeu	a5,s2,80025c32 <ewrite+0x10c>
            entry->file_size = off;
    80025c28:	112aa423          	sw	s2,264(s5)
            entry->dirty = 1;
    80025c2c:	4785                	li	a5,1
    80025c2e:	10fa8aa3          	sb	a5,277(s5)
    return tot;
    80025c32:	0009851b          	sext.w	a0,s3
}
    80025c36:	60e6                	ld	ra,88(sp)
    80025c38:	6446                	ld	s0,80(sp)
    80025c3a:	64a6                	ld	s1,72(sp)
    80025c3c:	6906                	ld	s2,64(sp)
    80025c3e:	79e2                	ld	s3,56(sp)
    80025c40:	7a42                	ld	s4,48(sp)
    80025c42:	7aa2                	ld	s5,40(sp)
    80025c44:	7b02                	ld	s6,32(sp)
    80025c46:	6be2                	ld	s7,24(sp)
    80025c48:	6c42                	ld	s8,16(sp)
    80025c4a:	6ca2                	ld	s9,8(sp)
    80025c4c:	6125                	addi	sp,sp,96
    80025c4e:	8082                	ret

0000000080025c50 <formatname>:
{
    80025c50:	7179                	addi	sp,sp,-48
    80025c52:	f406                	sd	ra,40(sp)
    80025c54:	f022                	sd	s0,32(sp)
    80025c56:	ec26                	sd	s1,24(sp)
    80025c58:	e84a                	sd	s2,16(sp)
    80025c5a:	e44e                	sd	s3,8(sp)
    80025c5c:	e052                	sd	s4,0(sp)
    80025c5e:	1800                	addi	s0,sp,48
    80025c60:	84aa                	mv	s1,a0
    while (*name == ' ' || *name == '.') { name++; }
    80025c62:	02000793          	li	a5,32
    80025c66:	02e00713          	li	a4,46
    80025c6a:	a011                	j	80025c6e <formatname+0x1e>
    80025c6c:	0485                	addi	s1,s1,1
    80025c6e:	0004c583          	lbu	a1,0(s1)
    80025c72:	fef58de3          	beq	a1,a5,80025c6c <formatname+0x1c>
    80025c76:	fee58be3          	beq	a1,a4,80025c6c <formatname+0x1c>
    for (p = name; *p; p++) {
    80025c7a:	c5b9                	beqz	a1,80025cc8 <formatname+0x78>
        if (c < 0x20 || strchr(illegal, c)) {
    80025c7c:	47fd                	li	a5,31
    80025c7e:	04b7f763          	bgeu	a5,a1,80025ccc <formatname+0x7c>
    80025c82:	8926                	mv	s2,s1
    80025c84:	00008997          	auipc	s3,0x8
    80025c88:	edc98993          	addi	s3,s3,-292 # 8002db60 <illegal.1655>
    80025c8c:	4a7d                	li	s4,31
    80025c8e:	854e                	mv	a0,s3
    80025c90:	ffffb097          	auipc	ra,0xffffb
    80025c94:	d60080e7          	jalr	-672(ra) # 800209f0 <strchr>
    80025c98:	ed05                	bnez	a0,80025cd0 <formatname+0x80>
    for (p = name; *p; p++) {
    80025c9a:	0905                	addi	s2,s2,1
    80025c9c:	00094583          	lbu	a1,0(s2)
    80025ca0:	c581                	beqz	a1,80025ca8 <formatname+0x58>
        if (c < 0x20 || strchr(illegal, c)) {
    80025ca2:	feba66e3          	bltu	s4,a1,80025c8e <formatname+0x3e>
    80025ca6:	a035                	j	80025cd2 <formatname+0x82>
        if (*p != ' ') {
    80025ca8:	02000693          	li	a3,32
    80025cac:	874a                	mv	a4,s2
    while (p-- > name) {
    80025cae:	0124fb63          	bgeu	s1,s2,80025cc4 <formatname+0x74>
        if (*p != ' ') {
    80025cb2:	197d                	addi	s2,s2,-1
    80025cb4:	00094783          	lbu	a5,0(s2)
    80025cb8:	fed78ae3          	beq	a5,a3,80025cac <formatname+0x5c>
            p[1] = '\0';
    80025cbc:	00070023          	sb	zero,0(a4)
            break;
    80025cc0:	8526                	mv	a0,s1
    80025cc2:	a801                	j	80025cd2 <formatname+0x82>
    80025cc4:	8526                	mv	a0,s1
    80025cc6:	a031                	j	80025cd2 <formatname+0x82>
    for (p = name; *p; p++) {
    80025cc8:	8526                	mv	a0,s1
    80025cca:	a021                	j	80025cd2 <formatname+0x82>
            return 0;
    80025ccc:	4501                	li	a0,0
    80025cce:	a011                	j	80025cd2 <formatname+0x82>
    80025cd0:	4501                	li	a0,0
}
    80025cd2:	70a2                	ld	ra,40(sp)
    80025cd4:	7402                	ld	s0,32(sp)
    80025cd6:	64e2                	ld	s1,24(sp)
    80025cd8:	6942                	ld	s2,16(sp)
    80025cda:	69a2                	ld	s3,8(sp)
    80025cdc:	6a02                	ld	s4,0(sp)
    80025cde:	6145                	addi	sp,sp,48
    80025ce0:	8082                	ret

0000000080025ce2 <cal_checksum>:
{
    80025ce2:	1141                	addi	sp,sp,-16
    80025ce4:	e422                	sd	s0,8(sp)
    80025ce6:	0800                	addi	s0,sp,16
    for (int i = CHAR_SHORT_NAME; i != 0; i--) {
    80025ce8:	00b50613          	addi	a2,a0,11
    uint8 sum = 0;
    80025cec:	4781                	li	a5,0
        sum = ((sum & 1) ? 0x80 : 0) + (sum >> 1) + *shortname++;
    80025cee:	0077971b          	slliw	a4,a5,0x7
    80025cf2:	0505                	addi	a0,a0,1
    80025cf4:	0017d79b          	srliw	a5,a5,0x1
    80025cf8:	fff54683          	lbu	a3,-1(a0)
    80025cfc:	9fb5                	addw	a5,a5,a3
    80025cfe:	97ba                	add	a5,a5,a4
    80025d00:	0ff7f793          	andi	a5,a5,255
    for (int i = CHAR_SHORT_NAME; i != 0; i--) {
    80025d04:	fea615e3          	bne	a2,a0,80025cee <cal_checksum+0xc>
}
    80025d08:	853e                	mv	a0,a5
    80025d0a:	6422                	ld	s0,8(sp)
    80025d0c:	0141                	addi	sp,sp,16
    80025d0e:	8082                	ret

0000000080025d10 <emake>:
{
    80025d10:	7171                	addi	sp,sp,-176
    80025d12:	f506                	sd	ra,168(sp)
    80025d14:	f122                	sd	s0,160(sp)
    80025d16:	ed26                	sd	s1,152(sp)
    80025d18:	e94a                	sd	s2,144(sp)
    80025d1a:	e54e                	sd	s3,136(sp)
    80025d1c:	e152                	sd	s4,128(sp)
    80025d1e:	fcd6                	sd	s5,120(sp)
    80025d20:	f8da                	sd	s6,112(sp)
    80025d22:	f4de                	sd	s7,104(sp)
    80025d24:	f0e2                	sd	s8,96(sp)
    80025d26:	ece6                	sd	s9,88(sp)
    80025d28:	e8ea                	sd	s10,80(sp)
    80025d2a:	e4ee                	sd	s11,72(sp)
    80025d2c:	1900                	addi	s0,sp,176
    if (!(dp->attribute & ATTR_DIRECTORY))
    80025d2e:	10054783          	lbu	a5,256(a0)
    80025d32:	8bc1                	andi	a5,a5,16
    80025d34:	c3d5                	beqz	a5,80025dd8 <emake+0xc8>
    80025d36:	89aa                	mv	s3,a0
    80025d38:	8aae                	mv	s5,a1
    80025d3a:	8932                	mv	s2,a2
    if (off % sizeof(union dentry))
    80025d3c:	01f67793          	andi	a5,a2,31
    80025d40:	e7c5                	bnez	a5,80025de8 <emake+0xd8>
    memset(&de, 0, sizeof(de));
    80025d42:	02000613          	li	a2,32
    80025d46:	4581                	li	a1,0
    80025d48:	f7040513          	addi	a0,s0,-144
    80025d4c:	ffffb097          	auipc	ra,0xffffb
    80025d50:	a10080e7          	jalr	-1520(ra) # 8002075c <memset>
    if (off <= 32) {
    80025d54:	02000793          	li	a5,32
    80025d58:	0b27ec63          	bltu	a5,s2,80025e10 <emake+0x100>
        if (off == 0) {
    80025d5c:	08091e63          	bnez	s2,80025df8 <emake+0xe8>
            strncpy(de.sne.name, ".          ", sizeof(de.sne.name));
    80025d60:	462d                	li	a2,11
    80025d62:	00006597          	auipc	a1,0x6
    80025d66:	6ee58593          	addi	a1,a1,1774 # 8002c450 <syscalls+0xae8>
    80025d6a:	f7040513          	addi	a0,s0,-144
    80025d6e:	ffffb097          	auipc	ra,0xffffb
    80025d72:	b26080e7          	jalr	-1242(ra) # 80020894 <strncpy>
        de.sne.attr = ATTR_DIRECTORY;
    80025d76:	47c1                	li	a5,16
    80025d78:	f6f40da3          	sb	a5,-133(s0)
        de.sne.fst_clus_hi = (uint16)(ep->first_clus >> 16);        // first clus high 16 bits
    80025d7c:	104aa783          	lw	a5,260(s5)
    80025d80:	0107d71b          	srliw	a4,a5,0x10
    80025d84:	f8e41223          	sh	a4,-124(s0)
        de.sne.fst_clus_lo = (uint16)(ep->first_clus & 0xffff);       // low 16 bits
    80025d88:	f8f41523          	sh	a5,-118(s0)
        de.sne.file_size = 0;                                       // filesize is updated in eupdate()
    80025d8c:	f8042623          	sw	zero,-116(s0)
        off = reloc_clus(dp, off, 1);
    80025d90:	4605                	li	a2,1
    80025d92:	85ca                	mv	a1,s2
    80025d94:	854e                	mv	a0,s3
    80025d96:	fffff097          	auipc	ra,0xfffff
    80025d9a:	64a080e7          	jalr	1610(ra) # 800253e0 <reloc_clus>
        rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    80025d9e:	02000793          	li	a5,32
    80025da2:	0005071b          	sext.w	a4,a0
    80025da6:	f7040693          	addi	a3,s0,-144
    80025daa:	4601                	li	a2,0
    80025dac:	4585                	li	a1,1
    80025dae:	10c9a503          	lw	a0,268(s3)
    80025db2:	fffff097          	auipc	ra,0xfffff
    80025db6:	740080e7          	jalr	1856(ra) # 800254f2 <rw_clus>
}
    80025dba:	70aa                	ld	ra,168(sp)
    80025dbc:	740a                	ld	s0,160(sp)
    80025dbe:	64ea                	ld	s1,152(sp)
    80025dc0:	694a                	ld	s2,144(sp)
    80025dc2:	69aa                	ld	s3,136(sp)
    80025dc4:	6a0a                	ld	s4,128(sp)
    80025dc6:	7ae6                	ld	s5,120(sp)
    80025dc8:	7b46                	ld	s6,112(sp)
    80025dca:	7ba6                	ld	s7,104(sp)
    80025dcc:	7c06                	ld	s8,96(sp)
    80025dce:	6ce6                	ld	s9,88(sp)
    80025dd0:	6d46                	ld	s10,80(sp)
    80025dd2:	6da6                	ld	s11,72(sp)
    80025dd4:	614d                	addi	sp,sp,176
    80025dd6:	8082                	ret
        panic("emake: not dir");
    80025dd8:	00006517          	auipc	a0,0x6
    80025ddc:	65050513          	addi	a0,a0,1616 # 8002c428 <syscalls+0xac0>
    80025de0:	ffffa097          	auipc	ra,0xffffa
    80025de4:	366080e7          	jalr	870(ra) # 80020146 <panic>
        panic("emake: not aligned");
    80025de8:	00006517          	auipc	a0,0x6
    80025dec:	65050513          	addi	a0,a0,1616 # 8002c438 <syscalls+0xad0>
    80025df0:	ffffa097          	auipc	ra,0xffffa
    80025df4:	356080e7          	jalr	854(ra) # 80020146 <panic>
            strncpy(de.sne.name, "..         ", sizeof(de.sne.name));
    80025df8:	462d                	li	a2,11
    80025dfa:	00006597          	auipc	a1,0x6
    80025dfe:	66658593          	addi	a1,a1,1638 # 8002c460 <syscalls+0xaf8>
    80025e02:	f7040513          	addi	a0,s0,-144
    80025e06:	ffffb097          	auipc	ra,0xffffb
    80025e0a:	a8e080e7          	jalr	-1394(ra) # 80020894 <strncpy>
    80025e0e:	b7a5                	j	80025d76 <emake+0x66>
        int entcnt = (strlen(ep->filename) + CHAR_LONG_NAME - 1) / CHAR_LONG_NAME;   // count of l-n-entries, rounds up
    80025e10:	8cd6                	mv	s9,s5
    80025e12:	8556                	mv	a0,s5
    80025e14:	ffffb097          	auipc	ra,0xffffb
    80025e18:	af2080e7          	jalr	-1294(ra) # 80020906 <strlen>
    80025e1c:	f4a43c23          	sd	a0,-168(s0)
    80025e20:	00c5071b          	addiw	a4,a0,12
    80025e24:	47b5                	li	a5,13
    80025e26:	02f747bb          	divw	a5,a4,a5
    80025e2a:	f4f42a23          	sw	a5,-172(s0)
    80025e2e:	00078b1b          	sext.w	s6,a5
        memset(shortname, 0, sizeof(shortname));
    80025e32:	4631                	li	a2,12
    80025e34:	4581                	li	a1,0
    80025e36:	f6040513          	addi	a0,s0,-160
    80025e3a:	ffffb097          	auipc	ra,0xffffb
    80025e3e:	922080e7          	jalr	-1758(ra) # 8002075c <memset>
    for (int j = strlen(name) - 1; j >= 0; j--) {
    80025e42:	8556                	mv	a0,s5
    80025e44:	ffffb097          	auipc	ra,0xffffb
    80025e48:	ac2080e7          	jalr	-1342(ra) # 80020906 <strlen>
    80025e4c:	fff5079b          	addiw	a5,a0,-1
    80025e50:	0207cf63          	bltz	a5,80025e8e <emake+0x17e>
        if (name[j] == '.') {
    80025e54:	00fa8733          	add	a4,s5,a5
    80025e58:	00074603          	lbu	a2,0(a4)
    80025e5c:	02e00693          	li	a3,46
    80025e60:	04d60363          	beq	a2,a3,80025ea6 <emake+0x196>
    80025e64:	17fd                	addi	a5,a5,-1
    80025e66:	97d6                	add	a5,a5,s5
    80025e68:	ffea8693          	addi	a3,s5,-2
    80025e6c:	96aa                	add	a3,a3,a0
    80025e6e:	fff5071b          	addiw	a4,a0,-1
    80025e72:	1702                	slli	a4,a4,0x20
    80025e74:	9301                	srli	a4,a4,0x20
    80025e76:	8e99                	sub	a3,a3,a4
    80025e78:	02e00613          	li	a2,46
    for (int j = strlen(name) - 1; j >= 0; j--) {
    80025e7c:	00d78963          	beq	a5,a3,80025e8e <emake+0x17e>
        if (name[j] == '.') {
    80025e80:	85be                	mv	a1,a5
    80025e82:	17fd                	addi	a5,a5,-1
    80025e84:	0017c703          	lbu	a4,1(a5) # 10000001 <BASE_ADDRESS-0x7001ffff>
    80025e88:	fec71ae3          	bne	a4,a2,80025e7c <emake+0x16c>
    80025e8c:	8cae                	mv	s9,a1
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025e8e:	001a8b93          	addi	s7,s5,1
    80025e92:	000aca03          	lbu	s4,0(s5)
    80025e96:	4481                	li	s1,0
    80025e98:	000a0963          	beqz	s4,80025eaa <emake+0x19a>
        if (i == 8 && p) {
    80025e9c:	4c21                	li	s8,8
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025e9e:	4d29                	li	s10,10
        if (c == '.') {
    80025ea0:	02e00d93          	li	s11,46
    80025ea4:	a0e1                	j	80025f6c <emake+0x25c>
        if (name[j] == '.') {
    80025ea6:	8cba                	mv	s9,a4
    80025ea8:	b7dd                	j	80025e8e <emake+0x17e>
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025eaa:	4481                	li	s1,0
    80025eac:	a039                	j	80025eba <emake+0x1aa>
        if (i == 8 && p) {
    80025eae:	1e0c8963          	beqz	s9,800260a0 <emake+0x390>
            if (p + 1 < name) { break; }            // no '.'
    80025eb2:	001c8793          	addi	a5,s9,1
    80025eb6:	0777fd63          	bgeu	a5,s7,80025f30 <emake+0x220>
    80025eba:	f6040793          	addi	a5,s0,-160
    80025ebe:	97a6                	add	a5,a5,s1
        shortname[i++] = ' ';
    80025ec0:	02000693          	li	a3,32
    while (i < CHAR_SHORT_NAME) {
    80025ec4:	4729                	li	a4,10
        shortname[i++] = ' ';
    80025ec6:	2485                	addiw	s1,s1,1
    80025ec8:	00d78023          	sb	a3,0(a5)
    80025ecc:	0785                	addi	a5,a5,1
    while (i < CHAR_SHORT_NAME) {
    80025ece:	fe975ce3          	bge	a4,s1,80025ec6 <emake+0x1b6>
        de.lne.checksum = cal_checksum((uchar *)shortname);
    80025ed2:	f6040513          	addi	a0,s0,-160
    80025ed6:	00000097          	auipc	ra,0x0
    80025eda:	e0c080e7          	jalr	-500(ra) # 80025ce2 <cal_checksum>
    80025ede:	f6a40ea3          	sb	a0,-131(s0)
        de.lne.attr = ATTR_LONG_NAME;
    80025ee2:	47bd                	li	a5,15
    80025ee4:	f6f40da3          	sb	a5,-133(s0)
        for (int i = entcnt; i > 0; i--) {
    80025ee8:	f5843783          	ld	a5,-168(s0)
    80025eec:	0cf05363          	blez	a5,80025fb2 <emake+0x2a2>
    80025ef0:	f5442783          	lw	a5,-172(s0)
    80025ef4:	37fd                	addiw	a5,a5,-1
    80025ef6:	00179c1b          	slliw	s8,a5,0x1
    80025efa:	00fc0c3b          	addw	s8,s8,a5
    80025efe:	002c1c1b          	slliw	s8,s8,0x2
    80025f02:	00fc0c3b          	addw	s8,s8,a5
    80025f06:	9c56                	add	s8,s8,s5
    80025f08:	8bda                	mv	s7,s6
            int end = 0;
    80025f0a:	4c81                	li	s9,0
                    *w++ = 0xff;            // on k210, unaligned reading is illegal
    80025f0c:	5a7d                	li	s4,-1
                switch (j) {
    80025f0e:	44ad                	li	s1,11
    80025f10:	aa8d                	j	80026082 <emake+0x372>
            if (name > p) {                    // last '.'
    80025f12:	057cf463          	bgeu	s9,s7,80025f5a <emake+0x24a>
                memset(shortname + i, ' ', 8 - i);
    80025f16:	4621                	li	a2,8
    80025f18:	9e05                	subw	a2,a2,s1
    80025f1a:	02000593          	li	a1,32
    80025f1e:	f6040793          	addi	a5,s0,-160
    80025f22:	00978533          	add	a0,a5,s1
    80025f26:	ffffb097          	auipc	ra,0xffffb
    80025f2a:	836080e7          	jalr	-1994(ra) # 8002075c <memset>
    80025f2e:	87de                	mv	a5,s7
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025f30:	84e2                	mv	s1,s8
    80025f32:	4c81                	li	s9,0
    80025f34:	a035                	j	80025f60 <emake+0x250>
            if (strchr(illegal, c) != NULL) {
    80025f36:	85d2                	mv	a1,s4
    80025f38:	00008517          	auipc	a0,0x8
    80025f3c:	c4050513          	addi	a0,a0,-960 # 8002db78 <illegal.1671>
    80025f40:	ffffb097          	auipc	ra,0xffffb
    80025f44:	ab0080e7          	jalr	-1360(ra) # 800209f0 <strchr>
    80025f48:	c119                	beqz	a0,80025f4e <emake+0x23e>
                c = '_';
    80025f4a:	05f00a13          	li	s4,95
        shortname[i++] = c;
    80025f4e:	f9040793          	addi	a5,s0,-112
    80025f52:	97a6                	add	a5,a5,s1
    80025f54:	fd478823          	sb	s4,-48(a5)
    80025f58:	2485                	addiw	s1,s1,1
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025f5a:	f69d4ce3          	blt	s10,s1,80025ed2 <emake+0x1c2>
    80025f5e:	87de                	mv	a5,s7
    80025f60:	00178b93          	addi	s7,a5,1
    80025f64:	0007ca03          	lbu	s4,0(a5)
    80025f68:	f40a09e3          	beqz	s4,80025eba <emake+0x1aa>
        if (i == 8 && p) {
    80025f6c:	f58481e3          	beq	s1,s8,80025eae <emake+0x19e>
        if (c == ' ') { continue; }
    80025f70:	02000793          	li	a5,32
    80025f74:	fefa03e3          	beq	s4,a5,80025f5a <emake+0x24a>
        if (c == '.') {
    80025f78:	f9ba0de3          	beq	s4,s11,80025f12 <emake+0x202>
        if (c >= 'a' && c <= 'z') {
    80025f7c:	f9fa079b          	addiw	a5,s4,-97
    80025f80:	0ff7f793          	andi	a5,a5,255
    80025f84:	4765                	li	a4,25
    80025f86:	faf768e3          	bltu	a4,a5,80025f36 <emake+0x226>
            c += 'A' - 'a';
    80025f8a:	3a01                	addiw	s4,s4,-32
    80025f8c:	0ffa7a13          	andi	s4,s4,255
    80025f90:	bf7d                	j	80025f4e <emake+0x23e>
                de.lne.order |= LAST_LONG_ENTRY;
    80025f92:	0407e793          	ori	a5,a5,64
    80025f96:	f6f40823          	sb	a5,-144(s0)
    80025f9a:	a8d5                	j	8002608e <emake+0x37e>
                    if ((*w++ = *p++) == 0) {
    80025f9c:	0005c683          	lbu	a3,0(a1)
    80025fa0:	00d78023          	sb	a3,0(a5)
                        end = 1;
    80025fa4:	0016b693          	seqz	a3,a3
                    *w++ = 0;
    80025fa8:	000780a3          	sb	zero,1(a5)
    80025fac:	0789                	addi	a5,a5,2
                    if ((*w++ = *p++) == 0) {
    80025fae:	0585                	addi	a1,a1,1
    80025fb0:	a079                	j	8002603e <emake+0x32e>
        memset(&de, 0, sizeof(de));
    80025fb2:	02000613          	li	a2,32
    80025fb6:	4581                	li	a1,0
    80025fb8:	f7040513          	addi	a0,s0,-144
    80025fbc:	ffffa097          	auipc	ra,0xffffa
    80025fc0:	7a0080e7          	jalr	1952(ra) # 8002075c <memset>
        strncpy(de.sne.name, shortname, sizeof(de.sne.name));
    80025fc4:	462d                	li	a2,11
    80025fc6:	f6040593          	addi	a1,s0,-160
    80025fca:	f7040513          	addi	a0,s0,-144
    80025fce:	ffffb097          	auipc	ra,0xffffb
    80025fd2:	8c6080e7          	jalr	-1850(ra) # 80020894 <strncpy>
        de.sne.attr = ep->attribute;
    80025fd6:	100ac783          	lbu	a5,256(s5)
    80025fda:	f6f40da3          	sb	a5,-133(s0)
        de.sne.fst_clus_hi = (uint16)(ep->first_clus >> 16);      // first clus high 16 bits
    80025fde:	104aa783          	lw	a5,260(s5)
    80025fe2:	0107d71b          	srliw	a4,a5,0x10
    80025fe6:	f8e41223          	sh	a4,-124(s0)
        de.sne.fst_clus_lo = (uint16)(ep->first_clus & 0xffff);     // low 16 bits
    80025fea:	f8f41523          	sh	a5,-118(s0)
        de.sne.file_size = ep->file_size;                         // filesize is updated in eupdate()
    80025fee:	108aa783          	lw	a5,264(s5)
    80025ff2:	f8f42623          	sw	a5,-116(s0)
        off = reloc_clus(dp, off, 1);
    80025ff6:	4605                	li	a2,1
    80025ff8:	85ca                	mv	a1,s2
    80025ffa:	854e                	mv	a0,s3
    80025ffc:	fffff097          	auipc	ra,0xfffff
    80026000:	3e4080e7          	jalr	996(ra) # 800253e0 <reloc_clus>
        rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    80026004:	02000793          	li	a5,32
    80026008:	0005071b          	sext.w	a4,a0
    8002600c:	f7040693          	addi	a3,s0,-144
    80026010:	4601                	li	a2,0
    80026012:	4585                	li	a1,1
    80026014:	10c9a503          	lw	a0,268(s3)
    80026018:	fffff097          	auipc	ra,0xfffff
    8002601c:	4da080e7          	jalr	1242(ra) # 800254f2 <rw_clus>
}
    80026020:	bb69                	j	80025dba <emake+0xaa>
                    case 5:     w = (uint8 *)de.lne.name2; break;
    80026022:	f7e40793          	addi	a5,s0,-130
    80026026:	a019                	j	8002602c <emake+0x31c>
                    case 11:    w = (uint8 *)de.lne.name3; break;
    80026028:	f8c40793          	addi	a5,s0,-116
    8002602c:	2705                	addiw	a4,a4,1
    8002602e:	fff7061b          	addiw	a2,a4,-1
                if (end) {
    80026032:	d6ad                	beqz	a3,80025f9c <emake+0x28c>
                    *w++ = 0xff;            // on k210, unaligned reading is illegal
    80026034:	01478023          	sb	s4,0(a5)
                    *w++ = 0xff;
    80026038:	014780a3          	sb	s4,1(a5)
    8002603c:	0789                	addi	a5,a5,2
                switch (j) {
    8002603e:	fea602e3          	beq	a2,a0,80026022 <emake+0x312>
    80026042:	fe9603e3          	beq	a2,s1,80026028 <emake+0x318>
            for (int j = 1; j <= CHAR_LONG_NAME; j++) {
    80026046:	0007061b          	sext.w	a2,a4
    8002604a:	fec851e3          	bge	a6,a2,8002602c <emake+0x31c>
            uint off2 = reloc_clus(dp, off, 1);
    8002604e:	4605                	li	a2,1
    80026050:	85ca                	mv	a1,s2
    80026052:	854e                	mv	a0,s3
    80026054:	fffff097          	auipc	ra,0xfffff
    80026058:	38c080e7          	jalr	908(ra) # 800253e0 <reloc_clus>
            rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off2, sizeof(de));
    8002605c:	02000793          	li	a5,32
    80026060:	0005071b          	sext.w	a4,a0
    80026064:	f7040693          	addi	a3,s0,-144
    80026068:	8666                	mv	a2,s9
    8002606a:	4585                	li	a1,1
    8002606c:	10c9a503          	lw	a0,268(s3)
    80026070:	fffff097          	auipc	ra,0xfffff
    80026074:	482080e7          	jalr	1154(ra) # 800254f2 <rw_clus>
            off += sizeof(de);
    80026078:	0209091b          	addiw	s2,s2,32
    8002607c:	1c4d                	addi	s8,s8,-13
        for (int i = entcnt; i > 0; i--) {
    8002607e:	f3705ae3          	blez	s7,80025fb2 <emake+0x2a2>
            if ((de.lne.order = i) == entcnt) {
    80026082:	0ffbf793          	andi	a5,s7,255
    80026086:	f0fb06e3          	beq	s6,a5,80025f92 <emake+0x282>
    8002608a:	f6f40823          	sb	a5,-144(s0)
            char *p = ep->filename + (i - 1) * CHAR_LONG_NAME;
    8002608e:	3bfd                	addiw	s7,s7,-1
    80026090:	85e2                	mv	a1,s8
    80026092:	4709                	li	a4,2
            int end = 0;
    80026094:	86e6                	mv	a3,s9
            uint8 *w = (uint8 *)de.lne.name1;
    80026096:	f7140793          	addi	a5,s0,-143
                switch (j) {
    8002609a:	4515                	li	a0,5
            for (int j = 1; j <= CHAR_LONG_NAME; j++) {
    8002609c:	4835                	li	a6,13
    8002609e:	bf41                	j	8002602e <emake+0x31e>
        if (c == ' ') { continue; }
    800260a0:	02000793          	li	a5,32
    800260a4:	ecfa1ae3          	bne	s4,a5,80025f78 <emake+0x268>
    800260a8:	87de                	mv	a5,s7
    800260aa:	bd5d                	j	80025f60 <emake+0x250>

00000000800260ac <edup>:
{
    800260ac:	1101                	addi	sp,sp,-32
    800260ae:	ec06                	sd	ra,24(sp)
    800260b0:	e822                	sd	s0,16(sp)
    800260b2:	e426                	sd	s1,8(sp)
    800260b4:	1000                	addi	s0,sp,32
    800260b6:	84aa                	mv	s1,a0
    if (entry != 0) {
    800260b8:	c515                	beqz	a0,800260e4 <edup+0x38>
        acquire(&ecache.lock);
    800260ba:	0001a517          	auipc	a0,0x1a
    800260be:	4fe50513          	addi	a0,a0,1278 # 800405b8 <ecache>
    800260c2:	ffffa097          	auipc	ra,0xffffa
    800260c6:	5fe080e7          	jalr	1534(ra) # 800206c0 <acquire>
        entry->ref++;
    800260ca:	1184a783          	lw	a5,280(s1)
    800260ce:	2785                	addiw	a5,a5,1
    800260d0:	10f4ac23          	sw	a5,280(s1)
        release(&ecache.lock);
    800260d4:	0001a517          	auipc	a0,0x1a
    800260d8:	4e450513          	addi	a0,a0,1252 # 800405b8 <ecache>
    800260dc:	ffffa097          	auipc	ra,0xffffa
    800260e0:	638080e7          	jalr	1592(ra) # 80020714 <release>
}
    800260e4:	8526                	mv	a0,s1
    800260e6:	60e2                	ld	ra,24(sp)
    800260e8:	6442                	ld	s0,16(sp)
    800260ea:	64a2                	ld	s1,8(sp)
    800260ec:	6105                	addi	sp,sp,32
    800260ee:	8082                	ret

00000000800260f0 <eupdate>:
    if (!entry->dirty || entry->valid != 1) { return; }
    800260f0:	11554783          	lbu	a5,277(a0)
    800260f4:	c791                	beqz	a5,80026100 <eupdate+0x10>
    800260f6:	11651703          	lh	a4,278(a0)
    800260fa:	4785                	li	a5,1
    800260fc:	00f70363          	beq	a4,a5,80026102 <eupdate+0x12>
    80026100:	8082                	ret
{
    80026102:	715d                	addi	sp,sp,-80
    80026104:	e486                	sd	ra,72(sp)
    80026106:	e0a2                	sd	s0,64(sp)
    80026108:	fc26                	sd	s1,56(sp)
    8002610a:	f84a                	sd	s2,48(sp)
    8002610c:	0880                	addi	s0,sp,80
    8002610e:	84aa                	mv	s1,a0
    uint entcnt = 0;
    80026110:	fc042e23          	sw	zero,-36(s0)
    uint32 off = reloc_clus(entry->parent, entry->off, 0);
    80026114:	4601                	li	a2,0
    80026116:	11c52583          	lw	a1,284(a0)
    8002611a:	12053503          	ld	a0,288(a0)
    8002611e:	fffff097          	auipc	ra,0xfffff
    80026122:	2c2080e7          	jalr	706(ra) # 800253e0 <reloc_clus>
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64) &entcnt, off, 1);
    80026126:	1204b803          	ld	a6,288(s1)
    8002612a:	4785                	li	a5,1
    8002612c:	0005071b          	sext.w	a4,a0
    80026130:	fdc40693          	addi	a3,s0,-36
    80026134:	4601                	li	a2,0
    80026136:	4581                	li	a1,0
    80026138:	10c82503          	lw	a0,268(a6)
    8002613c:	fffff097          	auipc	ra,0xfffff
    80026140:	3b6080e7          	jalr	950(ra) # 800254f2 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    80026144:	fdc42583          	lw	a1,-36(s0)
    80026148:	fbf5f593          	andi	a1,a1,-65
    8002614c:	fcb42e23          	sw	a1,-36(s0)
    off = reloc_clus(entry->parent, entry->off + (entcnt << 5), 0);
    80026150:	0055959b          	slliw	a1,a1,0x5
    80026154:	11c4a783          	lw	a5,284(s1)
    80026158:	4601                	li	a2,0
    8002615a:	9dbd                	addw	a1,a1,a5
    8002615c:	1204b503          	ld	a0,288(s1)
    80026160:	fffff097          	auipc	ra,0xfffff
    80026164:	280080e7          	jalr	640(ra) # 800253e0 <reloc_clus>
    80026168:	0005091b          	sext.w	s2,a0
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64)&de, off, sizeof(de));
    8002616c:	1204b503          	ld	a0,288(s1)
    80026170:	02000793          	li	a5,32
    80026174:	874a                	mv	a4,s2
    80026176:	fb840693          	addi	a3,s0,-72
    8002617a:	4601                	li	a2,0
    8002617c:	4581                	li	a1,0
    8002617e:	10c52503          	lw	a0,268(a0)
    80026182:	fffff097          	auipc	ra,0xfffff
    80026186:	370080e7          	jalr	880(ra) # 800254f2 <rw_clus>
    de.sne.fst_clus_hi = (uint16)(entry->first_clus >> 16);
    8002618a:	1044a783          	lw	a5,260(s1)
    8002618e:	0107d71b          	srliw	a4,a5,0x10
    80026192:	fce41623          	sh	a4,-52(s0)
    de.sne.fst_clus_lo = (uint16)(entry->first_clus & 0xffff);
    80026196:	fcf41923          	sh	a5,-46(s0)
    de.sne.file_size = entry->file_size;
    8002619a:	1084a783          	lw	a5,264(s1)
    8002619e:	fcf42a23          	sw	a5,-44(s0)
    rw_clus(entry->parent->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    800261a2:	1204b503          	ld	a0,288(s1)
    800261a6:	02000793          	li	a5,32
    800261aa:	874a                	mv	a4,s2
    800261ac:	fb840693          	addi	a3,s0,-72
    800261b0:	4601                	li	a2,0
    800261b2:	4585                	li	a1,1
    800261b4:	10c52503          	lw	a0,268(a0)
    800261b8:	fffff097          	auipc	ra,0xfffff
    800261bc:	33a080e7          	jalr	826(ra) # 800254f2 <rw_clus>
    entry->dirty = 0;
    800261c0:	10048aa3          	sb	zero,277(s1)
}
    800261c4:	60a6                	ld	ra,72(sp)
    800261c6:	6406                	ld	s0,64(sp)
    800261c8:	74e2                	ld	s1,56(sp)
    800261ca:	7942                	ld	s2,48(sp)
    800261cc:	6161                	addi	sp,sp,80
    800261ce:	8082                	ret

00000000800261d0 <eremove>:
    if (entry->valid != 1) { return; }
    800261d0:	11651703          	lh	a4,278(a0)
    800261d4:	4785                	li	a5,1
    800261d6:	00f70363          	beq	a4,a5,800261dc <eremove+0xc>
    800261da:	8082                	ret
{
    800261dc:	7139                	addi	sp,sp,-64
    800261de:	fc06                	sd	ra,56(sp)
    800261e0:	f822                	sd	s0,48(sp)
    800261e2:	f426                	sd	s1,40(sp)
    800261e4:	f04a                	sd	s2,32(sp)
    800261e6:	ec4e                	sd	s3,24(sp)
    800261e8:	e852                	sd	s4,16(sp)
    800261ea:	0080                	addi	s0,sp,64
    800261ec:	84aa                	mv	s1,a0
    uint entcnt = 0;
    800261ee:	fc042623          	sw	zero,-52(s0)
    uint32 off = entry->off;
    800261f2:	11c52903          	lw	s2,284(a0)
    uint32 off2 = reloc_clus(entry->parent, off, 0);
    800261f6:	4601                	li	a2,0
    800261f8:	85ca                	mv	a1,s2
    800261fa:	12053503          	ld	a0,288(a0)
    800261fe:	fffff097          	auipc	ra,0xfffff
    80026202:	1e2080e7          	jalr	482(ra) # 800253e0 <reloc_clus>
    80026206:	0005099b          	sext.w	s3,a0
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64) &entcnt, off2, 1);
    8002620a:	1204b503          	ld	a0,288(s1)
    8002620e:	4785                	li	a5,1
    80026210:	874e                	mv	a4,s3
    80026212:	fcc40693          	addi	a3,s0,-52
    80026216:	4601                	li	a2,0
    80026218:	4581                	li	a1,0
    8002621a:	10c52503          	lw	a0,268(a0)
    8002621e:	fffff097          	auipc	ra,0xfffff
    80026222:	2d4080e7          	jalr	724(ra) # 800254f2 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    80026226:	fcc42783          	lw	a5,-52(s0)
    8002622a:	fbf7f793          	andi	a5,a5,-65
    8002622e:	fcf42623          	sw	a5,-52(s0)
    uint8 flag = EMPTY_ENTRY;
    80026232:	5795                	li	a5,-27
    80026234:	fcf405a3          	sb	a5,-53(s0)
    for (int i = 0; i <= entcnt; i++) {
    80026238:	4a01                	li	s4,0
        rw_clus(entry->parent->cur_clus, 1, 0, (uint64) &flag, off2, 1);
    8002623a:	1204b503          	ld	a0,288(s1)
    8002623e:	4785                	li	a5,1
    80026240:	874e                	mv	a4,s3
    80026242:	fcb40693          	addi	a3,s0,-53
    80026246:	4601                	li	a2,0
    80026248:	4585                	li	a1,1
    8002624a:	10c52503          	lw	a0,268(a0)
    8002624e:	fffff097          	auipc	ra,0xfffff
    80026252:	2a4080e7          	jalr	676(ra) # 800254f2 <rw_clus>
        off += 32;
    80026256:	0209091b          	addiw	s2,s2,32
        off2 = reloc_clus(entry->parent, off, 0);
    8002625a:	4601                	li	a2,0
    8002625c:	85ca                	mv	a1,s2
    8002625e:	1204b503          	ld	a0,288(s1)
    80026262:	fffff097          	auipc	ra,0xfffff
    80026266:	17e080e7          	jalr	382(ra) # 800253e0 <reloc_clus>
    8002626a:	0005099b          	sext.w	s3,a0
    for (int i = 0; i <= entcnt; i++) {
    8002626e:	001a079b          	addiw	a5,s4,1
    80026272:	00078a1b          	sext.w	s4,a5
    80026276:	fcc42703          	lw	a4,-52(s0)
    8002627a:	fd4770e3          	bgeu	a4,s4,8002623a <eremove+0x6a>
    entry->valid = -1;
    8002627e:	57fd                	li	a5,-1
    80026280:	10f49b23          	sh	a5,278(s1)
}
    80026284:	70e2                	ld	ra,56(sp)
    80026286:	7442                	ld	s0,48(sp)
    80026288:	74a2                	ld	s1,40(sp)
    8002628a:	7902                	ld	s2,32(sp)
    8002628c:	69e2                	ld	s3,24(sp)
    8002628e:	6a42                	ld	s4,16(sp)
    80026290:	6121                	addi	sp,sp,64
    80026292:	8082                	ret

0000000080026294 <etrunc>:
{
    80026294:	7179                	addi	sp,sp,-48
    80026296:	f406                	sd	ra,40(sp)
    80026298:	f022                	sd	s0,32(sp)
    8002629a:	ec26                	sd	s1,24(sp)
    8002629c:	e84a                	sd	s2,16(sp)
    8002629e:	e44e                	sd	s3,8(sp)
    800262a0:	e052                	sd	s4,0(sp)
    800262a2:	1800                	addi	s0,sp,48
    800262a4:	8a2a                	mv	s4,a0
    for (uint32 clus = entry->first_clus; clus >= 2 && clus < FAT32_EOC; ) {
    800262a6:	10452903          	lw	s2,260(a0)
    800262aa:	ffe9071b          	addiw	a4,s2,-2
    800262ae:	100007b7          	lui	a5,0x10000
    800262b2:	17d5                	addi	a5,a5,-11
    800262b4:	02e7e563          	bltu	a5,a4,800262de <etrunc+0x4a>
    800262b8:	89be                	mv	s3,a5
        uint32 next = read_fat(clus);
    800262ba:	854a                	mv	a0,s2
    800262bc:	fffff097          	auipc	ra,0xfffff
    800262c0:	eec080e7          	jalr	-276(ra) # 800251a8 <read_fat>
    800262c4:	0005049b          	sext.w	s1,a0
    write_fat(cluster, 0);
    800262c8:	4581                	li	a1,0
    800262ca:	854a                	mv	a0,s2
    800262cc:	fffff097          	auipc	ra,0xfffff
    800262d0:	096080e7          	jalr	150(ra) # 80025362 <write_fat>
        clus = next;
    800262d4:	0004891b          	sext.w	s2,s1
    for (uint32 clus = entry->first_clus; clus >= 2 && clus < FAT32_EOC; ) {
    800262d8:	34f9                	addiw	s1,s1,-2
    800262da:	fe99f0e3          	bgeu	s3,s1,800262ba <etrunc+0x26>
    entry->file_size = 0;
    800262de:	100a2423          	sw	zero,264(s4)
    entry->first_clus = 0;
    800262e2:	100a2223          	sw	zero,260(s4)
    entry->dirty = 1;
    800262e6:	4785                	li	a5,1
    800262e8:	10fa0aa3          	sb	a5,277(s4)
}
    800262ec:	70a2                	ld	ra,40(sp)
    800262ee:	7402                	ld	s0,32(sp)
    800262f0:	64e2                	ld	s1,24(sp)
    800262f2:	6942                	ld	s2,16(sp)
    800262f4:	69a2                	ld	s3,8(sp)
    800262f6:	6a02                	ld	s4,0(sp)
    800262f8:	6145                	addi	sp,sp,48
    800262fa:	8082                	ret

00000000800262fc <elock>:
{
    800262fc:	1141                	addi	sp,sp,-16
    800262fe:	e406                	sd	ra,8(sp)
    80026300:	e022                	sd	s0,0(sp)
    80026302:	0800                	addi	s0,sp,16
    if (entry == 0 || entry->ref < 1)
    80026304:	cd19                	beqz	a0,80026322 <elock+0x26>
    80026306:	11852783          	lw	a5,280(a0)
    8002630a:	00f05c63          	blez	a5,80026322 <elock+0x26>
    acquiresleep(&entry->lock);
    8002630e:	13850513          	addi	a0,a0,312
    80026312:	ffffd097          	auipc	ra,0xffffd
    80026316:	40c080e7          	jalr	1036(ra) # 8002371e <acquiresleep>
}
    8002631a:	60a2                	ld	ra,8(sp)
    8002631c:	6402                	ld	s0,0(sp)
    8002631e:	0141                	addi	sp,sp,16
    80026320:	8082                	ret
        panic("elock");
    80026322:	00006517          	auipc	a0,0x6
    80026326:	14e50513          	addi	a0,a0,334 # 8002c470 <syscalls+0xb08>
    8002632a:	ffffa097          	auipc	ra,0xffffa
    8002632e:	e1c080e7          	jalr	-484(ra) # 80020146 <panic>

0000000080026332 <eunlock>:
{
    80026332:	1101                	addi	sp,sp,-32
    80026334:	ec06                	sd	ra,24(sp)
    80026336:	e822                	sd	s0,16(sp)
    80026338:	e426                	sd	s1,8(sp)
    8002633a:	e04a                	sd	s2,0(sp)
    8002633c:	1000                	addi	s0,sp,32
    if (entry == 0 || !holdingsleep(&entry->lock) || entry->ref < 1)
    8002633e:	c90d                	beqz	a0,80026370 <eunlock+0x3e>
    80026340:	84aa                	mv	s1,a0
    80026342:	13850913          	addi	s2,a0,312
    80026346:	854a                	mv	a0,s2
    80026348:	ffffd097          	auipc	ra,0xffffd
    8002634c:	470080e7          	jalr	1136(ra) # 800237b8 <holdingsleep>
    80026350:	c105                	beqz	a0,80026370 <eunlock+0x3e>
    80026352:	1184a783          	lw	a5,280(s1)
    80026356:	00f05d63          	blez	a5,80026370 <eunlock+0x3e>
    releasesleep(&entry->lock);
    8002635a:	854a                	mv	a0,s2
    8002635c:	ffffd097          	auipc	ra,0xffffd
    80026360:	418080e7          	jalr	1048(ra) # 80023774 <releasesleep>
}
    80026364:	60e2                	ld	ra,24(sp)
    80026366:	6442                	ld	s0,16(sp)
    80026368:	64a2                	ld	s1,8(sp)
    8002636a:	6902                	ld	s2,0(sp)
    8002636c:	6105                	addi	sp,sp,32
    8002636e:	8082                	ret
        panic("eunlock");
    80026370:	00006517          	auipc	a0,0x6
    80026374:	10850513          	addi	a0,a0,264 # 8002c478 <syscalls+0xb10>
    80026378:	ffffa097          	auipc	ra,0xffffa
    8002637c:	dce080e7          	jalr	-562(ra) # 80020146 <panic>

0000000080026380 <eput>:
{
    80026380:	1101                	addi	sp,sp,-32
    80026382:	ec06                	sd	ra,24(sp)
    80026384:	e822                	sd	s0,16(sp)
    80026386:	e426                	sd	s1,8(sp)
    80026388:	e04a                	sd	s2,0(sp)
    8002638a:	1000                	addi	s0,sp,32
    8002638c:	84aa                	mv	s1,a0
    acquire(&ecache.lock);
    8002638e:	0001a517          	auipc	a0,0x1a
    80026392:	22a50513          	addi	a0,a0,554 # 800405b8 <ecache>
    80026396:	ffffa097          	auipc	ra,0xffffa
    8002639a:	32a080e7          	jalr	810(ra) # 800206c0 <acquire>
    if (entry != &root && entry->valid != 0 && entry->ref == 1) {
    8002639e:	0001a797          	auipc	a5,0x1a
    800263a2:	0b278793          	addi	a5,a5,178 # 80040450 <root>
    800263a6:	00f48a63          	beq	s1,a5,800263ba <eput+0x3a>
    800263aa:	11649783          	lh	a5,278(s1)
    800263ae:	c791                	beqz	a5,800263ba <eput+0x3a>
    800263b0:	1184a703          	lw	a4,280(s1)
    800263b4:	4785                	li	a5,1
    800263b6:	02f70563          	beq	a4,a5,800263e0 <eput+0x60>
    entry->ref--;
    800263ba:	1184a783          	lw	a5,280(s1)
    800263be:	37fd                	addiw	a5,a5,-1
    800263c0:	10f4ac23          	sw	a5,280(s1)
    release(&ecache.lock);
    800263c4:	0001a517          	auipc	a0,0x1a
    800263c8:	1f450513          	addi	a0,a0,500 # 800405b8 <ecache>
    800263cc:	ffffa097          	auipc	ra,0xffffa
    800263d0:	348080e7          	jalr	840(ra) # 80020714 <release>
}
    800263d4:	60e2                	ld	ra,24(sp)
    800263d6:	6442                	ld	s0,16(sp)
    800263d8:	64a2                	ld	s1,8(sp)
    800263da:	6902                	ld	s2,0(sp)
    800263dc:	6105                	addi	sp,sp,32
    800263de:	8082                	ret
        acquiresleep(&entry->lock);
    800263e0:	13848913          	addi	s2,s1,312
    800263e4:	854a                	mv	a0,s2
    800263e6:	ffffd097          	auipc	ra,0xffffd
    800263ea:	338080e7          	jalr	824(ra) # 8002371e <acquiresleep>
        entry->next->prev = entry->prev;
    800263ee:	1284b703          	ld	a4,296(s1)
    800263f2:	1304b783          	ld	a5,304(s1)
    800263f6:	12f73823          	sd	a5,304(a4)
        entry->prev->next = entry->next;
    800263fa:	1284b703          	ld	a4,296(s1)
    800263fe:	12e7b423          	sd	a4,296(a5)
        entry->next = root.next;
    80026402:	0001a797          	auipc	a5,0x1a
    80026406:	02678793          	addi	a5,a5,38 # 80040428 <fat>
    8002640a:	1507b703          	ld	a4,336(a5)
    8002640e:	12e4b423          	sd	a4,296(s1)
        entry->prev = &root;
    80026412:	0001a697          	auipc	a3,0x1a
    80026416:	03e68693          	addi	a3,a3,62 # 80040450 <root>
    8002641a:	12d4b823          	sd	a3,304(s1)
        root.next->prev = entry;
    8002641e:	12973823          	sd	s1,304(a4)
        root.next = entry;
    80026422:	1497b823          	sd	s1,336(a5)
        release(&ecache.lock);
    80026426:	0001a517          	auipc	a0,0x1a
    8002642a:	19250513          	addi	a0,a0,402 # 800405b8 <ecache>
    8002642e:	ffffa097          	auipc	ra,0xffffa
    80026432:	2e6080e7          	jalr	742(ra) # 80020714 <release>
        if (entry->valid == -1) {       // this means some one has called eremove()
    80026436:	11649703          	lh	a4,278(s1)
    8002643a:	57fd                	li	a5,-1
    8002643c:	06f70863          	beq	a4,a5,800264ac <eput+0x12c>
            elock(entry->parent);
    80026440:	1204b503          	ld	a0,288(s1)
    80026444:	00000097          	auipc	ra,0x0
    80026448:	eb8080e7          	jalr	-328(ra) # 800262fc <elock>
            eupdate(entry);
    8002644c:	8526                	mv	a0,s1
    8002644e:	00000097          	auipc	ra,0x0
    80026452:	ca2080e7          	jalr	-862(ra) # 800260f0 <eupdate>
            eunlock(entry->parent);
    80026456:	1204b503          	ld	a0,288(s1)
    8002645a:	00000097          	auipc	ra,0x0
    8002645e:	ed8080e7          	jalr	-296(ra) # 80026332 <eunlock>
        releasesleep(&entry->lock);
    80026462:	854a                	mv	a0,s2
    80026464:	ffffd097          	auipc	ra,0xffffd
    80026468:	310080e7          	jalr	784(ra) # 80023774 <releasesleep>
        struct dirent *eparent = entry->parent;
    8002646c:	1204b903          	ld	s2,288(s1)
        acquire(&ecache.lock);
    80026470:	0001a517          	auipc	a0,0x1a
    80026474:	14850513          	addi	a0,a0,328 # 800405b8 <ecache>
    80026478:	ffffa097          	auipc	ra,0xffffa
    8002647c:	248080e7          	jalr	584(ra) # 800206c0 <acquire>
        entry->ref--;
    80026480:	1184a783          	lw	a5,280(s1)
    80026484:	37fd                	addiw	a5,a5,-1
    80026486:	10f4ac23          	sw	a5,280(s1)
        release(&ecache.lock);
    8002648a:	0001a517          	auipc	a0,0x1a
    8002648e:	12e50513          	addi	a0,a0,302 # 800405b8 <ecache>
    80026492:	ffffa097          	auipc	ra,0xffffa
    80026496:	282080e7          	jalr	642(ra) # 80020714 <release>
        if (entry->ref == 0) {
    8002649a:	1184a783          	lw	a5,280(s1)
    8002649e:	fb9d                	bnez	a5,800263d4 <eput+0x54>
            eput(eparent);
    800264a0:	854a                	mv	a0,s2
    800264a2:	00000097          	auipc	ra,0x0
    800264a6:	ede080e7          	jalr	-290(ra) # 80026380 <eput>
    800264aa:	b72d                	j	800263d4 <eput+0x54>
            etrunc(entry);
    800264ac:	8526                	mv	a0,s1
    800264ae:	00000097          	auipc	ra,0x0
    800264b2:	de6080e7          	jalr	-538(ra) # 80026294 <etrunc>
    800264b6:	b775                	j	80026462 <eput+0xe2>

00000000800264b8 <estat>:
{
    800264b8:	1101                	addi	sp,sp,-32
    800264ba:	ec06                	sd	ra,24(sp)
    800264bc:	e822                	sd	s0,16(sp)
    800264be:	e426                	sd	s1,8(sp)
    800264c0:	e04a                	sd	s2,0(sp)
    800264c2:	1000                	addi	s0,sp,32
    800264c4:	892a                	mv	s2,a0
    800264c6:	84ae                	mv	s1,a1
    strncpy(st->name, de->filename, STAT_MAX_NAME);
    800264c8:	02000613          	li	a2,32
    800264cc:	85aa                	mv	a1,a0
    800264ce:	8526                	mv	a0,s1
    800264d0:	ffffa097          	auipc	ra,0xffffa
    800264d4:	3c4080e7          	jalr	964(ra) # 80020894 <strncpy>
    st->type = (de->attribute & ATTR_DIRECTORY) ? T_DIR : T_FILE;
    800264d8:	10094783          	lbu	a5,256(s2)
    800264dc:	8bc1                	andi	a5,a5,16
    800264de:	0017b793          	seqz	a5,a5
    800264e2:	0785                	addi	a5,a5,1
    800264e4:	02f49423          	sh	a5,40(s1)
    st->dev = de->dev;
    800264e8:	11494783          	lbu	a5,276(s2)
    800264ec:	d0dc                	sw	a5,36(s1)
    st->size = de->file_size;
    800264ee:	10896783          	lwu	a5,264(s2)
    800264f2:	f89c                	sd	a5,48(s1)
}
    800264f4:	60e2                	ld	ra,24(sp)
    800264f6:	6442                	ld	s0,16(sp)
    800264f8:	64a2                	ld	s1,8(sp)
    800264fa:	6902                	ld	s2,0(sp)
    800264fc:	6105                	addi	sp,sp,32
    800264fe:	8082                	ret

0000000080026500 <enext>:
 * @return  -1      meet the end of dir
 *          0       find empty slots
 *          1       find a file with all its entries
 */
int enext(struct dirent *dp, struct dirent *ep, uint off, int *count)
{
    80026500:	7119                	addi	sp,sp,-128
    80026502:	fc86                	sd	ra,120(sp)
    80026504:	f8a2                	sd	s0,112(sp)
    80026506:	f4a6                	sd	s1,104(sp)
    80026508:	f0ca                	sd	s2,96(sp)
    8002650a:	ecce                	sd	s3,88(sp)
    8002650c:	e8d2                	sd	s4,80(sp)
    8002650e:	e4d6                	sd	s5,72(sp)
    80026510:	e0da                	sd	s6,64(sp)
    80026512:	fc5e                	sd	s7,56(sp)
    80026514:	f862                	sd	s8,48(sp)
    80026516:	f466                	sd	s9,40(sp)
    80026518:	0100                	addi	s0,sp,128
    if (!(dp->attribute & ATTR_DIRECTORY))
    8002651a:	10054783          	lbu	a5,256(a0)
    8002651e:	8bc1                	andi	a5,a5,16
    80026520:	cf95                	beqz	a5,8002655c <enext+0x5c>
    80026522:	892a                	mv	s2,a0
    80026524:	8bae                	mv	s7,a1
    80026526:	84b2                	mv	s1,a2
    80026528:	8ab6                	mv	s5,a3
        panic("enext not dir");
    if (ep->valid)
    8002652a:	11659783          	lh	a5,278(a1)
    8002652e:	ef9d                	bnez	a5,8002656c <enext+0x6c>
        panic("enext ep valid");
    if (off % 32)
    80026530:	01f67793          	andi	a5,a2,31
    80026534:	e7a1                	bnez	a5,8002657c <enext+0x7c>
        panic("enext not align");
    if (dp->valid != 1) { return -1; }
    80026536:	11651703          	lh	a4,278(a0)
    8002653a:	4785                	li	a5,1
    8002653c:	557d                	li	a0,-1
    8002653e:	04f70763          	beq	a4,a5,8002658c <enext+0x8c>
            read_entry_info(ep, &de);
            return 1;
        }
    }
    return -1;
}
    80026542:	70e6                	ld	ra,120(sp)
    80026544:	7446                	ld	s0,112(sp)
    80026546:	74a6                	ld	s1,104(sp)
    80026548:	7906                	ld	s2,96(sp)
    8002654a:	69e6                	ld	s3,88(sp)
    8002654c:	6a46                	ld	s4,80(sp)
    8002654e:	6aa6                	ld	s5,72(sp)
    80026550:	6b06                	ld	s6,64(sp)
    80026552:	7be2                	ld	s7,56(sp)
    80026554:	7c42                	ld	s8,48(sp)
    80026556:	7ca2                	ld	s9,40(sp)
    80026558:	6109                	addi	sp,sp,128
    8002655a:	8082                	ret
        panic("enext not dir");
    8002655c:	00006517          	auipc	a0,0x6
    80026560:	f2450513          	addi	a0,a0,-220 # 8002c480 <syscalls+0xb18>
    80026564:	ffffa097          	auipc	ra,0xffffa
    80026568:	be2080e7          	jalr	-1054(ra) # 80020146 <panic>
        panic("enext ep valid");
    8002656c:	00006517          	auipc	a0,0x6
    80026570:	f2450513          	addi	a0,a0,-220 # 8002c490 <syscalls+0xb28>
    80026574:	ffffa097          	auipc	ra,0xffffa
    80026578:	bd2080e7          	jalr	-1070(ra) # 80020146 <panic>
        panic("enext not align");
    8002657c:	00006517          	auipc	a0,0x6
    80026580:	f2450513          	addi	a0,a0,-220 # 8002c4a0 <syscalls+0xb38>
    80026584:	ffffa097          	auipc	ra,0xffffa
    80026588:	bc2080e7          	jalr	-1086(ra) # 80020146 <panic>
    memset(ep->filename, 0, FAT32_MAX_FILENAME + 1);
    8002658c:	8cae                	mv	s9,a1
    8002658e:	10000613          	li	a2,256
    80026592:	4581                	li	a1,0
    80026594:	855e                	mv	a0,s7
    80026596:	ffffa097          	auipc	ra,0xffffa
    8002659a:	1c6080e7          	jalr	454(ra) # 8002075c <memset>
    int cnt = 0;
    8002659e:	4981                	li	s3,0
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    800265a0:	5a7d                	li	s4,-1
        if (de.lne.order == EMPTY_ENTRY) {
    800265a2:	0e500b13          	li	s6,229
        if (de.lne.attr == ATTR_LONG_NAME) {
    800265a6:	4c3d                	li	s8,15
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    800265a8:	a805                	j	800265d8 <enext+0xd8>
            cnt++;
    800265aa:	2985                	addiw	s3,s3,1
            continue;
    800265ac:	a025                	j	800265d4 <enext+0xd4>
            *count = cnt;
    800265ae:	013aa023          	sw	s3,0(s5)
            return 0;
    800265b2:	4501                	li	a0,0
    800265b4:	b779                	j	80026542 <enext+0x42>
            read_entry_name(ep->filename + (lcnt - 1) * CHAR_LONG_NAME, &de);
    800265b6:	fff5079b          	addiw	a5,a0,-1
    800265ba:	0017951b          	slliw	a0,a5,0x1
    800265be:	9d3d                	addw	a0,a0,a5
    800265c0:	0025151b          	slliw	a0,a0,0x2
    800265c4:	9d3d                	addw	a0,a0,a5
    800265c6:	f8040593          	addi	a1,s0,-128
    800265ca:	9566                	add	a0,a0,s9
    800265cc:	fffff097          	auipc	ra,0xfffff
    800265d0:	196080e7          	jalr	406(ra) # 80025762 <read_entry_name>
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    800265d4:	0204849b          	addiw	s1,s1,32
    800265d8:	4601                	li	a2,0
    800265da:	85a6                	mv	a1,s1
    800265dc:	854a                	mv	a0,s2
    800265de:	fffff097          	auipc	ra,0xfffff
    800265e2:	e02080e7          	jalr	-510(ra) # 800253e0 <reloc_clus>
    800265e6:	f5450ee3          	beq	a0,s4,80026542 <enext+0x42>
        if (rw_clus(dp->cur_clus, 0, 0, (uint64)&de, off2, 32) != 32 || de.lne.order == END_OF_ENTRY) {
    800265ea:	02000793          	li	a5,32
    800265ee:	0005071b          	sext.w	a4,a0
    800265f2:	f8040693          	addi	a3,s0,-128
    800265f6:	4601                	li	a2,0
    800265f8:	4581                	li	a1,0
    800265fa:	10c92503          	lw	a0,268(s2)
    800265fe:	fffff097          	auipc	ra,0xfffff
    80026602:	ef4080e7          	jalr	-268(ra) # 800254f2 <rw_clus>
    80026606:	2501                	sext.w	a0,a0
    80026608:	02000793          	li	a5,32
    8002660c:	06f51c63          	bne	a0,a5,80026684 <enext+0x184>
    80026610:	f8044783          	lbu	a5,-128(s0)
    80026614:	cbb5                	beqz	a5,80026688 <enext+0x188>
        if (de.lne.order == EMPTY_ENTRY) {
    80026616:	f9678ae3          	beq	a5,s6,800265aa <enext+0xaa>
        } else if (cnt) {
    8002661a:	f8099ae3          	bnez	s3,800265ae <enext+0xae>
        if (de.lne.attr == ATTR_LONG_NAME) {
    8002661e:	f8b44703          	lbu	a4,-117(s0)
    80026622:	01871d63          	bne	a4,s8,8002663c <enext+0x13c>
            int lcnt = de.lne.order & ~LAST_LONG_ENTRY;
    80026626:	0bf7f513          	andi	a0,a5,191
            if (de.lne.order & LAST_LONG_ENTRY) {
    8002662a:	0407f793          	andi	a5,a5,64
    8002662e:	d7c1                	beqz	a5,800265b6 <enext+0xb6>
                *count = lcnt + 1;                              // plus the s-n-e;
    80026630:	0015079b          	addiw	a5,a0,1
    80026634:	00faa023          	sw	a5,0(s5)
                count = 0;
    80026638:	4a81                	li	s5,0
    8002663a:	bfb5                	j	800265b6 <enext+0xb6>
            if (count) {
    8002663c:	000a8c63          	beqz	s5,80026654 <enext+0x154>
                *count = 1;
    80026640:	4785                	li	a5,1
    80026642:	00faa023          	sw	a5,0(s5)
                read_entry_name(ep->filename, &de);
    80026646:	f8040593          	addi	a1,s0,-128
    8002664a:	855e                	mv	a0,s7
    8002664c:	fffff097          	auipc	ra,0xfffff
    80026650:	116080e7          	jalr	278(ra) # 80025762 <read_entry_name>
    entry->attribute = d->sne.attr;
    80026654:	f8b44783          	lbu	a5,-117(s0)
    80026658:	10fb8023          	sb	a5,256(s7) # fffffffffffff100 <kernel_end+0xffffffff7ffba100>
    entry->first_clus = ((uint32)d->sne.fst_clus_hi << 16) | d->sne.fst_clus_lo;
    8002665c:	f9445783          	lhu	a5,-108(s0)
    80026660:	0107979b          	slliw	a5,a5,0x10
    80026664:	f9a45703          	lhu	a4,-102(s0)
    80026668:	8fd9                	or	a5,a5,a4
    8002666a:	2781                	sext.w	a5,a5
    8002666c:	10fba223          	sw	a5,260(s7)
    entry->file_size = d->sne.file_size;
    80026670:	f9c42703          	lw	a4,-100(s0)
    80026674:	10eba423          	sw	a4,264(s7)
    entry->cur_clus = entry->first_clus;
    80026678:	10fba623          	sw	a5,268(s7)
    entry->clus_cnt = 0;
    8002667c:	100ba823          	sw	zero,272(s7)
            return 1;
    80026680:	4505                	li	a0,1
    80026682:	b5c1                	j	80026542 <enext+0x42>
            return -1;
    80026684:	557d                	li	a0,-1
    80026686:	bd75                	j	80026542 <enext+0x42>
    80026688:	557d                	li	a0,-1
    8002668a:	bd65                	j	80026542 <enext+0x42>

000000008002668c <dirlookup>:
 * @param   dp          entry of a directory file
 * @param   filename    target filename
 * @param   poff        offset of proper empty entry slots from the beginning of the dir
 */
struct dirent *dirlookup(struct dirent *dp, char *filename, uint *poff)
{
    8002668c:	715d                	addi	sp,sp,-80
    8002668e:	e486                	sd	ra,72(sp)
    80026690:	e0a2                	sd	s0,64(sp)
    80026692:	fc26                	sd	s1,56(sp)
    80026694:	f84a                	sd	s2,48(sp)
    80026696:	f44e                	sd	s3,40(sp)
    80026698:	f052                	sd	s4,32(sp)
    8002669a:	ec56                	sd	s5,24(sp)
    8002669c:	e85a                	sd	s6,16(sp)
    8002669e:	0880                	addi	s0,sp,80
    if (!(dp->attribute & ATTR_DIRECTORY))
    800266a0:	10054783          	lbu	a5,256(a0)
    800266a4:	8bc1                	andi	a5,a5,16
    800266a6:	cbb1                	beqz	a5,800266fa <dirlookup+0x6e>
    800266a8:	892a                	mv	s2,a0
    800266aa:	89ae                	mv	s3,a1
    800266ac:	8b32                	mv	s6,a2
        panic("dirlookup not DIR");
    if (strncmp(filename, ".", FAT32_MAX_FILENAME) == 0) {
    800266ae:	0ff00613          	li	a2,255
    800266b2:	00006597          	auipc	a1,0x6
    800266b6:	e1658593          	addi	a1,a1,-490 # 8002c4c8 <syscalls+0xb60>
    800266ba:	854e                	mv	a0,s3
    800266bc:	ffffa097          	auipc	ra,0xffffa
    800266c0:	188080e7          	jalr	392(ra) # 80020844 <strncmp>
    800266c4:	c139                	beqz	a0,8002670a <dirlookup+0x7e>
        return edup(dp);
    } else if (strncmp(filename, "..", FAT32_MAX_FILENAME) == 0) {
    800266c6:	0ff00613          	li	a2,255
    800266ca:	00006597          	auipc	a1,0x6
    800266ce:	e0658593          	addi	a1,a1,-506 # 8002c4d0 <syscalls+0xb68>
    800266d2:	854e                	mv	a0,s3
    800266d4:	ffffa097          	auipc	ra,0xffffa
    800266d8:	170080e7          	jalr	368(ra) # 80020844 <strncmp>
    800266dc:	ed39                	bnez	a0,8002673a <dirlookup+0xae>
        if (dp == &root) {
    800266de:	0001a797          	auipc	a5,0x1a
    800266e2:	d7278793          	addi	a5,a5,-654 # 80040450 <root>
    800266e6:	04f90363          	beq	s2,a5,8002672c <dirlookup+0xa0>
            return edup(&root);
        }
        return edup(dp->parent);
    800266ea:	12093503          	ld	a0,288(s2)
    800266ee:	00000097          	auipc	ra,0x0
    800266f2:	9be080e7          	jalr	-1602(ra) # 800260ac <edup>
    800266f6:	84aa                	mv	s1,a0
    800266f8:	a839                	j	80026716 <dirlookup+0x8a>
        panic("dirlookup not DIR");
    800266fa:	00006517          	auipc	a0,0x6
    800266fe:	db650513          	addi	a0,a0,-586 # 8002c4b0 <syscalls+0xb48>
    80026702:	ffffa097          	auipc	ra,0xffffa
    80026706:	a44080e7          	jalr	-1468(ra) # 80020146 <panic>
        return edup(dp);
    8002670a:	854a                	mv	a0,s2
    8002670c:	00000097          	auipc	ra,0x0
    80026710:	9a0080e7          	jalr	-1632(ra) # 800260ac <edup>
    80026714:	84aa                	mv	s1,a0
    if (poff) {
        *poff = off;
    }
    eput(ep);
    return NULL;
}
    80026716:	8526                	mv	a0,s1
    80026718:	60a6                	ld	ra,72(sp)
    8002671a:	6406                	ld	s0,64(sp)
    8002671c:	74e2                	ld	s1,56(sp)
    8002671e:	7942                	ld	s2,48(sp)
    80026720:	79a2                	ld	s3,40(sp)
    80026722:	7a02                	ld	s4,32(sp)
    80026724:	6ae2                	ld	s5,24(sp)
    80026726:	6b42                	ld	s6,16(sp)
    80026728:	6161                	addi	sp,sp,80
    8002672a:	8082                	ret
            return edup(&root);
    8002672c:	853e                	mv	a0,a5
    8002672e:	00000097          	auipc	ra,0x0
    80026732:	97e080e7          	jalr	-1666(ra) # 800260ac <edup>
    80026736:	84aa                	mv	s1,a0
    80026738:	bff9                	j	80026716 <dirlookup+0x8a>
    if (dp->valid != 1) {
    8002673a:	11691703          	lh	a4,278(s2)
    8002673e:	4785                	li	a5,1
        return NULL;
    80026740:	4481                	li	s1,0
    if (dp->valid != 1) {
    80026742:	fcf71ae3          	bne	a4,a5,80026716 <dirlookup+0x8a>
    struct dirent *ep = eget(dp, filename);
    80026746:	85ce                	mv	a1,s3
    80026748:	854a                	mv	a0,s2
    8002674a:	fffff097          	auipc	ra,0xfffff
    8002674e:	ef6080e7          	jalr	-266(ra) # 80025640 <eget>
    80026752:	84aa                	mv	s1,a0
    if (ep->valid == 1) { return ep; }                               // ecache hits
    80026754:	11651703          	lh	a4,278(a0)
    80026758:	4785                	li	a5,1
    8002675a:	faf70ee3          	beq	a4,a5,80026716 <dirlookup+0x8a>
    int len = strlen(filename);
    8002675e:	854e                	mv	a0,s3
    80026760:	ffffa097          	auipc	ra,0xffffa
    80026764:	1a6080e7          	jalr	422(ra) # 80020906 <strlen>
    int count = 0;
    80026768:	fa042e23          	sw	zero,-68(s0)
    reloc_clus(dp, 0, 0);
    8002676c:	4601                	li	a2,0
    8002676e:	4581                	li	a1,0
    80026770:	854a                	mv	a0,s2
    80026772:	fffff097          	auipc	ra,0xfffff
    80026776:	c6e080e7          	jalr	-914(ra) # 800253e0 <reloc_clus>
    uint off = 0;
    8002677a:	4a01                	li	s4,0
    while ((type = enext(dp, ep, off, &count) != -1)) {
    8002677c:	5afd                	li	s5,-1
    8002677e:	fbc40693          	addi	a3,s0,-68
    80026782:	8652                	mv	a2,s4
    80026784:	85a6                	mv	a1,s1
    80026786:	854a                	mv	a0,s2
    80026788:	00000097          	auipc	ra,0x0
    8002678c:	d78080e7          	jalr	-648(ra) # 80026500 <enext>
    80026790:	03550f63          	beq	a0,s5,800267ce <dirlookup+0x142>
        } else if (strncmp(filename, ep->filename, FAT32_MAX_FILENAME) == 0) {
    80026794:	0ff00613          	li	a2,255
    80026798:	85a6                	mv	a1,s1
    8002679a:	854e                	mv	a0,s3
    8002679c:	ffffa097          	auipc	ra,0xffffa
    800267a0:	0a8080e7          	jalr	168(ra) # 80020844 <strncmp>
    800267a4:	c901                	beqz	a0,800267b4 <dirlookup+0x128>
        off += count << 5;
    800267a6:	fbc42783          	lw	a5,-68(s0)
    800267aa:	0057979b          	slliw	a5,a5,0x5
    800267ae:	01478a3b          	addw	s4,a5,s4
    800267b2:	b7f1                	j	8002677e <dirlookup+0xf2>
            ep->parent = edup(dp);
    800267b4:	854a                	mv	a0,s2
    800267b6:	00000097          	auipc	ra,0x0
    800267ba:	8f6080e7          	jalr	-1802(ra) # 800260ac <edup>
    800267be:	12a4b023          	sd	a0,288(s1)
            ep->off = off;
    800267c2:	1144ae23          	sw	s4,284(s1)
            ep->valid = 1;
    800267c6:	4785                	li	a5,1
    800267c8:	10f49b23          	sh	a5,278(s1)
            return ep;
    800267cc:	b7a9                	j	80026716 <dirlookup+0x8a>
    if (poff) {
    800267ce:	000b0463          	beqz	s6,800267d6 <dirlookup+0x14a>
        *poff = off;
    800267d2:	014b2023          	sw	s4,0(s6)
    eput(ep);
    800267d6:	8526                	mv	a0,s1
    800267d8:	00000097          	auipc	ra,0x0
    800267dc:	ba8080e7          	jalr	-1112(ra) # 80026380 <eput>
    return NULL;
    800267e0:	4481                	li	s1,0
    800267e2:	bf15                	j	80026716 <dirlookup+0x8a>

00000000800267e4 <ealloc>:
{
    800267e4:	7139                	addi	sp,sp,-64
    800267e6:	fc06                	sd	ra,56(sp)
    800267e8:	f822                	sd	s0,48(sp)
    800267ea:	f426                	sd	s1,40(sp)
    800267ec:	f04a                	sd	s2,32(sp)
    800267ee:	ec4e                	sd	s3,24(sp)
    800267f0:	e852                	sd	s4,16(sp)
    800267f2:	0080                	addi	s0,sp,64
    if (!(dp->attribute & ATTR_DIRECTORY)) {
    800267f4:	10054783          	lbu	a5,256(a0)
    800267f8:	8bc1                	andi	a5,a5,16
    800267fa:	c7b1                	beqz	a5,80026846 <ealloc+0x62>
    800267fc:	892a                	mv	s2,a0
    800267fe:	8a32                	mv	s4,a2
    if (dp->valid != 1 || !(name = formatname(name))) {        // detect illegal character
    80026800:	11651703          	lh	a4,278(a0)
    80026804:	4785                	li	a5,1
        return NULL;
    80026806:	4481                	li	s1,0
    if (dp->valid != 1 || !(name = formatname(name))) {        // detect illegal character
    80026808:	02f71663          	bne	a4,a5,80026834 <ealloc+0x50>
    8002680c:	852e                	mv	a0,a1
    8002680e:	fffff097          	auipc	ra,0xfffff
    80026812:	442080e7          	jalr	1090(ra) # 80025c50 <formatname>
    80026816:	89aa                	mv	s3,a0
    80026818:	10050663          	beqz	a0,80026924 <ealloc+0x140>
    uint off = 0;
    8002681c:	fc042623          	sw	zero,-52(s0)
    if ((ep = dirlookup(dp, name, &off)) != 0) {      // entry exists
    80026820:	fcc40613          	addi	a2,s0,-52
    80026824:	85aa                	mv	a1,a0
    80026826:	854a                	mv	a0,s2
    80026828:	00000097          	auipc	ra,0x0
    8002682c:	e64080e7          	jalr	-412(ra) # 8002668c <dirlookup>
    80026830:	84aa                	mv	s1,a0
    80026832:	c115                	beqz	a0,80026856 <ealloc+0x72>
}
    80026834:	8526                	mv	a0,s1
    80026836:	70e2                	ld	ra,56(sp)
    80026838:	7442                	ld	s0,48(sp)
    8002683a:	74a2                	ld	s1,40(sp)
    8002683c:	7902                	ld	s2,32(sp)
    8002683e:	69e2                	ld	s3,24(sp)
    80026840:	6a42                	ld	s4,16(sp)
    80026842:	6121                	addi	sp,sp,64
    80026844:	8082                	ret
        panic("ealloc not dir");
    80026846:	00006517          	auipc	a0,0x6
    8002684a:	c9250513          	addi	a0,a0,-878 # 8002c4d8 <syscalls+0xb70>
    8002684e:	ffffa097          	auipc	ra,0xffffa
    80026852:	8f8080e7          	jalr	-1800(ra) # 80020146 <panic>
    ep = eget(dp, name);
    80026856:	85ce                	mv	a1,s3
    80026858:	854a                	mv	a0,s2
    8002685a:	fffff097          	auipc	ra,0xfffff
    8002685e:	de6080e7          	jalr	-538(ra) # 80025640 <eget>
    80026862:	84aa                	mv	s1,a0
    elock(ep);
    80026864:	00000097          	auipc	ra,0x0
    80026868:	a98080e7          	jalr	-1384(ra) # 800262fc <elock>
    ep->attribute = attr;
    8002686c:	11448023          	sb	s4,256(s1)
    ep->file_size = 0;
    80026870:	1004a423          	sw	zero,264(s1)
    ep->first_clus = 0;
    80026874:	1004a223          	sw	zero,260(s1)
    ep->parent = edup(dp);
    80026878:	854a                	mv	a0,s2
    8002687a:	00000097          	auipc	ra,0x0
    8002687e:	832080e7          	jalr	-1998(ra) # 800260ac <edup>
    80026882:	12a4b023          	sd	a0,288(s1)
    ep->off = off;
    80026886:	fcc42783          	lw	a5,-52(s0)
    8002688a:	10f4ae23          	sw	a5,284(s1)
    ep->clus_cnt = 0;
    8002688e:	1004a823          	sw	zero,272(s1)
    ep->cur_clus = 0;
    80026892:	1004a623          	sw	zero,268(s1)
    ep->dirty = 0;
    80026896:	10048aa3          	sb	zero,277(s1)
    strncpy(ep->filename, name, FAT32_MAX_FILENAME);
    8002689a:	0ff00613          	li	a2,255
    8002689e:	85ce                	mv	a1,s3
    800268a0:	8526                	mv	a0,s1
    800268a2:	ffffa097          	auipc	ra,0xffffa
    800268a6:	ff2080e7          	jalr	-14(ra) # 80020894 <strncpy>
    ep->filename[FAT32_MAX_FILENAME] = '\0';
    800268aa:	0e048fa3          	sb	zero,255(s1)
    if (attr == ATTR_DIRECTORY) {    // generate "." and ".." for ep
    800268ae:	47c1                	li	a5,16
    800268b0:	02fa0963          	beq	s4,a5,800268e2 <ealloc+0xfe>
        ep->attribute |= ATTR_ARCHIVE;
    800268b4:	1004c783          	lbu	a5,256(s1)
    800268b8:	0207e793          	ori	a5,a5,32
    800268bc:	10f48023          	sb	a5,256(s1)
    emake(dp, ep, off);
    800268c0:	fcc42603          	lw	a2,-52(s0)
    800268c4:	85a6                	mv	a1,s1
    800268c6:	854a                	mv	a0,s2
    800268c8:	fffff097          	auipc	ra,0xfffff
    800268cc:	448080e7          	jalr	1096(ra) # 80025d10 <emake>
    ep->valid = 1;
    800268d0:	4785                	li	a5,1
    800268d2:	10f49b23          	sh	a5,278(s1)
    eunlock(ep);
    800268d6:	8526                	mv	a0,s1
    800268d8:	00000097          	auipc	ra,0x0
    800268dc:	a5a080e7          	jalr	-1446(ra) # 80026332 <eunlock>
    return ep;
    800268e0:	bf91                	j	80026834 <ealloc+0x50>
        ep->attribute |= ATTR_DIRECTORY;
    800268e2:	1004c783          	lbu	a5,256(s1)
    800268e6:	0107e793          	ori	a5,a5,16
    800268ea:	10f48023          	sb	a5,256(s1)
        ep->cur_clus = ep->first_clus = alloc_clus(dp->dev);
    800268ee:	11494503          	lbu	a0,276(s2)
    800268f2:	fffff097          	auipc	ra,0xfffff
    800268f6:	928080e7          	jalr	-1752(ra) # 8002521a <alloc_clus>
    800268fa:	2501                	sext.w	a0,a0
    800268fc:	10a4a223          	sw	a0,260(s1)
    80026900:	10a4a623          	sw	a0,268(s1)
        emake(ep, ep, 0);
    80026904:	4601                	li	a2,0
    80026906:	85a6                	mv	a1,s1
    80026908:	8526                	mv	a0,s1
    8002690a:	fffff097          	auipc	ra,0xfffff
    8002690e:	406080e7          	jalr	1030(ra) # 80025d10 <emake>
        emake(ep, dp, 32);
    80026912:	02000613          	li	a2,32
    80026916:	85ca                	mv	a1,s2
    80026918:	8526                	mv	a0,s1
    8002691a:	fffff097          	auipc	ra,0xfffff
    8002691e:	3f6080e7          	jalr	1014(ra) # 80025d10 <emake>
    80026922:	bf79                	j	800268c0 <ealloc+0xdc>
        return NULL;
    80026924:	84aa                	mv	s1,a0
    80026926:	b739                	j	80026834 <ealloc+0x50>

0000000080026928 <lookup_path>:
    return path;
}

// FAT32 version of namex in xv6's original file system.
static struct dirent *lookup_path(char *path, int parent, char *name)
{
    80026928:	715d                	addi	sp,sp,-80
    8002692a:	e486                	sd	ra,72(sp)
    8002692c:	e0a2                	sd	s0,64(sp)
    8002692e:	fc26                	sd	s1,56(sp)
    80026930:	f84a                	sd	s2,48(sp)
    80026932:	f44e                	sd	s3,40(sp)
    80026934:	f052                	sd	s4,32(sp)
    80026936:	ec56                	sd	s5,24(sp)
    80026938:	e85a                	sd	s6,16(sp)
    8002693a:	e45e                	sd	s7,8(sp)
    8002693c:	e062                	sd	s8,0(sp)
    8002693e:	0880                	addi	s0,sp,80
    80026940:	84aa                	mv	s1,a0
    80026942:	8aae                	mv	s5,a1
    80026944:	8a32                	mv	s4,a2
    struct dirent *entry, *next;
    if (*path == '/') {
    80026946:	00054783          	lbu	a5,0(a0)
    8002694a:	02f00713          	li	a4,47
    8002694e:	02e78663          	beq	a5,a4,8002697a <lookup_path+0x52>
        entry = edup(&root);
    } else if (*path != '\0') {
        entry = edup(myproc()->cwd);
    } else {
        return NULL;
    80026952:	4901                	li	s2,0
    } else if (*path != '\0') {
    80026954:	cba1                	beqz	a5,800269a4 <lookup_path+0x7c>
        entry = edup(myproc()->cwd);
    80026956:	ffffb097          	auipc	ra,0xffffb
    8002695a:	1fc080e7          	jalr	508(ra) # 80021b52 <myproc>
    8002695e:	15853503          	ld	a0,344(a0)
    80026962:	fffff097          	auipc	ra,0xfffff
    80026966:	74a080e7          	jalr	1866(ra) # 800260ac <edup>
    8002696a:	892a                	mv	s2,a0
    while (*path == '/') {
    8002696c:	02f00993          	li	s3,47
    80026970:	0ff00b13          	li	s6,255
    80026974:	0ff00b93          	li	s7,255
    80026978:	a0d5                	j	80026a5c <lookup_path+0x134>
        entry = edup(&root);
    8002697a:	0001a517          	auipc	a0,0x1a
    8002697e:	ad650513          	addi	a0,a0,-1322 # 80040450 <root>
    80026982:	fffff097          	auipc	ra,0xfffff
    80026986:	72a080e7          	jalr	1834(ra) # 800260ac <edup>
    8002698a:	892a                	mv	s2,a0
    8002698c:	b7c5                	j	8002696c <lookup_path+0x44>
    }
    while ((path = skipelem(path, name)) != 0) {
        elock(entry);
        if (!(entry->attribute & ATTR_DIRECTORY)) {
            eunlock(entry);
    8002698e:	854a                	mv	a0,s2
    80026990:	00000097          	auipc	ra,0x0
    80026994:	9a2080e7          	jalr	-1630(ra) # 80026332 <eunlock>
            eput(entry);
    80026998:	854a                	mv	a0,s2
    8002699a:	00000097          	auipc	ra,0x0
    8002699e:	9e6080e7          	jalr	-1562(ra) # 80026380 <eput>
            return NULL;
    800269a2:	4901                	li	s2,0
    if (parent) {
        eput(entry);
        return NULL;
    }
    return entry;
}
    800269a4:	854a                	mv	a0,s2
    800269a6:	60a6                	ld	ra,72(sp)
    800269a8:	6406                	ld	s0,64(sp)
    800269aa:	74e2                	ld	s1,56(sp)
    800269ac:	7942                	ld	s2,48(sp)
    800269ae:	79a2                	ld	s3,40(sp)
    800269b0:	7a02                	ld	s4,32(sp)
    800269b2:	6ae2                	ld	s5,24(sp)
    800269b4:	6b42                	ld	s6,16(sp)
    800269b6:	6ba2                	ld	s7,8(sp)
    800269b8:	6c02                	ld	s8,0(sp)
    800269ba:	6161                	addi	sp,sp,80
    800269bc:	8082                	ret
            eunlock(entry);
    800269be:	854a                	mv	a0,s2
    800269c0:	00000097          	auipc	ra,0x0
    800269c4:	972080e7          	jalr	-1678(ra) # 80026332 <eunlock>
            return entry;
    800269c8:	bff1                	j	800269a4 <lookup_path+0x7c>
            eunlock(entry);
    800269ca:	854a                	mv	a0,s2
    800269cc:	00000097          	auipc	ra,0x0
    800269d0:	966080e7          	jalr	-1690(ra) # 80026332 <eunlock>
            eput(entry);
    800269d4:	854a                	mv	a0,s2
    800269d6:	00000097          	auipc	ra,0x0
    800269da:	9aa080e7          	jalr	-1622(ra) # 80026380 <eput>
            return NULL;
    800269de:	8962                	mv	s2,s8
    800269e0:	b7d1                	j	800269a4 <lookup_path+0x7c>
        path++;
    800269e2:	85a6                	mv	a1,s1
    int len = path - s;
    800269e4:	40b487bb          	subw	a5,s1,a1
    if (len > FAT32_MAX_FILENAME) {
    800269e8:	863e                	mv	a2,a5
    800269ea:	00fb5363          	bge	s6,a5,800269f0 <lookup_path+0xc8>
    800269ee:	865e                	mv	a2,s7
    800269f0:	0006079b          	sext.w	a5,a2
    name[len] = 0;
    800269f4:	97d2                	add	a5,a5,s4
    800269f6:	00078023          	sb	zero,0(a5)
    memmove(name, s, len);
    800269fa:	2601                	sext.w	a2,a2
    800269fc:	8552                	mv	a0,s4
    800269fe:	ffffa097          	auipc	ra,0xffffa
    80026a02:	dca080e7          	jalr	-566(ra) # 800207c8 <memmove>
    while (*path == '/') {
    80026a06:	0004c783          	lbu	a5,0(s1)
    80026a0a:	01379763          	bne	a5,s3,80026a18 <lookup_path+0xf0>
        path++;
    80026a0e:	0485                	addi	s1,s1,1
    while (*path == '/') {
    80026a10:	0004c783          	lbu	a5,0(s1)
    80026a14:	ff378de3          	beq	a5,s3,80026a0e <lookup_path+0xe6>
        elock(entry);
    80026a18:	854a                	mv	a0,s2
    80026a1a:	00000097          	auipc	ra,0x0
    80026a1e:	8e2080e7          	jalr	-1822(ra) # 800262fc <elock>
        if (!(entry->attribute & ATTR_DIRECTORY)) {
    80026a22:	10094783          	lbu	a5,256(s2)
    80026a26:	8bc1                	andi	a5,a5,16
    80026a28:	d3bd                	beqz	a5,8002698e <lookup_path+0x66>
        if (parent && *path == '\0') {
    80026a2a:	000a8563          	beqz	s5,80026a34 <lookup_path+0x10c>
    80026a2e:	0004c783          	lbu	a5,0(s1)
    80026a32:	d7d1                	beqz	a5,800269be <lookup_path+0x96>
        if ((next = dirlookup(entry, name, 0)) == 0) {
    80026a34:	4601                	li	a2,0
    80026a36:	85d2                	mv	a1,s4
    80026a38:	854a                	mv	a0,s2
    80026a3a:	00000097          	auipc	ra,0x0
    80026a3e:	c52080e7          	jalr	-942(ra) # 8002668c <dirlookup>
    80026a42:	8c2a                	mv	s8,a0
    80026a44:	d159                	beqz	a0,800269ca <lookup_path+0xa2>
        eunlock(entry);
    80026a46:	854a                	mv	a0,s2
    80026a48:	00000097          	auipc	ra,0x0
    80026a4c:	8ea080e7          	jalr	-1814(ra) # 80026332 <eunlock>
        eput(entry);
    80026a50:	854a                	mv	a0,s2
    80026a52:	00000097          	auipc	ra,0x0
    80026a56:	92e080e7          	jalr	-1746(ra) # 80026380 <eput>
        entry = next;
    80026a5a:	8962                	mv	s2,s8
    while (*path == '/') {
    80026a5c:	0004c783          	lbu	a5,0(s1)
    80026a60:	03379e63          	bne	a5,s3,80026a9c <lookup_path+0x174>
        path++;
    80026a64:	0485                	addi	s1,s1,1
    while (*path == '/') {
    80026a66:	0004c783          	lbu	a5,0(s1)
    80026a6a:	ff378de3          	beq	a5,s3,80026a64 <lookup_path+0x13c>
    if (*path == 0) { return NULL; }
    80026a6e:	cf91                	beqz	a5,80026a8a <lookup_path+0x162>
    while (*path != '/' && *path != 0) {
    80026a70:	f73789e3          	beq	a5,s3,800269e2 <lookup_path+0xba>
    80026a74:	cb89                	beqz	a5,80026a86 <lookup_path+0x15e>
        path++;
    80026a76:	85a6                	mv	a1,s1
        path++;
    80026a78:	0485                	addi	s1,s1,1
    while (*path != '/' && *path != 0) {
    80026a7a:	0004c783          	lbu	a5,0(s1)
    80026a7e:	f73783e3          	beq	a5,s3,800269e4 <lookup_path+0xbc>
    80026a82:	fbfd                	bnez	a5,80026a78 <lookup_path+0x150>
    80026a84:	b785                	j	800269e4 <lookup_path+0xbc>
        path++;
    80026a86:	85a6                	mv	a1,s1
    80026a88:	bfb1                	j	800269e4 <lookup_path+0xbc>
    if (parent) {
    80026a8a:	f00a8de3          	beqz	s5,800269a4 <lookup_path+0x7c>
        eput(entry);
    80026a8e:	854a                	mv	a0,s2
    80026a90:	00000097          	auipc	ra,0x0
    80026a94:	8f0080e7          	jalr	-1808(ra) # 80026380 <eput>
        return NULL;
    80026a98:	4901                	li	s2,0
    80026a9a:	b729                	j	800269a4 <lookup_path+0x7c>
    if (*path == 0) { return NULL; }
    80026a9c:	d7fd                	beqz	a5,80026a8a <lookup_path+0x162>
    80026a9e:	85a6                	mv	a1,s1
    80026aa0:	bfe1                	j	80026a78 <lookup_path+0x150>

0000000080026aa2 <ename>:

struct dirent *ename(char *path)
{
    80026aa2:	716d                	addi	sp,sp,-272
    80026aa4:	e606                	sd	ra,264(sp)
    80026aa6:	e222                	sd	s0,256(sp)
    80026aa8:	0a00                	addi	s0,sp,272
    char name[FAT32_MAX_FILENAME + 1];
    return lookup_path(path, 0, name);
    80026aaa:	ef040613          	addi	a2,s0,-272
    80026aae:	4581                	li	a1,0
    80026ab0:	00000097          	auipc	ra,0x0
    80026ab4:	e78080e7          	jalr	-392(ra) # 80026928 <lookup_path>
}
    80026ab8:	60b2                	ld	ra,264(sp)
    80026aba:	6412                	ld	s0,256(sp)
    80026abc:	6151                	addi	sp,sp,272
    80026abe:	8082                	ret

0000000080026ac0 <enameparent>:

struct dirent *enameparent(char *path, char *name)
{
    80026ac0:	1141                	addi	sp,sp,-16
    80026ac2:	e406                	sd	ra,8(sp)
    80026ac4:	e022                	sd	s0,0(sp)
    80026ac6:	0800                	addi	s0,sp,16
    return lookup_path(path, 1, name);
    80026ac8:	862e                	mv	a2,a1
    80026aca:	4585                	li	a1,1
    80026acc:	00000097          	auipc	ra,0x0
    80026ad0:	e5c080e7          	jalr	-420(ra) # 80026928 <lookup_path>
}
    80026ad4:	60a2                	ld	ra,8(sp)
    80026ad6:	6402                	ld	s0,0(sp)
    80026ad8:	0141                	addi	sp,sp,16
    80026ada:	8082                	ret

0000000080026adc <plicinit>:

//
// the riscv Platform Level Interrupt Controller (PLIC).
//

void plicinit(void) {
    80026adc:	1141                	addi	sp,sp,-16
    80026ade:	e422                	sd	s0,8(sp)
    80026ae0:	0800                	addi	s0,sp,16
	writed(1, PLIC_V + DISK_IRQ * sizeof(uint32));
    80026ae2:	00fc37b7          	lui	a5,0xfc3
    80026ae6:	07ba                	slli	a5,a5,0xe
    80026ae8:	4705                	li	a4,1
    80026aea:	d7f8                	sw	a4,108(a5)
	writed(1, PLIC_V + UART_IRQ * sizeof(uint32));
    80026aec:	08e7a223          	sw	a4,132(a5) # fc3084 <BASE_ADDRESS-0x7f05cf7c>

	#ifdef DEBUG 
	printf("plicinit\n");
	#endif 
}
    80026af0:	6422                	ld	s0,8(sp)
    80026af2:	0141                	addi	sp,sp,16
    80026af4:	8082                	ret

0000000080026af6 <plicinithart>:

void
plicinithart(void)
{
    80026af6:	1141                	addi	sp,sp,-16
    80026af8:	e406                	sd	ra,8(sp)
    80026afa:	e022                	sd	s0,0(sp)
    80026afc:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80026afe:	ffffb097          	auipc	ra,0xffffb
    80026b02:	028080e7          	jalr	40(ra) # 80021b26 <cpuid>
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART_IRQ) | (1 << DISK_IRQ);
  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
  #else
  uint32 *hart_m_enable = (uint32*)PLIC_MENABLE(hart);
    80026b06:	0085151b          	slliw	a0,a0,0x8
    80026b0a:	01f867b7          	lui	a5,0x1f86
    80026b0e:	0785                	addi	a5,a5,1
    80026b10:	07b6                	slli	a5,a5,0xd
    80026b12:	953e                	add	a0,a0,a5
  *(hart_m_enable) = readd(hart_m_enable) | (1 << DISK_IRQ);
    80026b14:	411c                	lw	a5,0(a0)
    80026b16:	08000737          	lui	a4,0x8000
    80026b1a:	8fd9                	or	a5,a5,a4
    80026b1c:	c11c                	sw	a5,0(a0)
  uint32 *hart0_m_int_enable_hi = hart_m_enable + 1;
  *(hart0_m_int_enable_hi) = readd(hart0_m_int_enable_hi) | (1 << (UART_IRQ % 32));
    80026b1e:	415c                	lw	a5,4(a0)
    80026b20:	0027e793          	ori	a5,a5,2
    80026b24:	c15c                	sw	a5,4(a0)
  #endif
  #ifdef DEBUG
  printf("plicinithart\n");
  #endif
}
    80026b26:	60a2                	ld	ra,8(sp)
    80026b28:	6402                	ld	s0,0(sp)
    80026b2a:	0141                	addi	sp,sp,16
    80026b2c:	8082                	ret

0000000080026b2e <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80026b2e:	1141                	addi	sp,sp,-16
    80026b30:	e406                	sd	ra,8(sp)
    80026b32:	e022                	sd	s0,0(sp)
    80026b34:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80026b36:	ffffb097          	auipc	ra,0xffffb
    80026b3a:	ff0080e7          	jalr	-16(ra) # 80021b26 <cpuid>
  int irq;
  #ifndef QEMU
  irq = *(uint32*)PLIC_MCLAIM(hart);
    80026b3e:	00d5151b          	slliw	a0,a0,0xd
    80026b42:	1f8617b7          	lui	a5,0x1f861
    80026b46:	07a6                	slli	a5,a5,0x9
    80026b48:	97aa                	add	a5,a5,a0
  #else
  irq = *(uint32*)PLIC_SCLAIM(hart);
  #endif
  return irq;
}
    80026b4a:	43c8                	lw	a0,4(a5)
    80026b4c:	60a2                	ld	ra,8(sp)
    80026b4e:	6402                	ld	s0,0(sp)
    80026b50:	0141                	addi	sp,sp,16
    80026b52:	8082                	ret

0000000080026b54 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80026b54:	1101                	addi	sp,sp,-32
    80026b56:	ec06                	sd	ra,24(sp)
    80026b58:	e822                	sd	s0,16(sp)
    80026b5a:	e426                	sd	s1,8(sp)
    80026b5c:	1000                	addi	s0,sp,32
    80026b5e:	84aa                	mv	s1,a0
  int hart = cpuid();
    80026b60:	ffffb097          	auipc	ra,0xffffb
    80026b64:	fc6080e7          	jalr	-58(ra) # 80021b26 <cpuid>
  #ifndef QEMU
  *(uint32*)PLIC_MCLAIM(hart) = irq;
    80026b68:	00d5151b          	slliw	a0,a0,0xd
    80026b6c:	1f8617b7          	lui	a5,0x1f861
    80026b70:	07a6                	slli	a5,a5,0x9
    80026b72:	97aa                	add	a5,a5,a0
    80026b74:	c3c4                	sw	s1,4(a5)
  #else
  *(uint32*)PLIC_SCLAIM(hart) = irq;
  #endif
}
    80026b76:	60e2                	ld	ra,24(sp)
    80026b78:	6442                	ld	s0,16(sp)
    80026b7a:	64a2                	ld	s1,8(sp)
    80026b7c:	6105                	addi	sp,sp,32
    80026b7e:	8082                	ret

0000000080026b80 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80026b80:	715d                	addi	sp,sp,-80
    80026b82:	e486                	sd	ra,72(sp)
    80026b84:	e0a2                	sd	s0,64(sp)
    80026b86:	fc26                	sd	s1,56(sp)
    80026b88:	f84a                	sd	s2,48(sp)
    80026b8a:	f44e                	sd	s3,40(sp)
    80026b8c:	f052                	sd	s4,32(sp)
    80026b8e:	ec56                	sd	s5,24(sp)
    80026b90:	0880                	addi	s0,sp,80
    80026b92:	8a2a                	mv	s4,a0
    80026b94:	892e                	mv	s2,a1
    80026b96:	89b2                	mv	s3,a2
  int i;

  acquire(&cons.lock);
    80026b98:	0001e517          	auipc	a0,0x1e
    80026b9c:	08850513          	addi	a0,a0,136 # 80044c20 <cons>
    80026ba0:	ffffa097          	auipc	ra,0xffffa
    80026ba4:	b20080e7          	jalr	-1248(ra) # 800206c0 <acquire>
  for(i = 0; i < n; i++){
    80026ba8:	05305d63          	blez	s3,80026c02 <consolewrite+0x82>
    80026bac:	4481                	li	s1,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80026bae:	5afd                	li	s5,-1
    80026bb0:	4685                	li	a3,1
    80026bb2:	864a                	mv	a2,s2
    80026bb4:	85d2                	mv	a1,s4
    80026bb6:	fbf40513          	addi	a0,s0,-65
    80026bba:	ffffc097          	auipc	ra,0xffffc
    80026bbe:	aac080e7          	jalr	-1364(ra) # 80022666 <either_copyin>
    80026bc2:	01550e63          	beq	a0,s5,80026bde <consolewrite+0x5e>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
    80026bc6:	fbf44503          	lbu	a0,-65(s0)
    80026bca:	4581                	li	a1,0
    80026bcc:	4601                	li	a2,0
    80026bce:	4681                	li	a3,0
    80026bd0:	4885                	li	a7,1
    80026bd2:	00000073          	ecall
  for(i = 0; i < n; i++){
    80026bd6:	2485                	addiw	s1,s1,1
    80026bd8:	0905                	addi	s2,s2,1
    80026bda:	fc999be3          	bne	s3,s1,80026bb0 <consolewrite+0x30>
      break;
    sbi_console_putchar(c);
  }
  release(&cons.lock);
    80026bde:	0001e517          	auipc	a0,0x1e
    80026be2:	04250513          	addi	a0,a0,66 # 80044c20 <cons>
    80026be6:	ffffa097          	auipc	ra,0xffffa
    80026bea:	b2e080e7          	jalr	-1234(ra) # 80020714 <release>

  return i;
}
    80026bee:	8526                	mv	a0,s1
    80026bf0:	60a6                	ld	ra,72(sp)
    80026bf2:	6406                	ld	s0,64(sp)
    80026bf4:	74e2                	ld	s1,56(sp)
    80026bf6:	7942                	ld	s2,48(sp)
    80026bf8:	79a2                	ld	s3,40(sp)
    80026bfa:	7a02                	ld	s4,32(sp)
    80026bfc:	6ae2                	ld	s5,24(sp)
    80026bfe:	6161                	addi	sp,sp,80
    80026c00:	8082                	ret
  for(i = 0; i < n; i++){
    80026c02:	4481                	li	s1,0
    80026c04:	bfe9                	j	80026bde <consolewrite+0x5e>

0000000080026c06 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80026c06:	7119                	addi	sp,sp,-128
    80026c08:	fc86                	sd	ra,120(sp)
    80026c0a:	f8a2                	sd	s0,112(sp)
    80026c0c:	f4a6                	sd	s1,104(sp)
    80026c0e:	f0ca                	sd	s2,96(sp)
    80026c10:	ecce                	sd	s3,88(sp)
    80026c12:	e8d2                	sd	s4,80(sp)
    80026c14:	e4d6                	sd	s5,72(sp)
    80026c16:	e0da                	sd	s6,64(sp)
    80026c18:	fc5e                	sd	s7,56(sp)
    80026c1a:	f862                	sd	s8,48(sp)
    80026c1c:	f466                	sd	s9,40(sp)
    80026c1e:	f06a                	sd	s10,32(sp)
    80026c20:	ec6e                	sd	s11,24(sp)
    80026c22:	0100                	addi	s0,sp,128
    80026c24:	8caa                	mv	s9,a0
    80026c26:	8aae                	mv	s5,a1
    80026c28:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80026c2a:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80026c2e:	0001e517          	auipc	a0,0x1e
    80026c32:	ff250513          	addi	a0,a0,-14 # 80044c20 <cons>
    80026c36:	ffffa097          	auipc	ra,0xffffa
    80026c3a:	a8a080e7          	jalr	-1398(ra) # 800206c0 <acquire>
  while(n > 0){
    80026c3e:	09405663          	blez	s4,80026cca <consoleread+0xc4>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80026c42:	0001e497          	auipc	s1,0x1e
    80026c46:	fde48493          	addi	s1,s1,-34 # 80044c20 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80026c4a:	89a6                	mv	s3,s1
    80026c4c:	0001e917          	auipc	s2,0x1e
    80026c50:	06c90913          	addi	s2,s2,108 # 80044cb8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    80026c54:	4c11                	li	s8,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80026c56:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80026c58:	4da9                	li	s11,10
    while(cons.r == cons.w){
    80026c5a:	0984a783          	lw	a5,152(s1)
    80026c5e:	09c4a703          	lw	a4,156(s1)
    80026c62:	02f71463          	bne	a4,a5,80026c8a <consoleread+0x84>
      if(myproc()->killed){
    80026c66:	ffffb097          	auipc	ra,0xffffb
    80026c6a:	eec080e7          	jalr	-276(ra) # 80021b52 <myproc>
    80026c6e:	591c                	lw	a5,48(a0)
    80026c70:	eba5                	bnez	a5,80026ce0 <consoleread+0xda>
      sleep(&cons.r, &cons.lock);
    80026c72:	85ce                	mv	a1,s3
    80026c74:	854a                	mv	a0,s2
    80026c76:	ffffb097          	auipc	ra,0xffffb
    80026c7a:	75e080e7          	jalr	1886(ra) # 800223d4 <sleep>
    while(cons.r == cons.w){
    80026c7e:	0984a783          	lw	a5,152(s1)
    80026c82:	09c4a703          	lw	a4,156(s1)
    80026c86:	fef700e3          	beq	a4,a5,80026c66 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF];
    80026c8a:	0017871b          	addiw	a4,a5,1
    80026c8e:	08e4ac23          	sw	a4,152(s1)
    80026c92:	07f7f713          	andi	a4,a5,127
    80026c96:	9726                	add	a4,a4,s1
    80026c98:	01874703          	lbu	a4,24(a4) # 8000018 <BASE_ADDRESS-0x7801ffe8>
    80026c9c:	00070b9b          	sext.w	s7,a4
    if(c == C('D')){  // end-of-file
    80026ca0:	078b8863          	beq	s7,s8,80026d10 <consoleread+0x10a>
    cbuf = c;
    80026ca4:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80026ca8:	4685                	li	a3,1
    80026caa:	f8f40613          	addi	a2,s0,-113
    80026cae:	85d6                	mv	a1,s5
    80026cb0:	8566                	mv	a0,s9
    80026cb2:	ffffc097          	auipc	ra,0xffffc
    80026cb6:	97e080e7          	jalr	-1666(ra) # 80022630 <either_copyout>
    80026cba:	01a50863          	beq	a0,s10,80026cca <consoleread+0xc4>
    dst++;
    80026cbe:	0a85                	addi	s5,s5,1
    --n;
    80026cc0:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80026cc2:	01bb8463          	beq	s7,s11,80026cca <consoleread+0xc4>
  while(n > 0){
    80026cc6:	f80a1ae3          	bnez	s4,80026c5a <consoleread+0x54>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80026cca:	0001e517          	auipc	a0,0x1e
    80026cce:	f5650513          	addi	a0,a0,-170 # 80044c20 <cons>
    80026cd2:	ffffa097          	auipc	ra,0xffffa
    80026cd6:	a42080e7          	jalr	-1470(ra) # 80020714 <release>

  return target - n;
    80026cda:	414b053b          	subw	a0,s6,s4
    80026cde:	a811                	j	80026cf2 <consoleread+0xec>
        release(&cons.lock);
    80026ce0:	0001e517          	auipc	a0,0x1e
    80026ce4:	f4050513          	addi	a0,a0,-192 # 80044c20 <cons>
    80026ce8:	ffffa097          	auipc	ra,0xffffa
    80026cec:	a2c080e7          	jalr	-1492(ra) # 80020714 <release>
        return -1;
    80026cf0:	557d                	li	a0,-1
}
    80026cf2:	70e6                	ld	ra,120(sp)
    80026cf4:	7446                	ld	s0,112(sp)
    80026cf6:	74a6                	ld	s1,104(sp)
    80026cf8:	7906                	ld	s2,96(sp)
    80026cfa:	69e6                	ld	s3,88(sp)
    80026cfc:	6a46                	ld	s4,80(sp)
    80026cfe:	6aa6                	ld	s5,72(sp)
    80026d00:	6b06                	ld	s6,64(sp)
    80026d02:	7be2                	ld	s7,56(sp)
    80026d04:	7c42                	ld	s8,48(sp)
    80026d06:	7ca2                	ld	s9,40(sp)
    80026d08:	7d02                	ld	s10,32(sp)
    80026d0a:	6de2                	ld	s11,24(sp)
    80026d0c:	6109                	addi	sp,sp,128
    80026d0e:	8082                	ret
      if(n < target){
    80026d10:	000a071b          	sext.w	a4,s4
    80026d14:	fb677be3          	bgeu	a4,s6,80026cca <consoleread+0xc4>
        cons.r--;
    80026d18:	0001e717          	auipc	a4,0x1e
    80026d1c:	faf72023          	sw	a5,-96(a4) # 80044cb8 <cons+0x98>
    80026d20:	b76d                	j	80026cca <consoleread+0xc4>

0000000080026d22 <consputc>:
void consputc(int c) {
    80026d22:	1141                	addi	sp,sp,-16
    80026d24:	e422                	sd	s0,8(sp)
    80026d26:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80026d28:	10000793          	li	a5,256
    80026d2c:	00f50b63          	beq	a0,a5,80026d42 <consputc+0x20>
    80026d30:	4581                	li	a1,0
    80026d32:	4601                	li	a2,0
    80026d34:	4681                	li	a3,0
    80026d36:	4885                	li	a7,1
    80026d38:	00000073          	ecall
}
    80026d3c:	6422                	ld	s0,8(sp)
    80026d3e:	0141                	addi	sp,sp,16
    80026d40:	8082                	ret
    80026d42:	4521                	li	a0,8
    80026d44:	4581                	li	a1,0
    80026d46:	4601                	li	a2,0
    80026d48:	4681                	li	a3,0
    80026d4a:	4885                	li	a7,1
    80026d4c:	00000073          	ecall
    80026d50:	02000513          	li	a0,32
    80026d54:	00000073          	ecall
    80026d58:	4521                	li	a0,8
    80026d5a:	00000073          	ecall
    80026d5e:	bff9                	j	80026d3c <consputc+0x1a>

0000000080026d60 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80026d60:	1101                	addi	sp,sp,-32
    80026d62:	ec06                	sd	ra,24(sp)
    80026d64:	e822                	sd	s0,16(sp)
    80026d66:	e426                	sd	s1,8(sp)
    80026d68:	e04a                	sd	s2,0(sp)
    80026d6a:	1000                	addi	s0,sp,32
    80026d6c:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80026d6e:	0001e517          	auipc	a0,0x1e
    80026d72:	eb250513          	addi	a0,a0,-334 # 80044c20 <cons>
    80026d76:	ffffa097          	auipc	ra,0xffffa
    80026d7a:	94a080e7          	jalr	-1718(ra) # 800206c0 <acquire>

  switch(c){
    80026d7e:	47c1                	li	a5,16
    80026d80:	14f48063          	beq	s1,a5,80026ec0 <consoleintr+0x160>
    80026d84:	0297df63          	bge	a5,s1,80026dc2 <consoleintr+0x62>
    80026d88:	47d5                	li	a5,21
    80026d8a:	0cf48463          	beq	s1,a5,80026e52 <consoleintr+0xf2>
    80026d8e:	07f00793          	li	a5,127
    80026d92:	02f49b63          	bne	s1,a5,80026dc8 <consoleintr+0x68>
      consputc(BACKSPACE);
    }
    break;
  case C('H'): // Backspace
  case '\x7f':
    if(cons.e != cons.w){
    80026d96:	0001e717          	auipc	a4,0x1e
    80026d9a:	e8a70713          	addi	a4,a4,-374 # 80044c20 <cons>
    80026d9e:	0a072783          	lw	a5,160(a4)
    80026da2:	09c72703          	lw	a4,156(a4)
    80026da6:	12f70163          	beq	a4,a5,80026ec8 <consoleintr+0x168>
      cons.e--;
    80026daa:	37fd                	addiw	a5,a5,-1
    80026dac:	0001e717          	auipc	a4,0x1e
    80026db0:	f0f72a23          	sw	a5,-236(a4) # 80044cc0 <cons+0xa0>
      consputc(BACKSPACE);
    80026db4:	10000513          	li	a0,256
    80026db8:	00000097          	auipc	ra,0x0
    80026dbc:	f6a080e7          	jalr	-150(ra) # 80026d22 <consputc>
    80026dc0:	a221                	j	80026ec8 <consoleintr+0x168>
  switch(c){
    80026dc2:	47a1                	li	a5,8
    80026dc4:	fcf489e3          	beq	s1,a5,80026d96 <consoleintr+0x36>
    }
    break;
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80026dc8:	10048063          	beqz	s1,80026ec8 <consoleintr+0x168>
    80026dcc:	0001e717          	auipc	a4,0x1e
    80026dd0:	e5470713          	addi	a4,a4,-428 # 80044c20 <cons>
    80026dd4:	0a072783          	lw	a5,160(a4)
    80026dd8:	09872703          	lw	a4,152(a4)
    80026ddc:	9f99                	subw	a5,a5,a4
    80026dde:	07f00713          	li	a4,127
    80026de2:	0ef76363          	bltu	a4,a5,80026ec8 <consoleintr+0x168>
      #ifndef QEMU
      if (c == '\r') break;     // on k210, "enter" will input \n and \r
    80026de6:	47b5                	li	a5,13
    80026de8:	0ef48063          	beq	s1,a5,80026ec8 <consoleintr+0x168>
      #else
      c = (c == '\r') ? '\n' : c;
      #endif
      // echo back to the user.
      consputc(c);
    80026dec:	8526                	mv	a0,s1
    80026dee:	00000097          	auipc	ra,0x0
    80026df2:	f34080e7          	jalr	-204(ra) # 80026d22 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80026df6:	0001e797          	auipc	a5,0x1e
    80026dfa:	e2a78793          	addi	a5,a5,-470 # 80044c20 <cons>
    80026dfe:	0a07a703          	lw	a4,160(a5)
    80026e02:	0017069b          	addiw	a3,a4,1
    80026e06:	0006861b          	sext.w	a2,a3
    80026e0a:	0ad7a023          	sw	a3,160(a5)
    80026e0e:	07f77713          	andi	a4,a4,127
    80026e12:	97ba                	add	a5,a5,a4
    80026e14:	00978c23          	sb	s1,24(a5)

      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80026e18:	47a9                	li	a5,10
    80026e1a:	00f48f63          	beq	s1,a5,80026e38 <consoleintr+0xd8>
    80026e1e:	4791                	li	a5,4
    80026e20:	00f48c63          	beq	s1,a5,80026e38 <consoleintr+0xd8>
    80026e24:	0001e797          	auipc	a5,0x1e
    80026e28:	dfc78793          	addi	a5,a5,-516 # 80044c20 <cons>
    80026e2c:	0987a783          	lw	a5,152(a5)
    80026e30:	0807879b          	addiw	a5,a5,128
    80026e34:	08c79a63          	bne	a5,a2,80026ec8 <consoleintr+0x168>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80026e38:	0001e797          	auipc	a5,0x1e
    80026e3c:	e8d7a223          	sw	a3,-380(a5) # 80044cbc <cons+0x9c>
        wakeup(&cons.r);
    80026e40:	0001e517          	auipc	a0,0x1e
    80026e44:	e7850513          	addi	a0,a0,-392 # 80044cb8 <cons+0x98>
    80026e48:	ffffb097          	auipc	ra,0xffffb
    80026e4c:	70e080e7          	jalr	1806(ra) # 80022556 <wakeup>
    80026e50:	a8a5                	j	80026ec8 <consoleintr+0x168>
    while(cons.e != cons.w &&
    80026e52:	0001e717          	auipc	a4,0x1e
    80026e56:	dce70713          	addi	a4,a4,-562 # 80044c20 <cons>
    80026e5a:	0a072783          	lw	a5,160(a4)
    80026e5e:	09c72703          	lw	a4,156(a4)
    80026e62:	06f70363          	beq	a4,a5,80026ec8 <consoleintr+0x168>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80026e66:	37fd                	addiw	a5,a5,-1
    80026e68:	0007871b          	sext.w	a4,a5
    80026e6c:	07f7f793          	andi	a5,a5,127
    80026e70:	0001e697          	auipc	a3,0x1e
    80026e74:	db068693          	addi	a3,a3,-592 # 80044c20 <cons>
    80026e78:	97b6                	add	a5,a5,a3
    while(cons.e != cons.w &&
    80026e7a:	0187c683          	lbu	a3,24(a5)
    80026e7e:	47a9                	li	a5,10
      cons.e--;
    80026e80:	0001e497          	auipc	s1,0x1e
    80026e84:	da048493          	addi	s1,s1,-608 # 80044c20 <cons>
    while(cons.e != cons.w &&
    80026e88:	4929                	li	s2,10
    80026e8a:	02f68f63          	beq	a3,a5,80026ec8 <consoleintr+0x168>
      cons.e--;
    80026e8e:	0ae4a023          	sw	a4,160(s1)
      consputc(BACKSPACE);
    80026e92:	10000513          	li	a0,256
    80026e96:	00000097          	auipc	ra,0x0
    80026e9a:	e8c080e7          	jalr	-372(ra) # 80026d22 <consputc>
    while(cons.e != cons.w &&
    80026e9e:	0a04a783          	lw	a5,160(s1)
    80026ea2:	09c4a703          	lw	a4,156(s1)
    80026ea6:	02f70163          	beq	a4,a5,80026ec8 <consoleintr+0x168>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80026eaa:	37fd                	addiw	a5,a5,-1
    80026eac:	0007871b          	sext.w	a4,a5
    80026eb0:	07f7f793          	andi	a5,a5,127
    80026eb4:	97a6                	add	a5,a5,s1
    while(cons.e != cons.w &&
    80026eb6:	0187c783          	lbu	a5,24(a5)
    80026eba:	fd279ae3          	bne	a5,s2,80026e8e <consoleintr+0x12e>
    80026ebe:	a029                	j	80026ec8 <consoleintr+0x168>
    procdump();
    80026ec0:	ffffb097          	auipc	ra,0xffffb
    80026ec4:	7da080e7          	jalr	2010(ra) # 8002269a <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80026ec8:	0001e517          	auipc	a0,0x1e
    80026ecc:	d5850513          	addi	a0,a0,-680 # 80044c20 <cons>
    80026ed0:	ffffa097          	auipc	ra,0xffffa
    80026ed4:	844080e7          	jalr	-1980(ra) # 80020714 <release>
}
    80026ed8:	60e2                	ld	ra,24(sp)
    80026eda:	6442                	ld	s0,16(sp)
    80026edc:	64a2                	ld	s1,8(sp)
    80026ede:	6902                	ld	s2,0(sp)
    80026ee0:	6105                	addi	sp,sp,32
    80026ee2:	8082                	ret

0000000080026ee4 <consoleinit>:

void
consoleinit(void)
{
    80026ee4:	1101                	addi	sp,sp,-32
    80026ee6:	ec06                	sd	ra,24(sp)
    80026ee8:	e822                	sd	s0,16(sp)
    80026eea:	e426                	sd	s1,8(sp)
    80026eec:	1000                	addi	s0,sp,32
  initlock(&cons.lock, "cons");
    80026eee:	0001e497          	auipc	s1,0x1e
    80026ef2:	d3248493          	addi	s1,s1,-718 # 80044c20 <cons>
    80026ef6:	00005597          	auipc	a1,0x5
    80026efa:	5f258593          	addi	a1,a1,1522 # 8002c4e8 <syscalls+0xb80>
    80026efe:	8526                	mv	a0,s1
    80026f00:	ffff9097          	auipc	ra,0xffff9
    80026f04:	77c080e7          	jalr	1916(ra) # 8002067c <initlock>

  cons.e = cons.w = cons.r = 0;
    80026f08:	0804ac23          	sw	zero,152(s1)
    80026f0c:	0804ae23          	sw	zero,156(s1)
    80026f10:	0a04a023          	sw	zero,160(s1)
  
  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80026f14:	00018797          	auipc	a5,0x18
    80026f18:	49c78793          	addi	a5,a5,1180 # 8003f3b0 <devsw>
    80026f1c:	00000717          	auipc	a4,0x0
    80026f20:	cea70713          	addi	a4,a4,-790 # 80026c06 <consoleread>
    80026f24:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80026f26:	00000717          	auipc	a4,0x0
    80026f2a:	c5a70713          	addi	a4,a4,-934 # 80026b80 <consolewrite>
    80026f2e:	ef98                	sd	a4,24(a5)
}
    80026f30:	60e2                	ld	ra,24(sp)
    80026f32:	6442                	ld	s0,16(sp)
    80026f34:	64a2                	ld	s1,8(sp)
    80026f36:	6105                	addi	sp,sp,32
    80026f38:	8082                	ret

0000000080026f3a <spi_set_tmod>:
    spi_adapter->endian = endian;
}


static void spi_set_tmod(uint8 spi_num, uint32 tmod)
{
    80026f3a:	1141                	addi	sp,sp,-16
    80026f3c:	e406                	sd	ra,8(sp)
    80026f3e:	e022                	sd	s0,0(sp)
    80026f40:	0800                	addi	s0,sp,16
    80026f42:	872a                	mv	a4,a0
    // configASSERT(spi_num < SPI_DEVICE_MAX);
    volatile spi_t *spi_handle = spi[spi_num];
    80026f44:	00351693          	slli	a3,a0,0x3
    80026f48:	00005797          	auipc	a5,0x5
    80026f4c:	5a878793          	addi	a5,a5,1448 # 8002c4f0 <spi>
    80026f50:	97b6                	add	a5,a5,a3
    80026f52:	6388                	ld	a0,0(a5)
    uint8 tmod_offset = 0;
    switch(spi_num)
    80026f54:	4689                	li	a3,2
    {
        case 0:
        case 1:
        case 2:
            tmod_offset = 8;
    80026f56:	47a1                	li	a5,8
    switch(spi_num)
    80026f58:	00e6f363          	bgeu	a3,a4,80026f5e <spi_set_tmod+0x24>
            break;
        case 3:
        default:
            tmod_offset = 10;
    80026f5c:	47a9                	li	a5,10
            break;
    }
    set_bit(&spi_handle->ctrlr0, 3 << tmod_offset, tmod << tmod_offset);
    80026f5e:	2781                	sext.w	a5,a5
    80026f60:	00f5963b          	sllw	a2,a1,a5
    80026f64:	458d                	li	a1,3
    80026f66:	00f595bb          	sllw	a1,a1,a5
    80026f6a:	00001097          	auipc	ra,0x1
    80026f6e:	f10080e7          	jalr	-240(ra) # 80027e7a <set_bit>
}
    80026f72:	60a2                	ld	ra,8(sp)
    80026f74:	6402                	ld	s0,0(sp)
    80026f76:	0141                	addi	sp,sp,16
    80026f78:	8082                	ret

0000000080026f7a <spi_init>:
{
    80026f7a:	1141                	addi	sp,sp,-16
    80026f7c:	e422                	sd	s0,8(sp)
    80026f7e:	0800                	addi	s0,sp,16
    switch(spi_num)
    80026f80:	4785                	li	a5,1
    80026f82:	06a7f463          	bgeu	a5,a0,80026fea <spi_init+0x70>
    80026f86:	4789                	li	a5,2
    80026f88:	06f50563          	beq	a0,a5,80026ff2 <spi_init+0x78>
            work_mode_offset = 8;
    80026f8c:	4321                	li	t1,8
            frf_offset = 22;
    80026f8e:	48d9                	li	a7,22
            dfs_offset = 0;
    80026f90:	4801                	li	a6,0
    volatile spi_t *spi_adapter = spi[spi_num];
    80026f92:	1502                	slli	a0,a0,0x20
    80026f94:	9101                	srli	a0,a0,0x20
    80026f96:	050e                	slli	a0,a0,0x3
    80026f98:	00005797          	auipc	a5,0x5
    80026f9c:	55878793          	addi	a5,a5,1368 # 8002c4f0 <spi>
    80026fa0:	953e                	add	a0,a0,a5
    80026fa2:	611c                	ld	a5,0(a0)
    if(spi_adapter->baudr == 0)
    80026fa4:	4bc8                	lw	a0,20(a5)
    80026fa6:	2501                	sext.w	a0,a0
    80026fa8:	e119                	bnez	a0,80026fae <spi_init+0x34>
        spi_adapter->baudr = 0x14;
    80026faa:	4551                	li	a0,20
    80026fac:	cbc8                	sw	a0,20(a5)
    spi_adapter->imr = 0x00;
    80026fae:	0207a623          	sw	zero,44(a5)
    spi_adapter->dmacr = 0x00;
    80026fb2:	0407a623          	sw	zero,76(a5)
    spi_adapter->dmatdlr = 0x10;
    80026fb6:	4541                	li	a0,16
    80026fb8:	cba8                	sw	a0,80(a5)
    spi_adapter->dmardlr = 0x00;
    80026fba:	0407aa23          	sw	zero,84(a5)
    spi_adapter->ser = 0x00;
    80026fbe:	0007a823          	sw	zero,16(a5)
    spi_adapter->ssienr = 0x00;
    80026fc2:	0007a423          	sw	zero,8(a5)
    spi_adapter->ctrlr0 = (work_mode << work_mode_offset) | (frame_format << frf_offset) | ((data_bit_length - 1) << dfs_offset);
    80026fc6:	006595bb          	sllw	a1,a1,t1
    80026fca:	0116163b          	sllw	a2,a2,a7
    80026fce:	8dd1                	or	a1,a1,a2
    80026fd0:	16fd                	addi	a3,a3,-1
    80026fd2:	010696b3          	sll	a3,a3,a6
    80026fd6:	8dd5                	or	a1,a1,a3
    80026fd8:	2581                	sext.w	a1,a1
    80026fda:	c38c                	sw	a1,0(a5)
    spi_adapter->spi_ctrlr0 = 0;
    80026fdc:	0e07aa23          	sw	zero,244(a5)
    spi_adapter->endian = endian;
    80026fe0:	10e7ac23          	sw	a4,280(a5)
}
    80026fe4:	6422                	ld	s0,8(sp)
    80026fe6:	0141                	addi	sp,sp,16
    80026fe8:	8082                	ret
            work_mode_offset = 6;
    80026fea:	4319                	li	t1,6
            frf_offset = 21;
    80026fec:	48d5                	li	a7,21
            dfs_offset = 16;
    80026fee:	4841                	li	a6,16
    80026ff0:	b74d                	j	80026f92 <spi_init+0x18>
    uint8 work_mode_offset = 0;
    80026ff2:	4301                	li	t1,0
    uint8 frf_offset = 0;
    80026ff4:	4881                	li	a7,0
    uint8 dfs_offset = 0;
    80026ff6:	4801                	li	a6,0
    80026ff8:	bf69                	j	80026f92 <spi_init+0x18>

0000000080026ffa <spi_send_data_normal>:
        return SPI_TRANS_SHORT;
    return SPI_TRANS_INT;
}

void spi_send_data_normal(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *tx_buff, uint64 tx_len)
{
    80026ffa:	7119                	addi	sp,sp,-128
    80026ffc:	fc86                	sd	ra,120(sp)
    80026ffe:	f8a2                	sd	s0,112(sp)
    80027000:	f4a6                	sd	s1,104(sp)
    80027002:	f0ca                	sd	s2,96(sp)
    80027004:	ecce                	sd	s3,88(sp)
    80027006:	e8d2                	sd	s4,80(sp)
    80027008:	e4d6                	sd	s5,72(sp)
    8002700a:	e0da                	sd	s6,64(sp)
    8002700c:	fc5e                	sd	s7,56(sp)
    8002700e:	f862                	sd	s8,48(sp)
    80027010:	f466                	sd	s9,40(sp)
    80027012:	f06a                	sd	s10,32(sp)
    80027014:	ec6e                	sd	s11,24(sp)
    80027016:	0100                	addi	s0,sp,128
    80027018:	84aa                	mv	s1,a0
    8002701a:	8aae                	mv	s5,a1
    8002701c:	89b2                	mv	s3,a2
    8002701e:	8a36                	mv	s4,a3
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    uint64 index, fifo_len;
    spi_set_tmod(spi_num, SPI_TMOD_TRANS);
    80027020:	4585                	li	a1,1
    80027022:	0ff57513          	andi	a0,a0,255
    80027026:	00000097          	auipc	ra,0x0
    8002702a:	f14080e7          	jalr	-236(ra) # 80026f3a <spi_set_tmod>

    volatile spi_t *spi_handle = spi[spi_num];
    8002702e:	02049793          	slli	a5,s1,0x20
    80027032:	9381                	srli	a5,a5,0x20
    80027034:	00379713          	slli	a4,a5,0x3
    80027038:	00005797          	auipc	a5,0x5
    8002703c:	4b878793          	addi	a5,a5,1208 # 8002c4f0 <spi>
    80027040:	97ba                	add	a5,a5,a4
    80027042:	0007b903          	ld	s2,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80027046:	0024b493          	sltiu	s1,s1,2
    8002704a:	0492                	slli	s1,s1,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    8002704c:	00092783          	lw	a5,0(s2)
    80027050:	0097d4bb          	srlw	s1,a5,s1
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80027054:	88fd                	andi	s1,s1,31
    if(data_bit_length < 8)
    80027056:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    80027058:	4b85                	li	s7,1
    if(data_bit_length < 8)
    8002705a:	0097f663          	bgeu	a5,s1,80027066 <spi_send_data_normal+0x6c>
    else if(data_bit_length < 16)
    8002705e:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    80027060:	4b91                	li	s7,4
    else if(data_bit_length < 16)
    80027062:	0297f863          	bgeu	a5,s1,80027092 <spi_send_data_normal+0x98>

    uint8 v_misalign_flag = 0;
    uint32 v_send_data;
    if((uintptr_t)tx_buff % frame_width)
    80027066:	020b9c93          	slli	s9,s7,0x20
    8002706a:	020cdc93          	srli	s9,s9,0x20
    8002706e:	0399fcb3          	remu	s9,s3,s9
        v_misalign_flag = 1;

    spi_handle->ssienr = 0x01;
    80027072:	4785                	li	a5,1
    80027074:	00f92423          	sw	a5,8(s2)
    spi_handle->ser = 1U << chip_select;
    80027078:	4585                	li	a1,1
    8002707a:	015595bb          	sllw	a1,a1,s5
    8002707e:	00b92823          	sw	a1,16(s2)
    uint32 i = 0;
    while(tx_len)
    80027082:	120a0a63          	beqz	s4,800271b6 <spi_send_data_normal+0x1bc>
    uint32 i = 0;
    80027086:	4481                	li	s1,0
    {
        fifo_len = 32 - spi_handle->txflr;
    80027088:	02000c13          	li	s8,32
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
        switch(frame_width)
    8002708c:	4b09                	li	s6,2
    8002708e:	4a91                	li	s5,4
    80027090:	a0b5                	j	800270fc <spi_send_data_normal+0x102>
        return SPI_TRANS_SHORT;
    80027092:	4b89                	li	s7,2
    80027094:	bfc9                	j	80027066 <spi_send_data_normal+0x6c>
        {
            case SPI_TRANS_INT:
                fifo_len = fifo_len / 4 * 4;
    80027096:	ffc77d13          	andi	s10,a4,-4
                if(v_misalign_flag)
    8002709a:	020c9763          	bnez	s9,800270c8 <spi_send_data_normal+0xce>
                        spi_handle->dr[0] = v_send_data;
                        i += 4;
                    }
                } else
                {
                    for(index = 0; index < fifo_len / 4; index++)
    8002709e:	8309                	srli	a4,a4,0x2
    800270a0:	009705bb          	addw	a1,a4,s1
    800270a4:	87a6                	mv	a5,s1
    800270a6:	c739                	beqz	a4,800270f4 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint32 *)tx_buff)[i++];
    800270a8:	0017869b          	addiw	a3,a5,1
    800270ac:	0006861b          	sext.w	a2,a3
    800270b0:	1782                	slli	a5,a5,0x20
    800270b2:	9381                	srli	a5,a5,0x20
    800270b4:	078a                	slli	a5,a5,0x2
    800270b6:	97ce                	add	a5,a5,s3
    800270b8:	439c                	lw	a5,0(a5)
    800270ba:	06f92023          	sw	a5,96(s2)
    800270be:	87b2                	mv	a5,a2
                    for(index = 0; index < fifo_len / 4; index++)
    800270c0:	fec594e3          	bne	a1,a2,800270a8 <spi_send_data_normal+0xae>
    800270c4:	9cb9                	addw	s1,s1,a4
    800270c6:	a03d                	j	800270f4 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 4)
    800270c8:	020d0663          	beqz	s10,800270f4 <spi_send_data_normal+0xfa>
    800270cc:	4d81                	li	s11,0
                        memmove(&v_send_data, tx_buff + i, 4);
    800270ce:	02049593          	slli	a1,s1,0x20
    800270d2:	9181                	srli	a1,a1,0x20
    800270d4:	8656                	mv	a2,s5
    800270d6:	95ce                	add	a1,a1,s3
    800270d8:	f8c40513          	addi	a0,s0,-116
    800270dc:	ffff9097          	auipc	ra,0xffff9
    800270e0:	6ec080e7          	jalr	1772(ra) # 800207c8 <memmove>
                        spi_handle->dr[0] = v_send_data;
    800270e4:	f8c42783          	lw	a5,-116(s0)
    800270e8:	06f92023          	sw	a5,96(s2)
                        i += 4;
    800270ec:	2491                	addiw	s1,s1,4
                    for(index = 0; index < fifo_len; index += 4)
    800270ee:	0d91                	addi	s11,s11,4
    800270f0:	fdadefe3          	bltu	s11,s10,800270ce <spi_send_data_normal+0xd4>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = tx_buff[i++];
                break;
        }
        tx_len -= fifo_len;
    800270f4:	41aa0a33          	sub	s4,s4,s10
    while(tx_len)
    800270f8:	0a0a0f63          	beqz	s4,800271b6 <spi_send_data_normal+0x1bc>
        fifo_len = 32 - spi_handle->txflr;
    800270fc:	02092703          	lw	a4,32(s2)
    80027100:	40ec073b          	subw	a4,s8,a4
    80027104:	1702                	slli	a4,a4,0x20
    80027106:	9301                	srli	a4,a4,0x20
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    80027108:	00ea7363          	bgeu	s4,a4,8002710e <spi_send_data_normal+0x114>
    8002710c:	8752                	mv	a4,s4
        switch(frame_width)
    8002710e:	036b8a63          	beq	s7,s6,80027142 <spi_send_data_normal+0x148>
    80027112:	f95b82e3          	beq	s7,s5,80027096 <spi_send_data_normal+0x9c>
    80027116:	009705bb          	addw	a1,a4,s1
                for(index = 0; index < fifo_len; index++)
    8002711a:	87a6                	mv	a5,s1
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    8002711c:	8d3a                	mv	s10,a4
                for(index = 0; index < fifo_len; index++)
    8002711e:	db79                	beqz	a4,800270f4 <spi_send_data_normal+0xfa>
                    spi_handle->dr[0] = tx_buff[i++];
    80027120:	0017869b          	addiw	a3,a5,1
    80027124:	0006861b          	sext.w	a2,a3
    80027128:	1782                	slli	a5,a5,0x20
    8002712a:	9381                	srli	a5,a5,0x20
    8002712c:	97ce                	add	a5,a5,s3
    8002712e:	0007c783          	lbu	a5,0(a5)
    80027132:	06f92023          	sw	a5,96(s2)
    80027136:	87b2                	mv	a5,a2
                for(index = 0; index < fifo_len; index++)
    80027138:	fec594e3          	bne	a1,a2,80027120 <spi_send_data_normal+0x126>
    8002713c:	9cb9                	addw	s1,s1,a4
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    8002713e:	8d3a                	mv	s10,a4
    80027140:	bf55                	j	800270f4 <spi_send_data_normal+0xfa>
                fifo_len = fifo_len / 2 * 2;
    80027142:	ffe77d13          	andi	s10,a4,-2
                if(v_misalign_flag)
    80027146:	020c9863          	bnez	s9,80027176 <spi_send_data_normal+0x17c>
                    for(index = 0; index < fifo_len / 2; index++)
    8002714a:	8305                	srli	a4,a4,0x1
    8002714c:	009705bb          	addw	a1,a4,s1
    80027150:	87a6                	mv	a5,s1
    80027152:	d34d                	beqz	a4,800270f4 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint16 *)tx_buff)[i++];
    80027154:	0017869b          	addiw	a3,a5,1
    80027158:	0006861b          	sext.w	a2,a3
    8002715c:	1782                	slli	a5,a5,0x20
    8002715e:	9381                	srli	a5,a5,0x20
    80027160:	0786                	slli	a5,a5,0x1
    80027162:	97ce                	add	a5,a5,s3
    80027164:	0007d783          	lhu	a5,0(a5)
    80027168:	06f92023          	sw	a5,96(s2)
    8002716c:	87b2                	mv	a5,a2
                    for(index = 0; index < fifo_len / 2; index++)
    8002716e:	fec593e3          	bne	a1,a2,80027154 <spi_send_data_normal+0x15a>
    80027172:	9cb9                	addw	s1,s1,a4
    80027174:	b741                	j	800270f4 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 2)
    80027176:	f60d0fe3          	beqz	s10,800270f4 <spi_send_data_normal+0xfa>
    8002717a:	fffd0d93          	addi	s11,s10,-1 # ffffffffffffefff <kernel_end+0xffffffff7ffb9fff>
    8002717e:	001ddd93          	srli	s11,s11,0x1
    80027182:	001d9d9b          	slliw	s11,s11,0x1
    80027186:	0024879b          	addiw	a5,s1,2
    8002718a:	00fd8dbb          	addw	s11,s11,a5
                        memmove(&v_send_data, tx_buff + i, 2);
    8002718e:	02049593          	slli	a1,s1,0x20
    80027192:	9181                	srli	a1,a1,0x20
    80027194:	865a                	mv	a2,s6
    80027196:	95ce                	add	a1,a1,s3
    80027198:	f8c40513          	addi	a0,s0,-116
    8002719c:	ffff9097          	auipc	ra,0xffff9
    800271a0:	62c080e7          	jalr	1580(ra) # 800207c8 <memmove>
                        spi_handle->dr[0] = v_send_data;
    800271a4:	f8c42783          	lw	a5,-116(s0)
    800271a8:	06f92023          	sw	a5,96(s2)
                        i += 2;
    800271ac:	2489                	addiw	s1,s1,2
                    for(index = 0; index < fifo_len; index += 2)
    800271ae:	fe9d90e3          	bne	s11,s1,8002718e <spi_send_data_normal+0x194>
                        i += 2;
    800271b2:	84ee                	mv	s1,s11
    800271b4:	b781                	j	800270f4 <spi_send_data_normal+0xfa>
    }
    while((spi_handle->sr & 0x05) != 0x04)
    800271b6:	4711                	li	a4,4
    800271b8:	02892783          	lw	a5,40(s2)
    800271bc:	8b95                	andi	a5,a5,5
    800271be:	fee79de3          	bne	a5,a4,800271b8 <spi_send_data_normal+0x1be>
        ;
    spi_handle->ser = 0x00;
    800271c2:	00092823          	sw	zero,16(s2)
    spi_handle->ssienr = 0x00;
    800271c6:	00092423          	sw	zero,8(s2)
}
    800271ca:	70e6                	ld	ra,120(sp)
    800271cc:	7446                	ld	s0,112(sp)
    800271ce:	74a6                	ld	s1,104(sp)
    800271d0:	7906                	ld	s2,96(sp)
    800271d2:	69e6                	ld	s3,88(sp)
    800271d4:	6a46                	ld	s4,80(sp)
    800271d6:	6aa6                	ld	s5,72(sp)
    800271d8:	6b06                	ld	s6,64(sp)
    800271da:	7be2                	ld	s7,56(sp)
    800271dc:	7c42                	ld	s8,48(sp)
    800271de:	7ca2                	ld	s9,40(sp)
    800271e0:	7d02                	ld	s10,32(sp)
    800271e2:	6de2                	ld	s11,24(sp)
    800271e4:	6109                	addi	sp,sp,128
    800271e6:	8082                	ret

00000000800271e8 <spi_send_data_standard>:

void spi_send_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                            uint64 cmd_len, const uint8 *tx_buff, uint64 tx_len)
{
    800271e8:	715d                	addi	sp,sp,-80
    800271ea:	e486                	sd	ra,72(sp)
    800271ec:	e0a2                	sd	s0,64(sp)
    800271ee:	fc26                	sd	s1,56(sp)
    800271f0:	f84a                	sd	s2,48(sp)
    800271f2:	f44e                	sd	s3,40(sp)
    800271f4:	f052                	sd	s4,32(sp)
    800271f6:	ec56                	sd	s5,24(sp)
    800271f8:	e85a                	sd	s6,16(sp)
    800271fa:	e45e                	sd	s7,8(sp)
    800271fc:	0880                	addi	s0,sp,80
    800271fe:	8a2a                	mv	s4,a0
    80027200:	8aae                	mv	s5,a1
    80027202:	8bb2                	mv	s7,a2
    80027204:	8936                	mv	s2,a3
    80027206:	8b3a                	mv	s6,a4
    80027208:	89be                	mv	s3,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    // uint8 *v_buf = malloc(cmd_len + tx_len);
    uint8 *v_buf = kalloc();
    8002720a:	ffff9097          	auipc	ra,0xffff9
    8002720e:	348080e7          	jalr	840(ra) # 80020552 <kalloc>
    80027212:	84aa                	mv	s1,a0
    uint64 i;
    for(i = 0; i < cmd_len; i++)
    80027214:	00090e63          	beqz	s2,80027230 <spi_send_data_standard+0x48>
    80027218:	87de                	mv	a5,s7
    8002721a:	872a                	mv	a4,a0
    8002721c:	012b8633          	add	a2,s7,s2
        v_buf[i] = cmd_buff[i];
    80027220:	0007c683          	lbu	a3,0(a5)
    80027224:	00d70023          	sb	a3,0(a4)
    80027228:	0785                	addi	a5,a5,1
    8002722a:	0705                	addi	a4,a4,1
    for(i = 0; i < cmd_len; i++)
    8002722c:	fec79ae3          	bne	a5,a2,80027220 <spi_send_data_standard+0x38>
    for(i = 0; i < tx_len; i++)
    80027230:	00098f63          	beqz	s3,8002724e <spi_send_data_standard+0x66>
    80027234:	87da                	mv	a5,s6
    80027236:	012486b3          	add	a3,s1,s2
    8002723a:	013b0733          	add	a4,s6,s3
        v_buf[cmd_len + i] = tx_buff[i];
    8002723e:	0007c603          	lbu	a2,0(a5)
    80027242:	00c68023          	sb	a2,0(a3)
    80027246:	0785                	addi	a5,a5,1
    80027248:	0685                	addi	a3,a3,1
    for(i = 0; i < tx_len; i++)
    8002724a:	fee79ae3          	bne	a5,a4,8002723e <spi_send_data_standard+0x56>

    spi_send_data_normal(spi_num, chip_select, v_buf, cmd_len + tx_len);
    8002724e:	013906b3          	add	a3,s2,s3
    80027252:	8626                	mv	a2,s1
    80027254:	85d6                	mv	a1,s5
    80027256:	8552                	mv	a0,s4
    80027258:	00000097          	auipc	ra,0x0
    8002725c:	da2080e7          	jalr	-606(ra) # 80026ffa <spi_send_data_normal>
    // free((void *)v_buf);
    kfree((void *)v_buf);
    80027260:	8526                	mv	a0,s1
    80027262:	ffff9097          	auipc	ra,0xffff9
    80027266:	1d6080e7          	jalr	470(ra) # 80020438 <kfree>
}
    8002726a:	60a6                	ld	ra,72(sp)
    8002726c:	6406                	ld	s0,64(sp)
    8002726e:	74e2                	ld	s1,56(sp)
    80027270:	7942                	ld	s2,48(sp)
    80027272:	79a2                	ld	s3,40(sp)
    80027274:	7a02                	ld	s4,32(sp)
    80027276:	6ae2                	ld	s5,24(sp)
    80027278:	6b42                	ld	s6,16(sp)
    8002727a:	6ba2                	ld	s7,8(sp)
    8002727c:	6161                	addi	sp,sp,80
    8002727e:	8082                	ret

0000000080027280 <spi_receive_data_standard>:

void spi_receive_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                               uint64 cmd_len, uint8 *rx_buff, uint64 rx_len)
{
    80027280:	7139                	addi	sp,sp,-64
    80027282:	fc06                	sd	ra,56(sp)
    80027284:	f822                	sd	s0,48(sp)
    80027286:	f426                	sd	s1,40(sp)
    80027288:	f04a                	sd	s2,32(sp)
    8002728a:	ec4e                	sd	s3,24(sp)
    8002728c:	e852                	sd	s4,16(sp)
    8002728e:	e456                	sd	s5,8(sp)
    80027290:	e05a                	sd	s6,0(sp)
    80027292:	0080                	addi	s0,sp,64
    80027294:	89aa                	mv	s3,a0
    80027296:	8aae                	mv	s5,a1
    80027298:	8932                	mv	s2,a2
    8002729a:	8a36                	mv	s4,a3
    8002729c:	84ba                	mv	s1,a4
    8002729e:	8b3e                	mv	s6,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    uint64 index, fifo_len;
    if(cmd_len == 0)
    800272a0:	eab5                	bnez	a3,80027314 <spi_receive_data_standard+0x94>
        spi_set_tmod(spi_num, SPI_TMOD_RECV);
    800272a2:	4589                	li	a1,2
    800272a4:	0ff57513          	andi	a0,a0,255
    800272a8:	00000097          	auipc	ra,0x0
    800272ac:	c92080e7          	jalr	-878(ra) # 80026f3a <spi_set_tmod>
    else
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    volatile spi_t *spi_handle = spi[spi_num];
    800272b0:	02099793          	slli	a5,s3,0x20
    800272b4:	9381                	srli	a5,a5,0x20
    800272b6:	00379713          	slli	a4,a5,0x3
    800272ba:	00005797          	auipc	a5,0x5
    800272be:	23678793          	addi	a5,a5,566 # 8002c4f0 <spi>
    800272c2:	97ba                	add	a5,a5,a4
    800272c4:	6398                	ld	a4,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    800272c6:	0029b993          	sltiu	s3,s3,2
    800272ca:	0992                	slli	s3,s3,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    800272cc:	431c                	lw	a5,0(a4)
    800272ce:	0137d9bb          	srlw	s3,a5,s3
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    800272d2:	01f9f993          	andi	s3,s3,31
    if(data_bit_length < 8)
    800272d6:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    800272d8:	4605                	li	a2,1
    if(data_bit_length < 8)
    800272da:	0137f663          	bgeu	a5,s3,800272e6 <spi_receive_data_standard+0x66>
    else if(data_bit_length < 16)
    800272de:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    800272e0:	4611                	li	a2,4
    else if(data_bit_length < 16)
    800272e2:	0537f163          	bgeu	a5,s3,80027324 <spi_receive_data_standard+0xa4>

    uint32 i = 0;
    uint64 v_cmd_len = cmd_len / frame_width;
    800272e6:	02061793          	slli	a5,a2,0x20
    800272ea:	9381                	srli	a5,a5,0x20
    800272ec:	02fa58b3          	divu	a7,s4,a5
    uint32 v_rx_len = rx_len / frame_width;
    800272f0:	02fb56b3          	divu	a3,s6,a5
    800272f4:	2681                	sext.w	a3,a3

    spi_handle->ctrlr1 = (uint32)(v_rx_len - 1);
    800272f6:	fff6859b          	addiw	a1,a3,-1
    800272fa:	c34c                	sw	a1,4(a4)
    spi_handle->ssienr = 0x01;
    800272fc:	4585                	li	a1,1
    800272fe:	c70c                	sw	a1,8(a4)

    while(v_cmd_len)
    80027300:	0cfa6163          	bltu	s4,a5,800273c2 <spi_receive_data_standard+0x142>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = cmd_buff[i++];
                break;
        }
        spi_handle->ser = 1U << chip_select;
    80027304:	015595bb          	sllw	a1,a1,s5
    uint32 i = 0;
    80027308:	4301                	li	t1,0
        fifo_len = 32 - spi_handle->txflr;
    8002730a:	02000f13          	li	t5,32
        switch(frame_width)
    8002730e:	4e89                	li	t4,2
    80027310:	4e11                	li	t3,4
    80027312:	a0a1                	j	8002735a <spi_receive_data_standard+0xda>
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    80027314:	458d                	li	a1,3
    80027316:	0ff57513          	andi	a0,a0,255
    8002731a:	00000097          	auipc	ra,0x0
    8002731e:	c20080e7          	jalr	-992(ra) # 80026f3a <spi_set_tmod>
    80027322:	b779                	j	800272b0 <spi_receive_data_standard+0x30>
        return SPI_TRANS_SHORT;
    80027324:	4609                	li	a2,2
    80027326:	b7c1                	j	800272e6 <spi_receive_data_standard+0x66>
    80027328:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    8002732c:	879a                	mv	a5,t1
    8002732e:	c10d                	beqz	a0,80027350 <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = ((uint16 *)cmd_buff)[i++];
    80027330:	0017881b          	addiw	a6,a5,1
    80027334:	00080f9b          	sext.w	t6,a6
    80027338:	1782                	slli	a5,a5,0x20
    8002733a:	9381                	srli	a5,a5,0x20
    8002733c:	0786                	slli	a5,a5,0x1
    8002733e:	97ca                	add	a5,a5,s2
    80027340:	0007d783          	lhu	a5,0(a5)
    80027344:	d33c                	sw	a5,96(a4)
    80027346:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    80027348:	fff294e3          	bne	t0,t6,80027330 <spi_receive_data_standard+0xb0>
    8002734c:	00a3033b          	addw	t1,t1,a0
        spi_handle->ser = 1U << chip_select;
    80027350:	cb0c                	sw	a1,16(a4)
        v_cmd_len -= fifo_len;
    80027352:	40a888b3          	sub	a7,a7,a0
    while(v_cmd_len)
    80027356:	06088e63          	beqz	a7,800273d2 <spi_receive_data_standard+0x152>
        fifo_len = 32 - spi_handle->txflr;
    8002735a:	5308                	lw	a0,32(a4)
    8002735c:	40af053b          	subw	a0,t5,a0
    80027360:	1502                	slli	a0,a0,0x20
    80027362:	9101                	srli	a0,a0,0x20
        fifo_len = fifo_len < v_cmd_len ? fifo_len : v_cmd_len;
    80027364:	00a8f363          	bgeu	a7,a0,8002736a <spi_receive_data_standard+0xea>
    80027368:	8546                	mv	a0,a7
        switch(frame_width)
    8002736a:	fbd60fe3          	beq	a2,t4,80027328 <spi_receive_data_standard+0xa8>
    8002736e:	03c61663          	bne	a2,t3,8002739a <spi_receive_data_standard+0x11a>
    80027372:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    80027376:	879a                	mv	a5,t1
    80027378:	dd61                	beqz	a0,80027350 <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = ((uint32 *)cmd_buff)[i++];
    8002737a:	0017881b          	addiw	a6,a5,1
    8002737e:	00080f9b          	sext.w	t6,a6
    80027382:	1782                	slli	a5,a5,0x20
    80027384:	9381                	srli	a5,a5,0x20
    80027386:	078a                	slli	a5,a5,0x2
    80027388:	97ca                	add	a5,a5,s2
    8002738a:	439c                	lw	a5,0(a5)
    8002738c:	d33c                	sw	a5,96(a4)
    8002738e:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    80027390:	fff295e3          	bne	t0,t6,8002737a <spi_receive_data_standard+0xfa>
    80027394:	00a3033b          	addw	t1,t1,a0
    80027398:	bf65                	j	80027350 <spi_receive_data_standard+0xd0>
    8002739a:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    8002739e:	879a                	mv	a5,t1
    800273a0:	d945                	beqz	a0,80027350 <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = cmd_buff[i++];
    800273a2:	0017881b          	addiw	a6,a5,1
    800273a6:	00080f9b          	sext.w	t6,a6
    800273aa:	1782                	slli	a5,a5,0x20
    800273ac:	9381                	srli	a5,a5,0x20
    800273ae:	97ca                	add	a5,a5,s2
    800273b0:	0007c783          	lbu	a5,0(a5)
    800273b4:	d33c                	sw	a5,96(a4)
    800273b6:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    800273b8:	fff295e3          	bne	t0,t6,800273a2 <spi_receive_data_standard+0x122>
    800273bc:	00a3033b          	addw	t1,t1,a0
    800273c0:	bf41                	j	80027350 <spi_receive_data_standard+0xd0>
    }

    if(cmd_len == 0)
    800273c2:	000a1863          	bnez	s4,800273d2 <spi_receive_data_standard+0x152>
    {
        spi_handle->dr[0] = 0xffffffff;
    800273c6:	57fd                	li	a5,-1
    800273c8:	d33c                	sw	a5,96(a4)
        spi_handle->ser = 1U << chip_select;
    800273ca:	4585                	li	a1,1
    800273cc:	015595bb          	sllw	a1,a1,s5
    800273d0:	cb0c                	sw	a1,16(a4)
    }

    i = 0;
    while(v_rx_len)
    800273d2:	c6c5                	beqz	a3,8002747a <spi_receive_data_standard+0x1fa>
    800273d4:	4301                	li	t1,0
    {
        fifo_len = spi_handle->rxflr;
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
        switch(frame_width)
    800273d6:	4e89                	li	t4,2
    800273d8:	4e11                	li	t3,4
    800273da:	a805                	j	8002740a <spi_receive_data_standard+0x18a>
    800273dc:	00650f3b          	addw	t5,a0,t1
            case SPI_TRANS_INT:
                for(index = 0; index < fifo_len; index++)
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
                break;
            case SPI_TRANS_SHORT:
                for(index = 0; index < fifo_len; index++)
    800273e0:	879a                	mv	a5,t1
    800273e2:	c115                	beqz	a0,80027406 <spi_receive_data_standard+0x186>
                    ((uint16 *)rx_buff)[i++] = (uint16)spi_handle->dr[0];
    800273e4:	06072883          	lw	a7,96(a4)
    800273e8:	0017859b          	addiw	a1,a5,1
    800273ec:	0005881b          	sext.w	a6,a1
    800273f0:	1782                	slli	a5,a5,0x20
    800273f2:	9381                	srli	a5,a5,0x20
    800273f4:	0786                	slli	a5,a5,0x1
    800273f6:	97a6                	add	a5,a5,s1
    800273f8:	01179023          	sh	a7,0(a5)
    800273fc:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    800273fe:	ff0f13e3          	bne	t5,a6,800273e4 <spi_receive_data_standard+0x164>
    80027402:	00a3033b          	addw	t1,t1,a0
                for(index = 0; index < fifo_len; index++)
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
                break;
        }

        v_rx_len -= fifo_len;
    80027406:	9e89                	subw	a3,a3,a0
    while(v_rx_len)
    80027408:	caad                	beqz	a3,8002747a <spi_receive_data_standard+0x1fa>
        fifo_len = spi_handle->rxflr;
    8002740a:	535c                	lw	a5,36(a4)
    8002740c:	1782                	slli	a5,a5,0x20
    8002740e:	9381                	srli	a5,a5,0x20
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
    80027410:	02069513          	slli	a0,a3,0x20
    80027414:	9101                	srli	a0,a0,0x20
    80027416:	00a7f363          	bgeu	a5,a0,8002741c <spi_receive_data_standard+0x19c>
    8002741a:	853e                	mv	a0,a5
        switch(frame_width)
    8002741c:	fdd600e3          	beq	a2,t4,800273dc <spi_receive_data_standard+0x15c>
    80027420:	03c61863          	bne	a2,t3,80027450 <spi_receive_data_standard+0x1d0>
    80027424:	00650f3b          	addw	t5,a0,t1
                for(index = 0; index < fifo_len; index++)
    80027428:	879a                	mv	a5,t1
    8002742a:	dd71                	beqz	a0,80027406 <spi_receive_data_standard+0x186>
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
    8002742c:	0017859b          	addiw	a1,a5,1
    80027430:	0005881b          	sext.w	a6,a1
    80027434:	06072883          	lw	a7,96(a4)
    80027438:	1782                	slli	a5,a5,0x20
    8002743a:	9381                	srli	a5,a5,0x20
    8002743c:	078a                	slli	a5,a5,0x2
    8002743e:	97a6                	add	a5,a5,s1
    80027440:	0117a023          	sw	a7,0(a5)
    80027444:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    80027446:	ff0f13e3          	bne	t5,a6,8002742c <spi_receive_data_standard+0x1ac>
    8002744a:	00a3033b          	addw	t1,t1,a0
    8002744e:	bf65                	j	80027406 <spi_receive_data_standard+0x186>
    80027450:	00650f3b          	addw	t5,a0,t1
                for(index = 0; index < fifo_len; index++)
    80027454:	879a                	mv	a5,t1
    80027456:	d945                	beqz	a0,80027406 <spi_receive_data_standard+0x186>
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
    80027458:	06072883          	lw	a7,96(a4)
    8002745c:	0017859b          	addiw	a1,a5,1
    80027460:	0005881b          	sext.w	a6,a1
    80027464:	1782                	slli	a5,a5,0x20
    80027466:	9381                	srli	a5,a5,0x20
    80027468:	97a6                	add	a5,a5,s1
    8002746a:	01178023          	sb	a7,0(a5)
    8002746e:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    80027470:	ff0f14e3          	bne	t5,a6,80027458 <spi_receive_data_standard+0x1d8>
    80027474:	00a3033b          	addw	t1,t1,a0
    80027478:	b779                	j	80027406 <spi_receive_data_standard+0x186>
    }

    spi_handle->ser = 0x00;
    8002747a:	00072823          	sw	zero,16(a4)
    spi_handle->ssienr = 0x00;
    8002747e:	00072423          	sw	zero,8(a4)
}
    80027482:	70e2                	ld	ra,56(sp)
    80027484:	7442                	ld	s0,48(sp)
    80027486:	74a2                	ld	s1,40(sp)
    80027488:	7902                	ld	s2,32(sp)
    8002748a:	69e2                	ld	s3,24(sp)
    8002748c:	6a42                	ld	s4,16(sp)
    8002748e:	6aa2                	ld	s5,8(sp)
    80027490:	6b02                	ld	s6,0(sp)
    80027492:	6121                	addi	sp,sp,64
    80027494:	8082                	ret

0000000080027496 <spi_receive_data_normal_dma>:

void spi_receive_data_normal_dma(dmac_channel_number_t dma_send_channel_num,
                                 dmac_channel_number_t dma_receive_channel_num,
                                 spi_device_num_t spi_num, spi_chip_select_t chip_select, const void *cmd_buff,
                                 uint64 cmd_len, void *rx_buff, uint64 rx_len)
{
    80027496:	711d                	addi	sp,sp,-96
    80027498:	ec86                	sd	ra,88(sp)
    8002749a:	e8a2                	sd	s0,80(sp)
    8002749c:	e4a6                	sd	s1,72(sp)
    8002749e:	e0ca                	sd	s2,64(sp)
    800274a0:	fc4e                	sd	s3,56(sp)
    800274a2:	f852                	sd	s4,48(sp)
    800274a4:	f456                	sd	s5,40(sp)
    800274a6:	f05a                	sd	s6,32(sp)
    800274a8:	ec5e                	sd	s7,24(sp)
    800274aa:	e862                	sd	s8,16(sp)
    800274ac:	e466                	sd	s9,8(sp)
    800274ae:	1080                	addi	s0,sp,96
    800274b0:	89ae                	mv	s3,a1
    800274b2:	8932                	mv	s2,a2
    800274b4:	8b36                	mv	s6,a3
    800274b6:	8ac2                	mv	s5,a6
    800274b8:	8a46                	mv	s4,a7
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    if(cmd_len == 0)
    800274ba:	e7c1                	bnez	a5,80027542 <spi_receive_data_normal_dma+0xac>
        spi_set_tmod(spi_num, SPI_TMOD_RECV);
    800274bc:	4589                	li	a1,2
    800274be:	0ff67513          	andi	a0,a2,255
    800274c2:	00000097          	auipc	ra,0x0
    800274c6:	a78080e7          	jalr	-1416(ra) # 80026f3a <spi_set_tmod>
    else
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);

    volatile spi_t *spi_handle = spi[spi_num];
    800274ca:	02091793          	slli	a5,s2,0x20
    800274ce:	9381                	srli	a5,a5,0x20
    800274d0:	00379713          	slli	a4,a5,0x3
    800274d4:	00005797          	auipc	a5,0x5
    800274d8:	01c78793          	addi	a5,a5,28 # 8002c4f0 <spi>
    800274dc:	97ba                	add	a5,a5,a4
    800274de:	6384                	ld	s1,0(a5)

    spi_handle->ctrlr1 = (uint32)(rx_len - 1);
    800274e0:	fffa079b          	addiw	a5,s4,-1
    800274e4:	c0dc                	sw	a5,4(s1)
    spi_handle->dmacr = 0x3;
    800274e6:	478d                	li	a5,3
    800274e8:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    800274ea:	4b85                	li	s7,1
    800274ec:	0174a423          	sw	s7,8(s1)
    if(cmd_len)
        sysctl_dma_select((sysctl_dma_channel_t)dma_send_channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    sysctl_dma_select((sysctl_dma_channel_t)dma_receive_channel_num, SYSCTL_DMA_SELECT_SSI0_RX_REQ + spi_num * 2);
    800274f0:	0019159b          	slliw	a1,s2,0x1
    800274f4:	854e                	mv	a0,s3
    800274f6:	00002097          	auipc	ra,0x2
    800274fa:	be4080e7          	jalr	-1052(ra) # 800290da <sysctl_dma_select>

    dmac_set_single_mode(dma_receive_channel_num, (void *)(&spi_handle->dr[0]), rx_buff, DMAC_ADDR_NOCHANGE, DMAC_ADDR_INCREMENT,
    800274fe:	88d2                	mv	a7,s4
    80027500:	4809                	li	a6,2
    80027502:	4781                	li	a5,0
    80027504:	4701                	li	a4,0
    80027506:	4685                	li	a3,1
    80027508:	8656                	mv	a2,s5
    8002750a:	06048593          	addi	a1,s1,96
    8002750e:	854e                	mv	a0,s3
    80027510:	00001097          	auipc	ra,0x1
    80027514:	6aa080e7          	jalr	1706(ra) # 80028bba <dmac_set_single_mode>
            frf_offset = 21;
    80027518:	47d5                	li	a5,21
    switch(spi_num)
    8002751a:	012bf763          	bgeu	s7,s2,80027528 <spi_receive_data_normal_dma+0x92>
    8002751e:	4709                	li	a4,2
    uint8 frf_offset = 0;
    80027520:	4781                	li	a5,0
    switch(spi_num)
    80027522:	00e90363          	beq	s2,a4,80027528 <spi_receive_data_normal_dma+0x92>
            frf_offset = 22;
    80027526:	47d9                	li	a5,22
    return ((spi_adapter->ctrlr0 >> frf_offset) & 0x3);
    80027528:	4098                	lw	a4,0(s1)
    8002752a:	00f757bb          	srlw	a5,a4,a5
                         DMAC_MSIZE_1, DMAC_TRANS_WIDTH_32, rx_len);
    if(cmd_len)
        dmac_set_single_mode(dma_send_channel_num, cmd_buff, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
                             DMAC_MSIZE_4, DMAC_TRANS_WIDTH_32, cmd_len);
    if(cmd_len == 0 && spi_get_frame_format(spi_num) == SPI_FF_STANDARD)
    8002752e:	8b8d                	andi	a5,a5,3
    80027530:	e399                	bnez	a5,80027536 <spi_receive_data_normal_dma+0xa0>
        spi[spi_num]->dr[0] = 0xffffffff;
    80027532:	57fd                	li	a5,-1
    80027534:	d0bc                	sw	a5,96(s1)
    spi_handle->ser = 1U << chip_select;
    80027536:	4785                	li	a5,1
    80027538:	01679b3b          	sllw	s6,a5,s6
    8002753c:	0164a823          	sw	s6,16(s1)
    if(cmd_len)
    80027540:	a04d                	j	800275e2 <spi_receive_data_normal_dma+0x14c>
    80027542:	8baa                	mv	s7,a0
    80027544:	8cba                	mv	s9,a4
    80027546:	8c3e                	mv	s8,a5
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    80027548:	458d                	li	a1,3
    8002754a:	0ff67513          	andi	a0,a2,255
    8002754e:	00000097          	auipc	ra,0x0
    80027552:	9ec080e7          	jalr	-1556(ra) # 80026f3a <spi_set_tmod>
    volatile spi_t *spi_handle = spi[spi_num];
    80027556:	02091793          	slli	a5,s2,0x20
    8002755a:	9381                	srli	a5,a5,0x20
    8002755c:	00379713          	slli	a4,a5,0x3
    80027560:	00005797          	auipc	a5,0x5
    80027564:	f9078793          	addi	a5,a5,-112 # 8002c4f0 <spi>
    80027568:	97ba                	add	a5,a5,a4
    8002756a:	6384                	ld	s1,0(a5)
    spi_handle->ctrlr1 = (uint32)(rx_len - 1);
    8002756c:	fffa079b          	addiw	a5,s4,-1
    80027570:	c0dc                	sw	a5,4(s1)
    spi_handle->dmacr = 0x3;
    80027572:	478d                	li	a5,3
    80027574:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    80027576:	4785                	li	a5,1
    80027578:	c49c                	sw	a5,8(s1)
        sysctl_dma_select((sysctl_dma_channel_t)dma_send_channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    8002757a:	0019159b          	slliw	a1,s2,0x1
    8002757e:	0005891b          	sext.w	s2,a1
    80027582:	2585                	addiw	a1,a1,1
    80027584:	855e                	mv	a0,s7
    80027586:	00002097          	auipc	ra,0x2
    8002758a:	b54080e7          	jalr	-1196(ra) # 800290da <sysctl_dma_select>
    sysctl_dma_select((sysctl_dma_channel_t)dma_receive_channel_num, SYSCTL_DMA_SELECT_SSI0_RX_REQ + spi_num * 2);
    8002758e:	85ca                	mv	a1,s2
    80027590:	854e                	mv	a0,s3
    80027592:	00002097          	auipc	ra,0x2
    80027596:	b48080e7          	jalr	-1208(ra) # 800290da <sysctl_dma_select>
    dmac_set_single_mode(dma_receive_channel_num, (void *)(&spi_handle->dr[0]), rx_buff, DMAC_ADDR_NOCHANGE, DMAC_ADDR_INCREMENT,
    8002759a:	06048913          	addi	s2,s1,96
    8002759e:	88d2                	mv	a7,s4
    800275a0:	4809                	li	a6,2
    800275a2:	4781                	li	a5,0
    800275a4:	4701                	li	a4,0
    800275a6:	4685                	li	a3,1
    800275a8:	8656                	mv	a2,s5
    800275aa:	85ca                	mv	a1,s2
    800275ac:	854e                	mv	a0,s3
    800275ae:	00001097          	auipc	ra,0x1
    800275b2:	60c080e7          	jalr	1548(ra) # 80028bba <dmac_set_single_mode>
        dmac_set_single_mode(dma_send_channel_num, cmd_buff, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    800275b6:	88e2                	mv	a7,s8
    800275b8:	4809                	li	a6,2
    800275ba:	4785                	li	a5,1
    800275bc:	4705                	li	a4,1
    800275be:	4681                	li	a3,0
    800275c0:	864a                	mv	a2,s2
    800275c2:	85e6                	mv	a1,s9
    800275c4:	855e                	mv	a0,s7
    800275c6:	00001097          	auipc	ra,0x1
    800275ca:	5f4080e7          	jalr	1524(ra) # 80028bba <dmac_set_single_mode>
    spi_handle->ser = 1U << chip_select;
    800275ce:	4785                	li	a5,1
    800275d0:	01679b3b          	sllw	s6,a5,s6
    800275d4:	0164a823          	sw	s6,16(s1)
        dmac_wait_done(dma_send_channel_num);
    800275d8:	855e                	mv	a0,s7
    800275da:	00001097          	auipc	ra,0x1
    800275de:	68c080e7          	jalr	1676(ra) # 80028c66 <dmac_wait_done>
    dmac_wait_done(dma_receive_channel_num);
    800275e2:	854e                	mv	a0,s3
    800275e4:	00001097          	auipc	ra,0x1
    800275e8:	682080e7          	jalr	1666(ra) # 80028c66 <dmac_wait_done>

    spi_handle->ser = 0x00;
    800275ec:	0004a823          	sw	zero,16(s1)
    spi_handle->ssienr = 0x00;
    800275f0:	0004a423          	sw	zero,8(s1)
}
    800275f4:	60e6                	ld	ra,88(sp)
    800275f6:	6446                	ld	s0,80(sp)
    800275f8:	64a6                	ld	s1,72(sp)
    800275fa:	6906                	ld	s2,64(sp)
    800275fc:	79e2                	ld	s3,56(sp)
    800275fe:	7a42                	ld	s4,48(sp)
    80027600:	7aa2                	ld	s5,40(sp)
    80027602:	7b02                	ld	s6,32(sp)
    80027604:	6be2                	ld	s7,24(sp)
    80027606:	6c42                	ld	s8,16(sp)
    80027608:	6ca2                	ld	s9,8(sp)
    8002760a:	6125                	addi	sp,sp,96
    8002760c:	8082                	ret

000000008002760e <spi_send_data_normal_dma>:

void spi_send_data_normal_dma(dmac_channel_number_t channel_num, spi_device_num_t spi_num,
                              spi_chip_select_t chip_select,
                              const void *tx_buff, uint64 tx_len, spi_transfer_width_t spi_transfer_width)
{
    8002760e:	715d                	addi	sp,sp,-80
    80027610:	e486                	sd	ra,72(sp)
    80027612:	e0a2                	sd	s0,64(sp)
    80027614:	fc26                	sd	s1,56(sp)
    80027616:	f84a                	sd	s2,48(sp)
    80027618:	f44e                	sd	s3,40(sp)
    8002761a:	f052                	sd	s4,32(sp)
    8002761c:	ec56                	sd	s5,24(sp)
    8002761e:	e85a                	sd	s6,16(sp)
    80027620:	e45e                	sd	s7,8(sp)
    80027622:	0880                	addi	s0,sp,80
    80027624:	8a2a                	mv	s4,a0
    80027626:	89ae                	mv	s3,a1
    80027628:	8b32                	mv	s6,a2
    8002762a:	8936                	mv	s2,a3
    8002762c:	8aba                	mv	s5,a4
    8002762e:	8bbe                	mv	s7,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    spi_set_tmod(spi_num, SPI_TMOD_TRANS);
    80027630:	4585                	li	a1,1
    80027632:	0ff9f513          	andi	a0,s3,255
    80027636:	00000097          	auipc	ra,0x0
    8002763a:	904080e7          	jalr	-1788(ra) # 80026f3a <spi_set_tmod>
    volatile spi_t *spi_handle = spi[spi_num];
    8002763e:	02099793          	slli	a5,s3,0x20
    80027642:	9381                	srli	a5,a5,0x20
    80027644:	00379713          	slli	a4,a5,0x3
    80027648:	00005797          	auipc	a5,0x5
    8002764c:	ea878793          	addi	a5,a5,-344 # 8002c4f0 <spi>
    80027650:	97ba                	add	a5,a5,a4
    80027652:	6384                	ld	s1,0(a5)
    uint32 *buf;
    int i;
    switch(spi_transfer_width)
    80027654:	4789                	li	a5,2
    80027656:	0afb8263          	beq	s7,a5,800276fa <spi_send_data_normal_dma+0xec>
    8002765a:	4791                	li	a5,4
    8002765c:	02fb8563          	beq	s7,a5,80027686 <spi_send_data_normal_dma+0x78>
        case SPI_TRANS_INT:
            buf = (uint32 *)tx_buff;
            break;
        case SPI_TRANS_CHAR:
        default:
            buf = kalloc();
    80027660:	ffff9097          	auipc	ra,0xffff9
    80027664:	ef2080e7          	jalr	-270(ra) # 80020552 <kalloc>
            for(i = 0; i < tx_len; i++)
    80027668:	100a8563          	beqz	s5,80027772 <spi_send_data_normal_dma+0x164>
    8002766c:	86ca                	mv	a3,s2
    8002766e:	87aa                	mv	a5,a0
    80027670:	002a9613          	slli	a2,s5,0x2
    80027674:	962a                	add	a2,a2,a0
                buf[i] = ((uint8 *)tx_buff)[i];
    80027676:	0006c703          	lbu	a4,0(a3)
    8002767a:	c398                	sw	a4,0(a5)
    8002767c:	0685                	addi	a3,a3,1
    8002767e:	0791                	addi	a5,a5,4
            for(i = 0; i < tx_len; i++)
    80027680:	fec79be3          	bne	a5,a2,80027676 <spi_send_data_normal_dma+0x68>
            buf = kalloc();
    80027684:	892a                	mv	s2,a0
            break;
    }
    spi_handle->dmacr = 0x2; /*enable dma transmit*/
    80027686:	4789                	li	a5,2
    80027688:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    8002768a:	4785                	li	a5,1
    8002768c:	c49c                	sw	a5,8(s1)

    sysctl_dma_select((sysctl_dma_channel_t)channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    8002768e:	0019959b          	slliw	a1,s3,0x1
    80027692:	2585                	addiw	a1,a1,1
    80027694:	8552                	mv	a0,s4
    80027696:	00002097          	auipc	ra,0x2
    8002769a:	a44080e7          	jalr	-1468(ra) # 800290da <sysctl_dma_select>
    dmac_set_single_mode(channel_num, buf, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    8002769e:	88d6                	mv	a7,s5
    800276a0:	4809                	li	a6,2
    800276a2:	4785                	li	a5,1
    800276a4:	4705                	li	a4,1
    800276a6:	4681                	li	a3,0
    800276a8:	06048613          	addi	a2,s1,96
    800276ac:	85ca                	mv	a1,s2
    800276ae:	8552                	mv	a0,s4
    800276b0:	00001097          	auipc	ra,0x1
    800276b4:	50a080e7          	jalr	1290(ra) # 80028bba <dmac_set_single_mode>
                         DMAC_MSIZE_4, DMAC_TRANS_WIDTH_32, tx_len);
    spi_handle->ser = 1U << chip_select;
    800276b8:	4785                	li	a5,1
    800276ba:	01679b3b          	sllw	s6,a5,s6
    800276be:	0164a823          	sw	s6,16(s1)
    dmac_wait_done(channel_num);
    800276c2:	8552                	mv	a0,s4
    800276c4:	00001097          	auipc	ra,0x1
    800276c8:	5a2080e7          	jalr	1442(ra) # 80028c66 <dmac_wait_done>
    if(spi_transfer_width != SPI_TRANS_INT)
    800276cc:	4791                	li	a5,4
    800276ce:	0afb9463          	bne	s7,a5,80027776 <spi_send_data_normal_dma+0x168>
        kfree((void *)buf);

    while((spi_handle->sr & 0x05) != 0x04)
    800276d2:	4711                	li	a4,4
    800276d4:	549c                	lw	a5,40(s1)
    800276d6:	8b95                	andi	a5,a5,5
    800276d8:	fee79ee3          	bne	a5,a4,800276d4 <spi_send_data_normal_dma+0xc6>
        ;
    spi_handle->ser = 0x00;
    800276dc:	0004a823          	sw	zero,16(s1)
    spi_handle->ssienr = 0x00;
    800276e0:	0004a423          	sw	zero,8(s1)
}
    800276e4:	60a6                	ld	ra,72(sp)
    800276e6:	6406                	ld	s0,64(sp)
    800276e8:	74e2                	ld	s1,56(sp)
    800276ea:	7942                	ld	s2,48(sp)
    800276ec:	79a2                	ld	s3,40(sp)
    800276ee:	7a02                	ld	s4,32(sp)
    800276f0:	6ae2                	ld	s5,24(sp)
    800276f2:	6b42                	ld	s6,16(sp)
    800276f4:	6ba2                	ld	s7,8(sp)
    800276f6:	6161                	addi	sp,sp,80
    800276f8:	8082                	ret
            buf = kalloc();
    800276fa:	ffff9097          	auipc	ra,0xffff9
    800276fe:	e58080e7          	jalr	-424(ra) # 80020552 <kalloc>
    80027702:	8baa                	mv	s7,a0
            for(i = 0; i < tx_len; i++)
    80027704:	000a8e63          	beqz	s5,80027720 <spi_send_data_normal_dma+0x112>
    80027708:	87ca                	mv	a5,s2
    8002770a:	872a                	mv	a4,a0
    8002770c:	001a9693          	slli	a3,s5,0x1
    80027710:	96ca                	add	a3,a3,s2
                buf[i] = ((uint16 *)tx_buff)[i];
    80027712:	0007d603          	lhu	a2,0(a5)
    80027716:	c310                	sw	a2,0(a4)
    80027718:	0789                	addi	a5,a5,2
    8002771a:	0711                	addi	a4,a4,4
            for(i = 0; i < tx_len; i++)
    8002771c:	fed79be3          	bne	a5,a3,80027712 <spi_send_data_normal_dma+0x104>
    spi_handle->dmacr = 0x2; /*enable dma transmit*/
    80027720:	4789                	li	a5,2
    80027722:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    80027724:	4785                	li	a5,1
    80027726:	c49c                	sw	a5,8(s1)
    sysctl_dma_select((sysctl_dma_channel_t)channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    80027728:	0019959b          	slliw	a1,s3,0x1
    8002772c:	2585                	addiw	a1,a1,1
    8002772e:	8552                	mv	a0,s4
    80027730:	00002097          	auipc	ra,0x2
    80027734:	9aa080e7          	jalr	-1622(ra) # 800290da <sysctl_dma_select>
    dmac_set_single_mode(channel_num, buf, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    80027738:	88d6                	mv	a7,s5
    8002773a:	4809                	li	a6,2
    8002773c:	4785                	li	a5,1
    8002773e:	4705                	li	a4,1
    80027740:	4681                	li	a3,0
    80027742:	06048613          	addi	a2,s1,96
    80027746:	85de                	mv	a1,s7
    80027748:	8552                	mv	a0,s4
    8002774a:	00001097          	auipc	ra,0x1
    8002774e:	470080e7          	jalr	1136(ra) # 80028bba <dmac_set_single_mode>
    spi_handle->ser = 1U << chip_select;
    80027752:	4785                	li	a5,1
    80027754:	01679b3b          	sllw	s6,a5,s6
    80027758:	0164a823          	sw	s6,16(s1)
    dmac_wait_done(channel_num);
    8002775c:	8552                	mv	a0,s4
    8002775e:	00001097          	auipc	ra,0x1
    80027762:	508080e7          	jalr	1288(ra) # 80028c66 <dmac_wait_done>
        kfree((void *)buf);
    80027766:	855e                	mv	a0,s7
    80027768:	ffff9097          	auipc	ra,0xffff9
    8002776c:	cd0080e7          	jalr	-816(ra) # 80020438 <kfree>
    80027770:	b78d                	j	800276d2 <spi_send_data_normal_dma+0xc4>
            buf = kalloc();
    80027772:	892a                	mv	s2,a0
    80027774:	bf09                	j	80027686 <spi_send_data_normal_dma+0x78>
    80027776:	8bca                	mv	s7,s2
    80027778:	b7fd                	j	80027766 <spi_send_data_normal_dma+0x158>

000000008002777a <spi_receive_data_standard_dma>:

void spi_receive_data_standard_dma(dmac_channel_number_t dma_send_channel_num,
                                   dmac_channel_number_t dma_receive_channel_num,
                                   spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                                   uint64 cmd_len, uint8 *rx_buff, uint64 rx_len)
{
    8002777a:	711d                	addi	sp,sp,-96
    8002777c:	ec86                	sd	ra,88(sp)
    8002777e:	e8a2                	sd	s0,80(sp)
    80027780:	e4a6                	sd	s1,72(sp)
    80027782:	e0ca                	sd	s2,64(sp)
    80027784:	fc4e                	sd	s3,56(sp)
    80027786:	f852                	sd	s4,48(sp)
    80027788:	f456                	sd	s5,40(sp)
    8002778a:	f05a                	sd	s6,32(sp)
    8002778c:	ec5e                	sd	s7,24(sp)
    8002778e:	e862                	sd	s8,16(sp)
    80027790:	e466                	sd	s9,8(sp)
    80027792:	1080                	addi	s0,sp,96
    80027794:	8b2a                	mv	s6,a0
    80027796:	8bae                	mv	s7,a1
    80027798:	8a32                	mv	s4,a2
    8002779a:	8c36                	mv	s8,a3
    8002779c:	8cba                	mv	s9,a4
    8002779e:	893e                	mv	s2,a5
    800277a0:	84c2                	mv	s1,a6
    800277a2:	8ac6                	mv	s5,a7
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    volatile spi_t *spi_handle = spi[spi_num];
    800277a4:	02061793          	slli	a5,a2,0x20
    800277a8:	9381                	srli	a5,a5,0x20
    800277aa:	00379713          	slli	a4,a5,0x3
    800277ae:	00005797          	auipc	a5,0x5
    800277b2:	d4278793          	addi	a5,a5,-702 # 8002c4f0 <spi>
    800277b6:	97ba                	add	a5,a5,a4
    800277b8:	639c                	ld	a5,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    800277ba:	00263713          	sltiu	a4,a2,2
    800277be:	0712                	slli	a4,a4,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    800277c0:	439c                	lw	a5,0(a5)
    800277c2:	00e7d7bb          	srlw	a5,a5,a4
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    800277c6:	8bfd                	andi	a5,a5,31
    if(data_bit_length < 8)
    800277c8:	471d                	li	a4,7
    800277ca:	08f77863          	bgeu	a4,a5,8002785a <spi_receive_data_standard_dma+0xe0>
    else if(data_bit_length < 16)
    800277ce:	473d                	li	a4,15
    800277d0:	0ef77863          	bgeu	a4,a5,800278c0 <spi_receive_data_standard_dma+0x146>
    uint64 v_recv_len;
    uint64 v_cmd_len;
    switch(frame_width)
    {
        case SPI_TRANS_INT:
            write_cmd = kalloc();
    800277d4:	ffff9097          	auipc	ra,0xffff9
    800277d8:	d7e080e7          	jalr	-642(ra) # 80020552 <kalloc>
    800277dc:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 4; i++)
    800277de:	00295793          	srli	a5,s2,0x2
    800277e2:	458d                	li	a1,3
    800277e4:	8766                	mv	a4,s9
    800277e6:	862a                	mv	a2,a0
    800277e8:	4681                	li	a3,0
    800277ea:	0d25f963          	bgeu	a1,s2,800278bc <spi_receive_data_standard_dma+0x142>
                write_cmd[i] = ((uint32 *)cmd_buff)[i];
    800277ee:	430c                	lw	a1,0(a4)
    800277f0:	c20c                	sw	a1,0(a2)
            for(i = 0; i < cmd_len / 4; i++)
    800277f2:	0685                	addi	a3,a3,1
    800277f4:	0711                	addi	a4,a4,4
    800277f6:	0611                	addi	a2,a2,4
    800277f8:	fef6ebe3          	bltu	a3,a5,800277ee <spi_receive_data_standard_dma+0x74>
            read_buf = &write_cmd[i];
    800277fc:	068a                	slli	a3,a3,0x2
    800277fe:	00d98933          	add	s2,s3,a3
            v_recv_len = rx_len / 4;
    80027802:	002adc93          	srli	s9,s5,0x2
            v_recv_len = rx_len;
            v_cmd_len = cmd_len;
            break;
    }

    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    80027806:	88e6                	mv	a7,s9
    80027808:	884a                	mv	a6,s2
    8002780a:	874e                	mv	a4,s3
    8002780c:	86e2                	mv	a3,s8
    8002780e:	8652                	mv	a2,s4
    80027810:	85de                	mv	a1,s7
    80027812:	855a                	mv	a0,s6
    80027814:	00000097          	auipc	ra,0x0
    80027818:	c82080e7          	jalr	-894(ra) # 80027496 <spi_receive_data_normal_dma>

    switch(frame_width)
    {
        case SPI_TRANS_INT:
            for(i = 0; i < v_recv_len; i++)
    8002781c:	470d                	li	a4,3
    8002781e:	884a                	mv	a6,s2
    80027820:	4781                	li	a5,0
    80027822:	01577a63          	bgeu	a4,s5,80027836 <spi_receive_data_standard_dma+0xbc>
                ((uint32 *)rx_buff)[i] = read_buf[i];
    80027826:	00082703          	lw	a4,0(a6)
    8002782a:	c098                	sw	a4,0(s1)
            for(i = 0; i < v_recv_len; i++)
    8002782c:	0785                	addi	a5,a5,1
    8002782e:	0811                	addi	a6,a6,4
    80027830:	0491                	addi	s1,s1,4
    80027832:	ff97eae3          	bltu	a5,s9,80027826 <spi_receive_data_standard_dma+0xac>
            for(i = 0; i < v_recv_len; i++)
                rx_buff[i] = read_buf[i];
            break;
    }

    kfree(write_cmd);
    80027836:	854e                	mv	a0,s3
    80027838:	ffff9097          	auipc	ra,0xffff9
    8002783c:	c00080e7          	jalr	-1024(ra) # 80020438 <kfree>
}
    80027840:	60e6                	ld	ra,88(sp)
    80027842:	6446                	ld	s0,80(sp)
    80027844:	64a6                	ld	s1,72(sp)
    80027846:	6906                	ld	s2,64(sp)
    80027848:	79e2                	ld	s3,56(sp)
    8002784a:	7a42                	ld	s4,48(sp)
    8002784c:	7aa2                	ld	s5,40(sp)
    8002784e:	7b02                	ld	s6,32(sp)
    80027850:	6be2                	ld	s7,24(sp)
    80027852:	6c42                	ld	s8,16(sp)
    80027854:	6ca2                	ld	s9,8(sp)
    80027856:	6125                	addi	sp,sp,96
    80027858:	8082                	ret
            write_cmd = kalloc();
    8002785a:	ffff9097          	auipc	ra,0xffff9
    8002785e:	cf8080e7          	jalr	-776(ra) # 80020552 <kalloc>
    80027862:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len; i++)
    80027864:	04090a63          	beqz	s2,800278b8 <spi_receive_data_standard_dma+0x13e>
    80027868:	8766                	mv	a4,s9
    8002786a:	87ce                	mv	a5,s3
    8002786c:	00291613          	slli	a2,s2,0x2
    80027870:	964e                	add	a2,a2,s3
                write_cmd[i] = cmd_buff[i];
    80027872:	00074683          	lbu	a3,0(a4)
    80027876:	c394                	sw	a3,0(a5)
    80027878:	0705                	addi	a4,a4,1
    8002787a:	0791                	addi	a5,a5,4
            for(i = 0; i < cmd_len; i++)
    8002787c:	fef61be3          	bne	a2,a5,80027872 <spi_receive_data_standard_dma+0xf8>
    80027880:	8cca                	mv	s9,s2
            read_buf = &write_cmd[i];
    80027882:	0c8a                	slli	s9,s9,0x2
    80027884:	9cce                	add	s9,s9,s3
    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    80027886:	88d6                	mv	a7,s5
    80027888:	8866                	mv	a6,s9
    8002788a:	87ca                	mv	a5,s2
    8002788c:	874e                	mv	a4,s3
    8002788e:	86e2                	mv	a3,s8
    80027890:	8652                	mv	a2,s4
    80027892:	85de                	mv	a1,s7
    80027894:	855a                	mv	a0,s6
    80027896:	00000097          	auipc	ra,0x0
    8002789a:	c00080e7          	jalr	-1024(ra) # 80027496 <spi_receive_data_normal_dma>
            for(i = 0; i < v_recv_len; i++)
    8002789e:	f80a8ce3          	beqz	s5,80027836 <spi_receive_data_standard_dma+0xbc>
    800278a2:	87e6                	mv	a5,s9
    800278a4:	0a8a                	slli	s5,s5,0x2
    800278a6:	9ae6                	add	s5,s5,s9
                rx_buff[i] = read_buf[i];
    800278a8:	4398                	lw	a4,0(a5)
    800278aa:	00e48023          	sb	a4,0(s1)
    800278ae:	0791                	addi	a5,a5,4
    800278b0:	0485                	addi	s1,s1,1
            for(i = 0; i < v_recv_len; i++)
    800278b2:	ff579be3          	bne	a5,s5,800278a8 <spi_receive_data_standard_dma+0x12e>
    800278b6:	b741                	j	80027836 <spi_receive_data_standard_dma+0xbc>
            for(i = 0; i < cmd_len; i++)
    800278b8:	8cca                	mv	s9,s2
    800278ba:	b7e1                	j	80027882 <spi_receive_data_standard_dma+0x108>
            for(i = 0; i < cmd_len / 4; i++)
    800278bc:	4781                	li	a5,0
    800278be:	bf3d                	j	800277fc <spi_receive_data_standard_dma+0x82>
            write_cmd = kalloc();
    800278c0:	ffff9097          	auipc	ra,0xffff9
    800278c4:	c92080e7          	jalr	-878(ra) # 80020552 <kalloc>
    800278c8:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 2; i++)
    800278ca:	00195793          	srli	a5,s2,0x1
    800278ce:	4585                	li	a1,1
    800278d0:	8766                	mv	a4,s9
    800278d2:	862a                	mv	a2,a0
    800278d4:	4681                	li	a3,0
    800278d6:	0525f963          	bgeu	a1,s2,80027928 <spi_receive_data_standard_dma+0x1ae>
                write_cmd[i] = ((uint16 *)cmd_buff)[i];
    800278da:	00075583          	lhu	a1,0(a4)
    800278de:	c20c                	sw	a1,0(a2)
            for(i = 0; i < cmd_len / 2; i++)
    800278e0:	0685                	addi	a3,a3,1
    800278e2:	0709                	addi	a4,a4,2
    800278e4:	0611                	addi	a2,a2,4
    800278e6:	fef6eae3          	bltu	a3,a5,800278da <spi_receive_data_standard_dma+0x160>
            read_buf = &write_cmd[i];
    800278ea:	068a                	slli	a3,a3,0x2
    800278ec:	00d98933          	add	s2,s3,a3
            v_recv_len = rx_len / 2;
    800278f0:	001adc93          	srli	s9,s5,0x1
    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    800278f4:	88e6                	mv	a7,s9
    800278f6:	884a                	mv	a6,s2
    800278f8:	874e                	mv	a4,s3
    800278fa:	86e2                	mv	a3,s8
    800278fc:	8652                	mv	a2,s4
    800278fe:	85de                	mv	a1,s7
    80027900:	855a                	mv	a0,s6
    80027902:	00000097          	auipc	ra,0x0
    80027906:	b94080e7          	jalr	-1132(ra) # 80027496 <spi_receive_data_normal_dma>
            for(i = 0; i < v_recv_len; i++)
    8002790a:	4705                	li	a4,1
    8002790c:	884a                	mv	a6,s2
    8002790e:	4781                	li	a5,0
    80027910:	f35773e3          	bgeu	a4,s5,80027836 <spi_receive_data_standard_dma+0xbc>
                ((uint16 *)rx_buff)[i] = read_buf[i];
    80027914:	00082703          	lw	a4,0(a6)
    80027918:	00e49023          	sh	a4,0(s1)
            for(i = 0; i < v_recv_len; i++)
    8002791c:	0785                	addi	a5,a5,1
    8002791e:	0811                	addi	a6,a6,4
    80027920:	0489                	addi	s1,s1,2
    80027922:	ff97e9e3          	bltu	a5,s9,80027914 <spi_receive_data_standard_dma+0x19a>
    80027926:	bf01                	j	80027836 <spi_receive_data_standard_dma+0xbc>
            for(i = 0; i < cmd_len / 2; i++)
    80027928:	4781                	li	a5,0
    8002792a:	b7c1                	j	800278ea <spi_receive_data_standard_dma+0x170>

000000008002792c <spi_send_data_standard_dma>:

void spi_send_data_standard_dma(dmac_channel_number_t channel_num, spi_device_num_t spi_num,
                                spi_chip_select_t chip_select,
                                const uint8 *cmd_buff, uint64 cmd_len, const uint8 *tx_buff, uint64 tx_len)
{
    8002792c:	715d                	addi	sp,sp,-80
    8002792e:	e486                	sd	ra,72(sp)
    80027930:	e0a2                	sd	s0,64(sp)
    80027932:	fc26                	sd	s1,56(sp)
    80027934:	f84a                	sd	s2,48(sp)
    80027936:	f44e                	sd	s3,40(sp)
    80027938:	f052                	sd	s4,32(sp)
    8002793a:	ec56                	sd	s5,24(sp)
    8002793c:	e85a                	sd	s6,16(sp)
    8002793e:	e45e                	sd	s7,8(sp)
    80027940:	e062                	sd	s8,0(sp)
    80027942:	0880                	addi	s0,sp,80
    80027944:	8b2a                	mv	s6,a0
    80027946:	8a2e                	mv	s4,a1
    80027948:	8bb2                	mv	s7,a2
    8002794a:	8c36                	mv	s8,a3
    8002794c:	893a                	mv	s2,a4
    8002794e:	84be                	mv	s1,a5
    80027950:	8ac2                	mv	s5,a6
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    volatile spi_t *spi_handle = spi[spi_num];
    80027952:	02059793          	slli	a5,a1,0x20
    80027956:	9381                	srli	a5,a5,0x20
    80027958:	00379713          	slli	a4,a5,0x3
    8002795c:	00005797          	auipc	a5,0x5
    80027960:	b9478793          	addi	a5,a5,-1132 # 8002c4f0 <spi>
    80027964:	97ba                	add	a5,a5,a4
    80027966:	639c                	ld	a5,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80027968:	0025b713          	sltiu	a4,a1,2
    8002796c:	0712                	slli	a4,a4,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    8002796e:	439c                	lw	a5,0(a5)
    80027970:	00e7d7bb          	srlw	a5,a5,a4
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80027974:	8bfd                	andi	a5,a5,31
    if(data_bit_length < 8)
    80027976:	471d                	li	a4,7
    80027978:	08f77763          	bgeu	a4,a5,80027a06 <spi_send_data_standard_dma+0xda>
    else if(data_bit_length < 16)
    8002797c:	473d                	li	a4,15
    8002797e:	0cf77863          	bgeu	a4,a5,80027a4e <spi_send_data_standard_dma+0x122>
    uint64 v_send_len;
    int i;
    switch(frame_width)
    {
        case SPI_TRANS_INT:
            buf = kalloc();
    80027982:	ffff9097          	auipc	ra,0xffff9
    80027986:	bd0080e7          	jalr	-1072(ra) # 80020552 <kalloc>
    8002798a:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 4; i++)
    8002798c:	00295793          	srli	a5,s2,0x2
    80027990:	458d                	li	a1,3
    80027992:	86e2                	mv	a3,s8
    80027994:	862a                	mv	a2,a0
    80027996:	4701                	li	a4,0
    80027998:	0725f563          	bgeu	a1,s2,80027a02 <spi_send_data_standard_dma+0xd6>
                buf[i] = ((uint32 *)cmd_buff)[i];
    8002799c:	428c                	lw	a1,0(a3)
    8002799e:	c20c                	sw	a1,0(a2)
    800279a0:	0705                	addi	a4,a4,1
    800279a2:	0691                	addi	a3,a3,4
    800279a4:	0611                	addi	a2,a2,4
            for(i = 0; i < cmd_len / 4; i++)
    800279a6:	fef76be3          	bltu	a4,a5,8002799c <spi_send_data_standard_dma+0x70>
            for(i = 0; i < tx_len / 4; i++)
    800279aa:	002ad613          	srli	a2,s5,0x2
    800279ae:	470d                	li	a4,3
    800279b0:	01577c63          	bgeu	a4,s5,800279c8 <spi_send_data_standard_dma+0x9c>
    800279b4:	078a                	slli	a5,a5,0x2
    800279b6:	97ce                	add	a5,a5,s3
    800279b8:	4701                	li	a4,0
                buf[cmd_len / 4 + i] = ((uint32 *)tx_buff)[i];
    800279ba:	4094                	lw	a3,0(s1)
    800279bc:	c394                	sw	a3,0(a5)
    800279be:	0705                	addi	a4,a4,1
    800279c0:	0491                	addi	s1,s1,4
    800279c2:	0791                	addi	a5,a5,4
            for(i = 0; i < tx_len / 4; i++)
    800279c4:	fec76be3          	bltu	a4,a2,800279ba <spi_send_data_standard_dma+0x8e>
            v_send_len = (cmd_len + tx_len) / 4;
    800279c8:	9956                	add	s2,s2,s5
    800279ca:	00295713          	srli	a4,s2,0x2
                buf[cmd_len + i] = tx_buff[i];
            v_send_len = cmd_len + tx_len;
            break;
    }

    spi_send_data_normal_dma(channel_num, spi_num, chip_select, buf, v_send_len, SPI_TRANS_INT);
    800279ce:	4791                	li	a5,4
    800279d0:	86ce                	mv	a3,s3
    800279d2:	865e                	mv	a2,s7
    800279d4:	85d2                	mv	a1,s4
    800279d6:	855a                	mv	a0,s6
    800279d8:	00000097          	auipc	ra,0x0
    800279dc:	c36080e7          	jalr	-970(ra) # 8002760e <spi_send_data_normal_dma>

    kfree((void *)buf);
    800279e0:	854e                	mv	a0,s3
    800279e2:	ffff9097          	auipc	ra,0xffff9
    800279e6:	a56080e7          	jalr	-1450(ra) # 80020438 <kfree>
    800279ea:	60a6                	ld	ra,72(sp)
    800279ec:	6406                	ld	s0,64(sp)
    800279ee:	74e2                	ld	s1,56(sp)
    800279f0:	7942                	ld	s2,48(sp)
    800279f2:	79a2                	ld	s3,40(sp)
    800279f4:	7a02                	ld	s4,32(sp)
    800279f6:	6ae2                	ld	s5,24(sp)
    800279f8:	6b42                	ld	s6,16(sp)
    800279fa:	6ba2                	ld	s7,8(sp)
    800279fc:	6c02                	ld	s8,0(sp)
    800279fe:	6161                	addi	sp,sp,80
    80027a00:	8082                	ret
            for(i = 0; i < cmd_len / 4; i++)
    80027a02:	4781                	li	a5,0
    80027a04:	b75d                	j	800279aa <spi_send_data_standard_dma+0x7e>
            buf = kalloc();
    80027a06:	ffff9097          	auipc	ra,0xffff9
    80027a0a:	b4c080e7          	jalr	-1204(ra) # 80020552 <kalloc>
    80027a0e:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len; i++)
    80027a10:	00090e63          	beqz	s2,80027a2c <spi_send_data_standard_dma+0x100>
    80027a14:	86e2                	mv	a3,s8
    80027a16:	87ce                	mv	a5,s3
    80027a18:	00291613          	slli	a2,s2,0x2
    80027a1c:	964e                	add	a2,a2,s3
                buf[i] = cmd_buff[i];
    80027a1e:	0006c703          	lbu	a4,0(a3)
    80027a22:	c398                	sw	a4,0(a5)
    80027a24:	0685                	addi	a3,a3,1
    80027a26:	0791                	addi	a5,a5,4
            for(i = 0; i < cmd_len; i++)
    80027a28:	fec79be3          	bne	a5,a2,80027a1e <spi_send_data_standard_dma+0xf2>
            for(i = 0; i < tx_len; i++)
    80027a2c:	000a8e63          	beqz	s5,80027a48 <spi_send_data_standard_dma+0x11c>
    80027a30:	87a6                	mv	a5,s1
    80027a32:	00291713          	slli	a4,s2,0x2
    80027a36:	974e                	add	a4,a4,s3
    80027a38:	94d6                	add	s1,s1,s5
                buf[cmd_len + i] = tx_buff[i];
    80027a3a:	0007c683          	lbu	a3,0(a5)
    80027a3e:	c314                	sw	a3,0(a4)
    80027a40:	0785                	addi	a5,a5,1
    80027a42:	0711                	addi	a4,a4,4
            for(i = 0; i < tx_len; i++)
    80027a44:	fe979be3          	bne	a5,s1,80027a3a <spi_send_data_standard_dma+0x10e>
            v_send_len = cmd_len + tx_len;
    80027a48:	01590733          	add	a4,s2,s5
            break;
    80027a4c:	b749                	j	800279ce <spi_send_data_standard_dma+0xa2>
            buf = kalloc();
    80027a4e:	ffff9097          	auipc	ra,0xffff9
    80027a52:	b04080e7          	jalr	-1276(ra) # 80020552 <kalloc>
    80027a56:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 2; i++)
    80027a58:	00195793          	srli	a5,s2,0x1
    80027a5c:	4585                	li	a1,1
    80027a5e:	86e2                	mv	a3,s8
    80027a60:	862a                	mv	a2,a0
    80027a62:	4701                	li	a4,0
    80027a64:	0325fe63          	bgeu	a1,s2,80027aa0 <spi_send_data_standard_dma+0x174>
                buf[i] = ((uint16 *)cmd_buff)[i];
    80027a68:	0006d583          	lhu	a1,0(a3)
    80027a6c:	c20c                	sw	a1,0(a2)
    80027a6e:	0705                	addi	a4,a4,1
    80027a70:	0689                	addi	a3,a3,2
    80027a72:	0611                	addi	a2,a2,4
            for(i = 0; i < cmd_len / 2; i++)
    80027a74:	fef76ae3          	bltu	a4,a5,80027a68 <spi_send_data_standard_dma+0x13c>
            for(i = 0; i < tx_len / 2; i++)
    80027a78:	001ad613          	srli	a2,s5,0x1
    80027a7c:	4705                	li	a4,1
    80027a7e:	01577d63          	bgeu	a4,s5,80027a98 <spi_send_data_standard_dma+0x16c>
    80027a82:	078a                	slli	a5,a5,0x2
    80027a84:	97ce                	add	a5,a5,s3
    80027a86:	4701                	li	a4,0
                buf[cmd_len / 2 + i] = ((uint16 *)tx_buff)[i];
    80027a88:	0004d683          	lhu	a3,0(s1)
    80027a8c:	c394                	sw	a3,0(a5)
    80027a8e:	0705                	addi	a4,a4,1
    80027a90:	0489                	addi	s1,s1,2
    80027a92:	0791                	addi	a5,a5,4
            for(i = 0; i < tx_len / 2; i++)
    80027a94:	fec76ae3          	bltu	a4,a2,80027a88 <spi_send_data_standard_dma+0x15c>
            v_send_len = (cmd_len + tx_len) / 2;
    80027a98:	9956                	add	s2,s2,s5
    80027a9a:	00195713          	srli	a4,s2,0x1
            break;
    80027a9e:	bf05                	j	800279ce <spi_send_data_standard_dma+0xa2>
            for(i = 0; i < cmd_len / 2; i++)
    80027aa0:	4781                	li	a5,0
    80027aa2:	bfd9                	j	80027a78 <spi_send_data_standard_dma+0x14c>

0000000080027aa4 <gpiohs_set_drive_mode>:
// } gpiohs_pin_instance_t;

// static gpiohs_pin_instance_t pin_instance[32];

void gpiohs_set_drive_mode(uint8 pin, gpio_drive_mode_t mode)
{
    80027aa4:	1101                	addi	sp,sp,-32
    80027aa6:	ec06                	sd	ra,24(sp)
    80027aa8:	e822                	sd	s0,16(sp)
    80027aaa:	e426                	sd	s1,8(sp)
    80027aac:	e04a                	sd	s2,0(sp)
    80027aae:	1000                	addi	s0,sp,32
    80027ab0:	892a                	mv	s2,a0
    80027ab2:	84ae                	mv	s1,a1
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    int io_number = fpioa_get_io_by_function(FUNC_GPIOHS0 + pin);
    80027ab4:	0561                	addi	a0,a0,24
    80027ab6:	00000097          	auipc	ra,0x0
    80027aba:	32c080e7          	jalr	812(ra) # 80027de2 <fpioa_get_io_by_function>
    // configASSERT(io_number >= 0);

    fpioa_pull_t pull = FPIOA_PULL_NONE;
    uint32 dir = 0;

    switch(mode)
    80027abe:	4789                	li	a5,2
    80027ac0:	02f48e63          	beq	s1,a5,80027afc <gpiohs_set_drive_mode+0x58>
    80027ac4:	478d                	li	a5,3
    80027ac6:	00f48b63          	beq	s1,a5,80027adc <gpiohs_set_drive_mode+0x38>
    80027aca:	4785                	li	a5,1
    80027acc:	02f48863          	beq	s1,a5,80027afc <gpiohs_set_drive_mode+0x58>
        default:
            // configASSERT(!"GPIO drive mode is not supported.") 
            break;
    }

    fpioa_set_io_pull(io_number, pull);
    80027ad0:	4581                	li	a1,0
    80027ad2:	00000097          	auipc	ra,0x0
    80027ad6:	094080e7          	jalr	148(ra) # 80027b66 <fpioa_set_io_pull>
    volatile uint32 *reg = dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027ada:	a035                	j	80027b06 <gpiohs_set_drive_mode+0x62>
    fpioa_set_io_pull(io_number, pull);
    80027adc:	4585                	li	a1,1
    80027ade:	00000097          	auipc	ra,0x0
    80027ae2:	088080e7          	jalr	136(ra) # 80027b66 <fpioa_set_io_pull>
    80027ae6:	00005797          	auipc	a5,0x5
    80027aea:	20278793          	addi	a5,a5,514 # 8002cce8 <get_select_pll2+0x10>
    80027aee:	6384                	ld	s1,0(a5)
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027af0:	00005797          	auipc	a5,0x5
    80027af4:	1f078793          	addi	a5,a5,496 # 8002cce0 <get_select_pll2+0x8>
    80027af8:	6388                	ld	a0,0(a5)
    80027afa:	a005                	j	80027b1a <gpiohs_set_drive_mode+0x76>
    fpioa_set_io_pull(io_number, pull);
    80027afc:	85a6                	mv	a1,s1
    80027afe:	00000097          	auipc	ra,0x0
    80027b02:	068080e7          	jalr	104(ra) # 80027b66 <fpioa_set_io_pull>
{
    80027b06:	00005797          	auipc	a5,0x5
    80027b0a:	1da78793          	addi	a5,a5,474 # 8002cce0 <get_select_pll2+0x8>
    80027b0e:	6384                	ld	s1,0(a5)
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027b10:	00005797          	auipc	a5,0x5
    80027b14:	1d878793          	addi	a5,a5,472 # 8002cce8 <get_select_pll2+0x10>
    80027b18:	6388                	ld	a0,0(a5)
    set_gpio_bit(reg_d, pin, 0);
    80027b1a:	4601                	li	a2,0
    80027b1c:	85ca                	mv	a1,s2
    80027b1e:	00000097          	auipc	ra,0x0
    80027b22:	398080e7          	jalr	920(ra) # 80027eb6 <set_gpio_bit>
    set_gpio_bit(reg, pin, 1);
    80027b26:	4605                	li	a2,1
    80027b28:	85ca                	mv	a1,s2
    80027b2a:	8526                	mv	a0,s1
    80027b2c:	00000097          	auipc	ra,0x0
    80027b30:	38a080e7          	jalr	906(ra) # 80027eb6 <set_gpio_bit>
}
    80027b34:	60e2                	ld	ra,24(sp)
    80027b36:	6442                	ld	s0,16(sp)
    80027b38:	64a2                	ld	s1,8(sp)
    80027b3a:	6902                	ld	s2,0(sp)
    80027b3c:	6105                	addi	sp,sp,32
    80027b3e:	8082                	ret

0000000080027b40 <gpiohs_set_pin>:
//     // configASSERT(pin < GPIOHS_MAX_PINNO);
//     return get_gpio_bit(gpiohs->input_val.u32, pin);
// }

void gpiohs_set_pin(uint8 pin, gpio_pin_value_t value)
{
    80027b40:	1141                	addi	sp,sp,-16
    80027b42:	e406                	sd	ra,8(sp)
    80027b44:	e022                	sd	s0,0(sp)
    80027b46:	0800                	addi	s0,sp,16
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    set_gpio_bit(gpiohs->output_val.u32, pin, value);
    80027b48:	862e                	mv	a2,a1
    80027b4a:	85aa                	mv	a1,a0
    80027b4c:	00005797          	auipc	a5,0x5
    80027b50:	1a478793          	addi	a5,a5,420 # 8002ccf0 <get_select_pll2+0x18>
    80027b54:	6388                	ld	a0,0(a5)
    80027b56:	00000097          	auipc	ra,0x0
    80027b5a:	360080e7          	jalr	864(ra) # 80027eb6 <set_gpio_bit>
}
    80027b5e:	60a2                	ld	ra,8(sp)
    80027b60:	6402                	ld	s0,0(sp)
    80027b62:	0141                	addi	sp,sp,16
    80027b64:	8082                	ret

0000000080027b66 <fpioa_set_io_pull>:
//     fpioa->io[number] = *cfg;
//     return 0;
// }

int fpioa_set_io_pull(int number, fpioa_pull_t pull)
{
    80027b66:	1141                	addi	sp,sp,-16
    80027b68:	e422                	sd	s0,8(sp)
    80027b6a:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || pull >= FPIOA_PULL_MAX)
    80027b6c:	02f00793          	li	a5,47
    80027b70:	06a7ef63          	bltu	a5,a0,80027bee <fpioa_set_io_pull+0x88>
    80027b74:	862a                	mv	a2,a0
    80027b76:	4789                	li	a5,2
    80027b78:	06b7ed63          	bltu	a5,a1,80027bf2 <fpioa_set_io_pull+0x8c>
        return -1;

    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80027b7c:	003f5737          	lui	a4,0x3f5
    80027b80:	00251793          	slli	a5,a0,0x2
    80027b84:	02b70713          	addi	a4,a4,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027b88:	0742                	slli	a4,a4,0x10
    80027b8a:	97ba                	add	a5,a5,a4
    80027b8c:	439c                	lw	a5,0(a5)
    80027b8e:	0107d69b          	srliw	a3,a5,0x10
    80027b92:	8a85                	andi	a3,a3,1
    80027b94:	0117d71b          	srliw	a4,a5,0x11
    80027b98:	8b05                	andi	a4,a4,1

    switch(pull)
    80027b9a:	4505                	li	a0,1
    80027b9c:	04a58063          	beq	a1,a0,80027bdc <fpioa_set_io_pull+0x76>
    80027ba0:	c1a9                	beqz	a1,80027be2 <fpioa_set_io_pull+0x7c>
    80027ba2:	4509                	li	a0,2
    80027ba4:	04a58263          	beq	a1,a0,80027be8 <fpioa_set_io_pull+0x82>
            break;
        default:
            break;
    }
    /* Atomic write register */
    fpioa->io[number] = cfg;
    80027ba8:	8a85                	andi	a3,a3,1
    80027baa:	0106969b          	slliw	a3,a3,0x10
    80027bae:	75c1                	lui	a1,0xffff0
    80027bb0:	15fd                	addi	a1,a1,-1
    80027bb2:	8fed                	and	a5,a5,a1
    80027bb4:	8fd5                	or	a5,a5,a3
    80027bb6:	8b05                	andi	a4,a4,1
    80027bb8:	0117171b          	slliw	a4,a4,0x11
    80027bbc:	7681                	lui	a3,0xfffe0
    80027bbe:	16fd                	addi	a3,a3,-1
    80027bc0:	8ff5                	and	a5,a5,a3
    80027bc2:	8fd9                	or	a5,a5,a4
    80027bc4:	003f5537          	lui	a0,0x3f5
    80027bc8:	060a                	slli	a2,a2,0x2
    80027bca:	02b50513          	addi	a0,a0,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027bce:	0542                	slli	a0,a0,0x10
    80027bd0:	9532                	add	a0,a0,a2
    80027bd2:	c11c                	sw	a5,0(a0)
    return 0;
    80027bd4:	4501                	li	a0,0
}
    80027bd6:	6422                	ld	s0,8(sp)
    80027bd8:	0141                	addi	sp,sp,16
    80027bda:	8082                	ret
            cfg.pd = 1;
    80027bdc:	4705                	li	a4,1
            cfg.pu = 0;
    80027bde:	4681                	li	a3,0
    80027be0:	b7e1                	j	80027ba8 <fpioa_set_io_pull+0x42>
            cfg.pd = 0;
    80027be2:	4701                	li	a4,0
            cfg.pu = 0;
    80027be4:	4681                	li	a3,0
    80027be6:	b7c9                	j	80027ba8 <fpioa_set_io_pull+0x42>
            cfg.pd = 0;
    80027be8:	4701                	li	a4,0
            cfg.pu = 1;
    80027bea:	4685                	li	a3,1
    80027bec:	bf75                	j	80027ba8 <fpioa_set_io_pull+0x42>
        return -1;
    80027bee:	557d                	li	a0,-1
    80027bf0:	b7dd                	j	80027bd6 <fpioa_set_io_pull+0x70>
    80027bf2:	557d                	li	a0,-1
    80027bf4:	b7cd                	j	80027bd6 <fpioa_set_io_pull+0x70>

0000000080027bf6 <fpioa_set_function_raw>:

//     return fpioa->io[number].ds;
// }

int fpioa_set_function_raw(int number, fpioa_function_t function)
{
    80027bf6:	1141                	addi	sp,sp,-16
    80027bf8:	e422                	sd	s0,8(sp)
    80027bfa:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027bfc:	02f00793          	li	a5,47
    80027c00:	12a7ec63          	bltu	a5,a0,80027d38 <fpioa_set_function_raw+0x142>
    80027c04:	882a                	mv	a6,a0
    80027c06:	0ff00793          	li	a5,255
    80027c0a:	12b7e963          	bltu	a5,a1,80027d3c <fpioa_set_function_raw+0x146>
        return -1;
    /* Atomic write register */
    fpioa->io[number] = (const fpioa_io_config_t){
        .ch_sel = function_config[function].ch_sel,
    80027c0e:	1582                	slli	a1,a1,0x20
    80027c10:	9181                	srli	a1,a1,0x20
    80027c12:	058a                	slli	a1,a1,0x2
    80027c14:	00005397          	auipc	t2,0x5
    80027c18:	8fc38393          	addi	t2,t2,-1796 # 8002c510 <function_config>
    80027c1c:	93ae                	add	t2,t2,a1
        .ds = function_config[function].ds,
    80027c1e:	0003a583          	lw	a1,0(t2)
    80027c22:	0085d61b          	srliw	a2,a1,0x8
        .oe_en = function_config[function].oe_en,
    80027c26:	00c5d69b          	srliw	a3,a1,0xc
        .oe_inv = function_config[function].oe_inv,
    80027c2a:	00d5df9b          	srliw	t6,a1,0xd
        .do_sel = function_config[function].do_sel,
    80027c2e:	00e5df1b          	srliw	t5,a1,0xe
        .do_inv = function_config[function].do_inv,
    80027c32:	00f5d71b          	srliw	a4,a1,0xf
        .pu = function_config[function].pu,
    80027c36:	0105de9b          	srliw	t4,a1,0x10
        .pd = function_config[function].pd,
    80027c3a:	0115de1b          	srliw	t3,a1,0x11
        .sl = function_config[function].sl,
    80027c3e:	0135d79b          	srliw	a5,a1,0x13
        .ie_en = function_config[function].ie_en,
    80027c42:	0145d31b          	srliw	t1,a1,0x14
        .ie_inv = function_config[function].ie_inv,
    80027c46:	0155d89b          	srliw	a7,a1,0x15
        .di_inv = function_config[function].di_inv,
    80027c4a:	0165d51b          	srliw	a0,a1,0x16
        .st = function_config[function].st,
    80027c4e:	0175d59b          	srliw	a1,a1,0x17
    fpioa->io[number] = (const fpioa_io_config_t){
    80027c52:	8a3d                	andi	a2,a2,15
    80027c54:	0086129b          	slliw	t0,a2,0x8
    80027c58:	0003c603          	lbu	a2,0(t2)
    80027c5c:	00566633          	or	a2,a2,t0
    80027c60:	8a85                	andi	a3,a3,1
    80027c62:	00c6969b          	slliw	a3,a3,0xc
    80027c66:	72fd                	lui	t0,0xfffff
    80027c68:	12fd                	addi	t0,t0,-1
    80027c6a:	00567633          	and	a2,a2,t0
    80027c6e:	8e55                	or	a2,a2,a3
    80027c70:	001fff93          	andi	t6,t6,1
    80027c74:	00df9f9b          	slliw	t6,t6,0xd
    80027c78:	76f9                	lui	a3,0xffffe
    80027c7a:	16fd                	addi	a3,a3,-1
    80027c7c:	8ef1                	and	a3,a3,a2
    80027c7e:	01f6e633          	or	a2,a3,t6
    80027c82:	001f7693          	andi	a3,t5,1
    80027c86:	00e69f1b          	slliw	t5,a3,0xe
    80027c8a:	76f1                	lui	a3,0xffffc
    80027c8c:	16fd                	addi	a3,a3,-1
    80027c8e:	8ef1                	and	a3,a3,a2
    80027c90:	01e6e6b3          	or	a3,a3,t5
    80027c94:	8b05                	andi	a4,a4,1
    80027c96:	00f7171b          	slliw	a4,a4,0xf
    80027c9a:	7661                	lui	a2,0xffff8
    80027c9c:	167d                	addi	a2,a2,-1
    80027c9e:	8ef1                	and	a3,a3,a2
    80027ca0:	8ed9                	or	a3,a3,a4
    80027ca2:	001ef613          	andi	a2,t4,1
    80027ca6:	0106161b          	slliw	a2,a2,0x10
    80027caa:	7741                	lui	a4,0xffff0
    80027cac:	177d                	addi	a4,a4,-1
    80027cae:	8f75                	and	a4,a4,a3
    80027cb0:	00c766b3          	or	a3,a4,a2
    80027cb4:	001e7713          	andi	a4,t3,1
    80027cb8:	0117161b          	slliw	a2,a4,0x11
    80027cbc:	7701                	lui	a4,0xfffe0
    80027cbe:	177d                	addi	a4,a4,-1
    80027cc0:	8f75                	and	a4,a4,a3
    80027cc2:	8f51                	or	a4,a4,a2
    80027cc4:	8b85                	andi	a5,a5,1
    80027cc6:	0137979b          	slliw	a5,a5,0x13
    80027cca:	fff806b7          	lui	a3,0xfff80
    80027cce:	16fd                	addi	a3,a3,-1
    80027cd0:	8f75                	and	a4,a4,a3
    80027cd2:	8f5d                	or	a4,a4,a5
    80027cd4:	00137693          	andi	a3,t1,1
    80027cd8:	0146969b          	slliw	a3,a3,0x14
    80027cdc:	fff007b7          	lui	a5,0xfff00
    80027ce0:	17fd                	addi	a5,a5,-1
    80027ce2:	8ff9                	and	a5,a5,a4
    80027ce4:	00d7e733          	or	a4,a5,a3
    80027ce8:	0018f793          	andi	a5,a7,1
    80027cec:	0157969b          	slliw	a3,a5,0x15
    80027cf0:	ffe007b7          	lui	a5,0xffe00
    80027cf4:	17fd                	addi	a5,a5,-1
    80027cf6:	8ff9                	and	a5,a5,a4
    80027cf8:	8fd5                	or	a5,a5,a3
    80027cfa:	00157713          	andi	a4,a0,1
    80027cfe:	0167171b          	slliw	a4,a4,0x16
    80027d02:	ffc006b7          	lui	a3,0xffc00
    80027d06:	16fd                	addi	a3,a3,-1
    80027d08:	8ff5                	and	a5,a5,a3
    80027d0a:	8fd9                	or	a5,a5,a4
    80027d0c:	8985                	andi	a1,a1,1
    80027d0e:	0175959b          	slliw	a1,a1,0x17
    80027d12:	ff800737          	lui	a4,0xff800
    80027d16:	177d                	addi	a4,a4,-1
    80027d18:	8ff9                	and	a5,a5,a4
    80027d1a:	8fcd                	or	a5,a5,a1
    80027d1c:	003f5737          	lui	a4,0x3f5
    80027d20:	00281693          	slli	a3,a6,0x2
    80027d24:	02b70813          	addi	a6,a4,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027d28:	0842                	slli	a6,a6,0x10
    80027d2a:	9836                	add	a6,a6,a3
    80027d2c:	00f82023          	sw	a5,0(a6)
        /* resv and pad_di do not need initialization */
    };
    return 0;
    80027d30:	4501                	li	a0,0
}
    80027d32:	6422                	ld	s0,8(sp)
    80027d34:	0141                	addi	sp,sp,16
    80027d36:	8082                	ret
        return -1;
    80027d38:	557d                	li	a0,-1
    80027d3a:	bfe5                	j	80027d32 <fpioa_set_function_raw+0x13c>
    80027d3c:	557d                	li	a0,-1
    80027d3e:	bfd5                	j	80027d32 <fpioa_set_function_raw+0x13c>

0000000080027d40 <fpioa_set_function>:

int fpioa_set_function(int number, fpioa_function_t function)
{
    uint8 index = 0;
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027d40:	02f00793          	li	a5,47
    80027d44:	08a7eb63          	bltu	a5,a0,80027dda <fpioa_set_function+0x9a>
{
    80027d48:	7139                	addi	sp,sp,-64
    80027d4a:	fc06                	sd	ra,56(sp)
    80027d4c:	f822                	sd	s0,48(sp)
    80027d4e:	f426                	sd	s1,40(sp)
    80027d50:	f04a                	sd	s2,32(sp)
    80027d52:	ec4e                	sd	s3,24(sp)
    80027d54:	e852                	sd	s4,16(sp)
    80027d56:	e456                	sd	s5,8(sp)
    80027d58:	0080                	addi	s0,sp,64
    80027d5a:	8aaa                	mv	s5,a0
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027d5c:	0ff00793          	li	a5,255
    80027d60:	06b7ef63          	bltu	a5,a1,80027dde <fpioa_set_function+0x9e>
    80027d64:	892e                	mv	s2,a1
        return -1;
    if(function == FUNC_RESV0)
    80027d66:	07800793          	li	a5,120
    80027d6a:	4481                	li	s1,0
    80027d6c:	00f58a63          	beq	a1,a5,80027d80 <fpioa_set_function+0x40>
        return 0;
    }
    /* Compare all IO */
    for(index = 0; index < FPIOA_NUM_IO; index++)
    {
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80027d70:	003f59b7          	lui	s3,0x3f5
    80027d74:	02b98993          	addi	s3,s3,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027d78:	09c2                	slli	s3,s3,0x10
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027d7a:	03000a13          	li	s4,48
    80027d7e:	a821                	j	80027d96 <fpioa_set_function+0x56>
        fpioa_set_function_raw(number, FUNC_RESV0);
    80027d80:	07800593          	li	a1,120
    80027d84:	00000097          	auipc	ra,0x0
    80027d88:	e72080e7          	jalr	-398(ra) # 80027bf6 <fpioa_set_function_raw>
        return 0;
    80027d8c:	4501                	li	a0,0
    80027d8e:	a82d                	j	80027dc8 <fpioa_set_function+0x88>
    80027d90:	2485                	addiw	s1,s1,1
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027d92:	03448463          	beq	s1,s4,80027dba <fpioa_set_function+0x7a>
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80027d96:	0004851b          	sext.w	a0,s1
    80027d9a:	00251793          	slli	a5,a0,0x2
    80027d9e:	97ce                	add	a5,a5,s3
    80027da0:	0007c783          	lbu	a5,0(a5) # ffffffffffe00000 <kernel_end+0xffffffff7fdbb000>
    80027da4:	fef916e3          	bne	s2,a5,80027d90 <fpioa_set_function+0x50>
    80027da8:	ff5504e3          	beq	a0,s5,80027d90 <fpioa_set_function+0x50>
            fpioa_set_function_raw(index, FUNC_RESV0);
    80027dac:	07800593          	li	a1,120
    80027db0:	00000097          	auipc	ra,0x0
    80027db4:	e46080e7          	jalr	-442(ra) # 80027bf6 <fpioa_set_function_raw>
    80027db8:	bfe1                	j	80027d90 <fpioa_set_function+0x50>
    }
    fpioa_set_function_raw(number, function);
    80027dba:	85ca                	mv	a1,s2
    80027dbc:	8556                	mv	a0,s5
    80027dbe:	00000097          	auipc	ra,0x0
    80027dc2:	e38080e7          	jalr	-456(ra) # 80027bf6 <fpioa_set_function_raw>
    return 0;
    80027dc6:	4501                	li	a0,0
}
    80027dc8:	70e2                	ld	ra,56(sp)
    80027dca:	7442                	ld	s0,48(sp)
    80027dcc:	74a2                	ld	s1,40(sp)
    80027dce:	7902                	ld	s2,32(sp)
    80027dd0:	69e2                	ld	s3,24(sp)
    80027dd2:	6a42                	ld	s4,16(sp)
    80027dd4:	6aa2                	ld	s5,8(sp)
    80027dd6:	6121                	addi	sp,sp,64
    80027dd8:	8082                	ret
        return -1;
    80027dda:	557d                	li	a0,-1
}
    80027ddc:	8082                	ret
        return -1;
    80027dde:	557d                	li	a0,-1
    80027de0:	b7e5                	j	80027dc8 <fpioa_set_function+0x88>

0000000080027de2 <fpioa_get_io_by_function>:
//         fpioa->tie.val[function / 32] &= (~(1UL << (function % 32)));
//     return 0;
// }

int fpioa_get_io_by_function(fpioa_function_t function)
{
    80027de2:	1141                	addi	sp,sp,-16
    80027de4:	e422                	sd	s0,8(sp)
    80027de6:	0800                	addi	s0,sp,16
    int index = 0;
    for(index = 0; index < FPIOA_NUM_IO; index++)
    {
        if(fpioa->io[index].ch_sel == function)
    80027de8:	003f57b7          	lui	a5,0x3f5
    80027dec:	02b78793          	addi	a5,a5,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027df0:	07c2                	slli	a5,a5,0x10
    80027df2:	0007c783          	lbu	a5,0(a5)
    80027df6:	02f50963          	beq	a0,a5,80027e28 <fpioa_get_io_by_function+0x46>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027dfa:	4785                	li	a5,1
        if(fpioa->io[index].ch_sel == function)
    80027dfc:	003f56b7          	lui	a3,0x3f5
    80027e00:	02b68693          	addi	a3,a3,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027e04:	06c2                	slli	a3,a3,0x10
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027e06:	03000613          	li	a2,48
        if(fpioa->io[index].ch_sel == function)
    80027e0a:	00279713          	slli	a4,a5,0x2
    80027e0e:	9736                	add	a4,a4,a3
    80027e10:	00074703          	lbu	a4,0(a4)
    80027e14:	00e50663          	beq	a0,a4,80027e20 <fpioa_get_io_by_function+0x3e>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027e18:	2785                	addiw	a5,a5,1
    80027e1a:	fec798e3          	bne	a5,a2,80027e0a <fpioa_get_io_by_function+0x28>
            return index;
    }

    return -1;
    80027e1e:	57fd                	li	a5,-1
}
    80027e20:	853e                	mv	a0,a5
    80027e22:	6422                	ld	s0,8(sp)
    80027e24:	0141                	addi	sp,sp,16
    80027e26:	8082                	ret
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027e28:	4781                	li	a5,0
    80027e2a:	bfdd                	j	80027e20 <fpioa_get_io_by_function+0x3e>

0000000080027e2c <fpioa_pin_init>:

void fpioa_pin_init() {
    80027e2c:	1141                	addi	sp,sp,-16
    80027e2e:	e406                	sd	ra,8(sp)
    80027e30:	e022                	sd	s0,0(sp)
    80027e32:	0800                	addi	s0,sp,16
    fpioa_set_function(27, FUNC_SPI0_SCLK);
    80027e34:	45c5                	li	a1,17
    80027e36:	456d                	li	a0,27
    80027e38:	00000097          	auipc	ra,0x0
    80027e3c:	f08080e7          	jalr	-248(ra) # 80027d40 <fpioa_set_function>
    fpioa_set_function(28, FUNC_SPI0_D0);
    80027e40:	4591                	li	a1,4
    80027e42:	4571                	li	a0,28
    80027e44:	00000097          	auipc	ra,0x0
    80027e48:	efc080e7          	jalr	-260(ra) # 80027d40 <fpioa_set_function>
    fpioa_set_function(26, FUNC_SPI0_D1);
    80027e4c:	4595                	li	a1,5
    80027e4e:	4569                	li	a0,26
    80027e50:	00000097          	auipc	ra,0x0
    80027e54:	ef0080e7          	jalr	-272(ra) # 80027d40 <fpioa_set_function>
	fpioa_set_function(32, FUNC_GPIOHS7);
    80027e58:	45fd                	li	a1,31
    80027e5a:	02000513          	li	a0,32
    80027e5e:	00000097          	auipc	ra,0x0
    80027e62:	ee2080e7          	jalr	-286(ra) # 80027d40 <fpioa_set_function>
    fpioa_set_function(29, FUNC_SPI0_SS3);
    80027e66:	45bd                	li	a1,15
    80027e68:	4575                	li	a0,29
    80027e6a:	00000097          	auipc	ra,0x0
    80027e6e:	ed6080e7          	jalr	-298(ra) # 80027d40 <fpioa_set_function>
    #ifdef DEBUG
    printf("fpioa_pin_init\n");
    #endif
    80027e72:	60a2                	ld	ra,8(sp)
    80027e74:	6402                	ld	s0,0(sp)
    80027e76:	0141                	addi	sp,sp,16
    80027e78:	8082                	ret

0000000080027e7a <set_bit>:
#include "include/types.h"
#include "include/utils.h"

void set_bit(volatile uint32 *bits, uint32 mask, uint32 value)
{
    80027e7a:	1141                	addi	sp,sp,-16
    80027e7c:	e422                	sd	s0,8(sp)
    80027e7e:	0800                	addi	s0,sp,16
    uint32 org = (*bits) & ~mask;
    80027e80:	411c                	lw	a5,0(a0)
    80027e82:	2781                	sext.w	a5,a5
    *bits = org | (value & mask);
    80027e84:	8e3d                	xor	a2,a2,a5
    80027e86:	8df1                	and	a1,a1,a2
    80027e88:	8fad                	xor	a5,a5,a1
    80027e8a:	c11c                	sw	a5,0(a0)
}
    80027e8c:	6422                	ld	s0,8(sp)
    80027e8e:	0141                	addi	sp,sp,16
    80027e90:	8082                	ret

0000000080027e92 <set_bit_offset>:

void set_bit_offset(volatile uint32 *bits, uint32 mask, uint64 offset, uint32 value)
{
    80027e92:	1141                	addi	sp,sp,-16
    80027e94:	e422                	sd	s0,8(sp)
    80027e96:	0800                	addi	s0,sp,16
    set_bit(bits, mask << offset, value << offset);
    80027e98:	2601                	sext.w	a2,a2
    uint32 org = (*bits) & ~mask;
    80027e9a:	411c                	lw	a5,0(a0)
    80027e9c:	2781                	sext.w	a5,a5
    set_bit(bits, mask << offset, value << offset);
    80027e9e:	00c696bb          	sllw	a3,a3,a2
    *bits = org | (value & mask);
    80027ea2:	8ebd                	xor	a3,a3,a5
    set_bit(bits, mask << offset, value << offset);
    80027ea4:	00c595bb          	sllw	a1,a1,a2
    *bits = org | (value & mask);
    80027ea8:	8eed                	and	a3,a3,a1
    80027eaa:	8fb5                	xor	a5,a5,a3
    80027eac:	2781                	sext.w	a5,a5
    80027eae:	c11c                	sw	a5,0(a0)
}
    80027eb0:	6422                	ld	s0,8(sp)
    80027eb2:	0141                	addi	sp,sp,16
    80027eb4:	8082                	ret

0000000080027eb6 <set_gpio_bit>:

void set_gpio_bit(volatile uint32 *bits, uint64 offset, uint32 value)
{
    80027eb6:	1141                	addi	sp,sp,-16
    80027eb8:	e406                	sd	ra,8(sp)
    80027eba:	e022                	sd	s0,0(sp)
    80027ebc:	0800                	addi	s0,sp,16
    set_bit_offset(bits, 1, offset, value);
    80027ebe:	86b2                	mv	a3,a2
    80027ec0:	862e                	mv	a2,a1
    80027ec2:	4585                	li	a1,1
    80027ec4:	00000097          	auipc	ra,0x0
    80027ec8:	fce080e7          	jalr	-50(ra) # 80027e92 <set_bit_offset>
}
    80027ecc:	60a2                	ld	ra,8(sp)
    80027ece:	6402                	ld	s0,0(sp)
    80027ed0:	0141                	addi	sp,sp,16
    80027ed2:	8082                	ret

0000000080027ed4 <get_bit>:

uint32 get_bit(volatile uint32 *bits, uint32 mask, uint64 offset)
{
    80027ed4:	1141                	addi	sp,sp,-16
    80027ed6:	e422                	sd	s0,8(sp)
    80027ed8:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    80027eda:	411c                	lw	a5,0(a0)
    80027edc:	2781                	sext.w	a5,a5
    80027ede:	2601                	sext.w	a2,a2
    80027ee0:	00c595bb          	sllw	a1,a1,a2
    80027ee4:	8fed                	and	a5,a5,a1
}
    80027ee6:	00c7d53b          	srlw	a0,a5,a2
    80027eea:	6422                	ld	s0,8(sp)
    80027eec:	0141                	addi	sp,sp,16
    80027eee:	8082                	ret

0000000080027ef0 <get_gpio_bit>:

uint32 get_gpio_bit(volatile uint32 *bits, uint64 offset)
{
    80027ef0:	1141                	addi	sp,sp,-16
    80027ef2:	e422                	sd	s0,8(sp)
    80027ef4:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    80027ef6:	411c                	lw	a5,0(a0)
    80027ef8:	2781                	sext.w	a5,a5
    80027efa:	2581                	sext.w	a1,a1
    80027efc:	4705                	li	a4,1
    80027efe:	00b7173b          	sllw	a4,a4,a1
    80027f02:	8ff9                	and	a5,a5,a4
    return get_bit(bits, 1, offset);
}
    80027f04:	00b7d53b          	srlw	a0,a5,a1
    80027f08:	6422                	ld	s0,8(sp)
    80027f0a:	0141                	addi	sp,sp,16
    80027f0c:	8082                	ret

0000000080027f0e <sd_write_data>:
static void sd_lowlevel_init(uint8 spi_index) {
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    // spi_set_clk_rate(SPI_DEVICE_0, 200000);     /*set clk rate*/
}

static void sd_write_data(uint8 const *data_buff, uint32 length) {
    80027f0e:	1101                	addi	sp,sp,-32
    80027f10:	ec06                	sd	ra,24(sp)
    80027f12:	e822                	sd	s0,16(sp)
    80027f14:	e426                	sd	s1,8(sp)
    80027f16:	e04a                	sd	s2,0(sp)
    80027f18:	1000                	addi	s0,sp,32
    80027f1a:	84aa                	mv	s1,a0
    80027f1c:	892e                	mv	s2,a1
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80027f1e:	4701                	li	a4,0
    80027f20:	46a1                	li	a3,8
    80027f22:	4601                	li	a2,0
    80027f24:	4581                	li	a1,0
    80027f26:	4501                	li	a0,0
    80027f28:	fffff097          	auipc	ra,0xfffff
    80027f2c:	052080e7          	jalr	82(ra) # 80026f7a <spi_init>
    spi_send_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    80027f30:	02091793          	slli	a5,s2,0x20
    80027f34:	9381                	srli	a5,a5,0x20
    80027f36:	8726                	mv	a4,s1
    80027f38:	4681                	li	a3,0
    80027f3a:	4601                	li	a2,0
    80027f3c:	458d                	li	a1,3
    80027f3e:	4501                	li	a0,0
    80027f40:	fffff097          	auipc	ra,0xfffff
    80027f44:	2a8080e7          	jalr	680(ra) # 800271e8 <spi_send_data_standard>
}
    80027f48:	60e2                	ld	ra,24(sp)
    80027f4a:	6442                	ld	s0,16(sp)
    80027f4c:	64a2                	ld	s1,8(sp)
    80027f4e:	6902                	ld	s2,0(sp)
    80027f50:	6105                	addi	sp,sp,32
    80027f52:	8082                	ret

0000000080027f54 <sd_read_data>:

static void sd_read_data(uint8 *data_buff, uint32 length) {
    80027f54:	1101                	addi	sp,sp,-32
    80027f56:	ec06                	sd	ra,24(sp)
    80027f58:	e822                	sd	s0,16(sp)
    80027f5a:	e426                	sd	s1,8(sp)
    80027f5c:	e04a                	sd	s2,0(sp)
    80027f5e:	1000                	addi	s0,sp,32
    80027f60:	84aa                	mv	s1,a0
    80027f62:	892e                	mv	s2,a1
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80027f64:	4701                	li	a4,0
    80027f66:	46a1                	li	a3,8
    80027f68:	4601                	li	a2,0
    80027f6a:	4581                	li	a1,0
    80027f6c:	4501                	li	a0,0
    80027f6e:	fffff097          	auipc	ra,0xfffff
    80027f72:	00c080e7          	jalr	12(ra) # 80026f7a <spi_init>
    spi_receive_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    80027f76:	02091793          	slli	a5,s2,0x20
    80027f7a:	9381                	srli	a5,a5,0x20
    80027f7c:	8726                	mv	a4,s1
    80027f7e:	4681                	li	a3,0
    80027f80:	4601                	li	a2,0
    80027f82:	458d                	li	a1,3
    80027f84:	4501                	li	a0,0
    80027f86:	fffff097          	auipc	ra,0xfffff
    80027f8a:	2fa080e7          	jalr	762(ra) # 80027280 <spi_receive_data_standard>
}
    80027f8e:	60e2                	ld	ra,24(sp)
    80027f90:	6442                	ld	s0,16(sp)
    80027f92:	64a2                	ld	s1,8(sp)
    80027f94:	6902                	ld	s2,0(sp)
    80027f96:	6105                	addi	sp,sp,32
    80027f98:	8082                	ret

0000000080027f9a <sd_get_response_R1>:
#define SD_CMD13 	13 		// SEND_STATUS

/*
 * Read sdcard response in R1 type. 
 */
static uint8 sd_get_response_R1(void) {
    80027f9a:	7179                	addi	sp,sp,-48
    80027f9c:	f406                	sd	ra,40(sp)
    80027f9e:	f022                	sd	s0,32(sp)
    80027fa0:	ec26                	sd	s1,24(sp)
    80027fa2:	e84a                	sd	s2,16(sp)
    80027fa4:	1800                	addi	s0,sp,48
    80027fa6:	0ff00493          	li	s1,255
	uint8 result;
	uint16 timeout = 0xff;

	while (timeout--) {
		sd_read_data(&result, 1);
		if (result != 0xff)
    80027faa:	0ff00913          	li	s2,255
		sd_read_data(&result, 1);
    80027fae:	4585                	li	a1,1
    80027fb0:	fdf40513          	addi	a0,s0,-33
    80027fb4:	00000097          	auipc	ra,0x0
    80027fb8:	fa0080e7          	jalr	-96(ra) # 80027f54 <sd_read_data>
		if (result != 0xff)
    80027fbc:	fdf44503          	lbu	a0,-33(s0)
    80027fc0:	01251663          	bne	a0,s2,80027fcc <sd_get_response_R1+0x32>
    80027fc4:	34fd                	addiw	s1,s1,-1
    80027fc6:	14c2                	slli	s1,s1,0x30
    80027fc8:	90c1                	srli	s1,s1,0x30
	while (timeout--) {
    80027fca:	f0f5                	bnez	s1,80027fae <sd_get_response_R1+0x14>
			return result;
	}

	// timeout!
	return 0xff;
}
    80027fcc:	70a2                	ld	ra,40(sp)
    80027fce:	7402                	ld	s0,32(sp)
    80027fd0:	64e2                	ld	s1,24(sp)
    80027fd2:	6942                	ld	s2,16(sp)
    80027fd4:	6145                	addi	sp,sp,48
    80027fd6:	8082                	ret

0000000080027fd8 <SD_CS_HIGH>:
void SD_CS_HIGH(void) {
    80027fd8:	1141                	addi	sp,sp,-16
    80027fda:	e406                	sd	ra,8(sp)
    80027fdc:	e022                	sd	s0,0(sp)
    80027fde:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_HIGH);
    80027fe0:	4585                	li	a1,1
    80027fe2:	451d                	li	a0,7
    80027fe4:	00000097          	auipc	ra,0x0
    80027fe8:	b5c080e7          	jalr	-1188(ra) # 80027b40 <gpiohs_set_pin>
}
    80027fec:	60a2                	ld	ra,8(sp)
    80027fee:	6402                	ld	s0,0(sp)
    80027ff0:	0141                	addi	sp,sp,16
    80027ff2:	8082                	ret

0000000080027ff4 <sd_end_cmd>:
static void sd_end_cmd(void) {
    80027ff4:	1101                	addi	sp,sp,-32
    80027ff6:	ec06                	sd	ra,24(sp)
    80027ff8:	e822                	sd	s0,16(sp)
    80027ffa:	1000                	addi	s0,sp,32
	uint8 frame[1] = {0xFF};
    80027ffc:	57fd                	li	a5,-1
    80027ffe:	fef40423          	sb	a5,-24(s0)
	SD_CS_HIGH();
    80028002:	00000097          	auipc	ra,0x0
    80028006:	fd6080e7          	jalr	-42(ra) # 80027fd8 <SD_CS_HIGH>
	sd_write_data(frame, 1);
    8002800a:	4585                	li	a1,1
    8002800c:	fe840513          	addi	a0,s0,-24
    80028010:	00000097          	auipc	ra,0x0
    80028014:	efe080e7          	jalr	-258(ra) # 80027f0e <sd_write_data>
}
    80028018:	60e2                	ld	ra,24(sp)
    8002801a:	6442                	ld	s0,16(sp)
    8002801c:	6105                	addi	sp,sp,32
    8002801e:	8082                	ret

0000000080028020 <SD_CS_LOW>:
void SD_CS_LOW(void) {
    80028020:	1141                	addi	sp,sp,-16
    80028022:	e406                	sd	ra,8(sp)
    80028024:	e022                	sd	s0,0(sp)
    80028026:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_LOW);
    80028028:	4581                	li	a1,0
    8002802a:	451d                	li	a0,7
    8002802c:	00000097          	auipc	ra,0x0
    80028030:	b14080e7          	jalr	-1260(ra) # 80027b40 <gpiohs_set_pin>
}
    80028034:	60a2                	ld	ra,8(sp)
    80028036:	6402                	ld	s0,0(sp)
    80028038:	0141                	addi	sp,sp,16
    8002803a:	8082                	ret

000000008002803c <sd_send_cmd>:
static void sd_send_cmd(uint8 cmd, uint32 arg, uint8 crc) {
    8002803c:	1101                	addi	sp,sp,-32
    8002803e:	ec06                	sd	ra,24(sp)
    80028040:	e822                	sd	s0,16(sp)
    80028042:	1000                	addi	s0,sp,32
	frame[0] = (cmd | 0x40);
    80028044:	04056513          	ori	a0,a0,64
    80028048:	fea40423          	sb	a0,-24(s0)
	frame[1] = (uint8)(arg >> 24);
    8002804c:	0185d79b          	srliw	a5,a1,0x18
    80028050:	fef404a3          	sb	a5,-23(s0)
	frame[2] = (uint8)(arg >> 16);
    80028054:	0105d79b          	srliw	a5,a1,0x10
    80028058:	fef40523          	sb	a5,-22(s0)
	frame[3] = (uint8)(arg >> 8);
    8002805c:	0085d79b          	srliw	a5,a1,0x8
    80028060:	fef405a3          	sb	a5,-21(s0)
	frame[4] = (uint8)(arg);
    80028064:	feb40623          	sb	a1,-20(s0)
	frame[5] = (crc);
    80028068:	fec406a3          	sb	a2,-19(s0)
	SD_CS_LOW();
    8002806c:	00000097          	auipc	ra,0x0
    80028070:	fb4080e7          	jalr	-76(ra) # 80028020 <SD_CS_LOW>
	sd_write_data(frame, 6);
    80028074:	4599                	li	a1,6
    80028076:	fe840513          	addi	a0,s0,-24
    8002807a:	00000097          	auipc	ra,0x0
    8002807e:	e94080e7          	jalr	-364(ra) # 80027f0e <sd_write_data>
}
    80028082:	60e2                	ld	ra,24(sp)
    80028084:	6442                	ld	s0,16(sp)
    80028086:	6105                	addi	sp,sp,32
    80028088:	8082                	ret

000000008002808a <SD_HIGH_SPEED_ENABLE>:
void SD_HIGH_SPEED_ENABLE(void) {
    8002808a:	1141                	addi	sp,sp,-16
    8002808c:	e422                	sd	s0,8(sp)
    8002808e:	0800                	addi	s0,sp,16
}
    80028090:	6422                	ld	s0,8(sp)
    80028092:	0141                	addi	sp,sp,16
    80028094:	8082                	ret

0000000080028096 <sdcard_init>:
	return 0;
}

static struct sleeplock sdcard_lock;

void sdcard_init(void) {
    80028096:	715d                	addi	sp,sp,-80
    80028098:	e486                	sd	ra,72(sp)
    8002809a:	e0a2                	sd	s0,64(sp)
    8002809c:	fc26                	sd	s1,56(sp)
    8002809e:	f84a                	sd	s2,48(sp)
    800280a0:	f44e                	sd	s3,40(sp)
    800280a2:	0880                	addi	s0,sp,80
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    800280a4:	458d                	li	a1,3
    800280a6:	451d                	li	a0,7
    800280a8:	00000097          	auipc	ra,0x0
    800280ac:	9fc080e7          	jalr	-1540(ra) # 80027aa4 <gpiohs_set_drive_mode>
	SD_CS_LOW();
    800280b0:	00000097          	auipc	ra,0x0
    800280b4:	f70080e7          	jalr	-144(ra) # 80028020 <SD_CS_LOW>
	for (int i = 0; i < 10; i ++) 
    800280b8:	fc040793          	addi	a5,s0,-64
    800280bc:	fca40693          	addi	a3,s0,-54
		frame[i] = 0xff;
    800280c0:	577d                	li	a4,-1
    800280c2:	00e78023          	sb	a4,0(a5)
    800280c6:	0785                	addi	a5,a5,1
	for (int i = 0; i < 10; i ++) 
    800280c8:	fef69de3          	bne	a3,a5,800280c2 <sdcard_init+0x2c>
	sd_write_data(frame, 10);
    800280cc:	45a9                	li	a1,10
    800280ce:	fc040513          	addi	a0,s0,-64
    800280d2:	00000097          	auipc	ra,0x0
    800280d6:	e3c080e7          	jalr	-452(ra) # 80027f0e <sd_write_data>
    800280da:	0fe00493          	li	s1,254
		if (0x01 == result) break;
    800280de:	4905                	li	s2,1
		sd_send_cmd(SD_CMD0, 0, 0x95);
    800280e0:	09500613          	li	a2,149
    800280e4:	4581                	li	a1,0
    800280e6:	4501                	li	a0,0
    800280e8:	00000097          	auipc	ra,0x0
    800280ec:	f54080e7          	jalr	-172(ra) # 8002803c <sd_send_cmd>
		uint64 result = sd_get_response_R1();
    800280f0:	00000097          	auipc	ra,0x0
    800280f4:	eaa080e7          	jalr	-342(ra) # 80027f9a <sd_get_response_R1>
    800280f8:	89aa                	mv	s3,a0
		sd_end_cmd();
    800280fa:	00000097          	auipc	ra,0x0
    800280fe:	efa080e7          	jalr	-262(ra) # 80027ff4 <sd_end_cmd>
		if (0x01 == result) break;
    80028102:	25298a63          	beq	s3,s2,80028356 <sdcard_init+0x2c0>
    80028106:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    80028108:	fce1                	bnez	s1,800280e0 <sdcard_init+0x4a>
		printf("SD_CMD0 failed\n");
    8002810a:	00005517          	auipc	a0,0x5
    8002810e:	94e50513          	addi	a0,a0,-1714 # 8002ca58 <function_config+0x548>
    80028112:	ffff8097          	auipc	ra,0xffff8
    80028116:	07e080e7          	jalr	126(ra) # 80020190 <printf>
		return 0xff;
    8002811a:	ac59                	j	800283b0 <sdcard_init+0x31a>
		printf("invalid CRC for CMD8\n");
    8002811c:	00004517          	auipc	a0,0x4
    80028120:	7f450513          	addi	a0,a0,2036 # 8002c910 <function_config+0x400>
    80028124:	ffff8097          	auipc	ra,0xffff8
    80028128:	06c080e7          	jalr	108(ra) # 80020190 <printf>
		return 0xff;
    8002812c:	a451                	j	800283b0 <sdcard_init+0x31a>
	else if (0x01 == result && 0x01 == (frame[2] & 0x0f) && 0xaa == frame[3]) {
    8002812e:	fbb44703          	lbu	a4,-69(s0)
    80028132:	0aa00793          	li	a5,170
    80028136:	26f71563          	bne	a4,a5,800283a0 <sdcard_init+0x30a>
    8002813a:	0ff00493          	li	s1,255
	uint64 result=0;
    8002813e:	4901                	li	s2,0
		if (
    80028140:	4985                	li	s3,1
    80028142:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    80028144:	14048163          	beqz	s1,80028286 <sdcard_init+0x1f0>
		sd_send_cmd(SD_CMD58, 0, 0);
    80028148:	4601                	li	a2,0
    8002814a:	4581                	li	a1,0
    8002814c:	03a00513          	li	a0,58
    80028150:	00000097          	auipc	ra,0x0
    80028154:	eec080e7          	jalr	-276(ra) # 8002803c <sd_send_cmd>
		result = sd_get_response_R1();
    80028158:	00000097          	auipc	ra,0x0
    8002815c:	e42080e7          	jalr	-446(ra) # 80027f9a <sd_get_response_R1>
    80028160:	892a                	mv	s2,a0
	sd_read_data(frame, 4);
    80028162:	4591                	li	a1,4
    80028164:	fb840513          	addi	a0,s0,-72
    80028168:	00000097          	auipc	ra,0x0
    8002816c:	dec080e7          	jalr	-532(ra) # 80027f54 <sd_read_data>
		sd_end_cmd();
    80028170:	00000097          	auipc	ra,0x0
    80028174:	e84080e7          	jalr	-380(ra) # 80027ff4 <sd_end_cmd>
		if (
    80028178:	fd3915e3          	bne	s2,s3,80028142 <sdcard_init+0xac>
			0x01 == result && // R1 response in idle status 
    8002817c:	fb944783          	lbu	a5,-71(s0)
    80028180:	8bfd                	andi	a5,a5,31
    80028182:	d3e1                	beqz	a5,80028142 <sdcard_init+0xac>
			(ocr[1] & 0x1f) && (ocr[2] & 0x80) 	// voltage range valid 
    80028184:	fba40783          	lb	a5,-70(s0)
    80028188:	fa07dde3          	bgez	a5,80028142 <sdcard_init+0xac>
    8002818c:	6485                	lui	s1,0x1
    8002818e:	14fd                	addi	s1,s1,-1
	uint8 result = 0xff;
    80028190:	0ff00913          	li	s2,255
		if (0x01 != result) {
    80028194:	4985                	li	s3,1
    80028196:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    80028198:	12048463          	beqz	s1,800282c0 <sdcard_init+0x22a>
		sd_send_cmd(SD_CMD55, 0, 0);
    8002819c:	4601                	li	a2,0
    8002819e:	4581                	li	a1,0
    800281a0:	03700513          	li	a0,55
    800281a4:	00000097          	auipc	ra,0x0
    800281a8:	e98080e7          	jalr	-360(ra) # 8002803c <sd_send_cmd>
		result = sd_get_response_R1();
    800281ac:	00000097          	auipc	ra,0x0
    800281b0:	dee080e7          	jalr	-530(ra) # 80027f9a <sd_get_response_R1>
    800281b4:	892a                	mv	s2,a0
		sd_end_cmd();
    800281b6:	00000097          	auipc	ra,0x0
    800281ba:	e3e080e7          	jalr	-450(ra) # 80027ff4 <sd_end_cmd>
		if (0x01 != result) {
    800281be:	0f391663          	bne	s2,s3,800282aa <sdcard_init+0x214>
		sd_send_cmd(SD_ACMD41, 0x40000000, 0);
    800281c2:	4601                	li	a2,0
    800281c4:	400005b7          	lui	a1,0x40000
    800281c8:	02900513          	li	a0,41
    800281cc:	00000097          	auipc	ra,0x0
    800281d0:	e70080e7          	jalr	-400(ra) # 8002803c <sd_send_cmd>
		result = sd_get_response_R1();
    800281d4:	00000097          	auipc	ra,0x0
    800281d8:	dc6080e7          	jalr	-570(ra) # 80027f9a <sd_get_response_R1>
    800281dc:	892a                	mv	s2,a0
		sd_end_cmd();
    800281de:	00000097          	auipc	ra,0x0
    800281e2:	e16080e7          	jalr	-490(ra) # 80027ff4 <sd_end_cmd>
		if (0 == result) {
    800281e6:	fa0918e3          	bnez	s2,80028196 <sdcard_init+0x100>
    800281ea:	10000493          	li	s1,256
	uint8 result = 0xff;
    800281ee:	0ff00913          	li	s2,255
    800281f2:	34fd                	addiw	s1,s1,-1
	while (timeout --) {
    800281f4:	10048663          	beqz	s1,80028300 <sdcard_init+0x26a>
		sd_send_cmd(SD_CMD58, 0, 0);
    800281f8:	4601                	li	a2,0
    800281fa:	4581                	li	a1,0
    800281fc:	03a00513          	li	a0,58
    80028200:	00000097          	auipc	ra,0x0
    80028204:	e3c080e7          	jalr	-452(ra) # 8002803c <sd_send_cmd>
		result = sd_get_response_R1();
    80028208:	00000097          	auipc	ra,0x0
    8002820c:	d92080e7          	jalr	-622(ra) # 80027f9a <sd_get_response_R1>
    80028210:	892a                	mv	s2,a0
	sd_read_data(frame, 4);
    80028212:	4591                	li	a1,4
    80028214:	fb840513          	addi	a0,s0,-72
    80028218:	00000097          	auipc	ra,0x0
    8002821c:	d3c080e7          	jalr	-708(ra) # 80027f54 <sd_read_data>
		sd_end_cmd();
    80028220:	00000097          	auipc	ra,0x0
    80028224:	dd4080e7          	jalr	-556(ra) # 80027ff4 <sd_end_cmd>
		if (0 == result) {
    80028228:	fc0915e3          	bnez	s2,800281f2 <sdcard_init+0x15c>
			if (ocr[0] & 0x40) {
    8002822c:	fb844783          	lbu	a5,-72(s0)
    80028230:	0407f793          	andi	a5,a5,64
    80028234:	ebcd                	bnez	a5,800282e6 <sdcard_init+0x250>
				printf("SDSC detected, setting block size\n");
    80028236:	00004517          	auipc	a0,0x4
    8002823a:	79a50513          	addi	a0,a0,1946 # 8002c9d0 <function_config+0x4c0>
    8002823e:	ffff8097          	auipc	ra,0xffff8
    80028242:	f52080e7          	jalr	-174(ra) # 80020190 <printf>
    80028246:	0fe00493          	li	s1,254
					sd_send_cmd(SD_CMD16, BSIZE, 0);
    8002824a:	4601                	li	a2,0
    8002824c:	20000593          	li	a1,512
    80028250:	4541                	li	a0,16
    80028252:	00000097          	auipc	ra,0x0
    80028256:	dea080e7          	jalr	-534(ra) # 8002803c <sd_send_cmd>
					result = sd_get_response_R1();
    8002825a:	00000097          	auipc	ra,0x0
    8002825e:	d40080e7          	jalr	-704(ra) # 80027f9a <sd_get_response_R1>
    80028262:	892a                	mv	s2,a0
					sd_end_cmd();
    80028264:	00000097          	auipc	ra,0x0
    80028268:	d90080e7          	jalr	-624(ra) # 80027ff4 <sd_end_cmd>
					if (0 == result) break;
    8002826c:	0a090d63          	beqz	s2,80028326 <sdcard_init+0x290>
    80028270:	34fd                	addiw	s1,s1,-1
				while (--timeout) {
    80028272:	fce1                	bnez	s1,8002824a <sdcard_init+0x1b4>
					printf("check_OCR(): fail to set block size");
    80028274:	00004517          	auipc	a0,0x4
    80028278:	7bc50513          	addi	a0,a0,1980 # 8002ca30 <function_config+0x520>
    8002827c:	ffff8097          	auipc	ra,0xffff8
    80028280:	f14080e7          	jalr	-236(ra) # 80020190 <printf>
					return 0xff;
    80028284:	a235                	j	800283b0 <sdcard_init+0x31a>
	printf("read_OCR() timeout!\n");
    80028286:	00004517          	auipc	a0,0x4
    8002828a:	6ca50513          	addi	a0,a0,1738 # 8002c950 <function_config+0x440>
    8002828e:	ffff8097          	auipc	ra,0xffff8
    80028292:	f02080e7          	jalr	-254(ra) # 80020190 <printf>
	printf("result = %d\n", result);
    80028296:	85ca                	mv	a1,s2
    80028298:	00004517          	auipc	a0,0x4
    8002829c:	6d050513          	addi	a0,a0,1744 # 8002c968 <function_config+0x458>
    800282a0:	ffff8097          	auipc	ra,0xffff8
    800282a4:	ef0080e7          	jalr	-272(ra) # 80020190 <printf>
	return 0xff;
    800282a8:	a221                	j	800283b0 <sdcard_init+0x31a>
			printf("SD_CMD55 fail! result = %d\n", result);
    800282aa:	0009059b          	sext.w	a1,s2
    800282ae:	00004517          	auipc	a0,0x4
    800282b2:	6ca50513          	addi	a0,a0,1738 # 8002c978 <function_config+0x468>
    800282b6:	ffff8097          	auipc	ra,0xffff8
    800282ba:	eda080e7          	jalr	-294(ra) # 80020190 <printf>
			return 0xff;
    800282be:	a8cd                	j	800283b0 <sdcard_init+0x31a>
	printf("set_SDXC_capacity() timeout!\n");
    800282c0:	00004517          	auipc	a0,0x4
    800282c4:	6d850513          	addi	a0,a0,1752 # 8002c998 <function_config+0x488>
    800282c8:	ffff8097          	auipc	ra,0xffff8
    800282cc:	ec8080e7          	jalr	-312(ra) # 80020190 <printf>
	printf("result = %d\n", result);
    800282d0:	0009059b          	sext.w	a1,s2
    800282d4:	00004517          	auipc	a0,0x4
    800282d8:	69450513          	addi	a0,a0,1684 # 8002c968 <function_config+0x458>
    800282dc:	ffff8097          	auipc	ra,0xffff8
    800282e0:	eb4080e7          	jalr	-332(ra) # 80020190 <printf>
	return 0xff;
    800282e4:	a0f1                	j	800283b0 <sdcard_init+0x31a>
				printf("SDHC/SDXC detected\n");
    800282e6:	00004517          	auipc	a0,0x4
    800282ea:	6d250513          	addi	a0,a0,1746 # 8002c9b8 <function_config+0x4a8>
    800282ee:	ffff8097          	auipc	ra,0xffff8
    800282f2:	ea2080e7          	jalr	-350(ra) # 80020190 <printf>
				is_standard_sd = 0;
    800282f6:	0001d797          	auipc	a5,0x1d
    800282fa:	a007a123          	sw	zero,-1534(a5) # 80044cf8 <is_standard_sd>
    800282fe:	a80d                	j	80028330 <sdcard_init+0x29a>
	printf("check_OCR() timeout!\n");
    80028300:	00004517          	auipc	a0,0x4
    80028304:	6f850513          	addi	a0,a0,1784 # 8002c9f8 <function_config+0x4e8>
    80028308:	ffff8097          	auipc	ra,0xffff8
    8002830c:	e88080e7          	jalr	-376(ra) # 80020190 <printf>
	printf("result = %d\n", result);
    80028310:	0009059b          	sext.w	a1,s2
    80028314:	00004517          	auipc	a0,0x4
    80028318:	65450513          	addi	a0,a0,1620 # 8002c968 <function_config+0x458>
    8002831c:	ffff8097          	auipc	ra,0xffff8
    80028320:	e74080e7          	jalr	-396(ra) # 80020190 <printf>
	return 0xff;
    80028324:	a071                	j	800283b0 <sdcard_init+0x31a>
				is_standard_sd = 1;
    80028326:	4785                	li	a5,1
    80028328:	0001d717          	auipc	a4,0x1d
    8002832c:	9cf72823          	sw	a5,-1584(a4) # 80044cf8 <is_standard_sd>
	int result = sd_init();
	initsleeplock(&sdcard_lock, "sdcard");
    80028330:	00004597          	auipc	a1,0x4
    80028334:	6e058593          	addi	a1,a1,1760 # 8002ca10 <function_config+0x500>
    80028338:	0001d517          	auipc	a0,0x1d
    8002833c:	99050513          	addi	a0,a0,-1648 # 80044cc8 <sdcard_lock>
    80028340:	ffffb097          	auipc	ra,0xffffb
    80028344:	3a4080e7          	jalr	932(ra) # 800236e4 <initsleeplock>
		panic("sdcard_init failed");
	}
	#ifdef DEBUG
	printf("sdcard_init\n");
	#endif
}
    80028348:	60a6                	ld	ra,72(sp)
    8002834a:	6406                	ld	s0,64(sp)
    8002834c:	74e2                	ld	s1,56(sp)
    8002834e:	7942                	ld	s2,48(sp)
    80028350:	79a2                	ld	s3,40(sp)
    80028352:	6161                	addi	sp,sp,80
    80028354:	8082                	ret
	sd_send_cmd(SD_CMD8, 0x01aa, 0x87);
    80028356:	08700613          	li	a2,135
    8002835a:	1aa00593          	li	a1,426
    8002835e:	4521                	li	a0,8
    80028360:	00000097          	auipc	ra,0x0
    80028364:	cdc080e7          	jalr	-804(ra) # 8002803c <sd_send_cmd>
	result = sd_get_response_R1();
    80028368:	00000097          	auipc	ra,0x0
    8002836c:	c32080e7          	jalr	-974(ra) # 80027f9a <sd_get_response_R1>
    80028370:	84aa                	mv	s1,a0
	sd_read_data(frame, 4);
    80028372:	4591                	li	a1,4
    80028374:	fb840513          	addi	a0,s0,-72
    80028378:	00000097          	auipc	ra,0x0
    8002837c:	bdc080e7          	jalr	-1060(ra) # 80027f54 <sd_read_data>
	sd_end_cmd();
    80028380:	00000097          	auipc	ra,0x0
    80028384:	c74080e7          	jalr	-908(ra) # 80027ff4 <sd_end_cmd>
	if (0x09 == result) {
    80028388:	47a5                	li	a5,9
    8002838a:	d8f489e3          	beq	s1,a5,8002811c <sdcard_init+0x86>
	else if (0x01 == result && 0x01 == (frame[2] & 0x0f) && 0xaa == frame[3]) {
    8002838e:	4785                	li	a5,1
    80028390:	00f49863          	bne	s1,a5,800283a0 <sdcard_init+0x30a>
    80028394:	fba44783          	lbu	a5,-70(s0)
    80028398:	8bbd                	andi	a5,a5,15
    8002839a:	4705                	li	a4,1
    8002839c:	d8e789e3          	beq	a5,a4,8002812e <sdcard_init+0x98>
	printf("verify_operation_condition() fail!\n");
    800283a0:	00004517          	auipc	a0,0x4
    800283a4:	58850513          	addi	a0,a0,1416 # 8002c928 <function_config+0x418>
    800283a8:	ffff8097          	auipc	ra,0xffff8
    800283ac:	de8080e7          	jalr	-536(ra) # 80020190 <printf>
	initsleeplock(&sdcard_lock, "sdcard");
    800283b0:	00004597          	auipc	a1,0x4
    800283b4:	66058593          	addi	a1,a1,1632 # 8002ca10 <function_config+0x500>
    800283b8:	0001d517          	auipc	a0,0x1d
    800283bc:	91050513          	addi	a0,a0,-1776 # 80044cc8 <sdcard_lock>
    800283c0:	ffffb097          	auipc	ra,0xffffb
    800283c4:	324080e7          	jalr	804(ra) # 800236e4 <initsleeplock>
		panic("sdcard_init failed");
    800283c8:	00004517          	auipc	a0,0x4
    800283cc:	65050513          	addi	a0,a0,1616 # 8002ca18 <function_config+0x508>
    800283d0:	ffff8097          	auipc	ra,0xffff8
    800283d4:	d76080e7          	jalr	-650(ra) # 80020146 <panic>

00000000800283d8 <sdcard_read_sector>:

void sdcard_read_sector(uint8 *buf, int sectorno) {
    800283d8:	7139                	addi	sp,sp,-64
    800283da:	fc06                	sd	ra,56(sp)
    800283dc:	f822                	sd	s0,48(sp)
    800283de:	f426                	sd	s1,40(sp)
    800283e0:	f04a                	sd	s2,32(sp)
    800283e2:	ec4e                	sd	s3,24(sp)
    800283e4:	0080                	addi	s0,sp,64
    800283e6:	89aa                	mv	s3,a0

	#ifdef DEBUG
	printf("sdcard_read_sector()\n");
	#endif

	if (is_standard_sd) {
    800283e8:	0001d797          	auipc	a5,0x1d
    800283ec:	91078793          	addi	a5,a5,-1776 # 80044cf8 <is_standard_sd>
    800283f0:	439c                	lw	a5,0(a5)
		address = sectorno << 9;
	}
	else {
		address = sectorno;
    800283f2:	0005849b          	sext.w	s1,a1
	if (is_standard_sd) {
    800283f6:	c399                	beqz	a5,800283fc <sdcard_read_sector+0x24>
		address = sectorno << 9;
    800283f8:	0095949b          	slliw	s1,a1,0x9
	}

	// enter critical section!
	acquiresleep(&sdcard_lock);
    800283fc:	0001d517          	auipc	a0,0x1d
    80028400:	8cc50513          	addi	a0,a0,-1844 # 80044cc8 <sdcard_lock>
    80028404:	ffffb097          	auipc	ra,0xffffb
    80028408:	31a080e7          	jalr	794(ra) # 8002371e <acquiresleep>

	sd_send_cmd(SD_CMD17, address, 0);
    8002840c:	4601                	li	a2,0
    8002840e:	85a6                	mv	a1,s1
    80028410:	4545                	li	a0,17
    80028412:	00000097          	auipc	ra,0x0
    80028416:	c2a080e7          	jalr	-982(ra) # 8002803c <sd_send_cmd>
	result = sd_get_response_R1();
    8002841a:	00000097          	auipc	ra,0x0
    8002841e:	b80080e7          	jalr	-1152(ra) # 80027f9a <sd_get_response_R1>
    80028422:	fca407a3          	sb	a0,-49(s0)

	if (0 != result) {
    80028426:	010004b7          	lui	s1,0x1000
    8002842a:	14f9                	addi	s1,s1,-2
	}

	int timeout = 0xffffff;
	while (--timeout) {
		sd_read_data(&result, 1);
		if (0xfe == result) break;
    8002842c:	0fe00913          	li	s2,254
	if (0 != result) {
    80028430:	e515                	bnez	a0,8002845c <sdcard_read_sector+0x84>
		sd_read_data(&result, 1);
    80028432:	4585                	li	a1,1
    80028434:	fcf40513          	addi	a0,s0,-49
    80028438:	00000097          	auipc	ra,0x0
    8002843c:	b1c080e7          	jalr	-1252(ra) # 80027f54 <sd_read_data>
		if (0xfe == result) break;
    80028440:	fcf44783          	lbu	a5,-49(s0)
    80028444:	03278c63          	beq	a5,s2,8002847c <sdcard_read_sector+0xa4>
    80028448:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    8002844a:	f4e5                	bnez	s1,80028432 <sdcard_read_sector+0x5a>
	}
	if (0 == timeout) {
		panic("sdcard: timeout waiting for reading");
    8002844c:	00004517          	auipc	a0,0x4
    80028450:	63450513          	addi	a0,a0,1588 # 8002ca80 <function_config+0x570>
    80028454:	ffff8097          	auipc	ra,0xffff8
    80028458:	cf2080e7          	jalr	-782(ra) # 80020146 <panic>
		releasesleep(&sdcard_lock);
    8002845c:	0001d517          	auipc	a0,0x1d
    80028460:	86c50513          	addi	a0,a0,-1940 # 80044cc8 <sdcard_lock>
    80028464:	ffffb097          	auipc	ra,0xffffb
    80028468:	310080e7          	jalr	784(ra) # 80023774 <releasesleep>
		panic("sdcard: fail to read");
    8002846c:	00004517          	auipc	a0,0x4
    80028470:	5fc50513          	addi	a0,a0,1532 # 8002ca68 <function_config+0x558>
    80028474:	ffff8097          	auipc	ra,0xffff8
    80028478:	cd2080e7          	jalr	-814(ra) # 80020146 <panic>
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    8002847c:	4701                	li	a4,0
    8002847e:	46a1                	li	a3,8
    80028480:	4601                	li	a2,0
    80028482:	4581                	li	a1,0
    80028484:	4501                	li	a0,0
    80028486:	fffff097          	auipc	ra,0xfffff
    8002848a:	af4080e7          	jalr	-1292(ra) # 80026f7a <spi_init>
	spi_receive_data_standard_dma(-1, DMAC_CHANNEL0, SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    8002848e:	20000893          	li	a7,512
    80028492:	884e                	mv	a6,s3
    80028494:	4781                	li	a5,0
    80028496:	4701                	li	a4,0
    80028498:	468d                	li	a3,3
    8002849a:	4601                	li	a2,0
    8002849c:	4581                	li	a1,0
    8002849e:	557d                	li	a0,-1
    800284a0:	fffff097          	auipc	ra,0xfffff
    800284a4:	2da080e7          	jalr	730(ra) # 8002777a <spi_receive_data_standard_dma>
	}
	sd_read_data_dma(buf, BSIZE);
	sd_read_data(dummy_crc, 2);
    800284a8:	4589                	li	a1,2
    800284aa:	fc840513          	addi	a0,s0,-56
    800284ae:	00000097          	auipc	ra,0x0
    800284b2:	aa6080e7          	jalr	-1370(ra) # 80027f54 <sd_read_data>

	sd_end_cmd();
    800284b6:	00000097          	auipc	ra,0x0
    800284ba:	b3e080e7          	jalr	-1218(ra) # 80027ff4 <sd_end_cmd>

	releasesleep(&sdcard_lock);
    800284be:	0001d517          	auipc	a0,0x1d
    800284c2:	80a50513          	addi	a0,a0,-2038 # 80044cc8 <sdcard_lock>
    800284c6:	ffffb097          	auipc	ra,0xffffb
    800284ca:	2ae080e7          	jalr	686(ra) # 80023774 <releasesleep>
	// leave critical section!
}
    800284ce:	70e2                	ld	ra,56(sp)
    800284d0:	7442                	ld	s0,48(sp)
    800284d2:	74a2                	ld	s1,40(sp)
    800284d4:	7902                	ld	s2,32(sp)
    800284d6:	69e2                	ld	s3,24(sp)
    800284d8:	6121                	addi	sp,sp,64
    800284da:	8082                	ret

00000000800284dc <sdcard_write_sector>:

void sdcard_write_sector(uint8 *buf, int sectorno) {
    800284dc:	7179                	addi	sp,sp,-48
    800284de:	f406                	sd	ra,40(sp)
    800284e0:	f022                	sd	s0,32(sp)
    800284e2:	ec26                	sd	s1,24(sp)
    800284e4:	e84a                	sd	s2,16(sp)
    800284e6:	1800                	addi	s0,sp,48
    800284e8:	892a                	mv	s2,a0
	uint32 address;
	static uint8 const START_BLOCK_TOKEN = 0xfe;
	uint8 dummy_crc[2] = {0xff, 0xff};
    800284ea:	57fd                	li	a5,-1
    800284ec:	fcf40c23          	sb	a5,-40(s0)
    800284f0:	fcf40ca3          	sb	a5,-39(s0)

	#ifdef DEBUG
	printf("sdcard_write_sector()\n");
	#endif

	if (is_standard_sd) {
    800284f4:	0001d797          	auipc	a5,0x1d
    800284f8:	80478793          	addi	a5,a5,-2044 # 80044cf8 <is_standard_sd>
    800284fc:	439c                	lw	a5,0(a5)
		address = sectorno << 9;
	}
	else {
		address = sectorno;
    800284fe:	0005849b          	sext.w	s1,a1
	if (is_standard_sd) {
    80028502:	c399                	beqz	a5,80028508 <sdcard_write_sector+0x2c>
		address = sectorno << 9;
    80028504:	0095949b          	slliw	s1,a1,0x9
	}

	// enter critical section!
	acquiresleep(&sdcard_lock);
    80028508:	0001c517          	auipc	a0,0x1c
    8002850c:	7c050513          	addi	a0,a0,1984 # 80044cc8 <sdcard_lock>
    80028510:	ffffb097          	auipc	ra,0xffffb
    80028514:	20e080e7          	jalr	526(ra) # 8002371e <acquiresleep>

	sd_send_cmd(SD_CMD24, address, 0);
    80028518:	4601                	li	a2,0
    8002851a:	85a6                	mv	a1,s1
    8002851c:	4561                	li	a0,24
    8002851e:	00000097          	auipc	ra,0x0
    80028522:	b1e080e7          	jalr	-1250(ra) # 8002803c <sd_send_cmd>
	if (0 != sd_get_response_R1()) {
    80028526:	00000097          	auipc	ra,0x0
    8002852a:	a74080e7          	jalr	-1420(ra) # 80027f9a <sd_get_response_R1>
    8002852e:	e559                	bnez	a0,800285bc <sdcard_write_sector+0xe0>
		releasesleep(&sdcard_lock);
		panic("sdcard: fail to write");
	}

	// sending data to be written 
	sd_write_data(&START_BLOCK_TOKEN, 1);
    80028530:	4585                	li	a1,1
    80028532:	00004517          	auipc	a0,0x4
    80028536:	77650513          	addi	a0,a0,1910 # 8002cca8 <START_BLOCK_TOKEN.2204>
    8002853a:	00000097          	auipc	ra,0x0
    8002853e:	9d4080e7          	jalr	-1580(ra) # 80027f0e <sd_write_data>
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80028542:	4701                	li	a4,0
    80028544:	46a1                	li	a3,8
    80028546:	4601                	li	a2,0
    80028548:	4581                	li	a1,0
    8002854a:	4501                	li	a0,0
    8002854c:	fffff097          	auipc	ra,0xfffff
    80028550:	a2e080e7          	jalr	-1490(ra) # 80026f7a <spi_init>
	spi_send_data_standard_dma(DMAC_CHANNEL0, SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    80028554:	20000813          	li	a6,512
    80028558:	87ca                	mv	a5,s2
    8002855a:	4701                	li	a4,0
    8002855c:	4681                	li	a3,0
    8002855e:	460d                	li	a2,3
    80028560:	4581                	li	a1,0
    80028562:	4501                	li	a0,0
    80028564:	fffff097          	auipc	ra,0xfffff
    80028568:	3c8080e7          	jalr	968(ra) # 8002792c <spi_send_data_standard_dma>
	sd_write_data_dma(buf, BSIZE);
	sd_write_data(dummy_crc, 2);
    8002856c:	4589                	li	a1,2
    8002856e:	fd840513          	addi	a0,s0,-40
    80028572:	00000097          	auipc	ra,0x0
    80028576:	99c080e7          	jalr	-1636(ra) # 80027f0e <sd_write_data>
    8002857a:	6485                	lui	s1,0x1
    8002857c:	14f9                	addi	s1,s1,-2
	// waiting for sdcard to finish programming 
	uint8 result;
	int timeout = 0xfff;
	while (--timeout) {
		sd_read_data(&result, 1);
		if (0x05 == (result & 0x1f)) {
    8002857e:	4915                	li	s2,5
		sd_read_data(&result, 1);
    80028580:	4585                	li	a1,1
    80028582:	fd740513          	addi	a0,s0,-41
    80028586:	00000097          	auipc	ra,0x0
    8002858a:	9ce080e7          	jalr	-1586(ra) # 80027f54 <sd_read_data>
		if (0x05 == (result & 0x1f)) {
    8002858e:	fd744783          	lbu	a5,-41(s0)
    80028592:	8bfd                	andi	a5,a5,31
    80028594:	05278463          	beq	a5,s2,800285dc <sdcard_write_sector+0x100>
    80028598:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    8002859a:	f0fd                	bnez	s1,80028580 <sdcard_write_sector+0xa4>
			break;
		}
	}
	if (0 == timeout) {
		releasesleep(&sdcard_lock);
    8002859c:	0001c517          	auipc	a0,0x1c
    800285a0:	72c50513          	addi	a0,a0,1836 # 80044cc8 <sdcard_lock>
    800285a4:	ffffb097          	auipc	ra,0xffffb
    800285a8:	1d0080e7          	jalr	464(ra) # 80023774 <releasesleep>
		panic("sdcard: invalid response token");
    800285ac:	00004517          	auipc	a0,0x4
    800285b0:	58450513          	addi	a0,a0,1412 # 8002cb30 <function_config+0x620>
    800285b4:	ffff8097          	auipc	ra,0xffff8
    800285b8:	b92080e7          	jalr	-1134(ra) # 80020146 <panic>
		releasesleep(&sdcard_lock);
    800285bc:	0001c517          	auipc	a0,0x1c
    800285c0:	70c50513          	addi	a0,a0,1804 # 80044cc8 <sdcard_lock>
    800285c4:	ffffb097          	auipc	ra,0xffffb
    800285c8:	1b0080e7          	jalr	432(ra) # 80023774 <releasesleep>
		panic("sdcard: fail to write");
    800285cc:	00004517          	auipc	a0,0x4
    800285d0:	4dc50513          	addi	a0,a0,1244 # 8002caa8 <function_config+0x598>
    800285d4:	ffff8097          	auipc	ra,0xffff8
    800285d8:	b72080e7          	jalr	-1166(ra) # 80020146 <panic>
    800285dc:	010004b7          	lui	s1,0x1000
    800285e0:	14fd                	addi	s1,s1,-1
    800285e2:	34fd                	addiw	s1,s1,-1
	}
	
	timeout = 0xffffff;
	while (--timeout) {
    800285e4:	c0f1                	beqz	s1,800286a8 <sdcard_write_sector+0x1cc>
		sd_read_data(&result, 1);
    800285e6:	4585                	li	a1,1
    800285e8:	fd740513          	addi	a0,s0,-41
    800285ec:	00000097          	auipc	ra,0x0
    800285f0:	968080e7          	jalr	-1688(ra) # 80027f54 <sd_read_data>
		if (0 != result) break;
    800285f4:	fd744783          	lbu	a5,-41(s0)
    800285f8:	d7ed                	beqz	a5,800285e2 <sdcard_write_sector+0x106>
	}
	if (0 == timeout) {
		releasesleep(&sdcard_lock);
		panic("sdcard: timeout waiting for response");
	}
	sd_end_cmd();
    800285fa:	00000097          	auipc	ra,0x0
    800285fe:	9fa080e7          	jalr	-1542(ra) # 80027ff4 <sd_end_cmd>

	// send SD_CMD13 to check if writing is correctly done 
	uint8 error_code = 0xff;
    80028602:	57fd                	li	a5,-1
    80028604:	fcf40b23          	sb	a5,-42(s0)
	sd_send_cmd(SD_CMD13, 0, 0);
    80028608:	4601                	li	a2,0
    8002860a:	4581                	li	a1,0
    8002860c:	4535                	li	a0,13
    8002860e:	00000097          	auipc	ra,0x0
    80028612:	a2e080e7          	jalr	-1490(ra) # 8002803c <sd_send_cmd>
	result = sd_get_response_R1();
    80028616:	00000097          	auipc	ra,0x0
    8002861a:	984080e7          	jalr	-1660(ra) # 80027f9a <sd_get_response_R1>
    8002861e:	fca40ba3          	sb	a0,-41(s0)
	sd_read_data(&error_code, 1);
    80028622:	4585                	li	a1,1
    80028624:	fd640513          	addi	a0,s0,-42
    80028628:	00000097          	auipc	ra,0x0
    8002862c:	92c080e7          	jalr	-1748(ra) # 80027f54 <sd_read_data>
	sd_end_cmd();
    80028630:	00000097          	auipc	ra,0x0
    80028634:	9c4080e7          	jalr	-1596(ra) # 80027ff4 <sd_end_cmd>
	if (0 != result || 0 != error_code) {
    80028638:	fd744783          	lbu	a5,-41(s0)
    8002863c:	fd644703          	lbu	a4,-42(s0)
    80028640:	8fd9                	or	a5,a5,a4
    80028642:	ef99                	bnez	a5,80028660 <sdcard_write_sector+0x184>
		printf("result: %x\n", result);
		printf("error_code: %x\n", error_code);
		panic("sdcard: an error occurs when writing");
	}

	releasesleep(&sdcard_lock);
    80028644:	0001c517          	auipc	a0,0x1c
    80028648:	68450513          	addi	a0,a0,1668 # 80044cc8 <sdcard_lock>
    8002864c:	ffffb097          	auipc	ra,0xffffb
    80028650:	128080e7          	jalr	296(ra) # 80023774 <releasesleep>
	// leave critical section!
}
    80028654:	70a2                	ld	ra,40(sp)
    80028656:	7402                	ld	s0,32(sp)
    80028658:	64e2                	ld	s1,24(sp)
    8002865a:	6942                	ld	s2,16(sp)
    8002865c:	6145                	addi	sp,sp,48
    8002865e:	8082                	ret
		releasesleep(&sdcard_lock);
    80028660:	0001c517          	auipc	a0,0x1c
    80028664:	66850513          	addi	a0,a0,1640 # 80044cc8 <sdcard_lock>
    80028668:	ffffb097          	auipc	ra,0xffffb
    8002866c:	10c080e7          	jalr	268(ra) # 80023774 <releasesleep>
		printf("result: %x\n", result);
    80028670:	fd744583          	lbu	a1,-41(s0)
    80028674:	00004517          	auipc	a0,0x4
    80028678:	44c50513          	addi	a0,a0,1100 # 8002cac0 <function_config+0x5b0>
    8002867c:	ffff8097          	auipc	ra,0xffff8
    80028680:	b14080e7          	jalr	-1260(ra) # 80020190 <printf>
		printf("error_code: %x\n", error_code);
    80028684:	fd644583          	lbu	a1,-42(s0)
    80028688:	00004517          	auipc	a0,0x4
    8002868c:	44850513          	addi	a0,a0,1096 # 8002cad0 <function_config+0x5c0>
    80028690:	ffff8097          	auipc	ra,0xffff8
    80028694:	b00080e7          	jalr	-1280(ra) # 80020190 <printf>
		panic("sdcard: an error occurs when writing");
    80028698:	00004517          	auipc	a0,0x4
    8002869c:	44850513          	addi	a0,a0,1096 # 8002cae0 <function_config+0x5d0>
    800286a0:	ffff8097          	auipc	ra,0xffff8
    800286a4:	aa6080e7          	jalr	-1370(ra) # 80020146 <panic>
		releasesleep(&sdcard_lock);
    800286a8:	0001c517          	auipc	a0,0x1c
    800286ac:	62050513          	addi	a0,a0,1568 # 80044cc8 <sdcard_lock>
    800286b0:	ffffb097          	auipc	ra,0xffffb
    800286b4:	0c4080e7          	jalr	196(ra) # 80023774 <releasesleep>
		panic("sdcard: timeout waiting for response");
    800286b8:	00004517          	auipc	a0,0x4
    800286bc:	45050513          	addi	a0,a0,1104 # 8002cb08 <function_config+0x5f8>
    800286c0:	ffff8097          	auipc	ra,0xffff8
    800286c4:	a86080e7          	jalr	-1402(ra) # 80020146 <panic>

00000000800286c8 <test_sdcard>:

// A simple test for sdcard read/write test 
void test_sdcard(void) {
    800286c8:	da010113          	addi	sp,sp,-608
    800286cc:	24113c23          	sd	ra,600(sp)
    800286d0:	24813823          	sd	s0,592(sp)
    800286d4:	24913423          	sd	s1,584(sp)
    800286d8:	25213023          	sd	s2,576(sp)
    800286dc:	23313c23          	sd	s3,568(sp)
    800286e0:	23413823          	sd	s4,560(sp)
    800286e4:	23513423          	sd	s5,552(sp)
    800286e8:	23613023          	sd	s6,544(sp)
    800286ec:	21713c23          	sd	s7,536(sp)
    800286f0:	21813823          	sd	s8,528(sp)
    800286f4:	21913423          	sd	s9,520(sp)
    800286f8:	21a13023          	sd	s10,512(sp)
    800286fc:	1480                	addi	s0,sp,608
	uint8 buf[BSIZE];

	for (int sec = 0; sec < 5; sec ++) {
    800286fe:	4c81                	li	s9,0
    80028700:	fa040993          	addi	s3,s0,-96
		for (int i = 0; i < BSIZE; i ++) {
			buf[i] = 0xaa;		// data to be written 
    80028704:	faa00b93          	li	s7,-86
		}

		sdcard_write_sector(buf, sec);

		for (int i = 0; i < BSIZE; i ++) {
			buf[i] = 0xff;		// fill in junk
    80028708:	5b7d                	li	s6,-1
		}

		sdcard_read_sector(buf, sec);
		for (int i = 0; i < BSIZE; i ++) {
    8002870a:	4d01                	li	s10,0
			if (0 == i % 16) {
				printf("\n");
    8002870c:	00004c17          	auipc	s8,0x4
    80028710:	accc0c13          	addi	s8,s8,-1332 # 8002c1d8 <syscalls+0x870>
			}

			printf("%x ", buf[i]);
    80028714:	00004a97          	auipc	s5,0x4
    80028718:	43ca8a93          	addi	s5,s5,1084 # 8002cb50 <function_config+0x640>
		for (int i = 0; i < BSIZE; i ++) {
    8002871c:	20000a13          	li	s4,512
    80028720:	a835                	j	8002875c <test_sdcard+0x94>
			printf("%x ", buf[i]);
    80028722:	00094583          	lbu	a1,0(s2)
    80028726:	8556                	mv	a0,s5
    80028728:	ffff8097          	auipc	ra,0xffff8
    8002872c:	a68080e7          	jalr	-1432(ra) # 80020190 <printf>
		for (int i = 0; i < BSIZE; i ++) {
    80028730:	2485                	addiw	s1,s1,1
    80028732:	0905                	addi	s2,s2,1
    80028734:	01448b63          	beq	s1,s4,8002874a <test_sdcard+0x82>
			if (0 == i % 16) {
    80028738:	00f4f793          	andi	a5,s1,15
    8002873c:	f3fd                	bnez	a5,80028722 <test_sdcard+0x5a>
				printf("\n");
    8002873e:	8562                	mv	a0,s8
    80028740:	ffff8097          	auipc	ra,0xffff8
    80028744:	a50080e7          	jalr	-1456(ra) # 80020190 <printf>
    80028748:	bfe9                	j	80028722 <test_sdcard+0x5a>
		}
		printf("\n");
    8002874a:	8562                	mv	a0,s8
    8002874c:	ffff8097          	auipc	ra,0xffff8
    80028750:	a44080e7          	jalr	-1468(ra) # 80020190 <printf>
	for (int sec = 0; sec < 5; sec ++) {
    80028754:	2c85                	addiw	s9,s9,1
    80028756:	4795                	li	a5,5
    80028758:	04fc8063          	beq	s9,a5,80028798 <test_sdcard+0xd0>
    8002875c:	da040913          	addi	s2,s0,-608
void test_sdcard(void) {
    80028760:	87ca                	mv	a5,s2
			buf[i] = 0xaa;		// data to be written 
    80028762:	01778023          	sb	s7,0(a5)
    80028766:	0785                	addi	a5,a5,1
		for (int i = 0; i < BSIZE; i ++) {
    80028768:	ff379de3          	bne	a5,s3,80028762 <test_sdcard+0x9a>
		sdcard_write_sector(buf, sec);
    8002876c:	85e6                	mv	a1,s9
    8002876e:	da040513          	addi	a0,s0,-608
    80028772:	00000097          	auipc	ra,0x0
    80028776:	d6a080e7          	jalr	-662(ra) # 800284dc <sdcard_write_sector>
    8002877a:	87ca                	mv	a5,s2
			buf[i] = 0xff;		// fill in junk
    8002877c:	01678023          	sb	s6,0(a5)
    80028780:	0785                	addi	a5,a5,1
		for (int i = 0; i < BSIZE; i ++) {
    80028782:	ff379de3          	bne	a5,s3,8002877c <test_sdcard+0xb4>
		sdcard_read_sector(buf, sec);
    80028786:	85e6                	mv	a1,s9
    80028788:	da040513          	addi	a0,s0,-608
    8002878c:	00000097          	auipc	ra,0x0
    80028790:	c4c080e7          	jalr	-948(ra) # 800283d8 <sdcard_read_sector>
		for (int i = 0; i < BSIZE; i ++) {
    80028794:	84ea                	mv	s1,s10
    80028796:	b74d                	j	80028738 <test_sdcard+0x70>
	}

	while (1) ;
    80028798:	a001                	j	80028798 <test_sdcard+0xd0>

000000008002879a <dmac_enable>:
{
    return dmac->channel[channel_num].axi_id;
}

static void dmac_enable(void)
{
    8002879a:	1141                	addi	sp,sp,-16
    8002879c:	e422                	sd	s0,8(sp)
    8002879e:	0800                	addi	s0,sp,16
    dmac_cfg_u_t dmac_cfg;

    dmac_cfg.data = readq(&dmac->cfg);
    800287a0:	3f500793          	li	a5,1013
    800287a4:	07f2                	slli	a5,a5,0x1c
    800287a6:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 1;
    dmac_cfg.cfg.int_en = 1;
    800287a8:	00376713          	ori	a4,a4,3
    writeq(dmac_cfg.data, &dmac->cfg);
    800287ac:	eb98                	sd	a4,16(a5)
}
    800287ae:	6422                	ld	s0,8(sp)
    800287b0:	0141                	addi	sp,sp,16
    800287b2:	8082                	ret

00000000800287b4 <dmac_read_id>:
{
    800287b4:	1141                	addi	sp,sp,-16
    800287b6:	e422                	sd	s0,8(sp)
    800287b8:	0800                	addi	s0,sp,16
    return dmac->id;
    800287ba:	3f500793          	li	a5,1013
    800287be:	07f2                	slli	a5,a5,0x1c
    800287c0:	6388                	ld	a0,0(a5)
}
    800287c2:	6422                	ld	s0,8(sp)
    800287c4:	0141                	addi	sp,sp,16
    800287c6:	8082                	ret

00000000800287c8 <dmac_read_version>:
{
    800287c8:	1141                	addi	sp,sp,-16
    800287ca:	e422                	sd	s0,8(sp)
    800287cc:	0800                	addi	s0,sp,16
    return dmac->compver;
    800287ce:	3f500793          	li	a5,1013
    800287d2:	07f2                	slli	a5,a5,0x1c
    800287d4:	6788                	ld	a0,8(a5)
}
    800287d6:	6422                	ld	s0,8(sp)
    800287d8:	0141                	addi	sp,sp,16
    800287da:	8082                	ret

00000000800287dc <dmac_read_channel_id>:
{
    800287dc:	1141                	addi	sp,sp,-16
    800287de:	e422                	sd	s0,8(sp)
    800287e0:	0800                	addi	s0,sp,16
    return dmac->channel[channel_num].axi_id;
    800287e2:	1502                	slli	a0,a0,0x20
    800287e4:	9101                	srli	a0,a0,0x20
    800287e6:	00851793          	slli	a5,a0,0x8
    800287ea:	3f500513          	li	a0,1013
    800287ee:	0572                	slli	a0,a0,0x1c
    800287f0:	953e                	add	a0,a0,a5
    800287f2:	15053503          	ld	a0,336(a0)
}
    800287f6:	6422                	ld	s0,8(sp)
    800287f8:	0141                	addi	sp,sp,16
    800287fa:	8082                	ret

00000000800287fc <dmac_disable>:

void dmac_disable(void)
{
    800287fc:	1141                	addi	sp,sp,-16
    800287fe:	e422                	sd	s0,8(sp)
    80028800:	0800                	addi	s0,sp,16
    dmac_cfg_u_t dmac_cfg;

    dmac_cfg.data = readq(&dmac->cfg);
    80028802:	3f500793          	li	a5,1013
    80028806:	07f2                	slli	a5,a5,0x1c
    80028808:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 0;
    dmac_cfg.cfg.int_en = 0;
    8002880a:	9b71                	andi	a4,a4,-4
    writeq(dmac_cfg.data, &dmac->cfg);
    8002880c:	eb98                	sd	a4,16(a5)
}
    8002880e:	6422                	ld	s0,8(sp)
    80028810:	0141                	addi	sp,sp,16
    80028812:	8082                	ret

0000000080028814 <dmac_channel_enable>:

void dmac_channel_enable(dmac_channel_number_t channel_num)
{
    80028814:	1141                	addi	sp,sp,-16
    80028816:	e422                	sd	s0,8(sp)
    80028818:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;

    chen.data = readq(&dmac->chen);
    8002881a:	3f500793          	li	a5,1013
    8002881e:	07f2                	slli	a5,a5,0x1c
    80028820:	6f9c                	ld	a5,24(a5)

    switch(channel_num)
    80028822:	4715                	li	a4,5
    80028824:	00a76d63          	bltu	a4,a0,8002883e <dmac_channel_enable+0x2a>
    80028828:	050a                	slli	a0,a0,0x2
    8002882a:	00004697          	auipc	a3,0x4
    8002882e:	32e68693          	addi	a3,a3,814 # 8002cb58 <function_config+0x648>
    80028832:	9536                	add	a0,a0,a3
    80028834:	4118                	lw	a4,0(a0)
    80028836:	9736                	add	a4,a4,a3
    80028838:	8702                	jr	a4
    {
        case DMAC_CHANNEL0:
            chen.dmac_chen.ch1_en = 1;
            chen.dmac_chen.ch1_en_we = 1;
    8002883a:	1017e793          	ori	a5,a5,257
            break;
        default:
            break;
    }

    writeq(chen.data, &dmac->chen);
    8002883e:	3f500713          	li	a4,1013
    80028842:	0772                	slli	a4,a4,0x1c
    80028844:	ef1c                	sd	a5,24(a4)
}
    80028846:	6422                	ld	s0,8(sp)
    80028848:	0141                	addi	sp,sp,16
    8002884a:	8082                	ret
            chen.dmac_chen.ch2_en_we = 1;
    8002884c:	2027e793          	ori	a5,a5,514
            break;
    80028850:	b7fd                	j	8002883e <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch3_en_we = 1;
    80028852:	4047e793          	ori	a5,a5,1028
            break;
    80028856:	b7e5                	j	8002883e <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch4_en = 1;
    80028858:	0087e793          	ori	a5,a5,8
            chen.dmac_chen.ch4_en_we = 1;
    8002885c:	6705                	lui	a4,0x1
    8002885e:	80070713          	addi	a4,a4,-2048 # 800 <BASE_ADDRESS-0x8001f800>
    80028862:	8fd9                	or	a5,a5,a4
            break;
    80028864:	bfe9                	j	8002883e <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch5_en = 1;
    80028866:	0107e793          	ori	a5,a5,16
            chen.dmac_chen.ch5_en_we = 1;
    8002886a:	6705                	lui	a4,0x1
    8002886c:	8fd9                	or	a5,a5,a4
            break;
    8002886e:	bfc1                	j	8002883e <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch6_en = 1;
    80028870:	0207e793          	ori	a5,a5,32
            chen.dmac_chen.ch6_en_we = 1;
    80028874:	6709                	lui	a4,0x2
    80028876:	8fd9                	or	a5,a5,a4
            break;
    80028878:	b7d9                	j	8002883e <dmac_channel_enable+0x2a>

000000008002887a <dmac_channel_disable>:

void dmac_channel_disable(dmac_channel_number_t channel_num)
{
    8002887a:	1141                	addi	sp,sp,-16
    8002887c:	e422                	sd	s0,8(sp)
    8002887e:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;

    chen.data = readq(&dmac->chen);
    80028880:	3f500793          	li	a5,1013
    80028884:	07f2                	slli	a5,a5,0x1c
    80028886:	6f9c                	ld	a5,24(a5)

    switch(channel_num)
    80028888:	4715                	li	a4,5
    8002888a:	00a76e63          	bltu	a4,a0,800288a6 <dmac_channel_disable+0x2c>
    8002888e:	050a                	slli	a0,a0,0x2
    80028890:	00004697          	auipc	a3,0x4
    80028894:	2e068693          	addi	a3,a3,736 # 8002cb70 <function_config+0x660>
    80028898:	9536                	add	a0,a0,a3
    8002889a:	4118                	lw	a4,0(a0)
    8002889c:	9736                	add	a4,a4,a3
    8002889e:	8702                	jr	a4
    {
        case DMAC_CHANNEL0:
            chen.dmac_chen.ch1_en = 0;
    800288a0:	9bf9                	andi	a5,a5,-2
            chen.dmac_chen.ch1_en_we = 1;
    800288a2:	1007e793          	ori	a5,a5,256
            break;
        default:
            break;
    }

    writeq(chen.data, &dmac->chen);
    800288a6:	3f500713          	li	a4,1013
    800288aa:	0772                	slli	a4,a4,0x1c
    800288ac:	ef1c                	sd	a5,24(a4)
}
    800288ae:	6422                	ld	s0,8(sp)
    800288b0:	0141                	addi	sp,sp,16
    800288b2:	8082                	ret
            chen.dmac_chen.ch2_en = 0;
    800288b4:	9bf5                	andi	a5,a5,-3
            chen.dmac_chen.ch2_en_we = 1;
    800288b6:	2007e793          	ori	a5,a5,512
            break;
    800288ba:	b7f5                	j	800288a6 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch3_en = 0;
    800288bc:	9bed                	andi	a5,a5,-5
            chen.dmac_chen.ch3_en_we = 1;
    800288be:	4007e793          	ori	a5,a5,1024
            break;
    800288c2:	b7d5                	j	800288a6 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch4_en = 0;
    800288c4:	9bdd                	andi	a5,a5,-9
            chen.dmac_chen.ch4_en_we = 1;
    800288c6:	6705                	lui	a4,0x1
    800288c8:	80070713          	addi	a4,a4,-2048 # 800 <BASE_ADDRESS-0x8001f800>
    800288cc:	8fd9                	or	a5,a5,a4
            break;
    800288ce:	bfe1                	j	800288a6 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch5_en = 0;
    800288d0:	9bbd                	andi	a5,a5,-17
            chen.dmac_chen.ch5_en_we = 1;
    800288d2:	6705                	lui	a4,0x1
    800288d4:	8fd9                	or	a5,a5,a4
            break;
    800288d6:	bfc1                	j	800288a6 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch6_en = 0;
    800288d8:	fdf7f793          	andi	a5,a5,-33
            chen.dmac_chen.ch6_en_we = 1;
    800288dc:	6709                	lui	a4,0x2
    800288de:	8fd9                	or	a5,a5,a4
            break;
    800288e0:	b7d9                	j	800288a6 <dmac_channel_disable+0x2c>

00000000800288e2 <dmac_enable_common_interrupt_status>:

void dmac_enable_common_interrupt_status(void)
{
    800288e2:	1141                	addi	sp,sp,-16
    800288e4:	e422                	sd	s0,8(sp)
    800288e6:	0800                	addi	s0,sp,16
    dmac_commonreg_intstatus_enable_u_t intstatus;

    intstatus.data = readq(&dmac->com_intstatus_en);
    800288e8:	3f500793          	li	a5,1013
    800288ec:	07f2                	slli	a5,a5,0x1c
    800288ee:	63b8                	ld	a4,64(a5)
    intstatus.intstatus_enable.enable_slvif_dec_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_wr2ro_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_rd2wo_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_wronhold_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_undefinedreg_dec_err_intstat = 1;
    800288f0:	10f76713          	ori	a4,a4,271

    writeq(intstatus.data, &dmac->com_intstatus_en);
    800288f4:	e3b8                	sd	a4,64(a5)
}
    800288f6:	6422                	ld	s0,8(sp)
    800288f8:	0141                	addi	sp,sp,16
    800288fa:	8082                	ret

00000000800288fc <dmac_enable_common_interrupt_signal>:

void dmac_enable_common_interrupt_signal(void)
{
    800288fc:	1141                	addi	sp,sp,-16
    800288fe:	e422                	sd	s0,8(sp)
    80028900:	0800                	addi	s0,sp,16
    dmac_commonreg_intsignal_enable_u_t intsignal;

    intsignal.data = readq(&dmac->com_intsignal_en);
    80028902:	3f500793          	li	a5,1013
    80028906:	07f2                	slli	a5,a5,0x1c
    80028908:	67b8                	ld	a4,72(a5)
    intsignal.intsignal_enable.enable_slvif_dec_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_wr2ro_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_rd2wo_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_wronhold_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_undefinedreg_dec_err_intsignal = 1;
    8002890a:	10f76713          	ori	a4,a4,271

    writeq(intsignal.data, &dmac->com_intsignal_en);
    8002890e:	e7b8                	sd	a4,72(a5)
}
    80028910:	6422                	ld	s0,8(sp)
    80028912:	0141                	addi	sp,sp,16
    80028914:	8082                	ret

0000000080028916 <dmac_disable_channel_interrupt>:
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    writeq(0x2, &dmac->channel[channel_num].intstatus_en);
}

void dmac_disable_channel_interrupt(dmac_channel_number_t channel_num)
{
    80028916:	1141                	addi	sp,sp,-16
    80028918:	e422                	sd	s0,8(sp)
    8002891a:	0800                	addi	s0,sp,16
    writeq(0, &dmac->channel[channel_num].intstatus_en);
    8002891c:	1502                	slli	a0,a0,0x20
    8002891e:	9101                	srli	a0,a0,0x20
    80028920:	00851793          	slli	a5,a0,0x8
    80028924:	3f500513          	li	a0,1013
    80028928:	0572                	slli	a0,a0,0x1c
    8002892a:	953e                	add	a0,a0,a5
    8002892c:	18053023          	sd	zero,384(a0)
}
    80028930:	6422                	ld	s0,8(sp)
    80028932:	0141                	addi	sp,sp,16
    80028934:	8082                	ret

0000000080028936 <dmac_set_channel_param>:
int dmac_set_channel_param(dmac_channel_number_t channel_num,
                           const void *src, void *dest, dmac_address_increment_t src_inc, dmac_address_increment_t dest_inc,
                           dmac_burst_trans_length_t dmac_burst_size,
                           dmac_transfer_width_t dmac_trans_width,
                           uint32 blockSize)
{
    80028936:	1141                	addi	sp,sp,-16
    80028938:	e422                	sd	s0,8(sp)
    8002893a:	0800                	addi	s0,sp,16
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    8002893c:	80000e37          	lui	t3,0x80000
    80028940:	9e2e                	add	t3,t3,a1
    80028942:	00600337          	lui	t1,0x600
    80028946:	046e6663          	bltu	t3,t1,80028992 <dmac_set_channel_param+0x5c>
    8002894a:	c0000337          	lui	t1,0xc0000
    8002894e:	932e                	add	t1,t1,a1
    80028950:	00800e37          	lui	t3,0x800
    80028954:	03c36f63          	bltu	t1,t3,80028992 <dmac_set_channel_param+0x5c>
    80028958:	afbb02b7          	lui	t0,0xafbb0
    8002895c:	fc028293          	addi	t0,t0,-64 # ffffffffafbaffc0 <kernel_end+0xffffffff2fb6afc0>
    80028960:	92ae                	add	t0,t0,a1
    80028962:	0012b293          	seqz	t0,t0
    dmac_ch_ctl_u_t ctl;
    dmac_ch_cfg_u_t cfg_u;

    int mem_type_src = is_memory((uintptr_t)src), mem_type_dest = is_memory((uintptr_t)dest);
    80028966:	8fb2                	mv	t6,a2
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028968:	80000337          	lui	t1,0x80000
    8002896c:	9332                	add	t1,t1,a2
    8002896e:	00600e37          	lui	t3,0x600
    80028972:	4f05                	li	t5,1
    80028974:	03c37863          	bgeu	t1,t3,800289a4 <dmac_set_channel_param+0x6e>
    {
        flow_control = DMAC_PRF2PRF_DMA;
    } else if(mem_type_src == 1 && mem_type_dest == 0)
        flow_control = DMAC_MEM2PRF_DMA;
    else if(mem_type_src == 0 && mem_type_dest == 1)
        flow_control = DMAC_PRF2MEM_DMA;
    80028978:	4309                	li	t1,2
    } else if(mem_type_src == 1 && mem_type_dest == 0)
    8002897a:	04028963          	beqz	t0,800289cc <dmac_set_channel_param+0x96>
    8002897e:	a039                	j	8002898c <dmac_set_channel_param+0x56>
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028980:	8f32                	mv	t5,a2
    80028982:	bfdd                	j	80028978 <dmac_set_channel_param+0x42>
    80028984:	4f05                	li	t5,1
    80028986:	bfcd                	j	80028978 <dmac_set_channel_param+0x42>
    80028988:	4f05                	li	t5,1
    8002898a:	4285                	li	t0,1
        flow_control = DMAC_PRF2PRF_DMA;
    8002898c:	001f3313          	seqz	t1,t5
    80028990:	a835                	j	800289cc <dmac_set_channel_param+0x96>
    int mem_type_src = is_memory((uintptr_t)src), mem_type_dest = is_memory((uintptr_t)dest);
    80028992:	8fb2                	mv	t6,a2
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028994:	80000337          	lui	t1,0x80000
    80028998:	9332                	add	t1,t1,a2
    8002899a:	00600e37          	lui	t3,0x600
    8002899e:	4285                	li	t0,1
    800289a0:	ffc364e3          	bltu	t1,t3,80028988 <dmac_set_channel_param+0x52>
    800289a4:	c0000337          	lui	t1,0xc0000
    800289a8:	937e                	add	t1,t1,t6
    800289aa:	00800e37          	lui	t3,0x800
    800289ae:	fdc36be3          	bltu	t1,t3,80028984 <dmac_set_channel_param+0x4e>
    800289b2:	afbb0337          	lui	t1,0xafbb0
    800289b6:	fc030313          	addi	t1,t1,-64 # ffffffffafbaffc0 <kernel_end+0xffffffff2fb6afc0>
    800289ba:	961a                	add	a2,a2,t1
    800289bc:	00163613          	seqz	a2,a2
    if(mem_type_src == 0 && mem_type_dest == 0)
    800289c0:	00566f33          	or	t5,a2,t0
    800289c4:	2f01                	sext.w	t5,t5
        flow_control = DMAC_PRF2PRF_DMA;
    800289c6:	430d                	li	t1,3
    if(mem_type_src == 0 && mem_type_dest == 0)
    800289c8:	fa0f1ce3          	bnez	t5,80028980 <dmac_set_channel_param+0x4a>

    /**
     * cfg register must configure before ts_block and
     * sar dar register
     */
    cfg_u.data = readq(&dmac->channel[channel_num].cfg);
    800289cc:	02051e93          	slli	t4,a0,0x20
    800289d0:	020ede93          	srli	t4,t4,0x20
    800289d4:	008e9613          	slli	a2,t4,0x8
    800289d8:	3f500e93          	li	t4,1013
    800289dc:	0ef2                	slli	t4,t4,0x1c
    800289de:	9eb2                	add	t4,t4,a2
    800289e0:	120ebe03          	ld	t3,288(t4)

    cfg_u.ch_cfg.tt_fc = flow_control;
    800289e4:	02031613          	slli	a2,t1,0x20
    800289e8:	5365                	li	t1,-7
    800289ea:	1302                	slli	t1,t1,0x20
    800289ec:	137d                	addi	t1,t1,-1
    800289ee:	006e7333          	and	t1,t3,t1
    800289f2:	00c36333          	or	t1,t1,a2
    cfg_u.ch_cfg.hs_sel_src = mem_type_src ? DMAC_HS_SOFTWARE : DMAC_HS_HARDWARE;
    800289f6:	128e                	slli	t0,t0,0x23
    800289f8:	567d                	li	a2,-1
    800289fa:	02361e13          	slli	t3,a2,0x23
    800289fe:	1e7d                	addi	t3,t3,-1
    80028a00:	01c37333          	and	t1,t1,t3
    80028a04:	00536333          	or	t1,t1,t0
    cfg_u.ch_cfg.hs_sel_dst = mem_type_dest ? DMAC_HS_SOFTWARE : DMAC_HS_HARDWARE;
    80028a08:	01e03f33          	snez	t5,t5
    80028a0c:	1f12                	slli	t5,t5,0x24
    80028a0e:	1612                	slli	a2,a2,0x24
    80028a10:	167d                	addi	a2,a2,-1
    80028a12:	00c37333          	and	t1,t1,a2
    80028a16:	01e36333          	or	t1,t1,t5
    cfg_u.ch_cfg.src_per = channel_num;
    80028a1a:	893d                	andi	a0,a0,15
    80028a1c:	02751f13          	slli	t5,a0,0x27
    80028a20:	5645                	li	a2,-15
    80028a22:	02761e13          	slli	t3,a2,0x27
    80028a26:	1e7d                	addi	t3,t3,-1
    80028a28:	01c37333          	and	t1,t1,t3
    80028a2c:	01e36333          	or	t1,t1,t5
    cfg_u.ch_cfg.dst_per = channel_num;
    80028a30:	02c51e13          	slli	t3,a0,0x2c
    80028a34:	02c61513          	slli	a0,a2,0x2c
    80028a38:	157d                	addi	a0,a0,-1
    80028a3a:	00a37533          	and	a0,t1,a0
    80028a3e:	01c56533          	or	a0,a0,t3
    cfg_u.ch_cfg.src_multblk_type = 0;
    cfg_u.ch_cfg.dst_multblk_type = 0;
    80028a42:	9941                	andi	a0,a0,-16

    writeq(cfg_u.data, &dmac->channel[channel_num].cfg);
    80028a44:	12aeb023          	sd	a0,288(t4)

    dmac->channel[channel_num].sar = (uint64)src;
    80028a48:	10beb023          	sd	a1,256(t4)
    dmac->channel[channel_num].dar = (uint64)dest;
    80028a4c:	11feb423          	sd	t6,264(t4)

    ctl.data = readq(&dmac->channel[channel_num].ctl);
    80028a50:	118eb603          	ld	a2,280(t4)
    ctl.ch_ctl.sms = DMAC_MASTER1;
    ctl.ch_ctl.dms = DMAC_MASTER2;
    80028a54:	9a39                	andi	a2,a2,-18
    /* master select */
    ctl.ch_ctl.sinc = src_inc;
    80028a56:	8a85                	andi	a3,a3,1
    80028a58:	0692                	slli	a3,a3,0x4
    80028a5a:	00466613          	ori	a2,a2,4
    80028a5e:	8e55                	or	a2,a2,a3
    ctl.ch_ctl.dinc = dest_inc;
    80028a60:	8b05                	andi	a4,a4,1
    80028a62:	071a                	slli	a4,a4,0x6
    80028a64:	8be67613          	andi	a2,a2,-1858
    /* address incrememt */
    ctl.ch_ctl.src_tr_width = dmac_trans_width;
    80028a68:	00787813          	andi	a6,a6,7
    80028a6c:	00881693          	slli	a3,a6,0x8
    80028a70:	8e59                	or	a2,a2,a4
    80028a72:	8e55                	or	a2,a2,a3
    ctl.ch_ctl.dst_tr_width = dmac_trans_width;
    80028a74:	082e                	slli	a6,a6,0xb
    80028a76:	7771                	lui	a4,0xffffc
    80028a78:	7ff70713          	addi	a4,a4,2047 # ffffffffffffc7ff <kernel_end+0xffffffff7ffb77ff>
    80028a7c:	8e79                	and	a2,a2,a4
    80028a7e:	01066633          	or	a2,a2,a6
    /* transfer width */
    ctl.ch_ctl.src_msize = dmac_burst_size;
    80028a82:	00f7f713          	andi	a4,a5,15
    80028a86:	00e71693          	slli	a3,a4,0xe
    80028a8a:	fffc47b7          	lui	a5,0xfffc4
    80028a8e:	17fd                	addi	a5,a5,-1
    80028a90:	8ff1                	and	a5,a5,a2
    80028a92:	8fd5                	or	a5,a5,a3
    ctl.ch_ctl.dst_msize = dmac_burst_size;
    80028a94:	074a                	slli	a4,a4,0x12
    80028a96:	ffc40637          	lui	a2,0xffc40
    80028a9a:	167d                	addi	a2,a2,-1
    80028a9c:	8ff1                	and	a5,a5,a2
    80028a9e:	8fd9                	or	a5,a5,a4

    writeq(ctl.data, &dmac->channel[channel_num].ctl);
    80028aa0:	10febc23          	sd	a5,280(t4)

    writeq(blockSize - 1, &dmac->channel[channel_num].block_ts);
    80028aa4:	38fd                	addiw	a7,a7,-1
    80028aa6:	1882                	slli	a7,a7,0x20
    80028aa8:	0208d893          	srli	a7,a7,0x20
    80028aac:	111eb823          	sd	a7,272(t4)
    /*the number of (blcok_ts +1) data of width SRC_TR_WIDTF to be */
    /* transferred in a dma block transfer */
    return 0;
}
    80028ab0:	4501                	li	a0,0
    80028ab2:	6422                	ld	s0,8(sp)
    80028ab4:	0141                	addi	sp,sp,16
    80028ab6:	8082                	ret

0000000080028ab8 <dmac_init>:

void dmac_init(void)
{
    80028ab8:	1141                	addi	sp,sp,-16
    80028aba:	e406                	sd	ra,8(sp)
    80028abc:	e022                	sd	s0,0(sp)
    80028abe:	0800                	addi	s0,sp,16
    uint64 tmp;
    dmac_commonreg_intclear_u_t intclear;
    dmac_cfg_u_t dmac_cfg;
    dmac_reset_u_t dmac_reset;

    sysctl_clock_enable(SYSCTL_CLOCK_DMA);
    80028ac0:	4529                	li	a0,10
    80028ac2:	00000097          	auipc	ra,0x0
    80028ac6:	220080e7          	jalr	544(ra) # 80028ce2 <sysctl_clock_enable>
    // printf("[dmac_init] dma clk=%d\n", sysctl_clock_get_freq(SYSCTL_CLOCK_DMA));

    dmac_reset.data = readq(&dmac->reset);
    80028aca:	3f500793          	li	a5,1013
    80028ace:	07f2                	slli	a5,a5,0x1c
    80028ad0:	6fb8                	ld	a4,88(a5)
    dmac_reset.reset.rst = 1;
    80028ad2:	00176713          	ori	a4,a4,1
    writeq(dmac_reset.data, &dmac->reset);
    80028ad6:	efb8                	sd	a4,88(a5)
    while(dmac_reset.reset.rst)
        dmac_reset.data = readq(&dmac->reset);
    80028ad8:	873e                	mv	a4,a5
    80028ada:	6f3c                	ld	a5,88(a4)
    while(dmac_reset.reset.rst)
    80028adc:	8b85                	andi	a5,a5,1
    80028ade:	fff5                	bnez	a5,80028ada <dmac_init+0x22>

    /*reset dmac */

    intclear.data = readq(&dmac->com_intclear);
    80028ae0:	3f500793          	li	a5,1013
    80028ae4:	07f2                	slli	a5,a5,0x1c
    80028ae6:	7f98                	ld	a4,56(a5)
    intclear.com_intclear.clear_slvif_dec_err_intstat = 1;
    intclear.com_intclear.clear_slvif_wr2ro_err_intstat = 1;
    intclear.com_intclear.clear_slvif_rd2wo_err_intstat = 1;
    intclear.com_intclear.clear_slvif_wronhold_err_intstat = 1;
    intclear.com_intclear.clear_slvif_undefinedreg_dec_err_intstat = 1;
    80028ae8:	10f76713          	ori	a4,a4,271
    writeq(intclear.data, &dmac->com_intclear);
    80028aec:	ff98                	sd	a4,56(a5)
    /* clear common register interrupt */

    dmac_cfg.data = readq(&dmac->cfg);
    80028aee:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 0;
    dmac_cfg.cfg.int_en = 0;
    80028af0:	9b71                	andi	a4,a4,-4
    writeq(dmac_cfg.data, &dmac->cfg);
    80028af2:	eb98                	sd	a4,16(a5)
    /* disable dmac and disable interrupt */

    while(readq(&dmac->cfg))
    80028af4:	873e                	mv	a4,a5
    80028af6:	6b1c                	ld	a5,16(a4)
    80028af8:	fffd                	bnez	a5,80028af6 <dmac_init+0x3e>
        ;
    tmp = readq(&dmac->chen);
    80028afa:	3f500793          	li	a5,1013
    80028afe:	07f2                	slli	a5,a5,0x1c
    80028b00:	6f98                	ld	a4,24(a5)
    tmp &= ~0xf;
    80028b02:	9b41                	andi	a4,a4,-16
    writeq(tmp, &dmac->chen);
    80028b04:	ef98                	sd	a4,24(a5)
    /* disable all channel before configure */
    dmac_enable();
    80028b06:	00000097          	auipc	ra,0x0
    80028b0a:	c94080e7          	jalr	-876(ra) # 8002879a <dmac_enable>
}
    80028b0e:	60a2                	ld	ra,8(sp)
    80028b10:	6402                	ld	s0,0(sp)
    80028b12:	0141                	addi	sp,sp,16
    80028b14:	8082                	ret

0000000080028b16 <dmac_is_done>:
    dmac_enable_channel_interrupt(channel_num);
    dmac_channel_enable(channel_num);
}

int dmac_is_done(dmac_channel_number_t channel_num)
{
    80028b16:	1141                	addi	sp,sp,-16
    80028b18:	e422                	sd	s0,8(sp)
    80028b1a:	0800                	addi	s0,sp,16
    if(readq(&dmac->channel[channel_num].intstatus) & 0x2)
    80028b1c:	1502                	slli	a0,a0,0x20
    80028b1e:	9101                	srli	a0,a0,0x20
    80028b20:	00851793          	slli	a5,a0,0x8
    80028b24:	3f500513          	li	a0,1013
    80028b28:	0572                	slli	a0,a0,0x1c
    80028b2a:	953e                	add	a0,a0,a5
    80028b2c:	18853503          	ld	a0,392(a0)
    80028b30:	8105                	srli	a0,a0,0x1
        return 1;
    else
        return 0;
}
    80028b32:	8905                	andi	a0,a0,1
    80028b34:	6422                	ld	s0,8(sp)
    80028b36:	0141                	addi	sp,sp,16
    80028b38:	8082                	ret

0000000080028b3a <dmac_is_idle>:
{
    dmac_wait_idle(channel_num);
}

int dmac_is_idle(dmac_channel_number_t channel_num)
{
    80028b3a:	1141                	addi	sp,sp,-16
    80028b3c:	e422                	sd	s0,8(sp)
    80028b3e:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;
    chen.data = readq(&dmac->chen);
    80028b40:	3f500793          	li	a5,1013
    80028b44:	07f2                	slli	a5,a5,0x1c
    80028b46:	6f9c                	ld	a5,24(a5)
    if((chen.data >> channel_num) & 0x1UL)
    80028b48:	00a7d533          	srl	a0,a5,a0
    80028b4c:	00154513          	xori	a0,a0,1
        return 0;
    else
        return 1;
}
    80028b50:	8905                	andi	a0,a0,1
    80028b52:	6422                	ld	s0,8(sp)
    80028b54:	0141                	addi	sp,sp,16
    80028b56:	8082                	ret

0000000080028b58 <dmac_wait_idle>:

static void *dmac_chan = (void *) DMAC_V;

void dmac_wait_idle(dmac_channel_number_t channel_num)
{
    80028b58:	1101                	addi	sp,sp,-32
    80028b5a:	ec06                	sd	ra,24(sp)
    80028b5c:	e822                	sd	s0,16(sp)
    80028b5e:	e426                	sd	s1,8(sp)
    80028b60:	e04a                	sd	s2,0(sp)
    80028b62:	1000                	addi	s0,sp,32
    80028b64:	892a                	mv	s2,a0
    while(!dmac_is_idle(channel_num)) {
        acquire(&myproc()->lock);
        sleep(dmac_chan, &myproc()->lock);
    80028b66:	3f500493          	li	s1,1013
    80028b6a:	04f2                	slli	s1,s1,0x1c
    while(!dmac_is_idle(channel_num)) {
    80028b6c:	854a                	mv	a0,s2
    80028b6e:	00000097          	auipc	ra,0x0
    80028b72:	fcc080e7          	jalr	-52(ra) # 80028b3a <dmac_is_idle>
    80028b76:	ed05                	bnez	a0,80028bae <dmac_wait_idle+0x56>
        acquire(&myproc()->lock);
    80028b78:	ffff9097          	auipc	ra,0xffff9
    80028b7c:	fda080e7          	jalr	-38(ra) # 80021b52 <myproc>
    80028b80:	ffff8097          	auipc	ra,0xffff8
    80028b84:	b40080e7          	jalr	-1216(ra) # 800206c0 <acquire>
        sleep(dmac_chan, &myproc()->lock);
    80028b88:	ffff9097          	auipc	ra,0xffff9
    80028b8c:	fca080e7          	jalr	-54(ra) # 80021b52 <myproc>
    80028b90:	85aa                	mv	a1,a0
    80028b92:	8526                	mv	a0,s1
    80028b94:	ffffa097          	auipc	ra,0xffffa
    80028b98:	840080e7          	jalr	-1984(ra) # 800223d4 <sleep>
        release(&myproc()->lock);
    80028b9c:	ffff9097          	auipc	ra,0xffff9
    80028ba0:	fb6080e7          	jalr	-74(ra) # 80021b52 <myproc>
    80028ba4:	ffff8097          	auipc	ra,0xffff8
    80028ba8:	b70080e7          	jalr	-1168(ra) # 80020714 <release>
    80028bac:	b7c1                	j	80028b6c <dmac_wait_idle+0x14>
    }
}
    80028bae:	60e2                	ld	ra,24(sp)
    80028bb0:	6442                	ld	s0,16(sp)
    80028bb2:	64a2                	ld	s1,8(sp)
    80028bb4:	6902                	ld	s2,0(sp)
    80028bb6:	6105                	addi	sp,sp,32
    80028bb8:	8082                	ret

0000000080028bba <dmac_set_single_mode>:
{
    80028bba:	711d                	addi	sp,sp,-96
    80028bbc:	ec86                	sd	ra,88(sp)
    80028bbe:	e8a2                	sd	s0,80(sp)
    80028bc0:	e4a6                	sd	s1,72(sp)
    80028bc2:	e0ca                	sd	s2,64(sp)
    80028bc4:	fc4e                	sd	s3,56(sp)
    80028bc6:	f852                	sd	s4,48(sp)
    80028bc8:	f456                	sd	s5,40(sp)
    80028bca:	f05a                	sd	s6,32(sp)
    80028bcc:	ec5e                	sd	s7,24(sp)
    80028bce:	e862                	sd	s8,16(sp)
    80028bd0:	e466                	sd	s9,8(sp)
    80028bd2:	e06a                	sd	s10,0(sp)
    80028bd4:	1080                	addi	s0,sp,96
    80028bd6:	892a                	mv	s2,a0
    80028bd8:	8a2e                	mv	s4,a1
    80028bda:	8ab2                	mv	s5,a2
    80028bdc:	8b36                	mv	s6,a3
    80028bde:	8bba                	mv	s7,a4
    80028be0:	8c3e                	mv	s8,a5
    80028be2:	8cc2                	mv	s9,a6
    80028be4:	8d46                	mv	s10,a7
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028be6:	02051493          	slli	s1,a0,0x20
    80028bea:	9081                	srli	s1,s1,0x20
    80028bec:	00849793          	slli	a5,s1,0x8
    80028bf0:	3f500493          	li	s1,1013
    80028bf4:	04f2                	slli	s1,s1,0x1c
    80028bf6:	94be                	add	s1,s1,a5
    80028bf8:	59fd                	li	s3,-1
    80028bfa:	0209d993          	srli	s3,s3,0x20
    80028bfe:	1934bc23          	sd	s3,408(s1) # 1000198 <BASE_ADDRESS-0x7f01fe68>
    dmac_channel_disable(channel_num);
    80028c02:	00000097          	auipc	ra,0x0
    80028c06:	c78080e7          	jalr	-904(ra) # 8002887a <dmac_channel_disable>
    dmac_wait_idle(channel_num);
    80028c0a:	854a                	mv	a0,s2
    80028c0c:	00000097          	auipc	ra,0x0
    80028c10:	f4c080e7          	jalr	-180(ra) # 80028b58 <dmac_wait_idle>
    dmac_set_channel_param(channel_num, src, dest, src_inc, dest_inc,
    80028c14:	000d089b          	sext.w	a7,s10
    80028c18:	8866                	mv	a6,s9
    80028c1a:	87e2                	mv	a5,s8
    80028c1c:	875e                	mv	a4,s7
    80028c1e:	86da                	mv	a3,s6
    80028c20:	8656                	mv	a2,s5
    80028c22:	85d2                	mv	a1,s4
    80028c24:	854a                	mv	a0,s2
    80028c26:	00000097          	auipc	ra,0x0
    80028c2a:	d10080e7          	jalr	-752(ra) # 80028936 <dmac_set_channel_param>
    dmac_enable();
    80028c2e:	00000097          	auipc	ra,0x0
    80028c32:	b6c080e7          	jalr	-1172(ra) # 8002879a <dmac_enable>
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028c36:	1934bc23          	sd	s3,408(s1)
    writeq(0x2, &dmac->channel[channel_num].intstatus_en);
    80028c3a:	4789                	li	a5,2
    80028c3c:	18f4b023          	sd	a5,384(s1)
    dmac_channel_enable(channel_num);
    80028c40:	854a                	mv	a0,s2
    80028c42:	00000097          	auipc	ra,0x0
    80028c46:	bd2080e7          	jalr	-1070(ra) # 80028814 <dmac_channel_enable>
}
    80028c4a:	60e6                	ld	ra,88(sp)
    80028c4c:	6446                	ld	s0,80(sp)
    80028c4e:	64a6                	ld	s1,72(sp)
    80028c50:	6906                	ld	s2,64(sp)
    80028c52:	79e2                	ld	s3,56(sp)
    80028c54:	7a42                	ld	s4,48(sp)
    80028c56:	7aa2                	ld	s5,40(sp)
    80028c58:	7b02                	ld	s6,32(sp)
    80028c5a:	6be2                	ld	s7,24(sp)
    80028c5c:	6c42                	ld	s8,16(sp)
    80028c5e:	6ca2                	ld	s9,8(sp)
    80028c60:	6d02                	ld	s10,0(sp)
    80028c62:	6125                	addi	sp,sp,96
    80028c64:	8082                	ret

0000000080028c66 <dmac_wait_done>:
{
    80028c66:	1141                	addi	sp,sp,-16
    80028c68:	e406                	sd	ra,8(sp)
    80028c6a:	e022                	sd	s0,0(sp)
    80028c6c:	0800                	addi	s0,sp,16
    dmac_wait_idle(channel_num);
    80028c6e:	00000097          	auipc	ra,0x0
    80028c72:	eea080e7          	jalr	-278(ra) # 80028b58 <dmac_wait_idle>
}
    80028c76:	60a2                	ld	ra,8(sp)
    80028c78:	6402                	ld	s0,0(sp)
    80028c7a:	0141                	addi	sp,sp,16
    80028c7c:	8082                	ret

0000000080028c7e <dmac_intr>:

void dmac_intr(dmac_channel_number_t channel_num)
{
    80028c7e:	1141                	addi	sp,sp,-16
    80028c80:	e406                	sd	ra,8(sp)
    80028c82:	e022                	sd	s0,0(sp)
    80028c84:	0800                	addi	s0,sp,16
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028c86:	3f500793          	li	a5,1013
    80028c8a:	07f2                	slli	a5,a5,0x1c
    80028c8c:	1502                	slli	a0,a0,0x20
    80028c8e:	9101                	srli	a0,a0,0x20
    80028c90:	0522                	slli	a0,a0,0x8
    80028c92:	953e                	add	a0,a0,a5
    80028c94:	577d                	li	a4,-1
    80028c96:	9301                	srli	a4,a4,0x20
    80028c98:	18e53c23          	sd	a4,408(a0)
    dmac_chanel_interrupt_clear(channel_num);
    wakeup(dmac_chan);
    80028c9c:	853e                	mv	a0,a5
    80028c9e:	ffffa097          	auipc	ra,0xffffa
    80028ca2:	8b8080e7          	jalr	-1864(ra) # 80022556 <wakeup>
    80028ca6:	60a2                	ld	ra,8(sp)
    80028ca8:	6402                	ld	s0,0(sp)
    80028caa:	0141                	addi	sp,sp,16
    80028cac:	8082                	ret

0000000080028cae <sysctl_get_git_id>:
};

volatile sysctl_t *const sysctl = (volatile sysctl_t *)SYSCTL_V;

uint32 sysctl_get_git_id(void)
{
    80028cae:	1141                	addi	sp,sp,-16
    80028cb0:	e422                	sd	s0,8(sp)
    80028cb2:	0800                	addi	s0,sp,16
    return sysctl->git_id.git_id;
    80028cb4:	000fd7b7          	lui	a5,0xfd
    80028cb8:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028cbc:	07ca                	slli	a5,a5,0x12
    80028cbe:	4388                	lw	a0,0(a5)
}
    80028cc0:	2501                	sext.w	a0,a0
    80028cc2:	6422                	ld	s0,8(sp)
    80028cc4:	0141                	addi	sp,sp,16
    80028cc6:	8082                	ret

0000000080028cc8 <sysctl_get_freq>:

uint32 sysctl_get_freq(void)
{
    80028cc8:	1141                	addi	sp,sp,-16
    80028cca:	e422                	sd	s0,8(sp)
    80028ccc:	0800                	addi	s0,sp,16
    return sysctl->clk_freq.clk_freq;
    80028cce:	000fd7b7          	lui	a5,0xfd
    80028cd2:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028cd6:	07ca                	slli	a5,a5,0x12
    80028cd8:	43c8                	lw	a0,4(a5)
}
    80028cda:	2501                	sext.w	a0,a0
    80028cdc:	6422                	ld	s0,8(sp)
    80028cde:	0141                	addi	sp,sp,16
    80028ce0:	8082                	ret

0000000080028ce2 <sysctl_clock_enable>:

    return 0;
}

int sysctl_clock_enable(sysctl_clock_t clock)
{
    80028ce2:	1141                	addi	sp,sp,-16
    80028ce4:	e422                	sd	s0,8(sp)
    80028ce6:	0800                	addi	s0,sp,16
    if(clock >= SYSCTL_CLOCK_MAX)
    80028ce8:	02a00793          	li	a5,42
    80028cec:	3ea7e363          	bltu	a5,a0,800290d2 <sysctl_clock_enable+0x3f0>
        switch(clock)
    80028cf0:	ff25079b          	addiw	a5,a0,-14
    80028cf4:	0007869b          	sext.w	a3,a5
    80028cf8:	475d                	li	a4,23
    80028cfa:	02d76663          	bltu	a4,a3,80028d26 <sysctl_clock_enable+0x44>
    80028cfe:	1782                	slli	a5,a5,0x20
    80028d00:	9381                	srli	a5,a5,0x20
    80028d02:	078a                	slli	a5,a5,0x2
    80028d04:	00004717          	auipc	a4,0x4
    80028d08:	e8470713          	addi	a4,a4,-380 # 8002cb88 <function_config+0x678>
    80028d0c:	97ba                	add	a5,a5,a4
    80028d0e:	439c                	lw	a5,0(a5)
    80028d10:	97ba                	add	a5,a5,a4
    80028d12:	8782                	jr	a5
                sysctl->clk_en_cent.apb0_clk_en = en;
    80028d14:	000fd7b7          	lui	a5,0xfd
    80028d18:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028d1c:	07ca                	slli	a5,a5,0x12
    80028d1e:	5798                	lw	a4,40(a5)
    80028d20:	00876713          	ori	a4,a4,8
    80028d24:	d798                	sw	a4,40(a5)
    switch(clock)
    80028d26:	02500793          	li	a5,37
    80028d2a:	3aa7e663          	bltu	a5,a0,800290d6 <sysctl_clock_enable+0x3f4>
    80028d2e:	050a                	slli	a0,a0,0x2
    80028d30:	00004717          	auipc	a4,0x4
    80028d34:	eb870713          	addi	a4,a4,-328 # 8002cbe8 <function_config+0x6d8>
    80028d38:	953a                	add	a0,a0,a4
    80028d3a:	411c                	lw	a5,0(a0)
    80028d3c:	97ba                	add	a5,a5,a4
    80028d3e:	8782                	jr	a5
                sysctl->clk_en_cent.apb1_clk_en = en;
    80028d40:	000fd7b7          	lui	a5,0xfd
    80028d44:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028d48:	07ca                	slli	a5,a5,0x12
    80028d4a:	5798                	lw	a4,40(a5)
    80028d4c:	01076713          	ori	a4,a4,16
    80028d50:	d798                	sw	a4,40(a5)
                break;
    80028d52:	bfd1                	j	80028d26 <sysctl_clock_enable+0x44>
                sysctl->clk_en_cent.apb2_clk_en = en;
    80028d54:	000fd7b7          	lui	a5,0xfd
    80028d58:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028d5c:	07ca                	slli	a5,a5,0x12
    80028d5e:	5798                	lw	a4,40(a5)
    80028d60:	02076713          	ori	a4,a4,32
    80028d64:	d798                	sw	a4,40(a5)
                break;
    80028d66:	b7c1                	j	80028d26 <sysctl_clock_enable+0x44>
            sysctl->pll0.pll_out_en0 = en;
    80028d68:	000fd7b7          	lui	a5,0xfd
    80028d6c:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028d70:	07ca                	slli	a5,a5,0x12
    80028d72:	4798                	lw	a4,8(a5)
    80028d74:	020006b7          	lui	a3,0x2000
    80028d78:	8f55                	or	a4,a4,a3
    80028d7a:	c798                	sw	a4,8(a5)
        return -1;
    sysctl_clock_bus_en(clock, 1);
    sysctl_clock_device_en(clock, 1);
    return 0;
    80028d7c:	4501                	li	a0,0
}
    80028d7e:	6422                	ld	s0,8(sp)
    80028d80:	0141                	addi	sp,sp,16
    80028d82:	8082                	ret
            sysctl->pll1.pll_out_en1 = en;
    80028d84:	000fd7b7          	lui	a5,0xfd
    80028d88:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028d8c:	07ca                	slli	a5,a5,0x12
    80028d8e:	47d8                	lw	a4,12(a5)
    80028d90:	020006b7          	lui	a3,0x2000
    80028d94:	8f55                	or	a4,a4,a3
    80028d96:	c7d8                	sw	a4,12(a5)
    return 0;
    80028d98:	4501                	li	a0,0
    80028d9a:	b7d5                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->pll2.pll_out_en2 = en;
    80028d9c:	000fd7b7          	lui	a5,0xfd
    80028da0:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028da4:	07ca                	slli	a5,a5,0x12
    80028da6:	4b98                	lw	a4,16(a5)
    80028da8:	020006b7          	lui	a3,0x2000
    80028dac:	8f55                	or	a4,a4,a3
    80028dae:	cb98                	sw	a4,16(a5)
    return 0;
    80028db0:	4501                	li	a0,0
    80028db2:	b7f1                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.cpu_clk_en = en;
    80028db4:	000fd7b7          	lui	a5,0xfd
    80028db8:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028dbc:	07ca                	slli	a5,a5,0x12
    80028dbe:	5798                	lw	a4,40(a5)
    80028dc0:	00176713          	ori	a4,a4,1
    80028dc4:	d798                	sw	a4,40(a5)
    return 0;
    80028dc6:	4501                	li	a0,0
    80028dc8:	bf5d                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.sram0_clk_en = en;
    80028dca:	000fd7b7          	lui	a5,0xfd
    80028dce:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028dd2:	07ca                	slli	a5,a5,0x12
    80028dd4:	5798                	lw	a4,40(a5)
    80028dd6:	00276713          	ori	a4,a4,2
    80028dda:	d798                	sw	a4,40(a5)
    return 0;
    80028ddc:	4501                	li	a0,0
    80028dde:	b745                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.sram1_clk_en = en;
    80028de0:	000fd7b7          	lui	a5,0xfd
    80028de4:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028de8:	07ca                	slli	a5,a5,0x12
    80028dea:	5798                	lw	a4,40(a5)
    80028dec:	00476713          	ori	a4,a4,4
    80028df0:	d798                	sw	a4,40(a5)
    return 0;
    80028df2:	4501                	li	a0,0
    80028df4:	b769                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb0_clk_en = en;
    80028df6:	000fd7b7          	lui	a5,0xfd
    80028dfa:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028dfe:	07ca                	slli	a5,a5,0x12
    80028e00:	5798                	lw	a4,40(a5)
    80028e02:	00876713          	ori	a4,a4,8
    80028e06:	d798                	sw	a4,40(a5)
    return 0;
    80028e08:	4501                	li	a0,0
    80028e0a:	bf95                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb1_clk_en = en;
    80028e0c:	000fd7b7          	lui	a5,0xfd
    80028e10:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e14:	07ca                	slli	a5,a5,0x12
    80028e16:	5798                	lw	a4,40(a5)
    80028e18:	01076713          	ori	a4,a4,16
    80028e1c:	d798                	sw	a4,40(a5)
    return 0;
    80028e1e:	4501                	li	a0,0
    80028e20:	bfb9                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb2_clk_en = en;
    80028e22:	000fd7b7          	lui	a5,0xfd
    80028e26:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e2a:	07ca                	slli	a5,a5,0x12
    80028e2c:	5798                	lw	a4,40(a5)
    80028e2e:	02076713          	ori	a4,a4,32
    80028e32:	d798                	sw	a4,40(a5)
    return 0;
    80028e34:	4501                	li	a0,0
    80028e36:	b7a1                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.rom_clk_en = en;
    80028e38:	000fd7b7          	lui	a5,0xfd
    80028e3c:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e40:	07ca                	slli	a5,a5,0x12
    80028e42:	57d8                	lw	a4,44(a5)
    80028e44:	00176713          	ori	a4,a4,1
    80028e48:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e4a:	4501                	li	a0,0
    80028e4c:	bf0d                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.dma_clk_en = en;
    80028e4e:	000fd7b7          	lui	a5,0xfd
    80028e52:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e56:	07ca                	slli	a5,a5,0x12
    80028e58:	57d8                	lw	a4,44(a5)
    80028e5a:	00276713          	ori	a4,a4,2
    80028e5e:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e60:	4501                	li	a0,0
    80028e62:	bf31                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.ai_clk_en = en;
    80028e64:	000fd7b7          	lui	a5,0xfd
    80028e68:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e6c:	07ca                	slli	a5,a5,0x12
    80028e6e:	57d8                	lw	a4,44(a5)
    80028e70:	00476713          	ori	a4,a4,4
    80028e74:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e76:	4501                	li	a0,0
    80028e78:	b719                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.dvp_clk_en = en;
    80028e7a:	000fd7b7          	lui	a5,0xfd
    80028e7e:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e82:	07ca                	slli	a5,a5,0x12
    80028e84:	57d8                	lw	a4,44(a5)
    80028e86:	00876713          	ori	a4,a4,8
    80028e8a:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e8c:	4501                	li	a0,0
    80028e8e:	bdc5                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.fft_clk_en = en;
    80028e90:	000fd7b7          	lui	a5,0xfd
    80028e94:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e98:	07ca                	slli	a5,a5,0x12
    80028e9a:	57d8                	lw	a4,44(a5)
    80028e9c:	01076713          	ori	a4,a4,16
    80028ea0:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ea2:	4501                	li	a0,0
    80028ea4:	bde9                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi3_clk_en = en;
    80028ea6:	000fd7b7          	lui	a5,0xfd
    80028eaa:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028eae:	07ca                	slli	a5,a5,0x12
    80028eb0:	57d8                	lw	a4,44(a5)
    80028eb2:	20076713          	ori	a4,a4,512
    80028eb6:	d7d8                	sw	a4,44(a5)
    return 0;
    80028eb8:	4501                	li	a0,0
    80028eba:	b5d1                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.gpio_clk_en = en;
    80028ebc:	000fd7b7          	lui	a5,0xfd
    80028ec0:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028ec4:	07ca                	slli	a5,a5,0x12
    80028ec6:	57d8                	lw	a4,44(a5)
    80028ec8:	02076713          	ori	a4,a4,32
    80028ecc:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ece:	4501                	li	a0,0
    80028ed0:	b57d                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi2_clk_en = en;
    80028ed2:	000fd7b7          	lui	a5,0xfd
    80028ed6:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028eda:	07ca                	slli	a5,a5,0x12
    80028edc:	57d8                	lw	a4,44(a5)
    80028ede:	10076713          	ori	a4,a4,256
    80028ee2:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ee4:	4501                	li	a0,0
    80028ee6:	bd61                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s0_clk_en = en;
    80028ee8:	000fd7b7          	lui	a5,0xfd
    80028eec:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028ef0:	07ca                	slli	a5,a5,0x12
    80028ef2:	57d8                	lw	a4,44(a5)
    80028ef4:	40076713          	ori	a4,a4,1024
    80028ef8:	d7d8                	sw	a4,44(a5)
    return 0;
    80028efa:	4501                	li	a0,0
    80028efc:	b549                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s1_clk_en = en;
    80028efe:	000fd7b7          	lui	a5,0xfd
    80028f02:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f06:	07ca                	slli	a5,a5,0x12
    80028f08:	57d8                	lw	a4,44(a5)
    80028f0a:	6685                	lui	a3,0x1
    80028f0c:	80068693          	addi	a3,a3,-2048 # 800 <BASE_ADDRESS-0x8001f800>
    80028f10:	8f55                	or	a4,a4,a3
    80028f12:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f14:	4501                	li	a0,0
    80028f16:	b5a5                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s2_clk_en = en;
    80028f18:	000fd7b7          	lui	a5,0xfd
    80028f1c:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f20:	07ca                	slli	a5,a5,0x12
    80028f22:	57d8                	lw	a4,44(a5)
    80028f24:	6685                	lui	a3,0x1
    80028f26:	8f55                	or	a4,a4,a3
    80028f28:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f2a:	4501                	li	a0,0
    80028f2c:	bd89                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c0_clk_en = en;
    80028f2e:	000fd7b7          	lui	a5,0xfd
    80028f32:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f36:	07ca                	slli	a5,a5,0x12
    80028f38:	57d8                	lw	a4,44(a5)
    80028f3a:	6689                	lui	a3,0x2
    80028f3c:	8f55                	or	a4,a4,a3
    80028f3e:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f40:	4501                	li	a0,0
    80028f42:	bd35                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c1_clk_en = en;
    80028f44:	000fd7b7          	lui	a5,0xfd
    80028f48:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f4c:	07ca                	slli	a5,a5,0x12
    80028f4e:	57d8                	lw	a4,44(a5)
    80028f50:	6691                	lui	a3,0x4
    80028f52:	8f55                	or	a4,a4,a3
    80028f54:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f56:	4501                	li	a0,0
    80028f58:	b51d                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c2_clk_en = en;
    80028f5a:	000fd7b7          	lui	a5,0xfd
    80028f5e:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f62:	07ca                	slli	a5,a5,0x12
    80028f64:	57d8                	lw	a4,44(a5)
    80028f66:	66a1                	lui	a3,0x8
    80028f68:	8f55                	or	a4,a4,a3
    80028f6a:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f6c:	4501                	li	a0,0
    80028f6e:	bd01                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart1_clk_en = en;
    80028f70:	000fd7b7          	lui	a5,0xfd
    80028f74:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f78:	07ca                	slli	a5,a5,0x12
    80028f7a:	57d8                	lw	a4,44(a5)
    80028f7c:	66c1                	lui	a3,0x10
    80028f7e:	8f55                	or	a4,a4,a3
    80028f80:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f82:	4501                	li	a0,0
    80028f84:	bbed                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart2_clk_en = en;
    80028f86:	000fd7b7          	lui	a5,0xfd
    80028f8a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f8e:	07ca                	slli	a5,a5,0x12
    80028f90:	57d8                	lw	a4,44(a5)
    80028f92:	000206b7          	lui	a3,0x20
    80028f96:	8f55                	or	a4,a4,a3
    80028f98:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f9a:	4501                	li	a0,0
    80028f9c:	b3cd                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart3_clk_en = en;
    80028f9e:	000fd7b7          	lui	a5,0xfd
    80028fa2:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fa6:	07ca                	slli	a5,a5,0x12
    80028fa8:	57d8                	lw	a4,44(a5)
    80028faa:	000406b7          	lui	a3,0x40
    80028fae:	8f55                	or	a4,a4,a3
    80028fb0:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fb2:	4501                	li	a0,0
    80028fb4:	b3e9                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.fpioa_clk_en = en;
    80028fb6:	000fd7b7          	lui	a5,0xfd
    80028fba:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fbe:	07ca                	slli	a5,a5,0x12
    80028fc0:	57d8                	lw	a4,44(a5)
    80028fc2:	001006b7          	lui	a3,0x100
    80028fc6:	8f55                	or	a4,a4,a3
    80028fc8:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fca:	4501                	li	a0,0
    80028fcc:	bb4d                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer0_clk_en = en;
    80028fce:	000fd7b7          	lui	a5,0xfd
    80028fd2:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fd6:	07ca                	slli	a5,a5,0x12
    80028fd8:	57d8                	lw	a4,44(a5)
    80028fda:	002006b7          	lui	a3,0x200
    80028fde:	8f55                	or	a4,a4,a3
    80028fe0:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fe2:	4501                	li	a0,0
    80028fe4:	bb69                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer1_clk_en = en;
    80028fe6:	000fd7b7          	lui	a5,0xfd
    80028fea:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fee:	07ca                	slli	a5,a5,0x12
    80028ff0:	57d8                	lw	a4,44(a5)
    80028ff2:	004006b7          	lui	a3,0x400
    80028ff6:	8f55                	or	a4,a4,a3
    80028ff8:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ffa:	4501                	li	a0,0
    80028ffc:	b349                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer2_clk_en = en;
    80028ffe:	000fd7b7          	lui	a5,0xfd
    80029002:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029006:	07ca                	slli	a5,a5,0x12
    80029008:	57d8                	lw	a4,44(a5)
    8002900a:	008006b7          	lui	a3,0x800
    8002900e:	8f55                	or	a4,a4,a3
    80029010:	d7d8                	sw	a4,44(a5)
    return 0;
    80029012:	4501                	li	a0,0
    80029014:	b3ad                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.sha_clk_en = en;
    80029016:	000fd7b7          	lui	a5,0xfd
    8002901a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002901e:	07ca                	slli	a5,a5,0x12
    80029020:	57d8                	lw	a4,44(a5)
    80029022:	040006b7          	lui	a3,0x4000
    80029026:	8f55                	or	a4,a4,a3
    80029028:	d7d8                	sw	a4,44(a5)
    return 0;
    8002902a:	4501                	li	a0,0
    8002902c:	bb89                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.aes_clk_en = en;
    8002902e:	000fd7b7          	lui	a5,0xfd
    80029032:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029036:	07ca                	slli	a5,a5,0x12
    80029038:	57d8                	lw	a4,44(a5)
    8002903a:	000806b7          	lui	a3,0x80
    8002903e:	8f55                	or	a4,a4,a3
    80029040:	d7d8                	sw	a4,44(a5)
    return 0;
    80029042:	4501                	li	a0,0
    80029044:	bb2d                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.wdt0_clk_en = en;
    80029046:	000fd7b7          	lui	a5,0xfd
    8002904a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002904e:	07ca                	slli	a5,a5,0x12
    80029050:	57d8                	lw	a4,44(a5)
    80029052:	010006b7          	lui	a3,0x1000
    80029056:	8f55                	or	a4,a4,a3
    80029058:	d7d8                	sw	a4,44(a5)
    return 0;
    8002905a:	4501                	li	a0,0
    8002905c:	b30d                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.wdt1_clk_en = en;
    8002905e:	000fd7b7          	lui	a5,0xfd
    80029062:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029066:	07ca                	slli	a5,a5,0x12
    80029068:	57d8                	lw	a4,44(a5)
    8002906a:	020006b7          	lui	a3,0x2000
    8002906e:	8f55                	or	a4,a4,a3
    80029070:	d7d8                	sw	a4,44(a5)
    return 0;
    80029072:	4501                	li	a0,0
    80029074:	b329                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.otp_clk_en = en;
    80029076:	000fd7b7          	lui	a5,0xfd
    8002907a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002907e:	07ca                	slli	a5,a5,0x12
    80029080:	57d8                	lw	a4,44(a5)
    80029082:	080006b7          	lui	a3,0x8000
    80029086:	8f55                	or	a4,a4,a3
    80029088:	d7d8                	sw	a4,44(a5)
    return 0;
    8002908a:	4501                	li	a0,0
    8002908c:	b9cd                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.rtc_clk_en = en;
    8002908e:	000fd7b7          	lui	a5,0xfd
    80029092:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029096:	07ca                	slli	a5,a5,0x12
    80029098:	57d8                	lw	a4,44(a5)
    8002909a:	200006b7          	lui	a3,0x20000
    8002909e:	8f55                	or	a4,a4,a3
    800290a0:	d7d8                	sw	a4,44(a5)
    return 0;
    800290a2:	4501                	li	a0,0
    800290a4:	b9e9                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi0_clk_en = en;
    800290a6:	000fd7b7          	lui	a5,0xfd
    800290aa:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290ae:	07ca                	slli	a5,a5,0x12
    800290b0:	57d8                	lw	a4,44(a5)
    800290b2:	04076713          	ori	a4,a4,64
    800290b6:	d7d8                	sw	a4,44(a5)
    return 0;
    800290b8:	4501                	li	a0,0
    800290ba:	b1d1                	j	80028d7e <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi1_clk_en = en;
    800290bc:	000fd7b7          	lui	a5,0xfd
    800290c0:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290c4:	07ca                	slli	a5,a5,0x12
    800290c6:	57d8                	lw	a4,44(a5)
    800290c8:	08076713          	ori	a4,a4,128
    800290cc:	d7d8                	sw	a4,44(a5)
    return 0;
    800290ce:	4501                	li	a0,0
    800290d0:	b17d                	j	80028d7e <sysctl_clock_enable+0x9c>
        return -1;
    800290d2:	557d                	li	a0,-1
    800290d4:	b16d                	j	80028d7e <sysctl_clock_enable+0x9c>
    return 0;
    800290d6:	4501                	li	a0,0
    800290d8:	b15d                	j	80028d7e <sysctl_clock_enable+0x9c>

00000000800290da <sysctl_dma_select>:

int sysctl_dma_select(sysctl_dma_channel_t channel, sysctl_dma_select_t select)
{
    800290da:	1141                	addi	sp,sp,-16
    800290dc:	e422                	sd	s0,8(sp)
    800290de:	0800                	addi	s0,sp,16
    sysctl_dma_sel0_t dma_sel0;
    sysctl_dma_sel1_t dma_sel1;

    /* Read register from bus */
    dma_sel0 = sysctl->dma_sel0;
    800290e0:	000fd637          	lui	a2,0xfd
    800290e4:	41160613          	addi	a2,a2,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290e8:	064a                	slli	a2,a2,0x12
    800290ea:	5274                	lw	a3,100(a2)
    800290ec:	0186d81b          	srliw	a6,a3,0x18
    dma_sel1 = sysctl->dma_sel1;
    800290f0:	5630                	lw	a2,104(a2)
    switch(channel)
    800290f2:	4e95                	li	t4,5
    800290f4:	0aaeee63          	bltu	t4,a0,800291b0 <sysctl_dma_select+0xd6>
    800290f8:	03f6f793          	andi	a5,a3,63
    800290fc:	0066d71b          	srliw	a4,a3,0x6
    80029100:	03f77713          	andi	a4,a4,63
    80029104:	00c6d31b          	srliw	t1,a3,0xc
    80029108:	03f37313          	andi	t1,t1,63
    8002910c:	0126d89b          	srliw	a7,a3,0x12
    80029110:	03f8f893          	andi	a7,a7,63
    80029114:	03f87813          	andi	a6,a6,63
    80029118:	03f67e13          	andi	t3,a2,63
    8002911c:	050a                	slli	a0,a0,0x2
    8002911e:	00004e97          	auipc	t4,0x4
    80029122:	b62e8e93          	addi	t4,t4,-1182 # 8002cc80 <function_config+0x770>
    80029126:	9576                	add	a0,a0,t4
    80029128:	4108                	lw	a0,0(a0)
    8002912a:	9576                	add	a0,a0,t4
    8002912c:	8502                	jr	a0
    {
        case SYSCTL_DMA_CHANNEL_0:
            dma_sel0.dma_sel0 = select;
    8002912e:	03f5f793          	andi	a5,a1,63
        default:
            return -1;
    }

    /* Write register back to bus */
    sysctl->dma_sel0 = dma_sel0;
    80029132:	fc06f693          	andi	a3,a3,-64
    80029136:	8edd                	or	a3,a3,a5
    80029138:	0067179b          	slliw	a5,a4,0x6
    8002913c:	777d                	lui	a4,0xfffff
    8002913e:	03f70713          	addi	a4,a4,63 # fffffffffffff03f <kernel_end+0xffffffff7ffba03f>
    80029142:	8f75                	and	a4,a4,a3
    80029144:	8f5d                	or	a4,a4,a5
    80029146:	00c3179b          	slliw	a5,t1,0xc
    8002914a:	fffc16b7          	lui	a3,0xfffc1
    8002914e:	16fd                	addi	a3,a3,-1
    80029150:	8f75                	and	a4,a4,a3
    80029152:	8f5d                	or	a4,a4,a5
    80029154:	0128989b          	slliw	a7,a7,0x12
    80029158:	ff0407b7          	lui	a5,0xff040
    8002915c:	17fd                	addi	a5,a5,-1
    8002915e:	8ff9                	and	a5,a5,a4
    80029160:	0117e7b3          	or	a5,a5,a7
    80029164:	0188181b          	slliw	a6,a6,0x18
    80029168:	c1000737          	lui	a4,0xc1000
    8002916c:	177d                	addi	a4,a4,-1
    8002916e:	8ff9                	and	a5,a5,a4
    80029170:	0107e7b3          	or	a5,a5,a6
    80029174:	000fd737          	lui	a4,0xfd
    80029178:	41170713          	addi	a4,a4,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002917c:	074a                	slli	a4,a4,0x12
    8002917e:	d37c                	sw	a5,100(a4)
    sysctl->dma_sel1 = dma_sel1;
    80029180:	fc067613          	andi	a2,a2,-64
    80029184:	00ce6633          	or	a2,t3,a2
    80029188:	d730                	sw	a2,104(a4)

    return 0;
    8002918a:	4501                	li	a0,0
}
    8002918c:	6422                	ld	s0,8(sp)
    8002918e:	0141                	addi	sp,sp,16
    80029190:	8082                	ret
            dma_sel0.dma_sel1 = select;
    80029192:	03f5f713          	andi	a4,a1,63
            break;
    80029196:	bf71                	j	80029132 <sysctl_dma_select+0x58>
            dma_sel0.dma_sel2 = select;
    80029198:	03f5f313          	andi	t1,a1,63
            break;
    8002919c:	bf59                	j	80029132 <sysctl_dma_select+0x58>
            dma_sel0.dma_sel3 = select;
    8002919e:	03f5f893          	andi	a7,a1,63
            break;
    800291a2:	bf41                	j	80029132 <sysctl_dma_select+0x58>
            dma_sel0.dma_sel4 = select;
    800291a4:	03f5f813          	andi	a6,a1,63
            break;
    800291a8:	b769                	j	80029132 <sysctl_dma_select+0x58>
            dma_sel1.dma_sel5 = select;
    800291aa:	03f5fe13          	andi	t3,a1,63
            break;
    800291ae:	b751                	j	80029132 <sysctl_dma_select+0x58>
            return -1;
    800291b0:	557d                	li	a0,-1
    800291b2:	bfe9                	j	8002918c <sysctl_dma_select+0xb2>
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
