/* frag_8caca8 @ 0x8caca8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fill_statistics_to_host
 */
	.section .text.frag_8caca8,"ax",@progbits
	.global frag_8caca8
frag_8caca8:
	.global L_8caca8
L_8caca8:
	b.d L_8cacb0
L_8cacac:
	add_s r0,r0,0x34
L_8cacae:
	nop_s
	.global L_8cacb0
L_8cacb0:
	b.d L_8cacb8
L_8cacb4:
	add_s r0,r0,0x50
L_8cacb6:
	nop_s
	.global L_8cacb8
L_8cacb8:
	j_s.d [blink]
L_8cacba:
	ld_s r0,[r0,0x40]
