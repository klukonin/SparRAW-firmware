/* set_g_800240 @ 0x8e1ab4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit
 */
	.section .text.set_g_800240,"ax",@progbits
	.global set_g_800240
set_g_800240:
	.global L_8e1ab4
L_8e1ab4:
	j_s.d [blink]
L_8e1ab6:
	stb r0,[gp, 0xd0]
L_8e1aba:
	nop_s
