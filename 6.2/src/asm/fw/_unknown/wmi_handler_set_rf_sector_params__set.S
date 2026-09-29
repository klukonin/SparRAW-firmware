/* wmi_handler_set_rf_sector_params__set @ 0x8e5e84, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_set_rf_sector_params::set: Cannot execute command since radio is still locked by previous request. m_radio_handle=0x%X
 *   wmi_handler_set_rf_sector_params::set: Cannot execute command due to BAD_PARAMETERS_ERROR
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, fw_log_emit1, mem_pool__alloc_locked, memcpy_fw, memset0_words, wmi_evt__post, wmi_handler_set_rf_sector_params__verify_inputs
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_set_rf_sector_params__set
wmi_handler_set_rf_sector_params__set:
	.global L_8e5e84
L_8e5e84:
	push_s blink
L_8e5e86:
	bl L_8c01d8
L_8e5e8a:
	sub_s sp,sp,0x4
L_8e5e8c:
	mov_s r14,r2
L_8e5e8e:
	add3 r15,r0,0x10
L_8e5e92:
	ld_s r2,[r15,0x48]
L_8e5e94:
	mov_s r17,r1
L_8e5e96:
	mov_s r16,r0
L_8e5e98:
	mov_s r13,0x0
L_8e5e9a:
	breq_s r2,0,L_8e5eac
L_8e5e9c:
	mov_s r1,0x1008354
L_8e5ea2:
	bl.d L_8dcc10
L_8e5ea6:
	mov_s r0,0x25
L_8e5ea8:
	mov_s r13,0x2
L_8e5eaa:
	b_s L_8e5ed2
	.global L_8e5eac
L_8e5eac:
	bl.d L_8c60d0
L_8e5eb0:
	mov_s r2,r14
L_8e5eb2:
	breq_s r0,0,L_8e5ec4
L_8e5eb4:
	mov_s r0,r16
L_8e5eb6:
	mov_s r1,r17
L_8e5eb8:
	bl.d L_8c0380
L_8e5ebc:
	mov_s r2,0xc4
L_8e5ebe:
	st_s r13,[r15,0x48]
L_8e5ec0:
	st_s r14,[r15,0x44]
L_8e5ec2:
	b_s L_8e5ed2
	.global L_8e5ec4
L_8e5ec4:
	mov_s r1,0x10083d8
L_8e5eca:
	bl.d L_8dcba8
L_8e5ece:
	mov_s r0,0x25
L_8e5ed0:
	mov_s r13,0x1
	.global L_8e5ed2
L_8e5ed2:
	mov_s r0,0x1
L_8e5ed4:
	breq_s r13,0,L_8e5f06
L_8e5ed6:
	bl.d L_8c33d0
L_8e5eda:
	mov_s r0,r14
L_8e5edc:
	mov_s r15,r0
L_8e5ede:
	bl.d L_8c1cd8
L_8e5ee2:
	mov_s r1,0x1
L_8e5ee4:
	stb_s r13,[r15]
L_8e5ee6:
	mov_s r13,0x0
L_8e5ee8:
	st_s r13,[sp,0x0]
L_8e5eea:
	mov_s r0,r14
L_8e5eec:
	mov_s r1,r15
L_8e5eee:
	mov_s r2,r13
L_8e5ef0:
	mov_s r3,0x19a1
L_8e5ef6:
	mov r4,0x1
L_8e5efa:
	mov_s r5,r13
L_8e5efc:
	mov_s r6,r13
L_8e5efe:
	bl.d L_8e4fc4
L_8e5f02:
	mov_s r7,r13
L_8e5f04:
	mov_s r0,r13
	.global L_8e5f06
L_8e5f06:
	b.d L_8c023c
L_8e5f0a:
	add_s sp,sp,0x4
