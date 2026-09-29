/* ut__begin_response @ 0x8eae60, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_OPERATIONAL_cmd_handler, UT_HW_MODES_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, fw_sysapi_mgr__send_evt2host, hw_sysapi_get_beamforming_statistics
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut__begin_response
ut__begin_response:
	.global L_8eae60
L_8eae60:
	push_s blink
L_8eae62:
	bl L_8c01e4
L_8eae66:
	mov_s r14,r1
L_8eae68:
	bl.d L_8c33d0
L_8eae6c:
	mov_s r13,r2
L_8eae6e:
	stw_s r14,[r0]
L_8eae70:
	b.d L_8c0254
L_8eae74:
	stw_s r13,[r0,0x2]
L_8eae76:
	nop_s
