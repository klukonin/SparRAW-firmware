/* get_reg_8813c8 @ 0x8cda7c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.get_reg_8813c8,"ax",@progbits
	.global get_reg_8813c8
get_reg_8813c8:
	.global L_8cda7c
L_8cda7c:
	mov_s r0,0x881380
L_8cda82:
	ld_s r0,[r0,0x48]
L_8cda84:
	j_s [blink]
L_8cda86:
	nop_s
