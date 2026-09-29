/* tx_api__set_mgmt_retry_limit @ 0x8e6900, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__set_mgmt_retry_limit
tx_api__set_mgmt_retry_limit:
	.global L_8e6900
L_8e6900:
	j_s.d [blink]
L_8e6902:
	stb r0,[gp, 0xd3]
L_8e6906:
	nop_s
