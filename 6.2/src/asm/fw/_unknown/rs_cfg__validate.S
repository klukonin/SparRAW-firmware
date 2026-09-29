/* rs_cfg__validate @ 0x8dd5ac, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   connection ID [%d] out of range
 *   STOP TH [%d] out of range
 *   MCS1 FAIL TH [%d] out of range
 *   PER TH [%d] out of range
 *   Unsupported MCS vector [%d]
 *   Unsupported failure window, BACK mask [%d] max back failure TH [%d]
 * Зовут его: wmi_rs_cfg
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rs_cfg__validate
rs_cfg__validate:
	.global L_8dd5ac
L_8dd5ac:
	push_s blink
L_8dd5ae:
	push_s r13
L_8dd5b0:
	ldb_s r2,[r1]
L_8dd5b2:
	brlt.d r2,0x8,L_8dd5c8
L_8dd5b6:
	add_s r3,r1,0x2
L_8dd5b8:
	mov_s r1,0x1006618
	.global L_8dd5be
L_8dd5be:
	bl.d L_8dcc10
L_8dd5c2:
	mov_s r0,0x5
L_8dd5c4:
	mov_s r0,0x0
L_8dd5c6:
	b_s L_8dd646
	.global L_8dd5c8
L_8dd5c8:
	ldb_s r2,[r1,0x1c]
L_8dd5ca:
	cmp_s r2,0x64
L_8dd5cc:
	ble_s L_8dd5d6
L_8dd5ce:
	mov_s r1,0x1006638
L_8dd5d4:
	b_s L_8dd5be
	.global L_8dd5d6
L_8dd5d6:
	ldb_s r2,[r1,0x1d]
L_8dd5d8:
	cmp_s r2,0x64
L_8dd5da:
	ble_s L_8dd5e4
L_8dd5dc:
	mov_s r1,0x1006654
L_8dd5e2:
	b_s L_8dd5be
	.global L_8dd5e4
L_8dd5e4:
	mov_s r0,0x0
L_8dd5e6:
	b_s L_8dd5ea
	.global L_8dd5e8
L_8dd5e8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8dd5ea
L_8dd5ea:
	brge r0,0xd,L_8dd5fc
L_8dd5ee:
	ldb_s r2,[r3,r0]
L_8dd5f0:
	cmp_s r2,0x64
L_8dd5f2:
	ble_s L_8dd5e8
L_8dd5f4:
	mov_s r1,0x1006674
L_8dd5fa:
	b_s L_8dd5be
	.global L_8dd5fc
L_8dd5fc:
	ldw_s r0,[r1,0x26]
L_8dd5fe:
	ldw_s r2,[r1,0x24]
L_8dd600:
	asl_s r0,r0,0x10
L_8dd602:
	or_s r2,r2,r0
L_8dd604:
	mov_s r12,r2
L_8dd606:
	bic.f r12,r12,-0x221
L_8dd60a:
	beq_s L_8dd614
L_8dd60c:
	mov_s r1,0x1006690
L_8dd612:
	b_s L_8dd5be
	.global L_8dd614
L_8dd614:
	ldw_s r0,[r1,0x22]
L_8dd616:
	ldw_s r2,[r1,0x20]
L_8dd618:
	asl_s r0,r0,0x10
L_8dd61a:
	or_s r2,r2,r0
L_8dd61c:
	mov_s r0,0x1f
L_8dd61e:
	bbit1 r2,0x1f,L_8dd62a
L_8dd622:
	norm r3,r2
L_8dd626:
	rsub r0,r3,0x1e
	.global L_8dd62a
L_8dd62a:
	ldb_s r3,[r1,0x1e]
L_8dd62c:
	rsub r13,r0,0x20
L_8dd630:
	brhs r13,r3,L_8dd644
L_8dd634:
	mov_s r1,0x10066ac
L_8dd63a:
	bl.d L_8dcc80
L_8dd63e:
	mov_s r0,0x5
L_8dd640:
	mov_s r0,0x0
L_8dd642:
	b_s L_8dd646
	.global L_8dd644
L_8dd644:
	mov_s r0,0x1
	.global L_8dd646
L_8dd646:
	b L_8c025c
L_8dd64a:
	nop_s
