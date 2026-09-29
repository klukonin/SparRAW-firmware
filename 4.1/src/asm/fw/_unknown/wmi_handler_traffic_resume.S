/* wmi_handler_traffic_resume @ 0x8e7ed4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: l2mgr__send_traffic_resume_evt
 */
	.section .text.wmi_handler_traffic_resume,"ax",@progbits
	.global wmi_handler_traffic_resume
wmi_handler_traffic_resume:
	.global L_8e7ed4
L_8e7ed4:
	mov_s r0,0x803510
L_8e7eda:
	b L_8dc494
L_8e7ede:
	nop_s
