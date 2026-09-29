/* uc_ap__read_match_value @ 0x920fa8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_vector_02
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_ap__read_match_value
uc_ap__read_match_value:
	.global L_920fa8
L_920fa8:
	add1_s r0,r0,r0
L_920faa:
	add r0,r0,0x220
L_920fae:
	j_s.d [blink]
L_920fb0:
	lr r0,[r0]
