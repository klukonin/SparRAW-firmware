/* bf__set_field_byte_fw @ 0x8edccc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon__bits_set8_s5_w3, bits__set8_s0_w2, bits__set8_s0_w4, bits__set8_s2_w4, bits__set8_s2_w5, bits__set8_s2_w6, bits__set8_s4_w2, bits__set8_s4_w4, bits__set8_s6_w2, dmg_cap__bits_set8_s1_w3
 * Зовёт сам: bf__insert_field_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bf__set_field_byte_fw
bf__set_field_byte_fw:
	.global L_8edccc
L_8edccc:
	push_s r12
L_8edcce:
	push_s blink
L_8edcd0:
	bl.d L_8edc10
L_8edcd4:
	ldb_s r12,[r0]
L_8edcd6:
	stb_s r12,[r0]
L_8edcd8:
	ld.ab blink,[sp,0x4]
L_8edcdc:
	j_s.d [blink]
L_8edcde:
	pop_s r12
