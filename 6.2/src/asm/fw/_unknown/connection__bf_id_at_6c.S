/* connection__bf_id_at_6c @ 0x8e75e8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__update_bf_id_on_rs_done, connection__bf_notify_entry, connection__on_bf_result
 * Зовёт сам: fw_divmod_unsigned
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global connection__bf_id_at_6c
connection__bf_id_at_6c:
	.global L_8e75e8
L_8e75e8:
	push_s blink
L_8e75ea:
	ldb r1,[r0, 0x6c]
L_8e75ee:
	bl.d L_8c02d4
L_8e75f2:
	ld_s r0,[r0,0x68]
L_8e75f4:
	extb_s r0,r0
L_8e75f6:
	pop_s blink
L_8e75f8:
	j_s [blink]
L_8e75fa:
	nop_s
