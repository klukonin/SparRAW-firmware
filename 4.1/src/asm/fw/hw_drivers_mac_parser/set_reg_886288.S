/* set_reg_886288 @ 0x8dbaf0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 */
	.section .text.set_reg_886288,"ax",@progbits
	.global set_reg_886288
set_reg_886288:
	.global L_8dbaf0
L_8dbaf0:
	mov_s r0,0x886280
L_8dbaf6:
	st 0xf0c3f0f0,[r0, 0x8]
L_8dbafe:
	j_s [blink]
