/* bf_rmw_word_unaligned_uc @ 0x937ed4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_s11_w5_uc
 * Зовёт сам: bf_core_insert_uc
 */
	.section .text.bf_rmw_word_unaligned_uc,"ax",@progbits
	.global bf_rmw_word_unaligned_uc
bf_rmw_word_unaligned_uc:
	.global L_937ed4
L_937ed4:
	push_s r12
L_937ed6:
	push_s r2
L_937ed8:
	push_s blink
L_937eda:
	ldb r2,[r0, 0x3]
L_937ede:
	ldb r12,[r0, 0x2]
L_937ee2:
	asl r2,r2,0x18
L_937ee6:
	asl r12,r12,0x10
L_937eea:
	or blink,r12,r2
L_937eee:
	ldb r2,[r0, 0x1]
L_937ef2:
	ldb r12,[r0]
L_937ef6:
	asl r2,r2,0x8
L_937efa:
	or r12,r12,r2
L_937efe:
	or r12,r12,blink
L_937f02:
	bl L_937e84
L_937f06:
	stb r12,[r0]
L_937f0a:
	lsr r12,r12,0x8
L_937f0e:
	stb r12,[r0, 0x1]
L_937f12:
	lsr r12,r12,0x8
L_937f16:
	stb r12,[r0, 0x2]
L_937f1a:
	lsr r12,r12,0x8
L_937f1e:
	stb r12,[r0, 0x3]
L_937f22:
	pop_s blink
L_937f24:
	pop_s r2
L_937f26:
	j_s.d [blink]
L_937f28:
	pop_s r12
L_937f2a:
	nop_s
