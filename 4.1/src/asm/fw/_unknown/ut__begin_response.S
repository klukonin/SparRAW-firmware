/* ut__begin_response @ 0x8e5b7c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, UT_HW_MODES_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_if__alloc_mbox_slot
 */
	.section .text.ut__begin_response,"ax",@progbits
	.global ut__begin_response
ut__begin_response:
	.global L_8e5b7c
L_8e5b7c:
	push_s blink
L_8e5b7e:
	bl L_8c02c4
L_8e5b82:
	mov_s r14,r1
L_8e5b84:
	bl.d L_8c2c38
L_8e5b88:
	mov_s r13,r2
L_8e5b8a:
	stw_s r14,[r0]
L_8e5b8c:
	b.d L_8c0334
L_8e5b90:
	stw_s r13,[r0,0x2]
L_8e5b92:
	nop_s
