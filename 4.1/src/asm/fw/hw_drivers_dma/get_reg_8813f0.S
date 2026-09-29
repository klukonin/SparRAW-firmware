/* get_reg_8813f0 @ 0x8cda70, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.get_reg_8813f0,"ax",@progbits
	.global get_reg_8813f0
get_reg_8813f0:
	.global L_8cda70
L_8cda70:
	mov_s r0,0x881380
L_8cda76:
	ld_s r0,[r0,0x70]
L_8cda78:
	j_s [blink]
L_8cda7a:
	nop_s
