
target/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080020000 <_start>:
    80020000:	00150293          	addi	t0,a0,1
    80020004:	02ba                	slli	t0,t0,0xe
    80020006:	0000c117          	auipc	sp,0xc
    8002000a:	ffa10113          	addi	sp,sp,-6 # 8002c000 <boot_stack>
    8002000e:	9116                	add	sp,sp,t0
    80020010:	0bd000ef          	jal	ra,800208cc <main>

0000000080020014 <loop>:
    80020014:	a001                	j	80020014 <loop>

0000000080020016 <printint>:
    }
}

static void
printint(int xx, int base, int sign)
{
    80020016:	1101                	addi	sp,sp,-32
    80020018:	ec22                	sd	s0,24(sp)
    8002001a:	1000                	addi	s0,sp,32
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    8002001c:	c219                	beqz	a2,80020022 <printint+0xc>
    8002001e:	00054d63          	bltz	a0,80020038 <printint+0x22>
    x = -xx;
  else
    x = xx;
    80020022:	2501                	sext.w	a0,a0
    80020024:	4881                	li	a7,0
    80020026:	fe040713          	addi	a4,s0,-32

  i = 0;
    8002002a:	4601                	li	a2,0
  do {
    buf[i++] = digits[x % base];
    8002002c:	2581                	sext.w	a1,a1
    8002002e:	00009817          	auipc	a6,0x9
    80020032:	fd280813          	addi	a6,a6,-46 # 80029000 <etext>
    80020036:	a039                	j	80020044 <printint+0x2e>
    x = -xx;
    80020038:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    8002003c:	4885                	li	a7,1
    x = -xx;
    8002003e:	b7e5                	j	80020026 <printint+0x10>
  } while((x /= base) != 0);
    80020040:	853e                	mv	a0,a5
    buf[i++] = digits[x % base];
    80020042:	8636                	mv	a2,a3
    80020044:	0016069b          	addiw	a3,a2,1
    80020048:	02b577bb          	remuw	a5,a0,a1
    8002004c:	1782                	slli	a5,a5,0x20
    8002004e:	9381                	srli	a5,a5,0x20
    80020050:	97c2                	add	a5,a5,a6
    80020052:	0007c783          	lbu	a5,0(a5)
    80020056:	00f70023          	sb	a5,0(a4)
    8002005a:	0705                	addi	a4,a4,1
  } while((x /= base) != 0);
    8002005c:	02b557bb          	divuw	a5,a0,a1
    80020060:	feb570e3          	bgeu	a0,a1,80020040 <printint+0x2a>

  if(sign)
    80020064:	00088b63          	beqz	a7,8002007a <printint+0x64>
    buf[i++] = '-';
    80020068:	ff040793          	addi	a5,s0,-16
    8002006c:	96be                	add	a3,a3,a5
    8002006e:	02d00793          	li	a5,45
    80020072:	fef68823          	sb	a5,-16(a3)
    80020076:	0026069b          	addiw	a3,a2,2

  while(--i >= 0)
    8002007a:	02d05763          	blez	a3,800200a8 <printint+0x92>
    8002007e:	fe040793          	addi	a5,s0,-32
    80020082:	97b6                	add	a5,a5,a3
    80020084:	fdf40713          	addi	a4,s0,-33
    80020088:	9736                	add	a4,a4,a3
    8002008a:	36fd                	addiw	a3,a3,-1
    8002008c:	1682                	slli	a3,a3,0x20
    8002008e:	9281                	srli	a3,a3,0x20
    80020090:	8f15                	sub	a4,a4,a3
#define SBI_CALL_4(which, arg0, arg1, arg2, arg3) \
		SBI_CALL(which, arg0, arg1, arg2, arg3)

static inline void sbi_console_putchar(int ch)
{
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
    80020092:	fff7c503          	lbu	a0,-1(a5)
    80020096:	4581                	li	a1,0
    80020098:	4601                	li	a2,0
    8002009a:	4681                	li	a3,0
    8002009c:	4885                	li	a7,1
    8002009e:	00000073          	ecall
    800200a2:	17fd                	addi	a5,a5,-1
    800200a4:	fee797e3          	bne	a5,a4,80020092 <printint+0x7c>
    sbi_console_putchar(buf[i]);
}
    800200a8:	6462                	ld	s0,24(sp)
    800200aa:	6105                	addi	sp,sp,32
    800200ac:	8082                	ret

00000000800200ae <printstring>:
void printstring(const char* s) {
    800200ae:	1141                	addi	sp,sp,-16
    800200b0:	e422                	sd	s0,8(sp)
    800200b2:	0800                	addi	s0,sp,16
    800200b4:	87aa                	mv	a5,a0
    while (*s)
    800200b6:	00054503          	lbu	a0,0(a0)
    800200ba:	c919                	beqz	a0,800200d0 <printstring+0x22>
        sbi_console_putchar(*s++);
    800200bc:	0785                	addi	a5,a5,1
    800200be:	4581                	li	a1,0
    800200c0:	4601                	li	a2,0
    800200c2:	4681                	li	a3,0
    800200c4:	4885                	li	a7,1
    800200c6:	00000073          	ecall
    while (*s)
    800200ca:	0007c503          	lbu	a0,0(a5)
    800200ce:	f57d                	bnez	a0,800200bc <printstring+0xe>
}
    800200d0:	6422                	ld	s0,8(sp)
    800200d2:	0141                	addi	sp,sp,16
    800200d4:	8082                	ret

00000000800200d6 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    800200d6:	1101                	addi	sp,sp,-32
    800200d8:	ec06                	sd	ra,24(sp)
    800200da:	e822                	sd	s0,16(sp)
    800200dc:	e426                	sd	s1,8(sp)
    800200de:	1000                	addi	s0,sp,32
    800200e0:	84aa                	mv	s1,a0
  printf("panic: ");
    800200e2:	00009517          	auipc	a0,0x9
    800200e6:	f3650513          	addi	a0,a0,-202 # 80029018 <etext+0x18>
    800200ea:	00000097          	auipc	ra,0x0
    800200ee:	02e080e7          	jalr	46(ra) # 80020118 <printf>
  printf(s);
    800200f2:	8526                	mv	a0,s1
    800200f4:	00000097          	auipc	ra,0x0
    800200f8:	024080e7          	jalr	36(ra) # 80020118 <printf>
  printf("\n");
    800200fc:	0000a517          	auipc	a0,0xa
    80020100:	8fc50513          	addi	a0,a0,-1796 # 800299f8 <syscalls+0x4a8>
    80020104:	00000097          	auipc	ra,0x0
    80020108:	014080e7          	jalr	20(ra) # 80020118 <printf>
  panicked = 1; // freeze uart output from other CPUs
    8002010c:	4785                	li	a5,1
    8002010e:	00014717          	auipc	a4,0x14
    80020112:	f0f72923          	sw	a5,-238(a4) # 80034020 <panicked>
  for(;;)
    ;
    80020116:	a001                	j	80020116 <panic+0x40>

0000000080020118 <printf>:
{
    80020118:	7171                	addi	sp,sp,-176
    8002011a:	f486                	sd	ra,104(sp)
    8002011c:	f0a2                	sd	s0,96(sp)
    8002011e:	eca6                	sd	s1,88(sp)
    80020120:	e8ca                	sd	s2,80(sp)
    80020122:	e4ce                	sd	s3,72(sp)
    80020124:	e0d2                	sd	s4,64(sp)
    80020126:	fc56                	sd	s5,56(sp)
    80020128:	f85a                	sd	s6,48(sp)
    8002012a:	f45e                	sd	s7,40(sp)
    8002012c:	f062                	sd	s8,32(sp)
    8002012e:	ec66                	sd	s9,24(sp)
    80020130:	e86a                	sd	s10,16(sp)
    80020132:	1880                	addi	s0,sp,112
    80020134:	892a                	mv	s2,a0
    80020136:	e40c                	sd	a1,8(s0)
    80020138:	e810                	sd	a2,16(s0)
    8002013a:	ec14                	sd	a3,24(s0)
    8002013c:	f018                	sd	a4,32(s0)
    8002013e:	f41c                	sd	a5,40(s0)
    80020140:	03043823          	sd	a6,48(s0)
    80020144:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80020148:	00014797          	auipc	a5,0x14
    8002014c:	eb878793          	addi	a5,a5,-328 # 80034000 <boot_stack_top>
    80020150:	0187ac03          	lw	s8,24(a5)
  if(locking)
    80020154:	020c1f63          	bnez	s8,80020192 <printf+0x7a>
  if (fmt == 0)
    80020158:	04090363          	beqz	s2,8002019e <printf+0x86>
  va_start(ap, fmt);
    8002015c:	00840793          	addi	a5,s0,8
    80020160:	f8f43c23          	sd	a5,-104(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80020164:	00094503          	lbu	a0,0(s2)
    80020168:	0005079b          	sext.w	a5,a0
    8002016c:	16078563          	beqz	a5,800202d6 <printf+0x1be>
    80020170:	4481                	li	s1,0
    if(c != '%'){
    80020172:	02500993          	li	s3,37
    switch(c){
    80020176:	07000a93          	li	s5,112
    8002017a:	4cc1                	li	s9,16
    sbi_console_putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8002017c:	00009a17          	auipc	s4,0x9
    80020180:	e84a0a13          	addi	s4,s4,-380 # 80029000 <etext>
    switch(c){
    80020184:	07300b93          	li	s7,115
      for(; *s; s++)
    80020188:	02800d13          	li	s10,40
    switch(c){
    8002018c:	06400b13          	li	s6,100
    80020190:	a835                	j	800201cc <printf+0xb4>
    acquire(&pr.lock);
    80020192:	853e                	mv	a0,a5
    80020194:	00000097          	auipc	ra,0x0
    80020198:	3a8080e7          	jalr	936(ra) # 8002053c <acquire>
    8002019c:	bf75                	j	80020158 <printf+0x40>
    panic("null fmt");
    8002019e:	00009517          	auipc	a0,0x9
    800201a2:	e8a50513          	addi	a0,a0,-374 # 80029028 <etext+0x28>
    800201a6:	00000097          	auipc	ra,0x0
    800201aa:	f30080e7          	jalr	-208(ra) # 800200d6 <panic>
    800201ae:	4581                	li	a1,0
    800201b0:	4601                	li	a2,0
    800201b2:	4681                	li	a3,0
    800201b4:	4885                	li	a7,1
    800201b6:	00000073          	ecall
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800201ba:	2485                	addiw	s1,s1,1
    800201bc:	009907b3          	add	a5,s2,s1
    800201c0:	0007c503          	lbu	a0,0(a5)
    800201c4:	0005079b          	sext.w	a5,a0
    800201c8:	10078763          	beqz	a5,800202d6 <printf+0x1be>
    if(c != '%'){
    800201cc:	ff3791e3          	bne	a5,s3,800201ae <printf+0x96>
    c = fmt[++i] & 0xff;
    800201d0:	2485                	addiw	s1,s1,1
    800201d2:	009907b3          	add	a5,s2,s1
    800201d6:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
    800201da:	cff5                	beqz	a5,800202d6 <printf+0x1be>
    switch(c){
    800201dc:	05578a63          	beq	a5,s5,80020230 <printf+0x118>
    800201e0:	02faf663          	bgeu	s5,a5,8002020c <printf+0xf4>
    800201e4:	09778a63          	beq	a5,s7,80020278 <printf+0x160>
    800201e8:	07800713          	li	a4,120
    800201ec:	0ce79a63          	bne	a5,a4,800202c0 <printf+0x1a8>
      printint(va_arg(ap, int), 16, 1);
    800201f0:	f9843783          	ld	a5,-104(s0)
    800201f4:	00878713          	addi	a4,a5,8
    800201f8:	f8e43c23          	sd	a4,-104(s0)
    800201fc:	4605                	li	a2,1
    800201fe:	85e6                	mv	a1,s9
    80020200:	4388                	lw	a0,0(a5)
    80020202:	00000097          	auipc	ra,0x0
    80020206:	e14080e7          	jalr	-492(ra) # 80020016 <printint>
      break;
    8002020a:	bf45                	j	800201ba <printf+0xa2>
    switch(c){
    8002020c:	0b378263          	beq	a5,s3,800202b0 <printf+0x198>
    80020210:	0b679863          	bne	a5,s6,800202c0 <printf+0x1a8>
      printint(va_arg(ap, int), 10, 1);
    80020214:	f9843783          	ld	a5,-104(s0)
    80020218:	00878713          	addi	a4,a5,8
    8002021c:	f8e43c23          	sd	a4,-104(s0)
    80020220:	4605                	li	a2,1
    80020222:	45a9                	li	a1,10
    80020224:	4388                	lw	a0,0(a5)
    80020226:	00000097          	auipc	ra,0x0
    8002022a:	df0080e7          	jalr	-528(ra) # 80020016 <printint>
      break;
    8002022e:	b771                	j	800201ba <printf+0xa2>
      printptr(va_arg(ap, uint64));
    80020230:	f9843783          	ld	a5,-104(s0)
    80020234:	00878713          	addi	a4,a5,8
    80020238:	f8e43c23          	sd	a4,-104(s0)
    8002023c:	0007b803          	ld	a6,0(a5)
    80020240:	03000513          	li	a0,48
    80020244:	4581                	li	a1,0
    80020246:	4601                	li	a2,0
    80020248:	4681                	li	a3,0
    8002024a:	4885                	li	a7,1
    8002024c:	00000073          	ecall
    80020250:	07800513          	li	a0,120
    80020254:	00000073          	ecall
    80020258:	8766                	mv	a4,s9
    sbi_console_putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8002025a:	03c85793          	srli	a5,a6,0x3c
    8002025e:	97d2                	add	a5,a5,s4
    80020260:	0007c503          	lbu	a0,0(a5)
    80020264:	4581                	li	a1,0
    80020266:	4601                	li	a2,0
    80020268:	4681                	li	a3,0
    8002026a:	4885                	li	a7,1
    8002026c:	00000073          	ecall
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80020270:	0812                	slli	a6,a6,0x4
    80020272:	377d                	addiw	a4,a4,-1
    80020274:	f37d                	bnez	a4,8002025a <printf+0x142>
    80020276:	b791                	j	800201ba <printf+0xa2>
      if((s = va_arg(ap, char*)) == 0)
    80020278:	f9843783          	ld	a5,-104(s0)
    8002027c:	00878713          	addi	a4,a5,8
    80020280:	f8e43c23          	sd	a4,-104(s0)
    80020284:	639c                	ld	a5,0(a5)
    80020286:	cf99                	beqz	a5,800202a4 <printf+0x18c>
      for(; *s; s++)
    80020288:	0007c503          	lbu	a0,0(a5)
    8002028c:	d51d                	beqz	a0,800201ba <printf+0xa2>
    8002028e:	4581                	li	a1,0
    80020290:	4601                	li	a2,0
    80020292:	4681                	li	a3,0
    80020294:	4885                	li	a7,1
    80020296:	00000073          	ecall
    8002029a:	0785                	addi	a5,a5,1
    8002029c:	0007c503          	lbu	a0,0(a5)
    800202a0:	f57d                	bnez	a0,8002028e <printf+0x176>
    800202a2:	bf21                	j	800201ba <printf+0xa2>
        s = "(null)";
    800202a4:	00009797          	auipc	a5,0x9
    800202a8:	d7c78793          	addi	a5,a5,-644 # 80029020 <etext+0x20>
      for(; *s; s++)
    800202ac:	856a                	mv	a0,s10
    800202ae:	b7c5                	j	8002028e <printf+0x176>
    800202b0:	854e                	mv	a0,s3
    800202b2:	4581                	li	a1,0
    800202b4:	4601                	li	a2,0
    800202b6:	4681                	li	a3,0
    800202b8:	4885                	li	a7,1
    800202ba:	00000073          	ecall
    800202be:	bdf5                	j	800201ba <printf+0xa2>
    800202c0:	854e                	mv	a0,s3
    800202c2:	4581                	li	a1,0
    800202c4:	4601                	li	a2,0
    800202c6:	4681                	li	a3,0
    800202c8:	4885                	li	a7,1
    800202ca:	00000073          	ecall
    800202ce:	853e                	mv	a0,a5
    800202d0:	00000073          	ecall
    800202d4:	b5dd                	j	800201ba <printf+0xa2>
  if(locking)
    800202d6:	020c1063          	bnez	s8,800202f6 <printf+0x1de>
}
    800202da:	70a6                	ld	ra,104(sp)
    800202dc:	7406                	ld	s0,96(sp)
    800202de:	64e6                	ld	s1,88(sp)
    800202e0:	6946                	ld	s2,80(sp)
    800202e2:	69a6                	ld	s3,72(sp)
    800202e4:	6a06                	ld	s4,64(sp)
    800202e6:	7ae2                	ld	s5,56(sp)
    800202e8:	7b42                	ld	s6,48(sp)
    800202ea:	7ba2                	ld	s7,40(sp)
    800202ec:	7c02                	ld	s8,32(sp)
    800202ee:	6ce2                	ld	s9,24(sp)
    800202f0:	6d42                	ld	s10,16(sp)
    800202f2:	614d                	addi	sp,sp,176
    800202f4:	8082                	ret
    release(&pr.lock);
    800202f6:	00014517          	auipc	a0,0x14
    800202fa:	d0a50513          	addi	a0,a0,-758 # 80034000 <boot_stack_top>
    800202fe:	00000097          	auipc	ra,0x0
    80020302:	2f2080e7          	jalr	754(ra) # 800205f0 <release>
}
    80020306:	bfd1                	j	800202da <printf+0x1c2>

0000000080020308 <printfinit>:
}

void
printfinit(void)
{
    80020308:	1101                	addi	sp,sp,-32
    8002030a:	ec06                	sd	ra,24(sp)
    8002030c:	e822                	sd	s0,16(sp)
    8002030e:	e426                	sd	s1,8(sp)
    80020310:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80020312:	00014497          	auipc	s1,0x14
    80020316:	cee48493          	addi	s1,s1,-786 # 80034000 <boot_stack_top>
    8002031a:	00009597          	auipc	a1,0x9
    8002031e:	d1e58593          	addi	a1,a1,-738 # 80029038 <etext+0x38>
    80020322:	8526                	mv	a0,s1
    80020324:	00000097          	auipc	ra,0x0
    80020328:	188080e7          	jalr	392(ra) # 800204ac <initlock>
  pr.locking = 1;   // changed, used to be 1
    8002032c:	4785                	li	a5,1
    8002032e:	cc9c                	sw	a5,24(s1)
}
    80020330:	60e2                	ld	ra,24(sp)
    80020332:	6442                	ld	s0,16(sp)
    80020334:	64a2                	ld	s1,8(sp)
    80020336:	6105                	addi	sp,sp,32
    80020338:	8082                	ret

000000008002033a <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8002033a:	1101                	addi	sp,sp,-32
    8002033c:	ec06                	sd	ra,24(sp)
    8002033e:	e822                	sd	s0,16(sp)
    80020340:	e426                	sd	s1,8(sp)
    80020342:	e04a                	sd	s2,0(sp)
    80020344:	1000                	addi	s0,sp,32
  struct run *r;
  
  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < kernel_end || (uint64)pa >= PHYSTOP)
    80020346:	03451793          	slli	a5,a0,0x34
    8002034a:	efa1                	bnez	a5,800203a2 <kfree+0x68>
    8002034c:	84aa                	mv	s1,a0
    8002034e:	00020797          	auipc	a5,0x20
    80020352:	cb278793          	addi	a5,a5,-846 # 80040000 <kernel_end>
    80020356:	04f56663          	bltu	a0,a5,800203a2 <kfree+0x68>
    8002035a:	40300793          	li	a5,1027
    8002035e:	07d6                	slli	a5,a5,0x15
    80020360:	04f57163          	bgeu	a0,a5,800203a2 <kfree+0x68>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80020364:	6605                	lui	a2,0x1
    80020366:	4585                	li	a1,1
    80020368:	00000097          	auipc	ra,0x0
    8002036c:	2d0080e7          	jalr	720(ra) # 80020638 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80020370:	00014917          	auipc	s2,0x14
    80020374:	cb890913          	addi	s2,s2,-840 # 80034028 <kmem>
    80020378:	854a                	mv	a0,s2
    8002037a:	00000097          	auipc	ra,0x0
    8002037e:	1c2080e7          	jalr	450(ra) # 8002053c <acquire>
  r->next = kmem.freelist;
    80020382:	01893783          	ld	a5,24(s2)
    80020386:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80020388:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8002038c:	854a                	mv	a0,s2
    8002038e:	00000097          	auipc	ra,0x0
    80020392:	262080e7          	jalr	610(ra) # 800205f0 <release>
}
    80020396:	60e2                	ld	ra,24(sp)
    80020398:	6442                	ld	s0,16(sp)
    8002039a:	64a2                	ld	s1,8(sp)
    8002039c:	6902                	ld	s2,0(sp)
    8002039e:	6105                	addi	sp,sp,32
    800203a0:	8082                	ret
    panic("kfree");
    800203a2:	00009517          	auipc	a0,0x9
    800203a6:	c9e50513          	addi	a0,a0,-866 # 80029040 <etext+0x40>
    800203aa:	00000097          	auipc	ra,0x0
    800203ae:	d2c080e7          	jalr	-724(ra) # 800200d6 <panic>

00000000800203b2 <freerange>:
{
    800203b2:	7179                	addi	sp,sp,-48
    800203b4:	f406                	sd	ra,40(sp)
    800203b6:	f022                	sd	s0,32(sp)
    800203b8:	ec26                	sd	s1,24(sp)
    800203ba:	e84a                	sd	s2,16(sp)
    800203bc:	e44e                	sd	s3,8(sp)
    800203be:	e052                	sd	s4,0(sp)
    800203c0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800203c2:	6705                	lui	a4,0x1
    800203c4:	fff70793          	addi	a5,a4,-1 # fff <BASE_ADDRESS-0x8001f001>
    800203c8:	00f504b3          	add	s1,a0,a5
    800203cc:	77fd                	lui	a5,0xfffff
    800203ce:	8cfd                	and	s1,s1,a5
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800203d0:	94ba                	add	s1,s1,a4
    800203d2:	0095ee63          	bltu	a1,s1,800203ee <freerange+0x3c>
    800203d6:	892e                	mv	s2,a1
    kfree(p);
    800203d8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800203da:	6985                	lui	s3,0x1
    kfree(p);
    800203dc:	01448533          	add	a0,s1,s4
    800203e0:	00000097          	auipc	ra,0x0
    800203e4:	f5a080e7          	jalr	-166(ra) # 8002033a <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800203e8:	94ce                	add	s1,s1,s3
    800203ea:	fe9979e3          	bgeu	s2,s1,800203dc <freerange+0x2a>
}
    800203ee:	70a2                	ld	ra,40(sp)
    800203f0:	7402                	ld	s0,32(sp)
    800203f2:	64e2                	ld	s1,24(sp)
    800203f4:	6942                	ld	s2,16(sp)
    800203f6:	69a2                	ld	s3,8(sp)
    800203f8:	6a02                	ld	s4,0(sp)
    800203fa:	6145                	addi	sp,sp,48
    800203fc:	8082                	ret

00000000800203fe <kinit>:
{
    800203fe:	1141                	addi	sp,sp,-16
    80020400:	e406                	sd	ra,8(sp)
    80020402:	e022                	sd	s0,0(sp)
    80020404:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80020406:	00009597          	auipc	a1,0x9
    8002040a:	c4258593          	addi	a1,a1,-958 # 80029048 <etext+0x48>
    8002040e:	00014517          	auipc	a0,0x14
    80020412:	c1a50513          	addi	a0,a0,-998 # 80034028 <kmem>
    80020416:	00000097          	auipc	ra,0x0
    8002041a:	096080e7          	jalr	150(ra) # 800204ac <initlock>
  freerange(kernel_end, (void*)PHYSTOP);
    8002041e:	40300593          	li	a1,1027
    80020422:	05d6                	slli	a1,a1,0x15
    80020424:	00020517          	auipc	a0,0x20
    80020428:	bdc50513          	addi	a0,a0,-1060 # 80040000 <kernel_end>
    8002042c:	00000097          	auipc	ra,0x0
    80020430:	f86080e7          	jalr	-122(ra) # 800203b2 <freerange>
  printf("kinit\n");
    80020434:	00009517          	auipc	a0,0x9
    80020438:	c1c50513          	addi	a0,a0,-996 # 80029050 <etext+0x50>
    8002043c:	00000097          	auipc	ra,0x0
    80020440:	cdc080e7          	jalr	-804(ra) # 80020118 <printf>
}
    80020444:	60a2                	ld	ra,8(sp)
    80020446:	6402                	ld	s0,0(sp)
    80020448:	0141                	addi	sp,sp,16
    8002044a:	8082                	ret

000000008002044c <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8002044c:	1101                	addi	sp,sp,-32
    8002044e:	ec06                	sd	ra,24(sp)
    80020450:	e822                	sd	s0,16(sp)
    80020452:	e426                	sd	s1,8(sp)
    80020454:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80020456:	00014497          	auipc	s1,0x14
    8002045a:	bd248493          	addi	s1,s1,-1070 # 80034028 <kmem>
    8002045e:	8526                	mv	a0,s1
    80020460:	00000097          	auipc	ra,0x0
    80020464:	0dc080e7          	jalr	220(ra) # 8002053c <acquire>
  r = kmem.freelist;
    80020468:	6c84                	ld	s1,24(s1)
  if(r)
    8002046a:	c885                	beqz	s1,8002049a <kalloc+0x4e>
    kmem.freelist = r->next;
    8002046c:	609c                	ld	a5,0(s1)
    8002046e:	00014517          	auipc	a0,0x14
    80020472:	bba50513          	addi	a0,a0,-1094 # 80034028 <kmem>
    80020476:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80020478:	00000097          	auipc	ra,0x0
    8002047c:	178080e7          	jalr	376(ra) # 800205f0 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80020480:	6605                	lui	a2,0x1
    80020482:	4595                	li	a1,5
    80020484:	8526                	mv	a0,s1
    80020486:	00000097          	auipc	ra,0x0
    8002048a:	1b2080e7          	jalr	434(ra) # 80020638 <memset>
  return (void*)r;
    8002048e:	8526                	mv	a0,s1
    80020490:	60e2                	ld	ra,24(sp)
    80020492:	6442                	ld	s0,16(sp)
    80020494:	64a2                	ld	s1,8(sp)
    80020496:	6105                	addi	sp,sp,32
    80020498:	8082                	ret
  release(&kmem.lock);
    8002049a:	00014517          	auipc	a0,0x14
    8002049e:	b8e50513          	addi	a0,a0,-1138 # 80034028 <kmem>
    800204a2:	00000097          	auipc	ra,0x0
    800204a6:	14e080e7          	jalr	334(ra) # 800205f0 <release>
  if(r)
    800204aa:	b7d5                	j	8002048e <kalloc+0x42>

00000000800204ac <initlock>:
#include "include/proc.h"
#include "include/defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800204ac:	1141                	addi	sp,sp,-16
    800204ae:	e422                	sd	s0,8(sp)
    800204b0:	0800                	addi	s0,sp,16
  lk->name = name;
    800204b2:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800204b4:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800204b8:	00053823          	sd	zero,16(a0)
}
    800204bc:	6422                	ld	s0,8(sp)
    800204be:	0141                	addi	sp,sp,16
    800204c0:	8082                	ret

00000000800204c2 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800204c2:	411c                	lw	a5,0(a0)
    800204c4:	e399                	bnez	a5,800204ca <holding+0x8>
    800204c6:	4501                	li	a0,0
  return r;
}
    800204c8:	8082                	ret
{
    800204ca:	1101                	addi	sp,sp,-32
    800204cc:	ec06                	sd	ra,24(sp)
    800204ce:	e822                	sd	s0,16(sp)
    800204d0:	e426                	sd	s1,8(sp)
    800204d2:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800204d4:	6904                	ld	s1,16(a0)
    800204d6:	00001097          	auipc	ra,0x1
    800204da:	0e4080e7          	jalr	228(ra) # 800215ba <mycpu>
    800204de:	40a48533          	sub	a0,s1,a0
    800204e2:	00153513          	seqz	a0,a0
}
    800204e6:	60e2                	ld	ra,24(sp)
    800204e8:	6442                	ld	s0,16(sp)
    800204ea:	64a2                	ld	s1,8(sp)
    800204ec:	6105                	addi	sp,sp,32
    800204ee:	8082                	ret

00000000800204f0 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800204f0:	1101                	addi	sp,sp,-32
    800204f2:	ec06                	sd	ra,24(sp)
    800204f4:	e822                	sd	s0,16(sp)
    800204f6:	e426                	sd	s1,8(sp)
    800204f8:	1000                	addi	s0,sp,32

static inline uint64
r_sstatus()
{
  uint64 x;
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800204fa:	100024f3          	csrr	s1,sstatus
    800204fe:	100027f3          	csrr	a5,sstatus

// disable device interrupts
static inline void
intr_off()
{
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80020502:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80020504:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  //printf("\e[32mpush_off()\e[0m: cpuid(): %d\n", cpuid());
  if(mycpu()->noff == 0)
    80020508:	00001097          	auipc	ra,0x1
    8002050c:	0b2080e7          	jalr	178(ra) # 800215ba <mycpu>
    80020510:	5d3c                	lw	a5,120(a0)
    80020512:	cf89                	beqz	a5,8002052c <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80020514:	00001097          	auipc	ra,0x1
    80020518:	0a6080e7          	jalr	166(ra) # 800215ba <mycpu>
    8002051c:	5d3c                	lw	a5,120(a0)
    8002051e:	2785                	addiw	a5,a5,1
    80020520:	dd3c                	sw	a5,120(a0)
}
    80020522:	60e2                	ld	ra,24(sp)
    80020524:	6442                	ld	s0,16(sp)
    80020526:	64a2                	ld	s1,8(sp)
    80020528:	6105                	addi	sp,sp,32
    8002052a:	8082                	ret
    mycpu()->intena = old;
    8002052c:	00001097          	auipc	ra,0x1
    80020530:	08e080e7          	jalr	142(ra) # 800215ba <mycpu>
// are device interrupts enabled?
static inline int
intr_get()
{
  uint64 x = r_sstatus();
  return (x & SSTATUS_SIE) != 0;
    80020534:	8085                	srli	s1,s1,0x1
    80020536:	8885                	andi	s1,s1,1
    80020538:	dd64                	sw	s1,124(a0)
    8002053a:	bfe9                	j	80020514 <push_off+0x24>

000000008002053c <acquire>:
{
    8002053c:	1101                	addi	sp,sp,-32
    8002053e:	ec06                	sd	ra,24(sp)
    80020540:	e822                	sd	s0,16(sp)
    80020542:	e426                	sd	s1,8(sp)
    80020544:	1000                	addi	s0,sp,32
    80020546:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80020548:	00000097          	auipc	ra,0x0
    8002054c:	fa8080e7          	jalr	-88(ra) # 800204f0 <push_off>
  if(holding(lk))
    80020550:	8526                	mv	a0,s1
    80020552:	00000097          	auipc	ra,0x0
    80020556:	f70080e7          	jalr	-144(ra) # 800204c2 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8002055a:	4705                	li	a4,1
  if(holding(lk))
    8002055c:	e115                	bnez	a0,80020580 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8002055e:	87ba                	mv	a5,a4
    80020560:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80020564:	2781                	sext.w	a5,a5
    80020566:	ffe5                	bnez	a5,8002055e <acquire+0x22>
  __sync_synchronize();
    80020568:	0ff0000f          	fence
  lk->cpu = mycpu();
    8002056c:	00001097          	auipc	ra,0x1
    80020570:	04e080e7          	jalr	78(ra) # 800215ba <mycpu>
    80020574:	e888                	sd	a0,16(s1)
}
    80020576:	60e2                	ld	ra,24(sp)
    80020578:	6442                	ld	s0,16(sp)
    8002057a:	64a2                	ld	s1,8(sp)
    8002057c:	6105                	addi	sp,sp,32
    8002057e:	8082                	ret
    panic("acquire");
    80020580:	00009517          	auipc	a0,0x9
    80020584:	ad850513          	addi	a0,a0,-1320 # 80029058 <etext+0x58>
    80020588:	00000097          	auipc	ra,0x0
    8002058c:	b4e080e7          	jalr	-1202(ra) # 800200d6 <panic>

0000000080020590 <pop_off>:

void
pop_off(void)
{
    80020590:	1141                	addi	sp,sp,-16
    80020592:	e406                	sd	ra,8(sp)
    80020594:	e022                	sd	s0,0(sp)
    80020596:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80020598:	00001097          	auipc	ra,0x1
    8002059c:	022080e7          	jalr	34(ra) # 800215ba <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800205a0:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800205a4:	8b89                	andi	a5,a5,2

  //printf("\e[31mpop_off()\e[0m: cpuid(): %d\n", cpuid());
  if(intr_get())
    800205a6:	e78d                	bnez	a5,800205d0 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1) {
    800205a8:	5d3c                	lw	a5,120(a0)
    800205aa:	02f05b63          	blez	a5,800205e0 <pop_off+0x50>
    //printf("c->noff = %d\n", c->noff);
    panic("pop_off");
  }
  //printf("c->noff: %d\n", c->noff);
  //printf("c: %x\n", c);
  c->noff -= 1;
    800205ae:	37fd                	addiw	a5,a5,-1
    800205b0:	0007871b          	sext.w	a4,a5
    800205b4:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800205b6:	eb09                	bnez	a4,800205c8 <pop_off+0x38>
    800205b8:	5d7c                	lw	a5,124(a0)
    800205ba:	c799                	beqz	a5,800205c8 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800205bc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800205c0:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800205c4:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800205c8:	60a2                	ld	ra,8(sp)
    800205ca:	6402                	ld	s0,0(sp)
    800205cc:	0141                	addi	sp,sp,16
    800205ce:	8082                	ret
    panic("pop_off - interruptible");
    800205d0:	00009517          	auipc	a0,0x9
    800205d4:	a9050513          	addi	a0,a0,-1392 # 80029060 <etext+0x60>
    800205d8:	00000097          	auipc	ra,0x0
    800205dc:	afe080e7          	jalr	-1282(ra) # 800200d6 <panic>
    panic("pop_off");
    800205e0:	00009517          	auipc	a0,0x9
    800205e4:	a9850513          	addi	a0,a0,-1384 # 80029078 <etext+0x78>
    800205e8:	00000097          	auipc	ra,0x0
    800205ec:	aee080e7          	jalr	-1298(ra) # 800200d6 <panic>

00000000800205f0 <release>:
{
    800205f0:	1101                	addi	sp,sp,-32
    800205f2:	ec06                	sd	ra,24(sp)
    800205f4:	e822                	sd	s0,16(sp)
    800205f6:	e426                	sd	s1,8(sp)
    800205f8:	1000                	addi	s0,sp,32
    800205fa:	84aa                	mv	s1,a0
  if(!holding(lk))
    800205fc:	00000097          	auipc	ra,0x0
    80020600:	ec6080e7          	jalr	-314(ra) # 800204c2 <holding>
    80020604:	c115                	beqz	a0,80020628 <release+0x38>
  lk->cpu = 0;
    80020606:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    8002060a:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    8002060e:	0f50000f          	fence	iorw,ow
    80020612:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80020616:	00000097          	auipc	ra,0x0
    8002061a:	f7a080e7          	jalr	-134(ra) # 80020590 <pop_off>
}
    8002061e:	60e2                	ld	ra,24(sp)
    80020620:	6442                	ld	s0,16(sp)
    80020622:	64a2                	ld	s1,8(sp)
    80020624:	6105                	addi	sp,sp,32
    80020626:	8082                	ret
    panic("release");
    80020628:	00009517          	auipc	a0,0x9
    8002062c:	a5850513          	addi	a0,a0,-1448 # 80029080 <etext+0x80>
    80020630:	00000097          	auipc	ra,0x0
    80020634:	aa6080e7          	jalr	-1370(ra) # 800200d6 <panic>

0000000080020638 <memset>:
#include "include/types.h"

void*
memset(void *dst, int c, uint n)
{
    80020638:	1141                	addi	sp,sp,-16
    8002063a:	e422                	sd	s0,8(sp)
    8002063c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8002063e:	ce09                	beqz	a2,80020658 <memset+0x20>
    80020640:	87aa                	mv	a5,a0
    80020642:	fff6071b          	addiw	a4,a2,-1
    80020646:	1702                	slli	a4,a4,0x20
    80020648:	9301                	srli	a4,a4,0x20
    8002064a:	0705                	addi	a4,a4,1
    8002064c:	972a                	add	a4,a4,a0
    cdst[i] = c;
    8002064e:	00b78023          	sb	a1,0(a5) # fffffffffffff000 <kernel_end+0xffffffff7ffbf000>
    80020652:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
    80020654:	fee79de3          	bne	a5,a4,8002064e <memset+0x16>
  }
  return dst;
}
    80020658:	6422                	ld	s0,8(sp)
    8002065a:	0141                	addi	sp,sp,16
    8002065c:	8082                	ret

000000008002065e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8002065e:	1141                	addi	sp,sp,-16
    80020660:	e422                	sd	s0,8(sp)
    80020662:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80020664:	ce15                	beqz	a2,800206a0 <memcmp+0x42>
    80020666:	fff6069b          	addiw	a3,a2,-1
    if(*s1 != *s2)
    8002066a:	00054783          	lbu	a5,0(a0)
    8002066e:	0005c703          	lbu	a4,0(a1)
    80020672:	02e79063          	bne	a5,a4,80020692 <memcmp+0x34>
    80020676:	1682                	slli	a3,a3,0x20
    80020678:	9281                	srli	a3,a3,0x20
    8002067a:	0685                	addi	a3,a3,1
    8002067c:	96aa                	add	a3,a3,a0
      return *s1 - *s2;
    s1++, s2++;
    8002067e:	0505                	addi	a0,a0,1
    80020680:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80020682:	00d50d63          	beq	a0,a3,8002069c <memcmp+0x3e>
    if(*s1 != *s2)
    80020686:	00054783          	lbu	a5,0(a0)
    8002068a:	0005c703          	lbu	a4,0(a1)
    8002068e:	fee788e3          	beq	a5,a4,8002067e <memcmp+0x20>
      return *s1 - *s2;
    80020692:	40e7853b          	subw	a0,a5,a4
  }

  return 0;
}
    80020696:	6422                	ld	s0,8(sp)
    80020698:	0141                	addi	sp,sp,16
    8002069a:	8082                	ret
  return 0;
    8002069c:	4501                	li	a0,0
    8002069e:	bfe5                	j	80020696 <memcmp+0x38>
    800206a0:	4501                	li	a0,0
    800206a2:	bfd5                	j	80020696 <memcmp+0x38>

00000000800206a4 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800206a4:	1141                	addi	sp,sp,-16
    800206a6:	e422                	sd	s0,8(sp)
    800206a8:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
    800206aa:	02a5e563          	bltu	a1,a0,800206d4 <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800206ae:	fff6069b          	addiw	a3,a2,-1
    800206b2:	ce11                	beqz	a2,800206ce <memmove+0x2a>
    800206b4:	1682                	slli	a3,a3,0x20
    800206b6:	9281                	srli	a3,a3,0x20
    800206b8:	0685                	addi	a3,a3,1
    800206ba:	96ae                	add	a3,a3,a1
    800206bc:	87aa                	mv	a5,a0
      *d++ = *s++;
    800206be:	0585                	addi	a1,a1,1
    800206c0:	0785                	addi	a5,a5,1
    800206c2:	fff5c703          	lbu	a4,-1(a1)
    800206c6:	fee78fa3          	sb	a4,-1(a5)
    while(n-- > 0)
    800206ca:	fed59ae3          	bne	a1,a3,800206be <memmove+0x1a>

  return dst;
}
    800206ce:	6422                	ld	s0,8(sp)
    800206d0:	0141                	addi	sp,sp,16
    800206d2:	8082                	ret
  if(s < d && s + n > d){
    800206d4:	02061713          	slli	a4,a2,0x20
    800206d8:	9301                	srli	a4,a4,0x20
    800206da:	00e587b3          	add	a5,a1,a4
    800206de:	fcf578e3          	bgeu	a0,a5,800206ae <memmove+0xa>
    d += n;
    800206e2:	972a                	add	a4,a4,a0
    while(n-- > 0)
    800206e4:	fff6069b          	addiw	a3,a2,-1
    800206e8:	d27d                	beqz	a2,800206ce <memmove+0x2a>
    800206ea:	02069613          	slli	a2,a3,0x20
    800206ee:	9201                	srli	a2,a2,0x20
    800206f0:	fff64613          	not	a2,a2
    800206f4:	963e                	add	a2,a2,a5
      *--d = *--s;
    800206f6:	17fd                	addi	a5,a5,-1
    800206f8:	177d                	addi	a4,a4,-1
    800206fa:	0007c683          	lbu	a3,0(a5)
    800206fe:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    80020702:	fef61ae3          	bne	a2,a5,800206f6 <memmove+0x52>
    80020706:	b7e1                	j	800206ce <memmove+0x2a>

0000000080020708 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80020708:	1141                	addi	sp,sp,-16
    8002070a:	e406                	sd	ra,8(sp)
    8002070c:	e022                	sd	s0,0(sp)
    8002070e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80020710:	00000097          	auipc	ra,0x0
    80020714:	f94080e7          	jalr	-108(ra) # 800206a4 <memmove>
}
    80020718:	60a2                	ld	ra,8(sp)
    8002071a:	6402                	ld	s0,0(sp)
    8002071c:	0141                	addi	sp,sp,16
    8002071e:	8082                	ret

0000000080020720 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80020720:	1141                	addi	sp,sp,-16
    80020722:	e422                	sd	s0,8(sp)
    80020724:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80020726:	c229                	beqz	a2,80020768 <strncmp+0x48>
    80020728:	00054783          	lbu	a5,0(a0)
    8002072c:	c795                	beqz	a5,80020758 <strncmp+0x38>
    8002072e:	0005c703          	lbu	a4,0(a1)
    80020732:	02f71363          	bne	a4,a5,80020758 <strncmp+0x38>
    80020736:	fff6071b          	addiw	a4,a2,-1
    8002073a:	1702                	slli	a4,a4,0x20
    8002073c:	9301                	srli	a4,a4,0x20
    8002073e:	0705                	addi	a4,a4,1
    80020740:	972a                	add	a4,a4,a0
    n--, p++, q++;
    80020742:	0505                	addi	a0,a0,1
    80020744:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80020746:	02e50363          	beq	a0,a4,8002076c <strncmp+0x4c>
    8002074a:	00054783          	lbu	a5,0(a0)
    8002074e:	c789                	beqz	a5,80020758 <strncmp+0x38>
    80020750:	0005c683          	lbu	a3,0(a1)
    80020754:	fef687e3          	beq	a3,a5,80020742 <strncmp+0x22>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
    80020758:	00054503          	lbu	a0,0(a0)
    8002075c:	0005c783          	lbu	a5,0(a1)
    80020760:	9d1d                	subw	a0,a0,a5
}
    80020762:	6422                	ld	s0,8(sp)
    80020764:	0141                	addi	sp,sp,16
    80020766:	8082                	ret
    return 0;
    80020768:	4501                	li	a0,0
    8002076a:	bfe5                	j	80020762 <strncmp+0x42>
    8002076c:	4501                	li	a0,0
    8002076e:	bfd5                	j	80020762 <strncmp+0x42>

0000000080020770 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80020770:	1141                	addi	sp,sp,-16
    80020772:	e422                	sd	s0,8(sp)
    80020774:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80020776:	872a                	mv	a4,a0
    80020778:	a011                	j	8002077c <strncpy+0xc>
    8002077a:	8642                	mv	a2,a6
    8002077c:	fff6081b          	addiw	a6,a2,-1
    80020780:	00c05963          	blez	a2,80020792 <strncpy+0x22>
    80020784:	0705                	addi	a4,a4,1
    80020786:	0005c783          	lbu	a5,0(a1)
    8002078a:	fef70fa3          	sb	a5,-1(a4)
    8002078e:	0585                	addi	a1,a1,1
    80020790:	f7ed                	bnez	a5,8002077a <strncpy+0xa>
    ;
  while(n-- > 0)
    80020792:	86ba                	mv	a3,a4
    80020794:	01005b63          	blez	a6,800207aa <strncpy+0x3a>
    *s++ = 0;
    80020798:	0685                	addi	a3,a3,1
    8002079a:	fe068fa3          	sb	zero,-1(a3)
    8002079e:	fff6c793          	not	a5,a3
    800207a2:	9fb9                	addw	a5,a5,a4
  while(n-- > 0)
    800207a4:	9fb1                	addw	a5,a5,a2
    800207a6:	fef049e3          	bgtz	a5,80020798 <strncpy+0x28>
  return os;
}
    800207aa:	6422                	ld	s0,8(sp)
    800207ac:	0141                	addi	sp,sp,16
    800207ae:	8082                	ret

00000000800207b0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800207b0:	1141                	addi	sp,sp,-16
    800207b2:	e422                	sd	s0,8(sp)
    800207b4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800207b6:	02c05363          	blez	a2,800207dc <safestrcpy+0x2c>
    800207ba:	fff6069b          	addiw	a3,a2,-1
    800207be:	1682                	slli	a3,a3,0x20
    800207c0:	9281                	srli	a3,a3,0x20
    800207c2:	96ae                	add	a3,a3,a1
    800207c4:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800207c6:	00d58963          	beq	a1,a3,800207d8 <safestrcpy+0x28>
    800207ca:	0585                	addi	a1,a1,1
    800207cc:	0785                	addi	a5,a5,1
    800207ce:	fff5c703          	lbu	a4,-1(a1)
    800207d2:	fee78fa3          	sb	a4,-1(a5)
    800207d6:	fb65                	bnez	a4,800207c6 <safestrcpy+0x16>
    ;
  *s = 0;
    800207d8:	00078023          	sb	zero,0(a5)
  return os;
}
    800207dc:	6422                	ld	s0,8(sp)
    800207de:	0141                	addi	sp,sp,16
    800207e0:	8082                	ret

00000000800207e2 <strlen>:

int
strlen(const char *s)
{
    800207e2:	1141                	addi	sp,sp,-16
    800207e4:	e422                	sd	s0,8(sp)
    800207e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800207e8:	00054783          	lbu	a5,0(a0)
    800207ec:	cf91                	beqz	a5,80020808 <strlen+0x26>
    800207ee:	0505                	addi	a0,a0,1
    800207f0:	87aa                	mv	a5,a0
    800207f2:	4685                	li	a3,1
    800207f4:	9e89                	subw	a3,a3,a0
    ;
    800207f6:	00f6853b          	addw	a0,a3,a5
    800207fa:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
    800207fc:	fff7c703          	lbu	a4,-1(a5)
    80020800:	fb7d                	bnez	a4,800207f6 <strlen+0x14>
  return n;
}
    80020802:	6422                	ld	s0,8(sp)
    80020804:	0141                	addi	sp,sp,16
    80020806:	8082                	ret
  for(n = 0; s[n]; n++)
    80020808:	4501                	li	a0,0
    8002080a:	bfe5                	j	80020802 <strlen+0x20>

000000008002080c <wnstr>:

// convert uchar string into wide char string 
void wnstr(wchar *dst, char const *src, int len) {
    8002080c:	1141                	addi	sp,sp,-16
    8002080e:	e422                	sd	s0,8(sp)
    80020810:	0800                	addi	s0,sp,16
  while (len -- && *src) {
    80020812:	ca15                	beqz	a2,80020846 <wnstr+0x3a>
    80020814:	0005c783          	lbu	a5,0(a1)
    80020818:	cb8d                	beqz	a5,8002084a <wnstr+0x3e>
    8002081a:	fff6071b          	addiw	a4,a2,-1
    8002081e:	1702                	slli	a4,a4,0x20
    80020820:	9301                	srli	a4,a4,0x20
    80020822:	0705                	addi	a4,a4,1
    80020824:	0706                	slli	a4,a4,0x1
    80020826:	972a                	add	a4,a4,a0
    *(uchar*)dst = *src++;
    80020828:	0585                	addi	a1,a1,1
    8002082a:	00f50023          	sb	a5,0(a0)
    dst ++;
    8002082e:	0509                	addi	a0,a0,2
  while (len -- && *src) {
    80020830:	00e50663          	beq	a0,a4,8002083c <wnstr+0x30>
    80020834:	0005c783          	lbu	a5,0(a1)
    80020838:	fbe5                	bnez	a5,80020828 <wnstr+0x1c>
    dst ++;
    8002083a:	872a                	mv	a4,a0
  }

  *dst = 0;
    8002083c:	00071023          	sh	zero,0(a4)
}
    80020840:	6422                	ld	s0,8(sp)
    80020842:	0141                	addi	sp,sp,16
    80020844:	8082                	ret
  while (len -- && *src) {
    80020846:	872a                	mv	a4,a0
    80020848:	bfd5                	j	8002083c <wnstr+0x30>
    8002084a:	872a                	mv	a4,a0
    8002084c:	bfc5                	j	8002083c <wnstr+0x30>

000000008002084e <snstr>:

// convert wide char string into uchar string 
void snstr(char *dst, wchar const *src, int len) {
    8002084e:	1141                	addi	sp,sp,-16
    80020850:	e422                	sd	s0,8(sp)
    80020852:	0800                	addi	s0,sp,16
  while (len -- && *src) {
    80020854:	c229                	beqz	a2,80020896 <snstr+0x48>
    80020856:	fff6071b          	addiw	a4,a2,-1
    8002085a:	0005d783          	lhu	a5,0(a1)
    8002085e:	cf99                	beqz	a5,8002087c <snstr+0x2e>
    80020860:	3679                	addiw	a2,a2,-2
    80020862:	56fd                	li	a3,-1
    *dst++ = (uchar)(*src & 0xff);
    80020864:	0505                	addi	a0,a0,1
    80020866:	fef50fa3          	sb	a5,-1(a0)
    src ++;
    8002086a:	0589                	addi	a1,a1,2
  while (len -- && *src) {
    8002086c:	0006071b          	sext.w	a4,a2
    80020870:	02d60363          	beq	a2,a3,80020896 <snstr+0x48>
    80020874:	0005d783          	lhu	a5,0(a1)
    80020878:	367d                	addiw	a2,a2,-1
    8002087a:	f7ed                	bnez	a5,80020864 <snstr+0x16>
  }
  while(len-- > 0)
    8002087c:	00e05d63          	blez	a4,80020896 <snstr+0x48>
    80020880:	fff7079b          	addiw	a5,a4,-1
    80020884:	1782                	slli	a5,a5,0x20
    80020886:	9381                	srli	a5,a5,0x20
    80020888:	0785                	addi	a5,a5,1
    8002088a:	97aa                	add	a5,a5,a0
    *dst++ = 0;
    8002088c:	0505                	addi	a0,a0,1
    8002088e:	fe050fa3          	sb	zero,-1(a0)
  while(len-- > 0)
    80020892:	fea79de3          	bne	a5,a0,8002088c <snstr+0x3e>
}
    80020896:	6422                	ld	s0,8(sp)
    80020898:	0141                	addi	sp,sp,16
    8002089a:	8082                	ret

000000008002089c <wcsncmp>:

int wcsncmp(wchar const *s1, wchar const *s2, int len) {
    8002089c:	1141                	addi	sp,sp,-16
    8002089e:	e422                	sd	s0,8(sp)
    800208a0:	0800                	addi	s0,sp,16
  int ret = 0;

  while (len-- && *s1) {
    800208a2:	1602                	slli	a2,a2,0x20
    800208a4:	9201                	srli	a2,a2,0x20
    800208a6:	0606                	slli	a2,a2,0x1
    800208a8:	962e                	add	a2,a2,a1
    800208aa:	00c58c63          	beq	a1,a2,800208c2 <wcsncmp+0x26>
    800208ae:	00055783          	lhu	a5,0(a0)
    800208b2:	cb89                	beqz	a5,800208c4 <wcsncmp+0x28>
    ret = (int)(*s1++ - *s2++);
    800208b4:	0509                	addi	a0,a0,2
    800208b6:	0589                	addi	a1,a1,2
    800208b8:	ffe5d703          	lhu	a4,-2(a1)
    800208bc:	9f99                	subw	a5,a5,a4
    if (ret) break;
    800208be:	d7f5                	beqz	a5,800208aa <wcsncmp+0xe>
    800208c0:	a011                	j	800208c4 <wcsncmp+0x28>
    800208c2:	4781                	li	a5,0
  }

  return ret;
    800208c4:	853e                	mv	a0,a5
    800208c6:	6422                	ld	s0,8(sp)
    800208c8:	0141                	addi	sp,sp,16
    800208ca:	8082                	ret

00000000800208cc <main>:

volatile static int started = 0;

void
main(unsigned long hartid, unsigned long dtb_pa)
{
    800208cc:	7179                	addi	sp,sp,-48
    800208ce:	f406                	sd	ra,40(sp)
    800208d0:	f022                	sd	s0,32(sp)
    800208d2:	ec26                	sd	s1,24(sp)
    800208d4:	e84a                	sd	s2,16(sp)
    800208d6:	1800                	addi	s0,sp,48
    800208d8:	84aa                	mv	s1,a0
    800208da:	892e                	mv	s2,a1
  asm volatile("mv tp, %0" : : "r" (hartid & 0x1));
    800208dc:	00157793          	andi	a5,a0,1
    800208e0:	823e                	mv	tp,a5
    __sync_synchronize();
    started = 1;
  } else
  {
    // hart 1
    while (started == 0)
    800208e2:	00013717          	auipc	a4,0x13
    800208e6:	76670713          	addi	a4,a4,1894 # 80034048 <started>
  if (hartid == 0) {
    800208ea:	cd29                	beqz	a0,80020944 <main+0x78>
    while (started == 0)
    800208ec:	431c                	lw	a5,0(a4)
    800208ee:	2781                	sext.w	a5,a5
    800208f0:	dff5                	beqz	a5,800208ec <main+0x20>
      ;
    __sync_synchronize();
    800208f2:	0ff0000f          	fence
    printf("hart %d enter main()...\n", hartid);
    800208f6:	85a6                	mv	a1,s1
    800208f8:	00008517          	auipc	a0,0x8
    800208fc:	79050513          	addi	a0,a0,1936 # 80029088 <etext+0x88>
    80020900:	00000097          	auipc	ra,0x0
    80020904:	818080e7          	jalr	-2024(ra) # 80020118 <printf>
    kvminithart();
    80020908:	00000097          	auipc	ra,0x0
    8002090c:	0e4080e7          	jalr	228(ra) # 800209ec <kvminithart>
    trapinithart();
    80020910:	00002097          	auipc	ra,0x2
    80020914:	9fa080e7          	jalr	-1542(ra) # 8002230a <trapinithart>
    timerinit();     // set up timer interrupt handler
    80020918:	00004097          	auipc	ra,0x4
    8002091c:	b9c080e7          	jalr	-1124(ra) # 800244b4 <timerinit>
    #ifndef QEMU
    device_init(dtb_pa, hartid);
    80020920:	85a6                	mv	a1,s1
    80020922:	854a                	mv	a0,s2
    80020924:	00002097          	auipc	ra,0x2
    80020928:	d3a080e7          	jalr	-710(ra) # 8002265e <device_init>
    #else
    plicinithart();  // ask PLIC for device interrupts
    #endif
    printf("hart 1 init done\n");
    8002092c:	00008517          	auipc	a0,0x8
    80020930:	79450513          	addi	a0,a0,1940 # 800290c0 <etext+0xc0>
    80020934:	fffff097          	auipc	ra,0xfffff
    80020938:	7e4080e7          	jalr	2020(ra) # 80020118 <printf>
  }
  scheduler();
    8002093c:	00001097          	auipc	ra,0x1
    80020940:	2a0080e7          	jalr	672(ra) # 80021bdc <scheduler>
    printfinit();   // init a lock for printf 
    80020944:	00000097          	auipc	ra,0x0
    80020948:	9c4080e7          	jalr	-1596(ra) # 80020308 <printfinit>
    print_logo();
    8002094c:	00004097          	auipc	ra,0x4
    80020950:	c10080e7          	jalr	-1008(ra) # 8002455c <print_logo>
    printf("hart %d enter main()...\n", hartid);
    80020954:	4581                	li	a1,0
    80020956:	00008517          	auipc	a0,0x8
    8002095a:	73250513          	addi	a0,a0,1842 # 80029088 <etext+0x88>
    8002095e:	fffff097          	auipc	ra,0xfffff
    80020962:	7ba080e7          	jalr	1978(ra) # 80020118 <printf>
    kinit();         // physical page allocator
    80020966:	00000097          	auipc	ra,0x0
    8002096a:	a98080e7          	jalr	-1384(ra) # 800203fe <kinit>
    kvminit();       // create kernel page table
    8002096e:	00000097          	auipc	ra,0x0
    80020972:	2c6080e7          	jalr	710(ra) # 80020c34 <kvminit>
    kvminithart();   // turn on paging
    80020976:	00000097          	auipc	ra,0x0
    8002097a:	076080e7          	jalr	118(ra) # 800209ec <kvminithart>
    trapinit();      // trap vectors
    8002097e:	00002097          	auipc	ra,0x2
    80020982:	954080e7          	jalr	-1708(ra) # 800222d2 <trapinit>
    trapinithart();  // install kernel trap vector
    80020986:	00002097          	auipc	ra,0x2
    8002098a:	984080e7          	jalr	-1660(ra) # 8002230a <trapinithart>
    timerinit();     // set up timer interrupt handler
    8002098e:	00004097          	auipc	ra,0x4
    80020992:	b26080e7          	jalr	-1242(ra) # 800244b4 <timerinit>
    procinit();
    80020996:	00001097          	auipc	ra,0x1
    8002099a:	b34080e7          	jalr	-1228(ra) # 800214ca <procinit>
    fpioa_pin_init();
    8002099e:	00006097          	auipc	ra,0x6
    800209a2:	6c8080e7          	jalr	1736(ra) # 80027066 <fpioa_pin_init>
    sdcard_init();
    800209a6:	00007097          	auipc	ra,0x7
    800209aa:	e26080e7          	jalr	-474(ra) # 800277cc <sdcard_init>
    test_sdcard();
    800209ae:	00004097          	auipc	ra,0x4
    800209b2:	03a080e7          	jalr	58(ra) # 800249e8 <test_sdcard>
    printf("hart 0 init done\n");
    800209b6:	00008517          	auipc	a0,0x8
    800209ba:	6f250513          	addi	a0,a0,1778 # 800290a8 <etext+0xa8>
    800209be:	fffff097          	auipc	ra,0xfffff
    800209c2:	75a080e7          	jalr	1882(ra) # 80020118 <printf>
      unsigned long mask = 1 << i;
    800209c6:	4789                	li	a5,2
    800209c8:	fcf43c23          	sd	a5,-40(s0)
	SBI_CALL_0(SBI_CLEAR_IPI);
}

static inline void sbi_send_ipi(const unsigned long *hart_mask)
{
	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
    800209cc:	fd840513          	addi	a0,s0,-40
    800209d0:	4581                	li	a1,0
    800209d2:	4601                	li	a2,0
    800209d4:	4681                	li	a3,0
    800209d6:	4891                	li	a7,4
    800209d8:	00000073          	ecall
    __sync_synchronize();
    800209dc:	0ff0000f          	fence
    started = 1;
    800209e0:	4785                	li	a5,1
    800209e2:	00013717          	auipc	a4,0x13
    800209e6:	66f72323          	sw	a5,1638(a4) # 80034048 <started>
    800209ea:	bf89                	j	8002093c <main+0x70>

00000000800209ec <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    800209ec:	1141                	addi	sp,sp,-16
    800209ee:	e406                	sd	ra,8(sp)
    800209f0:	e022                	sd	s0,0(sp)
    800209f2:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    800209f4:	00013797          	auipc	a5,0x13
    800209f8:	65c78793          	addi	a5,a5,1628 # 80034050 <kernel_pagetable>
    800209fc:	639c                	ld	a5,0(a5)
    800209fe:	83b1                	srli	a5,a5,0xc
    80020a00:	577d                	li	a4,-1
    80020a02:	177e                	slli	a4,a4,0x3f
    80020a04:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80020a06:	18079073          	csrw	satp,a5
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  // asm volatile("sfence.vma zero, zero");
  asm volatile("sfence.vma");
    80020a0a:	12000073          	sfence.vma
  // reg_info();
  sfence_vma();
  printf("kvminithart\n");
    80020a0e:	00008517          	auipc	a0,0x8
    80020a12:	6ca50513          	addi	a0,a0,1738 # 800290d8 <etext+0xd8>
    80020a16:	fffff097          	auipc	ra,0xfffff
    80020a1a:	702080e7          	jalr	1794(ra) # 80020118 <printf>
}
    80020a1e:	60a2                	ld	ra,8(sp)
    80020a20:	6402                	ld	s0,0(sp)
    80020a22:	0141                	addi	sp,sp,16
    80020a24:	8082                	ret

0000000080020a26 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80020a26:	7139                	addi	sp,sp,-64
    80020a28:	fc06                	sd	ra,56(sp)
    80020a2a:	f822                	sd	s0,48(sp)
    80020a2c:	f426                	sd	s1,40(sp)
    80020a2e:	f04a                	sd	s2,32(sp)
    80020a30:	ec4e                	sd	s3,24(sp)
    80020a32:	e852                	sd	s4,16(sp)
    80020a34:	e456                	sd	s5,8(sp)
    80020a36:	e05a                	sd	s6,0(sp)
    80020a38:	0080                	addi	s0,sp,64
    80020a3a:	84aa                	mv	s1,a0
    80020a3c:	89ae                	mv	s3,a1
    80020a3e:	8b32                	mv	s6,a2
  
  if(va >= MAXVA)
    80020a40:	57fd                	li	a5,-1
    80020a42:	83e9                	srli	a5,a5,0x1a
    80020a44:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80020a46:	4ab1                	li	s5,12
  if(va >= MAXVA)
    80020a48:	04b7f263          	bgeu	a5,a1,80020a8c <walk+0x66>
    panic("walk");
    80020a4c:	00008517          	auipc	a0,0x8
    80020a50:	69c50513          	addi	a0,a0,1692 # 800290e8 <etext+0xe8>
    80020a54:	fffff097          	auipc	ra,0xfffff
    80020a58:	682080e7          	jalr	1666(ra) # 800200d6 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80020a5c:	060b0663          	beqz	s6,80020ac8 <walk+0xa2>
    80020a60:	00000097          	auipc	ra,0x0
    80020a64:	9ec080e7          	jalr	-1556(ra) # 8002044c <kalloc>
    80020a68:	84aa                	mv	s1,a0
    80020a6a:	c529                	beqz	a0,80020ab4 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80020a6c:	6605                	lui	a2,0x1
    80020a6e:	4581                	li	a1,0
    80020a70:	00000097          	auipc	ra,0x0
    80020a74:	bc8080e7          	jalr	-1080(ra) # 80020638 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80020a78:	00c4d793          	srli	a5,s1,0xc
    80020a7c:	07aa                	slli	a5,a5,0xa
    80020a7e:	0017e793          	ori	a5,a5,1
    80020a82:	00f93023          	sd	a5,0(s2)
    80020a86:	3a5d                	addiw	s4,s4,-9
  for(int level = 2; level > 0; level--) {
    80020a88:	035a0063          	beq	s4,s5,80020aa8 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80020a8c:	0149d933          	srl	s2,s3,s4
    80020a90:	1ff97913          	andi	s2,s2,511
    80020a94:	090e                	slli	s2,s2,0x3
    80020a96:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80020a98:	00093483          	ld	s1,0(s2)
    80020a9c:	0014f793          	andi	a5,s1,1
    80020aa0:	dfd5                	beqz	a5,80020a5c <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80020aa2:	80a9                	srli	s1,s1,0xa
    80020aa4:	04b2                	slli	s1,s1,0xc
    80020aa6:	b7c5                	j	80020a86 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80020aa8:	00c9d513          	srli	a0,s3,0xc
    80020aac:	1ff57513          	andi	a0,a0,511
    80020ab0:	050e                	slli	a0,a0,0x3
    80020ab2:	9526                	add	a0,a0,s1
}
    80020ab4:	70e2                	ld	ra,56(sp)
    80020ab6:	7442                	ld	s0,48(sp)
    80020ab8:	74a2                	ld	s1,40(sp)
    80020aba:	7902                	ld	s2,32(sp)
    80020abc:	69e2                	ld	s3,24(sp)
    80020abe:	6a42                	ld	s4,16(sp)
    80020ac0:	6aa2                	ld	s5,8(sp)
    80020ac2:	6b02                	ld	s6,0(sp)
    80020ac4:	6121                	addi	sp,sp,64
    80020ac6:	8082                	ret
        return 0;
    80020ac8:	4501                	li	a0,0
    80020aca:	b7ed                	j	80020ab4 <walk+0x8e>

0000000080020acc <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80020acc:	57fd                	li	a5,-1
    80020ace:	83e9                	srli	a5,a5,0x1a
    80020ad0:	00b7f463          	bgeu	a5,a1,80020ad8 <walkaddr+0xc>
    return 0;
    80020ad4:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80020ad6:	8082                	ret
{
    80020ad8:	1141                	addi	sp,sp,-16
    80020ada:	e406                	sd	ra,8(sp)
    80020adc:	e022                	sd	s0,0(sp)
    80020ade:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80020ae0:	4601                	li	a2,0
    80020ae2:	00000097          	auipc	ra,0x0
    80020ae6:	f44080e7          	jalr	-188(ra) # 80020a26 <walk>
  if(pte == 0)
    80020aea:	c105                	beqz	a0,80020b0a <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80020aec:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80020aee:	0117f693          	andi	a3,a5,17
    80020af2:	4745                	li	a4,17
    return 0;
    80020af4:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80020af6:	00e68663          	beq	a3,a4,80020b02 <walkaddr+0x36>
}
    80020afa:	60a2                	ld	ra,8(sp)
    80020afc:	6402                	ld	s0,0(sp)
    80020afe:	0141                	addi	sp,sp,16
    80020b00:	8082                	ret
  pa = PTE2PA(*pte);
    80020b02:	00a7d513          	srli	a0,a5,0xa
    80020b06:	0532                	slli	a0,a0,0xc
  return pa;
    80020b08:	bfcd                	j	80020afa <walkaddr+0x2e>
    return 0;
    80020b0a:	4501                	li	a0,0
    80020b0c:	b7fd                	j	80020afa <walkaddr+0x2e>

0000000080020b0e <kvmpa>:
// a physical address. only needed for
// addresses on the stack.
// assumes va is page aligned.
uint64
kvmpa(uint64 va)
{
    80020b0e:	1101                	addi	sp,sp,-32
    80020b10:	ec06                	sd	ra,24(sp)
    80020b12:	e822                	sd	s0,16(sp)
    80020b14:	e426                	sd	s1,8(sp)
    80020b16:	1000                	addi	s0,sp,32
    80020b18:	85aa                	mv	a1,a0
  uint64 off = va % PGSIZE;
    80020b1a:	03451493          	slli	s1,a0,0x34
  pte_t *pte;
  uint64 pa;
  
  pte = walk(kernel_pagetable, va, 0);
    80020b1e:	4601                	li	a2,0
    80020b20:	00013797          	auipc	a5,0x13
    80020b24:	53078793          	addi	a5,a5,1328 # 80034050 <kernel_pagetable>
    80020b28:	6388                	ld	a0,0(a5)
    80020b2a:	00000097          	auipc	ra,0x0
    80020b2e:	efc080e7          	jalr	-260(ra) # 80020a26 <walk>
  if(pte == 0)
    80020b32:	cd11                	beqz	a0,80020b4e <kvmpa+0x40>
    80020b34:	90d1                	srli	s1,s1,0x34
    panic("kvmpa");
  if((*pte & PTE_V) == 0)
    80020b36:	6108                	ld	a0,0(a0)
    80020b38:	00157793          	andi	a5,a0,1
    80020b3c:	c38d                	beqz	a5,80020b5e <kvmpa+0x50>
    panic("kvmpa");
  pa = PTE2PA(*pte);
    80020b3e:	8129                	srli	a0,a0,0xa
    80020b40:	0532                	slli	a0,a0,0xc
  return pa+off;
}
    80020b42:	9526                	add	a0,a0,s1
    80020b44:	60e2                	ld	ra,24(sp)
    80020b46:	6442                	ld	s0,16(sp)
    80020b48:	64a2                	ld	s1,8(sp)
    80020b4a:	6105                	addi	sp,sp,32
    80020b4c:	8082                	ret
    panic("kvmpa");
    80020b4e:	00008517          	auipc	a0,0x8
    80020b52:	5a250513          	addi	a0,a0,1442 # 800290f0 <etext+0xf0>
    80020b56:	fffff097          	auipc	ra,0xfffff
    80020b5a:	580080e7          	jalr	1408(ra) # 800200d6 <panic>
    panic("kvmpa");
    80020b5e:	00008517          	auipc	a0,0x8
    80020b62:	59250513          	addi	a0,a0,1426 # 800290f0 <etext+0xf0>
    80020b66:	fffff097          	auipc	ra,0xfffff
    80020b6a:	570080e7          	jalr	1392(ra) # 800200d6 <panic>

0000000080020b6e <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80020b6e:	715d                	addi	sp,sp,-80
    80020b70:	e486                	sd	ra,72(sp)
    80020b72:	e0a2                	sd	s0,64(sp)
    80020b74:	fc26                	sd	s1,56(sp)
    80020b76:	f84a                	sd	s2,48(sp)
    80020b78:	f44e                	sd	s3,40(sp)
    80020b7a:	f052                	sd	s4,32(sp)
    80020b7c:	ec56                	sd	s5,24(sp)
    80020b7e:	e85a                	sd	s6,16(sp)
    80020b80:	e45e                	sd	s7,8(sp)
    80020b82:	0880                	addi	s0,sp,80
    80020b84:	8aaa                	mv	s5,a0
    80020b86:	8b3a                	mv	s6,a4
  uint64 a, last;
  pte_t *pte;

  a = PGROUNDDOWN(va);
    80020b88:	79fd                	lui	s3,0xfffff
    80020b8a:	0135fa33          	and	s4,a1,s3
  last = PGROUNDDOWN(va + size - 1);
    80020b8e:	167d                	addi	a2,a2,-1
    80020b90:	962e                	add	a2,a2,a1
    80020b92:	013679b3          	and	s3,a2,s3
  a = PGROUNDDOWN(va);
    80020b96:	8952                	mv	s2,s4
    80020b98:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80020b9c:	6b85                	lui	s7,0x1
    80020b9e:	a811                	j	80020bb2 <mappages+0x44>
      panic("remap");
    80020ba0:	00008517          	auipc	a0,0x8
    80020ba4:	55850513          	addi	a0,a0,1368 # 800290f8 <etext+0xf8>
    80020ba8:	fffff097          	auipc	ra,0xfffff
    80020bac:	52e080e7          	jalr	1326(ra) # 800200d6 <panic>
    a += PGSIZE;
    80020bb0:	995e                	add	s2,s2,s7
    pa += PGSIZE;
    80020bb2:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    80020bb6:	4605                	li	a2,1
    80020bb8:	85ca                	mv	a1,s2
    80020bba:	8556                	mv	a0,s5
    80020bbc:	00000097          	auipc	ra,0x0
    80020bc0:	e6a080e7          	jalr	-406(ra) # 80020a26 <walk>
    80020bc4:	cd19                	beqz	a0,80020be2 <mappages+0x74>
    if(*pte & PTE_V)
    80020bc6:	611c                	ld	a5,0(a0)
    80020bc8:	8b85                	andi	a5,a5,1
    80020bca:	fbf9                	bnez	a5,80020ba0 <mappages+0x32>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80020bcc:	80b1                	srli	s1,s1,0xc
    80020bce:	04aa                	slli	s1,s1,0xa
    80020bd0:	0164e4b3          	or	s1,s1,s6
    80020bd4:	0014e493          	ori	s1,s1,1
    80020bd8:	e104                	sd	s1,0(a0)
    if(a == last)
    80020bda:	fd391be3          	bne	s2,s3,80020bb0 <mappages+0x42>
  }
  return 0;
    80020bde:	4501                	li	a0,0
    80020be0:	a011                	j	80020be4 <mappages+0x76>
      return -1;
    80020be2:	557d                	li	a0,-1
}
    80020be4:	60a6                	ld	ra,72(sp)
    80020be6:	6406                	ld	s0,64(sp)
    80020be8:	74e2                	ld	s1,56(sp)
    80020bea:	7942                	ld	s2,48(sp)
    80020bec:	79a2                	ld	s3,40(sp)
    80020bee:	7a02                	ld	s4,32(sp)
    80020bf0:	6ae2                	ld	s5,24(sp)
    80020bf2:	6b42                	ld	s6,16(sp)
    80020bf4:	6ba2                	ld	s7,8(sp)
    80020bf6:	6161                	addi	sp,sp,80
    80020bf8:	8082                	ret

0000000080020bfa <kvmmap>:
{
    80020bfa:	1141                	addi	sp,sp,-16
    80020bfc:	e406                	sd	ra,8(sp)
    80020bfe:	e022                	sd	s0,0(sp)
    80020c00:	0800                	addi	s0,sp,16
  if(mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    80020c02:	8736                	mv	a4,a3
    80020c04:	86ae                	mv	a3,a1
    80020c06:	85aa                	mv	a1,a0
    80020c08:	00013797          	auipc	a5,0x13
    80020c0c:	44878793          	addi	a5,a5,1096 # 80034050 <kernel_pagetable>
    80020c10:	6388                	ld	a0,0(a5)
    80020c12:	00000097          	auipc	ra,0x0
    80020c16:	f5c080e7          	jalr	-164(ra) # 80020b6e <mappages>
    80020c1a:	e509                	bnez	a0,80020c24 <kvmmap+0x2a>
}
    80020c1c:	60a2                	ld	ra,8(sp)
    80020c1e:	6402                	ld	s0,0(sp)
    80020c20:	0141                	addi	sp,sp,16
    80020c22:	8082                	ret
    panic("kvmmap");
    80020c24:	00008517          	auipc	a0,0x8
    80020c28:	4dc50513          	addi	a0,a0,1244 # 80029100 <etext+0x100>
    80020c2c:	fffff097          	auipc	ra,0xfffff
    80020c30:	4aa080e7          	jalr	1194(ra) # 800200d6 <panic>

0000000080020c34 <kvminit>:
{
    80020c34:	1101                	addi	sp,sp,-32
    80020c36:	ec06                	sd	ra,24(sp)
    80020c38:	e822                	sd	s0,16(sp)
    80020c3a:	e426                	sd	s1,8(sp)
    80020c3c:	1000                	addi	s0,sp,32
  kernel_pagetable = (pagetable_t) kalloc();
    80020c3e:	00000097          	auipc	ra,0x0
    80020c42:	80e080e7          	jalr	-2034(ra) # 8002044c <kalloc>
    80020c46:	00013797          	auipc	a5,0x13
    80020c4a:	40a7b523          	sd	a0,1034(a5) # 80034050 <kernel_pagetable>
  memset(kernel_pagetable, 0, PGSIZE);
    80020c4e:	6605                	lui	a2,0x1
    80020c50:	4581                	li	a1,0
    80020c52:	00000097          	auipc	ra,0x0
    80020c56:	9e6080e7          	jalr	-1562(ra) # 80020638 <memset>
  kvmmap(UARTHS, UARTHS, PGSIZE, PTE_R | PTE_W);
    80020c5a:	4699                	li	a3,6
    80020c5c:	6605                	lui	a2,0x1
    80020c5e:	380005b7          	lui	a1,0x38000
    80020c62:	38000537          	lui	a0,0x38000
    80020c66:	00000097          	auipc	ra,0x0
    80020c6a:	f94080e7          	jalr	-108(ra) # 80020bfa <kvmmap>
  kvmmap(CLINT, CLINT, 0x10000, PTE_R | PTE_W);
    80020c6e:	4699                	li	a3,6
    80020c70:	6641                	lui	a2,0x10
    80020c72:	020005b7          	lui	a1,0x2000
    80020c76:	02000537          	lui	a0,0x2000
    80020c7a:	00000097          	auipc	ra,0x0
    80020c7e:	f80080e7          	jalr	-128(ra) # 80020bfa <kvmmap>
  kvmmap(PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80020c82:	4699                	li	a3,6
    80020c84:	00400637          	lui	a2,0x400
    80020c88:	0c2005b7          	lui	a1,0xc200
    80020c8c:	0c200537          	lui	a0,0xc200
    80020c90:	00000097          	auipc	ra,0x0
    80020c94:	f6a080e7          	jalr	-150(ra) # 80020bfa <kvmmap>
  kvmmap(GPIOHS, GPIOHS, 0x1000, PTE_R | PTE_W);
    80020c98:	4699                	li	a3,6
    80020c9a:	6605                	lui	a2,0x1
    80020c9c:	380015b7          	lui	a1,0x38001
    80020ca0:	38001537          	lui	a0,0x38001
    80020ca4:	00000097          	auipc	ra,0x0
    80020ca8:	f56080e7          	jalr	-170(ra) # 80020bfa <kvmmap>
  kvmmap(GPIO, GPIO, 0x1000, PTE_R | PTE_W);
    80020cac:	4699                	li	a3,6
    80020cae:	6605                	lui	a2,0x1
    80020cb0:	502005b7          	lui	a1,0x50200
    80020cb4:	50200537          	lui	a0,0x50200
    80020cb8:	00000097          	auipc	ra,0x0
    80020cbc:	f42080e7          	jalr	-190(ra) # 80020bfa <kvmmap>
  kvmmap(SPI_SLAVE, SPI_SLAVE, 0x1000, PTE_R | PTE_W);
    80020cc0:	4699                	li	a3,6
    80020cc2:	6605                	lui	a2,0x1
    80020cc4:	502405b7          	lui	a1,0x50240
    80020cc8:	50240537          	lui	a0,0x50240
    80020ccc:	00000097          	auipc	ra,0x0
    80020cd0:	f2e080e7          	jalr	-210(ra) # 80020bfa <kvmmap>
  kvmmap(FPIOA, FPIOA, 0x1000, PTE_R | PTE_W);
    80020cd4:	4699                	li	a3,6
    80020cd6:	6605                	lui	a2,0x1
    80020cd8:	502b05b7          	lui	a1,0x502b0
    80020cdc:	502b0537          	lui	a0,0x502b0
    80020ce0:	00000097          	auipc	ra,0x0
    80020ce4:	f1a080e7          	jalr	-230(ra) # 80020bfa <kvmmap>
  kvmmap(SPI0, SPI0, 0x1000, PTE_R | PTE_W);
    80020ce8:	4699                	li	a3,6
    80020cea:	6605                	lui	a2,0x1
    80020cec:	520005b7          	lui	a1,0x52000
    80020cf0:	52000537          	lui	a0,0x52000
    80020cf4:	00000097          	auipc	ra,0x0
    80020cf8:	f06080e7          	jalr	-250(ra) # 80020bfa <kvmmap>
  kvmmap(SPI1, SPI1, 0x1000, PTE_R | PTE_W);
    80020cfc:	4699                	li	a3,6
    80020cfe:	6605                	lui	a2,0x1
    80020d00:	530005b7          	lui	a1,0x53000
    80020d04:	53000537          	lui	a0,0x53000
    80020d08:	00000097          	auipc	ra,0x0
    80020d0c:	ef2080e7          	jalr	-270(ra) # 80020bfa <kvmmap>
  kvmmap(SPI2, SPI2, 0x1000, PTE_R | PTE_W);
    80020d10:	4699                	li	a3,6
    80020d12:	6605                	lui	a2,0x1
    80020d14:	540005b7          	lui	a1,0x54000
    80020d18:	54000537          	lui	a0,0x54000
    80020d1c:	00000097          	auipc	ra,0x0
    80020d20:	ede080e7          	jalr	-290(ra) # 80020bfa <kvmmap>
  kvmmap(RUSTSBI_BASE, RUSTSBI_BASE, KERNBASE - RUSTSBI_BASE, PTE_R | PTE_X);
    80020d24:	46a9                	li	a3,10
    80020d26:	00020637          	lui	a2,0x20
    80020d2a:	4585                	li	a1,1
    80020d2c:	05fe                	slli	a1,a1,0x1f
    80020d2e:	852e                	mv	a0,a1
    80020d30:	00000097          	auipc	ra,0x0
    80020d34:	eca080e7          	jalr	-310(ra) # 80020bfa <kvmmap>
  kvmmap(KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);
    80020d38:	00008497          	auipc	s1,0x8
    80020d3c:	2c848493          	addi	s1,s1,712 # 80029000 <etext>
    80020d40:	46a9                	li	a3,10
    80020d42:	fbfff637          	lui	a2,0xfbfff
    80020d46:	0616                	slli	a2,a2,0x5
    80020d48:	9626                	add	a2,a2,s1
    80020d4a:	040015b7          	lui	a1,0x4001
    80020d4e:	0596                	slli	a1,a1,0x5
    80020d50:	852e                	mv	a0,a1
    80020d52:	00000097          	auipc	ra,0x0
    80020d56:	ea8080e7          	jalr	-344(ra) # 80020bfa <kvmmap>
  kvmmap((uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext, PTE_R | PTE_W);
    80020d5a:	4699                	li	a3,6
    80020d5c:	40300613          	li	a2,1027
    80020d60:	0656                	slli	a2,a2,0x15
    80020d62:	8e05                	sub	a2,a2,s1
    80020d64:	85a6                	mv	a1,s1
    80020d66:	8526                	mv	a0,s1
    80020d68:	00000097          	auipc	ra,0x0
    80020d6c:	e92080e7          	jalr	-366(ra) # 80020bfa <kvmmap>
  kvmmap(TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80020d70:	46a9                	li	a3,10
    80020d72:	6605                	lui	a2,0x1
    80020d74:	00007597          	auipc	a1,0x7
    80020d78:	28c58593          	addi	a1,a1,652 # 80028000 <_trampoline>
    80020d7c:	04000537          	lui	a0,0x4000
    80020d80:	157d                	addi	a0,a0,-1
    80020d82:	0532                	slli	a0,a0,0xc
    80020d84:	00000097          	auipc	ra,0x0
    80020d88:	e76080e7          	jalr	-394(ra) # 80020bfa <kvmmap>
  printf("kvminit\n");
    80020d8c:	00008517          	auipc	a0,0x8
    80020d90:	37c50513          	addi	a0,a0,892 # 80029108 <etext+0x108>
    80020d94:	fffff097          	auipc	ra,0xfffff
    80020d98:	384080e7          	jalr	900(ra) # 80020118 <printf>
}
    80020d9c:	60e2                	ld	ra,24(sp)
    80020d9e:	6442                	ld	s0,16(sp)
    80020da0:	64a2                	ld	s1,8(sp)
    80020da2:	6105                	addi	sp,sp,32
    80020da4:	8082                	ret

0000000080020da6 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80020da6:	715d                	addi	sp,sp,-80
    80020da8:	e486                	sd	ra,72(sp)
    80020daa:	e0a2                	sd	s0,64(sp)
    80020dac:	fc26                	sd	s1,56(sp)
    80020dae:	f84a                	sd	s2,48(sp)
    80020db0:	f44e                	sd	s3,40(sp)
    80020db2:	f052                	sd	s4,32(sp)
    80020db4:	ec56                	sd	s5,24(sp)
    80020db6:	e85a                	sd	s6,16(sp)
    80020db8:	e45e                	sd	s7,8(sp)
    80020dba:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80020dbc:	03459793          	slli	a5,a1,0x34
    80020dc0:	e795                	bnez	a5,80020dec <uvmunmap+0x46>
    80020dc2:	8a2a                	mv	s4,a0
    80020dc4:	84ae                	mv	s1,a1
    80020dc6:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020dc8:	0632                	slli	a2,a2,0xc
    80020dca:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80020dce:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020dd0:	6b05                	lui	s6,0x1
    80020dd2:	0735e863          	bltu	a1,s3,80020e42 <uvmunmap+0x9c>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80020dd6:	60a6                	ld	ra,72(sp)
    80020dd8:	6406                	ld	s0,64(sp)
    80020dda:	74e2                	ld	s1,56(sp)
    80020ddc:	7942                	ld	s2,48(sp)
    80020dde:	79a2                	ld	s3,40(sp)
    80020de0:	7a02                	ld	s4,32(sp)
    80020de2:	6ae2                	ld	s5,24(sp)
    80020de4:	6b42                	ld	s6,16(sp)
    80020de6:	6ba2                	ld	s7,8(sp)
    80020de8:	6161                	addi	sp,sp,80
    80020dea:	8082                	ret
    panic("uvmunmap: not aligned");
    80020dec:	00008517          	auipc	a0,0x8
    80020df0:	32c50513          	addi	a0,a0,812 # 80029118 <etext+0x118>
    80020df4:	fffff097          	auipc	ra,0xfffff
    80020df8:	2e2080e7          	jalr	738(ra) # 800200d6 <panic>
      panic("uvmunmap: walk");
    80020dfc:	00008517          	auipc	a0,0x8
    80020e00:	33450513          	addi	a0,a0,820 # 80029130 <etext+0x130>
    80020e04:	fffff097          	auipc	ra,0xfffff
    80020e08:	2d2080e7          	jalr	722(ra) # 800200d6 <panic>
      panic("uvmunmap: not mapped");
    80020e0c:	00008517          	auipc	a0,0x8
    80020e10:	33450513          	addi	a0,a0,820 # 80029140 <etext+0x140>
    80020e14:	fffff097          	auipc	ra,0xfffff
    80020e18:	2c2080e7          	jalr	706(ra) # 800200d6 <panic>
      panic("uvmunmap: not a leaf");
    80020e1c:	00008517          	auipc	a0,0x8
    80020e20:	33c50513          	addi	a0,a0,828 # 80029158 <etext+0x158>
    80020e24:	fffff097          	auipc	ra,0xfffff
    80020e28:	2b2080e7          	jalr	690(ra) # 800200d6 <panic>
      uint64 pa = PTE2PA(*pte);
    80020e2c:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80020e2e:	0532                	slli	a0,a0,0xc
    80020e30:	fffff097          	auipc	ra,0xfffff
    80020e34:	50a080e7          	jalr	1290(ra) # 8002033a <kfree>
    *pte = 0;
    80020e38:	00093023          	sd	zero,0(s2)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80020e3c:	94da                	add	s1,s1,s6
    80020e3e:	f934fce3          	bgeu	s1,s3,80020dd6 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80020e42:	4601                	li	a2,0
    80020e44:	85a6                	mv	a1,s1
    80020e46:	8552                	mv	a0,s4
    80020e48:	00000097          	auipc	ra,0x0
    80020e4c:	bde080e7          	jalr	-1058(ra) # 80020a26 <walk>
    80020e50:	892a                	mv	s2,a0
    80020e52:	d54d                	beqz	a0,80020dfc <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    80020e54:	6108                	ld	a0,0(a0)
    80020e56:	00157793          	andi	a5,a0,1
    80020e5a:	dbcd                	beqz	a5,80020e0c <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    80020e5c:	3ff57793          	andi	a5,a0,1023
    80020e60:	fb778ee3          	beq	a5,s7,80020e1c <uvmunmap+0x76>
    if(do_free){
    80020e64:	fc0a8ae3          	beqz	s5,80020e38 <uvmunmap+0x92>
    80020e68:	b7d1                	j	80020e2c <uvmunmap+0x86>

0000000080020e6a <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80020e6a:	1101                	addi	sp,sp,-32
    80020e6c:	ec06                	sd	ra,24(sp)
    80020e6e:	e822                	sd	s0,16(sp)
    80020e70:	e426                	sd	s1,8(sp)
    80020e72:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80020e74:	fffff097          	auipc	ra,0xfffff
    80020e78:	5d8080e7          	jalr	1496(ra) # 8002044c <kalloc>
    80020e7c:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80020e7e:	c519                	beqz	a0,80020e8c <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80020e80:	6605                	lui	a2,0x1
    80020e82:	4581                	li	a1,0
    80020e84:	fffff097          	auipc	ra,0xfffff
    80020e88:	7b4080e7          	jalr	1972(ra) # 80020638 <memset>
  return pagetable;
}
    80020e8c:	8526                	mv	a0,s1
    80020e8e:	60e2                	ld	ra,24(sp)
    80020e90:	6442                	ld	s0,16(sp)
    80020e92:	64a2                	ld	s1,8(sp)
    80020e94:	6105                	addi	sp,sp,32
    80020e96:	8082                	ret

0000000080020e98 <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    80020e98:	7179                	addi	sp,sp,-48
    80020e9a:	f406                	sd	ra,40(sp)
    80020e9c:	f022                	sd	s0,32(sp)
    80020e9e:	ec26                	sd	s1,24(sp)
    80020ea0:	e84a                	sd	s2,16(sp)
    80020ea2:	e44e                	sd	s3,8(sp)
    80020ea4:	e052                	sd	s4,0(sp)
    80020ea6:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80020ea8:	6785                	lui	a5,0x1
    80020eaa:	04f67863          	bgeu	a2,a5,80020efa <uvminit+0x62>
    80020eae:	8a2a                	mv	s4,a0
    80020eb0:	89ae                	mv	s3,a1
    80020eb2:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    80020eb4:	fffff097          	auipc	ra,0xfffff
    80020eb8:	598080e7          	jalr	1432(ra) # 8002044c <kalloc>
    80020ebc:	892a                	mv	s2,a0
  // printf("[uvminit]kalloc: %p\n", mem);
  memset(mem, 0, PGSIZE);
    80020ebe:	6605                	lui	a2,0x1
    80020ec0:	4581                	li	a1,0
    80020ec2:	fffff097          	auipc	ra,0xfffff
    80020ec6:	776080e7          	jalr	1910(ra) # 80020638 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80020eca:	4779                	li	a4,30
    80020ecc:	86ca                	mv	a3,s2
    80020ece:	6605                	lui	a2,0x1
    80020ed0:	4581                	li	a1,0
    80020ed2:	8552                	mv	a0,s4
    80020ed4:	00000097          	auipc	ra,0x0
    80020ed8:	c9a080e7          	jalr	-870(ra) # 80020b6e <mappages>
  memmove(mem, src, sz);
    80020edc:	8626                	mv	a2,s1
    80020ede:	85ce                	mv	a1,s3
    80020ee0:	854a                	mv	a0,s2
    80020ee2:	fffff097          	auipc	ra,0xfffff
    80020ee6:	7c2080e7          	jalr	1986(ra) # 800206a4 <memmove>
  // for (int i = 0; i < sz; i ++) {
  //   printf("[uvminit]mem: %p, %x\n", mem + i, mem[i]);
  // }
}
    80020eea:	70a2                	ld	ra,40(sp)
    80020eec:	7402                	ld	s0,32(sp)
    80020eee:	64e2                	ld	s1,24(sp)
    80020ef0:	6942                	ld	s2,16(sp)
    80020ef2:	69a2                	ld	s3,8(sp)
    80020ef4:	6a02                	ld	s4,0(sp)
    80020ef6:	6145                	addi	sp,sp,48
    80020ef8:	8082                	ret
    panic("inituvm: more than a page");
    80020efa:	00008517          	auipc	a0,0x8
    80020efe:	27650513          	addi	a0,a0,630 # 80029170 <etext+0x170>
    80020f02:	fffff097          	auipc	ra,0xfffff
    80020f06:	1d4080e7          	jalr	468(ra) # 800200d6 <panic>

0000000080020f0a <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80020f0a:	1101                	addi	sp,sp,-32
    80020f0c:	ec06                	sd	ra,24(sp)
    80020f0e:	e822                	sd	s0,16(sp)
    80020f10:	e426                	sd	s1,8(sp)
    80020f12:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80020f14:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80020f16:	00b67d63          	bgeu	a2,a1,80020f30 <uvmdealloc+0x26>
    80020f1a:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80020f1c:	6605                	lui	a2,0x1
    80020f1e:	167d                	addi	a2,a2,-1
    80020f20:	00c487b3          	add	a5,s1,a2
    80020f24:	777d                	lui	a4,0xfffff
    80020f26:	8ff9                	and	a5,a5,a4
    80020f28:	962e                	add	a2,a2,a1
    80020f2a:	8e79                	and	a2,a2,a4
    80020f2c:	00c7e863          	bltu	a5,a2,80020f3c <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80020f30:	8526                	mv	a0,s1
    80020f32:	60e2                	ld	ra,24(sp)
    80020f34:	6442                	ld	s0,16(sp)
    80020f36:	64a2                	ld	s1,8(sp)
    80020f38:	6105                	addi	sp,sp,32
    80020f3a:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80020f3c:	8e1d                	sub	a2,a2,a5
    80020f3e:	8231                	srli	a2,a2,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80020f40:	4685                	li	a3,1
    80020f42:	2601                	sext.w	a2,a2
    80020f44:	85be                	mv	a1,a5
    80020f46:	00000097          	auipc	ra,0x0
    80020f4a:	e60080e7          	jalr	-416(ra) # 80020da6 <uvmunmap>
    80020f4e:	b7cd                	j	80020f30 <uvmdealloc+0x26>

0000000080020f50 <uvmalloc>:
  if(newsz < oldsz)
    80020f50:	0ab66163          	bltu	a2,a1,80020ff2 <uvmalloc+0xa2>
{
    80020f54:	7139                	addi	sp,sp,-64
    80020f56:	fc06                	sd	ra,56(sp)
    80020f58:	f822                	sd	s0,48(sp)
    80020f5a:	f426                	sd	s1,40(sp)
    80020f5c:	f04a                	sd	s2,32(sp)
    80020f5e:	ec4e                	sd	s3,24(sp)
    80020f60:	e852                	sd	s4,16(sp)
    80020f62:	e456                	sd	s5,8(sp)
    80020f64:	0080                	addi	s0,sp,64
  oldsz = PGROUNDUP(oldsz);
    80020f66:	6a05                	lui	s4,0x1
    80020f68:	1a7d                	addi	s4,s4,-1
    80020f6a:	95d2                	add	a1,a1,s4
    80020f6c:	7a7d                	lui	s4,0xfffff
    80020f6e:	0145fa33          	and	s4,a1,s4
  for(a = oldsz; a < newsz; a += PGSIZE){
    80020f72:	08ca7263          	bgeu	s4,a2,80020ff6 <uvmalloc+0xa6>
    80020f76:	89b2                	mv	s3,a2
    80020f78:	8aaa                	mv	s5,a0
    80020f7a:	8952                	mv	s2,s4
    mem = kalloc();
    80020f7c:	fffff097          	auipc	ra,0xfffff
    80020f80:	4d0080e7          	jalr	1232(ra) # 8002044c <kalloc>
    80020f84:	84aa                	mv	s1,a0
    if(mem == 0){
    80020f86:	c51d                	beqz	a0,80020fb4 <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    80020f88:	6605                	lui	a2,0x1
    80020f8a:	4581                	li	a1,0
    80020f8c:	fffff097          	auipc	ra,0xfffff
    80020f90:	6ac080e7          	jalr	1708(ra) # 80020638 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80020f94:	4779                	li	a4,30
    80020f96:	86a6                	mv	a3,s1
    80020f98:	6605                	lui	a2,0x1
    80020f9a:	85ca                	mv	a1,s2
    80020f9c:	8556                	mv	a0,s5
    80020f9e:	00000097          	auipc	ra,0x0
    80020fa2:	bd0080e7          	jalr	-1072(ra) # 80020b6e <mappages>
    80020fa6:	e905                	bnez	a0,80020fd6 <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80020fa8:	6785                	lui	a5,0x1
    80020faa:	993e                	add	s2,s2,a5
    80020fac:	fd3968e3          	bltu	s2,s3,80020f7c <uvmalloc+0x2c>
  return newsz;
    80020fb0:	854e                	mv	a0,s3
    80020fb2:	a809                	j	80020fc4 <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80020fb4:	8652                	mv	a2,s4
    80020fb6:	85ca                	mv	a1,s2
    80020fb8:	8556                	mv	a0,s5
    80020fba:	00000097          	auipc	ra,0x0
    80020fbe:	f50080e7          	jalr	-176(ra) # 80020f0a <uvmdealloc>
      return 0;
    80020fc2:	4501                	li	a0,0
}
    80020fc4:	70e2                	ld	ra,56(sp)
    80020fc6:	7442                	ld	s0,48(sp)
    80020fc8:	74a2                	ld	s1,40(sp)
    80020fca:	7902                	ld	s2,32(sp)
    80020fcc:	69e2                	ld	s3,24(sp)
    80020fce:	6a42                	ld	s4,16(sp)
    80020fd0:	6aa2                	ld	s5,8(sp)
    80020fd2:	6121                	addi	sp,sp,64
    80020fd4:	8082                	ret
      kfree(mem);
    80020fd6:	8526                	mv	a0,s1
    80020fd8:	fffff097          	auipc	ra,0xfffff
    80020fdc:	362080e7          	jalr	866(ra) # 8002033a <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80020fe0:	8652                	mv	a2,s4
    80020fe2:	85ca                	mv	a1,s2
    80020fe4:	8556                	mv	a0,s5
    80020fe6:	00000097          	auipc	ra,0x0
    80020fea:	f24080e7          	jalr	-220(ra) # 80020f0a <uvmdealloc>
      return 0;
    80020fee:	4501                	li	a0,0
    80020ff0:	bfd1                	j	80020fc4 <uvmalloc+0x74>
    return oldsz;
    80020ff2:	852e                	mv	a0,a1
}
    80020ff4:	8082                	ret
  return newsz;
    80020ff6:	8532                	mv	a0,a2
    80020ff8:	b7f1                	j	80020fc4 <uvmalloc+0x74>

0000000080020ffa <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80020ffa:	7179                	addi	sp,sp,-48
    80020ffc:	f406                	sd	ra,40(sp)
    80020ffe:	f022                	sd	s0,32(sp)
    80021000:	ec26                	sd	s1,24(sp)
    80021002:	e84a                	sd	s2,16(sp)
    80021004:	e44e                	sd	s3,8(sp)
    80021006:	e052                	sd	s4,0(sp)
    80021008:	1800                	addi	s0,sp,48
    8002100a:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    8002100c:	84aa                	mv	s1,a0
    8002100e:	6905                	lui	s2,0x1
    80021010:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80021012:	4985                	li	s3,1
    80021014:	a821                	j	8002102c <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80021016:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    80021018:	0532                	slli	a0,a0,0xc
    8002101a:	00000097          	auipc	ra,0x0
    8002101e:	fe0080e7          	jalr	-32(ra) # 80020ffa <freewalk>
      pagetable[i] = 0;
    80021022:	0004b023          	sd	zero,0(s1)
    80021026:	04a1                	addi	s1,s1,8
  for(int i = 0; i < 512; i++){
    80021028:	03248163          	beq	s1,s2,8002104a <freewalk+0x50>
    pte_t pte = pagetable[i];
    8002102c:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8002102e:	00f57793          	andi	a5,a0,15
    80021032:	ff3782e3          	beq	a5,s3,80021016 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80021036:	8905                	andi	a0,a0,1
    80021038:	d57d                	beqz	a0,80021026 <freewalk+0x2c>
      panic("freewalk: leaf");
    8002103a:	00008517          	auipc	a0,0x8
    8002103e:	15650513          	addi	a0,a0,342 # 80029190 <etext+0x190>
    80021042:	fffff097          	auipc	ra,0xfffff
    80021046:	094080e7          	jalr	148(ra) # 800200d6 <panic>
    }
  }
  kfree((void*)pagetable);
    8002104a:	8552                	mv	a0,s4
    8002104c:	fffff097          	auipc	ra,0xfffff
    80021050:	2ee080e7          	jalr	750(ra) # 8002033a <kfree>
}
    80021054:	70a2                	ld	ra,40(sp)
    80021056:	7402                	ld	s0,32(sp)
    80021058:	64e2                	ld	s1,24(sp)
    8002105a:	6942                	ld	s2,16(sp)
    8002105c:	69a2                	ld	s3,8(sp)
    8002105e:	6a02                	ld	s4,0(sp)
    80021060:	6145                	addi	sp,sp,48
    80021062:	8082                	ret

0000000080021064 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80021064:	1101                	addi	sp,sp,-32
    80021066:	ec06                	sd	ra,24(sp)
    80021068:	e822                	sd	s0,16(sp)
    8002106a:	e426                	sd	s1,8(sp)
    8002106c:	1000                	addi	s0,sp,32
    8002106e:	84aa                	mv	s1,a0
  if(sz > 0)
    80021070:	e999                	bnez	a1,80021086 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80021072:	8526                	mv	a0,s1
    80021074:	00000097          	auipc	ra,0x0
    80021078:	f86080e7          	jalr	-122(ra) # 80020ffa <freewalk>
}
    8002107c:	60e2                	ld	ra,24(sp)
    8002107e:	6442                	ld	s0,16(sp)
    80021080:	64a2                	ld	s1,8(sp)
    80021082:	6105                	addi	sp,sp,32
    80021084:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80021086:	6605                	lui	a2,0x1
    80021088:	167d                	addi	a2,a2,-1
    8002108a:	962e                	add	a2,a2,a1
    8002108c:	4685                	li	a3,1
    8002108e:	8231                	srli	a2,a2,0xc
    80021090:	4581                	li	a1,0
    80021092:	00000097          	auipc	ra,0x0
    80021096:	d14080e7          	jalr	-748(ra) # 80020da6 <uvmunmap>
    8002109a:	bfe1                	j	80021072 <uvmfree+0xe>

000000008002109c <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    8002109c:	c679                	beqz	a2,8002116a <uvmcopy+0xce>
{
    8002109e:	715d                	addi	sp,sp,-80
    800210a0:	e486                	sd	ra,72(sp)
    800210a2:	e0a2                	sd	s0,64(sp)
    800210a4:	fc26                	sd	s1,56(sp)
    800210a6:	f84a                	sd	s2,48(sp)
    800210a8:	f44e                	sd	s3,40(sp)
    800210aa:	f052                	sd	s4,32(sp)
    800210ac:	ec56                	sd	s5,24(sp)
    800210ae:	e85a                	sd	s6,16(sp)
    800210b0:	e45e                	sd	s7,8(sp)
    800210b2:	0880                	addi	s0,sp,80
    800210b4:	8ab2                	mv	s5,a2
    800210b6:	8b2e                	mv	s6,a1
    800210b8:	8baa                	mv	s7,a0
  for(i = 0; i < sz; i += PGSIZE){
    800210ba:	4901                	li	s2,0
    if((pte = walk(old, i, 0)) == 0)
    800210bc:	4601                	li	a2,0
    800210be:	85ca                	mv	a1,s2
    800210c0:	855e                	mv	a0,s7
    800210c2:	00000097          	auipc	ra,0x0
    800210c6:	964080e7          	jalr	-1692(ra) # 80020a26 <walk>
    800210ca:	c531                	beqz	a0,80021116 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    800210cc:	6118                	ld	a4,0(a0)
    800210ce:	00177793          	andi	a5,a4,1
    800210d2:	cbb1                	beqz	a5,80021126 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    800210d4:	00a75593          	srli	a1,a4,0xa
    800210d8:	00c59993          	slli	s3,a1,0xc
    flags = PTE_FLAGS(*pte);
    800210dc:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    800210e0:	fffff097          	auipc	ra,0xfffff
    800210e4:	36c080e7          	jalr	876(ra) # 8002044c <kalloc>
    800210e8:	8a2a                	mv	s4,a0
    800210ea:	c939                	beqz	a0,80021140 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800210ec:	6605                	lui	a2,0x1
    800210ee:	85ce                	mv	a1,s3
    800210f0:	fffff097          	auipc	ra,0xfffff
    800210f4:	5b4080e7          	jalr	1460(ra) # 800206a4 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800210f8:	8726                	mv	a4,s1
    800210fa:	86d2                	mv	a3,s4
    800210fc:	6605                	lui	a2,0x1
    800210fe:	85ca                	mv	a1,s2
    80021100:	855a                	mv	a0,s6
    80021102:	00000097          	auipc	ra,0x0
    80021106:	a6c080e7          	jalr	-1428(ra) # 80020b6e <mappages>
    8002110a:	e515                	bnez	a0,80021136 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    8002110c:	6785                	lui	a5,0x1
    8002110e:	993e                	add	s2,s2,a5
    80021110:	fb5966e3          	bltu	s2,s5,800210bc <uvmcopy+0x20>
    80021114:	a081                	j	80021154 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80021116:	00008517          	auipc	a0,0x8
    8002111a:	08a50513          	addi	a0,a0,138 # 800291a0 <etext+0x1a0>
    8002111e:	fffff097          	auipc	ra,0xfffff
    80021122:	fb8080e7          	jalr	-72(ra) # 800200d6 <panic>
      panic("uvmcopy: page not present");
    80021126:	00008517          	auipc	a0,0x8
    8002112a:	09a50513          	addi	a0,a0,154 # 800291c0 <etext+0x1c0>
    8002112e:	fffff097          	auipc	ra,0xfffff
    80021132:	fa8080e7          	jalr	-88(ra) # 800200d6 <panic>
      kfree(mem);
    80021136:	8552                	mv	a0,s4
    80021138:	fffff097          	auipc	ra,0xfffff
    8002113c:	202080e7          	jalr	514(ra) # 8002033a <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80021140:	4685                	li	a3,1
    80021142:	00c95613          	srli	a2,s2,0xc
    80021146:	4581                	li	a1,0
    80021148:	855a                	mv	a0,s6
    8002114a:	00000097          	auipc	ra,0x0
    8002114e:	c5c080e7          	jalr	-932(ra) # 80020da6 <uvmunmap>
  return -1;
    80021152:	557d                	li	a0,-1
}
    80021154:	60a6                	ld	ra,72(sp)
    80021156:	6406                	ld	s0,64(sp)
    80021158:	74e2                	ld	s1,56(sp)
    8002115a:	7942                	ld	s2,48(sp)
    8002115c:	79a2                	ld	s3,40(sp)
    8002115e:	7a02                	ld	s4,32(sp)
    80021160:	6ae2                	ld	s5,24(sp)
    80021162:	6b42                	ld	s6,16(sp)
    80021164:	6ba2                	ld	s7,8(sp)
    80021166:	6161                	addi	sp,sp,80
    80021168:	8082                	ret
  return 0;
    8002116a:	4501                	li	a0,0
}
    8002116c:	8082                	ret

000000008002116e <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8002116e:	1141                	addi	sp,sp,-16
    80021170:	e406                	sd	ra,8(sp)
    80021172:	e022                	sd	s0,0(sp)
    80021174:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80021176:	4601                	li	a2,0
    80021178:	00000097          	auipc	ra,0x0
    8002117c:	8ae080e7          	jalr	-1874(ra) # 80020a26 <walk>
  if(pte == 0)
    80021180:	c901                	beqz	a0,80021190 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80021182:	611c                	ld	a5,0(a0)
    80021184:	9bbd                	andi	a5,a5,-17
    80021186:	e11c                	sd	a5,0(a0)
}
    80021188:	60a2                	ld	ra,8(sp)
    8002118a:	6402                	ld	s0,0(sp)
    8002118c:	0141                	addi	sp,sp,16
    8002118e:	8082                	ret
    panic("uvmclear");
    80021190:	00008517          	auipc	a0,0x8
    80021194:	05050513          	addi	a0,a0,80 # 800291e0 <etext+0x1e0>
    80021198:	fffff097          	auipc	ra,0xfffff
    8002119c:	f3e080e7          	jalr	-194(ra) # 800200d6 <panic>

00000000800211a0 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800211a0:	c6bd                	beqz	a3,8002120e <copyout+0x6e>
{
    800211a2:	715d                	addi	sp,sp,-80
    800211a4:	e486                	sd	ra,72(sp)
    800211a6:	e0a2                	sd	s0,64(sp)
    800211a8:	fc26                	sd	s1,56(sp)
    800211aa:	f84a                	sd	s2,48(sp)
    800211ac:	f44e                	sd	s3,40(sp)
    800211ae:	f052                	sd	s4,32(sp)
    800211b0:	ec56                	sd	s5,24(sp)
    800211b2:	e85a                	sd	s6,16(sp)
    800211b4:	e45e                	sd	s7,8(sp)
    800211b6:	e062                	sd	s8,0(sp)
    800211b8:	0880                	addi	s0,sp,80
    800211ba:	8baa                	mv	s7,a0
    800211bc:	8a2e                	mv	s4,a1
    800211be:	8ab2                	mv	s5,a2
    800211c0:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    800211c2:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    800211c4:	6b05                	lui	s6,0x1
    800211c6:	a015                	j	800211ea <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    800211c8:	9552                	add	a0,a0,s4
    800211ca:	0004861b          	sext.w	a2,s1
    800211ce:	85d6                	mv	a1,s5
    800211d0:	41250533          	sub	a0,a0,s2
    800211d4:	fffff097          	auipc	ra,0xfffff
    800211d8:	4d0080e7          	jalr	1232(ra) # 800206a4 <memmove>

    len -= n;
    800211dc:	409989b3          	sub	s3,s3,s1
    src += n;
    800211e0:	9aa6                	add	s5,s5,s1
    dstva = va0 + PGSIZE;
    800211e2:	01690a33          	add	s4,s2,s6
  while(len > 0){
    800211e6:	02098263          	beqz	s3,8002120a <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    800211ea:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    800211ee:	85ca                	mv	a1,s2
    800211f0:	855e                	mv	a0,s7
    800211f2:	00000097          	auipc	ra,0x0
    800211f6:	8da080e7          	jalr	-1830(ra) # 80020acc <walkaddr>
    if(pa0 == 0)
    800211fa:	cd01                	beqz	a0,80021212 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    800211fc:	414904b3          	sub	s1,s2,s4
    80021200:	94da                	add	s1,s1,s6
    if(n > len)
    80021202:	fc99f3e3          	bgeu	s3,s1,800211c8 <copyout+0x28>
    80021206:	84ce                	mv	s1,s3
    80021208:	b7c1                	j	800211c8 <copyout+0x28>
  }
  return 0;
    8002120a:	4501                	li	a0,0
    8002120c:	a021                	j	80021214 <copyout+0x74>
    8002120e:	4501                	li	a0,0
}
    80021210:	8082                	ret
      return -1;
    80021212:	557d                	li	a0,-1
}
    80021214:	60a6                	ld	ra,72(sp)
    80021216:	6406                	ld	s0,64(sp)
    80021218:	74e2                	ld	s1,56(sp)
    8002121a:	7942                	ld	s2,48(sp)
    8002121c:	79a2                	ld	s3,40(sp)
    8002121e:	7a02                	ld	s4,32(sp)
    80021220:	6ae2                	ld	s5,24(sp)
    80021222:	6b42                	ld	s6,16(sp)
    80021224:	6ba2                	ld	s7,8(sp)
    80021226:	6c02                	ld	s8,0(sp)
    80021228:	6161                	addi	sp,sp,80
    8002122a:	8082                	ret

000000008002122c <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    8002122c:	caa5                	beqz	a3,8002129c <copyin+0x70>
{
    8002122e:	715d                	addi	sp,sp,-80
    80021230:	e486                	sd	ra,72(sp)
    80021232:	e0a2                	sd	s0,64(sp)
    80021234:	fc26                	sd	s1,56(sp)
    80021236:	f84a                	sd	s2,48(sp)
    80021238:	f44e                	sd	s3,40(sp)
    8002123a:	f052                	sd	s4,32(sp)
    8002123c:	ec56                	sd	s5,24(sp)
    8002123e:	e85a                	sd	s6,16(sp)
    80021240:	e45e                	sd	s7,8(sp)
    80021242:	e062                	sd	s8,0(sp)
    80021244:	0880                	addi	s0,sp,80
    80021246:	8baa                	mv	s7,a0
    80021248:	8aae                	mv	s5,a1
    8002124a:	8a32                	mv	s4,a2
    8002124c:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    8002124e:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80021250:	6b05                	lui	s6,0x1
    80021252:	a01d                	j	80021278 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80021254:	014505b3          	add	a1,a0,s4
    80021258:	0004861b          	sext.w	a2,s1
    8002125c:	412585b3          	sub	a1,a1,s2
    80021260:	8556                	mv	a0,s5
    80021262:	fffff097          	auipc	ra,0xfffff
    80021266:	442080e7          	jalr	1090(ra) # 800206a4 <memmove>

    len -= n;
    8002126a:	409989b3          	sub	s3,s3,s1
    dst += n;
    8002126e:	9aa6                	add	s5,s5,s1
    srcva = va0 + PGSIZE;
    80021270:	01690a33          	add	s4,s2,s6
  while(len > 0){
    80021274:	02098263          	beqz	s3,80021298 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80021278:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    8002127c:	85ca                	mv	a1,s2
    8002127e:	855e                	mv	a0,s7
    80021280:	00000097          	auipc	ra,0x0
    80021284:	84c080e7          	jalr	-1972(ra) # 80020acc <walkaddr>
    if(pa0 == 0)
    80021288:	cd01                	beqz	a0,800212a0 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    8002128a:	414904b3          	sub	s1,s2,s4
    8002128e:	94da                	add	s1,s1,s6
    if(n > len)
    80021290:	fc99f2e3          	bgeu	s3,s1,80021254 <copyin+0x28>
    80021294:	84ce                	mv	s1,s3
    80021296:	bf7d                	j	80021254 <copyin+0x28>
  }
  return 0;
    80021298:	4501                	li	a0,0
    8002129a:	a021                	j	800212a2 <copyin+0x76>
    8002129c:	4501                	li	a0,0
}
    8002129e:	8082                	ret
      return -1;
    800212a0:	557d                	li	a0,-1
}
    800212a2:	60a6                	ld	ra,72(sp)
    800212a4:	6406                	ld	s0,64(sp)
    800212a6:	74e2                	ld	s1,56(sp)
    800212a8:	7942                	ld	s2,48(sp)
    800212aa:	79a2                	ld	s3,40(sp)
    800212ac:	7a02                	ld	s4,32(sp)
    800212ae:	6ae2                	ld	s5,24(sp)
    800212b0:	6b42                	ld	s6,16(sp)
    800212b2:	6ba2                	ld	s7,8(sp)
    800212b4:	6c02                	ld	s8,0(sp)
    800212b6:	6161                	addi	sp,sp,80
    800212b8:	8082                	ret

00000000800212ba <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    800212ba:	cecd                	beqz	a3,80021374 <copyinstr+0xba>
{
    800212bc:	715d                	addi	sp,sp,-80
    800212be:	e486                	sd	ra,72(sp)
    800212c0:	e0a2                	sd	s0,64(sp)
    800212c2:	fc26                	sd	s1,56(sp)
    800212c4:	f84a                	sd	s2,48(sp)
    800212c6:	f44e                	sd	s3,40(sp)
    800212c8:	f052                	sd	s4,32(sp)
    800212ca:	ec56                	sd	s5,24(sp)
    800212cc:	e85a                	sd	s6,16(sp)
    800212ce:	e45e                	sd	s7,8(sp)
    800212d0:	e062                	sd	s8,0(sp)
    800212d2:	0880                	addi	s0,sp,80
    800212d4:	8aaa                	mv	s5,a0
    800212d6:	84ae                	mv	s1,a1
    800212d8:	8c32                	mv	s8,a2
    800212da:	8bb6                	mv	s7,a3
    va0 = PGROUNDDOWN(srcva);
    800212dc:	7a7d                	lui	s4,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    800212de:	6985                	lui	s3,0x1
    800212e0:	4b05                	li	s6,1
    800212e2:	a801                	j	800212f2 <copyinstr+0x38>
    if(n > max)
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
    800212e4:	87a6                	mv	a5,s1
    800212e6:	a085                	j	80021346 <copyinstr+0x8c>
        *dst = *p;
      }
      --n;
      --max;
      p++;
      dst++;
    800212e8:	84b2                	mv	s1,a2
    }

    srcva = va0 + PGSIZE;
    800212ea:	01390c33          	add	s8,s2,s3
  while(got_null == 0 && max > 0){
    800212ee:	060b8f63          	beqz	s7,8002136c <copyinstr+0xb2>
    va0 = PGROUNDDOWN(srcva);
    800212f2:	014c7933          	and	s2,s8,s4
    pa0 = walkaddr(pagetable, va0);
    800212f6:	85ca                	mv	a1,s2
    800212f8:	8556                	mv	a0,s5
    800212fa:	fffff097          	auipc	ra,0xfffff
    800212fe:	7d2080e7          	jalr	2002(ra) # 80020acc <walkaddr>
    if(pa0 == 0)
    80021302:	c53d                	beqz	a0,80021370 <copyinstr+0xb6>
    n = PGSIZE - (srcva - va0);
    80021304:	41890633          	sub	a2,s2,s8
    80021308:	964e                	add	a2,a2,s3
    if(n > max)
    8002130a:	00cbf363          	bgeu	s7,a2,80021310 <copyinstr+0x56>
    8002130e:	865e                	mv	a2,s7
    char *p = (char *) (pa0 + (srcva - va0));
    80021310:	9562                	add	a0,a0,s8
    80021312:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80021316:	da71                	beqz	a2,800212ea <copyinstr+0x30>
      if(*p == '\0'){
    80021318:	00054703          	lbu	a4,0(a0)
    8002131c:	d761                	beqz	a4,800212e4 <copyinstr+0x2a>
    8002131e:	9626                	add	a2,a2,s1
    80021320:	87a6                	mv	a5,s1
    80021322:	1bfd                	addi	s7,s7,-1
    80021324:	009b86b3          	add	a3,s7,s1
    80021328:	409b04b3          	sub	s1,s6,s1
    8002132c:	94aa                	add	s1,s1,a0
        *dst = *p;
    8002132e:	00e78023          	sb	a4,0(a5) # 1000 <BASE_ADDRESS-0x8001f000>
      --max;
    80021332:	40f68bb3          	sub	s7,a3,a5
      p++;
    80021336:	00f48733          	add	a4,s1,a5
      dst++;
    8002133a:	0785                	addi	a5,a5,1
    while(n > 0){
    8002133c:	faf606e3          	beq	a2,a5,800212e8 <copyinstr+0x2e>
      if(*p == '\0'){
    80021340:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <kernel_end+0xffffffff7ffbf000>
    80021344:	f76d                	bnez	a4,8002132e <copyinstr+0x74>
        *dst = '\0';
    80021346:	00078023          	sb	zero,0(a5)
    8002134a:	4785                	li	a5,1
  }
  if(got_null){
    8002134c:	0017b793          	seqz	a5,a5
    80021350:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80021354:	60a6                	ld	ra,72(sp)
    80021356:	6406                	ld	s0,64(sp)
    80021358:	74e2                	ld	s1,56(sp)
    8002135a:	7942                	ld	s2,48(sp)
    8002135c:	79a2                	ld	s3,40(sp)
    8002135e:	7a02                	ld	s4,32(sp)
    80021360:	6ae2                	ld	s5,24(sp)
    80021362:	6b42                	ld	s6,16(sp)
    80021364:	6ba2                	ld	s7,8(sp)
    80021366:	6c02                	ld	s8,0(sp)
    80021368:	6161                	addi	sp,sp,80
    8002136a:	8082                	ret
    8002136c:	4781                	li	a5,0
    8002136e:	bff9                	j	8002134c <copyinstr+0x92>
      return -1;
    80021370:	557d                	li	a0,-1
    80021372:	b7cd                	j	80021354 <copyinstr+0x9a>
  int got_null = 0;
    80021374:	4781                	li	a5,0
  if(got_null){
    80021376:	0017b793          	seqz	a5,a5
    8002137a:	40f00533          	neg	a0,a5
}
    8002137e:	8082                	ret

0000000080021380 <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    80021380:	1101                	addi	sp,sp,-32
    80021382:	ec06                	sd	ra,24(sp)
    80021384:	e822                	sd	s0,16(sp)
    80021386:	e426                	sd	s1,8(sp)
    80021388:	1000                	addi	s0,sp,32
    8002138a:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8002138c:	fffff097          	auipc	ra,0xfffff
    80021390:	136080e7          	jalr	310(ra) # 800204c2 <holding>
    80021394:	c909                	beqz	a0,800213a6 <wakeup1+0x26>
    panic("wakeup1");
  if(p->chan == p && p->state == SLEEPING) {
    80021396:	749c                	ld	a5,40(s1)
    80021398:	00978f63          	beq	a5,s1,800213b6 <wakeup1+0x36>
    p->state = RUNNABLE;
  }
}
    8002139c:	60e2                	ld	ra,24(sp)
    8002139e:	6442                	ld	s0,16(sp)
    800213a0:	64a2                	ld	s1,8(sp)
    800213a2:	6105                	addi	sp,sp,32
    800213a4:	8082                	ret
    panic("wakeup1");
    800213a6:	00008517          	auipc	a0,0x8
    800213aa:	e7250513          	addi	a0,a0,-398 # 80029218 <states.1805+0x28>
    800213ae:	fffff097          	auipc	ra,0xfffff
    800213b2:	d28080e7          	jalr	-728(ra) # 800200d6 <panic>
  if(p->chan == p && p->state == SLEEPING) {
    800213b6:	4c98                	lw	a4,24(s1)
    800213b8:	4785                	li	a5,1
    800213ba:	fef711e3          	bne	a4,a5,8002139c <wakeup1+0x1c>
    p->state = RUNNABLE;
    800213be:	4789                	li	a5,2
    800213c0:	cc9c                	sw	a5,24(s1)
}
    800213c2:	bfe9                	j	8002139c <wakeup1+0x1c>

00000000800213c4 <reg_info>:
void reg_info(void) {
    800213c4:	1141                	addi	sp,sp,-16
    800213c6:	e406                	sd	ra,8(sp)
    800213c8:	e022                	sd	s0,0(sp)
    800213ca:	0800                	addi	s0,sp,16
  printf("register info: {\n");
    800213cc:	00008517          	auipc	a0,0x8
    800213d0:	e5450513          	addi	a0,a0,-428 # 80029220 <states.1805+0x30>
    800213d4:	fffff097          	auipc	ra,0xfffff
    800213d8:	d44080e7          	jalr	-700(ra) # 80020118 <printf>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800213dc:	100025f3          	csrr	a1,sstatus
  printf("sstatus: %p\n", r_sstatus());
    800213e0:	00008517          	auipc	a0,0x8
    800213e4:	e5850513          	addi	a0,a0,-424 # 80029238 <states.1805+0x48>
    800213e8:	fffff097          	auipc	ra,0xfffff
    800213ec:	d30080e7          	jalr	-720(ra) # 80020118 <printf>
  asm volatile("csrr %0, sip" : "=r" (x) );
    800213f0:	144025f3          	csrr	a1,sip
  printf("sip: %p\n", r_sip());
    800213f4:	00008517          	auipc	a0,0x8
    800213f8:	e5450513          	addi	a0,a0,-428 # 80029248 <states.1805+0x58>
    800213fc:	fffff097          	auipc	ra,0xfffff
    80021400:	d1c080e7          	jalr	-740(ra) # 80020118 <printf>
  asm volatile("csrr %0, sie" : "=r" (x) );
    80021404:	104025f3          	csrr	a1,sie
  printf("sie: %p\n", r_sie());
    80021408:	00008517          	auipc	a0,0x8
    8002140c:	e5050513          	addi	a0,a0,-432 # 80029258 <states.1805+0x68>
    80021410:	fffff097          	auipc	ra,0xfffff
    80021414:	d08080e7          	jalr	-760(ra) # 80020118 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80021418:	141025f3          	csrr	a1,sepc
  printf("sepc: %p\n", r_sepc());
    8002141c:	00008517          	auipc	a0,0x8
    80021420:	e4c50513          	addi	a0,a0,-436 # 80029268 <states.1805+0x78>
    80021424:	fffff097          	auipc	ra,0xfffff
    80021428:	cf4080e7          	jalr	-780(ra) # 80020118 <printf>
  asm volatile("csrr %0, stvec" : "=r" (x) );
    8002142c:	105025f3          	csrr	a1,stvec
  printf("stvec: %p\n", r_stvec());
    80021430:	00008517          	auipc	a0,0x8
    80021434:	e4850513          	addi	a0,a0,-440 # 80029278 <states.1805+0x88>
    80021438:	fffff097          	auipc	ra,0xfffff
    8002143c:	ce0080e7          	jalr	-800(ra) # 80020118 <printf>
  asm volatile("csrr %0, satp" : "=r" (x) );
    80021440:	180025f3          	csrr	a1,satp
  printf("satp: %p\n", r_satp());
    80021444:	00008517          	auipc	a0,0x8
    80021448:	e4450513          	addi	a0,a0,-444 # 80029288 <states.1805+0x98>
    8002144c:	fffff097          	auipc	ra,0xfffff
    80021450:	ccc080e7          	jalr	-820(ra) # 80020118 <printf>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80021454:	142025f3          	csrr	a1,scause
  printf("scause: %p\n", r_scause());
    80021458:	00008517          	auipc	a0,0x8
    8002145c:	e4050513          	addi	a0,a0,-448 # 80029298 <states.1805+0xa8>
    80021460:	fffff097          	auipc	ra,0xfffff
    80021464:	cb8080e7          	jalr	-840(ra) # 80020118 <printf>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80021468:	143025f3          	csrr	a1,stval
  printf("stval: %p\n", r_stval());
    8002146c:	00008517          	auipc	a0,0x8
    80021470:	e3c50513          	addi	a0,a0,-452 # 800292a8 <states.1805+0xb8>
    80021474:	fffff097          	auipc	ra,0xfffff
    80021478:	ca4080e7          	jalr	-860(ra) # 80020118 <printf>
  asm volatile("mv %0, sp" : "=r" (x) );
    8002147c:	858a                	mv	a1,sp
  printf("sp: %p\n", r_sp());
    8002147e:	00008517          	auipc	a0,0x8
    80021482:	e3a50513          	addi	a0,a0,-454 # 800292b8 <states.1805+0xc8>
    80021486:	fffff097          	auipc	ra,0xfffff
    8002148a:	c92080e7          	jalr	-878(ra) # 80020118 <printf>
  asm volatile("mv %0, tp" : "=r" (x) );
    8002148e:	8592                	mv	a1,tp
  printf("tp: %p\n", r_tp());
    80021490:	00008517          	auipc	a0,0x8
    80021494:	e3050513          	addi	a0,a0,-464 # 800292c0 <states.1805+0xd0>
    80021498:	fffff097          	auipc	ra,0xfffff
    8002149c:	c80080e7          	jalr	-896(ra) # 80020118 <printf>
  asm volatile("mv %0, ra" : "=r" (x) );
    800214a0:	8586                	mv	a1,ra
  printf("ra: %p\n", r_ra());
    800214a2:	00008517          	auipc	a0,0x8
    800214a6:	e2650513          	addi	a0,a0,-474 # 800292c8 <states.1805+0xd8>
    800214aa:	fffff097          	auipc	ra,0xfffff
    800214ae:	c6e080e7          	jalr	-914(ra) # 80020118 <printf>
  printf("}\n");
    800214b2:	00008517          	auipc	a0,0x8
    800214b6:	e1e50513          	addi	a0,a0,-482 # 800292d0 <states.1805+0xe0>
    800214ba:	fffff097          	auipc	ra,0xfffff
    800214be:	c5e080e7          	jalr	-930(ra) # 80020118 <printf>
}
    800214c2:	60a2                	ld	ra,8(sp)
    800214c4:	6402                	ld	s0,0(sp)
    800214c6:	0141                	addi	sp,sp,16
    800214c8:	8082                	ret

00000000800214ca <procinit>:
{
    800214ca:	715d                	addi	sp,sp,-80
    800214cc:	e486                	sd	ra,72(sp)
    800214ce:	e0a2                	sd	s0,64(sp)
    800214d0:	fc26                	sd	s1,56(sp)
    800214d2:	f84a                	sd	s2,48(sp)
    800214d4:	f44e                	sd	s3,40(sp)
    800214d6:	f052                	sd	s4,32(sp)
    800214d8:	ec56                	sd	s5,24(sp)
    800214da:	e85a                	sd	s6,16(sp)
    800214dc:	e45e                	sd	s7,8(sp)
    800214de:	0880                	addi	s0,sp,80
  initlock(&pid_lock, "nextpid");
    800214e0:	00008597          	auipc	a1,0x8
    800214e4:	df858593          	addi	a1,a1,-520 # 800292d8 <states.1805+0xe8>
    800214e8:	00013517          	auipc	a0,0x13
    800214ec:	b7050513          	addi	a0,a0,-1168 # 80034058 <pid_lock>
    800214f0:	fffff097          	auipc	ra,0xfffff
    800214f4:	fbc080e7          	jalr	-68(ra) # 800204ac <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    800214f8:	00013917          	auipc	s2,0x13
    800214fc:	c7890913          	addi	s2,s2,-904 # 80034170 <proc>
      initlock(&p->lock, "proc");
    80021500:	00008a17          	auipc	s4,0x8
    80021504:	de0a0a13          	addi	s4,s4,-544 # 800292e0 <states.1805+0xf0>
      uint64 va = KSTACK((int) (p - proc));
    80021508:	8bca                	mv	s7,s2
    8002150a:	00009b17          	auipc	s6,0x9
    8002150e:	d0eb0b13          	addi	s6,s6,-754 # 8002a218 <erodata>
    80021512:	040009b7          	lui	s3,0x4000
    80021516:	19fd                	addi	s3,s3,-1
    80021518:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    8002151a:	00014a97          	auipc	s5,0x14
    8002151e:	2d6a8a93          	addi	s5,s5,726 # 800357f0 <initproc>
      initlock(&p->lock, "proc");
    80021522:	85d2                	mv	a1,s4
    80021524:	854a                	mv	a0,s2
    80021526:	fffff097          	auipc	ra,0xfffff
    8002152a:	f86080e7          	jalr	-122(ra) # 800204ac <initlock>
      char *pa = kalloc();
    8002152e:	fffff097          	auipc	ra,0xfffff
    80021532:	f1e080e7          	jalr	-226(ra) # 8002044c <kalloc>
      if(pa == 0)
    80021536:	c135                	beqz	a0,8002159a <procinit+0xd0>
      uint64 va = KSTACK((int) (p - proc));
    80021538:	417904b3          	sub	s1,s2,s7
    8002153c:	848d                	srai	s1,s1,0x3
    8002153e:	000b3783          	ld	a5,0(s6)
    80021542:	02f484b3          	mul	s1,s1,a5
    80021546:	2485                	addiw	s1,s1,1
    80021548:	00d4949b          	slliw	s1,s1,0xd
    8002154c:	409984b3          	sub	s1,s3,s1
      kvmmap(va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80021550:	4699                	li	a3,6
    80021552:	6605                	lui	a2,0x1
    80021554:	85aa                	mv	a1,a0
    80021556:	8526                	mv	a0,s1
    80021558:	fffff097          	auipc	ra,0xfffff
    8002155c:	6a2080e7          	jalr	1698(ra) # 80020bfa <kvmmap>
      p->kstack = va;
    80021560:	04993023          	sd	s1,64(s2)
  for(p = proc; p < &proc[NPROC]; p++) {
    80021564:	16890913          	addi	s2,s2,360
    80021568:	fb591de3          	bne	s2,s5,80021522 <procinit+0x58>
  kvminithart();
    8002156c:	fffff097          	auipc	ra,0xfffff
    80021570:	480080e7          	jalr	1152(ra) # 800209ec <kvminithart>
  printf("procinit\n");
    80021574:	00008517          	auipc	a0,0x8
    80021578:	d7c50513          	addi	a0,a0,-644 # 800292f0 <states.1805+0x100>
    8002157c:	fffff097          	auipc	ra,0xfffff
    80021580:	b9c080e7          	jalr	-1124(ra) # 80020118 <printf>
}
    80021584:	60a6                	ld	ra,72(sp)
    80021586:	6406                	ld	s0,64(sp)
    80021588:	74e2                	ld	s1,56(sp)
    8002158a:	7942                	ld	s2,48(sp)
    8002158c:	79a2                	ld	s3,40(sp)
    8002158e:	7a02                	ld	s4,32(sp)
    80021590:	6ae2                	ld	s5,24(sp)
    80021592:	6b42                	ld	s6,16(sp)
    80021594:	6ba2                	ld	s7,8(sp)
    80021596:	6161                	addi	sp,sp,80
    80021598:	8082                	ret
        panic("kalloc");
    8002159a:	00008517          	auipc	a0,0x8
    8002159e:	d4e50513          	addi	a0,a0,-690 # 800292e8 <states.1805+0xf8>
    800215a2:	fffff097          	auipc	ra,0xfffff
    800215a6:	b34080e7          	jalr	-1228(ra) # 800200d6 <panic>

00000000800215aa <cpuid>:
{
    800215aa:	1141                	addi	sp,sp,-16
    800215ac:	e422                	sd	s0,8(sp)
    800215ae:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    800215b0:	8512                	mv	a0,tp
}
    800215b2:	2501                	sext.w	a0,a0
    800215b4:	6422                	ld	s0,8(sp)
    800215b6:	0141                	addi	sp,sp,16
    800215b8:	8082                	ret

00000000800215ba <mycpu>:
mycpu(void) {
    800215ba:	1141                	addi	sp,sp,-16
    800215bc:	e422                	sd	s0,8(sp)
    800215be:	0800                	addi	s0,sp,16
    800215c0:	8792                	mv	a5,tp
  struct cpu *c = &cpus[id];
    800215c2:	2781                	sext.w	a5,a5
    800215c4:	079e                	slli	a5,a5,0x7
}
    800215c6:	00013517          	auipc	a0,0x13
    800215ca:	aaa50513          	addi	a0,a0,-1366 # 80034070 <cpus>
    800215ce:	953e                	add	a0,a0,a5
    800215d0:	6422                	ld	s0,8(sp)
    800215d2:	0141                	addi	sp,sp,16
    800215d4:	8082                	ret

00000000800215d6 <myproc>:
myproc(void) {
    800215d6:	1101                	addi	sp,sp,-32
    800215d8:	ec06                	sd	ra,24(sp)
    800215da:	e822                	sd	s0,16(sp)
    800215dc:	e426                	sd	s1,8(sp)
    800215de:	1000                	addi	s0,sp,32
  push_off();
    800215e0:	fffff097          	auipc	ra,0xfffff
    800215e4:	f10080e7          	jalr	-240(ra) # 800204f0 <push_off>
    800215e8:	8792                	mv	a5,tp
  struct proc *p = c->proc;
    800215ea:	2781                	sext.w	a5,a5
    800215ec:	079e                	slli	a5,a5,0x7
    800215ee:	00013717          	auipc	a4,0x13
    800215f2:	a6a70713          	addi	a4,a4,-1430 # 80034058 <pid_lock>
    800215f6:	97ba                	add	a5,a5,a4
    800215f8:	6f84                	ld	s1,24(a5)
  pop_off();
    800215fa:	fffff097          	auipc	ra,0xfffff
    800215fe:	f96080e7          	jalr	-106(ra) # 80020590 <pop_off>
}
    80021602:	8526                	mv	a0,s1
    80021604:	60e2                	ld	ra,24(sp)
    80021606:	6442                	ld	s0,16(sp)
    80021608:	64a2                	ld	s1,8(sp)
    8002160a:	6105                	addi	sp,sp,32
    8002160c:	8082                	ret

000000008002160e <forkret>:
{
    8002160e:	1141                	addi	sp,sp,-16
    80021610:	e406                	sd	ra,8(sp)
    80021612:	e022                	sd	s0,0(sp)
    80021614:	0800                	addi	s0,sp,16
  release(&myproc()->lock);
    80021616:	00000097          	auipc	ra,0x0
    8002161a:	fc0080e7          	jalr	-64(ra) # 800215d6 <myproc>
    8002161e:	fffff097          	auipc	ra,0xfffff
    80021622:	fd2080e7          	jalr	-46(ra) # 800205f0 <release>
  if (first) {
    80021626:	0000a797          	auipc	a5,0xa
    8002162a:	a3678793          	addi	a5,a5,-1482 # 8002b05c <edata>
    8002162e:	439c                	lw	a5,0(a5)
    80021630:	c789                	beqz	a5,8002163a <forkret+0x2c>
    first = 0;
    80021632:	0000a797          	auipc	a5,0xa
    80021636:	a207a523          	sw	zero,-1494(a5) # 8002b05c <edata>
  usertrapret();
    8002163a:	00001097          	auipc	ra,0x1
    8002163e:	d14080e7          	jalr	-748(ra) # 8002234e <usertrapret>
}
    80021642:	60a2                	ld	ra,8(sp)
    80021644:	6402                	ld	s0,0(sp)
    80021646:	0141                	addi	sp,sp,16
    80021648:	8082                	ret

000000008002164a <allocpid>:
allocpid() {
    8002164a:	1101                	addi	sp,sp,-32
    8002164c:	ec06                	sd	ra,24(sp)
    8002164e:	e822                	sd	s0,16(sp)
    80021650:	e426                	sd	s1,8(sp)
    80021652:	e04a                	sd	s2,0(sp)
    80021654:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80021656:	00013917          	auipc	s2,0x13
    8002165a:	a0290913          	addi	s2,s2,-1534 # 80034058 <pid_lock>
    8002165e:	854a                	mv	a0,s2
    80021660:	fffff097          	auipc	ra,0xfffff
    80021664:	edc080e7          	jalr	-292(ra) # 8002053c <acquire>
  pid = nextpid;
    80021668:	0000a797          	auipc	a5,0xa
    8002166c:	9f878793          	addi	a5,a5,-1544 # 8002b060 <nextpid>
    80021670:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80021672:	0014871b          	addiw	a4,s1,1
    80021676:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80021678:	854a                	mv	a0,s2
    8002167a:	fffff097          	auipc	ra,0xfffff
    8002167e:	f76080e7          	jalr	-138(ra) # 800205f0 <release>
}
    80021682:	8526                	mv	a0,s1
    80021684:	60e2                	ld	ra,24(sp)
    80021686:	6442                	ld	s0,16(sp)
    80021688:	64a2                	ld	s1,8(sp)
    8002168a:	6902                	ld	s2,0(sp)
    8002168c:	6105                	addi	sp,sp,32
    8002168e:	8082                	ret

0000000080021690 <proc_pagetable>:
{
    80021690:	1101                	addi	sp,sp,-32
    80021692:	ec06                	sd	ra,24(sp)
    80021694:	e822                	sd	s0,16(sp)
    80021696:	e426                	sd	s1,8(sp)
    80021698:	e04a                	sd	s2,0(sp)
    8002169a:	1000                	addi	s0,sp,32
    8002169c:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    8002169e:	fffff097          	auipc	ra,0xfffff
    800216a2:	7cc080e7          	jalr	1996(ra) # 80020e6a <uvmcreate>
    800216a6:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800216a8:	c121                	beqz	a0,800216e8 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    800216aa:	4729                	li	a4,10
    800216ac:	00007697          	auipc	a3,0x7
    800216b0:	95468693          	addi	a3,a3,-1708 # 80028000 <_trampoline>
    800216b4:	6605                	lui	a2,0x1
    800216b6:	040005b7          	lui	a1,0x4000
    800216ba:	15fd                	addi	a1,a1,-1
    800216bc:	05b2                	slli	a1,a1,0xc
    800216be:	fffff097          	auipc	ra,0xfffff
    800216c2:	4b0080e7          	jalr	1200(ra) # 80020b6e <mappages>
    800216c6:	02054863          	bltz	a0,800216f6 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    800216ca:	4719                	li	a4,6
    800216cc:	05893683          	ld	a3,88(s2)
    800216d0:	6605                	lui	a2,0x1
    800216d2:	020005b7          	lui	a1,0x2000
    800216d6:	15fd                	addi	a1,a1,-1
    800216d8:	05b6                	slli	a1,a1,0xd
    800216da:	8526                	mv	a0,s1
    800216dc:	fffff097          	auipc	ra,0xfffff
    800216e0:	492080e7          	jalr	1170(ra) # 80020b6e <mappages>
    800216e4:	02054163          	bltz	a0,80021706 <proc_pagetable+0x76>
}
    800216e8:	8526                	mv	a0,s1
    800216ea:	60e2                	ld	ra,24(sp)
    800216ec:	6442                	ld	s0,16(sp)
    800216ee:	64a2                	ld	s1,8(sp)
    800216f0:	6902                	ld	s2,0(sp)
    800216f2:	6105                	addi	sp,sp,32
    800216f4:	8082                	ret
    uvmfree(pagetable, 0);
    800216f6:	4581                	li	a1,0
    800216f8:	8526                	mv	a0,s1
    800216fa:	00000097          	auipc	ra,0x0
    800216fe:	96a080e7          	jalr	-1686(ra) # 80021064 <uvmfree>
    return 0;
    80021702:	4481                	li	s1,0
    80021704:	b7d5                	j	800216e8 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80021706:	4681                	li	a3,0
    80021708:	4605                	li	a2,1
    8002170a:	040005b7          	lui	a1,0x4000
    8002170e:	15fd                	addi	a1,a1,-1
    80021710:	05b2                	slli	a1,a1,0xc
    80021712:	8526                	mv	a0,s1
    80021714:	fffff097          	auipc	ra,0xfffff
    80021718:	692080e7          	jalr	1682(ra) # 80020da6 <uvmunmap>
    uvmfree(pagetable, 0);
    8002171c:	4581                	li	a1,0
    8002171e:	8526                	mv	a0,s1
    80021720:	00000097          	auipc	ra,0x0
    80021724:	944080e7          	jalr	-1724(ra) # 80021064 <uvmfree>
    return 0;
    80021728:	4481                	li	s1,0
    8002172a:	bf7d                	j	800216e8 <proc_pagetable+0x58>

000000008002172c <proc_freepagetable>:
{
    8002172c:	1101                	addi	sp,sp,-32
    8002172e:	ec06                	sd	ra,24(sp)
    80021730:	e822                	sd	s0,16(sp)
    80021732:	e426                	sd	s1,8(sp)
    80021734:	e04a                	sd	s2,0(sp)
    80021736:	1000                	addi	s0,sp,32
    80021738:	84aa                	mv	s1,a0
    8002173a:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    8002173c:	4681                	li	a3,0
    8002173e:	4605                	li	a2,1
    80021740:	040005b7          	lui	a1,0x4000
    80021744:	15fd                	addi	a1,a1,-1
    80021746:	05b2                	slli	a1,a1,0xc
    80021748:	fffff097          	auipc	ra,0xfffff
    8002174c:	65e080e7          	jalr	1630(ra) # 80020da6 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80021750:	4681                	li	a3,0
    80021752:	4605                	li	a2,1
    80021754:	020005b7          	lui	a1,0x2000
    80021758:	15fd                	addi	a1,a1,-1
    8002175a:	05b6                	slli	a1,a1,0xd
    8002175c:	8526                	mv	a0,s1
    8002175e:	fffff097          	auipc	ra,0xfffff
    80021762:	648080e7          	jalr	1608(ra) # 80020da6 <uvmunmap>
  uvmfree(pagetable, sz);
    80021766:	85ca                	mv	a1,s2
    80021768:	8526                	mv	a0,s1
    8002176a:	00000097          	auipc	ra,0x0
    8002176e:	8fa080e7          	jalr	-1798(ra) # 80021064 <uvmfree>
}
    80021772:	60e2                	ld	ra,24(sp)
    80021774:	6442                	ld	s0,16(sp)
    80021776:	64a2                	ld	s1,8(sp)
    80021778:	6902                	ld	s2,0(sp)
    8002177a:	6105                	addi	sp,sp,32
    8002177c:	8082                	ret

000000008002177e <freeproc>:
{
    8002177e:	1101                	addi	sp,sp,-32
    80021780:	ec06                	sd	ra,24(sp)
    80021782:	e822                	sd	s0,16(sp)
    80021784:	e426                	sd	s1,8(sp)
    80021786:	1000                	addi	s0,sp,32
    80021788:	84aa                	mv	s1,a0
  if(p->trapframe)
    8002178a:	6d28                	ld	a0,88(a0)
    8002178c:	c509                	beqz	a0,80021796 <freeproc+0x18>
    kfree((void*)p->trapframe);
    8002178e:	fffff097          	auipc	ra,0xfffff
    80021792:	bac080e7          	jalr	-1108(ra) # 8002033a <kfree>
  p->trapframe = 0;
    80021796:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    8002179a:	68a8                	ld	a0,80(s1)
    8002179c:	c511                	beqz	a0,800217a8 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    8002179e:	64ac                	ld	a1,72(s1)
    800217a0:	00000097          	auipc	ra,0x0
    800217a4:	f8c080e7          	jalr	-116(ra) # 8002172c <proc_freepagetable>
  p->pagetable = 0;
    800217a8:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    800217ac:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    800217b0:	0204ac23          	sw	zero,56(s1)
  p->parent = 0;
    800217b4:	0204b023          	sd	zero,32(s1)
  p->name[0] = 0;
    800217b8:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    800217bc:	0204b423          	sd	zero,40(s1)
  p->killed = 0;
    800217c0:	0204a823          	sw	zero,48(s1)
  p->xstate = 0;
    800217c4:	0204aa23          	sw	zero,52(s1)
  p->state = UNUSED;
    800217c8:	0004ac23          	sw	zero,24(s1)
}
    800217cc:	60e2                	ld	ra,24(sp)
    800217ce:	6442                	ld	s0,16(sp)
    800217d0:	64a2                	ld	s1,8(sp)
    800217d2:	6105                	addi	sp,sp,32
    800217d4:	8082                	ret

00000000800217d6 <allocproc>:
{
    800217d6:	1101                	addi	sp,sp,-32
    800217d8:	ec06                	sd	ra,24(sp)
    800217da:	e822                	sd	s0,16(sp)
    800217dc:	e426                	sd	s1,8(sp)
    800217de:	e04a                	sd	s2,0(sp)
    800217e0:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    800217e2:	00013497          	auipc	s1,0x13
    800217e6:	98e48493          	addi	s1,s1,-1650 # 80034170 <proc>
    800217ea:	00014917          	auipc	s2,0x14
    800217ee:	00690913          	addi	s2,s2,6 # 800357f0 <initproc>
    acquire(&p->lock);
    800217f2:	8526                	mv	a0,s1
    800217f4:	fffff097          	auipc	ra,0xfffff
    800217f8:	d48080e7          	jalr	-696(ra) # 8002053c <acquire>
    if(p->state == UNUSED) {
    800217fc:	4c9c                	lw	a5,24(s1)
    800217fe:	c395                	beqz	a5,80021822 <allocproc+0x4c>
      release(&p->lock);
    80021800:	8526                	mv	a0,s1
    80021802:	fffff097          	auipc	ra,0xfffff
    80021806:	dee080e7          	jalr	-530(ra) # 800205f0 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8002180a:	16848493          	addi	s1,s1,360
    8002180e:	ff2492e3          	bne	s1,s2,800217f2 <allocproc+0x1c>
  return 0;
    80021812:	4481                	li	s1,0
}
    80021814:	8526                	mv	a0,s1
    80021816:	60e2                	ld	ra,24(sp)
    80021818:	6442                	ld	s0,16(sp)
    8002181a:	64a2                	ld	s1,8(sp)
    8002181c:	6902                	ld	s2,0(sp)
    8002181e:	6105                	addi	sp,sp,32
    80021820:	8082                	ret
  p->pid = allocpid();
    80021822:	00000097          	auipc	ra,0x0
    80021826:	e28080e7          	jalr	-472(ra) # 8002164a <allocpid>
    8002182a:	dc88                	sw	a0,56(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8002182c:	fffff097          	auipc	ra,0xfffff
    80021830:	c20080e7          	jalr	-992(ra) # 8002044c <kalloc>
    80021834:	892a                	mv	s2,a0
    80021836:	eca8                	sd	a0,88(s1)
    80021838:	cd05                	beqz	a0,80021870 <allocproc+0x9a>
  p->pagetable = proc_pagetable(p);
    8002183a:	8526                	mv	a0,s1
    8002183c:	00000097          	auipc	ra,0x0
    80021840:	e54080e7          	jalr	-428(ra) # 80021690 <proc_pagetable>
    80021844:	892a                	mv	s2,a0
    80021846:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80021848:	c91d                	beqz	a0,8002187e <allocproc+0xa8>
  memset(&p->context, 0, sizeof(p->context));
    8002184a:	07000613          	li	a2,112
    8002184e:	4581                	li	a1,0
    80021850:	06048513          	addi	a0,s1,96
    80021854:	fffff097          	auipc	ra,0xfffff
    80021858:	de4080e7          	jalr	-540(ra) # 80020638 <memset>
  p->context.ra = (uint64)forkret;
    8002185c:	00000797          	auipc	a5,0x0
    80021860:	db278793          	addi	a5,a5,-590 # 8002160e <forkret>
    80021864:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80021866:	60bc                	ld	a5,64(s1)
    80021868:	6705                	lui	a4,0x1
    8002186a:	97ba                	add	a5,a5,a4
    8002186c:	f4bc                	sd	a5,104(s1)
  return p;
    8002186e:	b75d                	j	80021814 <allocproc+0x3e>
    release(&p->lock);
    80021870:	8526                	mv	a0,s1
    80021872:	fffff097          	auipc	ra,0xfffff
    80021876:	d7e080e7          	jalr	-642(ra) # 800205f0 <release>
    return 0;
    8002187a:	84ca                	mv	s1,s2
    8002187c:	bf61                	j	80021814 <allocproc+0x3e>
    freeproc(p);
    8002187e:	8526                	mv	a0,s1
    80021880:	00000097          	auipc	ra,0x0
    80021884:	efe080e7          	jalr	-258(ra) # 8002177e <freeproc>
    release(&p->lock);
    80021888:	8526                	mv	a0,s1
    8002188a:	fffff097          	auipc	ra,0xfffff
    8002188e:	d66080e7          	jalr	-666(ra) # 800205f0 <release>
    return 0;
    80021892:	84ca                	mv	s1,s2
    80021894:	b741                	j	80021814 <allocproc+0x3e>

0000000080021896 <test_proc_init>:
void test_proc_init(int proc_num) {
    80021896:	715d                	addi	sp,sp,-80
    80021898:	e486                	sd	ra,72(sp)
    8002189a:	e0a2                	sd	s0,64(sp)
    8002189c:	fc26                	sd	s1,56(sp)
    8002189e:	f84a                	sd	s2,48(sp)
    800218a0:	f44e                	sd	s3,40(sp)
    800218a2:	f052                	sd	s4,32(sp)
    800218a4:	ec56                	sd	s5,24(sp)
    800218a6:	e85a                	sd	s6,16(sp)
    800218a8:	e45e                	sd	s7,8(sp)
    800218aa:	0880                	addi	s0,sp,80
  if(proc_num > NPROC) panic("test_proc_init\n");
    800218ac:	47c1                	li	a5,16
    800218ae:	0aa7c263          	blt	a5,a0,80021952 <test_proc_init+0xbc>
    800218b2:	8a2a                	mv	s4,a0
  for(int i = 0; i < proc_num; i++) {
    800218b4:	4901                	li	s2,0
    800218b6:	06a05363          	blez	a0,8002191c <test_proc_init+0x86>
    uvminit(p->pagetable, (uchar*)printhello, sizeof(printhello));
    800218ba:	00009b97          	auipc	s7,0x9
    800218be:	746b8b93          	addi	s7,s7,1862 # 8002b000 <printhello>
    p->sz = PGSIZE;
    800218c2:	6985                	lui	s3,0x1
    safestrcpy(p->name, "test_code", sizeof(p->name));
    800218c4:	00008b17          	auipc	s6,0x8
    800218c8:	a4cb0b13          	addi	s6,s6,-1460 # 80029310 <states.1805+0x120>
    p->state = RUNNABLE;
    800218cc:	4a89                	li	s5,2
    p = allocproc();
    800218ce:	00000097          	auipc	ra,0x0
    800218d2:	f08080e7          	jalr	-248(ra) # 800217d6 <allocproc>
    800218d6:	84aa                	mv	s1,a0
    uvminit(p->pagetable, (uchar*)printhello, sizeof(printhello));
    800218d8:	02400613          	li	a2,36
    800218dc:	85de                	mv	a1,s7
    800218de:	6928                	ld	a0,80(a0)
    800218e0:	fffff097          	auipc	ra,0xfffff
    800218e4:	5b8080e7          	jalr	1464(ra) # 80020e98 <uvminit>
    p->sz = PGSIZE;
    800218e8:	0534b423          	sd	s3,72(s1)
    p->trapframe->epc = 0x0;
    800218ec:	6cbc                	ld	a5,88(s1)
    800218ee:	0007bc23          	sd	zero,24(a5)
    p->trapframe->sp = PGSIZE;
    800218f2:	6cbc                	ld	a5,88(s1)
    800218f4:	0337b823          	sd	s3,48(a5)
    safestrcpy(p->name, "test_code", sizeof(p->name));
    800218f8:	4641                	li	a2,16
    800218fa:	85da                	mv	a1,s6
    800218fc:	15848513          	addi	a0,s1,344
    80021900:	fffff097          	auipc	ra,0xfffff
    80021904:	eb0080e7          	jalr	-336(ra) # 800207b0 <safestrcpy>
    p->state = RUNNABLE;
    80021908:	0154ac23          	sw	s5,24(s1)
    release(&p->lock);
    8002190c:	8526                	mv	a0,s1
    8002190e:	fffff097          	auipc	ra,0xfffff
    80021912:	ce2080e7          	jalr	-798(ra) # 800205f0 <release>
  for(int i = 0; i < proc_num; i++) {
    80021916:	2905                	addiw	s2,s2,1
    80021918:	fb2a1be3          	bne	s4,s2,800218ce <test_proc_init+0x38>
  initproc = proc;
    8002191c:	00013797          	auipc	a5,0x13
    80021920:	85478793          	addi	a5,a5,-1964 # 80034170 <proc>
    80021924:	00014717          	auipc	a4,0x14
    80021928:	ecf73623          	sd	a5,-308(a4) # 800357f0 <initproc>
  printf("[test_proc]test_proc init done\n");
    8002192c:	00008517          	auipc	a0,0x8
    80021930:	9f450513          	addi	a0,a0,-1548 # 80029320 <states.1805+0x130>
    80021934:	ffffe097          	auipc	ra,0xffffe
    80021938:	7e4080e7          	jalr	2020(ra) # 80020118 <printf>
}
    8002193c:	60a6                	ld	ra,72(sp)
    8002193e:	6406                	ld	s0,64(sp)
    80021940:	74e2                	ld	s1,56(sp)
    80021942:	7942                	ld	s2,48(sp)
    80021944:	79a2                	ld	s3,40(sp)
    80021946:	7a02                	ld	s4,32(sp)
    80021948:	6ae2                	ld	s5,24(sp)
    8002194a:	6b42                	ld	s6,16(sp)
    8002194c:	6ba2                	ld	s7,8(sp)
    8002194e:	6161                	addi	sp,sp,80
    80021950:	8082                	ret
  if(proc_num > NPROC) panic("test_proc_init\n");
    80021952:	00008517          	auipc	a0,0x8
    80021956:	9ae50513          	addi	a0,a0,-1618 # 80029300 <states.1805+0x110>
    8002195a:	ffffe097          	auipc	ra,0xffffe
    8002195e:	77c080e7          	jalr	1916(ra) # 800200d6 <panic>

0000000080021962 <userinit>:
{
    80021962:	1101                	addi	sp,sp,-32
    80021964:	ec06                	sd	ra,24(sp)
    80021966:	e822                	sd	s0,16(sp)
    80021968:	e426                	sd	s1,8(sp)
    8002196a:	1000                	addi	s0,sp,32
  p = allocproc();
    8002196c:	00000097          	auipc	ra,0x0
    80021970:	e6a080e7          	jalr	-406(ra) # 800217d6 <allocproc>
    80021974:	84aa                	mv	s1,a0
  initproc = p;
    80021976:	00014797          	auipc	a5,0x14
    8002197a:	e6a7bd23          	sd	a0,-390(a5) # 800357f0 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    8002197e:	03400613          	li	a2,52
    80021982:	00009597          	auipc	a1,0x9
    80021986:	6a658593          	addi	a1,a1,1702 # 8002b028 <initcode>
    8002198a:	6928                	ld	a0,80(a0)
    8002198c:	fffff097          	auipc	ra,0xfffff
    80021990:	50c080e7          	jalr	1292(ra) # 80020e98 <uvminit>
  p->sz = PGSIZE;
    80021994:	6785                	lui	a5,0x1
    80021996:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0x0;      // user program counter
    80021998:	6cb8                	ld	a4,88(s1)
    8002199a:	00073c23          	sd	zero,24(a4)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    8002199e:	6cb8                	ld	a4,88(s1)
    800219a0:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    800219a2:	4641                	li	a2,16
    800219a4:	00008597          	auipc	a1,0x8
    800219a8:	99c58593          	addi	a1,a1,-1636 # 80029340 <states.1805+0x150>
    800219ac:	15848513          	addi	a0,s1,344
    800219b0:	fffff097          	auipc	ra,0xfffff
    800219b4:	e00080e7          	jalr	-512(ra) # 800207b0 <safestrcpy>
  p->cwd = ename("/");
    800219b8:	00008517          	auipc	a0,0x8
    800219bc:	99850513          	addi	a0,a0,-1640 # 80029350 <states.1805+0x160>
    800219c0:	00004097          	auipc	ra,0x4
    800219c4:	742080e7          	jalr	1858(ra) # 80026102 <ename>
    800219c8:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    800219cc:	4789                	li	a5,2
    800219ce:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    800219d0:	8526                	mv	a0,s1
    800219d2:	fffff097          	auipc	ra,0xfffff
    800219d6:	c1e080e7          	jalr	-994(ra) # 800205f0 <release>
  printf("userinit\n");
    800219da:	00008517          	auipc	a0,0x8
    800219de:	97e50513          	addi	a0,a0,-1666 # 80029358 <states.1805+0x168>
    800219e2:	ffffe097          	auipc	ra,0xffffe
    800219e6:	736080e7          	jalr	1846(ra) # 80020118 <printf>
}
    800219ea:	60e2                	ld	ra,24(sp)
    800219ec:	6442                	ld	s0,16(sp)
    800219ee:	64a2                	ld	s1,8(sp)
    800219f0:	6105                	addi	sp,sp,32
    800219f2:	8082                	ret

00000000800219f4 <growproc>:
{
    800219f4:	1101                	addi	sp,sp,-32
    800219f6:	ec06                	sd	ra,24(sp)
    800219f8:	e822                	sd	s0,16(sp)
    800219fa:	e426                	sd	s1,8(sp)
    800219fc:	e04a                	sd	s2,0(sp)
    800219fe:	1000                	addi	s0,sp,32
    80021a00:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80021a02:	00000097          	auipc	ra,0x0
    80021a06:	bd4080e7          	jalr	-1068(ra) # 800215d6 <myproc>
    80021a0a:	892a                	mv	s2,a0
  sz = p->sz;
    80021a0c:	652c                	ld	a1,72(a0)
    80021a0e:	0005851b          	sext.w	a0,a1
  if(n > 0){
    80021a12:	00904f63          	bgtz	s1,80021a30 <growproc+0x3c>
  } else if(n < 0){
    80021a16:	0204cd63          	bltz	s1,80021a50 <growproc+0x5c>
  p->sz = sz;
    80021a1a:	1502                	slli	a0,a0,0x20
    80021a1c:	9101                	srli	a0,a0,0x20
    80021a1e:	04a93423          	sd	a0,72(s2)
  return 0;
    80021a22:	4501                	li	a0,0
}
    80021a24:	60e2                	ld	ra,24(sp)
    80021a26:	6442                	ld	s0,16(sp)
    80021a28:	64a2                	ld	s1,8(sp)
    80021a2a:	6902                	ld	s2,0(sp)
    80021a2c:	6105                	addi	sp,sp,32
    80021a2e:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80021a30:	00a4863b          	addw	a2,s1,a0
    80021a34:	1602                	slli	a2,a2,0x20
    80021a36:	9201                	srli	a2,a2,0x20
    80021a38:	1582                	slli	a1,a1,0x20
    80021a3a:	9181                	srli	a1,a1,0x20
    80021a3c:	05093503          	ld	a0,80(s2)
    80021a40:	fffff097          	auipc	ra,0xfffff
    80021a44:	510080e7          	jalr	1296(ra) # 80020f50 <uvmalloc>
    80021a48:	2501                	sext.w	a0,a0
    80021a4a:	f961                	bnez	a0,80021a1a <growproc+0x26>
      return -1;
    80021a4c:	557d                	li	a0,-1
    80021a4e:	bfd9                	j	80021a24 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80021a50:	00a4863b          	addw	a2,s1,a0
    80021a54:	1602                	slli	a2,a2,0x20
    80021a56:	9201                	srli	a2,a2,0x20
    80021a58:	1582                	slli	a1,a1,0x20
    80021a5a:	9181                	srli	a1,a1,0x20
    80021a5c:	05093503          	ld	a0,80(s2)
    80021a60:	fffff097          	auipc	ra,0xfffff
    80021a64:	4aa080e7          	jalr	1194(ra) # 80020f0a <uvmdealloc>
    80021a68:	2501                	sext.w	a0,a0
    80021a6a:	bf45                	j	80021a1a <growproc+0x26>

0000000080021a6c <fork>:
{
    80021a6c:	7179                	addi	sp,sp,-48
    80021a6e:	f406                	sd	ra,40(sp)
    80021a70:	f022                	sd	s0,32(sp)
    80021a72:	ec26                	sd	s1,24(sp)
    80021a74:	e84a                	sd	s2,16(sp)
    80021a76:	e44e                	sd	s3,8(sp)
    80021a78:	e052                	sd	s4,0(sp)
    80021a7a:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80021a7c:	00000097          	auipc	ra,0x0
    80021a80:	b5a080e7          	jalr	-1190(ra) # 800215d6 <myproc>
    80021a84:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    80021a86:	00000097          	auipc	ra,0x0
    80021a8a:	d50080e7          	jalr	-688(ra) # 800217d6 <allocproc>
    80021a8e:	c175                	beqz	a0,80021b72 <fork+0x106>
    80021a90:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80021a92:	04893603          	ld	a2,72(s2)
    80021a96:	692c                	ld	a1,80(a0)
    80021a98:	05093503          	ld	a0,80(s2)
    80021a9c:	fffff097          	auipc	ra,0xfffff
    80021aa0:	600080e7          	jalr	1536(ra) # 8002109c <uvmcopy>
    80021aa4:	04054863          	bltz	a0,80021af4 <fork+0x88>
  np->sz = p->sz;
    80021aa8:	04893783          	ld	a5,72(s2)
    80021aac:	04f9b423          	sd	a5,72(s3) # 1048 <BASE_ADDRESS-0x8001efb8>
  np->parent = p;
    80021ab0:	0329b023          	sd	s2,32(s3)
  *(np->trapframe) = *(p->trapframe);
    80021ab4:	05893683          	ld	a3,88(s2)
    80021ab8:	87b6                	mv	a5,a3
    80021aba:	0589b703          	ld	a4,88(s3)
    80021abe:	12068693          	addi	a3,a3,288
    80021ac2:	0007b803          	ld	a6,0(a5) # 1000 <BASE_ADDRESS-0x8001f000>
    80021ac6:	6788                	ld	a0,8(a5)
    80021ac8:	6b8c                	ld	a1,16(a5)
    80021aca:	6f90                	ld	a2,24(a5)
    80021acc:	01073023          	sd	a6,0(a4)
    80021ad0:	e708                	sd	a0,8(a4)
    80021ad2:	eb0c                	sd	a1,16(a4)
    80021ad4:	ef10                	sd	a2,24(a4)
    80021ad6:	02078793          	addi	a5,a5,32
    80021ada:	02070713          	addi	a4,a4,32
    80021ade:	fed792e3          	bne	a5,a3,80021ac2 <fork+0x56>
  np->trapframe->a0 = 0;
    80021ae2:	0589b783          	ld	a5,88(s3)
    80021ae6:	0607b823          	sd	zero,112(a5)
    80021aea:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    80021aee:	15000a13          	li	s4,336
    80021af2:	a03d                	j	80021b20 <fork+0xb4>
    freeproc(np);
    80021af4:	854e                	mv	a0,s3
    80021af6:	00000097          	auipc	ra,0x0
    80021afa:	c88080e7          	jalr	-888(ra) # 8002177e <freeproc>
    release(&np->lock);
    80021afe:	854e                	mv	a0,s3
    80021b00:	fffff097          	auipc	ra,0xfffff
    80021b04:	af0080e7          	jalr	-1296(ra) # 800205f0 <release>
    return -1;
    80021b08:	54fd                	li	s1,-1
    80021b0a:	a899                	j	80021b60 <fork+0xf4>
      np->ofile[i] = filedup(p->ofile[i]);
    80021b0c:	00001097          	auipc	ra,0x1
    80021b10:	4aa080e7          	jalr	1194(ra) # 80022fb6 <filedup>
    80021b14:	009987b3          	add	a5,s3,s1
    80021b18:	e388                	sd	a0,0(a5)
    80021b1a:	04a1                	addi	s1,s1,8
  for(i = 0; i < NOFILE; i++)
    80021b1c:	01448763          	beq	s1,s4,80021b2a <fork+0xbe>
    if(p->ofile[i])
    80021b20:	009907b3          	add	a5,s2,s1
    80021b24:	6388                	ld	a0,0(a5)
    80021b26:	f17d                	bnez	a0,80021b0c <fork+0xa0>
    80021b28:	bfcd                	j	80021b1a <fork+0xae>
  np->cwd = edup(p->cwd);
    80021b2a:	15093503          	ld	a0,336(s2)
    80021b2e:	00003097          	auipc	ra,0x3
    80021b32:	760080e7          	jalr	1888(ra) # 8002528e <edup>
    80021b36:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80021b3a:	4641                	li	a2,16
    80021b3c:	15890593          	addi	a1,s2,344
    80021b40:	15898513          	addi	a0,s3,344
    80021b44:	fffff097          	auipc	ra,0xfffff
    80021b48:	c6c080e7          	jalr	-916(ra) # 800207b0 <safestrcpy>
  pid = np->pid;
    80021b4c:	0389a483          	lw	s1,56(s3)
  np->state = RUNNABLE;
    80021b50:	4789                	li	a5,2
    80021b52:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80021b56:	854e                	mv	a0,s3
    80021b58:	fffff097          	auipc	ra,0xfffff
    80021b5c:	a98080e7          	jalr	-1384(ra) # 800205f0 <release>
}
    80021b60:	8526                	mv	a0,s1
    80021b62:	70a2                	ld	ra,40(sp)
    80021b64:	7402                	ld	s0,32(sp)
    80021b66:	64e2                	ld	s1,24(sp)
    80021b68:	6942                	ld	s2,16(sp)
    80021b6a:	69a2                	ld	s3,8(sp)
    80021b6c:	6a02                	ld	s4,0(sp)
    80021b6e:	6145                	addi	sp,sp,48
    80021b70:	8082                	ret
    return -1;
    80021b72:	54fd                	li	s1,-1
    80021b74:	b7f5                	j	80021b60 <fork+0xf4>

0000000080021b76 <reparent>:
{
    80021b76:	7179                	addi	sp,sp,-48
    80021b78:	f406                	sd	ra,40(sp)
    80021b7a:	f022                	sd	s0,32(sp)
    80021b7c:	ec26                	sd	s1,24(sp)
    80021b7e:	e84a                	sd	s2,16(sp)
    80021b80:	e44e                	sd	s3,8(sp)
    80021b82:	e052                	sd	s4,0(sp)
    80021b84:	1800                	addi	s0,sp,48
    80021b86:	89aa                	mv	s3,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80021b88:	00012497          	auipc	s1,0x12
    80021b8c:	5e848493          	addi	s1,s1,1512 # 80034170 <proc>
      pp->parent = initproc;
    80021b90:	00014a17          	auipc	s4,0x14
    80021b94:	c60a0a13          	addi	s4,s4,-928 # 800357f0 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80021b98:	00014917          	auipc	s2,0x14
    80021b9c:	c5890913          	addi	s2,s2,-936 # 800357f0 <initproc>
    80021ba0:	a029                	j	80021baa <reparent+0x34>
    80021ba2:	16848493          	addi	s1,s1,360
    80021ba6:	03248363          	beq	s1,s2,80021bcc <reparent+0x56>
    if(pp->parent == p){
    80021baa:	709c                	ld	a5,32(s1)
    80021bac:	ff379be3          	bne	a5,s3,80021ba2 <reparent+0x2c>
      acquire(&pp->lock);
    80021bb0:	8526                	mv	a0,s1
    80021bb2:	fffff097          	auipc	ra,0xfffff
    80021bb6:	98a080e7          	jalr	-1654(ra) # 8002053c <acquire>
      pp->parent = initproc;
    80021bba:	000a3783          	ld	a5,0(s4)
    80021bbe:	f09c                	sd	a5,32(s1)
      release(&pp->lock);
    80021bc0:	8526                	mv	a0,s1
    80021bc2:	fffff097          	auipc	ra,0xfffff
    80021bc6:	a2e080e7          	jalr	-1490(ra) # 800205f0 <release>
    80021bca:	bfe1                	j	80021ba2 <reparent+0x2c>
}
    80021bcc:	70a2                	ld	ra,40(sp)
    80021bce:	7402                	ld	s0,32(sp)
    80021bd0:	64e2                	ld	s1,24(sp)
    80021bd2:	6942                	ld	s2,16(sp)
    80021bd4:	69a2                	ld	s3,8(sp)
    80021bd6:	6a02                	ld	s4,0(sp)
    80021bd8:	6145                	addi	sp,sp,48
    80021bda:	8082                	ret

0000000080021bdc <scheduler>:
{
    80021bdc:	715d                	addi	sp,sp,-80
    80021bde:	e486                	sd	ra,72(sp)
    80021be0:	e0a2                	sd	s0,64(sp)
    80021be2:	fc26                	sd	s1,56(sp)
    80021be4:	f84a                	sd	s2,48(sp)
    80021be6:	f44e                	sd	s3,40(sp)
    80021be8:	f052                	sd	s4,32(sp)
    80021bea:	ec56                	sd	s5,24(sp)
    80021bec:	e85a                	sd	s6,16(sp)
    80021bee:	e45e                	sd	s7,8(sp)
    80021bf0:	e062                	sd	s8,0(sp)
    80021bf2:	0880                	addi	s0,sp,80
    80021bf4:	8792                	mv	a5,tp
  int id = r_tp();
    80021bf6:	2781                	sext.w	a5,a5
  c->proc = 0;
    80021bf8:	00779b13          	slli	s6,a5,0x7
    80021bfc:	00012717          	auipc	a4,0x12
    80021c00:	45c70713          	addi	a4,a4,1116 # 80034058 <pid_lock>
    80021c04:	975a                	add	a4,a4,s6
    80021c06:	00073c23          	sd	zero,24(a4)
        swtch(&c->context, &p->context);
    80021c0a:	00012717          	auipc	a4,0x12
    80021c0e:	46e70713          	addi	a4,a4,1134 # 80034078 <cpus+0x8>
    80021c12:	9b3a                	add	s6,s6,a4
        p->state = RUNNING;
    80021c14:	4c0d                	li	s8,3
        c->proc = p;
    80021c16:	079e                	slli	a5,a5,0x7
    80021c18:	00012a17          	auipc	s4,0x12
    80021c1c:	440a0a13          	addi	s4,s4,1088 # 80034058 <pid_lock>
    80021c20:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80021c22:	00014997          	auipc	s3,0x14
    80021c26:	bce98993          	addi	s3,s3,-1074 # 800357f0 <initproc>
        found = 1;
    80021c2a:	4b85                	li	s7,1
    80021c2c:	a899                	j	80021c82 <scheduler+0xa6>
        p->state = RUNNING;
    80021c2e:	0184ac23          	sw	s8,24(s1)
        c->proc = p;
    80021c32:	009a3c23          	sd	s1,24(s4)
        swtch(&c->context, &p->context);
    80021c36:	06048593          	addi	a1,s1,96
    80021c3a:	855a                	mv	a0,s6
    80021c3c:	00000097          	auipc	ra,0x0
    80021c40:	62c080e7          	jalr	1580(ra) # 80022268 <swtch>
        c->proc = 0;
    80021c44:	000a3c23          	sd	zero,24(s4)
        found = 1;
    80021c48:	8ade                	mv	s5,s7
      release(&p->lock);
    80021c4a:	8526                	mv	a0,s1
    80021c4c:	fffff097          	auipc	ra,0xfffff
    80021c50:	9a4080e7          	jalr	-1628(ra) # 800205f0 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80021c54:	16848493          	addi	s1,s1,360
    80021c58:	01348b63          	beq	s1,s3,80021c6e <scheduler+0x92>
      acquire(&p->lock);
    80021c5c:	8526                	mv	a0,s1
    80021c5e:	fffff097          	auipc	ra,0xfffff
    80021c62:	8de080e7          	jalr	-1826(ra) # 8002053c <acquire>
      if(p->state == RUNNABLE) {
    80021c66:	4c9c                	lw	a5,24(s1)
    80021c68:	ff2791e3          	bne	a5,s2,80021c4a <scheduler+0x6e>
    80021c6c:	b7c9                	j	80021c2e <scheduler+0x52>
    if(found == 0) {
    80021c6e:	000a9a63          	bnez	s5,80021c82 <scheduler+0xa6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80021c72:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80021c76:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80021c7a:	10079073          	csrw	sstatus,a5
      asm volatile("wfi");
    80021c7e:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80021c82:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80021c86:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80021c8a:	10079073          	csrw	sstatus,a5
    int found = 0;
    80021c8e:	4a81                	li	s5,0
    for(p = proc; p < &proc[NPROC]; p++) {
    80021c90:	00012497          	auipc	s1,0x12
    80021c94:	4e048493          	addi	s1,s1,1248 # 80034170 <proc>
      if(p->state == RUNNABLE) {
    80021c98:	4909                	li	s2,2
    80021c9a:	b7c9                	j	80021c5c <scheduler+0x80>

0000000080021c9c <sched>:
{
    80021c9c:	7179                	addi	sp,sp,-48
    80021c9e:	f406                	sd	ra,40(sp)
    80021ca0:	f022                	sd	s0,32(sp)
    80021ca2:	ec26                	sd	s1,24(sp)
    80021ca4:	e84a                	sd	s2,16(sp)
    80021ca6:	e44e                	sd	s3,8(sp)
    80021ca8:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80021caa:	00000097          	auipc	ra,0x0
    80021cae:	92c080e7          	jalr	-1748(ra) # 800215d6 <myproc>
    80021cb2:	892a                	mv	s2,a0
  if(!holding(&p->lock))
    80021cb4:	fffff097          	auipc	ra,0xfffff
    80021cb8:	80e080e7          	jalr	-2034(ra) # 800204c2 <holding>
    80021cbc:	cd25                	beqz	a0,80021d34 <sched+0x98>
  asm volatile("mv %0, tp" : "=r" (x) );
    80021cbe:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80021cc0:	2781                	sext.w	a5,a5
    80021cc2:	079e                	slli	a5,a5,0x7
    80021cc4:	00012717          	auipc	a4,0x12
    80021cc8:	39470713          	addi	a4,a4,916 # 80034058 <pid_lock>
    80021ccc:	97ba                	add	a5,a5,a4
    80021cce:	0907a703          	lw	a4,144(a5)
    80021cd2:	4785                	li	a5,1
    80021cd4:	06f71863          	bne	a4,a5,80021d44 <sched+0xa8>
  if(p->state == RUNNING)
    80021cd8:	01892703          	lw	a4,24(s2)
    80021cdc:	478d                	li	a5,3
    80021cde:	06f70b63          	beq	a4,a5,80021d54 <sched+0xb8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80021ce2:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80021ce6:	8b89                	andi	a5,a5,2
  if(intr_get())
    80021ce8:	efb5                	bnez	a5,80021d64 <sched+0xc8>
  asm volatile("mv %0, tp" : "=r" (x) );
    80021cea:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80021cec:	00012497          	auipc	s1,0x12
    80021cf0:	36c48493          	addi	s1,s1,876 # 80034058 <pid_lock>
    80021cf4:	2781                	sext.w	a5,a5
    80021cf6:	079e                	slli	a5,a5,0x7
    80021cf8:	97a6                	add	a5,a5,s1
    80021cfa:	0947a983          	lw	s3,148(a5)
    80021cfe:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80021d00:	2781                	sext.w	a5,a5
    80021d02:	079e                	slli	a5,a5,0x7
    80021d04:	00012597          	auipc	a1,0x12
    80021d08:	37458593          	addi	a1,a1,884 # 80034078 <cpus+0x8>
    80021d0c:	95be                	add	a1,a1,a5
    80021d0e:	06090513          	addi	a0,s2,96
    80021d12:	00000097          	auipc	ra,0x0
    80021d16:	556080e7          	jalr	1366(ra) # 80022268 <swtch>
    80021d1a:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80021d1c:	2781                	sext.w	a5,a5
    80021d1e:	079e                	slli	a5,a5,0x7
    80021d20:	97a6                	add	a5,a5,s1
    80021d22:	0937aa23          	sw	s3,148(a5)
}
    80021d26:	70a2                	ld	ra,40(sp)
    80021d28:	7402                	ld	s0,32(sp)
    80021d2a:	64e2                	ld	s1,24(sp)
    80021d2c:	6942                	ld	s2,16(sp)
    80021d2e:	69a2                	ld	s3,8(sp)
    80021d30:	6145                	addi	sp,sp,48
    80021d32:	8082                	ret
    panic("sched p->lock");
    80021d34:	00007517          	auipc	a0,0x7
    80021d38:	63450513          	addi	a0,a0,1588 # 80029368 <states.1805+0x178>
    80021d3c:	ffffe097          	auipc	ra,0xffffe
    80021d40:	39a080e7          	jalr	922(ra) # 800200d6 <panic>
    panic("sched locks");
    80021d44:	00007517          	auipc	a0,0x7
    80021d48:	63450513          	addi	a0,a0,1588 # 80029378 <states.1805+0x188>
    80021d4c:	ffffe097          	auipc	ra,0xffffe
    80021d50:	38a080e7          	jalr	906(ra) # 800200d6 <panic>
    panic("sched running");
    80021d54:	00007517          	auipc	a0,0x7
    80021d58:	63450513          	addi	a0,a0,1588 # 80029388 <states.1805+0x198>
    80021d5c:	ffffe097          	auipc	ra,0xffffe
    80021d60:	37a080e7          	jalr	890(ra) # 800200d6 <panic>
    panic("sched interruptible");
    80021d64:	00007517          	auipc	a0,0x7
    80021d68:	63450513          	addi	a0,a0,1588 # 80029398 <states.1805+0x1a8>
    80021d6c:	ffffe097          	auipc	ra,0xffffe
    80021d70:	36a080e7          	jalr	874(ra) # 800200d6 <panic>

0000000080021d74 <exit>:
{
    80021d74:	7179                	addi	sp,sp,-48
    80021d76:	f406                	sd	ra,40(sp)
    80021d78:	f022                	sd	s0,32(sp)
    80021d7a:	ec26                	sd	s1,24(sp)
    80021d7c:	e84a                	sd	s2,16(sp)
    80021d7e:	e44e                	sd	s3,8(sp)
    80021d80:	e052                	sd	s4,0(sp)
    80021d82:	1800                	addi	s0,sp,48
    80021d84:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80021d86:	00000097          	auipc	ra,0x0
    80021d8a:	850080e7          	jalr	-1968(ra) # 800215d6 <myproc>
    80021d8e:	89aa                	mv	s3,a0
  if(p == initproc)
    80021d90:	00014797          	auipc	a5,0x14
    80021d94:	a6078793          	addi	a5,a5,-1440 # 800357f0 <initproc>
    80021d98:	639c                	ld	a5,0(a5)
    80021d9a:	0d050493          	addi	s1,a0,208
    80021d9e:	15050913          	addi	s2,a0,336
    80021da2:	02a79363          	bne	a5,a0,80021dc8 <exit+0x54>
    panic("init exiting");
    80021da6:	00007517          	auipc	a0,0x7
    80021daa:	60a50513          	addi	a0,a0,1546 # 800293b0 <states.1805+0x1c0>
    80021dae:	ffffe097          	auipc	ra,0xffffe
    80021db2:	328080e7          	jalr	808(ra) # 800200d6 <panic>
      fileclose(f);
    80021db6:	00001097          	auipc	ra,0x1
    80021dba:	252080e7          	jalr	594(ra) # 80023008 <fileclose>
      p->ofile[fd] = 0;
    80021dbe:	0004b023          	sd	zero,0(s1)
    80021dc2:	04a1                	addi	s1,s1,8
  for(int fd = 0; fd < NOFILE; fd++){
    80021dc4:	01248563          	beq	s1,s2,80021dce <exit+0x5a>
    if(p->ofile[fd]){
    80021dc8:	6088                	ld	a0,0(s1)
    80021dca:	f575                	bnez	a0,80021db6 <exit+0x42>
    80021dcc:	bfdd                	j	80021dc2 <exit+0x4e>
  eput(p->cwd);
    80021dce:	1509b503          	ld	a0,336(s3)
    80021dd2:	00004097          	auipc	ra,0x4
    80021dd6:	a3c080e7          	jalr	-1476(ra) # 8002580e <eput>
  p->cwd = 0;
    80021dda:	1409b823          	sd	zero,336(s3)
  acquire(&initproc->lock);
    80021dde:	00014497          	auipc	s1,0x14
    80021de2:	a1248493          	addi	s1,s1,-1518 # 800357f0 <initproc>
    80021de6:	6088                	ld	a0,0(s1)
    80021de8:	ffffe097          	auipc	ra,0xffffe
    80021dec:	754080e7          	jalr	1876(ra) # 8002053c <acquire>
  wakeup1(initproc);
    80021df0:	6088                	ld	a0,0(s1)
    80021df2:	fffff097          	auipc	ra,0xfffff
    80021df6:	58e080e7          	jalr	1422(ra) # 80021380 <wakeup1>
  release(&initproc->lock);
    80021dfa:	6088                	ld	a0,0(s1)
    80021dfc:	ffffe097          	auipc	ra,0xffffe
    80021e00:	7f4080e7          	jalr	2036(ra) # 800205f0 <release>
  acquire(&p->lock);
    80021e04:	854e                	mv	a0,s3
    80021e06:	ffffe097          	auipc	ra,0xffffe
    80021e0a:	736080e7          	jalr	1846(ra) # 8002053c <acquire>
  struct proc *original_parent = p->parent;
    80021e0e:	0209b483          	ld	s1,32(s3)
  release(&p->lock);
    80021e12:	854e                	mv	a0,s3
    80021e14:	ffffe097          	auipc	ra,0xffffe
    80021e18:	7dc080e7          	jalr	2012(ra) # 800205f0 <release>
  acquire(&original_parent->lock);
    80021e1c:	8526                	mv	a0,s1
    80021e1e:	ffffe097          	auipc	ra,0xffffe
    80021e22:	71e080e7          	jalr	1822(ra) # 8002053c <acquire>
  acquire(&p->lock);
    80021e26:	854e                	mv	a0,s3
    80021e28:	ffffe097          	auipc	ra,0xffffe
    80021e2c:	714080e7          	jalr	1812(ra) # 8002053c <acquire>
  reparent(p);
    80021e30:	854e                	mv	a0,s3
    80021e32:	00000097          	auipc	ra,0x0
    80021e36:	d44080e7          	jalr	-700(ra) # 80021b76 <reparent>
  wakeup1(original_parent);
    80021e3a:	8526                	mv	a0,s1
    80021e3c:	fffff097          	auipc	ra,0xfffff
    80021e40:	544080e7          	jalr	1348(ra) # 80021380 <wakeup1>
  p->xstate = status;
    80021e44:	0349aa23          	sw	s4,52(s3)
  p->state = ZOMBIE;
    80021e48:	4791                	li	a5,4
    80021e4a:	00f9ac23          	sw	a5,24(s3)
  release(&original_parent->lock);
    80021e4e:	8526                	mv	a0,s1
    80021e50:	ffffe097          	auipc	ra,0xffffe
    80021e54:	7a0080e7          	jalr	1952(ra) # 800205f0 <release>
  sched();
    80021e58:	00000097          	auipc	ra,0x0
    80021e5c:	e44080e7          	jalr	-444(ra) # 80021c9c <sched>
  panic("zombie exit");
    80021e60:	00007517          	auipc	a0,0x7
    80021e64:	56050513          	addi	a0,a0,1376 # 800293c0 <states.1805+0x1d0>
    80021e68:	ffffe097          	auipc	ra,0xffffe
    80021e6c:	26e080e7          	jalr	622(ra) # 800200d6 <panic>

0000000080021e70 <yield>:
{
    80021e70:	1101                	addi	sp,sp,-32
    80021e72:	ec06                	sd	ra,24(sp)
    80021e74:	e822                	sd	s0,16(sp)
    80021e76:	e426                	sd	s1,8(sp)
    80021e78:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80021e7a:	fffff097          	auipc	ra,0xfffff
    80021e7e:	75c080e7          	jalr	1884(ra) # 800215d6 <myproc>
    80021e82:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80021e84:	ffffe097          	auipc	ra,0xffffe
    80021e88:	6b8080e7          	jalr	1720(ra) # 8002053c <acquire>
  p->state = RUNNABLE;
    80021e8c:	4789                	li	a5,2
    80021e8e:	cc9c                	sw	a5,24(s1)
  sched();
    80021e90:	00000097          	auipc	ra,0x0
    80021e94:	e0c080e7          	jalr	-500(ra) # 80021c9c <sched>
  release(&p->lock);
    80021e98:	8526                	mv	a0,s1
    80021e9a:	ffffe097          	auipc	ra,0xffffe
    80021e9e:	756080e7          	jalr	1878(ra) # 800205f0 <release>
}
    80021ea2:	60e2                	ld	ra,24(sp)
    80021ea4:	6442                	ld	s0,16(sp)
    80021ea6:	64a2                	ld	s1,8(sp)
    80021ea8:	6105                	addi	sp,sp,32
    80021eaa:	8082                	ret

0000000080021eac <sleep>:
{
    80021eac:	7179                	addi	sp,sp,-48
    80021eae:	f406                	sd	ra,40(sp)
    80021eb0:	f022                	sd	s0,32(sp)
    80021eb2:	ec26                	sd	s1,24(sp)
    80021eb4:	e84a                	sd	s2,16(sp)
    80021eb6:	e44e                	sd	s3,8(sp)
    80021eb8:	1800                	addi	s0,sp,48
    80021eba:	89aa                	mv	s3,a0
    80021ebc:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80021ebe:	fffff097          	auipc	ra,0xfffff
    80021ec2:	718080e7          	jalr	1816(ra) # 800215d6 <myproc>
    80021ec6:	84aa                	mv	s1,a0
  if(lk != &p->lock){  //DOC: sleeplock0
    80021ec8:	05250663          	beq	a0,s2,80021f14 <sleep+0x68>
    acquire(&p->lock);  //DOC: sleeplock1
    80021ecc:	ffffe097          	auipc	ra,0xffffe
    80021ed0:	670080e7          	jalr	1648(ra) # 8002053c <acquire>
    release(lk);
    80021ed4:	854a                	mv	a0,s2
    80021ed6:	ffffe097          	auipc	ra,0xffffe
    80021eda:	71a080e7          	jalr	1818(ra) # 800205f0 <release>
  p->chan = chan;
    80021ede:	0334b423          	sd	s3,40(s1)
  p->state = SLEEPING;
    80021ee2:	4785                	li	a5,1
    80021ee4:	cc9c                	sw	a5,24(s1)
  sched();
    80021ee6:	00000097          	auipc	ra,0x0
    80021eea:	db6080e7          	jalr	-586(ra) # 80021c9c <sched>
  p->chan = 0;
    80021eee:	0204b423          	sd	zero,40(s1)
    release(&p->lock);
    80021ef2:	8526                	mv	a0,s1
    80021ef4:	ffffe097          	auipc	ra,0xffffe
    80021ef8:	6fc080e7          	jalr	1788(ra) # 800205f0 <release>
    acquire(lk);
    80021efc:	854a                	mv	a0,s2
    80021efe:	ffffe097          	auipc	ra,0xffffe
    80021f02:	63e080e7          	jalr	1598(ra) # 8002053c <acquire>
}
    80021f06:	70a2                	ld	ra,40(sp)
    80021f08:	7402                	ld	s0,32(sp)
    80021f0a:	64e2                	ld	s1,24(sp)
    80021f0c:	6942                	ld	s2,16(sp)
    80021f0e:	69a2                	ld	s3,8(sp)
    80021f10:	6145                	addi	sp,sp,48
    80021f12:	8082                	ret
  p->chan = chan;
    80021f14:	03353423          	sd	s3,40(a0)
  p->state = SLEEPING;
    80021f18:	4785                	li	a5,1
    80021f1a:	cd1c                	sw	a5,24(a0)
  sched();
    80021f1c:	00000097          	auipc	ra,0x0
    80021f20:	d80080e7          	jalr	-640(ra) # 80021c9c <sched>
  p->chan = 0;
    80021f24:	0204b423          	sd	zero,40(s1)
  if(lk != &p->lock){
    80021f28:	bff9                	j	80021f06 <sleep+0x5a>

0000000080021f2a <wait>:
{
    80021f2a:	715d                	addi	sp,sp,-80
    80021f2c:	e486                	sd	ra,72(sp)
    80021f2e:	e0a2                	sd	s0,64(sp)
    80021f30:	fc26                	sd	s1,56(sp)
    80021f32:	f84a                	sd	s2,48(sp)
    80021f34:	f44e                	sd	s3,40(sp)
    80021f36:	f052                	sd	s4,32(sp)
    80021f38:	ec56                	sd	s5,24(sp)
    80021f3a:	e85a                	sd	s6,16(sp)
    80021f3c:	e45e                	sd	s7,8(sp)
    80021f3e:	e062                	sd	s8,0(sp)
    80021f40:	0880                	addi	s0,sp,80
    80021f42:	8c2a                	mv	s8,a0
  struct proc *p = myproc();
    80021f44:	fffff097          	auipc	ra,0xfffff
    80021f48:	692080e7          	jalr	1682(ra) # 800215d6 <myproc>
    80021f4c:	892a                	mv	s2,a0
  acquire(&p->lock);
    80021f4e:	8baa                	mv	s7,a0
    80021f50:	ffffe097          	auipc	ra,0xffffe
    80021f54:	5ec080e7          	jalr	1516(ra) # 8002053c <acquire>
    havekids = 0;
    80021f58:	4b01                	li	s6,0
        if(np->state == ZOMBIE){
    80021f5a:	4a11                	li	s4,4
    for(np = proc; np < &proc[NPROC]; np++){
    80021f5c:	00014997          	auipc	s3,0x14
    80021f60:	89498993          	addi	s3,s3,-1900 # 800357f0 <initproc>
        havekids = 1;
    80021f64:	4a85                	li	s5,1
    havekids = 0;
    80021f66:	875a                	mv	a4,s6
    for(np = proc; np < &proc[NPROC]; np++){
    80021f68:	00012497          	auipc	s1,0x12
    80021f6c:	20848493          	addi	s1,s1,520 # 80034170 <proc>
    80021f70:	a08d                	j	80021fd2 <wait+0xa8>
          pid = np->pid;
    80021f72:	0384a983          	lw	s3,56(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    80021f76:	000c0e63          	beqz	s8,80021f92 <wait+0x68>
    80021f7a:	4691                	li	a3,4
    80021f7c:	03448613          	addi	a2,s1,52
    80021f80:	85e2                	mv	a1,s8
    80021f82:	05093503          	ld	a0,80(s2)
    80021f86:	fffff097          	auipc	ra,0xfffff
    80021f8a:	21a080e7          	jalr	538(ra) # 800211a0 <copyout>
    80021f8e:	02054263          	bltz	a0,80021fb2 <wait+0x88>
          freeproc(np);
    80021f92:	8526                	mv	a0,s1
    80021f94:	fffff097          	auipc	ra,0xfffff
    80021f98:	7ea080e7          	jalr	2026(ra) # 8002177e <freeproc>
          release(&np->lock);
    80021f9c:	8526                	mv	a0,s1
    80021f9e:	ffffe097          	auipc	ra,0xffffe
    80021fa2:	652080e7          	jalr	1618(ra) # 800205f0 <release>
          release(&p->lock);
    80021fa6:	854a                	mv	a0,s2
    80021fa8:	ffffe097          	auipc	ra,0xffffe
    80021fac:	648080e7          	jalr	1608(ra) # 800205f0 <release>
          return pid;
    80021fb0:	a8a9                	j	8002200a <wait+0xe0>
            release(&np->lock);
    80021fb2:	8526                	mv	a0,s1
    80021fb4:	ffffe097          	auipc	ra,0xffffe
    80021fb8:	63c080e7          	jalr	1596(ra) # 800205f0 <release>
            release(&p->lock);
    80021fbc:	854a                	mv	a0,s2
    80021fbe:	ffffe097          	auipc	ra,0xffffe
    80021fc2:	632080e7          	jalr	1586(ra) # 800205f0 <release>
            return -1;
    80021fc6:	59fd                	li	s3,-1
    80021fc8:	a089                	j	8002200a <wait+0xe0>
    for(np = proc; np < &proc[NPROC]; np++){
    80021fca:	16848493          	addi	s1,s1,360
    80021fce:	03348463          	beq	s1,s3,80021ff6 <wait+0xcc>
      if(np->parent == p){
    80021fd2:	709c                	ld	a5,32(s1)
    80021fd4:	ff279be3          	bne	a5,s2,80021fca <wait+0xa0>
        acquire(&np->lock);
    80021fd8:	8526                	mv	a0,s1
    80021fda:	ffffe097          	auipc	ra,0xffffe
    80021fde:	562080e7          	jalr	1378(ra) # 8002053c <acquire>
        if(np->state == ZOMBIE){
    80021fe2:	4c9c                	lw	a5,24(s1)
    80021fe4:	f94787e3          	beq	a5,s4,80021f72 <wait+0x48>
        release(&np->lock);
    80021fe8:	8526                	mv	a0,s1
    80021fea:	ffffe097          	auipc	ra,0xffffe
    80021fee:	606080e7          	jalr	1542(ra) # 800205f0 <release>
        havekids = 1;
    80021ff2:	8756                	mv	a4,s5
    80021ff4:	bfd9                	j	80021fca <wait+0xa0>
    if(!havekids || p->killed){
    80021ff6:	c701                	beqz	a4,80021ffe <wait+0xd4>
    80021ff8:	03092783          	lw	a5,48(s2)
    80021ffc:	c785                	beqz	a5,80022024 <wait+0xfa>
      release(&p->lock);
    80021ffe:	854a                	mv	a0,s2
    80022000:	ffffe097          	auipc	ra,0xffffe
    80022004:	5f0080e7          	jalr	1520(ra) # 800205f0 <release>
      return -1;
    80022008:	59fd                	li	s3,-1
}
    8002200a:	854e                	mv	a0,s3
    8002200c:	60a6                	ld	ra,72(sp)
    8002200e:	6406                	ld	s0,64(sp)
    80022010:	74e2                	ld	s1,56(sp)
    80022012:	7942                	ld	s2,48(sp)
    80022014:	79a2                	ld	s3,40(sp)
    80022016:	7a02                	ld	s4,32(sp)
    80022018:	6ae2                	ld	s5,24(sp)
    8002201a:	6b42                	ld	s6,16(sp)
    8002201c:	6ba2                	ld	s7,8(sp)
    8002201e:	6c02                	ld	s8,0(sp)
    80022020:	6161                	addi	sp,sp,80
    80022022:	8082                	ret
    sleep(p, &p->lock);  //DOC: wait-sleep
    80022024:	85de                	mv	a1,s7
    80022026:	854a                	mv	a0,s2
    80022028:	00000097          	auipc	ra,0x0
    8002202c:	e84080e7          	jalr	-380(ra) # 80021eac <sleep>
    havekids = 0;
    80022030:	bf1d                	j	80021f66 <wait+0x3c>

0000000080022032 <wakeup>:
{
    80022032:	7139                	addi	sp,sp,-64
    80022034:	fc06                	sd	ra,56(sp)
    80022036:	f822                	sd	s0,48(sp)
    80022038:	f426                	sd	s1,40(sp)
    8002203a:	f04a                	sd	s2,32(sp)
    8002203c:	ec4e                	sd	s3,24(sp)
    8002203e:	e852                	sd	s4,16(sp)
    80022040:	e456                	sd	s5,8(sp)
    80022042:	0080                	addi	s0,sp,64
    80022044:	8a2a                	mv	s4,a0
  for(p = proc; p < &proc[NPROC]; p++) {
    80022046:	00012497          	auipc	s1,0x12
    8002204a:	12a48493          	addi	s1,s1,298 # 80034170 <proc>
    if(p->state == SLEEPING && p->chan == chan) {
    8002204e:	4985                	li	s3,1
      p->state = RUNNABLE;
    80022050:	4a89                	li	s5,2
  for(p = proc; p < &proc[NPROC]; p++) {
    80022052:	00013917          	auipc	s2,0x13
    80022056:	79e90913          	addi	s2,s2,1950 # 800357f0 <initproc>
    8002205a:	a821                	j	80022072 <wakeup+0x40>
      p->state = RUNNABLE;
    8002205c:	0154ac23          	sw	s5,24(s1)
    release(&p->lock);
    80022060:	8526                	mv	a0,s1
    80022062:	ffffe097          	auipc	ra,0xffffe
    80022066:	58e080e7          	jalr	1422(ra) # 800205f0 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8002206a:	16848493          	addi	s1,s1,360
    8002206e:	01248e63          	beq	s1,s2,8002208a <wakeup+0x58>
    acquire(&p->lock);
    80022072:	8526                	mv	a0,s1
    80022074:	ffffe097          	auipc	ra,0xffffe
    80022078:	4c8080e7          	jalr	1224(ra) # 8002053c <acquire>
    if(p->state == SLEEPING && p->chan == chan) {
    8002207c:	4c9c                	lw	a5,24(s1)
    8002207e:	ff3791e3          	bne	a5,s3,80022060 <wakeup+0x2e>
    80022082:	749c                	ld	a5,40(s1)
    80022084:	fd479ee3          	bne	a5,s4,80022060 <wakeup+0x2e>
    80022088:	bfd1                	j	8002205c <wakeup+0x2a>
}
    8002208a:	70e2                	ld	ra,56(sp)
    8002208c:	7442                	ld	s0,48(sp)
    8002208e:	74a2                	ld	s1,40(sp)
    80022090:	7902                	ld	s2,32(sp)
    80022092:	69e2                	ld	s3,24(sp)
    80022094:	6a42                	ld	s4,16(sp)
    80022096:	6aa2                	ld	s5,8(sp)
    80022098:	6121                	addi	sp,sp,64
    8002209a:	8082                	ret

000000008002209c <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    8002209c:	7179                	addi	sp,sp,-48
    8002209e:	f406                	sd	ra,40(sp)
    800220a0:	f022                	sd	s0,32(sp)
    800220a2:	ec26                	sd	s1,24(sp)
    800220a4:	e84a                	sd	s2,16(sp)
    800220a6:	e44e                	sd	s3,8(sp)
    800220a8:	1800                	addi	s0,sp,48
    800220aa:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800220ac:	00012497          	auipc	s1,0x12
    800220b0:	0c448493          	addi	s1,s1,196 # 80034170 <proc>
    800220b4:	00013997          	auipc	s3,0x13
    800220b8:	73c98993          	addi	s3,s3,1852 # 800357f0 <initproc>
    acquire(&p->lock);
    800220bc:	8526                	mv	a0,s1
    800220be:	ffffe097          	auipc	ra,0xffffe
    800220c2:	47e080e7          	jalr	1150(ra) # 8002053c <acquire>
    if(p->pid == pid){
    800220c6:	5c9c                	lw	a5,56(s1)
    800220c8:	03278363          	beq	a5,s2,800220ee <kill+0x52>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800220cc:	8526                	mv	a0,s1
    800220ce:	ffffe097          	auipc	ra,0xffffe
    800220d2:	522080e7          	jalr	1314(ra) # 800205f0 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800220d6:	16848493          	addi	s1,s1,360
    800220da:	ff3491e3          	bne	s1,s3,800220bc <kill+0x20>
  }
  return -1;
    800220de:	557d                	li	a0,-1
}
    800220e0:	70a2                	ld	ra,40(sp)
    800220e2:	7402                	ld	s0,32(sp)
    800220e4:	64e2                	ld	s1,24(sp)
    800220e6:	6942                	ld	s2,16(sp)
    800220e8:	69a2                	ld	s3,8(sp)
    800220ea:	6145                	addi	sp,sp,48
    800220ec:	8082                	ret
      p->killed = 1;
    800220ee:	4785                	li	a5,1
    800220f0:	d89c                	sw	a5,48(s1)
      if(p->state == SLEEPING){
    800220f2:	4c98                	lw	a4,24(s1)
    800220f4:	00f70963          	beq	a4,a5,80022106 <kill+0x6a>
      release(&p->lock);
    800220f8:	8526                	mv	a0,s1
    800220fa:	ffffe097          	auipc	ra,0xffffe
    800220fe:	4f6080e7          	jalr	1270(ra) # 800205f0 <release>
      return 0;
    80022102:	4501                	li	a0,0
    80022104:	bff1                	j	800220e0 <kill+0x44>
        p->state = RUNNABLE;
    80022106:	4789                	li	a5,2
    80022108:	cc9c                	sw	a5,24(s1)
    8002210a:	b7fd                	j	800220f8 <kill+0x5c>

000000008002210c <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8002210c:	7179                	addi	sp,sp,-48
    8002210e:	f406                	sd	ra,40(sp)
    80022110:	f022                	sd	s0,32(sp)
    80022112:	ec26                	sd	s1,24(sp)
    80022114:	e84a                	sd	s2,16(sp)
    80022116:	e44e                	sd	s3,8(sp)
    80022118:	e052                	sd	s4,0(sp)
    8002211a:	1800                	addi	s0,sp,48
    8002211c:	84aa                	mv	s1,a0
    8002211e:	892e                	mv	s2,a1
    80022120:	89b2                	mv	s3,a2
    80022122:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80022124:	fffff097          	auipc	ra,0xfffff
    80022128:	4b2080e7          	jalr	1202(ra) # 800215d6 <myproc>
  if(user_dst){
    8002212c:	c08d                	beqz	s1,8002214e <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    8002212e:	86d2                	mv	a3,s4
    80022130:	864e                	mv	a2,s3
    80022132:	85ca                	mv	a1,s2
    80022134:	6928                	ld	a0,80(a0)
    80022136:	fffff097          	auipc	ra,0xfffff
    8002213a:	06a080e7          	jalr	106(ra) # 800211a0 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8002213e:	70a2                	ld	ra,40(sp)
    80022140:	7402                	ld	s0,32(sp)
    80022142:	64e2                	ld	s1,24(sp)
    80022144:	6942                	ld	s2,16(sp)
    80022146:	69a2                	ld	s3,8(sp)
    80022148:	6a02                	ld	s4,0(sp)
    8002214a:	6145                	addi	sp,sp,48
    8002214c:	8082                	ret
    memmove((char *)dst, src, len);
    8002214e:	000a061b          	sext.w	a2,s4
    80022152:	85ce                	mv	a1,s3
    80022154:	854a                	mv	a0,s2
    80022156:	ffffe097          	auipc	ra,0xffffe
    8002215a:	54e080e7          	jalr	1358(ra) # 800206a4 <memmove>
    return 0;
    8002215e:	8526                	mv	a0,s1
    80022160:	bff9                	j	8002213e <either_copyout+0x32>

0000000080022162 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80022162:	7179                	addi	sp,sp,-48
    80022164:	f406                	sd	ra,40(sp)
    80022166:	f022                	sd	s0,32(sp)
    80022168:	ec26                	sd	s1,24(sp)
    8002216a:	e84a                	sd	s2,16(sp)
    8002216c:	e44e                	sd	s3,8(sp)
    8002216e:	e052                	sd	s4,0(sp)
    80022170:	1800                	addi	s0,sp,48
    80022172:	892a                	mv	s2,a0
    80022174:	84ae                	mv	s1,a1
    80022176:	89b2                	mv	s3,a2
    80022178:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8002217a:	fffff097          	auipc	ra,0xfffff
    8002217e:	45c080e7          	jalr	1116(ra) # 800215d6 <myproc>
  if(user_src){
    80022182:	c08d                	beqz	s1,800221a4 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80022184:	86d2                	mv	a3,s4
    80022186:	864e                	mv	a2,s3
    80022188:	85ca                	mv	a1,s2
    8002218a:	6928                	ld	a0,80(a0)
    8002218c:	fffff097          	auipc	ra,0xfffff
    80022190:	0a0080e7          	jalr	160(ra) # 8002122c <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80022194:	70a2                	ld	ra,40(sp)
    80022196:	7402                	ld	s0,32(sp)
    80022198:	64e2                	ld	s1,24(sp)
    8002219a:	6942                	ld	s2,16(sp)
    8002219c:	69a2                	ld	s3,8(sp)
    8002219e:	6a02                	ld	s4,0(sp)
    800221a0:	6145                	addi	sp,sp,48
    800221a2:	8082                	ret
    memmove(dst, (char*)src, len);
    800221a4:	000a061b          	sext.w	a2,s4
    800221a8:	85ce                	mv	a1,s3
    800221aa:	854a                	mv	a0,s2
    800221ac:	ffffe097          	auipc	ra,0xffffe
    800221b0:	4f8080e7          	jalr	1272(ra) # 800206a4 <memmove>
    return 0;
    800221b4:	8526                	mv	a0,s1
    800221b6:	bff9                	j	80022194 <either_copyin+0x32>

00000000800221b8 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800221b8:	715d                	addi	sp,sp,-80
    800221ba:	e486                	sd	ra,72(sp)
    800221bc:	e0a2                	sd	s0,64(sp)
    800221be:	fc26                	sd	s1,56(sp)
    800221c0:	f84a                	sd	s2,48(sp)
    800221c2:	f44e                	sd	s3,40(sp)
    800221c4:	f052                	sd	s4,32(sp)
    800221c6:	ec56                	sd	s5,24(sp)
    800221c8:	e85a                	sd	s6,16(sp)
    800221ca:	e45e                	sd	s7,8(sp)
    800221cc:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800221ce:	00008517          	auipc	a0,0x8
    800221d2:	82a50513          	addi	a0,a0,-2006 # 800299f8 <syscalls+0x4a8>
    800221d6:	ffffe097          	auipc	ra,0xffffe
    800221da:	f42080e7          	jalr	-190(ra) # 80020118 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800221de:	00012497          	auipc	s1,0x12
    800221e2:	0ea48493          	addi	s1,s1,234 # 800342c8 <proc+0x158>
    800221e6:	00013917          	auipc	s2,0x13
    800221ea:	76290913          	addi	s2,s2,1890 # 80035948 <bcache+0x130>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800221ee:	4b11                	li	s6,4
      state = states[p->state];
    else
      state = "???";
    800221f0:	00007997          	auipc	s3,0x7
    800221f4:	1e098993          	addi	s3,s3,480 # 800293d0 <states.1805+0x1e0>
    printf("%d %s %s", p->pid, state, p->name);
    800221f8:	00007a97          	auipc	s5,0x7
    800221fc:	1e0a8a93          	addi	s5,s5,480 # 800293d8 <states.1805+0x1e8>
    printf("\n");
    80022200:	00007a17          	auipc	s4,0x7
    80022204:	7f8a0a13          	addi	s4,s4,2040 # 800299f8 <syscalls+0x4a8>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80022208:	00007b97          	auipc	s7,0x7
    8002220c:	fe8b8b93          	addi	s7,s7,-24 # 800291f0 <states.1805>
    80022210:	a015                	j	80022234 <procdump+0x7c>
    printf("%d %s %s", p->pid, state, p->name);
    80022212:	86ba                	mv	a3,a4
    80022214:	ee072583          	lw	a1,-288(a4)
    80022218:	8556                	mv	a0,s5
    8002221a:	ffffe097          	auipc	ra,0xffffe
    8002221e:	efe080e7          	jalr	-258(ra) # 80020118 <printf>
    printf("\n");
    80022222:	8552                	mv	a0,s4
    80022224:	ffffe097          	auipc	ra,0xffffe
    80022228:	ef4080e7          	jalr	-268(ra) # 80020118 <printf>
    8002222c:	16848493          	addi	s1,s1,360
  for(p = proc; p < &proc[NPROC]; p++){
    80022230:	03248163          	beq	s1,s2,80022252 <procdump+0x9a>
    if(p->state == UNUSED)
    80022234:	8726                	mv	a4,s1
    80022236:	ec04a783          	lw	a5,-320(s1)
    8002223a:	dbed                	beqz	a5,8002222c <procdump+0x74>
      state = "???";
    8002223c:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8002223e:	fcfb6ae3          	bltu	s6,a5,80022212 <procdump+0x5a>
    80022242:	1782                	slli	a5,a5,0x20
    80022244:	9381                	srli	a5,a5,0x20
    80022246:	078e                	slli	a5,a5,0x3
    80022248:	97de                	add	a5,a5,s7
    8002224a:	6390                	ld	a2,0(a5)
    8002224c:	f279                	bnez	a2,80022212 <procdump+0x5a>
      state = "???";
    8002224e:	864e                	mv	a2,s3
    80022250:	b7c9                	j	80022212 <procdump+0x5a>
  }
}
    80022252:	60a6                	ld	ra,72(sp)
    80022254:	6406                	ld	s0,64(sp)
    80022256:	74e2                	ld	s1,56(sp)
    80022258:	7942                	ld	s2,48(sp)
    8002225a:	79a2                	ld	s3,40(sp)
    8002225c:	7a02                	ld	s4,32(sp)
    8002225e:	6ae2                	ld	s5,24(sp)
    80022260:	6b42                	ld	s6,16(sp)
    80022262:	6ba2                	ld	s7,8(sp)
    80022264:	6161                	addi	sp,sp,80
    80022266:	8082                	ret

0000000080022268 <swtch>:
    80022268:	00153023          	sd	ra,0(a0)
    8002226c:	00253423          	sd	sp,8(a0)
    80022270:	e900                	sd	s0,16(a0)
    80022272:	ed04                	sd	s1,24(a0)
    80022274:	03253023          	sd	s2,32(a0)
    80022278:	03353423          	sd	s3,40(a0)
    8002227c:	03453823          	sd	s4,48(a0)
    80022280:	03553c23          	sd	s5,56(a0)
    80022284:	05653023          	sd	s6,64(a0)
    80022288:	05753423          	sd	s7,72(a0)
    8002228c:	05853823          	sd	s8,80(a0)
    80022290:	05953c23          	sd	s9,88(a0)
    80022294:	07a53023          	sd	s10,96(a0)
    80022298:	07b53423          	sd	s11,104(a0)
    8002229c:	0005b083          	ld	ra,0(a1)
    800222a0:	0085b103          	ld	sp,8(a1)
    800222a4:	6980                	ld	s0,16(a1)
    800222a6:	6d84                	ld	s1,24(a1)
    800222a8:	0205b903          	ld	s2,32(a1)
    800222ac:	0285b983          	ld	s3,40(a1)
    800222b0:	0305ba03          	ld	s4,48(a1)
    800222b4:	0385ba83          	ld	s5,56(a1)
    800222b8:	0405bb03          	ld	s6,64(a1)
    800222bc:	0485bb83          	ld	s7,72(a1)
    800222c0:	0505bc03          	ld	s8,80(a1)
    800222c4:	0585bc83          	ld	s9,88(a1)
    800222c8:	0605bd03          	ld	s10,96(a1)
    800222cc:	0685bd83          	ld	s11,104(a1)
    800222d0:	8082                	ret

00000000800222d2 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    800222d2:	1141                	addi	sp,sp,-16
    800222d4:	e406                	sd	ra,8(sp)
    800222d6:	e022                	sd	s0,0(sp)
    800222d8:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    800222da:	00007597          	auipc	a1,0x7
    800222de:	13658593          	addi	a1,a1,310 # 80029410 <states.1805+0x220>
    800222e2:	00013517          	auipc	a0,0x13
    800222e6:	51650513          	addi	a0,a0,1302 # 800357f8 <tickslock>
    800222ea:	ffffe097          	auipc	ra,0xffffe
    800222ee:	1c2080e7          	jalr	450(ra) # 800204ac <initlock>
  printf("trapinit\n");
    800222f2:	00007517          	auipc	a0,0x7
    800222f6:	12650513          	addi	a0,a0,294 # 80029418 <states.1805+0x228>
    800222fa:	ffffe097          	auipc	ra,0xffffe
    800222fe:	e1e080e7          	jalr	-482(ra) # 80020118 <printf>
}
    80022302:	60a2                	ld	ra,8(sp)
    80022304:	6402                	ld	s0,0(sp)
    80022306:	0141                	addi	sp,sp,16
    80022308:	8082                	ret

000000008002230a <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    8002230a:	1141                	addi	sp,sp,-16
    8002230c:	e406                	sd	ra,8(sp)
    8002230e:	e022                	sd	s0,0(sp)
    80022310:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80022312:	00002797          	auipc	a5,0x2
    80022316:	0ae78793          	addi	a5,a5,174 # 800243c0 <kernelvec>
    8002231a:	10579073          	csrw	stvec,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002231e:	100027f3          	csrr	a5,sstatus
  w_stvec((uint64)kernelvec);
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80022322:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022326:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    8002232a:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_SSIE);
    8002232e:	2027e793          	ori	a5,a5,514
  asm volatile("csrw sie, %0" : : "r" (x));
    80022332:	10479073          	csrw	sie,a5
  printf("trapinithart\n");
    80022336:	00007517          	auipc	a0,0x7
    8002233a:	0f250513          	addi	a0,a0,242 # 80029428 <states.1805+0x238>
    8002233e:	ffffe097          	auipc	ra,0xffffe
    80022342:	dda080e7          	jalr	-550(ra) # 80020118 <printf>
}
    80022346:	60a2                	ld	ra,8(sp)
    80022348:	6402                	ld	s0,0(sp)
    8002234a:	0141                	addi	sp,sp,16
    8002234c:	8082                	ret

000000008002234e <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    8002234e:	1141                	addi	sp,sp,-16
    80022350:	e406                	sd	ra,8(sp)
    80022352:	e022                	sd	s0,0(sp)
    80022354:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80022356:	fffff097          	auipc	ra,0xfffff
    8002235a:	280080e7          	jalr	640(ra) # 800215d6 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002235e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80022362:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80022364:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80022368:	00006617          	auipc	a2,0x6
    8002236c:	c9860613          	addi	a2,a2,-872 # 80028000 <_trampoline>
    80022370:	00006697          	auipc	a3,0x6
    80022374:	c9068693          	addi	a3,a3,-880 # 80028000 <_trampoline>
    80022378:	8e91                	sub	a3,a3,a2
    8002237a:	040007b7          	lui	a5,0x4000
    8002237e:	17fd                	addi	a5,a5,-1
    80022380:	07b2                	slli	a5,a5,0xc
    80022382:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80022384:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80022388:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    8002238a:	180026f3          	csrr	a3,satp
    8002238e:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80022390:	6d38                	ld	a4,88(a0)
    80022392:	6134                	ld	a3,64(a0)
    80022394:	6585                	lui	a1,0x1
    80022396:	96ae                	add	a3,a3,a1
    80022398:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    8002239a:	6d38                	ld	a4,88(a0)
    8002239c:	00000697          	auipc	a3,0x0
    800223a0:	0de68693          	addi	a3,a3,222 # 8002247a <usertrap>
    800223a4:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800223a6:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800223a8:	8692                	mv	a3,tp
    800223aa:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800223ac:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800223b0:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800223b4:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800223b8:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800223bc:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800223be:	6f18                	ld	a4,24(a4)
    800223c0:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  // printf("[usertrapret]p->pagetable: %p\n", p->pagetable);
  uint64 satp = MAKE_SATP(p->pagetable);
    800223c4:	692c                	ld	a1,80(a0)
    800223c6:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    800223c8:	00006717          	auipc	a4,0x6
    800223cc:	cc870713          	addi	a4,a4,-824 # 80028090 <userret>
    800223d0:	8f11                	sub	a4,a4,a2
    800223d2:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    800223d4:	577d                	li	a4,-1
    800223d6:	177e                	slli	a4,a4,0x3f
    800223d8:	8dd9                	or	a1,a1,a4
    800223da:	02000537          	lui	a0,0x2000
    800223de:	157d                	addi	a0,a0,-1
    800223e0:	0536                	slli	a0,a0,0xd
    800223e2:	9782                	jalr	a5
}
    800223e4:	60a2                	ld	ra,8(sp)
    800223e6:	6402                	ld	s0,0(sp)
    800223e8:	0141                	addi	sp,sp,16
    800223ea:	8082                	ret

00000000800223ec <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800223ec:	1101                	addi	sp,sp,-32
    800223ee:	ec06                	sd	ra,24(sp)
    800223f0:	e822                	sd	s0,16(sp)
    800223f2:	e426                	sd	s1,8(sp)
    800223f4:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    800223f6:	00013497          	auipc	s1,0x13
    800223fa:	40248493          	addi	s1,s1,1026 # 800357f8 <tickslock>
    800223fe:	8526                	mv	a0,s1
    80022400:	ffffe097          	auipc	ra,0xffffe
    80022404:	13c080e7          	jalr	316(ra) # 8002053c <acquire>
  ticks++;
    80022408:	00013517          	auipc	a0,0x13
    8002240c:	40850513          	addi	a0,a0,1032 # 80035810 <ticks>
    80022410:	411c                	lw	a5,0(a0)
    80022412:	2785                	addiw	a5,a5,1
    80022414:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80022416:	00000097          	auipc	ra,0x0
    8002241a:	c1c080e7          	jalr	-996(ra) # 80022032 <wakeup>
  release(&tickslock);
    8002241e:	8526                	mv	a0,s1
    80022420:	ffffe097          	auipc	ra,0xffffe
    80022424:	1d0080e7          	jalr	464(ra) # 800205f0 <release>
}
    80022428:	60e2                	ld	ra,24(sp)
    8002242a:	6442                	ld	s0,16(sp)
    8002242c:	64a2                	ld	s1,8(sp)
    8002242e:	6105                	addi	sp,sp,32
    80022430:	8082                	ret

0000000080022432 <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022432:	14202773          	csrr	a4,scause
int
devintr()
{
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80022436:	00074963          	bltz	a4,80022448 <devintr+0x16>
      plic_complete(irq);
    #endif

    return 1;
  } 
  else if(scause == 0x8000000000000005L)
    8002243a:	57fd                	li	a5,-1
    8002243c:	17fe                	slli	a5,a5,0x3f
    8002243e:	0795                	addi	a5,a5,5
    w_sip(r_sip() & ~2);

    return 2;
  }
  else {
    return 0;
    80022440:	4501                	li	a0,0
  else if(scause == 0x8000000000000005L)
    80022442:	00f70a63          	beq	a4,a5,80022456 <devintr+0x24>
  }
}
    80022446:	8082                	ret
     (scause & 0xff) == 9){
    80022448:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    8002244c:	46a5                	li	a3,9
    return 1;
    8002244e:	4505                	li	a0,1
  if((scause & 0x8000000000000000L) &&
    80022450:	fed795e3          	bne	a5,a3,8002243a <devintr+0x8>
    80022454:	bfcd                	j	80022446 <devintr+0x14>
{
    80022456:	1141                	addi	sp,sp,-16
    80022458:	e406                	sd	ra,8(sp)
    8002245a:	e022                	sd	s0,0(sp)
    8002245c:	0800                	addi	s0,sp,16
    if(cpuid() == 0){
    8002245e:	fffff097          	auipc	ra,0xfffff
    80022462:	14c080e7          	jalr	332(ra) # 800215aa <cpuid>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80022466:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    8002246a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    8002246c:	14479073          	csrw	sip,a5
    return 2;
    80022470:	4509                	li	a0,2
}
    80022472:	60a2                	ld	ra,8(sp)
    80022474:	6402                	ld	s0,0(sp)
    80022476:	0141                	addi	sp,sp,16
    80022478:	8082                	ret

000000008002247a <usertrap>:
{
    8002247a:	1101                	addi	sp,sp,-32
    8002247c:	ec06                	sd	ra,24(sp)
    8002247e:	e822                	sd	s0,16(sp)
    80022480:	e426                	sd	s1,8(sp)
    80022482:	e04a                	sd	s2,0(sp)
    80022484:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022486:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    8002248a:	1007f793          	andi	a5,a5,256
    8002248e:	e3ad                	bnez	a5,800224f0 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80022490:	00002797          	auipc	a5,0x2
    80022494:	f3078793          	addi	a5,a5,-208 # 800243c0 <kernelvec>
    80022498:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    8002249c:	fffff097          	auipc	ra,0xfffff
    800224a0:	13a080e7          	jalr	314(ra) # 800215d6 <myproc>
    800224a4:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    800224a6:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800224a8:	14102773          	csrr	a4,sepc
    800224ac:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    800224ae:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    800224b2:	47a1                	li	a5,8
    800224b4:	04f71c63          	bne	a4,a5,8002250c <usertrap+0x92>
    if(p->killed)
    800224b8:	591c                	lw	a5,48(a0)
    800224ba:	e3b9                	bnez	a5,80022500 <usertrap+0x86>
    p->trapframe->epc += 4;
    800224bc:	6cb8                	ld	a4,88(s1)
    800224be:	6f1c                	ld	a5,24(a4)
    800224c0:	0791                	addi	a5,a5,4
    800224c2:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800224c4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800224c8:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800224cc:	10079073          	csrw	sstatus,a5
    syscall();
    800224d0:	00000097          	auipc	ra,0x0
    800224d4:	38c080e7          	jalr	908(ra) # 8002285c <syscall>
  if(p->killed)
    800224d8:	589c                	lw	a5,48(s1)
    800224da:	ebc1                	bnez	a5,8002256a <usertrap+0xf0>
  usertrapret();
    800224dc:	00000097          	auipc	ra,0x0
    800224e0:	e72080e7          	jalr	-398(ra) # 8002234e <usertrapret>
}
    800224e4:	60e2                	ld	ra,24(sp)
    800224e6:	6442                	ld	s0,16(sp)
    800224e8:	64a2                	ld	s1,8(sp)
    800224ea:	6902                	ld	s2,0(sp)
    800224ec:	6105                	addi	sp,sp,32
    800224ee:	8082                	ret
    panic("usertrap: not from user mode");
    800224f0:	00007517          	auipc	a0,0x7
    800224f4:	f4850513          	addi	a0,a0,-184 # 80029438 <states.1805+0x248>
    800224f8:	ffffe097          	auipc	ra,0xffffe
    800224fc:	bde080e7          	jalr	-1058(ra) # 800200d6 <panic>
      exit(-1);
    80022500:	557d                	li	a0,-1
    80022502:	00000097          	auipc	ra,0x0
    80022506:	872080e7          	jalr	-1934(ra) # 80021d74 <exit>
    8002250a:	bf4d                	j	800224bc <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    8002250c:	00000097          	auipc	ra,0x0
    80022510:	f26080e7          	jalr	-218(ra) # 80022432 <devintr>
    80022514:	892a                	mv	s2,a0
    80022516:	c501                	beqz	a0,8002251e <usertrap+0xa4>
  if(p->killed)
    80022518:	589c                	lw	a5,48(s1)
    8002251a:	c3a1                	beqz	a5,8002255a <usertrap+0xe0>
    8002251c:	a815                	j	80022550 <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    8002251e:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80022522:	5c90                	lw	a2,56(s1)
    80022524:	00007517          	auipc	a0,0x7
    80022528:	f3450513          	addi	a0,a0,-204 # 80029458 <states.1805+0x268>
    8002252c:	ffffe097          	auipc	ra,0xffffe
    80022530:	bec080e7          	jalr	-1044(ra) # 80020118 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80022534:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80022538:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    8002253c:	00007517          	auipc	a0,0x7
    80022540:	f4c50513          	addi	a0,a0,-180 # 80029488 <states.1805+0x298>
    80022544:	ffffe097          	auipc	ra,0xffffe
    80022548:	bd4080e7          	jalr	-1068(ra) # 80020118 <printf>
    p->killed = 1;
    8002254c:	4785                	li	a5,1
    8002254e:	d89c                	sw	a5,48(s1)
    exit(-1);
    80022550:	557d                	li	a0,-1
    80022552:	00000097          	auipc	ra,0x0
    80022556:	822080e7          	jalr	-2014(ra) # 80021d74 <exit>
  if(which_dev == 2)
    8002255a:	4789                	li	a5,2
    8002255c:	f8f910e3          	bne	s2,a5,800224dc <usertrap+0x62>
    yield();
    80022560:	00000097          	auipc	ra,0x0
    80022564:	910080e7          	jalr	-1776(ra) # 80021e70 <yield>
    80022568:	bf95                	j	800224dc <usertrap+0x62>
  int which_dev = 0;
    8002256a:	4901                	li	s2,0
    8002256c:	b7d5                	j	80022550 <usertrap+0xd6>

000000008002256e <kerneltrap>:
{
    8002256e:	7179                	addi	sp,sp,-48
    80022570:	f406                	sd	ra,40(sp)
    80022572:	f022                	sd	s0,32(sp)
    80022574:	ec26                	sd	s1,24(sp)
    80022576:	e84a                	sd	s2,16(sp)
    80022578:	e44e                	sd	s3,8(sp)
    8002257a:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8002257c:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80022580:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80022584:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80022588:	1004f793          	andi	a5,s1,256
    8002258c:	cb85                	beqz	a5,800225bc <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8002258e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80022592:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80022594:	ef85                	bnez	a5,800225cc <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80022596:	00000097          	auipc	ra,0x0
    8002259a:	e9c080e7          	jalr	-356(ra) # 80022432 <devintr>
    8002259e:	cd1d                	beqz	a0,800225dc <kerneltrap+0x6e>
  if(which_dev == 2) {
    800225a0:	4789                	li	a5,2
    800225a2:	06f50a63          	beq	a0,a5,80022616 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    800225a6:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800225aa:	10049073          	csrw	sstatus,s1
}
    800225ae:	70a2                	ld	ra,40(sp)
    800225b0:	7402                	ld	s0,32(sp)
    800225b2:	64e2                	ld	s1,24(sp)
    800225b4:	6942                	ld	s2,16(sp)
    800225b6:	69a2                	ld	s3,8(sp)
    800225b8:	6145                	addi	sp,sp,48
    800225ba:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    800225bc:	00007517          	auipc	a0,0x7
    800225c0:	eec50513          	addi	a0,a0,-276 # 800294a8 <states.1805+0x2b8>
    800225c4:	ffffe097          	auipc	ra,0xffffe
    800225c8:	b12080e7          	jalr	-1262(ra) # 800200d6 <panic>
    panic("kerneltrap: interrupts enabled");
    800225cc:	00007517          	auipc	a0,0x7
    800225d0:	f0450513          	addi	a0,a0,-252 # 800294d0 <states.1805+0x2e0>
    800225d4:	ffffe097          	auipc	ra,0xffffe
    800225d8:	b02080e7          	jalr	-1278(ra) # 800200d6 <panic>
    printf("scause %p\n", scause);
    800225dc:	85ce                	mv	a1,s3
    800225de:	00007517          	auipc	a0,0x7
    800225e2:	f1250513          	addi	a0,a0,-238 # 800294f0 <states.1805+0x300>
    800225e6:	ffffe097          	auipc	ra,0xffffe
    800225ea:	b32080e7          	jalr	-1230(ra) # 80020118 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800225ee:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800225f2:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    800225f6:	00007517          	auipc	a0,0x7
    800225fa:	f0a50513          	addi	a0,a0,-246 # 80029500 <states.1805+0x310>
    800225fe:	ffffe097          	auipc	ra,0xffffe
    80022602:	b1a080e7          	jalr	-1254(ra) # 80020118 <printf>
    panic("kerneltrap");
    80022606:	00007517          	auipc	a0,0x7
    8002260a:	f1250513          	addi	a0,a0,-238 # 80029518 <states.1805+0x328>
    8002260e:	ffffe097          	auipc	ra,0xffffe
    80022612:	ac8080e7          	jalr	-1336(ra) # 800200d6 <panic>
    timer_tick();
    80022616:	00002097          	auipc	ra,0x2
    8002261a:	ed2080e7          	jalr	-302(ra) # 800244e8 <timer_tick>
    if(myproc() != 0 && myproc()->state == RUNNING) {
    8002261e:	fffff097          	auipc	ra,0xfffff
    80022622:	fb8080e7          	jalr	-72(ra) # 800215d6 <myproc>
    80022626:	d141                	beqz	a0,800225a6 <kerneltrap+0x38>
    80022628:	fffff097          	auipc	ra,0xfffff
    8002262c:	fae080e7          	jalr	-82(ra) # 800215d6 <myproc>
    80022630:	4d18                	lw	a4,24(a0)
    80022632:	478d                	li	a5,3
    80022634:	f6f719e3          	bne	a4,a5,800225a6 <kerneltrap+0x38>
      yield();
    80022638:	00000097          	auipc	ra,0x0
    8002263c:	838080e7          	jalr	-1992(ra) # 80021e70 <yield>
    80022640:	b79d                	j	800225a6 <kerneltrap+0x38>

0000000080022642 <supervisor_external_handler>:

#ifndef QEMU
void
supervisor_external_handler() {
    80022642:	1141                	addi	sp,sp,-16
    80022644:	e422                	sd	s0,8(sp)
    80022646:	0800                	addi	s0,sp,16
  int irq = *(uint32*)(PLIC + 0x04);
  if(irq == UARTHS_IRQ) {
    80022648:	0c2007b7          	lui	a5,0xc200
    8002264c:	43d8                	lw	a4,4(a5)
    8002264e:	02100793          	li	a5,33
    80022652:	00f70363          	beq	a4,a5,80022658 <supervisor_external_handler+0x16>
    // UARTHS
  }
  else
  {
    while (1);
    80022656:	a001                	j	80022656 <supervisor_external_handler+0x14>
  }
}
    80022658:	6422                	ld	s0,8(sp)
    8002265a:	0141                	addi	sp,sp,16
    8002265c:	8082                	ret

000000008002265e <device_init>:
#endif

void device_init(unsigned long pa, uint64 hartid) {
    8002265e:	1141                	addi	sp,sp,-16
    80022660:	e406                	sd	ra,8(sp)
    80022662:	e022                	sd	s0,0(sp)
    80022664:	0800                	addi	s0,sp,16
  #ifndef QEMU
  // after RustSBI, txen = rxen = 1, rxie = 1, rxcnt = 0
  // start UART interrupt configuration
  // disable external interrupt on hart1 by setting threshold
  uint32 *hart0_m_threshold = (uint32*)PLIC;
  uint32 *hart1_m_threshold = (uint32*)PLIC_MENABLE(hartid);
    80022666:	000c27b7          	lui	a5,0xc2
    8002266a:	02078793          	addi	a5,a5,32 # c2020 <BASE_ADDRESS-0x7ff5dfe0>
    8002266e:	95be                	add	a1,a1,a5
    80022670:	05a2                	slli	a1,a1,0x8
  *(hart0_m_threshold) = 0;
    80022672:	0c2007b7          	lui	a5,0xc200
    80022676:	0007a023          	sw	zero,0(a5) # c200000 <BASE_ADDRESS-0x73e20000>
  *(hart1_m_threshold) = 1;
    8002267a:	4785                	li	a5,1
    8002267c:	c19c                	sw	a5,0(a1)
  // assure that its priority equals 1
  // if(*(uint32*)(0x0c000000 + 33 * 4) != 1) panic("uarhs's priority is not 1\n");
  // printf("uart priority: %p\n", *(uint32*)(0x0c000000 + 33 * 4));
  // *(uint32*)(0x0c000000 + 33 * 4) = 0x1;
  uint32 *hart0_m_int_enable_hi = (uint32*)(PLIC_MENABLE(hartid) + 0x04);
  *(hart0_m_int_enable_hi) = (1 << 0x1);
    8002267e:	4789                	li	a5,2
    80022680:	c1dc                	sw	a5,4(a1)
  *((uint8*)0x10000004) = 0x0b;
  *((uint8*)0x10000001) = 0x01;
  *((uint32*)0x0c000028) = 0x7;
  *((uint32*)0x0c201000) = 0x0;
  #endif
  printf("device init\n");
    80022682:	00007517          	auipc	a0,0x7
    80022686:	ea650513          	addi	a0,a0,-346 # 80029528 <states.1805+0x338>
    8002268a:	ffffe097          	auipc	ra,0xffffe
    8002268e:	a8e080e7          	jalr	-1394(ra) # 80020118 <printf>
    80022692:	60a2                	ld	ra,8(sp)
    80022694:	6402                	ld	s0,0(sp)
    80022696:	0141                	addi	sp,sp,16
    80022698:	8082                	ret

000000008002269a <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    8002269a:	1101                	addi	sp,sp,-32
    8002269c:	ec06                	sd	ra,24(sp)
    8002269e:	e822                	sd	s0,16(sp)
    800226a0:	e426                	sd	s1,8(sp)
    800226a2:	1000                	addi	s0,sp,32
    800226a4:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800226a6:	fffff097          	auipc	ra,0xfffff
    800226aa:	f30080e7          	jalr	-208(ra) # 800215d6 <myproc>
  switch (n) {
    800226ae:	4795                	li	a5,5
    800226b0:	0497e163          	bltu	a5,s1,800226f2 <argraw+0x58>
    800226b4:	048a                	slli	s1,s1,0x2
    800226b6:	00007717          	auipc	a4,0x7
    800226ba:	e8270713          	addi	a4,a4,-382 # 80029538 <states.1805+0x348>
    800226be:	94ba                	add	s1,s1,a4
    800226c0:	409c                	lw	a5,0(s1)
    800226c2:	97ba                	add	a5,a5,a4
    800226c4:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    800226c6:	6d3c                	ld	a5,88(a0)
    800226c8:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    800226ca:	60e2                	ld	ra,24(sp)
    800226cc:	6442                	ld	s0,16(sp)
    800226ce:	64a2                	ld	s1,8(sp)
    800226d0:	6105                	addi	sp,sp,32
    800226d2:	8082                	ret
    return p->trapframe->a1;
    800226d4:	6d3c                	ld	a5,88(a0)
    800226d6:	7fa8                	ld	a0,120(a5)
    800226d8:	bfcd                	j	800226ca <argraw+0x30>
    return p->trapframe->a2;
    800226da:	6d3c                	ld	a5,88(a0)
    800226dc:	63c8                	ld	a0,128(a5)
    800226de:	b7f5                	j	800226ca <argraw+0x30>
    return p->trapframe->a3;
    800226e0:	6d3c                	ld	a5,88(a0)
    800226e2:	67c8                	ld	a0,136(a5)
    800226e4:	b7dd                	j	800226ca <argraw+0x30>
    return p->trapframe->a4;
    800226e6:	6d3c                	ld	a5,88(a0)
    800226e8:	6bc8                	ld	a0,144(a5)
    800226ea:	b7c5                	j	800226ca <argraw+0x30>
    return p->trapframe->a5;
    800226ec:	6d3c                	ld	a5,88(a0)
    800226ee:	6fc8                	ld	a0,152(a5)
    800226f0:	bfe9                	j	800226ca <argraw+0x30>
  panic("argraw");
    800226f2:	00007517          	auipc	a0,0x7
    800226f6:	f2e50513          	addi	a0,a0,-210 # 80029620 <syscalls+0xd0>
    800226fa:	ffffe097          	auipc	ra,0xffffe
    800226fe:	9dc080e7          	jalr	-1572(ra) # 800200d6 <panic>

0000000080022702 <sys_test_proc>:
}

static int count = 0;
uint64 
sys_test_proc(void) {
    count++;
    80022702:	00013717          	auipc	a4,0x13
    80022706:	11270713          	addi	a4,a4,274 # 80035814 <count>
    8002270a:	431c                	lw	a5,0(a4)
    8002270c:	2785                	addiw	a5,a5,1
    8002270e:	c31c                	sw	a5,0(a4)
    if(count % 10000 == 0)
    80022710:	6709                	lui	a4,0x2
    80022712:	7107071b          	addiw	a4,a4,1808
    80022716:	02e7e7bb          	remw	a5,a5,a4
    8002271a:	c399                	beqz	a5,80022720 <sys_test_proc+0x1e>
      printf("hello world from proc %d, hart %d\n", myproc()->pid, r_tp());
    return 0;
    8002271c:	4501                	li	a0,0
    8002271e:	8082                	ret
sys_test_proc(void) {
    80022720:	1141                	addi	sp,sp,-16
    80022722:	e406                	sd	ra,8(sp)
    80022724:	e022                	sd	s0,0(sp)
    80022726:	0800                	addi	s0,sp,16
      printf("hello world from proc %d, hart %d\n", myproc()->pid, r_tp());
    80022728:	fffff097          	auipc	ra,0xfffff
    8002272c:	eae080e7          	jalr	-338(ra) # 800215d6 <myproc>
  asm volatile("mv %0, tp" : "=r" (x) );
    80022730:	8612                	mv	a2,tp
    80022732:	5d0c                	lw	a1,56(a0)
    80022734:	00007517          	auipc	a0,0x7
    80022738:	ef450513          	addi	a0,a0,-268 # 80029628 <syscalls+0xd8>
    8002273c:	ffffe097          	auipc	ra,0xffffe
    80022740:	9dc080e7          	jalr	-1572(ra) # 80020118 <printf>
    80022744:	4501                	li	a0,0
    80022746:	60a2                	ld	ra,8(sp)
    80022748:	6402                	ld	s0,0(sp)
    8002274a:	0141                	addi	sp,sp,16
    8002274c:	8082                	ret

000000008002274e <fetchaddr>:
{
    8002274e:	1101                	addi	sp,sp,-32
    80022750:	ec06                	sd	ra,24(sp)
    80022752:	e822                	sd	s0,16(sp)
    80022754:	e426                	sd	s1,8(sp)
    80022756:	e04a                	sd	s2,0(sp)
    80022758:	1000                	addi	s0,sp,32
    8002275a:	84aa                	mv	s1,a0
    8002275c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8002275e:	fffff097          	auipc	ra,0xfffff
    80022762:	e78080e7          	jalr	-392(ra) # 800215d6 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80022766:	653c                	ld	a5,72(a0)
    80022768:	02f4f863          	bgeu	s1,a5,80022798 <fetchaddr+0x4a>
    8002276c:	00848713          	addi	a4,s1,8
    80022770:	02e7e663          	bltu	a5,a4,8002279c <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80022774:	46a1                	li	a3,8
    80022776:	8626                	mv	a2,s1
    80022778:	85ca                	mv	a1,s2
    8002277a:	6928                	ld	a0,80(a0)
    8002277c:	fffff097          	auipc	ra,0xfffff
    80022780:	ab0080e7          	jalr	-1360(ra) # 8002122c <copyin>
    80022784:	00a03533          	snez	a0,a0
    80022788:	40a00533          	neg	a0,a0
}
    8002278c:	60e2                	ld	ra,24(sp)
    8002278e:	6442                	ld	s0,16(sp)
    80022790:	64a2                	ld	s1,8(sp)
    80022792:	6902                	ld	s2,0(sp)
    80022794:	6105                	addi	sp,sp,32
    80022796:	8082                	ret
    return -1;
    80022798:	557d                	li	a0,-1
    8002279a:	bfcd                	j	8002278c <fetchaddr+0x3e>
    8002279c:	557d                	li	a0,-1
    8002279e:	b7fd                	j	8002278c <fetchaddr+0x3e>

00000000800227a0 <fetchstr>:
{
    800227a0:	7179                	addi	sp,sp,-48
    800227a2:	f406                	sd	ra,40(sp)
    800227a4:	f022                	sd	s0,32(sp)
    800227a6:	ec26                	sd	s1,24(sp)
    800227a8:	e84a                	sd	s2,16(sp)
    800227aa:	e44e                	sd	s3,8(sp)
    800227ac:	1800                	addi	s0,sp,48
    800227ae:	892a                	mv	s2,a0
    800227b0:	84ae                	mv	s1,a1
    800227b2:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    800227b4:	fffff097          	auipc	ra,0xfffff
    800227b8:	e22080e7          	jalr	-478(ra) # 800215d6 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    800227bc:	86ce                	mv	a3,s3
    800227be:	864a                	mv	a2,s2
    800227c0:	85a6                	mv	a1,s1
    800227c2:	6928                	ld	a0,80(a0)
    800227c4:	fffff097          	auipc	ra,0xfffff
    800227c8:	af6080e7          	jalr	-1290(ra) # 800212ba <copyinstr>
  if(err < 0)
    800227cc:	00054763          	bltz	a0,800227da <fetchstr+0x3a>
  return strlen(buf);
    800227d0:	8526                	mv	a0,s1
    800227d2:	ffffe097          	auipc	ra,0xffffe
    800227d6:	010080e7          	jalr	16(ra) # 800207e2 <strlen>
}
    800227da:	70a2                	ld	ra,40(sp)
    800227dc:	7402                	ld	s0,32(sp)
    800227de:	64e2                	ld	s1,24(sp)
    800227e0:	6942                	ld	s2,16(sp)
    800227e2:	69a2                	ld	s3,8(sp)
    800227e4:	6145                	addi	sp,sp,48
    800227e6:	8082                	ret

00000000800227e8 <argint>:
{
    800227e8:	1101                	addi	sp,sp,-32
    800227ea:	ec06                	sd	ra,24(sp)
    800227ec:	e822                	sd	s0,16(sp)
    800227ee:	e426                	sd	s1,8(sp)
    800227f0:	1000                	addi	s0,sp,32
    800227f2:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800227f4:	00000097          	auipc	ra,0x0
    800227f8:	ea6080e7          	jalr	-346(ra) # 8002269a <argraw>
    800227fc:	c088                	sw	a0,0(s1)
}
    800227fe:	4501                	li	a0,0
    80022800:	60e2                	ld	ra,24(sp)
    80022802:	6442                	ld	s0,16(sp)
    80022804:	64a2                	ld	s1,8(sp)
    80022806:	6105                	addi	sp,sp,32
    80022808:	8082                	ret

000000008002280a <argaddr>:
{
    8002280a:	1101                	addi	sp,sp,-32
    8002280c:	ec06                	sd	ra,24(sp)
    8002280e:	e822                	sd	s0,16(sp)
    80022810:	e426                	sd	s1,8(sp)
    80022812:	1000                	addi	s0,sp,32
    80022814:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80022816:	00000097          	auipc	ra,0x0
    8002281a:	e84080e7          	jalr	-380(ra) # 8002269a <argraw>
    8002281e:	e088                	sd	a0,0(s1)
}
    80022820:	4501                	li	a0,0
    80022822:	60e2                	ld	ra,24(sp)
    80022824:	6442                	ld	s0,16(sp)
    80022826:	64a2                	ld	s1,8(sp)
    80022828:	6105                	addi	sp,sp,32
    8002282a:	8082                	ret

000000008002282c <argstr>:
{
    8002282c:	1101                	addi	sp,sp,-32
    8002282e:	ec06                	sd	ra,24(sp)
    80022830:	e822                	sd	s0,16(sp)
    80022832:	e426                	sd	s1,8(sp)
    80022834:	e04a                	sd	s2,0(sp)
    80022836:	1000                	addi	s0,sp,32
    80022838:	84ae                	mv	s1,a1
    8002283a:	8932                	mv	s2,a2
  *ip = argraw(n);
    8002283c:	00000097          	auipc	ra,0x0
    80022840:	e5e080e7          	jalr	-418(ra) # 8002269a <argraw>
  return fetchstr(addr, buf, max);
    80022844:	864a                	mv	a2,s2
    80022846:	85a6                	mv	a1,s1
    80022848:	00000097          	auipc	ra,0x0
    8002284c:	f58080e7          	jalr	-168(ra) # 800227a0 <fetchstr>
}
    80022850:	60e2                	ld	ra,24(sp)
    80022852:	6442                	ld	s0,16(sp)
    80022854:	64a2                	ld	s1,8(sp)
    80022856:	6902                	ld	s2,0(sp)
    80022858:	6105                	addi	sp,sp,32
    8002285a:	8082                	ret

000000008002285c <syscall>:
{
    8002285c:	1101                	addi	sp,sp,-32
    8002285e:	ec06                	sd	ra,24(sp)
    80022860:	e822                	sd	s0,16(sp)
    80022862:	e426                	sd	s1,8(sp)
    80022864:	e04a                	sd	s2,0(sp)
    80022866:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80022868:	fffff097          	auipc	ra,0xfffff
    8002286c:	d6e080e7          	jalr	-658(ra) # 800215d6 <myproc>
    80022870:	84aa                	mv	s1,a0
  num = p->trapframe->a7;
    80022872:	05853903          	ld	s2,88(a0)
    80022876:	0a893783          	ld	a5,168(s2)
    8002287a:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    8002287e:	37fd                	addiw	a5,a5,-1
    80022880:	4761                	li	a4,24
    80022882:	00f76f63          	bltu	a4,a5,800228a0 <syscall+0x44>
    80022886:	00369713          	slli	a4,a3,0x3
    8002288a:	00007797          	auipc	a5,0x7
    8002288e:	cc678793          	addi	a5,a5,-826 # 80029550 <syscalls>
    80022892:	97ba                	add	a5,a5,a4
    80022894:	639c                	ld	a5,0(a5)
    80022896:	c789                	beqz	a5,800228a0 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80022898:	9782                	jalr	a5
    8002289a:	06a93823          	sd	a0,112(s2)
    8002289e:	a839                	j	800228bc <syscall+0x60>
    printf("%d %s: unknown sys call %d\n",
    800228a0:	15848613          	addi	a2,s1,344
    800228a4:	5c8c                	lw	a1,56(s1)
    800228a6:	00007517          	auipc	a0,0x7
    800228aa:	daa50513          	addi	a0,a0,-598 # 80029650 <syscalls+0x100>
    800228ae:	ffffe097          	auipc	ra,0xffffe
    800228b2:	86a080e7          	jalr	-1942(ra) # 80020118 <printf>
    p->trapframe->a0 = -1;
    800228b6:	6cbc                	ld	a5,88(s1)
    800228b8:	577d                	li	a4,-1
    800228ba:	fbb8                	sd	a4,112(a5)
}
    800228bc:	60e2                	ld	ra,24(sp)
    800228be:	6442                	ld	s0,16(sp)
    800228c0:	64a2                	ld	s1,8(sp)
    800228c2:	6902                	ld	s2,0(sp)
    800228c4:	6105                	addi	sp,sp,32
    800228c6:	8082                	ret

00000000800228c8 <sys_exit>:
#include "include/spinlock.h"
#include "include/proc.h"

uint64
sys_exit(void)
{
    800228c8:	1101                	addi	sp,sp,-32
    800228ca:	ec06                	sd	ra,24(sp)
    800228cc:	e822                	sd	s0,16(sp)
    800228ce:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    800228d0:	fec40593          	addi	a1,s0,-20
    800228d4:	4501                	li	a0,0
    800228d6:	00000097          	auipc	ra,0x0
    800228da:	f12080e7          	jalr	-238(ra) # 800227e8 <argint>
    return -1;
    800228de:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800228e0:	00054963          	bltz	a0,800228f2 <sys_exit+0x2a>
  exit(n);
    800228e4:	fec42503          	lw	a0,-20(s0)
    800228e8:	fffff097          	auipc	ra,0xfffff
    800228ec:	48c080e7          	jalr	1164(ra) # 80021d74 <exit>
  return 0;  // not reached
    800228f0:	4781                	li	a5,0
}
    800228f2:	853e                	mv	a0,a5
    800228f4:	60e2                	ld	ra,24(sp)
    800228f6:	6442                	ld	s0,16(sp)
    800228f8:	6105                	addi	sp,sp,32
    800228fa:	8082                	ret

00000000800228fc <sys_getpid>:

uint64
sys_getpid(void)
{
    800228fc:	1141                	addi	sp,sp,-16
    800228fe:	e406                	sd	ra,8(sp)
    80022900:	e022                	sd	s0,0(sp)
    80022902:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80022904:	fffff097          	auipc	ra,0xfffff
    80022908:	cd2080e7          	jalr	-814(ra) # 800215d6 <myproc>
}
    8002290c:	5d08                	lw	a0,56(a0)
    8002290e:	60a2                	ld	ra,8(sp)
    80022910:	6402                	ld	s0,0(sp)
    80022912:	0141                	addi	sp,sp,16
    80022914:	8082                	ret

0000000080022916 <sys_fork>:

uint64
sys_fork(void)
{
    80022916:	1141                	addi	sp,sp,-16
    80022918:	e406                	sd	ra,8(sp)
    8002291a:	e022                	sd	s0,0(sp)
    8002291c:	0800                	addi	s0,sp,16
  return fork();
    8002291e:	fffff097          	auipc	ra,0xfffff
    80022922:	14e080e7          	jalr	334(ra) # 80021a6c <fork>
}
    80022926:	60a2                	ld	ra,8(sp)
    80022928:	6402                	ld	s0,0(sp)
    8002292a:	0141                	addi	sp,sp,16
    8002292c:	8082                	ret

000000008002292e <sys_wait>:

uint64
sys_wait(void)
{
    8002292e:	1101                	addi	sp,sp,-32
    80022930:	ec06                	sd	ra,24(sp)
    80022932:	e822                	sd	s0,16(sp)
    80022934:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80022936:	fe840593          	addi	a1,s0,-24
    8002293a:	4501                	li	a0,0
    8002293c:	00000097          	auipc	ra,0x0
    80022940:	ece080e7          	jalr	-306(ra) # 8002280a <argaddr>
    return -1;
    80022944:	57fd                	li	a5,-1
  if(argaddr(0, &p) < 0)
    80022946:	00054963          	bltz	a0,80022958 <sys_wait+0x2a>
  return wait(p);
    8002294a:	fe843503          	ld	a0,-24(s0)
    8002294e:	fffff097          	auipc	ra,0xfffff
    80022952:	5dc080e7          	jalr	1500(ra) # 80021f2a <wait>
    80022956:	87aa                	mv	a5,a0
}
    80022958:	853e                	mv	a0,a5
    8002295a:	60e2                	ld	ra,24(sp)
    8002295c:	6442                	ld	s0,16(sp)
    8002295e:	6105                	addi	sp,sp,32
    80022960:	8082                	ret

0000000080022962 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80022962:	7179                	addi	sp,sp,-48
    80022964:	f406                	sd	ra,40(sp)
    80022966:	f022                	sd	s0,32(sp)
    80022968:	ec26                	sd	s1,24(sp)
    8002296a:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    8002296c:	fdc40593          	addi	a1,s0,-36
    80022970:	4501                	li	a0,0
    80022972:	00000097          	auipc	ra,0x0
    80022976:	e76080e7          	jalr	-394(ra) # 800227e8 <argint>
    return -1;
    8002297a:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    8002297c:	00054f63          	bltz	a0,8002299a <sys_sbrk+0x38>
  addr = myproc()->sz;
    80022980:	fffff097          	auipc	ra,0xfffff
    80022984:	c56080e7          	jalr	-938(ra) # 800215d6 <myproc>
    80022988:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    8002298a:	fdc42503          	lw	a0,-36(s0)
    8002298e:	fffff097          	auipc	ra,0xfffff
    80022992:	066080e7          	jalr	102(ra) # 800219f4 <growproc>
    80022996:	00054863          	bltz	a0,800229a6 <sys_sbrk+0x44>
    return -1;
  return addr;
}
    8002299a:	8526                	mv	a0,s1
    8002299c:	70a2                	ld	ra,40(sp)
    8002299e:	7402                	ld	s0,32(sp)
    800229a0:	64e2                	ld	s1,24(sp)
    800229a2:	6145                	addi	sp,sp,48
    800229a4:	8082                	ret
    return -1;
    800229a6:	54fd                	li	s1,-1
    800229a8:	bfcd                	j	8002299a <sys_sbrk+0x38>

00000000800229aa <sys_sleep>:

uint64
sys_sleep(void)
{
    800229aa:	7139                	addi	sp,sp,-64
    800229ac:	fc06                	sd	ra,56(sp)
    800229ae:	f822                	sd	s0,48(sp)
    800229b0:	f426                	sd	s1,40(sp)
    800229b2:	f04a                	sd	s2,32(sp)
    800229b4:	ec4e                	sd	s3,24(sp)
    800229b6:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800229b8:	fcc40593          	addi	a1,s0,-52
    800229bc:	4501                	li	a0,0
    800229be:	00000097          	auipc	ra,0x0
    800229c2:	e2a080e7          	jalr	-470(ra) # 800227e8 <argint>
    return -1;
    800229c6:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800229c8:	06054763          	bltz	a0,80022a36 <sys_sleep+0x8c>
  acquire(&tickslock);
    800229cc:	00013517          	auipc	a0,0x13
    800229d0:	e2c50513          	addi	a0,a0,-468 # 800357f8 <tickslock>
    800229d4:	ffffe097          	auipc	ra,0xffffe
    800229d8:	b68080e7          	jalr	-1176(ra) # 8002053c <acquire>
  ticks0 = ticks;
    800229dc:	00013797          	auipc	a5,0x13
    800229e0:	e3478793          	addi	a5,a5,-460 # 80035810 <ticks>
    800229e4:	0007a903          	lw	s2,0(a5)
  while(ticks - ticks0 < n){
    800229e8:	fcc42783          	lw	a5,-52(s0)
    800229ec:	cf85                	beqz	a5,80022a24 <sys_sleep+0x7a>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800229ee:	00013997          	auipc	s3,0x13
    800229f2:	e0a98993          	addi	s3,s3,-502 # 800357f8 <tickslock>
    800229f6:	00013497          	auipc	s1,0x13
    800229fa:	e1a48493          	addi	s1,s1,-486 # 80035810 <ticks>
    if(myproc()->killed){
    800229fe:	fffff097          	auipc	ra,0xfffff
    80022a02:	bd8080e7          	jalr	-1064(ra) # 800215d6 <myproc>
    80022a06:	591c                	lw	a5,48(a0)
    80022a08:	ef9d                	bnez	a5,80022a46 <sys_sleep+0x9c>
    sleep(&ticks, &tickslock);
    80022a0a:	85ce                	mv	a1,s3
    80022a0c:	8526                	mv	a0,s1
    80022a0e:	fffff097          	auipc	ra,0xfffff
    80022a12:	49e080e7          	jalr	1182(ra) # 80021eac <sleep>
  while(ticks - ticks0 < n){
    80022a16:	409c                	lw	a5,0(s1)
    80022a18:	412787bb          	subw	a5,a5,s2
    80022a1c:	fcc42703          	lw	a4,-52(s0)
    80022a20:	fce7efe3          	bltu	a5,a4,800229fe <sys_sleep+0x54>
  }
  release(&tickslock);
    80022a24:	00013517          	auipc	a0,0x13
    80022a28:	dd450513          	addi	a0,a0,-556 # 800357f8 <tickslock>
    80022a2c:	ffffe097          	auipc	ra,0xffffe
    80022a30:	bc4080e7          	jalr	-1084(ra) # 800205f0 <release>
  return 0;
    80022a34:	4781                	li	a5,0
}
    80022a36:	853e                	mv	a0,a5
    80022a38:	70e2                	ld	ra,56(sp)
    80022a3a:	7442                	ld	s0,48(sp)
    80022a3c:	74a2                	ld	s1,40(sp)
    80022a3e:	7902                	ld	s2,32(sp)
    80022a40:	69e2                	ld	s3,24(sp)
    80022a42:	6121                	addi	sp,sp,64
    80022a44:	8082                	ret
      release(&tickslock);
    80022a46:	00013517          	auipc	a0,0x13
    80022a4a:	db250513          	addi	a0,a0,-590 # 800357f8 <tickslock>
    80022a4e:	ffffe097          	auipc	ra,0xffffe
    80022a52:	ba2080e7          	jalr	-1118(ra) # 800205f0 <release>
      return -1;
    80022a56:	57fd                	li	a5,-1
    80022a58:	bff9                	j	80022a36 <sys_sleep+0x8c>

0000000080022a5a <sys_kill>:

uint64
sys_kill(void)
{
    80022a5a:	1101                	addi	sp,sp,-32
    80022a5c:	ec06                	sd	ra,24(sp)
    80022a5e:	e822                	sd	s0,16(sp)
    80022a60:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80022a62:	fec40593          	addi	a1,s0,-20
    80022a66:	4501                	li	a0,0
    80022a68:	00000097          	auipc	ra,0x0
    80022a6c:	d80080e7          	jalr	-640(ra) # 800227e8 <argint>
    return -1;
    80022a70:	57fd                	li	a5,-1
  if(argint(0, &pid) < 0)
    80022a72:	00054963          	bltz	a0,80022a84 <sys_kill+0x2a>
  return kill(pid);
    80022a76:	fec42503          	lw	a0,-20(s0)
    80022a7a:	fffff097          	auipc	ra,0xfffff
    80022a7e:	622080e7          	jalr	1570(ra) # 8002209c <kill>
    80022a82:	87aa                	mv	a5,a0
}
    80022a84:	853e                	mv	a0,a5
    80022a86:	60e2                	ld	ra,24(sp)
    80022a88:	6442                	ld	s0,16(sp)
    80022a8a:	6105                	addi	sp,sp,32
    80022a8c:	8082                	ret

0000000080022a8e <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80022a8e:	1101                	addi	sp,sp,-32
    80022a90:	ec06                	sd	ra,24(sp)
    80022a92:	e822                	sd	s0,16(sp)
    80022a94:	e426                	sd	s1,8(sp)
    80022a96:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80022a98:	00013517          	auipc	a0,0x13
    80022a9c:	d6050513          	addi	a0,a0,-672 # 800357f8 <tickslock>
    80022aa0:	ffffe097          	auipc	ra,0xffffe
    80022aa4:	a9c080e7          	jalr	-1380(ra) # 8002053c <acquire>
  xticks = ticks;
    80022aa8:	00013797          	auipc	a5,0x13
    80022aac:	d6878793          	addi	a5,a5,-664 # 80035810 <ticks>
    80022ab0:	4384                	lw	s1,0(a5)
  release(&tickslock);
    80022ab2:	00013517          	auipc	a0,0x13
    80022ab6:	d4650513          	addi	a0,a0,-698 # 800357f8 <tickslock>
    80022aba:	ffffe097          	auipc	ra,0xffffe
    80022abe:	b36080e7          	jalr	-1226(ra) # 800205f0 <release>
  return xticks;
}
    80022ac2:	02049513          	slli	a0,s1,0x20
    80022ac6:	9101                	srli	a0,a0,0x20
    80022ac8:	60e2                	ld	ra,24(sp)
    80022aca:	6442                	ld	s0,16(sp)
    80022acc:	64a2                	ld	s1,8(sp)
    80022ace:	6105                	addi	sp,sp,32
    80022ad0:	8082                	ret

0000000080022ad2 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80022ad2:	7139                	addi	sp,sp,-64
    80022ad4:	fc06                	sd	ra,56(sp)
    80022ad6:	f822                	sd	s0,48(sp)
    80022ad8:	f426                	sd	s1,40(sp)
    80022ada:	f04a                	sd	s2,32(sp)
    80022adc:	ec4e                	sd	s3,24(sp)
    80022ade:	e852                	sd	s4,16(sp)
    80022ae0:	e456                	sd	s5,8(sp)
    80022ae2:	0080                	addi	s0,sp,64
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80022ae4:	00007597          	auipc	a1,0x7
    80022ae8:	b8c58593          	addi	a1,a1,-1140 # 80029670 <syscalls+0x120>
    80022aec:	00013517          	auipc	a0,0x13
    80022af0:	d2c50513          	addi	a0,a0,-724 # 80035818 <bcache>
    80022af4:	ffffe097          	auipc	ra,0xffffe
    80022af8:	9b8080e7          	jalr	-1608(ra) # 800204ac <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80022afc:	00017797          	auipc	a5,0x17
    80022b00:	d1c78793          	addi	a5,a5,-740 # 80039818 <bcache+0x4000>
    80022b04:	00017717          	auipc	a4,0x17
    80022b08:	37c70713          	addi	a4,a4,892 # 80039e80 <bcache+0x4668>
    80022b0c:	6ae7b823          	sd	a4,1712(a5)
  bcache.head.next = &bcache.head;
    80022b10:	6ae7bc23          	sd	a4,1720(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80022b14:	00013497          	auipc	s1,0x13
    80022b18:	d1c48493          	addi	s1,s1,-740 # 80035830 <bcache+0x18>
    b->refcnt = 0;
    b->sectorno = ~0;
    80022b1c:	5a7d                	li	s4,-1
    b->dev = ~0;
    b->next = bcache.head.next;
    80022b1e:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80022b20:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80022b22:	00007a97          	auipc	s5,0x7
    80022b26:	b56a8a93          	addi	s5,s5,-1194 # 80029678 <syscalls+0x128>
    b->refcnt = 0;
    80022b2a:	0404a023          	sw	zero,64(s1)
    b->sectorno = ~0;
    80022b2e:	0144a623          	sw	s4,12(s1)
    b->dev = ~0;
    80022b32:	0144a423          	sw	s4,8(s1)
    b->next = bcache.head.next;
    80022b36:	6b893783          	ld	a5,1720(s2)
    80022b3a:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80022b3c:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80022b40:	85d6                	mv	a1,s5
    80022b42:	01048513          	addi	a0,s1,16
    80022b46:	00000097          	auipc	ra,0x0
    80022b4a:	290080e7          	jalr	656(ra) # 80022dd6 <initsleeplock>
    bcache.head.next->prev = b;
    80022b4e:	6b893783          	ld	a5,1720(s2)
    80022b52:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80022b54:	6a993c23          	sd	s1,1720(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80022b58:	25848493          	addi	s1,s1,600
    80022b5c:	fd3497e3          	bne	s1,s3,80022b2a <binit+0x58>
  }
  printf("binit\n");
    80022b60:	00007517          	auipc	a0,0x7
    80022b64:	b2050513          	addi	a0,a0,-1248 # 80029680 <syscalls+0x130>
    80022b68:	ffffd097          	auipc	ra,0xffffd
    80022b6c:	5b0080e7          	jalr	1456(ra) # 80020118 <printf>
}
    80022b70:	70e2                	ld	ra,56(sp)
    80022b72:	7442                	ld	s0,48(sp)
    80022b74:	74a2                	ld	s1,40(sp)
    80022b76:	7902                	ld	s2,32(sp)
    80022b78:	69e2                	ld	s3,24(sp)
    80022b7a:	6a42                	ld	s4,16(sp)
    80022b7c:	6aa2                	ld	s5,8(sp)
    80022b7e:	6121                	addi	sp,sp,64
    80022b80:	8082                	ret

0000000080022b82 <bread>:
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf* 
bread(uint dev, uint sectorno) {
    80022b82:	7179                	addi	sp,sp,-48
    80022b84:	f406                	sd	ra,40(sp)
    80022b86:	f022                	sd	s0,32(sp)
    80022b88:	ec26                	sd	s1,24(sp)
    80022b8a:	e84a                	sd	s2,16(sp)
    80022b8c:	e44e                	sd	s3,8(sp)
    80022b8e:	1800                	addi	s0,sp,48
    80022b90:	89aa                	mv	s3,a0
    80022b92:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    80022b94:	00013517          	auipc	a0,0x13
    80022b98:	c8450513          	addi	a0,a0,-892 # 80035818 <bcache>
    80022b9c:	ffffe097          	auipc	ra,0xffffe
    80022ba0:	9a0080e7          	jalr	-1632(ra) # 8002053c <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80022ba4:	00017797          	auipc	a5,0x17
    80022ba8:	c7478793          	addi	a5,a5,-908 # 80039818 <bcache+0x4000>
    80022bac:	6b87b483          	ld	s1,1720(a5)
    80022bb0:	00017797          	auipc	a5,0x17
    80022bb4:	2d078793          	addi	a5,a5,720 # 80039e80 <bcache+0x4668>
    80022bb8:	02f48f63          	beq	s1,a5,80022bf6 <bread+0x74>
    80022bbc:	873e                	mv	a4,a5
    80022bbe:	a021                	j	80022bc6 <bread+0x44>
    80022bc0:	68a4                	ld	s1,80(s1)
    80022bc2:	02e48a63          	beq	s1,a4,80022bf6 <bread+0x74>
    if(b->dev == dev && b->sectorno == sectorno){
    80022bc6:	449c                	lw	a5,8(s1)
    80022bc8:	ff379ce3          	bne	a5,s3,80022bc0 <bread+0x3e>
    80022bcc:	44dc                	lw	a5,12(s1)
    80022bce:	ff2799e3          	bne	a5,s2,80022bc0 <bread+0x3e>
      b->refcnt++;
    80022bd2:	40bc                	lw	a5,64(s1)
    80022bd4:	2785                	addiw	a5,a5,1
    80022bd6:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80022bd8:	00013517          	auipc	a0,0x13
    80022bdc:	c4050513          	addi	a0,a0,-960 # 80035818 <bcache>
    80022be0:	ffffe097          	auipc	ra,0xffffe
    80022be4:	a10080e7          	jalr	-1520(ra) # 800205f0 <release>
      acquiresleep(&b->lock);
    80022be8:	01048513          	addi	a0,s1,16
    80022bec:	00000097          	auipc	ra,0x0
    80022bf0:	224080e7          	jalr	548(ra) # 80022e10 <acquiresleep>
      return b;
    80022bf4:	a8b1                	j	80022c50 <bread+0xce>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80022bf6:	00017797          	auipc	a5,0x17
    80022bfa:	c2278793          	addi	a5,a5,-990 # 80039818 <bcache+0x4000>
    80022bfe:	6b07b483          	ld	s1,1712(a5)
    80022c02:	00017797          	auipc	a5,0x17
    80022c06:	27e78793          	addi	a5,a5,638 # 80039e80 <bcache+0x4668>
    80022c0a:	04f48d63          	beq	s1,a5,80022c64 <bread+0xe2>
    if(b->refcnt == 0) {
    80022c0e:	40bc                	lw	a5,64(s1)
    80022c10:	cb91                	beqz	a5,80022c24 <bread+0xa2>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80022c12:	00017717          	auipc	a4,0x17
    80022c16:	26e70713          	addi	a4,a4,622 # 80039e80 <bcache+0x4668>
    80022c1a:	64a4                	ld	s1,72(s1)
    80022c1c:	04e48463          	beq	s1,a4,80022c64 <bread+0xe2>
    if(b->refcnt == 0) {
    80022c20:	40bc                	lw	a5,64(s1)
    80022c22:	ffe5                	bnez	a5,80022c1a <bread+0x98>
      b->dev = dev;
    80022c24:	0134a423          	sw	s3,8(s1)
      b->sectorno = sectorno;
    80022c28:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    80022c2c:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80022c30:	4785                	li	a5,1
    80022c32:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80022c34:	00013517          	auipc	a0,0x13
    80022c38:	be450513          	addi	a0,a0,-1052 # 80035818 <bcache>
    80022c3c:	ffffe097          	auipc	ra,0xffffe
    80022c40:	9b4080e7          	jalr	-1612(ra) # 800205f0 <release>
      acquiresleep(&b->lock);
    80022c44:	01048513          	addi	a0,s1,16
    80022c48:	00000097          	auipc	ra,0x0
    80022c4c:	1c8080e7          	jalr	456(ra) # 80022e10 <acquiresleep>
  struct buf *b;

  b = bget(dev, sectorno);
  if (!b->valid) {
    80022c50:	409c                	lw	a5,0(s1)
    80022c52:	c38d                	beqz	a5,80022c74 <bread+0xf2>
    disk_read(b);
    b->valid = 1;
  }

  return b;
}
    80022c54:	8526                	mv	a0,s1
    80022c56:	70a2                	ld	ra,40(sp)
    80022c58:	7402                	ld	s0,32(sp)
    80022c5a:	64e2                	ld	s1,24(sp)
    80022c5c:	6942                	ld	s2,16(sp)
    80022c5e:	69a2                	ld	s3,8(sp)
    80022c60:	6145                	addi	sp,sp,48
    80022c62:	8082                	ret
  panic("bget: no buffers");
    80022c64:	00007517          	auipc	a0,0x7
    80022c68:	a2450513          	addi	a0,a0,-1500 # 80029688 <syscalls+0x138>
    80022c6c:	ffffd097          	auipc	ra,0xffffd
    80022c70:	46a080e7          	jalr	1130(ra) # 800200d6 <panic>
    disk_read(b);
    80022c74:	8526                	mv	a0,s1
    80022c76:	00002097          	auipc	ra,0x2
    80022c7a:	eec080e7          	jalr	-276(ra) # 80024b62 <disk_read>
    b->valid = 1;
    80022c7e:	4785                	li	a5,1
    80022c80:	c09c                	sw	a5,0(s1)
  return b;
    80022c82:	bfc9                	j	80022c54 <bread+0xd2>

0000000080022c84 <bwrite>:

// Write b's contents to disk.  Must be locked.
void 
bwrite(struct buf *b) {
    80022c84:	1101                	addi	sp,sp,-32
    80022c86:	ec06                	sd	ra,24(sp)
    80022c88:	e822                	sd	s0,16(sp)
    80022c8a:	e426                	sd	s1,8(sp)
    80022c8c:	1000                	addi	s0,sp,32
    80022c8e:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80022c90:	0541                	addi	a0,a0,16
    80022c92:	00000097          	auipc	ra,0x0
    80022c96:	218080e7          	jalr	536(ra) # 80022eaa <holdingsleep>
    80022c9a:	c919                	beqz	a0,80022cb0 <bwrite+0x2c>
    panic("bwrite");
  disk_write(b);
    80022c9c:	8526                	mv	a0,s1
    80022c9e:	00002097          	auipc	ra,0x2
    80022ca2:	ed0080e7          	jalr	-304(ra) # 80024b6e <disk_write>
}
    80022ca6:	60e2                	ld	ra,24(sp)
    80022ca8:	6442                	ld	s0,16(sp)
    80022caa:	64a2                	ld	s1,8(sp)
    80022cac:	6105                	addi	sp,sp,32
    80022cae:	8082                	ret
    panic("bwrite");
    80022cb0:	00007517          	auipc	a0,0x7
    80022cb4:	9f050513          	addi	a0,a0,-1552 # 800296a0 <syscalls+0x150>
    80022cb8:	ffffd097          	auipc	ra,0xffffd
    80022cbc:	41e080e7          	jalr	1054(ra) # 800200d6 <panic>

0000000080022cc0 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80022cc0:	1101                	addi	sp,sp,-32
    80022cc2:	ec06                	sd	ra,24(sp)
    80022cc4:	e822                	sd	s0,16(sp)
    80022cc6:	e426                	sd	s1,8(sp)
    80022cc8:	e04a                	sd	s2,0(sp)
    80022cca:	1000                	addi	s0,sp,32
    80022ccc:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80022cce:	01050913          	addi	s2,a0,16
    80022cd2:	854a                	mv	a0,s2
    80022cd4:	00000097          	auipc	ra,0x0
    80022cd8:	1d6080e7          	jalr	470(ra) # 80022eaa <holdingsleep>
    80022cdc:	c92d                	beqz	a0,80022d4e <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80022cde:	854a                	mv	a0,s2
    80022ce0:	00000097          	auipc	ra,0x0
    80022ce4:	186080e7          	jalr	390(ra) # 80022e66 <releasesleep>

  acquire(&bcache.lock);
    80022ce8:	00013517          	auipc	a0,0x13
    80022cec:	b3050513          	addi	a0,a0,-1232 # 80035818 <bcache>
    80022cf0:	ffffe097          	auipc	ra,0xffffe
    80022cf4:	84c080e7          	jalr	-1972(ra) # 8002053c <acquire>
  b->refcnt--;
    80022cf8:	40bc                	lw	a5,64(s1)
    80022cfa:	37fd                	addiw	a5,a5,-1
    80022cfc:	0007871b          	sext.w	a4,a5
    80022d00:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80022d02:	eb05                	bnez	a4,80022d32 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80022d04:	68bc                	ld	a5,80(s1)
    80022d06:	64b8                	ld	a4,72(s1)
    80022d08:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80022d0a:	64bc                	ld	a5,72(s1)
    80022d0c:	68b8                	ld	a4,80(s1)
    80022d0e:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80022d10:	00017797          	auipc	a5,0x17
    80022d14:	b0878793          	addi	a5,a5,-1272 # 80039818 <bcache+0x4000>
    80022d18:	6b87b703          	ld	a4,1720(a5)
    80022d1c:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80022d1e:	00017717          	auipc	a4,0x17
    80022d22:	16270713          	addi	a4,a4,354 # 80039e80 <bcache+0x4668>
    80022d26:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80022d28:	6b87b703          	ld	a4,1720(a5)
    80022d2c:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80022d2e:	6a97bc23          	sd	s1,1720(a5)
  }
  
  release(&bcache.lock);
    80022d32:	00013517          	auipc	a0,0x13
    80022d36:	ae650513          	addi	a0,a0,-1306 # 80035818 <bcache>
    80022d3a:	ffffe097          	auipc	ra,0xffffe
    80022d3e:	8b6080e7          	jalr	-1866(ra) # 800205f0 <release>
}
    80022d42:	60e2                	ld	ra,24(sp)
    80022d44:	6442                	ld	s0,16(sp)
    80022d46:	64a2                	ld	s1,8(sp)
    80022d48:	6902                	ld	s2,0(sp)
    80022d4a:	6105                	addi	sp,sp,32
    80022d4c:	8082                	ret
    panic("brelse");
    80022d4e:	00007517          	auipc	a0,0x7
    80022d52:	95a50513          	addi	a0,a0,-1702 # 800296a8 <syscalls+0x158>
    80022d56:	ffffd097          	auipc	ra,0xffffd
    80022d5a:	380080e7          	jalr	896(ra) # 800200d6 <panic>

0000000080022d5e <bpin>:

void
bpin(struct buf *b) {
    80022d5e:	1101                	addi	sp,sp,-32
    80022d60:	ec06                	sd	ra,24(sp)
    80022d62:	e822                	sd	s0,16(sp)
    80022d64:	e426                	sd	s1,8(sp)
    80022d66:	1000                	addi	s0,sp,32
    80022d68:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80022d6a:	00013517          	auipc	a0,0x13
    80022d6e:	aae50513          	addi	a0,a0,-1362 # 80035818 <bcache>
    80022d72:	ffffd097          	auipc	ra,0xffffd
    80022d76:	7ca080e7          	jalr	1994(ra) # 8002053c <acquire>
  b->refcnt++;
    80022d7a:	40bc                	lw	a5,64(s1)
    80022d7c:	2785                	addiw	a5,a5,1
    80022d7e:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80022d80:	00013517          	auipc	a0,0x13
    80022d84:	a9850513          	addi	a0,a0,-1384 # 80035818 <bcache>
    80022d88:	ffffe097          	auipc	ra,0xffffe
    80022d8c:	868080e7          	jalr	-1944(ra) # 800205f0 <release>
}
    80022d90:	60e2                	ld	ra,24(sp)
    80022d92:	6442                	ld	s0,16(sp)
    80022d94:	64a2                	ld	s1,8(sp)
    80022d96:	6105                	addi	sp,sp,32
    80022d98:	8082                	ret

0000000080022d9a <bunpin>:

void
bunpin(struct buf *b) {
    80022d9a:	1101                	addi	sp,sp,-32
    80022d9c:	ec06                	sd	ra,24(sp)
    80022d9e:	e822                	sd	s0,16(sp)
    80022da0:	e426                	sd	s1,8(sp)
    80022da2:	1000                	addi	s0,sp,32
    80022da4:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80022da6:	00013517          	auipc	a0,0x13
    80022daa:	a7250513          	addi	a0,a0,-1422 # 80035818 <bcache>
    80022dae:	ffffd097          	auipc	ra,0xffffd
    80022db2:	78e080e7          	jalr	1934(ra) # 8002053c <acquire>
  b->refcnt--;
    80022db6:	40bc                	lw	a5,64(s1)
    80022db8:	37fd                	addiw	a5,a5,-1
    80022dba:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80022dbc:	00013517          	auipc	a0,0x13
    80022dc0:	a5c50513          	addi	a0,a0,-1444 # 80035818 <bcache>
    80022dc4:	ffffe097          	auipc	ra,0xffffe
    80022dc8:	82c080e7          	jalr	-2004(ra) # 800205f0 <release>
}
    80022dcc:	60e2                	ld	ra,24(sp)
    80022dce:	6442                	ld	s0,16(sp)
    80022dd0:	64a2                	ld	s1,8(sp)
    80022dd2:	6105                	addi	sp,sp,32
    80022dd4:	8082                	ret

0000000080022dd6 <initsleeplock>:
#include "include/proc.h"
#include "include/sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80022dd6:	1101                	addi	sp,sp,-32
    80022dd8:	ec06                	sd	ra,24(sp)
    80022dda:	e822                	sd	s0,16(sp)
    80022ddc:	e426                	sd	s1,8(sp)
    80022dde:	e04a                	sd	s2,0(sp)
    80022de0:	1000                	addi	s0,sp,32
    80022de2:	84aa                	mv	s1,a0
    80022de4:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80022de6:	00007597          	auipc	a1,0x7
    80022dea:	8ca58593          	addi	a1,a1,-1846 # 800296b0 <syscalls+0x160>
    80022dee:	0521                	addi	a0,a0,8
    80022df0:	ffffd097          	auipc	ra,0xffffd
    80022df4:	6bc080e7          	jalr	1724(ra) # 800204ac <initlock>
  lk->name = name;
    80022df8:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80022dfc:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80022e00:	0204a423          	sw	zero,40(s1)
}
    80022e04:	60e2                	ld	ra,24(sp)
    80022e06:	6442                	ld	s0,16(sp)
    80022e08:	64a2                	ld	s1,8(sp)
    80022e0a:	6902                	ld	s2,0(sp)
    80022e0c:	6105                	addi	sp,sp,32
    80022e0e:	8082                	ret

0000000080022e10 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80022e10:	1101                	addi	sp,sp,-32
    80022e12:	ec06                	sd	ra,24(sp)
    80022e14:	e822                	sd	s0,16(sp)
    80022e16:	e426                	sd	s1,8(sp)
    80022e18:	e04a                	sd	s2,0(sp)
    80022e1a:	1000                	addi	s0,sp,32
    80022e1c:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80022e1e:	00850913          	addi	s2,a0,8
    80022e22:	854a                	mv	a0,s2
    80022e24:	ffffd097          	auipc	ra,0xffffd
    80022e28:	718080e7          	jalr	1816(ra) # 8002053c <acquire>
  while (lk->locked) {
    80022e2c:	409c                	lw	a5,0(s1)
    80022e2e:	cb89                	beqz	a5,80022e40 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80022e30:	85ca                	mv	a1,s2
    80022e32:	8526                	mv	a0,s1
    80022e34:	fffff097          	auipc	ra,0xfffff
    80022e38:	078080e7          	jalr	120(ra) # 80021eac <sleep>
  while (lk->locked) {
    80022e3c:	409c                	lw	a5,0(s1)
    80022e3e:	fbed                	bnez	a5,80022e30 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80022e40:	4785                	li	a5,1
    80022e42:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80022e44:	ffffe097          	auipc	ra,0xffffe
    80022e48:	792080e7          	jalr	1938(ra) # 800215d6 <myproc>
    80022e4c:	5d1c                	lw	a5,56(a0)
    80022e4e:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80022e50:	854a                	mv	a0,s2
    80022e52:	ffffd097          	auipc	ra,0xffffd
    80022e56:	79e080e7          	jalr	1950(ra) # 800205f0 <release>
}
    80022e5a:	60e2                	ld	ra,24(sp)
    80022e5c:	6442                	ld	s0,16(sp)
    80022e5e:	64a2                	ld	s1,8(sp)
    80022e60:	6902                	ld	s2,0(sp)
    80022e62:	6105                	addi	sp,sp,32
    80022e64:	8082                	ret

0000000080022e66 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80022e66:	1101                	addi	sp,sp,-32
    80022e68:	ec06                	sd	ra,24(sp)
    80022e6a:	e822                	sd	s0,16(sp)
    80022e6c:	e426                	sd	s1,8(sp)
    80022e6e:	e04a                	sd	s2,0(sp)
    80022e70:	1000                	addi	s0,sp,32
    80022e72:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80022e74:	00850913          	addi	s2,a0,8
    80022e78:	854a                	mv	a0,s2
    80022e7a:	ffffd097          	auipc	ra,0xffffd
    80022e7e:	6c2080e7          	jalr	1730(ra) # 8002053c <acquire>
  lk->locked = 0;
    80022e82:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80022e86:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80022e8a:	8526                	mv	a0,s1
    80022e8c:	fffff097          	auipc	ra,0xfffff
    80022e90:	1a6080e7          	jalr	422(ra) # 80022032 <wakeup>
  release(&lk->lk);
    80022e94:	854a                	mv	a0,s2
    80022e96:	ffffd097          	auipc	ra,0xffffd
    80022e9a:	75a080e7          	jalr	1882(ra) # 800205f0 <release>
}
    80022e9e:	60e2                	ld	ra,24(sp)
    80022ea0:	6442                	ld	s0,16(sp)
    80022ea2:	64a2                	ld	s1,8(sp)
    80022ea4:	6902                	ld	s2,0(sp)
    80022ea6:	6105                	addi	sp,sp,32
    80022ea8:	8082                	ret

0000000080022eaa <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80022eaa:	7179                	addi	sp,sp,-48
    80022eac:	f406                	sd	ra,40(sp)
    80022eae:	f022                	sd	s0,32(sp)
    80022eb0:	ec26                	sd	s1,24(sp)
    80022eb2:	e84a                	sd	s2,16(sp)
    80022eb4:	e44e                	sd	s3,8(sp)
    80022eb6:	1800                	addi	s0,sp,48
    80022eb8:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80022eba:	00850913          	addi	s2,a0,8
    80022ebe:	854a                	mv	a0,s2
    80022ec0:	ffffd097          	auipc	ra,0xffffd
    80022ec4:	67c080e7          	jalr	1660(ra) # 8002053c <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80022ec8:	409c                	lw	a5,0(s1)
    80022eca:	ef99                	bnez	a5,80022ee8 <holdingsleep+0x3e>
    80022ecc:	4481                	li	s1,0
  release(&lk->lk);
    80022ece:	854a                	mv	a0,s2
    80022ed0:	ffffd097          	auipc	ra,0xffffd
    80022ed4:	720080e7          	jalr	1824(ra) # 800205f0 <release>
  return r;
}
    80022ed8:	8526                	mv	a0,s1
    80022eda:	70a2                	ld	ra,40(sp)
    80022edc:	7402                	ld	s0,32(sp)
    80022ede:	64e2                	ld	s1,24(sp)
    80022ee0:	6942                	ld	s2,16(sp)
    80022ee2:	69a2                	ld	s3,8(sp)
    80022ee4:	6145                	addi	sp,sp,48
    80022ee6:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80022ee8:	0284a983          	lw	s3,40(s1)
    80022eec:	ffffe097          	auipc	ra,0xffffe
    80022ef0:	6ea080e7          	jalr	1770(ra) # 800215d6 <myproc>
    80022ef4:	5d04                	lw	s1,56(a0)
    80022ef6:	413484b3          	sub	s1,s1,s3
    80022efa:	0014b493          	seqz	s1,s1
    80022efe:	bfc1                	j	80022ece <holdingsleep+0x24>

0000000080022f00 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80022f00:	1141                	addi	sp,sp,-16
    80022f02:	e406                	sd	ra,8(sp)
    80022f04:	e022                	sd	s0,0(sp)
    80022f06:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80022f08:	00006597          	auipc	a1,0x6
    80022f0c:	7b858593          	addi	a1,a1,1976 # 800296c0 <syscalls+0x170>
    80022f10:	00017517          	auipc	a0,0x17
    80022f14:	26850513          	addi	a0,a0,616 # 8003a178 <ftable>
    80022f18:	ffffd097          	auipc	ra,0xffffd
    80022f1c:	594080e7          	jalr	1428(ra) # 800204ac <initlock>
  printf("fileinit\n");
    80022f20:	00006517          	auipc	a0,0x6
    80022f24:	7a850513          	addi	a0,a0,1960 # 800296c8 <syscalls+0x178>
    80022f28:	ffffd097          	auipc	ra,0xffffd
    80022f2c:	1f0080e7          	jalr	496(ra) # 80020118 <printf>
}
    80022f30:	60a2                	ld	ra,8(sp)
    80022f32:	6402                	ld	s0,0(sp)
    80022f34:	0141                	addi	sp,sp,16
    80022f36:	8082                	ret

0000000080022f38 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80022f38:	1101                	addi	sp,sp,-32
    80022f3a:	ec06                	sd	ra,24(sp)
    80022f3c:	e822                	sd	s0,16(sp)
    80022f3e:	e426                	sd	s1,8(sp)
    80022f40:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80022f42:	00017517          	auipc	a0,0x17
    80022f46:	23650513          	addi	a0,a0,566 # 8003a178 <ftable>
    80022f4a:	ffffd097          	auipc	ra,0xffffd
    80022f4e:	5f2080e7          	jalr	1522(ra) # 8002053c <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
    80022f52:	00017797          	auipc	a5,0x17
    80022f56:	22678793          	addi	a5,a5,550 # 8003a178 <ftable>
    80022f5a:	4fdc                	lw	a5,28(a5)
    80022f5c:	cb8d                	beqz	a5,80022f8e <filealloc+0x56>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80022f5e:	00017497          	auipc	s1,0x17
    80022f62:	25a48493          	addi	s1,s1,602 # 8003a1b8 <ftable+0x40>
    80022f66:	00018717          	auipc	a4,0x18
    80022f6a:	1ca70713          	addi	a4,a4,458 # 8003b130 <tick>
    if(f->ref == 0){
    80022f6e:	40dc                	lw	a5,4(s1)
    80022f70:	c39d                	beqz	a5,80022f96 <filealloc+0x5e>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80022f72:	02848493          	addi	s1,s1,40
    80022f76:	fee49ce3          	bne	s1,a4,80022f6e <filealloc+0x36>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80022f7a:	00017517          	auipc	a0,0x17
    80022f7e:	1fe50513          	addi	a0,a0,510 # 8003a178 <ftable>
    80022f82:	ffffd097          	auipc	ra,0xffffd
    80022f86:	66e080e7          	jalr	1646(ra) # 800205f0 <release>
  return 0;
    80022f8a:	4481                	li	s1,0
    80022f8c:	a839                	j	80022faa <filealloc+0x72>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80022f8e:	00017497          	auipc	s1,0x17
    80022f92:	20248493          	addi	s1,s1,514 # 8003a190 <ftable+0x18>
      f->ref = 1;
    80022f96:	4785                	li	a5,1
    80022f98:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80022f9a:	00017517          	auipc	a0,0x17
    80022f9e:	1de50513          	addi	a0,a0,478 # 8003a178 <ftable>
    80022fa2:	ffffd097          	auipc	ra,0xffffd
    80022fa6:	64e080e7          	jalr	1614(ra) # 800205f0 <release>
}
    80022faa:	8526                	mv	a0,s1
    80022fac:	60e2                	ld	ra,24(sp)
    80022fae:	6442                	ld	s0,16(sp)
    80022fb0:	64a2                	ld	s1,8(sp)
    80022fb2:	6105                	addi	sp,sp,32
    80022fb4:	8082                	ret

0000000080022fb6 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80022fb6:	1101                	addi	sp,sp,-32
    80022fb8:	ec06                	sd	ra,24(sp)
    80022fba:	e822                	sd	s0,16(sp)
    80022fbc:	e426                	sd	s1,8(sp)
    80022fbe:	1000                	addi	s0,sp,32
    80022fc0:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80022fc2:	00017517          	auipc	a0,0x17
    80022fc6:	1b650513          	addi	a0,a0,438 # 8003a178 <ftable>
    80022fca:	ffffd097          	auipc	ra,0xffffd
    80022fce:	572080e7          	jalr	1394(ra) # 8002053c <acquire>
  if(f->ref < 1)
    80022fd2:	40dc                	lw	a5,4(s1)
    80022fd4:	02f05263          	blez	a5,80022ff8 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80022fd8:	2785                	addiw	a5,a5,1
    80022fda:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80022fdc:	00017517          	auipc	a0,0x17
    80022fe0:	19c50513          	addi	a0,a0,412 # 8003a178 <ftable>
    80022fe4:	ffffd097          	auipc	ra,0xffffd
    80022fe8:	60c080e7          	jalr	1548(ra) # 800205f0 <release>
  return f;
}
    80022fec:	8526                	mv	a0,s1
    80022fee:	60e2                	ld	ra,24(sp)
    80022ff0:	6442                	ld	s0,16(sp)
    80022ff2:	64a2                	ld	s1,8(sp)
    80022ff4:	6105                	addi	sp,sp,32
    80022ff6:	8082                	ret
    panic("filedup");
    80022ff8:	00006517          	auipc	a0,0x6
    80022ffc:	6e050513          	addi	a0,a0,1760 # 800296d8 <syscalls+0x188>
    80023000:	ffffd097          	auipc	ra,0xffffd
    80023004:	0d6080e7          	jalr	214(ra) # 800200d6 <panic>

0000000080023008 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80023008:	7139                	addi	sp,sp,-64
    8002300a:	fc06                	sd	ra,56(sp)
    8002300c:	f822                	sd	s0,48(sp)
    8002300e:	f426                	sd	s1,40(sp)
    80023010:	f04a                	sd	s2,32(sp)
    80023012:	ec4e                	sd	s3,24(sp)
    80023014:	e852                	sd	s4,16(sp)
    80023016:	e456                	sd	s5,8(sp)
    80023018:	0080                	addi	s0,sp,64
    8002301a:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    8002301c:	00017517          	auipc	a0,0x17
    80023020:	15c50513          	addi	a0,a0,348 # 8003a178 <ftable>
    80023024:	ffffd097          	auipc	ra,0xffffd
    80023028:	518080e7          	jalr	1304(ra) # 8002053c <acquire>
  if(f->ref < 1)
    8002302c:	40dc                	lw	a5,4(s1)
    8002302e:	04f05863          	blez	a5,8002307e <fileclose+0x76>
    panic("fileclose");
  if(--f->ref > 0){
    80023032:	37fd                	addiw	a5,a5,-1
    80023034:	0007871b          	sext.w	a4,a5
    80023038:	c0dc                	sw	a5,4(s1)
    8002303a:	04e04a63          	bgtz	a4,8002308e <fileclose+0x86>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    8002303e:	0004a903          	lw	s2,0(s1)
    80023042:	0094ca03          	lbu	s4,9(s1)
    80023046:	0104b983          	ld	s3,16(s1)
    8002304a:	0184ba83          	ld	s5,24(s1)
  f->ref = 0;
    8002304e:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80023052:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80023056:	00017517          	auipc	a0,0x17
    8002305a:	12250513          	addi	a0,a0,290 # 8003a178 <ftable>
    8002305e:	ffffd097          	auipc	ra,0xffffd
    80023062:	592080e7          	jalr	1426(ra) # 800205f0 <release>

  if(ff.type == FD_PIPE){
    80023066:	4785                	li	a5,1
    80023068:	04f90463          	beq	s2,a5,800230b0 <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_ENTRY){
    8002306c:	4789                	li	a5,2
    8002306e:	02f91863          	bne	s2,a5,8002309e <fileclose+0x96>
    eput(ff.ep);
    80023072:	8556                	mv	a0,s5
    80023074:	00002097          	auipc	ra,0x2
    80023078:	79a080e7          	jalr	1946(ra) # 8002580e <eput>
    8002307c:	a00d                	j	8002309e <fileclose+0x96>
    panic("fileclose");
    8002307e:	00006517          	auipc	a0,0x6
    80023082:	66250513          	addi	a0,a0,1634 # 800296e0 <syscalls+0x190>
    80023086:	ffffd097          	auipc	ra,0xffffd
    8002308a:	050080e7          	jalr	80(ra) # 800200d6 <panic>
    release(&ftable.lock);
    8002308e:	00017517          	auipc	a0,0x17
    80023092:	0ea50513          	addi	a0,a0,234 # 8003a178 <ftable>
    80023096:	ffffd097          	auipc	ra,0xffffd
    8002309a:	55a080e7          	jalr	1370(ra) # 800205f0 <release>
  } else if (ff.type == FD_DEVICE) {

  }
}
    8002309e:	70e2                	ld	ra,56(sp)
    800230a0:	7442                	ld	s0,48(sp)
    800230a2:	74a2                	ld	s1,40(sp)
    800230a4:	7902                	ld	s2,32(sp)
    800230a6:	69e2                	ld	s3,24(sp)
    800230a8:	6a42                	ld	s4,16(sp)
    800230aa:	6aa2                	ld	s5,8(sp)
    800230ac:	6121                	addi	sp,sp,64
    800230ae:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800230b0:	85d2                	mv	a1,s4
    800230b2:	854e                	mv	a0,s3
    800230b4:	00000097          	auipc	ra,0x0
    800230b8:	3b4080e7          	jalr	948(ra) # 80023468 <pipeclose>
    800230bc:	b7cd                	j	8002309e <fileclose+0x96>

00000000800230be <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    800230be:	7159                	addi	sp,sp,-112
    800230c0:	f486                	sd	ra,104(sp)
    800230c2:	f0a2                	sd	s0,96(sp)
    800230c4:	eca6                	sd	s1,88(sp)
    800230c6:	e8ca                	sd	s2,80(sp)
    800230c8:	e4ce                	sd	s3,72(sp)
    800230ca:	1880                	addi	s0,sp,112
    800230cc:	84aa                	mv	s1,a0
    800230ce:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    800230d0:	ffffe097          	auipc	ra,0xffffe
    800230d4:	506080e7          	jalr	1286(ra) # 800215d6 <myproc>
  struct stat st;
  
  if(f->type == FD_ENTRY){
    800230d8:	4098                	lw	a4,0(s1)
    800230da:	4789                	li	a5,2
    800230dc:	04f71863          	bne	a4,a5,8002312c <filestat+0x6e>
    800230e0:	892a                	mv	s2,a0
    elock(f->ep);
    800230e2:	6c88                	ld	a0,24(s1)
    800230e4:	00002097          	auipc	ra,0x2
    800230e8:	6a6080e7          	jalr	1702(ra) # 8002578a <elock>
    estat(f->ep, &st);
    800230ec:	f9840593          	addi	a1,s0,-104
    800230f0:	6c88                	ld	a0,24(s1)
    800230f2:	00003097          	auipc	ra,0x3
    800230f6:	804080e7          	jalr	-2044(ra) # 800258f6 <estat>
    eunlock(f->ep);
    800230fa:	6c88                	ld	a0,24(s1)
    800230fc:	00002097          	auipc	ra,0x2
    80023100:	6c4080e7          	jalr	1732(ra) # 800257c0 <eunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80023104:	03800693          	li	a3,56
    80023108:	f9840613          	addi	a2,s0,-104
    8002310c:	85ce                	mv	a1,s3
    8002310e:	05093503          	ld	a0,80(s2)
    80023112:	ffffe097          	auipc	ra,0xffffe
    80023116:	08e080e7          	jalr	142(ra) # 800211a0 <copyout>
    8002311a:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    8002311e:	70a6                	ld	ra,104(sp)
    80023120:	7406                	ld	s0,96(sp)
    80023122:	64e6                	ld	s1,88(sp)
    80023124:	6946                	ld	s2,80(sp)
    80023126:	69a6                	ld	s3,72(sp)
    80023128:	6165                	addi	sp,sp,112
    8002312a:	8082                	ret
  return -1;
    8002312c:	557d                	li	a0,-1
    8002312e:	bfc5                	j	8002311e <filestat+0x60>

0000000080023130 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80023130:	7179                	addi	sp,sp,-48
    80023132:	f406                	sd	ra,40(sp)
    80023134:	f022                	sd	s0,32(sp)
    80023136:	ec26                	sd	s1,24(sp)
    80023138:	e84a                	sd	s2,16(sp)
    8002313a:	e44e                	sd	s3,8(sp)
    8002313c:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    8002313e:	00854783          	lbu	a5,8(a0)
    80023142:	c3d5                	beqz	a5,800231e6 <fileread+0xb6>
    80023144:	89b2                	mv	s3,a2
    80023146:	892e                	mv	s2,a1
    80023148:	84aa                	mv	s1,a0
    return -1;

  switch (f->type) {
    8002314a:	411c                	lw	a5,0(a0)
    8002314c:	4709                	li	a4,2
    8002314e:	06e78263          	beq	a5,a4,800231b2 <fileread+0x82>
    80023152:	470d                	li	a4,3
    80023154:	02e78b63          	beq	a5,a4,8002318a <fileread+0x5a>
    80023158:	4705                	li	a4,1
    8002315a:	00e78a63          	beq	a5,a4,8002316e <fileread+0x3e>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
            f->off += r;
        eunlock(f->ep);
        break;
    default:
      panic("fileread");
    8002315e:	00006517          	auipc	a0,0x6
    80023162:	59250513          	addi	a0,a0,1426 # 800296f0 <syscalls+0x1a0>
    80023166:	ffffd097          	auipc	ra,0xffffd
    8002316a:	f70080e7          	jalr	-144(ra) # 800200d6 <panic>
        r = piperead(f->pipe, addr, n);
    8002316e:	6908                	ld	a0,16(a0)
    80023170:	00000097          	auipc	ra,0x0
    80023174:	498080e7          	jalr	1176(ra) # 80023608 <piperead>
    80023178:	892a                	mv	s2,a0
  }

  return r;
}
    8002317a:	854a                	mv	a0,s2
    8002317c:	70a2                	ld	ra,40(sp)
    8002317e:	7402                	ld	s0,32(sp)
    80023180:	64e2                	ld	s1,24(sp)
    80023182:	6942                	ld	s2,16(sp)
    80023184:	69a2                	ld	s3,8(sp)
    80023186:	6145                	addi	sp,sp,48
    80023188:	8082                	ret
        if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    8002318a:	02451783          	lh	a5,36(a0)
    8002318e:	03079693          	slli	a3,a5,0x30
    80023192:	92c1                	srli	a3,a3,0x30
    80023194:	4725                	li	a4,9
    80023196:	04d76a63          	bltu	a4,a3,800231ea <fileread+0xba>
    8002319a:	0792                	slli	a5,a5,0x4
    8002319c:	00017717          	auipc	a4,0x17
    800231a0:	f3c70713          	addi	a4,a4,-196 # 8003a0d8 <devsw>
    800231a4:	97ba                	add	a5,a5,a4
    800231a6:	639c                	ld	a5,0(a5)
    800231a8:	c3b9                	beqz	a5,800231ee <fileread+0xbe>
        r = devsw[f->major].read(1, addr, n);
    800231aa:	4505                	li	a0,1
    800231ac:	9782                	jalr	a5
    800231ae:	892a                	mv	s2,a0
        break;
    800231b0:	b7e9                	j	8002317a <fileread+0x4a>
        elock(f->ep);
    800231b2:	6d08                	ld	a0,24(a0)
    800231b4:	00002097          	auipc	ra,0x2
    800231b8:	5d6080e7          	jalr	1494(ra) # 8002578a <elock>
          if((r = eread(f->ep, 1, addr, f->off, n)) > 0)
    800231bc:	874e                	mv	a4,s3
    800231be:	5094                	lw	a3,32(s1)
    800231c0:	864a                	mv	a2,s2
    800231c2:	4585                	li	a1,1
    800231c4:	6c88                	ld	a0,24(s1)
    800231c6:	00002097          	auipc	ra,0x2
    800231ca:	fd2080e7          	jalr	-46(ra) # 80025198 <eread>
    800231ce:	892a                	mv	s2,a0
    800231d0:	00a05563          	blez	a0,800231da <fileread+0xaa>
            f->off += r;
    800231d4:	509c                	lw	a5,32(s1)
    800231d6:	9fa9                	addw	a5,a5,a0
    800231d8:	d09c                	sw	a5,32(s1)
        eunlock(f->ep);
    800231da:	6c88                	ld	a0,24(s1)
    800231dc:	00002097          	auipc	ra,0x2
    800231e0:	5e4080e7          	jalr	1508(ra) # 800257c0 <eunlock>
        break;
    800231e4:	bf59                	j	8002317a <fileread+0x4a>
    return -1;
    800231e6:	597d                	li	s2,-1
    800231e8:	bf49                	j	8002317a <fileread+0x4a>
          return -1;
    800231ea:	597d                	li	s2,-1
    800231ec:	b779                	j	8002317a <fileread+0x4a>
    800231ee:	597d                	li	s2,-1
    800231f0:	b769                	j	8002317a <fileread+0x4a>

00000000800231f2 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    800231f2:	7179                	addi	sp,sp,-48
    800231f4:	f406                	sd	ra,40(sp)
    800231f6:	f022                	sd	s0,32(sp)
    800231f8:	ec26                	sd	s1,24(sp)
    800231fa:	e84a                	sd	s2,16(sp)
    800231fc:	e44e                	sd	s3,8(sp)
    800231fe:	e052                	sd	s4,0(sp)
    80023200:	1800                	addi	s0,sp,48
  int ret = 0;

  if(f->writable == 0)
    80023202:	00954783          	lbu	a5,9(a0)
    80023206:	cbcd                	beqz	a5,800232b8 <filewrite+0xc6>
    80023208:	8932                	mv	s2,a2
    8002320a:	89ae                	mv	s3,a1
    8002320c:	84aa                	mv	s1,a0
    return -1;

  if(f->type == FD_PIPE){
    8002320e:	411c                	lw	a5,0(a0)
    80023210:	4705                	li	a4,1
    80023212:	04e78963          	beq	a5,a4,80023264 <filewrite+0x72>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80023216:	470d                	li	a4,3
    80023218:	04e78d63          	beq	a5,a4,80023272 <filewrite+0x80>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_ENTRY){
    8002321c:	4709                	li	a4,2
    8002321e:	08e79563          	bne	a5,a4,800232a8 <filewrite+0xb6>
    elock(f->ep);
    80023222:	6d08                	ld	a0,24(a0)
    80023224:	00002097          	auipc	ra,0x2
    80023228:	566080e7          	jalr	1382(ra) # 8002578a <elock>
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    8002322c:	00090a1b          	sext.w	s4,s2
    80023230:	8752                	mv	a4,s4
    80023232:	5094                	lw	a3,32(s1)
    80023234:	864e                	mv	a2,s3
    80023236:	4585                	li	a1,1
    80023238:	6c88                	ld	a0,24(s1)
    8002323a:	00002097          	auipc	ra,0x2
    8002323e:	2f4080e7          	jalr	756(ra) # 8002552e <ewrite>
      ret = n;
      f->off += n;
    } else {
      ret = -1;
    80023242:	59fd                	li	s3,-1
    if (ewrite(f->ep, 1, addr, f->off, n) == n) {
    80023244:	05250b63          	beq	a0,s2,8002329a <filewrite+0xa8>
    }
    eunlock(f->ep);
    80023248:	6c88                	ld	a0,24(s1)
    8002324a:	00002097          	auipc	ra,0x2
    8002324e:	576080e7          	jalr	1398(ra) # 800257c0 <eunlock>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80023252:	854e                	mv	a0,s3
    80023254:	70a2                	ld	ra,40(sp)
    80023256:	7402                	ld	s0,32(sp)
    80023258:	64e2                	ld	s1,24(sp)
    8002325a:	6942                	ld	s2,16(sp)
    8002325c:	69a2                	ld	s3,8(sp)
    8002325e:	6a02                	ld	s4,0(sp)
    80023260:	6145                	addi	sp,sp,48
    80023262:	8082                	ret
    ret = pipewrite(f->pipe, addr, n);
    80023264:	6908                	ld	a0,16(a0)
    80023266:	00000097          	auipc	ra,0x0
    8002326a:	272080e7          	jalr	626(ra) # 800234d8 <pipewrite>
    8002326e:	89aa                	mv	s3,a0
    80023270:	b7cd                	j	80023252 <filewrite+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80023272:	02451783          	lh	a5,36(a0)
    80023276:	03079693          	slli	a3,a5,0x30
    8002327a:	92c1                	srli	a3,a3,0x30
    8002327c:	4725                	li	a4,9
    8002327e:	02d76f63          	bltu	a4,a3,800232bc <filewrite+0xca>
    80023282:	0792                	slli	a5,a5,0x4
    80023284:	00017717          	auipc	a4,0x17
    80023288:	e5470713          	addi	a4,a4,-428 # 8003a0d8 <devsw>
    8002328c:	97ba                	add	a5,a5,a4
    8002328e:	679c                	ld	a5,8(a5)
    80023290:	cb85                	beqz	a5,800232c0 <filewrite+0xce>
    ret = devsw[f->major].write(1, addr, n);
    80023292:	4505                	li	a0,1
    80023294:	9782                	jalr	a5
    80023296:	89aa                	mv	s3,a0
    80023298:	bf6d                	j	80023252 <filewrite+0x60>
      f->off += n;
    8002329a:	509c                	lw	a5,32(s1)
    8002329c:	01478a3b          	addw	s4,a5,s4
    800232a0:	0344a023          	sw	s4,32(s1)
      ret = n;
    800232a4:	89ca                	mv	s3,s2
    800232a6:	b74d                	j	80023248 <filewrite+0x56>
    panic("filewrite");
    800232a8:	00006517          	auipc	a0,0x6
    800232ac:	45850513          	addi	a0,a0,1112 # 80029700 <syscalls+0x1b0>
    800232b0:	ffffd097          	auipc	ra,0xffffd
    800232b4:	e26080e7          	jalr	-474(ra) # 800200d6 <panic>
    return -1;
    800232b8:	59fd                	li	s3,-1
    800232ba:	bf61                	j	80023252 <filewrite+0x60>
      return -1;
    800232bc:	59fd                	li	s3,-1
    800232be:	bf51                	j	80023252 <filewrite+0x60>
    800232c0:	59fd                	li	s3,-1
    800232c2:	bf41                	j	80023252 <filewrite+0x60>

00000000800232c4 <dirnext>:

// Read from dir f.
// addr is a user virtual address.
int
dirnext(struct file *f, uint64 addr)
{
    800232c4:	7105                	addi	sp,sp,-480
    800232c6:	ef86                	sd	ra,472(sp)
    800232c8:	eba2                	sd	s0,464(sp)
    800232ca:	e7a6                	sd	s1,456(sp)
    800232cc:	e3ca                	sd	s2,448(sp)
    800232ce:	ff4e                	sd	s3,440(sp)
    800232d0:	fb52                	sd	s4,432(sp)
    800232d2:	1380                	addi	s0,sp,480
    800232d4:	84aa                	mv	s1,a0
    800232d6:	8a2e                	mv	s4,a1
  struct proc *p = myproc();
    800232d8:	ffffe097          	auipc	ra,0xffffe
    800232dc:	2fe080e7          	jalr	766(ra) # 800215d6 <myproc>

  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    800232e0:	0084c783          	lbu	a5,8(s1)
    800232e4:	cfc1                	beqz	a5,8002337c <dirnext+0xb8>
    800232e6:	89aa                	mv	s3,a0
    800232e8:	6c98                	ld	a4,24(s1)
    800232ea:	10074783          	lbu	a5,256(a4)
    800232ee:	8bc1                	andi	a5,a5,16
    return -1;
    800232f0:	557d                	li	a0,-1
  if(f->readable == 0 || !(f->ep->attribute & ATTR_DIRECTORY))
    800232f2:	c7d1                	beqz	a5,8002337e <dirnext+0xba>

  struct dirent de;
  struct stat st;
  int count = 0;
    800232f4:	e2042623          	sw	zero,-468(s0)
  int ret;
  elock(f->ep);
    800232f8:	853a                	mv	a0,a4
    800232fa:	00002097          	auipc	ra,0x2
    800232fe:	490080e7          	jalr	1168(ra) # 8002578a <elock>
  while ((ret = enext(f->ep, &de, f->off, &count)) == 0) {  // skip empty entry
    80023302:	e2c40693          	addi	a3,s0,-468
    80023306:	5090                	lw	a2,32(s1)
    80023308:	e6840593          	addi	a1,s0,-408
    8002330c:	6c88                	ld	a0,24(s1)
    8002330e:	00002097          	auipc	ra,0x2
    80023312:	630080e7          	jalr	1584(ra) # 8002593e <enext>
    80023316:	892a                	mv	s2,a0
    80023318:	e909                	bnez	a0,8002332a <dirnext+0x66>
    f->off += count * 32;
    8002331a:	e2c42783          	lw	a5,-468(s0)
    8002331e:	0057971b          	slliw	a4,a5,0x5
    80023322:	509c                	lw	a5,32(s1)
    80023324:	9fb9                	addw	a5,a5,a4
    80023326:	d09c                	sw	a5,32(s1)
    80023328:	bfe9                	j	80023302 <dirnext+0x3e>
  }
  eunlock(f->ep);
    8002332a:	6c88                	ld	a0,24(s1)
    8002332c:	00002097          	auipc	ra,0x2
    80023330:	494080e7          	jalr	1172(ra) # 800257c0 <eunlock>
  if (ret == -1)
    80023334:	57fd                	li	a5,-1
    return 0;
    80023336:	4501                	li	a0,0
  if (ret == -1)
    80023338:	04f90363          	beq	s2,a5,8002337e <dirnext+0xba>

  f->off += count * 32;
    8002333c:	e2c42783          	lw	a5,-468(s0)
    80023340:	0057971b          	slliw	a4,a5,0x5
    80023344:	509c                	lw	a5,32(s1)
    80023346:	9fb9                	addw	a5,a5,a4
    80023348:	d09c                	sw	a5,32(s1)
  estat(&de, &st);
    8002334a:	e3040593          	addi	a1,s0,-464
    8002334e:	e6840513          	addi	a0,s0,-408
    80023352:	00002097          	auipc	ra,0x2
    80023356:	5a4080e7          	jalr	1444(ra) # 800258f6 <estat>
  if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    8002335a:	03800693          	li	a3,56
    8002335e:	e3040613          	addi	a2,s0,-464
    80023362:	85d2                	mv	a1,s4
    80023364:	0509b503          	ld	a0,80(s3)
    80023368:	ffffe097          	auipc	ra,0xffffe
    8002336c:	e38080e7          	jalr	-456(ra) # 800211a0 <copyout>
    return -1;
    80023370:	fff54513          	not	a0,a0
    80023374:	957d                	srai	a0,a0,0x3f
    80023376:	8909                	andi	a0,a0,2
    80023378:	157d                	addi	a0,a0,-1
    8002337a:	a011                	j	8002337e <dirnext+0xba>
    return -1;
    8002337c:	557d                	li	a0,-1

  return 1;
    8002337e:	60fe                	ld	ra,472(sp)
    80023380:	645e                	ld	s0,464(sp)
    80023382:	64be                	ld	s1,456(sp)
    80023384:	691e                	ld	s2,448(sp)
    80023386:	79fa                	ld	s3,440(sp)
    80023388:	7a5a                	ld	s4,432(sp)
    8002338a:	613d                	addi	sp,sp,480
    8002338c:	8082                	ret

000000008002338e <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    8002338e:	7179                	addi	sp,sp,-48
    80023390:	f406                	sd	ra,40(sp)
    80023392:	f022                	sd	s0,32(sp)
    80023394:	ec26                	sd	s1,24(sp)
    80023396:	e84a                	sd	s2,16(sp)
    80023398:	e44e                	sd	s3,8(sp)
    8002339a:	e052                	sd	s4,0(sp)
    8002339c:	1800                	addi	s0,sp,48
    8002339e:	84aa                	mv	s1,a0
    800233a0:	892e                	mv	s2,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    800233a2:	0005b023          	sd	zero,0(a1)
    800233a6:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800233aa:	00000097          	auipc	ra,0x0
    800233ae:	b8e080e7          	jalr	-1138(ra) # 80022f38 <filealloc>
    800233b2:	e088                	sd	a0,0(s1)
    800233b4:	c551                	beqz	a0,80023440 <pipealloc+0xb2>
    800233b6:	00000097          	auipc	ra,0x0
    800233ba:	b82080e7          	jalr	-1150(ra) # 80022f38 <filealloc>
    800233be:	00a93023          	sd	a0,0(s2)
    800233c2:	c92d                	beqz	a0,80023434 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800233c4:	ffffd097          	auipc	ra,0xffffd
    800233c8:	088080e7          	jalr	136(ra) # 8002044c <kalloc>
    800233cc:	89aa                	mv	s3,a0
    800233ce:	c125                	beqz	a0,8002342e <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    800233d0:	4a05                	li	s4,1
    800233d2:	23452023          	sw	s4,544(a0)
  pi->writeopen = 1;
    800233d6:	23452223          	sw	s4,548(a0)
  pi->nwrite = 0;
    800233da:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    800233de:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    800233e2:	00006597          	auipc	a1,0x6
    800233e6:	32e58593          	addi	a1,a1,814 # 80029710 <syscalls+0x1c0>
    800233ea:	ffffd097          	auipc	ra,0xffffd
    800233ee:	0c2080e7          	jalr	194(ra) # 800204ac <initlock>
  (*f0)->type = FD_PIPE;
    800233f2:	609c                	ld	a5,0(s1)
    800233f4:	0147a023          	sw	s4,0(a5)
  (*f0)->readable = 1;
    800233f8:	609c                	ld	a5,0(s1)
    800233fa:	01478423          	sb	s4,8(a5)
  (*f0)->writable = 0;
    800233fe:	609c                	ld	a5,0(s1)
    80023400:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80023404:	609c                	ld	a5,0(s1)
    80023406:	0137b823          	sd	s3,16(a5)
  (*f1)->type = FD_PIPE;
    8002340a:	00093783          	ld	a5,0(s2)
    8002340e:	0147a023          	sw	s4,0(a5)
  (*f1)->readable = 0;
    80023412:	00093783          	ld	a5,0(s2)
    80023416:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    8002341a:	00093783          	ld	a5,0(s2)
    8002341e:	014784a3          	sb	s4,9(a5)
  (*f1)->pipe = pi;
    80023422:	00093783          	ld	a5,0(s2)
    80023426:	0137b823          	sd	s3,16(a5)
  return 0;
    8002342a:	4501                	li	a0,0
    8002342c:	a025                	j	80023454 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    8002342e:	6088                	ld	a0,0(s1)
    80023430:	e501                	bnez	a0,80023438 <pipealloc+0xaa>
    80023432:	a039                	j	80023440 <pipealloc+0xb2>
    80023434:	6088                	ld	a0,0(s1)
    80023436:	c51d                	beqz	a0,80023464 <pipealloc+0xd6>
    fileclose(*f0);
    80023438:	00000097          	auipc	ra,0x0
    8002343c:	bd0080e7          	jalr	-1072(ra) # 80023008 <fileclose>
  if(*f1)
    80023440:	00093783          	ld	a5,0(s2)
    fileclose(*f1);
  return -1;
    80023444:	557d                	li	a0,-1
  if(*f1)
    80023446:	c799                	beqz	a5,80023454 <pipealloc+0xc6>
    fileclose(*f1);
    80023448:	853e                	mv	a0,a5
    8002344a:	00000097          	auipc	ra,0x0
    8002344e:	bbe080e7          	jalr	-1090(ra) # 80023008 <fileclose>
  return -1;
    80023452:	557d                	li	a0,-1
}
    80023454:	70a2                	ld	ra,40(sp)
    80023456:	7402                	ld	s0,32(sp)
    80023458:	64e2                	ld	s1,24(sp)
    8002345a:	6942                	ld	s2,16(sp)
    8002345c:	69a2                	ld	s3,8(sp)
    8002345e:	6a02                	ld	s4,0(sp)
    80023460:	6145                	addi	sp,sp,48
    80023462:	8082                	ret
  return -1;
    80023464:	557d                	li	a0,-1
    80023466:	b7fd                	j	80023454 <pipealloc+0xc6>

0000000080023468 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80023468:	1101                	addi	sp,sp,-32
    8002346a:	ec06                	sd	ra,24(sp)
    8002346c:	e822                	sd	s0,16(sp)
    8002346e:	e426                	sd	s1,8(sp)
    80023470:	e04a                	sd	s2,0(sp)
    80023472:	1000                	addi	s0,sp,32
    80023474:	84aa                	mv	s1,a0
    80023476:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80023478:	ffffd097          	auipc	ra,0xffffd
    8002347c:	0c4080e7          	jalr	196(ra) # 8002053c <acquire>
  if(writable){
    80023480:	02090d63          	beqz	s2,800234ba <pipeclose+0x52>
    pi->writeopen = 0;
    80023484:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80023488:	21848513          	addi	a0,s1,536
    8002348c:	fffff097          	auipc	ra,0xfffff
    80023490:	ba6080e7          	jalr	-1114(ra) # 80022032 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80023494:	2204b783          	ld	a5,544(s1)
    80023498:	eb95                	bnez	a5,800234cc <pipeclose+0x64>
    release(&pi->lock);
    8002349a:	8526                	mv	a0,s1
    8002349c:	ffffd097          	auipc	ra,0xffffd
    800234a0:	154080e7          	jalr	340(ra) # 800205f0 <release>
    kfree((char*)pi);
    800234a4:	8526                	mv	a0,s1
    800234a6:	ffffd097          	auipc	ra,0xffffd
    800234aa:	e94080e7          	jalr	-364(ra) # 8002033a <kfree>
  } else
    release(&pi->lock);
}
    800234ae:	60e2                	ld	ra,24(sp)
    800234b0:	6442                	ld	s0,16(sp)
    800234b2:	64a2                	ld	s1,8(sp)
    800234b4:	6902                	ld	s2,0(sp)
    800234b6:	6105                	addi	sp,sp,32
    800234b8:	8082                	ret
    pi->readopen = 0;
    800234ba:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800234be:	21c48513          	addi	a0,s1,540
    800234c2:	fffff097          	auipc	ra,0xfffff
    800234c6:	b70080e7          	jalr	-1168(ra) # 80022032 <wakeup>
    800234ca:	b7e9                	j	80023494 <pipeclose+0x2c>
    release(&pi->lock);
    800234cc:	8526                	mv	a0,s1
    800234ce:	ffffd097          	auipc	ra,0xffffd
    800234d2:	122080e7          	jalr	290(ra) # 800205f0 <release>
}
    800234d6:	bfe1                	j	800234ae <pipeclose+0x46>

00000000800234d8 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800234d8:	7119                	addi	sp,sp,-128
    800234da:	fc86                	sd	ra,120(sp)
    800234dc:	f8a2                	sd	s0,112(sp)
    800234de:	f4a6                	sd	s1,104(sp)
    800234e0:	f0ca                	sd	s2,96(sp)
    800234e2:	ecce                	sd	s3,88(sp)
    800234e4:	e8d2                	sd	s4,80(sp)
    800234e6:	e4d6                	sd	s5,72(sp)
    800234e8:	e0da                	sd	s6,64(sp)
    800234ea:	fc5e                	sd	s7,56(sp)
    800234ec:	f862                	sd	s8,48(sp)
    800234ee:	f466                	sd	s9,40(sp)
    800234f0:	f06a                	sd	s10,32(sp)
    800234f2:	ec6e                	sd	s11,24(sp)
    800234f4:	0100                	addi	s0,sp,128
    800234f6:	84aa                	mv	s1,a0
    800234f8:	8d2e                	mv	s10,a1
    800234fa:	8b32                	mv	s6,a2
  int i;
  char ch;
  struct proc *pr = myproc();
    800234fc:	ffffe097          	auipc	ra,0xffffe
    80023500:	0da080e7          	jalr	218(ra) # 800215d6 <myproc>
    80023504:	892a                	mv	s2,a0

  acquire(&pi->lock);
    80023506:	8526                	mv	a0,s1
    80023508:	ffffd097          	auipc	ra,0xffffd
    8002350c:	034080e7          	jalr	52(ra) # 8002053c <acquire>
  for(i = 0; i < n; i++){
    80023510:	0d605f63          	blez	s6,800235ee <pipewrite+0x116>
    80023514:	89a6                	mv	s3,s1
    80023516:	3b7d                	addiw	s6,s6,-1
    80023518:	1b02                	slli	s6,s6,0x20
    8002351a:	020b5b13          	srli	s6,s6,0x20
    8002351e:	4b81                	li	s7,0
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || pr->killed){
        release(&pi->lock);
        return -1;
      }
      wakeup(&pi->nread);
    80023520:	21848a93          	addi	s5,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80023524:	21c48a13          	addi	s4,s1,540
    }
    if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80023528:	5dfd                	li	s11,-1
    8002352a:	000b8c9b          	sext.w	s9,s7
    8002352e:	8c66                	mv	s8,s9
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023530:	2184a783          	lw	a5,536(s1)
    80023534:	21c4a703          	lw	a4,540(s1)
    80023538:	2007879b          	addiw	a5,a5,512
    8002353c:	06f71763          	bne	a4,a5,800235aa <pipewrite+0xd2>
      if(pi->readopen == 0 || pr->killed){
    80023540:	2204a783          	lw	a5,544(s1)
    80023544:	cf8d                	beqz	a5,8002357e <pipewrite+0xa6>
    80023546:	03092783          	lw	a5,48(s2)
    8002354a:	eb95                	bnez	a5,8002357e <pipewrite+0xa6>
      wakeup(&pi->nread);
    8002354c:	8556                	mv	a0,s5
    8002354e:	fffff097          	auipc	ra,0xfffff
    80023552:	ae4080e7          	jalr	-1308(ra) # 80022032 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80023556:	85ce                	mv	a1,s3
    80023558:	8552                	mv	a0,s4
    8002355a:	fffff097          	auipc	ra,0xfffff
    8002355e:	952080e7          	jalr	-1710(ra) # 80021eac <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80023562:	2184a783          	lw	a5,536(s1)
    80023566:	21c4a703          	lw	a4,540(s1)
    8002356a:	2007879b          	addiw	a5,a5,512
    8002356e:	02f71e63          	bne	a4,a5,800235aa <pipewrite+0xd2>
      if(pi->readopen == 0 || pr->killed){
    80023572:	2204a783          	lw	a5,544(s1)
    80023576:	c781                	beqz	a5,8002357e <pipewrite+0xa6>
    80023578:	03092783          	lw	a5,48(s2)
    8002357c:	dbe1                	beqz	a5,8002354c <pipewrite+0x74>
        release(&pi->lock);
    8002357e:	8526                	mv	a0,s1
    80023580:	ffffd097          	auipc	ra,0xffffd
    80023584:	070080e7          	jalr	112(ra) # 800205f0 <release>
        return -1;
    80023588:	5c7d                	li	s8,-1
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
  }
  wakeup(&pi->nread);
  release(&pi->lock);
  return i;
}
    8002358a:	8562                	mv	a0,s8
    8002358c:	70e6                	ld	ra,120(sp)
    8002358e:	7446                	ld	s0,112(sp)
    80023590:	74a6                	ld	s1,104(sp)
    80023592:	7906                	ld	s2,96(sp)
    80023594:	69e6                	ld	s3,88(sp)
    80023596:	6a46                	ld	s4,80(sp)
    80023598:	6aa6                	ld	s5,72(sp)
    8002359a:	6b06                	ld	s6,64(sp)
    8002359c:	7be2                	ld	s7,56(sp)
    8002359e:	7c42                	ld	s8,48(sp)
    800235a0:	7ca2                	ld	s9,40(sp)
    800235a2:	7d02                	ld	s10,32(sp)
    800235a4:	6de2                	ld	s11,24(sp)
    800235a6:	6109                	addi	sp,sp,128
    800235a8:	8082                	ret
    if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800235aa:	4685                	li	a3,1
    800235ac:	01ab8633          	add	a2,s7,s10
    800235b0:	f8f40593          	addi	a1,s0,-113
    800235b4:	05093503          	ld	a0,80(s2)
    800235b8:	ffffe097          	auipc	ra,0xffffe
    800235bc:	c74080e7          	jalr	-908(ra) # 8002122c <copyin>
    800235c0:	03b50863          	beq	a0,s11,800235f0 <pipewrite+0x118>
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800235c4:	21c4a783          	lw	a5,540(s1)
    800235c8:	0017871b          	addiw	a4,a5,1
    800235cc:	20e4ae23          	sw	a4,540(s1)
    800235d0:	1ff7f793          	andi	a5,a5,511
    800235d4:	97a6                	add	a5,a5,s1
    800235d6:	f8f44703          	lbu	a4,-113(s0)
    800235da:	00e78c23          	sb	a4,24(a5)
    800235de:	001c8c1b          	addiw	s8,s9,1
    800235e2:	001b8793          	addi	a5,s7,1
  for(i = 0; i < n; i++){
    800235e6:	016b8563          	beq	s7,s6,800235f0 <pipewrite+0x118>
    800235ea:	8bbe                	mv	s7,a5
    800235ec:	bf3d                	j	8002352a <pipewrite+0x52>
    800235ee:	4c01                	li	s8,0
  wakeup(&pi->nread);
    800235f0:	21848513          	addi	a0,s1,536
    800235f4:	fffff097          	auipc	ra,0xfffff
    800235f8:	a3e080e7          	jalr	-1474(ra) # 80022032 <wakeup>
  release(&pi->lock);
    800235fc:	8526                	mv	a0,s1
    800235fe:	ffffd097          	auipc	ra,0xffffd
    80023602:	ff2080e7          	jalr	-14(ra) # 800205f0 <release>
  return i;
    80023606:	b751                	j	8002358a <pipewrite+0xb2>

0000000080023608 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80023608:	715d                	addi	sp,sp,-80
    8002360a:	e486                	sd	ra,72(sp)
    8002360c:	e0a2                	sd	s0,64(sp)
    8002360e:	fc26                	sd	s1,56(sp)
    80023610:	f84a                	sd	s2,48(sp)
    80023612:	f44e                	sd	s3,40(sp)
    80023614:	f052                	sd	s4,32(sp)
    80023616:	ec56                	sd	s5,24(sp)
    80023618:	e85a                	sd	s6,16(sp)
    8002361a:	0880                	addi	s0,sp,80
    8002361c:	84aa                	mv	s1,a0
    8002361e:	89ae                	mv	s3,a1
    80023620:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80023622:	ffffe097          	auipc	ra,0xffffe
    80023626:	fb4080e7          	jalr	-76(ra) # 800215d6 <myproc>
    8002362a:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    8002362c:	8526                	mv	a0,s1
    8002362e:	ffffd097          	auipc	ra,0xffffd
    80023632:	f0e080e7          	jalr	-242(ra) # 8002053c <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80023636:	2184a703          	lw	a4,536(s1)
    8002363a:	21c4a783          	lw	a5,540(s1)
    8002363e:	06f71b63          	bne	a4,a5,800236b4 <piperead+0xac>
    80023642:	8926                	mv	s2,s1
    80023644:	2244a783          	lw	a5,548(s1)
    80023648:	cf9d                	beqz	a5,80023686 <piperead+0x7e>
    if(pr->killed){
    8002364a:	030a2783          	lw	a5,48(s4)
    8002364e:	e78d                	bnez	a5,80023678 <piperead+0x70>
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80023650:	21848b13          	addi	s6,s1,536
    80023654:	85ca                	mv	a1,s2
    80023656:	855a                	mv	a0,s6
    80023658:	fffff097          	auipc	ra,0xfffff
    8002365c:	854080e7          	jalr	-1964(ra) # 80021eac <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80023660:	2184a703          	lw	a4,536(s1)
    80023664:	21c4a783          	lw	a5,540(s1)
    80023668:	04f71663          	bne	a4,a5,800236b4 <piperead+0xac>
    8002366c:	2244a783          	lw	a5,548(s1)
    80023670:	cb99                	beqz	a5,80023686 <piperead+0x7e>
    if(pr->killed){
    80023672:	030a2783          	lw	a5,48(s4)
    80023676:	dff9                	beqz	a5,80023654 <piperead+0x4c>
      release(&pi->lock);
    80023678:	8526                	mv	a0,s1
    8002367a:	ffffd097          	auipc	ra,0xffffd
    8002367e:	f76080e7          	jalr	-138(ra) # 800205f0 <release>
      return -1;
    80023682:	597d                	li	s2,-1
    80023684:	a829                	j	8002369e <piperead+0x96>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(pi->nread == pi->nwrite)
    80023686:	4901                	li	s2,0
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80023688:	21c48513          	addi	a0,s1,540
    8002368c:	fffff097          	auipc	ra,0xfffff
    80023690:	9a6080e7          	jalr	-1626(ra) # 80022032 <wakeup>
  release(&pi->lock);
    80023694:	8526                	mv	a0,s1
    80023696:	ffffd097          	auipc	ra,0xffffd
    8002369a:	f5a080e7          	jalr	-166(ra) # 800205f0 <release>
  return i;
}
    8002369e:	854a                	mv	a0,s2
    800236a0:	60a6                	ld	ra,72(sp)
    800236a2:	6406                	ld	s0,64(sp)
    800236a4:	74e2                	ld	s1,56(sp)
    800236a6:	7942                	ld	s2,48(sp)
    800236a8:	79a2                	ld	s3,40(sp)
    800236aa:	7a02                	ld	s4,32(sp)
    800236ac:	6ae2                	ld	s5,24(sp)
    800236ae:	6b42                	ld	s6,16(sp)
    800236b0:	6161                	addi	sp,sp,80
    800236b2:	8082                	ret
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800236b4:	4901                	li	s2,0
    800236b6:	fd5059e3          	blez	s5,80023688 <piperead+0x80>
    if(pi->nread == pi->nwrite)
    800236ba:	2184a783          	lw	a5,536(s1)
    800236be:	4901                	li	s2,0
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800236c0:	5b7d                	li	s6,-1
    ch = pi->data[pi->nread++ % PIPESIZE];
    800236c2:	0017871b          	addiw	a4,a5,1
    800236c6:	20e4ac23          	sw	a4,536(s1)
    800236ca:	1ff7f793          	andi	a5,a5,511
    800236ce:	97a6                	add	a5,a5,s1
    800236d0:	0187c783          	lbu	a5,24(a5)
    800236d4:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800236d8:	4685                	li	a3,1
    800236da:	fbf40613          	addi	a2,s0,-65
    800236de:	85ce                	mv	a1,s3
    800236e0:	050a3503          	ld	a0,80(s4)
    800236e4:	ffffe097          	auipc	ra,0xffffe
    800236e8:	abc080e7          	jalr	-1348(ra) # 800211a0 <copyout>
    800236ec:	f9650ee3          	beq	a0,s6,80023688 <piperead+0x80>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800236f0:	2905                	addiw	s2,s2,1
    800236f2:	f92a8be3          	beq	s5,s2,80023688 <piperead+0x80>
    if(pi->nread == pi->nwrite)
    800236f6:	2184a783          	lw	a5,536(s1)
    800236fa:	0985                	addi	s3,s3,1
    800236fc:	21c4a703          	lw	a4,540(s1)
    80023700:	fcf711e3          	bne	a4,a5,800236c2 <piperead+0xba>
    80023704:	b751                	j	80023688 <piperead+0x80>

0000000080023706 <exec>:
  return 0;
}


int exec(char *path, char **argv)
{
    80023706:	de010113          	addi	sp,sp,-544
    8002370a:	20113c23          	sd	ra,536(sp)
    8002370e:	20813823          	sd	s0,528(sp)
    80023712:	20913423          	sd	s1,520(sp)
    80023716:	21213023          	sd	s2,512(sp)
    8002371a:	ffce                	sd	s3,504(sp)
    8002371c:	fbd2                	sd	s4,496(sp)
    8002371e:	f7d6                	sd	s5,488(sp)
    80023720:	f3da                	sd	s6,480(sp)
    80023722:	efde                	sd	s7,472(sp)
    80023724:	ebe2                	sd	s8,464(sp)
    80023726:	e7e6                	sd	s9,456(sp)
    80023728:	e3ea                	sd	s10,448(sp)
    8002372a:	ff6e                	sd	s11,440(sp)
    8002372c:	1400                	addi	s0,sp,544
    8002372e:	84aa                	mv	s1,a0
    80023730:	dea43823          	sd	a0,-528(s0)
    80023734:	deb43c23          	sd	a1,-520(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
  struct elfhdr elf;
  struct dirent *ep;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80023738:	ffffe097          	auipc	ra,0xffffe
    8002373c:	e9e080e7          	jalr	-354(ra) # 800215d6 <myproc>
    80023740:	892a                	mv	s2,a0

  if((ep = ename(path)) == 0)
    80023742:	8526                	mv	a0,s1
    80023744:	00003097          	auipc	ra,0x3
    80023748:	9be080e7          	jalr	-1602(ra) # 80026102 <ename>
    8002374c:	28050363          	beqz	a0,800239d2 <exec+0x2cc>
    80023750:	84aa                	mv	s1,a0
    return -1;
  elock(ep);
    80023752:	00002097          	auipc	ra,0x2
    80023756:	038080e7          	jalr	56(ra) # 8002578a <elock>

  // Check ELF header
  if(eread(ep, 0, (uint64) &elf, 0, sizeof(elf)) != sizeof(elf))
    8002375a:	04000713          	li	a4,64
    8002375e:	4681                	li	a3,0
    80023760:	e4840613          	addi	a2,s0,-440
    80023764:	4581                	li	a1,0
    80023766:	8526                	mv	a0,s1
    80023768:	00002097          	auipc	ra,0x2
    8002376c:	a30080e7          	jalr	-1488(ra) # 80025198 <eread>
    80023770:	04000793          	li	a5,64
    80023774:	00f51a63          	bne	a0,a5,80023788 <exec+0x82>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80023778:	e4842703          	lw	a4,-440(s0)
    8002377c:	464c47b7          	lui	a5,0x464c4
    80023780:	57f78793          	addi	a5,a5,1407 # 464c457f <BASE_ADDRESS-0x39b5ba81>
    80023784:	04f70163          	beq	a4,a5,800237c6 <exec+0xc0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ep){
    eunlock(ep);
    80023788:	8526                	mv	a0,s1
    8002378a:	00002097          	auipc	ra,0x2
    8002378e:	036080e7          	jalr	54(ra) # 800257c0 <eunlock>
    eput(ep);
    80023792:	8526                	mv	a0,s1
    80023794:	00002097          	auipc	ra,0x2
    80023798:	07a080e7          	jalr	122(ra) # 8002580e <eput>
  }
  return -1;
    8002379c:	557d                	li	a0,-1
}
    8002379e:	21813083          	ld	ra,536(sp)
    800237a2:	21013403          	ld	s0,528(sp)
    800237a6:	20813483          	ld	s1,520(sp)
    800237aa:	20013903          	ld	s2,512(sp)
    800237ae:	79fe                	ld	s3,504(sp)
    800237b0:	7a5e                	ld	s4,496(sp)
    800237b2:	7abe                	ld	s5,488(sp)
    800237b4:	7b1e                	ld	s6,480(sp)
    800237b6:	6bfe                	ld	s7,472(sp)
    800237b8:	6c5e                	ld	s8,464(sp)
    800237ba:	6cbe                	ld	s9,456(sp)
    800237bc:	6d1e                	ld	s10,448(sp)
    800237be:	7dfa                	ld	s11,440(sp)
    800237c0:	22010113          	addi	sp,sp,544
    800237c4:	8082                	ret
  if((pagetable = proc_pagetable(p)) == 0)
    800237c6:	854a                	mv	a0,s2
    800237c8:	ffffe097          	auipc	ra,0xffffe
    800237cc:	ec8080e7          	jalr	-312(ra) # 80021690 <proc_pagetable>
    800237d0:	e0a43423          	sd	a0,-504(s0)
    800237d4:	d955                	beqz	a0,80023788 <exec+0x82>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800237d6:	e6842983          	lw	s3,-408(s0)
    800237da:	e8045783          	lhu	a5,-384(s0)
    800237de:	c7b5                	beqz	a5,8002384a <exec+0x144>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    800237e0:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800237e2:	4b01                	li	s6,0
    if(ph.vaddr % PGSIZE != 0)
    800237e4:	6c05                	lui	s8,0x1
    800237e6:	fffc0793          	addi	a5,s8,-1 # fff <BASE_ADDRESS-0x8001f001>
    800237ea:	def43423          	sd	a5,-536(s0)
    800237ee:	7cfd                	lui	s9,0xfffff
    800237f0:	ac3d                	j	80023a2e <exec+0x328>
      panic("loadseg: address should exist");
    800237f2:	00006517          	auipc	a0,0x6
    800237f6:	f2650513          	addi	a0,a0,-218 # 80029718 <syscalls+0x1c8>
    800237fa:	ffffd097          	auipc	ra,0xffffd
    800237fe:	8dc080e7          	jalr	-1828(ra) # 800200d6 <panic>
    if(eread(ep, 0, (uint64)pa, offset+i, n) != n)
    80023802:	8756                	mv	a4,s5
    80023804:	012d86bb          	addw	a3,s11,s2
    80023808:	4581                	li	a1,0
    8002380a:	8526                	mv	a0,s1
    8002380c:	00002097          	auipc	ra,0x2
    80023810:	98c080e7          	jalr	-1652(ra) # 80025198 <eread>
    80023814:	2501                	sext.w	a0,a0
    80023816:	1caa9263          	bne	s5,a0,800239da <exec+0x2d4>
  for(i = 0; i < sz; i += PGSIZE){
    8002381a:	6785                	lui	a5,0x1
    8002381c:	0127893b          	addw	s2,a5,s2
    80023820:	014c8a3b          	addw	s4,s9,s4
    80023824:	1f797c63          	bgeu	s2,s7,80023a1c <exec+0x316>
    pa = walkaddr(pagetable, va + i);
    80023828:	02091593          	slli	a1,s2,0x20
    8002382c:	9181                	srli	a1,a1,0x20
    8002382e:	95ea                	add	a1,a1,s10
    80023830:	e0843503          	ld	a0,-504(s0)
    80023834:	ffffd097          	auipc	ra,0xffffd
    80023838:	298080e7          	jalr	664(ra) # 80020acc <walkaddr>
    8002383c:	862a                	mv	a2,a0
    if(pa == 0)
    8002383e:	d955                	beqz	a0,800237f2 <exec+0xec>
      n = PGSIZE;
    80023840:	8ae2                	mv	s5,s8
    if(sz - i < PGSIZE)
    80023842:	fd8a70e3          	bgeu	s4,s8,80023802 <exec+0xfc>
      n = sz - i;
    80023846:	8ad2                	mv	s5,s4
    80023848:	bf6d                	j	80023802 <exec+0xfc>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    8002384a:	4901                	li	s2,0
  eunlock(ep);
    8002384c:	8526                	mv	a0,s1
    8002384e:	00002097          	auipc	ra,0x2
    80023852:	f72080e7          	jalr	-142(ra) # 800257c0 <eunlock>
  eput(ep);
    80023856:	8526                	mv	a0,s1
    80023858:	00002097          	auipc	ra,0x2
    8002385c:	fb6080e7          	jalr	-74(ra) # 8002580e <eput>
  p = myproc();
    80023860:	ffffe097          	auipc	ra,0xffffe
    80023864:	d76080e7          	jalr	-650(ra) # 800215d6 <myproc>
    80023868:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    8002386a:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    8002386e:	6785                	lui	a5,0x1
    80023870:	17fd                	addi	a5,a5,-1
    80023872:	993e                	add	s2,s2,a5
    80023874:	77fd                	lui	a5,0xfffff
    80023876:	00f977b3          	and	a5,s2,a5
    8002387a:	e0f43023          	sd	a5,-512(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    8002387e:	6609                	lui	a2,0x2
    80023880:	963e                	add	a2,a2,a5
    80023882:	85be                	mv	a1,a5
    80023884:	e0843903          	ld	s2,-504(s0)
    80023888:	854a                	mv	a0,s2
    8002388a:	ffffd097          	auipc	ra,0xffffd
    8002388e:	6c6080e7          	jalr	1734(ra) # 80020f50 <uvmalloc>
    80023892:	8b2a                	mv	s6,a0
  ep = 0;
    80023894:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80023896:	14050263          	beqz	a0,800239da <exec+0x2d4>
  uvmclear(pagetable, sz-2*PGSIZE);
    8002389a:	75f9                	lui	a1,0xffffe
    8002389c:	95aa                	add	a1,a1,a0
    8002389e:	854a                	mv	a0,s2
    800238a0:	ffffe097          	auipc	ra,0xffffe
    800238a4:	8ce080e7          	jalr	-1842(ra) # 8002116e <uvmclear>
  stackbase = sp - PGSIZE;
    800238a8:	7bfd                	lui	s7,0xfffff
    800238aa:	9bda                	add	s7,s7,s6
  for(argc = 0; argv[argc]; argc++) {
    800238ac:	df843783          	ld	a5,-520(s0)
    800238b0:	6388                	ld	a0,0(a5)
    800238b2:	c53d                	beqz	a0,80023920 <exec+0x21a>
    800238b4:	e8840993          	addi	s3,s0,-376
    800238b8:	f8840c13          	addi	s8,s0,-120
  sp = sz;
    800238bc:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    800238be:	ffffd097          	auipc	ra,0xffffd
    800238c2:	f24080e7          	jalr	-220(ra) # 800207e2 <strlen>
    800238c6:	2505                	addiw	a0,a0,1
    800238c8:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800238cc:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    800238d0:	13796a63          	bltu	s2,s7,80023a04 <exec+0x2fe>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800238d4:	df843c83          	ld	s9,-520(s0)
    800238d8:	000cba03          	ld	s4,0(s9) # fffffffffffff000 <kernel_end+0xffffffff7ffbf000>
    800238dc:	8552                	mv	a0,s4
    800238de:	ffffd097          	auipc	ra,0xffffd
    800238e2:	f04080e7          	jalr	-252(ra) # 800207e2 <strlen>
    800238e6:	0015069b          	addiw	a3,a0,1
    800238ea:	8652                	mv	a2,s4
    800238ec:	85ca                	mv	a1,s2
    800238ee:	e0843503          	ld	a0,-504(s0)
    800238f2:	ffffe097          	auipc	ra,0xffffe
    800238f6:	8ae080e7          	jalr	-1874(ra) # 800211a0 <copyout>
    800238fa:	10054963          	bltz	a0,80023a0c <exec+0x306>
    ustack[argc] = sp;
    800238fe:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80023902:	0485                	addi	s1,s1,1
    80023904:	008c8793          	addi	a5,s9,8
    80023908:	def43c23          	sd	a5,-520(s0)
    8002390c:	008cb503          	ld	a0,8(s9)
    80023910:	c911                	beqz	a0,80023924 <exec+0x21e>
    if(argc >= MAXARG)
    80023912:	09a1                	addi	s3,s3,8
    80023914:	fb8995e3          	bne	s3,s8,800238be <exec+0x1b8>
  sz = sz1;
    80023918:	e1643023          	sd	s6,-512(s0)
  ep = 0;
    8002391c:	4481                	li	s1,0
    8002391e:	a875                	j	800239da <exec+0x2d4>
  sp = sz;
    80023920:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    80023922:	4481                	li	s1,0
  ustack[argc] = 0;
    80023924:	00349793          	slli	a5,s1,0x3
    80023928:	f9040713          	addi	a4,s0,-112
    8002392c:	97ba                	add	a5,a5,a4
    8002392e:	ee07bc23          	sd	zero,-264(a5) # ffffffffffffeef8 <kernel_end+0xffffffff7ffbeef8>
  sp -= (argc+1) * sizeof(uint64);
    80023932:	00148693          	addi	a3,s1,1
    80023936:	068e                	slli	a3,a3,0x3
    80023938:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8002393c:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80023940:	01797663          	bgeu	s2,s7,8002394c <exec+0x246>
  sz = sz1;
    80023944:	e1643023          	sd	s6,-512(s0)
  ep = 0;
    80023948:	4481                	li	s1,0
    8002394a:	a841                	j	800239da <exec+0x2d4>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8002394c:	e8840613          	addi	a2,s0,-376
    80023950:	85ca                	mv	a1,s2
    80023952:	e0843503          	ld	a0,-504(s0)
    80023956:	ffffe097          	auipc	ra,0xffffe
    8002395a:	84a080e7          	jalr	-1974(ra) # 800211a0 <copyout>
    8002395e:	0a054b63          	bltz	a0,80023a14 <exec+0x30e>
  p->trapframe->a1 = sp;
    80023962:	058ab783          	ld	a5,88(s5)
    80023966:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8002396a:	df043783          	ld	a5,-528(s0)
    8002396e:	0007c703          	lbu	a4,0(a5)
    80023972:	cf11                	beqz	a4,8002398e <exec+0x288>
    80023974:	0785                	addi	a5,a5,1
    if(*s == '/')
    80023976:	02f00693          	li	a3,47
    8002397a:	a029                	j	80023984 <exec+0x27e>
    8002397c:	0785                	addi	a5,a5,1
  for(last=s=path; *s; s++)
    8002397e:	fff7c703          	lbu	a4,-1(a5)
    80023982:	c711                	beqz	a4,8002398e <exec+0x288>
    if(*s == '/')
    80023984:	fed71ce3          	bne	a4,a3,8002397c <exec+0x276>
      last = s+1;
    80023988:	def43823          	sd	a5,-528(s0)
    8002398c:	bfc5                	j	8002397c <exec+0x276>
  safestrcpy(p->name, last, sizeof(p->name));
    8002398e:	4641                	li	a2,16
    80023990:	df043583          	ld	a1,-528(s0)
    80023994:	158a8513          	addi	a0,s5,344
    80023998:	ffffd097          	auipc	ra,0xffffd
    8002399c:	e18080e7          	jalr	-488(ra) # 800207b0 <safestrcpy>
  oldpagetable = p->pagetable;
    800239a0:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    800239a4:	e0843783          	ld	a5,-504(s0)
    800239a8:	04fab823          	sd	a5,80(s5)
  p->sz = sz;
    800239ac:	056ab423          	sd	s6,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800239b0:	058ab783          	ld	a5,88(s5)
    800239b4:	e6043703          	ld	a4,-416(s0)
    800239b8:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800239ba:	058ab783          	ld	a5,88(s5)
    800239be:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800239c2:	85ea                	mv	a1,s10
    800239c4:	ffffe097          	auipc	ra,0xffffe
    800239c8:	d68080e7          	jalr	-664(ra) # 8002172c <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800239cc:	0004851b          	sext.w	a0,s1
    800239d0:	b3f9                	j	8002379e <exec+0x98>
    return -1;
    800239d2:	557d                	li	a0,-1
    800239d4:	b3e9                	j	8002379e <exec+0x98>
    800239d6:	e1243023          	sd	s2,-512(s0)
    proc_freepagetable(pagetable, sz);
    800239da:	e0043583          	ld	a1,-512(s0)
    800239de:	e0843503          	ld	a0,-504(s0)
    800239e2:	ffffe097          	auipc	ra,0xffffe
    800239e6:	d4a080e7          	jalr	-694(ra) # 8002172c <proc_freepagetable>
  if(ep){
    800239ea:	d8049fe3          	bnez	s1,80023788 <exec+0x82>
  return -1;
    800239ee:	557d                	li	a0,-1
    800239f0:	b37d                	j	8002379e <exec+0x98>
    800239f2:	e1243023          	sd	s2,-512(s0)
    800239f6:	b7d5                	j	800239da <exec+0x2d4>
    800239f8:	e1243023          	sd	s2,-512(s0)
    800239fc:	bff9                	j	800239da <exec+0x2d4>
    800239fe:	e1243023          	sd	s2,-512(s0)
    80023a02:	bfe1                	j	800239da <exec+0x2d4>
  sz = sz1;
    80023a04:	e1643023          	sd	s6,-512(s0)
  ep = 0;
    80023a08:	4481                	li	s1,0
    80023a0a:	bfc1                	j	800239da <exec+0x2d4>
  sz = sz1;
    80023a0c:	e1643023          	sd	s6,-512(s0)
  ep = 0;
    80023a10:	4481                	li	s1,0
    80023a12:	b7e1                	j	800239da <exec+0x2d4>
  sz = sz1;
    80023a14:	e1643023          	sd	s6,-512(s0)
  ep = 0;
    80023a18:	4481                	li	s1,0
    80023a1a:	b7c1                	j	800239da <exec+0x2d4>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80023a1c:	e0043903          	ld	s2,-512(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80023a20:	2b05                	addiw	s6,s6,1
    80023a22:	0389899b          	addiw	s3,s3,56
    80023a26:	e8045783          	lhu	a5,-384(s0)
    80023a2a:	e2fb51e3          	bge	s6,a5,8002384c <exec+0x146>
    if(eread(ep, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80023a2e:	2981                	sext.w	s3,s3
    80023a30:	03800713          	li	a4,56
    80023a34:	86ce                	mv	a3,s3
    80023a36:	e1040613          	addi	a2,s0,-496
    80023a3a:	4581                	li	a1,0
    80023a3c:	8526                	mv	a0,s1
    80023a3e:	00001097          	auipc	ra,0x1
    80023a42:	75a080e7          	jalr	1882(ra) # 80025198 <eread>
    80023a46:	03800793          	li	a5,56
    80023a4a:	f8f516e3          	bne	a0,a5,800239d6 <exec+0x2d0>
    if(ph.type != ELF_PROG_LOAD)
    80023a4e:	e1042783          	lw	a5,-496(s0)
    80023a52:	4705                	li	a4,1
    80023a54:	fce796e3          	bne	a5,a4,80023a20 <exec+0x31a>
    if(ph.memsz < ph.filesz)
    80023a58:	e3843603          	ld	a2,-456(s0)
    80023a5c:	e3043783          	ld	a5,-464(s0)
    80023a60:	f8f669e3          	bltu	a2,a5,800239f2 <exec+0x2ec>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80023a64:	e2043783          	ld	a5,-480(s0)
    80023a68:	963e                	add	a2,a2,a5
    80023a6a:	f8f667e3          	bltu	a2,a5,800239f8 <exec+0x2f2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80023a6e:	85ca                	mv	a1,s2
    80023a70:	e0843503          	ld	a0,-504(s0)
    80023a74:	ffffd097          	auipc	ra,0xffffd
    80023a78:	4dc080e7          	jalr	1244(ra) # 80020f50 <uvmalloc>
    80023a7c:	e0a43023          	sd	a0,-512(s0)
    80023a80:	dd3d                	beqz	a0,800239fe <exec+0x2f8>
    if(ph.vaddr % PGSIZE != 0)
    80023a82:	e2043d03          	ld	s10,-480(s0)
    80023a86:	de843783          	ld	a5,-536(s0)
    80023a8a:	00fd77b3          	and	a5,s10,a5
    80023a8e:	f7b1                	bnez	a5,800239da <exec+0x2d4>
    if(loadseg(pagetable, ph.vaddr, ep, ph.off, ph.filesz) < 0)
    80023a90:	e1842d83          	lw	s11,-488(s0)
    80023a94:	e3042b83          	lw	s7,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80023a98:	f80b82e3          	beqz	s7,80023a1c <exec+0x316>
    80023a9c:	8a5e                	mv	s4,s7
    80023a9e:	4901                	li	s2,0
    80023aa0:	b361                	j	80023828 <exec+0x122>

0000000080023aa2 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80023aa2:	7179                	addi	sp,sp,-48
    80023aa4:	f406                	sd	ra,40(sp)
    80023aa6:	f022                	sd	s0,32(sp)
    80023aa8:	ec26                	sd	s1,24(sp)
    80023aaa:	e84a                	sd	s2,16(sp)
    80023aac:	1800                	addi	s0,sp,48
    80023aae:	892e                	mv	s2,a1
    80023ab0:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80023ab2:	fdc40593          	addi	a1,s0,-36
    80023ab6:	fffff097          	auipc	ra,0xfffff
    80023aba:	d32080e7          	jalr	-718(ra) # 800227e8 <argint>
    80023abe:	04054063          	bltz	a0,80023afe <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80023ac2:	fdc42703          	lw	a4,-36(s0)
    80023ac6:	47bd                	li	a5,15
    80023ac8:	02e7ed63          	bltu	a5,a4,80023b02 <argfd+0x60>
    80023acc:	ffffe097          	auipc	ra,0xffffe
    80023ad0:	b0a080e7          	jalr	-1270(ra) # 800215d6 <myproc>
    80023ad4:	fdc42703          	lw	a4,-36(s0)
    80023ad8:	01a70793          	addi	a5,a4,26
    80023adc:	078e                	slli	a5,a5,0x3
    80023ade:	953e                	add	a0,a0,a5
    80023ae0:	611c                	ld	a5,0(a0)
    80023ae2:	c395                	beqz	a5,80023b06 <argfd+0x64>
    return -1;
  if(pfd)
    80023ae4:	00090463          	beqz	s2,80023aec <argfd+0x4a>
    *pfd = fd;
    80023ae8:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80023aec:	4501                	li	a0,0
  if(pf)
    80023aee:	c091                	beqz	s1,80023af2 <argfd+0x50>
    *pf = f;
    80023af0:	e09c                	sd	a5,0(s1)
}
    80023af2:	70a2                	ld	ra,40(sp)
    80023af4:	7402                	ld	s0,32(sp)
    80023af6:	64e2                	ld	s1,24(sp)
    80023af8:	6942                	ld	s2,16(sp)
    80023afa:	6145                	addi	sp,sp,48
    80023afc:	8082                	ret
    return -1;
    80023afe:	557d                	li	a0,-1
    80023b00:	bfcd                	j	80023af2 <argfd+0x50>
    return -1;
    80023b02:	557d                	li	a0,-1
    80023b04:	b7fd                	j	80023af2 <argfd+0x50>
    80023b06:	557d                	li	a0,-1
    80023b08:	b7ed                	j	80023af2 <argfd+0x50>

0000000080023b0a <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80023b0a:	1101                	addi	sp,sp,-32
    80023b0c:	ec06                	sd	ra,24(sp)
    80023b0e:	e822                	sd	s0,16(sp)
    80023b10:	e426                	sd	s1,8(sp)
    80023b12:	1000                	addi	s0,sp,32
    80023b14:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80023b16:	ffffe097          	auipc	ra,0xffffe
    80023b1a:	ac0080e7          	jalr	-1344(ra) # 800215d6 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(p->ofile[fd] == 0){
    80023b1e:	697c                	ld	a5,208(a0)
    80023b20:	c395                	beqz	a5,80023b44 <fdalloc+0x3a>
    80023b22:	0d850713          	addi	a4,a0,216
  for(fd = 0; fd < NOFILE; fd++){
    80023b26:	4785                	li	a5,1
    80023b28:	4641                	li	a2,16
    if(p->ofile[fd] == 0){
    80023b2a:	6314                	ld	a3,0(a4)
    80023b2c:	ce89                	beqz	a3,80023b46 <fdalloc+0x3c>
  for(fd = 0; fd < NOFILE; fd++){
    80023b2e:	2785                	addiw	a5,a5,1
    80023b30:	0721                	addi	a4,a4,8
    80023b32:	fec79ce3          	bne	a5,a2,80023b2a <fdalloc+0x20>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80023b36:	57fd                	li	a5,-1
}
    80023b38:	853e                	mv	a0,a5
    80023b3a:	60e2                	ld	ra,24(sp)
    80023b3c:	6442                	ld	s0,16(sp)
    80023b3e:	64a2                	ld	s1,8(sp)
    80023b40:	6105                	addi	sp,sp,32
    80023b42:	8082                	ret
  for(fd = 0; fd < NOFILE; fd++){
    80023b44:	4781                	li	a5,0
      p->ofile[fd] = f;
    80023b46:	01a78713          	addi	a4,a5,26
    80023b4a:	070e                	slli	a4,a4,0x3
    80023b4c:	953a                	add	a0,a0,a4
    80023b4e:	e104                	sd	s1,0(a0)
      return fd;
    80023b50:	b7e5                	j	80023b38 <fdalloc+0x2e>

0000000080023b52 <create>:
//   return 1;
// }

static struct dirent*
create(char *path, short type)
{
    80023b52:	712d                	addi	sp,sp,-288
    80023b54:	ee06                	sd	ra,280(sp)
    80023b56:	ea22                	sd	s0,272(sp)
    80023b58:	e626                	sd	s1,264(sp)
    80023b5a:	e24a                	sd	s2,256(sp)
    80023b5c:	1200                	addi	s0,sp,288
    80023b5e:	892e                	mv	s2,a1
  struct dirent *ep, *dp;
  char name[FAT32_MAX_FILENAME];

  if((dp = enameparent(path, name)) == 0)
    80023b60:	ee040593          	addi	a1,s0,-288
    80023b64:	00002097          	auipc	ra,0x2
    80023b68:	5d6080e7          	jalr	1494(ra) # 8002613a <enameparent>
    80023b6c:	84aa                	mv	s1,a0
    80023b6e:	c539                	beqz	a0,80023bbc <create+0x6a>
    return 0;

  elock(dp);
    80023b70:	00002097          	auipc	ra,0x2
    80023b74:	c1a080e7          	jalr	-998(ra) # 8002578a <elock>
  if((ep = ealloc(dp, name, type == T_DIR)) == 0)
    80023b78:	fff90613          	addi	a2,s2,-1
    80023b7c:	00163613          	seqz	a2,a2
    80023b80:	ee040593          	addi	a1,s0,-288
    80023b84:	8526                	mv	a0,s1
    80023b86:	00002097          	auipc	ra,0x2
    80023b8a:	12e080e7          	jalr	302(ra) # 80025cb4 <ealloc>
    80023b8e:	892a                	mv	s2,a0
    80023b90:	cd19                	beqz	a0,80023bae <create+0x5c>
    return 0;

  elock(ep);
    80023b92:	00002097          	auipc	ra,0x2
    80023b96:	bf8080e7          	jalr	-1032(ra) # 8002578a <elock>

  // what needs to do ?

  eunlock(dp);
    80023b9a:	8526                	mv	a0,s1
    80023b9c:	00002097          	auipc	ra,0x2
    80023ba0:	c24080e7          	jalr	-988(ra) # 800257c0 <eunlock>
  eput(dp);
    80023ba4:	8526                	mv	a0,s1
    80023ba6:	00002097          	auipc	ra,0x2
    80023baa:	c68080e7          	jalr	-920(ra) # 8002580e <eput>

  return ep;
}
    80023bae:	854a                	mv	a0,s2
    80023bb0:	60f2                	ld	ra,280(sp)
    80023bb2:	6452                	ld	s0,272(sp)
    80023bb4:	64b2                	ld	s1,264(sp)
    80023bb6:	6912                	ld	s2,256(sp)
    80023bb8:	6115                	addi	sp,sp,288
    80023bba:	8082                	ret
    return 0;
    80023bbc:	892a                	mv	s2,a0
    80023bbe:	bfc5                	j	80023bae <create+0x5c>

0000000080023bc0 <sys_dup>:
{
    80023bc0:	7179                	addi	sp,sp,-48
    80023bc2:	f406                	sd	ra,40(sp)
    80023bc4:	f022                	sd	s0,32(sp)
    80023bc6:	ec26                	sd	s1,24(sp)
    80023bc8:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80023bca:	fd840613          	addi	a2,s0,-40
    80023bce:	4581                	li	a1,0
    80023bd0:	4501                	li	a0,0
    80023bd2:	00000097          	auipc	ra,0x0
    80023bd6:	ed0080e7          	jalr	-304(ra) # 80023aa2 <argfd>
    return -1;
    80023bda:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80023bdc:	02054363          	bltz	a0,80023c02 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80023be0:	fd843503          	ld	a0,-40(s0)
    80023be4:	00000097          	auipc	ra,0x0
    80023be8:	f26080e7          	jalr	-218(ra) # 80023b0a <fdalloc>
    80023bec:	84aa                	mv	s1,a0
    return -1;
    80023bee:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80023bf0:	00054963          	bltz	a0,80023c02 <sys_dup+0x42>
  filedup(f);
    80023bf4:	fd843503          	ld	a0,-40(s0)
    80023bf8:	fffff097          	auipc	ra,0xfffff
    80023bfc:	3be080e7          	jalr	958(ra) # 80022fb6 <filedup>
  return fd;
    80023c00:	87a6                	mv	a5,s1
}
    80023c02:	853e                	mv	a0,a5
    80023c04:	70a2                	ld	ra,40(sp)
    80023c06:	7402                	ld	s0,32(sp)
    80023c08:	64e2                	ld	s1,24(sp)
    80023c0a:	6145                	addi	sp,sp,48
    80023c0c:	8082                	ret

0000000080023c0e <sys_read>:
{
    80023c0e:	7179                	addi	sp,sp,-48
    80023c10:	f406                	sd	ra,40(sp)
    80023c12:	f022                	sd	s0,32(sp)
    80023c14:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80023c16:	fe840613          	addi	a2,s0,-24
    80023c1a:	4581                	li	a1,0
    80023c1c:	4501                	li	a0,0
    80023c1e:	00000097          	auipc	ra,0x0
    80023c22:	e84080e7          	jalr	-380(ra) # 80023aa2 <argfd>
    return -1;
    80023c26:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80023c28:	04054163          	bltz	a0,80023c6a <sys_read+0x5c>
    80023c2c:	fe440593          	addi	a1,s0,-28
    80023c30:	4509                	li	a0,2
    80023c32:	fffff097          	auipc	ra,0xfffff
    80023c36:	bb6080e7          	jalr	-1098(ra) # 800227e8 <argint>
    return -1;
    80023c3a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80023c3c:	02054763          	bltz	a0,80023c6a <sys_read+0x5c>
    80023c40:	fd840593          	addi	a1,s0,-40
    80023c44:	4505                	li	a0,1
    80023c46:	fffff097          	auipc	ra,0xfffff
    80023c4a:	bc4080e7          	jalr	-1084(ra) # 8002280a <argaddr>
    return -1;
    80023c4e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80023c50:	00054d63          	bltz	a0,80023c6a <sys_read+0x5c>
  return fileread(f, p, n);
    80023c54:	fe442603          	lw	a2,-28(s0)
    80023c58:	fd843583          	ld	a1,-40(s0)
    80023c5c:	fe843503          	ld	a0,-24(s0)
    80023c60:	fffff097          	auipc	ra,0xfffff
    80023c64:	4d0080e7          	jalr	1232(ra) # 80023130 <fileread>
    80023c68:	87aa                	mv	a5,a0
}
    80023c6a:	853e                	mv	a0,a5
    80023c6c:	70a2                	ld	ra,40(sp)
    80023c6e:	7402                	ld	s0,32(sp)
    80023c70:	6145                	addi	sp,sp,48
    80023c72:	8082                	ret

0000000080023c74 <sys_write>:
{
    80023c74:	7179                	addi	sp,sp,-48
    80023c76:	f406                	sd	ra,40(sp)
    80023c78:	f022                	sd	s0,32(sp)
    80023c7a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80023c7c:	fe840613          	addi	a2,s0,-24
    80023c80:	4581                	li	a1,0
    80023c82:	4501                	li	a0,0
    80023c84:	00000097          	auipc	ra,0x0
    80023c88:	e1e080e7          	jalr	-482(ra) # 80023aa2 <argfd>
    return -1;
    80023c8c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80023c8e:	04054163          	bltz	a0,80023cd0 <sys_write+0x5c>
    80023c92:	fe440593          	addi	a1,s0,-28
    80023c96:	4509                	li	a0,2
    80023c98:	fffff097          	auipc	ra,0xfffff
    80023c9c:	b50080e7          	jalr	-1200(ra) # 800227e8 <argint>
    return -1;
    80023ca0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80023ca2:	02054763          	bltz	a0,80023cd0 <sys_write+0x5c>
    80023ca6:	fd840593          	addi	a1,s0,-40
    80023caa:	4505                	li	a0,1
    80023cac:	fffff097          	auipc	ra,0xfffff
    80023cb0:	b5e080e7          	jalr	-1186(ra) # 8002280a <argaddr>
    return -1;
    80023cb4:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80023cb6:	00054d63          	bltz	a0,80023cd0 <sys_write+0x5c>
  return filewrite(f, p, n);
    80023cba:	fe442603          	lw	a2,-28(s0)
    80023cbe:	fd843583          	ld	a1,-40(s0)
    80023cc2:	fe843503          	ld	a0,-24(s0)
    80023cc6:	fffff097          	auipc	ra,0xfffff
    80023cca:	52c080e7          	jalr	1324(ra) # 800231f2 <filewrite>
    80023cce:	87aa                	mv	a5,a0
}
    80023cd0:	853e                	mv	a0,a5
    80023cd2:	70a2                	ld	ra,40(sp)
    80023cd4:	7402                	ld	s0,32(sp)
    80023cd6:	6145                	addi	sp,sp,48
    80023cd8:	8082                	ret

0000000080023cda <sys_close>:
{
    80023cda:	1101                	addi	sp,sp,-32
    80023cdc:	ec06                	sd	ra,24(sp)
    80023cde:	e822                	sd	s0,16(sp)
    80023ce0:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80023ce2:	fe040613          	addi	a2,s0,-32
    80023ce6:	fec40593          	addi	a1,s0,-20
    80023cea:	4501                	li	a0,0
    80023cec:	00000097          	auipc	ra,0x0
    80023cf0:	db6080e7          	jalr	-586(ra) # 80023aa2 <argfd>
    return -1;
    80023cf4:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80023cf6:	02054463          	bltz	a0,80023d1e <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80023cfa:	ffffe097          	auipc	ra,0xffffe
    80023cfe:	8dc080e7          	jalr	-1828(ra) # 800215d6 <myproc>
    80023d02:	fec42783          	lw	a5,-20(s0)
    80023d06:	07e9                	addi	a5,a5,26
    80023d08:	078e                	slli	a5,a5,0x3
    80023d0a:	953e                	add	a0,a0,a5
    80023d0c:	00053023          	sd	zero,0(a0)
  fileclose(f);
    80023d10:	fe043503          	ld	a0,-32(s0)
    80023d14:	fffff097          	auipc	ra,0xfffff
    80023d18:	2f4080e7          	jalr	756(ra) # 80023008 <fileclose>
  return 0;
    80023d1c:	4781                	li	a5,0
}
    80023d1e:	853e                	mv	a0,a5
    80023d20:	60e2                	ld	ra,24(sp)
    80023d22:	6442                	ld	s0,16(sp)
    80023d24:	6105                	addi	sp,sp,32
    80023d26:	8082                	ret

0000000080023d28 <sys_fstat>:
{
    80023d28:	1101                	addi	sp,sp,-32
    80023d2a:	ec06                	sd	ra,24(sp)
    80023d2c:	e822                	sd	s0,16(sp)
    80023d2e:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80023d30:	fe840613          	addi	a2,s0,-24
    80023d34:	4581                	li	a1,0
    80023d36:	4501                	li	a0,0
    80023d38:	00000097          	auipc	ra,0x0
    80023d3c:	d6a080e7          	jalr	-662(ra) # 80023aa2 <argfd>
    return -1;
    80023d40:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80023d42:	02054563          	bltz	a0,80023d6c <sys_fstat+0x44>
    80023d46:	fe040593          	addi	a1,s0,-32
    80023d4a:	4505                	li	a0,1
    80023d4c:	fffff097          	auipc	ra,0xfffff
    80023d50:	abe080e7          	jalr	-1346(ra) # 8002280a <argaddr>
    return -1;
    80023d54:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80023d56:	00054b63          	bltz	a0,80023d6c <sys_fstat+0x44>
  return filestat(f, st);
    80023d5a:	fe043583          	ld	a1,-32(s0)
    80023d5e:	fe843503          	ld	a0,-24(s0)
    80023d62:	fffff097          	auipc	ra,0xfffff
    80023d66:	35c080e7          	jalr	860(ra) # 800230be <filestat>
    80023d6a:	87aa                	mv	a5,a0
}
    80023d6c:	853e                	mv	a0,a5
    80023d6e:	60e2                	ld	ra,24(sp)
    80023d70:	6442                	ld	s0,16(sp)
    80023d72:	6105                	addi	sp,sp,32
    80023d74:	8082                	ret

0000000080023d76 <sys_open>:

uint64
sys_open(void)
{
    80023d76:	7129                	addi	sp,sp,-320
    80023d78:	fe06                	sd	ra,312(sp)
    80023d7a:	fa22                	sd	s0,304(sp)
    80023d7c:	f626                	sd	s1,296(sp)
    80023d7e:	f24a                	sd	s2,288(sp)
    80023d80:	ee4e                	sd	s3,280(sp)
    80023d82:	0280                	addi	s0,sp,320
  char path[FAT32_MAX_PATH];
  int fd, omode;
  struct file *f;
  struct dirent *ep;

  if(argstr(0, path, MAXPATH) < 0 || argint(1, &omode) < 0)
    80023d84:	08000613          	li	a2,128
    80023d88:	ec840593          	addi	a1,s0,-312
    80023d8c:	4501                	li	a0,0
    80023d8e:	fffff097          	auipc	ra,0xfffff
    80023d92:	a9e080e7          	jalr	-1378(ra) # 8002282c <argstr>
    return -1;
    80023d96:	54fd                	li	s1,-1
  if(argstr(0, path, MAXPATH) < 0 || argint(1, &omode) < 0)
    80023d98:	08054263          	bltz	a0,80023e1c <sys_open+0xa6>
    80023d9c:	ec440593          	addi	a1,s0,-316
    80023da0:	4505                	li	a0,1
    80023da2:	fffff097          	auipc	ra,0xfffff
    80023da6:	a46080e7          	jalr	-1466(ra) # 800227e8 <argint>
    80023daa:	0c054663          	bltz	a0,80023e76 <sys_open+0x100>

  if(omode & O_CREATE){
    80023dae:	ec442783          	lw	a5,-316(s0)
    80023db2:	2007f793          	andi	a5,a5,512
    80023db6:	cbbd                	beqz	a5,80023e2c <sys_open+0xb6>
    ep = create(path, T_FILE);
    80023db8:	4589                	li	a1,2
    80023dba:	ec840513          	addi	a0,s0,-312
    80023dbe:	00000097          	auipc	ra,0x0
    80023dc2:	d94080e7          	jalr	-620(ra) # 80023b52 <create>
    80023dc6:	89aa                	mv	s3,a0
    if(ep == 0){
    80023dc8:	c94d                	beqz	a0,80023e7a <sys_open+0x104>
  //   eunlock(ep);
  //   eput(ep);
  //   return -1;
  // }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80023dca:	fffff097          	auipc	ra,0xfffff
    80023dce:	16e080e7          	jalr	366(ra) # 80022f38 <filealloc>
    80023dd2:	892a                	mv	s2,a0
    80023dd4:	cd45                	beqz	a0,80023e8c <sys_open+0x116>
    80023dd6:	00000097          	auipc	ra,0x0
    80023dda:	d34080e7          	jalr	-716(ra) # 80023b0a <fdalloc>
    80023dde:	84aa                	mv	s1,a0
    80023de0:	0a054163          	bltz	a0,80023e82 <sys_open+0x10c>
    eunlock(ep);
    eput(ep);
    return -1;
  }

  f->type = FD_ENTRY;
    80023de4:	4789                	li	a5,2
    80023de6:	00f92023          	sw	a5,0(s2)
  f->off = 0;
    80023dea:	02092023          	sw	zero,32(s2)
  f->ep = ep;
    80023dee:	01393c23          	sd	s3,24(s2)
  f->readable = !(omode & O_WRONLY);
    80023df2:	ec442783          	lw	a5,-316(s0)
    80023df6:	0017c713          	xori	a4,a5,1
    80023dfa:	8b05                	andi	a4,a4,1
    80023dfc:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80023e00:	0037f713          	andi	a4,a5,3
    80023e04:	00e03733          	snez	a4,a4
    80023e08:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC)){
    80023e0c:	4007f793          	andi	a5,a5,1024
    80023e10:	efa9                	bnez	a5,80023e6a <sys_open+0xf4>
    etrunc(ep);
  }

  eunlock(ep);
    80023e12:	854e                	mv	a0,s3
    80023e14:	00002097          	auipc	ra,0x2
    80023e18:	9ac080e7          	jalr	-1620(ra) # 800257c0 <eunlock>

  return fd;
}
    80023e1c:	8526                	mv	a0,s1
    80023e1e:	70f2                	ld	ra,312(sp)
    80023e20:	7452                	ld	s0,304(sp)
    80023e22:	74b2                	ld	s1,296(sp)
    80023e24:	7912                	ld	s2,288(sp)
    80023e26:	69f2                	ld	s3,280(sp)
    80023e28:	6131                	addi	sp,sp,320
    80023e2a:	8082                	ret
    if((ep = ename(path)) == 0){
    80023e2c:	ec840513          	addi	a0,s0,-312
    80023e30:	00002097          	auipc	ra,0x2
    80023e34:	2d2080e7          	jalr	722(ra) # 80026102 <ename>
    80023e38:	89aa                	mv	s3,a0
    80023e3a:	c131                	beqz	a0,80023e7e <sys_open+0x108>
    elock(ep);
    80023e3c:	00002097          	auipc	ra,0x2
    80023e40:	94e080e7          	jalr	-1714(ra) # 8002578a <elock>
    if((ep->attribute & ATTR_DIRECTORY) && omode != O_RDONLY){
    80023e44:	1009c783          	lbu	a5,256(s3)
    80023e48:	8bc1                	andi	a5,a5,16
    80023e4a:	d3c1                	beqz	a5,80023dca <sys_open+0x54>
    80023e4c:	ec442783          	lw	a5,-316(s0)
    80023e50:	dfad                	beqz	a5,80023dca <sys_open+0x54>
      eunlock(ep);
    80023e52:	854e                	mv	a0,s3
    80023e54:	00002097          	auipc	ra,0x2
    80023e58:	96c080e7          	jalr	-1684(ra) # 800257c0 <eunlock>
      eput(ep);
    80023e5c:	854e                	mv	a0,s3
    80023e5e:	00002097          	auipc	ra,0x2
    80023e62:	9b0080e7          	jalr	-1616(ra) # 8002580e <eput>
      return -1;
    80023e66:	54fd                	li	s1,-1
    80023e68:	bf55                	j	80023e1c <sys_open+0xa6>
    etrunc(ep);
    80023e6a:	854e                	mv	a0,s3
    80023e6c:	00002097          	auipc	ra,0x2
    80023e70:	80e080e7          	jalr	-2034(ra) # 8002567a <etrunc>
    80023e74:	bf79                	j	80023e12 <sys_open+0x9c>
    return -1;
    80023e76:	54fd                	li	s1,-1
    80023e78:	b755                	j	80023e1c <sys_open+0xa6>
      return -1;
    80023e7a:	54fd                	li	s1,-1
    80023e7c:	b745                	j	80023e1c <sys_open+0xa6>
      return -1;
    80023e7e:	54fd                	li	s1,-1
    80023e80:	bf71                	j	80023e1c <sys_open+0xa6>
      fileclose(f);
    80023e82:	854a                	mv	a0,s2
    80023e84:	fffff097          	auipc	ra,0xfffff
    80023e88:	184080e7          	jalr	388(ra) # 80023008 <fileclose>
    eunlock(ep);
    80023e8c:	854e                	mv	a0,s3
    80023e8e:	00002097          	auipc	ra,0x2
    80023e92:	932080e7          	jalr	-1742(ra) # 800257c0 <eunlock>
    eput(ep);
    80023e96:	854e                	mv	a0,s3
    80023e98:	00002097          	auipc	ra,0x2
    80023e9c:	976080e7          	jalr	-1674(ra) # 8002580e <eput>
    return -1;
    80023ea0:	54fd                	li	s1,-1
    80023ea2:	bfad                	j	80023e1c <sys_open+0xa6>

0000000080023ea4 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80023ea4:	7169                	addi	sp,sp,-304
    80023ea6:	f606                	sd	ra,296(sp)
    80023ea8:	f222                	sd	s0,288(sp)
    80023eaa:	ee26                	sd	s1,280(sp)
    80023eac:	1a00                	addi	s0,sp,304
  char path[FAT32_MAX_PATH];
  struct dirent *ep;

  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR)) == 0){
    80023eae:	10400613          	li	a2,260
    80023eb2:	ed840593          	addi	a1,s0,-296
    80023eb6:	4501                	li	a0,0
    80023eb8:	fffff097          	auipc	ra,0xfffff
    80023ebc:	974080e7          	jalr	-1676(ra) # 8002282c <argstr>
    return -1;
    80023ec0:	57fd                	li	a5,-1
  if(argstr(0, path, FAT32_MAX_PATH) < 0 || (ep = create(path, T_DIR)) == 0){
    80023ec2:	02054563          	bltz	a0,80023eec <sys_mkdir+0x48>
    80023ec6:	4585                	li	a1,1
    80023ec8:	ed840513          	addi	a0,s0,-296
    80023ecc:	00000097          	auipc	ra,0x0
    80023ed0:	c86080e7          	jalr	-890(ra) # 80023b52 <create>
    80023ed4:	84aa                	mv	s1,a0
    80023ed6:	c10d                	beqz	a0,80023ef8 <sys_mkdir+0x54>
  }
  eunlock(ep);
    80023ed8:	00002097          	auipc	ra,0x2
    80023edc:	8e8080e7          	jalr	-1816(ra) # 800257c0 <eunlock>
  eput(ep);
    80023ee0:	8526                	mv	a0,s1
    80023ee2:	00002097          	auipc	ra,0x2
    80023ee6:	92c080e7          	jalr	-1748(ra) # 8002580e <eput>
  return 0;
    80023eea:	4781                	li	a5,0
}
    80023eec:	853e                	mv	a0,a5
    80023eee:	70b2                	ld	ra,296(sp)
    80023ef0:	7412                	ld	s0,288(sp)
    80023ef2:	64f2                	ld	s1,280(sp)
    80023ef4:	6155                	addi	sp,sp,304
    80023ef6:	8082                	ret
    return -1;
    80023ef8:	57fd                	li	a5,-1
    80023efa:	bfcd                	j	80023eec <sys_mkdir+0x48>

0000000080023efc <sys_chdir>:
//   return 0;
// }

uint64
sys_chdir(void)
{
    80023efc:	7135                	addi	sp,sp,-160
    80023efe:	ed06                	sd	ra,152(sp)
    80023f00:	e922                	sd	s0,144(sp)
    80023f02:	e526                	sd	s1,136(sp)
    80023f04:	e14a                	sd	s2,128(sp)
    80023f06:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct dirent *ep;
  struct proc *p = myproc();
    80023f08:	ffffd097          	auipc	ra,0xffffd
    80023f0c:	6ce080e7          	jalr	1742(ra) # 800215d6 <myproc>
    80023f10:	892a                	mv	s2,a0
  
  if(argstr(0, path, MAXPATH) < 0 || (ep = ename(path)) == 0){
    80023f12:	08000613          	li	a2,128
    80023f16:	f6040593          	addi	a1,s0,-160
    80023f1a:	4501                	li	a0,0
    80023f1c:	fffff097          	auipc	ra,0xfffff
    80023f20:	910080e7          	jalr	-1776(ra) # 8002282c <argstr>
    return -1;
    80023f24:	57fd                	li	a5,-1
  if(argstr(0, path, MAXPATH) < 0 || (ep = ename(path)) == 0){
    80023f26:	04054063          	bltz	a0,80023f66 <sys_chdir+0x6a>
    80023f2a:	f6040513          	addi	a0,s0,-160
    80023f2e:	00002097          	auipc	ra,0x2
    80023f32:	1d4080e7          	jalr	468(ra) # 80026102 <ename>
    80023f36:	84aa                	mv	s1,a0
    80023f38:	c931                	beqz	a0,80023f8c <sys_chdir+0x90>
  }
  elock(ep);
    80023f3a:	00002097          	auipc	ra,0x2
    80023f3e:	850080e7          	jalr	-1968(ra) # 8002578a <elock>
  if(!(ep->attribute & ATTR_DIRECTORY)){
    80023f42:	1004c783          	lbu	a5,256(s1)
    80023f46:	8bc1                	andi	a5,a5,16
    80023f48:	c795                	beqz	a5,80023f74 <sys_chdir+0x78>
    eunlock(ep);
    eput(ep);
    return -1;
  }
  eunlock(ep);
    80023f4a:	8526                	mv	a0,s1
    80023f4c:	00002097          	auipc	ra,0x2
    80023f50:	874080e7          	jalr	-1932(ra) # 800257c0 <eunlock>
  eput(p->cwd);
    80023f54:	15093503          	ld	a0,336(s2)
    80023f58:	00002097          	auipc	ra,0x2
    80023f5c:	8b6080e7          	jalr	-1866(ra) # 8002580e <eput>
  p->cwd = ep;
    80023f60:	14993823          	sd	s1,336(s2)
  return 0;
    80023f64:	4781                	li	a5,0
}
    80023f66:	853e                	mv	a0,a5
    80023f68:	60ea                	ld	ra,152(sp)
    80023f6a:	644a                	ld	s0,144(sp)
    80023f6c:	64aa                	ld	s1,136(sp)
    80023f6e:	690a                	ld	s2,128(sp)
    80023f70:	610d                	addi	sp,sp,160
    80023f72:	8082                	ret
    eunlock(ep);
    80023f74:	8526                	mv	a0,s1
    80023f76:	00002097          	auipc	ra,0x2
    80023f7a:	84a080e7          	jalr	-1974(ra) # 800257c0 <eunlock>
    eput(ep);
    80023f7e:	8526                	mv	a0,s1
    80023f80:	00002097          	auipc	ra,0x2
    80023f84:	88e080e7          	jalr	-1906(ra) # 8002580e <eput>
    return -1;
    80023f88:	57fd                	li	a5,-1
    80023f8a:	bff1                	j	80023f66 <sys_chdir+0x6a>
    return -1;
    80023f8c:	57fd                	li	a5,-1
    80023f8e:	bfe1                	j	80023f66 <sys_chdir+0x6a>

0000000080023f90 <sys_exec>:

uint64
sys_exec(void)
{
    80023f90:	7145                	addi	sp,sp,-464
    80023f92:	e786                	sd	ra,456(sp)
    80023f94:	e3a2                	sd	s0,448(sp)
    80023f96:	ff26                	sd	s1,440(sp)
    80023f98:	fb4a                	sd	s2,432(sp)
    80023f9a:	f74e                	sd	s3,424(sp)
    80023f9c:	f352                	sd	s4,416(sp)
    80023f9e:	ef56                	sd	s5,408(sp)
    80023fa0:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80023fa2:	08000613          	li	a2,128
    80023fa6:	f4040593          	addi	a1,s0,-192
    80023faa:	4501                	li	a0,0
    80023fac:	fffff097          	auipc	ra,0xfffff
    80023fb0:	880080e7          	jalr	-1920(ra) # 8002282c <argstr>
    return -1;
    80023fb4:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80023fb6:	0e054c63          	bltz	a0,800240ae <sys_exec+0x11e>
    80023fba:	e3840593          	addi	a1,s0,-456
    80023fbe:	4505                	li	a0,1
    80023fc0:	fffff097          	auipc	ra,0xfffff
    80023fc4:	84a080e7          	jalr	-1974(ra) # 8002280a <argaddr>
    80023fc8:	0e054363          	bltz	a0,800240ae <sys_exec+0x11e>
  }
  memset(argv, 0, sizeof(argv));
    80023fcc:	e4040913          	addi	s2,s0,-448
    80023fd0:	10000613          	li	a2,256
    80023fd4:	4581                	li	a1,0
    80023fd6:	854a                	mv	a0,s2
    80023fd8:	ffffc097          	auipc	ra,0xffffc
    80023fdc:	660080e7          	jalr	1632(ra) # 80020638 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80023fe0:	89ca                	mv	s3,s2
  memset(argv, 0, sizeof(argv));
    80023fe2:	4481                	li	s1,0
    if(i >= NELEM(argv)){
    80023fe4:	02000a93          	li	s5,32
    80023fe8:	00048a1b          	sext.w	s4,s1
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80023fec:	00349513          	slli	a0,s1,0x3
    80023ff0:	e3040593          	addi	a1,s0,-464
    80023ff4:	e3843783          	ld	a5,-456(s0)
    80023ff8:	953e                	add	a0,a0,a5
    80023ffa:	ffffe097          	auipc	ra,0xffffe
    80023ffe:	754080e7          	jalr	1876(ra) # 8002274e <fetchaddr>
    80024002:	02054a63          	bltz	a0,80024036 <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    80024006:	e3043783          	ld	a5,-464(s0)
    8002400a:	cfa9                	beqz	a5,80024064 <sys_exec+0xd4>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    8002400c:	ffffc097          	auipc	ra,0xffffc
    80024010:	440080e7          	jalr	1088(ra) # 8002044c <kalloc>
    80024014:	00a93023          	sd	a0,0(s2)
    if(argv[i] == 0)
    80024018:	cd19                	beqz	a0,80024036 <sys_exec+0xa6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8002401a:	6605                	lui	a2,0x1
    8002401c:	85aa                	mv	a1,a0
    8002401e:	e3043503          	ld	a0,-464(s0)
    80024022:	ffffe097          	auipc	ra,0xffffe
    80024026:	77e080e7          	jalr	1918(ra) # 800227a0 <fetchstr>
    8002402a:	00054663          	bltz	a0,80024036 <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    8002402e:	0485                	addi	s1,s1,1
    80024030:	0921                	addi	s2,s2,8
    80024032:	fb549be3          	bne	s1,s5,80023fe8 <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80024036:	e4043503          	ld	a0,-448(s0)
    kfree(argv[i]);
  return -1;
    8002403a:	597d                	li	s2,-1
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002403c:	c92d                	beqz	a0,800240ae <sys_exec+0x11e>
    kfree(argv[i]);
    8002403e:	ffffc097          	auipc	ra,0xffffc
    80024042:	2fc080e7          	jalr	764(ra) # 8002033a <kfree>
    80024046:	e4840493          	addi	s1,s0,-440
    8002404a:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002404e:	6088                	ld	a0,0(s1)
    80024050:	cd31                	beqz	a0,800240ac <sys_exec+0x11c>
    kfree(argv[i]);
    80024052:	ffffc097          	auipc	ra,0xffffc
    80024056:	2e8080e7          	jalr	744(ra) # 8002033a <kfree>
    8002405a:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8002405c:	ff3499e3          	bne	s1,s3,8002404e <sys_exec+0xbe>
  return -1;
    80024060:	597d                	li	s2,-1
    80024062:	a0b1                	j	800240ae <sys_exec+0x11e>
      argv[i] = 0;
    80024064:	0a0e                	slli	s4,s4,0x3
    80024066:	fc040793          	addi	a5,s0,-64
    8002406a:	9a3e                	add	s4,s4,a5
    8002406c:	e80a3023          	sd	zero,-384(s4)
  int ret = exec(path, argv);
    80024070:	e4040593          	addi	a1,s0,-448
    80024074:	f4040513          	addi	a0,s0,-192
    80024078:	fffff097          	auipc	ra,0xfffff
    8002407c:	68e080e7          	jalr	1678(ra) # 80023706 <exec>
    80024080:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80024082:	e4043503          	ld	a0,-448(s0)
    80024086:	c505                	beqz	a0,800240ae <sys_exec+0x11e>
    kfree(argv[i]);
    80024088:	ffffc097          	auipc	ra,0xffffc
    8002408c:	2b2080e7          	jalr	690(ra) # 8002033a <kfree>
    80024090:	e4840493          	addi	s1,s0,-440
    80024094:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80024098:	6088                	ld	a0,0(s1)
    8002409a:	c911                	beqz	a0,800240ae <sys_exec+0x11e>
    kfree(argv[i]);
    8002409c:	ffffc097          	auipc	ra,0xffffc
    800240a0:	29e080e7          	jalr	670(ra) # 8002033a <kfree>
    800240a4:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800240a6:	ff3499e3          	bne	s1,s3,80024098 <sys_exec+0x108>
    800240aa:	a011                	j	800240ae <sys_exec+0x11e>
  return -1;
    800240ac:	597d                	li	s2,-1
}
    800240ae:	854a                	mv	a0,s2
    800240b0:	60be                	ld	ra,456(sp)
    800240b2:	641e                	ld	s0,448(sp)
    800240b4:	74fa                	ld	s1,440(sp)
    800240b6:	795a                	ld	s2,432(sp)
    800240b8:	79ba                	ld	s3,424(sp)
    800240ba:	7a1a                	ld	s4,416(sp)
    800240bc:	6afa                	ld	s5,408(sp)
    800240be:	6179                	addi	sp,sp,464
    800240c0:	8082                	ret

00000000800240c2 <sys_pipe>:

uint64
sys_pipe(void)
{
    800240c2:	7139                	addi	sp,sp,-64
    800240c4:	fc06                	sd	ra,56(sp)
    800240c6:	f822                	sd	s0,48(sp)
    800240c8:	f426                	sd	s1,40(sp)
    800240ca:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800240cc:	ffffd097          	auipc	ra,0xffffd
    800240d0:	50a080e7          	jalr	1290(ra) # 800215d6 <myproc>
    800240d4:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    800240d6:	fd840593          	addi	a1,s0,-40
    800240da:	4501                	li	a0,0
    800240dc:	ffffe097          	auipc	ra,0xffffe
    800240e0:	72e080e7          	jalr	1838(ra) # 8002280a <argaddr>
    return -1;
    800240e4:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    800240e6:	0c054f63          	bltz	a0,800241c4 <sys_pipe+0x102>
  if(pipealloc(&rf, &wf) < 0)
    800240ea:	fc840593          	addi	a1,s0,-56
    800240ee:	fd040513          	addi	a0,s0,-48
    800240f2:	fffff097          	auipc	ra,0xfffff
    800240f6:	29c080e7          	jalr	668(ra) # 8002338e <pipealloc>
    return -1;
    800240fa:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800240fc:	0c054463          	bltz	a0,800241c4 <sys_pipe+0x102>
  fd0 = -1;
    80024100:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80024104:	fd043503          	ld	a0,-48(s0)
    80024108:	00000097          	auipc	ra,0x0
    8002410c:	a02080e7          	jalr	-1534(ra) # 80023b0a <fdalloc>
    80024110:	fca42223          	sw	a0,-60(s0)
    80024114:	08054b63          	bltz	a0,800241aa <sys_pipe+0xe8>
    80024118:	fc843503          	ld	a0,-56(s0)
    8002411c:	00000097          	auipc	ra,0x0
    80024120:	9ee080e7          	jalr	-1554(ra) # 80023b0a <fdalloc>
    80024124:	fca42023          	sw	a0,-64(s0)
    80024128:	06054863          	bltz	a0,80024198 <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8002412c:	4691                	li	a3,4
    8002412e:	fc440613          	addi	a2,s0,-60
    80024132:	fd843583          	ld	a1,-40(s0)
    80024136:	68a8                	ld	a0,80(s1)
    80024138:	ffffd097          	auipc	ra,0xffffd
    8002413c:	068080e7          	jalr	104(ra) # 800211a0 <copyout>
    80024140:	02054063          	bltz	a0,80024160 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80024144:	4691                	li	a3,4
    80024146:	fc040613          	addi	a2,s0,-64
    8002414a:	fd843583          	ld	a1,-40(s0)
    8002414e:	0591                	addi	a1,a1,4
    80024150:	68a8                	ld	a0,80(s1)
    80024152:	ffffd097          	auipc	ra,0xffffd
    80024156:	04e080e7          	jalr	78(ra) # 800211a0 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    8002415a:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8002415c:	06055463          	bgez	a0,800241c4 <sys_pipe+0x102>
    p->ofile[fd0] = 0;
    80024160:	fc442783          	lw	a5,-60(s0)
    80024164:	07e9                	addi	a5,a5,26
    80024166:	078e                	slli	a5,a5,0x3
    80024168:	97a6                	add	a5,a5,s1
    8002416a:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    8002416e:	fc042783          	lw	a5,-64(s0)
    80024172:	07e9                	addi	a5,a5,26
    80024174:	078e                	slli	a5,a5,0x3
    80024176:	94be                	add	s1,s1,a5
    80024178:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    8002417c:	fd043503          	ld	a0,-48(s0)
    80024180:	fffff097          	auipc	ra,0xfffff
    80024184:	e88080e7          	jalr	-376(ra) # 80023008 <fileclose>
    fileclose(wf);
    80024188:	fc843503          	ld	a0,-56(s0)
    8002418c:	fffff097          	auipc	ra,0xfffff
    80024190:	e7c080e7          	jalr	-388(ra) # 80023008 <fileclose>
    return -1;
    80024194:	57fd                	li	a5,-1
    80024196:	a03d                	j	800241c4 <sys_pipe+0x102>
    if(fd0 >= 0)
    80024198:	fc442783          	lw	a5,-60(s0)
    8002419c:	0007c763          	bltz	a5,800241aa <sys_pipe+0xe8>
      p->ofile[fd0] = 0;
    800241a0:	07e9                	addi	a5,a5,26
    800241a2:	078e                	slli	a5,a5,0x3
    800241a4:	94be                	add	s1,s1,a5
    800241a6:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    800241aa:	fd043503          	ld	a0,-48(s0)
    800241ae:	fffff097          	auipc	ra,0xfffff
    800241b2:	e5a080e7          	jalr	-422(ra) # 80023008 <fileclose>
    fileclose(wf);
    800241b6:	fc843503          	ld	a0,-56(s0)
    800241ba:	fffff097          	auipc	ra,0xfffff
    800241be:	e4e080e7          	jalr	-434(ra) # 80023008 <fileclose>
    return -1;
    800241c2:	57fd                	li	a5,-1
}
    800241c4:	853e                	mv	a0,a5
    800241c6:	70e2                	ld	ra,56(sp)
    800241c8:	7442                	ld	s0,48(sp)
    800241ca:	74a2                	ld	s1,40(sp)
    800241cc:	6121                	addi	sp,sp,64
    800241ce:	8082                	ret

00000000800241d0 <sys_dev>:

// To open console device.
uint64
sys_dev(void)
{
    800241d0:	7179                	addi	sp,sp,-48
    800241d2:	f406                	sd	ra,40(sp)
    800241d4:	f022                	sd	s0,32(sp)
    800241d6:	ec26                	sd	s1,24(sp)
    800241d8:	1800                	addi	s0,sp,48
  int fd, omode;
  int major, minor;
  struct file *f;

  if(argint(0, &omode) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0){
    800241da:	fdc40593          	addi	a1,s0,-36
    800241de:	4501                	li	a0,0
    800241e0:	ffffe097          	auipc	ra,0xffffe
    800241e4:	608080e7          	jalr	1544(ra) # 800227e8 <argint>
    800241e8:	08054a63          	bltz	a0,8002427c <sys_dev+0xac>
    800241ec:	fd840593          	addi	a1,s0,-40
    800241f0:	4505                	li	a0,1
    800241f2:	ffffe097          	auipc	ra,0xffffe
    800241f6:	5f6080e7          	jalr	1526(ra) # 800227e8 <argint>
    800241fa:	08054763          	bltz	a0,80024288 <sys_dev+0xb8>
    800241fe:	fd440593          	addi	a1,s0,-44
    80024202:	4509                	li	a0,2
    80024204:	ffffe097          	auipc	ra,0xffffe
    80024208:	5e4080e7          	jalr	1508(ra) # 800227e8 <argint>
    8002420c:	08054063          	bltz	a0,8002428c <sys_dev+0xbc>
    return -1;
  }

  if(omode & O_CREATE){
    80024210:	fdc42783          	lw	a5,-36(s0)
    80024214:	2007f793          	andi	a5,a5,512
    80024218:	ebb1                	bnez	a5,8002426c <sys_dev+0x9c>
    panic("dev file on FAT");
  }

  if(major < 0 || major >= NDEV)
    8002421a:	fd842703          	lw	a4,-40(s0)
    8002421e:	47a5                	li	a5,9
    return -1;
    80024220:	557d                	li	a0,-1
  if(major < 0 || major >= NDEV)
    80024222:	04e7ee63          	bltu	a5,a4,8002427e <sys_dev+0xae>

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80024226:	fffff097          	auipc	ra,0xfffff
    8002422a:	d12080e7          	jalr	-750(ra) # 80022f38 <filealloc>
    8002422e:	84aa                	mv	s1,a0
    80024230:	c125                	beqz	a0,80024290 <sys_dev+0xc0>
    80024232:	00000097          	auipc	ra,0x0
    80024236:	8d8080e7          	jalr	-1832(ra) # 80023b0a <fdalloc>
    8002423a:	04054d63          	bltz	a0,80024294 <sys_dev+0xc4>
    if(f)
      fileclose(f);
    return -1;
  }

  f->type = FD_DEVICE;
    8002423e:	478d                	li	a5,3
    80024240:	c09c                	sw	a5,0(s1)
  f->off = 0;
    80024242:	0204a023          	sw	zero,32(s1)
  f->ep = 0;
    80024246:	0004bc23          	sd	zero,24(s1)
  f->major = major;
    8002424a:	fd842783          	lw	a5,-40(s0)
    8002424e:	02f49223          	sh	a5,36(s1)
  f->readable = !(omode & O_WRONLY);
    80024252:	fdc42783          	lw	a5,-36(s0)
    80024256:	0017c713          	xori	a4,a5,1
    8002425a:	8b05                	andi	a4,a4,1
    8002425c:	00e48423          	sb	a4,8(s1)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80024260:	8b8d                	andi	a5,a5,3
    80024262:	00f037b3          	snez	a5,a5
    80024266:	00f484a3          	sb	a5,9(s1)

  return fd;
    8002426a:	a811                	j	8002427e <sys_dev+0xae>
    panic("dev file on FAT");
    8002426c:	00005517          	auipc	a0,0x5
    80024270:	4cc50513          	addi	a0,a0,1228 # 80029738 <syscalls+0x1e8>
    80024274:	ffffc097          	auipc	ra,0xffffc
    80024278:	e62080e7          	jalr	-414(ra) # 800200d6 <panic>
    return -1;
    8002427c:	557d                	li	a0,-1
}
    8002427e:	70a2                	ld	ra,40(sp)
    80024280:	7402                	ld	s0,32(sp)
    80024282:	64e2                	ld	s1,24(sp)
    80024284:	6145                	addi	sp,sp,48
    80024286:	8082                	ret
    return -1;
    80024288:	557d                	li	a0,-1
    8002428a:	bfd5                	j	8002427e <sys_dev+0xae>
    8002428c:	557d                	li	a0,-1
    8002428e:	bfc5                	j	8002427e <sys_dev+0xae>
    return -1;
    80024290:	557d                	li	a0,-1
    80024292:	b7f5                	j	8002427e <sys_dev+0xae>
      fileclose(f);
    80024294:	8526                	mv	a0,s1
    80024296:	fffff097          	auipc	ra,0xfffff
    8002429a:	d72080e7          	jalr	-654(ra) # 80023008 <fileclose>
    return -1;
    8002429e:	557d                	li	a0,-1
    800242a0:	bff9                	j	8002427e <sys_dev+0xae>

00000000800242a2 <sys_dir>:

// To support ls command
uint64
sys_dir(void)
{
    800242a2:	1101                	addi	sp,sp,-32
    800242a4:	ec06                	sd	ra,24(sp)
    800242a6:	e822                	sd	s0,16(sp)
    800242a8:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    800242aa:	fe840613          	addi	a2,s0,-24
    800242ae:	4581                	li	a1,0
    800242b0:	4501                	li	a0,0
    800242b2:	fffff097          	auipc	ra,0xfffff
    800242b6:	7f0080e7          	jalr	2032(ra) # 80023aa2 <argfd>
    return -1;
    800242ba:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    800242bc:	02054563          	bltz	a0,800242e6 <sys_dir+0x44>
    800242c0:	fe040593          	addi	a1,s0,-32
    800242c4:	4505                	li	a0,1
    800242c6:	ffffe097          	auipc	ra,0xffffe
    800242ca:	544080e7          	jalr	1348(ra) # 8002280a <argaddr>
    return -1;
    800242ce:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &p) < 0)
    800242d0:	00054b63          	bltz	a0,800242e6 <sys_dir+0x44>
  return dirnext(f, p);
    800242d4:	fe043583          	ld	a1,-32(s0)
    800242d8:	fe843503          	ld	a0,-24(s0)
    800242dc:	fffff097          	auipc	ra,0xfffff
    800242e0:	fe8080e7          	jalr	-24(ra) # 800232c4 <dirnext>
    800242e4:	87aa                	mv	a5,a0
}
    800242e6:	853e                	mv	a0,a5
    800242e8:	60e2                	ld	ra,24(sp)
    800242ea:	6442                	ld	s0,16(sp)
    800242ec:	6105                	addi	sp,sp,32
    800242ee:	8082                	ret

00000000800242f0 <sys_getcwd>:

// get absolute cwd string
uint64
sys_getcwd(void)
{
    800242f0:	7155                	addi	sp,sp,-208
    800242f2:	e586                	sd	ra,200(sp)
    800242f4:	e1a2                	sd	s0,192(sp)
    800242f6:	fd26                	sd	s1,184(sp)
    800242f8:	f94a                	sd	s2,176(sp)
    800242fa:	f54e                	sd	s3,168(sp)
    800242fc:	f152                	sd	s4,160(sp)
    800242fe:	ed56                	sd	s5,152(sp)
    80024300:	0980                	addi	s0,sp,208
  uint64 addr;
  if (argaddr(0, &addr) < 0)
    80024302:	fb840593          	addi	a1,s0,-72
    80024306:	4501                	li	a0,0
    80024308:	ffffe097          	auipc	ra,0xffffe
    8002430c:	502080e7          	jalr	1282(ra) # 8002280a <argaddr>
    return -1;
    80024310:	57fd                	li	a5,-1
  if (argaddr(0, &addr) < 0)
    80024312:	08054363          	bltz	a0,80024398 <sys_getcwd+0xa8>

  struct dirent *de = myproc()->cwd;
    80024316:	ffffd097          	auipc	ra,0xffffd
    8002431a:	2c0080e7          	jalr	704(ra) # 800215d6 <myproc>
    8002431e:	15053483          	ld	s1,336(a0)
  char path[MAXPATH];
  char *s;
  int len;

  if (de->parent == 0) {
    80024322:	1204b783          	ld	a5,288(s1)
    80024326:	c3d9                	beqz	a5,800243ac <sys_getcwd+0xbc>
    s = "/";
  } else {
    s = path + MAXPATH - 1;
    *s-- = '\0';
    80024328:	fa040ba3          	sb	zero,-73(s0)
    8002432c:	fb640993          	addi	s3,s0,-74
    while (de->parent) {
      len = strlen(de->filename);
      s -= len;
      if (s <= path)          // can't reach root "/"
    80024330:	f3840a13          	addi	s4,s0,-200
        return -1;
      strncpy(s, de->filename, len);
      *--s = '/';
    80024334:	02f00a93          	li	s5,47
      len = strlen(de->filename);
    80024338:	8526                	mv	a0,s1
    8002433a:	ffffc097          	auipc	ra,0xffffc
    8002433e:	4a8080e7          	jalr	1192(ra) # 800207e2 <strlen>
      s -= len;
    80024342:	40a98933          	sub	s2,s3,a0
      if (s <= path)          // can't reach root "/"
    80024346:	072a7863          	bgeu	s4,s2,800243b6 <sys_getcwd+0xc6>
      strncpy(s, de->filename, len);
    8002434a:	862a                	mv	a2,a0
    8002434c:	85a6                	mv	a1,s1
    8002434e:	854a                	mv	a0,s2
    80024350:	ffffc097          	auipc	ra,0xffffc
    80024354:	420080e7          	jalr	1056(ra) # 80020770 <strncpy>
      *--s = '/';
    80024358:	fff90993          	addi	s3,s2,-1
    8002435c:	ff590fa3          	sb	s5,-1(s2)
      de = de->parent;
    80024360:	1204b483          	ld	s1,288(s1)
    while (de->parent) {
    80024364:	1204b783          	ld	a5,288(s1)
    80024368:	fbe1                	bnez	a5,80024338 <sys_getcwd+0x48>
    }
  }

  if (copyout(myproc()->pagetable, addr, s, strlen(s) + 1) < 0)
    8002436a:	ffffd097          	auipc	ra,0xffffd
    8002436e:	26c080e7          	jalr	620(ra) # 800215d6 <myproc>
    80024372:	6924                	ld	s1,80(a0)
    80024374:	fb843903          	ld	s2,-72(s0)
    80024378:	854e                	mv	a0,s3
    8002437a:	ffffc097          	auipc	ra,0xffffc
    8002437e:	468080e7          	jalr	1128(ra) # 800207e2 <strlen>
    80024382:	0015069b          	addiw	a3,a0,1
    80024386:	864e                	mv	a2,s3
    80024388:	85ca                	mv	a1,s2
    8002438a:	8526                	mv	a0,s1
    8002438c:	ffffd097          	auipc	ra,0xffffd
    80024390:	e14080e7          	jalr	-492(ra) # 800211a0 <copyout>
    80024394:	43f55793          	srai	a5,a0,0x3f
    return -1;
  
  return 0;

    80024398:	853e                	mv	a0,a5
    8002439a:	60ae                	ld	ra,200(sp)
    8002439c:	640e                	ld	s0,192(sp)
    8002439e:	74ea                	ld	s1,184(sp)
    800243a0:	794a                	ld	s2,176(sp)
    800243a2:	79aa                	ld	s3,168(sp)
    800243a4:	7a0a                	ld	s4,160(sp)
    800243a6:	6aea                	ld	s5,152(sp)
    800243a8:	6169                	addi	sp,sp,208
    800243aa:	8082                	ret
    s = "/";
    800243ac:	00005997          	auipc	s3,0x5
    800243b0:	fa498993          	addi	s3,s3,-92 # 80029350 <states.1805+0x160>
    800243b4:	bf5d                	j	8002436a <sys_getcwd+0x7a>
        return -1;
    800243b6:	57fd                	li	a5,-1
    800243b8:	b7c5                	j	80024398 <sys_getcwd+0xa8>
    800243ba:	0000                	unimp
    800243bc:	0000                	unimp
	...

00000000800243c0 <kernelvec>:
    800243c0:	7111                	addi	sp,sp,-256
    800243c2:	e006                	sd	ra,0(sp)
    800243c4:	e40a                	sd	sp,8(sp)
    800243c6:	e80e                	sd	gp,16(sp)
    800243c8:	ec12                	sd	tp,24(sp)
    800243ca:	f016                	sd	t0,32(sp)
    800243cc:	f41a                	sd	t1,40(sp)
    800243ce:	f81e                	sd	t2,48(sp)
    800243d0:	fc22                	sd	s0,56(sp)
    800243d2:	e0a6                	sd	s1,64(sp)
    800243d4:	e4aa                	sd	a0,72(sp)
    800243d6:	e8ae                	sd	a1,80(sp)
    800243d8:	ecb2                	sd	a2,88(sp)
    800243da:	f0b6                	sd	a3,96(sp)
    800243dc:	f4ba                	sd	a4,104(sp)
    800243de:	f8be                	sd	a5,112(sp)
    800243e0:	fcc2                	sd	a6,120(sp)
    800243e2:	e146                	sd	a7,128(sp)
    800243e4:	e54a                	sd	s2,136(sp)
    800243e6:	e94e                	sd	s3,144(sp)
    800243e8:	ed52                	sd	s4,152(sp)
    800243ea:	f156                	sd	s5,160(sp)
    800243ec:	f55a                	sd	s6,168(sp)
    800243ee:	f95e                	sd	s7,176(sp)
    800243f0:	fd62                	sd	s8,184(sp)
    800243f2:	e1e6                	sd	s9,192(sp)
    800243f4:	e5ea                	sd	s10,200(sp)
    800243f6:	e9ee                	sd	s11,208(sp)
    800243f8:	edf2                	sd	t3,216(sp)
    800243fa:	f1f6                	sd	t4,224(sp)
    800243fc:	f5fa                	sd	t5,232(sp)
    800243fe:	f9fe                	sd	t6,240(sp)
    80024400:	96efe0ef          	jal	ra,8002256e <kerneltrap>
    80024404:	6082                	ld	ra,0(sp)
    80024406:	6122                	ld	sp,8(sp)
    80024408:	61c2                	ld	gp,16(sp)
    8002440a:	7282                	ld	t0,32(sp)
    8002440c:	7322                	ld	t1,40(sp)
    8002440e:	73c2                	ld	t2,48(sp)
    80024410:	7462                	ld	s0,56(sp)
    80024412:	6486                	ld	s1,64(sp)
    80024414:	6526                	ld	a0,72(sp)
    80024416:	65c6                	ld	a1,80(sp)
    80024418:	6666                	ld	a2,88(sp)
    8002441a:	7686                	ld	a3,96(sp)
    8002441c:	7726                	ld	a4,104(sp)
    8002441e:	77c6                	ld	a5,112(sp)
    80024420:	7866                	ld	a6,120(sp)
    80024422:	688a                	ld	a7,128(sp)
    80024424:	692a                	ld	s2,136(sp)
    80024426:	69ca                	ld	s3,144(sp)
    80024428:	6a6a                	ld	s4,152(sp)
    8002442a:	7a8a                	ld	s5,160(sp)
    8002442c:	7b2a                	ld	s6,168(sp)
    8002442e:	7bca                	ld	s7,176(sp)
    80024430:	7c6a                	ld	s8,184(sp)
    80024432:	6c8e                	ld	s9,192(sp)
    80024434:	6d2e                	ld	s10,200(sp)
    80024436:	6dce                	ld	s11,208(sp)
    80024438:	6e6e                	ld	t3,216(sp)
    8002443a:	7e8e                	ld	t4,224(sp)
    8002443c:	7f2e                	ld	t5,232(sp)
    8002443e:	7fce                	ld	t6,240(sp)
    80024440:	6111                	addi	sp,sp,256
    80024442:	10200073          	sret
    80024446:	00000013          	nop
    8002444a:	00000013          	nop
    8002444e:	0001                	nop

0000000080024450 <timervec>:
    80024450:	34051573          	csrrw	a0,mscratch,a0
    80024454:	e10c                	sd	a1,0(a0)
    80024456:	e510                	sd	a2,8(a0)
    80024458:	e914                	sd	a3,16(a0)
    8002445a:	710c                	ld	a1,32(a0)
    8002445c:	7510                	ld	a2,40(a0)
    8002445e:	6194                	ld	a3,0(a1)
    80024460:	96b2                	add	a3,a3,a2
    80024462:	e194                	sd	a3,0(a1)
    80024464:	4589                	li	a1,2
    80024466:	14459073          	csrw	sip,a1
    8002446a:	6914                	ld	a3,16(a0)
    8002446c:	6510                	ld	a2,8(a0)
    8002446e:	610c                	ld	a1,0(a0)
    80024470:	34051573          	csrrw	a0,mscratch,a0
    80024474:	30200073          	mret
	...

000000008002447a <set_next_timeout>:
    set_next_timeout();
    printf("timerinit\n");
}

void
set_next_timeout() {
    8002447a:	1141                	addi	sp,sp,-16
    8002447c:	e406                	sd	ra,8(sp)
    8002447e:	e022                	sd	s0,0(sp)
    80024480:	0800                	addi	s0,sp,16
    // There is a very strange bug,
    // if comment the `printf` line below
    // the timer will not work.
    printf("");
    80024482:	00005517          	auipc	a0,0x5
    80024486:	c1e50513          	addi	a0,a0,-994 # 800290a0 <etext+0xa0>
    8002448a:	ffffc097          	auipc	ra,0xffffc
    8002448e:	c8e080e7          	jalr	-882(ra) # 80020118 <printf>
  asm volatile("rdtime %0" : "=r" (x) );
    80024492:	c0102573          	rdtime	a0
    sbi_set_timer(r_time() + INTERVAL);
    80024496:	001dc7b7          	lui	a5,0x1dc
    8002449a:	13078793          	addi	a5,a5,304 # 1dc130 <BASE_ADDRESS-0x7fe43ed0>
    8002449e:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
    800244a0:	4581                	li	a1,0
    800244a2:	4601                	li	a2,0
    800244a4:	4681                	li	a3,0
    800244a6:	4881                	li	a7,0
    800244a8:	00000073          	ecall
}
    800244ac:	60a2                	ld	ra,8(sp)
    800244ae:	6402                	ld	s0,0(sp)
    800244b0:	0141                	addi	sp,sp,16
    800244b2:	8082                	ret

00000000800244b4 <timerinit>:
void timerinit() {
    800244b4:	1141                	addi	sp,sp,-16
    800244b6:	e406                	sd	ra,8(sp)
    800244b8:	e022                	sd	s0,0(sp)
    800244ba:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, sie" : "=r" (x) );
    800244bc:	104027f3          	csrr	a5,sie
    w_sie(r_sie() | SIE_STIE);
    800244c0:	0207e793          	ori	a5,a5,32
  asm volatile("csrw sie, %0" : : "r" (x));
    800244c4:	10479073          	csrw	sie,a5
    set_next_timeout();
    800244c8:	00000097          	auipc	ra,0x0
    800244cc:	fb2080e7          	jalr	-78(ra) # 8002447a <set_next_timeout>
    printf("timerinit\n");
    800244d0:	00005517          	auipc	a0,0x5
    800244d4:	27850513          	addi	a0,a0,632 # 80029748 <syscalls+0x1f8>
    800244d8:	ffffc097          	auipc	ra,0xffffc
    800244dc:	c40080e7          	jalr	-960(ra) # 80020118 <printf>
}
    800244e0:	60a2                	ld	ra,8(sp)
    800244e2:	6402                	ld	s0,0(sp)
    800244e4:	0141                	addi	sp,sp,16
    800244e6:	8082                	ret

00000000800244e8 <timer_tick>:

void timer_tick() {
    800244e8:	1101                	addi	sp,sp,-32
    800244ea:	ec06                	sd	ra,24(sp)
    800244ec:	e822                	sd	s0,16(sp)
    800244ee:	e426                	sd	s1,8(sp)
    800244f0:	1000                	addi	s0,sp,32
    set_next_timeout();
    800244f2:	00000097          	auipc	ra,0x0
    800244f6:	f88080e7          	jalr	-120(ra) # 8002447a <set_next_timeout>
    tick++;
    800244fa:	00017717          	auipc	a4,0x17
    800244fe:	c3670713          	addi	a4,a4,-970 # 8003b130 <tick>
    80024502:	431c                	lw	a5,0(a4)
    80024504:	2785                	addiw	a5,a5,1
    80024506:	c31c                	sw	a5,0(a4)
    if((tick % 10) == 0) {
    80024508:	4729                	li	a4,10
    8002450a:	02e7e7bb          	remw	a5,a5,a4
    8002450e:	eb81                	bnez	a5,8002451e <timer_tick+0x36>
        // printf("[Timer]tick: %d from hart %d\n", tick, r_tp());
        #ifndef QEMU
        uint32 c = *(uint32*)(UARTHS + UARTHS_REG_RXFIFO);
    80024510:	380007b7          	lui	a5,0x38000
    80024514:	43c4                	lw	s1,4(a5)
        if(c <= 255) {
    80024516:	0ff00793          	li	a5,255
    8002451a:	0097f763          	bgeu	a5,s1,80024528 <timer_tick+0x40>
            sbi_console_putchar(c);
            printf("\n");
        }
        #endif
    }
}
    8002451e:	60e2                	ld	ra,24(sp)
    80024520:	6442                	ld	s0,16(sp)
    80024522:	64a2                	ld	s1,8(sp)
    80024524:	6105                	addi	sp,sp,32
    80024526:	8082                	ret
            printf("[UARTHS]receive: %p, ", c);
    80024528:	85a6                	mv	a1,s1
    8002452a:	00005517          	auipc	a0,0x5
    8002452e:	22e50513          	addi	a0,a0,558 # 80029758 <syscalls+0x208>
    80024532:	ffffc097          	auipc	ra,0xffffc
    80024536:	be6080e7          	jalr	-1050(ra) # 80020118 <printf>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
    8002453a:	0004851b          	sext.w	a0,s1
    8002453e:	4581                	li	a1,0
    80024540:	4601                	li	a2,0
    80024542:	4681                	li	a3,0
    80024544:	4885                	li	a7,1
    80024546:	00000073          	ecall
            printf("\n");
    8002454a:	00005517          	auipc	a0,0x5
    8002454e:	4ae50513          	addi	a0,a0,1198 # 800299f8 <syscalls+0x4a8>
    80024552:	ffffc097          	auipc	ra,0xffffc
    80024556:	bc6080e7          	jalr	-1082(ra) # 80020118 <printf>
}
    8002455a:	b7d1                	j	8002451e <timer_tick+0x36>

000000008002455c <print_logo>:
    printf("  .'    \\_)    \\     /__)' \\  |  |  '------'   |  | |  |   |  .--'   |  |   |  |  |  | | `-' /\n");
    printf(" /  .'.  \\      \\   /    \\  `'  /              '  '-'  '-. |  `---.  |  |   |  | ('  '-'(_.-'\n");
    printf("'--'   '--'      `-'      `----'                `-----'--' `------'  `--'   `--'   `-----'\n");
}
#else
void print_logo() {
    8002455c:	1141                	addi	sp,sp,-16
    8002455e:	e406                	sd	ra,8(sp)
    80024560:	e022                	sd	s0,0(sp)
    80024562:	0800                	addi	s0,sp,16
    printf(" (`-')           (`-')                   <-.(`-')\n");
    80024564:	00005517          	auipc	a0,0x5
    80024568:	20c50513          	addi	a0,a0,524 # 80029770 <syscalls+0x220>
    8002456c:	ffffc097          	auipc	ra,0xffffc
    80024570:	bac080e7          	jalr	-1108(ra) # 80020118 <printf>
    printf(" (OO )_.->      _(OO )                    __( OO)\n");
    80024574:	00005517          	auipc	a0,0x5
    80024578:	23450513          	addi	a0,a0,564 # 800297a8 <syscalls+0x258>
    8002457c:	ffffc097          	auipc	ra,0xffffc
    80024580:	b9c080e7          	jalr	-1124(ra) # 80020118 <printf>
    printf(" (_| \\_)--.,--.(_/,-.\\  ,--.    (`-')    '-'. ,--.  .----.   .--.   .----.\n");
    80024584:	00005517          	auipc	a0,0x5
    80024588:	25c50513          	addi	a0,a0,604 # 800297e0 <syscalls+0x290>
    8002458c:	ffffc097          	auipc	ra,0xffffc
    80024590:	b8c080e7          	jalr	-1140(ra) # 80020118 <printf>
    printf(" \\  `.'  / \\   \\ / (_/ /  .'    ( OO).-> |  .'   / \\_,-.  | /_  |  /  ..  \\\n");
    80024594:	00005517          	auipc	a0,0x5
    80024598:	29c50513          	addi	a0,a0,668 # 80029830 <syscalls+0x2e0>
    8002459c:	ffffc097          	auipc	ra,0xffffc
    800245a0:	b7c080e7          	jalr	-1156(ra) # 80020118 <printf>
    printf("  \\    .')  \\   /   / .  / -.  (,------. |      /)    .' .'  |  | |  /  \\  .\n");
    800245a4:	00005517          	auipc	a0,0x5
    800245a8:	2dc50513          	addi	a0,a0,732 # 80029880 <syscalls+0x330>
    800245ac:	ffffc097          	auipc	ra,0xffffc
    800245b0:	b6c080e7          	jalr	-1172(ra) # 80020118 <printf>
    printf("  .'    \\  _ \\     /_)'  .-. \\  `------' |  .   '   .'  /_   |  | '  \\  /  '\n");
    800245b4:	00005517          	auipc	a0,0x5
    800245b8:	31c50513          	addi	a0,a0,796 # 800298d0 <syscalls+0x380>
    800245bc:	ffffc097          	auipc	ra,0xffffc
    800245c0:	b5c080e7          	jalr	-1188(ra) # 80020118 <printf>
    printf(" /  .'.  \\ \\-'\\   /   \\  `-' /           |  |\\   \\ |      |  |  |  \\  `'  /\n");
    800245c4:	00005517          	auipc	a0,0x5
    800245c8:	35c50513          	addi	a0,a0,860 # 80029920 <syscalls+0x3d0>
    800245cc:	ffffc097          	auipc	ra,0xffffc
    800245d0:	b4c080e7          	jalr	-1204(ra) # 80020118 <printf>
    printf("`--'   '--'    `-'     `----'            `--' '--' `------'  `--'   `---''\n");
    800245d4:	00005517          	auipc	a0,0x5
    800245d8:	39c50513          	addi	a0,a0,924 # 80029970 <syscalls+0x420>
    800245dc:	ffffc097          	auipc	ra,0xffffc
    800245e0:	b3c080e7          	jalr	-1220(ra) # 80020118 <printf>
}
    800245e4:	60a2                	ld	ra,8(sp)
    800245e6:	6402                	ld	s0,0(sp)
    800245e8:	0141                	addi	sp,sp,16
    800245ea:	8082                	ret

00000000800245ec <test_kalloc>:
#include "include/sbi.h"
#include "include/sdcard.h"

extern char etext[];
extern struct proc *initproc;
void test_kalloc() {
    800245ec:	1101                	addi	sp,sp,-32
    800245ee:	ec06                	sd	ra,24(sp)
    800245f0:	e822                	sd	s0,16(sp)
    800245f2:	e426                	sd	s1,8(sp)
    800245f4:	1000                	addi	s0,sp,32
    char *mem = kalloc();
    800245f6:	ffffc097          	auipc	ra,0xffffc
    800245fa:	e56080e7          	jalr	-426(ra) # 8002044c <kalloc>
    800245fe:	84aa                	mv	s1,a0
    memset(mem, 0, PGSIZE);
    80024600:	6605                	lui	a2,0x1
    80024602:	4581                	li	a1,0
    80024604:	ffffc097          	auipc	ra,0xffffc
    80024608:	034080e7          	jalr	52(ra) # 80020638 <memset>
    strncpy(mem, "Hello, xv6-k210", 16);
    8002460c:	4641                	li	a2,16
    8002460e:	00005597          	auipc	a1,0x5
    80024612:	3b258593          	addi	a1,a1,946 # 800299c0 <syscalls+0x470>
    80024616:	8526                	mv	a0,s1
    80024618:	ffffc097          	auipc	ra,0xffffc
    8002461c:	158080e7          	jalr	344(ra) # 80020770 <strncpy>
    printf("[test_kalloc]mem: %s\n", mem);
    80024620:	85a6                	mv	a1,s1
    80024622:	00005517          	auipc	a0,0x5
    80024626:	3ae50513          	addi	a0,a0,942 # 800299d0 <syscalls+0x480>
    8002462a:	ffffc097          	auipc	ra,0xffffc
    8002462e:	aee080e7          	jalr	-1298(ra) # 80020118 <printf>
    kfree(mem);
    80024632:	8526                	mv	a0,s1
    80024634:	ffffc097          	auipc	ra,0xffffc
    80024638:	d06080e7          	jalr	-762(ra) # 8002033a <kfree>
}
    8002463c:	60e2                	ld	ra,24(sp)
    8002463e:	6442                	ld	s0,16(sp)
    80024640:	64a2                	ld	s1,8(sp)
    80024642:	6105                	addi	sp,sp,32
    80024644:	8082                	ret

0000000080024646 <test_vm>:

void test_vm(unsigned long hart_id) {
    80024646:	1101                	addi	sp,sp,-32
    80024648:	ec06                	sd	ra,24(sp)
    8002464a:	e822                	sd	s0,16(sp)
    8002464c:	e426                	sd	s1,8(sp)
    8002464e:	e04a                	sd	s2,0(sp)
    80024650:	1000                	addi	s0,sp,32
  #ifndef QEMU
  printf("[test_vm]UARTHS:\n");
    80024652:	00005517          	auipc	a0,0x5
    80024656:	39650513          	addi	a0,a0,918 # 800299e8 <syscalls+0x498>
    8002465a:	ffffc097          	auipc	ra,0xffffc
    8002465e:	abe080e7          	jalr	-1346(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", UARTHS, kvmpa(UARTHS));
    80024662:	38000537          	lui	a0,0x38000
    80024666:	ffffc097          	auipc	ra,0xffffc
    8002466a:	4a8080e7          	jalr	1192(ra) # 80020b0e <kvmpa>
    8002466e:	862a                	mv	a2,a0
    80024670:	380005b7          	lui	a1,0x38000
    80024674:	00005517          	auipc	a0,0x5
    80024678:	38c50513          	addi	a0,a0,908 # 80029a00 <syscalls+0x4b0>
    8002467c:	ffffc097          	auipc	ra,0xffffc
    80024680:	a9c080e7          	jalr	-1380(ra) # 80020118 <printf>
  #else
  printf("virto mmio:\n");
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", VIRTIO0, kvmpa(VIRTIO0));
  #endif
  printf("[test_vm]CLINT:\n");
    80024684:	00005517          	auipc	a0,0x5
    80024688:	3a450513          	addi	a0,a0,932 # 80029a28 <syscalls+0x4d8>
    8002468c:	ffffc097          	auipc	ra,0xffffc
    80024690:	a8c080e7          	jalr	-1396(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", CLINT, kvmpa(CLINT));
    80024694:	02000537          	lui	a0,0x2000
    80024698:	ffffc097          	auipc	ra,0xffffc
    8002469c:	476080e7          	jalr	1142(ra) # 80020b0e <kvmpa>
    800246a0:	862a                	mv	a2,a0
    800246a2:	020005b7          	lui	a1,0x2000
    800246a6:	00005517          	auipc	a0,0x5
    800246aa:	35a50513          	addi	a0,a0,858 # 80029a00 <syscalls+0x4b0>
    800246ae:	ffffc097          	auipc	ra,0xffffc
    800246b2:	a6a080e7          	jalr	-1430(ra) # 80020118 <printf>
//   printf("[test_vm](kvmpa) va: %p, pa: %p\n", CLINT_MTIMECMP(hart_id), kvmpa(CLINT_MTIMECMP(hart_id)));
//   printf("[test_vm](kvmpa) va: %p, pa: %p\n", CLINT_MTIME, kvmpa(CLINT_MTIME));
  printf("[test_vm]PLIC\n");
    800246b6:	00005517          	auipc	a0,0x5
    800246ba:	38a50513          	addi	a0,a0,906 # 80029a40 <syscalls+0x4f0>
    800246be:	ffffc097          	auipc	ra,0xffffc
    800246c2:	a5a080e7          	jalr	-1446(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", PLIC, kvmpa(PLIC));
    800246c6:	0c200537          	lui	a0,0xc200
    800246ca:	ffffc097          	auipc	ra,0xffffc
    800246ce:	444080e7          	jalr	1092(ra) # 80020b0e <kvmpa>
    800246d2:	862a                	mv	a2,a0
    800246d4:	0c2005b7          	lui	a1,0xc200
    800246d8:	00005517          	auipc	a0,0x5
    800246dc:	32850513          	addi	a0,a0,808 # 80029a00 <syscalls+0x4b0>
    800246e0:	ffffc097          	auipc	ra,0xffffc
    800246e4:	a38080e7          	jalr	-1480(ra) # 80020118 <printf>
//   printf("[test_vm](kvmpa) va: %p, pa: %p\n", PLIC_MPRIORITY(hart_id), kvmpa(PLIC_MPRIORITY(hart_id)));
//   printf("[test_vm](kvmpa) va: %p, pa: %p\n", PLIC_SPRIORITY(hart_id), kvmpa(PLIC_SPRIORITY(hart_id)));
//   printf("[test_vm](kvmpa) va: %p, pa: %p\n", PLIC_MCLAIM(hart_id), kvmpa(PLIC_MCLAIM(hart_id)));
//   printf("[test_vm](kvmpa) va: %p, pa: %p\n", PLIC_SCLAIM(hart_id), kvmpa(PLIC_SCLAIM(hart_id)));
  
  printf("[test_vm]rustsbi:\n");
    800246e8:	00005517          	auipc	a0,0x5
    800246ec:	36850513          	addi	a0,a0,872 # 80029a50 <syscalls+0x500>
    800246f0:	ffffc097          	auipc	ra,0xffffc
    800246f4:	a28080e7          	jalr	-1496(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", RUSTSBI_BASE, kvmpa(RUSTSBI_BASE));
    800246f8:	4505                	li	a0,1
    800246fa:	057e                	slli	a0,a0,0x1f
    800246fc:	ffffc097          	auipc	ra,0xffffc
    80024700:	412080e7          	jalr	1042(ra) # 80020b0e <kvmpa>
    80024704:	862a                	mv	a2,a0
    80024706:	800005b7          	lui	a1,0x80000
    8002470a:	00005517          	auipc	a0,0x5
    8002470e:	2f650513          	addi	a0,a0,758 # 80029a00 <syscalls+0x4b0>
    80024712:	ffffc097          	auipc	ra,0xffffc
    80024716:	a06080e7          	jalr	-1530(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", RUSTSBI_BASE + 0x1000, kvmpa(RUSTSBI_BASE + 0x1000));
    8002471a:	000804b7          	lui	s1,0x80
    8002471e:	00148513          	addi	a0,s1,1 # 80001 <BASE_ADDRESS-0x7ff9ffff>
    80024722:	0532                	slli	a0,a0,0xc
    80024724:	ffffc097          	auipc	ra,0xffffc
    80024728:	3ea080e7          	jalr	1002(ra) # 80020b0e <kvmpa>
    8002472c:	862a                	mv	a2,a0
    8002472e:	800015b7          	lui	a1,0x80001
    80024732:	00005517          	auipc	a0,0x5
    80024736:	2ce50513          	addi	a0,a0,718 # 80029a00 <syscalls+0x4b0>
    8002473a:	ffffc097          	auipc	ra,0xffffc
    8002473e:	9de080e7          	jalr	-1570(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", RUSTSBI_BASE + 0x2000, kvmpa(RUSTSBI_BASE + 0x2000));
    80024742:	40001537          	lui	a0,0x40001
    80024746:	0506                	slli	a0,a0,0x1
    80024748:	ffffc097          	auipc	ra,0xffffc
    8002474c:	3c6080e7          	jalr	966(ra) # 80020b0e <kvmpa>
    80024750:	862a                	mv	a2,a0
    80024752:	800025b7          	lui	a1,0x80002
    80024756:	00005517          	auipc	a0,0x5
    8002475a:	2aa50513          	addi	a0,a0,682 # 80029a00 <syscalls+0x4b0>
    8002475e:	ffffc097          	auipc	ra,0xffffc
    80024762:	9ba080e7          	jalr	-1606(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", RUSTSBI_BASE + 0x3000, kvmpa(RUSTSBI_BASE + 0x3000));
    80024766:	00348513          	addi	a0,s1,3
    8002476a:	0532                	slli	a0,a0,0xc
    8002476c:	ffffc097          	auipc	ra,0xffffc
    80024770:	3a2080e7          	jalr	930(ra) # 80020b0e <kvmpa>
    80024774:	862a                	mv	a2,a0
    80024776:	800035b7          	lui	a1,0x80003
    8002477a:	00005517          	auipc	a0,0x5
    8002477e:	28650513          	addi	a0,a0,646 # 80029a00 <syscalls+0x4b0>
    80024782:	ffffc097          	auipc	ra,0xffffc
    80024786:	996080e7          	jalr	-1642(ra) # 80020118 <printf>
  printf("[test_vm]kernel base:\n");
    8002478a:	00005517          	auipc	a0,0x5
    8002478e:	2de50513          	addi	a0,a0,734 # 80029a68 <syscalls+0x518>
    80024792:	ffffc097          	auipc	ra,0xffffc
    80024796:	986080e7          	jalr	-1658(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", KERNBASE, kvmpa(KERNBASE));
    8002479a:	04001537          	lui	a0,0x4001
    8002479e:	0516                	slli	a0,a0,0x5
    800247a0:	ffffc097          	auipc	ra,0xffffc
    800247a4:	36e080e7          	jalr	878(ra) # 80020b0e <kvmpa>
    800247a8:	862a                	mv	a2,a0
    800247aa:	800205b7          	lui	a1,0x80020
    800247ae:	00005517          	auipc	a0,0x5
    800247b2:	25250513          	addi	a0,a0,594 # 80029a00 <syscalls+0x4b0>
    800247b6:	ffffc097          	auipc	ra,0xffffc
    800247ba:	962080e7          	jalr	-1694(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", KERNBASE + 0x1000, kvmpa(KERNBASE + 0x1000));
    800247be:	02148513          	addi	a0,s1,33
    800247c2:	0532                	slli	a0,a0,0xc
    800247c4:	ffffc097          	auipc	ra,0xffffc
    800247c8:	34a080e7          	jalr	842(ra) # 80020b0e <kvmpa>
    800247cc:	862a                	mv	a2,a0
    800247ce:	800215b7          	lui	a1,0x80021
    800247d2:	00005517          	auipc	a0,0x5
    800247d6:	22e50513          	addi	a0,a0,558 # 80029a00 <syscalls+0x4b0>
    800247da:	ffffc097          	auipc	ra,0xffffc
    800247de:	93e080e7          	jalr	-1730(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", KERNBASE + 0x2000, kvmpa(KERNBASE + 0x2000));
    800247e2:	40011537          	lui	a0,0x40011
    800247e6:	0506                	slli	a0,a0,0x1
    800247e8:	ffffc097          	auipc	ra,0xffffc
    800247ec:	326080e7          	jalr	806(ra) # 80020b0e <kvmpa>
    800247f0:	862a                	mv	a2,a0
    800247f2:	800225b7          	lui	a1,0x80022
    800247f6:	00005517          	auipc	a0,0x5
    800247fa:	20a50513          	addi	a0,a0,522 # 80029a00 <syscalls+0x4b0>
    800247fe:	ffffc097          	auipc	ra,0xffffc
    80024802:	91a080e7          	jalr	-1766(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", KERNBASE + 0x3000, kvmpa(KERNBASE + 0x3000));
    80024806:	02348513          	addi	a0,s1,35
    8002480a:	0532                	slli	a0,a0,0xc
    8002480c:	ffffc097          	auipc	ra,0xffffc
    80024810:	302080e7          	jalr	770(ra) # 80020b0e <kvmpa>
    80024814:	862a                	mv	a2,a0
    80024816:	800235b7          	lui	a1,0x80023
    8002481a:	00005517          	auipc	a0,0x5
    8002481e:	1e650513          	addi	a0,a0,486 # 80029a00 <syscalls+0x4b0>
    80024822:	ffffc097          	auipc	ra,0xffffc
    80024826:	8f6080e7          	jalr	-1802(ra) # 80020118 <printf>
  printf("[test_vm]etext:\n");
    8002482a:	00005517          	auipc	a0,0x5
    8002482e:	25650513          	addi	a0,a0,598 # 80029a80 <syscalls+0x530>
    80024832:	ffffc097          	auipc	ra,0xffffc
    80024836:	8e6080e7          	jalr	-1818(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", (uint64)etext, kvmpa((uint64)etext));
    8002483a:	00004497          	auipc	s1,0x4
    8002483e:	7c648493          	addi	s1,s1,1990 # 80029000 <etext>
    80024842:	8526                	mv	a0,s1
    80024844:	ffffc097          	auipc	ra,0xffffc
    80024848:	2ca080e7          	jalr	714(ra) # 80020b0e <kvmpa>
    8002484c:	862a                	mv	a2,a0
    8002484e:	85a6                	mv	a1,s1
    80024850:	00005517          	auipc	a0,0x5
    80024854:	1b050513          	addi	a0,a0,432 # 80029a00 <syscalls+0x4b0>
    80024858:	ffffc097          	auipc	ra,0xffffc
    8002485c:	8c0080e7          	jalr	-1856(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", (uint64)etext + 0x1000, kvmpa((uint64)etext + 0x1000));
    80024860:	00005497          	auipc	s1,0x5
    80024864:	7a048493          	addi	s1,s1,1952 # 8002a000 <function_config+0x268>
    80024868:	8526                	mv	a0,s1
    8002486a:	ffffc097          	auipc	ra,0xffffc
    8002486e:	2a4080e7          	jalr	676(ra) # 80020b0e <kvmpa>
    80024872:	862a                	mv	a2,a0
    80024874:	85a6                	mv	a1,s1
    80024876:	00005517          	auipc	a0,0x5
    8002487a:	18a50513          	addi	a0,a0,394 # 80029a00 <syscalls+0x4b0>
    8002487e:	ffffc097          	auipc	ra,0xffffc
    80024882:	89a080e7          	jalr	-1894(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", (uint64)etext + 0x2000, kvmpa((uint64)etext + 0x2000));
    80024886:	00006497          	auipc	s1,0x6
    8002488a:	77a48493          	addi	s1,s1,1914 # 8002b000 <printhello>
    8002488e:	8526                	mv	a0,s1
    80024890:	ffffc097          	auipc	ra,0xffffc
    80024894:	27e080e7          	jalr	638(ra) # 80020b0e <kvmpa>
    80024898:	862a                	mv	a2,a0
    8002489a:	85a6                	mv	a1,s1
    8002489c:	00005517          	auipc	a0,0x5
    800248a0:	16450513          	addi	a0,a0,356 # 80029a00 <syscalls+0x4b0>
    800248a4:	ffffc097          	auipc	ra,0xffffc
    800248a8:	874080e7          	jalr	-1932(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", (uint64)etext + 0x3000, kvmpa((uint64)etext + 0x3000));
    800248ac:	00007497          	auipc	s1,0x7
    800248b0:	75448493          	addi	s1,s1,1876 # 8002c000 <boot_stack>
    800248b4:	8526                	mv	a0,s1
    800248b6:	ffffc097          	auipc	ra,0xffffc
    800248ba:	258080e7          	jalr	600(ra) # 80020b0e <kvmpa>
    800248be:	862a                	mv	a2,a0
    800248c0:	85a6                	mv	a1,s1
    800248c2:	00005517          	auipc	a0,0x5
    800248c6:	13e50513          	addi	a0,a0,318 # 80029a00 <syscalls+0x4b0>
    800248ca:	ffffc097          	auipc	ra,0xffffc
    800248ce:	84e080e7          	jalr	-1970(ra) # 80020118 <printf>
  printf("[test_vm]trampoline:\n");
    800248d2:	00005517          	auipc	a0,0x5
    800248d6:	1c650513          	addi	a0,a0,454 # 80029a98 <syscalls+0x548>
    800248da:	ffffc097          	auipc	ra,0xffffc
    800248de:	83e080e7          	jalr	-1986(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", TRAMPOLINE, kvmpa(TRAMPOLINE));
    800248e2:	040004b7          	lui	s1,0x4000
    800248e6:	14fd                	addi	s1,s1,-1
    800248e8:	00c49513          	slli	a0,s1,0xc
    800248ec:	ffffc097          	auipc	ra,0xffffc
    800248f0:	222080e7          	jalr	546(ra) # 80020b0e <kvmpa>
    800248f4:	862a                	mv	a2,a0
    800248f6:	00c49593          	slli	a1,s1,0xc
    800248fa:	00005517          	auipc	a0,0x5
    800248fe:	10650513          	addi	a0,a0,262 # 80029a00 <syscalls+0x4b0>
    80024902:	ffffc097          	auipc	ra,0xffffc
    80024906:	816080e7          	jalr	-2026(ra) # 80020118 <printf>
  printf("[test_vm](kvmpa) va: %p, pa: %p\n", TRAMPOLINE + PGSIZE - 1, kvmpa(TRAMPOLINE + PGSIZE - 1));
    8002490a:	54fd                	li	s1,-1
    8002490c:	01a4d513          	srli	a0,s1,0x1a
    80024910:	ffffc097          	auipc	ra,0xffffc
    80024914:	1fe080e7          	jalr	510(ra) # 80020b0e <kvmpa>
    80024918:	862a                	mv	a2,a0
    8002491a:	01a4d593          	srli	a1,s1,0x1a
    8002491e:	00005517          	auipc	a0,0x5
    80024922:	0e250513          	addi	a0,a0,226 # 80029a00 <syscalls+0x4b0>
    80024926:	ffffb097          	auipc	ra,0xffffb
    8002492a:	7f2080e7          	jalr	2034(ra) # 80020118 <printf>
  printf("[test_vm]create test pagetable\n");
    8002492e:	00005517          	auipc	a0,0x5
    80024932:	18250513          	addi	a0,a0,386 # 80029ab0 <syscalls+0x560>
    80024936:	ffffb097          	auipc	ra,0xffffb
    8002493a:	7e2080e7          	jalr	2018(ra) # 80020118 <printf>
  pagetable_t test_pagetable = uvmcreate();
    8002493e:	ffffc097          	auipc	ra,0xffffc
    80024942:	52c080e7          	jalr	1324(ra) # 80020e6a <uvmcreate>
    80024946:	892a                	mv	s2,a0
  printf("[test_vm]test_pagetable: %p\n", test_pagetable);
    80024948:	85aa                	mv	a1,a0
    8002494a:	00005517          	auipc	a0,0x5
    8002494e:	18650513          	addi	a0,a0,390 # 80029ad0 <syscalls+0x580>
    80024952:	ffffb097          	auipc	ra,0xffffb
    80024956:	7c6080e7          	jalr	1990(ra) # 80020118 <printf>
  char *test_mem = kalloc();
    8002495a:	ffffc097          	auipc	ra,0xffffc
    8002495e:	af2080e7          	jalr	-1294(ra) # 8002044c <kalloc>
    80024962:	84aa                	mv	s1,a0
  memset(test_mem, 0, PGSIZE);
    80024964:	6605                	lui	a2,0x1
    80024966:	4581                	li	a1,0
    80024968:	ffffc097          	auipc	ra,0xffffc
    8002496c:	cd0080e7          	jalr	-816(ra) # 80020638 <memset>
  if(mappages(test_pagetable, 0, PGSIZE, (uint64)test_mem, PTE_R | PTE_W | PTE_U | PTE_X) != 0) {
    80024970:	4779                	li	a4,30
    80024972:	86a6                	mv	a3,s1
    80024974:	6605                	lui	a2,0x1
    80024976:	4581                	li	a1,0
    80024978:	854a                	mv	a0,s2
    8002497a:	ffffc097          	auipc	ra,0xffffc
    8002497e:	1f4080e7          	jalr	500(ra) # 80020b6e <mappages>
    80024982:	e939                	bnez	a0,800249d8 <test_vm+0x392>
    panic("[test_vm]mappages failed\n");
  }
  printf("[test_vm](walkaddr) va: %p, pa: %p\n", 0, walkaddr(test_pagetable, 0));
    80024984:	4581                	li	a1,0
    80024986:	854a                	mv	a0,s2
    80024988:	ffffc097          	auipc	ra,0xffffc
    8002498c:	144080e7          	jalr	324(ra) # 80020acc <walkaddr>
    80024990:	862a                	mv	a2,a0
    80024992:	4581                	li	a1,0
    80024994:	00005517          	auipc	a0,0x5
    80024998:	17c50513          	addi	a0,a0,380 # 80029b10 <syscalls+0x5c0>
    8002499c:	ffffb097          	auipc	ra,0xffffb
    800249a0:	77c080e7          	jalr	1916(ra) # 80020118 <printf>
  printf("[test_vm](walkaddr) va: %p, pa: %p\n", PGSIZE - 1, walkaddr(test_pagetable, PGSIZE - 1) + (PGSIZE - 1) % PGSIZE);
    800249a4:	6485                	lui	s1,0x1
    800249a6:	fff48593          	addi	a1,s1,-1 # fff <BASE_ADDRESS-0x8001f001>
    800249aa:	854a                	mv	a0,s2
    800249ac:	ffffc097          	auipc	ra,0xffffc
    800249b0:	120080e7          	jalr	288(ra) # 80020acc <walkaddr>
    800249b4:	fff48593          	addi	a1,s1,-1
    800249b8:	00b50633          	add	a2,a0,a1
    800249bc:	00005517          	auipc	a0,0x5
    800249c0:	15450513          	addi	a0,a0,340 # 80029b10 <syscalls+0x5c0>
    800249c4:	ffffb097          	auipc	ra,0xffffb
    800249c8:	754080e7          	jalr	1876(ra) # 80020118 <printf>
}
    800249cc:	60e2                	ld	ra,24(sp)
    800249ce:	6442                	ld	s0,16(sp)
    800249d0:	64a2                	ld	s1,8(sp)
    800249d2:	6902                	ld	s2,0(sp)
    800249d4:	6105                	addi	sp,sp,32
    800249d6:	8082                	ret
    panic("[test_vm]mappages failed\n");
    800249d8:	00005517          	auipc	a0,0x5
    800249dc:	11850513          	addi	a0,a0,280 # 80029af0 <syscalls+0x5a0>
    800249e0:	ffffb097          	auipc	ra,0xffffb
    800249e4:	6f6080e7          	jalr	1782(ra) # 800200d6 <panic>

00000000800249e8 <test_sdcard>:

#ifndef QEMU
void test_sdcard() {
    800249e8:	1101                	addi	sp,sp,-32
    800249ea:	ec06                	sd	ra,24(sp)
    800249ec:	e822                	sd	s0,16(sp)
    800249ee:	e426                	sd	s1,8(sp)
    800249f0:	e04a                	sd	s2,0(sp)
    800249f2:	1000                	addi	s0,sp,32
  uint8 *buffer = kalloc();
    800249f4:	ffffc097          	auipc	ra,0xffffc
    800249f8:	a58080e7          	jalr	-1448(ra) # 8002044c <kalloc>
    800249fc:	84aa                	mv	s1,a0
  uint8 *pre_buffer = kalloc();
    800249fe:	ffffc097          	auipc	ra,0xffffc
    80024a02:	a4e080e7          	jalr	-1458(ra) # 8002044c <kalloc>
    80024a06:	892a                	mv	s2,a0
  memset(buffer, 0, sizeof(buffer));
    80024a08:	4621                	li	a2,8
    80024a0a:	4581                	li	a1,0
    80024a0c:	8526                	mv	a0,s1
    80024a0e:	ffffc097          	auipc	ra,0xffffc
    80024a12:	c2a080e7          	jalr	-982(ra) # 80020638 <memset>
  if(sd_read_sector(pre_buffer, 0, sizeof(pre_buffer))) {
    80024a16:	4621                	li	a2,8
    80024a18:	4581                	li	a1,0
    80024a1a:	854a                	mv	a0,s2
    80024a1c:	00003097          	auipc	ra,0x3
    80024a20:	dec080e7          	jalr	-532(ra) # 80027808 <sd_read_sector>
    80024a24:	c56d                	beqz	a0,80024b0e <test_sdcard+0x126>
      printf("[test_sdcard]SD card read sector err\n");
    80024a26:	00005517          	auipc	a0,0x5
    80024a2a:	11250513          	addi	a0,a0,274 # 80029b38 <syscalls+0x5e8>
    80024a2e:	ffffb097          	auipc	ra,0xffffb
    80024a32:	6ea080e7          	jalr	1770(ra) # 80020118 <printf>
  } else {
      printf("[test_sdcard]SD card read sector succeed\n");
  }
  printf("[test_sdcard]Buffer: %s\n", buffer);
    80024a36:	85a6                	mv	a1,s1
    80024a38:	00005517          	auipc	a0,0x5
    80024a3c:	15850513          	addi	a0,a0,344 # 80029b90 <syscalls+0x640>
    80024a40:	ffffb097          	auipc	ra,0xffffb
    80024a44:	6d8080e7          	jalr	1752(ra) # 80020118 <printf>
  memmove(buffer, "Hello,sdcard", sizeof("Hello,sdcard"));
    80024a48:	4635                	li	a2,13
    80024a4a:	00005597          	auipc	a1,0x5
    80024a4e:	16658593          	addi	a1,a1,358 # 80029bb0 <syscalls+0x660>
    80024a52:	8526                	mv	a0,s1
    80024a54:	ffffc097          	auipc	ra,0xffffc
    80024a58:	c50080e7          	jalr	-944(ra) # 800206a4 <memmove>
  printf("[test_sdcard]Buffer: %s\n", buffer);
    80024a5c:	85a6                	mv	a1,s1
    80024a5e:	00005517          	auipc	a0,0x5
    80024a62:	13250513          	addi	a0,a0,306 # 80029b90 <syscalls+0x640>
    80024a66:	ffffb097          	auipc	ra,0xffffb
    80024a6a:	6b2080e7          	jalr	1714(ra) # 80020118 <printf>
  if(sd_write_sector(buffer, 0, sizeof(buffer))) {
    80024a6e:	4621                	li	a2,8
    80024a70:	4581                	li	a1,0
    80024a72:	8526                	mv	a0,s1
    80024a74:	00003097          	auipc	ra,0x3
    80024a78:	e7a080e7          	jalr	-390(ra) # 800278ee <sd_write_sector>
    80024a7c:	c155                	beqz	a0,80024b20 <test_sdcard+0x138>
      printf("[test_sdcard]SD card write sector err\n");
    80024a7e:	00005517          	auipc	a0,0x5
    80024a82:	14250513          	addi	a0,a0,322 # 80029bc0 <syscalls+0x670>
    80024a86:	ffffb097          	auipc	ra,0xffffb
    80024a8a:	692080e7          	jalr	1682(ra) # 80020118 <printf>
  } else {
      printf("[test_sdcard]SD card write sector succeed\n");
  }
  memset(buffer, 0, sizeof(buffer));
    80024a8e:	4621                	li	a2,8
    80024a90:	4581                	li	a1,0
    80024a92:	8526                	mv	a0,s1
    80024a94:	ffffc097          	auipc	ra,0xffffc
    80024a98:	ba4080e7          	jalr	-1116(ra) # 80020638 <memset>
  if(sd_read_sector(buffer, 0, sizeof(buffer))) {
    80024a9c:	4621                	li	a2,8
    80024a9e:	4581                	li	a1,0
    80024aa0:	8526                	mv	a0,s1
    80024aa2:	00003097          	auipc	ra,0x3
    80024aa6:	d66080e7          	jalr	-666(ra) # 80027808 <sd_read_sector>
    80024aaa:	c541                	beqz	a0,80024b32 <test_sdcard+0x14a>
      printf("[test_sdcard]SD card read sector err\n");
    80024aac:	00005517          	auipc	a0,0x5
    80024ab0:	08c50513          	addi	a0,a0,140 # 80029b38 <syscalls+0x5e8>
    80024ab4:	ffffb097          	auipc	ra,0xffffb
    80024ab8:	664080e7          	jalr	1636(ra) # 80020118 <printf>
  } else {
      printf("[test_sdcard]SD card read sector succeed\n");
  }
  printf("[test_sdcard]Buffer: %s\n", buffer);
    80024abc:	85a6                	mv	a1,s1
    80024abe:	00005517          	auipc	a0,0x5
    80024ac2:	0d250513          	addi	a0,a0,210 # 80029b90 <syscalls+0x640>
    80024ac6:	ffffb097          	auipc	ra,0xffffb
    80024aca:	652080e7          	jalr	1618(ra) # 80020118 <printf>
  if(sd_write_sector(pre_buffer, 0, sizeof(pre_buffer))) {
    80024ace:	4621                	li	a2,8
    80024ad0:	4581                	li	a1,0
    80024ad2:	854a                	mv	a0,s2
    80024ad4:	00003097          	auipc	ra,0x3
    80024ad8:	e1a080e7          	jalr	-486(ra) # 800278ee <sd_write_sector>
    80024adc:	c525                	beqz	a0,80024b44 <test_sdcard+0x15c>
      printf("[test_sdcard]SD card recover err\n");
    80024ade:	00005517          	auipc	a0,0x5
    80024ae2:	13a50513          	addi	a0,a0,314 # 80029c18 <syscalls+0x6c8>
    80024ae6:	ffffb097          	auipc	ra,0xffffb
    80024aea:	632080e7          	jalr	1586(ra) # 80020118 <printf>
  } else {
      printf("[test_sdcard]SD card recover succeed\n");
  }
  kfree(buffer);
    80024aee:	8526                	mv	a0,s1
    80024af0:	ffffc097          	auipc	ra,0xffffc
    80024af4:	84a080e7          	jalr	-1974(ra) # 8002033a <kfree>
  kfree(pre_buffer);
    80024af8:	854a                	mv	a0,s2
    80024afa:	ffffc097          	auipc	ra,0xffffc
    80024afe:	840080e7          	jalr	-1984(ra) # 8002033a <kfree>
}
    80024b02:	60e2                	ld	ra,24(sp)
    80024b04:	6442                	ld	s0,16(sp)
    80024b06:	64a2                	ld	s1,8(sp)
    80024b08:	6902                	ld	s2,0(sp)
    80024b0a:	6105                	addi	sp,sp,32
    80024b0c:	8082                	ret
      printf("[test_sdcard]SD card read sector succeed\n");
    80024b0e:	00005517          	auipc	a0,0x5
    80024b12:	05250513          	addi	a0,a0,82 # 80029b60 <syscalls+0x610>
    80024b16:	ffffb097          	auipc	ra,0xffffb
    80024b1a:	602080e7          	jalr	1538(ra) # 80020118 <printf>
    80024b1e:	bf21                	j	80024a36 <test_sdcard+0x4e>
      printf("[test_sdcard]SD card write sector succeed\n");
    80024b20:	00005517          	auipc	a0,0x5
    80024b24:	0c850513          	addi	a0,a0,200 # 80029be8 <syscalls+0x698>
    80024b28:	ffffb097          	auipc	ra,0xffffb
    80024b2c:	5f0080e7          	jalr	1520(ra) # 80020118 <printf>
    80024b30:	bfb9                	j	80024a8e <test_sdcard+0xa6>
      printf("[test_sdcard]SD card read sector succeed\n");
    80024b32:	00005517          	auipc	a0,0x5
    80024b36:	02e50513          	addi	a0,a0,46 # 80029b60 <syscalls+0x610>
    80024b3a:	ffffb097          	auipc	ra,0xffffb
    80024b3e:	5de080e7          	jalr	1502(ra) # 80020118 <printf>
    80024b42:	bfad                	j	80024abc <test_sdcard+0xd4>
      printf("[test_sdcard]SD card recover succeed\n");
    80024b44:	00005517          	auipc	a0,0x5
    80024b48:	0fc50513          	addi	a0,a0,252 # 80029c40 <syscalls+0x6f0>
    80024b4c:	ffffb097          	auipc	ra,0xffffb
    80024b50:	5cc080e7          	jalr	1484(ra) # 80020118 <printf>
    80024b54:	bf69                	j	80024aee <test_sdcard+0x106>

0000000080024b56 <disk_init>:
#include "include/memlayout.h"
#include "include/riscv.h"
#include "include/defs.h"

void disk_init(void)
{
    80024b56:	1141                	addi	sp,sp,-16
    80024b58:	e422                	sd	s0,8(sp)
    80024b5a:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_init();
    #endif
}
    80024b5c:	6422                	ld	s0,8(sp)
    80024b5e:	0141                	addi	sp,sp,16
    80024b60:	8082                	ret

0000000080024b62 <disk_read>:

void disk_read(struct buf *b)
{
    80024b62:	1141                	addi	sp,sp,-16
    80024b64:	e422                	sd	s0,8(sp)
    80024b66:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 0);
    #endif
}
    80024b68:	6422                	ld	s0,8(sp)
    80024b6a:	0141                	addi	sp,sp,16
    80024b6c:	8082                	ret

0000000080024b6e <disk_write>:

void disk_write(struct buf *b)
{
    80024b6e:	1141                	addi	sp,sp,-16
    80024b70:	e422                	sd	s0,8(sp)
    80024b72:	0800                	addi	s0,sp,16
    #ifdef QEMU
	virtio_disk_rw(b, 1);
    #endif
}
    80024b74:	6422                	ld	s0,8(sp)
    80024b76:	0141                	addi	sp,sp,16
    80024b78:	8082                	ret

0000000080024b7a <disk_intr>:

void disk_intr(void)
{
    80024b7a:	1141                	addi	sp,sp,-16
    80024b7c:	e422                	sd	s0,8(sp)
    80024b7e:	0800                	addi	s0,sp,16
    #ifdef QEMU
    virtio_disk_intr();
    #endif
    80024b80:	6422                	ld	s0,8(sp)
    80024b82:	0141                	addi	sp,sp,16
    80024b84:	8082                	ret

0000000080024b86 <wnstr_lazy>:
    }
    panic("eget: insufficient ecache");
    return 0;
}

static void wnstr_lazy(wchar *dst, char const *src, int len) {
    80024b86:	1141                	addi	sp,sp,-16
    80024b88:	e422                	sd	s0,8(sp)
    80024b8a:	0800                	addi	s0,sp,16
    while (len-- && *src) {
    80024b8c:	c605                	beqz	a2,80024bb4 <wnstr_lazy+0x2e>
    80024b8e:	0005c783          	lbu	a5,0(a1)
    80024b92:	c38d                	beqz	a5,80024bb4 <wnstr_lazy+0x2e>
    80024b94:	fff6071b          	addiw	a4,a2,-1
    80024b98:	1702                	slli	a4,a4,0x20
    80024b9a:	9301                	srli	a4,a4,0x20
    80024b9c:	0705                	addi	a4,a4,1
    80024b9e:	0706                	slli	a4,a4,0x1
    80024ba0:	972a                	add	a4,a4,a0
        *dst = *src++;
    80024ba2:	0585                	addi	a1,a1,1
    80024ba4:	00f51023          	sh	a5,0(a0)
        dst++;
    80024ba8:	0509                	addi	a0,a0,2
    while (len-- && *src) {
    80024baa:	00e50563          	beq	a0,a4,80024bb4 <wnstr_lazy+0x2e>
    80024bae:	0005c783          	lbu	a5,0(a1)
    80024bb2:	fbe5                	bnez	a5,80024ba2 <wnstr_lazy+0x1c>
    }
}
    80024bb4:	6422                	ld	s0,8(sp)
    80024bb6:	0141                	addi	sp,sp,16
    80024bb8:	8082                	ret

0000000080024bba <read_fat>:
{
    80024bba:	1101                	addi	sp,sp,-32
    80024bbc:	ec06                	sd	ra,24(sp)
    80024bbe:	e822                	sd	s0,16(sp)
    80024bc0:	e426                	sd	s1,8(sp)
    80024bc2:	e04a                	sd	s2,0(sp)
    80024bc4:	1000                	addi	s0,sp,32
    if (cluster >= FAT32_EOC) {
    80024bc6:	100007b7          	lui	a5,0x10000
    80024bca:	17dd                	addi	a5,a5,-9
        return cluster;
    80024bcc:	84aa                	mv	s1,a0
    if (cluster >= FAT32_EOC) {
    80024bce:	00a7eb63          	bltu	a5,a0,80024be4 <read_fat+0x2a>
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    80024bd2:	00016797          	auipc	a5,0x16
    80024bd6:	56678793          	addi	a5,a5,1382 # 8003b138 <fat>
    80024bda:	479c                	lw	a5,8(a5)
    80024bdc:	2785                	addiw	a5,a5,1
        return 0;
    80024bde:	4481                	li	s1,0
    if (cluster > fat.data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
    80024be0:	00a7f963          	bgeu	a5,a0,80024bf2 <read_fat+0x38>
}
    80024be4:	8526                	mv	a0,s1
    80024be6:	60e2                	ld	ra,24(sp)
    80024be8:	6442                	ld	s0,16(sp)
    80024bea:	64a2                	ld	s1,8(sp)
    80024bec:	6902                	ld	s2,0(sp)
    80024bee:	6105                	addi	sp,sp,32
    80024bf0:	8082                	ret
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    80024bf2:	0025149b          	slliw	s1,a0,0x2
    80024bf6:	00016917          	auipc	s2,0x16
    80024bfa:	54290913          	addi	s2,s2,1346 # 8003b138 <fat>
    80024bfe:	01095783          	lhu	a5,16(s2)
    80024c02:	02f4d7bb          	divuw	a5,s1,a5
    80024c06:	01495583          	lhu	a1,20(s2)
    struct buf *b = bread(0, fat_sec);
    80024c0a:	9dbd                	addw	a1,a1,a5
    80024c0c:	4501                	li	a0,0
    80024c0e:	ffffe097          	auipc	ra,0xffffe
    80024c12:	f74080e7          	jalr	-140(ra) # 80022b82 <bread>
    return (cluster << 2) % fat.bpb.byts_per_sec;
    80024c16:	01095783          	lhu	a5,16(s2)
    80024c1a:	02f4f4bb          	remuw	s1,s1,a5
    uint32 next_clus = *(uint32 *)(b->data + fat_offset_of_clus(cluster));
    80024c1e:	94aa                	add	s1,s1,a0
    80024c20:	4ca4                	lw	s1,88(s1)
    brelse(b);
    80024c22:	ffffe097          	auipc	ra,0xffffe
    80024c26:	09e080e7          	jalr	158(ra) # 80022cc0 <brelse>
    return next_clus;
    80024c2a:	bf6d                	j	80024be4 <read_fat+0x2a>

0000000080024c2c <reloc_clus>:
{
    80024c2c:	7179                	addi	sp,sp,-48
    80024c2e:	f406                	sd	ra,40(sp)
    80024c30:	f022                	sd	s0,32(sp)
    80024c32:	ec26                	sd	s1,24(sp)
    80024c34:	e84a                	sd	s2,16(sp)
    80024c36:	e44e                	sd	s3,8(sp)
    80024c38:	e052                	sd	s4,0(sp)
    80024c3a:	1800                	addi	s0,sp,48
    80024c3c:	84aa                	mv	s1,a0
    80024c3e:	89ae                	mv	s3,a1
    int clus_num = off / fat.byts_per_clus;
    80024c40:	00016797          	auipc	a5,0x16
    80024c44:	4f878793          	addi	a5,a5,1272 # 8003b138 <fat>
    80024c48:	00c7aa03          	lw	s4,12(a5)
    80024c4c:	0345d93b          	divuw	s2,a1,s4
    while (clus_num > entry->clus_cnt) {
    80024c50:	11052703          	lw	a4,272(a0)
    80024c54:	03277363          	bgeu	a4,s2,80024c7a <reloc_clus+0x4e>
        entry->cur_clus = read_fat(entry->cur_clus);
    80024c58:	10c4a503          	lw	a0,268(s1)
    80024c5c:	00000097          	auipc	ra,0x0
    80024c60:	f5e080e7          	jalr	-162(ra) # 80024bba <read_fat>
    80024c64:	10a4a623          	sw	a0,268(s1)
        entry->clus_cnt++;
    80024c68:	1104a783          	lw	a5,272(s1)
    80024c6c:	2785                	addiw	a5,a5,1
    80024c6e:	0007871b          	sext.w	a4,a5
    80024c72:	10f4a823          	sw	a5,272(s1)
    while (clus_num > entry->clus_cnt) {
    80024c76:	ff2761e3          	bltu	a4,s2,80024c58 <reloc_clus+0x2c>
    if (clus_num < entry->clus_cnt) {
    80024c7a:	02e97b63          	bgeu	s2,a4,80024cb0 <reloc_clus+0x84>
        entry->cur_clus = entry->first_clus;
    80024c7e:	1044a783          	lw	a5,260(s1)
    80024c82:	10f4a623          	sw	a5,268(s1)
        entry->clus_cnt = 0;
    80024c86:	1004a823          	sw	zero,272(s1)
        while (entry->clus_cnt < clus_num) {
    80024c8a:	0349e363          	bltu	s3,s4,80024cb0 <reloc_clus+0x84>
            entry->cur_clus = read_fat(entry->cur_clus);
    80024c8e:	10c4a503          	lw	a0,268(s1)
    80024c92:	00000097          	auipc	ra,0x0
    80024c96:	f28080e7          	jalr	-216(ra) # 80024bba <read_fat>
    80024c9a:	10a4a623          	sw	a0,268(s1)
            entry->clus_cnt++;
    80024c9e:	1104a783          	lw	a5,272(s1)
    80024ca2:	2785                	addiw	a5,a5,1
    80024ca4:	0007871b          	sext.w	a4,a5
    80024ca8:	10f4a823          	sw	a5,272(s1)
        while (entry->clus_cnt < clus_num) {
    80024cac:	ff2761e3          	bltu	a4,s2,80024c8e <reloc_clus+0x62>
    return off % fat.byts_per_clus;
    80024cb0:	00016797          	auipc	a5,0x16
    80024cb4:	48878793          	addi	a5,a5,1160 # 8003b138 <fat>
    80024cb8:	47c8                	lw	a0,12(a5)
}
    80024cba:	02a9f53b          	remuw	a0,s3,a0
    80024cbe:	70a2                	ld	ra,40(sp)
    80024cc0:	7402                	ld	s0,32(sp)
    80024cc2:	64e2                	ld	s1,24(sp)
    80024cc4:	6942                	ld	s2,16(sp)
    80024cc6:	69a2                	ld	s3,8(sp)
    80024cc8:	6a02                	ld	s4,0(sp)
    80024cca:	6145                	addi	sp,sp,48
    80024ccc:	8082                	ret

0000000080024cce <alloc_clus>:
{
    80024cce:	711d                	addi	sp,sp,-96
    80024cd0:	ec86                	sd	ra,88(sp)
    80024cd2:	e8a2                	sd	s0,80(sp)
    80024cd4:	e4a6                	sd	s1,72(sp)
    80024cd6:	e0ca                	sd	s2,64(sp)
    80024cd8:	fc4e                	sd	s3,56(sp)
    80024cda:	f852                	sd	s4,48(sp)
    80024cdc:	f456                	sd	s5,40(sp)
    80024cde:	f05a                	sd	s6,32(sp)
    80024ce0:	ec5e                	sd	s7,24(sp)
    80024ce2:	e862                	sd	s8,16(sp)
    80024ce4:	e466                	sd	s9,8(sp)
    80024ce6:	1080                	addi	s0,sp,96
    uint32 sec = fat.bpb.rsvd_sec_cnt;
    80024ce8:	00016797          	auipc	a5,0x16
    80024cec:	45078793          	addi	a5,a5,1104 # 8003b138 <fat>
    80024cf0:	0147db03          	lhu	s6,20(a5)
    uint32 const ent_per_sec = fat.bpb.byts_per_sec / sizeof(uint32);
    80024cf4:	0107d903          	lhu	s2,16(a5)
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    80024cf8:	539c                	lw	a5,32(a5)
    80024cfa:	10078663          	beqz	a5,80024e06 <alloc_clus+0x138>
    80024cfe:	0029591b          	srliw	s2,s2,0x2
    80024d02:	0009099b          	sext.w	s3,s2
    80024d06:	4a81                	li	s5,0
        b = bread(dev, sec);
    80024d08:	00050b9b          	sext.w	s7,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80024d0c:	4c01                	li	s8,0
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    80024d0e:	00016c97          	auipc	s9,0x16
    80024d12:	42ac8c93          	addi	s9,s9,1066 # 8003b138 <fat>
    80024d16:	a821                	j	80024d2e <alloc_clus+0x60>
        brelse(b);
    80024d18:	8552                	mv	a0,s4
    80024d1a:	ffffe097          	auipc	ra,0xffffe
    80024d1e:	fa6080e7          	jalr	-90(ra) # 80022cc0 <brelse>
    for (uint32 i = 0; i < fat.bpb.fat_sz; i++, sec++) {
    80024d22:	2a85                	addiw	s5,s5,1
    80024d24:	2b05                	addiw	s6,s6,1
    80024d26:	020ca783          	lw	a5,32(s9)
    80024d2a:	0cfafe63          	bgeu	s5,a5,80024e06 <alloc_clus+0x138>
        b = bread(dev, sec);
    80024d2e:	85da                	mv	a1,s6
    80024d30:	855e                	mv	a0,s7
    80024d32:	ffffe097          	auipc	ra,0xffffe
    80024d36:	e50080e7          	jalr	-432(ra) # 80022b82 <bread>
    80024d3a:	8a2a                	mv	s4,a0
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80024d3c:	fc098ee3          	beqz	s3,80024d18 <alloc_clus+0x4a>
            if (((uint32 *)(b->data))[j] == 0) {
    80024d40:	05850693          	addi	a3,a0,88
    80024d44:	4d24                	lw	s1,88(a0)
    80024d46:	cc81                	beqz	s1,80024d5e <alloc_clus+0x90>
    80024d48:	05c50793          	addi	a5,a0,92
        for (uint32 j = 0; j < ent_per_sec; j++) {
    80024d4c:	84e2                	mv	s1,s8
    80024d4e:	2485                	addiw	s1,s1,1
    80024d50:	fc9984e3          	beq	s3,s1,80024d18 <alloc_clus+0x4a>
            if (((uint32 *)(b->data))[j] == 0) {
    80024d54:	86be                	mv	a3,a5
    80024d56:	0791                	addi	a5,a5,4
    80024d58:	ffc7a703          	lw	a4,-4(a5)
    80024d5c:	fb6d                	bnez	a4,80024d4e <alloc_clus+0x80>
                ((uint32 *)(b->data))[j] = FAT32_EOC + 7;
    80024d5e:	100007b7          	lui	a5,0x10000
    80024d62:	17fd                	addi	a5,a5,-1
    80024d64:	c29c                	sw	a5,0(a3)
                bwrite(b);
    80024d66:	8552                	mv	a0,s4
    80024d68:	ffffe097          	auipc	ra,0xffffe
    80024d6c:	f1c080e7          	jalr	-228(ra) # 80022c84 <bwrite>
                brelse(b);
    80024d70:	8552                	mv	a0,s4
    80024d72:	ffffe097          	auipc	ra,0xffffe
    80024d76:	f4e080e7          	jalr	-178(ra) # 80022cc0 <brelse>
                uint32 clus = i * ent_per_sec + j;
    80024d7a:	0359093b          	mulw	s2,s2,s5
    80024d7e:	009904bb          	addw	s1,s2,s1
    80024d82:	00048a9b          	sext.w	s5,s1
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    80024d86:	00016717          	auipc	a4,0x16
    80024d8a:	3b270713          	addi	a4,a4,946 # 8003b138 <fat>
    80024d8e:	01274783          	lbu	a5,18(a4)
    80024d92:	34f9                	addiw	s1,s1,-2
    80024d94:	02f489bb          	mulw	s3,s1,a5
    80024d98:	4318                	lw	a4,0(a4)
    80024d9a:	00e989bb          	addw	s3,s3,a4
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    80024d9e:	c7b1                	beqz	a5,80024dea <alloc_clus+0x11c>
    80024da0:	4481                	li	s1,0
    80024da2:	00016a17          	auipc	s4,0x16
    80024da6:	396a0a13          	addi	s4,s4,918 # 8003b138 <fat>
        b = bread(0, sec++);
    80024daa:	013485bb          	addw	a1,s1,s3
    80024dae:	4501                	li	a0,0
    80024db0:	ffffe097          	auipc	ra,0xffffe
    80024db4:	dd2080e7          	jalr	-558(ra) # 80022b82 <bread>
    80024db8:	892a                	mv	s2,a0
        memset(b->data, 0, BSIZE);
    80024dba:	20000613          	li	a2,512
    80024dbe:	4581                	li	a1,0
    80024dc0:	05850513          	addi	a0,a0,88
    80024dc4:	ffffc097          	auipc	ra,0xffffc
    80024dc8:	874080e7          	jalr	-1932(ra) # 80020638 <memset>
        bwrite(b);
    80024dcc:	854a                	mv	a0,s2
    80024dce:	ffffe097          	auipc	ra,0xffffe
    80024dd2:	eb6080e7          	jalr	-330(ra) # 80022c84 <bwrite>
        brelse(b);
    80024dd6:	854a                	mv	a0,s2
    80024dd8:	ffffe097          	auipc	ra,0xffffe
    80024ddc:	ee8080e7          	jalr	-280(ra) # 80022cc0 <brelse>
    for (int i = 0; i < fat.bpb.sec_per_clus; i++) {
    80024de0:	2485                	addiw	s1,s1,1
    80024de2:	012a4783          	lbu	a5,18(s4)
    80024de6:	fcf4c2e3          	blt	s1,a5,80024daa <alloc_clus+0xdc>
}
    80024dea:	8556                	mv	a0,s5
    80024dec:	60e6                	ld	ra,88(sp)
    80024dee:	6446                	ld	s0,80(sp)
    80024df0:	64a6                	ld	s1,72(sp)
    80024df2:	6906                	ld	s2,64(sp)
    80024df4:	79e2                	ld	s3,56(sp)
    80024df6:	7a42                	ld	s4,48(sp)
    80024df8:	7aa2                	ld	s5,40(sp)
    80024dfa:	7b02                	ld	s6,32(sp)
    80024dfc:	6be2                	ld	s7,24(sp)
    80024dfe:	6c42                	ld	s8,16(sp)
    80024e00:	6ca2                	ld	s9,8(sp)
    80024e02:	6125                	addi	sp,sp,96
    80024e04:	8082                	ret
    panic("no clusters");
    80024e06:	00005517          	auipc	a0,0x5
    80024e0a:	e6250513          	addi	a0,a0,-414 # 80029c68 <syscalls+0x718>
    80024e0e:	ffffb097          	auipc	ra,0xffffb
    80024e12:	2c8080e7          	jalr	712(ra) # 800200d6 <panic>

0000000080024e16 <write_fat>:
    if (cluster > fat.data_clus_cnt + 1) {
    80024e16:	00016797          	auipc	a5,0x16
    80024e1a:	32278793          	addi	a5,a5,802 # 8003b138 <fat>
    80024e1e:	479c                	lw	a5,8(a5)
    80024e20:	2785                	addiw	a5,a5,1
    80024e22:	06a7e763          	bltu	a5,a0,80024e90 <write_fat+0x7a>
{
    80024e26:	7179                	addi	sp,sp,-48
    80024e28:	f406                	sd	ra,40(sp)
    80024e2a:	f022                	sd	s0,32(sp)
    80024e2c:	ec26                	sd	s1,24(sp)
    80024e2e:	e84a                	sd	s2,16(sp)
    80024e30:	e44e                	sd	s3,8(sp)
    80024e32:	e052                	sd	s4,0(sp)
    80024e34:	1800                	addi	s0,sp,48
    80024e36:	8a2e                	mv	s4,a1
    return fat.bpb.rsvd_sec_cnt + (cluster << 2) / fat.bpb.byts_per_sec + fat.bpb.fat_sz * (fat_num - 1);
    80024e38:	0025149b          	slliw	s1,a0,0x2
    80024e3c:	00016917          	auipc	s2,0x16
    80024e40:	2fc90913          	addi	s2,s2,764 # 8003b138 <fat>
    80024e44:	01095783          	lhu	a5,16(s2)
    80024e48:	02f4d7bb          	divuw	a5,s1,a5
    80024e4c:	01495583          	lhu	a1,20(s2)
    struct buf *b = bread(0, fat_sec);
    80024e50:	9dbd                	addw	a1,a1,a5
    80024e52:	4501                	li	a0,0
    80024e54:	ffffe097          	auipc	ra,0xffffe
    80024e58:	d2e080e7          	jalr	-722(ra) # 80022b82 <bread>
    80024e5c:	89aa                	mv	s3,a0
    return (cluster << 2) % fat.bpb.byts_per_sec;
    80024e5e:	01095783          	lhu	a5,16(s2)
    80024e62:	02f4f4bb          	remuw	s1,s1,a5
    *(uint32 *)(b->data + off) = content;
    80024e66:	94aa                	add	s1,s1,a0
    80024e68:	0544ac23          	sw	s4,88(s1)
    bwrite(b);
    80024e6c:	ffffe097          	auipc	ra,0xffffe
    80024e70:	e18080e7          	jalr	-488(ra) # 80022c84 <bwrite>
    brelse(b);
    80024e74:	854e                	mv	a0,s3
    80024e76:	ffffe097          	auipc	ra,0xffffe
    80024e7a:	e4a080e7          	jalr	-438(ra) # 80022cc0 <brelse>
    return 0;
    80024e7e:	4501                	li	a0,0
}
    80024e80:	70a2                	ld	ra,40(sp)
    80024e82:	7402                	ld	s0,32(sp)
    80024e84:	64e2                	ld	s1,24(sp)
    80024e86:	6942                	ld	s2,16(sp)
    80024e88:	69a2                	ld	s3,8(sp)
    80024e8a:	6a02                	ld	s4,0(sp)
    80024e8c:	6145                	addi	sp,sp,48
    80024e8e:	8082                	ret
        return -1;
    80024e90:	557d                	li	a0,-1
}
    80024e92:	8082                	ret

0000000080024e94 <rw_clus>:
{
    80024e94:	7119                	addi	sp,sp,-128
    80024e96:	fc86                	sd	ra,120(sp)
    80024e98:	f8a2                	sd	s0,112(sp)
    80024e9a:	f4a6                	sd	s1,104(sp)
    80024e9c:	f0ca                	sd	s2,96(sp)
    80024e9e:	ecce                	sd	s3,88(sp)
    80024ea0:	e8d2                	sd	s4,80(sp)
    80024ea2:	e4d6                	sd	s5,72(sp)
    80024ea4:	e0da                	sd	s6,64(sp)
    80024ea6:	fc5e                	sd	s7,56(sp)
    80024ea8:	f862                	sd	s8,48(sp)
    80024eaa:	f466                	sd	s9,40(sp)
    80024eac:	f06a                	sd	s10,32(sp)
    80024eae:	ec6e                	sd	s11,24(sp)
    80024eb0:	0100                	addi	s0,sp,128
    80024eb2:	f8c43423          	sd	a2,-120(s0)
    80024eb6:	8b36                	mv	s6,a3
    80024eb8:	8bbe                	mv	s7,a5
    if (off + n > fat.byts_per_clus)
    80024eba:	00f706bb          	addw	a3,a4,a5
    80024ebe:	00016797          	auipc	a5,0x16
    80024ec2:	27a78793          	addi	a5,a5,634 # 8003b138 <fat>
    80024ec6:	47dc                	lw	a5,12(a5)
    80024ec8:	02d7ef63          	bltu	a5,a3,80024f06 <rw_clus+0x72>
    80024ecc:	8d2e                	mv	s10,a1
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    80024ece:	00016797          	auipc	a5,0x16
    80024ed2:	26a78793          	addi	a5,a5,618 # 8003b138 <fat>
    80024ed6:	0107da03          	lhu	s4,16(a5)
    return ((cluster - 2) * fat.bpb.sec_per_clus) + fat.first_data_sec;
    80024eda:	ffe5099b          	addiw	s3,a0,-2
    80024ede:	0127c503          	lbu	a0,18(a5)
    80024ee2:	02a989bb          	mulw	s3,s3,a0
    80024ee6:	4388                	lw	a0,0(a5)
    80024ee8:	00a989bb          	addw	s3,s3,a0
    uint sec = first_sec_of_clus(cluster) + off / fat.bpb.byts_per_sec;
    80024eec:	034757bb          	divuw	a5,a4,s4
    80024ef0:	00f989bb          	addw	s3,s3,a5
    off = off % fat.bpb.byts_per_sec;
    80024ef4:	03477a3b          	remuw	s4,a4,s4
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    80024ef8:	0e0b8363          	beqz	s7,80024fde <rw_clus+0x14a>
    80024efc:	4901                	li	s2,0
        m = BSIZE - off % BSIZE;
    80024efe:	20000d93          	li	s11,512
        if (bad == -1) {
    80024f02:	5cfd                	li	s9,-1
    80024f04:	a095                	j	80024f68 <rw_clus+0xd4>
        panic("offset out of range");
    80024f06:	00005517          	auipc	a0,0x5
    80024f0a:	d7250513          	addi	a0,a0,-654 # 80029c78 <syscalls+0x728>
    80024f0e:	ffffb097          	auipc	ra,0xffffb
    80024f12:	1c8080e7          	jalr	456(ra) # 800200d6 <panic>
                bwrite(bp);
    80024f16:	8556                	mv	a0,s5
    80024f18:	ffffe097          	auipc	ra,0xffffe
    80024f1c:	d6c080e7          	jalr	-660(ra) # 80022c84 <bwrite>
        brelse(bp);
    80024f20:	8556                	mv	a0,s5
    80024f22:	ffffe097          	auipc	ra,0xffffe
    80024f26:	d9e080e7          	jalr	-610(ra) # 80022cc0 <brelse>
        if (bad == -1) {
    80024f2a:	a02d                	j	80024f54 <rw_clus+0xc0>
            bad = either_copyout(user, data, bp->data + (off % BSIZE), m);
    80024f2c:	058a8613          	addi	a2,s5,88
    80024f30:	1682                	slli	a3,a3,0x20
    80024f32:	9281                	srli	a3,a3,0x20
    80024f34:	963a                	add	a2,a2,a4
    80024f36:	85da                	mv	a1,s6
    80024f38:	f8843503          	ld	a0,-120(s0)
    80024f3c:	ffffd097          	auipc	ra,0xffffd
    80024f40:	1d0080e7          	jalr	464(ra) # 8002210c <either_copyout>
    80024f44:	8c2a                	mv	s8,a0
        brelse(bp);
    80024f46:	8556                	mv	a0,s5
    80024f48:	ffffe097          	auipc	ra,0xffffe
    80024f4c:	d78080e7          	jalr	-648(ra) # 80022cc0 <brelse>
        if (bad == -1) {
    80024f50:	079c0763          	beq	s8,s9,80024fbe <rw_clus+0x12a>
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    80024f54:	0124893b          	addw	s2,s1,s2
    80024f58:	01448a3b          	addw	s4,s1,s4
    80024f5c:	1482                	slli	s1,s1,0x20
    80024f5e:	9081                	srli	s1,s1,0x20
    80024f60:	9b26                	add	s6,s6,s1
    80024f62:	2985                	addiw	s3,s3,1
    80024f64:	05797d63          	bgeu	s2,s7,80024fbe <rw_clus+0x12a>
        bp = bread(0, sec);
    80024f68:	85ce                	mv	a1,s3
    80024f6a:	4501                	li	a0,0
    80024f6c:	ffffe097          	auipc	ra,0xffffe
    80024f70:	c16080e7          	jalr	-1002(ra) # 80022b82 <bread>
    80024f74:	8aaa                	mv	s5,a0
        m = BSIZE - off % BSIZE;
    80024f76:	1ffa7713          	andi	a4,s4,511
    80024f7a:	40ed863b          	subw	a2,s11,a4
        if (n - tot < m) {
    80024f7e:	412b87bb          	subw	a5,s7,s2
    80024f82:	86be                	mv	a3,a5
    80024f84:	2781                	sext.w	a5,a5
    80024f86:	0006059b          	sext.w	a1,a2
    80024f8a:	00f5f363          	bgeu	a1,a5,80024f90 <rw_clus+0xfc>
    80024f8e:	86b2                	mv	a3,a2
    80024f90:	0006849b          	sext.w	s1,a3
        if (write) {
    80024f94:	f80d0ce3          	beqz	s10,80024f2c <rw_clus+0x98>
            if ((bad = either_copyin(bp->data + (off % BSIZE), user, data, m)) != -1) {
    80024f98:	058a8513          	addi	a0,s5,88
    80024f9c:	1682                	slli	a3,a3,0x20
    80024f9e:	9281                	srli	a3,a3,0x20
    80024fa0:	865a                	mv	a2,s6
    80024fa2:	f8843583          	ld	a1,-120(s0)
    80024fa6:	953a                	add	a0,a0,a4
    80024fa8:	ffffd097          	auipc	ra,0xffffd
    80024fac:	1ba080e7          	jalr	442(ra) # 80022162 <either_copyin>
    80024fb0:	f79513e3          	bne	a0,s9,80024f16 <rw_clus+0x82>
        brelse(bp);
    80024fb4:	8556                	mv	a0,s5
    80024fb6:	ffffe097          	auipc	ra,0xffffe
    80024fba:	d0a080e7          	jalr	-758(ra) # 80022cc0 <brelse>
}
    80024fbe:	854a                	mv	a0,s2
    80024fc0:	70e6                	ld	ra,120(sp)
    80024fc2:	7446                	ld	s0,112(sp)
    80024fc4:	74a6                	ld	s1,104(sp)
    80024fc6:	7906                	ld	s2,96(sp)
    80024fc8:	69e6                	ld	s3,88(sp)
    80024fca:	6a46                	ld	s4,80(sp)
    80024fcc:	6aa6                	ld	s5,72(sp)
    80024fce:	6b06                	ld	s6,64(sp)
    80024fd0:	7be2                	ld	s7,56(sp)
    80024fd2:	7c42                	ld	s8,48(sp)
    80024fd4:	7ca2                	ld	s9,40(sp)
    80024fd6:	7d02                	ld	s10,32(sp)
    80024fd8:	6de2                	ld	s11,24(sp)
    80024fda:	6109                	addi	sp,sp,128
    80024fdc:	8082                	ret
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
    80024fde:	895e                	mv	s2,s7
    80024fe0:	bff9                	j	80024fbe <rw_clus+0x12a>

0000000080024fe2 <fat32_init>:
{
    80024fe2:	7139                	addi	sp,sp,-64
    80024fe4:	fc06                	sd	ra,56(sp)
    80024fe6:	f822                	sd	s0,48(sp)
    80024fe8:	f426                	sd	s1,40(sp)
    80024fea:	f04a                	sd	s2,32(sp)
    80024fec:	ec4e                	sd	s3,24(sp)
    80024fee:	e852                	sd	s4,16(sp)
    80024ff0:	e456                	sd	s5,8(sp)
    80024ff2:	0080                	addi	s0,sp,64
    struct buf *b = bread(0, 0);
    80024ff4:	4581                	li	a1,0
    80024ff6:	4501                	li	a0,0
    80024ff8:	ffffe097          	auipc	ra,0xffffe
    80024ffc:	b8a080e7          	jalr	-1142(ra) # 80022b82 <bread>
    80025000:	892a                	mv	s2,a0
    if (strncmp((char const*)(b->data + 82), "FAT32", 5))
    80025002:	4615                	li	a2,5
    80025004:	00005597          	auipc	a1,0x5
    80025008:	c8c58593          	addi	a1,a1,-884 # 80029c90 <syscalls+0x740>
    8002500c:	0aa50513          	addi	a0,a0,170
    80025010:	ffffb097          	auipc	ra,0xffffb
    80025014:	710080e7          	jalr	1808(ra) # 80020720 <strncmp>
    80025018:	16051063          	bnez	a0,80025178 <fat32_init+0x196>
    fat.bpb.byts_per_sec = *(uint16 *)(b->data + 11);
    8002501c:	06395603          	lhu	a2,99(s2)
    80025020:	00016497          	auipc	s1,0x16
    80025024:	11848493          	addi	s1,s1,280 # 8003b138 <fat>
    80025028:	00c49823          	sh	a2,16(s1)
    fat.bpb.sec_per_clus = *(b->data + 13);
    8002502c:	06594683          	lbu	a3,101(s2)
    80025030:	00d48923          	sb	a3,18(s1)
    fat.bpb.rsvd_sec_cnt = *(uint16 *)(b->data + 14);
    80025034:	06695583          	lhu	a1,102(s2)
    80025038:	00b49a23          	sh	a1,20(s1)
    fat.bpb.fat_cnt = *(b->data + 16);
    8002503c:	06894703          	lbu	a4,104(s2)
    80025040:	00e48b23          	sb	a4,22(s1)
    fat.bpb.hidd_sec = *(uint32 *)(b->data + 28);
    80025044:	07492783          	lw	a5,116(s2)
    80025048:	cc9c                	sw	a5,24(s1)
    fat.bpb.tot_sec = *(uint32 *)(b->data + 32);
    8002504a:	07892783          	lw	a5,120(s2)
    8002504e:	ccdc                	sw	a5,28(s1)
    fat.bpb.fat_sz = *(uint32 *)(b->data + 36);
    80025050:	07c92503          	lw	a0,124(s2)
    80025054:	d088                	sw	a0,32(s1)
    fat.bpb.root_clus = *(uint32 *)(b->data + 44);
    80025056:	08492803          	lw	a6,132(s2)
    8002505a:	0304a223          	sw	a6,36(s1)
    fat.first_data_sec = fat.bpb.rsvd_sec_cnt + fat.bpb.fat_cnt * fat.bpb.fat_sz;
    8002505e:	02a7073b          	mulw	a4,a4,a0
    80025062:	9f2d                	addw	a4,a4,a1
    80025064:	c098                	sw	a4,0(s1)
    fat.data_sec_cnt = fat.bpb.tot_sec - fat.first_data_sec;
    80025066:	9f99                	subw	a5,a5,a4
    80025068:	c0dc                	sw	a5,4(s1)
    fat.data_clus_cnt = fat.data_sec_cnt / fat.bpb.sec_per_clus;
    8002506a:	02d7d7bb          	divuw	a5,a5,a3
    8002506e:	c49c                	sw	a5,8(s1)
    fat.byts_per_clus = fat.bpb.sec_per_clus * fat.bpb.byts_per_sec;
    80025070:	02c686bb          	mulw	a3,a3,a2
    80025074:	c4d4                	sw	a3,12(s1)
    brelse(b);
    80025076:	854a                	mv	a0,s2
    80025078:	ffffe097          	auipc	ra,0xffffe
    8002507c:	c48080e7          	jalr	-952(ra) # 80022cc0 <brelse>
    if (BSIZE != fat.bpb.byts_per_sec) 
    80025080:	0104d703          	lhu	a4,16(s1)
    80025084:	20000793          	li	a5,512
    80025088:	10f71063          	bne	a4,a5,80025188 <fat32_init+0x1a6>
    initlock(&ecache.lock, "ecache");
    8002508c:	00005597          	auipc	a1,0x5
    80025090:	c3c58593          	addi	a1,a1,-964 # 80029cc8 <syscalls+0x778>
    80025094:	00016517          	auipc	a0,0x16
    80025098:	23450513          	addi	a0,a0,564 # 8003b2c8 <ecache>
    8002509c:	ffffb097          	auipc	ra,0xffffb
    800250a0:	410080e7          	jalr	1040(ra) # 800204ac <initlock>
    memset(&root, 0, sizeof(root));
    800250a4:	00016497          	auipc	s1,0x16
    800250a8:	09448493          	addi	s1,s1,148 # 8003b138 <fat>
    800250ac:	00016917          	auipc	s2,0x16
    800250b0:	0b490913          	addi	s2,s2,180 # 8003b160 <root>
    800250b4:	16800613          	li	a2,360
    800250b8:	4581                	li	a1,0
    800250ba:	854a                	mv	a0,s2
    800250bc:	ffffb097          	auipc	ra,0xffffb
    800250c0:	57c080e7          	jalr	1404(ra) # 80020638 <memset>
    initsleeplock(&root.lock, "entry");
    800250c4:	00005597          	auipc	a1,0x5
    800250c8:	c0c58593          	addi	a1,a1,-1012 # 80029cd0 <syscalls+0x780>
    800250cc:	00016517          	auipc	a0,0x16
    800250d0:	1cc50513          	addi	a0,a0,460 # 8003b298 <root+0x138>
    800250d4:	ffffe097          	auipc	ra,0xffffe
    800250d8:	d02080e7          	jalr	-766(ra) # 80022dd6 <initsleeplock>
    root.attribute = (ATTR_DIRECTORY | ATTR_SYSTEM);
    800250dc:	47d1                	li	a5,20
    800250de:	12f48423          	sb	a5,296(s1)
    root.first_clus = root.cur_clus = fat.bpb.root_clus;
    800250e2:	50dc                	lw	a5,36(s1)
    800250e4:	12f4aa23          	sw	a5,308(s1)
    800250e8:	12f4a623          	sw	a5,300(s1)
    root.valid = 1;
    800250ec:	4785                	li	a5,1
    800250ee:	12f48f23          	sb	a5,318(s1)
    root.prev = &root;
    800250f2:	1524bc23          	sd	s2,344(s1)
    root.next = &root;
    800250f6:	1524b823          	sd	s2,336(s1)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    800250fa:	00016497          	auipc	s1,0x16
    800250fe:	1e648493          	addi	s1,s1,486 # 8003b2e0 <ecache+0x18>
        de->next = root.next;
    80025102:	00016917          	auipc	s2,0x16
    80025106:	03690913          	addi	s2,s2,54 # 8003b138 <fat>
        de->prev = &root;
    8002510a:	00016a97          	auipc	s5,0x16
    8002510e:	056a8a93          	addi	s5,s5,86 # 8003b160 <root>
        initsleeplock(&de->lock, "entry");
    80025112:	00005a17          	auipc	s4,0x5
    80025116:	bbea0a13          	addi	s4,s4,-1090 # 80029cd0 <syscalls+0x780>
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    8002511a:	0001b997          	auipc	s3,0x1b
    8002511e:	81698993          	addi	s3,s3,-2026 # 8003f930 <cardinfo>
        de->dev = 0;
    80025122:	10048a23          	sb	zero,276(s1)
        de->valid = 0;
    80025126:	10048b23          	sb	zero,278(s1)
        de->ref = 0;
    8002512a:	1004ac23          	sw	zero,280(s1)
        de->dirty = 0;
    8002512e:	10048aa3          	sb	zero,277(s1)
        de->parent = 0;
    80025132:	1204b023          	sd	zero,288(s1)
        de->next = root.next;
    80025136:	15093783          	ld	a5,336(s2)
    8002513a:	12f4b423          	sd	a5,296(s1)
        de->prev = &root;
    8002513e:	1354b823          	sd	s5,304(s1)
        initsleeplock(&de->lock, "entry");
    80025142:	85d2                	mv	a1,s4
    80025144:	13848513          	addi	a0,s1,312
    80025148:	ffffe097          	auipc	ra,0xffffe
    8002514c:	c8e080e7          	jalr	-882(ra) # 80022dd6 <initsleeplock>
        root.next->prev = de;
    80025150:	15093783          	ld	a5,336(s2)
    80025154:	1297b823          	sd	s1,304(a5)
        root.next = de;
    80025158:	14993823          	sd	s1,336(s2)
    for(struct dirent *de = ecache.entries; de < ecache.entries + ENTRY_CACHE_NUM; de++) {
    8002515c:	16848493          	addi	s1,s1,360
    80025160:	fd3491e3          	bne	s1,s3,80025122 <fat32_init+0x140>
}
    80025164:	4501                	li	a0,0
    80025166:	70e2                	ld	ra,56(sp)
    80025168:	7442                	ld	s0,48(sp)
    8002516a:	74a2                	ld	s1,40(sp)
    8002516c:	7902                	ld	s2,32(sp)
    8002516e:	69e2                	ld	s3,24(sp)
    80025170:	6a42                	ld	s4,16(sp)
    80025172:	6aa2                	ld	s5,8(sp)
    80025174:	6121                	addi	sp,sp,64
    80025176:	8082                	ret
        panic("not FAT32 volume");
    80025178:	00005517          	auipc	a0,0x5
    8002517c:	b2050513          	addi	a0,a0,-1248 # 80029c98 <syscalls+0x748>
    80025180:	ffffb097          	auipc	ra,0xffffb
    80025184:	f56080e7          	jalr	-170(ra) # 800200d6 <panic>
        panic("byts_per_sec != BSIZE");
    80025188:	00005517          	auipc	a0,0x5
    8002518c:	b2850513          	addi	a0,a0,-1240 # 80029cb0 <syscalls+0x760>
    80025190:	ffffb097          	auipc	ra,0xffffb
    80025194:	f46080e7          	jalr	-186(ra) # 800200d6 <panic>

0000000080025198 <eread>:
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    80025198:	10852783          	lw	a5,264(a0)
    8002519c:	0ed7e763          	bltu	a5,a3,8002528a <eread+0xf2>
{
    800251a0:	711d                	addi	sp,sp,-96
    800251a2:	ec86                	sd	ra,88(sp)
    800251a4:	e8a2                	sd	s0,80(sp)
    800251a6:	e4a6                	sd	s1,72(sp)
    800251a8:	e0ca                	sd	s2,64(sp)
    800251aa:	fc4e                	sd	s3,56(sp)
    800251ac:	f852                	sd	s4,48(sp)
    800251ae:	f456                	sd	s5,40(sp)
    800251b0:	f05a                	sd	s6,32(sp)
    800251b2:	ec5e                	sd	s7,24(sp)
    800251b4:	e862                	sd	s8,16(sp)
    800251b6:	e466                	sd	s9,8(sp)
    800251b8:	e06a                	sd	s10,0(sp)
    800251ba:	1080                	addi	s0,sp,96
    800251bc:	8a2a                	mv	s4,a0
    800251be:	8bae                	mv	s7,a1
    800251c0:	8ab2                	mv	s5,a2
    800251c2:	8936                	mv	s2,a3
    800251c4:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    800251c6:	9eb9                	addw	a3,a3,a4
        return 0;
    800251c8:	4501                	li	a0,0
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
    800251ca:	0b26e063          	bltu	a3,s2,8002526a <eread+0xd2>
    800251ce:	100a4703          	lbu	a4,256(s4)
    800251d2:	8b41                	andi	a4,a4,16
    800251d4:	eb59                	bnez	a4,8002526a <eread+0xd2>
    if (off + n > entry->file_size) {
    800251d6:	00d7f463          	bgeu	a5,a3,800251de <eread+0x46>
        n = entry->file_size - off;
    800251da:	41278b3b          	subw	s6,a5,s2
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    800251de:	10ca2703          	lw	a4,268(s4)
    800251e2:	100007b7          	lui	a5,0x10000
    800251e6:	17dd                	addi	a5,a5,-9
    800251e8:	06e7ee63          	bltu	a5,a4,80025264 <eread+0xcc>
    800251ec:	080b0d63          	beqz	s6,80025286 <eread+0xee>
    800251f0:	4981                	li	s3,0
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    800251f2:	00016c97          	auipc	s9,0x16
    800251f6:	f46c8c93          	addi	s9,s9,-186 # 8003b138 <fat>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    800251fa:	8c3e                	mv	s8,a5
    800251fc:	a82d                	j	80025236 <eread+0x9e>
    800251fe:	00048d1b          	sext.w	s10,s1
        if (rw_clus(entry->cur_clus, 0, user_dst, dst, off % fat.byts_per_clus, m) != m) {
    80025202:	87ea                	mv	a5,s10
    80025204:	86d6                	mv	a3,s5
    80025206:	865e                	mv	a2,s7
    80025208:	4581                	li	a1,0
    8002520a:	10ca2503          	lw	a0,268(s4)
    8002520e:	00000097          	auipc	ra,0x0
    80025212:	c86080e7          	jalr	-890(ra) # 80024e94 <rw_clus>
    80025216:	2501                	sext.w	a0,a0
    80025218:	05a51763          	bne	a0,s10,80025266 <eread+0xce>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    8002521c:	013489bb          	addw	s3,s1,s3
    80025220:	0124893b          	addw	s2,s1,s2
    80025224:	1482                	slli	s1,s1,0x20
    80025226:	9081                	srli	s1,s1,0x20
    80025228:	9aa6                	add	s5,s5,s1
    8002522a:	10ca2783          	lw	a5,268(s4)
    8002522e:	02fc6c63          	bltu	s8,a5,80025266 <eread+0xce>
    80025232:	0369fa63          	bgeu	s3,s6,80025266 <eread+0xce>
        reloc_clus(entry, off);
    80025236:	85ca                	mv	a1,s2
    80025238:	8552                	mv	a0,s4
    8002523a:	00000097          	auipc	ra,0x0
    8002523e:	9f2080e7          	jalr	-1550(ra) # 80024c2c <reloc_clus>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    80025242:	00cca783          	lw	a5,12(s9)
    80025246:	02f976bb          	remuw	a3,s2,a5
    8002524a:	0006871b          	sext.w	a4,a3
    8002524e:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    80025250:	413b06bb          	subw	a3,s6,s3
    80025254:	84b6                	mv	s1,a3
    80025256:	2681                	sext.w	a3,a3
    80025258:	0007861b          	sext.w	a2,a5
    8002525c:	fad671e3          	bgeu	a2,a3,800251fe <eread+0x66>
    80025260:	84be                	mv	s1,a5
    80025262:	bf71                	j	800251fe <eread+0x66>
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025264:	4981                	li	s3,0
    return tot;
    80025266:	0009851b          	sext.w	a0,s3
}
    8002526a:	60e6                	ld	ra,88(sp)
    8002526c:	6446                	ld	s0,80(sp)
    8002526e:	64a6                	ld	s1,72(sp)
    80025270:	6906                	ld	s2,64(sp)
    80025272:	79e2                	ld	s3,56(sp)
    80025274:	7a42                	ld	s4,48(sp)
    80025276:	7aa2                	ld	s5,40(sp)
    80025278:	7b02                	ld	s6,32(sp)
    8002527a:	6be2                	ld	s7,24(sp)
    8002527c:	6c42                	ld	s8,16(sp)
    8002527e:	6ca2                	ld	s9,8(sp)
    80025280:	6d02                	ld	s10,0(sp)
    80025282:	6125                	addi	sp,sp,96
    80025284:	8082                	ret
    for (tot = 0; entry->cur_clus < FAT32_EOC && tot < n; tot += m, off += m, dst += m) {
    80025286:	89da                	mv	s3,s6
    80025288:	bff9                	j	80025266 <eread+0xce>
        return 0;
    8002528a:	4501                	li	a0,0
}
    8002528c:	8082                	ret

000000008002528e <edup>:
    eunlock(ep);
    return ep;
}

struct dirent *edup(struct dirent *entry)
{
    8002528e:	1101                	addi	sp,sp,-32
    80025290:	ec06                	sd	ra,24(sp)
    80025292:	e822                	sd	s0,16(sp)
    80025294:	e426                	sd	s1,8(sp)
    80025296:	1000                	addi	s0,sp,32
    80025298:	84aa                	mv	s1,a0
    if (entry != 0) {
    8002529a:	c515                	beqz	a0,800252c6 <edup+0x38>
        acquire(&ecache.lock);
    8002529c:	00016517          	auipc	a0,0x16
    800252a0:	02c50513          	addi	a0,a0,44 # 8003b2c8 <ecache>
    800252a4:	ffffb097          	auipc	ra,0xffffb
    800252a8:	298080e7          	jalr	664(ra) # 8002053c <acquire>
        entry->ref++;
    800252ac:	1184a783          	lw	a5,280(s1)
    800252b0:	2785                	addiw	a5,a5,1
    800252b2:	10f4ac23          	sw	a5,280(s1)
        release(&ecache.lock);
    800252b6:	00016517          	auipc	a0,0x16
    800252ba:	01250513          	addi	a0,a0,18 # 8003b2c8 <ecache>
    800252be:	ffffb097          	auipc	ra,0xffffb
    800252c2:	332080e7          	jalr	818(ra) # 800205f0 <release>
    }
    return entry;
}
    800252c6:	8526                	mv	a0,s1
    800252c8:	60e2                	ld	ra,24(sp)
    800252ca:	6442                	ld	s0,16(sp)
    800252cc:	64a2                	ld	s1,8(sp)
    800252ce:	6105                	addi	sp,sp,32
    800252d0:	8082                	ret

00000000800252d2 <eget>:
{
    800252d2:	7179                	addi	sp,sp,-48
    800252d4:	f406                	sd	ra,40(sp)
    800252d6:	f022                	sd	s0,32(sp)
    800252d8:	ec26                	sd	s1,24(sp)
    800252da:	e84a                	sd	s2,16(sp)
    800252dc:	e44e                	sd	s3,8(sp)
    800252de:	e052                	sd	s4,0(sp)
    800252e0:	1800                	addi	s0,sp,48
    800252e2:	892a                	mv	s2,a0
    800252e4:	8a2e                	mv	s4,a1
    acquire(&ecache.lock);
    800252e6:	00016517          	auipc	a0,0x16
    800252ea:	fe250513          	addi	a0,a0,-30 # 8003b2c8 <ecache>
    800252ee:	ffffb097          	auipc	ra,0xffffb
    800252f2:	24e080e7          	jalr	590(ra) # 8002053c <acquire>
    if (name) {
    800252f6:	060a0863          	beqz	s4,80025366 <eget+0x94>
        for (ep = root.next; ep != &root; ep = ep->next) {
    800252fa:	00016797          	auipc	a5,0x16
    800252fe:	e3e78793          	addi	a5,a5,-450 # 8003b138 <fat>
    80025302:	1507b483          	ld	s1,336(a5)
    80025306:	00016797          	auipc	a5,0x16
    8002530a:	e5a78793          	addi	a5,a5,-422 # 8003b160 <root>
    8002530e:	04f48c63          	beq	s1,a5,80025366 <eget+0x94>
    80025312:	89be                	mv	s3,a5
    80025314:	a029                	j	8002531e <eget+0x4c>
    80025316:	1284b483          	ld	s1,296(s1)
    8002531a:	05348663          	beq	s1,s3,80025366 <eget+0x94>
            if (ep->parent == parent && strncmp(ep->filename, name, FAT32_MAX_FILENAME) == 0) {
    8002531e:	1204b783          	ld	a5,288(s1)
    80025322:	ff279ae3          	bne	a5,s2,80025316 <eget+0x44>
    80025326:	0ff00613          	li	a2,255
    8002532a:	85d2                	mv	a1,s4
    8002532c:	8526                	mv	a0,s1
    8002532e:	ffffb097          	auipc	ra,0xffffb
    80025332:	3f2080e7          	jalr	1010(ra) # 80020720 <strncmp>
    80025336:	f165                	bnez	a0,80025316 <eget+0x44>
                ep->ref++;
    80025338:	1184a783          	lw	a5,280(s1)
    8002533c:	2785                	addiw	a5,a5,1
    8002533e:	10f4ac23          	sw	a5,280(s1)
                ep->valid = 1;
    80025342:	4785                	li	a5,1
    80025344:	10f48b23          	sb	a5,278(s1)
                release(&ecache.lock);
    80025348:	00016517          	auipc	a0,0x16
    8002534c:	f8050513          	addi	a0,a0,-128 # 8003b2c8 <ecache>
    80025350:	ffffb097          	auipc	ra,0xffffb
    80025354:	2a0080e7          	jalr	672(ra) # 800205f0 <release>
                edup(ep->parent);
    80025358:	1204b503          	ld	a0,288(s1)
    8002535c:	00000097          	auipc	ra,0x0
    80025360:	f32080e7          	jalr	-206(ra) # 8002528e <edup>
                return ep;
    80025364:	a8b1                	j	800253c0 <eget+0xee>
    for (ep = root.prev; ep != &root; ep = ep->prev) {
    80025366:	00016797          	auipc	a5,0x16
    8002536a:	dd278793          	addi	a5,a5,-558 # 8003b138 <fat>
    8002536e:	1587b483          	ld	s1,344(a5)
    80025372:	00016797          	auipc	a5,0x16
    80025376:	dee78793          	addi	a5,a5,-530 # 8003b160 <root>
    8002537a:	04f48c63          	beq	s1,a5,800253d2 <eget+0x100>
        if (ep->ref == 0) {
    8002537e:	1184a783          	lw	a5,280(s1)
    80025382:	cf81                	beqz	a5,8002539a <eget+0xc8>
    for (ep = root.prev; ep != &root; ep = ep->prev) {
    80025384:	00016717          	auipc	a4,0x16
    80025388:	ddc70713          	addi	a4,a4,-548 # 8003b160 <root>
    8002538c:	1304b483          	ld	s1,304(s1)
    80025390:	04e48163          	beq	s1,a4,800253d2 <eget+0x100>
        if (ep->ref == 0) {
    80025394:	1184a783          	lw	a5,280(s1)
    80025398:	fbf5                	bnez	a5,8002538c <eget+0xba>
            ep->ref = 1;
    8002539a:	4785                	li	a5,1
    8002539c:	10f4ac23          	sw	a5,280(s1)
            ep->dev = parent->dev;
    800253a0:	11494783          	lbu	a5,276(s2)
    800253a4:	10f48a23          	sb	a5,276(s1)
            ep->off = 0;
    800253a8:	1004ae23          	sw	zero,284(s1)
            ep->valid = 0;
    800253ac:	10048b23          	sb	zero,278(s1)
            release(&ecache.lock);
    800253b0:	00016517          	auipc	a0,0x16
    800253b4:	f1850513          	addi	a0,a0,-232 # 8003b2c8 <ecache>
    800253b8:	ffffb097          	auipc	ra,0xffffb
    800253bc:	238080e7          	jalr	568(ra) # 800205f0 <release>
}
    800253c0:	8526                	mv	a0,s1
    800253c2:	70a2                	ld	ra,40(sp)
    800253c4:	7402                	ld	s0,32(sp)
    800253c6:	64e2                	ld	s1,24(sp)
    800253c8:	6942                	ld	s2,16(sp)
    800253ca:	69a2                	ld	s3,8(sp)
    800253cc:	6a02                	ld	s4,0(sp)
    800253ce:	6145                	addi	sp,sp,48
    800253d0:	8082                	ret
    panic("eget: insufficient ecache");
    800253d2:	00005517          	auipc	a0,0x5
    800253d6:	90650513          	addi	a0,a0,-1786 # 80029cd8 <syscalls+0x788>
    800253da:	ffffb097          	auipc	ra,0xffffb
    800253de:	cfc080e7          	jalr	-772(ra) # 800200d6 <panic>

00000000800253e2 <eupdate>:

void eupdate(struct dirent *entry)
{
    if (!entry->dirty) { return; }
    800253e2:	11554783          	lbu	a5,277(a0)
    800253e6:	e391                	bnez	a5,800253ea <eupdate+0x8>
    800253e8:	8082                	ret
{
    800253ea:	715d                	addi	sp,sp,-80
    800253ec:	e486                	sd	ra,72(sp)
    800253ee:	e0a2                	sd	s0,64(sp)
    800253f0:	fc26                	sd	s1,56(sp)
    800253f2:	f84a                	sd	s2,48(sp)
    800253f4:	f44e                	sd	s3,40(sp)
    800253f6:	f052                	sd	s4,32(sp)
    800253f8:	ec56                	sd	s5,24(sp)
    800253fa:	0880                	addi	s0,sp,80
    800253fc:	89aa                	mv	s3,a0
    printf("[eupdate] %s\n", entry->filename);
    800253fe:	85aa                	mv	a1,a0
    80025400:	00005517          	auipc	a0,0x5
    80025404:	8f850513          	addi	a0,a0,-1800 # 80029cf8 <syscalls+0x7a8>
    80025408:	ffffb097          	auipc	ra,0xffffb
    8002540c:	d10080e7          	jalr	-752(ra) # 80020118 <printf>
    uint entcnt;
    uint32 clus = entry->parent->first_clus;
    80025410:	1209b783          	ld	a5,288(s3)
    80025414:	1047a903          	lw	s2,260(a5)
    uint32 off = entry->off % fat.byts_per_clus;
    80025418:	11c9a703          	lw	a4,284(s3)
    8002541c:	00016797          	auipc	a5,0x16
    80025420:	d1c78793          	addi	a5,a5,-740 # 8003b138 <fat>
    80025424:	47dc                	lw	a5,12(a5)
    80025426:	02f77a3b          	remuw	s4,a4,a5
    8002542a:	000a0a9b          	sext.w	s5,s4
    for (uint clus_cnt = entry->off / fat.byts_per_clus; clus_cnt > 0; clus_cnt--) {
    8002542e:	02f754bb          	divuw	s1,a4,a5
    80025432:	00f76b63          	bltu	a4,a5,80025448 <eupdate+0x66>
        clus = read_fat(clus);
    80025436:	854a                	mv	a0,s2
    80025438:	fffff097          	auipc	ra,0xfffff
    8002543c:	782080e7          	jalr	1922(ra) # 80024bba <read_fat>
    80025440:	0005091b          	sext.w	s2,a0
    for (uint clus_cnt = entry->off / fat.byts_per_clus; clus_cnt > 0; clus_cnt--) {
    80025444:	34fd                	addiw	s1,s1,-1
    80025446:	f8e5                	bnez	s1,80025436 <eupdate+0x54>
    }
    rw_clus(clus, 0, 0, (uint64) &entcnt, off, 1);
    80025448:	4785                	li	a5,1
    8002544a:	8756                	mv	a4,s5
    8002544c:	fbc40693          	addi	a3,s0,-68
    80025450:	4601                	li	a2,0
    80025452:	4581                	li	a1,0
    80025454:	854a                	mv	a0,s2
    80025456:	00000097          	auipc	ra,0x0
    8002545a:	a3e080e7          	jalr	-1474(ra) # 80024e94 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    8002545e:	fbc42783          	lw	a5,-68(s0)
    80025462:	fbf7f793          	andi	a5,a5,-65
    80025466:	faf42e23          	sw	a5,-68(s0)
    off += (entcnt << 5);
    8002546a:	0057979b          	slliw	a5,a5,0x5
    8002546e:	014784bb          	addw	s1,a5,s4
    80025472:	00048a1b          	sext.w	s4,s1
    if (off / fat.byts_per_clus != 0) {
    80025476:	00016797          	auipc	a5,0x16
    8002547a:	cc278793          	addi	a5,a5,-830 # 8003b138 <fat>
    8002547e:	47dc                	lw	a5,12(a5)
    80025480:	08fa7763          	bgeu	s4,a5,8002550e <eupdate+0x12c>
        clus = read_fat(clus);
        off %= fat.byts_per_clus;
    }
    uint16 clus_high = (uint16)(entry->first_clus >> 16);
    80025484:	1049a783          	lw	a5,260(s3)
    80025488:	0107d71b          	srliw	a4,a5,0x10
    8002548c:	fae41d23          	sh	a4,-70(s0)
    uint16 clus_low = (uint16)(entry->first_clus & 0xff);
    80025490:	0ff7f793          	andi	a5,a5,255
    80025494:	faf41c23          	sh	a5,-72(s0)
    rw_clus(clus, 1, 0, (uint64) &entry->attribute, off + 11, sizeof(entry->attribute));
    80025498:	4785                	li	a5,1
    8002549a:	00ba071b          	addiw	a4,s4,11
    8002549e:	10098693          	addi	a3,s3,256
    800254a2:	4601                	li	a2,0
    800254a4:	4585                	li	a1,1
    800254a6:	854a                	mv	a0,s2
    800254a8:	00000097          	auipc	ra,0x0
    800254ac:	9ec080e7          	jalr	-1556(ra) # 80024e94 <rw_clus>
    rw_clus(clus, 1, 0, (uint64) &clus_high, off + 20, sizeof(clus_high));
    800254b0:	4789                	li	a5,2
    800254b2:	014a071b          	addiw	a4,s4,20
    800254b6:	fba40693          	addi	a3,s0,-70
    800254ba:	4601                	li	a2,0
    800254bc:	4585                	li	a1,1
    800254be:	854a                	mv	a0,s2
    800254c0:	00000097          	auipc	ra,0x0
    800254c4:	9d4080e7          	jalr	-1580(ra) # 80024e94 <rw_clus>
    rw_clus(clus, 1, 0, (uint64) &clus_low, off + 26, sizeof(clus_low));
    800254c8:	4789                	li	a5,2
    800254ca:	01aa071b          	addiw	a4,s4,26
    800254ce:	fb840693          	addi	a3,s0,-72
    800254d2:	4601                	li	a2,0
    800254d4:	4585                	li	a1,1
    800254d6:	854a                	mv	a0,s2
    800254d8:	00000097          	auipc	ra,0x0
    800254dc:	9bc080e7          	jalr	-1604(ra) # 80024e94 <rw_clus>
    rw_clus(clus, 1, 0, (uint64) &entry->file_size, off + 28, sizeof(entry->file_size));
    800254e0:	4791                	li	a5,4
    800254e2:	01ca071b          	addiw	a4,s4,28
    800254e6:	10898693          	addi	a3,s3,264
    800254ea:	4601                	li	a2,0
    800254ec:	4585                	li	a1,1
    800254ee:	854a                	mv	a0,s2
    800254f0:	00000097          	auipc	ra,0x0
    800254f4:	9a4080e7          	jalr	-1628(ra) # 80024e94 <rw_clus>
    entry->dirty = 0;
    800254f8:	10098aa3          	sb	zero,277(s3)
}
    800254fc:	60a6                	ld	ra,72(sp)
    800254fe:	6406                	ld	s0,64(sp)
    80025500:	74e2                	ld	s1,56(sp)
    80025502:	7942                	ld	s2,48(sp)
    80025504:	79a2                	ld	s3,40(sp)
    80025506:	7a02                	ld	s4,32(sp)
    80025508:	6ae2                	ld	s5,24(sp)
    8002550a:	6161                	addi	sp,sp,80
    8002550c:	8082                	ret
        clus = read_fat(clus);
    8002550e:	854a                	mv	a0,s2
    80025510:	fffff097          	auipc	ra,0xfffff
    80025514:	6aa080e7          	jalr	1706(ra) # 80024bba <read_fat>
    80025518:	0005091b          	sext.w	s2,a0
        off %= fat.byts_per_clus;
    8002551c:	00016797          	auipc	a5,0x16
    80025520:	c1c78793          	addi	a5,a5,-996 # 8003b138 <fat>
    80025524:	00c7aa03          	lw	s4,12(a5)
    80025528:	0344fa3b          	remuw	s4,s1,s4
    8002552c:	bfa1                	j	80025484 <eupdate+0xa2>

000000008002552e <ewrite>:
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_READ_ONLY)) {
    8002552e:	10852783          	lw	a5,264(a0)
    80025532:	10d7ea63          	bltu	a5,a3,80025646 <ewrite+0x118>
{
    80025536:	711d                	addi	sp,sp,-96
    80025538:	ec86                	sd	ra,88(sp)
    8002553a:	e8a2                	sd	s0,80(sp)
    8002553c:	e4a6                	sd	s1,72(sp)
    8002553e:	e0ca                	sd	s2,64(sp)
    80025540:	fc4e                	sd	s3,56(sp)
    80025542:	f852                	sd	s4,48(sp)
    80025544:	f456                	sd	s5,40(sp)
    80025546:	f05a                	sd	s6,32(sp)
    80025548:	ec5e                	sd	s7,24(sp)
    8002554a:	e862                	sd	s8,16(sp)
    8002554c:	e466                	sd	s9,8(sp)
    8002554e:	e06a                	sd	s10,0(sp)
    80025550:	1080                	addi	s0,sp,96
    80025552:	89aa                	mv	s3,a0
    80025554:	8c2e                	mv	s8,a1
    80025556:	8ab2                	mv	s5,a2
    80025558:	8936                	mv	s2,a3
    8002555a:	8b3a                	mv	s6,a4
    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_READ_ONLY)) {
    8002555c:	00e687bb          	addw	a5,a3,a4
    80025560:	0ed7e563          	bltu	a5,a3,8002564a <ewrite+0x11c>
    80025564:	10054783          	lbu	a5,256(a0)
    80025568:	8b85                	andi	a5,a5,1
    8002556a:	e3f5                	bnez	a5,8002564e <ewrite+0x120>
    if (entry->first_clus == 0) {   // so file_size if 0 too, which requests off == 0
    8002556c:	10452783          	lw	a5,260(a0)
    80025570:	cf89                	beqz	a5,8002558a <ewrite+0x5c>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025572:	4a01                	li	s4,0
        if (entry->cur_clus >= FAT32_EOC) {
    80025574:	10000bb7          	lui	s7,0x10000
    80025578:	1bdd                	addi	s7,s7,-9
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    8002557a:	00016c97          	auipc	s9,0x16
    8002557e:	bbec8c93          	addi	s9,s9,-1090 # 8003b138 <fat>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80025582:	060b1c63          	bnez	s6,800255fa <ewrite+0xcc>
    80025586:	8a5a                	mv	s4,s6
    80025588:	a8c9                	j	8002565a <ewrite+0x12c>
        entry->cur_clus = entry->first_clus = alloc_clus(entry->dev);
    8002558a:	11454503          	lbu	a0,276(a0)
    8002558e:	fffff097          	auipc	ra,0xfffff
    80025592:	740080e7          	jalr	1856(ra) # 80024cce <alloc_clus>
    80025596:	2501                	sext.w	a0,a0
    80025598:	10a9a223          	sw	a0,260(s3)
    8002559c:	10a9a623          	sw	a0,268(s3)
        entry->clus_cnt = 0;
    800255a0:	1009a823          	sw	zero,272(s3)
        entry->dirty = 1;
    800255a4:	4785                	li	a5,1
    800255a6:	10f98aa3          	sb	a5,277(s3)
    800255aa:	b7e1                	j	80025572 <ewrite+0x44>
            uint32 new_clus = alloc_clus(entry->dev);
    800255ac:	1149c503          	lbu	a0,276(s3)
    800255b0:	fffff097          	auipc	ra,0xfffff
    800255b4:	71e080e7          	jalr	1822(ra) # 80024cce <alloc_clus>
            write_fat(entry->cur_clus, new_clus);
    800255b8:	0005059b          	sext.w	a1,a0
    800255bc:	10c9a503          	lw	a0,268(s3)
    800255c0:	00000097          	auipc	ra,0x0
    800255c4:	856080e7          	jalr	-1962(ra) # 80024e16 <write_fat>
    800255c8:	a099                	j	8002560e <ewrite+0xe0>
    800255ca:	00048d1b          	sext.w	s10,s1
        if (rw_clus(entry->cur_clus, 1, user_src, src, off % fat.byts_per_clus, m) != m) {
    800255ce:	87ea                	mv	a5,s10
    800255d0:	86d6                	mv	a3,s5
    800255d2:	8662                	mv	a2,s8
    800255d4:	4585                	li	a1,1
    800255d6:	10c9a503          	lw	a0,268(s3)
    800255da:	00000097          	auipc	ra,0x0
    800255de:	8ba080e7          	jalr	-1862(ra) # 80024e94 <rw_clus>
    800255e2:	2501                	sext.w	a0,a0
    800255e4:	06ad1763          	bne	s10,a0,80025652 <ewrite+0x124>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    800255e8:	01448a3b          	addw	s4,s1,s4
    800255ec:	0124893b          	addw	s2,s1,s2
    800255f0:	1482                	slli	s1,s1,0x20
    800255f2:	9081                	srli	s1,s1,0x20
    800255f4:	9aa6                	add	s5,s5,s1
    800255f6:	056a7e63          	bgeu	s4,s6,80025652 <ewrite+0x124>
        reloc_clus(entry, off);
    800255fa:	85ca                	mv	a1,s2
    800255fc:	854e                	mv	a0,s3
    800255fe:	fffff097          	auipc	ra,0xfffff
    80025602:	62e080e7          	jalr	1582(ra) # 80024c2c <reloc_clus>
        if (entry->cur_clus >= FAT32_EOC) {
    80025606:	10c9a783          	lw	a5,268(s3)
    8002560a:	fafbe1e3          	bltu	s7,a5,800255ac <ewrite+0x7e>
        m = fat.byts_per_clus - off % fat.byts_per_clus;
    8002560e:	00cca783          	lw	a5,12(s9)
    80025612:	02f976bb          	remuw	a3,s2,a5
    80025616:	0006871b          	sext.w	a4,a3
    8002561a:	9f95                	subw	a5,a5,a3
        if (n - tot < m) {
    8002561c:	414b06bb          	subw	a3,s6,s4
    80025620:	84b6                	mv	s1,a3
    80025622:	2681                	sext.w	a3,a3
    80025624:	0007861b          	sext.w	a2,a5
    80025628:	fad671e3          	bgeu	a2,a3,800255ca <ewrite+0x9c>
    8002562c:	84be                	mv	s1,a5
    8002562e:	bf71                	j	800255ca <ewrite+0x9c>
            entry->file_size = off;
    80025630:	1129a423          	sw	s2,264(s3)
            entry->dirty = 1;
    80025634:	4785                	li	a5,1
    80025636:	10f98aa3          	sb	a5,277(s3)
            eupdate(entry);
    8002563a:	854e                	mv	a0,s3
    8002563c:	00000097          	auipc	ra,0x0
    80025640:	da6080e7          	jalr	-602(ra) # 800253e2 <eupdate>
    80025644:	a819                	j	8002565a <ewrite+0x12c>
        return -1;
    80025646:	557d                	li	a0,-1
}
    80025648:	8082                	ret
        return -1;
    8002564a:	557d                	li	a0,-1
    8002564c:	a809                	j	8002565e <ewrite+0x130>
    8002564e:	557d                	li	a0,-1
    80025650:	a039                	j	8002565e <ewrite+0x130>
        if(off > entry->file_size) {
    80025652:	1089a783          	lw	a5,264(s3)
    80025656:	fd27ede3          	bltu	a5,s2,80025630 <ewrite+0x102>
    return tot;
    8002565a:	000a051b          	sext.w	a0,s4
}
    8002565e:	60e6                	ld	ra,88(sp)
    80025660:	6446                	ld	s0,80(sp)
    80025662:	64a6                	ld	s1,72(sp)
    80025664:	6906                	ld	s2,64(sp)
    80025666:	79e2                	ld	s3,56(sp)
    80025668:	7a42                	ld	s4,48(sp)
    8002566a:	7aa2                	ld	s5,40(sp)
    8002566c:	7b02                	ld	s6,32(sp)
    8002566e:	6be2                	ld	s7,24(sp)
    80025670:	6c42                	ld	s8,16(sp)
    80025672:	6ca2                	ld	s9,8(sp)
    80025674:	6d02                	ld	s10,0(sp)
    80025676:	6125                	addi	sp,sp,96
    80025678:	8082                	ret

000000008002567a <etrunc>:

void etrunc(struct dirent *entry)
{
    8002567a:	715d                	addi	sp,sp,-80
    8002567c:	e486                	sd	ra,72(sp)
    8002567e:	e0a2                	sd	s0,64(sp)
    80025680:	fc26                	sd	s1,56(sp)
    80025682:	f84a                	sd	s2,48(sp)
    80025684:	f44e                	sd	s3,40(sp)
    80025686:	f052                	sd	s4,32(sp)
    80025688:	ec56                	sd	s5,24(sp)
    8002568a:	0880                	addi	s0,sp,80
    8002568c:	8aaa                	mv	s5,a0
    uint entcnt;
    uint32 clus = entry->parent->first_clus;
    8002568e:	12053783          	ld	a5,288(a0)
    80025692:	1047a903          	lw	s2,260(a5)
    uint32 off = entry->off % fat.byts_per_clus;
    80025696:	11c52703          	lw	a4,284(a0)
    8002569a:	00016797          	auipc	a5,0x16
    8002569e:	a9e78793          	addi	a5,a5,-1378 # 8003b138 <fat>
    800256a2:	47dc                	lw	a5,12(a5)
    800256a4:	02f774bb          	remuw	s1,a4,a5
    for (uint clus_cnt = entry->off / fat.byts_per_clus; clus_cnt > 0; clus_cnt--) {
    800256a8:	02f759bb          	divuw	s3,a4,a5
    800256ac:	00f76c63          	bltu	a4,a5,800256c4 <etrunc+0x4a>
        clus = read_fat(clus);
    800256b0:	854a                	mv	a0,s2
    800256b2:	fffff097          	auipc	ra,0xfffff
    800256b6:	508080e7          	jalr	1288(ra) # 80024bba <read_fat>
    800256ba:	0005091b          	sext.w	s2,a0
    for (uint clus_cnt = entry->off / fat.byts_per_clus; clus_cnt > 0; clus_cnt--) {
    800256be:	39fd                	addiw	s3,s3,-1
    800256c0:	fe0998e3          	bnez	s3,800256b0 <etrunc+0x36>
    }
    rw_clus(clus, 0, 0, (uint64) &entcnt, off, 1);
    800256c4:	4785                	li	a5,1
    800256c6:	8726                	mv	a4,s1
    800256c8:	fbc40693          	addi	a3,s0,-68
    800256cc:	4601                	li	a2,0
    800256ce:	4581                	li	a1,0
    800256d0:	854a                	mv	a0,s2
    800256d2:	fffff097          	auipc	ra,0xfffff
    800256d6:	7c2080e7          	jalr	1986(ra) # 80024e94 <rw_clus>
    entcnt &= ~LAST_LONG_ENTRY;
    800256da:	fbc42783          	lw	a5,-68(s0)
    800256de:	fbf7f793          	andi	a5,a5,-65
    800256e2:	faf42e23          	sw	a5,-68(s0)
    uint8 flag = EMPTY_ENTRY;
    800256e6:	5795                	li	a5,-27
    800256e8:	faf40da3          	sb	a5,-69(s0)
    for (int i = 0; i <= entcnt; i++) {
    800256ec:	4981                	li	s3,0
        rw_clus(clus, 1, 0, (uint64) &flag, off, 1);
        off += 32;
        if (off / fat.byts_per_clus != 0) {
    800256ee:	00016a17          	auipc	s4,0x16
    800256f2:	a4aa0a13          	addi	s4,s4,-1462 # 8003b138 <fat>
    800256f6:	a015                	j	8002571a <etrunc+0xa0>
            off %= fat.byts_per_clus;
    800256f8:	02f774bb          	remuw	s1,a4,a5
            clus = read_fat(clus);
    800256fc:	854a                	mv	a0,s2
    800256fe:	fffff097          	auipc	ra,0xfffff
    80025702:	4bc080e7          	jalr	1212(ra) # 80024bba <read_fat>
    80025706:	0005091b          	sext.w	s2,a0
    for (int i = 0; i <= entcnt; i++) {
    8002570a:	0019879b          	addiw	a5,s3,1
    8002570e:	0007899b          	sext.w	s3,a5
    80025712:	fbc42703          	lw	a4,-68(s0)
    80025716:	03376663          	bltu	a4,s3,80025742 <etrunc+0xc8>
        rw_clus(clus, 1, 0, (uint64) &flag, off, 1);
    8002571a:	4785                	li	a5,1
    8002571c:	8726                	mv	a4,s1
    8002571e:	fbb40693          	addi	a3,s0,-69
    80025722:	4601                	li	a2,0
    80025724:	4585                	li	a1,1
    80025726:	854a                	mv	a0,s2
    80025728:	fffff097          	auipc	ra,0xfffff
    8002572c:	76c080e7          	jalr	1900(ra) # 80024e94 <rw_clus>
        off += 32;
    80025730:	0204871b          	addiw	a4,s1,32
    80025734:	0007049b          	sext.w	s1,a4
        if (off / fat.byts_per_clus != 0) {
    80025738:	00ca2783          	lw	a5,12(s4)
    8002573c:	fcf4e7e3          	bltu	s1,a5,8002570a <etrunc+0x90>
    80025740:	bf65                	j	800256f8 <etrunc+0x7e>
        }
    }
    entry->valid = 0;
    80025742:	100a8b23          	sb	zero,278(s5)
    for (clus = entry->first_clus; clus < FAT32_EOC; ) {
    80025746:	104aa483          	lw	s1,260(s5)
    8002574a:	100007b7          	lui	a5,0x10000
    8002574e:	17dd                	addi	a5,a5,-9
    80025750:	0297e463          	bltu	a5,s1,80025778 <etrunc+0xfe>
    80025754:	89be                	mv	s3,a5
        uint32 next = read_fat(clus);
    80025756:	8526                	mv	a0,s1
    80025758:	fffff097          	auipc	ra,0xfffff
    8002575c:	462080e7          	jalr	1122(ra) # 80024bba <read_fat>
    80025760:	0005091b          	sext.w	s2,a0
    write_fat(cluster, 0);
    80025764:	4581                	li	a1,0
    80025766:	8526                	mv	a0,s1
    80025768:	fffff097          	auipc	ra,0xfffff
    8002576c:	6ae080e7          	jalr	1710(ra) # 80024e16 <write_fat>
        free_clus(clus);
        clus = next;
    80025770:	0009049b          	sext.w	s1,s2
    for (clus = entry->first_clus; clus < FAT32_EOC; ) {
    80025774:	ff29f1e3          	bgeu	s3,s2,80025756 <etrunc+0xdc>
    }
}
    80025778:	60a6                	ld	ra,72(sp)
    8002577a:	6406                	ld	s0,64(sp)
    8002577c:	74e2                	ld	s1,56(sp)
    8002577e:	7942                	ld	s2,48(sp)
    80025780:	79a2                	ld	s3,40(sp)
    80025782:	7a02                	ld	s4,32(sp)
    80025784:	6ae2                	ld	s5,24(sp)
    80025786:	6161                	addi	sp,sp,80
    80025788:	8082                	ret

000000008002578a <elock>:

void elock(struct dirent *entry)
{
    8002578a:	1141                	addi	sp,sp,-16
    8002578c:	e406                	sd	ra,8(sp)
    8002578e:	e022                	sd	s0,0(sp)
    80025790:	0800                	addi	s0,sp,16
    if (entry == 0 || entry->ref < 1)
    80025792:	cd19                	beqz	a0,800257b0 <elock+0x26>
    80025794:	11852783          	lw	a5,280(a0)
    80025798:	00f05c63          	blez	a5,800257b0 <elock+0x26>
        panic("elock");
    acquiresleep(&entry->lock);
    8002579c:	13850513          	addi	a0,a0,312
    800257a0:	ffffd097          	auipc	ra,0xffffd
    800257a4:	670080e7          	jalr	1648(ra) # 80022e10 <acquiresleep>
}
    800257a8:	60a2                	ld	ra,8(sp)
    800257aa:	6402                	ld	s0,0(sp)
    800257ac:	0141                	addi	sp,sp,16
    800257ae:	8082                	ret
        panic("elock");
    800257b0:	00004517          	auipc	a0,0x4
    800257b4:	55850513          	addi	a0,a0,1368 # 80029d08 <syscalls+0x7b8>
    800257b8:	ffffb097          	auipc	ra,0xffffb
    800257bc:	91e080e7          	jalr	-1762(ra) # 800200d6 <panic>

00000000800257c0 <eunlock>:

void eunlock(struct dirent *entry)
{
    800257c0:	1101                	addi	sp,sp,-32
    800257c2:	ec06                	sd	ra,24(sp)
    800257c4:	e822                	sd	s0,16(sp)
    800257c6:	e426                	sd	s1,8(sp)
    800257c8:	e04a                	sd	s2,0(sp)
    800257ca:	1000                	addi	s0,sp,32
    if (entry == 0 || !holdingsleep(&entry->lock) || entry->ref < 1)
    800257cc:	c90d                	beqz	a0,800257fe <eunlock+0x3e>
    800257ce:	84aa                	mv	s1,a0
    800257d0:	13850913          	addi	s2,a0,312
    800257d4:	854a                	mv	a0,s2
    800257d6:	ffffd097          	auipc	ra,0xffffd
    800257da:	6d4080e7          	jalr	1748(ra) # 80022eaa <holdingsleep>
    800257de:	c105                	beqz	a0,800257fe <eunlock+0x3e>
    800257e0:	1184a783          	lw	a5,280(s1)
    800257e4:	00f05d63          	blez	a5,800257fe <eunlock+0x3e>
        panic("eunlock");
    releasesleep(&entry->lock);
    800257e8:	854a                	mv	a0,s2
    800257ea:	ffffd097          	auipc	ra,0xffffd
    800257ee:	67c080e7          	jalr	1660(ra) # 80022e66 <releasesleep>
}
    800257f2:	60e2                	ld	ra,24(sp)
    800257f4:	6442                	ld	s0,16(sp)
    800257f6:	64a2                	ld	s1,8(sp)
    800257f8:	6902                	ld	s2,0(sp)
    800257fa:	6105                	addi	sp,sp,32
    800257fc:	8082                	ret
        panic("eunlock");
    800257fe:	00004517          	auipc	a0,0x4
    80025802:	51250513          	addi	a0,a0,1298 # 80029d10 <syscalls+0x7c0>
    80025806:	ffffb097          	auipc	ra,0xffffb
    8002580a:	8d0080e7          	jalr	-1840(ra) # 800200d6 <panic>

000000008002580e <eput>:

void eput(struct dirent *entry)
{
    8002580e:	1101                	addi	sp,sp,-32
    80025810:	ec06                	sd	ra,24(sp)
    80025812:	e822                	sd	s0,16(sp)
    80025814:	e426                	sd	s1,8(sp)
    80025816:	e04a                	sd	s2,0(sp)
    80025818:	1000                	addi	s0,sp,32
    8002581a:	84aa                	mv	s1,a0
    acquire(&ecache.lock);
    8002581c:	00016517          	auipc	a0,0x16
    80025820:	aac50513          	addi	a0,a0,-1364 # 8003b2c8 <ecache>
    80025824:	ffffb097          	auipc	ra,0xffffb
    80025828:	d18080e7          	jalr	-744(ra) # 8002053c <acquire>
    if (entry->valid && entry->ref == 1) {
    8002582c:	1164c783          	lbu	a5,278(s1)
    80025830:	c791                	beqz	a5,8002583c <eput+0x2e>
    80025832:	1184a703          	lw	a4,280(s1)
    80025836:	4785                	li	a5,1
    80025838:	02f70563          	beq	a4,a5,80025862 <eput+0x54>
            eput(entry->parent);
        }
        releasesleep(&entry->lock);
        acquire(&ecache.lock);
    }
    entry->ref--;
    8002583c:	1184a783          	lw	a5,280(s1)
    80025840:	37fd                	addiw	a5,a5,-1
    80025842:	10f4ac23          	sw	a5,280(s1)
    release(&ecache.lock);
    80025846:	00016517          	auipc	a0,0x16
    8002584a:	a8250513          	addi	a0,a0,-1406 # 8003b2c8 <ecache>
    8002584e:	ffffb097          	auipc	ra,0xffffb
    80025852:	da2080e7          	jalr	-606(ra) # 800205f0 <release>
}
    80025856:	60e2                	ld	ra,24(sp)
    80025858:	6442                	ld	s0,16(sp)
    8002585a:	64a2                	ld	s1,8(sp)
    8002585c:	6902                	ld	s2,0(sp)
    8002585e:	6105                	addi	sp,sp,32
    80025860:	8082                	ret
        acquiresleep(&entry->lock);
    80025862:	13848913          	addi	s2,s1,312
    80025866:	854a                	mv	a0,s2
    80025868:	ffffd097          	auipc	ra,0xffffd
    8002586c:	5a8080e7          	jalr	1448(ra) # 80022e10 <acquiresleep>
        release(&ecache.lock);
    80025870:	00016517          	auipc	a0,0x16
    80025874:	a5850513          	addi	a0,a0,-1448 # 8003b2c8 <ecache>
    80025878:	ffffb097          	auipc	ra,0xffffb
    8002587c:	d78080e7          	jalr	-648(ra) # 800205f0 <release>
        if (entry != &root) {
    80025880:	00016797          	auipc	a5,0x16
    80025884:	8e078793          	addi	a5,a5,-1824 # 8003b160 <root>
    80025888:	04f48963          	beq	s1,a5,800258da <eput+0xcc>
            entry->next->prev = entry->prev;
    8002588c:	1284b703          	ld	a4,296(s1)
    80025890:	1304b783          	ld	a5,304(s1)
    80025894:	12f73823          	sd	a5,304(a4)
            entry->prev->next = entry->next;
    80025898:	1284b703          	ld	a4,296(s1)
    8002589c:	12e7b423          	sd	a4,296(a5)
            entry->next = root.next;
    800258a0:	00016797          	auipc	a5,0x16
    800258a4:	89878793          	addi	a5,a5,-1896 # 8003b138 <fat>
    800258a8:	1507b703          	ld	a4,336(a5)
    800258ac:	12e4b423          	sd	a4,296(s1)
            entry->prev = &root;
    800258b0:	00016697          	auipc	a3,0x16
    800258b4:	8b068693          	addi	a3,a3,-1872 # 8003b160 <root>
    800258b8:	12d4b823          	sd	a3,304(s1)
            root.next->prev = entry;
    800258bc:	12973823          	sd	s1,304(a4)
            root.next = entry;
    800258c0:	1497b823          	sd	s1,336(a5)
            eupdate(entry);
    800258c4:	8526                	mv	a0,s1
    800258c6:	00000097          	auipc	ra,0x0
    800258ca:	b1c080e7          	jalr	-1252(ra) # 800253e2 <eupdate>
            eput(entry->parent);
    800258ce:	1204b503          	ld	a0,288(s1)
    800258d2:	00000097          	auipc	ra,0x0
    800258d6:	f3c080e7          	jalr	-196(ra) # 8002580e <eput>
        releasesleep(&entry->lock);
    800258da:	854a                	mv	a0,s2
    800258dc:	ffffd097          	auipc	ra,0xffffd
    800258e0:	58a080e7          	jalr	1418(ra) # 80022e66 <releasesleep>
        acquire(&ecache.lock);
    800258e4:	00016517          	auipc	a0,0x16
    800258e8:	9e450513          	addi	a0,a0,-1564 # 8003b2c8 <ecache>
    800258ec:	ffffb097          	auipc	ra,0xffffb
    800258f0:	c50080e7          	jalr	-944(ra) # 8002053c <acquire>
    800258f4:	b7a1                	j	8002583c <eput+0x2e>

00000000800258f6 <estat>:

void estat(struct dirent *entry, struct stat *st)
{
    800258f6:	1101                	addi	sp,sp,-32
    800258f8:	ec06                	sd	ra,24(sp)
    800258fa:	e822                	sd	s0,16(sp)
    800258fc:	e426                	sd	s1,8(sp)
    800258fe:	e04a                	sd	s2,0(sp)
    80025900:	1000                	addi	s0,sp,32
    80025902:	892a                	mv	s2,a0
    80025904:	84ae                	mv	s1,a1
    strncpy(st->name, entry->filename, STAT_MAX_NAME);
    80025906:	02000613          	li	a2,32
    8002590a:	85aa                	mv	a1,a0
    8002590c:	8526                	mv	a0,s1
    8002590e:	ffffb097          	auipc	ra,0xffffb
    80025912:	e62080e7          	jalr	-414(ra) # 80020770 <strncpy>
    st->type = (entry->attribute & ATTR_DIRECTORY) ? T_DIR : T_FILE;
    80025916:	10094783          	lbu	a5,256(s2)
    8002591a:	8bc1                	andi	a5,a5,16
    8002591c:	0017b793          	seqz	a5,a5
    80025920:	0785                	addi	a5,a5,1
    80025922:	02f49423          	sh	a5,40(s1)
    st->dev = entry->dev;
    80025926:	11494783          	lbu	a5,276(s2)
    8002592a:	d0dc                	sw	a5,36(s1)
    st->size = entry->file_size;
    8002592c:	10896783          	lwu	a5,264(s2)
    80025930:	f89c                	sd	a5,48(s1)
}
    80025932:	60e2                	ld	ra,24(sp)
    80025934:	6442                	ld	s0,16(sp)
    80025936:	64a2                	ld	s1,8(sp)
    80025938:	6902                	ld	s2,0(sp)
    8002593a:	6105                	addi	sp,sp,32
    8002593c:	8082                	ret

000000008002593e <enext>:
 * Read a directory from off
 * 
 * 
 */
int enext(struct dirent *dp, struct dirent *ep, uint off, int *count)
{
    8002593e:	7119                	addi	sp,sp,-128
    80025940:	fc86                	sd	ra,120(sp)
    80025942:	f8a2                	sd	s0,112(sp)
    80025944:	f4a6                	sd	s1,104(sp)
    80025946:	f0ca                	sd	s2,96(sp)
    80025948:	ecce                	sd	s3,88(sp)
    8002594a:	e8d2                	sd	s4,80(sp)
    8002594c:	e4d6                	sd	s5,72(sp)
    8002594e:	e0da                	sd	s6,64(sp)
    80025950:	fc5e                	sd	s7,56(sp)
    80025952:	f862                	sd	s8,48(sp)
    80025954:	f466                	sd	s9,40(sp)
    80025956:	f06a                	sd	s10,32(sp)
    80025958:	0100                	addi	s0,sp,128
    if (!(dp->attribute & ATTR_DIRECTORY))
    8002595a:	10054783          	lbu	a5,256(a0)
    8002595e:	8bc1                	andi	a5,a5,16
    80025960:	cba9                	beqz	a5,800259b2 <enext+0x74>
    80025962:	89aa                	mv	s3,a0
    80025964:	8d2e                	mv	s10,a1
    80025966:	84b2                	mv	s1,a2
    80025968:	8bb6                	mv	s7,a3
        panic("enext not dir");
    if (ep->valid)
    8002596a:	1165c783          	lbu	a5,278(a1)
    8002596e:	ebb1                	bnez	a5,800259c2 <enext+0x84>
        panic("enext ep valid");
    if (off % 32)
    80025970:	01f67793          	andi	a5,a2,31
    80025974:	efb9                	bnez	a5,800259d2 <enext+0x94>
        panic("enext not align");

    uint8 ebuf[32];
    int cnt = 0;
    memset(ep->filename, 0, FAT32_MAX_FILENAME + 1);
    80025976:	8cae                	mv	s9,a1
    80025978:	10000613          	li	a2,256
    8002597c:	4581                	li	a1,0
    8002597e:	856a                	mv	a0,s10
    80025980:	ffffb097          	auipc	ra,0xffffb
    80025984:	cb8080e7          	jalr	-840(ra) # 80020638 <memset>
    for (uint off2 = reloc_clus(dp, off); dp->cur_clus < FAT32_EOC; off2 = reloc_clus(dp, off2 + 32)) {
    80025988:	85a6                	mv	a1,s1
    8002598a:	854e                	mv	a0,s3
    8002598c:	fffff097          	auipc	ra,0xfffff
    80025990:	2a0080e7          	jalr	672(ra) # 80024c2c <reloc_clus>
    80025994:	0005091b          	sext.w	s2,a0
    80025998:	10c9a503          	lw	a0,268(s3)
    8002599c:	100007b7          	lui	a5,0x10000
    800259a0:	17dd                	addi	a5,a5,-9
    800259a2:	1aa7e863          	bltu	a5,a0,80025b52 <enext+0x214>
    int cnt = 0;
    800259a6:	4a01                	li	s4,0
        if (rw_clus(dp->cur_clus, 0, 0, (uint64)ebuf, off2, 32) != 32 || ebuf[0] == END_OF_ENTRY) {
            return -1;
        }
        if (ebuf[0] == EMPTY_ENTRY) {
    800259a8:	0e500b13          	li	s6,229
            continue;
        } else if (cnt) {
            *count = cnt;
            return 0;
        }
        if (ebuf[11] == ATTR_LONG_NAME) {
    800259ac:	4c3d                	li	s8,15
    for (uint off2 = reloc_clus(dp, off); dp->cur_clus < FAT32_EOC; off2 = reloc_clus(dp, off2 + 32)) {
    800259ae:	8abe                	mv	s5,a5
    800259b0:	a879                	j	80025a4e <enext+0x110>
        panic("enext not dir");
    800259b2:	00004517          	auipc	a0,0x4
    800259b6:	36650513          	addi	a0,a0,870 # 80029d18 <syscalls+0x7c8>
    800259ba:	ffffa097          	auipc	ra,0xffffa
    800259be:	71c080e7          	jalr	1820(ra) # 800200d6 <panic>
        panic("enext ep valid");
    800259c2:	00004517          	auipc	a0,0x4
    800259c6:	36650513          	addi	a0,a0,870 # 80029d28 <syscalls+0x7d8>
    800259ca:	ffffa097          	auipc	ra,0xffffa
    800259ce:	70c080e7          	jalr	1804(ra) # 800200d6 <panic>
        panic("enext not align");
    800259d2:	00004517          	auipc	a0,0x4
    800259d6:	36650513          	addi	a0,a0,870 # 80029d38 <syscalls+0x7e8>
    800259da:	ffffa097          	auipc	ra,0xffffa
    800259de:	6fc080e7          	jalr	1788(ra) # 800200d6 <panic>
            cnt++;
    800259e2:	2a05                	addiw	s4,s4,1
            continue;
    800259e4:	a881                	j	80025a34 <enext+0xf6>
            *count = cnt;
    800259e6:	014ba023          	sw	s4,0(s7) # 10000000 <BASE_ADDRESS-0x70020000>
            return 0;
    800259ea:	4501                	li	a0,0
    800259ec:	a2b5                	j	80025b58 <enext+0x21a>
            int lcnt = ebuf[0] & ~LAST_LONG_ENTRY;
            if (ebuf[0] & LAST_LONG_ENTRY) {
                *count = lcnt + 1;                              // plus the s-n-e;
                count = 0;
            }
            read_entry_name(ep->filename + (lcnt - 1) * CHAR_LONG_NAME, ebuf, 1);
    800259ee:	fff4879b          	addiw	a5,s1,-1
    800259f2:	0017949b          	slliw	s1,a5,0x1
    800259f6:	9cbd                	addw	s1,s1,a5
    800259f8:	0024949b          	slliw	s1,s1,0x2
    800259fc:	9cbd                	addw	s1,s1,a5
    800259fe:	94e6                	add	s1,s1,s9
        snstr(buffer, (wchar *) (raw_entry + 1), 5);
    80025a00:	4615                	li	a2,5
    80025a02:	f8140593          	addi	a1,s0,-127
    80025a06:	8526                	mv	a0,s1
    80025a08:	ffffb097          	auipc	ra,0xffffb
    80025a0c:	e46080e7          	jalr	-442(ra) # 8002084e <snstr>
        snstr(buffer + 5, (wchar *) (raw_entry + 14), 6);
    80025a10:	4619                	li	a2,6
    80025a12:	f8e40593          	addi	a1,s0,-114
    80025a16:	00548513          	addi	a0,s1,5
    80025a1a:	ffffb097          	auipc	ra,0xffffb
    80025a1e:	e34080e7          	jalr	-460(ra) # 8002084e <snstr>
        snstr(buffer + 11, (wchar *) (raw_entry + 28), 2);
    80025a22:	4609                	li	a2,2
    80025a24:	f9c40593          	addi	a1,s0,-100
    80025a28:	00b48513          	addi	a0,s1,11
    80025a2c:	ffffb097          	auipc	ra,0xffffb
    80025a30:	e22080e7          	jalr	-478(ra) # 8002084e <snstr>
    for (uint off2 = reloc_clus(dp, off); dp->cur_clus < FAT32_EOC; off2 = reloc_clus(dp, off2 + 32)) {
    80025a34:	0209059b          	addiw	a1,s2,32
    80025a38:	854e                	mv	a0,s3
    80025a3a:	fffff097          	auipc	ra,0xfffff
    80025a3e:	1f2080e7          	jalr	498(ra) # 80024c2c <reloc_clus>
    80025a42:	0005091b          	sext.w	s2,a0
    80025a46:	10c9a503          	lw	a0,268(s3)
    80025a4a:	10aae263          	bltu	s5,a0,80025b4e <enext+0x210>
        if (rw_clus(dp->cur_clus, 0, 0, (uint64)ebuf, off2, 32) != 32 || ebuf[0] == END_OF_ENTRY) {
    80025a4e:	f8040493          	addi	s1,s0,-128
    80025a52:	02000793          	li	a5,32
    80025a56:	874a                	mv	a4,s2
    80025a58:	86a6                	mv	a3,s1
    80025a5a:	4601                	li	a2,0
    80025a5c:	4581                	li	a1,0
    80025a5e:	fffff097          	auipc	ra,0xfffff
    80025a62:	436080e7          	jalr	1078(ra) # 80024e94 <rw_clus>
    80025a66:	2501                	sext.w	a0,a0
    80025a68:	02000793          	li	a5,32
    80025a6c:	0ef51563          	bne	a0,a5,80025b56 <enext+0x218>
    80025a70:	f8044783          	lbu	a5,-128(s0)
    80025a74:	10078063          	beqz	a5,80025b74 <enext+0x236>
        if (ebuf[0] == EMPTY_ENTRY) {
    80025a78:	f76785e3          	beq	a5,s6,800259e2 <enext+0xa4>
        } else if (cnt) {
    80025a7c:	f60a15e3          	bnez	s4,800259e6 <enext+0xa8>
        if (ebuf[11] == ATTR_LONG_NAME) {
    80025a80:	f8b44703          	lbu	a4,-117(s0)
    80025a84:	01871d63          	bne	a4,s8,80025a9e <enext+0x160>
            int lcnt = ebuf[0] & ~LAST_LONG_ENTRY;
    80025a88:	0bf7f493          	andi	s1,a5,191
            if (ebuf[0] & LAST_LONG_ENTRY) {
    80025a8c:	0407f793          	andi	a5,a5,64
    80025a90:	dfb9                	beqz	a5,800259ee <enext+0xb0>
                *count = lcnt + 1;                              // plus the s-n-e;
    80025a92:	0014879b          	addiw	a5,s1,1
    80025a96:	00fba023          	sw	a5,0(s7)
                count = 0;
    80025a9a:	4b81                	li	s7,0
    80025a9c:	bf89                	j	800259ee <enext+0xb0>
        } else {
            if (count) {
    80025a9e:	040b8463          	beqz	s7,80025ae6 <enext+0x1a8>
                *count = 1;
    80025aa2:	4785                	li	a5,1
    80025aa4:	00fba023          	sw	a5,0(s7)
        memset(buffer, 0, 12 << 1);
    80025aa8:	4661                	li	a2,24
    80025aaa:	4581                	li	a1,0
    80025aac:	856a                	mv	a0,s10
    80025aae:	ffffb097          	auipc	ra,0xffffb
    80025ab2:	b8a080e7          	jalr	-1142(ra) # 80020638 <memset>
        if (raw_entry[i] == ' ') {
    80025ab6:	f8744703          	lbu	a4,-121(s0)
    80025aba:	02000793          	li	a5,32
    80025abe:	04f70b63          	beq	a4,a5,80025b14 <enext+0x1d6>
        int i = 7;
    80025ac2:	479d                	li	a5,7
        i++;
    80025ac4:	2785                	addiw	a5,a5,1
    80025ac6:	0007849b          	sext.w	s1,a5
        memmove(buffer, raw_entry, i);
    80025aca:	8626                	mv	a2,s1
    80025acc:	f8040593          	addi	a1,s0,-128
    80025ad0:	856a                	mv	a0,s10
    80025ad2:	ffffb097          	auipc	ra,0xffffb
    80025ad6:	bd2080e7          	jalr	-1070(ra) # 800206a4 <memmove>
        if (raw_entry[8] != ' ') {
    80025ada:	f8844703          	lbu	a4,-120(s0)
    80025ade:	02000793          	li	a5,32
    80025ae2:	04f71663          	bne	a4,a5,80025b2e <enext+0x1f0>
    entry->attribute = raw_entry[11];
    80025ae6:	f8b44783          	lbu	a5,-117(s0)
    80025aea:	10fd0023          	sb	a5,256(s10)
    entry->first_clus = ((uint32) *(uint16 *)(raw_entry + 20)) << 16;
    80025aee:	f9445783          	lhu	a5,-108(s0)
    80025af2:	0107979b          	slliw	a5,a5,0x10
    entry->first_clus += *(uint16 *)(raw_entry + 26);
    80025af6:	f9a45703          	lhu	a4,-102(s0)
    80025afa:	9fb9                	addw	a5,a5,a4
    80025afc:	10fd2223          	sw	a5,260(s10)
    entry->file_size = *(uint32 *)(raw_entry + 28);
    80025b00:	f9c42703          	lw	a4,-100(s0)
    80025b04:	10ed2423          	sw	a4,264(s10)
    entry->cur_clus = entry->first_clus;
    80025b08:	10fd2623          	sw	a5,268(s10)
    entry->clus_cnt = 0;
    80025b0c:	100d2823          	sw	zero,272(s10)
                read_entry_name(ep->filename, ebuf, 0);
            }
            read_entry_info(ep, ebuf);
            return 1;
    80025b10:	4505                	li	a0,1
    80025b12:	a099                	j	80025b58 <enext+0x21a>
                i--;
    80025b14:	4799                	li	a5,6
            } while (i >= 0 && raw_entry[i] == ' ');
    80025b16:	02000693          	li	a3,32
    80025b1a:	567d                	li	a2,-1
    80025b1c:	0064c703          	lbu	a4,6(s1)
    80025b20:	fad712e3          	bne	a4,a3,80025ac4 <enext+0x186>
                i--;
    80025b24:	37fd                	addiw	a5,a5,-1
    80025b26:	14fd                	addi	s1,s1,-1
            } while (i >= 0 && raw_entry[i] == ' ');
    80025b28:	fec79ae3          	bne	a5,a2,80025b1c <enext+0x1de>
    80025b2c:	bf61                	j	80025ac4 <enext+0x186>
            memmove(buffer + i + 1, raw_entry + 8, 3);
    80025b2e:	00148513          	addi	a0,s1,1
    80025b32:	460d                	li	a2,3
    80025b34:	f8840593          	addi	a1,s0,-120
    80025b38:	956a                	add	a0,a0,s10
    80025b3a:	ffffb097          	auipc	ra,0xffffb
    80025b3e:	b6a080e7          	jalr	-1174(ra) # 800206a4 <memmove>
            buffer[i] = '.';
    80025b42:	94ea                	add	s1,s1,s10
    80025b44:	02e00793          	li	a5,46
    80025b48:	00f48023          	sb	a5,0(s1)
    80025b4c:	bf69                	j	80025ae6 <enext+0x1a8>
        }
    }
    return -1;
    80025b4e:	557d                	li	a0,-1
    80025b50:	a021                	j	80025b58 <enext+0x21a>
    80025b52:	557d                	li	a0,-1
    80025b54:	a011                	j	80025b58 <enext+0x21a>
            return -1;
    80025b56:	557d                	li	a0,-1
}
    80025b58:	70e6                	ld	ra,120(sp)
    80025b5a:	7446                	ld	s0,112(sp)
    80025b5c:	74a6                	ld	s1,104(sp)
    80025b5e:	7906                	ld	s2,96(sp)
    80025b60:	69e6                	ld	s3,88(sp)
    80025b62:	6a46                	ld	s4,80(sp)
    80025b64:	6aa6                	ld	s5,72(sp)
    80025b66:	6b06                	ld	s6,64(sp)
    80025b68:	7be2                	ld	s7,56(sp)
    80025b6a:	7c42                	ld	s8,48(sp)
    80025b6c:	7ca2                	ld	s9,40(sp)
    80025b6e:	7d02                	ld	s10,32(sp)
    80025b70:	6109                	addi	sp,sp,128
    80025b72:	8082                	ret
            return -1;
    80025b74:	557d                	li	a0,-1
    80025b76:	b7cd                	j	80025b58 <enext+0x21a>

0000000080025b78 <dirlookup>:
 * @param   entry       entry of a directory file
 * @param   filename    target filename
 * @param   poff        offset of proper empty entries slot from the dir
 */
struct dirent *dirlookup(struct dirent *entry, char *filename, uint *poff)
{
    80025b78:	715d                	addi	sp,sp,-80
    80025b7a:	e486                	sd	ra,72(sp)
    80025b7c:	e0a2                	sd	s0,64(sp)
    80025b7e:	fc26                	sd	s1,56(sp)
    80025b80:	f84a                	sd	s2,48(sp)
    80025b82:	f44e                	sd	s3,40(sp)
    80025b84:	f052                	sd	s4,32(sp)
    80025b86:	ec56                	sd	s5,24(sp)
    80025b88:	e85a                	sd	s6,16(sp)
    80025b8a:	0880                	addi	s0,sp,80
    if (!(entry->attribute & ATTR_DIRECTORY))
    80025b8c:	10054783          	lbu	a5,256(a0)
    80025b90:	8bc1                	andi	a5,a5,16
    80025b92:	cbc5                	beqz	a5,80025c42 <dirlookup+0xca>
    80025b94:	84aa                	mv	s1,a0
    80025b96:	8a2e                	mv	s4,a1
    80025b98:	8b32                	mv	s6,a2
        panic("dirlookup not DIR");
    if (strncmp(filename, ".", FAT32_MAX_FILENAME) == 0) {
    80025b9a:	0ff00613          	li	a2,255
    80025b9e:	00004597          	auipc	a1,0x4
    80025ba2:	1c258593          	addi	a1,a1,450 # 80029d60 <syscalls+0x810>
    80025ba6:	8552                	mv	a0,s4
    80025ba8:	ffffb097          	auipc	ra,0xffffb
    80025bac:	b78080e7          	jalr	-1160(ra) # 80020720 <strncmp>
    80025bb0:	c14d                	beqz	a0,80025c52 <dirlookup+0xda>
        return edup(entry);
    } else if (strncmp(filename, "..", FAT32_MAX_FILENAME) == 0) {
    80025bb2:	0ff00613          	li	a2,255
    80025bb6:	00004597          	auipc	a1,0x4
    80025bba:	1b258593          	addi	a1,a1,434 # 80029d68 <syscalls+0x818>
    80025bbe:	8552                	mv	a0,s4
    80025bc0:	ffffb097          	auipc	ra,0xffffb
    80025bc4:	b60080e7          	jalr	-1184(ra) # 80020720 <strncmp>
    80025bc8:	c555                	beqz	a0,80025c74 <dirlookup+0xfc>
        return edup(entry->parent);
    }
    struct dirent *de = eget(entry, filename);
    80025bca:	85d2                	mv	a1,s4
    80025bcc:	8526                	mv	a0,s1
    80025bce:	fffff097          	auipc	ra,0xfffff
    80025bd2:	704080e7          	jalr	1796(ra) # 800252d2 <eget>
    80025bd6:	892a                	mv	s2,a0
    if (de->valid) { return de; }                               // ecache hits
    80025bd8:	11654783          	lbu	a5,278(a0)
    80025bdc:	e3c9                	bnez	a5,80025c5e <dirlookup+0xe6>

    int len = strlen(filename);
    80025bde:	8552                	mv	a0,s4
    80025be0:	ffffb097          	auipc	ra,0xffffb
    80025be4:	c02080e7          	jalr	-1022(ra) # 800207e2 <strlen>
    int entcnt = (len + CHAR_LONG_NAME - 1) / CHAR_LONG_NAME + 1;   // count of l-n-entries, rounds up
    int count = 0;
    80025be8:	fa042e23          	sw	zero,-68(s0)
    int type;
    uint off = reloc_clus(entry, 0);
    80025bec:	4581                	li	a1,0
    80025bee:	8526                	mv	a0,s1
    80025bf0:	fffff097          	auipc	ra,0xfffff
    80025bf4:	03c080e7          	jalr	60(ra) # 80024c2c <reloc_clus>
    80025bf8:	0005099b          	sext.w	s3,a0

    while ((type = enext(entry, de, off, &count) != -1)) {
    80025bfc:	5afd                	li	s5,-1
    80025bfe:	fbc40693          	addi	a3,s0,-68
    80025c02:	864e                	mv	a2,s3
    80025c04:	85ca                	mv	a1,s2
    80025c06:	8526                	mv	a0,s1
    80025c08:	00000097          	auipc	ra,0x0
    80025c0c:	d36080e7          	jalr	-714(ra) # 8002593e <enext>
    80025c10:	09550763          	beq	a0,s5,80025c9e <dirlookup+0x126>
        if (type == 0) {
            if (poff && count >= entcnt) {
                *poff = off;
                poff = 0;
            }
        } else if (strncmp(filename, de->filename, FAT32_MAX_FILENAME) == 0) {
    80025c14:	0ff00613          	li	a2,255
    80025c18:	85ca                	mv	a1,s2
    80025c1a:	8552                	mv	a0,s4
    80025c1c:	ffffb097          	auipc	ra,0xffffb
    80025c20:	b04080e7          	jalr	-1276(ra) # 80020720 <strncmp>
    80025c24:	c125                	beqz	a0,80025c84 <dirlookup+0x10c>
            de->parent = edup(entry);
            de->off = off;
            de->valid = 1;
            return de;
        }
        off = reloc_clus(entry, off + count * 32);
    80025c26:	fbc42583          	lw	a1,-68(s0)
    80025c2a:	0055959b          	slliw	a1,a1,0x5
    80025c2e:	013585bb          	addw	a1,a1,s3
    80025c32:	8526                	mv	a0,s1
    80025c34:	fffff097          	auipc	ra,0xfffff
    80025c38:	ff8080e7          	jalr	-8(ra) # 80024c2c <reloc_clus>
    80025c3c:	0005099b          	sext.w	s3,a0
    80025c40:	bf7d                	j	80025bfe <dirlookup+0x86>
        panic("dirlookup not DIR");
    80025c42:	00004517          	auipc	a0,0x4
    80025c46:	10650513          	addi	a0,a0,262 # 80029d48 <syscalls+0x7f8>
    80025c4a:	ffffa097          	auipc	ra,0xffffa
    80025c4e:	48c080e7          	jalr	1164(ra) # 800200d6 <panic>
        return edup(entry);
    80025c52:	8526                	mv	a0,s1
    80025c54:	fffff097          	auipc	ra,0xfffff
    80025c58:	63a080e7          	jalr	1594(ra) # 8002528e <edup>
    80025c5c:	892a                	mv	s2,a0
    if (poff) {
        *poff = off;
    }
    eput(de);
    return 0;
}
    80025c5e:	854a                	mv	a0,s2
    80025c60:	60a6                	ld	ra,72(sp)
    80025c62:	6406                	ld	s0,64(sp)
    80025c64:	74e2                	ld	s1,56(sp)
    80025c66:	7942                	ld	s2,48(sp)
    80025c68:	79a2                	ld	s3,40(sp)
    80025c6a:	7a02                	ld	s4,32(sp)
    80025c6c:	6ae2                	ld	s5,24(sp)
    80025c6e:	6b42                	ld	s6,16(sp)
    80025c70:	6161                	addi	sp,sp,80
    80025c72:	8082                	ret
        return edup(entry->parent);
    80025c74:	1204b503          	ld	a0,288(s1)
    80025c78:	fffff097          	auipc	ra,0xfffff
    80025c7c:	616080e7          	jalr	1558(ra) # 8002528e <edup>
    80025c80:	892a                	mv	s2,a0
    80025c82:	bff1                	j	80025c5e <dirlookup+0xe6>
            de->parent = edup(entry);
    80025c84:	8526                	mv	a0,s1
    80025c86:	fffff097          	auipc	ra,0xfffff
    80025c8a:	608080e7          	jalr	1544(ra) # 8002528e <edup>
    80025c8e:	12a93023          	sd	a0,288(s2)
            de->off = off;
    80025c92:	11392e23          	sw	s3,284(s2)
            de->valid = 1;
    80025c96:	4785                	li	a5,1
    80025c98:	10f90b23          	sb	a5,278(s2)
            return de;
    80025c9c:	b7c9                	j	80025c5e <dirlookup+0xe6>
    if (poff) {
    80025c9e:	000b0463          	beqz	s6,80025ca6 <dirlookup+0x12e>
        *poff = off;
    80025ca2:	013b2023          	sw	s3,0(s6)
    eput(de);
    80025ca6:	854a                	mv	a0,s2
    80025ca8:	00000097          	auipc	ra,0x0
    80025cac:	b66080e7          	jalr	-1178(ra) # 8002580e <eput>
    return 0;
    80025cb0:	4901                	li	s2,0
    80025cb2:	b775                	j	80025c5e <dirlookup+0xe6>

0000000080025cb4 <ealloc>:
{
    80025cb4:	7159                	addi	sp,sp,-112
    80025cb6:	f486                	sd	ra,104(sp)
    80025cb8:	f0a2                	sd	s0,96(sp)
    80025cba:	eca6                	sd	s1,88(sp)
    80025cbc:	e8ca                	sd	s2,80(sp)
    80025cbe:	e4ce                	sd	s3,72(sp)
    80025cc0:	e0d2                	sd	s4,64(sp)
    80025cc2:	fc56                	sd	s5,56(sp)
    80025cc4:	f85a                	sd	s6,48(sp)
    80025cc6:	1880                	addi	s0,sp,112
    if (!(dp->attribute & ATTR_DIRECTORY)) { return 0; }
    80025cc8:	10054783          	lbu	a5,256(a0)
    80025ccc:	8bc1                	andi	a5,a5,16
    80025cce:	2a078f63          	beqz	a5,80025f8c <ealloc+0x2d8>
    80025cd2:	8932                	mv	s2,a2
    80025cd4:	84ae                	mv	s1,a1
    80025cd6:	89aa                	mv	s3,a0
    uint off = 0;
    80025cd8:	fa042e23          	sw	zero,-68(s0)
    ep = dirlookup(dp, name, &off);
    80025cdc:	fbc40613          	addi	a2,s0,-68
    80025ce0:	00000097          	auipc	ra,0x0
    80025ce4:	e98080e7          	jalr	-360(ra) # 80025b78 <dirlookup>
    if (ep != 0) {      // entry exists
    80025ce8:	e961                	bnez	a0,80025db8 <ealloc+0x104>
    ep = eget(dp, name);
    80025cea:	85a6                	mv	a1,s1
    80025cec:	854e                	mv	a0,s3
    80025cee:	fffff097          	auipc	ra,0xfffff
    80025cf2:	5e4080e7          	jalr	1508(ra) # 800252d2 <eget>
    80025cf6:	8a2a                	mv	s4,a0
    if (ep->valid) {    // shouldn't be valid
    80025cf8:	11654783          	lbu	a5,278(a0)
    80025cfc:	e7e1                	bnez	a5,80025dc4 <ealloc+0x110>
    elock(ep);
    80025cfe:	00000097          	auipc	ra,0x0
    80025d02:	a8c080e7          	jalr	-1396(ra) # 8002578a <elock>
    ep->attribute = 0;
    80025d06:	100a0023          	sb	zero,256(s4)
    ep->file_size = 0;
    80025d0a:	100a2423          	sw	zero,264(s4)
    ep->first_clus = 0;
    80025d0e:	100a2223          	sw	zero,260(s4)
    ep->parent = edup(dp);
    80025d12:	854e                	mv	a0,s3
    80025d14:	fffff097          	auipc	ra,0xfffff
    80025d18:	57a080e7          	jalr	1402(ra) # 8002528e <edup>
    80025d1c:	12aa3023          	sd	a0,288(s4)
    ep->off = off;
    80025d20:	fbc42783          	lw	a5,-68(s0)
    80025d24:	10fa2e23          	sw	a5,284(s4)
    ep->clus_cnt = 0;
    80025d28:	100a2823          	sw	zero,272(s4)
    ep->cur_clus = 0;
    80025d2c:	100a2623          	sw	zero,268(s4)
    strncpy(ep->filename, name, FAT32_MAX_FILENAME);    
    80025d30:	0ff00613          	li	a2,255
    80025d34:	85a6                	mv	a1,s1
    80025d36:	8552                	mv	a0,s4
    80025d38:	ffffb097          	auipc	ra,0xffffb
    80025d3c:	a38080e7          	jalr	-1480(ra) # 80020770 <strncpy>
    int len = strlen(name);
    80025d40:	8526                	mv	a0,s1
    80025d42:	ffffb097          	auipc	ra,0xffffb
    80025d46:	aa0080e7          	jalr	-1376(ra) # 800207e2 <strlen>
    int entcnt = (len + CHAR_LONG_NAME - 1) / CHAR_LONG_NAME;   // count of l-n-entries, rounds up
    80025d4a:	2531                	addiw	a0,a0,12
    80025d4c:	47b5                	li	a5,13
    80025d4e:	02f54abb          	divw	s5,a0,a5
    uint8 ebuf[32] = {0};
    80025d52:	f8043c23          	sd	zero,-104(s0)
    80025d56:	fa043023          	sd	zero,-96(s0)
    80025d5a:	fa043423          	sd	zero,-88(s0)
    80025d5e:	fa043823          	sd	zero,-80(s0)
    if(dir){    // generate "." and ".." for ep
    80025d62:	06091963          	bnez	s2,80025dd4 <ealloc+0x120>
        ep->attribute |= ATTR_ARCHIVE;
    80025d66:	100a4783          	lbu	a5,256(s4)
    80025d6a:	0207e793          	ori	a5,a5,32
    80025d6e:	10fa0023          	sb	a5,256(s4)
    memset(ebuf, 0, sizeof(ebuf));
    80025d72:	02000613          	li	a2,32
    80025d76:	4581                	li	a1,0
    80025d78:	f9840513          	addi	a0,s0,-104
    80025d7c:	ffffb097          	auipc	ra,0xffffb
    80025d80:	8bc080e7          	jalr	-1860(ra) # 80020638 <memset>
    off = reloc_clus(dp, off);
    80025d84:	fbc42583          	lw	a1,-68(s0)
    80025d88:	854e                	mv	a0,s3
    80025d8a:	fffff097          	auipc	ra,0xfffff
    80025d8e:	ea2080e7          	jalr	-350(ra) # 80024c2c <reloc_clus>
    80025d92:	faa42e23          	sw	a0,-68(s0)
    for (uint8 i = entcnt; i > 0; i--) {                          // ignore checksum
    80025d96:	0ffaf793          	andi	a5,s5,255
    80025d9a:	1a078f63          	beqz	a5,80025f58 <ealloc+0x2a4>
    80025d9e:	0ffaf493          	andi	s1,s5,255
    80025da2:	0004891b          	sext.w	s2,s1
    80025da6:	0014979b          	slliw	a5,s1,0x1
    80025daa:	9fa5                	addw	a5,a5,s1
    80025dac:	0027979b          	slliw	a5,a5,0x2
    80025db0:	94be                	add	s1,s1,a5
    80025db2:	94d2                	add	s1,s1,s4
        ebuf[11] = ATTR_LONG_NAME;
    80025db4:	4b3d                	li	s6,15
    80025db6:	aa41                	j	80025f46 <ealloc+0x292>
        eput(ep);
    80025db8:	00000097          	auipc	ra,0x0
    80025dbc:	a56080e7          	jalr	-1450(ra) # 8002580e <eput>
        return 0;
    80025dc0:	4a01                	li	s4,0
    80025dc2:	aa55                	j	80025f76 <ealloc+0x2c2>
        panic("ealloc");
    80025dc4:	00004517          	auipc	a0,0x4
    80025dc8:	fac50513          	addi	a0,a0,-84 # 80029d70 <syscalls+0x820>
    80025dcc:	ffffa097          	auipc	ra,0xffffa
    80025dd0:	30a080e7          	jalr	778(ra) # 800200d6 <panic>
        ep->attribute |= ATTR_DIRECTORY;
    80025dd4:	100a4783          	lbu	a5,256(s4)
    80025dd8:	0107e793          	ori	a5,a5,16
    80025ddc:	10fa0023          	sb	a5,256(s4)
        ep->cur_clus = ep->first_clus = alloc_clus(dp->dev);
    80025de0:	1149c503          	lbu	a0,276(s3)
    80025de4:	fffff097          	auipc	ra,0xfffff
    80025de8:	eea080e7          	jalr	-278(ra) # 80024cce <alloc_clus>
    80025dec:	2501                	sext.w	a0,a0
    80025dee:	10aa2223          	sw	a0,260(s4)
    80025df2:	10aa2623          	sw	a0,268(s4)
        strncpy((char *)ebuf, ".", 11);
    80025df6:	462d                	li	a2,11
    80025df8:	00004597          	auipc	a1,0x4
    80025dfc:	f6858593          	addi	a1,a1,-152 # 80029d60 <syscalls+0x810>
    80025e00:	f9840513          	addi	a0,s0,-104
    80025e04:	ffffb097          	auipc	ra,0xffffb
    80025e08:	96c080e7          	jalr	-1684(ra) # 80020770 <strncpy>
        ebuf[11] = ATTR_DIRECTORY;
    80025e0c:	44c1                	li	s1,16
    80025e0e:	fa9401a3          	sb	s1,-93(s0)
        *(uint16 *)(ebuf + 20) = (uint16)(ep->first_clus >> 16);
    80025e12:	104a2783          	lw	a5,260(s4)
    80025e16:	0107d71b          	srliw	a4,a5,0x10
    80025e1a:	fae41623          	sh	a4,-84(s0)
        *(uint16 *)(ebuf + 26) = (uint16)(ep->first_clus & 0xff);
    80025e1e:	0ff7f793          	andi	a5,a5,255
    80025e22:	faf41923          	sh	a5,-78(s0)
        *(uint32 *)(ebuf + 28) = 0;
    80025e26:	fa042a23          	sw	zero,-76(s0)
        rw_clus(ep->cur_clus, 1, 0, (uint64)ebuf, 0, sizeof(ebuf));
    80025e2a:	02000793          	li	a5,32
    80025e2e:	4701                	li	a4,0
    80025e30:	f9840693          	addi	a3,s0,-104
    80025e34:	4601                	li	a2,0
    80025e36:	4585                	li	a1,1
    80025e38:	10ca2503          	lw	a0,268(s4)
    80025e3c:	fffff097          	auipc	ra,0xfffff
    80025e40:	058080e7          	jalr	88(ra) # 80024e94 <rw_clus>
        strncpy((char *)ebuf, "..", 11);
    80025e44:	462d                	li	a2,11
    80025e46:	00004597          	auipc	a1,0x4
    80025e4a:	f2258593          	addi	a1,a1,-222 # 80029d68 <syscalls+0x818>
    80025e4e:	f9840513          	addi	a0,s0,-104
    80025e52:	ffffb097          	auipc	ra,0xffffb
    80025e56:	91e080e7          	jalr	-1762(ra) # 80020770 <strncpy>
        ebuf[11] = ATTR_DIRECTORY;
    80025e5a:	fa9401a3          	sb	s1,-93(s0)
        *(uint16 *)(ebuf + 20) = (uint16)(dp->first_clus >> 16);
    80025e5e:	1049a783          	lw	a5,260(s3)
    80025e62:	0107d71b          	srliw	a4,a5,0x10
    80025e66:	fae41623          	sh	a4,-84(s0)
        *(uint16 *)(ebuf + 26) = (uint16)(dp->first_clus & 0xff);
    80025e6a:	0ff7f793          	andi	a5,a5,255
    80025e6e:	faf41923          	sh	a5,-78(s0)
        *(uint32 *)(ebuf + 28) = 0;
    80025e72:	fa042a23          	sw	zero,-76(s0)
        rw_clus(ep->cur_clus, 1, 0, (uint64)ebuf, 32, sizeof(ebuf));
    80025e76:	02000793          	li	a5,32
    80025e7a:	02000713          	li	a4,32
    80025e7e:	f9840693          	addi	a3,s0,-104
    80025e82:	4601                	li	a2,0
    80025e84:	4585                	li	a1,1
    80025e86:	10ca2503          	lw	a0,268(s4)
    80025e8a:	fffff097          	auipc	ra,0xfffff
    80025e8e:	00a080e7          	jalr	10(ra) # 80024e94 <rw_clus>
    80025e92:	b5c5                	j	80025d72 <ealloc+0xbe>
            ebuf[0] |= LAST_LONG_ENTRY;
    80025e94:	0407e793          	ori	a5,a5,64
    80025e98:	f8f40c23          	sb	a5,-104(s0)
            memset(ebuf + 1, 0xff, 10);
    80025e9c:	4629                	li	a2,10
    80025e9e:	0ff00593          	li	a1,255
    80025ea2:	f9940513          	addi	a0,s0,-103
    80025ea6:	ffffa097          	auipc	ra,0xffffa
    80025eaa:	792080e7          	jalr	1938(ra) # 80020638 <memset>
            memset(ebuf + 14, 0xff, 12);
    80025eae:	4631                	li	a2,12
    80025eb0:	0ff00593          	li	a1,255
    80025eb4:	fa640513          	addi	a0,s0,-90
    80025eb8:	ffffa097          	auipc	ra,0xffffa
    80025ebc:	780080e7          	jalr	1920(ra) # 80020638 <memset>
            memset(ebuf + 28, 0xff, 4);
    80025ec0:	4611                	li	a2,4
    80025ec2:	0ff00593          	li	a1,255
    80025ec6:	fb440513          	addi	a0,s0,-76
    80025eca:	ffffa097          	auipc	ra,0xffffa
    80025ece:	76e080e7          	jalr	1902(ra) # 80020638 <memset>
        ebuf[11] = ATTR_LONG_NAME;
    80025ed2:	fb6401a3          	sb	s6,-93(s0)
        wnstr_lazy((wchar *) (ebuf + 1), ep->filename + i * CHAR_LONG_NAME, 5);
    80025ed6:	4615                	li	a2,5
    80025ed8:	85a6                	mv	a1,s1
    80025eda:	f9940513          	addi	a0,s0,-103
    80025ede:	fffff097          	auipc	ra,0xfffff
    80025ee2:	ca8080e7          	jalr	-856(ra) # 80024b86 <wnstr_lazy>
        wnstr_lazy((wchar *) (ebuf + 14), ep->filename + i * CHAR_LONG_NAME + 5, 6);
    80025ee6:	4619                	li	a2,6
    80025ee8:	00548593          	addi	a1,s1,5
    80025eec:	fa640513          	addi	a0,s0,-90
    80025ef0:	fffff097          	auipc	ra,0xfffff
    80025ef4:	c96080e7          	jalr	-874(ra) # 80024b86 <wnstr_lazy>
        wnstr_lazy((wchar *) (ebuf + 28), ep->filename + i * CHAR_LONG_NAME + 11, 2);
    80025ef8:	4609                	li	a2,2
    80025efa:	00b48593          	addi	a1,s1,11
    80025efe:	fb440513          	addi	a0,s0,-76
    80025f02:	fffff097          	auipc	ra,0xfffff
    80025f06:	c84080e7          	jalr	-892(ra) # 80024b86 <wnstr_lazy>
        rw_clus(dp->cur_clus, 1, 0, (uint64)ebuf, off, sizeof(ebuf));
    80025f0a:	02000793          	li	a5,32
    80025f0e:	fbc42703          	lw	a4,-68(s0)
    80025f12:	f9840693          	addi	a3,s0,-104
    80025f16:	4601                	li	a2,0
    80025f18:	4585                	li	a1,1
    80025f1a:	10c9a503          	lw	a0,268(s3)
    80025f1e:	fffff097          	auipc	ra,0xfffff
    80025f22:	f76080e7          	jalr	-138(ra) # 80024e94 <rw_clus>
        off = reloc_clus(dp, off + 32);
    80025f26:	fbc42583          	lw	a1,-68(s0)
    80025f2a:	0205859b          	addiw	a1,a1,32
    80025f2e:	854e                	mv	a0,s3
    80025f30:	fffff097          	auipc	ra,0xfffff
    80025f34:	cfc080e7          	jalr	-772(ra) # 80024c2c <reloc_clus>
    80025f38:	faa42e23          	sw	a0,-68(s0)
    80025f3c:	397d                	addiw	s2,s2,-1
    80025f3e:	14cd                	addi	s1,s1,-13
    for (uint8 i = entcnt; i > 0; i--) {                          // ignore checksum
    80025f40:	0ff97793          	andi	a5,s2,255
    80025f44:	cb91                	beqz	a5,80025f58 <ealloc+0x2a4>
    80025f46:	0ff97793          	andi	a5,s2,255
        if (i == entcnt) {
    80025f4a:	0009071b          	sext.w	a4,s2
    80025f4e:	f4ea83e3          	beq	s5,a4,80025e94 <ealloc+0x1e0>
        ebuf[0] = i;
    80025f52:	f8f40c23          	sb	a5,-104(s0)
    80025f56:	bfb5                	j	80025ed2 <ealloc+0x21e>
    ep->dirty = 1;
    80025f58:	4485                	li	s1,1
    80025f5a:	109a0aa3          	sb	s1,277(s4)
    eupdate(ep);
    80025f5e:	8552                	mv	a0,s4
    80025f60:	fffff097          	auipc	ra,0xfffff
    80025f64:	482080e7          	jalr	1154(ra) # 800253e2 <eupdate>
    ep->valid = 1;
    80025f68:	109a0b23          	sb	s1,278(s4)
    eunlock(ep);
    80025f6c:	8552                	mv	a0,s4
    80025f6e:	00000097          	auipc	ra,0x0
    80025f72:	852080e7          	jalr	-1966(ra) # 800257c0 <eunlock>
}
    80025f76:	8552                	mv	a0,s4
    80025f78:	70a6                	ld	ra,104(sp)
    80025f7a:	7406                	ld	s0,96(sp)
    80025f7c:	64e6                	ld	s1,88(sp)
    80025f7e:	6946                	ld	s2,80(sp)
    80025f80:	69a6                	ld	s3,72(sp)
    80025f82:	6a06                	ld	s4,64(sp)
    80025f84:	7ae2                	ld	s5,56(sp)
    80025f86:	7b42                	ld	s6,48(sp)
    80025f88:	6165                	addi	sp,sp,112
    80025f8a:	8082                	ret
    if (!(dp->attribute & ATTR_DIRECTORY)) { return 0; }
    80025f8c:	4a01                	li	s4,0
    80025f8e:	b7e5                	j	80025f76 <ealloc+0x2c2>

0000000080025f90 <lookup_path>:
    return path;
}

// FAT32 version of namex in xv6's original file system.
static struct dirent *lookup_path(char *path, int parent, char *name)
{
    80025f90:	715d                	addi	sp,sp,-80
    80025f92:	e486                	sd	ra,72(sp)
    80025f94:	e0a2                	sd	s0,64(sp)
    80025f96:	fc26                	sd	s1,56(sp)
    80025f98:	f84a                	sd	s2,48(sp)
    80025f9a:	f44e                	sd	s3,40(sp)
    80025f9c:	f052                	sd	s4,32(sp)
    80025f9e:	ec56                	sd	s5,24(sp)
    80025fa0:	e85a                	sd	s6,16(sp)
    80025fa2:	e45e                	sd	s7,8(sp)
    80025fa4:	e062                	sd	s8,0(sp)
    80025fa6:	0880                	addi	s0,sp,80
    80025fa8:	84aa                	mv	s1,a0
    80025faa:	8bae                	mv	s7,a1
    80025fac:	8a32                	mv	s4,a2
    struct dirent *entry, *next;
    if (*path == '/') {
    80025fae:	00054703          	lbu	a4,0(a0)
    80025fb2:	02f00793          	li	a5,47
    80025fb6:	02f70363          	beq	a4,a5,80025fdc <lookup_path+0x4c>
        entry = edup(&root);
    } else {
        entry = edup(myproc()->cwd);
    80025fba:	ffffb097          	auipc	ra,0xffffb
    80025fbe:	61c080e7          	jalr	1564(ra) # 800215d6 <myproc>
    80025fc2:	15053503          	ld	a0,336(a0)
    80025fc6:	fffff097          	auipc	ra,0xfffff
    80025fca:	2c8080e7          	jalr	712(ra) # 8002528e <edup>
    80025fce:	892a                	mv	s2,a0
    while (*path == '/') {
    80025fd0:	02f00993          	li	s3,47
    int len = path - s;
    80025fd4:	4b01                	li	s6,0
    if (len > FAT32_MAX_FILENAME) {
    80025fd6:	0ff00a93          	li	s5,255
    80025fda:	a8d9                	j	800260b0 <lookup_path+0x120>
        entry = edup(&root);
    80025fdc:	00015517          	auipc	a0,0x15
    80025fe0:	18450513          	addi	a0,a0,388 # 8003b160 <root>
    80025fe4:	fffff097          	auipc	ra,0xfffff
    80025fe8:	2aa080e7          	jalr	682(ra) # 8002528e <edup>
    80025fec:	892a                	mv	s2,a0
    80025fee:	b7cd                	j	80025fd0 <lookup_path+0x40>
    }
    while ((path = skipelem(path, name)) != 0) {
        elock(entry);
        if (!(entry->attribute & ATTR_DIRECTORY)) {
            eunlock(entry);
    80025ff0:	854a                	mv	a0,s2
    80025ff2:	fffff097          	auipc	ra,0xfffff
    80025ff6:	7ce080e7          	jalr	1998(ra) # 800257c0 <eunlock>
            eput(entry);
    80025ffa:	854a                	mv	a0,s2
    80025ffc:	00000097          	auipc	ra,0x0
    80026000:	812080e7          	jalr	-2030(ra) # 8002580e <eput>
            return 0;
    80026004:	4901                	li	s2,0
    if (parent) {
        eput(entry);
        return 0;
    }
    return entry;
}
    80026006:	854a                	mv	a0,s2
    80026008:	60a6                	ld	ra,72(sp)
    8002600a:	6406                	ld	s0,64(sp)
    8002600c:	74e2                	ld	s1,56(sp)
    8002600e:	7942                	ld	s2,48(sp)
    80026010:	79a2                	ld	s3,40(sp)
    80026012:	7a02                	ld	s4,32(sp)
    80026014:	6ae2                	ld	s5,24(sp)
    80026016:	6b42                	ld	s6,16(sp)
    80026018:	6ba2                	ld	s7,8(sp)
    8002601a:	6c02                	ld	s8,0(sp)
    8002601c:	6161                	addi	sp,sp,80
    8002601e:	8082                	ret
            eunlock(entry);
    80026020:	854a                	mv	a0,s2
    80026022:	fffff097          	auipc	ra,0xfffff
    80026026:	79e080e7          	jalr	1950(ra) # 800257c0 <eunlock>
            return entry;
    8002602a:	bff1                	j	80026006 <lookup_path+0x76>
            eunlock(entry);
    8002602c:	854a                	mv	a0,s2
    8002602e:	fffff097          	auipc	ra,0xfffff
    80026032:	792080e7          	jalr	1938(ra) # 800257c0 <eunlock>
            eput(entry);
    80026036:	854a                	mv	a0,s2
    80026038:	fffff097          	auipc	ra,0xfffff
    8002603c:	7d6080e7          	jalr	2006(ra) # 8002580e <eput>
            return 0;
    80026040:	8962                	mv	s2,s8
    80026042:	b7d1                	j	80026006 <lookup_path+0x76>
    while (*path != '/' && *path != 0) {
    80026044:	85a6                	mv	a1,s1
    int len = path - s;
    80026046:	865a                	mv	a2,s6
        name[len] = 0;
    80026048:	00ca07b3          	add	a5,s4,a2
    8002604c:	00078023          	sb	zero,0(a5) # 10000000 <BASE_ADDRESS-0x70020000>
    memmove(name, s, len);
    80026050:	8552                	mv	a0,s4
    80026052:	ffffa097          	auipc	ra,0xffffa
    80026056:	652080e7          	jalr	1618(ra) # 800206a4 <memmove>
    while (*path == '/') {
    8002605a:	0004c783          	lbu	a5,0(s1)
    8002605e:	01379763          	bne	a5,s3,8002606c <lookup_path+0xdc>
        path++;
    80026062:	0485                	addi	s1,s1,1
    while (*path == '/') {
    80026064:	0004c783          	lbu	a5,0(s1)
    80026068:	ff378de3          	beq	a5,s3,80026062 <lookup_path+0xd2>
        elock(entry);
    8002606c:	854a                	mv	a0,s2
    8002606e:	fffff097          	auipc	ra,0xfffff
    80026072:	71c080e7          	jalr	1820(ra) # 8002578a <elock>
        if (!(entry->attribute & ATTR_DIRECTORY)) {
    80026076:	10094783          	lbu	a5,256(s2)
    8002607a:	8bc1                	andi	a5,a5,16
    8002607c:	dbb5                	beqz	a5,80025ff0 <lookup_path+0x60>
        if (parent && *path == '\0') {
    8002607e:	000b8563          	beqz	s7,80026088 <lookup_path+0xf8>
    80026082:	0004c783          	lbu	a5,0(s1)
    80026086:	dfc9                	beqz	a5,80026020 <lookup_path+0x90>
        if ((next = dirlookup(entry, name, 0)) == 0) {
    80026088:	865a                	mv	a2,s6
    8002608a:	85d2                	mv	a1,s4
    8002608c:	854a                	mv	a0,s2
    8002608e:	00000097          	auipc	ra,0x0
    80026092:	aea080e7          	jalr	-1302(ra) # 80025b78 <dirlookup>
    80026096:	8c2a                	mv	s8,a0
    80026098:	d951                	beqz	a0,8002602c <lookup_path+0x9c>
        eunlock(entry);
    8002609a:	854a                	mv	a0,s2
    8002609c:	fffff097          	auipc	ra,0xfffff
    800260a0:	724080e7          	jalr	1828(ra) # 800257c0 <eunlock>
        eput(entry);
    800260a4:	854a                	mv	a0,s2
    800260a6:	fffff097          	auipc	ra,0xfffff
    800260aa:	768080e7          	jalr	1896(ra) # 8002580e <eput>
        entry = next;
    800260ae:	8962                	mv	s2,s8
    while (*path == '/') {
    800260b0:	0004c783          	lbu	a5,0(s1)
    800260b4:	05379463          	bne	a5,s3,800260fc <lookup_path+0x16c>
        path++;
    800260b8:	0485                	addi	s1,s1,1
    while (*path == '/') {
    800260ba:	0004c783          	lbu	a5,0(s1)
    800260be:	ff378de3          	beq	a5,s3,800260b8 <lookup_path+0x128>
    if (*path == 0) { return 0; }
    800260c2:	c785                	beqz	a5,800260ea <lookup_path+0x15a>
    while (*path != '/' && *path != 0) {
    800260c4:	f93780e3          	beq	a5,s3,80026044 <lookup_path+0xb4>
    800260c8:	cf91                	beqz	a5,800260e4 <lookup_path+0x154>
        path++;
    800260ca:	85a6                	mv	a1,s1
        path++;
    800260cc:	0485                	addi	s1,s1,1
    while (*path != '/' && *path != 0) {
    800260ce:	0004c783          	lbu	a5,0(s1)
    800260d2:	01378363          	beq	a5,s3,800260d8 <lookup_path+0x148>
    800260d6:	fbfd                	bnez	a5,800260cc <lookup_path+0x13c>
    int len = path - s;
    800260d8:	40b4863b          	subw	a2,s1,a1
    if (len > FAT32_MAX_FILENAME) {
    800260dc:	f6cad6e3          	bge	s5,a2,80026048 <lookup_path+0xb8>
        len = FAT32_MAX_FILENAME;
    800260e0:	8656                	mv	a2,s5
    800260e2:	b7bd                	j	80026050 <lookup_path+0xc0>
    while (*path != '/' && *path != 0) {
    800260e4:	85a6                	mv	a1,s1
    int len = path - s;
    800260e6:	865a                	mv	a2,s6
    800260e8:	b785                	j	80026048 <lookup_path+0xb8>
    if (parent) {
    800260ea:	f00b8ee3          	beqz	s7,80026006 <lookup_path+0x76>
        eput(entry);
    800260ee:	854a                	mv	a0,s2
    800260f0:	fffff097          	auipc	ra,0xfffff
    800260f4:	71e080e7          	jalr	1822(ra) # 8002580e <eput>
        return 0;
    800260f8:	4901                	li	s2,0
    800260fa:	b731                	j	80026006 <lookup_path+0x76>
    if (*path == 0) { return 0; }
    800260fc:	d7fd                	beqz	a5,800260ea <lookup_path+0x15a>
    800260fe:	85a6                	mv	a1,s1
    80026100:	b7f1                	j	800260cc <lookup_path+0x13c>

0000000080026102 <ename>:

struct dirent *ename(char *path)
{
    80026102:	712d                	addi	sp,sp,-288
    80026104:	ee06                	sd	ra,280(sp)
    80026106:	ea22                	sd	s0,272(sp)
    80026108:	e626                	sd	s1,264(sp)
    8002610a:	1200                	addi	s0,sp,288
    8002610c:	84aa                	mv	s1,a0
    char name[FAT32_MAX_FILENAME + 1] = {0};
    8002610e:	10000613          	li	a2,256
    80026112:	4581                	li	a1,0
    80026114:	ee040513          	addi	a0,s0,-288
    80026118:	ffffa097          	auipc	ra,0xffffa
    8002611c:	520080e7          	jalr	1312(ra) # 80020638 <memset>
    return lookup_path(path, 0, name);
    80026120:	ee040613          	addi	a2,s0,-288
    80026124:	4581                	li	a1,0
    80026126:	8526                	mv	a0,s1
    80026128:	00000097          	auipc	ra,0x0
    8002612c:	e68080e7          	jalr	-408(ra) # 80025f90 <lookup_path>
}
    80026130:	60f2                	ld	ra,280(sp)
    80026132:	6452                	ld	s0,272(sp)
    80026134:	64b2                	ld	s1,264(sp)
    80026136:	6115                	addi	sp,sp,288
    80026138:	8082                	ret

000000008002613a <enameparent>:

struct dirent *enameparent(char *path, char *name)
{
    8002613a:	1141                	addi	sp,sp,-16
    8002613c:	e406                	sd	ra,8(sp)
    8002613e:	e022                	sd	s0,0(sp)
    80026140:	0800                	addi	s0,sp,16
    return lookup_path(path, 1, name);
    80026142:	862e                	mv	a2,a1
    80026144:	4585                	li	a1,1
    80026146:	00000097          	auipc	ra,0x0
    8002614a:	e4a080e7          	jalr	-438(ra) # 80025f90 <lookup_path>
}
    8002614e:	60a2                	ld	ra,8(sp)
    80026150:	6402                	ld	s0,0(sp)
    80026152:	0141                	addi	sp,sp,16
    80026154:	8082                	ret

0000000080026156 <spi_set_tmod>:
    spi_adapter->endian = endian;
}


static void spi_set_tmod(uint8 spi_num, uint32 tmod)
{
    80026156:	1141                	addi	sp,sp,-16
    80026158:	e406                	sd	ra,8(sp)
    8002615a:	e022                	sd	s0,0(sp)
    8002615c:	0800                	addi	s0,sp,16
    8002615e:	872a                	mv	a4,a0
    // configASSERT(spi_num < SPI_DEVICE_MAX);
    volatile spi_t *spi_handle = spi[spi_num];
    80026160:	00351693          	slli	a3,a0,0x3
    80026164:	00004797          	auipc	a5,0x4
    80026168:	c1478793          	addi	a5,a5,-1004 # 80029d78 <spi>
    8002616c:	97b6                	add	a5,a5,a3
    8002616e:	6388                	ld	a0,0(a5)
    uint8 tmod_offset = 0;
    switch(spi_num)
    80026170:	4689                	li	a3,2
    {
        case 0:
        case 1:
        case 2:
            tmod_offset = 8;
    80026172:	47a1                	li	a5,8
    switch(spi_num)
    80026174:	00e6f363          	bgeu	a3,a4,8002617a <spi_set_tmod+0x24>
            break;
        case 3:
        default:
            tmod_offset = 10;
    80026178:	47a9                	li	a5,10
            break;
    }
    set_bit(&spi_handle->ctrlr0, 3 << tmod_offset, tmod << tmod_offset);
    8002617a:	2781                	sext.w	a5,a5
    8002617c:	00f5963b          	sllw	a2,a1,a5
    80026180:	458d                	li	a1,3
    80026182:	00f595bb          	sllw	a1,a1,a5
    80026186:	00001097          	auipc	ra,0x1
    8002618a:	f3e080e7          	jalr	-194(ra) # 800270c4 <set_bit>
}
    8002618e:	60a2                	ld	ra,8(sp)
    80026190:	6402                	ld	s0,0(sp)
    80026192:	0141                	addi	sp,sp,16
    80026194:	8082                	ret

0000000080026196 <spi_init>:
{
    80026196:	1141                	addi	sp,sp,-16
    80026198:	e422                	sd	s0,8(sp)
    8002619a:	0800                	addi	s0,sp,16
    switch(spi_num)
    8002619c:	4785                	li	a5,1
    8002619e:	06a7f463          	bgeu	a5,a0,80026206 <spi_init+0x70>
    800261a2:	4789                	li	a5,2
    800261a4:	06f50563          	beq	a0,a5,8002620e <spi_init+0x78>
            work_mode_offset = 8;
    800261a8:	4321                	li	t1,8
            frf_offset = 22;
    800261aa:	48d9                	li	a7,22
            dfs_offset = 0;
    800261ac:	4801                	li	a6,0
    volatile spi_t *spi_adapter = spi[spi_num];
    800261ae:	1502                	slli	a0,a0,0x20
    800261b0:	9101                	srli	a0,a0,0x20
    800261b2:	050e                	slli	a0,a0,0x3
    800261b4:	00004797          	auipc	a5,0x4
    800261b8:	bc478793          	addi	a5,a5,-1084 # 80029d78 <spi>
    800261bc:	953e                	add	a0,a0,a5
    800261be:	611c                	ld	a5,0(a0)
    if(spi_adapter->baudr == 0)
    800261c0:	4bc8                	lw	a0,20(a5)
    800261c2:	2501                	sext.w	a0,a0
    800261c4:	e119                	bnez	a0,800261ca <spi_init+0x34>
        spi_adapter->baudr = 0x14;
    800261c6:	4551                	li	a0,20
    800261c8:	cbc8                	sw	a0,20(a5)
    spi_adapter->imr = 0x00;
    800261ca:	0207a623          	sw	zero,44(a5)
    spi_adapter->dmacr = 0x00;
    800261ce:	0407a623          	sw	zero,76(a5)
    spi_adapter->dmatdlr = 0x10;
    800261d2:	4541                	li	a0,16
    800261d4:	cba8                	sw	a0,80(a5)
    spi_adapter->dmardlr = 0x00;
    800261d6:	0407aa23          	sw	zero,84(a5)
    spi_adapter->ser = 0x00;
    800261da:	0007a823          	sw	zero,16(a5)
    spi_adapter->ssienr = 0x00;
    800261de:	0007a423          	sw	zero,8(a5)
    spi_adapter->ctrlr0 = (work_mode << work_mode_offset) | (frame_format << frf_offset) | ((data_bit_length - 1) << dfs_offset);
    800261e2:	006595bb          	sllw	a1,a1,t1
    800261e6:	0116163b          	sllw	a2,a2,a7
    800261ea:	8dd1                	or	a1,a1,a2
    800261ec:	16fd                	addi	a3,a3,-1
    800261ee:	010696b3          	sll	a3,a3,a6
    800261f2:	8dd5                	or	a1,a1,a3
    800261f4:	2581                	sext.w	a1,a1
    800261f6:	c38c                	sw	a1,0(a5)
    spi_adapter->spi_ctrlr0 = 0;
    800261f8:	0e07aa23          	sw	zero,244(a5)
    spi_adapter->endian = endian;
    800261fc:	10e7ac23          	sw	a4,280(a5)
}
    80026200:	6422                	ld	s0,8(sp)
    80026202:	0141                	addi	sp,sp,16
    80026204:	8082                	ret
            work_mode_offset = 6;
    80026206:	4319                	li	t1,6
            frf_offset = 21;
    80026208:	48d5                	li	a7,21
            dfs_offset = 16;
    8002620a:	4841                	li	a6,16
    8002620c:	b74d                	j	800261ae <spi_init+0x18>
    uint8 work_mode_offset = 0;
    8002620e:	4301                	li	t1,0
    uint8 frf_offset = 0;
    80026210:	4881                	li	a7,0
    uint8 dfs_offset = 0;
    80026212:	4801                	li	a6,0
    80026214:	bf69                	j	800261ae <spi_init+0x18>

0000000080026216 <spi_send_data_normal>:
        return SPI_TRANS_SHORT;
    return SPI_TRANS_INT;
}

void spi_send_data_normal(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *tx_buff, uint64 tx_len)
{
    80026216:	7119                	addi	sp,sp,-128
    80026218:	fc86                	sd	ra,120(sp)
    8002621a:	f8a2                	sd	s0,112(sp)
    8002621c:	f4a6                	sd	s1,104(sp)
    8002621e:	f0ca                	sd	s2,96(sp)
    80026220:	ecce                	sd	s3,88(sp)
    80026222:	e8d2                	sd	s4,80(sp)
    80026224:	e4d6                	sd	s5,72(sp)
    80026226:	e0da                	sd	s6,64(sp)
    80026228:	fc5e                	sd	s7,56(sp)
    8002622a:	f862                	sd	s8,48(sp)
    8002622c:	f466                	sd	s9,40(sp)
    8002622e:	f06a                	sd	s10,32(sp)
    80026230:	ec6e                	sd	s11,24(sp)
    80026232:	0100                	addi	s0,sp,128
    80026234:	84aa                	mv	s1,a0
    80026236:	8aae                	mv	s5,a1
    80026238:	89b2                	mv	s3,a2
    8002623a:	8a36                	mv	s4,a3
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);

    uint64 index, fifo_len;
    spi_set_tmod(spi_num, SPI_TMOD_TRANS);
    8002623c:	4585                	li	a1,1
    8002623e:	0ff57513          	andi	a0,a0,255
    80026242:	00000097          	auipc	ra,0x0
    80026246:	f14080e7          	jalr	-236(ra) # 80026156 <spi_set_tmod>

    volatile spi_t *spi_handle = spi[spi_num];
    8002624a:	02049793          	slli	a5,s1,0x20
    8002624e:	9381                	srli	a5,a5,0x20
    80026250:	00379713          	slli	a4,a5,0x3
    80026254:	00004797          	auipc	a5,0x4
    80026258:	b2478793          	addi	a5,a5,-1244 # 80029d78 <spi>
    8002625c:	97ba                	add	a5,a5,a4
    8002625e:	0007b903          	ld	s2,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    80026262:	0024b493          	sltiu	s1,s1,2
    80026266:	0492                	slli	s1,s1,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    80026268:	00092783          	lw	a5,0(s2)
    8002626c:	0097d4bb          	srlw	s1,a5,s1
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    80026270:	88fd                	andi	s1,s1,31
    if(data_bit_length < 8)
    80026272:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    80026274:	4b85                	li	s7,1
    if(data_bit_length < 8)
    80026276:	0097f663          	bgeu	a5,s1,80026282 <spi_send_data_normal+0x6c>
    else if(data_bit_length < 16)
    8002627a:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    8002627c:	4b91                	li	s7,4
    else if(data_bit_length < 16)
    8002627e:	0297f863          	bgeu	a5,s1,800262ae <spi_send_data_normal+0x98>

    uint8 v_misalign_flag = 0;
    uint32 v_send_data;
    if((uintptr_t)tx_buff % frame_width)
    80026282:	020b9c93          	slli	s9,s7,0x20
    80026286:	020cdc93          	srli	s9,s9,0x20
    8002628a:	0399fcb3          	remu	s9,s3,s9
        v_misalign_flag = 1;

    spi_handle->ssienr = 0x01;
    8002628e:	4785                	li	a5,1
    80026290:	00f92423          	sw	a5,8(s2)
    spi_handle->ser = 1U << chip_select;
    80026294:	4585                	li	a1,1
    80026296:	015595bb          	sllw	a1,a1,s5
    8002629a:	00b92823          	sw	a1,16(s2)
    uint32 i = 0;
    while(tx_len)
    8002629e:	120a0a63          	beqz	s4,800263d2 <spi_send_data_normal+0x1bc>
    uint32 i = 0;
    800262a2:	4481                	li	s1,0
    {
        fifo_len = 32 - spi_handle->txflr;
    800262a4:	02000c13          	li	s8,32
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
        switch(frame_width)
    800262a8:	4b09                	li	s6,2
    800262aa:	4a91                	li	s5,4
    800262ac:	a0b5                	j	80026318 <spi_send_data_normal+0x102>
        return SPI_TRANS_SHORT;
    800262ae:	4b89                	li	s7,2
    800262b0:	bfc9                	j	80026282 <spi_send_data_normal+0x6c>
        {
            case SPI_TRANS_INT:
                fifo_len = fifo_len / 4 * 4;
    800262b2:	ffc77d13          	andi	s10,a4,-4
                if(v_misalign_flag)
    800262b6:	020c9763          	bnez	s9,800262e4 <spi_send_data_normal+0xce>
                        spi_handle->dr[0] = v_send_data;
                        i += 4;
                    }
                } else
                {
                    for(index = 0; index < fifo_len / 4; index++)
    800262ba:	8309                	srli	a4,a4,0x2
    800262bc:	009705bb          	addw	a1,a4,s1
    800262c0:	87a6                	mv	a5,s1
    800262c2:	c739                	beqz	a4,80026310 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint32 *)tx_buff)[i++];
    800262c4:	0017869b          	addiw	a3,a5,1
    800262c8:	0006861b          	sext.w	a2,a3
    800262cc:	1782                	slli	a5,a5,0x20
    800262ce:	9381                	srli	a5,a5,0x20
    800262d0:	078a                	slli	a5,a5,0x2
    800262d2:	97ce                	add	a5,a5,s3
    800262d4:	439c                	lw	a5,0(a5)
    800262d6:	06f92023          	sw	a5,96(s2)
    800262da:	87b2                	mv	a5,a2
                    for(index = 0; index < fifo_len / 4; index++)
    800262dc:	fec594e3          	bne	a1,a2,800262c4 <spi_send_data_normal+0xae>
    800262e0:	9cb9                	addw	s1,s1,a4
    800262e2:	a03d                	j	80026310 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 4)
    800262e4:	020d0663          	beqz	s10,80026310 <spi_send_data_normal+0xfa>
    800262e8:	4d81                	li	s11,0
                        memmove(&v_send_data, tx_buff + i, 4);
    800262ea:	02049593          	slli	a1,s1,0x20
    800262ee:	9181                	srli	a1,a1,0x20
    800262f0:	8656                	mv	a2,s5
    800262f2:	95ce                	add	a1,a1,s3
    800262f4:	f8c40513          	addi	a0,s0,-116
    800262f8:	ffffa097          	auipc	ra,0xffffa
    800262fc:	3ac080e7          	jalr	940(ra) # 800206a4 <memmove>
                        spi_handle->dr[0] = v_send_data;
    80026300:	f8c42783          	lw	a5,-116(s0)
    80026304:	06f92023          	sw	a5,96(s2)
                        i += 4;
    80026308:	2491                	addiw	s1,s1,4
                    for(index = 0; index < fifo_len; index += 4)
    8002630a:	0d91                	addi	s11,s11,4
    8002630c:	fdadefe3          	bltu	s11,s10,800262ea <spi_send_data_normal+0xd4>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = tx_buff[i++];
                break;
        }
        tx_len -= fifo_len;
    80026310:	41aa0a33          	sub	s4,s4,s10
    while(tx_len)
    80026314:	0a0a0f63          	beqz	s4,800263d2 <spi_send_data_normal+0x1bc>
        fifo_len = 32 - spi_handle->txflr;
    80026318:	02092703          	lw	a4,32(s2)
    8002631c:	40ec073b          	subw	a4,s8,a4
    80026320:	1702                	slli	a4,a4,0x20
    80026322:	9301                	srli	a4,a4,0x20
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    80026324:	00ea7363          	bgeu	s4,a4,8002632a <spi_send_data_normal+0x114>
    80026328:	8752                	mv	a4,s4
        switch(frame_width)
    8002632a:	036b8a63          	beq	s7,s6,8002635e <spi_send_data_normal+0x148>
    8002632e:	f95b82e3          	beq	s7,s5,800262b2 <spi_send_data_normal+0x9c>
    80026332:	009705bb          	addw	a1,a4,s1
                for(index = 0; index < fifo_len; index++)
    80026336:	87a6                	mv	a5,s1
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    80026338:	8d3a                	mv	s10,a4
                for(index = 0; index < fifo_len; index++)
    8002633a:	db79                	beqz	a4,80026310 <spi_send_data_normal+0xfa>
                    spi_handle->dr[0] = tx_buff[i++];
    8002633c:	0017869b          	addiw	a3,a5,1
    80026340:	0006861b          	sext.w	a2,a3
    80026344:	1782                	slli	a5,a5,0x20
    80026346:	9381                	srli	a5,a5,0x20
    80026348:	97ce                	add	a5,a5,s3
    8002634a:	0007c783          	lbu	a5,0(a5)
    8002634e:	06f92023          	sw	a5,96(s2)
    80026352:	87b2                	mv	a5,a2
                for(index = 0; index < fifo_len; index++)
    80026354:	fec594e3          	bne	a1,a2,8002633c <spi_send_data_normal+0x126>
    80026358:	9cb9                	addw	s1,s1,a4
        fifo_len = fifo_len < tx_len ? fifo_len : tx_len;
    8002635a:	8d3a                	mv	s10,a4
    8002635c:	bf55                	j	80026310 <spi_send_data_normal+0xfa>
                fifo_len = fifo_len / 2 * 2;
    8002635e:	ffe77d13          	andi	s10,a4,-2
                if(v_misalign_flag)
    80026362:	020c9863          	bnez	s9,80026392 <spi_send_data_normal+0x17c>
                    for(index = 0; index < fifo_len / 2; index++)
    80026366:	8305                	srli	a4,a4,0x1
    80026368:	009705bb          	addw	a1,a4,s1
    8002636c:	87a6                	mv	a5,s1
    8002636e:	d34d                	beqz	a4,80026310 <spi_send_data_normal+0xfa>
                        spi_handle->dr[0] = ((uint16 *)tx_buff)[i++];
    80026370:	0017869b          	addiw	a3,a5,1
    80026374:	0006861b          	sext.w	a2,a3
    80026378:	1782                	slli	a5,a5,0x20
    8002637a:	9381                	srli	a5,a5,0x20
    8002637c:	0786                	slli	a5,a5,0x1
    8002637e:	97ce                	add	a5,a5,s3
    80026380:	0007d783          	lhu	a5,0(a5)
    80026384:	06f92023          	sw	a5,96(s2)
    80026388:	87b2                	mv	a5,a2
                    for(index = 0; index < fifo_len / 2; index++)
    8002638a:	fec593e3          	bne	a1,a2,80026370 <spi_send_data_normal+0x15a>
    8002638e:	9cb9                	addw	s1,s1,a4
    80026390:	b741                	j	80026310 <spi_send_data_normal+0xfa>
                    for(index = 0; index < fifo_len; index += 2)
    80026392:	f60d0fe3          	beqz	s10,80026310 <spi_send_data_normal+0xfa>
    80026396:	fffd0d93          	addi	s11,s10,-1
    8002639a:	001ddd93          	srli	s11,s11,0x1
    8002639e:	001d9d9b          	slliw	s11,s11,0x1
    800263a2:	0024879b          	addiw	a5,s1,2
    800263a6:	00fd8dbb          	addw	s11,s11,a5
                        memmove(&v_send_data, tx_buff + i, 2);
    800263aa:	02049593          	slli	a1,s1,0x20
    800263ae:	9181                	srli	a1,a1,0x20
    800263b0:	865a                	mv	a2,s6
    800263b2:	95ce                	add	a1,a1,s3
    800263b4:	f8c40513          	addi	a0,s0,-116
    800263b8:	ffffa097          	auipc	ra,0xffffa
    800263bc:	2ec080e7          	jalr	748(ra) # 800206a4 <memmove>
                        spi_handle->dr[0] = v_send_data;
    800263c0:	f8c42783          	lw	a5,-116(s0)
    800263c4:	06f92023          	sw	a5,96(s2)
                        i += 2;
    800263c8:	2489                	addiw	s1,s1,2
                    for(index = 0; index < fifo_len; index += 2)
    800263ca:	fe9d90e3          	bne	s11,s1,800263aa <spi_send_data_normal+0x194>
                        i += 2;
    800263ce:	84ee                	mv	s1,s11
    800263d0:	b781                	j	80026310 <spi_send_data_normal+0xfa>
    }
    while((spi_handle->sr & 0x05) != 0x04)
    800263d2:	4711                	li	a4,4
    800263d4:	02892783          	lw	a5,40(s2)
    800263d8:	8b95                	andi	a5,a5,5
    800263da:	fee79de3          	bne	a5,a4,800263d4 <spi_send_data_normal+0x1be>
        ;
    spi_handle->ser = 0x00;
    800263de:	00092823          	sw	zero,16(s2)
    spi_handle->ssienr = 0x00;
    800263e2:	00092423          	sw	zero,8(s2)
}
    800263e6:	70e6                	ld	ra,120(sp)
    800263e8:	7446                	ld	s0,112(sp)
    800263ea:	74a6                	ld	s1,104(sp)
    800263ec:	7906                	ld	s2,96(sp)
    800263ee:	69e6                	ld	s3,88(sp)
    800263f0:	6a46                	ld	s4,80(sp)
    800263f2:	6aa6                	ld	s5,72(sp)
    800263f4:	6b06                	ld	s6,64(sp)
    800263f6:	7be2                	ld	s7,56(sp)
    800263f8:	7c42                	ld	s8,48(sp)
    800263fa:	7ca2                	ld	s9,40(sp)
    800263fc:	7d02                	ld	s10,32(sp)
    800263fe:	6de2                	ld	s11,24(sp)
    80026400:	6109                	addi	sp,sp,128
    80026402:	8082                	ret

0000000080026404 <spi_send_data_standard>:

void spi_send_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                            uint64 cmd_len, const uint8 *tx_buff, uint64 tx_len)
{
    80026404:	715d                	addi	sp,sp,-80
    80026406:	e486                	sd	ra,72(sp)
    80026408:	e0a2                	sd	s0,64(sp)
    8002640a:	fc26                	sd	s1,56(sp)
    8002640c:	f84a                	sd	s2,48(sp)
    8002640e:	f44e                	sd	s3,40(sp)
    80026410:	f052                	sd	s4,32(sp)
    80026412:	ec56                	sd	s5,24(sp)
    80026414:	e85a                	sd	s6,16(sp)
    80026416:	e45e                	sd	s7,8(sp)
    80026418:	0880                	addi	s0,sp,80
    8002641a:	8a2a                	mv	s4,a0
    8002641c:	8aae                	mv	s5,a1
    8002641e:	8bb2                	mv	s7,a2
    80026420:	8936                	mv	s2,a3
    80026422:	8b3a                	mv	s6,a4
    80026424:	89be                	mv	s3,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    // uint8 *v_buf = malloc(cmd_len + tx_len);
    uint8 *v_buf = kalloc();
    80026426:	ffffa097          	auipc	ra,0xffffa
    8002642a:	026080e7          	jalr	38(ra) # 8002044c <kalloc>
    8002642e:	84aa                	mv	s1,a0
    uint64 i;
    for(i = 0; i < cmd_len; i++)
    80026430:	00090e63          	beqz	s2,8002644c <spi_send_data_standard+0x48>
    80026434:	87de                	mv	a5,s7
    80026436:	872a                	mv	a4,a0
    80026438:	012b8633          	add	a2,s7,s2
        v_buf[i] = cmd_buff[i];
    8002643c:	0007c683          	lbu	a3,0(a5)
    80026440:	00d70023          	sb	a3,0(a4)
    80026444:	0785                	addi	a5,a5,1
    80026446:	0705                	addi	a4,a4,1
    for(i = 0; i < cmd_len; i++)
    80026448:	fec79ae3          	bne	a5,a2,8002643c <spi_send_data_standard+0x38>
    for(i = 0; i < tx_len; i++)
    8002644c:	00098f63          	beqz	s3,8002646a <spi_send_data_standard+0x66>
    80026450:	87da                	mv	a5,s6
    80026452:	012486b3          	add	a3,s1,s2
    80026456:	013b0733          	add	a4,s6,s3
        v_buf[cmd_len + i] = tx_buff[i];
    8002645a:	0007c603          	lbu	a2,0(a5)
    8002645e:	00c68023          	sb	a2,0(a3)
    80026462:	0785                	addi	a5,a5,1
    80026464:	0685                	addi	a3,a3,1
    for(i = 0; i < tx_len; i++)
    80026466:	fee79ae3          	bne	a5,a4,8002645a <spi_send_data_standard+0x56>

    spi_send_data_normal(spi_num, chip_select, v_buf, cmd_len + tx_len);
    8002646a:	013906b3          	add	a3,s2,s3
    8002646e:	8626                	mv	a2,s1
    80026470:	85d6                	mv	a1,s5
    80026472:	8552                	mv	a0,s4
    80026474:	00000097          	auipc	ra,0x0
    80026478:	da2080e7          	jalr	-606(ra) # 80026216 <spi_send_data_normal>
    // free((void *)v_buf);
    kfree((void *)v_buf);
    8002647c:	8526                	mv	a0,s1
    8002647e:	ffffa097          	auipc	ra,0xffffa
    80026482:	ebc080e7          	jalr	-324(ra) # 8002033a <kfree>
}
    80026486:	60a6                	ld	ra,72(sp)
    80026488:	6406                	ld	s0,64(sp)
    8002648a:	74e2                	ld	s1,56(sp)
    8002648c:	7942                	ld	s2,48(sp)
    8002648e:	79a2                	ld	s3,40(sp)
    80026490:	7a02                	ld	s4,32(sp)
    80026492:	6ae2                	ld	s5,24(sp)
    80026494:	6b42                	ld	s6,16(sp)
    80026496:	6ba2                	ld	s7,8(sp)
    80026498:	6161                	addi	sp,sp,80
    8002649a:	8082                	ret

000000008002649c <spi_receive_data_standard>:

void spi_receive_data_standard(spi_device_num_t spi_num, spi_chip_select_t chip_select, const uint8 *cmd_buff,
                               uint64 cmd_len, uint8 *rx_buff, uint64 rx_len)
{
    8002649c:	7139                	addi	sp,sp,-64
    8002649e:	fc06                	sd	ra,56(sp)
    800264a0:	f822                	sd	s0,48(sp)
    800264a2:	f426                	sd	s1,40(sp)
    800264a4:	f04a                	sd	s2,32(sp)
    800264a6:	ec4e                	sd	s3,24(sp)
    800264a8:	e852                	sd	s4,16(sp)
    800264aa:	e456                	sd	s5,8(sp)
    800264ac:	e05a                	sd	s6,0(sp)
    800264ae:	0080                	addi	s0,sp,64
    800264b0:	89aa                	mv	s3,a0
    800264b2:	8aae                	mv	s5,a1
    800264b4:	8932                	mv	s2,a2
    800264b6:	8a36                	mv	s4,a3
    800264b8:	84ba                	mv	s1,a4
    800264ba:	8b3e                	mv	s6,a5
    // configASSERT(spi_num < SPI_DEVICE_MAX && spi_num != 2);
    uint64 index, fifo_len;
    if(cmd_len == 0)
    800264bc:	eab5                	bnez	a3,80026530 <spi_receive_data_standard+0x94>
        spi_set_tmod(spi_num, SPI_TMOD_RECV);
    800264be:	4589                	li	a1,2
    800264c0:	0ff57513          	andi	a0,a0,255
    800264c4:	00000097          	auipc	ra,0x0
    800264c8:	c92080e7          	jalr	-878(ra) # 80026156 <spi_set_tmod>
    else
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    volatile spi_t *spi_handle = spi[spi_num];
    800264cc:	02099793          	slli	a5,s3,0x20
    800264d0:	9381                	srli	a5,a5,0x20
    800264d2:	00379713          	slli	a4,a5,0x3
    800264d6:	00004797          	auipc	a5,0x4
    800264da:	8a278793          	addi	a5,a5,-1886 # 80029d78 <spi>
    800264de:	97ba                	add	a5,a5,a4
    800264e0:	6398                	ld	a4,0(a5)
    uint8 dfs_offset = 0;
    switch(spi_num)
    {
        case 0:
        case 1:
            dfs_offset = 16;
    800264e2:	0029b993          	sltiu	s3,s3,2
    800264e6:	0992                	slli	s3,s3,0x4
        case 3:
        default:
            dfs_offset = 0;
            break;
    }
    uint32 data_bit_length = (spi_handle->ctrlr0 >> dfs_offset) & 0x1F;
    800264e8:	431c                	lw	a5,0(a4)
    800264ea:	0137d9bb          	srlw	s3,a5,s3
    spi_transfer_width_t frame_width = spi_get_frame_size(data_bit_length);
    800264ee:	01f9f993          	andi	s3,s3,31
    if(data_bit_length < 8)
    800264f2:	479d                	li	a5,7
        return SPI_TRANS_CHAR;
    800264f4:	4605                	li	a2,1
    if(data_bit_length < 8)
    800264f6:	0137f663          	bgeu	a5,s3,80026502 <spi_receive_data_standard+0x66>
    else if(data_bit_length < 16)
    800264fa:	47bd                	li	a5,15
    return SPI_TRANS_INT;
    800264fc:	4611                	li	a2,4
    else if(data_bit_length < 16)
    800264fe:	0537f163          	bgeu	a5,s3,80026540 <spi_receive_data_standard+0xa4>

    uint32 i = 0;
    uint64 v_cmd_len = cmd_len / frame_width;
    80026502:	02061793          	slli	a5,a2,0x20
    80026506:	9381                	srli	a5,a5,0x20
    80026508:	02fa58b3          	divu	a7,s4,a5
    uint32 v_rx_len = rx_len / frame_width;
    8002650c:	02fb56b3          	divu	a3,s6,a5
    80026510:	2681                	sext.w	a3,a3

    spi_handle->ctrlr1 = (uint32)(v_rx_len - 1);
    80026512:	fff6859b          	addiw	a1,a3,-1
    80026516:	c34c                	sw	a1,4(a4)
    spi_handle->ssienr = 0x01;
    80026518:	4585                	li	a1,1
    8002651a:	c70c                	sw	a1,8(a4)

    while(v_cmd_len)
    8002651c:	0cfa6163          	bltu	s4,a5,800265de <spi_receive_data_standard+0x142>
            default:
                for(index = 0; index < fifo_len; index++)
                    spi_handle->dr[0] = cmd_buff[i++];
                break;
        }
        spi_handle->ser = 1U << chip_select;
    80026520:	015595bb          	sllw	a1,a1,s5
    uint32 i = 0;
    80026524:	4301                	li	t1,0
        fifo_len = 32 - spi_handle->txflr;
    80026526:	02000f13          	li	t5,32
        switch(frame_width)
    8002652a:	4e89                	li	t4,2
    8002652c:	4e11                	li	t3,4
    8002652e:	a0a1                	j	80026576 <spi_receive_data_standard+0xda>
        spi_set_tmod(spi_num, SPI_TMOD_EEROM);
    80026530:	458d                	li	a1,3
    80026532:	0ff57513          	andi	a0,a0,255
    80026536:	00000097          	auipc	ra,0x0
    8002653a:	c20080e7          	jalr	-992(ra) # 80026156 <spi_set_tmod>
    8002653e:	b779                	j	800264cc <spi_receive_data_standard+0x30>
        return SPI_TRANS_SHORT;
    80026540:	4609                	li	a2,2
    80026542:	b7c1                	j	80026502 <spi_receive_data_standard+0x66>
    80026544:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    80026548:	879a                	mv	a5,t1
    8002654a:	c10d                	beqz	a0,8002656c <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = ((uint16 *)cmd_buff)[i++];
    8002654c:	0017881b          	addiw	a6,a5,1
    80026550:	00080f9b          	sext.w	t6,a6
    80026554:	1782                	slli	a5,a5,0x20
    80026556:	9381                	srli	a5,a5,0x20
    80026558:	0786                	slli	a5,a5,0x1
    8002655a:	97ca                	add	a5,a5,s2
    8002655c:	0007d783          	lhu	a5,0(a5)
    80026560:	d33c                	sw	a5,96(a4)
    80026562:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    80026564:	fff294e3          	bne	t0,t6,8002654c <spi_receive_data_standard+0xb0>
    80026568:	00a3033b          	addw	t1,t1,a0
        spi_handle->ser = 1U << chip_select;
    8002656c:	cb0c                	sw	a1,16(a4)
        v_cmd_len -= fifo_len;
    8002656e:	40a888b3          	sub	a7,a7,a0
    while(v_cmd_len)
    80026572:	06088e63          	beqz	a7,800265ee <spi_receive_data_standard+0x152>
        fifo_len = 32 - spi_handle->txflr;
    80026576:	5308                	lw	a0,32(a4)
    80026578:	40af053b          	subw	a0,t5,a0
    8002657c:	1502                	slli	a0,a0,0x20
    8002657e:	9101                	srli	a0,a0,0x20
        fifo_len = fifo_len < v_cmd_len ? fifo_len : v_cmd_len;
    80026580:	00a8f363          	bgeu	a7,a0,80026586 <spi_receive_data_standard+0xea>
    80026584:	8546                	mv	a0,a7
        switch(frame_width)
    80026586:	fbd60fe3          	beq	a2,t4,80026544 <spi_receive_data_standard+0xa8>
    8002658a:	03c61663          	bne	a2,t3,800265b6 <spi_receive_data_standard+0x11a>
    8002658e:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    80026592:	879a                	mv	a5,t1
    80026594:	dd61                	beqz	a0,8002656c <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = ((uint32 *)cmd_buff)[i++];
    80026596:	0017881b          	addiw	a6,a5,1
    8002659a:	00080f9b          	sext.w	t6,a6
    8002659e:	1782                	slli	a5,a5,0x20
    800265a0:	9381                	srli	a5,a5,0x20
    800265a2:	078a                	slli	a5,a5,0x2
    800265a4:	97ca                	add	a5,a5,s2
    800265a6:	439c                	lw	a5,0(a5)
    800265a8:	d33c                	sw	a5,96(a4)
    800265aa:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    800265ac:	fff295e3          	bne	t0,t6,80026596 <spi_receive_data_standard+0xfa>
    800265b0:	00a3033b          	addw	t1,t1,a0
    800265b4:	bf65                	j	8002656c <spi_receive_data_standard+0xd0>
    800265b6:	006502bb          	addw	t0,a0,t1
                for(index = 0; index < fifo_len; index++)
    800265ba:	879a                	mv	a5,t1
    800265bc:	d945                	beqz	a0,8002656c <spi_receive_data_standard+0xd0>
                    spi_handle->dr[0] = cmd_buff[i++];
    800265be:	0017881b          	addiw	a6,a5,1
    800265c2:	00080f9b          	sext.w	t6,a6
    800265c6:	1782                	slli	a5,a5,0x20
    800265c8:	9381                	srli	a5,a5,0x20
    800265ca:	97ca                	add	a5,a5,s2
    800265cc:	0007c783          	lbu	a5,0(a5)
    800265d0:	d33c                	sw	a5,96(a4)
    800265d2:	87fe                	mv	a5,t6
                for(index = 0; index < fifo_len; index++)
    800265d4:	fff295e3          	bne	t0,t6,800265be <spi_receive_data_standard+0x122>
    800265d8:	00a3033b          	addw	t1,t1,a0
    800265dc:	bf41                	j	8002656c <spi_receive_data_standard+0xd0>
    }

    if(cmd_len == 0)
    800265de:	000a1863          	bnez	s4,800265ee <spi_receive_data_standard+0x152>
    {
        spi_handle->dr[0] = 0xffffffff;
    800265e2:	57fd                	li	a5,-1
    800265e4:	d33c                	sw	a5,96(a4)
        spi_handle->ser = 1U << chip_select;
    800265e6:	4585                	li	a1,1
    800265e8:	015595bb          	sllw	a1,a1,s5
    800265ec:	cb0c                	sw	a1,16(a4)
    }

    i = 0;
    while(v_rx_len)
    800265ee:	c6c5                	beqz	a3,80026696 <spi_receive_data_standard+0x1fa>
    800265f0:	4301                	li	t1,0
    {
        fifo_len = spi_handle->rxflr;
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
        switch(frame_width)
    800265f2:	4e89                	li	t4,2
    800265f4:	4e11                	li	t3,4
    800265f6:	a805                	j	80026626 <spi_receive_data_standard+0x18a>
    800265f8:	00650f3b          	addw	t5,a0,t1
            case SPI_TRANS_INT:
                for(index = 0; index < fifo_len; index++)
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
                break;
            case SPI_TRANS_SHORT:
                for(index = 0; index < fifo_len; index++)
    800265fc:	879a                	mv	a5,t1
    800265fe:	c115                	beqz	a0,80026622 <spi_receive_data_standard+0x186>
                    ((uint16 *)rx_buff)[i++] = (uint16)spi_handle->dr[0];
    80026600:	06072883          	lw	a7,96(a4)
    80026604:	0017859b          	addiw	a1,a5,1
    80026608:	0005881b          	sext.w	a6,a1
    8002660c:	1782                	slli	a5,a5,0x20
    8002660e:	9381                	srli	a5,a5,0x20
    80026610:	0786                	slli	a5,a5,0x1
    80026612:	97a6                	add	a5,a5,s1
    80026614:	01179023          	sh	a7,0(a5)
    80026618:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    8002661a:	ff0f13e3          	bne	t5,a6,80026600 <spi_receive_data_standard+0x164>
    8002661e:	00a3033b          	addw	t1,t1,a0
                for(index = 0; index < fifo_len; index++)
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
                break;
        }

        v_rx_len -= fifo_len;
    80026622:	9e89                	subw	a3,a3,a0
    while(v_rx_len)
    80026624:	caad                	beqz	a3,80026696 <spi_receive_data_standard+0x1fa>
        fifo_len = spi_handle->rxflr;
    80026626:	535c                	lw	a5,36(a4)
    80026628:	1782                	slli	a5,a5,0x20
    8002662a:	9381                	srli	a5,a5,0x20
        fifo_len = fifo_len < v_rx_len ? fifo_len : v_rx_len;
    8002662c:	02069513          	slli	a0,a3,0x20
    80026630:	9101                	srli	a0,a0,0x20
    80026632:	00a7f363          	bgeu	a5,a0,80026638 <spi_receive_data_standard+0x19c>
    80026636:	853e                	mv	a0,a5
        switch(frame_width)
    80026638:	fdd600e3          	beq	a2,t4,800265f8 <spi_receive_data_standard+0x15c>
    8002663c:	03c61863          	bne	a2,t3,8002666c <spi_receive_data_standard+0x1d0>
    80026640:	00650f3b          	addw	t5,a0,t1
                for(index = 0; index < fifo_len; index++)
    80026644:	879a                	mv	a5,t1
    80026646:	dd71                	beqz	a0,80026622 <spi_receive_data_standard+0x186>
                    ((uint32 *)rx_buff)[i++] = spi_handle->dr[0];
    80026648:	0017859b          	addiw	a1,a5,1
    8002664c:	0005881b          	sext.w	a6,a1
    80026650:	06072883          	lw	a7,96(a4)
    80026654:	1782                	slli	a5,a5,0x20
    80026656:	9381                	srli	a5,a5,0x20
    80026658:	078a                	slli	a5,a5,0x2
    8002665a:	97a6                	add	a5,a5,s1
    8002665c:	0117a023          	sw	a7,0(a5)
    80026660:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    80026662:	ff0f13e3          	bne	t5,a6,80026648 <spi_receive_data_standard+0x1ac>
    80026666:	00a3033b          	addw	t1,t1,a0
    8002666a:	bf65                	j	80026622 <spi_receive_data_standard+0x186>
    8002666c:	00650f3b          	addw	t5,a0,t1
                for(index = 0; index < fifo_len; index++)
    80026670:	879a                	mv	a5,t1
    80026672:	d945                	beqz	a0,80026622 <spi_receive_data_standard+0x186>
                    rx_buff[i++] = (uint8)spi_handle->dr[0];
    80026674:	06072883          	lw	a7,96(a4)
    80026678:	0017859b          	addiw	a1,a5,1
    8002667c:	0005881b          	sext.w	a6,a1
    80026680:	1782                	slli	a5,a5,0x20
    80026682:	9381                	srli	a5,a5,0x20
    80026684:	97a6                	add	a5,a5,s1
    80026686:	01178023          	sb	a7,0(a5)
    8002668a:	87c2                	mv	a5,a6
                for(index = 0; index < fifo_len; index++)
    8002668c:	ff0f14e3          	bne	t5,a6,80026674 <spi_receive_data_standard+0x1d8>
    80026690:	00a3033b          	addw	t1,t1,a0
    80026694:	b779                	j	80026622 <spi_receive_data_standard+0x186>
    }

    spi_handle->ser = 0x00;
    80026696:	00072823          	sw	zero,16(a4)
    spi_handle->ssienr = 0x00;
    8002669a:	00072423          	sw	zero,8(a4)
    8002669e:	70e2                	ld	ra,56(sp)
    800266a0:	7442                	ld	s0,48(sp)
    800266a2:	74a2                	ld	s1,40(sp)
    800266a4:	7902                	ld	s2,32(sp)
    800266a6:	69e2                	ld	s3,24(sp)
    800266a8:	6a42                	ld	s4,16(sp)
    800266aa:	6aa2                	ld	s5,8(sp)
    800266ac:	6b02                	ld	s6,0(sp)
    800266ae:	6121                	addi	sp,sp,64
    800266b0:	8082                	ret

00000000800266b2 <gpiohs_set_drive_mode>:
} gpiohs_pin_instance_t;

static gpiohs_pin_instance_t pin_instance[32];

void gpiohs_set_drive_mode(uint8 pin, gpio_drive_mode_t mode)
{
    800266b2:	1101                	addi	sp,sp,-32
    800266b4:	ec06                	sd	ra,24(sp)
    800266b6:	e822                	sd	s0,16(sp)
    800266b8:	e426                	sd	s1,8(sp)
    800266ba:	e04a                	sd	s2,0(sp)
    800266bc:	1000                	addi	s0,sp,32
    800266be:	892a                	mv	s2,a0
    800266c0:	84ae                	mv	s1,a1
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    int io_number = fpioa_get_io_by_function(FUNC_GPIOHS0 + pin);
    800266c2:	0561                	addi	a0,a0,24
    800266c4:	00001097          	auipc	ra,0x1
    800266c8:	964080e7          	jalr	-1692(ra) # 80027028 <fpioa_get_io_by_function>
    // configASSERT(io_number >= 0);

    fpioa_pull_t pull = FPIOA_PULL_NONE;
    uint32 dir = 0;

    switch(mode)
    800266cc:	4789                	li	a5,2
    800266ce:	02f48963          	beq	s1,a5,80026700 <gpiohs_set_drive_mode+0x4e>
    800266d2:	478d                	li	a5,3
    800266d4:	00f48b63          	beq	s1,a5,800266ea <gpiohs_set_drive_mode+0x38>
    800266d8:	4785                	li	a5,1
    800266da:	02f48363          	beq	s1,a5,80026700 <gpiohs_set_drive_mode+0x4e>
        default:
            // configASSERT(!"GPIO drive mode is not supported.") 
            break;
    }

    fpioa_set_io_pull(io_number, pull);
    800266de:	4581                	li	a1,0
    800266e0:	00000097          	auipc	ra,0x0
    800266e4:	4c0080e7          	jalr	1216(ra) # 80026ba0 <fpioa_set_io_pull>
    volatile uint32 *reg = dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    800266e8:	a00d                	j	8002670a <gpiohs_set_drive_mode+0x58>
    fpioa_set_io_pull(io_number, pull);
    800266ea:	4585                	li	a1,1
    800266ec:	00000097          	auipc	ra,0x0
    800266f0:	4b4080e7          	jalr	1204(ra) # 80026ba0 <fpioa_set_io_pull>
    800266f4:	38001537          	lui	a0,0x38001
    800266f8:	00850493          	addi	s1,a0,8 # 38001008 <BASE_ADDRESS-0x4801eff8>
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    800266fc:	0511                	addi	a0,a0,4
    800266fe:	a819                	j	80026714 <gpiohs_set_drive_mode+0x62>
    fpioa_set_io_pull(io_number, pull);
    80026700:	85a6                	mv	a1,s1
    80026702:	00000097          	auipc	ra,0x0
    80026706:	49e080e7          	jalr	1182(ra) # 80026ba0 <fpioa_set_io_pull>
{
    8002670a:	38001537          	lui	a0,0x38001
    8002670e:	00450493          	addi	s1,a0,4 # 38001004 <BASE_ADDRESS-0x4801effc>
    volatile uint32 *reg_d = !dir ? gpiohs->output_en.u32 : gpiohs->input_en.u32;
    80026712:	0521                	addi	a0,a0,8
    set_gpio_bit(reg_d, pin, 0);
    80026714:	4601                	li	a2,0
    80026716:	85ca                	mv	a1,s2
    80026718:	00001097          	auipc	ra,0x1
    8002671c:	9e8080e7          	jalr	-1560(ra) # 80027100 <set_gpio_bit>
    set_gpio_bit(reg, pin, 1);
    80026720:	4605                	li	a2,1
    80026722:	85ca                	mv	a1,s2
    80026724:	8526                	mv	a0,s1
    80026726:	00001097          	auipc	ra,0x1
    8002672a:	9da080e7          	jalr	-1574(ra) # 80027100 <set_gpio_bit>
}
    8002672e:	60e2                	ld	ra,24(sp)
    80026730:	6442                	ld	s0,16(sp)
    80026732:	64a2                	ld	s1,8(sp)
    80026734:	6902                	ld	s2,0(sp)
    80026736:	6105                	addi	sp,sp,32
    80026738:	8082                	ret

000000008002673a <gpiohs_get_pin>:

gpio_pin_value_t gpiohs_get_pin(uint8 pin)
{
    8002673a:	1141                	addi	sp,sp,-16
    8002673c:	e406                	sd	ra,8(sp)
    8002673e:	e022                	sd	s0,0(sp)
    80026740:	0800                	addi	s0,sp,16
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    return get_gpio_bit(gpiohs->input_val.u32, pin);
    80026742:	85aa                	mv	a1,a0
    80026744:	38001537          	lui	a0,0x38001
    80026748:	00001097          	auipc	ra,0x1
    8002674c:	9f2080e7          	jalr	-1550(ra) # 8002713a <get_gpio_bit>
}
    80026750:	2501                	sext.w	a0,a0
    80026752:	60a2                	ld	ra,8(sp)
    80026754:	6402                	ld	s0,0(sp)
    80026756:	0141                	addi	sp,sp,16
    80026758:	8082                	ret

000000008002675a <gpiohs_set_pin>:

void gpiohs_set_pin(uint8 pin, gpio_pin_value_t value)
{
    8002675a:	1141                	addi	sp,sp,-16
    8002675c:	e406                	sd	ra,8(sp)
    8002675e:	e022                	sd	s0,0(sp)
    80026760:	0800                	addi	s0,sp,16
    // configASSERT(pin < GPIOHS_MAX_PINNO);
    set_gpio_bit(gpiohs->output_val.u32, pin, value);
    80026762:	862e                	mv	a2,a1
    80026764:	85aa                	mv	a1,a0
    80026766:	38001537          	lui	a0,0x38001
    8002676a:	0531                	addi	a0,a0,12
    8002676c:	00001097          	auipc	ra,0x1
    80026770:	994080e7          	jalr	-1644(ra) # 80027100 <set_gpio_bit>
}
    80026774:	60a2                	ld	ra,8(sp)
    80026776:	6402                	ld	s0,0(sp)
    80026778:	0141                	addi	sp,sp,16
    8002677a:	8082                	ret

000000008002677c <gpiohs_set_pin_edge>:

void gpiohs_set_pin_edge(uint8 pin, gpio_pin_edge_t edge)
{
    8002677c:	7179                	addi	sp,sp,-48
    8002677e:	f406                	sd	ra,40(sp)
    80026780:	f022                	sd	s0,32(sp)
    80026782:	ec26                	sd	s1,24(sp)
    80026784:	e84a                	sd	s2,16(sp)
    80026786:	e44e                	sd	s3,8(sp)
    80026788:	1800                	addi	s0,sp,48
    8002678a:	84aa                	mv	s1,a0
    8002678c:	89ae                	mv	s3,a1
    set_gpio_bit(gpiohs->rise_ie.u32, pin, 0);
    8002678e:	4601                	li	a2,0
    80026790:	85aa                	mv	a1,a0
    80026792:	38001937          	lui	s2,0x38001
    80026796:	01890513          	addi	a0,s2,24 # 38001018 <BASE_ADDRESS-0x4801efe8>
    8002679a:	00001097          	auipc	ra,0x1
    8002679e:	966080e7          	jalr	-1690(ra) # 80027100 <set_gpio_bit>
    set_gpio_bit(gpiohs->rise_ip.u32, pin, 1);
    800267a2:	4605                	li	a2,1
    800267a4:	85a6                	mv	a1,s1
    800267a6:	01c90513          	addi	a0,s2,28
    800267aa:	00001097          	auipc	ra,0x1
    800267ae:	956080e7          	jalr	-1706(ra) # 80027100 <set_gpio_bit>

    set_gpio_bit(gpiohs->fall_ie.u32, pin, 0);
    800267b2:	4601                	li	a2,0
    800267b4:	85a6                	mv	a1,s1
    800267b6:	02090513          	addi	a0,s2,32
    800267ba:	00001097          	auipc	ra,0x1
    800267be:	946080e7          	jalr	-1722(ra) # 80027100 <set_gpio_bit>
    set_gpio_bit(gpiohs->fall_ip.u32, pin, 1);
    800267c2:	4605                	li	a2,1
    800267c4:	85a6                	mv	a1,s1
    800267c6:	02490513          	addi	a0,s2,36
    800267ca:	00001097          	auipc	ra,0x1
    800267ce:	936080e7          	jalr	-1738(ra) # 80027100 <set_gpio_bit>

    set_gpio_bit(gpiohs->low_ie.u32, pin, 0);
    800267d2:	4601                	li	a2,0
    800267d4:	85a6                	mv	a1,s1
    800267d6:	03090513          	addi	a0,s2,48
    800267da:	00001097          	auipc	ra,0x1
    800267de:	926080e7          	jalr	-1754(ra) # 80027100 <set_gpio_bit>
    set_gpio_bit(gpiohs->low_ip.u32, pin, 1);
    800267e2:	4605                	li	a2,1
    800267e4:	85a6                	mv	a1,s1
    800267e6:	03490513          	addi	a0,s2,52
    800267ea:	00001097          	auipc	ra,0x1
    800267ee:	916080e7          	jalr	-1770(ra) # 80027100 <set_gpio_bit>

    set_gpio_bit(gpiohs->high_ie.u32, pin, 0);
    800267f2:	4601                	li	a2,0
    800267f4:	85a6                	mv	a1,s1
    800267f6:	02890513          	addi	a0,s2,40
    800267fa:	00001097          	auipc	ra,0x1
    800267fe:	906080e7          	jalr	-1786(ra) # 80027100 <set_gpio_bit>
    set_gpio_bit(gpiohs->high_ip.u32, pin, 1);
    80026802:	4605                	li	a2,1
    80026804:	85a6                	mv	a1,s1
    80026806:	02c90513          	addi	a0,s2,44
    8002680a:	00001097          	auipc	ra,0x1
    8002680e:	8f6080e7          	jalr	-1802(ra) # 80027100 <set_gpio_bit>

    if(edge & GPIO_PE_FALLING)
    80026812:	0019f793          	andi	a5,s3,1
    80026816:	cbad                	beqz	a5,80026888 <gpiohs_set_pin_edge+0x10c>
    {
        set_gpio_bit(gpiohs->fall_ie.u32, pin, 1);
    80026818:	4605                	li	a2,1
    8002681a:	85a6                	mv	a1,s1
    8002681c:	38001537          	lui	a0,0x38001
    80026820:	02050513          	addi	a0,a0,32 # 38001020 <BASE_ADDRESS-0x4801efe0>
    80026824:	00001097          	auipc	ra,0x1
    80026828:	8dc080e7          	jalr	-1828(ra) # 80027100 <set_gpio_bit>
    } else
    {
        set_gpio_bit(gpiohs->fall_ie.u32, pin, 0);
    }

    if(edge & GPIO_PE_RISING)
    8002682c:	0029f793          	andi	a5,s3,2
    80026830:	c7bd                	beqz	a5,8002689e <gpiohs_set_pin_edge+0x122>
    {
        set_gpio_bit(gpiohs->rise_ie.u32, pin, 1);
    80026832:	4605                	li	a2,1
    80026834:	85a6                	mv	a1,s1
    80026836:	38001537          	lui	a0,0x38001
    8002683a:	0561                	addi	a0,a0,24
    8002683c:	00001097          	auipc	ra,0x1
    80026840:	8c4080e7          	jalr	-1852(ra) # 80027100 <set_gpio_bit>
    } else
    {
        set_gpio_bit(gpiohs->rise_ie.u32, pin, 0);
    }

    if(edge & GPIO_PE_LOW)
    80026844:	0049f793          	andi	a5,s3,4
    80026848:	c7ad                	beqz	a5,800268b2 <gpiohs_set_pin_edge+0x136>
    {
        set_gpio_bit(gpiohs->low_ie.u32, pin, 1);
    8002684a:	4605                	li	a2,1
    8002684c:	85a6                	mv	a1,s1
    8002684e:	38001537          	lui	a0,0x38001
    80026852:	03050513          	addi	a0,a0,48 # 38001030 <BASE_ADDRESS-0x4801efd0>
    80026856:	00001097          	auipc	ra,0x1
    8002685a:	8aa080e7          	jalr	-1878(ra) # 80027100 <set_gpio_bit>
    } else
    {
        set_gpio_bit(gpiohs->low_ie.u32, pin, 0);
    }

    if(edge & GPIO_PE_HIGH)
    8002685e:	0089f993          	andi	s3,s3,8
    80026862:	06098363          	beqz	s3,800268c8 <gpiohs_set_pin_edge+0x14c>
    {
        set_gpio_bit(gpiohs->high_ie.u32, pin, 1);
    80026866:	4605                	li	a2,1
    80026868:	85a6                	mv	a1,s1
    8002686a:	38001537          	lui	a0,0x38001
    8002686e:	02850513          	addi	a0,a0,40 # 38001028 <BASE_ADDRESS-0x4801efd8>
    80026872:	00001097          	auipc	ra,0x1
    80026876:	88e080e7          	jalr	-1906(ra) # 80027100 <set_gpio_bit>
    {
        set_gpio_bit(gpiohs->high_ie.u32, pin, 0);
    }

    pin_instance[pin].edge = edge;
}
    8002687a:	70a2                	ld	ra,40(sp)
    8002687c:	7402                	ld	s0,32(sp)
    8002687e:	64e2                	ld	s1,24(sp)
    80026880:	6942                	ld	s2,16(sp)
    80026882:	69a2                	ld	s3,8(sp)
    80026884:	6145                	addi	sp,sp,48
    80026886:	8082                	ret
        set_gpio_bit(gpiohs->fall_ie.u32, pin, 0);
    80026888:	4601                	li	a2,0
    8002688a:	85a6                	mv	a1,s1
    8002688c:	38001537          	lui	a0,0x38001
    80026890:	02050513          	addi	a0,a0,32 # 38001020 <BASE_ADDRESS-0x4801efe0>
    80026894:	00001097          	auipc	ra,0x1
    80026898:	86c080e7          	jalr	-1940(ra) # 80027100 <set_gpio_bit>
    8002689c:	bf41                	j	8002682c <gpiohs_set_pin_edge+0xb0>
        set_gpio_bit(gpiohs->rise_ie.u32, pin, 0);
    8002689e:	4601                	li	a2,0
    800268a0:	85a6                	mv	a1,s1
    800268a2:	38001537          	lui	a0,0x38001
    800268a6:	0561                	addi	a0,a0,24
    800268a8:	00001097          	auipc	ra,0x1
    800268ac:	858080e7          	jalr	-1960(ra) # 80027100 <set_gpio_bit>
    800268b0:	bf51                	j	80026844 <gpiohs_set_pin_edge+0xc8>
        set_gpio_bit(gpiohs->low_ie.u32, pin, 0);
    800268b2:	4601                	li	a2,0
    800268b4:	85a6                	mv	a1,s1
    800268b6:	38001537          	lui	a0,0x38001
    800268ba:	03050513          	addi	a0,a0,48 # 38001030 <BASE_ADDRESS-0x4801efd0>
    800268be:	00001097          	auipc	ra,0x1
    800268c2:	842080e7          	jalr	-1982(ra) # 80027100 <set_gpio_bit>
    800268c6:	bf61                	j	8002685e <gpiohs_set_pin_edge+0xe2>
        set_gpio_bit(gpiohs->high_ie.u32, pin, 0);
    800268c8:	4601                	li	a2,0
    800268ca:	85a6                	mv	a1,s1
    800268cc:	38001537          	lui	a0,0x38001
    800268d0:	02850513          	addi	a0,a0,40 # 38001028 <BASE_ADDRESS-0x4801efd8>
    800268d4:	00001097          	auipc	ra,0x1
    800268d8:	82c080e7          	jalr	-2004(ra) # 80027100 <set_gpio_bit>
}
    800268dc:	bf79                	j	8002687a <gpiohs_set_pin_edge+0xfe>

00000000800268de <gpiohs_pin_onchange_isr>:

int gpiohs_pin_onchange_isr(void *userdata)
{
    800268de:	7179                	addi	sp,sp,-48
    800268e0:	f406                	sd	ra,40(sp)
    800268e2:	f022                	sd	s0,32(sp)
    800268e4:	ec26                	sd	s1,24(sp)
    800268e6:	e84a                	sd	s2,16(sp)
    800268e8:	e44e                	sd	s3,8(sp)
    800268ea:	1800                	addi	s0,sp,48
    800268ec:	84aa                	mv	s1,a0
    gpiohs_pin_instance_t *ctx = (gpiohs_pin_instance_t *)userdata;
    uint64 pin = ctx->pin;
    800268ee:	00053903          	ld	s2,0(a0)

    if(ctx->edge & GPIO_PE_FALLING)
    800268f2:	451c                	lw	a5,8(a0)
    800268f4:	8b85                	andi	a5,a5,1
    800268f6:	eb8d                	bnez	a5,80026928 <gpiohs_pin_onchange_isr+0x4a>
        set_gpio_bit(gpiohs->fall_ie.u32, pin, 0);
        set_gpio_bit(gpiohs->fall_ip.u32, pin, 1);
        set_gpio_bit(gpiohs->fall_ie.u32, pin, 1);
    }

    if(ctx->edge & GPIO_PE_RISING)
    800268f8:	449c                	lw	a5,8(s1)
    800268fa:	8b89                	andi	a5,a5,2
    800268fc:	e3ad                	bnez	a5,8002695e <gpiohs_pin_onchange_isr+0x80>
        set_gpio_bit(gpiohs->rise_ie.u32, pin, 0);
        set_gpio_bit(gpiohs->rise_ip.u32, pin, 1);
        set_gpio_bit(gpiohs->rise_ie.u32, pin, 1);
    }

    if(ctx->edge & GPIO_PE_LOW)
    800268fe:	449c                	lw	a5,8(s1)
    80026900:	8b91                	andi	a5,a5,4
    80026902:	ebc9                	bnez	a5,80026994 <gpiohs_pin_onchange_isr+0xb6>
        set_gpio_bit(gpiohs->low_ie.u32, pin, 0);
        set_gpio_bit(gpiohs->low_ip.u32, pin, 1);
        set_gpio_bit(gpiohs->low_ie.u32, pin, 1);
    }

    if(ctx->edge & GPIO_PE_HIGH)
    80026904:	449c                	lw	a5,8(s1)
    80026906:	8ba1                	andi	a5,a5,8
    80026908:	e3e9                	bnez	a5,800269ca <gpiohs_pin_onchange_isr+0xec>
        set_gpio_bit(gpiohs->high_ie.u32, pin, 0);
        set_gpio_bit(gpiohs->high_ip.u32, pin, 1);
        set_gpio_bit(gpiohs->high_ie.u32, pin, 1);
    }

    if(ctx->callback)
    8002690a:	689c                	ld	a5,16(s1)
    8002690c:	c391                	beqz	a5,80026910 <gpiohs_pin_onchange_isr+0x32>
        ctx->callback();
    8002690e:	9782                	jalr	a5
    if(ctx->gpiohs_callback)
    80026910:	6c9c                	ld	a5,24(s1)
    80026912:	c399                	beqz	a5,80026918 <gpiohs_pin_onchange_isr+0x3a>
        ctx->gpiohs_callback(ctx->context);
    80026914:	7088                	ld	a0,32(s1)
    80026916:	9782                	jalr	a5

    return 0;
}
    80026918:	4501                	li	a0,0
    8002691a:	70a2                	ld	ra,40(sp)
    8002691c:	7402                	ld	s0,32(sp)
    8002691e:	64e2                	ld	s1,24(sp)
    80026920:	6942                	ld	s2,16(sp)
    80026922:	69a2                	ld	s3,8(sp)
    80026924:	6145                	addi	sp,sp,48
    80026926:	8082                	ret
        set_gpio_bit(gpiohs->fall_ie.u32, pin, 0);
    80026928:	4601                	li	a2,0
    8002692a:	85ca                	mv	a1,s2
    8002692c:	380019b7          	lui	s3,0x38001
    80026930:	02098513          	addi	a0,s3,32 # 38001020 <BASE_ADDRESS-0x4801efe0>
    80026934:	00000097          	auipc	ra,0x0
    80026938:	7cc080e7          	jalr	1996(ra) # 80027100 <set_gpio_bit>
        set_gpio_bit(gpiohs->fall_ip.u32, pin, 1);
    8002693c:	4605                	li	a2,1
    8002693e:	85ca                	mv	a1,s2
    80026940:	02498513          	addi	a0,s3,36
    80026944:	00000097          	auipc	ra,0x0
    80026948:	7bc080e7          	jalr	1980(ra) # 80027100 <set_gpio_bit>
        set_gpio_bit(gpiohs->fall_ie.u32, pin, 1);
    8002694c:	4605                	li	a2,1
    8002694e:	85ca                	mv	a1,s2
    80026950:	02098513          	addi	a0,s3,32
    80026954:	00000097          	auipc	ra,0x0
    80026958:	7ac080e7          	jalr	1964(ra) # 80027100 <set_gpio_bit>
    8002695c:	bf71                	j	800268f8 <gpiohs_pin_onchange_isr+0x1a>
        set_gpio_bit(gpiohs->rise_ie.u32, pin, 0);
    8002695e:	4601                	li	a2,0
    80026960:	85ca                	mv	a1,s2
    80026962:	380019b7          	lui	s3,0x38001
    80026966:	01898513          	addi	a0,s3,24 # 38001018 <BASE_ADDRESS-0x4801efe8>
    8002696a:	00000097          	auipc	ra,0x0
    8002696e:	796080e7          	jalr	1942(ra) # 80027100 <set_gpio_bit>
        set_gpio_bit(gpiohs->rise_ip.u32, pin, 1);
    80026972:	4605                	li	a2,1
    80026974:	85ca                	mv	a1,s2
    80026976:	01c98513          	addi	a0,s3,28
    8002697a:	00000097          	auipc	ra,0x0
    8002697e:	786080e7          	jalr	1926(ra) # 80027100 <set_gpio_bit>
        set_gpio_bit(gpiohs->rise_ie.u32, pin, 1);
    80026982:	4605                	li	a2,1
    80026984:	85ca                	mv	a1,s2
    80026986:	01898513          	addi	a0,s3,24
    8002698a:	00000097          	auipc	ra,0x0
    8002698e:	776080e7          	jalr	1910(ra) # 80027100 <set_gpio_bit>
    80026992:	b7b5                	j	800268fe <gpiohs_pin_onchange_isr+0x20>
        set_gpio_bit(gpiohs->low_ie.u32, pin, 0);
    80026994:	4601                	li	a2,0
    80026996:	85ca                	mv	a1,s2
    80026998:	380019b7          	lui	s3,0x38001
    8002699c:	03098513          	addi	a0,s3,48 # 38001030 <BASE_ADDRESS-0x4801efd0>
    800269a0:	00000097          	auipc	ra,0x0
    800269a4:	760080e7          	jalr	1888(ra) # 80027100 <set_gpio_bit>
        set_gpio_bit(gpiohs->low_ip.u32, pin, 1);
    800269a8:	4605                	li	a2,1
    800269aa:	85ca                	mv	a1,s2
    800269ac:	03498513          	addi	a0,s3,52
    800269b0:	00000097          	auipc	ra,0x0
    800269b4:	750080e7          	jalr	1872(ra) # 80027100 <set_gpio_bit>
        set_gpio_bit(gpiohs->low_ie.u32, pin, 1);
    800269b8:	4605                	li	a2,1
    800269ba:	85ca                	mv	a1,s2
    800269bc:	03098513          	addi	a0,s3,48
    800269c0:	00000097          	auipc	ra,0x0
    800269c4:	740080e7          	jalr	1856(ra) # 80027100 <set_gpio_bit>
    800269c8:	bf35                	j	80026904 <gpiohs_pin_onchange_isr+0x26>
        set_gpio_bit(gpiohs->high_ie.u32, pin, 0);
    800269ca:	4601                	li	a2,0
    800269cc:	85ca                	mv	a1,s2
    800269ce:	380019b7          	lui	s3,0x38001
    800269d2:	02898513          	addi	a0,s3,40 # 38001028 <BASE_ADDRESS-0x4801efd8>
    800269d6:	00000097          	auipc	ra,0x0
    800269da:	72a080e7          	jalr	1834(ra) # 80027100 <set_gpio_bit>
        set_gpio_bit(gpiohs->high_ip.u32, pin, 1);
    800269de:	4605                	li	a2,1
    800269e0:	85ca                	mv	a1,s2
    800269e2:	02c98513          	addi	a0,s3,44
    800269e6:	00000097          	auipc	ra,0x0
    800269ea:	71a080e7          	jalr	1818(ra) # 80027100 <set_gpio_bit>
        set_gpio_bit(gpiohs->high_ie.u32, pin, 1);
    800269ee:	4605                	li	a2,1
    800269f0:	85ca                	mv	a1,s2
    800269f2:	02898513          	addi	a0,s3,40
    800269f6:	00000097          	auipc	ra,0x0
    800269fa:	70a080e7          	jalr	1802(ra) # 80027100 <set_gpio_bit>
    800269fe:	b731                	j	8002690a <gpiohs_pin_onchange_isr+0x2c>

0000000080026a00 <gpiohs_set_irq>:

void gpiohs_set_irq(uint8 pin, uint32 priority, void (*func)())
{
    80026a00:	1141                	addi	sp,sp,-16
    80026a02:	e422                	sd	s0,8(sp)
    80026a04:	0800                	addi	s0,sp,16
    pin_instance[pin].callback = func;

    // plic_set_priority(IRQN_GPIOHS0_INTERRUPT + pin, priority);
    // plic_irq_register(IRQN_GPIOHS0_INTERRUPT + pin, gpiohs_pin_onchange_isr, &(pin_instance[pin]));
    // plic_irq_enable(IRQN_GPIOHS0_INTERRUPT + pin);
}
    80026a06:	6422                	ld	s0,8(sp)
    80026a08:	0141                	addi	sp,sp,16
    80026a0a:	8082                	ret

0000000080026a0c <gpiohs_irq_register>:

void gpiohs_irq_register(uint8 pin, uint32 priority, plic_irq_callback_t callback, void *ctx)
{
    80026a0c:	1141                	addi	sp,sp,-16
    80026a0e:	e422                	sd	s0,8(sp)
    80026a10:	0800                	addi	s0,sp,16
    pin_instance[pin].context = ctx;

    // plic_set_priority(IRQN_GPIOHS0_INTERRUPT + pin, priority);
    // plic_irq_register(IRQN_GPIOHS0_INTERRUPT + pin, gpiohs_pin_onchange_isr, &(pin_instance[pin]));
    // plic_irq_enable(IRQN_GPIOHS0_INTERRUPT + pin);
}
    80026a12:	6422                	ld	s0,8(sp)
    80026a14:	0141                	addi	sp,sp,16
    80026a16:	8082                	ret

0000000080026a18 <gpiohs_irq_unregister>:

void gpiohs_irq_unregister(uint8 pin)
{
    80026a18:	1101                	addi	sp,sp,-32
    80026a1a:	ec06                	sd	ra,24(sp)
    80026a1c:	e822                	sd	s0,16(sp)
    80026a1e:	e426                	sd	s1,8(sp)
    80026a20:	e04a                	sd	s2,0(sp)
    80026a22:	1000                	addi	s0,sp,32
    80026a24:	892a                	mv	s2,a0
    pin_instance[pin] = (gpiohs_pin_instance_t){
        .callback = NULL,
        .gpiohs_callback = NULL,
        .context = NULL,
    };
    set_gpio_bit(gpiohs->rise_ie.u32, pin, 0);
    80026a26:	4601                	li	a2,0
    80026a28:	85aa                	mv	a1,a0
    80026a2a:	380014b7          	lui	s1,0x38001
    80026a2e:	01848513          	addi	a0,s1,24 # 38001018 <BASE_ADDRESS-0x4801efe8>
    80026a32:	00000097          	auipc	ra,0x0
    80026a36:	6ce080e7          	jalr	1742(ra) # 80027100 <set_gpio_bit>
    set_gpio_bit(gpiohs->fall_ie.u32, pin, 0);
    80026a3a:	4601                	li	a2,0
    80026a3c:	85ca                	mv	a1,s2
    80026a3e:	02048513          	addi	a0,s1,32
    80026a42:	00000097          	auipc	ra,0x0
    80026a46:	6be080e7          	jalr	1726(ra) # 80027100 <set_gpio_bit>
    set_gpio_bit(gpiohs->low_ie.u32, pin, 0);
    80026a4a:	4601                	li	a2,0
    80026a4c:	85ca                	mv	a1,s2
    80026a4e:	03048513          	addi	a0,s1,48
    80026a52:	00000097          	auipc	ra,0x0
    80026a56:	6ae080e7          	jalr	1710(ra) # 80027100 <set_gpio_bit>
    set_gpio_bit(gpiohs->high_ie.u32, pin, 0);
    80026a5a:	4601                	li	a2,0
    80026a5c:	85ca                	mv	a1,s2
    80026a5e:	02848513          	addi	a0,s1,40
    80026a62:	00000097          	auipc	ra,0x0
    80026a66:	69e080e7          	jalr	1694(ra) # 80027100 <set_gpio_bit>
    // plic_irq_unregister(IRQN_GPIOHS0_INTERRUPT + pin);
}
    80026a6a:	60e2                	ld	ra,24(sp)
    80026a6c:	6442                	ld	s0,16(sp)
    80026a6e:	64a2                	ld	s1,8(sp)
    80026a70:	6902                	ld	s2,0(sp)
    80026a72:	6105                	addi	sp,sp,32
    80026a74:	8082                	ret

0000000080026a76 <gpiohs_irq_disable>:

void gpiohs_irq_disable(uint64 pin)
{
    80026a76:	1141                	addi	sp,sp,-16
    80026a78:	e422                	sd	s0,8(sp)
    80026a7a:	0800                	addi	s0,sp,16
    // plic_irq_disable(IRQN_GPIOHS0_INTERRUPT + pin);
    80026a7c:	6422                	ld	s0,8(sp)
    80026a7e:	0141                	addi	sp,sp,16
    80026a80:	8082                	ret

0000000080026a82 <fpioa_init>:
         .resv0 = 0,
         .pad_di = 0},
};

int fpioa_init(void)
{
    80026a82:	715d                	addi	sp,sp,-80
    80026a84:	e4a2                	sd	s0,72(sp)
    80026a86:	0880                	addi	s0,sp,80

    /* Enable fpioa clock in system controller */
    // sysctl_clock_enable(SYSCTL_CLOCK_FPIOA);

    /* Initialize tie */
    fpioa_tie_t tie = {0};
    80026a88:	fa043823          	sd	zero,-80(s0)
    80026a8c:	fa043c23          	sd	zero,-72(s0)
    80026a90:	fc043023          	sd	zero,-64(s0)
    80026a94:	fc043423          	sd	zero,-56(s0)
    80026a98:	fc043823          	sd	zero,-48(s0)
    80026a9c:	fc043c23          	sd	zero,-40(s0)
    80026aa0:	fe043023          	sd	zero,-32(s0)
    80026aa4:	fe043423          	sd	zero,-24(s0)

    /* Set tie enable and tie value */
    for(i = 0; i < FUNC_MAX; i++)
    80026aa8:	4581                	li	a1,0
    {
        tie.en[i / 32] |= (function_config[i].tie_en << (i % 32));
    80026aaa:	00003897          	auipc	a7,0x3
    80026aae:	2ee88893          	addi	a7,a7,750 # 80029d98 <function_config>
    for(i = 0; i < FUNC_MAX; i++)
    80026ab2:	10000813          	li	a6,256
        tie.en[i / 32] |= (function_config[i].tie_en << (i % 32));
    80026ab6:	41f5d79b          	sraiw	a5,a1,0x1f
    80026aba:	01b7d79b          	srliw	a5,a5,0x1b
    80026abe:	00b786bb          	addw	a3,a5,a1
    80026ac2:	4056d71b          	sraiw	a4,a3,0x5
    80026ac6:	8afd                	andi	a3,a3,31
    80026ac8:	9e9d                	subw	a3,a3,a5
    80026aca:	00271513          	slli	a0,a4,0x2
    80026ace:	ff040793          	addi	a5,s0,-16
    80026ad2:	953e                	add	a0,a0,a5
    80026ad4:	00259793          	slli	a5,a1,0x2
    80026ad8:	97c6                	add	a5,a5,a7
    80026ada:	439c                	lw	a5,0(a5)
    80026adc:	0187d61b          	srliw	a2,a5,0x18
    80026ae0:	8a05                	andi	a2,a2,1
    80026ae2:	00d6163b          	sllw	a2,a2,a3
    80026ae6:	fc052303          	lw	t1,-64(a0)
    80026aea:	00666633          	or	a2,a2,t1
    80026aee:	fcc52023          	sw	a2,-64(a0)
        tie.val[i / 32] |= (function_config[i].tie_val << (i % 32));
    80026af2:	0721                	addi	a4,a4,8
    80026af4:	070a                	slli	a4,a4,0x2
    80026af6:	ff040613          	addi	a2,s0,-16
    80026afa:	9732                	add	a4,a4,a2
    80026afc:	0197d79b          	srliw	a5,a5,0x19
    80026b00:	8b85                	andi	a5,a5,1
    80026b02:	00d797bb          	sllw	a5,a5,a3
    80026b06:	fc072683          	lw	a3,-64(a4)
    80026b0a:	8fd5                	or	a5,a5,a3
    80026b0c:	fcf72023          	sw	a5,-64(a4)
    for(i = 0; i < FUNC_MAX; i++)
    80026b10:	2585                	addiw	a1,a1,1
    80026b12:	fb0592e3          	bne	a1,a6,80026ab6 <fpioa_init+0x34>
    80026b16:	fb040693          	addi	a3,s0,-80
    }

    /* Atomic write every 32bit register to fpioa function */
    for(i = 0; i < FUNC_MAX / 32; i++)
    80026b1a:	4701                	li	a4,0
    80026b1c:	502b0537          	lui	a0,0x502b0
    80026b20:	45a1                	li	a1,8
    {
        /* Set value before enable */
        fpioa->tie.val[i] = tie.val[i];
    80026b22:	5290                	lw	a2,32(a3)
    80026b24:	00271793          	slli	a5,a4,0x2
    80026b28:	97aa                	add	a5,a5,a0
    80026b2a:	0ec7a023          	sw	a2,224(a5)
        fpioa->tie.en[i] = tie.en[i];
    80026b2e:	4290                	lw	a2,0(a3)
    80026b30:	0cc7a023          	sw	a2,192(a5)
    for(i = 0; i < FUNC_MAX / 32; i++)
    80026b34:	2705                	addiw	a4,a4,1
    80026b36:	0691                	addi	a3,a3,4
    80026b38:	feb715e3          	bne	a4,a1,80026b22 <fpioa_init+0xa0>
    }

    return 0;
}
    80026b3c:	4501                	li	a0,0
    80026b3e:	6426                	ld	s0,72(sp)
    80026b40:	6161                	addi	sp,sp,80
    80026b42:	8082                	ret

0000000080026b44 <fpioa_get_io>:

int fpioa_get_io(int number, fpioa_io_config_t *cfg)
{
    80026b44:	1141                	addi	sp,sp,-16
    80026b46:	e422                	sd	s0,8(sp)
    80026b48:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || cfg == NULL)
    80026b4a:	02f00713          	li	a4,47
    80026b4e:	00a76e63          	bltu	a4,a0,80026b6a <fpioa_get_io+0x26>
    80026b52:	cd91                	beqz	a1,80026b6e <fpioa_get_io+0x2a>
        return -1;
    /* Atomic read register */
    *cfg = fpioa->io[number];
    80026b54:	00251793          	slli	a5,a0,0x2
    80026b58:	502b0737          	lui	a4,0x502b0
    80026b5c:	97ba                	add	a5,a5,a4
    80026b5e:	439c                	lw	a5,0(a5)
    80026b60:	c19c                	sw	a5,0(a1)
    return 0;
    80026b62:	4501                	li	a0,0
}
    80026b64:	6422                	ld	s0,8(sp)
    80026b66:	0141                	addi	sp,sp,16
    80026b68:	8082                	ret
        return -1;
    80026b6a:	557d                	li	a0,-1
    80026b6c:	bfe5                	j	80026b64 <fpioa_get_io+0x20>
    80026b6e:	557d                	li	a0,-1
    80026b70:	bfd5                	j	80026b64 <fpioa_get_io+0x20>

0000000080026b72 <fpioa_set_io>:

int fpioa_set_io(int number, fpioa_io_config_t *cfg)
{
    80026b72:	1141                	addi	sp,sp,-16
    80026b74:	e422                	sd	s0,8(sp)
    80026b76:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || cfg == NULL)
    80026b78:	02f00713          	li	a4,47
    80026b7c:	00a76e63          	bltu	a4,a0,80026b98 <fpioa_set_io+0x26>
    80026b80:	cd91                	beqz	a1,80026b9c <fpioa_set_io+0x2a>
        return -1;
    /* Atomic write register */
    fpioa->io[number] = *cfg;
    80026b82:	00251793          	slli	a5,a0,0x2
    80026b86:	502b0737          	lui	a4,0x502b0
    80026b8a:	97ba                	add	a5,a5,a4
    80026b8c:	4198                	lw	a4,0(a1)
    80026b8e:	c398                	sw	a4,0(a5)
    return 0;
    80026b90:	4501                	li	a0,0
}
    80026b92:	6422                	ld	s0,8(sp)
    80026b94:	0141                	addi	sp,sp,16
    80026b96:	8082                	ret
        return -1;
    80026b98:	557d                	li	a0,-1
    80026b9a:	bfe5                	j	80026b92 <fpioa_set_io+0x20>
    80026b9c:	557d                	li	a0,-1
    80026b9e:	bfd5                	j	80026b92 <fpioa_set_io+0x20>

0000000080026ba0 <fpioa_set_io_pull>:

int fpioa_set_io_pull(int number, fpioa_pull_t pull)
{
    80026ba0:	1141                	addi	sp,sp,-16
    80026ba2:	e422                	sd	s0,8(sp)
    80026ba4:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || pull >= FPIOA_PULL_MAX)
    80026ba6:	02f00793          	li	a5,47
    80026baa:	06a7e963          	bltu	a5,a0,80026c1c <fpioa_set_io_pull+0x7c>
    80026bae:	862a                	mv	a2,a0
    80026bb0:	4789                	li	a5,2
    80026bb2:	06b7e763          	bltu	a5,a1,80026c20 <fpioa_set_io_pull+0x80>
        return -1;

    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80026bb6:	00251713          	slli	a4,a0,0x2
    80026bba:	502b07b7          	lui	a5,0x502b0
    80026bbe:	97ba                	add	a5,a5,a4
    80026bc0:	439c                	lw	a5,0(a5)
    80026bc2:	0107d69b          	srliw	a3,a5,0x10
    80026bc6:	8a85                	andi	a3,a3,1
    80026bc8:	0117d71b          	srliw	a4,a5,0x11
    80026bcc:	8b05                	andi	a4,a4,1

    switch(pull)
    80026bce:	4505                	li	a0,1
    80026bd0:	02a58d63          	beq	a1,a0,80026c0a <fpioa_set_io_pull+0x6a>
    80026bd4:	cd95                	beqz	a1,80026c10 <fpioa_set_io_pull+0x70>
    80026bd6:	4509                	li	a0,2
    80026bd8:	02a58f63          	beq	a1,a0,80026c16 <fpioa_set_io_pull+0x76>
            break;
        default:
            break;
    }
    /* Atomic write register */
    fpioa->io[number] = cfg;
    80026bdc:	8a85                	andi	a3,a3,1
    80026bde:	0106969b          	slliw	a3,a3,0x10
    80026be2:	75c1                	lui	a1,0xffff0
    80026be4:	15fd                	addi	a1,a1,-1
    80026be6:	8fed                	and	a5,a5,a1
    80026be8:	8fd5                	or	a5,a5,a3
    80026bea:	8b05                	andi	a4,a4,1
    80026bec:	0117171b          	slliw	a4,a4,0x11
    80026bf0:	7681                	lui	a3,0xfffe0
    80026bf2:	16fd                	addi	a3,a3,-1
    80026bf4:	8ff5                	and	a5,a5,a3
    80026bf6:	8fd9                	or	a5,a5,a4
    80026bf8:	060a                	slli	a2,a2,0x2
    80026bfa:	502b0737          	lui	a4,0x502b0
    80026bfe:	963a                	add	a2,a2,a4
    80026c00:	c21c                	sw	a5,0(a2)
    return 0;
    80026c02:	4501                	li	a0,0
}
    80026c04:	6422                	ld	s0,8(sp)
    80026c06:	0141                	addi	sp,sp,16
    80026c08:	8082                	ret
            cfg.pd = 1;
    80026c0a:	4705                	li	a4,1
            cfg.pu = 0;
    80026c0c:	4681                	li	a3,0
    80026c0e:	b7f9                	j	80026bdc <fpioa_set_io_pull+0x3c>
            cfg.pd = 0;
    80026c10:	4701                	li	a4,0
            cfg.pu = 0;
    80026c12:	4681                	li	a3,0
    80026c14:	b7e1                	j	80026bdc <fpioa_set_io_pull+0x3c>
            cfg.pd = 0;
    80026c16:	4701                	li	a4,0
            cfg.pu = 1;
    80026c18:	4685                	li	a3,1
    80026c1a:	b7c9                	j	80026bdc <fpioa_set_io_pull+0x3c>
        return -1;
    80026c1c:	557d                	li	a0,-1
    80026c1e:	b7dd                	j	80026c04 <fpioa_set_io_pull+0x64>
    80026c20:	557d                	li	a0,-1
    80026c22:	b7cd                	j	80026c04 <fpioa_set_io_pull+0x64>

0000000080026c24 <fpioa_get_io_pull>:

int fpioa_get_io_pull(int number)
{
    80026c24:	1141                	addi	sp,sp,-16
    80026c26:	e422                	sd	s0,8(sp)
    80026c28:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO)
    80026c2a:	02f00713          	li	a4,47
    80026c2e:	02a76a63          	bltu	a4,a0,80026c62 <fpioa_get_io_pull+0x3e>
        return -1;

    fpioa_pull_t pull;
    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80026c32:	00251793          	slli	a5,a0,0x2
    80026c36:	502b0737          	lui	a4,0x502b0
    80026c3a:	97ba                	add	a5,a5,a4
    80026c3c:	439c                	lw	a5,0(a5)

    if(cfg.pu == 0 && cfg.pd == 1)
    80026c3e:	00030537          	lui	a0,0x30
    80026c42:	8fe9                	and	a5,a5,a0
    80026c44:	00020737          	lui	a4,0x20
        pull = FPIOA_PULL_DOWN;
    80026c48:	4505                	li	a0,1
    if(cfg.pu == 0 && cfg.pd == 1)
    80026c4a:	00e78863          	beq	a5,a4,80026c5a <fpioa_get_io_pull+0x36>
    else if(cfg.pu == 1 && cfg.pd == 0)
    80026c4e:	6541                	lui	a0,0x10
        pull = FPIOA_PULL_UP;
    else
        pull = FPIOA_PULL_NONE;
    80026c50:	40a78533          	sub	a0,a5,a0
    80026c54:	00153513          	seqz	a0,a0
    80026c58:	0506                	slli	a0,a0,0x1
    return pull;
    80026c5a:	2501                	sext.w	a0,a0
}
    80026c5c:	6422                	ld	s0,8(sp)
    80026c5e:	0141                	addi	sp,sp,16
    80026c60:	8082                	ret
        return -1;
    80026c62:	557d                	li	a0,-1
    80026c64:	bfe5                	j	80026c5c <fpioa_get_io_pull+0x38>

0000000080026c66 <fpioa_set_io_driving>:

int fpioa_set_io_driving(int number, fpioa_driving_t driving)
{
    80026c66:	1141                	addi	sp,sp,-16
    80026c68:	e422                	sd	s0,8(sp)
    80026c6a:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || driving >= FPIOA_DRIVING_MAX)
    80026c6c:	02f00713          	li	a4,47
    80026c70:	02a76863          	bltu	a4,a0,80026ca0 <fpioa_set_io_driving+0x3a>
    80026c74:	473d                	li	a4,15
    80026c76:	02b76763          	bltu	a4,a1,80026ca4 <fpioa_set_io_driving+0x3e>
        return -1;

    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80026c7a:	00251793          	slli	a5,a0,0x2
    80026c7e:	502b0537          	lui	a0,0x502b0
    80026c82:	953e                	add	a0,a0,a5
    80026c84:	411c                	lw	a5,0(a0)
    /* Set IO driving */
    cfg.ds = driving;
    /* Atomic write register */
    fpioa->io[number] = cfg;
    80026c86:	89bd                	andi	a1,a1,15
    80026c88:	0085959b          	slliw	a1,a1,0x8
    80026c8c:	777d                	lui	a4,0xfffff
    80026c8e:	0ff70713          	addi	a4,a4,255 # fffffffffffff0ff <kernel_end+0xffffffff7ffbf0ff>
    80026c92:	8ff9                	and	a5,a5,a4
    80026c94:	8ddd                	or	a1,a1,a5
    80026c96:	c10c                	sw	a1,0(a0)
    return 0;
    80026c98:	4501                	li	a0,0
}
    80026c9a:	6422                	ld	s0,8(sp)
    80026c9c:	0141                	addi	sp,sp,16
    80026c9e:	8082                	ret
        return -1;
    80026ca0:	557d                	li	a0,-1
    80026ca2:	bfe5                	j	80026c9a <fpioa_set_io_driving+0x34>
    80026ca4:	557d                	li	a0,-1
    80026ca6:	bfd5                	j	80026c9a <fpioa_set_io_driving+0x34>

0000000080026ca8 <fpioa_set_sl>:

int fpioa_set_sl(int number, uint8 sl_enable)
{
    80026ca8:	1141                	addi	sp,sp,-16
    80026caa:	e422                	sd	s0,8(sp)
    80026cac:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO)
    80026cae:	02f00713          	li	a4,47
    80026cb2:	02a76563          	bltu	a4,a0,80026cdc <fpioa_set_sl+0x34>
        return -1;

    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80026cb6:	00251793          	slli	a5,a0,0x2
    80026cba:	502b0537          	lui	a0,0x502b0
    80026cbe:	953e                	add	a0,a0,a5
    80026cc0:	411c                	lw	a5,0(a0)
    /* Set IO slew rate */
    cfg.sl = sl_enable;
    /* Atomic write register */
    fpioa->io[number] = cfg;
    80026cc2:	8985                	andi	a1,a1,1
    80026cc4:	0135959b          	slliw	a1,a1,0x13
    80026cc8:	fff80737          	lui	a4,0xfff80
    80026ccc:	177d                	addi	a4,a4,-1
    80026cce:	8ff9                	and	a5,a5,a4
    80026cd0:	8ddd                	or	a1,a1,a5
    80026cd2:	c10c                	sw	a1,0(a0)
    return 0;
    80026cd4:	4501                	li	a0,0
}
    80026cd6:	6422                	ld	s0,8(sp)
    80026cd8:	0141                	addi	sp,sp,16
    80026cda:	8082                	ret
        return -1;
    80026cdc:	557d                	li	a0,-1
    80026cde:	bfe5                	j	80026cd6 <fpioa_set_sl+0x2e>

0000000080026ce0 <fpioa_set_st>:

int fpioa_set_st(int number, uint8 st_enable)
{
    80026ce0:	1141                	addi	sp,sp,-16
    80026ce2:	e422                	sd	s0,8(sp)
    80026ce4:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO)
    80026ce6:	02f00713          	li	a4,47
    80026cea:	02a76563          	bltu	a4,a0,80026d14 <fpioa_set_st+0x34>
        return -1;

    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80026cee:	00251793          	slli	a5,a0,0x2
    80026cf2:	502b0537          	lui	a0,0x502b0
    80026cf6:	953e                	add	a0,a0,a5
    80026cf8:	411c                	lw	a5,0(a0)
    /* Set IO schmitt trigger */
    cfg.st = st_enable;
    /* Atomic write register */
    fpioa->io[number] = cfg;
    80026cfa:	8985                	andi	a1,a1,1
    80026cfc:	0175959b          	slliw	a1,a1,0x17
    80026d00:	ff800737          	lui	a4,0xff800
    80026d04:	177d                	addi	a4,a4,-1
    80026d06:	8ff9                	and	a5,a5,a4
    80026d08:	8ddd                	or	a1,a1,a5
    80026d0a:	c10c                	sw	a1,0(a0)
    return 0;
    80026d0c:	4501                	li	a0,0
}
    80026d0e:	6422                	ld	s0,8(sp)
    80026d10:	0141                	addi	sp,sp,16
    80026d12:	8082                	ret
        return -1;
    80026d14:	557d                	li	a0,-1
    80026d16:	bfe5                	j	80026d0e <fpioa_set_st+0x2e>

0000000080026d18 <fpioa_set_oe_inv>:

int fpioa_set_oe_inv(int number, uint8 inv_enable)
{
    80026d18:	1141                	addi	sp,sp,-16
    80026d1a:	e422                	sd	s0,8(sp)
    80026d1c:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO)
    80026d1e:	02f00713          	li	a4,47
    80026d22:	02a76463          	bltu	a4,a0,80026d4a <fpioa_set_oe_inv+0x32>
        return -1;

    /* Atomic read register */
    fpioa_io_config_t cfg = fpioa->io[number];
    80026d26:	00251793          	slli	a5,a0,0x2
    80026d2a:	502b0537          	lui	a0,0x502b0
    80026d2e:	953e                	add	a0,a0,a5
    80026d30:	411c                	lw	a5,0(a0)
    /* Set IO schmitt trigger */
    cfg.oe_inv = inv_enable;
    /* Atomic write register */
    fpioa->io[number] = cfg;
    80026d32:	8985                	andi	a1,a1,1
    80026d34:	00d5959b          	slliw	a1,a1,0xd
    80026d38:	7779                	lui	a4,0xffffe
    80026d3a:	177d                	addi	a4,a4,-1
    80026d3c:	8ff9                	and	a5,a5,a4
    80026d3e:	8ddd                	or	a1,a1,a5
    80026d40:	c10c                	sw	a1,0(a0)
    return 0;
    80026d42:	4501                	li	a0,0
}
    80026d44:	6422                	ld	s0,8(sp)
    80026d46:	0141                	addi	sp,sp,16
    80026d48:	8082                	ret
        return -1;
    80026d4a:	557d                	li	a0,-1
    80026d4c:	bfe5                	j	80026d44 <fpioa_set_oe_inv+0x2c>

0000000080026d4e <fpioa_get_io_driving>:

int fpioa_get_io_driving(int number)
{
    80026d4e:	1141                	addi	sp,sp,-16
    80026d50:	e422                	sd	s0,8(sp)
    80026d52:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO)
    80026d54:	02f00713          	li	a4,47
    80026d58:	00a76e63          	bltu	a4,a0,80026d74 <fpioa_get_io_driving+0x26>
        return -1;

    return fpioa->io[number].ds;
    80026d5c:	00251793          	slli	a5,a0,0x2
    80026d60:	502b0737          	lui	a4,0x502b0
    80026d64:	97ba                	add	a5,a5,a4
    80026d66:	4388                	lw	a0,0(a5)
    80026d68:	0085551b          	srliw	a0,a0,0x8
    80026d6c:	893d                	andi	a0,a0,15
}
    80026d6e:	6422                	ld	s0,8(sp)
    80026d70:	0141                	addi	sp,sp,16
    80026d72:	8082                	ret
        return -1;
    80026d74:	557d                	li	a0,-1
    80026d76:	bfe5                	j	80026d6e <fpioa_get_io_driving+0x20>

0000000080026d78 <fpioa_set_function_raw>:

int fpioa_set_function_raw(int number, fpioa_function_t function)
{
    80026d78:	1141                	addi	sp,sp,-16
    80026d7a:	e422                	sd	s0,8(sp)
    80026d7c:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80026d7e:	02f00793          	li	a5,47
    80026d82:	12a7e863          	bltu	a5,a0,80026eb2 <fpioa_set_function_raw+0x13a>
    80026d86:	882a                	mv	a6,a0
    80026d88:	0ff00793          	li	a5,255
    80026d8c:	12b7e563          	bltu	a5,a1,80026eb6 <fpioa_set_function_raw+0x13e>
        return -1;
    /* Atomic write register */
    fpioa->io[number] = (const fpioa_io_config_t){
        .ch_sel = function_config[function].ch_sel,
    80026d90:	1582                	slli	a1,a1,0x20
    80026d92:	9181                	srli	a1,a1,0x20
    80026d94:	058a                	slli	a1,a1,0x2
    80026d96:	00003397          	auipc	t2,0x3
    80026d9a:	00238393          	addi	t2,t2,2 # 80029d98 <function_config>
    80026d9e:	93ae                	add	t2,t2,a1
        .ds = function_config[function].ds,
    80026da0:	0003a583          	lw	a1,0(t2)
    80026da4:	0085d61b          	srliw	a2,a1,0x8
        .oe_en = function_config[function].oe_en,
    80026da8:	00c5d69b          	srliw	a3,a1,0xc
        .oe_inv = function_config[function].oe_inv,
    80026dac:	00d5df9b          	srliw	t6,a1,0xd
        .do_sel = function_config[function].do_sel,
    80026db0:	00e5df1b          	srliw	t5,a1,0xe
        .do_inv = function_config[function].do_inv,
    80026db4:	00f5d71b          	srliw	a4,a1,0xf
        .pu = function_config[function].pu,
    80026db8:	0105de9b          	srliw	t4,a1,0x10
        .pd = function_config[function].pd,
    80026dbc:	0115de1b          	srliw	t3,a1,0x11
        .sl = function_config[function].sl,
    80026dc0:	0135d79b          	srliw	a5,a1,0x13
        .ie_en = function_config[function].ie_en,
    80026dc4:	0145d31b          	srliw	t1,a1,0x14
        .ie_inv = function_config[function].ie_inv,
    80026dc8:	0155d89b          	srliw	a7,a1,0x15
        .di_inv = function_config[function].di_inv,
    80026dcc:	0165d51b          	srliw	a0,a1,0x16
        .st = function_config[function].st,
    80026dd0:	0175d59b          	srliw	a1,a1,0x17
    fpioa->io[number] = (const fpioa_io_config_t){
    80026dd4:	8a3d                	andi	a2,a2,15
    80026dd6:	0086129b          	slliw	t0,a2,0x8
    80026dda:	0003c603          	lbu	a2,0(t2)
    80026dde:	00566633          	or	a2,a2,t0
    80026de2:	8a85                	andi	a3,a3,1
    80026de4:	00c6969b          	slliw	a3,a3,0xc
    80026de8:	72fd                	lui	t0,0xfffff
    80026dea:	12fd                	addi	t0,t0,-1
    80026dec:	00567633          	and	a2,a2,t0
    80026df0:	8e55                	or	a2,a2,a3
    80026df2:	001fff93          	andi	t6,t6,1
    80026df6:	00df9f9b          	slliw	t6,t6,0xd
    80026dfa:	76f9                	lui	a3,0xffffe
    80026dfc:	16fd                	addi	a3,a3,-1
    80026dfe:	8ef1                	and	a3,a3,a2
    80026e00:	01f6e633          	or	a2,a3,t6
    80026e04:	001f7693          	andi	a3,t5,1
    80026e08:	00e69f1b          	slliw	t5,a3,0xe
    80026e0c:	76f1                	lui	a3,0xffffc
    80026e0e:	16fd                	addi	a3,a3,-1
    80026e10:	8ef1                	and	a3,a3,a2
    80026e12:	01e6e6b3          	or	a3,a3,t5
    80026e16:	8b05                	andi	a4,a4,1
    80026e18:	00f7171b          	slliw	a4,a4,0xf
    80026e1c:	7661                	lui	a2,0xffff8
    80026e1e:	167d                	addi	a2,a2,-1
    80026e20:	8ef1                	and	a3,a3,a2
    80026e22:	8ed9                	or	a3,a3,a4
    80026e24:	001ef613          	andi	a2,t4,1
    80026e28:	0106161b          	slliw	a2,a2,0x10
    80026e2c:	7741                	lui	a4,0xffff0
    80026e2e:	177d                	addi	a4,a4,-1
    80026e30:	8f75                	and	a4,a4,a3
    80026e32:	00c766b3          	or	a3,a4,a2
    80026e36:	001e7713          	andi	a4,t3,1
    80026e3a:	0117161b          	slliw	a2,a4,0x11
    80026e3e:	7701                	lui	a4,0xfffe0
    80026e40:	177d                	addi	a4,a4,-1
    80026e42:	8f75                	and	a4,a4,a3
    80026e44:	8f51                	or	a4,a4,a2
    80026e46:	8b85                	andi	a5,a5,1
    80026e48:	0137979b          	slliw	a5,a5,0x13
    80026e4c:	fff806b7          	lui	a3,0xfff80
    80026e50:	16fd                	addi	a3,a3,-1
    80026e52:	8f75                	and	a4,a4,a3
    80026e54:	8f5d                	or	a4,a4,a5
    80026e56:	00137693          	andi	a3,t1,1
    80026e5a:	0146969b          	slliw	a3,a3,0x14
    80026e5e:	fff007b7          	lui	a5,0xfff00
    80026e62:	17fd                	addi	a5,a5,-1
    80026e64:	8ff9                	and	a5,a5,a4
    80026e66:	00d7e733          	or	a4,a5,a3
    80026e6a:	0018f793          	andi	a5,a7,1
    80026e6e:	0157969b          	slliw	a3,a5,0x15
    80026e72:	ffe007b7          	lui	a5,0xffe00
    80026e76:	17fd                	addi	a5,a5,-1
    80026e78:	8ff9                	and	a5,a5,a4
    80026e7a:	8fd5                	or	a5,a5,a3
    80026e7c:	00157713          	andi	a4,a0,1
    80026e80:	0167171b          	slliw	a4,a4,0x16
    80026e84:	ffc006b7          	lui	a3,0xffc00
    80026e88:	16fd                	addi	a3,a3,-1
    80026e8a:	8ff5                	and	a5,a5,a3
    80026e8c:	8fd9                	or	a5,a5,a4
    80026e8e:	8985                	andi	a1,a1,1
    80026e90:	0175959b          	slliw	a1,a1,0x17
    80026e94:	ff800737          	lui	a4,0xff800
    80026e98:	177d                	addi	a4,a4,-1
    80026e9a:	8ff9                	and	a5,a5,a4
    80026e9c:	8fcd                	or	a5,a5,a1
    80026e9e:	080a                	slli	a6,a6,0x2
    80026ea0:	502b0737          	lui	a4,0x502b0
    80026ea4:	983a                	add	a6,a6,a4
    80026ea6:	00f82023          	sw	a5,0(a6)
        /* resv and pad_di do not need initialization */
    };
    return 0;
    80026eaa:	4501                	li	a0,0
}
    80026eac:	6422                	ld	s0,8(sp)
    80026eae:	0141                	addi	sp,sp,16
    80026eb0:	8082                	ret
        return -1;
    80026eb2:	557d                	li	a0,-1
    80026eb4:	bfe5                	j	80026eac <fpioa_set_function_raw+0x134>
    80026eb6:	557d                	li	a0,-1
    80026eb8:	bfd5                	j	80026eac <fpioa_set_function_raw+0x134>

0000000080026eba <fpioa_set_function>:

int fpioa_set_function(int number, fpioa_function_t function)
{
    uint8 index = 0;
    /* Check parameters */
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80026eba:	02f00793          	li	a5,47
    80026ebe:	08a7e763          	bltu	a5,a0,80026f4c <fpioa_set_function+0x92>
{
    80026ec2:	7139                	addi	sp,sp,-64
    80026ec4:	fc06                	sd	ra,56(sp)
    80026ec6:	f822                	sd	s0,48(sp)
    80026ec8:	f426                	sd	s1,40(sp)
    80026eca:	f04a                	sd	s2,32(sp)
    80026ecc:	ec4e                	sd	s3,24(sp)
    80026ece:	e852                	sd	s4,16(sp)
    80026ed0:	e456                	sd	s5,8(sp)
    80026ed2:	0080                	addi	s0,sp,64
    80026ed4:	8aaa                	mv	s5,a0
    if(number < 0 || number >= FPIOA_NUM_IO || function < 0 || function >= FUNC_MAX)
    80026ed6:	0ff00793          	li	a5,255
    80026eda:	06b7eb63          	bltu	a5,a1,80026f50 <fpioa_set_function+0x96>
    80026ede:	892e                	mv	s2,a1
        return -1;
    if(function == FUNC_RESV0)
    80026ee0:	07800793          	li	a5,120
    80026ee4:	4481                	li	s1,0
        return 0;
    }
    /* Compare all IO */
    for(index = 0; index < FPIOA_NUM_IO; index++)
    {
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80026ee6:	502b0a37          	lui	s4,0x502b0
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80026eea:	03000993          	li	s3,48
    if(function == FUNC_RESV0)
    80026eee:	00f59d63          	bne	a1,a5,80026f08 <fpioa_set_function+0x4e>
        fpioa_set_function_raw(number, FUNC_RESV0);
    80026ef2:	07800593          	li	a1,120
    80026ef6:	00000097          	auipc	ra,0x0
    80026efa:	e82080e7          	jalr	-382(ra) # 80026d78 <fpioa_set_function_raw>
        return 0;
    80026efe:	4501                	li	a0,0
    80026f00:	a82d                	j	80026f3a <fpioa_set_function+0x80>
    80026f02:	2485                	addiw	s1,s1,1
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80026f04:	03348463          	beq	s1,s3,80026f2c <fpioa_set_function+0x72>
        if((fpioa->io[index].ch_sel == function) && (index != number))
    80026f08:	0004851b          	sext.w	a0,s1
    80026f0c:	00251793          	slli	a5,a0,0x2
    80026f10:	97d2                	add	a5,a5,s4
    80026f12:	0007c783          	lbu	a5,0(a5) # ffffffffffe00000 <kernel_end+0xffffffff7fdc0000>
    80026f16:	fef916e3          	bne	s2,a5,80026f02 <fpioa_set_function+0x48>
    80026f1a:	ff5504e3          	beq	a0,s5,80026f02 <fpioa_set_function+0x48>
            fpioa_set_function_raw(index, FUNC_RESV0);
    80026f1e:	07800593          	li	a1,120
    80026f22:	00000097          	auipc	ra,0x0
    80026f26:	e56080e7          	jalr	-426(ra) # 80026d78 <fpioa_set_function_raw>
    80026f2a:	bfe1                	j	80026f02 <fpioa_set_function+0x48>
    }
    fpioa_set_function_raw(number, function);
    80026f2c:	85ca                	mv	a1,s2
    80026f2e:	8556                	mv	a0,s5
    80026f30:	00000097          	auipc	ra,0x0
    80026f34:	e48080e7          	jalr	-440(ra) # 80026d78 <fpioa_set_function_raw>
    return 0;
    80026f38:	4501                	li	a0,0
}
    80026f3a:	70e2                	ld	ra,56(sp)
    80026f3c:	7442                	ld	s0,48(sp)
    80026f3e:	74a2                	ld	s1,40(sp)
    80026f40:	7902                	ld	s2,32(sp)
    80026f42:	69e2                	ld	s3,24(sp)
    80026f44:	6a42                	ld	s4,16(sp)
    80026f46:	6aa2                	ld	s5,8(sp)
    80026f48:	6121                	addi	sp,sp,64
    80026f4a:	8082                	ret
        return -1;
    80026f4c:	557d                	li	a0,-1
}
    80026f4e:	8082                	ret
        return -1;
    80026f50:	557d                	li	a0,-1
    80026f52:	b7e5                	j	80026f3a <fpioa_set_function+0x80>

0000000080026f54 <fpioa_set_tie_enable>:

int fpioa_set_tie_enable(fpioa_function_t function, int enable)
{
    80026f54:	1141                	addi	sp,sp,-16
    80026f56:	e422                	sd	s0,8(sp)
    80026f58:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(function < 0 || function >= FUNC_MAX)
    80026f5a:	0ff00793          	li	a5,255
    80026f5e:	04a7ee63          	bltu	a5,a0,80026fba <fpioa_set_tie_enable+0x66>
        return -1;
    /* Set tie enable */
    if(enable)
    80026f62:	c595                	beqz	a1,80026f8e <fpioa_set_tie_enable+0x3a>
        fpioa->tie.en[function / 32] |= (1UL << (function % 32));
    80026f64:	0055571b          	srliw	a4,a0,0x5
    80026f68:	00271793          	slli	a5,a4,0x2
    80026f6c:	502b0737          	lui	a4,0x502b0
    80026f70:	973e                	add	a4,a4,a5
    80026f72:	0c072683          	lw	a3,192(a4) # 502b00c0 <BASE_ADDRESS-0x2fd6ff40>
    80026f76:	897d                	andi	a0,a0,31
    80026f78:	4785                	li	a5,1
    80026f7a:	00a79533          	sll	a0,a5,a0
    80026f7e:	8d55                	or	a0,a0,a3
    80026f80:	2501                	sext.w	a0,a0
    80026f82:	0ca72023          	sw	a0,192(a4)
    else
        fpioa->tie.en[function / 32] &= (~(1UL << (function % 32)));
    return 0;
    80026f86:	4501                	li	a0,0
}
    80026f88:	6422                	ld	s0,8(sp)
    80026f8a:	0141                	addi	sp,sp,16
    80026f8c:	8082                	ret
        fpioa->tie.en[function / 32] &= (~(1UL << (function % 32)));
    80026f8e:	0055569b          	srliw	a3,a0,0x5
    80026f92:	00269793          	slli	a5,a3,0x2
    80026f96:	502b06b7          	lui	a3,0x502b0
    80026f9a:	96be                	add	a3,a3,a5
    80026f9c:	0c06a603          	lw	a2,192(a3) # 502b00c0 <BASE_ADDRESS-0x2fd6ff40>
    80026fa0:	01f57793          	andi	a5,a0,31
    80026fa4:	4705                	li	a4,1
    80026fa6:	00f717b3          	sll	a5,a4,a5
    80026faa:	fff7c793          	not	a5,a5
    80026fae:	8ff1                	and	a5,a5,a2
    80026fb0:	2781                	sext.w	a5,a5
    80026fb2:	0cf6a023          	sw	a5,192(a3)
    return 0;
    80026fb6:	852e                	mv	a0,a1
    80026fb8:	bfc1                	j	80026f88 <fpioa_set_tie_enable+0x34>
        return -1;
    80026fba:	557d                	li	a0,-1
    80026fbc:	b7f1                	j	80026f88 <fpioa_set_tie_enable+0x34>

0000000080026fbe <fpioa_set_tie_value>:

int fpioa_set_tie_value(fpioa_function_t function, int value)
{
    80026fbe:	1141                	addi	sp,sp,-16
    80026fc0:	e422                	sd	s0,8(sp)
    80026fc2:	0800                	addi	s0,sp,16
    /* Check parameters */
    if(function < 0 || function >= FUNC_MAX)
    80026fc4:	0ff00793          	li	a5,255
    80026fc8:	04a7ee63          	bltu	a5,a0,80027024 <fpioa_set_tie_value+0x66>
        return -1;
    /* Set tie value */
    if(value)
    80026fcc:	c595                	beqz	a1,80026ff8 <fpioa_set_tie_value+0x3a>
        fpioa->tie.val[function / 32] |= (1UL << (function % 32));
    80026fce:	0055571b          	srliw	a4,a0,0x5
    80026fd2:	00271793          	slli	a5,a4,0x2
    80026fd6:	502b0737          	lui	a4,0x502b0
    80026fda:	973e                	add	a4,a4,a5
    80026fdc:	0e072683          	lw	a3,224(a4) # 502b00e0 <BASE_ADDRESS-0x2fd6ff20>
    80026fe0:	897d                	andi	a0,a0,31
    80026fe2:	4785                	li	a5,1
    80026fe4:	00a79533          	sll	a0,a5,a0
    80026fe8:	8d55                	or	a0,a0,a3
    80026fea:	2501                	sext.w	a0,a0
    80026fec:	0ea72023          	sw	a0,224(a4)
    else
        fpioa->tie.val[function / 32] &= (~(1UL << (function % 32)));
    return 0;
    80026ff0:	4501                	li	a0,0
}
    80026ff2:	6422                	ld	s0,8(sp)
    80026ff4:	0141                	addi	sp,sp,16
    80026ff6:	8082                	ret
        fpioa->tie.val[function / 32] &= (~(1UL << (function % 32)));
    80026ff8:	0055569b          	srliw	a3,a0,0x5
    80026ffc:	00269793          	slli	a5,a3,0x2
    80027000:	502b06b7          	lui	a3,0x502b0
    80027004:	96be                	add	a3,a3,a5
    80027006:	0e06a603          	lw	a2,224(a3) # 502b00e0 <BASE_ADDRESS-0x2fd6ff20>
    8002700a:	01f57793          	andi	a5,a0,31
    8002700e:	4705                	li	a4,1
    80027010:	00f717b3          	sll	a5,a4,a5
    80027014:	fff7c793          	not	a5,a5
    80027018:	8ff1                	and	a5,a5,a2
    8002701a:	2781                	sext.w	a5,a5
    8002701c:	0ef6a023          	sw	a5,224(a3)
    return 0;
    80027020:	852e                	mv	a0,a1
    80027022:	bfc1                	j	80026ff2 <fpioa_set_tie_value+0x34>
        return -1;
    80027024:	557d                	li	a0,-1
    80027026:	b7f1                	j	80026ff2 <fpioa_set_tie_value+0x34>

0000000080027028 <fpioa_get_io_by_function>:

int fpioa_get_io_by_function(fpioa_function_t function)
{
    80027028:	1141                	addi	sp,sp,-16
    8002702a:	e422                	sd	s0,8(sp)
    8002702c:	0800                	addi	s0,sp,16
    int index = 0;
    for(index = 0; index < FPIOA_NUM_IO; index++)
    {
        if(fpioa->io[index].ch_sel == function)
    8002702e:	502b07b7          	lui	a5,0x502b0
    80027032:	0007c783          	lbu	a5,0(a5) # 502b0000 <BASE_ADDRESS-0x2fd70000>
    80027036:	02f50663          	beq	a0,a5,80027062 <fpioa_get_io_by_function+0x3a>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    8002703a:	4785                	li	a5,1
        if(fpioa->io[index].ch_sel == function)
    8002703c:	502b06b7          	lui	a3,0x502b0
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027040:	03000613          	li	a2,48
        if(fpioa->io[index].ch_sel == function)
    80027044:	00279713          	slli	a4,a5,0x2
    80027048:	9736                	add	a4,a4,a3
    8002704a:	00074703          	lbu	a4,0(a4)
    8002704e:	00e50663          	beq	a0,a4,8002705a <fpioa_get_io_by_function+0x32>
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027052:	2785                	addiw	a5,a5,1
    80027054:	fec798e3          	bne	a5,a2,80027044 <fpioa_get_io_by_function+0x1c>
            return index;
    }

    return -1;
    80027058:	57fd                	li	a5,-1
}
    8002705a:	853e                	mv	a0,a5
    8002705c:	6422                	ld	s0,8(sp)
    8002705e:	0141                	addi	sp,sp,16
    80027060:	8082                	ret
    for(index = 0; index < FPIOA_NUM_IO; index++)
    80027062:	4781                	li	a5,0
    80027064:	bfdd                	j	8002705a <fpioa_get_io_by_function+0x32>

0000000080027066 <fpioa_pin_init>:

void fpioa_pin_init() {
    80027066:	1141                	addi	sp,sp,-16
    80027068:	e406                	sd	ra,8(sp)
    8002706a:	e022                	sd	s0,0(sp)
    8002706c:	0800                	addi	s0,sp,16
    fpioa_set_function(27, FUNC_SPI0_SCLK);
    8002706e:	45c5                	li	a1,17
    80027070:	456d                	li	a0,27
    80027072:	00000097          	auipc	ra,0x0
    80027076:	e48080e7          	jalr	-440(ra) # 80026eba <fpioa_set_function>
    fpioa_set_function(28, FUNC_SPI0_D0);
    8002707a:	4591                	li	a1,4
    8002707c:	4571                	li	a0,28
    8002707e:	00000097          	auipc	ra,0x0
    80027082:	e3c080e7          	jalr	-452(ra) # 80026eba <fpioa_set_function>
    fpioa_set_function(26, FUNC_SPI0_D1);
    80027086:	4595                	li	a1,5
    80027088:	4569                	li	a0,26
    8002708a:	00000097          	auipc	ra,0x0
    8002708e:	e30080e7          	jalr	-464(ra) # 80026eba <fpioa_set_function>
	fpioa_set_function(32, FUNC_GPIOHS7);
    80027092:	45fd                	li	a1,31
    80027094:	02000513          	li	a0,32
    80027098:	00000097          	auipc	ra,0x0
    8002709c:	e22080e7          	jalr	-478(ra) # 80026eba <fpioa_set_function>
    fpioa_set_function(29, FUNC_SPI0_SS3);
    800270a0:	45bd                	li	a1,15
    800270a2:	4575                	li	a0,29
    800270a4:	00000097          	auipc	ra,0x0
    800270a8:	e16080e7          	jalr	-490(ra) # 80026eba <fpioa_set_function>
    printf("fpioa_pin_init\n");
    800270ac:	00003517          	auipc	a0,0x3
    800270b0:	0ec50513          	addi	a0,a0,236 # 8002a198 <function_config+0x400>
    800270b4:	ffff9097          	auipc	ra,0xffff9
    800270b8:	064080e7          	jalr	100(ra) # 80020118 <printf>
    800270bc:	60a2                	ld	ra,8(sp)
    800270be:	6402                	ld	s0,0(sp)
    800270c0:	0141                	addi	sp,sp,16
    800270c2:	8082                	ret

00000000800270c4 <set_bit>:
#include "include/types.h"
#include "include/utils.h"
#include "include/encoding.h"

void set_bit(volatile uint32 *bits, uint32 mask, uint32 value)
{
    800270c4:	1141                	addi	sp,sp,-16
    800270c6:	e422                	sd	s0,8(sp)
    800270c8:	0800                	addi	s0,sp,16
    uint32 org = (*bits) & ~mask;
    800270ca:	411c                	lw	a5,0(a0)
    800270cc:	2781                	sext.w	a5,a5
    *bits = org | (value & mask);
    800270ce:	8e3d                	xor	a2,a2,a5
    800270d0:	8df1                	and	a1,a1,a2
    800270d2:	8fad                	xor	a5,a5,a1
    800270d4:	c11c                	sw	a5,0(a0)
}
    800270d6:	6422                	ld	s0,8(sp)
    800270d8:	0141                	addi	sp,sp,16
    800270da:	8082                	ret

00000000800270dc <set_bit_offset>:

void set_bit_offset(volatile uint32 *bits, uint32 mask, uint64 offset, uint32 value)
{
    800270dc:	1141                	addi	sp,sp,-16
    800270de:	e422                	sd	s0,8(sp)
    800270e0:	0800                	addi	s0,sp,16
    set_bit(bits, mask << offset, value << offset);
    800270e2:	2601                	sext.w	a2,a2
    uint32 org = (*bits) & ~mask;
    800270e4:	411c                	lw	a5,0(a0)
    800270e6:	2781                	sext.w	a5,a5
    set_bit(bits, mask << offset, value << offset);
    800270e8:	00c696bb          	sllw	a3,a3,a2
    *bits = org | (value & mask);
    800270ec:	8ebd                	xor	a3,a3,a5
    set_bit(bits, mask << offset, value << offset);
    800270ee:	00c595bb          	sllw	a1,a1,a2
    *bits = org | (value & mask);
    800270f2:	8eed                	and	a3,a3,a1
    800270f4:	8fb5                	xor	a5,a5,a3
    800270f6:	2781                	sext.w	a5,a5
    800270f8:	c11c                	sw	a5,0(a0)
}
    800270fa:	6422                	ld	s0,8(sp)
    800270fc:	0141                	addi	sp,sp,16
    800270fe:	8082                	ret

0000000080027100 <set_gpio_bit>:

void set_gpio_bit(volatile uint32 *bits, uint64 offset, uint32 value)
{
    80027100:	1141                	addi	sp,sp,-16
    80027102:	e406                	sd	ra,8(sp)
    80027104:	e022                	sd	s0,0(sp)
    80027106:	0800                	addi	s0,sp,16
    set_bit_offset(bits, 1, offset, value);
    80027108:	86b2                	mv	a3,a2
    8002710a:	862e                	mv	a2,a1
    8002710c:	4585                	li	a1,1
    8002710e:	00000097          	auipc	ra,0x0
    80027112:	fce080e7          	jalr	-50(ra) # 800270dc <set_bit_offset>
}
    80027116:	60a2                	ld	ra,8(sp)
    80027118:	6402                	ld	s0,0(sp)
    8002711a:	0141                	addi	sp,sp,16
    8002711c:	8082                	ret

000000008002711e <get_bit>:

uint32 get_bit(volatile uint32 *bits, uint32 mask, uint64 offset)
{
    8002711e:	1141                	addi	sp,sp,-16
    80027120:	e422                	sd	s0,8(sp)
    80027122:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    80027124:	411c                	lw	a5,0(a0)
    80027126:	2781                	sext.w	a5,a5
    80027128:	2601                	sext.w	a2,a2
    8002712a:	00c595bb          	sllw	a1,a1,a2
    8002712e:	8fed                	and	a5,a5,a1
}
    80027130:	00c7d53b          	srlw	a0,a5,a2
    80027134:	6422                	ld	s0,8(sp)
    80027136:	0141                	addi	sp,sp,16
    80027138:	8082                	ret

000000008002713a <get_gpio_bit>:

uint32 get_gpio_bit(volatile uint32 *bits, uint64 offset)
{
    8002713a:	1141                	addi	sp,sp,-16
    8002713c:	e422                	sd	s0,8(sp)
    8002713e:	0800                	addi	s0,sp,16
    return ((*bits) & (mask << offset)) >> offset;
    80027140:	411c                	lw	a5,0(a0)
    80027142:	2781                	sext.w	a5,a5
    80027144:	2581                	sext.w	a1,a1
    80027146:	4705                	li	a4,1
    80027148:	00b7173b          	sllw	a4,a4,a1
    8002714c:	8ff9                	and	a5,a5,a4
    return get_bit(bits, 1, offset);
}
    8002714e:	00b7d53b          	srlw	a0,a5,a1
    80027152:	6422                	ld	s0,8(sp)
    80027154:	0141                	addi	sp,sp,16
    80027156:	8082                	ret

0000000080027158 <sd_write_data>:
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    // spi_set_clk_rate(SPI_DEVICE_0, 200000);     /*set clk rate*/
}

static void sd_write_data(uint8 *data_buff, uint32 length)
{
    80027158:	1101                	addi	sp,sp,-32
    8002715a:	ec06                	sd	ra,24(sp)
    8002715c:	e822                	sd	s0,16(sp)
    8002715e:	e426                	sd	s1,8(sp)
    80027160:	e04a                	sd	s2,0(sp)
    80027162:	1000                	addi	s0,sp,32
    80027164:	84aa                	mv	s1,a0
    80027166:	892e                	mv	s2,a1
    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    80027168:	4701                	li	a4,0
    8002716a:	46a1                	li	a3,8
    8002716c:	4601                	li	a2,0
    8002716e:	4581                	li	a1,0
    80027170:	4501                	li	a0,0
    80027172:	fffff097          	auipc	ra,0xfffff
    80027176:	024080e7          	jalr	36(ra) # 80026196 <spi_init>
    spi_send_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    8002717a:	02091793          	slli	a5,s2,0x20
    8002717e:	9381                	srli	a5,a5,0x20
    80027180:	8726                	mv	a4,s1
    80027182:	4681                	li	a3,0
    80027184:	4601                	li	a2,0
    80027186:	458d                	li	a1,3
    80027188:	4501                	li	a0,0
    8002718a:	fffff097          	auipc	ra,0xfffff
    8002718e:	27a080e7          	jalr	634(ra) # 80026404 <spi_send_data_standard>
}
    80027192:	60e2                	ld	ra,24(sp)
    80027194:	6442                	ld	s0,16(sp)
    80027196:	64a2                	ld	s1,8(sp)
    80027198:	6902                	ld	s2,0(sp)
    8002719a:	6105                	addi	sp,sp,32
    8002719c:	8082                	ret

000000008002719e <sd_read_data>:

static void sd_read_data(uint8 *data_buff, uint32 length)
{
    8002719e:	1101                	addi	sp,sp,-32
    800271a0:	ec06                	sd	ra,24(sp)
    800271a2:	e822                	sd	s0,16(sp)
    800271a4:	e426                	sd	s1,8(sp)
    800271a6:	e04a                	sd	s2,0(sp)
    800271a8:	1000                	addi	s0,sp,32
    800271aa:	84aa                	mv	s1,a0
    800271ac:	892e                	mv	s2,a1

    spi_init(SPI_DEVICE_0, SPI_WORK_MODE_0, SPI_FF_STANDARD, 8, 0);
    800271ae:	4701                	li	a4,0
    800271b0:	46a1                	li	a3,8
    800271b2:	4601                	li	a2,0
    800271b4:	4581                	li	a1,0
    800271b6:	4501                	li	a0,0
    800271b8:	fffff097          	auipc	ra,0xfffff
    800271bc:	fde080e7          	jalr	-34(ra) # 80026196 <spi_init>
    spi_receive_data_standard(SPI_DEVICE_0, SPI_CHIP_SELECT_3, NULL, 0, data_buff, length);
    800271c0:	02091793          	slli	a5,s2,0x20
    800271c4:	9381                	srli	a5,a5,0x20
    800271c6:	8726                	mv	a4,s1
    800271c8:	4681                	li	a3,0
    800271ca:	4601                	li	a2,0
    800271cc:	458d                	li	a1,3
    800271ce:	4501                	li	a0,0
    800271d0:	fffff097          	auipc	ra,0xfffff
    800271d4:	2cc080e7          	jalr	716(ra) # 8002649c <spi_receive_data_standard>

}
    800271d8:	60e2                	ld	ra,24(sp)
    800271da:	6442                	ld	s0,16(sp)
    800271dc:	64a2                	ld	s1,8(sp)
    800271de:	6902                	ld	s2,0(sp)
    800271e0:	6105                	addi	sp,sp,32
    800271e2:	8082                	ret

00000000800271e4 <sd_get_response>:
 * @retval The SD Response:
 *         - 0xFF: Sequence failed
 *         - 0: Sequence succeed
 */
	static uint8 sd_get_response(void)
{
    800271e4:	7179                	addi	sp,sp,-48
    800271e6:	f406                	sd	ra,40(sp)
    800271e8:	f022                	sd	s0,32(sp)
    800271ea:	ec26                	sd	s1,24(sp)
    800271ec:	e84a                	sd	s2,16(sp)
    800271ee:	1800                	addi	s0,sp,48
    800271f0:	6485                	lui	s1,0x1
    800271f2:	14fd                	addi	s1,s1,-1
	/*!< Check if response is got or a timeout is happen */
	while (timeout--) {
		sd_read_data(&result, 1);
		// sd_read_data_dma(&result);
		/*!< Right response got */
		if (result != 0xFF)
    800271f4:	0ff00913          	li	s2,255
		sd_read_data(&result, 1);
    800271f8:	4585                	li	a1,1
    800271fa:	fdf40513          	addi	a0,s0,-33
    800271fe:	00000097          	auipc	ra,0x0
    80027202:	fa0080e7          	jalr	-96(ra) # 8002719e <sd_read_data>
		if (result != 0xFF)
    80027206:	fdf44503          	lbu	a0,-33(s0)
    8002720a:	01251663          	bne	a0,s2,80027216 <sd_get_response+0x32>
    8002720e:	34fd                	addiw	s1,s1,-1
    80027210:	14c2                	slli	s1,s1,0x30
    80027212:	90c1                	srli	s1,s1,0x30
	while (timeout--) {
    80027214:	f0f5                	bnez	s1,800271f8 <sd_get_response+0x14>
			return result;
	}
	/*!< After time out */
	return 0xFF;
}
    80027216:	70a2                	ld	ra,40(sp)
    80027218:	7402                	ld	s0,32(sp)
    8002721a:	64e2                	ld	s1,24(sp)
    8002721c:	6942                	ld	s2,16(sp)
    8002721e:	6145                	addi	sp,sp,48
    80027220:	8082                	ret

0000000080027222 <SD_CS_HIGH>:
{
    80027222:	1141                	addi	sp,sp,-16
    80027224:	e406                	sd	ra,8(sp)
    80027226:	e022                	sd	s0,0(sp)
    80027228:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_HIGH);
    8002722a:	4585                	li	a1,1
    8002722c:	451d                	li	a0,7
    8002722e:	fffff097          	auipc	ra,0xfffff
    80027232:	52c080e7          	jalr	1324(ra) # 8002675a <gpiohs_set_pin>
}
    80027236:	60a2                	ld	ra,8(sp)
    80027238:	6402                	ld	s0,0(sp)
    8002723a:	0141                	addi	sp,sp,16
    8002723c:	8082                	ret

000000008002723e <sd_end_cmd>:
{
    8002723e:	1101                	addi	sp,sp,-32
    80027240:	ec06                	sd	ra,24(sp)
    80027242:	e822                	sd	s0,16(sp)
    80027244:	1000                	addi	s0,sp,32
	uint8 frame[1] = {0xFF};
    80027246:	57fd                	li	a5,-1
    80027248:	fef40423          	sb	a5,-24(s0)
	SD_CS_HIGH();
    8002724c:	00000097          	auipc	ra,0x0
    80027250:	fd6080e7          	jalr	-42(ra) # 80027222 <SD_CS_HIGH>
	sd_write_data(frame, 1);
    80027254:	4585                	li	a1,1
    80027256:	fe840513          	addi	a0,s0,-24
    8002725a:	00000097          	auipc	ra,0x0
    8002725e:	efe080e7          	jalr	-258(ra) # 80027158 <sd_write_data>
}
    80027262:	60e2                	ld	ra,24(sp)
    80027264:	6442                	ld	s0,16(sp)
    80027266:	6105                	addi	sp,sp,32
    80027268:	8082                	ret

000000008002726a <SD_CS_LOW>:
{
    8002726a:	1141                	addi	sp,sp,-16
    8002726c:	e406                	sd	ra,8(sp)
    8002726e:	e022                	sd	s0,0(sp)
    80027270:	0800                	addi	s0,sp,16
    gpiohs_set_pin(7, GPIO_PV_LOW);
    80027272:	4581                	li	a1,0
    80027274:	451d                	li	a0,7
    80027276:	fffff097          	auipc	ra,0xfffff
    8002727a:	4e4080e7          	jalr	1252(ra) # 8002675a <gpiohs_set_pin>
}
    8002727e:	60a2                	ld	ra,8(sp)
    80027280:	6402                	ld	s0,0(sp)
    80027282:	0141                	addi	sp,sp,16
    80027284:	8082                	ret

0000000080027286 <sd_send_cmd>:
{
    80027286:	1101                	addi	sp,sp,-32
    80027288:	ec06                	sd	ra,24(sp)
    8002728a:	e822                	sd	s0,16(sp)
    8002728c:	1000                	addi	s0,sp,32
	frame[0] = (cmd | 0x40);
    8002728e:	04056513          	ori	a0,a0,64
    80027292:	fea40423          	sb	a0,-24(s0)
	frame[1] = (uint8)(arg >> 24);
    80027296:	0185d79b          	srliw	a5,a1,0x18
    8002729a:	fef404a3          	sb	a5,-23(s0)
	frame[2] = (uint8)(arg >> 16);
    8002729e:	0105d79b          	srliw	a5,a1,0x10
    800272a2:	fef40523          	sb	a5,-22(s0)
	frame[3] = (uint8)(arg >> 8);
    800272a6:	0085d79b          	srliw	a5,a1,0x8
    800272aa:	fef405a3          	sb	a5,-21(s0)
	frame[4] = (uint8)(arg);
    800272ae:	feb40623          	sb	a1,-20(s0)
	frame[5] = (crc);
    800272b2:	fec406a3          	sb	a2,-19(s0)
	SD_CS_LOW();
    800272b6:	00000097          	auipc	ra,0x0
    800272ba:	fb4080e7          	jalr	-76(ra) # 8002726a <SD_CS_LOW>
	sd_write_data(frame, 6);
    800272be:	4599                	li	a1,6
    800272c0:	fe840513          	addi	a0,s0,-24
    800272c4:	00000097          	auipc	ra,0x0
    800272c8:	e94080e7          	jalr	-364(ra) # 80027158 <sd_write_data>
}
    800272cc:	60e2                	ld	ra,24(sp)
    800272ce:	6442                	ld	s0,16(sp)
    800272d0:	6105                	addi	sp,sp,32
    800272d2:	8082                	ret

00000000800272d4 <SD_HIGH_SPEED_ENABLE>:
{
    800272d4:	1141                	addi	sp,sp,-16
    800272d6:	e422                	sd	s0,8(sp)
    800272d8:	0800                	addi	s0,sp,16
}
    800272da:	6422                	ld	s0,8(sp)
    800272dc:	0141                	addi	sp,sp,16
    800272de:	8082                	ret

00000000800272e0 <sd_init>:
 * @retval The SD Response:
 *         - 0xFF: Sequence failed
 *         - 0: Sequence succeed
 */
uint8 sd_init(void)
{
    800272e0:	711d                	addi	sp,sp,-96
    800272e2:	ec86                	sd	ra,88(sp)
    800272e4:	e8a2                	sd	s0,80(sp)
    800272e6:	e4a6                	sd	s1,72(sp)
    800272e8:	e0ca                	sd	s2,64(sp)
    800272ea:	fc4e                	sd	s3,56(sp)
    800272ec:	f852                	sd	s4,48(sp)
    800272ee:	1080                	addi	s0,sp,96
    gpiohs_set_drive_mode(7, GPIO_DM_OUTPUT);
    800272f0:	458d                	li	a1,3
    800272f2:	451d                	li	a0,7
    800272f4:	fffff097          	auipc	ra,0xfffff
    800272f8:	3be080e7          	jalr	958(ra) # 800266b2 <gpiohs_set_drive_mode>
	uint8 frame[10], index, result;
	/*!< Initialize SD_SPI */
	sd_lowlevel_init(0);
	/*!< SD chip select high */
	SD_CS_HIGH();
    800272fc:	00000097          	auipc	ra,0x0
    80027300:	f26080e7          	jalr	-218(ra) # 80027222 <SD_CS_HIGH>
	/*!< Send dummy byte 0xFF, 10 times with CS high */
	/*!< Rise CS and MOSI for 80 clocks cycles */
	/*!< Send dummy byte 0xFF */
	for (index = 0; index < 10; index++)
    80027304:	fc040793          	addi	a5,s0,-64
    80027308:	fca40693          	addi	a3,s0,-54
		frame[index] = 0xFF;
    8002730c:	577d                	li	a4,-1
    8002730e:	00e78023          	sb	a4,0(a5)
    80027312:	0785                	addi	a5,a5,1
	for (index = 0; index < 10; index++)
    80027314:	fef69de3          	bne	a3,a5,8002730e <sd_init+0x2e>
	sd_write_data(frame, 10);
    80027318:	45a9                	li	a1,10
    8002731a:	fc040513          	addi	a0,s0,-64
    8002731e:	00000097          	auipc	ra,0x0
    80027322:	e3a080e7          	jalr	-454(ra) # 80027158 <sd_write_data>
	/*------------Put SD in SPI mode--------------*/
	/*!< SD initialized and set to SPI mode properly */
	
    index = 0xFF;
    while (index--) {
    80027326:	0fe00493          	li	s1,254
        sd_send_cmd(SD_CMD0, 0, 0x95);
		// printf("get_response: %d\n", index);
        result = sd_get_response();
        sd_end_cmd();
        if (result == 0x01)
    8002732a:	4985                	li	s3,1
    while (index--) {
    8002732c:	0ff00a13          	li	s4,255
        sd_send_cmd(SD_CMD0, 0, 0x95);
    80027330:	09500613          	li	a2,149
    80027334:	4581                	li	a1,0
    80027336:	4501                	li	a0,0
    80027338:	00000097          	auipc	ra,0x0
    8002733c:	f4e080e7          	jalr	-178(ra) # 80027286 <sd_send_cmd>
        result = sd_get_response();
    80027340:	00000097          	auipc	ra,0x0
    80027344:	ea4080e7          	jalr	-348(ra) # 800271e4 <sd_get_response>
    80027348:	892a                	mv	s2,a0
        sd_end_cmd();
    8002734a:	00000097          	auipc	ra,0x0
    8002734e:	ef4080e7          	jalr	-268(ra) # 8002723e <sd_end_cmd>
        if (result == 0x01)
    80027352:	01390863          	beq	s2,s3,80027362 <sd_init+0x82>
    while (index--) {
    80027356:	34fd                	addiw	s1,s1,-1
    80027358:	0ff4f493          	andi	s1,s1,255
    8002735c:	fd449ae3          	bne	s1,s4,80027330 <sd_init+0x50>
    80027360:	a011                	j	80027364 <sd_init+0x84>
            break;
    }
    if (index == 0)
    80027362:	c0cd                	beqz	s1,80027404 <sd_init+0x124>
    {
        printf("SD_CMD0 is %x\n", result);
        return 0xFF;
    }

	sd_send_cmd(SD_CMD8, 0x01AA, 0x87);
    80027364:	08700613          	li	a2,135
    80027368:	1aa00593          	li	a1,426
    8002736c:	4521                	li	a0,8
    8002736e:	00000097          	auipc	ra,0x0
    80027372:	f18080e7          	jalr	-232(ra) # 80027286 <sd_send_cmd>
	/*!< 0x01 or 0x05 */
	result = sd_get_response();
    80027376:	00000097          	auipc	ra,0x0
    8002737a:	e6e080e7          	jalr	-402(ra) # 800271e4 <sd_get_response>
    8002737e:	892a                	mv	s2,a0
	sd_read_data(frame, 4);
    80027380:	4591                	li	a1,4
    80027382:	fc040513          	addi	a0,s0,-64
    80027386:	00000097          	auipc	ra,0x0
    8002738a:	e18080e7          	jalr	-488(ra) # 8002719e <sd_read_data>
	sd_end_cmd();
    8002738e:	00000097          	auipc	ra,0x0
    80027392:	eb0080e7          	jalr	-336(ra) # 8002723e <sd_end_cmd>
	if (result != 0x01)
    80027396:	4785                	li	a5,1
	{
        printf("SD_CMD8 is %x\n", result);
		return 0xFF;
    }
	index = 0xFF;
	while (index--) {
    80027398:	0fe00493          	li	s1,254
		sd_send_cmd(SD_CMD55, 0, 0);
		result = sd_get_response();
		sd_end_cmd();
		if (result != 0x01)
    8002739c:	4985                	li	s3,1
	while (index--) {
    8002739e:	0ff00a13          	li	s4,255
	if (result != 0x01)
    800273a2:	06f91d63          	bne	s2,a5,8002741c <sd_init+0x13c>
		sd_send_cmd(SD_CMD55, 0, 0);
    800273a6:	4601                	li	a2,0
    800273a8:	4581                	li	a1,0
    800273aa:	03700513          	li	a0,55
    800273ae:	00000097          	auipc	ra,0x0
    800273b2:	ed8080e7          	jalr	-296(ra) # 80027286 <sd_send_cmd>
		result = sd_get_response();
    800273b6:	00000097          	auipc	ra,0x0
    800273ba:	e2e080e7          	jalr	-466(ra) # 800271e4 <sd_get_response>
    800273be:	892a                	mv	s2,a0
		sd_end_cmd();
    800273c0:	00000097          	auipc	ra,0x0
    800273c4:	e7e080e7          	jalr	-386(ra) # 8002723e <sd_end_cmd>
		if (result != 0x01)
    800273c8:	3f391763          	bne	s2,s3,800277b6 <sd_init+0x4d6>
			return 0xFF;
		sd_send_cmd(SD_ACMD41, 0x40000000, 0);
    800273cc:	4601                	li	a2,0
    800273ce:	400005b7          	lui	a1,0x40000
    800273d2:	02900513          	li	a0,41
    800273d6:	00000097          	auipc	ra,0x0
    800273da:	eb0080e7          	jalr	-336(ra) # 80027286 <sd_send_cmd>
		result = sd_get_response();
    800273de:	00000097          	auipc	ra,0x0
    800273e2:	e06080e7          	jalr	-506(ra) # 800271e4 <sd_get_response>
    800273e6:	892a                	mv	s2,a0
		sd_end_cmd();
    800273e8:	00000097          	auipc	ra,0x0
    800273ec:	e56080e7          	jalr	-426(ra) # 8002723e <sd_end_cmd>
		if (result == 0x00)
    800273f0:	04090363          	beqz	s2,80027436 <sd_init+0x156>
	while (index--) {
    800273f4:	34fd                	addiw	s1,s1,-1
    800273f6:	0ff4f493          	andi	s1,s1,255
    800273fa:	fb4496e3          	bne	s1,s4,800273a6 <sd_init+0xc6>
    800273fe:	0fe00913          	li	s2,254
    80027402:	a82d                	j	8002743c <sd_init+0x15c>
        printf("SD_CMD0 is %x\n", result);
    80027404:	4585                	li	a1,1
    80027406:	00003517          	auipc	a0,0x3
    8002740a:	da250513          	addi	a0,a0,-606 # 8002a1a8 <function_config+0x410>
    8002740e:	ffff9097          	auipc	ra,0xffff9
    80027412:	d0a080e7          	jalr	-758(ra) # 80020118 <printf>
        return 0xFF;
    80027416:	0ff00493          	li	s1,255
    8002741a:	a645                	j	800277ba <sd_init+0x4da>
        printf("SD_CMD8 is %x\n", result);
    8002741c:	0009059b          	sext.w	a1,s2
    80027420:	00003517          	auipc	a0,0x3
    80027424:	d9850513          	addi	a0,a0,-616 # 8002a1b8 <function_config+0x420>
    80027428:	ffff9097          	auipc	ra,0xffff9
    8002742c:	cf0080e7          	jalr	-784(ra) # 80020118 <printf>
		return 0xFF;
    80027430:	0ff00493          	li	s1,255
    80027434:	a659                	j	800277ba <sd_init+0x4da>
			break;
	}
	if (index == 0)
    80027436:	0fe00913          	li	s2,254
    8002743a:	c4a1                	beqz	s1,80027482 <sd_init+0x1a2>
	{
        printf("SD_CMD55 is %x\n", result);
		return 0xFF;
    }
	index = 255;
	while(index--){
    8002743c:	0ff00993          	li	s3,255
    80027440:	05390f63          	beq	s2,s3,8002749e <sd_init+0x1be>
		sd_send_cmd(SD_CMD58, 0, 1);
    80027444:	4605                	li	a2,1
    80027446:	4581                	li	a1,0
    80027448:	03a00513          	li	a0,58
    8002744c:	00000097          	auipc	ra,0x0
    80027450:	e3a080e7          	jalr	-454(ra) # 80027286 <sd_send_cmd>
		result = sd_get_response();
    80027454:	00000097          	auipc	ra,0x0
    80027458:	d90080e7          	jalr	-624(ra) # 800271e4 <sd_get_response>
    8002745c:	84aa                	mv	s1,a0
		sd_read_data(frame, 4);
    8002745e:	4591                	li	a1,4
    80027460:	fc040513          	addi	a0,s0,-64
    80027464:	00000097          	auipc	ra,0x0
    80027468:	d3a080e7          	jalr	-710(ra) # 8002719e <sd_read_data>
		sd_end_cmd();
    8002746c:	00000097          	auipc	ra,0x0
    80027470:	dd2080e7          	jalr	-558(ra) # 8002723e <sd_end_cmd>
		if(result == 0){
    80027474:	fff9079b          	addiw	a5,s2,-1
    80027478:	0ff7f793          	andi	a5,a5,255
    8002747c:	cc99                	beqz	s1,8002749a <sd_init+0x1ba>
    8002747e:	893e                	mv	s2,a5
    80027480:	b7c1                	j	80027440 <sd_init+0x160>
        printf("SD_CMD55 is %x\n", result);
    80027482:	4581                	li	a1,0
    80027484:	00003517          	auipc	a0,0x3
    80027488:	d4450513          	addi	a0,a0,-700 # 8002a1c8 <function_config+0x430>
    8002748c:	ffff9097          	auipc	ra,0xffff9
    80027490:	c8c080e7          	jalr	-884(ra) # 80020118 <printf>
		return 0xFF;
    80027494:	0ff00493          	li	s1,255
    80027498:	a60d                	j	800277ba <sd_init+0x4da>
			break;
		}
	}
	if(index == 0)
    8002749a:	2c090a63          	beqz	s2,8002776e <sd_init+0x48e>
	{
	    printf("SD_CMD58 is %x\n", result);
		return 0xFF;
	}
	if ((frame[0] & 0x40) == 0)
    8002749e:	fc044783          	lbu	a5,-64(s0)
    800274a2:	0407f793          	andi	a5,a5,64
		return 0xFF;
    800274a6:	0ff00493          	li	s1,255
	if ((frame[0] & 0x40) == 0)
    800274aa:	30078863          	beqz	a5,800277ba <sd_init+0x4da>
	sd_send_cmd(SD_CMD9, 0, 0);
    800274ae:	4601                	li	a2,0
    800274b0:	4581                	li	a1,0
    800274b2:	4525                	li	a0,9
    800274b4:	00000097          	auipc	ra,0x0
    800274b8:	dd2080e7          	jalr	-558(ra) # 80027286 <sd_send_cmd>
	if (sd_get_response() != 0x00) {
    800274bc:	00000097          	auipc	ra,0x0
    800274c0:	d28080e7          	jalr	-728(ra) # 800271e4 <sd_get_response>
    800274c4:	2c051163          	bnez	a0,80027786 <sd_init+0x4a6>
	if (sd_get_response() != SD_START_DATA_SINGLE_BLOCK_READ) {
    800274c8:	00000097          	auipc	ra,0x0
    800274cc:	d1c080e7          	jalr	-740(ra) # 800271e4 <sd_get_response>
    800274d0:	0fe00793          	li	a5,254
    800274d4:	2af51e63          	bne	a0,a5,80027790 <sd_init+0x4b0>
	sd_read_data(csd_tab, 18);
    800274d8:	45c9                	li	a1,18
    800274da:	fa840513          	addi	a0,s0,-88
    800274de:	00000097          	auipc	ra,0x0
    800274e2:	cc0080e7          	jalr	-832(ra) # 8002719e <sd_read_data>
	sd_end_cmd();
    800274e6:	00000097          	auipc	ra,0x0
    800274ea:	d58080e7          	jalr	-680(ra) # 8002723e <sd_end_cmd>
	SD_csd->CSDStruct = (csd_tab[0] & 0xC0) >> 6;
    800274ee:	fa844703          	lbu	a4,-88(s0)
    800274f2:	00018797          	auipc	a5,0x18
    800274f6:	43e78793          	addi	a5,a5,1086 # 8003f930 <cardinfo>
    800274fa:	0067569b          	srliw	a3,a4,0x6
    800274fe:	00d78023          	sb	a3,0(a5)
	SD_csd->SysSpecVersion = (csd_tab[0] & 0x3C) >> 2;
    80027502:	4027569b          	sraiw	a3,a4,0x2
    80027506:	8abd                	andi	a3,a3,15
    80027508:	00d780a3          	sb	a3,1(a5)
	SD_csd->Reserved1 = csd_tab[0] & 0x03;
    8002750c:	8b0d                	andi	a4,a4,3
    8002750e:	00e78123          	sb	a4,2(a5)
	SD_csd->TAAC = csd_tab[1];
    80027512:	fa944703          	lbu	a4,-87(s0)
    80027516:	00e781a3          	sb	a4,3(a5)
	SD_csd->NSAC = csd_tab[2];
    8002751a:	faa44703          	lbu	a4,-86(s0)
    8002751e:	00e78223          	sb	a4,4(a5)
	SD_csd->MaxBusClkFrec = csd_tab[3];
    80027522:	fab44703          	lbu	a4,-85(s0)
    80027526:	00e782a3          	sb	a4,5(a5)
	SD_csd->CardComdClasses |= (csd_tab[5] & 0xF0) >> 4;
    8002752a:	fad44703          	lbu	a4,-83(s0)
	SD_csd->CardComdClasses = csd_tab[4] << 4;
    8002752e:	fac44603          	lbu	a2,-84(s0)
	SD_csd->CardComdClasses |= (csd_tab[5] & 0xF0) >> 4;
    80027532:	0047569b          	srliw	a3,a4,0x4
    80027536:	0046161b          	slliw	a2,a2,0x4
    8002753a:	8ed1                	or	a3,a3,a2
    8002753c:	00d79323          	sh	a3,6(a5)
	SD_csd->RdBlockLen = csd_tab[5] & 0x0F;
    80027540:	8b3d                	andi	a4,a4,15
    80027542:	00e78423          	sb	a4,8(a5)
	SD_csd->PartBlockRead = (csd_tab[6] & 0x80) >> 7;
    80027546:	fae44703          	lbu	a4,-82(s0)
    8002754a:	0077569b          	srliw	a3,a4,0x7
    8002754e:	00d784a3          	sb	a3,9(a5)
	SD_csd->WrBlockMisalign = (csd_tab[6] & 0x40) >> 6;
    80027552:	00675693          	srli	a3,a4,0x6
    80027556:	8a85                	andi	a3,a3,1
    80027558:	00d78523          	sb	a3,10(a5)
	SD_csd->RdBlockMisalign = (csd_tab[6] & 0x20) >> 5;
    8002755c:	00575693          	srli	a3,a4,0x5
    80027560:	8a85                	andi	a3,a3,1
    80027562:	00d785a3          	sb	a3,11(a5)
	SD_csd->DSRImpl = (csd_tab[6] & 0x10) >> 4;
    80027566:	8311                	srli	a4,a4,0x4
    80027568:	8b05                	andi	a4,a4,1
    8002756a:	00e78623          	sb	a4,12(a5)
	SD_csd->Reserved2 = 0; /*!< Reserved */
    8002756e:	000786a3          	sb	zero,13(a5)
	SD_csd->DeviceSize |= csd_tab[8] << 8;
    80027572:	fb044703          	lbu	a4,-80(s0)
    80027576:	0087171b          	slliw	a4,a4,0x8
	SD_csd->DeviceSize |= csd_tab[9];
    8002757a:	fb144683          	lbu	a3,-79(s0)
    8002757e:	8f55                	or	a4,a4,a3
	SD_csd->DeviceSize = (csd_tab[7] & 0x3F) << 16;
    80027580:	faf44683          	lbu	a3,-81(s0)
    80027584:	0106969b          	slliw	a3,a3,0x10
    80027588:	003f0637          	lui	a2,0x3f0
    8002758c:	8ef1                	and	a3,a3,a2
	SD_csd->DeviceSize |= csd_tab[9];
    8002758e:	8f55                	or	a4,a4,a3
    80027590:	cb98                	sw	a4,16(a5)
	SD_csd->EraseGrSize = (csd_tab[10] & 0x40) >> 6;
    80027592:	fb244703          	lbu	a4,-78(s0)
    80027596:	4067569b          	sraiw	a3,a4,0x6
    8002759a:	8a85                	andi	a3,a3,1
    8002759c:	00d78ca3          	sb	a3,25(a5)
	SD_csd->EraseGrMul |= (csd_tab[11] & 0x80) >> 7;
    800275a0:	fb344683          	lbu	a3,-77(s0)
	SD_csd->EraseGrMul = (csd_tab[10] & 0x3F) << 1;
    800275a4:	0017171b          	slliw	a4,a4,0x1
    800275a8:	07e77713          	andi	a4,a4,126
	SD_csd->EraseGrMul |= (csd_tab[11] & 0x80) >> 7;
    800275ac:	0076d61b          	srliw	a2,a3,0x7
    800275b0:	8f51                	or	a4,a4,a2
    800275b2:	00e78d23          	sb	a4,26(a5)
	SD_csd->WrProtectGrSize = (csd_tab[11] & 0x7F);
    800275b6:	07f6f693          	andi	a3,a3,127
    800275ba:	00d78da3          	sb	a3,27(a5)
	SD_csd->WrProtectGrEnable = (csd_tab[12] & 0x80) >> 7;
    800275be:	fb444703          	lbu	a4,-76(s0)
    800275c2:	0077569b          	srliw	a3,a4,0x7
    800275c6:	00d78e23          	sb	a3,28(a5)
	SD_csd->ManDeflECC = (csd_tab[12] & 0x60) >> 5;
    800275ca:	00575693          	srli	a3,a4,0x5
    800275ce:	8a8d                	andi	a3,a3,3
    800275d0:	00d78ea3          	sb	a3,29(a5)
	SD_csd->WrSpeedFact = (csd_tab[12] & 0x1C) >> 2;
    800275d4:	00275693          	srli	a3,a4,0x2
    800275d8:	8a9d                	andi	a3,a3,7
    800275da:	00d78f23          	sb	a3,30(a5)
	SD_csd->MaxWrBlockLen |= (csd_tab[13] & 0xC0) >> 6;
    800275de:	fb544683          	lbu	a3,-75(s0)
	SD_csd->MaxWrBlockLen = (csd_tab[12] & 0x03) << 2;
    800275e2:	0027171b          	slliw	a4,a4,0x2
    800275e6:	8b31                	andi	a4,a4,12
	SD_csd->MaxWrBlockLen |= (csd_tab[13] & 0xC0) >> 6;
    800275e8:	0066d61b          	srliw	a2,a3,0x6
    800275ec:	8f51                	or	a4,a4,a2
    800275ee:	00e78fa3          	sb	a4,31(a5)
	SD_csd->WriteBlockPaPartial = (csd_tab[13] & 0x20) >> 5;
    800275f2:	4056d71b          	sraiw	a4,a3,0x5
    800275f6:	8b05                	andi	a4,a4,1
    800275f8:	02e78023          	sb	a4,32(a5)
	SD_csd->Reserved3 = 0;
    800275fc:	020780a3          	sb	zero,33(a5)
	SD_csd->ContentProtectAppli = (csd_tab[13] & 0x01);
    80027600:	8a85                	andi	a3,a3,1
    80027602:	02d78123          	sb	a3,34(a5)
	SD_csd->FileFormatGrouop = (csd_tab[14] & 0x80) >> 7;
    80027606:	fb644703          	lbu	a4,-74(s0)
    8002760a:	0077569b          	srliw	a3,a4,0x7
    8002760e:	02d781a3          	sb	a3,35(a5)
	SD_csd->CopyFlag = (csd_tab[14] & 0x40) >> 6;
    80027612:	00675693          	srli	a3,a4,0x6
    80027616:	8a85                	andi	a3,a3,1
    80027618:	02d78223          	sb	a3,36(a5)
	SD_csd->PermWrProtect = (csd_tab[14] & 0x20) >> 5;
    8002761c:	00575693          	srli	a3,a4,0x5
    80027620:	8a85                	andi	a3,a3,1
    80027622:	02d782a3          	sb	a3,37(a5)
	SD_csd->TempWrProtect = (csd_tab[14] & 0x10) >> 4;
    80027626:	00475693          	srli	a3,a4,0x4
    8002762a:	8a85                	andi	a3,a3,1
    8002762c:	02d78323          	sb	a3,38(a5)
	SD_csd->FileFormat = (csd_tab[14] & 0x0C) >> 2;
    80027630:	00275693          	srli	a3,a4,0x2
    80027634:	8a8d                	andi	a3,a3,3
    80027636:	02d783a3          	sb	a3,39(a5)
	SD_csd->ECC = (csd_tab[14] & 0x03);
    8002763a:	8b0d                	andi	a4,a4,3
    8002763c:	02e78423          	sb	a4,40(a5)
	SD_csd->CSD_CRC = (csd_tab[15] & 0xFE) >> 1;
    80027640:	fb744703          	lbu	a4,-73(s0)
    80027644:	0017571b          	srliw	a4,a4,0x1
    80027648:	02e784a3          	sb	a4,41(a5)
	SD_csd->Reserved4 = 1;
    8002764c:	4705                	li	a4,1
    8002764e:	02e78523          	sb	a4,42(a5)
	sd_send_cmd(SD_CMD10, 0, 0);
    80027652:	4601                	li	a2,0
    80027654:	4581                	li	a1,0
    80027656:	4529                	li	a0,10
    80027658:	00000097          	auipc	ra,0x0
    8002765c:	c2e080e7          	jalr	-978(ra) # 80027286 <sd_send_cmd>
	if (sd_get_response() != 0x00) {
    80027660:	00000097          	auipc	ra,0x0
    80027664:	b84080e7          	jalr	-1148(ra) # 800271e4 <sd_get_response>
    80027668:	84aa                	mv	s1,a0
    8002766a:	12051a63          	bnez	a0,8002779e <sd_init+0x4be>
	if (sd_get_response() != SD_START_DATA_SINGLE_BLOCK_READ) {
    8002766e:	00000097          	auipc	ra,0x0
    80027672:	b76080e7          	jalr	-1162(ra) # 800271e4 <sd_get_response>
    80027676:	0fe00793          	li	a5,254
    8002767a:	12f51763          	bne	a0,a5,800277a8 <sd_init+0x4c8>
	sd_read_data(cid_tab, 18);
    8002767e:	45c9                	li	a1,18
    80027680:	fa840513          	addi	a0,s0,-88
    80027684:	00000097          	auipc	ra,0x0
    80027688:	b1a080e7          	jalr	-1254(ra) # 8002719e <sd_read_data>
	sd_end_cmd();
    8002768c:	00000097          	auipc	ra,0x0
    80027690:	bb2080e7          	jalr	-1102(ra) # 8002723e <sd_end_cmd>
	SD_cid->ManufacturerID = cid_tab[0];
    80027694:	00018797          	auipc	a5,0x18
    80027698:	29c78793          	addi	a5,a5,668 # 8003f930 <cardinfo>
    8002769c:	fa844703          	lbu	a4,-88(s0)
    800276a0:	02e78623          	sb	a4,44(a5)
	SD_cid->OEM_AppliID = cid_tab[1] << 8;
    800276a4:	fa944703          	lbu	a4,-87(s0)
	SD_cid->OEM_AppliID |= cid_tab[2];
    800276a8:	faa44683          	lbu	a3,-86(s0)
    800276ac:	0087171b          	slliw	a4,a4,0x8
    800276b0:	8f55                	or	a4,a4,a3
    800276b2:	02e79723          	sh	a4,46(a5)
	SD_cid->ProdName1 = cid_tab[3] << 24;
    800276b6:	fab44703          	lbu	a4,-85(s0)
    800276ba:	0187171b          	slliw	a4,a4,0x18
	SD_cid->ProdName1 |= cid_tab[4] << 16;
    800276be:	fac44683          	lbu	a3,-84(s0)
    800276c2:	0106969b          	slliw	a3,a3,0x10
    800276c6:	8f55                	or	a4,a4,a3
	SD_cid->ProdName1 |= cid_tab[6];
    800276c8:	fae44683          	lbu	a3,-82(s0)
    800276cc:	8f55                	or	a4,a4,a3
	SD_cid->ProdName1 |= cid_tab[5] << 8;
    800276ce:	fad44683          	lbu	a3,-83(s0)
    800276d2:	0086969b          	slliw	a3,a3,0x8
	SD_cid->ProdName1 |= cid_tab[6];
    800276d6:	8f55                	or	a4,a4,a3
    800276d8:	db98                	sw	a4,48(a5)
	SD_cid->ProdName2 = cid_tab[7];
    800276da:	faf44703          	lbu	a4,-81(s0)
    800276de:	02e78a23          	sb	a4,52(a5)
	SD_cid->ProdRev = cid_tab[8];
    800276e2:	fb044703          	lbu	a4,-80(s0)
    800276e6:	02e78aa3          	sb	a4,53(a5)
	SD_cid->ProdSN = cid_tab[9] << 24;
    800276ea:	fb144703          	lbu	a4,-79(s0)
    800276ee:	0187171b          	slliw	a4,a4,0x18
	SD_cid->ProdSN |= cid_tab[10] << 16;
    800276f2:	fb244683          	lbu	a3,-78(s0)
    800276f6:	0106969b          	slliw	a3,a3,0x10
    800276fa:	8f55                	or	a4,a4,a3
	SD_cid->ProdSN |= cid_tab[12];
    800276fc:	fb444683          	lbu	a3,-76(s0)
    80027700:	8f55                	or	a4,a4,a3
	SD_cid->ProdSN |= cid_tab[11] << 8;
    80027702:	fb344683          	lbu	a3,-77(s0)
    80027706:	0086969b          	slliw	a3,a3,0x8
	SD_cid->ProdSN |= cid_tab[12];
    8002770a:	8f55                	or	a4,a4,a3
    8002770c:	df98                	sw	a4,56(a5)
	SD_cid->Reserved1 |= (cid_tab[13] & 0xF0) >> 4;
    8002770e:	fb544703          	lbu	a4,-75(s0)
    80027712:	0047561b          	srliw	a2,a4,0x4
    80027716:	03c7c683          	lbu	a3,60(a5)
    8002771a:	8ed1                	or	a3,a3,a2
    8002771c:	02d78e23          	sb	a3,60(a5)
	SD_cid->ManufactDate = (cid_tab[13] & 0x0F) << 8;
    80027720:	0087171b          	slliw	a4,a4,0x8
    80027724:	6685                	lui	a3,0x1
    80027726:	f0068693          	addi	a3,a3,-256 # f00 <BASE_ADDRESS-0x8001f100>
    8002772a:	8f75                	and	a4,a4,a3
	SD_cid->ManufactDate |= cid_tab[14];
    8002772c:	fb644683          	lbu	a3,-74(s0)
    80027730:	8f55                	or	a4,a4,a3
    80027732:	02e79f23          	sh	a4,62(a5)
	SD_cid->CID_CRC = (cid_tab[15] & 0xFE) >> 1;
    80027736:	fb744703          	lbu	a4,-73(s0)
    8002773a:	0017571b          	srliw	a4,a4,0x1
    8002773e:	04e78023          	sb	a4,64(a5)
	SD_cid->Reserved2 = 1;
    80027742:	4705                	li	a4,1
    80027744:	04e780a3          	sb	a4,65(a5)
	cardinfo->CardCapacity = (cardinfo->SD_csd.DeviceSize + 1) * 1024;
    80027748:	4b98                	lw	a4,16(a5)
    8002774a:	2705                	addiw	a4,a4,1
    8002774c:	00a7171b          	slliw	a4,a4,0xa
    80027750:	02071693          	slli	a3,a4,0x20
    80027754:	9281                	srli	a3,a3,0x20
	cardinfo->CardBlockSize = 1 << (cardinfo->SD_csd.RdBlockLen);
    80027756:	0087c603          	lbu	a2,8(a5)
    8002775a:	4705                	li	a4,1
    8002775c:	00c7173b          	sllw	a4,a4,a2
    80027760:	cbb8                	sw	a4,80(a5)
	cardinfo->CardCapacity *= cardinfo->CardBlockSize;
    80027762:	1702                	slli	a4,a4,0x20
    80027764:	9301                	srli	a4,a4,0x20
    80027766:	02d70733          	mul	a4,a4,a3
    8002776a:	e7b8                	sd	a4,72(a5)
	return 0;
    8002776c:	a0b9                	j	800277ba <sd_init+0x4da>
	    printf("SD_CMD58 is %x\n", result);
    8002776e:	4581                	li	a1,0
    80027770:	00003517          	auipc	a0,0x3
    80027774:	a6850513          	addi	a0,a0,-1432 # 8002a1d8 <function_config+0x440>
    80027778:	ffff9097          	auipc	ra,0xffff9
    8002777c:	9a0080e7          	jalr	-1632(ra) # 80020118 <printf>
		return 0xFF;
    80027780:	0ff00493          	li	s1,255
    80027784:	a81d                	j	800277ba <sd_init+0x4da>
		sd_end_cmd();
    80027786:	00000097          	auipc	ra,0x0
    8002778a:	ab8080e7          	jalr	-1352(ra) # 8002723e <sd_end_cmd>
		return 0xFF;
    8002778e:	a029                	j	80027798 <sd_init+0x4b8>
		sd_end_cmd();
    80027790:	00000097          	auipc	ra,0x0
    80027794:	aae080e7          	jalr	-1362(ra) # 8002723e <sd_end_cmd>
		return 0xFF;
    80027798:	0ff00493          	li	s1,255
    8002779c:	a839                	j	800277ba <sd_init+0x4da>
		sd_end_cmd();
    8002779e:	00000097          	auipc	ra,0x0
    800277a2:	aa0080e7          	jalr	-1376(ra) # 8002723e <sd_end_cmd>
		return 0xFF;
    800277a6:	a029                	j	800277b0 <sd_init+0x4d0>
		sd_end_cmd();
    800277a8:	00000097          	auipc	ra,0x0
    800277ac:	a96080e7          	jalr	-1386(ra) # 8002723e <sd_end_cmd>
		return 0xFF;
    800277b0:	0ff00493          	li	s1,255
    800277b4:	a019                	j	800277ba <sd_init+0x4da>
			return 0xFF;
    800277b6:	0ff00493          	li	s1,255
	SD_HIGH_SPEED_ENABLE();
	return sd_get_cardinfo(&cardinfo);
}
    800277ba:	8526                	mv	a0,s1
    800277bc:	60e6                	ld	ra,88(sp)
    800277be:	6446                	ld	s0,80(sp)
    800277c0:	64a6                	ld	s1,72(sp)
    800277c2:	6906                	ld	s2,64(sp)
    800277c4:	79e2                	ld	s3,56(sp)
    800277c6:	7a42                	ld	s4,48(sp)
    800277c8:	6125                	addi	sp,sp,96
    800277ca:	8082                	ret

00000000800277cc <sdcard_init>:
void sdcard_init() {
    800277cc:	1141                	addi	sp,sp,-16
    800277ce:	e406                	sd	ra,8(sp)
    800277d0:	e022                	sd	s0,0(sp)
    800277d2:	0800                	addi	s0,sp,16
	uint8 cardinfo = sd_init();
    800277d4:	00000097          	auipc	ra,0x0
    800277d8:	b0c080e7          	jalr	-1268(ra) # 800272e0 <sd_init>
    if(cardinfo) {
    800277dc:	ed11                	bnez	a0,800277f8 <sdcard_init+0x2c>
      printf("sdcard init: %d\n", cardinfo);
    800277de:	4581                	li	a1,0
    800277e0:	00003517          	auipc	a0,0x3
    800277e4:	a2050513          	addi	a0,a0,-1504 # 8002a200 <function_config+0x468>
    800277e8:	ffff9097          	auipc	ra,0xffff9
    800277ec:	930080e7          	jalr	-1744(ra) # 80020118 <printf>
}
    800277f0:	60a2                	ld	ra,8(sp)
    800277f2:	6402                	ld	s0,0(sp)
    800277f4:	0141                	addi	sp,sp,16
    800277f6:	8082                	ret
      panic("sd card init error\n");
    800277f8:	00003517          	auipc	a0,0x3
    800277fc:	9f050513          	addi	a0,a0,-1552 # 8002a1e8 <function_config+0x450>
    80027800:	ffff9097          	auipc	ra,0xffff9
    80027804:	8d6080e7          	jalr	-1834(ra) # 800200d6 <panic>

0000000080027808 <sd_read_sector>:
 * @retval The SD Response:
 *         - 0xFF: Sequence failed
 *         - 0: Sequence succeed
 */
uint8 sd_read_sector(uint8 *data_buff, uint32 sector, uint32 count)
{
    80027808:	7139                	addi	sp,sp,-64
    8002780a:	fc06                	sd	ra,56(sp)
    8002780c:	f822                	sd	s0,48(sp)
    8002780e:	f426                	sd	s1,40(sp)
    80027810:	f04a                	sd	s2,32(sp)
    80027812:	ec4e                	sd	s3,24(sp)
    80027814:	e852                	sd	s4,16(sp)
    80027816:	0080                	addi	s0,sp,64
    80027818:	892a                	mv	s2,a0
    8002781a:	84b2                	mv	s1,a2
	uint8 frame[2], flag;
	/*!< Send CMD17 (SD_CMD17) to read one block */
	if (count == 1) {
    8002781c:	4785                	li	a5,1
    8002781e:	06f60d63          	beq	a2,a5,80027898 <sd_read_sector+0x90>
		flag = 0;
		sd_send_cmd(SD_CMD17, sector, 0);
	} else {
		flag = 1;
		sd_send_cmd(SD_CMD18, sector, 0);
    80027822:	4601                	li	a2,0
    80027824:	4549                	li	a0,18
    80027826:	00000097          	auipc	ra,0x0
    8002782a:	a60080e7          	jalr	-1440(ra) # 80027286 <sd_send_cmd>
	}
	/*!< Check if the SD acknowledged the read block command: R1 response (0x00: no errors) */
	if (sd_get_response() != 0x00) {
    8002782e:	00000097          	auipc	ra,0x0
    80027832:	9b6080e7          	jalr	-1610(ra) # 800271e4 <sd_get_response>
    80027836:	ed2d                	bnez	a0,800278b0 <sd_read_sector+0xa8>
		flag = 1;
    80027838:	4a05                	li	s4,1
		sd_end_cmd();
		return 0xFF;
	}
	while (count) {
    8002783a:	c0d1                	beqz	s1,800278be <sd_read_sector+0xb6>
		if (sd_get_response() != SD_START_DATA_SINGLE_BLOCK_READ)
    8002783c:	0fe00993          	li	s3,254
    80027840:	00000097          	auipc	ra,0x0
    80027844:	9a4080e7          	jalr	-1628(ra) # 800271e4 <sd_get_response>
    80027848:	03351463          	bne	a0,s3,80027870 <sd_read_sector+0x68>
			break;
		/*!< Read the SD block data : read NumByteToRead data */
		sd_read_data(data_buff, 512);
    8002784c:	20000593          	li	a1,512
    80027850:	854a                	mv	a0,s2
    80027852:	00000097          	auipc	ra,0x0
    80027856:	94c080e7          	jalr	-1716(ra) # 8002719e <sd_read_data>
		/*!< Get CRC bytes (not really needed by us, but required by SD) */
		sd_read_data(frame, 2);
    8002785a:	4589                	li	a1,2
    8002785c:	fc840513          	addi	a0,s0,-56
    80027860:	00000097          	auipc	ra,0x0
    80027864:	93e080e7          	jalr	-1730(ra) # 8002719e <sd_read_data>
		data_buff += 512;
    80027868:	20090913          	addi	s2,s2,512
		count--;
    8002786c:	34fd                	addiw	s1,s1,-1
	while (count) {
    8002786e:	f8e9                	bnez	s1,80027840 <sd_read_sector+0x38>
	}
	sd_end_cmd();
    80027870:	00000097          	auipc	ra,0x0
    80027874:	9ce080e7          	jalr	-1586(ra) # 8002723e <sd_end_cmd>
	if (flag) {
    80027878:	040a1763          	bnez	s4,800278c6 <sd_read_sector+0xbe>
		sd_get_response();
		sd_end_cmd();
		sd_end_cmd();
	}
	/*!< Returns the reponse */
	return count > 0 ? 0xFF : 0;
    8002787c:	00903533          	snez	a0,s1
    80027880:	40a0053b          	negw	a0,a0
    80027884:	0ff57513          	andi	a0,a0,255
}
    80027888:	70e2                	ld	ra,56(sp)
    8002788a:	7442                	ld	s0,48(sp)
    8002788c:	74a2                	ld	s1,40(sp)
    8002788e:	7902                	ld	s2,32(sp)
    80027890:	69e2                	ld	s3,24(sp)
    80027892:	6a42                	ld	s4,16(sp)
    80027894:	6121                	addi	sp,sp,64
    80027896:	8082                	ret
		sd_send_cmd(SD_CMD17, sector, 0);
    80027898:	4601                	li	a2,0
    8002789a:	4545                	li	a0,17
    8002789c:	00000097          	auipc	ra,0x0
    800278a0:	9ea080e7          	jalr	-1558(ra) # 80027286 <sd_send_cmd>
	if (sd_get_response() != 0x00) {
    800278a4:	00000097          	auipc	ra,0x0
    800278a8:	940080e7          	jalr	-1728(ra) # 800271e4 <sd_get_response>
    800278ac:	8a2a                	mv	s4,a0
    800278ae:	d559                	beqz	a0,8002783c <sd_read_sector+0x34>
		sd_end_cmd();
    800278b0:	00000097          	auipc	ra,0x0
    800278b4:	98e080e7          	jalr	-1650(ra) # 8002723e <sd_end_cmd>
		return 0xFF;
    800278b8:	0ff00513          	li	a0,255
    800278bc:	b7f1                	j	80027888 <sd_read_sector+0x80>
	sd_end_cmd();
    800278be:	00000097          	auipc	ra,0x0
    800278c2:	980080e7          	jalr	-1664(ra) # 8002723e <sd_end_cmd>
		sd_send_cmd(SD_CMD12, 0, 0);
    800278c6:	4601                	li	a2,0
    800278c8:	4581                	li	a1,0
    800278ca:	4531                	li	a0,12
    800278cc:	00000097          	auipc	ra,0x0
    800278d0:	9ba080e7          	jalr	-1606(ra) # 80027286 <sd_send_cmd>
		sd_get_response();
    800278d4:	00000097          	auipc	ra,0x0
    800278d8:	910080e7          	jalr	-1776(ra) # 800271e4 <sd_get_response>
		sd_end_cmd();
    800278dc:	00000097          	auipc	ra,0x0
    800278e0:	962080e7          	jalr	-1694(ra) # 8002723e <sd_end_cmd>
		sd_end_cmd();
    800278e4:	00000097          	auipc	ra,0x0
    800278e8:	95a080e7          	jalr	-1702(ra) # 8002723e <sd_end_cmd>
    800278ec:	bf41                	j	8002787c <sd_read_sector+0x74>

00000000800278ee <sd_write_sector>:
 * @retval The SD Response:
 *         - 0xFF: Sequence failed
 *         - 0: Sequence succeed
 */
uint8 sd_write_sector(uint8 *data_buff, uint32 sector, uint32 count)
{
    800278ee:	7139                	addi	sp,sp,-64
    800278f0:	fc06                	sd	ra,56(sp)
    800278f2:	f822                	sd	s0,48(sp)
    800278f4:	f426                	sd	s1,40(sp)
    800278f6:	f04a                	sd	s2,32(sp)
    800278f8:	ec4e                	sd	s3,24(sp)
    800278fa:	e852                	sd	s4,16(sp)
    800278fc:	0080                	addi	s0,sp,64
    800278fe:	84aa                	mv	s1,a0
    80027900:	89ae                	mv	s3,a1
    80027902:	8932                	mv	s2,a2
	uint8 frame[2] = {0xFF};
    80027904:	57fd                	li	a5,-1
    80027906:	fcf40423          	sb	a5,-56(s0)

	if (count == 1) {
    8002790a:	4785                	li	a5,1
    8002790c:	04f60863          	beq	a2,a5,8002795c <sd_write_sector+0x6e>
		frame[1] = SD_START_DATA_SINGLE_BLOCK_WRITE;
		sd_send_cmd(SD_CMD24, sector, 0);
	} else {
		frame[1] = SD_START_DATA_MULTIPLE_BLOCK_WRITE;
    80027910:	57f1                	li	a5,-4
    80027912:	fcf404a3          	sb	a5,-55(s0)
		sd_send_cmd(SD_ACMD23, count, 0);
    80027916:	4601                	li	a2,0
    80027918:	85ca                	mv	a1,s2
    8002791a:	455d                	li	a0,23
    8002791c:	00000097          	auipc	ra,0x0
    80027920:	96a080e7          	jalr	-1686(ra) # 80027286 <sd_send_cmd>
		sd_get_response();
    80027924:	00000097          	auipc	ra,0x0
    80027928:	8c0080e7          	jalr	-1856(ra) # 800271e4 <sd_get_response>
		sd_end_cmd();
    8002792c:	00000097          	auipc	ra,0x0
    80027930:	912080e7          	jalr	-1774(ra) # 8002723e <sd_end_cmd>
		sd_send_cmd(SD_CMD25, sector, 0);
    80027934:	4601                	li	a2,0
    80027936:	85ce                	mv	a1,s3
    80027938:	4565                	li	a0,25
    8002793a:	00000097          	auipc	ra,0x0
    8002793e:	94c080e7          	jalr	-1716(ra) # 80027286 <sd_send_cmd>
	}
	/*!< Check if the SD acknowledged the write block command: R1 response (0x00: no errors) */
	if (sd_get_response() != 0x00) {
    80027942:	00000097          	auipc	ra,0x0
    80027946:	8a2080e7          	jalr	-1886(ra) # 800271e4 <sd_get_response>
    8002794a:	8a2a                	mv	s4,a0
    8002794c:	e115                	bnez	a0,80027970 <sd_write_sector+0x82>
    8002794e:	1902                	slli	s2,s2,0x20
    80027950:	02095913          	srli	s2,s2,0x20
    80027954:	0926                	slli	s2,s2,0x9
    80027956:	9926                	add	s2,s2,s1
	if (response != 0x05)
    80027958:	4995                	li	s3,5
    8002795a:	a881                	j	800279aa <sd_write_sector+0xbc>
		frame[1] = SD_START_DATA_SINGLE_BLOCK_WRITE;
    8002795c:	57f9                	li	a5,-2
    8002795e:	fcf404a3          	sb	a5,-55(s0)
		sd_send_cmd(SD_CMD24, sector, 0);
    80027962:	4601                	li	a2,0
    80027964:	4561                	li	a0,24
    80027966:	00000097          	auipc	ra,0x0
    8002796a:	920080e7          	jalr	-1760(ra) # 80027286 <sd_send_cmd>
    8002796e:	bfd1                	j	80027942 <sd_write_sector+0x54>
		sd_end_cmd();
    80027970:	00000097          	auipc	ra,0x0
    80027974:	8ce080e7          	jalr	-1842(ra) # 8002723e <sd_end_cmd>
		return 0xFF;
    80027978:	0ff00a13          	li	s4,255
    8002797c:	a859                	j	80027a12 <sd_write_sector+0x124>
	sd_read_data(&response, 1);
    8002797e:	4585                	li	a1,1
    80027980:	fc740513          	addi	a0,s0,-57
    80027984:	00000097          	auipc	ra,0x0
    80027988:	81a080e7          	jalr	-2022(ra) # 8002719e <sd_read_data>
	while (response == 0)
    8002798c:	fc744783          	lbu	a5,-57(s0)
    80027990:	eb99                	bnez	a5,800279a6 <sd_write_sector+0xb8>
		sd_read_data(&response, 1);
    80027992:	4585                	li	a1,1
    80027994:	fc740513          	addi	a0,s0,-57
    80027998:	00000097          	auipc	ra,0x0
    8002799c:	806080e7          	jalr	-2042(ra) # 8002719e <sd_read_data>
	while (response == 0)
    800279a0:	fc744783          	lbu	a5,-57(s0)
    800279a4:	d7fd                	beqz	a5,80027992 <sd_write_sector+0xa4>
		sd_write_data(frame, 2);
		/*!< Write the block data to SD : write count data by block */
		sd_write_data(data_buff, 512);
		/*!< Put CRC bytes (not really needed by us, but required by SD) */
		sd_write_data(frame, 2);
		data_buff += 512;
    800279a6:	20048493          	addi	s1,s1,512 # 1200 <BASE_ADDRESS-0x8001ee00>
	while (count--) {
    800279aa:	05248c63          	beq	s1,s2,80027a02 <sd_write_sector+0x114>
		sd_write_data(frame, 2);
    800279ae:	4589                	li	a1,2
    800279b0:	fc840513          	addi	a0,s0,-56
    800279b4:	fffff097          	auipc	ra,0xfffff
    800279b8:	7a4080e7          	jalr	1956(ra) # 80027158 <sd_write_data>
		sd_write_data(data_buff, 512);
    800279bc:	20000593          	li	a1,512
    800279c0:	8526                	mv	a0,s1
    800279c2:	fffff097          	auipc	ra,0xfffff
    800279c6:	796080e7          	jalr	1942(ra) # 80027158 <sd_write_data>
		sd_write_data(frame, 2);
    800279ca:	4589                	li	a1,2
    800279cc:	fc840513          	addi	a0,s0,-56
    800279d0:	fffff097          	auipc	ra,0xfffff
    800279d4:	788080e7          	jalr	1928(ra) # 80027158 <sd_write_data>
	sd_read_data(&response, 1);
    800279d8:	4585                	li	a1,1
    800279da:	fc740513          	addi	a0,s0,-57
    800279de:	fffff097          	auipc	ra,0xfffff
    800279e2:	7c0080e7          	jalr	1984(ra) # 8002719e <sd_read_data>
	response &= 0x1F;
    800279e6:	fc744783          	lbu	a5,-57(s0)
    800279ea:	8bfd                	andi	a5,a5,31
    800279ec:	fcf403a3          	sb	a5,-57(s0)
	if (response != 0x05)
    800279f0:	f93787e3          	beq	a5,s3,8002797e <sd_write_sector+0x90>
		/*!< Read data response */
		if (sd_get_dataresponse() != 0x00) {
			sd_end_cmd();
    800279f4:	00000097          	auipc	ra,0x0
    800279f8:	84a080e7          	jalr	-1974(ra) # 8002723e <sd_end_cmd>
			return 0xFF;
    800279fc:	0ff00a13          	li	s4,255
    80027a00:	a809                	j	80027a12 <sd_write_sector+0x124>
		}
	}
	sd_end_cmd();
    80027a02:	00000097          	auipc	ra,0x0
    80027a06:	83c080e7          	jalr	-1988(ra) # 8002723e <sd_end_cmd>
	sd_end_cmd();
    80027a0a:	00000097          	auipc	ra,0x0
    80027a0e:	834080e7          	jalr	-1996(ra) # 8002723e <sd_end_cmd>
	/*!< Returns the reponse */
	return 0;
}
    80027a12:	8552                	mv	a0,s4
    80027a14:	70e2                	ld	ra,56(sp)
    80027a16:	7442                	ld	s0,48(sp)
    80027a18:	74a2                	ld	s1,40(sp)
    80027a1a:	7902                	ld	s2,32(sp)
    80027a1c:	69e2                	ld	s3,24(sp)
    80027a1e:	6a42                	ld	s4,16(sp)
    80027a20:	6121                	addi	sp,sp,64
    80027a22:	8082                	ret
	...

0000000080028000 <_trampoline>:
    80028000:	14051573          	csrrw	a0,sscratch,a0
    80028004:	02153423          	sd	ra,40(a0)
    80028008:	02253823          	sd	sp,48(a0)
    8002800c:	02353c23          	sd	gp,56(a0)
    80028010:	04453023          	sd	tp,64(a0)
    80028014:	04553423          	sd	t0,72(a0)
    80028018:	04653823          	sd	t1,80(a0)
    8002801c:	04753c23          	sd	t2,88(a0)
    80028020:	f120                	sd	s0,96(a0)
    80028022:	f524                	sd	s1,104(a0)
    80028024:	fd2c                	sd	a1,120(a0)
    80028026:	e150                	sd	a2,128(a0)
    80028028:	e554                	sd	a3,136(a0)
    8002802a:	e958                	sd	a4,144(a0)
    8002802c:	ed5c                	sd	a5,152(a0)
    8002802e:	0b053023          	sd	a6,160(a0)
    80028032:	0b153423          	sd	a7,168(a0)
    80028036:	0b253823          	sd	s2,176(a0)
    8002803a:	0b353c23          	sd	s3,184(a0)
    8002803e:	0d453023          	sd	s4,192(a0)
    80028042:	0d553423          	sd	s5,200(a0)
    80028046:	0d653823          	sd	s6,208(a0)
    8002804a:	0d753c23          	sd	s7,216(a0)
    8002804e:	0f853023          	sd	s8,224(a0)
    80028052:	0f953423          	sd	s9,232(a0)
    80028056:	0fa53823          	sd	s10,240(a0)
    8002805a:	0fb53c23          	sd	s11,248(a0)
    8002805e:	11c53023          	sd	t3,256(a0)
    80028062:	11d53423          	sd	t4,264(a0)
    80028066:	11e53823          	sd	t5,272(a0)
    8002806a:	11f53c23          	sd	t6,280(a0)
    8002806e:	140022f3          	csrr	t0,sscratch
    80028072:	06553823          	sd	t0,112(a0)
    80028076:	00853103          	ld	sp,8(a0)
    8002807a:	02053203          	ld	tp,32(a0)
    8002807e:	01053283          	ld	t0,16(a0)
    80028082:	00053303          	ld	t1,0(a0)
    80028086:	18031073          	csrw	satp,t1
    8002808a:	12000073          	sfence.vma
    8002808e:	8282                	jr	t0

0000000080028090 <userret>:
    80028090:	18059073          	csrw	satp,a1
    80028094:	12000073          	sfence.vma
    80028098:	07053283          	ld	t0,112(a0)
    8002809c:	14029073          	csrw	sscratch,t0
    800280a0:	02853083          	ld	ra,40(a0)
    800280a4:	03053103          	ld	sp,48(a0)
    800280a8:	03853183          	ld	gp,56(a0)
    800280ac:	04053203          	ld	tp,64(a0)
    800280b0:	04853283          	ld	t0,72(a0)
    800280b4:	05053303          	ld	t1,80(a0)
    800280b8:	05853383          	ld	t2,88(a0)
    800280bc:	7120                	ld	s0,96(a0)
    800280be:	7524                	ld	s1,104(a0)
    800280c0:	7d2c                	ld	a1,120(a0)
    800280c2:	6150                	ld	a2,128(a0)
    800280c4:	6554                	ld	a3,136(a0)
    800280c6:	6958                	ld	a4,144(a0)
    800280c8:	6d5c                	ld	a5,152(a0)
    800280ca:	0a053803          	ld	a6,160(a0)
    800280ce:	0a853883          	ld	a7,168(a0)
    800280d2:	0b053903          	ld	s2,176(a0)
    800280d6:	0b853983          	ld	s3,184(a0)
    800280da:	0c053a03          	ld	s4,192(a0)
    800280de:	0c853a83          	ld	s5,200(a0)
    800280e2:	0d053b03          	ld	s6,208(a0)
    800280e6:	0d853b83          	ld	s7,216(a0)
    800280ea:	0e053c03          	ld	s8,224(a0)
    800280ee:	0e853c83          	ld	s9,232(a0)
    800280f2:	0f053d03          	ld	s10,240(a0)
    800280f6:	0f853d83          	ld	s11,248(a0)
    800280fa:	10053e03          	ld	t3,256(a0)
    800280fe:	10853e83          	ld	t4,264(a0)
    80028102:	11053f03          	ld	t5,272(a0)
    80028106:	11853f83          	ld	t6,280(a0)
    8002810a:	14051573          	csrrw	a0,sscratch,a0
    8002810e:	10200073          	sret
	...
