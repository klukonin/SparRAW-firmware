/* wmi_handler_set_mac_address @ 0x8e7e4c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: l2mgr__set_mac_address
 */
	.section .text.wmi_handler_set_mac_address,"ax",@progbits
	.global wmi_handler_set_mac_address
wmi_handler_set_mac_address:
	.global L_8e7e4c
L_8e7e4c:
	b L_8f3284
