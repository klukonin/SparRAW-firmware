/* set_reg_880b50_x2 @ 0x8d7708, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.set_reg_880b50_x2,"ax",@progbits
	.global set_reg_880b50_x2
set_reg_880b50_x2:
	.global L_8d7708
L_8d7708:
	mov_s r1,0x10
L_8d770a:
	mov_s r0,0x880b00
L_8d7710:
	st_s r1,[r0,0x50]
L_8d7712:
	st_s r1,[r0,0x64]
L_8d7714:
	j_s [blink]
L_8d7716:
	nop_s
