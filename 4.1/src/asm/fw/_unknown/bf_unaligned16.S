/* bf_unaligned16 @ 0x8e888c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_u16_s3_w8, bf_u16_s4_w12, bf_u16_s5_w5, bf_u16_s5_w6, bf_u16_s6_w10, bf_u16_s6_w6, bf_u16_s6_w7, bf_u16_s7_w3, bf_u16_s7_w5, bf_u16_s7_w6
 * Зовёт сам: bf_insert
 */
	.section .text.bf_unaligned16,"ax",@progbits
	.global bf_unaligned16
bf_unaligned16:
	.global L_8e888c
L_8e888c:
	push_s r12
L_8e888e:
	push_s r2
L_8e8890:
	push_s blink
L_8e8892:
	ldb r2,[r0, 0x1]
L_8e8896:
	ldb r12,[r0]
L_8e889a:
	asl r2,r2,0x8
L_8e889e:
	bl.d L_8e8868
L_8e88a2:
	or_s r12,r12,r2
L_8e88a4:
	stb r12,[r0]
L_8e88a8:
	lsr r12,r12,0x8
L_8e88ac:
	stb r12,[r0, 0x1]
L_8e88b0:
	pop_s blink
L_8e88b2:
	pop_s r2
L_8e88b4:
	j_s.d [blink]
L_8e88b6:
	pop_s r12
