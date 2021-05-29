
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
    800200a4:	cb2080e7          	jalr	-846(ra) # 80026d52 <consputc>
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
    800200d2:	c84080e7          	jalr	-892(ra) # 80026d52 <consputc>
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
    80020170:	3c450513          	addi	a0,a0,964 # 8002c530 <sysnames+0x5b0>
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
    80020224:	b32080e7          	jalr	-1230(ra) # 80026d52 <consputc>
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
    800202b8:	a9e080e7          	jalr	-1378(ra) # 80026d52 <consputc>
  consputc('x');
    800202bc:	07800513          	li	a0,120
    800202c0:	00007097          	auipc	ra,0x7
    800202c4:	a92080e7          	jalr	-1390(ra) # 80026d52 <consputc>
    800202c8:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800202ca:	03c9d793          	srli	a5,s3,0x3c
    800202ce:	97de                	add	a5,a5,s7
    800202d0:	0007c503          	lbu	a0,0(a5)
    800202d4:	00007097          	auipc	ra,0x7
    800202d8:	a7e080e7          	jalr	-1410(ra) # 80026d52 <consputc>
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
    80020304:	a52080e7          	jalr	-1454(ra) # 80026d52 <consputc>
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
    80020326:	a30080e7          	jalr	-1488(ra) # 80026d52 <consputc>
      break;
    8002032a:	bdfd                	j	80020228 <printf+0x98>
      consputc('%');
    8002032c:	8552                	mv	a0,s4
    8002032e:	00007097          	auipc	ra,0x7
    80020332:	a24080e7          	jalr	-1500(ra) # 80026d52 <consputc>
      consputc(c);
    80020336:	854a                	mv	a0,s2
    80020338:	00007097          	auipc	ra,0x7
    8002033c:	a1a080e7          	jalr	-1510(ra) # 80026d52 <consputc>
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
    80020a48:	dd4080e7          	jalr	-556(ra) # 80022818 <trapinithart>
    plicinithart();  // ask PLIC for device interrupts
    80020a4c:	00006097          	auipc	ra,0x6
    80020a50:	0da080e7          	jalr	218(ra) # 80026b26 <plicinithart>
    printf("hart 1 init done\n");
    80020a54:	0000b517          	auipc	a0,0xb
    80020a58:	8a450513          	addi	a0,a0,-1884 # 8002b2f8 <etext+0x2f8>
    80020a5c:	fffff097          	auipc	ra,0xfffff
    80020a60:	734080e7          	jalr	1844(ra) # 80020190 <printf>
  }
  scheduler();
    80020a64:	00001097          	auipc	ra,0x1
    80020a68:	6a6080e7          	jalr	1702(ra) # 8002210a <scheduler>
    consoleinit();
    80020a6c:	00006097          	auipc	ra,0x6
    80020a70:	4a8080e7          	jalr	1192(ra) # 80026f14 <consoleinit>
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
    80020aa0:	632080e7          	jalr	1586(ra) # 800250ce <timerinit>
    trapinithart();  // install kernel trap vector, including interrupt handler
    80020aa4:	00002097          	auipc	ra,0x2
    80020aa8:	d74080e7          	jalr	-652(ra) # 80022818 <trapinithart>
    procinit();
    80020aac:	00001097          	auipc	ra,0x1
    80020ab0:	034080e7          	jalr	52(ra) # 80021ae0 <procinit>
    plicinit();
    80020ab4:	00006097          	auipc	ra,0x6
    80020ab8:	058080e7          	jalr	88(ra) # 80026b0c <plicinit>
    plicinithart();
    80020abc:	00006097          	auipc	ra,0x6
    80020ac0:	06a080e7          	jalr	106(ra) # 80026b26 <plicinithart>
    fpioa_pin_init();
    80020ac4:	00007097          	auipc	ra,0x7
    80020ac8:	398080e7          	jalr	920(ra) # 80027e5c <fpioa_pin_init>
    fpioa_set_function(27, FUNC_SPI0_SCLK); 
    80020acc:	45c5                	li	a1,17
    80020ace:	456d                	li	a0,27
    80020ad0:	00007097          	auipc	ra,0x7
    80020ad4:	2a0080e7          	jalr	672(ra) # 80027d70 <fpioa_set_function>
    fpioa_set_function(28, FUNC_SPI0_D0); 
    80020ad8:	4591                	li	a1,4
    80020ada:	4571                	li	a0,28
    80020adc:	00007097          	auipc	ra,0x7
    80020ae0:	294080e7          	jalr	660(ra) # 80027d70 <fpioa_set_function>
    fpioa_set_function(26, FUNC_SPI0_D1); 
    80020ae4:	4595                	li	a1,5
    80020ae6:	4569                	li	a0,26
    80020ae8:	00007097          	auipc	ra,0x7
    80020aec:	288080e7          	jalr	648(ra) # 80027d70 <fpioa_set_function>
    fpioa_set_function(29, FUNC_SPI0_SS0); 
    80020af0:	45b1                	li	a1,12
    80020af2:	4575                	li	a0,29
    80020af4:	00007097          	auipc	ra,0x7
    80020af8:	27c080e7          	jalr	636(ra) # 80027d70 <fpioa_set_function>
    dmac_init();
    80020afc:	00008097          	auipc	ra,0x8
    80020b00:	fec080e7          	jalr	-20(ra) # 80028ae8 <dmac_init>
    disk_init();
    80020b04:	00004097          	auipc	ra,0x4
    80020b08:	666080e7          	jalr	1638(ra) # 8002516a <disk_init>
    binit();         // buffer cache
    80020b0c:	00003097          	auipc	ra,0x3
    80020b10:	914080e7          	jalr	-1772(ra) # 80023420 <binit>
    fileinit();      // file table
    80020b14:	00003097          	auipc	ra,0x3
    80020b18:	d2a080e7          	jalr	-726(ra) # 8002383e <fileinit>
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
    800219c0:	ad450513          	addi	a0,a0,-1324 # 8002b490 <states.1738+0x28>
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
    800219e6:	ab650513          	addi	a0,a0,-1354 # 8002b498 <states.1738+0x30>
    800219ea:	ffffe097          	auipc	ra,0xffffe
    800219ee:	7a6080e7          	jalr	1958(ra) # 80020190 <printf>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800219f2:	100025f3          	csrr	a1,sstatus
  printf("sstatus: %p\n", r_sstatus());
    800219f6:	0000a517          	auipc	a0,0xa
    800219fa:	aba50513          	addi	a0,a0,-1350 # 8002b4b0 <states.1738+0x48>
    800219fe:	ffffe097          	auipc	ra,0xffffe
    80021a02:	792080e7          	jalr	1938(ra) # 80020190 <printf>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80021a06:	144025f3          	csrr	a1,sip
  printf("sip: %p\n", r_sip());
    80021a0a:	0000a517          	auipc	a0,0xa
    80021a0e:	ab650513          	addi	a0,a0,-1354 # 8002b4c0 <states.1738+0x58>
    80021a12:	ffffe097          	auipc	ra,0xffffe
    80021a16:	77e080e7          	jalr	1918(ra) # 80020190 <printf>
  asm volatile("csrr %0, sie" : "=r" (x) );
    80021a1a:	104025f3          	csrr	a1,sie
  printf("sie: %p\n", r_sie());
    80021a1e:	0000a517          	auipc	a0,0xa
    80021a22:	ab250513          	addi	a0,a0,-1358 # 8002b4d0 <states.1738+0x68>
    80021a26:	ffffe097          	auipc	ra,0xffffe
    80021a2a:	76a080e7          	jalr	1898(ra) # 80020190 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80021a2e:	141025f3          	csrr	a1,sepc
  printf("sepc: %p\n", r_sepc());
    80021a32:	0000a517          	auipc	a0,0xa
    80021a36:	aae50513          	addi	a0,a0,-1362 # 8002b4e0 <states.1738+0x78>
    80021a3a:	ffffe097          	auipc	ra,0xffffe
    80021a3e:	756080e7          	jalr	1878(ra) # 80020190 <printf>
  asm volatile("csrr %0, stvec" : "=r" (x) );
    80021a42:	105025f3          	csrr	a1,stvec
  printf("stvec: %p\n", r_stvec());
    80021a46:	0000a517          	auipc	a0,0xa
    80021a4a:	aaa50513          	addi	a0,a0,-1366 # 8002b4f0 <states.1738+0x88>
    80021a4e:	ffffe097          	auipc	ra,0xffffe
    80021a52:	742080e7          	jalr	1858(ra) # 80020190 <printf>
  asm volatile("csrr %0, satp" : "=r" (x) );
    80021a56:	180025f3          	csrr	a1,satp
  printf("satp: %p\n", r_satp());
    80021a5a:	0000a517          	auipc	a0,0xa
    80021a5e:	aa650513          	addi	a0,a0,-1370 # 8002b500 <states.1738+0x98>
    80021a62:	ffffe097          	auipc	ra,0xffffe
    80021a66:	72e080e7          	jalr	1838(ra) # 80020190 <printf>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80021a6a:	142025f3          	csrr	a1,scause
  printf("scause: %p\n", r_scause());
    80021a6e:	0000a517          	auipc	a0,0xa
    80021a72:	aa250513          	addi	a0,a0,-1374 # 8002b510 <states.1738+0xa8>
    80021a76:	ffffe097          	auipc	ra,0xffffe
    80021a7a:	71a080e7          	jalr	1818(ra) # 80020190 <printf>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80021a7e:	143025f3          	csrr	a1,stval
  printf("stval: %p\n", r_stval());
    80021a82:	0000a517          	auipc	a0,0xa
    80021a86:	a9e50513          	addi	a0,a0,-1378 # 8002b520 <states.1738+0xb8>
    80021a8a:	ffffe097          	auipc	ra,0xffffe
    80021a8e:	706080e7          	jalr	1798(ra) # 80020190 <printf>
  asm volatile("mv %0, sp" : "=r" (x) );
    80021a92:	858a                	mv	a1,sp
  printf("sp: %p\n", r_sp());
    80021a94:	0000a517          	auipc	a0,0xa
    80021a98:	a9c50513          	addi	a0,a0,-1380 # 8002b530 <states.1738+0xc8>
    80021a9c:	ffffe097          	auipc	ra,0xffffe
    80021aa0:	6f4080e7          	jalr	1780(ra) # 80020190 <printf>
  asm volatile("mv %0, tp" : "=r" (x) );
    80021aa4:	8592                	mv	a1,tp
  printf("tp: %p\n", r_tp());
    80021aa6:	0000a517          	auipc	a0,0xa
    80021aaa:	a9250513          	addi	a0,a0,-1390 # 8002b538 <states.1738+0xd0>
    80021aae:	ffffe097          	auipc	ra,0xffffe
    80021ab2:	6e2080e7          	jalr	1762(ra) # 80020190 <printf>
  asm volatile("mv %0, ra" : "=r" (x) );
    80021ab6:	8586                	mv	a1,ra
  printf("ra: %p\n", r_ra());
    80021ab8:	0000a517          	auipc	a0,0xa
    80021abc:	a8850513          	addi	a0,a0,-1400 # 8002b540 <states.1738+0xd8>
    80021ac0:	ffffe097          	auipc	ra,0xffffe
    80021ac4:	6d0080e7          	jalr	1744(ra) # 80020190 <printf>
  printf("}\n");
    80021ac8:	0000a517          	auipc	a0,0xa
    80021acc:	a8050513          	addi	a0,a0,-1408 # 8002b548 <states.1738+0xe0>
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
    80021af2:	a6258593          	addi	a1,a1,-1438 # 8002b550 <states.1738+0xe8>
    80021af6:	00015517          	auipc	a0,0x15
    80021afa:	56a50513          	addi	a0,a0,1386 # 80037060 <pid_lock>
    80021afe:	fffff097          	auipc	ra,0xfffff
    80021b02:	b7e080e7          	jalr	-1154(ra) # 8002067c <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80021b06:	00015497          	auipc	s1,0x15
    80021b0a:	67248493          	addi	s1,s1,1650 # 80037178 <proc>
      initlock(&p->lock, "proc");
    80021b0e:	0000a997          	auipc	s3,0xa
    80021b12:	a4a98993          	addi	s3,s3,-1462 # 8002b558 <states.1738+0xf0>
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
    80021bd8:	f9c78793          	addi	a5,a5,-100 # 8002eb70 <first.1700>
    80021bdc:	439c                	lw	a5,0(a5)
    80021bde:	eb91                	bnez	a5,80021bf2 <forkret+0x38>
  usertrapret();
    80021be0:	00001097          	auipc	ra,0x1
    80021be4:	c74080e7          	jalr	-908(ra) # 80022854 <usertrapret>
}
    80021be8:	60e2                	ld	ra,24(sp)
    80021bea:	6442                	ld	s0,16(sp)
    80021bec:	64a2                	ld	s1,8(sp)
    80021bee:	6105                	addi	sp,sp,32
    80021bf0:	8082                	ret
    first = 0;
    80021bf2:	0000d797          	auipc	a5,0xd
    80021bf6:	f607af23          	sw	zero,-130(a5) # 8002eb70 <first.1700>
    fat32_init();
    80021bfa:	00004097          	auipc	ra,0x4
    80021bfe:	c9e080e7          	jalr	-866(ra) # 80025898 <fat32_init>
    myproc()->cwd = ename("/");
    80021c02:	00000097          	auipc	ra,0x0
    80021c06:	f80080e7          	jalr	-128(ra) # 80021b82 <myproc>
    80021c0a:	84aa                	mv	s1,a0
    80021c0c:	0000a517          	auipc	a0,0xa
    80021c10:	95450513          	addi	a0,a0,-1708 # 8002b560 <states.1738+0xf8>
    80021c14:	00005097          	auipc	ra,0x5
    80021c18:	ebe080e7          	jalr	-322(ra) # 80026ad2 <ename>
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
    80021ee2:	68a58593          	addi	a1,a1,1674 # 8002b568 <states.1738+0x100>
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

0000000080021f90 <fork>:
{
    80021f90:	7179                	addi	sp,sp,-48
    80021f92:	f406                	sd	ra,40(sp)
    80021f94:	f022                	sd	s0,32(sp)
    80021f96:	ec26                	sd	s1,24(sp)
    80021f98:	e84a                	sd	s2,16(sp)
    80021f9a:	e44e                	sd	s3,8(sp)
    80021f9c:	e052                	sd	s4,0(sp)
    80021f9e:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80021fa0:	00000097          	auipc	ra,0x0
    80021fa4:	be2080e7          	jalr	-1054(ra) # 80021b82 <myproc>
    80021fa8:	892a                	mv	s2,a0
  if((np = allocproc()) == NULL){
    80021faa:	00000097          	auipc	ra,0x0
    80021fae:	e16080e7          	jalr	-490(ra) # 80021dc0 <allocproc>
    80021fb2:	c57d                	beqz	a0,800220a0 <fork+0x110>
    80021fb4:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, np->kpagetable, p->sz) < 0){
    80021fb6:	04893683          	ld	a3,72(s2)
    80021fba:	6d30                	ld	a2,88(a0)
    80021fbc:	692c                	ld	a1,80(a0)
    80021fbe:	05093503          	ld	a0,80(s2)
    80021fc2:	fffff097          	auipc	ra,0xfffff
    80021fc6:	2fa080e7          	jalr	762(ra) # 800212bc <uvmcopy>
    80021fca:	04054c63          	bltz	a0,80022022 <fork+0x92>
  np->sz = p->sz;
    80021fce:	04893783          	ld	a5,72(s2)
    80021fd2:	04f9b423          	sd	a5,72(s3)
  np->parent = p;
    80021fd6:	0329b023          	sd	s2,32(s3)
  np->tmask = p->tmask;
    80021fda:	17092783          	lw	a5,368(s2)
    80021fde:	16f9a823          	sw	a5,368(s3)
  *(np->trapframe) = *(p->trapframe);
    80021fe2:	06093683          	ld	a3,96(s2)
    80021fe6:	87b6                	mv	a5,a3
    80021fe8:	0609b703          	ld	a4,96(s3)
    80021fec:	12068693          	addi	a3,a3,288
    80021ff0:	0007b803          	ld	a6,0(a5)
    80021ff4:	6788                	ld	a0,8(a5)
    80021ff6:	6b8c                	ld	a1,16(a5)
    80021ff8:	6f90                	ld	a2,24(a5)
    80021ffa:	01073023          	sd	a6,0(a4) # 1000 <BASE_ADDRESS-0x8001f000>
    80021ffe:	e708                	sd	a0,8(a4)
    80022000:	eb0c                	sd	a1,16(a4)
    80022002:	ef10                	sd	a2,24(a4)
    80022004:	02078793          	addi	a5,a5,32
    80022008:	02070713          	addi	a4,a4,32
    8002200c:	fed792e3          	bne	a5,a3,80021ff0 <fork+0x60>
  np->trapframe->a0 = 0;
    80022010:	0609b783          	ld	a5,96(s3)
    80022014:	0607b823          	sd	zero,112(a5)
    80022018:	0d800493          	li	s1,216
  for(i = 0; i < NOFILE; i++)
    8002201c:	15800a13          	li	s4,344
    80022020:	a03d                	j	8002204e <fork+0xbe>
    freeproc(np);
    80022022:	854e                	mv	a0,s3
    80022024:	00000097          	auipc	ra,0x0
    80022028:	d32080e7          	jalr	-718(ra) # 80021d56 <freeproc>
    release(&np->lock);
    8002202c:	854e                	mv	a0,s3
    8002202e:	ffffe097          	auipc	ra,0xffffe
    80022032:	6e6080e7          	jalr	1766(ra) # 80020714 <release>
    return -1;
    80022036:	54fd                	li	s1,-1
    80022038:	a899                	j	8002208e <fork+0xfe>
      np->ofile[i] = filedup(p->ofile[i]);
    8002203a:	00002097          	auipc	ra,0x2
    8002203e:	8da080e7          	jalr	-1830(ra) # 80023914 <filedup>
    80022042:	009987b3          	add	a5,s3,s1
    80022046:	e388                	sd	a0,0(a5)
    80022048:	04a1                	addi	s1,s1,8
  for(i = 0; i < NOFILE; i++)
    8002204a:	01448763          	beq	s1,s4,80022058 <fork+0xc8>
    if(p->ofile[i])
    8002204e:	009907b3          	add	a5,s2,s1
    80022052:	6388                	ld	a0,0(a5)
    80022054:	f17d                	bnez	a0,8002203a <fork+0xaa>
    80022056:	bfcd                	j	80022048 <fork+0xb8>
  np->cwd = edup(p->cwd);
    80022058:	15893503          	ld	a0,344(s2)
    8002205c:	00004097          	auipc	ra,0x4
    80022060:	080080e7          	jalr	128(ra) # 800260dc <edup>
    80022064:	14a9bc23          	sd	a0,344(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80022068:	4641                	li	a2,16
    8002206a:	16090593          	addi	a1,s2,352
    8002206e:	16098513          	addi	a0,s3,352
    80022072:	fffff097          	auipc	ra,0xfffff
    80022076:	862080e7          	jalr	-1950(ra) # 800208d4 <safestrcpy>
  pid = np->pid;
    8002207a:	0389a483          	lw	s1,56(s3)
  np->state = RUNNABLE;
    8002207e:	4789                	li	a5,2
    80022080:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80022084:	854e                	mv	a0,s3
    80022086:	ffffe097          	auipc	ra,0xffffe
    8002208a:	68e080e7          	jalr	1678(ra) # 80020714 <release>
}
    8002208e:	8526                	mv	a0,s1
    80022090:	70a2                	ld	ra,40(sp)
    80022092:	7402                	ld	s0,32(sp)
    80022094:	64e2                	ld	s1,24(sp)
    80022096:	6942                	ld	s2,16(sp)
    80022098:	69a2                	ld	s3,8(sp)
    8002209a:	6a02                	ld	s4,0(sp)
    8002209c:	6145                	addi	sp,sp,48
    8002209e:	8082                	ret
    return -1;
    800220a0:	54fd                	li	s1,-1
    800220a2:	b7f5                	j	8002208e <fork+0xfe>

00000000800220a4 <reparent>:
{
    800220a4:	7179                	addi	sp,sp,-48
    800220a6:	f406                	sd	ra,40(sp)
    800220a8:	f022                	sd	s0,32(sp)
    800220aa:	ec26                	sd	s1,24(sp)
    800220ac:	e84a                	sd	s2,16(sp)
    800220ae:	e44e                	sd	s3,8(sp)
    800220b0:	e052                	sd	s4,0(sp)
    800220b2:	1800                	addi	s0,sp,48
    800220b4:	89aa                	mv	s3,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800220b6:	00015497          	auipc	s1,0x15
    800220ba:	0c248493          	addi	s1,s1,194 # 80037178 <proc>
      pp->parent = initproc;
    800220be:	0001aa17          	auipc	s4,0x1a
    800220c2:	a2aa0a13          	addi	s4,s4,-1494 # 8003bae8 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800220c6:	0001a917          	auipc	s2,0x1a
    800220ca:	a2290913          	addi	s2,s2,-1502 # 8003bae8 <initproc>
    800220ce:	a029                	j	800220d8 <reparent+0x34>
    800220d0:	17848493          	addi	s1,s1,376
    800220d4:	03248363          	beq	s1,s2,800220fa <reparent+0x56>
    if(pp->parent == p){
    800220d8:	709c                	ld	a5,32(s1)
    800220da:	ff379be3          	bne	a5,s3,800220d0 <reparent+0x2c>
      acquire(&pp->lock);
    800220de:	8526                	mv	a0,s1
    800220e0:	ffffe097          	auipc	ra,0xffffe
    800220e4:	5e0080e7          	jalr	1504(ra) # 800206c0 <acquire>
      pp->parent = initproc;
    800220e8:	000a3783          	ld	a5,0(s4)
    800220ec:	f09c                	sd	a5,32(s1)
      release(&pp->lock);
    800220ee:	8526                	mv	a0,s1
    800220f0:	ffffe097          	auipc	ra,0xffffe
    800220f4:	624080e7          	jalr	1572(ra) # 80020714 <release>
    800220f8:	bfe1                	j	800220d0 <reparent+0x2c>
}
    800220fa:	70a2                	ld	ra,40(sp)
    800220fc:	7402                	ld	s0,32(sp)
    800220fe:	64e2                	ld	s1,24(sp)
    80022100:	6942                	ld	s2,16(sp)
    80022102:	69a2                	ld	s3,8(sp)
    80022104:	6a02                	ld	s4,0(sp)
    80022106:	6145                	addi	sp,sp,48
    80022108:	8082                	ret

000000008002210a <scheduler>:
{
    8002210a:	715d                	addi	sp,sp,-80
    8002210c:	e486                	sd	ra,72(sp)
    8002210e:	e0a2                	sd	s0,64(sp)
    80022110:	fc26                	sd	s1,56(sp)
    80022112:	f84a                	sd	s2,48(sp)
    80022114:	f44e                	sd	s3,40(sp)
    80022116:	f052                	sd	s4,32(sp)
    80022118:	ec56                	sd	s5,24(sp)
    8002211a:	e85a                	sd	s6,16(sp)
    8002211c:	e45e                	sd	s7,8(sp)
    8002211e:	e062                	sd	s8,0(sp)
    80022120:	0880                	addi	s0,sp,80
    80022122:	8792                	mv	a5,tp
  int id = r_tp();
    80022124:	2781                	sext.w	a5,a5
  c->proc = 0;
    80022126:	00779b13          	slli	s6,a5,0x7
    8002212a:	00015717          	auipc	a4,0x15
    8002212e:	f3670713          	addi	a4,a4,-202 # 80037060 <pid_lock>
    80022132:	975a                	add	a4,a4,s6
    80022134:	00073c23          	sd	zero,24(a4)
        swtch(&c->context, &p->context);
    80022138:	00015717          	auipc	a4,0x15
    8002213c:	f4870713          	addi	a4,a4,-184 # 80037080 <cpus+0x8>
    80022140:	9b3a                	add	s6,s6,a4
        c->proc = p;
    80022142:	079e                	slli	a5,a5,0x7
    80022144:	00015a97          	auipc	s5,0x15
    80022148:	f1ca8a93          	addi	s5,s5,-228 # 80037060 <pid_lock>
    8002214c:	9abe                	add	s5,s5,a5
        w_satp(MAKE_SATP(p->kpagetable));
    8002214e:	5a7d                	li	s4,-1
    80022150:	1a7e                	slli	s4,s4,0x3f
        w_satp(MAKE_SATP(kernel_pagetable));
    80022152:	00015b97          	auipc	s7,0x15
    80022156:	f06b8b93          	addi	s7,s7,-250 # 80037058 <kernel_pagetable>
    8002215a:	a8a5                	j	800221d2 <scheduler+0xc8>
        p->state = RUNNING;
    8002215c:	478d                	li	a5,3
    8002215e:	cc9c                	sw	a5,24(s1)
        c->proc = p;
    80022160:	009abc23          	sd	s1,24(s5)
        w_satp(MAKE_SATP(p->kpagetable));
    80022164:	6cbc                	ld	a5,88(s1)
    80022166:	83b1                	srli	a5,a5,0xc
    80022168:	0147e7b3          	or	a5,a5,s4
  asm volatile("csrw satp, %0" : : "r" (x));
    8002216c:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    80022170:	12000073          	sfence.vma
        swtch(&c->context, &p->context);
    80022174:	06848593          	addi	a1,s1,104
    80022178:	855a                	mv	a0,s6
    8002217a:	00000097          	auipc	ra,0x0
    8002217e:	634080e7          	jalr	1588(ra) # 800227ae <swtch>
        w_satp(MAKE_SATP(kernel_pagetable));
    80022182:	000bb783          	ld	a5,0(s7)
    80022186:	83b1                	srli	a5,a5,0xc
    80022188:	0147e7b3          	or	a5,a5,s4
  asm volatile("csrw satp, %0" : : "r" (x));
    8002218c:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    80022190:	12000073          	sfence.vma
        c->proc = 0;
    80022194:	000abc23          	sd	zero,24(s5)
        found = 1;
    80022198:	4c05                	li	s8,1
      release(&p->lock);
    8002219a:	8526                	mv	a0,s1
    8002219c:	ffffe097          	auipc	ra,0xffffe
    800221a0:	578080e7          	jalr	1400(ra) # 80020714 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800221a4:	17848493          	addi	s1,s1,376
    800221a8:	01248b63          	beq	s1,s2,800221be <scheduler+0xb4>
      acquire(&p->lock);
    800221ac:	8526                	mv	a0,s1
    800221ae:	ffffe097          	auipc	ra,0xffffe
    800221b2:	512080e7          	jalr	1298(ra) # 800206c0 <acquire>
      if(p->state == RUNNABLE) {
    800221b6:	4c9c                	lw	a5,24(s1)
    800221b8:	ff3791e3          	bne	a5,s3,8002219a <scheduler+0x90>
    800221bc:	b745                	j	8002215c <scheduler+0x52>
    if(found == 0) {
    800221be:	000c1a63          	bnez	s8,800221d2 <scheduler+0xc8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800221c2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800221c6:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800221ca:	10079073          	csrw	sstatus,a5
      asm volatile("wfi");
    800221ce:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800221d2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800221d6:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800221da:	10079073          	csrw	sstatus,a5
    int found = 0;
    800221de:	4c01                	li	s8,0
    for(p = proc; p < &proc[NPROC]; p++) {
    800221e0:	00015497          	auipc	s1,0x15
    800221e4:	f9848493          	addi	s1,s1,-104 # 80037178 <proc>
      if(p->state == RUNNABLE) {
    800221e8:	4989                	li	s3,2
    for(p = proc; p < &proc[NPROC]; p++) {
    800221ea:	0001a917          	auipc	s2,0x1a
    800221ee:	8fe90913          	addi	s2,s2,-1794 # 8003bae8 <initproc>
    800221f2:	bf6d                	j	800221ac <scheduler+0xa2>

00000000800221f4 <sched>:
{
    800221f4:	7179                	addi	sp,sp,-48
    800221f6:	f406                	sd	ra,40(sp)
    800221f8:	f022                	sd	s0,32(sp)
    800221fa:	ec26                	sd	s1,24(sp)
    800221fc:	e84a                	sd	s2,16(sp)
    800221fe:	e44e                	sd	s3,8(sp)
    80022200:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80022202:	00000097          	auipc	ra,0x0
    80022206:	980080e7          	jalr	-1664(ra) # 80021b82 <myproc>
    8002220a:	892a                	mv	s2,a0
  if(!holding(&p->lock))
    8002220c:	ffffe097          	auipc	ra,0xffffe
    80022210:	486080e7          	jalr	1158(ra) # 80020692 <holding>
    80022214:	cd25                	beqz	a0,8002228c <sched+0x98>
  asm volatile("mv %0, tp" : "=r" (x) );
    80022216:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80022218:	2781                	sext.w	a5,a5
    8002221a:	079e                	slli	a5,a5,0x7
    8002221c:	00015717          	auipc	a4,0x15
    80022220:	e4470713          	addi	a4,a4,-444 # 80037060 <pid_lock>
    80022224:	97ba                	add	a5,a5,a4
    80022226:	0907a703          	lw	a4,144(a5)
    8002222a:	4785                	li	a5,1
    8002222c:	06f71863          	bne	a4,a5,8002229c <sched+0xa8>
  if(p->state == RUNNING)
    80022230:	01892703          	lw	a4,24(s2)
    80022234:	478d                	li	a5,3
    80022236:	06f70b63          	beq	a4,a5,800222ac <sched+0xb8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002223a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8002223e:	8b89                	andi	a5,a5,2
  if(intr_get())
    80022240:	efb5                	bnez	a5,800222bc <sched+0xc8>
  asm volatile("mv %0, tp" : "=r" (x) );
    80022242:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80022244:	00015497          	auipc	s1,0x15
    80022248:	e1c48493          	addi	s1,s1,-484 # 80037060 <pid_lock>
    8002224c:	2781                	sext.w	a5,a5
    8002224e:	079e                	slli	a5,a5,0x7
    80022250:	97a6                	add	a5,a5,s1
    80022252:	0947a983          	lw	s3,148(a5)
    80022256:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80022258:	2781                	sext.w	a5,a5
    8002225a:	079e                	slli	a5,a5,0x7
    8002225c:	00015597          	auipc	a1,0x15
    80022260:	e2458593          	addi	a1,a1,-476 # 80037080 <cpus+0x8>
    80022264:	95be                	add	a1,a1,a5
    80022266:	06890513          	addi	a0,s2,104
    8002226a:	00000097          	auipc	ra,0x0
    8002226e:	544080e7          	jalr	1348(ra) # 800227ae <swtch>
    80022272:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80022274:	2781                	sext.w	a5,a5
    80022276:	079e                	slli	a5,a5,0x7
    80022278:	97a6                	add	a5,a5,s1
    8002227a:	0937aa23          	sw	s3,148(a5)
}
    8002227e:	70a2                	ld	ra,40(sp)
    80022280:	7402                	ld	s0,32(sp)
    80022282:	64e2                	ld	s1,24(sp)
    80022284:	6942                	ld	s2,16(sp)
    80022286:	69a2                	ld	s3,8(sp)
    80022288:	6145                	addi	sp,sp,48
    8002228a:	8082                	ret
    panic("sched p->lock");
    8002228c:	00009517          	auipc	a0,0x9
    80022290:	2ec50513          	addi	a0,a0,748 # 8002b578 <states.1738+0x110>
    80022294:	ffffe097          	auipc	ra,0xffffe
    80022298:	eb2080e7          	jalr	-334(ra) # 80020146 <panic>
    panic("sched locks");
    8002229c:	00009517          	auipc	a0,0x9
    800222a0:	2ec50513          	addi	a0,a0,748 # 8002b588 <states.1738+0x120>
    800222a4:	ffffe097          	auipc	ra,0xffffe
    800222a8:	ea2080e7          	jalr	-350(ra) # 80020146 <panic>
    panic("sched running");
    800222ac:	00009517          	auipc	a0,0x9
    800222b0:	2ec50513          	addi	a0,a0,748 # 8002b598 <states.1738+0x130>
    800222b4:	ffffe097          	auipc	ra,0xffffe
    800222b8:	e92080e7          	jalr	-366(ra) # 80020146 <panic>
    panic("sched interruptible");
    800222bc:	00009517          	auipc	a0,0x9
    800222c0:	2ec50513          	addi	a0,a0,748 # 8002b5a8 <states.1738+0x140>
    800222c4:	ffffe097          	auipc	ra,0xffffe
    800222c8:	e82080e7          	jalr	-382(ra) # 80020146 <panic>

00000000800222cc <exit>:
{
    800222cc:	7179                	addi	sp,sp,-48
    800222ce:	f406                	sd	ra,40(sp)
    800222d0:	f022                	sd	s0,32(sp)
    800222d2:	ec26                	sd	s1,24(sp)
    800222d4:	e84a                	sd	s2,16(sp)
    800222d6:	e44e                	sd	s3,8(sp)
    800222d8:	e052                	sd	s4,0(sp)
    800222da:	1800                	addi	s0,sp,48
    800222dc:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800222de:	00000097          	auipc	ra,0x0
    800222e2:	8a4080e7          	jalr	-1884(ra) # 80021b82 <myproc>
    800222e6:	89aa                	mv	s3,a0
  if(p == initproc)
    800222e8:	0001a797          	auipc	a5,0x1a
    800222ec:	80078793          	addi	a5,a5,-2048 # 8003bae8 <initproc>
    800222f0:	639c                	ld	a5,0(a5)
    800222f2:	0d850493          	addi	s1,a0,216
    800222f6:	15850913          	addi	s2,a0,344
    800222fa:	02a79363          	bne	a5,a0,80022320 <exit+0x54>
    panic("init exiting");
    800222fe:	00009517          	auipc	a0,0x9
    80022302:	2c250513          	addi	a0,a0,706 # 8002b5c0 <states.1738+0x158>
    80022306:	ffffe097          	auipc	ra,0xffffe
    8002230a:	e40080e7          	jalr	-448(ra) # 80020146 <panic>
      fileclose(f);
    8002230e:	00001097          	auipc	ra,0x1
    80022312:	658080e7          	jalr	1624(ra) # 80023966 <fileclose>
      p->ofile[fd] = 0;
    80022316:	0004b023          	sd	zero,0(s1)
    8002231a:	04a1                	addi	s1,s1,8
  for(int fd = 0; fd < NOFILE; fd++){
    8002231c:	01248563          	beq	s1,s2,80022326 <exit+0x5a>
    if(p->ofile[fd]){
    80022320:	6088                	ld	a0,0(s1)
    80022322:	f575                	bnez	a0,8002230e <exit+0x42>
    80022324:	bfdd                	j	8002231a <exit+0x4e>
  eput(p->cwd);
    80022326:	1589b503          	ld	a0,344(s3)
    8002232a:	00004097          	auipc	ra,0x4
    8002232e:	086080e7          	jalr	134(ra) # 800263b0 <eput>
  p->cwd = 0;
    80022332:	1409bc23          	sd	zero,344(s3)
  acquire(&initproc->lock);
    80022336:	00019497          	auipc	s1,0x19
    8002233a:	7b248493          	addi	s1,s1,1970 # 8003bae8 <initproc>
    8002233e:	6088                	ld	a0,0(s1)
    80022340:	ffffe097          	auipc	ra,0xffffe
    80022344:	380080e7          	jalr	896(ra) # 800206c0 <acquire>
  wakeup1(initproc);
    80022348:	6088                	ld	a0,0(s1)
    8002234a:	fffff097          	auipc	ra,0xfffff
    8002234e:	64c080e7          	jalr	1612(ra) # 80021996 <wakeup1>
  release(&initproc->lock);
    80022352:	6088                	ld	a0,0(s1)
    80022354:	ffffe097          	auipc	ra,0xffffe
    80022358:	3c0080e7          	jalr	960(ra) # 80020714 <release>
  acquire(&p->lock);
    8002235c:	854e                	mv	a0,s3
    8002235e:	ffffe097          	auipc	ra,0xffffe
    80022362:	362080e7          	jalr	866(ra) # 800206c0 <acquire>
  struct proc *original_parent = p->parent;
    80022366:	0209b483          	ld	s1,32(s3)
  release(&p->lock);
    8002236a:	854e                	mv	a0,s3
    8002236c:	ffffe097          	auipc	ra,0xffffe
    80022370:	3a8080e7          	jalr	936(ra) # 80020714 <release>
  acquire(&original_parent->lock);
    80022374:	8526                	mv	a0,s1
    80022376:	ffffe097          	auipc	ra,0xffffe
    8002237a:	34a080e7          	jalr	842(ra) # 800206c0 <acquire>
  acquire(&p->lock);
    8002237e:	854e                	mv	a0,s3
    80022380:	ffffe097          	auipc	ra,0xffffe
    80022384:	340080e7          	jalr	832(ra) # 800206c0 <acquire>
  reparent(p);
    80022388:	854e                	mv	a0,s3
    8002238a:	00000097          	auipc	ra,0x0
    8002238e:	d1a080e7          	jalr	-742(ra) # 800220a4 <reparent>
  wakeup1(original_parent);
    80022392:	8526                	mv	a0,s1
    80022394:	fffff097          	auipc	ra,0xfffff
    80022398:	602080e7          	jalr	1538(ra) # 80021996 <wakeup1>
  p->xstate = status;
    8002239c:	0349aa23          	sw	s4,52(s3)
  p->state = ZOMBIE;
    800223a0:	4791                	li	a5,4
    800223a2:	00f9ac23          	sw	a5,24(s3)
  release(&original_parent->lock);
    800223a6:	8526                	mv	a0,s1
    800223a8:	ffffe097          	auipc	ra,0xffffe
    800223ac:	36c080e7          	jalr	876(ra) # 80020714 <release>
  sched();
    800223b0:	00000097          	auipc	ra,0x0
    800223b4:	e44080e7          	jalr	-444(ra) # 800221f4 <sched>
  panic("zombie exit");
    800223b8:	00009517          	auipc	a0,0x9
    800223bc:	21850513          	addi	a0,a0,536 # 8002b5d0 <states.1738+0x168>
    800223c0:	ffffe097          	auipc	ra,0xffffe
    800223c4:	d86080e7          	jalr	-634(ra) # 80020146 <panic>

00000000800223c8 <yield>:
{
    800223c8:	1101                	addi	sp,sp,-32
    800223ca:	ec06                	sd	ra,24(sp)
    800223cc:	e822                	sd	s0,16(sp)
    800223ce:	e426                	sd	s1,8(sp)
    800223d0:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800223d2:	fffff097          	auipc	ra,0xfffff
    800223d6:	7b0080e7          	jalr	1968(ra) # 80021b82 <myproc>
    800223da:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800223dc:	ffffe097          	auipc	ra,0xffffe
    800223e0:	2e4080e7          	jalr	740(ra) # 800206c0 <acquire>
  p->state = RUNNABLE;
    800223e4:	4789                	li	a5,2
    800223e6:	cc9c                	sw	a5,24(s1)
  sched();
    800223e8:	00000097          	auipc	ra,0x0
    800223ec:	e0c080e7          	jalr	-500(ra) # 800221f4 <sched>
  release(&p->lock);
    800223f0:	8526                	mv	a0,s1
    800223f2:	ffffe097          	auipc	ra,0xffffe
    800223f6:	322080e7          	jalr	802(ra) # 80020714 <release>
}
    800223fa:	60e2                	ld	ra,24(sp)
    800223fc:	6442                	ld	s0,16(sp)
    800223fe:	64a2                	ld	s1,8(sp)
    80022400:	6105                	addi	sp,sp,32
    80022402:	8082                	ret

0000000080022404 <sleep>:
{
    80022404:	7179                	addi	sp,sp,-48
    80022406:	f406                	sd	ra,40(sp)
    80022408:	f022                	sd	s0,32(sp)
    8002240a:	ec26                	sd	s1,24(sp)
    8002240c:	e84a                	sd	s2,16(sp)
    8002240e:	e44e                	sd	s3,8(sp)
    80022410:	1800                	addi	s0,sp,48
    80022412:	89aa                	mv	s3,a0
    80022414:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80022416:	fffff097          	auipc	ra,0xfffff
    8002241a:	76c080e7          	jalr	1900(ra) # 80021b82 <myproc>
    8002241e:	84aa                	mv	s1,a0
  if(lk != &p->lock){  //DOC: sleeplock0
    80022420:	05250663          	beq	a0,s2,8002246c <sleep+0x68>
    acquire(&p->lock);  //DOC: sleeplock1
    80022424:	ffffe097          	auipc	ra,0xffffe
    80022428:	29c080e7          	jalr	668(ra) # 800206c0 <acquire>
    release(lk);
    8002242c:	854a                	mv	a0,s2
    8002242e:	ffffe097          	auipc	ra,0xffffe
    80022432:	2e6080e7          	jalr	742(ra) # 80020714 <release>
  p->chan = chan;
    80022436:	0334b423          	sd	s3,40(s1)
  p->state = SLEEPING;
    8002243a:	4785                	li	a5,1
    8002243c:	cc9c                	sw	a5,24(s1)
  sched();
    8002243e:	00000097          	auipc	ra,0x0
    80022442:	db6080e7          	jalr	-586(ra) # 800221f4 <sched>
  p->chan = 0;
    80022446:	0204b423          	sd	zero,40(s1)
    release(&p->lock);
    8002244a:	8526                	mv	a0,s1
    8002244c:	ffffe097          	auipc	ra,0xffffe
    80022450:	2c8080e7          	jalr	712(ra) # 80020714 <release>
    acquire(lk);
    80022454:	854a                	mv	a0,s2
    80022456:	ffffe097          	auipc	ra,0xffffe
    8002245a:	26a080e7          	jalr	618(ra) # 800206c0 <acquire>
}
    8002245e:	70a2                	ld	ra,40(sp)
    80022460:	7402                	ld	s0,32(sp)
    80022462:	64e2                	ld	s1,24(sp)
    80022464:	6942                	ld	s2,16(sp)
    80022466:	69a2                	ld	s3,8(sp)
    80022468:	6145                	addi	sp,sp,48
    8002246a:	8082                	ret
  p->chan = chan;
    8002246c:	03353423          	sd	s3,40(a0)
  p->state = SLEEPING;
    80022470:	4785                	li	a5,1
    80022472:	cd1c                	sw	a5,24(a0)
  sched();
    80022474:	00000097          	auipc	ra,0x0
    80022478:	d80080e7          	jalr	-640(ra) # 800221f4 <sched>
  p->chan = 0;
    8002247c:	0204b423          	sd	zero,40(s1)
  if(lk != &p->lock){
    80022480:	bff9                	j	8002245e <sleep+0x5a>

0000000080022482 <wait>:
{
    80022482:	715d                	addi	sp,sp,-80
    80022484:	e486                	sd	ra,72(sp)
    80022486:	e0a2                	sd	s0,64(sp)
    80022488:	fc26                	sd	s1,56(sp)
    8002248a:	f84a                	sd	s2,48(sp)
    8002248c:	f44e                	sd	s3,40(sp)
    8002248e:	f052                	sd	s4,32(sp)
    80022490:	ec56                	sd	s5,24(sp)
    80022492:	e85a                	sd	s6,16(sp)
    80022494:	e45e                	sd	s7,8(sp)
    80022496:	e062                	sd	s8,0(sp)
    80022498:	0880                	addi	s0,sp,80
    8002249a:	8baa                	mv	s7,a0
  struct proc *p = myproc();
    8002249c:	fffff097          	auipc	ra,0xfffff
    800224a0:	6e6080e7          	jalr	1766(ra) # 80021b82 <myproc>
    800224a4:	892a                	mv	s2,a0
  acquire(&p->lock);
    800224a6:	8c2a                	mv	s8,a0
    800224a8:	ffffe097          	auipc	ra,0xffffe
    800224ac:	218080e7          	jalr	536(ra) # 800206c0 <acquire>
    havekids = 0;
    800224b0:	4b01                	li	s6,0
        if(np->state == ZOMBIE){
    800224b2:	4a11                	li	s4,4
    for(np = proc; np < &proc[NPROC]; np++){
    800224b4:	00019997          	auipc	s3,0x19
    800224b8:	63498993          	addi	s3,s3,1588 # 8003bae8 <initproc>
        havekids = 1;
    800224bc:	4a85                	li	s5,1
    havekids = 0;
    800224be:	875a                	mv	a4,s6
    for(np = proc; np < &proc[NPROC]; np++){
    800224c0:	00015497          	auipc	s1,0x15
    800224c4:	cb848493          	addi	s1,s1,-840 # 80037178 <proc>
    800224c8:	a8b9                	j	80022526 <wait+0xa4>
          pid = np->pid;
    800224ca:	0384a983          	lw	s3,56(s1)
          if(addr != 0 && copyout2(addr, (char *)&np->xstate, sizeof(np->xstate)) < 0) {
    800224ce:	000b8c63          	beqz	s7,800224e6 <wait+0x64>
    800224d2:	4611                	li	a2,4
    800224d4:	03448593          	addi	a1,s1,52
    800224d8:	855e                	mv	a0,s7
    800224da:	fffff097          	auipc	ra,0xfffff
    800224de:	fae080e7          	jalr	-82(ra) # 80021488 <copyout2>
    800224e2:	02054263          	bltz	a0,80022506 <wait+0x84>
          freeproc(np);
    800224e6:	8526                	mv	a0,s1
    800224e8:	00000097          	auipc	ra,0x0
    800224ec:	86e080e7          	jalr	-1938(ra) # 80021d56 <freeproc>
          release(&np->lock);
    800224f0:	8526                	mv	a0,s1
    800224f2:	ffffe097          	auipc	ra,0xffffe
    800224f6:	222080e7          	jalr	546(ra) # 80020714 <release>
          release(&p->lock);
    800224fa:	854a                	mv	a0,s2
    800224fc:	ffffe097          	auipc	ra,0xffffe
    80022500:	218080e7          	jalr	536(ra) # 80020714 <release>
          return pid;
    80022504:	a8a9                	j	8002255e <wait+0xdc>
            release(&np->lock);
    80022506:	8526                	mv	a0,s1
    80022508:	ffffe097          	auipc	ra,0xffffe
    8002250c:	20c080e7          	jalr	524(ra) # 80020714 <release>
            release(&p->lock);
    80022510:	854a                	mv	a0,s2
    80022512:	ffffe097          	auipc	ra,0xffffe
    80022516:	202080e7          	jalr	514(ra) # 80020714 <release>
            return -1;
    8002251a:	59fd                	li	s3,-1
    8002251c:	a089                	j	8002255e <wait+0xdc>
    for(np = proc; np < &proc[NPROC]; np++){
    8002251e:	17848493          	addi	s1,s1,376
    80022522:	03348463          	beq	s1,s3,8002254a <wait+0xc8>
      if(np->parent == p){
    80022526:	709c                	ld	a5,32(s1)
    80022528:	ff279be3          	bne	a5,s2,8002251e <wait+0x9c>
        acquire(&np->lock);
    8002252c:	8526                	mv	a0,s1
    8002252e:	ffffe097          	auipc	ra,0xffffe
    80022532:	192080e7          	jalr	402(ra) # 800206c0 <acquire>
        if(np->state == ZOMBIE){
    80022536:	4c9c                	lw	a5,24(s1)
    80022538:	f94789e3          	beq	a5,s4,800224ca <wait+0x48>
        release(&np->lock);
    8002253c:	8526                	mv	a0,s1
    8002253e:	ffffe097          	auipc	ra,0xffffe
    80022542:	1d6080e7          	jalr	470(ra) # 80020714 <release>
        havekids = 1;
    80022546:	8756                	mv	a4,s5
    80022548:	bfd9                	j	8002251e <wait+0x9c>
    if(!havekids || p->killed){
    8002254a:	c701                	beqz	a4,80022552 <wait+0xd0>
    8002254c:	03092783          	lw	a5,48(s2)
    80022550:	c785                	beqz	a5,80022578 <wait+0xf6>
      release(&p->lock);
    80022552:	854a                	mv	a0,s2
    80022554:	ffffe097          	auipc	ra,0xffffe
    80022558:	1c0080e7          	jalr	448(ra) # 80020714 <release>
      return -1;
    8002255c:	59fd                	li	s3,-1
}
    8002255e:	854e                	mv	a0,s3
    80022560:	60a6                	ld	ra,72(sp)
    80022562:	6406                	ld	s0,64(sp)
    80022564:	74e2                	ld	s1,56(sp)
    80022566:	7942                	ld	s2,48(sp)
    80022568:	79a2                	ld	s3,40(sp)
    8002256a:	7a02                	ld	s4,32(sp)
    8002256c:	6ae2                	ld	s5,24(sp)
    8002256e:	6b42                	ld	s6,16(sp)
    80022570:	6ba2                	ld	s7,8(sp)
    80022572:	6c02                	ld	s8,0(sp)
    80022574:	6161                	addi	sp,sp,80
    80022576:	8082                	ret
    sleep(p, &p->lock);  //DOC: wait-sleep
    80022578:	85e2                	mv	a1,s8
    8002257a:	854a                	mv	a0,s2
    8002257c:	00000097          	auipc	ra,0x0
    80022580:	e88080e7          	jalr	-376(ra) # 80022404 <sleep>
    havekids = 0;
    80022584:	bf2d                	j	800224be <wait+0x3c>

0000000080022586 <wakeup>:
{
    80022586:	7139                	addi	sp,sp,-64
    80022588:	fc06                	sd	ra,56(sp)
    8002258a:	f822                	sd	s0,48(sp)
    8002258c:	f426                	sd	s1,40(sp)
    8002258e:	f04a                	sd	s2,32(sp)
    80022590:	ec4e                	sd	s3,24(sp)
    80022592:	e852                	sd	s4,16(sp)
    80022594:	e456                	sd	s5,8(sp)
    80022596:	0080                	addi	s0,sp,64
    80022598:	8a2a                	mv	s4,a0
  for(p = proc; p < &proc[NPROC]; p++) {
    8002259a:	00015497          	auipc	s1,0x15
    8002259e:	bde48493          	addi	s1,s1,-1058 # 80037178 <proc>
    if(p->state == SLEEPING && p->chan == chan) {
    800225a2:	4985                	li	s3,1
      p->state = RUNNABLE;
    800225a4:	4a89                	li	s5,2
  for(p = proc; p < &proc[NPROC]; p++) {
    800225a6:	00019917          	auipc	s2,0x19
    800225aa:	54290913          	addi	s2,s2,1346 # 8003bae8 <initproc>
    800225ae:	a821                	j	800225c6 <wakeup+0x40>
      p->state = RUNNABLE;
    800225b0:	0154ac23          	sw	s5,24(s1)
    release(&p->lock);
    800225b4:	8526                	mv	a0,s1
    800225b6:	ffffe097          	auipc	ra,0xffffe
    800225ba:	15e080e7          	jalr	350(ra) # 80020714 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800225be:	17848493          	addi	s1,s1,376
    800225c2:	01248e63          	beq	s1,s2,800225de <wakeup+0x58>
    acquire(&p->lock);
    800225c6:	8526                	mv	a0,s1
    800225c8:	ffffe097          	auipc	ra,0xffffe
    800225cc:	0f8080e7          	jalr	248(ra) # 800206c0 <acquire>
    if(p->state == SLEEPING && p->chan == chan) {
    800225d0:	4c9c                	lw	a5,24(s1)
    800225d2:	ff3791e3          	bne	a5,s3,800225b4 <wakeup+0x2e>
    800225d6:	749c                	ld	a5,40(s1)
    800225d8:	fd479ee3          	bne	a5,s4,800225b4 <wakeup+0x2e>
    800225dc:	bfd1                	j	800225b0 <wakeup+0x2a>
}
    800225de:	70e2                	ld	ra,56(sp)
    800225e0:	7442                	ld	s0,48(sp)
    800225e2:	74a2                	ld	s1,40(sp)
    800225e4:	7902                	ld	s2,32(sp)
    800225e6:	69e2                	ld	s3,24(sp)
    800225e8:	6a42                	ld	s4,16(sp)
    800225ea:	6aa2                	ld	s5,8(sp)
    800225ec:	6121                	addi	sp,sp,64
    800225ee:	8082                	ret

00000000800225f0 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800225f0:	7179                	addi	sp,sp,-48
    800225f2:	f406                	sd	ra,40(sp)
    800225f4:	f022                	sd	s0,32(sp)
    800225f6:	ec26                	sd	s1,24(sp)
    800225f8:	e84a                	sd	s2,16(sp)
    800225fa:	e44e                	sd	s3,8(sp)
    800225fc:	1800                	addi	s0,sp,48
    800225fe:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80022600:	00015497          	auipc	s1,0x15
    80022604:	b7848493          	addi	s1,s1,-1160 # 80037178 <proc>
    80022608:	00019997          	auipc	s3,0x19
    8002260c:	4e098993          	addi	s3,s3,1248 # 8003bae8 <initproc>
    acquire(&p->lock);
    80022610:	8526                	mv	a0,s1
    80022612:	ffffe097          	auipc	ra,0xffffe
    80022616:	0ae080e7          	jalr	174(ra) # 800206c0 <acquire>
    if(p->pid == pid){
    8002261a:	5c9c                	lw	a5,56(s1)
    8002261c:	01278d63          	beq	a5,s2,80022636 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80022620:	8526                	mv	a0,s1
    80022622:	ffffe097          	auipc	ra,0xffffe
    80022626:	0f2080e7          	jalr	242(ra) # 80020714 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8002262a:	17848493          	addi	s1,s1,376
    8002262e:	ff3491e3          	bne	s1,s3,80022610 <kill+0x20>
  }
  return -1;
    80022632:	557d                	li	a0,-1
    80022634:	a821                	j	8002264c <kill+0x5c>
      p->killed = 1;
    80022636:	4785                	li	a5,1
    80022638:	d89c                	sw	a5,48(s1)
      if(p->state == SLEEPING){
    8002263a:	4c98                	lw	a4,24(s1)
    8002263c:	00f70f63          	beq	a4,a5,8002265a <kill+0x6a>
      release(&p->lock);
    80022640:	8526                	mv	a0,s1
    80022642:	ffffe097          	auipc	ra,0xffffe
    80022646:	0d2080e7          	jalr	210(ra) # 80020714 <release>
      return 0;
    8002264a:	4501                	li	a0,0
}
    8002264c:	70a2                	ld	ra,40(sp)
    8002264e:	7402                	ld	s0,32(sp)
    80022650:	64e2                	ld	s1,24(sp)
    80022652:	6942                	ld	s2,16(sp)
    80022654:	69a2                	ld	s3,8(sp)
    80022656:	6145                	addi	sp,sp,48
    80022658:	8082                	ret
        p->state = RUNNABLE;
    8002265a:	4789                	li	a5,2
    8002265c:	cc9c                	sw	a5,24(s1)
    8002265e:	b7cd                	j	80022640 <kill+0x50>

0000000080022660 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80022660:	1101                	addi	sp,sp,-32
    80022662:	ec06                	sd	ra,24(sp)
    80022664:	e822                	sd	s0,16(sp)
    80022666:	e426                	sd	s1,8(sp)
    80022668:	1000                	addi	s0,sp,32
    8002266a:	84aa                	mv	s1,a0
    8002266c:	852e                	mv	a0,a1
    8002266e:	85b2                	mv	a1,a2
  // struct proc *p = myproc();
  if(user_dst){
    80022670:	c899                	beqz	s1,80022686 <either_copyout+0x26>
    // return copyout(p->pagetable, dst, src, len);
    return copyout2(dst, src, len);
    80022672:	8636                	mv	a2,a3
    80022674:	fffff097          	auipc	ra,0xfffff
    80022678:	e14080e7          	jalr	-492(ra) # 80021488 <copyout2>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8002267c:	60e2                	ld	ra,24(sp)
    8002267e:	6442                	ld	s0,16(sp)
    80022680:	64a2                	ld	s1,8(sp)
    80022682:	6105                	addi	sp,sp,32
    80022684:	8082                	ret
    memmove((char *)dst, src, len);
    80022686:	0006861b          	sext.w	a2,a3
    8002268a:	ffffe097          	auipc	ra,0xffffe
    8002268e:	13e080e7          	jalr	318(ra) # 800207c8 <memmove>
    return 0;
    80022692:	8526                	mv	a0,s1
    80022694:	b7e5                	j	8002267c <either_copyout+0x1c>

0000000080022696 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80022696:	1101                	addi	sp,sp,-32
    80022698:	ec06                	sd	ra,24(sp)
    8002269a:	e822                	sd	s0,16(sp)
    8002269c:	e426                	sd	s1,8(sp)
    8002269e:	1000                	addi	s0,sp,32
    800226a0:	84ae                	mv	s1,a1
    800226a2:	85b2                	mv	a1,a2
  // struct proc *p = myproc();
  if(user_src){
    800226a4:	c899                	beqz	s1,800226ba <either_copyin+0x24>
    // return copyin(p->pagetable, dst, src, len);
    return copyin2(dst, src, len);
    800226a6:	8636                	mv	a2,a3
    800226a8:	fffff097          	auipc	ra,0xfffff
    800226ac:	ec0080e7          	jalr	-320(ra) # 80021568 <copyin2>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    800226b0:	60e2                	ld	ra,24(sp)
    800226b2:	6442                	ld	s0,16(sp)
    800226b4:	64a2                	ld	s1,8(sp)
    800226b6:	6105                	addi	sp,sp,32
    800226b8:	8082                	ret
    memmove(dst, (char*)src, len);
    800226ba:	0006861b          	sext.w	a2,a3
    800226be:	ffffe097          	auipc	ra,0xffffe
    800226c2:	10a080e7          	jalr	266(ra) # 800207c8 <memmove>
    return 0;
    800226c6:	8526                	mv	a0,s1
    800226c8:	b7e5                	j	800226b0 <either_copyin+0x1a>

00000000800226ca <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800226ca:	715d                	addi	sp,sp,-80
    800226cc:	e486                	sd	ra,72(sp)
    800226ce:	e0a2                	sd	s0,64(sp)
    800226d0:	fc26                	sd	s1,56(sp)
    800226d2:	f84a                	sd	s2,48(sp)
    800226d4:	f44e                	sd	s3,40(sp)
    800226d6:	f052                	sd	s4,32(sp)
    800226d8:	ec56                	sd	s5,24(sp)
    800226da:	e85a                	sd	s6,16(sp)
    800226dc:	e45e                	sd	s7,8(sp)
    800226de:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\nPID\tSTATE\tNAME\tMEM\n");
    800226e0:	00009517          	auipc	a0,0x9
    800226e4:	f0850513          	addi	a0,a0,-248 # 8002b5e8 <states.1738+0x180>
    800226e8:	ffffe097          	auipc	ra,0xffffe
    800226ec:	aa8080e7          	jalr	-1368(ra) # 80020190 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800226f0:	00015497          	auipc	s1,0x15
    800226f4:	be848493          	addi	s1,s1,-1048 # 800372d8 <proc+0x160>
    800226f8:	00019917          	auipc	s2,0x19
    800226fc:	55090913          	addi	s2,s2,1360 # 8003bc48 <bcache+0x158>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80022700:	4b11                	li	s6,4
      state = states[p->state];
    else
      state = "???";
    80022702:	00009997          	auipc	s3,0x9
    80022706:	ede98993          	addi	s3,s3,-290 # 8002b5e0 <states.1738+0x178>
    printf("%d\t%s\t%s\t%d", p->pid, state, p->name, p->sz);
    8002270a:	00009a97          	auipc	s5,0x9
    8002270e:	ef6a8a93          	addi	s5,s5,-266 # 8002b600 <states.1738+0x198>
    printf("\n");
    80022712:	0000aa17          	auipc	s4,0xa
    80022716:	e1ea0a13          	addi	s4,s4,-482 # 8002c530 <sysnames+0x5b0>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8002271a:	00009b97          	auipc	s7,0x9
    8002271e:	d4eb8b93          	addi	s7,s7,-690 # 8002b468 <states.1738>
    80022722:	a025                	j	8002274a <procdump+0x80>
    printf("%d\t%s\t%s\t%d", p->pid, state, p->name, p->sz);
    80022724:	ee85b703          	ld	a4,-280(a1)
    80022728:	86ae                	mv	a3,a1
    8002272a:	ed85a583          	lw	a1,-296(a1)
    8002272e:	8556                	mv	a0,s5
    80022730:	ffffe097          	auipc	ra,0xffffe
    80022734:	a60080e7          	jalr	-1440(ra) # 80020190 <printf>
    printf("\n");
    80022738:	8552                	mv	a0,s4
    8002273a:	ffffe097          	auipc	ra,0xffffe
    8002273e:	a56080e7          	jalr	-1450(ra) # 80020190 <printf>
    80022742:	17848493          	addi	s1,s1,376
  for(p = proc; p < &proc[NPROC]; p++){
    80022746:	03248163          	beq	s1,s2,80022768 <procdump+0x9e>
    if(p->state == UNUSED)
    8002274a:	85a6                	mv	a1,s1
    8002274c:	eb84a783          	lw	a5,-328(s1)
    80022750:	dbed                	beqz	a5,80022742 <procdump+0x78>
      state = "???";
    80022752:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80022754:	fcfb68e3          	bltu	s6,a5,80022724 <procdump+0x5a>
    80022758:	1782                	slli	a5,a5,0x20
    8002275a:	9381                	srli	a5,a5,0x20
    8002275c:	078e                	slli	a5,a5,0x3
    8002275e:	97de                	add	a5,a5,s7
    80022760:	6390                	ld	a2,0(a5)
    80022762:	f269                	bnez	a2,80022724 <procdump+0x5a>
      state = "???";
    80022764:	864e                	mv	a2,s3
    80022766:	bf7d                	j	80022724 <procdump+0x5a>
  }
}
    80022768:	60a6                	ld	ra,72(sp)
    8002276a:	6406                	ld	s0,64(sp)
    8002276c:	74e2                	ld	s1,56(sp)
    8002276e:	7942                	ld	s2,48(sp)
    80022770:	79a2                	ld	s3,40(sp)
    80022772:	7a02                	ld	s4,32(sp)
    80022774:	6ae2                	ld	s5,24(sp)
    80022776:	6b42                	ld	s6,16(sp)
    80022778:	6ba2                	ld	s7,8(sp)
    8002277a:	6161                	addi	sp,sp,80
    8002277c:	8082                	ret

000000008002277e <procnum>:

uint64
procnum(void)
{
    8002277e:	1141                	addi	sp,sp,-16
    80022780:	e422                	sd	s0,8(sp)
    80022782:	0800                	addi	s0,sp,16
  int num = 0;
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++) {
    80022784:	00015797          	auipc	a5,0x15
    80022788:	9f478793          	addi	a5,a5,-1548 # 80037178 <proc>
  int num = 0;
    8002278c:	4501                	li	a0,0
  for (p = proc; p < &proc[NPROC]; p++) {
    8002278e:	00019697          	auipc	a3,0x19
    80022792:	35a68693          	addi	a3,a3,858 # 8003bae8 <initproc>
    80022796:	a029                	j	800227a0 <procnum+0x22>
    80022798:	17878793          	addi	a5,a5,376
    8002279c:	00d78663          	beq	a5,a3,800227a8 <procnum+0x2a>
    if (p->state != UNUSED) {
    800227a0:	4f98                	lw	a4,24(a5)
    800227a2:	db7d                	beqz	a4,80022798 <procnum+0x1a>
      num++;
    800227a4:	2505                	addiw	a0,a0,1
    800227a6:	bfcd                	j	80022798 <procnum+0x1a>
    }
  }

  return num;
}
    800227a8:	6422                	ld	s0,8(sp)
    800227aa:	0141                	addi	sp,sp,16
    800227ac:	8082                	ret

00000000800227ae <swtch>:
    800227ae:	00153023          	sd	ra,0(a0)
    800227b2:	00253423          	sd	sp,8(a0)
    800227b6:	e900                	sd	s0,16(a0)
    800227b8:	ed04                	sd	s1,24(a0)
    800227ba:	03253023          	sd	s2,32(a0)
    800227be:	03353423          	sd	s3,40(a0)
    800227c2:	03453823          	sd	s4,48(a0)
    800227c6:	03553c23          	sd	s5,56(a0)
    800227ca:	05653023          	sd	s6,64(a0)
    800227ce:	05753423          	sd	s7,72(a0)
    800227d2:	05853823          	sd	s8,80(a0)
    800227d6:	05953c23          	sd	s9,88(a0)
    800227da:	07a53023          	sd	s10,96(a0)
    800227de:	07b53423          	sd	s11,104(a0)
    800227e2:	0005b083          	ld	ra,0(a1)
    800227e6:	0085b103          	ld	sp,8(a1)
    800227ea:	6980                	ld	s0,16(a1)
    800227ec:	6d84                	ld	s1,24(a1)
    800227ee:	0205b903          	ld	s2,32(a1)
    800227f2:	0285b983          	ld	s3,40(a1)
    800227f6:	0305ba03          	ld	s4,48(a1)
    800227fa:	0385ba83          	ld	s5,56(a1)
    800227fe:	0405bb03          	ld	s6,64(a1)
    80022802:	0485bb83          	ld	s7,72(a1)
    80022806:	0505bc03          	ld	s8,80(a1)
    8002280a:	0585bc83          	ld	s9,88(a1)
    8002280e:	0605bd03          	ld	s10,96(a1)
    80022812:	0685bd83          	ld	s11,104(a1)
    80022816:	8082                	ret

0000000080022818 <trapinithart>:
// }

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80022818:	1141                	addi	sp,sp,-16
    8002281a:	e406                	sd	ra,8(sp)
    8002281c:	e022                	sd	s0,0(sp)
    8002281e:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80022820:	00003797          	auipc	a5,0x3
    80022824:	82078793          	addi	a5,a5,-2016 # 80025040 <kernelvec>
    80022828:	10579073          	csrw	stvec,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002282c:	100027f3          	csrr	a5,sstatus
  w_stvec((uint64)kernelvec);
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80022830:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022834:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80022838:	104027f3          	csrr	a5,sie
  // enable supervisor-mode timer interrupts.
  w_sie(r_sie() | SIE_SEIE | SIE_SSIE | SIE_STIE);
    8002283c:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80022840:	10479073          	csrw	sie,a5
  set_next_timeout();
    80022844:	00003097          	auipc	ra,0x3
    80022848:	8b2080e7          	jalr	-1870(ra) # 800250f6 <set_next_timeout>
  #ifdef DEBUG
  printf("trapinithart\n");
  #endif
}
    8002284c:	60a2                	ld	ra,8(sp)
    8002284e:	6402                	ld	s0,0(sp)
    80022850:	0141                	addi	sp,sp,16
    80022852:	8082                	ret

0000000080022854 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80022854:	1141                	addi	sp,sp,-16
    80022856:	e406                	sd	ra,8(sp)
    80022858:	e022                	sd	s0,0(sp)
    8002285a:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    8002285c:	fffff097          	auipc	ra,0xfffff
    80022860:	326080e7          	jalr	806(ra) # 80021b82 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022864:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80022868:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8002286a:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    8002286e:	00007617          	auipc	a2,0x7
    80022872:	79260613          	addi	a2,a2,1938 # 8002a000 <_trampoline>
    80022876:	00007697          	auipc	a3,0x7
    8002287a:	78a68693          	addi	a3,a3,1930 # 8002a000 <_trampoline>
    8002287e:	8e91                	sub	a3,a3,a2
    80022880:	040007b7          	lui	a5,0x4000
    80022884:	17fd                	addi	a5,a5,-1
    80022886:	07b2                	slli	a5,a5,0xc
    80022888:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    8002288a:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    8002288e:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80022890:	180026f3          	csrr	a3,satp
    80022894:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80022896:	7138                	ld	a4,96(a0)
    80022898:	6134                	ld	a3,64(a0)
    8002289a:	6585                	lui	a1,0x1
    8002289c:	96ae                	add	a3,a3,a1
    8002289e:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800228a0:	7138                	ld	a4,96(a0)
    800228a2:	00000697          	auipc	a3,0x0
    800228a6:	11a68693          	addi	a3,a3,282 # 800229bc <usertrap>
    800228aa:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800228ac:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800228ae:	8692                	mv	a3,tp
    800228b0:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800228b2:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800228b6:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800228ba:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800228be:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800228c2:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800228c4:	6f18                	ld	a4,24(a4)
    800228c6:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  // printf("[usertrapret]p->pagetable: %p\n", p->pagetable);
  uint64 satp = MAKE_SATP(p->pagetable);
    800228ca:	692c                	ld	a1,80(a0)
    800228cc:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    800228ce:	00007717          	auipc	a4,0x7
    800228d2:	7c270713          	addi	a4,a4,1986 # 8002a090 <userret>
    800228d6:	8f11                	sub	a4,a4,a2
    800228d8:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    800228da:	577d                	li	a4,-1
    800228dc:	177e                	slli	a4,a4,0x3f
    800228de:	8dd9                	or	a1,a1,a4
    800228e0:	02000537          	lui	a0,0x2000
    800228e4:	157d                	addi	a0,a0,-1
    800228e6:	0536                	slli	a0,a0,0xd
    800228e8:	9782                	jalr	a5
}
    800228ea:	60a2                	ld	ra,8(sp)
    800228ec:	6402                	ld	s0,0(sp)
    800228ee:	0141                	addi	sp,sp,16
    800228f0:	8082                	ret

00000000800228f2 <devintr>:
// Check if it's an external/software interrupt, 
// and handle it. 
// returns  2 if timer interrupt, 
//          1 if other device, 
//          0 if not recognized. 
int devintr(void) {
    800228f2:	1101                	addi	sp,sp,-32
    800228f4:	ec06                	sd	ra,24(sp)
    800228f6:	e822                	sd	s0,16(sp)
    800228f8:	e426                	sd	s1,8(sp)
    800228fa:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    800228fc:	14202773          	csrr	a4,scause
	if ((0x8000000000000000L & scause) && 9 == (scause & 0xff)) 
	#else 
	// on k210, supervisor software interrupt is used 
	// in alternative to supervisor external interrupt, 
	// which is not available on k210. 
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    80022900:	57fd                	li	a5,-1
    80022902:	17fe                	slli	a5,a5,0x3f
    80022904:	0785                	addi	a5,a5,1
    80022906:	00f70d63          	beq	a4,a5,80022920 <devintr+0x2e>
		sbi_set_mie();
		#endif 

		return 1;
	}
	else if (0x8000000000000005L == scause) {
    8002290a:	57fd                	li	a5,-1
    8002290c:	17fe                	slli	a5,a5,0x3f
    8002290e:	0795                	addi	a5,a5,5
		timer_tick();
		return 2;
	}
	else { return 0;}
    80022910:	4501                	li	a0,0
	else if (0x8000000000000005L == scause) {
    80022912:	08f70f63          	beq	a4,a5,800229b0 <devintr+0xbe>
}
    80022916:	60e2                	ld	ra,24(sp)
    80022918:	6442                	ld	s0,16(sp)
    8002291a:	64a2                	ld	s1,8(sp)
    8002291c:	6105                	addi	sp,sp,32
    8002291e:	8082                	ret
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022920:	14302773          	csrr	a4,stval
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    80022924:	47a5                	li	a5,9
	else { return 0;}
    80022926:	4501                	li	a0,0
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    80022928:	fef717e3          	bne	a4,a5,80022916 <devintr+0x24>
		int irq = plic_claim();
    8002292c:	00004097          	auipc	ra,0x4
    80022930:	232080e7          	jalr	562(ra) # 80026b5e <plic_claim>
    80022934:	84aa                	mv	s1,a0
		if (UART_IRQ == irq) {
    80022936:	02100793          	li	a5,33
    8002293a:	02f50663          	beq	a0,a5,80022966 <devintr+0x74>
		else if (DISK_IRQ == irq) {
    8002293e:	47ed                	li	a5,27
    80022940:	04f50963          	beq	a0,a5,80022992 <devintr+0xa0>
		else if (irq) {
    80022944:	ed21                	bnez	a0,8002299c <devintr+0xaa>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80022946:	144027f3          	csrr	a5,sip
		w_sip(r_sip() & ~2);    // clear pending bit
    8002294a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    8002294c:	14479073          	csrw	sip,a5
	asm volatile("mv a6, %0" : : "r" (0x210));
	SBI_CALL_1(0x0A000004, func_pointer);
}

static inline void sbi_set_mie(void) {
	SBI_CALL_0(0x0A000005);
    80022950:	4501                	li	a0,0
    80022952:	4581                	li	a1,0
    80022954:	4601                	li	a2,0
    80022956:	4681                	li	a3,0
    80022958:	0a0008b7          	lui	a7,0xa000
    8002295c:	0895                	addi	a7,a7,5
    8002295e:	00000073          	ecall
		return 1;
    80022962:	4505                	li	a0,1
    80022964:	bf4d                	j	80022916 <devintr+0x24>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
    80022966:	4501                	li	a0,0
    80022968:	4581                	li	a1,0
    8002296a:	4601                	li	a2,0
    8002296c:	4681                	li	a3,0
    8002296e:	4889                	li	a7,2
    80022970:	00000073          	ecall
    80022974:	2501                	sext.w	a0,a0
			if (-1 != c) {
    80022976:	57fd                	li	a5,-1
    80022978:	00f51863          	bne	a0,a5,80022988 <devintr+0x96>
		if (irq) { plic_complete(irq);}
    8002297c:	8526                	mv	a0,s1
    8002297e:	00004097          	auipc	ra,0x4
    80022982:	206080e7          	jalr	518(ra) # 80026b84 <plic_complete>
    80022986:	b7c1                	j	80022946 <devintr+0x54>
				consoleintr(c);
    80022988:	00004097          	auipc	ra,0x4
    8002298c:	408080e7          	jalr	1032(ra) # 80026d90 <consoleintr>
    80022990:	b7f5                	j	8002297c <devintr+0x8a>
			disk_intr();
    80022992:	00003097          	auipc	ra,0x3
    80022996:	82c080e7          	jalr	-2004(ra) # 800251be <disk_intr>
    8002299a:	b7cd                	j	8002297c <devintr+0x8a>
			printf("unexpected interrupt irq = %d\n", irq);
    8002299c:	85aa                	mv	a1,a0
    8002299e:	00009517          	auipc	a0,0x9
    800229a2:	c9a50513          	addi	a0,a0,-870 # 8002b638 <states.1738+0x1d0>
    800229a6:	ffffd097          	auipc	ra,0xffffd
    800229aa:	7ea080e7          	jalr	2026(ra) # 80020190 <printf>
    800229ae:	b7f9                	j	8002297c <devintr+0x8a>
		timer_tick();
    800229b0:	00002097          	auipc	ra,0x2
    800229b4:	76c080e7          	jalr	1900(ra) # 8002511c <timer_tick>
		return 2;
    800229b8:	4509                	li	a0,2
    800229ba:	bfb1                	j	80022916 <devintr+0x24>

00000000800229bc <usertrap>:
{
    800229bc:	1101                	addi	sp,sp,-32
    800229be:	ec06                	sd	ra,24(sp)
    800229c0:	e822                	sd	s0,16(sp)
    800229c2:	e426                	sd	s1,8(sp)
    800229c4:	e04a                	sd	s2,0(sp)
    800229c6:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800229c8:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    800229cc:	1007f793          	andi	a5,a5,256
    800229d0:	e3ad                	bnez	a5,80022a32 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    800229d2:	00002797          	auipc	a5,0x2
    800229d6:	66e78793          	addi	a5,a5,1646 # 80025040 <kernelvec>
    800229da:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800229de:	fffff097          	auipc	ra,0xfffff
    800229e2:	1a4080e7          	jalr	420(ra) # 80021b82 <myproc>
    800229e6:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    800229e8:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800229ea:	14102773          	csrr	a4,sepc
    800229ee:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    800229f0:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    800229f4:	47a1                	li	a5,8
    800229f6:	04f71c63          	bne	a4,a5,80022a4e <usertrap+0x92>
    if(p->killed)
    800229fa:	591c                	lw	a5,48(a0)
    800229fc:	e3b9                	bnez	a5,80022a42 <usertrap+0x86>
    p->trapframe->epc += 4;
    800229fe:	70b8                	ld	a4,96(s1)
    80022a00:	6f1c                	ld	a5,24(a4)
    80022a02:	0791                	addi	a5,a5,4
    80022a04:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022a06:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80022a0a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022a0e:	10079073          	csrw	sstatus,a5
    syscall();
    80022a12:	00000097          	auipc	ra,0x0
    80022a16:	5d4080e7          	jalr	1492(ra) # 80022fe6 <syscall>
  if(p->killed)
    80022a1a:	589c                	lw	a5,48(s1)
    80022a1c:	ebd1                	bnez	a5,80022ab0 <usertrap+0xf4>
  usertrapret();
    80022a1e:	00000097          	auipc	ra,0x0
    80022a22:	e36080e7          	jalr	-458(ra) # 80022854 <usertrapret>
}
    80022a26:	60e2                	ld	ra,24(sp)
    80022a28:	6442                	ld	s0,16(sp)
    80022a2a:	64a2                	ld	s1,8(sp)
    80022a2c:	6902                	ld	s2,0(sp)
    80022a2e:	6105                	addi	sp,sp,32
    80022a30:	8082                	ret
    panic("usertrap: not from user mode");
    80022a32:	00009517          	auipc	a0,0x9
    80022a36:	c2650513          	addi	a0,a0,-986 # 8002b658 <states.1738+0x1f0>
    80022a3a:	ffffd097          	auipc	ra,0xffffd
    80022a3e:	70c080e7          	jalr	1804(ra) # 80020146 <panic>
      exit(-1);
    80022a42:	557d                	li	a0,-1
    80022a44:	00000097          	auipc	ra,0x0
    80022a48:	888080e7          	jalr	-1912(ra) # 800222cc <exit>
    80022a4c:	bf4d                	j	800229fe <usertrap+0x42>
  else if((which_dev = devintr()) != 0){
    80022a4e:	00000097          	auipc	ra,0x0
    80022a52:	ea4080e7          	jalr	-348(ra) # 800228f2 <devintr>
    80022a56:	892a                	mv	s2,a0
    80022a58:	c501                	beqz	a0,80022a60 <usertrap+0xa4>
  if(p->killed)
    80022a5a:	589c                	lw	a5,48(s1)
    80022a5c:	c3b1                	beqz	a5,80022aa0 <usertrap+0xe4>
    80022a5e:	a825                	j	80022a96 <usertrap+0xda>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022a60:	142025f3          	csrr	a1,scause
    printf("\nusertrap(): unexpected scause %p pid=%d %s\n", r_scause(), p->pid, p->name);
    80022a64:	16048693          	addi	a3,s1,352
    80022a68:	5c90                	lw	a2,56(s1)
    80022a6a:	00009517          	auipc	a0,0x9
    80022a6e:	c0e50513          	addi	a0,a0,-1010 # 8002b678 <states.1738+0x210>
    80022a72:	ffffd097          	auipc	ra,0xffffd
    80022a76:	71e080e7          	jalr	1822(ra) # 80020190 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022a7a:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022a7e:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80022a82:	00009517          	auipc	a0,0x9
    80022a86:	c2650513          	addi	a0,a0,-986 # 8002b6a8 <states.1738+0x240>
    80022a8a:	ffffd097          	auipc	ra,0xffffd
    80022a8e:	706080e7          	jalr	1798(ra) # 80020190 <printf>
    p->killed = 1;
    80022a92:	4785                	li	a5,1
    80022a94:	d89c                	sw	a5,48(s1)
    exit(-1);
    80022a96:	557d                	li	a0,-1
    80022a98:	00000097          	auipc	ra,0x0
    80022a9c:	834080e7          	jalr	-1996(ra) # 800222cc <exit>
  if(which_dev == 2)
    80022aa0:	4789                	li	a5,2
    80022aa2:	f6f91ee3          	bne	s2,a5,80022a1e <usertrap+0x62>
    yield();
    80022aa6:	00000097          	auipc	ra,0x0
    80022aaa:	922080e7          	jalr	-1758(ra) # 800223c8 <yield>
    80022aae:	bf85                	j	80022a1e <usertrap+0x62>
  int which_dev = 0;
    80022ab0:	4901                	li	s2,0
    80022ab2:	b7d5                	j	80022a96 <usertrap+0xda>

0000000080022ab4 <kerneltrap>:
kerneltrap() {
    80022ab4:	7179                	addi	sp,sp,-48
    80022ab6:	f406                	sd	ra,40(sp)
    80022ab8:	f022                	sd	s0,32(sp)
    80022aba:	ec26                	sd	s1,24(sp)
    80022abc:	e84a                	sd	s2,16(sp)
    80022abe:	e44e                	sd	s3,8(sp)
    80022ac0:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022ac2:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022ac6:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022aca:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80022ace:	1004f793          	andi	a5,s1,256
    80022ad2:	cb85                	beqz	a5,80022b02 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022ad4:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80022ad8:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80022ada:	ef85                	bnez	a5,80022b12 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80022adc:	00000097          	auipc	ra,0x0
    80022ae0:	e16080e7          	jalr	-490(ra) # 800228f2 <devintr>
    80022ae4:	cd1d                	beqz	a0,80022b22 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    80022ae6:	4789                	li	a5,2
    80022ae8:	08f50b63          	beq	a0,a5,80022b7e <kerneltrap+0xca>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80022aec:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022af0:	10049073          	csrw	sstatus,s1
}
    80022af4:	70a2                	ld	ra,40(sp)
    80022af6:	7402                	ld	s0,32(sp)
    80022af8:	64e2                	ld	s1,24(sp)
    80022afa:	6942                	ld	s2,16(sp)
    80022afc:	69a2                	ld	s3,8(sp)
    80022afe:	6145                	addi	sp,sp,48
    80022b00:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80022b02:	00009517          	auipc	a0,0x9
    80022b06:	bc650513          	addi	a0,a0,-1082 # 8002b6c8 <states.1738+0x260>
    80022b0a:	ffffd097          	auipc	ra,0xffffd
    80022b0e:	63c080e7          	jalr	1596(ra) # 80020146 <panic>
    panic("kerneltrap: interrupts enabled");
    80022b12:	00009517          	auipc	a0,0x9
    80022b16:	bde50513          	addi	a0,a0,-1058 # 8002b6f0 <states.1738+0x288>
    80022b1a:	ffffd097          	auipc	ra,0xffffd
    80022b1e:	62c080e7          	jalr	1580(ra) # 80020146 <panic>
    printf("\nscause %p\n", scause);
    80022b22:	85ce                	mv	a1,s3
    80022b24:	00009517          	auipc	a0,0x9
    80022b28:	bec50513          	addi	a0,a0,-1044 # 8002b710 <states.1738+0x2a8>
    80022b2c:	ffffd097          	auipc	ra,0xffffd
    80022b30:	664080e7          	jalr	1636(ra) # 80020190 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022b34:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022b38:	14302673          	csrr	a2,stval
  asm volatile("mv %0, tp" : "=r" (x) );
    80022b3c:	8692                	mv	a3,tp
    printf("sepc=%p stval=%p hart=%d\n", r_sepc(), r_stval(), r_tp());
    80022b3e:	00009517          	auipc	a0,0x9
    80022b42:	be250513          	addi	a0,a0,-1054 # 8002b720 <states.1738+0x2b8>
    80022b46:	ffffd097          	auipc	ra,0xffffd
    80022b4a:	64a080e7          	jalr	1610(ra) # 80020190 <printf>
    struct proc *p = myproc();
    80022b4e:	fffff097          	auipc	ra,0xfffff
    80022b52:	034080e7          	jalr	52(ra) # 80021b82 <myproc>
    if (p != 0) {
    80022b56:	cd01                	beqz	a0,80022b6e <kerneltrap+0xba>
      printf("pid: %d, name: %s\n", p->pid, p->name);
    80022b58:	16050613          	addi	a2,a0,352
    80022b5c:	5d0c                	lw	a1,56(a0)
    80022b5e:	00009517          	auipc	a0,0x9
    80022b62:	be250513          	addi	a0,a0,-1054 # 8002b740 <states.1738+0x2d8>
    80022b66:	ffffd097          	auipc	ra,0xffffd
    80022b6a:	62a080e7          	jalr	1578(ra) # 80020190 <printf>
    panic("kerneltrap");
    80022b6e:	00009517          	auipc	a0,0x9
    80022b72:	bea50513          	addi	a0,a0,-1046 # 8002b758 <states.1738+0x2f0>
    80022b76:	ffffd097          	auipc	ra,0xffffd
    80022b7a:	5d0080e7          	jalr	1488(ra) # 80020146 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    80022b7e:	fffff097          	auipc	ra,0xfffff
    80022b82:	004080e7          	jalr	4(ra) # 80021b82 <myproc>
    80022b86:	d13d                	beqz	a0,80022aec <kerneltrap+0x38>
    80022b88:	fffff097          	auipc	ra,0xfffff
    80022b8c:	ffa080e7          	jalr	-6(ra) # 80021b82 <myproc>
    80022b90:	4d18                	lw	a4,24(a0)
    80022b92:	478d                	li	a5,3
    80022b94:	f4f71ce3          	bne	a4,a5,80022aec <kerneltrap+0x38>
    yield();
    80022b98:	00000097          	auipc	ra,0x0
    80022b9c:	830080e7          	jalr	-2000(ra) # 800223c8 <yield>
    80022ba0:	b7b1                	j	80022aec <kerneltrap+0x38>

0000000080022ba2 <trapframedump>:

void trapframedump(struct trapframe *tf)
{
    80022ba2:	1101                	addi	sp,sp,-32
    80022ba4:	ec06                	sd	ra,24(sp)
    80022ba6:	e822                	sd	s0,16(sp)
    80022ba8:	e426                	sd	s1,8(sp)
    80022baa:	1000                	addi	s0,sp,32
    80022bac:	84aa                	mv	s1,a0
  printf("a0: %p\t", tf->a0);
    80022bae:	792c                	ld	a1,112(a0)
    80022bb0:	00009517          	auipc	a0,0x9
    80022bb4:	bb850513          	addi	a0,a0,-1096 # 8002b768 <states.1738+0x300>
    80022bb8:	ffffd097          	auipc	ra,0xffffd
    80022bbc:	5d8080e7          	jalr	1496(ra) # 80020190 <printf>
  printf("a1: %p\t", tf->a1);
    80022bc0:	7cac                	ld	a1,120(s1)
    80022bc2:	00009517          	auipc	a0,0x9
    80022bc6:	bae50513          	addi	a0,a0,-1106 # 8002b770 <states.1738+0x308>
    80022bca:	ffffd097          	auipc	ra,0xffffd
    80022bce:	5c6080e7          	jalr	1478(ra) # 80020190 <printf>
  printf("a2: %p\t", tf->a2);
    80022bd2:	60cc                	ld	a1,128(s1)
    80022bd4:	00009517          	auipc	a0,0x9
    80022bd8:	ba450513          	addi	a0,a0,-1116 # 8002b778 <states.1738+0x310>
    80022bdc:	ffffd097          	auipc	ra,0xffffd
    80022be0:	5b4080e7          	jalr	1460(ra) # 80020190 <printf>
  printf("a3: %p\n", tf->a3);
    80022be4:	64cc                	ld	a1,136(s1)
    80022be6:	00009517          	auipc	a0,0x9
    80022bea:	b9a50513          	addi	a0,a0,-1126 # 8002b780 <states.1738+0x318>
    80022bee:	ffffd097          	auipc	ra,0xffffd
    80022bf2:	5a2080e7          	jalr	1442(ra) # 80020190 <printf>
  printf("a4: %p\t", tf->a4);
    80022bf6:	68cc                	ld	a1,144(s1)
    80022bf8:	00009517          	auipc	a0,0x9
    80022bfc:	b9050513          	addi	a0,a0,-1136 # 8002b788 <states.1738+0x320>
    80022c00:	ffffd097          	auipc	ra,0xffffd
    80022c04:	590080e7          	jalr	1424(ra) # 80020190 <printf>
  printf("a5: %p\t", tf->a5);
    80022c08:	6ccc                	ld	a1,152(s1)
    80022c0a:	00009517          	auipc	a0,0x9
    80022c0e:	b8650513          	addi	a0,a0,-1146 # 8002b790 <states.1738+0x328>
    80022c12:	ffffd097          	auipc	ra,0xffffd
    80022c16:	57e080e7          	jalr	1406(ra) # 80020190 <printf>
  printf("a6: %p\t", tf->a6);
    80022c1a:	70cc                	ld	a1,160(s1)
    80022c1c:	00009517          	auipc	a0,0x9
    80022c20:	b7c50513          	addi	a0,a0,-1156 # 8002b798 <states.1738+0x330>
    80022c24:	ffffd097          	auipc	ra,0xffffd
    80022c28:	56c080e7          	jalr	1388(ra) # 80020190 <printf>
  printf("a7: %p\n", tf->a7);
    80022c2c:	74cc                	ld	a1,168(s1)
    80022c2e:	00009517          	auipc	a0,0x9
    80022c32:	b7250513          	addi	a0,a0,-1166 # 8002b7a0 <states.1738+0x338>
    80022c36:	ffffd097          	auipc	ra,0xffffd
    80022c3a:	55a080e7          	jalr	1370(ra) # 80020190 <printf>
  printf("t0: %p\t", tf->t0);
    80022c3e:	64ac                	ld	a1,72(s1)
    80022c40:	00009517          	auipc	a0,0x9
    80022c44:	b6850513          	addi	a0,a0,-1176 # 8002b7a8 <states.1738+0x340>
    80022c48:	ffffd097          	auipc	ra,0xffffd
    80022c4c:	548080e7          	jalr	1352(ra) # 80020190 <printf>
  printf("t1: %p\t", tf->t1);
    80022c50:	68ac                	ld	a1,80(s1)
    80022c52:	00009517          	auipc	a0,0x9
    80022c56:	b5e50513          	addi	a0,a0,-1186 # 8002b7b0 <states.1738+0x348>
    80022c5a:	ffffd097          	auipc	ra,0xffffd
    80022c5e:	536080e7          	jalr	1334(ra) # 80020190 <printf>
  printf("t2: %p\t", tf->t2);
    80022c62:	6cac                	ld	a1,88(s1)
    80022c64:	00009517          	auipc	a0,0x9
    80022c68:	b5450513          	addi	a0,a0,-1196 # 8002b7b8 <states.1738+0x350>
    80022c6c:	ffffd097          	auipc	ra,0xffffd
    80022c70:	524080e7          	jalr	1316(ra) # 80020190 <printf>
  printf("t3: %p\n", tf->t3);
    80022c74:	1004b583          	ld	a1,256(s1)
    80022c78:	00009517          	auipc	a0,0x9
    80022c7c:	b4850513          	addi	a0,a0,-1208 # 8002b7c0 <states.1738+0x358>
    80022c80:	ffffd097          	auipc	ra,0xffffd
    80022c84:	510080e7          	jalr	1296(ra) # 80020190 <printf>
  printf("t4: %p\t", tf->t4);
    80022c88:	1084b583          	ld	a1,264(s1)
    80022c8c:	00009517          	auipc	a0,0x9
    80022c90:	b3c50513          	addi	a0,a0,-1220 # 8002b7c8 <states.1738+0x360>
    80022c94:	ffffd097          	auipc	ra,0xffffd
    80022c98:	4fc080e7          	jalr	1276(ra) # 80020190 <printf>
  printf("t5: %p\t", tf->t5);
    80022c9c:	1104b583          	ld	a1,272(s1)
    80022ca0:	00009517          	auipc	a0,0x9
    80022ca4:	b3050513          	addi	a0,a0,-1232 # 8002b7d0 <states.1738+0x368>
    80022ca8:	ffffd097          	auipc	ra,0xffffd
    80022cac:	4e8080e7          	jalr	1256(ra) # 80020190 <printf>
  printf("t6: %p\t", tf->t6);
    80022cb0:	1184b583          	ld	a1,280(s1)
    80022cb4:	00009517          	auipc	a0,0x9
    80022cb8:	b2450513          	addi	a0,a0,-1244 # 8002b7d8 <states.1738+0x370>
    80022cbc:	ffffd097          	auipc	ra,0xffffd
    80022cc0:	4d4080e7          	jalr	1236(ra) # 80020190 <printf>
  printf("s0: %p\n", tf->s0);
    80022cc4:	70ac                	ld	a1,96(s1)
    80022cc6:	00009517          	auipc	a0,0x9
    80022cca:	b1a50513          	addi	a0,a0,-1254 # 8002b7e0 <states.1738+0x378>
    80022cce:	ffffd097          	auipc	ra,0xffffd
    80022cd2:	4c2080e7          	jalr	1218(ra) # 80020190 <printf>
  printf("s1: %p\t", tf->s1);
    80022cd6:	74ac                	ld	a1,104(s1)
    80022cd8:	00009517          	auipc	a0,0x9
    80022cdc:	b1050513          	addi	a0,a0,-1264 # 8002b7e8 <states.1738+0x380>
    80022ce0:	ffffd097          	auipc	ra,0xffffd
    80022ce4:	4b0080e7          	jalr	1200(ra) # 80020190 <printf>
  printf("s2: %p\t", tf->s2);
    80022ce8:	78cc                	ld	a1,176(s1)
    80022cea:	00009517          	auipc	a0,0x9
    80022cee:	b0650513          	addi	a0,a0,-1274 # 8002b7f0 <states.1738+0x388>
    80022cf2:	ffffd097          	auipc	ra,0xffffd
    80022cf6:	49e080e7          	jalr	1182(ra) # 80020190 <printf>
  printf("s3: %p\t", tf->s3);
    80022cfa:	7ccc                	ld	a1,184(s1)
    80022cfc:	00009517          	auipc	a0,0x9
    80022d00:	afc50513          	addi	a0,a0,-1284 # 8002b7f8 <states.1738+0x390>
    80022d04:	ffffd097          	auipc	ra,0xffffd
    80022d08:	48c080e7          	jalr	1164(ra) # 80020190 <printf>
  printf("s4: %p\n", tf->s4);
    80022d0c:	60ec                	ld	a1,192(s1)
    80022d0e:	00009517          	auipc	a0,0x9
    80022d12:	af250513          	addi	a0,a0,-1294 # 8002b800 <states.1738+0x398>
    80022d16:	ffffd097          	auipc	ra,0xffffd
    80022d1a:	47a080e7          	jalr	1146(ra) # 80020190 <printf>
  printf("s5: %p\t", tf->s5);
    80022d1e:	64ec                	ld	a1,200(s1)
    80022d20:	00009517          	auipc	a0,0x9
    80022d24:	ae850513          	addi	a0,a0,-1304 # 8002b808 <states.1738+0x3a0>
    80022d28:	ffffd097          	auipc	ra,0xffffd
    80022d2c:	468080e7          	jalr	1128(ra) # 80020190 <printf>
  printf("s6: %p\t", tf->s6);
    80022d30:	68ec                	ld	a1,208(s1)
    80022d32:	00009517          	auipc	a0,0x9
    80022d36:	ade50513          	addi	a0,a0,-1314 # 8002b810 <states.1738+0x3a8>
    80022d3a:	ffffd097          	auipc	ra,0xffffd
    80022d3e:	456080e7          	jalr	1110(ra) # 80020190 <printf>
  printf("s7: %p\t", tf->s7);
    80022d42:	6cec                	ld	a1,216(s1)
    80022d44:	00009517          	auipc	a0,0x9
    80022d48:	ad450513          	addi	a0,a0,-1324 # 8002b818 <states.1738+0x3b0>
    80022d4c:	ffffd097          	auipc	ra,0xffffd
    80022d50:	444080e7          	jalr	1092(ra) # 80020190 <printf>
  printf("s8: %p\n", tf->s8);
    80022d54:	70ec                	ld	a1,224(s1)
    80022d56:	00009517          	auipc	a0,0x9
    80022d5a:	aca50513          	addi	a0,a0,-1334 # 8002b820 <states.1738+0x3b8>
    80022d5e:	ffffd097          	auipc	ra,0xffffd
    80022d62:	432080e7          	jalr	1074(ra) # 80020190 <printf>
  printf("s9: %p\t", tf->s9);
    80022d66:	74ec                	ld	a1,232(s1)
    80022d68:	00009517          	auipc	a0,0x9
    80022d6c:	ac050513          	addi	a0,a0,-1344 # 8002b828 <states.1738+0x3c0>
    80022d70:	ffffd097          	auipc	ra,0xffffd
    80022d74:	420080e7          	jalr	1056(ra) # 80020190 <printf>
  printf("s10: %p\t", tf->s10);
    80022d78:	78ec                	ld	a1,240(s1)
    80022d7a:	00009517          	auipc	a0,0x9
    80022d7e:	ab650513          	addi	a0,a0,-1354 # 8002b830 <states.1738+0x3c8>
    80022d82:	ffffd097          	auipc	ra,0xffffd
    80022d86:	40e080e7          	jalr	1038(ra) # 80020190 <printf>
  printf("s11: %p\t", tf->s11);
    80022d8a:	7cec                	ld	a1,248(s1)
    80022d8c:	00009517          	auipc	a0,0x9
    80022d90:	ab450513          	addi	a0,a0,-1356 # 8002b840 <states.1738+0x3d8>
    80022d94:	ffffd097          	auipc	ra,0xffffd
    80022d98:	3fc080e7          	jalr	1020(ra) # 80020190 <printf>
  printf("ra: %p\n", tf->ra);
    80022d9c:	748c                	ld	a1,40(s1)
    80022d9e:	00008517          	auipc	a0,0x8
    80022da2:	7a250513          	addi	a0,a0,1954 # 8002b540 <states.1738+0xd8>
    80022da6:	ffffd097          	auipc	ra,0xffffd
    80022daa:	3ea080e7          	jalr	1002(ra) # 80020190 <printf>
  printf("sp: %p\t", tf->sp);
    80022dae:	788c                	ld	a1,48(s1)
    80022db0:	00009517          	auipc	a0,0x9
    80022db4:	aa050513          	addi	a0,a0,-1376 # 8002b850 <states.1738+0x3e8>
    80022db8:	ffffd097          	auipc	ra,0xffffd
    80022dbc:	3d8080e7          	jalr	984(ra) # 80020190 <printf>
  printf("gp: %p\t", tf->gp);
    80022dc0:	7c8c                	ld	a1,56(s1)
    80022dc2:	00009517          	auipc	a0,0x9
    80022dc6:	a9650513          	addi	a0,a0,-1386 # 8002b858 <states.1738+0x3f0>
    80022dca:	ffffd097          	auipc	ra,0xffffd
    80022dce:	3c6080e7          	jalr	966(ra) # 80020190 <printf>
  printf("tp: %p\t", tf->tp);
    80022dd2:	60ac                	ld	a1,64(s1)
    80022dd4:	00009517          	auipc	a0,0x9
    80022dd8:	a8c50513          	addi	a0,a0,-1396 # 8002b860 <states.1738+0x3f8>
    80022ddc:	ffffd097          	auipc	ra,0xffffd
    80022de0:	3b4080e7          	jalr	948(ra) # 80020190 <printf>
  printf("epc: %p\n", tf->epc);
    80022de4:	6c8c                	ld	a1,24(s1)
    80022de6:	00009517          	auipc	a0,0x9
    80022dea:	a8250513          	addi	a0,a0,-1406 # 8002b868 <states.1738+0x400>
    80022dee:	ffffd097          	auipc	ra,0xffffd
    80022df2:	3a2080e7          	jalr	930(ra) # 80020190 <printf>
}
    80022df6:	60e2                	ld	ra,24(sp)
    80022df8:	6442                	ld	s0,16(sp)
    80022dfa:	64a2                	ld	s1,8(sp)
    80022dfc:	6105                	addi	sp,sp,32
    80022dfe:	8082                	ret

0000000080022e00 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80022e00:	1101                	addi	sp,sp,-32
    80022e02:	ec06                	sd	ra,24(sp)
    80022e04:	e822                	sd	s0,16(sp)
    80022e06:	e426                	sd	s1,8(sp)
    80022e08:	1000                	addi	s0,sp,32
    80022e0a:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80022e0c:	fffff097          	auipc	ra,0xfffff
    80022e10:	d76080e7          	jalr	-650(ra) # 80021b82 <myproc>
  switch (n) {
    80022e14:	4795                	li	a5,5
    80022e16:	0497e163          	bltu	a5,s1,80022e58 <argraw+0x58>
    80022e1a:	048a                	slli	s1,s1,0x2
    80022e1c:	00009717          	auipc	a4,0x9
    80022e20:	a5c70713          	addi	a4,a4,-1444 # 8002b878 <states.1738+0x410>
    80022e24:	94ba                	add	s1,s1,a4
    80022e26:	409c                	lw	a5,0(s1)
    80022e28:	97ba                	add	a5,a5,a4
    80022e2a:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80022e2c:	713c                	ld	a5,96(a0)
    80022e2e:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80022e30:	60e2                	ld	ra,24(sp)
    80022e32:	6442                	ld	s0,16(sp)
    80022e34:	64a2                	ld	s1,8(sp)
    80022e36:	6105                	addi	sp,sp,32
    80022e38:	8082                	ret
    return p->trapframe->a1;
    80022e3a:	713c                	ld	a5,96(a0)
    80022e3c:	7fa8                	ld	a0,120(a5)
    80022e3e:	bfcd                	j	80022e30 <argraw+0x30>
    return p->trapframe->a2;
    80022e40:	713c                	ld	a5,96(a0)
    80022e42:	63c8                	ld	a0,128(a5)
    80022e44:	b7f5                	j	80022e30 <argraw+0x30>
    return p->trapframe->a3;
    80022e46:	713c                	ld	a5,96(a0)
    80022e48:	67c8                	ld	a0,136(a5)
    80022e4a:	b7dd                	j	80022e30 <argraw+0x30>
    return p->trapframe->a4;
    80022e4c:	713c                	ld	a5,96(a0)
    80022e4e:	6bc8                	ld	a0,144(a5)
    80022e50:	b7c5                	j	80022e30 <argraw+0x30>
    return p->trapframe->a5;
    80022e52:	713c                	ld	a5,96(a0)
    80022e54:	6fc8                	ld	a0,152(a5)
    80022e56:	bfe9                	j	80022e30 <argraw+0x30>
  panic("argraw");
    80022e58:	00009517          	auipc	a0,0x9
    80022e5c:	69050513          	addi	a0,a0,1680 # 8002c4e8 <sysnames+0x568>
    80022e60:	ffffd097          	auipc	ra,0xffffd
    80022e64:	2e6080e7          	jalr	742(ra) # 80020146 <panic>

0000000080022e68 <sys_sysinfo>:
    return 0;
}

uint64
sys_sysinfo(void)
{
    80022e68:	7179                	addi	sp,sp,-48
    80022e6a:	f406                	sd	ra,40(sp)
    80022e6c:	f022                	sd	s0,32(sp)
    80022e6e:	ec26                	sd	s1,24(sp)
    80022e70:	1800                	addi	s0,sp,48
  *ip = argraw(n);
    80022e72:	4501                	li	a0,0
    80022e74:	00000097          	auipc	ra,0x0
    80022e78:	f8c080e7          	jalr	-116(ra) # 80022e00 <argraw>
    80022e7c:	84aa                	mv	s1,a0
  if (argaddr(0, &addr) < 0) {
    return -1;
  }

  struct sysinfo info;
  info.freemem = freemem_amount();
    80022e7e:	ffffd097          	auipc	ra,0xffffd
    80022e82:	73a080e7          	jalr	1850(ra) # 800205b8 <freemem_amount>
    80022e86:	fca43823          	sd	a0,-48(s0)
  info.nproc = procnum();
    80022e8a:	00000097          	auipc	ra,0x0
    80022e8e:	8f4080e7          	jalr	-1804(ra) # 8002277e <procnum>
    80022e92:	fca43c23          	sd	a0,-40(s0)

  // if (copyout(p->pagetable, addr, (char *)&info, sizeof(info)) < 0) {
  if (copyout2(addr, (char *)&info, sizeof(info)) < 0) {
    80022e96:	4641                	li	a2,16
    80022e98:	fd040593          	addi	a1,s0,-48
    80022e9c:	8526                	mv	a0,s1
    80022e9e:	ffffe097          	auipc	ra,0xffffe
    80022ea2:	5ea080e7          	jalr	1514(ra) # 80021488 <copyout2>
    return -1;
  }

  return 0;
    80022ea6:	957d                	srai	a0,a0,0x3f
    80022ea8:	70a2                	ld	ra,40(sp)
    80022eaa:	7402                	ld	s0,32(sp)
    80022eac:	64e2                	ld	s1,24(sp)
    80022eae:	6145                	addi	sp,sp,48
    80022eb0:	8082                	ret

0000000080022eb2 <fetchaddr>:
{
    80022eb2:	1101                	addi	sp,sp,-32
    80022eb4:	ec06                	sd	ra,24(sp)
    80022eb6:	e822                	sd	s0,16(sp)
    80022eb8:	e426                	sd	s1,8(sp)
    80022eba:	e04a                	sd	s2,0(sp)
    80022ebc:	1000                	addi	s0,sp,32
    80022ebe:	84aa                	mv	s1,a0
    80022ec0:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80022ec2:	fffff097          	auipc	ra,0xfffff
    80022ec6:	cc0080e7          	jalr	-832(ra) # 80021b82 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80022eca:	653c                	ld	a5,72(a0)
    80022ecc:	02f4f763          	bgeu	s1,a5,80022efa <fetchaddr+0x48>
    80022ed0:	00848713          	addi	a4,s1,8
    80022ed4:	02e7e563          	bltu	a5,a4,80022efe <fetchaddr+0x4c>
  if(copyin2((char *)ip, addr, sizeof(*ip)) != 0)
    80022ed8:	4621                	li	a2,8
    80022eda:	85a6                	mv	a1,s1
    80022edc:	854a                	mv	a0,s2
    80022ede:	ffffe097          	auipc	ra,0xffffe
    80022ee2:	68a080e7          	jalr	1674(ra) # 80021568 <copyin2>
    80022ee6:	00a03533          	snez	a0,a0
    80022eea:	40a00533          	neg	a0,a0
}
    80022eee:	60e2                	ld	ra,24(sp)
    80022ef0:	6442                	ld	s0,16(sp)
    80022ef2:	64a2                	ld	s1,8(sp)
    80022ef4:	6902                	ld	s2,0(sp)
    80022ef6:	6105                	addi	sp,sp,32
    80022ef8:	8082                	ret
    return -1;
    80022efa:	557d                	li	a0,-1
    80022efc:	bfcd                	j	80022eee <fetchaddr+0x3c>
    80022efe:	557d                	li	a0,-1
    80022f00:	b7fd                	j	80022eee <fetchaddr+0x3c>

0000000080022f02 <fetchstr>:
{
    80022f02:	1101                	addi	sp,sp,-32
    80022f04:	ec06                	sd	ra,24(sp)
    80022f06:	e822                	sd	s0,16(sp)
    80022f08:	e426                	sd	s1,8(sp)
    80022f0a:	1000                	addi	s0,sp,32
    80022f0c:	84ae                	mv	s1,a1
  int err = copyinstr2(buf, addr, max);
    80022f0e:	85aa                	mv	a1,a0
    80022f10:	8526                	mv	a0,s1
    80022f12:	ffffe097          	auipc	ra,0xffffe
    80022f16:	76e080e7          	jalr	1902(ra) # 80021680 <copyinstr2>
  if(err < 0)
    80022f1a:	00054763          	bltz	a0,80022f28 <fetchstr+0x26>
  return strlen(buf);
    80022f1e:	8526                	mv	a0,s1
    80022f20:	ffffe097          	auipc	ra,0xffffe
    80022f24:	9e6080e7          	jalr	-1562(ra) # 80020906 <strlen>
}
    80022f28:	60e2                	ld	ra,24(sp)
    80022f2a:	6442                	ld	s0,16(sp)
    80022f2c:	64a2                	ld	s1,8(sp)
    80022f2e:	6105                	addi	sp,sp,32
    80022f30:	8082                	ret

0000000080022f32 <argint>:
{
    80022f32:	1101                	addi	sp,sp,-32
    80022f34:	ec06                	sd	ra,24(sp)
    80022f36:	e822                	sd	s0,16(sp)
    80022f38:	e426                	sd	s1,8(sp)
    80022f3a:	1000                	addi	s0,sp,32
    80022f3c:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80022f3e:	00000097          	auipc	ra,0x0
    80022f42:	ec2080e7          	jalr	-318(ra) # 80022e00 <argraw>
    80022f46:	c088                	sw	a0,0(s1)
}
    80022f48:	4501                	li	a0,0
    80022f4a:	60e2                	ld	ra,24(sp)
    80022f4c:	6442                	ld	s0,16(sp)
    80022f4e:	64a2                	ld	s1,8(sp)
    80022f50:	6105                	addi	sp,sp,32
    80022f52:	8082                	ret

0000000080022f54 <sys_test_proc>:
sys_test_proc(void) {
    80022f54:	1101                	addi	sp,sp,-32
    80022f56:	ec06                	sd	ra,24(sp)
    80022f58:	e822                	sd	s0,16(sp)
    80022f5a:	1000                	addi	s0,sp,32
    argint(0, &n);
    80022f5c:	fec40593          	addi	a1,s0,-20
    80022f60:	4501                	li	a0,0
    80022f62:	00000097          	auipc	ra,0x0
    80022f66:	fd0080e7          	jalr	-48(ra) # 80022f32 <argint>
    printf("hello world from proc %d, hart %d, arg %d\n", myproc()->pid, r_tp(), n);
    80022f6a:	fffff097          	auipc	ra,0xfffff
    80022f6e:	c18080e7          	jalr	-1000(ra) # 80021b82 <myproc>
    80022f72:	8612                	mv	a2,tp
    80022f74:	fec42683          	lw	a3,-20(s0)
    80022f78:	5d0c                	lw	a1,56(a0)
    80022f7a:	00009517          	auipc	a0,0x9
    80022f7e:	57650513          	addi	a0,a0,1398 # 8002c4f0 <sysnames+0x570>
    80022f82:	ffffd097          	auipc	ra,0xffffd
    80022f86:	20e080e7          	jalr	526(ra) # 80020190 <printf>
}
    80022f8a:	4501                	li	a0,0
    80022f8c:	60e2                	ld	ra,24(sp)
    80022f8e:	6442                	ld	s0,16(sp)
    80022f90:	6105                	addi	sp,sp,32
    80022f92:	8082                	ret

0000000080022f94 <argaddr>:
{
    80022f94:	1101                	addi	sp,sp,-32
    80022f96:	ec06                	sd	ra,24(sp)
    80022f98:	e822                	sd	s0,16(sp)
    80022f9a:	e426                	sd	s1,8(sp)
    80022f9c:	1000                	addi	s0,sp,32
    80022f9e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80022fa0:	00000097          	auipc	ra,0x0
    80022fa4:	e60080e7          	jalr	-416(ra) # 80022e00 <argraw>
    80022fa8:	e088                	sd	a0,0(s1)
}
    80022faa:	4501                	li	a0,0
    80022fac:	60e2                	ld	ra,24(sp)
    80022fae:	6442                	ld	s0,16(sp)
    80022fb0:	64a2                	ld	s1,8(sp)
    80022fb2:	6105                	addi	sp,sp,32
    80022fb4:	8082                	ret

0000000080022fb6 <argstr>:
{
    80022fb6:	1101                	addi	sp,sp,-32
    80022fb8:	ec06                	sd	ra,24(sp)
    80022fba:	e822                	sd	s0,16(sp)
    80022fbc:	e426                	sd	s1,8(sp)
    80022fbe:	e04a                	sd	s2,0(sp)
    80022fc0:	1000                	addi	s0,sp,32
    80022fc2:	84ae                	mv	s1,a1
    80022fc4:	8932                	mv	s2,a2
  *ip = argraw(n);
    80022fc6:	00000097          	auipc	ra,0x0
    80022fca:	e3a080e7          	jalr	-454(ra) # 80022e00 <argraw>
  return fetchstr(addr, buf, max);
    80022fce:	864a                	mv	a2,s2
    80022fd0:	85a6                	mv	a1,s1
    80022fd2:	00000097          	auipc	ra,0x0
    80022fd6:	f30080e7          	jalr	-208(ra) # 80022f02 <fetchstr>
}
    80022fda:	60e2                	ld	ra,24(sp)
    80022fdc:	6442                	ld	s0,16(sp)
    80022fde:	64a2                	ld	s1,8(sp)
    80022fe0:	6902                	ld	s2,0(sp)
    80022fe2:	6105                	addi	sp,sp,32
    80022fe4:	8082                	ret

0000000080022fe6 <syscall>:
{
    80022fe6:	7179                	addi	sp,sp,-48
    80022fe8:	f406                	sd	ra,40(sp)
    80022fea:	f022                	sd	s0,32(sp)
    80022fec:	ec26                	sd	s1,24(sp)
    80022fee:	e84a                	sd	s2,16(sp)
    80022ff0:	e44e                	sd	s3,8(sp)
    80022ff2:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80022ff4:	fffff097          	auipc	ra,0xfffff
    80022ff8:	b8e080e7          	jalr	-1138(ra) # 80021b82 <myproc>
    80022ffc:	84aa                	mv	s1,a0
  num = p->trapframe->a7;
    80022ffe:	06053983          	ld	s3,96(a0)
    80023002:	0a89b783          	ld	a5,168(s3)
    80023006:	0007891b          	sext.w	s2,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    8002300a:	37fd                	addiw	a5,a5,-1
    8002300c:	0dc00713          	li	a4,220
    80023010:	04f76863          	bltu	a4,a5,80023060 <syscall+0x7a>
    80023014:	00391713          	slli	a4,s2,0x3
    80023018:	00009797          	auipc	a5,0x9
    8002301c:	87878793          	addi	a5,a5,-1928 # 8002b890 <syscalls>
    80023020:	97ba                	add	a5,a5,a4
    80023022:	639c                	ld	a5,0(a5)
    80023024:	cf95                	beqz	a5,80023060 <syscall+0x7a>
    p->trapframe->a0 = syscalls[num]();
    80023026:	9782                	jalr	a5
    80023028:	06a9b823          	sd	a0,112(s3)
    if ((p->tmask & (1 << num)) != 0) {
    8002302c:	1704a783          	lw	a5,368(s1)
    80023030:	4127d7bb          	sraw	a5,a5,s2
    80023034:	8b85                	andi	a5,a5,1
    80023036:	c7a1                	beqz	a5,8002307e <syscall+0x98>
      printf("pid %d: %s -> %d\n", p->pid, sysnames[num], p->trapframe->a0);
    80023038:	70b8                	ld	a4,96(s1)
    8002303a:	090e                	slli	s2,s2,0x3
    8002303c:	00009797          	auipc	a5,0x9
    80023040:	85478793          	addi	a5,a5,-1964 # 8002b890 <syscalls>
    80023044:	993e                	add	s2,s2,a5
    80023046:	7b34                	ld	a3,112(a4)
    80023048:	6f093603          	ld	a2,1776(s2)
    8002304c:	5c8c                	lw	a1,56(s1)
    8002304e:	00009517          	auipc	a0,0x9
    80023052:	4d250513          	addi	a0,a0,1234 # 8002c520 <sysnames+0x5a0>
    80023056:	ffffd097          	auipc	ra,0xffffd
    8002305a:	13a080e7          	jalr	314(ra) # 80020190 <printf>
    8002305e:	a005                	j	8002307e <syscall+0x98>
    printf("pid %d %s: unknown sys call %d\n",
    80023060:	86ca                	mv	a3,s2
    80023062:	16048613          	addi	a2,s1,352
    80023066:	5c8c                	lw	a1,56(s1)
    80023068:	00009517          	auipc	a0,0x9
    8002306c:	4d050513          	addi	a0,a0,1232 # 8002c538 <sysnames+0x5b8>
    80023070:	ffffd097          	auipc	ra,0xffffd
    80023074:	120080e7          	jalr	288(ra) # 80020190 <printf>
    p->trapframe->a0 = -1;
    80023078:	70bc                	ld	a5,96(s1)
    8002307a:	577d                	li	a4,-1
    8002307c:	fbb8                	sd	a4,112(a5)
}
    8002307e:	70a2                	ld	ra,40(sp)
    80023080:	7402                	ld	s0,32(sp)
    80023082:	64e2                	ld	s1,24(sp)
    80023084:	6942                	ld	s2,16(sp)
    80023086:	69a2                	ld	s3,8(sp)
    80023088:	6145                	addi	sp,sp,48
    8002308a:	8082                	ret

000000008002308c <sys_exec>:

extern int exec(char *path, char **argv);

uint64
sys_exec(void)
{
    8002308c:	da010113          	addi	sp,sp,-608
    80023090:	24113c23          	sd	ra,600(sp)
    80023094:	24813823          	sd	s0,592(sp)
    80023098:	24913423          	sd	s1,584(sp)
    8002309c:	25213023          	sd	s2,576(sp)
    800230a0:	23313c23          	sd	s3,568(sp)
    800230a4:	23413823          	sd	s4,560(sp)
    800230a8:	23513423          	sd	s5,552(sp)
    800230ac:	1480                	addi	s0,sp,608
  char path[FAT32_MAX_PATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argaddr(1, &uargv) < 0){
    800230ae:	10400613          	li	a2,260
    800230b2:	eb840593          	addi	a1,s0,-328
    800230b6:	4501                	li	a0,0
    800230b8:	00000097          	auipc	ra,0x0
    800230bc:	efe080e7          	jalr	-258(ra) # 80022fb6 <argstr>
    return -1;
    800230c0:	597d                	li	s2,-1
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argaddr(1, &uargv) < 0){
    800230c2:	0e054c63          	bltz	a0,800231ba <sys_exec+0x12e>
    800230c6:	db040593          	addi	a1,s0,-592
    800230ca:	4505                	li	a0,1
    800230cc:	00000097          	auipc	ra,0x0
    800230d0:	ec8080e7          	jalr	-312(ra) # 80022f94 <argaddr>
    800230d4:	0e054363          	bltz	a0,800231ba <sys_exec+0x12e>
  }
  memset(argv, 0, sizeof(argv));
    800230d8:	db840913          	addi	s2,s0,-584
    800230dc:	10000613          	li	a2,256
    800230e0:	4581                	li	a1,0
    800230e2:	854a                	mv	a0,s2
    800230e4:	ffffd097          	auipc	ra,0xffffd
    800230e8:	678080e7          	jalr	1656(ra) # 8002075c <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800230ec:	89ca                	mv	s3,s2
  memset(argv, 0, sizeof(argv));
    800230ee:	4481                	li	s1,0
    if(i >= NELEM(argv)){
    800230f0:	02000a93          	li	s5,32
    800230f4:	00048a1b          	sext.w	s4,s1
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800230f8:	00349513          	slli	a0,s1,0x3
    800230fc:	da840593          	addi	a1,s0,-600
    80023100:	db043783          	ld	a5,-592(s0)
    80023104:	953e                	add	a0,a0,a5
    80023106:	00000097          	auipc	ra,0x0
    8002310a:	dac080e7          	jalr	-596(ra) # 80022eb2 <fetchaddr>
    8002310e:	02054a63          	bltz	a0,80023142 <sys_exec+0xb6>
      goto bad;
    }
    if(uarg == 0){
    80023112:	da843783          	ld	a5,-600(s0)
    80023116:	cfa9                	beqz	a5,80023170 <sys_exec+0xe4>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80023118:	ffffd097          	auipc	ra,0xffffd
    8002311c:	43a080e7          	jalr	1082(ra) # 80020552 <kalloc>
    80023120:	00a93023          	sd	a0,0(s2)
    if(argv[i] == 0)
    80023124:	cd19                	beqz	a0,80023142 <sys_exec+0xb6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80023126:	6605                	lui	a2,0x1
    80023128:	85aa                	mv	a1,a0
    8002312a:	da843503          	ld	a0,-600(s0)
    8002312e:	00000097          	auipc	ra,0x0
    80023132:	dd4080e7          	jalr	-556(ra) # 80022f02 <fetchstr>
    80023136:	00054663          	bltz	a0,80023142 <sys_exec+0xb6>
    if(i >= NELEM(argv)){
    8002313a:	0485                	addi	s1,s1,1
    8002313c:	0921                	addi	s2,s2,8
    8002313e:	fb549be3          	bne	s1,s5,800230f4 <sys_exec+0x68>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80023142:	db843503          	ld	a0,-584(s0)
    kfree(argv[i]);
  return -1;
    80023146:	597d                	li	s2,-1
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80023148:	c92d                	beqz	a0,800231ba <sys_exec+0x12e>
    kfree(argv[i]);
    8002314a:	ffffd097          	auipc	ra,0xffffd
    8002314e:	2ee080e7          	jalr	750(ra) # 80020438 <kfree>
    80023152:	dc040493          	addi	s1,s0,-576
    80023156:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002315a:	6088                	ld	a0,0(s1)
    8002315c:	cd31                	beqz	a0,800231b8 <sys_exec+0x12c>
    kfree(argv[i]);
    8002315e:	ffffd097          	auipc	ra,0xffffd
    80023162:	2da080e7          	jalr	730(ra) # 80020438 <kfree>
    80023166:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80023168:	ff3499e3          	bne	s1,s3,8002315a <sys_exec+0xce>
  return -1;
    8002316c:	597d                	li	s2,-1
    8002316e:	a0b1                	j	800231ba <sys_exec+0x12e>
      argv[i] = 0;
    80023170:	0a0e                	slli	s4,s4,0x3
    80023172:	fc040793          	addi	a5,s0,-64
    80023176:	9a3e                	add	s4,s4,a5
    80023178:	de0a3c23          	sd	zero,-520(s4)
  int ret = exec(path, argv);
    8002317c:	db840593          	addi	a1,s0,-584
    80023180:	eb840513          	addi	a0,s0,-328
    80023184:	00001097          	auipc	ra,0x1
    80023188:	eba080e7          	jalr	-326(ra) # 8002403e <exec>
    8002318c:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002318e:	db843503          	ld	a0,-584(s0)
    80023192:	c505                	beqz	a0,800231ba <sys_exec+0x12e>
    kfree(argv[i]);
    80023194:	ffffd097          	auipc	ra,0xffffd
    80023198:	2a4080e7          	jalr	676(ra) # 80020438 <kfree>
    8002319c:	dc040493          	addi	s1,s0,-576
    800231a0:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800231a4:	6088                	ld	a0,0(s1)
    800231a6:	c911                	beqz	a0,800231ba <sys_exec+0x12e>
    kfree(argv[i]);
    800231a8:	ffffd097          	auipc	ra,0xffffd
    800231ac:	290080e7          	jalr	656(ra) # 80020438 <kfree>
    800231b0:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800231b2:	ff3499e3          	bne	s1,s3,800231a4 <sys_exec+0x118>
    800231b6:	a011                	j	800231ba <sys_exec+0x12e>
  return -1;
    800231b8:	597d                	li	s2,-1
}
    800231ba:	854a                	mv	a0,s2
    800231bc:	25813083          	ld	ra,600(sp)
    800231c0:	25013403          	ld	s0,592(sp)
    800231c4:	24813483          	ld	s1,584(sp)
    800231c8:	24013903          	ld	s2,576(sp)
    800231cc:	23813983          	ld	s3,568(sp)
    800231d0:	23013a03          	ld	s4,560(sp)
    800231d4:	22813a83          	ld	s5,552(sp)
    800231d8:	26010113          	addi	sp,sp,608
    800231dc:	8082                	ret

00000000800231de <sys_exit>:

uint64
sys_exit(void)
{
    800231de:	1101                	addi	sp,sp,-32
    800231e0:	ec06                	sd	ra,24(sp)
    800231e2:	e822                	sd	s0,16(sp)
    800231e4:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    800231e6:	fec40593          	addi	a1,s0,-20
    800231ea:	4501                	li	a0,0
    800231ec:	00000097          	auipc	ra,0x0
    800231f0:	d46080e7          	jalr	-698(ra) # 80022f32 <argint>
    return -1;
    800231f4:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800231f6:	00054963          	bltz	a0,80023208 <sys_exit+0x2a>
  exit(n);
    800231fa:	fec42503          	lw	a0,-20(s0)
    800231fe:	fffff097          	auipc	ra,0xfffff
    80023202:	0ce080e7          	jalr	206(ra) # 800222cc <exit>
  return 0;  // not reached
    80023206:	4781                	li	a5,0
}
    80023208:	853e                	mv	a0,a5
    8002320a:	60e2                	ld	ra,24(sp)
    8002320c:	6442                	ld	s0,16(sp)
    8002320e:	6105                	addi	sp,sp,32
    80023210:	8082                	ret

0000000080023212 <sys_getpid>:

uint64
sys_getpid(void)
{
    80023212:	1141                	addi	sp,sp,-16
    80023214:	e406                	sd	ra,8(sp)
    80023216:	e022                	sd	s0,0(sp)
    80023218:	0800                	addi	s0,sp,16
  return myproc()->pid;
    8002321a:	fffff097          	auipc	ra,0xfffff
    8002321e:	968080e7          	jalr	-1688(ra) # 80021b82 <myproc>
}
    80023222:	5d08                	lw	a0,56(a0)
    80023224:	60a2                	ld	ra,8(sp)
    80023226:	6402                	ld	s0,0(sp)
    80023228:	0141                	addi	sp,sp,16
    8002322a:	8082                	ret

000000008002322c <sys_fork>:

uint64
sys_fork(void)
{
    8002322c:	1141                	addi	sp,sp,-16
    8002322e:	e406                	sd	ra,8(sp)
    80023230:	e022                	sd	s0,0(sp)
    80023232:	0800                	addi	s0,sp,16
  return fork();
    80023234:	fffff097          	auipc	ra,0xfffff
    80023238:	d5c080e7          	jalr	-676(ra) # 80021f90 <fork>
}
    8002323c:	60a2                	ld	ra,8(sp)
    8002323e:	6402                	ld	s0,0(sp)
    80023240:	0141                	addi	sp,sp,16
    80023242:	8082                	ret

0000000080023244 <sys_wait>:

uint64
sys_wait(void)
{
    80023244:	1101                	addi	sp,sp,-32
    80023246:	ec06                	sd	ra,24(sp)
    80023248:	e822                	sd	s0,16(sp)
    8002324a:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    8002324c:	fe840593          	addi	a1,s0,-24
    80023250:	4501                	li	a0,0
    80023252:	00000097          	auipc	ra,0x0
    80023256:	d42080e7          	jalr	-702(ra) # 80022f94 <argaddr>
    return -1;
    8002325a:	57fd                	li	a5,-1
  if(argaddr(0, &p) < 0)
    8002325c:	00054963          	bltz	a0,8002326e <sys_wait+0x2a>
  return wait(p);
    80023260:	fe843503          	ld	a0,-24(s0)
    80023264:	fffff097          	auipc	ra,0xfffff
    80023268:	21e080e7          	jalr	542(ra) # 80022482 <wait>
    8002326c:	87aa                	mv	a5,a0
}
    8002326e:	853e                	mv	a0,a5
    80023270:	60e2                	ld	ra,24(sp)
    80023272:	6442                	ld	s0,16(sp)
    80023274:	6105                	addi	sp,sp,32
    80023276:	8082                	ret

0000000080023278 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80023278:	7179                	addi	sp,sp,-48
    8002327a:	f406                	sd	ra,40(sp)
    8002327c:	f022                	sd	s0,32(sp)
    8002327e:	ec26                	sd	s1,24(sp)
    80023280:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80023282:	fdc40593          	addi	a1,s0,-36
    80023286:	4501                	li	a0,0
    80023288:	00000097          	auipc	ra,0x0
    8002328c:	caa080e7          	jalr	-854(ra) # 80022f32 <argint>
    return -1;
    80023290:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    80023292:	00054f63          	bltz	a0,800232b0 <sys_sbrk+0x38>
  addr = myproc()->sz;
    80023296:	fffff097          	auipc	ra,0xfffff
    8002329a:	8ec080e7          	jalr	-1812(ra) # 80021b82 <myproc>
    8002329e:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    800232a0:	fdc42503          	lw	a0,-36(s0)
    800232a4:	fffff097          	auipc	ra,0xfffff
    800232a8:	c6c080e7          	jalr	-916(ra) # 80021f10 <growproc>
    800232ac:	00054863          	bltz	a0,800232bc <sys_sbrk+0x44>
    return -1;
  return addr;
}
    800232b0:	8526                	mv	a0,s1
    800232b2:	70a2                	ld	ra,40(sp)
    800232b4:	7402                	ld	s0,32(sp)
    800232b6:	64e2                	ld	s1,24(sp)
    800232b8:	6145                	addi	sp,sp,48
    800232ba:	8082                	ret
    return -1;
    800232bc:	54fd                	li	s1,-1
    800232be:	bfcd                	j	800232b0 <sys_sbrk+0x38>

00000000800232c0 <sys_sleep>:

uint64
sys_sleep(void)
{
    800232c0:	7139                	addi	sp,sp,-64
    800232c2:	fc06                	sd	ra,56(sp)
    800232c4:	f822                	sd	s0,48(sp)
    800232c6:	f426                	sd	s1,40(sp)
    800232c8:	f04a                	sd	s2,32(sp)
    800232ca:	ec4e                	sd	s3,24(sp)
    800232cc:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800232ce:	fcc40593          	addi	a1,s0,-52
    800232d2:	4501                	li	a0,0
    800232d4:	00000097          	auipc	ra,0x0
    800232d8:	c5e080e7          	jalr	-930(ra) # 80022f32 <argint>
    return -1;
    800232dc:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800232de:	06054763          	bltz	a0,8002334c <sys_sleep+0x8c>
  acquire(&tickslock);
    800232e2:	0001e517          	auipc	a0,0x1e
    800232e6:	12650513          	addi	a0,a0,294 # 80041408 <tickslock>
    800232ea:	ffffd097          	auipc	ra,0xffffd
    800232ee:	3d6080e7          	jalr	982(ra) # 800206c0 <acquire>
  ticks0 = ticks;
    800232f2:	0001e797          	auipc	a5,0x1e
    800232f6:	12e78793          	addi	a5,a5,302 # 80041420 <ticks>
    800232fa:	0007a903          	lw	s2,0(a5)
  while(ticks - ticks0 < n){
    800232fe:	fcc42783          	lw	a5,-52(s0)
    80023302:	cf85                	beqz	a5,8002333a <sys_sleep+0x7a>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80023304:	0001e997          	auipc	s3,0x1e
    80023308:	10498993          	addi	s3,s3,260 # 80041408 <tickslock>
    8002330c:	0001e497          	auipc	s1,0x1e
    80023310:	11448493          	addi	s1,s1,276 # 80041420 <ticks>
    if(myproc()->killed){
    80023314:	fffff097          	auipc	ra,0xfffff
    80023318:	86e080e7          	jalr	-1938(ra) # 80021b82 <myproc>
    8002331c:	591c                	lw	a5,48(a0)
    8002331e:	ef9d                	bnez	a5,8002335c <sys_sleep+0x9c>
    sleep(&ticks, &tickslock);
    80023320:	85ce                	mv	a1,s3
    80023322:	8526                	mv	a0,s1
    80023324:	fffff097          	auipc	ra,0xfffff
    80023328:	0e0080e7          	jalr	224(ra) # 80022404 <sleep>
  while(ticks - ticks0 < n){
    8002332c:	409c                	lw	a5,0(s1)
    8002332e:	412787bb          	subw	a5,a5,s2
    80023332:	fcc42703          	lw	a4,-52(s0)
    80023336:	fce7efe3          	bltu	a5,a4,80023314 <sys_sleep+0x54>
  }
  release(&tickslock);
    8002333a:	0001e517          	auipc	a0,0x1e
    8002333e:	0ce50513          	addi	a0,a0,206 # 80041408 <tickslock>
    80023342:	ffffd097          	auipc	ra,0xffffd
    80023346:	3d2080e7          	jalr	978(ra) # 80020714 <release>
  return 0;
    8002334a:	4781                	li	a5,0
}
    8002334c:	853e                	mv	a0,a5
    8002334e:	70e2                	ld	ra,56(sp)
    80023350:	7442                	ld	s0,48(sp)
    80023352:	74a2                	ld	s1,40(sp)
    80023354:	7902                	ld	s2,32(sp)
    80023356:	69e2                	ld	s3,24(sp)
    80023358:	6121                	addi	sp,sp,64
    8002335a:	8082                	ret
      release(&tickslock);
    8002335c:	0001e517          	auipc	a0,0x1e
    80023360:	0ac50513          	addi	a0,a0,172 # 80041408 <tickslock>
    80023364:	ffffd097          	auipc	ra,0xffffd
    80023368:	3b0080e7          	jalr	944(ra) # 80020714 <release>
      return -1;
    8002336c:	57fd                	li	a5,-1
    8002336e:	bff9                	j	8002334c <sys_sleep+0x8c>

0000000080023370 <sys_kill>:

uint64
sys_kill(void)
{
    80023370:	1101                	addi	sp,sp,-32
    80023372:	ec06                	sd	ra,24(sp)
    80023374:	e822                	sd	s0,16(sp)
    80023376:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80023378:	fec40593          	addi	a1,s0,-20
    8002337c:	4501                	li	a0,0
    8002337e:	00000097          	auipc	ra,0x0
    80023382:	bb4080e7          	jalr	-1100(ra) # 80022f32 <argint>
    return -1;
    80023386:	57fd                	li	a5,-1
  if(argint(0, &pid) < 0)
    80023388:	00054963          	bltz	a0,8002339a <sys_kill+0x2a>
  return kill(pid);
    8002338c:	fec42503          	lw	a0,-20(s0)
    80023390:	fffff097          	auipc	ra,0xfffff
    80023394:	260080e7          	jalr	608(ra) # 800225f0 <kill>
    80023398:	87aa                	mv	a5,a0
}
    8002339a:	853e                	mv	a0,a5
    8002339c:	60e2                	ld	ra,24(sp)
    8002339e:	6442                	ld	s0,16(sp)
    800233a0:	6105                	addi	sp,sp,32
    800233a2:	8082                	ret

00000000800233a4 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800233a4:	1101                	addi	sp,sp,-32
    800233a6:	ec06                	sd	ra,24(sp)
    800233a8:	e822                	sd	s0,16(sp)
    800233aa:	e426                	sd	s1,8(sp)
    800233ac:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800233ae:	0001e517          	auipc	a0,0x1e
    800233b2:	05a50513          	addi	a0,a0,90 # 80041408 <tickslock>
    800233b6:	ffffd097          	auipc	ra,0xffffd
    800233ba:	30a080e7          	jalr	778(ra) # 800206c0 <acquire>
  xticks = ticks;
    800233be:	0001e797          	auipc	a5,0x1e
    800233c2:	06278793          	addi	a5,a5,98 # 80041420 <ticks>
    800233c6:	4384                	lw	s1,0(a5)
  release(&tickslock);
    800233c8:	0001e517          	auipc	a0,0x1e
    800233cc:	04050513          	addi	a0,a0,64 # 80041408 <tickslock>
    800233d0:	ffffd097          	auipc	ra,0xffffd
    800233d4:	344080e7          	jalr	836(ra) # 80020714 <release>
  return xticks;
}
    800233d8:	02049513          	slli	a0,s1,0x20
    800233dc:	9101                	srli	a0,a0,0x20
    800233de:	60e2                	ld	ra,24(sp)
    800233e0:	6442                	ld	s0,16(sp)
    800233e2:	64a2                	ld	s1,8(sp)
    800233e4:	6105                	addi	sp,sp,32
    800233e6:	8082                	ret

00000000800233e8 <sys_trace>:

uint64
sys_trace(void)
{
    800233e8:	1101                	addi	sp,sp,-32
    800233ea:	ec06                	sd	ra,24(sp)
    800233ec:	e822                	sd	s0,16(sp)
    800233ee:	1000                	addi	s0,sp,32
  int mask;
  if(argint(0, &mask) < 0) {
    800233f0:	fec40593          	addi	a1,s0,-20
    800233f4:	4501                	li	a0,0
    800233f6:	00000097          	auipc	ra,0x0
    800233fa:	b3c080e7          	jalr	-1220(ra) # 80022f32 <argint>
    return -1;
    800233fe:	57fd                	li	a5,-1
  if(argint(0, &mask) < 0) {
    80023400:	00054b63          	bltz	a0,80023416 <sys_trace+0x2e>
  }
  myproc()->tmask = mask;
    80023404:	ffffe097          	auipc	ra,0xffffe
    80023408:	77e080e7          	jalr	1918(ra) # 80021b82 <myproc>
    8002340c:	fec42783          	lw	a5,-20(s0)
    80023410:	16f52823          	sw	a5,368(a0)
  return 0;
    80023414:	4781                	li	a5,0
    80023416:	853e                	mv	a0,a5
    80023418:	60e2                	ld	ra,24(sp)
    8002341a:	6442                	ld	s0,16(sp)
    8002341c:	6105                	addi	sp,sp,32
    8002341e:	8082                	ret

0000000080023420 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80023420:	7139                	addi	sp,sp,-64
    80023422:	fc06                	sd	ra,56(sp)
    80023424:	f822                	sd	s0,48(sp)
    80023426:	f426                	sd	s1,40(sp)
    80023428:	f04a                	sd	s2,32(sp)
    8002342a:	ec4e                	sd	s3,24(sp)
    8002342c:	e852                	sd	s4,16(sp)
    8002342e:	e456                	sd	s5,8(sp)
    80023430:	0080                	addi	s0,sp,64
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80023432:	00009597          	auipc	a1,0x9
    80023436:	1ee58593          	addi	a1,a1,494 # 8002c620 <sysnames+0x6a0>
    8002343a:	00018517          	auipc	a0,0x18
    8002343e:	6b650513          	addi	a0,a0,1718 # 8003baf0 <bcache>
    80023442:	ffffd097          	auipc	ra,0xffffd
    80023446:	23a080e7          	jalr	570(ra) # 8002067c <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8002344a:	0001c797          	auipc	a5,0x1c
    8002344e:	6a678793          	addi	a5,a5,1702 # 8003faf0 <bcache+0x4000>
    80023452:	0001d717          	auipc	a4,0x1d
    80023456:	d0670713          	addi	a4,a4,-762 # 80040158 <bcache+0x4668>
    8002345a:	6ae7b823          	sd	a4,1712(a5)
  bcache.head.next = &bcache.head;
    8002345e:	6ae7bc23          	sd	a4,1720(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80023462:	00018497          	auipc	s1,0x18
    80023466:	6a648493          	addi	s1,s1,1702 # 8003bb08 <bcache+0x18>
    b->refcnt = 0;
    b->sectorno = ~0;
    8002346a:	5a7d                	li	s4,-1
    b->dev = ~0;
    b->next = bcache.head.next;
    8002346c:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    8002346e:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80023470:	00009a97          	auipc	s5,0x9
    80023474:	1b8a8a93          	addi	s5,s5,440 # 8002c628 <sysnames+0x6a8>
    b->refcnt = 0;
    80023478:	0404a023          	sw	zero,64(s1)
    b->sectorno = ~0;
    8002347c:	0144a623          	sw	s4,12(s1)
    b->dev = ~0;
    80023480:	0144a423          	sw	s4,8(s1)
    b->next = bcache.head.next;
    80023484:	6b893783          	ld	a5,1720(s2)
    80023488:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    8002348a:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8002348e:	85d6                	mv	a1,s5
    80023490:	01048513          	addi	a0,s1,16
    80023494:	00000097          	auipc	ra,0x0
    80023498:	280080e7          	jalr	640(ra) # 80023714 <initsleeplock>
    bcache.head.next->prev = b;
    8002349c:	6b893783          	ld	a5,1720(s2)
    800234a0:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    800234a2:	6a993c23          	sd	s1,1720(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800234a6:	25848493          	addi	s1,s1,600
    800234aa:	fd3497e3          	bne	s1,s3,80023478 <binit+0x58>
  }
  #ifdef DEBUG
  printf("binit\n");
  #endif
}
    800234ae:	70e2                	ld	ra,56(sp)
    800234b0:	7442                	ld	s0,48(sp)
    800234b2:	74a2                	ld	s1,40(sp)
    800234b4:	7902                	ld	s2,32(sp)
    800234b6:	69e2                	ld	s3,24(sp)
    800234b8:	6a42                	ld	s4,16(sp)
    800234ba:	6aa2                	ld	s5,8(sp)
    800234bc:	6121                	addi	sp,sp,64
    800234be:	8082                	ret

00000000800234c0 <bread>:
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf* 
bread(uint dev, uint sectorno) {
    800234c0:	7179                	addi	sp,sp,-48
    800234c2:	f406                	sd	ra,40(sp)
    800234c4:	f022                	sd	s0,32(sp)
    800234c6:	ec26                	sd	s1,24(sp)
    800234c8:	e84a                	sd	s2,16(sp)
    800234ca:	e44e                	sd	s3,8(sp)
    800234cc:	1800                	addi	s0,sp,48
    800234ce:	89aa                	mv	s3,a0
    800234d0:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    800234d2:	00018517          	auipc	a0,0x18
    800234d6:	61e50513          	addi	a0,a0,1566 # 8003baf0 <bcache>
    800234da:	ffffd097          	auipc	ra,0xffffd
    800234de:	1e6080e7          	jalr	486(ra) # 800206c0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800234e2:	0001c797          	auipc	a5,0x1c
    800234e6:	60e78793          	addi	a5,a5,1550 # 8003faf0 <bcache+0x4000>
    800234ea:	6b87b483          	ld	s1,1720(a5)
    800234ee:	0001d797          	auipc	a5,0x1d
    800234f2:	c6a78793          	addi	a5,a5,-918 # 80040158 <bcache+0x4668>
    800234f6:	02f48f63          	beq	s1,a5,80023534 <bread+0x74>
    800234fa:	873e                	mv	a4,a5
    800234fc:	a021                	j	80023504 <bread+0x44>
    800234fe:	68a4                	ld	s1,80(s1)
    80023500:	02e48a63          	beq	s1,a4,80023534 <bread+0x74>
    if(b->dev == dev && b->sectorno == sectorno){
    80023504:	449c                	lw	a5,8(s1)
    80023506:	ff379ce3          	bne	a5,s3,800234fe <bread+0x3e>
    8002350a:	44dc                	lw	a5,12(s1)
    8002350c:	ff2799e3          	bne	a5,s2,800234fe <bread+0x3e>
      b->refcnt++;
    80023510:	40bc                	lw	a5,64(s1)
    80023512:	2785                	addiw	a5,a5,1
    80023514:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80023516:	00018517          	auipc	a0,0x18
    8002351a:	5da50513          	addi	a0,a0,1498 # 8003baf0 <bcache>
    8002351e:	ffffd097          	auipc	ra,0xffffd
    80023522:	1f6080e7          	jalr	502(ra) # 80020714 <release>
      acquiresleep(&b->lock);
    80023526:	01048513          	addi	a0,s1,16
    8002352a:	00000097          	auipc	ra,0x0
    8002352e:	224080e7          	jalr	548(ra) # 8002374e <acquiresleep>
      return b;
    80023532:	a8b1                	j	8002358e <bread+0xce>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80023534:	0001c797          	auipc	a5,0x1c
    80023538:	5bc78793          	addi	a5,a5,1468 # 8003faf0 <bcache+0x4000>
    8002353c:	6b07b483          	ld	s1,1712(a5)
    80023540:	0001d797          	auipc	a5,0x1d
    80023544:	c1878793          	addi	a5,a5,-1000 # 80040158 <bcache+0x4668>
    80023548:	04f48d63          	beq	s1,a5,800235a2 <bread+0xe2>
    if(b->refcnt == 0) {
    8002354c:	40bc                	lw	a5,64(s1)
    8002354e:	cb91                	beqz	a5,80023562 <bread+0xa2>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80023550:	0001d717          	auipc	a4,0x1d
    80023554:	c0870713          	addi	a4,a4,-1016 # 80040158 <bcache+0x4668>
    80023558:	64a4                	ld	s1,72(s1)
    8002355a:	04e48463          	beq	s1,a4,800235a2 <bread+0xe2>
    if(b->refcnt == 0) {
    8002355e:	40bc                	lw	a5,64(s1)
    80023560:	ffe5                	bnez	a5,80023558 <bread+0x98>
      b->dev = dev;
    80023562:	0134a423          	sw	s3,8(s1)
      b->sectorno = sectorno;
    80023566:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    8002356a:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    8002356e:	4785                	li	a5,1
    80023570:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80023572:	00018517          	auipc	a0,0x18
    80023576:	57e50513          	addi	a0,a0,1406 # 8003baf0 <bcache>
    8002357a:	ffffd097          	auipc	ra,0xffffd
    8002357e:	19a080e7          	jalr	410(ra) # 80020714 <release>
      acquiresleep(&b->lock);
    80023582:	01048513          	addi	a0,s1,16
    80023586:	00000097          	auipc	ra,0x0
    8002358a:	1c8080e7          	jalr	456(ra) # 8002374e <acquiresleep>
  struct buf *b;

  b = bget(dev, sectorno);
  if (!b->valid) {
    8002358e:	409c                	lw	a5,0(s1)
    80023590:	c38d                	beqz	a5,800235b2 <bread+0xf2>
    disk_read(b);
    b->valid = 1;
  }

  return b;
}
    80023592:	8526                	mv	a0,s1
    80023594:	70a2                	ld	ra,40(sp)
    80023596:	7402                	ld	s0,32(sp)
    80023598:	64e2                	ld	s1,24(sp)
    8002359a:	6942                	ld	s2,16(sp)
    8002359c:	69a2                	ld	s3,8(sp)
    8002359e:	6145                	addi	sp,sp,48
    800235a0:	8082                	ret
  panic("bget: no buffers");
    800235a2:	00009517          	auipc	a0,0x9
    800235a6:	08e50513          	addi	a0,a0,142 # 8002c630 <sysnames+0x6b0>
    800235aa:	ffffd097          	auipc	ra,0xffffd
    800235ae:	b9c080e7          	jalr	-1124(ra) # 80020146 <panic>
    disk_read(b);
    800235b2:	8526                	mv	a0,s1
    800235b4:	00002097          	auipc	ra,0x2
    800235b8:	bce080e7          	jalr	-1074(ra) # 80025182 <disk_read>
    b->valid = 1;
    800235bc:	4785                	li	a5,1
    800235be:	c09c                	sw	a5,0(s1)
  return b;
    800235c0:	bfc9                	j	80023592 <bread+0xd2>

00000000800235c2 <bwrite>:

// Write b's contents to disk.  Must be locked.
void 
bwrite(struct buf *b) {
    800235c2:	1101                	addi	sp,sp,-32
    800235c4:	ec06                	sd	ra,24(sp)
    800235c6:	e822                	sd	s0,16(sp)
    800235c8:	e426                	sd	s1,8(sp)
    800235ca:	1000                	addi	s0,sp,32
    800235cc:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800235ce:	0541                	addi	a0,a0,16
    800235d0:	00000097          	auipc	ra,0x0
    800235d4:	218080e7          	jalr	536(ra) # 800237e8 <holdingsleep>
    800235d8:	c919                	beqz	a0,800235ee <bwrite+0x2c>
    panic("bwrite");
  disk_write(b);
    800235da:	8526                	mv	a0,s1
    800235dc:	00002097          	auipc	ra,0x2
    800235e0:	bc4080e7          	jalr	-1084(ra) # 800251a0 <disk_write>
}
    800235e4:	60e2                	ld	ra,24(sp)
    800235e6:	6442                	ld	s0,16(sp)
    800235e8:	64a2                	ld	s1,8(sp)
    800235ea:	6105                	addi	sp,sp,32
    800235ec:	8082                	ret
    panic("bwrite");
    800235ee:	00009517          	auipc	a0,0x9
    800235f2:	05a50513          	addi	a0,a0,90 # 8002c648 <sysnames+0x6c8>
    800235f6:	ffffd097          	auipc	ra,0xffffd
    800235fa:	b50080e7          	jalr	-1200(ra) # 80020146 <panic>

00000000800235fe <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800235fe:	1101                	addi	sp,sp,-32
    80023600:	ec06                	sd	ra,24(sp)
    80023602:	e822                	sd	s0,16(sp)
    80023604:	e426                	sd	s1,8(sp)
    80023606:	e04a                	sd	s2,0(sp)
    80023608:	1000                	addi	s0,sp,32
    8002360a:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8002360c:	01050913          	addi	s2,a0,16
    80023610:	854a                	mv	a0,s2
    80023612:	00000097          	auipc	ra,0x0
    80023616:	1d6080e7          	jalr	470(ra) # 800237e8 <holdingsleep>
    8002361a:	c92d                	beqz	a0,8002368c <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    8002361c:	854a                	mv	a0,s2
    8002361e:	00000097          	auipc	ra,0x0
    80023622:	186080e7          	jalr	390(ra) # 800237a4 <releasesleep>

  acquire(&bcache.lock);
    80023626:	00018517          	auipc	a0,0x18
    8002362a:	4ca50513          	addi	a0,a0,1226 # 8003baf0 <bcache>
    8002362e:	ffffd097          	auipc	ra,0xffffd
    80023632:	092080e7          	jalr	146(ra) # 800206c0 <acquire>
  b->refcnt--;
    80023636:	40bc                	lw	a5,64(s1)
    80023638:	37fd                	addiw	a5,a5,-1
    8002363a:	0007871b          	sext.w	a4,a5
    8002363e:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80023640:	eb05                	bnez	a4,80023670 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80023642:	68bc                	ld	a5,80(s1)
    80023644:	64b8                	ld	a4,72(s1)
    80023646:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80023648:	64bc                	ld	a5,72(s1)
    8002364a:	68b8                	ld	a4,80(s1)
    8002364c:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8002364e:	0001c797          	auipc	a5,0x1c
    80023652:	4a278793          	addi	a5,a5,1186 # 8003faf0 <bcache+0x4000>
    80023656:	6b87b703          	ld	a4,1720(a5)
    8002365a:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    8002365c:	0001d717          	auipc	a4,0x1d
    80023660:	afc70713          	addi	a4,a4,-1284 # 80040158 <bcache+0x4668>
    80023664:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80023666:	6b87b703          	ld	a4,1720(a5)
    8002366a:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    8002366c:	6a97bc23          	sd	s1,1720(a5)
  }
  
  release(&bcache.lock);
    80023670:	00018517          	auipc	a0,0x18
    80023674:	48050513          	addi	a0,a0,1152 # 8003baf0 <bcache>
    80023678:	ffffd097          	auipc	ra,0xffffd
    8002367c:	09c080e7          	jalr	156(ra) # 80020714 <release>
}
    80023680:	60e2                	ld	ra,24(sp)
    80023682:	6442                	ld	s0,16(sp)
    80023684:	64a2                	ld	s1,8(sp)
    80023686:	6902                	ld	s2,0(sp)
    80023688:	6105                	addi	sp,sp,32
    8002368a:	8082                	ret
    panic("brelse");
    8002368c:	00009517          	auipc	a0,0x9
    80023690:	fc450513          	addi	a0,a0,-60 # 8002c650 <sysnames+0x6d0>
    80023694:	ffffd097          	auipc	ra,0xffffd
    80023698:	ab2080e7          	jalr	-1358(ra) # 80020146 <panic>

000000008002369c <bpin>:

void
bpin(struct buf *b) {
    8002369c:	1101                	addi	sp,sp,-32
    8002369e:	ec06                	sd	ra,24(sp)
    800236a0:	e822                	sd	s0,16(sp)
    800236a2:	e426                	sd	s1,8(sp)
    800236a4:	1000                	addi	s0,sp,32
    800236a6:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800236a8:	00018517          	auipc	a0,0x18
    800236ac:	44850513          	addi	a0,a0,1096 # 8003baf0 <bcache>
    800236b0:	ffffd097          	auipc	ra,0xffffd
    800236b4:	010080e7          	jalr	16(ra) # 800206c0 <acquire>
  b->refcnt++;
    800236b8:	40bc                	lw	a5,64(s1)
    800236ba:	2785                	addiw	a5,a5,1
    800236bc:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800236be:	00018517          	auipc	a0,0x18
    800236c2:	43250513          	addi	a0,a0,1074 # 8003baf0 <bcache>
    800236c6:	ffffd097          	auipc	ra,0xffffd
    800236ca:	04e080e7          	jalr	78(ra) # 80020714 <release>
}
    800236ce:	60e2                	ld	ra,24(sp)
    800236d0:	6442                	ld	s0,16(sp)
    800236d2:	64a2                	ld	s1,8(sp)
    800236d4:	6105                	addi	sp,sp,32
    800236d6:	8082                	ret

00000000800236d8 <bunpin>:

void
bunpin(struct buf *b) {
    800236d8:	1101                	addi	sp,sp,-32
    800236da:	ec06                	sd	ra,24(sp)
    800236dc:	e822                	sd	s0,16(sp)
    800236de:	e426                	sd	s1,8(sp)
    800236e0:	1000                	addi	s0,sp,32
    800236e2:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800236e4:	00018517          	auipc	a0,0x18
    800236e8:	40c50513          	addi	a0,a0,1036 # 8003baf0 <bcache>
    800236ec:	ffffd097          	auipc	ra,0xffffd
    800236f0:	fd4080e7          	jalr	-44(ra) # 800206c0 <acquire>
  b->refcnt--;
    800236f4:	40bc                	lw	a5,64(s1)
    800236f6:	37fd                	addiw	a5,a5,-1
    800236f8:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800236fa:	00018517          	auipc	a0,0x18
    800236fe:	3f650513          	addi	a0,a0,1014 # 8003baf0 <bcache>
    80023702:	ffffd097          	auipc	ra,0xffffd
    80023706:	012080e7          	jalr	18(ra) # 80020714 <release>
}
    8002370a:	60e2                	ld	ra,24(sp)
    8002370c:	6442                	ld	s0,16(sp)
    8002370e:	64a2                	ld	s1,8(sp)
    80023710:	6105                	addi	sp,sp,32
    80023712:	8082                	ret

0000000080023714 <initsleeplock>:
#include "include/proc.h"
#include "include/sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80023714:	1101                	addi	sp,sp,-32
    80023716:	ec06                	sd	ra,24(sp)
    80023718:	e822                	sd	s0,16(sp)
    8002371a:	e426                	sd	s1,8(sp)
    8002371c:	e04a                	sd	s2,0(sp)
    8002371e:	1000                	addi	s0,sp,32
    80023720:	84aa                	mv	s1,a0
    80023722:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80023724:	00009597          	auipc	a1,0x9
    80023728:	f3458593          	addi	a1,a1,-204 # 8002c658 <sysnames+0x6d8>
    8002372c:	0521                	addi	a0,a0,8
    8002372e:	ffffd097          	auipc	ra,0xffffd
    80023732:	f4e080e7          	jalr	-178(ra) # 8002067c <initlock>
  lk->name = name;
    80023736:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8002373a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8002373e:	0204a423          	sw	zero,40(s1)
}
    80023742:	60e2                	ld	ra,24(sp)
    80023744:	6442                	ld	s0,16(sp)
    80023746:	64a2                	ld	s1,8(sp)
    80023748:	6902                	ld	s2,0(sp)
    8002374a:	6105                	addi	sp,sp,32
    8002374c:	8082                	ret

000000008002374e <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8002374e:	1101                	addi	sp,sp,-32
    80023750:	ec06                	sd	ra,24(sp)
    80023752:	e822                	sd	s0,16(sp)
    80023754:	e426                	sd	s1,8(sp)
    80023756:	e04a                	sd	s2,0(sp)
    80023758:	1000                	addi	s0,sp,32
    8002375a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8002375c:	00850913          	addi	s2,a0,8
    80023760:	854a                	mv	a0,s2
    80023762:	ffffd097          	auipc	ra,0xffffd
    80023766:	f5e080e7          	jalr	-162(ra) # 800206c0 <acquire>
  while (lk->locked) {
    8002376a:	409c                	lw	a5,0(s1)
    8002376c:	cb89                	beqz	a5,8002377e <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    8002376e:	85ca                	mv	a1,s2
    80023770:	8526                	mv	a0,s1
    80023772:	fffff097          	auipc	ra,0xfffff
    80023776:	c92080e7          	jalr	-878(ra) # 80022404 <sleep>
  while (lk->locked) {
    8002377a:	409c                	lw	a5,0(s1)
    8002377c:	fbed                	bnez	a5,8002376e <acquiresleep+0x20>
  }
  lk->locked = 1;
    8002377e:	4785                	li	a5,1
    80023780:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80023782:	ffffe097          	auipc	ra,0xffffe
    80023786:	400080e7          	jalr	1024(ra) # 80021b82 <myproc>
    8002378a:	5d1c                	lw	a5,56(a0)
    8002378c:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8002378e:	854a                	mv	a0,s2
    80023790:	ffffd097          	auipc	ra,0xffffd
    80023794:	f84080e7          	jalr	-124(ra) # 80020714 <release>
}
    80023798:	60e2                	ld	ra,24(sp)
    8002379a:	6442                	ld	s0,16(sp)
    8002379c:	64a2                	ld	s1,8(sp)
    8002379e:	6902                	ld	s2,0(sp)
    800237a0:	6105                	addi	sp,sp,32
    800237a2:	8082                	ret

00000000800237a4 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800237a4:	1101                	addi	sp,sp,-32
    800237a6:	ec06                	sd	ra,24(sp)
    800237a8:	e822                	sd	s0,16(sp)
    800237aa:	e426                	sd	s1,8(sp)
    800237ac:	e04a                	sd	s2,0(sp)
    800237ae:	1000                	addi	s0,sp,32
    800237b0:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800237b2:	00850913          	addi	s2,a0,8
    800237b6:	854a                	mv	a0,s2
    800237b8:	ffffd097          	auipc	ra,0xffffd
    800237bc:	f08080e7          	jalr	-248(ra) # 800206c0 <acquire>
  lk->locked = 0;
    800237c0:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800237c4:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800237c8:	8526                	mv	a0,s1
    800237ca:	fffff097          	auipc	ra,0xfffff
    800237ce:	dbc080e7          	jalr	-580(ra) # 80022586 <wakeup>
  release(&lk->lk);
    800237d2:	854a                	mv	a0,s2
    800237d4:	ffffd097          	auipc	ra,0xffffd
    800237d8:	f40080e7          	jalr	-192(ra) # 80020714 <release>
}
    800237dc:	60e2                	ld	ra,24(sp)
    800237de:	6442                	ld	s0,16(sp)
    800237e0:	64a2                	ld	s1,8(sp)
    800237e2:	6902                	ld	s2,0(sp)
    800237e4:	6105                	addi	sp,sp,32
    800237e6:	8082                	ret

00000000800237e8 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800237e8:	7179                	addi	sp,sp,-48
    800237ea:	f406                	sd	ra,40(sp)
    800237ec:	f022                	sd	s0,32(sp)
    800237ee:	ec26                	sd	s1,24(sp)
    800237f0:	e84a                	sd	s2,16(sp)
    800237f2:	e44e                	sd	s3,8(sp)
    800237f4:	1800                	addi	s0,sp,48
    800237f6:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800237f8:	00850913          	addi	s2,a0,8
    800237fc:	854a                	mv	a0,s2
    800237fe:	ffffd097          	auipc	ra,0xffffd
    80023802:	ec2080e7          	jalr	-318(ra) # 800206c0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80023806:	409c                	lw	a5,0(s1)
    80023808:	ef99                	bnez	a5,80023826 <holdingsleep+0x3e>
    8002380a:	4481                	li	s1,0
  release(&lk->lk);
    8002380c:	854a                	mv	a0,s2
    8002380e:	ffffd097          	auipc	ra,0xffffd
    80023812:	f06080e7          	jalr	-250(ra) # 80020714 <release>
  return r;
}
    80023816:	8526                	mv	a0,s1
    80023818:	70a2                	ld	ra,40(sp)
    8002381a:	7402                	ld	s0,32(sp)
    8002381c:	64e2                	ld	s1,24(sp)
    8002381e:	6942                	ld	s2,16(sp)
    80023820:	69a2                	ld	s3,8(sp)
    80023822:	6145                	addi	sp,sp,48
    80023824:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80023826:	0284a983          	lw	s3,40(s1)
    8002382a:	ffffe097          	auipc	ra,0xffffe
    8002382e:	358080e7          	jalr	856(ra) # 80021b82 <myproc>
    80023832:	5d04                	lw	s1,56(a0)
    80023834:	413484b3          	sub	s1,s1,s3
    80023838:	0014b493          	seqz	s1,s1
    8002383c:	bfc1                	j	8002380c <holdingsleep+0x24>

000000008002383e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8002383e:	1101                	addi	sp,sp,-32
    80023840:	ec06                	sd	ra,24(sp)
    80023842:	e822                	sd	s0,16(sp)
    80023844:	e426                	sd	s1,8(sp)
    80023846:	e04a                	sd	s2,0(sp)
    80023848:	1000                	addi	s0,sp,32
  initlock(&ftable.lock, "ftable");
    8002384a:	00009597          	auipc	a1,0x9
    8002384e:	e1e58593          	addi	a1,a1,-482 # 8002c668 <sysnames+0x6e8>
    80023852:	0001d517          	auipc	a0,0x1d
    80023856:	bfe50513          	addi	a0,a0,-1026 # 80040450 <ftable>
    8002385a:	ffffd097          	auipc	ra,0xffffd
    8002385e:	e22080e7          	jalr	-478(ra) # 8002067c <initlock>
  struct file *f;
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80023862:	0001d497          	auipc	s1,0x1d
    80023866:	c0648493          	addi	s1,s1,-1018 # 80040468 <ftable+0x18>
    8002386a:	0001e917          	auipc	s2,0x1e
    8002386e:	b9e90913          	addi	s2,s2,-1122 # 80041408 <tickslock>
    memset(f, 0, sizeof(struct file));
    80023872:	02800613          	li	a2,40
    80023876:	4581                	li	a1,0
    80023878:	8526                	mv	a0,s1
    8002387a:	ffffd097          	auipc	ra,0xffffd
    8002387e:	ee2080e7          	jalr	-286(ra) # 8002075c <memset>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80023882:	02848493          	addi	s1,s1,40
    80023886:	ff2496e3          	bne	s1,s2,80023872 <fileinit+0x34>
  }
  #ifdef DEBUG
  printf("fileinit\n");
  #endif
}
    8002388a:	60e2                	ld	ra,24(sp)
    8002388c:	6442                	ld	s0,16(sp)
    8002388e:	64a2                	ld	s1,8(sp)
    80023890:	6902                	ld	s2,0(sp)
    80023892:	6105                	addi	sp,sp,32
    80023894:	8082                	ret

0000000080023896 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80023896:	1101                	addi	sp,sp,-32
    80023898:	ec06                	sd	ra,24(sp)
    8002389a:	e822                	sd	s0,16(sp)
    8002389c:	e426                	sd	s1,8(sp)
    8002389e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800238a0:	0001d517          	auipc	a0,0x1d
    800238a4:	bb050513          	addi	a0,a0,-1104 # 80040450 <ftable>
    800238a8:	ffffd097          	auipc	ra,0xffffd
    800238ac:	e18080e7          	jalr	-488(ra) # 800206c0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
    800238b0:	0001d797          	auipc	a5,0x1d
    800238b4:	ba078793          	addi	a5,a5,-1120 # 80040450 <ftable>
    800238b8:	4fdc                	lw	a5,28(a5)
    800238ba:	cb8d                	beqz	a5,800238ec <filealloc+0x56>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800238bc:	0001d497          	auipc	s1,0x1d
    800238c0:	bd448493          	addi	s1,s1,-1068 # 80040490 <ftable+0x40>
    800238c4:	0001e717          	auipc	a4,0x1e
    800238c8:	b4470713          	addi	a4,a4,-1212 # 80041408 <tickslock>
    if(f->ref == 0){
    800238cc:	40dc                	lw	a5,4(s1)
    800238ce:	c39d                	beqz	a5,800238f4 <filealloc+0x5e>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800238d0:	02848493          	addi	s1,s1,40
    800238d4:	fee49ce3          	bne	s1,a4,800238cc <filealloc+0x36>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800238d8:	0001d517          	auipc	a0,0x1d
    800238dc:	b7850513          	addi	a0,a0,-1160 # 80040450 <ftable>
    800238e0:	ffffd097          	auipc	ra,0xffffd
    800238e4:	e34080e7          	jalr	-460(ra) # 80020714 <release>
  return NULL;
    800238e8:	4481                	li	s1,0
    800238ea:	a839                	j	80023908 <filealloc+0x72>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800238ec:	0001d497          	auipc	s1,0x1d
    800238f0:	b7c48493          	addi	s1,s1,-1156 # 80040468 <ftable+0x18>
      f->ref = 1;
    800238f4:	4785                	li	a5,1
    800238f6:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800238f8:	0001d517          	auipc	a0,0x1d
    800238fc:	b5850513          	addi	a0,a0,-1192 # 80040450 <ftable>
    80023900:	ffffd097          	auipc	ra,0xffffd
    80023904:	e14080e7          	jalr	-492(ra) # 80020714 <release>
}
    80023908:	8526                	mv	a0,s1
    8002390a:	60e2                	ld	ra,24(sp)
    8002390c:	6442                	ld	s0,16(sp)
    8002390e:	64a2                	ld	s1,8(sp)
    80023910:	6105                	addi	sp,sp,32
    80023912:	8082                	ret

0000000080023914 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80023914:	1101                	addi	sp,sp,-32
    80023916:	ec06                	sd	ra,24(sp)
    80023918:	e822                	sd	s0,16(sp)
    8002391a:	e426                	sd	s1,8(sp)
    8002391c:	1000                	addi	s0,sp,32
    8002391e:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80023920:	0001d517          	auipc	a0,0x1d
    80023924:	b3050513          	addi	a0,a0,-1232 # 80040450 <ftable>
    80023928:	ffffd097          	auipc	ra,0xffffd
    8002392c:	d98080e7          	jalr	-616(ra) # 800206c0 <acquire>
  if(f->ref < 1)
    80023930:	40dc                	lw	a5,4(s1)
    80023932:	02f05263          	blez	a5,80023956 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80023936:	2785                	addiw	a5,a5,1
    80023938:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    8002393a:	0001d517          	auipc	a0,0x1d
    8002393e:	b1650513          	addi	a0,a0,-1258 # 80040450 <ftable>
    80023942:	ffffd097          	auipc	ra,0xffffd
    80023946:	dd2080e7          	jalr	-558(ra) # 80020714 <release>
  return f;
}
    8002394a:	8526                	mv	a0,s1
    8002394c:	60e2                	ld	ra,24(sp)
    8002394e:	6442                	ld	s0,16(sp)
    80023950:	64a2                	ld	s1,8(sp)
    80023952:	6105                	addi	sp,sp,32
    80023954:	8082                	ret
    panic("filedup");
    80023956:	00009517          	auipc	a0,0x9
    8002395a:	d1a50513          	addi	a0,a0,-742 # 8002c670 <sysnames+0x6f0>
    8002395e:	ffffc097          	auipc	ra,0xffffc
    80023962:	7e8080e7          	jalr	2024(ra) # 80020146 <panic>

0000000080023966 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80023966:	7139                	addi	sp,sp,-64
    80023968:	fc06                	sd	ra,56(sp)
    8002396a:	f822                	sd	s0,48(sp)
    8002396c:	f426                	sd	s1,40(sp)
    8002396e:	f04a                	sd	s2,32(sp)
    80023970:	ec4e                	sd	s3,24(sp)
    80023972:	e852                	sd	s4,16(sp)
    80023974:	e456                	sd	s5,8(sp)
    80023976:	0080                	addi	s0,sp,64
    80023978:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    8002397a:	0001d517          	auipc	a0,0x1d
    8002397e:	ad650513          	addi	a0,a0,-1322 # 80040450 <ftable>
    80023982:	ffffd097          	auipc	ra,0xffffd
    80023986:	d3e080e7          	jalr	-706(ra) # 800206c0 <acquire>
  if(f->ref < 1)
    8002398a:	40dc                	lw	a5,4(s1)
    8002398c:	04f05863          	blez	a5,800239dc <fileclose+0x76>
    panic("fileclose");
  if(--f->ref > 0){
    80023990:	37fd                	addiw	a5,a5,-1
    80023992:	0007871b          	sext.w	a4,a5
    80023996:	c0dc                	sw	a5,4(s1)
    80023998:	04e04a63          	bgtz	a4,800239ec <fileclose+0x86>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    8002399c:	0004a903          	lw	s2,0(s1)
    800239a0:	0094ca03          	lbu	s4,9(s1)
    800239a4:	0104b983          	ld	s3,16(s1)
    800239a8:	0184ba83          	ld	s5,24(s1)
  f->ref = 0;
    800239ac:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    800239b0:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    800239b4:	0001d517          	auipc	a0,0x1d
    800239b8:	a9c50513          	addi	a0,a0,-1380 # 80040450 <ftable>
    800239bc:	ffffd097          	auipc	ra,0xffffd
    800239c0:	d58080e7          	jalr	-680(ra) # 80020714 <release>

  if(ff.type == FD_PIPE){
    800239c4:	4785                	li	a5,1
    800239c6:	04f90463          	beq	s2,a5,80023a0e <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_ENTRY){
    800239ca:	4789                	li	a5,2
    800239cc:	02f91863          	bne	s2,a5,800239fc <fileclose+0x96>
    eput(ff.ep);
    800239d0:	8556                	mv	a0,s5
    800239d2:	00003097          	auipc	ra,0x3
    800239d6:	9de080e7          	jalr	-1570(ra) # 800263b0 <eput>
    800239da:	a00d                	j	800239fc <fileclose+0x96>
    panic("fileclose");
    800239dc:	00009517          	auipc	a0,0x9
    800239e0:	c9c50513          	addi	a0,a0,-868 # 8002c678 <sysnames+0x6f8>
    800239e4:	ffffc097          	auipc	ra,0xffffc
    800239e8:	762080e7          	jalr	1890(ra) # 80020146 <panic>
    release(&ftable.lock);
    800239ec:	0001d517          	auipc	a0,0x1d
    800239f0:	a6450513          	addi	a0,a0,-1436 # 80040450 <ftable>
    800239f4:	ffffd097          	auipc	ra,0xffffd
    800239f8:	d20080e7          	jalr	-736(ra) # 80020714 <release>
  } else if (ff.type == FD_DEVICE) {

  }
}
    800239fc:	70e2                	ld	ra,56(sp)
    800239fe:	7442                	ld	s0,48(sp)
    80023a00:	74a2                	ld	s1,40(sp)
    80023a02:	7902                	ld	s2,32(sp)
    80023a04:	69e2                	ld	s3,24(sp)
    80023a06:	6a42                	ld	s4,16(sp)
    80023a08:	6aa2                	ld	s5,8(sp)
    80023a0a:	6121                	addi	sp,sp,64
    80023a0c:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80023a0e:	85d2                	mv	a1,s4
    80023a10:	854e                	mv	a0,s3
    80023a12:	00000097          	auipc	ra,0x0
    80023a16:	396080e7          	jalr	918(ra) # 80023da8 <pipeclose>
    80023a1a:	b7cd                	j	800239fc <fileclose+0x96>

0000000080023a1c <filestat>:
filestat(struct file *f, uint64 addr)
{
  // struct proc *p = myproc();
  struct stat st;
  
  if(f->type == FD_ENTRY){
    80023a1c:	4118                	lw	a4,0(a0)
    80023a1e:	4789                	li	a5,2
    80023a20:	04f71c63          	bne	a4,a5,80023a78 <filestat+0x5c>
{
    80023a24:	711d                	addi	sp,sp,-96
    80023a26:	ec86                	sd	ra,88(sp)
    80023a28:	e8a2                	sd	s0,80(sp)
    80023a2a:	e4a6                	sd	s1,72(sp)
    80023a2c:	e0ca                	sd	s2,64(sp)
    80023a2e:	1080                	addi	s0,sp,96
    80023a30:	892e                	mv	s2,a1
    80023a32:	84aa                	mv	s1,a0
    elock(f->ep);
    80023a34:	6d08                	ld	a0,24(a0)
    80023a36:	00003097          	auipc	ra,0x3
    80023a3a:	8f6080e7          	jalr	-1802(ra) # 8002632c <elock>
    estat(f->ep, &st);
    80023a3e:	fa840593          	addi	a1,s0,-88
    80023a42:	6c88                	ld	a0,24(s1)
    80023a44:	00003097          	auipc	ra,0x3
    80023a48:	aa4080e7          	jalr	-1372(ra) # 800264e8 <estat>
    eunlock(f->ep);
    80023a4c:	6c88                	ld	a0,24(s1)
    80023a4e:	00003097          	auipc	ra,0x3
    80023a52:	914080e7          	jalr	-1772(ra) # 80026362 <eunlock>
    // if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    80023a56:	03800613          	li	a2,56
    80023a5a:	fa840593          	addi	a1,s0,-88
    80023a5e:	854a                	mv	a0,s2
    80023a60:	ffffe097          	auipc	ra,0xffffe
    80023a64:	a28080e7          	jalr	-1496(ra) # 80021488 <copyout2>
    80023a68:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80023a6c:	60e6                	ld	ra,88(sp)
    80023a6e:	6446                	ld	s0,80(sp)
    80023a70:	64a6                	ld	s1,72(sp)
    80023a72:	6906                	ld	s2,64(sp)
    80023a74:	6125                	addi	sp,sp,96
    80023a76:	8082                	ret
  return -1;
    80023a78:	557d                	li	a0,-1
}
    80023a7a:	8082                	ret

0000000080023a7c <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80023a7c:	7179                	addi	sp,sp,-48
    80023a7e:	f406                	sd	ra,40(sp)
    80023a80:	f022                	sd	s0,32(sp)
    80023a82:	ec26                	sd	s1,24(sp)
    80023a84:	e84a                	sd	s2,16(sp)
    80023a86:	e44e                	sd	s3,8(sp)
    80023a88:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80023a8a:	00854783          	lbu	a5,8(a0)
    80023a8e:	c3d5                	beqz	a5,80023b32 <fileread+0xb6>
    80023a90:	89b2                	mv	s3,a2
    80023a92:	892e                	mv	s2,a1
    80023a94:	84aa                	mv	s1,a0
    return -1;

  switch (f->type) {
    80023a96:	411c                	lw	a5,0(a0)
    80023a98:	4709                	li	a4,2
    80023a9a:	06e78263          	beq	a5,a4,80023afe <fileread+0x82>
    80023a9e:	470d                	li	a4,3
    80023aa0:	02e78b63          	beq	a5,a4,80023ad6 <fileread+0x5a>
    80023aa4:	4705                	li	a4,1
    80023aa6:	00e78a63          	beq	a5,a4,80023aba <fileread+0x3e>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
            f->off += r;
        eunlock(f->ep);
        break;
    default:
      panic("fileread");
    80023aaa:	00009517          	auipc	a0,0x9
    80023aae:	bde50513          	addi	a0,a0,-1058 # 8002c688 <sysnames+0x708>
    80023ab2:	ffffc097          	auipc	ra,0xffffc
    80023ab6:	694080e7          	jalr	1684(ra) # 80020146 <panic>
        r = piperead(f->pipe, addr, n);
    80023aba:	6908                	ld	a0,16(a0)
    80023abc:	00000097          	auipc	ra,0x0
    80023ac0:	488080e7          	jalr	1160(ra) # 80023f44 <piperead>
    80023ac4:	892a                	mv	s2,a0
  }

  return r;
}
    80023ac6:	854a                	mv	a0,s2
    80023ac8:	70a2                	ld	ra,40(sp)
    80023aca:	7402                	ld	s0,32(sp)
    80023acc:	64e2                	ld	s1,24(sp)
    80023ace:	6942                	ld	s2,16(sp)
    80023ad0:	69a2                	ld	s3,8(sp)
    80023ad2:	6145                	addi	sp,sp,48
    80023ad4:	8082                	ret
        if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80023ad6:	02451783          	lh	a5,36(a0)
    80023ada:	03079693          	slli	a3,a5,0x30
    80023ade:	92c1                	srli	a3,a3,0x30
    80023ae0:	4725                	li	a4,9
    80023ae2:	04d76a63          	bltu	a4,a3,80023b36 <fileread+0xba>
    80023ae6:	0792                	slli	a5,a5,0x4
    80023ae8:	0001d717          	auipc	a4,0x1d
    80023aec:	8c870713          	addi	a4,a4,-1848 # 800403b0 <devsw>
    80023af0:	97ba                	add	a5,a5,a4
    80023af2:	639c                	ld	a5,0(a5)
    80023af4:	c3b9                	beqz	a5,80023b3a <fileread+0xbe>
        r = devsw[f->major].read(1, addr, n);
    80023af6:	4505                	li	a0,1
    80023af8:	9782                	jalr	a5
    80023afa:	892a                	mv	s2,a0
        break;
    80023afc:	b7e9                	j	80023ac6 <fileread+0x4a>
        elock(f->ep);
    80023afe:	6d08                	ld	a0,24(a0)
    80023b00:	00003097          	auipc	ra,0x3
    80023b04:	82c080e7          	jalr	-2004(ra) # 8002632c <elock>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
    80023b08:	874e                	mv	a4,s3
    80023b0a:	5094                	lw	a3,32(s1)
    80023b0c:	864a                	mv	a2,s2
    80023b0e:	4585                	li	a1,1
    80023b10:	6c88                	ld	a0,24(s1)
    80023b12:	00002097          	auipc	ra,0x2
    80023b16:	f4c080e7          	jalr	-180(ra) # 80025a5e <eread>
    80023b1a:	892a                	mv	s2,a0
    80023b1c:	00a05563          	blez	a0,80023b26 <fileread+0xaa>
            f->off += r;
    80023b20:	509c                	lw	a5,32(s1)
    80023b22:	9fa9                	addw	a5,a5,a0
    80023b24:	d09c                	sw	a5,32(s1)
        eunlock(f->ep);
    80023b26:	6c88                	ld	a0,24(s1)
    80023b28:	00003097          	auipc	ra,0x3
    80023b2c:	83a080e7          	jalr	-1990(ra) # 80026362 <eunlock>
        break;
    80023b30:	bf59                	j	80023ac6 <fileread+0x4a>
    return -1;
    80023b32:	597d                	li	s2,-1
    80023b34:	bf49                	j	80023ac6 <fileread+0x4a>
          return -1;
    80023b36:	597d                	li	s2,-1
    80023b38:	b779                	j	80023ac6 <fileread+0x4a>
    80023b3a:	597d                	li	s2,-1
    80023b3c:	b769                	j	80023ac6 <fileread+0x4a>

0000000080023b3e <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80023b3e:	7179                	addi	sp,sp,-48
    80023b40:	f406                	sd	ra,40(sp)
    80023b42:	f022                	sd	s0,32(sp)
    80023b44:	ec26                	sd	s1,24(sp)
    80023b46:	e84a                	sd	s2,16(sp)
    80023b48:	e44e                	sd	s3,8(sp)
    80023b4a:	e052                	sd	s4,0(sp)
    80023b4c:	1800                	addi	s0,sp,48
  int ret = 0;

  if(f->writable == 0)
    80023b4e:	00954783          	lbu	a5,9(a0)
    80023b52:	cbcd                	beqz	a5,80023c04 <filewrite+0xc6>
    80023b54:	8932                	mv	s2,a2
    80023b56:	89ae                	mv	s3,a1
    80023b58:	84aa                	mv	s1,a0
    return -1;

  if(f->type == FD_PIPE){
    80023b5a:	411c                	lw	a5,0(a0)
    80023b5c:	4705                	li	a4,1
    80023b5e:	04e78963          	beq	a5,a4,80023bb0 <filewrite+0x72>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80023b62:	470d                	li	a4,3
    80023b64:	04e78d63          	beq	a5,a4,80023bbe <filewrite+0x80>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_ENTRY){
    80023b68:	4709                	li	a4,2
    80023b6a:	08e79563          	bne	a5,a4,80023bf4 <filewrite+0xb6>
    elock(f->ep);
    80023b6e:	6d08                	ld	a0,24(a0)
    80023b70:	00002097          	auipc	ra,0x2
    80023b74:	7bc080e7          	jalr	1980(ra) # 8002632c <elock>
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    80023b78:	00090a1b          	sext.w	s4,s2
    80023b7c:	8752                	mv	a4,s4
    80023b7e:	5094                	lw	a3,32(s1)
    80023b80:	864e                	mv	a2,s3
    80023b82:	4585                	li	a1,1
    80023b84:	6c88                	ld	a0,24(s1)
    80023b86:	00002097          	auipc	ra,0x2
    80023b8a:	fd0080e7          	jalr	-48(ra) # 80025b56 <ewrite>
      ret = n;
      f->off += n;
    } else {
      ret = -1;
    80023b8e:	59fd                	li	s3,-1
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    80023b90:	05250b63          	beq	a0,s2,80023be6 <filewrite+0xa8>
    }
    eunlock(f->ep);
    80023b94:	6c88                	ld	a0,24(s1)
    80023b96:	00002097          	auipc	ra,0x2
    80023b9a:	7cc080e7          	jalr	1996(ra) # 80026362 <eunlock>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80023b9e:	854e                	mv	a0,s3
    80023ba0:	70a2                	ld	ra,40(sp)
    80023ba2:	7402                	ld	s0,32(sp)
    80023ba4:	64e2                	ld	s1,24(sp)
    80023ba6:	6942                	ld	s2,16(sp)
    80023ba8:	69a2                	ld	s3,8(sp)
    80023baa:	6a02                	ld	s4,0(sp)
    80023bac:	6145                	addi	sp,sp,48
    80023bae:	8082                	ret
    ret = pipewrite(f->pipe, addr, n);
    80023bb0:	6908                	ld	a0,16(a0)
    80023bb2:	00000097          	auipc	ra,0x0
    80023bb6:	266080e7          	jalr	614(ra) # 80023e18 <pipewrite>
    80023bba:	89aa                	mv	s3,a0
    80023bbc:	b7cd                	j	80023b9e <filewrite+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80023bbe:	02451783          	lh	a5,36(a0)
    80023bc2:	03079693          	slli	a3,a5,0x30
    80023bc6:	92c1                	srli	a3,a3,0x30
    80023bc8:	4725                	li	a4,9
    80023bca:	02d76f63          	bltu	a4,a3,80023c08 <filewrite+0xca>
    80023bce:	0792                	slli	a5,a5,0x4
    80023bd0:	0001c717          	auipc	a4,0x1c
    80023bd4:	7e070713          	addi	a4,a4,2016 # 800403b0 <devsw>
    80023bd8:	97ba                	add	a5,a5,a4
    80023bda:	679c                	ld	a5,8(a5)
    80023bdc:	cb85                	beqz	a5,80023c0c <filewrite+0xce>
    ret = devsw[f->major].write(1, addr, n);
    80023bde:	4505                	li	a0,1
    80023be0:	9782                	jalr	a5
    80023be2:	89aa                	mv	s3,a0
    80023be4:	bf6d                	j	80023b9e <filewrite+0x60>
      f->off += n;
    80023be6:	509c                	lw	a5,32(s1)
    80023be8:	01478a3b          	addw	s4,a5,s4
    80023bec:	0344a023          	sw	s4,32(s1)
      ret = n;
    80023bf0:	89ca                	mv	s3,s2
    80023bf2:	b74d                	j	80023b94 <filewrite+0x56>
    panic("filewrite");
    80023bf4:	00009517          	auipc	a0,0x9
    80023bf8:	aa450513          	addi	a0,a0,-1372 # 8002c698 <sysnames+0x718>
    80023bfc:	ffffc097          	auipc	ra,0xffffc
    80023c00:	54a080e7          	jalr	1354(ra) # 80020146 <panic>
    return -1;
    80023c04:	59fd                	li	s3,-1
    80023c06:	bf61                	j	80023b9e <filewrite+0x60>
      return -1;
    80023c08:	59fd                	li	s3,-1
    80023c0a:	bf51                	j	80023b9e <filewrite+0x60>
    80023c0c:	59fd                	li	s3,-1
    80023c0e:	bf41                	j	80023b9e <filewrite+0x60>

0000000080023c10 <dirnext>:
int
dirnext(struct file *f, uint64 addr)
{
  // struct proc *p = myproc();

  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    80023c10:	00854783          	lbu	a5,8(a0)
    80023c14:	cbd5                	beqz	a5,80023cc8 <dirnext+0xb8>
    80023c16:	6d14                	ld	a3,24(a0)
    80023c18:	1006c703          	lbu	a4,256(a3)
    80023c1c:	8b41                	andi	a4,a4,16
    return -1;
    80023c1e:	57fd                	li	a5,-1
  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    80023c20:	c74d                	beqz	a4,80023cca <dirnext+0xba>
{
    80023c22:	7105                	addi	sp,sp,-480
    80023c24:	ef86                	sd	ra,472(sp)
    80023c26:	eba2                	sd	s0,464(sp)
    80023c28:	e7a6                	sd	s1,456(sp)
    80023c2a:	e3ca                	sd	s2,448(sp)
    80023c2c:	ff4e                	sd	s3,440(sp)
    80023c2e:	1380                	addi	s0,sp,480
    80023c30:	89ae                	mv	s3,a1
    80023c32:	84aa                	mv	s1,a0

  struct dirent de;
  struct stat st;
  int count = 0;
    80023c34:	e2042623          	sw	zero,-468(s0)
  int ret;
  elock(f->ep);
    80023c38:	8536                	mv	a0,a3
    80023c3a:	00002097          	auipc	ra,0x2
    80023c3e:	6f2080e7          	jalr	1778(ra) # 8002632c <elock>
  while ((ret = enext(f->ep, &de, f->off, &count)) == 0) {  // skip empty entry
    80023c42:	e2c40693          	addi	a3,s0,-468
    80023c46:	5090                	lw	a2,32(s1)
    80023c48:	e6840593          	addi	a1,s0,-408
    80023c4c:	6c88                	ld	a0,24(s1)
    80023c4e:	00003097          	auipc	ra,0x3
    80023c52:	8e2080e7          	jalr	-1822(ra) # 80026530 <enext>
    80023c56:	892a                	mv	s2,a0
    80023c58:	e909                	bnez	a0,80023c6a <dirnext+0x5a>
    f->off += count * 32;
    80023c5a:	e2c42783          	lw	a5,-468(s0)
    80023c5e:	0057971b          	slliw	a4,a5,0x5
    80023c62:	509c                	lw	a5,32(s1)
    80023c64:	9fb9                	addw	a5,a5,a4
    80023c66:	d09c                	sw	a5,32(s1)
    80023c68:	bfe9                	j	80023c42 <dirnext+0x32>
  }
  eunlock(f->ep);
    80023c6a:	6c88                	ld	a0,24(s1)
    80023c6c:	00002097          	auipc	ra,0x2
    80023c70:	6f6080e7          	jalr	1782(ra) # 80026362 <eunlock>
  if (ret == -1)
    80023c74:	577d                	li	a4,-1
    return 0;
    80023c76:	4781                	li	a5,0
  if (ret == -1)
    80023c78:	04e90063          	beq	s2,a4,80023cb8 <dirnext+0xa8>

  f->off += count * 32;
    80023c7c:	e2c42783          	lw	a5,-468(s0)
    80023c80:	0057971b          	slliw	a4,a5,0x5
    80023c84:	509c                	lw	a5,32(s1)
    80023c86:	9fb9                	addw	a5,a5,a4
    80023c88:	d09c                	sw	a5,32(s1)
  estat(&de, &st);
    80023c8a:	e3040593          	addi	a1,s0,-464
    80023c8e:	e6840513          	addi	a0,s0,-408
    80023c92:	00003097          	auipc	ra,0x3
    80023c96:	856080e7          	jalr	-1962(ra) # 800264e8 <estat>
  // if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
  if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    80023c9a:	03800613          	li	a2,56
    80023c9e:	e3040593          	addi	a1,s0,-464
    80023ca2:	854e                	mv	a0,s3
    80023ca4:	ffffd097          	auipc	ra,0xffffd
    80023ca8:	7e4080e7          	jalr	2020(ra) # 80021488 <copyout2>
    return -1;
    80023cac:	fff54513          	not	a0,a0
    80023cb0:	43f55793          	srai	a5,a0,0x3f
    80023cb4:	8b89                	andi	a5,a5,2
    80023cb6:	17fd                	addi	a5,a5,-1

  return 1;
    80023cb8:	853e                	mv	a0,a5
    80023cba:	60fe                	ld	ra,472(sp)
    80023cbc:	645e                	ld	s0,464(sp)
    80023cbe:	64be                	ld	s1,456(sp)
    80023cc0:	691e                	ld	s2,448(sp)
    80023cc2:	79fa                	ld	s3,440(sp)
    80023cc4:	613d                	addi	sp,sp,480
    80023cc6:	8082                	ret
    return -1;
    80023cc8:	57fd                	li	a5,-1
    80023cca:	853e                	mv	a0,a5
    80023ccc:	8082                	ret

0000000080023cce <pipealloc>:
#include "include/kalloc.h"
#include "include/vm.h"

int
pipealloc(struct file **f0, struct file **f1)
{
    80023cce:	7179                	addi	sp,sp,-48
    80023cd0:	f406                	sd	ra,40(sp)
    80023cd2:	f022                	sd	s0,32(sp)
    80023cd4:	ec26                	sd	s1,24(sp)
    80023cd6:	e84a                	sd	s2,16(sp)
    80023cd8:	e44e                	sd	s3,8(sp)
    80023cda:	e052                	sd	s4,0(sp)
    80023cdc:	1800                	addi	s0,sp,48
    80023cde:	84aa                	mv	s1,a0
    80023ce0:	892e                	mv	s2,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80023ce2:	0005b023          	sd	zero,0(a1)
    80023ce6:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == NULL || (*f1 = filealloc()) == NULL)
    80023cea:	00000097          	auipc	ra,0x0
    80023cee:	bac080e7          	jalr	-1108(ra) # 80023896 <filealloc>
    80023cf2:	e088                	sd	a0,0(s1)
    80023cf4:	c551                	beqz	a0,80023d80 <pipealloc+0xb2>
    80023cf6:	00000097          	auipc	ra,0x0
    80023cfa:	ba0080e7          	jalr	-1120(ra) # 80023896 <filealloc>
    80023cfe:	00a93023          	sd	a0,0(s2)
    80023d02:	c92d                	beqz	a0,80023d74 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == NULL)
    80023d04:	ffffd097          	auipc	ra,0xffffd
    80023d08:	84e080e7          	jalr	-1970(ra) # 80020552 <kalloc>
    80023d0c:	89aa                	mv	s3,a0
    80023d0e:	c125                	beqz	a0,80023d6e <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80023d10:	4a05                	li	s4,1
    80023d12:	23452023          	sw	s4,544(a0)
  pi->writeopen = 1;
    80023d16:	23452223          	sw	s4,548(a0)
  pi->nwrite = 0;
    80023d1a:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80023d1e:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80023d22:	00009597          	auipc	a1,0x9
    80023d26:	8ce58593          	addi	a1,a1,-1842 # 8002c5f0 <sysnames+0x670>
    80023d2a:	ffffd097          	auipc	ra,0xffffd
    80023d2e:	952080e7          	jalr	-1710(ra) # 8002067c <initlock>
  (*f0)->type = FD_PIPE;
    80023d32:	609c                	ld	a5,0(s1)
    80023d34:	0147a023          	sw	s4,0(a5)
  (*f0)->readable = 1;
    80023d38:	609c                	ld	a5,0(s1)
    80023d3a:	01478423          	sb	s4,8(a5)
  (*f0)->writable = 0;
    80023d3e:	609c                	ld	a5,0(s1)
    80023d40:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80023d44:	609c                	ld	a5,0(s1)
    80023d46:	0137b823          	sd	s3,16(a5)
  (*f1)->type = FD_PIPE;
    80023d4a:	00093783          	ld	a5,0(s2)
    80023d4e:	0147a023          	sw	s4,0(a5)
  (*f1)->readable = 0;
    80023d52:	00093783          	ld	a5,0(s2)
    80023d56:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80023d5a:	00093783          	ld	a5,0(s2)
    80023d5e:	014784a3          	sb	s4,9(a5)
  (*f1)->pipe = pi;
    80023d62:	00093783          	ld	a5,0(s2)
    80023d66:	0137b823          	sd	s3,16(a5)
  return 0;
    80023d6a:	4501                	li	a0,0
    80023d6c:	a025                	j	80023d94 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80023d6e:	6088                	ld	a0,0(s1)
    80023d70:	e501                	bnez	a0,80023d78 <pipealloc+0xaa>
    80023d72:	a039                	j	80023d80 <pipealloc+0xb2>
    80023d74:	6088                	ld	a0,0(s1)
    80023d76:	c51d                	beqz	a0,80023da4 <pipealloc+0xd6>
    fileclose(*f0);
    80023d78:	00000097          	auipc	ra,0x0
    80023d7c:	bee080e7          	jalr	-1042(ra) # 80023966 <fileclose>
  if(*f1)
    80023d80:	00093783          	ld	a5,0(s2)
    fileclose(*f1);
  return -1;
    80023d84:	557d                	li	a0,-1
  if(*f1)
    80023d86:	c799                	beqz	a5,80023d94 <pipealloc+0xc6>
    fileclose(*f1);
    80023d88:	853e                	mv	a0,a5
    80023d8a:	00000097          	auipc	ra,0x0
    80023d8e:	bdc080e7          	jalr	-1060(ra) # 80023966 <fileclose>
  return -1;
    80023d92:	557d                	li	a0,-1
}
    80023d94:	70a2                	ld	ra,40(sp)
    80023d96:	7402                	ld	s0,32(sp)
    80023d98:	64e2                	ld	s1,24(sp)
    80023d9a:	6942                	ld	s2,16(sp)
    80023d9c:	69a2                	ld	s3,8(sp)
    80023d9e:	6a02                	ld	s4,0(sp)
    80023da0:	6145                	addi	sp,sp,48
    80023da2:	8082                	ret
  return -1;
    80023da4:	557d                	li	a0,-1
    80023da6:	b7fd                	j	80023d94 <pipealloc+0xc6>

0000000080023da8 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80023da8:	1101                	addi	sp,sp,-32
    80023daa:	ec06                	sd	ra,24(sp)
    80023dac:	e822                	sd	s0,16(sp)
    80023dae:	e426                	sd	s1,8(sp)
    80023db0:	e04a                	sd	s2,0(sp)
    80023db2:	1000                	addi	s0,sp,32
    80023db4:	84aa                	mv	s1,a0
    80023db6:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80023db8:	ffffd097          	auipc	ra,0xffffd
    80023dbc:	908080e7          	jalr	-1784(ra) # 800206c0 <acquire>
  if(writable){
    80023dc0:	02090d63          	beqz	s2,80023dfa <pipeclose+0x52>
    pi->writeopen = 0;
    80023dc4:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80023dc8:	21848513          	addi	a0,s1,536
    80023dcc:	ffffe097          	auipc	ra,0xffffe
    80023dd0:	7ba080e7          	jalr	1978(ra) # 80022586 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80023dd4:	2204b783          	ld	a5,544(s1)
    80023dd8:	eb95                	bnez	a5,80023e0c <pipeclose+0x64>
    release(&pi->lock);
    80023dda:	8526                	mv	a0,s1
    80023ddc:	ffffd097          	auipc	ra,0xffffd
    80023de0:	938080e7          	jalr	-1736(ra) # 80020714 <release>
    kfree((char*)pi);
    80023de4:	8526                	mv	a0,s1
    80023de6:	ffffc097          	auipc	ra,0xffffc
    80023dea:	652080e7          	jalr	1618(ra) # 80020438 <kfree>
  } else
    release(&pi->lock);
}
    80023dee:	60e2                	ld	ra,24(sp)
    80023df0:	6442                	ld	s0,16(sp)
    80023df2:	64a2                	ld	s1,8(sp)
    80023df4:	6902                	ld	s2,0(sp)
    80023df6:	6105                	addi	sp,sp,32
    80023df8:	8082                	ret
    pi->readopen = 0;
    80023dfa:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80023dfe:	21c48513          	addi	a0,s1,540
    80023e02:	ffffe097          	auipc	ra,0xffffe
    80023e06:	784080e7          	jalr	1924(ra) # 80022586 <wakeup>
    80023e0a:	b7e9                	j	80023dd4 <pipeclose+0x2c>
    release(&pi->lock);
    80023e0c:	8526                	mv	a0,s1
    80023e0e:	ffffd097          	auipc	ra,0xffffd
    80023e12:	906080e7          	jalr	-1786(ra) # 80020714 <release>
}
    80023e16:	bfe1                	j	80023dee <pipeclose+0x46>

0000000080023e18 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80023e18:	7119                	addi	sp,sp,-128
    80023e1a:	fc86                	sd	ra,120(sp)
    80023e1c:	f8a2                	sd	s0,112(sp)
    80023e1e:	f4a6                	sd	s1,104(sp)
    80023e20:	f0ca                	sd	s2,96(sp)
    80023e22:	ecce                	sd	s3,88(sp)
    80023e24:	e8d2                	sd	s4,80(sp)
    80023e26:	e4d6                	sd	s5,72(sp)
    80023e28:	e0da                	sd	s6,64(sp)
    80023e2a:	fc5e                	sd	s7,56(sp)
    80023e2c:	f862                	sd	s8,48(sp)
    80023e2e:	f466                	sd	s9,40(sp)
    80023e30:	f06a                	sd	s10,32(sp)
    80023e32:	ec6e                	sd	s11,24(sp)
    80023e34:	0100                	addi	s0,sp,128
    80023e36:	84aa                	mv	s1,a0
    80023e38:	8d2e                	mv	s10,a1
    80023e3a:	8b32                	mv	s6,a2
  int i;
  char ch;
  struct proc *pr = myproc();
    80023e3c:	ffffe097          	auipc	ra,0xffffe
    80023e40:	d46080e7          	jalr	-698(ra) # 80021b82 <myproc>
    80023e44:	892a                	mv	s2,a0

  acquire(&pi->lock);
    80023e46:	8526                	mv	a0,s1
    80023e48:	ffffd097          	auipc	ra,0xffffd
    80023e4c:	878080e7          	jalr	-1928(ra) # 800206c0 <acquire>
  for(i = 0; i < n; i++){
    80023e50:	0d605d63          	blez	s6,80023f2a <pipewrite+0x112>
    80023e54:	89a6                	mv	s3,s1
    80023e56:	3b7d                	addiw	s6,s6,-1
    80023e58:	1b02                	slli	s6,s6,0x20
    80023e5a:	020b5b13          	srli	s6,s6,0x20
    80023e5e:	4b81                	li	s7,0
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || pr->killed){
        release(&pi->lock);
        return -1;
      }
      wakeup(&pi->nread);
    80023e60:	21848a93          	addi	s5,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80023e64:	21c48a13          	addi	s4,s1,540
    }
    // if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    if(copyin2(&ch, addr + i, 1) == -1)
    80023e68:	5dfd                	li	s11,-1
    80023e6a:	000b8c9b          	sext.w	s9,s7
    80023e6e:	8c66                	mv	s8,s9
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023e70:	2184a783          	lw	a5,536(s1)
    80023e74:	21c4a703          	lw	a4,540(s1)
    80023e78:	2007879b          	addiw	a5,a5,512
    80023e7c:	06f71763          	bne	a4,a5,80023eea <pipewrite+0xd2>
      if(pi->readopen == 0 || pr->killed){
    80023e80:	2204a783          	lw	a5,544(s1)
    80023e84:	cf8d                	beqz	a5,80023ebe <pipewrite+0xa6>
    80023e86:	03092783          	lw	a5,48(s2)
    80023e8a:	eb95                	bnez	a5,80023ebe <pipewrite+0xa6>
      wakeup(&pi->nread);
    80023e8c:	8556                	mv	a0,s5
    80023e8e:	ffffe097          	auipc	ra,0xffffe
    80023e92:	6f8080e7          	jalr	1784(ra) # 80022586 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80023e96:	85ce                	mv	a1,s3
    80023e98:	8552                	mv	a0,s4
    80023e9a:	ffffe097          	auipc	ra,0xffffe
    80023e9e:	56a080e7          	jalr	1386(ra) # 80022404 <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023ea2:	2184a783          	lw	a5,536(s1)
    80023ea6:	21c4a703          	lw	a4,540(s1)
    80023eaa:	2007879b          	addiw	a5,a5,512
    80023eae:	02f71e63          	bne	a4,a5,80023eea <pipewrite+0xd2>
      if(pi->readopen == 0 || pr->killed){
    80023eb2:	2204a783          	lw	a5,544(s1)
    80023eb6:	c781                	beqz	a5,80023ebe <pipewrite+0xa6>
    80023eb8:	03092783          	lw	a5,48(s2)
    80023ebc:	dbe1                	beqz	a5,80023e8c <pipewrite+0x74>
        release(&pi->lock);
    80023ebe:	8526                	mv	a0,s1
    80023ec0:	ffffd097          	auipc	ra,0xffffd
    80023ec4:	854080e7          	jalr	-1964(ra) # 80020714 <release>
        return -1;
    80023ec8:	5c7d                	li	s8,-1
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
  }
  wakeup(&pi->nread);
  release(&pi->lock);
  return i;
}
    80023eca:	8562                	mv	a0,s8
    80023ecc:	70e6                	ld	ra,120(sp)
    80023ece:	7446                	ld	s0,112(sp)
    80023ed0:	74a6                	ld	s1,104(sp)
    80023ed2:	7906                	ld	s2,96(sp)
    80023ed4:	69e6                	ld	s3,88(sp)
    80023ed6:	6a46                	ld	s4,80(sp)
    80023ed8:	6aa6                	ld	s5,72(sp)
    80023eda:	6b06                	ld	s6,64(sp)
    80023edc:	7be2                	ld	s7,56(sp)
    80023ede:	7c42                	ld	s8,48(sp)
    80023ee0:	7ca2                	ld	s9,40(sp)
    80023ee2:	7d02                	ld	s10,32(sp)
    80023ee4:	6de2                	ld	s11,24(sp)
    80023ee6:	6109                	addi	sp,sp,128
    80023ee8:	8082                	ret
    if(copyin2(&ch, addr + i, 1) == -1)
    80023eea:	4605                	li	a2,1
    80023eec:	01ab85b3          	add	a1,s7,s10
    80023ef0:	f8f40513          	addi	a0,s0,-113
    80023ef4:	ffffd097          	auipc	ra,0xffffd
    80023ef8:	674080e7          	jalr	1652(ra) # 80021568 <copyin2>
    80023efc:	03b50863          	beq	a0,s11,80023f2c <pipewrite+0x114>
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80023f00:	21c4a783          	lw	a5,540(s1)
    80023f04:	0017871b          	addiw	a4,a5,1
    80023f08:	20e4ae23          	sw	a4,540(s1)
    80023f0c:	1ff7f793          	andi	a5,a5,511
    80023f10:	97a6                	add	a5,a5,s1
    80023f12:	f8f44703          	lbu	a4,-113(s0)
    80023f16:	00e78c23          	sb	a4,24(a5)
    80023f1a:	001c8c1b          	addiw	s8,s9,1
    80023f1e:	001b8793          	addi	a5,s7,1
  for(i = 0; i < n; i++){
    80023f22:	016b8563          	beq	s7,s6,80023f2c <pipewrite+0x114>
    80023f26:	8bbe                	mv	s7,a5
    80023f28:	b789                	j	80023e6a <pipewrite+0x52>
    80023f2a:	4c01                	li	s8,0
  wakeup(&pi->nread);
    80023f2c:	21848513          	addi	a0,s1,536
    80023f30:	ffffe097          	auipc	ra,0xffffe
    80023f34:	656080e7          	jalr	1622(ra) # 80022586 <wakeup>
  release(&pi->lock);
    80023f38:	8526                	mv	a0,s1
    80023f3a:	ffffc097          	auipc	ra,0xffffc
    80023f3e:	7da080e7          	jalr	2010(ra) # 80020714 <release>
  return i;
    80023f42:	b761                	j	80023eca <pipewrite+0xb2>

0000000080023f44 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80023f44:	715d                	addi	sp,sp,-80
    80023f46:	e486                	sd	ra,72(sp)
    80023f48:	e0a2                	sd	s0,64(sp)
    80023f4a:	fc26                	sd	s1,56(sp)
    80023f4c:	f84a                	sd	s2,48(sp)
    80023f4e:	f44e                	sd	s3,40(sp)
    80023f50:	f052                	sd	s4,32(sp)
    80023f52:	ec56                	sd	s5,24(sp)
    80023f54:	e85a                	sd	s6,16(sp)
    80023f56:	0880                	addi	s0,sp,80
    80023f58:	84aa                	mv	s1,a0
    80023f5a:	89ae                	mv	s3,a1
    80023f5c:	8a32                	mv	s4,a2
  int i;
  struct proc *pr = myproc();
    80023f5e:	ffffe097          	auipc	ra,0xffffe
    80023f62:	c24080e7          	jalr	-988(ra) # 80021b82 <myproc>
    80023f66:	892a                	mv	s2,a0
  char ch;

  acquire(&pi->lock);
    80023f68:	8526                	mv	a0,s1
    80023f6a:	ffffc097          	auipc	ra,0xffffc
    80023f6e:	756080e7          	jalr	1878(ra) # 800206c0 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80023f72:	2184a703          	lw	a4,536(s1)
    80023f76:	21c4a783          	lw	a5,540(s1)
    80023f7a:	06f71b63          	bne	a4,a5,80023ff0 <piperead+0xac>
    80023f7e:	8aa6                	mv	s5,s1
    80023f80:	2244a783          	lw	a5,548(s1)
    80023f84:	cf9d                	beqz	a5,80023fc2 <piperead+0x7e>
    if(pr->killed){
    80023f86:	03092783          	lw	a5,48(s2)
    80023f8a:	e78d                	bnez	a5,80023fb4 <piperead+0x70>
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80023f8c:	21848b13          	addi	s6,s1,536
    80023f90:	85d6                	mv	a1,s5
    80023f92:	855a                	mv	a0,s6
    80023f94:	ffffe097          	auipc	ra,0xffffe
    80023f98:	470080e7          	jalr	1136(ra) # 80022404 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80023f9c:	2184a703          	lw	a4,536(s1)
    80023fa0:	21c4a783          	lw	a5,540(s1)
    80023fa4:	04f71663          	bne	a4,a5,80023ff0 <piperead+0xac>
    80023fa8:	2244a783          	lw	a5,548(s1)
    80023fac:	cb99                	beqz	a5,80023fc2 <piperead+0x7e>
    if(pr->killed){
    80023fae:	03092783          	lw	a5,48(s2)
    80023fb2:	dff9                	beqz	a5,80023f90 <piperead+0x4c>
      release(&pi->lock);
    80023fb4:	8526                	mv	a0,s1
    80023fb6:	ffffc097          	auipc	ra,0xffffc
    80023fba:	75e080e7          	jalr	1886(ra) # 80020714 <release>
      return -1;
    80023fbe:	597d                	li	s2,-1
    80023fc0:	a829                	j	80023fda <piperead+0x96>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(pi->nread == pi->nwrite)
    80023fc2:	4901                	li	s2,0
    ch = pi->data[pi->nread++ % PIPESIZE];
    // if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    if(copyout2(addr + i, &ch, 1) == -1)
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80023fc4:	21c48513          	addi	a0,s1,540
    80023fc8:	ffffe097          	auipc	ra,0xffffe
    80023fcc:	5be080e7          	jalr	1470(ra) # 80022586 <wakeup>
  release(&pi->lock);
    80023fd0:	8526                	mv	a0,s1
    80023fd2:	ffffc097          	auipc	ra,0xffffc
    80023fd6:	742080e7          	jalr	1858(ra) # 80020714 <release>
  return i;
}
    80023fda:	854a                	mv	a0,s2
    80023fdc:	60a6                	ld	ra,72(sp)
    80023fde:	6406                	ld	s0,64(sp)
    80023fe0:	74e2                	ld	s1,56(sp)
    80023fe2:	7942                	ld	s2,48(sp)
    80023fe4:	79a2                	ld	s3,40(sp)
    80023fe6:	7a02                	ld	s4,32(sp)
    80023fe8:	6ae2                	ld	s5,24(sp)
    80023fea:	6b42                	ld	s6,16(sp)
    80023fec:	6161                	addi	sp,sp,80
    80023fee:	8082                	ret
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80023ff0:	4901                	li	s2,0
    80023ff2:	fd4059e3          	blez	s4,80023fc4 <piperead+0x80>
    if(pi->nread == pi->nwrite)
    80023ff6:	2184a783          	lw	a5,536(s1)
    80023ffa:	4901                	li	s2,0
    if(copyout2(addr + i, &ch, 1) == -1)
    80023ffc:	5afd                	li	s5,-1
    ch = pi->data[pi->nread++ % PIPESIZE];
    80023ffe:	0017871b          	addiw	a4,a5,1
    80024002:	20e4ac23          	sw	a4,536(s1)
    80024006:	1ff7f793          	andi	a5,a5,511
    8002400a:	97a6                	add	a5,a5,s1
    8002400c:	0187c783          	lbu	a5,24(a5)
    80024010:	faf40fa3          	sb	a5,-65(s0)
    if(copyout2(addr + i, &ch, 1) == -1)
    80024014:	4605                	li	a2,1
    80024016:	fbf40593          	addi	a1,s0,-65
    8002401a:	854e                	mv	a0,s3
    8002401c:	ffffd097          	auipc	ra,0xffffd
    80024020:	46c080e7          	jalr	1132(ra) # 80021488 <copyout2>
    80024024:	fb5500e3          	beq	a0,s5,80023fc4 <piperead+0x80>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80024028:	2905                	addiw	s2,s2,1
    8002402a:	f92a0de3          	beq	s4,s2,80023fc4 <piperead+0x80>
    if(pi->nread == pi->nwrite)
    8002402e:	2184a783          	lw	a5,536(s1)
    80024032:	0985                	addi	s3,s3,1
    80024034:	21c4a703          	lw	a4,540(s1)
    80024038:	fcf713e3          	bne	a4,a5,80023ffe <piperead+0xba>
    8002403c:	b761                	j	80023fc4 <piperead+0x80>

000000008002403e <exec>:
  return 0;
}


int exec(char *path, char **argv)
{
    8002403e:	dd010113          	addi	sp,sp,-560
    80024042:	22113423          	sd	ra,552(sp)
    80024046:	22813023          	sd	s0,544(sp)
    8002404a:	20913c23          	sd	s1,536(sp)
    8002404e:	21213823          	sd	s2,528(sp)
    80024052:	21313423          	sd	s3,520(sp)
    80024056:	21413023          	sd	s4,512(sp)
    8002405a:	ffd6                	sd	s5,504(sp)
    8002405c:	fbda                	sd	s6,496(sp)
    8002405e:	f7de                	sd	s7,488(sp)
    80024060:	f3e2                	sd	s8,480(sp)
    80024062:	efe6                	sd	s9,472(sp)
    80024064:	ebea                	sd	s10,464(sp)
    80024066:	e7ee                	sd	s11,456(sp)
    80024068:	1c00                	addi	s0,sp,560
    8002406a:	892a                	mv	s2,a0
    8002406c:	dea43023          	sd	a0,-544(s0)
    80024070:	deb43423          	sd	a1,-536(s0)
  struct elfhdr elf;
  struct dirent *ep;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  pagetable_t kpagetable = 0, oldkpagetable;
  struct proc *p = myproc();
    80024074:	ffffe097          	auipc	ra,0xffffe
    80024078:	b0e080e7          	jalr	-1266(ra) # 80021b82 <myproc>
    8002407c:	84aa                	mv	s1,a0

  // Make a copy of p->kpt without old user space, 
  // but with the same kstack we are using now, which can't be changed
  if ((kpagetable = (pagetable_t)kalloc()) == NULL) {
    8002407e:	ffffc097          	auipc	ra,0xffffc
    80024082:	4d4080e7          	jalr	1236(ra) # 80020552 <kalloc>
    80024086:	2a050363          	beqz	a0,8002432c <exec+0x2ee>
    8002408a:	8aaa                	mv	s5,a0
    return -1;
  }
  memmove(kpagetable, p->kpagetable, PGSIZE);
    8002408c:	6605                	lui	a2,0x1
    8002408e:	6cac                	ld	a1,88(s1)
    80024090:	ffffc097          	auipc	ra,0xffffc
    80024094:	738080e7          	jalr	1848(ra) # 800207c8 <memmove>
  for (int i = 0; i < PX(2, MAXUVA); i++) {
    kpagetable[i] = 0;
    80024098:	000ab023          	sd	zero,0(s5)
    8002409c:	000ab423          	sd	zero,8(s5)
  }

  if((ep = ename(path)) == NULL) {
    800240a0:	854a                	mv	a0,s2
    800240a2:	00003097          	auipc	ra,0x3
    800240a6:	a30080e7          	jalr	-1488(ra) # 80026ad2 <ename>
    800240aa:	8a2a                	mv	s4,a0
    800240ac:	3a050963          	beqz	a0,8002445e <exec+0x420>
    #ifdef DEBUG
    printf("[exec] %s not found\n", path);
    #endif
    goto bad;
  }
  elock(ep);
    800240b0:	00002097          	auipc	ra,0x2
    800240b4:	27c080e7          	jalr	636(ra) # 8002632c <elock>

  // Check ELF header
  if(eread(ep, 0, (uint64) &elf, 0, sizeof(elf)) != sizeof(elf))
    800240b8:	04000713          	li	a4,64
    800240bc:	4681                	li	a3,0
    800240be:	e4840613          	addi	a2,s0,-440
    800240c2:	4581                	li	a1,0
    800240c4:	8552                	mv	a0,s4
    800240c6:	00002097          	auipc	ra,0x2
    800240ca:	998080e7          	jalr	-1640(ra) # 80025a5e <eread>
    800240ce:	04000793          	li	a5,64
    800240d2:	00f51a63          	bne	a0,a5,800240e6 <exec+0xa8>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    800240d6:	e4842703          	lw	a4,-440(s0)
    800240da:	464c47b7          	lui	a5,0x464c4
    800240de:	57f78793          	addi	a5,a5,1407 # 464c457f <BASE_ADDRESS-0x39b5ba81>
    800240e2:	00f70963          	beq	a4,a5,800240f4 <exec+0xb6>
  printf("[exec] reach bad\n");
  #endif
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(kpagetable)
    kvmfree(kpagetable, 0);
    800240e6:	4581                	li	a1,0
    800240e8:	8556                	mv	a0,s5
    800240ea:	ffffd097          	auipc	ra,0xffffd
    800240ee:	6bc080e7          	jalr	1724(ra) # 800217a6 <kvmfree>
  if(ep){
    800240f2:	a495                	j	80024356 <exec+0x318>
  if((pagetable = proc_pagetable(p)) == NULL)
    800240f4:	8526                	mv	a0,s1
    800240f6:	ffffe097          	auipc	ra,0xffffe
    800240fa:	b72080e7          	jalr	-1166(ra) # 80021c68 <proc_pagetable>
    800240fe:	e0a43423          	sd	a0,-504(s0)
    80024102:	d175                	beqz	a0,800240e6 <exec+0xa8>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80024104:	e6842783          	lw	a5,-408(s0)
    80024108:	e8045703          	lhu	a4,-384(s0)
    8002410c:	c73d                	beqz	a4,8002417a <exec+0x13c>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    8002410e:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80024110:	e0043023          	sd	zero,-512(s0)
    if(ph.vaddr % PGSIZE != 0)
    80024114:	6b05                	lui	s6,0x1
    80024116:	fffb0713          	addi	a4,s6,-1 # fff <BASE_ADDRESS-0x8001f001>
    8002411a:	dce43c23          	sd	a4,-552(s0)
  for(i = 0; i < sz; i += PGSIZE){
    8002411e:	6d85                	lui	s11,0x1
    80024120:	7d7d                	lui	s10,0xfffff
    80024122:	a4c1                	j	800243e2 <exec+0x3a4>
      panic("loadseg: address should exist");
    80024124:	00008517          	auipc	a0,0x8
    80024128:	58450513          	addi	a0,a0,1412 # 8002c6a8 <sysnames+0x728>
    8002412c:	ffffc097          	auipc	ra,0xffffc
    80024130:	01a080e7          	jalr	26(ra) # 80020146 <panic>
    if(eread(ep, 0, (uint64)pa, offset+i, n) != n)
    80024134:	874e                	mv	a4,s3
    80024136:	009c86bb          	addw	a3,s9,s1
    8002413a:	4581                	li	a1,0
    8002413c:	8552                	mv	a0,s4
    8002413e:	00002097          	auipc	ra,0x2
    80024142:	920080e7          	jalr	-1760(ra) # 80025a5e <eread>
    80024146:	2501                	sext.w	a0,a0
    80024148:	1ea99663          	bne	s3,a0,80024334 <exec+0x2f6>
  for(i = 0; i < sz; i += PGSIZE){
    8002414c:	009d84bb          	addw	s1,s11,s1
    80024150:	012d093b          	addw	s2,s10,s2
    80024154:	2774f763          	bgeu	s1,s7,800243c2 <exec+0x384>
    pa = walkaddr(pagetable, va + i);
    80024158:	02049593          	slli	a1,s1,0x20
    8002415c:	9181                	srli	a1,a1,0x20
    8002415e:	95e2                	add	a1,a1,s8
    80024160:	e0843503          	ld	a0,-504(s0)
    80024164:	ffffd097          	auipc	ra,0xffffd
    80024168:	ac2080e7          	jalr	-1342(ra) # 80020c26 <walkaddr>
    8002416c:	862a                	mv	a2,a0
    if(pa == NULL)
    8002416e:	d95d                	beqz	a0,80024124 <exec+0xe6>
      n = PGSIZE;
    80024170:	89da                	mv	s3,s6
    if(sz - i < PGSIZE)
    80024172:	fd6971e3          	bgeu	s2,s6,80024134 <exec+0xf6>
      n = sz - i;
    80024176:	89ca                	mv	s3,s2
    80024178:	bf75                	j	80024134 <exec+0xf6>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    8002417a:	4481                	li	s1,0
  eunlock(ep);
    8002417c:	8552                	mv	a0,s4
    8002417e:	00002097          	auipc	ra,0x2
    80024182:	1e4080e7          	jalr	484(ra) # 80026362 <eunlock>
  eput(ep);
    80024186:	8552                	mv	a0,s4
    80024188:	00002097          	auipc	ra,0x2
    8002418c:	228080e7          	jalr	552(ra) # 800263b0 <eput>
  p = myproc();
    80024190:	ffffe097          	auipc	ra,0xffffe
    80024194:	9f2080e7          	jalr	-1550(ra) # 80021b82 <myproc>
    80024198:	8b2a                	mv	s6,a0
  uint64 oldsz = p->sz;
    8002419a:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    8002419e:	6785                	lui	a5,0x1
    800241a0:	17fd                	addi	a5,a5,-1
    800241a2:	94be                	add	s1,s1,a5
    800241a4:	77fd                	lui	a5,0xfffff
    800241a6:	8fe5                	and	a5,a5,s1
    800241a8:	def43823          	sd	a5,-528(s0)
  if((sz1 = uvmalloc(pagetable, kpagetable, sz, sz + 2*PGSIZE)) == 0)
    800241ac:	6689                	lui	a3,0x2
    800241ae:	96be                	add	a3,a3,a5
    800241b0:	863e                	mv	a2,a5
    800241b2:	85d6                	mv	a1,s5
    800241b4:	e0843483          	ld	s1,-504(s0)
    800241b8:	8526                	mv	a0,s1
    800241ba:	ffffd097          	auipc	ra,0xffffd
    800241be:	f6a080e7          	jalr	-150(ra) # 80021124 <uvmalloc>
    800241c2:	8caa                	mv	s9,a0
  ep = 0;
    800241c4:	4a01                	li	s4,0
  if((sz1 = uvmalloc(pagetable, kpagetable, sz, sz + 2*PGSIZE)) == 0)
    800241c6:	16050763          	beqz	a0,80024334 <exec+0x2f6>
  uvmclear(pagetable, sz-2*PGSIZE);
    800241ca:	75f9                	lui	a1,0xffffe
    800241cc:	95aa                	add	a1,a1,a0
    800241ce:	8526                	mv	a0,s1
    800241d0:	ffffd097          	auipc	ra,0xffffd
    800241d4:	1fa080e7          	jalr	506(ra) # 800213ca <uvmclear>
  stackbase = sp - PGSIZE;
    800241d8:	7bfd                	lui	s7,0xfffff
    800241da:	9be6                	add	s7,s7,s9
  for(argc = 0; argv[argc]; argc++) {
    800241dc:	de843783          	ld	a5,-536(s0)
    800241e0:	6388                	ld	a0,0(a5)
    800241e2:	c925                	beqz	a0,80024252 <exec+0x214>
    800241e4:	e8840993          	addi	s3,s0,-376
    800241e8:	f8840c13          	addi	s8,s0,-120
  sp = sz;
    800241ec:	8966                	mv	s2,s9
  for(argc = 0; argv[argc]; argc++) {
    800241ee:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    800241f0:	ffffc097          	auipc	ra,0xffffc
    800241f4:	716080e7          	jalr	1814(ra) # 80020906 <strlen>
    800241f8:	2505                	addiw	a0,a0,1
    800241fa:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800241fe:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80024202:	1b796463          	bltu	s2,s7,800243aa <exec+0x36c>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80024206:	de843d83          	ld	s11,-536(s0)
    8002420a:	000dba03          	ld	s4,0(s11) # 1000 <BASE_ADDRESS-0x8001f000>
    8002420e:	8552                	mv	a0,s4
    80024210:	ffffc097          	auipc	ra,0xffffc
    80024214:	6f6080e7          	jalr	1782(ra) # 80020906 <strlen>
    80024218:	0015069b          	addiw	a3,a0,1
    8002421c:	8652                	mv	a2,s4
    8002421e:	85ca                	mv	a1,s2
    80024220:	e0843503          	ld	a0,-504(s0)
    80024224:	ffffd097          	auipc	ra,0xffffd
    80024228:	1d8080e7          	jalr	472(ra) # 800213fc <copyout>
    8002422c:	18054363          	bltz	a0,800243b2 <exec+0x374>
    ustack[argc] = sp;
    80024230:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80024234:	0485                	addi	s1,s1,1
    80024236:	008d8793          	addi	a5,s11,8
    8002423a:	def43423          	sd	a5,-536(s0)
    8002423e:	008db503          	ld	a0,8(s11)
    80024242:	c911                	beqz	a0,80024256 <exec+0x218>
    if(argc >= MAXARG)
    80024244:	09a1                	addi	s3,s3,8
    80024246:	fb3c15e3          	bne	s8,s3,800241f0 <exec+0x1b2>
  sz = sz1;
    8002424a:	df943823          	sd	s9,-528(s0)
  ep = 0;
    8002424e:	4a01                	li	s4,0
    80024250:	a0d5                	j	80024334 <exec+0x2f6>
  sp = sz;
    80024252:	8966                	mv	s2,s9
  for(argc = 0; argv[argc]; argc++) {
    80024254:	4481                	li	s1,0
  ustack[argc] = 0;
    80024256:	00349793          	slli	a5,s1,0x3
    8002425a:	f9040713          	addi	a4,s0,-112
    8002425e:	97ba                	add	a5,a5,a4
    80024260:	ee07bc23          	sd	zero,-264(a5) # ffffffffffffeef8 <kernel_end+0xffffffff7ffb8ef8>
  sp -= (argc+1) * sizeof(uint64);
    80024264:	00148693          	addi	a3,s1,1
    80024268:	068e                	slli	a3,a3,0x3
    8002426a:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8002426e:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80024272:	01797663          	bgeu	s2,s7,8002427e <exec+0x240>
  sz = sz1;
    80024276:	df943823          	sd	s9,-528(s0)
  ep = 0;
    8002427a:	4a01                	li	s4,0
    8002427c:	a865                	j	80024334 <exec+0x2f6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8002427e:	e8840613          	addi	a2,s0,-376
    80024282:	85ca                	mv	a1,s2
    80024284:	e0843503          	ld	a0,-504(s0)
    80024288:	ffffd097          	auipc	ra,0xffffd
    8002428c:	174080e7          	jalr	372(ra) # 800213fc <copyout>
    80024290:	12054563          	bltz	a0,800243ba <exec+0x37c>
  p->trapframe->a1 = sp;
    80024294:	060b3783          	ld	a5,96(s6)
    80024298:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8002429c:	de043783          	ld	a5,-544(s0)
    800242a0:	0007c703          	lbu	a4,0(a5)
    800242a4:	cf11                	beqz	a4,800242c0 <exec+0x282>
    800242a6:	0785                	addi	a5,a5,1
    if(*s == '/')
    800242a8:	02f00693          	li	a3,47
    800242ac:	a029                	j	800242b6 <exec+0x278>
    800242ae:	0785                	addi	a5,a5,1
  for(last=s=path; *s; s++)
    800242b0:	fff7c703          	lbu	a4,-1(a5)
    800242b4:	c711                	beqz	a4,800242c0 <exec+0x282>
    if(*s == '/')
    800242b6:	fed71ce3          	bne	a4,a3,800242ae <exec+0x270>
      last = s+1;
    800242ba:	def43023          	sd	a5,-544(s0)
    800242be:	bfc5                	j	800242ae <exec+0x270>
  safestrcpy(p->name, last, sizeof(p->name));
    800242c0:	4641                	li	a2,16
    800242c2:	de043583          	ld	a1,-544(s0)
    800242c6:	160b0513          	addi	a0,s6,352
    800242ca:	ffffc097          	auipc	ra,0xffffc
    800242ce:	60a080e7          	jalr	1546(ra) # 800208d4 <safestrcpy>
  oldpagetable = p->pagetable;
    800242d2:	050b3503          	ld	a0,80(s6)
  oldkpagetable = p->kpagetable;
    800242d6:	058b3983          	ld	s3,88(s6)
  p->pagetable = pagetable;
    800242da:	e0843783          	ld	a5,-504(s0)
    800242de:	04fb3823          	sd	a5,80(s6)
  p->kpagetable = kpagetable;
    800242e2:	055b3c23          	sd	s5,88(s6)
  p->sz = sz;
    800242e6:	059b3423          	sd	s9,72(s6)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800242ea:	060b3783          	ld	a5,96(s6)
    800242ee:	e6043703          	ld	a4,-416(s0)
    800242f2:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800242f4:	060b3783          	ld	a5,96(s6)
    800242f8:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800242fc:	85ea                	mv	a1,s10
    800242fe:	ffffe097          	auipc	ra,0xffffe
    80024302:	a06080e7          	jalr	-1530(ra) # 80021d04 <proc_freepagetable>
  w_satp(MAKE_SATP(p->kpagetable));
    80024306:	058b3783          	ld	a5,88(s6)
    8002430a:	83b1                	srli	a5,a5,0xc
    8002430c:	577d                	li	a4,-1
    8002430e:	177e                	slli	a4,a4,0x3f
    80024310:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80024312:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    80024316:	12000073          	sfence.vma
  kvmfree(oldkpagetable, 0);
    8002431a:	4581                	li	a1,0
    8002431c:	854e                	mv	a0,s3
    8002431e:	ffffd097          	auipc	ra,0xffffd
    80024322:	488080e7          	jalr	1160(ra) # 800217a6 <kvmfree>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80024326:	0004851b          	sext.w	a0,s1
    8002432a:	a089                	j	8002436c <exec+0x32e>
    return -1;
    8002432c:	557d                	li	a0,-1
    8002432e:	a83d                	j	8002436c <exec+0x32e>
    80024330:	de943823          	sd	s1,-528(s0)
    proc_freepagetable(pagetable, sz);
    80024334:	df043583          	ld	a1,-528(s0)
    80024338:	e0843503          	ld	a0,-504(s0)
    8002433c:	ffffe097          	auipc	ra,0xffffe
    80024340:	9c8080e7          	jalr	-1592(ra) # 80021d04 <proc_freepagetable>
    kvmfree(kpagetable, 0);
    80024344:	4581                	li	a1,0
    80024346:	8556                	mv	a0,s5
    80024348:	ffffd097          	auipc	ra,0xffffd
    8002434c:	45e080e7          	jalr	1118(ra) # 800217a6 <kvmfree>
    eunlock(ep);
    eput(ep);
  }
  return -1;
    80024350:	557d                	li	a0,-1
  if(ep){
    80024352:	000a0d63          	beqz	s4,8002436c <exec+0x32e>
    eunlock(ep);
    80024356:	8552                	mv	a0,s4
    80024358:	00002097          	auipc	ra,0x2
    8002435c:	00a080e7          	jalr	10(ra) # 80026362 <eunlock>
    eput(ep);
    80024360:	8552                	mv	a0,s4
    80024362:	00002097          	auipc	ra,0x2
    80024366:	04e080e7          	jalr	78(ra) # 800263b0 <eput>
  return -1;
    8002436a:	557d                	li	a0,-1
}
    8002436c:	22813083          	ld	ra,552(sp)
    80024370:	22013403          	ld	s0,544(sp)
    80024374:	21813483          	ld	s1,536(sp)
    80024378:	21013903          	ld	s2,528(sp)
    8002437c:	20813983          	ld	s3,520(sp)
    80024380:	20013a03          	ld	s4,512(sp)
    80024384:	7afe                	ld	s5,504(sp)
    80024386:	7b5e                	ld	s6,496(sp)
    80024388:	7bbe                	ld	s7,488(sp)
    8002438a:	7c1e                	ld	s8,480(sp)
    8002438c:	6cfe                	ld	s9,472(sp)
    8002438e:	6d5e                	ld	s10,464(sp)
    80024390:	6dbe                	ld	s11,456(sp)
    80024392:	23010113          	addi	sp,sp,560
    80024396:	8082                	ret
    80024398:	de943823          	sd	s1,-528(s0)
    8002439c:	bf61                	j	80024334 <exec+0x2f6>
    8002439e:	de943823          	sd	s1,-528(s0)
    800243a2:	bf49                	j	80024334 <exec+0x2f6>
    800243a4:	de943823          	sd	s1,-528(s0)
    800243a8:	b771                	j	80024334 <exec+0x2f6>
  sz = sz1;
    800243aa:	df943823          	sd	s9,-528(s0)
  ep = 0;
    800243ae:	4a01                	li	s4,0
    800243b0:	b751                	j	80024334 <exec+0x2f6>
  sz = sz1;
    800243b2:	df943823          	sd	s9,-528(s0)
  ep = 0;
    800243b6:	4a01                	li	s4,0
    800243b8:	bfb5                	j	80024334 <exec+0x2f6>
  sz = sz1;
    800243ba:	df943823          	sd	s9,-528(s0)
  ep = 0;
    800243be:	4a01                	li	s4,0
    800243c0:	bf95                	j	80024334 <exec+0x2f6>
    if((sz1 = uvmalloc(pagetable, kpagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800243c2:	df043483          	ld	s1,-528(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800243c6:	e0043783          	ld	a5,-512(s0)
    800243ca:	0017869b          	addiw	a3,a5,1
    800243ce:	e0d43023          	sd	a3,-512(s0)
    800243d2:	df843783          	ld	a5,-520(s0)
    800243d6:	0387879b          	addiw	a5,a5,56
    800243da:	e8045703          	lhu	a4,-384(s0)
    800243de:	d8e6dfe3          	bge	a3,a4,8002417c <exec+0x13e>
    if(eread(ep, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800243e2:	2781                	sext.w	a5,a5
    800243e4:	def43c23          	sd	a5,-520(s0)
    800243e8:	03800713          	li	a4,56
    800243ec:	86be                	mv	a3,a5
    800243ee:	e1040613          	addi	a2,s0,-496
    800243f2:	4581                	li	a1,0
    800243f4:	8552                	mv	a0,s4
    800243f6:	00001097          	auipc	ra,0x1
    800243fa:	668080e7          	jalr	1640(ra) # 80025a5e <eread>
    800243fe:	03800793          	li	a5,56
    80024402:	f2f517e3          	bne	a0,a5,80024330 <exec+0x2f2>
    if(ph.type != ELF_PROG_LOAD)
    80024406:	e1042783          	lw	a5,-496(s0)
    8002440a:	4705                	li	a4,1
    8002440c:	fae79de3          	bne	a5,a4,800243c6 <exec+0x388>
    if(ph.memsz < ph.filesz)
    80024410:	e3843683          	ld	a3,-456(s0)
    80024414:	e3043783          	ld	a5,-464(s0)
    80024418:	f8f6e0e3          	bltu	a3,a5,80024398 <exec+0x35a>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    8002441c:	e2043783          	ld	a5,-480(s0)
    80024420:	96be                	add	a3,a3,a5
    80024422:	f6f6eee3          	bltu	a3,a5,8002439e <exec+0x360>
    if((sz1 = uvmalloc(pagetable, kpagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80024426:	8626                	mv	a2,s1
    80024428:	85d6                	mv	a1,s5
    8002442a:	e0843503          	ld	a0,-504(s0)
    8002442e:	ffffd097          	auipc	ra,0xffffd
    80024432:	cf6080e7          	jalr	-778(ra) # 80021124 <uvmalloc>
    80024436:	dea43823          	sd	a0,-528(s0)
    8002443a:	d52d                	beqz	a0,800243a4 <exec+0x366>
    if(ph.vaddr % PGSIZE != 0)
    8002443c:	e2043c03          	ld	s8,-480(s0)
    80024440:	dd843783          	ld	a5,-552(s0)
    80024444:	00fc77b3          	and	a5,s8,a5
    80024448:	ee0796e3          	bnez	a5,80024334 <exec+0x2f6>
    if(loadseg(pagetable, ph.vaddr, ep, ph.off, ph.filesz) < 0)
    8002444c:	e1842c83          	lw	s9,-488(s0)
    80024450:	e3042b83          	lw	s7,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80024454:	f60b87e3          	beqz	s7,800243c2 <exec+0x384>
    80024458:	895e                	mv	s2,s7
    8002445a:	4481                	li	s1,0
    8002445c:	b9f5                	j	80024158 <exec+0x11a>
    kvmfree(kpagetable, 0);
    8002445e:	4581                	li	a1,0
    80024460:	8556                	mv	a0,s5
    80024462:	ffffd097          	auipc	ra,0xffffd
    80024466:	344080e7          	jalr	836(ra) # 800217a6 <kvmfree>
  return -1;
    8002446a:	557d                	li	a0,-1
    8002446c:	b701                	j	8002436c <exec+0x32e>

000000008002446e <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8002446e:	7179                	addi	sp,sp,-48
    80024470:	f406                	sd	ra,40(sp)
    80024472:	f022                	sd	s0,32(sp)
    80024474:	ec26                	sd	s1,24(sp)
    80024476:	e84a                	sd	s2,16(sp)
    80024478:	1800                	addi	s0,sp,48
    8002447a:	892e                	mv	s2,a1
    8002447c:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    8002447e:	fdc40593          	addi	a1,s0,-36
    80024482:	fffff097          	auipc	ra,0xfffff
    80024486:	ab0080e7          	jalr	-1360(ra) # 80022f32 <argint>
    8002448a:	04054063          	bltz	a0,800244ca <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == NULL)
    8002448e:	fdc42703          	lw	a4,-36(s0)
    80024492:	47bd                	li	a5,15
    80024494:	02e7ed63          	bltu	a5,a4,800244ce <argfd+0x60>
    80024498:	ffffd097          	auipc	ra,0xffffd
    8002449c:	6ea080e7          	jalr	1770(ra) # 80021b82 <myproc>
    800244a0:	fdc42703          	lw	a4,-36(s0)
    800244a4:	01a70793          	addi	a5,a4,26
    800244a8:	078e                	slli	a5,a5,0x3
    800244aa:	953e                	add	a0,a0,a5
    800244ac:	651c                	ld	a5,8(a0)
    800244ae:	c395                	beqz	a5,800244d2 <argfd+0x64>
    return -1;
  if(pfd)
    800244b0:	00090463          	beqz	s2,800244b8 <argfd+0x4a>
    *pfd = fd;
    800244b4:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800244b8:	4501                	li	a0,0
  if(pf)
    800244ba:	c091                	beqz	s1,800244be <argfd+0x50>
    *pf = f;
    800244bc:	e09c                	sd	a5,0(s1)
}
    800244be:	70a2                	ld	ra,40(sp)
    800244c0:	7402                	ld	s0,32(sp)
    800244c2:	64e2                	ld	s1,24(sp)
    800244c4:	6942                	ld	s2,16(sp)
    800244c6:	6145                	addi	sp,sp,48
    800244c8:	8082                	ret
    return -1;
    800244ca:	557d                	li	a0,-1
    800244cc:	bfcd                	j	800244be <argfd+0x50>
    return -1;
    800244ce:	557d                	li	a0,-1
    800244d0:	b7fd                	j	800244be <argfd+0x50>
    800244d2:	557d                	li	a0,-1
    800244d4:	b7ed                	j	800244be <argfd+0x50>

00000000800244d6 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800244d6:	1101                	addi	sp,sp,-32
    800244d8:	ec06                	sd	ra,24(sp)
    800244da:	e822                	sd	s0,16(sp)
    800244dc:	e426                	sd	s1,8(sp)
    800244de:	1000                	addi	s0,sp,32
    800244e0:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800244e2:	ffffd097          	auipc	ra,0xffffd
    800244e6:	6a0080e7          	jalr	1696(ra) # 80021b82 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(p->ofile[fd] == 0){
    800244ea:	6d7c                	ld	a5,216(a0)
    800244ec:	c395                	beqz	a5,80024510 <fdalloc+0x3a>
    800244ee:	0e050713          	addi	a4,a0,224
  for(fd = 0; fd < NOFILE; fd++){
    800244f2:	4785                	li	a5,1
    800244f4:	4641                	li	a2,16
    if(p->ofile[fd] == 0){
    800244f6:	6314                	ld	a3,0(a4)
    800244f8:	ce89                	beqz	a3,80024512 <fdalloc+0x3c>
  for(fd = 0; fd < NOFILE; fd++){
    800244fa:	2785                	addiw	a5,a5,1
    800244fc:	0721                	addi	a4,a4,8
    800244fe:	fec79ce3          	bne	a5,a2,800244f6 <fdalloc+0x20>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80024502:	57fd                	li	a5,-1
}
    80024504:	853e                	mv	a0,a5
    80024506:	60e2                	ld	ra,24(sp)
    80024508:	6442                	ld	s0,16(sp)
    8002450a:	64a2                	ld	s1,8(sp)
    8002450c:	6105                	addi	sp,sp,32
    8002450e:	8082                	ret
  for(fd = 0; fd < NOFILE; fd++){
    80024510:	4781                	li	a5,0
      p->ofile[fd] = f;
    80024512:	01a78713          	addi	a4,a5,26
    80024516:	070e                	slli	a4,a4,0x3
    80024518:	953a                	add	a0,a0,a4
    8002451a:	e504                	sd	s1,8(a0)
      return fd;
    8002451c:	b7e5                	j	80024504 <fdalloc+0x2e>

000000008002451e <create>:
  return filestat(f, st);
}

static struct dirent*
create(char *path, short type, int mode)
{
    8002451e:	7169                	addi	sp,sp,-304
    80024520:	f606                	sd	ra,296(sp)
    80024522:	f222                	sd	s0,288(sp)
    80024524:	ee26                	sd	s1,280(sp)
    80024526:	ea4a                	sd	s2,272(sp)
    80024528:	e64e                	sd	s3,264(sp)
    8002452a:	1a00                	addi	s0,sp,304
    8002452c:	89ae                	mv	s3,a1
  struct dirent *ep, *dp;
  char name[FAT32_MAX_FILENAME + 1];

  if((dp = enameparent(path, name)) == NULL)
    8002452e:	ed040593          	addi	a1,s0,-304
    80024532:	00002097          	auipc	ra,0x2
    80024536:	5be080e7          	jalr	1470(ra) # 80026af0 <enameparent>
    8002453a:	84aa                	mv	s1,a0
    8002453c:	cd3d                	beqz	a0,800245ba <create+0x9c>
    return NULL;

  if (type == T_DIR) {
    8002453e:	0009879b          	sext.w	a5,s3
    80024542:	4705                	li	a4,1
    80024544:	06e78d63          	beq	a5,a4,800245be <create+0xa0>
    mode = ATTR_READ_ONLY;
  } else {
    mode = 0;  
  }

  elock(dp);
    80024548:	00002097          	auipc	ra,0x2
    8002454c:	de4080e7          	jalr	-540(ra) # 8002632c <elock>
  if ((ep = ealloc(dp, name, mode)) == NULL) {
    80024550:	4601                	li	a2,0
    80024552:	ed040593          	addi	a1,s0,-304
    80024556:	8526                	mv	a0,s1
    80024558:	00002097          	auipc	ra,0x2
    8002455c:	2bc080e7          	jalr	700(ra) # 80026814 <ealloc>
    80024560:	892a                	mv	s2,a0
    80024562:	c121                	beqz	a0,800245a2 <create+0x84>
    eunlock(dp);
    eput(dp);
    return NULL;
  }
  
  if ((type == T_DIR && !(ep->attribute & ATTR_DIRECTORY)) ||
    80024564:	2981                	sext.w	s3,s3
    80024566:	4789                	li	a5,2
    80024568:	00f99663          	bne	s3,a5,80024574 <create+0x56>
      (type == T_FILE && (ep->attribute & ATTR_DIRECTORY))) {
    8002456c:	10094783          	lbu	a5,256(s2)
    80024570:	8bc1                	andi	a5,a5,16
    80024572:	eba5                	bnez	a5,800245e2 <create+0xc4>
    eput(ep);
    eput(dp);
    return NULL;
  }

  eunlock(dp);
    80024574:	8526                	mv	a0,s1
    80024576:	00002097          	auipc	ra,0x2
    8002457a:	dec080e7          	jalr	-532(ra) # 80026362 <eunlock>
  eput(dp);
    8002457e:	8526                	mv	a0,s1
    80024580:	00002097          	auipc	ra,0x2
    80024584:	e30080e7          	jalr	-464(ra) # 800263b0 <eput>

  elock(ep);
    80024588:	854a                	mv	a0,s2
    8002458a:	00002097          	auipc	ra,0x2
    8002458e:	da2080e7          	jalr	-606(ra) # 8002632c <elock>
  return ep;
}
    80024592:	854a                	mv	a0,s2
    80024594:	70b2                	ld	ra,296(sp)
    80024596:	7412                	ld	s0,288(sp)
    80024598:	64f2                	ld	s1,280(sp)
    8002459a:	6952                	ld	s2,272(sp)
    8002459c:	69b2                	ld	s3,264(sp)
    8002459e:	6155                	addi	sp,sp,304
    800245a0:	8082                	ret
    eunlock(dp);
    800245a2:	8526                	mv	a0,s1
    800245a4:	00002097          	auipc	ra,0x2
    800245a8:	dbe080e7          	jalr	-578(ra) # 80026362 <eunlock>
    eput(dp);
    800245ac:	8526                	mv	a0,s1
    800245ae:	00002097          	auipc	ra,0x2
    800245b2:	e02080e7          	jalr	-510(ra) # 800263b0 <eput>
    return NULL;
    800245b6:	4901                	li	s2,0
    800245b8:	bfe9                	j	80024592 <create+0x74>
    return NULL;
    800245ba:	892a                	mv	s2,a0
    800245bc:	bfd9                	j	80024592 <create+0x74>
  elock(dp);
    800245be:	00002097          	auipc	ra,0x2
    800245c2:	d6e080e7          	jalr	-658(ra) # 8002632c <elock>
  if ((ep = ealloc(dp, name, mode)) == NULL) {
    800245c6:	4641                	li	a2,16
    800245c8:	ed040593          	addi	a1,s0,-304
    800245cc:	8526                	mv	a0,s1
    800245ce:	00002097          	auipc	ra,0x2
    800245d2:	246080e7          	jalr	582(ra) # 80026814 <ealloc>
    800245d6:	892a                	mv	s2,a0
    800245d8:	d569                	beqz	a0,800245a2 <create+0x84>
  if ((type == T_DIR && !(ep->attribute & ATTR_DIRECTORY)) ||
    800245da:	10094783          	lbu	a5,256(s2)
    800245de:	8bc1                	andi	a5,a5,16
    800245e0:	fbd1                	bnez	a5,80024574 <create+0x56>
    eunlock(dp);
    800245e2:	8526                	mv	a0,s1
    800245e4:	00002097          	auipc	ra,0x2
    800245e8:	d7e080e7          	jalr	-642(ra) # 80026362 <eunlock>
    eput(ep);
    800245ec:	854a                	mv	a0,s2
    800245ee:	00002097          	auipc	ra,0x2
    800245f2:	dc2080e7          	jalr	-574(ra) # 800263b0 <eput>
    eput(dp);
    800245f6:	8526                	mv	a0,s1
    800245f8:	00002097          	auipc	ra,0x2
    800245fc:	db8080e7          	jalr	-584(ra) # 800263b0 <eput>
    return NULL;
    80024600:	4901                	li	s2,0
    80024602:	bf41                	j	80024592 <create+0x74>

0000000080024604 <sys_dup>:
{
    80024604:	7179                	addi	sp,sp,-48
    80024606:	f406                	sd	ra,40(sp)
    80024608:	f022                	sd	s0,32(sp)
    8002460a:	ec26                	sd	s1,24(sp)
    8002460c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    8002460e:	fd840613          	addi	a2,s0,-40
    80024612:	4581                	li	a1,0
    80024614:	4501                	li	a0,0
    80024616:	00000097          	auipc	ra,0x0
    8002461a:	e58080e7          	jalr	-424(ra) # 8002446e <argfd>
    return -1;
    8002461e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80024620:	02054363          	bltz	a0,80024646 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80024624:	fd843503          	ld	a0,-40(s0)
    80024628:	00000097          	auipc	ra,0x0
    8002462c:	eae080e7          	jalr	-338(ra) # 800244d6 <fdalloc>
    80024630:	84aa                	mv	s1,a0
    return -1;
    80024632:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80024634:	00054963          	bltz	a0,80024646 <sys_dup+0x42>
  filedup(f);
    80024638:	fd843503          	ld	a0,-40(s0)
    8002463c:	fffff097          	auipc	ra,0xfffff
    80024640:	2d8080e7          	jalr	728(ra) # 80023914 <filedup>
  return fd;
    80024644:	87a6                	mv	a5,s1
}
    80024646:	853e                	mv	a0,a5
    80024648:	70a2                	ld	ra,40(sp)
    8002464a:	7402                	ld	s0,32(sp)
    8002464c:	64e2                	ld	s1,24(sp)
    8002464e:	6145                	addi	sp,sp,48
    80024650:	8082                	ret

0000000080024652 <sys_read>:
{
    80024652:	7179                	addi	sp,sp,-48
    80024654:	f406                	sd	ra,40(sp)
    80024656:	f022                	sd	s0,32(sp)
    80024658:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002465a:	fe840613          	addi	a2,s0,-24
    8002465e:	4581                	li	a1,0
    80024660:	4501                	li	a0,0
    80024662:	00000097          	auipc	ra,0x0
    80024666:	e0c080e7          	jalr	-500(ra) # 8002446e <argfd>
    return -1;
    8002466a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002466c:	04054163          	bltz	a0,800246ae <sys_read+0x5c>
    80024670:	fe440593          	addi	a1,s0,-28
    80024674:	4509                	li	a0,2
    80024676:	fffff097          	auipc	ra,0xfffff
    8002467a:	8bc080e7          	jalr	-1860(ra) # 80022f32 <argint>
    return -1;
    8002467e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80024680:	02054763          	bltz	a0,800246ae <sys_read+0x5c>
    80024684:	fd840593          	addi	a1,s0,-40
    80024688:	4505                	li	a0,1
    8002468a:	fffff097          	auipc	ra,0xfffff
    8002468e:	90a080e7          	jalr	-1782(ra) # 80022f94 <argaddr>
    return -1;
    80024692:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80024694:	00054d63          	bltz	a0,800246ae <sys_read+0x5c>
  return fileread(f, p, n);
    80024698:	fe442603          	lw	a2,-28(s0)
    8002469c:	fd843583          	ld	a1,-40(s0)
    800246a0:	fe843503          	ld	a0,-24(s0)
    800246a4:	fffff097          	auipc	ra,0xfffff
    800246a8:	3d8080e7          	jalr	984(ra) # 80023a7c <fileread>
    800246ac:	87aa                	mv	a5,a0
}
    800246ae:	853e                	mv	a0,a5
    800246b0:	70a2                	ld	ra,40(sp)
    800246b2:	7402                	ld	s0,32(sp)
    800246b4:	6145                	addi	sp,sp,48
    800246b6:	8082                	ret

00000000800246b8 <sys_write>:
{
    800246b8:	7179                	addi	sp,sp,-48
    800246ba:	f406                	sd	ra,40(sp)
    800246bc:	f022                	sd	s0,32(sp)
    800246be:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800246c0:	fe840613          	addi	a2,s0,-24
    800246c4:	4581                	li	a1,0
    800246c6:	4501                	li	a0,0
    800246c8:	00000097          	auipc	ra,0x0
    800246cc:	da6080e7          	jalr	-602(ra) # 8002446e <argfd>
    return -1;
    800246d0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800246d2:	04054163          	bltz	a0,80024714 <sys_write+0x5c>
    800246d6:	fe440593          	addi	a1,s0,-28
    800246da:	4509                	li	a0,2
    800246dc:	fffff097          	auipc	ra,0xfffff
    800246e0:	856080e7          	jalr	-1962(ra) # 80022f32 <argint>
    return -1;
    800246e4:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800246e6:	02054763          	bltz	a0,80024714 <sys_write+0x5c>
    800246ea:	fd840593          	addi	a1,s0,-40
    800246ee:	4505                	li	a0,1
    800246f0:	fffff097          	auipc	ra,0xfffff
    800246f4:	8a4080e7          	jalr	-1884(ra) # 80022f94 <argaddr>
    return -1;
    800246f8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800246fa:	00054d63          	bltz	a0,80024714 <sys_write+0x5c>
  return filewrite(f, p, n);
    800246fe:	fe442603          	lw	a2,-28(s0)
    80024702:	fd843583          	ld	a1,-40(s0)
    80024706:	fe843503          	ld	a0,-24(s0)
    8002470a:	fffff097          	auipc	ra,0xfffff
    8002470e:	434080e7          	jalr	1076(ra) # 80023b3e <filewrite>
    80024712:	87aa                	mv	a5,a0
}
    80024714:	853e                	mv	a0,a5
    80024716:	70a2                	ld	ra,40(sp)
    80024718:	7402                	ld	s0,32(sp)
    8002471a:	6145                	addi	sp,sp,48
    8002471c:	8082                	ret

000000008002471e <sys_close>:
{
    8002471e:	1101                	addi	sp,sp,-32
    80024720:	ec06                	sd	ra,24(sp)
    80024722:	e822                	sd	s0,16(sp)
    80024724:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80024726:	fe040613          	addi	a2,s0,-32
    8002472a:	fec40593          	addi	a1,s0,-20
    8002472e:	4501                	li	a0,0
    80024730:	00000097          	auipc	ra,0x0
    80024734:	d3e080e7          	jalr	-706(ra) # 8002446e <argfd>
    return -1;
    80024738:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    8002473a:	02054463          	bltz	a0,80024762 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    8002473e:	ffffd097          	auipc	ra,0xffffd
    80024742:	444080e7          	jalr	1092(ra) # 80021b82 <myproc>
    80024746:	fec42783          	lw	a5,-20(s0)
    8002474a:	07e9                	addi	a5,a5,26
    8002474c:	078e                	slli	a5,a5,0x3
    8002474e:	953e                	add	a0,a0,a5
    80024750:	00053423          	sd	zero,8(a0)
  fileclose(f);
    80024754:	fe043503          	ld	a0,-32(s0)
    80024758:	fffff097          	auipc	ra,0xfffff
    8002475c:	20e080e7          	jalr	526(ra) # 80023966 <fileclose>
  return 0;
    80024760:	4781                	li	a5,0
}
    80024762:	853e                	mv	a0,a5
    80024764:	60e2                	ld	ra,24(sp)
    80024766:	6442                	ld	s0,16(sp)
    80024768:	6105                	addi	sp,sp,32
    8002476a:	8082                	ret

000000008002476c <sys_fstat>:
{
    8002476c:	1101                	addi	sp,sp,-32
    8002476e:	ec06                	sd	ra,24(sp)
    80024770:	e822                	sd	s0,16(sp)
    80024772:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80024774:	fe840613          	addi	a2,s0,-24
    80024778:	4581                	li	a1,0
    8002477a:	4501                	li	a0,0
    8002477c:	00000097          	auipc	ra,0x0
    80024780:	cf2080e7          	jalr	-782(ra) # 8002446e <argfd>
    return -1;
    80024784:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80024786:	02054563          	bltz	a0,800247b0 <sys_fstat+0x44>
    8002478a:	fe040593          	addi	a1,s0,-32
    8002478e:	4505                	li	a0,1
    80024790:	fffff097          	auipc	ra,0xfffff
    80024794:	804080e7          	jalr	-2044(ra) # 80022f94 <argaddr>
    return -1;
    80024798:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8002479a:	00054b63          	bltz	a0,800247b0 <sys_fstat+0x44>
  return filestat(f, st);
    8002479e:	fe043583          	ld	a1,-32(s0)
    800247a2:	fe843503          	ld	a0,-24(s0)
    800247a6:	fffff097          	auipc	ra,0xfffff
    800247aa:	276080e7          	jalr	630(ra) # 80023a1c <filestat>
    800247ae:	87aa                	mv	a5,a0
}
    800247b0:	853e                	mv	a0,a5
    800247b2:	60e2                	ld	ra,24(sp)
    800247b4:	6442                	ld	s0,16(sp)
    800247b6:	6105                	addi	sp,sp,32
    800247b8:	8082                	ret

00000000800247ba <sys_open>:

uint64
sys_open(void)
{
    800247ba:	7129                	addi	sp,sp,-320
    800247bc:	fe06                	sd	ra,312(sp)
    800247be:	fa22                	sd	s0,304(sp)
    800247c0:	f626                	sd	s1,296(sp)
    800247c2:	f24a                	sd	s2,288(sp)
    800247c4:	ee4e                	sd	s3,280(sp)
    800247c6:	0280                	addi	s0,sp,320
  char path[FAT32_MAX_PATH];
  int fd, omode;
  struct file *f;
  struct dirent *ep;

  if(argstr(1, path, FAT32_MAX_PATH) < 0 || argint(2, &omode) < 0)
    800247c8:	10400613          	li	a2,260
    800247cc:	ec840593          	addi	a1,s0,-312
    800247d0:	4505                	li	a0,1
    800247d2:	ffffe097          	auipc	ra,0xffffe
    800247d6:	7e4080e7          	jalr	2020(ra) # 80022fb6 <argstr>
    return -1;
    800247da:	54fd                	li	s1,-1
  if(argstr(1, path, FAT32_MAX_PATH) < 0 || argint(2, &omode) < 0)
    800247dc:	08054d63          	bltz	a0,80024876 <sys_open+0xbc>
    800247e0:	ec440593          	addi	a1,s0,-316
    800247e4:	4509                	li	a0,2
    800247e6:	ffffe097          	auipc	ra,0xffffe
    800247ea:	74c080e7          	jalr	1868(ra) # 80022f32 <argint>
    800247ee:	0e054163          	bltz	a0,800248d0 <sys_open+0x116>

  if(omode & O_CREATE){
    800247f2:	ec442603          	lw	a2,-316(s0)
    800247f6:	20067793          	andi	a5,a2,512
    800247fa:	c7d1                	beqz	a5,80024886 <sys_open+0xcc>
    ep = create(path, T_FILE, omode);
    800247fc:	4589                	li	a1,2
    800247fe:	ec840513          	addi	a0,s0,-312
    80024802:	00000097          	auipc	ra,0x0
    80024806:	d1c080e7          	jalr	-740(ra) # 8002451e <create>
    8002480a:	892a                	mv	s2,a0
    if(ep == NULL){
    8002480c:	c561                	beqz	a0,800248d4 <sys_open+0x11a>
      eput(ep);
      return -1;
    }
  }

  if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    8002480e:	fffff097          	auipc	ra,0xfffff
    80024812:	088080e7          	jalr	136(ra) # 80023896 <filealloc>
    80024816:	89aa                	mv	s3,a0
    80024818:	c579                	beqz	a0,800248e6 <sys_open+0x12c>
    8002481a:	00000097          	auipc	ra,0x0
    8002481e:	cbc080e7          	jalr	-836(ra) # 800244d6 <fdalloc>
    80024822:	84aa                	mv	s1,a0
    80024824:	0a054c63          	bltz	a0,800248dc <sys_open+0x122>
    eunlock(ep);
    eput(ep);
    return -1;
  }

  if(!(ep->attribute & ATTR_DIRECTORY) && (omode & O_TRUNC)){
    80024828:	10094783          	lbu	a5,256(s2)
    8002482c:	8bc1                	andi	a5,a5,16
    8002482e:	e791                	bnez	a5,8002483a <sys_open+0x80>
    80024830:	ec442783          	lw	a5,-316(s0)
    80024834:	4007f793          	andi	a5,a5,1024
    80024838:	e7d1                	bnez	a5,800248c4 <sys_open+0x10a>
    etrunc(ep);
  }

  f->type = FD_ENTRY;
    8002483a:	4789                	li	a5,2
    8002483c:	00f9a023          	sw	a5,0(s3)
  f->off = (omode & O_APPEND) ? ep->file_size : 0;
    80024840:	ec442783          	lw	a5,-316(s0)
    80024844:	0047f693          	andi	a3,a5,4
    80024848:	4701                	li	a4,0
    8002484a:	c299                	beqz	a3,80024850 <sys_open+0x96>
    8002484c:	10892703          	lw	a4,264(s2)
    80024850:	02e9a023          	sw	a4,32(s3)
  f->ep = ep;
    80024854:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80024858:	0017c713          	xori	a4,a5,1
    8002485c:	8b05                	andi	a4,a4,1
    8002485e:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80024862:	8b8d                	andi	a5,a5,3
    80024864:	00f037b3          	snez	a5,a5
    80024868:	00f984a3          	sb	a5,9(s3)

  eunlock(ep);
    8002486c:	854a                	mv	a0,s2
    8002486e:	00002097          	auipc	ra,0x2
    80024872:	af4080e7          	jalr	-1292(ra) # 80026362 <eunlock>

  return fd;
}
    80024876:	8526                	mv	a0,s1
    80024878:	70f2                	ld	ra,312(sp)
    8002487a:	7452                	ld	s0,304(sp)
    8002487c:	74b2                	ld	s1,296(sp)
    8002487e:	7912                	ld	s2,288(sp)
    80024880:	69f2                	ld	s3,280(sp)
    80024882:	6131                	addi	sp,sp,320
    80024884:	8082                	ret
    if((ep = ename(path)) == NULL){
    80024886:	ec840513          	addi	a0,s0,-312
    8002488a:	00002097          	auipc	ra,0x2
    8002488e:	248080e7          	jalr	584(ra) # 80026ad2 <ename>
    80024892:	892a                	mv	s2,a0
    80024894:	c131                	beqz	a0,800248d8 <sys_open+0x11e>
    elock(ep);
    80024896:	00002097          	auipc	ra,0x2
    8002489a:	a96080e7          	jalr	-1386(ra) # 8002632c <elock>
    if((ep->attribute & ATTR_DIRECTORY) && omode != O_RDONLY){
    8002489e:	10094783          	lbu	a5,256(s2)
    800248a2:	8bc1                	andi	a5,a5,16
    800248a4:	d7ad                	beqz	a5,8002480e <sys_open+0x54>
    800248a6:	ec442783          	lw	a5,-316(s0)
    800248aa:	d3b5                	beqz	a5,8002480e <sys_open+0x54>
      eunlock(ep);
    800248ac:	854a                	mv	a0,s2
    800248ae:	00002097          	auipc	ra,0x2
    800248b2:	ab4080e7          	jalr	-1356(ra) # 80026362 <eunlock>
      eput(ep);
    800248b6:	854a                	mv	a0,s2
    800248b8:	00002097          	auipc	ra,0x2
    800248bc:	af8080e7          	jalr	-1288(ra) # 800263b0 <eput>
      return -1;
    800248c0:	54fd                	li	s1,-1
    800248c2:	bf55                	j	80024876 <sys_open+0xbc>
    etrunc(ep);
    800248c4:	854a                	mv	a0,s2
    800248c6:	00002097          	auipc	ra,0x2
    800248ca:	9fe080e7          	jalr	-1538(ra) # 800262c4 <etrunc>
    800248ce:	b7b5                	j	8002483a <sys_open+0x80>
    return -1;
    800248d0:	54fd                	li	s1,-1
    800248d2:	b755                	j	80024876 <sys_open+0xbc>
      return -1;
    800248d4:	54fd                	li	s1,-1
    800248d6:	b745                	j	80024876 <sys_open+0xbc>
      return -1;
    800248d8:	54fd                	li	s1,-1
    800248da:	bf71                	j	80024876 <sys_open+0xbc>
      fileclose(f);
    800248dc:	854e                	mv	a0,s3
    800248de:	fffff097          	auipc	ra,0xfffff
    800248e2:	088080e7          	jalr	136(ra) # 80023966 <fileclose>
    eunlock(ep);
    800248e6:	854a                	mv	a0,s2
    800248e8:	00002097          	auipc	ra,0x2
    800248ec:	a7a080e7          	jalr	-1414(ra) # 80026362 <eunlock>
    eput(ep);
    800248f0:	854a                	mv	a0,s2
    800248f2:	00002097          	auipc	ra,0x2
    800248f6:	abe080e7          	jalr	-1346(ra) # 800263b0 <eput>
    return -1;
    800248fa:	54fd                	li	s1,-1
    800248fc:	bfad                	j	80024876 <sys_open+0xbc>

00000000800248fe <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800248fe:	7169                	addi	sp,sp,-304
    80024900:	f606                	sd	ra,296(sp)
    80024902:	f222                	sd	s0,288(sp)
    80024904:	ee26                	sd	s1,280(sp)
    80024906:	1a00                	addi	s0,sp,304
  char path[FAT32_MAX_PATH];
  struct dirent *ep;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR, 0)) == 0){
    80024908:	10400613          	li	a2,260
    8002490c:	ed840593          	addi	a1,s0,-296
    80024910:	4501                	li	a0,0
    80024912:	ffffe097          	auipc	ra,0xffffe
    80024916:	6a4080e7          	jalr	1700(ra) # 80022fb6 <argstr>
    return -1;
    8002491a:	57fd                	li	a5,-1
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR, 0)) == 0){
    8002491c:	02054663          	bltz	a0,80024948 <sys_mkdir+0x4a>
    80024920:	4601                	li	a2,0
    80024922:	4585                	li	a1,1
    80024924:	ed840513          	addi	a0,s0,-296
    80024928:	00000097          	auipc	ra,0x0
    8002492c:	bf6080e7          	jalr	-1034(ra) # 8002451e <create>
    80024930:	84aa                	mv	s1,a0
    80024932:	c10d                	beqz	a0,80024954 <sys_mkdir+0x56>
  }
  eunlock(ep);
    80024934:	00002097          	auipc	ra,0x2
    80024938:	a2e080e7          	jalr	-1490(ra) # 80026362 <eunlock>
  eput(ep);
    8002493c:	8526                	mv	a0,s1
    8002493e:	00002097          	auipc	ra,0x2
    80024942:	a72080e7          	jalr	-1422(ra) # 800263b0 <eput>
  return 0;
    80024946:	4781                	li	a5,0
}
    80024948:	853e                	mv	a0,a5
    8002494a:	70b2                	ld	ra,296(sp)
    8002494c:	7412                	ld	s0,288(sp)
    8002494e:	64f2                	ld	s1,280(sp)
    80024950:	6155                	addi	sp,sp,304
    80024952:	8082                	ret
    return -1;
    80024954:	57fd                	li	a5,-1
    80024956:	bfcd                	j	80024948 <sys_mkdir+0x4a>

0000000080024958 <sys_chdir>:

uint64
sys_chdir(void)
{
    80024958:	7169                	addi	sp,sp,-304
    8002495a:	f606                	sd	ra,296(sp)
    8002495c:	f222                	sd	s0,288(sp)
    8002495e:	ee26                	sd	s1,280(sp)
    80024960:	ea4a                	sd	s2,272(sp)
    80024962:	1a00                	addi	s0,sp,304
  char path[FAT32_MAX_PATH];
  struct dirent *ep;
  struct proc *p = myproc();
    80024964:	ffffd097          	auipc	ra,0xffffd
    80024968:	21e080e7          	jalr	542(ra) # 80021b82 <myproc>
    8002496c:	892a                	mv	s2,a0
  
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = ename(path)) == NULL){
    8002496e:	10400613          	li	a2,260
    80024972:	ed840593          	addi	a1,s0,-296
    80024976:	4501                	li	a0,0
    80024978:	ffffe097          	auipc	ra,0xffffe
    8002497c:	63e080e7          	jalr	1598(ra) # 80022fb6 <argstr>
    return -1;
    80024980:	57fd                	li	a5,-1
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = ename(path)) == NULL){
    80024982:	04054063          	bltz	a0,800249c2 <sys_chdir+0x6a>
    80024986:	ed840513          	addi	a0,s0,-296
    8002498a:	00002097          	auipc	ra,0x2
    8002498e:	148080e7          	jalr	328(ra) # 80026ad2 <ename>
    80024992:	84aa                	mv	s1,a0
    80024994:	c931                	beqz	a0,800249e8 <sys_chdir+0x90>
  }
  elock(ep);
    80024996:	00002097          	auipc	ra,0x2
    8002499a:	996080e7          	jalr	-1642(ra) # 8002632c <elock>
  if(!(ep->attribute & ATTR_DIRECTORY)){
    8002499e:	1004c783          	lbu	a5,256(s1)
    800249a2:	8bc1                	andi	a5,a5,16
    800249a4:	c795                	beqz	a5,800249d0 <sys_chdir+0x78>
    eunlock(ep);
    eput(ep);
    return -1;
  }
  eunlock(ep);
    800249a6:	8526                	mv	a0,s1
    800249a8:	00002097          	auipc	ra,0x2
    800249ac:	9ba080e7          	jalr	-1606(ra) # 80026362 <eunlock>
  eput(p->cwd);
    800249b0:	15893503          	ld	a0,344(s2)
    800249b4:	00002097          	auipc	ra,0x2
    800249b8:	9fc080e7          	jalr	-1540(ra) # 800263b0 <eput>
  p->cwd = ep;
    800249bc:	14993c23          	sd	s1,344(s2)
  return 0;
    800249c0:	4781                	li	a5,0
}
    800249c2:	853e                	mv	a0,a5
    800249c4:	70b2                	ld	ra,296(sp)
    800249c6:	7412                	ld	s0,288(sp)
    800249c8:	64f2                	ld	s1,280(sp)
    800249ca:	6952                	ld	s2,272(sp)
    800249cc:	6155                	addi	sp,sp,304
    800249ce:	8082                	ret
    eunlock(ep);
    800249d0:	8526                	mv	a0,s1
    800249d2:	00002097          	auipc	ra,0x2
    800249d6:	990080e7          	jalr	-1648(ra) # 80026362 <eunlock>
    eput(ep);
    800249da:	8526                	mv	a0,s1
    800249dc:	00002097          	auipc	ra,0x2
    800249e0:	9d4080e7          	jalr	-1580(ra) # 800263b0 <eput>
    return -1;
    800249e4:	57fd                	li	a5,-1
    800249e6:	bff1                	j	800249c2 <sys_chdir+0x6a>
    return -1;
    800249e8:	57fd                	li	a5,-1
    800249ea:	bfe1                	j	800249c2 <sys_chdir+0x6a>

00000000800249ec <sys_pipe>:

uint64
sys_pipe(void)
{
    800249ec:	7139                	addi	sp,sp,-64
    800249ee:	fc06                	sd	ra,56(sp)
    800249f0:	f822                	sd	s0,48(sp)
    800249f2:	f426                	sd	s1,40(sp)
    800249f4:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800249f6:	ffffd097          	auipc	ra,0xffffd
    800249fa:	18c080e7          	jalr	396(ra) # 80021b82 <myproc>
    800249fe:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80024a00:	fd840593          	addi	a1,s0,-40
    80024a04:	4501                	li	a0,0
    80024a06:	ffffe097          	auipc	ra,0xffffe
    80024a0a:	58e080e7          	jalr	1422(ra) # 80022f94 <argaddr>
    return -1;
    80024a0e:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80024a10:	0c054d63          	bltz	a0,80024aea <sys_pipe+0xfe>
  if(pipealloc(&rf, &wf) < 0)
    80024a14:	fc840593          	addi	a1,s0,-56
    80024a18:	fd040513          	addi	a0,s0,-48
    80024a1c:	fffff097          	auipc	ra,0xfffff
    80024a20:	2b2080e7          	jalr	690(ra) # 80023cce <pipealloc>
    return -1;
    80024a24:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80024a26:	0c054263          	bltz	a0,80024aea <sys_pipe+0xfe>
  fd0 = -1;
    80024a2a:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80024a2e:	fd043503          	ld	a0,-48(s0)
    80024a32:	00000097          	auipc	ra,0x0
    80024a36:	aa4080e7          	jalr	-1372(ra) # 800244d6 <fdalloc>
    80024a3a:	fca42223          	sw	a0,-60(s0)
    80024a3e:	08054963          	bltz	a0,80024ad0 <sys_pipe+0xe4>
    80024a42:	fc843503          	ld	a0,-56(s0)
    80024a46:	00000097          	auipc	ra,0x0
    80024a4a:	a90080e7          	jalr	-1392(ra) # 800244d6 <fdalloc>
    80024a4e:	fca42023          	sw	a0,-64(s0)
    80024a52:	06054663          	bltz	a0,80024abe <sys_pipe+0xd2>
    fileclose(wf);
    return -1;
  }
  // if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
  //    copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
  if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80024a56:	4611                	li	a2,4
    80024a58:	fc440593          	addi	a1,s0,-60
    80024a5c:	fd843503          	ld	a0,-40(s0)
    80024a60:	ffffd097          	auipc	ra,0xffffd
    80024a64:	a28080e7          	jalr	-1496(ra) # 80021488 <copyout2>
    80024a68:	00054f63          	bltz	a0,80024a86 <sys_pipe+0x9a>
     copyout2(fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80024a6c:	4611                	li	a2,4
    80024a6e:	fc040593          	addi	a1,s0,-64
    80024a72:	fd843503          	ld	a0,-40(s0)
    80024a76:	0511                	addi	a0,a0,4
    80024a78:	ffffd097          	auipc	ra,0xffffd
    80024a7c:	a10080e7          	jalr	-1520(ra) # 80021488 <copyout2>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80024a80:	4781                	li	a5,0
  if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80024a82:	06055463          	bgez	a0,80024aea <sys_pipe+0xfe>
    p->ofile[fd0] = 0;
    80024a86:	fc442783          	lw	a5,-60(s0)
    80024a8a:	07e9                	addi	a5,a5,26
    80024a8c:	078e                	slli	a5,a5,0x3
    80024a8e:	97a6                	add	a5,a5,s1
    80024a90:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80024a94:	fc042783          	lw	a5,-64(s0)
    80024a98:	07e9                	addi	a5,a5,26
    80024a9a:	078e                	slli	a5,a5,0x3
    80024a9c:	94be                	add	s1,s1,a5
    80024a9e:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80024aa2:	fd043503          	ld	a0,-48(s0)
    80024aa6:	fffff097          	auipc	ra,0xfffff
    80024aaa:	ec0080e7          	jalr	-320(ra) # 80023966 <fileclose>
    fileclose(wf);
    80024aae:	fc843503          	ld	a0,-56(s0)
    80024ab2:	fffff097          	auipc	ra,0xfffff
    80024ab6:	eb4080e7          	jalr	-332(ra) # 80023966 <fileclose>
    return -1;
    80024aba:	57fd                	li	a5,-1
    80024abc:	a03d                	j	80024aea <sys_pipe+0xfe>
    if(fd0 >= 0)
    80024abe:	fc442783          	lw	a5,-60(s0)
    80024ac2:	0007c763          	bltz	a5,80024ad0 <sys_pipe+0xe4>
      p->ofile[fd0] = 0;
    80024ac6:	07e9                	addi	a5,a5,26
    80024ac8:	078e                	slli	a5,a5,0x3
    80024aca:	94be                	add	s1,s1,a5
    80024acc:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80024ad0:	fd043503          	ld	a0,-48(s0)
    80024ad4:	fffff097          	auipc	ra,0xfffff
    80024ad8:	e92080e7          	jalr	-366(ra) # 80023966 <fileclose>
    fileclose(wf);
    80024adc:	fc843503          	ld	a0,-56(s0)
    80024ae0:	fffff097          	auipc	ra,0xfffff
    80024ae4:	e86080e7          	jalr	-378(ra) # 80023966 <fileclose>
    return -1;
    80024ae8:	57fd                	li	a5,-1
}
    80024aea:	853e                	mv	a0,a5
    80024aec:	70e2                	ld	ra,56(sp)
    80024aee:	7442                	ld	s0,48(sp)
    80024af0:	74a2                	ld	s1,40(sp)
    80024af2:	6121                	addi	sp,sp,64
    80024af4:	8082                	ret

0000000080024af6 <sys_dev>:

// To open console device.
uint64
sys_dev(void)
{
    80024af6:	7179                	addi	sp,sp,-48
    80024af8:	f406                	sd	ra,40(sp)
    80024afa:	f022                	sd	s0,32(sp)
    80024afc:	ec26                	sd	s1,24(sp)
    80024afe:	1800                	addi	s0,sp,48
  int fd, omode;
  int major, minor;
  struct file *f;

  if(argint(0, &omode) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0){
    80024b00:	fdc40593          	addi	a1,s0,-36
    80024b04:	4501                	li	a0,0
    80024b06:	ffffe097          	auipc	ra,0xffffe
    80024b0a:	42c080e7          	jalr	1068(ra) # 80022f32 <argint>
    80024b0e:	08054a63          	bltz	a0,80024ba2 <sys_dev+0xac>
    80024b12:	fd840593          	addi	a1,s0,-40
    80024b16:	4505                	li	a0,1
    80024b18:	ffffe097          	auipc	ra,0xffffe
    80024b1c:	41a080e7          	jalr	1050(ra) # 80022f32 <argint>
    80024b20:	08054763          	bltz	a0,80024bae <sys_dev+0xb8>
    80024b24:	fd440593          	addi	a1,s0,-44
    80024b28:	4509                	li	a0,2
    80024b2a:	ffffe097          	auipc	ra,0xffffe
    80024b2e:	408080e7          	jalr	1032(ra) # 80022f32 <argint>
    80024b32:	08054063          	bltz	a0,80024bb2 <sys_dev+0xbc>
    return -1;
  }

  if(omode & O_CREATE){
    80024b36:	fdc42783          	lw	a5,-36(s0)
    80024b3a:	2007f793          	andi	a5,a5,512
    80024b3e:	ebb1                	bnez	a5,80024b92 <sys_dev+0x9c>
    panic("dev file on FAT");
  }

  if(major < 0 || major >= NDEV)
    80024b40:	fd842703          	lw	a4,-40(s0)
    80024b44:	47a5                	li	a5,9
    return -1;
    80024b46:	557d                	li	a0,-1
  if(major < 0 || major >= NDEV)
    80024b48:	04e7ee63          	bltu	a5,a4,80024ba4 <sys_dev+0xae>

  if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    80024b4c:	fffff097          	auipc	ra,0xfffff
    80024b50:	d4a080e7          	jalr	-694(ra) # 80023896 <filealloc>
    80024b54:	84aa                	mv	s1,a0
    80024b56:	c125                	beqz	a0,80024bb6 <sys_dev+0xc0>
    80024b58:	00000097          	auipc	ra,0x0
    80024b5c:	97e080e7          	jalr	-1666(ra) # 800244d6 <fdalloc>
    80024b60:	04054d63          	bltz	a0,80024bba <sys_dev+0xc4>
    if(f)
      fileclose(f);
    return -1;
  }

  f->type = FD_DEVICE;
    80024b64:	478d                	li	a5,3
    80024b66:	c09c                	sw	a5,0(s1)
  f->off = 0;
    80024b68:	0204a023          	sw	zero,32(s1)
  f->ep = 0;
    80024b6c:	0004bc23          	sd	zero,24(s1)
  f->major = major;
    80024b70:	fd842783          	lw	a5,-40(s0)
    80024b74:	02f49223          	sh	a5,36(s1)
  f->readable = !(omode & O_WRONLY);
    80024b78:	fdc42783          	lw	a5,-36(s0)
    80024b7c:	0017c713          	xori	a4,a5,1
    80024b80:	8b05                	andi	a4,a4,1
    80024b82:	00e48423          	sb	a4,8(s1)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80024b86:	8b8d                	andi	a5,a5,3
    80024b88:	00f037b3          	snez	a5,a5
    80024b8c:	00f484a3          	sb	a5,9(s1)

  return fd;
    80024b90:	a811                	j	80024ba4 <sys_dev+0xae>
    panic("dev file on FAT");
    80024b92:	00008517          	auipc	a0,0x8
    80024b96:	b3650513          	addi	a0,a0,-1226 # 8002c6c8 <sysnames+0x748>
    80024b9a:	ffffb097          	auipc	ra,0xffffb
    80024b9e:	5ac080e7          	jalr	1452(ra) # 80020146 <panic>
    return -1;
    80024ba2:	557d                	li	a0,-1
}
    80024ba4:	70a2                	ld	ra,40(sp)
    80024ba6:	7402                	ld	s0,32(sp)
    80024ba8:	64e2                	ld	s1,24(sp)
    80024baa:	6145                	addi	sp,sp,48
    80024bac:	8082                	ret
    return -1;
    80024bae:	557d                	li	a0,-1
    80024bb0:	bfd5                	j	80024ba4 <sys_dev+0xae>
    80024bb2:	557d                	li	a0,-1
    80024bb4:	bfc5                	j	80024ba4 <sys_dev+0xae>
    return -1;
    80024bb6:	557d                	li	a0,-1
    80024bb8:	b7f5                	j	80024ba4 <sys_dev+0xae>
      fileclose(f);
    80024bba:	8526                	mv	a0,s1
    80024bbc:	fffff097          	auipc	ra,0xfffff
    80024bc0:	daa080e7          	jalr	-598(ra) # 80023966 <fileclose>
    return -1;
    80024bc4:	557d                	li	a0,-1
    80024bc6:	bff9                	j	80024ba4 <sys_dev+0xae>

0000000080024bc8 <sys_readdir>:

// To support ls command
uint64
sys_readdir(void)
{
    80024bc8:	1101                	addi	sp,sp,-32
    80024bca:	ec06                	sd	ra,24(sp)
    80024bcc:	e822                	sd	s0,16(sp)
    80024bce:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024bd0:	fe840613          	addi	a2,s0,-24
    80024bd4:	4581                	li	a1,0
    80024bd6:	4501                	li	a0,0
    80024bd8:	00000097          	auipc	ra,0x0
    80024bdc:	896080e7          	jalr	-1898(ra) # 8002446e <argfd>
    return -1;
    80024be0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024be2:	02054563          	bltz	a0,80024c0c <sys_readdir+0x44>
    80024be6:	fe040593          	addi	a1,s0,-32
    80024bea:	4505                	li	a0,1
    80024bec:	ffffe097          	auipc	ra,0xffffe
    80024bf0:	3a8080e7          	jalr	936(ra) # 80022f94 <argaddr>
    return -1;
    80024bf4:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024bf6:	00054b63          	bltz	a0,80024c0c <sys_readdir+0x44>
  return dirnext(f, p);
    80024bfa:	fe043583          	ld	a1,-32(s0)
    80024bfe:	fe843503          	ld	a0,-24(s0)
    80024c02:	fffff097          	auipc	ra,0xfffff
    80024c06:	00e080e7          	jalr	14(ra) # 80023c10 <dirnext>
    80024c0a:	87aa                	mv	a5,a0
}
    80024c0c:	853e                	mv	a0,a5
    80024c0e:	60e2                	ld	ra,24(sp)
    80024c10:	6442                	ld	s0,16(sp)
    80024c12:	6105                	addi	sp,sp,32
    80024c14:	8082                	ret

0000000080024c16 <sys_getcwd>:

// get absolute cwd string
uint64
sys_getcwd(void)
{
    80024c16:	714d                	addi	sp,sp,-336
    80024c18:	e686                	sd	ra,328(sp)
    80024c1a:	e2a2                	sd	s0,320(sp)
    80024c1c:	fe26                	sd	s1,312(sp)
    80024c1e:	fa4a                	sd	s2,304(sp)
    80024c20:	f64e                	sd	s3,296(sp)
    80024c22:	f252                	sd	s4,288(sp)
    80024c24:	ee56                	sd	s5,280(sp)
    80024c26:	0a80                	addi	s0,sp,336
  uint64 addr;
  if (argaddr(0, &addr) < 0)
    80024c28:	fb840593          	addi	a1,s0,-72
    80024c2c:	4501                	li	a0,0
    80024c2e:	ffffe097          	auipc	ra,0xffffe
    80024c32:	366080e7          	jalr	870(ra) # 80022f94 <argaddr>
    return -1;
    80024c36:	57fd                	li	a5,-1
  if (argaddr(0, &addr) < 0)
    80024c38:	08054063          	bltz	a0,80024cb8 <sys_getcwd+0xa2>

  struct dirent *de = myproc()->cwd;
    80024c3c:	ffffd097          	auipc	ra,0xffffd
    80024c40:	f46080e7          	jalr	-186(ra) # 80021b82 <myproc>
    80024c44:	15853483          	ld	s1,344(a0)
  char path[FAT32_MAX_PATH];
  char *s;
  int len;

  if (de->parent == NULL) {
    80024c48:	1204b783          	ld	a5,288(s1)
    80024c4c:	c3c1                	beqz	a5,80024ccc <sys_getcwd+0xb6>
    s = "/";
  } else {
    s = path + FAT32_MAX_PATH - 1;
    *s = '\0';
    80024c4e:	fa0409a3          	sb	zero,-77(s0)
    s = path + FAT32_MAX_PATH - 1;
    80024c52:	fb340993          	addi	s3,s0,-77
    while (de->parent) {
      len = strlen(de->filename);
      s -= len;
      if (s <= path)          // can't reach root "/"
    80024c56:	eb040a13          	addi	s4,s0,-336
        return -1;
      strncpy(s, de->filename, len);
      *--s = '/';
    80024c5a:	02f00a93          	li	s5,47
      len = strlen(de->filename);
    80024c5e:	8526                	mv	a0,s1
    80024c60:	ffffc097          	auipc	ra,0xffffc
    80024c64:	ca6080e7          	jalr	-858(ra) # 80020906 <strlen>
      s -= len;
    80024c68:	40a98933          	sub	s2,s3,a0
      if (s <= path)          // can't reach root "/"
    80024c6c:	072a7563          	bgeu	s4,s2,80024cd6 <sys_getcwd+0xc0>
      strncpy(s, de->filename, len);
    80024c70:	862a                	mv	a2,a0
    80024c72:	85a6                	mv	a1,s1
    80024c74:	854a                	mv	a0,s2
    80024c76:	ffffc097          	auipc	ra,0xffffc
    80024c7a:	c1e080e7          	jalr	-994(ra) # 80020894 <strncpy>
      *--s = '/';
    80024c7e:	fff90993          	addi	s3,s2,-1
    80024c82:	ff590fa3          	sb	s5,-1(s2)
      de = de->parent;
    80024c86:	1204b483          	ld	s1,288(s1)
    while (de->parent) {
    80024c8a:	1204b783          	ld	a5,288(s1)
    80024c8e:	fbe1                	bnez	a5,80024c5e <sys_getcwd+0x48>
    }
  }

  // if (copyout(myproc()->pagetable, addr, s, strlen(s) + 1) < 0)
  if (copyout2(addr, s, strlen(s) + 1) < 0)
    80024c90:	fb843483          	ld	s1,-72(s0)
    80024c94:	854e                	mv	a0,s3
    80024c96:	ffffc097          	auipc	ra,0xffffc
    80024c9a:	c70080e7          	jalr	-912(ra) # 80020906 <strlen>
    80024c9e:	0015061b          	addiw	a2,a0,1
    80024ca2:	85ce                	mv	a1,s3
    80024ca4:	8526                	mv	a0,s1
    80024ca6:	ffffc097          	auipc	ra,0xffffc
    80024caa:	7e2080e7          	jalr	2018(ra) # 80021488 <copyout2>
    return NULL;
    80024cae:	4781                	li	a5,0
  if (copyout2(addr, s, strlen(s) + 1) < 0)
    80024cb0:	00054463          	bltz	a0,80024cb8 <sys_getcwd+0xa2>
  
  return addr;
    80024cb4:	fb843783          	ld	a5,-72(s0)

}
    80024cb8:	853e                	mv	a0,a5
    80024cba:	60b6                	ld	ra,328(sp)
    80024cbc:	6416                	ld	s0,320(sp)
    80024cbe:	74f2                	ld	s1,312(sp)
    80024cc0:	7952                	ld	s2,304(sp)
    80024cc2:	79b2                	ld	s3,296(sp)
    80024cc4:	7a12                	ld	s4,288(sp)
    80024cc6:	6af2                	ld	s5,280(sp)
    80024cc8:	6171                	addi	sp,sp,336
    80024cca:	8082                	ret
    s = "/";
    80024ccc:	00007997          	auipc	s3,0x7
    80024cd0:	89498993          	addi	s3,s3,-1900 # 8002b560 <states.1738+0xf8>
    80024cd4:	bf75                	j	80024c90 <sys_getcwd+0x7a>
        return -1;
    80024cd6:	57fd                	li	a5,-1
    80024cd8:	b7c5                	j	80024cb8 <sys_getcwd+0xa2>

0000000080024cda <sys_remove>:
  return ret == -1;
}

uint64
sys_remove(void)
{
    80024cda:	d6010113          	addi	sp,sp,-672
    80024cde:	28113c23          	sd	ra,664(sp)
    80024ce2:	28813823          	sd	s0,656(sp)
    80024ce6:	28913423          	sd	s1,648(sp)
    80024cea:	1500                	addi	s0,sp,672
  char path[FAT32_MAX_PATH];
  struct dirent *ep;
  int len;
  if((len = argstr(0, path, FAT32_MAX_PATH)) <= 0)
    80024cec:	10400613          	li	a2,260
    80024cf0:	ed840593          	addi	a1,s0,-296
    80024cf4:	4501                	li	a0,0
    80024cf6:	ffffe097          	auipc	ra,0xffffe
    80024cfa:	2c0080e7          	jalr	704(ra) # 80022fb6 <argstr>
    80024cfe:	0ea05f63          	blez	a0,80024dfc <sys_remove+0x122>
    return -1;

  char *s = path + len - 1;
    80024d02:	ed840793          	addi	a5,s0,-296
    80024d06:	157d                	addi	a0,a0,-1
    80024d08:	953e                	add	a0,a0,a5
  while (s >= path && *s == '/') {
    80024d0a:	02f56c63          	bltu	a0,a5,80024d42 <sys_remove+0x68>
    80024d0e:	00054703          	lbu	a4,0(a0)
    80024d12:	02f00793          	li	a5,47
    80024d16:	02f71063          	bne	a4,a5,80024d36 <sys_remove+0x5c>
    80024d1a:	fff50793          	addi	a5,a0,-1
    80024d1e:	ed740693          	addi	a3,s0,-297
    80024d22:	02f00613          	li	a2,47
    s--;
    80024d26:	853e                	mv	a0,a5
  while (s >= path && *s == '/') {
    80024d28:	00d78d63          	beq	a5,a3,80024d42 <sys_remove+0x68>
    80024d2c:	17fd                	addi	a5,a5,-1
    80024d2e:	0017c703          	lbu	a4,1(a5)
    80024d32:	fec70ae3          	beq	a4,a2,80024d26 <sys_remove+0x4c>
  }
  if (s >= path && *s == '.' && (s == path || *--s == '/')) {
    80024d36:	00054703          	lbu	a4,0(a0)
    80024d3a:	02e00793          	li	a5,46
    80024d3e:	08f70763          	beq	a4,a5,80024dcc <sys_remove+0xf2>
    return -1;
  }
  
  if((ep = ename(path)) == NULL){
    80024d42:	ed840513          	addi	a0,s0,-296
    80024d46:	00002097          	auipc	ra,0x2
    80024d4a:	d8c080e7          	jalr	-628(ra) # 80026ad2 <ename>
    80024d4e:	84aa                	mv	s1,a0
    80024d50:	c955                	beqz	a0,80024e04 <sys_remove+0x12a>
    return -1;
  }
  elock(ep);
    80024d52:	00001097          	auipc	ra,0x1
    80024d56:	5da080e7          	jalr	1498(ra) # 8002632c <elock>
  if((ep->attribute & ATTR_DIRECTORY) && !isdirempty(ep)){
    80024d5a:	1004c783          	lbu	a5,256(s1)
    80024d5e:	8bc1                	andi	a5,a5,16
    80024d60:	c38d                	beqz	a5,80024d82 <sys_remove+0xa8>
  ep.valid = 0;
    80024d62:	e8041323          	sh	zero,-378(s0)
  ret = enext(dp, &ep, 2 * 32, &count);   // skip the "." and ".."
    80024d66:	d6c40693          	addi	a3,s0,-660
    80024d6a:	04000613          	li	a2,64
    80024d6e:	d7040593          	addi	a1,s0,-656
    80024d72:	8526                	mv	a0,s1
    80024d74:	00001097          	auipc	ra,0x1
    80024d78:	7bc080e7          	jalr	1980(ra) # 80026530 <enext>
  if((ep->attribute & ATTR_DIRECTORY) && !isdirempty(ep)){
    80024d7c:	57fd                	li	a5,-1
    80024d7e:	06f51363          	bne	a0,a5,80024de4 <sys_remove+0x10a>
      eunlock(ep);
      eput(ep);
      return -1;
  }
  elock(ep->parent);      // Will this lead to deadlock?
    80024d82:	1204b503          	ld	a0,288(s1)
    80024d86:	00001097          	auipc	ra,0x1
    80024d8a:	5a6080e7          	jalr	1446(ra) # 8002632c <elock>
  eremove(ep);
    80024d8e:	8526                	mv	a0,s1
    80024d90:	00001097          	auipc	ra,0x1
    80024d94:	470080e7          	jalr	1136(ra) # 80026200 <eremove>
  eunlock(ep->parent);
    80024d98:	1204b503          	ld	a0,288(s1)
    80024d9c:	00001097          	auipc	ra,0x1
    80024da0:	5c6080e7          	jalr	1478(ra) # 80026362 <eunlock>
  eunlock(ep);
    80024da4:	8526                	mv	a0,s1
    80024da6:	00001097          	auipc	ra,0x1
    80024daa:	5bc080e7          	jalr	1468(ra) # 80026362 <eunlock>
  eput(ep);
    80024dae:	8526                	mv	a0,s1
    80024db0:	00001097          	auipc	ra,0x1
    80024db4:	600080e7          	jalr	1536(ra) # 800263b0 <eput>

  return 0;
    80024db8:	4501                	li	a0,0
}
    80024dba:	29813083          	ld	ra,664(sp)
    80024dbe:	29013403          	ld	s0,656(sp)
    80024dc2:	28813483          	ld	s1,648(sp)
    80024dc6:	2a010113          	addi	sp,sp,672
    80024dca:	8082                	ret
  if (s >= path && *s == '.' && (s == path || *--s == '/')) {
    80024dcc:	ed840793          	addi	a5,s0,-296
    80024dd0:	02f50863          	beq	a0,a5,80024e00 <sys_remove+0x126>
    80024dd4:	fff54703          	lbu	a4,-1(a0)
    80024dd8:	02f00793          	li	a5,47
    80024ddc:	f6f713e3          	bne	a4,a5,80024d42 <sys_remove+0x68>
    return -1;
    80024de0:	557d                	li	a0,-1
    80024de2:	bfe1                	j	80024dba <sys_remove+0xe0>
      eunlock(ep);
    80024de4:	8526                	mv	a0,s1
    80024de6:	00001097          	auipc	ra,0x1
    80024dea:	57c080e7          	jalr	1404(ra) # 80026362 <eunlock>
      eput(ep);
    80024dee:	8526                	mv	a0,s1
    80024df0:	00001097          	auipc	ra,0x1
    80024df4:	5c0080e7          	jalr	1472(ra) # 800263b0 <eput>
      return -1;
    80024df8:	557d                	li	a0,-1
    80024dfa:	b7c1                	j	80024dba <sys_remove+0xe0>
    return -1;
    80024dfc:	557d                	li	a0,-1
    80024dfe:	bf75                	j	80024dba <sys_remove+0xe0>
    return -1;
    80024e00:	557d                	li	a0,-1
    80024e02:	bf65                	j	80024dba <sys_remove+0xe0>
    return -1;
    80024e04:	557d                	li	a0,-1
    80024e06:	bf55                	j	80024dba <sys_remove+0xe0>

0000000080024e08 <sys_rename>:

// Must hold too many locks at a time! It's possible to raise a deadlock.
// Because this op takes some steps, we can't promise
uint64
sys_rename(void)
{
    80024e08:	c4010113          	addi	sp,sp,-960
    80024e0c:	3a113c23          	sd	ra,952(sp)
    80024e10:	3a813823          	sd	s0,944(sp)
    80024e14:	3a913423          	sd	s1,936(sp)
    80024e18:	3b213023          	sd	s2,928(sp)
    80024e1c:	39313c23          	sd	s3,920(sp)
    80024e20:	39413823          	sd	s4,912(sp)
    80024e24:	0780                	addi	s0,sp,960
  char old[FAT32_MAX_PATH], new[FAT32_MAX_PATH];
  if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024e26:	10400613          	li	a2,260
    80024e2a:	ec840593          	addi	a1,s0,-312
    80024e2e:	4501                	li	a0,0
    80024e30:	ffffe097          	auipc	ra,0xffffe
    80024e34:	186080e7          	jalr	390(ra) # 80022fb6 <argstr>
      return -1;
    80024e38:	57fd                	li	a5,-1
  if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024e3a:	0c054d63          	bltz	a0,80024f14 <sys_rename+0x10c>
    80024e3e:	10400613          	li	a2,260
    80024e42:	dc040593          	addi	a1,s0,-576
    80024e46:	4505                	li	a0,1
    80024e48:	ffffe097          	auipc	ra,0xffffe
    80024e4c:	16e080e7          	jalr	366(ra) # 80022fb6 <argstr>
      return -1;
    80024e50:	57fd                	li	a5,-1
  if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024e52:	0c054163          	bltz	a0,80024f14 <sys_rename+0x10c>
  }

  struct dirent *src = NULL, *dst = NULL, *pdst = NULL;
  int srclock = 0;
  char *name;
  if ((src = ename(old)) == NULL || (pdst = enameparent(new, old)) == NULL
    80024e56:	ec840513          	addi	a0,s0,-312
    80024e5a:	00002097          	auipc	ra,0x2
    80024e5e:	c78080e7          	jalr	-904(ra) # 80026ad2 <ename>
    80024e62:	84aa                	mv	s1,a0
    80024e64:	1c050963          	beqz	a0,80025036 <sys_rename+0x22e>
    80024e68:	ec840593          	addi	a1,s0,-312
    80024e6c:	dc040513          	addi	a0,s0,-576
    80024e70:	00002097          	auipc	ra,0x2
    80024e74:	c80080e7          	jalr	-896(ra) # 80026af0 <enameparent>
    80024e78:	892a                	mv	s2,a0
    80024e7a:	cd35                	beqz	a0,80024ef6 <sys_rename+0xee>
      || (name = formatname(old)) == NULL) {
    80024e7c:	ec840513          	addi	a0,s0,-312
    80024e80:	00001097          	auipc	ra,0x1
    80024e84:	e00080e7          	jalr	-512(ra) # 80025c80 <formatname>
    80024e88:	8a2a                	mv	s4,a0
    80024e8a:	c535                	beqz	a0,80024ef6 <sys_rename+0xee>
    goto fail;          // src doesn't exist || dst parent doesn't exist || illegal new name
  }
  for (struct dirent *ep = pdst; ep != NULL; ep = ep->parent) {
    if (ep == src) {    // In what universe can we move a directory into its child?
    80024e8c:	07248563          	beq	s1,s2,80024ef6 <sys_rename+0xee>
  for (struct dirent *ep = pdst; ep != NULL; ep = ep->parent) {
    80024e90:	87ca                	mv	a5,s2
    80024e92:	1207b783          	ld	a5,288(a5)
    80024e96:	c781                	beqz	a5,80024e9e <sys_rename+0x96>
    if (ep == src) {    // In what universe can we move a directory into its child?
    80024e98:	fef49de3          	bne	s1,a5,80024e92 <sys_rename+0x8a>
    80024e9c:	a8a9                	j	80024ef6 <sys_rename+0xee>
      goto fail;
    }
  }

  uint off;
  elock(src);     // must hold child's lock before acquiring parent's, because we do so in other similar cases
    80024e9e:	8526                	mv	a0,s1
    80024ea0:	00001097          	auipc	ra,0x1
    80024ea4:	48c080e7          	jalr	1164(ra) # 8002632c <elock>
  srclock = 1;
  elock(pdst);
    80024ea8:	854a                	mv	a0,s2
    80024eaa:	00001097          	auipc	ra,0x1
    80024eae:	482080e7          	jalr	1154(ra) # 8002632c <elock>
  dst = dirlookup(pdst, name, &off);
    80024eb2:	dbc40613          	addi	a2,s0,-580
    80024eb6:	85d2                	mv	a1,s4
    80024eb8:	854a                	mv	a0,s2
    80024eba:	00002097          	auipc	ra,0x2
    80024ebe:	802080e7          	jalr	-2046(ra) # 800266bc <dirlookup>
    80024ec2:	89aa                	mv	s3,a0
  if (dst != NULL) {
    80024ec4:	cd45                	beqz	a0,80024f7c <sys_rename+0x174>
    eunlock(pdst);
    80024ec6:	854a                	mv	a0,s2
    80024ec8:	00001097          	auipc	ra,0x1
    80024ecc:	49a080e7          	jalr	1178(ra) # 80026362 <eunlock>
    if (src == dst) {
    80024ed0:	01348963          	beq	s1,s3,80024ee2 <sys_rename+0xda>
      goto fail;
    } else if (src->attribute & dst->attribute & ATTR_DIRECTORY) {
    80024ed4:	1004c783          	lbu	a5,256(s1)
    80024ed8:	1009c703          	lbu	a4,256(s3)
    80024edc:	8ff9                	and	a5,a5,a4
    80024ede:	8bc1                	andi	a5,a5,16
    80024ee0:	ebb1                	bnez	a5,80024f34 <sys_rename+0x12c>

  return 0;

fail:
  if (srclock)
    eunlock(src);
    80024ee2:	8526                	mv	a0,s1
    80024ee4:	00001097          	auipc	ra,0x1
    80024ee8:	47e080e7          	jalr	1150(ra) # 80026362 <eunlock>
  if (dst)
    eput(dst);
    80024eec:	854e                	mv	a0,s3
    80024eee:	00001097          	auipc	ra,0x1
    80024ef2:	4c2080e7          	jalr	1218(ra) # 800263b0 <eput>
  if (pdst)
    80024ef6:	00090763          	beqz	s2,80024f04 <sys_rename+0xfc>
    eput(pdst);
    80024efa:	854a                	mv	a0,s2
    80024efc:	00001097          	auipc	ra,0x1
    80024f00:	4b4080e7          	jalr	1204(ra) # 800263b0 <eput>
  if (src)
    eput(src);
  return -1;
    80024f04:	57fd                	li	a5,-1
  if (src)
    80024f06:	c499                	beqz	s1,80024f14 <sys_rename+0x10c>
    eput(src);
    80024f08:	8526                	mv	a0,s1
    80024f0a:	00001097          	auipc	ra,0x1
    80024f0e:	4a6080e7          	jalr	1190(ra) # 800263b0 <eput>
  return -1;
    80024f12:	57fd                	li	a5,-1
}
    80024f14:	853e                	mv	a0,a5
    80024f16:	3b813083          	ld	ra,952(sp)
    80024f1a:	3b013403          	ld	s0,944(sp)
    80024f1e:	3a813483          	ld	s1,936(sp)
    80024f22:	3a013903          	ld	s2,928(sp)
    80024f26:	39813983          	ld	s3,920(sp)
    80024f2a:	39013a03          	ld	s4,912(sp)
    80024f2e:	3c010113          	addi	sp,sp,960
    80024f32:	8082                	ret
      elock(dst);
    80024f34:	854e                	mv	a0,s3
    80024f36:	00001097          	auipc	ra,0x1
    80024f3a:	3f6080e7          	jalr	1014(ra) # 8002632c <elock>
  ep.valid = 0;
    80024f3e:	d6041323          	sh	zero,-666(s0)
  ret = enext(dp, &ep, 2 * 32, &count);   // skip the "." and ".."
    80024f42:	c4c40693          	addi	a3,s0,-948
    80024f46:	04000613          	li	a2,64
    80024f4a:	c5040593          	addi	a1,s0,-944
    80024f4e:	854e                	mv	a0,s3
    80024f50:	00001097          	auipc	ra,0x1
    80024f54:	5e0080e7          	jalr	1504(ra) # 80026530 <enext>
      if (!isdirempty(dst)) {    // it's ok to overwrite an empty dir
    80024f58:	57fd                	li	a5,-1
    80024f5a:	0cf51863          	bne	a0,a5,8002502a <sys_rename+0x222>
      elock(pdst);
    80024f5e:	854a                	mv	a0,s2
    80024f60:	00001097          	auipc	ra,0x1
    80024f64:	3cc080e7          	jalr	972(ra) # 8002632c <elock>
    eremove(dst);
    80024f68:	854e                	mv	a0,s3
    80024f6a:	00001097          	auipc	ra,0x1
    80024f6e:	296080e7          	jalr	662(ra) # 80026200 <eremove>
    eunlock(dst);
    80024f72:	854e                	mv	a0,s3
    80024f74:	00001097          	auipc	ra,0x1
    80024f78:	3ee080e7          	jalr	1006(ra) # 80026362 <eunlock>
  memmove(src->filename, name, FAT32_MAX_FILENAME);
    80024f7c:	0ff00613          	li	a2,255
    80024f80:	85d2                	mv	a1,s4
    80024f82:	8526                	mv	a0,s1
    80024f84:	ffffc097          	auipc	ra,0xffffc
    80024f88:	844080e7          	jalr	-1980(ra) # 800207c8 <memmove>
  emake(pdst, src, off);
    80024f8c:	dbc42603          	lw	a2,-580(s0)
    80024f90:	85a6                	mv	a1,s1
    80024f92:	854a                	mv	a0,s2
    80024f94:	00001097          	auipc	ra,0x1
    80024f98:	dac080e7          	jalr	-596(ra) # 80025d40 <emake>
  if (src->parent != pdst) {
    80024f9c:	1204b783          	ld	a5,288(s1)
    80024fa0:	01278d63          	beq	a5,s2,80024fba <sys_rename+0x1b2>
    eunlock(pdst);
    80024fa4:	854a                	mv	a0,s2
    80024fa6:	00001097          	auipc	ra,0x1
    80024faa:	3bc080e7          	jalr	956(ra) # 80026362 <eunlock>
    elock(src->parent);
    80024fae:	1204b503          	ld	a0,288(s1)
    80024fb2:	00001097          	auipc	ra,0x1
    80024fb6:	37a080e7          	jalr	890(ra) # 8002632c <elock>
  eremove(src);
    80024fba:	8526                	mv	a0,s1
    80024fbc:	00001097          	auipc	ra,0x1
    80024fc0:	244080e7          	jalr	580(ra) # 80026200 <eremove>
  eunlock(src->parent);
    80024fc4:	1204b503          	ld	a0,288(s1)
    80024fc8:	00001097          	auipc	ra,0x1
    80024fcc:	39a080e7          	jalr	922(ra) # 80026362 <eunlock>
  struct dirent *psrc = src->parent;  // src must not be root, or it won't pass the for-loop test
    80024fd0:	1204ba03          	ld	s4,288(s1)
  src->parent = edup(pdst);
    80024fd4:	854a                	mv	a0,s2
    80024fd6:	00001097          	auipc	ra,0x1
    80024fda:	106080e7          	jalr	262(ra) # 800260dc <edup>
    80024fde:	12a4b023          	sd	a0,288(s1)
  src->off = off;
    80024fe2:	dbc42783          	lw	a5,-580(s0)
    80024fe6:	10f4ae23          	sw	a5,284(s1)
  src->valid = 1;
    80024fea:	4785                	li	a5,1
    80024fec:	10f49b23          	sh	a5,278(s1)
  eunlock(src);
    80024ff0:	8526                	mv	a0,s1
    80024ff2:	00001097          	auipc	ra,0x1
    80024ff6:	370080e7          	jalr	880(ra) # 80026362 <eunlock>
  eput(psrc);
    80024ffa:	8552                	mv	a0,s4
    80024ffc:	00001097          	auipc	ra,0x1
    80025000:	3b4080e7          	jalr	948(ra) # 800263b0 <eput>
  if (dst) {
    80025004:	00098763          	beqz	s3,80025012 <sys_rename+0x20a>
    eput(dst);
    80025008:	854e                	mv	a0,s3
    8002500a:	00001097          	auipc	ra,0x1
    8002500e:	3a6080e7          	jalr	934(ra) # 800263b0 <eput>
  eput(pdst);
    80025012:	854a                	mv	a0,s2
    80025014:	00001097          	auipc	ra,0x1
    80025018:	39c080e7          	jalr	924(ra) # 800263b0 <eput>
  eput(src);
    8002501c:	8526                	mv	a0,s1
    8002501e:	00001097          	auipc	ra,0x1
    80025022:	392080e7          	jalr	914(ra) # 800263b0 <eput>
  return 0;
    80025026:	4781                	li	a5,0
    80025028:	b5f5                	j	80024f14 <sys_rename+0x10c>
        eunlock(dst);
    8002502a:	854e                	mv	a0,s3
    8002502c:	00001097          	auipc	ra,0x1
    80025030:	336080e7          	jalr	822(ra) # 80026362 <eunlock>
        goto fail;
    80025034:	b57d                	j	80024ee2 <sys_rename+0xda>
  struct dirent *src = NULL, *dst = NULL, *pdst = NULL;
    80025036:	892a                	mv	s2,a0
  if (dst)
    80025038:	bd7d                	j	80024ef6 <sys_rename+0xee>
    8002503a:	0000                	unimp
    8002503c:	0000                	unimp
	...

0000000080025040 <kernelvec>:
    80025040:	7111                	addi	sp,sp,-256
    80025042:	e006                	sd	ra,0(sp)
    80025044:	e40a                	sd	sp,8(sp)
    80025046:	e80e                	sd	gp,16(sp)
    80025048:	ec12                	sd	tp,24(sp)
    8002504a:	f016                	sd	t0,32(sp)
    8002504c:	f41a                	sd	t1,40(sp)
    8002504e:	f81e                	sd	t2,48(sp)
    80025050:	fc22                	sd	s0,56(sp)
    80025052:	e0a6                	sd	s1,64(sp)
    80025054:	e4aa                	sd	a0,72(sp)
    80025056:	e8ae                	sd	a1,80(sp)
    80025058:	ecb2                	sd	a2,88(sp)
    8002505a:	f0b6                	sd	a3,96(sp)
    8002505c:	f4ba                	sd	a4,104(sp)
    8002505e:	f8be                	sd	a5,112(sp)
    80025060:	fcc2                	sd	a6,120(sp)
    80025062:	e146                	sd	a7,128(sp)
    80025064:	e54a                	sd	s2,136(sp)
    80025066:	e94e                	sd	s3,144(sp)
    80025068:	ed52                	sd	s4,152(sp)
    8002506a:	f156                	sd	s5,160(sp)
    8002506c:	f55a                	sd	s6,168(sp)
    8002506e:	f95e                	sd	s7,176(sp)
    80025070:	fd62                	sd	s8,184(sp)
    80025072:	e1e6                	sd	s9,192(sp)
    80025074:	e5ea                	sd	s10,200(sp)
    80025076:	e9ee                	sd	s11,208(sp)
    80025078:	edf2                	sd	t3,216(sp)
    8002507a:	f1f6                	sd	t4,224(sp)
    8002507c:	f5fa                	sd	t5,232(sp)
    8002507e:	f9fe                	sd	t6,240(sp)
    80025080:	a35fd0ef          	jal	ra,80022ab4 <kerneltrap>
    80025084:	6082                	ld	ra,0(sp)
    80025086:	6122                	ld	sp,8(sp)
    80025088:	61c2                	ld	gp,16(sp)
    8002508a:	7282                	ld	t0,32(sp)
    8002508c:	7322                	ld	t1,40(sp)
    8002508e:	73c2                	ld	t2,48(sp)
    80025090:	7462                	ld	s0,56(sp)
    80025092:	6486                	ld	s1,64(sp)
    80025094:	6526                	ld	a0,72(sp)
    80025096:	65c6                	ld	a1,80(sp)
    80025098:	6666                	ld	a2,88(sp)
    8002509a:	7686                	ld	a3,96(sp)
    8002509c:	7726                	ld	a4,104(sp)
    8002509e:	77c6                	ld	a5,112(sp)
    800250a0:	7866                	ld	a6,120(sp)
    800250a2:	688a                	ld	a7,128(sp)
    800250a4:	692a                	ld	s2,136(sp)
    800250a6:	69ca                	ld	s3,144(sp)
    800250a8:	6a6a                	ld	s4,152(sp)
    800250aa:	7a8a                	ld	s5,160(sp)
    800250ac:	7b2a                	ld	s6,168(sp)
    800250ae:	7bca                	ld	s7,176(sp)
    800250b0:	7c6a                	ld	s8,184(sp)
    800250b2:	6c8e                	ld	s9,192(sp)
    800250b4:	6d2e                	ld	s10,200(sp)
    800250b6:	6dce                	ld	s11,208(sp)
    800250b8:	6e6e                	ld	t3,216(sp)
    800250ba:	7e8e                	ld	t4,224(sp)
    800250bc:	7f2e                	ld	t5,232(sp)
    800250be:	7fce                	ld	t6,240(sp)
    800250c0:	6111                	addi	sp,sp,256
    800250c2:	10200073          	sret
	...

00000000800250ce <timerinit>:
#include "include/proc.h"

struct spinlock tickslock;
uint ticks;

void timerinit() {
    800250ce:	1141                	addi	sp,sp,-16
    800250d0:	e406                	sd	ra,8(sp)
    800250d2:	e022                	sd	s0,0(sp)
    800250d4:	0800                	addi	s0,sp,16
    initlock(&tickslock, "time");
    800250d6:	00007597          	auipc	a1,0x7
    800250da:	60258593          	addi	a1,a1,1538 # 8002c6d8 <sysnames+0x758>
    800250de:	0001c517          	auipc	a0,0x1c
    800250e2:	32a50513          	addi	a0,a0,810 # 80041408 <tickslock>
    800250e6:	ffffb097          	auipc	ra,0xffffb
    800250ea:	596080e7          	jalr	1430(ra) # 8002067c <initlock>
    #ifdef DEBUG
    printf("timerinit\n");
    #endif
}
    800250ee:	60a2                	ld	ra,8(sp)
    800250f0:	6402                	ld	s0,0(sp)
    800250f2:	0141                	addi	sp,sp,16
    800250f4:	8082                	ret

00000000800250f6 <set_next_timeout>:

void
set_next_timeout() {
    800250f6:	1141                	addi	sp,sp,-16
    800250f8:	e422                	sd	s0,8(sp)
    800250fa:	0800                	addi	s0,sp,16
  asm volatile("rdtime %0" : "=r" (x) );
    800250fc:	c0102573          	rdtime	a0
    // if comment the `printf` line below
    // the timer will not work.

    // this bug seems to disappear automatically
    // printf("");
    sbi_set_timer(r_time() + INTERVAL);
    80025100:	001dc7b7          	lui	a5,0x1dc
    80025104:	13078793          	addi	a5,a5,304 # 1dc130 <BASE_ADDRESS-0x7fe43ed0>
    80025108:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
    8002510a:	4581                	li	a1,0
    8002510c:	4601                	li	a2,0
    8002510e:	4681                	li	a3,0
    80025110:	4881                	li	a7,0
    80025112:	00000073          	ecall
}
    80025116:	6422                	ld	s0,8(sp)
    80025118:	0141                	addi	sp,sp,16
    8002511a:	8082                	ret

000000008002511c <timer_tick>:

void timer_tick() {
    8002511c:	1101                	addi	sp,sp,-32
    8002511e:	ec06                	sd	ra,24(sp)
    80025120:	e822                	sd	s0,16(sp)
    80025122:	e426                	sd	s1,8(sp)
    80025124:	1000                	addi	s0,sp,32
    acquire(&tickslock);
    80025126:	0001c497          	auipc	s1,0x1c
    8002512a:	2e248493          	addi	s1,s1,738 # 80041408 <tickslock>
    8002512e:	8526                	mv	a0,s1
    80025130:	ffffb097          	auipc	ra,0xffffb
    80025134:	590080e7          	jalr	1424(ra) # 800206c0 <acquire>
    ticks++;
    80025138:	0001c517          	auipc	a0,0x1c
    8002513c:	2e850513          	addi	a0,a0,744 # 80041420 <ticks>
    80025140:	411c                	lw	a5,0(a0)
    80025142:	2785                	addiw	a5,a5,1
    80025144:	c11c                	sw	a5,0(a0)
    wakeup(&ticks);
    80025146:	ffffd097          	auipc	ra,0xffffd
    8002514a:	440080e7          	jalr	1088(ra) # 80022586 <wakeup>
    release(&tickslock);
    8002514e:	8526                	mv	a0,s1
    80025150:	ffffb097          	auipc	ra,0xffffb
    80025154:	5c4080e7          	jalr	1476(ra) # 80020714 <release>
    set_next_timeout();
    80025158:	00000097          	auipc	ra,0x0
    8002515c:	f9e080e7          	jalr	-98(ra) # 800250f6 <set_next_timeout>
}
    80025160:	60e2                	ld	ra,24(sp)
    80025162:	6442                	ld	s0,16(sp)
    80025164:	64a2                	ld	s1,8(sp)
    80025166:	6105                	addi	sp,sp,32
    80025168:	8082                	ret

000000008002516a <disk_init>:
#else
#include "include/virtio.h"
#endif 

void disk_init(void)
{
    8002516a:	1141                	addi	sp,sp,-16
    8002516c:	e406                	sd	ra,8(sp)
    8002516e:	e022                	sd	s0,0(sp)
    80025170:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_init();
	#else 
	sdcard_init();
    80025172:	00003097          	auipc	ra,0x3
    80025176:	f54080e7          	jalr	-172(ra) # 800280c6 <sdcard_init>
    #endif
}
    8002517a:	60a2                	ld	ra,8(sp)
    8002517c:	6402                	ld	s0,0(sp)
    8002517e:	0141                	addi	sp,sp,16
    80025180:	8082                	ret

0000000080025182 <disk_read>:

void disk_read(struct buf *b)
{
    80025182:	1141                	addi	sp,sp,-16
    80025184:	e406                	sd	ra,8(sp)
    80025186:	e022                	sd	s0,0(sp)
    80025188:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 0);
    #else 
	sdcard_read_sector(b->data, b->sectorno);
    8002518a:	454c                	lw	a1,12(a0)
    8002518c:	05850513          	addi	a0,a0,88
    80025190:	00003097          	auipc	ra,0x3
    80025194:	278080e7          	jalr	632(ra) # 80028408 <sdcard_read_sector>
	#endif
}
    80025198:	60a2                	ld	ra,8(sp)
    8002519a:	6402                	ld	s0,0(sp)
    8002519c:	0141                	addi	sp,sp,16
    8002519e:	8082                	ret

00000000800251a0 <disk_write>:

void disk_write(struct buf *b)
{
    800251a0:	1141                	addi	sp,sp,-16
    800251a2:	e406                	sd	ra,8(sp)
    800251a4:	e022                	sd	s0,0(sp)
    800251a6:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 1);
    #else 
	sdcard_write_sector(b->data, b->sectorno);
    800251a8:	454c                	lw	a1,12(a0)
    800251aa:	05850513          	addi	a0,a0,88
    800251ae:	00003097          	auipc	ra,0x3
    800251b2:	35e080e7          	jalr	862(ra) # 8002850c <sdcard_write_sector>
	#endif
}
    800251b6:	60a2                	ld	ra,8(sp)
    800251b8:	6402                	ld	s0,0(sp)
    800251ba:	0141                	addi	sp,sp,16
    800251bc:	8082                	ret

00000000800251be <disk_intr>:

void disk_intr(void)
{
    800251be:	1141                	addi	sp,sp,-16
    800251c0:	e406                	sd	ra,8(sp)
    800251c2:	e022                	sd	s0,0(sp)
    800251c4:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_intr();
    #else 
    dmac_intr(DMAC_CHANNEL0);
    800251c6:	4501                	li	a0,0
    800251c8:	00004097          	auipc	ra,0x4
    800251cc:	ae6080e7          	jalr	-1306(ra) # 80028cae <dmac_intr>
    #endif
}
    800251d0:	60a2                	ld	ra,8(sp)
    800251d2:	6402                	ld	s0,0(sp)
    800251d4:	0141                	addi	sp,sp,16
    800251d6:	8082                	ret

00000000800251d8 <read_fat>:
/**
 * Read the FAT table content corresponded to the given cluster number.
 * @param   cluster     the number of cluster which you want to read its content in FAT table
 */
static uint32 read_fat(uint32 cluster)
{
    800251d8:	1101                	addi	sp,sp,-32
    800251da:	ec06                	sd	ra,24(sp)
    800251dc:	e822                	sd	s0,16(sp)
    800251de:	e426                	sd	s1,8(sp)
    800251e0:	e04a                	sd	s2,0(sp)
    800251e2:	1000                	addi	s0,sp,32
    if (cluster >= FAT32_EOC) {
    800251e4:	100007b7          	lui	a5,0x10000
    800251e8:	17dd                	addi	a5,a5,-9
        return cluster;
    800251ea:	84aa                	mv	s1,a0
    if (cluster >= FAT32_EOC) {
    800251ec:	00a7eb63          	bltu	a5,a0,80025202 <read_fat+0x2a>
    }
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    800251f0:	0001c797          	auipc	a5,0x1c
    800251f4:	23878793          	addi	a5,a5,568 # 80041428 <fat>
    800251f8:	479c                	lw	a5,8(a5)
    800251fa:	2785                	addiw	a5,a5,1
        return 0;
    800251fc:	4481                	li	s1,0
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    800251fe:	00a7f963          	bgeu	a5,a0,80025210 <read_fat+0x38>
    // here should be a cache layer for FAT table, but not implemented yet.
    struct buf *b = bread(0, fat_sec);
    uint32 next_clus = *(uint32 *)(b->data + fat_offset_of_clus(cluster));
    brelse(b);
    return next_clus;
}
    80025202:	8526                	mv	a0,s1
    80025204:	60e2                	ld	ra,24(sp)
    80025206:	6442                	ld	s0,16(sp)
    80025208:	64a2                	ld	s1,8(sp)
    8002520a:	6902                	ld	s2,0(sp)
    8002520c:	6105                	addi	sp,sp,32
    8002520e:	8082                	ret
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    80025210:	0025149b          	slliw	s1,a0,0x2
    80025214:	0001c917          	auipc	s2,0x1c
    80025218:	21490913          	addi	s2,s2,532 # 80041428 <fat>
    8002521c:	01095783          	lhu	a5,16(s2)
    80025220:	02f4d7bb          	divuw	a5,s1,a5
    80025224:	01495583          	lhu	a1,20(s2)
    struct buf *b = bread(0, fat_sec);
    80025228:	9dbd                	addw	a1,a1,a5
    8002522a:	4501                	li	a0,0
    8002522c:	ffffe097          	auipc	ra,0xffffe
    80025230:	294080e7          	jalr	660(ra) # 800234c0 <bread>
    return (cluster << 2) % fat.bpb.byts_per_sec;
    80025234:	01095783          	lhu	a5,16(s2)
    80025238:	02f4f4bb          	remuw	s1,s1,a5
    uint32 next_clus = *(uint32 *)(b->data + fat_offset_of_clus(cluster));
    8002523c:	94aa                	add	s1,s1,a0
    8002523e:	4ca4                	lw	s1,88(s1)
    brelse(b);
    80025240:	ffffe097          	auipc	ra,0xffffe
    80025244:	3be080e7          	jalr	958(ra) # 800235fe <brelse>
    return next_clus;
    80025248:	bf6d                	j	80025202 <read_fat+0x2a>

000000008002524a <alloc_clus>:
        brelse(b);
    }
}

static uint32 alloc_clus(uint8 dev)
{
    8002524a:	711d                	addi	sp,sp,-96
    8002524c:	ec86                	sd	ra,88(sp)
    8002524e:	e8a2                	sd	s0,80(sp)
    80025250:	e4a6                	sd	s1,72(sp)
    80025252:	e0ca                	sd	s2,64(sp)
    80025254:	fc4e                	sd	s3,56(sp)
    80025256:	f852                	sd	s4,48(sp)
    80025258:	f456                	sd	s5,40(sp)
    8002525a:	f05a                	sd	s6,32(sp)
    8002525c:	ec5e                	sd	s7,24(sp)
    8002525e:	e862                	sd	s8,16(sp)
    80025260:	e466                	sd	s9,8(sp)
    80025262:	1080                	addi	s0,sp,96
    // should we keep a free cluster list? instead of searching fat every time.
    struct buf *b;
    uint32 sec = fat.bpb.rsvd_sec_cnt;
    80025264:	0001c797          	auipc	a5,0x1c
    80025268:	1c478793          	addi	a5,a5,452 # 80041428 <fat>
    8002526c:	0147db03          	lhu	s6,20(a5)
    uint32 const ent_per_sec = fat.bpb.byts_per_sec / sizeof(uint32);
    80025270:	0107d903          	lhu	s2,16(a5)
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    80025274:	539c                	lw	a5,32(a5)
    80025276:	10078663          	beqz	a5,80025382 <alloc_clus+0x138>
    8002527a:	0029591b          	srliw	s2,s2,0x2
    8002527e:	0009099b          	sext.w	s3,s2
    80025282:	4a81                	li	s5,0
        b = bread(dev, sec);
    80025284:	00050b9b          	sext.w	s7,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80025288:	4c01                	li	s8,0
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    8002528a:	0001cc97          	auipc	s9,0x1c
    8002528e:	19ec8c93          	addi	s9,s9,414 # 80041428 <fat>
    80025292:	a821                	j	800252aa <alloc_clus+0x60>
                uint32 clus = i * ent_per_sec + j;
                zero_clus(clus);
                return clus;
            }
        }
        brelse(b);
    80025294:	8552                	mv	a0,s4
    80025296:	ffffe097          	auipc	ra,0xffffe
    8002529a:	368080e7          	jalr	872(ra) # 800235fe <brelse>
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    8002529e:	2a85                	addiw	s5,s5,1
    800252a0:	2b05                	addiw	s6,s6,1
    800252a2:	020ca783          	lw	a5,32(s9)
    800252a6:	0cfafe63          	bgeu	s5,a5,80025382 <alloc_clus+0x138>
        b = bread(dev, sec);
    800252aa:	85da                	mv	a1,s6
    800252ac:	855e                	mv	a0,s7
    800252ae:	ffffe097          	auipc	ra,0xffffe
    800252b2:	212080e7          	jalr	530(ra) # 800234c0 <bread>
    800252b6:	8a2a                	mv	s4,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    800252b8:	fc098ee3          	beqz	s3,80025294 <alloc_clus+0x4a>
            if (((uint32 *)(b->data))[j] == 0) {
    800252bc:	05850693          	addi	a3,a0,88
    800252c0:	4d24                	lw	s1,88(a0)
    800252c2:	cc81                	beqz	s1,800252da <alloc_clus+0x90>
    800252c4:	05c50793          	addi	a5,a0,92
        for (uint32 j = 0; j < ent_per_sec; j++) {
    800252c8:	84e2                	mv	s1,s8
    800252ca:	2485                	addiw	s1,s1,1
    800252cc:	fc9984e3          	beq	s3,s1,80025294 <alloc_clus+0x4a>
            if (((uint32 *)(b->data))[j] == 0) {
    800252d0:	86be                	mv	a3,a5
    800252d2:	0791                	addi	a5,a5,4
    800252d4:	ffc7a703          	lw	a4,-4(a5)
    800252d8:	fb6d                	bnez	a4,800252ca <alloc_clus+0x80>
                ((uint32 *)(b->data))[j] = FAT32_EOC + 7;
    800252da:	100007b7          	lui	a5,0x10000
    800252de:	17fd                	addi	a5,a5,-1
    800252e0:	c29c                	sw	a5,0(a3)
                bwrite(b);
    800252e2:	8552                	mv	a0,s4
    800252e4:	ffffe097          	auipc	ra,0xffffe
    800252e8:	2de080e7          	jalr	734(ra) # 800235c2 <bwrite>
                brelse(b);
    800252ec:	8552                	mv	a0,s4
    800252ee:	ffffe097          	auipc	ra,0xffffe
    800252f2:	310080e7          	jalr	784(ra) # 800235fe <brelse>
                uint32 clus = i * ent_per_sec + j;
    800252f6:	0359093b          	mulw	s2,s2,s5
    800252fa:	009904bb          	addw	s1,s2,s1
    800252fe:	00048a9b          	sext.w	s5,s1
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    80025302:	0001c717          	auipc	a4,0x1c
    80025306:	12670713          	addi	a4,a4,294 # 80041428 <fat>
    8002530a:	01274783          	lbu	a5,18(a4)
    8002530e:	34f9                	addiw	s1,s1,-2
    80025310:	02f489bb          	mulw	s3,s1,a5
    80025314:	4318                	lw	a4,0(a4)
    80025316:	00e989bb          	addw	s3,s3,a4
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    8002531a:	c7b1                	beqz	a5,80025366 <alloc_clus+0x11c>
    8002531c:	4481                	li	s1,0
    8002531e:	0001ca17          	auipc	s4,0x1c
    80025322:	10aa0a13          	addi	s4,s4,266 # 80041428 <fat>
        b = bread(0, sec++);
    80025326:	013485bb          	addw	a1,s1,s3
    8002532a:	4501                	li	a0,0
    8002532c:	ffffe097          	auipc	ra,0xffffe
    80025330:	194080e7          	jalr	404(ra) # 800234c0 <bread>
    80025334:	892a                	mv	s2,a0
        memset(b->data, 0, BSIZE);
    80025336:	20000613          	li	a2,512
    8002533a:	4581                	li	a1,0
    8002533c:	05850513          	addi	a0,a0,88
    80025340:	ffffb097          	auipc	ra,0xffffb
    80025344:	41c080e7          	jalr	1052(ra) # 8002075c <memset>
        bwrite(b);
    80025348:	854a                	mv	a0,s2
    8002534a:	ffffe097          	auipc	ra,0xffffe
    8002534e:	278080e7          	jalr	632(ra) # 800235c2 <bwrite>
        brelse(b);
    80025352:	854a                	mv	a0,s2
    80025354:	ffffe097          	auipc	ra,0xffffe
    80025358:	2aa080e7          	jalr	682(ra) # 800235fe <brelse>
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    8002535c:	2485                	addiw	s1,s1,1
    8002535e:	012a4783          	lbu	a5,18(s4)
    80025362:	fcf4c2e3          	blt	s1,a5,80025326 <alloc_clus+0xdc>
    }
    panic("no clusters");
}
    80025366:	8556                	mv	a0,s5
    80025368:	60e6                	ld	ra,88(sp)
    8002536a:	6446                	ld	s0,80(sp)
    8002536c:	64a6                	ld	s1,72(sp)
    8002536e:	6906                	ld	s2,64(sp)
    80025370:	79e2                	ld	s3,56(sp)
    80025372:	7a42                	ld	s4,48(sp)
    80025374:	7aa2                	ld	s5,40(sp)
    80025376:	7b02                	ld	s6,32(sp)
    80025378:	6be2                	ld	s7,24(sp)
    8002537a:	6c42                	ld	s8,16(sp)
    8002537c:	6ca2                	ld	s9,8(sp)
    8002537e:	6125                	addi	sp,sp,96
    80025380:	8082                	ret
    panic("no clusters");
    80025382:	00007517          	auipc	a0,0x7
    80025386:	35e50513          	addi	a0,a0,862 # 8002c6e0 <sysnames+0x760>
    8002538a:	ffffb097          	auipc	ra,0xffffb
    8002538e:	dbc080e7          	jalr	-580(ra) # 80020146 <panic>

0000000080025392 <write_fat>:
    if (cluster > fat.data_clus_cnt + 1) {
    80025392:	0001c797          	auipc	a5,0x1c
    80025396:	09678793          	addi	a5,a5,150 # 80041428 <fat>
    8002539a:	479c                	lw	a5,8(a5)
    8002539c:	2785                	addiw	a5,a5,1
    8002539e:	06a7e763          	bltu	a5,a0,8002540c <write_fat+0x7a>
{
    800253a2:	7179                	addi	sp,sp,-48
    800253a4:	f406                	sd	ra,40(sp)
    800253a6:	f022                	sd	s0,32(sp)
    800253a8:	ec26                	sd	s1,24(sp)
    800253aa:	e84a                	sd	s2,16(sp)
    800253ac:	e44e                	sd	s3,8(sp)
    800253ae:	e052                	sd	s4,0(sp)
    800253b0:	1800                	addi	s0,sp,48
    800253b2:	8a2e                	mv	s4,a1
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    800253b4:	0025149b          	slliw	s1,a0,0x2
    800253b8:	0001c917          	auipc	s2,0x1c
    800253bc:	07090913          	addi	s2,s2,112 # 80041428 <fat>
    800253c0:	01095783          	lhu	a5,16(s2)
    800253c4:	02f4d7bb          	divuw	a5,s1,a5
    800253c8:	01495583          	lhu	a1,20(s2)
    struct buf *b = bread(0, fat_sec);
    800253cc:	9dbd                	addw	a1,a1,a5
    800253ce:	4501                	li	a0,0
    800253d0:	ffffe097          	auipc	ra,0xffffe
    800253d4:	0f0080e7          	jalr	240(ra) # 800234c0 <bread>
    800253d8:	89aa                	mv	s3,a0
    return (cluster << 2) % fat.bpb.byts_per_sec;
    800253da:	01095783          	lhu	a5,16(s2)
    800253de:	02f4f4bb          	remuw	s1,s1,a5
    *(uint32 *)(b->data + off) = content;
    800253e2:	94aa                	add	s1,s1,a0
    800253e4:	0544ac23          	sw	s4,88(s1)
    bwrite(b);
    800253e8:	ffffe097          	auipc	ra,0xffffe
    800253ec:	1da080e7          	jalr	474(ra) # 800235c2 <bwrite>
    brelse(b);
    800253f0:	854e                	mv	a0,s3
    800253f2:	ffffe097          	auipc	ra,0xffffe
    800253f6:	20c080e7          	jalr	524(ra) # 800235fe <brelse>
    return 0;
    800253fa:	4501                	li	a0,0
}
    800253fc:	70a2                	ld	ra,40(sp)
    800253fe:	7402                	ld	s0,32(sp)
    80025400:	64e2                	ld	s1,24(sp)
    80025402:	6942                	ld	s2,16(sp)
    80025404:	69a2                	ld	s3,8(sp)
    80025406:	6a02                	ld	s4,0(sp)
    80025408:	6145                	addi	sp,sp,48
    8002540a:	8082                	ret
        return -1;
    8002540c:	557d                	li	a0,-1
}
    8002540e:	8082                	ret

0000000080025410 <reloc_clus>:
 * @param   off         the offset from the beginning of the relative file
 * @param   alloc       whether alloc new cluster when meeting end of FAT chains
 * @return              the offset from the new cur_clus
 */
static int reloc_clus(struct dirent *entry, uint off, int alloc)
{
    80025410:	715d                	addi	sp,sp,-80
    80025412:	e486                	sd	ra,72(sp)
    80025414:	e0a2                	sd	s0,64(sp)
    80025416:	fc26                	sd	s1,56(sp)
    80025418:	f84a                	sd	s2,48(sp)
    8002541a:	f44e                	sd	s3,40(sp)
    8002541c:	f052                	sd	s4,32(sp)
    8002541e:	ec56                	sd	s5,24(sp)
    80025420:	e85a                	sd	s6,16(sp)
    80025422:	e45e                	sd	s7,8(sp)
    80025424:	0880                	addi	s0,sp,80
    80025426:	84aa                	mv	s1,a0
    80025428:	8a2e                	mv	s4,a1
    int clus_num = off / fat.byts_per_clus;
    8002542a:	0001c797          	auipc	a5,0x1c
    8002542e:	ffe78793          	addi	a5,a5,-2 # 80041428 <fat>
    80025432:	00c7ab83          	lw	s7,12(a5)
    80025436:	0375d9bb          	divuw	s3,a1,s7
    while (clus_num > entry->clus_cnt) {
    8002543a:	11052703          	lw	a4,272(a0)
    8002543e:	07377763          	bgeu	a4,s3,800254ac <reloc_clus+0x9c>
    80025442:	8b32                	mv	s6,a2
        int clus = read_fat(entry->cur_clus);
        if (clus >= FAT32_EOC) {
    80025444:	10000ab7          	lui	s5,0x10000
    80025448:	1add                	addi	s5,s5,-9
    8002544a:	a025                	j	80025472 <reloc_clus+0x62>
            if (alloc) {
                clus = alloc_clus(entry->dev);
                write_fat(entry->cur_clus, clus);
            } else {
                entry->cur_clus = entry->first_clus;
    8002544c:	1044a783          	lw	a5,260(s1)
    80025450:	10f4a623          	sw	a5,268(s1)
                entry->clus_cnt = 0;
    80025454:	1004a823          	sw	zero,272(s1)
                return -1;
    80025458:	557d                	li	a0,-1
    8002545a:	a04d                	j	800254fc <reloc_clus+0xec>
            }
        }
        entry->cur_clus = clus;
    8002545c:	1124a623          	sw	s2,268(s1)
        entry->clus_cnt++;
    80025460:	1104a783          	lw	a5,272(s1)
    80025464:	2785                	addiw	a5,a5,1
    80025466:	0007871b          	sext.w	a4,a5
    8002546a:	10f4a823          	sw	a5,272(s1)
    while (clus_num > entry->clus_cnt) {
    8002546e:	03377f63          	bgeu	a4,s3,800254ac <reloc_clus+0x9c>
        int clus = read_fat(entry->cur_clus);
    80025472:	10c4a503          	lw	a0,268(s1)
    80025476:	00000097          	auipc	ra,0x0
    8002547a:	d62080e7          	jalr	-670(ra) # 800251d8 <read_fat>
    8002547e:	0005091b          	sext.w	s2,a0
        if (clus >= FAT32_EOC) {
    80025482:	fd2adde3          	bge	s5,s2,8002545c <reloc_clus+0x4c>
            if (alloc) {
    80025486:	fc0b03e3          	beqz	s6,8002544c <reloc_clus+0x3c>
                clus = alloc_clus(entry->dev);
    8002548a:	1144c503          	lbu	a0,276(s1)
    8002548e:	00000097          	auipc	ra,0x0
    80025492:	dbc080e7          	jalr	-580(ra) # 8002524a <alloc_clus>
    80025496:	0005059b          	sext.w	a1,a0
    8002549a:	0005891b          	sext.w	s2,a1
                write_fat(entry->cur_clus, clus);
    8002549e:	10c4a503          	lw	a0,268(s1)
    800254a2:	00000097          	auipc	ra,0x0
    800254a6:	ef0080e7          	jalr	-272(ra) # 80025392 <write_fat>
    800254aa:	bf4d                	j	8002545c <reloc_clus+0x4c>
    }
    if (clus_num < entry->clus_cnt) {
    800254ac:	04e9f163          	bgeu	s3,a4,800254ee <reloc_clus+0xde>
        entry->cur_clus = entry->first_clus;
    800254b0:	1044a783          	lw	a5,260(s1)
    800254b4:	10f4a623          	sw	a5,268(s1)
        entry->clus_cnt = 0;
    800254b8:	1004a823          	sw	zero,272(s1)
        while (entry->clus_cnt < clus_num) {
    800254bc:	037a6963          	bltu	s4,s7,800254ee <reloc_clus+0xde>
            entry->cur_clus = read_fat(entry->cur_clus);
            if (entry->cur_clus >= FAT32_EOC) {
    800254c0:	10000937          	lui	s2,0x10000
    800254c4:	195d                	addi	s2,s2,-9
            entry->cur_clus = read_fat(entry->cur_clus);
    800254c6:	10c4a503          	lw	a0,268(s1)
    800254ca:	00000097          	auipc	ra,0x0
    800254ce:	d0e080e7          	jalr	-754(ra) # 800251d8 <read_fat>
    800254d2:	2501                	sext.w	a0,a0
    800254d4:	10a4a623          	sw	a0,268(s1)
            if (entry->cur_clus >= FAT32_EOC) {
    800254d8:	02a96d63          	bltu	s2,a0,80025512 <reloc_clus+0x102>
                panic("reloc_clus");
            }
            entry->clus_cnt++;
    800254dc:	1104a783          	lw	a5,272(s1)
    800254e0:	2785                	addiw	a5,a5,1
    800254e2:	0007871b          	sext.w	a4,a5
    800254e6:	10f4a823          	sw	a5,272(s1)
        while (entry->clus_cnt < clus_num) {
    800254ea:	fd376ee3          	bltu	a4,s3,800254c6 <reloc_clus+0xb6>
        }
    }
    return off % fat.byts_per_clus;
    800254ee:	0001c797          	auipc	a5,0x1c
    800254f2:	f3a78793          	addi	a5,a5,-198 # 80041428 <fat>
    800254f6:	47c8                	lw	a0,12(a5)
    800254f8:	02aa753b          	remuw	a0,s4,a0
}
    800254fc:	60a6                	ld	ra,72(sp)
    800254fe:	6406                	ld	s0,64(sp)
    80025500:	74e2                	ld	s1,56(sp)
    80025502:	7942                	ld	s2,48(sp)
    80025504:	79a2                	ld	s3,40(sp)
    80025506:	7a02                	ld	s4,32(sp)
    80025508:	6ae2                	ld	s5,24(sp)
    8002550a:	6b42                	ld	s6,16(sp)
    8002550c:	6ba2                	ld	s7,8(sp)
    8002550e:	6161                	addi	sp,sp,80
    80025510:	8082                	ret
                panic("reloc_clus");
    80025512:	00007517          	auipc	a0,0x7
    80025516:	1de50513          	addi	a0,a0,478 # 8002c6f0 <sysnames+0x770>
    8002551a:	ffffb097          	auipc	ra,0xffffb
    8002551e:	c2c080e7          	jalr	-980(ra) # 80020146 <panic>

0000000080025522 <rw_clus>:
{
    80025522:	7119                	addi	sp,sp,-128
    80025524:	fc86                	sd	ra,120(sp)
    80025526:	f8a2                	sd	s0,112(sp)
    80025528:	f4a6                	sd	s1,104(sp)
    8002552a:	f0ca                	sd	s2,96(sp)
    8002552c:	ecce                	sd	s3,88(sp)
    8002552e:	e8d2                	sd	s4,80(sp)
    80025530:	e4d6                	sd	s5,72(sp)
    80025532:	e0da                	sd	s6,64(sp)
    80025534:	fc5e                	sd	s7,56(sp)
    80025536:	f862                	sd	s8,48(sp)
    80025538:	f466                	sd	s9,40(sp)
    8002553a:	f06a                	sd	s10,32(sp)
    8002553c:	ec6e                	sd	s11,24(sp)
    8002553e:	0100                	addi	s0,sp,128
    80025540:	f8c43423          	sd	a2,-120(s0)
    80025544:	8b36                	mv	s6,a3
    80025546:	8bbe                	mv	s7,a5
    if (off + n > fat.byts_per_clus)
    80025548:	00f706bb          	addw	a3,a4,a5
    8002554c:	0001c797          	auipc	a5,0x1c
    80025550:	edc78793          	addi	a5,a5,-292 # 80041428 <fat>
    80025554:	47dc                	lw	a5,12(a5)
    80025556:	02d7ef63          	bltu	a5,a3,80025594 <rw_clus+0x72>
    8002555a:	8d2e                	mv	s10,a1
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    8002555c:	0001c797          	auipc	a5,0x1c
    80025560:	ecc78793          	addi	a5,a5,-308 # 80041428 <fat>
    80025564:	0107da03          	lhu	s4,16(a5)
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    80025568:	ffe5099b          	addiw	s3,a0,-2
    8002556c:	0127c503          	lbu	a0,18(a5)
    80025570:	02a989bb          	mulw	s3,s3,a0
    80025574:	4388                	lw	a0,0(a5)
    80025576:	00a989bb          	addw	s3,s3,a0
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    8002557a:	034757bb          	divuw	a5,a4,s4
    8002557e:	00f989bb          	addw	s3,s3,a5
    off = off % fat.bpb.byts_per_sec;
    80025582:	03477a3b          	remuw	s4,a4,s4
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    80025586:	0e0b8363          	beqz	s7,8002566c <rw_clus+0x14a>
    8002558a:	4901                	li	s2,0
        m = BSIZE - off % BSIZE;
    8002558c:	20000d93          	li	s11,512
        if (bad == -1) {
    80025590:	5cfd                	li	s9,-1
    80025592:	a095                	j	800255f6 <rw_clus+0xd4>
        panic("offset out of range");
    80025594:	00007517          	auipc	a0,0x7
    80025598:	16c50513          	addi	a0,a0,364 # 8002c700 <sysnames+0x780>
    8002559c:	ffffb097          	auipc	ra,0xffffb
    800255a0:	baa080e7          	jalr	-1110(ra) # 80020146 <panic>
                bwrite(bp);
    800255a4:	8556                	mv	a0,s5
    800255a6:	ffffe097          	auipc	ra,0xffffe
    800255aa:	01c080e7          	jalr	28(ra) # 800235c2 <bwrite>
        brelse(bp);
    800255ae:	8556                	mv	a0,s5
    800255b0:	ffffe097          	auipc	ra,0xffffe
    800255b4:	04e080e7          	jalr	78(ra) # 800235fe <brelse>
        if (bad == -1) {
    800255b8:	a02d                	j	800255e2 <rw_clus+0xc0>
            bad = either_copyout(user, data, bp->data + (off % BSIZE), m);
    800255ba:	058a8613          	addi	a2,s5,88 # 10000058 <BASE_ADDRESS-0x7001ffa8>
    800255be:	1682                	slli	a3,a3,0x20
    800255c0:	9281                	srli	a3,a3,0x20
    800255c2:	963a                	add	a2,a2,a4
    800255c4:	85da                	mv	a1,s6
    800255c6:	f8843503          	ld	a0,-120(s0)
    800255ca:	ffffd097          	auipc	ra,0xffffd
    800255ce:	096080e7          	jalr	150(ra) # 80022660 <either_copyout>
    800255d2:	8c2a                	mv	s8,a0
        brelse(bp);
    800255d4:	8556                	mv	a0,s5
    800255d6:	ffffe097          	auipc	ra,0xffffe
    800255da:	028080e7          	jalr	40(ra) # 800235fe <brelse>
        if (bad == -1) {
    800255de:	079c0763          	beq	s8,s9,8002564c <rw_clus+0x12a>
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    800255e2:	0124893b          	addw	s2,s1,s2
    800255e6:	01448a3b          	addw	s4,s1,s4
    800255ea:	1482                	slli	s1,s1,0x20
    800255ec:	9081                	srli	s1,s1,0x20
    800255ee:	9b26                	add	s6,s6,s1
    800255f0:	2985                	addiw	s3,s3,1
    800255f2:	05797d63          	bgeu	s2,s7,8002564c <rw_clus+0x12a>
        bp = bread(0, sec);
    800255f6:	85ce                	mv	a1,s3
    800255f8:	4501                	li	a0,0
    800255fa:	ffffe097          	auipc	ra,0xffffe
    800255fe:	ec6080e7          	jalr	-314(ra) # 800234c0 <bread>
    80025602:	8aaa                	mv	s5,a0
        m = BSIZE - off % BSIZE;
    80025604:	1ffa7713          	andi	a4,s4,511
    80025608:	40ed863b          	subw	a2,s11,a4
        if (n - tot < m) {
    8002560c:	412b87bb          	subw	a5,s7,s2
    80025610:	86be                	mv	a3,a5
    80025612:	2781                	sext.w	a5,a5
    80025614:	0006059b          	sext.w	a1,a2
    80025618:	00f5f363          	bgeu	a1,a5,8002561e <rw_clus+0xfc>
    8002561c:	86b2                	mv	a3,a2
    8002561e:	0006849b          	sext.w	s1,a3
        if (write) {
    80025622:	f80d0ce3          	beqz	s10,800255ba <rw_clus+0x98>
            if ((bad = either_copyin(bp->data + (off % BSIZE), user, data, m)) != -1) {
    80025626:	058a8513          	addi	a0,s5,88
    8002562a:	1682                	slli	a3,a3,0x20
    8002562c:	9281                	srli	a3,a3,0x20
    8002562e:	865a                	mv	a2,s6
    80025630:	f8843583          	ld	a1,-120(s0)
    80025634:	953a                	add	a0,a0,a4
    80025636:	ffffd097          	auipc	ra,0xffffd
    8002563a:	060080e7          	jalr	96(ra) # 80022696 <either_copyin>
    8002563e:	f79513e3          	bne	a0,s9,800255a4 <rw_clus+0x82>
        brelse(bp);
    80025642:	8556                	mv	a0,s5
    80025644:	ffffe097          	auipc	ra,0xffffe
    80025648:	fba080e7          	jalr	-70(ra) # 800235fe <brelse>
}
    8002564c:	854a                	mv	a0,s2
    8002564e:	70e6                	ld	ra,120(sp)
    80025650:	7446                	ld	s0,112(sp)
    80025652:	74a6                	ld	s1,104(sp)
    80025654:	7906                	ld	s2,96(sp)
    80025656:	69e6                	ld	s3,88(sp)
    80025658:	6a46                	ld	s4,80(sp)
    8002565a:	6aa6                	ld	s5,72(sp)
    8002565c:	6b06                	ld	s6,64(sp)
    8002565e:	7be2                	ld	s7,56(sp)
    80025660:	7c42                	ld	s8,48(sp)
    80025662:	7ca2                	ld	s9,40(sp)
    80025664:	7d02                	ld	s10,32(sp)
    80025666:	6de2                	ld	s11,24(sp)
    80025668:	6109                	addi	sp,sp,128
    8002566a:	8082                	ret
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    8002566c:	895e                	mv	s2,s7
    8002566e:	bff9                	j	8002564c <rw_clus+0x12a>

0000000080025670 <eget>:
// by their whole path. But when parsing a path, we open all the directories through it, 
// which forms a linked list from the final file to the root. Thus, we use the "parent" pointer 
// to recognize whether an entry with the "name" as given is really the file we want in the right path.
// Should never get root by eget, it's easy to understand.
static struct dirent *eget(struct dirent *parent, char *name)
{
    80025670:	7139                	addi	sp,sp,-64
    80025672:	fc06                	sd	ra,56(sp)
    80025674:	f822                	sd	s0,48(sp)
    80025676:	f426                	sd	s1,40(sp)
    80025678:	f04a                	sd	s2,32(sp)
    8002567a:	ec4e                	sd	s3,24(sp)
    8002567c:	e852                	sd	s4,16(sp)
    8002567e:	e456                	sd	s5,8(sp)
    80025680:	0080                	addi	s0,sp,64
    80025682:	8a2a                	mv	s4,a0
    80025684:	8aae                	mv	s5,a1
    struct dirent *ep;
    acquire(&ecache.lock);
    80025686:	0001c517          	auipc	a0,0x1c
    8002568a:	f3250513          	addi	a0,a0,-206 # 800415b8 <ecache>
    8002568e:	ffffb097          	auipc	ra,0xffffb
    80025692:	032080e7          	jalr	50(ra) # 800206c0 <acquire>
    if (name) {
    80025696:	060a8d63          	beqz	s5,80025710 <eget+0xa0>
        for (ep = root.next; ep != &root; ep = ep->next) {          // LRU algo
    8002569a:	0001c797          	auipc	a5,0x1c
    8002569e:	d8e78793          	addi	a5,a5,-626 # 80041428 <fat>
    800256a2:	1507b483          	ld	s1,336(a5)
    800256a6:	0001c797          	auipc	a5,0x1c
    800256aa:	daa78793          	addi	a5,a5,-598 # 80041450 <root>
    800256ae:	06f48163          	beq	s1,a5,80025710 <eget+0xa0>
            if (ep->valid == 1 && ep->parent == parent
    800256b2:	4905                	li	s2,1
        for (ep = root.next; ep != &root; ep = ep->next) {          // LRU algo
    800256b4:	89be                	mv	s3,a5
    800256b6:	a029                	j	800256c0 <eget+0x50>
    800256b8:	1284b483          	ld	s1,296(s1)
    800256bc:	05348a63          	beq	s1,s3,80025710 <eget+0xa0>
            if (ep->valid == 1 && ep->parent == parent
    800256c0:	11649783          	lh	a5,278(s1)
    800256c4:	ff279ae3          	bne	a5,s2,800256b8 <eget+0x48>
    800256c8:	1204b783          	ld	a5,288(s1)
    800256cc:	ff4796e3          	bne	a5,s4,800256b8 <eget+0x48>
                && strncmp(ep->filename, name, FAT32_MAX_FILENAME) == 0) {
    800256d0:	0ff00613          	li	a2,255
    800256d4:	85d6                	mv	a1,s5
    800256d6:	8526                	mv	a0,s1
    800256d8:	ffffb097          	auipc	ra,0xffffb
    800256dc:	16c080e7          	jalr	364(ra) # 80020844 <strncmp>
    800256e0:	fd61                	bnez	a0,800256b8 <eget+0x48>
                if (ep->ref++ == 0) {
    800256e2:	1184a783          	lw	a5,280(s1)
    800256e6:	0017871b          	addiw	a4,a5,1
    800256ea:	10e4ac23          	sw	a4,280(s1)
    800256ee:	eb81                	bnez	a5,800256fe <eget+0x8e>
                    ep->parent->ref++;
    800256f0:	1204b703          	ld	a4,288(s1)
    800256f4:	11872783          	lw	a5,280(a4)
    800256f8:	2785                	addiw	a5,a5,1
    800256fa:	10f72c23          	sw	a5,280(a4)
                }
                release(&ecache.lock);
    800256fe:	0001c517          	auipc	a0,0x1c
    80025702:	eba50513          	addi	a0,a0,-326 # 800415b8 <ecache>
    80025706:	ffffb097          	auipc	ra,0xffffb
    8002570a:	00e080e7          	jalr	14(ra) # 80020714 <release>
                // edup(ep->parent);
                return ep;
    8002570e:	a085                	j	8002576e <eget+0xfe>
            }
        }
    }
    for (ep = root.prev; ep != &root; ep = ep->prev) {              // LRU algo
    80025710:	0001c797          	auipc	a5,0x1c
    80025714:	d1878793          	addi	a5,a5,-744 # 80041428 <fat>
    80025718:	1587b483          	ld	s1,344(a5)
    8002571c:	0001c797          	auipc	a5,0x1c
    80025720:	d3478793          	addi	a5,a5,-716 # 80041450 <root>
    80025724:	04f48f63          	beq	s1,a5,80025782 <eget+0x112>
        if (ep->ref == 0) {
    80025728:	1184a783          	lw	a5,280(s1)
    8002572c:	cf81                	beqz	a5,80025744 <eget+0xd4>
    for (ep = root.prev; ep != &root; ep = ep->prev) {              // LRU algo
    8002572e:	0001c717          	auipc	a4,0x1c
    80025732:	d2270713          	addi	a4,a4,-734 # 80041450 <root>
    80025736:	1304b483          	ld	s1,304(s1)
    8002573a:	04e48463          	beq	s1,a4,80025782 <eget+0x112>
        if (ep->ref == 0) {
    8002573e:	1184a783          	lw	a5,280(s1)
    80025742:	fbf5                	bnez	a5,80025736 <eget+0xc6>
            ep->ref = 1;
    80025744:	4785                	li	a5,1
    80025746:	10f4ac23          	sw	a5,280(s1)
            ep->dev = parent->dev;
    8002574a:	114a4783          	lbu	a5,276(s4)
    8002574e:	10f48a23          	sb	a5,276(s1)
            ep->off = 0;
    80025752:	1004ae23          	sw	zero,284(s1)
            ep->valid = 0;
    80025756:	10049b23          	sh	zero,278(s1)
            ep->dirty = 0;
    8002575a:	10048aa3          	sb	zero,277(s1)
            release(&ecache.lock);
    8002575e:	0001c517          	auipc	a0,0x1c
    80025762:	e5a50513          	addi	a0,a0,-422 # 800415b8 <ecache>
    80025766:	ffffb097          	auipc	ra,0xffffb
    8002576a:	fae080e7          	jalr	-82(ra) # 80020714 <release>
            return ep;
        }
    }
    panic("eget: insufficient ecache");
    return 0;
}
    8002576e:	8526                	mv	a0,s1
    80025770:	70e2                	ld	ra,56(sp)
    80025772:	7442                	ld	s0,48(sp)
    80025774:	74a2                	ld	s1,40(sp)
    80025776:	7902                	ld	s2,32(sp)
    80025778:	69e2                	ld	s3,24(sp)
    8002577a:	6a42                	ld	s4,16(sp)
    8002577c:	6aa2                	ld	s5,8(sp)
    8002577e:	6121                	addi	sp,sp,64
    80025780:	8082                	ret
    panic("eget: insufficient ecache");
    80025782:	00007517          	auipc	a0,0x7
    80025786:	f9650513          	addi	a0,a0,-106 # 8002c718 <sysnames+0x798>
    8002578a:	ffffb097          	auipc	ra,0xffffb
    8002578e:	9bc080e7          	jalr	-1604(ra) # 80020146 <panic>

0000000080025792 <read_entry_name>:
 * @param   buffer      pointer to the array that stores the name
 * @param   raw_entry   pointer to the entry in a sector buffer
 * @param   islong      if non-zero, read as l-n-e, otherwise s-n-e.
 */
static void read_entry_name(char *buffer, union dentry *d)
{
    80025792:	7179                	addi	sp,sp,-48
    80025794:	f406                	sd	ra,40(sp)
    80025796:	f022                	sd	s0,32(sp)
    80025798:	ec26                	sd	s1,24(sp)
    8002579a:	e84a                	sd	s2,16(sp)
    8002579c:	1800                	addi	s0,sp,48
    8002579e:	892a                	mv	s2,a0
    800257a0:	84ae                	mv	s1,a1
    if (d->lne.attr == ATTR_LONG_NAME) {                       // long entry branch
    800257a2:	00b5c703          	lbu	a4,11(a1)
    800257a6:	47bd                	li	a5,15
    800257a8:	0af70363          	beq	a4,a5,8002584e <read_entry_name+0xbc>
        snstr(buffer, d->lne.name2, NELEM(d->lne.name2));
        buffer += NELEM(d->lne.name2);
        snstr(buffer, d->lne.name3, NELEM(d->lne.name3));
    } else {
        // assert: only "." and ".." will enter this branch
        memset(buffer, 0, CHAR_SHORT_NAME + 2); // plus '.' and '\0'
    800257ac:	4635                	li	a2,13
    800257ae:	4581                	li	a1,0
    800257b0:	ffffb097          	auipc	ra,0xffffb
    800257b4:	fac080e7          	jalr	-84(ra) # 8002075c <memset>
        int i;
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    800257b8:	0004c703          	lbu	a4,0(s1)
    800257bc:	02000793          	li	a5,32
    800257c0:	0cf70a63          	beq	a4,a5,80025894 <read_entry_name+0x102>
    800257c4:	4785                	li	a5,1
    800257c6:	02000613          	li	a2,32
    800257ca:	45a5                	li	a1,9
            buffer[i] = d->sne.name[i];
    800257cc:	00f906b3          	add	a3,s2,a5
    800257d0:	fee68fa3          	sb	a4,-1(a3) # 1fff <BASE_ADDRESS-0x8001e001>
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    800257d4:	0007869b          	sext.w	a3,a5
    800257d8:	00f48733          	add	a4,s1,a5
    800257dc:	00074703          	lbu	a4,0(a4)
    800257e0:	00c70563          	beq	a4,a2,800257ea <read_entry_name+0x58>
    800257e4:	0785                	addi	a5,a5,1
    800257e6:	feb793e3          	bne	a5,a1,800257cc <read_entry_name+0x3a>
        }
        if (d->sne.name[8] != ' ') {
    800257ea:	0084c703          	lbu	a4,8(s1)
    800257ee:	02000793          	li	a5,32
    800257f2:	04f70863          	beq	a4,a5,80025842 <read_entry_name+0xb0>
            buffer[i++] = '.';
    800257f6:	0016871b          	addiw	a4,a3,1
    800257fa:	00d907b3          	add	a5,s2,a3
    800257fe:	02e00613          	li	a2,46
    80025802:	00c78023          	sb	a2,0(a5)
        }
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
            if (d->sne.name[j] == ' ') { break; }
    80025806:	0084c783          	lbu	a5,8(s1)
    8002580a:	02000613          	li	a2,32
    8002580e:	02c78a63          	beq	a5,a2,80025842 <read_entry_name+0xb0>
            buffer[i] = d->sne.name[j];
    80025812:	974a                	add	a4,a4,s2
    80025814:	00f70023          	sb	a5,0(a4)
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
    80025818:	0026879b          	addiw	a5,a3,2
            if (d->sne.name[j] == ' ') { break; }
    8002581c:	0094c703          	lbu	a4,9(s1)
    80025820:	02000613          	li	a2,32
    80025824:	00c70f63          	beq	a4,a2,80025842 <read_entry_name+0xb0>
            buffer[i] = d->sne.name[j];
    80025828:	97ca                	add	a5,a5,s2
    8002582a:	00e78023          	sb	a4,0(a5)
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
    8002582e:	268d                	addiw	a3,a3,3
            if (d->sne.name[j] == ' ') { break; }
    80025830:	00a4c783          	lbu	a5,10(s1)
    80025834:	02000713          	li	a4,32
    80025838:	00e78563          	beq	a5,a4,80025842 <read_entry_name+0xb0>
            buffer[i] = d->sne.name[j];
    8002583c:	96ca                	add	a3,a3,s2
    8002583e:	00f68023          	sb	a5,0(a3)
        }
    }
}
    80025842:	70a2                	ld	ra,40(sp)
    80025844:	7402                	ld	s0,32(sp)
    80025846:	64e2                	ld	s1,24(sp)
    80025848:	6942                	ld	s2,16(sp)
    8002584a:	6145                	addi	sp,sp,48
    8002584c:	8082                	ret
        memmove(temp, d->lne.name1, sizeof(temp));
    8002584e:	4629                	li	a2,10
    80025850:	0585                	addi	a1,a1,1
    80025852:	fd040513          	addi	a0,s0,-48
    80025856:	ffffb097          	auipc	ra,0xffffb
    8002585a:	f72080e7          	jalr	-142(ra) # 800207c8 <memmove>
        snstr(buffer, temp, NELEM(d->lne.name1));
    8002585e:	4615                	li	a2,5
    80025860:	fd040593          	addi	a1,s0,-48
    80025864:	854a                	mv	a0,s2
    80025866:	ffffb097          	auipc	ra,0xffffb
    8002586a:	10c080e7          	jalr	268(ra) # 80020972 <snstr>
        snstr(buffer, d->lne.name2, NELEM(d->lne.name2));
    8002586e:	4619                	li	a2,6
    80025870:	00e48593          	addi	a1,s1,14
    80025874:	00590513          	addi	a0,s2,5 # 10000005 <BASE_ADDRESS-0x7001fffb>
    80025878:	ffffb097          	auipc	ra,0xffffb
    8002587c:	0fa080e7          	jalr	250(ra) # 80020972 <snstr>
        snstr(buffer, d->lne.name3, NELEM(d->lne.name3));
    80025880:	4609                	li	a2,2
    80025882:	01c48593          	addi	a1,s1,28
    80025886:	00b90513          	addi	a0,s2,11
    8002588a:	ffffb097          	auipc	ra,0xffffb
    8002588e:	0e8080e7          	jalr	232(ra) # 80020972 <snstr>
    80025892:	bf45                	j	80025842 <read_entry_name+0xb0>
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    80025894:	4681                	li	a3,0
    80025896:	bf91                	j	800257ea <read_entry_name+0x58>

0000000080025898 <fat32_init>:
{
    80025898:	7139                	addi	sp,sp,-64
    8002589a:	fc06                	sd	ra,56(sp)
    8002589c:	f822                	sd	s0,48(sp)
    8002589e:	f426                	sd	s1,40(sp)
    800258a0:	f04a                	sd	s2,32(sp)
    800258a2:	ec4e                	sd	s3,24(sp)
    800258a4:	e852                	sd	s4,16(sp)
    800258a6:	e456                	sd	s5,8(sp)
    800258a8:	0080                	addi	s0,sp,64
    struct buf *b = bread(0, 0);
    800258aa:	4581                	li	a1,0
    800258ac:	4501                	li	a0,0
    800258ae:	ffffe097          	auipc	ra,0xffffe
    800258b2:	c12080e7          	jalr	-1006(ra) # 800234c0 <bread>
    800258b6:	892a                	mv	s2,a0
    if (strncmp((char const*)(b->data + 82), "FAT32", 5))
    800258b8:	4615                	li	a2,5
    800258ba:	00007597          	auipc	a1,0x7
    800258be:	e7e58593          	addi	a1,a1,-386 # 8002c738 <sysnames+0x7b8>
    800258c2:	0aa50513          	addi	a0,a0,170
    800258c6:	ffffb097          	auipc	ra,0xffffb
    800258ca:	f7e080e7          	jalr	-130(ra) # 80020844 <strncmp>
    800258ce:	16051863          	bnez	a0,80025a3e <fat32_init+0x1a6>
    memmove(&fat.bpb.byts_per_sec, b->data + 11, 2);            // avoid misaligned load on k210
    800258d2:	0001c497          	auipc	s1,0x1c
    800258d6:	b5648493          	addi	s1,s1,-1194 # 80041428 <fat>
    800258da:	4609                	li	a2,2
    800258dc:	06390593          	addi	a1,s2,99
    800258e0:	0001c517          	auipc	a0,0x1c
    800258e4:	b5850513          	addi	a0,a0,-1192 # 80041438 <fat+0x10>
    800258e8:	ffffb097          	auipc	ra,0xffffb
    800258ec:	ee0080e7          	jalr	-288(ra) # 800207c8 <memmove>
    fat.bpb.sec_per_clus = *(b->data + 13);
    800258f0:	06594683          	lbu	a3,101(s2)
    800258f4:	00d48923          	sb	a3,18(s1)
    fat.bpb.rsvd_sec_cnt = *(uint16 *)(b->data + 14);
    800258f8:	06695603          	lhu	a2,102(s2)
    800258fc:	00c49a23          	sh	a2,20(s1)
    fat.bpb.fat_cnt = *(b->data + 16);
    80025900:	06894703          	lbu	a4,104(s2)
    80025904:	00e48b23          	sb	a4,22(s1)
    fat.bpb.hidd_sec = *(uint32 *)(b->data + 28);
    80025908:	07492783          	lw	a5,116(s2)
    8002590c:	cc9c                	sw	a5,24(s1)
    fat.bpb.tot_sec = *(uint32 *)(b->data + 32);
    8002590e:	07892783          	lw	a5,120(s2)
    80025912:	ccdc                	sw	a5,28(s1)
    fat.bpb.fat_sz = *(uint32 *)(b->data + 36);
    80025914:	07c92583          	lw	a1,124(s2)
    80025918:	d08c                	sw	a1,32(s1)
    fat.bpb.root_clus = *(uint32 *)(b->data + 44);
    8002591a:	08492503          	lw	a0,132(s2)
    8002591e:	d0c8                	sw	a0,36(s1)
    fat.first_data_sec = fat.bpb.rsvd_sec_cnt + fat.bpb.fat_cnt * fat.bpb.fat_sz;
    80025920:	02b7073b          	mulw	a4,a4,a1
    80025924:	9f31                	addw	a4,a4,a2
    80025926:	c098                	sw	a4,0(s1)
    fat.data_sec_cnt = fat.bpb.tot_sec - fat.first_data_sec;
    80025928:	9f99                	subw	a5,a5,a4
    8002592a:	c0dc                	sw	a5,4(s1)
    fat.data_clus_cnt = fat.data_sec_cnt / fat.bpb.sec_per_clus;
    8002592c:	02d7d7bb          	divuw	a5,a5,a3
    80025930:	c49c                	sw	a5,8(s1)
    fat.byts_per_clus = fat.bpb.sec_per_clus * fat.bpb.byts_per_sec;
    80025932:	0104d783          	lhu	a5,16(s1)
    80025936:	02d787bb          	mulw	a5,a5,a3
    8002593a:	c4dc                	sw	a5,12(s1)
    brelse(b);
    8002593c:	854a                	mv	a0,s2
    8002593e:	ffffe097          	auipc	ra,0xffffe
    80025942:	cc0080e7          	jalr	-832(ra) # 800235fe <brelse>
    if (BSIZE != fat.bpb.byts_per_sec) 
    80025946:	0104d703          	lhu	a4,16(s1)
    8002594a:	20000793          	li	a5,512
    8002594e:	10f71063          	bne	a4,a5,80025a4e <fat32_init+0x1b6>
    initlock(&ecache.lock, "ecache");
    80025952:	00007597          	auipc	a1,0x7
    80025956:	e1e58593          	addi	a1,a1,-482 # 8002c770 <sysnames+0x7f0>
    8002595a:	0001c517          	auipc	a0,0x1c
    8002595e:	c5e50513          	addi	a0,a0,-930 # 800415b8 <ecache>
    80025962:	ffffb097          	auipc	ra,0xffffb
    80025966:	d1a080e7          	jalr	-742(ra) # 8002067c <initlock>
    memset(&root, 0, sizeof(root));
    8002596a:	0001c497          	auipc	s1,0x1c
    8002596e:	abe48493          	addi	s1,s1,-1346 # 80041428 <fat>
    80025972:	0001c917          	auipc	s2,0x1c
    80025976:	ade90913          	addi	s2,s2,-1314 # 80041450 <root>
    8002597a:	16800613          	li	a2,360
    8002597e:	4581                	li	a1,0
    80025980:	854a                	mv	a0,s2
    80025982:	ffffb097          	auipc	ra,0xffffb
    80025986:	dda080e7          	jalr	-550(ra) # 8002075c <memset>
    initsleeplock(&root.lock, "entry");
    8002598a:	00007597          	auipc	a1,0x7
    8002598e:	dee58593          	addi	a1,a1,-530 # 8002c778 <sysnames+0x7f8>
    80025992:	0001c517          	auipc	a0,0x1c
    80025996:	bf650513          	addi	a0,a0,-1034 # 80041588 <root+0x138>
    8002599a:	ffffe097          	auipc	ra,0xffffe
    8002599e:	d7a080e7          	jalr	-646(ra) # 80023714 <initsleeplock>
    root.attribute = (ATTR_DIRECTORY | ATTR_SYSTEM);
    800259a2:	47d1                	li	a5,20
    800259a4:	12f48423          	sb	a5,296(s1)
    root.first_clus = root.cur_clus = fat.bpb.root_clus;
    800259a8:	50dc                	lw	a5,36(s1)
    800259aa:	12f4aa23          	sw	a5,308(s1)
    800259ae:	12f4a623          	sw	a5,300(s1)
    root.valid = 1;
    800259b2:	4785                	li	a5,1
    800259b4:	12f49f23          	sh	a5,318(s1)
    root.prev = &root;
    800259b8:	1524bc23          	sd	s2,344(s1)
    root.next = &root;
    800259bc:	1524b823          	sd	s2,336(s1)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    800259c0:	0001c497          	auipc	s1,0x1c
    800259c4:	c1048493          	addi	s1,s1,-1008 # 800415d0 <ecache+0x18>
        de->next = root.next;
    800259c8:	0001c917          	auipc	s2,0x1c
    800259cc:	a6090913          	addi	s2,s2,-1440 # 80041428 <fat>
        de->prev = &root;
    800259d0:	0001ca97          	auipc	s5,0x1c
    800259d4:	a80a8a93          	addi	s5,s5,-1408 # 80041450 <root>
        initsleeplock(&de->lock, "entry");
    800259d8:	00007a17          	auipc	s4,0x7
    800259dc:	da0a0a13          	addi	s4,s4,-608 # 8002c778 <sysnames+0x7f8>
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    800259e0:	00020997          	auipc	s3,0x20
    800259e4:	24098993          	addi	s3,s3,576 # 80045c20 <cons>
        de->dev = 0;
    800259e8:	10048a23          	sb	zero,276(s1)
        de->valid = 0;
    800259ec:	10049b23          	sh	zero,278(s1)
        de->ref = 0;
    800259f0:	1004ac23          	sw	zero,280(s1)
        de->dirty = 0;
    800259f4:	10048aa3          	sb	zero,277(s1)
        de->parent = 0;
    800259f8:	1204b023          	sd	zero,288(s1)
        de->next = root.next;
    800259fc:	15093783          	ld	a5,336(s2)
    80025a00:	12f4b423          	sd	a5,296(s1)
        de->prev = &root;
    80025a04:	1354b823          	sd	s5,304(s1)
        initsleeplock(&de->lock, "entry");
    80025a08:	85d2                	mv	a1,s4
    80025a0a:	13848513          	addi	a0,s1,312
    80025a0e:	ffffe097          	auipc	ra,0xffffe
    80025a12:	d06080e7          	jalr	-762(ra) # 80023714 <initsleeplock>
        root.next->prev = de;
    80025a16:	15093783          	ld	a5,336(s2)
    80025a1a:	1297b823          	sd	s1,304(a5)
        root.next = de;
    80025a1e:	14993823          	sd	s1,336(s2)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    80025a22:	16848493          	addi	s1,s1,360
    80025a26:	fd3491e3          	bne	s1,s3,800259e8 <fat32_init+0x150>
}
    80025a2a:	4501                	li	a0,0
    80025a2c:	70e2                	ld	ra,56(sp)
    80025a2e:	7442                	ld	s0,48(sp)
    80025a30:	74a2                	ld	s1,40(sp)
    80025a32:	7902                	ld	s2,32(sp)
    80025a34:	69e2                	ld	s3,24(sp)
    80025a36:	6a42                	ld	s4,16(sp)
    80025a38:	6aa2                	ld	s5,8(sp)
    80025a3a:	6121                	addi	sp,sp,64
    80025a3c:	8082                	ret
        panic("not FAT32 volume");
    80025a3e:	00007517          	auipc	a0,0x7
    80025a42:	d0250513          	addi	a0,a0,-766 # 8002c740 <sysnames+0x7c0>
    80025a46:	ffffa097          	auipc	ra,0xffffa
    80025a4a:	700080e7          	jalr	1792(ra) # 80020146 <panic>
        panic("byts_per_sec != BSIZE");
    80025a4e:	00007517          	auipc	a0,0x7
    80025a52:	d0a50513          	addi	a0,a0,-758 # 8002c758 <sysnames+0x7d8>
    80025a56:	ffffa097          	auipc	ra,0xffffa
    80025a5a:	6f0080e7          	jalr	1776(ra) # 80020146 <panic>

0000000080025a5e <eread>:
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025a5e:	10852783          	lw	a5,264(a0)
    80025a62:	0ed7e863          	bltu	a5,a3,80025b52 <eread+0xf4>
{
    80025a66:	711d                	addi	sp,sp,-96
    80025a68:	ec86                	sd	ra,88(sp)
    80025a6a:	e8a2                	sd	s0,80(sp)
    80025a6c:	e4a6                	sd	s1,72(sp)
    80025a6e:	e0ca                	sd	s2,64(sp)
    80025a70:	fc4e                	sd	s3,56(sp)
    80025a72:	f852                	sd	s4,48(sp)
    80025a74:	f456                	sd	s5,40(sp)
    80025a76:	f05a                	sd	s6,32(sp)
    80025a78:	ec5e                	sd	s7,24(sp)
    80025a7a:	e862                	sd	s8,16(sp)
    80025a7c:	e466                	sd	s9,8(sp)
    80025a7e:	e06a                	sd	s10,0(sp)
    80025a80:	1080                	addi	s0,sp,96
    80025a82:	8a2a                	mv	s4,a0
    80025a84:	8bae                	mv	s7,a1
    80025a86:	8ab2                	mv	s5,a2
    80025a88:	8936                	mv	s2,a3
    80025a8a:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025a8c:	9eb9                	addw	a3,a3,a4
        return 0;
    80025a8e:	4501                	li	a0,0
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025a90:	0b26e163          	bltu	a3,s2,80025b32 <eread+0xd4>
    80025a94:	100a4703          	lbu	a4,256(s4)
    80025a98:	8b41                	andi	a4,a4,16
    80025a9a:	ef41                	bnez	a4,80025b32 <eread+0xd4>
    if (off + n > entry->file_size) {
    80025a9c:	00d7f463          	bgeu	a5,a3,80025aa4 <eread+0x46>
        n = entry->file_size - off;
    80025aa0:	41278b3b          	subw	s6,a5,s2
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025aa4:	10ca2703          	lw	a4,268(s4)
    80025aa8:	100007b7          	lui	a5,0x10000
    80025aac:	17dd                	addi	a5,a5,-9
    80025aae:	06e7ef63          	bltu	a5,a4,80025b2c <eread+0xce>
    80025ab2:	080b0e63          	beqz	s6,80025b4e <eread+0xf0>
    80025ab6:	4981                	li	s3,0
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025ab8:	0001cc97          	auipc	s9,0x1c
    80025abc:	970c8c93          	addi	s9,s9,-1680 # 80041428 <fat>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025ac0:	8c3e                	mv	s8,a5
    80025ac2:	a82d                	j	80025afc <eread+0x9e>
    80025ac4:	00048d1b          	sext.w	s10,s1
        if (rw_clus(entry->cur_clus, 0, user_dst, dst, off % fat.byts_per_clus, m) != m) {
    80025ac8:	87ea                	mv	a5,s10
    80025aca:	86d6                	mv	a3,s5
    80025acc:	865e                	mv	a2,s7
    80025ace:	4581                	li	a1,0
    80025ad0:	10ca2503          	lw	a0,268(s4)
    80025ad4:	00000097          	auipc	ra,0x0
    80025ad8:	a4e080e7          	jalr	-1458(ra) # 80025522 <rw_clus>
    80025adc:	2501                	sext.w	a0,a0
    80025ade:	05a51863          	bne	a0,s10,80025b2e <eread+0xd0>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025ae2:	013489bb          	addw	s3,s1,s3
    80025ae6:	0124893b          	addw	s2,s1,s2
    80025aea:	1482                	slli	s1,s1,0x20
    80025aec:	9081                	srli	s1,s1,0x20
    80025aee:	9aa6                	add	s5,s5,s1
    80025af0:	10ca2783          	lw	a5,268(s4)
    80025af4:	02fc6d63          	bltu	s8,a5,80025b2e <eread+0xd0>
    80025af8:	0369fb63          	bgeu	s3,s6,80025b2e <eread+0xd0>
        reloc_clus(entry, off, 0);
    80025afc:	4601                	li	a2,0
    80025afe:	85ca                	mv	a1,s2
    80025b00:	8552                	mv	a0,s4
    80025b02:	00000097          	auipc	ra,0x0
    80025b06:	90e080e7          	jalr	-1778(ra) # 80025410 <reloc_clus>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025b0a:	00cca783          	lw	a5,12(s9)
    80025b0e:	02f976bb          	remuw	a3,s2,a5
    80025b12:	0006871b          	sext.w	a4,a3
    80025b16:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    80025b18:	413b06bb          	subw	a3,s6,s3
    80025b1c:	84b6                	mv	s1,a3
    80025b1e:	2681                	sext.w	a3,a3
    80025b20:	0007861b          	sext.w	a2,a5
    80025b24:	fad670e3          	bgeu	a2,a3,80025ac4 <eread+0x66>
    80025b28:	84be                	mv	s1,a5
    80025b2a:	bf69                	j	80025ac4 <eread+0x66>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025b2c:	4981                	li	s3,0
    return tot;
    80025b2e:	0009851b          	sext.w	a0,s3
}
    80025b32:	60e6                	ld	ra,88(sp)
    80025b34:	6446                	ld	s0,80(sp)
    80025b36:	64a6                	ld	s1,72(sp)
    80025b38:	6906                	ld	s2,64(sp)
    80025b3a:	79e2                	ld	s3,56(sp)
    80025b3c:	7a42                	ld	s4,48(sp)
    80025b3e:	7aa2                	ld	s5,40(sp)
    80025b40:	7b02                	ld	s6,32(sp)
    80025b42:	6be2                	ld	s7,24(sp)
    80025b44:	6c42                	ld	s8,16(sp)
    80025b46:	6ca2                	ld	s9,8(sp)
    80025b48:	6d02                	ld	s10,0(sp)
    80025b4a:	6125                	addi	sp,sp,96
    80025b4c:	8082                	ret
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025b4e:	89da                	mv	s3,s6
    80025b50:	bff9                	j	80025b2e <eread+0xd0>
        return 0;
    80025b52:	4501                	li	a0,0
}
    80025b54:	8082                	ret

0000000080025b56 <ewrite>:
    if (off > entry->file_size || off + n < off || (uint64)off + n > 0xffffffff
    80025b56:	10852783          	lw	a5,264(a0)
    80025b5a:	0ed7e363          	bltu	a5,a3,80025c40 <ewrite+0xea>
{
    80025b5e:	711d                	addi	sp,sp,-96
    80025b60:	ec86                	sd	ra,88(sp)
    80025b62:	e8a2                	sd	s0,80(sp)
    80025b64:	e4a6                	sd	s1,72(sp)
    80025b66:	e0ca                	sd	s2,64(sp)
    80025b68:	fc4e                	sd	s3,56(sp)
    80025b6a:	f852                	sd	s4,48(sp)
    80025b6c:	f456                	sd	s5,40(sp)
    80025b6e:	f05a                	sd	s6,32(sp)
    80025b70:	ec5e                	sd	s7,24(sp)
    80025b72:	e862                	sd	s8,16(sp)
    80025b74:	e466                	sd	s9,8(sp)
    80025b76:	1080                	addi	s0,sp,96
    80025b78:	8aaa                	mv	s5,a0
    80025b7a:	8bae                	mv	s7,a1
    80025b7c:	8a32                	mv	s4,a2
    80025b7e:	8936                	mv	s2,a3
    80025b80:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (uint64)off + n > 0xffffffff
    80025b82:	00e687bb          	addw	a5,a3,a4
    80025b86:	0ad7ef63          	bltu	a5,a3,80025c44 <ewrite+0xee>
    80025b8a:	02069793          	slli	a5,a3,0x20
    80025b8e:	9381                	srli	a5,a5,0x20
    80025b90:	1702                	slli	a4,a4,0x20
    80025b92:	9301                	srli	a4,a4,0x20
    80025b94:	97ba                	add	a5,a5,a4
    80025b96:	577d                	li	a4,-1
    80025b98:	9301                	srli	a4,a4,0x20
    80025b9a:	0af76763          	bltu	a4,a5,80025c48 <ewrite+0xf2>
        || (entry->attribute & ATTR_READ_ONLY)) {
    80025b9e:	10054783          	lbu	a5,256(a0)
    80025ba2:	8b85                	andi	a5,a5,1
    80025ba4:	e7c5                	bnez	a5,80025c4c <ewrite+0xf6>
    if (entry->first_clus == 0) {   // so file_size if 0 too, which requests off == 0
    80025ba6:	10452783          	lw	a5,260(a0)
    80025baa:	cb91                	beqz	a5,80025bbe <ewrite+0x68>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025bac:	4981                	li	s3,0
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025bae:	0001cc17          	auipc	s8,0x1c
    80025bb2:	87ac0c13          	addi	s8,s8,-1926 # 80041428 <fat>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025bb6:	040b1d63          	bnez	s6,80025c10 <ewrite+0xba>
    80025bba:	89da                	mv	s3,s6
    80025bbc:	a05d                	j	80025c62 <ewrite+0x10c>
        entry->cur_clus = entry->first_clus = alloc_clus(entry->dev);
    80025bbe:	11454503          	lbu	a0,276(a0)
    80025bc2:	fffff097          	auipc	ra,0xfffff
    80025bc6:	688080e7          	jalr	1672(ra) # 8002524a <alloc_clus>
    80025bca:	2501                	sext.w	a0,a0
    80025bcc:	10aaa223          	sw	a0,260(s5)
    80025bd0:	10aaa623          	sw	a0,268(s5)
        entry->clus_cnt = 0;
    80025bd4:	100aa823          	sw	zero,272(s5)
        entry->dirty = 1;
    80025bd8:	4785                	li	a5,1
    80025bda:	10fa8aa3          	sb	a5,277(s5)
    80025bde:	b7f9                	j	80025bac <ewrite+0x56>
    80025be0:	00048c9b          	sext.w	s9,s1
        if (rw_clus(entry->cur_clus, 1, user_src, src, off % fat.byts_per_clus, m) != m) {
    80025be4:	87e6                	mv	a5,s9
    80025be6:	86d2                	mv	a3,s4
    80025be8:	865e                	mv	a2,s7
    80025bea:	4585                	li	a1,1
    80025bec:	10caa503          	lw	a0,268(s5)
    80025bf0:	00000097          	auipc	ra,0x0
    80025bf4:	932080e7          	jalr	-1742(ra) # 80025522 <rw_clus>
    80025bf8:	2501                	sext.w	a0,a0
    80025bfa:	04ac9b63          	bne	s9,a0,80025c50 <ewrite+0xfa>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025bfe:	013489bb          	addw	s3,s1,s3
    80025c02:	0124893b          	addw	s2,s1,s2
    80025c06:	1482                	slli	s1,s1,0x20
    80025c08:	9081                	srli	s1,s1,0x20
    80025c0a:	9a26                	add	s4,s4,s1
    80025c0c:	0569f263          	bgeu	s3,s6,80025c50 <ewrite+0xfa>
        reloc_clus(entry, off, 1);
    80025c10:	4605                	li	a2,1
    80025c12:	85ca                	mv	a1,s2
    80025c14:	8556                	mv	a0,s5
    80025c16:	fffff097          	auipc	ra,0xfffff
    80025c1a:	7fa080e7          	jalr	2042(ra) # 80025410 <reloc_clus>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025c1e:	00cc2783          	lw	a5,12(s8)
    80025c22:	02f976bb          	remuw	a3,s2,a5
    80025c26:	0006871b          	sext.w	a4,a3
    80025c2a:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    80025c2c:	413b06bb          	subw	a3,s6,s3
    80025c30:	84b6                	mv	s1,a3
    80025c32:	2681                	sext.w	a3,a3
    80025c34:	0007861b          	sext.w	a2,a5
    80025c38:	fad674e3          	bgeu	a2,a3,80025be0 <ewrite+0x8a>
    80025c3c:	84be                	mv	s1,a5
    80025c3e:	b74d                	j	80025be0 <ewrite+0x8a>
        return -1;
    80025c40:	557d                	li	a0,-1
}
    80025c42:	8082                	ret
        return -1;
    80025c44:	557d                	li	a0,-1
    80025c46:	a005                	j	80025c66 <ewrite+0x110>
    80025c48:	557d                	li	a0,-1
    80025c4a:	a831                	j	80025c66 <ewrite+0x110>
    80025c4c:	557d                	li	a0,-1
    80025c4e:	a821                	j	80025c66 <ewrite+0x110>
        if(off > entry->file_size) {
    80025c50:	108aa783          	lw	a5,264(s5)
    80025c54:	0127f763          	bgeu	a5,s2,80025c62 <ewrite+0x10c>
            entry->file_size = off;
    80025c58:	112aa423          	sw	s2,264(s5)
            entry->dirty = 1;
    80025c5c:	4785                	li	a5,1
    80025c5e:	10fa8aa3          	sb	a5,277(s5)
    return tot;
    80025c62:	0009851b          	sext.w	a0,s3
}
    80025c66:	60e6                	ld	ra,88(sp)
    80025c68:	6446                	ld	s0,80(sp)
    80025c6a:	64a6                	ld	s1,72(sp)
    80025c6c:	6906                	ld	s2,64(sp)
    80025c6e:	79e2                	ld	s3,56(sp)
    80025c70:	7a42                	ld	s4,48(sp)
    80025c72:	7aa2                	ld	s5,40(sp)
    80025c74:	7b02                	ld	s6,32(sp)
    80025c76:	6be2                	ld	s7,24(sp)
    80025c78:	6c42                	ld	s8,16(sp)
    80025c7a:	6ca2                	ld	s9,8(sp)
    80025c7c:	6125                	addi	sp,sp,96
    80025c7e:	8082                	ret

0000000080025c80 <formatname>:
{
    80025c80:	7179                	addi	sp,sp,-48
    80025c82:	f406                	sd	ra,40(sp)
    80025c84:	f022                	sd	s0,32(sp)
    80025c86:	ec26                	sd	s1,24(sp)
    80025c88:	e84a                	sd	s2,16(sp)
    80025c8a:	e44e                	sd	s3,8(sp)
    80025c8c:	e052                	sd	s4,0(sp)
    80025c8e:	1800                	addi	s0,sp,48
    80025c90:	84aa                	mv	s1,a0
    while (*name == ' ' || *name == '.') { name++; }
    80025c92:	02000793          	li	a5,32
    80025c96:	02e00713          	li	a4,46
    80025c9a:	a011                	j	80025c9e <formatname+0x1e>
    80025c9c:	0485                	addi	s1,s1,1
    80025c9e:	0004c583          	lbu	a1,0(s1)
    80025ca2:	fef58de3          	beq	a1,a5,80025c9c <formatname+0x1c>
    80025ca6:	fee58be3          	beq	a1,a4,80025c9c <formatname+0x1c>
    for (p = name; *p; p++) {
    80025caa:	c5b9                	beqz	a1,80025cf8 <formatname+0x78>
        if (c < 0x20 || strchr(illegal, c)) {
    80025cac:	47fd                	li	a5,31
    80025cae:	04b7f763          	bgeu	a5,a1,80025cfc <formatname+0x7c>
    80025cb2:	8926                	mv	s2,s1
    80025cb4:	00009997          	auipc	s3,0x9
    80025cb8:	eac98993          	addi	s3,s3,-340 # 8002eb60 <illegal.1655>
    80025cbc:	4a7d                	li	s4,31
    80025cbe:	854e                	mv	a0,s3
    80025cc0:	ffffb097          	auipc	ra,0xffffb
    80025cc4:	d30080e7          	jalr	-720(ra) # 800209f0 <strchr>
    80025cc8:	ed05                	bnez	a0,80025d00 <formatname+0x80>
    for (p = name; *p; p++) {
    80025cca:	0905                	addi	s2,s2,1
    80025ccc:	00094583          	lbu	a1,0(s2)
    80025cd0:	c581                	beqz	a1,80025cd8 <formatname+0x58>
        if (c < 0x20 || strchr(illegal, c)) {
    80025cd2:	feba66e3          	bltu	s4,a1,80025cbe <formatname+0x3e>
    80025cd6:	a035                	j	80025d02 <formatname+0x82>
        if (*p != ' ') {
    80025cd8:	02000693          	li	a3,32
    80025cdc:	874a                	mv	a4,s2
    while (p-- > name) {
    80025cde:	0124fb63          	bgeu	s1,s2,80025cf4 <formatname+0x74>
        if (*p != ' ') {
    80025ce2:	197d                	addi	s2,s2,-1
    80025ce4:	00094783          	lbu	a5,0(s2)
    80025ce8:	fed78ae3          	beq	a5,a3,80025cdc <formatname+0x5c>
            p[1] = '\0';
    80025cec:	00070023          	sb	zero,0(a4)
            break;
    80025cf0:	8526                	mv	a0,s1
    80025cf2:	a801                	j	80025d02 <formatname+0x82>
    80025cf4:	8526                	mv	a0,s1
    80025cf6:	a031                	j	80025d02 <formatname+0x82>
    for (p = name; *p; p++) {
    80025cf8:	8526                	mv	a0,s1
    80025cfa:	a021                	j	80025d02 <formatname+0x82>
            return 0;
    80025cfc:	4501                	li	a0,0
    80025cfe:	a011                	j	80025d02 <formatname+0x82>
    80025d00:	4501                	li	a0,0
}
    80025d02:	70a2                	ld	ra,40(sp)
    80025d04:	7402                	ld	s0,32(sp)
    80025d06:	64e2                	ld	s1,24(sp)
    80025d08:	6942                	ld	s2,16(sp)
    80025d0a:	69a2                	ld	s3,8(sp)
    80025d0c:	6a02                	ld	s4,0(sp)
    80025d0e:	6145                	addi	sp,sp,48
    80025d10:	8082                	ret

0000000080025d12 <cal_checksum>:
{
    80025d12:	1141                	addi	sp,sp,-16
    80025d14:	e422                	sd	s0,8(sp)
    80025d16:	0800                	addi	s0,sp,16
    for (int i = CHAR_SHORT_NAME; i != 0; i--) {
    80025d18:	00b50613          	addi	a2,a0,11
    uint8 sum = 0;
    80025d1c:	4781                	li	a5,0
        sum = ((sum & 1) ? 0x80 : 0) + (sum >> 1) + *shortname++;
    80025d1e:	0077971b          	slliw	a4,a5,0x7
    80025d22:	0505                	addi	a0,a0,1
    80025d24:	0017d79b          	srliw	a5,a5,0x1
    80025d28:	fff54683          	lbu	a3,-1(a0)
    80025d2c:	9fb5                	addw	a5,a5,a3
    80025d2e:	97ba                	add	a5,a5,a4
    80025d30:	0ff7f793          	andi	a5,a5,255
    for (int i = CHAR_SHORT_NAME; i != 0; i--) {
    80025d34:	fea615e3          	bne	a2,a0,80025d1e <cal_checksum+0xc>
}
    80025d38:	853e                	mv	a0,a5
    80025d3a:	6422                	ld	s0,8(sp)
    80025d3c:	0141                	addi	sp,sp,16
    80025d3e:	8082                	ret

0000000080025d40 <emake>:
{
    80025d40:	7171                	addi	sp,sp,-176
    80025d42:	f506                	sd	ra,168(sp)
    80025d44:	f122                	sd	s0,160(sp)
    80025d46:	ed26                	sd	s1,152(sp)
    80025d48:	e94a                	sd	s2,144(sp)
    80025d4a:	e54e                	sd	s3,136(sp)
    80025d4c:	e152                	sd	s4,128(sp)
    80025d4e:	fcd6                	sd	s5,120(sp)
    80025d50:	f8da                	sd	s6,112(sp)
    80025d52:	f4de                	sd	s7,104(sp)
    80025d54:	f0e2                	sd	s8,96(sp)
    80025d56:	ece6                	sd	s9,88(sp)
    80025d58:	e8ea                	sd	s10,80(sp)
    80025d5a:	e4ee                	sd	s11,72(sp)
    80025d5c:	1900                	addi	s0,sp,176
    if (!(dp->attribute & ATTR_DIRECTORY))
    80025d5e:	10054783          	lbu	a5,256(a0)
    80025d62:	8bc1                	andi	a5,a5,16
    80025d64:	c3d5                	beqz	a5,80025e08 <emake+0xc8>
    80025d66:	89aa                	mv	s3,a0
    80025d68:	8aae                	mv	s5,a1
    80025d6a:	8932                	mv	s2,a2
    if (off % sizeof(union dentry))
    80025d6c:	01f67793          	andi	a5,a2,31
    80025d70:	e7c5                	bnez	a5,80025e18 <emake+0xd8>
    memset(&de, 0, sizeof(de));
    80025d72:	02000613          	li	a2,32
    80025d76:	4581                	li	a1,0
    80025d78:	f7040513          	addi	a0,s0,-144
    80025d7c:	ffffb097          	auipc	ra,0xffffb
    80025d80:	9e0080e7          	jalr	-1568(ra) # 8002075c <memset>
    if (off <= 32) {
    80025d84:	02000793          	li	a5,32
    80025d88:	0b27ec63          	bltu	a5,s2,80025e40 <emake+0x100>
        if (off == 0) {
    80025d8c:	08091e63          	bnez	s2,80025e28 <emake+0xe8>
            strncpy(de.sne.name, ".          ", sizeof(de.sne.name));
    80025d90:	462d                	li	a2,11
    80025d92:	00007597          	auipc	a1,0x7
    80025d96:	a1658593          	addi	a1,a1,-1514 # 8002c7a8 <sysnames+0x828>
    80025d9a:	f7040513          	addi	a0,s0,-144
    80025d9e:	ffffb097          	auipc	ra,0xffffb
    80025da2:	af6080e7          	jalr	-1290(ra) # 80020894 <strncpy>
        de.sne.attr = ATTR_DIRECTORY;
    80025da6:	47c1                	li	a5,16
    80025da8:	f6f40da3          	sb	a5,-133(s0)
        de.sne.fst_clus_hi = (uint16)(ep->first_clus >> 16);        // first clus high 16 bits
    80025dac:	104aa783          	lw	a5,260(s5)
    80025db0:	0107d71b          	srliw	a4,a5,0x10
    80025db4:	f8e41223          	sh	a4,-124(s0)
        de.sne.fst_clus_lo = (uint16)(ep->first_clus & 0xffff);       // low 16 bits
    80025db8:	f8f41523          	sh	a5,-118(s0)
        de.sne.file_size = 0;                                       // filesize is updated in eupdate()
    80025dbc:	f8042623          	sw	zero,-116(s0)
        off = reloc_clus(dp, off, 1);
    80025dc0:	4605                	li	a2,1
    80025dc2:	85ca                	mv	a1,s2
    80025dc4:	854e                	mv	a0,s3
    80025dc6:	fffff097          	auipc	ra,0xfffff
    80025dca:	64a080e7          	jalr	1610(ra) # 80025410 <reloc_clus>
        rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    80025dce:	02000793          	li	a5,32
    80025dd2:	0005071b          	sext.w	a4,a0
    80025dd6:	f7040693          	addi	a3,s0,-144
    80025dda:	4601                	li	a2,0
    80025ddc:	4585                	li	a1,1
    80025dde:	10c9a503          	lw	a0,268(s3)
    80025de2:	fffff097          	auipc	ra,0xfffff
    80025de6:	740080e7          	jalr	1856(ra) # 80025522 <rw_clus>
}
    80025dea:	70aa                	ld	ra,168(sp)
    80025dec:	740a                	ld	s0,160(sp)
    80025dee:	64ea                	ld	s1,152(sp)
    80025df0:	694a                	ld	s2,144(sp)
    80025df2:	69aa                	ld	s3,136(sp)
    80025df4:	6a0a                	ld	s4,128(sp)
    80025df6:	7ae6                	ld	s5,120(sp)
    80025df8:	7b46                	ld	s6,112(sp)
    80025dfa:	7ba6                	ld	s7,104(sp)
    80025dfc:	7c06                	ld	s8,96(sp)
    80025dfe:	6ce6                	ld	s9,88(sp)
    80025e00:	6d46                	ld	s10,80(sp)
    80025e02:	6da6                	ld	s11,72(sp)
    80025e04:	614d                	addi	sp,sp,176
    80025e06:	8082                	ret
        panic("emake: not dir");
    80025e08:	00007517          	auipc	a0,0x7
    80025e0c:	97850513          	addi	a0,a0,-1672 # 8002c780 <sysnames+0x800>
    80025e10:	ffffa097          	auipc	ra,0xffffa
    80025e14:	336080e7          	jalr	822(ra) # 80020146 <panic>
        panic("emake: not aligned");
    80025e18:	00007517          	auipc	a0,0x7
    80025e1c:	97850513          	addi	a0,a0,-1672 # 8002c790 <sysnames+0x810>
    80025e20:	ffffa097          	auipc	ra,0xffffa
    80025e24:	326080e7          	jalr	806(ra) # 80020146 <panic>
            strncpy(de.sne.name, "..         ", sizeof(de.sne.name));
    80025e28:	462d                	li	a2,11
    80025e2a:	00007597          	auipc	a1,0x7
    80025e2e:	98e58593          	addi	a1,a1,-1650 # 8002c7b8 <sysnames+0x838>
    80025e32:	f7040513          	addi	a0,s0,-144
    80025e36:	ffffb097          	auipc	ra,0xffffb
    80025e3a:	a5e080e7          	jalr	-1442(ra) # 80020894 <strncpy>
    80025e3e:	b7a5                	j	80025da6 <emake+0x66>
        int entcnt = (strlen(ep->filename) + CHAR_LONG_NAME - 1) / CHAR_LONG_NAME;   // count of l-n-entries, rounds up
    80025e40:	8cd6                	mv	s9,s5
    80025e42:	8556                	mv	a0,s5
    80025e44:	ffffb097          	auipc	ra,0xffffb
    80025e48:	ac2080e7          	jalr	-1342(ra) # 80020906 <strlen>
    80025e4c:	f4a43c23          	sd	a0,-168(s0)
    80025e50:	00c5071b          	addiw	a4,a0,12
    80025e54:	47b5                	li	a5,13
    80025e56:	02f747bb          	divw	a5,a4,a5
    80025e5a:	f4f42a23          	sw	a5,-172(s0)
    80025e5e:	00078b1b          	sext.w	s6,a5
        memset(shortname, 0, sizeof(shortname));
    80025e62:	4631                	li	a2,12
    80025e64:	4581                	li	a1,0
    80025e66:	f6040513          	addi	a0,s0,-160
    80025e6a:	ffffb097          	auipc	ra,0xffffb
    80025e6e:	8f2080e7          	jalr	-1806(ra) # 8002075c <memset>
    for (int j = strlen(name) - 1; j >= 0; j--) {
    80025e72:	8556                	mv	a0,s5
    80025e74:	ffffb097          	auipc	ra,0xffffb
    80025e78:	a92080e7          	jalr	-1390(ra) # 80020906 <strlen>
    80025e7c:	fff5079b          	addiw	a5,a0,-1
    80025e80:	0207cf63          	bltz	a5,80025ebe <emake+0x17e>
        if (name[j] == '.') {
    80025e84:	00fa8733          	add	a4,s5,a5
    80025e88:	00074603          	lbu	a2,0(a4)
    80025e8c:	02e00693          	li	a3,46
    80025e90:	04d60363          	beq	a2,a3,80025ed6 <emake+0x196>
    80025e94:	17fd                	addi	a5,a5,-1
    80025e96:	97d6                	add	a5,a5,s5
    80025e98:	ffea8693          	addi	a3,s5,-2
    80025e9c:	96aa                	add	a3,a3,a0
    80025e9e:	fff5071b          	addiw	a4,a0,-1
    80025ea2:	1702                	slli	a4,a4,0x20
    80025ea4:	9301                	srli	a4,a4,0x20
    80025ea6:	8e99                	sub	a3,a3,a4
    80025ea8:	02e00613          	li	a2,46
    for (int j = strlen(name) - 1; j >= 0; j--) {
    80025eac:	00d78963          	beq	a5,a3,80025ebe <emake+0x17e>
        if (name[j] == '.') {
    80025eb0:	85be                	mv	a1,a5
    80025eb2:	17fd                	addi	a5,a5,-1
    80025eb4:	0017c703          	lbu	a4,1(a5) # 10000001 <BASE_ADDRESS-0x7001ffff>
    80025eb8:	fec71ae3          	bne	a4,a2,80025eac <emake+0x16c>
    80025ebc:	8cae                	mv	s9,a1
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025ebe:	001a8b93          	addi	s7,s5,1
    80025ec2:	000aca03          	lbu	s4,0(s5)
    80025ec6:	4481                	li	s1,0
    80025ec8:	000a0963          	beqz	s4,80025eda <emake+0x19a>
        if (i == 8 && p) {
    80025ecc:	4c21                	li	s8,8
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025ece:	4d29                	li	s10,10
        if (c == '.') {
    80025ed0:	02e00d93          	li	s11,46
    80025ed4:	a0e1                	j	80025f9c <emake+0x25c>
        if (name[j] == '.') {
    80025ed6:	8cba                	mv	s9,a4
    80025ed8:	b7dd                	j	80025ebe <emake+0x17e>
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025eda:	4481                	li	s1,0
    80025edc:	a039                	j	80025eea <emake+0x1aa>
        if (i == 8 && p) {
    80025ede:	1e0c8963          	beqz	s9,800260d0 <emake+0x390>
            if (p + 1 < name) { break; }            // no '.'
    80025ee2:	001c8793          	addi	a5,s9,1
    80025ee6:	0777fd63          	bgeu	a5,s7,80025f60 <emake+0x220>
    80025eea:	f6040793          	addi	a5,s0,-160
    80025eee:	97a6                	add	a5,a5,s1
        shortname[i++] = ' ';
    80025ef0:	02000693          	li	a3,32
    while (i < CHAR_SHORT_NAME) {
    80025ef4:	4729                	li	a4,10
        shortname[i++] = ' ';
    80025ef6:	2485                	addiw	s1,s1,1
    80025ef8:	00d78023          	sb	a3,0(a5)
    80025efc:	0785                	addi	a5,a5,1
    while (i < CHAR_SHORT_NAME) {
    80025efe:	fe975ce3          	bge	a4,s1,80025ef6 <emake+0x1b6>
        de.lne.checksum = cal_checksum((uchar *)shortname);
    80025f02:	f6040513          	addi	a0,s0,-160
    80025f06:	00000097          	auipc	ra,0x0
    80025f0a:	e0c080e7          	jalr	-500(ra) # 80025d12 <cal_checksum>
    80025f0e:	f6a40ea3          	sb	a0,-131(s0)
        de.lne.attr = ATTR_LONG_NAME;
    80025f12:	47bd                	li	a5,15
    80025f14:	f6f40da3          	sb	a5,-133(s0)
        for (int i = entcnt; i > 0; i--) {
    80025f18:	f5843783          	ld	a5,-168(s0)
    80025f1c:	0cf05363          	blez	a5,80025fe2 <emake+0x2a2>
    80025f20:	f5442783          	lw	a5,-172(s0)
    80025f24:	37fd                	addiw	a5,a5,-1
    80025f26:	00179c1b          	slliw	s8,a5,0x1
    80025f2a:	00fc0c3b          	addw	s8,s8,a5
    80025f2e:	002c1c1b          	slliw	s8,s8,0x2
    80025f32:	00fc0c3b          	addw	s8,s8,a5
    80025f36:	9c56                	add	s8,s8,s5
    80025f38:	8bda                	mv	s7,s6
            int end = 0;
    80025f3a:	4c81                	li	s9,0
                    *w++ = 0xff;            // on k210, unaligned reading is illegal
    80025f3c:	5a7d                	li	s4,-1
                switch (j) {
    80025f3e:	44ad                	li	s1,11
    80025f40:	aa8d                	j	800260b2 <emake+0x372>
            if (name > p) {                    // last '.'
    80025f42:	057cf463          	bgeu	s9,s7,80025f8a <emake+0x24a>
                memset(shortname + i, ' ', 8 - i);
    80025f46:	4621                	li	a2,8
    80025f48:	9e05                	subw	a2,a2,s1
    80025f4a:	02000593          	li	a1,32
    80025f4e:	f6040793          	addi	a5,s0,-160
    80025f52:	00978533          	add	a0,a5,s1
    80025f56:	ffffb097          	auipc	ra,0xffffb
    80025f5a:	806080e7          	jalr	-2042(ra) # 8002075c <memset>
    80025f5e:	87de                	mv	a5,s7
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025f60:	84e2                	mv	s1,s8
    80025f62:	4c81                	li	s9,0
    80025f64:	a035                	j	80025f90 <emake+0x250>
            if (strchr(illegal, c) != NULL) {
    80025f66:	85d2                	mv	a1,s4
    80025f68:	00009517          	auipc	a0,0x9
    80025f6c:	c1050513          	addi	a0,a0,-1008 # 8002eb78 <illegal.1671>
    80025f70:	ffffb097          	auipc	ra,0xffffb
    80025f74:	a80080e7          	jalr	-1408(ra) # 800209f0 <strchr>
    80025f78:	c119                	beqz	a0,80025f7e <emake+0x23e>
                c = '_';
    80025f7a:	05f00a13          	li	s4,95
        shortname[i++] = c;
    80025f7e:	f9040793          	addi	a5,s0,-112
    80025f82:	97a6                	add	a5,a5,s1
    80025f84:	fd478823          	sb	s4,-48(a5)
    80025f88:	2485                	addiw	s1,s1,1
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025f8a:	f69d4ce3          	blt	s10,s1,80025f02 <emake+0x1c2>
    80025f8e:	87de                	mv	a5,s7
    80025f90:	00178b93          	addi	s7,a5,1
    80025f94:	0007ca03          	lbu	s4,0(a5)
    80025f98:	f40a09e3          	beqz	s4,80025eea <emake+0x1aa>
        if (i == 8 && p) {
    80025f9c:	f58481e3          	beq	s1,s8,80025ede <emake+0x19e>
        if (c == ' ') { continue; }
    80025fa0:	02000793          	li	a5,32
    80025fa4:	fefa03e3          	beq	s4,a5,80025f8a <emake+0x24a>
        if (c == '.') {
    80025fa8:	f9ba0de3          	beq	s4,s11,80025f42 <emake+0x202>
        if (c >= 'a' && c <= 'z') {
    80025fac:	f9fa079b          	addiw	a5,s4,-97
    80025fb0:	0ff7f793          	andi	a5,a5,255
    80025fb4:	4765                	li	a4,25
    80025fb6:	faf768e3          	bltu	a4,a5,80025f66 <emake+0x226>
            c += 'A' - 'a';
    80025fba:	3a01                	addiw	s4,s4,-32
    80025fbc:	0ffa7a13          	andi	s4,s4,255
    80025fc0:	bf7d                	j	80025f7e <emake+0x23e>
                de.lne.order |= LAST_LONG_ENTRY;
    80025fc2:	0407e793          	ori	a5,a5,64
    80025fc6:	f6f40823          	sb	a5,-144(s0)
    80025fca:	a8d5                	j	800260be <emake+0x37e>
                    if ((*w++ = *p++) == 0) {
    80025fcc:	0005c683          	lbu	a3,0(a1)
    80025fd0:	00d78023          	sb	a3,0(a5)
                        end = 1;
    80025fd4:	0016b693          	seqz	a3,a3
                    *w++ = 0;
    80025fd8:	000780a3          	sb	zero,1(a5)
    80025fdc:	0789                	addi	a5,a5,2
                    if ((*w++ = *p++) == 0) {
    80025fde:	0585                	addi	a1,a1,1
    80025fe0:	a079                	j	8002606e <emake+0x32e>
        memset(&de, 0, sizeof(de));
    80025fe2:	02000613          	li	a2,32
    80025fe6:	4581                	li	a1,0
    80025fe8:	f7040513          	addi	a0,s0,-144
    80025fec:	ffffa097          	auipc	ra,0xffffa
    80025ff0:	770080e7          	jalr	1904(ra) # 8002075c <memset>
        strncpy(de.sne.name, shortname, sizeof(de.sne.name));
    80025ff4:	462d                	li	a2,11
    80025ff6:	f6040593          	addi	a1,s0,-160
    80025ffa:	f7040513          	addi	a0,s0,-144
    80025ffe:	ffffb097          	auipc	ra,0xffffb
    80026002:	896080e7          	jalr	-1898(ra) # 80020894 <strncpy>
        de.sne.attr = ep->attribute;
    80026006:	100ac783          	lbu	a5,256(s5)
    8002600a:	f6f40da3          	sb	a5,-133(s0)
        de.sne.fst_clus_hi = (uint16)(ep->first_clus >> 16);      // first clus high 16 bits
    8002600e:	104aa783          	lw	a5,260(s5)
    80026012:	0107d71b          	srliw	a4,a5,0x10
    80026016:	f8e41223          	sh	a4,-124(s0)
        de.sne.fst_clus_lo = (uint16)(ep->first_clus & 0xffff);     // low 16 bits
    8002601a:	f8f41523          	sh	a5,-118(s0)
        de.sne.file_size = ep->file_size;                         // filesize is updated in eupdate()
    8002601e:	108aa783          	lw	a5,264(s5)
    80026022:	f8f42623          	sw	a5,-116(s0)
        off = reloc_clus(dp, off, 1);
    80026026:	4605                	li	a2,1
    80026028:	85ca                	mv	a1,s2
    8002602a:	854e                	mv	a0,s3
    8002602c:	fffff097          	auipc	ra,0xfffff
    80026030:	3e4080e7          	jalr	996(ra) # 80025410 <reloc_clus>
        rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    80026034:	02000793          	li	a5,32
    80026038:	0005071b          	sext.w	a4,a0
    8002603c:	f7040693          	addi	a3,s0,-144
    80026040:	4601                	li	a2,0
    80026042:	4585                	li	a1,1
    80026044:	10c9a503          	lw	a0,268(s3)
    80026048:	fffff097          	auipc	ra,0xfffff
    8002604c:	4da080e7          	jalr	1242(ra) # 80025522 <rw_clus>
}
    80026050:	bb69                	j	80025dea <emake+0xaa>
                    case 5:     w = (uint8 *)de.lne.name2; break;
    80026052:	f7e40793          	addi	a5,s0,-130
    80026056:	a019                	j	8002605c <emake+0x31c>
                    case 11:    w = (uint8 *)de.lne.name3; break;
    80026058:	f8c40793          	addi	a5,s0,-116
    8002605c:	2705                	addiw	a4,a4,1
    8002605e:	fff7061b          	addiw	a2,a4,-1
                if (end) {
    80026062:	d6ad                	beqz	a3,80025fcc <emake+0x28c>
                    *w++ = 0xff;            // on k210, unaligned reading is illegal
    80026064:	01478023          	sb	s4,0(a5)
                    *w++ = 0xff;
    80026068:	014780a3          	sb	s4,1(a5)
    8002606c:	0789                	addi	a5,a5,2
                switch (j) {
    8002606e:	fea602e3          	beq	a2,a0,80026052 <emake+0x312>
    80026072:	fe9603e3          	beq	a2,s1,80026058 <emake+0x318>
            for (int j = 1; j <= CHAR_LONG_NAME; j++) {
    80026076:	0007061b          	sext.w	a2,a4
    8002607a:	fec851e3          	bge	a6,a2,8002605c <emake+0x31c>
            uint off2 = reloc_clus(dp, off, 1);
    8002607e:	4605                	li	a2,1
    80026080:	85ca                	mv	a1,s2
    80026082:	854e                	mv	a0,s3
    80026084:	fffff097          	auipc	ra,0xfffff
    80026088:	38c080e7          	jalr	908(ra) # 80025410 <reloc_clus>
            rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off2, sizeof(de));
    8002608c:	02000793          	li	a5,32
    80026090:	0005071b          	sext.w	a4,a0
    80026094:	f7040693          	addi	a3,s0,-144
    80026098:	8666                	mv	a2,s9
    8002609a:	4585                	li	a1,1
    8002609c:	10c9a503          	lw	a0,268(s3)
    800260a0:	fffff097          	auipc	ra,0xfffff
    800260a4:	482080e7          	jalr	1154(ra) # 80025522 <rw_clus>
            off += sizeof(de);
    800260a8:	0209091b          	addiw	s2,s2,32
    800260ac:	1c4d                	addi	s8,s8,-13
        for (int i = entcnt; i > 0; i--) {
    800260ae:	f3705ae3          	blez	s7,80025fe2 <emake+0x2a2>
            if ((de.lne.order = i) == entcnt) {
    800260b2:	0ffbf793          	andi	a5,s7,255
    800260b6:	f0fb06e3          	beq	s6,a5,80025fc2 <emake+0x282>
    800260ba:	f6f40823          	sb	a5,-144(s0)
            char *p = ep->filename + (i - 1) * CHAR_LONG_NAME;
    800260be:	3bfd                	addiw	s7,s7,-1
    800260c0:	85e2                	mv	a1,s8
    800260c2:	4709                	li	a4,2
            int end = 0;
    800260c4:	86e6                	mv	a3,s9
            uint8 *w = (uint8 *)de.lne.name1;
    800260c6:	f7140793          	addi	a5,s0,-143
                switch (j) {
    800260ca:	4515                	li	a0,5
            for (int j = 1; j <= CHAR_LONG_NAME; j++) {
    800260cc:	4835                	li	a6,13
    800260ce:	bf41                	j	8002605e <emake+0x31e>
        if (c == ' ') { continue; }
    800260d0:	02000793          	li	a5,32
    800260d4:	ecfa1ae3          	bne	s4,a5,80025fa8 <emake+0x268>
    800260d8:	87de                	mv	a5,s7
    800260da:	bd5d                	j	80025f90 <emake+0x250>

00000000800260dc <edup>:
{
    800260dc:	1101                	addi	sp,sp,-32
    800260de:	ec06                	sd	ra,24(sp)
    800260e0:	e822                	sd	s0,16(sp)
    800260e2:	e426                	sd	s1,8(sp)
    800260e4:	1000                	addi	s0,sp,32
    800260e6:	84aa                	mv	s1,a0
    if (entry != 0) {
    800260e8:	c515                	beqz	a0,80026114 <edup+0x38>
        acquire(&ecache.lock);
    800260ea:	0001b517          	auipc	a0,0x1b
    800260ee:	4ce50513          	addi	a0,a0,1230 # 800415b8 <ecache>
    800260f2:	ffffa097          	auipc	ra,0xffffa
    800260f6:	5ce080e7          	jalr	1486(ra) # 800206c0 <acquire>
        entry->ref++;
    800260fa:	1184a783          	lw	a5,280(s1)
    800260fe:	2785                	addiw	a5,a5,1
    80026100:	10f4ac23          	sw	a5,280(s1)
        release(&ecache.lock);
    80026104:	0001b517          	auipc	a0,0x1b
    80026108:	4b450513          	addi	a0,a0,1204 # 800415b8 <ecache>
    8002610c:	ffffa097          	auipc	ra,0xffffa
    80026110:	608080e7          	jalr	1544(ra) # 80020714 <release>
}
    80026114:	8526                	mv	a0,s1
    80026116:	60e2                	ld	ra,24(sp)
    80026118:	6442                	ld	s0,16(sp)
    8002611a:	64a2                	ld	s1,8(sp)
    8002611c:	6105                	addi	sp,sp,32
    8002611e:	8082                	ret

0000000080026120 <eupdate>:
    if (!entry->dirty || entry->valid != 1) { return; }
    80026120:	11554783          	lbu	a5,277(a0)
    80026124:	c791                	beqz	a5,80026130 <eupdate+0x10>
    80026126:	11651703          	lh	a4,278(a0)
    8002612a:	4785                	li	a5,1
    8002612c:	00f70363          	beq	a4,a5,80026132 <eupdate+0x12>
    80026130:	8082                	ret
{
    80026132:	715d                	addi	sp,sp,-80
    80026134:	e486                	sd	ra,72(sp)
    80026136:	e0a2                	sd	s0,64(sp)
    80026138:	fc26                	sd	s1,56(sp)
    8002613a:	f84a                	sd	s2,48(sp)
    8002613c:	0880                	addi	s0,sp,80
    8002613e:	84aa                	mv	s1,a0
    uint entcnt = 0;
    80026140:	fc042e23          	sw	zero,-36(s0)
    uint32 off = reloc_clus(entry->parent, entry->off, 0);
    80026144:	4601                	li	a2,0
    80026146:	11c52583          	lw	a1,284(a0)
    8002614a:	12053503          	ld	a0,288(a0)
    8002614e:	fffff097          	auipc	ra,0xfffff
    80026152:	2c2080e7          	jalr	706(ra) # 80025410 <reloc_clus>
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64) &entcnt, off, 1);
    80026156:	1204b803          	ld	a6,288(s1)
    8002615a:	4785                	li	a5,1
    8002615c:	0005071b          	sext.w	a4,a0
    80026160:	fdc40693          	addi	a3,s0,-36
    80026164:	4601                	li	a2,0
    80026166:	4581                	li	a1,0
    80026168:	10c82503          	lw	a0,268(a6)
    8002616c:	fffff097          	auipc	ra,0xfffff
    80026170:	3b6080e7          	jalr	950(ra) # 80025522 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    80026174:	fdc42583          	lw	a1,-36(s0)
    80026178:	fbf5f593          	andi	a1,a1,-65
    8002617c:	fcb42e23          	sw	a1,-36(s0)
    off = reloc_clus(entry->parent, entry->off + (entcnt << 5), 0);
    80026180:	0055959b          	slliw	a1,a1,0x5
    80026184:	11c4a783          	lw	a5,284(s1)
    80026188:	4601                	li	a2,0
    8002618a:	9dbd                	addw	a1,a1,a5
    8002618c:	1204b503          	ld	a0,288(s1)
    80026190:	fffff097          	auipc	ra,0xfffff
    80026194:	280080e7          	jalr	640(ra) # 80025410 <reloc_clus>
    80026198:	0005091b          	sext.w	s2,a0
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64)&de, off, sizeof(de));
    8002619c:	1204b503          	ld	a0,288(s1)
    800261a0:	02000793          	li	a5,32
    800261a4:	874a                	mv	a4,s2
    800261a6:	fb840693          	addi	a3,s0,-72
    800261aa:	4601                	li	a2,0
    800261ac:	4581                	li	a1,0
    800261ae:	10c52503          	lw	a0,268(a0)
    800261b2:	fffff097          	auipc	ra,0xfffff
    800261b6:	370080e7          	jalr	880(ra) # 80025522 <rw_clus>
    de.sne.fst_clus_hi = (uint16)(entry->first_clus >> 16);
    800261ba:	1044a783          	lw	a5,260(s1)
    800261be:	0107d71b          	srliw	a4,a5,0x10
    800261c2:	fce41623          	sh	a4,-52(s0)
    de.sne.fst_clus_lo = (uint16)(entry->first_clus & 0xffff);
    800261c6:	fcf41923          	sh	a5,-46(s0)
    de.sne.file_size = entry->file_size;
    800261ca:	1084a783          	lw	a5,264(s1)
    800261ce:	fcf42a23          	sw	a5,-44(s0)
    rw_clus(entry->parent->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    800261d2:	1204b503          	ld	a0,288(s1)
    800261d6:	02000793          	li	a5,32
    800261da:	874a                	mv	a4,s2
    800261dc:	fb840693          	addi	a3,s0,-72
    800261e0:	4601                	li	a2,0
    800261e2:	4585                	li	a1,1
    800261e4:	10c52503          	lw	a0,268(a0)
    800261e8:	fffff097          	auipc	ra,0xfffff
    800261ec:	33a080e7          	jalr	826(ra) # 80025522 <rw_clus>
    entry->dirty = 0;
    800261f0:	10048aa3          	sb	zero,277(s1)
}
    800261f4:	60a6                	ld	ra,72(sp)
    800261f6:	6406                	ld	s0,64(sp)
    800261f8:	74e2                	ld	s1,56(sp)
    800261fa:	7942                	ld	s2,48(sp)
    800261fc:	6161                	addi	sp,sp,80
    800261fe:	8082                	ret

0000000080026200 <eremove>:
    if (entry->valid != 1) { return; }
    80026200:	11651703          	lh	a4,278(a0)
    80026204:	4785                	li	a5,1
    80026206:	00f70363          	beq	a4,a5,8002620c <eremove+0xc>
    8002620a:	8082                	ret
{
    8002620c:	7139                	addi	sp,sp,-64
    8002620e:	fc06                	sd	ra,56(sp)
    80026210:	f822                	sd	s0,48(sp)
    80026212:	f426                	sd	s1,40(sp)
    80026214:	f04a                	sd	s2,32(sp)
    80026216:	ec4e                	sd	s3,24(sp)
    80026218:	e852                	sd	s4,16(sp)
    8002621a:	0080                	addi	s0,sp,64
    8002621c:	84aa                	mv	s1,a0
    uint entcnt = 0;
    8002621e:	fc042623          	sw	zero,-52(s0)
    uint32 off = entry->off;
    80026222:	11c52903          	lw	s2,284(a0)
    uint32 off2 = reloc_clus(entry->parent, off, 0);
    80026226:	4601                	li	a2,0
    80026228:	85ca                	mv	a1,s2
    8002622a:	12053503          	ld	a0,288(a0)
    8002622e:	fffff097          	auipc	ra,0xfffff
    80026232:	1e2080e7          	jalr	482(ra) # 80025410 <reloc_clus>
    80026236:	0005099b          	sext.w	s3,a0
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64) &entcnt, off2, 1);
    8002623a:	1204b503          	ld	a0,288(s1)
    8002623e:	4785                	li	a5,1
    80026240:	874e                	mv	a4,s3
    80026242:	fcc40693          	addi	a3,s0,-52
    80026246:	4601                	li	a2,0
    80026248:	4581                	li	a1,0
    8002624a:	10c52503          	lw	a0,268(a0)
    8002624e:	fffff097          	auipc	ra,0xfffff
    80026252:	2d4080e7          	jalr	724(ra) # 80025522 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    80026256:	fcc42783          	lw	a5,-52(s0)
    8002625a:	fbf7f793          	andi	a5,a5,-65
    8002625e:	fcf42623          	sw	a5,-52(s0)
    uint8 flag = EMPTY_ENTRY;
    80026262:	5795                	li	a5,-27
    80026264:	fcf405a3          	sb	a5,-53(s0)
    for (int i = 0; i <= entcnt; i++) {
    80026268:	4a01                	li	s4,0
        rw_clus(entry->parent->cur_clus, 1, 0, (uint64) &flag, off2, 1);
    8002626a:	1204b503          	ld	a0,288(s1)
    8002626e:	4785                	li	a5,1
    80026270:	874e                	mv	a4,s3
    80026272:	fcb40693          	addi	a3,s0,-53
    80026276:	4601                	li	a2,0
    80026278:	4585                	li	a1,1
    8002627a:	10c52503          	lw	a0,268(a0)
    8002627e:	fffff097          	auipc	ra,0xfffff
    80026282:	2a4080e7          	jalr	676(ra) # 80025522 <rw_clus>
        off += 32;
    80026286:	0209091b          	addiw	s2,s2,32
        off2 = reloc_clus(entry->parent, off, 0);
    8002628a:	4601                	li	a2,0
    8002628c:	85ca                	mv	a1,s2
    8002628e:	1204b503          	ld	a0,288(s1)
    80026292:	fffff097          	auipc	ra,0xfffff
    80026296:	17e080e7          	jalr	382(ra) # 80025410 <reloc_clus>
    8002629a:	0005099b          	sext.w	s3,a0
    for (int i = 0; i <= entcnt; i++) {
    8002629e:	001a079b          	addiw	a5,s4,1
    800262a2:	00078a1b          	sext.w	s4,a5
    800262a6:	fcc42703          	lw	a4,-52(s0)
    800262aa:	fd4770e3          	bgeu	a4,s4,8002626a <eremove+0x6a>
    entry->valid = -1;
    800262ae:	57fd                	li	a5,-1
    800262b0:	10f49b23          	sh	a5,278(s1)
}
    800262b4:	70e2                	ld	ra,56(sp)
    800262b6:	7442                	ld	s0,48(sp)
    800262b8:	74a2                	ld	s1,40(sp)
    800262ba:	7902                	ld	s2,32(sp)
    800262bc:	69e2                	ld	s3,24(sp)
    800262be:	6a42                	ld	s4,16(sp)
    800262c0:	6121                	addi	sp,sp,64
    800262c2:	8082                	ret

00000000800262c4 <etrunc>:
{
    800262c4:	7179                	addi	sp,sp,-48
    800262c6:	f406                	sd	ra,40(sp)
    800262c8:	f022                	sd	s0,32(sp)
    800262ca:	ec26                	sd	s1,24(sp)
    800262cc:	e84a                	sd	s2,16(sp)
    800262ce:	e44e                	sd	s3,8(sp)
    800262d0:	e052                	sd	s4,0(sp)
    800262d2:	1800                	addi	s0,sp,48
    800262d4:	8a2a                	mv	s4,a0
    for (uint32 clus = entry->first_clus; clus >= 2 && clus < FAT32_EOC; ) {
    800262d6:	10452903          	lw	s2,260(a0)
    800262da:	ffe9071b          	addiw	a4,s2,-2
    800262de:	100007b7          	lui	a5,0x10000
    800262e2:	17d5                	addi	a5,a5,-11
    800262e4:	02e7e563          	bltu	a5,a4,8002630e <etrunc+0x4a>
    800262e8:	89be                	mv	s3,a5
        uint32 next = read_fat(clus);
    800262ea:	854a                	mv	a0,s2
    800262ec:	fffff097          	auipc	ra,0xfffff
    800262f0:	eec080e7          	jalr	-276(ra) # 800251d8 <read_fat>
    800262f4:	0005049b          	sext.w	s1,a0
    write_fat(cluster, 0);
    800262f8:	4581                	li	a1,0
    800262fa:	854a                	mv	a0,s2
    800262fc:	fffff097          	auipc	ra,0xfffff
    80026300:	096080e7          	jalr	150(ra) # 80025392 <write_fat>
        clus = next;
    80026304:	0004891b          	sext.w	s2,s1
    for (uint32 clus = entry->first_clus; clus >= 2 && clus < FAT32_EOC; ) {
    80026308:	34f9                	addiw	s1,s1,-2
    8002630a:	fe99f0e3          	bgeu	s3,s1,800262ea <etrunc+0x26>
    entry->file_size = 0;
    8002630e:	100a2423          	sw	zero,264(s4)
    entry->first_clus = 0;
    80026312:	100a2223          	sw	zero,260(s4)
    entry->dirty = 1;
    80026316:	4785                	li	a5,1
    80026318:	10fa0aa3          	sb	a5,277(s4)
}
    8002631c:	70a2                	ld	ra,40(sp)
    8002631e:	7402                	ld	s0,32(sp)
    80026320:	64e2                	ld	s1,24(sp)
    80026322:	6942                	ld	s2,16(sp)
    80026324:	69a2                	ld	s3,8(sp)
    80026326:	6a02                	ld	s4,0(sp)
    80026328:	6145                	addi	sp,sp,48
    8002632a:	8082                	ret

000000008002632c <elock>:
{
    8002632c:	1141                	addi	sp,sp,-16
    8002632e:	e406                	sd	ra,8(sp)
    80026330:	e022                	sd	s0,0(sp)
    80026332:	0800                	addi	s0,sp,16
    if (entry == 0 || entry->ref < 1)
    80026334:	cd19                	beqz	a0,80026352 <elock+0x26>
    80026336:	11852783          	lw	a5,280(a0)
    8002633a:	00f05c63          	blez	a5,80026352 <elock+0x26>
    acquiresleep(&entry->lock);
    8002633e:	13850513          	addi	a0,a0,312
    80026342:	ffffd097          	auipc	ra,0xffffd
    80026346:	40c080e7          	jalr	1036(ra) # 8002374e <acquiresleep>
}
    8002634a:	60a2                	ld	ra,8(sp)
    8002634c:	6402                	ld	s0,0(sp)
    8002634e:	0141                	addi	sp,sp,16
    80026350:	8082                	ret
        panic("elock");
    80026352:	00006517          	auipc	a0,0x6
    80026356:	47650513          	addi	a0,a0,1142 # 8002c7c8 <sysnames+0x848>
    8002635a:	ffffa097          	auipc	ra,0xffffa
    8002635e:	dec080e7          	jalr	-532(ra) # 80020146 <panic>

0000000080026362 <eunlock>:
{
    80026362:	1101                	addi	sp,sp,-32
    80026364:	ec06                	sd	ra,24(sp)
    80026366:	e822                	sd	s0,16(sp)
    80026368:	e426                	sd	s1,8(sp)
    8002636a:	e04a                	sd	s2,0(sp)
    8002636c:	1000                	addi	s0,sp,32
    if (entry == 0 || !holdingsleep(&entry->lock) || entry->ref < 1)
    8002636e:	c90d                	beqz	a0,800263a0 <eunlock+0x3e>
    80026370:	84aa                	mv	s1,a0
    80026372:	13850913          	addi	s2,a0,312
    80026376:	854a                	mv	a0,s2
    80026378:	ffffd097          	auipc	ra,0xffffd
    8002637c:	470080e7          	jalr	1136(ra) # 800237e8 <holdingsleep>
    80026380:	c105                	beqz	a0,800263a0 <eunlock+0x3e>
    80026382:	1184a783          	lw	a5,280(s1)
    80026386:	00f05d63          	blez	a5,800263a0 <eunlock+0x3e>
    releasesleep(&entry->lock);
    8002638a:	854a                	mv	a0,s2
    8002638c:	ffffd097          	auipc	ra,0xffffd
    80026390:	418080e7          	jalr	1048(ra) # 800237a4 <releasesleep>
}
    80026394:	60e2                	ld	ra,24(sp)
    80026396:	6442                	ld	s0,16(sp)
    80026398:	64a2                	ld	s1,8(sp)
    8002639a:	6902                	ld	s2,0(sp)
    8002639c:	6105                	addi	sp,sp,32
    8002639e:	8082                	ret
        panic("eunlock");
    800263a0:	00006517          	auipc	a0,0x6
    800263a4:	43050513          	addi	a0,a0,1072 # 8002c7d0 <sysnames+0x850>
    800263a8:	ffffa097          	auipc	ra,0xffffa
    800263ac:	d9e080e7          	jalr	-610(ra) # 80020146 <panic>

00000000800263b0 <eput>:
{
    800263b0:	1101                	addi	sp,sp,-32
    800263b2:	ec06                	sd	ra,24(sp)
    800263b4:	e822                	sd	s0,16(sp)
    800263b6:	e426                	sd	s1,8(sp)
    800263b8:	e04a                	sd	s2,0(sp)
    800263ba:	1000                	addi	s0,sp,32
    800263bc:	84aa                	mv	s1,a0
    acquire(&ecache.lock);
    800263be:	0001b517          	auipc	a0,0x1b
    800263c2:	1fa50513          	addi	a0,a0,506 # 800415b8 <ecache>
    800263c6:	ffffa097          	auipc	ra,0xffffa
    800263ca:	2fa080e7          	jalr	762(ra) # 800206c0 <acquire>
    if (entry != &root && entry->valid != 0 && entry->ref == 1) {
    800263ce:	0001b797          	auipc	a5,0x1b
    800263d2:	08278793          	addi	a5,a5,130 # 80041450 <root>
    800263d6:	00f48a63          	beq	s1,a5,800263ea <eput+0x3a>
    800263da:	11649783          	lh	a5,278(s1)
    800263de:	c791                	beqz	a5,800263ea <eput+0x3a>
    800263e0:	1184a703          	lw	a4,280(s1)
    800263e4:	4785                	li	a5,1
    800263e6:	02f70563          	beq	a4,a5,80026410 <eput+0x60>
    entry->ref--;
    800263ea:	1184a783          	lw	a5,280(s1)
    800263ee:	37fd                	addiw	a5,a5,-1
    800263f0:	10f4ac23          	sw	a5,280(s1)
    release(&ecache.lock);
    800263f4:	0001b517          	auipc	a0,0x1b
    800263f8:	1c450513          	addi	a0,a0,452 # 800415b8 <ecache>
    800263fc:	ffffa097          	auipc	ra,0xffffa
    80026400:	318080e7          	jalr	792(ra) # 80020714 <release>
}
    80026404:	60e2                	ld	ra,24(sp)
    80026406:	6442                	ld	s0,16(sp)
    80026408:	64a2                	ld	s1,8(sp)
    8002640a:	6902                	ld	s2,0(sp)
    8002640c:	6105                	addi	sp,sp,32
    8002640e:	8082                	ret
        acquiresleep(&entry->lock);
    80026410:	13848913          	addi	s2,s1,312
    80026414:	854a                	mv	a0,s2
    80026416:	ffffd097          	auipc	ra,0xffffd
    8002641a:	338080e7          	jalr	824(ra) # 8002374e <acquiresleep>
        entry->next->prev = entry->prev;
    8002641e:	1284b703          	ld	a4,296(s1)
    80026422:	1304b783          	ld	a5,304(s1)
    80026426:	12f73823          	sd	a5,304(a4)
        entry->prev->next = entry->next;
    8002642a:	1284b703          	ld	a4,296(s1)
    8002642e:	12e7b423          	sd	a4,296(a5)
        entry->next = root.next;
    80026432:	0001b797          	auipc	a5,0x1b
    80026436:	ff678793          	addi	a5,a5,-10 # 80041428 <fat>
    8002643a:	1507b703          	ld	a4,336(a5)
    8002643e:	12e4b423          	sd	a4,296(s1)
        entry->prev = &root;
    80026442:	0001b697          	auipc	a3,0x1b
    80026446:	00e68693          	addi	a3,a3,14 # 80041450 <root>
    8002644a:	12d4b823          	sd	a3,304(s1)
        root.next->prev = entry;
    8002644e:	12973823          	sd	s1,304(a4)
        root.next = entry;
    80026452:	1497b823          	sd	s1,336(a5)
        release(&ecache.lock);
    80026456:	0001b517          	auipc	a0,0x1b
    8002645a:	16250513          	addi	a0,a0,354 # 800415b8 <ecache>
    8002645e:	ffffa097          	auipc	ra,0xffffa
    80026462:	2b6080e7          	jalr	694(ra) # 80020714 <release>
        if (entry->valid == -1) {       // this means some one has called eremove()
    80026466:	11649703          	lh	a4,278(s1)
    8002646a:	57fd                	li	a5,-1
    8002646c:	06f70863          	beq	a4,a5,800264dc <eput+0x12c>
            elock(entry->parent);
    80026470:	1204b503          	ld	a0,288(s1)
    80026474:	00000097          	auipc	ra,0x0
    80026478:	eb8080e7          	jalr	-328(ra) # 8002632c <elock>
            eupdate(entry);
    8002647c:	8526                	mv	a0,s1
    8002647e:	00000097          	auipc	ra,0x0
    80026482:	ca2080e7          	jalr	-862(ra) # 80026120 <eupdate>
            eunlock(entry->parent);
    80026486:	1204b503          	ld	a0,288(s1)
    8002648a:	00000097          	auipc	ra,0x0
    8002648e:	ed8080e7          	jalr	-296(ra) # 80026362 <eunlock>
        releasesleep(&entry->lock);
    80026492:	854a                	mv	a0,s2
    80026494:	ffffd097          	auipc	ra,0xffffd
    80026498:	310080e7          	jalr	784(ra) # 800237a4 <releasesleep>
        struct dirent *eparent = entry->parent;
    8002649c:	1204b903          	ld	s2,288(s1)
        acquire(&ecache.lock);
    800264a0:	0001b517          	auipc	a0,0x1b
    800264a4:	11850513          	addi	a0,a0,280 # 800415b8 <ecache>
    800264a8:	ffffa097          	auipc	ra,0xffffa
    800264ac:	218080e7          	jalr	536(ra) # 800206c0 <acquire>
        entry->ref--;
    800264b0:	1184a783          	lw	a5,280(s1)
    800264b4:	37fd                	addiw	a5,a5,-1
    800264b6:	10f4ac23          	sw	a5,280(s1)
        release(&ecache.lock);
    800264ba:	0001b517          	auipc	a0,0x1b
    800264be:	0fe50513          	addi	a0,a0,254 # 800415b8 <ecache>
    800264c2:	ffffa097          	auipc	ra,0xffffa
    800264c6:	252080e7          	jalr	594(ra) # 80020714 <release>
        if (entry->ref == 0) {
    800264ca:	1184a783          	lw	a5,280(s1)
    800264ce:	fb9d                	bnez	a5,80026404 <eput+0x54>
            eput(eparent);
    800264d0:	854a                	mv	a0,s2
    800264d2:	00000097          	auipc	ra,0x0
    800264d6:	ede080e7          	jalr	-290(ra) # 800263b0 <eput>
    800264da:	b72d                	j	80026404 <eput+0x54>
            etrunc(entry);
    800264dc:	8526                	mv	a0,s1
    800264de:	00000097          	auipc	ra,0x0
    800264e2:	de6080e7          	jalr	-538(ra) # 800262c4 <etrunc>
    800264e6:	b775                	j	80026492 <eput+0xe2>

00000000800264e8 <estat>:
{
    800264e8:	1101                	addi	sp,sp,-32
    800264ea:	ec06                	sd	ra,24(sp)
    800264ec:	e822                	sd	s0,16(sp)
    800264ee:	e426                	sd	s1,8(sp)
    800264f0:	e04a                	sd	s2,0(sp)
    800264f2:	1000                	addi	s0,sp,32
    800264f4:	892a                	mv	s2,a0
    800264f6:	84ae                	mv	s1,a1
    strncpy(st->name, de->filename, STAT_MAX_NAME);
    800264f8:	02000613          	li	a2,32
    800264fc:	85aa                	mv	a1,a0
    800264fe:	8526                	mv	a0,s1
    80026500:	ffffa097          	auipc	ra,0xffffa
    80026504:	394080e7          	jalr	916(ra) # 80020894 <strncpy>
    st->type = (de->attribute & ATTR_DIRECTORY) ? T_DIR : T_FILE;
    80026508:	10094783          	lbu	a5,256(s2)
    8002650c:	8bc1                	andi	a5,a5,16
    8002650e:	0017b793          	seqz	a5,a5
    80026512:	0785                	addi	a5,a5,1
    80026514:	02f49423          	sh	a5,40(s1)
    st->dev = de->dev;
    80026518:	11494783          	lbu	a5,276(s2)
    8002651c:	d0dc                	sw	a5,36(s1)
    st->size = de->file_size;
    8002651e:	10896783          	lwu	a5,264(s2)
    80026522:	f89c                	sd	a5,48(s1)
}
    80026524:	60e2                	ld	ra,24(sp)
    80026526:	6442                	ld	s0,16(sp)
    80026528:	64a2                	ld	s1,8(sp)
    8002652a:	6902                	ld	s2,0(sp)
    8002652c:	6105                	addi	sp,sp,32
    8002652e:	8082                	ret

0000000080026530 <enext>:
 * @return  -1      meet the end of dir
 *          0       find empty slots
 *          1       find a file with all its entries
 */
int enext(struct dirent *dp, struct dirent *ep, uint off, int *count)
{
    80026530:	7119                	addi	sp,sp,-128
    80026532:	fc86                	sd	ra,120(sp)
    80026534:	f8a2                	sd	s0,112(sp)
    80026536:	f4a6                	sd	s1,104(sp)
    80026538:	f0ca                	sd	s2,96(sp)
    8002653a:	ecce                	sd	s3,88(sp)
    8002653c:	e8d2                	sd	s4,80(sp)
    8002653e:	e4d6                	sd	s5,72(sp)
    80026540:	e0da                	sd	s6,64(sp)
    80026542:	fc5e                	sd	s7,56(sp)
    80026544:	f862                	sd	s8,48(sp)
    80026546:	f466                	sd	s9,40(sp)
    80026548:	0100                	addi	s0,sp,128
    if (!(dp->attribute & ATTR_DIRECTORY))
    8002654a:	10054783          	lbu	a5,256(a0)
    8002654e:	8bc1                	andi	a5,a5,16
    80026550:	cf95                	beqz	a5,8002658c <enext+0x5c>
    80026552:	892a                	mv	s2,a0
    80026554:	8bae                	mv	s7,a1
    80026556:	84b2                	mv	s1,a2
    80026558:	8ab6                	mv	s5,a3
        panic("enext not dir");
    if (ep->valid)
    8002655a:	11659783          	lh	a5,278(a1)
    8002655e:	ef9d                	bnez	a5,8002659c <enext+0x6c>
        panic("enext ep valid");
    if (off % 32)
    80026560:	01f67793          	andi	a5,a2,31
    80026564:	e7a1                	bnez	a5,800265ac <enext+0x7c>
        panic("enext not align");
    if (dp->valid != 1) { return -1; }
    80026566:	11651703          	lh	a4,278(a0)
    8002656a:	4785                	li	a5,1
    8002656c:	557d                	li	a0,-1
    8002656e:	04f70763          	beq	a4,a5,800265bc <enext+0x8c>
            read_entry_info(ep, &de);
            return 1;
        }
    }
    return -1;
}
    80026572:	70e6                	ld	ra,120(sp)
    80026574:	7446                	ld	s0,112(sp)
    80026576:	74a6                	ld	s1,104(sp)
    80026578:	7906                	ld	s2,96(sp)
    8002657a:	69e6                	ld	s3,88(sp)
    8002657c:	6a46                	ld	s4,80(sp)
    8002657e:	6aa6                	ld	s5,72(sp)
    80026580:	6b06                	ld	s6,64(sp)
    80026582:	7be2                	ld	s7,56(sp)
    80026584:	7c42                	ld	s8,48(sp)
    80026586:	7ca2                	ld	s9,40(sp)
    80026588:	6109                	addi	sp,sp,128
    8002658a:	8082                	ret
        panic("enext not dir");
    8002658c:	00006517          	auipc	a0,0x6
    80026590:	24c50513          	addi	a0,a0,588 # 8002c7d8 <sysnames+0x858>
    80026594:	ffffa097          	auipc	ra,0xffffa
    80026598:	bb2080e7          	jalr	-1102(ra) # 80020146 <panic>
        panic("enext ep valid");
    8002659c:	00006517          	auipc	a0,0x6
    800265a0:	24c50513          	addi	a0,a0,588 # 8002c7e8 <sysnames+0x868>
    800265a4:	ffffa097          	auipc	ra,0xffffa
    800265a8:	ba2080e7          	jalr	-1118(ra) # 80020146 <panic>
        panic("enext not align");
    800265ac:	00006517          	auipc	a0,0x6
    800265b0:	24c50513          	addi	a0,a0,588 # 8002c7f8 <sysnames+0x878>
    800265b4:	ffffa097          	auipc	ra,0xffffa
    800265b8:	b92080e7          	jalr	-1134(ra) # 80020146 <panic>
    memset(ep->filename, 0, FAT32_MAX_FILENAME + 1);
    800265bc:	8cae                	mv	s9,a1
    800265be:	10000613          	li	a2,256
    800265c2:	4581                	li	a1,0
    800265c4:	855e                	mv	a0,s7
    800265c6:	ffffa097          	auipc	ra,0xffffa
    800265ca:	196080e7          	jalr	406(ra) # 8002075c <memset>
    int cnt = 0;
    800265ce:	4981                	li	s3,0
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    800265d0:	5a7d                	li	s4,-1
        if (de.lne.order == EMPTY_ENTRY) {
    800265d2:	0e500b13          	li	s6,229
        if (de.lne.attr == ATTR_LONG_NAME) {
    800265d6:	4c3d                	li	s8,15
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    800265d8:	a805                	j	80026608 <enext+0xd8>
            cnt++;
    800265da:	2985                	addiw	s3,s3,1
            continue;
    800265dc:	a025                	j	80026604 <enext+0xd4>
            *count = cnt;
    800265de:	013aa023          	sw	s3,0(s5)
            return 0;
    800265e2:	4501                	li	a0,0
    800265e4:	b779                	j	80026572 <enext+0x42>
            read_entry_name(ep->filename + (lcnt - 1) * CHAR_LONG_NAME, &de);
    800265e6:	fff5079b          	addiw	a5,a0,-1
    800265ea:	0017951b          	slliw	a0,a5,0x1
    800265ee:	9d3d                	addw	a0,a0,a5
    800265f0:	0025151b          	slliw	a0,a0,0x2
    800265f4:	9d3d                	addw	a0,a0,a5
    800265f6:	f8040593          	addi	a1,s0,-128
    800265fa:	9566                	add	a0,a0,s9
    800265fc:	fffff097          	auipc	ra,0xfffff
    80026600:	196080e7          	jalr	406(ra) # 80025792 <read_entry_name>
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    80026604:	0204849b          	addiw	s1,s1,32
    80026608:	4601                	li	a2,0
    8002660a:	85a6                	mv	a1,s1
    8002660c:	854a                	mv	a0,s2
    8002660e:	fffff097          	auipc	ra,0xfffff
    80026612:	e02080e7          	jalr	-510(ra) # 80025410 <reloc_clus>
    80026616:	f5450ee3          	beq	a0,s4,80026572 <enext+0x42>
        if (rw_clus(dp->cur_clus, 0, 0, (uint64)&de, off2, 32) != 32 || de.lne.order == END_OF_ENTRY) {
    8002661a:	02000793          	li	a5,32
    8002661e:	0005071b          	sext.w	a4,a0
    80026622:	f8040693          	addi	a3,s0,-128
    80026626:	4601                	li	a2,0
    80026628:	4581                	li	a1,0
    8002662a:	10c92503          	lw	a0,268(s2)
    8002662e:	fffff097          	auipc	ra,0xfffff
    80026632:	ef4080e7          	jalr	-268(ra) # 80025522 <rw_clus>
    80026636:	2501                	sext.w	a0,a0
    80026638:	02000793          	li	a5,32
    8002663c:	06f51c63          	bne	a0,a5,800266b4 <enext+0x184>
    80026640:	f8044783          	lbu	a5,-128(s0)
    80026644:	cbb5                	beqz	a5,800266b8 <enext+0x188>
        if (de.lne.order == EMPTY_ENTRY) {
    80026646:	f9678ae3          	beq	a5,s6,800265da <enext+0xaa>
        } else if (cnt) {
    8002664a:	f8099ae3          	bnez	s3,800265de <enext+0xae>
        if (de.lne.attr == ATTR_LONG_NAME) {
    8002664e:	f8b44703          	lbu	a4,-117(s0)
    80026652:	01871d63          	bne	a4,s8,8002666c <enext+0x13c>
            int lcnt = de.lne.order & ~LAST_LONG_ENTRY;
    80026656:	0bf7f513          	andi	a0,a5,191
            if (de.lne.order & LAST_LONG_ENTRY) {
    8002665a:	0407f793          	andi	a5,a5,64
    8002665e:	d7c1                	beqz	a5,800265e6 <enext+0xb6>
                *count = lcnt + 1;                              // plus the s-n-e;
    80026660:	0015079b          	addiw	a5,a0,1
    80026664:	00faa023          	sw	a5,0(s5)
                count = 0;
    80026668:	4a81                	li	s5,0
    8002666a:	bfb5                	j	800265e6 <enext+0xb6>
            if (count) {
    8002666c:	000a8c63          	beqz	s5,80026684 <enext+0x154>
                *count = 1;
    80026670:	4785                	li	a5,1
    80026672:	00faa023          	sw	a5,0(s5)
                read_entry_name(ep->filename, &de);
    80026676:	f8040593          	addi	a1,s0,-128
    8002667a:	855e                	mv	a0,s7
    8002667c:	fffff097          	auipc	ra,0xfffff
    80026680:	116080e7          	jalr	278(ra) # 80025792 <read_entry_name>
    entry->attribute = d->sne.attr;
    80026684:	f8b44783          	lbu	a5,-117(s0)
    80026688:	10fb8023          	sb	a5,256(s7) # fffffffffffff100 <kernel_end+0xffffffff7ffb9100>
    entry->first_clus = ((uint32)d->sne.fst_clus_hi << 16) | d->sne.fst_clus_lo;
    8002668c:	f9445783          	lhu	a5,-108(s0)
    80026690:	0107979b          	slliw	a5,a5,0x10
    80026694:	f9a45703          	lhu	a4,-102(s0)
    80026698:	8fd9                	or	a5,a5,a4
    8002669a:	2781                	sext.w	a5,a5
    8002669c:	10fba223          	sw	a5,260(s7)
    entry->file_size = d->sne.file_size;
    800266a0:	f9c42703          	lw	a4,-100(s0)
    800266a4:	10eba423          	sw	a4,264(s7)
    entry->cur_clus = entry->first_clus;
    800266a8:	10fba623          	sw	a5,268(s7)
    entry->clus_cnt = 0;
    800266ac:	100ba823          	sw	zero,272(s7)
            return 1;
    800266b0:	4505                	li	a0,1
    800266b2:	b5c1                	j	80026572 <enext+0x42>
            return -1;
    800266b4:	557d                	li	a0,-1
    800266b6:	bd75                	j	80026572 <enext+0x42>
    800266b8:	557d                	li	a0,-1
    800266ba:	bd65                	j	80026572 <enext+0x42>

00000000800266bc <dirlookup>:
 * @param   dp          entry of a directory file
 * @param   filename    target filename
 * @param   poff        offset of proper empty entry slots from the beginning of the dir
 */
struct dirent *dirlookup(struct dirent *dp, char *filename, uint *poff)
{
    800266bc:	715d                	addi	sp,sp,-80
    800266be:	e486                	sd	ra,72(sp)
    800266c0:	e0a2                	sd	s0,64(sp)
    800266c2:	fc26                	sd	s1,56(sp)
    800266c4:	f84a                	sd	s2,48(sp)
    800266c6:	f44e                	sd	s3,40(sp)
    800266c8:	f052                	sd	s4,32(sp)
    800266ca:	ec56                	sd	s5,24(sp)
    800266cc:	e85a                	sd	s6,16(sp)
    800266ce:	0880                	addi	s0,sp,80
    if (!(dp->attribute & ATTR_DIRECTORY))
    800266d0:	10054783          	lbu	a5,256(a0)
    800266d4:	8bc1                	andi	a5,a5,16
    800266d6:	cbb1                	beqz	a5,8002672a <dirlookup+0x6e>
    800266d8:	892a                	mv	s2,a0
    800266da:	89ae                	mv	s3,a1
    800266dc:	8b32                	mv	s6,a2
        panic("dirlookup not DIR");
    if (strncmp(filename, ".", FAT32_MAX_FILENAME) == 0) {
    800266de:	0ff00613          	li	a2,255
    800266e2:	00006597          	auipc	a1,0x6
    800266e6:	13e58593          	addi	a1,a1,318 # 8002c820 <sysnames+0x8a0>
    800266ea:	854e                	mv	a0,s3
    800266ec:	ffffa097          	auipc	ra,0xffffa
    800266f0:	158080e7          	jalr	344(ra) # 80020844 <strncmp>
    800266f4:	c139                	beqz	a0,8002673a <dirlookup+0x7e>
        return edup(dp);
    } else if (strncmp(filename, "..", FAT32_MAX_FILENAME) == 0) {
    800266f6:	0ff00613          	li	a2,255
    800266fa:	00006597          	auipc	a1,0x6
    800266fe:	12e58593          	addi	a1,a1,302 # 8002c828 <sysnames+0x8a8>
    80026702:	854e                	mv	a0,s3
    80026704:	ffffa097          	auipc	ra,0xffffa
    80026708:	140080e7          	jalr	320(ra) # 80020844 <strncmp>
    8002670c:	ed39                	bnez	a0,8002676a <dirlookup+0xae>
        if (dp == &root) {
    8002670e:	0001b797          	auipc	a5,0x1b
    80026712:	d4278793          	addi	a5,a5,-702 # 80041450 <root>
    80026716:	04f90363          	beq	s2,a5,8002675c <dirlookup+0xa0>
            return edup(&root);
        }
        return edup(dp->parent);
    8002671a:	12093503          	ld	a0,288(s2)
    8002671e:	00000097          	auipc	ra,0x0
    80026722:	9be080e7          	jalr	-1602(ra) # 800260dc <edup>
    80026726:	84aa                	mv	s1,a0
    80026728:	a839                	j	80026746 <dirlookup+0x8a>
        panic("dirlookup not DIR");
    8002672a:	00006517          	auipc	a0,0x6
    8002672e:	0de50513          	addi	a0,a0,222 # 8002c808 <sysnames+0x888>
    80026732:	ffffa097          	auipc	ra,0xffffa
    80026736:	a14080e7          	jalr	-1516(ra) # 80020146 <panic>
        return edup(dp);
    8002673a:	854a                	mv	a0,s2
    8002673c:	00000097          	auipc	ra,0x0
    80026740:	9a0080e7          	jalr	-1632(ra) # 800260dc <edup>
    80026744:	84aa                	mv	s1,a0
    if (poff) {
        *poff = off;
    }
    eput(ep);
    return NULL;
}
    80026746:	8526                	mv	a0,s1
    80026748:	60a6                	ld	ra,72(sp)
    8002674a:	6406                	ld	s0,64(sp)
    8002674c:	74e2                	ld	s1,56(sp)
    8002674e:	7942                	ld	s2,48(sp)
    80026750:	79a2                	ld	s3,40(sp)
    80026752:	7a02                	ld	s4,32(sp)
    80026754:	6ae2                	ld	s5,24(sp)
    80026756:	6b42                	ld	s6,16(sp)
    80026758:	6161                	addi	sp,sp,80
    8002675a:	8082                	ret
            return edup(&root);
    8002675c:	853e                	mv	a0,a5
    8002675e:	00000097          	auipc	ra,0x0
    80026762:	97e080e7          	jalr	-1666(ra) # 800260dc <edup>
    80026766:	84aa                	mv	s1,a0
    80026768:	bff9                	j	80026746 <dirlookup+0x8a>
    if (dp->valid != 1) {
    8002676a:	11691703          	lh	a4,278(s2)
    8002676e:	4785                	li	a5,1
        return NULL;
    80026770:	4481                	li	s1,0
    if (dp->valid != 1) {
    80026772:	fcf71ae3          	bne	a4,a5,80026746 <dirlookup+0x8a>
    struct dirent *ep = eget(dp, filename);
    80026776:	85ce                	mv	a1,s3
    80026778:	854a                	mv	a0,s2
    8002677a:	fffff097          	auipc	ra,0xfffff
    8002677e:	ef6080e7          	jalr	-266(ra) # 80025670 <eget>
    80026782:	84aa                	mv	s1,a0
    if (ep->valid == 1) { return ep; }                               // ecache hits
    80026784:	11651703          	lh	a4,278(a0)
    80026788:	4785                	li	a5,1
    8002678a:	faf70ee3          	beq	a4,a5,80026746 <dirlookup+0x8a>
    int len = strlen(filename);
    8002678e:	854e                	mv	a0,s3
    80026790:	ffffa097          	auipc	ra,0xffffa
    80026794:	176080e7          	jalr	374(ra) # 80020906 <strlen>
    int count = 0;
    80026798:	fa042e23          	sw	zero,-68(s0)
    reloc_clus(dp, 0, 0);
    8002679c:	4601                	li	a2,0
    8002679e:	4581                	li	a1,0
    800267a0:	854a                	mv	a0,s2
    800267a2:	fffff097          	auipc	ra,0xfffff
    800267a6:	c6e080e7          	jalr	-914(ra) # 80025410 <reloc_clus>
    uint off = 0;
    800267aa:	4a01                	li	s4,0
    while ((type = enext(dp, ep, off, &count) != -1)) {
    800267ac:	5afd                	li	s5,-1
    800267ae:	fbc40693          	addi	a3,s0,-68
    800267b2:	8652                	mv	a2,s4
    800267b4:	85a6                	mv	a1,s1
    800267b6:	854a                	mv	a0,s2
    800267b8:	00000097          	auipc	ra,0x0
    800267bc:	d78080e7          	jalr	-648(ra) # 80026530 <enext>
    800267c0:	03550f63          	beq	a0,s5,800267fe <dirlookup+0x142>
        } else if (strncmp(filename, ep->filename, FAT32_MAX_FILENAME) == 0) {
    800267c4:	0ff00613          	li	a2,255
    800267c8:	85a6                	mv	a1,s1
    800267ca:	854e                	mv	a0,s3
    800267cc:	ffffa097          	auipc	ra,0xffffa
    800267d0:	078080e7          	jalr	120(ra) # 80020844 <strncmp>
    800267d4:	c901                	beqz	a0,800267e4 <dirlookup+0x128>
        off += count << 5;
    800267d6:	fbc42783          	lw	a5,-68(s0)
    800267da:	0057979b          	slliw	a5,a5,0x5
    800267de:	01478a3b          	addw	s4,a5,s4
    800267e2:	b7f1                	j	800267ae <dirlookup+0xf2>
            ep->parent = edup(dp);
    800267e4:	854a                	mv	a0,s2
    800267e6:	00000097          	auipc	ra,0x0
    800267ea:	8f6080e7          	jalr	-1802(ra) # 800260dc <edup>
    800267ee:	12a4b023          	sd	a0,288(s1)
            ep->off = off;
    800267f2:	1144ae23          	sw	s4,284(s1)
            ep->valid = 1;
    800267f6:	4785                	li	a5,1
    800267f8:	10f49b23          	sh	a5,278(s1)
            return ep;
    800267fc:	b7a9                	j	80026746 <dirlookup+0x8a>
    if (poff) {
    800267fe:	000b0463          	beqz	s6,80026806 <dirlookup+0x14a>
        *poff = off;
    80026802:	014b2023          	sw	s4,0(s6)
    eput(ep);
    80026806:	8526                	mv	a0,s1
    80026808:	00000097          	auipc	ra,0x0
    8002680c:	ba8080e7          	jalr	-1112(ra) # 800263b0 <eput>
    return NULL;
    80026810:	4481                	li	s1,0
    80026812:	bf15                	j	80026746 <dirlookup+0x8a>

0000000080026814 <ealloc>:
{
    80026814:	7139                	addi	sp,sp,-64
    80026816:	fc06                	sd	ra,56(sp)
    80026818:	f822                	sd	s0,48(sp)
    8002681a:	f426                	sd	s1,40(sp)
    8002681c:	f04a                	sd	s2,32(sp)
    8002681e:	ec4e                	sd	s3,24(sp)
    80026820:	e852                	sd	s4,16(sp)
    80026822:	0080                	addi	s0,sp,64
    if (!(dp->attribute & ATTR_DIRECTORY)) {
    80026824:	10054783          	lbu	a5,256(a0)
    80026828:	8bc1                	andi	a5,a5,16
    8002682a:	c7b1                	beqz	a5,80026876 <ealloc+0x62>
    8002682c:	892a                	mv	s2,a0
    8002682e:	8a32                	mv	s4,a2
    if (dp->valid != 1 || !(name = formatname(name))) {        // detect illegal character
    80026830:	11651703          	lh	a4,278(a0)
    80026834:	4785                	li	a5,1
        return NULL;
    80026836:	4481                	li	s1,0
    if (dp->valid != 1 || !(name = formatname(name))) {        // detect illegal character
    80026838:	02f71663          	bne	a4,a5,80026864 <ealloc+0x50>
    8002683c:	852e                	mv	a0,a1
    8002683e:	fffff097          	auipc	ra,0xfffff
    80026842:	442080e7          	jalr	1090(ra) # 80025c80 <formatname>
    80026846:	89aa                	mv	s3,a0
    80026848:	10050663          	beqz	a0,80026954 <ealloc+0x140>
    uint off = 0;
    8002684c:	fc042623          	sw	zero,-52(s0)
    if ((ep = dirlookup(dp, name, &off)) != 0) {      // entry exists
    80026850:	fcc40613          	addi	a2,s0,-52
    80026854:	85aa                	mv	a1,a0
    80026856:	854a                	mv	a0,s2
    80026858:	00000097          	auipc	ra,0x0
    8002685c:	e64080e7          	jalr	-412(ra) # 800266bc <dirlookup>
    80026860:	84aa                	mv	s1,a0
    80026862:	c115                	beqz	a0,80026886 <ealloc+0x72>
}
    80026864:	8526                	mv	a0,s1
    80026866:	70e2                	ld	ra,56(sp)
    80026868:	7442                	ld	s0,48(sp)
    8002686a:	74a2                	ld	s1,40(sp)
    8002686c:	7902                	ld	s2,32(sp)
    8002686e:	69e2                	ld	s3,24(sp)
    80026870:	6a42                	ld	s4,16(sp)
    80026872:	6121                	addi	sp,sp,64
    80026874:	8082                	ret
        panic("ealloc not dir");
    80026876:	00006517          	auipc	a0,0x6
    8002687a:	fba50513          	addi	a0,a0,-70 # 8002c830 <sysnames+0x8b0>
    8002687e:	ffffa097          	auipc	ra,0xffffa
    80026882:	8c8080e7          	jalr	-1848(ra) # 80020146 <panic>
    ep = eget(dp, name);
    80026886:	85ce                	mv	a1,s3
    80026888:	854a                	mv	a0,s2
    8002688a:	fffff097          	auipc	ra,0xfffff
    8002688e:	de6080e7          	jalr	-538(ra) # 80025670 <eget>
    80026892:	84aa                	mv	s1,a0
    elock(ep);
    80026894:	00000097          	auipc	ra,0x0
    80026898:	a98080e7          	jalr	-1384(ra) # 8002632c <elock>
    ep->attribute = attr;
    8002689c:	11448023          	sb	s4,256(s1)
    ep->file_size = 0;
    800268a0:	1004a423          	sw	zero,264(s1)
    ep->first_clus = 0;
    800268a4:	1004a223          	sw	zero,260(s1)
    ep->parent = edup(dp);
    800268a8:	854a                	mv	a0,s2
    800268aa:	00000097          	auipc	ra,0x0
    800268ae:	832080e7          	jalr	-1998(ra) # 800260dc <edup>
    800268b2:	12a4b023          	sd	a0,288(s1)
    ep->off = off;
    800268b6:	fcc42783          	lw	a5,-52(s0)
    800268ba:	10f4ae23          	sw	a5,284(s1)
    ep->clus_cnt = 0;
    800268be:	1004a823          	sw	zero,272(s1)
    ep->cur_clus = 0;
    800268c2:	1004a623          	sw	zero,268(s1)
    ep->dirty = 0;
    800268c6:	10048aa3          	sb	zero,277(s1)
    strncpy(ep->filename, name, FAT32_MAX_FILENAME);
    800268ca:	0ff00613          	li	a2,255
    800268ce:	85ce                	mv	a1,s3
    800268d0:	8526                	mv	a0,s1
    800268d2:	ffffa097          	auipc	ra,0xffffa
    800268d6:	fc2080e7          	jalr	-62(ra) # 80020894 <strncpy>
    ep->filename[FAT32_MAX_FILENAME] = '\0';
    800268da:	0e048fa3          	sb	zero,255(s1)
    if (attr == ATTR_DIRECTORY) {    // generate "." and ".." for ep
    800268de:	47c1                	li	a5,16
    800268e0:	02fa0963          	beq	s4,a5,80026912 <ealloc+0xfe>
        ep->attribute |= ATTR_ARCHIVE;
    800268e4:	1004c783          	lbu	a5,256(s1)
    800268e8:	0207e793          	ori	a5,a5,32
    800268ec:	10f48023          	sb	a5,256(s1)
    emake(dp, ep, off);
    800268f0:	fcc42603          	lw	a2,-52(s0)
    800268f4:	85a6                	mv	a1,s1
    800268f6:	854a                	mv	a0,s2
    800268f8:	fffff097          	auipc	ra,0xfffff
    800268fc:	448080e7          	jalr	1096(ra) # 80025d40 <emake>
    ep->valid = 1;
    80026900:	4785                	li	a5,1
    80026902:	10f49b23          	sh	a5,278(s1)
    eunlock(ep);
    80026906:	8526                	mv	a0,s1
    80026908:	00000097          	auipc	ra,0x0
    8002690c:	a5a080e7          	jalr	-1446(ra) # 80026362 <eunlock>
    return ep;
    80026910:	bf91                	j	80026864 <ealloc+0x50>
        ep->attribute |= ATTR_DIRECTORY;
    80026912:	1004c783          	lbu	a5,256(s1)
    80026916:	0107e793          	ori	a5,a5,16
    8002691a:	10f48023          	sb	a5,256(s1)
        ep->cur_clus = ep->first_clus = alloc_clus(dp->dev);
    8002691e:	11494503          	lbu	a0,276(s2)
    80026922:	fffff097          	auipc	ra,0xfffff
    80026926:	928080e7          	jalr	-1752(ra) # 8002524a <alloc_clus>
    8002692a:	2501                	sext.w	a0,a0
    8002692c:	10a4a223          	sw	a0,260(s1)
    80026930:	10a4a623          	sw	a0,268(s1)
        emake(ep, ep, 0);
    80026934:	4601                	li	a2,0
    80026936:	85a6                	mv	a1,s1
    80026938:	8526                	mv	a0,s1
    8002693a:	fffff097          	auipc	ra,0xfffff
    8002693e:	406080e7          	jalr	1030(ra) # 80025d40 <emake>
        emake(ep, dp, 32);
    80026942:	02000613          	li	a2,32
    80026946:	85ca                	mv	a1,s2
    80026948:	8526                	mv	a0,s1
    8002694a:	fffff097          	auipc	ra,0xfffff
    8002694e:	3f6080e7          	jalr	1014(ra) # 80025d40 <emake>
    80026952:	bf79                	j	800268f0 <ealloc+0xdc>
        return NULL;
    80026954:	84aa                	mv	s1,a0
    80026956:	b739                	j	80026864 <ealloc+0x50>

0000000080026958 <lookup_path>:
    return path;
}

// FAT32 version of namex in xv6's original file system.
static struct dirent *lookup_path(char *path, int parent, char *name)
{
    80026958:	715d                	addi	sp,sp,-80
    8002695a:	e486                	sd	ra,72(sp)
    8002695c:	e0a2                	sd	s0,64(sp)
    8002695e:	fc26                	sd	s1,56(sp)
    80026960:	f84a                	sd	s2,48(sp)
    80026962:	f44e                	sd	s3,40(sp)
    80026964:	f052                	sd	s4,32(sp)
    80026966:	ec56                	sd	s5,24(sp)
    80026968:	e85a                	sd	s6,16(sp)
    8002696a:	e45e                	sd	s7,8(sp)
    8002696c:	e062                	sd	s8,0(sp)
    8002696e:	0880                	addi	s0,sp,80
    80026970:	84aa                	mv	s1,a0
    80026972:	8aae                	mv	s5,a1
    80026974:	8a32                	mv	s4,a2
    struct dirent *entry, *next;
    if (*path == '/') {
    80026976:	00054783          	lbu	a5,0(a0)
    8002697a:	02f00713          	li	a4,47
    8002697e:	02e78663          	beq	a5,a4,800269aa <lookup_path+0x52>
        entry = edup(&root);
    } else if (*path != '\0') {
        entry = edup(myproc()->cwd);
    } else {
        return NULL;
    80026982:	4901                	li	s2,0
    } else if (*path != '\0') {
    80026984:	cba1                	beqz	a5,800269d4 <lookup_path+0x7c>
        entry = edup(myproc()->cwd);
    80026986:	ffffb097          	auipc	ra,0xffffb
    8002698a:	1fc080e7          	jalr	508(ra) # 80021b82 <myproc>
    8002698e:	15853503          	ld	a0,344(a0)
    80026992:	fffff097          	auipc	ra,0xfffff
    80026996:	74a080e7          	jalr	1866(ra) # 800260dc <edup>
    8002699a:	892a                	mv	s2,a0
    while (*path == '/') {
    8002699c:	02f00993          	li	s3,47
    800269a0:	0ff00b13          	li	s6,255
    800269a4:	0ff00b93          	li	s7,255
    800269a8:	a0d5                	j	80026a8c <lookup_path+0x134>
        entry = edup(&root);
    800269aa:	0001b517          	auipc	a0,0x1b
    800269ae:	aa650513          	addi	a0,a0,-1370 # 80041450 <root>
    800269b2:	fffff097          	auipc	ra,0xfffff
    800269b6:	72a080e7          	jalr	1834(ra) # 800260dc <edup>
    800269ba:	892a                	mv	s2,a0
    800269bc:	b7c5                	j	8002699c <lookup_path+0x44>
    }
    while ((path = skipelem(path, name)) != 0) {
        elock(entry);
        if (!(entry->attribute & ATTR_DIRECTORY)) {
            eunlock(entry);
    800269be:	854a                	mv	a0,s2
    800269c0:	00000097          	auipc	ra,0x0
    800269c4:	9a2080e7          	jalr	-1630(ra) # 80026362 <eunlock>
            eput(entry);
    800269c8:	854a                	mv	a0,s2
    800269ca:	00000097          	auipc	ra,0x0
    800269ce:	9e6080e7          	jalr	-1562(ra) # 800263b0 <eput>
            return NULL;
    800269d2:	4901                	li	s2,0
    if (parent) {
        eput(entry);
        return NULL;
    }
    return entry;
}
    800269d4:	854a                	mv	a0,s2
    800269d6:	60a6                	ld	ra,72(sp)
    800269d8:	6406                	ld	s0,64(sp)
    800269da:	74e2                	ld	s1,56(sp)
    800269dc:	7942                	ld	s2,48(sp)
    800269de:	79a2                	ld	s3,40(sp)
    800269e0:	7a02                	ld	s4,32(sp)
    800269e2:	6ae2                	ld	s5,24(sp)
    800269e4:	6b42                	ld	s6,16(sp)
    800269e6:	6ba2                	ld	s7,8(sp)
    800269e8:	6c02                	ld	s8,0(sp)
    800269ea:	6161                	addi	sp,sp,80
    800269ec:	8082                	ret
            eunlock(entry);
    800269ee:	854a                	mv	a0,s2
    800269f0:	00000097          	auipc	ra,0x0
    800269f4:	972080e7          	jalr	-1678(ra) # 80026362 <eunlock>
            return entry;
    800269f8:	bff1                	j	800269d4 <lookup_path+0x7c>
            eunlock(entry);
    800269fa:	854a                	mv	a0,s2
    800269fc:	00000097          	auipc	ra,0x0
    80026a00:	966080e7          	jalr	-1690(ra) # 80026362 <eunlock>
            eput(entry);
    80026a04:	854a                	mv	a0,s2
    80026a06:	00000097          	auipc	ra,0x0
    80026a0a:	9aa080e7          	jalr	-1622(ra) # 800263b0 <eput>
            return NULL;
    80026a0e:	8962                	mv	s2,s8
    80026a10:	b7d1                	j	800269d4 <lookup_path+0x7c>
        path++;
    80026a12:	85a6                	mv	a1,s1
    int len = path - s;
    80026a14:	40b487bb          	subw	a5,s1,a1
    if (len > FAT32_MAX_FILENAME) {
    80026a18:	863e                	mv	a2,a5
    80026a1a:	00fb5363          	bge	s6,a5,80026a20 <lookup_path+0xc8>
    80026a1e:	865e                	mv	a2,s7
    80026a20:	0006079b          	sext.w	a5,a2
    name[len] = 0;
    80026a24:	97d2                	add	a5,a5,s4
    80026a26:	00078023          	sb	zero,0(a5)
    memmove(name, s, len);
    80026a2a:	2601                	sext.w	a2,a2
    80026a2c:	8552                	mv	a0,s4
    80026a2e:	ffffa097          	auipc	ra,0xffffa
    80026a32:	d9a080e7          	jalr	-614(ra) # 800207c8 <memmove>
    while (*path == '/') {
    80026a36:	0004c783          	lbu	a5,0(s1)
    80026a3a:	01379763          	bne	a5,s3,80026a48 <lookup_path+0xf0>
        path++;
    80026a3e:	0485                	addi	s1,s1,1
    while (*path == '/') {
    80026a40:	0004c783          	lbu	a5,0(s1)
    80026a44:	ff378de3          	beq	a5,s3,80026a3e <lookup_path+0xe6>
        elock(entry);
    80026a48:	854a                	mv	a0,s2
    80026a4a:	00000097          	auipc	ra,0x0
    80026a4e:	8e2080e7          	jalr	-1822(ra) # 8002632c <elock>
        if (!(entry->attribute & ATTR_DIRECTORY)) {
    80026a52:	10094783          	lbu	a5,256(s2)
    80026a56:	8bc1                	andi	a5,a5,16
    80026a58:	d3bd                	beqz	a5,800269be <lookup_path+0x66>
        if (parent && *path == '\0') {
    80026a5a:	000a8563          	beqz	s5,80026a64 <lookup_path+0x10c>
    80026a5e:	0004c783          	lbu	a5,0(s1)
    80026a62:	d7d1                	beqz	a5,800269ee <lookup_path+0x96>
        if ((next = dirlookup(entry, name, 0)) == 0) {
    80026a64:	4601                	li	a2,0
    80026a66:	85d2                	mv	a1,s4
    80026a68:	854a                	mv	a0,s2
    80026a6a:	00000097          	auipc	ra,0x0
    80026a6e:	c52080e7          	jalr	-942(ra) # 800266bc <dirlookup>
    80026a72:	8c2a                	mv	s8,a0
    80026a74:	d159                	beqz	a0,800269fa <lookup_path+0xa2>
        eunlock(entry);
    80026a76:	854a                	mv	a0,s2
    80026a78:	00000097          	auipc	ra,0x0
    80026a7c:	8ea080e7          	jalr	-1814(ra) # 80026362 <eunlock>
        eput(entry);
    80026a80:	854a                	mv	a0,s2
    80026a82:	00000097          	auipc	ra,0x0
    80026a86:	92e080e7          	jalr	-1746(ra) # 800263b0 <eput>
        entry = next;
    80026a8a:	8962                	mv	s2,s8
    while (*path == '/') {
    80026a8c:	0004c783          	lbu	a5,0(s1)
    80026a90:	03379e63          	bne	a5,s3,80026acc <lookup_path+0x174>
        path++;
    80026a94:	0485                	addi	s1,s1,1
    while (*path == '/') {
    80026a96:	0004c783          	lbu	a5,0(s1)
    80026a9a:	ff378de3          	beq	a5,s3,80026a94 <lookup_path+0x13c>
    if (*path == 0) { return NULL; }
    80026a9e:	cf91                	beqz	a5,80026aba <lookup_path+0x162>
    while (*path != '/' && *path != 0) {
    80026aa0:	f73789e3          	beq	a5,s3,80026a12 <lookup_path+0xba>
    80026aa4:	cb89                	beqz	a5,80026ab6 <lookup_path+0x15e>
        path++;
    80026aa6:	85a6                	mv	a1,s1
        path++;
    80026aa8:	0485                	addi	s1,s1,1
    while (*path != '/' && *path != 0) {
    80026aaa:	0004c783          	lbu	a5,0(s1)
    80026aae:	f73783e3          	beq	a5,s3,80026a14 <lookup_path+0xbc>
    80026ab2:	fbfd                	bnez	a5,80026aa8 <lookup_path+0x150>
    80026ab4:	b785                	j	80026a14 <lookup_path+0xbc>
        path++;
    80026ab6:	85a6                	mv	a1,s1
    80026ab8:	bfb1                	j	80026a14 <lookup_path+0xbc>
    if (parent) {
    80026aba:	f00a8de3          	beqz	s5,800269d4 <lookup_path+0x7c>
        eput(entry);
    80026abe:	854a                	mv	a0,s2
    80026ac0:	00000097          	auipc	ra,0x0
    80026ac4:	8f0080e7          	jalr	-1808(ra) # 800263b0 <eput>
        return NULL;
    80026ac8:	4901                	li	s2,0
    80026aca:	b729                	j	800269d4 <lookup_path+0x7c>
    if (*path == 0) { return NULL; }
    80026acc:	d7fd                	beqz	a5,80026aba <lookup_path+0x162>
    80026ace:	85a6                	mv	a1,s1
    80026ad0:	bfe1                	j	80026aa8 <lookup_path+0x150>

0000000080026ad2 <ename>:

struct dirent *ename(char *path)
{
    80026ad2:	716d                	addi	sp,sp,-272
    80026ad4:	e606                	sd	ra,264(sp)
    80026ad6:	e222                	sd	s0,256(sp)
    80026ad8:	0a00                	addi	s0,sp,272
    char name[FAT32_MAX_FILENAME + 1];
    return lookup_path(path, 0, name);
    80026ada:	ef040613          	addi	a2,s0,-272
    80026ade:	4581                	li	a1,0
    80026ae0:	00000097          	auipc	ra,0x0
    80026ae4:	e78080e7          	jalr	-392(ra) # 80026958 <lookup_path>
}
    80026ae8:	60b2                	ld	ra,264(sp)
    80026aea:	6412                	ld	s0,256(sp)
    80026aec:	6151                	addi	sp,sp,272
    80026aee:	8082                	ret

0000000080026af0 <enameparent>:

struct dirent *enameparent(char *path, char *name)
{
    80026af0:	1141                	addi	sp,sp,-16
    80026af2:	e406                	sd	ra,8(sp)
    80026af4:	e022                	sd	s0,0(sp)
    80026af6:	0800                	addi	s0,sp,16
    return lookup_path(path, 1, name);
    80026af8:	862e                	mv	a2,a1
    80026afa:	4585                	li	a1,1
    80026afc:	00000097          	auipc	ra,0x0
    80026b00:	e5c080e7          	jalr	-420(ra) # 80026958 <lookup_path>
}
    80026b04:	60a2                	ld	ra,8(sp)
    80026b06:	6402                	ld	s0,0(sp)
    80026b08:	0141                	addi	sp,sp,16
    80026b0a:	8082                	ret

0000000080026b0c <plicinit>:

//
// the riscv Platform Level Interrupt Controller (PLIC).
//

void plicinit(void) {
    80026b0c:	1141                	addi	sp,sp,-16
    80026b0e:	e422                	sd	s0,8(sp)
    80026b10:	0800                	addi	s0,sp,16
	writed(1, PLIC_V + DISK_IRQ * sizeof(uint32));
    80026b12:	00fc37b7          	lui	a5,0xfc3
    80026b16:	07ba                	slli	a5,a5,0xe
    80026b18:	4705                	li	a4,1
    80026b1a:	d7f8                	sw	a4,108(a5)
	writed(1, PLIC_V + UART_IRQ * sizeof(uint32));
    80026b1c:	08e7a223          	sw	a4,132(a5) # fc3084 <BASE_ADDRESS-0x7f05cf7c>

	#ifdef DEBUG 
	printf("plicinit\n");
	#endif 
}
    80026b20:	6422                	ld	s0,8(sp)
    80026b22:	0141                	addi	sp,sp,16
    80026b24:	8082                	ret

0000000080026b26 <plicinithart>:

void
plicinithart(void)
{
    80026b26:	1141                	addi	sp,sp,-16
    80026b28:	e406                	sd	ra,8(sp)
    80026b2a:	e022                	sd	s0,0(sp)
    80026b2c:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80026b2e:	ffffb097          	auipc	ra,0xffffb
    80026b32:	028080e7          	jalr	40(ra) # 80021b56 <cpuid>
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART_IRQ) | (1 << DISK_IRQ);
  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
  #else
  uint32 *hart_m_enable = (uint32*)PLIC_MENABLE(hart);
    80026b36:	0085151b          	slliw	a0,a0,0x8
    80026b3a:	01f867b7          	lui	a5,0x1f86
    80026b3e:	0785                	addi	a5,a5,1
    80026b40:	07b6                	slli	a5,a5,0xd
    80026b42:	953e                	add	a0,a0,a5
  *(hart_m_enable) = readd(hart_m_enable) | (1 << DISK_IRQ);
    80026b44:	411c                	lw	a5,0(a0)
    80026b46:	08000737          	lui	a4,0x8000
    80026b4a:	8fd9                	or	a5,a5,a4
    80026b4c:	c11c                	sw	a5,0(a0)
  uint32 *hart0_m_int_enable_hi = hart_m_enable + 1;
  *(hart0_m_int_enable_hi) = readd(hart0_m_int_enable_hi) | (1 << (UART_IRQ % 32));
    80026b4e:	415c                	lw	a5,4(a0)
    80026b50:	0027e793          	ori	a5,a5,2
    80026b54:	c15c                	sw	a5,4(a0)
  #endif
  #ifdef DEBUG
  printf("plicinithart\n");
  #endif
}
    80026b56:	60a2                	ld	ra,8(sp)
    80026b58:	6402                	ld	s0,0(sp)
    80026b5a:	0141                	addi	sp,sp,16
    80026b5c:	8082                	ret

0000000080026b5e <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80026b5e:	1141                	addi	sp,sp,-16
    80026b60:	e406                	sd	ra,8(sp)
    80026b62:	e022                	sd	s0,0(sp)
    80026b64:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80026b66:	ffffb097          	auipc	ra,0xffffb
    80026b6a:	ff0080e7          	jalr	-16(ra) # 80021b56 <cpuid>
  int irq;
  #ifndef QEMU
  irq = *(uint32*)PLIC_MCLAIM(hart);
    80026b6e:	00d5151b          	slliw	a0,a0,0xd
    80026b72:	1f8617b7          	lui	a5,0x1f861
    80026b76:	07a6                	slli	a5,a5,0x9
    80026b78:	97aa                	add	a5,a5,a0
  #else
  irq = *(uint32*)PLIC_SCLAIM(hart);
  #endif
  return irq;
}
    80026b7a:	43c8                	lw	a0,4(a5)
    80026b7c:	60a2                	ld	ra,8(sp)
    80026b7e:	6402                	ld	s0,0(sp)
    80026b80:	0141                	addi	sp,sp,16
    80026b82:	8082                	ret

0000000080026b84 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80026b84:	1101                	addi	sp,sp,-32
    80026b86:	ec06                	sd	ra,24(sp)
    80026b88:	e822                	sd	s0,16(sp)
    80026b8a:	e426                	sd	s1,8(sp)
    80026b8c:	1000                	addi	s0,sp,32
    80026b8e:	84aa                	mv	s1,a0
  int hart = cpuid();
    80026b90:	ffffb097          	auipc	ra,0xffffb
    80026b94:	fc6080e7          	jalr	-58(ra) # 80021b56 <cpuid>
  #ifndef QEMU
  *(uint32*)PLIC_MCLAIM(hart) = irq;
    80026b98:	00d5151b          	slliw	a0,a0,0xd
    80026b9c:	1f8617b7          	lui	a5,0x1f861
    80026ba0:	07a6                	slli	a5,a5,0x9
    80026ba2:	97aa                	add	a5,a5,a0
    80026ba4:	c3c4                	sw	s1,4(a5)
  #else
  *(uint32*)PLIC_SCLAIM(hart) = irq;
  #endif
}
    80026ba6:	60e2                	ld	ra,24(sp)
    80026ba8:	6442                	ld	s0,16(sp)
    80026baa:	64a2                	ld	s1,8(sp)
    80026bac:	6105                	addi	sp,sp,32
    80026bae:	8082                	ret

0000000080026bb0 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80026bb0:	715d                	addi	sp,sp,-80
    80026bb2:	e486                	sd	ra,72(sp)
    80026bb4:	e0a2                	sd	s0,64(sp)
    80026bb6:	fc26                	sd	s1,56(sp)
    80026bb8:	f84a                	sd	s2,48(sp)
    80026bba:	f44e                	sd	s3,40(sp)
    80026bbc:	f052                	sd	s4,32(sp)
    80026bbe:	ec56                	sd	s5,24(sp)
    80026bc0:	0880                	addi	s0,sp,80
    80026bc2:	8a2a                	mv	s4,a0
    80026bc4:	892e                	mv	s2,a1
    80026bc6:	89b2                	mv	s3,a2
  int i;

  acquire(&cons.lock);
    80026bc8:	0001f517          	auipc	a0,0x1f
    80026bcc:	05850513          	addi	a0,a0,88 # 80045c20 <cons>
    80026bd0:	ffffa097          	auipc	ra,0xffffa
    80026bd4:	af0080e7          	jalr	-1296(ra) # 800206c0 <acquire>
  for(i = 0; i < n; i++){
    80026bd8:	05305d63          	blez	s3,80026c32 <consolewrite+0x82>
    80026bdc:	4481                	li	s1,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80026bde:	5afd                	li	s5,-1
    80026be0:	4685                	li	a3,1
    80026be2:	864a                	mv	a2,s2
    80026be4:	85d2                	mv	a1,s4
    80026be6:	fbf40513          	addi	a0,s0,-65
    80026bea:	ffffc097          	auipc	ra,0xffffc
    80026bee:	aac080e7          	jalr	-1364(ra) # 80022696 <either_copyin>
    80026bf2:	01550e63          	beq	a0,s5,80026c0e <consolewrite+0x5e>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
    80026bf6:	fbf44503          	lbu	a0,-65(s0)
    80026bfa:	4581                	li	a1,0
    80026bfc:	4601                	li	a2,0
    80026bfe:	4681                	li	a3,0
    80026c00:	4885                	li	a7,1
    80026c02:	00000073          	ecall
  for(i = 0; i < n; i++){
    80026c06:	2485                	addiw	s1,s1,1
    80026c08:	0905                	addi	s2,s2,1
    80026c0a:	fc999be3          	bne	s3,s1,80026be0 <consolewrite+0x30>
      break;
    sbi_console_putchar(c);
  }
  release(&cons.lock);
    80026c0e:	0001f517          	auipc	a0,0x1f
    80026c12:	01250513          	addi	a0,a0,18 # 80045c20 <cons>
    80026c16:	ffffa097          	auipc	ra,0xffffa
    80026c1a:	afe080e7          	jalr	-1282(ra) # 80020714 <release>

  return i;
}
    80026c1e:	8526                	mv	a0,s1
    80026c20:	60a6                	ld	ra,72(sp)
    80026c22:	6406                	ld	s0,64(sp)
    80026c24:	74e2                	ld	s1,56(sp)
    80026c26:	7942                	ld	s2,48(sp)
    80026c28:	79a2                	ld	s3,40(sp)
    80026c2a:	7a02                	ld	s4,32(sp)
    80026c2c:	6ae2                	ld	s5,24(sp)
    80026c2e:	6161                	addi	sp,sp,80
    80026c30:	8082                	ret
  for(i = 0; i < n; i++){
    80026c32:	4481                	li	s1,0
    80026c34:	bfe9                	j	80026c0e <consolewrite+0x5e>

0000000080026c36 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80026c36:	7119                	addi	sp,sp,-128
    80026c38:	fc86                	sd	ra,120(sp)
    80026c3a:	f8a2                	sd	s0,112(sp)
    80026c3c:	f4a6                	sd	s1,104(sp)
    80026c3e:	f0ca                	sd	s2,96(sp)
    80026c40:	ecce                	sd	s3,88(sp)
    80026c42:	e8d2                	sd	s4,80(sp)
    80026c44:	e4d6                	sd	s5,72(sp)
    80026c46:	e0da                	sd	s6,64(sp)
    80026c48:	fc5e                	sd	s7,56(sp)
    80026c4a:	f862                	sd	s8,48(sp)
    80026c4c:	f466                	sd	s9,40(sp)
    80026c4e:	f06a                	sd	s10,32(sp)
    80026c50:	ec6e                	sd	s11,24(sp)
    80026c52:	0100                	addi	s0,sp,128
    80026c54:	8caa                	mv	s9,a0
    80026c56:	8aae                	mv	s5,a1
    80026c58:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80026c5a:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80026c5e:	0001f517          	auipc	a0,0x1f
    80026c62:	fc250513          	addi	a0,a0,-62 # 80045c20 <cons>
    80026c66:	ffffa097          	auipc	ra,0xffffa
    80026c6a:	a5a080e7          	jalr	-1446(ra) # 800206c0 <acquire>
  while(n > 0){
    80026c6e:	09405663          	blez	s4,80026cfa <consoleread+0xc4>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80026c72:	0001f497          	auipc	s1,0x1f
    80026c76:	fae48493          	addi	s1,s1,-82 # 80045c20 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80026c7a:	89a6                	mv	s3,s1
    80026c7c:	0001f917          	auipc	s2,0x1f
    80026c80:	03c90913          	addi	s2,s2,60 # 80045cb8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    80026c84:	4c11                	li	s8,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80026c86:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80026c88:	4da9                	li	s11,10
    while(cons.r == cons.w){
    80026c8a:	0984a783          	lw	a5,152(s1)
    80026c8e:	09c4a703          	lw	a4,156(s1)
    80026c92:	02f71463          	bne	a4,a5,80026cba <consoleread+0x84>
      if(myproc()->killed){
    80026c96:	ffffb097          	auipc	ra,0xffffb
    80026c9a:	eec080e7          	jalr	-276(ra) # 80021b82 <myproc>
    80026c9e:	591c                	lw	a5,48(a0)
    80026ca0:	eba5                	bnez	a5,80026d10 <consoleread+0xda>
      sleep(&cons.r, &cons.lock);
    80026ca2:	85ce                	mv	a1,s3
    80026ca4:	854a                	mv	a0,s2
    80026ca6:	ffffb097          	auipc	ra,0xffffb
    80026caa:	75e080e7          	jalr	1886(ra) # 80022404 <sleep>
    while(cons.r == cons.w){
    80026cae:	0984a783          	lw	a5,152(s1)
    80026cb2:	09c4a703          	lw	a4,156(s1)
    80026cb6:	fef700e3          	beq	a4,a5,80026c96 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF];
    80026cba:	0017871b          	addiw	a4,a5,1
    80026cbe:	08e4ac23          	sw	a4,152(s1)
    80026cc2:	07f7f713          	andi	a4,a5,127
    80026cc6:	9726                	add	a4,a4,s1
    80026cc8:	01874703          	lbu	a4,24(a4) # 8000018 <BASE_ADDRESS-0x7801ffe8>
    80026ccc:	00070b9b          	sext.w	s7,a4
    if(c == C('D')){  // end-of-file
    80026cd0:	078b8863          	beq	s7,s8,80026d40 <consoleread+0x10a>
    cbuf = c;
    80026cd4:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80026cd8:	4685                	li	a3,1
    80026cda:	f8f40613          	addi	a2,s0,-113
    80026cde:	85d6                	mv	a1,s5
    80026ce0:	8566                	mv	a0,s9
    80026ce2:	ffffc097          	auipc	ra,0xffffc
    80026ce6:	97e080e7          	jalr	-1666(ra) # 80022660 <either_copyout>
    80026cea:	01a50863          	beq	a0,s10,80026cfa <consoleread+0xc4>
    dst++;
    80026cee:	0a85                	addi	s5,s5,1
    --n;
    80026cf0:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80026cf2:	01bb8463          	beq	s7,s11,80026cfa <consoleread+0xc4>
  while(n > 0){
    80026cf6:	f80a1ae3          	bnez	s4,80026c8a <consoleread+0x54>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80026cfa:	0001f517          	auipc	a0,0x1f
    80026cfe:	f2650513          	addi	a0,a0,-218 # 80045c20 <cons>
    80026d02:	ffffa097          	auipc	ra,0xffffa
    80026d06:	a12080e7          	jalr	-1518(ra) # 80020714 <release>

  return target - n;
    80026d0a:	414b053b          	subw	a0,s6,s4
    80026d0e:	a811                	j	80026d22 <consoleread+0xec>
        release(&cons.lock);
    80026d10:	0001f517          	auipc	a0,0x1f
    80026d14:	f1050513          	addi	a0,a0,-240 # 80045c20 <cons>
    80026d18:	ffffa097          	auipc	ra,0xffffa
    80026d1c:	9fc080e7          	jalr	-1540(ra) # 80020714 <release>
        return -1;
    80026d20:	557d                	li	a0,-1
}
    80026d22:	70e6                	ld	ra,120(sp)
    80026d24:	7446                	ld	s0,112(sp)
    80026d26:	74a6                	ld	s1,104(sp)
    80026d28:	7906                	ld	s2,96(sp)
    80026d2a:	69e6                	ld	s3,88(sp)
    80026d2c:	6a46                	ld	s4,80(sp)
    80026d2e:	6aa6                	ld	s5,72(sp)
    80026d30:	6b06                	ld	s6,64(sp)
    80026d32:	7be2                	ld	s7,56(sp)
    80026d34:	7c42                	ld	s8,48(sp)
    80026d36:	7ca2                	ld	s9,40(sp)
    80026d38:	7d02                	ld	s10,32(sp)
    80026d3a:	6de2                	ld	s11,24(sp)
    80026d3c:	6109                	addi	sp,sp,128
    80026d3e:	8082                	ret
      if(n < target){
    80026d40:	000a071b          	sext.w	a4,s4
    80026d44:	fb677be3          	bgeu	a4,s6,80026cfa <consoleread+0xc4>
        cons.r--;
    80026d48:	0001f717          	auipc	a4,0x1f
    80026d4c:	f6f72823          	sw	a5,-144(a4) # 80045cb8 <cons+0x98>
    80026d50:	b76d                	j	80026cfa <consoleread+0xc4>

0000000080026d52 <consputc>:
void consputc(int c) {
    80026d52:	1141                	addi	sp,sp,-16
    80026d54:	e422                	sd	s0,8(sp)
    80026d56:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80026d58:	10000793          	li	a5,256
    80026d5c:	00f50b63          	beq	a0,a5,80026d72 <consputc+0x20>
    80026d60:	4581                	li	a1,0
    80026d62:	4601                	li	a2,0
    80026d64:	4681                	li	a3,0
    80026d66:	4885                	li	a7,1
    80026d68:	00000073          	ecall
}
    80026d6c:	6422                	ld	s0,8(sp)
    80026d6e:	0141                	addi	sp,sp,16
    80026d70:	8082                	ret
    80026d72:	4521                	li	a0,8
    80026d74:	4581                	li	a1,0
    80026d76:	4601                	li	a2,0
    80026d78:	4681                	li	a3,0
    80026d7a:	4885                	li	a7,1
    80026d7c:	00000073          	ecall
    80026d80:	02000513          	li	a0,32
    80026d84:	00000073          	ecall
    80026d88:	4521                	li	a0,8
    80026d8a:	00000073          	ecall
    80026d8e:	bff9                	j	80026d6c <consputc+0x1a>

0000000080026d90 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80026d90:	1101                	addi	sp,sp,-32
    80026d92:	ec06                	sd	ra,24(sp)
    80026d94:	e822                	sd	s0,16(sp)
    80026d96:	e426                	sd	s1,8(sp)
    80026d98:	e04a                	sd	s2,0(sp)
    80026d9a:	1000                	addi	s0,sp,32
    80026d9c:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80026d9e:	0001f517          	auipc	a0,0x1f
    80026da2:	e8250513          	addi	a0,a0,-382 # 80045c20 <cons>
    80026da6:	ffffa097          	auipc	ra,0xffffa
    80026daa:	91a080e7          	jalr	-1766(ra) # 800206c0 <acquire>

  switch(c){
    80026dae:	47c1                	li	a5,16
    80026db0:	14f48063          	beq	s1,a5,80026ef0 <consoleintr+0x160>
    80026db4:	0297df63          	bge	a5,s1,80026df2 <consoleintr+0x62>
    80026db8:	47d5                	li	a5,21
    80026dba:	0cf48463          	beq	s1,a5,80026e82 <consoleintr+0xf2>
    80026dbe:	07f00793          	li	a5,127
    80026dc2:	02f49b63          	bne	s1,a5,80026df8 <consoleintr+0x68>
      consputc(BACKSPACE);
    }
    break;
  case C('H'): // Backspace
  case '\x7f':
    if(cons.e != cons.w){
    80026dc6:	0001f717          	auipc	a4,0x1f
    80026dca:	e5a70713          	addi	a4,a4,-422 # 80045c20 <cons>
    80026dce:	0a072783          	lw	a5,160(a4)
    80026dd2:	09c72703          	lw	a4,156(a4)
    80026dd6:	12f70163          	beq	a4,a5,80026ef8 <consoleintr+0x168>
      cons.e--;
    80026dda:	37fd                	addiw	a5,a5,-1
    80026ddc:	0001f717          	auipc	a4,0x1f
    80026de0:	eef72223          	sw	a5,-284(a4) # 80045cc0 <cons+0xa0>
      consputc(BACKSPACE);
    80026de4:	10000513          	li	a0,256
    80026de8:	00000097          	auipc	ra,0x0
    80026dec:	f6a080e7          	jalr	-150(ra) # 80026d52 <consputc>
    80026df0:	a221                	j	80026ef8 <consoleintr+0x168>
  switch(c){
    80026df2:	47a1                	li	a5,8
    80026df4:	fcf489e3          	beq	s1,a5,80026dc6 <consoleintr+0x36>
    }
    break;
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80026df8:	10048063          	beqz	s1,80026ef8 <consoleintr+0x168>
    80026dfc:	0001f717          	auipc	a4,0x1f
    80026e00:	e2470713          	addi	a4,a4,-476 # 80045c20 <cons>
    80026e04:	0a072783          	lw	a5,160(a4)
    80026e08:	09872703          	lw	a4,152(a4)
    80026e0c:	9f99                	subw	a5,a5,a4
    80026e0e:	07f00713          	li	a4,127
    80026e12:	0ef76363          	bltu	a4,a5,80026ef8 <consoleintr+0x168>
      #ifndef QEMU
      if (c == '\r') break;     // on k210, "enter" will input \n and \r
    80026e16:	47b5                	li	a5,13
    80026e18:	0ef48063          	beq	s1,a5,80026ef8 <consoleintr+0x168>
      #else
      c = (c == '\r') ? '\n' : c;
      #endif
      // echo back to the user.
      consputc(c);
    80026e1c:	8526                	mv	a0,s1
    80026e1e:	00000097          	auipc	ra,0x0
    80026e22:	f34080e7          	jalr	-204(ra) # 80026d52 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80026e26:	0001f797          	auipc	a5,0x1f
    80026e2a:	dfa78793          	addi	a5,a5,-518 # 80045c20 <cons>
    80026e2e:	0a07a703          	lw	a4,160(a5)
    80026e32:	0017069b          	addiw	a3,a4,1
    80026e36:	0006861b          	sext.w	a2,a3
    80026e3a:	0ad7a023          	sw	a3,160(a5)
    80026e3e:	07f77713          	andi	a4,a4,127
    80026e42:	97ba                	add	a5,a5,a4
    80026e44:	00978c23          	sb	s1,24(a5)

      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80026e48:	47a9                	li	a5,10
    80026e4a:	00f48f63          	beq	s1,a5,80026e68 <consoleintr+0xd8>
    80026e4e:	4791                	li	a5,4
    80026e50:	00f48c63          	beq	s1,a5,80026e68 <consoleintr+0xd8>
    80026e54:	0001f797          	auipc	a5,0x1f
    80026e58:	dcc78793          	addi	a5,a5,-564 # 80045c20 <cons>
    80026e5c:	0987a783          	lw	a5,152(a5)
    80026e60:	0807879b          	addiw	a5,a5,128
    80026e64:	08c79a63          	bne	a5,a2,80026ef8 <consoleintr+0x168>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80026e68:	0001f797          	auipc	a5,0x1f
    80026e6c:	e4d7aa23          	sw	a3,-428(a5) # 80045cbc <cons+0x9c>
        wakeup(&cons.r);
    80026e70:	0001f517          	auipc	a0,0x1f
    80026e74:	e4850513          	addi	a0,a0,-440 # 80045cb8 <cons+0x98>
    80026e78:	ffffb097          	auipc	ra,0xffffb
    80026e7c:	70e080e7          	jalr	1806(ra) # 80022586 <wakeup>
    80026e80:	a8a5                	j	80026ef8 <consoleintr+0x168>
    while(cons.e != cons.w &&
    80026e82:	0001f717          	auipc	a4,0x1f
    80026e86:	d9e70713          	addi	a4,a4,-610 # 80045c20 <cons>
    80026e8a:	0a072783          	lw	a5,160(a4)
    80026e8e:	09c72703          	lw	a4,156(a4)
    80026e92:	06f70363          	beq	a4,a5,80026ef8 <consoleintr+0x168>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80026e96:	37fd                	addiw	a5,a5,-1
    80026e98:	0007871b          	sext.w	a4,a5
    80026e9c:	07f7f793          	andi	a5,a5,127
    80026ea0:	0001f697          	auipc	a3,0x1f
    80026ea4:	d8068693          	addi	a3,a3,-640 # 80045c20 <cons>
    80026ea8:	97b6                	add	a5,a5,a3
    while(cons.e != cons.w &&
    80026eaa:	0187c683          	lbu	a3,24(a5)
    80026eae:	47a9                	li	a5,10
      cons.e--;
    80026eb0:	0001f497          	auipc	s1,0x1f
    80026eb4:	d7048493          	addi	s1,s1,-656 # 80045c20 <cons>
    while(cons.e != cons.w &&
    80026eb8:	4929                	li	s2,10
    80026eba:	02f68f63          	beq	a3,a5,80026ef8 <consoleintr+0x168>
      cons.e--;
    80026ebe:	0ae4a023          	sw	a4,160(s1)
      consputc(BACKSPACE);
    80026ec2:	10000513          	li	a0,256
    80026ec6:	00000097          	auipc	ra,0x0
    80026eca:	e8c080e7          	jalr	-372(ra) # 80026d52 <consputc>
    while(cons.e != cons.w &&
    80026ece:	0a04a783          	lw	a5,160(s1)
    80026ed2:	09c4a703          	lw	a4,156(s1)
    80026ed6:	02f70163          	beq	a4,a5,80026ef8 <consoleintr+0x168>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80026eda:	37fd                	addiw	a5,a5,-1
    80026edc:	0007871b          	sext.w	a4,a5
    80026ee0:	07f7f793          	andi	a5,a5,127
    80026ee4:	97a6                	add	a5,a5,s1
    while(cons.e != cons.w &&
    80026ee6:	0187c783          	lbu	a5,24(a5)
    80026eea:	fd279ae3          	bne	a5,s2,80026ebe <consoleintr+0x12e>
    80026eee:	a029                	j	80026ef8 <consoleintr+0x168>
    procdump();
    80026ef0:	ffffb097          	auipc	ra,0xffffb
    80026ef4:	7da080e7          	jalr	2010(ra) # 800226ca <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80026ef8:	0001f517          	auipc	a0,0x1f
    80026efc:	d2850513          	addi	a0,a0,-728 # 80045c20 <cons>
    80026f00:	ffffa097          	auipc	ra,0xffffa
    80026f04:	814080e7          	jalr	-2028(ra) # 80020714 <release>
}
    80026f08:	60e2                	ld	ra,24(sp)
    80026f0a:	6442                	ld	s0,16(sp)
    80026f0c:	64a2                	ld	s1,8(sp)
    80026f0e:	6902                	ld	s2,0(sp)
    80026f10:	6105                	addi	sp,sp,32
    80026f12:	8082                	ret

0000000080026f14 <consoleinit>:

void
consoleinit(void)
{
    80026f14:	1101                	addi	sp,sp,-32
    80026f16:	ec06                	sd	ra,24(sp)
    80026f18:	e822                	sd	s0,16(sp)
    80026f1a:	e426                	sd	s1,8(sp)
    80026f1c:	1000                	addi	s0,sp,32
  initlock(&cons.lock, "cons");
    80026f1e:	0001f497          	auipc	s1,0x1f
    80026f22:	d0248493          	addi	s1,s1,-766 # 80045c20 <cons>
    80026f26:	00006597          	auipc	a1,0x6
    80026f2a:	91a58593          	addi	a1,a1,-1766 # 8002c840 <sysnames+0x8c0>
    80026f2e:	8526                	mv	a0,s1
    80026f30:	ffff9097          	auipc	ra,0xffff9
    80026f34:	74c080e7          	jalr	1868(ra) # 8002067c <initlock>

  cons.e = cons.w = cons.r = 0;
    80026f38:	0804ac23          	sw	zero,152(s1)
    80026f3c:	0804ae23          	sw	zero,156(s1)
    80026f40:	0a04a023          	sw	zero,160(s1)
  
  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80026f44:	00019797          	auipc	a5,0x19
    80026f48:	46c78793          	addi	a5,a5,1132 # 800403b0 <devsw>
    80026f4c:	00000717          	auipc	a4,0x0
    80026f50:	cea70713          	addi	a4,a4,-790 # 80026c36 <consoleread>
    80026f54:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80026f56:	00000717          	auipc	a4,0x0
    80026f5a:	c5a70713          	addi	a4,a4,-934 # 80026bb0 <consolewrite>
    80026f5e:	ef98                	sd	a4,24(a5)
}
    80026f60:	60e2                	ld	ra,24(sp)
    80026f62:	6442                	ld	s0,16(sp)
    80026f64:	64a2                	ld	s1,8(sp)
    80026f66:	6105                	addi	sp,sp,32
    80026f68:	8082                	ret

0000000080026f6a <spi_set_tmod>:
    spi_adapter->endian = endian;
}


static void spi_set_tmod(uint8 spi_num, uint32 tmod)
{
    80026f6a:	1141                	addi	sp,sp,-16
    80026f6c:	e406                	sd	ra,8(sp)
    80026f6e:	e022                	sd	s0,0(sp)
    80026f70:	0800                	addi	s0,sp,16
    80026f72:	872a                	mv	a4,a0
    // configASSERT(spi_num < SPI_DEVICE_MAX);
    volatile spi_t *spi_handle = spi[spi_num];
    80026f74:	00351693          	slli	a3,a0,0x3
    80026f78:	00006797          	auipc	a5,0x6
    80026f7c:	8d078793          	addi	a5,a5,-1840 # 8002c848 <spi>
    80026f80:	97b6                	add	a5,a5,a3
    80026f82:	6388                	ld	a0,0(a5)
    uint8 tmod_offset = 0;
    switch(spi_num)
    80026f84:	4689                	li	a3,2
    {
        case 0:
        case 1:
        case 2:
            tmod_offset = 8;
    80026f86:	47a1                	li	a5,8
    switch(spi_num)
    80026f88:	00e6f363          	bgeu	a3,a4,80026f8e <spi_set_tmod+0x24>
            break;
        case 3:
        default:
            tmod_offset = 10;
    80026f8c:	47a9                	li	a5,10
            break;
    }
    set_bit(&spi_handle->ctrlr0, 3 << tmod_offset, tmod << tmod_offset);
    80026f8e:	2781                	sext.w	a5,a5
    80026f90:	00f5963b          	sllw	a2,a1,a5
    80026f94:	458d                	li	a1,3
    80026f96:	00f595bb          	sllw	a1,a1,a5
    80026f9a:	00001097          	auipc	ra,0x1
    80026f9e:	f10080e7          	jalr	-240(ra) # 80027eaa <set_bit>
}
    80026fa2:	60a2                	ld	ra,8(sp)
    80026fa4:	6402                	ld	s0,0(sp)
    80026fa6:	0141                	addi	sp,sp,16
    80026fa8:	8082                	ret

0000000080026faa <spi_init>:
{
    80026faa:	1141                	addi	sp,sp,-16
    80026fac:	e422                	sd	s0,8(sp)
    80026fae:	0800                	addi	s0,sp,16
    switch(spi_num)
    80026fb0:	4785                	li	a5,1
    80026fb2:	06a7f463          	bgeu	a5,a0,8002701a <spi_init+0x70>
    80026fb6:	4789                	li	a5,2
    80026fb8:	06f50563          	beq	a0,a5,80027022 <spi_init+0x78>
            work_mode_offset = 8;
    80026fbc:	4321                	li	t1,8
            frf_offset = 22;
    80026fbe:	48d9                	li	a7,22
            dfs_offset = 0;
    80026fc0:	4801                	li	a6,0
    volatile spi_t *spi_adapter = spi[spi_num];
    80026fc2:	1502                	slli	a0,a0,0x20
    80026fc4:	9101                	srli	a0,a0,0x20
    80026fc6:	050e                	slli	a0,a0,0x3
    80026fc8:	00006797          	auipc	a5,0x6
    80026fcc:	88078793          	addi	a5,a5,-1920 # 8002c848 <spi>
    80026fd0:	953e                	add	a0,a0,a5
    80026fd2:	611c                	ld	a5,0(a0)
    if(spi_adapter->baudr == 0)
    80026fd4:	4bc8                	lw	a0,20(a5)
    80026fd6:	2501                	sext.w	a0,a0
    80026fd8:	e119                	bnez	a0,80026fde <spi_init+0x34>
        spi_adapter->baudr = 0x14;
    80026fda:	4551                	li	a0,20
    80026fdc:	cbc8                	sw	a0,20(a5)
    spi_adapter->imr = 0x00;
    80026fde:	0207a623          	sw	zero,44(a5)
    spi_adapter->dmacr = 0x00;
    80026fe2:	0407a623          	sw	zero,76(a5)
    spi_adapter->dmatdlr = 0x10;
    80026fe6:	4541                	li	a0,16
    80026fe8:	cba8                	sw	a0,80(a5)
    spi_adapter->dmardlr = 0x00;
    80026fea:	0407aa23          	sw	zero,84(a5)
    spi_adapter->ser = 0x00;
    80026fee:	0007a823          	sw	zero,16(a5)
    spi_adapter->ssienr = 0x00;
    80026ff2:	0007a423          	sw	zero,8(a5)
    spi_adapter->ctrlr0 = (work_mode << work_mode_offset) | (frame_format << frf_offset) | ((data_bit_length - 1) << dfs_offset);
    80026ff6:	006595bb          	sllw	a1,a1,t1
    80026ffa:	0116163b          	sllw	a2,a2,a7
    80026ffe:	8dd1                	or	a1,a1,a2
    80027000:	16fd                	addi	a3,a3,-1
    80027002:	010696b3          	sll	a3,a3,a6
    80027006:	8dd5                	or	a1,a1,a3
    80027008:	2581                	sext.w	a1,a1
    8002700a:	c38c                	sw	a1,0(a5)
    spi_adapter->spi_ctrlr0 = 0;
    8002700c:	0e07aa23          	sw	zero,244(a5)
    spi_adapter->endian = endian;
    80027010:	10e7ac23          	sw	a4,280(a5)
}
    80027014:	6422                	ld	s0,8(sp)
    80027016:	0141                	addi	sp,sp,16
    80027018:	8082                	ret
            work_mode_offset = 6;
    8002701a:	4319                	li	t1,6
            frf_offset = 21;
    8002701c:	48d5                	li	a7,21
            dfs_offset = 16;
    8002701e:	4841                	li	a6,16
    80027020:	b74d                	j	80026fc2 <spi_init+0x18>
    uint8 work_mode_offset = 0;
    80027022:	4301                	li	t1,0
    uint8 frf_offset = 0;
    80027024:	4881                	li	a7,0
    uint8 dfs_offset = 0;
    80027026:	4801                	li	a6,0
    80027028:	bf69                	j	80026fc2 <spi_init+0x18>

000000008002702a <spi_send_data_normal>:
        return SPI_TRANS_SHORT;
    return SPI_TRANS_INT;
}

void spi_send_data_normal(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *tx_buff, uint64 tx_len)
{
    8002702a:	7119                	addi	sp,sp,-128
    8002702c:	fc86                	sd	ra,120(sp)
    8002702e:	f8a2                	sd	s0,112(sp)
    80027030:	f4a6                	sd	s1,104(sp)
    80027032:	f0ca                	sd	s2,96(sp)
    80027034:	ecce                	sd	s3,88(sp)
    80027036:	e8d2                	sd	s4,80(sp)
    80027038:	e4d6                	sd	s5,72(sp)
    8002703a:	e0da                	sd	s6,64(sp)
    8002703c:	fc5e                	sd	s7,56(sp)
    8002703e:	f862                	sd	s8,48(sp)
    80027040:	f466                	sd	s9,40(sp)
    80027042:	f06a                	sd	s10,32(sp)
    80027044:	ec6e                	sd	s11,24(sp)
    80027046:	0100                	addi	s0,sp,128
    80027048:	84aa                	mv	s1,a0
    8002704a:	8aae                	mv	s5,a1
    8002704c:	89b2                	mv	s3,a2
    8002704e:	8a36                	mv	s4,a3
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    uint64 index, fifo_len;
    spi_set_tmod(spi_num, SPI_TMOD_TRANS);
    80027050:	4585                	li	a1,1
    80027052:	0ff57513          	andi	a0,a0,255
    80027056:	00000097          	auipc	ra,0x0
    8002705a:	f14080e7          	jalr	-236(ra) # 80026f6a <spi_set_tmod>

    volatile spi_t *spi_handle = spi[spi_num];
    8002705e:	02049793          	slli	a5,s1,0x20
    80027062:	9381                	srli	a5,a5,0x20
    80027064:	00379713          	slli	a4,a5,0x3
    80027068:	00005797          	auipc	a5,0x5
    8002706c:	7e078793          	addi	a5,a5,2016 # 8002c848 <spi>
    80027070:	97ba                	add	a5,a5,a4
    80027072:	0007b903          	ld	s2,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80027076:	0024b493          	sltiu	s1,s1,2
    8002707a:	0492                	slli	s1,s1,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    8002707c:	00092783          	lw	a5,0(s2)
    80027080:	0097d4bb          	srlw	s1,a5,s1
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80027084:	88fd                	andi	s1,s1,31
    if(data_bit_length < 8)
    80027086:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    80027088:	4b85                	li	s7,1
    if(data_bit_length < 8)
    8002708a:	0097f663          	bgeu	a5,s1,80027096 <spi_send_data_normal+0x6c>
    else if(data_bit_length < 16)
    8002708e:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    80027090:	4b91                	li	s7,4
    else if(data_bit_length < 16)
    80027092:	0297f863          	bgeu	a5,s1,800270c2 <spi_send_data_normal+0x98>

    uint8 v_misalign_flag = 0;
    uint32 v_send_data;
    if((uintptr_t)tx_buff % frame_width)
    80027096:	020b9c93          	slli	s9,s7,0x20
    8002709a:	020cdc93          	srli	s9,s9,0x20
    8002709e:	0399fcb3          	remu	s9,s3,s9
        v_misalign_flag = 1;

    spi_handle->ssienr = 0x01;
    800270a2:	4785                	li	a5,1
    800270a4:	00f92423          	sw	a5,8(s2)
    spi_handle->ser = 1U << chip_select;
    800270a8:	4585                	li	a1,1
    800270aa:	015595bb          	sllw	a1,a1,s5
    800270ae:	00b92823          	sw	a1,16(s2)
    uint32 i = 0;
    while(tx_len)
    800270b2:	120a0a63          	beqz	s4,800271e6 <spi_send_data_normal+0x1bc>
    uint32 i = 0;
    800270b6:	4481                	li	s1,0
    {
        fifo_len = 32 - spi_handle->txflr;
    800270b8:	02000c13          	li	s8,32
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
        switch(frame_width)
    800270bc:	4b09                	li	s6,2
    800270be:	4a91                	li	s5,4
    800270c0:	a0b5                	j	8002712c <spi_send_data_normal+0x102>
        return SPI_TRANS_SHORT;
    800270c2:	4b89                	li	s7,2
    800270c4:	bfc9                	j	80027096 <spi_send_data_normal+0x6c>
        {
            case SPI_TRANS_INT:
                fifo_len = fifo_len / 4 * 4;
    800270c6:	ffc77d13          	andi	s10,a4,-4
                if(v_misalign_flag)
    800270ca:	020c9763          	bnez	s9,800270f8 <spi_send_data_normal+0xce>
                        spi_handle->dr[0] = v_send_data;
                        i += 4;
                    }
                } else
                {
                    for(index = 0; index < fifo_len / 4; index++)
    800270ce:	8309                	srli	a4,a4,0x2
    800270d0:	009705bb          	addw	a1,a4,s1
    800270d4:	87a6                	mv	a5,s1
    800270d6:	c739                	beqz	a4,80027124 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint32 *)tx_buff)[i++];
    800270d8:	0017869b          	addiw	a3,a5,1
    800270dc:	0006861b          	sext.w	a2,a3
    800270e0:	1782                	slli	a5,a5,0x20
    800270e2:	9381                	srli	a5,a5,0x20
    800270e4:	078a                	slli	a5,a5,0x2
    800270e6:	97ce                	add	a5,a5,s3
    800270e8:	439c                	lw	a5,0(a5)
    800270ea:	06f92023          	sw	a5,96(s2)
    800270ee:	87b2                	mv	a5,a2
                    for(index = 0; index < fifo_len / 4; index++)
    800270f0:	fec594e3          	bne	a1,a2,800270d8 <spi_send_data_normal+0xae>
    800270f4:	9cb9                	addw	s1,s1,a4
    800270f6:	a03d                	j	80027124 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 4)
    800270f8:	020d0663          	beqz	s10,80027124 <spi_send_data_normal+0xfa>
    800270fc:	4d81                	li	s11,0
                        memmove(&v_send_data, tx_buff + i, 4);
    800270fe:	02049593          	slli	a1,s1,0x20
    80027102:	9181                	srli	a1,a1,0x20
    80027104:	8656                	mv	a2,s5
    80027106:	95ce                	add	a1,a1,s3
    80027108:	f8c40513          	addi	a0,s0,-116
    8002710c:	ffff9097          	auipc	ra,0xffff9
    80027110:	6bc080e7          	jalr	1724(ra) # 800207c8 <memmove>
                        spi_handle->dr[0] = v_send_data;
    80027114:	f8c42783          	lw	a5,-116(s0)
    80027118:	06f92023          	sw	a5,96(s2)
                        i += 4;
    8002711c:	2491                	addiw	s1,s1,4
                    for(index = 0; index < fifo_len; index += 4)
    8002711e:	0d91                	addi	s11,s11,4
    80027120:	fdadefe3          	bltu	s11,s10,800270fe <spi_send_data_normal+0xd4>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = tx_buff[i++];
                break;
        }
        tx_len -= fifo_len;
    80027124:	41aa0a33          	sub	s4,s4,s10
    while(tx_len)
    80027128:	0a0a0f63          	beqz	s4,800271e6 <spi_send_data_normal+0x1bc>
        fifo_len = 32 - spi_handle->txflr;
    8002712c:	02092703          	lw	a4,32(s2)
    80027130:	40ec073b          	subw	a4,s8,a4
    80027134:	1702                	slli	a4,a4,0x20
    80027136:	9301                	srli	a4,a4,0x20
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    80027138:	00ea7363          	bgeu	s4,a4,8002713e <spi_send_data_normal+0x114>
    8002713c:	8752                	mv	a4,s4
        switch(frame_width)
    8002713e:	036b8a63          	beq	s7,s6,80027172 <spi_send_data_normal+0x148>
    80027142:	f95b82e3          	beq	s7,s5,800270c6 <spi_send_data_normal+0x9c>
    80027146:	009705bb          	addw	a1,a4,s1
                for(index = 0; index < fifo_len; index++)
    8002714a:	87a6                	mv	a5,s1
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    8002714c:	8d3a                	mv	s10,a4
                for(index = 0; index < fifo_len; index++)
    8002714e:	db79                	beqz	a4,80027124 <spi_send_data_normal+0xfa>
                    spi_handle->dr[0] = tx_buff[i++];
    80027150:	0017869b          	addiw	a3,a5,1
    80027154:	0006861b          	sext.w	a2,a3
    80027158:	1782                	slli	a5,a5,0x20
    8002715a:	9381                	srli	a5,a5,0x20
    8002715c:	97ce                	add	a5,a5,s3
    8002715e:	0007c783          	lbu	a5,0(a5)
    80027162:	06f92023          	sw	a5,96(s2)
    80027166:	87b2                	mv	a5,a2
                for(index = 0; index < fifo_len; index++)
    80027168:	fec594e3          	bne	a1,a2,80027150 <spi_send_data_normal+0x126>
    8002716c:	9cb9                	addw	s1,s1,a4
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    8002716e:	8d3a                	mv	s10,a4
    80027170:	bf55                	j	80027124 <spi_send_data_normal+0xfa>
                fifo_len = fifo_len / 2 * 2;
    80027172:	ffe77d13          	andi	s10,a4,-2
                if(v_misalign_flag)
    80027176:	020c9863          	bnez	s9,800271a6 <spi_send_data_normal+0x17c>
                    for(index = 0; index < fifo_len / 2; index++)
    8002717a:	8305                	srli	a4,a4,0x1
    8002717c:	009705bb          	addw	a1,a4,s1
    80027180:	87a6                	mv	a5,s1
    80027182:	d34d                	beqz	a4,80027124 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint16 *)tx_buff)[i++];
    80027184:	0017869b          	addiw	a3,a5,1
    80027188:	0006861b          	sext.w	a2,a3
    8002718c:	1782                	slli	a5,a5,0x20
    8002718e:	9381                	srli	a5,a5,0x20
    80027190:	0786                	slli	a5,a5,0x1
    80027192:	97ce                	add	a5,a5,s3
    80027194:	0007d783          	lhu	a5,0(a5)
    80027198:	06f92023          	sw	a5,96(s2)
    8002719c:	87b2                	mv	a5,a2
                    for(index = 0; index < fifo_len / 2; index++)
    8002719e:	fec593e3          	bne	a1,a2,80027184 <spi_send_data_normal+0x15a>
    800271a2:	9cb9                	addw	s1,s1,a4
    800271a4:	b741                	j	80027124 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 2)
    800271a6:	f60d0fe3          	beqz	s10,80027124 <spi_send_data_normal+0xfa>
    800271aa:	fffd0d93          	addi	s11,s10,-1 # ffffffffffffefff <kernel_end+0xffffffff7ffb8fff>
    800271ae:	001ddd93          	srli	s11,s11,0x1
    800271b2:	001d9d9b          	slliw	s11,s11,0x1
    800271b6:	0024879b          	addiw	a5,s1,2
    800271ba:	00fd8dbb          	addw	s11,s11,a5
                        memmove(&v_send_data, tx_buff + i, 2);
    800271be:	02049593          	slli	a1,s1,0x20
    800271c2:	9181                	srli	a1,a1,0x20
    800271c4:	865a                	mv	a2,s6
    800271c6:	95ce                	add	a1,a1,s3
    800271c8:	f8c40513          	addi	a0,s0,-116
    800271cc:	ffff9097          	auipc	ra,0xffff9
    800271d0:	5fc080e7          	jalr	1532(ra) # 800207c8 <memmove>
                        spi_handle->dr[0] = v_send_data;
    800271d4:	f8c42783          	lw	a5,-116(s0)
    800271d8:	06f92023          	sw	a5,96(s2)
                        i += 2;
    800271dc:	2489                	addiw	s1,s1,2
                    for(index = 0; index < fifo_len; index += 2)
    800271de:	fe9d90e3          	bne	s11,s1,800271be <spi_send_data_normal+0x194>
                        i += 2;
    800271e2:	84ee                	mv	s1,s11
    800271e4:	b781                	j	80027124 <spi_send_data_normal+0xfa>
    }
    while((spi_handle->sr & 0x05) != 0x04)
    800271e6:	4711                	li	a4,4
    800271e8:	02892783          	lw	a5,40(s2)
    800271ec:	8b95                	andi	a5,a5,5
    800271ee:	fee79de3          	bne	a5,a4,800271e8 <spi_send_data_normal+0x1be>
        ;
    spi_handle->ser = 0x00;
    800271f2:	00092823          	sw	zero,16(s2)
    spi_handle->ssienr = 0x00;
    800271f6:	00092423          	sw	zero,8(s2)
}
    800271fa:	70e6                	ld	ra,120(sp)
    800271fc:	7446                	ld	s0,112(sp)
    800271fe:	74a6                	ld	s1,104(sp)
    80027200:	7906                	ld	s2,96(sp)
    80027202:	69e6                	ld	s3,88(sp)
    80027204:	6a46                	ld	s4,80(sp)
    80027206:	6aa6                	ld	s5,72(sp)
    80027208:	6b06                	ld	s6,64(sp)
    8002720a:	7be2                	ld	s7,56(sp)
    8002720c:	7c42                	ld	s8,48(sp)
    8002720e:	7ca2                	ld	s9,40(sp)
    80027210:	7d02                	ld	s10,32(sp)
    80027212:	6de2                	ld	s11,24(sp)
    80027214:	6109                	addi	sp,sp,128
    80027216:	8082                	ret

0000000080027218 <spi_send_data_standard>:

void spi_send_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                            uint64 cmd_len, const uint8 *tx_buff, uint64 tx_len)
{
    80027218:	715d                	addi	sp,sp,-80
    8002721a:	e486                	sd	ra,72(sp)
    8002721c:	e0a2                	sd	s0,64(sp)
    8002721e:	fc26                	sd	s1,56(sp)
    80027220:	f84a                	sd	s2,48(sp)
    80027222:	f44e                	sd	s3,40(sp)
    80027224:	f052                	sd	s4,32(sp)
    80027226:	ec56                	sd	s5,24(sp)
    80027228:	e85a                	sd	s6,16(sp)
    8002722a:	e45e                	sd	s7,8(sp)
    8002722c:	0880                	addi	s0,sp,80
    8002722e:	8a2a                	mv	s4,a0
    80027230:	8aae                	mv	s5,a1
    80027232:	8bb2                	mv	s7,a2
    80027234:	8936                	mv	s2,a3
    80027236:	8b3a                	mv	s6,a4
    80027238:	89be                	mv	s3,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    // uint8 *v_buf = malloc(cmd_len + tx_len);
    uint8 *v_buf = kalloc();
    8002723a:	ffff9097          	auipc	ra,0xffff9
    8002723e:	318080e7          	jalr	792(ra) # 80020552 <kalloc>
    80027242:	84aa                	mv	s1,a0
    uint64 i;
    for(i = 0; i < cmd_len; i++)
    80027244:	00090e63          	beqz	s2,80027260 <spi_send_data_standard+0x48>
    80027248:	87de                	mv	a5,s7
    8002724a:	872a                	mv	a4,a0
    8002724c:	012b8633          	add	a2,s7,s2
        v_buf[i] = cmd_buff[i];
    80027250:	0007c683          	lbu	a3,0(a5)
    80027254:	00d70023          	sb	a3,0(a4)
    80027258:	0785                	addi	a5,a5,1
    8002725a:	0705                	addi	a4,a4,1
    for(i = 0; i < cmd_len; i++)
    8002725c:	fec79ae3          	bne	a5,a2,80027250 <spi_send_data_standard+0x38>
    for(i = 0; i < tx_len; i++)
    80027260:	00098f63          	beqz	s3,8002727e <spi_send_data_standard+0x66>
    80027264:	87da                	mv	a5,s6
    80027266:	012486b3          	add	a3,s1,s2
    8002726a:	013b0733          	add	a4,s6,s3
        v_buf[cmd_len + i] = tx_buff[i];
    8002726e:	0007c603          	lbu	a2,0(a5)
    80027272:	00c68023          	sb	a2,0(a3)
    80027276:	0785                	addi	a5,a5,1
    80027278:	0685                	addi	a3,a3,1
    for(i = 0; i < tx_len; i++)
    8002727a:	fee79ae3          	bne	a5,a4,8002726e <spi_send_data_standard+0x56>

    spi_send_data_normal(spi_num, chip_select, v_buf, cmd_len + tx_len);
    8002727e:	013906b3          	add	a3,s2,s3
    80027282:	8626                	mv	a2,s1
    80027284:	85d6                	mv	a1,s5
    80027286:	8552                	mv	a0,s4
    80027288:	00000097          	auipc	ra,0x0
    8002728c:	da2080e7          	jalr	-606(ra) # 8002702a <spi_send_data_normal>
    // free((void *)v_buf);
    kfree((void *)v_buf);
    80027290:	8526                	mv	a0,s1
    80027292:	ffff9097          	auipc	ra,0xffff9
    80027296:	1a6080e7          	jalr	422(ra) # 80020438 <kfree>
}
    8002729a:	60a6                	ld	ra,72(sp)
    8002729c:	6406                	ld	s0,64(sp)
    8002729e:	74e2                	ld	s1,56(sp)
    800272a0:	7942                	ld	s2,48(sp)
    800272a2:	79a2                	ld	s3,40(sp)
    800272a4:	7a02                	ld	s4,32(sp)
    800272a6:	6ae2                	ld	s5,24(sp)
    800272a8:	6b42                	ld	s6,16(sp)
    800272aa:	6ba2                	ld	s7,8(sp)
    800272ac:	6161                	addi	sp,sp,80
    800272ae:	8082                	ret

00000000800272b0 <spi_receive_data_standard>:

void spi_receive_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                               uint64 cmd_len, uint8 *rx_buff, uint64 rx_len)
{
    800272b0:	7139                	addi	sp,sp,-64
    800272b2:	fc06                	sd	ra,56(sp)
    800272b4:	f822                	sd	s0,48(sp)
    800272b6:	f426                	sd	s1,40(sp)
    800272b8:	f04a                	sd	s2,32(sp)
    800272ba:	ec4e                	sd	s3,24(sp)
    800272bc:	e852                	sd	s4,16(sp)
    800272be:	e456                	sd	s5,8(sp)
    800272c0:	e05a                	sd	s6,0(sp)
    800272c2:	0080                	addi	s0,sp,64
    800272c4:	89aa                	mv	s3,a0
    800272c6:	8aae                	mv	s5,a1
    800272c8:	8932                	mv	s2,a2
    800272ca:	8a36                	mv	s4,a3
    800272cc:	84ba                	mv	s1,a4
    800272ce:	8b3e                	mv	s6,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    uint64 index, fifo_len;
    if(cmd_len == 0)
    800272d0:	eab5                	bnez	a3,80027344 <spi_receive_data_standard+0x94>
        spi_set_tmod(spi_num, SPI_TMOD_RECV);
    800272d2:	4589                	li	a1,2
    800272d4:	0ff57513          	andi	a0,a0,255
    800272d8:	00000097          	auipc	ra,0x0
    800272dc:	c92080e7          	jalr	-878(ra) # 80026f6a <spi_set_tmod>
    else
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    volatile spi_t *spi_handle = spi[spi_num];
    800272e0:	02099793          	slli	a5,s3,0x20
    800272e4:	9381                	srli	a5,a5,0x20
    800272e6:	00379713          	slli	a4,a5,0x3
    800272ea:	00005797          	auipc	a5,0x5
    800272ee:	55e78793          	addi	a5,a5,1374 # 8002c848 <spi>
    800272f2:	97ba                	add	a5,a5,a4
    800272f4:	6398                	ld	a4,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    800272f6:	0029b993          	sltiu	s3,s3,2
    800272fa:	0992                	slli	s3,s3,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    800272fc:	431c                	lw	a5,0(a4)
    800272fe:	0137d9bb          	srlw	s3,a5,s3
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80027302:	01f9f993          	andi	s3,s3,31
    if(data_bit_length < 8)
    80027306:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    80027308:	4605                	li	a2,1
    if(data_bit_length < 8)
    8002730a:	0137f663          	bgeu	a5,s3,80027316 <spi_receive_data_standard+0x66>
    else if(data_bit_length < 16)
    8002730e:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    80027310:	4611                	li	a2,4
    else if(data_bit_length < 16)
    80027312:	0537f163          	bgeu	a5,s3,80027354 <spi_receive_data_standard+0xa4>

    uint32 i = 0;
    uint64 v_cmd_len = cmd_len / frame_width;
    80027316:	02061793          	slli	a5,a2,0x20
    8002731a:	9381                	srli	a5,a5,0x20
    8002731c:	02fa58b3          	divu	a7,s4,a5
    uint32 v_rx_len = rx_len / frame_width;
    80027320:	02fb56b3          	divu	a3,s6,a5
    80027324:	2681                	sext.w	a3,a3

    spi_handle->ctrlr1 = (uint32)(v_rx_len - 1);
    80027326:	fff6859b          	addiw	a1,a3,-1
    8002732a:	c34c                	sw	a1,4(a4)
    spi_handle->ssienr = 0x01;
    8002732c:	4585                	li	a1,1
    8002732e:	c70c                	sw	a1,8(a4)

    while(v_cmd_len)
    80027330:	0cfa6163          	bltu	s4,a5,800273f2 <spi_receive_data_standard+0x142>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = cmd_buff[i++];
                break;
        }
        spi_handle->ser = 1U << chip_select;
    80027334:	015595bb          	sllw	a1,a1,s5
    uint32 i = 0;
    80027338:	4301                	li	t1,0
        fifo_len = 32 - spi_handle->txflr;
    8002733a:	02000f13          	li	t5,32
        switch(frame_width)
    8002733e:	4e89                	li	t4,2
    80027340:	4e11                	li	t3,4
    80027342:	a0a1                	j	8002738a <spi_receive_data_standard+0xda>
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    80027344:	458d                	li	a1,3
    80027346:	0ff57513          	andi	a0,a0,255
    8002734a:	00000097          	auipc	ra,0x0
    8002734e:	c20080e7          	jalr	-992(ra) # 80026f6a <spi_set_tmod>
    80027352:	b779                	j	800272e0 <spi_receive_data_standard+0x30>
        return SPI_TRANS_SHORT;
    80027354:	4609                	li	a2,2
    80027356:	b7c1                	j	80027316 <spi_receive_data_standard+0x66>
    80027358:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    8002735c:	879a                	mv	a5,t1
    8002735e:	c10d                	beqz	a0,80027380 <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = ((uint16 *)cmd_buff)[i++];
    80027360:	0017881b          	addiw	a6,a5,1
    80027364:	00080f9b          	sext.w	t6,a6
    80027368:	1782                	slli	a5,a5,0x20
    8002736a:	9381                	srli	a5,a5,0x20
    8002736c:	0786                	slli	a5,a5,0x1
    8002736e:	97ca                	add	a5,a5,s2
    80027370:	0007d783          	lhu	a5,0(a5)
    80027374:	d33c                	sw	a5,96(a4)
    80027376:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    80027378:	fff294e3          	bne	t0,t6,80027360 <spi_receive_data_standard+0xb0>
    8002737c:	00a3033b          	addw	t1,t1,a0
        spi_handle->ser = 1U << chip_select;
    80027380:	cb0c                	sw	a1,16(a4)
        v_cmd_len -= fifo_len;
    80027382:	40a888b3          	sub	a7,a7,a0
    while(v_cmd_len)
    80027386:	06088e63          	beqz	a7,80027402 <spi_receive_data_standard+0x152>
        fifo_len = 32 - spi_handle->txflr;
    8002738a:	5308                	lw	a0,32(a4)
    8002738c:	40af053b          	subw	a0,t5,a0
    80027390:	1502                	slli	a0,a0,0x20
    80027392:	9101                	srli	a0,a0,0x20
        fifo_len = fifo_len < v_cmd_len ? fifo_len : v_cmd_len;
    80027394:	00a8f363          	bgeu	a7,a0,8002739a <spi_receive_data_standard+0xea>
    80027398:	8546                	mv	a0,a7
        switch(frame_width)
    8002739a:	fbd60fe3          	beq	a2,t4,80027358 <spi_receive_data_standard+0xa8>
    8002739e:	03c61663          	bne	a2,t3,800273ca <spi_receive_data_standard+0x11a>
    800273a2:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    800273a6:	879a                	mv	a5,t1
    800273a8:	dd61                	beqz	a0,80027380 <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = ((uint32 *)cmd_buff)[i++];
    800273aa:	0017881b          	addiw	a6,a5,1
    800273ae:	00080f9b          	sext.w	t6,a6
    800273b2:	1782                	slli	a5,a5,0x20
    800273b4:	9381                	srli	a5,a5,0x20
    800273b6:	078a                	slli	a5,a5,0x2
    800273b8:	97ca                	add	a5,a5,s2
    800273ba:	439c                	lw	a5,0(a5)
    800273bc:	d33c                	sw	a5,96(a4)
    800273be:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    800273c0:	fff295e3          	bne	t0,t6,800273aa <spi_receive_data_standard+0xfa>
    800273c4:	00a3033b          	addw	t1,t1,a0
    800273c8:	bf65                	j	80027380 <spi_receive_data_standard+0xd0>
    800273ca:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    800273ce:	879a                	mv	a5,t1
    800273d0:	d945                	beqz	a0,80027380 <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = cmd_buff[i++];
    800273d2:	0017881b          	addiw	a6,a5,1
    800273d6:	00080f9b          	sext.w	t6,a6
    800273da:	1782                	slli	a5,a5,0x20
    800273dc:	9381                	srli	a5,a5,0x20
    800273de:	97ca                	add	a5,a5,s2
    800273e0:	0007c783          	lbu	a5,0(a5)
    800273e4:	d33c                	sw	a5,96(a4)
    800273e6:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    800273e8:	fff295e3          	bne	t0,t6,800273d2 <spi_receive_data_standard+0x122>
    800273ec:	00a3033b          	addw	t1,t1,a0
    800273f0:	bf41                	j	80027380 <spi_receive_data_standard+0xd0>
    }

    if(cmd_len == 0)
    800273f2:	000a1863          	bnez	s4,80027402 <spi_receive_data_standard+0x152>
    {
        spi_handle->dr[0] = 0xffffffff;
    800273f6:	57fd                	li	a5,-1
    800273f8:	d33c                	sw	a5,96(a4)
        spi_handle->ser = 1U << chip_select;
    800273fa:	4585                	li	a1,1
    800273fc:	015595bb          	sllw	a1,a1,s5
    80027400:	cb0c                	sw	a1,16(a4)
    }

    i = 0;
    while(v_rx_len)
    80027402:	c6c5                	beqz	a3,800274aa <spi_receive_data_standard+0x1fa>
    80027404:	4301                	li	t1,0
    {
        fifo_len = spi_handle->rxflr;
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
        switch(frame_width)
    80027406:	4e89                	li	t4,2
    80027408:	4e11                	li	t3,4
    8002740a:	a805                	j	8002743a <spi_receive_data_standard+0x18a>
    8002740c:	00650f3b          	addw	t5,a0,t1
            case SPI_TRANS_INT:
                for(index = 0; index < fifo_len; index++)
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
                break;
            case SPI_TRANS_SHORT:
                for(index = 0; index < fifo_len; index++)
    80027410:	879a                	mv	a5,t1
    80027412:	c115                	beqz	a0,80027436 <spi_receive_data_standard+0x186>
                    ((uint16 *)rx_buff)[i++] = (uint16)spi_handle->dr[0];
    80027414:	06072883          	lw	a7,96(a4)
    80027418:	0017859b          	addiw	a1,a5,1
    8002741c:	0005881b          	sext.w	a6,a1
    80027420:	1782                	slli	a5,a5,0x20
    80027422:	9381                	srli	a5,a5,0x20
    80027424:	0786                	slli	a5,a5,0x1
    80027426:	97a6                	add	a5,a5,s1
    80027428:	01179023          	sh	a7,0(a5)
    8002742c:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    8002742e:	ff0f13e3          	bne	t5,a6,80027414 <spi_receive_data_standard+0x164>
    80027432:	00a3033b          	addw	t1,t1,a0
                for(index = 0; index < fifo_len; index++)
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
                break;
        }

        v_rx_len -= fifo_len;
    80027436:	9e89                	subw	a3,a3,a0
    while(v_rx_len)
    80027438:	caad                	beqz	a3,800274aa <spi_receive_data_standard+0x1fa>
        fifo_len = spi_handle->rxflr;
    8002743a:	535c                	lw	a5,36(a4)
    8002743c:	1782                	slli	a5,a5,0x20
    8002743e:	9381                	srli	a5,a5,0x20
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
    80027440:	02069513          	slli	a0,a3,0x20
    80027444:	9101                	srli	a0,a0,0x20
    80027446:	00a7f363          	bgeu	a5,a0,8002744c <spi_receive_data_standard+0x19c>
    8002744a:	853e                	mv	a0,a5
        switch(frame_width)
    8002744c:	fdd600e3          	beq	a2,t4,8002740c <spi_receive_data_standard+0x15c>
    80027450:	03c61863          	bne	a2,t3,80027480 <spi_receive_data_standard+0x1d0>
    80027454:	00650f3b          	addw	t5,a0,t1
                for(index = 0; index < fifo_len; index++)
    80027458:	879a                	mv	a5,t1
    8002745a:	dd71                	beqz	a0,80027436 <spi_receive_data_standard+0x186>
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
    8002745c:	0017859b          	addiw	a1,a5,1
    80027460:	0005881b          	sext.w	a6,a1
    80027464:	06072883          	lw	a7,96(a4)
    80027468:	1782                	slli	a5,a5,0x20
    8002746a:	9381                	srli	a5,a5,0x20
    8002746c:	078a                	slli	a5,a5,0x2
    8002746e:	97a6                	add	a5,a5,s1
    80027470:	0117a023          	sw	a7,0(a5)
    80027474:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    80027476:	ff0f13e3          	bne	t5,a6,8002745c <spi_receive_data_standard+0x1ac>
    8002747a:	00a3033b          	addw	t1,t1,a0
    8002747e:	bf65                	j	80027436 <spi_receive_data_standard+0x186>
    80027480:	00650f3b          	addw	t5,a0,t1
                for(index = 0; index < fifo_len; index++)
    80027484:	879a                	mv	a5,t1
    80027486:	d945                	beqz	a0,80027436 <spi_receive_data_standard+0x186>
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
    80027488:	06072883          	lw	a7,96(a4)
    8002748c:	0017859b          	addiw	a1,a5,1
    80027490:	0005881b          	sext.w	a6,a1
    80027494:	1782                	slli	a5,a5,0x20
    80027496:	9381                	srli	a5,a5,0x20
    80027498:	97a6                	add	a5,a5,s1
    8002749a:	01178023          	sb	a7,0(a5)
    8002749e:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    800274a0:	ff0f14e3          	bne	t5,a6,80027488 <spi_receive_data_standard+0x1d8>
    800274a4:	00a3033b          	addw	t1,t1,a0
    800274a8:	b779                	j	80027436 <spi_receive_data_standard+0x186>
    }

    spi_handle->ser = 0x00;
    800274aa:	00072823          	sw	zero,16(a4)
    spi_handle->ssienr = 0x00;
    800274ae:	00072423          	sw	zero,8(a4)
}
    800274b2:	70e2                	ld	ra,56(sp)
    800274b4:	7442                	ld	s0,48(sp)
    800274b6:	74a2                	ld	s1,40(sp)
    800274b8:	7902                	ld	s2,32(sp)
    800274ba:	69e2                	ld	s3,24(sp)
    800274bc:	6a42                	ld	s4,16(sp)
    800274be:	6aa2                	ld	s5,8(sp)
    800274c0:	6b02                	ld	s6,0(sp)
    800274c2:	6121                	addi	sp,sp,64
    800274c4:	8082                	ret

00000000800274c6 <spi_receive_data_normal_dma>:

void spi_receive_data_normal_dma(dmac_channel_number_t dma_send_channel_num,
                                 dmac_channel_number_t dma_receive_channel_num,
                                 spi_device_num_t spi_num, spi_chip_select_t chip_select, const void *cmd_buff,
                                 uint64 cmd_len, void *rx_buff, uint64 rx_len)
{
    800274c6:	711d                	addi	sp,sp,-96
    800274c8:	ec86                	sd	ra,88(sp)
    800274ca:	e8a2                	sd	s0,80(sp)
    800274cc:	e4a6                	sd	s1,72(sp)
    800274ce:	e0ca                	sd	s2,64(sp)
    800274d0:	fc4e                	sd	s3,56(sp)
    800274d2:	f852                	sd	s4,48(sp)
    800274d4:	f456                	sd	s5,40(sp)
    800274d6:	f05a                	sd	s6,32(sp)
    800274d8:	ec5e                	sd	s7,24(sp)
    800274da:	e862                	sd	s8,16(sp)
    800274dc:	e466                	sd	s9,8(sp)
    800274de:	1080                	addi	s0,sp,96
    800274e0:	89ae                	mv	s3,a1
    800274e2:	8932                	mv	s2,a2
    800274e4:	8b36                	mv	s6,a3
    800274e6:	8ac2                	mv	s5,a6
    800274e8:	8a46                	mv	s4,a7
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    if(cmd_len == 0)
    800274ea:	e7c1                	bnez	a5,80027572 <spi_receive_data_normal_dma+0xac>
        spi_set_tmod(spi_num, SPI_TMOD_RECV);
    800274ec:	4589                	li	a1,2
    800274ee:	0ff67513          	andi	a0,a2,255
    800274f2:	00000097          	auipc	ra,0x0
    800274f6:	a78080e7          	jalr	-1416(ra) # 80026f6a <spi_set_tmod>
    else
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);

    volatile spi_t *spi_handle = spi[spi_num];
    800274fa:	02091793          	slli	a5,s2,0x20
    800274fe:	9381                	srli	a5,a5,0x20
    80027500:	00379713          	slli	a4,a5,0x3
    80027504:	00005797          	auipc	a5,0x5
    80027508:	34478793          	addi	a5,a5,836 # 8002c848 <spi>
    8002750c:	97ba                	add	a5,a5,a4
    8002750e:	6384                	ld	s1,0(a5)

    spi_handle->ctrlr1 = (uint32)(rx_len - 1);
    80027510:	fffa079b          	addiw	a5,s4,-1
    80027514:	c0dc                	sw	a5,4(s1)
    spi_handle->dmacr = 0x3;
    80027516:	478d                	li	a5,3
    80027518:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    8002751a:	4b85                	li	s7,1
    8002751c:	0174a423          	sw	s7,8(s1)
    if(cmd_len)
        sysctl_dma_select((sysctl_dma_channel_t)dma_send_channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    sysctl_dma_select((sysctl_dma_channel_t)dma_receive_channel_num, SYSCTL_DMA_SELECT_SSI0_RX_REQ + spi_num * 2);
    80027520:	0019159b          	slliw	a1,s2,0x1
    80027524:	854e                	mv	a0,s3
    80027526:	00002097          	auipc	ra,0x2
    8002752a:	be4080e7          	jalr	-1052(ra) # 8002910a <sysctl_dma_select>

    dmac_set_single_mode(dma_receive_channel_num, (void *)(&spi_handle->dr[0]), rx_buff, DMAC_ADDR_NOCHANGE, DMAC_ADDR_INCREMENT,
    8002752e:	88d2                	mv	a7,s4
    80027530:	4809                	li	a6,2
    80027532:	4781                	li	a5,0
    80027534:	4701                	li	a4,0
    80027536:	4685                	li	a3,1
    80027538:	8656                	mv	a2,s5
    8002753a:	06048593          	addi	a1,s1,96
    8002753e:	854e                	mv	a0,s3
    80027540:	00001097          	auipc	ra,0x1
    80027544:	6aa080e7          	jalr	1706(ra) # 80028bea <dmac_set_single_mode>
            frf_offset = 21;
    80027548:	47d5                	li	a5,21
    switch(spi_num)
    8002754a:	012bf763          	bgeu	s7,s2,80027558 <spi_receive_data_normal_dma+0x92>
    8002754e:	4709                	li	a4,2
    uint8 frf_offset = 0;
    80027550:	4781                	li	a5,0
    switch(spi_num)
    80027552:	00e90363          	beq	s2,a4,80027558 <spi_receive_data_normal_dma+0x92>
            frf_offset = 22;
    80027556:	47d9                	li	a5,22
    return ((spi_adapter->ctrlr0 >> frf_offset) & 0x3);
    80027558:	4098                	lw	a4,0(s1)
    8002755a:	00f757bb          	srlw	a5,a4,a5
                         DMAC_MSIZE_1, DMAC_TRANS_WIDTH_32, rx_len);
    if(cmd_len)
        dmac_set_single_mode(dma_send_channel_num, cmd_buff, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
                             DMAC_MSIZE_4, DMAC_TRANS_WIDTH_32, cmd_len);
    if(cmd_len == 0 && spi_get_frame_format(spi_num) == SPI_FF_STANDARD)
    8002755e:	8b8d                	andi	a5,a5,3
    80027560:	e399                	bnez	a5,80027566 <spi_receive_data_normal_dma+0xa0>
        spi[spi_num]->dr[0] = 0xffffffff;
    80027562:	57fd                	li	a5,-1
    80027564:	d0bc                	sw	a5,96(s1)
    spi_handle->ser = 1U << chip_select;
    80027566:	4785                	li	a5,1
    80027568:	01679b3b          	sllw	s6,a5,s6
    8002756c:	0164a823          	sw	s6,16(s1)
    if(cmd_len)
    80027570:	a04d                	j	80027612 <spi_receive_data_normal_dma+0x14c>
    80027572:	8baa                	mv	s7,a0
    80027574:	8cba                	mv	s9,a4
    80027576:	8c3e                	mv	s8,a5
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    80027578:	458d                	li	a1,3
    8002757a:	0ff67513          	andi	a0,a2,255
    8002757e:	00000097          	auipc	ra,0x0
    80027582:	9ec080e7          	jalr	-1556(ra) # 80026f6a <spi_set_tmod>
    volatile spi_t *spi_handle = spi[spi_num];
    80027586:	02091793          	slli	a5,s2,0x20
    8002758a:	9381                	srli	a5,a5,0x20
    8002758c:	00379713          	slli	a4,a5,0x3
    80027590:	00005797          	auipc	a5,0x5
    80027594:	2b878793          	addi	a5,a5,696 # 8002c848 <spi>
    80027598:	97ba                	add	a5,a5,a4
    8002759a:	6384                	ld	s1,0(a5)
    spi_handle->ctrlr1 = (uint32)(rx_len - 1);
    8002759c:	fffa079b          	addiw	a5,s4,-1
    800275a0:	c0dc                	sw	a5,4(s1)
    spi_handle->dmacr = 0x3;
    800275a2:	478d                	li	a5,3
    800275a4:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    800275a6:	4785                	li	a5,1
    800275a8:	c49c                	sw	a5,8(s1)
        sysctl_dma_select((sysctl_dma_channel_t)dma_send_channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    800275aa:	0019159b          	slliw	a1,s2,0x1
    800275ae:	0005891b          	sext.w	s2,a1
    800275b2:	2585                	addiw	a1,a1,1
    800275b4:	855e                	mv	a0,s7
    800275b6:	00002097          	auipc	ra,0x2
    800275ba:	b54080e7          	jalr	-1196(ra) # 8002910a <sysctl_dma_select>
    sysctl_dma_select((sysctl_dma_channel_t)dma_receive_channel_num, SYSCTL_DMA_SELECT_SSI0_RX_REQ + spi_num * 2);
    800275be:	85ca                	mv	a1,s2
    800275c0:	854e                	mv	a0,s3
    800275c2:	00002097          	auipc	ra,0x2
    800275c6:	b48080e7          	jalr	-1208(ra) # 8002910a <sysctl_dma_select>
    dmac_set_single_mode(dma_receive_channel_num, (void *)(&spi_handle->dr[0]), rx_buff, DMAC_ADDR_NOCHANGE, DMAC_ADDR_INCREMENT,
    800275ca:	06048913          	addi	s2,s1,96
    800275ce:	88d2                	mv	a7,s4
    800275d0:	4809                	li	a6,2
    800275d2:	4781                	li	a5,0
    800275d4:	4701                	li	a4,0
    800275d6:	4685                	li	a3,1
    800275d8:	8656                	mv	a2,s5
    800275da:	85ca                	mv	a1,s2
    800275dc:	854e                	mv	a0,s3
    800275de:	00001097          	auipc	ra,0x1
    800275e2:	60c080e7          	jalr	1548(ra) # 80028bea <dmac_set_single_mode>
        dmac_set_single_mode(dma_send_channel_num, cmd_buff, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    800275e6:	88e2                	mv	a7,s8
    800275e8:	4809                	li	a6,2
    800275ea:	4785                	li	a5,1
    800275ec:	4705                	li	a4,1
    800275ee:	4681                	li	a3,0
    800275f0:	864a                	mv	a2,s2
    800275f2:	85e6                	mv	a1,s9
    800275f4:	855e                	mv	a0,s7
    800275f6:	00001097          	auipc	ra,0x1
    800275fa:	5f4080e7          	jalr	1524(ra) # 80028bea <dmac_set_single_mode>
    spi_handle->ser = 1U << chip_select;
    800275fe:	4785                	li	a5,1
    80027600:	01679b3b          	sllw	s6,a5,s6
    80027604:	0164a823          	sw	s6,16(s1)
        dmac_wait_done(dma_send_channel_num);
    80027608:	855e                	mv	a0,s7
    8002760a:	00001097          	auipc	ra,0x1
    8002760e:	68c080e7          	jalr	1676(ra) # 80028c96 <dmac_wait_done>
    dmac_wait_done(dma_receive_channel_num);
    80027612:	854e                	mv	a0,s3
    80027614:	00001097          	auipc	ra,0x1
    80027618:	682080e7          	jalr	1666(ra) # 80028c96 <dmac_wait_done>

    spi_handle->ser = 0x00;
    8002761c:	0004a823          	sw	zero,16(s1)
    spi_handle->ssienr = 0x00;
    80027620:	0004a423          	sw	zero,8(s1)
}
    80027624:	60e6                	ld	ra,88(sp)
    80027626:	6446                	ld	s0,80(sp)
    80027628:	64a6                	ld	s1,72(sp)
    8002762a:	6906                	ld	s2,64(sp)
    8002762c:	79e2                	ld	s3,56(sp)
    8002762e:	7a42                	ld	s4,48(sp)
    80027630:	7aa2                	ld	s5,40(sp)
    80027632:	7b02                	ld	s6,32(sp)
    80027634:	6be2                	ld	s7,24(sp)
    80027636:	6c42                	ld	s8,16(sp)
    80027638:	6ca2                	ld	s9,8(sp)
    8002763a:	6125                	addi	sp,sp,96
    8002763c:	8082                	ret

000000008002763e <spi_send_data_normal_dma>:

void spi_send_data_normal_dma(dmac_channel_number_t channel_num, spi_device_num_t spi_num,
                              spi_chip_select_t chip_select,
                              const void *tx_buff, uint64 tx_len, spi_transfer_width_t spi_transfer_width)
{
    8002763e:	715d                	addi	sp,sp,-80
    80027640:	e486                	sd	ra,72(sp)
    80027642:	e0a2                	sd	s0,64(sp)
    80027644:	fc26                	sd	s1,56(sp)
    80027646:	f84a                	sd	s2,48(sp)
    80027648:	f44e                	sd	s3,40(sp)
    8002764a:	f052                	sd	s4,32(sp)
    8002764c:	ec56                	sd	s5,24(sp)
    8002764e:	e85a                	sd	s6,16(sp)
    80027650:	e45e                	sd	s7,8(sp)
    80027652:	0880                	addi	s0,sp,80
    80027654:	8a2a                	mv	s4,a0
    80027656:	89ae                	mv	s3,a1
    80027658:	8b32                	mv	s6,a2
    8002765a:	8936                	mv	s2,a3
    8002765c:	8aba                	mv	s5,a4
    8002765e:	8bbe                	mv	s7,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    spi_set_tmod(spi_num, SPI_TMOD_TRANS);
    80027660:	4585                	li	a1,1
    80027662:	0ff9f513          	andi	a0,s3,255
    80027666:	00000097          	auipc	ra,0x0
    8002766a:	904080e7          	jalr	-1788(ra) # 80026f6a <spi_set_tmod>
    volatile spi_t *spi_handle = spi[spi_num];
    8002766e:	02099793          	slli	a5,s3,0x20
    80027672:	9381                	srli	a5,a5,0x20
    80027674:	00379713          	slli	a4,a5,0x3
    80027678:	00005797          	auipc	a5,0x5
    8002767c:	1d078793          	addi	a5,a5,464 # 8002c848 <spi>
    80027680:	97ba                	add	a5,a5,a4
    80027682:	6384                	ld	s1,0(a5)
    uint32 *buf;
    int i;
    switch(spi_transfer_width)
    80027684:	4789                	li	a5,2
    80027686:	0afb8263          	beq	s7,a5,8002772a <spi_send_data_normal_dma+0xec>
    8002768a:	4791                	li	a5,4
    8002768c:	02fb8563          	beq	s7,a5,800276b6 <spi_send_data_normal_dma+0x78>
        case SPI_TRANS_INT:
            buf = (uint32 *)tx_buff;
            break;
        case SPI_TRANS_CHAR:
        default:
            buf = kalloc();
    80027690:	ffff9097          	auipc	ra,0xffff9
    80027694:	ec2080e7          	jalr	-318(ra) # 80020552 <kalloc>
            for(i = 0; i < tx_len; i++)
    80027698:	100a8563          	beqz	s5,800277a2 <spi_send_data_normal_dma+0x164>
    8002769c:	86ca                	mv	a3,s2
    8002769e:	87aa                	mv	a5,a0
    800276a0:	002a9613          	slli	a2,s5,0x2
    800276a4:	962a                	add	a2,a2,a0
                buf[i] = ((uint8 *)tx_buff)[i];
    800276a6:	0006c703          	lbu	a4,0(a3)
    800276aa:	c398                	sw	a4,0(a5)
    800276ac:	0685                	addi	a3,a3,1
    800276ae:	0791                	addi	a5,a5,4
            for(i = 0; i < tx_len; i++)
    800276b0:	fec79be3          	bne	a5,a2,800276a6 <spi_send_data_normal_dma+0x68>
            buf = kalloc();
    800276b4:	892a                	mv	s2,a0
            break;
    }
    spi_handle->dmacr = 0x2; /*enable dma transmit*/
    800276b6:	4789                	li	a5,2
    800276b8:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    800276ba:	4785                	li	a5,1
    800276bc:	c49c                	sw	a5,8(s1)

    sysctl_dma_select((sysctl_dma_channel_t)channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    800276be:	0019959b          	slliw	a1,s3,0x1
    800276c2:	2585                	addiw	a1,a1,1
    800276c4:	8552                	mv	a0,s4
    800276c6:	00002097          	auipc	ra,0x2
    800276ca:	a44080e7          	jalr	-1468(ra) # 8002910a <sysctl_dma_select>
    dmac_set_single_mode(channel_num, buf, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    800276ce:	88d6                	mv	a7,s5
    800276d0:	4809                	li	a6,2
    800276d2:	4785                	li	a5,1
    800276d4:	4705                	li	a4,1
    800276d6:	4681                	li	a3,0
    800276d8:	06048613          	addi	a2,s1,96
    800276dc:	85ca                	mv	a1,s2
    800276de:	8552                	mv	a0,s4
    800276e0:	00001097          	auipc	ra,0x1
    800276e4:	50a080e7          	jalr	1290(ra) # 80028bea <dmac_set_single_mode>
                         DMAC_MSIZE_4, DMAC_TRANS_WIDTH_32, tx_len);
    spi_handle->ser = 1U << chip_select;
    800276e8:	4785                	li	a5,1
    800276ea:	01679b3b          	sllw	s6,a5,s6
    800276ee:	0164a823          	sw	s6,16(s1)
    dmac_wait_done(channel_num);
    800276f2:	8552                	mv	a0,s4
    800276f4:	00001097          	auipc	ra,0x1
    800276f8:	5a2080e7          	jalr	1442(ra) # 80028c96 <dmac_wait_done>
    if(spi_transfer_width != SPI_TRANS_INT)
    800276fc:	4791                	li	a5,4
    800276fe:	0afb9463          	bne	s7,a5,800277a6 <spi_send_data_normal_dma+0x168>
        kfree((void *)buf);

    while((spi_handle->sr & 0x05) != 0x04)
    80027702:	4711                	li	a4,4
    80027704:	549c                	lw	a5,40(s1)
    80027706:	8b95                	andi	a5,a5,5
    80027708:	fee79ee3          	bne	a5,a4,80027704 <spi_send_data_normal_dma+0xc6>
        ;
    spi_handle->ser = 0x00;
    8002770c:	0004a823          	sw	zero,16(s1)
    spi_handle->ssienr = 0x00;
    80027710:	0004a423          	sw	zero,8(s1)
}
    80027714:	60a6                	ld	ra,72(sp)
    80027716:	6406                	ld	s0,64(sp)
    80027718:	74e2                	ld	s1,56(sp)
    8002771a:	7942                	ld	s2,48(sp)
    8002771c:	79a2                	ld	s3,40(sp)
    8002771e:	7a02                	ld	s4,32(sp)
    80027720:	6ae2                	ld	s5,24(sp)
    80027722:	6b42                	ld	s6,16(sp)
    80027724:	6ba2                	ld	s7,8(sp)
    80027726:	6161                	addi	sp,sp,80
    80027728:	8082                	ret
            buf = kalloc();
    8002772a:	ffff9097          	auipc	ra,0xffff9
    8002772e:	e28080e7          	jalr	-472(ra) # 80020552 <kalloc>
    80027732:	8baa                	mv	s7,a0
            for(i = 0; i < tx_len; i++)
    80027734:	000a8e63          	beqz	s5,80027750 <spi_send_data_normal_dma+0x112>
    80027738:	87ca                	mv	a5,s2
    8002773a:	872a                	mv	a4,a0
    8002773c:	001a9693          	slli	a3,s5,0x1
    80027740:	96ca                	add	a3,a3,s2
                buf[i] = ((uint16 *)tx_buff)[i];
    80027742:	0007d603          	lhu	a2,0(a5)
    80027746:	c310                	sw	a2,0(a4)
    80027748:	0789                	addi	a5,a5,2
    8002774a:	0711                	addi	a4,a4,4
            for(i = 0; i < tx_len; i++)
    8002774c:	fed79be3          	bne	a5,a3,80027742 <spi_send_data_normal_dma+0x104>
    spi_handle->dmacr = 0x2; /*enable dma transmit*/
    80027750:	4789                	li	a5,2
    80027752:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    80027754:	4785                	li	a5,1
    80027756:	c49c                	sw	a5,8(s1)
    sysctl_dma_select((sysctl_dma_channel_t)channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    80027758:	0019959b          	slliw	a1,s3,0x1
    8002775c:	2585                	addiw	a1,a1,1
    8002775e:	8552                	mv	a0,s4
    80027760:	00002097          	auipc	ra,0x2
    80027764:	9aa080e7          	jalr	-1622(ra) # 8002910a <sysctl_dma_select>
    dmac_set_single_mode(channel_num, buf, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    80027768:	88d6                	mv	a7,s5
    8002776a:	4809                	li	a6,2
    8002776c:	4785                	li	a5,1
    8002776e:	4705                	li	a4,1
    80027770:	4681                	li	a3,0
    80027772:	06048613          	addi	a2,s1,96
    80027776:	85de                	mv	a1,s7
    80027778:	8552                	mv	a0,s4
    8002777a:	00001097          	auipc	ra,0x1
    8002777e:	470080e7          	jalr	1136(ra) # 80028bea <dmac_set_single_mode>
    spi_handle->ser = 1U << chip_select;
    80027782:	4785                	li	a5,1
    80027784:	01679b3b          	sllw	s6,a5,s6
    80027788:	0164a823          	sw	s6,16(s1)
    dmac_wait_done(channel_num);
    8002778c:	8552                	mv	a0,s4
    8002778e:	00001097          	auipc	ra,0x1
    80027792:	508080e7          	jalr	1288(ra) # 80028c96 <dmac_wait_done>
        kfree((void *)buf);
    80027796:	855e                	mv	a0,s7
    80027798:	ffff9097          	auipc	ra,0xffff9
    8002779c:	ca0080e7          	jalr	-864(ra) # 80020438 <kfree>
    800277a0:	b78d                	j	80027702 <spi_send_data_normal_dma+0xc4>
            buf = kalloc();
    800277a2:	892a                	mv	s2,a0
    800277a4:	bf09                	j	800276b6 <spi_send_data_normal_dma+0x78>
    800277a6:	8bca                	mv	s7,s2
    800277a8:	b7fd                	j	80027796 <spi_send_data_normal_dma+0x158>

00000000800277aa <spi_receive_data_standard_dma>:

void spi_receive_data_standard_dma(dmac_channel_number_t dma_send_channel_num,
                                   dmac_channel_number_t dma_receive_channel_num,
                                   spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                                   uint64 cmd_len, uint8 *rx_buff, uint64 rx_len)
{
    800277aa:	711d                	addi	sp,sp,-96
    800277ac:	ec86                	sd	ra,88(sp)
    800277ae:	e8a2                	sd	s0,80(sp)
    800277b0:	e4a6                	sd	s1,72(sp)
    800277b2:	e0ca                	sd	s2,64(sp)
    800277b4:	fc4e                	sd	s3,56(sp)
    800277b6:	f852                	sd	s4,48(sp)
    800277b8:	f456                	sd	s5,40(sp)
    800277ba:	f05a                	sd	s6,32(sp)
    800277bc:	ec5e                	sd	s7,24(sp)
    800277be:	e862                	sd	s8,16(sp)
    800277c0:	e466                	sd	s9,8(sp)
    800277c2:	1080                	addi	s0,sp,96
    800277c4:	8b2a                	mv	s6,a0
    800277c6:	8bae                	mv	s7,a1
    800277c8:	8a32                	mv	s4,a2
    800277ca:	8c36                	mv	s8,a3
    800277cc:	8cba                	mv	s9,a4
    800277ce:	893e                	mv	s2,a5
    800277d0:	84c2                	mv	s1,a6
    800277d2:	8ac6                	mv	s5,a7
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    volatile spi_t *spi_handle = spi[spi_num];
    800277d4:	02061793          	slli	a5,a2,0x20
    800277d8:	9381                	srli	a5,a5,0x20
    800277da:	00379713          	slli	a4,a5,0x3
    800277de:	00005797          	auipc	a5,0x5
    800277e2:	06a78793          	addi	a5,a5,106 # 8002c848 <spi>
    800277e6:	97ba                	add	a5,a5,a4
    800277e8:	639c                	ld	a5,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    800277ea:	00263713          	sltiu	a4,a2,2
    800277ee:	0712                	slli	a4,a4,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    800277f0:	439c                	lw	a5,0(a5)
    800277f2:	00e7d7bb          	srlw	a5,a5,a4
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    800277f6:	8bfd                	andi	a5,a5,31
    if(data_bit_length < 8)
    800277f8:	471d                	li	a4,7
    800277fa:	08f77863          	bgeu	a4,a5,8002788a <spi_receive_data_standard_dma+0xe0>
    else if(data_bit_length < 16)
    800277fe:	473d                	li	a4,15
    80027800:	0ef77863          	bgeu	a4,a5,800278f0 <spi_receive_data_standard_dma+0x146>
    uint64 v_recv_len;
    uint64 v_cmd_len;
    switch(frame_width)
    {
        case SPI_TRANS_INT:
            write_cmd = kalloc();
    80027804:	ffff9097          	auipc	ra,0xffff9
    80027808:	d4e080e7          	jalr	-690(ra) # 80020552 <kalloc>
    8002780c:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 4; i++)
    8002780e:	00295793          	srli	a5,s2,0x2
    80027812:	458d                	li	a1,3
    80027814:	8766                	mv	a4,s9
    80027816:	862a                	mv	a2,a0
    80027818:	4681                	li	a3,0
    8002781a:	0d25f963          	bgeu	a1,s2,800278ec <spi_receive_data_standard_dma+0x142>
                write_cmd[i] = ((uint32 *)cmd_buff)[i];
    8002781e:	430c                	lw	a1,0(a4)
    80027820:	c20c                	sw	a1,0(a2)
            for(i = 0; i < cmd_len / 4; i++)
    80027822:	0685                	addi	a3,a3,1
    80027824:	0711                	addi	a4,a4,4
    80027826:	0611                	addi	a2,a2,4
    80027828:	fef6ebe3          	bltu	a3,a5,8002781e <spi_receive_data_standard_dma+0x74>
            read_buf = &write_cmd[i];
    8002782c:	068a                	slli	a3,a3,0x2
    8002782e:	00d98933          	add	s2,s3,a3
            v_recv_len = rx_len / 4;
    80027832:	002adc93          	srli	s9,s5,0x2
            v_recv_len = rx_len;
            v_cmd_len = cmd_len;
            break;
    }

    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    80027836:	88e6                	mv	a7,s9
    80027838:	884a                	mv	a6,s2
    8002783a:	874e                	mv	a4,s3
    8002783c:	86e2                	mv	a3,s8
    8002783e:	8652                	mv	a2,s4
    80027840:	85de                	mv	a1,s7
    80027842:	855a                	mv	a0,s6
    80027844:	00000097          	auipc	ra,0x0
    80027848:	c82080e7          	jalr	-894(ra) # 800274c6 <spi_receive_data_normal_dma>

    switch(frame_width)
    {
        case SPI_TRANS_INT:
            for(i = 0; i < v_recv_len; i++)
    8002784c:	470d                	li	a4,3
    8002784e:	884a                	mv	a6,s2
    80027850:	4781                	li	a5,0
    80027852:	01577a63          	bgeu	a4,s5,80027866 <spi_receive_data_standard_dma+0xbc>
                ((uint32 *)rx_buff)[i] = read_buf[i];
    80027856:	00082703          	lw	a4,0(a6)
    8002785a:	c098                	sw	a4,0(s1)
            for(i = 0; i < v_recv_len; i++)
    8002785c:	0785                	addi	a5,a5,1
    8002785e:	0811                	addi	a6,a6,4
    80027860:	0491                	addi	s1,s1,4
    80027862:	ff97eae3          	bltu	a5,s9,80027856 <spi_receive_data_standard_dma+0xac>
            for(i = 0; i < v_recv_len; i++)
                rx_buff[i] = read_buf[i];
            break;
    }

    kfree(write_cmd);
    80027866:	854e                	mv	a0,s3
    80027868:	ffff9097          	auipc	ra,0xffff9
    8002786c:	bd0080e7          	jalr	-1072(ra) # 80020438 <kfree>
}
    80027870:	60e6                	ld	ra,88(sp)
    80027872:	6446                	ld	s0,80(sp)
    80027874:	64a6                	ld	s1,72(sp)
    80027876:	6906                	ld	s2,64(sp)
    80027878:	79e2                	ld	s3,56(sp)
    8002787a:	7a42                	ld	s4,48(sp)
    8002787c:	7aa2                	ld	s5,40(sp)
    8002787e:	7b02                	ld	s6,32(sp)
    80027880:	6be2                	ld	s7,24(sp)
    80027882:	6c42                	ld	s8,16(sp)
    80027884:	6ca2                	ld	s9,8(sp)
    80027886:	6125                	addi	sp,sp,96
    80027888:	8082                	ret
            write_cmd = kalloc();
    8002788a:	ffff9097          	auipc	ra,0xffff9
    8002788e:	cc8080e7          	jalr	-824(ra) # 80020552 <kalloc>
    80027892:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len; i++)
    80027894:	04090a63          	beqz	s2,800278e8 <spi_receive_data_standard_dma+0x13e>
    80027898:	8766                	mv	a4,s9
    8002789a:	87ce                	mv	a5,s3
    8002789c:	00291613          	slli	a2,s2,0x2
    800278a0:	964e                	add	a2,a2,s3
                write_cmd[i] = cmd_buff[i];
    800278a2:	00074683          	lbu	a3,0(a4)
    800278a6:	c394                	sw	a3,0(a5)
    800278a8:	0705                	addi	a4,a4,1
    800278aa:	0791                	addi	a5,a5,4
            for(i = 0; i < cmd_len; i++)
    800278ac:	fef61be3          	bne	a2,a5,800278a2 <spi_receive_data_standard_dma+0xf8>
    800278b0:	8cca                	mv	s9,s2
            read_buf = &write_cmd[i];
    800278b2:	0c8a                	slli	s9,s9,0x2
    800278b4:	9cce                	add	s9,s9,s3
    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    800278b6:	88d6                	mv	a7,s5
    800278b8:	8866                	mv	a6,s9
    800278ba:	87ca                	mv	a5,s2
    800278bc:	874e                	mv	a4,s3
    800278be:	86e2                	mv	a3,s8
    800278c0:	8652                	mv	a2,s4
    800278c2:	85de                	mv	a1,s7
    800278c4:	855a                	mv	a0,s6
    800278c6:	00000097          	auipc	ra,0x0
    800278ca:	c00080e7          	jalr	-1024(ra) # 800274c6 <spi_receive_data_normal_dma>
            for(i = 0; i < v_recv_len; i++)
    800278ce:	f80a8ce3          	beqz	s5,80027866 <spi_receive_data_standard_dma+0xbc>
    800278d2:	87e6                	mv	a5,s9
    800278d4:	0a8a                	slli	s5,s5,0x2
    800278d6:	9ae6                	add	s5,s5,s9
                rx_buff[i] = read_buf[i];
    800278d8:	4398                	lw	a4,0(a5)
    800278da:	00e48023          	sb	a4,0(s1)
    800278de:	0791                	addi	a5,a5,4
    800278e0:	0485                	addi	s1,s1,1
            for(i = 0; i < v_recv_len; i++)
    800278e2:	ff579be3          	bne	a5,s5,800278d8 <spi_receive_data_standard_dma+0x12e>
    800278e6:	b741                	j	80027866 <spi_receive_data_standard_dma+0xbc>
            for(i = 0; i < cmd_len; i++)
    800278e8:	8cca                	mv	s9,s2
    800278ea:	b7e1                	j	800278b2 <spi_receive_data_standard_dma+0x108>
            for(i = 0; i < cmd_len / 4; i++)
    800278ec:	4781                	li	a5,0
    800278ee:	bf3d                	j	8002782c <spi_receive_data_standard_dma+0x82>
            write_cmd = kalloc();
    800278f0:	ffff9097          	auipc	ra,0xffff9
    800278f4:	c62080e7          	jalr	-926(ra) # 80020552 <kalloc>
    800278f8:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 2; i++)
    800278fa:	00195793          	srli	a5,s2,0x1
    800278fe:	4585                	li	a1,1
    80027900:	8766                	mv	a4,s9
    80027902:	862a                	mv	a2,a0
    80027904:	4681                	li	a3,0
    80027906:	0525f963          	bgeu	a1,s2,80027958 <spi_receive_data_standard_dma+0x1ae>
                write_cmd[i] = ((uint16 *)cmd_buff)[i];
    8002790a:	00075583          	lhu	a1,0(a4)
    8002790e:	c20c                	sw	a1,0(a2)
            for(i = 0; i < cmd_len / 2; i++)
    80027910:	0685                	addi	a3,a3,1
    80027912:	0709                	addi	a4,a4,2
    80027914:	0611                	addi	a2,a2,4
    80027916:	fef6eae3          	bltu	a3,a5,8002790a <spi_receive_data_standard_dma+0x160>
            read_buf = &write_cmd[i];
    8002791a:	068a                	slli	a3,a3,0x2
    8002791c:	00d98933          	add	s2,s3,a3
            v_recv_len = rx_len / 2;
    80027920:	001adc93          	srli	s9,s5,0x1
    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    80027924:	88e6                	mv	a7,s9
    80027926:	884a                	mv	a6,s2
    80027928:	874e                	mv	a4,s3
    8002792a:	86e2                	mv	a3,s8
    8002792c:	8652                	mv	a2,s4
    8002792e:	85de                	mv	a1,s7
    80027930:	855a                	mv	a0,s6
    80027932:	00000097          	auipc	ra,0x0
    80027936:	b94080e7          	jalr	-1132(ra) # 800274c6 <spi_receive_data_normal_dma>
            for(i = 0; i < v_recv_len; i++)
    8002793a:	4705                	li	a4,1
    8002793c:	884a                	mv	a6,s2
    8002793e:	4781                	li	a5,0
    80027940:	f35773e3          	bgeu	a4,s5,80027866 <spi_receive_data_standard_dma+0xbc>
                ((uint16 *)rx_buff)[i] = read_buf[i];
    80027944:	00082703          	lw	a4,0(a6)
    80027948:	00e49023          	sh	a4,0(s1)
            for(i = 0; i < v_recv_len; i++)
    8002794c:	0785                	addi	a5,a5,1
    8002794e:	0811                	addi	a6,a6,4
    80027950:	0489                	addi	s1,s1,2
    80027952:	ff97e9e3          	bltu	a5,s9,80027944 <spi_receive_data_standard_dma+0x19a>
    80027956:	bf01                	j	80027866 <spi_receive_data_standard_dma+0xbc>
            for(i = 0; i < cmd_len / 2; i++)
    80027958:	4781                	li	a5,0
    8002795a:	b7c1                	j	8002791a <spi_receive_data_standard_dma+0x170>

000000008002795c <spi_send_data_standard_dma>:

void spi_send_data_standard_dma(dmac_channel_number_t channel_num, spi_device_num_t spi_num,
                                spi_chip_select_t chip_select,
                                const uint8 *cmd_buff, uint64 cmd_len, const uint8 *tx_buff, uint64 tx_len)
{
    8002795c:	715d                	addi	sp,sp,-80
    8002795e:	e486                	sd	ra,72(sp)
    80027960:	e0a2                	sd	s0,64(sp)
    80027962:	fc26                	sd	s1,56(sp)
    80027964:	f84a                	sd	s2,48(sp)
    80027966:	f44e                	sd	s3,40(sp)
    80027968:	f052                	sd	s4,32(sp)
    8002796a:	ec56                	sd	s5,24(sp)
    8002796c:	e85a                	sd	s6,16(sp)
    8002796e:	e45e                	sd	s7,8(sp)
    80027970:	e062                	sd	s8,0(sp)
    80027972:	0880                	addi	s0,sp,80
    80027974:	8b2a                	mv	s6,a0
    80027976:	8a2e                	mv	s4,a1
    80027978:	8bb2                	mv	s7,a2
    8002797a:	8c36                	mv	s8,a3
    8002797c:	893a                	mv	s2,a4
    8002797e:	84be                	mv	s1,a5
    80027980:	8ac2                	mv	s5,a6
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    volatile spi_t *spi_handle = spi[spi_num];
    80027982:	02059793          	slli	a5,a1,0x20
    80027986:	9381                	srli	a5,a5,0x20
    80027988:	00379713          	slli	a4,a5,0x3
    8002798c:	00005797          	auipc	a5,0x5
    80027990:	ebc78793          	addi	a5,a5,-324 # 8002c848 <spi>
    80027994:	97ba                	add	a5,a5,a4
    80027996:	639c                	ld	a5,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80027998:	0025b713          	sltiu	a4,a1,2
    8002799c:	0712                	slli	a4,a4,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    8002799e:	439c                	lw	a5,0(a5)
    800279a0:	00e7d7bb          	srlw	a5,a5,a4
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    800279a4:	8bfd                	andi	a5,a5,31
    if(data_bit_length < 8)
    800279a6:	471d                	li	a4,7
    800279a8:	08f77763          	bgeu	a4,a5,80027a36 <spi_send_data_standard_dma+0xda>
    else if(data_bit_length < 16)
    800279ac:	473d                	li	a4,15
    800279ae:	0cf77863          	bgeu	a4,a5,80027a7e <spi_send_data_standard_dma+0x122>
    uint64 v_send_len;
    int i;
    switch(frame_width)
    {
        case SPI_TRANS_INT:
            buf = kalloc();
    800279b2:	ffff9097          	auipc	ra,0xffff9
    800279b6:	ba0080e7          	jalr	-1120(ra) # 80020552 <kalloc>
    800279ba:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 4; i++)
    800279bc:	00295793          	srli	a5,s2,0x2
    800279c0:	458d                	li	a1,3
    800279c2:	86e2                	mv	a3,s8
    800279c4:	862a                	mv	a2,a0
    800279c6:	4701                	li	a4,0
    800279c8:	0725f563          	bgeu	a1,s2,80027a32 <spi_send_data_standard_dma+0xd6>
                buf[i] = ((uint32 *)cmd_buff)[i];
    800279cc:	428c                	lw	a1,0(a3)
    800279ce:	c20c                	sw	a1,0(a2)
    800279d0:	0705                	addi	a4,a4,1
    800279d2:	0691                	addi	a3,a3,4
    800279d4:	0611                	addi	a2,a2,4
            for(i = 0; i < cmd_len / 4; i++)
    800279d6:	fef76be3          	bltu	a4,a5,800279cc <spi_send_data_standard_dma+0x70>
            for(i = 0; i < tx_len / 4; i++)
    800279da:	002ad613          	srli	a2,s5,0x2
    800279de:	470d                	li	a4,3
    800279e0:	01577c63          	bgeu	a4,s5,800279f8 <spi_send_data_standard_dma+0x9c>
    800279e4:	078a                	slli	a5,a5,0x2
    800279e6:	97ce                	add	a5,a5,s3
    800279e8:	4701                	li	a4,0
                buf[cmd_len / 4 + i] = ((uint32 *)tx_buff)[i];
    800279ea:	4094                	lw	a3,0(s1)
    800279ec:	c394                	sw	a3,0(a5)
    800279ee:	0705                	addi	a4,a4,1
    800279f0:	0491                	addi	s1,s1,4
    800279f2:	0791                	addi	a5,a5,4
            for(i = 0; i < tx_len / 4; i++)
    800279f4:	fec76be3          	bltu	a4,a2,800279ea <spi_send_data_standard_dma+0x8e>
            v_send_len = (cmd_len + tx_len) / 4;
    800279f8:	9956                	add	s2,s2,s5
    800279fa:	00295713          	srli	a4,s2,0x2
                buf[cmd_len + i] = tx_buff[i];
            v_send_len = cmd_len + tx_len;
            break;
    }

    spi_send_data_normal_dma(channel_num, spi_num, chip_select, buf, v_send_len, SPI_TRANS_INT);
    800279fe:	4791                	li	a5,4
    80027a00:	86ce                	mv	a3,s3
    80027a02:	865e                	mv	a2,s7
    80027a04:	85d2                	mv	a1,s4
    80027a06:	855a                	mv	a0,s6
    80027a08:	00000097          	auipc	ra,0x0
    80027a0c:	c36080e7          	jalr	-970(ra) # 8002763e <spi_send_data_normal_dma>

    kfree((void *)buf);
    80027a10:	854e                	mv	a0,s3
    80027a12:	ffff9097          	auipc	ra,0xffff9
    80027a16:	a26080e7          	jalr	-1498(ra) # 80020438 <kfree>
    80027a1a:	60a6                	ld	ra,72(sp)
    80027a1c:	6406                	ld	s0,64(sp)
    80027a1e:	74e2                	ld	s1,56(sp)
    80027a20:	7942                	ld	s2,48(sp)
    80027a22:	79a2                	ld	s3,40(sp)
    80027a24:	7a02                	ld	s4,32(sp)
    80027a26:	6ae2                	ld	s5,24(sp)
    80027a28:	6b42                	ld	s6,16(sp)
    80027a2a:	6ba2                	ld	s7,8(sp)
    80027a2c:	6c02                	ld	s8,0(sp)
    80027a2e:	6161                	addi	sp,sp,80
    80027a30:	8082                	ret
            for(i = 0; i < cmd_len / 4; i++)
    80027a32:	4781                	li	a5,0
    80027a34:	b75d                	j	800279da <spi_send_data_standard_dma+0x7e>
            buf = kalloc();
    80027a36:	ffff9097          	auipc	ra,0xffff9
    80027a3a:	b1c080e7          	jalr	-1252(ra) # 80020552 <kalloc>
    80027a3e:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len; i++)
    80027a40:	00090e63          	beqz	s2,80027a5c <spi_send_data_standard_dma+0x100>
    80027a44:	86e2                	mv	a3,s8
    80027a46:	87ce                	mv	a5,s3
    80027a48:	00291613          	slli	a2,s2,0x2
    80027a4c:	964e                	add	a2,a2,s3
                buf[i] = cmd_buff[i];
    80027a4e:	0006c703          	lbu	a4,0(a3)
    80027a52:	c398                	sw	a4,0(a5)
    80027a54:	0685                	addi	a3,a3,1
    80027a56:	0791                	addi	a5,a5,4
            for(i = 0; i < cmd_len; i++)
    80027a58:	fec79be3          	bne	a5,a2,80027a4e <spi_send_data_standard_dma+0xf2>
            for(i = 0; i < tx_len; i++)
    80027a5c:	000a8e63          	beqz	s5,80027a78 <spi_send_data_standard_dma+0x11c>
    80027a60:	87a6                	mv	a5,s1
    80027a62:	00291713          	slli	a4,s2,0x2
    80027a66:	974e                	add	a4,a4,s3
    80027a68:	94d6                	add	s1,s1,s5
                buf[cmd_len + i] = tx_buff[i];
    80027a6a:	0007c683          	lbu	a3,0(a5)
    80027a6e:	c314                	sw	a3,0(a4)
    80027a70:	0785                	addi	a5,a5,1
    80027a72:	0711                	addi	a4,a4,4
            for(i = 0; i < tx_len; i++)
    80027a74:	fe979be3          	bne	a5,s1,80027a6a <spi_send_data_standard_dma+0x10e>
            v_send_len = cmd_len + tx_len;
    80027a78:	01590733          	add	a4,s2,s5
            break;
    80027a7c:	b749                	j	800279fe <spi_send_data_standard_dma+0xa2>
            buf = kalloc();
    80027a7e:	ffff9097          	auipc	ra,0xffff9
    80027a82:	ad4080e7          	jalr	-1324(ra) # 80020552 <kalloc>
    80027a86:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 2; i++)
    80027a88:	00195793          	srli	a5,s2,0x1
    80027a8c:	4585                	li	a1,1
    80027a8e:	86e2                	mv	a3,s8
    80027a90:	862a                	mv	a2,a0
    80027a92:	4701                	li	a4,0
    80027a94:	0325fe63          	bgeu	a1,s2,80027ad0 <spi_send_data_standard_dma+0x174>
                buf[i] = ((uint16 *)cmd_buff)[i];
    80027a98:	0006d583          	lhu	a1,0(a3)
    80027a9c:	c20c                	sw	a1,0(a2)
    80027a9e:	0705                	addi	a4,a4,1
    80027aa0:	0689                	addi	a3,a3,2
    80027aa2:	0611                	addi	a2,a2,4
            for(i = 0; i < cmd_len / 2; i++)
    80027aa4:	fef76ae3          	bltu	a4,a5,80027a98 <spi_send_data_standard_dma+0x13c>
            for(i = 0; i < tx_len / 2; i++)
    80027aa8:	001ad613          	srli	a2,s5,0x1
    80027aac:	4705                	li	a4,1
    80027aae:	01577d63          	bgeu	a4,s5,80027ac8 <spi_send_data_standard_dma+0x16c>
    80027ab2:	078a                	slli	a5,a5,0x2
    80027ab4:	97ce                	add	a5,a5,s3
    80027ab6:	4701                	li	a4,0
                buf[cmd_len / 2 + i] = ((uint16 *)tx_buff)[i];
    80027ab8:	0004d683          	lhu	a3,0(s1)
    80027abc:	c394                	sw	a3,0(a5)
    80027abe:	0705                	addi	a4,a4,1
    80027ac0:	0489                	addi	s1,s1,2
    80027ac2:	0791                	addi	a5,a5,4
            for(i = 0; i < tx_len / 2; i++)
    80027ac4:	fec76ae3          	bltu	a4,a2,80027ab8 <spi_send_data_standard_dma+0x15c>
            v_send_len = (cmd_len + tx_len) / 2;
    80027ac8:	9956                	add	s2,s2,s5
    80027aca:	00195713          	srli	a4,s2,0x1
            break;
    80027ace:	bf05                	j	800279fe <spi_send_data_standard_dma+0xa2>
            for(i = 0; i < cmd_len / 2; i++)
    80027ad0:	4781                	li	a5,0
    80027ad2:	bfd9                	j	80027aa8 <spi_send_data_standard_dma+0x14c>

0000000080027ad4 <gpiohs_set_drive_mode>:
// } gpiohs_pin_instance_t;

// static gpiohs_pin_instance_t pin_instance[32];

void gpiohs_set_drive_mode(uint8 pin, gpio_drive_mode_t mode)
{
    80027ad4:	1101                	addi	sp,sp,-32
    80027ad6:	ec06                	sd	ra,24(sp)
    80027ad8:	e822                	sd	s0,16(sp)
    80027ada:	e426                	sd	s1,8(sp)
    80027adc:	e04a                	sd	s2,0(sp)
    80027ade:	1000                	addi	s0,sp,32
    80027ae0:	892a                	mv	s2,a0
    80027ae2:	84ae                	mv	s1,a1
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    int io_number = fpioa_get_io_by_function(FUNC_GPIOHS0 + pin);
    80027ae4:	0561                	addi	a0,a0,24
    80027ae6:	00000097          	auipc	ra,0x0
    80027aea:	32c080e7          	jalr	812(ra) # 80027e12 <fpioa_get_io_by_function>
    // configASSERT(io_number >= 0);

    fpioa_pull_t pull = FPIOA_PULL_NONE;
    uint32 dir = 0;

    switch(mode)
    80027aee:	4789                	li	a5,2
    80027af0:	02f48e63          	beq	s1,a5,80027b2c <gpiohs_set_drive_mode+0x58>
    80027af4:	478d                	li	a5,3
    80027af6:	00f48b63          	beq	s1,a5,80027b0c <gpiohs_set_drive_mode+0x38>
    80027afa:	4785                	li	a5,1
    80027afc:	02f48863          	beq	s1,a5,80027b2c <gpiohs_set_drive_mode+0x58>
        default:
            // configASSERT(!"GPIO drive mode is not supported.") 
            break;
    }

    fpioa_set_io_pull(io_number, pull);
    80027b00:	4581                	li	a1,0
    80027b02:	00000097          	auipc	ra,0x0
    80027b06:	094080e7          	jalr	148(ra) # 80027b96 <fpioa_set_io_pull>
    volatile uint32 *reg = dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027b0a:	a035                	j	80027b36 <gpiohs_set_drive_mode+0x62>
    fpioa_set_io_pull(io_number, pull);
    80027b0c:	4585                	li	a1,1
    80027b0e:	00000097          	auipc	ra,0x0
    80027b12:	088080e7          	jalr	136(ra) # 80027b96 <fpioa_set_io_pull>
    80027b16:	00005797          	auipc	a5,0x5
    80027b1a:	52a78793          	addi	a5,a5,1322 # 8002d040 <get_select_pll2+0x10>
    80027b1e:	6384                	ld	s1,0(a5)
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027b20:	00005797          	auipc	a5,0x5
    80027b24:	51878793          	addi	a5,a5,1304 # 8002d038 <get_select_pll2+0x8>
    80027b28:	6388                	ld	a0,0(a5)
    80027b2a:	a005                	j	80027b4a <gpiohs_set_drive_mode+0x76>
    fpioa_set_io_pull(io_number, pull);
    80027b2c:	85a6                	mv	a1,s1
    80027b2e:	00000097          	auipc	ra,0x0
    80027b32:	068080e7          	jalr	104(ra) # 80027b96 <fpioa_set_io_pull>
{
    80027b36:	00005797          	auipc	a5,0x5
    80027b3a:	50278793          	addi	a5,a5,1282 # 8002d038 <get_select_pll2+0x8>
    80027b3e:	6384                	ld	s1,0(a5)
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027b40:	00005797          	auipc	a5,0x5
    80027b44:	50078793          	addi	a5,a5,1280 # 8002d040 <get_select_pll2+0x10>
    80027b48:	6388                	ld	a0,0(a5)
    set_gpio_bit(reg_d, pin, 0);
    80027b4a:	4601                	li	a2,0
    80027b4c:	85ca                	mv	a1,s2
    80027b4e:	00000097          	auipc	ra,0x0
    80027b52:	398080e7          	jalr	920(ra) # 80027ee6 <set_gpio_bit>
    set_gpio_bit(reg, pin, 1);
    80027b56:	4605                	li	a2,1
    80027b58:	85ca                	mv	a1,s2
    80027b5a:	8526                	mv	a0,s1
    80027b5c:	00000097          	auipc	ra,0x0
    80027b60:	38a080e7          	jalr	906(ra) # 80027ee6 <set_gpio_bit>
}
    80027b64:	60e2                	ld	ra,24(sp)
    80027b66:	6442                	ld	s0,16(sp)
    80027b68:	64a2                	ld	s1,8(sp)
    80027b6a:	6902                	ld	s2,0(sp)
    80027b6c:	6105                	addi	sp,sp,32
    80027b6e:	8082                	ret

0000000080027b70 <gpiohs_set_pin>:
//     // configASSERT(pin < GPIOHS_MAX_PINNO);
//     return get_gpio_bit(gpiohs->input_val.u32, pin);
// }

void gpiohs_set_pin(uint8 pin, gpio_pin_value_t value)
{
    80027b70:	1141                	addi	sp,sp,-16
    80027b72:	e406                	sd	ra,8(sp)
    80027b74:	e022                	sd	s0,0(sp)
    80027b76:	0800                	addi	s0,sp,16
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    set_gpio_bit(gpiohs->output_val.u32, pin, value);
    80027b78:	862e                	mv	a2,a1
    80027b7a:	85aa                	mv	a1,a0
    80027b7c:	00005797          	auipc	a5,0x5
    80027b80:	4cc78793          	addi	a5,a5,1228 # 8002d048 <get_select_pll2+0x18>
    80027b84:	6388                	ld	a0,0(a5)
    80027b86:	00000097          	auipc	ra,0x0
    80027b8a:	360080e7          	jalr	864(ra) # 80027ee6 <set_gpio_bit>
}
    80027b8e:	60a2                	ld	ra,8(sp)
    80027b90:	6402                	ld	s0,0(sp)
    80027b92:	0141                	addi	sp,sp,16
    80027b94:	8082                	ret

0000000080027b96 <fpioa_set_io_pull>:
//     fpioa->io[number] = *cfg;
//     return 0;
// }

int fpioa_set_io_pull(int number, fpioa_pull_t pull)
{
    80027b96:	1141                	addi	sp,sp,-16
    80027b98:	e422                	sd	s0,8(sp)
    80027b9a:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || pull >= FPIOA_PULL_MAX)
    80027b9c:	02f00793          	li	a5,47
    80027ba0:	06a7ef63          	bltu	a5,a0,80027c1e <fpioa_set_io_pull+0x88>
    80027ba4:	862a                	mv	a2,a0
    80027ba6:	4789                	li	a5,2
    80027ba8:	06b7ed63          	bltu	a5,a1,80027c22 <fpioa_set_io_pull+0x8c>
        return -1;

    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80027bac:	003f5737          	lui	a4,0x3f5
    80027bb0:	00251793          	slli	a5,a0,0x2
    80027bb4:	02b70713          	addi	a4,a4,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027bb8:	0742                	slli	a4,a4,0x10
    80027bba:	97ba                	add	a5,a5,a4
    80027bbc:	439c                	lw	a5,0(a5)
    80027bbe:	0107d69b          	srliw	a3,a5,0x10
    80027bc2:	8a85                	andi	a3,a3,1
    80027bc4:	0117d71b          	srliw	a4,a5,0x11
    80027bc8:	8b05                	andi	a4,a4,1

    switch(pull)
    80027bca:	4505                	li	a0,1
    80027bcc:	04a58063          	beq	a1,a0,80027c0c <fpioa_set_io_pull+0x76>
    80027bd0:	c1a9                	beqz	a1,80027c12 <fpioa_set_io_pull+0x7c>
    80027bd2:	4509                	li	a0,2
    80027bd4:	04a58263          	beq	a1,a0,80027c18 <fpioa_set_io_pull+0x82>
            break;
        default:
            break;
    }
    /* Atomic write register */
    fpioa->io[number] = cfg;
    80027bd8:	8a85                	andi	a3,a3,1
    80027bda:	0106969b          	slliw	a3,a3,0x10
    80027bde:	75c1                	lui	a1,0xffff0
    80027be0:	15fd                	addi	a1,a1,-1
    80027be2:	8fed                	and	a5,a5,a1
    80027be4:	8fd5                	or	a5,a5,a3
    80027be6:	8b05                	andi	a4,a4,1
    80027be8:	0117171b          	slliw	a4,a4,0x11
    80027bec:	7681                	lui	a3,0xfffe0
    80027bee:	16fd                	addi	a3,a3,-1
    80027bf0:	8ff5                	and	a5,a5,a3
    80027bf2:	8fd9                	or	a5,a5,a4
    80027bf4:	003f5537          	lui	a0,0x3f5
    80027bf8:	060a                	slli	a2,a2,0x2
    80027bfa:	02b50513          	addi	a0,a0,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027bfe:	0542                	slli	a0,a0,0x10
    80027c00:	9532                	add	a0,a0,a2
    80027c02:	c11c                	sw	a5,0(a0)
    return 0;
    80027c04:	4501                	li	a0,0
}
    80027c06:	6422                	ld	s0,8(sp)
    80027c08:	0141                	addi	sp,sp,16
    80027c0a:	8082                	ret
            cfg.pd = 1;
    80027c0c:	4705                	li	a4,1
            cfg.pu = 0;
    80027c0e:	4681                	li	a3,0
    80027c10:	b7e1                	j	80027bd8 <fpioa_set_io_pull+0x42>
            cfg.pd = 0;
    80027c12:	4701                	li	a4,0
            cfg.pu = 0;
    80027c14:	4681                	li	a3,0
    80027c16:	b7c9                	j	80027bd8 <fpioa_set_io_pull+0x42>
            cfg.pd = 0;
    80027c18:	4701                	li	a4,0
            cfg.pu = 1;
    80027c1a:	4685                	li	a3,1
    80027c1c:	bf75                	j	80027bd8 <fpioa_set_io_pull+0x42>
        return -1;
    80027c1e:	557d                	li	a0,-1
    80027c20:	b7dd                	j	80027c06 <fpioa_set_io_pull+0x70>
    80027c22:	557d                	li	a0,-1
    80027c24:	b7cd                	j	80027c06 <fpioa_set_io_pull+0x70>

0000000080027c26 <fpioa_set_function_raw>:

//     return fpioa->io[number].ds;
// }

int fpioa_set_function_raw(int number, fpioa_function_t function)
{
    80027c26:	1141                	addi	sp,sp,-16
    80027c28:	e422                	sd	s0,8(sp)
    80027c2a:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027c2c:	02f00793          	li	a5,47
    80027c30:	12a7ec63          	bltu	a5,a0,80027d68 <fpioa_set_function_raw+0x142>
    80027c34:	882a                	mv	a6,a0
    80027c36:	0ff00793          	li	a5,255
    80027c3a:	12b7e963          	bltu	a5,a1,80027d6c <fpioa_set_function_raw+0x146>
        return -1;
    /* Atomic write register */
    fpioa->io[number] = (const fpioa_io_config_t){
        .ch_sel = function_config[function].ch_sel,
    80027c3e:	1582                	slli	a1,a1,0x20
    80027c40:	9181                	srli	a1,a1,0x20
    80027c42:	058a                	slli	a1,a1,0x2
    80027c44:	00005397          	auipc	t2,0x5
    80027c48:	c2438393          	addi	t2,t2,-988 # 8002c868 <function_config>
    80027c4c:	93ae                	add	t2,t2,a1
        .ds = function_config[function].ds,
    80027c4e:	0003a583          	lw	a1,0(t2)
    80027c52:	0085d61b          	srliw	a2,a1,0x8
        .oe_en = function_config[function].oe_en,
    80027c56:	00c5d69b          	srliw	a3,a1,0xc
        .oe_inv = function_config[function].oe_inv,
    80027c5a:	00d5df9b          	srliw	t6,a1,0xd
        .do_sel = function_config[function].do_sel,
    80027c5e:	00e5df1b          	srliw	t5,a1,0xe
        .do_inv = function_config[function].do_inv,
    80027c62:	00f5d71b          	srliw	a4,a1,0xf
        .pu = function_config[function].pu,
    80027c66:	0105de9b          	srliw	t4,a1,0x10
        .pd = function_config[function].pd,
    80027c6a:	0115de1b          	srliw	t3,a1,0x11
        .sl = function_config[function].sl,
    80027c6e:	0135d79b          	srliw	a5,a1,0x13
        .ie_en = function_config[function].ie_en,
    80027c72:	0145d31b          	srliw	t1,a1,0x14
        .ie_inv = function_config[function].ie_inv,
    80027c76:	0155d89b          	srliw	a7,a1,0x15
        .di_inv = function_config[function].di_inv,
    80027c7a:	0165d51b          	srliw	a0,a1,0x16
        .st = function_config[function].st,
    80027c7e:	0175d59b          	srliw	a1,a1,0x17
    fpioa->io[number] = (const fpioa_io_config_t){
    80027c82:	8a3d                	andi	a2,a2,15
    80027c84:	0086129b          	slliw	t0,a2,0x8
    80027c88:	0003c603          	lbu	a2,0(t2)
    80027c8c:	00566633          	or	a2,a2,t0
    80027c90:	8a85                	andi	a3,a3,1
    80027c92:	00c6969b          	slliw	a3,a3,0xc
    80027c96:	72fd                	lui	t0,0xfffff
    80027c98:	12fd                	addi	t0,t0,-1
    80027c9a:	00567633          	and	a2,a2,t0
    80027c9e:	8e55                	or	a2,a2,a3
    80027ca0:	001fff93          	andi	t6,t6,1
    80027ca4:	00df9f9b          	slliw	t6,t6,0xd
    80027ca8:	76f9                	lui	a3,0xffffe
    80027caa:	16fd                	addi	a3,a3,-1
    80027cac:	8ef1                	and	a3,a3,a2
    80027cae:	01f6e633          	or	a2,a3,t6
    80027cb2:	001f7693          	andi	a3,t5,1
    80027cb6:	00e69f1b          	slliw	t5,a3,0xe
    80027cba:	76f1                	lui	a3,0xffffc
    80027cbc:	16fd                	addi	a3,a3,-1
    80027cbe:	8ef1                	and	a3,a3,a2
    80027cc0:	01e6e6b3          	or	a3,a3,t5
    80027cc4:	8b05                	andi	a4,a4,1
    80027cc6:	00f7171b          	slliw	a4,a4,0xf
    80027cca:	7661                	lui	a2,0xffff8
    80027ccc:	167d                	addi	a2,a2,-1
    80027cce:	8ef1                	and	a3,a3,a2
    80027cd0:	8ed9                	or	a3,a3,a4
    80027cd2:	001ef613          	andi	a2,t4,1
    80027cd6:	0106161b          	slliw	a2,a2,0x10
    80027cda:	7741                	lui	a4,0xffff0
    80027cdc:	177d                	addi	a4,a4,-1
    80027cde:	8f75                	and	a4,a4,a3
    80027ce0:	00c766b3          	or	a3,a4,a2
    80027ce4:	001e7713          	andi	a4,t3,1
    80027ce8:	0117161b          	slliw	a2,a4,0x11
    80027cec:	7701                	lui	a4,0xfffe0
    80027cee:	177d                	addi	a4,a4,-1
    80027cf0:	8f75                	and	a4,a4,a3
    80027cf2:	8f51                	or	a4,a4,a2
    80027cf4:	8b85                	andi	a5,a5,1
    80027cf6:	0137979b          	slliw	a5,a5,0x13
    80027cfa:	fff806b7          	lui	a3,0xfff80
    80027cfe:	16fd                	addi	a3,a3,-1
    80027d00:	8f75                	and	a4,a4,a3
    80027d02:	8f5d                	or	a4,a4,a5
    80027d04:	00137693          	andi	a3,t1,1
    80027d08:	0146969b          	slliw	a3,a3,0x14
    80027d0c:	fff007b7          	lui	a5,0xfff00
    80027d10:	17fd                	addi	a5,a5,-1
    80027d12:	8ff9                	and	a5,a5,a4
    80027d14:	00d7e733          	or	a4,a5,a3
    80027d18:	0018f793          	andi	a5,a7,1
    80027d1c:	0157969b          	slliw	a3,a5,0x15
    80027d20:	ffe007b7          	lui	a5,0xffe00
    80027d24:	17fd                	addi	a5,a5,-1
    80027d26:	8ff9                	and	a5,a5,a4
    80027d28:	8fd5                	or	a5,a5,a3
    80027d2a:	00157713          	andi	a4,a0,1
    80027d2e:	0167171b          	slliw	a4,a4,0x16
    80027d32:	ffc006b7          	lui	a3,0xffc00
    80027d36:	16fd                	addi	a3,a3,-1
    80027d38:	8ff5                	and	a5,a5,a3
    80027d3a:	8fd9                	or	a5,a5,a4
    80027d3c:	8985                	andi	a1,a1,1
    80027d3e:	0175959b          	slliw	a1,a1,0x17
    80027d42:	ff800737          	lui	a4,0xff800
    80027d46:	177d                	addi	a4,a4,-1
    80027d48:	8ff9                	and	a5,a5,a4
    80027d4a:	8fcd                	or	a5,a5,a1
    80027d4c:	003f5737          	lui	a4,0x3f5
    80027d50:	00281693          	slli	a3,a6,0x2
    80027d54:	02b70813          	addi	a6,a4,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027d58:	0842                	slli	a6,a6,0x10
    80027d5a:	9836                	add	a6,a6,a3
    80027d5c:	00f82023          	sw	a5,0(a6)
        /* resv and pad_di do not need initialization */
    };
    return 0;
    80027d60:	4501                	li	a0,0
}
    80027d62:	6422                	ld	s0,8(sp)
    80027d64:	0141                	addi	sp,sp,16
    80027d66:	8082                	ret
        return -1;
    80027d68:	557d                	li	a0,-1
    80027d6a:	bfe5                	j	80027d62 <fpioa_set_function_raw+0x13c>
    80027d6c:	557d                	li	a0,-1
    80027d6e:	bfd5                	j	80027d62 <fpioa_set_function_raw+0x13c>

0000000080027d70 <fpioa_set_function>:

int fpioa_set_function(int number, fpioa_function_t function)
{
    uint8 index = 0;
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027d70:	02f00793          	li	a5,47
    80027d74:	08a7eb63          	bltu	a5,a0,80027e0a <fpioa_set_function+0x9a>
{
    80027d78:	7139                	addi	sp,sp,-64
    80027d7a:	fc06                	sd	ra,56(sp)
    80027d7c:	f822                	sd	s0,48(sp)
    80027d7e:	f426                	sd	s1,40(sp)
    80027d80:	f04a                	sd	s2,32(sp)
    80027d82:	ec4e                	sd	s3,24(sp)
    80027d84:	e852                	sd	s4,16(sp)
    80027d86:	e456                	sd	s5,8(sp)
    80027d88:	0080                	addi	s0,sp,64
    80027d8a:	8aaa                	mv	s5,a0
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027d8c:	0ff00793          	li	a5,255
    80027d90:	06b7ef63          	bltu	a5,a1,80027e0e <fpioa_set_function+0x9e>
    80027d94:	892e                	mv	s2,a1
        return -1;
    if(function == FUNC_RESV0)
    80027d96:	07800793          	li	a5,120
    80027d9a:	4481                	li	s1,0
    80027d9c:	00f58a63          	beq	a1,a5,80027db0 <fpioa_set_function+0x40>
        return 0;
    }
    /* Compare all IO */
    for(index = 0; index < FPIOA_NUM_IO; index++)
    {
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80027da0:	003f59b7          	lui	s3,0x3f5
    80027da4:	02b98993          	addi	s3,s3,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027da8:	09c2                	slli	s3,s3,0x10
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027daa:	03000a13          	li	s4,48
    80027dae:	a821                	j	80027dc6 <fpioa_set_function+0x56>
        fpioa_set_function_raw(number, FUNC_RESV0);
    80027db0:	07800593          	li	a1,120
    80027db4:	00000097          	auipc	ra,0x0
    80027db8:	e72080e7          	jalr	-398(ra) # 80027c26 <fpioa_set_function_raw>
        return 0;
    80027dbc:	4501                	li	a0,0
    80027dbe:	a82d                	j	80027df8 <fpioa_set_function+0x88>
    80027dc0:	2485                	addiw	s1,s1,1
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027dc2:	03448463          	beq	s1,s4,80027dea <fpioa_set_function+0x7a>
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80027dc6:	0004851b          	sext.w	a0,s1
    80027dca:	00251793          	slli	a5,a0,0x2
    80027dce:	97ce                	add	a5,a5,s3
    80027dd0:	0007c783          	lbu	a5,0(a5) # ffffffffffe00000 <kernel_end+0xffffffff7fdba000>
    80027dd4:	fef916e3          	bne	s2,a5,80027dc0 <fpioa_set_function+0x50>
    80027dd8:	ff5504e3          	beq	a0,s5,80027dc0 <fpioa_set_function+0x50>
            fpioa_set_function_raw(index, FUNC_RESV0);
    80027ddc:	07800593          	li	a1,120
    80027de0:	00000097          	auipc	ra,0x0
    80027de4:	e46080e7          	jalr	-442(ra) # 80027c26 <fpioa_set_function_raw>
    80027de8:	bfe1                	j	80027dc0 <fpioa_set_function+0x50>
    }
    fpioa_set_function_raw(number, function);
    80027dea:	85ca                	mv	a1,s2
    80027dec:	8556                	mv	a0,s5
    80027dee:	00000097          	auipc	ra,0x0
    80027df2:	e38080e7          	jalr	-456(ra) # 80027c26 <fpioa_set_function_raw>
    return 0;
    80027df6:	4501                	li	a0,0
}
    80027df8:	70e2                	ld	ra,56(sp)
    80027dfa:	7442                	ld	s0,48(sp)
    80027dfc:	74a2                	ld	s1,40(sp)
    80027dfe:	7902                	ld	s2,32(sp)
    80027e00:	69e2                	ld	s3,24(sp)
    80027e02:	6a42                	ld	s4,16(sp)
    80027e04:	6aa2                	ld	s5,8(sp)
    80027e06:	6121                	addi	sp,sp,64
    80027e08:	8082                	ret
        return -1;
    80027e0a:	557d                	li	a0,-1
}
    80027e0c:	8082                	ret
        return -1;
    80027e0e:	557d                	li	a0,-1
    80027e10:	b7e5                	j	80027df8 <fpioa_set_function+0x88>

0000000080027e12 <fpioa_get_io_by_function>:
//         fpioa->tie.val[function / 32] &= (~(1UL << (function % 32)));
//     return 0;
// }

int fpioa_get_io_by_function(fpioa_function_t function)
{
    80027e12:	1141                	addi	sp,sp,-16
    80027e14:	e422                	sd	s0,8(sp)
    80027e16:	0800                	addi	s0,sp,16
    int index = 0;
    for(index = 0; index < FPIOA_NUM_IO; index++)
    {
        if(fpioa->io[index].ch_sel == function)
    80027e18:	003f57b7          	lui	a5,0x3f5
    80027e1c:	02b78793          	addi	a5,a5,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027e20:	07c2                	slli	a5,a5,0x10
    80027e22:	0007c783          	lbu	a5,0(a5)
    80027e26:	02f50963          	beq	a0,a5,80027e58 <fpioa_get_io_by_function+0x46>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027e2a:	4785                	li	a5,1
        if(fpioa->io[index].ch_sel == function)
    80027e2c:	003f56b7          	lui	a3,0x3f5
    80027e30:	02b68693          	addi	a3,a3,43 # 3f502b <BASE_ADDRESS-0x7fc2afd5>
    80027e34:	06c2                	slli	a3,a3,0x10
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027e36:	03000613          	li	a2,48
        if(fpioa->io[index].ch_sel == function)
    80027e3a:	00279713          	slli	a4,a5,0x2
    80027e3e:	9736                	add	a4,a4,a3
    80027e40:	00074703          	lbu	a4,0(a4)
    80027e44:	00e50663          	beq	a0,a4,80027e50 <fpioa_get_io_by_function+0x3e>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027e48:	2785                	addiw	a5,a5,1
    80027e4a:	fec798e3          	bne	a5,a2,80027e3a <fpioa_get_io_by_function+0x28>
            return index;
    }

    return -1;
    80027e4e:	57fd                	li	a5,-1
}
    80027e50:	853e                	mv	a0,a5
    80027e52:	6422                	ld	s0,8(sp)
    80027e54:	0141                	addi	sp,sp,16
    80027e56:	8082                	ret
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027e58:	4781                	li	a5,0
    80027e5a:	bfdd                	j	80027e50 <fpioa_get_io_by_function+0x3e>

0000000080027e5c <fpioa_pin_init>:

void fpioa_pin_init() {
    80027e5c:	1141                	addi	sp,sp,-16
    80027e5e:	e406                	sd	ra,8(sp)
    80027e60:	e022                	sd	s0,0(sp)
    80027e62:	0800                	addi	s0,sp,16
    fpioa_set_function(27, FUNC_SPI0_SCLK);
    80027e64:	45c5                	li	a1,17
    80027e66:	456d                	li	a0,27
    80027e68:	00000097          	auipc	ra,0x0
    80027e6c:	f08080e7          	jalr	-248(ra) # 80027d70 <fpioa_set_function>
    fpioa_set_function(28, FUNC_SPI0_D0);
    80027e70:	4591                	li	a1,4
    80027e72:	4571                	li	a0,28
    80027e74:	00000097          	auipc	ra,0x0
    80027e78:	efc080e7          	jalr	-260(ra) # 80027d70 <fpioa_set_function>
    fpioa_set_function(26, FUNC_SPI0_D1);
    80027e7c:	4595                	li	a1,5
    80027e7e:	4569                	li	a0,26
    80027e80:	00000097          	auipc	ra,0x0
    80027e84:	ef0080e7          	jalr	-272(ra) # 80027d70 <fpioa_set_function>
	fpioa_set_function(32, FUNC_GPIOHS7);
    80027e88:	45fd                	li	a1,31
    80027e8a:	02000513          	li	a0,32
    80027e8e:	00000097          	auipc	ra,0x0
    80027e92:	ee2080e7          	jalr	-286(ra) # 80027d70 <fpioa_set_function>
    fpioa_set_function(29, FUNC_SPI0_SS3);
    80027e96:	45bd                	li	a1,15
    80027e98:	4575                	li	a0,29
    80027e9a:	00000097          	auipc	ra,0x0
    80027e9e:	ed6080e7          	jalr	-298(ra) # 80027d70 <fpioa_set_function>
    #ifdef DEBUG
    printf("fpioa_pin_init\n");
    #endif
    80027ea2:	60a2                	ld	ra,8(sp)
    80027ea4:	6402                	ld	s0,0(sp)
    80027ea6:	0141                	addi	sp,sp,16
    80027ea8:	8082                	ret

0000000080027eaa <set_bit>:
#include "include/types.h"
#include "include/utils.h"

void set_bit(volatile uint32 *bits, uint32 mask, uint32 value)
{
    80027eaa:	1141                	addi	sp,sp,-16
    80027eac:	e422                	sd	s0,8(sp)
    80027eae:	0800                	addi	s0,sp,16
    uint32 org = (*bits) & ~mask;
    80027eb0:	411c                	lw	a5,0(a0)
    80027eb2:	2781                	sext.w	a5,a5
    *bits = org | (value & mask);
    80027eb4:	8e3d                	xor	a2,a2,a5
    80027eb6:	8df1                	and	a1,a1,a2
    80027eb8:	8fad                	xor	a5,a5,a1
    80027eba:	c11c                	sw	a5,0(a0)
}
    80027ebc:	6422                	ld	s0,8(sp)
    80027ebe:	0141                	addi	sp,sp,16
    80027ec0:	8082                	ret

0000000080027ec2 <set_bit_offset>:

void set_bit_offset(volatile uint32 *bits, uint32 mask, uint64 offset, uint32 value)
{
    80027ec2:	1141                	addi	sp,sp,-16
    80027ec4:	e422                	sd	s0,8(sp)
    80027ec6:	0800                	addi	s0,sp,16
    set_bit(bits, mask << offset, value << offset);
    80027ec8:	2601                	sext.w	a2,a2
    uint32 org = (*bits) & ~mask;
    80027eca:	411c                	lw	a5,0(a0)
    80027ecc:	2781                	sext.w	a5,a5
    set_bit(bits, mask << offset, value << offset);
    80027ece:	00c696bb          	sllw	a3,a3,a2
    *bits = org | (value & mask);
    80027ed2:	8ebd                	xor	a3,a3,a5
    set_bit(bits, mask << offset, value << offset);
    80027ed4:	00c595bb          	sllw	a1,a1,a2
    *bits = org | (value & mask);
    80027ed8:	8eed                	and	a3,a3,a1
    80027eda:	8fb5                	xor	a5,a5,a3
    80027edc:	2781                	sext.w	a5,a5
    80027ede:	c11c                	sw	a5,0(a0)
}
    80027ee0:	6422                	ld	s0,8(sp)
    80027ee2:	0141                	addi	sp,sp,16
    80027ee4:	8082                	ret

0000000080027ee6 <set_gpio_bit>:

void set_gpio_bit(volatile uint32 *bits, uint64 offset, uint32 value)
{
    80027ee6:	1141                	addi	sp,sp,-16
    80027ee8:	e406                	sd	ra,8(sp)
    80027eea:	e022                	sd	s0,0(sp)
    80027eec:	0800                	addi	s0,sp,16
    set_bit_offset(bits, 1, offset, value);
    80027eee:	86b2                	mv	a3,a2
    80027ef0:	862e                	mv	a2,a1
    80027ef2:	4585                	li	a1,1
    80027ef4:	00000097          	auipc	ra,0x0
    80027ef8:	fce080e7          	jalr	-50(ra) # 80027ec2 <set_bit_offset>
}
    80027efc:	60a2                	ld	ra,8(sp)
    80027efe:	6402                	ld	s0,0(sp)
    80027f00:	0141                	addi	sp,sp,16
    80027f02:	8082                	ret

0000000080027f04 <get_bit>:

uint32 get_bit(volatile uint32 *bits, uint32 mask, uint64 offset)
{
    80027f04:	1141                	addi	sp,sp,-16
    80027f06:	e422                	sd	s0,8(sp)
    80027f08:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    80027f0a:	411c                	lw	a5,0(a0)
    80027f0c:	2781                	sext.w	a5,a5
    80027f0e:	2601                	sext.w	a2,a2
    80027f10:	00c595bb          	sllw	a1,a1,a2
    80027f14:	8fed                	and	a5,a5,a1
}
    80027f16:	00c7d53b          	srlw	a0,a5,a2
    80027f1a:	6422                	ld	s0,8(sp)
    80027f1c:	0141                	addi	sp,sp,16
    80027f1e:	8082                	ret

0000000080027f20 <get_gpio_bit>:

uint32 get_gpio_bit(volatile uint32 *bits, uint64 offset)
{
    80027f20:	1141                	addi	sp,sp,-16
    80027f22:	e422                	sd	s0,8(sp)
    80027f24:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    80027f26:	411c                	lw	a5,0(a0)
    80027f28:	2781                	sext.w	a5,a5
    80027f2a:	2581                	sext.w	a1,a1
    80027f2c:	4705                	li	a4,1
    80027f2e:	00b7173b          	sllw	a4,a4,a1
    80027f32:	8ff9                	and	a5,a5,a4
    return get_bit(bits, 1, offset);
}
    80027f34:	00b7d53b          	srlw	a0,a5,a1
    80027f38:	6422                	ld	s0,8(sp)
    80027f3a:	0141                	addi	sp,sp,16
    80027f3c:	8082                	ret

0000000080027f3e <sd_write_data>:
static void sd_lowlevel_init(uint8 spi_index) {
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    // spi_set_clk_rate(SPI_DEVICE_0, 200000);     /*set clk rate*/
}

static void sd_write_data(uint8 const *data_buff, uint32 length) {
    80027f3e:	1101                	addi	sp,sp,-32
    80027f40:	ec06                	sd	ra,24(sp)
    80027f42:	e822                	sd	s0,16(sp)
    80027f44:	e426                	sd	s1,8(sp)
    80027f46:	e04a                	sd	s2,0(sp)
    80027f48:	1000                	addi	s0,sp,32
    80027f4a:	84aa                	mv	s1,a0
    80027f4c:	892e                	mv	s2,a1
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80027f4e:	4701                	li	a4,0
    80027f50:	46a1                	li	a3,8
    80027f52:	4601                	li	a2,0
    80027f54:	4581                	li	a1,0
    80027f56:	4501                	li	a0,0
    80027f58:	fffff097          	auipc	ra,0xfffff
    80027f5c:	052080e7          	jalr	82(ra) # 80026faa <spi_init>
    spi_send_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    80027f60:	02091793          	slli	a5,s2,0x20
    80027f64:	9381                	srli	a5,a5,0x20
    80027f66:	8726                	mv	a4,s1
    80027f68:	4681                	li	a3,0
    80027f6a:	4601                	li	a2,0
    80027f6c:	4581                	li	a1,0
    80027f6e:	4501                	li	a0,0
    80027f70:	fffff097          	auipc	ra,0xfffff
    80027f74:	2a8080e7          	jalr	680(ra) # 80027218 <spi_send_data_standard>
}
    80027f78:	60e2                	ld	ra,24(sp)
    80027f7a:	6442                	ld	s0,16(sp)
    80027f7c:	64a2                	ld	s1,8(sp)
    80027f7e:	6902                	ld	s2,0(sp)
    80027f80:	6105                	addi	sp,sp,32
    80027f82:	8082                	ret

0000000080027f84 <sd_read_data>:

static void sd_read_data(uint8 *data_buff, uint32 length) {
    80027f84:	1101                	addi	sp,sp,-32
    80027f86:	ec06                	sd	ra,24(sp)
    80027f88:	e822                	sd	s0,16(sp)
    80027f8a:	e426                	sd	s1,8(sp)
    80027f8c:	e04a                	sd	s2,0(sp)
    80027f8e:	1000                	addi	s0,sp,32
    80027f90:	84aa                	mv	s1,a0
    80027f92:	892e                	mv	s2,a1
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80027f94:	4701                	li	a4,0
    80027f96:	46a1                	li	a3,8
    80027f98:	4601                	li	a2,0
    80027f9a:	4581                	li	a1,0
    80027f9c:	4501                	li	a0,0
    80027f9e:	fffff097          	auipc	ra,0xfffff
    80027fa2:	00c080e7          	jalr	12(ra) # 80026faa <spi_init>
    spi_receive_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    80027fa6:	02091793          	slli	a5,s2,0x20
    80027faa:	9381                	srli	a5,a5,0x20
    80027fac:	8726                	mv	a4,s1
    80027fae:	4681                	li	a3,0
    80027fb0:	4601                	li	a2,0
    80027fb2:	4581                	li	a1,0
    80027fb4:	4501                	li	a0,0
    80027fb6:	fffff097          	auipc	ra,0xfffff
    80027fba:	2fa080e7          	jalr	762(ra) # 800272b0 <spi_receive_data_standard>
}
    80027fbe:	60e2                	ld	ra,24(sp)
    80027fc0:	6442                	ld	s0,16(sp)
    80027fc2:	64a2                	ld	s1,8(sp)
    80027fc4:	6902                	ld	s2,0(sp)
    80027fc6:	6105                	addi	sp,sp,32
    80027fc8:	8082                	ret

0000000080027fca <sd_get_response_R1>:
#define SD_CMD13 	13 		// SEND_STATUS

/*
 * Read sdcard response in R1 type. 
 */
static uint8 sd_get_response_R1(void) {
    80027fca:	7179                	addi	sp,sp,-48
    80027fcc:	f406                	sd	ra,40(sp)
    80027fce:	f022                	sd	s0,32(sp)
    80027fd0:	ec26                	sd	s1,24(sp)
    80027fd2:	e84a                	sd	s2,16(sp)
    80027fd4:	1800                	addi	s0,sp,48
    80027fd6:	0ff00493          	li	s1,255
	uint8 result;
	uint16 timeout = 0xff;

	while (timeout--) {
		sd_read_data(&result, 1);
		if (result != 0xff)
    80027fda:	0ff00913          	li	s2,255
		sd_read_data(&result, 1);
    80027fde:	4585                	li	a1,1
    80027fe0:	fdf40513          	addi	a0,s0,-33
    80027fe4:	00000097          	auipc	ra,0x0
    80027fe8:	fa0080e7          	jalr	-96(ra) # 80027f84 <sd_read_data>
		if (result != 0xff)
    80027fec:	fdf44503          	lbu	a0,-33(s0)
    80027ff0:	01251663          	bne	a0,s2,80027ffc <sd_get_response_R1+0x32>
    80027ff4:	34fd                	addiw	s1,s1,-1
    80027ff6:	14c2                	slli	s1,s1,0x30
    80027ff8:	90c1                	srli	s1,s1,0x30
	while (timeout--) {
    80027ffa:	f0f5                	bnez	s1,80027fde <sd_get_response_R1+0x14>
			return result;
	}

	// timeout!
	return 0xff;
}
    80027ffc:	70a2                	ld	ra,40(sp)
    80027ffe:	7402                	ld	s0,32(sp)
    80028000:	64e2                	ld	s1,24(sp)
    80028002:	6942                	ld	s2,16(sp)
    80028004:	6145                	addi	sp,sp,48
    80028006:	8082                	ret

0000000080028008 <SD_CS_HIGH>:
void SD_CS_HIGH(void) {
    80028008:	1141                	addi	sp,sp,-16
    8002800a:	e406                	sd	ra,8(sp)
    8002800c:	e022                	sd	s0,0(sp)
    8002800e:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_HIGH);
    80028010:	4585                	li	a1,1
    80028012:	451d                	li	a0,7
    80028014:	00000097          	auipc	ra,0x0
    80028018:	b5c080e7          	jalr	-1188(ra) # 80027b70 <gpiohs_set_pin>
}
    8002801c:	60a2                	ld	ra,8(sp)
    8002801e:	6402                	ld	s0,0(sp)
    80028020:	0141                	addi	sp,sp,16
    80028022:	8082                	ret

0000000080028024 <sd_end_cmd>:
static void sd_end_cmd(void) {
    80028024:	1101                	addi	sp,sp,-32
    80028026:	ec06                	sd	ra,24(sp)
    80028028:	e822                	sd	s0,16(sp)
    8002802a:	1000                	addi	s0,sp,32
	uint8 frame[1] = {0xFF};
    8002802c:	57fd                	li	a5,-1
    8002802e:	fef40423          	sb	a5,-24(s0)
	SD_CS_HIGH();
    80028032:	00000097          	auipc	ra,0x0
    80028036:	fd6080e7          	jalr	-42(ra) # 80028008 <SD_CS_HIGH>
	sd_write_data(frame, 1);
    8002803a:	4585                	li	a1,1
    8002803c:	fe840513          	addi	a0,s0,-24
    80028040:	00000097          	auipc	ra,0x0
    80028044:	efe080e7          	jalr	-258(ra) # 80027f3e <sd_write_data>
}
    80028048:	60e2                	ld	ra,24(sp)
    8002804a:	6442                	ld	s0,16(sp)
    8002804c:	6105                	addi	sp,sp,32
    8002804e:	8082                	ret

0000000080028050 <SD_CS_LOW>:
void SD_CS_LOW(void) {
    80028050:	1141                	addi	sp,sp,-16
    80028052:	e406                	sd	ra,8(sp)
    80028054:	e022                	sd	s0,0(sp)
    80028056:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_LOW);
    80028058:	4581                	li	a1,0
    8002805a:	451d                	li	a0,7
    8002805c:	00000097          	auipc	ra,0x0
    80028060:	b14080e7          	jalr	-1260(ra) # 80027b70 <gpiohs_set_pin>
}
    80028064:	60a2                	ld	ra,8(sp)
    80028066:	6402                	ld	s0,0(sp)
    80028068:	0141                	addi	sp,sp,16
    8002806a:	8082                	ret

000000008002806c <sd_send_cmd>:
static void sd_send_cmd(uint8 cmd, uint32 arg, uint8 crc) {
    8002806c:	1101                	addi	sp,sp,-32
    8002806e:	ec06                	sd	ra,24(sp)
    80028070:	e822                	sd	s0,16(sp)
    80028072:	1000                	addi	s0,sp,32
	frame[0] = (cmd | 0x40);
    80028074:	04056513          	ori	a0,a0,64
    80028078:	fea40423          	sb	a0,-24(s0)
	frame[1] = (uint8)(arg >> 24);
    8002807c:	0185d79b          	srliw	a5,a1,0x18
    80028080:	fef404a3          	sb	a5,-23(s0)
	frame[2] = (uint8)(arg >> 16);
    80028084:	0105d79b          	srliw	a5,a1,0x10
    80028088:	fef40523          	sb	a5,-22(s0)
	frame[3] = (uint8)(arg >> 8);
    8002808c:	0085d79b          	srliw	a5,a1,0x8
    80028090:	fef405a3          	sb	a5,-21(s0)
	frame[4] = (uint8)(arg);
    80028094:	feb40623          	sb	a1,-20(s0)
	frame[5] = (crc);
    80028098:	fec406a3          	sb	a2,-19(s0)
	SD_CS_LOW();
    8002809c:	00000097          	auipc	ra,0x0
    800280a0:	fb4080e7          	jalr	-76(ra) # 80028050 <SD_CS_LOW>
	sd_write_data(frame, 6);
    800280a4:	4599                	li	a1,6
    800280a6:	fe840513          	addi	a0,s0,-24
    800280aa:	00000097          	auipc	ra,0x0
    800280ae:	e94080e7          	jalr	-364(ra) # 80027f3e <sd_write_data>
}
    800280b2:	60e2                	ld	ra,24(sp)
    800280b4:	6442                	ld	s0,16(sp)
    800280b6:	6105                	addi	sp,sp,32
    800280b8:	8082                	ret

00000000800280ba <SD_HIGH_SPEED_ENABLE>:
void SD_HIGH_SPEED_ENABLE(void) {
    800280ba:	1141                	addi	sp,sp,-16
    800280bc:	e422                	sd	s0,8(sp)
    800280be:	0800                	addi	s0,sp,16
}
    800280c0:	6422                	ld	s0,8(sp)
    800280c2:	0141                	addi	sp,sp,16
    800280c4:	8082                	ret

00000000800280c6 <sdcard_init>:
	return 0;
}

static struct sleeplock sdcard_lock;

void sdcard_init(void) {
    800280c6:	715d                	addi	sp,sp,-80
    800280c8:	e486                	sd	ra,72(sp)
    800280ca:	e0a2                	sd	s0,64(sp)
    800280cc:	fc26                	sd	s1,56(sp)
    800280ce:	f84a                	sd	s2,48(sp)
    800280d0:	f44e                	sd	s3,40(sp)
    800280d2:	0880                	addi	s0,sp,80
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    800280d4:	458d                	li	a1,3
    800280d6:	451d                	li	a0,7
    800280d8:	00000097          	auipc	ra,0x0
    800280dc:	9fc080e7          	jalr	-1540(ra) # 80027ad4 <gpiohs_set_drive_mode>
	SD_CS_LOW();
    800280e0:	00000097          	auipc	ra,0x0
    800280e4:	f70080e7          	jalr	-144(ra) # 80028050 <SD_CS_LOW>
	for (int i = 0; i < 10; i ++) 
    800280e8:	fc040793          	addi	a5,s0,-64
    800280ec:	fca40693          	addi	a3,s0,-54
		frame[i] = 0xff;
    800280f0:	577d                	li	a4,-1
    800280f2:	00e78023          	sb	a4,0(a5)
    800280f6:	0785                	addi	a5,a5,1
	for (int i = 0; i < 10; i ++) 
    800280f8:	fef69de3          	bne	a3,a5,800280f2 <sdcard_init+0x2c>
	sd_write_data(frame, 10);
    800280fc:	45a9                	li	a1,10
    800280fe:	fc040513          	addi	a0,s0,-64
    80028102:	00000097          	auipc	ra,0x0
    80028106:	e3c080e7          	jalr	-452(ra) # 80027f3e <sd_write_data>
    8002810a:	0fe00493          	li	s1,254
		if (0x01 == result) break;
    8002810e:	4905                	li	s2,1
		sd_send_cmd(SD_CMD0, 0, 0x95);
    80028110:	09500613          	li	a2,149
    80028114:	4581                	li	a1,0
    80028116:	4501                	li	a0,0
    80028118:	00000097          	auipc	ra,0x0
    8002811c:	f54080e7          	jalr	-172(ra) # 8002806c <sd_send_cmd>
		uint64 result = sd_get_response_R1();
    80028120:	00000097          	auipc	ra,0x0
    80028124:	eaa080e7          	jalr	-342(ra) # 80027fca <sd_get_response_R1>
    80028128:	89aa                	mv	s3,a0
		sd_end_cmd();
    8002812a:	00000097          	auipc	ra,0x0
    8002812e:	efa080e7          	jalr	-262(ra) # 80028024 <sd_end_cmd>
		if (0x01 == result) break;
    80028132:	25298a63          	beq	s3,s2,80028386 <sdcard_init+0x2c0>
    80028136:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    80028138:	fce1                	bnez	s1,80028110 <sdcard_init+0x4a>
		printf("SD_CMD0 failed\n");
    8002813a:	00005517          	auipc	a0,0x5
    8002813e:	c7650513          	addi	a0,a0,-906 # 8002cdb0 <function_config+0x548>
    80028142:	ffff8097          	auipc	ra,0xffff8
    80028146:	04e080e7          	jalr	78(ra) # 80020190 <printf>
		return 0xff;
    8002814a:	ac59                	j	800283e0 <sdcard_init+0x31a>
		printf("invalid CRC for CMD8\n");
    8002814c:	00005517          	auipc	a0,0x5
    80028150:	b1c50513          	addi	a0,a0,-1252 # 8002cc68 <function_config+0x400>
    80028154:	ffff8097          	auipc	ra,0xffff8
    80028158:	03c080e7          	jalr	60(ra) # 80020190 <printf>
		return 0xff;
    8002815c:	a451                	j	800283e0 <sdcard_init+0x31a>
	else if (0x01 == result && 0x01 == (frame[2] & 0x0f) && 0xaa == frame[3]) {
    8002815e:	fbb44703          	lbu	a4,-69(s0)
    80028162:	0aa00793          	li	a5,170
    80028166:	26f71563          	bne	a4,a5,800283d0 <sdcard_init+0x30a>
    8002816a:	0ff00493          	li	s1,255
	uint64 result=0;
    8002816e:	4901                	li	s2,0
		if (
    80028170:	4985                	li	s3,1
    80028172:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    80028174:	14048163          	beqz	s1,800282b6 <sdcard_init+0x1f0>
		sd_send_cmd(SD_CMD58, 0, 0);
    80028178:	4601                	li	a2,0
    8002817a:	4581                	li	a1,0
    8002817c:	03a00513          	li	a0,58
    80028180:	00000097          	auipc	ra,0x0
    80028184:	eec080e7          	jalr	-276(ra) # 8002806c <sd_send_cmd>
		result = sd_get_response_R1();
    80028188:	00000097          	auipc	ra,0x0
    8002818c:	e42080e7          	jalr	-446(ra) # 80027fca <sd_get_response_R1>
    80028190:	892a                	mv	s2,a0
	sd_read_data(frame, 4);
    80028192:	4591                	li	a1,4
    80028194:	fb840513          	addi	a0,s0,-72
    80028198:	00000097          	auipc	ra,0x0
    8002819c:	dec080e7          	jalr	-532(ra) # 80027f84 <sd_read_data>
		sd_end_cmd();
    800281a0:	00000097          	auipc	ra,0x0
    800281a4:	e84080e7          	jalr	-380(ra) # 80028024 <sd_end_cmd>
		if (
    800281a8:	fd3915e3          	bne	s2,s3,80028172 <sdcard_init+0xac>
			0x01 == result && // R1 response in idle status 
    800281ac:	fb944783          	lbu	a5,-71(s0)
    800281b0:	8bfd                	andi	a5,a5,31
    800281b2:	d3e1                	beqz	a5,80028172 <sdcard_init+0xac>
			(ocr[1] & 0x1f) && (ocr[2] & 0x80) 	// voltage range valid 
    800281b4:	fba40783          	lb	a5,-70(s0)
    800281b8:	fa07dde3          	bgez	a5,80028172 <sdcard_init+0xac>
    800281bc:	6485                	lui	s1,0x1
    800281be:	14fd                	addi	s1,s1,-1
	uint8 result = 0xff;
    800281c0:	0ff00913          	li	s2,255
		if (0x01 != result) {
    800281c4:	4985                	li	s3,1
    800281c6:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    800281c8:	12048463          	beqz	s1,800282f0 <sdcard_init+0x22a>
		sd_send_cmd(SD_CMD55, 0, 0);
    800281cc:	4601                	li	a2,0
    800281ce:	4581                	li	a1,0
    800281d0:	03700513          	li	a0,55
    800281d4:	00000097          	auipc	ra,0x0
    800281d8:	e98080e7          	jalr	-360(ra) # 8002806c <sd_send_cmd>
		result = sd_get_response_R1();
    800281dc:	00000097          	auipc	ra,0x0
    800281e0:	dee080e7          	jalr	-530(ra) # 80027fca <sd_get_response_R1>
    800281e4:	892a                	mv	s2,a0
		sd_end_cmd();
    800281e6:	00000097          	auipc	ra,0x0
    800281ea:	e3e080e7          	jalr	-450(ra) # 80028024 <sd_end_cmd>
		if (0x01 != result) {
    800281ee:	0f391663          	bne	s2,s3,800282da <sdcard_init+0x214>
		sd_send_cmd(SD_ACMD41, 0x40000000, 0);
    800281f2:	4601                	li	a2,0
    800281f4:	400005b7          	lui	a1,0x40000
    800281f8:	02900513          	li	a0,41
    800281fc:	00000097          	auipc	ra,0x0
    80028200:	e70080e7          	jalr	-400(ra) # 8002806c <sd_send_cmd>
		result = sd_get_response_R1();
    80028204:	00000097          	auipc	ra,0x0
    80028208:	dc6080e7          	jalr	-570(ra) # 80027fca <sd_get_response_R1>
    8002820c:	892a                	mv	s2,a0
		sd_end_cmd();
    8002820e:	00000097          	auipc	ra,0x0
    80028212:	e16080e7          	jalr	-490(ra) # 80028024 <sd_end_cmd>
		if (0 == result) {
    80028216:	fa0918e3          	bnez	s2,800281c6 <sdcard_init+0x100>
    8002821a:	10000493          	li	s1,256
	uint8 result = 0xff;
    8002821e:	0ff00913          	li	s2,255
    80028222:	34fd                	addiw	s1,s1,-1
	while (timeout --) {
    80028224:	10048663          	beqz	s1,80028330 <sdcard_init+0x26a>
		sd_send_cmd(SD_CMD58, 0, 0);
    80028228:	4601                	li	a2,0
    8002822a:	4581                	li	a1,0
    8002822c:	03a00513          	li	a0,58
    80028230:	00000097          	auipc	ra,0x0
    80028234:	e3c080e7          	jalr	-452(ra) # 8002806c <sd_send_cmd>
		result = sd_get_response_R1();
    80028238:	00000097          	auipc	ra,0x0
    8002823c:	d92080e7          	jalr	-622(ra) # 80027fca <sd_get_response_R1>
    80028240:	892a                	mv	s2,a0
	sd_read_data(frame, 4);
    80028242:	4591                	li	a1,4
    80028244:	fb840513          	addi	a0,s0,-72
    80028248:	00000097          	auipc	ra,0x0
    8002824c:	d3c080e7          	jalr	-708(ra) # 80027f84 <sd_read_data>
		sd_end_cmd();
    80028250:	00000097          	auipc	ra,0x0
    80028254:	dd4080e7          	jalr	-556(ra) # 80028024 <sd_end_cmd>
		if (0 == result) {
    80028258:	fc0915e3          	bnez	s2,80028222 <sdcard_init+0x15c>
			if (ocr[0] & 0x40) {
    8002825c:	fb844783          	lbu	a5,-72(s0)
    80028260:	0407f793          	andi	a5,a5,64
    80028264:	ebcd                	bnez	a5,80028316 <sdcard_init+0x250>
				printf("SDSC detected, setting block size\n");
    80028266:	00005517          	auipc	a0,0x5
    8002826a:	ac250513          	addi	a0,a0,-1342 # 8002cd28 <function_config+0x4c0>
    8002826e:	ffff8097          	auipc	ra,0xffff8
    80028272:	f22080e7          	jalr	-222(ra) # 80020190 <printf>
    80028276:	0fe00493          	li	s1,254
					sd_send_cmd(SD_CMD16, BSIZE, 0);
    8002827a:	4601                	li	a2,0
    8002827c:	20000593          	li	a1,512
    80028280:	4541                	li	a0,16
    80028282:	00000097          	auipc	ra,0x0
    80028286:	dea080e7          	jalr	-534(ra) # 8002806c <sd_send_cmd>
					result = sd_get_response_R1();
    8002828a:	00000097          	auipc	ra,0x0
    8002828e:	d40080e7          	jalr	-704(ra) # 80027fca <sd_get_response_R1>
    80028292:	892a                	mv	s2,a0
					sd_end_cmd();
    80028294:	00000097          	auipc	ra,0x0
    80028298:	d90080e7          	jalr	-624(ra) # 80028024 <sd_end_cmd>
					if (0 == result) break;
    8002829c:	0a090d63          	beqz	s2,80028356 <sdcard_init+0x290>
    800282a0:	34fd                	addiw	s1,s1,-1
				while (--timeout) {
    800282a2:	fce1                	bnez	s1,8002827a <sdcard_init+0x1b4>
					printf("check_OCR(): fail to set block size");
    800282a4:	00005517          	auipc	a0,0x5
    800282a8:	ae450513          	addi	a0,a0,-1308 # 8002cd88 <function_config+0x520>
    800282ac:	ffff8097          	auipc	ra,0xffff8
    800282b0:	ee4080e7          	jalr	-284(ra) # 80020190 <printf>
					return 0xff;
    800282b4:	a235                	j	800283e0 <sdcard_init+0x31a>
	printf("read_OCR() timeout!\n");
    800282b6:	00005517          	auipc	a0,0x5
    800282ba:	9f250513          	addi	a0,a0,-1550 # 8002cca8 <function_config+0x440>
    800282be:	ffff8097          	auipc	ra,0xffff8
    800282c2:	ed2080e7          	jalr	-302(ra) # 80020190 <printf>
	printf("result = %d\n", result);
    800282c6:	85ca                	mv	a1,s2
    800282c8:	00005517          	auipc	a0,0x5
    800282cc:	9f850513          	addi	a0,a0,-1544 # 8002ccc0 <function_config+0x458>
    800282d0:	ffff8097          	auipc	ra,0xffff8
    800282d4:	ec0080e7          	jalr	-320(ra) # 80020190 <printf>
	return 0xff;
    800282d8:	a221                	j	800283e0 <sdcard_init+0x31a>
			printf("SD_CMD55 fail! result = %d\n", result);
    800282da:	0009059b          	sext.w	a1,s2
    800282de:	00005517          	auipc	a0,0x5
    800282e2:	9f250513          	addi	a0,a0,-1550 # 8002ccd0 <function_config+0x468>
    800282e6:	ffff8097          	auipc	ra,0xffff8
    800282ea:	eaa080e7          	jalr	-342(ra) # 80020190 <printf>
			return 0xff;
    800282ee:	a8cd                	j	800283e0 <sdcard_init+0x31a>
	printf("set_SDXC_capacity() timeout!\n");
    800282f0:	00005517          	auipc	a0,0x5
    800282f4:	a0050513          	addi	a0,a0,-1536 # 8002ccf0 <function_config+0x488>
    800282f8:	ffff8097          	auipc	ra,0xffff8
    800282fc:	e98080e7          	jalr	-360(ra) # 80020190 <printf>
	printf("result = %d\n", result);
    80028300:	0009059b          	sext.w	a1,s2
    80028304:	00005517          	auipc	a0,0x5
    80028308:	9bc50513          	addi	a0,a0,-1604 # 8002ccc0 <function_config+0x458>
    8002830c:	ffff8097          	auipc	ra,0xffff8
    80028310:	e84080e7          	jalr	-380(ra) # 80020190 <printf>
	return 0xff;
    80028314:	a0f1                	j	800283e0 <sdcard_init+0x31a>
				printf("SDHC/SDXC detected\n");
    80028316:	00005517          	auipc	a0,0x5
    8002831a:	9fa50513          	addi	a0,a0,-1542 # 8002cd10 <function_config+0x4a8>
    8002831e:	ffff8097          	auipc	ra,0xffff8
    80028322:	e72080e7          	jalr	-398(ra) # 80020190 <printf>
				is_standard_sd = 0;
    80028326:	0001e797          	auipc	a5,0x1e
    8002832a:	9c07a923          	sw	zero,-1582(a5) # 80045cf8 <is_standard_sd>
    8002832e:	a80d                	j	80028360 <sdcard_init+0x29a>
	printf("check_OCR() timeout!\n");
    80028330:	00005517          	auipc	a0,0x5
    80028334:	a2050513          	addi	a0,a0,-1504 # 8002cd50 <function_config+0x4e8>
    80028338:	ffff8097          	auipc	ra,0xffff8
    8002833c:	e58080e7          	jalr	-424(ra) # 80020190 <printf>
	printf("result = %d\n", result);
    80028340:	0009059b          	sext.w	a1,s2
    80028344:	00005517          	auipc	a0,0x5
    80028348:	97c50513          	addi	a0,a0,-1668 # 8002ccc0 <function_config+0x458>
    8002834c:	ffff8097          	auipc	ra,0xffff8
    80028350:	e44080e7          	jalr	-444(ra) # 80020190 <printf>
	return 0xff;
    80028354:	a071                	j	800283e0 <sdcard_init+0x31a>
				is_standard_sd = 1;
    80028356:	4785                	li	a5,1
    80028358:	0001e717          	auipc	a4,0x1e
    8002835c:	9af72023          	sw	a5,-1632(a4) # 80045cf8 <is_standard_sd>
	int result = sd_init();
	initsleeplock(&sdcard_lock, "sdcard");
    80028360:	00005597          	auipc	a1,0x5
    80028364:	a0858593          	addi	a1,a1,-1528 # 8002cd68 <function_config+0x500>
    80028368:	0001e517          	auipc	a0,0x1e
    8002836c:	96050513          	addi	a0,a0,-1696 # 80045cc8 <sdcard_lock>
    80028370:	ffffb097          	auipc	ra,0xffffb
    80028374:	3a4080e7          	jalr	932(ra) # 80023714 <initsleeplock>
		panic("sdcard_init failed");
	}
	#ifdef DEBUG
	printf("sdcard_init\n");
	#endif
}
    80028378:	60a6                	ld	ra,72(sp)
    8002837a:	6406                	ld	s0,64(sp)
    8002837c:	74e2                	ld	s1,56(sp)
    8002837e:	7942                	ld	s2,48(sp)
    80028380:	79a2                	ld	s3,40(sp)
    80028382:	6161                	addi	sp,sp,80
    80028384:	8082                	ret
	sd_send_cmd(SD_CMD8, 0x01aa, 0x87);
    80028386:	08700613          	li	a2,135
    8002838a:	1aa00593          	li	a1,426
    8002838e:	4521                	li	a0,8
    80028390:	00000097          	auipc	ra,0x0
    80028394:	cdc080e7          	jalr	-804(ra) # 8002806c <sd_send_cmd>
	result = sd_get_response_R1();
    80028398:	00000097          	auipc	ra,0x0
    8002839c:	c32080e7          	jalr	-974(ra) # 80027fca <sd_get_response_R1>
    800283a0:	84aa                	mv	s1,a0
	sd_read_data(frame, 4);
    800283a2:	4591                	li	a1,4
    800283a4:	fb840513          	addi	a0,s0,-72
    800283a8:	00000097          	auipc	ra,0x0
    800283ac:	bdc080e7          	jalr	-1060(ra) # 80027f84 <sd_read_data>
	sd_end_cmd();
    800283b0:	00000097          	auipc	ra,0x0
    800283b4:	c74080e7          	jalr	-908(ra) # 80028024 <sd_end_cmd>
	if (0x09 == result) {
    800283b8:	47a5                	li	a5,9
    800283ba:	d8f489e3          	beq	s1,a5,8002814c <sdcard_init+0x86>
	else if (0x01 == result && 0x01 == (frame[2] & 0x0f) && 0xaa == frame[3]) {
    800283be:	4785                	li	a5,1
    800283c0:	00f49863          	bne	s1,a5,800283d0 <sdcard_init+0x30a>
    800283c4:	fba44783          	lbu	a5,-70(s0)
    800283c8:	8bbd                	andi	a5,a5,15
    800283ca:	4705                	li	a4,1
    800283cc:	d8e789e3          	beq	a5,a4,8002815e <sdcard_init+0x98>
	printf("verify_operation_condition() fail!\n");
    800283d0:	00005517          	auipc	a0,0x5
    800283d4:	8b050513          	addi	a0,a0,-1872 # 8002cc80 <function_config+0x418>
    800283d8:	ffff8097          	auipc	ra,0xffff8
    800283dc:	db8080e7          	jalr	-584(ra) # 80020190 <printf>
	initsleeplock(&sdcard_lock, "sdcard");
    800283e0:	00005597          	auipc	a1,0x5
    800283e4:	98858593          	addi	a1,a1,-1656 # 8002cd68 <function_config+0x500>
    800283e8:	0001e517          	auipc	a0,0x1e
    800283ec:	8e050513          	addi	a0,a0,-1824 # 80045cc8 <sdcard_lock>
    800283f0:	ffffb097          	auipc	ra,0xffffb
    800283f4:	324080e7          	jalr	804(ra) # 80023714 <initsleeplock>
		panic("sdcard_init failed");
    800283f8:	00005517          	auipc	a0,0x5
    800283fc:	97850513          	addi	a0,a0,-1672 # 8002cd70 <function_config+0x508>
    80028400:	ffff8097          	auipc	ra,0xffff8
    80028404:	d46080e7          	jalr	-698(ra) # 80020146 <panic>

0000000080028408 <sdcard_read_sector>:

void sdcard_read_sector(uint8 *buf, int sectorno) {
    80028408:	7139                	addi	sp,sp,-64
    8002840a:	fc06                	sd	ra,56(sp)
    8002840c:	f822                	sd	s0,48(sp)
    8002840e:	f426                	sd	s1,40(sp)
    80028410:	f04a                	sd	s2,32(sp)
    80028412:	ec4e                	sd	s3,24(sp)
    80028414:	0080                	addi	s0,sp,64
    80028416:	89aa                	mv	s3,a0

	#ifdef DEBUG
	printf("sdcard_read_sector()\n");
	#endif

	if (is_standard_sd) {
    80028418:	0001e797          	auipc	a5,0x1e
    8002841c:	8e078793          	addi	a5,a5,-1824 # 80045cf8 <is_standard_sd>
    80028420:	439c                	lw	a5,0(a5)
		address = sectorno << 9;
	}
	else {
		address = sectorno;
    80028422:	0005849b          	sext.w	s1,a1
	if (is_standard_sd) {
    80028426:	c399                	beqz	a5,8002842c <sdcard_read_sector+0x24>
		address = sectorno << 9;
    80028428:	0095949b          	slliw	s1,a1,0x9
	}

	// enter critical section!
	acquiresleep(&sdcard_lock);
    8002842c:	0001e517          	auipc	a0,0x1e
    80028430:	89c50513          	addi	a0,a0,-1892 # 80045cc8 <sdcard_lock>
    80028434:	ffffb097          	auipc	ra,0xffffb
    80028438:	31a080e7          	jalr	794(ra) # 8002374e <acquiresleep>

	sd_send_cmd(SD_CMD17, address, 0);
    8002843c:	4601                	li	a2,0
    8002843e:	85a6                	mv	a1,s1
    80028440:	4545                	li	a0,17
    80028442:	00000097          	auipc	ra,0x0
    80028446:	c2a080e7          	jalr	-982(ra) # 8002806c <sd_send_cmd>
	result = sd_get_response_R1();
    8002844a:	00000097          	auipc	ra,0x0
    8002844e:	b80080e7          	jalr	-1152(ra) # 80027fca <sd_get_response_R1>
    80028452:	fca407a3          	sb	a0,-49(s0)

	if (0 != result) {
    80028456:	010004b7          	lui	s1,0x1000
    8002845a:	14f9                	addi	s1,s1,-2
	}

	int timeout = 0xffffff;
	while (--timeout) {
		sd_read_data(&result, 1);
		if (0xfe == result) break;
    8002845c:	0fe00913          	li	s2,254
	if (0 != result) {
    80028460:	e515                	bnez	a0,8002848c <sdcard_read_sector+0x84>
		sd_read_data(&result, 1);
    80028462:	4585                	li	a1,1
    80028464:	fcf40513          	addi	a0,s0,-49
    80028468:	00000097          	auipc	ra,0x0
    8002846c:	b1c080e7          	jalr	-1252(ra) # 80027f84 <sd_read_data>
		if (0xfe == result) break;
    80028470:	fcf44783          	lbu	a5,-49(s0)
    80028474:	03278c63          	beq	a5,s2,800284ac <sdcard_read_sector+0xa4>
    80028478:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    8002847a:	f4e5                	bnez	s1,80028462 <sdcard_read_sector+0x5a>
	}
	if (0 == timeout) {
		panic("sdcard: timeout waiting for reading");
    8002847c:	00005517          	auipc	a0,0x5
    80028480:	95c50513          	addi	a0,a0,-1700 # 8002cdd8 <function_config+0x570>
    80028484:	ffff8097          	auipc	ra,0xffff8
    80028488:	cc2080e7          	jalr	-830(ra) # 80020146 <panic>
		releasesleep(&sdcard_lock);
    8002848c:	0001e517          	auipc	a0,0x1e
    80028490:	83c50513          	addi	a0,a0,-1988 # 80045cc8 <sdcard_lock>
    80028494:	ffffb097          	auipc	ra,0xffffb
    80028498:	310080e7          	jalr	784(ra) # 800237a4 <releasesleep>
		panic("sdcard: fail to read");
    8002849c:	00005517          	auipc	a0,0x5
    800284a0:	92450513          	addi	a0,a0,-1756 # 8002cdc0 <function_config+0x558>
    800284a4:	ffff8097          	auipc	ra,0xffff8
    800284a8:	ca2080e7          	jalr	-862(ra) # 80020146 <panic>
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    800284ac:	4701                	li	a4,0
    800284ae:	46a1                	li	a3,8
    800284b0:	4601                	li	a2,0
    800284b2:	4581                	li	a1,0
    800284b4:	4501                	li	a0,0
    800284b6:	fffff097          	auipc	ra,0xfffff
    800284ba:	af4080e7          	jalr	-1292(ra) # 80026faa <spi_init>
	spi_receive_data_standard_dma(-1, DMAC_CHANNEL0, SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    800284be:	20000893          	li	a7,512
    800284c2:	884e                	mv	a6,s3
    800284c4:	4781                	li	a5,0
    800284c6:	4701                	li	a4,0
    800284c8:	4681                	li	a3,0
    800284ca:	4601                	li	a2,0
    800284cc:	4581                	li	a1,0
    800284ce:	557d                	li	a0,-1
    800284d0:	fffff097          	auipc	ra,0xfffff
    800284d4:	2da080e7          	jalr	730(ra) # 800277aa <spi_receive_data_standard_dma>
	}
	sd_read_data_dma(buf, BSIZE);
	sd_read_data(dummy_crc, 2);
    800284d8:	4589                	li	a1,2
    800284da:	fc840513          	addi	a0,s0,-56
    800284de:	00000097          	auipc	ra,0x0
    800284e2:	aa6080e7          	jalr	-1370(ra) # 80027f84 <sd_read_data>

	sd_end_cmd();
    800284e6:	00000097          	auipc	ra,0x0
    800284ea:	b3e080e7          	jalr	-1218(ra) # 80028024 <sd_end_cmd>

	releasesleep(&sdcard_lock);
    800284ee:	0001d517          	auipc	a0,0x1d
    800284f2:	7da50513          	addi	a0,a0,2010 # 80045cc8 <sdcard_lock>
    800284f6:	ffffb097          	auipc	ra,0xffffb
    800284fa:	2ae080e7          	jalr	686(ra) # 800237a4 <releasesleep>
	// leave critical section!
}
    800284fe:	70e2                	ld	ra,56(sp)
    80028500:	7442                	ld	s0,48(sp)
    80028502:	74a2                	ld	s1,40(sp)
    80028504:	7902                	ld	s2,32(sp)
    80028506:	69e2                	ld	s3,24(sp)
    80028508:	6121                	addi	sp,sp,64
    8002850a:	8082                	ret

000000008002850c <sdcard_write_sector>:

void sdcard_write_sector(uint8 *buf, int sectorno) {
    8002850c:	7179                	addi	sp,sp,-48
    8002850e:	f406                	sd	ra,40(sp)
    80028510:	f022                	sd	s0,32(sp)
    80028512:	ec26                	sd	s1,24(sp)
    80028514:	e84a                	sd	s2,16(sp)
    80028516:	1800                	addi	s0,sp,48
    80028518:	892a                	mv	s2,a0
	uint32 address;
	static uint8 const START_BLOCK_TOKEN = 0xfe;
	uint8 dummy_crc[2] = {0xff, 0xff};
    8002851a:	57fd                	li	a5,-1
    8002851c:	fcf40c23          	sb	a5,-40(s0)
    80028520:	fcf40ca3          	sb	a5,-39(s0)

	#ifdef DEBUG
	printf("sdcard_write_sector()\n");
	#endif

	if (is_standard_sd) {
    80028524:	0001d797          	auipc	a5,0x1d
    80028528:	7d478793          	addi	a5,a5,2004 # 80045cf8 <is_standard_sd>
    8002852c:	439c                	lw	a5,0(a5)
		address = sectorno << 9;
	}
	else {
		address = sectorno;
    8002852e:	0005849b          	sext.w	s1,a1
	if (is_standard_sd) {
    80028532:	c399                	beqz	a5,80028538 <sdcard_write_sector+0x2c>
		address = sectorno << 9;
    80028534:	0095949b          	slliw	s1,a1,0x9
	}

	// enter critical section!
	acquiresleep(&sdcard_lock);
    80028538:	0001d517          	auipc	a0,0x1d
    8002853c:	79050513          	addi	a0,a0,1936 # 80045cc8 <sdcard_lock>
    80028540:	ffffb097          	auipc	ra,0xffffb
    80028544:	20e080e7          	jalr	526(ra) # 8002374e <acquiresleep>

	sd_send_cmd(SD_CMD24, address, 0);
    80028548:	4601                	li	a2,0
    8002854a:	85a6                	mv	a1,s1
    8002854c:	4561                	li	a0,24
    8002854e:	00000097          	auipc	ra,0x0
    80028552:	b1e080e7          	jalr	-1250(ra) # 8002806c <sd_send_cmd>
	if (0 != sd_get_response_R1()) {
    80028556:	00000097          	auipc	ra,0x0
    8002855a:	a74080e7          	jalr	-1420(ra) # 80027fca <sd_get_response_R1>
    8002855e:	e559                	bnez	a0,800285ec <sdcard_write_sector+0xe0>
		releasesleep(&sdcard_lock);
		panic("sdcard: fail to write");
	}

	// sending data to be written 
	sd_write_data(&START_BLOCK_TOKEN, 1);
    80028560:	4585                	li	a1,1
    80028562:	00005517          	auipc	a0,0x5
    80028566:	a9e50513          	addi	a0,a0,-1378 # 8002d000 <START_BLOCK_TOKEN.2204>
    8002856a:	00000097          	auipc	ra,0x0
    8002856e:	9d4080e7          	jalr	-1580(ra) # 80027f3e <sd_write_data>
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80028572:	4701                	li	a4,0
    80028574:	46a1                	li	a3,8
    80028576:	4601                	li	a2,0
    80028578:	4581                	li	a1,0
    8002857a:	4501                	li	a0,0
    8002857c:	fffff097          	auipc	ra,0xfffff
    80028580:	a2e080e7          	jalr	-1490(ra) # 80026faa <spi_init>
	spi_send_data_standard_dma(DMAC_CHANNEL0, SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    80028584:	20000813          	li	a6,512
    80028588:	87ca                	mv	a5,s2
    8002858a:	4701                	li	a4,0
    8002858c:	4681                	li	a3,0
    8002858e:	4601                	li	a2,0
    80028590:	4581                	li	a1,0
    80028592:	4501                	li	a0,0
    80028594:	fffff097          	auipc	ra,0xfffff
    80028598:	3c8080e7          	jalr	968(ra) # 8002795c <spi_send_data_standard_dma>
	sd_write_data_dma(buf, BSIZE);
	sd_write_data(dummy_crc, 2);
    8002859c:	4589                	li	a1,2
    8002859e:	fd840513          	addi	a0,s0,-40
    800285a2:	00000097          	auipc	ra,0x0
    800285a6:	99c080e7          	jalr	-1636(ra) # 80027f3e <sd_write_data>
    800285aa:	6485                	lui	s1,0x1
    800285ac:	14f9                	addi	s1,s1,-2
	// waiting for sdcard to finish programming 
	uint8 result;
	int timeout = 0xfff;
	while (--timeout) {
		sd_read_data(&result, 1);
		if (0x05 == (result & 0x1f)) {
    800285ae:	4915                	li	s2,5
		sd_read_data(&result, 1);
    800285b0:	4585                	li	a1,1
    800285b2:	fd740513          	addi	a0,s0,-41
    800285b6:	00000097          	auipc	ra,0x0
    800285ba:	9ce080e7          	jalr	-1586(ra) # 80027f84 <sd_read_data>
		if (0x05 == (result & 0x1f)) {
    800285be:	fd744783          	lbu	a5,-41(s0)
    800285c2:	8bfd                	andi	a5,a5,31
    800285c4:	05278463          	beq	a5,s2,8002860c <sdcard_write_sector+0x100>
    800285c8:	34fd                	addiw	s1,s1,-1
	while (--timeout) {
    800285ca:	f0fd                	bnez	s1,800285b0 <sdcard_write_sector+0xa4>
			break;
		}
	}
	if (0 == timeout) {
		releasesleep(&sdcard_lock);
    800285cc:	0001d517          	auipc	a0,0x1d
    800285d0:	6fc50513          	addi	a0,a0,1788 # 80045cc8 <sdcard_lock>
    800285d4:	ffffb097          	auipc	ra,0xffffb
    800285d8:	1d0080e7          	jalr	464(ra) # 800237a4 <releasesleep>
		panic("sdcard: invalid response token");
    800285dc:	00005517          	auipc	a0,0x5
    800285e0:	8ac50513          	addi	a0,a0,-1876 # 8002ce88 <function_config+0x620>
    800285e4:	ffff8097          	auipc	ra,0xffff8
    800285e8:	b62080e7          	jalr	-1182(ra) # 80020146 <panic>
		releasesleep(&sdcard_lock);
    800285ec:	0001d517          	auipc	a0,0x1d
    800285f0:	6dc50513          	addi	a0,a0,1756 # 80045cc8 <sdcard_lock>
    800285f4:	ffffb097          	auipc	ra,0xffffb
    800285f8:	1b0080e7          	jalr	432(ra) # 800237a4 <releasesleep>
		panic("sdcard: fail to write");
    800285fc:	00005517          	auipc	a0,0x5
    80028600:	80450513          	addi	a0,a0,-2044 # 8002ce00 <function_config+0x598>
    80028604:	ffff8097          	auipc	ra,0xffff8
    80028608:	b42080e7          	jalr	-1214(ra) # 80020146 <panic>
    8002860c:	010004b7          	lui	s1,0x1000
    80028610:	14fd                	addi	s1,s1,-1
    80028612:	34fd                	addiw	s1,s1,-1
	}
	
	timeout = 0xffffff;
	while (--timeout) {
    80028614:	c0f1                	beqz	s1,800286d8 <sdcard_write_sector+0x1cc>
		sd_read_data(&result, 1);
    80028616:	4585                	li	a1,1
    80028618:	fd740513          	addi	a0,s0,-41
    8002861c:	00000097          	auipc	ra,0x0
    80028620:	968080e7          	jalr	-1688(ra) # 80027f84 <sd_read_data>
		if (0 != result) break;
    80028624:	fd744783          	lbu	a5,-41(s0)
    80028628:	d7ed                	beqz	a5,80028612 <sdcard_write_sector+0x106>
	}
	if (0 == timeout) {
		releasesleep(&sdcard_lock);
		panic("sdcard: timeout waiting for response");
	}
	sd_end_cmd();
    8002862a:	00000097          	auipc	ra,0x0
    8002862e:	9fa080e7          	jalr	-1542(ra) # 80028024 <sd_end_cmd>

	// send SD_CMD13 to check if writing is correctly done 
	uint8 error_code = 0xff;
    80028632:	57fd                	li	a5,-1
    80028634:	fcf40b23          	sb	a5,-42(s0)
	sd_send_cmd(SD_CMD13, 0, 0);
    80028638:	4601                	li	a2,0
    8002863a:	4581                	li	a1,0
    8002863c:	4535                	li	a0,13
    8002863e:	00000097          	auipc	ra,0x0
    80028642:	a2e080e7          	jalr	-1490(ra) # 8002806c <sd_send_cmd>
	result = sd_get_response_R1();
    80028646:	00000097          	auipc	ra,0x0
    8002864a:	984080e7          	jalr	-1660(ra) # 80027fca <sd_get_response_R1>
    8002864e:	fca40ba3          	sb	a0,-41(s0)
	sd_read_data(&error_code, 1);
    80028652:	4585                	li	a1,1
    80028654:	fd640513          	addi	a0,s0,-42
    80028658:	00000097          	auipc	ra,0x0
    8002865c:	92c080e7          	jalr	-1748(ra) # 80027f84 <sd_read_data>
	sd_end_cmd();
    80028660:	00000097          	auipc	ra,0x0
    80028664:	9c4080e7          	jalr	-1596(ra) # 80028024 <sd_end_cmd>
	if (0 != result || 0 != error_code) {
    80028668:	fd744783          	lbu	a5,-41(s0)
    8002866c:	fd644703          	lbu	a4,-42(s0)
    80028670:	8fd9                	or	a5,a5,a4
    80028672:	ef99                	bnez	a5,80028690 <sdcard_write_sector+0x184>
		printf("result: %x\n", result);
		printf("error_code: %x\n", error_code);
		panic("sdcard: an error occurs when writing");
	}

	releasesleep(&sdcard_lock);
    80028674:	0001d517          	auipc	a0,0x1d
    80028678:	65450513          	addi	a0,a0,1620 # 80045cc8 <sdcard_lock>
    8002867c:	ffffb097          	auipc	ra,0xffffb
    80028680:	128080e7          	jalr	296(ra) # 800237a4 <releasesleep>
	// leave critical section!
}
    80028684:	70a2                	ld	ra,40(sp)
    80028686:	7402                	ld	s0,32(sp)
    80028688:	64e2                	ld	s1,24(sp)
    8002868a:	6942                	ld	s2,16(sp)
    8002868c:	6145                	addi	sp,sp,48
    8002868e:	8082                	ret
		releasesleep(&sdcard_lock);
    80028690:	0001d517          	auipc	a0,0x1d
    80028694:	63850513          	addi	a0,a0,1592 # 80045cc8 <sdcard_lock>
    80028698:	ffffb097          	auipc	ra,0xffffb
    8002869c:	10c080e7          	jalr	268(ra) # 800237a4 <releasesleep>
		printf("result: %x\n", result);
    800286a0:	fd744583          	lbu	a1,-41(s0)
    800286a4:	00004517          	auipc	a0,0x4
    800286a8:	77450513          	addi	a0,a0,1908 # 8002ce18 <function_config+0x5b0>
    800286ac:	ffff8097          	auipc	ra,0xffff8
    800286b0:	ae4080e7          	jalr	-1308(ra) # 80020190 <printf>
		printf("error_code: %x\n", error_code);
    800286b4:	fd644583          	lbu	a1,-42(s0)
    800286b8:	00004517          	auipc	a0,0x4
    800286bc:	77050513          	addi	a0,a0,1904 # 8002ce28 <function_config+0x5c0>
    800286c0:	ffff8097          	auipc	ra,0xffff8
    800286c4:	ad0080e7          	jalr	-1328(ra) # 80020190 <printf>
		panic("sdcard: an error occurs when writing");
    800286c8:	00004517          	auipc	a0,0x4
    800286cc:	77050513          	addi	a0,a0,1904 # 8002ce38 <function_config+0x5d0>
    800286d0:	ffff8097          	auipc	ra,0xffff8
    800286d4:	a76080e7          	jalr	-1418(ra) # 80020146 <panic>
		releasesleep(&sdcard_lock);
    800286d8:	0001d517          	auipc	a0,0x1d
    800286dc:	5f050513          	addi	a0,a0,1520 # 80045cc8 <sdcard_lock>
    800286e0:	ffffb097          	auipc	ra,0xffffb
    800286e4:	0c4080e7          	jalr	196(ra) # 800237a4 <releasesleep>
		panic("sdcard: timeout waiting for response");
    800286e8:	00004517          	auipc	a0,0x4
    800286ec:	77850513          	addi	a0,a0,1912 # 8002ce60 <function_config+0x5f8>
    800286f0:	ffff8097          	auipc	ra,0xffff8
    800286f4:	a56080e7          	jalr	-1450(ra) # 80020146 <panic>

00000000800286f8 <test_sdcard>:

// A simple test for sdcard read/write test 
void test_sdcard(void) {
    800286f8:	da010113          	addi	sp,sp,-608
    800286fc:	24113c23          	sd	ra,600(sp)
    80028700:	24813823          	sd	s0,592(sp)
    80028704:	24913423          	sd	s1,584(sp)
    80028708:	25213023          	sd	s2,576(sp)
    8002870c:	23313c23          	sd	s3,568(sp)
    80028710:	23413823          	sd	s4,560(sp)
    80028714:	23513423          	sd	s5,552(sp)
    80028718:	23613023          	sd	s6,544(sp)
    8002871c:	21713c23          	sd	s7,536(sp)
    80028720:	21813823          	sd	s8,528(sp)
    80028724:	21913423          	sd	s9,520(sp)
    80028728:	21a13023          	sd	s10,512(sp)
    8002872c:	1480                	addi	s0,sp,608
	uint8 buf[BSIZE];

	for (int sec = 0; sec < 5; sec ++) {
    8002872e:	4c81                	li	s9,0
    80028730:	fa040993          	addi	s3,s0,-96
		for (int i = 0; i < BSIZE; i ++) {
			buf[i] = 0xaa;		// data to be written 
    80028734:	faa00b93          	li	s7,-86
		}

		sdcard_write_sector(buf, sec);

		for (int i = 0; i < BSIZE; i ++) {
			buf[i] = 0xff;		// fill in junk
    80028738:	5b7d                	li	s6,-1
		}

		sdcard_read_sector(buf, sec);
		for (int i = 0; i < BSIZE; i ++) {
    8002873a:	4d01                	li	s10,0
			if (0 == i % 16) {
				printf("\n");
    8002873c:	00004c17          	auipc	s8,0x4
    80028740:	df4c0c13          	addi	s8,s8,-524 # 8002c530 <sysnames+0x5b0>
			}

			printf("%x ", buf[i]);
    80028744:	00004a97          	auipc	s5,0x4
    80028748:	764a8a93          	addi	s5,s5,1892 # 8002cea8 <function_config+0x640>
		for (int i = 0; i < BSIZE; i ++) {
    8002874c:	20000a13          	li	s4,512
    80028750:	a835                	j	8002878c <test_sdcard+0x94>
			printf("%x ", buf[i]);
    80028752:	00094583          	lbu	a1,0(s2)
    80028756:	8556                	mv	a0,s5
    80028758:	ffff8097          	auipc	ra,0xffff8
    8002875c:	a38080e7          	jalr	-1480(ra) # 80020190 <printf>
		for (int i = 0; i < BSIZE; i ++) {
    80028760:	2485                	addiw	s1,s1,1
    80028762:	0905                	addi	s2,s2,1
    80028764:	01448b63          	beq	s1,s4,8002877a <test_sdcard+0x82>
			if (0 == i % 16) {
    80028768:	00f4f793          	andi	a5,s1,15
    8002876c:	f3fd                	bnez	a5,80028752 <test_sdcard+0x5a>
				printf("\n");
    8002876e:	8562                	mv	a0,s8
    80028770:	ffff8097          	auipc	ra,0xffff8
    80028774:	a20080e7          	jalr	-1504(ra) # 80020190 <printf>
    80028778:	bfe9                	j	80028752 <test_sdcard+0x5a>
		}
		printf("\n");
    8002877a:	8562                	mv	a0,s8
    8002877c:	ffff8097          	auipc	ra,0xffff8
    80028780:	a14080e7          	jalr	-1516(ra) # 80020190 <printf>
	for (int sec = 0; sec < 5; sec ++) {
    80028784:	2c85                	addiw	s9,s9,1
    80028786:	4795                	li	a5,5
    80028788:	04fc8063          	beq	s9,a5,800287c8 <test_sdcard+0xd0>
    8002878c:	da040913          	addi	s2,s0,-608
void test_sdcard(void) {
    80028790:	87ca                	mv	a5,s2
			buf[i] = 0xaa;		// data to be written 
    80028792:	01778023          	sb	s7,0(a5)
    80028796:	0785                	addi	a5,a5,1
		for (int i = 0; i < BSIZE; i ++) {
    80028798:	ff379de3          	bne	a5,s3,80028792 <test_sdcard+0x9a>
		sdcard_write_sector(buf, sec);
    8002879c:	85e6                	mv	a1,s9
    8002879e:	da040513          	addi	a0,s0,-608
    800287a2:	00000097          	auipc	ra,0x0
    800287a6:	d6a080e7          	jalr	-662(ra) # 8002850c <sdcard_write_sector>
    800287aa:	87ca                	mv	a5,s2
			buf[i] = 0xff;		// fill in junk
    800287ac:	01678023          	sb	s6,0(a5)
    800287b0:	0785                	addi	a5,a5,1
		for (int i = 0; i < BSIZE; i ++) {
    800287b2:	ff379de3          	bne	a5,s3,800287ac <test_sdcard+0xb4>
		sdcard_read_sector(buf, sec);
    800287b6:	85e6                	mv	a1,s9
    800287b8:	da040513          	addi	a0,s0,-608
    800287bc:	00000097          	auipc	ra,0x0
    800287c0:	c4c080e7          	jalr	-948(ra) # 80028408 <sdcard_read_sector>
		for (int i = 0; i < BSIZE; i ++) {
    800287c4:	84ea                	mv	s1,s10
    800287c6:	b74d                	j	80028768 <test_sdcard+0x70>
	}

	while (1) ;
    800287c8:	a001                	j	800287c8 <test_sdcard+0xd0>

00000000800287ca <dmac_enable>:
{
    return dmac->channel[channel_num].axi_id;
}

static void dmac_enable(void)
{
    800287ca:	1141                	addi	sp,sp,-16
    800287cc:	e422                	sd	s0,8(sp)
    800287ce:	0800                	addi	s0,sp,16
    dmac_cfg_u_t dmac_cfg;

    dmac_cfg.data = readq(&dmac->cfg);
    800287d0:	3f500793          	li	a5,1013
    800287d4:	07f2                	slli	a5,a5,0x1c
    800287d6:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 1;
    dmac_cfg.cfg.int_en = 1;
    800287d8:	00376713          	ori	a4,a4,3
    writeq(dmac_cfg.data, &dmac->cfg);
    800287dc:	eb98                	sd	a4,16(a5)
}
    800287de:	6422                	ld	s0,8(sp)
    800287e0:	0141                	addi	sp,sp,16
    800287e2:	8082                	ret

00000000800287e4 <dmac_read_id>:
{
    800287e4:	1141                	addi	sp,sp,-16
    800287e6:	e422                	sd	s0,8(sp)
    800287e8:	0800                	addi	s0,sp,16
    return dmac->id;
    800287ea:	3f500793          	li	a5,1013
    800287ee:	07f2                	slli	a5,a5,0x1c
    800287f0:	6388                	ld	a0,0(a5)
}
    800287f2:	6422                	ld	s0,8(sp)
    800287f4:	0141                	addi	sp,sp,16
    800287f6:	8082                	ret

00000000800287f8 <dmac_read_version>:
{
    800287f8:	1141                	addi	sp,sp,-16
    800287fa:	e422                	sd	s0,8(sp)
    800287fc:	0800                	addi	s0,sp,16
    return dmac->compver;
    800287fe:	3f500793          	li	a5,1013
    80028802:	07f2                	slli	a5,a5,0x1c
    80028804:	6788                	ld	a0,8(a5)
}
    80028806:	6422                	ld	s0,8(sp)
    80028808:	0141                	addi	sp,sp,16
    8002880a:	8082                	ret

000000008002880c <dmac_read_channel_id>:
{
    8002880c:	1141                	addi	sp,sp,-16
    8002880e:	e422                	sd	s0,8(sp)
    80028810:	0800                	addi	s0,sp,16
    return dmac->channel[channel_num].axi_id;
    80028812:	1502                	slli	a0,a0,0x20
    80028814:	9101                	srli	a0,a0,0x20
    80028816:	00851793          	slli	a5,a0,0x8
    8002881a:	3f500513          	li	a0,1013
    8002881e:	0572                	slli	a0,a0,0x1c
    80028820:	953e                	add	a0,a0,a5
    80028822:	15053503          	ld	a0,336(a0)
}
    80028826:	6422                	ld	s0,8(sp)
    80028828:	0141                	addi	sp,sp,16
    8002882a:	8082                	ret

000000008002882c <dmac_disable>:

void dmac_disable(void)
{
    8002882c:	1141                	addi	sp,sp,-16
    8002882e:	e422                	sd	s0,8(sp)
    80028830:	0800                	addi	s0,sp,16
    dmac_cfg_u_t dmac_cfg;

    dmac_cfg.data = readq(&dmac->cfg);
    80028832:	3f500793          	li	a5,1013
    80028836:	07f2                	slli	a5,a5,0x1c
    80028838:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 0;
    dmac_cfg.cfg.int_en = 0;
    8002883a:	9b71                	andi	a4,a4,-4
    writeq(dmac_cfg.data, &dmac->cfg);
    8002883c:	eb98                	sd	a4,16(a5)
}
    8002883e:	6422                	ld	s0,8(sp)
    80028840:	0141                	addi	sp,sp,16
    80028842:	8082                	ret

0000000080028844 <dmac_channel_enable>:

void dmac_channel_enable(dmac_channel_number_t channel_num)
{
    80028844:	1141                	addi	sp,sp,-16
    80028846:	e422                	sd	s0,8(sp)
    80028848:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;

    chen.data = readq(&dmac->chen);
    8002884a:	3f500793          	li	a5,1013
    8002884e:	07f2                	slli	a5,a5,0x1c
    80028850:	6f9c                	ld	a5,24(a5)

    switch(channel_num)
    80028852:	4715                	li	a4,5
    80028854:	00a76d63          	bltu	a4,a0,8002886e <dmac_channel_enable+0x2a>
    80028858:	050a                	slli	a0,a0,0x2
    8002885a:	00004697          	auipc	a3,0x4
    8002885e:	65668693          	addi	a3,a3,1622 # 8002ceb0 <function_config+0x648>
    80028862:	9536                	add	a0,a0,a3
    80028864:	4118                	lw	a4,0(a0)
    80028866:	9736                	add	a4,a4,a3
    80028868:	8702                	jr	a4
    {
        case DMAC_CHANNEL0:
            chen.dmac_chen.ch1_en = 1;
            chen.dmac_chen.ch1_en_we = 1;
    8002886a:	1017e793          	ori	a5,a5,257
            break;
        default:
            break;
    }

    writeq(chen.data, &dmac->chen);
    8002886e:	3f500713          	li	a4,1013
    80028872:	0772                	slli	a4,a4,0x1c
    80028874:	ef1c                	sd	a5,24(a4)
}
    80028876:	6422                	ld	s0,8(sp)
    80028878:	0141                	addi	sp,sp,16
    8002887a:	8082                	ret
            chen.dmac_chen.ch2_en_we = 1;
    8002887c:	2027e793          	ori	a5,a5,514
            break;
    80028880:	b7fd                	j	8002886e <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch3_en_we = 1;
    80028882:	4047e793          	ori	a5,a5,1028
            break;
    80028886:	b7e5                	j	8002886e <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch4_en = 1;
    80028888:	0087e793          	ori	a5,a5,8
            chen.dmac_chen.ch4_en_we = 1;
    8002888c:	6705                	lui	a4,0x1
    8002888e:	80070713          	addi	a4,a4,-2048 # 800 <BASE_ADDRESS-0x8001f800>
    80028892:	8fd9                	or	a5,a5,a4
            break;
    80028894:	bfe9                	j	8002886e <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch5_en = 1;
    80028896:	0107e793          	ori	a5,a5,16
            chen.dmac_chen.ch5_en_we = 1;
    8002889a:	6705                	lui	a4,0x1
    8002889c:	8fd9                	or	a5,a5,a4
            break;
    8002889e:	bfc1                	j	8002886e <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch6_en = 1;
    800288a0:	0207e793          	ori	a5,a5,32
            chen.dmac_chen.ch6_en_we = 1;
    800288a4:	6709                	lui	a4,0x2
    800288a6:	8fd9                	or	a5,a5,a4
            break;
    800288a8:	b7d9                	j	8002886e <dmac_channel_enable+0x2a>

00000000800288aa <dmac_channel_disable>:

void dmac_channel_disable(dmac_channel_number_t channel_num)
{
    800288aa:	1141                	addi	sp,sp,-16
    800288ac:	e422                	sd	s0,8(sp)
    800288ae:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;

    chen.data = readq(&dmac->chen);
    800288b0:	3f500793          	li	a5,1013
    800288b4:	07f2                	slli	a5,a5,0x1c
    800288b6:	6f9c                	ld	a5,24(a5)

    switch(channel_num)
    800288b8:	4715                	li	a4,5
    800288ba:	00a76e63          	bltu	a4,a0,800288d6 <dmac_channel_disable+0x2c>
    800288be:	050a                	slli	a0,a0,0x2
    800288c0:	00004697          	auipc	a3,0x4
    800288c4:	60868693          	addi	a3,a3,1544 # 8002cec8 <function_config+0x660>
    800288c8:	9536                	add	a0,a0,a3
    800288ca:	4118                	lw	a4,0(a0)
    800288cc:	9736                	add	a4,a4,a3
    800288ce:	8702                	jr	a4
    {
        case DMAC_CHANNEL0:
            chen.dmac_chen.ch1_en = 0;
    800288d0:	9bf9                	andi	a5,a5,-2
            chen.dmac_chen.ch1_en_we = 1;
    800288d2:	1007e793          	ori	a5,a5,256
            break;
        default:
            break;
    }

    writeq(chen.data, &dmac->chen);
    800288d6:	3f500713          	li	a4,1013
    800288da:	0772                	slli	a4,a4,0x1c
    800288dc:	ef1c                	sd	a5,24(a4)
}
    800288de:	6422                	ld	s0,8(sp)
    800288e0:	0141                	addi	sp,sp,16
    800288e2:	8082                	ret
            chen.dmac_chen.ch2_en = 0;
    800288e4:	9bf5                	andi	a5,a5,-3
            chen.dmac_chen.ch2_en_we = 1;
    800288e6:	2007e793          	ori	a5,a5,512
            break;
    800288ea:	b7f5                	j	800288d6 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch3_en = 0;
    800288ec:	9bed                	andi	a5,a5,-5
            chen.dmac_chen.ch3_en_we = 1;
    800288ee:	4007e793          	ori	a5,a5,1024
            break;
    800288f2:	b7d5                	j	800288d6 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch4_en = 0;
    800288f4:	9bdd                	andi	a5,a5,-9
            chen.dmac_chen.ch4_en_we = 1;
    800288f6:	6705                	lui	a4,0x1
    800288f8:	80070713          	addi	a4,a4,-2048 # 800 <BASE_ADDRESS-0x8001f800>
    800288fc:	8fd9                	or	a5,a5,a4
            break;
    800288fe:	bfe1                	j	800288d6 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch5_en = 0;
    80028900:	9bbd                	andi	a5,a5,-17
            chen.dmac_chen.ch5_en_we = 1;
    80028902:	6705                	lui	a4,0x1
    80028904:	8fd9                	or	a5,a5,a4
            break;
    80028906:	bfc1                	j	800288d6 <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch6_en = 0;
    80028908:	fdf7f793          	andi	a5,a5,-33
            chen.dmac_chen.ch6_en_we = 1;
    8002890c:	6709                	lui	a4,0x2
    8002890e:	8fd9                	or	a5,a5,a4
            break;
    80028910:	b7d9                	j	800288d6 <dmac_channel_disable+0x2c>

0000000080028912 <dmac_enable_common_interrupt_status>:

void dmac_enable_common_interrupt_status(void)
{
    80028912:	1141                	addi	sp,sp,-16
    80028914:	e422                	sd	s0,8(sp)
    80028916:	0800                	addi	s0,sp,16
    dmac_commonreg_intstatus_enable_u_t intstatus;

    intstatus.data = readq(&dmac->com_intstatus_en);
    80028918:	3f500793          	li	a5,1013
    8002891c:	07f2                	slli	a5,a5,0x1c
    8002891e:	63b8                	ld	a4,64(a5)
    intstatus.intstatus_enable.enable_slvif_dec_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_wr2ro_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_rd2wo_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_wronhold_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_undefinedreg_dec_err_intstat = 1;
    80028920:	10f76713          	ori	a4,a4,271

    writeq(intstatus.data, &dmac->com_intstatus_en);
    80028924:	e3b8                	sd	a4,64(a5)
}
    80028926:	6422                	ld	s0,8(sp)
    80028928:	0141                	addi	sp,sp,16
    8002892a:	8082                	ret

000000008002892c <dmac_enable_common_interrupt_signal>:

void dmac_enable_common_interrupt_signal(void)
{
    8002892c:	1141                	addi	sp,sp,-16
    8002892e:	e422                	sd	s0,8(sp)
    80028930:	0800                	addi	s0,sp,16
    dmac_commonreg_intsignal_enable_u_t intsignal;

    intsignal.data = readq(&dmac->com_intsignal_en);
    80028932:	3f500793          	li	a5,1013
    80028936:	07f2                	slli	a5,a5,0x1c
    80028938:	67b8                	ld	a4,72(a5)
    intsignal.intsignal_enable.enable_slvif_dec_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_wr2ro_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_rd2wo_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_wronhold_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_undefinedreg_dec_err_intsignal = 1;
    8002893a:	10f76713          	ori	a4,a4,271

    writeq(intsignal.data, &dmac->com_intsignal_en);
    8002893e:	e7b8                	sd	a4,72(a5)
}
    80028940:	6422                	ld	s0,8(sp)
    80028942:	0141                	addi	sp,sp,16
    80028944:	8082                	ret

0000000080028946 <dmac_disable_channel_interrupt>:
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    writeq(0x2, &dmac->channel[channel_num].intstatus_en);
}

void dmac_disable_channel_interrupt(dmac_channel_number_t channel_num)
{
    80028946:	1141                	addi	sp,sp,-16
    80028948:	e422                	sd	s0,8(sp)
    8002894a:	0800                	addi	s0,sp,16
    writeq(0, &dmac->channel[channel_num].intstatus_en);
    8002894c:	1502                	slli	a0,a0,0x20
    8002894e:	9101                	srli	a0,a0,0x20
    80028950:	00851793          	slli	a5,a0,0x8
    80028954:	3f500513          	li	a0,1013
    80028958:	0572                	slli	a0,a0,0x1c
    8002895a:	953e                	add	a0,a0,a5
    8002895c:	18053023          	sd	zero,384(a0)
}
    80028960:	6422                	ld	s0,8(sp)
    80028962:	0141                	addi	sp,sp,16
    80028964:	8082                	ret

0000000080028966 <dmac_set_channel_param>:
int dmac_set_channel_param(dmac_channel_number_t channel_num,
                           const void *src, void *dest, dmac_address_increment_t src_inc, dmac_address_increment_t dest_inc,
                           dmac_burst_trans_length_t dmac_burst_size,
                           dmac_transfer_width_t dmac_trans_width,
                           uint32 blockSize)
{
    80028966:	1141                	addi	sp,sp,-16
    80028968:	e422                	sd	s0,8(sp)
    8002896a:	0800                	addi	s0,sp,16
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    8002896c:	80000e37          	lui	t3,0x80000
    80028970:	9e2e                	add	t3,t3,a1
    80028972:	00600337          	lui	t1,0x600
    80028976:	046e6663          	bltu	t3,t1,800289c2 <dmac_set_channel_param+0x5c>
    8002897a:	c0000337          	lui	t1,0xc0000
    8002897e:	932e                	add	t1,t1,a1
    80028980:	00800e37          	lui	t3,0x800
    80028984:	03c36f63          	bltu	t1,t3,800289c2 <dmac_set_channel_param+0x5c>
    80028988:	afbb02b7          	lui	t0,0xafbb0
    8002898c:	fc028293          	addi	t0,t0,-64 # ffffffffafbaffc0 <kernel_end+0xffffffff2fb69fc0>
    80028990:	92ae                	add	t0,t0,a1
    80028992:	0012b293          	seqz	t0,t0
    dmac_ch_ctl_u_t ctl;
    dmac_ch_cfg_u_t cfg_u;

    int mem_type_src = is_memory((uintptr_t)src), mem_type_dest = is_memory((uintptr_t)dest);
    80028996:	8fb2                	mv	t6,a2
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028998:	80000337          	lui	t1,0x80000
    8002899c:	9332                	add	t1,t1,a2
    8002899e:	00600e37          	lui	t3,0x600
    800289a2:	4f05                	li	t5,1
    800289a4:	03c37863          	bgeu	t1,t3,800289d4 <dmac_set_channel_param+0x6e>
    {
        flow_control = DMAC_PRF2PRF_DMA;
    } else if(mem_type_src == 1 && mem_type_dest == 0)
        flow_control = DMAC_MEM2PRF_DMA;
    else if(mem_type_src == 0 && mem_type_dest == 1)
        flow_control = DMAC_PRF2MEM_DMA;
    800289a8:	4309                	li	t1,2
    } else if(mem_type_src == 1 && mem_type_dest == 0)
    800289aa:	04028963          	beqz	t0,800289fc <dmac_set_channel_param+0x96>
    800289ae:	a039                	j	800289bc <dmac_set_channel_param+0x56>
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    800289b0:	8f32                	mv	t5,a2
    800289b2:	bfdd                	j	800289a8 <dmac_set_channel_param+0x42>
    800289b4:	4f05                	li	t5,1
    800289b6:	bfcd                	j	800289a8 <dmac_set_channel_param+0x42>
    800289b8:	4f05                	li	t5,1
    800289ba:	4285                	li	t0,1
        flow_control = DMAC_PRF2PRF_DMA;
    800289bc:	001f3313          	seqz	t1,t5
    800289c0:	a835                	j	800289fc <dmac_set_channel_param+0x96>
    int mem_type_src = is_memory((uintptr_t)src), mem_type_dest = is_memory((uintptr_t)dest);
    800289c2:	8fb2                	mv	t6,a2
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    800289c4:	80000337          	lui	t1,0x80000
    800289c8:	9332                	add	t1,t1,a2
    800289ca:	00600e37          	lui	t3,0x600
    800289ce:	4285                	li	t0,1
    800289d0:	ffc364e3          	bltu	t1,t3,800289b8 <dmac_set_channel_param+0x52>
    800289d4:	c0000337          	lui	t1,0xc0000
    800289d8:	937e                	add	t1,t1,t6
    800289da:	00800e37          	lui	t3,0x800
    800289de:	fdc36be3          	bltu	t1,t3,800289b4 <dmac_set_channel_param+0x4e>
    800289e2:	afbb0337          	lui	t1,0xafbb0
    800289e6:	fc030313          	addi	t1,t1,-64 # ffffffffafbaffc0 <kernel_end+0xffffffff2fb69fc0>
    800289ea:	961a                	add	a2,a2,t1
    800289ec:	00163613          	seqz	a2,a2
    if(mem_type_src == 0 && mem_type_dest == 0)
    800289f0:	00566f33          	or	t5,a2,t0
    800289f4:	2f01                	sext.w	t5,t5
        flow_control = DMAC_PRF2PRF_DMA;
    800289f6:	430d                	li	t1,3
    if(mem_type_src == 0 && mem_type_dest == 0)
    800289f8:	fa0f1ce3          	bnez	t5,800289b0 <dmac_set_channel_param+0x4a>

    /**
     * cfg register must configure before ts_block and
     * sar dar register
     */
    cfg_u.data = readq(&dmac->channel[channel_num].cfg);
    800289fc:	02051e93          	slli	t4,a0,0x20
    80028a00:	020ede93          	srli	t4,t4,0x20
    80028a04:	008e9613          	slli	a2,t4,0x8
    80028a08:	3f500e93          	li	t4,1013
    80028a0c:	0ef2                	slli	t4,t4,0x1c
    80028a0e:	9eb2                	add	t4,t4,a2
    80028a10:	120ebe03          	ld	t3,288(t4)

    cfg_u.ch_cfg.tt_fc = flow_control;
    80028a14:	02031613          	slli	a2,t1,0x20
    80028a18:	5365                	li	t1,-7
    80028a1a:	1302                	slli	t1,t1,0x20
    80028a1c:	137d                	addi	t1,t1,-1
    80028a1e:	006e7333          	and	t1,t3,t1
    80028a22:	00c36333          	or	t1,t1,a2
    cfg_u.ch_cfg.hs_sel_src = mem_type_src ? DMAC_HS_SOFTWARE : DMAC_HS_HARDWARE;
    80028a26:	128e                	slli	t0,t0,0x23
    80028a28:	567d                	li	a2,-1
    80028a2a:	02361e13          	slli	t3,a2,0x23
    80028a2e:	1e7d                	addi	t3,t3,-1
    80028a30:	01c37333          	and	t1,t1,t3
    80028a34:	00536333          	or	t1,t1,t0
    cfg_u.ch_cfg.hs_sel_dst = mem_type_dest ? DMAC_HS_SOFTWARE : DMAC_HS_HARDWARE;
    80028a38:	01e03f33          	snez	t5,t5
    80028a3c:	1f12                	slli	t5,t5,0x24
    80028a3e:	1612                	slli	a2,a2,0x24
    80028a40:	167d                	addi	a2,a2,-1
    80028a42:	00c37333          	and	t1,t1,a2
    80028a46:	01e36333          	or	t1,t1,t5
    cfg_u.ch_cfg.src_per = channel_num;
    80028a4a:	893d                	andi	a0,a0,15
    80028a4c:	02751f13          	slli	t5,a0,0x27
    80028a50:	5645                	li	a2,-15
    80028a52:	02761e13          	slli	t3,a2,0x27
    80028a56:	1e7d                	addi	t3,t3,-1
    80028a58:	01c37333          	and	t1,t1,t3
    80028a5c:	01e36333          	or	t1,t1,t5
    cfg_u.ch_cfg.dst_per = channel_num;
    80028a60:	02c51e13          	slli	t3,a0,0x2c
    80028a64:	02c61513          	slli	a0,a2,0x2c
    80028a68:	157d                	addi	a0,a0,-1
    80028a6a:	00a37533          	and	a0,t1,a0
    80028a6e:	01c56533          	or	a0,a0,t3
    cfg_u.ch_cfg.src_multblk_type = 0;
    cfg_u.ch_cfg.dst_multblk_type = 0;
    80028a72:	9941                	andi	a0,a0,-16

    writeq(cfg_u.data, &dmac->channel[channel_num].cfg);
    80028a74:	12aeb023          	sd	a0,288(t4)

    dmac->channel[channel_num].sar = (uint64)src;
    80028a78:	10beb023          	sd	a1,256(t4)
    dmac->channel[channel_num].dar = (uint64)dest;
    80028a7c:	11feb423          	sd	t6,264(t4)

    ctl.data = readq(&dmac->channel[channel_num].ctl);
    80028a80:	118eb603          	ld	a2,280(t4)
    ctl.ch_ctl.sms = DMAC_MASTER1;
    ctl.ch_ctl.dms = DMAC_MASTER2;
    80028a84:	9a39                	andi	a2,a2,-18
    /* master select */
    ctl.ch_ctl.sinc = src_inc;
    80028a86:	8a85                	andi	a3,a3,1
    80028a88:	0692                	slli	a3,a3,0x4
    80028a8a:	00466613          	ori	a2,a2,4
    80028a8e:	8e55                	or	a2,a2,a3
    ctl.ch_ctl.dinc = dest_inc;
    80028a90:	8b05                	andi	a4,a4,1
    80028a92:	071a                	slli	a4,a4,0x6
    80028a94:	8be67613          	andi	a2,a2,-1858
    /* address incrememt */
    ctl.ch_ctl.src_tr_width = dmac_trans_width;
    80028a98:	00787813          	andi	a6,a6,7
    80028a9c:	00881693          	slli	a3,a6,0x8
    80028aa0:	8e59                	or	a2,a2,a4
    80028aa2:	8e55                	or	a2,a2,a3
    ctl.ch_ctl.dst_tr_width = dmac_trans_width;
    80028aa4:	082e                	slli	a6,a6,0xb
    80028aa6:	7771                	lui	a4,0xffffc
    80028aa8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffc7ff <kernel_end+0xffffffff7ffb67ff>
    80028aac:	8e79                	and	a2,a2,a4
    80028aae:	01066633          	or	a2,a2,a6
    /* transfer width */
    ctl.ch_ctl.src_msize = dmac_burst_size;
    80028ab2:	00f7f713          	andi	a4,a5,15
    80028ab6:	00e71693          	slli	a3,a4,0xe
    80028aba:	fffc47b7          	lui	a5,0xfffc4
    80028abe:	17fd                	addi	a5,a5,-1
    80028ac0:	8ff1                	and	a5,a5,a2
    80028ac2:	8fd5                	or	a5,a5,a3
    ctl.ch_ctl.dst_msize = dmac_burst_size;
    80028ac4:	074a                	slli	a4,a4,0x12
    80028ac6:	ffc40637          	lui	a2,0xffc40
    80028aca:	167d                	addi	a2,a2,-1
    80028acc:	8ff1                	and	a5,a5,a2
    80028ace:	8fd9                	or	a5,a5,a4

    writeq(ctl.data, &dmac->channel[channel_num].ctl);
    80028ad0:	10febc23          	sd	a5,280(t4)

    writeq(blockSize - 1, &dmac->channel[channel_num].block_ts);
    80028ad4:	38fd                	addiw	a7,a7,-1
    80028ad6:	1882                	slli	a7,a7,0x20
    80028ad8:	0208d893          	srli	a7,a7,0x20
    80028adc:	111eb823          	sd	a7,272(t4)
    /*the number of (blcok_ts +1) data of width SRC_TR_WIDTF to be */
    /* transferred in a dma block transfer */
    return 0;
}
    80028ae0:	4501                	li	a0,0
    80028ae2:	6422                	ld	s0,8(sp)
    80028ae4:	0141                	addi	sp,sp,16
    80028ae6:	8082                	ret

0000000080028ae8 <dmac_init>:

void dmac_init(void)
{
    80028ae8:	1141                	addi	sp,sp,-16
    80028aea:	e406                	sd	ra,8(sp)
    80028aec:	e022                	sd	s0,0(sp)
    80028aee:	0800                	addi	s0,sp,16
    uint64 tmp;
    dmac_commonreg_intclear_u_t intclear;
    dmac_cfg_u_t dmac_cfg;
    dmac_reset_u_t dmac_reset;

    sysctl_clock_enable(SYSCTL_CLOCK_DMA);
    80028af0:	4529                	li	a0,10
    80028af2:	00000097          	auipc	ra,0x0
    80028af6:	220080e7          	jalr	544(ra) # 80028d12 <sysctl_clock_enable>
    // printf("[dmac_init] dma clk=%d\n", sysctl_clock_get_freq(SYSCTL_CLOCK_DMA));

    dmac_reset.data = readq(&dmac->reset);
    80028afa:	3f500793          	li	a5,1013
    80028afe:	07f2                	slli	a5,a5,0x1c
    80028b00:	6fb8                	ld	a4,88(a5)
    dmac_reset.reset.rst = 1;
    80028b02:	00176713          	ori	a4,a4,1
    writeq(dmac_reset.data, &dmac->reset);
    80028b06:	efb8                	sd	a4,88(a5)
    while(dmac_reset.reset.rst)
        dmac_reset.data = readq(&dmac->reset);
    80028b08:	873e                	mv	a4,a5
    80028b0a:	6f3c                	ld	a5,88(a4)
    while(dmac_reset.reset.rst)
    80028b0c:	8b85                	andi	a5,a5,1
    80028b0e:	fff5                	bnez	a5,80028b0a <dmac_init+0x22>

    /*reset dmac */

    intclear.data = readq(&dmac->com_intclear);
    80028b10:	3f500793          	li	a5,1013
    80028b14:	07f2                	slli	a5,a5,0x1c
    80028b16:	7f98                	ld	a4,56(a5)
    intclear.com_intclear.clear_slvif_dec_err_intstat = 1;
    intclear.com_intclear.clear_slvif_wr2ro_err_intstat = 1;
    intclear.com_intclear.clear_slvif_rd2wo_err_intstat = 1;
    intclear.com_intclear.clear_slvif_wronhold_err_intstat = 1;
    intclear.com_intclear.clear_slvif_undefinedreg_dec_err_intstat = 1;
    80028b18:	10f76713          	ori	a4,a4,271
    writeq(intclear.data, &dmac->com_intclear);
    80028b1c:	ff98                	sd	a4,56(a5)
    /* clear common register interrupt */

    dmac_cfg.data = readq(&dmac->cfg);
    80028b1e:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 0;
    dmac_cfg.cfg.int_en = 0;
    80028b20:	9b71                	andi	a4,a4,-4
    writeq(dmac_cfg.data, &dmac->cfg);
    80028b22:	eb98                	sd	a4,16(a5)
    /* disable dmac and disable interrupt */

    while(readq(&dmac->cfg))
    80028b24:	873e                	mv	a4,a5
    80028b26:	6b1c                	ld	a5,16(a4)
    80028b28:	fffd                	bnez	a5,80028b26 <dmac_init+0x3e>
        ;
    tmp = readq(&dmac->chen);
    80028b2a:	3f500793          	li	a5,1013
    80028b2e:	07f2                	slli	a5,a5,0x1c
    80028b30:	6f98                	ld	a4,24(a5)
    tmp &= ~0xf;
    80028b32:	9b41                	andi	a4,a4,-16
    writeq(tmp, &dmac->chen);
    80028b34:	ef98                	sd	a4,24(a5)
    /* disable all channel before configure */
    dmac_enable();
    80028b36:	00000097          	auipc	ra,0x0
    80028b3a:	c94080e7          	jalr	-876(ra) # 800287ca <dmac_enable>
}
    80028b3e:	60a2                	ld	ra,8(sp)
    80028b40:	6402                	ld	s0,0(sp)
    80028b42:	0141                	addi	sp,sp,16
    80028b44:	8082                	ret

0000000080028b46 <dmac_is_done>:
    dmac_enable_channel_interrupt(channel_num);
    dmac_channel_enable(channel_num);
}

int dmac_is_done(dmac_channel_number_t channel_num)
{
    80028b46:	1141                	addi	sp,sp,-16
    80028b48:	e422                	sd	s0,8(sp)
    80028b4a:	0800                	addi	s0,sp,16
    if(readq(&dmac->channel[channel_num].intstatus) & 0x2)
    80028b4c:	1502                	slli	a0,a0,0x20
    80028b4e:	9101                	srli	a0,a0,0x20
    80028b50:	00851793          	slli	a5,a0,0x8
    80028b54:	3f500513          	li	a0,1013
    80028b58:	0572                	slli	a0,a0,0x1c
    80028b5a:	953e                	add	a0,a0,a5
    80028b5c:	18853503          	ld	a0,392(a0)
    80028b60:	8105                	srli	a0,a0,0x1
        return 1;
    else
        return 0;
}
    80028b62:	8905                	andi	a0,a0,1
    80028b64:	6422                	ld	s0,8(sp)
    80028b66:	0141                	addi	sp,sp,16
    80028b68:	8082                	ret

0000000080028b6a <dmac_is_idle>:
{
    dmac_wait_idle(channel_num);
}

int dmac_is_idle(dmac_channel_number_t channel_num)
{
    80028b6a:	1141                	addi	sp,sp,-16
    80028b6c:	e422                	sd	s0,8(sp)
    80028b6e:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;
    chen.data = readq(&dmac->chen);
    80028b70:	3f500793          	li	a5,1013
    80028b74:	07f2                	slli	a5,a5,0x1c
    80028b76:	6f9c                	ld	a5,24(a5)
    if((chen.data >> channel_num) & 0x1UL)
    80028b78:	00a7d533          	srl	a0,a5,a0
    80028b7c:	00154513          	xori	a0,a0,1
        return 0;
    else
        return 1;
}
    80028b80:	8905                	andi	a0,a0,1
    80028b82:	6422                	ld	s0,8(sp)
    80028b84:	0141                	addi	sp,sp,16
    80028b86:	8082                	ret

0000000080028b88 <dmac_wait_idle>:

static void *dmac_chan = (void *) DMAC_V;

void dmac_wait_idle(dmac_channel_number_t channel_num)
{
    80028b88:	1101                	addi	sp,sp,-32
    80028b8a:	ec06                	sd	ra,24(sp)
    80028b8c:	e822                	sd	s0,16(sp)
    80028b8e:	e426                	sd	s1,8(sp)
    80028b90:	e04a                	sd	s2,0(sp)
    80028b92:	1000                	addi	s0,sp,32
    80028b94:	892a                	mv	s2,a0
    while(!dmac_is_idle(channel_num)) {
        acquire(&myproc()->lock);
        sleep(dmac_chan, &myproc()->lock);
    80028b96:	3f500493          	li	s1,1013
    80028b9a:	04f2                	slli	s1,s1,0x1c
    while(!dmac_is_idle(channel_num)) {
    80028b9c:	854a                	mv	a0,s2
    80028b9e:	00000097          	auipc	ra,0x0
    80028ba2:	fcc080e7          	jalr	-52(ra) # 80028b6a <dmac_is_idle>
    80028ba6:	ed05                	bnez	a0,80028bde <dmac_wait_idle+0x56>
        acquire(&myproc()->lock);
    80028ba8:	ffff9097          	auipc	ra,0xffff9
    80028bac:	fda080e7          	jalr	-38(ra) # 80021b82 <myproc>
    80028bb0:	ffff8097          	auipc	ra,0xffff8
    80028bb4:	b10080e7          	jalr	-1264(ra) # 800206c0 <acquire>
        sleep(dmac_chan, &myproc()->lock);
    80028bb8:	ffff9097          	auipc	ra,0xffff9
    80028bbc:	fca080e7          	jalr	-54(ra) # 80021b82 <myproc>
    80028bc0:	85aa                	mv	a1,a0
    80028bc2:	8526                	mv	a0,s1
    80028bc4:	ffffa097          	auipc	ra,0xffffa
    80028bc8:	840080e7          	jalr	-1984(ra) # 80022404 <sleep>
        release(&myproc()->lock);
    80028bcc:	ffff9097          	auipc	ra,0xffff9
    80028bd0:	fb6080e7          	jalr	-74(ra) # 80021b82 <myproc>
    80028bd4:	ffff8097          	auipc	ra,0xffff8
    80028bd8:	b40080e7          	jalr	-1216(ra) # 80020714 <release>
    80028bdc:	b7c1                	j	80028b9c <dmac_wait_idle+0x14>
    }
}
    80028bde:	60e2                	ld	ra,24(sp)
    80028be0:	6442                	ld	s0,16(sp)
    80028be2:	64a2                	ld	s1,8(sp)
    80028be4:	6902                	ld	s2,0(sp)
    80028be6:	6105                	addi	sp,sp,32
    80028be8:	8082                	ret

0000000080028bea <dmac_set_single_mode>:
{
    80028bea:	711d                	addi	sp,sp,-96
    80028bec:	ec86                	sd	ra,88(sp)
    80028bee:	e8a2                	sd	s0,80(sp)
    80028bf0:	e4a6                	sd	s1,72(sp)
    80028bf2:	e0ca                	sd	s2,64(sp)
    80028bf4:	fc4e                	sd	s3,56(sp)
    80028bf6:	f852                	sd	s4,48(sp)
    80028bf8:	f456                	sd	s5,40(sp)
    80028bfa:	f05a                	sd	s6,32(sp)
    80028bfc:	ec5e                	sd	s7,24(sp)
    80028bfe:	e862                	sd	s8,16(sp)
    80028c00:	e466                	sd	s9,8(sp)
    80028c02:	e06a                	sd	s10,0(sp)
    80028c04:	1080                	addi	s0,sp,96
    80028c06:	892a                	mv	s2,a0
    80028c08:	8a2e                	mv	s4,a1
    80028c0a:	8ab2                	mv	s5,a2
    80028c0c:	8b36                	mv	s6,a3
    80028c0e:	8bba                	mv	s7,a4
    80028c10:	8c3e                	mv	s8,a5
    80028c12:	8cc2                	mv	s9,a6
    80028c14:	8d46                	mv	s10,a7
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028c16:	02051493          	slli	s1,a0,0x20
    80028c1a:	9081                	srli	s1,s1,0x20
    80028c1c:	00849793          	slli	a5,s1,0x8
    80028c20:	3f500493          	li	s1,1013
    80028c24:	04f2                	slli	s1,s1,0x1c
    80028c26:	94be                	add	s1,s1,a5
    80028c28:	59fd                	li	s3,-1
    80028c2a:	0209d993          	srli	s3,s3,0x20
    80028c2e:	1934bc23          	sd	s3,408(s1) # 1000198 <BASE_ADDRESS-0x7f01fe68>
    dmac_channel_disable(channel_num);
    80028c32:	00000097          	auipc	ra,0x0
    80028c36:	c78080e7          	jalr	-904(ra) # 800288aa <dmac_channel_disable>
    dmac_wait_idle(channel_num);
    80028c3a:	854a                	mv	a0,s2
    80028c3c:	00000097          	auipc	ra,0x0
    80028c40:	f4c080e7          	jalr	-180(ra) # 80028b88 <dmac_wait_idle>
    dmac_set_channel_param(channel_num, src, dest, src_inc, dest_inc,
    80028c44:	000d089b          	sext.w	a7,s10
    80028c48:	8866                	mv	a6,s9
    80028c4a:	87e2                	mv	a5,s8
    80028c4c:	875e                	mv	a4,s7
    80028c4e:	86da                	mv	a3,s6
    80028c50:	8656                	mv	a2,s5
    80028c52:	85d2                	mv	a1,s4
    80028c54:	854a                	mv	a0,s2
    80028c56:	00000097          	auipc	ra,0x0
    80028c5a:	d10080e7          	jalr	-752(ra) # 80028966 <dmac_set_channel_param>
    dmac_enable();
    80028c5e:	00000097          	auipc	ra,0x0
    80028c62:	b6c080e7          	jalr	-1172(ra) # 800287ca <dmac_enable>
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028c66:	1934bc23          	sd	s3,408(s1)
    writeq(0x2, &dmac->channel[channel_num].intstatus_en);
    80028c6a:	4789                	li	a5,2
    80028c6c:	18f4b023          	sd	a5,384(s1)
    dmac_channel_enable(channel_num);
    80028c70:	854a                	mv	a0,s2
    80028c72:	00000097          	auipc	ra,0x0
    80028c76:	bd2080e7          	jalr	-1070(ra) # 80028844 <dmac_channel_enable>
}
    80028c7a:	60e6                	ld	ra,88(sp)
    80028c7c:	6446                	ld	s0,80(sp)
    80028c7e:	64a6                	ld	s1,72(sp)
    80028c80:	6906                	ld	s2,64(sp)
    80028c82:	79e2                	ld	s3,56(sp)
    80028c84:	7a42                	ld	s4,48(sp)
    80028c86:	7aa2                	ld	s5,40(sp)
    80028c88:	7b02                	ld	s6,32(sp)
    80028c8a:	6be2                	ld	s7,24(sp)
    80028c8c:	6c42                	ld	s8,16(sp)
    80028c8e:	6ca2                	ld	s9,8(sp)
    80028c90:	6d02                	ld	s10,0(sp)
    80028c92:	6125                	addi	sp,sp,96
    80028c94:	8082                	ret

0000000080028c96 <dmac_wait_done>:
{
    80028c96:	1141                	addi	sp,sp,-16
    80028c98:	e406                	sd	ra,8(sp)
    80028c9a:	e022                	sd	s0,0(sp)
    80028c9c:	0800                	addi	s0,sp,16
    dmac_wait_idle(channel_num);
    80028c9e:	00000097          	auipc	ra,0x0
    80028ca2:	eea080e7          	jalr	-278(ra) # 80028b88 <dmac_wait_idle>
}
    80028ca6:	60a2                	ld	ra,8(sp)
    80028ca8:	6402                	ld	s0,0(sp)
    80028caa:	0141                	addi	sp,sp,16
    80028cac:	8082                	ret

0000000080028cae <dmac_intr>:

void dmac_intr(dmac_channel_number_t channel_num)
{
    80028cae:	1141                	addi	sp,sp,-16
    80028cb0:	e406                	sd	ra,8(sp)
    80028cb2:	e022                	sd	s0,0(sp)
    80028cb4:	0800                	addi	s0,sp,16
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028cb6:	3f500793          	li	a5,1013
    80028cba:	07f2                	slli	a5,a5,0x1c
    80028cbc:	1502                	slli	a0,a0,0x20
    80028cbe:	9101                	srli	a0,a0,0x20
    80028cc0:	0522                	slli	a0,a0,0x8
    80028cc2:	953e                	add	a0,a0,a5
    80028cc4:	577d                	li	a4,-1
    80028cc6:	9301                	srli	a4,a4,0x20
    80028cc8:	18e53c23          	sd	a4,408(a0)
    dmac_chanel_interrupt_clear(channel_num);
    wakeup(dmac_chan);
    80028ccc:	853e                	mv	a0,a5
    80028cce:	ffffa097          	auipc	ra,0xffffa
    80028cd2:	8b8080e7          	jalr	-1864(ra) # 80022586 <wakeup>
    80028cd6:	60a2                	ld	ra,8(sp)
    80028cd8:	6402                	ld	s0,0(sp)
    80028cda:	0141                	addi	sp,sp,16
    80028cdc:	8082                	ret

0000000080028cde <sysctl_get_git_id>:
};

volatile sysctl_t *const sysctl = (volatile sysctl_t *)SYSCTL_V;

uint32 sysctl_get_git_id(void)
{
    80028cde:	1141                	addi	sp,sp,-16
    80028ce0:	e422                	sd	s0,8(sp)
    80028ce2:	0800                	addi	s0,sp,16
    return sysctl->git_id.git_id;
    80028ce4:	000fd7b7          	lui	a5,0xfd
    80028ce8:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028cec:	07ca                	slli	a5,a5,0x12
    80028cee:	4388                	lw	a0,0(a5)
}
    80028cf0:	2501                	sext.w	a0,a0
    80028cf2:	6422                	ld	s0,8(sp)
    80028cf4:	0141                	addi	sp,sp,16
    80028cf6:	8082                	ret

0000000080028cf8 <sysctl_get_freq>:

uint32 sysctl_get_freq(void)
{
    80028cf8:	1141                	addi	sp,sp,-16
    80028cfa:	e422                	sd	s0,8(sp)
    80028cfc:	0800                	addi	s0,sp,16
    return sysctl->clk_freq.clk_freq;
    80028cfe:	000fd7b7          	lui	a5,0xfd
    80028d02:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028d06:	07ca                	slli	a5,a5,0x12
    80028d08:	43c8                	lw	a0,4(a5)
}
    80028d0a:	2501                	sext.w	a0,a0
    80028d0c:	6422                	ld	s0,8(sp)
    80028d0e:	0141                	addi	sp,sp,16
    80028d10:	8082                	ret

0000000080028d12 <sysctl_clock_enable>:

    return 0;
}

int sysctl_clock_enable(sysctl_clock_t clock)
{
    80028d12:	1141                	addi	sp,sp,-16
    80028d14:	e422                	sd	s0,8(sp)
    80028d16:	0800                	addi	s0,sp,16
    if(clock >= SYSCTL_CLOCK_MAX)
    80028d18:	02a00793          	li	a5,42
    80028d1c:	3ea7e363          	bltu	a5,a0,80029102 <sysctl_clock_enable+0x3f0>
        switch(clock)
    80028d20:	ff25079b          	addiw	a5,a0,-14
    80028d24:	0007869b          	sext.w	a3,a5
    80028d28:	475d                	li	a4,23
    80028d2a:	02d76663          	bltu	a4,a3,80028d56 <sysctl_clock_enable+0x44>
    80028d2e:	1782                	slli	a5,a5,0x20
    80028d30:	9381                	srli	a5,a5,0x20
    80028d32:	078a                	slli	a5,a5,0x2
    80028d34:	00004717          	auipc	a4,0x4
    80028d38:	1ac70713          	addi	a4,a4,428 # 8002cee0 <function_config+0x678>
    80028d3c:	97ba                	add	a5,a5,a4
    80028d3e:	439c                	lw	a5,0(a5)
    80028d40:	97ba                	add	a5,a5,a4
    80028d42:	8782                	jr	a5
                sysctl->clk_en_cent.apb0_clk_en = en;
    80028d44:	000fd7b7          	lui	a5,0xfd
    80028d48:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028d4c:	07ca                	slli	a5,a5,0x12
    80028d4e:	5798                	lw	a4,40(a5)
    80028d50:	00876713          	ori	a4,a4,8
    80028d54:	d798                	sw	a4,40(a5)
    switch(clock)
    80028d56:	02500793          	li	a5,37
    80028d5a:	3aa7e663          	bltu	a5,a0,80029106 <sysctl_clock_enable+0x3f4>
    80028d5e:	050a                	slli	a0,a0,0x2
    80028d60:	00004717          	auipc	a4,0x4
    80028d64:	1e070713          	addi	a4,a4,480 # 8002cf40 <function_config+0x6d8>
    80028d68:	953a                	add	a0,a0,a4
    80028d6a:	411c                	lw	a5,0(a0)
    80028d6c:	97ba                	add	a5,a5,a4
    80028d6e:	8782                	jr	a5
                sysctl->clk_en_cent.apb1_clk_en = en;
    80028d70:	000fd7b7          	lui	a5,0xfd
    80028d74:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028d78:	07ca                	slli	a5,a5,0x12
    80028d7a:	5798                	lw	a4,40(a5)
    80028d7c:	01076713          	ori	a4,a4,16
    80028d80:	d798                	sw	a4,40(a5)
                break;
    80028d82:	bfd1                	j	80028d56 <sysctl_clock_enable+0x44>
                sysctl->clk_en_cent.apb2_clk_en = en;
    80028d84:	000fd7b7          	lui	a5,0xfd
    80028d88:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028d8c:	07ca                	slli	a5,a5,0x12
    80028d8e:	5798                	lw	a4,40(a5)
    80028d90:	02076713          	ori	a4,a4,32
    80028d94:	d798                	sw	a4,40(a5)
                break;
    80028d96:	b7c1                	j	80028d56 <sysctl_clock_enable+0x44>
            sysctl->pll0.pll_out_en0 = en;
    80028d98:	000fd7b7          	lui	a5,0xfd
    80028d9c:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028da0:	07ca                	slli	a5,a5,0x12
    80028da2:	4798                	lw	a4,8(a5)
    80028da4:	020006b7          	lui	a3,0x2000
    80028da8:	8f55                	or	a4,a4,a3
    80028daa:	c798                	sw	a4,8(a5)
        return -1;
    sysctl_clock_bus_en(clock, 1);
    sysctl_clock_device_en(clock, 1);
    return 0;
    80028dac:	4501                	li	a0,0
}
    80028dae:	6422                	ld	s0,8(sp)
    80028db0:	0141                	addi	sp,sp,16
    80028db2:	8082                	ret
            sysctl->pll1.pll_out_en1 = en;
    80028db4:	000fd7b7          	lui	a5,0xfd
    80028db8:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028dbc:	07ca                	slli	a5,a5,0x12
    80028dbe:	47d8                	lw	a4,12(a5)
    80028dc0:	020006b7          	lui	a3,0x2000
    80028dc4:	8f55                	or	a4,a4,a3
    80028dc6:	c7d8                	sw	a4,12(a5)
    return 0;
    80028dc8:	4501                	li	a0,0
    80028dca:	b7d5                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->pll2.pll_out_en2 = en;
    80028dcc:	000fd7b7          	lui	a5,0xfd
    80028dd0:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028dd4:	07ca                	slli	a5,a5,0x12
    80028dd6:	4b98                	lw	a4,16(a5)
    80028dd8:	020006b7          	lui	a3,0x2000
    80028ddc:	8f55                	or	a4,a4,a3
    80028dde:	cb98                	sw	a4,16(a5)
    return 0;
    80028de0:	4501                	li	a0,0
    80028de2:	b7f1                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.cpu_clk_en = en;
    80028de4:	000fd7b7          	lui	a5,0xfd
    80028de8:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028dec:	07ca                	slli	a5,a5,0x12
    80028dee:	5798                	lw	a4,40(a5)
    80028df0:	00176713          	ori	a4,a4,1
    80028df4:	d798                	sw	a4,40(a5)
    return 0;
    80028df6:	4501                	li	a0,0
    80028df8:	bf5d                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.sram0_clk_en = en;
    80028dfa:	000fd7b7          	lui	a5,0xfd
    80028dfe:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e02:	07ca                	slli	a5,a5,0x12
    80028e04:	5798                	lw	a4,40(a5)
    80028e06:	00276713          	ori	a4,a4,2
    80028e0a:	d798                	sw	a4,40(a5)
    return 0;
    80028e0c:	4501                	li	a0,0
    80028e0e:	b745                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.sram1_clk_en = en;
    80028e10:	000fd7b7          	lui	a5,0xfd
    80028e14:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e18:	07ca                	slli	a5,a5,0x12
    80028e1a:	5798                	lw	a4,40(a5)
    80028e1c:	00476713          	ori	a4,a4,4
    80028e20:	d798                	sw	a4,40(a5)
    return 0;
    80028e22:	4501                	li	a0,0
    80028e24:	b769                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb0_clk_en = en;
    80028e26:	000fd7b7          	lui	a5,0xfd
    80028e2a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e2e:	07ca                	slli	a5,a5,0x12
    80028e30:	5798                	lw	a4,40(a5)
    80028e32:	00876713          	ori	a4,a4,8
    80028e36:	d798                	sw	a4,40(a5)
    return 0;
    80028e38:	4501                	li	a0,0
    80028e3a:	bf95                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb1_clk_en = en;
    80028e3c:	000fd7b7          	lui	a5,0xfd
    80028e40:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e44:	07ca                	slli	a5,a5,0x12
    80028e46:	5798                	lw	a4,40(a5)
    80028e48:	01076713          	ori	a4,a4,16
    80028e4c:	d798                	sw	a4,40(a5)
    return 0;
    80028e4e:	4501                	li	a0,0
    80028e50:	bfb9                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb2_clk_en = en;
    80028e52:	000fd7b7          	lui	a5,0xfd
    80028e56:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e5a:	07ca                	slli	a5,a5,0x12
    80028e5c:	5798                	lw	a4,40(a5)
    80028e5e:	02076713          	ori	a4,a4,32
    80028e62:	d798                	sw	a4,40(a5)
    return 0;
    80028e64:	4501                	li	a0,0
    80028e66:	b7a1                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.rom_clk_en = en;
    80028e68:	000fd7b7          	lui	a5,0xfd
    80028e6c:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e70:	07ca                	slli	a5,a5,0x12
    80028e72:	57d8                	lw	a4,44(a5)
    80028e74:	00176713          	ori	a4,a4,1
    80028e78:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e7a:	4501                	li	a0,0
    80028e7c:	bf0d                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.dma_clk_en = en;
    80028e7e:	000fd7b7          	lui	a5,0xfd
    80028e82:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e86:	07ca                	slli	a5,a5,0x12
    80028e88:	57d8                	lw	a4,44(a5)
    80028e8a:	00276713          	ori	a4,a4,2
    80028e8e:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e90:	4501                	li	a0,0
    80028e92:	bf31                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.ai_clk_en = en;
    80028e94:	000fd7b7          	lui	a5,0xfd
    80028e98:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028e9c:	07ca                	slli	a5,a5,0x12
    80028e9e:	57d8                	lw	a4,44(a5)
    80028ea0:	00476713          	ori	a4,a4,4
    80028ea4:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ea6:	4501                	li	a0,0
    80028ea8:	b719                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.dvp_clk_en = en;
    80028eaa:	000fd7b7          	lui	a5,0xfd
    80028eae:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028eb2:	07ca                	slli	a5,a5,0x12
    80028eb4:	57d8                	lw	a4,44(a5)
    80028eb6:	00876713          	ori	a4,a4,8
    80028eba:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ebc:	4501                	li	a0,0
    80028ebe:	bdc5                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.fft_clk_en = en;
    80028ec0:	000fd7b7          	lui	a5,0xfd
    80028ec4:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028ec8:	07ca                	slli	a5,a5,0x12
    80028eca:	57d8                	lw	a4,44(a5)
    80028ecc:	01076713          	ori	a4,a4,16
    80028ed0:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ed2:	4501                	li	a0,0
    80028ed4:	bde9                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi3_clk_en = en;
    80028ed6:	000fd7b7          	lui	a5,0xfd
    80028eda:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028ede:	07ca                	slli	a5,a5,0x12
    80028ee0:	57d8                	lw	a4,44(a5)
    80028ee2:	20076713          	ori	a4,a4,512
    80028ee6:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ee8:	4501                	li	a0,0
    80028eea:	b5d1                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.gpio_clk_en = en;
    80028eec:	000fd7b7          	lui	a5,0xfd
    80028ef0:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028ef4:	07ca                	slli	a5,a5,0x12
    80028ef6:	57d8                	lw	a4,44(a5)
    80028ef8:	02076713          	ori	a4,a4,32
    80028efc:	d7d8                	sw	a4,44(a5)
    return 0;
    80028efe:	4501                	li	a0,0
    80028f00:	b57d                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi2_clk_en = en;
    80028f02:	000fd7b7          	lui	a5,0xfd
    80028f06:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f0a:	07ca                	slli	a5,a5,0x12
    80028f0c:	57d8                	lw	a4,44(a5)
    80028f0e:	10076713          	ori	a4,a4,256
    80028f12:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f14:	4501                	li	a0,0
    80028f16:	bd61                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s0_clk_en = en;
    80028f18:	000fd7b7          	lui	a5,0xfd
    80028f1c:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f20:	07ca                	slli	a5,a5,0x12
    80028f22:	57d8                	lw	a4,44(a5)
    80028f24:	40076713          	ori	a4,a4,1024
    80028f28:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f2a:	4501                	li	a0,0
    80028f2c:	b549                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s1_clk_en = en;
    80028f2e:	000fd7b7          	lui	a5,0xfd
    80028f32:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f36:	07ca                	slli	a5,a5,0x12
    80028f38:	57d8                	lw	a4,44(a5)
    80028f3a:	6685                	lui	a3,0x1
    80028f3c:	80068693          	addi	a3,a3,-2048 # 800 <BASE_ADDRESS-0x8001f800>
    80028f40:	8f55                	or	a4,a4,a3
    80028f42:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f44:	4501                	li	a0,0
    80028f46:	b5a5                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s2_clk_en = en;
    80028f48:	000fd7b7          	lui	a5,0xfd
    80028f4c:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f50:	07ca                	slli	a5,a5,0x12
    80028f52:	57d8                	lw	a4,44(a5)
    80028f54:	6685                	lui	a3,0x1
    80028f56:	8f55                	or	a4,a4,a3
    80028f58:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f5a:	4501                	li	a0,0
    80028f5c:	bd89                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c0_clk_en = en;
    80028f5e:	000fd7b7          	lui	a5,0xfd
    80028f62:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f66:	07ca                	slli	a5,a5,0x12
    80028f68:	57d8                	lw	a4,44(a5)
    80028f6a:	6689                	lui	a3,0x2
    80028f6c:	8f55                	or	a4,a4,a3
    80028f6e:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f70:	4501                	li	a0,0
    80028f72:	bd35                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c1_clk_en = en;
    80028f74:	000fd7b7          	lui	a5,0xfd
    80028f78:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f7c:	07ca                	slli	a5,a5,0x12
    80028f7e:	57d8                	lw	a4,44(a5)
    80028f80:	6691                	lui	a3,0x4
    80028f82:	8f55                	or	a4,a4,a3
    80028f84:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f86:	4501                	li	a0,0
    80028f88:	b51d                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c2_clk_en = en;
    80028f8a:	000fd7b7          	lui	a5,0xfd
    80028f8e:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028f92:	07ca                	slli	a5,a5,0x12
    80028f94:	57d8                	lw	a4,44(a5)
    80028f96:	66a1                	lui	a3,0x8
    80028f98:	8f55                	or	a4,a4,a3
    80028f9a:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f9c:	4501                	li	a0,0
    80028f9e:	bd01                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart1_clk_en = en;
    80028fa0:	000fd7b7          	lui	a5,0xfd
    80028fa4:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fa8:	07ca                	slli	a5,a5,0x12
    80028faa:	57d8                	lw	a4,44(a5)
    80028fac:	66c1                	lui	a3,0x10
    80028fae:	8f55                	or	a4,a4,a3
    80028fb0:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fb2:	4501                	li	a0,0
    80028fb4:	bbed                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart2_clk_en = en;
    80028fb6:	000fd7b7          	lui	a5,0xfd
    80028fba:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fbe:	07ca                	slli	a5,a5,0x12
    80028fc0:	57d8                	lw	a4,44(a5)
    80028fc2:	000206b7          	lui	a3,0x20
    80028fc6:	8f55                	or	a4,a4,a3
    80028fc8:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fca:	4501                	li	a0,0
    80028fcc:	b3cd                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart3_clk_en = en;
    80028fce:	000fd7b7          	lui	a5,0xfd
    80028fd2:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fd6:	07ca                	slli	a5,a5,0x12
    80028fd8:	57d8                	lw	a4,44(a5)
    80028fda:	000406b7          	lui	a3,0x40
    80028fde:	8f55                	or	a4,a4,a3
    80028fe0:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fe2:	4501                	li	a0,0
    80028fe4:	b3e9                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.fpioa_clk_en = en;
    80028fe6:	000fd7b7          	lui	a5,0xfd
    80028fea:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80028fee:	07ca                	slli	a5,a5,0x12
    80028ff0:	57d8                	lw	a4,44(a5)
    80028ff2:	001006b7          	lui	a3,0x100
    80028ff6:	8f55                	or	a4,a4,a3
    80028ff8:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ffa:	4501                	li	a0,0
    80028ffc:	bb4d                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer0_clk_en = en;
    80028ffe:	000fd7b7          	lui	a5,0xfd
    80029002:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029006:	07ca                	slli	a5,a5,0x12
    80029008:	57d8                	lw	a4,44(a5)
    8002900a:	002006b7          	lui	a3,0x200
    8002900e:	8f55                	or	a4,a4,a3
    80029010:	d7d8                	sw	a4,44(a5)
    return 0;
    80029012:	4501                	li	a0,0
    80029014:	bb69                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer1_clk_en = en;
    80029016:	000fd7b7          	lui	a5,0xfd
    8002901a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002901e:	07ca                	slli	a5,a5,0x12
    80029020:	57d8                	lw	a4,44(a5)
    80029022:	004006b7          	lui	a3,0x400
    80029026:	8f55                	or	a4,a4,a3
    80029028:	d7d8                	sw	a4,44(a5)
    return 0;
    8002902a:	4501                	li	a0,0
    8002902c:	b349                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer2_clk_en = en;
    8002902e:	000fd7b7          	lui	a5,0xfd
    80029032:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029036:	07ca                	slli	a5,a5,0x12
    80029038:	57d8                	lw	a4,44(a5)
    8002903a:	008006b7          	lui	a3,0x800
    8002903e:	8f55                	or	a4,a4,a3
    80029040:	d7d8                	sw	a4,44(a5)
    return 0;
    80029042:	4501                	li	a0,0
    80029044:	b3ad                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.sha_clk_en = en;
    80029046:	000fd7b7          	lui	a5,0xfd
    8002904a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002904e:	07ca                	slli	a5,a5,0x12
    80029050:	57d8                	lw	a4,44(a5)
    80029052:	040006b7          	lui	a3,0x4000
    80029056:	8f55                	or	a4,a4,a3
    80029058:	d7d8                	sw	a4,44(a5)
    return 0;
    8002905a:	4501                	li	a0,0
    8002905c:	bb89                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.aes_clk_en = en;
    8002905e:	000fd7b7          	lui	a5,0xfd
    80029062:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029066:	07ca                	slli	a5,a5,0x12
    80029068:	57d8                	lw	a4,44(a5)
    8002906a:	000806b7          	lui	a3,0x80
    8002906e:	8f55                	or	a4,a4,a3
    80029070:	d7d8                	sw	a4,44(a5)
    return 0;
    80029072:	4501                	li	a0,0
    80029074:	bb2d                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.wdt0_clk_en = en;
    80029076:	000fd7b7          	lui	a5,0xfd
    8002907a:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    8002907e:	07ca                	slli	a5,a5,0x12
    80029080:	57d8                	lw	a4,44(a5)
    80029082:	010006b7          	lui	a3,0x1000
    80029086:	8f55                	or	a4,a4,a3
    80029088:	d7d8                	sw	a4,44(a5)
    return 0;
    8002908a:	4501                	li	a0,0
    8002908c:	b30d                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.wdt1_clk_en = en;
    8002908e:	000fd7b7          	lui	a5,0xfd
    80029092:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029096:	07ca                	slli	a5,a5,0x12
    80029098:	57d8                	lw	a4,44(a5)
    8002909a:	020006b7          	lui	a3,0x2000
    8002909e:	8f55                	or	a4,a4,a3
    800290a0:	d7d8                	sw	a4,44(a5)
    return 0;
    800290a2:	4501                	li	a0,0
    800290a4:	b329                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.otp_clk_en = en;
    800290a6:	000fd7b7          	lui	a5,0xfd
    800290aa:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290ae:	07ca                	slli	a5,a5,0x12
    800290b0:	57d8                	lw	a4,44(a5)
    800290b2:	080006b7          	lui	a3,0x8000
    800290b6:	8f55                	or	a4,a4,a3
    800290b8:	d7d8                	sw	a4,44(a5)
    return 0;
    800290ba:	4501                	li	a0,0
    800290bc:	b9cd                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.rtc_clk_en = en;
    800290be:	000fd7b7          	lui	a5,0xfd
    800290c2:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290c6:	07ca                	slli	a5,a5,0x12
    800290c8:	57d8                	lw	a4,44(a5)
    800290ca:	200006b7          	lui	a3,0x20000
    800290ce:	8f55                	or	a4,a4,a3
    800290d0:	d7d8                	sw	a4,44(a5)
    return 0;
    800290d2:	4501                	li	a0,0
    800290d4:	b9e9                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi0_clk_en = en;
    800290d6:	000fd7b7          	lui	a5,0xfd
    800290da:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290de:	07ca                	slli	a5,a5,0x12
    800290e0:	57d8                	lw	a4,44(a5)
    800290e2:	04076713          	ori	a4,a4,64
    800290e6:	d7d8                	sw	a4,44(a5)
    return 0;
    800290e8:	4501                	li	a0,0
    800290ea:	b1d1                	j	80028dae <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi1_clk_en = en;
    800290ec:	000fd7b7          	lui	a5,0xfd
    800290f0:	41178793          	addi	a5,a5,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800290f4:	07ca                	slli	a5,a5,0x12
    800290f6:	57d8                	lw	a4,44(a5)
    800290f8:	08076713          	ori	a4,a4,128
    800290fc:	d7d8                	sw	a4,44(a5)
    return 0;
    800290fe:	4501                	li	a0,0
    80029100:	b17d                	j	80028dae <sysctl_clock_enable+0x9c>
        return -1;
    80029102:	557d                	li	a0,-1
    80029104:	b16d                	j	80028dae <sysctl_clock_enable+0x9c>
    return 0;
    80029106:	4501                	li	a0,0
    80029108:	b15d                	j	80028dae <sysctl_clock_enable+0x9c>

000000008002910a <sysctl_dma_select>:

int sysctl_dma_select(sysctl_dma_channel_t channel, sysctl_dma_select_t select)
{
    8002910a:	1141                	addi	sp,sp,-16
    8002910c:	e422                	sd	s0,8(sp)
    8002910e:	0800                	addi	s0,sp,16
    sysctl_dma_sel0_t dma_sel0;
    sysctl_dma_sel1_t dma_sel1;

    /* Read register from bus */
    dma_sel0 = sysctl->dma_sel0;
    80029110:	000fd637          	lui	a2,0xfd
    80029114:	41160613          	addi	a2,a2,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    80029118:	064a                	slli	a2,a2,0x12
    8002911a:	5274                	lw	a3,100(a2)
    8002911c:	0186d81b          	srliw	a6,a3,0x18
    dma_sel1 = sysctl->dma_sel1;
    80029120:	5630                	lw	a2,104(a2)
    switch(channel)
    80029122:	4e95                	li	t4,5
    80029124:	0aaeee63          	bltu	t4,a0,800291e0 <sysctl_dma_select+0xd6>
    80029128:	03f6f793          	andi	a5,a3,63
    8002912c:	0066d71b          	srliw	a4,a3,0x6
    80029130:	03f77713          	andi	a4,a4,63
    80029134:	00c6d31b          	srliw	t1,a3,0xc
    80029138:	03f37313          	andi	t1,t1,63
    8002913c:	0126d89b          	srliw	a7,a3,0x12
    80029140:	03f8f893          	andi	a7,a7,63
    80029144:	03f87813          	andi	a6,a6,63
    80029148:	03f67e13          	andi	t3,a2,63
    8002914c:	050a                	slli	a0,a0,0x2
    8002914e:	00004e97          	auipc	t4,0x4
    80029152:	e8ae8e93          	addi	t4,t4,-374 # 8002cfd8 <function_config+0x770>
    80029156:	9576                	add	a0,a0,t4
    80029158:	4108                	lw	a0,0(a0)
    8002915a:	9576                	add	a0,a0,t4
    8002915c:	8502                	jr	a0
    {
        case SYSCTL_DMA_CHANNEL_0:
            dma_sel0.dma_sel0 = select;
    8002915e:	03f5f793          	andi	a5,a1,63
        default:
            return -1;
    }

    /* Write register back to bus */
    sysctl->dma_sel0 = dma_sel0;
    80029162:	fc06f693          	andi	a3,a3,-64
    80029166:	8edd                	or	a3,a3,a5
    80029168:	0067179b          	slliw	a5,a4,0x6
    8002916c:	777d                	lui	a4,0xfffff
    8002916e:	03f70713          	addi	a4,a4,63 # fffffffffffff03f <kernel_end+0xffffffff7ffb903f>
    80029172:	8f75                	and	a4,a4,a3
    80029174:	8f5d                	or	a4,a4,a5
    80029176:	00c3179b          	slliw	a5,t1,0xc
    8002917a:	fffc16b7          	lui	a3,0xfffc1
    8002917e:	16fd                	addi	a3,a3,-1
    80029180:	8f75                	and	a4,a4,a3
    80029182:	8f5d                	or	a4,a4,a5
    80029184:	0128989b          	slliw	a7,a7,0x12
    80029188:	ff0407b7          	lui	a5,0xff040
    8002918c:	17fd                	addi	a5,a5,-1
    8002918e:	8ff9                	and	a5,a5,a4
    80029190:	0117e7b3          	or	a5,a5,a7
    80029194:	0188181b          	slliw	a6,a6,0x18
    80029198:	c1000737          	lui	a4,0xc1000
    8002919c:	177d                	addi	a4,a4,-1
    8002919e:	8ff9                	and	a5,a5,a4
    800291a0:	0107e7b3          	or	a5,a5,a6
    800291a4:	000fd737          	lui	a4,0xfd
    800291a8:	41170713          	addi	a4,a4,1041 # fd411 <BASE_ADDRESS-0x7ff22bef>
    800291ac:	074a                	slli	a4,a4,0x12
    800291ae:	d37c                	sw	a5,100(a4)
    sysctl->dma_sel1 = dma_sel1;
    800291b0:	fc067613          	andi	a2,a2,-64
    800291b4:	00ce6633          	or	a2,t3,a2
    800291b8:	d730                	sw	a2,104(a4)

    return 0;
    800291ba:	4501                	li	a0,0
}
    800291bc:	6422                	ld	s0,8(sp)
    800291be:	0141                	addi	sp,sp,16
    800291c0:	8082                	ret
            dma_sel0.dma_sel1 = select;
    800291c2:	03f5f713          	andi	a4,a1,63
            break;
    800291c6:	bf71                	j	80029162 <sysctl_dma_select+0x58>
            dma_sel0.dma_sel2 = select;
    800291c8:	03f5f313          	andi	t1,a1,63
            break;
    800291cc:	bf59                	j	80029162 <sysctl_dma_select+0x58>
            dma_sel0.dma_sel3 = select;
    800291ce:	03f5f893          	andi	a7,a1,63
            break;
    800291d2:	bf41                	j	80029162 <sysctl_dma_select+0x58>
            dma_sel0.dma_sel4 = select;
    800291d4:	03f5f813          	andi	a6,a1,63
            break;
    800291d8:	b769                	j	80029162 <sysctl_dma_select+0x58>
            dma_sel1.dma_sel5 = select;
    800291da:	03f5fe13          	andi	t3,a1,63
            break;
    800291de:	b751                	j	80029162 <sysctl_dma_select+0x58>
            return -1;
    800291e0:	557d                	li	a0,-1
    800291e2:	bfe9                	j	800291bc <sysctl_dma_select+0xb2>
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
