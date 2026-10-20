/* get_reg_880a7c_8d74b8 @ 0x8d74b8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: check_rf_boardfile, link_lost_diag__dump_rf
 */
	.section .text.get_reg_880a7c_8d74b8,"ax",@progbits
	.global get_reg_880a7c_8d74b8
get_reg_880a7c_8d74b8:
	.global L_8d74b8
L_8d74b8:
	mov_s r0,0x880a7c
L_8d74be:
	ldw_s r0,[r0,0x12]
L_8d74c0:
	cmp_s r0,0x2
L_8d74c2:
	mov_s r0,0x1
L_8d74c4:
	j_s.d [blink]
L_8d74c6:
	sub_s.ne r0,r0,r0
