/* rs_cfg__validate @ 0x8d97a8, 188 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовут его: wmi_handler_rs_cfg
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, fw_log__emit2
 */
	.section .text.rs_cfg__validate,"ax",@progbits
	.global rs_cfg__validate
rs_cfg__validate:
	.global L_8d97a8
L_8d97a8:
	push_s blink
L_8d97aa:
	push_s r13
L_8d97ac:
	ldb_s r3,[r1]
L_8d97ae:
	brlt.d r3,0x8,L_8d97c6
L_8d97b2:
	add_s r2,r1,0x2
L_8d97b4:
	mov_s r2,0x10062e0
	.global L_8d97ba
L_8d97ba:
	mov_s r0,0x5
L_8d97bc:
	bl.d L_8edfcc
L_8d97c0:
	mov_s r1,0x0
L_8d97c2:
	mov_s r0,0x0
L_8d97c4:
	b_s L_8d9860
	.global L_8d97c6
L_8d97c6:
	ldb_s r3,[r1,0x1c]
L_8d97c8:
	cmp_s r3,0x64
L_8d97ca:
	ble_s L_8d97d4
L_8d97cc:
	mov_s r2,0x1006300
L_8d97d2:
	b_s L_8d97ba
	.global L_8d97d4
L_8d97d4:
	ldb_s r3,[r1,0x1d]
L_8d97d6:
	cmp_s r3,0x64
L_8d97d8:
	ble_s L_8d97e2
L_8d97da:
	mov_s r2,0x100631c
L_8d97e0:
	b_s L_8d97ba
	.global L_8d97e2
L_8d97e2:
	mov_s r0,0x0
L_8d97e4:
	b_s L_8d97e8
	.global L_8d97e6
L_8d97e6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8d97e8
L_8d97e8:
	brge r0,0xd,L_8d9806
L_8d97ec:
	ldb_s r3,[r2,r0]
L_8d97ee:
	cmp_s r3,0x64
L_8d97f0:
	ble_s L_8d97e6
L_8d97f2:
	mov_s r2,0x100633c
L_8d97f8:
	mov_s r0,0x5
L_8d97fa:
	mov_s r13,0x0
L_8d97fc:
	bl.d L_8edfcc
L_8d9800:
	mov_s r1,r13
L_8d9802:
	mov_s r0,r13
L_8d9804:
	b_s L_8d9860
	.global L_8d9806
L_8d9806:
	ldw_s r0,[r1,0x26]
L_8d9808:
	ldw_s r3,[r1,0x24]
L_8d980a:
	asl_s r0,r0,0x10
L_8d980c:
	or_s r3,r3,r0
L_8d980e:
	mov_s r12,r3
L_8d9810:
	bic.f r12,r12,-0x221
L_8d9814:
	beq_s L_8d9828
L_8d9816:
	mov_s r2,0x1006358
L_8d981c:
	mov_s r0,0x5
L_8d981e:
	bl.d L_8edfcc
L_8d9822:
	mov_s r1,0x0
L_8d9824:
	mov_s r0,0x0
L_8d9826:
	b_s L_8d9860
	.global L_8d9828
L_8d9828:
	ldw_s r0,[r1,0x22]
L_8d982a:
	ldw_s r3,[r1,0x20]
L_8d982c:
	asl_s r0,r0,0x10
L_8d982e:
	or_s r3,r3,r0
L_8d9830:
	mov_s r0,0x1f
L_8d9832:
	bbit1 r3,0x1f,L_8d983e
L_8d9836:
	norm r2,r3
L_8d983a:
	rsub r0,r2,0x1e
	.global L_8d983e
L_8d983e:
	ldb r4,[r1, 0x1e]
L_8d9842:
	rsub r2,r0,0x20
L_8d9846:
	brhs r2,r4,L_8d985e
L_8d984a:
	mov_s r2,0x1006374
L_8d9850:
	mov_s r0,0x5
L_8d9852:
	mov_s r13,0x0
L_8d9854:
	bl.d L_8edff8
L_8d9858:
	mov_s r1,r13
L_8d985a:
	mov_s r0,r13
L_8d985c:
	b_s L_8d9860
	.global L_8d985e
L_8d985e:
	mov_s r0,0x1
	.global L_8d9860
L_8d9860:
	b L_8c033c
