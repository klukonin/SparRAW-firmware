/* UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler @ 0x8e7024, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler ut_subtype_id=0x%x
 *   ut_hw_sysapi.c
 * Зовут его: wmi_ut_handler_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_sysassert_fatal, hw_sysapi_config_short_vec, hw_sysapi_force_mcs, ut__begin_response, ut_hw__post_response
 */
	.section .text.UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler,"ax",@progbits
	.global UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler:
	.global L_8e7024
L_8e7024:
	push_s blink
L_8e7026:
	bl L_8c02bc
L_8e702a:
	mov_s r16,r0
L_8e702c:
	mov_s r13,r1
L_8e702e:
	mov_s r2,0x1016638
L_8e7034:
	mov_s r0,0x0
L_8e7036:
	mov_s r1,0x2
L_8e7038:
	bl.d L_8edfcc
L_8e703c:
	ldw_s r3,[r13,0x2]
L_8e703e:
	ldw_s r2,[r13,0x2]
L_8e7040:
	breq r2,0x6,L_8e705c
L_8e7044:
	cmp_s r2,0x48
L_8e7046:
	beq_s L_8e7078
L_8e7048:
	mov_s r0,blink
L_8e704a:
	mov_s r2,0x1016674
L_8e7050:
	mov_s r1,0xe4
L_8e7052:
	bset_s r1,r1,0xc
L_8e7054:
	bl.d L_8c82c0
L_8e7058:
	mov_s r3,0x75
L_8e705a:
	b_s L_8e7094
	.global L_8e705c
L_8e705c:
	mov_s r0,r16
L_8e705e:
	bl.d L_8e5b7c
L_8e7062:
	mov_s r1,0xa
L_8e7064:
	mov_s r14,r0
L_8e7066:
	ldb_s r0,[r13,0x4]
L_8e7068:
	ldb_s r1,[r13,0x8]
L_8e706a:
	bl.d L_8cb754
L_8e706e:
	ldb_s r2,[r13,0xc]
L_8e7070:
	st_s r0,[r14,0x4]
L_8e7072:
	mov_s r0,r16
L_8e7074:
	mov_s r1,r14
L_8e7076:
	b_s L_8e708e
	.global L_8e7078
L_8e7078:
	mov_s r0,r16
L_8e707a:
	bl.d L_8e5b7c
L_8e707e:
	mov_s r1,0xa
L_8e7080:
	mov_s r13,r0
L_8e7082:
	bl.d L_8cb714
L_8e7086:
	mov_s r14,0x1
L_8e7088:
	st_s r14,[r13,0x4]
L_8e708a:
	mov_s r0,r16
L_8e708c:
	mov_s r1,r13
	.global L_8e708e
L_8e708e:
	bl.d L_8e5b94
L_8e7092:
	mov_s r2,0x8
	.global L_8e7094
L_8e7094:
	b L_8c0324
