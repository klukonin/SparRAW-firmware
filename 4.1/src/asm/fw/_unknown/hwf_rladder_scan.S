/* hwf_rladder_scan @ 0x8c14b4, 252 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit0, fw_log__emit3, rladder__mark_invalid, rladder__step_code
 */
	.section .text.hwf_rladder_scan,"ax",@progbits
	.global hwf_rladder_scan
hwf_rladder_scan:
	.global L_8c14b4
L_8c14b4:
	push_s blink
L_8c14b6:
	bl L_8c02b4
L_8c14ba:
	sub_s sp,sp,0x4
L_8c14bc:
	mov_s r16,r0
L_8c14be:
	mov_s r13,r1
L_8c14c0:
	mov_s r18,r2
L_8c14c2:
	add r15,sp,0x1
L_8c14c6:
	mov_s r2,sp
L_8c14c8:
	bl.d L_8c075c
L_8c14cc:
	mov_s r1,r15
L_8c14ce:
	cmp r13,0xff
L_8c14d2:
	mov r17,0x0
L_8c14d6:
	beq_s L_8c14dc
L_8c14d8:
	stb r13,[sp, 0x1]
	.global L_8c14dc
L_8c14dc:
	mov_s r14,0x0
L_8c14de:
	b_s L_8c1524
	.global L_8c14e0
L_8c14e0:
	cmp_s r13,r0
L_8c14e2:
	cmp.eq r0,0x1
L_8c14e6:
	bne_s L_8c14fc
L_8c14e8:
	mov_s r0,0x1f
L_8c14ea:
	stb r0,[sp, 0x1]
L_8c14ee:
	mov_s r2,0x101806c
L_8c14f4:
	mov_s r0,0x0
	.global L_8c14f6
L_8c14f6:
	bl.d L_8edfb0
L_8c14fa:
	mov_s r1,0x2
	.global L_8c14fc
L_8c14fc:
	ldb.x r1,[sp, 0x1]
L_8c1500:
	ldb.x r0,[sp]
L_8c1504:
	add r17,r17,r1
L_8c1508:
	sub2 r1,r1,r0
L_8c150c:
	sexb_s r1,r1
L_8c150e:
	mov r0,-0x1
L_8c1512:
	max r0,r1,r0
L_8c1516:
	sexb_s r0,r0
L_8c1518:
	min r0,r0,0x20
L_8c151c:
	stb r0,[sp, 0x1]
L_8c1520:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c1522:
	extb_s r14,r14
	.global L_8c1524
L_8c1524:
	brge r14,0x20,L_8c15a6
L_8c1528:
	mov_s r0,r15
L_8c152a:
	bl.d L_8c15b0
L_8c152e:
	ldb.x r1,[sp]
L_8c1532:
	mov_s r13,r0
L_8c1534:
	cmp r16,0x0
L_8c1538:
	cmp.eq r13,0x0
L_8c153c:
	bne_s L_8c1546
L_8c153e:
	mov_s r2,0x10180ac
L_8c1544:
	b_s L_8c1556
	.global L_8c1546
L_8c1546:
	cmp r16,0x1
L_8c154a:
	cmp.eq r13,0x1
L_8c154e:
	bne_s L_8c1568
L_8c1550:
	mov_s r2,0x1018128
	.global L_8c1556
L_8c1556:
	mov_s r0,0x0
L_8c1558:
	mov_s r1,0x2
L_8c155a:
	mov_s r3,r14
L_8c155c:
	mov r4,0x20
L_8c1560:
	bl.d L_8ee034
L_8c1564:
	mov r5,r18
	.global L_8c1568
L_8c1568:
	mov_s r0,r15
L_8c156a:
	bl.d L_8c15b0
L_8c156e:
	ldb.x r1,[sp]
L_8c1572:
	ldb.x r1,[sp, 0x1]
L_8c1576:
	brne r13,r0,L_8c1582
L_8c157a:
	brge r1,0x20,L_8c1582
L_8c157e:
	brge r1,0x0,L_8c1568
	.global L_8c1582
L_8c1582:
	max r1,r1,0x0
L_8c1586:
	sexb_s r1,r1
L_8c1588:
	min r1,r1,0x1f
L_8c158c:
	stb r1,[sp, 0x1]
L_8c1590:
	cmp_s r13,r0
L_8c1592:
	cmp.eq r0,0x0
L_8c1596:
	bne_s L_8c14e0
L_8c1598:
	mov_s r0,0x0
L_8c159a:
	mov_s r2,0x10181a8
L_8c15a0:
	stb r0,[sp, 0x1]
L_8c15a4:
	b_s L_8c14f6
	.global L_8c15a6
L_8c15a6:
	mov_s r0,r17
L_8c15a8:
	b.d L_8c0314
L_8c15ac:
	add_s sp,sp,0x4
L_8c15ae:
	nop_s
