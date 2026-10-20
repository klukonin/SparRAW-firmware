/* wmi_ut_handler_dispatch @ 0x8e7ee0, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI_UT_HANDLER:: module_id=0x%x
 *   ut_wmi_handlers.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, UT_HW_MODES_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, __ld_r16_to_r13_ret, __st_r16_to_r13, calib_mgr_ut, fw_log__emit1, fw_sysassert_fatal, power_mgr_ut
 */
	.section .text.wmi_ut_handler_dispatch,"ax",@progbits
	.global wmi_ut_handler_dispatch
wmi_ut_handler_dispatch:
	.global L_8e7ee0
L_8e7ee0:
	push_s blink
L_8e7ee2:
	bl L_8c02bc
L_8e7ee6:
	mov_s r16,r0
L_8e7ee8:
	mov_s r13,r1
L_8e7eea:
	mov_s r2,0x10081e0
L_8e7ef0:
	mov_s r0,0x0
L_8e7ef2:
	mov_s r1,0x2
L_8e7ef4:
	bl.d L_8edfcc
L_8e7ef8:
	ldw_s r3,[r13]
L_8e7efa:
	ldw_s r0,[r13]
L_8e7efc:
	/* sub_s r0,r0,0x7 */
	.byte 0x67,0xb8
L_8e7efe:
	brhs r0,0x7,L_8e7f4a
L_8e7f02:
	ldb.x r0,[0x801cdc,r0]
L_8e7f0a:
	add r1,pcl,0xa
L_8e7f0e:
	add1_s r1,r1,r0
L_8e7f10:
	j_s [r1]
L_8e7f12:
	bl.d L_8e5abc
L_8e7f16:
	mov_s r0,r13
L_8e7f18:
	b_s L_8e7f5c
L_8e7f1a:
	mov_s r0,r16
L_8e7f1c:
	bl.d L_8e6514
L_8e7f20:
	mov_s r1,r13
L_8e7f22:
	b_s L_8e7f5c
L_8e7f24:
	mov_s r0,r16
L_8e7f26:
	bl.d L_8e7024
L_8e7f2a:
	mov_s r1,r13
L_8e7f2c:
	b_s L_8e7f5c
L_8e7f2e:
	mov_s r0,r16
L_8e7f30:
	bl.d L_8e6e5c
L_8e7f34:
	mov_s r1,r13
L_8e7f36:
	b_s L_8e7f5c
L_8e7f38:
	mov_s r0,r16
L_8e7f3a:
	bl.d L_8e5be8
L_8e7f3e:
	mov_s r1,r13
L_8e7f40:
	b_s L_8e7f5c
L_8e7f42:
	bl.d L_8e5b24
L_8e7f46:
	mov_s r0,r13
L_8e7f48:
	b_s L_8e7f5c
	.global L_8e7f4a
L_8e7f4a:
	mov_s r0,blink
L_8e7f4c:
	mov_s r2,0x1008200
L_8e7f52:
	mov_s r1,0xcf
L_8e7f54:
	bset_s r1,r1,0xc
L_8e7f56:
	bl.d L_8c82c0
L_8e7f5a:
	mov_s r3,0x2e
	.global L_8e7f5c
L_8e7f5c:
	b L_8c0324
