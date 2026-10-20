/* bf__set_field_u32_bytewise @ 0x8edc60, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dmg_cap__bits_set32b_s4_w24
 * Зовёт сам: bf__insert_field_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bf__set_field_u32_bytewise
bf__set_field_u32_bytewise:
	.global L_8edc60
L_8edc60:
	push_s r12
L_8edc62:
	push_s r2
L_8edc64:
	push_s blink
L_8edc66:
	ldb r2,[r0, 0x3]
L_8edc6a:
	ldb r12,[r0, 0x2]
L_8edc6e:
	asl r2,r2,0x18
L_8edc72:
	asl r12,r12,0x10
L_8edc76:
	or blink,r12,r2
L_8edc7a:
	ldb r2,[r0, 0x1]
L_8edc7e:
	ldb r12,[r0]
L_8edc82:
	asl r2,r2,0x8
L_8edc86:
	or r12,r12,r2
L_8edc8a:
	or r12,r12,blink
L_8edc8e:
	bl L_8edc10
L_8edc92:
	stb r12,[r0]
L_8edc96:
	lsr r12,r12,0x8
L_8edc9a:
	stb r12,[r0, 0x1]
L_8edc9e:
	lsr r12,r12,0x8
L_8edca2:
	stb r12,[r0, 0x2]
L_8edca6:
	lsr r12,r12,0x8
L_8edcaa:
	stb r12,[r0, 0x3]
L_8edcae:
	pop_s blink
L_8edcb0:
	pop_s r2
L_8edcb2:
	j_s.d [blink]
L_8edcb4:
	pop_s r12
L_8edcb6:
	nop_s
