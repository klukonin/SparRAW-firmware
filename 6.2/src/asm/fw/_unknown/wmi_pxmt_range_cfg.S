/* wmi_pxmt_range_cfg @ 0x8ec9d0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, mid_list__by_mid_fw, mid_list__find_by
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_pxmt_range_cfg
wmi_pxmt_range_cfg:
	.global L_8ec9d0
L_8ec9d0:
	push_s blink
L_8ec9d2:
	push_s r13
L_8ec9d4:
	mov_s r13,r0
L_8ec9d6:
	bl.d L_8cc3dc
L_8ec9da:
	mov_s r0,r1
L_8ec9dc:
	bl.d L_8cc024
L_8ec9e0:
	mov_s r1,r13
L_8ec9e2:
	b L_8c025c
L_8ec9e6:
	nop_s
