/* bf__insert_field_fw @ 0x8edc10, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__set_field_byte_fw, bf__set_field_half_fw, bf__set_field_u16_le, bf__set_field_u32_bytewise, bf__set_field_word_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bf__insert_field_fw
bf__insert_field_fw:
	.global L_8edc10
L_8edc10:
	push_s r0
L_8edc12:
	push_s r1
L_8edc14:
	mov r0,-0x1
L_8edc18:
	bmsk r0,r0,r11
L_8edc1c:
	and_s r1,r1,r0
L_8edc1e:
	asl r0,r0,r10
L_8edc22:
	asl r1,r1,r10
L_8edc26:
	bic r12,r12,r0
L_8edc2a:
	or_s r12,r12,r1
L_8edc2c:
	pop_s r1
L_8edc2e:
	j_s.d [blink]
L_8edc30:
	pop_s r0
L_8edc32:
	nop_s
