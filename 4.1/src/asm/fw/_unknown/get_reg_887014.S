/* get_reg_887014 @ 0x8d9b2c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_icr_887000_mask
 */
	.section .text.get_reg_887014,"ax",@progbits
	.global get_reg_887014
get_reg_887014:
	.global L_8d9b2c
L_8d9b2c:
	mov_s r0,0x887000
L_8d9b32:
	ld_s r0,[r0,0x14]
L_8d9b34:
	j_s [blink]
L_8d9b36:
	nop_s
