/* get_g_800240 @ 0x8ca1a4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit, tx_api__send_mgmt, tx_api__send_mgmt_with_cb
 * Глобалы (через gp): 0x800240
 */
	.section .text.get_g_800240,"ax",@progbits
	.global get_g_800240
get_g_800240:
	.global L_8ca1a4
L_8ca1a4:
	j_s.d [blink]
L_8ca1a6:
	ldb_s r0,[gp,0xd0]
