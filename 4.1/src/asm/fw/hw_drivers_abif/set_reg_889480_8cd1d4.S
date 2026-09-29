/* set_reg_889480_8cd1d4 @ 0x8cd1d4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_modes__enable_pll
 */
	.section .text.set_reg_889480_8cd1d4,"ax",@progbits
	.global set_reg_889480_8cd1d4
set_reg_889480_8cd1d4:
	.global L_8cd1d4
L_8cd1d4:
	mov_s r1,0x4
L_8cd1d6:
	mov_s r0,0x889480
L_8cd1dc:
	st_s r1,[r0]
L_8cd1de:
	j_s [blink]
