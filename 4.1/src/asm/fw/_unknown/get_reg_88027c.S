/* get_reg_88027c @ 0x8d76f8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.get_reg_88027c,"ax",@progbits
	.global get_reg_88027c
get_reg_88027c:
	.global L_8d76f8
L_8d76f8:
	mov_s r0,0x880200
L_8d76fe:
	ld_s r0,[r0,0x7c]
L_8d7700:
	j_s [blink]
L_8d7702:
	nop_s
