/* wmi_handler_abort_scan @ 0x8e7afc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r13_ret, l2_mgr__aborting_scan, tx_probe__send_scan_complete
 */
	.section .text.wmi_handler_abort_scan,"ax",@progbits
	.global wmi_handler_abort_scan
wmi_handler_abort_scan:
	.global L_8e7afc
L_8e7afc:
	push_s blink
L_8e7afe:
	push_s r13
L_8e7b00:
	bl.d L_8e8e70
L_8e7b04:
	mov_s r13,r0
L_8e7b06:
	cmp_s r0,0x0
L_8e7b08:
	mov.eq r0,0x4
L_8e7b0c:
	bl.eq.d L_8f0980
L_8e7b10:
	mov.eq r1,r13
L_8e7b14:
	b L_8c033c
