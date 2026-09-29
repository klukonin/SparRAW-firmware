/* wmi_handler_get_rf_sector_params__set @ 0x8e5e00, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_get_rf_sector_params::set: Cannot execute command since radio is still locked by previous request. m_radio_handle=0x%X
 *   wmi_handler_get_rf_sector_params::set: Cannot execute command due to BAD_PARAMETERS_ERROR
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit1, mem_pool__alloc_locked, memcpy_fw, memset0_words, wmi_evt__post, wmi_handler_get_rf_sector_params__check_inputs_valid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_get_rf_sector_params__set
wmi_handler_get_rf_sector_params__set:
	.global L_8e5e00
L_8e5e00:
	push_s blink
L_8e5e02:
	bl L_8c01dc
L_8e5e06:
	sub_s sp,sp,0x4
L_8e5e08:
	mov_s r14,r2
L_8e5e0a:
	ld_s r2,[r0,0x8]
L_8e5e0c:
	mov_s r16,r1
L_8e5e0e:
	mov_s r15,r0
L_8e5e10:
	mov_s r13,0x0
L_8e5e12:
	breq_s r2,0,L_8e5e24
L_8e5e14:
	mov_s r1,0x1007f08
L_8e5e1a:
	bl.d L_8dcc10
L_8e5e1e:
	mov_s r0,0x25
L_8e5e20:
	mov_s r13,0x2
L_8e5e22:
	b_s L_8e5e4a
	.global L_8e5e24
L_8e5e24:
	bl.d L_8c6040
L_8e5e28:
	mov_s r2,r14
L_8e5e2a:
	breq_s r0,0,L_8e5e3c
L_8e5e2c:
	mov_s r0,r15
L_8e5e2e:
	mov_s r1,r16
L_8e5e30:
	bl.d L_8c0380
L_8e5e34:
	mov_s r2,0x4
L_8e5e36:
	st_s r13,[r15,0x8]
L_8e5e38:
	st_s r14,[r15,0x4]
L_8e5e3a:
	b_s L_8e5e4a
	.global L_8e5e3c
L_8e5e3c:
	mov_s r1,0x1007f8c
L_8e5e42:
	bl.d L_8dcba8
L_8e5e46:
	mov_s r0,0x25
L_8e5e48:
	mov_s r13,0x1
	.global L_8e5e4a
L_8e5e4a:
	mov_s r0,0x1
L_8e5e4c:
	breq_s r13,0,L_8e5e7c
L_8e5e4e:
	bl.d L_8c33d0
L_8e5e52:
	mov_s r0,r14
L_8e5e54:
	mov_s r15,r0
L_8e5e56:
	bl.d L_8c1cd8
L_8e5e5a:
	mov_s r1,0xd0
L_8e5e5c:
	stb_s r13,[r15]
L_8e5e5e:
	mov_s r13,0x0
L_8e5e60:
	st_s r13,[sp,0x0]
L_8e5e62:
	mov_s r0,r14
L_8e5e64:
	mov_s r1,r15
L_8e5e66:
	mov_s r2,r13
L_8e5e68:
	mov_s r3,0xcd
L_8e5e6a:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8e5e6c:
	mov r4,0xd0
L_8e5e70:
	mov_s r5,r13
L_8e5e72:
	mov_s r6,r13
L_8e5e74:
	bl.d L_8e4fc4
L_8e5e78:
	mov_s r7,r13
L_8e5e7a:
	mov_s r0,r13
	.global L_8e5e7c
L_8e5e7c:
	b.d L_8c0244
L_8e5e80:
	add_s sp,sp,0x4
L_8e5e82:
	nop_s
