/* ucode_cmd_0x04_handler_uc @ 0x93adf0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, txrx_api_step_c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x04_handler_uc
ucode_cmd_0x04_handler_uc:
	.global L_93adf0
L_93adf0:
	push_s blink
L_93adf2:
	bl L_920234
L_93adf6:
	mov_s r14,r0
L_93adf8:
	mov_s r13,0x0
L_93adfa:
	b_s L_93ae0e
	.global L_93adfc
L_93adfc:
	asl_s r1,r13,0x2
L_93adfe:
	add1_s r1,r1,r1
L_93ae00:
	ld_s r0,[r14,r1]
L_93ae02:
	cmp_s r0,0x4
L_93ae04:
	bl.cs.d L_9368d8
L_93ae08:
	add.cs r1,r1,r14
L_93ae0c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_93ae0e
L_93ae0e:
	brlo r13,0x4,L_93adfc
L_93ae12:
	b L_9202a4
L_93ae16:
	nop_s
