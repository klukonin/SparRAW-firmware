/* tx_api__get_mgmt_retry_limit @ 0x8cc3d0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit, tx_api__send_mgmt, tx_api__send_mgmt_with_cb
 * Глобалы (через gp): 0x800257
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__get_mgmt_retry_limit
tx_api__get_mgmt_retry_limit:
	.global L_8cc3d0
L_8cc3d0:
	j_s.d [blink]
L_8cc3d2:
	ldb_s r0,[gp,0xd3]
