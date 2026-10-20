/* ba_sm__get_param_byte6 @ 0x8cca30, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__prepare_ba_td_8e0ddc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__get_param_byte6
ba_sm__get_param_byte6:
	.global L_8cca30
L_8cca30:
	ld_s r0,[r0,0x40]
L_8cca32:
	j_s.d [blink]
L_8cca34:
	ldb_s r0,[r0,0x6]
L_8cca36:
	nop_s
