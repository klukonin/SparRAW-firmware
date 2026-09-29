/* set_reg_889480 @ 0x8cd1c8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_abif__program_rf_clk
 */
	.section .text.set_reg_889480,"ax",@progbits
	.global set_reg_889480
set_reg_889480:
	.global L_8cd1c8
L_8cd1c8:
	mov_s r1,0x80
L_8cd1ca:
	mov_s r0,0x889480
L_8cd1d0:
	st_s r1,[r0]
L_8cd1d2:
	j_s [blink]
