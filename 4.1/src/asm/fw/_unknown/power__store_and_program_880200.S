/* power__store_and_program_880200 @ 0x8d5bc4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power__enter_halt
 * Зовёт сам: set_reg_880200_8e42d8
 */
	.section .text.power__store_and_program_880200,"ax",@progbits
	.global power__store_and_program_880200
power__store_and_program_880200:
	.global L_8d5bc4
L_8d5bc4:
	st_s r1,[r0]
L_8d5bc6:
	b.d L_8e42d8
L_8d5bca:
	mov_s r0,r1
