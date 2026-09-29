/* otp_init @ 0x8f6cb0, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   otp_init(); OTP params_0. seq_num    = %x,  pcb_id8      = %x
 *   otp_init(): OTP params_1. silicon_id = %x,  wilocity_num = %x
 *   otp_init(): OTP read failed
 *   otp_init(): com_test failed, cannot read from OTP
 * Зовут его: fw_main
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit2, hwf_rf_xpm__read_block_8b, rf_comm_test
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global otp_init
otp_init:
	.global L_8f6cb0
L_8f6cb0:
	push_s blink
L_8f6cb2:
	push_s r13
L_8f6cb4:
	mov_s r0,0x8042c8
L_8f6cba:
	bl.d L_8c6a40
L_8f6cbe:
	ldb_s r1,[r0]
L_8f6cc0:
	breq_s r0,0,L_8f6cfa
L_8f6cc2:
	mov_s r13,0x80522c
L_8f6cc8:
	bl.d L_8f6d0c
L_8f6ccc:
	mov_s r0,r13
L_8f6cce:
	breq_s r0,0,L_8f6cf2
L_8f6cd0:
	ld_s r2,[r13]
L_8f6cd2:
	mov_s r1,0x101339c
L_8f6cd8:
	mov_s r0,0x20
L_8f6cda:
	bl.d L_8dcc80
L_8f6cde:
	ldb_s r3,[r13,0x4]
L_8f6ce0:
	mov_s r1,0x10133dc
L_8f6ce6:
	ldb_s r2,[r13,0x5]
L_8f6ce8:
	mov_s r0,0x20
L_8f6cea:
	bl.d L_8dcc80
L_8f6cee:
	ldw_s r3,[r13,0x6]
L_8f6cf0:
	b_s L_8f6d06
	.global L_8f6cf2
L_8f6cf2:
	mov_s r1,0x101341c
L_8f6cf8:
	b_s L_8f6d00
	.global L_8f6cfa
L_8f6cfa:
	mov_s r1,0x1013438
	.global L_8f6d00
L_8f6d00:
	bl.d L_8dcba8
L_8f6d04:
	mov_s r0,0x10
	.global L_8f6d06
L_8f6d06:
	b L_8c025c
L_8f6d0a:
	nop_s
