/* get_reg_887030 @ 0x8d9b38, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_icr_88701c_mask
 */
	.section .text.get_reg_887030,"ax",@progbits
	.global get_reg_887030
get_reg_887030:
	.global L_8d9b38
L_8d9b38:
	mov_s r0,0x887000
L_8d9b3e:
	ld_s r0,[r0,0x30]
L_8d9b40:
	j_s [blink]
L_8d9b42:
	nop_s
