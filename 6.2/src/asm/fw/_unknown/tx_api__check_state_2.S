/* tx_api__check_state_2 @ 0x8e7ec4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__pause_for_ch_switch
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, sm__null_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__check_state_2
tx_api__check_state_2:
	.global L_8e7ec4
L_8e7ec4:
	push_s blink
L_8e7ec6:
	push_s r13
L_8e7ec8:
	mov_s r13,r0
L_8e7eca:
	ld_s r0,[r0,0x8]
L_8e7ecc:
	breq r0,0x2,L_8e7ee6
	.global L_8e7ed0
L_8e7ed0:
	ld_s r0,[r13,0x34]
L_8e7ed2:
	cmp_s r0,0x0
L_8e7ed4:
	mov_s r0,0x1
L_8e7ed6:
	sub_s.ne r0,r0,r0
L_8e7ed8:
	extb.f 0x0,r0
L_8e7edc:
	beq_s L_8e7ef4
L_8e7ede:
	bl.d L_8df4f0
L_8e7ee2:
	mov_s r0,r13
L_8e7ee4:
	b_s L_8e7ef8
	.global L_8e7ee6
L_8e7ee6:
	mov_s r0,blink
L_8e7ee8:
	mov_s r1,0x120e
L_8e7eee:
	bl L_8c9b28
L_8e7ef2:
	b_s L_8e7ed0
	.global L_8e7ef4
L_8e7ef4:
	mov_s r0,0x2
L_8e7ef6:
	st_s r0,[r13,0x8]
	.global L_8e7ef8
L_8e7ef8:
	b L_8c025c
