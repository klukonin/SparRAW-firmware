/* ba_sm__get_param_byte7 @ 0x8cce9c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__action_8e0d9c, ba_sm__prepare_ba_td_8e0ddc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__get_param_byte7
ba_sm__get_param_byte7:
	.global L_8cce9c
L_8cce9c:
	ld_s r0,[r0,0x40]
L_8cce9e:
	j_s.d [blink]
L_8ccea0:
	ldb_s r0,[r0,0x7]
L_8ccea2:
	nop_s
