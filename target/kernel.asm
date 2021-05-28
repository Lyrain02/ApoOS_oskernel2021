
target/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080020000 <_start>:
    80020000:	00150293          	addi	t0,a0,1
    80020004:	02ba                	slli	t0,t0,0xe
    80020006:	0000e117          	auipc	sp,0xe
    8002000a:	4f213103          	ld	sp,1266(sp) # 8002e4f8 <_GLOBAL_OFFSET_TABLE_+0x50>
    8002000e:	9116                	add	sp,sp,t0
    80020010:	1b9000ef          	jal	ra,800209c8 <main>

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
    80020024:	08054563          	bltz	a0,800200ae <printint+0x98>
    x = -xx;
  else
    x = xx;
    80020028:	2501                	sext.w	a0,a0
    8002002a:	4881                	li	a7,0

  i = 0;
    8002002c:	fd040913          	addi	s2,s0,-48
    x = xx;
    80020030:	86ca                	mv	a3,s2
  i = 0;
    80020032:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80020034:	2581                	sext.w	a1,a1
    80020036:	0000b617          	auipc	a2,0xb
    8002003a:	25260613          	addi	a2,a2,594 # 8002b288 <digits>
    8002003e:	883a                	mv	a6,a4
    80020040:	2705                	addiw	a4,a4,1
    80020042:	02b577bb          	remuw	a5,a0,a1
    80020046:	1782                	slli	a5,a5,0x20
    80020048:	9381                	srli	a5,a5,0x20
    8002004a:	97b2                	add	a5,a5,a2
    8002004c:	0007c783          	lbu	a5,0(a5)
    80020050:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80020054:	0005079b          	sext.w	a5,a0
    80020058:	02b5553b          	divuw	a0,a0,a1
    8002005c:	0685                	addi	a3,a3,1
    8002005e:	feb7f0e3          	bgeu	a5,a1,8002003e <printint+0x28>

  if(sign)
    80020062:	00088b63          	beqz	a7,80020078 <printint+0x62>
    buf[i++] = '-';
    80020066:	fe040793          	addi	a5,s0,-32
    8002006a:	973e                	add	a4,a4,a5
    8002006c:	02d00793          	li	a5,45
    80020070:	fef70823          	sb	a5,-16(a4)
    80020074:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80020078:	02e05563          	blez	a4,800200a2 <printint+0x8c>
    8002007c:	fd040493          	addi	s1,s0,-48
    80020080:	94ba                	add	s1,s1,a4
    80020082:	197d                	addi	s2,s2,-1
    80020084:	993a                	add	s2,s2,a4
    80020086:	377d                	addiw	a4,a4,-1
    80020088:	1702                	slli	a4,a4,0x20
    8002008a:	9301                	srli	a4,a4,0x20
    8002008c:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80020090:	fff4c503          	lbu	a0,-1(s1)
    80020094:	00007097          	auipc	ra,0x7
    80020098:	b76080e7          	jalr	-1162(ra) # 80026c0a <consputc>
  while(--i >= 0)
    8002009c:	14fd                	addi	s1,s1,-1
    8002009e:	ff2499e3          	bne	s1,s2,80020090 <printint+0x7a>
}
    800200a2:	70a2                	ld	ra,40(sp)
    800200a4:	7402                	ld	s0,32(sp)
    800200a6:	64e2                	ld	s1,24(sp)
    800200a8:	6942                	ld	s2,16(sp)
    800200aa:	6145                	addi	sp,sp,48
    800200ac:	8082                	ret
    x = -xx;
    800200ae:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    800200b2:	4885                	li	a7,1
    x = -xx;
    800200b4:	bfa5                	j	8002002c <printint+0x16>

00000000800200b6 <printstring>:
void printstring(const char* s) {
    800200b6:	1101                	addi	sp,sp,-32
    800200b8:	ec06                	sd	ra,24(sp)
    800200ba:	e822                	sd	s0,16(sp)
    800200bc:	e426                	sd	s1,8(sp)
    800200be:	1000                	addi	s0,sp,32
    800200c0:	84aa                	mv	s1,a0
    while (*s)
    800200c2:	00054503          	lbu	a0,0(a0)
    800200c6:	c909                	beqz	a0,800200d8 <printstring+0x22>
        consputc(*s++);
    800200c8:	0485                	addi	s1,s1,1
    800200ca:	00007097          	auipc	ra,0x7
    800200ce:	b40080e7          	jalr	-1216(ra) # 80026c0a <consputc>
    while (*s)
    800200d2:	0004c503          	lbu	a0,0(s1)
    800200d6:	f96d                	bnez	a0,800200c8 <printstring+0x12>
}
    800200d8:	60e2                	ld	ra,24(sp)
    800200da:	6442                	ld	s0,16(sp)
    800200dc:	64a2                	ld	s1,8(sp)
    800200de:	6105                	addi	sp,sp,32
    800200e0:	8082                	ret

00000000800200e2 <backtrace>:
  for(;;)
    ;
}

void backtrace()
{
    800200e2:	7179                	addi	sp,sp,-48
    800200e4:	f406                	sd	ra,40(sp)
    800200e6:	f022                	sd	s0,32(sp)
    800200e8:	ec26                	sd	s1,24(sp)
    800200ea:	e84a                	sd	s2,16(sp)
    800200ec:	e44e                	sd	s3,8(sp)
    800200ee:	1800                	addi	s0,sp,48

static inline uint64
r_fp()
{
  uint64 x;
  asm volatile("mv %0, s0" : "=r" (x) );
    800200f0:	8922                	mv	s2,s0
  uint64 *fp = (uint64 *)r_fp();
    800200f2:	84ca                	mv	s1,s2
  uint64 *bottom = (uint64 *)PGROUNDUP((uint64)fp);
    800200f4:	6785                	lui	a5,0x1
    800200f6:	17fd                	addi	a5,a5,-1
    800200f8:	993e                	add	s2,s2,a5
    800200fa:	77fd                	lui	a5,0xfffff
    800200fc:	00f97933          	and	s2,s2,a5
  printf("backtrace:\n");
    80020100:	0000b517          	auipc	a0,0xb
    80020104:	f0050513          	addi	a0,a0,-256 # 8002b000 <etext>
    80020108:	00000097          	auipc	ra,0x0
    8002010c:	084080e7          	jalr	132(ra) # 8002018c <printf>
  while (fp < bottom) {
    80020110:	0324f263          	bgeu	s1,s2,80020134 <backtrace+0x52>
    uint64 ra = *(fp - 1);
    printf("%p\n", ra - 4);
    80020114:	0000b997          	auipc	s3,0xb
    80020118:	3dc98993          	addi	s3,s3,988 # 8002b4f0 <digits+0x268>
    8002011c:	ff84b583          	ld	a1,-8(s1)
    80020120:	15f1                	addi	a1,a1,-4
    80020122:	854e                	mv	a0,s3
    80020124:	00000097          	auipc	ra,0x0
    80020128:	068080e7          	jalr	104(ra) # 8002018c <printf>
    fp = (uint64 *)*(fp - 2);
    8002012c:	ff04b483          	ld	s1,-16(s1)
  while (fp < bottom) {
    80020130:	ff24e6e3          	bltu	s1,s2,8002011c <backtrace+0x3a>
  }
}
    80020134:	70a2                	ld	ra,40(sp)
    80020136:	7402                	ld	s0,32(sp)
    80020138:	64e2                	ld	s1,24(sp)
    8002013a:	6942                	ld	s2,16(sp)
    8002013c:	69a2                	ld	s3,8(sp)
    8002013e:	6145                	addi	sp,sp,48
    80020140:	8082                	ret

0000000080020142 <panic>:
{
    80020142:	1101                	addi	sp,sp,-32
    80020144:	ec06                	sd	ra,24(sp)
    80020146:	e822                	sd	s0,16(sp)
    80020148:	e426                	sd	s1,8(sp)
    8002014a:	1000                	addi	s0,sp,32
    8002014c:	84aa                	mv	s1,a0
  printf("panic: ");
    8002014e:	0000b517          	auipc	a0,0xb
    80020152:	ec250513          	addi	a0,a0,-318 # 8002b010 <etext+0x10>
    80020156:	00000097          	auipc	ra,0x0
    8002015a:	036080e7          	jalr	54(ra) # 8002018c <printf>
  printf(s);
    8002015e:	8526                	mv	a0,s1
    80020160:	00000097          	auipc	ra,0x0
    80020164:	02c080e7          	jalr	44(ra) # 8002018c <printf>
  printf("\n");
    80020168:	0000b517          	auipc	a0,0xb
    8002016c:	73050513          	addi	a0,a0,1840 # 8002b898 <digits+0x610>
    80020170:	00000097          	auipc	ra,0x0
    80020174:	01c080e7          	jalr	28(ra) # 8002018c <printf>
  backtrace();
    80020178:	00000097          	auipc	ra,0x0
    8002017c:	f6a080e7          	jalr	-150(ra) # 800200e2 <backtrace>
  panicked = 1; // freeze uart output from other CPUs
    80020180:	4785                	li	a5,1
    80020182:	00017717          	auipc	a4,0x17
    80020186:	e6f72f23          	sw	a5,-386(a4) # 80037000 <panicked>
  for(;;)
    8002018a:	a001                	j	8002018a <panic+0x48>

000000008002018c <printf>:
{
    8002018c:	7131                	addi	sp,sp,-192
    8002018e:	fc86                	sd	ra,120(sp)
    80020190:	f8a2                	sd	s0,112(sp)
    80020192:	f4a6                	sd	s1,104(sp)
    80020194:	f0ca                	sd	s2,96(sp)
    80020196:	ecce                	sd	s3,88(sp)
    80020198:	e8d2                	sd	s4,80(sp)
    8002019a:	e4d6                	sd	s5,72(sp)
    8002019c:	e0da                	sd	s6,64(sp)
    8002019e:	fc5e                	sd	s7,56(sp)
    800201a0:	f862                	sd	s8,48(sp)
    800201a2:	f466                	sd	s9,40(sp)
    800201a4:	f06a                	sd	s10,32(sp)
    800201a6:	ec6e                	sd	s11,24(sp)
    800201a8:	0100                	addi	s0,sp,128
    800201aa:	8a2a                	mv	s4,a0
    800201ac:	e40c                	sd	a1,8(s0)
    800201ae:	e810                	sd	a2,16(s0)
    800201b0:	ec14                	sd	a3,24(s0)
    800201b2:	f018                	sd	a4,32(s0)
    800201b4:	f41c                	sd	a5,40(s0)
    800201b6:	03043823          	sd	a6,48(s0)
    800201ba:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800201be:	00017d97          	auipc	s11,0x17
    800201c2:	e62dad83          	lw	s11,-414(s11) # 80037020 <pr+0x18>
  if(locking)
    800201c6:	020d9b63          	bnez	s11,800201fc <printf+0x70>
  if (fmt == 0)
    800201ca:	040a0263          	beqz	s4,8002020e <printf+0x82>
  va_start(ap, fmt);
    800201ce:	00840793          	addi	a5,s0,8
    800201d2:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800201d6:	000a4503          	lbu	a0,0(s4)
    800201da:	14050f63          	beqz	a0,80020338 <printf+0x1ac>
    800201de:	4981                	li	s3,0
    if(c != '%'){
    800201e0:	02500a93          	li	s5,37
    switch(c){
    800201e4:	07000b93          	li	s7,112
  consputc('x');
    800201e8:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800201ea:	0000bb17          	auipc	s6,0xb
    800201ee:	09eb0b13          	addi	s6,s6,158 # 8002b288 <digits>
    switch(c){
    800201f2:	07300c93          	li	s9,115
    800201f6:	06400c13          	li	s8,100
    800201fa:	a82d                	j	80020234 <printf+0xa8>
    acquire(&pr.lock);
    800201fc:	00017517          	auipc	a0,0x17
    80020200:	e0c50513          	addi	a0,a0,-500 # 80037008 <pr>
    80020204:	00000097          	auipc	ra,0x0
    80020208:	4ae080e7          	jalr	1198(ra) # 800206b2 <acquire>
    8002020c:	bf7d                	j	800201ca <printf+0x3e>
    panic("null fmt");
    8002020e:	0000b517          	auipc	a0,0xb
    80020212:	e1250513          	addi	a0,a0,-494 # 8002b020 <etext+0x20>
    80020216:	00000097          	auipc	ra,0x0
    8002021a:	f2c080e7          	jalr	-212(ra) # 80020142 <panic>
      consputc(c);
    8002021e:	00007097          	auipc	ra,0x7
    80020222:	9ec080e7          	jalr	-1556(ra) # 80026c0a <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80020226:	2985                	addiw	s3,s3,1
    80020228:	013a07b3          	add	a5,s4,s3
    8002022c:	0007c503          	lbu	a0,0(a5) # fffffffffffff000 <kernel_end+0xffffffff7ffb9000>
    80020230:	10050463          	beqz	a0,80020338 <printf+0x1ac>
    if(c != '%'){
    80020234:	ff5515e3          	bne	a0,s5,8002021e <printf+0x92>
    c = fmt[++i] & 0xff;
    80020238:	2985                	addiw	s3,s3,1
    8002023a:	013a07b3          	add	a5,s4,s3
    8002023e:	0007c783          	lbu	a5,0(a5)
    80020242:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80020246:	cbed                	beqz	a5,80020338 <printf+0x1ac>
    switch(c){
    80020248:	05778a63          	beq	a5,s7,8002029c <printf+0x110>
    8002024c:	02fbf663          	bgeu	s7,a5,80020278 <printf+0xec>
    80020250:	09978863          	beq	a5,s9,800202e0 <printf+0x154>
    80020254:	07800713          	li	a4,120
    80020258:	0ce79563          	bne	a5,a4,80020322 <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    8002025c:	f8843783          	ld	a5,-120(s0)
    80020260:	00878713          	addi	a4,a5,8
    80020264:	f8e43423          	sd	a4,-120(s0)
    80020268:	4605                	li	a2,1
    8002026a:	85ea                	mv	a1,s10
    8002026c:	4388                	lw	a0,0(a5)
    8002026e:	00000097          	auipc	ra,0x0
    80020272:	da8080e7          	jalr	-600(ra) # 80020016 <printint>
      break;
    80020276:	bf45                	j	80020226 <printf+0x9a>
    switch(c){
    80020278:	09578f63          	beq	a5,s5,80020316 <printf+0x18a>
    8002027c:	0b879363          	bne	a5,s8,80020322 <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    80020280:	f8843783          	ld	a5,-120(s0)
    80020284:	00878713          	addi	a4,a5,8
    80020288:	f8e43423          	sd	a4,-120(s0)
    8002028c:	4605                	li	a2,1
    8002028e:	45a9                	li	a1,10
    80020290:	4388                	lw	a0,0(a5)
    80020292:	00000097          	auipc	ra,0x0
    80020296:	d84080e7          	jalr	-636(ra) # 80020016 <printint>
      break;
    8002029a:	b771                	j	80020226 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    8002029c:	f8843783          	ld	a5,-120(s0)
    800202a0:	00878713          	addi	a4,a5,8
    800202a4:	f8e43423          	sd	a4,-120(s0)
    800202a8:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800202ac:	03000513          	li	a0,48
    800202b0:	00007097          	auipc	ra,0x7
    800202b4:	95a080e7          	jalr	-1702(ra) # 80026c0a <consputc>
  consputc('x');
    800202b8:	07800513          	li	a0,120
    800202bc:	00007097          	auipc	ra,0x7
    800202c0:	94e080e7          	jalr	-1714(ra) # 80026c0a <consputc>
    800202c4:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800202c6:	03c95793          	srli	a5,s2,0x3c
    800202ca:	97da                	add	a5,a5,s6
    800202cc:	0007c503          	lbu	a0,0(a5)
    800202d0:	00007097          	auipc	ra,0x7
    800202d4:	93a080e7          	jalr	-1734(ra) # 80026c0a <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800202d8:	0912                	slli	s2,s2,0x4
    800202da:	34fd                	addiw	s1,s1,-1
    800202dc:	f4ed                	bnez	s1,800202c6 <printf+0x13a>
    800202de:	b7a1                	j	80020226 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800202e0:	f8843783          	ld	a5,-120(s0)
    800202e4:	00878713          	addi	a4,a5,8
    800202e8:	f8e43423          	sd	a4,-120(s0)
    800202ec:	6384                	ld	s1,0(a5)
    800202ee:	cc89                	beqz	s1,80020308 <printf+0x17c>
      for(; *s; s++)
    800202f0:	0004c503          	lbu	a0,0(s1)
    800202f4:	d90d                	beqz	a0,80020226 <printf+0x9a>
        consputc(*s);
    800202f6:	00007097          	auipc	ra,0x7
    800202fa:	914080e7          	jalr	-1772(ra) # 80026c0a <consputc>
      for(; *s; s++)
    800202fe:	0485                	addi	s1,s1,1
    80020300:	0004c503          	lbu	a0,0(s1)
    80020304:	f96d                	bnez	a0,800202f6 <printf+0x16a>
    80020306:	b705                	j	80020226 <printf+0x9a>
        s = "(null)";
    80020308:	0000b497          	auipc	s1,0xb
    8002030c:	d1048493          	addi	s1,s1,-752 # 8002b018 <etext+0x18>
      for(; *s; s++)
    80020310:	02800513          	li	a0,40
    80020314:	b7cd                	j	800202f6 <printf+0x16a>
      consputc('%');
    80020316:	8556                	mv	a0,s5
    80020318:	00007097          	auipc	ra,0x7
    8002031c:	8f2080e7          	jalr	-1806(ra) # 80026c0a <consputc>
      break;
    80020320:	b719                	j	80020226 <printf+0x9a>
      consputc('%');
    80020322:	8556                	mv	a0,s5
    80020324:	00007097          	auipc	ra,0x7
    80020328:	8e6080e7          	jalr	-1818(ra) # 80026c0a <consputc>
      consputc(c);
    8002032c:	8526                	mv	a0,s1
    8002032e:	00007097          	auipc	ra,0x7
    80020332:	8dc080e7          	jalr	-1828(ra) # 80026c0a <consputc>
      break;
    80020336:	bdc5                	j	80020226 <printf+0x9a>
  if(locking)
    80020338:	020d9163          	bnez	s11,8002035a <printf+0x1ce>
}
    8002033c:	70e6                	ld	ra,120(sp)
    8002033e:	7446                	ld	s0,112(sp)
    80020340:	74a6                	ld	s1,104(sp)
    80020342:	7906                	ld	s2,96(sp)
    80020344:	69e6                	ld	s3,88(sp)
    80020346:	6a46                	ld	s4,80(sp)
    80020348:	6aa6                	ld	s5,72(sp)
    8002034a:	6b06                	ld	s6,64(sp)
    8002034c:	7be2                	ld	s7,56(sp)
    8002034e:	7c42                	ld	s8,48(sp)
    80020350:	7ca2                	ld	s9,40(sp)
    80020352:	7d02                	ld	s10,32(sp)
    80020354:	6de2                	ld	s11,24(sp)
    80020356:	6129                	addi	sp,sp,192
    80020358:	8082                	ret
    release(&pr.lock);
    8002035a:	00017517          	auipc	a0,0x17
    8002035e:	cae50513          	addi	a0,a0,-850 # 80037008 <pr>
    80020362:	00000097          	auipc	ra,0x0
    80020366:	3a4080e7          	jalr	932(ra) # 80020706 <release>
}
    8002036a:	bfc9                	j	8002033c <printf+0x1b0>

000000008002036c <printfinit>:

void
printfinit(void)
{
    8002036c:	1141                	addi	sp,sp,-16
    8002036e:	e406                	sd	ra,8(sp)
    80020370:	e022                	sd	s0,0(sp)
    80020372:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80020374:	0000b597          	auipc	a1,0xb
    80020378:	cbc58593          	addi	a1,a1,-836 # 8002b030 <etext+0x30>
    8002037c:	00017517          	auipc	a0,0x17
    80020380:	c8c50513          	addi	a0,a0,-884 # 80037008 <pr>
    80020384:	00000097          	auipc	ra,0x0
    80020388:	2ea080e7          	jalr	746(ra) # 8002066e <initlock>
  pr.locking = 1;   // changed, used to be 1
    8002038c:	4785                	li	a5,1
    8002038e:	00017717          	auipc	a4,0x17
    80020392:	c8f72923          	sw	a5,-878(a4) # 80037020 <pr+0x18>
}
    80020396:	60a2                	ld	ra,8(sp)
    80020398:	6402                	ld	s0,0(sp)
    8002039a:	0141                	addi	sp,sp,16
    8002039c:	8082                	ret

000000008002039e <print_logo>:
    printf("  .'    \\_)    \\     /__)' \\  |  |  '------'   |  | |  |   |  .--'   |  |   |  |  |  | | `-' /\n");
    printf(" /  .'.  \\      \\   /    \\  `'  /              '  '-'  '-. |  `---.  |  |   |  | ('  '-'(_.-'\n");
    printf("'--'   '--'      `-'      `----'                `-----'--' `------'  `--'   `--'   `-----'\n");
}
#else
void print_logo() {
    8002039e:	1141                	addi	sp,sp,-16
    800203a0:	e406                	sd	ra,8(sp)
    800203a2:	e022                	sd	s0,0(sp)
    800203a4:	0800                	addi	s0,sp,16
    printf(" (`-')           (`-')                   <-.(`-')\n");
    800203a6:	0000b517          	auipc	a0,0xb
    800203aa:	c9250513          	addi	a0,a0,-878 # 8002b038 <etext+0x38>
    800203ae:	00000097          	auipc	ra,0x0
    800203b2:	dde080e7          	jalr	-546(ra) # 8002018c <printf>
    printf(" (OO )_.->      _(OO )                    __( OO)\n");
    800203b6:	0000b517          	auipc	a0,0xb
    800203ba:	cba50513          	addi	a0,a0,-838 # 8002b070 <etext+0x70>
    800203be:	00000097          	auipc	ra,0x0
    800203c2:	dce080e7          	jalr	-562(ra) # 8002018c <printf>
    printf(" (_| \\_)--.,--.(_/,-.\\  ,--.    (`-')    '-'. ,--.  .----.   .--.   .----.\n");
    800203c6:	0000b517          	auipc	a0,0xb
    800203ca:	ce250513          	addi	a0,a0,-798 # 8002b0a8 <etext+0xa8>
    800203ce:	00000097          	auipc	ra,0x0
    800203d2:	dbe080e7          	jalr	-578(ra) # 8002018c <printf>
    printf(" \\  `.'  / \\   \\ / (_/ /  .'    ( OO).-> |  .'   / \\_,-.  | /_  |  /  ..  \\\n");
    800203d6:	0000b517          	auipc	a0,0xb
    800203da:	d2250513          	addi	a0,a0,-734 # 8002b0f8 <etext+0xf8>
    800203de:	00000097          	auipc	ra,0x0
    800203e2:	dae080e7          	jalr	-594(ra) # 8002018c <printf>
    printf("  \\    .')  \\   /   / .  / -.  (,------. |      /)    .' .'  |  | |  /  \\  .\n");
    800203e6:	0000b517          	auipc	a0,0xb
    800203ea:	d6250513          	addi	a0,a0,-670 # 8002b148 <etext+0x148>
    800203ee:	00000097          	auipc	ra,0x0
    800203f2:	d9e080e7          	jalr	-610(ra) # 8002018c <printf>
    printf("  .'    \\  _ \\     /_)'  .-. \\  `------' |  .   '   .'  /_   |  | '  \\  /  '\n");
    800203f6:	0000b517          	auipc	a0,0xb
    800203fa:	da250513          	addi	a0,a0,-606 # 8002b198 <etext+0x198>
    800203fe:	00000097          	auipc	ra,0x0
    80020402:	d8e080e7          	jalr	-626(ra) # 8002018c <printf>
    printf(" /  .'.  \\ \\-'\\   /   \\  `-' /           |  |\\   \\ |      |  |  |  \\  `'  /\n");
    80020406:	0000b517          	auipc	a0,0xb
    8002040a:	de250513          	addi	a0,a0,-542 # 8002b1e8 <etext+0x1e8>
    8002040e:	00000097          	auipc	ra,0x0
    80020412:	d7e080e7          	jalr	-642(ra) # 8002018c <printf>
    printf("`--'   '--'    `-'     `----'            `--' '--' `------'  `--'   `---''\n");
    80020416:	0000b517          	auipc	a0,0xb
    8002041a:	e2250513          	addi	a0,a0,-478 # 8002b238 <etext+0x238>
    8002041e:	00000097          	auipc	ra,0x0
    80020422:	d6e080e7          	jalr	-658(ra) # 8002018c <printf>
}
    80020426:	60a2                	ld	ra,8(sp)
    80020428:	6402                	ld	s0,0(sp)
    8002042a:	0141                	addi	sp,sp,16
    8002042c:	8082                	ret

000000008002042e <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8002042e:	1101                	addi	sp,sp,-32
    80020430:	ec06                	sd	ra,24(sp)
    80020432:	e822                	sd	s0,16(sp)
    80020434:	e426                	sd	s1,8(sp)
    80020436:	e04a                	sd	s2,0(sp)
    80020438:	1000                	addi	s0,sp,32
  struct run *r;
  
  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < kernel_end || (uint64)pa >= PHYSTOP)
    8002043a:	03451793          	slli	a5,a0,0x34
    8002043e:	e3ad                	bnez	a5,800204a0 <kfree+0x72>
    80020440:	84aa                	mv	s1,a0
    80020442:	0000e797          	auipc	a5,0xe
    80020446:	08e7b783          	ld	a5,142(a5) # 8002e4d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    8002044a:	04f56b63          	bltu	a0,a5,800204a0 <kfree+0x72>
    8002044e:	40300793          	li	a5,1027
    80020452:	07d6                	slli	a5,a5,0x15
    80020454:	04f57663          	bgeu	a0,a5,800204a0 <kfree+0x72>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80020458:	6605                	lui	a2,0x1
    8002045a:	4585                	li	a1,1
    8002045c:	00000097          	auipc	ra,0x0
    80020460:	2f2080e7          	jalr	754(ra) # 8002074e <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80020464:	00017917          	auipc	s2,0x17
    80020468:	bc490913          	addi	s2,s2,-1084 # 80037028 <kmem>
    8002046c:	854a                	mv	a0,s2
    8002046e:	00000097          	auipc	ra,0x0
    80020472:	244080e7          	jalr	580(ra) # 800206b2 <acquire>
  r->next = kmem.freelist;
    80020476:	01893783          	ld	a5,24(s2)
    8002047a:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    8002047c:	00993c23          	sd	s1,24(s2)
  kmem.npage++;
    80020480:	02093783          	ld	a5,32(s2)
    80020484:	0785                	addi	a5,a5,1
    80020486:	02f93023          	sd	a5,32(s2)
  release(&kmem.lock);
    8002048a:	854a                	mv	a0,s2
    8002048c:	00000097          	auipc	ra,0x0
    80020490:	27a080e7          	jalr	634(ra) # 80020706 <release>
}
    80020494:	60e2                	ld	ra,24(sp)
    80020496:	6442                	ld	s0,16(sp)
    80020498:	64a2                	ld	s1,8(sp)
    8002049a:	6902                	ld	s2,0(sp)
    8002049c:	6105                	addi	sp,sp,32
    8002049e:	8082                	ret
    panic("kfree");
    800204a0:	0000b517          	auipc	a0,0xb
    800204a4:	e0050513          	addi	a0,a0,-512 # 8002b2a0 <digits+0x18>
    800204a8:	00000097          	auipc	ra,0x0
    800204ac:	c9a080e7          	jalr	-870(ra) # 80020142 <panic>

00000000800204b0 <freerange>:
{
    800204b0:	7179                	addi	sp,sp,-48
    800204b2:	f406                	sd	ra,40(sp)
    800204b4:	f022                	sd	s0,32(sp)
    800204b6:	ec26                	sd	s1,24(sp)
    800204b8:	e84a                	sd	s2,16(sp)
    800204ba:	e44e                	sd	s3,8(sp)
    800204bc:	e052                	sd	s4,0(sp)
    800204be:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800204c0:	6785                	lui	a5,0x1
    800204c2:	fff78493          	addi	s1,a5,-1 # fff <_start-0x8001f001>
    800204c6:	94aa                	add	s1,s1,a0
    800204c8:	757d                	lui	a0,0xfffff
    800204ca:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800204cc:	94be                	add	s1,s1,a5
    800204ce:	0095ee63          	bltu	a1,s1,800204ea <freerange+0x3a>
    800204d2:	892e                	mv	s2,a1
    kfree(p);
    800204d4:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800204d6:	6985                	lui	s3,0x1
    kfree(p);
    800204d8:	01448533          	add	a0,s1,s4
    800204dc:	00000097          	auipc	ra,0x0
    800204e0:	f52080e7          	jalr	-174(ra) # 8002042e <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800204e4:	94ce                	add	s1,s1,s3
    800204e6:	fe9979e3          	bgeu	s2,s1,800204d8 <freerange+0x28>
}
    800204ea:	70a2                	ld	ra,40(sp)
    800204ec:	7402                	ld	s0,32(sp)
    800204ee:	64e2                	ld	s1,24(sp)
    800204f0:	6942                	ld	s2,16(sp)
    800204f2:	69a2                	ld	s3,8(sp)
    800204f4:	6a02                	ld	s4,0(sp)
    800204f6:	6145                	addi	sp,sp,48
    800204f8:	8082                	ret

00000000800204fa <kinit>:
{
    800204fa:	1101                	addi	sp,sp,-32
    800204fc:	ec06                	sd	ra,24(sp)
    800204fe:	e822                	sd	s0,16(sp)
    80020500:	e426                	sd	s1,8(sp)
    80020502:	1000                	addi	s0,sp,32
  initlock(&kmem.lock, "kmem");
    80020504:	00017497          	auipc	s1,0x17
    80020508:	b2448493          	addi	s1,s1,-1244 # 80037028 <kmem>
    8002050c:	0000b597          	auipc	a1,0xb
    80020510:	d9c58593          	addi	a1,a1,-612 # 8002b2a8 <digits+0x20>
    80020514:	8526                	mv	a0,s1
    80020516:	00000097          	auipc	ra,0x0
    8002051a:	158080e7          	jalr	344(ra) # 8002066e <initlock>
  kmem.freelist = 0;
    8002051e:	0004bc23          	sd	zero,24(s1)
  kmem.npage = 0;
    80020522:	0204b023          	sd	zero,32(s1)
  freerange(kernel_end, (void*)PHYSTOP);
    80020526:	40300593          	li	a1,1027
    8002052a:	05d6                	slli	a1,a1,0x15
    8002052c:	0000e517          	auipc	a0,0xe
    80020530:	fa453503          	ld	a0,-92(a0) # 8002e4d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80020534:	00000097          	auipc	ra,0x0
    80020538:	f7c080e7          	jalr	-132(ra) # 800204b0 <freerange>
}
    8002053c:	60e2                	ld	ra,24(sp)
    8002053e:	6442                	ld	s0,16(sp)
    80020540:	64a2                	ld	s1,8(sp)
    80020542:	6105                	addi	sp,sp,32
    80020544:	8082                	ret

0000000080020546 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80020546:	1101                	addi	sp,sp,-32
    80020548:	ec06                	sd	ra,24(sp)
    8002054a:	e822                	sd	s0,16(sp)
    8002054c:	e426                	sd	s1,8(sp)
    8002054e:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80020550:	00017497          	auipc	s1,0x17
    80020554:	ad848493          	addi	s1,s1,-1320 # 80037028 <kmem>
    80020558:	8526                	mv	a0,s1
    8002055a:	00000097          	auipc	ra,0x0
    8002055e:	158080e7          	jalr	344(ra) # 800206b2 <acquire>
  r = kmem.freelist;
    80020562:	6c84                	ld	s1,24(s1)
  if(r) {
    80020564:	c89d                	beqz	s1,8002059a <kalloc+0x54>
    kmem.freelist = r->next;
    80020566:	609c                	ld	a5,0(s1)
    80020568:	00017517          	auipc	a0,0x17
    8002056c:	ac050513          	addi	a0,a0,-1344 # 80037028 <kmem>
    80020570:	ed1c                	sd	a5,24(a0)
    kmem.npage--;
    80020572:	711c                	ld	a5,32(a0)
    80020574:	17fd                	addi	a5,a5,-1
    80020576:	f11c                	sd	a5,32(a0)
  }
  release(&kmem.lock);
    80020578:	00000097          	auipc	ra,0x0
    8002057c:	18e080e7          	jalr	398(ra) # 80020706 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80020580:	6605                	lui	a2,0x1
    80020582:	4595                	li	a1,5
    80020584:	8526                	mv	a0,s1
    80020586:	00000097          	auipc	ra,0x0
    8002058a:	1c8080e7          	jalr	456(ra) # 8002074e <memset>
  return (void*)r;
}
    8002058e:	8526                	mv	a0,s1
    80020590:	60e2                	ld	ra,24(sp)
    80020592:	6442                	ld	s0,16(sp)
    80020594:	64a2                	ld	s1,8(sp)
    80020596:	6105                	addi	sp,sp,32
    80020598:	8082                	ret
  release(&kmem.lock);
    8002059a:	00017517          	auipc	a0,0x17
    8002059e:	a8e50513          	addi	a0,a0,-1394 # 80037028 <kmem>
    800205a2:	00000097          	auipc	ra,0x0
    800205a6:	164080e7          	jalr	356(ra) # 80020706 <release>
  if(r)
    800205aa:	b7d5                	j	8002058e <kalloc+0x48>

00000000800205ac <freemem_amount>:

uint64
freemem_amount(void)
{
    800205ac:	1141                	addi	sp,sp,-16
    800205ae:	e422                	sd	s0,8(sp)
    800205b0:	0800                	addi	s0,sp,16
  return kmem.npage << PGSHIFT;
}
    800205b2:	00017517          	auipc	a0,0x17
    800205b6:	a9653503          	ld	a0,-1386(a0) # 80037048 <kmem+0x20>
    800205ba:	0532                	slli	a0,a0,0xc
    800205bc:	6422                	ld	s0,8(sp)
    800205be:	0141                	addi	sp,sp,16
    800205c0:	8082                	ret

00000000800205c2 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800205c2:	1101                	addi	sp,sp,-32
    800205c4:	ec06                	sd	ra,24(sp)
    800205c6:	e822                	sd	s0,16(sp)
    800205c8:	e426                	sd	s1,8(sp)
    800205ca:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800205cc:	100024f3          	csrr	s1,sstatus
    800205d0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800205d4:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800205d6:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  //printf("\e[32mpush_off()\e[0m: cpuid(): %d\n", cpuid());
  if(mycpu()->noff == 0)
    800205da:	00001097          	auipc	ra,0x1
    800205de:	4dc080e7          	jalr	1244(ra) # 80021ab6 <mycpu>
    800205e2:	5d3c                	lw	a5,120(a0)
    800205e4:	cf89                	beqz	a5,800205fe <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800205e6:	00001097          	auipc	ra,0x1
    800205ea:	4d0080e7          	jalr	1232(ra) # 80021ab6 <mycpu>
    800205ee:	5d3c                	lw	a5,120(a0)
    800205f0:	2785                	addiw	a5,a5,1
    800205f2:	dd3c                	sw	a5,120(a0)
}
    800205f4:	60e2                	ld	ra,24(sp)
    800205f6:	6442                	ld	s0,16(sp)
    800205f8:	64a2                	ld	s1,8(sp)
    800205fa:	6105                	addi	sp,sp,32
    800205fc:	8082                	ret
    mycpu()->intena = old;
    800205fe:	00001097          	auipc	ra,0x1
    80020602:	4b8080e7          	jalr	1208(ra) # 80021ab6 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80020606:	8085                	srli	s1,s1,0x1
    80020608:	8885                	andi	s1,s1,1
    8002060a:	dd64                	sw	s1,124(a0)
    8002060c:	bfe9                	j	800205e6 <push_off+0x24>

000000008002060e <pop_off>:

void
pop_off(void)
{
    8002060e:	1141                	addi	sp,sp,-16
    80020610:	e406                	sd	ra,8(sp)
    80020612:	e022                	sd	s0,0(sp)
    80020614:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80020616:	00001097          	auipc	ra,0x1
    8002061a:	4a0080e7          	jalr	1184(ra) # 80021ab6 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002061e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80020622:	8b89                	andi	a5,a5,2

  //printf("\e[31mpop_off()\e[0m: cpuid(): %d\n", cpuid());
  if(intr_get())
    80020624:	e78d                	bnez	a5,8002064e <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1) {
    80020626:	5d3c                	lw	a5,120(a0)
    80020628:	02f05b63          	blez	a5,8002065e <pop_off+0x50>
    //printf("c->noff = %d\n", c->noff);
    panic("pop_off");
  }
  //printf("c->noff: %d\n", c->noff);
  //printf("c: %x\n", c);
  c->noff -= 1;
    8002062c:	37fd                	addiw	a5,a5,-1
    8002062e:	0007871b          	sext.w	a4,a5
    80020632:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80020634:	eb09                	bnez	a4,80020646 <pop_off+0x38>
    80020636:	5d7c                	lw	a5,124(a0)
    80020638:	c799                	beqz	a5,80020646 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002063a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8002063e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80020642:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80020646:	60a2                	ld	ra,8(sp)
    80020648:	6402                	ld	s0,0(sp)
    8002064a:	0141                	addi	sp,sp,16
    8002064c:	8082                	ret
    panic("pop_off - interruptible");
    8002064e:	0000b517          	auipc	a0,0xb
    80020652:	c6250513          	addi	a0,a0,-926 # 8002b2b0 <digits+0x28>
    80020656:	00000097          	auipc	ra,0x0
    8002065a:	aec080e7          	jalr	-1300(ra) # 80020142 <panic>
    panic("pop_off");
    8002065e:	0000b517          	auipc	a0,0xb
    80020662:	c6a50513          	addi	a0,a0,-918 # 8002b2c8 <digits+0x40>
    80020666:	00000097          	auipc	ra,0x0
    8002066a:	adc080e7          	jalr	-1316(ra) # 80020142 <panic>

000000008002066e <initlock>:
#include "include/intr.h"
#include "include/printf.h"

void
initlock(struct spinlock *lk, char *name)
{
    8002066e:	1141                	addi	sp,sp,-16
    80020670:	e422                	sd	s0,8(sp)
    80020672:	0800                	addi	s0,sp,16
  lk->name = name;
    80020674:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80020676:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    8002067a:	00053823          	sd	zero,16(a0)
}
    8002067e:	6422                	ld	s0,8(sp)
    80020680:	0141                	addi	sp,sp,16
    80020682:	8082                	ret

0000000080020684 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80020684:	411c                	lw	a5,0(a0)
    80020686:	e399                	bnez	a5,8002068c <holding+0x8>
    80020688:	4501                	li	a0,0
  return r;
}
    8002068a:	8082                	ret
{
    8002068c:	1101                	addi	sp,sp,-32
    8002068e:	ec06                	sd	ra,24(sp)
    80020690:	e822                	sd	s0,16(sp)
    80020692:	e426                	sd	s1,8(sp)
    80020694:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80020696:	6904                	ld	s1,16(a0)
    80020698:	00001097          	auipc	ra,0x1
    8002069c:	41e080e7          	jalr	1054(ra) # 80021ab6 <mycpu>
    800206a0:	40a48533          	sub	a0,s1,a0
    800206a4:	00153513          	seqz	a0,a0
}
    800206a8:	60e2                	ld	ra,24(sp)
    800206aa:	6442                	ld	s0,16(sp)
    800206ac:	64a2                	ld	s1,8(sp)
    800206ae:	6105                	addi	sp,sp,32
    800206b0:	8082                	ret

00000000800206b2 <acquire>:
{
    800206b2:	1101                	addi	sp,sp,-32
    800206b4:	ec06                	sd	ra,24(sp)
    800206b6:	e822                	sd	s0,16(sp)
    800206b8:	e426                	sd	s1,8(sp)
    800206ba:	1000                	addi	s0,sp,32
    800206bc:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    800206be:	00000097          	auipc	ra,0x0
    800206c2:	f04080e7          	jalr	-252(ra) # 800205c2 <push_off>
  if(holding(lk))
    800206c6:	8526                	mv	a0,s1
    800206c8:	00000097          	auipc	ra,0x0
    800206cc:	fbc080e7          	jalr	-68(ra) # 80020684 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800206d0:	4705                	li	a4,1
  if(holding(lk))
    800206d2:	e115                	bnez	a0,800206f6 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800206d4:	87ba                	mv	a5,a4
    800206d6:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800206da:	2781                	sext.w	a5,a5
    800206dc:	ffe5                	bnez	a5,800206d4 <acquire+0x22>
  __sync_synchronize();
    800206de:	0ff0000f          	fence
  lk->cpu = mycpu();
    800206e2:	00001097          	auipc	ra,0x1
    800206e6:	3d4080e7          	jalr	980(ra) # 80021ab6 <mycpu>
    800206ea:	e888                	sd	a0,16(s1)
}
    800206ec:	60e2                	ld	ra,24(sp)
    800206ee:	6442                	ld	s0,16(sp)
    800206f0:	64a2                	ld	s1,8(sp)
    800206f2:	6105                	addi	sp,sp,32
    800206f4:	8082                	ret
    panic("acquire");
    800206f6:	0000b517          	auipc	a0,0xb
    800206fa:	bda50513          	addi	a0,a0,-1062 # 8002b2d0 <digits+0x48>
    800206fe:	00000097          	auipc	ra,0x0
    80020702:	a44080e7          	jalr	-1468(ra) # 80020142 <panic>

0000000080020706 <release>:
{
    80020706:	1101                	addi	sp,sp,-32
    80020708:	ec06                	sd	ra,24(sp)
    8002070a:	e822                	sd	s0,16(sp)
    8002070c:	e426                	sd	s1,8(sp)
    8002070e:	1000                	addi	s0,sp,32
    80020710:	84aa                	mv	s1,a0
  if(!holding(lk))
    80020712:	00000097          	auipc	ra,0x0
    80020716:	f72080e7          	jalr	-142(ra) # 80020684 <holding>
    8002071a:	c115                	beqz	a0,8002073e <release+0x38>
  lk->cpu = 0;
    8002071c:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80020720:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80020724:	0f50000f          	fence	iorw,ow
    80020728:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    8002072c:	00000097          	auipc	ra,0x0
    80020730:	ee2080e7          	jalr	-286(ra) # 8002060e <pop_off>
}
    80020734:	60e2                	ld	ra,24(sp)
    80020736:	6442                	ld	s0,16(sp)
    80020738:	64a2                	ld	s1,8(sp)
    8002073a:	6105                	addi	sp,sp,32
    8002073c:	8082                	ret
    panic("release");
    8002073e:	0000b517          	auipc	a0,0xb
    80020742:	b9a50513          	addi	a0,a0,-1126 # 8002b2d8 <digits+0x50>
    80020746:	00000097          	auipc	ra,0x0
    8002074a:	9fc080e7          	jalr	-1540(ra) # 80020142 <panic>

000000008002074e <memset>:
#include "include/types.h"

void*
memset(void *dst, int c, uint n)
{
    8002074e:	1141                	addi	sp,sp,-16
    80020750:	e422                	sd	s0,8(sp)
    80020752:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80020754:	ca19                	beqz	a2,8002076a <memset+0x1c>
    80020756:	87aa                	mv	a5,a0
    80020758:	1602                	slli	a2,a2,0x20
    8002075a:	9201                	srli	a2,a2,0x20
    8002075c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80020760:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80020764:	0785                	addi	a5,a5,1
    80020766:	fee79de3          	bne	a5,a4,80020760 <memset+0x12>
  }
  return dst;
}
    8002076a:	6422                	ld	s0,8(sp)
    8002076c:	0141                	addi	sp,sp,16
    8002076e:	8082                	ret

0000000080020770 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80020770:	1141                	addi	sp,sp,-16
    80020772:	e422                	sd	s0,8(sp)
    80020774:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80020776:	ca05                	beqz	a2,800207a6 <memcmp+0x36>
    80020778:	fff6069b          	addiw	a3,a2,-1
    8002077c:	1682                	slli	a3,a3,0x20
    8002077e:	9281                	srli	a3,a3,0x20
    80020780:	0685                	addi	a3,a3,1
    80020782:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80020784:	00054783          	lbu	a5,0(a0)
    80020788:	0005c703          	lbu	a4,0(a1)
    8002078c:	00e79863          	bne	a5,a4,8002079c <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80020790:	0505                	addi	a0,a0,1
    80020792:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80020794:	fed518e3          	bne	a0,a3,80020784 <memcmp+0x14>
  }

  return 0;
    80020798:	4501                	li	a0,0
    8002079a:	a019                	j	800207a0 <memcmp+0x30>
      return *s1 - *s2;
    8002079c:	40e7853b          	subw	a0,a5,a4
}
    800207a0:	6422                	ld	s0,8(sp)
    800207a2:	0141                	addi	sp,sp,16
    800207a4:	8082                	ret
  return 0;
    800207a6:	4501                	li	a0,0
    800207a8:	bfe5                	j	800207a0 <memcmp+0x30>

00000000800207aa <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800207aa:	1141                	addi	sp,sp,-16
    800207ac:	e422                	sd	s0,8(sp)
    800207ae:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
    800207b0:	02a5e563          	bltu	a1,a0,800207da <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800207b4:	fff6069b          	addiw	a3,a2,-1
    800207b8:	ce11                	beqz	a2,800207d4 <memmove+0x2a>
    800207ba:	1682                	slli	a3,a3,0x20
    800207bc:	9281                	srli	a3,a3,0x20
    800207be:	0685                	addi	a3,a3,1
    800207c0:	96ae                	add	a3,a3,a1
    800207c2:	87aa                	mv	a5,a0
      *d++ = *s++;
    800207c4:	0585                	addi	a1,a1,1
    800207c6:	0785                	addi	a5,a5,1
    800207c8:	fff5c703          	lbu	a4,-1(a1)
    800207cc:	fee78fa3          	sb	a4,-1(a5)
    while(n-- > 0)
    800207d0:	fed59ae3          	bne	a1,a3,800207c4 <memmove+0x1a>

  return dst;
}
    800207d4:	6422                	ld	s0,8(sp)
    800207d6:	0141                	addi	sp,sp,16
    800207d8:	8082                	ret
  if(s < d && s + n > d){
    800207da:	02061713          	slli	a4,a2,0x20
    800207de:	9301                	srli	a4,a4,0x20
    800207e0:	00e587b3          	add	a5,a1,a4
    800207e4:	fcf578e3          	bgeu	a0,a5,800207b4 <memmove+0xa>
    d += n;
    800207e8:	972a                	add	a4,a4,a0
    while(n-- > 0)
    800207ea:	fff6069b          	addiw	a3,a2,-1
    800207ee:	d27d                	beqz	a2,800207d4 <memmove+0x2a>
    800207f0:	02069613          	slli	a2,a3,0x20
    800207f4:	9201                	srli	a2,a2,0x20
    800207f6:	fff64613          	not	a2,a2
    800207fa:	963e                	add	a2,a2,a5
      *--d = *--s;
    800207fc:	17fd                	addi	a5,a5,-1
    800207fe:	177d                	addi	a4,a4,-1
    80020800:	0007c683          	lbu	a3,0(a5)
    80020804:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    80020808:	fef61ae3          	bne	a2,a5,800207fc <memmove+0x52>
    8002080c:	b7e1                	j	800207d4 <memmove+0x2a>

000000008002080e <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    8002080e:	1141                	addi	sp,sp,-16
    80020810:	e406                	sd	ra,8(sp)
    80020812:	e022                	sd	s0,0(sp)
    80020814:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80020816:	00000097          	auipc	ra,0x0
    8002081a:	f94080e7          	jalr	-108(ra) # 800207aa <memmove>
}
    8002081e:	60a2                	ld	ra,8(sp)
    80020820:	6402                	ld	s0,0(sp)
    80020822:	0141                	addi	sp,sp,16
    80020824:	8082                	ret

0000000080020826 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80020826:	1141                	addi	sp,sp,-16
    80020828:	e422                	sd	s0,8(sp)
    8002082a:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8002082c:	ce11                	beqz	a2,80020848 <strncmp+0x22>
    8002082e:	00054783          	lbu	a5,0(a0)
    80020832:	cf89                	beqz	a5,8002084c <strncmp+0x26>
    80020834:	0005c703          	lbu	a4,0(a1)
    80020838:	00f71a63          	bne	a4,a5,8002084c <strncmp+0x26>
    n--, p++, q++;
    8002083c:	367d                	addiw	a2,a2,-1
    8002083e:	0505                	addi	a0,a0,1
    80020840:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80020842:	f675                	bnez	a2,8002082e <strncmp+0x8>
  if(n == 0)
    return 0;
    80020844:	4501                	li	a0,0
    80020846:	a809                	j	80020858 <strncmp+0x32>
    80020848:	4501                	li	a0,0
    8002084a:	a039                	j	80020858 <strncmp+0x32>
  if(n == 0)
    8002084c:	ca09                	beqz	a2,8002085e <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    8002084e:	00054503          	lbu	a0,0(a0)
    80020852:	0005c783          	lbu	a5,0(a1)
    80020856:	9d1d                	subw	a0,a0,a5
}
    80020858:	6422                	ld	s0,8(sp)
    8002085a:	0141                	addi	sp,sp,16
    8002085c:	8082                	ret
    return 0;
    8002085e:	4501                	li	a0,0
    80020860:	bfe5                	j	80020858 <strncmp+0x32>

0000000080020862 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80020862:	1141                	addi	sp,sp,-16
    80020864:	e422                	sd	s0,8(sp)
    80020866:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80020868:	872a                	mv	a4,a0
    8002086a:	8832                	mv	a6,a2
    8002086c:	367d                	addiw	a2,a2,-1
    8002086e:	01005963          	blez	a6,80020880 <strncpy+0x1e>
    80020872:	0705                	addi	a4,a4,1
    80020874:	0005c783          	lbu	a5,0(a1)
    80020878:	fef70fa3          	sb	a5,-1(a4)
    8002087c:	0585                	addi	a1,a1,1
    8002087e:	f7f5                	bnez	a5,8002086a <strncpy+0x8>
    ;
  while(n-- > 0)
    80020880:	86ba                	mv	a3,a4
    80020882:	00c05c63          	blez	a2,8002089a <strncpy+0x38>
    *s++ = 0;
    80020886:	0685                	addi	a3,a3,1
    80020888:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    8002088c:	fff6c793          	not	a5,a3
    80020890:	9fb9                	addw	a5,a5,a4
    80020892:	010787bb          	addw	a5,a5,a6
    80020896:	fef048e3          	bgtz	a5,80020886 <strncpy+0x24>
  return os;
}
    8002089a:	6422                	ld	s0,8(sp)
    8002089c:	0141                	addi	sp,sp,16
    8002089e:	8082                	ret

00000000800208a0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800208a0:	1141                	addi	sp,sp,-16
    800208a2:	e422                	sd	s0,8(sp)
    800208a4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800208a6:	02c05363          	blez	a2,800208cc <safestrcpy+0x2c>
    800208aa:	fff6069b          	addiw	a3,a2,-1
    800208ae:	1682                	slli	a3,a3,0x20
    800208b0:	9281                	srli	a3,a3,0x20
    800208b2:	96ae                	add	a3,a3,a1
    800208b4:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800208b6:	00d58963          	beq	a1,a3,800208c8 <safestrcpy+0x28>
    800208ba:	0585                	addi	a1,a1,1
    800208bc:	0785                	addi	a5,a5,1
    800208be:	fff5c703          	lbu	a4,-1(a1)
    800208c2:	fee78fa3          	sb	a4,-1(a5)
    800208c6:	fb65                	bnez	a4,800208b6 <safestrcpy+0x16>
    ;
  *s = 0;
    800208c8:	00078023          	sb	zero,0(a5)
  return os;
}
    800208cc:	6422                	ld	s0,8(sp)
    800208ce:	0141                	addi	sp,sp,16
    800208d0:	8082                	ret

00000000800208d2 <strlen>:

int
strlen(const char *s)
{
    800208d2:	1141                	addi	sp,sp,-16
    800208d4:	e422                	sd	s0,8(sp)
    800208d6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800208d8:	00054783          	lbu	a5,0(a0)
    800208dc:	cf91                	beqz	a5,800208f8 <strlen+0x26>
    800208de:	0505                	addi	a0,a0,1
    800208e0:	87aa                	mv	a5,a0
    800208e2:	4685                	li	a3,1
    800208e4:	9e89                	subw	a3,a3,a0
    800208e6:	00f6853b          	addw	a0,a3,a5
    800208ea:	0785                	addi	a5,a5,1
    800208ec:	fff7c703          	lbu	a4,-1(a5)
    800208f0:	fb7d                	bnez	a4,800208e6 <strlen+0x14>
    ;
  return n;
}
    800208f2:	6422                	ld	s0,8(sp)
    800208f4:	0141                	addi	sp,sp,16
    800208f6:	8082                	ret
  for(n = 0; s[n]; n++)
    800208f8:	4501                	li	a0,0
    800208fa:	bfe5                	j	800208f2 <strlen+0x20>

00000000800208fc <wnstr>:

// convert uchar string into wide char string 
void wnstr(wchar *dst, char const *src, int len) {
    800208fc:	1141                	addi	sp,sp,-16
    800208fe:	e422                	sd	s0,8(sp)
    80020900:	0800                	addi	s0,sp,16
  while (len -- && *src) {
    80020902:	c205                	beqz	a2,80020922 <wnstr+0x26>
    80020904:	02061713          	slli	a4,a2,0x20
    80020908:	9301                	srli	a4,a4,0x20
    8002090a:	0706                	slli	a4,a4,0x1
    8002090c:	972a                	add	a4,a4,a0
    8002090e:	0005c783          	lbu	a5,0(a1)
    80020912:	cb81                	beqz	a5,80020922 <wnstr+0x26>
    *(uchar*)dst = *src++;
    80020914:	0585                	addi	a1,a1,1
    80020916:	00f50023          	sb	a5,0(a0)
    dst ++;
    8002091a:	0509                	addi	a0,a0,2
  while (len -- && *src) {
    8002091c:	fee519e3          	bne	a0,a4,8002090e <wnstr+0x12>
    dst ++;
    80020920:	853a                	mv	a0,a4
  }

  *dst = 0;
    80020922:	00051023          	sh	zero,0(a0)
}
    80020926:	6422                	ld	s0,8(sp)
    80020928:	0141                	addi	sp,sp,16
    8002092a:	8082                	ret

000000008002092c <snstr>:

// convert wide char string into uchar string 
void snstr(char *dst, wchar const *src, int len) {
    8002092c:	1141                	addi	sp,sp,-16
    8002092e:	e422                	sd	s0,8(sp)
    80020930:	0800                	addi	s0,sp,16
  while (len -- && *src) {
    80020932:	fff6071b          	addiw	a4,a2,-1
    80020936:	02061693          	slli	a3,a2,0x20
    8002093a:	9281                	srli	a3,a3,0x20
    8002093c:	96aa                	add	a3,a3,a0
    8002093e:	c61d                	beqz	a2,8002096c <snstr+0x40>
    80020940:	0005d783          	lhu	a5,0(a1)
    80020944:	cb89                	beqz	a5,80020956 <snstr+0x2a>
    *dst++ = (uchar)(*src & 0xff);
    80020946:	0505                	addi	a0,a0,1
    80020948:	fef50fa3          	sb	a5,-1(a0)
    src ++;
    8002094c:	0589                	addi	a1,a1,2
  while (len -- && *src) {
    8002094e:	377d                	addiw	a4,a4,-1
    80020950:	fed518e3          	bne	a0,a3,80020940 <snstr+0x14>
    *dst++ = (uchar)(*src & 0xff);
    80020954:	8536                	mv	a0,a3
  }
  while(len-- > 0)
    80020956:	02071793          	slli	a5,a4,0x20
    8002095a:	9381                	srli	a5,a5,0x20
    8002095c:	97aa                	add	a5,a5,a0
    8002095e:	00e05763          	blez	a4,8002096c <snstr+0x40>
    *dst++ = 0;
    80020962:	0505                	addi	a0,a0,1
    80020964:	fe050fa3          	sb	zero,-1(a0)
  while(len-- > 0)
    80020968:	fea79de3          	bne	a5,a0,80020962 <snstr+0x36>
}
    8002096c:	6422                	ld	s0,8(sp)
    8002096e:	0141                	addi	sp,sp,16
    80020970:	8082                	ret

0000000080020972 <wcsncmp>:

int wcsncmp(wchar const *s1, wchar const *s2, int len) {
    80020972:	1141                	addi	sp,sp,-16
    80020974:	e422                	sd	s0,8(sp)
    80020976:	0800                	addi	s0,sp,16
    80020978:	87aa                	mv	a5,a0
  int ret = 0;

  while (len-- && *s1) {
    8002097a:	02061693          	slli	a3,a2,0x20
    8002097e:	9281                	srli	a3,a3,0x20
    80020980:	0686                	slli	a3,a3,0x1
    80020982:	96ae                	add	a3,a3,a1
    80020984:	00d58c63          	beq	a1,a3,8002099c <wcsncmp+0x2a>
    80020988:	0007d503          	lhu	a0,0(a5)
    8002098c:	c909                	beqz	a0,8002099e <wcsncmp+0x2c>
    ret = (int)(*s1++ - *s2++);
    8002098e:	0789                	addi	a5,a5,2
    80020990:	0589                	addi	a1,a1,2
    80020992:	ffe5d703          	lhu	a4,-2(a1)
    80020996:	9d19                	subw	a0,a0,a4
    if (ret) break;
    80020998:	d575                	beqz	a0,80020984 <wcsncmp+0x12>
    8002099a:	a011                	j	8002099e <wcsncmp+0x2c>
    8002099c:	4501                	li	a0,0
  }

  return ret;
}
    8002099e:	6422                	ld	s0,8(sp)
    800209a0:	0141                	addi	sp,sp,16
    800209a2:	8082                	ret

00000000800209a4 <strchr>:

char*
strchr(const char *s, char c)
{
    800209a4:	1141                	addi	sp,sp,-16
    800209a6:	e422                	sd	s0,8(sp)
    800209a8:	0800                	addi	s0,sp,16
  for(; *s; s++)
    800209aa:	00054783          	lbu	a5,0(a0)
    800209ae:	cb99                	beqz	a5,800209c4 <strchr+0x20>
    if(*s == c)
    800209b0:	00f58763          	beq	a1,a5,800209be <strchr+0x1a>
  for(; *s; s++)
    800209b4:	0505                	addi	a0,a0,1
    800209b6:	00054783          	lbu	a5,0(a0)
    800209ba:	fbfd                	bnez	a5,800209b0 <strchr+0xc>
      return (char*)s;
  return 0;
    800209bc:	4501                	li	a0,0
    800209be:	6422                	ld	s0,8(sp)
    800209c0:	0141                	addi	sp,sp,16
    800209c2:	8082                	ret
  return 0;
    800209c4:	4501                	li	a0,0
    800209c6:	bfe5                	j	800209be <strchr+0x1a>

00000000800209c8 <main>:

volatile static int started = 0;

void
main(unsigned long hartid, unsigned long dtb_pa)
{
    800209c8:	1101                	addi	sp,sp,-32
    800209ca:	ec06                	sd	ra,24(sp)
    800209cc:	e822                	sd	s0,16(sp)
    800209ce:	1000                	addi	s0,sp,32
  asm volatile("mv tp, %0" : : "r" (hartid & 0x1));
    800209d0:	00157793          	andi	a5,a0,1
    800209d4:	823e                	mv	tp,a5
    started = 1;
  }
  else
  {
    // hart 1
    while (started == 0)
    800209d6:	00016717          	auipc	a4,0x16
    800209da:	67a70713          	addi	a4,a4,1658 # 80037050 <started>
  if (hartid == 0) {
    800209de:	cd15                	beqz	a0,80020a1a <main+0x52>
    while (started == 0)
    800209e0:	431c                	lw	a5,0(a4)
    800209e2:	2781                	sext.w	a5,a5
    800209e4:	dff5                	beqz	a5,800209e0 <main+0x18>
      ;
    __sync_synchronize();
    800209e6:	0ff0000f          	fence
    #ifdef DEBUG
    printf("hart %d enter main()...\n", hartid);
    #endif
    kvminithart();
    800209ea:	00000097          	auipc	ra,0x0
    800209ee:	0ee080e7          	jalr	238(ra) # 80020ad8 <kvminithart>
    trapinithart();
    800209f2:	00002097          	auipc	ra,0x2
    800209f6:	d6a080e7          	jalr	-662(ra) # 8002275c <trapinithart>
    plicinithart();  // ask PLIC for device interrupts
    800209fa:	00006097          	auipc	ra,0x6
    800209fe:	fe2080e7          	jalr	-30(ra) # 800269dc <plicinithart>
    printf("hart 1 init done\n");
    80020a02:	0000b517          	auipc	a0,0xb
    80020a06:	8f650513          	addi	a0,a0,-1802 # 8002b2f8 <digits+0x70>
    80020a0a:	fffff097          	auipc	ra,0xfffff
    80020a0e:	782080e7          	jalr	1922(ra) # 8002018c <printf>
  }
  scheduler();
    80020a12:	00001097          	auipc	ra,0x1
    80020a16:	642080e7          	jalr	1602(ra) # 80022054 <scheduler>
    consoleinit();
    80020a1a:	00006097          	auipc	ra,0x6
    80020a1e:	38e080e7          	jalr	910(ra) # 80026da8 <consoleinit>
    printfinit();   // init a lock for printf
    80020a22:	00000097          	auipc	ra,0x0
    80020a26:	94a080e7          	jalr	-1718(ra) # 8002036c <printfinit>
    print_logo();
    80020a2a:	00000097          	auipc	ra,0x0
    80020a2e:	974080e7          	jalr	-1676(ra) # 8002039e <print_logo>
    kinit();         // physical page allocator
    80020a32:	00000097          	auipc	ra,0x0
    80020a36:	ac8080e7          	jalr	-1336(ra) # 800204fa <kinit>
    kvminit();       // create kernel page table
    80020a3a:	00000097          	auipc	ra,0x0
    80020a3e:	2e8080e7          	jalr	744(ra) # 80020d22 <kvminit>
    kvminithart();   // turn on paging
    80020a42:	00000097          	auipc	ra,0x0
    80020a46:	096080e7          	jalr	150(ra) # 80020ad8 <kvminithart>
    timerinit();     // init a lock for timer
    80020a4a:	00004097          	auipc	ra,0x4
    80020a4e:	554080e7          	jalr	1364(ra) # 80024f9e <timerinit>
    trapinithart();  // install kernel trap vector, including interrupt handler
    80020a52:	00002097          	auipc	ra,0x2
    80020a56:	d0a080e7          	jalr	-758(ra) # 8002275c <trapinithart>
    procinit();
    80020a5a:	00001097          	auipc	ra,0x1
    80020a5e:	fd6080e7          	jalr	-42(ra) # 80021a30 <procinit>
    plicinit();
    80020a62:	00006097          	auipc	ra,0x6
    80020a66:	f60080e7          	jalr	-160(ra) # 800269c2 <plicinit>
    plicinithart();
    80020a6a:	00006097          	auipc	ra,0x6
    80020a6e:	f72080e7          	jalr	-142(ra) # 800269dc <plicinithart>
    fpioa_pin_init();
    80020a72:	00007097          	auipc	ra,0x7
    80020a76:	2ca080e7          	jalr	714(ra) # 80027d3c <fpioa_pin_init>
    dmac_init();
    80020a7a:	00008097          	auipc	ra,0x8
    80020a7e:	f68080e7          	jalr	-152(ra) # 800289e2 <dmac_init>
    disk_init();
    80020a82:	00004097          	auipc	ra,0x4
    80020a86:	5b8080e7          	jalr	1464(ra) # 8002503a <disk_init>
    binit();         // buffer cache
    80020a8a:	00003097          	auipc	ra,0x3
    80020a8e:	8ba080e7          	jalr	-1862(ra) # 80023344 <binit>
    fileinit();      // file table
    80020a92:	00003097          	auipc	ra,0x3
    80020a96:	cbe080e7          	jalr	-834(ra) # 80023750 <fileinit>
    userinit();      // first user process
    80020a9a:	00001097          	auipc	ra,0x1
    80020a9e:	346080e7          	jalr	838(ra) # 80021de0 <userinit>
    printf("hart 0 init done\n");
    80020aa2:	0000b517          	auipc	a0,0xb
    80020aa6:	83e50513          	addi	a0,a0,-1986 # 8002b2e0 <digits+0x58>
    80020aaa:	fffff097          	auipc	ra,0xfffff
    80020aae:	6e2080e7          	jalr	1762(ra) # 8002018c <printf>
      unsigned long mask = 1 << i;
    80020ab2:	4789                	li	a5,2
    80020ab4:	fef43423          	sd	a5,-24(s0)
	SBI_CALL_0(SBI_CLEAR_IPI);
}

static inline void sbi_send_ipi(const unsigned long *hart_mask)
{
	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
    80020ab8:	fe840513          	addi	a0,s0,-24
    80020abc:	4581                	li	a1,0
    80020abe:	4601                	li	a2,0
    80020ac0:	4681                	li	a3,0
    80020ac2:	4891                	li	a7,4
    80020ac4:	00000073          	ecall
    __sync_synchronize();
    80020ac8:	0ff0000f          	fence
    started = 1;
    80020acc:	4785                	li	a5,1
    80020ace:	00016717          	auipc	a4,0x16
    80020ad2:	58f72123          	sw	a5,1410(a4) # 80037050 <started>
    80020ad6:	bf35                	j	80020a12 <main+0x4a>

0000000080020ad8 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80020ad8:	1141                	addi	sp,sp,-16
    80020ada:	e422                	sd	s0,8(sp)
    80020adc:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80020ade:	00016797          	auipc	a5,0x16
    80020ae2:	57a7b783          	ld	a5,1402(a5) # 80037058 <kernel_pagetable>
    80020ae6:	83b1                	srli	a5,a5,0xc
    80020ae8:	577d                	li	a4,-1
    80020aea:	177e                	slli	a4,a4,0x3f
    80020aec:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80020aee:	18079073          	csrw	satp,a5
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  // asm volatile("sfence.vma zero, zero");
  asm volatile("sfence.vma");
    80020af2:	12000073          	sfence.vma
  // reg_info();
  sfence_vma();
  #ifdef DEBUG
  printf("kvminithart\n");
  #endif
}
    80020af6:	6422                	ld	s0,8(sp)
    80020af8:	0141                	addi	sp,sp,16
    80020afa:	8082                	ret

0000000080020afc <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80020afc:	7139                	addi	sp,sp,-64
    80020afe:	fc06                	sd	ra,56(sp)
    80020b00:	f822                	sd	s0,48(sp)
    80020b02:	f426                	sd	s1,40(sp)
    80020b04:	f04a                	sd	s2,32(sp)
    80020b06:	ec4e                	sd	s3,24(sp)
    80020b08:	e852                	sd	s4,16(sp)
    80020b0a:	e456                	sd	s5,8(sp)
    80020b0c:	e05a                	sd	s6,0(sp)
    80020b0e:	0080                	addi	s0,sp,64
    80020b10:	84aa                	mv	s1,a0
    80020b12:	89ae                	mv	s3,a1
    80020b14:	8ab2                	mv	s5,a2
  
  if(va >= MAXVA)
    80020b16:	57fd                	li	a5,-1
    80020b18:	83e9                	srli	a5,a5,0x1a
    80020b1a:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80020b1c:	4b31                	li	s6,12
  if(va >= MAXVA)
    80020b1e:	04b7f263          	bgeu	a5,a1,80020b62 <walk+0x66>
    panic("walk");
    80020b22:	0000a517          	auipc	a0,0xa
    80020b26:	7ee50513          	addi	a0,a0,2030 # 8002b310 <digits+0x88>
    80020b2a:	fffff097          	auipc	ra,0xfffff
    80020b2e:	618080e7          	jalr	1560(ra) # 80020142 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == NULL)
    80020b32:	060a8663          	beqz	s5,80020b9e <walk+0xa2>
    80020b36:	00000097          	auipc	ra,0x0
    80020b3a:	a10080e7          	jalr	-1520(ra) # 80020546 <kalloc>
    80020b3e:	84aa                	mv	s1,a0
    80020b40:	c529                	beqz	a0,80020b8a <walk+0x8e>
        return NULL;
      memset(pagetable, 0, PGSIZE);
    80020b42:	6605                	lui	a2,0x1
    80020b44:	4581                	li	a1,0
    80020b46:	00000097          	auipc	ra,0x0
    80020b4a:	c08080e7          	jalr	-1016(ra) # 8002074e <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80020b4e:	00c4d793          	srli	a5,s1,0xc
    80020b52:	07aa                	slli	a5,a5,0xa
    80020b54:	0017e793          	ori	a5,a5,1
    80020b58:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80020b5c:	3a5d                	addiw	s4,s4,-9
    80020b5e:	036a0063          	beq	s4,s6,80020b7e <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80020b62:	0149d933          	srl	s2,s3,s4
    80020b66:	1ff97913          	andi	s2,s2,511
    80020b6a:	090e                	slli	s2,s2,0x3
    80020b6c:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80020b6e:	00093483          	ld	s1,0(s2)
    80020b72:	0014f793          	andi	a5,s1,1
    80020b76:	dfd5                	beqz	a5,80020b32 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80020b78:	80a9                	srli	s1,s1,0xa
    80020b7a:	04b2                	slli	s1,s1,0xc
    80020b7c:	b7c5                	j	80020b5c <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80020b7e:	00c9d513          	srli	a0,s3,0xc
    80020b82:	1ff57513          	andi	a0,a0,511
    80020b86:	050e                	slli	a0,a0,0x3
    80020b88:	9526                	add	a0,a0,s1
}
    80020b8a:	70e2                	ld	ra,56(sp)
    80020b8c:	7442                	ld	s0,48(sp)
    80020b8e:	74a2                	ld	s1,40(sp)
    80020b90:	7902                	ld	s2,32(sp)
    80020b92:	69e2                	ld	s3,24(sp)
    80020b94:	6a42                	ld	s4,16(sp)
    80020b96:	6aa2                	ld	s5,8(sp)
    80020b98:	6b02                	ld	s6,0(sp)
    80020b9a:	6121                	addi	sp,sp,64
    80020b9c:	8082                	ret
        return NULL;
    80020b9e:	4501                	li	a0,0
    80020ba0:	b7ed                	j	80020b8a <walk+0x8e>

0000000080020ba2 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80020ba2:	57fd                	li	a5,-1
    80020ba4:	83e9                	srli	a5,a5,0x1a
    80020ba6:	00b7f463          	bgeu	a5,a1,80020bae <walkaddr+0xc>
    return NULL;
    80020baa:	4501                	li	a0,0
    return NULL;
  if((*pte & PTE_U) == 0)
    return NULL;
  pa = PTE2PA(*pte);
  return pa;
}
    80020bac:	8082                	ret
{
    80020bae:	1141                	addi	sp,sp,-16
    80020bb0:	e406                	sd	ra,8(sp)
    80020bb2:	e022                	sd	s0,0(sp)
    80020bb4:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80020bb6:	4601                	li	a2,0
    80020bb8:	00000097          	auipc	ra,0x0
    80020bbc:	f44080e7          	jalr	-188(ra) # 80020afc <walk>
  if(pte == 0)
    80020bc0:	c105                	beqz	a0,80020be0 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80020bc2:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80020bc4:	0117f693          	andi	a3,a5,17
    80020bc8:	4745                	li	a4,17
    return NULL;
    80020bca:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80020bcc:	00e68663          	beq	a3,a4,80020bd8 <walkaddr+0x36>
}
    80020bd0:	60a2                	ld	ra,8(sp)
    80020bd2:	6402                	ld	s0,0(sp)
    80020bd4:	0141                	addi	sp,sp,16
    80020bd6:	8082                	ret
  pa = PTE2PA(*pte);
    80020bd8:	00a7d513          	srli	a0,a5,0xa
    80020bdc:	0532                	slli	a0,a0,0xc
  return pa;
    80020bde:	bfcd                	j	80020bd0 <walkaddr+0x2e>
    return NULL;
    80020be0:	4501                	li	a0,0
    80020be2:	b7fd                	j	80020bd0 <walkaddr+0x2e>

0000000080020be4 <kwalkaddr>:
  return kwalkaddr(kernel_pagetable, va);
}

uint64
kwalkaddr(pagetable_t kpt, uint64 va)
{
    80020be4:	1101                	addi	sp,sp,-32
    80020be6:	ec06                	sd	ra,24(sp)
    80020be8:	e822                	sd	s0,16(sp)
    80020bea:	e426                	sd	s1,8(sp)
    80020bec:	1000                	addi	s0,sp,32
  uint64 off = va % PGSIZE;
    80020bee:	03459793          	slli	a5,a1,0x34
    80020bf2:	0347d493          	srli	s1,a5,0x34
  pte_t *pte;
  uint64 pa;
  
  pte = walk(kpt, va, 0);
    80020bf6:	4601                	li	a2,0
    80020bf8:	00000097          	auipc	ra,0x0
    80020bfc:	f04080e7          	jalr	-252(ra) # 80020afc <walk>
  if(pte == 0)
    80020c00:	cd09                	beqz	a0,80020c1a <kwalkaddr+0x36>
    panic("kvmpa");
  if((*pte & PTE_V) == 0)
    80020c02:	6108                	ld	a0,0(a0)
    80020c04:	00157793          	andi	a5,a0,1
    80020c08:	c38d                	beqz	a5,80020c2a <kwalkaddr+0x46>
    panic("kvmpa");
  pa = PTE2PA(*pte);
    80020c0a:	8129                	srli	a0,a0,0xa
    80020c0c:	0532                	slli	a0,a0,0xc
  return pa+off;
}
    80020c0e:	9526                	add	a0,a0,s1
    80020c10:	60e2                	ld	ra,24(sp)
    80020c12:	6442                	ld	s0,16(sp)
    80020c14:	64a2                	ld	s1,8(sp)
    80020c16:	6105                	addi	sp,sp,32
    80020c18:	8082                	ret
    panic("kvmpa");
    80020c1a:	0000a517          	auipc	a0,0xa
    80020c1e:	6fe50513          	addi	a0,a0,1790 # 8002b318 <digits+0x90>
    80020c22:	fffff097          	auipc	ra,0xfffff
    80020c26:	520080e7          	jalr	1312(ra) # 80020142 <panic>
    panic("kvmpa");
    80020c2a:	0000a517          	auipc	a0,0xa
    80020c2e:	6ee50513          	addi	a0,a0,1774 # 8002b318 <digits+0x90>
    80020c32:	fffff097          	auipc	ra,0xfffff
    80020c36:	510080e7          	jalr	1296(ra) # 80020142 <panic>

0000000080020c3a <kvmpa>:
{
    80020c3a:	1141                	addi	sp,sp,-16
    80020c3c:	e406                	sd	ra,8(sp)
    80020c3e:	e022                	sd	s0,0(sp)
    80020c40:	0800                	addi	s0,sp,16
    80020c42:	85aa                	mv	a1,a0
  return kwalkaddr(kernel_pagetable, va);
    80020c44:	00016517          	auipc	a0,0x16
    80020c48:	41453503          	ld	a0,1044(a0) # 80037058 <kernel_pagetable>
    80020c4c:	00000097          	auipc	ra,0x0
    80020c50:	f98080e7          	jalr	-104(ra) # 80020be4 <kwalkaddr>
}
    80020c54:	60a2                	ld	ra,8(sp)
    80020c56:	6402                	ld	s0,0(sp)
    80020c58:	0141                	addi	sp,sp,16
    80020c5a:	8082                	ret

0000000080020c5c <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80020c5c:	715d                	addi	sp,sp,-80
    80020c5e:	e486                	sd	ra,72(sp)
    80020c60:	e0a2                	sd	s0,64(sp)
    80020c62:	fc26                	sd	s1,56(sp)
    80020c64:	f84a                	sd	s2,48(sp)
    80020c66:	f44e                	sd	s3,40(sp)
    80020c68:	f052                	sd	s4,32(sp)
    80020c6a:	ec56                	sd	s5,24(sp)
    80020c6c:	e85a                	sd	s6,16(sp)
    80020c6e:	e45e                	sd	s7,8(sp)
    80020c70:	0880                	addi	s0,sp,80
    80020c72:	8aaa                	mv	s5,a0
    80020c74:	8b3a                	mv	s6,a4
  uint64 a, last;
  pte_t *pte;

  a = PGROUNDDOWN(va);
    80020c76:	777d                	lui	a4,0xfffff
    80020c78:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    80020c7c:	167d                	addi	a2,a2,-1
    80020c7e:	00b609b3          	add	s3,a2,a1
    80020c82:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    80020c86:	893e                	mv	s2,a5
    80020c88:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80020c8c:	6b85                	lui	s7,0x1
    80020c8e:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == NULL)
    80020c92:	4605                	li	a2,1
    80020c94:	85ca                	mv	a1,s2
    80020c96:	8556                	mv	a0,s5
    80020c98:	00000097          	auipc	ra,0x0
    80020c9c:	e64080e7          	jalr	-412(ra) # 80020afc <walk>
    80020ca0:	c51d                	beqz	a0,80020cce <mappages+0x72>
    if(*pte & PTE_V)
    80020ca2:	611c                	ld	a5,0(a0)
    80020ca4:	8b85                	andi	a5,a5,1
    80020ca6:	ef81                	bnez	a5,80020cbe <mappages+0x62>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80020ca8:	80b1                	srli	s1,s1,0xc
    80020caa:	04aa                	slli	s1,s1,0xa
    80020cac:	0164e4b3          	or	s1,s1,s6
    80020cb0:	0014e493          	ori	s1,s1,1
    80020cb4:	e104                	sd	s1,0(a0)
    if(a == last)
    80020cb6:	03390863          	beq	s2,s3,80020ce6 <mappages+0x8a>
    a += PGSIZE;
    80020cba:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == NULL)
    80020cbc:	bfc9                	j	80020c8e <mappages+0x32>
      panic("remap");
    80020cbe:	0000a517          	auipc	a0,0xa
    80020cc2:	66250513          	addi	a0,a0,1634 # 8002b320 <digits+0x98>
    80020cc6:	fffff097          	auipc	ra,0xfffff
    80020cca:	47c080e7          	jalr	1148(ra) # 80020142 <panic>
      return -1;
    80020cce:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80020cd0:	60a6                	ld	ra,72(sp)
    80020cd2:	6406                	ld	s0,64(sp)
    80020cd4:	74e2                	ld	s1,56(sp)
    80020cd6:	7942                	ld	s2,48(sp)
    80020cd8:	79a2                	ld	s3,40(sp)
    80020cda:	7a02                	ld	s4,32(sp)
    80020cdc:	6ae2                	ld	s5,24(sp)
    80020cde:	6b42                	ld	s6,16(sp)
    80020ce0:	6ba2                	ld	s7,8(sp)
    80020ce2:	6161                	addi	sp,sp,80
    80020ce4:	8082                	ret
  return 0;
    80020ce6:	4501                	li	a0,0
    80020ce8:	b7e5                	j	80020cd0 <mappages+0x74>

0000000080020cea <kvmmap>:
{
    80020cea:	1141                	addi	sp,sp,-16
    80020cec:	e406                	sd	ra,8(sp)
    80020cee:	e022                	sd	s0,0(sp)
    80020cf0:	0800                	addi	s0,sp,16
    80020cf2:	8736                	mv	a4,a3
  if(mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    80020cf4:	86ae                	mv	a3,a1
    80020cf6:	85aa                	mv	a1,a0
    80020cf8:	00016517          	auipc	a0,0x16
    80020cfc:	36053503          	ld	a0,864(a0) # 80037058 <kernel_pagetable>
    80020d00:	00000097          	auipc	ra,0x0
    80020d04:	f5c080e7          	jalr	-164(ra) # 80020c5c <mappages>
    80020d08:	e509                	bnez	a0,80020d12 <kvmmap+0x28>
}
    80020d0a:	60a2                	ld	ra,8(sp)
    80020d0c:	6402                	ld	s0,0(sp)
    80020d0e:	0141                	addi	sp,sp,16
    80020d10:	8082                	ret
    panic("kvmmap");
    80020d12:	0000a517          	auipc	a0,0xa
    80020d16:	61650513          	addi	a0,a0,1558 # 8002b328 <digits+0xa0>
    80020d1a:	fffff097          	auipc	ra,0xfffff
    80020d1e:	428080e7          	jalr	1064(ra) # 80020142 <panic>

0000000080020d22 <kvminit>:
{
    80020d22:	1101                	addi	sp,sp,-32
    80020d24:	ec06                	sd	ra,24(sp)
    80020d26:	e822                	sd	s0,16(sp)
    80020d28:	e426                	sd	s1,8(sp)
    80020d2a:	1000                	addi	s0,sp,32
  kernel_pagetable = (pagetable_t) kalloc();
    80020d2c:	00000097          	auipc	ra,0x0
    80020d30:	81a080e7          	jalr	-2022(ra) # 80020546 <kalloc>
    80020d34:	00016797          	auipc	a5,0x16
    80020d38:	32a7b223          	sd	a0,804(a5) # 80037058 <kernel_pagetable>
  memset(kernel_pagetable, 0, PGSIZE);
    80020d3c:	6605                	lui	a2,0x1
    80020d3e:	4581                	li	a1,0
    80020d40:	00000097          	auipc	ra,0x0
    80020d44:	a0e080e7          	jalr	-1522(ra) # 8002074e <memset>
  kvmmap(UART_V, UART, PGSIZE, PTE_R | PTE_W);
    80020d48:	4699                	li	a3,6
    80020d4a:	6605                	lui	a2,0x1
    80020d4c:	380005b7          	lui	a1,0x38000
    80020d50:	7e700513          	li	a0,2023
    80020d54:	056e                	slli	a0,a0,0x1b
    80020d56:	00000097          	auipc	ra,0x0
    80020d5a:	f94080e7          	jalr	-108(ra) # 80020cea <kvmmap>
  kvmmap(CLINT_V, CLINT, 0x10000, PTE_R | PTE_W);
    80020d5e:	4699                	li	a3,6
    80020d60:	6641                	lui	a2,0x10
    80020d62:	020005b7          	lui	a1,0x2000
    80020d66:	01f81537          	lui	a0,0x1f81
    80020d6a:	0536                	slli	a0,a0,0xd
    80020d6c:	00000097          	auipc	ra,0x0
    80020d70:	f7e080e7          	jalr	-130(ra) # 80020cea <kvmmap>
  kvmmap(PLIC_V, PLIC, 0x4000, PTE_R | PTE_W);
    80020d74:	4699                	li	a3,6
    80020d76:	6611                	lui	a2,0x4
    80020d78:	0c0005b7          	lui	a1,0xc000
    80020d7c:	00fc3537          	lui	a0,0xfc3
    80020d80:	053a                	slli	a0,a0,0xe
    80020d82:	00000097          	auipc	ra,0x0
    80020d86:	f68080e7          	jalr	-152(ra) # 80020cea <kvmmap>
  kvmmap(PLIC_V + 0x200000, PLIC + 0x200000, 0x4000, PTE_R | PTE_W);
    80020d8a:	4699                	li	a3,6
    80020d8c:	6611                	lui	a2,0x4
    80020d8e:	0c2005b7          	lui	a1,0xc200
    80020d92:	1f861537          	lui	a0,0x1f861
    80020d96:	0526                	slli	a0,a0,0x9
    80020d98:	00000097          	auipc	ra,0x0
    80020d9c:	f52080e7          	jalr	-174(ra) # 80020cea <kvmmap>
  kvmmap(GPIOHS_V, GPIOHS, 0x1000, PTE_R | PTE_W);
    80020da0:	4699                	li	a3,6
    80020da2:	6605                	lui	a2,0x1
    80020da4:	380015b7          	lui	a1,0x38001
    80020da8:	03f38537          	lui	a0,0x3f38
    80020dac:	0505                	addi	a0,a0,1
    80020dae:	0532                	slli	a0,a0,0xc
    80020db0:	00000097          	auipc	ra,0x0
    80020db4:	f3a080e7          	jalr	-198(ra) # 80020cea <kvmmap>
  kvmmap(DMAC_V, DMAC, 0x1000, PTE_R | PTE_W);
    80020db8:	4699                	li	a3,6
    80020dba:	6605                	lui	a2,0x1
    80020dbc:	500005b7          	lui	a1,0x50000
    80020dc0:	3f500513          	li	a0,1013
    80020dc4:	0572                	slli	a0,a0,0x1c
    80020dc6:	00000097          	auipc	ra,0x0
    80020dca:	f24080e7          	jalr	-220(ra) # 80020cea <kvmmap>
  kvmmap(SPI_SLAVE_V, SPI_SLAVE, 0x1000, PTE_R | PTE_W);
    80020dce:	4699                	li	a3,6
    80020dd0:	6605                	lui	a2,0x1
    80020dd2:	502405b7          	lui	a1,0x50240
    80020dd6:	000fd4b7          	lui	s1,0xfd
    80020dda:	40948513          	addi	a0,s1,1033 # fd409 <_start-0x7ff22bf7>
    80020dde:	054a                	slli	a0,a0,0x12
    80020de0:	00000097          	auipc	ra,0x0
    80020de4:	f0a080e7          	jalr	-246(ra) # 80020cea <kvmmap>
  kvmmap(FPIOA_V, FPIOA, 0x1000, PTE_R | PTE_W);
    80020de8:	4699                	li	a3,6
    80020dea:	6605                	lui	a2,0x1
    80020dec:	502b05b7          	lui	a1,0x502b0
    80020df0:	003f5537          	lui	a0,0x3f5
    80020df4:	02b50513          	addi	a0,a0,43 # 3f502b <_start-0x7fc2afd5>
    80020df8:	0542                	slli	a0,a0,0x10
    80020dfa:	00000097          	auipc	ra,0x0
    80020dfe:	ef0080e7          	jalr	-272(ra) # 80020cea <kvmmap>
  kvmmap(SPI0_V, SPI0, 0x1000, PTE_R | PTE_W);
    80020e02:	4699                	li	a3,6
    80020e04:	6605                	lui	a2,0x1
    80020e06:	520005b7          	lui	a1,0x52000
    80020e0a:	01fa9537          	lui	a0,0x1fa9
    80020e0e:	0536                	slli	a0,a0,0xd
    80020e10:	00000097          	auipc	ra,0x0
    80020e14:	eda080e7          	jalr	-294(ra) # 80020cea <kvmmap>
  kvmmap(SPI1_V, SPI1, 0x1000, PTE_R | PTE_W);
    80020e18:	4699                	li	a3,6
    80020e1a:	6605                	lui	a2,0x1
    80020e1c:	530005b7          	lui	a1,0x53000
    80020e20:	03f53537          	lui	a0,0x3f53
    80020e24:	0532                	slli	a0,a0,0xc
    80020e26:	00000097          	auipc	ra,0x0
    80020e2a:	ec4080e7          	jalr	-316(ra) # 80020cea <kvmmap>
  kvmmap(SPI2_V, SPI2, 0x1000, PTE_R | PTE_W);
    80020e2e:	4699                	li	a3,6
    80020e30:	6605                	lui	a2,0x1
    80020e32:	540005b7          	lui	a1,0x54000
    80020e36:	00fd5537          	lui	a0,0xfd5
    80020e3a:	053a                	slli	a0,a0,0xe
    80020e3c:	00000097          	auipc	ra,0x0
    80020e40:	eae080e7          	jalr	-338(ra) # 80020cea <kvmmap>
  kvmmap(SYSCTL_V, SYSCTL, 0x1000, PTE_R | PTE_W);
    80020e44:	4699                	li	a3,6
    80020e46:	6605                	lui	a2,0x1
    80020e48:	504405b7          	lui	a1,0x50440
    80020e4c:	41148513          	addi	a0,s1,1041
    80020e50:	054a                	slli	a0,a0,0x12
    80020e52:	00000097          	auipc	ra,0x0
    80020e56:	e98080e7          	jalr	-360(ra) # 80020cea <kvmmap>
  kvmmap(KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);
    80020e5a:	0000d497          	auipc	s1,0xd
    80020e5e:	66e4b483          	ld	s1,1646(s1) # 8002e4c8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80020e62:	46a9                	li	a3,10
    80020e64:	fbfff637          	lui	a2,0xfbfff
    80020e68:	0616                	slli	a2,a2,0x5
    80020e6a:	9626                	add	a2,a2,s1
    80020e6c:	040015b7          	lui	a1,0x4001
    80020e70:	0596                	slli	a1,a1,0x5
    80020e72:	852e                	mv	a0,a1
    80020e74:	00000097          	auipc	ra,0x0
    80020e78:	e76080e7          	jalr	-394(ra) # 80020cea <kvmmap>
  kvmmap((uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext, PTE_R | PTE_W);
    80020e7c:	4699                	li	a3,6
    80020e7e:	40300613          	li	a2,1027
    80020e82:	0656                	slli	a2,a2,0x15
    80020e84:	8e05                	sub	a2,a2,s1
    80020e86:	85a6                	mv	a1,s1
    80020e88:	8526                	mv	a0,s1
    80020e8a:	00000097          	auipc	ra,0x0
    80020e8e:	e60080e7          	jalr	-416(ra) # 80020cea <kvmmap>
  kvmmap(TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80020e92:	46a9                	li	a3,10
    80020e94:	6605                	lui	a2,0x1
    80020e96:	0000d597          	auipc	a1,0xd
    80020e9a:	61a5b583          	ld	a1,1562(a1) # 8002e4b0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80020e9e:	04000537          	lui	a0,0x4000
    80020ea2:	157d                	addi	a0,a0,-1
    80020ea4:	0532                	slli	a0,a0,0xc
    80020ea6:	00000097          	auipc	ra,0x0
    80020eaa:	e44080e7          	jalr	-444(ra) # 80020cea <kvmmap>
}
    80020eae:	60e2                	ld	ra,24(sp)
    80020eb0:	6442                	ld	s0,16(sp)
    80020eb2:	64a2                	ld	s1,8(sp)
    80020eb4:	6105                	addi	sp,sp,32
    80020eb6:	8082                	ret

0000000080020eb8 <vmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
vmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80020eb8:	715d                	addi	sp,sp,-80
    80020eba:	e486                	sd	ra,72(sp)
    80020ebc:	e0a2                	sd	s0,64(sp)
    80020ebe:	fc26                	sd	s1,56(sp)
    80020ec0:	f84a                	sd	s2,48(sp)
    80020ec2:	f44e                	sd	s3,40(sp)
    80020ec4:	f052                	sd	s4,32(sp)
    80020ec6:	ec56                	sd	s5,24(sp)
    80020ec8:	e85a                	sd	s6,16(sp)
    80020eca:	e45e                	sd	s7,8(sp)
    80020ecc:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80020ece:	03459793          	slli	a5,a1,0x34
    80020ed2:	e795                	bnez	a5,80020efe <vmunmap+0x46>
    80020ed4:	8a2a                	mv	s4,a0
    80020ed6:	892e                	mv	s2,a1
    80020ed8:	8ab6                	mv	s5,a3
    panic("vmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020eda:	0632                	slli	a2,a2,0xc
    80020edc:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("vmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("vmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80020ee0:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020ee2:	6b05                	lui	s6,0x1
    80020ee4:	0735e263          	bltu	a1,s3,80020f48 <vmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80020ee8:	60a6                	ld	ra,72(sp)
    80020eea:	6406                	ld	s0,64(sp)
    80020eec:	74e2                	ld	s1,56(sp)
    80020eee:	7942                	ld	s2,48(sp)
    80020ef0:	79a2                	ld	s3,40(sp)
    80020ef2:	7a02                	ld	s4,32(sp)
    80020ef4:	6ae2                	ld	s5,24(sp)
    80020ef6:	6b42                	ld	s6,16(sp)
    80020ef8:	6ba2                	ld	s7,8(sp)
    80020efa:	6161                	addi	sp,sp,80
    80020efc:	8082                	ret
    panic("vmunmap: not aligned");
    80020efe:	0000a517          	auipc	a0,0xa
    80020f02:	43250513          	addi	a0,a0,1074 # 8002b330 <digits+0xa8>
    80020f06:	fffff097          	auipc	ra,0xfffff
    80020f0a:	23c080e7          	jalr	572(ra) # 80020142 <panic>
      panic("vmunmap: walk");
    80020f0e:	0000a517          	auipc	a0,0xa
    80020f12:	43a50513          	addi	a0,a0,1082 # 8002b348 <digits+0xc0>
    80020f16:	fffff097          	auipc	ra,0xfffff
    80020f1a:	22c080e7          	jalr	556(ra) # 80020142 <panic>
      panic("vmunmap: not mapped");
    80020f1e:	0000a517          	auipc	a0,0xa
    80020f22:	43a50513          	addi	a0,a0,1082 # 8002b358 <digits+0xd0>
    80020f26:	fffff097          	auipc	ra,0xfffff
    80020f2a:	21c080e7          	jalr	540(ra) # 80020142 <panic>
      panic("vmunmap: not a leaf");
    80020f2e:	0000a517          	auipc	a0,0xa
    80020f32:	44250513          	addi	a0,a0,1090 # 8002b370 <digits+0xe8>
    80020f36:	fffff097          	auipc	ra,0xfffff
    80020f3a:	20c080e7          	jalr	524(ra) # 80020142 <panic>
    *pte = 0;
    80020f3e:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020f42:	995a                	add	s2,s2,s6
    80020f44:	fb3972e3          	bgeu	s2,s3,80020ee8 <vmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80020f48:	4601                	li	a2,0
    80020f4a:	85ca                	mv	a1,s2
    80020f4c:	8552                	mv	a0,s4
    80020f4e:	00000097          	auipc	ra,0x0
    80020f52:	bae080e7          	jalr	-1106(ra) # 80020afc <walk>
    80020f56:	84aa                	mv	s1,a0
    80020f58:	d95d                	beqz	a0,80020f0e <vmunmap+0x56>
    if((*pte & PTE_V) == 0)
    80020f5a:	6108                	ld	a0,0(a0)
    80020f5c:	00157793          	andi	a5,a0,1
    80020f60:	dfdd                	beqz	a5,80020f1e <vmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    80020f62:	3ff57793          	andi	a5,a0,1023
    80020f66:	fd7784e3          	beq	a5,s7,80020f2e <vmunmap+0x76>
    if(do_free){
    80020f6a:	fc0a8ae3          	beqz	s5,80020f3e <vmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    80020f6e:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80020f70:	0532                	slli	a0,a0,0xc
    80020f72:	fffff097          	auipc	ra,0xfffff
    80020f76:	4bc080e7          	jalr	1212(ra) # 8002042e <kfree>
    80020f7a:	b7d1                	j	80020f3e <vmunmap+0x86>

0000000080020f7c <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80020f7c:	1101                	addi	sp,sp,-32
    80020f7e:	ec06                	sd	ra,24(sp)
    80020f80:	e822                	sd	s0,16(sp)
    80020f82:	e426                	sd	s1,8(sp)
    80020f84:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80020f86:	fffff097          	auipc	ra,0xfffff
    80020f8a:	5c0080e7          	jalr	1472(ra) # 80020546 <kalloc>
    80020f8e:	84aa                	mv	s1,a0
  if(pagetable == NULL)
    80020f90:	c519                	beqz	a0,80020f9e <uvmcreate+0x22>
    return NULL;
  memset(pagetable, 0, PGSIZE);
    80020f92:	6605                	lui	a2,0x1
    80020f94:	4581                	li	a1,0
    80020f96:	fffff097          	auipc	ra,0xfffff
    80020f9a:	7b8080e7          	jalr	1976(ra) # 8002074e <memset>
  return pagetable;
}
    80020f9e:	8526                	mv	a0,s1
    80020fa0:	60e2                	ld	ra,24(sp)
    80020fa2:	6442                	ld	s0,16(sp)
    80020fa4:	64a2                	ld	s1,8(sp)
    80020fa6:	6105                	addi	sp,sp,32
    80020fa8:	8082                	ret

0000000080020faa <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, pagetable_t kpagetable, uchar *src, uint sz)
{
    80020faa:	7139                	addi	sp,sp,-64
    80020fac:	fc06                	sd	ra,56(sp)
    80020fae:	f822                	sd	s0,48(sp)
    80020fb0:	f426                	sd	s1,40(sp)
    80020fb2:	f04a                	sd	s2,32(sp)
    80020fb4:	ec4e                	sd	s3,24(sp)
    80020fb6:	e852                	sd	s4,16(sp)
    80020fb8:	e456                	sd	s5,8(sp)
    80020fba:	0080                	addi	s0,sp,64
  char *mem;

  if(sz >= PGSIZE)
    80020fbc:	6785                	lui	a5,0x1
    80020fbe:	06f6f363          	bgeu	a3,a5,80021024 <uvminit+0x7a>
    80020fc2:	8aaa                	mv	s5,a0
    80020fc4:	8a2e                	mv	s4,a1
    80020fc6:	89b2                	mv	s3,a2
    80020fc8:	8936                	mv	s2,a3
    panic("inituvm: more than a page");
  mem = kalloc();
    80020fca:	fffff097          	auipc	ra,0xfffff
    80020fce:	57c080e7          	jalr	1404(ra) # 80020546 <kalloc>
    80020fd2:	84aa                	mv	s1,a0
  // printf("[uvminit]kalloc: %p\n", mem);
  memset(mem, 0, PGSIZE);
    80020fd4:	6605                	lui	a2,0x1
    80020fd6:	4581                	li	a1,0
    80020fd8:	fffff097          	auipc	ra,0xfffff
    80020fdc:	776080e7          	jalr	1910(ra) # 8002074e <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80020fe0:	4779                	li	a4,30
    80020fe2:	86a6                	mv	a3,s1
    80020fe4:	6605                	lui	a2,0x1
    80020fe6:	4581                	li	a1,0
    80020fe8:	8556                	mv	a0,s5
    80020fea:	00000097          	auipc	ra,0x0
    80020fee:	c72080e7          	jalr	-910(ra) # 80020c5c <mappages>
  mappages(kpagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X);
    80020ff2:	4739                	li	a4,14
    80020ff4:	86a6                	mv	a3,s1
    80020ff6:	6605                	lui	a2,0x1
    80020ff8:	4581                	li	a1,0
    80020ffa:	8552                	mv	a0,s4
    80020ffc:	00000097          	auipc	ra,0x0
    80021000:	c60080e7          	jalr	-928(ra) # 80020c5c <mappages>
  memmove(mem, src, sz);
    80021004:	864a                	mv	a2,s2
    80021006:	85ce                	mv	a1,s3
    80021008:	8526                	mv	a0,s1
    8002100a:	fffff097          	auipc	ra,0xfffff
    8002100e:	7a0080e7          	jalr	1952(ra) # 800207aa <memmove>
  // for (int i = 0; i < sz; i ++) {
  //   printf("[uvminit]mem: %p, %x\n", mem + i, mem[i]);
  // }
}
    80021012:	70e2                	ld	ra,56(sp)
    80021014:	7442                	ld	s0,48(sp)
    80021016:	74a2                	ld	s1,40(sp)
    80021018:	7902                	ld	s2,32(sp)
    8002101a:	69e2                	ld	s3,24(sp)
    8002101c:	6a42                	ld	s4,16(sp)
    8002101e:	6aa2                	ld	s5,8(sp)
    80021020:	6121                	addi	sp,sp,64
    80021022:	8082                	ret
    panic("inituvm: more than a page");
    80021024:	0000a517          	auipc	a0,0xa
    80021028:	36450513          	addi	a0,a0,868 # 8002b388 <digits+0x100>
    8002102c:	fffff097          	auipc	ra,0xfffff
    80021030:	116080e7          	jalr	278(ra) # 80020142 <panic>

0000000080021034 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, pagetable_t kpagetable, uint64 oldsz, uint64 newsz)
{
    80021034:	7179                	addi	sp,sp,-48
    80021036:	f406                	sd	ra,40(sp)
    80021038:	f022                	sd	s0,32(sp)
    8002103a:	ec26                	sd	s1,24(sp)
    8002103c:	e84a                	sd	s2,16(sp)
    8002103e:	e44e                	sd	s3,8(sp)
    80021040:	e052                	sd	s4,0(sp)
    80021042:	1800                	addi	s0,sp,48
  if(newsz >= oldsz)
    return oldsz;
    80021044:	8932                	mv	s2,a2
  if(newsz >= oldsz)
    80021046:	02c6f063          	bgeu	a3,a2,80021066 <uvmdealloc+0x32>
    8002104a:	89aa                	mv	s3,a0
    8002104c:	852e                	mv	a0,a1
    8002104e:	8936                	mv	s2,a3

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80021050:	6785                	lui	a5,0x1
    80021052:	17fd                	addi	a5,a5,-1
    80021054:	00f68a33          	add	s4,a3,a5
    80021058:	777d                	lui	a4,0xfffff
    8002105a:	00ea7a33          	and	s4,s4,a4
    8002105e:	963e                	add	a2,a2,a5
    80021060:	8e79                	and	a2,a2,a4
    80021062:	00ca6b63          	bltu	s4,a2,80021078 <uvmdealloc+0x44>
    vmunmap(kpagetable, PGROUNDUP(newsz), npages, 0);
    vmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80021066:	854a                	mv	a0,s2
    80021068:	70a2                	ld	ra,40(sp)
    8002106a:	7402                	ld	s0,32(sp)
    8002106c:	64e2                	ld	s1,24(sp)
    8002106e:	6942                	ld	s2,16(sp)
    80021070:	69a2                	ld	s3,8(sp)
    80021072:	6a02                	ld	s4,0(sp)
    80021074:	6145                	addi	sp,sp,48
    80021076:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80021078:	414604b3          	sub	s1,a2,s4
    8002107c:	80b1                	srli	s1,s1,0xc
    vmunmap(kpagetable, PGROUNDUP(newsz), npages, 0);
    8002107e:	2481                	sext.w	s1,s1
    80021080:	4681                	li	a3,0
    80021082:	8626                	mv	a2,s1
    80021084:	85d2                	mv	a1,s4
    80021086:	00000097          	auipc	ra,0x0
    8002108a:	e32080e7          	jalr	-462(ra) # 80020eb8 <vmunmap>
    vmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    8002108e:	4685                	li	a3,1
    80021090:	8626                	mv	a2,s1
    80021092:	85d2                	mv	a1,s4
    80021094:	854e                	mv	a0,s3
    80021096:	00000097          	auipc	ra,0x0
    8002109a:	e22080e7          	jalr	-478(ra) # 80020eb8 <vmunmap>
    8002109e:	b7e1                	j	80021066 <uvmdealloc+0x32>

00000000800210a0 <uvmalloc>:
  if(newsz < oldsz)
    800210a0:	0ec6e763          	bltu	a3,a2,8002118e <uvmalloc+0xee>
{
    800210a4:	7139                	addi	sp,sp,-64
    800210a6:	fc06                	sd	ra,56(sp)
    800210a8:	f822                	sd	s0,48(sp)
    800210aa:	f426                	sd	s1,40(sp)
    800210ac:	f04a                	sd	s2,32(sp)
    800210ae:	ec4e                	sd	s3,24(sp)
    800210b0:	e852                	sd	s4,16(sp)
    800210b2:	e456                	sd	s5,8(sp)
    800210b4:	e05a                	sd	s6,0(sp)
    800210b6:	0080                	addi	s0,sp,64
    800210b8:	8a2a                	mv	s4,a0
    800210ba:	8aae                	mv	s5,a1
    800210bc:	8b36                	mv	s6,a3
  oldsz = PGROUNDUP(oldsz);
    800210be:	6985                	lui	s3,0x1
    800210c0:	19fd                	addi	s3,s3,-1
    800210c2:	964e                	add	a2,a2,s3
    800210c4:	79fd                	lui	s3,0xfffff
    800210c6:	013679b3          	and	s3,a2,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    800210ca:	0cd9f463          	bgeu	s3,a3,80021192 <uvmalloc+0xf2>
    800210ce:	894e                	mv	s2,s3
    mem = kalloc();
    800210d0:	fffff097          	auipc	ra,0xfffff
    800210d4:	476080e7          	jalr	1142(ra) # 80020546 <kalloc>
    800210d8:	84aa                	mv	s1,a0
    if(mem == NULL){
    800210da:	c129                	beqz	a0,8002111c <uvmalloc+0x7c>
    memset(mem, 0, PGSIZE);
    800210dc:	6605                	lui	a2,0x1
    800210de:	4581                	li	a1,0
    800210e0:	fffff097          	auipc	ra,0xfffff
    800210e4:	66e080e7          	jalr	1646(ra) # 8002074e <memset>
    if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0) {
    800210e8:	4779                	li	a4,30
    800210ea:	86a6                	mv	a3,s1
    800210ec:	6605                	lui	a2,0x1
    800210ee:	85ca                	mv	a1,s2
    800210f0:	8552                	mv	a0,s4
    800210f2:	00000097          	auipc	ra,0x0
    800210f6:	b6a080e7          	jalr	-1174(ra) # 80020c5c <mappages>
    800210fa:	e521                	bnez	a0,80021142 <uvmalloc+0xa2>
    if (mappages(kpagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R) != 0){
    800210fc:	4739                	li	a4,14
    800210fe:	86a6                	mv	a3,s1
    80021100:	6605                	lui	a2,0x1
    80021102:	85ca                	mv	a1,s2
    80021104:	8556                	mv	a0,s5
    80021106:	00000097          	auipc	ra,0x0
    8002110a:	b56080e7          	jalr	-1194(ra) # 80020c5c <mappages>
    8002110e:	e929                	bnez	a0,80021160 <uvmalloc+0xc0>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80021110:	6785                	lui	a5,0x1
    80021112:	993e                	add	s2,s2,a5
    80021114:	fb696ee3          	bltu	s2,s6,800210d0 <uvmalloc+0x30>
  return newsz;
    80021118:	855a                	mv	a0,s6
    8002111a:	a811                	j	8002112e <uvmalloc+0x8e>
      uvmdealloc(pagetable, kpagetable, a, oldsz);
    8002111c:	86ce                	mv	a3,s3
    8002111e:	864a                	mv	a2,s2
    80021120:	85d6                	mv	a1,s5
    80021122:	8552                	mv	a0,s4
    80021124:	00000097          	auipc	ra,0x0
    80021128:	f10080e7          	jalr	-240(ra) # 80021034 <uvmdealloc>
      return 0;
    8002112c:	4501                	li	a0,0
}
    8002112e:	70e2                	ld	ra,56(sp)
    80021130:	7442                	ld	s0,48(sp)
    80021132:	74a2                	ld	s1,40(sp)
    80021134:	7902                	ld	s2,32(sp)
    80021136:	69e2                	ld	s3,24(sp)
    80021138:	6a42                	ld	s4,16(sp)
    8002113a:	6aa2                	ld	s5,8(sp)
    8002113c:	6b02                	ld	s6,0(sp)
    8002113e:	6121                	addi	sp,sp,64
    80021140:	8082                	ret
      kfree(mem);
    80021142:	8526                	mv	a0,s1
    80021144:	fffff097          	auipc	ra,0xfffff
    80021148:	2ea080e7          	jalr	746(ra) # 8002042e <kfree>
      uvmdealloc(pagetable, kpagetable, a, oldsz);
    8002114c:	86ce                	mv	a3,s3
    8002114e:	864a                	mv	a2,s2
    80021150:	85d6                	mv	a1,s5
    80021152:	8552                	mv	a0,s4
    80021154:	00000097          	auipc	ra,0x0
    80021158:	ee0080e7          	jalr	-288(ra) # 80021034 <uvmdealloc>
      return 0;
    8002115c:	4501                	li	a0,0
    8002115e:	bfc1                	j	8002112e <uvmalloc+0x8e>
      int npages = (a - oldsz) / PGSIZE;
    80021160:	41390633          	sub	a2,s2,s3
    80021164:	8231                	srli	a2,a2,0xc
    80021166:	0006049b          	sext.w	s1,a2
      vmunmap(pagetable, oldsz, npages + 1, 1);   // plus the page allocated above.
    8002116a:	4685                	li	a3,1
    8002116c:	2605                	addiw	a2,a2,1
    8002116e:	85ce                	mv	a1,s3
    80021170:	8552                	mv	a0,s4
    80021172:	00000097          	auipc	ra,0x0
    80021176:	d46080e7          	jalr	-698(ra) # 80020eb8 <vmunmap>
      vmunmap(kpagetable, oldsz, npages, 0);
    8002117a:	4681                	li	a3,0
    8002117c:	8626                	mv	a2,s1
    8002117e:	85ce                	mv	a1,s3
    80021180:	8556                	mv	a0,s5
    80021182:	00000097          	auipc	ra,0x0
    80021186:	d36080e7          	jalr	-714(ra) # 80020eb8 <vmunmap>
      return 0;
    8002118a:	4501                	li	a0,0
    8002118c:	b74d                	j	8002112e <uvmalloc+0x8e>
    return oldsz;
    8002118e:	8532                	mv	a0,a2
}
    80021190:	8082                	ret
  return newsz;
    80021192:	8536                	mv	a0,a3
    80021194:	bf69                	j	8002112e <uvmalloc+0x8e>

0000000080021196 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80021196:	7179                	addi	sp,sp,-48
    80021198:	f406                	sd	ra,40(sp)
    8002119a:	f022                	sd	s0,32(sp)
    8002119c:	ec26                	sd	s1,24(sp)
    8002119e:	e84a                	sd	s2,16(sp)
    800211a0:	e44e                	sd	s3,8(sp)
    800211a2:	e052                	sd	s4,0(sp)
    800211a4:	1800                	addi	s0,sp,48
    800211a6:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800211a8:	84aa                	mv	s1,a0
    800211aa:	6905                	lui	s2,0x1
    800211ac:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800211ae:	4985                	li	s3,1
    800211b0:	a821                	j	800211c8 <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800211b2:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    800211b4:	0532                	slli	a0,a0,0xc
    800211b6:	00000097          	auipc	ra,0x0
    800211ba:	fe0080e7          	jalr	-32(ra) # 80021196 <freewalk>
      pagetable[i] = 0;
    800211be:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800211c2:	04a1                	addi	s1,s1,8
    800211c4:	03248163          	beq	s1,s2,800211e6 <freewalk+0x50>
    pte_t pte = pagetable[i];
    800211c8:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800211ca:	00f57793          	andi	a5,a0,15
    800211ce:	ff3782e3          	beq	a5,s3,800211b2 <freewalk+0x1c>
    } else if(pte & PTE_V){
    800211d2:	8905                	andi	a0,a0,1
    800211d4:	d57d                	beqz	a0,800211c2 <freewalk+0x2c>
      panic("freewalk: leaf");
    800211d6:	0000a517          	auipc	a0,0xa
    800211da:	1d250513          	addi	a0,a0,466 # 8002b3a8 <digits+0x120>
    800211de:	fffff097          	auipc	ra,0xfffff
    800211e2:	f64080e7          	jalr	-156(ra) # 80020142 <panic>
    }
  }
  kfree((void*)pagetable);
    800211e6:	8552                	mv	a0,s4
    800211e8:	fffff097          	auipc	ra,0xfffff
    800211ec:	246080e7          	jalr	582(ra) # 8002042e <kfree>
}
    800211f0:	70a2                	ld	ra,40(sp)
    800211f2:	7402                	ld	s0,32(sp)
    800211f4:	64e2                	ld	s1,24(sp)
    800211f6:	6942                	ld	s2,16(sp)
    800211f8:	69a2                	ld	s3,8(sp)
    800211fa:	6a02                	ld	s4,0(sp)
    800211fc:	6145                	addi	sp,sp,48
    800211fe:	8082                	ret

0000000080021200 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80021200:	1101                	addi	sp,sp,-32
    80021202:	ec06                	sd	ra,24(sp)
    80021204:	e822                	sd	s0,16(sp)
    80021206:	e426                	sd	s1,8(sp)
    80021208:	1000                	addi	s0,sp,32
    8002120a:	84aa                	mv	s1,a0
  if(sz > 0)
    8002120c:	e999                	bnez	a1,80021222 <uvmfree+0x22>
    vmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    8002120e:	8526                	mv	a0,s1
    80021210:	00000097          	auipc	ra,0x0
    80021214:	f86080e7          	jalr	-122(ra) # 80021196 <freewalk>
}
    80021218:	60e2                	ld	ra,24(sp)
    8002121a:	6442                	ld	s0,16(sp)
    8002121c:	64a2                	ld	s1,8(sp)
    8002121e:	6105                	addi	sp,sp,32
    80021220:	8082                	ret
    vmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80021222:	6605                	lui	a2,0x1
    80021224:	167d                	addi	a2,a2,-1
    80021226:	962e                	add	a2,a2,a1
    80021228:	4685                	li	a3,1
    8002122a:	8231                	srli	a2,a2,0xc
    8002122c:	4581                	li	a1,0
    8002122e:	00000097          	auipc	ra,0x0
    80021232:	c8a080e7          	jalr	-886(ra) # 80020eb8 <vmunmap>
    80021236:	bfe1                	j	8002120e <uvmfree+0xe>

0000000080021238 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i = 0, ki = 0;
  uint flags;
  char *mem;

  while (i < sz){
    80021238:	10068563          	beqz	a3,80021342 <uvmcopy+0x10a>
{
    8002123c:	715d                	addi	sp,sp,-80
    8002123e:	e486                	sd	ra,72(sp)
    80021240:	e0a2                	sd	s0,64(sp)
    80021242:	fc26                	sd	s1,56(sp)
    80021244:	f84a                	sd	s2,48(sp)
    80021246:	f44e                	sd	s3,40(sp)
    80021248:	f052                	sd	s4,32(sp)
    8002124a:	ec56                	sd	s5,24(sp)
    8002124c:	e85a                	sd	s6,16(sp)
    8002124e:	e45e                	sd	s7,8(sp)
    80021250:	e062                	sd	s8,0(sp)
    80021252:	0880                	addi	s0,sp,80
    80021254:	8baa                	mv	s7,a0
    80021256:	8a2e                	mv	s4,a1
    80021258:	8b32                	mv	s6,a2
    8002125a:	8ab6                	mv	s5,a3
  uint64 pa, i = 0, ki = 0;
    8002125c:	4981                	li	s3,0
    8002125e:	a011                	j	80021262 <uvmcopy+0x2a>
    memmove(mem, (char*)pa, PGSIZE);
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) {
      kfree(mem);
      goto err;
    }
    i += PGSIZE;
    80021260:	89e2                	mv	s3,s8
    if((pte = walk(old, i, 0)) == NULL)
    80021262:	4601                	li	a2,0
    80021264:	85ce                	mv	a1,s3
    80021266:	855e                	mv	a0,s7
    80021268:	00000097          	auipc	ra,0x0
    8002126c:	894080e7          	jalr	-1900(ra) # 80020afc <walk>
    80021270:	c135                	beqz	a0,800212d4 <uvmcopy+0x9c>
    if((*pte & PTE_V) == 0)
    80021272:	6118                	ld	a4,0(a0)
    80021274:	00177793          	andi	a5,a4,1
    80021278:	c7b5                	beqz	a5,800212e4 <uvmcopy+0xac>
    pa = PTE2PA(*pte);
    8002127a:	00a75593          	srli	a1,a4,0xa
    8002127e:	00c59c13          	slli	s8,a1,0xc
    flags = PTE_FLAGS(*pte);
    80021282:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == NULL)
    80021286:	fffff097          	auipc	ra,0xfffff
    8002128a:	2c0080e7          	jalr	704(ra) # 80020546 <kalloc>
    8002128e:	892a                	mv	s2,a0
    80021290:	c92d                	beqz	a0,80021302 <uvmcopy+0xca>
    memmove(mem, (char*)pa, PGSIZE);
    80021292:	6605                	lui	a2,0x1
    80021294:	85e2                	mv	a1,s8
    80021296:	fffff097          	auipc	ra,0xfffff
    8002129a:	514080e7          	jalr	1300(ra) # 800207aa <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) {
    8002129e:	2481                	sext.w	s1,s1
    800212a0:	8726                	mv	a4,s1
    800212a2:	86ca                	mv	a3,s2
    800212a4:	6605                	lui	a2,0x1
    800212a6:	85ce                	mv	a1,s3
    800212a8:	8552                	mv	a0,s4
    800212aa:	00000097          	auipc	ra,0x0
    800212ae:	9b2080e7          	jalr	-1614(ra) # 80020c5c <mappages>
    800212b2:	e129                	bnez	a0,800212f4 <uvmcopy+0xbc>
    i += PGSIZE;
    800212b4:	6c05                	lui	s8,0x1
    800212b6:	9c4e                	add	s8,s8,s3
    if(mappages(knew, ki, PGSIZE, (uint64)mem, flags & ~PTE_U) != 0){
    800212b8:	3ef4f713          	andi	a4,s1,1007
    800212bc:	86ca                	mv	a3,s2
    800212be:	6605                	lui	a2,0x1
    800212c0:	85ce                	mv	a1,s3
    800212c2:	855a                	mv	a0,s6
    800212c4:	00000097          	auipc	ra,0x0
    800212c8:	998080e7          	jalr	-1640(ra) # 80020c5c <mappages>
    800212cc:	ed05                	bnez	a0,80021304 <uvmcopy+0xcc>
  while (i < sz){
    800212ce:	f95c69e3          	bltu	s8,s5,80021260 <uvmcopy+0x28>
    800212d2:	a8a1                	j	8002132a <uvmcopy+0xf2>
      panic("uvmcopy: pte should exist");
    800212d4:	0000a517          	auipc	a0,0xa
    800212d8:	0e450513          	addi	a0,a0,228 # 8002b3b8 <digits+0x130>
    800212dc:	fffff097          	auipc	ra,0xfffff
    800212e0:	e66080e7          	jalr	-410(ra) # 80020142 <panic>
      panic("uvmcopy: page not present");
    800212e4:	0000a517          	auipc	a0,0xa
    800212e8:	0f450513          	addi	a0,a0,244 # 8002b3d8 <digits+0x150>
    800212ec:	fffff097          	auipc	ra,0xfffff
    800212f0:	e56080e7          	jalr	-426(ra) # 80020142 <panic>
      kfree(mem);
    800212f4:	854a                	mv	a0,s2
    800212f6:	fffff097          	auipc	ra,0xfffff
    800212fa:	138080e7          	jalr	312(ra) # 8002042e <kfree>
      goto err;
    800212fe:	8c4e                	mv	s8,s3
    80021300:	a011                	j	80021304 <uvmcopy+0xcc>
    80021302:	8c4e                	mv	s8,s3
    ki += PGSIZE;
  }
  return 0;

 err:
  vmunmap(knew, 0, ki / PGSIZE, 0);
    80021304:	4681                	li	a3,0
    80021306:	00c9d613          	srli	a2,s3,0xc
    8002130a:	4581                	li	a1,0
    8002130c:	855a                	mv	a0,s6
    8002130e:	00000097          	auipc	ra,0x0
    80021312:	baa080e7          	jalr	-1110(ra) # 80020eb8 <vmunmap>
  vmunmap(new, 0, i / PGSIZE, 1);
    80021316:	4685                	li	a3,1
    80021318:	00cc5613          	srli	a2,s8,0xc
    8002131c:	4581                	li	a1,0
    8002131e:	8552                	mv	a0,s4
    80021320:	00000097          	auipc	ra,0x0
    80021324:	b98080e7          	jalr	-1128(ra) # 80020eb8 <vmunmap>
  return -1;
    80021328:	557d                	li	a0,-1
}
    8002132a:	60a6                	ld	ra,72(sp)
    8002132c:	6406                	ld	s0,64(sp)
    8002132e:	74e2                	ld	s1,56(sp)
    80021330:	7942                	ld	s2,48(sp)
    80021332:	79a2                	ld	s3,40(sp)
    80021334:	7a02                	ld	s4,32(sp)
    80021336:	6ae2                	ld	s5,24(sp)
    80021338:	6b42                	ld	s6,16(sp)
    8002133a:	6ba2                	ld	s7,8(sp)
    8002133c:	6c02                	ld	s8,0(sp)
    8002133e:	6161                	addi	sp,sp,80
    80021340:	8082                	ret
  return 0;
    80021342:	4501                	li	a0,0
}
    80021344:	8082                	ret

0000000080021346 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80021346:	1141                	addi	sp,sp,-16
    80021348:	e406                	sd	ra,8(sp)
    8002134a:	e022                	sd	s0,0(sp)
    8002134c:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8002134e:	4601                	li	a2,0
    80021350:	fffff097          	auipc	ra,0xfffff
    80021354:	7ac080e7          	jalr	1964(ra) # 80020afc <walk>
  if(pte == NULL)
    80021358:	c901                	beqz	a0,80021368 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8002135a:	611c                	ld	a5,0(a0)
    8002135c:	9bbd                	andi	a5,a5,-17
    8002135e:	e11c                	sd	a5,0(a0)
}
    80021360:	60a2                	ld	ra,8(sp)
    80021362:	6402                	ld	s0,0(sp)
    80021364:	0141                	addi	sp,sp,16
    80021366:	8082                	ret
    panic("uvmclear");
    80021368:	0000a517          	auipc	a0,0xa
    8002136c:	09050513          	addi	a0,a0,144 # 8002b3f8 <digits+0x170>
    80021370:	fffff097          	auipc	ra,0xfffff
    80021374:	dd2080e7          	jalr	-558(ra) # 80020142 <panic>

0000000080021378 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80021378:	c6bd                	beqz	a3,800213e6 <copyout+0x6e>
{
    8002137a:	715d                	addi	sp,sp,-80
    8002137c:	e486                	sd	ra,72(sp)
    8002137e:	e0a2                	sd	s0,64(sp)
    80021380:	fc26                	sd	s1,56(sp)
    80021382:	f84a                	sd	s2,48(sp)
    80021384:	f44e                	sd	s3,40(sp)
    80021386:	f052                	sd	s4,32(sp)
    80021388:	ec56                	sd	s5,24(sp)
    8002138a:	e85a                	sd	s6,16(sp)
    8002138c:	e45e                	sd	s7,8(sp)
    8002138e:	e062                	sd	s8,0(sp)
    80021390:	0880                	addi	s0,sp,80
    80021392:	8b2a                	mv	s6,a0
    80021394:	8c2e                	mv	s8,a1
    80021396:	8a32                	mv	s4,a2
    80021398:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    8002139a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == NULL)
      return -1;
    n = PGSIZE - (dstva - va0);
    8002139c:	6a85                	lui	s5,0x1
    8002139e:	a015                	j	800213c2 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    800213a0:	9562                	add	a0,a0,s8
    800213a2:	0004861b          	sext.w	a2,s1
    800213a6:	85d2                	mv	a1,s4
    800213a8:	41250533          	sub	a0,a0,s2
    800213ac:	fffff097          	auipc	ra,0xfffff
    800213b0:	3fe080e7          	jalr	1022(ra) # 800207aa <memmove>

    len -= n;
    800213b4:	409989b3          	sub	s3,s3,s1
    src += n;
    800213b8:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    800213ba:	01590c33          	add	s8,s2,s5
  while(len > 0){
    800213be:	02098263          	beqz	s3,800213e2 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    800213c2:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800213c6:	85ca                	mv	a1,s2
    800213c8:	855a                	mv	a0,s6
    800213ca:	fffff097          	auipc	ra,0xfffff
    800213ce:	7d8080e7          	jalr	2008(ra) # 80020ba2 <walkaddr>
    if(pa0 == NULL)
    800213d2:	cd01                	beqz	a0,800213ea <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    800213d4:	418904b3          	sub	s1,s2,s8
    800213d8:	94d6                	add	s1,s1,s5
    if(n > len)
    800213da:	fc99f3e3          	bgeu	s3,s1,800213a0 <copyout+0x28>
    800213de:	84ce                	mv	s1,s3
    800213e0:	b7c1                	j	800213a0 <copyout+0x28>
  }
  return 0;
    800213e2:	4501                	li	a0,0
    800213e4:	a021                	j	800213ec <copyout+0x74>
    800213e6:	4501                	li	a0,0
}
    800213e8:	8082                	ret
      return -1;
    800213ea:	557d                	li	a0,-1
}
    800213ec:	60a6                	ld	ra,72(sp)
    800213ee:	6406                	ld	s0,64(sp)
    800213f0:	74e2                	ld	s1,56(sp)
    800213f2:	7942                	ld	s2,48(sp)
    800213f4:	79a2                	ld	s3,40(sp)
    800213f6:	7a02                	ld	s4,32(sp)
    800213f8:	6ae2                	ld	s5,24(sp)
    800213fa:	6b42                	ld	s6,16(sp)
    800213fc:	6ba2                	ld	s7,8(sp)
    800213fe:	6c02                	ld	s8,0(sp)
    80021400:	6161                	addi	sp,sp,80
    80021402:	8082                	ret

0000000080021404 <copyout2>:

int
copyout2(uint64 dstva, char *src, uint64 len)
{
    80021404:	7179                	addi	sp,sp,-48
    80021406:	f406                	sd	ra,40(sp)
    80021408:	f022                	sd	s0,32(sp)
    8002140a:	ec26                	sd	s1,24(sp)
    8002140c:	e84a                	sd	s2,16(sp)
    8002140e:	e44e                	sd	s3,8(sp)
    80021410:	1800                	addi	s0,sp,48
    80021412:	84aa                	mv	s1,a0
    80021414:	89ae                	mv	s3,a1
    80021416:	8932                	mv	s2,a2
  uint64 sz = myproc()->sz;
    80021418:	00000097          	auipc	ra,0x0
    8002141c:	6ba080e7          	jalr	1722(ra) # 80021ad2 <myproc>
    80021420:	653c                	ld	a5,72(a0)
  if (dstva + len > sz || dstva >= sz) {
    80021422:	01248733          	add	a4,s1,s2
    80021426:	02e7e463          	bltu	a5,a4,8002144e <copyout2+0x4a>
    8002142a:	02f4f463          	bgeu	s1,a5,80021452 <copyout2+0x4e>
    return -1;
  }
  memmove((void *)dstva, src, len);
    8002142e:	0009061b          	sext.w	a2,s2
    80021432:	85ce                	mv	a1,s3
    80021434:	8526                	mv	a0,s1
    80021436:	fffff097          	auipc	ra,0xfffff
    8002143a:	374080e7          	jalr	884(ra) # 800207aa <memmove>
  return 0;
    8002143e:	4501                	li	a0,0
}
    80021440:	70a2                	ld	ra,40(sp)
    80021442:	7402                	ld	s0,32(sp)
    80021444:	64e2                	ld	s1,24(sp)
    80021446:	6942                	ld	s2,16(sp)
    80021448:	69a2                	ld	s3,8(sp)
    8002144a:	6145                	addi	sp,sp,48
    8002144c:	8082                	ret
    return -1;
    8002144e:	557d                	li	a0,-1
    80021450:	bfc5                	j	80021440 <copyout2+0x3c>
    80021452:	557d                	li	a0,-1
    80021454:	b7f5                	j	80021440 <copyout2+0x3c>

0000000080021456 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80021456:	caa5                	beqz	a3,800214c6 <copyin+0x70>
{
    80021458:	715d                	addi	sp,sp,-80
    8002145a:	e486                	sd	ra,72(sp)
    8002145c:	e0a2                	sd	s0,64(sp)
    8002145e:	fc26                	sd	s1,56(sp)
    80021460:	f84a                	sd	s2,48(sp)
    80021462:	f44e                	sd	s3,40(sp)
    80021464:	f052                	sd	s4,32(sp)
    80021466:	ec56                	sd	s5,24(sp)
    80021468:	e85a                	sd	s6,16(sp)
    8002146a:	e45e                	sd	s7,8(sp)
    8002146c:	e062                	sd	s8,0(sp)
    8002146e:	0880                	addi	s0,sp,80
    80021470:	8b2a                	mv	s6,a0
    80021472:	8a2e                	mv	s4,a1
    80021474:	8c32                	mv	s8,a2
    80021476:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80021478:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == NULL)
      return -1;
    n = PGSIZE - (srcva - va0);
    8002147a:	6a85                	lui	s5,0x1
    8002147c:	a01d                	j	800214a2 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8002147e:	018505b3          	add	a1,a0,s8
    80021482:	0004861b          	sext.w	a2,s1
    80021486:	412585b3          	sub	a1,a1,s2
    8002148a:	8552                	mv	a0,s4
    8002148c:	fffff097          	auipc	ra,0xfffff
    80021490:	31e080e7          	jalr	798(ra) # 800207aa <memmove>

    len -= n;
    80021494:	409989b3          	sub	s3,s3,s1
    dst += n;
    80021498:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    8002149a:	01590c33          	add	s8,s2,s5
  while(len > 0){
    8002149e:	02098263          	beqz	s3,800214c2 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    800214a2:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800214a6:	85ca                	mv	a1,s2
    800214a8:	855a                	mv	a0,s6
    800214aa:	fffff097          	auipc	ra,0xfffff
    800214ae:	6f8080e7          	jalr	1784(ra) # 80020ba2 <walkaddr>
    if(pa0 == NULL)
    800214b2:	cd01                	beqz	a0,800214ca <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    800214b4:	418904b3          	sub	s1,s2,s8
    800214b8:	94d6                	add	s1,s1,s5
    if(n > len)
    800214ba:	fc99f2e3          	bgeu	s3,s1,8002147e <copyin+0x28>
    800214be:	84ce                	mv	s1,s3
    800214c0:	bf7d                	j	8002147e <copyin+0x28>
  }
  return 0;
    800214c2:	4501                	li	a0,0
    800214c4:	a021                	j	800214cc <copyin+0x76>
    800214c6:	4501                	li	a0,0
}
    800214c8:	8082                	ret
      return -1;
    800214ca:	557d                	li	a0,-1
}
    800214cc:	60a6                	ld	ra,72(sp)
    800214ce:	6406                	ld	s0,64(sp)
    800214d0:	74e2                	ld	s1,56(sp)
    800214d2:	7942                	ld	s2,48(sp)
    800214d4:	79a2                	ld	s3,40(sp)
    800214d6:	7a02                	ld	s4,32(sp)
    800214d8:	6ae2                	ld	s5,24(sp)
    800214da:	6b42                	ld	s6,16(sp)
    800214dc:	6ba2                	ld	s7,8(sp)
    800214de:	6c02                	ld	s8,0(sp)
    800214e0:	6161                	addi	sp,sp,80
    800214e2:	8082                	ret

00000000800214e4 <copyin2>:

int
copyin2(char *dst, uint64 srcva, uint64 len)
{
    800214e4:	7179                	addi	sp,sp,-48
    800214e6:	f406                	sd	ra,40(sp)
    800214e8:	f022                	sd	s0,32(sp)
    800214ea:	ec26                	sd	s1,24(sp)
    800214ec:	e84a                	sd	s2,16(sp)
    800214ee:	e44e                	sd	s3,8(sp)
    800214f0:	1800                	addi	s0,sp,48
    800214f2:	89aa                	mv	s3,a0
    800214f4:	84ae                	mv	s1,a1
    800214f6:	8932                	mv	s2,a2
  uint64 sz = myproc()->sz;
    800214f8:	00000097          	auipc	ra,0x0
    800214fc:	5da080e7          	jalr	1498(ra) # 80021ad2 <myproc>
    80021500:	653c                	ld	a5,72(a0)
  if (srcva + len > sz || srcva >= sz) {
    80021502:	01248733          	add	a4,s1,s2
    80021506:	02e7e463          	bltu	a5,a4,8002152e <copyin2+0x4a>
    8002150a:	02f4f463          	bgeu	s1,a5,80021532 <copyin2+0x4e>
    return -1;
  }
  memmove(dst, (void *)srcva, len);
    8002150e:	0009061b          	sext.w	a2,s2
    80021512:	85a6                	mv	a1,s1
    80021514:	854e                	mv	a0,s3
    80021516:	fffff097          	auipc	ra,0xfffff
    8002151a:	294080e7          	jalr	660(ra) # 800207aa <memmove>
  return 0;
    8002151e:	4501                	li	a0,0
}
    80021520:	70a2                	ld	ra,40(sp)
    80021522:	7402                	ld	s0,32(sp)
    80021524:	64e2                	ld	s1,24(sp)
    80021526:	6942                	ld	s2,16(sp)
    80021528:	69a2                	ld	s3,8(sp)
    8002152a:	6145                	addi	sp,sp,48
    8002152c:	8082                	ret
    return -1;
    8002152e:	557d                	li	a0,-1
    80021530:	bfc5                	j	80021520 <copyin2+0x3c>
    80021532:	557d                	li	a0,-1
    80021534:	b7f5                	j	80021520 <copyin2+0x3c>

0000000080021536 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80021536:	c6c5                	beqz	a3,800215de <copyinstr+0xa8>
{
    80021538:	715d                	addi	sp,sp,-80
    8002153a:	e486                	sd	ra,72(sp)
    8002153c:	e0a2                	sd	s0,64(sp)
    8002153e:	fc26                	sd	s1,56(sp)
    80021540:	f84a                	sd	s2,48(sp)
    80021542:	f44e                	sd	s3,40(sp)
    80021544:	f052                	sd	s4,32(sp)
    80021546:	ec56                	sd	s5,24(sp)
    80021548:	e85a                	sd	s6,16(sp)
    8002154a:	e45e                	sd	s7,8(sp)
    8002154c:	0880                	addi	s0,sp,80
    8002154e:	8a2a                	mv	s4,a0
    80021550:	8b2e                	mv	s6,a1
    80021552:	8bb2                	mv	s7,a2
    80021554:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80021556:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == NULL)
      return -1;
    n = PGSIZE - (srcva - va0);
    80021558:	6985                	lui	s3,0x1
    8002155a:	a035                	j	80021586 <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    8002155c:	00078023          	sb	zero,0(a5) # 1000 <_start-0x8001f000>
    80021560:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80021562:	0017b793          	seqz	a5,a5
    80021566:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    8002156a:	60a6                	ld	ra,72(sp)
    8002156c:	6406                	ld	s0,64(sp)
    8002156e:	74e2                	ld	s1,56(sp)
    80021570:	7942                	ld	s2,48(sp)
    80021572:	79a2                	ld	s3,40(sp)
    80021574:	7a02                	ld	s4,32(sp)
    80021576:	6ae2                	ld	s5,24(sp)
    80021578:	6b42                	ld	s6,16(sp)
    8002157a:	6ba2                	ld	s7,8(sp)
    8002157c:	6161                	addi	sp,sp,80
    8002157e:	8082                	ret
    srcva = va0 + PGSIZE;
    80021580:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80021584:	c8a9                	beqz	s1,800215d6 <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80021586:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    8002158a:	85ca                	mv	a1,s2
    8002158c:	8552                	mv	a0,s4
    8002158e:	fffff097          	auipc	ra,0xfffff
    80021592:	614080e7          	jalr	1556(ra) # 80020ba2 <walkaddr>
    if(pa0 == NULL)
    80021596:	c131                	beqz	a0,800215da <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80021598:	41790833          	sub	a6,s2,s7
    8002159c:	984e                	add	a6,a6,s3
    if(n > max)
    8002159e:	0104f363          	bgeu	s1,a6,800215a4 <copyinstr+0x6e>
    800215a2:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    800215a4:	955e                	add	a0,a0,s7
    800215a6:	41250533          	sub	a0,a0,s2
    while(n > 0){
    800215aa:	fc080be3          	beqz	a6,80021580 <copyinstr+0x4a>
    800215ae:	985a                	add	a6,a6,s6
    800215b0:	87da                	mv	a5,s6
      if(*p == '\0'){
    800215b2:	41650633          	sub	a2,a0,s6
    800215b6:	14fd                	addi	s1,s1,-1
    800215b8:	9b26                	add	s6,s6,s1
    800215ba:	00f60733          	add	a4,a2,a5
    800215be:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <kernel_end+0xffffffff7ffb9000>
    800215c2:	df49                	beqz	a4,8002155c <copyinstr+0x26>
        *dst = *p;
    800215c4:	00e78023          	sb	a4,0(a5)
      --max;
    800215c8:	40fb04b3          	sub	s1,s6,a5
      dst++;
    800215cc:	0785                	addi	a5,a5,1
    while(n > 0){
    800215ce:	ff0796e3          	bne	a5,a6,800215ba <copyinstr+0x84>
      dst++;
    800215d2:	8b42                	mv	s6,a6
    800215d4:	b775                	j	80021580 <copyinstr+0x4a>
    800215d6:	4781                	li	a5,0
    800215d8:	b769                	j	80021562 <copyinstr+0x2c>
      return -1;
    800215da:	557d                	li	a0,-1
    800215dc:	b779                	j	8002156a <copyinstr+0x34>
  int got_null = 0;
    800215de:	4781                	li	a5,0
  if(got_null){
    800215e0:	0017b793          	seqz	a5,a5
    800215e4:	40f00533          	neg	a0,a5
}
    800215e8:	8082                	ret

00000000800215ea <copyinstr2>:

int
copyinstr2(char *dst, uint64 srcva, uint64 max)
{
    800215ea:	7179                	addi	sp,sp,-48
    800215ec:	f406                	sd	ra,40(sp)
    800215ee:	f022                	sd	s0,32(sp)
    800215f0:	ec26                	sd	s1,24(sp)
    800215f2:	e84a                	sd	s2,16(sp)
    800215f4:	e44e                	sd	s3,8(sp)
    800215f6:	1800                	addi	s0,sp,48
    800215f8:	89aa                	mv	s3,a0
    800215fa:	84ae                	mv	s1,a1
    800215fc:	8932                	mv	s2,a2
  int got_null = 0;
  uint64 sz = myproc()->sz;
    800215fe:	00000097          	auipc	ra,0x0
    80021602:	4d4080e7          	jalr	1236(ra) # 80021ad2 <myproc>
    80021606:	6534                	ld	a3,72(a0)
  while(srcva < sz && max > 0){
    80021608:	04d4f363          	bgeu	s1,a3,8002164e <copyinstr2+0x64>
    8002160c:	04090363          	beqz	s2,80021652 <copyinstr2+0x68>
    80021610:	01298633          	add	a2,s3,s2
    80021614:	8e85                	sub	a3,a3,s1
    80021616:	96ce                	add	a3,a3,s3
    80021618:	87ce                	mv	a5,s3
    char *p = (char *)srcva;
    if(*p == '\0'){
    8002161a:	413485b3          	sub	a1,s1,s3
    8002161e:	00b78733          	add	a4,a5,a1
    80021622:	00074703          	lbu	a4,0(a4)
    80021626:	cb11                	beqz	a4,8002163a <copyinstr2+0x50>
      *dst = '\0';
      got_null = 1;
      break;
    } else {
      *dst = *p;
    80021628:	00e78023          	sb	a4,0(a5)
    }
    --max;
    srcva++;
    dst++;
    8002162c:	0785                	addi	a5,a5,1
  while(srcva < sz && max > 0){
    8002162e:	02d78463          	beq	a5,a3,80021656 <copyinstr2+0x6c>
    80021632:	fec796e3          	bne	a5,a2,8002161e <copyinstr2+0x34>
  }
  if(got_null){
    return 0;
  } else {
    return -1;
    80021636:	557d                	li	a0,-1
    80021638:	a021                	j	80021640 <copyinstr2+0x56>
      *dst = '\0';
    8002163a:	00078023          	sb	zero,0(a5)
    return 0;
    8002163e:	4501                	li	a0,0
  }
}
    80021640:	70a2                	ld	ra,40(sp)
    80021642:	7402                	ld	s0,32(sp)
    80021644:	64e2                	ld	s1,24(sp)
    80021646:	6942                	ld	s2,16(sp)
    80021648:	69a2                	ld	s3,8(sp)
    8002164a:	6145                	addi	sp,sp,48
    8002164c:	8082                	ret
    return -1;
    8002164e:	557d                	li	a0,-1
    80021650:	bfc5                	j	80021640 <copyinstr2+0x56>
    80021652:	557d                	li	a0,-1
    80021654:	b7f5                	j	80021640 <copyinstr2+0x56>
    80021656:	557d                	li	a0,-1
    80021658:	b7e5                	j	80021640 <copyinstr2+0x56>

000000008002165a <kfreewalk>:
}

// only free page table, not physical pages
void
kfreewalk(pagetable_t kpt)
{
    8002165a:	7179                	addi	sp,sp,-48
    8002165c:	f406                	sd	ra,40(sp)
    8002165e:	f022                	sd	s0,32(sp)
    80021660:	ec26                	sd	s1,24(sp)
    80021662:	e84a                	sd	s2,16(sp)
    80021664:	e44e                	sd	s3,8(sp)
    80021666:	e052                	sd	s4,0(sp)
    80021668:	1800                	addi	s0,sp,48
    8002166a:	8a2a                	mv	s4,a0
  for (int i = 0; i < 512; i++) {
    8002166c:	84aa                	mv	s1,a0
    8002166e:	6905                	lui	s2,0x1
    80021670:	992a                	add	s2,s2,a0
    pte_t pte = kpt[i];
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    80021672:	4985                	li	s3,1
    80021674:	a829                	j	8002168e <kfreewalk+0x34>
      kfreewalk((pagetable_t) PTE2PA(pte));
    80021676:	83a9                	srli	a5,a5,0xa
    80021678:	00c79513          	slli	a0,a5,0xc
    8002167c:	00000097          	auipc	ra,0x0
    80021680:	fde080e7          	jalr	-34(ra) # 8002165a <kfreewalk>
      kpt[i] = 0;
    80021684:	0004b023          	sd	zero,0(s1)
  for (int i = 0; i < 512; i++) {
    80021688:	04a1                	addi	s1,s1,8
    8002168a:	01248963          	beq	s1,s2,8002169c <kfreewalk+0x42>
    pte_t pte = kpt[i];
    8002168e:	609c                	ld	a5,0(s1)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    80021690:	00f7f713          	andi	a4,a5,15
    80021694:	ff3701e3          	beq	a4,s3,80021676 <kfreewalk+0x1c>
    } else if (pte & PTE_V) {
    80021698:	8b85                	andi	a5,a5,1
    8002169a:	d7fd                	beqz	a5,80021688 <kfreewalk+0x2e>
      break;
    }
  }
  kfree((void *) kpt);
    8002169c:	8552                	mv	a0,s4
    8002169e:	fffff097          	auipc	ra,0xfffff
    800216a2:	d90080e7          	jalr	-624(ra) # 8002042e <kfree>
}
    800216a6:	70a2                	ld	ra,40(sp)
    800216a8:	7402                	ld	s0,32(sp)
    800216aa:	64e2                	ld	s1,24(sp)
    800216ac:	6942                	ld	s2,16(sp)
    800216ae:	69a2                	ld	s3,8(sp)
    800216b0:	6a02                	ld	s4,0(sp)
    800216b2:	6145                	addi	sp,sp,48
    800216b4:	8082                	ret

00000000800216b6 <kvmfreeusr>:

void
kvmfreeusr(pagetable_t kpt)
{
    800216b6:	1101                	addi	sp,sp,-32
    800216b8:	ec06                	sd	ra,24(sp)
    800216ba:	e822                	sd	s0,16(sp)
    800216bc:	e426                	sd	s1,8(sp)
    800216be:	1000                	addi	s0,sp,32
    800216c0:	84aa                	mv	s1,a0
  pte_t pte;
  for (int i = 0; i < PX(2, MAXUVA); i++) {
    pte = kpt[i];
    800216c2:	6108                	ld	a0,0(a0)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    800216c4:	00f57713          	andi	a4,a0,15
    800216c8:	4785                	li	a5,1
    800216ca:	00f70d63          	beq	a4,a5,800216e4 <kvmfreeusr+0x2e>
    pte = kpt[i];
    800216ce:	6488                	ld	a0,8(s1)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    800216d0:	00f57713          	andi	a4,a0,15
    800216d4:	4785                	li	a5,1
    800216d6:	02f70063          	beq	a4,a5,800216f6 <kvmfreeusr+0x40>
      kfreewalk((pagetable_t) PTE2PA(pte));
      kpt[i] = 0;
    }
  }
}
    800216da:	60e2                	ld	ra,24(sp)
    800216dc:	6442                	ld	s0,16(sp)
    800216de:	64a2                	ld	s1,8(sp)
    800216e0:	6105                	addi	sp,sp,32
    800216e2:	8082                	ret
      kfreewalk((pagetable_t) PTE2PA(pte));
    800216e4:	8129                	srli	a0,a0,0xa
    800216e6:	0532                	slli	a0,a0,0xc
    800216e8:	00000097          	auipc	ra,0x0
    800216ec:	f72080e7          	jalr	-142(ra) # 8002165a <kfreewalk>
      kpt[i] = 0;
    800216f0:	0004b023          	sd	zero,0(s1)
    800216f4:	bfe9                	j	800216ce <kvmfreeusr+0x18>
      kfreewalk((pagetable_t) PTE2PA(pte));
    800216f6:	8129                	srli	a0,a0,0xa
    800216f8:	0532                	slli	a0,a0,0xc
    800216fa:	00000097          	auipc	ra,0x0
    800216fe:	f60080e7          	jalr	-160(ra) # 8002165a <kfreewalk>
      kpt[i] = 0;
    80021702:	0004b423          	sd	zero,8(s1)
}
    80021706:	bfd1                	j	800216da <kvmfreeusr+0x24>

0000000080021708 <kvmfree>:

void
kvmfree(pagetable_t kpt, int stack_free)
{
    80021708:	1101                	addi	sp,sp,-32
    8002170a:	ec06                	sd	ra,24(sp)
    8002170c:	e822                	sd	s0,16(sp)
    8002170e:	e426                	sd	s1,8(sp)
    80021710:	1000                	addi	s0,sp,32
    80021712:	84aa                	mv	s1,a0
  if (stack_free) {
    80021714:	e185                	bnez	a1,80021734 <kvmfree+0x2c>
    pte_t pte = kpt[PX(2, VKSTACK)];
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
      kfreewalk((pagetable_t) PTE2PA(pte));
    }
  }
  kvmfreeusr(kpt);
    80021716:	8526                	mv	a0,s1
    80021718:	00000097          	auipc	ra,0x0
    8002171c:	f9e080e7          	jalr	-98(ra) # 800216b6 <kvmfreeusr>
  kfree(kpt);
    80021720:	8526                	mv	a0,s1
    80021722:	fffff097          	auipc	ra,0xfffff
    80021726:	d0c080e7          	jalr	-756(ra) # 8002042e <kfree>
}
    8002172a:	60e2                	ld	ra,24(sp)
    8002172c:	6442                	ld	s0,16(sp)
    8002172e:	64a2                	ld	s1,8(sp)
    80021730:	6105                	addi	sp,sp,32
    80021732:	8082                	ret
    vmunmap(kpt, VKSTACK, 1, 1);
    80021734:	4685                	li	a3,1
    80021736:	4605                	li	a2,1
    80021738:	0fb00593          	li	a1,251
    8002173c:	05fa                	slli	a1,a1,0x1e
    8002173e:	fffff097          	auipc	ra,0xfffff
    80021742:	77a080e7          	jalr	1914(ra) # 80020eb8 <vmunmap>
    pte_t pte = kpt[PX(2, VKSTACK)];
    80021746:	7d84b503          	ld	a0,2008(s1)
    if ((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0) {
    8002174a:	00f57713          	andi	a4,a0,15
    8002174e:	4785                	li	a5,1
    80021750:	fcf713e3          	bne	a4,a5,80021716 <kvmfree+0xe>
      kfreewalk((pagetable_t) PTE2PA(pte));
    80021754:	8129                	srli	a0,a0,0xa
    80021756:	0532                	slli	a0,a0,0xc
    80021758:	00000097          	auipc	ra,0x0
    8002175c:	f02080e7          	jalr	-254(ra) # 8002165a <kfreewalk>
    80021760:	bf5d                	j	80021716 <kvmfree+0xe>

0000000080021762 <proc_kpagetable>:
{
    80021762:	1101                	addi	sp,sp,-32
    80021764:	ec06                	sd	ra,24(sp)
    80021766:	e822                	sd	s0,16(sp)
    80021768:	e426                	sd	s1,8(sp)
    8002176a:	1000                	addi	s0,sp,32
  pagetable_t kpt = (pagetable_t) kalloc();
    8002176c:	fffff097          	auipc	ra,0xfffff
    80021770:	dda080e7          	jalr	-550(ra) # 80020546 <kalloc>
    80021774:	84aa                	mv	s1,a0
  if (kpt == NULL)
    80021776:	c91d                	beqz	a0,800217ac <proc_kpagetable+0x4a>
  memmove(kpt, kernel_pagetable, PGSIZE);
    80021778:	6605                	lui	a2,0x1
    8002177a:	00016597          	auipc	a1,0x16
    8002177e:	8de5b583          	ld	a1,-1826(a1) # 80037058 <kernel_pagetable>
    80021782:	fffff097          	auipc	ra,0xfffff
    80021786:	028080e7          	jalr	40(ra) # 800207aa <memmove>
  char *pstack = kalloc();
    8002178a:	fffff097          	auipc	ra,0xfffff
    8002178e:	dbc080e7          	jalr	-580(ra) # 80020546 <kalloc>
    80021792:	86aa                	mv	a3,a0
  if(pstack == NULL)
    80021794:	c115                	beqz	a0,800217b8 <proc_kpagetable+0x56>
  if (mappages(kpt, VKSTACK, PGSIZE, (uint64)pstack, PTE_R | PTE_W) != 0)
    80021796:	4719                	li	a4,6
    80021798:	6605                	lui	a2,0x1
    8002179a:	0fb00593          	li	a1,251
    8002179e:	05fa                	slli	a1,a1,0x1e
    800217a0:	8526                	mv	a0,s1
    800217a2:	fffff097          	auipc	ra,0xfffff
    800217a6:	4ba080e7          	jalr	1210(ra) # 80020c5c <mappages>
    800217aa:	e519                	bnez	a0,800217b8 <proc_kpagetable+0x56>
}
    800217ac:	8526                	mv	a0,s1
    800217ae:	60e2                	ld	ra,24(sp)
    800217b0:	6442                	ld	s0,16(sp)
    800217b2:	64a2                	ld	s1,8(sp)
    800217b4:	6105                	addi	sp,sp,32
    800217b6:	8082                	ret
  kvmfree(kpt, 1);
    800217b8:	4585                	li	a1,1
    800217ba:	8526                	mv	a0,s1
    800217bc:	00000097          	auipc	ra,0x0
    800217c0:	f4c080e7          	jalr	-180(ra) # 80021708 <kvmfree>
  return NULL;
    800217c4:	4481                	li	s1,0
    800217c6:	b7dd                	j	800217ac <proc_kpagetable+0x4a>

00000000800217c8 <vmprint>:

void vmprint(pagetable_t pagetable)
{
    800217c8:	7119                	addi	sp,sp,-128
    800217ca:	fc86                	sd	ra,120(sp)
    800217cc:	f8a2                	sd	s0,112(sp)
    800217ce:	f4a6                	sd	s1,104(sp)
    800217d0:	f0ca                	sd	s2,96(sp)
    800217d2:	ecce                	sd	s3,88(sp)
    800217d4:	e8d2                	sd	s4,80(sp)
    800217d6:	e4d6                	sd	s5,72(sp)
    800217d8:	e0da                	sd	s6,64(sp)
    800217da:	fc5e                	sd	s7,56(sp)
    800217dc:	f862                	sd	s8,48(sp)
    800217de:	f466                	sd	s9,40(sp)
    800217e0:	f06a                	sd	s10,32(sp)
    800217e2:	ec6e                	sd	s11,24(sp)
    800217e4:	0100                	addi	s0,sp,128
    800217e6:	8baa                	mv	s7,a0
    800217e8:	f8a43423          	sd	a0,-120(s0)
  const int capacity = 512;
  printf("page table %p\n", pagetable);
    800217ec:	85aa                	mv	a1,a0
    800217ee:	0000a517          	auipc	a0,0xa
    800217f2:	c1a50513          	addi	a0,a0,-998 # 8002b408 <digits+0x180>
    800217f6:	fffff097          	auipc	ra,0xfffff
    800217fa:	996080e7          	jalr	-1642(ra) # 8002018c <printf>
  for (pte_t *pte = (pte_t *) pagetable; pte < pagetable + capacity; pte++) {
    800217fe:	6d85                	lui	s11,0x1
    80021800:	9dde                	add	s11,s11,s7
    80021802:	6c85                	lui	s9,0x1

      for (pte_t *pte2 = (pte_t *) pt2; pte2 < pt2 + capacity; pte2++) {
        if (*pte2 & PTE_V)
        {
          pagetable_t pt3 = (pagetable_t) PTE2PA(*pte2);
          printf(".. ..%d: pte %p pa %p\n", pte2 - pt2, *pte2, pt3);
    80021804:	0000ad17          	auipc	s10,0xa
    80021808:	c2cd0d13          	addi	s10,s10,-980 # 8002b430 <digits+0x1a8>

          for (pte_t *pte3 = (pte_t *) pt3; pte3 < pt3 + capacity; pte3++)
            if (*pte3 & PTE_V)
              printf(".. .. ..%d: pte %p pa %p\n", pte3 - pt3, *pte3, PTE2PA(*pte3));
    8002180c:	0000aa17          	auipc	s4,0xa
    80021810:	c3ca0a13          	addi	s4,s4,-964 # 8002b448 <digits+0x1c0>
    80021814:	a885                	j	80021884 <vmprint+0xbc>
          for (pte_t *pte3 = (pte_t *) pt3; pte3 < pt3 + capacity; pte3++)
    80021816:	04a1                	addi	s1,s1,8
    80021818:	197d                	addi	s2,s2,-1
    8002181a:	02090263          	beqz	s2,8002183e <vmprint+0x76>
            if (*pte3 & PTE_V)
    8002181e:	6090                	ld	a2,0(s1)
    80021820:	00167793          	andi	a5,a2,1
    80021824:	dbed                	beqz	a5,80021816 <vmprint+0x4e>
              printf(".. .. ..%d: pte %p pa %p\n", pte3 - pt3, *pte3, PTE2PA(*pte3));
    80021826:	00a65693          	srli	a3,a2,0xa
    8002182a:	413485b3          	sub	a1,s1,s3
    8002182e:	06b2                	slli	a3,a3,0xc
    80021830:	858d                	srai	a1,a1,0x3
    80021832:	8552                	mv	a0,s4
    80021834:	fffff097          	auipc	ra,0xfffff
    80021838:	958080e7          	jalr	-1704(ra) # 8002018c <printf>
    8002183c:	bfe9                	j	80021816 <vmprint+0x4e>
      for (pte_t *pte2 = (pte_t *) pt2; pte2 < pt2 + capacity; pte2++) {
    8002183e:	0aa1                	addi	s5,s5,8
    80021840:	1b7d                	addi	s6,s6,-1
    80021842:	020b0e63          	beqz	s6,8002187e <vmprint+0xb6>
        if (*pte2 & PTE_V)
    80021846:	000ab603          	ld	a2,0(s5) # fffffffffffff000 <kernel_end+0xffffffff7ffb9000>
    8002184a:	00167793          	andi	a5,a2,1
    8002184e:	dbe5                	beqz	a5,8002183e <vmprint+0x76>
          pagetable_t pt3 = (pagetable_t) PTE2PA(*pte2);
    80021850:	00a65993          	srli	s3,a2,0xa
    80021854:	09b2                	slli	s3,s3,0xc
          printf(".. ..%d: pte %p pa %p\n", pte2 - pt2, *pte2, pt3);
    80021856:	418a85b3          	sub	a1,s5,s8
    8002185a:	86ce                	mv	a3,s3
    8002185c:	858d                	srai	a1,a1,0x3
    8002185e:	856a                	mv	a0,s10
    80021860:	fffff097          	auipc	ra,0xfffff
    80021864:	92c080e7          	jalr	-1748(ra) # 8002018c <printf>
          for (pte_t *pte3 = (pte_t *) pt3; pte3 < pt3 + capacity; pte3++)
    80021868:	00898713          	addi	a4,s3,8 # 1008 <_start-0x8001eff8>
    8002186c:	019987b3          	add	a5,s3,s9
    80021870:	20000913          	li	s2,512
    80021874:	00e7f363          	bgeu	a5,a4,8002187a <vmprint+0xb2>
    80021878:	4905                	li	s2,1
    8002187a:	84ce                	mv	s1,s3
    8002187c:	b74d                	j	8002181e <vmprint+0x56>
  for (pte_t *pte = (pte_t *) pagetable; pte < pagetable + capacity; pte++) {
    8002187e:	0ba1                	addi	s7,s7,8
    80021880:	05bb8463          	beq	s7,s11,800218c8 <vmprint+0x100>
    if (*pte & PTE_V)
    80021884:	000bb603          	ld	a2,0(s7) # fffffffffffff000 <kernel_end+0xffffffff7ffb9000>
    80021888:	00167793          	andi	a5,a2,1
    8002188c:	dbed                	beqz	a5,8002187e <vmprint+0xb6>
      pagetable_t pt2 = (pagetable_t) PTE2PA(*pte); 
    8002188e:	00a65c13          	srli	s8,a2,0xa
    80021892:	0c32                	slli	s8,s8,0xc
      printf("..%d: pte %p pa %p\n", pte - pagetable, *pte, pt2);
    80021894:	f8843783          	ld	a5,-120(s0)
    80021898:	40fb87b3          	sub	a5,s7,a5
    8002189c:	86e2                	mv	a3,s8
    8002189e:	4037d593          	srai	a1,a5,0x3
    800218a2:	0000a517          	auipc	a0,0xa
    800218a6:	b7650513          	addi	a0,a0,-1162 # 8002b418 <digits+0x190>
    800218aa:	fffff097          	auipc	ra,0xfffff
    800218ae:	8e2080e7          	jalr	-1822(ra) # 8002018c <printf>
      for (pte_t *pte2 = (pte_t *) pt2; pte2 < pt2 + capacity; pte2++) {
    800218b2:	019c0733          	add	a4,s8,s9
    800218b6:	008c0793          	addi	a5,s8,8 # 1008 <_start-0x8001eff8>
    800218ba:	20000b13          	li	s6,512
    800218be:	00f77363          	bgeu	a4,a5,800218c4 <vmprint+0xfc>
    800218c2:	4b05                	li	s6,1
    800218c4:	8ae2                	mv	s5,s8
    800218c6:	b741                	j	80021846 <vmprint+0x7e>
        }
      }
    }
  }
  return;
    800218c8:	70e6                	ld	ra,120(sp)
    800218ca:	7446                	ld	s0,112(sp)
    800218cc:	74a6                	ld	s1,104(sp)
    800218ce:	7906                	ld	s2,96(sp)
    800218d0:	69e6                	ld	s3,88(sp)
    800218d2:	6a46                	ld	s4,80(sp)
    800218d4:	6aa6                	ld	s5,72(sp)
    800218d6:	6b06                	ld	s6,64(sp)
    800218d8:	7be2                	ld	s7,56(sp)
    800218da:	7c42                	ld	s8,48(sp)
    800218dc:	7ca2                	ld	s9,40(sp)
    800218de:	7d02                	ld	s10,32(sp)
    800218e0:	6de2                	ld	s11,24(sp)
    800218e2:	6109                	addi	sp,sp,128
    800218e4:	8082                	ret

00000000800218e6 <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    800218e6:	1101                	addi	sp,sp,-32
    800218e8:	ec06                	sd	ra,24(sp)
    800218ea:	e822                	sd	s0,16(sp)
    800218ec:	e426                	sd	s1,8(sp)
    800218ee:	1000                	addi	s0,sp,32
    800218f0:	84aa                	mv	s1,a0
    if(!holding(&p->lock))
    800218f2:	fffff097          	auipc	ra,0xfffff
    800218f6:	d92080e7          	jalr	-622(ra) # 80020684 <holding>
    800218fa:	c909                	beqz	a0,8002190c <wakeup1+0x26>
        panic("wakeup1");
    if(p->chan == p && p->state == SLEEPING) {
    800218fc:	749c                	ld	a5,40(s1)
    800218fe:	00978f63          	beq	a5,s1,8002191c <wakeup1+0x36>
        p->state = RUNNABLE;
    }
}
    80021902:	60e2                	ld	ra,24(sp)
    80021904:	6442                	ld	s0,16(sp)
    80021906:	64a2                	ld	s1,8(sp)
    80021908:	6105                	addi	sp,sp,32
    8002190a:	8082                	ret
        panic("wakeup1");
    8002190c:	0000a517          	auipc	a0,0xa
    80021910:	b5c50513          	addi	a0,a0,-1188 # 8002b468 <digits+0x1e0>
    80021914:	fffff097          	auipc	ra,0xfffff
    80021918:	82e080e7          	jalr	-2002(ra) # 80020142 <panic>
    if(p->chan == p && p->state == SLEEPING) {
    8002191c:	4c98                	lw	a4,24(s1)
    8002191e:	4785                	li	a5,1
    80021920:	fef711e3          	bne	a4,a5,80021902 <wakeup1+0x1c>
        p->state = RUNNABLE;
    80021924:	4789                	li	a5,2
    80021926:	cc9c                	sw	a5,24(s1)
}
    80021928:	bfe9                	j	80021902 <wakeup1+0x1c>

000000008002192a <reg_info>:
void reg_info(void) {
    8002192a:	1141                	addi	sp,sp,-16
    8002192c:	e406                	sd	ra,8(sp)
    8002192e:	e022                	sd	s0,0(sp)
    80021930:	0800                	addi	s0,sp,16
    printf("register info: {\n");
    80021932:	0000a517          	auipc	a0,0xa
    80021936:	b3e50513          	addi	a0,a0,-1218 # 8002b470 <digits+0x1e8>
    8002193a:	fffff097          	auipc	ra,0xfffff
    8002193e:	852080e7          	jalr	-1966(ra) # 8002018c <printf>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80021942:	100025f3          	csrr	a1,sstatus
    printf("sstatus: %p\n", r_sstatus());
    80021946:	0000a517          	auipc	a0,0xa
    8002194a:	b4250513          	addi	a0,a0,-1214 # 8002b488 <digits+0x200>
    8002194e:	fffff097          	auipc	ra,0xfffff
    80021952:	83e080e7          	jalr	-1986(ra) # 8002018c <printf>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80021956:	144025f3          	csrr	a1,sip
    printf("sip: %p\n", r_sip());
    8002195a:	0000a517          	auipc	a0,0xa
    8002195e:	b3e50513          	addi	a0,a0,-1218 # 8002b498 <digits+0x210>
    80021962:	fffff097          	auipc	ra,0xfffff
    80021966:	82a080e7          	jalr	-2006(ra) # 8002018c <printf>
  asm volatile("csrr %0, sie" : "=r" (x) );
    8002196a:	104025f3          	csrr	a1,sie
    printf("sie: %p\n", r_sie());
    8002196e:	0000a517          	auipc	a0,0xa
    80021972:	b3a50513          	addi	a0,a0,-1222 # 8002b4a8 <digits+0x220>
    80021976:	fffff097          	auipc	ra,0xfffff
    8002197a:	816080e7          	jalr	-2026(ra) # 8002018c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8002197e:	141025f3          	csrr	a1,sepc
    printf("sepc: %p\n", r_sepc());
    80021982:	0000a517          	auipc	a0,0xa
    80021986:	b3650513          	addi	a0,a0,-1226 # 8002b4b8 <digits+0x230>
    8002198a:	fffff097          	auipc	ra,0xfffff
    8002198e:	802080e7          	jalr	-2046(ra) # 8002018c <printf>
  asm volatile("csrr %0, stvec" : "=r" (x) );
    80021992:	105025f3          	csrr	a1,stvec
    printf("stvec: %p\n", r_stvec());
    80021996:	0000a517          	auipc	a0,0xa
    8002199a:	b3250513          	addi	a0,a0,-1230 # 8002b4c8 <digits+0x240>
    8002199e:	ffffe097          	auipc	ra,0xffffe
    800219a2:	7ee080e7          	jalr	2030(ra) # 8002018c <printf>
  asm volatile("csrr %0, satp" : "=r" (x) );
    800219a6:	180025f3          	csrr	a1,satp
    printf("satp: %p\n", r_satp());
    800219aa:	0000a517          	auipc	a0,0xa
    800219ae:	b2e50513          	addi	a0,a0,-1234 # 8002b4d8 <digits+0x250>
    800219b2:	ffffe097          	auipc	ra,0xffffe
    800219b6:	7da080e7          	jalr	2010(ra) # 8002018c <printf>
  asm volatile("csrr %0, scause" : "=r" (x) );
    800219ba:	142025f3          	csrr	a1,scause
    printf("scause: %p\n", r_scause());
    800219be:	0000a517          	auipc	a0,0xa
    800219c2:	b2a50513          	addi	a0,a0,-1238 # 8002b4e8 <digits+0x260>
    800219c6:	ffffe097          	auipc	ra,0xffffe
    800219ca:	7c6080e7          	jalr	1990(ra) # 8002018c <printf>
  asm volatile("csrr %0, stval" : "=r" (x) );
    800219ce:	143025f3          	csrr	a1,stval
    printf("stval: %p\n", r_stval());
    800219d2:	0000a517          	auipc	a0,0xa
    800219d6:	b2650513          	addi	a0,a0,-1242 # 8002b4f8 <digits+0x270>
    800219da:	ffffe097          	auipc	ra,0xffffe
    800219de:	7b2080e7          	jalr	1970(ra) # 8002018c <printf>
  asm volatile("mv %0, sp" : "=r" (x) );
    800219e2:	858a                	mv	a1,sp
    printf("sp: %p\n", r_sp());
    800219e4:	0000a517          	auipc	a0,0xa
    800219e8:	b2450513          	addi	a0,a0,-1244 # 8002b508 <digits+0x280>
    800219ec:	ffffe097          	auipc	ra,0xffffe
    800219f0:	7a0080e7          	jalr	1952(ra) # 8002018c <printf>
  asm volatile("mv %0, tp" : "=r" (x) );
    800219f4:	8592                	mv	a1,tp
    printf("tp: %p\n", r_tp());
    800219f6:	0000a517          	auipc	a0,0xa
    800219fa:	b1a50513          	addi	a0,a0,-1254 # 8002b510 <digits+0x288>
    800219fe:	ffffe097          	auipc	ra,0xffffe
    80021a02:	78e080e7          	jalr	1934(ra) # 8002018c <printf>
  asm volatile("mv %0, ra" : "=r" (x) );
    80021a06:	8586                	mv	a1,ra
    printf("ra: %p\n", r_ra());
    80021a08:	0000a517          	auipc	a0,0xa
    80021a0c:	b1050513          	addi	a0,a0,-1264 # 8002b518 <digits+0x290>
    80021a10:	ffffe097          	auipc	ra,0xffffe
    80021a14:	77c080e7          	jalr	1916(ra) # 8002018c <printf>
    printf("}\n");
    80021a18:	0000a517          	auipc	a0,0xa
    80021a1c:	b0850513          	addi	a0,a0,-1272 # 8002b520 <digits+0x298>
    80021a20:	ffffe097          	auipc	ra,0xffffe
    80021a24:	76c080e7          	jalr	1900(ra) # 8002018c <printf>
}
    80021a28:	60a2                	ld	ra,8(sp)
    80021a2a:	6402                	ld	s0,0(sp)
    80021a2c:	0141                	addi	sp,sp,16
    80021a2e:	8082                	ret

0000000080021a30 <procinit>:
{
    80021a30:	7179                	addi	sp,sp,-48
    80021a32:	f406                	sd	ra,40(sp)
    80021a34:	f022                	sd	s0,32(sp)
    80021a36:	ec26                	sd	s1,24(sp)
    80021a38:	e84a                	sd	s2,16(sp)
    80021a3a:	e44e                	sd	s3,8(sp)
    80021a3c:	1800                	addi	s0,sp,48
    initlock(&pid_lock, "nextpid");
    80021a3e:	0000a597          	auipc	a1,0xa
    80021a42:	aea58593          	addi	a1,a1,-1302 # 8002b528 <digits+0x2a0>
    80021a46:	00015517          	auipc	a0,0x15
    80021a4a:	61a50513          	addi	a0,a0,1562 # 80037060 <pid_lock>
    80021a4e:	fffff097          	auipc	ra,0xfffff
    80021a52:	c20080e7          	jalr	-992(ra) # 8002066e <initlock>
    for(p = proc; p < &proc[NPROC]; p++) {
    80021a56:	00015497          	auipc	s1,0x15
    80021a5a:	72a48493          	addi	s1,s1,1834 # 80037180 <proc>
        initlock(&p->lock, "proc");
    80021a5e:	0000a997          	auipc	s3,0xa
    80021a62:	ad298993          	addi	s3,s3,-1326 # 8002b530 <digits+0x2a8>
    for(p = proc; p < &proc[NPROC]; p++) {
    80021a66:	0001a917          	auipc	s2,0x1a
    80021a6a:	08a90913          	addi	s2,s2,138 # 8003baf0 <bcache>
        initlock(&p->lock, "proc");
    80021a6e:	85ce                	mv	a1,s3
    80021a70:	8526                	mv	a0,s1
    80021a72:	fffff097          	auipc	ra,0xfffff
    80021a76:	bfc080e7          	jalr	-1028(ra) # 8002066e <initlock>
    for(p = proc; p < &proc[NPROC]; p++) {
    80021a7a:	17848493          	addi	s1,s1,376
    80021a7e:	ff2498e3          	bne	s1,s2,80021a6e <procinit+0x3e>
    memset(cpus, 0, sizeof(cpus));
    80021a82:	10000613          	li	a2,256
    80021a86:	4581                	li	a1,0
    80021a88:	00015517          	auipc	a0,0x15
    80021a8c:	5f050513          	addi	a0,a0,1520 # 80037078 <cpus>
    80021a90:	fffff097          	auipc	ra,0xfffff
    80021a94:	cbe080e7          	jalr	-834(ra) # 8002074e <memset>
}
    80021a98:	70a2                	ld	ra,40(sp)
    80021a9a:	7402                	ld	s0,32(sp)
    80021a9c:	64e2                	ld	s1,24(sp)
    80021a9e:	6942                	ld	s2,16(sp)
    80021aa0:	69a2                	ld	s3,8(sp)
    80021aa2:	6145                	addi	sp,sp,48
    80021aa4:	8082                	ret

0000000080021aa6 <cpuid>:
{
    80021aa6:	1141                	addi	sp,sp,-16
    80021aa8:	e422                	sd	s0,8(sp)
    80021aaa:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80021aac:	8512                	mv	a0,tp
}
    80021aae:	2501                	sext.w	a0,a0
    80021ab0:	6422                	ld	s0,8(sp)
    80021ab2:	0141                	addi	sp,sp,16
    80021ab4:	8082                	ret

0000000080021ab6 <mycpu>:
mycpu(void) {
    80021ab6:	1141                	addi	sp,sp,-16
    80021ab8:	e422                	sd	s0,8(sp)
    80021aba:	0800                	addi	s0,sp,16
    80021abc:	8792                	mv	a5,tp
    struct cpu *c = &cpus[id];
    80021abe:	2781                	sext.w	a5,a5
    80021ac0:	079e                	slli	a5,a5,0x7
}
    80021ac2:	00015517          	auipc	a0,0x15
    80021ac6:	5b650513          	addi	a0,a0,1462 # 80037078 <cpus>
    80021aca:	953e                	add	a0,a0,a5
    80021acc:	6422                	ld	s0,8(sp)
    80021ace:	0141                	addi	sp,sp,16
    80021ad0:	8082                	ret

0000000080021ad2 <myproc>:
myproc(void) {
    80021ad2:	1101                	addi	sp,sp,-32
    80021ad4:	ec06                	sd	ra,24(sp)
    80021ad6:	e822                	sd	s0,16(sp)
    80021ad8:	e426                	sd	s1,8(sp)
    80021ada:	1000                	addi	s0,sp,32
    push_off();
    80021adc:	fffff097          	auipc	ra,0xfffff
    80021ae0:	ae6080e7          	jalr	-1306(ra) # 800205c2 <push_off>
    80021ae4:	8792                	mv	a5,tp
    struct proc *p = c->proc;
    80021ae6:	2781                	sext.w	a5,a5
    80021ae8:	079e                	slli	a5,a5,0x7
    80021aea:	00015717          	auipc	a4,0x15
    80021aee:	57670713          	addi	a4,a4,1398 # 80037060 <pid_lock>
    80021af2:	97ba                	add	a5,a5,a4
    80021af4:	6f84                	ld	s1,24(a5)
    pop_off();
    80021af6:	fffff097          	auipc	ra,0xfffff
    80021afa:	b18080e7          	jalr	-1256(ra) # 8002060e <pop_off>
}
    80021afe:	8526                	mv	a0,s1
    80021b00:	60e2                	ld	ra,24(sp)
    80021b02:	6442                	ld	s0,16(sp)
    80021b04:	64a2                	ld	s1,8(sp)
    80021b06:	6105                	addi	sp,sp,32
    80021b08:	8082                	ret

0000000080021b0a <forkret>:
{
    80021b0a:	1101                	addi	sp,sp,-32
    80021b0c:	ec06                	sd	ra,24(sp)
    80021b0e:	e822                	sd	s0,16(sp)
    80021b10:	e426                	sd	s1,8(sp)
    80021b12:	1000                	addi	s0,sp,32
    release(&myproc()->lock);
    80021b14:	00000097          	auipc	ra,0x0
    80021b18:	fbe080e7          	jalr	-66(ra) # 80021ad2 <myproc>
    80021b1c:	fffff097          	auipc	ra,0xfffff
    80021b20:	bea080e7          	jalr	-1046(ra) # 80020706 <release>
    if (first) {
    80021b24:	0000b797          	auipc	a5,0xb
    80021b28:	4dc7a783          	lw	a5,1244(a5) # 8002d000 <first.1>
    80021b2c:	eb91                	bnez	a5,80021b40 <forkret+0x36>
    usertrapret();
    80021b2e:	00001097          	auipc	ra,0x1
    80021b32:	c6a080e7          	jalr	-918(ra) # 80022798 <usertrapret>
}
    80021b36:	60e2                	ld	ra,24(sp)
    80021b38:	6442                	ld	s0,16(sp)
    80021b3a:	64a2                	ld	s1,8(sp)
    80021b3c:	6105                	addi	sp,sp,32
    80021b3e:	8082                	ret
        first = 0;
    80021b40:	0000b797          	auipc	a5,0xb
    80021b44:	4c07a023          	sw	zero,1216(a5) # 8002d000 <first.1>
        fat32_init();
    80021b48:	00004097          	auipc	ra,0x4
    80021b4c:	be2080e7          	jalr	-1054(ra) # 8002572a <fat32_init>
        myproc()->cwd = ename("/");
    80021b50:	00000097          	auipc	ra,0x0
    80021b54:	f82080e7          	jalr	-126(ra) # 80021ad2 <myproc>
    80021b58:	84aa                	mv	s1,a0
    80021b5a:	0000a517          	auipc	a0,0xa
    80021b5e:	9de50513          	addi	a0,a0,-1570 # 8002b538 <digits+0x2b0>
    80021b62:	00005097          	auipc	ra,0x5
    80021b66:	e26080e7          	jalr	-474(ra) # 80026988 <ename>
    80021b6a:	14a4bc23          	sd	a0,344(s1)
    80021b6e:	b7c1                	j	80021b2e <forkret+0x24>

0000000080021b70 <allocpid>:
allocpid() {
    80021b70:	1101                	addi	sp,sp,-32
    80021b72:	ec06                	sd	ra,24(sp)
    80021b74:	e822                	sd	s0,16(sp)
    80021b76:	e426                	sd	s1,8(sp)
    80021b78:	e04a                	sd	s2,0(sp)
    80021b7a:	1000                	addi	s0,sp,32
    acquire(&pid_lock);
    80021b7c:	00015917          	auipc	s2,0x15
    80021b80:	4e490913          	addi	s2,s2,1252 # 80037060 <pid_lock>
    80021b84:	854a                	mv	a0,s2
    80021b86:	fffff097          	auipc	ra,0xfffff
    80021b8a:	b2c080e7          	jalr	-1236(ra) # 800206b2 <acquire>
    pid = nextpid;
    80021b8e:	0000b797          	auipc	a5,0xb
    80021b92:	47278793          	addi	a5,a5,1138 # 8002d000 <first.1>
    80021b96:	43c4                	lw	s1,4(a5)
    nextpid = nextpid + 1;
    80021b98:	0014871b          	addiw	a4,s1,1
    80021b9c:	c3d8                	sw	a4,4(a5)
    release(&pid_lock);
    80021b9e:	854a                	mv	a0,s2
    80021ba0:	fffff097          	auipc	ra,0xfffff
    80021ba4:	b66080e7          	jalr	-1178(ra) # 80020706 <release>
}
    80021ba8:	8526                	mv	a0,s1
    80021baa:	60e2                	ld	ra,24(sp)
    80021bac:	6442                	ld	s0,16(sp)
    80021bae:	64a2                	ld	s1,8(sp)
    80021bb0:	6902                	ld	s2,0(sp)
    80021bb2:	6105                	addi	sp,sp,32
    80021bb4:	8082                	ret

0000000080021bb6 <proc_pagetable>:
{
    80021bb6:	1101                	addi	sp,sp,-32
    80021bb8:	ec06                	sd	ra,24(sp)
    80021bba:	e822                	sd	s0,16(sp)
    80021bbc:	e426                	sd	s1,8(sp)
    80021bbe:	e04a                	sd	s2,0(sp)
    80021bc0:	1000                	addi	s0,sp,32
    80021bc2:	892a                	mv	s2,a0
    pagetable = uvmcreate();
    80021bc4:	fffff097          	auipc	ra,0xfffff
    80021bc8:	3b8080e7          	jalr	952(ra) # 80020f7c <uvmcreate>
    80021bcc:	84aa                	mv	s1,a0
    if(pagetable == 0)
    80021bce:	c121                	beqz	a0,80021c0e <proc_pagetable+0x58>
    if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80021bd0:	4729                	li	a4,10
    80021bd2:	0000d697          	auipc	a3,0xd
    80021bd6:	8de6b683          	ld	a3,-1826(a3) # 8002e4b0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80021bda:	6605                	lui	a2,0x1
    80021bdc:	040005b7          	lui	a1,0x4000
    80021be0:	15fd                	addi	a1,a1,-1
    80021be2:	05b2                	slli	a1,a1,0xc
    80021be4:	fffff097          	auipc	ra,0xfffff
    80021be8:	078080e7          	jalr	120(ra) # 80020c5c <mappages>
    80021bec:	02054863          	bltz	a0,80021c1c <proc_pagetable+0x66>
    if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80021bf0:	4719                	li	a4,6
    80021bf2:	06093683          	ld	a3,96(s2)
    80021bf6:	6605                	lui	a2,0x1
    80021bf8:	020005b7          	lui	a1,0x2000
    80021bfc:	15fd                	addi	a1,a1,-1
    80021bfe:	05b6                	slli	a1,a1,0xd
    80021c00:	8526                	mv	a0,s1
    80021c02:	fffff097          	auipc	ra,0xfffff
    80021c06:	05a080e7          	jalr	90(ra) # 80020c5c <mappages>
    80021c0a:	02054163          	bltz	a0,80021c2c <proc_pagetable+0x76>
}
    80021c0e:	8526                	mv	a0,s1
    80021c10:	60e2                	ld	ra,24(sp)
    80021c12:	6442                	ld	s0,16(sp)
    80021c14:	64a2                	ld	s1,8(sp)
    80021c16:	6902                	ld	s2,0(sp)
    80021c18:	6105                	addi	sp,sp,32
    80021c1a:	8082                	ret
        uvmfree(pagetable, 0);
    80021c1c:	4581                	li	a1,0
    80021c1e:	8526                	mv	a0,s1
    80021c20:	fffff097          	auipc	ra,0xfffff
    80021c24:	5e0080e7          	jalr	1504(ra) # 80021200 <uvmfree>
        return NULL;
    80021c28:	4481                	li	s1,0
    80021c2a:	b7d5                	j	80021c0e <proc_pagetable+0x58>
        vmunmap(pagetable, TRAMPOLINE, 1, 0);
    80021c2c:	4681                	li	a3,0
    80021c2e:	4605                	li	a2,1
    80021c30:	040005b7          	lui	a1,0x4000
    80021c34:	15fd                	addi	a1,a1,-1
    80021c36:	05b2                	slli	a1,a1,0xc
    80021c38:	8526                	mv	a0,s1
    80021c3a:	fffff097          	auipc	ra,0xfffff
    80021c3e:	27e080e7          	jalr	638(ra) # 80020eb8 <vmunmap>
        uvmfree(pagetable, 0);
    80021c42:	4581                	li	a1,0
    80021c44:	8526                	mv	a0,s1
    80021c46:	fffff097          	auipc	ra,0xfffff
    80021c4a:	5ba080e7          	jalr	1466(ra) # 80021200 <uvmfree>
        return NULL;
    80021c4e:	4481                	li	s1,0
    80021c50:	bf7d                	j	80021c0e <proc_pagetable+0x58>

0000000080021c52 <proc_freepagetable>:
{
    80021c52:	1101                	addi	sp,sp,-32
    80021c54:	ec06                	sd	ra,24(sp)
    80021c56:	e822                	sd	s0,16(sp)
    80021c58:	e426                	sd	s1,8(sp)
    80021c5a:	e04a                	sd	s2,0(sp)
    80021c5c:	1000                	addi	s0,sp,32
    80021c5e:	84aa                	mv	s1,a0
    80021c60:	892e                	mv	s2,a1
    vmunmap(pagetable, TRAMPOLINE, 1, 0);
    80021c62:	4681                	li	a3,0
    80021c64:	4605                	li	a2,1
    80021c66:	040005b7          	lui	a1,0x4000
    80021c6a:	15fd                	addi	a1,a1,-1
    80021c6c:	05b2                	slli	a1,a1,0xc
    80021c6e:	fffff097          	auipc	ra,0xfffff
    80021c72:	24a080e7          	jalr	586(ra) # 80020eb8 <vmunmap>
    vmunmap(pagetable, TRAPFRAME, 1, 0);
    80021c76:	4681                	li	a3,0
    80021c78:	4605                	li	a2,1
    80021c7a:	020005b7          	lui	a1,0x2000
    80021c7e:	15fd                	addi	a1,a1,-1
    80021c80:	05b6                	slli	a1,a1,0xd
    80021c82:	8526                	mv	a0,s1
    80021c84:	fffff097          	auipc	ra,0xfffff
    80021c88:	234080e7          	jalr	564(ra) # 80020eb8 <vmunmap>
    uvmfree(pagetable, sz);
    80021c8c:	85ca                	mv	a1,s2
    80021c8e:	8526                	mv	a0,s1
    80021c90:	fffff097          	auipc	ra,0xfffff
    80021c94:	570080e7          	jalr	1392(ra) # 80021200 <uvmfree>
}
    80021c98:	60e2                	ld	ra,24(sp)
    80021c9a:	6442                	ld	s0,16(sp)
    80021c9c:	64a2                	ld	s1,8(sp)
    80021c9e:	6902                	ld	s2,0(sp)
    80021ca0:	6105                	addi	sp,sp,32
    80021ca2:	8082                	ret

0000000080021ca4 <freeproc>:
{
    80021ca4:	1101                	addi	sp,sp,-32
    80021ca6:	ec06                	sd	ra,24(sp)
    80021ca8:	e822                	sd	s0,16(sp)
    80021caa:	e426                	sd	s1,8(sp)
    80021cac:	1000                	addi	s0,sp,32
    80021cae:	84aa                	mv	s1,a0
    if(p->trapframe)
    80021cb0:	7128                	ld	a0,96(a0)
    80021cb2:	c509                	beqz	a0,80021cbc <freeproc+0x18>
        kfree((void*)p->trapframe);
    80021cb4:	ffffe097          	auipc	ra,0xffffe
    80021cb8:	77a080e7          	jalr	1914(ra) # 8002042e <kfree>
    p->trapframe = 0;
    80021cbc:	0604b023          	sd	zero,96(s1)
    if (p->kpagetable) {
    80021cc0:	6ca8                	ld	a0,88(s1)
    80021cc2:	c511                	beqz	a0,80021cce <freeproc+0x2a>
        kvmfree(p->kpagetable, 1);
    80021cc4:	4585                	li	a1,1
    80021cc6:	00000097          	auipc	ra,0x0
    80021cca:	a42080e7          	jalr	-1470(ra) # 80021708 <kvmfree>
    p->kpagetable = 0;
    80021cce:	0404bc23          	sd	zero,88(s1)
    if(p->pagetable)
    80021cd2:	68a8                	ld	a0,80(s1)
    80021cd4:	c511                	beqz	a0,80021ce0 <freeproc+0x3c>
        proc_freepagetable(p->pagetable, p->sz);
    80021cd6:	64ac                	ld	a1,72(s1)
    80021cd8:	00000097          	auipc	ra,0x0
    80021cdc:	f7a080e7          	jalr	-134(ra) # 80021c52 <proc_freepagetable>
    p->pagetable = 0;
    80021ce0:	0404b823          	sd	zero,80(s1)
    p->sz = 0;
    80021ce4:	0404b423          	sd	zero,72(s1)
    p->pid = 0;
    80021ce8:	0204ac23          	sw	zero,56(s1)
    p->parent = 0;
    80021cec:	0204b023          	sd	zero,32(s1)
    p->name[0] = 0;
    80021cf0:	16048023          	sb	zero,352(s1)
    p->chan = 0;
    80021cf4:	0204b423          	sd	zero,40(s1)
    p->killed = 0;
    80021cf8:	0204a823          	sw	zero,48(s1)
    p->xstate = 0;
    80021cfc:	0204aa23          	sw	zero,52(s1)
    p->state = UNUSED;
    80021d00:	0004ac23          	sw	zero,24(s1)
}
    80021d04:	60e2                	ld	ra,24(sp)
    80021d06:	6442                	ld	s0,16(sp)
    80021d08:	64a2                	ld	s1,8(sp)
    80021d0a:	6105                	addi	sp,sp,32
    80021d0c:	8082                	ret

0000000080021d0e <allocproc>:
{
    80021d0e:	1101                	addi	sp,sp,-32
    80021d10:	ec06                	sd	ra,24(sp)
    80021d12:	e822                	sd	s0,16(sp)
    80021d14:	e426                	sd	s1,8(sp)
    80021d16:	e04a                	sd	s2,0(sp)
    80021d18:	1000                	addi	s0,sp,32
    for(p = proc; p < &proc[NPROC]; p++) {
    80021d1a:	00015497          	auipc	s1,0x15
    80021d1e:	46648493          	addi	s1,s1,1126 # 80037180 <proc>
    80021d22:	0001a917          	auipc	s2,0x1a
    80021d26:	dce90913          	addi	s2,s2,-562 # 8003baf0 <bcache>
        acquire(&p->lock);
    80021d2a:	8526                	mv	a0,s1
    80021d2c:	fffff097          	auipc	ra,0xfffff
    80021d30:	986080e7          	jalr	-1658(ra) # 800206b2 <acquire>
        if(p->state == UNUSED) {
    80021d34:	4c9c                	lw	a5,24(s1)
    80021d36:	cf81                	beqz	a5,80021d4e <allocproc+0x40>
            release(&p->lock);
    80021d38:	8526                	mv	a0,s1
    80021d3a:	fffff097          	auipc	ra,0xfffff
    80021d3e:	9cc080e7          	jalr	-1588(ra) # 80020706 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80021d42:	17848493          	addi	s1,s1,376
    80021d46:	ff2492e3          	bne	s1,s2,80021d2a <allocproc+0x1c>
    return NULL;
    80021d4a:	4481                	li	s1,0
    80021d4c:	a085                	j	80021dac <allocproc+0x9e>
    p->pid = allocpid();
    80021d4e:	00000097          	auipc	ra,0x0
    80021d52:	e22080e7          	jalr	-478(ra) # 80021b70 <allocpid>
    80021d56:	dc88                	sw	a0,56(s1)
    if((p->trapframe = (struct trapframe *)kalloc()) == NULL){
    80021d58:	ffffe097          	auipc	ra,0xffffe
    80021d5c:	7ee080e7          	jalr	2030(ra) # 80020546 <kalloc>
    80021d60:	892a                	mv	s2,a0
    80021d62:	f0a8                	sd	a0,96(s1)
    80021d64:	c939                	beqz	a0,80021dba <allocproc+0xac>
    if ((p->pagetable = proc_pagetable(p)) == NULL ||
    80021d66:	8526                	mv	a0,s1
    80021d68:	00000097          	auipc	ra,0x0
    80021d6c:	e4e080e7          	jalr	-434(ra) # 80021bb6 <proc_pagetable>
    80021d70:	e8a8                	sd	a0,80(s1)
    80021d72:	c939                	beqz	a0,80021dc8 <allocproc+0xba>
        (p->kpagetable = proc_kpagetable()) == NULL) {
    80021d74:	00000097          	auipc	ra,0x0
    80021d78:	9ee080e7          	jalr	-1554(ra) # 80021762 <proc_kpagetable>
    80021d7c:	eca8                	sd	a0,88(s1)
    if ((p->pagetable = proc_pagetable(p)) == NULL ||
    80021d7e:	c529                	beqz	a0,80021dc8 <allocproc+0xba>
    p->kstack = VKSTACK;
    80021d80:	0fb00793          	li	a5,251
    80021d84:	07fa                	slli	a5,a5,0x1e
    80021d86:	e0bc                	sd	a5,64(s1)
    memset(&p->context, 0, sizeof(p->context));
    80021d88:	07000613          	li	a2,112
    80021d8c:	4581                	li	a1,0
    80021d8e:	06848513          	addi	a0,s1,104
    80021d92:	fffff097          	auipc	ra,0xfffff
    80021d96:	9bc080e7          	jalr	-1604(ra) # 8002074e <memset>
    p->context.ra = (uint64)forkret;
    80021d9a:	00000797          	auipc	a5,0x0
    80021d9e:	d7078793          	addi	a5,a5,-656 # 80021b0a <forkret>
    80021da2:	f4bc                	sd	a5,104(s1)
    p->context.sp = p->kstack + PGSIZE;
    80021da4:	60bc                	ld	a5,64(s1)
    80021da6:	6705                	lui	a4,0x1
    80021da8:	97ba                	add	a5,a5,a4
    80021daa:	f8bc                	sd	a5,112(s1)
}
    80021dac:	8526                	mv	a0,s1
    80021dae:	60e2                	ld	ra,24(sp)
    80021db0:	6442                	ld	s0,16(sp)
    80021db2:	64a2                	ld	s1,8(sp)
    80021db4:	6902                	ld	s2,0(sp)
    80021db6:	6105                	addi	sp,sp,32
    80021db8:	8082                	ret
        release(&p->lock);
    80021dba:	8526                	mv	a0,s1
    80021dbc:	fffff097          	auipc	ra,0xfffff
    80021dc0:	94a080e7          	jalr	-1718(ra) # 80020706 <release>
        return NULL;
    80021dc4:	84ca                	mv	s1,s2
    80021dc6:	b7dd                	j	80021dac <allocproc+0x9e>
        freeproc(p);
    80021dc8:	8526                	mv	a0,s1
    80021dca:	00000097          	auipc	ra,0x0
    80021dce:	eda080e7          	jalr	-294(ra) # 80021ca4 <freeproc>
        release(&p->lock);
    80021dd2:	8526                	mv	a0,s1
    80021dd4:	fffff097          	auipc	ra,0xfffff
    80021dd8:	932080e7          	jalr	-1742(ra) # 80020706 <release>
        return NULL;
    80021ddc:	4481                	li	s1,0
    80021dde:	b7f9                	j	80021dac <allocproc+0x9e>

0000000080021de0 <userinit>:
{
    80021de0:	1101                	addi	sp,sp,-32
    80021de2:	ec06                	sd	ra,24(sp)
    80021de4:	e822                	sd	s0,16(sp)
    80021de6:	e426                	sd	s1,8(sp)
    80021de8:	e04a                	sd	s2,0(sp)
    80021dea:	1000                	addi	s0,sp,32
    p = allocproc();
    80021dec:	00000097          	auipc	ra,0x0
    80021df0:	f22080e7          	jalr	-222(ra) # 80021d0e <allocproc>
    80021df4:	84aa                	mv	s1,a0
    initproc = p;
    80021df6:	00015797          	auipc	a5,0x15
    80021dfa:	38a7b123          	sd	a0,898(a5) # 80037178 <initproc>
    uvminit(p->pagetable , p->kpagetable, initcode, sizeof(initcode));
    80021dfe:	6905                	lui	s2,0x1
    80021e00:	b5c90693          	addi	a3,s2,-1188 # b5c <_start-0x8001f4a4>
    80021e04:	0000b617          	auipc	a2,0xb
    80021e08:	20460613          	addi	a2,a2,516 # 8002d008 <initcode>
    80021e0c:	6d2c                	ld	a1,88(a0)
    80021e0e:	6928                	ld	a0,80(a0)
    80021e10:	fffff097          	auipc	ra,0xfffff
    80021e14:	19a080e7          	jalr	410(ra) # 80020faa <uvminit>
    p->sz = PGSIZE;
    80021e18:	0524b423          	sd	s2,72(s1)
    p->trapframe->epc = 0x3E;      // user program counter
    80021e1c:	70bc                	ld	a5,96(s1)
    80021e1e:	03e00713          	li	a4,62
    80021e22:	ef98                	sd	a4,24(a5)
    p->trapframe->sp = PGSIZE;  // user stack pointer
    80021e24:	70bc                	ld	a5,96(s1)
    80021e26:	0327b823          	sd	s2,48(a5)
    safestrcpy(p->name, "initcode", sizeof(p->name));
    80021e2a:	4641                	li	a2,16
    80021e2c:	00009597          	auipc	a1,0x9
    80021e30:	71458593          	addi	a1,a1,1812 # 8002b540 <digits+0x2b8>
    80021e34:	16048513          	addi	a0,s1,352
    80021e38:	fffff097          	auipc	ra,0xfffff
    80021e3c:	a68080e7          	jalr	-1432(ra) # 800208a0 <safestrcpy>
    p->state = RUNNABLE;
    80021e40:	4789                	li	a5,2
    80021e42:	cc9c                	sw	a5,24(s1)
    p->tmask = 0;
    80021e44:	1604a823          	sw	zero,368(s1)
    release(&p->lock);
    80021e48:	8526                	mv	a0,s1
    80021e4a:	fffff097          	auipc	ra,0xfffff
    80021e4e:	8bc080e7          	jalr	-1860(ra) # 80020706 <release>
}
    80021e52:	60e2                	ld	ra,24(sp)
    80021e54:	6442                	ld	s0,16(sp)
    80021e56:	64a2                	ld	s1,8(sp)
    80021e58:	6902                	ld	s2,0(sp)
    80021e5a:	6105                	addi	sp,sp,32
    80021e5c:	8082                	ret

0000000080021e5e <growproc>:
{
    80021e5e:	1101                	addi	sp,sp,-32
    80021e60:	ec06                	sd	ra,24(sp)
    80021e62:	e822                	sd	s0,16(sp)
    80021e64:	e426                	sd	s1,8(sp)
    80021e66:	e04a                	sd	s2,0(sp)
    80021e68:	1000                	addi	s0,sp,32
    80021e6a:	84aa                	mv	s1,a0
    struct proc *p = myproc();
    80021e6c:	00000097          	auipc	ra,0x0
    80021e70:	c66080e7          	jalr	-922(ra) # 80021ad2 <myproc>
    80021e74:	892a                	mv	s2,a0
    sz = p->sz;
    80021e76:	6530                	ld	a2,72(a0)
    80021e78:	0006069b          	sext.w	a3,a2
    if(n > 0){
    80021e7c:	00904f63          	bgtz	s1,80021e9a <growproc+0x3c>
    } else if(n < 0){
    80021e80:	0204cd63          	bltz	s1,80021eba <growproc+0x5c>
    p->sz = sz;
    80021e84:	1682                	slli	a3,a3,0x20
    80021e86:	9281                	srli	a3,a3,0x20
    80021e88:	04d93423          	sd	a3,72(s2)
    return 0;
    80021e8c:	4501                	li	a0,0
}
    80021e8e:	60e2                	ld	ra,24(sp)
    80021e90:	6442                	ld	s0,16(sp)
    80021e92:	64a2                	ld	s1,8(sp)
    80021e94:	6902                	ld	s2,0(sp)
    80021e96:	6105                	addi	sp,sp,32
    80021e98:	8082                	ret
        if((sz = uvmalloc(p->pagetable, p->kpagetable, sz, sz + n)) == 0) {
    80021e9a:	9ea5                	addw	a3,a3,s1
    80021e9c:	1682                	slli	a3,a3,0x20
    80021e9e:	9281                	srli	a3,a3,0x20
    80021ea0:	1602                	slli	a2,a2,0x20
    80021ea2:	9201                	srli	a2,a2,0x20
    80021ea4:	6d2c                	ld	a1,88(a0)
    80021ea6:	6928                	ld	a0,80(a0)
    80021ea8:	fffff097          	auipc	ra,0xfffff
    80021eac:	1f8080e7          	jalr	504(ra) # 800210a0 <uvmalloc>
    80021eb0:	0005069b          	sext.w	a3,a0
    80021eb4:	fae1                	bnez	a3,80021e84 <growproc+0x26>
            return -1;
    80021eb6:	557d                	li	a0,-1
    80021eb8:	bfd9                	j	80021e8e <growproc+0x30>
        sz = uvmdealloc(p->pagetable, p->kpagetable, sz, sz + n);
    80021eba:	9ea5                	addw	a3,a3,s1
    80021ebc:	1682                	slli	a3,a3,0x20
    80021ebe:	9281                	srli	a3,a3,0x20
    80021ec0:	1602                	slli	a2,a2,0x20
    80021ec2:	9201                	srli	a2,a2,0x20
    80021ec4:	6d2c                	ld	a1,88(a0)
    80021ec6:	6928                	ld	a0,80(a0)
    80021ec8:	fffff097          	auipc	ra,0xfffff
    80021ecc:	16c080e7          	jalr	364(ra) # 80021034 <uvmdealloc>
    80021ed0:	0005069b          	sext.w	a3,a0
    80021ed4:	bf45                	j	80021e84 <growproc+0x26>

0000000080021ed6 <fork>:
{
    80021ed6:	7139                	addi	sp,sp,-64
    80021ed8:	fc06                	sd	ra,56(sp)
    80021eda:	f822                	sd	s0,48(sp)
    80021edc:	f426                	sd	s1,40(sp)
    80021ede:	f04a                	sd	s2,32(sp)
    80021ee0:	ec4e                	sd	s3,24(sp)
    80021ee2:	e852                	sd	s4,16(sp)
    80021ee4:	e456                	sd	s5,8(sp)
    80021ee6:	0080                	addi	s0,sp,64
    struct proc *p = myproc();
    80021ee8:	00000097          	auipc	ra,0x0
    80021eec:	bea080e7          	jalr	-1046(ra) # 80021ad2 <myproc>
    80021ef0:	8aaa                	mv	s5,a0
    if((np = allocproc()) == NULL){
    80021ef2:	00000097          	auipc	ra,0x0
    80021ef6:	e1c080e7          	jalr	-484(ra) # 80021d0e <allocproc>
    80021efa:	c965                	beqz	a0,80021fea <fork+0x114>
    80021efc:	8a2a                	mv	s4,a0
    if(uvmcopy(p->pagetable, np->pagetable, np->kpagetable, p->sz) < 0){
    80021efe:	048ab683          	ld	a3,72(s5)
    80021f02:	6d30                	ld	a2,88(a0)
    80021f04:	692c                	ld	a1,80(a0)
    80021f06:	050ab503          	ld	a0,80(s5)
    80021f0a:	fffff097          	auipc	ra,0xfffff
    80021f0e:	32e080e7          	jalr	814(ra) # 80021238 <uvmcopy>
    80021f12:	04054e63          	bltz	a0,80021f6e <fork+0x98>
    np->sz = p->sz;
    80021f16:	048ab783          	ld	a5,72(s5)
    80021f1a:	04fa3423          	sd	a5,72(s4)
    np->parent = p;
    80021f1e:	035a3023          	sd	s5,32(s4)
    np->tmask = p->tmask;
    80021f22:	170aa783          	lw	a5,368(s5)
    80021f26:	16fa2823          	sw	a5,368(s4)
    *(np->trapframe) = *(p->trapframe);
    80021f2a:	060ab683          	ld	a3,96(s5)
    80021f2e:	87b6                	mv	a5,a3
    80021f30:	060a3703          	ld	a4,96(s4)
    80021f34:	12068693          	addi	a3,a3,288
    80021f38:	0007b803          	ld	a6,0(a5)
    80021f3c:	6788                	ld	a0,8(a5)
    80021f3e:	6b8c                	ld	a1,16(a5)
    80021f40:	6f90                	ld	a2,24(a5)
    80021f42:	01073023          	sd	a6,0(a4) # 1000 <_start-0x8001f000>
    80021f46:	e708                	sd	a0,8(a4)
    80021f48:	eb0c                	sd	a1,16(a4)
    80021f4a:	ef10                	sd	a2,24(a4)
    80021f4c:	02078793          	addi	a5,a5,32
    80021f50:	02070713          	addi	a4,a4,32
    80021f54:	fed792e3          	bne	a5,a3,80021f38 <fork+0x62>
    np->trapframe->a0 = 0;
    80021f58:	060a3783          	ld	a5,96(s4)
    80021f5c:	0607b823          	sd	zero,112(a5)
    for(i = 0; i < NOFILE; i++)
    80021f60:	0d8a8493          	addi	s1,s5,216
    80021f64:	0d8a0913          	addi	s2,s4,216
    80021f68:	158a8993          	addi	s3,s5,344
    80021f6c:	a00d                	j	80021f8e <fork+0xb8>
        freeproc(np);
    80021f6e:	8552                	mv	a0,s4
    80021f70:	00000097          	auipc	ra,0x0
    80021f74:	d34080e7          	jalr	-716(ra) # 80021ca4 <freeproc>
        release(&np->lock);
    80021f78:	8552                	mv	a0,s4
    80021f7a:	ffffe097          	auipc	ra,0xffffe
    80021f7e:	78c080e7          	jalr	1932(ra) # 80020706 <release>
        return -1;
    80021f82:	54fd                	li	s1,-1
    80021f84:	a889                	j	80021fd6 <fork+0x100>
    for(i = 0; i < NOFILE; i++)
    80021f86:	04a1                	addi	s1,s1,8
    80021f88:	0921                	addi	s2,s2,8
    80021f8a:	01348b63          	beq	s1,s3,80021fa0 <fork+0xca>
        if(p->ofile[i])
    80021f8e:	6088                	ld	a0,0(s1)
    80021f90:	d97d                	beqz	a0,80021f86 <fork+0xb0>
            np->ofile[i] = filedup(p->ofile[i]);
    80021f92:	00002097          	auipc	ra,0x2
    80021f96:	880080e7          	jalr	-1920(ra) # 80023812 <filedup>
    80021f9a:	00a93023          	sd	a0,0(s2)
    80021f9e:	b7e5                	j	80021f86 <fork+0xb0>
    np->cwd = edup(p->cwd);
    80021fa0:	158ab503          	ld	a0,344(s5)
    80021fa4:	00004097          	auipc	ra,0x4
    80021fa8:	fe2080e7          	jalr	-30(ra) # 80025f86 <edup>
    80021fac:	14aa3c23          	sd	a0,344(s4)
    safestrcpy(np->name, p->name, sizeof(p->name));
    80021fb0:	4641                	li	a2,16
    80021fb2:	160a8593          	addi	a1,s5,352
    80021fb6:	160a0513          	addi	a0,s4,352
    80021fba:	fffff097          	auipc	ra,0xfffff
    80021fbe:	8e6080e7          	jalr	-1818(ra) # 800208a0 <safestrcpy>
    pid = np->pid;
    80021fc2:	038a2483          	lw	s1,56(s4)
    np->state = RUNNABLE;
    80021fc6:	4789                	li	a5,2
    80021fc8:	00fa2c23          	sw	a5,24(s4)
    release(&np->lock);
    80021fcc:	8552                	mv	a0,s4
    80021fce:	ffffe097          	auipc	ra,0xffffe
    80021fd2:	738080e7          	jalr	1848(ra) # 80020706 <release>
}
    80021fd6:	8526                	mv	a0,s1
    80021fd8:	70e2                	ld	ra,56(sp)
    80021fda:	7442                	ld	s0,48(sp)
    80021fdc:	74a2                	ld	s1,40(sp)
    80021fde:	7902                	ld	s2,32(sp)
    80021fe0:	69e2                	ld	s3,24(sp)
    80021fe2:	6a42                	ld	s4,16(sp)
    80021fe4:	6aa2                	ld	s5,8(sp)
    80021fe6:	6121                	addi	sp,sp,64
    80021fe8:	8082                	ret
        return -1;
    80021fea:	54fd                	li	s1,-1
    80021fec:	b7ed                	j	80021fd6 <fork+0x100>

0000000080021fee <reparent>:
{
    80021fee:	7179                	addi	sp,sp,-48
    80021ff0:	f406                	sd	ra,40(sp)
    80021ff2:	f022                	sd	s0,32(sp)
    80021ff4:	ec26                	sd	s1,24(sp)
    80021ff6:	e84a                	sd	s2,16(sp)
    80021ff8:	e44e                	sd	s3,8(sp)
    80021ffa:	e052                	sd	s4,0(sp)
    80021ffc:	1800                	addi	s0,sp,48
    80021ffe:	892a                	mv	s2,a0
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80022000:	00015497          	auipc	s1,0x15
    80022004:	18048493          	addi	s1,s1,384 # 80037180 <proc>
            pp->parent = initproc;
    80022008:	00015a17          	auipc	s4,0x15
    8002200c:	058a0a13          	addi	s4,s4,88 # 80037060 <pid_lock>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80022010:	0001a997          	auipc	s3,0x1a
    80022014:	ae098993          	addi	s3,s3,-1312 # 8003baf0 <bcache>
    80022018:	a029                	j	80022022 <reparent+0x34>
    8002201a:	17848493          	addi	s1,s1,376
    8002201e:	03348363          	beq	s1,s3,80022044 <reparent+0x56>
        if(pp->parent == p){
    80022022:	709c                	ld	a5,32(s1)
    80022024:	ff279be3          	bne	a5,s2,8002201a <reparent+0x2c>
            acquire(&pp->lock);
    80022028:	8526                	mv	a0,s1
    8002202a:	ffffe097          	auipc	ra,0xffffe
    8002202e:	688080e7          	jalr	1672(ra) # 800206b2 <acquire>
            pp->parent = initproc;
    80022032:	118a3783          	ld	a5,280(s4)
    80022036:	f09c                	sd	a5,32(s1)
            release(&pp->lock);
    80022038:	8526                	mv	a0,s1
    8002203a:	ffffe097          	auipc	ra,0xffffe
    8002203e:	6cc080e7          	jalr	1740(ra) # 80020706 <release>
    80022042:	bfe1                	j	8002201a <reparent+0x2c>
}
    80022044:	70a2                	ld	ra,40(sp)
    80022046:	7402                	ld	s0,32(sp)
    80022048:	64e2                	ld	s1,24(sp)
    8002204a:	6942                	ld	s2,16(sp)
    8002204c:	69a2                	ld	s3,8(sp)
    8002204e:	6a02                	ld	s4,0(sp)
    80022050:	6145                	addi	sp,sp,48
    80022052:	8082                	ret

0000000080022054 <scheduler>:
{
    80022054:	715d                	addi	sp,sp,-80
    80022056:	e486                	sd	ra,72(sp)
    80022058:	e0a2                	sd	s0,64(sp)
    8002205a:	fc26                	sd	s1,56(sp)
    8002205c:	f84a                	sd	s2,48(sp)
    8002205e:	f44e                	sd	s3,40(sp)
    80022060:	f052                	sd	s4,32(sp)
    80022062:	ec56                	sd	s5,24(sp)
    80022064:	e85a                	sd	s6,16(sp)
    80022066:	e45e                	sd	s7,8(sp)
    80022068:	e062                	sd	s8,0(sp)
    8002206a:	0880                	addi	s0,sp,80
    8002206c:	8792                	mv	a5,tp
    int id = r_tp();
    8002206e:	2781                	sext.w	a5,a5
    c->proc = 0;
    80022070:	00779b13          	slli	s6,a5,0x7
    80022074:	00015717          	auipc	a4,0x15
    80022078:	fec70713          	addi	a4,a4,-20 # 80037060 <pid_lock>
    8002207c:	975a                	add	a4,a4,s6
    8002207e:	00073c23          	sd	zero,24(a4)
                swtch(&c->context, &p->context);
    80022082:	00015717          	auipc	a4,0x15
    80022086:	ffe70713          	addi	a4,a4,-2 # 80037080 <cpus+0x8>
    8002208a:	9b3a                	add	s6,s6,a4
                c->proc = p;
    8002208c:	079e                	slli	a5,a5,0x7
    8002208e:	00015a97          	auipc	s5,0x15
    80022092:	fd2a8a93          	addi	s5,s5,-46 # 80037060 <pid_lock>
    80022096:	9abe                	add	s5,s5,a5
                w_satp(MAKE_SATP(p->kpagetable));
    80022098:	5a7d                	li	s4,-1
    8002209a:	1a7e                	slli	s4,s4,0x3f
                w_satp(MAKE_SATP(kernel_pagetable));
    8002209c:	0000cb97          	auipc	s7,0xc
    800220a0:	454bbb83          	ld	s7,1108(s7) # 8002e4f0 <_GLOBAL_OFFSET_TABLE_+0x48>
    800220a4:	a8a5                	j	8002211c <scheduler+0xc8>
            release(&p->lock);
    800220a6:	8526                	mv	a0,s1
    800220a8:	ffffe097          	auipc	ra,0xffffe
    800220ac:	65e080e7          	jalr	1630(ra) # 80020706 <release>
        for(p = proc; p < &proc[NPROC]; p++) {
    800220b0:	17848493          	addi	s1,s1,376
    800220b4:	05248a63          	beq	s1,s2,80022108 <scheduler+0xb4>
            acquire(&p->lock);
    800220b8:	8526                	mv	a0,s1
    800220ba:	ffffe097          	auipc	ra,0xffffe
    800220be:	5f8080e7          	jalr	1528(ra) # 800206b2 <acquire>
            if(p->state == RUNNABLE) {
    800220c2:	4c9c                	lw	a5,24(s1)
    800220c4:	ff3791e3          	bne	a5,s3,800220a6 <scheduler+0x52>
                p->state = RUNNING;
    800220c8:	478d                	li	a5,3
    800220ca:	cc9c                	sw	a5,24(s1)
                c->proc = p;
    800220cc:	009abc23          	sd	s1,24(s5)
                w_satp(MAKE_SATP(p->kpagetable));
    800220d0:	6cbc                	ld	a5,88(s1)
    800220d2:	83b1                	srli	a5,a5,0xc
    800220d4:	0147e7b3          	or	a5,a5,s4
  asm volatile("csrw satp, %0" : : "r" (x));
    800220d8:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    800220dc:	12000073          	sfence.vma
                swtch(&c->context, &p->context);
    800220e0:	06848593          	addi	a1,s1,104
    800220e4:	855a                	mv	a0,s6
    800220e6:	00000097          	auipc	ra,0x0
    800220ea:	60c080e7          	jalr	1548(ra) # 800226f2 <swtch>
                w_satp(MAKE_SATP(kernel_pagetable));
    800220ee:	000bb783          	ld	a5,0(s7)
    800220f2:	83b1                	srli	a5,a5,0xc
    800220f4:	0147e7b3          	or	a5,a5,s4
  asm volatile("csrw satp, %0" : : "r" (x));
    800220f8:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    800220fc:	12000073          	sfence.vma
                c->proc = 0;
    80022100:	000abc23          	sd	zero,24(s5)
                found = 1;
    80022104:	4c05                	li	s8,1
    80022106:	b745                	j	800220a6 <scheduler+0x52>
        if(found == 0) {
    80022108:	000c1a63          	bnez	s8,8002211c <scheduler+0xc8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002210c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80022110:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022114:	10079073          	csrw	sstatus,a5
            asm volatile("wfi");
    80022118:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002211c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80022120:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022124:	10079073          	csrw	sstatus,a5
        int found = 0;
    80022128:	4c01                	li	s8,0
        for(p = proc; p < &proc[NPROC]; p++) {
    8002212a:	00015497          	auipc	s1,0x15
    8002212e:	05648493          	addi	s1,s1,86 # 80037180 <proc>
            if(p->state == RUNNABLE) {
    80022132:	4989                	li	s3,2
        for(p = proc; p < &proc[NPROC]; p++) {
    80022134:	0001a917          	auipc	s2,0x1a
    80022138:	9bc90913          	addi	s2,s2,-1604 # 8003baf0 <bcache>
    8002213c:	bfb5                	j	800220b8 <scheduler+0x64>

000000008002213e <sched>:
{
    8002213e:	7179                	addi	sp,sp,-48
    80022140:	f406                	sd	ra,40(sp)
    80022142:	f022                	sd	s0,32(sp)
    80022144:	ec26                	sd	s1,24(sp)
    80022146:	e84a                	sd	s2,16(sp)
    80022148:	e44e                	sd	s3,8(sp)
    8002214a:	1800                	addi	s0,sp,48
    struct proc *p = myproc();
    8002214c:	00000097          	auipc	ra,0x0
    80022150:	986080e7          	jalr	-1658(ra) # 80021ad2 <myproc>
    80022154:	84aa                	mv	s1,a0
    if(!holding(&p->lock))
    80022156:	ffffe097          	auipc	ra,0xffffe
    8002215a:	52e080e7          	jalr	1326(ra) # 80020684 <holding>
    8002215e:	c93d                	beqz	a0,800221d4 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80022160:	8792                	mv	a5,tp
    if(mycpu()->noff != 1)
    80022162:	2781                	sext.w	a5,a5
    80022164:	079e                	slli	a5,a5,0x7
    80022166:	00015717          	auipc	a4,0x15
    8002216a:	efa70713          	addi	a4,a4,-262 # 80037060 <pid_lock>
    8002216e:	97ba                	add	a5,a5,a4
    80022170:	0907a703          	lw	a4,144(a5)
    80022174:	4785                	li	a5,1
    80022176:	06f71763          	bne	a4,a5,800221e4 <sched+0xa6>
    if(p->state == RUNNING)
    8002217a:	4c98                	lw	a4,24(s1)
    8002217c:	478d                	li	a5,3
    8002217e:	06f70b63          	beq	a4,a5,800221f4 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022182:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80022186:	8b89                	andi	a5,a5,2
    if(intr_get())
    80022188:	efb5                	bnez	a5,80022204 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    8002218a:	8792                	mv	a5,tp
    intena = mycpu()->intena;
    8002218c:	00015917          	auipc	s2,0x15
    80022190:	ed490913          	addi	s2,s2,-300 # 80037060 <pid_lock>
    80022194:	2781                	sext.w	a5,a5
    80022196:	079e                	slli	a5,a5,0x7
    80022198:	97ca                	add	a5,a5,s2
    8002219a:	0947a983          	lw	s3,148(a5)
    8002219e:	8792                	mv	a5,tp
    swtch(&p->context, &mycpu()->context);
    800221a0:	2781                	sext.w	a5,a5
    800221a2:	079e                	slli	a5,a5,0x7
    800221a4:	00015597          	auipc	a1,0x15
    800221a8:	edc58593          	addi	a1,a1,-292 # 80037080 <cpus+0x8>
    800221ac:	95be                	add	a1,a1,a5
    800221ae:	06848513          	addi	a0,s1,104
    800221b2:	00000097          	auipc	ra,0x0
    800221b6:	540080e7          	jalr	1344(ra) # 800226f2 <swtch>
    800221ba:	8792                	mv	a5,tp
    mycpu()->intena = intena;
    800221bc:	2781                	sext.w	a5,a5
    800221be:	079e                	slli	a5,a5,0x7
    800221c0:	97ca                	add	a5,a5,s2
    800221c2:	0937aa23          	sw	s3,148(a5)
}
    800221c6:	70a2                	ld	ra,40(sp)
    800221c8:	7402                	ld	s0,32(sp)
    800221ca:	64e2                	ld	s1,24(sp)
    800221cc:	6942                	ld	s2,16(sp)
    800221ce:	69a2                	ld	s3,8(sp)
    800221d0:	6145                	addi	sp,sp,48
    800221d2:	8082                	ret
        panic("sched p->lock");
    800221d4:	00009517          	auipc	a0,0x9
    800221d8:	37c50513          	addi	a0,a0,892 # 8002b550 <digits+0x2c8>
    800221dc:	ffffe097          	auipc	ra,0xffffe
    800221e0:	f66080e7          	jalr	-154(ra) # 80020142 <panic>
        panic("sched locks");
    800221e4:	00009517          	auipc	a0,0x9
    800221e8:	37c50513          	addi	a0,a0,892 # 8002b560 <digits+0x2d8>
    800221ec:	ffffe097          	auipc	ra,0xffffe
    800221f0:	f56080e7          	jalr	-170(ra) # 80020142 <panic>
        panic("sched running");
    800221f4:	00009517          	auipc	a0,0x9
    800221f8:	37c50513          	addi	a0,a0,892 # 8002b570 <digits+0x2e8>
    800221fc:	ffffe097          	auipc	ra,0xffffe
    80022200:	f46080e7          	jalr	-186(ra) # 80020142 <panic>
        panic("sched interruptible");
    80022204:	00009517          	auipc	a0,0x9
    80022208:	37c50513          	addi	a0,a0,892 # 8002b580 <digits+0x2f8>
    8002220c:	ffffe097          	auipc	ra,0xffffe
    80022210:	f36080e7          	jalr	-202(ra) # 80020142 <panic>

0000000080022214 <exit>:
{
    80022214:	7179                	addi	sp,sp,-48
    80022216:	f406                	sd	ra,40(sp)
    80022218:	f022                	sd	s0,32(sp)
    8002221a:	ec26                	sd	s1,24(sp)
    8002221c:	e84a                	sd	s2,16(sp)
    8002221e:	e44e                	sd	s3,8(sp)
    80022220:	e052                	sd	s4,0(sp)
    80022222:	1800                	addi	s0,sp,48
    80022224:	8a2a                	mv	s4,a0
    struct proc *p = myproc();
    80022226:	00000097          	auipc	ra,0x0
    8002222a:	8ac080e7          	jalr	-1876(ra) # 80021ad2 <myproc>
    8002222e:	89aa                	mv	s3,a0
    if(p == initproc)
    80022230:	00015797          	auipc	a5,0x15
    80022234:	f487b783          	ld	a5,-184(a5) # 80037178 <initproc>
    80022238:	0d850493          	addi	s1,a0,216
    8002223c:	15850913          	addi	s2,a0,344
    80022240:	02a79363          	bne	a5,a0,80022266 <exit+0x52>
        panic("init exiting");
    80022244:	00009517          	auipc	a0,0x9
    80022248:	35450513          	addi	a0,a0,852 # 8002b598 <digits+0x310>
    8002224c:	ffffe097          	auipc	ra,0xffffe
    80022250:	ef6080e7          	jalr	-266(ra) # 80020142 <panic>
            fileclose(f);
    80022254:	00001097          	auipc	ra,0x1
    80022258:	610080e7          	jalr	1552(ra) # 80023864 <fileclose>
            p->ofile[fd] = 0;
    8002225c:	0004b023          	sd	zero,0(s1)
    for(int fd = 0; fd < NOFILE; fd++){
    80022260:	04a1                	addi	s1,s1,8
    80022262:	01248563          	beq	s1,s2,8002226c <exit+0x58>
        if(p->ofile[fd]){
    80022266:	6088                	ld	a0,0(s1)
    80022268:	f575                	bnez	a0,80022254 <exit+0x40>
    8002226a:	bfdd                	j	80022260 <exit+0x4c>
    eput(p->cwd);
    8002226c:	1589b503          	ld	a0,344(s3)
    80022270:	00004097          	auipc	ra,0x4
    80022274:	ff8080e7          	jalr	-8(ra) # 80026268 <eput>
    p->cwd = 0;
    80022278:	1409bc23          	sd	zero,344(s3)
    acquire(&initproc->lock);
    8002227c:	00015497          	auipc	s1,0x15
    80022280:	de448493          	addi	s1,s1,-540 # 80037060 <pid_lock>
    80022284:	1184b503          	ld	a0,280(s1)
    80022288:	ffffe097          	auipc	ra,0xffffe
    8002228c:	42a080e7          	jalr	1066(ra) # 800206b2 <acquire>
    wakeup1(initproc);
    80022290:	1184b503          	ld	a0,280(s1)
    80022294:	fffff097          	auipc	ra,0xfffff
    80022298:	652080e7          	jalr	1618(ra) # 800218e6 <wakeup1>
    release(&initproc->lock);
    8002229c:	1184b503          	ld	a0,280(s1)
    800222a0:	ffffe097          	auipc	ra,0xffffe
    800222a4:	466080e7          	jalr	1126(ra) # 80020706 <release>
    acquire(&p->lock);
    800222a8:	854e                	mv	a0,s3
    800222aa:	ffffe097          	auipc	ra,0xffffe
    800222ae:	408080e7          	jalr	1032(ra) # 800206b2 <acquire>
    struct proc *original_parent = p->parent;
    800222b2:	0209b483          	ld	s1,32(s3)
    release(&p->lock);
    800222b6:	854e                	mv	a0,s3
    800222b8:	ffffe097          	auipc	ra,0xffffe
    800222bc:	44e080e7          	jalr	1102(ra) # 80020706 <release>
    acquire(&original_parent->lock);
    800222c0:	8526                	mv	a0,s1
    800222c2:	ffffe097          	auipc	ra,0xffffe
    800222c6:	3f0080e7          	jalr	1008(ra) # 800206b2 <acquire>
    acquire(&p->lock);
    800222ca:	854e                	mv	a0,s3
    800222cc:	ffffe097          	auipc	ra,0xffffe
    800222d0:	3e6080e7          	jalr	998(ra) # 800206b2 <acquire>
    reparent(p);
    800222d4:	854e                	mv	a0,s3
    800222d6:	00000097          	auipc	ra,0x0
    800222da:	d18080e7          	jalr	-744(ra) # 80021fee <reparent>
    wakeup1(original_parent);
    800222de:	8526                	mv	a0,s1
    800222e0:	fffff097          	auipc	ra,0xfffff
    800222e4:	606080e7          	jalr	1542(ra) # 800218e6 <wakeup1>
    p->xstate = status;
    800222e8:	0349aa23          	sw	s4,52(s3)
    p->state = ZOMBIE;
    800222ec:	4791                	li	a5,4
    800222ee:	00f9ac23          	sw	a5,24(s3)
    release(&original_parent->lock);
    800222f2:	8526                	mv	a0,s1
    800222f4:	ffffe097          	auipc	ra,0xffffe
    800222f8:	412080e7          	jalr	1042(ra) # 80020706 <release>
    sched();
    800222fc:	00000097          	auipc	ra,0x0
    80022300:	e42080e7          	jalr	-446(ra) # 8002213e <sched>
    panic("zombie exit");
    80022304:	00009517          	auipc	a0,0x9
    80022308:	2a450513          	addi	a0,a0,676 # 8002b5a8 <digits+0x320>
    8002230c:	ffffe097          	auipc	ra,0xffffe
    80022310:	e36080e7          	jalr	-458(ra) # 80020142 <panic>

0000000080022314 <yield>:
{
    80022314:	1101                	addi	sp,sp,-32
    80022316:	ec06                	sd	ra,24(sp)
    80022318:	e822                	sd	s0,16(sp)
    8002231a:	e426                	sd	s1,8(sp)
    8002231c:	1000                	addi	s0,sp,32
    struct proc *p = myproc();
    8002231e:	fffff097          	auipc	ra,0xfffff
    80022322:	7b4080e7          	jalr	1972(ra) # 80021ad2 <myproc>
    80022326:	84aa                	mv	s1,a0
    acquire(&p->lock);
    80022328:	ffffe097          	auipc	ra,0xffffe
    8002232c:	38a080e7          	jalr	906(ra) # 800206b2 <acquire>
    p->state = RUNNABLE;
    80022330:	4789                	li	a5,2
    80022332:	cc9c                	sw	a5,24(s1)
    sched();
    80022334:	00000097          	auipc	ra,0x0
    80022338:	e0a080e7          	jalr	-502(ra) # 8002213e <sched>
    release(&p->lock);
    8002233c:	8526                	mv	a0,s1
    8002233e:	ffffe097          	auipc	ra,0xffffe
    80022342:	3c8080e7          	jalr	968(ra) # 80020706 <release>
}
    80022346:	60e2                	ld	ra,24(sp)
    80022348:	6442                	ld	s0,16(sp)
    8002234a:	64a2                	ld	s1,8(sp)
    8002234c:	6105                	addi	sp,sp,32
    8002234e:	8082                	ret

0000000080022350 <sleep>:
{
    80022350:	7179                	addi	sp,sp,-48
    80022352:	f406                	sd	ra,40(sp)
    80022354:	f022                	sd	s0,32(sp)
    80022356:	ec26                	sd	s1,24(sp)
    80022358:	e84a                	sd	s2,16(sp)
    8002235a:	e44e                	sd	s3,8(sp)
    8002235c:	1800                	addi	s0,sp,48
    8002235e:	89aa                	mv	s3,a0
    80022360:	892e                	mv	s2,a1
    struct proc *p = myproc();
    80022362:	fffff097          	auipc	ra,0xfffff
    80022366:	770080e7          	jalr	1904(ra) # 80021ad2 <myproc>
    8002236a:	84aa                	mv	s1,a0
    if(lk != &p->lock){  //DOC: sleeplock0
    8002236c:	05250663          	beq	a0,s2,800223b8 <sleep+0x68>
        acquire(&p->lock);  //DOC: sleeplock1
    80022370:	ffffe097          	auipc	ra,0xffffe
    80022374:	342080e7          	jalr	834(ra) # 800206b2 <acquire>
        release(lk);
    80022378:	854a                	mv	a0,s2
    8002237a:	ffffe097          	auipc	ra,0xffffe
    8002237e:	38c080e7          	jalr	908(ra) # 80020706 <release>
    p->chan = chan;
    80022382:	0334b423          	sd	s3,40(s1)
    p->state = SLEEPING;
    80022386:	4785                	li	a5,1
    80022388:	cc9c                	sw	a5,24(s1)
    sched();
    8002238a:	00000097          	auipc	ra,0x0
    8002238e:	db4080e7          	jalr	-588(ra) # 8002213e <sched>
    p->chan = 0;
    80022392:	0204b423          	sd	zero,40(s1)
        release(&p->lock);
    80022396:	8526                	mv	a0,s1
    80022398:	ffffe097          	auipc	ra,0xffffe
    8002239c:	36e080e7          	jalr	878(ra) # 80020706 <release>
        acquire(lk);
    800223a0:	854a                	mv	a0,s2
    800223a2:	ffffe097          	auipc	ra,0xffffe
    800223a6:	310080e7          	jalr	784(ra) # 800206b2 <acquire>
}
    800223aa:	70a2                	ld	ra,40(sp)
    800223ac:	7402                	ld	s0,32(sp)
    800223ae:	64e2                	ld	s1,24(sp)
    800223b0:	6942                	ld	s2,16(sp)
    800223b2:	69a2                	ld	s3,8(sp)
    800223b4:	6145                	addi	sp,sp,48
    800223b6:	8082                	ret
    p->chan = chan;
    800223b8:	03353423          	sd	s3,40(a0)
    p->state = SLEEPING;
    800223bc:	4785                	li	a5,1
    800223be:	cd1c                	sw	a5,24(a0)
    sched();
    800223c0:	00000097          	auipc	ra,0x0
    800223c4:	d7e080e7          	jalr	-642(ra) # 8002213e <sched>
    p->chan = 0;
    800223c8:	0204b423          	sd	zero,40(s1)
    if(lk != &p->lock){
    800223cc:	bff9                	j	800223aa <sleep+0x5a>

00000000800223ce <wait>:
{
    800223ce:	715d                	addi	sp,sp,-80
    800223d0:	e486                	sd	ra,72(sp)
    800223d2:	e0a2                	sd	s0,64(sp)
    800223d4:	fc26                	sd	s1,56(sp)
    800223d6:	f84a                	sd	s2,48(sp)
    800223d8:	f44e                	sd	s3,40(sp)
    800223da:	f052                	sd	s4,32(sp)
    800223dc:	ec56                	sd	s5,24(sp)
    800223de:	e85a                	sd	s6,16(sp)
    800223e0:	e45e                	sd	s7,8(sp)
    800223e2:	0880                	addi	s0,sp,80
    800223e4:	8b2a                	mv	s6,a0
    struct proc *p = myproc();
    800223e6:	fffff097          	auipc	ra,0xfffff
    800223ea:	6ec080e7          	jalr	1772(ra) # 80021ad2 <myproc>
    800223ee:	892a                	mv	s2,a0
    acquire(&p->lock);
    800223f0:	ffffe097          	auipc	ra,0xffffe
    800223f4:	2c2080e7          	jalr	706(ra) # 800206b2 <acquire>
        havekids = 0;
    800223f8:	4b81                	li	s7,0
                if(np->state == ZOMBIE){
    800223fa:	4a11                	li	s4,4
                havekids = 1;
    800223fc:	4a85                	li	s5,1
        for(np = proc; np < &proc[NPROC]; np++){
    800223fe:	00019997          	auipc	s3,0x19
    80022402:	6f298993          	addi	s3,s3,1778 # 8003baf0 <bcache>
        havekids = 0;
    80022406:	875e                	mv	a4,s7
        for(np = proc; np < &proc[NPROC]; np++){
    80022408:	00015497          	auipc	s1,0x15
    8002240c:	d7848493          	addi	s1,s1,-648 # 80037180 <proc>
    80022410:	a8b9                	j	8002246e <wait+0xa0>
                    pid = np->pid;
    80022412:	0384a983          	lw	s3,56(s1)
                    if(addr != 0 && copyout2(addr, (char *)&np->xstate, sizeof(np->xstate)) < 0) {
    80022416:	000b0c63          	beqz	s6,8002242e <wait+0x60>
    8002241a:	4611                	li	a2,4
    8002241c:	03448593          	addi	a1,s1,52
    80022420:	855a                	mv	a0,s6
    80022422:	fffff097          	auipc	ra,0xfffff
    80022426:	fe2080e7          	jalr	-30(ra) # 80021404 <copyout2>
    8002242a:	02054263          	bltz	a0,8002244e <wait+0x80>
                    freeproc(np);
    8002242e:	8526                	mv	a0,s1
    80022430:	00000097          	auipc	ra,0x0
    80022434:	874080e7          	jalr	-1932(ra) # 80021ca4 <freeproc>
                    release(&np->lock);
    80022438:	8526                	mv	a0,s1
    8002243a:	ffffe097          	auipc	ra,0xffffe
    8002243e:	2cc080e7          	jalr	716(ra) # 80020706 <release>
                    release(&p->lock);
    80022442:	854a                	mv	a0,s2
    80022444:	ffffe097          	auipc	ra,0xffffe
    80022448:	2c2080e7          	jalr	706(ra) # 80020706 <release>
                    return pid;
    8002244c:	a8a9                	j	800224a6 <wait+0xd8>
                        release(&np->lock);
    8002244e:	8526                	mv	a0,s1
    80022450:	ffffe097          	auipc	ra,0xffffe
    80022454:	2b6080e7          	jalr	694(ra) # 80020706 <release>
                        release(&p->lock);
    80022458:	854a                	mv	a0,s2
    8002245a:	ffffe097          	auipc	ra,0xffffe
    8002245e:	2ac080e7          	jalr	684(ra) # 80020706 <release>
                        return -1;
    80022462:	59fd                	li	s3,-1
    80022464:	a089                	j	800224a6 <wait+0xd8>
        for(np = proc; np < &proc[NPROC]; np++){
    80022466:	17848493          	addi	s1,s1,376
    8002246a:	03348463          	beq	s1,s3,80022492 <wait+0xc4>
            if(np->parent == p){
    8002246e:	709c                	ld	a5,32(s1)
    80022470:	ff279be3          	bne	a5,s2,80022466 <wait+0x98>
                acquire(&np->lock);
    80022474:	8526                	mv	a0,s1
    80022476:	ffffe097          	auipc	ra,0xffffe
    8002247a:	23c080e7          	jalr	572(ra) # 800206b2 <acquire>
                if(np->state == ZOMBIE){
    8002247e:	4c9c                	lw	a5,24(s1)
    80022480:	f94789e3          	beq	a5,s4,80022412 <wait+0x44>
                release(&np->lock);
    80022484:	8526                	mv	a0,s1
    80022486:	ffffe097          	auipc	ra,0xffffe
    8002248a:	280080e7          	jalr	640(ra) # 80020706 <release>
                havekids = 1;
    8002248e:	8756                	mv	a4,s5
    80022490:	bfd9                	j	80022466 <wait+0x98>
        if(!havekids || p->killed){
    80022492:	c701                	beqz	a4,8002249a <wait+0xcc>
    80022494:	03092783          	lw	a5,48(s2)
    80022498:	c39d                	beqz	a5,800224be <wait+0xf0>
            release(&p->lock);
    8002249a:	854a                	mv	a0,s2
    8002249c:	ffffe097          	auipc	ra,0xffffe
    800224a0:	26a080e7          	jalr	618(ra) # 80020706 <release>
            return -1;
    800224a4:	59fd                	li	s3,-1
}
    800224a6:	854e                	mv	a0,s3
    800224a8:	60a6                	ld	ra,72(sp)
    800224aa:	6406                	ld	s0,64(sp)
    800224ac:	74e2                	ld	s1,56(sp)
    800224ae:	7942                	ld	s2,48(sp)
    800224b0:	79a2                	ld	s3,40(sp)
    800224b2:	7a02                	ld	s4,32(sp)
    800224b4:	6ae2                	ld	s5,24(sp)
    800224b6:	6b42                	ld	s6,16(sp)
    800224b8:	6ba2                	ld	s7,8(sp)
    800224ba:	6161                	addi	sp,sp,80
    800224bc:	8082                	ret
        sleep(p, &p->lock);  //DOC: wait-sleep
    800224be:	85ca                	mv	a1,s2
    800224c0:	854a                	mv	a0,s2
    800224c2:	00000097          	auipc	ra,0x0
    800224c6:	e8e080e7          	jalr	-370(ra) # 80022350 <sleep>
        havekids = 0;
    800224ca:	bf35                	j	80022406 <wait+0x38>

00000000800224cc <wakeup>:
{
    800224cc:	7139                	addi	sp,sp,-64
    800224ce:	fc06                	sd	ra,56(sp)
    800224d0:	f822                	sd	s0,48(sp)
    800224d2:	f426                	sd	s1,40(sp)
    800224d4:	f04a                	sd	s2,32(sp)
    800224d6:	ec4e                	sd	s3,24(sp)
    800224d8:	e852                	sd	s4,16(sp)
    800224da:	e456                	sd	s5,8(sp)
    800224dc:	0080                	addi	s0,sp,64
    800224de:	8a2a                	mv	s4,a0
    for(p = proc; p < &proc[NPROC]; p++) {
    800224e0:	00015497          	auipc	s1,0x15
    800224e4:	ca048493          	addi	s1,s1,-864 # 80037180 <proc>
        if(p->state == SLEEPING && p->chan == chan) {
    800224e8:	4985                	li	s3,1
            p->state = RUNNABLE;
    800224ea:	4a89                	li	s5,2
    for(p = proc; p < &proc[NPROC]; p++) {
    800224ec:	00019917          	auipc	s2,0x19
    800224f0:	60490913          	addi	s2,s2,1540 # 8003baf0 <bcache>
    800224f4:	a811                	j	80022508 <wakeup+0x3c>
        release(&p->lock);
    800224f6:	8526                	mv	a0,s1
    800224f8:	ffffe097          	auipc	ra,0xffffe
    800224fc:	20e080e7          	jalr	526(ra) # 80020706 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80022500:	17848493          	addi	s1,s1,376
    80022504:	03248063          	beq	s1,s2,80022524 <wakeup+0x58>
        acquire(&p->lock);
    80022508:	8526                	mv	a0,s1
    8002250a:	ffffe097          	auipc	ra,0xffffe
    8002250e:	1a8080e7          	jalr	424(ra) # 800206b2 <acquire>
        if(p->state == SLEEPING && p->chan == chan) {
    80022512:	4c9c                	lw	a5,24(s1)
    80022514:	ff3791e3          	bne	a5,s3,800224f6 <wakeup+0x2a>
    80022518:	749c                	ld	a5,40(s1)
    8002251a:	fd479ee3          	bne	a5,s4,800224f6 <wakeup+0x2a>
            p->state = RUNNABLE;
    8002251e:	0154ac23          	sw	s5,24(s1)
    80022522:	bfd1                	j	800224f6 <wakeup+0x2a>
}
    80022524:	70e2                	ld	ra,56(sp)
    80022526:	7442                	ld	s0,48(sp)
    80022528:	74a2                	ld	s1,40(sp)
    8002252a:	7902                	ld	s2,32(sp)
    8002252c:	69e2                	ld	s3,24(sp)
    8002252e:	6a42                	ld	s4,16(sp)
    80022530:	6aa2                	ld	s5,8(sp)
    80022532:	6121                	addi	sp,sp,64
    80022534:	8082                	ret

0000000080022536 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80022536:	7179                	addi	sp,sp,-48
    80022538:	f406                	sd	ra,40(sp)
    8002253a:	f022                	sd	s0,32(sp)
    8002253c:	ec26                	sd	s1,24(sp)
    8002253e:	e84a                	sd	s2,16(sp)
    80022540:	e44e                	sd	s3,8(sp)
    80022542:	1800                	addi	s0,sp,48
    80022544:	892a                	mv	s2,a0
    struct proc *p;

    for(p = proc; p < &proc[NPROC]; p++){
    80022546:	00015497          	auipc	s1,0x15
    8002254a:	c3a48493          	addi	s1,s1,-966 # 80037180 <proc>
    8002254e:	00019997          	auipc	s3,0x19
    80022552:	5a298993          	addi	s3,s3,1442 # 8003baf0 <bcache>
        acquire(&p->lock);
    80022556:	8526                	mv	a0,s1
    80022558:	ffffe097          	auipc	ra,0xffffe
    8002255c:	15a080e7          	jalr	346(ra) # 800206b2 <acquire>
        if(p->pid == pid){
    80022560:	5c9c                	lw	a5,56(s1)
    80022562:	01278d63          	beq	a5,s2,8002257c <kill+0x46>
                p->state = RUNNABLE;
            }
            release(&p->lock);
            return 0;
        }
        release(&p->lock);
    80022566:	8526                	mv	a0,s1
    80022568:	ffffe097          	auipc	ra,0xffffe
    8002256c:	19e080e7          	jalr	414(ra) # 80020706 <release>
    for(p = proc; p < &proc[NPROC]; p++){
    80022570:	17848493          	addi	s1,s1,376
    80022574:	ff3491e3          	bne	s1,s3,80022556 <kill+0x20>
    }
    return -1;
    80022578:	557d                	li	a0,-1
    8002257a:	a821                	j	80022592 <kill+0x5c>
            p->killed = 1;
    8002257c:	4785                	li	a5,1
    8002257e:	d89c                	sw	a5,48(s1)
            if(p->state == SLEEPING){
    80022580:	4c98                	lw	a4,24(s1)
    80022582:	00f70f63          	beq	a4,a5,800225a0 <kill+0x6a>
            release(&p->lock);
    80022586:	8526                	mv	a0,s1
    80022588:	ffffe097          	auipc	ra,0xffffe
    8002258c:	17e080e7          	jalr	382(ra) # 80020706 <release>
            return 0;
    80022590:	4501                	li	a0,0
}
    80022592:	70a2                	ld	ra,40(sp)
    80022594:	7402                	ld	s0,32(sp)
    80022596:	64e2                	ld	s1,24(sp)
    80022598:	6942                	ld	s2,16(sp)
    8002259a:	69a2                	ld	s3,8(sp)
    8002259c:	6145                	addi	sp,sp,48
    8002259e:	8082                	ret
                p->state = RUNNABLE;
    800225a0:	4789                	li	a5,2
    800225a2:	cc9c                	sw	a5,24(s1)
    800225a4:	b7cd                	j	80022586 <kill+0x50>

00000000800225a6 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800225a6:	1101                	addi	sp,sp,-32
    800225a8:	ec06                	sd	ra,24(sp)
    800225aa:	e822                	sd	s0,16(sp)
    800225ac:	e426                	sd	s1,8(sp)
    800225ae:	1000                	addi	s0,sp,32
    800225b0:	84aa                	mv	s1,a0
    800225b2:	852e                	mv	a0,a1
    800225b4:	85b2                	mv	a1,a2
    800225b6:	8636                	mv	a2,a3
    // struct proc *p = myproc();
    if(user_dst){
    800225b8:	c891                	beqz	s1,800225cc <either_copyout+0x26>
        // return copyout(p->pagetable, dst, src, len);
        return copyout2(dst, src, len);
    800225ba:	fffff097          	auipc	ra,0xfffff
    800225be:	e4a080e7          	jalr	-438(ra) # 80021404 <copyout2>
    } else {
        memmove((char *)dst, src, len);
        return 0;
    }
}
    800225c2:	60e2                	ld	ra,24(sp)
    800225c4:	6442                	ld	s0,16(sp)
    800225c6:	64a2                	ld	s1,8(sp)
    800225c8:	6105                	addi	sp,sp,32
    800225ca:	8082                	ret
        memmove((char *)dst, src, len);
    800225cc:	0006861b          	sext.w	a2,a3
    800225d0:	ffffe097          	auipc	ra,0xffffe
    800225d4:	1da080e7          	jalr	474(ra) # 800207aa <memmove>
        return 0;
    800225d8:	8526                	mv	a0,s1
    800225da:	b7e5                	j	800225c2 <either_copyout+0x1c>

00000000800225dc <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800225dc:	1101                	addi	sp,sp,-32
    800225de:	ec06                	sd	ra,24(sp)
    800225e0:	e822                	sd	s0,16(sp)
    800225e2:	e426                	sd	s1,8(sp)
    800225e4:	1000                	addi	s0,sp,32
    800225e6:	84ae                	mv	s1,a1
    800225e8:	85b2                	mv	a1,a2
    800225ea:	8636                	mv	a2,a3
    // struct proc *p = myproc();
    if(user_src){
    800225ec:	c891                	beqz	s1,80022600 <either_copyin+0x24>
        // return copyin(p->pagetable, dst, src, len);
        return copyin2(dst, src, len);
    800225ee:	fffff097          	auipc	ra,0xfffff
    800225f2:	ef6080e7          	jalr	-266(ra) # 800214e4 <copyin2>
    } else {
        memmove(dst, (char*)src, len);
        return 0;
    }
}
    800225f6:	60e2                	ld	ra,24(sp)
    800225f8:	6442                	ld	s0,16(sp)
    800225fa:	64a2                	ld	s1,8(sp)
    800225fc:	6105                	addi	sp,sp,32
    800225fe:	8082                	ret
        memmove(dst, (char*)src, len);
    80022600:	0006861b          	sext.w	a2,a3
    80022604:	ffffe097          	auipc	ra,0xffffe
    80022608:	1a6080e7          	jalr	422(ra) # 800207aa <memmove>
        return 0;
    8002260c:	8526                	mv	a0,s1
    8002260e:	b7e5                	j	800225f6 <either_copyin+0x1a>

0000000080022610 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80022610:	715d                	addi	sp,sp,-80
    80022612:	e486                	sd	ra,72(sp)
    80022614:	e0a2                	sd	s0,64(sp)
    80022616:	fc26                	sd	s1,56(sp)
    80022618:	f84a                	sd	s2,48(sp)
    8002261a:	f44e                	sd	s3,40(sp)
    8002261c:	f052                	sd	s4,32(sp)
    8002261e:	ec56                	sd	s5,24(sp)
    80022620:	e85a                	sd	s6,16(sp)
    80022622:	e45e                	sd	s7,8(sp)
    80022624:	0880                	addi	s0,sp,80
            [ZOMBIE]    "zombie"
    };
    struct proc *p;
    char *state;

    printf("\nPID\tSTATE\tNAME\tMEM\n");
    80022626:	00009517          	auipc	a0,0x9
    8002262a:	f9a50513          	addi	a0,a0,-102 # 8002b5c0 <digits+0x338>
    8002262e:	ffffe097          	auipc	ra,0xffffe
    80022632:	b5e080e7          	jalr	-1186(ra) # 8002018c <printf>
    for(p = proc; p < &proc[NPROC]; p++){
    80022636:	00015497          	auipc	s1,0x15
    8002263a:	caa48493          	addi	s1,s1,-854 # 800372e0 <proc+0x160>
    8002263e:	00019917          	auipc	s2,0x19
    80022642:	61290913          	addi	s2,s2,1554 # 8003bc50 <bcache+0x160>
        if(p->state == UNUSED)
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80022646:	4b11                	li	s6,4
            state = states[p->state];
        else
            state = "???";
    80022648:	00009997          	auipc	s3,0x9
    8002264c:	f7098993          	addi	s3,s3,-144 # 8002b5b8 <digits+0x330>
        printf("%d\t%s\t%s\t%d", p->pid, state, p->name, p->sz);
    80022650:	00009a97          	auipc	s5,0x9
    80022654:	f88a8a93          	addi	s5,s5,-120 # 8002b5d8 <digits+0x350>
        printf("\n");
    80022658:	00009a17          	auipc	s4,0x9
    8002265c:	240a0a13          	addi	s4,s4,576 # 8002b898 <digits+0x610>
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80022660:	0000bb97          	auipc	s7,0xb
    80022664:	508b8b93          	addi	s7,s7,1288 # 8002db68 <states.0>
    80022668:	a01d                	j	8002268e <procdump+0x7e>
        printf("%d\t%s\t%s\t%d", p->pid, state, p->name, p->sz);
    8002266a:	ee86b703          	ld	a4,-280(a3)
    8002266e:	ed86a583          	lw	a1,-296(a3)
    80022672:	8556                	mv	a0,s5
    80022674:	ffffe097          	auipc	ra,0xffffe
    80022678:	b18080e7          	jalr	-1256(ra) # 8002018c <printf>
        printf("\n");
    8002267c:	8552                	mv	a0,s4
    8002267e:	ffffe097          	auipc	ra,0xffffe
    80022682:	b0e080e7          	jalr	-1266(ra) # 8002018c <printf>
    for(p = proc; p < &proc[NPROC]; p++){
    80022686:	17848493          	addi	s1,s1,376
    8002268a:	03248163          	beq	s1,s2,800226ac <procdump+0x9c>
        if(p->state == UNUSED)
    8002268e:	86a6                	mv	a3,s1
    80022690:	eb84a783          	lw	a5,-328(s1)
    80022694:	dbed                	beqz	a5,80022686 <procdump+0x76>
            state = "???";
    80022696:	864e                	mv	a2,s3
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80022698:	fcfb69e3          	bltu	s6,a5,8002266a <procdump+0x5a>
    8002269c:	1782                	slli	a5,a5,0x20
    8002269e:	9381                	srli	a5,a5,0x20
    800226a0:	078e                	slli	a5,a5,0x3
    800226a2:	97de                	add	a5,a5,s7
    800226a4:	6390                	ld	a2,0(a5)
    800226a6:	f271                	bnez	a2,8002266a <procdump+0x5a>
            state = "???";
    800226a8:	864e                	mv	a2,s3
    800226aa:	b7c1                	j	8002266a <procdump+0x5a>
    }
}
    800226ac:	60a6                	ld	ra,72(sp)
    800226ae:	6406                	ld	s0,64(sp)
    800226b0:	74e2                	ld	s1,56(sp)
    800226b2:	7942                	ld	s2,48(sp)
    800226b4:	79a2                	ld	s3,40(sp)
    800226b6:	7a02                	ld	s4,32(sp)
    800226b8:	6ae2                	ld	s5,24(sp)
    800226ba:	6b42                	ld	s6,16(sp)
    800226bc:	6ba2                	ld	s7,8(sp)
    800226be:	6161                	addi	sp,sp,80
    800226c0:	8082                	ret

00000000800226c2 <procnum>:

uint64
procnum(void)
{
    800226c2:	1141                	addi	sp,sp,-16
    800226c4:	e422                	sd	s0,8(sp)
    800226c6:	0800                	addi	s0,sp,16
    int num = 0;
    struct proc *p;

    for (p = proc; p < &proc[NPROC]; p++) {
    800226c8:	00015797          	auipc	a5,0x15
    800226cc:	ab878793          	addi	a5,a5,-1352 # 80037180 <proc>
    int num = 0;
    800226d0:	4501                	li	a0,0
    for (p = proc; p < &proc[NPROC]; p++) {
    800226d2:	00019697          	auipc	a3,0x19
    800226d6:	41e68693          	addi	a3,a3,1054 # 8003baf0 <bcache>
    800226da:	a029                	j	800226e4 <procnum+0x22>
    800226dc:	17878793          	addi	a5,a5,376
    800226e0:	00d78663          	beq	a5,a3,800226ec <procnum+0x2a>
        if (p->state != UNUSED) {
    800226e4:	4f98                	lw	a4,24(a5)
    800226e6:	db7d                	beqz	a4,800226dc <procnum+0x1a>
            num++;
    800226e8:	2505                	addiw	a0,a0,1
    800226ea:	bfcd                	j	800226dc <procnum+0x1a>
        }
    }

    return num;
}
    800226ec:	6422                	ld	s0,8(sp)
    800226ee:	0141                	addi	sp,sp,16
    800226f0:	8082                	ret

00000000800226f2 <swtch>:
    800226f2:	00153023          	sd	ra,0(a0)
    800226f6:	00253423          	sd	sp,8(a0)
    800226fa:	e900                	sd	s0,16(a0)
    800226fc:	ed04                	sd	s1,24(a0)
    800226fe:	03253023          	sd	s2,32(a0)
    80022702:	03353423          	sd	s3,40(a0)
    80022706:	03453823          	sd	s4,48(a0)
    8002270a:	03553c23          	sd	s5,56(a0)
    8002270e:	05653023          	sd	s6,64(a0)
    80022712:	05753423          	sd	s7,72(a0)
    80022716:	05853823          	sd	s8,80(a0)
    8002271a:	05953c23          	sd	s9,88(a0)
    8002271e:	07a53023          	sd	s10,96(a0)
    80022722:	07b53423          	sd	s11,104(a0)
    80022726:	0005b083          	ld	ra,0(a1)
    8002272a:	0085b103          	ld	sp,8(a1)
    8002272e:	6980                	ld	s0,16(a1)
    80022730:	6d84                	ld	s1,24(a1)
    80022732:	0205b903          	ld	s2,32(a1)
    80022736:	0285b983          	ld	s3,40(a1)
    8002273a:	0305ba03          	ld	s4,48(a1)
    8002273e:	0385ba83          	ld	s5,56(a1)
    80022742:	0405bb03          	ld	s6,64(a1)
    80022746:	0485bb83          	ld	s7,72(a1)
    8002274a:	0505bc03          	ld	s8,80(a1)
    8002274e:	0585bc83          	ld	s9,88(a1)
    80022752:	0605bd03          	ld	s10,96(a1)
    80022756:	0685bd83          	ld	s11,104(a1)
    8002275a:	8082                	ret

000000008002275c <trapinithart>:
// }

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    8002275c:	1141                	addi	sp,sp,-16
    8002275e:	e406                	sd	ra,8(sp)
    80022760:	e022                	sd	s0,0(sp)
    80022762:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80022764:	0000c797          	auipc	a5,0xc
    80022768:	d5c7b783          	ld	a5,-676(a5) # 8002e4c0 <_GLOBAL_OFFSET_TABLE_+0x18>
    8002276c:	10579073          	csrw	stvec,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022770:	100027f3          	csrr	a5,sstatus
  w_stvec((uint64)kernelvec);
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80022774:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022778:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    8002277c:	104027f3          	csrr	a5,sie
  // enable supervisor-mode timer interrupts.
  w_sie(r_sie() | SIE_SEIE | SIE_SSIE | SIE_STIE);
    80022780:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80022784:	10479073          	csrw	sie,a5
  set_next_timeout();
    80022788:	00003097          	auipc	ra,0x3
    8002278c:	83e080e7          	jalr	-1986(ra) # 80024fc6 <set_next_timeout>
  #ifdef DEBUG
  printf("trapinithart\n");
  #endif
}
    80022790:	60a2                	ld	ra,8(sp)
    80022792:	6402                	ld	s0,0(sp)
    80022794:	0141                	addi	sp,sp,16
    80022796:	8082                	ret

0000000080022798 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80022798:	1141                	addi	sp,sp,-16
    8002279a:	e406                	sd	ra,8(sp)
    8002279c:	e022                	sd	s0,0(sp)
    8002279e:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800227a0:	fffff097          	auipc	ra,0xfffff
    800227a4:	332080e7          	jalr	818(ra) # 80021ad2 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800227a8:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800227ac:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800227ae:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    800227b2:	0000c617          	auipc	a2,0xc
    800227b6:	cfe63603          	ld	a2,-770(a2) # 8002e4b0 <_GLOBAL_OFFSET_TABLE_+0x8>
    800227ba:	0000c697          	auipc	a3,0xc
    800227be:	d266b683          	ld	a3,-730(a3) # 8002e4e0 <_GLOBAL_OFFSET_TABLE_+0x38>
    800227c2:	8e91                	sub	a3,a3,a2
    800227c4:	040007b7          	lui	a5,0x4000
    800227c8:	17fd                	addi	a5,a5,-1
    800227ca:	07b2                	slli	a5,a5,0xc
    800227cc:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    800227ce:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    800227d2:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800227d4:	180026f3          	csrr	a3,satp
    800227d8:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800227da:	7138                	ld	a4,96(a0)
    800227dc:	6134                	ld	a3,64(a0)
    800227de:	6585                	lui	a1,0x1
    800227e0:	96ae                	add	a3,a3,a1
    800227e2:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800227e4:	7138                	ld	a4,96(a0)
    800227e6:	00000697          	auipc	a3,0x0
    800227ea:	11a68693          	addi	a3,a3,282 # 80022900 <usertrap>
    800227ee:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800227f0:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800227f2:	8692                	mv	a3,tp
    800227f4:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800227f6:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800227fa:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800227fe:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022802:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80022806:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80022808:	6f18                	ld	a4,24(a4)
    8002280a:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  // printf("[usertrapret]p->pagetable: %p\n", p->pagetable);
  uint64 satp = MAKE_SATP(p->pagetable);
    8002280e:	692c                	ld	a1,80(a0)
    80022810:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80022812:	0000c717          	auipc	a4,0xc
    80022816:	ca673703          	ld	a4,-858(a4) # 8002e4b8 <_GLOBAL_OFFSET_TABLE_+0x10>
    8002281a:	8f11                	sub	a4,a4,a2
    8002281c:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    8002281e:	577d                	li	a4,-1
    80022820:	177e                	slli	a4,a4,0x3f
    80022822:	8dd9                	or	a1,a1,a4
    80022824:	02000537          	lui	a0,0x2000
    80022828:	157d                	addi	a0,a0,-1
    8002282a:	0536                	slli	a0,a0,0xd
    8002282c:	9782                	jalr	a5
}
    8002282e:	60a2                	ld	ra,8(sp)
    80022830:	6402                	ld	s0,0(sp)
    80022832:	0141                	addi	sp,sp,16
    80022834:	8082                	ret

0000000080022836 <devintr>:
// Check if it's an external/software interrupt, 
// and handle it. 
// returns  2 if timer interrupt, 
//          1 if other device, 
//          0 if not recognized. 
int devintr(void) {
    80022836:	1101                	addi	sp,sp,-32
    80022838:	ec06                	sd	ra,24(sp)
    8002283a:	e822                	sd	s0,16(sp)
    8002283c:	e426                	sd	s1,8(sp)
    8002283e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022840:	14202773          	csrr	a4,scause
	if ((0x8000000000000000L & scause) && 9 == (scause & 0xff)) 
	#else 
	// on k210, supervisor software interrupt is used 
	// in alternative to supervisor external interrupt, 
	// which is not available on k210. 
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    80022844:	57fd                	li	a5,-1
    80022846:	17fe                	slli	a5,a5,0x3f
    80022848:	0785                	addi	a5,a5,1
    8002284a:	00f70d63          	beq	a4,a5,80022864 <devintr+0x2e>
		sbi_set_mie();
		#endif 

		return 1;
	}
	else if (0x8000000000000005L == scause) {
    8002284e:	57fd                	li	a5,-1
    80022850:	17fe                	slli	a5,a5,0x3f
    80022852:	0795                	addi	a5,a5,5
		timer_tick();
		return 2;
	}
	else { return 0;}
    80022854:	4501                	li	a0,0
	else if (0x8000000000000005L == scause) {
    80022856:	08f70f63          	beq	a4,a5,800228f4 <devintr+0xbe>
}
    8002285a:	60e2                	ld	ra,24(sp)
    8002285c:	6442                	ld	s0,16(sp)
    8002285e:	64a2                	ld	s1,8(sp)
    80022860:	6105                	addi	sp,sp,32
    80022862:	8082                	ret
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022864:	14302773          	csrr	a4,stval
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    80022868:	47a5                	li	a5,9
	else { return 0;}
    8002286a:	4501                	li	a0,0
	if (0x8000000000000001L == scause && 9 == r_stval()) 
    8002286c:	fef717e3          	bne	a4,a5,8002285a <devintr+0x24>
		int irq = plic_claim();
    80022870:	00004097          	auipc	ra,0x4
    80022874:	1a4080e7          	jalr	420(ra) # 80026a14 <plic_claim>
    80022878:	84aa                	mv	s1,a0
		if (UART_IRQ == irq) {
    8002287a:	02100793          	li	a5,33
    8002287e:	02f50663          	beq	a0,a5,800228aa <devintr+0x74>
		else if (DISK_IRQ == irq) {
    80022882:	47ed                	li	a5,27
    80022884:	04f50963          	beq	a0,a5,800228d6 <devintr+0xa0>
		else if (irq) {
    80022888:	ed21                	bnez	a0,800228e0 <devintr+0xaa>
  asm volatile("csrr %0, sip" : "=r" (x) );
    8002288a:	144027f3          	csrr	a5,sip
		w_sip(r_sip() & ~2);    // clear pending bit
    8002288e:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80022890:	14479073          	csrw	sip,a5
	asm volatile("mv a6, %0" : : "r" (0x210));
	SBI_CALL_1(0x0A000004, func_pointer);
}

static inline void sbi_set_mie(void) {
	SBI_CALL_0(0x0A000005);
    80022894:	4501                	li	a0,0
    80022896:	4581                	li	a1,0
    80022898:	4601                	li	a2,0
    8002289a:	4681                	li	a3,0
    8002289c:	0a0008b7          	lui	a7,0xa000
    800228a0:	0895                	addi	a7,a7,5
    800228a2:	00000073          	ecall
		return 1;
    800228a6:	4505                	li	a0,1
    800228a8:	bf4d                	j	8002285a <devintr+0x24>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
    800228aa:	4501                	li	a0,0
    800228ac:	4581                	li	a1,0
    800228ae:	4601                	li	a2,0
    800228b0:	4681                	li	a3,0
    800228b2:	4889                	li	a7,2
    800228b4:	00000073          	ecall
    800228b8:	2501                	sext.w	a0,a0
			if (-1 != c) {
    800228ba:	57fd                	li	a5,-1
    800228bc:	00f51863          	bne	a0,a5,800228cc <devintr+0x96>
		if (irq) { plic_complete(irq);}
    800228c0:	8526                	mv	a0,s1
    800228c2:	00004097          	auipc	ra,0x4
    800228c6:	178080e7          	jalr	376(ra) # 80026a3a <plic_complete>
    800228ca:	b7c1                	j	8002288a <devintr+0x54>
				consoleintr(c);
    800228cc:	00004097          	auipc	ra,0x4
    800228d0:	37c080e7          	jalr	892(ra) # 80026c48 <consoleintr>
    800228d4:	b7f5                	j	800228c0 <devintr+0x8a>
			disk_intr();
    800228d6:	00002097          	auipc	ra,0x2
    800228da:	7b8080e7          	jalr	1976(ra) # 8002508e <disk_intr>
    800228de:	b7cd                	j	800228c0 <devintr+0x8a>
			printf("unexpected interrupt irq = %d\n", irq);
    800228e0:	85aa                	mv	a1,a0
    800228e2:	00009517          	auipc	a0,0x9
    800228e6:	d2e50513          	addi	a0,a0,-722 # 8002b610 <digits+0x388>
    800228ea:	ffffe097          	auipc	ra,0xffffe
    800228ee:	8a2080e7          	jalr	-1886(ra) # 8002018c <printf>
    800228f2:	b7f9                	j	800228c0 <devintr+0x8a>
		timer_tick();
    800228f4:	00002097          	auipc	ra,0x2
    800228f8:	6f8080e7          	jalr	1784(ra) # 80024fec <timer_tick>
		return 2;
    800228fc:	4509                	li	a0,2
    800228fe:	bfb1                	j	8002285a <devintr+0x24>

0000000080022900 <usertrap>:
{
    80022900:	1101                	addi	sp,sp,-32
    80022902:	ec06                	sd	ra,24(sp)
    80022904:	e822                	sd	s0,16(sp)
    80022906:	e426                	sd	s1,8(sp)
    80022908:	e04a                	sd	s2,0(sp)
    8002290a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002290c:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80022910:	1007f793          	andi	a5,a5,256
    80022914:	e3ad                	bnez	a5,80022976 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80022916:	0000c797          	auipc	a5,0xc
    8002291a:	baa7b783          	ld	a5,-1110(a5) # 8002e4c0 <_GLOBAL_OFFSET_TABLE_+0x18>
    8002291e:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80022922:	fffff097          	auipc	ra,0xfffff
    80022926:	1b0080e7          	jalr	432(ra) # 80021ad2 <myproc>
    8002292a:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    8002292c:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8002292e:	14102773          	csrr	a4,sepc
    80022932:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022934:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80022938:	47a1                	li	a5,8
    8002293a:	04f71c63          	bne	a4,a5,80022992 <usertrap+0x92>
    if(p->killed)
    8002293e:	591c                	lw	a5,48(a0)
    80022940:	e3b9                	bnez	a5,80022986 <usertrap+0x86>
    p->trapframe->epc += 4;
    80022942:	70b8                	ld	a4,96(s1)
    80022944:	6f1c                	ld	a5,24(a4)
    80022946:	0791                	addi	a5,a5,4
    80022948:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002294a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8002294e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022952:	10079073          	csrw	sstatus,a5
    syscall();
    80022956:	00000097          	auipc	ra,0x0
    8002295a:	5d4080e7          	jalr	1492(ra) # 80022f2a <syscall>
  if(p->killed)
    8002295e:	589c                	lw	a5,48(s1)
    80022960:	ebd1                	bnez	a5,800229f4 <usertrap+0xf4>
  usertrapret();
    80022962:	00000097          	auipc	ra,0x0
    80022966:	e36080e7          	jalr	-458(ra) # 80022798 <usertrapret>
}
    8002296a:	60e2                	ld	ra,24(sp)
    8002296c:	6442                	ld	s0,16(sp)
    8002296e:	64a2                	ld	s1,8(sp)
    80022970:	6902                	ld	s2,0(sp)
    80022972:	6105                	addi	sp,sp,32
    80022974:	8082                	ret
    panic("usertrap: not from user mode");
    80022976:	00009517          	auipc	a0,0x9
    8002297a:	cba50513          	addi	a0,a0,-838 # 8002b630 <digits+0x3a8>
    8002297e:	ffffd097          	auipc	ra,0xffffd
    80022982:	7c4080e7          	jalr	1988(ra) # 80020142 <panic>
      exit(-1);
    80022986:	557d                	li	a0,-1
    80022988:	00000097          	auipc	ra,0x0
    8002298c:	88c080e7          	jalr	-1908(ra) # 80022214 <exit>
    80022990:	bf4d                	j	80022942 <usertrap+0x42>
  else if((which_dev = devintr()) != 0){
    80022992:	00000097          	auipc	ra,0x0
    80022996:	ea4080e7          	jalr	-348(ra) # 80022836 <devintr>
    8002299a:	892a                	mv	s2,a0
    8002299c:	c501                	beqz	a0,800229a4 <usertrap+0xa4>
  if(p->killed)
    8002299e:	589c                	lw	a5,48(s1)
    800229a0:	c3b1                	beqz	a5,800229e4 <usertrap+0xe4>
    800229a2:	a825                	j	800229da <usertrap+0xda>
  asm volatile("csrr %0, scause" : "=r" (x) );
    800229a4:	142025f3          	csrr	a1,scause
    printf("\nusertrap(): unexpected scause %p pid=%d %s\n", r_scause(), p->pid, p->name);
    800229a8:	16048693          	addi	a3,s1,352
    800229ac:	5c90                	lw	a2,56(s1)
    800229ae:	00009517          	auipc	a0,0x9
    800229b2:	ca250513          	addi	a0,a0,-862 # 8002b650 <digits+0x3c8>
    800229b6:	ffffd097          	auipc	ra,0xffffd
    800229ba:	7d6080e7          	jalr	2006(ra) # 8002018c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800229be:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800229c2:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    800229c6:	00009517          	auipc	a0,0x9
    800229ca:	cba50513          	addi	a0,a0,-838 # 8002b680 <digits+0x3f8>
    800229ce:	ffffd097          	auipc	ra,0xffffd
    800229d2:	7be080e7          	jalr	1982(ra) # 8002018c <printf>
    p->killed = 1;
    800229d6:	4785                	li	a5,1
    800229d8:	d89c                	sw	a5,48(s1)
    exit(-1);
    800229da:	557d                	li	a0,-1
    800229dc:	00000097          	auipc	ra,0x0
    800229e0:	838080e7          	jalr	-1992(ra) # 80022214 <exit>
  if(which_dev == 2)
    800229e4:	4789                	li	a5,2
    800229e6:	f6f91ee3          	bne	s2,a5,80022962 <usertrap+0x62>
    yield();
    800229ea:	00000097          	auipc	ra,0x0
    800229ee:	92a080e7          	jalr	-1750(ra) # 80022314 <yield>
    800229f2:	bf85                	j	80022962 <usertrap+0x62>
  int which_dev = 0;
    800229f4:	4901                	li	s2,0
    800229f6:	b7d5                	j	800229da <usertrap+0xda>

00000000800229f8 <kerneltrap>:
kerneltrap() {
    800229f8:	7179                	addi	sp,sp,-48
    800229fa:	f406                	sd	ra,40(sp)
    800229fc:	f022                	sd	s0,32(sp)
    800229fe:	ec26                	sd	s1,24(sp)
    80022a00:	e84a                	sd	s2,16(sp)
    80022a02:	e44e                	sd	s3,8(sp)
    80022a04:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022a06:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022a0a:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022a0e:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80022a12:	1004f793          	andi	a5,s1,256
    80022a16:	cb85                	beqz	a5,80022a46 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022a18:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80022a1c:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80022a1e:	ef85                	bnez	a5,80022a56 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80022a20:	00000097          	auipc	ra,0x0
    80022a24:	e16080e7          	jalr	-490(ra) # 80022836 <devintr>
    80022a28:	cd1d                	beqz	a0,80022a66 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    80022a2a:	4789                	li	a5,2
    80022a2c:	08f50b63          	beq	a0,a5,80022ac2 <kerneltrap+0xca>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80022a30:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022a34:	10049073          	csrw	sstatus,s1
}
    80022a38:	70a2                	ld	ra,40(sp)
    80022a3a:	7402                	ld	s0,32(sp)
    80022a3c:	64e2                	ld	s1,24(sp)
    80022a3e:	6942                	ld	s2,16(sp)
    80022a40:	69a2                	ld	s3,8(sp)
    80022a42:	6145                	addi	sp,sp,48
    80022a44:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80022a46:	00009517          	auipc	a0,0x9
    80022a4a:	c5a50513          	addi	a0,a0,-934 # 8002b6a0 <digits+0x418>
    80022a4e:	ffffd097          	auipc	ra,0xffffd
    80022a52:	6f4080e7          	jalr	1780(ra) # 80020142 <panic>
    panic("kerneltrap: interrupts enabled");
    80022a56:	00009517          	auipc	a0,0x9
    80022a5a:	c7250513          	addi	a0,a0,-910 # 8002b6c8 <digits+0x440>
    80022a5e:	ffffd097          	auipc	ra,0xffffd
    80022a62:	6e4080e7          	jalr	1764(ra) # 80020142 <panic>
    printf("\nscause %p\n", scause);
    80022a66:	85ce                	mv	a1,s3
    80022a68:	00009517          	auipc	a0,0x9
    80022a6c:	c8050513          	addi	a0,a0,-896 # 8002b6e8 <digits+0x460>
    80022a70:	ffffd097          	auipc	ra,0xffffd
    80022a74:	71c080e7          	jalr	1820(ra) # 8002018c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022a78:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022a7c:	14302673          	csrr	a2,stval
  asm volatile("mv %0, tp" : "=r" (x) );
    80022a80:	8692                	mv	a3,tp
    printf("sepc=%p stval=%p hart=%d\n", r_sepc(), r_stval(), r_tp());
    80022a82:	00009517          	auipc	a0,0x9
    80022a86:	c7650513          	addi	a0,a0,-906 # 8002b6f8 <digits+0x470>
    80022a8a:	ffffd097          	auipc	ra,0xffffd
    80022a8e:	702080e7          	jalr	1794(ra) # 8002018c <printf>
    struct proc *p = myproc();
    80022a92:	fffff097          	auipc	ra,0xfffff
    80022a96:	040080e7          	jalr	64(ra) # 80021ad2 <myproc>
    if (p != 0) {
    80022a9a:	cd01                	beqz	a0,80022ab2 <kerneltrap+0xba>
      printf("pid: %d, name: %s\n", p->pid, p->name);
    80022a9c:	16050613          	addi	a2,a0,352
    80022aa0:	5d0c                	lw	a1,56(a0)
    80022aa2:	00009517          	auipc	a0,0x9
    80022aa6:	c7650513          	addi	a0,a0,-906 # 8002b718 <digits+0x490>
    80022aaa:	ffffd097          	auipc	ra,0xffffd
    80022aae:	6e2080e7          	jalr	1762(ra) # 8002018c <printf>
    panic("kerneltrap");
    80022ab2:	00009517          	auipc	a0,0x9
    80022ab6:	c7e50513          	addi	a0,a0,-898 # 8002b730 <digits+0x4a8>
    80022aba:	ffffd097          	auipc	ra,0xffffd
    80022abe:	688080e7          	jalr	1672(ra) # 80020142 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING) {
    80022ac2:	fffff097          	auipc	ra,0xfffff
    80022ac6:	010080e7          	jalr	16(ra) # 80021ad2 <myproc>
    80022aca:	d13d                	beqz	a0,80022a30 <kerneltrap+0x38>
    80022acc:	fffff097          	auipc	ra,0xfffff
    80022ad0:	006080e7          	jalr	6(ra) # 80021ad2 <myproc>
    80022ad4:	4d18                	lw	a4,24(a0)
    80022ad6:	478d                	li	a5,3
    80022ad8:	f4f71ce3          	bne	a4,a5,80022a30 <kerneltrap+0x38>
    yield();
    80022adc:	00000097          	auipc	ra,0x0
    80022ae0:	838080e7          	jalr	-1992(ra) # 80022314 <yield>
    80022ae4:	b7b1                	j	80022a30 <kerneltrap+0x38>

0000000080022ae6 <trapframedump>:

void trapframedump(struct trapframe *tf)
{
    80022ae6:	1101                	addi	sp,sp,-32
    80022ae8:	ec06                	sd	ra,24(sp)
    80022aea:	e822                	sd	s0,16(sp)
    80022aec:	e426                	sd	s1,8(sp)
    80022aee:	1000                	addi	s0,sp,32
    80022af0:	84aa                	mv	s1,a0
  printf("a0: %p\t", tf->a0);
    80022af2:	792c                	ld	a1,112(a0)
    80022af4:	00009517          	auipc	a0,0x9
    80022af8:	c4c50513          	addi	a0,a0,-948 # 8002b740 <digits+0x4b8>
    80022afc:	ffffd097          	auipc	ra,0xffffd
    80022b00:	690080e7          	jalr	1680(ra) # 8002018c <printf>
  printf("a1: %p\t", tf->a1);
    80022b04:	7cac                	ld	a1,120(s1)
    80022b06:	00009517          	auipc	a0,0x9
    80022b0a:	c4250513          	addi	a0,a0,-958 # 8002b748 <digits+0x4c0>
    80022b0e:	ffffd097          	auipc	ra,0xffffd
    80022b12:	67e080e7          	jalr	1662(ra) # 8002018c <printf>
  printf("a2: %p\t", tf->a2);
    80022b16:	60cc                	ld	a1,128(s1)
    80022b18:	00009517          	auipc	a0,0x9
    80022b1c:	c3850513          	addi	a0,a0,-968 # 8002b750 <digits+0x4c8>
    80022b20:	ffffd097          	auipc	ra,0xffffd
    80022b24:	66c080e7          	jalr	1644(ra) # 8002018c <printf>
  printf("a3: %p\n", tf->a3);
    80022b28:	64cc                	ld	a1,136(s1)
    80022b2a:	00009517          	auipc	a0,0x9
    80022b2e:	c2e50513          	addi	a0,a0,-978 # 8002b758 <digits+0x4d0>
    80022b32:	ffffd097          	auipc	ra,0xffffd
    80022b36:	65a080e7          	jalr	1626(ra) # 8002018c <printf>
  printf("a4: %p\t", tf->a4);
    80022b3a:	68cc                	ld	a1,144(s1)
    80022b3c:	00009517          	auipc	a0,0x9
    80022b40:	c2450513          	addi	a0,a0,-988 # 8002b760 <digits+0x4d8>
    80022b44:	ffffd097          	auipc	ra,0xffffd
    80022b48:	648080e7          	jalr	1608(ra) # 8002018c <printf>
  printf("a5: %p\t", tf->a5);
    80022b4c:	6ccc                	ld	a1,152(s1)
    80022b4e:	00009517          	auipc	a0,0x9
    80022b52:	c1a50513          	addi	a0,a0,-998 # 8002b768 <digits+0x4e0>
    80022b56:	ffffd097          	auipc	ra,0xffffd
    80022b5a:	636080e7          	jalr	1590(ra) # 8002018c <printf>
  printf("a6: %p\t", tf->a6);
    80022b5e:	70cc                	ld	a1,160(s1)
    80022b60:	00009517          	auipc	a0,0x9
    80022b64:	c1050513          	addi	a0,a0,-1008 # 8002b770 <digits+0x4e8>
    80022b68:	ffffd097          	auipc	ra,0xffffd
    80022b6c:	624080e7          	jalr	1572(ra) # 8002018c <printf>
  printf("a7: %p\n", tf->a7);
    80022b70:	74cc                	ld	a1,168(s1)
    80022b72:	00009517          	auipc	a0,0x9
    80022b76:	c0650513          	addi	a0,a0,-1018 # 8002b778 <digits+0x4f0>
    80022b7a:	ffffd097          	auipc	ra,0xffffd
    80022b7e:	612080e7          	jalr	1554(ra) # 8002018c <printf>
  printf("t0: %p\t", tf->t0);
    80022b82:	64ac                	ld	a1,72(s1)
    80022b84:	00009517          	auipc	a0,0x9
    80022b88:	bfc50513          	addi	a0,a0,-1028 # 8002b780 <digits+0x4f8>
    80022b8c:	ffffd097          	auipc	ra,0xffffd
    80022b90:	600080e7          	jalr	1536(ra) # 8002018c <printf>
  printf("t1: %p\t", tf->t1);
    80022b94:	68ac                	ld	a1,80(s1)
    80022b96:	00009517          	auipc	a0,0x9
    80022b9a:	bf250513          	addi	a0,a0,-1038 # 8002b788 <digits+0x500>
    80022b9e:	ffffd097          	auipc	ra,0xffffd
    80022ba2:	5ee080e7          	jalr	1518(ra) # 8002018c <printf>
  printf("t2: %p\t", tf->t2);
    80022ba6:	6cac                	ld	a1,88(s1)
    80022ba8:	00009517          	auipc	a0,0x9
    80022bac:	be850513          	addi	a0,a0,-1048 # 8002b790 <digits+0x508>
    80022bb0:	ffffd097          	auipc	ra,0xffffd
    80022bb4:	5dc080e7          	jalr	1500(ra) # 8002018c <printf>
  printf("t3: %p\n", tf->t3);
    80022bb8:	1004b583          	ld	a1,256(s1)
    80022bbc:	00009517          	auipc	a0,0x9
    80022bc0:	bdc50513          	addi	a0,a0,-1060 # 8002b798 <digits+0x510>
    80022bc4:	ffffd097          	auipc	ra,0xffffd
    80022bc8:	5c8080e7          	jalr	1480(ra) # 8002018c <printf>
  printf("t4: %p\t", tf->t4);
    80022bcc:	1084b583          	ld	a1,264(s1)
    80022bd0:	00009517          	auipc	a0,0x9
    80022bd4:	bd050513          	addi	a0,a0,-1072 # 8002b7a0 <digits+0x518>
    80022bd8:	ffffd097          	auipc	ra,0xffffd
    80022bdc:	5b4080e7          	jalr	1460(ra) # 8002018c <printf>
  printf("t5: %p\t", tf->t5);
    80022be0:	1104b583          	ld	a1,272(s1)
    80022be4:	00009517          	auipc	a0,0x9
    80022be8:	bc450513          	addi	a0,a0,-1084 # 8002b7a8 <digits+0x520>
    80022bec:	ffffd097          	auipc	ra,0xffffd
    80022bf0:	5a0080e7          	jalr	1440(ra) # 8002018c <printf>
  printf("t6: %p\t", tf->t6);
    80022bf4:	1184b583          	ld	a1,280(s1)
    80022bf8:	00009517          	auipc	a0,0x9
    80022bfc:	bb850513          	addi	a0,a0,-1096 # 8002b7b0 <digits+0x528>
    80022c00:	ffffd097          	auipc	ra,0xffffd
    80022c04:	58c080e7          	jalr	1420(ra) # 8002018c <printf>
  printf("s0: %p\n", tf->s0);
    80022c08:	70ac                	ld	a1,96(s1)
    80022c0a:	00009517          	auipc	a0,0x9
    80022c0e:	bae50513          	addi	a0,a0,-1106 # 8002b7b8 <digits+0x530>
    80022c12:	ffffd097          	auipc	ra,0xffffd
    80022c16:	57a080e7          	jalr	1402(ra) # 8002018c <printf>
  printf("s1: %p\t", tf->s1);
    80022c1a:	74ac                	ld	a1,104(s1)
    80022c1c:	00009517          	auipc	a0,0x9
    80022c20:	ba450513          	addi	a0,a0,-1116 # 8002b7c0 <digits+0x538>
    80022c24:	ffffd097          	auipc	ra,0xffffd
    80022c28:	568080e7          	jalr	1384(ra) # 8002018c <printf>
  printf("s2: %p\t", tf->s2);
    80022c2c:	78cc                	ld	a1,176(s1)
    80022c2e:	00009517          	auipc	a0,0x9
    80022c32:	b9a50513          	addi	a0,a0,-1126 # 8002b7c8 <digits+0x540>
    80022c36:	ffffd097          	auipc	ra,0xffffd
    80022c3a:	556080e7          	jalr	1366(ra) # 8002018c <printf>
  printf("s3: %p\t", tf->s3);
    80022c3e:	7ccc                	ld	a1,184(s1)
    80022c40:	00009517          	auipc	a0,0x9
    80022c44:	b9050513          	addi	a0,a0,-1136 # 8002b7d0 <digits+0x548>
    80022c48:	ffffd097          	auipc	ra,0xffffd
    80022c4c:	544080e7          	jalr	1348(ra) # 8002018c <printf>
  printf("s4: %p\n", tf->s4);
    80022c50:	60ec                	ld	a1,192(s1)
    80022c52:	00009517          	auipc	a0,0x9
    80022c56:	b8650513          	addi	a0,a0,-1146 # 8002b7d8 <digits+0x550>
    80022c5a:	ffffd097          	auipc	ra,0xffffd
    80022c5e:	532080e7          	jalr	1330(ra) # 8002018c <printf>
  printf("s5: %p\t", tf->s5);
    80022c62:	64ec                	ld	a1,200(s1)
    80022c64:	00009517          	auipc	a0,0x9
    80022c68:	b7c50513          	addi	a0,a0,-1156 # 8002b7e0 <digits+0x558>
    80022c6c:	ffffd097          	auipc	ra,0xffffd
    80022c70:	520080e7          	jalr	1312(ra) # 8002018c <printf>
  printf("s6: %p\t", tf->s6);
    80022c74:	68ec                	ld	a1,208(s1)
    80022c76:	00009517          	auipc	a0,0x9
    80022c7a:	b7250513          	addi	a0,a0,-1166 # 8002b7e8 <digits+0x560>
    80022c7e:	ffffd097          	auipc	ra,0xffffd
    80022c82:	50e080e7          	jalr	1294(ra) # 8002018c <printf>
  printf("s7: %p\t", tf->s7);
    80022c86:	6cec                	ld	a1,216(s1)
    80022c88:	00009517          	auipc	a0,0x9
    80022c8c:	b6850513          	addi	a0,a0,-1176 # 8002b7f0 <digits+0x568>
    80022c90:	ffffd097          	auipc	ra,0xffffd
    80022c94:	4fc080e7          	jalr	1276(ra) # 8002018c <printf>
  printf("s8: %p\n", tf->s8);
    80022c98:	70ec                	ld	a1,224(s1)
    80022c9a:	00009517          	auipc	a0,0x9
    80022c9e:	b5e50513          	addi	a0,a0,-1186 # 8002b7f8 <digits+0x570>
    80022ca2:	ffffd097          	auipc	ra,0xffffd
    80022ca6:	4ea080e7          	jalr	1258(ra) # 8002018c <printf>
  printf("s9: %p\t", tf->s9);
    80022caa:	74ec                	ld	a1,232(s1)
    80022cac:	00009517          	auipc	a0,0x9
    80022cb0:	b5450513          	addi	a0,a0,-1196 # 8002b800 <digits+0x578>
    80022cb4:	ffffd097          	auipc	ra,0xffffd
    80022cb8:	4d8080e7          	jalr	1240(ra) # 8002018c <printf>
  printf("s10: %p\t", tf->s10);
    80022cbc:	78ec                	ld	a1,240(s1)
    80022cbe:	00009517          	auipc	a0,0x9
    80022cc2:	b4a50513          	addi	a0,a0,-1206 # 8002b808 <digits+0x580>
    80022cc6:	ffffd097          	auipc	ra,0xffffd
    80022cca:	4c6080e7          	jalr	1222(ra) # 8002018c <printf>
  printf("s11: %p\t", tf->s11);
    80022cce:	7cec                	ld	a1,248(s1)
    80022cd0:	00009517          	auipc	a0,0x9
    80022cd4:	b4850513          	addi	a0,a0,-1208 # 8002b818 <digits+0x590>
    80022cd8:	ffffd097          	auipc	ra,0xffffd
    80022cdc:	4b4080e7          	jalr	1204(ra) # 8002018c <printf>
  printf("ra: %p\n", tf->ra);
    80022ce0:	748c                	ld	a1,40(s1)
    80022ce2:	00009517          	auipc	a0,0x9
    80022ce6:	83650513          	addi	a0,a0,-1994 # 8002b518 <digits+0x290>
    80022cea:	ffffd097          	auipc	ra,0xffffd
    80022cee:	4a2080e7          	jalr	1186(ra) # 8002018c <printf>
  printf("sp: %p\t", tf->sp);
    80022cf2:	788c                	ld	a1,48(s1)
    80022cf4:	00009517          	auipc	a0,0x9
    80022cf8:	b3450513          	addi	a0,a0,-1228 # 8002b828 <digits+0x5a0>
    80022cfc:	ffffd097          	auipc	ra,0xffffd
    80022d00:	490080e7          	jalr	1168(ra) # 8002018c <printf>
  printf("gp: %p\t", tf->gp);
    80022d04:	7c8c                	ld	a1,56(s1)
    80022d06:	00009517          	auipc	a0,0x9
    80022d0a:	b2a50513          	addi	a0,a0,-1238 # 8002b830 <digits+0x5a8>
    80022d0e:	ffffd097          	auipc	ra,0xffffd
    80022d12:	47e080e7          	jalr	1150(ra) # 8002018c <printf>
  printf("tp: %p\t", tf->tp);
    80022d16:	60ac                	ld	a1,64(s1)
    80022d18:	00009517          	auipc	a0,0x9
    80022d1c:	b2050513          	addi	a0,a0,-1248 # 8002b838 <digits+0x5b0>
    80022d20:	ffffd097          	auipc	ra,0xffffd
    80022d24:	46c080e7          	jalr	1132(ra) # 8002018c <printf>
  printf("epc: %p\n", tf->epc);
    80022d28:	6c8c                	ld	a1,24(s1)
    80022d2a:	00009517          	auipc	a0,0x9
    80022d2e:	b1650513          	addi	a0,a0,-1258 # 8002b840 <digits+0x5b8>
    80022d32:	ffffd097          	auipc	ra,0xffffd
    80022d36:	45a080e7          	jalr	1114(ra) # 8002018c <printf>
}
    80022d3a:	60e2                	ld	ra,24(sp)
    80022d3c:	6442                	ld	s0,16(sp)
    80022d3e:	64a2                	ld	s1,8(sp)
    80022d40:	6105                	addi	sp,sp,32
    80022d42:	8082                	ret

0000000080022d44 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80022d44:	1101                	addi	sp,sp,-32
    80022d46:	ec06                	sd	ra,24(sp)
    80022d48:	e822                	sd	s0,16(sp)
    80022d4a:	e426                	sd	s1,8(sp)
    80022d4c:	1000                	addi	s0,sp,32
    80022d4e:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80022d50:	fffff097          	auipc	ra,0xfffff
    80022d54:	d82080e7          	jalr	-638(ra) # 80021ad2 <myproc>
  switch (n) {
    80022d58:	4795                	li	a5,5
    80022d5a:	0497e163          	bltu	a5,s1,80022d9c <argraw+0x58>
    80022d5e:	048a                	slli	s1,s1,0x2
    80022d60:	00009717          	auipc	a4,0x9
    80022d64:	c2870713          	addi	a4,a4,-984 # 8002b988 <digits+0x700>
    80022d68:	94ba                	add	s1,s1,a4
    80022d6a:	409c                	lw	a5,0(s1)
    80022d6c:	97ba                	add	a5,a5,a4
    80022d6e:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80022d70:	713c                	ld	a5,96(a0)
    80022d72:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80022d74:	60e2                	ld	ra,24(sp)
    80022d76:	6442                	ld	s0,16(sp)
    80022d78:	64a2                	ld	s1,8(sp)
    80022d7a:	6105                	addi	sp,sp,32
    80022d7c:	8082                	ret
    return p->trapframe->a1;
    80022d7e:	713c                	ld	a5,96(a0)
    80022d80:	7fa8                	ld	a0,120(a5)
    80022d82:	bfcd                	j	80022d74 <argraw+0x30>
    return p->trapframe->a2;
    80022d84:	713c                	ld	a5,96(a0)
    80022d86:	63c8                	ld	a0,128(a5)
    80022d88:	b7f5                	j	80022d74 <argraw+0x30>
    return p->trapframe->a3;
    80022d8a:	713c                	ld	a5,96(a0)
    80022d8c:	67c8                	ld	a0,136(a5)
    80022d8e:	b7dd                	j	80022d74 <argraw+0x30>
    return p->trapframe->a4;
    80022d90:	713c                	ld	a5,96(a0)
    80022d92:	6bc8                	ld	a0,144(a5)
    80022d94:	b7c5                	j	80022d74 <argraw+0x30>
    return p->trapframe->a5;
    80022d96:	713c                	ld	a5,96(a0)
    80022d98:	6fc8                	ld	a0,152(a5)
    80022d9a:	bfe9                	j	80022d74 <argraw+0x30>
  panic("argraw");
    80022d9c:	00009517          	auipc	a0,0x9
    80022da0:	ab450513          	addi	a0,a0,-1356 # 8002b850 <digits+0x5c8>
    80022da4:	ffffd097          	auipc	ra,0xffffd
    80022da8:	39e080e7          	jalr	926(ra) # 80020142 <panic>

0000000080022dac <sys_sysinfo>:
    return 0;
}

uint64
sys_sysinfo(void)
{
    80022dac:	7179                	addi	sp,sp,-48
    80022dae:	f406                	sd	ra,40(sp)
    80022db0:	f022                	sd	s0,32(sp)
    80022db2:	ec26                	sd	s1,24(sp)
    80022db4:	1800                	addi	s0,sp,48
  *ip = argraw(n);
    80022db6:	4501                	li	a0,0
    80022db8:	00000097          	auipc	ra,0x0
    80022dbc:	f8c080e7          	jalr	-116(ra) # 80022d44 <argraw>
    80022dc0:	84aa                	mv	s1,a0
  if (argaddr(0, &addr) < 0) {
    return -1;
  }

  struct sysinfo info;
  info.freemem = freemem_amount();
    80022dc2:	ffffd097          	auipc	ra,0xffffd
    80022dc6:	7ea080e7          	jalr	2026(ra) # 800205ac <freemem_amount>
    80022dca:	fca43823          	sd	a0,-48(s0)
  info.nproc = procnum();
    80022dce:	00000097          	auipc	ra,0x0
    80022dd2:	8f4080e7          	jalr	-1804(ra) # 800226c2 <procnum>
    80022dd6:	fca43c23          	sd	a0,-40(s0)

  // if (copyout(p->pagetable, addr, (char *)&info, sizeof(info)) < 0) {
  if (copyout2(addr, (char *)&info, sizeof(info)) < 0) {
    80022dda:	4641                	li	a2,16
    80022ddc:	fd040593          	addi	a1,s0,-48
    80022de0:	8526                	mv	a0,s1
    80022de2:	ffffe097          	auipc	ra,0xffffe
    80022de6:	622080e7          	jalr	1570(ra) # 80021404 <copyout2>
    return -1;
  }

  return 0;
    80022dea:	957d                	srai	a0,a0,0x3f
    80022dec:	70a2                	ld	ra,40(sp)
    80022dee:	7402                	ld	s0,32(sp)
    80022df0:	64e2                	ld	s1,24(sp)
    80022df2:	6145                	addi	sp,sp,48
    80022df4:	8082                	ret

0000000080022df6 <fetchaddr>:
{
    80022df6:	1101                	addi	sp,sp,-32
    80022df8:	ec06                	sd	ra,24(sp)
    80022dfa:	e822                	sd	s0,16(sp)
    80022dfc:	e426                	sd	s1,8(sp)
    80022dfe:	e04a                	sd	s2,0(sp)
    80022e00:	1000                	addi	s0,sp,32
    80022e02:	84aa                	mv	s1,a0
    80022e04:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80022e06:	fffff097          	auipc	ra,0xfffff
    80022e0a:	ccc080e7          	jalr	-820(ra) # 80021ad2 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80022e0e:	653c                	ld	a5,72(a0)
    80022e10:	02f4f763          	bgeu	s1,a5,80022e3e <fetchaddr+0x48>
    80022e14:	00848713          	addi	a4,s1,8
    80022e18:	02e7e563          	bltu	a5,a4,80022e42 <fetchaddr+0x4c>
  if(copyin2((char *)ip, addr, sizeof(*ip)) != 0)
    80022e1c:	4621                	li	a2,8
    80022e1e:	85a6                	mv	a1,s1
    80022e20:	854a                	mv	a0,s2
    80022e22:	ffffe097          	auipc	ra,0xffffe
    80022e26:	6c2080e7          	jalr	1730(ra) # 800214e4 <copyin2>
    80022e2a:	00a03533          	snez	a0,a0
    80022e2e:	40a00533          	neg	a0,a0
}
    80022e32:	60e2                	ld	ra,24(sp)
    80022e34:	6442                	ld	s0,16(sp)
    80022e36:	64a2                	ld	s1,8(sp)
    80022e38:	6902                	ld	s2,0(sp)
    80022e3a:	6105                	addi	sp,sp,32
    80022e3c:	8082                	ret
    return -1;
    80022e3e:	557d                	li	a0,-1
    80022e40:	bfcd                	j	80022e32 <fetchaddr+0x3c>
    80022e42:	557d                	li	a0,-1
    80022e44:	b7fd                	j	80022e32 <fetchaddr+0x3c>

0000000080022e46 <fetchstr>:
{
    80022e46:	1101                	addi	sp,sp,-32
    80022e48:	ec06                	sd	ra,24(sp)
    80022e4a:	e822                	sd	s0,16(sp)
    80022e4c:	e426                	sd	s1,8(sp)
    80022e4e:	1000                	addi	s0,sp,32
    80022e50:	84ae                	mv	s1,a1
  int err = copyinstr2(buf, addr, max);
    80022e52:	85aa                	mv	a1,a0
    80022e54:	8526                	mv	a0,s1
    80022e56:	ffffe097          	auipc	ra,0xffffe
    80022e5a:	794080e7          	jalr	1940(ra) # 800215ea <copyinstr2>
  if(err < 0)
    80022e5e:	00054763          	bltz	a0,80022e6c <fetchstr+0x26>
  return strlen(buf);
    80022e62:	8526                	mv	a0,s1
    80022e64:	ffffe097          	auipc	ra,0xffffe
    80022e68:	a6e080e7          	jalr	-1426(ra) # 800208d2 <strlen>
}
    80022e6c:	60e2                	ld	ra,24(sp)
    80022e6e:	6442                	ld	s0,16(sp)
    80022e70:	64a2                	ld	s1,8(sp)
    80022e72:	6105                	addi	sp,sp,32
    80022e74:	8082                	ret

0000000080022e76 <argint>:
{
    80022e76:	1101                	addi	sp,sp,-32
    80022e78:	ec06                	sd	ra,24(sp)
    80022e7a:	e822                	sd	s0,16(sp)
    80022e7c:	e426                	sd	s1,8(sp)
    80022e7e:	1000                	addi	s0,sp,32
    80022e80:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80022e82:	00000097          	auipc	ra,0x0
    80022e86:	ec2080e7          	jalr	-318(ra) # 80022d44 <argraw>
    80022e8a:	c088                	sw	a0,0(s1)
}
    80022e8c:	4501                	li	a0,0
    80022e8e:	60e2                	ld	ra,24(sp)
    80022e90:	6442                	ld	s0,16(sp)
    80022e92:	64a2                	ld	s1,8(sp)
    80022e94:	6105                	addi	sp,sp,32
    80022e96:	8082                	ret

0000000080022e98 <sys_test_proc>:
sys_test_proc(void) {
    80022e98:	1101                	addi	sp,sp,-32
    80022e9a:	ec06                	sd	ra,24(sp)
    80022e9c:	e822                	sd	s0,16(sp)
    80022e9e:	1000                	addi	s0,sp,32
    argint(0, &n);
    80022ea0:	fec40593          	addi	a1,s0,-20
    80022ea4:	4501                	li	a0,0
    80022ea6:	00000097          	auipc	ra,0x0
    80022eaa:	fd0080e7          	jalr	-48(ra) # 80022e76 <argint>
    printf("hello world from proc %d, hart %d, arg %d\n", myproc()->pid, r_tp(), n);
    80022eae:	fffff097          	auipc	ra,0xfffff
    80022eb2:	c24080e7          	jalr	-988(ra) # 80021ad2 <myproc>
    80022eb6:	8612                	mv	a2,tp
    80022eb8:	fec42683          	lw	a3,-20(s0)
    80022ebc:	5d0c                	lw	a1,56(a0)
    80022ebe:	00009517          	auipc	a0,0x9
    80022ec2:	99a50513          	addi	a0,a0,-1638 # 8002b858 <digits+0x5d0>
    80022ec6:	ffffd097          	auipc	ra,0xffffd
    80022eca:	2c6080e7          	jalr	710(ra) # 8002018c <printf>
}
    80022ece:	4501                	li	a0,0
    80022ed0:	60e2                	ld	ra,24(sp)
    80022ed2:	6442                	ld	s0,16(sp)
    80022ed4:	6105                	addi	sp,sp,32
    80022ed6:	8082                	ret

0000000080022ed8 <argaddr>:
{
    80022ed8:	1101                	addi	sp,sp,-32
    80022eda:	ec06                	sd	ra,24(sp)
    80022edc:	e822                	sd	s0,16(sp)
    80022ede:	e426                	sd	s1,8(sp)
    80022ee0:	1000                	addi	s0,sp,32
    80022ee2:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80022ee4:	00000097          	auipc	ra,0x0
    80022ee8:	e60080e7          	jalr	-416(ra) # 80022d44 <argraw>
    80022eec:	e088                	sd	a0,0(s1)
}
    80022eee:	4501                	li	a0,0
    80022ef0:	60e2                	ld	ra,24(sp)
    80022ef2:	6442                	ld	s0,16(sp)
    80022ef4:	64a2                	ld	s1,8(sp)
    80022ef6:	6105                	addi	sp,sp,32
    80022ef8:	8082                	ret

0000000080022efa <argstr>:
{
    80022efa:	1101                	addi	sp,sp,-32
    80022efc:	ec06                	sd	ra,24(sp)
    80022efe:	e822                	sd	s0,16(sp)
    80022f00:	e426                	sd	s1,8(sp)
    80022f02:	e04a                	sd	s2,0(sp)
    80022f04:	1000                	addi	s0,sp,32
    80022f06:	84ae                	mv	s1,a1
    80022f08:	8932                	mv	s2,a2
  *ip = argraw(n);
    80022f0a:	00000097          	auipc	ra,0x0
    80022f0e:	e3a080e7          	jalr	-454(ra) # 80022d44 <argraw>
  return fetchstr(addr, buf, max);
    80022f12:	864a                	mv	a2,s2
    80022f14:	85a6                	mv	a1,s1
    80022f16:	00000097          	auipc	ra,0x0
    80022f1a:	f30080e7          	jalr	-208(ra) # 80022e46 <fetchstr>
}
    80022f1e:	60e2                	ld	ra,24(sp)
    80022f20:	6442                	ld	s0,16(sp)
    80022f22:	64a2                	ld	s1,8(sp)
    80022f24:	6902                	ld	s2,0(sp)
    80022f26:	6105                	addi	sp,sp,32
    80022f28:	8082                	ret

0000000080022f2a <syscall>:
{
    80022f2a:	7179                	addi	sp,sp,-48
    80022f2c:	f406                	sd	ra,40(sp)
    80022f2e:	f022                	sd	s0,32(sp)
    80022f30:	ec26                	sd	s1,24(sp)
    80022f32:	e84a                	sd	s2,16(sp)
    80022f34:	e44e                	sd	s3,8(sp)
    80022f36:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80022f38:	fffff097          	auipc	ra,0xfffff
    80022f3c:	b9a080e7          	jalr	-1126(ra) # 80021ad2 <myproc>
    80022f40:	84aa                	mv	s1,a0
  num = p->trapframe->a7;
    80022f42:	06053903          	ld	s2,96(a0)
    80022f46:	0a893783          	ld	a5,168(s2)
    80022f4a:	0007899b          	sext.w	s3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80022f4e:	37fd                	addiw	a5,a5,-1
    80022f50:	10300713          	li	a4,259
    80022f54:	04f76863          	bltu	a4,a5,80022fa4 <syscall+0x7a>
    80022f58:	00399713          	slli	a4,s3,0x3
    80022f5c:	0000b797          	auipc	a5,0xb
    80022f60:	c3478793          	addi	a5,a5,-972 # 8002db90 <syscalls>
    80022f64:	97ba                	add	a5,a5,a4
    80022f66:	639c                	ld	a5,0(a5)
    80022f68:	cf95                	beqz	a5,80022fa4 <syscall+0x7a>
    p->trapframe->a0 = syscalls[num]();
    80022f6a:	9782                	jalr	a5
    80022f6c:	06a93823          	sd	a0,112(s2)
    if ((p->tmask & (1 << num)) != 0) {
    80022f70:	1704a783          	lw	a5,368(s1)
    80022f74:	4137d7bb          	sraw	a5,a5,s3
    80022f78:	8b85                	andi	a5,a5,1
    80022f7a:	c7a1                	beqz	a5,80022fc2 <syscall+0x98>
      printf("pid %d: %s -> %d\n", p->pid, sysnames[num], p->trapframe->a0);
    80022f7c:	70b8                	ld	a4,96(s1)
    80022f7e:	098e                	slli	s3,s3,0x3
    80022f80:	0000b797          	auipc	a5,0xb
    80022f84:	43878793          	addi	a5,a5,1080 # 8002e3b8 <sysnames>
    80022f88:	99be                	add	s3,s3,a5
    80022f8a:	7b34                	ld	a3,112(a4)
    80022f8c:	0009b603          	ld	a2,0(s3)
    80022f90:	5c8c                	lw	a1,56(s1)
    80022f92:	00009517          	auipc	a0,0x9
    80022f96:	8f650513          	addi	a0,a0,-1802 # 8002b888 <digits+0x600>
    80022f9a:	ffffd097          	auipc	ra,0xffffd
    80022f9e:	1f2080e7          	jalr	498(ra) # 8002018c <printf>
    80022fa2:	a005                	j	80022fc2 <syscall+0x98>
    printf("pid %d %s: unknown sys call %d\n",
    80022fa4:	86ce                	mv	a3,s3
    80022fa6:	16048613          	addi	a2,s1,352
    80022faa:	5c8c                	lw	a1,56(s1)
    80022fac:	00009517          	auipc	a0,0x9
    80022fb0:	8f450513          	addi	a0,a0,-1804 # 8002b8a0 <digits+0x618>
    80022fb4:	ffffd097          	auipc	ra,0xffffd
    80022fb8:	1d8080e7          	jalr	472(ra) # 8002018c <printf>
    p->trapframe->a0 = -1;
    80022fbc:	70bc                	ld	a5,96(s1)
    80022fbe:	577d                	li	a4,-1
    80022fc0:	fbb8                	sd	a4,112(a5)
}
    80022fc2:	70a2                	ld	ra,40(sp)
    80022fc4:	7402                	ld	s0,32(sp)
    80022fc6:	64e2                	ld	s1,24(sp)
    80022fc8:	6942                	ld	s2,16(sp)
    80022fca:	69a2                	ld	s3,8(sp)
    80022fcc:	6145                	addi	sp,sp,48
    80022fce:	8082                	ret

0000000080022fd0 <sys_exec>:

extern int exec(char *path, char **argv);

uint64
sys_exec(void)
{
    80022fd0:	da010113          	addi	sp,sp,-608
    80022fd4:	24113c23          	sd	ra,600(sp)
    80022fd8:	24813823          	sd	s0,592(sp)
    80022fdc:	24913423          	sd	s1,584(sp)
    80022fe0:	25213023          	sd	s2,576(sp)
    80022fe4:	23313c23          	sd	s3,568(sp)
    80022fe8:	23413823          	sd	s4,560(sp)
    80022fec:	23513423          	sd	s5,552(sp)
    80022ff0:	23613023          	sd	s6,544(sp)
    80022ff4:	1480                	addi	s0,sp,608
  char path[FAT32_MAX_PATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argaddr(1, &uargv) < 0){
    80022ff6:	10400613          	li	a2,260
    80022ffa:	eb840593          	addi	a1,s0,-328
    80022ffe:	4501                	li	a0,0
    80023000:	00000097          	auipc	ra,0x0
    80023004:	efa080e7          	jalr	-262(ra) # 80022efa <argstr>
    return -1;
    80023008:	597d                	li	s2,-1
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || argaddr(1, &uargv) < 0){
    8002300a:	0c054a63          	bltz	a0,800230de <sys_exec+0x10e>
    8002300e:	db040593          	addi	a1,s0,-592
    80023012:	4505                	li	a0,1
    80023014:	00000097          	auipc	ra,0x0
    80023018:	ec4080e7          	jalr	-316(ra) # 80022ed8 <argaddr>
    8002301c:	0c054163          	bltz	a0,800230de <sys_exec+0x10e>
  }
  memset(argv, 0, sizeof(argv));
    80023020:	10000613          	li	a2,256
    80023024:	4581                	li	a1,0
    80023026:	db840993          	addi	s3,s0,-584
    8002302a:	854e                	mv	a0,s3
    8002302c:	ffffd097          	auipc	ra,0xffffd
    80023030:	722080e7          	jalr	1826(ra) # 8002074e <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80023034:	84ce                	mv	s1,s3
  memset(argv, 0, sizeof(argv));
    80023036:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80023038:	da840a13          	addi	s4,s0,-600
    if(i >= NELEM(argv)){
    8002303c:	02000a93          	li	s5,32
    80023040:	00090b1b          	sext.w	s6,s2
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80023044:	00391793          	slli	a5,s2,0x3
    80023048:	85d2                	mv	a1,s4
    8002304a:	db043503          	ld	a0,-592(s0)
    8002304e:	953e                	add	a0,a0,a5
    80023050:	00000097          	auipc	ra,0x0
    80023054:	da6080e7          	jalr	-602(ra) # 80022df6 <fetchaddr>
    80023058:	02054a63          	bltz	a0,8002308c <sys_exec+0xbc>
      goto bad;
    }
    if(uarg == 0){
    8002305c:	da843783          	ld	a5,-600(s0)
    80023060:	c3b9                	beqz	a5,800230a6 <sys_exec+0xd6>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80023062:	ffffd097          	auipc	ra,0xffffd
    80023066:	4e4080e7          	jalr	1252(ra) # 80020546 <kalloc>
    8002306a:	85aa                	mv	a1,a0
    8002306c:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80023070:	cd11                	beqz	a0,8002308c <sys_exec+0xbc>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80023072:	6605                	lui	a2,0x1
    80023074:	da843503          	ld	a0,-600(s0)
    80023078:	00000097          	auipc	ra,0x0
    8002307c:	dce080e7          	jalr	-562(ra) # 80022e46 <fetchstr>
    80023080:	00054663          	bltz	a0,8002308c <sys_exec+0xbc>
    if(i >= NELEM(argv)){
    80023084:	0905                	addi	s2,s2,1
    80023086:	09a1                	addi	s3,s3,8
    80023088:	fb591ce3          	bne	s2,s5,80023040 <sys_exec+0x70>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002308c:	10048913          	addi	s2,s1,256
    80023090:	6088                	ld	a0,0(s1)
    80023092:	c529                	beqz	a0,800230dc <sys_exec+0x10c>
    kfree(argv[i]);
    80023094:	ffffd097          	auipc	ra,0xffffd
    80023098:	39a080e7          	jalr	922(ra) # 8002042e <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002309c:	04a1                	addi	s1,s1,8
    8002309e:	ff2499e3          	bne	s1,s2,80023090 <sys_exec+0xc0>
  return -1;
    800230a2:	597d                	li	s2,-1
    800230a4:	a82d                	j	800230de <sys_exec+0x10e>
      argv[i] = 0;
    800230a6:	0b0e                	slli	s6,s6,0x3
    800230a8:	fc040793          	addi	a5,s0,-64
    800230ac:	9b3e                	add	s6,s6,a5
    800230ae:	de0b3c23          	sd	zero,-520(s6) # df8 <_start-0x8001f208>
  int ret = exec(path, argv);
    800230b2:	db840593          	addi	a1,s0,-584
    800230b6:	eb840513          	addi	a0,s0,-328
    800230ba:	00001097          	auipc	ra,0x1
    800230be:	e4e080e7          	jalr	-434(ra) # 80023f08 <exec>
    800230c2:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800230c4:	10048993          	addi	s3,s1,256
    800230c8:	6088                	ld	a0,0(s1)
    800230ca:	c911                	beqz	a0,800230de <sys_exec+0x10e>
    kfree(argv[i]);
    800230cc:	ffffd097          	auipc	ra,0xffffd
    800230d0:	362080e7          	jalr	866(ra) # 8002042e <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800230d4:	04a1                	addi	s1,s1,8
    800230d6:	ff3499e3          	bne	s1,s3,800230c8 <sys_exec+0xf8>
    800230da:	a011                	j	800230de <sys_exec+0x10e>
  return -1;
    800230dc:	597d                	li	s2,-1
}
    800230de:	854a                	mv	a0,s2
    800230e0:	25813083          	ld	ra,600(sp)
    800230e4:	25013403          	ld	s0,592(sp)
    800230e8:	24813483          	ld	s1,584(sp)
    800230ec:	24013903          	ld	s2,576(sp)
    800230f0:	23813983          	ld	s3,568(sp)
    800230f4:	23013a03          	ld	s4,560(sp)
    800230f8:	22813a83          	ld	s5,552(sp)
    800230fc:	22013b03          	ld	s6,544(sp)
    80023100:	26010113          	addi	sp,sp,608
    80023104:	8082                	ret

0000000080023106 <sys_exit>:

uint64
sys_exit(void)
{
    80023106:	1101                	addi	sp,sp,-32
    80023108:	ec06                	sd	ra,24(sp)
    8002310a:	e822                	sd	s0,16(sp)
    8002310c:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    8002310e:	fec40593          	addi	a1,s0,-20
    80023112:	4501                	li	a0,0
    80023114:	00000097          	auipc	ra,0x0
    80023118:	d62080e7          	jalr	-670(ra) # 80022e76 <argint>
    return -1;
    8002311c:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8002311e:	00054963          	bltz	a0,80023130 <sys_exit+0x2a>
  exit(n);
    80023122:	fec42503          	lw	a0,-20(s0)
    80023126:	fffff097          	auipc	ra,0xfffff
    8002312a:	0ee080e7          	jalr	238(ra) # 80022214 <exit>
  return 0;  // not reached
    8002312e:	4781                	li	a5,0
}
    80023130:	853e                	mv	a0,a5
    80023132:	60e2                	ld	ra,24(sp)
    80023134:	6442                	ld	s0,16(sp)
    80023136:	6105                	addi	sp,sp,32
    80023138:	8082                	ret

000000008002313a <sys_getpid>:

uint64
sys_getpid(void)
{
    8002313a:	1141                	addi	sp,sp,-16
    8002313c:	e406                	sd	ra,8(sp)
    8002313e:	e022                	sd	s0,0(sp)
    80023140:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80023142:	fffff097          	auipc	ra,0xfffff
    80023146:	990080e7          	jalr	-1648(ra) # 80021ad2 <myproc>
}
    8002314a:	5d08                	lw	a0,56(a0)
    8002314c:	60a2                	ld	ra,8(sp)
    8002314e:	6402                	ld	s0,0(sp)
    80023150:	0141                	addi	sp,sp,16
    80023152:	8082                	ret

0000000080023154 <sys_fork>:

uint64
sys_fork(void)
{
    80023154:	1141                	addi	sp,sp,-16
    80023156:	e406                	sd	ra,8(sp)
    80023158:	e022                	sd	s0,0(sp)
    8002315a:	0800                	addi	s0,sp,16
  return fork();
    8002315c:	fffff097          	auipc	ra,0xfffff
    80023160:	d7a080e7          	jalr	-646(ra) # 80021ed6 <fork>
}
    80023164:	60a2                	ld	ra,8(sp)
    80023166:	6402                	ld	s0,0(sp)
    80023168:	0141                	addi	sp,sp,16
    8002316a:	8082                	ret

000000008002316c <sys_wait>:

uint64
sys_wait(void)
{
    8002316c:	1101                	addi	sp,sp,-32
    8002316e:	ec06                	sd	ra,24(sp)
    80023170:	e822                	sd	s0,16(sp)
    80023172:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80023174:	fe840593          	addi	a1,s0,-24
    80023178:	4501                	li	a0,0
    8002317a:	00000097          	auipc	ra,0x0
    8002317e:	d5e080e7          	jalr	-674(ra) # 80022ed8 <argaddr>
    80023182:	87aa                	mv	a5,a0
    return -1;
    80023184:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80023186:	0007c863          	bltz	a5,80023196 <sys_wait+0x2a>
  return wait(p);
    8002318a:	fe843503          	ld	a0,-24(s0)
    8002318e:	fffff097          	auipc	ra,0xfffff
    80023192:	240080e7          	jalr	576(ra) # 800223ce <wait>
}
    80023196:	60e2                	ld	ra,24(sp)
    80023198:	6442                	ld	s0,16(sp)
    8002319a:	6105                	addi	sp,sp,32
    8002319c:	8082                	ret

000000008002319e <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8002319e:	7179                	addi	sp,sp,-48
    800231a0:	f406                	sd	ra,40(sp)
    800231a2:	f022                	sd	s0,32(sp)
    800231a4:	ec26                	sd	s1,24(sp)
    800231a6:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    800231a8:	fdc40593          	addi	a1,s0,-36
    800231ac:	4501                	li	a0,0
    800231ae:	00000097          	auipc	ra,0x0
    800231b2:	cc8080e7          	jalr	-824(ra) # 80022e76 <argint>
    return -1;
    800231b6:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    800231b8:	00054f63          	bltz	a0,800231d6 <sys_sbrk+0x38>
  addr = myproc()->sz;
    800231bc:	fffff097          	auipc	ra,0xfffff
    800231c0:	916080e7          	jalr	-1770(ra) # 80021ad2 <myproc>
    800231c4:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    800231c6:	fdc42503          	lw	a0,-36(s0)
    800231ca:	fffff097          	auipc	ra,0xfffff
    800231ce:	c94080e7          	jalr	-876(ra) # 80021e5e <growproc>
    800231d2:	00054863          	bltz	a0,800231e2 <sys_sbrk+0x44>
    return -1;
  return addr;
}
    800231d6:	8526                	mv	a0,s1
    800231d8:	70a2                	ld	ra,40(sp)
    800231da:	7402                	ld	s0,32(sp)
    800231dc:	64e2                	ld	s1,24(sp)
    800231de:	6145                	addi	sp,sp,48
    800231e0:	8082                	ret
    return -1;
    800231e2:	54fd                	li	s1,-1
    800231e4:	bfcd                	j	800231d6 <sys_sbrk+0x38>

00000000800231e6 <sys_sleep>:

uint64
sys_sleep(void)
{
    800231e6:	7139                	addi	sp,sp,-64
    800231e8:	fc06                	sd	ra,56(sp)
    800231ea:	f822                	sd	s0,48(sp)
    800231ec:	f426                	sd	s1,40(sp)
    800231ee:	f04a                	sd	s2,32(sp)
    800231f0:	ec4e                	sd	s3,24(sp)
    800231f2:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800231f4:	fcc40593          	addi	a1,s0,-52
    800231f8:	4501                	li	a0,0
    800231fa:	00000097          	auipc	ra,0x0
    800231fe:	c7c080e7          	jalr	-900(ra) # 80022e76 <argint>
    return -1;
    80023202:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80023204:	06054763          	bltz	a0,80023272 <sys_sleep+0x8c>
  acquire(&tickslock);
    80023208:	0000b517          	auipc	a0,0xb
    8002320c:	2d053503          	ld	a0,720(a0) # 8002e4d8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80023210:	ffffd097          	auipc	ra,0xffffd
    80023214:	4a2080e7          	jalr	1186(ra) # 800206b2 <acquire>
  ticks0 = ticks;
    80023218:	0000b797          	auipc	a5,0xb
    8002321c:	2d07b783          	ld	a5,720(a5) # 8002e4e8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80023220:	0007a903          	lw	s2,0(a5)
  while(ticks - ticks0 < n){
    80023224:	fcc42783          	lw	a5,-52(s0)
    80023228:	cf85                	beqz	a5,80023260 <sys_sleep+0x7a>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    8002322a:	0000b997          	auipc	s3,0xb
    8002322e:	2ae9b983          	ld	s3,686(s3) # 8002e4d8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80023232:	0000b497          	auipc	s1,0xb
    80023236:	2b64b483          	ld	s1,694(s1) # 8002e4e8 <_GLOBAL_OFFSET_TABLE_+0x40>
    if(myproc()->killed){
    8002323a:	fffff097          	auipc	ra,0xfffff
    8002323e:	898080e7          	jalr	-1896(ra) # 80021ad2 <myproc>
    80023242:	591c                	lw	a5,48(a0)
    80023244:	ef9d                	bnez	a5,80023282 <sys_sleep+0x9c>
    sleep(&ticks, &tickslock);
    80023246:	85ce                	mv	a1,s3
    80023248:	8526                	mv	a0,s1
    8002324a:	fffff097          	auipc	ra,0xfffff
    8002324e:	106080e7          	jalr	262(ra) # 80022350 <sleep>
  while(ticks - ticks0 < n){
    80023252:	409c                	lw	a5,0(s1)
    80023254:	412787bb          	subw	a5,a5,s2
    80023258:	fcc42703          	lw	a4,-52(s0)
    8002325c:	fce7efe3          	bltu	a5,a4,8002323a <sys_sleep+0x54>
  }
  release(&tickslock);
    80023260:	0000b517          	auipc	a0,0xb
    80023264:	27853503          	ld	a0,632(a0) # 8002e4d8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80023268:	ffffd097          	auipc	ra,0xffffd
    8002326c:	49e080e7          	jalr	1182(ra) # 80020706 <release>
  return 0;
    80023270:	4781                	li	a5,0
}
    80023272:	853e                	mv	a0,a5
    80023274:	70e2                	ld	ra,56(sp)
    80023276:	7442                	ld	s0,48(sp)
    80023278:	74a2                	ld	s1,40(sp)
    8002327a:	7902                	ld	s2,32(sp)
    8002327c:	69e2                	ld	s3,24(sp)
    8002327e:	6121                	addi	sp,sp,64
    80023280:	8082                	ret
      release(&tickslock);
    80023282:	0000b517          	auipc	a0,0xb
    80023286:	25653503          	ld	a0,598(a0) # 8002e4d8 <_GLOBAL_OFFSET_TABLE_+0x30>
    8002328a:	ffffd097          	auipc	ra,0xffffd
    8002328e:	47c080e7          	jalr	1148(ra) # 80020706 <release>
      return -1;
    80023292:	57fd                	li	a5,-1
    80023294:	bff9                	j	80023272 <sys_sleep+0x8c>

0000000080023296 <sys_kill>:

uint64
sys_kill(void)
{
    80023296:	1101                	addi	sp,sp,-32
    80023298:	ec06                	sd	ra,24(sp)
    8002329a:	e822                	sd	s0,16(sp)
    8002329c:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    8002329e:	fec40593          	addi	a1,s0,-20
    800232a2:	4501                	li	a0,0
    800232a4:	00000097          	auipc	ra,0x0
    800232a8:	bd2080e7          	jalr	-1070(ra) # 80022e76 <argint>
    800232ac:	87aa                	mv	a5,a0
    return -1;
    800232ae:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    800232b0:	0007c863          	bltz	a5,800232c0 <sys_kill+0x2a>
  return kill(pid);
    800232b4:	fec42503          	lw	a0,-20(s0)
    800232b8:	fffff097          	auipc	ra,0xfffff
    800232bc:	27e080e7          	jalr	638(ra) # 80022536 <kill>
}
    800232c0:	60e2                	ld	ra,24(sp)
    800232c2:	6442                	ld	s0,16(sp)
    800232c4:	6105                	addi	sp,sp,32
    800232c6:	8082                	ret

00000000800232c8 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800232c8:	1101                	addi	sp,sp,-32
    800232ca:	ec06                	sd	ra,24(sp)
    800232cc:	e822                	sd	s0,16(sp)
    800232ce:	e426                	sd	s1,8(sp)
    800232d0:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800232d2:	0000b517          	auipc	a0,0xb
    800232d6:	20653503          	ld	a0,518(a0) # 8002e4d8 <_GLOBAL_OFFSET_TABLE_+0x30>
    800232da:	ffffd097          	auipc	ra,0xffffd
    800232de:	3d8080e7          	jalr	984(ra) # 800206b2 <acquire>
  xticks = ticks;
    800232e2:	0000b797          	auipc	a5,0xb
    800232e6:	2067b783          	ld	a5,518(a5) # 8002e4e8 <_GLOBAL_OFFSET_TABLE_+0x40>
    800232ea:	4384                	lw	s1,0(a5)
  release(&tickslock);
    800232ec:	0000b517          	auipc	a0,0xb
    800232f0:	1ec53503          	ld	a0,492(a0) # 8002e4d8 <_GLOBAL_OFFSET_TABLE_+0x30>
    800232f4:	ffffd097          	auipc	ra,0xffffd
    800232f8:	412080e7          	jalr	1042(ra) # 80020706 <release>
  return xticks;
}
    800232fc:	02049513          	slli	a0,s1,0x20
    80023300:	9101                	srli	a0,a0,0x20
    80023302:	60e2                	ld	ra,24(sp)
    80023304:	6442                	ld	s0,16(sp)
    80023306:	64a2                	ld	s1,8(sp)
    80023308:	6105                	addi	sp,sp,32
    8002330a:	8082                	ret

000000008002330c <sys_trace>:

uint64
sys_trace(void)
{
    8002330c:	1101                	addi	sp,sp,-32
    8002330e:	ec06                	sd	ra,24(sp)
    80023310:	e822                	sd	s0,16(sp)
    80023312:	1000                	addi	s0,sp,32
  int mask;
  if(argint(0, &mask) < 0) {
    80023314:	fec40593          	addi	a1,s0,-20
    80023318:	4501                	li	a0,0
    8002331a:	00000097          	auipc	ra,0x0
    8002331e:	b5c080e7          	jalr	-1188(ra) # 80022e76 <argint>
    return -1;
    80023322:	57fd                	li	a5,-1
  if(argint(0, &mask) < 0) {
    80023324:	00054b63          	bltz	a0,8002333a <sys_trace+0x2e>
  }
  myproc()->tmask = mask;
    80023328:	ffffe097          	auipc	ra,0xffffe
    8002332c:	7aa080e7          	jalr	1962(ra) # 80021ad2 <myproc>
    80023330:	fec42783          	lw	a5,-20(s0)
    80023334:	16f52823          	sw	a5,368(a0)
  return 0;
    80023338:	4781                	li	a5,0
    8002333a:	853e                	mv	a0,a5
    8002333c:	60e2                	ld	ra,24(sp)
    8002333e:	6442                	ld	s0,16(sp)
    80023340:	6105                	addi	sp,sp,32
    80023342:	8082                	ret

0000000080023344 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80023344:	7139                	addi	sp,sp,-64
    80023346:	fc06                	sd	ra,56(sp)
    80023348:	f822                	sd	s0,48(sp)
    8002334a:	f426                	sd	s1,40(sp)
    8002334c:	f04a                	sd	s2,32(sp)
    8002334e:	ec4e                	sd	s3,24(sp)
    80023350:	e852                	sd	s4,16(sp)
    80023352:	e456                	sd	s5,8(sp)
    80023354:	0080                	addi	s0,sp,64
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80023356:	00008597          	auipc	a1,0x8
    8002335a:	64a58593          	addi	a1,a1,1610 # 8002b9a0 <digits+0x718>
    8002335e:	00018517          	auipc	a0,0x18
    80023362:	79250513          	addi	a0,a0,1938 # 8003baf0 <bcache>
    80023366:	ffffd097          	auipc	ra,0xffffd
    8002336a:	308080e7          	jalr	776(ra) # 8002066e <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8002336e:	0001c797          	auipc	a5,0x1c
    80023372:	78278793          	addi	a5,a5,1922 # 8003faf0 <bcache+0x4000>
    80023376:	0001d717          	auipc	a4,0x1d
    8002337a:	de270713          	addi	a4,a4,-542 # 80040158 <bcache+0x4668>
    8002337e:	6ae7b823          	sd	a4,1712(a5)
  bcache.head.next = &bcache.head;
    80023382:	6ae7bc23          	sd	a4,1720(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80023386:	00018497          	auipc	s1,0x18
    8002338a:	78248493          	addi	s1,s1,1922 # 8003bb08 <bcache+0x18>
    b->refcnt = 0;
    b->sectorno = ~0;
    8002338e:	5a7d                	li	s4,-1
    b->dev = ~0;
    b->next = bcache.head.next;
    80023390:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80023392:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80023394:	00008a97          	auipc	s5,0x8
    80023398:	614a8a93          	addi	s5,s5,1556 # 8002b9a8 <digits+0x720>
    b->refcnt = 0;
    8002339c:	0404a023          	sw	zero,64(s1)
    b->sectorno = ~0;
    800233a0:	0144a623          	sw	s4,12(s1)
    b->dev = ~0;
    800233a4:	0144a423          	sw	s4,8(s1)
    b->next = bcache.head.next;
    800233a8:	6b893783          	ld	a5,1720(s2)
    800233ac:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    800233ae:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    800233b2:	85d6                	mv	a1,s5
    800233b4:	01048513          	addi	a0,s1,16
    800233b8:	00000097          	auipc	ra,0x0
    800233bc:	26e080e7          	jalr	622(ra) # 80023626 <initsleeplock>
    bcache.head.next->prev = b;
    800233c0:	6b893783          	ld	a5,1720(s2)
    800233c4:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    800233c6:	6a993c23          	sd	s1,1720(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800233ca:	25848493          	addi	s1,s1,600
    800233ce:	fd3497e3          	bne	s1,s3,8002339c <binit+0x58>
  }
  #ifdef DEBUG
  printf("binit\n");
  #endif
}
    800233d2:	70e2                	ld	ra,56(sp)
    800233d4:	7442                	ld	s0,48(sp)
    800233d6:	74a2                	ld	s1,40(sp)
    800233d8:	7902                	ld	s2,32(sp)
    800233da:	69e2                	ld	s3,24(sp)
    800233dc:	6a42                	ld	s4,16(sp)
    800233de:	6aa2                	ld	s5,8(sp)
    800233e0:	6121                	addi	sp,sp,64
    800233e2:	8082                	ret

00000000800233e4 <bread>:
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf* 
bread(uint dev, uint sectorno) {
    800233e4:	7179                	addi	sp,sp,-48
    800233e6:	f406                	sd	ra,40(sp)
    800233e8:	f022                	sd	s0,32(sp)
    800233ea:	ec26                	sd	s1,24(sp)
    800233ec:	e84a                	sd	s2,16(sp)
    800233ee:	e44e                	sd	s3,8(sp)
    800233f0:	1800                	addi	s0,sp,48
    800233f2:	892a                	mv	s2,a0
    800233f4:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    800233f6:	00018517          	auipc	a0,0x18
    800233fa:	6fa50513          	addi	a0,a0,1786 # 8003baf0 <bcache>
    800233fe:	ffffd097          	auipc	ra,0xffffd
    80023402:	2b4080e7          	jalr	692(ra) # 800206b2 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80023406:	0001d497          	auipc	s1,0x1d
    8002340a:	da24b483          	ld	s1,-606(s1) # 800401a8 <bcache+0x46b8>
    8002340e:	0001d797          	auipc	a5,0x1d
    80023412:	d4a78793          	addi	a5,a5,-694 # 80040158 <bcache+0x4668>
    80023416:	02f48f63          	beq	s1,a5,80023454 <bread+0x70>
    8002341a:	873e                	mv	a4,a5
    8002341c:	a021                	j	80023424 <bread+0x40>
    8002341e:	68a4                	ld	s1,80(s1)
    80023420:	02e48a63          	beq	s1,a4,80023454 <bread+0x70>
    if(b->dev == dev && b->sectorno == sectorno){
    80023424:	449c                	lw	a5,8(s1)
    80023426:	ff279ce3          	bne	a5,s2,8002341e <bread+0x3a>
    8002342a:	44dc                	lw	a5,12(s1)
    8002342c:	ff3799e3          	bne	a5,s3,8002341e <bread+0x3a>
      b->refcnt++;
    80023430:	40bc                	lw	a5,64(s1)
    80023432:	2785                	addiw	a5,a5,1
    80023434:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80023436:	00018517          	auipc	a0,0x18
    8002343a:	6ba50513          	addi	a0,a0,1722 # 8003baf0 <bcache>
    8002343e:	ffffd097          	auipc	ra,0xffffd
    80023442:	2c8080e7          	jalr	712(ra) # 80020706 <release>
      acquiresleep(&b->lock);
    80023446:	01048513          	addi	a0,s1,16
    8002344a:	00000097          	auipc	ra,0x0
    8002344e:	216080e7          	jalr	534(ra) # 80023660 <acquiresleep>
      return b;
    80023452:	a8b9                	j	800234b0 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80023454:	0001d497          	auipc	s1,0x1d
    80023458:	d4c4b483          	ld	s1,-692(s1) # 800401a0 <bcache+0x46b0>
    8002345c:	0001d797          	auipc	a5,0x1d
    80023460:	cfc78793          	addi	a5,a5,-772 # 80040158 <bcache+0x4668>
    80023464:	00f48863          	beq	s1,a5,80023474 <bread+0x90>
    80023468:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8002346a:	40bc                	lw	a5,64(s1)
    8002346c:	cf81                	beqz	a5,80023484 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8002346e:	64a4                	ld	s1,72(s1)
    80023470:	fee49de3          	bne	s1,a4,8002346a <bread+0x86>
  panic("bget: no buffers");
    80023474:	00008517          	auipc	a0,0x8
    80023478:	53c50513          	addi	a0,a0,1340 # 8002b9b0 <digits+0x728>
    8002347c:	ffffd097          	auipc	ra,0xffffd
    80023480:	cc6080e7          	jalr	-826(ra) # 80020142 <panic>
      b->dev = dev;
    80023484:	0124a423          	sw	s2,8(s1)
      b->sectorno = sectorno;
    80023488:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    8002348c:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80023490:	4785                	li	a5,1
    80023492:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80023494:	00018517          	auipc	a0,0x18
    80023498:	65c50513          	addi	a0,a0,1628 # 8003baf0 <bcache>
    8002349c:	ffffd097          	auipc	ra,0xffffd
    800234a0:	26a080e7          	jalr	618(ra) # 80020706 <release>
      acquiresleep(&b->lock);
    800234a4:	01048513          	addi	a0,s1,16
    800234a8:	00000097          	auipc	ra,0x0
    800234ac:	1b8080e7          	jalr	440(ra) # 80023660 <acquiresleep>
  struct buf *b;

  b = bget(dev, sectorno);
  if (!b->valid) {
    800234b0:	409c                	lw	a5,0(s1)
    800234b2:	cb89                	beqz	a5,800234c4 <bread+0xe0>
    disk_read(b);
    b->valid = 1;
  }

  return b;
}
    800234b4:	8526                	mv	a0,s1
    800234b6:	70a2                	ld	ra,40(sp)
    800234b8:	7402                	ld	s0,32(sp)
    800234ba:	64e2                	ld	s1,24(sp)
    800234bc:	6942                	ld	s2,16(sp)
    800234be:	69a2                	ld	s3,8(sp)
    800234c0:	6145                	addi	sp,sp,48
    800234c2:	8082                	ret
    disk_read(b);
    800234c4:	8526                	mv	a0,s1
    800234c6:	00002097          	auipc	ra,0x2
    800234ca:	b8c080e7          	jalr	-1140(ra) # 80025052 <disk_read>
    b->valid = 1;
    800234ce:	4785                	li	a5,1
    800234d0:	c09c                	sw	a5,0(s1)
  return b;
    800234d2:	b7cd                	j	800234b4 <bread+0xd0>

00000000800234d4 <bwrite>:

// Write b's contents to disk.  Must be locked.
void 
bwrite(struct buf *b) {
    800234d4:	1101                	addi	sp,sp,-32
    800234d6:	ec06                	sd	ra,24(sp)
    800234d8:	e822                	sd	s0,16(sp)
    800234da:	e426                	sd	s1,8(sp)
    800234dc:	1000                	addi	s0,sp,32
    800234de:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800234e0:	0541                	addi	a0,a0,16
    800234e2:	00000097          	auipc	ra,0x0
    800234e6:	218080e7          	jalr	536(ra) # 800236fa <holdingsleep>
    800234ea:	c919                	beqz	a0,80023500 <bwrite+0x2c>
    panic("bwrite");
  disk_write(b);
    800234ec:	8526                	mv	a0,s1
    800234ee:	00002097          	auipc	ra,0x2
    800234f2:	b82080e7          	jalr	-1150(ra) # 80025070 <disk_write>
}
    800234f6:	60e2                	ld	ra,24(sp)
    800234f8:	6442                	ld	s0,16(sp)
    800234fa:	64a2                	ld	s1,8(sp)
    800234fc:	6105                	addi	sp,sp,32
    800234fe:	8082                	ret
    panic("bwrite");
    80023500:	00008517          	auipc	a0,0x8
    80023504:	4c850513          	addi	a0,a0,1224 # 8002b9c8 <digits+0x740>
    80023508:	ffffd097          	auipc	ra,0xffffd
    8002350c:	c3a080e7          	jalr	-966(ra) # 80020142 <panic>

0000000080023510 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80023510:	1101                	addi	sp,sp,-32
    80023512:	ec06                	sd	ra,24(sp)
    80023514:	e822                	sd	s0,16(sp)
    80023516:	e426                	sd	s1,8(sp)
    80023518:	e04a                	sd	s2,0(sp)
    8002351a:	1000                	addi	s0,sp,32
    8002351c:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8002351e:	01050913          	addi	s2,a0,16
    80023522:	854a                	mv	a0,s2
    80023524:	00000097          	auipc	ra,0x0
    80023528:	1d6080e7          	jalr	470(ra) # 800236fa <holdingsleep>
    8002352c:	c92d                	beqz	a0,8002359e <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    8002352e:	854a                	mv	a0,s2
    80023530:	00000097          	auipc	ra,0x0
    80023534:	186080e7          	jalr	390(ra) # 800236b6 <releasesleep>

  acquire(&bcache.lock);
    80023538:	00018517          	auipc	a0,0x18
    8002353c:	5b850513          	addi	a0,a0,1464 # 8003baf0 <bcache>
    80023540:	ffffd097          	auipc	ra,0xffffd
    80023544:	172080e7          	jalr	370(ra) # 800206b2 <acquire>
  b->refcnt--;
    80023548:	40bc                	lw	a5,64(s1)
    8002354a:	37fd                	addiw	a5,a5,-1
    8002354c:	0007871b          	sext.w	a4,a5
    80023550:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80023552:	eb05                	bnez	a4,80023582 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80023554:	68bc                	ld	a5,80(s1)
    80023556:	64b8                	ld	a4,72(s1)
    80023558:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    8002355a:	64bc                	ld	a5,72(s1)
    8002355c:	68b8                	ld	a4,80(s1)
    8002355e:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80023560:	0001c797          	auipc	a5,0x1c
    80023564:	59078793          	addi	a5,a5,1424 # 8003faf0 <bcache+0x4000>
    80023568:	6b87b703          	ld	a4,1720(a5)
    8002356c:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    8002356e:	0001d717          	auipc	a4,0x1d
    80023572:	bea70713          	addi	a4,a4,-1046 # 80040158 <bcache+0x4668>
    80023576:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80023578:	6b87b703          	ld	a4,1720(a5)
    8002357c:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    8002357e:	6a97bc23          	sd	s1,1720(a5)
  }
  
  release(&bcache.lock);
    80023582:	00018517          	auipc	a0,0x18
    80023586:	56e50513          	addi	a0,a0,1390 # 8003baf0 <bcache>
    8002358a:	ffffd097          	auipc	ra,0xffffd
    8002358e:	17c080e7          	jalr	380(ra) # 80020706 <release>
}
    80023592:	60e2                	ld	ra,24(sp)
    80023594:	6442                	ld	s0,16(sp)
    80023596:	64a2                	ld	s1,8(sp)
    80023598:	6902                	ld	s2,0(sp)
    8002359a:	6105                	addi	sp,sp,32
    8002359c:	8082                	ret
    panic("brelse");
    8002359e:	00008517          	auipc	a0,0x8
    800235a2:	43250513          	addi	a0,a0,1074 # 8002b9d0 <digits+0x748>
    800235a6:	ffffd097          	auipc	ra,0xffffd
    800235aa:	b9c080e7          	jalr	-1124(ra) # 80020142 <panic>

00000000800235ae <bpin>:

void
bpin(struct buf *b) {
    800235ae:	1101                	addi	sp,sp,-32
    800235b0:	ec06                	sd	ra,24(sp)
    800235b2:	e822                	sd	s0,16(sp)
    800235b4:	e426                	sd	s1,8(sp)
    800235b6:	1000                	addi	s0,sp,32
    800235b8:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800235ba:	00018517          	auipc	a0,0x18
    800235be:	53650513          	addi	a0,a0,1334 # 8003baf0 <bcache>
    800235c2:	ffffd097          	auipc	ra,0xffffd
    800235c6:	0f0080e7          	jalr	240(ra) # 800206b2 <acquire>
  b->refcnt++;
    800235ca:	40bc                	lw	a5,64(s1)
    800235cc:	2785                	addiw	a5,a5,1
    800235ce:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800235d0:	00018517          	auipc	a0,0x18
    800235d4:	52050513          	addi	a0,a0,1312 # 8003baf0 <bcache>
    800235d8:	ffffd097          	auipc	ra,0xffffd
    800235dc:	12e080e7          	jalr	302(ra) # 80020706 <release>
}
    800235e0:	60e2                	ld	ra,24(sp)
    800235e2:	6442                	ld	s0,16(sp)
    800235e4:	64a2                	ld	s1,8(sp)
    800235e6:	6105                	addi	sp,sp,32
    800235e8:	8082                	ret

00000000800235ea <bunpin>:

void
bunpin(struct buf *b) {
    800235ea:	1101                	addi	sp,sp,-32
    800235ec:	ec06                	sd	ra,24(sp)
    800235ee:	e822                	sd	s0,16(sp)
    800235f0:	e426                	sd	s1,8(sp)
    800235f2:	1000                	addi	s0,sp,32
    800235f4:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800235f6:	00018517          	auipc	a0,0x18
    800235fa:	4fa50513          	addi	a0,a0,1274 # 8003baf0 <bcache>
    800235fe:	ffffd097          	auipc	ra,0xffffd
    80023602:	0b4080e7          	jalr	180(ra) # 800206b2 <acquire>
  b->refcnt--;
    80023606:	40bc                	lw	a5,64(s1)
    80023608:	37fd                	addiw	a5,a5,-1
    8002360a:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8002360c:	00018517          	auipc	a0,0x18
    80023610:	4e450513          	addi	a0,a0,1252 # 8003baf0 <bcache>
    80023614:	ffffd097          	auipc	ra,0xffffd
    80023618:	0f2080e7          	jalr	242(ra) # 80020706 <release>
}
    8002361c:	60e2                	ld	ra,24(sp)
    8002361e:	6442                	ld	s0,16(sp)
    80023620:	64a2                	ld	s1,8(sp)
    80023622:	6105                	addi	sp,sp,32
    80023624:	8082                	ret

0000000080023626 <initsleeplock>:
#include "include/proc.h"
#include "include/sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80023626:	1101                	addi	sp,sp,-32
    80023628:	ec06                	sd	ra,24(sp)
    8002362a:	e822                	sd	s0,16(sp)
    8002362c:	e426                	sd	s1,8(sp)
    8002362e:	e04a                	sd	s2,0(sp)
    80023630:	1000                	addi	s0,sp,32
    80023632:	84aa                	mv	s1,a0
    80023634:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80023636:	00008597          	auipc	a1,0x8
    8002363a:	3a258593          	addi	a1,a1,930 # 8002b9d8 <digits+0x750>
    8002363e:	0521                	addi	a0,a0,8
    80023640:	ffffd097          	auipc	ra,0xffffd
    80023644:	02e080e7          	jalr	46(ra) # 8002066e <initlock>
  lk->name = name;
    80023648:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8002364c:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80023650:	0204a423          	sw	zero,40(s1)
}
    80023654:	60e2                	ld	ra,24(sp)
    80023656:	6442                	ld	s0,16(sp)
    80023658:	64a2                	ld	s1,8(sp)
    8002365a:	6902                	ld	s2,0(sp)
    8002365c:	6105                	addi	sp,sp,32
    8002365e:	8082                	ret

0000000080023660 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80023660:	1101                	addi	sp,sp,-32
    80023662:	ec06                	sd	ra,24(sp)
    80023664:	e822                	sd	s0,16(sp)
    80023666:	e426                	sd	s1,8(sp)
    80023668:	e04a                	sd	s2,0(sp)
    8002366a:	1000                	addi	s0,sp,32
    8002366c:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8002366e:	00850913          	addi	s2,a0,8
    80023672:	854a                	mv	a0,s2
    80023674:	ffffd097          	auipc	ra,0xffffd
    80023678:	03e080e7          	jalr	62(ra) # 800206b2 <acquire>
  while (lk->locked) {
    8002367c:	409c                	lw	a5,0(s1)
    8002367e:	cb89                	beqz	a5,80023690 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80023680:	85ca                	mv	a1,s2
    80023682:	8526                	mv	a0,s1
    80023684:	fffff097          	auipc	ra,0xfffff
    80023688:	ccc080e7          	jalr	-820(ra) # 80022350 <sleep>
  while (lk->locked) {
    8002368c:	409c                	lw	a5,0(s1)
    8002368e:	fbed                	bnez	a5,80023680 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80023690:	4785                	li	a5,1
    80023692:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80023694:	ffffe097          	auipc	ra,0xffffe
    80023698:	43e080e7          	jalr	1086(ra) # 80021ad2 <myproc>
    8002369c:	5d1c                	lw	a5,56(a0)
    8002369e:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800236a0:	854a                	mv	a0,s2
    800236a2:	ffffd097          	auipc	ra,0xffffd
    800236a6:	064080e7          	jalr	100(ra) # 80020706 <release>
}
    800236aa:	60e2                	ld	ra,24(sp)
    800236ac:	6442                	ld	s0,16(sp)
    800236ae:	64a2                	ld	s1,8(sp)
    800236b0:	6902                	ld	s2,0(sp)
    800236b2:	6105                	addi	sp,sp,32
    800236b4:	8082                	ret

00000000800236b6 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800236b6:	1101                	addi	sp,sp,-32
    800236b8:	ec06                	sd	ra,24(sp)
    800236ba:	e822                	sd	s0,16(sp)
    800236bc:	e426                	sd	s1,8(sp)
    800236be:	e04a                	sd	s2,0(sp)
    800236c0:	1000                	addi	s0,sp,32
    800236c2:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800236c4:	00850913          	addi	s2,a0,8
    800236c8:	854a                	mv	a0,s2
    800236ca:	ffffd097          	auipc	ra,0xffffd
    800236ce:	fe8080e7          	jalr	-24(ra) # 800206b2 <acquire>
  lk->locked = 0;
    800236d2:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800236d6:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800236da:	8526                	mv	a0,s1
    800236dc:	fffff097          	auipc	ra,0xfffff
    800236e0:	df0080e7          	jalr	-528(ra) # 800224cc <wakeup>
  release(&lk->lk);
    800236e4:	854a                	mv	a0,s2
    800236e6:	ffffd097          	auipc	ra,0xffffd
    800236ea:	020080e7          	jalr	32(ra) # 80020706 <release>
}
    800236ee:	60e2                	ld	ra,24(sp)
    800236f0:	6442                	ld	s0,16(sp)
    800236f2:	64a2                	ld	s1,8(sp)
    800236f4:	6902                	ld	s2,0(sp)
    800236f6:	6105                	addi	sp,sp,32
    800236f8:	8082                	ret

00000000800236fa <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800236fa:	7179                	addi	sp,sp,-48
    800236fc:	f406                	sd	ra,40(sp)
    800236fe:	f022                	sd	s0,32(sp)
    80023700:	ec26                	sd	s1,24(sp)
    80023702:	e84a                	sd	s2,16(sp)
    80023704:	e44e                	sd	s3,8(sp)
    80023706:	1800                	addi	s0,sp,48
    80023708:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    8002370a:	00850913          	addi	s2,a0,8
    8002370e:	854a                	mv	a0,s2
    80023710:	ffffd097          	auipc	ra,0xffffd
    80023714:	fa2080e7          	jalr	-94(ra) # 800206b2 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80023718:	409c                	lw	a5,0(s1)
    8002371a:	ef99                	bnez	a5,80023738 <holdingsleep+0x3e>
    8002371c:	4481                	li	s1,0
  release(&lk->lk);
    8002371e:	854a                	mv	a0,s2
    80023720:	ffffd097          	auipc	ra,0xffffd
    80023724:	fe6080e7          	jalr	-26(ra) # 80020706 <release>
  return r;
}
    80023728:	8526                	mv	a0,s1
    8002372a:	70a2                	ld	ra,40(sp)
    8002372c:	7402                	ld	s0,32(sp)
    8002372e:	64e2                	ld	s1,24(sp)
    80023730:	6942                	ld	s2,16(sp)
    80023732:	69a2                	ld	s3,8(sp)
    80023734:	6145                	addi	sp,sp,48
    80023736:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80023738:	0284a983          	lw	s3,40(s1)
    8002373c:	ffffe097          	auipc	ra,0xffffe
    80023740:	396080e7          	jalr	918(ra) # 80021ad2 <myproc>
    80023744:	5d04                	lw	s1,56(a0)
    80023746:	413484b3          	sub	s1,s1,s3
    8002374a:	0014b493          	seqz	s1,s1
    8002374e:	bfc1                	j	8002371e <holdingsleep+0x24>

0000000080023750 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80023750:	1101                	addi	sp,sp,-32
    80023752:	ec06                	sd	ra,24(sp)
    80023754:	e822                	sd	s0,16(sp)
    80023756:	e426                	sd	s1,8(sp)
    80023758:	e04a                	sd	s2,0(sp)
    8002375a:	1000                	addi	s0,sp,32
  initlock(&ftable.lock, "ftable");
    8002375c:	00008597          	auipc	a1,0x8
    80023760:	28c58593          	addi	a1,a1,652 # 8002b9e8 <digits+0x760>
    80023764:	0001d517          	auipc	a0,0x1d
    80023768:	cec50513          	addi	a0,a0,-788 # 80040450 <ftable>
    8002376c:	ffffd097          	auipc	ra,0xffffd
    80023770:	f02080e7          	jalr	-254(ra) # 8002066e <initlock>
  struct file *f;
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80023774:	0001d497          	auipc	s1,0x1d
    80023778:	cf448493          	addi	s1,s1,-780 # 80040468 <ftable+0x18>
    8002377c:	0001e917          	auipc	s2,0x1e
    80023780:	c8c90913          	addi	s2,s2,-884 # 80041408 <tickslock>
    memset(f, 0, sizeof(struct file));
    80023784:	02800613          	li	a2,40
    80023788:	4581                	li	a1,0
    8002378a:	8526                	mv	a0,s1
    8002378c:	ffffd097          	auipc	ra,0xffffd
    80023790:	fc2080e7          	jalr	-62(ra) # 8002074e <memset>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80023794:	02848493          	addi	s1,s1,40
    80023798:	ff2496e3          	bne	s1,s2,80023784 <fileinit+0x34>
  }
  #ifdef DEBUG
  printf("fileinit\n");
  #endif
}
    8002379c:	60e2                	ld	ra,24(sp)
    8002379e:	6442                	ld	s0,16(sp)
    800237a0:	64a2                	ld	s1,8(sp)
    800237a2:	6902                	ld	s2,0(sp)
    800237a4:	6105                	addi	sp,sp,32
    800237a6:	8082                	ret

00000000800237a8 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800237a8:	1101                	addi	sp,sp,-32
    800237aa:	ec06                	sd	ra,24(sp)
    800237ac:	e822                	sd	s0,16(sp)
    800237ae:	e426                	sd	s1,8(sp)
    800237b0:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800237b2:	0001d517          	auipc	a0,0x1d
    800237b6:	c9e50513          	addi	a0,a0,-866 # 80040450 <ftable>
    800237ba:	ffffd097          	auipc	ra,0xffffd
    800237be:	ef8080e7          	jalr	-264(ra) # 800206b2 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800237c2:	0001d497          	auipc	s1,0x1d
    800237c6:	ca648493          	addi	s1,s1,-858 # 80040468 <ftable+0x18>
    800237ca:	0001e717          	auipc	a4,0x1e
    800237ce:	c3e70713          	addi	a4,a4,-962 # 80041408 <tickslock>
    if(f->ref == 0){
    800237d2:	40dc                	lw	a5,4(s1)
    800237d4:	cf99                	beqz	a5,800237f2 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800237d6:	02848493          	addi	s1,s1,40
    800237da:	fee49ce3          	bne	s1,a4,800237d2 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800237de:	0001d517          	auipc	a0,0x1d
    800237e2:	c7250513          	addi	a0,a0,-910 # 80040450 <ftable>
    800237e6:	ffffd097          	auipc	ra,0xffffd
    800237ea:	f20080e7          	jalr	-224(ra) # 80020706 <release>
  return NULL;
    800237ee:	4481                	li	s1,0
    800237f0:	a819                	j	80023806 <filealloc+0x5e>
      f->ref = 1;
    800237f2:	4785                	li	a5,1
    800237f4:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800237f6:	0001d517          	auipc	a0,0x1d
    800237fa:	c5a50513          	addi	a0,a0,-934 # 80040450 <ftable>
    800237fe:	ffffd097          	auipc	ra,0xffffd
    80023802:	f08080e7          	jalr	-248(ra) # 80020706 <release>
}
    80023806:	8526                	mv	a0,s1
    80023808:	60e2                	ld	ra,24(sp)
    8002380a:	6442                	ld	s0,16(sp)
    8002380c:	64a2                	ld	s1,8(sp)
    8002380e:	6105                	addi	sp,sp,32
    80023810:	8082                	ret

0000000080023812 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80023812:	1101                	addi	sp,sp,-32
    80023814:	ec06                	sd	ra,24(sp)
    80023816:	e822                	sd	s0,16(sp)
    80023818:	e426                	sd	s1,8(sp)
    8002381a:	1000                	addi	s0,sp,32
    8002381c:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8002381e:	0001d517          	auipc	a0,0x1d
    80023822:	c3250513          	addi	a0,a0,-974 # 80040450 <ftable>
    80023826:	ffffd097          	auipc	ra,0xffffd
    8002382a:	e8c080e7          	jalr	-372(ra) # 800206b2 <acquire>
  if(f->ref < 1)
    8002382e:	40dc                	lw	a5,4(s1)
    80023830:	02f05263          	blez	a5,80023854 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80023834:	2785                	addiw	a5,a5,1
    80023836:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80023838:	0001d517          	auipc	a0,0x1d
    8002383c:	c1850513          	addi	a0,a0,-1000 # 80040450 <ftable>
    80023840:	ffffd097          	auipc	ra,0xffffd
    80023844:	ec6080e7          	jalr	-314(ra) # 80020706 <release>
  return f;
}
    80023848:	8526                	mv	a0,s1
    8002384a:	60e2                	ld	ra,24(sp)
    8002384c:	6442                	ld	s0,16(sp)
    8002384e:	64a2                	ld	s1,8(sp)
    80023850:	6105                	addi	sp,sp,32
    80023852:	8082                	ret
    panic("filedup");
    80023854:	00008517          	auipc	a0,0x8
    80023858:	19c50513          	addi	a0,a0,412 # 8002b9f0 <digits+0x768>
    8002385c:	ffffd097          	auipc	ra,0xffffd
    80023860:	8e6080e7          	jalr	-1818(ra) # 80020142 <panic>

0000000080023864 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80023864:	7139                	addi	sp,sp,-64
    80023866:	fc06                	sd	ra,56(sp)
    80023868:	f822                	sd	s0,48(sp)
    8002386a:	f426                	sd	s1,40(sp)
    8002386c:	f04a                	sd	s2,32(sp)
    8002386e:	ec4e                	sd	s3,24(sp)
    80023870:	e852                	sd	s4,16(sp)
    80023872:	e456                	sd	s5,8(sp)
    80023874:	0080                	addi	s0,sp,64
    80023876:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80023878:	0001d517          	auipc	a0,0x1d
    8002387c:	bd850513          	addi	a0,a0,-1064 # 80040450 <ftable>
    80023880:	ffffd097          	auipc	ra,0xffffd
    80023884:	e32080e7          	jalr	-462(ra) # 800206b2 <acquire>
  if(f->ref < 1)
    80023888:	40dc                	lw	a5,4(s1)
    8002388a:	04f05863          	blez	a5,800238da <fileclose+0x76>
    panic("fileclose");
  if(--f->ref > 0){
    8002388e:	37fd                	addiw	a5,a5,-1
    80023890:	0007871b          	sext.w	a4,a5
    80023894:	c0dc                	sw	a5,4(s1)
    80023896:	04e04a63          	bgtz	a4,800238ea <fileclose+0x86>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    8002389a:	0004a903          	lw	s2,0(s1)
    8002389e:	0094ca03          	lbu	s4,9(s1)
    800238a2:	0104b983          	ld	s3,16(s1)
    800238a6:	0184ba83          	ld	s5,24(s1)
  f->ref = 0;
    800238aa:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    800238ae:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    800238b2:	0001d517          	auipc	a0,0x1d
    800238b6:	b9e50513          	addi	a0,a0,-1122 # 80040450 <ftable>
    800238ba:	ffffd097          	auipc	ra,0xffffd
    800238be:	e4c080e7          	jalr	-436(ra) # 80020706 <release>

  if(ff.type == FD_PIPE){
    800238c2:	4785                	li	a5,1
    800238c4:	04f90463          	beq	s2,a5,8002390c <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_ENTRY){
    800238c8:	4789                	li	a5,2
    800238ca:	02f91863          	bne	s2,a5,800238fa <fileclose+0x96>
    eput(ff.ep);
    800238ce:	8556                	mv	a0,s5
    800238d0:	00003097          	auipc	ra,0x3
    800238d4:	998080e7          	jalr	-1640(ra) # 80026268 <eput>
    800238d8:	a00d                	j	800238fa <fileclose+0x96>
    panic("fileclose");
    800238da:	00008517          	auipc	a0,0x8
    800238de:	11e50513          	addi	a0,a0,286 # 8002b9f8 <digits+0x770>
    800238e2:	ffffd097          	auipc	ra,0xffffd
    800238e6:	860080e7          	jalr	-1952(ra) # 80020142 <panic>
    release(&ftable.lock);
    800238ea:	0001d517          	auipc	a0,0x1d
    800238ee:	b6650513          	addi	a0,a0,-1178 # 80040450 <ftable>
    800238f2:	ffffd097          	auipc	ra,0xffffd
    800238f6:	e14080e7          	jalr	-492(ra) # 80020706 <release>
  } else if (ff.type == FD_DEVICE) {

  }
}
    800238fa:	70e2                	ld	ra,56(sp)
    800238fc:	7442                	ld	s0,48(sp)
    800238fe:	74a2                	ld	s1,40(sp)
    80023900:	7902                	ld	s2,32(sp)
    80023902:	69e2                	ld	s3,24(sp)
    80023904:	6a42                	ld	s4,16(sp)
    80023906:	6aa2                	ld	s5,8(sp)
    80023908:	6121                	addi	sp,sp,64
    8002390a:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    8002390c:	85d2                	mv	a1,s4
    8002390e:	854e                	mv	a0,s3
    80023910:	00000097          	auipc	ra,0x0
    80023914:	3a2080e7          	jalr	930(ra) # 80023cb2 <pipeclose>
    80023918:	b7cd                	j	800238fa <fileclose+0x96>

000000008002391a <filestat>:
filestat(struct file *f, uint64 addr)
{
  // struct proc *p = myproc();
  struct stat st;
  
  if(f->type == FD_ENTRY){
    8002391a:	4118                	lw	a4,0(a0)
    8002391c:	4789                	li	a5,2
    8002391e:	04f71e63          	bne	a4,a5,8002397a <filestat+0x60>
{
    80023922:	7159                	addi	sp,sp,-112
    80023924:	f486                	sd	ra,104(sp)
    80023926:	f0a2                	sd	s0,96(sp)
    80023928:	eca6                	sd	s1,88(sp)
    8002392a:	e8ca                	sd	s2,80(sp)
    8002392c:	e4ce                	sd	s3,72(sp)
    8002392e:	1880                	addi	s0,sp,112
    80023930:	84aa                	mv	s1,a0
    80023932:	892e                	mv	s2,a1
    elock(f->ep);
    80023934:	6d08                	ld	a0,24(a0)
    80023936:	00003097          	auipc	ra,0x3
    8002393a:	8ae080e7          	jalr	-1874(ra) # 800261e4 <elock>
    estat(f->ep, &st);
    8002393e:	f9840993          	addi	s3,s0,-104
    80023942:	85ce                	mv	a1,s3
    80023944:	6c88                	ld	a0,24(s1)
    80023946:	00003097          	auipc	ra,0x3
    8002394a:	a5a080e7          	jalr	-1446(ra) # 800263a0 <estat>
    eunlock(f->ep);
    8002394e:	6c88                	ld	a0,24(s1)
    80023950:	00003097          	auipc	ra,0x3
    80023954:	8ca080e7          	jalr	-1846(ra) # 8002621a <eunlock>
    // if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    80023958:	03800613          	li	a2,56
    8002395c:	85ce                	mv	a1,s3
    8002395e:	854a                	mv	a0,s2
    80023960:	ffffe097          	auipc	ra,0xffffe
    80023964:	aa4080e7          	jalr	-1372(ra) # 80021404 <copyout2>
    80023968:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    8002396c:	70a6                	ld	ra,104(sp)
    8002396e:	7406                	ld	s0,96(sp)
    80023970:	64e6                	ld	s1,88(sp)
    80023972:	6946                	ld	s2,80(sp)
    80023974:	69a6                	ld	s3,72(sp)
    80023976:	6165                	addi	sp,sp,112
    80023978:	8082                	ret
  return -1;
    8002397a:	557d                	li	a0,-1
}
    8002397c:	8082                	ret

000000008002397e <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    8002397e:	7179                	addi	sp,sp,-48
    80023980:	f406                	sd	ra,40(sp)
    80023982:	f022                	sd	s0,32(sp)
    80023984:	ec26                	sd	s1,24(sp)
    80023986:	e84a                	sd	s2,16(sp)
    80023988:	e44e                	sd	s3,8(sp)
    8002398a:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    8002398c:	00854783          	lbu	a5,8(a0)
    80023990:	c3d5                	beqz	a5,80023a34 <fileread+0xb6>
    80023992:	84aa                	mv	s1,a0
    80023994:	89ae                	mv	s3,a1
    80023996:	8932                	mv	s2,a2
    return -1;

  switch (f->type) {
    80023998:	411c                	lw	a5,0(a0)
    8002399a:	4709                	li	a4,2
    8002399c:	06e78263          	beq	a5,a4,80023a00 <fileread+0x82>
    800239a0:	470d                	li	a4,3
    800239a2:	02e78b63          	beq	a5,a4,800239d8 <fileread+0x5a>
    800239a6:	4705                	li	a4,1
    800239a8:	00e78a63          	beq	a5,a4,800239bc <fileread+0x3e>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
            f->off += r;
        eunlock(f->ep);
        break;
    default:
      panic("fileread");
    800239ac:	00008517          	auipc	a0,0x8
    800239b0:	05c50513          	addi	a0,a0,92 # 8002ba08 <digits+0x780>
    800239b4:	ffffc097          	auipc	ra,0xffffc
    800239b8:	78e080e7          	jalr	1934(ra) # 80020142 <panic>
        r = piperead(f->pipe, addr, n);
    800239bc:	6908                	ld	a0,16(a0)
    800239be:	00000097          	auipc	ra,0x0
    800239c2:	466080e7          	jalr	1126(ra) # 80023e24 <piperead>
    800239c6:	892a                	mv	s2,a0
  }

  return r;
}
    800239c8:	854a                	mv	a0,s2
    800239ca:	70a2                	ld	ra,40(sp)
    800239cc:	7402                	ld	s0,32(sp)
    800239ce:	64e2                	ld	s1,24(sp)
    800239d0:	6942                	ld	s2,16(sp)
    800239d2:	69a2                	ld	s3,8(sp)
    800239d4:	6145                	addi	sp,sp,48
    800239d6:	8082                	ret
        if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800239d8:	02451783          	lh	a5,36(a0)
    800239dc:	03079693          	slli	a3,a5,0x30
    800239e0:	92c1                	srli	a3,a3,0x30
    800239e2:	4725                	li	a4,9
    800239e4:	04d76a63          	bltu	a4,a3,80023a38 <fileread+0xba>
    800239e8:	0792                	slli	a5,a5,0x4
    800239ea:	0001d717          	auipc	a4,0x1d
    800239ee:	9c670713          	addi	a4,a4,-1594 # 800403b0 <devsw>
    800239f2:	97ba                	add	a5,a5,a4
    800239f4:	639c                	ld	a5,0(a5)
    800239f6:	c3b9                	beqz	a5,80023a3c <fileread+0xbe>
        r = devsw[f->major].read(1, addr, n);
    800239f8:	4505                	li	a0,1
    800239fa:	9782                	jalr	a5
    800239fc:	892a                	mv	s2,a0
        break;
    800239fe:	b7e9                	j	800239c8 <fileread+0x4a>
        elock(f->ep);
    80023a00:	6d08                	ld	a0,24(a0)
    80023a02:	00002097          	auipc	ra,0x2
    80023a06:	7e2080e7          	jalr	2018(ra) # 800261e4 <elock>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
    80023a0a:	874a                	mv	a4,s2
    80023a0c:	5094                	lw	a3,32(s1)
    80023a0e:	864e                	mv	a2,s3
    80023a10:	4585                	li	a1,1
    80023a12:	6c88                	ld	a0,24(s1)
    80023a14:	00002097          	auipc	ra,0x2
    80023a18:	edc080e7          	jalr	-292(ra) # 800258f0 <eread>
    80023a1c:	892a                	mv	s2,a0
    80023a1e:	00a05563          	blez	a0,80023a28 <fileread+0xaa>
            f->off += r;
    80023a22:	509c                	lw	a5,32(s1)
    80023a24:	9fa9                	addw	a5,a5,a0
    80023a26:	d09c                	sw	a5,32(s1)
        eunlock(f->ep);
    80023a28:	6c88                	ld	a0,24(s1)
    80023a2a:	00002097          	auipc	ra,0x2
    80023a2e:	7f0080e7          	jalr	2032(ra) # 8002621a <eunlock>
        break;
    80023a32:	bf59                	j	800239c8 <fileread+0x4a>
    return -1;
    80023a34:	597d                	li	s2,-1
    80023a36:	bf49                	j	800239c8 <fileread+0x4a>
          return -1;
    80023a38:	597d                	li	s2,-1
    80023a3a:	b779                	j	800239c8 <fileread+0x4a>
    80023a3c:	597d                	li	s2,-1
    80023a3e:	b769                	j	800239c8 <fileread+0x4a>

0000000080023a40 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80023a40:	7179                	addi	sp,sp,-48
    80023a42:	f406                	sd	ra,40(sp)
    80023a44:	f022                	sd	s0,32(sp)
    80023a46:	ec26                	sd	s1,24(sp)
    80023a48:	e84a                	sd	s2,16(sp)
    80023a4a:	e44e                	sd	s3,8(sp)
    80023a4c:	e052                	sd	s4,0(sp)
    80023a4e:	1800                	addi	s0,sp,48
  int ret = 0;

  if(f->writable == 0)
    80023a50:	00954783          	lbu	a5,9(a0)
    80023a54:	cbcd                	beqz	a5,80023b06 <filewrite+0xc6>
    80023a56:	84aa                	mv	s1,a0
    80023a58:	892e                	mv	s2,a1
    80023a5a:	89b2                	mv	s3,a2
    return -1;

  if(f->type == FD_PIPE){
    80023a5c:	411c                	lw	a5,0(a0)
    80023a5e:	4705                	li	a4,1
    80023a60:	04e78963          	beq	a5,a4,80023ab2 <filewrite+0x72>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80023a64:	470d                	li	a4,3
    80023a66:	04e78d63          	beq	a5,a4,80023ac0 <filewrite+0x80>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_ENTRY){
    80023a6a:	4709                	li	a4,2
    80023a6c:	08e79563          	bne	a5,a4,80023af6 <filewrite+0xb6>
    elock(f->ep);
    80023a70:	6d08                	ld	a0,24(a0)
    80023a72:	00002097          	auipc	ra,0x2
    80023a76:	772080e7          	jalr	1906(ra) # 800261e4 <elock>
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    80023a7a:	00098a1b          	sext.w	s4,s3
    80023a7e:	8752                	mv	a4,s4
    80023a80:	5094                	lw	a3,32(s1)
    80023a82:	864a                	mv	a2,s2
    80023a84:	4585                	li	a1,1
    80023a86:	6c88                	ld	a0,24(s1)
    80023a88:	00002097          	auipc	ra,0x2
    80023a8c:	f60080e7          	jalr	-160(ra) # 800259e8 <ewrite>
      ret = n;
      f->off += n;
    } else {
      ret = -1;
    80023a90:	597d                	li	s2,-1
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    80023a92:	05350b63          	beq	a0,s3,80023ae8 <filewrite+0xa8>
    }
    eunlock(f->ep);
    80023a96:	6c88                	ld	a0,24(s1)
    80023a98:	00002097          	auipc	ra,0x2
    80023a9c:	782080e7          	jalr	1922(ra) # 8002621a <eunlock>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80023aa0:	854a                	mv	a0,s2
    80023aa2:	70a2                	ld	ra,40(sp)
    80023aa4:	7402                	ld	s0,32(sp)
    80023aa6:	64e2                	ld	s1,24(sp)
    80023aa8:	6942                	ld	s2,16(sp)
    80023aaa:	69a2                	ld	s3,8(sp)
    80023aac:	6a02                	ld	s4,0(sp)
    80023aae:	6145                	addi	sp,sp,48
    80023ab0:	8082                	ret
    ret = pipewrite(f->pipe, addr, n);
    80023ab2:	6908                	ld	a0,16(a0)
    80023ab4:	00000097          	auipc	ra,0x0
    80023ab8:	26e080e7          	jalr	622(ra) # 80023d22 <pipewrite>
    80023abc:	892a                	mv	s2,a0
    80023abe:	b7cd                	j	80023aa0 <filewrite+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80023ac0:	02451783          	lh	a5,36(a0)
    80023ac4:	03079693          	slli	a3,a5,0x30
    80023ac8:	92c1                	srli	a3,a3,0x30
    80023aca:	4725                	li	a4,9
    80023acc:	02d76f63          	bltu	a4,a3,80023b0a <filewrite+0xca>
    80023ad0:	0792                	slli	a5,a5,0x4
    80023ad2:	0001d717          	auipc	a4,0x1d
    80023ad6:	8de70713          	addi	a4,a4,-1826 # 800403b0 <devsw>
    80023ada:	97ba                	add	a5,a5,a4
    80023adc:	679c                	ld	a5,8(a5)
    80023ade:	cb85                	beqz	a5,80023b0e <filewrite+0xce>
    ret = devsw[f->major].write(1, addr, n);
    80023ae0:	4505                	li	a0,1
    80023ae2:	9782                	jalr	a5
    80023ae4:	892a                	mv	s2,a0
    80023ae6:	bf6d                	j	80023aa0 <filewrite+0x60>
      f->off += n;
    80023ae8:	509c                	lw	a5,32(s1)
    80023aea:	01478a3b          	addw	s4,a5,s4
    80023aee:	0344a023          	sw	s4,32(s1)
      ret = n;
    80023af2:	894e                	mv	s2,s3
    80023af4:	b74d                	j	80023a96 <filewrite+0x56>
    panic("filewrite");
    80023af6:	00008517          	auipc	a0,0x8
    80023afa:	f2250513          	addi	a0,a0,-222 # 8002ba18 <digits+0x790>
    80023afe:	ffffc097          	auipc	ra,0xffffc
    80023b02:	644080e7          	jalr	1604(ra) # 80020142 <panic>
    return -1;
    80023b06:	597d                	li	s2,-1
    80023b08:	bf61                	j	80023aa0 <filewrite+0x60>
      return -1;
    80023b0a:	597d                	li	s2,-1
    80023b0c:	bf51                	j	80023aa0 <filewrite+0x60>
    80023b0e:	597d                	li	s2,-1
    80023b10:	bf41                	j	80023aa0 <filewrite+0x60>

0000000080023b12 <dirnext>:
int
dirnext(struct file *f, uint64 addr)
{
  // struct proc *p = myproc();

  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    80023b12:	00854783          	lbu	a5,8(a0)
    80023b16:	cfdd                	beqz	a5,80023bd4 <dirnext+0xc2>
{
    80023b18:	7141                	addi	sp,sp,-496
    80023b1a:	f786                	sd	ra,488(sp)
    80023b1c:	f3a2                	sd	s0,480(sp)
    80023b1e:	efa6                	sd	s1,472(sp)
    80023b20:	ebca                	sd	s2,464(sp)
    80023b22:	e7ce                	sd	s3,456(sp)
    80023b24:	e3d2                	sd	s4,448(sp)
    80023b26:	ff56                	sd	s5,440(sp)
    80023b28:	1b80                	addi	s0,sp,496
    80023b2a:	84aa                	mv	s1,a0
    80023b2c:	8aae                	mv	s5,a1
  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    80023b2e:	6d18                	ld	a4,24(a0)
    80023b30:	10074783          	lbu	a5,256(a4)
    80023b34:	8bc1                	andi	a5,a5,16
    return -1;
    80023b36:	557d                	li	a0,-1
  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    80023b38:	eb91                	bnez	a5,80023b4c <dirnext+0x3a>
  // if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
  if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    return -1;

  return 1;
    80023b3a:	70be                	ld	ra,488(sp)
    80023b3c:	741e                	ld	s0,480(sp)
    80023b3e:	64fe                	ld	s1,472(sp)
    80023b40:	695e                	ld	s2,464(sp)
    80023b42:	69be                	ld	s3,456(sp)
    80023b44:	6a1e                	ld	s4,448(sp)
    80023b46:	7afa                	ld	s5,440(sp)
    80023b48:	617d                	addi	sp,sp,496
    80023b4a:	8082                	ret
  int count = 0;
    80023b4c:	e0042e23          	sw	zero,-484(s0)
  elock(f->ep);
    80023b50:	853a                	mv	a0,a4
    80023b52:	00002097          	auipc	ra,0x2
    80023b56:	692080e7          	jalr	1682(ra) # 800261e4 <elock>
  while ((ret = enext(f->ep, &de, f->off, &count)) == 0) {  // skip empty entry
    80023b5a:	e1c40a13          	addi	s4,s0,-484
    80023b5e:	e5840993          	addi	s3,s0,-424
    80023b62:	a801                	j	80023b72 <dirnext+0x60>
    f->off += count * 32;
    80023b64:	e1c42783          	lw	a5,-484(s0)
    80023b68:	0057971b          	slliw	a4,a5,0x5
    80023b6c:	509c                	lw	a5,32(s1)
    80023b6e:	9fb9                	addw	a5,a5,a4
    80023b70:	d09c                	sw	a5,32(s1)
  while ((ret = enext(f->ep, &de, f->off, &count)) == 0) {  // skip empty entry
    80023b72:	86d2                	mv	a3,s4
    80023b74:	5090                	lw	a2,32(s1)
    80023b76:	85ce                	mv	a1,s3
    80023b78:	6c88                	ld	a0,24(s1)
    80023b7a:	00003097          	auipc	ra,0x3
    80023b7e:	86e080e7          	jalr	-1938(ra) # 800263e8 <enext>
    80023b82:	892a                	mv	s2,a0
    80023b84:	d165                	beqz	a0,80023b64 <dirnext+0x52>
  eunlock(f->ep);
    80023b86:	6c88                	ld	a0,24(s1)
    80023b88:	00002097          	auipc	ra,0x2
    80023b8c:	692080e7          	jalr	1682(ra) # 8002621a <eunlock>
  if (ret == -1)
    80023b90:	57fd                	li	a5,-1
    return 0;
    80023b92:	4501                	li	a0,0
  if (ret == -1)
    80023b94:	faf903e3          	beq	s2,a5,80023b3a <dirnext+0x28>
  f->off += count * 32;
    80023b98:	e1c42783          	lw	a5,-484(s0)
    80023b9c:	0057971b          	slliw	a4,a5,0x5
    80023ba0:	509c                	lw	a5,32(s1)
    80023ba2:	9fb9                	addw	a5,a5,a4
    80023ba4:	d09c                	sw	a5,32(s1)
  estat(&de, &st);
    80023ba6:	e2040493          	addi	s1,s0,-480
    80023baa:	85a6                	mv	a1,s1
    80023bac:	e5840513          	addi	a0,s0,-424
    80023bb0:	00002097          	auipc	ra,0x2
    80023bb4:	7f0080e7          	jalr	2032(ra) # 800263a0 <estat>
  if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    80023bb8:	03800613          	li	a2,56
    80023bbc:	85a6                	mv	a1,s1
    80023bbe:	8556                	mv	a0,s5
    80023bc0:	ffffe097          	auipc	ra,0xffffe
    80023bc4:	844080e7          	jalr	-1980(ra) # 80021404 <copyout2>
    return -1;
    80023bc8:	fff54513          	not	a0,a0
    80023bcc:	957d                	srai	a0,a0,0x3f
    80023bce:	8909                	andi	a0,a0,2
    80023bd0:	157d                	addi	a0,a0,-1
    80023bd2:	b7a5                	j	80023b3a <dirnext+0x28>
    return -1;
    80023bd4:	557d                	li	a0,-1
    80023bd6:	8082                	ret

0000000080023bd8 <pipealloc>:
#include "include/kalloc.h"
#include "include/vm.h"

int
pipealloc(struct file **f0, struct file **f1)
{
    80023bd8:	7179                	addi	sp,sp,-48
    80023bda:	f406                	sd	ra,40(sp)
    80023bdc:	f022                	sd	s0,32(sp)
    80023bde:	ec26                	sd	s1,24(sp)
    80023be0:	e84a                	sd	s2,16(sp)
    80023be2:	e44e                	sd	s3,8(sp)
    80023be4:	e052                	sd	s4,0(sp)
    80023be6:	1800                	addi	s0,sp,48
    80023be8:	84aa                	mv	s1,a0
    80023bea:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80023bec:	0005b023          	sd	zero,0(a1)
    80023bf0:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == NULL || (*f1 = filealloc()) == NULL)
    80023bf4:	00000097          	auipc	ra,0x0
    80023bf8:	bb4080e7          	jalr	-1100(ra) # 800237a8 <filealloc>
    80023bfc:	e088                	sd	a0,0(s1)
    80023bfe:	c551                	beqz	a0,80023c8a <pipealloc+0xb2>
    80023c00:	00000097          	auipc	ra,0x0
    80023c04:	ba8080e7          	jalr	-1112(ra) # 800237a8 <filealloc>
    80023c08:	00aa3023          	sd	a0,0(s4)
    80023c0c:	c92d                	beqz	a0,80023c7e <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == NULL)
    80023c0e:	ffffd097          	auipc	ra,0xffffd
    80023c12:	938080e7          	jalr	-1736(ra) # 80020546 <kalloc>
    80023c16:	892a                	mv	s2,a0
    80023c18:	c125                	beqz	a0,80023c78 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80023c1a:	4985                	li	s3,1
    80023c1c:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80023c20:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80023c24:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80023c28:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80023c2c:	00008597          	auipc	a1,0x8
    80023c30:	cac58593          	addi	a1,a1,-852 # 8002b8d8 <digits+0x650>
    80023c34:	ffffd097          	auipc	ra,0xffffd
    80023c38:	a3a080e7          	jalr	-1478(ra) # 8002066e <initlock>
  (*f0)->type = FD_PIPE;
    80023c3c:	609c                	ld	a5,0(s1)
    80023c3e:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80023c42:	609c                	ld	a5,0(s1)
    80023c44:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80023c48:	609c                	ld	a5,0(s1)
    80023c4a:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80023c4e:	609c                	ld	a5,0(s1)
    80023c50:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80023c54:	000a3783          	ld	a5,0(s4)
    80023c58:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80023c5c:	000a3783          	ld	a5,0(s4)
    80023c60:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80023c64:	000a3783          	ld	a5,0(s4)
    80023c68:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80023c6c:	000a3783          	ld	a5,0(s4)
    80023c70:	0127b823          	sd	s2,16(a5)
  return 0;
    80023c74:	4501                	li	a0,0
    80023c76:	a025                	j	80023c9e <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80023c78:	6088                	ld	a0,0(s1)
    80023c7a:	e501                	bnez	a0,80023c82 <pipealloc+0xaa>
    80023c7c:	a039                	j	80023c8a <pipealloc+0xb2>
    80023c7e:	6088                	ld	a0,0(s1)
    80023c80:	c51d                	beqz	a0,80023cae <pipealloc+0xd6>
    fileclose(*f0);
    80023c82:	00000097          	auipc	ra,0x0
    80023c86:	be2080e7          	jalr	-1054(ra) # 80023864 <fileclose>
  if(*f1)
    80023c8a:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80023c8e:	557d                	li	a0,-1
  if(*f1)
    80023c90:	c799                	beqz	a5,80023c9e <pipealloc+0xc6>
    fileclose(*f1);
    80023c92:	853e                	mv	a0,a5
    80023c94:	00000097          	auipc	ra,0x0
    80023c98:	bd0080e7          	jalr	-1072(ra) # 80023864 <fileclose>
  return -1;
    80023c9c:	557d                	li	a0,-1
}
    80023c9e:	70a2                	ld	ra,40(sp)
    80023ca0:	7402                	ld	s0,32(sp)
    80023ca2:	64e2                	ld	s1,24(sp)
    80023ca4:	6942                	ld	s2,16(sp)
    80023ca6:	69a2                	ld	s3,8(sp)
    80023ca8:	6a02                	ld	s4,0(sp)
    80023caa:	6145                	addi	sp,sp,48
    80023cac:	8082                	ret
  return -1;
    80023cae:	557d                	li	a0,-1
    80023cb0:	b7fd                	j	80023c9e <pipealloc+0xc6>

0000000080023cb2 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80023cb2:	1101                	addi	sp,sp,-32
    80023cb4:	ec06                	sd	ra,24(sp)
    80023cb6:	e822                	sd	s0,16(sp)
    80023cb8:	e426                	sd	s1,8(sp)
    80023cba:	e04a                	sd	s2,0(sp)
    80023cbc:	1000                	addi	s0,sp,32
    80023cbe:	84aa                	mv	s1,a0
    80023cc0:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80023cc2:	ffffd097          	auipc	ra,0xffffd
    80023cc6:	9f0080e7          	jalr	-1552(ra) # 800206b2 <acquire>
  if(writable){
    80023cca:	02090d63          	beqz	s2,80023d04 <pipeclose+0x52>
    pi->writeopen = 0;
    80023cce:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80023cd2:	21848513          	addi	a0,s1,536
    80023cd6:	ffffe097          	auipc	ra,0xffffe
    80023cda:	7f6080e7          	jalr	2038(ra) # 800224cc <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80023cde:	2204b783          	ld	a5,544(s1)
    80023ce2:	eb95                	bnez	a5,80023d16 <pipeclose+0x64>
    release(&pi->lock);
    80023ce4:	8526                	mv	a0,s1
    80023ce6:	ffffd097          	auipc	ra,0xffffd
    80023cea:	a20080e7          	jalr	-1504(ra) # 80020706 <release>
    kfree((char*)pi);
    80023cee:	8526                	mv	a0,s1
    80023cf0:	ffffc097          	auipc	ra,0xffffc
    80023cf4:	73e080e7          	jalr	1854(ra) # 8002042e <kfree>
  } else
    release(&pi->lock);
}
    80023cf8:	60e2                	ld	ra,24(sp)
    80023cfa:	6442                	ld	s0,16(sp)
    80023cfc:	64a2                	ld	s1,8(sp)
    80023cfe:	6902                	ld	s2,0(sp)
    80023d00:	6105                	addi	sp,sp,32
    80023d02:	8082                	ret
    pi->readopen = 0;
    80023d04:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80023d08:	21c48513          	addi	a0,s1,540
    80023d0c:	ffffe097          	auipc	ra,0xffffe
    80023d10:	7c0080e7          	jalr	1984(ra) # 800224cc <wakeup>
    80023d14:	b7e9                	j	80023cde <pipeclose+0x2c>
    release(&pi->lock);
    80023d16:	8526                	mv	a0,s1
    80023d18:	ffffd097          	auipc	ra,0xffffd
    80023d1c:	9ee080e7          	jalr	-1554(ra) # 80020706 <release>
}
    80023d20:	bfe1                	j	80023cf8 <pipeclose+0x46>

0000000080023d22 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80023d22:	7159                	addi	sp,sp,-112
    80023d24:	f486                	sd	ra,104(sp)
    80023d26:	f0a2                	sd	s0,96(sp)
    80023d28:	eca6                	sd	s1,88(sp)
    80023d2a:	e8ca                	sd	s2,80(sp)
    80023d2c:	e4ce                	sd	s3,72(sp)
    80023d2e:	e0d2                	sd	s4,64(sp)
    80023d30:	fc56                	sd	s5,56(sp)
    80023d32:	f85a                	sd	s6,48(sp)
    80023d34:	f45e                	sd	s7,40(sp)
    80023d36:	f062                	sd	s8,32(sp)
    80023d38:	ec66                	sd	s9,24(sp)
    80023d3a:	1880                	addi	s0,sp,112
    80023d3c:	84aa                	mv	s1,a0
    80023d3e:	8b2e                	mv	s6,a1
    80023d40:	8ab2                	mv	s5,a2
  int i;
  char ch;
  struct proc *pr = myproc();
    80023d42:	ffffe097          	auipc	ra,0xffffe
    80023d46:	d90080e7          	jalr	-624(ra) # 80021ad2 <myproc>
    80023d4a:	892a                	mv	s2,a0

  acquire(&pi->lock);
    80023d4c:	8526                	mv	a0,s1
    80023d4e:	ffffd097          	auipc	ra,0xffffd
    80023d52:	964080e7          	jalr	-1692(ra) # 800206b2 <acquire>
  for(i = 0; i < n; i++){
    80023d56:	09505663          	blez	s5,80023de2 <pipewrite+0xc0>
    80023d5a:	4b81                	li	s7,0
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || pr->killed){
        release(&pi->lock);
        return -1;
      }
      wakeup(&pi->nread);
    80023d5c:	21848a13          	addi	s4,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80023d60:	21c48993          	addi	s3,s1,540
    }
    // if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    if(copyin2(&ch, addr + i, 1) == -1)
    80023d64:	f9f40c93          	addi	s9,s0,-97
    80023d68:	5c7d                	li	s8,-1
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023d6a:	2184a783          	lw	a5,536(s1)
    80023d6e:	21c4a703          	lw	a4,540(s1)
    80023d72:	2007879b          	addiw	a5,a5,512
    80023d76:	02f71b63          	bne	a4,a5,80023dac <pipewrite+0x8a>
      if(pi->readopen == 0 || pr->killed){
    80023d7a:	2204a783          	lw	a5,544(s1)
    80023d7e:	cfbd                	beqz	a5,80023dfc <pipewrite+0xda>
    80023d80:	03092783          	lw	a5,48(s2)
    80023d84:	efa5                	bnez	a5,80023dfc <pipewrite+0xda>
      wakeup(&pi->nread);
    80023d86:	8552                	mv	a0,s4
    80023d88:	ffffe097          	auipc	ra,0xffffe
    80023d8c:	744080e7          	jalr	1860(ra) # 800224cc <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80023d90:	85a6                	mv	a1,s1
    80023d92:	854e                	mv	a0,s3
    80023d94:	ffffe097          	auipc	ra,0xffffe
    80023d98:	5bc080e7          	jalr	1468(ra) # 80022350 <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023d9c:	2184a783          	lw	a5,536(s1)
    80023da0:	21c4a703          	lw	a4,540(s1)
    80023da4:	2007879b          	addiw	a5,a5,512
    80023da8:	fcf709e3          	beq	a4,a5,80023d7a <pipewrite+0x58>
    if(copyin2(&ch, addr + i, 1) == -1)
    80023dac:	4605                	li	a2,1
    80023dae:	85da                	mv	a1,s6
    80023db0:	8566                	mv	a0,s9
    80023db2:	ffffd097          	auipc	ra,0xffffd
    80023db6:	732080e7          	jalr	1842(ra) # 800214e4 <copyin2>
    80023dba:	03850563          	beq	a0,s8,80023de4 <pipewrite+0xc2>
      break;
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80023dbe:	21c4a783          	lw	a5,540(s1)
    80023dc2:	0017871b          	addiw	a4,a5,1
    80023dc6:	20e4ae23          	sw	a4,540(s1)
    80023dca:	1ff7f793          	andi	a5,a5,511
    80023dce:	97a6                	add	a5,a5,s1
    80023dd0:	f9f44703          	lbu	a4,-97(s0)
    80023dd4:	00e78c23          	sb	a4,24(a5)
  for(i = 0; i < n; i++){
    80023dd8:	2b85                	addiw	s7,s7,1
    80023dda:	0b05                	addi	s6,s6,1
    80023ddc:	f97a97e3          	bne	s5,s7,80023d6a <pipewrite+0x48>
    80023de0:	a011                	j	80023de4 <pipewrite+0xc2>
    80023de2:	4b81                	li	s7,0
  }
  wakeup(&pi->nread);
    80023de4:	21848513          	addi	a0,s1,536
    80023de8:	ffffe097          	auipc	ra,0xffffe
    80023dec:	6e4080e7          	jalr	1764(ra) # 800224cc <wakeup>
  release(&pi->lock);
    80023df0:	8526                	mv	a0,s1
    80023df2:	ffffd097          	auipc	ra,0xffffd
    80023df6:	914080e7          	jalr	-1772(ra) # 80020706 <release>
  return i;
    80023dfa:	a039                	j	80023e08 <pipewrite+0xe6>
        release(&pi->lock);
    80023dfc:	8526                	mv	a0,s1
    80023dfe:	ffffd097          	auipc	ra,0xffffd
    80023e02:	908080e7          	jalr	-1784(ra) # 80020706 <release>
        return -1;
    80023e06:	5bfd                	li	s7,-1
}
    80023e08:	855e                	mv	a0,s7
    80023e0a:	70a6                	ld	ra,104(sp)
    80023e0c:	7406                	ld	s0,96(sp)
    80023e0e:	64e6                	ld	s1,88(sp)
    80023e10:	6946                	ld	s2,80(sp)
    80023e12:	69a6                	ld	s3,72(sp)
    80023e14:	6a06                	ld	s4,64(sp)
    80023e16:	7ae2                	ld	s5,56(sp)
    80023e18:	7b42                	ld	s6,48(sp)
    80023e1a:	7ba2                	ld	s7,40(sp)
    80023e1c:	7c02                	ld	s8,32(sp)
    80023e1e:	6ce2                	ld	s9,24(sp)
    80023e20:	6165                	addi	sp,sp,112
    80023e22:	8082                	ret

0000000080023e24 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80023e24:	715d                	addi	sp,sp,-80
    80023e26:	e486                	sd	ra,72(sp)
    80023e28:	e0a2                	sd	s0,64(sp)
    80023e2a:	fc26                	sd	s1,56(sp)
    80023e2c:	f84a                	sd	s2,48(sp)
    80023e2e:	f44e                	sd	s3,40(sp)
    80023e30:	f052                	sd	s4,32(sp)
    80023e32:	ec56                	sd	s5,24(sp)
    80023e34:	e85a                	sd	s6,16(sp)
    80023e36:	0880                	addi	s0,sp,80
    80023e38:	84aa                	mv	s1,a0
    80023e3a:	892e                	mv	s2,a1
    80023e3c:	8a32                	mv	s4,a2
  int i;
  struct proc *pr = myproc();
    80023e3e:	ffffe097          	auipc	ra,0xffffe
    80023e42:	c94080e7          	jalr	-876(ra) # 80021ad2 <myproc>
    80023e46:	89aa                	mv	s3,a0
  char ch;

  acquire(&pi->lock);
    80023e48:	8526                	mv	a0,s1
    80023e4a:	ffffd097          	auipc	ra,0xffffd
    80023e4e:	868080e7          	jalr	-1944(ra) # 800206b2 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80023e52:	2184a703          	lw	a4,536(s1)
    80023e56:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80023e5a:	21848a93          	addi	s5,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80023e5e:	02f71463          	bne	a4,a5,80023e86 <piperead+0x62>
    80023e62:	2244a783          	lw	a5,548(s1)
    80023e66:	c385                	beqz	a5,80023e86 <piperead+0x62>
    if(pr->killed){
    80023e68:	0309a783          	lw	a5,48(s3)
    80023e6c:	e7d9                	bnez	a5,80023efa <piperead+0xd6>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80023e6e:	85a6                	mv	a1,s1
    80023e70:	8556                	mv	a0,s5
    80023e72:	ffffe097          	auipc	ra,0xffffe
    80023e76:	4de080e7          	jalr	1246(ra) # 80022350 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80023e7a:	2184a703          	lw	a4,536(s1)
    80023e7e:	21c4a783          	lw	a5,540(s1)
    80023e82:	fef700e3          	beq	a4,a5,80023e62 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80023e86:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    // if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    if(copyout2(addr + i, &ch, 1) == -1)
    80023e88:	fbf40b13          	addi	s6,s0,-65
    80023e8c:	5afd                	li	s5,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80023e8e:	05405063          	blez	s4,80023ece <piperead+0xaa>
    if(pi->nread == pi->nwrite)
    80023e92:	2184a783          	lw	a5,536(s1)
    80023e96:	21c4a703          	lw	a4,540(s1)
    80023e9a:	02f70a63          	beq	a4,a5,80023ece <piperead+0xaa>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80023e9e:	0017871b          	addiw	a4,a5,1
    80023ea2:	20e4ac23          	sw	a4,536(s1)
    80023ea6:	1ff7f793          	andi	a5,a5,511
    80023eaa:	97a6                	add	a5,a5,s1
    80023eac:	0187c783          	lbu	a5,24(a5)
    80023eb0:	faf40fa3          	sb	a5,-65(s0)
    if(copyout2(addr + i, &ch, 1) == -1)
    80023eb4:	4605                	li	a2,1
    80023eb6:	85da                	mv	a1,s6
    80023eb8:	854a                	mv	a0,s2
    80023eba:	ffffd097          	auipc	ra,0xffffd
    80023ebe:	54a080e7          	jalr	1354(ra) # 80021404 <copyout2>
    80023ec2:	01550663          	beq	a0,s5,80023ece <piperead+0xaa>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80023ec6:	2985                	addiw	s3,s3,1
    80023ec8:	0905                	addi	s2,s2,1
    80023eca:	fd3a14e3          	bne	s4,s3,80023e92 <piperead+0x6e>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80023ece:	21c48513          	addi	a0,s1,540
    80023ed2:	ffffe097          	auipc	ra,0xffffe
    80023ed6:	5fa080e7          	jalr	1530(ra) # 800224cc <wakeup>
  release(&pi->lock);
    80023eda:	8526                	mv	a0,s1
    80023edc:	ffffd097          	auipc	ra,0xffffd
    80023ee0:	82a080e7          	jalr	-2006(ra) # 80020706 <release>
  return i;
}
    80023ee4:	854e                	mv	a0,s3
    80023ee6:	60a6                	ld	ra,72(sp)
    80023ee8:	6406                	ld	s0,64(sp)
    80023eea:	74e2                	ld	s1,56(sp)
    80023eec:	7942                	ld	s2,48(sp)
    80023eee:	79a2                	ld	s3,40(sp)
    80023ef0:	7a02                	ld	s4,32(sp)
    80023ef2:	6ae2                	ld	s5,24(sp)
    80023ef4:	6b42                	ld	s6,16(sp)
    80023ef6:	6161                	addi	sp,sp,80
    80023ef8:	8082                	ret
      release(&pi->lock);
    80023efa:	8526                	mv	a0,s1
    80023efc:	ffffd097          	auipc	ra,0xffffd
    80023f00:	80a080e7          	jalr	-2038(ra) # 80020706 <release>
      return -1;
    80023f04:	59fd                	li	s3,-1
    80023f06:	bff9                	j	80023ee4 <piperead+0xc0>

0000000080023f08 <exec>:
  return 0;
}


int exec(char *path, char **argv)
{
    80023f08:	dd010113          	addi	sp,sp,-560
    80023f0c:	22113423          	sd	ra,552(sp)
    80023f10:	22813023          	sd	s0,544(sp)
    80023f14:	20913c23          	sd	s1,536(sp)
    80023f18:	21213823          	sd	s2,528(sp)
    80023f1c:	21313423          	sd	s3,520(sp)
    80023f20:	21413023          	sd	s4,512(sp)
    80023f24:	ffd6                	sd	s5,504(sp)
    80023f26:	fbda                	sd	s6,496(sp)
    80023f28:	f7de                	sd	s7,488(sp)
    80023f2a:	f3e2                	sd	s8,480(sp)
    80023f2c:	efe6                	sd	s9,472(sp)
    80023f2e:	ebea                	sd	s10,464(sp)
    80023f30:	e7ee                	sd	s11,456(sp)
    80023f32:	1c00                	addi	s0,sp,560
    80023f34:	892a                	mv	s2,a0
    80023f36:	dca43c23          	sd	a0,-552(s0)
    80023f3a:	deb43423          	sd	a1,-536(s0)
  struct elfhdr elf;
  struct dirent *ep;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  pagetable_t kpagetable = 0, oldkpagetable;
  struct proc *p = myproc();
    80023f3e:	ffffe097          	auipc	ra,0xffffe
    80023f42:	b94080e7          	jalr	-1132(ra) # 80021ad2 <myproc>
    80023f46:	84aa                	mv	s1,a0

  // Make a copy of p->kpt without old user space, 
  // but with the same kstack we are using now, which can't be changed
  if ((kpagetable = (pagetable_t)kalloc()) == NULL) {
    80023f48:	ffffc097          	auipc	ra,0xffffc
    80023f4c:	5fe080e7          	jalr	1534(ra) # 80020546 <kalloc>
    80023f50:	2a050863          	beqz	a0,80024200 <exec+0x2f8>
    80023f54:	8b2a                	mv	s6,a0
    return -1;
  }
  memmove(kpagetable, p->kpagetable, PGSIZE);
    80023f56:	6605                	lui	a2,0x1
    80023f58:	6cac                	ld	a1,88(s1)
    80023f5a:	ffffd097          	auipc	ra,0xffffd
    80023f5e:	850080e7          	jalr	-1968(ra) # 800207aa <memmove>
  for (int i = 0; i < PX(2, MAXUVA); i++) {
    kpagetable[i] = 0;
    80023f62:	000b3023          	sd	zero,0(s6)
    80023f66:	000b3423          	sd	zero,8(s6)
  }

  if((ep = ename(path)) == NULL) {
    80023f6a:	854a                	mv	a0,s2
    80023f6c:	00003097          	auipc	ra,0x3
    80023f70:	a1c080e7          	jalr	-1508(ra) # 80026988 <ename>
    80023f74:	8a2a                	mv	s4,a0
    80023f76:	3a050e63          	beqz	a0,80024332 <exec+0x42a>
    #ifdef DEBUG
    printf("[exec] %s not found\n", path);
    #endif
    goto bad;
  }
  elock(ep);
    80023f7a:	00002097          	auipc	ra,0x2
    80023f7e:	26a080e7          	jalr	618(ra) # 800261e4 <elock>

  // Check ELF header
  if(eread(ep, 0, (uint64) &elf, 0, sizeof(elf)) != sizeof(elf))
    80023f82:	04000713          	li	a4,64
    80023f86:	4681                	li	a3,0
    80023f88:	e4840613          	addi	a2,s0,-440
    80023f8c:	4581                	li	a1,0
    80023f8e:	8552                	mv	a0,s4
    80023f90:	00002097          	auipc	ra,0x2
    80023f94:	960080e7          	jalr	-1696(ra) # 800258f0 <eread>
    80023f98:	04000793          	li	a5,64
    80023f9c:	00f51a63          	bne	a0,a5,80023fb0 <exec+0xa8>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80023fa0:	e4842703          	lw	a4,-440(s0)
    80023fa4:	464c47b7          	lui	a5,0x464c4
    80023fa8:	57f78793          	addi	a5,a5,1407 # 464c457f <_start-0x39b5ba81>
    80023fac:	00f70963          	beq	a4,a5,80023fbe <exec+0xb6>
  printf("[exec] reach bad\n");
  #endif
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(kpagetable)
    kvmfree(kpagetable, 0);
    80023fb0:	4581                	li	a1,0
    80023fb2:	855a                	mv	a0,s6
    80023fb4:	ffffd097          	auipc	ra,0xffffd
    80023fb8:	754080e7          	jalr	1876(ra) # 80021708 <kvmfree>
  if(ep){
    80023fbc:	a4bd                	j	8002422a <exec+0x322>
  if((pagetable = proc_pagetable(p)) == NULL)
    80023fbe:	8526                	mv	a0,s1
    80023fc0:	ffffe097          	auipc	ra,0xffffe
    80023fc4:	bf6080e7          	jalr	-1034(ra) # 80021bb6 <proc_pagetable>
    80023fc8:	e0a43423          	sd	a0,-504(s0)
    80023fcc:	d175                	beqz	a0,80023fb0 <exec+0xa8>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80023fce:	e6842783          	lw	a5,-408(s0)
    80023fd2:	e8045703          	lhu	a4,-384(s0)
    80023fd6:	cb3d                	beqz	a4,8002404c <exec+0x144>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    80023fd8:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80023fda:	e0043023          	sd	zero,-512(s0)
    if(eread(ep, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80023fde:	e1040713          	addi	a4,s0,-496
    80023fe2:	dee43023          	sd	a4,-544(s0)
    if(ph.vaddr % PGSIZE != 0)
    80023fe6:	6a85                	lui	s5,0x1
    80023fe8:	fffa8713          	addi	a4,s5,-1 # fff <_start-0x8001f001>
    80023fec:	dce43823          	sd	a4,-560(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80023ff0:	6d85                	lui	s11,0x1
    80023ff2:	7d7d                	lui	s10,0xfffff
    80023ff4:	a4c9                	j	800242b6 <exec+0x3ae>
      panic("loadseg: address should exist");
    80023ff6:	00008517          	auipc	a0,0x8
    80023ffa:	a3250513          	addi	a0,a0,-1486 # 8002ba28 <digits+0x7a0>
    80023ffe:	ffffc097          	auipc	ra,0xffffc
    80024002:	144080e7          	jalr	324(ra) # 80020142 <panic>
    if(eread(ep, 0, (uint64)pa, offset+i, n) != n)
    80024006:	874a                	mv	a4,s2
    80024008:	009c86bb          	addw	a3,s9,s1
    8002400c:	4581                	li	a1,0
    8002400e:	8552                	mv	a0,s4
    80024010:	00002097          	auipc	ra,0x2
    80024014:	8e0080e7          	jalr	-1824(ra) # 800258f0 <eread>
    80024018:	2501                	sext.w	a0,a0
    8002401a:	1ea91763          	bne	s2,a0,80024208 <exec+0x300>
  for(i = 0; i < sz; i += PGSIZE){
    8002401e:	009d84bb          	addw	s1,s11,s1
    80024022:	013d09bb          	addw	s3,s10,s3
    80024026:	2774f863          	bgeu	s1,s7,80024296 <exec+0x38e>
    pa = walkaddr(pagetable, va + i);
    8002402a:	02049593          	slli	a1,s1,0x20
    8002402e:	9181                	srli	a1,a1,0x20
    80024030:	95e2                	add	a1,a1,s8
    80024032:	e0843503          	ld	a0,-504(s0)
    80024036:	ffffd097          	auipc	ra,0xffffd
    8002403a:	b6c080e7          	jalr	-1172(ra) # 80020ba2 <walkaddr>
    8002403e:	862a                	mv	a2,a0
    if(pa == NULL)
    80024040:	d95d                	beqz	a0,80023ff6 <exec+0xee>
      n = PGSIZE;
    80024042:	8956                	mv	s2,s5
    if(sz - i < PGSIZE)
    80024044:	fd59f1e3          	bgeu	s3,s5,80024006 <exec+0xfe>
      n = sz - i;
    80024048:	894e                	mv	s2,s3
    8002404a:	bf75                	j	80024006 <exec+0xfe>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    8002404c:	4481                	li	s1,0
  eunlock(ep);
    8002404e:	8552                	mv	a0,s4
    80024050:	00002097          	auipc	ra,0x2
    80024054:	1ca080e7          	jalr	458(ra) # 8002621a <eunlock>
  eput(ep);
    80024058:	8552                	mv	a0,s4
    8002405a:	00002097          	auipc	ra,0x2
    8002405e:	20e080e7          	jalr	526(ra) # 80026268 <eput>
  p = myproc();
    80024062:	ffffe097          	auipc	ra,0xffffe
    80024066:	a70080e7          	jalr	-1424(ra) # 80021ad2 <myproc>
    8002406a:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    8002406c:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80024070:	6785                	lui	a5,0x1
    80024072:	17fd                	addi	a5,a5,-1
    80024074:	94be                	add	s1,s1,a5
    80024076:	77fd                	lui	a5,0xfffff
    80024078:	8fe5                	and	a5,a5,s1
    8002407a:	def43823          	sd	a5,-528(s0)
  if((sz1 = uvmalloc(pagetable, kpagetable, sz, sz + 2*PGSIZE)) == 0)
    8002407e:	6689                	lui	a3,0x2
    80024080:	96be                	add	a3,a3,a5
    80024082:	863e                	mv	a2,a5
    80024084:	85da                	mv	a1,s6
    80024086:	e0843483          	ld	s1,-504(s0)
    8002408a:	8526                	mv	a0,s1
    8002408c:	ffffd097          	auipc	ra,0xffffd
    80024090:	014080e7          	jalr	20(ra) # 800210a0 <uvmalloc>
    80024094:	8caa                	mv	s9,a0
  ep = 0;
    80024096:	4a01                	li	s4,0
  if((sz1 = uvmalloc(pagetable, kpagetable, sz, sz + 2*PGSIZE)) == 0)
    80024098:	16050863          	beqz	a0,80024208 <exec+0x300>
  uvmclear(pagetable, sz-2*PGSIZE);
    8002409c:	75f9                	lui	a1,0xffffe
    8002409e:	95aa                	add	a1,a1,a0
    800240a0:	8526                	mv	a0,s1
    800240a2:	ffffd097          	auipc	ra,0xffffd
    800240a6:	2a4080e7          	jalr	676(ra) # 80021346 <uvmclear>
  stackbase = sp - PGSIZE;
    800240aa:	7bfd                	lui	s7,0xfffff
    800240ac:	9be6                	add	s7,s7,s9
  for(argc = 0; argv[argc]; argc++) {
    800240ae:	de843783          	ld	a5,-536(s0)
    800240b2:	6388                	ld	a0,0(a5)
    800240b4:	c92d                	beqz	a0,80024126 <exec+0x21e>
    800240b6:	e8840993          	addi	s3,s0,-376
    800240ba:	f8840c13          	addi	s8,s0,-120
  sp = sz;
    800240be:	8966                	mv	s2,s9
  for(argc = 0; argv[argc]; argc++) {
    800240c0:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    800240c2:	ffffd097          	auipc	ra,0xffffd
    800240c6:	810080e7          	jalr	-2032(ra) # 800208d2 <strlen>
    800240ca:	0015079b          	addiw	a5,a0,1
    800240ce:	40f90933          	sub	s2,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800240d2:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    800240d6:	1b796463          	bltu	s2,s7,8002427e <exec+0x376>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800240da:	de843d83          	ld	s11,-536(s0)
    800240de:	000dba03          	ld	s4,0(s11) # 1000 <_start-0x8001f000>
    800240e2:	8552                	mv	a0,s4
    800240e4:	ffffc097          	auipc	ra,0xffffc
    800240e8:	7ee080e7          	jalr	2030(ra) # 800208d2 <strlen>
    800240ec:	0015069b          	addiw	a3,a0,1
    800240f0:	8652                	mv	a2,s4
    800240f2:	85ca                	mv	a1,s2
    800240f4:	e0843503          	ld	a0,-504(s0)
    800240f8:	ffffd097          	auipc	ra,0xffffd
    800240fc:	280080e7          	jalr	640(ra) # 80021378 <copyout>
    80024100:	18054363          	bltz	a0,80024286 <exec+0x37e>
    ustack[argc] = sp;
    80024104:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80024108:	0485                	addi	s1,s1,1
    8002410a:	008d8793          	addi	a5,s11,8
    8002410e:	def43423          	sd	a5,-536(s0)
    80024112:	008db503          	ld	a0,8(s11)
    80024116:	c911                	beqz	a0,8002412a <exec+0x222>
    if(argc >= MAXARG)
    80024118:	09a1                	addi	s3,s3,8
    8002411a:	fb3c14e3          	bne	s8,s3,800240c2 <exec+0x1ba>
  sz = sz1;
    8002411e:	df943823          	sd	s9,-528(s0)
  ep = 0;
    80024122:	4a01                	li	s4,0
    80024124:	a0d5                	j	80024208 <exec+0x300>
  sp = sz;
    80024126:	8966                	mv	s2,s9
  for(argc = 0; argv[argc]; argc++) {
    80024128:	4481                	li	s1,0
  ustack[argc] = 0;
    8002412a:	00349793          	slli	a5,s1,0x3
    8002412e:	f9040713          	addi	a4,s0,-112
    80024132:	97ba                	add	a5,a5,a4
    80024134:	ee07bc23          	sd	zero,-264(a5) # ffffffffffffeef8 <kernel_end+0xffffffff7ffb8ef8>
  sp -= (argc+1) * sizeof(uint64);
    80024138:	00148693          	addi	a3,s1,1
    8002413c:	068e                	slli	a3,a3,0x3
    8002413e:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80024142:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80024146:	01797663          	bgeu	s2,s7,80024152 <exec+0x24a>
  sz = sz1;
    8002414a:	df943823          	sd	s9,-528(s0)
  ep = 0;
    8002414e:	4a01                	li	s4,0
    80024150:	a865                	j	80024208 <exec+0x300>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80024152:	e8840613          	addi	a2,s0,-376
    80024156:	85ca                	mv	a1,s2
    80024158:	e0843503          	ld	a0,-504(s0)
    8002415c:	ffffd097          	auipc	ra,0xffffd
    80024160:	21c080e7          	jalr	540(ra) # 80021378 <copyout>
    80024164:	12054563          	bltz	a0,8002428e <exec+0x386>
  p->trapframe->a1 = sp;
    80024168:	060ab783          	ld	a5,96(s5)
    8002416c:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80024170:	dd843783          	ld	a5,-552(s0)
    80024174:	0007c703          	lbu	a4,0(a5)
    80024178:	cf11                	beqz	a4,80024194 <exec+0x28c>
    8002417a:	0785                	addi	a5,a5,1
    if(*s == '/')
    8002417c:	02f00693          	li	a3,47
    80024180:	a039                	j	8002418e <exec+0x286>
      last = s+1;
    80024182:	dcf43c23          	sd	a5,-552(s0)
  for(last=s=path; *s; s++)
    80024186:	0785                	addi	a5,a5,1
    80024188:	fff7c703          	lbu	a4,-1(a5)
    8002418c:	c701                	beqz	a4,80024194 <exec+0x28c>
    if(*s == '/')
    8002418e:	fed71ce3          	bne	a4,a3,80024186 <exec+0x27e>
    80024192:	bfc5                	j	80024182 <exec+0x27a>
  safestrcpy(p->name, last, sizeof(p->name));
    80024194:	4641                	li	a2,16
    80024196:	dd843583          	ld	a1,-552(s0)
    8002419a:	160a8513          	addi	a0,s5,352
    8002419e:	ffffc097          	auipc	ra,0xffffc
    800241a2:	702080e7          	jalr	1794(ra) # 800208a0 <safestrcpy>
  oldpagetable = p->pagetable;
    800241a6:	050ab503          	ld	a0,80(s5)
  oldkpagetable = p->kpagetable;
    800241aa:	058ab983          	ld	s3,88(s5)
  p->pagetable = pagetable;
    800241ae:	e0843783          	ld	a5,-504(s0)
    800241b2:	04fab823          	sd	a5,80(s5)
  p->kpagetable = kpagetable;
    800241b6:	056abc23          	sd	s6,88(s5)
  p->sz = sz;
    800241ba:	059ab423          	sd	s9,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800241be:	060ab783          	ld	a5,96(s5)
    800241c2:	e6043703          	ld	a4,-416(s0)
    800241c6:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800241c8:	060ab783          	ld	a5,96(s5)
    800241cc:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800241d0:	85ea                	mv	a1,s10
    800241d2:	ffffe097          	auipc	ra,0xffffe
    800241d6:	a80080e7          	jalr	-1408(ra) # 80021c52 <proc_freepagetable>
  w_satp(MAKE_SATP(p->kpagetable));
    800241da:	058ab783          	ld	a5,88(s5)
    800241de:	83b1                	srli	a5,a5,0xc
    800241e0:	577d                	li	a4,-1
    800241e2:	177e                	slli	a4,a4,0x3f
    800241e4:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800241e6:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma");
    800241ea:	12000073          	sfence.vma
  kvmfree(oldkpagetable, 0);
    800241ee:	4581                	li	a1,0
    800241f0:	854e                	mv	a0,s3
    800241f2:	ffffd097          	auipc	ra,0xffffd
    800241f6:	516080e7          	jalr	1302(ra) # 80021708 <kvmfree>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800241fa:	0004851b          	sext.w	a0,s1
    800241fe:	a089                	j	80024240 <exec+0x338>
    return -1;
    80024200:	557d                	li	a0,-1
    80024202:	a83d                	j	80024240 <exec+0x338>
    80024204:	de943823          	sd	s1,-528(s0)
    proc_freepagetable(pagetable, sz);
    80024208:	df043583          	ld	a1,-528(s0)
    8002420c:	e0843503          	ld	a0,-504(s0)
    80024210:	ffffe097          	auipc	ra,0xffffe
    80024214:	a42080e7          	jalr	-1470(ra) # 80021c52 <proc_freepagetable>
    kvmfree(kpagetable, 0);
    80024218:	4581                	li	a1,0
    8002421a:	855a                	mv	a0,s6
    8002421c:	ffffd097          	auipc	ra,0xffffd
    80024220:	4ec080e7          	jalr	1260(ra) # 80021708 <kvmfree>
    eunlock(ep);
    eput(ep);
  }
  return -1;
    80024224:	557d                	li	a0,-1
  if(ep){
    80024226:	000a0d63          	beqz	s4,80024240 <exec+0x338>
    eunlock(ep);
    8002422a:	8552                	mv	a0,s4
    8002422c:	00002097          	auipc	ra,0x2
    80024230:	fee080e7          	jalr	-18(ra) # 8002621a <eunlock>
    eput(ep);
    80024234:	8552                	mv	a0,s4
    80024236:	00002097          	auipc	ra,0x2
    8002423a:	032080e7          	jalr	50(ra) # 80026268 <eput>
  return -1;
    8002423e:	557d                	li	a0,-1
}
    80024240:	22813083          	ld	ra,552(sp)
    80024244:	22013403          	ld	s0,544(sp)
    80024248:	21813483          	ld	s1,536(sp)
    8002424c:	21013903          	ld	s2,528(sp)
    80024250:	20813983          	ld	s3,520(sp)
    80024254:	20013a03          	ld	s4,512(sp)
    80024258:	7afe                	ld	s5,504(sp)
    8002425a:	7b5e                	ld	s6,496(sp)
    8002425c:	7bbe                	ld	s7,488(sp)
    8002425e:	7c1e                	ld	s8,480(sp)
    80024260:	6cfe                	ld	s9,472(sp)
    80024262:	6d5e                	ld	s10,464(sp)
    80024264:	6dbe                	ld	s11,456(sp)
    80024266:	23010113          	addi	sp,sp,560
    8002426a:	8082                	ret
    8002426c:	de943823          	sd	s1,-528(s0)
    80024270:	bf61                	j	80024208 <exec+0x300>
    80024272:	de943823          	sd	s1,-528(s0)
    80024276:	bf49                	j	80024208 <exec+0x300>
    80024278:	de943823          	sd	s1,-528(s0)
    8002427c:	b771                	j	80024208 <exec+0x300>
  sz = sz1;
    8002427e:	df943823          	sd	s9,-528(s0)
  ep = 0;
    80024282:	4a01                	li	s4,0
    80024284:	b751                	j	80024208 <exec+0x300>
  sz = sz1;
    80024286:	df943823          	sd	s9,-528(s0)
  ep = 0;
    8002428a:	4a01                	li	s4,0
    8002428c:	bfb5                	j	80024208 <exec+0x300>
  sz = sz1;
    8002428e:	df943823          	sd	s9,-528(s0)
  ep = 0;
    80024292:	4a01                	li	s4,0
    80024294:	bf95                	j	80024208 <exec+0x300>
    if((sz1 = uvmalloc(pagetable, kpagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80024296:	df043483          	ld	s1,-528(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8002429a:	e0043783          	ld	a5,-512(s0)
    8002429e:	0017869b          	addiw	a3,a5,1
    800242a2:	e0d43023          	sd	a3,-512(s0)
    800242a6:	df843783          	ld	a5,-520(s0)
    800242aa:	0387879b          	addiw	a5,a5,56
    800242ae:	e8045703          	lhu	a4,-384(s0)
    800242b2:	d8e6dee3          	bge	a3,a4,8002404e <exec+0x146>
    if(eread(ep, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800242b6:	2781                	sext.w	a5,a5
    800242b8:	def43c23          	sd	a5,-520(s0)
    800242bc:	03800713          	li	a4,56
    800242c0:	86be                	mv	a3,a5
    800242c2:	de043603          	ld	a2,-544(s0)
    800242c6:	4581                	li	a1,0
    800242c8:	8552                	mv	a0,s4
    800242ca:	00001097          	auipc	ra,0x1
    800242ce:	626080e7          	jalr	1574(ra) # 800258f0 <eread>
    800242d2:	03800793          	li	a5,56
    800242d6:	f2f517e3          	bne	a0,a5,80024204 <exec+0x2fc>
    if(ph.type != ELF_PROG_LOAD)
    800242da:	e1042783          	lw	a5,-496(s0)
    800242de:	4705                	li	a4,1
    800242e0:	fae79de3          	bne	a5,a4,8002429a <exec+0x392>
    if(ph.memsz < ph.filesz)
    800242e4:	e3843683          	ld	a3,-456(s0)
    800242e8:	e3043783          	ld	a5,-464(s0)
    800242ec:	f8f6e0e3          	bltu	a3,a5,8002426c <exec+0x364>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800242f0:	e2043783          	ld	a5,-480(s0)
    800242f4:	96be                	add	a3,a3,a5
    800242f6:	f6f6eee3          	bltu	a3,a5,80024272 <exec+0x36a>
    if((sz1 = uvmalloc(pagetable, kpagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800242fa:	8626                	mv	a2,s1
    800242fc:	85da                	mv	a1,s6
    800242fe:	e0843503          	ld	a0,-504(s0)
    80024302:	ffffd097          	auipc	ra,0xffffd
    80024306:	d9e080e7          	jalr	-610(ra) # 800210a0 <uvmalloc>
    8002430a:	dea43823          	sd	a0,-528(s0)
    8002430e:	d52d                	beqz	a0,80024278 <exec+0x370>
    if(ph.vaddr % PGSIZE != 0)
    80024310:	e2043c03          	ld	s8,-480(s0)
    80024314:	dd043783          	ld	a5,-560(s0)
    80024318:	00fc77b3          	and	a5,s8,a5
    8002431c:	ee0796e3          	bnez	a5,80024208 <exec+0x300>
    if(loadseg(pagetable, ph.vaddr, ep, ph.off, ph.filesz) < 0)
    80024320:	e1842c83          	lw	s9,-488(s0)
    80024324:	e3042b83          	lw	s7,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80024328:	f60b87e3          	beqz	s7,80024296 <exec+0x38e>
    8002432c:	89de                	mv	s3,s7
    8002432e:	4481                	li	s1,0
    80024330:	b9ed                	j	8002402a <exec+0x122>
    kvmfree(kpagetable, 0);
    80024332:	4581                	li	a1,0
    80024334:	855a                	mv	a0,s6
    80024336:	ffffd097          	auipc	ra,0xffffd
    8002433a:	3d2080e7          	jalr	978(ra) # 80021708 <kvmfree>
  return -1;
    8002433e:	557d                	li	a0,-1
    80024340:	b701                	j	80024240 <exec+0x338>

0000000080024342 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80024342:	7179                	addi	sp,sp,-48
    80024344:	f406                	sd	ra,40(sp)
    80024346:	f022                	sd	s0,32(sp)
    80024348:	ec26                	sd	s1,24(sp)
    8002434a:	e84a                	sd	s2,16(sp)
    8002434c:	1800                	addi	s0,sp,48
    8002434e:	892e                	mv	s2,a1
    80024350:	84b2                	mv	s1,a2
    int fd;
    struct file *f;

    if(argint(n, &fd) < 0)
    80024352:	fdc40593          	addi	a1,s0,-36
    80024356:	fffff097          	auipc	ra,0xfffff
    8002435a:	b20080e7          	jalr	-1248(ra) # 80022e76 <argint>
    8002435e:	04054063          	bltz	a0,8002439e <argfd+0x5c>
        return -1;
    if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == NULL)
    80024362:	fdc42703          	lw	a4,-36(s0)
    80024366:	47bd                	li	a5,15
    80024368:	02e7ed63          	bltu	a5,a4,800243a2 <argfd+0x60>
    8002436c:	ffffd097          	auipc	ra,0xffffd
    80024370:	766080e7          	jalr	1894(ra) # 80021ad2 <myproc>
    80024374:	fdc42703          	lw	a4,-36(s0)
    80024378:	01a70793          	addi	a5,a4,26
    8002437c:	078e                	slli	a5,a5,0x3
    8002437e:	953e                	add	a0,a0,a5
    80024380:	651c                	ld	a5,8(a0)
    80024382:	c395                	beqz	a5,800243a6 <argfd+0x64>
        return -1;
    if(pfd)
    80024384:	00090463          	beqz	s2,8002438c <argfd+0x4a>
        *pfd = fd;
    80024388:	00e92023          	sw	a4,0(s2)
    if(pf)
        *pf = f;
    return 0;
    8002438c:	4501                	li	a0,0
    if(pf)
    8002438e:	c091                	beqz	s1,80024392 <argfd+0x50>
        *pf = f;
    80024390:	e09c                	sd	a5,0(s1)
}
    80024392:	70a2                	ld	ra,40(sp)
    80024394:	7402                	ld	s0,32(sp)
    80024396:	64e2                	ld	s1,24(sp)
    80024398:	6942                	ld	s2,16(sp)
    8002439a:	6145                	addi	sp,sp,48
    8002439c:	8082                	ret
        return -1;
    8002439e:	557d                	li	a0,-1
    800243a0:	bfcd                	j	80024392 <argfd+0x50>
        return -1;
    800243a2:	557d                	li	a0,-1
    800243a4:	b7fd                	j	80024392 <argfd+0x50>
    800243a6:	557d                	li	a0,-1
    800243a8:	b7ed                	j	80024392 <argfd+0x50>

00000000800243aa <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800243aa:	1101                	addi	sp,sp,-32
    800243ac:	ec06                	sd	ra,24(sp)
    800243ae:	e822                	sd	s0,16(sp)
    800243b0:	e426                	sd	s1,8(sp)
    800243b2:	1000                	addi	s0,sp,32
    800243b4:	84aa                	mv	s1,a0
    int fd;
    struct proc *p = myproc();
    800243b6:	ffffd097          	auipc	ra,0xffffd
    800243ba:	71c080e7          	jalr	1820(ra) # 80021ad2 <myproc>
    800243be:	862a                	mv	a2,a0

    for(fd = 0; fd < NOFILE; fd++){
    800243c0:	0d850793          	addi	a5,a0,216
    800243c4:	4501                	li	a0,0
    800243c6:	46c1                	li	a3,16
        if(p->ofile[fd] == 0){
    800243c8:	6398                	ld	a4,0(a5)
    800243ca:	cb19                	beqz	a4,800243e0 <fdalloc+0x36>
    for(fd = 0; fd < NOFILE; fd++){
    800243cc:	2505                	addiw	a0,a0,1
    800243ce:	07a1                	addi	a5,a5,8
    800243d0:	fed51ce3          	bne	a0,a3,800243c8 <fdalloc+0x1e>
            p->ofile[fd] = f;
            return fd;
        }
    }
    return -1;
    800243d4:	557d                	li	a0,-1
}
    800243d6:	60e2                	ld	ra,24(sp)
    800243d8:	6442                	ld	s0,16(sp)
    800243da:	64a2                	ld	s1,8(sp)
    800243dc:	6105                	addi	sp,sp,32
    800243de:	8082                	ret
            p->ofile[fd] = f;
    800243e0:	01a50793          	addi	a5,a0,26
    800243e4:	078e                	slli	a5,a5,0x3
    800243e6:	963e                	add	a2,a2,a5
    800243e8:	e604                	sd	s1,8(a2)
            return fd;
    800243ea:	b7f5                	j	800243d6 <fdalloc+0x2c>

00000000800243ec <create>:
    return filestat(f, st);
}

static struct dirent*
create(char *path, short type, int mode)
{
    800243ec:	7169                	addi	sp,sp,-304
    800243ee:	f606                	sd	ra,296(sp)
    800243f0:	f222                	sd	s0,288(sp)
    800243f2:	ee26                	sd	s1,280(sp)
    800243f4:	ea4a                	sd	s2,272(sp)
    800243f6:	e64e                	sd	s3,264(sp)
    800243f8:	1a00                	addi	s0,sp,304
    800243fa:	89ae                	mv	s3,a1
    struct dirent *ep, *dp;
    char name[FAT32_MAX_FILENAME + 1];

    if((dp = enameparent(path, name)) == NULL)
    800243fc:	ed040593          	addi	a1,s0,-304
    80024400:	00002097          	auipc	ra,0x2
    80024404:	5a6080e7          	jalr	1446(ra) # 800269a6 <enameparent>
    80024408:	84aa                	mv	s1,a0
    8002440a:	cd3d                	beqz	a0,80024488 <create+0x9c>
        return NULL;

    if (type == T_DIR) {
    8002440c:	0009879b          	sext.w	a5,s3
    80024410:	4705                	li	a4,1
    80024412:	06e78d63          	beq	a5,a4,8002448c <create+0xa0>
        mode = ATTR_READ_ONLY;
    } else {
        mode = 0;
    }

    elock(dp);
    80024416:	00002097          	auipc	ra,0x2
    8002441a:	dce080e7          	jalr	-562(ra) # 800261e4 <elock>
    if ((ep = ealloc(dp, name, mode)) == NULL) {
    8002441e:	4601                	li	a2,0
    80024420:	ed040593          	addi	a1,s0,-304
    80024424:	8526                	mv	a0,s1
    80024426:	00002097          	auipc	ra,0x2
    8002442a:	2aa080e7          	jalr	682(ra) # 800266d0 <ealloc>
    8002442e:	892a                	mv	s2,a0
    80024430:	c121                	beqz	a0,80024470 <create+0x84>
        eunlock(dp);
        eput(dp);
        return NULL;
    }

    if ((type == T_DIR && !(ep->attribute & ATTR_DIRECTORY)) ||
    80024432:	2981                	sext.w	s3,s3
    80024434:	4789                	li	a5,2
    80024436:	00f99663          	bne	s3,a5,80024442 <create+0x56>
        (type == T_FILE && (ep->attribute & ATTR_DIRECTORY))) {
    8002443a:	10094783          	lbu	a5,256(s2)
    8002443e:	8bc1                	andi	a5,a5,16
    80024440:	eba5                	bnez	a5,800244b0 <create+0xc4>
        eput(ep);
        eput(dp);
        return NULL;
    }

    eunlock(dp);
    80024442:	8526                	mv	a0,s1
    80024444:	00002097          	auipc	ra,0x2
    80024448:	dd6080e7          	jalr	-554(ra) # 8002621a <eunlock>
    eput(dp);
    8002444c:	8526                	mv	a0,s1
    8002444e:	00002097          	auipc	ra,0x2
    80024452:	e1a080e7          	jalr	-486(ra) # 80026268 <eput>

    elock(ep);
    80024456:	854a                	mv	a0,s2
    80024458:	00002097          	auipc	ra,0x2
    8002445c:	d8c080e7          	jalr	-628(ra) # 800261e4 <elock>
    return ep;
}
    80024460:	854a                	mv	a0,s2
    80024462:	70b2                	ld	ra,296(sp)
    80024464:	7412                	ld	s0,288(sp)
    80024466:	64f2                	ld	s1,280(sp)
    80024468:	6952                	ld	s2,272(sp)
    8002446a:	69b2                	ld	s3,264(sp)
    8002446c:	6155                	addi	sp,sp,304
    8002446e:	8082                	ret
        eunlock(dp);
    80024470:	8526                	mv	a0,s1
    80024472:	00002097          	auipc	ra,0x2
    80024476:	da8080e7          	jalr	-600(ra) # 8002621a <eunlock>
        eput(dp);
    8002447a:	8526                	mv	a0,s1
    8002447c:	00002097          	auipc	ra,0x2
    80024480:	dec080e7          	jalr	-532(ra) # 80026268 <eput>
        return NULL;
    80024484:	4901                	li	s2,0
    80024486:	bfe9                	j	80024460 <create+0x74>
        return NULL;
    80024488:	892a                	mv	s2,a0
    8002448a:	bfd9                	j	80024460 <create+0x74>
    elock(dp);
    8002448c:	00002097          	auipc	ra,0x2
    80024490:	d58080e7          	jalr	-680(ra) # 800261e4 <elock>
    if ((ep = ealloc(dp, name, mode)) == NULL) {
    80024494:	4641                	li	a2,16
    80024496:	ed040593          	addi	a1,s0,-304
    8002449a:	8526                	mv	a0,s1
    8002449c:	00002097          	auipc	ra,0x2
    800244a0:	234080e7          	jalr	564(ra) # 800266d0 <ealloc>
    800244a4:	892a                	mv	s2,a0
    800244a6:	d569                	beqz	a0,80024470 <create+0x84>
    if ((type == T_DIR && !(ep->attribute & ATTR_DIRECTORY)) ||
    800244a8:	10094783          	lbu	a5,256(s2)
    800244ac:	8bc1                	andi	a5,a5,16
    800244ae:	fbd1                	bnez	a5,80024442 <create+0x56>
        eunlock(dp);
    800244b0:	8526                	mv	a0,s1
    800244b2:	00002097          	auipc	ra,0x2
    800244b6:	d68080e7          	jalr	-664(ra) # 8002621a <eunlock>
        eput(ep);
    800244ba:	854a                	mv	a0,s2
    800244bc:	00002097          	auipc	ra,0x2
    800244c0:	dac080e7          	jalr	-596(ra) # 80026268 <eput>
        eput(dp);
    800244c4:	8526                	mv	a0,s1
    800244c6:	00002097          	auipc	ra,0x2
    800244ca:	da2080e7          	jalr	-606(ra) # 80026268 <eput>
        return NULL;
    800244ce:	4901                	li	s2,0
    800244d0:	bf41                	j	80024460 <create+0x74>

00000000800244d2 <sys_dup>:
{
    800244d2:	7179                	addi	sp,sp,-48
    800244d4:	f406                	sd	ra,40(sp)
    800244d6:	f022                	sd	s0,32(sp)
    800244d8:	ec26                	sd	s1,24(sp)
    800244da:	1800                	addi	s0,sp,48
    if(argfd(0, 0, &f) < 0)
    800244dc:	fd840613          	addi	a2,s0,-40
    800244e0:	4581                	li	a1,0
    800244e2:	4501                	li	a0,0
    800244e4:	00000097          	auipc	ra,0x0
    800244e8:	e5e080e7          	jalr	-418(ra) # 80024342 <argfd>
        return -1;
    800244ec:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0)
    800244ee:	02054363          	bltz	a0,80024514 <sys_dup+0x42>
    if((fd=fdalloc(f)) < 0)
    800244f2:	fd843503          	ld	a0,-40(s0)
    800244f6:	00000097          	auipc	ra,0x0
    800244fa:	eb4080e7          	jalr	-332(ra) # 800243aa <fdalloc>
    800244fe:	84aa                	mv	s1,a0
        return -1;
    80024500:	57fd                	li	a5,-1
    if((fd=fdalloc(f)) < 0)
    80024502:	00054963          	bltz	a0,80024514 <sys_dup+0x42>
    filedup(f);
    80024506:	fd843503          	ld	a0,-40(s0)
    8002450a:	fffff097          	auipc	ra,0xfffff
    8002450e:	308080e7          	jalr	776(ra) # 80023812 <filedup>
    return fd;
    80024512:	87a6                	mv	a5,s1
}
    80024514:	853e                	mv	a0,a5
    80024516:	70a2                	ld	ra,40(sp)
    80024518:	7402                	ld	s0,32(sp)
    8002451a:	64e2                	ld	s1,24(sp)
    8002451c:	6145                	addi	sp,sp,48
    8002451e:	8082                	ret

0000000080024520 <sys_read>:
{
    80024520:	7179                	addi	sp,sp,-48
    80024522:	f406                	sd	ra,40(sp)
    80024524:	f022                	sd	s0,32(sp)
    80024526:	1800                	addi	s0,sp,48
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80024528:	fe840613          	addi	a2,s0,-24
    8002452c:	4581                	li	a1,0
    8002452e:	4501                	li	a0,0
    80024530:	00000097          	auipc	ra,0x0
    80024534:	e12080e7          	jalr	-494(ra) # 80024342 <argfd>
        return -1;
    80024538:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002453a:	04054163          	bltz	a0,8002457c <sys_read+0x5c>
    8002453e:	fe440593          	addi	a1,s0,-28
    80024542:	4509                	li	a0,2
    80024544:	fffff097          	auipc	ra,0xfffff
    80024548:	932080e7          	jalr	-1742(ra) # 80022e76 <argint>
        return -1;
    8002454c:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002454e:	02054763          	bltz	a0,8002457c <sys_read+0x5c>
    80024552:	fd840593          	addi	a1,s0,-40
    80024556:	4505                	li	a0,1
    80024558:	fffff097          	auipc	ra,0xfffff
    8002455c:	980080e7          	jalr	-1664(ra) # 80022ed8 <argaddr>
        return -1;
    80024560:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80024562:	00054d63          	bltz	a0,8002457c <sys_read+0x5c>
    return fileread(f, p, n);
    80024566:	fe442603          	lw	a2,-28(s0)
    8002456a:	fd843583          	ld	a1,-40(s0)
    8002456e:	fe843503          	ld	a0,-24(s0)
    80024572:	fffff097          	auipc	ra,0xfffff
    80024576:	40c080e7          	jalr	1036(ra) # 8002397e <fileread>
    8002457a:	87aa                	mv	a5,a0
}
    8002457c:	853e                	mv	a0,a5
    8002457e:	70a2                	ld	ra,40(sp)
    80024580:	7402                	ld	s0,32(sp)
    80024582:	6145                	addi	sp,sp,48
    80024584:	8082                	ret

0000000080024586 <sys_write>:
{
    80024586:	7179                	addi	sp,sp,-48
    80024588:	f406                	sd	ra,40(sp)
    8002458a:	f022                	sd	s0,32(sp)
    8002458c:	1800                	addi	s0,sp,48
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8002458e:	fe840613          	addi	a2,s0,-24
    80024592:	4581                	li	a1,0
    80024594:	4501                	li	a0,0
    80024596:	00000097          	auipc	ra,0x0
    8002459a:	dac080e7          	jalr	-596(ra) # 80024342 <argfd>
        return -1;
    8002459e:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800245a0:	04054163          	bltz	a0,800245e2 <sys_write+0x5c>
    800245a4:	fe440593          	addi	a1,s0,-28
    800245a8:	4509                	li	a0,2
    800245aa:	fffff097          	auipc	ra,0xfffff
    800245ae:	8cc080e7          	jalr	-1844(ra) # 80022e76 <argint>
        return -1;
    800245b2:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800245b4:	02054763          	bltz	a0,800245e2 <sys_write+0x5c>
    800245b8:	fd840593          	addi	a1,s0,-40
    800245bc:	4505                	li	a0,1
    800245be:	fffff097          	auipc	ra,0xfffff
    800245c2:	91a080e7          	jalr	-1766(ra) # 80022ed8 <argaddr>
        return -1;
    800245c6:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800245c8:	00054d63          	bltz	a0,800245e2 <sys_write+0x5c>
    return filewrite(f, p, n);
    800245cc:	fe442603          	lw	a2,-28(s0)
    800245d0:	fd843583          	ld	a1,-40(s0)
    800245d4:	fe843503          	ld	a0,-24(s0)
    800245d8:	fffff097          	auipc	ra,0xfffff
    800245dc:	468080e7          	jalr	1128(ra) # 80023a40 <filewrite>
    800245e0:	87aa                	mv	a5,a0
}
    800245e2:	853e                	mv	a0,a5
    800245e4:	70a2                	ld	ra,40(sp)
    800245e6:	7402                	ld	s0,32(sp)
    800245e8:	6145                	addi	sp,sp,48
    800245ea:	8082                	ret

00000000800245ec <sys_close>:
{
    800245ec:	1101                	addi	sp,sp,-32
    800245ee:	ec06                	sd	ra,24(sp)
    800245f0:	e822                	sd	s0,16(sp)
    800245f2:	1000                	addi	s0,sp,32
    if(argfd(0, &fd, &f) < 0)
    800245f4:	fe040613          	addi	a2,s0,-32
    800245f8:	fec40593          	addi	a1,s0,-20
    800245fc:	4501                	li	a0,0
    800245fe:	00000097          	auipc	ra,0x0
    80024602:	d44080e7          	jalr	-700(ra) # 80024342 <argfd>
        return -1;
    80024606:	57fd                	li	a5,-1
    if(argfd(0, &fd, &f) < 0)
    80024608:	02054463          	bltz	a0,80024630 <sys_close+0x44>
    myproc()->ofile[fd] = 0;
    8002460c:	ffffd097          	auipc	ra,0xffffd
    80024610:	4c6080e7          	jalr	1222(ra) # 80021ad2 <myproc>
    80024614:	fec42783          	lw	a5,-20(s0)
    80024618:	07e9                	addi	a5,a5,26
    8002461a:	078e                	slli	a5,a5,0x3
    8002461c:	97aa                	add	a5,a5,a0
    8002461e:	0007b423          	sd	zero,8(a5)
    fileclose(f);
    80024622:	fe043503          	ld	a0,-32(s0)
    80024626:	fffff097          	auipc	ra,0xfffff
    8002462a:	23e080e7          	jalr	574(ra) # 80023864 <fileclose>
    return 0;
    8002462e:	4781                	li	a5,0
}
    80024630:	853e                	mv	a0,a5
    80024632:	60e2                	ld	ra,24(sp)
    80024634:	6442                	ld	s0,16(sp)
    80024636:	6105                	addi	sp,sp,32
    80024638:	8082                	ret

000000008002463a <sys_fstat>:
{
    8002463a:	1101                	addi	sp,sp,-32
    8002463c:	ec06                	sd	ra,24(sp)
    8002463e:	e822                	sd	s0,16(sp)
    80024640:	1000                	addi	s0,sp,32
    if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80024642:	fe840613          	addi	a2,s0,-24
    80024646:	4581                	li	a1,0
    80024648:	4501                	li	a0,0
    8002464a:	00000097          	auipc	ra,0x0
    8002464e:	cf8080e7          	jalr	-776(ra) # 80024342 <argfd>
        return -1;
    80024652:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80024654:	02054563          	bltz	a0,8002467e <sys_fstat+0x44>
    80024658:	fe040593          	addi	a1,s0,-32
    8002465c:	4505                	li	a0,1
    8002465e:	fffff097          	auipc	ra,0xfffff
    80024662:	87a080e7          	jalr	-1926(ra) # 80022ed8 <argaddr>
        return -1;
    80024666:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80024668:	00054b63          	bltz	a0,8002467e <sys_fstat+0x44>
    return filestat(f, st);
    8002466c:	fe043583          	ld	a1,-32(s0)
    80024670:	fe843503          	ld	a0,-24(s0)
    80024674:	fffff097          	auipc	ra,0xfffff
    80024678:	2a6080e7          	jalr	678(ra) # 8002391a <filestat>
    8002467c:	87aa                	mv	a5,a0
}
    8002467e:	853e                	mv	a0,a5
    80024680:	60e2                	ld	ra,24(sp)
    80024682:	6442                	ld	s0,16(sp)
    80024684:	6105                	addi	sp,sp,32
    80024686:	8082                	ret

0000000080024688 <sys_open>:

uint64
sys_open(void)
{
    80024688:	7129                	addi	sp,sp,-320
    8002468a:	fe06                	sd	ra,312(sp)
    8002468c:	fa22                	sd	s0,304(sp)
    8002468e:	f626                	sd	s1,296(sp)
    80024690:	f24a                	sd	s2,288(sp)
    80024692:	ee4e                	sd	s3,280(sp)
    80024694:	0280                	addi	s0,sp,320
    char path[FAT32_MAX_PATH];
    int fd, omode;
    struct file *f;
    struct dirent *ep;

    if(argstr(1, path, FAT32_MAX_PATH) < 0 || argint(2, &omode) < 0)
    80024696:	10400613          	li	a2,260
    8002469a:	ec840593          	addi	a1,s0,-312
    8002469e:	4505                	li	a0,1
    800246a0:	fffff097          	auipc	ra,0xfffff
    800246a4:	85a080e7          	jalr	-1958(ra) # 80022efa <argstr>
    800246a8:	87aa                	mv	a5,a0
        return -1;
    800246aa:	557d                	li	a0,-1
    if(argstr(1, path, FAT32_MAX_PATH) < 0 || argint(2, &omode) < 0)
    800246ac:	0807ce63          	bltz	a5,80024748 <sys_open+0xc0>
    800246b0:	ec440593          	addi	a1,s0,-316
    800246b4:	4509                	li	a0,2
    800246b6:	ffffe097          	auipc	ra,0xffffe
    800246ba:	7c0080e7          	jalr	1984(ra) # 80022e76 <argint>
    800246be:	0e054163          	bltz	a0,800247a0 <sys_open+0x118>

    if(omode & O_CREATE){
    800246c2:	ec442603          	lw	a2,-316(s0)
    800246c6:	04067793          	andi	a5,a2,64
    800246ca:	c7d1                	beqz	a5,80024756 <sys_open+0xce>
        ep = create(path, T_FILE, omode);
    800246cc:	4589                	li	a1,2
    800246ce:	ec840513          	addi	a0,s0,-312
    800246d2:	00000097          	auipc	ra,0x0
    800246d6:	d1a080e7          	jalr	-742(ra) # 800243ec <create>
    800246da:	892a                	mv	s2,a0
        if(ep == NULL){
    800246dc:	c561                	beqz	a0,800247a4 <sys_open+0x11c>
            eput(ep);
            return -1;
        }
    }

    if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    800246de:	fffff097          	auipc	ra,0xfffff
    800246e2:	0ca080e7          	jalr	202(ra) # 800237a8 <filealloc>
    800246e6:	89aa                	mv	s3,a0
    800246e8:	c579                	beqz	a0,800247b6 <sys_open+0x12e>
    800246ea:	00000097          	auipc	ra,0x0
    800246ee:	cc0080e7          	jalr	-832(ra) # 800243aa <fdalloc>
    800246f2:	84aa                	mv	s1,a0
    800246f4:	0a054c63          	bltz	a0,800247ac <sys_open+0x124>
        eunlock(ep);
        eput(ep);
        return -1;
    }

    if(!(ep->attribute & ATTR_DIRECTORY) && (omode & O_TRUNC)){
    800246f8:	10094783          	lbu	a5,256(s2)
    800246fc:	8bc1                	andi	a5,a5,16
    800246fe:	e791                	bnez	a5,8002470a <sys_open+0x82>
    80024700:	ec442783          	lw	a5,-316(s0)
    80024704:	4007f793          	andi	a5,a5,1024
    80024708:	e7d1                	bnez	a5,80024794 <sys_open+0x10c>
        etrunc(ep);
    }

    f->type = FD_ENTRY;
    8002470a:	4789                	li	a5,2
    8002470c:	00f9a023          	sw	a5,0(s3)
    f->off = (omode & O_APPEND) ? ep->file_size : 0;
    80024710:	ec442783          	lw	a5,-316(s0)
    80024714:	0047f693          	andi	a3,a5,4
    80024718:	4701                	li	a4,0
    8002471a:	c299                	beqz	a3,80024720 <sys_open+0x98>
    8002471c:	10892703          	lw	a4,264(s2)
    80024720:	02e9a023          	sw	a4,32(s3)
    f->ep = ep;
    80024724:	0129bc23          	sd	s2,24(s3)
    f->readable = !(omode & O_WRONLY);
    80024728:	0017c713          	xori	a4,a5,1
    8002472c:	8b05                	andi	a4,a4,1
    8002472e:	00e98423          	sb	a4,8(s3)
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80024732:	8b8d                	andi	a5,a5,3
    80024734:	00f037b3          	snez	a5,a5
    80024738:	00f984a3          	sb	a5,9(s3)

    eunlock(ep);
    8002473c:	854a                	mv	a0,s2
    8002473e:	00002097          	auipc	ra,0x2
    80024742:	adc080e7          	jalr	-1316(ra) # 8002621a <eunlock>

    return fd;
    80024746:	8526                	mv	a0,s1
}
    80024748:	70f2                	ld	ra,312(sp)
    8002474a:	7452                	ld	s0,304(sp)
    8002474c:	74b2                	ld	s1,296(sp)
    8002474e:	7912                	ld	s2,288(sp)
    80024750:	69f2                	ld	s3,280(sp)
    80024752:	6131                	addi	sp,sp,320
    80024754:	8082                	ret
        if((ep = ename(path)) == NULL){
    80024756:	ec840513          	addi	a0,s0,-312
    8002475a:	00002097          	auipc	ra,0x2
    8002475e:	22e080e7          	jalr	558(ra) # 80026988 <ename>
    80024762:	892a                	mv	s2,a0
    80024764:	c131                	beqz	a0,800247a8 <sys_open+0x120>
        elock(ep);
    80024766:	00002097          	auipc	ra,0x2
    8002476a:	a7e080e7          	jalr	-1410(ra) # 800261e4 <elock>
        if((ep->attribute & ATTR_DIRECTORY) && omode != O_RDONLY){
    8002476e:	10094783          	lbu	a5,256(s2)
    80024772:	8bc1                	andi	a5,a5,16
    80024774:	d7ad                	beqz	a5,800246de <sys_open+0x56>
    80024776:	ec442783          	lw	a5,-316(s0)
    8002477a:	d3b5                	beqz	a5,800246de <sys_open+0x56>
            eunlock(ep);
    8002477c:	854a                	mv	a0,s2
    8002477e:	00002097          	auipc	ra,0x2
    80024782:	a9c080e7          	jalr	-1380(ra) # 8002621a <eunlock>
            eput(ep);
    80024786:	854a                	mv	a0,s2
    80024788:	00002097          	auipc	ra,0x2
    8002478c:	ae0080e7          	jalr	-1312(ra) # 80026268 <eput>
            return -1;
    80024790:	557d                	li	a0,-1
    80024792:	bf5d                	j	80024748 <sys_open+0xc0>
        etrunc(ep);
    80024794:	854a                	mv	a0,s2
    80024796:	00002097          	auipc	ra,0x2
    8002479a:	9e4080e7          	jalr	-1564(ra) # 8002617a <etrunc>
    8002479e:	b7b5                	j	8002470a <sys_open+0x82>
        return -1;
    800247a0:	557d                	li	a0,-1
    800247a2:	b75d                	j	80024748 <sys_open+0xc0>
            return -1;
    800247a4:	557d                	li	a0,-1
    800247a6:	b74d                	j	80024748 <sys_open+0xc0>
            return -1;
    800247a8:	557d                	li	a0,-1
    800247aa:	bf79                	j	80024748 <sys_open+0xc0>
            fileclose(f);
    800247ac:	854e                	mv	a0,s3
    800247ae:	fffff097          	auipc	ra,0xfffff
    800247b2:	0b6080e7          	jalr	182(ra) # 80023864 <fileclose>
        eunlock(ep);
    800247b6:	854a                	mv	a0,s2
    800247b8:	00002097          	auipc	ra,0x2
    800247bc:	a62080e7          	jalr	-1438(ra) # 8002621a <eunlock>
        eput(ep);
    800247c0:	854a                	mv	a0,s2
    800247c2:	00002097          	auipc	ra,0x2
    800247c6:	aa6080e7          	jalr	-1370(ra) # 80026268 <eput>
        return -1;
    800247ca:	557d                	li	a0,-1
    800247cc:	bfb5                	j	80024748 <sys_open+0xc0>

00000000800247ce <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800247ce:	7169                	addi	sp,sp,-304
    800247d0:	f606                	sd	ra,296(sp)
    800247d2:	f222                	sd	s0,288(sp)
    800247d4:	ee26                	sd	s1,280(sp)
    800247d6:	1a00                	addi	s0,sp,304
    char path[FAT32_MAX_PATH];
    struct dirent *ep;

    if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR, 0)) == 0){
    800247d8:	10400613          	li	a2,260
    800247dc:	ed840593          	addi	a1,s0,-296
    800247e0:	4501                	li	a0,0
    800247e2:	ffffe097          	auipc	ra,0xffffe
    800247e6:	718080e7          	jalr	1816(ra) # 80022efa <argstr>
        return -1;
    800247ea:	57fd                	li	a5,-1
    if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR, 0)) == 0){
    800247ec:	02054663          	bltz	a0,80024818 <sys_mkdir+0x4a>
    800247f0:	4601                	li	a2,0
    800247f2:	4585                	li	a1,1
    800247f4:	ed840513          	addi	a0,s0,-296
    800247f8:	00000097          	auipc	ra,0x0
    800247fc:	bf4080e7          	jalr	-1036(ra) # 800243ec <create>
    80024800:	84aa                	mv	s1,a0
    80024802:	c10d                	beqz	a0,80024824 <sys_mkdir+0x56>
    }
    eunlock(ep);
    80024804:	00002097          	auipc	ra,0x2
    80024808:	a16080e7          	jalr	-1514(ra) # 8002621a <eunlock>
    eput(ep);
    8002480c:	8526                	mv	a0,s1
    8002480e:	00002097          	auipc	ra,0x2
    80024812:	a5a080e7          	jalr	-1446(ra) # 80026268 <eput>
    return 0;
    80024816:	4781                	li	a5,0
}
    80024818:	853e                	mv	a0,a5
    8002481a:	70b2                	ld	ra,296(sp)
    8002481c:	7412                	ld	s0,288(sp)
    8002481e:	64f2                	ld	s1,280(sp)
    80024820:	6155                	addi	sp,sp,304
    80024822:	8082                	ret
        return -1;
    80024824:	57fd                	li	a5,-1
    80024826:	bfcd                	j	80024818 <sys_mkdir+0x4a>

0000000080024828 <sys_chdir>:

uint64
sys_chdir(void)
{
    80024828:	7169                	addi	sp,sp,-304
    8002482a:	f606                	sd	ra,296(sp)
    8002482c:	f222                	sd	s0,288(sp)
    8002482e:	ee26                	sd	s1,280(sp)
    80024830:	ea4a                	sd	s2,272(sp)
    80024832:	1a00                	addi	s0,sp,304
    char path[FAT32_MAX_PATH];
    struct dirent *ep;
    struct proc *p = myproc();
    80024834:	ffffd097          	auipc	ra,0xffffd
    80024838:	29e080e7          	jalr	670(ra) # 80021ad2 <myproc>
    8002483c:	892a                	mv	s2,a0

    if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = ename(path)) == NULL){
    8002483e:	10400613          	li	a2,260
    80024842:	ed840593          	addi	a1,s0,-296
    80024846:	4501                	li	a0,0
    80024848:	ffffe097          	auipc	ra,0xffffe
    8002484c:	6b2080e7          	jalr	1714(ra) # 80022efa <argstr>
        return -1;
    80024850:	57fd                	li	a5,-1
    if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = ename(path)) == NULL){
    80024852:	04054063          	bltz	a0,80024892 <sys_chdir+0x6a>
    80024856:	ed840513          	addi	a0,s0,-296
    8002485a:	00002097          	auipc	ra,0x2
    8002485e:	12e080e7          	jalr	302(ra) # 80026988 <ename>
    80024862:	84aa                	mv	s1,a0
    80024864:	c931                	beqz	a0,800248b8 <sys_chdir+0x90>
    }
    elock(ep);
    80024866:	00002097          	auipc	ra,0x2
    8002486a:	97e080e7          	jalr	-1666(ra) # 800261e4 <elock>
    if(!(ep->attribute & ATTR_DIRECTORY)){
    8002486e:	1004c783          	lbu	a5,256(s1)
    80024872:	8bc1                	andi	a5,a5,16
    80024874:	c795                	beqz	a5,800248a0 <sys_chdir+0x78>
        eunlock(ep);
        eput(ep);
        return -1;
    }
    eunlock(ep);
    80024876:	8526                	mv	a0,s1
    80024878:	00002097          	auipc	ra,0x2
    8002487c:	9a2080e7          	jalr	-1630(ra) # 8002621a <eunlock>
    eput(p->cwd);
    80024880:	15893503          	ld	a0,344(s2)
    80024884:	00002097          	auipc	ra,0x2
    80024888:	9e4080e7          	jalr	-1564(ra) # 80026268 <eput>
    p->cwd = ep;
    8002488c:	14993c23          	sd	s1,344(s2)
    return 0;
    80024890:	4781                	li	a5,0
}
    80024892:	853e                	mv	a0,a5
    80024894:	70b2                	ld	ra,296(sp)
    80024896:	7412                	ld	s0,288(sp)
    80024898:	64f2                	ld	s1,280(sp)
    8002489a:	6952                	ld	s2,272(sp)
    8002489c:	6155                	addi	sp,sp,304
    8002489e:	8082                	ret
        eunlock(ep);
    800248a0:	8526                	mv	a0,s1
    800248a2:	00002097          	auipc	ra,0x2
    800248a6:	978080e7          	jalr	-1672(ra) # 8002621a <eunlock>
        eput(ep);
    800248aa:	8526                	mv	a0,s1
    800248ac:	00002097          	auipc	ra,0x2
    800248b0:	9bc080e7          	jalr	-1604(ra) # 80026268 <eput>
        return -1;
    800248b4:	57fd                	li	a5,-1
    800248b6:	bff1                	j	80024892 <sys_chdir+0x6a>
        return -1;
    800248b8:	57fd                	li	a5,-1
    800248ba:	bfe1                	j	80024892 <sys_chdir+0x6a>

00000000800248bc <sys_pipe>:

uint64
sys_pipe(void)
{
    800248bc:	7139                	addi	sp,sp,-64
    800248be:	fc06                	sd	ra,56(sp)
    800248c0:	f822                	sd	s0,48(sp)
    800248c2:	f426                	sd	s1,40(sp)
    800248c4:	0080                	addi	s0,sp,64
    uint64 fdarray; // user pointer to array of two integers
    struct file *rf, *wf;
    int fd0, fd1;
    struct proc *p = myproc();
    800248c6:	ffffd097          	auipc	ra,0xffffd
    800248ca:	20c080e7          	jalr	524(ra) # 80021ad2 <myproc>
    800248ce:	84aa                	mv	s1,a0

    if(argaddr(0, &fdarray) < 0)
    800248d0:	fd840593          	addi	a1,s0,-40
    800248d4:	4501                	li	a0,0
    800248d6:	ffffe097          	auipc	ra,0xffffe
    800248da:	602080e7          	jalr	1538(ra) # 80022ed8 <argaddr>
        return -1;
    800248de:	57fd                	li	a5,-1
    if(argaddr(0, &fdarray) < 0)
    800248e0:	0c054e63          	bltz	a0,800249bc <sys_pipe+0x100>
    if(pipealloc(&rf, &wf) < 0)
    800248e4:	fc840593          	addi	a1,s0,-56
    800248e8:	fd040513          	addi	a0,s0,-48
    800248ec:	fffff097          	auipc	ra,0xfffff
    800248f0:	2ec080e7          	jalr	748(ra) # 80023bd8 <pipealloc>
        return -1;
    800248f4:	57fd                	li	a5,-1
    if(pipealloc(&rf, &wf) < 0)
    800248f6:	0c054363          	bltz	a0,800249bc <sys_pipe+0x100>
    fd0 = -1;
    800248fa:	fcf42223          	sw	a5,-60(s0)
    if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800248fe:	fd043503          	ld	a0,-48(s0)
    80024902:	00000097          	auipc	ra,0x0
    80024906:	aa8080e7          	jalr	-1368(ra) # 800243aa <fdalloc>
    8002490a:	fca42223          	sw	a0,-60(s0)
    8002490e:	08054a63          	bltz	a0,800249a2 <sys_pipe+0xe6>
    80024912:	fc843503          	ld	a0,-56(s0)
    80024916:	00000097          	auipc	ra,0x0
    8002491a:	a94080e7          	jalr	-1388(ra) # 800243aa <fdalloc>
    8002491e:	fca42023          	sw	a0,-64(s0)
    80024922:	06054663          	bltz	a0,8002498e <sys_pipe+0xd2>
        fileclose(wf);
        return -1;
    }
    // if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    //    copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80024926:	4611                	li	a2,4
    80024928:	fc440593          	addi	a1,s0,-60
    8002492c:	fd843503          	ld	a0,-40(s0)
    80024930:	ffffd097          	auipc	ra,0xffffd
    80024934:	ad4080e7          	jalr	-1324(ra) # 80021404 <copyout2>
    80024938:	00054f63          	bltz	a0,80024956 <sys_pipe+0x9a>
       copyout2(fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8002493c:	4611                	li	a2,4
    8002493e:	fc040593          	addi	a1,s0,-64
    80024942:	fd843503          	ld	a0,-40(s0)
    80024946:	0511                	addi	a0,a0,4
    80024948:	ffffd097          	auipc	ra,0xffffd
    8002494c:	abc080e7          	jalr	-1348(ra) # 80021404 <copyout2>
        p->ofile[fd1] = 0;
        fileclose(rf);
        fileclose(wf);
        return -1;
    }
    return 0;
    80024950:	4781                	li	a5,0
    if(copyout2(fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80024952:	06055563          	bgez	a0,800249bc <sys_pipe+0x100>
        p->ofile[fd0] = 0;
    80024956:	fc442783          	lw	a5,-60(s0)
    8002495a:	07e9                	addi	a5,a5,26
    8002495c:	078e                	slli	a5,a5,0x3
    8002495e:	97a6                	add	a5,a5,s1
    80024960:	0007b423          	sd	zero,8(a5)
        p->ofile[fd1] = 0;
    80024964:	fc042503          	lw	a0,-64(s0)
    80024968:	0569                	addi	a0,a0,26
    8002496a:	050e                	slli	a0,a0,0x3
    8002496c:	9526                	add	a0,a0,s1
    8002496e:	00053423          	sd	zero,8(a0)
        fileclose(rf);
    80024972:	fd043503          	ld	a0,-48(s0)
    80024976:	fffff097          	auipc	ra,0xfffff
    8002497a:	eee080e7          	jalr	-274(ra) # 80023864 <fileclose>
        fileclose(wf);
    8002497e:	fc843503          	ld	a0,-56(s0)
    80024982:	fffff097          	auipc	ra,0xfffff
    80024986:	ee2080e7          	jalr	-286(ra) # 80023864 <fileclose>
        return -1;
    8002498a:	57fd                	li	a5,-1
    8002498c:	a805                	j	800249bc <sys_pipe+0x100>
        if(fd0 >= 0)
    8002498e:	fc442783          	lw	a5,-60(s0)
    80024992:	0007c863          	bltz	a5,800249a2 <sys_pipe+0xe6>
            p->ofile[fd0] = 0;
    80024996:	01a78513          	addi	a0,a5,26
    8002499a:	050e                	slli	a0,a0,0x3
    8002499c:	9526                	add	a0,a0,s1
    8002499e:	00053423          	sd	zero,8(a0)
        fileclose(rf);
    800249a2:	fd043503          	ld	a0,-48(s0)
    800249a6:	fffff097          	auipc	ra,0xfffff
    800249aa:	ebe080e7          	jalr	-322(ra) # 80023864 <fileclose>
        fileclose(wf);
    800249ae:	fc843503          	ld	a0,-56(s0)
    800249b2:	fffff097          	auipc	ra,0xfffff
    800249b6:	eb2080e7          	jalr	-334(ra) # 80023864 <fileclose>
        return -1;
    800249ba:	57fd                	li	a5,-1
}
    800249bc:	853e                	mv	a0,a5
    800249be:	70e2                	ld	ra,56(sp)
    800249c0:	7442                	ld	s0,48(sp)
    800249c2:	74a2                	ld	s1,40(sp)
    800249c4:	6121                	addi	sp,sp,64
    800249c6:	8082                	ret

00000000800249c8 <sys_dev>:

// To open console device.
uint64
sys_dev(void)
{
    800249c8:	7179                	addi	sp,sp,-48
    800249ca:	f406                	sd	ra,40(sp)
    800249cc:	f022                	sd	s0,32(sp)
    800249ce:	ec26                	sd	s1,24(sp)
    800249d0:	1800                	addi	s0,sp,48
    int fd, omode;
    int major, minor;
    struct file *f;

    if(argint(0, &omode) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0){
    800249d2:	fdc40593          	addi	a1,s0,-36
    800249d6:	4501                	li	a0,0
    800249d8:	ffffe097          	auipc	ra,0xffffe
    800249dc:	49e080e7          	jalr	1182(ra) # 80022e76 <argint>
    800249e0:	08054a63          	bltz	a0,80024a74 <sys_dev+0xac>
    800249e4:	fd840593          	addi	a1,s0,-40
    800249e8:	4505                	li	a0,1
    800249ea:	ffffe097          	auipc	ra,0xffffe
    800249ee:	48c080e7          	jalr	1164(ra) # 80022e76 <argint>
    800249f2:	08054763          	bltz	a0,80024a80 <sys_dev+0xb8>
    800249f6:	fd440593          	addi	a1,s0,-44
    800249fa:	4509                	li	a0,2
    800249fc:	ffffe097          	auipc	ra,0xffffe
    80024a00:	47a080e7          	jalr	1146(ra) # 80022e76 <argint>
    80024a04:	08054063          	bltz	a0,80024a84 <sys_dev+0xbc>
        return -1;
    }

    if(omode & O_CREATE){
    80024a08:	fdc42783          	lw	a5,-36(s0)
    80024a0c:	0407f793          	andi	a5,a5,64
    80024a10:	ebb1                	bnez	a5,80024a64 <sys_dev+0x9c>
        panic("dev file on FAT");
    }

    if(major < 0 || major >= NDEV)
    80024a12:	fd842703          	lw	a4,-40(s0)
    80024a16:	47a5                	li	a5,9
        return -1;
    80024a18:	557d                	li	a0,-1
    if(major < 0 || major >= NDEV)
    80024a1a:	04e7ee63          	bltu	a5,a4,80024a76 <sys_dev+0xae>

    if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
    80024a1e:	fffff097          	auipc	ra,0xfffff
    80024a22:	d8a080e7          	jalr	-630(ra) # 800237a8 <filealloc>
    80024a26:	84aa                	mv	s1,a0
    80024a28:	c125                	beqz	a0,80024a88 <sys_dev+0xc0>
    80024a2a:	00000097          	auipc	ra,0x0
    80024a2e:	980080e7          	jalr	-1664(ra) # 800243aa <fdalloc>
    80024a32:	04054d63          	bltz	a0,80024a8c <sys_dev+0xc4>
        if(f)
            fileclose(f);
        return -1;
    }

    f->type = FD_DEVICE;
    80024a36:	478d                	li	a5,3
    80024a38:	c09c                	sw	a5,0(s1)
    f->off = 0;
    80024a3a:	0204a023          	sw	zero,32(s1)
    f->ep = 0;
    80024a3e:	0004bc23          	sd	zero,24(s1)
    f->major = major;
    80024a42:	fd842783          	lw	a5,-40(s0)
    80024a46:	02f49223          	sh	a5,36(s1)
    f->readable = !(omode & O_WRONLY);
    80024a4a:	fdc42783          	lw	a5,-36(s0)
    80024a4e:	0017c713          	xori	a4,a5,1
    80024a52:	8b05                	andi	a4,a4,1
    80024a54:	00e48423          	sb	a4,8(s1)
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80024a58:	8b8d                	andi	a5,a5,3
    80024a5a:	00f037b3          	snez	a5,a5
    80024a5e:	00f484a3          	sb	a5,9(s1)

    return fd;
    80024a62:	a811                	j	80024a76 <sys_dev+0xae>
        panic("dev file on FAT");
    80024a64:	00007517          	auipc	a0,0x7
    80024a68:	fe450513          	addi	a0,a0,-28 # 8002ba48 <digits+0x7c0>
    80024a6c:	ffffb097          	auipc	ra,0xffffb
    80024a70:	6d6080e7          	jalr	1750(ra) # 80020142 <panic>
        return -1;
    80024a74:	557d                	li	a0,-1
}
    80024a76:	70a2                	ld	ra,40(sp)
    80024a78:	7402                	ld	s0,32(sp)
    80024a7a:	64e2                	ld	s1,24(sp)
    80024a7c:	6145                	addi	sp,sp,48
    80024a7e:	8082                	ret
        return -1;
    80024a80:	557d                	li	a0,-1
    80024a82:	bfd5                	j	80024a76 <sys_dev+0xae>
    80024a84:	557d                	li	a0,-1
    80024a86:	bfc5                	j	80024a76 <sys_dev+0xae>
        return -1;
    80024a88:	557d                	li	a0,-1
    80024a8a:	b7f5                	j	80024a76 <sys_dev+0xae>
            fileclose(f);
    80024a8c:	8526                	mv	a0,s1
    80024a8e:	fffff097          	auipc	ra,0xfffff
    80024a92:	dd6080e7          	jalr	-554(ra) # 80023864 <fileclose>
        return -1;
    80024a96:	557d                	li	a0,-1
    80024a98:	bff9                	j	80024a76 <sys_dev+0xae>

0000000080024a9a <sys_readdir>:

// To support ls command
uint64
sys_readdir(void)
{
    80024a9a:	1101                	addi	sp,sp,-32
    80024a9c:	ec06                	sd	ra,24(sp)
    80024a9e:	e822                	sd	s0,16(sp)
    80024aa0:	1000                	addi	s0,sp,32
    struct file *f;
    uint64 p;

    if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024aa2:	fe840613          	addi	a2,s0,-24
    80024aa6:	4581                	li	a1,0
    80024aa8:	4501                	li	a0,0
    80024aaa:	00000097          	auipc	ra,0x0
    80024aae:	898080e7          	jalr	-1896(ra) # 80024342 <argfd>
        return -1;
    80024ab2:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024ab4:	02054563          	bltz	a0,80024ade <sys_readdir+0x44>
    80024ab8:	fe040593          	addi	a1,s0,-32
    80024abc:	4505                	li	a0,1
    80024abe:	ffffe097          	auipc	ra,0xffffe
    80024ac2:	41a080e7          	jalr	1050(ra) # 80022ed8 <argaddr>
        return -1;
    80024ac6:	57fd                	li	a5,-1
    if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    80024ac8:	00054b63          	bltz	a0,80024ade <sys_readdir+0x44>
    return dirnext(f, p);
    80024acc:	fe043583          	ld	a1,-32(s0)
    80024ad0:	fe843503          	ld	a0,-24(s0)
    80024ad4:	fffff097          	auipc	ra,0xfffff
    80024ad8:	03e080e7          	jalr	62(ra) # 80023b12 <dirnext>
    80024adc:	87aa                	mv	a5,a0
}
    80024ade:	853e                	mv	a0,a5
    80024ae0:	60e2                	ld	ra,24(sp)
    80024ae2:	6442                	ld	s0,16(sp)
    80024ae4:	6105                	addi	sp,sp,32
    80024ae6:	8082                	ret

0000000080024ae8 <sys_getcwd>:

// get absolute cwd string
uint64
sys_getcwd(void)
{
    80024ae8:	714d                	addi	sp,sp,-336
    80024aea:	e686                	sd	ra,328(sp)
    80024aec:	e2a2                	sd	s0,320(sp)
    80024aee:	fe26                	sd	s1,312(sp)
    80024af0:	fa4a                	sd	s2,304(sp)
    80024af2:	f64e                	sd	s3,296(sp)
    80024af4:	f252                	sd	s4,288(sp)
    80024af6:	ee56                	sd	s5,280(sp)
    80024af8:	0a80                	addi	s0,sp,336
    uint64 addr;
    if (argaddr(0, &addr) < 0)
    80024afa:	fb840593          	addi	a1,s0,-72
    80024afe:	4501                	li	a0,0
    80024b00:	ffffe097          	auipc	ra,0xffffe
    80024b04:	3d8080e7          	jalr	984(ra) # 80022ed8 <argaddr>
        return -1;
    80024b08:	57fd                	li	a5,-1
    if (argaddr(0, &addr) < 0)
    80024b0a:	08054063          	bltz	a0,80024b8a <sys_getcwd+0xa2>

    struct dirent *de = myproc()->cwd;
    80024b0e:	ffffd097          	auipc	ra,0xffffd
    80024b12:	fc4080e7          	jalr	-60(ra) # 80021ad2 <myproc>
    80024b16:	15853483          	ld	s1,344(a0)
    char path[FAT32_MAX_PATH];
    char *s;
    int len;

    if (de->parent == NULL) {
    80024b1a:	1204b783          	ld	a5,288(s1)
    80024b1e:	c3c1                	beqz	a5,80024b9e <sys_getcwd+0xb6>
        s = "/";
    } else {
        s = path + FAT32_MAX_PATH - 1;
        *s = '\0';
    80024b20:	fa0409a3          	sb	zero,-77(s0)
        s = path + FAT32_MAX_PATH - 1;
    80024b24:	fb340993          	addi	s3,s0,-77
        while (de->parent) {
            len = strlen(de->filename);
            s -= len;
            if (s <= path)          // can't reach root "/"
    80024b28:	eb040a13          	addi	s4,s0,-336
                return -1;
            strncpy(s, de->filename, len);
            *--s = '/';
    80024b2c:	02f00a93          	li	s5,47
            len = strlen(de->filename);
    80024b30:	8526                	mv	a0,s1
    80024b32:	ffffc097          	auipc	ra,0xffffc
    80024b36:	da0080e7          	jalr	-608(ra) # 800208d2 <strlen>
    80024b3a:	862a                	mv	a2,a0
            s -= len;
    80024b3c:	40a98933          	sub	s2,s3,a0
            if (s <= path)          // can't reach root "/"
    80024b40:	072a7463          	bgeu	s4,s2,80024ba8 <sys_getcwd+0xc0>
            strncpy(s, de->filename, len);
    80024b44:	85a6                	mv	a1,s1
    80024b46:	854a                	mv	a0,s2
    80024b48:	ffffc097          	auipc	ra,0xffffc
    80024b4c:	d1a080e7          	jalr	-742(ra) # 80020862 <strncpy>
            *--s = '/';
    80024b50:	fff90993          	addi	s3,s2,-1
    80024b54:	ff590fa3          	sb	s5,-1(s2)
            de = de->parent;
    80024b58:	1204b483          	ld	s1,288(s1)
        while (de->parent) {
    80024b5c:	1204b783          	ld	a5,288(s1)
    80024b60:	fbe1                	bnez	a5,80024b30 <sys_getcwd+0x48>
        }
    }

    // if (copyout(myproc()->pagetable, addr, s, strlen(s) + 1) < 0)
    if (copyout2(addr, s, strlen(s) + 1) < 0)
    80024b62:	fb843483          	ld	s1,-72(s0)
    80024b66:	854e                	mv	a0,s3
    80024b68:	ffffc097          	auipc	ra,0xffffc
    80024b6c:	d6a080e7          	jalr	-662(ra) # 800208d2 <strlen>
    80024b70:	0015061b          	addiw	a2,a0,1
    80024b74:	85ce                	mv	a1,s3
    80024b76:	8526                	mv	a0,s1
    80024b78:	ffffd097          	auipc	ra,0xffffd
    80024b7c:	88c080e7          	jalr	-1908(ra) # 80021404 <copyout2>
        return NULL;
    80024b80:	4781                	li	a5,0
    if (copyout2(addr, s, strlen(s) + 1) < 0)
    80024b82:	00054463          	bltz	a0,80024b8a <sys_getcwd+0xa2>

    return addr;
    80024b86:	fb843783          	ld	a5,-72(s0)

}
    80024b8a:	853e                	mv	a0,a5
    80024b8c:	60b6                	ld	ra,328(sp)
    80024b8e:	6416                	ld	s0,320(sp)
    80024b90:	74f2                	ld	s1,312(sp)
    80024b92:	7952                	ld	s2,304(sp)
    80024b94:	79b2                	ld	s3,296(sp)
    80024b96:	7a12                	ld	s4,288(sp)
    80024b98:	6af2                	ld	s5,280(sp)
    80024b9a:	6171                	addi	sp,sp,336
    80024b9c:	8082                	ret
        s = "/";
    80024b9e:	00007997          	auipc	s3,0x7
    80024ba2:	99a98993          	addi	s3,s3,-1638 # 8002b538 <digits+0x2b0>
    80024ba6:	bf75                	j	80024b62 <sys_getcwd+0x7a>
                return -1;
    80024ba8:	57fd                	li	a5,-1
    80024baa:	b7c5                	j	80024b8a <sys_getcwd+0xa2>

0000000080024bac <sys_remove>:
    return ret == -1;
}

uint64
sys_remove(void)
{
    80024bac:	d6010113          	addi	sp,sp,-672
    80024bb0:	28113c23          	sd	ra,664(sp)
    80024bb4:	28813823          	sd	s0,656(sp)
    80024bb8:	28913423          	sd	s1,648(sp)
    80024bbc:	1500                	addi	s0,sp,672
    char path[FAT32_MAX_PATH];
    struct dirent *ep;
    int len;
    if((len = argstr(0, path, FAT32_MAX_PATH)) <= 0)
    80024bbe:	10400613          	li	a2,260
    80024bc2:	ed840593          	addi	a1,s0,-296
    80024bc6:	4501                	li	a0,0
    80024bc8:	ffffe097          	auipc	ra,0xffffe
    80024bcc:	332080e7          	jalr	818(ra) # 80022efa <argstr>
    80024bd0:	0ea05a63          	blez	a0,80024cc4 <sys_remove+0x118>
        return -1;

    char *s = path + len - 1;
    80024bd4:	157d                	addi	a0,a0,-1
    80024bd6:	ed840713          	addi	a4,s0,-296
    80024bda:	00a707b3          	add	a5,a4,a0
    while (s >= path && *s == '/') {
    80024bde:	02f00693          	li	a3,47
    80024be2:	863a                	mv	a2,a4
    80024be4:	00e7e963          	bltu	a5,a4,80024bf6 <sys_remove+0x4a>
    80024be8:	0007c703          	lbu	a4,0(a5)
    80024bec:	08d71a63          	bne	a4,a3,80024c80 <sys_remove+0xd4>
        s--;
    80024bf0:	17fd                	addi	a5,a5,-1
    while (s >= path && *s == '/') {
    80024bf2:	fec7fbe3          	bgeu	a5,a2,80024be8 <sys_remove+0x3c>
    }
    if (s >= path && *s == '.' && (s == path || *--s == '/')) {
        return -1;
    }

    if((ep = ename(path)) == NULL){
    80024bf6:	ed840513          	addi	a0,s0,-296
    80024bfa:	00002097          	auipc	ra,0x2
    80024bfe:	d8e080e7          	jalr	-626(ra) # 80026988 <ename>
    80024c02:	84aa                	mv	s1,a0
    80024c04:	c561                	beqz	a0,80024ccc <sys_remove+0x120>
        return -1;
    }
    elock(ep);
    80024c06:	00001097          	auipc	ra,0x1
    80024c0a:	5de080e7          	jalr	1502(ra) # 800261e4 <elock>
    if((ep->attribute & ATTR_DIRECTORY) && !isdirempty(ep)){
    80024c0e:	1004c783          	lbu	a5,256(s1)
    80024c12:	8bc1                	andi	a5,a5,16
    80024c14:	c38d                	beqz	a5,80024c36 <sys_remove+0x8a>
    ep.valid = 0;
    80024c16:	e8041323          	sh	zero,-378(s0)
    ret = enext(dp, &ep, 2 * 32, &count);   // skip the "." and ".."
    80024c1a:	d6c40693          	addi	a3,s0,-660
    80024c1e:	04000613          	li	a2,64
    80024c22:	d7040593          	addi	a1,s0,-656
    80024c26:	8526                	mv	a0,s1
    80024c28:	00001097          	auipc	ra,0x1
    80024c2c:	7c0080e7          	jalr	1984(ra) # 800263e8 <enext>
    if((ep->attribute & ATTR_DIRECTORY) && !isdirempty(ep)){
    80024c30:	57fd                	li	a5,-1
    80024c32:	06f51d63          	bne	a0,a5,80024cac <sys_remove+0x100>
        eunlock(ep);
        eput(ep);
        return -1;
    }
    elock(ep->parent);      // Will this lead to deadlock?
    80024c36:	1204b503          	ld	a0,288(s1)
    80024c3a:	00001097          	auipc	ra,0x1
    80024c3e:	5aa080e7          	jalr	1450(ra) # 800261e4 <elock>
    eremove(ep);
    80024c42:	8526                	mv	a0,s1
    80024c44:	00001097          	auipc	ra,0x1
    80024c48:	46c080e7          	jalr	1132(ra) # 800260b0 <eremove>
    eunlock(ep->parent);
    80024c4c:	1204b503          	ld	a0,288(s1)
    80024c50:	00001097          	auipc	ra,0x1
    80024c54:	5ca080e7          	jalr	1482(ra) # 8002621a <eunlock>
    eunlock(ep);
    80024c58:	8526                	mv	a0,s1
    80024c5a:	00001097          	auipc	ra,0x1
    80024c5e:	5c0080e7          	jalr	1472(ra) # 8002621a <eunlock>
    eput(ep);
    80024c62:	8526                	mv	a0,s1
    80024c64:	00001097          	auipc	ra,0x1
    80024c68:	604080e7          	jalr	1540(ra) # 80026268 <eput>

    return 0;
    80024c6c:	4501                	li	a0,0
}
    80024c6e:	29813083          	ld	ra,664(sp)
    80024c72:	29013403          	ld	s0,656(sp)
    80024c76:	28813483          	ld	s1,648(sp)
    80024c7a:	2a010113          	addi	sp,sp,672
    80024c7e:	8082                	ret
    if (s >= path && *s == '.' && (s == path || *--s == '/')) {
    80024c80:	ed840713          	addi	a4,s0,-296
    80024c84:	f6e7e9e3          	bltu	a5,a4,80024bf6 <sys_remove+0x4a>
    80024c88:	0007c683          	lbu	a3,0(a5)
    80024c8c:	02e00713          	li	a4,46
    80024c90:	f6e693e3          	bne	a3,a4,80024bf6 <sys_remove+0x4a>
    80024c94:	ed840713          	addi	a4,s0,-296
    80024c98:	02e78863          	beq	a5,a4,80024cc8 <sys_remove+0x11c>
    80024c9c:	fff7c703          	lbu	a4,-1(a5)
    80024ca0:	02f00793          	li	a5,47
    80024ca4:	f4f719e3          	bne	a4,a5,80024bf6 <sys_remove+0x4a>
        return -1;
    80024ca8:	557d                	li	a0,-1
    80024caa:	b7d1                	j	80024c6e <sys_remove+0xc2>
        eunlock(ep);
    80024cac:	8526                	mv	a0,s1
    80024cae:	00001097          	auipc	ra,0x1
    80024cb2:	56c080e7          	jalr	1388(ra) # 8002621a <eunlock>
        eput(ep);
    80024cb6:	8526                	mv	a0,s1
    80024cb8:	00001097          	auipc	ra,0x1
    80024cbc:	5b0080e7          	jalr	1456(ra) # 80026268 <eput>
        return -1;
    80024cc0:	557d                	li	a0,-1
    80024cc2:	b775                	j	80024c6e <sys_remove+0xc2>
        return -1;
    80024cc4:	557d                	li	a0,-1
    80024cc6:	b765                	j	80024c6e <sys_remove+0xc2>
        return -1;
    80024cc8:	557d                	li	a0,-1
    80024cca:	b755                	j	80024c6e <sys_remove+0xc2>
        return -1;
    80024ccc:	557d                	li	a0,-1
    80024cce:	b745                	j	80024c6e <sys_remove+0xc2>

0000000080024cd0 <sys_rename>:

// Must hold too many locks at a time! It's possible to raise a deadlock.
// Because this op takes some steps, we can't promise
uint64
sys_rename(void)
{
    80024cd0:	c4010113          	addi	sp,sp,-960
    80024cd4:	3a113c23          	sd	ra,952(sp)
    80024cd8:	3a813823          	sd	s0,944(sp)
    80024cdc:	3a913423          	sd	s1,936(sp)
    80024ce0:	3b213023          	sd	s2,928(sp)
    80024ce4:	39313c23          	sd	s3,920(sp)
    80024ce8:	39413823          	sd	s4,912(sp)
    80024cec:	0780                	addi	s0,sp,960
    char old[FAT32_MAX_PATH], new[FAT32_MAX_PATH];
    if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024cee:	10400613          	li	a2,260
    80024cf2:	ec840593          	addi	a1,s0,-312
    80024cf6:	4501                	li	a0,0
    80024cf8:	ffffe097          	auipc	ra,0xffffe
    80024cfc:	202080e7          	jalr	514(ra) # 80022efa <argstr>
        return -1;
    80024d00:	57fd                	li	a5,-1
    if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024d02:	0c054d63          	bltz	a0,80024ddc <sys_rename+0x10c>
    80024d06:	10400613          	li	a2,260
    80024d0a:	dc040593          	addi	a1,s0,-576
    80024d0e:	4505                	li	a0,1
    80024d10:	ffffe097          	auipc	ra,0xffffe
    80024d14:	1ea080e7          	jalr	490(ra) # 80022efa <argstr>
        return -1;
    80024d18:	57fd                	li	a5,-1
    if (argstr(0, old, FAT32_MAX_PATH) < 0 || argstr(1, new, FAT32_MAX_PATH) < 0) {
    80024d1a:	0c054163          	bltz	a0,80024ddc <sys_rename+0x10c>
    }

    struct dirent *src = NULL, *dst = NULL, *pdst = NULL;
    int srclock = 0;
    char *name;
    if ((src = ename(old)) == NULL || (pdst = enameparent(new, old)) == NULL
    80024d1e:	ec840513          	addi	a0,s0,-312
    80024d22:	00002097          	auipc	ra,0x2
    80024d26:	c66080e7          	jalr	-922(ra) # 80026988 <ename>
    80024d2a:	84aa                	mv	s1,a0
    80024d2c:	1c050963          	beqz	a0,80024efe <sys_rename+0x22e>
    80024d30:	ec840593          	addi	a1,s0,-312
    80024d34:	dc040513          	addi	a0,s0,-576
    80024d38:	00002097          	auipc	ra,0x2
    80024d3c:	c6e080e7          	jalr	-914(ra) # 800269a6 <enameparent>
    80024d40:	892a                	mv	s2,a0
    80024d42:	cd35                	beqz	a0,80024dbe <sys_rename+0xee>
        || (name = formatname(old)) == NULL) {
    80024d44:	ec840513          	addi	a0,s0,-312
    80024d48:	00001097          	auipc	ra,0x1
    80024d4c:	dcc080e7          	jalr	-564(ra) # 80025b14 <formatname>
    80024d50:	89aa                	mv	s3,a0
    80024d52:	c535                	beqz	a0,80024dbe <sys_rename+0xee>
        goto fail;          // src doesn't exist || dst parent doesn't exist || illegal new name
    }
    for (struct dirent *ep = pdst; ep != NULL; ep = ep->parent) {
        if (ep == src) {    // In what universe can we move a directory into its child?
    80024d54:	07248563          	beq	s1,s2,80024dbe <sys_rename+0xee>
    for (struct dirent *ep = pdst; ep != NULL; ep = ep->parent) {
    80024d58:	87ca                	mv	a5,s2
    80024d5a:	1207b783          	ld	a5,288(a5)
    80024d5e:	c781                	beqz	a5,80024d66 <sys_rename+0x96>
        if (ep == src) {    // In what universe can we move a directory into its child?
    80024d60:	fef49de3          	bne	s1,a5,80024d5a <sys_rename+0x8a>
    80024d64:	a8a9                	j	80024dbe <sys_rename+0xee>
            goto fail;
        }
    }

    uint off;
    elock(src);     // must hold child's lock before acquiring parent's, because we do so in other similar cases
    80024d66:	8526                	mv	a0,s1
    80024d68:	00001097          	auipc	ra,0x1
    80024d6c:	47c080e7          	jalr	1148(ra) # 800261e4 <elock>
    srclock = 1;
    elock(pdst);
    80024d70:	854a                	mv	a0,s2
    80024d72:	00001097          	auipc	ra,0x1
    80024d76:	472080e7          	jalr	1138(ra) # 800261e4 <elock>
    dst = dirlookup(pdst, name, &off);
    80024d7a:	dbc40613          	addi	a2,s0,-580
    80024d7e:	85ce                	mv	a1,s3
    80024d80:	854a                	mv	a0,s2
    80024d82:	00001097          	auipc	ra,0x1
    80024d86:	7f0080e7          	jalr	2032(ra) # 80026572 <dirlookup>
    80024d8a:	8a2a                	mv	s4,a0
    if (dst != NULL) {
    80024d8c:	cd45                	beqz	a0,80024e44 <sys_rename+0x174>
        eunlock(pdst);
    80024d8e:	854a                	mv	a0,s2
    80024d90:	00001097          	auipc	ra,0x1
    80024d94:	48a080e7          	jalr	1162(ra) # 8002621a <eunlock>
        if (src == dst) {
    80024d98:	01448963          	beq	s1,s4,80024daa <sys_rename+0xda>
            goto fail;
        } else if (src->attribute & dst->attribute & ATTR_DIRECTORY) {
    80024d9c:	1004c783          	lbu	a5,256(s1)
    80024da0:	100a4703          	lbu	a4,256(s4)
    80024da4:	8ff9                	and	a5,a5,a4
    80024da6:	8bc1                	andi	a5,a5,16
    80024da8:	ebb1                	bnez	a5,80024dfc <sys_rename+0x12c>

    return 0;

    fail:
    if (srclock)
        eunlock(src);
    80024daa:	8526                	mv	a0,s1
    80024dac:	00001097          	auipc	ra,0x1
    80024db0:	46e080e7          	jalr	1134(ra) # 8002621a <eunlock>
    if (dst)
        eput(dst);
    80024db4:	8552                	mv	a0,s4
    80024db6:	00001097          	auipc	ra,0x1
    80024dba:	4b2080e7          	jalr	1202(ra) # 80026268 <eput>
    if (pdst)
    80024dbe:	00090763          	beqz	s2,80024dcc <sys_rename+0xfc>
        eput(pdst);
    80024dc2:	854a                	mv	a0,s2
    80024dc4:	00001097          	auipc	ra,0x1
    80024dc8:	4a4080e7          	jalr	1188(ra) # 80026268 <eput>
    if (src)
        eput(src);
    return -1;
    80024dcc:	57fd                	li	a5,-1
    if (src)
    80024dce:	c499                	beqz	s1,80024ddc <sys_rename+0x10c>
        eput(src);
    80024dd0:	8526                	mv	a0,s1
    80024dd2:	00001097          	auipc	ra,0x1
    80024dd6:	496080e7          	jalr	1174(ra) # 80026268 <eput>
    return -1;
    80024dda:	57fd                	li	a5,-1
}
    80024ddc:	853e                	mv	a0,a5
    80024dde:	3b813083          	ld	ra,952(sp)
    80024de2:	3b013403          	ld	s0,944(sp)
    80024de6:	3a813483          	ld	s1,936(sp)
    80024dea:	3a013903          	ld	s2,928(sp)
    80024dee:	39813983          	ld	s3,920(sp)
    80024df2:	39013a03          	ld	s4,912(sp)
    80024df6:	3c010113          	addi	sp,sp,960
    80024dfa:	8082                	ret
            elock(dst);
    80024dfc:	8552                	mv	a0,s4
    80024dfe:	00001097          	auipc	ra,0x1
    80024e02:	3e6080e7          	jalr	998(ra) # 800261e4 <elock>
    ep.valid = 0;
    80024e06:	d6041323          	sh	zero,-666(s0)
    ret = enext(dp, &ep, 2 * 32, &count);   // skip the "." and ".."
    80024e0a:	c4c40693          	addi	a3,s0,-948
    80024e0e:	04000613          	li	a2,64
    80024e12:	c5040593          	addi	a1,s0,-944
    80024e16:	8552                	mv	a0,s4
    80024e18:	00001097          	auipc	ra,0x1
    80024e1c:	5d0080e7          	jalr	1488(ra) # 800263e8 <enext>
            if (!isdirempty(dst)) {    // it's ok to overwrite an empty dir
    80024e20:	57fd                	li	a5,-1
    80024e22:	0cf51863          	bne	a0,a5,80024ef2 <sys_rename+0x222>
            elock(pdst);
    80024e26:	854a                	mv	a0,s2
    80024e28:	00001097          	auipc	ra,0x1
    80024e2c:	3bc080e7          	jalr	956(ra) # 800261e4 <elock>
        eremove(dst);
    80024e30:	8552                	mv	a0,s4
    80024e32:	00001097          	auipc	ra,0x1
    80024e36:	27e080e7          	jalr	638(ra) # 800260b0 <eremove>
        eunlock(dst);
    80024e3a:	8552                	mv	a0,s4
    80024e3c:	00001097          	auipc	ra,0x1
    80024e40:	3de080e7          	jalr	990(ra) # 8002621a <eunlock>
    memmove(src->filename, name, FAT32_MAX_FILENAME);
    80024e44:	0ff00613          	li	a2,255
    80024e48:	85ce                	mv	a1,s3
    80024e4a:	8526                	mv	a0,s1
    80024e4c:	ffffc097          	auipc	ra,0xffffc
    80024e50:	95e080e7          	jalr	-1698(ra) # 800207aa <memmove>
    emake(pdst, src, off);
    80024e54:	dbc42603          	lw	a2,-580(s0)
    80024e58:	85a6                	mv	a1,s1
    80024e5a:	854a                	mv	a0,s2
    80024e5c:	00001097          	auipc	ra,0x1
    80024e60:	d70080e7          	jalr	-656(ra) # 80025bcc <emake>
    if (src->parent != pdst) {
    80024e64:	1204b783          	ld	a5,288(s1)
    80024e68:	01278d63          	beq	a5,s2,80024e82 <sys_rename+0x1b2>
        eunlock(pdst);
    80024e6c:	854a                	mv	a0,s2
    80024e6e:	00001097          	auipc	ra,0x1
    80024e72:	3ac080e7          	jalr	940(ra) # 8002621a <eunlock>
        elock(src->parent);
    80024e76:	1204b503          	ld	a0,288(s1)
    80024e7a:	00001097          	auipc	ra,0x1
    80024e7e:	36a080e7          	jalr	874(ra) # 800261e4 <elock>
    eremove(src);
    80024e82:	8526                	mv	a0,s1
    80024e84:	00001097          	auipc	ra,0x1
    80024e88:	22c080e7          	jalr	556(ra) # 800260b0 <eremove>
    eunlock(src->parent);
    80024e8c:	1204b503          	ld	a0,288(s1)
    80024e90:	00001097          	auipc	ra,0x1
    80024e94:	38a080e7          	jalr	906(ra) # 8002621a <eunlock>
    struct dirent *psrc = src->parent;  // src must not be root, or it won't pass the for-loop test
    80024e98:	1204b983          	ld	s3,288(s1)
    src->parent = edup(pdst);
    80024e9c:	854a                	mv	a0,s2
    80024e9e:	00001097          	auipc	ra,0x1
    80024ea2:	0e8080e7          	jalr	232(ra) # 80025f86 <edup>
    80024ea6:	12a4b023          	sd	a0,288(s1)
    src->off = off;
    80024eaa:	dbc42783          	lw	a5,-580(s0)
    80024eae:	10f4ae23          	sw	a5,284(s1)
    src->valid = 1;
    80024eb2:	4785                	li	a5,1
    80024eb4:	10f49b23          	sh	a5,278(s1)
    eunlock(src);
    80024eb8:	8526                	mv	a0,s1
    80024eba:	00001097          	auipc	ra,0x1
    80024ebe:	360080e7          	jalr	864(ra) # 8002621a <eunlock>
    eput(psrc);
    80024ec2:	854e                	mv	a0,s3
    80024ec4:	00001097          	auipc	ra,0x1
    80024ec8:	3a4080e7          	jalr	932(ra) # 80026268 <eput>
    if (dst) {
    80024ecc:	000a0763          	beqz	s4,80024eda <sys_rename+0x20a>
        eput(dst);
    80024ed0:	8552                	mv	a0,s4
    80024ed2:	00001097          	auipc	ra,0x1
    80024ed6:	396080e7          	jalr	918(ra) # 80026268 <eput>
    eput(pdst);
    80024eda:	854a                	mv	a0,s2
    80024edc:	00001097          	auipc	ra,0x1
    80024ee0:	38c080e7          	jalr	908(ra) # 80026268 <eput>
    eput(src);
    80024ee4:	8526                	mv	a0,s1
    80024ee6:	00001097          	auipc	ra,0x1
    80024eea:	382080e7          	jalr	898(ra) # 80026268 <eput>
    return 0;
    80024eee:	4781                	li	a5,0
    80024ef0:	b5f5                	j	80024ddc <sys_rename+0x10c>
                eunlock(dst);
    80024ef2:	8552                	mv	a0,s4
    80024ef4:	00001097          	auipc	ra,0x1
    80024ef8:	326080e7          	jalr	806(ra) # 8002621a <eunlock>
                goto fail;
    80024efc:	b57d                	j	80024daa <sys_rename+0xda>
    struct dirent *src = NULL, *dst = NULL, *pdst = NULL;
    80024efe:	892a                	mv	s2,a0
    if (dst)
    80024f00:	bd7d                	j	80024dbe <sys_rename+0xee>
	...

0000000080024f10 <kernelvec>:
    80024f10:	7111                	addi	sp,sp,-256
    80024f12:	e006                	sd	ra,0(sp)
    80024f14:	e40a                	sd	sp,8(sp)
    80024f16:	e80e                	sd	gp,16(sp)
    80024f18:	ec12                	sd	tp,24(sp)
    80024f1a:	f016                	sd	t0,32(sp)
    80024f1c:	f41a                	sd	t1,40(sp)
    80024f1e:	f81e                	sd	t2,48(sp)
    80024f20:	fc22                	sd	s0,56(sp)
    80024f22:	e0a6                	sd	s1,64(sp)
    80024f24:	e4aa                	sd	a0,72(sp)
    80024f26:	e8ae                	sd	a1,80(sp)
    80024f28:	ecb2                	sd	a2,88(sp)
    80024f2a:	f0b6                	sd	a3,96(sp)
    80024f2c:	f4ba                	sd	a4,104(sp)
    80024f2e:	f8be                	sd	a5,112(sp)
    80024f30:	fcc2                	sd	a6,120(sp)
    80024f32:	e146                	sd	a7,128(sp)
    80024f34:	e54a                	sd	s2,136(sp)
    80024f36:	e94e                	sd	s3,144(sp)
    80024f38:	ed52                	sd	s4,152(sp)
    80024f3a:	f156                	sd	s5,160(sp)
    80024f3c:	f55a                	sd	s6,168(sp)
    80024f3e:	f95e                	sd	s7,176(sp)
    80024f40:	fd62                	sd	s8,184(sp)
    80024f42:	e1e6                	sd	s9,192(sp)
    80024f44:	e5ea                	sd	s10,200(sp)
    80024f46:	e9ee                	sd	s11,208(sp)
    80024f48:	edf2                	sd	t3,216(sp)
    80024f4a:	f1f6                	sd	t4,224(sp)
    80024f4c:	f5fa                	sd	t5,232(sp)
    80024f4e:	f9fe                	sd	t6,240(sp)
    80024f50:	aa9fd0ef          	jal	ra,800229f8 <kerneltrap>
    80024f54:	6082                	ld	ra,0(sp)
    80024f56:	6122                	ld	sp,8(sp)
    80024f58:	61c2                	ld	gp,16(sp)
    80024f5a:	7282                	ld	t0,32(sp)
    80024f5c:	7322                	ld	t1,40(sp)
    80024f5e:	73c2                	ld	t2,48(sp)
    80024f60:	7462                	ld	s0,56(sp)
    80024f62:	6486                	ld	s1,64(sp)
    80024f64:	6526                	ld	a0,72(sp)
    80024f66:	65c6                	ld	a1,80(sp)
    80024f68:	6666                	ld	a2,88(sp)
    80024f6a:	7686                	ld	a3,96(sp)
    80024f6c:	7726                	ld	a4,104(sp)
    80024f6e:	77c6                	ld	a5,112(sp)
    80024f70:	7866                	ld	a6,120(sp)
    80024f72:	688a                	ld	a7,128(sp)
    80024f74:	692a                	ld	s2,136(sp)
    80024f76:	69ca                	ld	s3,144(sp)
    80024f78:	6a6a                	ld	s4,152(sp)
    80024f7a:	7a8a                	ld	s5,160(sp)
    80024f7c:	7b2a                	ld	s6,168(sp)
    80024f7e:	7bca                	ld	s7,176(sp)
    80024f80:	7c6a                	ld	s8,184(sp)
    80024f82:	6c8e                	ld	s9,192(sp)
    80024f84:	6d2e                	ld	s10,200(sp)
    80024f86:	6dce                	ld	s11,208(sp)
    80024f88:	6e6e                	ld	t3,216(sp)
    80024f8a:	7e8e                	ld	t4,224(sp)
    80024f8c:	7f2e                	ld	t5,232(sp)
    80024f8e:	7fce                	ld	t6,240(sp)
    80024f90:	6111                	addi	sp,sp,256
    80024f92:	10200073          	sret
	...

0000000080024f9e <timerinit>:
#include "include/proc.h"

struct spinlock tickslock;
uint ticks;

void timerinit() {
    80024f9e:	1141                	addi	sp,sp,-16
    80024fa0:	e406                	sd	ra,8(sp)
    80024fa2:	e022                	sd	s0,0(sp)
    80024fa4:	0800                	addi	s0,sp,16
    initlock(&tickslock, "time");
    80024fa6:	00007597          	auipc	a1,0x7
    80024faa:	ab258593          	addi	a1,a1,-1358 # 8002ba58 <digits+0x7d0>
    80024fae:	0001c517          	auipc	a0,0x1c
    80024fb2:	45a50513          	addi	a0,a0,1114 # 80041408 <tickslock>
    80024fb6:	ffffb097          	auipc	ra,0xffffb
    80024fba:	6b8080e7          	jalr	1720(ra) # 8002066e <initlock>
    #ifdef DEBUG
    printf("timerinit\n");
    #endif
}
    80024fbe:	60a2                	ld	ra,8(sp)
    80024fc0:	6402                	ld	s0,0(sp)
    80024fc2:	0141                	addi	sp,sp,16
    80024fc4:	8082                	ret

0000000080024fc6 <set_next_timeout>:

void
set_next_timeout() {
    80024fc6:	1141                	addi	sp,sp,-16
    80024fc8:	e422                	sd	s0,8(sp)
    80024fca:	0800                	addi	s0,sp,16
  asm volatile("rdtime %0" : "=r" (x) );
    80024fcc:	c0102573          	rdtime	a0
    // if comment the `printf` line below
    // the timer will not work.

    // this bug seems to disappear automatically
    // printf("");
    sbi_set_timer(r_time() + INTERVAL);
    80024fd0:	001dc7b7          	lui	a5,0x1dc
    80024fd4:	13078793          	addi	a5,a5,304 # 1dc130 <_start-0x7fe43ed0>
    80024fd8:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
    80024fda:	4581                	li	a1,0
    80024fdc:	4601                	li	a2,0
    80024fde:	4681                	li	a3,0
    80024fe0:	4881                	li	a7,0
    80024fe2:	00000073          	ecall
}
    80024fe6:	6422                	ld	s0,8(sp)
    80024fe8:	0141                	addi	sp,sp,16
    80024fea:	8082                	ret

0000000080024fec <timer_tick>:

void timer_tick() {
    80024fec:	1101                	addi	sp,sp,-32
    80024fee:	ec06                	sd	ra,24(sp)
    80024ff0:	e822                	sd	s0,16(sp)
    80024ff2:	e426                	sd	s1,8(sp)
    80024ff4:	1000                	addi	s0,sp,32
    acquire(&tickslock);
    80024ff6:	0001c497          	auipc	s1,0x1c
    80024ffa:	41248493          	addi	s1,s1,1042 # 80041408 <tickslock>
    80024ffe:	8526                	mv	a0,s1
    80025000:	ffffb097          	auipc	ra,0xffffb
    80025004:	6b2080e7          	jalr	1714(ra) # 800206b2 <acquire>
    ticks++;
    80025008:	4c9c                	lw	a5,24(s1)
    8002500a:	2785                	addiw	a5,a5,1
    8002500c:	cc9c                	sw	a5,24(s1)
    wakeup(&ticks);
    8002500e:	0001c517          	auipc	a0,0x1c
    80025012:	41250513          	addi	a0,a0,1042 # 80041420 <ticks>
    80025016:	ffffd097          	auipc	ra,0xffffd
    8002501a:	4b6080e7          	jalr	1206(ra) # 800224cc <wakeup>
    release(&tickslock);
    8002501e:	8526                	mv	a0,s1
    80025020:	ffffb097          	auipc	ra,0xffffb
    80025024:	6e6080e7          	jalr	1766(ra) # 80020706 <release>
    set_next_timeout();
    80025028:	00000097          	auipc	ra,0x0
    8002502c:	f9e080e7          	jalr	-98(ra) # 80024fc6 <set_next_timeout>
}
    80025030:	60e2                	ld	ra,24(sp)
    80025032:	6442                	ld	s0,16(sp)
    80025034:	64a2                	ld	s1,8(sp)
    80025036:	6105                	addi	sp,sp,32
    80025038:	8082                	ret

000000008002503a <disk_init>:
#else
#include "include/virtio.h"
#endif 

void disk_init(void)
{
    8002503a:	1141                	addi	sp,sp,-16
    8002503c:	e406                	sd	ra,8(sp)
    8002503e:	e022                	sd	s0,0(sp)
    80025040:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_init();
	#else 
	sdcard_init();
    80025042:	00003097          	auipc	ra,0x3
    80025046:	f64080e7          	jalr	-156(ra) # 80027fa6 <sdcard_init>
    #endif
}
    8002504a:	60a2                	ld	ra,8(sp)
    8002504c:	6402                	ld	s0,0(sp)
    8002504e:	0141                	addi	sp,sp,16
    80025050:	8082                	ret

0000000080025052 <disk_read>:

void disk_read(struct buf *b)
{
    80025052:	1141                	addi	sp,sp,-16
    80025054:	e406                	sd	ra,8(sp)
    80025056:	e022                	sd	s0,0(sp)
    80025058:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 0);
    #else 
	sdcard_read_sector(b->data, b->sectorno);
    8002505a:	454c                	lw	a1,12(a0)
    8002505c:	05850513          	addi	a0,a0,88
    80025060:	00003097          	auipc	ra,0x3
    80025064:	292080e7          	jalr	658(ra) # 800282f2 <sdcard_read_sector>
	#endif
}
    80025068:	60a2                	ld	ra,8(sp)
    8002506a:	6402                	ld	s0,0(sp)
    8002506c:	0141                	addi	sp,sp,16
    8002506e:	8082                	ret

0000000080025070 <disk_write>:

void disk_write(struct buf *b)
{
    80025070:	1141                	addi	sp,sp,-16
    80025072:	e406                	sd	ra,8(sp)
    80025074:	e022                	sd	s0,0(sp)
    80025076:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 1);
    #else 
	sdcard_write_sector(b->data, b->sectorno);
    80025078:	454c                	lw	a1,12(a0)
    8002507a:	05850513          	addi	a0,a0,88
    8002507e:	00003097          	auipc	ra,0x3
    80025082:	37c080e7          	jalr	892(ra) # 800283fa <sdcard_write_sector>
	#endif
}
    80025086:	60a2                	ld	ra,8(sp)
    80025088:	6402                	ld	s0,0(sp)
    8002508a:	0141                	addi	sp,sp,16
    8002508c:	8082                	ret

000000008002508e <disk_intr>:

void disk_intr(void)
{
    8002508e:	1141                	addi	sp,sp,-16
    80025090:	e406                	sd	ra,8(sp)
    80025092:	e022                	sd	s0,0(sp)
    80025094:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_intr();
    #else 
    dmac_intr(DMAC_CHANNEL0);
    80025096:	4501                	li	a0,0
    80025098:	00004097          	auipc	ra,0x4
    8002509c:	b10080e7          	jalr	-1264(ra) # 80028ba8 <dmac_intr>
    #endif
}
    800250a0:	60a2                	ld	ra,8(sp)
    800250a2:	6402                	ld	s0,0(sp)
    800250a4:	0141                	addi	sp,sp,16
    800250a6:	8082                	ret

00000000800250a8 <read_fat>:
/**
 * Read the FAT table content corresponded to the given cluster number.
 * @param   cluster     the number of cluster which you want to read its content in FAT table
 */
static uint32 read_fat(uint32 cluster)
{
    800250a8:	1101                	addi	sp,sp,-32
    800250aa:	ec06                	sd	ra,24(sp)
    800250ac:	e822                	sd	s0,16(sp)
    800250ae:	e426                	sd	s1,8(sp)
    800250b0:	e04a                	sd	s2,0(sp)
    800250b2:	1000                	addi	s0,sp,32
    if (cluster >= FAT32_EOC) {
    800250b4:	100007b7          	lui	a5,0x10000
    800250b8:	17dd                	addi	a5,a5,-9
        return cluster;
    800250ba:	84aa                	mv	s1,a0
    if (cluster >= FAT32_EOC) {
    800250bc:	00a7ea63          	bltu	a5,a0,800250d0 <read_fat+0x28>
    }
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    800250c0:	0001c797          	auipc	a5,0x1c
    800250c4:	3707a783          	lw	a5,880(a5) # 80041430 <fat+0x8>
    800250c8:	2785                	addiw	a5,a5,1
        return 0;
    800250ca:	4481                	li	s1,0
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    800250cc:	00a7f963          	bgeu	a5,a0,800250de <read_fat+0x36>
    // here should be a cache layer for FAT table, but not implemented yet.
    struct buf *b = bread(0, fat_sec);
    uint32 next_clus = *(uint32 *)(b->data + fat_offset_of_clus(cluster));
    brelse(b);
    return next_clus;
}
    800250d0:	8526                	mv	a0,s1
    800250d2:	60e2                	ld	ra,24(sp)
    800250d4:	6442                	ld	s0,16(sp)
    800250d6:	64a2                	ld	s1,8(sp)
    800250d8:	6902                	ld	s2,0(sp)
    800250da:	6105                	addi	sp,sp,32
    800250dc:	8082                	ret
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    800250de:	0025149b          	slliw	s1,a0,0x2
    800250e2:	0001c917          	auipc	s2,0x1c
    800250e6:	34690913          	addi	s2,s2,838 # 80041428 <fat>
    800250ea:	01095783          	lhu	a5,16(s2)
    800250ee:	02f4d7bb          	divuw	a5,s1,a5
    800250f2:	01495583          	lhu	a1,20(s2)
    struct buf *b = bread(0, fat_sec);
    800250f6:	9dbd                	addw	a1,a1,a5
    800250f8:	4501                	li	a0,0
    800250fa:	ffffe097          	auipc	ra,0xffffe
    800250fe:	2ea080e7          	jalr	746(ra) # 800233e4 <bread>
    return (cluster << 2) % fat.bpb.byts_per_sec;
    80025102:	01095783          	lhu	a5,16(s2)
    80025106:	02f4f4bb          	remuw	s1,s1,a5
    uint32 next_clus = *(uint32 *)(b->data + fat_offset_of_clus(cluster));
    8002510a:	1482                	slli	s1,s1,0x20
    8002510c:	9081                	srli	s1,s1,0x20
    8002510e:	94aa                	add	s1,s1,a0
    80025110:	4ca4                	lw	s1,88(s1)
    brelse(b);
    80025112:	ffffe097          	auipc	ra,0xffffe
    80025116:	3fe080e7          	jalr	1022(ra) # 80023510 <brelse>
    return next_clus;
    8002511a:	bf5d                	j	800250d0 <read_fat+0x28>

000000008002511c <alloc_clus>:
        brelse(b);
    }
}

static uint32 alloc_clus(uint8 dev)
{
    8002511c:	711d                	addi	sp,sp,-96
    8002511e:	ec86                	sd	ra,88(sp)
    80025120:	e8a2                	sd	s0,80(sp)
    80025122:	e4a6                	sd	s1,72(sp)
    80025124:	e0ca                	sd	s2,64(sp)
    80025126:	fc4e                	sd	s3,56(sp)
    80025128:	f852                	sd	s4,48(sp)
    8002512a:	f456                	sd	s5,40(sp)
    8002512c:	f05a                	sd	s6,32(sp)
    8002512e:	ec5e                	sd	s7,24(sp)
    80025130:	e862                	sd	s8,16(sp)
    80025132:	e466                	sd	s9,8(sp)
    80025134:	1080                	addi	s0,sp,96
    // should we keep a free cluster list? instead of searching fat every time.
    struct buf *b;
    uint32 sec = fat.bpb.rsvd_sec_cnt;
    80025136:	0001c797          	auipc	a5,0x1c
    8002513a:	2f278793          	addi	a5,a5,754 # 80041428 <fat>
    8002513e:	0147db83          	lhu	s7,20(a5)
    uint32 const ent_per_sec = fat.bpb.byts_per_sec / sizeof(uint32);
    80025142:	0107d903          	lhu	s2,16(a5)
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    80025146:	539c                	lw	a5,32(a5)
    80025148:	10078263          	beqz	a5,8002524c <alloc_clus+0x130>
    8002514c:	0029591b          	srliw	s2,s2,0x2
    80025150:	0009099b          	sext.w	s3,s2
    80025154:	4b01                	li	s6,0
        b = bread(dev, sec);
    80025156:	00050a9b          	sext.w	s5,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    8002515a:	4c01                	li	s8,0
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    8002515c:	0001cc97          	auipc	s9,0x1c
    80025160:	2ccc8c93          	addi	s9,s9,716 # 80041428 <fat>
    80025164:	a0c1                	j	80025224 <alloc_clus+0x108>
            if (((uint32 *)(b->data))[j] == 0) {
                ((uint32 *)(b->data))[j] = FAT32_EOC + 7;
    80025166:	100007b7          	lui	a5,0x10000
    8002516a:	17fd                	addi	a5,a5,-1
    8002516c:	c29c                	sw	a5,0(a3)
                bwrite(b);
    8002516e:	8552                	mv	a0,s4
    80025170:	ffffe097          	auipc	ra,0xffffe
    80025174:	364080e7          	jalr	868(ra) # 800234d4 <bwrite>
                brelse(b);
    80025178:	8552                	mv	a0,s4
    8002517a:	ffffe097          	auipc	ra,0xffffe
    8002517e:	396080e7          	jalr	918(ra) # 80023510 <brelse>
                uint32 clus = i * ent_per_sec + j;
    80025182:	0369093b          	mulw	s2,s2,s6
    80025186:	009904bb          	addw	s1,s2,s1
    8002518a:	00048a9b          	sext.w	s5,s1
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    8002518e:	0001c717          	auipc	a4,0x1c
    80025192:	29a70713          	addi	a4,a4,666 # 80041428 <fat>
    80025196:	01274783          	lbu	a5,18(a4)
    8002519a:	34f9                	addiw	s1,s1,-2
    8002519c:	02f489bb          	mulw	s3,s1,a5
    800251a0:	4318                	lw	a4,0(a4)
    800251a2:	00e989bb          	addw	s3,s3,a4
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    800251a6:	c7b1                	beqz	a5,800251f2 <alloc_clus+0xd6>
    800251a8:	4901                	li	s2,0
    800251aa:	0001ca17          	auipc	s4,0x1c
    800251ae:	27ea0a13          	addi	s4,s4,638 # 80041428 <fat>
        b = bread(0, sec++);
    800251b2:	013905bb          	addw	a1,s2,s3
    800251b6:	4501                	li	a0,0
    800251b8:	ffffe097          	auipc	ra,0xffffe
    800251bc:	22c080e7          	jalr	556(ra) # 800233e4 <bread>
    800251c0:	84aa                	mv	s1,a0
        memset(b->data, 0, BSIZE);
    800251c2:	20000613          	li	a2,512
    800251c6:	4581                	li	a1,0
    800251c8:	05850513          	addi	a0,a0,88
    800251cc:	ffffb097          	auipc	ra,0xffffb
    800251d0:	582080e7          	jalr	1410(ra) # 8002074e <memset>
        bwrite(b);
    800251d4:	8526                	mv	a0,s1
    800251d6:	ffffe097          	auipc	ra,0xffffe
    800251da:	2fe080e7          	jalr	766(ra) # 800234d4 <bwrite>
        brelse(b);
    800251de:	8526                	mv	a0,s1
    800251e0:	ffffe097          	auipc	ra,0xffffe
    800251e4:	330080e7          	jalr	816(ra) # 80023510 <brelse>
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    800251e8:	2905                	addiw	s2,s2,1
    800251ea:	012a4783          	lbu	a5,18(s4)
    800251ee:	fcf942e3          	blt	s2,a5,800251b2 <alloc_clus+0x96>
            }
        }
        brelse(b);
    }
    panic("no clusters");
}
    800251f2:	8556                	mv	a0,s5
    800251f4:	60e6                	ld	ra,88(sp)
    800251f6:	6446                	ld	s0,80(sp)
    800251f8:	64a6                	ld	s1,72(sp)
    800251fa:	6906                	ld	s2,64(sp)
    800251fc:	79e2                	ld	s3,56(sp)
    800251fe:	7a42                	ld	s4,48(sp)
    80025200:	7aa2                	ld	s5,40(sp)
    80025202:	7b02                	ld	s6,32(sp)
    80025204:	6be2                	ld	s7,24(sp)
    80025206:	6c42                	ld	s8,16(sp)
    80025208:	6ca2                	ld	s9,8(sp)
    8002520a:	6125                	addi	sp,sp,96
    8002520c:	8082                	ret
        brelse(b);
    8002520e:	8552                	mv	a0,s4
    80025210:	ffffe097          	auipc	ra,0xffffe
    80025214:	300080e7          	jalr	768(ra) # 80023510 <brelse>
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    80025218:	2b05                	addiw	s6,s6,1
    8002521a:	2b85                	addiw	s7,s7,1
    8002521c:	020ca783          	lw	a5,32(s9)
    80025220:	02fb7663          	bgeu	s6,a5,8002524c <alloc_clus+0x130>
        b = bread(dev, sec);
    80025224:	85de                	mv	a1,s7
    80025226:	8556                	mv	a0,s5
    80025228:	ffffe097          	auipc	ra,0xffffe
    8002522c:	1bc080e7          	jalr	444(ra) # 800233e4 <bread>
    80025230:	8a2a                	mv	s4,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80025232:	fc098ee3          	beqz	s3,8002520e <alloc_clus+0xf2>
    80025236:	05850793          	addi	a5,a0,88
    8002523a:	84e2                	mv	s1,s8
            if (((uint32 *)(b->data))[j] == 0) {
    8002523c:	86be                	mv	a3,a5
    8002523e:	4398                	lw	a4,0(a5)
    80025240:	d31d                	beqz	a4,80025166 <alloc_clus+0x4a>
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80025242:	2485                	addiw	s1,s1,1
    80025244:	0791                	addi	a5,a5,4
    80025246:	fe999be3          	bne	s3,s1,8002523c <alloc_clus+0x120>
    8002524a:	b7d1                	j	8002520e <alloc_clus+0xf2>
    panic("no clusters");
    8002524c:	00007517          	auipc	a0,0x7
    80025250:	81450513          	addi	a0,a0,-2028 # 8002ba60 <digits+0x7d8>
    80025254:	ffffb097          	auipc	ra,0xffffb
    80025258:	eee080e7          	jalr	-274(ra) # 80020142 <panic>

000000008002525c <write_fat>:
    if (cluster > fat.data_clus_cnt + 1) {
    8002525c:	0001c797          	auipc	a5,0x1c
    80025260:	1d47a783          	lw	a5,468(a5) # 80041430 <fat+0x8>
    80025264:	2785                	addiw	a5,a5,1
    80025266:	06a7e963          	bltu	a5,a0,800252d8 <write_fat+0x7c>
{
    8002526a:	7179                	addi	sp,sp,-48
    8002526c:	f406                	sd	ra,40(sp)
    8002526e:	f022                	sd	s0,32(sp)
    80025270:	ec26                	sd	s1,24(sp)
    80025272:	e84a                	sd	s2,16(sp)
    80025274:	e44e                	sd	s3,8(sp)
    80025276:	e052                	sd	s4,0(sp)
    80025278:	1800                	addi	s0,sp,48
    8002527a:	89ae                	mv	s3,a1
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    8002527c:	0025149b          	slliw	s1,a0,0x2
    80025280:	0001ca17          	auipc	s4,0x1c
    80025284:	1a8a0a13          	addi	s4,s4,424 # 80041428 <fat>
    80025288:	010a5783          	lhu	a5,16(s4)
    8002528c:	02f4d7bb          	divuw	a5,s1,a5
    80025290:	014a5583          	lhu	a1,20(s4)
    struct buf *b = bread(0, fat_sec);
    80025294:	9dbd                	addw	a1,a1,a5
    80025296:	4501                	li	a0,0
    80025298:	ffffe097          	auipc	ra,0xffffe
    8002529c:	14c080e7          	jalr	332(ra) # 800233e4 <bread>
    800252a0:	892a                	mv	s2,a0
    return (cluster << 2) % fat.bpb.byts_per_sec;
    800252a2:	010a5783          	lhu	a5,16(s4)
    800252a6:	02f4f4bb          	remuw	s1,s1,a5
    *(uint32 *)(b->data + off) = content;
    800252aa:	1482                	slli	s1,s1,0x20
    800252ac:	9081                	srli	s1,s1,0x20
    800252ae:	94aa                	add	s1,s1,a0
    800252b0:	0534ac23          	sw	s3,88(s1)
    bwrite(b);
    800252b4:	ffffe097          	auipc	ra,0xffffe
    800252b8:	220080e7          	jalr	544(ra) # 800234d4 <bwrite>
    brelse(b);
    800252bc:	854a                	mv	a0,s2
    800252be:	ffffe097          	auipc	ra,0xffffe
    800252c2:	252080e7          	jalr	594(ra) # 80023510 <brelse>
    return 0;
    800252c6:	4501                	li	a0,0
}
    800252c8:	70a2                	ld	ra,40(sp)
    800252ca:	7402                	ld	s0,32(sp)
    800252cc:	64e2                	ld	s1,24(sp)
    800252ce:	6942                	ld	s2,16(sp)
    800252d0:	69a2                	ld	s3,8(sp)
    800252d2:	6a02                	ld	s4,0(sp)
    800252d4:	6145                	addi	sp,sp,48
    800252d6:	8082                	ret
        return -1;
    800252d8:	557d                	li	a0,-1
}
    800252da:	8082                	ret

00000000800252dc <reloc_clus>:
 * @param   off         the offset from the beginning of the relative file
 * @param   alloc       whether alloc new cluster when meeting end of FAT chains
 * @return              the offset from the new cur_clus
 */
static int reloc_clus(struct dirent *entry, uint off, int alloc)
{
    800252dc:	715d                	addi	sp,sp,-80
    800252de:	e486                	sd	ra,72(sp)
    800252e0:	e0a2                	sd	s0,64(sp)
    800252e2:	fc26                	sd	s1,56(sp)
    800252e4:	f84a                	sd	s2,48(sp)
    800252e6:	f44e                	sd	s3,40(sp)
    800252e8:	f052                	sd	s4,32(sp)
    800252ea:	ec56                	sd	s5,24(sp)
    800252ec:	e85a                	sd	s6,16(sp)
    800252ee:	e45e                	sd	s7,8(sp)
    800252f0:	0880                	addi	s0,sp,80
    800252f2:	84aa                	mv	s1,a0
    800252f4:	8a2e                	mv	s4,a1
    int clus_num = off / fat.byts_per_clus;
    800252f6:	0001cb97          	auipc	s7,0x1c
    800252fa:	13ebab83          	lw	s7,318(s7) # 80041434 <fat+0xc>
    800252fe:	0375d9bb          	divuw	s3,a1,s7
    while (clus_num > entry->clus_cnt) {
    80025302:	11052703          	lw	a4,272(a0)
    80025306:	07377563          	bgeu	a4,s3,80025370 <reloc_clus+0x94>
    8002530a:	8b32                	mv	s6,a2
        int clus = read_fat(entry->cur_clus);
        if (clus >= FAT32_EOC) {
    8002530c:	10000ab7          	lui	s5,0x10000
    80025310:	1add                	addi	s5,s5,-9
    80025312:	a81d                	j	80025348 <reloc_clus+0x6c>
            if (alloc) {
                clus = alloc_clus(entry->dev);
    80025314:	1144c503          	lbu	a0,276(s1)
    80025318:	00000097          	auipc	ra,0x0
    8002531c:	e04080e7          	jalr	-508(ra) # 8002511c <alloc_clus>
    80025320:	0005091b          	sext.w	s2,a0
                write_fat(entry->cur_clus, clus);
    80025324:	85ca                	mv	a1,s2
    80025326:	10c4a503          	lw	a0,268(s1)
    8002532a:	00000097          	auipc	ra,0x0
    8002532e:	f32080e7          	jalr	-206(ra) # 8002525c <write_fat>
                entry->cur_clus = entry->first_clus;
                entry->clus_cnt = 0;
                return -1;
            }
        }
        entry->cur_clus = clus;
    80025332:	1124a623          	sw	s2,268(s1)
        entry->clus_cnt++;
    80025336:	1104a783          	lw	a5,272(s1)
    8002533a:	2785                	addiw	a5,a5,1
    8002533c:	0007871b          	sext.w	a4,a5
    80025340:	10f4a823          	sw	a5,272(s1)
    while (clus_num > entry->clus_cnt) {
    80025344:	03377663          	bgeu	a4,s3,80025370 <reloc_clus+0x94>
        int clus = read_fat(entry->cur_clus);
    80025348:	10c4a503          	lw	a0,268(s1)
    8002534c:	00000097          	auipc	ra,0x0
    80025350:	d5c080e7          	jalr	-676(ra) # 800250a8 <read_fat>
    80025354:	0005091b          	sext.w	s2,a0
        if (clus >= FAT32_EOC) {
    80025358:	fd2adde3          	bge	s5,s2,80025332 <reloc_clus+0x56>
            if (alloc) {
    8002535c:	fa0b1ce3          	bnez	s6,80025314 <reloc_clus+0x38>
                entry->cur_clus = entry->first_clus;
    80025360:	1044a783          	lw	a5,260(s1)
    80025364:	10f4a623          	sw	a5,268(s1)
                entry->clus_cnt = 0;
    80025368:	1004a823          	sw	zero,272(s1)
                return -1;
    8002536c:	557d                	li	a0,-1
    8002536e:	a881                	j	800253be <reloc_clus+0xe2>
    }
    if (clus_num < entry->clus_cnt) {
    80025370:	04e9f163          	bgeu	s3,a4,800253b2 <reloc_clus+0xd6>
        entry->cur_clus = entry->first_clus;
    80025374:	1044a783          	lw	a5,260(s1)
    80025378:	10f4a623          	sw	a5,268(s1)
        entry->clus_cnt = 0;
    8002537c:	1004a823          	sw	zero,272(s1)
        while (entry->clus_cnt < clus_num) {
    80025380:	037a6963          	bltu	s4,s7,800253b2 <reloc_clus+0xd6>
            entry->cur_clus = read_fat(entry->cur_clus);
            if (entry->cur_clus >= FAT32_EOC) {
    80025384:	10000937          	lui	s2,0x10000
    80025388:	195d                	addi	s2,s2,-9
            entry->cur_clus = read_fat(entry->cur_clus);
    8002538a:	10c4a503          	lw	a0,268(s1)
    8002538e:	00000097          	auipc	ra,0x0
    80025392:	d1a080e7          	jalr	-742(ra) # 800250a8 <read_fat>
    80025396:	2501                	sext.w	a0,a0
    80025398:	10a4a623          	sw	a0,268(s1)
            if (entry->cur_clus >= FAT32_EOC) {
    8002539c:	02a96c63          	bltu	s2,a0,800253d4 <reloc_clus+0xf8>
                panic("reloc_clus");
            }
            entry->clus_cnt++;
    800253a0:	1104a783          	lw	a5,272(s1)
    800253a4:	2785                	addiw	a5,a5,1
    800253a6:	0007871b          	sext.w	a4,a5
    800253aa:	10f4a823          	sw	a5,272(s1)
        while (entry->clus_cnt < clus_num) {
    800253ae:	fd376ee3          	bltu	a4,s3,8002538a <reloc_clus+0xae>
        }
    }
    return off % fat.byts_per_clus;
    800253b2:	0001c517          	auipc	a0,0x1c
    800253b6:	08252503          	lw	a0,130(a0) # 80041434 <fat+0xc>
    800253ba:	02aa753b          	remuw	a0,s4,a0
}
    800253be:	60a6                	ld	ra,72(sp)
    800253c0:	6406                	ld	s0,64(sp)
    800253c2:	74e2                	ld	s1,56(sp)
    800253c4:	7942                	ld	s2,48(sp)
    800253c6:	79a2                	ld	s3,40(sp)
    800253c8:	7a02                	ld	s4,32(sp)
    800253ca:	6ae2                	ld	s5,24(sp)
    800253cc:	6b42                	ld	s6,16(sp)
    800253ce:	6ba2                	ld	s7,8(sp)
    800253d0:	6161                	addi	sp,sp,80
    800253d2:	8082                	ret
                panic("reloc_clus");
    800253d4:	00006517          	auipc	a0,0x6
    800253d8:	69c50513          	addi	a0,a0,1692 # 8002ba70 <digits+0x7e8>
    800253dc:	ffffb097          	auipc	ra,0xffffb
    800253e0:	d66080e7          	jalr	-666(ra) # 80020142 <panic>

00000000800253e4 <rw_clus>:
{
    800253e4:	7119                	addi	sp,sp,-128
    800253e6:	fc86                	sd	ra,120(sp)
    800253e8:	f8a2                	sd	s0,112(sp)
    800253ea:	f4a6                	sd	s1,104(sp)
    800253ec:	f0ca                	sd	s2,96(sp)
    800253ee:	ecce                	sd	s3,88(sp)
    800253f0:	e8d2                	sd	s4,80(sp)
    800253f2:	e4d6                	sd	s5,72(sp)
    800253f4:	e0da                	sd	s6,64(sp)
    800253f6:	fc5e                	sd	s7,56(sp)
    800253f8:	f862                	sd	s8,48(sp)
    800253fa:	f466                	sd	s9,40(sp)
    800253fc:	f06a                	sd	s10,32(sp)
    800253fe:	ec6e                	sd	s11,24(sp)
    80025400:	0100                	addi	s0,sp,128
    80025402:	f8c43423          	sd	a2,-120(s0)
    80025406:	8b36                	mv	s6,a3
    80025408:	8c3e                	mv	s8,a5
    if (off + n > fat.byts_per_clus)
    8002540a:	00f706bb          	addw	a3,a4,a5
    8002540e:	0001c797          	auipc	a5,0x1c
    80025412:	0267a783          	lw	a5,38(a5) # 80041434 <fat+0xc>
    80025416:	02d7ef63          	bltu	a5,a3,80025454 <rw_clus+0x70>
    8002541a:	8cae                	mv	s9,a1
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    8002541c:	0001c797          	auipc	a5,0x1c
    80025420:	00c78793          	addi	a5,a5,12 # 80041428 <fat>
    80025424:	0107da83          	lhu	s5,16(a5)
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    80025428:	ffe5099b          	addiw	s3,a0,-2
    8002542c:	0127c503          	lbu	a0,18(a5)
    80025430:	02a989bb          	mulw	s3,s3,a0
    80025434:	4388                	lw	a0,0(a5)
    80025436:	00a989bb          	addw	s3,s3,a0
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    8002543a:	035757bb          	divuw	a5,a4,s5
    8002543e:	00f989bb          	addw	s3,s3,a5
    off = off % fat.bpb.byts_per_sec;
    80025442:	03577abb          	remuw	s5,a4,s5
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    80025446:	0e0c0363          	beqz	s8,8002552c <rw_clus+0x148>
    8002544a:	4a01                	li	s4,0
        m = BSIZE - off % BSIZE;
    8002544c:	20000d93          	li	s11,512
        if (bad == -1) {
    80025450:	5d7d                	li	s10,-1
    80025452:	a095                	j	800254b6 <rw_clus+0xd2>
        panic("offset out of range");
    80025454:	00006517          	auipc	a0,0x6
    80025458:	62c50513          	addi	a0,a0,1580 # 8002ba80 <digits+0x7f8>
    8002545c:	ffffb097          	auipc	ra,0xffffb
    80025460:	ce6080e7          	jalr	-794(ra) # 80020142 <panic>
                bwrite(bp);
    80025464:	854a                	mv	a0,s2
    80025466:	ffffe097          	auipc	ra,0xffffe
    8002546a:	06e080e7          	jalr	110(ra) # 800234d4 <bwrite>
        brelse(bp);
    8002546e:	854a                	mv	a0,s2
    80025470:	ffffe097          	auipc	ra,0xffffe
    80025474:	0a0080e7          	jalr	160(ra) # 80023510 <brelse>
        if (bad == -1) {
    80025478:	a02d                	j	800254a2 <rw_clus+0xbe>
            bad = either_copyout(user, data, bp->data + (off % BSIZE), m);
    8002547a:	05890613          	addi	a2,s2,88 # 10000058 <_start-0x7001ffa8>
    8002547e:	1682                	slli	a3,a3,0x20
    80025480:	9281                	srli	a3,a3,0x20
    80025482:	963a                	add	a2,a2,a4
    80025484:	85da                	mv	a1,s6
    80025486:	f8843503          	ld	a0,-120(s0)
    8002548a:	ffffd097          	auipc	ra,0xffffd
    8002548e:	11c080e7          	jalr	284(ra) # 800225a6 <either_copyout>
    80025492:	8baa                	mv	s7,a0
        brelse(bp);
    80025494:	854a                	mv	a0,s2
    80025496:	ffffe097          	auipc	ra,0xffffe
    8002549a:	07a080e7          	jalr	122(ra) # 80023510 <brelse>
        if (bad == -1) {
    8002549e:	07ab8763          	beq	s7,s10,8002550c <rw_clus+0x128>
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    800254a2:	01448a3b          	addw	s4,s1,s4
    800254a6:	01548abb          	addw	s5,s1,s5
    800254aa:	1482                	slli	s1,s1,0x20
    800254ac:	9081                	srli	s1,s1,0x20
    800254ae:	9b26                	add	s6,s6,s1
    800254b0:	2985                	addiw	s3,s3,1
    800254b2:	058a7d63          	bgeu	s4,s8,8002550c <rw_clus+0x128>
        bp = bread(0, sec);
    800254b6:	85ce                	mv	a1,s3
    800254b8:	4501                	li	a0,0
    800254ba:	ffffe097          	auipc	ra,0xffffe
    800254be:	f2a080e7          	jalr	-214(ra) # 800233e4 <bread>
    800254c2:	892a                	mv	s2,a0
        m = BSIZE - off % BSIZE;
    800254c4:	1ffaf713          	andi	a4,s5,511
    800254c8:	40ed863b          	subw	a2,s11,a4
        if (n - tot < m) {
    800254cc:	414c07bb          	subw	a5,s8,s4
    800254d0:	86be                	mv	a3,a5
    800254d2:	2781                	sext.w	a5,a5
    800254d4:	0006059b          	sext.w	a1,a2
    800254d8:	00f5f363          	bgeu	a1,a5,800254de <rw_clus+0xfa>
    800254dc:	86b2                	mv	a3,a2
    800254de:	0006849b          	sext.w	s1,a3
        if (write) {
    800254e2:	f80c8ce3          	beqz	s9,8002547a <rw_clus+0x96>
            if ((bad = either_copyin(bp->data + (off % BSIZE), user, data, m)) != -1) {
    800254e6:	05890513          	addi	a0,s2,88
    800254ea:	1682                	slli	a3,a3,0x20
    800254ec:	9281                	srli	a3,a3,0x20
    800254ee:	865a                	mv	a2,s6
    800254f0:	f8843583          	ld	a1,-120(s0)
    800254f4:	953a                	add	a0,a0,a4
    800254f6:	ffffd097          	auipc	ra,0xffffd
    800254fa:	0e6080e7          	jalr	230(ra) # 800225dc <either_copyin>
    800254fe:	f7a513e3          	bne	a0,s10,80025464 <rw_clus+0x80>
        brelse(bp);
    80025502:	854a                	mv	a0,s2
    80025504:	ffffe097          	auipc	ra,0xffffe
    80025508:	00c080e7          	jalr	12(ra) # 80023510 <brelse>
}
    8002550c:	8552                	mv	a0,s4
    8002550e:	70e6                	ld	ra,120(sp)
    80025510:	7446                	ld	s0,112(sp)
    80025512:	74a6                	ld	s1,104(sp)
    80025514:	7906                	ld	s2,96(sp)
    80025516:	69e6                	ld	s3,88(sp)
    80025518:	6a46                	ld	s4,80(sp)
    8002551a:	6aa6                	ld	s5,72(sp)
    8002551c:	6b06                	ld	s6,64(sp)
    8002551e:	7be2                	ld	s7,56(sp)
    80025520:	7c42                	ld	s8,48(sp)
    80025522:	7ca2                	ld	s9,40(sp)
    80025524:	7d02                	ld	s10,32(sp)
    80025526:	6de2                	ld	s11,24(sp)
    80025528:	6109                	addi	sp,sp,128
    8002552a:	8082                	ret
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    8002552c:	8a62                	mv	s4,s8
    8002552e:	bff9                	j	8002550c <rw_clus+0x128>

0000000080025530 <eget>:
// by their whole path. But when parsing a path, we open all the directories through it, 
// which forms a linked list from the final file to the root. Thus, we use the "parent" pointer 
// to recognize whether an entry with the "name" as given is really the file we want in the right path.
// Should never get root by eget, it's easy to understand.
static struct dirent *eget(struct dirent *parent, char *name)
{
    80025530:	7139                	addi	sp,sp,-64
    80025532:	fc06                	sd	ra,56(sp)
    80025534:	f822                	sd	s0,48(sp)
    80025536:	f426                	sd	s1,40(sp)
    80025538:	f04a                	sd	s2,32(sp)
    8002553a:	ec4e                	sd	s3,24(sp)
    8002553c:	e852                	sd	s4,16(sp)
    8002553e:	e456                	sd	s5,8(sp)
    80025540:	0080                	addi	s0,sp,64
    80025542:	8a2a                	mv	s4,a0
    80025544:	8aae                	mv	s5,a1
    struct dirent *ep;
    acquire(&ecache.lock);
    80025546:	0001c517          	auipc	a0,0x1c
    8002554a:	07250513          	addi	a0,a0,114 # 800415b8 <ecache>
    8002554e:	ffffb097          	auipc	ra,0xffffb
    80025552:	164080e7          	jalr	356(ra) # 800206b2 <acquire>
    if (name) {
    80025556:	060a8b63          	beqz	s5,800255cc <eget+0x9c>
        for (ep = root.next; ep != &root; ep = ep->next) {          // LRU algo
    8002555a:	0001c497          	auipc	s1,0x1c
    8002555e:	01e4b483          	ld	s1,30(s1) # 80041578 <root+0x128>
    80025562:	0001c797          	auipc	a5,0x1c
    80025566:	eee78793          	addi	a5,a5,-274 # 80041450 <root>
    8002556a:	06f48163          	beq	s1,a5,800255cc <eget+0x9c>
            if (ep->valid == 1 && ep->parent == parent
    8002556e:	4905                	li	s2,1
        for (ep = root.next; ep != &root; ep = ep->next) {          // LRU algo
    80025570:	89be                	mv	s3,a5
    80025572:	a029                	j	8002557c <eget+0x4c>
    80025574:	1284b483          	ld	s1,296(s1)
    80025578:	05348a63          	beq	s1,s3,800255cc <eget+0x9c>
            if (ep->valid == 1 && ep->parent == parent
    8002557c:	11649783          	lh	a5,278(s1)
    80025580:	ff279ae3          	bne	a5,s2,80025574 <eget+0x44>
    80025584:	1204b783          	ld	a5,288(s1)
    80025588:	ff4796e3          	bne	a5,s4,80025574 <eget+0x44>
                && strncmp(ep->filename, name, FAT32_MAX_FILENAME) == 0) {
    8002558c:	0ff00613          	li	a2,255
    80025590:	85d6                	mv	a1,s5
    80025592:	8526                	mv	a0,s1
    80025594:	ffffb097          	auipc	ra,0xffffb
    80025598:	292080e7          	jalr	658(ra) # 80020826 <strncmp>
    8002559c:	fd61                	bnez	a0,80025574 <eget+0x44>
                if (ep->ref++ == 0) {
    8002559e:	1184a783          	lw	a5,280(s1)
    800255a2:	0017871b          	addiw	a4,a5,1
    800255a6:	10e4ac23          	sw	a4,280(s1)
    800255aa:	eb81                	bnez	a5,800255ba <eget+0x8a>
                    ep->parent->ref++;
    800255ac:	1204b703          	ld	a4,288(s1)
    800255b0:	11872783          	lw	a5,280(a4)
    800255b4:	2785                	addiw	a5,a5,1
    800255b6:	10f72c23          	sw	a5,280(a4)
                }
                release(&ecache.lock);
    800255ba:	0001c517          	auipc	a0,0x1c
    800255be:	ffe50513          	addi	a0,a0,-2 # 800415b8 <ecache>
    800255c2:	ffffb097          	auipc	ra,0xffffb
    800255c6:	144080e7          	jalr	324(ra) # 80020706 <release>
                // edup(ep->parent);
                return ep;
    800255ca:	a085                	j	8002562a <eget+0xfa>
            }
        }
    }
    for (ep = root.prev; ep != &root; ep = ep->prev) {              // LRU algo
    800255cc:	0001c497          	auipc	s1,0x1c
    800255d0:	fb44b483          	ld	s1,-76(s1) # 80041580 <root+0x130>
    800255d4:	0001c797          	auipc	a5,0x1c
    800255d8:	e7c78793          	addi	a5,a5,-388 # 80041450 <root>
    800255dc:	00f48a63          	beq	s1,a5,800255f0 <eget+0xc0>
    800255e0:	873e                	mv	a4,a5
        if (ep->ref == 0) {
    800255e2:	1184a783          	lw	a5,280(s1)
    800255e6:	cf89                	beqz	a5,80025600 <eget+0xd0>
    for (ep = root.prev; ep != &root; ep = ep->prev) {              // LRU algo
    800255e8:	1304b483          	ld	s1,304(s1)
    800255ec:	fee49be3          	bne	s1,a4,800255e2 <eget+0xb2>
            ep->dirty = 0;
            release(&ecache.lock);
            return ep;
        }
    }
    panic("eget: insufficient ecache");
    800255f0:	00006517          	auipc	a0,0x6
    800255f4:	4a850513          	addi	a0,a0,1192 # 8002ba98 <digits+0x810>
    800255f8:	ffffb097          	auipc	ra,0xffffb
    800255fc:	b4a080e7          	jalr	-1206(ra) # 80020142 <panic>
            ep->ref = 1;
    80025600:	4785                	li	a5,1
    80025602:	10f4ac23          	sw	a5,280(s1)
            ep->dev = parent->dev;
    80025606:	114a4783          	lbu	a5,276(s4)
    8002560a:	10f48a23          	sb	a5,276(s1)
            ep->off = 0;
    8002560e:	1004ae23          	sw	zero,284(s1)
            ep->valid = 0;
    80025612:	10049b23          	sh	zero,278(s1)
            ep->dirty = 0;
    80025616:	10048aa3          	sb	zero,277(s1)
            release(&ecache.lock);
    8002561a:	0001c517          	auipc	a0,0x1c
    8002561e:	f9e50513          	addi	a0,a0,-98 # 800415b8 <ecache>
    80025622:	ffffb097          	auipc	ra,0xffffb
    80025626:	0e4080e7          	jalr	228(ra) # 80020706 <release>
    return 0;
}
    8002562a:	8526                	mv	a0,s1
    8002562c:	70e2                	ld	ra,56(sp)
    8002562e:	7442                	ld	s0,48(sp)
    80025630:	74a2                	ld	s1,40(sp)
    80025632:	7902                	ld	s2,32(sp)
    80025634:	69e2                	ld	s3,24(sp)
    80025636:	6a42                	ld	s4,16(sp)
    80025638:	6aa2                	ld	s5,8(sp)
    8002563a:	6121                	addi	sp,sp,64
    8002563c:	8082                	ret

000000008002563e <read_entry_name>:
 * @param   buffer      pointer to the array that stores the name
 * @param   raw_entry   pointer to the entry in a sector buffer
 * @param   islong      if non-zero, read as l-n-e, otherwise s-n-e.
 */
static void read_entry_name(char *buffer, union dentry *d)
{
    8002563e:	7139                	addi	sp,sp,-64
    80025640:	fc06                	sd	ra,56(sp)
    80025642:	f822                	sd	s0,48(sp)
    80025644:	f426                	sd	s1,40(sp)
    80025646:	f04a                	sd	s2,32(sp)
    80025648:	ec4e                	sd	s3,24(sp)
    8002564a:	0080                	addi	s0,sp,64
    8002564c:	84aa                	mv	s1,a0
    8002564e:	892e                	mv	s2,a1
    if (d->lne.attr == ATTR_LONG_NAME) {                       // long entry branch
    80025650:	00b5c703          	lbu	a4,11(a1)
    80025654:	47bd                	li	a5,15
    80025656:	08f70563          	beq	a4,a5,800256e0 <read_entry_name+0xa2>
        snstr(buffer, d->lne.name2, NELEM(d->lne.name2));
        buffer += NELEM(d->lne.name2);
        snstr(buffer, d->lne.name3, NELEM(d->lne.name3));
    } else {
        // assert: only "." and ".." will enter this branch
        memset(buffer, 0, CHAR_SHORT_NAME + 2); // plus '.' and '\0'
    8002565a:	4635                	li	a2,13
    8002565c:	4581                	li	a1,0
    8002565e:	ffffb097          	auipc	ra,0xffffb
    80025662:	0f0080e7          	jalr	240(ra) # 8002074e <memset>
        int i;
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    80025666:	00094703          	lbu	a4,0(s2)
    8002566a:	02000793          	li	a5,32
    8002566e:	0af70c63          	beq	a4,a5,80025726 <read_entry_name+0xe8>
    80025672:	4785                	li	a5,1
    80025674:	02000613          	li	a2,32
    80025678:	45a5                	li	a1,9
            buffer[i] = d->sne.name[i];
    8002567a:	00f486b3          	add	a3,s1,a5
    8002567e:	fee68fa3          	sb	a4,-1(a3) # 1fff <_start-0x8001e001>
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    80025682:	0007851b          	sext.w	a0,a5
    80025686:	00f90733          	add	a4,s2,a5
    8002568a:	00074703          	lbu	a4,0(a4)
    8002568e:	00c70563          	beq	a4,a2,80025698 <read_entry_name+0x5a>
    80025692:	0785                	addi	a5,a5,1
    80025694:	feb793e3          	bne	a5,a1,8002567a <read_entry_name+0x3c>
        }
        if (d->sne.name[8] != ' ') {
    80025698:	00894703          	lbu	a4,8(s2)
    8002569c:	02000793          	li	a5,32
    800256a0:	00f70963          	beq	a4,a5,800256b2 <read_entry_name+0x74>
            buffer[i++] = '.';
    800256a4:	00a487b3          	add	a5,s1,a0
    800256a8:	02e00713          	li	a4,46
    800256ac:	00e78023          	sb	a4,0(a5)
    800256b0:	2505                	addiw	a0,a0,1
        }
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
    800256b2:	00890793          	addi	a5,s2,8
    800256b6:	94aa                	add	s1,s1,a0
    800256b8:	092d                	addi	s2,s2,11
            if (d->sne.name[j] == ' ') { break; }
    800256ba:	02000693          	li	a3,32
    800256be:	0007c703          	lbu	a4,0(a5)
    800256c2:	00d70863          	beq	a4,a3,800256d2 <read_entry_name+0x94>
            buffer[i] = d->sne.name[j];
    800256c6:	00e48023          	sb	a4,0(s1)
        for (int j = 8; j < CHAR_SHORT_NAME; j++, i++) {
    800256ca:	0785                	addi	a5,a5,1
    800256cc:	0485                	addi	s1,s1,1
    800256ce:	ff2798e3          	bne	a5,s2,800256be <read_entry_name+0x80>
        }
    }
}
    800256d2:	70e2                	ld	ra,56(sp)
    800256d4:	7442                	ld	s0,48(sp)
    800256d6:	74a2                	ld	s1,40(sp)
    800256d8:	7902                	ld	s2,32(sp)
    800256da:	69e2                	ld	s3,24(sp)
    800256dc:	6121                	addi	sp,sp,64
    800256de:	8082                	ret
        memmove(temp, d->lne.name1, sizeof(temp));
    800256e0:	4629                	li	a2,10
    800256e2:	0585                	addi	a1,a1,1
    800256e4:	fc040993          	addi	s3,s0,-64
    800256e8:	854e                	mv	a0,s3
    800256ea:	ffffb097          	auipc	ra,0xffffb
    800256ee:	0c0080e7          	jalr	192(ra) # 800207aa <memmove>
        snstr(buffer, temp, NELEM(d->lne.name1));
    800256f2:	4615                	li	a2,5
    800256f4:	85ce                	mv	a1,s3
    800256f6:	8526                	mv	a0,s1
    800256f8:	ffffb097          	auipc	ra,0xffffb
    800256fc:	234080e7          	jalr	564(ra) # 8002092c <snstr>
        snstr(buffer, d->lne.name2, NELEM(d->lne.name2));
    80025700:	4619                	li	a2,6
    80025702:	00e90593          	addi	a1,s2,14
    80025706:	00548513          	addi	a0,s1,5
    8002570a:	ffffb097          	auipc	ra,0xffffb
    8002570e:	222080e7          	jalr	546(ra) # 8002092c <snstr>
        snstr(buffer, d->lne.name3, NELEM(d->lne.name3));
    80025712:	4609                	li	a2,2
    80025714:	01c90593          	addi	a1,s2,28
    80025718:	00b48513          	addi	a0,s1,11
    8002571c:	ffffb097          	auipc	ra,0xffffb
    80025720:	210080e7          	jalr	528(ra) # 8002092c <snstr>
    80025724:	b77d                	j	800256d2 <read_entry_name+0x94>
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
    80025726:	4501                	li	a0,0
    80025728:	bf85                	j	80025698 <read_entry_name+0x5a>

000000008002572a <fat32_init>:
{
    8002572a:	7139                	addi	sp,sp,-64
    8002572c:	fc06                	sd	ra,56(sp)
    8002572e:	f822                	sd	s0,48(sp)
    80025730:	f426                	sd	s1,40(sp)
    80025732:	f04a                	sd	s2,32(sp)
    80025734:	ec4e                	sd	s3,24(sp)
    80025736:	e852                	sd	s4,16(sp)
    80025738:	e456                	sd	s5,8(sp)
    8002573a:	0080                	addi	s0,sp,64
    struct buf *b = bread(0, 0);
    8002573c:	4581                	li	a1,0
    8002573e:	4501                	li	a0,0
    80025740:	ffffe097          	auipc	ra,0xffffe
    80025744:	ca4080e7          	jalr	-860(ra) # 800233e4 <bread>
    80025748:	892a                	mv	s2,a0
    if (strncmp((char const*)(b->data + 82), "FAT32", 5))
    8002574a:	4615                	li	a2,5
    8002574c:	00006597          	auipc	a1,0x6
    80025750:	36c58593          	addi	a1,a1,876 # 8002bab8 <digits+0x830>
    80025754:	0aa50513          	addi	a0,a0,170
    80025758:	ffffb097          	auipc	ra,0xffffb
    8002575c:	0ce080e7          	jalr	206(ra) # 80020826 <strncmp>
    80025760:	16051863          	bnez	a0,800258d0 <fat32_init+0x1a6>
    memmove(&fat.bpb.byts_per_sec, b->data + 11, 2);            // avoid misaligned load on k210
    80025764:	0001c497          	auipc	s1,0x1c
    80025768:	cc448493          	addi	s1,s1,-828 # 80041428 <fat>
    8002576c:	4609                	li	a2,2
    8002576e:	06390593          	addi	a1,s2,99
    80025772:	0001c517          	auipc	a0,0x1c
    80025776:	cc650513          	addi	a0,a0,-826 # 80041438 <fat+0x10>
    8002577a:	ffffb097          	auipc	ra,0xffffb
    8002577e:	030080e7          	jalr	48(ra) # 800207aa <memmove>
    fat.bpb.sec_per_clus = *(b->data + 13);
    80025782:	06594683          	lbu	a3,101(s2)
    80025786:	00d48923          	sb	a3,18(s1)
    fat.bpb.rsvd_sec_cnt = *(uint16 *)(b->data + 14);
    8002578a:	06695603          	lhu	a2,102(s2)
    8002578e:	00c49a23          	sh	a2,20(s1)
    fat.bpb.fat_cnt = *(b->data + 16);
    80025792:	06894703          	lbu	a4,104(s2)
    80025796:	00e48b23          	sb	a4,22(s1)
    fat.bpb.hidd_sec = *(uint32 *)(b->data + 28);
    8002579a:	07492783          	lw	a5,116(s2)
    8002579e:	cc9c                	sw	a5,24(s1)
    fat.bpb.tot_sec = *(uint32 *)(b->data + 32);
    800257a0:	07892783          	lw	a5,120(s2)
    800257a4:	ccdc                	sw	a5,28(s1)
    fat.bpb.fat_sz = *(uint32 *)(b->data + 36);
    800257a6:	07c92583          	lw	a1,124(s2)
    800257aa:	d08c                	sw	a1,32(s1)
    fat.bpb.root_clus = *(uint32 *)(b->data + 44);
    800257ac:	08492503          	lw	a0,132(s2)
    800257b0:	d0c8                	sw	a0,36(s1)
    fat.first_data_sec = fat.bpb.rsvd_sec_cnt + fat.bpb.fat_cnt * fat.bpb.fat_sz;
    800257b2:	02b7073b          	mulw	a4,a4,a1
    800257b6:	9f31                	addw	a4,a4,a2
    800257b8:	c098                	sw	a4,0(s1)
    fat.data_sec_cnt = fat.bpb.tot_sec - fat.first_data_sec;
    800257ba:	9f99                	subw	a5,a5,a4
    800257bc:	c0dc                	sw	a5,4(s1)
    fat.data_clus_cnt = fat.data_sec_cnt / fat.bpb.sec_per_clus;
    800257be:	02d7d7bb          	divuw	a5,a5,a3
    800257c2:	c49c                	sw	a5,8(s1)
    fat.byts_per_clus = fat.bpb.sec_per_clus * fat.bpb.byts_per_sec;
    800257c4:	0104d783          	lhu	a5,16(s1)
    800257c8:	02d787bb          	mulw	a5,a5,a3
    800257cc:	c4dc                	sw	a5,12(s1)
    brelse(b);
    800257ce:	854a                	mv	a0,s2
    800257d0:	ffffe097          	auipc	ra,0xffffe
    800257d4:	d40080e7          	jalr	-704(ra) # 80023510 <brelse>
    if (BSIZE != fat.bpb.byts_per_sec) 
    800257d8:	0104d703          	lhu	a4,16(s1)
    800257dc:	20000793          	li	a5,512
    800257e0:	10f71063          	bne	a4,a5,800258e0 <fat32_init+0x1b6>
    initlock(&ecache.lock, "ecache");
    800257e4:	00006597          	auipc	a1,0x6
    800257e8:	30c58593          	addi	a1,a1,780 # 8002baf0 <digits+0x868>
    800257ec:	0001c517          	auipc	a0,0x1c
    800257f0:	dcc50513          	addi	a0,a0,-564 # 800415b8 <ecache>
    800257f4:	ffffb097          	auipc	ra,0xffffb
    800257f8:	e7a080e7          	jalr	-390(ra) # 8002066e <initlock>
    memset(&root, 0, sizeof(root));
    800257fc:	0001c497          	auipc	s1,0x1c
    80025800:	c2c48493          	addi	s1,s1,-980 # 80041428 <fat>
    80025804:	0001c917          	auipc	s2,0x1c
    80025808:	c4c90913          	addi	s2,s2,-948 # 80041450 <root>
    8002580c:	16800613          	li	a2,360
    80025810:	4581                	li	a1,0
    80025812:	854a                	mv	a0,s2
    80025814:	ffffb097          	auipc	ra,0xffffb
    80025818:	f3a080e7          	jalr	-198(ra) # 8002074e <memset>
    initsleeplock(&root.lock, "entry");
    8002581c:	00006597          	auipc	a1,0x6
    80025820:	2dc58593          	addi	a1,a1,732 # 8002baf8 <digits+0x870>
    80025824:	0001c517          	auipc	a0,0x1c
    80025828:	d6450513          	addi	a0,a0,-668 # 80041588 <root+0x138>
    8002582c:	ffffe097          	auipc	ra,0xffffe
    80025830:	dfa080e7          	jalr	-518(ra) # 80023626 <initsleeplock>
    root.attribute = (ATTR_DIRECTORY | ATTR_SYSTEM);
    80025834:	47d1                	li	a5,20
    80025836:	12f48423          	sb	a5,296(s1)
    root.first_clus = root.cur_clus = fat.bpb.root_clus;
    8002583a:	50dc                	lw	a5,36(s1)
    8002583c:	12f4aa23          	sw	a5,308(s1)
    80025840:	12f4a623          	sw	a5,300(s1)
    root.valid = 1;
    80025844:	4785                	li	a5,1
    80025846:	12f49f23          	sh	a5,318(s1)
    root.prev = &root;
    8002584a:	1524bc23          	sd	s2,344(s1)
    root.next = &root;
    8002584e:	1524b823          	sd	s2,336(s1)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    80025852:	0001c497          	auipc	s1,0x1c
    80025856:	d7e48493          	addi	s1,s1,-642 # 800415d0 <ecache+0x18>
        de->next = root.next;
    8002585a:	0001c917          	auipc	s2,0x1c
    8002585e:	bce90913          	addi	s2,s2,-1074 # 80041428 <fat>
        de->prev = &root;
    80025862:	0001ca97          	auipc	s5,0x1c
    80025866:	beea8a93          	addi	s5,s5,-1042 # 80041450 <root>
        initsleeplock(&de->lock, "entry");
    8002586a:	00006a17          	auipc	s4,0x6
    8002586e:	28ea0a13          	addi	s4,s4,654 # 8002baf8 <digits+0x870>
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    80025872:	00020997          	auipc	s3,0x20
    80025876:	3ae98993          	addi	s3,s3,942 # 80045c20 <cons>
        de->dev = 0;
    8002587a:	10048a23          	sb	zero,276(s1)
        de->valid = 0;
    8002587e:	10049b23          	sh	zero,278(s1)
        de->ref = 0;
    80025882:	1004ac23          	sw	zero,280(s1)
        de->dirty = 0;
    80025886:	10048aa3          	sb	zero,277(s1)
        de->parent = 0;
    8002588a:	1204b023          	sd	zero,288(s1)
        de->next = root.next;
    8002588e:	15093783          	ld	a5,336(s2)
    80025892:	12f4b423          	sd	a5,296(s1)
        de->prev = &root;
    80025896:	1354b823          	sd	s5,304(s1)
        initsleeplock(&de->lock, "entry");
    8002589a:	85d2                	mv	a1,s4
    8002589c:	13848513          	addi	a0,s1,312
    800258a0:	ffffe097          	auipc	ra,0xffffe
    800258a4:	d86080e7          	jalr	-634(ra) # 80023626 <initsleeplock>
        root.next->prev = de;
    800258a8:	15093783          	ld	a5,336(s2)
    800258ac:	1297b823          	sd	s1,304(a5)
        root.next = de;
    800258b0:	14993823          	sd	s1,336(s2)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    800258b4:	16848493          	addi	s1,s1,360
    800258b8:	fd3491e3          	bne	s1,s3,8002587a <fat32_init+0x150>
}
    800258bc:	4501                	li	a0,0
    800258be:	70e2                	ld	ra,56(sp)
    800258c0:	7442                	ld	s0,48(sp)
    800258c2:	74a2                	ld	s1,40(sp)
    800258c4:	7902                	ld	s2,32(sp)
    800258c6:	69e2                	ld	s3,24(sp)
    800258c8:	6a42                	ld	s4,16(sp)
    800258ca:	6aa2                	ld	s5,8(sp)
    800258cc:	6121                	addi	sp,sp,64
    800258ce:	8082                	ret
        panic("not FAT32 volume");
    800258d0:	00006517          	auipc	a0,0x6
    800258d4:	1f050513          	addi	a0,a0,496 # 8002bac0 <digits+0x838>
    800258d8:	ffffb097          	auipc	ra,0xffffb
    800258dc:	86a080e7          	jalr	-1942(ra) # 80020142 <panic>
        panic("byts_per_sec != BSIZE");
    800258e0:	00006517          	auipc	a0,0x6
    800258e4:	1f850513          	addi	a0,a0,504 # 8002bad8 <digits+0x850>
    800258e8:	ffffb097          	auipc	ra,0xffffb
    800258ec:	85a080e7          	jalr	-1958(ra) # 80020142 <panic>

00000000800258f0 <eread>:
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    800258f0:	10852783          	lw	a5,264(a0)
    800258f4:	0ed7e863          	bltu	a5,a3,800259e4 <eread+0xf4>
{
    800258f8:	711d                	addi	sp,sp,-96
    800258fa:	ec86                	sd	ra,88(sp)
    800258fc:	e8a2                	sd	s0,80(sp)
    800258fe:	e4a6                	sd	s1,72(sp)
    80025900:	e0ca                	sd	s2,64(sp)
    80025902:	fc4e                	sd	s3,56(sp)
    80025904:	f852                	sd	s4,48(sp)
    80025906:	f456                	sd	s5,40(sp)
    80025908:	f05a                	sd	s6,32(sp)
    8002590a:	ec5e                	sd	s7,24(sp)
    8002590c:	e862                	sd	s8,16(sp)
    8002590e:	e466                	sd	s9,8(sp)
    80025910:	e06a                	sd	s10,0(sp)
    80025912:	1080                	addi	s0,sp,96
    80025914:	8a2a                	mv	s4,a0
    80025916:	8bae                	mv	s7,a1
    80025918:	8ab2                	mv	s5,a2
    8002591a:	8936                	mv	s2,a3
    8002591c:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    8002591e:	9eb9                	addw	a3,a3,a4
        return 0;
    80025920:	4501                	li	a0,0
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025922:	0b26e163          	bltu	a3,s2,800259c4 <eread+0xd4>
    80025926:	100a4703          	lbu	a4,256(s4)
    8002592a:	8b41                	andi	a4,a4,16
    8002592c:	ef41                	bnez	a4,800259c4 <eread+0xd4>
    if (off + n > entry->file_size) {
    8002592e:	00d7f463          	bgeu	a5,a3,80025936 <eread+0x46>
        n = entry->file_size - off;
    80025932:	41278b3b          	subw	s6,a5,s2
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025936:	10ca2703          	lw	a4,268(s4)
    8002593a:	100007b7          	lui	a5,0x10000
    8002593e:	17dd                	addi	a5,a5,-9
    80025940:	06e7ef63          	bltu	a5,a4,800259be <eread+0xce>
    80025944:	080b0e63          	beqz	s6,800259e0 <eread+0xf0>
    80025948:	4981                	li	s3,0
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    8002594a:	0001cc97          	auipc	s9,0x1c
    8002594e:	adec8c93          	addi	s9,s9,-1314 # 80041428 <fat>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025952:	8c3e                	mv	s8,a5
    80025954:	a82d                	j	8002598e <eread+0x9e>
    80025956:	00048d1b          	sext.w	s10,s1
        if (rw_clus(entry->cur_clus, 0, user_dst, dst, off % fat.byts_per_clus, m) != m) {
    8002595a:	87ea                	mv	a5,s10
    8002595c:	86d6                	mv	a3,s5
    8002595e:	865e                	mv	a2,s7
    80025960:	4581                	li	a1,0
    80025962:	10ca2503          	lw	a0,268(s4)
    80025966:	00000097          	auipc	ra,0x0
    8002596a:	a7e080e7          	jalr	-1410(ra) # 800253e4 <rw_clus>
    8002596e:	2501                	sext.w	a0,a0
    80025970:	04ad1863          	bne	s10,a0,800259c0 <eread+0xd0>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025974:	013489bb          	addw	s3,s1,s3
    80025978:	0124893b          	addw	s2,s1,s2
    8002597c:	1482                	slli	s1,s1,0x20
    8002597e:	9081                	srli	s1,s1,0x20
    80025980:	9aa6                	add	s5,s5,s1
    80025982:	10ca2783          	lw	a5,268(s4)
    80025986:	02fc6d63          	bltu	s8,a5,800259c0 <eread+0xd0>
    8002598a:	0369fb63          	bgeu	s3,s6,800259c0 <eread+0xd0>
        reloc_clus(entry, off, 0);
    8002598e:	4601                	li	a2,0
    80025990:	85ca                	mv	a1,s2
    80025992:	8552                	mv	a0,s4
    80025994:	00000097          	auipc	ra,0x0
    80025998:	948080e7          	jalr	-1720(ra) # 800252dc <reloc_clus>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    8002599c:	00cca783          	lw	a5,12(s9)
    800259a0:	02f976bb          	remuw	a3,s2,a5
    800259a4:	0006871b          	sext.w	a4,a3
    800259a8:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    800259aa:	413b06bb          	subw	a3,s6,s3
    800259ae:	84b6                	mv	s1,a3
    800259b0:	2681                	sext.w	a3,a3
    800259b2:	0007861b          	sext.w	a2,a5
    800259b6:	fad670e3          	bgeu	a2,a3,80025956 <eread+0x66>
    800259ba:	84be                	mv	s1,a5
    800259bc:	bf69                	j	80025956 <eread+0x66>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    800259be:	4981                	li	s3,0
    return tot;
    800259c0:	0009851b          	sext.w	a0,s3
}
    800259c4:	60e6                	ld	ra,88(sp)
    800259c6:	6446                	ld	s0,80(sp)
    800259c8:	64a6                	ld	s1,72(sp)
    800259ca:	6906                	ld	s2,64(sp)
    800259cc:	79e2                	ld	s3,56(sp)
    800259ce:	7a42                	ld	s4,48(sp)
    800259d0:	7aa2                	ld	s5,40(sp)
    800259d2:	7b02                	ld	s6,32(sp)
    800259d4:	6be2                	ld	s7,24(sp)
    800259d6:	6c42                	ld	s8,16(sp)
    800259d8:	6ca2                	ld	s9,8(sp)
    800259da:	6d02                	ld	s10,0(sp)
    800259dc:	6125                	addi	sp,sp,96
    800259de:	8082                	ret
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    800259e0:	89da                	mv	s3,s6
    800259e2:	bff9                	j	800259c0 <eread+0xd0>
        return 0;
    800259e4:	4501                	li	a0,0
}
    800259e6:	8082                	ret

00000000800259e8 <ewrite>:
    if (off > entry->file_size || off + n < off || (uint64)off + n > 0xffffffff
    800259e8:	10852783          	lw	a5,264(a0)
    800259ec:	0ed7e463          	bltu	a5,a3,80025ad4 <ewrite+0xec>
{
    800259f0:	711d                	addi	sp,sp,-96
    800259f2:	ec86                	sd	ra,88(sp)
    800259f4:	e8a2                	sd	s0,80(sp)
    800259f6:	e4a6                	sd	s1,72(sp)
    800259f8:	e0ca                	sd	s2,64(sp)
    800259fa:	fc4e                	sd	s3,56(sp)
    800259fc:	f852                	sd	s4,48(sp)
    800259fe:	f456                	sd	s5,40(sp)
    80025a00:	f05a                	sd	s6,32(sp)
    80025a02:	ec5e                	sd	s7,24(sp)
    80025a04:	e862                	sd	s8,16(sp)
    80025a06:	e466                	sd	s9,8(sp)
    80025a08:	1080                	addi	s0,sp,96
    80025a0a:	8aaa                	mv	s5,a0
    80025a0c:	8bae                	mv	s7,a1
    80025a0e:	8a32                	mv	s4,a2
    80025a10:	8936                	mv	s2,a3
    80025a12:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (uint64)off + n > 0xffffffff
    80025a14:	00e687bb          	addw	a5,a3,a4
    80025a18:	0cd7e063          	bltu	a5,a3,80025ad8 <ewrite+0xf0>
    80025a1c:	02069793          	slli	a5,a3,0x20
    80025a20:	9381                	srli	a5,a5,0x20
    80025a22:	1702                	slli	a4,a4,0x20
    80025a24:	9301                	srli	a4,a4,0x20
    80025a26:	97ba                	add	a5,a5,a4
    80025a28:	577d                	li	a4,-1
    80025a2a:	9301                	srli	a4,a4,0x20
    80025a2c:	0af76863          	bltu	a4,a5,80025adc <ewrite+0xf4>
        || (entry->attribute & ATTR_READ_ONLY)) {
    80025a30:	10054783          	lbu	a5,256(a0)
    80025a34:	8b85                	andi	a5,a5,1
    80025a36:	e7cd                	bnez	a5,80025ae0 <ewrite+0xf8>
    if (entry->first_clus == 0) {   // so file_size if 0 too, which requests off == 0
    80025a38:	10452783          	lw	a5,260(a0)
    80025a3c:	cb89                	beqz	a5,80025a4e <ewrite+0x66>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025a3e:	080b0963          	beqz	s6,80025ad0 <ewrite+0xe8>
    80025a42:	4981                	li	s3,0
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025a44:	0001cc17          	auipc	s8,0x1c
    80025a48:	9e4c0c13          	addi	s8,s8,-1564 # 80041428 <fat>
    80025a4c:	a891                	j	80025aa0 <ewrite+0xb8>
        entry->cur_clus = entry->first_clus = alloc_clus(entry->dev);
    80025a4e:	11454503          	lbu	a0,276(a0)
    80025a52:	fffff097          	auipc	ra,0xfffff
    80025a56:	6ca080e7          	jalr	1738(ra) # 8002511c <alloc_clus>
    80025a5a:	2501                	sext.w	a0,a0
    80025a5c:	10aaa223          	sw	a0,260(s5)
    80025a60:	10aaa623          	sw	a0,268(s5)
        entry->clus_cnt = 0;
    80025a64:	100aa823          	sw	zero,272(s5)
        entry->dirty = 1;
    80025a68:	4785                	li	a5,1
    80025a6a:	10fa8aa3          	sb	a5,277(s5)
    80025a6e:	bfc1                	j	80025a3e <ewrite+0x56>
    80025a70:	00048c9b          	sext.w	s9,s1
        if (rw_clus(entry->cur_clus, 1, user_src, src, off % fat.byts_per_clus, m) != m) {
    80025a74:	87e6                	mv	a5,s9
    80025a76:	86d2                	mv	a3,s4
    80025a78:	865e                	mv	a2,s7
    80025a7a:	4585                	li	a1,1
    80025a7c:	10caa503          	lw	a0,268(s5)
    80025a80:	00000097          	auipc	ra,0x0
    80025a84:	964080e7          	jalr	-1692(ra) # 800253e4 <rw_clus>
    80025a88:	2501                	sext.w	a0,a0
    80025a8a:	04ac9d63          	bne	s9,a0,80025ae4 <ewrite+0xfc>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025a8e:	013489bb          	addw	s3,s1,s3
    80025a92:	0124893b          	addw	s2,s1,s2
    80025a96:	1482                	slli	s1,s1,0x20
    80025a98:	9081                	srli	s1,s1,0x20
    80025a9a:	9a26                	add	s4,s4,s1
    80025a9c:	0569f463          	bgeu	s3,s6,80025ae4 <ewrite+0xfc>
        reloc_clus(entry, off, 1);
    80025aa0:	4605                	li	a2,1
    80025aa2:	85ca                	mv	a1,s2
    80025aa4:	8556                	mv	a0,s5
    80025aa6:	00000097          	auipc	ra,0x0
    80025aaa:	836080e7          	jalr	-1994(ra) # 800252dc <reloc_clus>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025aae:	00cc2783          	lw	a5,12(s8)
    80025ab2:	02f976bb          	remuw	a3,s2,a5
    80025ab6:	0006871b          	sext.w	a4,a3
    80025aba:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    80025abc:	413b06bb          	subw	a3,s6,s3
    80025ac0:	84b6                	mv	s1,a3
    80025ac2:	2681                	sext.w	a3,a3
    80025ac4:	0007861b          	sext.w	a2,a5
    80025ac8:	fad674e3          	bgeu	a2,a3,80025a70 <ewrite+0x88>
    80025acc:	84be                	mv	s1,a5
    80025ace:	b74d                	j	80025a70 <ewrite+0x88>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025ad0:	89da                	mv	s3,s6
    80025ad2:	a015                	j	80025af6 <ewrite+0x10e>
        return -1;
    80025ad4:	557d                	li	a0,-1
}
    80025ad6:	8082                	ret
        return -1;
    80025ad8:	557d                	li	a0,-1
    80025ada:	a005                	j	80025afa <ewrite+0x112>
    80025adc:	557d                	li	a0,-1
    80025ade:	a831                	j	80025afa <ewrite+0x112>
    80025ae0:	557d                	li	a0,-1
    80025ae2:	a821                	j	80025afa <ewrite+0x112>
        if(off > entry->file_size) {
    80025ae4:	108aa783          	lw	a5,264(s5)
    80025ae8:	0127f763          	bgeu	a5,s2,80025af6 <ewrite+0x10e>
            entry->file_size = off;
    80025aec:	112aa423          	sw	s2,264(s5)
            entry->dirty = 1;
    80025af0:	4785                	li	a5,1
    80025af2:	10fa8aa3          	sb	a5,277(s5)
    return tot;
    80025af6:	0009851b          	sext.w	a0,s3
}
    80025afa:	60e6                	ld	ra,88(sp)
    80025afc:	6446                	ld	s0,80(sp)
    80025afe:	64a6                	ld	s1,72(sp)
    80025b00:	6906                	ld	s2,64(sp)
    80025b02:	79e2                	ld	s3,56(sp)
    80025b04:	7a42                	ld	s4,48(sp)
    80025b06:	7aa2                	ld	s5,40(sp)
    80025b08:	7b02                	ld	s6,32(sp)
    80025b0a:	6be2                	ld	s7,24(sp)
    80025b0c:	6c42                	ld	s8,16(sp)
    80025b0e:	6ca2                	ld	s9,8(sp)
    80025b10:	6125                	addi	sp,sp,96
    80025b12:	8082                	ret

0000000080025b14 <formatname>:
{
    80025b14:	7179                	addi	sp,sp,-48
    80025b16:	f406                	sd	ra,40(sp)
    80025b18:	f022                	sd	s0,32(sp)
    80025b1a:	ec26                	sd	s1,24(sp)
    80025b1c:	e84a                	sd	s2,16(sp)
    80025b1e:	e44e                	sd	s3,8(sp)
    80025b20:	e052                	sd	s4,0(sp)
    80025b22:	1800                	addi	s0,sp,48
    80025b24:	84aa                	mv	s1,a0
    while (*name == ' ' || *name == '.') { name++; }
    80025b26:	02000793          	li	a5,32
    80025b2a:	02e00713          	li	a4,46
    80025b2e:	a011                	j	80025b32 <formatname+0x1e>
    80025b30:	0485                	addi	s1,s1,1
    80025b32:	0004c583          	lbu	a1,0(s1)
    80025b36:	fef58de3          	beq	a1,a5,80025b30 <formatname+0x1c>
    80025b3a:	fee58be3          	beq	a1,a4,80025b30 <formatname+0x1c>
    for (p = name; *p; p++) {
    80025b3e:	c1b9                	beqz	a1,80025b84 <formatname+0x70>
    80025b40:	8926                	mv	s2,s1
        if (c < 0x20 || strchr(illegal, c)) {
    80025b42:	49fd                	li	s3,31
    80025b44:	00009a17          	auipc	s4,0x9
    80025b48:	94ca0a13          	addi	s4,s4,-1716 # 8002e490 <illegal.1>
    80025b4c:	02b9fe63          	bgeu	s3,a1,80025b88 <formatname+0x74>
    80025b50:	8552                	mv	a0,s4
    80025b52:	ffffb097          	auipc	ra,0xffffb
    80025b56:	e52080e7          	jalr	-430(ra) # 800209a4 <strchr>
    80025b5a:	e121                	bnez	a0,80025b9a <formatname+0x86>
    for (p = name; *p; p++) {
    80025b5c:	0905                	addi	s2,s2,1
    80025b5e:	00094583          	lbu	a1,0(s2)
    80025b62:	f5ed                	bnez	a1,80025b4c <formatname+0x38>
        if (*p != ' ') {
    80025b64:	02000693          	li	a3,32
    80025b68:	874a                	mv	a4,s2
    while (p-- > name) {
    80025b6a:	0124fb63          	bgeu	s1,s2,80025b80 <formatname+0x6c>
        if (*p != ' ') {
    80025b6e:	197d                	addi	s2,s2,-1
    80025b70:	00094783          	lbu	a5,0(s2)
    80025b74:	fed78ae3          	beq	a5,a3,80025b68 <formatname+0x54>
            p[1] = '\0';
    80025b78:	00070023          	sb	zero,0(a4)
            break;
    80025b7c:	8526                	mv	a0,s1
    80025b7e:	a031                	j	80025b8a <formatname+0x76>
    80025b80:	8526                	mv	a0,s1
    80025b82:	a021                	j	80025b8a <formatname+0x76>
    for (p = name; *p; p++) {
    80025b84:	8526                	mv	a0,s1
    80025b86:	a011                	j	80025b8a <formatname+0x76>
            return 0;
    80025b88:	4501                	li	a0,0
}
    80025b8a:	70a2                	ld	ra,40(sp)
    80025b8c:	7402                	ld	s0,32(sp)
    80025b8e:	64e2                	ld	s1,24(sp)
    80025b90:	6942                	ld	s2,16(sp)
    80025b92:	69a2                	ld	s3,8(sp)
    80025b94:	6a02                	ld	s4,0(sp)
    80025b96:	6145                	addi	sp,sp,48
    80025b98:	8082                	ret
            return 0;
    80025b9a:	4501                	li	a0,0
    80025b9c:	b7fd                	j	80025b8a <formatname+0x76>

0000000080025b9e <cal_checksum>:
{
    80025b9e:	1141                	addi	sp,sp,-16
    80025ba0:	e422                	sd	s0,8(sp)
    80025ba2:	0800                	addi	s0,sp,16
    80025ba4:	87aa                	mv	a5,a0
    for (int i = CHAR_SHORT_NAME; i != 0; i--) {
    80025ba6:	00b50613          	addi	a2,a0,11
    uint8 sum = 0;
    80025baa:	4501                	li	a0,0
        sum = ((sum & 1) ? 0x80 : 0) + (sum >> 1) + *shortname++;
    80025bac:	0075171b          	slliw	a4,a0,0x7
    80025bb0:	0785                	addi	a5,a5,1
    80025bb2:	0015551b          	srliw	a0,a0,0x1
    80025bb6:	fff7c683          	lbu	a3,-1(a5) # fffffff <_start-0x70020001>
    80025bba:	9d35                	addw	a0,a0,a3
    80025bbc:	953a                	add	a0,a0,a4
    80025bbe:	0ff57513          	andi	a0,a0,255
    for (int i = CHAR_SHORT_NAME; i != 0; i--) {
    80025bc2:	fef615e3          	bne	a2,a5,80025bac <cal_checksum+0xe>
}
    80025bc6:	6422                	ld	s0,8(sp)
    80025bc8:	0141                	addi	sp,sp,16
    80025bca:	8082                	ret

0000000080025bcc <emake>:
{
    80025bcc:	7131                	addi	sp,sp,-192
    80025bce:	fd06                	sd	ra,184(sp)
    80025bd0:	f922                	sd	s0,176(sp)
    80025bd2:	f526                	sd	s1,168(sp)
    80025bd4:	f14a                	sd	s2,160(sp)
    80025bd6:	ed4e                	sd	s3,152(sp)
    80025bd8:	e952                	sd	s4,144(sp)
    80025bda:	e556                	sd	s5,136(sp)
    80025bdc:	e15a                	sd	s6,128(sp)
    80025bde:	fcde                	sd	s7,120(sp)
    80025be0:	f8e2                	sd	s8,112(sp)
    80025be2:	f4e6                	sd	s9,104(sp)
    80025be4:	f0ea                	sd	s10,96(sp)
    80025be6:	ecee                	sd	s11,88(sp)
    80025be8:	0180                	addi	s0,sp,192
    if (!(dp->attribute & ATTR_DIRECTORY))
    80025bea:	10054783          	lbu	a5,256(a0)
    80025bee:	8bc1                	andi	a5,a5,16
    80025bf0:	c3d5                	beqz	a5,80025c94 <emake+0xc8>
    80025bf2:	8b2a                	mv	s6,a0
    80025bf4:	8d2e                	mv	s10,a1
    80025bf6:	8cb2                	mv	s9,a2
    if (off % sizeof(union dentry))
    80025bf8:	01f67793          	andi	a5,a2,31
    80025bfc:	e7c5                	bnez	a5,80025ca4 <emake+0xd8>
    memset(&de, 0, sizeof(de));
    80025bfe:	02000613          	li	a2,32
    80025c02:	4581                	li	a1,0
    80025c04:	f7040513          	addi	a0,s0,-144
    80025c08:	ffffb097          	auipc	ra,0xffffb
    80025c0c:	b46080e7          	jalr	-1210(ra) # 8002074e <memset>
    if (off <= 32) {
    80025c10:	02000793          	li	a5,32
    80025c14:	0b97ec63          	bltu	a5,s9,80025ccc <emake+0x100>
        if (off == 0) {
    80025c18:	080c9e63          	bnez	s9,80025cb4 <emake+0xe8>
            strncpy(de.sne.name, ".          ", sizeof(de.sne.name));
    80025c1c:	462d                	li	a2,11
    80025c1e:	00006597          	auipc	a1,0x6
    80025c22:	f0a58593          	addi	a1,a1,-246 # 8002bb28 <digits+0x8a0>
    80025c26:	f7040513          	addi	a0,s0,-144
    80025c2a:	ffffb097          	auipc	ra,0xffffb
    80025c2e:	c38080e7          	jalr	-968(ra) # 80020862 <strncpy>
        de.sne.attr = ATTR_DIRECTORY;
    80025c32:	47c1                	li	a5,16
    80025c34:	f6f40da3          	sb	a5,-133(s0)
        de.sne.fst_clus_hi = (uint16)(ep->first_clus >> 16);        // first clus high 16 bits
    80025c38:	104d2783          	lw	a5,260(s10) # fffffffffffff104 <kernel_end+0xffffffff7ffb9104>
    80025c3c:	0107d71b          	srliw	a4,a5,0x10
    80025c40:	f8e41223          	sh	a4,-124(s0)
        de.sne.fst_clus_lo = (uint16)(ep->first_clus & 0xffff);       // low 16 bits
    80025c44:	f8f41523          	sh	a5,-118(s0)
        de.sne.file_size = 0;                                       // filesize is updated in eupdate()
    80025c48:	f8042623          	sw	zero,-116(s0)
        off = reloc_clus(dp, off, 1);
    80025c4c:	4605                	li	a2,1
    80025c4e:	85e6                	mv	a1,s9
    80025c50:	855a                	mv	a0,s6
    80025c52:	fffff097          	auipc	ra,0xfffff
    80025c56:	68a080e7          	jalr	1674(ra) # 800252dc <reloc_clus>
        rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    80025c5a:	02000793          	li	a5,32
    80025c5e:	0005071b          	sext.w	a4,a0
    80025c62:	f7040693          	addi	a3,s0,-144
    80025c66:	4601                	li	a2,0
    80025c68:	4585                	li	a1,1
    80025c6a:	10cb2503          	lw	a0,268(s6)
    80025c6e:	fffff097          	auipc	ra,0xfffff
    80025c72:	776080e7          	jalr	1910(ra) # 800253e4 <rw_clus>
}
    80025c76:	70ea                	ld	ra,184(sp)
    80025c78:	744a                	ld	s0,176(sp)
    80025c7a:	74aa                	ld	s1,168(sp)
    80025c7c:	790a                	ld	s2,160(sp)
    80025c7e:	69ea                	ld	s3,152(sp)
    80025c80:	6a4a                	ld	s4,144(sp)
    80025c82:	6aaa                	ld	s5,136(sp)
    80025c84:	6b0a                	ld	s6,128(sp)
    80025c86:	7be6                	ld	s7,120(sp)
    80025c88:	7c46                	ld	s8,112(sp)
    80025c8a:	7ca6                	ld	s9,104(sp)
    80025c8c:	7d06                	ld	s10,96(sp)
    80025c8e:	6de6                	ld	s11,88(sp)
    80025c90:	6129                	addi	sp,sp,192
    80025c92:	8082                	ret
        panic("emake: not dir");
    80025c94:	00006517          	auipc	a0,0x6
    80025c98:	e6c50513          	addi	a0,a0,-404 # 8002bb00 <digits+0x878>
    80025c9c:	ffffa097          	auipc	ra,0xffffa
    80025ca0:	4a6080e7          	jalr	1190(ra) # 80020142 <panic>
        panic("emake: not aligned");
    80025ca4:	00006517          	auipc	a0,0x6
    80025ca8:	e6c50513          	addi	a0,a0,-404 # 8002bb10 <digits+0x888>
    80025cac:	ffffa097          	auipc	ra,0xffffa
    80025cb0:	496080e7          	jalr	1174(ra) # 80020142 <panic>
            strncpy(de.sne.name, "..         ", sizeof(de.sne.name));
    80025cb4:	462d                	li	a2,11
    80025cb6:	00006597          	auipc	a1,0x6
    80025cba:	e8258593          	addi	a1,a1,-382 # 8002bb38 <digits+0x8b0>
    80025cbe:	f7040513          	addi	a0,s0,-144
    80025cc2:	ffffb097          	auipc	ra,0xffffb
    80025cc6:	ba0080e7          	jalr	-1120(ra) # 80020862 <strncpy>
    80025cca:	b7a5                	j	80025c32 <emake+0x66>
        int entcnt = (strlen(ep->filename) + CHAR_LONG_NAME - 1) / CHAR_LONG_NAME;   // count of l-n-entries, rounds up
    80025ccc:	896a                	mv	s2,s10
    80025cce:	856a                	mv	a0,s10
    80025cd0:	ffffb097          	auipc	ra,0xffffb
    80025cd4:	c02080e7          	jalr	-1022(ra) # 800208d2 <strlen>
    80025cd8:	f4a43823          	sd	a0,-176(s0)
    80025cdc:	00c5071b          	addiw	a4,a0,12
    80025ce0:	47b5                	li	a5,13
    80025ce2:	02f747bb          	divw	a5,a4,a5
    80025ce6:	f4f42c23          	sw	a5,-168(s0)
    80025cea:	00078d9b          	sext.w	s11,a5
        memset(shortname, 0, sizeof(shortname));
    80025cee:	4631                	li	a2,12
    80025cf0:	4581                	li	a1,0
    80025cf2:	f6040513          	addi	a0,s0,-160
    80025cf6:	ffffb097          	auipc	ra,0xffffb
    80025cfa:	a58080e7          	jalr	-1448(ra) # 8002074e <memset>
    for (int j = strlen(name) - 1; j >= 0; j--) {
    80025cfe:	856a                	mv	a0,s10
    80025d00:	ffffb097          	auipc	ra,0xffffb
    80025d04:	bd2080e7          	jalr	-1070(ra) # 800208d2 <strlen>
    80025d08:	fff5079b          	addiw	a5,a0,-1
    80025d0c:	0207cf63          	bltz	a5,80025d4a <emake+0x17e>
    80025d10:	97ea                	add	a5,a5,s10
    80025d12:	ffed0693          	addi	a3,s10,-2
    80025d16:	96aa                	add	a3,a3,a0
    80025d18:	fff5071b          	addiw	a4,a0,-1
    80025d1c:	1702                	slli	a4,a4,0x20
    80025d1e:	9301                	srli	a4,a4,0x20
    80025d20:	8e99                	sub	a3,a3,a4
        if (name[j] == '.') {
    80025d22:	02e00613          	li	a2,46
    80025d26:	89be                	mv	s3,a5
    80025d28:	0007c703          	lbu	a4,0(a5)
    80025d2c:	00c70663          	beq	a4,a2,80025d38 <emake+0x16c>
    for (int j = strlen(name) - 1; j >= 0; j--) {
    80025d30:	17fd                	addi	a5,a5,-1
    80025d32:	fed79ae3          	bne	a5,a3,80025d26 <emake+0x15a>
    char c, *p = name;
    80025d36:	89ea                	mv	s3,s10
        shortname[i++] = c;
    80025d38:	4481                	li	s1,0
        if (i == 8 && p) {
    80025d3a:	4aa1                	li	s5,8
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025d3c:	4ba9                	li	s7,10
        if (c >= 'a' && c <= 'z') {
    80025d3e:	4c65                	li	s8,25
                memset(shortname + i, ' ', 8 - i);
    80025d40:	f6040793          	addi	a5,s0,-160
    80025d44:	f4f43423          	sd	a5,-184(s0)
    80025d48:	a0f9                	j	80025e16 <emake+0x24a>
    char c, *p = name;
    80025d4a:	89ea                	mv	s3,s10
    80025d4c:	b7f5                	j	80025d38 <emake+0x16c>
        if (i == 8 && p) {
    80025d4e:	22098363          	beqz	s3,80025f74 <emake+0x3a8>
            if (p + 1 < name) { break; }            // no '.'
    80025d52:	0985                	addi	s3,s3,1
    80025d54:	0949f863          	bgeu	s3,s4,80025de4 <emake+0x218>
    80025d58:	f6040793          	addi	a5,s0,-160
    80025d5c:	97a6                	add	a5,a5,s1
        shortname[i++] = ' ';
    80025d5e:	02000693          	li	a3,32
    while (i < CHAR_SHORT_NAME) {
    80025d62:	4729                	li	a4,10
        shortname[i++] = ' ';
    80025d64:	2485                	addiw	s1,s1,1
    80025d66:	00d78023          	sb	a3,0(a5)
    while (i < CHAR_SHORT_NAME) {
    80025d6a:	0785                	addi	a5,a5,1
    80025d6c:	fe975ce3          	bge	a4,s1,80025d64 <emake+0x198>
        de.lne.checksum = cal_checksum((uchar *)shortname);
    80025d70:	f6040513          	addi	a0,s0,-160
    80025d74:	00000097          	auipc	ra,0x0
    80025d78:	e2a080e7          	jalr	-470(ra) # 80025b9e <cal_checksum>
    80025d7c:	f6a40ea3          	sb	a0,-131(s0)
        de.lne.attr = ATTR_LONG_NAME;
    80025d80:	47bd                	li	a5,15
    80025d82:	f6f40da3          	sb	a5,-133(s0)
        for (int i = entcnt; i > 0; i--) {
    80025d86:	f5043783          	ld	a5,-176(s0)
    80025d8a:	10f05163          	blez	a5,80025e8c <emake+0x2c0>
    80025d8e:	f5842783          	lw	a5,-168(s0)
    80025d92:	37fd                	addiw	a5,a5,-1
    80025d94:	f4f42423          	sw	a5,-184(s0)
    80025d98:	00179b9b          	slliw	s7,a5,0x1
    80025d9c:	00fb8bbb          	addw	s7,s7,a5
    80025da0:	002b9b9b          	slliw	s7,s7,0x2
    80025da4:	00fb8bbb          	addw	s7,s7,a5
    80025da8:	9bea                	add	s7,s7,s10
    80025daa:	8a6e                	mv	s4,s11
    80025dac:	8c66                	mv	s8,s9
            uint8 *w = (uint8 *)de.lne.name1;
    80025dae:	f7140793          	addi	a5,s0,-143
    80025db2:	f4f43c23          	sd	a5,-168(s0)
                    *w++ = 0xff;            // on k210, unaligned reading is illegal
    80025db6:	597d                	li	s2,-1
                    case 5:     w = (uint8 *)de.lne.name2; break;
    80025db8:	f7e40a93          	addi	s5,s0,-130
                switch (j) {
    80025dbc:	44ad                	li	s1,11
    80025dbe:	f8c40993          	addi	s3,s0,-116
    80025dc2:	aa51                	j	80025f56 <emake+0x38a>
            if (name > p) {                    // last '.'
    80025dc4:	0549f663          	bgeu	s3,s4,80025e10 <emake+0x244>
                memset(shortname + i, ' ', 8 - i);
    80025dc8:	47a1                	li	a5,8
    80025dca:	4097863b          	subw	a2,a5,s1
    80025dce:	02000593          	li	a1,32
    80025dd2:	f4843783          	ld	a5,-184(s0)
    80025dd6:	00978533          	add	a0,a5,s1
    80025dda:	ffffb097          	auipc	ra,0xffffb
    80025dde:	974080e7          	jalr	-1676(ra) # 8002074e <memset>
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025de2:	89d2                	mv	s3,s4
        shortname[i++] = c;
    80025de4:	8a4e                	mv	s4,s3
    80025de6:	84d6                	mv	s1,s5
    80025de8:	4981                	li	s3,0
    80025dea:	a02d                	j	80025e14 <emake+0x248>
            if (strchr(illegal, c) != NULL) {
    80025dec:	85ca                	mv	a1,s2
    80025dee:	00008517          	auipc	a0,0x8
    80025df2:	6b250513          	addi	a0,a0,1714 # 8002e4a0 <illegal.0>
    80025df6:	ffffb097          	auipc	ra,0xffffb
    80025dfa:	bae080e7          	jalr	-1106(ra) # 800209a4 <strchr>
    80025dfe:	c119                	beqz	a0,80025e04 <emake+0x238>
                c = '_';
    80025e00:	05f00913          	li	s2,95
        shortname[i++] = c;
    80025e04:	f9040793          	addi	a5,s0,-112
    80025e08:	97a6                	add	a5,a5,s1
    80025e0a:	fd278823          	sb	s2,-48(a5)
    80025e0e:	2485                	addiw	s1,s1,1
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025e10:	f69bc0e3          	blt	s7,s1,80025d70 <emake+0x1a4>
        shortname[i++] = c;
    80025e14:	8952                	mv	s2,s4
    while (i < CHAR_SHORT_NAME && (c = *name++)) {
    80025e16:	00190a13          	addi	s4,s2,1
    80025e1a:	00094903          	lbu	s2,0(s2)
    80025e1e:	02090663          	beqz	s2,80025e4a <emake+0x27e>
        if (i == 8 && p) {
    80025e22:	f35486e3          	beq	s1,s5,80025d4e <emake+0x182>
        if (c == ' ') { continue; }
    80025e26:	02000793          	li	a5,32
    80025e2a:	fef903e3          	beq	s2,a5,80025e10 <emake+0x244>
        if (c == '.') {
    80025e2e:	02e00793          	li	a5,46
    80025e32:	f8f909e3          	beq	s2,a5,80025dc4 <emake+0x1f8>
        if (c >= 'a' && c <= 'z') {
    80025e36:	f9f9079b          	addiw	a5,s2,-97
    80025e3a:	0ff7f793          	andi	a5,a5,255
    80025e3e:	fafc67e3          	bltu	s8,a5,80025dec <emake+0x220>
            c += 'A' - 'a';
    80025e42:	3901                	addiw	s2,s2,-32
    80025e44:	0ff97913          	andi	s2,s2,255
    80025e48:	bf75                	j	80025e04 <emake+0x238>
    while (i < CHAR_SHORT_NAME) {
    80025e4a:	47a9                	li	a5,10
    80025e4c:	f097d6e3          	bge	a5,s1,80025d58 <emake+0x18c>
    80025e50:	b705                	j	80025d70 <emake+0x1a4>
                de.lne.order |= LAST_LONG_ENTRY;
    80025e52:	0407e793          	ori	a5,a5,64
    80025e56:	f6f40823          	sb	a5,-144(s0)
    80025e5a:	a221                	j	80025f62 <emake+0x396>
                    if ((*w++ = *p++) == 0) {
    80025e5c:	0005c683          	lbu	a3,0(a1)
    80025e60:	00d78023          	sb	a3,0(a5)
                        end = 1;
    80025e64:	0016b693          	seqz	a3,a3
                    *w++ = 0;
    80025e68:	000780a3          	sb	zero,1(a5)
    80025e6c:	0789                	addi	a5,a5,2
                    if ((*w++ = *p++) == 0) {
    80025e6e:	0585                	addi	a1,a1,1
    80025e70:	a04d                	j	80025f12 <emake+0x346>
    80025e72:	020c8c9b          	addiw	s9,s9,32
            off += sizeof(de);
    80025e76:	4781                	li	a5,0
    80025e78:	f5043703          	ld	a4,-176(s0)
    80025e7c:	00e05663          	blez	a4,80025e88 <emake+0x2bc>
    80025e80:	f4842783          	lw	a5,-184(s0)
    80025e84:	0057979b          	slliw	a5,a5,0x5
    80025e88:	01978cbb          	addw	s9,a5,s9
        memset(&de, 0, sizeof(de));
    80025e8c:	02000613          	li	a2,32
    80025e90:	4581                	li	a1,0
    80025e92:	f7040493          	addi	s1,s0,-144
    80025e96:	8526                	mv	a0,s1
    80025e98:	ffffb097          	auipc	ra,0xffffb
    80025e9c:	8b6080e7          	jalr	-1866(ra) # 8002074e <memset>
        strncpy(de.sne.name, shortname, sizeof(de.sne.name));
    80025ea0:	462d                	li	a2,11
    80025ea2:	f6040593          	addi	a1,s0,-160
    80025ea6:	8526                	mv	a0,s1
    80025ea8:	ffffb097          	auipc	ra,0xffffb
    80025eac:	9ba080e7          	jalr	-1606(ra) # 80020862 <strncpy>
        de.sne.attr = ep->attribute;
    80025eb0:	100d4783          	lbu	a5,256(s10)
    80025eb4:	f6f40da3          	sb	a5,-133(s0)
        de.sne.fst_clus_hi = (uint16)(ep->first_clus >> 16);      // first clus high 16 bits
    80025eb8:	104d2783          	lw	a5,260(s10)
    80025ebc:	0107d71b          	srliw	a4,a5,0x10
    80025ec0:	f8e41223          	sh	a4,-124(s0)
        de.sne.fst_clus_lo = (uint16)(ep->first_clus & 0xffff);     // low 16 bits
    80025ec4:	f8f41523          	sh	a5,-118(s0)
        de.sne.file_size = ep->file_size;                         // filesize is updated in eupdate()
    80025ec8:	108d2783          	lw	a5,264(s10)
    80025ecc:	f8f42623          	sw	a5,-116(s0)
        off = reloc_clus(dp, off, 1);
    80025ed0:	4605                	li	a2,1
    80025ed2:	85e6                	mv	a1,s9
    80025ed4:	855a                	mv	a0,s6
    80025ed6:	fffff097          	auipc	ra,0xfffff
    80025eda:	406080e7          	jalr	1030(ra) # 800252dc <reloc_clus>
        rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    80025ede:	02000793          	li	a5,32
    80025ee2:	0005071b          	sext.w	a4,a0
    80025ee6:	86a6                	mv	a3,s1
    80025ee8:	4601                	li	a2,0
    80025eea:	4585                	li	a1,1
    80025eec:	10cb2503          	lw	a0,268(s6)
    80025ef0:	fffff097          	auipc	ra,0xfffff
    80025ef4:	4f4080e7          	jalr	1268(ra) # 800253e4 <rw_clus>
}
    80025ef8:	bbbd                	j	80025c76 <emake+0xaa>
                    case 5:     w = (uint8 *)de.lne.name2; break;
    80025efa:	87d6                	mv	a5,s5
    80025efc:	a011                	j	80025f00 <emake+0x334>
                switch (j) {
    80025efe:	87ce                	mv	a5,s3
            for (int j = 1; j <= CHAR_LONG_NAME; j++) {
    80025f00:	2705                	addiw	a4,a4,1
    80025f02:	fff7061b          	addiw	a2,a4,-1
                if (end) {
    80025f06:	dab9                	beqz	a3,80025e5c <emake+0x290>
                    *w++ = 0xff;            // on k210, unaligned reading is illegal
    80025f08:	01278023          	sb	s2,0(a5)
                    *w++ = 0xff;
    80025f0c:	012780a3          	sb	s2,1(a5)
    80025f10:	0789                	addi	a5,a5,2
                switch (j) {
    80025f12:	fea604e3          	beq	a2,a0,80025efa <emake+0x32e>
    80025f16:	fe9604e3          	beq	a2,s1,80025efe <emake+0x332>
            for (int j = 1; j <= CHAR_LONG_NAME; j++) {
    80025f1a:	0007061b          	sext.w	a2,a4
    80025f1e:	fec851e3          	bge	a6,a2,80025f00 <emake+0x334>
            uint off2 = reloc_clus(dp, off, 1);
    80025f22:	4605                	li	a2,1
    80025f24:	85e2                	mv	a1,s8
    80025f26:	855a                	mv	a0,s6
    80025f28:	fffff097          	auipc	ra,0xfffff
    80025f2c:	3b4080e7          	jalr	948(ra) # 800252dc <reloc_clus>
            rw_clus(dp->cur_clus, 1, 0, (uint64)&de, off2, sizeof(de));
    80025f30:	02000793          	li	a5,32
    80025f34:	0005071b          	sext.w	a4,a0
    80025f38:	f7040693          	addi	a3,s0,-144
    80025f3c:	4601                	li	a2,0
    80025f3e:	4585                	li	a1,1
    80025f40:	10cb2503          	lw	a0,268(s6)
    80025f44:	fffff097          	auipc	ra,0xfffff
    80025f48:	4a0080e7          	jalr	1184(ra) # 800253e4 <rw_clus>
            off += sizeof(de);
    80025f4c:	020c0c1b          	addiw	s8,s8,32
        for (int i = entcnt; i > 0; i--) {
    80025f50:	1bcd                	addi	s7,s7,-13
    80025f52:	f34050e3          	blez	s4,80025e72 <emake+0x2a6>
            if ((de.lne.order = i) == entcnt) {
    80025f56:	0ffa7793          	andi	a5,s4,255
    80025f5a:	eefd8ce3          	beq	s11,a5,80025e52 <emake+0x286>
    80025f5e:	f6f40823          	sb	a5,-144(s0)
            char *p = ep->filename + (i - 1) * CHAR_LONG_NAME;
    80025f62:	3a7d                	addiw	s4,s4,-1
    80025f64:	85de                	mv	a1,s7
    80025f66:	4709                	li	a4,2
            int end = 0;
    80025f68:	4681                	li	a3,0
            uint8 *w = (uint8 *)de.lne.name1;
    80025f6a:	f5843783          	ld	a5,-168(s0)
                switch (j) {
    80025f6e:	4515                	li	a0,5
            for (int j = 1; j <= CHAR_LONG_NAME; j++) {
    80025f70:	4835                	li	a6,13
    80025f72:	bf41                	j	80025f02 <emake+0x336>
        if (c == ' ') { continue; }
    80025f74:	02000793          	li	a5,32
    80025f78:	e8f90ee3          	beq	s2,a5,80025e14 <emake+0x248>
        if (c == '.') {
    80025f7c:	02e00793          	li	a5,46
    80025f80:	eaf91be3          	bne	s2,a5,80025e36 <emake+0x26a>
    80025f84:	b591                	j	80025dc8 <emake+0x1fc>

0000000080025f86 <edup>:
{
    80025f86:	1101                	addi	sp,sp,-32
    80025f88:	ec06                	sd	ra,24(sp)
    80025f8a:	e822                	sd	s0,16(sp)
    80025f8c:	e426                	sd	s1,8(sp)
    80025f8e:	1000                	addi	s0,sp,32
    80025f90:	84aa                	mv	s1,a0
    if (entry != 0) {
    80025f92:	c515                	beqz	a0,80025fbe <edup+0x38>
        acquire(&ecache.lock);
    80025f94:	0001b517          	auipc	a0,0x1b
    80025f98:	62450513          	addi	a0,a0,1572 # 800415b8 <ecache>
    80025f9c:	ffffa097          	auipc	ra,0xffffa
    80025fa0:	716080e7          	jalr	1814(ra) # 800206b2 <acquire>
        entry->ref++;
    80025fa4:	1184a783          	lw	a5,280(s1)
    80025fa8:	2785                	addiw	a5,a5,1
    80025faa:	10f4ac23          	sw	a5,280(s1)
        release(&ecache.lock);
    80025fae:	0001b517          	auipc	a0,0x1b
    80025fb2:	60a50513          	addi	a0,a0,1546 # 800415b8 <ecache>
    80025fb6:	ffffa097          	auipc	ra,0xffffa
    80025fba:	750080e7          	jalr	1872(ra) # 80020706 <release>
}
    80025fbe:	8526                	mv	a0,s1
    80025fc0:	60e2                	ld	ra,24(sp)
    80025fc2:	6442                	ld	s0,16(sp)
    80025fc4:	64a2                	ld	s1,8(sp)
    80025fc6:	6105                	addi	sp,sp,32
    80025fc8:	8082                	ret

0000000080025fca <eupdate>:
    if (!entry->dirty || entry->valid != 1) { return; }
    80025fca:	11554783          	lbu	a5,277(a0)
    80025fce:	c3e5                	beqz	a5,800260ae <eupdate+0xe4>
{
    80025fd0:	711d                	addi	sp,sp,-96
    80025fd2:	ec86                	sd	ra,88(sp)
    80025fd4:	e8a2                	sd	s0,80(sp)
    80025fd6:	e4a6                	sd	s1,72(sp)
    80025fd8:	e0ca                	sd	s2,64(sp)
    80025fda:	fc4e                	sd	s3,56(sp)
    80025fdc:	1080                	addi	s0,sp,96
    80025fde:	84aa                	mv	s1,a0
    if (!entry->dirty || entry->valid != 1) { return; }
    80025fe0:	11651703          	lh	a4,278(a0)
    80025fe4:	4785                	li	a5,1
    80025fe6:	00f70963          	beq	a4,a5,80025ff8 <eupdate+0x2e>
}
    80025fea:	60e6                	ld	ra,88(sp)
    80025fec:	6446                	ld	s0,80(sp)
    80025fee:	64a6                	ld	s1,72(sp)
    80025ff0:	6906                	ld	s2,64(sp)
    80025ff2:	79e2                	ld	s3,56(sp)
    80025ff4:	6125                	addi	sp,sp,96
    80025ff6:	8082                	ret
    uint entcnt = 0;
    80025ff8:	fc042623          	sw	zero,-52(s0)
    uint32 off = reloc_clus(entry->parent, entry->off, 0);
    80025ffc:	4601                	li	a2,0
    80025ffe:	11c52583          	lw	a1,284(a0)
    80026002:	12053503          	ld	a0,288(a0)
    80026006:	fffff097          	auipc	ra,0xfffff
    8002600a:	2d6080e7          	jalr	726(ra) # 800252dc <reloc_clus>
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64) &entcnt, off, 1);
    8002600e:	1204b803          	ld	a6,288(s1)
    80026012:	4785                	li	a5,1
    80026014:	0005071b          	sext.w	a4,a0
    80026018:	fcc40693          	addi	a3,s0,-52
    8002601c:	4601                	li	a2,0
    8002601e:	4581                	li	a1,0
    80026020:	10c82503          	lw	a0,268(a6)
    80026024:	fffff097          	auipc	ra,0xfffff
    80026028:	3c0080e7          	jalr	960(ra) # 800253e4 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    8002602c:	fcc42583          	lw	a1,-52(s0)
    80026030:	fbf5f593          	andi	a1,a1,-65
    80026034:	fcb42623          	sw	a1,-52(s0)
    off = reloc_clus(entry->parent, entry->off + (entcnt << 5), 0);
    80026038:	0055959b          	slliw	a1,a1,0x5
    8002603c:	11c4a783          	lw	a5,284(s1)
    80026040:	4601                	li	a2,0
    80026042:	9dbd                	addw	a1,a1,a5
    80026044:	1204b503          	ld	a0,288(s1)
    80026048:	fffff097          	auipc	ra,0xfffff
    8002604c:	294080e7          	jalr	660(ra) # 800252dc <reloc_clus>
    80026050:	0005099b          	sext.w	s3,a0
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64)&de, off, sizeof(de));
    80026054:	1204b503          	ld	a0,288(s1)
    80026058:	02000793          	li	a5,32
    8002605c:	874e                	mv	a4,s3
    8002605e:	fa840913          	addi	s2,s0,-88
    80026062:	86ca                	mv	a3,s2
    80026064:	4601                	li	a2,0
    80026066:	4581                	li	a1,0
    80026068:	10c52503          	lw	a0,268(a0)
    8002606c:	fffff097          	auipc	ra,0xfffff
    80026070:	378080e7          	jalr	888(ra) # 800253e4 <rw_clus>
    de.sne.fst_clus_hi = (uint16)(entry->first_clus >> 16);
    80026074:	1044a783          	lw	a5,260(s1)
    80026078:	0107d71b          	srliw	a4,a5,0x10
    8002607c:	fae41e23          	sh	a4,-68(s0)
    de.sne.fst_clus_lo = (uint16)(entry->first_clus & 0xffff);
    80026080:	fcf41123          	sh	a5,-62(s0)
    de.sne.file_size = entry->file_size;
    80026084:	1084a783          	lw	a5,264(s1)
    80026088:	fcf42223          	sw	a5,-60(s0)
    rw_clus(entry->parent->cur_clus, 1, 0, (uint64)&de, off, sizeof(de));
    8002608c:	1204b503          	ld	a0,288(s1)
    80026090:	02000793          	li	a5,32
    80026094:	874e                	mv	a4,s3
    80026096:	86ca                	mv	a3,s2
    80026098:	4601                	li	a2,0
    8002609a:	4585                	li	a1,1
    8002609c:	10c52503          	lw	a0,268(a0)
    800260a0:	fffff097          	auipc	ra,0xfffff
    800260a4:	344080e7          	jalr	836(ra) # 800253e4 <rw_clus>
    entry->dirty = 0;
    800260a8:	10048aa3          	sb	zero,277(s1)
    800260ac:	bf3d                	j	80025fea <eupdate+0x20>
    800260ae:	8082                	ret

00000000800260b0 <eremove>:
    if (entry->valid != 1) { return; }
    800260b0:	11651703          	lh	a4,278(a0)
    800260b4:	4785                	li	a5,1
    800260b6:	00f70363          	beq	a4,a5,800260bc <eremove+0xc>
    800260ba:	8082                	ret
{
    800260bc:	715d                	addi	sp,sp,-80
    800260be:	e486                	sd	ra,72(sp)
    800260c0:	e0a2                	sd	s0,64(sp)
    800260c2:	fc26                	sd	s1,56(sp)
    800260c4:	f84a                	sd	s2,48(sp)
    800260c6:	f44e                	sd	s3,40(sp)
    800260c8:	f052                	sd	s4,32(sp)
    800260ca:	ec56                	sd	s5,24(sp)
    800260cc:	0880                	addi	s0,sp,80
    800260ce:	89aa                	mv	s3,a0
    uint entcnt = 0;
    800260d0:	fa042e23          	sw	zero,-68(s0)
    uint32 off = entry->off;
    800260d4:	11c52a03          	lw	s4,284(a0)
    uint32 off2 = reloc_clus(entry->parent, off, 0);
    800260d8:	4601                	li	a2,0
    800260da:	85d2                	mv	a1,s4
    800260dc:	12053503          	ld	a0,288(a0)
    800260e0:	fffff097          	auipc	ra,0xfffff
    800260e4:	1fc080e7          	jalr	508(ra) # 800252dc <reloc_clus>
    800260e8:	0005049b          	sext.w	s1,a0
    rw_clus(entry->parent->cur_clus, 0, 0, (uint64) &entcnt, off2, 1);
    800260ec:	1209b503          	ld	a0,288(s3)
    800260f0:	4785                	li	a5,1
    800260f2:	8726                	mv	a4,s1
    800260f4:	fbc40693          	addi	a3,s0,-68
    800260f8:	4601                	li	a2,0
    800260fa:	4581                	li	a1,0
    800260fc:	10c52503          	lw	a0,268(a0)
    80026100:	fffff097          	auipc	ra,0xfffff
    80026104:	2e4080e7          	jalr	740(ra) # 800253e4 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    80026108:	fbc42783          	lw	a5,-68(s0)
    8002610c:	fbf7f793          	andi	a5,a5,-65
    80026110:	faf42e23          	sw	a5,-68(s0)
    uint8 flag = EMPTY_ENTRY;
    80026114:	5795                	li	a5,-27
    80026116:	faf40da3          	sb	a5,-69(s0)
    for (int i = 0; i <= entcnt; i++) {
    8002611a:	4901                	li	s2,0
        rw_clus(entry->parent->cur_clus, 1, 0, (uint64) &flag, off2, 1);
    8002611c:	fbb40a93          	addi	s5,s0,-69
    80026120:	1209b503          	ld	a0,288(s3)
    80026124:	4785                	li	a5,1
    80026126:	8726                	mv	a4,s1
    80026128:	86d6                	mv	a3,s5
    8002612a:	4601                	li	a2,0
    8002612c:	4585                	li	a1,1
    8002612e:	10c52503          	lw	a0,268(a0)
    80026132:	fffff097          	auipc	ra,0xfffff
    80026136:	2b2080e7          	jalr	690(ra) # 800253e4 <rw_clus>
        off += 32;
    8002613a:	020a0a1b          	addiw	s4,s4,32
        off2 = reloc_clus(entry->parent, off, 0);
    8002613e:	4601                	li	a2,0
    80026140:	85d2                	mv	a1,s4
    80026142:	1209b503          	ld	a0,288(s3)
    80026146:	fffff097          	auipc	ra,0xfffff
    8002614a:	196080e7          	jalr	406(ra) # 800252dc <reloc_clus>
    8002614e:	0005049b          	sext.w	s1,a0
    for (int i = 0; i <= entcnt; i++) {
    80026152:	0019079b          	addiw	a5,s2,1
    80026156:	0007891b          	sext.w	s2,a5
    8002615a:	fbc42703          	lw	a4,-68(s0)
    8002615e:	fd2771e3          	bgeu	a4,s2,80026120 <eremove+0x70>
    entry->valid = -1;
    80026162:	57fd                	li	a5,-1
    80026164:	10f99b23          	sh	a5,278(s3)
}
    80026168:	60a6                	ld	ra,72(sp)
    8002616a:	6406                	ld	s0,64(sp)
    8002616c:	74e2                	ld	s1,56(sp)
    8002616e:	7942                	ld	s2,48(sp)
    80026170:	79a2                	ld	s3,40(sp)
    80026172:	7a02                	ld	s4,32(sp)
    80026174:	6ae2                	ld	s5,24(sp)
    80026176:	6161                	addi	sp,sp,80
    80026178:	8082                	ret

000000008002617a <etrunc>:
{
    8002617a:	7179                	addi	sp,sp,-48
    8002617c:	f406                	sd	ra,40(sp)
    8002617e:	f022                	sd	s0,32(sp)
    80026180:	ec26                	sd	s1,24(sp)
    80026182:	e84a                	sd	s2,16(sp)
    80026184:	e44e                	sd	s3,8(sp)
    80026186:	e052                	sd	s4,0(sp)
    80026188:	1800                	addi	s0,sp,48
    8002618a:	8a2a                	mv	s4,a0
    for (uint32 clus = entry->first_clus; clus >= 2 && clus < FAT32_EOC; ) {
    8002618c:	10452483          	lw	s1,260(a0)
    80026190:	ffe4871b          	addiw	a4,s1,-2
    80026194:	100007b7          	lui	a5,0x10000
    80026198:	17d5                	addi	a5,a5,-11
    8002619a:	02e7e663          	bltu	a5,a4,800261c6 <etrunc+0x4c>
    8002619e:	89be                	mv	s3,a5
        uint32 next = read_fat(clus);
    800261a0:	0004891b          	sext.w	s2,s1
    800261a4:	8526                	mv	a0,s1
    800261a6:	fffff097          	auipc	ra,0xfffff
    800261aa:	f02080e7          	jalr	-254(ra) # 800250a8 <read_fat>
    800261ae:	0005049b          	sext.w	s1,a0
    write_fat(cluster, 0);
    800261b2:	4581                	li	a1,0
    800261b4:	854a                	mv	a0,s2
    800261b6:	fffff097          	auipc	ra,0xfffff
    800261ba:	0a6080e7          	jalr	166(ra) # 8002525c <write_fat>
    for (uint32 clus = entry->first_clus; clus >= 2 && clus < FAT32_EOC; ) {
    800261be:	ffe4879b          	addiw	a5,s1,-2
    800261c2:	fcf9ffe3          	bgeu	s3,a5,800261a0 <etrunc+0x26>
    entry->file_size = 0;
    800261c6:	100a2423          	sw	zero,264(s4)
    entry->first_clus = 0;
    800261ca:	100a2223          	sw	zero,260(s4)
    entry->dirty = 1;
    800261ce:	4785                	li	a5,1
    800261d0:	10fa0aa3          	sb	a5,277(s4)
}
    800261d4:	70a2                	ld	ra,40(sp)
    800261d6:	7402                	ld	s0,32(sp)
    800261d8:	64e2                	ld	s1,24(sp)
    800261da:	6942                	ld	s2,16(sp)
    800261dc:	69a2                	ld	s3,8(sp)
    800261de:	6a02                	ld	s4,0(sp)
    800261e0:	6145                	addi	sp,sp,48
    800261e2:	8082                	ret

00000000800261e4 <elock>:
{
    800261e4:	1141                	addi	sp,sp,-16
    800261e6:	e406                	sd	ra,8(sp)
    800261e8:	e022                	sd	s0,0(sp)
    800261ea:	0800                	addi	s0,sp,16
    if (entry == 0 || entry->ref < 1)
    800261ec:	cd19                	beqz	a0,8002620a <elock+0x26>
    800261ee:	11852783          	lw	a5,280(a0)
    800261f2:	00f05c63          	blez	a5,8002620a <elock+0x26>
    acquiresleep(&entry->lock);
    800261f6:	13850513          	addi	a0,a0,312
    800261fa:	ffffd097          	auipc	ra,0xffffd
    800261fe:	466080e7          	jalr	1126(ra) # 80023660 <acquiresleep>
}
    80026202:	60a2                	ld	ra,8(sp)
    80026204:	6402                	ld	s0,0(sp)
    80026206:	0141                	addi	sp,sp,16
    80026208:	8082                	ret
        panic("elock");
    8002620a:	00006517          	auipc	a0,0x6
    8002620e:	93e50513          	addi	a0,a0,-1730 # 8002bb48 <digits+0x8c0>
    80026212:	ffffa097          	auipc	ra,0xffffa
    80026216:	f30080e7          	jalr	-208(ra) # 80020142 <panic>

000000008002621a <eunlock>:
{
    8002621a:	1101                	addi	sp,sp,-32
    8002621c:	ec06                	sd	ra,24(sp)
    8002621e:	e822                	sd	s0,16(sp)
    80026220:	e426                	sd	s1,8(sp)
    80026222:	e04a                	sd	s2,0(sp)
    80026224:	1000                	addi	s0,sp,32
    if (entry == 0 || !holdingsleep(&entry->lock) || entry->ref < 1)
    80026226:	c90d                	beqz	a0,80026258 <eunlock+0x3e>
    80026228:	84aa                	mv	s1,a0
    8002622a:	13850913          	addi	s2,a0,312
    8002622e:	854a                	mv	a0,s2
    80026230:	ffffd097          	auipc	ra,0xffffd
    80026234:	4ca080e7          	jalr	1226(ra) # 800236fa <holdingsleep>
    80026238:	c105                	beqz	a0,80026258 <eunlock+0x3e>
    8002623a:	1184a783          	lw	a5,280(s1)
    8002623e:	00f05d63          	blez	a5,80026258 <eunlock+0x3e>
    releasesleep(&entry->lock);
    80026242:	854a                	mv	a0,s2
    80026244:	ffffd097          	auipc	ra,0xffffd
    80026248:	472080e7          	jalr	1138(ra) # 800236b6 <releasesleep>
}
    8002624c:	60e2                	ld	ra,24(sp)
    8002624e:	6442                	ld	s0,16(sp)
    80026250:	64a2                	ld	s1,8(sp)
    80026252:	6902                	ld	s2,0(sp)
    80026254:	6105                	addi	sp,sp,32
    80026256:	8082                	ret
        panic("eunlock");
    80026258:	00006517          	auipc	a0,0x6
    8002625c:	8f850513          	addi	a0,a0,-1800 # 8002bb50 <digits+0x8c8>
    80026260:	ffffa097          	auipc	ra,0xffffa
    80026264:	ee2080e7          	jalr	-286(ra) # 80020142 <panic>

0000000080026268 <eput>:
{
    80026268:	1101                	addi	sp,sp,-32
    8002626a:	ec06                	sd	ra,24(sp)
    8002626c:	e822                	sd	s0,16(sp)
    8002626e:	e426                	sd	s1,8(sp)
    80026270:	e04a                	sd	s2,0(sp)
    80026272:	1000                	addi	s0,sp,32
    80026274:	84aa                	mv	s1,a0
    acquire(&ecache.lock);
    80026276:	0001b517          	auipc	a0,0x1b
    8002627a:	34250513          	addi	a0,a0,834 # 800415b8 <ecache>
    8002627e:	ffffa097          	auipc	ra,0xffffa
    80026282:	434080e7          	jalr	1076(ra) # 800206b2 <acquire>
    if (entry != &root && entry->valid != 0 && entry->ref == 1) {
    80026286:	0001b797          	auipc	a5,0x1b
    8002628a:	1ca78793          	addi	a5,a5,458 # 80041450 <root>
    8002628e:	00f48a63          	beq	s1,a5,800262a2 <eput+0x3a>
    80026292:	11649783          	lh	a5,278(s1)
    80026296:	c791                	beqz	a5,800262a2 <eput+0x3a>
    80026298:	1184a703          	lw	a4,280(s1)
    8002629c:	4785                	li	a5,1
    8002629e:	02f70563          	beq	a4,a5,800262c8 <eput+0x60>
    entry->ref--;
    800262a2:	1184a783          	lw	a5,280(s1)
    800262a6:	37fd                	addiw	a5,a5,-1
    800262a8:	10f4ac23          	sw	a5,280(s1)
    release(&ecache.lock);
    800262ac:	0001b517          	auipc	a0,0x1b
    800262b0:	30c50513          	addi	a0,a0,780 # 800415b8 <ecache>
    800262b4:	ffffa097          	auipc	ra,0xffffa
    800262b8:	452080e7          	jalr	1106(ra) # 80020706 <release>
}
    800262bc:	60e2                	ld	ra,24(sp)
    800262be:	6442                	ld	s0,16(sp)
    800262c0:	64a2                	ld	s1,8(sp)
    800262c2:	6902                	ld	s2,0(sp)
    800262c4:	6105                	addi	sp,sp,32
    800262c6:	8082                	ret
        acquiresleep(&entry->lock);
    800262c8:	13848913          	addi	s2,s1,312
    800262cc:	854a                	mv	a0,s2
    800262ce:	ffffd097          	auipc	ra,0xffffd
    800262d2:	392080e7          	jalr	914(ra) # 80023660 <acquiresleep>
        entry->next->prev = entry->prev;
    800262d6:	1284b703          	ld	a4,296(s1)
    800262da:	1304b783          	ld	a5,304(s1)
    800262de:	12f73823          	sd	a5,304(a4)
        entry->prev->next = entry->next;
    800262e2:	1284b703          	ld	a4,296(s1)
    800262e6:	12e7b423          	sd	a4,296(a5)
        entry->next = root.next;
    800262ea:	0001b797          	auipc	a5,0x1b
    800262ee:	13e78793          	addi	a5,a5,318 # 80041428 <fat>
    800262f2:	1507b703          	ld	a4,336(a5)
    800262f6:	12e4b423          	sd	a4,296(s1)
        entry->prev = &root;
    800262fa:	0001b697          	auipc	a3,0x1b
    800262fe:	15668693          	addi	a3,a3,342 # 80041450 <root>
    80026302:	12d4b823          	sd	a3,304(s1)
        root.next->prev = entry;
    80026306:	12973823          	sd	s1,304(a4)
        root.next = entry;
    8002630a:	1497b823          	sd	s1,336(a5)
        release(&ecache.lock);
    8002630e:	0001b517          	auipc	a0,0x1b
    80026312:	2aa50513          	addi	a0,a0,682 # 800415b8 <ecache>
    80026316:	ffffa097          	auipc	ra,0xffffa
    8002631a:	3f0080e7          	jalr	1008(ra) # 80020706 <release>
        if (entry->valid == -1) {       // this means some one has called eremove()
    8002631e:	11649703          	lh	a4,278(s1)
    80026322:	57fd                	li	a5,-1
    80026324:	06f70863          	beq	a4,a5,80026394 <eput+0x12c>
            elock(entry->parent);
    80026328:	1204b503          	ld	a0,288(s1)
    8002632c:	00000097          	auipc	ra,0x0
    80026330:	eb8080e7          	jalr	-328(ra) # 800261e4 <elock>
            eupdate(entry);
    80026334:	8526                	mv	a0,s1
    80026336:	00000097          	auipc	ra,0x0
    8002633a:	c94080e7          	jalr	-876(ra) # 80025fca <eupdate>
            eunlock(entry->parent);
    8002633e:	1204b503          	ld	a0,288(s1)
    80026342:	00000097          	auipc	ra,0x0
    80026346:	ed8080e7          	jalr	-296(ra) # 8002621a <eunlock>
        releasesleep(&entry->lock);
    8002634a:	854a                	mv	a0,s2
    8002634c:	ffffd097          	auipc	ra,0xffffd
    80026350:	36a080e7          	jalr	874(ra) # 800236b6 <releasesleep>
        struct dirent *eparent = entry->parent;
    80026354:	1204b903          	ld	s2,288(s1)
        acquire(&ecache.lock);
    80026358:	0001b517          	auipc	a0,0x1b
    8002635c:	26050513          	addi	a0,a0,608 # 800415b8 <ecache>
    80026360:	ffffa097          	auipc	ra,0xffffa
    80026364:	352080e7          	jalr	850(ra) # 800206b2 <acquire>
        entry->ref--;
    80026368:	1184a783          	lw	a5,280(s1)
    8002636c:	37fd                	addiw	a5,a5,-1
    8002636e:	10f4ac23          	sw	a5,280(s1)
        release(&ecache.lock);
    80026372:	0001b517          	auipc	a0,0x1b
    80026376:	24650513          	addi	a0,a0,582 # 800415b8 <ecache>
    8002637a:	ffffa097          	auipc	ra,0xffffa
    8002637e:	38c080e7          	jalr	908(ra) # 80020706 <release>
        if (entry->ref == 0) {
    80026382:	1184a783          	lw	a5,280(s1)
    80026386:	fb9d                	bnez	a5,800262bc <eput+0x54>
            eput(eparent);
    80026388:	854a                	mv	a0,s2
    8002638a:	00000097          	auipc	ra,0x0
    8002638e:	ede080e7          	jalr	-290(ra) # 80026268 <eput>
    80026392:	b72d                	j	800262bc <eput+0x54>
            etrunc(entry);
    80026394:	8526                	mv	a0,s1
    80026396:	00000097          	auipc	ra,0x0
    8002639a:	de4080e7          	jalr	-540(ra) # 8002617a <etrunc>
    8002639e:	b775                	j	8002634a <eput+0xe2>

00000000800263a0 <estat>:
{
    800263a0:	1101                	addi	sp,sp,-32
    800263a2:	ec06                	sd	ra,24(sp)
    800263a4:	e822                	sd	s0,16(sp)
    800263a6:	e426                	sd	s1,8(sp)
    800263a8:	e04a                	sd	s2,0(sp)
    800263aa:	1000                	addi	s0,sp,32
    800263ac:	892a                	mv	s2,a0
    800263ae:	84ae                	mv	s1,a1
    strncpy(st->name, de->filename, STAT_MAX_NAME);
    800263b0:	02000613          	li	a2,32
    800263b4:	85aa                	mv	a1,a0
    800263b6:	8526                	mv	a0,s1
    800263b8:	ffffa097          	auipc	ra,0xffffa
    800263bc:	4aa080e7          	jalr	1194(ra) # 80020862 <strncpy>
    st->type = (de->attribute & ATTR_DIRECTORY) ? T_DIR : T_FILE;
    800263c0:	10094783          	lbu	a5,256(s2)
    800263c4:	8bc1                	andi	a5,a5,16
    800263c6:	0017b793          	seqz	a5,a5
    800263ca:	0785                	addi	a5,a5,1
    800263cc:	02f49423          	sh	a5,40(s1)
    st->dev = de->dev;
    800263d0:	11494783          	lbu	a5,276(s2)
    800263d4:	d0dc                	sw	a5,36(s1)
    st->size = de->file_size;
    800263d6:	10896783          	lwu	a5,264(s2)
    800263da:	f89c                	sd	a5,48(s1)
}
    800263dc:	60e2                	ld	ra,24(sp)
    800263de:	6442                	ld	s0,16(sp)
    800263e0:	64a2                	ld	s1,8(sp)
    800263e2:	6902                	ld	s2,0(sp)
    800263e4:	6105                	addi	sp,sp,32
    800263e6:	8082                	ret

00000000800263e8 <enext>:
 * @return  -1      meet the end of dir
 *          0       find empty slots
 *          1       find a file with all its entries
 */
int enext(struct dirent *dp, struct dirent *ep, uint off, int *count)
{
    800263e8:	7119                	addi	sp,sp,-128
    800263ea:	fc86                	sd	ra,120(sp)
    800263ec:	f8a2                	sd	s0,112(sp)
    800263ee:	f4a6                	sd	s1,104(sp)
    800263f0:	f0ca                	sd	s2,96(sp)
    800263f2:	ecce                	sd	s3,88(sp)
    800263f4:	e8d2                	sd	s4,80(sp)
    800263f6:	e4d6                	sd	s5,72(sp)
    800263f8:	e0da                	sd	s6,64(sp)
    800263fa:	fc5e                	sd	s7,56(sp)
    800263fc:	f862                	sd	s8,48(sp)
    800263fe:	f466                	sd	s9,40(sp)
    80026400:	0100                	addi	s0,sp,128
    if (!(dp->attribute & ATTR_DIRECTORY))
    80026402:	10054783          	lbu	a5,256(a0)
    80026406:	8bc1                	andi	a5,a5,16
    80026408:	cf95                	beqz	a5,80026444 <enext+0x5c>
    8002640a:	892a                	mv	s2,a0
    8002640c:	89ae                	mv	s3,a1
    8002640e:	84b2                	mv	s1,a2
    80026410:	8ab6                	mv	s5,a3
        panic("enext not dir");
    if (ep->valid)
    80026412:	11659783          	lh	a5,278(a1)
    80026416:	ef9d                	bnez	a5,80026454 <enext+0x6c>
        panic("enext ep valid");
    if (off % 32)
    80026418:	01f67793          	andi	a5,a2,31
    8002641c:	e7a1                	bnez	a5,80026464 <enext+0x7c>
        panic("enext not align");
    if (dp->valid != 1) { return -1; }
    8002641e:	11651703          	lh	a4,278(a0)
    80026422:	4785                	li	a5,1
    80026424:	557d                	li	a0,-1
    80026426:	04f70763          	beq	a4,a5,80026474 <enext+0x8c>
            read_entry_info(ep, &de);
            return 1;
        }
    }
    return -1;
}
    8002642a:	70e6                	ld	ra,120(sp)
    8002642c:	7446                	ld	s0,112(sp)
    8002642e:	74a6                	ld	s1,104(sp)
    80026430:	7906                	ld	s2,96(sp)
    80026432:	69e6                	ld	s3,88(sp)
    80026434:	6a46                	ld	s4,80(sp)
    80026436:	6aa6                	ld	s5,72(sp)
    80026438:	6b06                	ld	s6,64(sp)
    8002643a:	7be2                	ld	s7,56(sp)
    8002643c:	7c42                	ld	s8,48(sp)
    8002643e:	7ca2                	ld	s9,40(sp)
    80026440:	6109                	addi	sp,sp,128
    80026442:	8082                	ret
        panic("enext not dir");
    80026444:	00005517          	auipc	a0,0x5
    80026448:	71450513          	addi	a0,a0,1812 # 8002bb58 <digits+0x8d0>
    8002644c:	ffffa097          	auipc	ra,0xffffa
    80026450:	cf6080e7          	jalr	-778(ra) # 80020142 <panic>
        panic("enext ep valid");
    80026454:	00005517          	auipc	a0,0x5
    80026458:	71450513          	addi	a0,a0,1812 # 8002bb68 <digits+0x8e0>
    8002645c:	ffffa097          	auipc	ra,0xffffa
    80026460:	ce6080e7          	jalr	-794(ra) # 80020142 <panic>
        panic("enext not align");
    80026464:	00005517          	auipc	a0,0x5
    80026468:	71450513          	addi	a0,a0,1812 # 8002bb78 <digits+0x8f0>
    8002646c:	ffffa097          	auipc	ra,0xffffa
    80026470:	cd6080e7          	jalr	-810(ra) # 80020142 <panic>
    memset(ep->filename, 0, FAT32_MAX_FILENAME + 1);
    80026474:	10000613          	li	a2,256
    80026478:	4581                	li	a1,0
    8002647a:	854e                	mv	a0,s3
    8002647c:	ffffa097          	auipc	ra,0xffffa
    80026480:	2d2080e7          	jalr	722(ra) # 8002074e <memset>
    int cnt = 0;
    80026484:	4b01                	li	s6,0
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    80026486:	5bfd                	li	s7,-1
        if (rw_clus(dp->cur_clus, 0, 0, (uint64)&de, off2, 32) != 32 || de.lne.order == END_OF_ENTRY) {
    80026488:	f8040a13          	addi	s4,s0,-128
        if (de.lne.order == EMPTY_ENTRY) {
    8002648c:	0e500c13          	li	s8,229
        if (de.lne.attr == ATTR_LONG_NAME) {
    80026490:	4cbd                	li	s9,15
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    80026492:	a03d                	j	800264c0 <enext+0xd8>
            cnt++;
    80026494:	2b05                	addiw	s6,s6,1
            continue;
    80026496:	a01d                	j	800264bc <enext+0xd4>
            *count = cnt;
    80026498:	016aa023          	sw	s6,0(s5)
            return 0;
    8002649c:	4501                	li	a0,0
    8002649e:	b771                	j	8002642a <enext+0x42>
            read_entry_name(ep->filename + (lcnt - 1) * CHAR_LONG_NAME, &de);
    800264a0:	fff5079b          	addiw	a5,a0,-1
    800264a4:	0017951b          	slliw	a0,a5,0x1
    800264a8:	9d3d                	addw	a0,a0,a5
    800264aa:	0025151b          	slliw	a0,a0,0x2
    800264ae:	9d3d                	addw	a0,a0,a5
    800264b0:	85d2                	mv	a1,s4
    800264b2:	954e                	add	a0,a0,s3
    800264b4:	fffff097          	auipc	ra,0xfffff
    800264b8:	18a080e7          	jalr	394(ra) # 8002563e <read_entry_name>
    for (int off2; (off2 = reloc_clus(dp, off, 0)) != -1; off += 32) {
    800264bc:	0204849b          	addiw	s1,s1,32
    800264c0:	4601                	li	a2,0
    800264c2:	85a6                	mv	a1,s1
    800264c4:	854a                	mv	a0,s2
    800264c6:	fffff097          	auipc	ra,0xfffff
    800264ca:	e16080e7          	jalr	-490(ra) # 800252dc <reloc_clus>
    800264ce:	f5750ee3          	beq	a0,s7,8002642a <enext+0x42>
        if (rw_clus(dp->cur_clus, 0, 0, (uint64)&de, off2, 32) != 32 || de.lne.order == END_OF_ENTRY) {
    800264d2:	02000793          	li	a5,32
    800264d6:	0005071b          	sext.w	a4,a0
    800264da:	86d2                	mv	a3,s4
    800264dc:	4601                	li	a2,0
    800264de:	4581                	li	a1,0
    800264e0:	10c92503          	lw	a0,268(s2)
    800264e4:	fffff097          	auipc	ra,0xfffff
    800264e8:	f00080e7          	jalr	-256(ra) # 800253e4 <rw_clus>
    800264ec:	2501                	sext.w	a0,a0
    800264ee:	02000793          	li	a5,32
    800264f2:	06f51c63          	bne	a0,a5,8002656a <enext+0x182>
    800264f6:	f8044783          	lbu	a5,-128(s0)
    800264fa:	cbb5                	beqz	a5,8002656e <enext+0x186>
        if (de.lne.order == EMPTY_ENTRY) {
    800264fc:	f9878ce3          	beq	a5,s8,80026494 <enext+0xac>
        } else if (cnt) {
    80026500:	f80b1ce3          	bnez	s6,80026498 <enext+0xb0>
        if (de.lne.attr == ATTR_LONG_NAME) {
    80026504:	f8b44703          	lbu	a4,-117(s0)
    80026508:	01971d63          	bne	a4,s9,80026522 <enext+0x13a>
            int lcnt = de.lne.order & ~LAST_LONG_ENTRY;
    8002650c:	0bf7f513          	andi	a0,a5,191
            if (de.lne.order & LAST_LONG_ENTRY) {
    80026510:	0407f793          	andi	a5,a5,64
    80026514:	d7d1                	beqz	a5,800264a0 <enext+0xb8>
                *count = lcnt + 1;                              // plus the s-n-e;
    80026516:	0015079b          	addiw	a5,a0,1
    8002651a:	00faa023          	sw	a5,0(s5)
                count = 0;
    8002651e:	4a81                	li	s5,0
    80026520:	b741                	j	800264a0 <enext+0xb8>
            if (count) {
    80026522:	000a8c63          	beqz	s5,8002653a <enext+0x152>
                *count = 1;
    80026526:	4785                	li	a5,1
    80026528:	00faa023          	sw	a5,0(s5)
                read_entry_name(ep->filename, &de);
    8002652c:	f8040593          	addi	a1,s0,-128
    80026530:	854e                	mv	a0,s3
    80026532:	fffff097          	auipc	ra,0xfffff
    80026536:	10c080e7          	jalr	268(ra) # 8002563e <read_entry_name>
    entry->attribute = d->sne.attr;
    8002653a:	f8b44783          	lbu	a5,-117(s0)
    8002653e:	10f98023          	sb	a5,256(s3)
    entry->first_clus = ((uint32)d->sne.fst_clus_hi << 16) | d->sne.fst_clus_lo;
    80026542:	f9445783          	lhu	a5,-108(s0)
    80026546:	0107979b          	slliw	a5,a5,0x10
    8002654a:	f9a45703          	lhu	a4,-102(s0)
    8002654e:	8fd9                	or	a5,a5,a4
    80026550:	2781                	sext.w	a5,a5
    80026552:	10f9a223          	sw	a5,260(s3)
    entry->file_size = d->sne.file_size;
    80026556:	f9c42703          	lw	a4,-100(s0)
    8002655a:	10e9a423          	sw	a4,264(s3)
    entry->cur_clus = entry->first_clus;
    8002655e:	10f9a623          	sw	a5,268(s3)
    entry->clus_cnt = 0;
    80026562:	1009a823          	sw	zero,272(s3)
            return 1;
    80026566:	4505                	li	a0,1
}
    80026568:	b5c9                	j	8002642a <enext+0x42>
            return -1;
    8002656a:	557d                	li	a0,-1
    8002656c:	bd7d                	j	8002642a <enext+0x42>
    8002656e:	557d                	li	a0,-1
    80026570:	bd6d                	j	8002642a <enext+0x42>

0000000080026572 <dirlookup>:
 * @param   dp          entry of a directory file
 * @param   filename    target filename
 * @param   poff        offset of proper empty entry slots from the beginning of the dir
 */
struct dirent *dirlookup(struct dirent *dp, char *filename, uint *poff)
{
    80026572:	711d                	addi	sp,sp,-96
    80026574:	ec86                	sd	ra,88(sp)
    80026576:	e8a2                	sd	s0,80(sp)
    80026578:	e4a6                	sd	s1,72(sp)
    8002657a:	e0ca                	sd	s2,64(sp)
    8002657c:	fc4e                	sd	s3,56(sp)
    8002657e:	f852                	sd	s4,48(sp)
    80026580:	f456                	sd	s5,40(sp)
    80026582:	f05a                	sd	s6,32(sp)
    80026584:	ec5e                	sd	s7,24(sp)
    80026586:	1080                	addi	s0,sp,96
    if (!(dp->attribute & ATTR_DIRECTORY))
    80026588:	10054783          	lbu	a5,256(a0)
    8002658c:	8bc1                	andi	a5,a5,16
    8002658e:	cbb1                	beqz	a5,800265e2 <dirlookup+0x70>
    80026590:	84aa                	mv	s1,a0
    80026592:	89ae                	mv	s3,a1
    80026594:	8ab2                	mv	s5,a2
        panic("dirlookup not DIR");
    if (strncmp(filename, ".", FAT32_MAX_FILENAME) == 0) {
    80026596:	0ff00613          	li	a2,255
    8002659a:	00005597          	auipc	a1,0x5
    8002659e:	60658593          	addi	a1,a1,1542 # 8002bba0 <digits+0x918>
    800265a2:	854e                	mv	a0,s3
    800265a4:	ffffa097          	auipc	ra,0xffffa
    800265a8:	282080e7          	jalr	642(ra) # 80020826 <strncmp>
    800265ac:	c139                	beqz	a0,800265f2 <dirlookup+0x80>
        return edup(dp);
    } else if (strncmp(filename, "..", FAT32_MAX_FILENAME) == 0) {
    800265ae:	0ff00613          	li	a2,255
    800265b2:	00005597          	auipc	a1,0x5
    800265b6:	5f658593          	addi	a1,a1,1526 # 8002bba8 <digits+0x920>
    800265ba:	854e                	mv	a0,s3
    800265bc:	ffffa097          	auipc	ra,0xffffa
    800265c0:	26a080e7          	jalr	618(ra) # 80020826 <strncmp>
    800265c4:	e125                	bnez	a0,80026624 <dirlookup+0xb2>
        if (dp == &root) {
    800265c6:	0001b797          	auipc	a5,0x1b
    800265ca:	e8a78793          	addi	a5,a5,-374 # 80041450 <root>
    800265ce:	04f48463          	beq	s1,a5,80026616 <dirlookup+0xa4>
            return edup(&root);
        }
        return edup(dp->parent);
    800265d2:	1204b503          	ld	a0,288(s1)
    800265d6:	00000097          	auipc	ra,0x0
    800265da:	9b0080e7          	jalr	-1616(ra) # 80025f86 <edup>
    800265de:	892a                	mv	s2,a0
    800265e0:	a839                	j	800265fe <dirlookup+0x8c>
        panic("dirlookup not DIR");
    800265e2:	00005517          	auipc	a0,0x5
    800265e6:	5a650513          	addi	a0,a0,1446 # 8002bb88 <digits+0x900>
    800265ea:	ffffa097          	auipc	ra,0xffffa
    800265ee:	b58080e7          	jalr	-1192(ra) # 80020142 <panic>
        return edup(dp);
    800265f2:	8526                	mv	a0,s1
    800265f4:	00000097          	auipc	ra,0x0
    800265f8:	992080e7          	jalr	-1646(ra) # 80025f86 <edup>
    800265fc:	892a                	mv	s2,a0
    if (poff) {
        *poff = off;
    }
    eput(ep);
    return NULL;
}
    800265fe:	854a                	mv	a0,s2
    80026600:	60e6                	ld	ra,88(sp)
    80026602:	6446                	ld	s0,80(sp)
    80026604:	64a6                	ld	s1,72(sp)
    80026606:	6906                	ld	s2,64(sp)
    80026608:	79e2                	ld	s3,56(sp)
    8002660a:	7a42                	ld	s4,48(sp)
    8002660c:	7aa2                	ld	s5,40(sp)
    8002660e:	7b02                	ld	s6,32(sp)
    80026610:	6be2                	ld	s7,24(sp)
    80026612:	6125                	addi	sp,sp,96
    80026614:	8082                	ret
            return edup(&root);
    80026616:	853e                	mv	a0,a5
    80026618:	00000097          	auipc	ra,0x0
    8002661c:	96e080e7          	jalr	-1682(ra) # 80025f86 <edup>
    80026620:	892a                	mv	s2,a0
    80026622:	bff1                	j	800265fe <dirlookup+0x8c>
    if (dp->valid != 1) {
    80026624:	11649703          	lh	a4,278(s1)
    80026628:	4785                	li	a5,1
        return NULL;
    8002662a:	4901                	li	s2,0
    if (dp->valid != 1) {
    8002662c:	fcf719e3          	bne	a4,a5,800265fe <dirlookup+0x8c>
    struct dirent *ep = eget(dp, filename);
    80026630:	85ce                	mv	a1,s3
    80026632:	8526                	mv	a0,s1
    80026634:	fffff097          	auipc	ra,0xfffff
    80026638:	efc080e7          	jalr	-260(ra) # 80025530 <eget>
    8002663c:	892a                	mv	s2,a0
    if (ep->valid == 1) { return ep; }                               // ecache hits
    8002663e:	11651703          	lh	a4,278(a0)
    80026642:	4785                	li	a5,1
    80026644:	faf70de3          	beq	a4,a5,800265fe <dirlookup+0x8c>
    int len = strlen(filename);
    80026648:	854e                	mv	a0,s3
    8002664a:	ffffa097          	auipc	ra,0xffffa
    8002664e:	288080e7          	jalr	648(ra) # 800208d2 <strlen>
    int count = 0;
    80026652:	fa042623          	sw	zero,-84(s0)
    reloc_clus(dp, 0, 0);
    80026656:	4601                	li	a2,0
    80026658:	4581                	li	a1,0
    8002665a:	8526                	mv	a0,s1
    8002665c:	fffff097          	auipc	ra,0xfffff
    80026660:	c80080e7          	jalr	-896(ra) # 800252dc <reloc_clus>
    uint off = 0;
    80026664:	4a01                	li	s4,0
    while ((type = enext(dp, ep, off, &count) != -1)) {
    80026666:	fac40b93          	addi	s7,s0,-84
    8002666a:	5b7d                	li	s6,-1
    8002666c:	86de                	mv	a3,s7
    8002666e:	8652                	mv	a2,s4
    80026670:	85ca                	mv	a1,s2
    80026672:	8526                	mv	a0,s1
    80026674:	00000097          	auipc	ra,0x0
    80026678:	d74080e7          	jalr	-652(ra) # 800263e8 <enext>
    8002667c:	03650f63          	beq	a0,s6,800266ba <dirlookup+0x148>
        } else if (strncmp(filename, ep->filename, FAT32_MAX_FILENAME) == 0) {
    80026680:	0ff00613          	li	a2,255
    80026684:	85ca                	mv	a1,s2
    80026686:	854e                	mv	a0,s3
    80026688:	ffffa097          	auipc	ra,0xffffa
    8002668c:	19e080e7          	jalr	414(ra) # 80020826 <strncmp>
    80026690:	c901                	beqz	a0,800266a0 <dirlookup+0x12e>
        off += count << 5;
    80026692:	fac42783          	lw	a5,-84(s0)
    80026696:	0057979b          	slliw	a5,a5,0x5
    8002669a:	01478a3b          	addw	s4,a5,s4
    8002669e:	b7f9                	j	8002666c <dirlookup+0xfa>
            ep->parent = edup(dp);
    800266a0:	8526                	mv	a0,s1
    800266a2:	00000097          	auipc	ra,0x0
    800266a6:	8e4080e7          	jalr	-1820(ra) # 80025f86 <edup>
    800266aa:	12a93023          	sd	a0,288(s2)
            ep->off = off;
    800266ae:	11492e23          	sw	s4,284(s2)
            ep->valid = 1;
    800266b2:	4785                	li	a5,1
    800266b4:	10f91b23          	sh	a5,278(s2)
            return ep;
    800266b8:	b799                	j	800265fe <dirlookup+0x8c>
    if (poff) {
    800266ba:	000a8463          	beqz	s5,800266c2 <dirlookup+0x150>
        *poff = off;
    800266be:	014aa023          	sw	s4,0(s5)
    eput(ep);
    800266c2:	854a                	mv	a0,s2
    800266c4:	00000097          	auipc	ra,0x0
    800266c8:	ba4080e7          	jalr	-1116(ra) # 80026268 <eput>
    return NULL;
    800266cc:	4901                	li	s2,0
    800266ce:	bf05                	j	800265fe <dirlookup+0x8c>

00000000800266d0 <ealloc>:
{
    800266d0:	7139                	addi	sp,sp,-64
    800266d2:	fc06                	sd	ra,56(sp)
    800266d4:	f822                	sd	s0,48(sp)
    800266d6:	f426                	sd	s1,40(sp)
    800266d8:	f04a                	sd	s2,32(sp)
    800266da:	ec4e                	sd	s3,24(sp)
    800266dc:	e852                	sd	s4,16(sp)
    800266de:	0080                	addi	s0,sp,64
    800266e0:	892a                	mv	s2,a0
    if (!(dp->attribute & ATTR_DIRECTORY)) {
    800266e2:	10054783          	lbu	a5,256(a0)
    800266e6:	8bc1                	andi	a5,a5,16
    800266e8:	c7a9                	beqz	a5,80026732 <ealloc+0x62>
    800266ea:	852e                	mv	a0,a1
    800266ec:	8a32                	mv	s4,a2
    if (dp->valid != 1 || !(name = formatname(name))) {        // detect illegal character
    800266ee:	11691703          	lh	a4,278(s2)
    800266f2:	4785                	li	a5,1
        return NULL;
    800266f4:	4481                	li	s1,0
    if (dp->valid != 1 || !(name = formatname(name))) {        // detect illegal character
    800266f6:	02f71563          	bne	a4,a5,80026720 <ealloc+0x50>
    800266fa:	fffff097          	auipc	ra,0xfffff
    800266fe:	41a080e7          	jalr	1050(ra) # 80025b14 <formatname>
    80026702:	89aa                	mv	s3,a0
    80026704:	10050663          	beqz	a0,80026810 <ealloc+0x140>
    uint off = 0;
    80026708:	fc042623          	sw	zero,-52(s0)
    if ((ep = dirlookup(dp, name, &off)) != 0) {      // entry exists
    8002670c:	fcc40613          	addi	a2,s0,-52
    80026710:	85aa                	mv	a1,a0
    80026712:	854a                	mv	a0,s2
    80026714:	00000097          	auipc	ra,0x0
    80026718:	e5e080e7          	jalr	-418(ra) # 80026572 <dirlookup>
    8002671c:	84aa                	mv	s1,a0
    8002671e:	c115                	beqz	a0,80026742 <ealloc+0x72>
}
    80026720:	8526                	mv	a0,s1
    80026722:	70e2                	ld	ra,56(sp)
    80026724:	7442                	ld	s0,48(sp)
    80026726:	74a2                	ld	s1,40(sp)
    80026728:	7902                	ld	s2,32(sp)
    8002672a:	69e2                	ld	s3,24(sp)
    8002672c:	6a42                	ld	s4,16(sp)
    8002672e:	6121                	addi	sp,sp,64
    80026730:	8082                	ret
        panic("ealloc not dir");
    80026732:	00005517          	auipc	a0,0x5
    80026736:	47e50513          	addi	a0,a0,1150 # 8002bbb0 <digits+0x928>
    8002673a:	ffffa097          	auipc	ra,0xffffa
    8002673e:	a08080e7          	jalr	-1528(ra) # 80020142 <panic>
    ep = eget(dp, name);
    80026742:	85ce                	mv	a1,s3
    80026744:	854a                	mv	a0,s2
    80026746:	fffff097          	auipc	ra,0xfffff
    8002674a:	dea080e7          	jalr	-534(ra) # 80025530 <eget>
    8002674e:	84aa                	mv	s1,a0
    elock(ep);
    80026750:	00000097          	auipc	ra,0x0
    80026754:	a94080e7          	jalr	-1388(ra) # 800261e4 <elock>
    ep->attribute = attr;
    80026758:	11448023          	sb	s4,256(s1)
    ep->file_size = 0;
    8002675c:	1004a423          	sw	zero,264(s1)
    ep->first_clus = 0;
    80026760:	1004a223          	sw	zero,260(s1)
    ep->parent = edup(dp);
    80026764:	854a                	mv	a0,s2
    80026766:	00000097          	auipc	ra,0x0
    8002676a:	820080e7          	jalr	-2016(ra) # 80025f86 <edup>
    8002676e:	12a4b023          	sd	a0,288(s1)
    ep->off = off;
    80026772:	fcc42783          	lw	a5,-52(s0)
    80026776:	10f4ae23          	sw	a5,284(s1)
    ep->clus_cnt = 0;
    8002677a:	1004a823          	sw	zero,272(s1)
    ep->cur_clus = 0;
    8002677e:	1004a623          	sw	zero,268(s1)
    ep->dirty = 0;
    80026782:	10048aa3          	sb	zero,277(s1)
    strncpy(ep->filename, name, FAT32_MAX_FILENAME);
    80026786:	0ff00613          	li	a2,255
    8002678a:	85ce                	mv	a1,s3
    8002678c:	8526                	mv	a0,s1
    8002678e:	ffffa097          	auipc	ra,0xffffa
    80026792:	0d4080e7          	jalr	212(ra) # 80020862 <strncpy>
    ep->filename[FAT32_MAX_FILENAME] = '\0';
    80026796:	0e048fa3          	sb	zero,255(s1)
    if (attr == ATTR_DIRECTORY) {    // generate "." and ".." for ep
    8002679a:	47c1                	li	a5,16
    8002679c:	02fa0963          	beq	s4,a5,800267ce <ealloc+0xfe>
        ep->attribute |= ATTR_ARCHIVE;
    800267a0:	1004c783          	lbu	a5,256(s1)
    800267a4:	0207e793          	ori	a5,a5,32
    800267a8:	10f48023          	sb	a5,256(s1)
    emake(dp, ep, off);
    800267ac:	fcc42603          	lw	a2,-52(s0)
    800267b0:	85a6                	mv	a1,s1
    800267b2:	854a                	mv	a0,s2
    800267b4:	fffff097          	auipc	ra,0xfffff
    800267b8:	418080e7          	jalr	1048(ra) # 80025bcc <emake>
    ep->valid = 1;
    800267bc:	4785                	li	a5,1
    800267be:	10f49b23          	sh	a5,278(s1)
    eunlock(ep);
    800267c2:	8526                	mv	a0,s1
    800267c4:	00000097          	auipc	ra,0x0
    800267c8:	a56080e7          	jalr	-1450(ra) # 8002621a <eunlock>
    return ep;
    800267cc:	bf91                	j	80026720 <ealloc+0x50>
        ep->attribute |= ATTR_DIRECTORY;
    800267ce:	1004c783          	lbu	a5,256(s1)
    800267d2:	0107e793          	ori	a5,a5,16
    800267d6:	10f48023          	sb	a5,256(s1)
        ep->cur_clus = ep->first_clus = alloc_clus(dp->dev);
    800267da:	11494503          	lbu	a0,276(s2)
    800267de:	fffff097          	auipc	ra,0xfffff
    800267e2:	93e080e7          	jalr	-1730(ra) # 8002511c <alloc_clus>
    800267e6:	2501                	sext.w	a0,a0
    800267e8:	10a4a223          	sw	a0,260(s1)
    800267ec:	10a4a623          	sw	a0,268(s1)
        emake(ep, ep, 0);
    800267f0:	4601                	li	a2,0
    800267f2:	85a6                	mv	a1,s1
    800267f4:	8526                	mv	a0,s1
    800267f6:	fffff097          	auipc	ra,0xfffff
    800267fa:	3d6080e7          	jalr	982(ra) # 80025bcc <emake>
        emake(ep, dp, 32);
    800267fe:	02000613          	li	a2,32
    80026802:	85ca                	mv	a1,s2
    80026804:	8526                	mv	a0,s1
    80026806:	fffff097          	auipc	ra,0xfffff
    8002680a:	3c6080e7          	jalr	966(ra) # 80025bcc <emake>
    8002680e:	bf79                	j	800267ac <ealloc+0xdc>
        return NULL;
    80026810:	84aa                	mv	s1,a0
    80026812:	b739                	j	80026720 <ealloc+0x50>

0000000080026814 <lookup_path>:
    return path;
}

// FAT32 version of namex in xv6's original file system.
static struct dirent *lookup_path(char *path, int parent, char *name)
{
    80026814:	715d                	addi	sp,sp,-80
    80026816:	e486                	sd	ra,72(sp)
    80026818:	e0a2                	sd	s0,64(sp)
    8002681a:	fc26                	sd	s1,56(sp)
    8002681c:	f84a                	sd	s2,48(sp)
    8002681e:	f44e                	sd	s3,40(sp)
    80026820:	f052                	sd	s4,32(sp)
    80026822:	ec56                	sd	s5,24(sp)
    80026824:	e85a                	sd	s6,16(sp)
    80026826:	e45e                	sd	s7,8(sp)
    80026828:	e062                	sd	s8,0(sp)
    8002682a:	0880                	addi	s0,sp,80
    8002682c:	892a                	mv	s2,a0
    8002682e:	8b2e                	mv	s6,a1
    80026830:	8ab2                	mv	s5,a2
    struct dirent *entry, *next;
    if (*path == '/') {
    80026832:	00054783          	lbu	a5,0(a0)
    80026836:	02f00713          	li	a4,47
    8002683a:	02e78663          	beq	a5,a4,80026866 <lookup_path+0x52>
        entry = edup(&root);
    } else if (*path != '\0') {
        entry = edup(myproc()->cwd);
    } else {
        return NULL;
    8002683e:	4a01                	li	s4,0
    } else if (*path != '\0') {
    80026840:	cba1                	beqz	a5,80026890 <lookup_path+0x7c>
        entry = edup(myproc()->cwd);
    80026842:	ffffb097          	auipc	ra,0xffffb
    80026846:	290080e7          	jalr	656(ra) # 80021ad2 <myproc>
    8002684a:	15853503          	ld	a0,344(a0)
    8002684e:	fffff097          	auipc	ra,0xfffff
    80026852:	738080e7          	jalr	1848(ra) # 80025f86 <edup>
    80026856:	8a2a                	mv	s4,a0
    while (*path == '/') {
    80026858:	02f00993          	li	s3,47
    8002685c:	0ff00b93          	li	s7,255
    80026860:	0ff00c13          	li	s8,255
    80026864:	a0dd                	j	8002694a <lookup_path+0x136>
        entry = edup(&root);
    80026866:	0001b517          	auipc	a0,0x1b
    8002686a:	bea50513          	addi	a0,a0,-1046 # 80041450 <root>
    8002686e:	fffff097          	auipc	ra,0xfffff
    80026872:	718080e7          	jalr	1816(ra) # 80025f86 <edup>
    80026876:	8a2a                	mv	s4,a0
    80026878:	b7c5                	j	80026858 <lookup_path+0x44>
    }
    while ((path = skipelem(path, name)) != 0) {
        elock(entry);
        if (!(entry->attribute & ATTR_DIRECTORY)) {
            eunlock(entry);
    8002687a:	8552                	mv	a0,s4
    8002687c:	00000097          	auipc	ra,0x0
    80026880:	99e080e7          	jalr	-1634(ra) # 8002621a <eunlock>
            eput(entry);
    80026884:	8552                	mv	a0,s4
    80026886:	00000097          	auipc	ra,0x0
    8002688a:	9e2080e7          	jalr	-1566(ra) # 80026268 <eput>
            return NULL;
    8002688e:	4a01                	li	s4,0
    if (parent) {
        eput(entry);
        return NULL;
    }
    return entry;
}
    80026890:	8552                	mv	a0,s4
    80026892:	60a6                	ld	ra,72(sp)
    80026894:	6406                	ld	s0,64(sp)
    80026896:	74e2                	ld	s1,56(sp)
    80026898:	7942                	ld	s2,48(sp)
    8002689a:	79a2                	ld	s3,40(sp)
    8002689c:	7a02                	ld	s4,32(sp)
    8002689e:	6ae2                	ld	s5,24(sp)
    800268a0:	6b42                	ld	s6,16(sp)
    800268a2:	6ba2                	ld	s7,8(sp)
    800268a4:	6c02                	ld	s8,0(sp)
    800268a6:	6161                	addi	sp,sp,80
    800268a8:	8082                	ret
            eunlock(entry);
    800268aa:	8552                	mv	a0,s4
    800268ac:	00000097          	auipc	ra,0x0
    800268b0:	96e080e7          	jalr	-1682(ra) # 8002621a <eunlock>
            return entry;
    800268b4:	bff1                	j	80026890 <lookup_path+0x7c>
            eunlock(entry);
    800268b6:	8552                	mv	a0,s4
    800268b8:	00000097          	auipc	ra,0x0
    800268bc:	962080e7          	jalr	-1694(ra) # 8002621a <eunlock>
            eput(entry);
    800268c0:	8552                	mv	a0,s4
    800268c2:	00000097          	auipc	ra,0x0
    800268c6:	9a6080e7          	jalr	-1626(ra) # 80026268 <eput>
            return NULL;
    800268ca:	8a4a                	mv	s4,s2
    800268cc:	b7d1                	j	80026890 <lookup_path+0x7c>
    int len = path - s;
    800268ce:	412487bb          	subw	a5,s1,s2
    if (len > FAT32_MAX_FILENAME) {
    800268d2:	863e                	mv	a2,a5
    800268d4:	00fbd363          	bge	s7,a5,800268da <lookup_path+0xc6>
    800268d8:	8662                	mv	a2,s8
    800268da:	0006079b          	sext.w	a5,a2
    name[len] = 0;
    800268de:	97d6                	add	a5,a5,s5
    800268e0:	00078023          	sb	zero,0(a5)
    memmove(name, s, len);
    800268e4:	2601                	sext.w	a2,a2
    800268e6:	85ca                	mv	a1,s2
    800268e8:	8556                	mv	a0,s5
    800268ea:	ffffa097          	auipc	ra,0xffffa
    800268ee:	ec0080e7          	jalr	-320(ra) # 800207aa <memmove>
    while (*path == '/') {
    800268f2:	0004c783          	lbu	a5,0(s1)
    800268f6:	01379763          	bne	a5,s3,80026904 <lookup_path+0xf0>
        path++;
    800268fa:	0485                	addi	s1,s1,1
    while (*path == '/') {
    800268fc:	0004c783          	lbu	a5,0(s1)
    80026900:	ff378de3          	beq	a5,s3,800268fa <lookup_path+0xe6>
        elock(entry);
    80026904:	8552                	mv	a0,s4
    80026906:	00000097          	auipc	ra,0x0
    8002690a:	8de080e7          	jalr	-1826(ra) # 800261e4 <elock>
        if (!(entry->attribute & ATTR_DIRECTORY)) {
    8002690e:	100a4783          	lbu	a5,256(s4)
    80026912:	8bc1                	andi	a5,a5,16
    80026914:	d3bd                	beqz	a5,8002687a <lookup_path+0x66>
        if (parent && *path == '\0') {
    80026916:	000b0563          	beqz	s6,80026920 <lookup_path+0x10c>
    8002691a:	0004c783          	lbu	a5,0(s1)
    8002691e:	d7d1                	beqz	a5,800268aa <lookup_path+0x96>
        if ((next = dirlookup(entry, name, 0)) == 0) {
    80026920:	4601                	li	a2,0
    80026922:	85d6                	mv	a1,s5
    80026924:	8552                	mv	a0,s4
    80026926:	00000097          	auipc	ra,0x0
    8002692a:	c4c080e7          	jalr	-948(ra) # 80026572 <dirlookup>
    8002692e:	892a                	mv	s2,a0
    80026930:	d159                	beqz	a0,800268b6 <lookup_path+0xa2>
        eunlock(entry);
    80026932:	8552                	mv	a0,s4
    80026934:	00000097          	auipc	ra,0x0
    80026938:	8e6080e7          	jalr	-1818(ra) # 8002621a <eunlock>
        eput(entry);
    8002693c:	8552                	mv	a0,s4
    8002693e:	00000097          	auipc	ra,0x0
    80026942:	92a080e7          	jalr	-1750(ra) # 80026268 <eput>
        entry = next;
    80026946:	8a4a                	mv	s4,s2
        eput(entry);
    80026948:	8926                	mv	s2,s1
    while (*path == '/') {
    8002694a:	00094783          	lbu	a5,0(s2)
    8002694e:	03379363          	bne	a5,s3,80026974 <lookup_path+0x160>
        path++;
    80026952:	0905                	addi	s2,s2,1
    while (*path == '/') {
    80026954:	00094783          	lbu	a5,0(s2)
    80026958:	ff378de3          	beq	a5,s3,80026952 <lookup_path+0x13e>
    if (*path == 0) { return NULL; }
    8002695c:	cf89                	beqz	a5,80026976 <lookup_path+0x162>
        path++;
    8002695e:	84ca                	mv	s1,s2
    while (*path != '/' && *path != 0) {
    80026960:	f73787e3          	beq	a5,s3,800268ce <lookup_path+0xba>
        eput(entry);
    80026964:	84ca                	mv	s1,s2
    while (*path != '/' && *path != 0) {
    80026966:	d7a5                	beqz	a5,800268ce <lookup_path+0xba>
        path++;
    80026968:	0485                	addi	s1,s1,1
    while (*path != '/' && *path != 0) {
    8002696a:	0004c783          	lbu	a5,0(s1)
    8002696e:	ff379ce3          	bne	a5,s3,80026966 <lookup_path+0x152>
    80026972:	bfb1                	j	800268ce <lookup_path+0xba>
    if (*path == 0) { return NULL; }
    80026974:	fbe5                	bnez	a5,80026964 <lookup_path+0x150>
    if (parent) {
    80026976:	f00b0de3          	beqz	s6,80026890 <lookup_path+0x7c>
        eput(entry);
    8002697a:	8552                	mv	a0,s4
    8002697c:	00000097          	auipc	ra,0x0
    80026980:	8ec080e7          	jalr	-1812(ra) # 80026268 <eput>
        return NULL;
    80026984:	4a01                	li	s4,0
    80026986:	b729                	j	80026890 <lookup_path+0x7c>

0000000080026988 <ename>:

struct dirent *ename(char *path)
{
    80026988:	716d                	addi	sp,sp,-272
    8002698a:	e606                	sd	ra,264(sp)
    8002698c:	e222                	sd	s0,256(sp)
    8002698e:	0a00                	addi	s0,sp,272
    char name[FAT32_MAX_FILENAME + 1];
    return lookup_path(path, 0, name);
    80026990:	ef040613          	addi	a2,s0,-272
    80026994:	4581                	li	a1,0
    80026996:	00000097          	auipc	ra,0x0
    8002699a:	e7e080e7          	jalr	-386(ra) # 80026814 <lookup_path>
}
    8002699e:	60b2                	ld	ra,264(sp)
    800269a0:	6412                	ld	s0,256(sp)
    800269a2:	6151                	addi	sp,sp,272
    800269a4:	8082                	ret

00000000800269a6 <enameparent>:

struct dirent *enameparent(char *path, char *name)
{
    800269a6:	1141                	addi	sp,sp,-16
    800269a8:	e406                	sd	ra,8(sp)
    800269aa:	e022                	sd	s0,0(sp)
    800269ac:	0800                	addi	s0,sp,16
    800269ae:	862e                	mv	a2,a1
    return lookup_path(path, 1, name);
    800269b0:	4585                	li	a1,1
    800269b2:	00000097          	auipc	ra,0x0
    800269b6:	e62080e7          	jalr	-414(ra) # 80026814 <lookup_path>
}
    800269ba:	60a2                	ld	ra,8(sp)
    800269bc:	6402                	ld	s0,0(sp)
    800269be:	0141                	addi	sp,sp,16
    800269c0:	8082                	ret

00000000800269c2 <plicinit>:

//
// the riscv Platform Level Interrupt Controller (PLIC).
//

void plicinit(void) {
    800269c2:	1141                	addi	sp,sp,-16
    800269c4:	e422                	sd	s0,8(sp)
    800269c6:	0800                	addi	s0,sp,16
	writed(1, PLIC_V + DISK_IRQ * sizeof(uint32));
    800269c8:	00fc37b7          	lui	a5,0xfc3
    800269cc:	07ba                	slli	a5,a5,0xe
    800269ce:	4705                	li	a4,1
    800269d0:	d7f8                	sw	a4,108(a5)
	writed(1, PLIC_V + UART_IRQ * sizeof(uint32));
    800269d2:	08e7a223          	sw	a4,132(a5) # fc3084 <_start-0x7f05cf7c>

	#ifdef DEBUG 
	printf("plicinit\n");
	#endif 
}
    800269d6:	6422                	ld	s0,8(sp)
    800269d8:	0141                	addi	sp,sp,16
    800269da:	8082                	ret

00000000800269dc <plicinithart>:

void
plicinithart(void)
{
    800269dc:	1141                	addi	sp,sp,-16
    800269de:	e406                	sd	ra,8(sp)
    800269e0:	e022                	sd	s0,0(sp)
    800269e2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800269e4:	ffffb097          	auipc	ra,0xffffb
    800269e8:	0c2080e7          	jalr	194(ra) # 80021aa6 <cpuid>
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART_IRQ) | (1 << DISK_IRQ);
  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
  #else
  uint32 *hart_m_enable = (uint32*)PLIC_MENABLE(hart);
    800269ec:	0085151b          	slliw	a0,a0,0x8
    800269f0:	01f867b7          	lui	a5,0x1f86
    800269f4:	0785                	addi	a5,a5,1
    800269f6:	07b6                	slli	a5,a5,0xd
    800269f8:	953e                	add	a0,a0,a5
  *(hart_m_enable) = readd(hart_m_enable) | (1 << DISK_IRQ);
    800269fa:	411c                	lw	a5,0(a0)
    800269fc:	08000737          	lui	a4,0x8000
    80026a00:	8fd9                	or	a5,a5,a4
    80026a02:	c11c                	sw	a5,0(a0)
  uint32 *hart0_m_int_enable_hi = hart_m_enable + 1;
  *(hart0_m_int_enable_hi) = readd(hart0_m_int_enable_hi) | (1 << (UART_IRQ % 32));
    80026a04:	415c                	lw	a5,4(a0)
    80026a06:	0027e793          	ori	a5,a5,2
    80026a0a:	c15c                	sw	a5,4(a0)
  #endif
  #ifdef DEBUG
  printf("plicinithart\n");
  #endif
}
    80026a0c:	60a2                	ld	ra,8(sp)
    80026a0e:	6402                	ld	s0,0(sp)
    80026a10:	0141                	addi	sp,sp,16
    80026a12:	8082                	ret

0000000080026a14 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80026a14:	1141                	addi	sp,sp,-16
    80026a16:	e406                	sd	ra,8(sp)
    80026a18:	e022                	sd	s0,0(sp)
    80026a1a:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80026a1c:	ffffb097          	auipc	ra,0xffffb
    80026a20:	08a080e7          	jalr	138(ra) # 80021aa6 <cpuid>
  int irq;
  #ifndef QEMU
  irq = *(uint32*)PLIC_MCLAIM(hart);
    80026a24:	00d5179b          	slliw	a5,a0,0xd
    80026a28:	1f861537          	lui	a0,0x1f861
    80026a2c:	0526                	slli	a0,a0,0x9
    80026a2e:	953e                	add	a0,a0,a5
  #else
  irq = *(uint32*)PLIC_SCLAIM(hart);
  #endif
  return irq;
}
    80026a30:	4148                	lw	a0,4(a0)
    80026a32:	60a2                	ld	ra,8(sp)
    80026a34:	6402                	ld	s0,0(sp)
    80026a36:	0141                	addi	sp,sp,16
    80026a38:	8082                	ret

0000000080026a3a <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80026a3a:	1101                	addi	sp,sp,-32
    80026a3c:	ec06                	sd	ra,24(sp)
    80026a3e:	e822                	sd	s0,16(sp)
    80026a40:	e426                	sd	s1,8(sp)
    80026a42:	1000                	addi	s0,sp,32
    80026a44:	84aa                	mv	s1,a0
  int hart = cpuid();
    80026a46:	ffffb097          	auipc	ra,0xffffb
    80026a4a:	060080e7          	jalr	96(ra) # 80021aa6 <cpuid>
  #ifndef QEMU
  *(uint32*)PLIC_MCLAIM(hart) = irq;
    80026a4e:	00d5151b          	slliw	a0,a0,0xd
    80026a52:	1f8617b7          	lui	a5,0x1f861
    80026a56:	07a6                	slli	a5,a5,0x9
    80026a58:	97aa                	add	a5,a5,a0
    80026a5a:	c3c4                	sw	s1,4(a5)
  #else
  *(uint32*)PLIC_SCLAIM(hart) = irq;
  #endif
}
    80026a5c:	60e2                	ld	ra,24(sp)
    80026a5e:	6442                	ld	s0,16(sp)
    80026a60:	64a2                	ld	s1,8(sp)
    80026a62:	6105                	addi	sp,sp,32
    80026a64:	8082                	ret

0000000080026a66 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80026a66:	715d                	addi	sp,sp,-80
    80026a68:	e486                	sd	ra,72(sp)
    80026a6a:	e0a2                	sd	s0,64(sp)
    80026a6c:	fc26                	sd	s1,56(sp)
    80026a6e:	f84a                	sd	s2,48(sp)
    80026a70:	f44e                	sd	s3,40(sp)
    80026a72:	f052                	sd	s4,32(sp)
    80026a74:	ec56                	sd	s5,24(sp)
    80026a76:	e85a                	sd	s6,16(sp)
    80026a78:	0880                	addi	s0,sp,80
    80026a7a:	8a2a                	mv	s4,a0
    80026a7c:	84ae                	mv	s1,a1
    80026a7e:	89b2                	mv	s3,a2
  int i;

  acquire(&cons.lock);
    80026a80:	0001f517          	auipc	a0,0x1f
    80026a84:	1a050513          	addi	a0,a0,416 # 80045c20 <cons>
    80026a88:	ffffa097          	auipc	ra,0xffffa
    80026a8c:	c2a080e7          	jalr	-982(ra) # 800206b2 <acquire>
  for(i = 0; i < n; i++){
    80026a90:	05305f63          	blez	s3,80026aee <consolewrite+0x88>
    80026a94:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80026a96:	fbf40b13          	addi	s6,s0,-65
    80026a9a:	5afd                	li	s5,-1
    80026a9c:	4685                	li	a3,1
    80026a9e:	8626                	mv	a2,s1
    80026aa0:	85d2                	mv	a1,s4
    80026aa2:	855a                	mv	a0,s6
    80026aa4:	ffffc097          	auipc	ra,0xffffc
    80026aa8:	b38080e7          	jalr	-1224(ra) # 800225dc <either_copyin>
    80026aac:	01550e63          	beq	a0,s5,80026ac8 <consolewrite+0x62>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
    80026ab0:	fbf44503          	lbu	a0,-65(s0)
    80026ab4:	4581                	li	a1,0
    80026ab6:	4601                	li	a2,0
    80026ab8:	4681                	li	a3,0
    80026aba:	4885                	li	a7,1
    80026abc:	00000073          	ecall
  for(i = 0; i < n; i++){
    80026ac0:	2905                	addiw	s2,s2,1
    80026ac2:	0485                	addi	s1,s1,1
    80026ac4:	fd299ce3          	bne	s3,s2,80026a9c <consolewrite+0x36>
      break;
    sbi_console_putchar(c);
  }
  release(&cons.lock);
    80026ac8:	0001f517          	auipc	a0,0x1f
    80026acc:	15850513          	addi	a0,a0,344 # 80045c20 <cons>
    80026ad0:	ffffa097          	auipc	ra,0xffffa
    80026ad4:	c36080e7          	jalr	-970(ra) # 80020706 <release>

  return i;
}
    80026ad8:	854a                	mv	a0,s2
    80026ada:	60a6                	ld	ra,72(sp)
    80026adc:	6406                	ld	s0,64(sp)
    80026ade:	74e2                	ld	s1,56(sp)
    80026ae0:	7942                	ld	s2,48(sp)
    80026ae2:	79a2                	ld	s3,40(sp)
    80026ae4:	7a02                	ld	s4,32(sp)
    80026ae6:	6ae2                	ld	s5,24(sp)
    80026ae8:	6b42                	ld	s6,16(sp)
    80026aea:	6161                	addi	sp,sp,80
    80026aec:	8082                	ret
  for(i = 0; i < n; i++){
    80026aee:	4901                	li	s2,0
    80026af0:	bfe1                	j	80026ac8 <consolewrite+0x62>

0000000080026af2 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80026af2:	7119                	addi	sp,sp,-128
    80026af4:	fc86                	sd	ra,120(sp)
    80026af6:	f8a2                	sd	s0,112(sp)
    80026af8:	f4a6                	sd	s1,104(sp)
    80026afa:	f0ca                	sd	s2,96(sp)
    80026afc:	ecce                	sd	s3,88(sp)
    80026afe:	e8d2                	sd	s4,80(sp)
    80026b00:	e4d6                	sd	s5,72(sp)
    80026b02:	e0da                	sd	s6,64(sp)
    80026b04:	fc5e                	sd	s7,56(sp)
    80026b06:	f862                	sd	s8,48(sp)
    80026b08:	f466                	sd	s9,40(sp)
    80026b0a:	f06a                	sd	s10,32(sp)
    80026b0c:	ec6e                	sd	s11,24(sp)
    80026b0e:	0100                	addi	s0,sp,128
    80026b10:	8aaa                	mv	s5,a0
    80026b12:	8a2e                	mv	s4,a1
    80026b14:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80026b16:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80026b1a:	0001f517          	auipc	a0,0x1f
    80026b1e:	10650513          	addi	a0,a0,262 # 80045c20 <cons>
    80026b22:	ffffa097          	auipc	ra,0xffffa
    80026b26:	b90080e7          	jalr	-1136(ra) # 800206b2 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80026b2a:	0001f497          	auipc	s1,0x1f
    80026b2e:	0f648493          	addi	s1,s1,246 # 80045c20 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80026b32:	0001f917          	auipc	s2,0x1f
    80026b36:	18690913          	addi	s2,s2,390 # 80045cb8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    80026b3a:	4c11                	li	s8,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80026b3c:	f8f40d13          	addi	s10,s0,-113
    80026b40:	5cfd                	li	s9,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80026b42:	4da9                	li	s11,10
  while(n > 0){
    80026b44:	07305763          	blez	s3,80026bb2 <consoleread+0xc0>
    while(cons.r == cons.w){
    80026b48:	0984a783          	lw	a5,152(s1)
    80026b4c:	09c4a703          	lw	a4,156(s1)
    80026b50:	02f71463          	bne	a4,a5,80026b78 <consoleread+0x86>
      if(myproc()->killed){
    80026b54:	ffffb097          	auipc	ra,0xffffb
    80026b58:	f7e080e7          	jalr	-130(ra) # 80021ad2 <myproc>
    80026b5c:	591c                	lw	a5,48(a0)
    80026b5e:	e7ad                	bnez	a5,80026bc8 <consoleread+0xd6>
      sleep(&cons.r, &cons.lock);
    80026b60:	85a6                	mv	a1,s1
    80026b62:	854a                	mv	a0,s2
    80026b64:	ffffb097          	auipc	ra,0xffffb
    80026b68:	7ec080e7          	jalr	2028(ra) # 80022350 <sleep>
    while(cons.r == cons.w){
    80026b6c:	0984a783          	lw	a5,152(s1)
    80026b70:	09c4a703          	lw	a4,156(s1)
    80026b74:	fef700e3          	beq	a4,a5,80026b54 <consoleread+0x62>
    c = cons.buf[cons.r++ % INPUT_BUF];
    80026b78:	0017871b          	addiw	a4,a5,1
    80026b7c:	08e4ac23          	sw	a4,152(s1)
    80026b80:	07f7f713          	andi	a4,a5,127
    80026b84:	9726                	add	a4,a4,s1
    80026b86:	01874703          	lbu	a4,24(a4) # 8000018 <_start-0x7801ffe8>
    80026b8a:	00070b9b          	sext.w	s7,a4
    if(c == C('D')){  // end-of-file
    80026b8e:	078b8563          	beq	s7,s8,80026bf8 <consoleread+0x106>
    cbuf = c;
    80026b92:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80026b96:	4685                	li	a3,1
    80026b98:	866a                	mv	a2,s10
    80026b9a:	85d2                	mv	a1,s4
    80026b9c:	8556                	mv	a0,s5
    80026b9e:	ffffc097          	auipc	ra,0xffffc
    80026ba2:	a08080e7          	jalr	-1528(ra) # 800225a6 <either_copyout>
    80026ba6:	01950663          	beq	a0,s9,80026bb2 <consoleread+0xc0>
    dst++;
    80026baa:	0a05                	addi	s4,s4,1
    --n;
    80026bac:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    80026bae:	f9bb9be3          	bne	s7,s11,80026b44 <consoleread+0x52>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80026bb2:	0001f517          	auipc	a0,0x1f
    80026bb6:	06e50513          	addi	a0,a0,110 # 80045c20 <cons>
    80026bba:	ffffa097          	auipc	ra,0xffffa
    80026bbe:	b4c080e7          	jalr	-1204(ra) # 80020706 <release>

  return target - n;
    80026bc2:	413b053b          	subw	a0,s6,s3
    80026bc6:	a811                	j	80026bda <consoleread+0xe8>
        release(&cons.lock);
    80026bc8:	0001f517          	auipc	a0,0x1f
    80026bcc:	05850513          	addi	a0,a0,88 # 80045c20 <cons>
    80026bd0:	ffffa097          	auipc	ra,0xffffa
    80026bd4:	b36080e7          	jalr	-1226(ra) # 80020706 <release>
        return -1;
    80026bd8:	557d                	li	a0,-1
}
    80026bda:	70e6                	ld	ra,120(sp)
    80026bdc:	7446                	ld	s0,112(sp)
    80026bde:	74a6                	ld	s1,104(sp)
    80026be0:	7906                	ld	s2,96(sp)
    80026be2:	69e6                	ld	s3,88(sp)
    80026be4:	6a46                	ld	s4,80(sp)
    80026be6:	6aa6                	ld	s5,72(sp)
    80026be8:	6b06                	ld	s6,64(sp)
    80026bea:	7be2                	ld	s7,56(sp)
    80026bec:	7c42                	ld	s8,48(sp)
    80026bee:	7ca2                	ld	s9,40(sp)
    80026bf0:	7d02                	ld	s10,32(sp)
    80026bf2:	6de2                	ld	s11,24(sp)
    80026bf4:	6109                	addi	sp,sp,128
    80026bf6:	8082                	ret
      if(n < target){
    80026bf8:	0009871b          	sext.w	a4,s3
    80026bfc:	fb677be3          	bgeu	a4,s6,80026bb2 <consoleread+0xc0>
        cons.r--;
    80026c00:	0001f717          	auipc	a4,0x1f
    80026c04:	0af72c23          	sw	a5,184(a4) # 80045cb8 <cons+0x98>
    80026c08:	b76d                	j	80026bb2 <consoleread+0xc0>

0000000080026c0a <consputc>:
void consputc(int c) {
    80026c0a:	1141                	addi	sp,sp,-16
    80026c0c:	e422                	sd	s0,8(sp)
    80026c0e:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80026c10:	10000793          	li	a5,256
    80026c14:	00f50b63          	beq	a0,a5,80026c2a <consputc+0x20>
    80026c18:	4581                	li	a1,0
    80026c1a:	4601                	li	a2,0
    80026c1c:	4681                	li	a3,0
    80026c1e:	4885                	li	a7,1
    80026c20:	00000073          	ecall
}
    80026c24:	6422                	ld	s0,8(sp)
    80026c26:	0141                	addi	sp,sp,16
    80026c28:	8082                	ret
    80026c2a:	4521                	li	a0,8
    80026c2c:	4581                	li	a1,0
    80026c2e:	4601                	li	a2,0
    80026c30:	4681                	li	a3,0
    80026c32:	4885                	li	a7,1
    80026c34:	00000073          	ecall
    80026c38:	02000513          	li	a0,32
    80026c3c:	00000073          	ecall
    80026c40:	4521                	li	a0,8
    80026c42:	00000073          	ecall
}
    80026c46:	bff9                	j	80026c24 <consputc+0x1a>

0000000080026c48 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80026c48:	1101                	addi	sp,sp,-32
    80026c4a:	ec06                	sd	ra,24(sp)
    80026c4c:	e822                	sd	s0,16(sp)
    80026c4e:	e426                	sd	s1,8(sp)
    80026c50:	e04a                	sd	s2,0(sp)
    80026c52:	1000                	addi	s0,sp,32
    80026c54:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80026c56:	0001f517          	auipc	a0,0x1f
    80026c5a:	fca50513          	addi	a0,a0,-54 # 80045c20 <cons>
    80026c5e:	ffffa097          	auipc	ra,0xffffa
    80026c62:	a54080e7          	jalr	-1452(ra) # 800206b2 <acquire>

  switch(c){
    80026c66:	47d5                	li	a5,21
    80026c68:	0cf48163          	beq	s1,a5,80026d2a <consoleintr+0xe2>
    80026c6c:	0297ca63          	blt	a5,s1,80026ca0 <consoleintr+0x58>
    80026c70:	47a1                	li	a5,8
    80026c72:	10f48263          	beq	s1,a5,80026d76 <consoleintr+0x12e>
    80026c76:	47c1                	li	a5,16
    80026c78:	12f49563          	bne	s1,a5,80026da2 <consoleintr+0x15a>
  case C('P'):  // Print process list.
    procdump();
    80026c7c:	ffffc097          	auipc	ra,0xffffc
    80026c80:	994080e7          	jalr	-1644(ra) # 80022610 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80026c84:	0001f517          	auipc	a0,0x1f
    80026c88:	f9c50513          	addi	a0,a0,-100 # 80045c20 <cons>
    80026c8c:	ffffa097          	auipc	ra,0xffffa
    80026c90:	a7a080e7          	jalr	-1414(ra) # 80020706 <release>
}
    80026c94:	60e2                	ld	ra,24(sp)
    80026c96:	6442                	ld	s0,16(sp)
    80026c98:	64a2                	ld	s1,8(sp)
    80026c9a:	6902                	ld	s2,0(sp)
    80026c9c:	6105                	addi	sp,sp,32
    80026c9e:	8082                	ret
  switch(c){
    80026ca0:	07f00793          	li	a5,127
    80026ca4:	0cf48963          	beq	s1,a5,80026d76 <consoleintr+0x12e>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80026ca8:	0001f717          	auipc	a4,0x1f
    80026cac:	f7870713          	addi	a4,a4,-136 # 80045c20 <cons>
    80026cb0:	0a072783          	lw	a5,160(a4)
    80026cb4:	09872703          	lw	a4,152(a4)
    80026cb8:	9f99                	subw	a5,a5,a4
    80026cba:	07f00713          	li	a4,127
    80026cbe:	fcf763e3          	bltu	a4,a5,80026c84 <consoleintr+0x3c>
      if (c == '\r') break;     // on k210, "enter" will input \n and \r
    80026cc2:	47b5                	li	a5,13
    80026cc4:	fcf480e3          	beq	s1,a5,80026c84 <consoleintr+0x3c>
      consputc(c);
    80026cc8:	8526                	mv	a0,s1
    80026cca:	00000097          	auipc	ra,0x0
    80026cce:	f40080e7          	jalr	-192(ra) # 80026c0a <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80026cd2:	0001f797          	auipc	a5,0x1f
    80026cd6:	f4e78793          	addi	a5,a5,-178 # 80045c20 <cons>
    80026cda:	0a07a703          	lw	a4,160(a5)
    80026cde:	0017069b          	addiw	a3,a4,1
    80026ce2:	0006861b          	sext.w	a2,a3
    80026ce6:	0ad7a023          	sw	a3,160(a5)
    80026cea:	07f77713          	andi	a4,a4,127
    80026cee:	97ba                	add	a5,a5,a4
    80026cf0:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80026cf4:	47a9                	li	a5,10
    80026cf6:	00f48d63          	beq	s1,a5,80026d10 <consoleintr+0xc8>
    80026cfa:	4791                	li	a5,4
    80026cfc:	00f48a63          	beq	s1,a5,80026d10 <consoleintr+0xc8>
    80026d00:	0001f797          	auipc	a5,0x1f
    80026d04:	fb87a783          	lw	a5,-72(a5) # 80045cb8 <cons+0x98>
    80026d08:	0807879b          	addiw	a5,a5,128
    80026d0c:	f6c79ce3          	bne	a5,a2,80026c84 <consoleintr+0x3c>
        cons.w = cons.e;
    80026d10:	0001f797          	auipc	a5,0x1f
    80026d14:	fad7a623          	sw	a3,-84(a5) # 80045cbc <cons+0x9c>
        wakeup(&cons.r);
    80026d18:	0001f517          	auipc	a0,0x1f
    80026d1c:	fa050513          	addi	a0,a0,-96 # 80045cb8 <cons+0x98>
    80026d20:	ffffb097          	auipc	ra,0xffffb
    80026d24:	7ac080e7          	jalr	1964(ra) # 800224cc <wakeup>
    80026d28:	bfb1                	j	80026c84 <consoleintr+0x3c>
    while(cons.e != cons.w &&
    80026d2a:	0001f717          	auipc	a4,0x1f
    80026d2e:	ef670713          	addi	a4,a4,-266 # 80045c20 <cons>
    80026d32:	0a072783          	lw	a5,160(a4)
    80026d36:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80026d3a:	0001f497          	auipc	s1,0x1f
    80026d3e:	ee648493          	addi	s1,s1,-282 # 80045c20 <cons>
    while(cons.e != cons.w &&
    80026d42:	4929                	li	s2,10
    80026d44:	f4f700e3          	beq	a4,a5,80026c84 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80026d48:	37fd                	addiw	a5,a5,-1
    80026d4a:	07f7f713          	andi	a4,a5,127
    80026d4e:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80026d50:	01874703          	lbu	a4,24(a4)
    80026d54:	f32708e3          	beq	a4,s2,80026c84 <consoleintr+0x3c>
      cons.e--;
    80026d58:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80026d5c:	10000513          	li	a0,256
    80026d60:	00000097          	auipc	ra,0x0
    80026d64:	eaa080e7          	jalr	-342(ra) # 80026c0a <consputc>
    while(cons.e != cons.w &&
    80026d68:	0a04a783          	lw	a5,160(s1)
    80026d6c:	09c4a703          	lw	a4,156(s1)
    80026d70:	fcf71ce3          	bne	a4,a5,80026d48 <consoleintr+0x100>
    80026d74:	bf01                	j	80026c84 <consoleintr+0x3c>
    if(cons.e != cons.w){
    80026d76:	0001f717          	auipc	a4,0x1f
    80026d7a:	eaa70713          	addi	a4,a4,-342 # 80045c20 <cons>
    80026d7e:	0a072783          	lw	a5,160(a4)
    80026d82:	09c72703          	lw	a4,156(a4)
    80026d86:	eef70fe3          	beq	a4,a5,80026c84 <consoleintr+0x3c>
      cons.e--;
    80026d8a:	37fd                	addiw	a5,a5,-1
    80026d8c:	0001f717          	auipc	a4,0x1f
    80026d90:	f2f72a23          	sw	a5,-204(a4) # 80045cc0 <cons+0xa0>
      consputc(BACKSPACE);
    80026d94:	10000513          	li	a0,256
    80026d98:	00000097          	auipc	ra,0x0
    80026d9c:	e72080e7          	jalr	-398(ra) # 80026c0a <consputc>
    80026da0:	b5d5                	j	80026c84 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80026da2:	ee0481e3          	beqz	s1,80026c84 <consoleintr+0x3c>
    80026da6:	b709                	j	80026ca8 <consoleintr+0x60>

0000000080026da8 <consoleinit>:

void
consoleinit(void)
{
    80026da8:	1101                	addi	sp,sp,-32
    80026daa:	ec06                	sd	ra,24(sp)
    80026dac:	e822                	sd	s0,16(sp)
    80026dae:	e426                	sd	s1,8(sp)
    80026db0:	1000                	addi	s0,sp,32
  initlock(&cons.lock, "cons");
    80026db2:	0001f497          	auipc	s1,0x1f
    80026db6:	e6e48493          	addi	s1,s1,-402 # 80045c20 <cons>
    80026dba:	00005597          	auipc	a1,0x5
    80026dbe:	e0658593          	addi	a1,a1,-506 # 8002bbc0 <digits+0x938>
    80026dc2:	8526                	mv	a0,s1
    80026dc4:	ffffa097          	auipc	ra,0xffffa
    80026dc8:	8aa080e7          	jalr	-1878(ra) # 8002066e <initlock>

  cons.e = cons.w = cons.r = 0;
    80026dcc:	0804ac23          	sw	zero,152(s1)
    80026dd0:	0804ae23          	sw	zero,156(s1)
    80026dd4:	0a04a023          	sw	zero,160(s1)
  
  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80026dd8:	00007797          	auipc	a5,0x7
    80026ddc:	7287b783          	ld	a5,1832(a5) # 8002e500 <_GLOBAL_OFFSET_TABLE_+0x58>
    80026de0:	00000717          	auipc	a4,0x0
    80026de4:	d1270713          	addi	a4,a4,-750 # 80026af2 <consoleread>
    80026de8:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80026dea:	00000717          	auipc	a4,0x0
    80026dee:	c7c70713          	addi	a4,a4,-900 # 80026a66 <consolewrite>
    80026df2:	ef98                	sd	a4,24(a5)
}
    80026df4:	60e2                	ld	ra,24(sp)
    80026df6:	6442                	ld	s0,16(sp)
    80026df8:	64a2                	ld	s1,8(sp)
    80026dfa:	6105                	addi	sp,sp,32
    80026dfc:	8082                	ret

0000000080026dfe <spi_set_tmod>:
    spi_adapter->endian = endian;
}


static void spi_set_tmod(uint8 spi_num, uint32 tmod)
{
    80026dfe:	1141                	addi	sp,sp,-16
    80026e00:	e406                	sd	ra,8(sp)
    80026e02:	e022                	sd	s0,0(sp)
    80026e04:	0800                	addi	s0,sp,16
    80026e06:	87aa                	mv	a5,a0
    // configASSERT(spi_num < SPI_DEVICE_MAX);
    volatile spi_t *spi_handle = spi[spi_num];
    80026e08:	00351693          	slli	a3,a0,0x3
    80026e0c:	00005717          	auipc	a4,0x5
    80026e10:	dbc70713          	addi	a4,a4,-580 # 8002bbc8 <spi>
    80026e14:	9736                	add	a4,a4,a3
    80026e16:	6308                	ld	a0,0(a4)
    uint8 tmod_offset = 0;
    switch(spi_num)
    80026e18:	4689                	li	a3,2
    {
        case 0:
        case 1:
        case 2:
            tmod_offset = 8;
    80026e1a:	4721                	li	a4,8
    switch(spi_num)
    80026e1c:	00f6f363          	bgeu	a3,a5,80026e22 <spi_set_tmod+0x24>
            break;
        case 3:
        default:
            tmod_offset = 10;
    80026e20:	4729                	li	a4,10
            break;
    }
    set_bit(&spi_handle->ctrlr0, 3 << tmod_offset, tmod << tmod_offset);
    80026e22:	00e5963b          	sllw	a2,a1,a4
    80026e26:	458d                	li	a1,3
    80026e28:	00e595bb          	sllw	a1,a1,a4
    80026e2c:	00001097          	auipc	ra,0x1
    80026e30:	f5e080e7          	jalr	-162(ra) # 80027d8a <set_bit>
}
    80026e34:	60a2                	ld	ra,8(sp)
    80026e36:	6402                	ld	s0,0(sp)
    80026e38:	0141                	addi	sp,sp,16
    80026e3a:	8082                	ret

0000000080026e3c <spi_init>:
{
    80026e3c:	1141                	addi	sp,sp,-16
    80026e3e:	e422                	sd	s0,8(sp)
    80026e40:	0800                	addi	s0,sp,16
    switch(spi_num)
    80026e42:	4785                	li	a5,1
    80026e44:	06a7f463          	bgeu	a5,a0,80026eac <spi_init+0x70>
    80026e48:	4789                	li	a5,2
    80026e4a:	06f51563          	bne	a0,a5,80026eb4 <spi_init+0x78>
    uint8 work_mode_offset = 0;
    80026e4e:	4301                	li	t1,0
    uint8 frf_offset = 0;
    80026e50:	4881                	li	a7,0
    uint8 dfs_offset = 0;
    80026e52:	4801                	li	a6,0
    volatile spi_t *spi_adapter = spi[spi_num];
    80026e54:	1502                	slli	a0,a0,0x20
    80026e56:	9101                	srli	a0,a0,0x20
    80026e58:	050e                	slli	a0,a0,0x3
    80026e5a:	00005797          	auipc	a5,0x5
    80026e5e:	d6e78793          	addi	a5,a5,-658 # 8002bbc8 <spi>
    80026e62:	953e                	add	a0,a0,a5
    80026e64:	611c                	ld	a5,0(a0)
    if(spi_adapter->baudr == 0)
    80026e66:	4bc8                	lw	a0,20(a5)
    80026e68:	2501                	sext.w	a0,a0
    80026e6a:	e119                	bnez	a0,80026e70 <spi_init+0x34>
        spi_adapter->baudr = 0x14;
    80026e6c:	4551                	li	a0,20
    80026e6e:	cbc8                	sw	a0,20(a5)
    spi_adapter->imr = 0x00;
    80026e70:	0207a623          	sw	zero,44(a5)
    spi_adapter->dmacr = 0x00;
    80026e74:	0407a623          	sw	zero,76(a5)
    spi_adapter->dmatdlr = 0x10;
    80026e78:	4541                	li	a0,16
    80026e7a:	cba8                	sw	a0,80(a5)
    spi_adapter->dmardlr = 0x00;
    80026e7c:	0407aa23          	sw	zero,84(a5)
    spi_adapter->ser = 0x00;
    80026e80:	0007a823          	sw	zero,16(a5)
    spi_adapter->ssienr = 0x00;
    80026e84:	0007a423          	sw	zero,8(a5)
    spi_adapter->ctrlr0 = (work_mode << work_mode_offset) | (frame_format << frf_offset) | ((data_bit_length - 1) << dfs_offset);
    80026e88:	006595bb          	sllw	a1,a1,t1
    80026e8c:	0116163b          	sllw	a2,a2,a7
    80026e90:	8dd1                	or	a1,a1,a2
    80026e92:	16fd                	addi	a3,a3,-1
    80026e94:	010696b3          	sll	a3,a3,a6
    80026e98:	8dd5                	or	a1,a1,a3
    80026e9a:	2581                	sext.w	a1,a1
    80026e9c:	c38c                	sw	a1,0(a5)
    spi_adapter->spi_ctrlr0 = 0;
    80026e9e:	0e07aa23          	sw	zero,244(a5)
    spi_adapter->endian = endian;
    80026ea2:	10e7ac23          	sw	a4,280(a5)
}
    80026ea6:	6422                	ld	s0,8(sp)
    80026ea8:	0141                	addi	sp,sp,16
    80026eaa:	8082                	ret
    switch(spi_num)
    80026eac:	4319                	li	t1,6
    80026eae:	48d5                	li	a7,21
    80026eb0:	4841                	li	a6,16
    80026eb2:	b74d                	j	80026e54 <spi_init+0x18>
            work_mode_offset = 8;
    80026eb4:	4321                	li	t1,8
            frf_offset = 22;
    80026eb6:	48d9                	li	a7,22
            dfs_offset = 0;
    80026eb8:	4801                	li	a6,0
    80026eba:	bf69                	j	80026e54 <spi_init+0x18>

0000000080026ebc <spi_send_data_normal>:
        return SPI_TRANS_SHORT;
    return SPI_TRANS_INT;
}

void spi_send_data_normal(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *tx_buff, uint64 tx_len)
{
    80026ebc:	7175                	addi	sp,sp,-144
    80026ebe:	e506                	sd	ra,136(sp)
    80026ec0:	e122                	sd	s0,128(sp)
    80026ec2:	fca6                	sd	s1,120(sp)
    80026ec4:	f8ca                	sd	s2,112(sp)
    80026ec6:	f4ce                	sd	s3,104(sp)
    80026ec8:	f0d2                	sd	s4,96(sp)
    80026eca:	ecd6                	sd	s5,88(sp)
    80026ecc:	e8da                	sd	s6,80(sp)
    80026ece:	e4de                	sd	s7,72(sp)
    80026ed0:	e0e2                	sd	s8,64(sp)
    80026ed2:	fc66                	sd	s9,56(sp)
    80026ed4:	f86a                	sd	s10,48(sp)
    80026ed6:	f46e                	sd	s11,40(sp)
    80026ed8:	0900                	addi	s0,sp,144
    80026eda:	84aa                	mv	s1,a0
    80026edc:	8aae                	mv	s5,a1
    80026ede:	89b2                	mv	s3,a2
    80026ee0:	8a36                	mv	s4,a3
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    uint64 index, fifo_len;
    spi_set_tmod(spi_num, SPI_TMOD_TRANS);
    80026ee2:	4585                	li	a1,1
    80026ee4:	0ff57513          	andi	a0,a0,255
    80026ee8:	00000097          	auipc	ra,0x0
    80026eec:	f16080e7          	jalr	-234(ra) # 80026dfe <spi_set_tmod>

    volatile spi_t *spi_handle = spi[spi_num];
    80026ef0:	02049793          	slli	a5,s1,0x20
    80026ef4:	9381                	srli	a5,a5,0x20
    80026ef6:	00379713          	slli	a4,a5,0x3
    80026efa:	00005797          	auipc	a5,0x5
    80026efe:	cce78793          	addi	a5,a5,-818 # 8002bbc8 <spi>
    80026f02:	97ba                	add	a5,a5,a4
    80026f04:	0007b903          	ld	s2,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80026f08:	0024b493          	sltiu	s1,s1,2
    80026f0c:	0492                	slli	s1,s1,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    80026f0e:	00092783          	lw	a5,0(s2)
    80026f12:	0097d4bb          	srlw	s1,a5,s1
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80026f16:	88fd                	andi	s1,s1,31
    if(data_bit_length < 8)
    80026f18:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    80026f1a:	4d05                	li	s10,1
    if(data_bit_length < 8)
    80026f1c:	0097f663          	bgeu	a5,s1,80026f28 <spi_send_data_normal+0x6c>
    else if(data_bit_length < 16)
    80026f20:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    80026f22:	4d11                	li	s10,4
    else if(data_bit_length < 16)
    80026f24:	0297fa63          	bgeu	a5,s1,80026f58 <spi_send_data_normal+0x9c>

    uint8 v_misalign_flag = 0;
    uint32 v_send_data;
    if((uintptr_t)tx_buff % frame_width)
    80026f28:	020d1793          	slli	a5,s10,0x20
    80026f2c:	9381                	srli	a5,a5,0x20
    80026f2e:	02f9f7b3          	remu	a5,s3,a5
    80026f32:	f6f43c23          	sd	a5,-136(s0)
        v_misalign_flag = 1;

    spi_handle->ssienr = 0x01;
    80026f36:	4785                	li	a5,1
    80026f38:	00f92423          	sw	a5,8(s2)
    spi_handle->ser = 1U << chip_select;
    80026f3c:	015797bb          	sllw	a5,a5,s5
    80026f40:	00f92823          	sw	a5,16(s2)
    uint32 i = 0;
    while(tx_len)
    80026f44:	120a0663          	beqz	s4,80027070 <spi_send_data_normal+0x1b4>
    uint32 i = 0;
    80026f48:	4481                	li	s1,0
    {
        fifo_len = 32 - spi_handle->txflr;
    80026f4a:	02000d93          	li	s11,32
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
        switch(frame_width)
    80026f4e:	4c89                	li	s9,2
                if(v_misalign_flag)
                {
                    for(index = 0; index < fifo_len; index += 2)
                    {
                        // memcpy(&v_send_data, tx_buff + i, 2);
                        memmove(&v_send_data, tx_buff + i, 2);
    80026f50:	f8c40b93          	addi	s7,s0,-116
        switch(frame_width)
    80026f54:	4c11                	li	s8,4
    80026f56:	a0a5                	j	80026fbe <spi_send_data_normal+0x102>
        return SPI_TRANS_SHORT;
    80026f58:	4d09                	li	s10,2
    80026f5a:	b7f9                	j	80026f28 <spi_send_data_normal+0x6c>
                fifo_len = fifo_len / 4 * 4;
    80026f5c:	ffc6fb13          	andi	s6,a3,-4
                if(v_misalign_flag)
    80026f60:	f7843783          	ld	a5,-136(s0)
    80026f64:	e785                	bnez	a5,80026f8c <spi_send_data_normal+0xd0>
                    for(index = 0; index < fifo_len / 4; index++)
    80026f66:	8289                	srli	a3,a3,0x2
    80026f68:	0096863b          	addw	a2,a3,s1
    80026f6c:	8726                	mv	a4,s1
    80026f6e:	c6a1                	beqz	a3,80026fb6 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint32 *)tx_buff)[i++];
    80026f70:	0007079b          	sext.w	a5,a4
    80026f74:	2705                	addiw	a4,a4,1
    80026f76:	1782                	slli	a5,a5,0x20
    80026f78:	9381                	srli	a5,a5,0x20
    80026f7a:	078a                	slli	a5,a5,0x2
    80026f7c:	97ce                	add	a5,a5,s3
    80026f7e:	439c                	lw	a5,0(a5)
    80026f80:	06f92023          	sw	a5,96(s2)
                    for(index = 0; index < fifo_len / 4; index++)
    80026f84:	fee616e3          	bne	a2,a4,80026f70 <spi_send_data_normal+0xb4>
                        spi_handle->dr[0] = ((uint32 *)tx_buff)[i++];
    80026f88:	9cb5                	addw	s1,s1,a3
    80026f8a:	a035                	j	80026fb6 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 4)
    80026f8c:	020b0563          	beqz	s6,80026fb6 <spi_send_data_normal+0xfa>
    80026f90:	4a81                	li	s5,0
                        memmove(&v_send_data, tx_buff + i, 4);
    80026f92:	02049593          	slli	a1,s1,0x20
    80026f96:	9181                	srli	a1,a1,0x20
    80026f98:	8662                	mv	a2,s8
    80026f9a:	95ce                	add	a1,a1,s3
    80026f9c:	855e                	mv	a0,s7
    80026f9e:	ffffa097          	auipc	ra,0xffffa
    80026fa2:	80c080e7          	jalr	-2036(ra) # 800207aa <memmove>
                        spi_handle->dr[0] = v_send_data;
    80026fa6:	f8c42783          	lw	a5,-116(s0)
    80026faa:	06f92023          	sw	a5,96(s2)
                        i += 4;
    80026fae:	2491                	addiw	s1,s1,4
                    for(index = 0; index < fifo_len; index += 4)
    80026fb0:	0a91                	addi	s5,s5,4
    80026fb2:	ff6ae0e3          	bltu	s5,s6,80026f92 <spi_send_data_normal+0xd6>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = tx_buff[i++];
                break;
        }
        tx_len -= fifo_len;
    80026fb6:	416a0a33          	sub	s4,s4,s6
    while(tx_len)
    80026fba:	0a0a0b63          	beqz	s4,80027070 <spi_send_data_normal+0x1b4>
        fifo_len = 32 - spi_handle->txflr;
    80026fbe:	02092683          	lw	a3,32(s2)
    80026fc2:	40dd86bb          	subw	a3,s11,a3
    80026fc6:	1682                	slli	a3,a3,0x20
    80026fc8:	9281                	srli	a3,a3,0x20
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    80026fca:	00da7363          	bgeu	s4,a3,80026fd0 <spi_send_data_normal+0x114>
    80026fce:	86d2                	mv	a3,s4
        switch(frame_width)
    80026fd0:	039d0863          	beq	s10,s9,80027000 <spi_send_data_normal+0x144>
    80026fd4:	f98d04e3          	beq	s10,s8,80026f5c <spi_send_data_normal+0xa0>
                for(index = 0; index < fifo_len; index++)
    80026fd8:	0096863b          	addw	a2,a3,s1
    80026fdc:	8726                	mv	a4,s1
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    80026fde:	8b36                	mv	s6,a3
                for(index = 0; index < fifo_len; index++)
    80026fe0:	daf9                	beqz	a3,80026fb6 <spi_send_data_normal+0xfa>
                    spi_handle->dr[0] = tx_buff[i++];
    80026fe2:	0007079b          	sext.w	a5,a4
    80026fe6:	2705                	addiw	a4,a4,1
    80026fe8:	1782                	slli	a5,a5,0x20
    80026fea:	9381                	srli	a5,a5,0x20
    80026fec:	97ce                	add	a5,a5,s3
    80026fee:	0007c783          	lbu	a5,0(a5)
    80026ff2:	06f92023          	sw	a5,96(s2)
                for(index = 0; index < fifo_len; index++)
    80026ff6:	fee616e3          	bne	a2,a4,80026fe2 <spi_send_data_normal+0x126>
                    spi_handle->dr[0] = tx_buff[i++];
    80026ffa:	9cb5                	addw	s1,s1,a3
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    80026ffc:	8b36                	mv	s6,a3
    80026ffe:	bf65                	j	80026fb6 <spi_send_data_normal+0xfa>
                fifo_len = fifo_len / 2 * 2;
    80027000:	ffe6fb13          	andi	s6,a3,-2
                if(v_misalign_flag)
    80027004:	f7843783          	ld	a5,-136(s0)
    80027008:	e78d                	bnez	a5,80027032 <spi_send_data_normal+0x176>
                    for(index = 0; index < fifo_len / 2; index++)
    8002700a:	8285                	srli	a3,a3,0x1
    8002700c:	0096863b          	addw	a2,a3,s1
    80027010:	8726                	mv	a4,s1
    80027012:	d2d5                	beqz	a3,80026fb6 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint16 *)tx_buff)[i++];
    80027014:	0007079b          	sext.w	a5,a4
    80027018:	2705                	addiw	a4,a4,1
    8002701a:	1782                	slli	a5,a5,0x20
    8002701c:	9381                	srli	a5,a5,0x20
    8002701e:	0786                	slli	a5,a5,0x1
    80027020:	97ce                	add	a5,a5,s3
    80027022:	0007d783          	lhu	a5,0(a5)
    80027026:	06f92023          	sw	a5,96(s2)
                    for(index = 0; index < fifo_len / 2; index++)
    8002702a:	fee615e3          	bne	a2,a4,80027014 <spi_send_data_normal+0x158>
                        spi_handle->dr[0] = ((uint16 *)tx_buff)[i++];
    8002702e:	9cb5                	addw	s1,s1,a3
    80027030:	b759                	j	80026fb6 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 2)
    80027032:	f80b02e3          	beqz	s6,80026fb6 <spi_send_data_normal+0xfa>
    80027036:	fffb0a93          	addi	s5,s6,-1
    8002703a:	001ada93          	srli	s5,s5,0x1
    8002703e:	001a9a9b          	slliw	s5,s5,0x1
    80027042:	0024879b          	addiw	a5,s1,2
    80027046:	00fa8abb          	addw	s5,s5,a5
                        memmove(&v_send_data, tx_buff + i, 2);
    8002704a:	02049593          	slli	a1,s1,0x20
    8002704e:	9181                	srli	a1,a1,0x20
    80027050:	8666                	mv	a2,s9
    80027052:	95ce                	add	a1,a1,s3
    80027054:	855e                	mv	a0,s7
    80027056:	ffff9097          	auipc	ra,0xffff9
    8002705a:	754080e7          	jalr	1876(ra) # 800207aa <memmove>
                        spi_handle->dr[0] = v_send_data;
    8002705e:	f8c42783          	lw	a5,-116(s0)
    80027062:	06f92023          	sw	a5,96(s2)
                        i += 2;
    80027066:	2489                	addiw	s1,s1,2
                    for(index = 0; index < fifo_len; index += 2)
    80027068:	fe9a91e3          	bne	s5,s1,8002704a <spi_send_data_normal+0x18e>
                        i += 2;
    8002706c:	84d6                	mv	s1,s5
    8002706e:	b7a1                	j	80026fb6 <spi_send_data_normal+0xfa>
    }
    while((spi_handle->sr & 0x05) != 0x04)
    80027070:	4711                	li	a4,4
    80027072:	02892783          	lw	a5,40(s2)
    80027076:	8b95                	andi	a5,a5,5
    80027078:	fee79de3          	bne	a5,a4,80027072 <spi_send_data_normal+0x1b6>
        ;
    spi_handle->ser = 0x00;
    8002707c:	00092823          	sw	zero,16(s2)
    spi_handle->ssienr = 0x00;
    80027080:	00092423          	sw	zero,8(s2)
}
    80027084:	60aa                	ld	ra,136(sp)
    80027086:	640a                	ld	s0,128(sp)
    80027088:	74e6                	ld	s1,120(sp)
    8002708a:	7946                	ld	s2,112(sp)
    8002708c:	79a6                	ld	s3,104(sp)
    8002708e:	7a06                	ld	s4,96(sp)
    80027090:	6ae6                	ld	s5,88(sp)
    80027092:	6b46                	ld	s6,80(sp)
    80027094:	6ba6                	ld	s7,72(sp)
    80027096:	6c06                	ld	s8,64(sp)
    80027098:	7ce2                	ld	s9,56(sp)
    8002709a:	7d42                	ld	s10,48(sp)
    8002709c:	7da2                	ld	s11,40(sp)
    8002709e:	6149                	addi	sp,sp,144
    800270a0:	8082                	ret

00000000800270a2 <spi_send_data_standard>:

void spi_send_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                            uint64 cmd_len, const uint8 *tx_buff, uint64 tx_len)
{
    800270a2:	715d                	addi	sp,sp,-80
    800270a4:	e486                	sd	ra,72(sp)
    800270a6:	e0a2                	sd	s0,64(sp)
    800270a8:	fc26                	sd	s1,56(sp)
    800270aa:	f84a                	sd	s2,48(sp)
    800270ac:	f44e                	sd	s3,40(sp)
    800270ae:	f052                	sd	s4,32(sp)
    800270b0:	ec56                	sd	s5,24(sp)
    800270b2:	e85a                	sd	s6,16(sp)
    800270b4:	e45e                	sd	s7,8(sp)
    800270b6:	0880                	addi	s0,sp,80
    800270b8:	8a2a                	mv	s4,a0
    800270ba:	8aae                	mv	s5,a1
    800270bc:	8bb2                	mv	s7,a2
    800270be:	8936                	mv	s2,a3
    800270c0:	8b3a                	mv	s6,a4
    800270c2:	89be                	mv	s3,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    // uint8 *v_buf = malloc(cmd_len + tx_len);
    uint8 *v_buf = kalloc();
    800270c4:	ffff9097          	auipc	ra,0xffff9
    800270c8:	482080e7          	jalr	1154(ra) # 80020546 <kalloc>
    800270cc:	84aa                	mv	s1,a0
    uint64 i;
    for(i = 0; i < cmd_len; i++)
    800270ce:	00090e63          	beqz	s2,800270ea <spi_send_data_standard+0x48>
    800270d2:	885e                	mv	a6,s7
    800270d4:	88aa                	mv	a7,a0
    800270d6:	012b8633          	add	a2,s7,s2
        v_buf[i] = cmd_buff[i];
    800270da:	00084303          	lbu	t1,0(a6)
    800270de:	00688023          	sb	t1,0(a7) # a000000 <_start-0x76020000>
    for(i = 0; i < cmd_len; i++)
    800270e2:	0805                	addi	a6,a6,1
    800270e4:	0885                	addi	a7,a7,1
    800270e6:	fec81ae3          	bne	a6,a2,800270da <spi_send_data_standard+0x38>
    for(i = 0; i < tx_len; i++)
    800270ea:	00098f63          	beqz	s3,80027108 <spi_send_data_standard+0x66>
    800270ee:	885a                	mv	a6,s6
    800270f0:	012488b3          	add	a7,s1,s2
    800270f4:	013b07b3          	add	a5,s6,s3
        v_buf[cmd_len + i] = tx_buff[i];
    800270f8:	00084703          	lbu	a4,0(a6)
    800270fc:	00e88023          	sb	a4,0(a7)
    for(i = 0; i < tx_len; i++)
    80027100:	0805                	addi	a6,a6,1
    80027102:	0885                	addi	a7,a7,1
    80027104:	fef81ae3          	bne	a6,a5,800270f8 <spi_send_data_standard+0x56>

    spi_send_data_normal(spi_num, chip_select, v_buf, cmd_len + tx_len);
    80027108:	013906b3          	add	a3,s2,s3
    8002710c:	8626                	mv	a2,s1
    8002710e:	85d6                	mv	a1,s5
    80027110:	8552                	mv	a0,s4
    80027112:	00000097          	auipc	ra,0x0
    80027116:	daa080e7          	jalr	-598(ra) # 80026ebc <spi_send_data_normal>
    // free((void *)v_buf);
    kfree((void *)v_buf);
    8002711a:	8526                	mv	a0,s1
    8002711c:	ffff9097          	auipc	ra,0xffff9
    80027120:	312080e7          	jalr	786(ra) # 8002042e <kfree>
}
    80027124:	60a6                	ld	ra,72(sp)
    80027126:	6406                	ld	s0,64(sp)
    80027128:	74e2                	ld	s1,56(sp)
    8002712a:	7942                	ld	s2,48(sp)
    8002712c:	79a2                	ld	s3,40(sp)
    8002712e:	7a02                	ld	s4,32(sp)
    80027130:	6ae2                	ld	s5,24(sp)
    80027132:	6b42                	ld	s6,16(sp)
    80027134:	6ba2                	ld	s7,8(sp)
    80027136:	6161                	addi	sp,sp,80
    80027138:	8082                	ret

000000008002713a <spi_receive_data_standard>:

void spi_receive_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                               uint64 cmd_len, uint8 *rx_buff, uint64 rx_len)
{
    8002713a:	7139                	addi	sp,sp,-64
    8002713c:	fc06                	sd	ra,56(sp)
    8002713e:	f822                	sd	s0,48(sp)
    80027140:	f426                	sd	s1,40(sp)
    80027142:	f04a                	sd	s2,32(sp)
    80027144:	ec4e                	sd	s3,24(sp)
    80027146:	e852                	sd	s4,16(sp)
    80027148:	e456                	sd	s5,8(sp)
    8002714a:	e05a                	sd	s6,0(sp)
    8002714c:	0080                	addi	s0,sp,64
    8002714e:	89aa                	mv	s3,a0
    80027150:	8aae                	mv	s5,a1
    80027152:	8932                	mv	s2,a2
    80027154:	8a36                	mv	s4,a3
    80027156:	84ba                	mv	s1,a4
    80027158:	8b3e                	mv	s6,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    uint64 index, fifo_len;
    if(cmd_len == 0)
    8002715a:	eabd                	bnez	a3,800271d0 <spi_receive_data_standard+0x96>
        spi_set_tmod(spi_num, SPI_TMOD_RECV);
    8002715c:	4589                	li	a1,2
    8002715e:	0ff57513          	andi	a0,a0,255
    80027162:	00000097          	auipc	ra,0x0
    80027166:	c9c080e7          	jalr	-868(ra) # 80026dfe <spi_set_tmod>
    else
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    volatile spi_t *spi_handle = spi[spi_num];
    8002716a:	02099793          	slli	a5,s3,0x20
    8002716e:	9381                	srli	a5,a5,0x20
    80027170:	00379713          	slli	a4,a5,0x3
    80027174:	00005797          	auipc	a5,0x5
    80027178:	a5478793          	addi	a5,a5,-1452 # 8002bbc8 <spi>
    8002717c:	97ba                	add	a5,a5,a4
    8002717e:	6398                	ld	a4,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80027180:	0029b993          	sltiu	s3,s3,2
    80027184:	0992                	slli	s3,s3,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    80027186:	431c                	lw	a5,0(a4)
    80027188:	0137d9bb          	srlw	s3,a5,s3
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    8002718c:	01f9f993          	andi	s3,s3,31
    if(data_bit_length < 8)
    80027190:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    80027192:	4605                	li	a2,1
    if(data_bit_length < 8)
    80027194:	0137f663          	bgeu	a5,s3,800271a0 <spi_receive_data_standard+0x66>
    else if(data_bit_length < 16)
    80027198:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    8002719a:	4611                	li	a2,4
    else if(data_bit_length < 16)
    8002719c:	0537f263          	bgeu	a5,s3,800271e0 <spi_receive_data_standard+0xa6>

    uint32 i = 0;
    uint64 v_cmd_len = cmd_len / frame_width;
    800271a0:	02061693          	slli	a3,a2,0x20
    800271a4:	9281                	srli	a3,a3,0x20
    800271a6:	02da5833          	divu	a6,s4,a3
    uint32 v_rx_len = rx_len / frame_width;
    800271aa:	02db57b3          	divu	a5,s6,a3
    800271ae:	0007851b          	sext.w	a0,a5

    spi_handle->ctrlr1 = (uint32)(v_rx_len - 1);
    800271b2:	37fd                	addiw	a5,a5,-1
    800271b4:	c35c                	sw	a5,4(a4)
    spi_handle->ssienr = 0x01;
    800271b6:	4785                	li	a5,1
    800271b8:	c71c                	sw	a5,8(a4)

    while(v_cmd_len)
    800271ba:	0ada6d63          	bltu	s4,a3,80027274 <spi_receive_data_standard+0x13a>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = cmd_buff[i++];
                break;
        }
        spi_handle->ser = 1U << chip_select;
    800271be:	4305                	li	t1,1
    800271c0:	0153133b          	sllw	t1,t1,s5
    uint32 i = 0;
    800271c4:	4881                	li	a7,0
        fifo_len = 32 - spi_handle->txflr;
    800271c6:	02000f13          	li	t5,32
        switch(frame_width)
    800271ca:	4e89                	li	t4,2
    800271cc:	4e11                	li	t3,4
    800271ce:	a099                	j	80027214 <spi_receive_data_standard+0xda>
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    800271d0:	458d                	li	a1,3
    800271d2:	0ff57513          	andi	a0,a0,255
    800271d6:	00000097          	auipc	ra,0x0
    800271da:	c28080e7          	jalr	-984(ra) # 80026dfe <spi_set_tmod>
    800271de:	b771                	j	8002716a <spi_receive_data_standard+0x30>
        return SPI_TRANS_SHORT;
    800271e0:	4609                	li	a2,2
    800271e2:	bf7d                	j	800271a0 <spi_receive_data_standard+0x66>
                for(index = 0; index < fifo_len; index++)
    800271e4:	01158fbb          	addw	t6,a1,a7
    800271e8:	86c6                	mv	a3,a7
    800271ea:	cd99                	beqz	a1,80027208 <spi_receive_data_standard+0xce>
                    spi_handle->dr[0] = ((uint16 *)cmd_buff)[i++];
    800271ec:	0006879b          	sext.w	a5,a3
    800271f0:	2685                	addiw	a3,a3,1
    800271f2:	1782                	slli	a5,a5,0x20
    800271f4:	9381                	srli	a5,a5,0x20
    800271f6:	0786                	slli	a5,a5,0x1
    800271f8:	97ca                	add	a5,a5,s2
    800271fa:	0007d783          	lhu	a5,0(a5)
    800271fe:	d33c                	sw	a5,96(a4)
                for(index = 0; index < fifo_len; index++)
    80027200:	fedf96e3          	bne	t6,a3,800271ec <spi_receive_data_standard+0xb2>
                    spi_handle->dr[0] = ((uint16 *)cmd_buff)[i++];
    80027204:	00b888bb          	addw	a7,a7,a1
        spi_handle->ser = 1U << chip_select;
    80027208:	00672823          	sw	t1,16(a4)
        v_cmd_len -= fifo_len;
    8002720c:	40b80833          	sub	a6,a6,a1
    while(v_cmd_len)
    80027210:	06080b63          	beqz	a6,80027286 <spi_receive_data_standard+0x14c>
        fifo_len = 32 - spi_handle->txflr;
    80027214:	530c                	lw	a1,32(a4)
    80027216:	40bf05bb          	subw	a1,t5,a1
    8002721a:	1582                	slli	a1,a1,0x20
    8002721c:	9181                	srli	a1,a1,0x20
        fifo_len = fifo_len < v_cmd_len ? fifo_len : v_cmd_len;
    8002721e:	00b87363          	bgeu	a6,a1,80027224 <spi_receive_data_standard+0xea>
    80027222:	85c2                	mv	a1,a6
        switch(frame_width)
    80027224:	fdd600e3          	beq	a2,t4,800271e4 <spi_receive_data_standard+0xaa>
    80027228:	03c61463          	bne	a2,t3,80027250 <spi_receive_data_standard+0x116>
                for(index = 0; index < fifo_len; index++)
    8002722c:	01158fbb          	addw	t6,a1,a7
    80027230:	86c6                	mv	a3,a7
    80027232:	d9f9                	beqz	a1,80027208 <spi_receive_data_standard+0xce>
                    spi_handle->dr[0] = ((uint32 *)cmd_buff)[i++];
    80027234:	0006879b          	sext.w	a5,a3
    80027238:	2685                	addiw	a3,a3,1
    8002723a:	1782                	slli	a5,a5,0x20
    8002723c:	9381                	srli	a5,a5,0x20
    8002723e:	078a                	slli	a5,a5,0x2
    80027240:	97ca                	add	a5,a5,s2
    80027242:	439c                	lw	a5,0(a5)
    80027244:	d33c                	sw	a5,96(a4)
                for(index = 0; index < fifo_len; index++)
    80027246:	fedf97e3          	bne	t6,a3,80027234 <spi_receive_data_standard+0xfa>
                    spi_handle->dr[0] = ((uint32 *)cmd_buff)[i++];
    8002724a:	00b888bb          	addw	a7,a7,a1
    8002724e:	bf6d                	j	80027208 <spi_receive_data_standard+0xce>
                for(index = 0; index < fifo_len; index++)
    80027250:	01158fbb          	addw	t6,a1,a7
    80027254:	86c6                	mv	a3,a7
    80027256:	d9cd                	beqz	a1,80027208 <spi_receive_data_standard+0xce>
                    spi_handle->dr[0] = cmd_buff[i++];
    80027258:	0006879b          	sext.w	a5,a3
    8002725c:	2685                	addiw	a3,a3,1
    8002725e:	1782                	slli	a5,a5,0x20
    80027260:	9381                	srli	a5,a5,0x20
    80027262:	97ca                	add	a5,a5,s2
    80027264:	0007c783          	lbu	a5,0(a5)
    80027268:	d33c                	sw	a5,96(a4)
                for(index = 0; index < fifo_len; index++)
    8002726a:	fedf97e3          	bne	t6,a3,80027258 <spi_receive_data_standard+0x11e>
                    spi_handle->dr[0] = cmd_buff[i++];
    8002726e:	00b888bb          	addw	a7,a7,a1
    80027272:	bf59                	j	80027208 <spi_receive_data_standard+0xce>
    }

    if(cmd_len == 0)
    80027274:	000a1963          	bnez	s4,80027286 <spi_receive_data_standard+0x14c>
    {
        spi_handle->dr[0] = 0xffffffff;
    80027278:	57fd                	li	a5,-1
    8002727a:	d33c                	sw	a5,96(a4)
        spi_handle->ser = 1U << chip_select;
    8002727c:	4305                	li	t1,1
    8002727e:	0153133b          	sllw	t1,t1,s5
    80027282:	00672823          	sw	t1,16(a4)
    }

    i = 0;
    while(v_rx_len)
    80027286:	cd51                	beqz	a0,80027322 <spi_receive_data_standard+0x1e8>
    80027288:	4881                	li	a7,0
    {
        fifo_len = spi_handle->rxflr;
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
        switch(frame_width)
    8002728a:	4e09                	li	t3,2
    8002728c:	4311                	li	t1,4
    8002728e:	a035                	j	800272ba <spi_receive_data_standard+0x180>
            case SPI_TRANS_INT:
                for(index = 0; index < fifo_len; index++)
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
                break;
            case SPI_TRANS_SHORT:
                for(index = 0; index < fifo_len; index++)
    80027290:	01158ebb          	addw	t4,a1,a7
    80027294:	86c6                	mv	a3,a7
    80027296:	c185                	beqz	a1,800272b6 <spi_receive_data_standard+0x17c>
                    ((uint16 *)rx_buff)[i++] = (uint16)spi_handle->dr[0];
    80027298:	06072803          	lw	a6,96(a4)
    8002729c:	0006879b          	sext.w	a5,a3
    800272a0:	2685                	addiw	a3,a3,1
    800272a2:	1782                	slli	a5,a5,0x20
    800272a4:	9381                	srli	a5,a5,0x20
    800272a6:	0786                	slli	a5,a5,0x1
    800272a8:	97a6                	add	a5,a5,s1
    800272aa:	01079023          	sh	a6,0(a5)
                for(index = 0; index < fifo_len; index++)
    800272ae:	fede95e3          	bne	t4,a3,80027298 <spi_receive_data_standard+0x15e>
                    ((uint16 *)rx_buff)[i++] = (uint16)spi_handle->dr[0];
    800272b2:	00b888bb          	addw	a7,a7,a1
                for(index = 0; index < fifo_len; index++)
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
                break;
        }

        v_rx_len -= fifo_len;
    800272b6:	9d0d                	subw	a0,a0,a1
    while(v_rx_len)
    800272b8:	c52d                	beqz	a0,80027322 <spi_receive_data_standard+0x1e8>
        fifo_len = spi_handle->rxflr;
    800272ba:	535c                	lw	a5,36(a4)
    800272bc:	1782                	slli	a5,a5,0x20
    800272be:	9381                	srli	a5,a5,0x20
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
    800272c0:	02051593          	slli	a1,a0,0x20
    800272c4:	9181                	srli	a1,a1,0x20
    800272c6:	00b7f363          	bgeu	a5,a1,800272cc <spi_receive_data_standard+0x192>
    800272ca:	85be                	mv	a1,a5
        switch(frame_width)
    800272cc:	fdc602e3          	beq	a2,t3,80027290 <spi_receive_data_standard+0x156>
    800272d0:	02661663          	bne	a2,t1,800272fc <spi_receive_data_standard+0x1c2>
                for(index = 0; index < fifo_len; index++)
    800272d4:	01158ebb          	addw	t4,a1,a7
    800272d8:	86c6                	mv	a3,a7
    800272da:	ddf1                	beqz	a1,800272b6 <spi_receive_data_standard+0x17c>
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
    800272dc:	0006879b          	sext.w	a5,a3
    800272e0:	2685                	addiw	a3,a3,1
    800272e2:	06072803          	lw	a6,96(a4)
    800272e6:	1782                	slli	a5,a5,0x20
    800272e8:	9381                	srli	a5,a5,0x20
    800272ea:	078a                	slli	a5,a5,0x2
    800272ec:	97a6                	add	a5,a5,s1
    800272ee:	0107a023          	sw	a6,0(a5)
                for(index = 0; index < fifo_len; index++)
    800272f2:	fede95e3          	bne	t4,a3,800272dc <spi_receive_data_standard+0x1a2>
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
    800272f6:	00b888bb          	addw	a7,a7,a1
    800272fa:	bf75                	j	800272b6 <spi_receive_data_standard+0x17c>
                for(index = 0; index < fifo_len; index++)
    800272fc:	01158ebb          	addw	t4,a1,a7
    80027300:	86c6                	mv	a3,a7
    80027302:	d9d5                	beqz	a1,800272b6 <spi_receive_data_standard+0x17c>
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
    80027304:	06072803          	lw	a6,96(a4)
    80027308:	0006879b          	sext.w	a5,a3
    8002730c:	2685                	addiw	a3,a3,1
    8002730e:	1782                	slli	a5,a5,0x20
    80027310:	9381                	srli	a5,a5,0x20
    80027312:	97a6                	add	a5,a5,s1
    80027314:	01078023          	sb	a6,0(a5)
                for(index = 0; index < fifo_len; index++)
    80027318:	fede96e3          	bne	t4,a3,80027304 <spi_receive_data_standard+0x1ca>
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
    8002731c:	00b888bb          	addw	a7,a7,a1
    80027320:	bf59                	j	800272b6 <spi_receive_data_standard+0x17c>
    }

    spi_handle->ser = 0x00;
    80027322:	00072823          	sw	zero,16(a4)
    spi_handle->ssienr = 0x00;
    80027326:	00072423          	sw	zero,8(a4)
}
    8002732a:	70e2                	ld	ra,56(sp)
    8002732c:	7442                	ld	s0,48(sp)
    8002732e:	74a2                	ld	s1,40(sp)
    80027330:	7902                	ld	s2,32(sp)
    80027332:	69e2                	ld	s3,24(sp)
    80027334:	6a42                	ld	s4,16(sp)
    80027336:	6aa2                	ld	s5,8(sp)
    80027338:	6b02                	ld	s6,0(sp)
    8002733a:	6121                	addi	sp,sp,64
    8002733c:	8082                	ret

000000008002733e <spi_receive_data_normal_dma>:

void spi_receive_data_normal_dma(dmac_channel_number_t dma_send_channel_num,
                                 dmac_channel_number_t dma_receive_channel_num,
                                 spi_device_num_t spi_num, spi_chip_select_t chip_select, const void *cmd_buff,
                                 uint64 cmd_len, void *rx_buff, uint64 rx_len)
{
    8002733e:	711d                	addi	sp,sp,-96
    80027340:	ec86                	sd	ra,88(sp)
    80027342:	e8a2                	sd	s0,80(sp)
    80027344:	e4a6                	sd	s1,72(sp)
    80027346:	e0ca                	sd	s2,64(sp)
    80027348:	fc4e                	sd	s3,56(sp)
    8002734a:	f852                	sd	s4,48(sp)
    8002734c:	f456                	sd	s5,40(sp)
    8002734e:	f05a                	sd	s6,32(sp)
    80027350:	ec5e                	sd	s7,24(sp)
    80027352:	e862                	sd	s8,16(sp)
    80027354:	e466                	sd	s9,8(sp)
    80027356:	e06a                	sd	s10,0(sp)
    80027358:	1080                	addi	s0,sp,96
    8002735a:	89ae                	mv	s3,a1
    8002735c:	84b2                	mv	s1,a2
    8002735e:	8c36                	mv	s8,a3
    80027360:	8bc2                	mv	s7,a6
    80027362:	8a46                	mv	s4,a7
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    if(cmd_len == 0)
    80027364:	ebc9                	bnez	a5,800273f6 <spi_receive_data_normal_dma+0xb8>
        spi_set_tmod(spi_num, SPI_TMOD_RECV);
    80027366:	4589                	li	a1,2
    80027368:	0ff67513          	andi	a0,a2,255
    8002736c:	00000097          	auipc	ra,0x0
    80027370:	a92080e7          	jalr	-1390(ra) # 80026dfe <spi_set_tmod>
    else
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);

    volatile spi_t *spi_handle = spi[spi_num];
    80027374:	02049793          	slli	a5,s1,0x20
    80027378:	9381                	srli	a5,a5,0x20
    8002737a:	00379713          	slli	a4,a5,0x3
    8002737e:	00005797          	auipc	a5,0x5
    80027382:	84a78793          	addi	a5,a5,-1974 # 8002bbc8 <spi>
    80027386:	97ba                	add	a5,a5,a4
    80027388:	0007b903          	ld	s2,0(a5)

    spi_handle->ctrlr1 = (uint32)(rx_len - 1);
    8002738c:	fffa079b          	addiw	a5,s4,-1
    80027390:	00f92223          	sw	a5,4(s2)
    spi_handle->dmacr = 0x3;
    80027394:	478d                	li	a5,3
    80027396:	04f92623          	sw	a5,76(s2)
    spi_handle->ssienr = 0x01;
    8002739a:	4a85                	li	s5,1
    8002739c:	01592423          	sw	s5,8(s2)
    if(cmd_len)
        sysctl_dma_select((sysctl_dma_channel_t)dma_send_channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    sysctl_dma_select((sysctl_dma_channel_t)dma_receive_channel_num, SYSCTL_DMA_SELECT_SSI0_RX_REQ + spi_num * 2);
    800273a0:	0014959b          	slliw	a1,s1,0x1
    800273a4:	854e                	mv	a0,s3
    800273a6:	00002097          	auipc	ra,0x2
    800273aa:	c5e080e7          	jalr	-930(ra) # 80029004 <sysctl_dma_select>

    dmac_set_single_mode(dma_receive_channel_num, (void *)(&spi_handle->dr[0]), rx_buff, DMAC_ADDR_NOCHANGE, DMAC_ADDR_INCREMENT,
    800273ae:	88d2                	mv	a7,s4
    800273b0:	4809                	li	a6,2
    800273b2:	4781                	li	a5,0
    800273b4:	4701                	li	a4,0
    800273b6:	4685                	li	a3,1
    800273b8:	865e                	mv	a2,s7
    800273ba:	06090593          	addi	a1,s2,96
    800273be:	854e                	mv	a0,s3
    800273c0:	00001097          	auipc	ra,0x1
    800273c4:	724080e7          	jalr	1828(ra) # 80028ae4 <dmac_set_single_mode>
    switch(spi_num)
    800273c8:	47d5                	li	a5,21
    800273ca:	009af763          	bgeu	s5,s1,800273d8 <spi_receive_data_normal_dma+0x9a>
    800273ce:	4709                	li	a4,2
            frf_offset = 22;
    800273d0:	47d9                	li	a5,22
    switch(spi_num)
    800273d2:	00e49363          	bne	s1,a4,800273d8 <spi_receive_data_normal_dma+0x9a>
    uint8 frf_offset = 0;
    800273d6:	4781                	li	a5,0
    return ((spi_adapter->ctrlr0 >> frf_offset) & 0x3);
    800273d8:	00092703          	lw	a4,0(s2)
    800273dc:	00f757bb          	srlw	a5,a4,a5
                         DMAC_MSIZE_1, DMAC_TRANS_WIDTH_32, rx_len);
    if(cmd_len)
        dmac_set_single_mode(dma_send_channel_num, cmd_buff, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
                             DMAC_MSIZE_4, DMAC_TRANS_WIDTH_32, cmd_len);
    if(cmd_len == 0 && spi_get_frame_format(spi_num) == SPI_FF_STANDARD)
    800273e0:	8b8d                	andi	a5,a5,3
    800273e2:	e781                	bnez	a5,800273ea <spi_receive_data_normal_dma+0xac>
        spi[spi_num]->dr[0] = 0xffffffff;
    800273e4:	57fd                	li	a5,-1
    800273e6:	06f92023          	sw	a5,96(s2)
    spi_handle->ser = 1U << chip_select;
    800273ea:	4685                	li	a3,1
    800273ec:	01869c3b          	sllw	s8,a3,s8
    800273f0:	01892823          	sw	s8,16(s2)
    if(cmd_len)
    800273f4:	a075                	j	800274a0 <spi_receive_data_normal_dma+0x162>
    800273f6:	8aaa                	mv	s5,a0
    800273f8:	8cba                	mv	s9,a4
    800273fa:	8b3e                	mv	s6,a5
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    800273fc:	458d                	li	a1,3
    800273fe:	0ff67513          	andi	a0,a2,255
    80027402:	00000097          	auipc	ra,0x0
    80027406:	9fc080e7          	jalr	-1540(ra) # 80026dfe <spi_set_tmod>
    volatile spi_t *spi_handle = spi[spi_num];
    8002740a:	02049793          	slli	a5,s1,0x20
    8002740e:	9381                	srli	a5,a5,0x20
    80027410:	00379713          	slli	a4,a5,0x3
    80027414:	00004797          	auipc	a5,0x4
    80027418:	7b478793          	addi	a5,a5,1972 # 8002bbc8 <spi>
    8002741c:	97ba                	add	a5,a5,a4
    8002741e:	0007b903          	ld	s2,0(a5)
    spi_handle->ctrlr1 = (uint32)(rx_len - 1);
    80027422:	fffa079b          	addiw	a5,s4,-1
    80027426:	00f92223          	sw	a5,4(s2)
    spi_handle->dmacr = 0x3;
    8002742a:	478d                	li	a5,3
    8002742c:	04f92623          	sw	a5,76(s2)
    spi_handle->ssienr = 0x01;
    80027430:	4785                	li	a5,1
    80027432:	00f92423          	sw	a5,8(s2)
        sysctl_dma_select((sysctl_dma_channel_t)dma_send_channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    80027436:	0014949b          	slliw	s1,s1,0x1
    8002743a:	00048d1b          	sext.w	s10,s1
    8002743e:	0014859b          	addiw	a1,s1,1
    80027442:	8556                	mv	a0,s5
    80027444:	00002097          	auipc	ra,0x2
    80027448:	bc0080e7          	jalr	-1088(ra) # 80029004 <sysctl_dma_select>
    sysctl_dma_select((sysctl_dma_channel_t)dma_receive_channel_num, SYSCTL_DMA_SELECT_SSI0_RX_REQ + spi_num * 2);
    8002744c:	85ea                	mv	a1,s10
    8002744e:	854e                	mv	a0,s3
    80027450:	00002097          	auipc	ra,0x2
    80027454:	bb4080e7          	jalr	-1100(ra) # 80029004 <sysctl_dma_select>
    dmac_set_single_mode(dma_receive_channel_num, (void *)(&spi_handle->dr[0]), rx_buff, DMAC_ADDR_NOCHANGE, DMAC_ADDR_INCREMENT,
    80027458:	06090493          	addi	s1,s2,96
    8002745c:	88d2                	mv	a7,s4
    8002745e:	4809                	li	a6,2
    80027460:	4781                	li	a5,0
    80027462:	4701                	li	a4,0
    80027464:	4685                	li	a3,1
    80027466:	865e                	mv	a2,s7
    80027468:	85a6                	mv	a1,s1
    8002746a:	854e                	mv	a0,s3
    8002746c:	00001097          	auipc	ra,0x1
    80027470:	678080e7          	jalr	1656(ra) # 80028ae4 <dmac_set_single_mode>
        dmac_set_single_mode(dma_send_channel_num, cmd_buff, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    80027474:	88da                	mv	a7,s6
    80027476:	4809                	li	a6,2
    80027478:	4785                	li	a5,1
    8002747a:	4705                	li	a4,1
    8002747c:	4681                	li	a3,0
    8002747e:	8626                	mv	a2,s1
    80027480:	85e6                	mv	a1,s9
    80027482:	8556                	mv	a0,s5
    80027484:	00001097          	auipc	ra,0x1
    80027488:	660080e7          	jalr	1632(ra) # 80028ae4 <dmac_set_single_mode>
    spi_handle->ser = 1U << chip_select;
    8002748c:	4685                	li	a3,1
    8002748e:	01869c3b          	sllw	s8,a3,s8
    80027492:	01892823          	sw	s8,16(s2)
        dmac_wait_done(dma_send_channel_num);
    80027496:	8556                	mv	a0,s5
    80027498:	00001097          	auipc	ra,0x1
    8002749c:	6f8080e7          	jalr	1784(ra) # 80028b90 <dmac_wait_done>
    dmac_wait_done(dma_receive_channel_num);
    800274a0:	854e                	mv	a0,s3
    800274a2:	00001097          	auipc	ra,0x1
    800274a6:	6ee080e7          	jalr	1774(ra) # 80028b90 <dmac_wait_done>

    spi_handle->ser = 0x00;
    800274aa:	00092823          	sw	zero,16(s2)
    spi_handle->ssienr = 0x00;
    800274ae:	00092423          	sw	zero,8(s2)
}
    800274b2:	60e6                	ld	ra,88(sp)
    800274b4:	6446                	ld	s0,80(sp)
    800274b6:	64a6                	ld	s1,72(sp)
    800274b8:	6906                	ld	s2,64(sp)
    800274ba:	79e2                	ld	s3,56(sp)
    800274bc:	7a42                	ld	s4,48(sp)
    800274be:	7aa2                	ld	s5,40(sp)
    800274c0:	7b02                	ld	s6,32(sp)
    800274c2:	6be2                	ld	s7,24(sp)
    800274c4:	6c42                	ld	s8,16(sp)
    800274c6:	6ca2                	ld	s9,8(sp)
    800274c8:	6d02                	ld	s10,0(sp)
    800274ca:	6125                	addi	sp,sp,96
    800274cc:	8082                	ret

00000000800274ce <spi_send_data_normal_dma>:

void spi_send_data_normal_dma(dmac_channel_number_t channel_num, spi_device_num_t spi_num,
                              spi_chip_select_t chip_select,
                              const void *tx_buff, uint64 tx_len, spi_transfer_width_t spi_transfer_width)
{
    800274ce:	715d                	addi	sp,sp,-80
    800274d0:	e486                	sd	ra,72(sp)
    800274d2:	e0a2                	sd	s0,64(sp)
    800274d4:	fc26                	sd	s1,56(sp)
    800274d6:	f84a                	sd	s2,48(sp)
    800274d8:	f44e                	sd	s3,40(sp)
    800274da:	f052                	sd	s4,32(sp)
    800274dc:	ec56                	sd	s5,24(sp)
    800274de:	e85a                	sd	s6,16(sp)
    800274e0:	e45e                	sd	s7,8(sp)
    800274e2:	0880                	addi	s0,sp,80
    800274e4:	8a2a                	mv	s4,a0
    800274e6:	89ae                	mv	s3,a1
    800274e8:	8b32                	mv	s6,a2
    800274ea:	8936                	mv	s2,a3
    800274ec:	8aba                	mv	s5,a4
    800274ee:	8bbe                	mv	s7,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    spi_set_tmod(spi_num, SPI_TMOD_TRANS);
    800274f0:	4585                	li	a1,1
    800274f2:	0ff9f513          	andi	a0,s3,255
    800274f6:	00000097          	auipc	ra,0x0
    800274fa:	908080e7          	jalr	-1784(ra) # 80026dfe <spi_set_tmod>
    volatile spi_t *spi_handle = spi[spi_num];
    800274fe:	02099793          	slli	a5,s3,0x20
    80027502:	9381                	srli	a5,a5,0x20
    80027504:	00379713          	slli	a4,a5,0x3
    80027508:	00004797          	auipc	a5,0x4
    8002750c:	6c078793          	addi	a5,a5,1728 # 8002bbc8 <spi>
    80027510:	97ba                	add	a5,a5,a4
    80027512:	6384                	ld	s1,0(a5)
    uint32 *buf;
    int i;
    switch(spi_transfer_width)
    80027514:	4789                	li	a5,2
    80027516:	06fb8c63          	beq	s7,a5,8002758e <spi_send_data_normal_dma+0xc0>
    8002751a:	4791                	li	a5,4
    8002751c:	0efb8663          	beq	s7,a5,80027608 <spi_send_data_normal_dma+0x13a>
        case SPI_TRANS_INT:
            buf = (uint32 *)tx_buff;
            break;
        case SPI_TRANS_CHAR:
        default:
            buf = kalloc();
    80027520:	ffff9097          	auipc	ra,0xffff9
    80027524:	026080e7          	jalr	38(ra) # 80020546 <kalloc>
    80027528:	8baa                	mv	s7,a0
            for(i = 0; i < tx_len; i++)
    8002752a:	000a8e63          	beqz	s5,80027546 <spi_send_data_normal_dma+0x78>
    8002752e:	86ca                	mv	a3,s2
    80027530:	87aa                	mv	a5,a0
    80027532:	002a9613          	slli	a2,s5,0x2
    80027536:	962a                	add	a2,a2,a0
                buf[i] = ((uint8 *)tx_buff)[i];
    80027538:	0006c703          	lbu	a4,0(a3)
    8002753c:	c398                	sw	a4,0(a5)
            for(i = 0; i < tx_len; i++)
    8002753e:	0685                	addi	a3,a3,1
    80027540:	0791                	addi	a5,a5,4
    80027542:	fec79be3          	bne	a5,a2,80027538 <spi_send_data_normal_dma+0x6a>
            break;
    }
    spi_handle->dmacr = 0x2; /*enable dma transmit*/
    80027546:	4789                	li	a5,2
    80027548:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    8002754a:	4785                	li	a5,1
    8002754c:	c49c                	sw	a5,8(s1)

    sysctl_dma_select((sysctl_dma_channel_t)channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    8002754e:	0019959b          	slliw	a1,s3,0x1
    80027552:	2585                	addiw	a1,a1,1
    80027554:	8552                	mv	a0,s4
    80027556:	00002097          	auipc	ra,0x2
    8002755a:	aae080e7          	jalr	-1362(ra) # 80029004 <sysctl_dma_select>
    dmac_set_single_mode(channel_num, buf, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    8002755e:	88d6                	mv	a7,s5
    80027560:	4809                	li	a6,2
    80027562:	4785                	li	a5,1
    80027564:	4705                	li	a4,1
    80027566:	4681                	li	a3,0
    80027568:	06048613          	addi	a2,s1,96
    8002756c:	85de                	mv	a1,s7
    8002756e:	8552                	mv	a0,s4
    80027570:	00001097          	auipc	ra,0x1
    80027574:	574080e7          	jalr	1396(ra) # 80028ae4 <dmac_set_single_mode>
                         DMAC_MSIZE_4, DMAC_TRANS_WIDTH_32, tx_len);
    spi_handle->ser = 1U << chip_select;
    80027578:	4785                	li	a5,1
    8002757a:	01679b3b          	sllw	s6,a5,s6
    8002757e:	0164a823          	sw	s6,16(s1)
    dmac_wait_done(channel_num);
    80027582:	8552                	mv	a0,s4
    80027584:	00001097          	auipc	ra,0x1
    80027588:	60c080e7          	jalr	1548(ra) # 80028b90 <dmac_wait_done>
    if(spi_transfer_width != SPI_TRANS_INT)
    8002758c:	a885                	j	800275fc <spi_send_data_normal_dma+0x12e>
            buf = kalloc();
    8002758e:	ffff9097          	auipc	ra,0xffff9
    80027592:	fb8080e7          	jalr	-72(ra) # 80020546 <kalloc>
    80027596:	8baa                	mv	s7,a0
            for(i = 0; i < tx_len; i++)
    80027598:	000a8f63          	beqz	s5,800275b6 <spi_send_data_normal_dma+0xe8>
    8002759c:	87ca                	mv	a5,s2
    8002759e:	882a                	mv	a6,a0
    800275a0:	001a9693          	slli	a3,s5,0x1
    800275a4:	96ca                	add	a3,a3,s2
                buf[i] = ((uint16 *)tx_buff)[i];
    800275a6:	0007d703          	lhu	a4,0(a5)
    800275aa:	00e82023          	sw	a4,0(a6)
            for(i = 0; i < tx_len; i++)
    800275ae:	0789                	addi	a5,a5,2
    800275b0:	0811                	addi	a6,a6,4
    800275b2:	fed79ae3          	bne	a5,a3,800275a6 <spi_send_data_normal_dma+0xd8>
    spi_handle->dmacr = 0x2; /*enable dma transmit*/
    800275b6:	4789                	li	a5,2
    800275b8:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    800275ba:	4785                	li	a5,1
    800275bc:	c49c                	sw	a5,8(s1)
    sysctl_dma_select((sysctl_dma_channel_t)channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    800275be:	0019959b          	slliw	a1,s3,0x1
    800275c2:	2585                	addiw	a1,a1,1
    800275c4:	8552                	mv	a0,s4
    800275c6:	00002097          	auipc	ra,0x2
    800275ca:	a3e080e7          	jalr	-1474(ra) # 80029004 <sysctl_dma_select>
    dmac_set_single_mode(channel_num, buf, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    800275ce:	88d6                	mv	a7,s5
    800275d0:	4809                	li	a6,2
    800275d2:	4785                	li	a5,1
    800275d4:	4705                	li	a4,1
    800275d6:	4681                	li	a3,0
    800275d8:	06048613          	addi	a2,s1,96
    800275dc:	85de                	mv	a1,s7
    800275de:	8552                	mv	a0,s4
    800275e0:	00001097          	auipc	ra,0x1
    800275e4:	504080e7          	jalr	1284(ra) # 80028ae4 <dmac_set_single_mode>
    spi_handle->ser = 1U << chip_select;
    800275e8:	4785                	li	a5,1
    800275ea:	01679b3b          	sllw	s6,a5,s6
    800275ee:	0164a823          	sw	s6,16(s1)
    dmac_wait_done(channel_num);
    800275f2:	8552                	mv	a0,s4
    800275f4:	00001097          	auipc	ra,0x1
    800275f8:	59c080e7          	jalr	1436(ra) # 80028b90 <dmac_wait_done>
        kfree((void *)buf);
    800275fc:	855e                	mv	a0,s7
    800275fe:	ffff9097          	auipc	ra,0xffff9
    80027602:	e30080e7          	jalr	-464(ra) # 8002042e <kfree>
    80027606:	a0a1                	j	8002764e <spi_send_data_normal_dma+0x180>
    spi_handle->dmacr = 0x2; /*enable dma transmit*/
    80027608:	4789                	li	a5,2
    8002760a:	c4fc                	sw	a5,76(s1)
    spi_handle->ssienr = 0x01;
    8002760c:	4785                	li	a5,1
    8002760e:	c49c                	sw	a5,8(s1)
    sysctl_dma_select((sysctl_dma_channel_t)channel_num, SYSCTL_DMA_SELECT_SSI0_TX_REQ + spi_num * 2);
    80027610:	0019959b          	slliw	a1,s3,0x1
    80027614:	2585                	addiw	a1,a1,1
    80027616:	8552                	mv	a0,s4
    80027618:	00002097          	auipc	ra,0x2
    8002761c:	9ec080e7          	jalr	-1556(ra) # 80029004 <sysctl_dma_select>
    dmac_set_single_mode(channel_num, buf, (void *)(&spi_handle->dr[0]), DMAC_ADDR_INCREMENT, DMAC_ADDR_NOCHANGE,
    80027620:	88d6                	mv	a7,s5
    80027622:	4809                	li	a6,2
    80027624:	4785                	li	a5,1
    80027626:	4705                	li	a4,1
    80027628:	4681                	li	a3,0
    8002762a:	06048613          	addi	a2,s1,96
    8002762e:	85ca                	mv	a1,s2
    80027630:	8552                	mv	a0,s4
    80027632:	00001097          	auipc	ra,0x1
    80027636:	4b2080e7          	jalr	1202(ra) # 80028ae4 <dmac_set_single_mode>
    spi_handle->ser = 1U << chip_select;
    8002763a:	4785                	li	a5,1
    8002763c:	01679b3b          	sllw	s6,a5,s6
    80027640:	0164a823          	sw	s6,16(s1)
    dmac_wait_done(channel_num);
    80027644:	8552                	mv	a0,s4
    80027646:	00001097          	auipc	ra,0x1
    8002764a:	54a080e7          	jalr	1354(ra) # 80028b90 <dmac_wait_done>

    while((spi_handle->sr & 0x05) != 0x04)
    8002764e:	4711                	li	a4,4
    80027650:	549c                	lw	a5,40(s1)
    80027652:	8b95                	andi	a5,a5,5
    80027654:	fee79ee3          	bne	a5,a4,80027650 <spi_send_data_normal_dma+0x182>
        ;
    spi_handle->ser = 0x00;
    80027658:	0004a823          	sw	zero,16(s1)
    spi_handle->ssienr = 0x00;
    8002765c:	0004a423          	sw	zero,8(s1)
}
    80027660:	60a6                	ld	ra,72(sp)
    80027662:	6406                	ld	s0,64(sp)
    80027664:	74e2                	ld	s1,56(sp)
    80027666:	7942                	ld	s2,48(sp)
    80027668:	79a2                	ld	s3,40(sp)
    8002766a:	7a02                	ld	s4,32(sp)
    8002766c:	6ae2                	ld	s5,24(sp)
    8002766e:	6b42                	ld	s6,16(sp)
    80027670:	6ba2                	ld	s7,8(sp)
    80027672:	6161                	addi	sp,sp,80
    80027674:	8082                	ret

0000000080027676 <spi_receive_data_standard_dma>:

void spi_receive_data_standard_dma(dmac_channel_number_t dma_send_channel_num,
                                   dmac_channel_number_t dma_receive_channel_num,
                                   spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                                   uint64 cmd_len, uint8 *rx_buff, uint64 rx_len)
{
    80027676:	711d                	addi	sp,sp,-96
    80027678:	ec86                	sd	ra,88(sp)
    8002767a:	e8a2                	sd	s0,80(sp)
    8002767c:	e4a6                	sd	s1,72(sp)
    8002767e:	e0ca                	sd	s2,64(sp)
    80027680:	fc4e                	sd	s3,56(sp)
    80027682:	f852                	sd	s4,48(sp)
    80027684:	f456                	sd	s5,40(sp)
    80027686:	f05a                	sd	s6,32(sp)
    80027688:	ec5e                	sd	s7,24(sp)
    8002768a:	e862                	sd	s8,16(sp)
    8002768c:	e466                	sd	s9,8(sp)
    8002768e:	1080                	addi	s0,sp,96
    80027690:	8b2a                	mv	s6,a0
    80027692:	8bae                	mv	s7,a1
    80027694:	8a32                	mv	s4,a2
    80027696:	8c36                	mv	s8,a3
    80027698:	893a                	mv	s2,a4
    8002769a:	8cbe                	mv	s9,a5
    8002769c:	84c2                	mv	s1,a6
    8002769e:	8ac6                	mv	s5,a7
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    volatile spi_t *spi_handle = spi[spi_num];
    800276a0:	02061793          	slli	a5,a2,0x20
    800276a4:	9381                	srli	a5,a5,0x20
    800276a6:	00379713          	slli	a4,a5,0x3
    800276aa:	00004797          	auipc	a5,0x4
    800276ae:	51e78793          	addi	a5,a5,1310 # 8002bbc8 <spi>
    800276b2:	97ba                	add	a5,a5,a4
    800276b4:	639c                	ld	a5,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    800276b6:	00263713          	sltiu	a4,a2,2
    800276ba:	0712                	slli	a4,a4,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    800276bc:	439c                	lw	a5,0(a5)
    800276be:	00e7d7bb          	srlw	a5,a5,a4
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    800276c2:	8bfd                	andi	a5,a5,31
    if(data_bit_length < 8)
    800276c4:	471d                	li	a4,7
    800276c6:	08f77b63          	bgeu	a4,a5,8002775c <spi_receive_data_standard_dma+0xe6>
    else if(data_bit_length < 16)
    800276ca:	473d                	li	a4,15
    800276cc:	0ef77c63          	bgeu	a4,a5,800277c4 <spi_receive_data_standard_dma+0x14e>
    uint64 v_recv_len;
    uint64 v_cmd_len;
    switch(frame_width)
    {
        case SPI_TRANS_INT:
            write_cmd = kalloc();
    800276d0:	ffff9097          	auipc	ra,0xffff9
    800276d4:	e76080e7          	jalr	-394(ra) # 80020546 <kalloc>
    800276d8:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 4; i++)
    800276da:	002cd793          	srli	a5,s9,0x2
    800276de:	458d                	li	a1,3
    800276e0:	874a                	mv	a4,s2
    800276e2:	862a                	mv	a2,a0
    800276e4:	4681                	li	a3,0
    800276e6:	0d95fc63          	bgeu	a1,s9,800277be <spi_receive_data_standard_dma+0x148>
                write_cmd[i] = ((uint32 *)cmd_buff)[i];
    800276ea:	430c                	lw	a1,0(a4)
    800276ec:	c20c                	sw	a1,0(a2)
            for(i = 0; i < cmd_len / 4; i++)
    800276ee:	0685                	addi	a3,a3,1
    800276f0:	0711                	addi	a4,a4,4
    800276f2:	0611                	addi	a2,a2,4
    800276f4:	fef6ebe3          	bltu	a3,a5,800276ea <spi_receive_data_standard_dma+0x74>
    800276f8:	470d                	li	a4,3
    800276fa:	4905                	li	s2,1
    800276fc:	01977363          	bgeu	a4,s9,80027702 <spi_receive_data_standard_dma+0x8c>
    80027700:	893e                	mv	s2,a5
            read_buf = &write_cmd[i];
    80027702:	090a                	slli	s2,s2,0x2
    80027704:	994e                	add	s2,s2,s3
            v_recv_len = rx_len / 4;
    80027706:	002adc93          	srli	s9,s5,0x2
            v_recv_len = rx_len;
            v_cmd_len = cmd_len;
            break;
    }

    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    8002770a:	88e6                	mv	a7,s9
    8002770c:	884a                	mv	a6,s2
    8002770e:	874e                	mv	a4,s3
    80027710:	86e2                	mv	a3,s8
    80027712:	8652                	mv	a2,s4
    80027714:	85de                	mv	a1,s7
    80027716:	855a                	mv	a0,s6
    80027718:	00000097          	auipc	ra,0x0
    8002771c:	c26080e7          	jalr	-986(ra) # 8002733e <spi_receive_data_normal_dma>

    switch(frame_width)
    {
        case SPI_TRANS_INT:
            for(i = 0; i < v_recv_len; i++)
    80027720:	468d                	li	a3,3
    80027722:	87ca                	mv	a5,s2
    80027724:	4701                	li	a4,0
    80027726:	0156f963          	bgeu	a3,s5,80027738 <spi_receive_data_standard_dma+0xc2>
                ((uint32 *)rx_buff)[i] = read_buf[i];
    8002772a:	4394                	lw	a3,0(a5)
    8002772c:	c094                	sw	a3,0(s1)
            for(i = 0; i < v_recv_len; i++)
    8002772e:	0705                	addi	a4,a4,1
    80027730:	0791                	addi	a5,a5,4
    80027732:	0491                	addi	s1,s1,4
    80027734:	ff976be3          	bltu	a4,s9,8002772a <spi_receive_data_standard_dma+0xb4>
            for(i = 0; i < v_recv_len; i++)
                rx_buff[i] = read_buf[i];
            break;
    }

    kfree(write_cmd);
    80027738:	854e                	mv	a0,s3
    8002773a:	ffff9097          	auipc	ra,0xffff9
    8002773e:	cf4080e7          	jalr	-780(ra) # 8002042e <kfree>
}
    80027742:	60e6                	ld	ra,88(sp)
    80027744:	6446                	ld	s0,80(sp)
    80027746:	64a6                	ld	s1,72(sp)
    80027748:	6906                	ld	s2,64(sp)
    8002774a:	79e2                	ld	s3,56(sp)
    8002774c:	7a42                	ld	s4,48(sp)
    8002774e:	7aa2                	ld	s5,40(sp)
    80027750:	7b02                	ld	s6,32(sp)
    80027752:	6be2                	ld	s7,24(sp)
    80027754:	6c42                	ld	s8,16(sp)
    80027756:	6ca2                	ld	s9,8(sp)
    80027758:	6125                	addi	sp,sp,96
    8002775a:	8082                	ret
            write_cmd = kalloc();
    8002775c:	ffff9097          	auipc	ra,0xffff9
    80027760:	dea080e7          	jalr	-534(ra) # 80020546 <kalloc>
    80027764:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len; i++)
    80027766:	040c8a63          	beqz	s9,800277ba <spi_receive_data_standard_dma+0x144>
    8002776a:	87ca                	mv	a5,s2
    8002776c:	874e                	mv	a4,s3
    8002776e:	002c9613          	slli	a2,s9,0x2
    80027772:	964e                	add	a2,a2,s3
                write_cmd[i] = cmd_buff[i];
    80027774:	0007c683          	lbu	a3,0(a5)
    80027778:	c314                	sw	a3,0(a4)
            for(i = 0; i < cmd_len; i++)
    8002777a:	0785                	addi	a5,a5,1
    8002777c:	0711                	addi	a4,a4,4
    8002777e:	fec71be3          	bne	a4,a2,80027774 <spi_receive_data_standard_dma+0xfe>
    80027782:	8966                	mv	s2,s9
            read_buf = &write_cmd[i];
    80027784:	090a                	slli	s2,s2,0x2
    80027786:	994e                	add	s2,s2,s3
    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    80027788:	88d6                	mv	a7,s5
    8002778a:	884a                	mv	a6,s2
    8002778c:	87e6                	mv	a5,s9
    8002778e:	874e                	mv	a4,s3
    80027790:	86e2                	mv	a3,s8
    80027792:	8652                	mv	a2,s4
    80027794:	85de                	mv	a1,s7
    80027796:	855a                	mv	a0,s6
    80027798:	00000097          	auipc	ra,0x0
    8002779c:	ba6080e7          	jalr	-1114(ra) # 8002733e <spi_receive_data_normal_dma>
            for(i = 0; i < v_recv_len; i++)
    800277a0:	f80a8ce3          	beqz	s5,80027738 <spi_receive_data_standard_dma+0xc2>
    800277a4:	87ca                	mv	a5,s2
    800277a6:	0a8a                	slli	s5,s5,0x2
    800277a8:	9aca                	add	s5,s5,s2
                rx_buff[i] = read_buf[i];
    800277aa:	4398                	lw	a4,0(a5)
    800277ac:	00e48023          	sb	a4,0(s1)
            for(i = 0; i < v_recv_len; i++)
    800277b0:	0791                	addi	a5,a5,4
    800277b2:	0485                	addi	s1,s1,1
    800277b4:	fefa9be3          	bne	s5,a5,800277aa <spi_receive_data_standard_dma+0x134>
    800277b8:	b741                	j	80027738 <spi_receive_data_standard_dma+0xc2>
            for(i = 0; i < cmd_len; i++)
    800277ba:	8966                	mv	s2,s9
    800277bc:	b7e1                	j	80027784 <spi_receive_data_standard_dma+0x10e>
            for(i = 0; i < cmd_len / 4; i++)
    800277be:	4901                	li	s2,0
    800277c0:	4781                	li	a5,0
    800277c2:	b781                	j	80027702 <spi_receive_data_standard_dma+0x8c>
            write_cmd = kalloc();
    800277c4:	ffff9097          	auipc	ra,0xffff9
    800277c8:	d82080e7          	jalr	-638(ra) # 80020546 <kalloc>
    800277cc:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 2; i++)
    800277ce:	001cd793          	srli	a5,s9,0x1
    800277d2:	4585                	li	a1,1
    800277d4:	874a                	mv	a4,s2
    800277d6:	862a                	mv	a2,a0
    800277d8:	4681                	li	a3,0
    800277da:	0595fc63          	bgeu	a1,s9,80027832 <spi_receive_data_standard_dma+0x1bc>
                write_cmd[i] = ((uint16 *)cmd_buff)[i];
    800277de:	00075583          	lhu	a1,0(a4)
    800277e2:	c20c                	sw	a1,0(a2)
            for(i = 0; i < cmd_len / 2; i++)
    800277e4:	0685                	addi	a3,a3,1
    800277e6:	0709                	addi	a4,a4,2
    800277e8:	0611                	addi	a2,a2,4
    800277ea:	fef6eae3          	bltu	a3,a5,800277de <spi_receive_data_standard_dma+0x168>
    800277ee:	4705                	li	a4,1
    800277f0:	4905                	li	s2,1
    800277f2:	01977363          	bgeu	a4,s9,800277f8 <spi_receive_data_standard_dma+0x182>
    800277f6:	893e                	mv	s2,a5
            read_buf = &write_cmd[i];
    800277f8:	090a                	slli	s2,s2,0x2
    800277fa:	994e                	add	s2,s2,s3
            v_recv_len = rx_len / 2;
    800277fc:	001adc93          	srli	s9,s5,0x1
    spi_receive_data_normal_dma(dma_send_channel_num, dma_receive_channel_num, spi_num, chip_select, write_cmd, v_cmd_len, read_buf, v_recv_len);
    80027800:	88e6                	mv	a7,s9
    80027802:	884a                	mv	a6,s2
    80027804:	874e                	mv	a4,s3
    80027806:	86e2                	mv	a3,s8
    80027808:	8652                	mv	a2,s4
    8002780a:	85de                	mv	a1,s7
    8002780c:	855a                	mv	a0,s6
    8002780e:	00000097          	auipc	ra,0x0
    80027812:	b30080e7          	jalr	-1232(ra) # 8002733e <spi_receive_data_normal_dma>
            for(i = 0; i < v_recv_len; i++)
    80027816:	4685                	li	a3,1
    80027818:	87ca                	mv	a5,s2
    8002781a:	4701                	li	a4,0
    8002781c:	f156fee3          	bgeu	a3,s5,80027738 <spi_receive_data_standard_dma+0xc2>
                ((uint16 *)rx_buff)[i] = read_buf[i];
    80027820:	4394                	lw	a3,0(a5)
    80027822:	00d49023          	sh	a3,0(s1)
            for(i = 0; i < v_recv_len; i++)
    80027826:	0705                	addi	a4,a4,1
    80027828:	0791                	addi	a5,a5,4
    8002782a:	0489                	addi	s1,s1,2
    8002782c:	ff976ae3          	bltu	a4,s9,80027820 <spi_receive_data_standard_dma+0x1aa>
    80027830:	b721                	j	80027738 <spi_receive_data_standard_dma+0xc2>
            for(i = 0; i < cmd_len / 2; i++)
    80027832:	4901                	li	s2,0
    80027834:	4781                	li	a5,0
    80027836:	b7c9                	j	800277f8 <spi_receive_data_standard_dma+0x182>

0000000080027838 <spi_send_data_standard_dma>:

void spi_send_data_standard_dma(dmac_channel_number_t channel_num, spi_device_num_t spi_num,
                                spi_chip_select_t chip_select,
                                const uint8 *cmd_buff, uint64 cmd_len, const uint8 *tx_buff, uint64 tx_len)
{
    80027838:	715d                	addi	sp,sp,-80
    8002783a:	e486                	sd	ra,72(sp)
    8002783c:	e0a2                	sd	s0,64(sp)
    8002783e:	fc26                	sd	s1,56(sp)
    80027840:	f84a                	sd	s2,48(sp)
    80027842:	f44e                	sd	s3,40(sp)
    80027844:	f052                	sd	s4,32(sp)
    80027846:	ec56                	sd	s5,24(sp)
    80027848:	e85a                	sd	s6,16(sp)
    8002784a:	e45e                	sd	s7,8(sp)
    8002784c:	e062                	sd	s8,0(sp)
    8002784e:	0880                	addi	s0,sp,80
    80027850:	8b2a                	mv	s6,a0
    80027852:	8a2e                	mv	s4,a1
    80027854:	8bb2                	mv	s7,a2
    80027856:	8c36                	mv	s8,a3
    80027858:	893a                	mv	s2,a4
    8002785a:	84be                	mv	s1,a5
    8002785c:	8ac2                	mv	s5,a6
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    volatile spi_t *spi_handle = spi[spi_num];
    8002785e:	02059793          	slli	a5,a1,0x20
    80027862:	9381                	srli	a5,a5,0x20
    80027864:	00379713          	slli	a4,a5,0x3
    80027868:	00004797          	auipc	a5,0x4
    8002786c:	36078793          	addi	a5,a5,864 # 8002bbc8 <spi>
    80027870:	97ba                	add	a5,a5,a4
    80027872:	639c                	ld	a5,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80027874:	0025b713          	sltiu	a4,a1,2
    80027878:	0712                	slli	a4,a4,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    8002787a:	439c                	lw	a5,0(a5)
    8002787c:	00e7d7bb          	srlw	a5,a5,a4
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80027880:	8bfd                	andi	a5,a5,31
    if(data_bit_length < 8)
    80027882:	471d                	li	a4,7
    80027884:	08f77863          	bgeu	a4,a5,80027914 <spi_send_data_standard_dma+0xdc>
    else if(data_bit_length < 16)
    80027888:	473d                	li	a4,15
    8002788a:	0cf77963          	bgeu	a4,a5,8002795c <spi_send_data_standard_dma+0x124>
    uint64 v_send_len;
    int i;
    switch(frame_width)
    {
        case SPI_TRANS_INT:
            buf = kalloc();
    8002788e:	ffff9097          	auipc	ra,0xffff9
    80027892:	cb8080e7          	jalr	-840(ra) # 80020546 <kalloc>
    80027896:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 4; i++)
    80027898:	00295893          	srli	a7,s2,0x2
    8002789c:	460d                	li	a2,3
    8002789e:	86e2                	mv	a3,s8
    800278a0:	872a                	mv	a4,a0
    800278a2:	4781                	li	a5,0
    800278a4:	07267663          	bgeu	a2,s2,80027910 <spi_send_data_standard_dma+0xd8>
                buf[i] = ((uint32 *)cmd_buff)[i];
    800278a8:	4290                	lw	a2,0(a3)
    800278aa:	c310                	sw	a2,0(a4)
            for(i = 0; i < cmd_len / 4; i++)
    800278ac:	0785                	addi	a5,a5,1
    800278ae:	0691                	addi	a3,a3,4
    800278b0:	0711                	addi	a4,a4,4
    800278b2:	ff17ebe3          	bltu	a5,a7,800278a8 <spi_send_data_standard_dma+0x70>
            for(i = 0; i < tx_len / 4; i++)
    800278b6:	002ad693          	srli	a3,s5,0x2
    800278ba:	478d                	li	a5,3
    800278bc:	0157fd63          	bgeu	a5,s5,800278d6 <spi_send_data_standard_dma+0x9e>
    800278c0:	088a                	slli	a7,a7,0x2
    800278c2:	98ce                	add	a7,a7,s3
    800278c4:	4701                	li	a4,0
                buf[cmd_len / 4 + i] = ((uint32 *)tx_buff)[i];
    800278c6:	409c                	lw	a5,0(s1)
    800278c8:	00f8a023          	sw	a5,0(a7)
            for(i = 0; i < tx_len / 4; i++)
    800278cc:	0705                	addi	a4,a4,1
    800278ce:	0491                	addi	s1,s1,4
    800278d0:	0891                	addi	a7,a7,4
    800278d2:	fed76ae3          	bltu	a4,a3,800278c6 <spi_send_data_standard_dma+0x8e>
            v_send_len = (cmd_len + tx_len) / 4;
    800278d6:	9956                	add	s2,s2,s5
    800278d8:	00295713          	srli	a4,s2,0x2
                buf[cmd_len + i] = tx_buff[i];
            v_send_len = cmd_len + tx_len;
            break;
    }

    spi_send_data_normal_dma(channel_num, spi_num, chip_select, buf, v_send_len, SPI_TRANS_INT);
    800278dc:	4791                	li	a5,4
    800278de:	86ce                	mv	a3,s3
    800278e0:	865e                	mv	a2,s7
    800278e2:	85d2                	mv	a1,s4
    800278e4:	855a                	mv	a0,s6
    800278e6:	00000097          	auipc	ra,0x0
    800278ea:	be8080e7          	jalr	-1048(ra) # 800274ce <spi_send_data_normal_dma>

    kfree((void *)buf);
    800278ee:	854e                	mv	a0,s3
    800278f0:	ffff9097          	auipc	ra,0xffff9
    800278f4:	b3e080e7          	jalr	-1218(ra) # 8002042e <kfree>
    800278f8:	60a6                	ld	ra,72(sp)
    800278fa:	6406                	ld	s0,64(sp)
    800278fc:	74e2                	ld	s1,56(sp)
    800278fe:	7942                	ld	s2,48(sp)
    80027900:	79a2                	ld	s3,40(sp)
    80027902:	7a02                	ld	s4,32(sp)
    80027904:	6ae2                	ld	s5,24(sp)
    80027906:	6b42                	ld	s6,16(sp)
    80027908:	6ba2                	ld	s7,8(sp)
    8002790a:	6c02                	ld	s8,0(sp)
    8002790c:	6161                	addi	sp,sp,80
    8002790e:	8082                	ret
            for(i = 0; i < cmd_len / 4; i++)
    80027910:	4881                	li	a7,0
    80027912:	b755                	j	800278b6 <spi_send_data_standard_dma+0x7e>
            buf = kalloc();
    80027914:	ffff9097          	auipc	ra,0xffff9
    80027918:	c32080e7          	jalr	-974(ra) # 80020546 <kalloc>
    8002791c:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len; i++)
    8002791e:	00090e63          	beqz	s2,8002793a <spi_send_data_standard_dma+0x102>
    80027922:	86e2                	mv	a3,s8
    80027924:	87ce                	mv	a5,s3
    80027926:	00291613          	slli	a2,s2,0x2
    8002792a:	964e                	add	a2,a2,s3
                buf[i] = cmd_buff[i];
    8002792c:	0006c703          	lbu	a4,0(a3)
    80027930:	c398                	sw	a4,0(a5)
            for(i = 0; i < cmd_len; i++)
    80027932:	0685                	addi	a3,a3,1
    80027934:	0791                	addi	a5,a5,4
    80027936:	fec79be3          	bne	a5,a2,8002792c <spi_send_data_standard_dma+0xf4>
            for(i = 0; i < tx_len; i++)
    8002793a:	000a8e63          	beqz	s5,80027956 <spi_send_data_standard_dma+0x11e>
    8002793e:	8726                	mv	a4,s1
    80027940:	00291693          	slli	a3,s2,0x2
    80027944:	96ce                	add	a3,a3,s3
    80027946:	94d6                	add	s1,s1,s5
                buf[cmd_len + i] = tx_buff[i];
    80027948:	00074603          	lbu	a2,0(a4)
    8002794c:	c290                	sw	a2,0(a3)
            for(i = 0; i < tx_len; i++)
    8002794e:	0705                	addi	a4,a4,1
    80027950:	0691                	addi	a3,a3,4
    80027952:	fe971be3          	bne	a4,s1,80027948 <spi_send_data_standard_dma+0x110>
            v_send_len = cmd_len + tx_len;
    80027956:	01590733          	add	a4,s2,s5
            break;
    8002795a:	b749                	j	800278dc <spi_send_data_standard_dma+0xa4>
            buf = kalloc();
    8002795c:	ffff9097          	auipc	ra,0xffff9
    80027960:	bea080e7          	jalr	-1046(ra) # 80020546 <kalloc>
    80027964:	89aa                	mv	s3,a0
            for(i = 0; i < cmd_len / 2; i++)
    80027966:	00195893          	srli	a7,s2,0x1
    8002796a:	4605                	li	a2,1
    8002796c:	86e2                	mv	a3,s8
    8002796e:	872a                	mv	a4,a0
    80027970:	4781                	li	a5,0
    80027972:	03267f63          	bgeu	a2,s2,800279b0 <spi_send_data_standard_dma+0x178>
                buf[i] = ((uint16 *)cmd_buff)[i];
    80027976:	0006d603          	lhu	a2,0(a3)
    8002797a:	c310                	sw	a2,0(a4)
            for(i = 0; i < cmd_len / 2; i++)
    8002797c:	0785                	addi	a5,a5,1
    8002797e:	0689                	addi	a3,a3,2
    80027980:	0711                	addi	a4,a4,4
    80027982:	ff17eae3          	bltu	a5,a7,80027976 <spi_send_data_standard_dma+0x13e>
            for(i = 0; i < tx_len / 2; i++)
    80027986:	001ad693          	srli	a3,s5,0x1
    8002798a:	4785                	li	a5,1
    8002798c:	0157fe63          	bgeu	a5,s5,800279a8 <spi_send_data_standard_dma+0x170>
    80027990:	088a                	slli	a7,a7,0x2
    80027992:	98ce                	add	a7,a7,s3
    80027994:	4701                	li	a4,0
                buf[cmd_len / 2 + i] = ((uint16 *)tx_buff)[i];
    80027996:	0004d783          	lhu	a5,0(s1)
    8002799a:	00f8a023          	sw	a5,0(a7)
            for(i = 0; i < tx_len / 2; i++)
    8002799e:	0705                	addi	a4,a4,1
    800279a0:	0489                	addi	s1,s1,2
    800279a2:	0891                	addi	a7,a7,4
    800279a4:	fed769e3          	bltu	a4,a3,80027996 <spi_send_data_standard_dma+0x15e>
            v_send_len = (cmd_len + tx_len) / 2;
    800279a8:	9956                	add	s2,s2,s5
    800279aa:	00195713          	srli	a4,s2,0x1
            break;
    800279ae:	b73d                	j	800278dc <spi_send_data_standard_dma+0xa4>
            for(i = 0; i < cmd_len / 2; i++)
    800279b0:	4881                	li	a7,0
    800279b2:	bfd1                	j	80027986 <spi_send_data_standard_dma+0x14e>

00000000800279b4 <gpiohs_set_drive_mode>:
// } gpiohs_pin_instance_t;

// static gpiohs_pin_instance_t pin_instance[32];

void gpiohs_set_drive_mode(uint8 pin, gpio_drive_mode_t mode)
{
    800279b4:	1101                	addi	sp,sp,-32
    800279b6:	ec06                	sd	ra,24(sp)
    800279b8:	e822                	sd	s0,16(sp)
    800279ba:	e426                	sd	s1,8(sp)
    800279bc:	e04a                	sd	s2,0(sp)
    800279be:	1000                	addi	s0,sp,32
    800279c0:	892a                	mv	s2,a0
    800279c2:	84ae                	mv	s1,a1
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    int io_number = fpioa_get_io_by_function(FUNC_GPIOHS0 + pin);
    800279c4:	0561                	addi	a0,a0,24
    800279c6:	00000097          	auipc	ra,0x0
    800279ca:	33e080e7          	jalr	830(ra) # 80027d04 <fpioa_get_io_by_function>
    // configASSERT(io_number >= 0);

    fpioa_pull_t pull = FPIOA_PULL_NONE;
    uint32 dir = 0;

    switch(mode)
    800279ce:	4789                	li	a5,2
    800279d0:	02f48c63          	beq	s1,a5,80027a08 <gpiohs_set_drive_mode+0x54>
    800279d4:	478d                	li	a5,3
    800279d6:	00f48b63          	beq	s1,a5,800279ec <gpiohs_set_drive_mode+0x38>
    800279da:	4785                	li	a5,1
    800279dc:	02f48663          	beq	s1,a5,80027a08 <gpiohs_set_drive_mode+0x54>
        default:
            // configASSERT(!"GPIO drive mode is not supported.") 
            break;
    }

    fpioa_set_io_pull(io_number, pull);
    800279e0:	4581                	li	a1,0
    800279e2:	00000097          	auipc	ra,0x0
    800279e6:	08a080e7          	jalr	138(ra) # 80027a6c <fpioa_set_io_pull>
    volatile uint32 *reg = dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    800279ea:	a025                	j	80027a12 <gpiohs_set_drive_mode+0x5e>
    fpioa_set_io_pull(io_number, pull);
    800279ec:	4585                	li	a1,1
    800279ee:	00000097          	auipc	ra,0x0
    800279f2:	07e080e7          	jalr	126(ra) # 80027a6c <fpioa_set_io_pull>
    800279f6:	00004497          	auipc	s1,0x4
    800279fa:	1f24b483          	ld	s1,498(s1) # 8002bbe8 <spi+0x20>
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    800279fe:	00004517          	auipc	a0,0x4
    80027a02:	1f253503          	ld	a0,498(a0) # 8002bbf0 <spi+0x28>
    80027a06:	a831                	j	80027a22 <gpiohs_set_drive_mode+0x6e>
    fpioa_set_io_pull(io_number, pull);
    80027a08:	85a6                	mv	a1,s1
    80027a0a:	00000097          	auipc	ra,0x0
    80027a0e:	062080e7          	jalr	98(ra) # 80027a6c <fpioa_set_io_pull>
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80027a12:	00004497          	auipc	s1,0x4
    80027a16:	1de4b483          	ld	s1,478(s1) # 8002bbf0 <spi+0x28>
    80027a1a:	00004517          	auipc	a0,0x4
    80027a1e:	1ce53503          	ld	a0,462(a0) # 8002bbe8 <spi+0x20>
    set_gpio_bit(reg_d, pin, 0);
    80027a22:	4601                	li	a2,0
    80027a24:	85ca                	mv	a1,s2
    80027a26:	00000097          	auipc	ra,0x0
    80027a2a:	39e080e7          	jalr	926(ra) # 80027dc4 <set_gpio_bit>
    set_gpio_bit(reg, pin, 1);
    80027a2e:	4605                	li	a2,1
    80027a30:	85ca                	mv	a1,s2
    80027a32:	8526                	mv	a0,s1
    80027a34:	00000097          	auipc	ra,0x0
    80027a38:	390080e7          	jalr	912(ra) # 80027dc4 <set_gpio_bit>
}
    80027a3c:	60e2                	ld	ra,24(sp)
    80027a3e:	6442                	ld	s0,16(sp)
    80027a40:	64a2                	ld	s1,8(sp)
    80027a42:	6902                	ld	s2,0(sp)
    80027a44:	6105                	addi	sp,sp,32
    80027a46:	8082                	ret

0000000080027a48 <gpiohs_set_pin>:
//     // configASSERT(pin < GPIOHS_MAX_PINNO);
//     return get_gpio_bit(gpiohs->input_val.u32, pin);
// }

void gpiohs_set_pin(uint8 pin, gpio_pin_value_t value)
{
    80027a48:	1141                	addi	sp,sp,-16
    80027a4a:	e406                	sd	ra,8(sp)
    80027a4c:	e022                	sd	s0,0(sp)
    80027a4e:	0800                	addi	s0,sp,16
    80027a50:	862e                	mv	a2,a1
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    set_gpio_bit(gpiohs->output_val.u32, pin, value);
    80027a52:	85aa                	mv	a1,a0
    80027a54:	00004517          	auipc	a0,0x4
    80027a58:	1a453503          	ld	a0,420(a0) # 8002bbf8 <spi+0x30>
    80027a5c:	00000097          	auipc	ra,0x0
    80027a60:	368080e7          	jalr	872(ra) # 80027dc4 <set_gpio_bit>
}
    80027a64:	60a2                	ld	ra,8(sp)
    80027a66:	6402                	ld	s0,0(sp)
    80027a68:	0141                	addi	sp,sp,16
    80027a6a:	8082                	ret

0000000080027a6c <fpioa_set_io_pull>:
//     fpioa->io[number] = *cfg;
//     return 0;
// }

int fpioa_set_io_pull(int number, fpioa_pull_t pull)
{
    80027a6c:	1141                	addi	sp,sp,-16
    80027a6e:	e422                	sd	s0,8(sp)
    80027a70:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || pull >= FPIOA_PULL_MAX)
    80027a72:	02f00793          	li	a5,47
    80027a76:	06a7ed63          	bltu	a5,a0,80027af0 <fpioa_set_io_pull+0x84>
    80027a7a:	882a                	mv	a6,a0
    80027a7c:	4789                	li	a5,2
    80027a7e:	06b7eb63          	bltu	a5,a1,80027af4 <fpioa_set_io_pull+0x88>
        return -1;

    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80027a82:	003f56b7          	lui	a3,0x3f5
    80027a86:	00251793          	slli	a5,a0,0x2
    80027a8a:	02b68693          	addi	a3,a3,43 # 3f502b <_start-0x7fc2afd5>
    80027a8e:	06c2                	slli	a3,a3,0x10
    80027a90:	97b6                	add	a5,a5,a3
    80027a92:	439c                	lw	a5,0(a5)
    80027a94:	0107d61b          	srliw	a2,a5,0x10
    80027a98:	8a05                	andi	a2,a2,1
    80027a9a:	0117d69b          	srliw	a3,a5,0x11
    80027a9e:	8a85                	andi	a3,a3,1

    switch(pull)
    80027aa0:	4705                	li	a4,1
    80027aa2:	04e58163          	beq	a1,a4,80027ae4 <fpioa_set_io_pull+0x78>
    80027aa6:	4709                	li	a4,2
    80027aa8:	04e58163          	beq	a1,a4,80027aea <fpioa_set_io_pull+0x7e>
    80027aac:	c98d                	beqz	a1,80027ade <fpioa_set_io_pull+0x72>
            break;
        default:
            break;
    }
    /* Atomic write register */
    fpioa->io[number] = cfg;
    80027aae:	0106161b          	slliw	a2,a2,0x10
    80027ab2:	7741                	lui	a4,0xffff0
    80027ab4:	177d                	addi	a4,a4,-1
    80027ab6:	8ff9                	and	a5,a5,a4
    80027ab8:	8fd1                	or	a5,a5,a2
    80027aba:	0116969b          	slliw	a3,a3,0x11
    80027abe:	7701                	lui	a4,0xfffe0
    80027ac0:	177d                	addi	a4,a4,-1
    80027ac2:	8ff9                	and	a5,a5,a4
    80027ac4:	8fd5                	or	a5,a5,a3
    80027ac6:	003f5737          	lui	a4,0x3f5
    80027aca:	080a                	slli	a6,a6,0x2
    80027acc:	02b70713          	addi	a4,a4,43 # 3f502b <_start-0x7fc2afd5>
    80027ad0:	0742                	slli	a4,a4,0x10
    80027ad2:	9742                	add	a4,a4,a6
    80027ad4:	c31c                	sw	a5,0(a4)
    return 0;
    80027ad6:	4501                	li	a0,0
}
    80027ad8:	6422                	ld	s0,8(sp)
    80027ada:	0141                	addi	sp,sp,16
    80027adc:	8082                	ret
    switch(pull)
    80027ade:	4681                	li	a3,0
    80027ae0:	4601                	li	a2,0
    80027ae2:	b7f1                	j	80027aae <fpioa_set_io_pull+0x42>
            cfg.pd = 1;
    80027ae4:	4685                	li	a3,1
            cfg.pu = 0;
    80027ae6:	4601                	li	a2,0
    80027ae8:	b7d9                	j	80027aae <fpioa_set_io_pull+0x42>
            cfg.pd = 0;
    80027aea:	4681                	li	a3,0
            cfg.pu = 1;
    80027aec:	4605                	li	a2,1
    80027aee:	b7c1                	j	80027aae <fpioa_set_io_pull+0x42>
        return -1;
    80027af0:	557d                	li	a0,-1
    80027af2:	b7dd                	j	80027ad8 <fpioa_set_io_pull+0x6c>
    80027af4:	557d                	li	a0,-1
    80027af6:	b7cd                	j	80027ad8 <fpioa_set_io_pull+0x6c>

0000000080027af8 <fpioa_set_function_raw>:
// }

int fpioa_set_function_raw(int number, fpioa_function_t function)
{
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027af8:	02f00793          	li	a5,47
    80027afc:	14a7ed63          	bltu	a5,a0,80027c56 <fpioa_set_function_raw+0x15e>
    80027b00:	882a                	mv	a6,a0
    80027b02:	0ff00793          	li	a5,255
    80027b06:	14b7ea63          	bltu	a5,a1,80027c5a <fpioa_set_function_raw+0x162>
{
    80027b0a:	1101                	addi	sp,sp,-32
    80027b0c:	ec22                	sd	s0,24(sp)
    80027b0e:	e826                	sd	s1,16(sp)
    80027b10:	1000                	addi	s0,sp,32
        return -1;
    /* Atomic write register */
    fpioa->io[number] = (const fpioa_io_config_t){
        .ch_sel = function_config[function].ch_sel,
    80027b12:	1582                	slli	a1,a1,0x20
    80027b14:	9181                	srli	a1,a1,0x20
    80027b16:	058a                	slli	a1,a1,0x2
    80027b18:	00004797          	auipc	a5,0x4
    80027b1c:	0f078793          	addi	a5,a5,240 # 8002bc08 <function_config>
    80027b20:	95be                	add	a1,a1,a5
    80027b22:	0005c383          	lbu	t2,0(a1)
        .ds = function_config[function].ds,
    80027b26:	418c                	lw	a1,0(a1)
    80027b28:	0085d29b          	srliw	t0,a1,0x8
        .oe_en = function_config[function].oe_en,
    80027b2c:	00c5d69b          	srliw	a3,a1,0xc
        .oe_inv = function_config[function].oe_inv,
    80027b30:	00d5df9b          	srliw	t6,a1,0xd
        .do_sel = function_config[function].do_sel,
    80027b34:	00e5df1b          	srliw	t5,a1,0xe
        .do_inv = function_config[function].do_inv,
    80027b38:	00f5d71b          	srliw	a4,a1,0xf
        .pu = function_config[function].pu,
    80027b3c:	0105de9b          	srliw	t4,a1,0x10
        .pd = function_config[function].pd,
    80027b40:	0115de1b          	srliw	t3,a1,0x11
        .sl = function_config[function].sl,
    80027b44:	0135d79b          	srliw	a5,a1,0x13
        .ie_en = function_config[function].ie_en,
    80027b48:	0145d31b          	srliw	t1,a1,0x14
        .ie_inv = function_config[function].ie_inv,
    80027b4c:	0155d89b          	srliw	a7,a1,0x15
        .di_inv = function_config[function].di_inv,
    80027b50:	0165d51b          	srliw	a0,a1,0x16
        .st = function_config[function].st,
    80027b54:	0175d59b          	srliw	a1,a1,0x17
    fpioa->io[number] = (const fpioa_io_config_t){
    80027b58:	fe041023          	sh	zero,-32(s0)
    80027b5c:	fe040123          	sb	zero,-30(s0)
    80027b60:	fe043603          	ld	a2,-32(s0)
    80027b64:	0086161b          	slliw	a2,a2,0x8
    80027b68:	00766633          	or	a2,a2,t2
    80027b6c:	00f2f293          	andi	t0,t0,15
    80027b70:	0082929b          	slliw	t0,t0,0x8
    80027b74:	73fd                	lui	t2,0xfffff
    80027b76:	0ff38493          	addi	s1,t2,255 # fffffffffffff0ff <kernel_end+0xffffffff7ffb90ff>
    80027b7a:	8e65                	and	a2,a2,s1
    80027b7c:	00566633          	or	a2,a2,t0
    80027b80:	8a85                	andi	a3,a3,1
    80027b82:	00c6969b          	slliw	a3,a3,0xc
    80027b86:	13fd                	addi	t2,t2,-1
    80027b88:	00767633          	and	a2,a2,t2
    80027b8c:	8e55                	or	a2,a2,a3
    80027b8e:	001fff93          	andi	t6,t6,1
    80027b92:	00df9f9b          	slliw	t6,t6,0xd
    80027b96:	76f9                	lui	a3,0xffffe
    80027b98:	16fd                	addi	a3,a3,-1
    80027b9a:	8ef1                	and	a3,a3,a2
    80027b9c:	01f6e633          	or	a2,a3,t6
    80027ba0:	001f7693          	andi	a3,t5,1
    80027ba4:	00e69f1b          	slliw	t5,a3,0xe
    80027ba8:	76f1                	lui	a3,0xffffc
    80027baa:	16fd                	addi	a3,a3,-1
    80027bac:	8ef1                	and	a3,a3,a2
    80027bae:	01e6e6b3          	or	a3,a3,t5
    80027bb2:	8b05                	andi	a4,a4,1
    80027bb4:	00f7171b          	slliw	a4,a4,0xf
    80027bb8:	7661                	lui	a2,0xffff8
    80027bba:	167d                	addi	a2,a2,-1
    80027bbc:	8ef1                	and	a3,a3,a2
    80027bbe:	8ed9                	or	a3,a3,a4
    80027bc0:	001ef613          	andi	a2,t4,1
    80027bc4:	0106161b          	slliw	a2,a2,0x10
    80027bc8:	7741                	lui	a4,0xffff0
    80027bca:	177d                	addi	a4,a4,-1
    80027bcc:	8f75                	and	a4,a4,a3
    80027bce:	00c766b3          	or	a3,a4,a2
    80027bd2:	001e7713          	andi	a4,t3,1
    80027bd6:	0117161b          	slliw	a2,a4,0x11
    80027bda:	7701                	lui	a4,0xfffe0
    80027bdc:	177d                	addi	a4,a4,-1
    80027bde:	8f75                	and	a4,a4,a3
    80027be0:	8f51                	or	a4,a4,a2
    80027be2:	8b85                	andi	a5,a5,1
    80027be4:	0137979b          	slliw	a5,a5,0x13
    80027be8:	fff806b7          	lui	a3,0xfff80
    80027bec:	16fd                	addi	a3,a3,-1
    80027bee:	8f75                	and	a4,a4,a3
    80027bf0:	8f5d                	or	a4,a4,a5
    80027bf2:	00137693          	andi	a3,t1,1
    80027bf6:	0146969b          	slliw	a3,a3,0x14
    80027bfa:	fff007b7          	lui	a5,0xfff00
    80027bfe:	17fd                	addi	a5,a5,-1
    80027c00:	8ff9                	and	a5,a5,a4
    80027c02:	00d7e733          	or	a4,a5,a3
    80027c06:	0018f793          	andi	a5,a7,1
    80027c0a:	0157969b          	slliw	a3,a5,0x15
    80027c0e:	ffe007b7          	lui	a5,0xffe00
    80027c12:	17fd                	addi	a5,a5,-1
    80027c14:	8ff9                	and	a5,a5,a4
    80027c16:	8fd5                	or	a5,a5,a3
    80027c18:	8905                	andi	a0,a0,1
    80027c1a:	0165151b          	slliw	a0,a0,0x16
    80027c1e:	ffc00737          	lui	a4,0xffc00
    80027c22:	177d                	addi	a4,a4,-1
    80027c24:	8ff9                	and	a5,a5,a4
    80027c26:	8fc9                	or	a5,a5,a0
    80027c28:	8985                	andi	a1,a1,1
    80027c2a:	0175959b          	slliw	a1,a1,0x17
    80027c2e:	ff800737          	lui	a4,0xff800
    80027c32:	177d                	addi	a4,a4,-1
    80027c34:	8ff9                	and	a5,a5,a4
    80027c36:	8fcd                	or	a5,a5,a1
    80027c38:	003f5737          	lui	a4,0x3f5
    80027c3c:	00281693          	slli	a3,a6,0x2
    80027c40:	02b70813          	addi	a6,a4,43 # 3f502b <_start-0x7fc2afd5>
    80027c44:	0842                	slli	a6,a6,0x10
    80027c46:	9836                	add	a6,a6,a3
    80027c48:	00f82023          	sw	a5,0(a6)
        /* resv and pad_di do not need initialization */
    };
    return 0;
    80027c4c:	4501                	li	a0,0
}
    80027c4e:	6462                	ld	s0,24(sp)
    80027c50:	64c2                	ld	s1,16(sp)
    80027c52:	6105                	addi	sp,sp,32
    80027c54:	8082                	ret
        return -1;
    80027c56:	557d                	li	a0,-1
    80027c58:	8082                	ret
    80027c5a:	557d                	li	a0,-1
}
    80027c5c:	8082                	ret

0000000080027c5e <fpioa_set_function>:

int fpioa_set_function(int number, fpioa_function_t function)
{
    uint8 index = 0;
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027c5e:	02f00793          	li	a5,47
    80027c62:	08a7ed63          	bltu	a5,a0,80027cfc <fpioa_set_function+0x9e>
{
    80027c66:	7139                	addi	sp,sp,-64
    80027c68:	fc06                	sd	ra,56(sp)
    80027c6a:	f822                	sd	s0,48(sp)
    80027c6c:	f426                	sd	s1,40(sp)
    80027c6e:	f04a                	sd	s2,32(sp)
    80027c70:	ec4e                	sd	s3,24(sp)
    80027c72:	e852                	sd	s4,16(sp)
    80027c74:	e456                	sd	s5,8(sp)
    80027c76:	0080                	addi	s0,sp,64
    80027c78:	892e                	mv	s2,a1
    80027c7a:	8a2a                	mv	s4,a0
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80027c7c:	0ff00793          	li	a5,255
    80027c80:	08b7e063          	bltu	a5,a1,80027d00 <fpioa_set_function+0xa2>
        return -1;
    if(function == FUNC_RESV0)
    80027c84:	07800793          	li	a5,120
    80027c88:	4481                	li	s1,0
    80027c8a:	00f58a63          	beq	a1,a5,80027c9e <fpioa_set_function+0x40>
        return 0;
    }
    /* Compare all IO */
    for(index = 0; index < FPIOA_NUM_IO; index++)
    {
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80027c8e:	003f59b7          	lui	s3,0x3f5
    80027c92:	02b98993          	addi	s3,s3,43 # 3f502b <_start-0x7fc2afd5>
    80027c96:	09c2                	slli	s3,s3,0x10
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027c98:	03000a93          	li	s5,48
    80027c9c:	a821                	j	80027cb4 <fpioa_set_function+0x56>
        fpioa_set_function_raw(number, FUNC_RESV0);
    80027c9e:	07800593          	li	a1,120
    80027ca2:	00000097          	auipc	ra,0x0
    80027ca6:	e56080e7          	jalr	-426(ra) # 80027af8 <fpioa_set_function_raw>
        return 0;
    80027caa:	4501                	li	a0,0
    80027cac:	a83d                	j	80027cea <fpioa_set_function+0x8c>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027cae:	2485                	addiw	s1,s1,1
    80027cb0:	03548663          	beq	s1,s5,80027cdc <fpioa_set_function+0x7e>
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80027cb4:	0004851b          	sext.w	a0,s1
    80027cb8:	00249793          	slli	a5,s1,0x2
    80027cbc:	97ce                	add	a5,a5,s3
    80027cbe:	0007c783          	lbu	a5,0(a5) # ffffffffffe00000 <kernel_end+0xffffffff7fdba000>
    80027cc2:	0ff7f793          	andi	a5,a5,255
    80027cc6:	ff2794e3          	bne	a5,s2,80027cae <fpioa_set_function+0x50>
    80027cca:	ff4502e3          	beq	a0,s4,80027cae <fpioa_set_function+0x50>
            fpioa_set_function_raw(index, FUNC_RESV0);
    80027cce:	07800593          	li	a1,120
    80027cd2:	00000097          	auipc	ra,0x0
    80027cd6:	e26080e7          	jalr	-474(ra) # 80027af8 <fpioa_set_function_raw>
    80027cda:	bfd1                	j	80027cae <fpioa_set_function+0x50>
    }
    fpioa_set_function_raw(number, function);
    80027cdc:	85ca                	mv	a1,s2
    80027cde:	8552                	mv	a0,s4
    80027ce0:	00000097          	auipc	ra,0x0
    80027ce4:	e18080e7          	jalr	-488(ra) # 80027af8 <fpioa_set_function_raw>
    return 0;
    80027ce8:	4501                	li	a0,0
}
    80027cea:	70e2                	ld	ra,56(sp)
    80027cec:	7442                	ld	s0,48(sp)
    80027cee:	74a2                	ld	s1,40(sp)
    80027cf0:	7902                	ld	s2,32(sp)
    80027cf2:	69e2                	ld	s3,24(sp)
    80027cf4:	6a42                	ld	s4,16(sp)
    80027cf6:	6aa2                	ld	s5,8(sp)
    80027cf8:	6121                	addi	sp,sp,64
    80027cfa:	8082                	ret
        return -1;
    80027cfc:	557d                	li	a0,-1
}
    80027cfe:	8082                	ret
        return -1;
    80027d00:	557d                	li	a0,-1
    80027d02:	b7e5                	j	80027cea <fpioa_set_function+0x8c>

0000000080027d04 <fpioa_get_io_by_function>:
//         fpioa->tie.val[function / 32] &= (~(1UL << (function % 32)));
//     return 0;
// }

int fpioa_get_io_by_function(fpioa_function_t function)
{
    80027d04:	1141                	addi	sp,sp,-16
    80027d06:	e422                	sd	s0,8(sp)
    80027d08:	0800                	addi	s0,sp,16
    80027d0a:	86aa                	mv	a3,a0
    int index = 0;
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027d0c:	4501                	li	a0,0
    {
        if(fpioa->io[index].ch_sel == function)
    80027d0e:	003f5737          	lui	a4,0x3f5
    80027d12:	02b70713          	addi	a4,a4,43 # 3f502b <_start-0x7fc2afd5>
    80027d16:	0742                	slli	a4,a4,0x10
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027d18:	03000613          	li	a2,48
        if(fpioa->io[index].ch_sel == function)
    80027d1c:	00251793          	slli	a5,a0,0x2
    80027d20:	97ba                	add	a5,a5,a4
    80027d22:	0007c783          	lbu	a5,0(a5)
    80027d26:	0ff7f793          	andi	a5,a5,255
    80027d2a:	00d78663          	beq	a5,a3,80027d36 <fpioa_get_io_by_function+0x32>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027d2e:	2505                	addiw	a0,a0,1
    80027d30:	fec516e3          	bne	a0,a2,80027d1c <fpioa_get_io_by_function+0x18>
            return index;
    }

    return -1;
    80027d34:	557d                	li	a0,-1
}
    80027d36:	6422                	ld	s0,8(sp)
    80027d38:	0141                	addi	sp,sp,16
    80027d3a:	8082                	ret

0000000080027d3c <fpioa_pin_init>:

void fpioa_pin_init() {
    80027d3c:	1141                	addi	sp,sp,-16
    80027d3e:	e406                	sd	ra,8(sp)
    80027d40:	e022                	sd	s0,0(sp)
    80027d42:	0800                	addi	s0,sp,16
    fpioa_set_function(27, FUNC_SPI0_SCLK);
    80027d44:	45c5                	li	a1,17
    80027d46:	456d                	li	a0,27
    80027d48:	00000097          	auipc	ra,0x0
    80027d4c:	f16080e7          	jalr	-234(ra) # 80027c5e <fpioa_set_function>
    fpioa_set_function(28, FUNC_SPI0_D0);
    80027d50:	4591                	li	a1,4
    80027d52:	4571                	li	a0,28
    80027d54:	00000097          	auipc	ra,0x0
    80027d58:	f0a080e7          	jalr	-246(ra) # 80027c5e <fpioa_set_function>
    fpioa_set_function(26, FUNC_SPI0_D1);
    80027d5c:	4595                	li	a1,5
    80027d5e:	4569                	li	a0,26
    80027d60:	00000097          	auipc	ra,0x0
    80027d64:	efe080e7          	jalr	-258(ra) # 80027c5e <fpioa_set_function>
	fpioa_set_function(32, FUNC_GPIOHS7);
    80027d68:	45fd                	li	a1,31
    80027d6a:	02000513          	li	a0,32
    80027d6e:	00000097          	auipc	ra,0x0
    80027d72:	ef0080e7          	jalr	-272(ra) # 80027c5e <fpioa_set_function>
    fpioa_set_function(29, FUNC_SPI0_SS3);
    80027d76:	45bd                	li	a1,15
    80027d78:	4575                	li	a0,29
    80027d7a:	00000097          	auipc	ra,0x0
    80027d7e:	ee4080e7          	jalr	-284(ra) # 80027c5e <fpioa_set_function>
    #ifdef DEBUG
    printf("fpioa_pin_init\n");
    #endif
    80027d82:	60a2                	ld	ra,8(sp)
    80027d84:	6402                	ld	s0,0(sp)
    80027d86:	0141                	addi	sp,sp,16
    80027d88:	8082                	ret

0000000080027d8a <set_bit>:
#include "include/types.h"
#include "include/utils.h"

void set_bit(volatile uint32 *bits, uint32 mask, uint32 value)
{
    80027d8a:	1141                	addi	sp,sp,-16
    80027d8c:	e422                	sd	s0,8(sp)
    80027d8e:	0800                	addi	s0,sp,16
    uint32 org = (*bits) & ~mask;
    80027d90:	411c                	lw	a5,0(a0)
    80027d92:	2781                	sext.w	a5,a5
    *bits = org | (value & mask);
    80027d94:	8e3d                	xor	a2,a2,a5
    80027d96:	8e6d                	and	a2,a2,a1
    80027d98:	8fb1                	xor	a5,a5,a2
    80027d9a:	c11c                	sw	a5,0(a0)
}
    80027d9c:	6422                	ld	s0,8(sp)
    80027d9e:	0141                	addi	sp,sp,16
    80027da0:	8082                	ret

0000000080027da2 <set_bit_offset>:

void set_bit_offset(volatile uint32 *bits, uint32 mask, uint64 offset, uint32 value)
{
    80027da2:	1141                	addi	sp,sp,-16
    80027da4:	e422                	sd	s0,8(sp)
    80027da6:	0800                	addi	s0,sp,16
    uint32 org = (*bits) & ~mask;
    80027da8:	411c                	lw	a5,0(a0)
    80027daa:	2781                	sext.w	a5,a5
    set_bit(bits, mask << offset, value << offset);
    80027dac:	00c696bb          	sllw	a3,a3,a2
    *bits = org | (value & mask);
    80027db0:	8ebd                	xor	a3,a3,a5
    set_bit(bits, mask << offset, value << offset);
    80027db2:	00c595bb          	sllw	a1,a1,a2
    *bits = org | (value & mask);
    80027db6:	8eed                	and	a3,a3,a1
    80027db8:	8fb5                	xor	a5,a5,a3
    80027dba:	2781                	sext.w	a5,a5
    80027dbc:	c11c                	sw	a5,0(a0)
}
    80027dbe:	6422                	ld	s0,8(sp)
    80027dc0:	0141                	addi	sp,sp,16
    80027dc2:	8082                	ret

0000000080027dc4 <set_gpio_bit>:

void set_gpio_bit(volatile uint32 *bits, uint64 offset, uint32 value)
{
    80027dc4:	1141                	addi	sp,sp,-16
    80027dc6:	e406                	sd	ra,8(sp)
    80027dc8:	e022                	sd	s0,0(sp)
    80027dca:	0800                	addi	s0,sp,16
    80027dcc:	86b2                	mv	a3,a2
    set_bit_offset(bits, 1, offset, value);
    80027dce:	862e                	mv	a2,a1
    80027dd0:	4585                	li	a1,1
    80027dd2:	00000097          	auipc	ra,0x0
    80027dd6:	fd0080e7          	jalr	-48(ra) # 80027da2 <set_bit_offset>
}
    80027dda:	60a2                	ld	ra,8(sp)
    80027ddc:	6402                	ld	s0,0(sp)
    80027dde:	0141                	addi	sp,sp,16
    80027de0:	8082                	ret

0000000080027de2 <get_bit>:

uint32 get_bit(volatile uint32 *bits, uint32 mask, uint64 offset)
{
    80027de2:	1141                	addi	sp,sp,-16
    80027de4:	e422                	sd	s0,8(sp)
    80027de6:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    80027de8:	411c                	lw	a5,0(a0)
    80027dea:	2781                	sext.w	a5,a5
    80027dec:	00c595bb          	sllw	a1,a1,a2
    80027df0:	8fed                	and	a5,a5,a1
}
    80027df2:	00c7d53b          	srlw	a0,a5,a2
    80027df6:	6422                	ld	s0,8(sp)
    80027df8:	0141                	addi	sp,sp,16
    80027dfa:	8082                	ret

0000000080027dfc <get_gpio_bit>:

uint32 get_gpio_bit(volatile uint32 *bits, uint64 offset)
{
    80027dfc:	1141                	addi	sp,sp,-16
    80027dfe:	e422                	sd	s0,8(sp)
    80027e00:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    80027e02:	411c                	lw	a5,0(a0)
    80027e04:	2781                	sext.w	a5,a5
    80027e06:	4705                	li	a4,1
    80027e08:	00b7173b          	sllw	a4,a4,a1
    80027e0c:	8ff9                	and	a5,a5,a4
    return get_bit(bits, 1, offset);
}
    80027e0e:	00b7d53b          	srlw	a0,a5,a1
    80027e12:	6422                	ld	s0,8(sp)
    80027e14:	0141                	addi	sp,sp,16
    80027e16:	8082                	ret

0000000080027e18 <sd_write_data>:
static void sd_lowlevel_init(uint8 spi_index) {
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    // spi_set_clk_rate(SPI_DEVICE_0, 200000);     /*set clk rate*/
}

static void sd_write_data(uint8 const *data_buff, uint32 length) {
    80027e18:	1101                	addi	sp,sp,-32
    80027e1a:	ec06                	sd	ra,24(sp)
    80027e1c:	e822                	sd	s0,16(sp)
    80027e1e:	e426                	sd	s1,8(sp)
    80027e20:	e04a                	sd	s2,0(sp)
    80027e22:	1000                	addi	s0,sp,32
    80027e24:	84aa                	mv	s1,a0
    80027e26:	892e                	mv	s2,a1
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80027e28:	4701                	li	a4,0
    80027e2a:	46a1                	li	a3,8
    80027e2c:	4601                	li	a2,0
    80027e2e:	4581                	li	a1,0
    80027e30:	4501                	li	a0,0
    80027e32:	fffff097          	auipc	ra,0xfffff
    80027e36:	00a080e7          	jalr	10(ra) # 80026e3c <spi_init>
    spi_send_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    80027e3a:	02091793          	slli	a5,s2,0x20
    80027e3e:	9381                	srli	a5,a5,0x20
    80027e40:	8726                	mv	a4,s1
    80027e42:	4681                	li	a3,0
    80027e44:	4601                	li	a2,0
    80027e46:	458d                	li	a1,3
    80027e48:	4501                	li	a0,0
    80027e4a:	fffff097          	auipc	ra,0xfffff
    80027e4e:	258080e7          	jalr	600(ra) # 800270a2 <spi_send_data_standard>
}
    80027e52:	60e2                	ld	ra,24(sp)
    80027e54:	6442                	ld	s0,16(sp)
    80027e56:	64a2                	ld	s1,8(sp)
    80027e58:	6902                	ld	s2,0(sp)
    80027e5a:	6105                	addi	sp,sp,32
    80027e5c:	8082                	ret

0000000080027e5e <sd_read_data>:

static void sd_read_data(uint8 *data_buff, uint32 length) {
    80027e5e:	1101                	addi	sp,sp,-32
    80027e60:	ec06                	sd	ra,24(sp)
    80027e62:	e822                	sd	s0,16(sp)
    80027e64:	e426                	sd	s1,8(sp)
    80027e66:	e04a                	sd	s2,0(sp)
    80027e68:	1000                	addi	s0,sp,32
    80027e6a:	84aa                	mv	s1,a0
    80027e6c:	892e                	mv	s2,a1
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80027e6e:	4701                	li	a4,0
    80027e70:	46a1                	li	a3,8
    80027e72:	4601                	li	a2,0
    80027e74:	4581                	li	a1,0
    80027e76:	4501                	li	a0,0
    80027e78:	fffff097          	auipc	ra,0xfffff
    80027e7c:	fc4080e7          	jalr	-60(ra) # 80026e3c <spi_init>
    spi_receive_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    80027e80:	02091793          	slli	a5,s2,0x20
    80027e84:	9381                	srli	a5,a5,0x20
    80027e86:	8726                	mv	a4,s1
    80027e88:	4681                	li	a3,0
    80027e8a:	4601                	li	a2,0
    80027e8c:	458d                	li	a1,3
    80027e8e:	4501                	li	a0,0
    80027e90:	fffff097          	auipc	ra,0xfffff
    80027e94:	2aa080e7          	jalr	682(ra) # 8002713a <spi_receive_data_standard>
}
    80027e98:	60e2                	ld	ra,24(sp)
    80027e9a:	6442                	ld	s0,16(sp)
    80027e9c:	64a2                	ld	s1,8(sp)
    80027e9e:	6902                	ld	s2,0(sp)
    80027ea0:	6105                	addi	sp,sp,32
    80027ea2:	8082                	ret

0000000080027ea4 <sd_get_response_R1>:
#define SD_CMD13 	13 		// SEND_STATUS

/*
 * Read sdcard response in R1 type. 
 */
static uint8 sd_get_response_R1(void) {
    80027ea4:	7139                	addi	sp,sp,-64
    80027ea6:	fc06                	sd	ra,56(sp)
    80027ea8:	f822                	sd	s0,48(sp)
    80027eaa:	f426                	sd	s1,40(sp)
    80027eac:	f04a                	sd	s2,32(sp)
    80027eae:	ec4e                	sd	s3,24(sp)
    80027eb0:	0080                	addi	s0,sp,64
    80027eb2:	0ff00493          	li	s1,255
	uint8 result;
	uint16 timeout = 0xff;

	while (timeout--) {
		sd_read_data(&result, 1);
    80027eb6:	fcf40993          	addi	s3,s0,-49
		if (result != 0xff)
    80027eba:	0ff00913          	li	s2,255
		sd_read_data(&result, 1);
    80027ebe:	4585                	li	a1,1
    80027ec0:	854e                	mv	a0,s3
    80027ec2:	00000097          	auipc	ra,0x0
    80027ec6:	f9c080e7          	jalr	-100(ra) # 80027e5e <sd_read_data>
		if (result != 0xff)
    80027eca:	fcf44503          	lbu	a0,-49(s0)
    80027ece:	01251663          	bne	a0,s2,80027eda <sd_get_response_R1+0x36>
	while (timeout--) {
    80027ed2:	34fd                	addiw	s1,s1,-1
    80027ed4:	14c2                	slli	s1,s1,0x30
    80027ed6:	90c1                	srli	s1,s1,0x30
    80027ed8:	f0fd                	bnez	s1,80027ebe <sd_get_response_R1+0x1a>
			return result;
	}

	// timeout!
	return 0xff;
}
    80027eda:	70e2                	ld	ra,56(sp)
    80027edc:	7442                	ld	s0,48(sp)
    80027ede:	74a2                	ld	s1,40(sp)
    80027ee0:	7902                	ld	s2,32(sp)
    80027ee2:	69e2                	ld	s3,24(sp)
    80027ee4:	6121                	addi	sp,sp,64
    80027ee6:	8082                	ret

0000000080027ee8 <SD_CS_HIGH>:
void SD_CS_HIGH(void) {
    80027ee8:	1141                	addi	sp,sp,-16
    80027eea:	e406                	sd	ra,8(sp)
    80027eec:	e022                	sd	s0,0(sp)
    80027eee:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_HIGH);
    80027ef0:	4585                	li	a1,1
    80027ef2:	451d                	li	a0,7
    80027ef4:	00000097          	auipc	ra,0x0
    80027ef8:	b54080e7          	jalr	-1196(ra) # 80027a48 <gpiohs_set_pin>
}
    80027efc:	60a2                	ld	ra,8(sp)
    80027efe:	6402                	ld	s0,0(sp)
    80027f00:	0141                	addi	sp,sp,16
    80027f02:	8082                	ret

0000000080027f04 <sd_end_cmd>:
static void sd_end_cmd(void) {
    80027f04:	1101                	addi	sp,sp,-32
    80027f06:	ec06                	sd	ra,24(sp)
    80027f08:	e822                	sd	s0,16(sp)
    80027f0a:	1000                	addi	s0,sp,32
	uint8 frame[1] = {0xFF};
    80027f0c:	57fd                	li	a5,-1
    80027f0e:	fef40423          	sb	a5,-24(s0)
	SD_CS_HIGH();
    80027f12:	00000097          	auipc	ra,0x0
    80027f16:	fd6080e7          	jalr	-42(ra) # 80027ee8 <SD_CS_HIGH>
	sd_write_data(frame, 1);
    80027f1a:	4585                	li	a1,1
    80027f1c:	fe840513          	addi	a0,s0,-24
    80027f20:	00000097          	auipc	ra,0x0
    80027f24:	ef8080e7          	jalr	-264(ra) # 80027e18 <sd_write_data>
}
    80027f28:	60e2                	ld	ra,24(sp)
    80027f2a:	6442                	ld	s0,16(sp)
    80027f2c:	6105                	addi	sp,sp,32
    80027f2e:	8082                	ret

0000000080027f30 <SD_CS_LOW>:
void SD_CS_LOW(void) {
    80027f30:	1141                	addi	sp,sp,-16
    80027f32:	e406                	sd	ra,8(sp)
    80027f34:	e022                	sd	s0,0(sp)
    80027f36:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_LOW);
    80027f38:	4581                	li	a1,0
    80027f3a:	451d                	li	a0,7
    80027f3c:	00000097          	auipc	ra,0x0
    80027f40:	b0c080e7          	jalr	-1268(ra) # 80027a48 <gpiohs_set_pin>
}
    80027f44:	60a2                	ld	ra,8(sp)
    80027f46:	6402                	ld	s0,0(sp)
    80027f48:	0141                	addi	sp,sp,16
    80027f4a:	8082                	ret

0000000080027f4c <sd_send_cmd>:
static void sd_send_cmd(uint8 cmd, uint32 arg, uint8 crc) {
    80027f4c:	1101                	addi	sp,sp,-32
    80027f4e:	ec06                	sd	ra,24(sp)
    80027f50:	e822                	sd	s0,16(sp)
    80027f52:	1000                	addi	s0,sp,32
	frame[0] = (cmd | 0x40);
    80027f54:	04056513          	ori	a0,a0,64
    80027f58:	fea40423          	sb	a0,-24(s0)
	frame[1] = (uint8)(arg >> 24);
    80027f5c:	0185d79b          	srliw	a5,a1,0x18
    80027f60:	fef404a3          	sb	a5,-23(s0)
	frame[2] = (uint8)(arg >> 16);
    80027f64:	0105d79b          	srliw	a5,a1,0x10
    80027f68:	fef40523          	sb	a5,-22(s0)
	frame[3] = (uint8)(arg >> 8);
    80027f6c:	0085d79b          	srliw	a5,a1,0x8
    80027f70:	fef405a3          	sb	a5,-21(s0)
	frame[4] = (uint8)(arg);
    80027f74:	feb40623          	sb	a1,-20(s0)
	frame[5] = (crc);
    80027f78:	fec406a3          	sb	a2,-19(s0)
	SD_CS_LOW();
    80027f7c:	00000097          	auipc	ra,0x0
    80027f80:	fb4080e7          	jalr	-76(ra) # 80027f30 <SD_CS_LOW>
	sd_write_data(frame, 6);
    80027f84:	4599                	li	a1,6
    80027f86:	fe840513          	addi	a0,s0,-24
    80027f8a:	00000097          	auipc	ra,0x0
    80027f8e:	e8e080e7          	jalr	-370(ra) # 80027e18 <sd_write_data>
}
    80027f92:	60e2                	ld	ra,24(sp)
    80027f94:	6442                	ld	s0,16(sp)
    80027f96:	6105                	addi	sp,sp,32
    80027f98:	8082                	ret

0000000080027f9a <SD_HIGH_SPEED_ENABLE>:
void SD_HIGH_SPEED_ENABLE(void) {
    80027f9a:	1141                	addi	sp,sp,-16
    80027f9c:	e422                	sd	s0,8(sp)
    80027f9e:	0800                	addi	s0,sp,16
}
    80027fa0:	6422                	ld	s0,8(sp)
    80027fa2:	0141                	addi	sp,sp,16
    80027fa4:	8082                	ret

0000000080027fa6 <sdcard_init>:
	return 0;
}

static struct sleeplock sdcard_lock;

void sdcard_init(void) {
    80027fa6:	711d                	addi	sp,sp,-96
    80027fa8:	ec86                	sd	ra,88(sp)
    80027faa:	e8a2                	sd	s0,80(sp)
    80027fac:	e4a6                	sd	s1,72(sp)
    80027fae:	e0ca                	sd	s2,64(sp)
    80027fb0:	fc4e                	sd	s3,56(sp)
    80027fb2:	f852                	sd	s4,48(sp)
    80027fb4:	f456                	sd	s5,40(sp)
    80027fb6:	1080                	addi	s0,sp,96
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    80027fb8:	458d                	li	a1,3
    80027fba:	451d                	li	a0,7
    80027fbc:	00000097          	auipc	ra,0x0
    80027fc0:	9f8080e7          	jalr	-1544(ra) # 800279b4 <gpiohs_set_drive_mode>
	SD_CS_LOW();
    80027fc4:	00000097          	auipc	ra,0x0
    80027fc8:	f6c080e7          	jalr	-148(ra) # 80027f30 <SD_CS_LOW>
	for (int i = 0; i < 10; i ++) 
    80027fcc:	fb040793          	addi	a5,s0,-80
    80027fd0:	fba40693          	addi	a3,s0,-70
		frame[i] = 0xff;
    80027fd4:	577d                	li	a4,-1
    80027fd6:	00e78023          	sb	a4,0(a5)
	for (int i = 0; i < 10; i ++) 
    80027fda:	0785                	addi	a5,a5,1
    80027fdc:	fed79de3          	bne	a5,a3,80027fd6 <sdcard_init+0x30>
	sd_write_data(frame, 10);
    80027fe0:	45a9                	li	a1,10
    80027fe2:	fb040513          	addi	a0,s0,-80
    80027fe6:	00000097          	auipc	ra,0x0
    80027fea:	e32080e7          	jalr	-462(ra) # 80027e18 <sd_write_data>
    80027fee:	0fe00913          	li	s2,254
		if (0x01 == result) break;
    80027ff2:	4985                	li	s3,1
		sd_send_cmd(SD_CMD0, 0, 0x95);
    80027ff4:	09500613          	li	a2,149
    80027ff8:	4581                	li	a1,0
    80027ffa:	4501                	li	a0,0
    80027ffc:	00000097          	auipc	ra,0x0
    80028000:	f50080e7          	jalr	-176(ra) # 80027f4c <sd_send_cmd>
		uint64 result = sd_get_response_R1();
    80028004:	00000097          	auipc	ra,0x0
    80028008:	ea0080e7          	jalr	-352(ra) # 80027ea4 <sd_get_response_R1>
    8002800c:	84aa                	mv	s1,a0
		sd_end_cmd();
    8002800e:	00000097          	auipc	ra,0x0
    80028012:	ef6080e7          	jalr	-266(ra) # 80027f04 <sd_end_cmd>
		if (0x01 == result) break;
    80028016:	25348d63          	beq	s1,s3,80028270 <sdcard_init+0x2ca>
	while (--timeout) {
    8002801a:	397d                	addiw	s2,s2,-1
    8002801c:	fc091ce3          	bnez	s2,80027ff4 <sdcard_init+0x4e>
		printf("SD_CMD0 failed\n");
    80028020:	00004517          	auipc	a0,0x4
    80028024:	13850513          	addi	a0,a0,312 # 8002c158 <fpioa+0x150>
    80028028:	ffff8097          	auipc	ra,0xffff8
    8002802c:	164080e7          	jalr	356(ra) # 8002018c <printf>
		return 0xff;
    80028030:	ac69                	j	800282ca <sdcard_init+0x324>
		printf("invalid CRC for CMD8\n");
    80028032:	00004517          	auipc	a0,0x4
    80028036:	fde50513          	addi	a0,a0,-34 # 8002c010 <fpioa+0x8>
    8002803a:	ffff8097          	auipc	ra,0xffff8
    8002803e:	152080e7          	jalr	338(ra) # 8002018c <printf>
		return 0xff;
    80028042:	a461                	j	800282ca <sdcard_init+0x324>
	else if (0x01 == result && 0x01 == (frame[2] & 0x0f) && 0xaa == frame[3]) {
    80028044:	fab44703          	lbu	a4,-85(s0)
    80028048:	0aa00793          	li	a5,170
    8002804c:	26f71763          	bne	a4,a5,800282ba <sdcard_init+0x314>
    80028050:	0fe00913          	li	s2,254
	sd_read_data(frame, 4);
    80028054:	fa840a93          	addi	s5,s0,-88
		if (
    80028058:	4a05                	li	s4,1
    8002805a:	a021                	j	80028062 <sdcard_init+0xbc>
	while (--timeout) {
    8002805c:	397d                	addiw	s2,s2,-1
    8002805e:	12090f63          	beqz	s2,8002819c <sdcard_init+0x1f6>
		sd_send_cmd(SD_CMD58, 0, 0);
    80028062:	4601                	li	a2,0
    80028064:	4581                	li	a1,0
    80028066:	03a00513          	li	a0,58
    8002806a:	00000097          	auipc	ra,0x0
    8002806e:	ee2080e7          	jalr	-286(ra) # 80027f4c <sd_send_cmd>
		result = sd_get_response_R1();
    80028072:	00000097          	auipc	ra,0x0
    80028076:	e32080e7          	jalr	-462(ra) # 80027ea4 <sd_get_response_R1>
    8002807a:	84aa                	mv	s1,a0
	sd_read_data(frame, 4);
    8002807c:	4591                	li	a1,4
    8002807e:	8556                	mv	a0,s5
    80028080:	00000097          	auipc	ra,0x0
    80028084:	dde080e7          	jalr	-546(ra) # 80027e5e <sd_read_data>
		sd_end_cmd();
    80028088:	00000097          	auipc	ra,0x0
    8002808c:	e7c080e7          	jalr	-388(ra) # 80027f04 <sd_end_cmd>
		if (
    80028090:	fd4496e3          	bne	s1,s4,8002805c <sdcard_init+0xb6>
			0x01 == result && // R1 response in idle status 
    80028094:	fa944783          	lbu	a5,-87(s0)
    80028098:	8bfd                	andi	a5,a5,31
    8002809a:	d3e9                	beqz	a5,8002805c <sdcard_init+0xb6>
			(ocr[1] & 0x1f) && (ocr[2] & 0x80) 	// voltage range valid 
    8002809c:	faa40783          	lb	a5,-86(s0)
    800280a0:	fa07dee3          	bgez	a5,8002805c <sdcard_init+0xb6>
    800280a4:	6905                	lui	s2,0x1
    800280a6:	197d                	addi	s2,s2,-1
    800280a8:	0ff00493          	li	s1,255
		if (0x01 != result) {
    800280ac:	4985                	li	s3,1
	while (--timeout) {
    800280ae:	397d                	addiw	s2,s2,-1
    800280b0:	12090363          	beqz	s2,800281d6 <sdcard_init+0x230>
		sd_send_cmd(SD_CMD55, 0, 0);
    800280b4:	4601                	li	a2,0
    800280b6:	4581                	li	a1,0
    800280b8:	03700513          	li	a0,55
    800280bc:	00000097          	auipc	ra,0x0
    800280c0:	e90080e7          	jalr	-368(ra) # 80027f4c <sd_send_cmd>
		result = sd_get_response_R1();
    800280c4:	00000097          	auipc	ra,0x0
    800280c8:	de0080e7          	jalr	-544(ra) # 80027ea4 <sd_get_response_R1>
    800280cc:	84aa                	mv	s1,a0
		sd_end_cmd();
    800280ce:	00000097          	auipc	ra,0x0
    800280d2:	e36080e7          	jalr	-458(ra) # 80027f04 <sd_end_cmd>
		if (0x01 != result) {
    800280d6:	0f349563          	bne	s1,s3,800281c0 <sdcard_init+0x21a>
		sd_send_cmd(SD_ACMD41, 0x40000000, 0);
    800280da:	4601                	li	a2,0
    800280dc:	400005b7          	lui	a1,0x40000
    800280e0:	02900513          	li	a0,41
    800280e4:	00000097          	auipc	ra,0x0
    800280e8:	e68080e7          	jalr	-408(ra) # 80027f4c <sd_send_cmd>
		result = sd_get_response_R1();
    800280ec:	00000097          	auipc	ra,0x0
    800280f0:	db8080e7          	jalr	-584(ra) # 80027ea4 <sd_get_response_R1>
    800280f4:	84aa                	mv	s1,a0
		sd_end_cmd();
    800280f6:	00000097          	auipc	ra,0x0
    800280fa:	e0e080e7          	jalr	-498(ra) # 80027f04 <sd_end_cmd>
		if (0 == result) {
    800280fe:	f8c5                	bnez	s1,800280ae <sdcard_init+0x108>
    80028100:	10000913          	li	s2,256
    80028104:	0ff00493          	li	s1,255
	sd_read_data(frame, 4);
    80028108:	fa840993          	addi	s3,s0,-88
	while (timeout --) {
    8002810c:	397d                	addiw	s2,s2,-1
    8002810e:	10090463          	beqz	s2,80028216 <sdcard_init+0x270>
		sd_send_cmd(SD_CMD58, 0, 0);
    80028112:	4601                	li	a2,0
    80028114:	4581                	li	a1,0
    80028116:	03a00513          	li	a0,58
    8002811a:	00000097          	auipc	ra,0x0
    8002811e:	e32080e7          	jalr	-462(ra) # 80027f4c <sd_send_cmd>
		result = sd_get_response_R1();
    80028122:	00000097          	auipc	ra,0x0
    80028126:	d82080e7          	jalr	-638(ra) # 80027ea4 <sd_get_response_R1>
    8002812a:	84aa                	mv	s1,a0
	sd_read_data(frame, 4);
    8002812c:	4591                	li	a1,4
    8002812e:	854e                	mv	a0,s3
    80028130:	00000097          	auipc	ra,0x0
    80028134:	d2e080e7          	jalr	-722(ra) # 80027e5e <sd_read_data>
		sd_end_cmd();
    80028138:	00000097          	auipc	ra,0x0
    8002813c:	dcc080e7          	jalr	-564(ra) # 80027f04 <sd_end_cmd>
		if (0 == result) {
    80028140:	f4f1                	bnez	s1,8002810c <sdcard_init+0x166>
			if (ocr[0] & 0x40) {
    80028142:	fa844783          	lbu	a5,-88(s0)
    80028146:	0407f793          	andi	a5,a5,64
    8002814a:	ebcd                	bnez	a5,800281fc <sdcard_init+0x256>
				printf("SDSC detected, setting block size\n");
    8002814c:	00004517          	auipc	a0,0x4
    80028150:	f8450513          	addi	a0,a0,-124 # 8002c0d0 <fpioa+0xc8>
    80028154:	ffff8097          	auipc	ra,0xffff8
    80028158:	038080e7          	jalr	56(ra) # 8002018c <printf>
    8002815c:	0fe00913          	li	s2,254
					sd_send_cmd(SD_CMD16, BSIZE, 0);
    80028160:	4601                	li	a2,0
    80028162:	20000593          	li	a1,512
    80028166:	4541                	li	a0,16
    80028168:	00000097          	auipc	ra,0x0
    8002816c:	de4080e7          	jalr	-540(ra) # 80027f4c <sd_send_cmd>
					result = sd_get_response_R1();
    80028170:	00000097          	auipc	ra,0x0
    80028174:	d34080e7          	jalr	-716(ra) # 80027ea4 <sd_get_response_R1>
    80028178:	84aa                	mv	s1,a0
					sd_end_cmd();
    8002817a:	00000097          	auipc	ra,0x0
    8002817e:	d8a080e7          	jalr	-630(ra) # 80027f04 <sd_end_cmd>
					if (0 == result) break;
    80028182:	cccd                	beqz	s1,8002823c <sdcard_init+0x296>
				while (--timeout) {
    80028184:	397d                	addiw	s2,s2,-1
    80028186:	fc091de3          	bnez	s2,80028160 <sdcard_init+0x1ba>
					printf("check_OCR(): fail to set block size");
    8002818a:	00004517          	auipc	a0,0x4
    8002818e:	fa650513          	addi	a0,a0,-90 # 8002c130 <fpioa+0x128>
    80028192:	ffff8097          	auipc	ra,0xffff8
    80028196:	ffa080e7          	jalr	-6(ra) # 8002018c <printf>
					return 0xff;
    8002819a:	aa05                	j	800282ca <sdcard_init+0x324>
	printf("read_OCR() timeout!\n");
    8002819c:	00004517          	auipc	a0,0x4
    800281a0:	eb450513          	addi	a0,a0,-332 # 8002c050 <fpioa+0x48>
    800281a4:	ffff8097          	auipc	ra,0xffff8
    800281a8:	fe8080e7          	jalr	-24(ra) # 8002018c <printf>
	printf("result = %d\n", result);
    800281ac:	85a6                	mv	a1,s1
    800281ae:	00004517          	auipc	a0,0x4
    800281b2:	eba50513          	addi	a0,a0,-326 # 8002c068 <fpioa+0x60>
    800281b6:	ffff8097          	auipc	ra,0xffff8
    800281ba:	fd6080e7          	jalr	-42(ra) # 8002018c <printf>
	return 0xff;
    800281be:	a231                	j	800282ca <sdcard_init+0x324>
			printf("SD_CMD55 fail! result = %d\n", result);
    800281c0:	0004859b          	sext.w	a1,s1
    800281c4:	00004517          	auipc	a0,0x4
    800281c8:	eb450513          	addi	a0,a0,-332 # 8002c078 <fpioa+0x70>
    800281cc:	ffff8097          	auipc	ra,0xffff8
    800281d0:	fc0080e7          	jalr	-64(ra) # 8002018c <printf>
			return 0xff;
    800281d4:	a8dd                	j	800282ca <sdcard_init+0x324>
	printf("set_SDXC_capacity() timeout!\n");
    800281d6:	00004517          	auipc	a0,0x4
    800281da:	ec250513          	addi	a0,a0,-318 # 8002c098 <fpioa+0x90>
    800281de:	ffff8097          	auipc	ra,0xffff8
    800281e2:	fae080e7          	jalr	-82(ra) # 8002018c <printf>
	printf("result = %d\n", result);
    800281e6:	0004859b          	sext.w	a1,s1
    800281ea:	00004517          	auipc	a0,0x4
    800281ee:	e7e50513          	addi	a0,a0,-386 # 8002c068 <fpioa+0x60>
    800281f2:	ffff8097          	auipc	ra,0xffff8
    800281f6:	f9a080e7          	jalr	-102(ra) # 8002018c <printf>
	return 0xff;
    800281fa:	a8c1                	j	800282ca <sdcard_init+0x324>
				printf("SDHC/SDXC detected\n");
    800281fc:	00004517          	auipc	a0,0x4
    80028200:	ebc50513          	addi	a0,a0,-324 # 8002c0b8 <fpioa+0xb0>
    80028204:	ffff8097          	auipc	ra,0xffff8
    80028208:	f88080e7          	jalr	-120(ra) # 8002018c <printf>
				is_standard_sd = 0;
    8002820c:	0001e797          	auipc	a5,0x1e
    80028210:	aa07ae23          	sw	zero,-1348(a5) # 80045cc8 <is_standard_sd>
    80028214:	a80d                	j	80028246 <sdcard_init+0x2a0>
	printf("check_OCR() timeout!\n");
    80028216:	00004517          	auipc	a0,0x4
    8002821a:	ee250513          	addi	a0,a0,-286 # 8002c0f8 <fpioa+0xf0>
    8002821e:	ffff8097          	auipc	ra,0xffff8
    80028222:	f6e080e7          	jalr	-146(ra) # 8002018c <printf>
	printf("result = %d\n", result);
    80028226:	0004859b          	sext.w	a1,s1
    8002822a:	00004517          	auipc	a0,0x4
    8002822e:	e3e50513          	addi	a0,a0,-450 # 8002c068 <fpioa+0x60>
    80028232:	ffff8097          	auipc	ra,0xffff8
    80028236:	f5a080e7          	jalr	-166(ra) # 8002018c <printf>
	return 0xff;
    8002823a:	a841                	j	800282ca <sdcard_init+0x324>
				is_standard_sd = 1;
    8002823c:	4785                	li	a5,1
    8002823e:	0001e717          	auipc	a4,0x1e
    80028242:	a8f72523          	sw	a5,-1398(a4) # 80045cc8 <is_standard_sd>
	int result = sd_init();
	initsleeplock(&sdcard_lock, "sdcard");
    80028246:	00004597          	auipc	a1,0x4
    8002824a:	eca58593          	addi	a1,a1,-310 # 8002c110 <fpioa+0x108>
    8002824e:	0001e517          	auipc	a0,0x1e
    80028252:	a8250513          	addi	a0,a0,-1406 # 80045cd0 <sdcard_lock>
    80028256:	ffffb097          	auipc	ra,0xffffb
    8002825a:	3d0080e7          	jalr	976(ra) # 80023626 <initsleeplock>
		panic("sdcard_init failed");
	}
	#ifdef DEBUG
	printf("sdcard_init\n");
	#endif
}
    8002825e:	60e6                	ld	ra,88(sp)
    80028260:	6446                	ld	s0,80(sp)
    80028262:	64a6                	ld	s1,72(sp)
    80028264:	6906                	ld	s2,64(sp)
    80028266:	79e2                	ld	s3,56(sp)
    80028268:	7a42                	ld	s4,48(sp)
    8002826a:	7aa2                	ld	s5,40(sp)
    8002826c:	6125                	addi	sp,sp,96
    8002826e:	8082                	ret
	sd_send_cmd(SD_CMD8, 0x01aa, 0x87);
    80028270:	08700613          	li	a2,135
    80028274:	1aa00593          	li	a1,426
    80028278:	4521                	li	a0,8
    8002827a:	00000097          	auipc	ra,0x0
    8002827e:	cd2080e7          	jalr	-814(ra) # 80027f4c <sd_send_cmd>
	result = sd_get_response_R1();
    80028282:	00000097          	auipc	ra,0x0
    80028286:	c22080e7          	jalr	-990(ra) # 80027ea4 <sd_get_response_R1>
    8002828a:	84aa                	mv	s1,a0
	sd_read_data(frame, 4);
    8002828c:	4591                	li	a1,4
    8002828e:	fa840513          	addi	a0,s0,-88
    80028292:	00000097          	auipc	ra,0x0
    80028296:	bcc080e7          	jalr	-1076(ra) # 80027e5e <sd_read_data>
	sd_end_cmd();
    8002829a:	00000097          	auipc	ra,0x0
    8002829e:	c6a080e7          	jalr	-918(ra) # 80027f04 <sd_end_cmd>
	if (0x09 == result) {
    800282a2:	47a5                	li	a5,9
    800282a4:	d8f487e3          	beq	s1,a5,80028032 <sdcard_init+0x8c>
	else if (0x01 == result && 0x01 == (frame[2] & 0x0f) && 0xaa == frame[3]) {
    800282a8:	4785                	li	a5,1
    800282aa:	00f49863          	bne	s1,a5,800282ba <sdcard_init+0x314>
    800282ae:	faa44783          	lbu	a5,-86(s0)
    800282b2:	8bbd                	andi	a5,a5,15
    800282b4:	4705                	li	a4,1
    800282b6:	d8e787e3          	beq	a5,a4,80028044 <sdcard_init+0x9e>
	printf("verify_operation_condition() fail!\n");
    800282ba:	00004517          	auipc	a0,0x4
    800282be:	d6e50513          	addi	a0,a0,-658 # 8002c028 <fpioa+0x20>
    800282c2:	ffff8097          	auipc	ra,0xffff8
    800282c6:	eca080e7          	jalr	-310(ra) # 8002018c <printf>
	initsleeplock(&sdcard_lock, "sdcard");
    800282ca:	00004597          	auipc	a1,0x4
    800282ce:	e4658593          	addi	a1,a1,-442 # 8002c110 <fpioa+0x108>
    800282d2:	0001e517          	auipc	a0,0x1e
    800282d6:	9fe50513          	addi	a0,a0,-1538 # 80045cd0 <sdcard_lock>
    800282da:	ffffb097          	auipc	ra,0xffffb
    800282de:	34c080e7          	jalr	844(ra) # 80023626 <initsleeplock>
		panic("sdcard_init failed");
    800282e2:	00004517          	auipc	a0,0x4
    800282e6:	e3650513          	addi	a0,a0,-458 # 8002c118 <fpioa+0x110>
    800282ea:	ffff8097          	auipc	ra,0xffff8
    800282ee:	e58080e7          	jalr	-424(ra) # 80020142 <panic>

00000000800282f2 <sdcard_read_sector>:

void sdcard_read_sector(uint8 *buf, int sectorno) {
    800282f2:	7139                	addi	sp,sp,-64
    800282f4:	fc06                	sd	ra,56(sp)
    800282f6:	f822                	sd	s0,48(sp)
    800282f8:	f426                	sd	s1,40(sp)
    800282fa:	f04a                	sd	s2,32(sp)
    800282fc:	ec4e                	sd	s3,24(sp)
    800282fe:	e852                	sd	s4,16(sp)
    80028300:	0080                	addi	s0,sp,64
    80028302:	8a2a                	mv	s4,a0

	#ifdef DEBUG
	printf("sdcard_read_sector()\n");
	#endif

	if (is_standard_sd) {
    80028304:	0001e797          	auipc	a5,0x1e
    80028308:	9c47a783          	lw	a5,-1596(a5) # 80045cc8 <is_standard_sd>
		address = sectorno << 9;
	}
	else {
		address = sectorno;
    8002830c:	0005849b          	sext.w	s1,a1
	if (is_standard_sd) {
    80028310:	c399                	beqz	a5,80028316 <sdcard_read_sector+0x24>
		address = sectorno << 9;
    80028312:	0095949b          	slliw	s1,a1,0x9
	}

	// enter critical section!
	acquiresleep(&sdcard_lock);
    80028316:	0001e517          	auipc	a0,0x1e
    8002831a:	9ba50513          	addi	a0,a0,-1606 # 80045cd0 <sdcard_lock>
    8002831e:	ffffb097          	auipc	ra,0xffffb
    80028322:	342080e7          	jalr	834(ra) # 80023660 <acquiresleep>

	sd_send_cmd(SD_CMD17, address, 0);
    80028326:	4601                	li	a2,0
    80028328:	85a6                	mv	a1,s1
    8002832a:	4545                	li	a0,17
    8002832c:	00000097          	auipc	ra,0x0
    80028330:	c20080e7          	jalr	-992(ra) # 80027f4c <sd_send_cmd>
	result = sd_get_response_R1();
    80028334:	00000097          	auipc	ra,0x0
    80028338:	b70080e7          	jalr	-1168(ra) # 80027ea4 <sd_get_response_R1>
    8002833c:	fca407a3          	sb	a0,-49(s0)

	if (0 != result) {
    80028340:	010004b7          	lui	s1,0x1000
    80028344:	14f9                	addi	s1,s1,-2
		panic("sdcard: fail to read");
	}

	int timeout = 0xffffff;
	while (--timeout) {
		sd_read_data(&result, 1);
    80028346:	fcf40993          	addi	s3,s0,-49
		if (0xfe == result) break;
    8002834a:	0fe00913          	li	s2,254
	if (0 != result) {
    8002834e:	e50d                	bnez	a0,80028378 <sdcard_read_sector+0x86>
		sd_read_data(&result, 1);
    80028350:	4585                	li	a1,1
    80028352:	854e                	mv	a0,s3
    80028354:	00000097          	auipc	ra,0x0
    80028358:	b0a080e7          	jalr	-1270(ra) # 80027e5e <sd_read_data>
		if (0xfe == result) break;
    8002835c:	fcf44783          	lbu	a5,-49(s0)
    80028360:	03278c63          	beq	a5,s2,80028398 <sdcard_read_sector+0xa6>
	while (--timeout) {
    80028364:	34fd                	addiw	s1,s1,-1
    80028366:	f4ed                	bnez	s1,80028350 <sdcard_read_sector+0x5e>
	}
	if (0 == timeout) {
		panic("sdcard: timeout waiting for reading");
    80028368:	00004517          	auipc	a0,0x4
    8002836c:	e1850513          	addi	a0,a0,-488 # 8002c180 <fpioa+0x178>
    80028370:	ffff8097          	auipc	ra,0xffff8
    80028374:	dd2080e7          	jalr	-558(ra) # 80020142 <panic>
		releasesleep(&sdcard_lock);
    80028378:	0001e517          	auipc	a0,0x1e
    8002837c:	95850513          	addi	a0,a0,-1704 # 80045cd0 <sdcard_lock>
    80028380:	ffffb097          	auipc	ra,0xffffb
    80028384:	336080e7          	jalr	822(ra) # 800236b6 <releasesleep>
		panic("sdcard: fail to read");
    80028388:	00004517          	auipc	a0,0x4
    8002838c:	de050513          	addi	a0,a0,-544 # 8002c168 <fpioa+0x160>
    80028390:	ffff8097          	auipc	ra,0xffff8
    80028394:	db2080e7          	jalr	-590(ra) # 80020142 <panic>
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80028398:	4701                	li	a4,0
    8002839a:	46a1                	li	a3,8
    8002839c:	4601                	li	a2,0
    8002839e:	4581                	li	a1,0
    800283a0:	4501                	li	a0,0
    800283a2:	fffff097          	auipc	ra,0xfffff
    800283a6:	a9a080e7          	jalr	-1382(ra) # 80026e3c <spi_init>
	spi_receive_data_standard_dma(-1, DMAC_CHANNEL0, SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    800283aa:	20000893          	li	a7,512
    800283ae:	8852                	mv	a6,s4
    800283b0:	4781                	li	a5,0
    800283b2:	4701                	li	a4,0
    800283b4:	468d                	li	a3,3
    800283b6:	4601                	li	a2,0
    800283b8:	4581                	li	a1,0
    800283ba:	557d                	li	a0,-1
    800283bc:	fffff097          	auipc	ra,0xfffff
    800283c0:	2ba080e7          	jalr	698(ra) # 80027676 <spi_receive_data_standard_dma>
	}
	sd_read_data_dma(buf, BSIZE);
	sd_read_data(dummy_crc, 2);
    800283c4:	4589                	li	a1,2
    800283c6:	fc840513          	addi	a0,s0,-56
    800283ca:	00000097          	auipc	ra,0x0
    800283ce:	a94080e7          	jalr	-1388(ra) # 80027e5e <sd_read_data>

	sd_end_cmd();
    800283d2:	00000097          	auipc	ra,0x0
    800283d6:	b32080e7          	jalr	-1230(ra) # 80027f04 <sd_end_cmd>

	releasesleep(&sdcard_lock);
    800283da:	0001e517          	auipc	a0,0x1e
    800283de:	8f650513          	addi	a0,a0,-1802 # 80045cd0 <sdcard_lock>
    800283e2:	ffffb097          	auipc	ra,0xffffb
    800283e6:	2d4080e7          	jalr	724(ra) # 800236b6 <releasesleep>
	// leave critical section!
}
    800283ea:	70e2                	ld	ra,56(sp)
    800283ec:	7442                	ld	s0,48(sp)
    800283ee:	74a2                	ld	s1,40(sp)
    800283f0:	7902                	ld	s2,32(sp)
    800283f2:	69e2                	ld	s3,24(sp)
    800283f4:	6a42                	ld	s4,16(sp)
    800283f6:	6121                	addi	sp,sp,64
    800283f8:	8082                	ret

00000000800283fa <sdcard_write_sector>:

void sdcard_write_sector(uint8 *buf, int sectorno) {
    800283fa:	7139                	addi	sp,sp,-64
    800283fc:	fc06                	sd	ra,56(sp)
    800283fe:	f822                	sd	s0,48(sp)
    80028400:	f426                	sd	s1,40(sp)
    80028402:	f04a                	sd	s2,32(sp)
    80028404:	ec4e                	sd	s3,24(sp)
    80028406:	0080                	addi	s0,sp,64
    80028408:	84aa                	mv	s1,a0
	uint32 address;
	static uint8 const START_BLOCK_TOKEN = 0xfe;
	uint8 dummy_crc[2] = {0xff, 0xff};
    8002840a:	57fd                	li	a5,-1
    8002840c:	fcf41423          	sh	a5,-56(s0)

	#ifdef DEBUG
	printf("sdcard_write_sector()\n");
	#endif

	if (is_standard_sd) {
    80028410:	0001e797          	auipc	a5,0x1e
    80028414:	8b87a783          	lw	a5,-1864(a5) # 80045cc8 <is_standard_sd>
		address = sectorno << 9;
	}
	else {
		address = sectorno;
    80028418:	0005891b          	sext.w	s2,a1
	if (is_standard_sd) {
    8002841c:	c399                	beqz	a5,80028422 <sdcard_write_sector+0x28>
		address = sectorno << 9;
    8002841e:	0095991b          	slliw	s2,a1,0x9
	}

	// enter critical section!
	acquiresleep(&sdcard_lock);
    80028422:	0001e517          	auipc	a0,0x1e
    80028426:	8ae50513          	addi	a0,a0,-1874 # 80045cd0 <sdcard_lock>
    8002842a:	ffffb097          	auipc	ra,0xffffb
    8002842e:	236080e7          	jalr	566(ra) # 80023660 <acquiresleep>

	sd_send_cmd(SD_CMD24, address, 0);
    80028432:	4601                	li	a2,0
    80028434:	85ca                	mv	a1,s2
    80028436:	4561                	li	a0,24
    80028438:	00000097          	auipc	ra,0x0
    8002843c:	b14080e7          	jalr	-1260(ra) # 80027f4c <sd_send_cmd>
	if (0 != sd_get_response_R1()) {
    80028440:	00000097          	auipc	ra,0x0
    80028444:	a64080e7          	jalr	-1436(ra) # 80027ea4 <sd_get_response_R1>
    80028448:	e941                	bnez	a0,800284d8 <sdcard_write_sector+0xde>
		releasesleep(&sdcard_lock);
		panic("sdcard: fail to write");
	}

	// sending data to be written 
	sd_write_data(&START_BLOCK_TOKEN, 1);
    8002844a:	4585                	li	a1,1
    8002844c:	00004517          	auipc	a0,0x4
    80028450:	e0850513          	addi	a0,a0,-504 # 8002c254 <START_BLOCK_TOKEN.0>
    80028454:	00000097          	auipc	ra,0x0
    80028458:	9c4080e7          	jalr	-1596(ra) # 80027e18 <sd_write_data>
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    8002845c:	4701                	li	a4,0
    8002845e:	46a1                	li	a3,8
    80028460:	4601                	li	a2,0
    80028462:	4581                	li	a1,0
    80028464:	4501                	li	a0,0
    80028466:	fffff097          	auipc	ra,0xfffff
    8002846a:	9d6080e7          	jalr	-1578(ra) # 80026e3c <spi_init>
	spi_send_data_standard_dma(DMAC_CHANNEL0, SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    8002846e:	20000813          	li	a6,512
    80028472:	87a6                	mv	a5,s1
    80028474:	4701                	li	a4,0
    80028476:	4681                	li	a3,0
    80028478:	460d                	li	a2,3
    8002847a:	4581                	li	a1,0
    8002847c:	4501                	li	a0,0
    8002847e:	fffff097          	auipc	ra,0xfffff
    80028482:	3ba080e7          	jalr	954(ra) # 80027838 <spi_send_data_standard_dma>
	sd_write_data_dma(buf, BSIZE);
	sd_write_data(dummy_crc, 2);
    80028486:	4589                	li	a1,2
    80028488:	fc840513          	addi	a0,s0,-56
    8002848c:	00000097          	auipc	ra,0x0
    80028490:	98c080e7          	jalr	-1652(ra) # 80027e18 <sd_write_data>
    80028494:	6485                	lui	s1,0x1
    80028496:	14f9                	addi	s1,s1,-2

	// waiting for sdcard to finish programming 
	uint8 result;
	int timeout = 0xfff;
	while (--timeout) {
		sd_read_data(&result, 1);
    80028498:	fc740993          	addi	s3,s0,-57
		if (0x05 == (result & 0x1f)) {
    8002849c:	4915                	li	s2,5
		sd_read_data(&result, 1);
    8002849e:	4585                	li	a1,1
    800284a0:	854e                	mv	a0,s3
    800284a2:	00000097          	auipc	ra,0x0
    800284a6:	9bc080e7          	jalr	-1604(ra) # 80027e5e <sd_read_data>
		if (0x05 == (result & 0x1f)) {
    800284aa:	fc744783          	lbu	a5,-57(s0)
    800284ae:	8bfd                	andi	a5,a5,31
    800284b0:	05278463          	beq	a5,s2,800284f8 <sdcard_write_sector+0xfe>
	while (--timeout) {
    800284b4:	34fd                	addiw	s1,s1,-1
    800284b6:	f4e5                	bnez	s1,8002849e <sdcard_write_sector+0xa4>
			break;
		}
	}
	if (0 == timeout) {
		releasesleep(&sdcard_lock);
    800284b8:	0001e517          	auipc	a0,0x1e
    800284bc:	81850513          	addi	a0,a0,-2024 # 80045cd0 <sdcard_lock>
    800284c0:	ffffb097          	auipc	ra,0xffffb
    800284c4:	1f6080e7          	jalr	502(ra) # 800236b6 <releasesleep>
		panic("sdcard: invalid response token");
    800284c8:	00004517          	auipc	a0,0x4
    800284cc:	d6850513          	addi	a0,a0,-664 # 8002c230 <fpioa+0x228>
    800284d0:	ffff8097          	auipc	ra,0xffff8
    800284d4:	c72080e7          	jalr	-910(ra) # 80020142 <panic>
		releasesleep(&sdcard_lock);
    800284d8:	0001d517          	auipc	a0,0x1d
    800284dc:	7f850513          	addi	a0,a0,2040 # 80045cd0 <sdcard_lock>
    800284e0:	ffffb097          	auipc	ra,0xffffb
    800284e4:	1d6080e7          	jalr	470(ra) # 800236b6 <releasesleep>
		panic("sdcard: fail to write");
    800284e8:	00004517          	auipc	a0,0x4
    800284ec:	cc050513          	addi	a0,a0,-832 # 8002c1a8 <fpioa+0x1a0>
    800284f0:	ffff8097          	auipc	ra,0xffff8
    800284f4:	c52080e7          	jalr	-942(ra) # 80020142 <panic>
    800284f8:	010004b7          	lui	s1,0x1000
    800284fc:	14fd                	addi	s1,s1,-1
	}
	
	timeout = 0xffffff;
	while (--timeout) {
		sd_read_data(&result, 1);
    800284fe:	fc740913          	addi	s2,s0,-57
	while (--timeout) {
    80028502:	34fd                	addiw	s1,s1,-1
    80028504:	c4e1                	beqz	s1,800285cc <sdcard_write_sector+0x1d2>
		sd_read_data(&result, 1);
    80028506:	4585                	li	a1,1
    80028508:	854a                	mv	a0,s2
    8002850a:	00000097          	auipc	ra,0x0
    8002850e:	954080e7          	jalr	-1708(ra) # 80027e5e <sd_read_data>
		if (0 != result) break;
    80028512:	fc744783          	lbu	a5,-57(s0)
    80028516:	d7f5                	beqz	a5,80028502 <sdcard_write_sector+0x108>
	}
	if (0 == timeout) {
		releasesleep(&sdcard_lock);
		panic("sdcard: timeout waiting for response");
	}
	sd_end_cmd();
    80028518:	00000097          	auipc	ra,0x0
    8002851c:	9ec080e7          	jalr	-1556(ra) # 80027f04 <sd_end_cmd>

	// send SD_CMD13 to check if writing is correctly done 
	uint8 error_code = 0xff;
    80028520:	57fd                	li	a5,-1
    80028522:	fcf40323          	sb	a5,-58(s0)
	sd_send_cmd(SD_CMD13, 0, 0);
    80028526:	4601                	li	a2,0
    80028528:	4581                	li	a1,0
    8002852a:	4535                	li	a0,13
    8002852c:	00000097          	auipc	ra,0x0
    80028530:	a20080e7          	jalr	-1504(ra) # 80027f4c <sd_send_cmd>
	result = sd_get_response_R1();
    80028534:	00000097          	auipc	ra,0x0
    80028538:	970080e7          	jalr	-1680(ra) # 80027ea4 <sd_get_response_R1>
    8002853c:	fca403a3          	sb	a0,-57(s0)
	sd_read_data(&error_code, 1);
    80028540:	4585                	li	a1,1
    80028542:	fc640513          	addi	a0,s0,-58
    80028546:	00000097          	auipc	ra,0x0
    8002854a:	918080e7          	jalr	-1768(ra) # 80027e5e <sd_read_data>
	sd_end_cmd();
    8002854e:	00000097          	auipc	ra,0x0
    80028552:	9b6080e7          	jalr	-1610(ra) # 80027f04 <sd_end_cmd>
	if (0 != result || 0 != error_code) {
    80028556:	fc744783          	lbu	a5,-57(s0)
    8002855a:	fc644703          	lbu	a4,-58(s0)
    8002855e:	8fd9                	or	a5,a5,a4
    80028560:	0ff7f793          	andi	a5,a5,255
    80028564:	e385                	bnez	a5,80028584 <sdcard_write_sector+0x18a>
		printf("result: %x\n", result);
		printf("error_code: %x\n", error_code);
		panic("sdcard: an error occurs when writing");
	}

	releasesleep(&sdcard_lock);
    80028566:	0001d517          	auipc	a0,0x1d
    8002856a:	76a50513          	addi	a0,a0,1898 # 80045cd0 <sdcard_lock>
    8002856e:	ffffb097          	auipc	ra,0xffffb
    80028572:	148080e7          	jalr	328(ra) # 800236b6 <releasesleep>
	// leave critical section!
}
    80028576:	70e2                	ld	ra,56(sp)
    80028578:	7442                	ld	s0,48(sp)
    8002857a:	74a2                	ld	s1,40(sp)
    8002857c:	7902                	ld	s2,32(sp)
    8002857e:	69e2                	ld	s3,24(sp)
    80028580:	6121                	addi	sp,sp,64
    80028582:	8082                	ret
		releasesleep(&sdcard_lock);
    80028584:	0001d517          	auipc	a0,0x1d
    80028588:	74c50513          	addi	a0,a0,1868 # 80045cd0 <sdcard_lock>
    8002858c:	ffffb097          	auipc	ra,0xffffb
    80028590:	12a080e7          	jalr	298(ra) # 800236b6 <releasesleep>
		printf("result: %x\n", result);
    80028594:	fc744583          	lbu	a1,-57(s0)
    80028598:	00004517          	auipc	a0,0x4
    8002859c:	c2850513          	addi	a0,a0,-984 # 8002c1c0 <fpioa+0x1b8>
    800285a0:	ffff8097          	auipc	ra,0xffff8
    800285a4:	bec080e7          	jalr	-1044(ra) # 8002018c <printf>
		printf("error_code: %x\n", error_code);
    800285a8:	fc644583          	lbu	a1,-58(s0)
    800285ac:	00004517          	auipc	a0,0x4
    800285b0:	c2450513          	addi	a0,a0,-988 # 8002c1d0 <fpioa+0x1c8>
    800285b4:	ffff8097          	auipc	ra,0xffff8
    800285b8:	bd8080e7          	jalr	-1064(ra) # 8002018c <printf>
		panic("sdcard: an error occurs when writing");
    800285bc:	00004517          	auipc	a0,0x4
    800285c0:	c2450513          	addi	a0,a0,-988 # 8002c1e0 <fpioa+0x1d8>
    800285c4:	ffff8097          	auipc	ra,0xffff8
    800285c8:	b7e080e7          	jalr	-1154(ra) # 80020142 <panic>
		releasesleep(&sdcard_lock);
    800285cc:	0001d517          	auipc	a0,0x1d
    800285d0:	70450513          	addi	a0,a0,1796 # 80045cd0 <sdcard_lock>
    800285d4:	ffffb097          	auipc	ra,0xffffb
    800285d8:	0e2080e7          	jalr	226(ra) # 800236b6 <releasesleep>
		panic("sdcard: timeout waiting for response");
    800285dc:	00004517          	auipc	a0,0x4
    800285e0:	c2c50513          	addi	a0,a0,-980 # 8002c208 <fpioa+0x200>
    800285e4:	ffff8097          	auipc	ra,0xffff8
    800285e8:	b5e080e7          	jalr	-1186(ra) # 80020142 <panic>

00000000800285ec <test_sdcard>:

// A simple test for sdcard read/write test 
void test_sdcard(void) {
    800285ec:	d9010113          	addi	sp,sp,-624
    800285f0:	26113423          	sd	ra,616(sp)
    800285f4:	26813023          	sd	s0,608(sp)
    800285f8:	24913c23          	sd	s1,600(sp)
    800285fc:	25213823          	sd	s2,592(sp)
    80028600:	25313423          	sd	s3,584(sp)
    80028604:	25413023          	sd	s4,576(sp)
    80028608:	23513c23          	sd	s5,568(sp)
    8002860c:	23613823          	sd	s6,560(sp)
    80028610:	23713423          	sd	s7,552(sp)
    80028614:	23813023          	sd	s8,544(sp)
    80028618:	21913c23          	sd	s9,536(sp)
    8002861c:	21a13823          	sd	s10,528(sp)
    80028620:	21b13423          	sd	s11,520(sp)
    80028624:	1c80                	addi	s0,sp,624
	uint8 buf[BSIZE];

	for (int sec = 0; sec < 5; sec ++) {
    80028626:	4c01                	li	s8,0
    80028628:	f9040913          	addi	s2,s0,-112
		for (int i = 0; i < BSIZE; i ++) {
			buf[i] = 0xaa;		// data to be written 
    8002862c:	faa00b13          	li	s6,-86
		}

		sdcard_write_sector(buf, sec);
    80028630:	d9040c93          	addi	s9,s0,-624

		for (int i = 0; i < BSIZE; i ++) {
			buf[i] = 0xff;		// fill in junk
    80028634:	5afd                	li	s5,-1
		}

		sdcard_read_sector(buf, sec);
		for (int i = 0; i < BSIZE; i ++) {
    80028636:	4d01                	li	s10,0
			if (0 == i % 16) {
				printf("\n");
    80028638:	00003b97          	auipc	s7,0x3
    8002863c:	260b8b93          	addi	s7,s7,608 # 8002b898 <digits+0x610>
			}

			printf("%x ", buf[i]);
    80028640:	00004a17          	auipc	s4,0x4
    80028644:	c10a0a13          	addi	s4,s4,-1008 # 8002c250 <fpioa+0x248>
		for (int i = 0; i < BSIZE; i ++) {
    80028648:	20000993          	li	s3,512
    8002864c:	a835                	j	80028688 <test_sdcard+0x9c>
			printf("%x ", buf[i]);
    8002864e:	0004c583          	lbu	a1,0(s1) # 1000000 <_start-0x7f020000>
    80028652:	8552                	mv	a0,s4
    80028654:	ffff8097          	auipc	ra,0xffff8
    80028658:	b38080e7          	jalr	-1224(ra) # 8002018c <printf>
		for (int i = 0; i < BSIZE; i ++) {
    8002865c:	2d85                	addiw	s11,s11,1
    8002865e:	0485                	addi	s1,s1,1
    80028660:	013d8b63          	beq	s11,s3,80028676 <test_sdcard+0x8a>
			if (0 == i % 16) {
    80028664:	00fdf793          	andi	a5,s11,15
    80028668:	f3fd                	bnez	a5,8002864e <test_sdcard+0x62>
				printf("\n");
    8002866a:	855e                	mv	a0,s7
    8002866c:	ffff8097          	auipc	ra,0xffff8
    80028670:	b20080e7          	jalr	-1248(ra) # 8002018c <printf>
    80028674:	bfe9                	j	8002864e <test_sdcard+0x62>
		}
		printf("\n");
    80028676:	855e                	mv	a0,s7
    80028678:	ffff8097          	auipc	ra,0xffff8
    8002867c:	b14080e7          	jalr	-1260(ra) # 8002018c <printf>
	for (int sec = 0; sec < 5; sec ++) {
    80028680:	2c05                	addiw	s8,s8,1
    80028682:	4795                	li	a5,5
    80028684:	02fc0e63          	beq	s8,a5,800286c0 <test_sdcard+0xd4>
		for (int i = 0; i < BSIZE; i ++) {
    80028688:	d9040493          	addi	s1,s0,-624
void test_sdcard(void) {
    8002868c:	87a6                	mv	a5,s1
			buf[i] = 0xaa;		// data to be written 
    8002868e:	01678023          	sb	s6,0(a5)
		for (int i = 0; i < BSIZE; i ++) {
    80028692:	0785                	addi	a5,a5,1
    80028694:	ff279de3          	bne	a5,s2,8002868e <test_sdcard+0xa2>
		sdcard_write_sector(buf, sec);
    80028698:	85e2                	mv	a1,s8
    8002869a:	8566                	mv	a0,s9
    8002869c:	00000097          	auipc	ra,0x0
    800286a0:	d5e080e7          	jalr	-674(ra) # 800283fa <sdcard_write_sector>
    800286a4:	87a6                	mv	a5,s1
			buf[i] = 0xff;		// fill in junk
    800286a6:	01578023          	sb	s5,0(a5)
		for (int i = 0; i < BSIZE; i ++) {
    800286aa:	0785                	addi	a5,a5,1
    800286ac:	ff279de3          	bne	a5,s2,800286a6 <test_sdcard+0xba>
		sdcard_read_sector(buf, sec);
    800286b0:	85e2                	mv	a1,s8
    800286b2:	8566                	mv	a0,s9
    800286b4:	00000097          	auipc	ra,0x0
    800286b8:	c3e080e7          	jalr	-962(ra) # 800282f2 <sdcard_read_sector>
		for (int i = 0; i < BSIZE; i ++) {
    800286bc:	8dea                	mv	s11,s10
    800286be:	b75d                	j	80028664 <test_sdcard+0x78>
	}

	while (1) ;
    800286c0:	a001                	j	800286c0 <test_sdcard+0xd4>

00000000800286c2 <dmac_enable>:
{
    return dmac->channel[channel_num].axi_id;
}

static void dmac_enable(void)
{
    800286c2:	1141                	addi	sp,sp,-16
    800286c4:	e422                	sd	s0,8(sp)
    800286c6:	0800                	addi	s0,sp,16
    dmac_cfg_u_t dmac_cfg;

    dmac_cfg.data = readq(&dmac->cfg);
    800286c8:	3f500793          	li	a5,1013
    800286cc:	07f2                	slli	a5,a5,0x1c
    800286ce:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 1;
    dmac_cfg.cfg.int_en = 1;
    800286d0:	00376713          	ori	a4,a4,3
    writeq(dmac_cfg.data, &dmac->cfg);
    800286d4:	eb98                	sd	a4,16(a5)
}
    800286d6:	6422                	ld	s0,8(sp)
    800286d8:	0141                	addi	sp,sp,16
    800286da:	8082                	ret

00000000800286dc <dmac_read_id>:
{
    800286dc:	1141                	addi	sp,sp,-16
    800286de:	e422                	sd	s0,8(sp)
    800286e0:	0800                	addi	s0,sp,16
    return dmac->id;
    800286e2:	3f500793          	li	a5,1013
    800286e6:	07f2                	slli	a5,a5,0x1c
    800286e8:	6388                	ld	a0,0(a5)
}
    800286ea:	6422                	ld	s0,8(sp)
    800286ec:	0141                	addi	sp,sp,16
    800286ee:	8082                	ret

00000000800286f0 <dmac_read_version>:
{
    800286f0:	1141                	addi	sp,sp,-16
    800286f2:	e422                	sd	s0,8(sp)
    800286f4:	0800                	addi	s0,sp,16
    return dmac->compver;
    800286f6:	3f500793          	li	a5,1013
    800286fa:	07f2                	slli	a5,a5,0x1c
    800286fc:	6788                	ld	a0,8(a5)
}
    800286fe:	6422                	ld	s0,8(sp)
    80028700:	0141                	addi	sp,sp,16
    80028702:	8082                	ret

0000000080028704 <dmac_read_channel_id>:
{
    80028704:	1141                	addi	sp,sp,-16
    80028706:	e422                	sd	s0,8(sp)
    80028708:	0800                	addi	s0,sp,16
    return dmac->channel[channel_num].axi_id;
    8002870a:	1502                	slli	a0,a0,0x20
    8002870c:	9101                	srli	a0,a0,0x20
    8002870e:	00851793          	slli	a5,a0,0x8
    80028712:	3f500513          	li	a0,1013
    80028716:	0572                	slli	a0,a0,0x1c
    80028718:	953e                	add	a0,a0,a5
    8002871a:	15053503          	ld	a0,336(a0)
}
    8002871e:	6422                	ld	s0,8(sp)
    80028720:	0141                	addi	sp,sp,16
    80028722:	8082                	ret

0000000080028724 <dmac_disable>:

void dmac_disable(void)
{
    80028724:	1141                	addi	sp,sp,-16
    80028726:	e422                	sd	s0,8(sp)
    80028728:	0800                	addi	s0,sp,16
    dmac_cfg_u_t dmac_cfg;

    dmac_cfg.data = readq(&dmac->cfg);
    8002872a:	3f500793          	li	a5,1013
    8002872e:	07f2                	slli	a5,a5,0x1c
    80028730:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 0;
    dmac_cfg.cfg.int_en = 0;
    80028732:	9b71                	andi	a4,a4,-4
    writeq(dmac_cfg.data, &dmac->cfg);
    80028734:	eb98                	sd	a4,16(a5)
}
    80028736:	6422                	ld	s0,8(sp)
    80028738:	0141                	addi	sp,sp,16
    8002873a:	8082                	ret

000000008002873c <dmac_channel_enable>:

void dmac_channel_enable(dmac_channel_number_t channel_num)
{
    8002873c:	1141                	addi	sp,sp,-16
    8002873e:	e422                	sd	s0,8(sp)
    80028740:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;

    chen.data = readq(&dmac->chen);
    80028742:	3f500793          	li	a5,1013
    80028746:	07f2                	slli	a5,a5,0x1c
    80028748:	6f9c                	ld	a5,24(a5)

    switch(channel_num)
    8002874a:	4715                	li	a4,5
    8002874c:	00a76d63          	bltu	a4,a0,80028766 <dmac_channel_enable+0x2a>
    80028750:	050a                	slli	a0,a0,0x2
    80028752:	00004697          	auipc	a3,0x4
    80028756:	b0668693          	addi	a3,a3,-1274 # 8002c258 <START_BLOCK_TOKEN.0+0x4>
    8002875a:	9536                	add	a0,a0,a3
    8002875c:	4118                	lw	a4,0(a0)
    8002875e:	9736                	add	a4,a4,a3
    80028760:	8702                	jr	a4
    {
        case DMAC_CHANNEL0:
            chen.dmac_chen.ch1_en = 1;
            chen.dmac_chen.ch1_en_we = 1;
    80028762:	1017e793          	ori	a5,a5,257
            break;
        default:
            break;
    }

    writeq(chen.data, &dmac->chen);
    80028766:	3f500713          	li	a4,1013
    8002876a:	0772                	slli	a4,a4,0x1c
    8002876c:	ef1c                	sd	a5,24(a4)
}
    8002876e:	6422                	ld	s0,8(sp)
    80028770:	0141                	addi	sp,sp,16
    80028772:	8082                	ret
            chen.dmac_chen.ch2_en_we = 1;
    80028774:	2027e793          	ori	a5,a5,514
            break;
    80028778:	b7fd                	j	80028766 <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch3_en_we = 1;
    8002877a:	4047e793          	ori	a5,a5,1028
            break;
    8002877e:	b7e5                	j	80028766 <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch4_en = 1;
    80028780:	0087e793          	ori	a5,a5,8
            chen.dmac_chen.ch4_en_we = 1;
    80028784:	6705                	lui	a4,0x1
    80028786:	80070713          	addi	a4,a4,-2048 # 800 <_start-0x8001f800>
    8002878a:	8fd9                	or	a5,a5,a4
            break;
    8002878c:	bfe9                	j	80028766 <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch5_en = 1;
    8002878e:	0107e793          	ori	a5,a5,16
            chen.dmac_chen.ch5_en_we = 1;
    80028792:	6705                	lui	a4,0x1
    80028794:	8fd9                	or	a5,a5,a4
            break;
    80028796:	bfc1                	j	80028766 <dmac_channel_enable+0x2a>
            chen.dmac_chen.ch6_en = 1;
    80028798:	0207e793          	ori	a5,a5,32
            chen.dmac_chen.ch6_en_we = 1;
    8002879c:	6709                	lui	a4,0x2
    8002879e:	8fd9                	or	a5,a5,a4
            break;
    800287a0:	b7d9                	j	80028766 <dmac_channel_enable+0x2a>

00000000800287a2 <dmac_channel_disable>:

void dmac_channel_disable(dmac_channel_number_t channel_num)
{
    800287a2:	1141                	addi	sp,sp,-16
    800287a4:	e422                	sd	s0,8(sp)
    800287a6:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;

    chen.data = readq(&dmac->chen);
    800287a8:	3f500793          	li	a5,1013
    800287ac:	07f2                	slli	a5,a5,0x1c
    800287ae:	6f9c                	ld	a5,24(a5)

    switch(channel_num)
    800287b0:	4715                	li	a4,5
    800287b2:	00a76e63          	bltu	a4,a0,800287ce <dmac_channel_disable+0x2c>
    800287b6:	050a                	slli	a0,a0,0x2
    800287b8:	00004697          	auipc	a3,0x4
    800287bc:	ab868693          	addi	a3,a3,-1352 # 8002c270 <START_BLOCK_TOKEN.0+0x1c>
    800287c0:	9536                	add	a0,a0,a3
    800287c2:	4118                	lw	a4,0(a0)
    800287c4:	9736                	add	a4,a4,a3
    800287c6:	8702                	jr	a4
    {
        case DMAC_CHANNEL0:
            chen.dmac_chen.ch1_en = 0;
    800287c8:	9bf9                	andi	a5,a5,-2
            chen.dmac_chen.ch1_en_we = 1;
    800287ca:	1007e793          	ori	a5,a5,256
            break;
        default:
            break;
    }

    writeq(chen.data, &dmac->chen);
    800287ce:	3f500713          	li	a4,1013
    800287d2:	0772                	slli	a4,a4,0x1c
    800287d4:	ef1c                	sd	a5,24(a4)
}
    800287d6:	6422                	ld	s0,8(sp)
    800287d8:	0141                	addi	sp,sp,16
    800287da:	8082                	ret
            chen.dmac_chen.ch2_en = 0;
    800287dc:	9bf5                	andi	a5,a5,-3
            chen.dmac_chen.ch2_en_we = 1;
    800287de:	2007e793          	ori	a5,a5,512
            break;
    800287e2:	b7f5                	j	800287ce <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch3_en = 0;
    800287e4:	9bed                	andi	a5,a5,-5
            chen.dmac_chen.ch3_en_we = 1;
    800287e6:	4007e793          	ori	a5,a5,1024
            break;
    800287ea:	b7d5                	j	800287ce <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch4_en = 0;
    800287ec:	9bdd                	andi	a5,a5,-9
            chen.dmac_chen.ch4_en_we = 1;
    800287ee:	6705                	lui	a4,0x1
    800287f0:	80070713          	addi	a4,a4,-2048 # 800 <_start-0x8001f800>
    800287f4:	8fd9                	or	a5,a5,a4
            break;
    800287f6:	bfe1                	j	800287ce <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch5_en = 0;
    800287f8:	9bbd                	andi	a5,a5,-17
            chen.dmac_chen.ch5_en_we = 1;
    800287fa:	6705                	lui	a4,0x1
    800287fc:	8fd9                	or	a5,a5,a4
            break;
    800287fe:	bfc1                	j	800287ce <dmac_channel_disable+0x2c>
            chen.dmac_chen.ch6_en = 0;
    80028800:	fdf7f793          	andi	a5,a5,-33
            chen.dmac_chen.ch6_en_we = 1;
    80028804:	6709                	lui	a4,0x2
    80028806:	8fd9                	or	a5,a5,a4
            break;
    80028808:	b7d9                	j	800287ce <dmac_channel_disable+0x2c>

000000008002880a <dmac_enable_common_interrupt_status>:

void dmac_enable_common_interrupt_status(void)
{
    8002880a:	1141                	addi	sp,sp,-16
    8002880c:	e422                	sd	s0,8(sp)
    8002880e:	0800                	addi	s0,sp,16
    dmac_commonreg_intstatus_enable_u_t intstatus;

    intstatus.data = readq(&dmac->com_intstatus_en);
    80028810:	3f500793          	li	a5,1013
    80028814:	07f2                	slli	a5,a5,0x1c
    80028816:	63b8                	ld	a4,64(a5)
    intstatus.intstatus_enable.enable_slvif_dec_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_wr2ro_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_rd2wo_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_wronhold_err_intstat = 1;
    intstatus.intstatus_enable.enable_slvif_undefinedreg_dec_err_intstat = 1;
    80028818:	10f76713          	ori	a4,a4,271

    writeq(intstatus.data, &dmac->com_intstatus_en);
    8002881c:	e3b8                	sd	a4,64(a5)
}
    8002881e:	6422                	ld	s0,8(sp)
    80028820:	0141                	addi	sp,sp,16
    80028822:	8082                	ret

0000000080028824 <dmac_enable_common_interrupt_signal>:

void dmac_enable_common_interrupt_signal(void)
{
    80028824:	1141                	addi	sp,sp,-16
    80028826:	e422                	sd	s0,8(sp)
    80028828:	0800                	addi	s0,sp,16
    dmac_commonreg_intsignal_enable_u_t intsignal;

    intsignal.data = readq(&dmac->com_intsignal_en);
    8002882a:	3f500793          	li	a5,1013
    8002882e:	07f2                	slli	a5,a5,0x1c
    80028830:	67b8                	ld	a4,72(a5)
    intsignal.intsignal_enable.enable_slvif_dec_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_wr2ro_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_rd2wo_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_wronhold_err_intsignal = 1;
    intsignal.intsignal_enable.enable_slvif_undefinedreg_dec_err_intsignal = 1;
    80028832:	10f76713          	ori	a4,a4,271

    writeq(intsignal.data, &dmac->com_intsignal_en);
    80028836:	e7b8                	sd	a4,72(a5)
}
    80028838:	6422                	ld	s0,8(sp)
    8002883a:	0141                	addi	sp,sp,16
    8002883c:	8082                	ret

000000008002883e <dmac_disable_channel_interrupt>:
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    writeq(0x2, &dmac->channel[channel_num].intstatus_en);
}

void dmac_disable_channel_interrupt(dmac_channel_number_t channel_num)
{
    8002883e:	1141                	addi	sp,sp,-16
    80028840:	e422                	sd	s0,8(sp)
    80028842:	0800                	addi	s0,sp,16
    writeq(0, &dmac->channel[channel_num].intstatus_en);
    80028844:	1502                	slli	a0,a0,0x20
    80028846:	9101                	srli	a0,a0,0x20
    80028848:	00851793          	slli	a5,a0,0x8
    8002884c:	3f500513          	li	a0,1013
    80028850:	0572                	slli	a0,a0,0x1c
    80028852:	953e                	add	a0,a0,a5
    80028854:	18053023          	sd	zero,384(a0)
}
    80028858:	6422                	ld	s0,8(sp)
    8002885a:	0141                	addi	sp,sp,16
    8002885c:	8082                	ret

000000008002885e <dmac_set_channel_param>:
int dmac_set_channel_param(dmac_channel_number_t channel_num,
                           const void *src, void *dest, dmac_address_increment_t src_inc, dmac_address_increment_t dest_inc,
                           dmac_burst_trans_length_t dmac_burst_size,
                           dmac_transfer_width_t dmac_trans_width,
                           uint32 blockSize)
{
    8002885e:	1141                	addi	sp,sp,-16
    80028860:	e422                	sd	s0,8(sp)
    80028862:	0800                	addi	s0,sp,16
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028864:	80000337          	lui	t1,0x80000
    80028868:	932e                	add	t1,t1,a1
    8002886a:	00600e37          	lui	t3,0x600
    8002886e:	05c36763          	bltu	t1,t3,800288bc <dmac_set_channel_param+0x5e>
    80028872:	c0000337          	lui	t1,0xc0000
    80028876:	932e                	add	t1,t1,a1
    80028878:	00800e37          	lui	t3,0x800
    8002887c:	05c36063          	bltu	t1,t3,800288bc <dmac_set_channel_param+0x5e>
    80028880:	afbb0eb7          	lui	t4,0xafbb0
    80028884:	fc0e8e93          	addi	t4,t4,-64 # ffffffffafbaffc0 <kernel_end+0xffffffff2fb69fc0>
    80028888:	9eae                	add	t4,t4,a1
    8002888a:	001ebe93          	seqz	t4,t4
    dmac_ch_ctl_u_t ctl;
    dmac_ch_cfg_u_t cfg_u;

    int mem_type_src = is_memory((uintptr_t)src), mem_type_dest = is_memory((uintptr_t)dest);
    8002888e:	8f32                	mv	t5,a2
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    80028890:	80000337          	lui	t1,0x80000
    80028894:	9332                	add	t1,t1,a2
    80028896:	00600e37          	lui	t3,0x600
    8002889a:	4f85                	li	t6,1
    8002889c:	01c36663          	bltu	t1,t3,800288a8 <dmac_set_channel_param+0x4a>
    800288a0:	a03d                	j	800288ce <dmac_set_channel_param+0x70>
    800288a2:	8f9a                	mv	t6,t1
    800288a4:	a011                	j	800288a8 <dmac_set_channel_param+0x4a>
    800288a6:	4f85                	li	t6,1
    {
        flow_control = DMAC_PRF2PRF_DMA;
    } else if(mem_type_src == 1 && mem_type_dest == 0)
        flow_control = DMAC_MEM2PRF_DMA;
    else if(mem_type_src == 0 && mem_type_dest == 1)
        flow_control = DMAC_PRF2MEM_DMA;
    800288a8:	4609                	li	a2,2
    } else if(mem_type_src == 1 && mem_type_dest == 0)
    800288aa:	040e8563          	beqz	t4,800288f4 <dmac_set_channel_param+0x96>
    800288ae:	a019                	j	800288b4 <dmac_set_channel_param+0x56>
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    800288b0:	4f85                	li	t6,1
    800288b2:	4e85                	li	t4,1
    } else if(mem_type_src == 1 && mem_type_dest == 0)
    800288b4:	4605                	li	a2,1
    800288b6:	41f6063b          	subw	a2,a2,t6
    800288ba:	a82d                	j	800288f4 <dmac_set_channel_param+0x96>
    int mem_type_src = is_memory((uintptr_t)src), mem_type_dest = is_memory((uintptr_t)dest);
    800288bc:	8f32                	mv	t5,a2
    return ((address >= 0x80000000) && (address < 0x80000000 + mem_len)) || ((address >= 0x40000000) && (address < 0x40000000 + mem_no_cache_len)) || (address == 0x50450040);
    800288be:	80000337          	lui	t1,0x80000
    800288c2:	9332                	add	t1,t1,a2
    800288c4:	00600e37          	lui	t3,0x600
    800288c8:	4e85                	li	t4,1
    800288ca:	ffc363e3          	bltu	t1,t3,800288b0 <dmac_set_channel_param+0x52>
    800288ce:	c0000337          	lui	t1,0xc0000
    800288d2:	937a                	add	t1,t1,t5
    800288d4:	00800e37          	lui	t3,0x800
    800288d8:	fdc367e3          	bltu	t1,t3,800288a6 <dmac_set_channel_param+0x48>
    800288dc:	afbb0337          	lui	t1,0xafbb0
    800288e0:	fc030313          	addi	t1,t1,-64 # ffffffffafbaffc0 <kernel_end+0xffffffff2fb69fc0>
    800288e4:	961a                	add	a2,a2,t1
    800288e6:	00163313          	seqz	t1,a2
    if(mem_type_src == 0 && mem_type_dest == 0)
    800288ea:	01d36fb3          	or	t6,t1,t4
        flow_control = DMAC_PRF2PRF_DMA;
    800288ee:	460d                	li	a2,3
    if(mem_type_src == 0 && mem_type_dest == 0)
    800288f0:	fa0f99e3          	bnez	t6,800288a2 <dmac_set_channel_param+0x44>

    /**
     * cfg register must configure before ts_block and
     * sar dar register
     */
    cfg_u.data = readq(&dmac->channel[channel_num].cfg);
    800288f4:	02051e13          	slli	t3,a0,0x20
    800288f8:	020e5e13          	srli	t3,t3,0x20
    800288fc:	008e1313          	slli	t1,t3,0x8
    80028900:	3f500e13          	li	t3,1013
    80028904:	0e72                	slli	t3,t3,0x1c
    80028906:	9e1a                	add	t3,t3,t1
    80028908:	120e3303          	ld	t1,288(t3) # 800120 <_start-0x7f81fee0>

    cfg_u.ch_cfg.tt_fc = flow_control;
    8002890c:	8a1d                	andi	a2,a2,7
    8002890e:	1602                	slli	a2,a2,0x20
    80028910:	52e5                	li	t0,-7
    80028912:	1282                	slli	t0,t0,0x20
    80028914:	12fd                	addi	t0,t0,-1
    80028916:	00537333          	and	t1,t1,t0
    8002891a:	00c36333          	or	t1,t1,a2
    cfg_u.ch_cfg.hs_sel_src = mem_type_src ? DMAC_HS_SOFTWARE : DMAC_HS_HARDWARE;
    8002891e:	023e9293          	slli	t0,t4,0x23
    80028922:	5efd                	li	t4,-1
    80028924:	023e9613          	slli	a2,t4,0x23
    80028928:	167d                	addi	a2,a2,-1
    8002892a:	00c37633          	and	a2,t1,a2
    8002892e:	00566333          	or	t1,a2,t0
    cfg_u.ch_cfg.hs_sel_dst = mem_type_dest ? DMAC_HS_SOFTWARE : DMAC_HS_HARDWARE;
    80028932:	01f03fb3          	snez	t6,t6
    80028936:	1f92                	slli	t6,t6,0x24
    80028938:	024e9613          	slli	a2,t4,0x24
    8002893c:	167d                	addi	a2,a2,-1
    8002893e:	00c37633          	and	a2,t1,a2
    80028942:	01f66633          	or	a2,a2,t6
    cfg_u.ch_cfg.src_per = channel_num;
    80028946:	893d                	andi	a0,a0,15
    80028948:	02751f93          	slli	t6,a0,0x27
    8002894c:	5345                	li	t1,-15
    8002894e:	02731e93          	slli	t4,t1,0x27
    80028952:	1efd                	addi	t4,t4,-1
    80028954:	01d67633          	and	a2,a2,t4
    80028958:	01f66633          	or	a2,a2,t6
    cfg_u.ch_cfg.dst_per = channel_num;
    8002895c:	1532                	slli	a0,a0,0x2c
    8002895e:	1332                	slli	t1,t1,0x2c
    80028960:	137d                	addi	t1,t1,-1
    80028962:	00667633          	and	a2,a2,t1
    80028966:	8e49                	or	a2,a2,a0
    cfg_u.ch_cfg.src_multblk_type = 0;
    cfg_u.ch_cfg.dst_multblk_type = 0;
    80028968:	9a41                	andi	a2,a2,-16

    writeq(cfg_u.data, &dmac->channel[channel_num].cfg);
    8002896a:	12ce3023          	sd	a2,288(t3)

    dmac->channel[channel_num].sar = (uint64)src;
    8002896e:	10be3023          	sd	a1,256(t3)
    dmac->channel[channel_num].dar = (uint64)dest;
    80028972:	11ee3423          	sd	t5,264(t3)

    ctl.data = readq(&dmac->channel[channel_num].ctl);
    80028976:	118e3603          	ld	a2,280(t3)
    ctl.ch_ctl.sms = DMAC_MASTER1;
    ctl.ch_ctl.dms = DMAC_MASTER2;
    8002897a:	9a39                	andi	a2,a2,-18
    /* master select */
    ctl.ch_ctl.sinc = src_inc;
    8002897c:	8a85                	andi	a3,a3,1
    8002897e:	00469593          	slli	a1,a3,0x4
    80028982:	00466693          	ori	a3,a2,4
    80028986:	8ecd                	or	a3,a3,a1
    ctl.ch_ctl.dinc = dest_inc;
    80028988:	8b05                	andi	a4,a4,1
    8002898a:	00671613          	slli	a2,a4,0x6
    8002898e:	8be6f713          	andi	a4,a3,-1858
    /* address incrememt */
    ctl.ch_ctl.src_tr_width = dmac_trans_width;
    80028992:	00787813          	andi	a6,a6,7
    80028996:	00881693          	slli	a3,a6,0x8
    8002899a:	8f51                	or	a4,a4,a2
    8002899c:	8f55                	or	a4,a4,a3
    ctl.ch_ctl.dst_tr_width = dmac_trans_width;
    8002899e:	082e                	slli	a6,a6,0xb
    800289a0:	76f1                	lui	a3,0xffffc
    800289a2:	7ff68693          	addi	a3,a3,2047 # ffffffffffffc7ff <kernel_end+0xffffffff7ffb67ff>
    800289a6:	8f75                	and	a4,a4,a3
    800289a8:	01076733          	or	a4,a4,a6
    /* transfer width */
    ctl.ch_ctl.src_msize = dmac_burst_size;
    800289ac:	00f7f693          	andi	a3,a5,15
    800289b0:	00e69613          	slli	a2,a3,0xe
    800289b4:	fffc47b7          	lui	a5,0xfffc4
    800289b8:	17fd                	addi	a5,a5,-1
    800289ba:	8ff9                	and	a5,a5,a4
    800289bc:	8fd1                	or	a5,a5,a2
    ctl.ch_ctl.dst_msize = dmac_burst_size;
    800289be:	06ca                	slli	a3,a3,0x12
    800289c0:	ffc40737          	lui	a4,0xffc40
    800289c4:	177d                	addi	a4,a4,-1
    800289c6:	8ff9                	and	a5,a5,a4
    800289c8:	8fd5                	or	a5,a5,a3

    writeq(ctl.data, &dmac->channel[channel_num].ctl);
    800289ca:	10fe3c23          	sd	a5,280(t3)

    writeq(blockSize - 1, &dmac->channel[channel_num].block_ts);
    800289ce:	38fd                	addiw	a7,a7,-1
    800289d0:	1882                	slli	a7,a7,0x20
    800289d2:	0208d893          	srli	a7,a7,0x20
    800289d6:	111e3823          	sd	a7,272(t3)
    /*the number of (blcok_ts +1) data of width SRC_TR_WIDTF to be */
    /* transferred in a dma block transfer */
    return 0;
}
    800289da:	4501                	li	a0,0
    800289dc:	6422                	ld	s0,8(sp)
    800289de:	0141                	addi	sp,sp,16
    800289e0:	8082                	ret

00000000800289e2 <dmac_init>:

void dmac_init(void)
{
    800289e2:	1141                	addi	sp,sp,-16
    800289e4:	e406                	sd	ra,8(sp)
    800289e6:	e022                	sd	s0,0(sp)
    800289e8:	0800                	addi	s0,sp,16
    uint64 tmp;
    dmac_commonreg_intclear_u_t intclear;
    dmac_cfg_u_t dmac_cfg;
    dmac_reset_u_t dmac_reset;

    sysctl_clock_enable(SYSCTL_CLOCK_DMA);
    800289ea:	4529                	li	a0,10
    800289ec:	00000097          	auipc	ra,0x0
    800289f0:	220080e7          	jalr	544(ra) # 80028c0c <sysctl_clock_enable>
    // printf("[dmac_init] dma clk=%d\n", sysctl_clock_get_freq(SYSCTL_CLOCK_DMA));

    dmac_reset.data = readq(&dmac->reset);
    800289f4:	3f500793          	li	a5,1013
    800289f8:	07f2                	slli	a5,a5,0x1c
    800289fa:	6fb8                	ld	a4,88(a5)
    dmac_reset.reset.rst = 1;
    800289fc:	00176713          	ori	a4,a4,1
    writeq(dmac_reset.data, &dmac->reset);
    80028a00:	efb8                	sd	a4,88(a5)
    while(dmac_reset.reset.rst)
        dmac_reset.data = readq(&dmac->reset);
    80028a02:	873e                	mv	a4,a5
    80028a04:	6f3c                	ld	a5,88(a4)
    while(dmac_reset.reset.rst)
    80028a06:	8b85                	andi	a5,a5,1
    80028a08:	fff5                	bnez	a5,80028a04 <dmac_init+0x22>

    /*reset dmac */

    intclear.data = readq(&dmac->com_intclear);
    80028a0a:	3f500793          	li	a5,1013
    80028a0e:	07f2                	slli	a5,a5,0x1c
    80028a10:	7f98                	ld	a4,56(a5)
    intclear.com_intclear.clear_slvif_dec_err_intstat = 1;
    intclear.com_intclear.clear_slvif_wr2ro_err_intstat = 1;
    intclear.com_intclear.clear_slvif_rd2wo_err_intstat = 1;
    intclear.com_intclear.clear_slvif_wronhold_err_intstat = 1;
    intclear.com_intclear.clear_slvif_undefinedreg_dec_err_intstat = 1;
    80028a12:	10f76713          	ori	a4,a4,271
    writeq(intclear.data, &dmac->com_intclear);
    80028a16:	ff98                	sd	a4,56(a5)
    /* clear common register interrupt */

    dmac_cfg.data = readq(&dmac->cfg);
    80028a18:	6b98                	ld	a4,16(a5)
    dmac_cfg.cfg.dmac_en = 0;
    dmac_cfg.cfg.int_en = 0;
    80028a1a:	9b71                	andi	a4,a4,-4
    writeq(dmac_cfg.data, &dmac->cfg);
    80028a1c:	eb98                	sd	a4,16(a5)
    /* disable dmac and disable interrupt */

    while(readq(&dmac->cfg))
    80028a1e:	873e                	mv	a4,a5
    80028a20:	6b1c                	ld	a5,16(a4)
    80028a22:	fffd                	bnez	a5,80028a20 <dmac_init+0x3e>
        ;
    tmp = readq(&dmac->chen);
    80028a24:	3f500793          	li	a5,1013
    80028a28:	07f2                	slli	a5,a5,0x1c
    80028a2a:	6f98                	ld	a4,24(a5)
    tmp &= ~0xf;
    80028a2c:	9b41                	andi	a4,a4,-16
    writeq(tmp, &dmac->chen);
    80028a2e:	ef98                	sd	a4,24(a5)
    /* disable all channel before configure */
    dmac_enable();
    80028a30:	00000097          	auipc	ra,0x0
    80028a34:	c92080e7          	jalr	-878(ra) # 800286c2 <dmac_enable>
}
    80028a38:	60a2                	ld	ra,8(sp)
    80028a3a:	6402                	ld	s0,0(sp)
    80028a3c:	0141                	addi	sp,sp,16
    80028a3e:	8082                	ret

0000000080028a40 <dmac_is_done>:
    dmac_enable_channel_interrupt(channel_num);
    dmac_channel_enable(channel_num);
}

int dmac_is_done(dmac_channel_number_t channel_num)
{
    80028a40:	1141                	addi	sp,sp,-16
    80028a42:	e422                	sd	s0,8(sp)
    80028a44:	0800                	addi	s0,sp,16
    if(readq(&dmac->channel[channel_num].intstatus) & 0x2)
    80028a46:	1502                	slli	a0,a0,0x20
    80028a48:	9101                	srli	a0,a0,0x20
    80028a4a:	00851793          	slli	a5,a0,0x8
    80028a4e:	3f500513          	li	a0,1013
    80028a52:	0572                	slli	a0,a0,0x1c
    80028a54:	953e                	add	a0,a0,a5
    80028a56:	18853503          	ld	a0,392(a0)
    80028a5a:	8105                	srli	a0,a0,0x1
        return 1;
    else
        return 0;
}
    80028a5c:	8905                	andi	a0,a0,1
    80028a5e:	6422                	ld	s0,8(sp)
    80028a60:	0141                	addi	sp,sp,16
    80028a62:	8082                	ret

0000000080028a64 <dmac_is_idle>:
{
    dmac_wait_idle(channel_num);
}

int dmac_is_idle(dmac_channel_number_t channel_num)
{
    80028a64:	1141                	addi	sp,sp,-16
    80028a66:	e422                	sd	s0,8(sp)
    80028a68:	0800                	addi	s0,sp,16
    dmac_chen_u_t chen;
    chen.data = readq(&dmac->chen);
    80028a6a:	3f500713          	li	a4,1013
    80028a6e:	0772                	slli	a4,a4,0x1c
    80028a70:	6f1c                	ld	a5,24(a4)
    if((chen.data >> channel_num) & 0x1UL)
    80028a72:	00a7d533          	srl	a0,a5,a0
    80028a76:	00154513          	xori	a0,a0,1
        return 0;
    else
        return 1;
}
    80028a7a:	8905                	andi	a0,a0,1
    80028a7c:	6422                	ld	s0,8(sp)
    80028a7e:	0141                	addi	sp,sp,16
    80028a80:	8082                	ret

0000000080028a82 <dmac_wait_idle>:

static void *dmac_chan = (void *) DMAC_V;

void dmac_wait_idle(dmac_channel_number_t channel_num)
{
    80028a82:	1101                	addi	sp,sp,-32
    80028a84:	ec06                	sd	ra,24(sp)
    80028a86:	e822                	sd	s0,16(sp)
    80028a88:	e426                	sd	s1,8(sp)
    80028a8a:	e04a                	sd	s2,0(sp)
    80028a8c:	1000                	addi	s0,sp,32
    80028a8e:	84aa                	mv	s1,a0
    while(!dmac_is_idle(channel_num)) {
        acquire(&myproc()->lock);
        sleep(dmac_chan, &myproc()->lock);
    80028a90:	3f500913          	li	s2,1013
    80028a94:	0972                	slli	s2,s2,0x1c
    while(!dmac_is_idle(channel_num)) {
    80028a96:	a81d                	j	80028acc <dmac_wait_idle+0x4a>
        acquire(&myproc()->lock);
    80028a98:	ffff9097          	auipc	ra,0xffff9
    80028a9c:	03a080e7          	jalr	58(ra) # 80021ad2 <myproc>
    80028aa0:	ffff8097          	auipc	ra,0xffff8
    80028aa4:	c12080e7          	jalr	-1006(ra) # 800206b2 <acquire>
        sleep(dmac_chan, &myproc()->lock);
    80028aa8:	ffff9097          	auipc	ra,0xffff9
    80028aac:	02a080e7          	jalr	42(ra) # 80021ad2 <myproc>
    80028ab0:	85aa                	mv	a1,a0
    80028ab2:	854a                	mv	a0,s2
    80028ab4:	ffffa097          	auipc	ra,0xffffa
    80028ab8:	89c080e7          	jalr	-1892(ra) # 80022350 <sleep>
        release(&myproc()->lock);
    80028abc:	ffff9097          	auipc	ra,0xffff9
    80028ac0:	016080e7          	jalr	22(ra) # 80021ad2 <myproc>
    80028ac4:	ffff8097          	auipc	ra,0xffff8
    80028ac8:	c42080e7          	jalr	-958(ra) # 80020706 <release>
    while(!dmac_is_idle(channel_num)) {
    80028acc:	8526                	mv	a0,s1
    80028ace:	00000097          	auipc	ra,0x0
    80028ad2:	f96080e7          	jalr	-106(ra) # 80028a64 <dmac_is_idle>
    80028ad6:	d169                	beqz	a0,80028a98 <dmac_wait_idle+0x16>
    }
}
    80028ad8:	60e2                	ld	ra,24(sp)
    80028ada:	6442                	ld	s0,16(sp)
    80028adc:	64a2                	ld	s1,8(sp)
    80028ade:	6902                	ld	s2,0(sp)
    80028ae0:	6105                	addi	sp,sp,32
    80028ae2:	8082                	ret

0000000080028ae4 <dmac_set_single_mode>:
{
    80028ae4:	711d                	addi	sp,sp,-96
    80028ae6:	ec86                	sd	ra,88(sp)
    80028ae8:	e8a2                	sd	s0,80(sp)
    80028aea:	e4a6                	sd	s1,72(sp)
    80028aec:	e0ca                	sd	s2,64(sp)
    80028aee:	fc4e                	sd	s3,56(sp)
    80028af0:	f852                	sd	s4,48(sp)
    80028af2:	f456                	sd	s5,40(sp)
    80028af4:	f05a                	sd	s6,32(sp)
    80028af6:	ec5e                	sd	s7,24(sp)
    80028af8:	e862                	sd	s8,16(sp)
    80028afa:	e466                	sd	s9,8(sp)
    80028afc:	e06a                	sd	s10,0(sp)
    80028afe:	1080                	addi	s0,sp,96
    80028b00:	892a                	mv	s2,a0
    80028b02:	8a2e                	mv	s4,a1
    80028b04:	8ab2                	mv	s5,a2
    80028b06:	8b36                	mv	s6,a3
    80028b08:	8bba                	mv	s7,a4
    80028b0a:	8c3e                	mv	s8,a5
    80028b0c:	8cc2                	mv	s9,a6
    80028b0e:	8d46                	mv	s10,a7
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028b10:	02051493          	slli	s1,a0,0x20
    80028b14:	9081                	srli	s1,s1,0x20
    80028b16:	00849793          	slli	a5,s1,0x8
    80028b1a:	3f500493          	li	s1,1013
    80028b1e:	04f2                	slli	s1,s1,0x1c
    80028b20:	94be                	add	s1,s1,a5
    80028b22:	59fd                	li	s3,-1
    80028b24:	0209d993          	srli	s3,s3,0x20
    80028b28:	1934bc23          	sd	s3,408(s1)
    dmac_channel_disable(channel_num);
    80028b2c:	00000097          	auipc	ra,0x0
    80028b30:	c76080e7          	jalr	-906(ra) # 800287a2 <dmac_channel_disable>
    dmac_wait_idle(channel_num);
    80028b34:	854a                	mv	a0,s2
    80028b36:	00000097          	auipc	ra,0x0
    80028b3a:	f4c080e7          	jalr	-180(ra) # 80028a82 <dmac_wait_idle>
    dmac_set_channel_param(channel_num, src, dest, src_inc, dest_inc,
    80028b3e:	000d089b          	sext.w	a7,s10
    80028b42:	8866                	mv	a6,s9
    80028b44:	87e2                	mv	a5,s8
    80028b46:	875e                	mv	a4,s7
    80028b48:	86da                	mv	a3,s6
    80028b4a:	8656                	mv	a2,s5
    80028b4c:	85d2                	mv	a1,s4
    80028b4e:	854a                	mv	a0,s2
    80028b50:	00000097          	auipc	ra,0x0
    80028b54:	d0e080e7          	jalr	-754(ra) # 8002885e <dmac_set_channel_param>
    dmac_enable();
    80028b58:	00000097          	auipc	ra,0x0
    80028b5c:	b6a080e7          	jalr	-1174(ra) # 800286c2 <dmac_enable>
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028b60:	1934bc23          	sd	s3,408(s1)
    writeq(0x2, &dmac->channel[channel_num].intstatus_en);
    80028b64:	4789                	li	a5,2
    80028b66:	18f4b023          	sd	a5,384(s1)
    dmac_channel_enable(channel_num);
    80028b6a:	854a                	mv	a0,s2
    80028b6c:	00000097          	auipc	ra,0x0
    80028b70:	bd0080e7          	jalr	-1072(ra) # 8002873c <dmac_channel_enable>
}
    80028b74:	60e6                	ld	ra,88(sp)
    80028b76:	6446                	ld	s0,80(sp)
    80028b78:	64a6                	ld	s1,72(sp)
    80028b7a:	6906                	ld	s2,64(sp)
    80028b7c:	79e2                	ld	s3,56(sp)
    80028b7e:	7a42                	ld	s4,48(sp)
    80028b80:	7aa2                	ld	s5,40(sp)
    80028b82:	7b02                	ld	s6,32(sp)
    80028b84:	6be2                	ld	s7,24(sp)
    80028b86:	6c42                	ld	s8,16(sp)
    80028b88:	6ca2                	ld	s9,8(sp)
    80028b8a:	6d02                	ld	s10,0(sp)
    80028b8c:	6125                	addi	sp,sp,96
    80028b8e:	8082                	ret

0000000080028b90 <dmac_wait_done>:
{
    80028b90:	1141                	addi	sp,sp,-16
    80028b92:	e406                	sd	ra,8(sp)
    80028b94:	e022                	sd	s0,0(sp)
    80028b96:	0800                	addi	s0,sp,16
    dmac_wait_idle(channel_num);
    80028b98:	00000097          	auipc	ra,0x0
    80028b9c:	eea080e7          	jalr	-278(ra) # 80028a82 <dmac_wait_idle>
}
    80028ba0:	60a2                	ld	ra,8(sp)
    80028ba2:	6402                	ld	s0,0(sp)
    80028ba4:	0141                	addi	sp,sp,16
    80028ba6:	8082                	ret

0000000080028ba8 <dmac_intr>:

void dmac_intr(dmac_channel_number_t channel_num)
{
    80028ba8:	1141                	addi	sp,sp,-16
    80028baa:	e406                	sd	ra,8(sp)
    80028bac:	e022                	sd	s0,0(sp)
    80028bae:	0800                	addi	s0,sp,16
    80028bb0:	87aa                	mv	a5,a0
    writeq(0xffffffff, &dmac->channel[channel_num].intclear);
    80028bb2:	3f500513          	li	a0,1013
    80028bb6:	0572                	slli	a0,a0,0x1c
    80028bb8:	1782                	slli	a5,a5,0x20
    80028bba:	9381                	srli	a5,a5,0x20
    80028bbc:	07a2                	slli	a5,a5,0x8
    80028bbe:	97aa                	add	a5,a5,a0
    80028bc0:	577d                	li	a4,-1
    80028bc2:	9301                	srli	a4,a4,0x20
    80028bc4:	18e7bc23          	sd	a4,408(a5) # fffffffffffc4198 <kernel_end+0xffffffff7ff7e198>
    dmac_chanel_interrupt_clear(channel_num);
    wakeup(dmac_chan);
    80028bc8:	ffffa097          	auipc	ra,0xffffa
    80028bcc:	904080e7          	jalr	-1788(ra) # 800224cc <wakeup>
    80028bd0:	60a2                	ld	ra,8(sp)
    80028bd2:	6402                	ld	s0,0(sp)
    80028bd4:	0141                	addi	sp,sp,16
    80028bd6:	8082                	ret

0000000080028bd8 <sysctl_get_git_id>:
};

volatile sysctl_t *const sysctl = (volatile sysctl_t *)SYSCTL_V;

uint32 sysctl_get_git_id(void)
{
    80028bd8:	1141                	addi	sp,sp,-16
    80028bda:	e422                	sd	s0,8(sp)
    80028bdc:	0800                	addi	s0,sp,16
    return sysctl->git_id.git_id;
    80028bde:	000fd7b7          	lui	a5,0xfd
    80028be2:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028be6:	07ca                	slli	a5,a5,0x12
    80028be8:	4388                	lw	a0,0(a5)
}
    80028bea:	2501                	sext.w	a0,a0
    80028bec:	6422                	ld	s0,8(sp)
    80028bee:	0141                	addi	sp,sp,16
    80028bf0:	8082                	ret

0000000080028bf2 <sysctl_get_freq>:

uint32 sysctl_get_freq(void)
{
    80028bf2:	1141                	addi	sp,sp,-16
    80028bf4:	e422                	sd	s0,8(sp)
    80028bf6:	0800                	addi	s0,sp,16
    return sysctl->clk_freq.clk_freq;
    80028bf8:	000fd7b7          	lui	a5,0xfd
    80028bfc:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028c00:	07ca                	slli	a5,a5,0x12
    80028c02:	43c8                	lw	a0,4(a5)
}
    80028c04:	2501                	sext.w	a0,a0
    80028c06:	6422                	ld	s0,8(sp)
    80028c08:	0141                	addi	sp,sp,16
    80028c0a:	8082                	ret

0000000080028c0c <sysctl_clock_enable>:

    return 0;
}

int sysctl_clock_enable(sysctl_clock_t clock)
{
    80028c0c:	1141                	addi	sp,sp,-16
    80028c0e:	e422                	sd	s0,8(sp)
    80028c10:	0800                	addi	s0,sp,16
    if(clock >= SYSCTL_CLOCK_MAX)
    80028c12:	02a00793          	li	a5,42
    80028c16:	3ea7e363          	bltu	a5,a0,80028ffc <sysctl_clock_enable+0x3f0>
        switch(clock)
    80028c1a:	ff25079b          	addiw	a5,a0,-14
    80028c1e:	0007869b          	sext.w	a3,a5
    80028c22:	475d                	li	a4,23
    80028c24:	02d76663          	bltu	a4,a3,80028c50 <sysctl_clock_enable+0x44>
    80028c28:	1782                	slli	a5,a5,0x20
    80028c2a:	9381                	srli	a5,a5,0x20
    80028c2c:	078a                	slli	a5,a5,0x2
    80028c2e:	00003717          	auipc	a4,0x3
    80028c32:	66270713          	addi	a4,a4,1634 # 8002c290 <dmac+0x8>
    80028c36:	97ba                	add	a5,a5,a4
    80028c38:	439c                	lw	a5,0(a5)
    80028c3a:	97ba                	add	a5,a5,a4
    80028c3c:	8782                	jr	a5
                sysctl->clk_en_cent.apb0_clk_en = en;
    80028c3e:	000fd7b7          	lui	a5,0xfd
    80028c42:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028c46:	07ca                	slli	a5,a5,0x12
    80028c48:	5798                	lw	a4,40(a5)
    80028c4a:	00876713          	ori	a4,a4,8
    80028c4e:	d798                	sw	a4,40(a5)
    switch(clock)
    80028c50:	02500793          	li	a5,37
    80028c54:	3aa7e663          	bltu	a5,a0,80029000 <sysctl_clock_enable+0x3f4>
    80028c58:	050a                	slli	a0,a0,0x2
    80028c5a:	00003717          	auipc	a4,0x3
    80028c5e:	69670713          	addi	a4,a4,1686 # 8002c2f0 <dmac+0x68>
    80028c62:	953a                	add	a0,a0,a4
    80028c64:	411c                	lw	a5,0(a0)
    80028c66:	97ba                	add	a5,a5,a4
    80028c68:	8782                	jr	a5
                sysctl->clk_en_cent.apb1_clk_en = en;
    80028c6a:	000fd7b7          	lui	a5,0xfd
    80028c6e:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028c72:	07ca                	slli	a5,a5,0x12
    80028c74:	5798                	lw	a4,40(a5)
    80028c76:	01076713          	ori	a4,a4,16
    80028c7a:	d798                	sw	a4,40(a5)
                break;
    80028c7c:	bfd1                	j	80028c50 <sysctl_clock_enable+0x44>
                sysctl->clk_en_cent.apb2_clk_en = en;
    80028c7e:	000fd7b7          	lui	a5,0xfd
    80028c82:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028c86:	07ca                	slli	a5,a5,0x12
    80028c88:	5798                	lw	a4,40(a5)
    80028c8a:	02076713          	ori	a4,a4,32
    80028c8e:	d798                	sw	a4,40(a5)
                break;
    80028c90:	b7c1                	j	80028c50 <sysctl_clock_enable+0x44>
            sysctl->pll0.pll_out_en0 = en;
    80028c92:	000fd7b7          	lui	a5,0xfd
    80028c96:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028c9a:	07ca                	slli	a5,a5,0x12
    80028c9c:	4798                	lw	a4,8(a5)
    80028c9e:	020006b7          	lui	a3,0x2000
    80028ca2:	8f55                	or	a4,a4,a3
    80028ca4:	c798                	sw	a4,8(a5)
        return -1;
    sysctl_clock_bus_en(clock, 1);
    sysctl_clock_device_en(clock, 1);
    return 0;
    80028ca6:	4501                	li	a0,0
}
    80028ca8:	6422                	ld	s0,8(sp)
    80028caa:	0141                	addi	sp,sp,16
    80028cac:	8082                	ret
            sysctl->pll1.pll_out_en1 = en;
    80028cae:	000fd7b7          	lui	a5,0xfd
    80028cb2:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028cb6:	07ca                	slli	a5,a5,0x12
    80028cb8:	47d8                	lw	a4,12(a5)
    80028cba:	020006b7          	lui	a3,0x2000
    80028cbe:	8f55                	or	a4,a4,a3
    80028cc0:	c7d8                	sw	a4,12(a5)
    return 0;
    80028cc2:	4501                	li	a0,0
            break;
    80028cc4:	b7d5                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->pll2.pll_out_en2 = en;
    80028cc6:	000fd7b7          	lui	a5,0xfd
    80028cca:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028cce:	07ca                	slli	a5,a5,0x12
    80028cd0:	4b98                	lw	a4,16(a5)
    80028cd2:	020006b7          	lui	a3,0x2000
    80028cd6:	8f55                	or	a4,a4,a3
    80028cd8:	cb98                	sw	a4,16(a5)
    return 0;
    80028cda:	4501                	li	a0,0
            break;
    80028cdc:	b7f1                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.cpu_clk_en = en;
    80028cde:	000fd7b7          	lui	a5,0xfd
    80028ce2:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028ce6:	07ca                	slli	a5,a5,0x12
    80028ce8:	5798                	lw	a4,40(a5)
    80028cea:	00176713          	ori	a4,a4,1
    80028cee:	d798                	sw	a4,40(a5)
    return 0;
    80028cf0:	4501                	li	a0,0
            break;
    80028cf2:	bf5d                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.sram0_clk_en = en;
    80028cf4:	000fd7b7          	lui	a5,0xfd
    80028cf8:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028cfc:	07ca                	slli	a5,a5,0x12
    80028cfe:	5798                	lw	a4,40(a5)
    80028d00:	00276713          	ori	a4,a4,2
    80028d04:	d798                	sw	a4,40(a5)
    return 0;
    80028d06:	4501                	li	a0,0
            break;
    80028d08:	b745                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.sram1_clk_en = en;
    80028d0a:	000fd7b7          	lui	a5,0xfd
    80028d0e:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028d12:	07ca                	slli	a5,a5,0x12
    80028d14:	5798                	lw	a4,40(a5)
    80028d16:	00476713          	ori	a4,a4,4
    80028d1a:	d798                	sw	a4,40(a5)
    return 0;
    80028d1c:	4501                	li	a0,0
            break;
    80028d1e:	b769                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb0_clk_en = en;
    80028d20:	000fd7b7          	lui	a5,0xfd
    80028d24:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028d28:	07ca                	slli	a5,a5,0x12
    80028d2a:	5798                	lw	a4,40(a5)
    80028d2c:	00876713          	ori	a4,a4,8
    80028d30:	d798                	sw	a4,40(a5)
    return 0;
    80028d32:	4501                	li	a0,0
            break;
    80028d34:	bf95                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb1_clk_en = en;
    80028d36:	000fd7b7          	lui	a5,0xfd
    80028d3a:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028d3e:	07ca                	slli	a5,a5,0x12
    80028d40:	5798                	lw	a4,40(a5)
    80028d42:	01076713          	ori	a4,a4,16
    80028d46:	d798                	sw	a4,40(a5)
    return 0;
    80028d48:	4501                	li	a0,0
            break;
    80028d4a:	bfb9                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_cent.apb2_clk_en = en;
    80028d4c:	000fd7b7          	lui	a5,0xfd
    80028d50:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028d54:	07ca                	slli	a5,a5,0x12
    80028d56:	5798                	lw	a4,40(a5)
    80028d58:	02076713          	ori	a4,a4,32
    80028d5c:	d798                	sw	a4,40(a5)
    return 0;
    80028d5e:	4501                	li	a0,0
            break;
    80028d60:	b7a1                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.rom_clk_en = en;
    80028d62:	000fd7b7          	lui	a5,0xfd
    80028d66:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028d6a:	07ca                	slli	a5,a5,0x12
    80028d6c:	57d8                	lw	a4,44(a5)
    80028d6e:	00176713          	ori	a4,a4,1
    80028d72:	d7d8                	sw	a4,44(a5)
    return 0;
    80028d74:	4501                	li	a0,0
            break;
    80028d76:	bf0d                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.dma_clk_en = en;
    80028d78:	000fd7b7          	lui	a5,0xfd
    80028d7c:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028d80:	07ca                	slli	a5,a5,0x12
    80028d82:	57d8                	lw	a4,44(a5)
    80028d84:	00276713          	ori	a4,a4,2
    80028d88:	d7d8                	sw	a4,44(a5)
    return 0;
    80028d8a:	4501                	li	a0,0
            break;
    80028d8c:	bf31                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.ai_clk_en = en;
    80028d8e:	000fd7b7          	lui	a5,0xfd
    80028d92:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028d96:	07ca                	slli	a5,a5,0x12
    80028d98:	57d8                	lw	a4,44(a5)
    80028d9a:	00476713          	ori	a4,a4,4
    80028d9e:	d7d8                	sw	a4,44(a5)
    return 0;
    80028da0:	4501                	li	a0,0
            break;
    80028da2:	b719                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.dvp_clk_en = en;
    80028da4:	000fd7b7          	lui	a5,0xfd
    80028da8:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028dac:	07ca                	slli	a5,a5,0x12
    80028dae:	57d8                	lw	a4,44(a5)
    80028db0:	00876713          	ori	a4,a4,8
    80028db4:	d7d8                	sw	a4,44(a5)
    return 0;
    80028db6:	4501                	li	a0,0
            break;
    80028db8:	bdc5                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.fft_clk_en = en;
    80028dba:	000fd7b7          	lui	a5,0xfd
    80028dbe:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028dc2:	07ca                	slli	a5,a5,0x12
    80028dc4:	57d8                	lw	a4,44(a5)
    80028dc6:	01076713          	ori	a4,a4,16
    80028dca:	d7d8                	sw	a4,44(a5)
    return 0;
    80028dcc:	4501                	li	a0,0
            break;
    80028dce:	bde9                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi3_clk_en = en;
    80028dd0:	000fd7b7          	lui	a5,0xfd
    80028dd4:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028dd8:	07ca                	slli	a5,a5,0x12
    80028dda:	57d8                	lw	a4,44(a5)
    80028ddc:	20076713          	ori	a4,a4,512
    80028de0:	d7d8                	sw	a4,44(a5)
    return 0;
    80028de2:	4501                	li	a0,0
            break;
    80028de4:	b5d1                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.gpio_clk_en = en;
    80028de6:	000fd7b7          	lui	a5,0xfd
    80028dea:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028dee:	07ca                	slli	a5,a5,0x12
    80028df0:	57d8                	lw	a4,44(a5)
    80028df2:	02076713          	ori	a4,a4,32
    80028df6:	d7d8                	sw	a4,44(a5)
    return 0;
    80028df8:	4501                	li	a0,0
            break;
    80028dfa:	b57d                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi2_clk_en = en;
    80028dfc:	000fd7b7          	lui	a5,0xfd
    80028e00:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028e04:	07ca                	slli	a5,a5,0x12
    80028e06:	57d8                	lw	a4,44(a5)
    80028e08:	10076713          	ori	a4,a4,256
    80028e0c:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e0e:	4501                	li	a0,0
            break;
    80028e10:	bd61                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s0_clk_en = en;
    80028e12:	000fd7b7          	lui	a5,0xfd
    80028e16:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028e1a:	07ca                	slli	a5,a5,0x12
    80028e1c:	57d8                	lw	a4,44(a5)
    80028e1e:	40076713          	ori	a4,a4,1024
    80028e22:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e24:	4501                	li	a0,0
            break;
    80028e26:	b549                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s1_clk_en = en;
    80028e28:	000fd7b7          	lui	a5,0xfd
    80028e2c:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028e30:	07ca                	slli	a5,a5,0x12
    80028e32:	57d8                	lw	a4,44(a5)
    80028e34:	6685                	lui	a3,0x1
    80028e36:	80068693          	addi	a3,a3,-2048 # 800 <_start-0x8001f800>
    80028e3a:	8f55                	or	a4,a4,a3
    80028e3c:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e3e:	4501                	li	a0,0
            break;
    80028e40:	b5a5                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2s2_clk_en = en;
    80028e42:	000fd7b7          	lui	a5,0xfd
    80028e46:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028e4a:	07ca                	slli	a5,a5,0x12
    80028e4c:	57d8                	lw	a4,44(a5)
    80028e4e:	6685                	lui	a3,0x1
    80028e50:	8f55                	or	a4,a4,a3
    80028e52:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e54:	4501                	li	a0,0
            break;
    80028e56:	bd89                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c0_clk_en = en;
    80028e58:	000fd7b7          	lui	a5,0xfd
    80028e5c:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028e60:	07ca                	slli	a5,a5,0x12
    80028e62:	57d8                	lw	a4,44(a5)
    80028e64:	6689                	lui	a3,0x2
    80028e66:	8f55                	or	a4,a4,a3
    80028e68:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e6a:	4501                	li	a0,0
            break;
    80028e6c:	bd35                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c1_clk_en = en;
    80028e6e:	000fd7b7          	lui	a5,0xfd
    80028e72:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028e76:	07ca                	slli	a5,a5,0x12
    80028e78:	57d8                	lw	a4,44(a5)
    80028e7a:	6691                	lui	a3,0x4
    80028e7c:	8f55                	or	a4,a4,a3
    80028e7e:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e80:	4501                	li	a0,0
            break;
    80028e82:	b51d                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.i2c2_clk_en = en;
    80028e84:	000fd7b7          	lui	a5,0xfd
    80028e88:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028e8c:	07ca                	slli	a5,a5,0x12
    80028e8e:	57d8                	lw	a4,44(a5)
    80028e90:	66a1                	lui	a3,0x8
    80028e92:	8f55                	or	a4,a4,a3
    80028e94:	d7d8                	sw	a4,44(a5)
    return 0;
    80028e96:	4501                	li	a0,0
            break;
    80028e98:	bd01                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart1_clk_en = en;
    80028e9a:	000fd7b7          	lui	a5,0xfd
    80028e9e:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028ea2:	07ca                	slli	a5,a5,0x12
    80028ea4:	57d8                	lw	a4,44(a5)
    80028ea6:	66c1                	lui	a3,0x10
    80028ea8:	8f55                	or	a4,a4,a3
    80028eaa:	d7d8                	sw	a4,44(a5)
    return 0;
    80028eac:	4501                	li	a0,0
            break;
    80028eae:	bbed                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart2_clk_en = en;
    80028eb0:	000fd7b7          	lui	a5,0xfd
    80028eb4:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028eb8:	07ca                	slli	a5,a5,0x12
    80028eba:	57d8                	lw	a4,44(a5)
    80028ebc:	000206b7          	lui	a3,0x20
    80028ec0:	8f55                	or	a4,a4,a3
    80028ec2:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ec4:	4501                	li	a0,0
            break;
    80028ec6:	b3cd                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.uart3_clk_en = en;
    80028ec8:	000fd7b7          	lui	a5,0xfd
    80028ecc:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028ed0:	07ca                	slli	a5,a5,0x12
    80028ed2:	57d8                	lw	a4,44(a5)
    80028ed4:	000406b7          	lui	a3,0x40
    80028ed8:	8f55                	or	a4,a4,a3
    80028eda:	d7d8                	sw	a4,44(a5)
    return 0;
    80028edc:	4501                	li	a0,0
            break;
    80028ede:	b3e9                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.fpioa_clk_en = en;
    80028ee0:	000fd7b7          	lui	a5,0xfd
    80028ee4:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028ee8:	07ca                	slli	a5,a5,0x12
    80028eea:	57d8                	lw	a4,44(a5)
    80028eec:	001006b7          	lui	a3,0x100
    80028ef0:	8f55                	or	a4,a4,a3
    80028ef2:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ef4:	4501                	li	a0,0
            break;
    80028ef6:	bb4d                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer0_clk_en = en;
    80028ef8:	000fd7b7          	lui	a5,0xfd
    80028efc:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028f00:	07ca                	slli	a5,a5,0x12
    80028f02:	57d8                	lw	a4,44(a5)
    80028f04:	002006b7          	lui	a3,0x200
    80028f08:	8f55                	or	a4,a4,a3
    80028f0a:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f0c:	4501                	li	a0,0
            break;
    80028f0e:	bb69                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer1_clk_en = en;
    80028f10:	000fd7b7          	lui	a5,0xfd
    80028f14:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028f18:	07ca                	slli	a5,a5,0x12
    80028f1a:	57d8                	lw	a4,44(a5)
    80028f1c:	004006b7          	lui	a3,0x400
    80028f20:	8f55                	or	a4,a4,a3
    80028f22:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f24:	4501                	li	a0,0
            break;
    80028f26:	b349                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.timer2_clk_en = en;
    80028f28:	000fd7b7          	lui	a5,0xfd
    80028f2c:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028f30:	07ca                	slli	a5,a5,0x12
    80028f32:	57d8                	lw	a4,44(a5)
    80028f34:	008006b7          	lui	a3,0x800
    80028f38:	8f55                	or	a4,a4,a3
    80028f3a:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f3c:	4501                	li	a0,0
            break;
    80028f3e:	b3ad                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.sha_clk_en = en;
    80028f40:	000fd7b7          	lui	a5,0xfd
    80028f44:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028f48:	07ca                	slli	a5,a5,0x12
    80028f4a:	57d8                	lw	a4,44(a5)
    80028f4c:	040006b7          	lui	a3,0x4000
    80028f50:	8f55                	or	a4,a4,a3
    80028f52:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f54:	4501                	li	a0,0
            break;
    80028f56:	bb89                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.aes_clk_en = en;
    80028f58:	000fd7b7          	lui	a5,0xfd
    80028f5c:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028f60:	07ca                	slli	a5,a5,0x12
    80028f62:	57d8                	lw	a4,44(a5)
    80028f64:	000806b7          	lui	a3,0x80
    80028f68:	8f55                	or	a4,a4,a3
    80028f6a:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f6c:	4501                	li	a0,0
            break;
    80028f6e:	bb2d                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.wdt0_clk_en = en;
    80028f70:	000fd7b7          	lui	a5,0xfd
    80028f74:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028f78:	07ca                	slli	a5,a5,0x12
    80028f7a:	57d8                	lw	a4,44(a5)
    80028f7c:	010006b7          	lui	a3,0x1000
    80028f80:	8f55                	or	a4,a4,a3
    80028f82:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f84:	4501                	li	a0,0
            break;
    80028f86:	b30d                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.wdt1_clk_en = en;
    80028f88:	000fd7b7          	lui	a5,0xfd
    80028f8c:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028f90:	07ca                	slli	a5,a5,0x12
    80028f92:	57d8                	lw	a4,44(a5)
    80028f94:	020006b7          	lui	a3,0x2000
    80028f98:	8f55                	or	a4,a4,a3
    80028f9a:	d7d8                	sw	a4,44(a5)
    return 0;
    80028f9c:	4501                	li	a0,0
            break;
    80028f9e:	b329                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.otp_clk_en = en;
    80028fa0:	000fd7b7          	lui	a5,0xfd
    80028fa4:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028fa8:	07ca                	slli	a5,a5,0x12
    80028faa:	57d8                	lw	a4,44(a5)
    80028fac:	080006b7          	lui	a3,0x8000
    80028fb0:	8f55                	or	a4,a4,a3
    80028fb2:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fb4:	4501                	li	a0,0
            break;
    80028fb6:	b9cd                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.rtc_clk_en = en;
    80028fb8:	000fd7b7          	lui	a5,0xfd
    80028fbc:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028fc0:	07ca                	slli	a5,a5,0x12
    80028fc2:	57d8                	lw	a4,44(a5)
    80028fc4:	200006b7          	lui	a3,0x20000
    80028fc8:	8f55                	or	a4,a4,a3
    80028fca:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fcc:	4501                	li	a0,0
            break;
    80028fce:	b9e9                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi0_clk_en = en;
    80028fd0:	000fd7b7          	lui	a5,0xfd
    80028fd4:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028fd8:	07ca                	slli	a5,a5,0x12
    80028fda:	57d8                	lw	a4,44(a5)
    80028fdc:	04076713          	ori	a4,a4,64
    80028fe0:	d7d8                	sw	a4,44(a5)
    return 0;
    80028fe2:	4501                	li	a0,0
            break;
    80028fe4:	b1d1                	j	80028ca8 <sysctl_clock_enable+0x9c>
            sysctl->clk_en_peri.spi1_clk_en = en;
    80028fe6:	000fd7b7          	lui	a5,0xfd
    80028fea:	41178793          	addi	a5,a5,1041 # fd411 <_start-0x7ff22bef>
    80028fee:	07ca                	slli	a5,a5,0x12
    80028ff0:	57d8                	lw	a4,44(a5)
    80028ff2:	08076713          	ori	a4,a4,128
    80028ff6:	d7d8                	sw	a4,44(a5)
    return 0;
    80028ff8:	4501                	li	a0,0
            break;
    80028ffa:	b17d                	j	80028ca8 <sysctl_clock_enable+0x9c>
        return -1;
    80028ffc:	557d                	li	a0,-1
    80028ffe:	b16d                	j	80028ca8 <sysctl_clock_enable+0x9c>
    return 0;
    80029000:	4501                	li	a0,0
    80029002:	b15d                	j	80028ca8 <sysctl_clock_enable+0x9c>

0000000080029004 <sysctl_dma_select>:

int sysctl_dma_select(sysctl_dma_channel_t channel, sysctl_dma_select_t select)
{
    80029004:	1141                	addi	sp,sp,-16
    80029006:	e422                	sd	s0,8(sp)
    80029008:	0800                	addi	s0,sp,16
    sysctl_dma_sel0_t dma_sel0;
    sysctl_dma_sel1_t dma_sel1;

    /* Read register from bus */
    dma_sel0 = sysctl->dma_sel0;
    8002900a:	000fd637          	lui	a2,0xfd
    8002900e:	41160613          	addi	a2,a2,1041 # fd411 <_start-0x7ff22bef>
    80029012:	064a                	slli	a2,a2,0x12
    80029014:	5274                	lw	a3,100(a2)
    dma_sel1 = sysctl->dma_sel1;
    80029016:	5630                	lw	a2,104(a2)
    switch(channel)
    80029018:	4e95                	li	t4,5
    8002901a:	0caee063          	bltu	t4,a0,800290da <sysctl_dma_select+0xd6>
    8002901e:	03f6f793          	andi	a5,a3,63
    80029022:	0066d71b          	srliw	a4,a3,0x6
    80029026:	03f77713          	andi	a4,a4,63
    8002902a:	00c6d81b          	srliw	a6,a3,0xc
    8002902e:	03f87313          	andi	t1,a6,63
    80029032:	0126d89b          	srliw	a7,a3,0x12
    80029036:	03f8f893          	andi	a7,a7,63
    8002903a:	0186d81b          	srliw	a6,a3,0x18
    8002903e:	03f87813          	andi	a6,a6,63
    80029042:	03f67e13          	andi	t3,a2,63
    80029046:	050a                	slli	a0,a0,0x2
    80029048:	00003e97          	auipc	t4,0x3
    8002904c:	340e8e93          	addi	t4,t4,832 # 8002c388 <dmac+0x100>
    80029050:	9576                	add	a0,a0,t4
    80029052:	4108                	lw	a0,0(a0)
    80029054:	9576                	add	a0,a0,t4
    80029056:	8502                	jr	a0
    {
        case SYSCTL_DMA_CHANNEL_0:
            dma_sel0.dma_sel0 = select;
    80029058:	03f5f793          	andi	a5,a1,63
        default:
            return -1;
    }

    /* Write register back to bus */
    sysctl->dma_sel0 = dma_sel0;
    8002905c:	fc06f693          	andi	a3,a3,-64
    80029060:	8edd                	or	a3,a3,a5
    80029062:	0067179b          	slliw	a5,a4,0x6
    80029066:	777d                	lui	a4,0xfffff
    80029068:	03f70713          	addi	a4,a4,63 # fffffffffffff03f <kernel_end+0xffffffff7ffb903f>
    8002906c:	8f75                	and	a4,a4,a3
    8002906e:	8f5d                	or	a4,a4,a5
    80029070:	00c3179b          	slliw	a5,t1,0xc
    80029074:	fffc16b7          	lui	a3,0xfffc1
    80029078:	16fd                	addi	a3,a3,-1
    8002907a:	8f75                	and	a4,a4,a3
    8002907c:	8f5d                	or	a4,a4,a5
    8002907e:	0128989b          	slliw	a7,a7,0x12
    80029082:	ff0407b7          	lui	a5,0xff040
    80029086:	17fd                	addi	a5,a5,-1
    80029088:	8ff9                	and	a5,a5,a4
    8002908a:	0117e7b3          	or	a5,a5,a7
    8002908e:	0188181b          	slliw	a6,a6,0x18
    80029092:	c1000737          	lui	a4,0xc1000
    80029096:	177d                	addi	a4,a4,-1
    80029098:	8ff9                	and	a5,a5,a4
    8002909a:	0107e7b3          	or	a5,a5,a6
    8002909e:	000fd737          	lui	a4,0xfd
    800290a2:	41170713          	addi	a4,a4,1041 # fd411 <_start-0x7ff22bef>
    800290a6:	074a                	slli	a4,a4,0x12
    800290a8:	d37c                	sw	a5,100(a4)
    sysctl->dma_sel1 = dma_sel1;
    800290aa:	fc067613          	andi	a2,a2,-64
    800290ae:	00ce6633          	or	a2,t3,a2
    800290b2:	d730                	sw	a2,104(a4)

    return 0;
    800290b4:	4501                	li	a0,0
}
    800290b6:	6422                	ld	s0,8(sp)
    800290b8:	0141                	addi	sp,sp,16
    800290ba:	8082                	ret
            dma_sel0.dma_sel1 = select;
    800290bc:	03f5f713          	andi	a4,a1,63
            break;
    800290c0:	bf71                	j	8002905c <sysctl_dma_select+0x58>
            dma_sel0.dma_sel2 = select;
    800290c2:	03f5f313          	andi	t1,a1,63
            break;
    800290c6:	bf59                	j	8002905c <sysctl_dma_select+0x58>
            dma_sel0.dma_sel3 = select;
    800290c8:	03f5f893          	andi	a7,a1,63
            break;
    800290cc:	bf41                	j	8002905c <sysctl_dma_select+0x58>
            dma_sel0.dma_sel4 = select;
    800290ce:	03f5f813          	andi	a6,a1,63
            break;
    800290d2:	b769                	j	8002905c <sysctl_dma_select+0x58>
            dma_sel1.dma_sel5 = select;
    800290d4:	03f5fe13          	andi	t3,a1,63
            break;
    800290d8:	b751                	j	8002905c <sysctl_dma_select+0x58>
    dma_sel1 = sysctl->dma_sel1;
    800290da:	557d                	li	a0,-1
    800290dc:	bfe9                	j	800290b6 <sysctl_dma_select+0xb2>
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
