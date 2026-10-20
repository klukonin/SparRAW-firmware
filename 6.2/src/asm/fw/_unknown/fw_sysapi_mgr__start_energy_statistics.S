/* fw_sysapi_mgr__start_energy_statistics @ 0x8f2cc0, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   energy_statistics_cmd_start: Enter, samples_num = %d
 *   fw_sysapi_mgr::start_energy_statistics: Rejecting sysapi request since previous command is still not completed (prev request_type=%d, new request type=%d)
 *   fw_sysapi_mgr::start_energy_statistics: Requested samples_num=%d exceeds allowed maximum=%d. Executing request with max
 * Зовут его: hw_sysapi_get_rx_packet_energy_statistics
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r17_to_r13_ret, __st_r17_to_r13, channel_est__clamp_64, channel_est__stack_args, field_set_0x00__8dbe88, fw_log_emit1, fw_log_emit2, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__start_sysapi_cmd, fw_sysassert_fatal, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__start_energy_statistics
fw_sysapi_mgr__start_energy_statistics:
	.global L_8f2cc0
L_8f2cc0:
	push_s blink
L_8f2cc2:
	bl L_8c01d8
L_8f2cc6:
	sub_s sp,sp,0x2c
L_8f2cc8:
	mov_s r14,r0
L_8f2cca:
	mov_s r17,r1
L_8f2ccc:
	mov_s r13,r2
L_8f2cce:
	mov_s r16,r3
L_8f2cd0:
	mov_s r15,r4
L_8f2cd2:
	mov_s r1,0x101250c
L_8f2cd8:
	bl.d L_8dcc10
L_8f2cdc:
	mov_s r0,0x20
L_8f2cde:
	mov_s r0,r14
L_8f2ce0:
	mov_s r1,r17
L_8f2ce2:
	bl.d L_8f7490
L_8f2ce6:
	mov_s r2,r16
L_8f2ce8:
	mov_s r0,r14
L_8f2cea:
	mov_s r1,0x1
L_8f2cec:
	bl.d L_8f9a20
L_8f2cf0:
	mov_s r2,r15
L_8f2cf2:
	brne_s r0,0,L_8f2d1e
L_8f2cf4:
	mov_s r0,sp
L_8f2cf6:
	bl.d L_8c1cd8
L_8f2cfa:
	mov_s r1,0x2c
L_8f2cfc:
	ld_s r2,[r14]
L_8f2cfe:
	mov_s r1,0x1012544
L_8f2d04:
	mov_s r0,0x20
L_8f2d06:
	bl.d L_8dcc80
L_8f2d0a:
	mov_s r3,0x1
L_8f2d0c:
	ld_s r1,[r14,0x20]
L_8f2d0e:
	mov_s r2,sp
L_8f2d10:
	add r4,r14,0x4
L_8f2d14:
	mov_s r0,r14
L_8f2d16:
	bl.d L_8f8948
L_8f2d1a:
	mov_s r3,0x2c
L_8f2d1c:
	b_s L_8f2d7a
	.global L_8f2d1e
L_8f2d1e:
	st_s r13,[r14,0x38]
L_8f2d20:
	add r0,r14,0x3c
L_8f2d24:
	bl.d L_8c1cd8
L_8f2d28:
	mov_s r1,0x2c
L_8f2d2a:
	mov_s r0,0x857280
L_8f2d30:
	mov_s r1,0x0
L_8f2d32:
	st_s r1,[r0,0x20]
L_8f2d34:
	ld_s r0,[r14,0x38]
L_8f2d36:
	brlo r0,0x15,L_8f2d4e
L_8f2d3a:
	mov_s r1,0x10125e0
L_8f2d40:
	mov_s r0,0x20
L_8f2d42:
	mov_s r2,r13
L_8f2d44:
	mov_s r15,0x14
L_8f2d46:
	bl.d L_8dcc80
L_8f2d4a:
	mov_s r3,r15
L_8f2d4c:
	st_s r15,[r14,0x38]
	.global L_8f2d4e
L_8f2d4e:
	mov_s r0,0x32d80
L_8f2d54:
	st_s r0,[r14,0x34]
L_8f2d56:
	mov_s r2,0x32d88
L_8f2d5c:
	mov_s r0,r14
L_8f2d5e:
	bl.d L_8f9070
L_8f2d62:
	mov_s r1,r16
L_8f2d64:
	mov_s r0,sp
L_8f2d66:
	mov_s r1,r17
L_8f2d68:
	bl.d L_8c0380
L_8f2d6c:
	mov_s r2,0x8
L_8f2d6e:
	ld_s r1,[sp,0x0]
L_8f2d70:
	mov_s r0,0x28
L_8f2d72:
	ld_s r2,[sp,0x4]
L_8f2d74:
	bl.d L_8dbe54
L_8f2d78:
	mov_s r3,r13
	.global L_8f2d7a
L_8f2d7a:
	b.d L_8c023c
L_8f2d7e:
	add_s sp,sp,0x2c
L_8f2d80:
	b.d L_8f2c08
L_8f2d84:
	st_s r1,[r0,0x20]
L_8f2d86:
	nop_s
L_8f2d88:
	push_s blink
L_8f2d8a:
	push_s r13
L_8f2d8c:
	mov.f r13,r0
L_8f2d90:
	beq_s L_8f2db8
	.global L_8f2d92
L_8f2d92:
	ld_s r1,[r13]
L_8f2d94:
	mov_s r0,0x0
L_8f2d96:
	st_s r0,[r13,0x10]
L_8f2d98:
	brne r1,0x1,L_8f2da4
L_8f2d9c:
	ld_s r1,[r13,0x20]
L_8f2d9e:
	cmp_s r1,0x2
L_8f2da0:
	mov.eq r0,0x1
	.global L_8f2da4
L_8f2da4:
	extb.f 0x0,r0
L_8f2da8:
	mov.ne r0,0x29
L_8f2dac:
	bl.ne.d L_8dbe88
L_8f2db0:
	mov.ne r1,0x3
L_8f2db4:
	b L_8c025c
	.global L_8f2db8
L_8f2db8:
	mov_s r0,blink
L_8f2dba:
	mov_s r1,0x1451
L_8f2dc0:
	bl L_8c9b28
L_8f2dc4:
	b_s L_8f2d92
L_8f2dc6:
	nop_s
