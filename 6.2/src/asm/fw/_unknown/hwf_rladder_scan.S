/* hwf_rladder_scan @ 0x8c14f0, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WARNING- setting to MAX value (31) due to no change in comLoop
 *   WARNING!! RLADDER INITIAL STATE WHILST UP SCAN IS BIGGER THAN OUTPUT in measurement:%d , out of: %d , in (TEMP0/VOLT1)%d
 *   WARNING!! RLADDER INITIAL STATE WHILST DOWN SCAN IS SMALLET THAN OUTPUT in measurement:%d , out of: %d , in (TEMP0/VOLT1)%d
 *   WARNING- setting to MIN value (0) due to no change in comLoop
 * Зовут его: hwf__rladder_calibrate
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit0, fw_log_emit3, isr_pcie_main, rladder__step_code
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rladder_scan
hwf_rladder_scan:
	.global L_8c14f0
L_8c14f0:
	push_s blink
L_8c14f2:
	bl L_8c01d4
L_8c14f6:
	sub_s sp,sp,0x4
L_8c14f8:
	mov_s r16,r0
L_8c14fa:
	mov_s r13,r1
L_8c14fc:
	mov_s r18,r2
L_8c14fe:
	add r15,sp,0x1
L_8c1502:
	mov_s r2,sp
L_8c1504:
	bl.d L_8c075c
L_8c1508:
	mov_s r1,r15
L_8c150a:
	cmp r13,0xff
L_8c150e:
	mov r17,0x0
L_8c1512:
	beq_s L_8c1518
L_8c1514:
	stb r13,[sp, 0x1]
	.global L_8c1518
L_8c1518:
	mov_s r14,0x0
L_8c151a:
	b_s L_8c155e
	.global L_8c151c
L_8c151c:
	cmp_s r13,r0
L_8c151e:
	cmp.eq r0,0x1
L_8c1522:
	bne_s L_8c1536
L_8c1524:
	mov_s r0,0x1f
L_8c1526:
	stb r0,[sp, 0x1]
L_8c152a:
	mov_s r1,0x101cd74
	.global L_8c1530
L_8c1530:
	bl.d L_8dcba8
L_8c1534:
	mov_s r0,0x20
	.global L_8c1536
L_8c1536:
	ldb.x r1,[sp, 0x1]
L_8c153a:
	ldb.x r0,[sp]
L_8c153e:
	add r17,r17,r1
L_8c1542:
	sub2 r1,r1,r0
L_8c1546:
	sexb_s r1,r1
L_8c1548:
	mov r0,-0x1
L_8c154c:
	max r0,r1,r0
L_8c1550:
	sexb_s r0,r0
L_8c1552:
	min r0,r0,0x20
L_8c1556:
	stb r0,[sp, 0x1]
L_8c155a:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c155c:
	extb_s r14,r14
	.global L_8c155e
L_8c155e:
	brge r14,0x20,L_8c15dc
L_8c1562:
	mov_s r0,r15
L_8c1564:
	bl.d L_8c15e4
L_8c1568:
	ldb.x r1,[sp]
L_8c156c:
	mov_s r13,r0
L_8c156e:
	cmp r16,0x0
L_8c1572:
	cmp.eq r13,0x0
L_8c1576:
	bne_s L_8c1580
L_8c1578:
	mov_s r1,0x101cdb4
L_8c157e:
	b_s L_8c1590
	.global L_8c1580
L_8c1580:
	cmp r16,0x1
L_8c1584:
	cmp.eq r13,0x1
L_8c1588:
	bne_s L_8c159e
L_8c158a:
	mov_s r1,0x101ce30
	.global L_8c1590
L_8c1590:
	mov_s r0,0x20
L_8c1592:
	mov_s r2,r14
L_8c1594:
	mov_s r3,r0
L_8c1596:
	bl.d L_8dcd00
L_8c159a:
	mov r4,r18
	.global L_8c159e
L_8c159e:
	mov_s r0,r15
L_8c15a0:
	bl.d L_8c15e4
L_8c15a4:
	ldb.x r1,[sp]
L_8c15a8:
	ldb.x r1,[sp, 0x1]
L_8c15ac:
	brne r13,r0,L_8c15b8
L_8c15b0:
	brge r1,0x20,L_8c15b8
L_8c15b4:
	brge r1,0x0,L_8c159e
	.global L_8c15b8
L_8c15b8:
	max r1,r1,0x0
L_8c15bc:
	sexb_s r1,r1
L_8c15be:
	min r1,r1,0x1f
L_8c15c2:
	stb r1,[sp, 0x1]
L_8c15c6:
	cmp_s r13,r0
L_8c15c8:
	cmp.eq r0,0x0
L_8c15cc:
	bne_s L_8c151c
L_8c15ce:
	mov_s r0,0x0
L_8c15d0:
	mov_s r1,0x101ceb0
L_8c15d6:
	stb r0,[sp, 0x1]
L_8c15da:
	b_s L_8c1530
	.global L_8c15dc
L_8c15dc:
	mov_s r0,r17
L_8c15de:
	b.d L_8c0234
L_8c15e2:
	add_s sp,sp,0x4
