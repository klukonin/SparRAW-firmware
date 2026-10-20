/* marlon_r_if_class__rf_configure_role_power @ 0x8e2e88, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rf_configure_role_power - NO RF on current platform!!!
 *   marlon_r_if_class::rf_configure_role_power: Failed to load board file COMMON_RF_SECTION
 *   marlon_r_if_class::rf_configure_role_power: temperature cmds are in brd file
 * Зовут его: deep_sleep_exit, fw_main, hwf_rf_config, rf__restore_if_needed
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, marlon_r_if_class__load_brd_rf_cfg_section, memcpy_fw, rf__is_present
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global marlon_r_if_class__rf_configure_role_power
marlon_r_if_class__rf_configure_role_power:
	.global L_8e2e88
L_8e2e88:
	push_s blink
L_8e2e8a:
	bl L_8c01e0
L_8e2e8e:
	sub_s sp,sp,0x40
L_8e2e90:
	bl.d L_8da5d8
L_8e2e94:
	mov_s r14,r0
L_8e2e96:
	brne_s r0,0,L_8e2ea8
L_8e2e98:
	mov_s r1,0x10057bc
L_8e2e9e:
	bl.d L_8dcba8
L_8e2ea2:
	mov_s r0,0x10
L_8e2ea4:
	mov_s r0,0x1
L_8e2ea6:
	b_s L_8e2f10
	.global L_8e2ea8
L_8e2ea8:
	mov_s r13,0x801fa4
L_8e2eae:
	ld_s r1,[r13,0x8]
L_8e2eb0:
	ld_s r0,[r13,0xc]
L_8e2eb2:
	st_s r1,[sp,0x0]
L_8e2eb4:
	st_s r0,[sp,0x4]
L_8e2eb6:
	add_s r15,sp,0x8
L_8e2eb8:
	mov_s r0,r15
L_8e2eba:
	add r1,r13,0x10
L_8e2ebe:
	bl.d L_8c0380
L_8e2ec2:
	mov_s r2,0x30
L_8e2ec4:
	mov_s r0,r14
L_8e2ec6:
	add r0,r0,0x474
L_8e2eca:
	st_s r0,[sp,0x10]
L_8e2ecc:
	mov_s r0,sp
L_8e2ece:
	st_s r0,[sp,0x28]
L_8e2ed0:
	ld_s r0,[r13,0x44]
L_8e2ed2:
	st_s r15,[sp,0x38]
L_8e2ed4:
	st_s r0,[sp,0x3c]
L_8e2ed6:
	add_s r2,sp,0x38
L_8e2ed8:
	mov_s r0,r14
L_8e2eda:
	mov_s r13,0x1
L_8e2edc:
	mov_s r1,r13
L_8e2ede:
	mov_s r3,0x80
L_8e2ee0:
	bl.d L_8dc830
L_8e2ee4:
	mov_s r4,r13
L_8e2ee6:
	brne_s r0,0,L_8e2ef8
L_8e2ee8:
	mov_s r1,0x10057f4
L_8e2eee:
	bl.d L_8dcba8
L_8e2ef2:
	mov_s r0,0x0
L_8e2ef4:
	mov_s r0,0x2
L_8e2ef6:
	b_s L_8e2f10
	.global L_8e2ef8
L_8e2ef8:
	ld_s r0,[sp,0x4]
L_8e2efa:
	breq_s r0,0,L_8e2f0e
L_8e2efc:
	mov_s r1,0x100584c
L_8e2f02:
	bl.d L_8dcba8
L_8e2f06:
	mov_s r0,0x20
L_8e2f08:
	add r14,r14,0x46c
L_8e2f0c:
	st_s r13,[r14]
	.global L_8e2f0e
L_8e2f0e:
	mov_s r0,0x0
	.global L_8e2f10
L_8e2f10:
	b.d L_8c024c
L_8e2f14:
	add_s sp,sp,0x40
L_8e2f16:
	nop_s
