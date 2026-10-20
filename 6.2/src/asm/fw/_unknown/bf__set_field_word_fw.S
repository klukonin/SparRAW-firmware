/* bf__set_field_word_fw @ 0x8edcb8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bits__set32_s0_w12, bits__set32_s0_w13, bits__set32_s0_w2, bits__set32_s0_w4, bits__set32_s0_w5, bits__set32_s12_w12, bits__set32_s14_w2, bits__set32_s16_w12, bits__set32_s16_w4, bits__set32_s16_w5
 * Зовёт сам: bf__insert_field_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bf__set_field_word_fw
bf__set_field_word_fw:
	.global L_8edcb8
L_8edcb8:
	push_s r12
L_8edcba:
	push_s blink
L_8edcbc:
	bl.d L_8edc10
L_8edcc0:
	ld_s r12,[r0]
L_8edcc2:
	st_s r12,[r0]
L_8edcc4:
	ld.ab blink,[sp,0x4]
L_8edcc8:
	j_s.d [blink]
L_8edcca:
	pop_s r12
