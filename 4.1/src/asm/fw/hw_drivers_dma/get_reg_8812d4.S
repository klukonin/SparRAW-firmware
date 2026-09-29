/* get_reg_8812d4 @ 0x8cda1c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_lost_diag__dump_dma
 */
	.section .text.get_reg_8812d4,"ax",@progbits
	.global get_reg_8812d4
get_reg_8812d4:
	.global L_8cda1c
L_8cda1c:
	mov_s r0,0x881280
L_8cda22:
	ld_s r0,[r0,0x54]
L_8cda24:
	j_s [blink]
L_8cda26:
	nop_s
