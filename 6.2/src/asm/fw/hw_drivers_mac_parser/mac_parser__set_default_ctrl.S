/* mac_parser__set_default_ctrl @ 0x8dfbc8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__set_default_ctrl
mac_parser__set_default_ctrl:
	.global L_8dfbc8
L_8dfbc8:
	mov_s r0,0x886280
L_8dfbce:
	st 0xf0c3f0f0,[r0, 0x8]
L_8dfbd6:
	j_s [blink]
