/* wmi_handler_pxmt_range_cfg @ 0x8e7a84, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r13_ret, mid_list__by_mid, mid_list__find_by
 */
	.section .text.wmi_handler_pxmt_range_cfg,"ax",@progbits
	.global wmi_handler_pxmt_range_cfg
wmi_handler_pxmt_range_cfg:
	.global L_8e7a84
L_8e7a84:
	push_s blink
L_8e7a86:
	push_s r13
L_8e7a88:
	mov_s r13,r0
L_8e7a8a:
	bl.d L_8ca1b0
L_8e7a8e:
	mov_s r0,r1
L_8e7a90:
	bl.d L_8c9e74
L_8e7a94:
	mov_s r1,r13
L_8e7a96:
	b L_8c033c
L_8e7a9a:
	nop_s
