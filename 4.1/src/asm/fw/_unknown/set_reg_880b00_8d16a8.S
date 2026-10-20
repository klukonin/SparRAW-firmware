/* set_reg_880b00_8d16a8 @ 0x8d16a8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sdp__program_880b00
 */
	.section .text.set_reg_880b00_8d16a8,"ax",@progbits
	.global set_reg_880b00_8d16a8
set_reg_880b00_8d16a8:
	.global L_8d16a8
L_8d16a8:
	mov_s r1,0x0
L_8d16aa:
	bset r1,r1,r0
L_8d16ae:
	mov_s r0,0x880b00
L_8d16b4:
	st_s r1,[r0,0x50]
L_8d16b6:
	j_s [blink]
