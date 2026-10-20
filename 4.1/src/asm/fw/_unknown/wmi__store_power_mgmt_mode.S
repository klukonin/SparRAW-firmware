/* wmi__store_power_mgmt_mode @ 0x8e7690, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_power_mgmt_cfg
 */
	.section .text.wmi__store_power_mgmt_mode,"ax",@progbits
	.global wmi__store_power_mgmt_mode
wmi__store_power_mgmt_mode:
	.global L_8e7690
L_8e7690:
	ldb_s r0,[r0]
L_8e7692:
	j_s.d [blink]
L_8e7694:
	st.as r0,[gp,-0x17]
