/* set_reg_880b00_8d16cc @ 0x8d16cc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sdp__program_880b00
 */
	.section .text.set_reg_880b00_8d16cc,"ax",@progbits
	.global set_reg_880b00_8d16cc
set_reg_880b00_8d16cc:
	.global L_8d16cc
L_8d16cc:
	mov_s r1,0x0
L_8d16ce:
	bset r1,r1,r0
L_8d16d2:
	mov_s r0,0x880b00
L_8d16d8:
	st_s r1,[r0,0x64]
L_8d16da:
	j_s [blink]
