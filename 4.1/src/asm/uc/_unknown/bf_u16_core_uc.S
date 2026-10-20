/* bf_u16_core_uc @ 0x937ea8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bf_core_insert_uc
 */
	.section .text.bf_u16_core_uc,"ax",@progbits
	.global bf_u16_core_uc
bf_u16_core_uc:
L_937ea8:
	push_s r12
L_937eaa:
	push_s r2
L_937eac:
	push_s blink
L_937eae:
	ldb r2,[r0, 0x1]
L_937eb2:
	ldb r12,[r0]
L_937eb6:
	asl r2,r2,0x8
L_937eba:
	bl.d L_937e84
L_937ebe:
	or_s r12,r12,r2
L_937ec0:
	stb r12,[r0]
L_937ec4:
	lsr r12,r12,0x8
L_937ec8:
	stb r12,[r0, 0x1]
L_937ecc:
	pop_s blink
L_937ece:
	pop_s r2
L_937ed0:
	j_s.d [blink]
L_937ed2:
	pop_s r12
