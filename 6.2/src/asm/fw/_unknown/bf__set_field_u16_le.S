/* bf__set_field_u16_le @ 0x8edc34, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon__bits_set16_s6_w7, bcon__bits_set16_s7_w3, bcon__bits_set16_s7_w6, bits__set16_s6_w6, bits__set16_s7_w5, bits__set16_s7_w7, dmg_cap__bits_set16_s3_w8, dmg_cap__bits_set16_s5_w6, frame__bits_set16_s4_w12, frame__bits_set16_s6_w10
 * Зовёт сам: bf__insert_field_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bf__set_field_u16_le
bf__set_field_u16_le:
	.global L_8edc34
L_8edc34:
	push_s r12
L_8edc36:
	push_s r2
L_8edc38:
	push_s blink
L_8edc3a:
	ldb r2,[r0, 0x1]
L_8edc3e:
	ldb r12,[r0]
L_8edc42:
	asl r2,r2,0x8
L_8edc46:
	bl.d L_8edc10
L_8edc4a:
	or_s r12,r12,r2
L_8edc4c:
	stb r12,[r0]
L_8edc50:
	lsr r12,r12,0x8
L_8edc54:
	stb r12,[r0, 0x1]
L_8edc58:
	pop_s blink
L_8edc5a:
	pop_s r2
L_8edc5c:
	j_s.d [blink]
L_8edc5e:
	pop_s r12
