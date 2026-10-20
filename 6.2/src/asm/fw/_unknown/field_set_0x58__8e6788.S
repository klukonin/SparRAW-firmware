/* field_set_0x58__8e6788 @ 0x8e6788, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__pcp_start_flow
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x58__8e6788
field_set_0x58__8e6788:
	.global L_8e6788
L_8e6788:
	j_s.d [blink]
L_8e678a:
	st_s r1,[r0,0x58]
