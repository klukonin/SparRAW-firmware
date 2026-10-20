/* marlon_r_if_class__config_channel @ 0x8c6d00, 324 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::config_channel - NO RF on current platform!!!
 *   marlon_r_if_class::config_channel. Loading BRP sectors Failed
 *   marlon_r_if_class::config_channel. Loading RX Section for channel %d
 *   marlon_r_if_class::config_channel: Failed to load board file RX Section for channel %d
 *   marlon_r_if_class::config_channel. Loading TX Section for channel %d
 *   marlon_r_if_class::config_channel: Failed to load board file TX Section for channel %d
 *   marlon_r_if_class::config_channel(): m_current_channel_id was set to %d
 * Зовут его: deep_sleep_exit, hwf_rf_config, hwm_analog_channel_switch, rf__restore_if_needed
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, handle_omni_sector_info, marlon_r_if__read_step, marlon_r_if_class__load_brd_rf_cfg_section, memcpy_fw, rf__is_present, rf_power_off, rf_utils__fill_default_patterns
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global marlon_r_if_class__config_channel
marlon_r_if_class__config_channel:
	.global L_8c6d00
L_8c6d00:
	push_s blink
L_8c6d02:
	bl L_8c01d0
L_8c6d06:
	sub_s sp,sp,0x20
L_8c6d08:
	mov_s r14,r0
L_8c6d0a:
	mov_s r13,r1
L_8c6d0c:
	bl.d L_8da5d8
L_8c6d10:
	mov_s r19,r2
L_8c6d12:
	brne_s r0,0,L_8c6d22
L_8c6d14:
	mov_s r1,0x1005ea8
L_8c6d1a:
	bl.d L_8dcba8
L_8c6d1e:
	mov_s r0,0x10
L_8c6d20:
	b_s L_8c6e3a
	.global L_8c6d22
L_8c6d22:
	cmp_s r13,0x3
L_8c6d24:
	mov.hi r0,blink
L_8c6d28:
	mov.hi r1,0x119b
L_8c6d30:
	bl.hi L_8c9b28
L_8c6d34:
	bl.d L_8d9a54
L_8c6d38:
	mov_s r0,r14
L_8c6d3a:
	mov_s r0,r14
L_8c6d3c:
	bl.d L_8c6ccc
L_8c6d40:
	mov_s r1,r19
L_8c6d42:
	cmp r19,0x0
L_8c6d46:
	cmp.eq r0,0x0
L_8c6d4a:
	bne_s L_8c6d5e
L_8c6d4c:
	mov_s r1,0x1005eec
L_8c6d52:
	mov_s r13,0x0
L_8c6d54:
	bl.d L_8dcba8
L_8c6d58:
	mov_s r0,r13
L_8c6d5a:
	mov_s r0,r13
L_8c6d5c:
	b_s L_8c6e3c
	.global L_8c6d5e
L_8c6d5e:
	mov_s r1,0x1005f2c
L_8c6d64:
	add_s r15,r13,0x1
L_8c6d66:
	mov_s r0,0x20
L_8c6d68:
	bl.d L_8dcc10
L_8c6d6c:
	mov_s r2,r15
L_8c6d6e:
	asl_s r0,r13
L_8c6d70:
	add r16,r0,0x2
L_8c6d74:
	mov r17,sp
L_8c6d78:
	mov r18,0x801fa4
L_8c6d80:
	mov_s r0,r17
L_8c6d82:
	add3 r1,r18,0x14
L_8c6d86:
	bl.d L_8c0380
L_8c6d8a:
	mov_s r2,0x18
L_8c6d8c:
	ld r0,[r18, 0xbc]
L_8c6d90:
	st r17,[sp, 0x18]
L_8c6d94:
	st_s r0,[sp,0x1c]
L_8c6d96:
	add r17,sp,0x18
L_8c6d9a:
	mov_s r0,r14
L_8c6d9c:
	mov_s r1,r16
L_8c6d9e:
	mov_s r2,r17
L_8c6da0:
	mov_s r3,0x80
L_8c6da2:
	bl.d L_8dc830
L_8c6da6:
	mov r4,r19
L_8c6daa:
	brne_s r0,0,L_8c6dd2
L_8c6dac:
	bl.d L_8e2fa8
L_8c6db0:
	mov_s r0,r14
L_8c6db2:
	mov_s r1,0x1005f74
L_8c6db8:
	mov_s r0,0x0
L_8c6dba:
	bl.d L_8dcc10
L_8c6dbe:
	mov_s r2,r15
L_8c6dc0:
	brne r19,0x0,L_8c6dc8
	.global L_8c6dc4
L_8c6dc4:
	mov_s r0,0x0
L_8c6dc6:
	b_s L_8c6e3c
	.global L_8c6dc8
L_8c6dc8:
	mov_s r1,0x1191
L_8c6dce:
	mov_s r0,blink
L_8c6dd0:
	b_s L_8c6e20
	.global L_8c6dd2
L_8c6dd2:
	breq r17,0x0,L_8c6dde
L_8c6dd6:
	mov_s r0,r14
L_8c6dd8:
	bl.d L_8cd940
L_8c6ddc:
	ld_s r1,[sp,0x18]
	.global L_8c6dde
L_8c6dde:
	mov_s r1,0x1005fcc
L_8c6de4:
	mov_s r0,0x20
L_8c6de6:
	bl.d L_8dcc10
L_8c6dea:
	mov_s r2,r15
L_8c6dec:
	add r1,r16,0x1
L_8c6df0:
	mov_s r0,r14
L_8c6df2:
	mov_s r2,0x0
L_8c6df4:
	mov_s r3,0x80
L_8c6df6:
	bl.d L_8dc830
L_8c6dfa:
	mov r4,r19
L_8c6dfe:
	brne_s r0,0,L_8c6e26
L_8c6e00:
	bl.d L_8e2fa8
L_8c6e04:
	mov_s r0,r14
L_8c6e06:
	mov_s r1,0x1006014
L_8c6e0c:
	mov_s r0,0x0
L_8c6e0e:
	bl.d L_8dcc10
L_8c6e12:
	mov_s r2,r15
L_8c6e14:
	breq r19,0x0,L_8c6dc4
L_8c6e18:
	mov_s r0,blink
L_8c6e1a:
	mov_s r1,0x1192
	.global L_8c6e20
L_8c6e20:
	bl L_8c9b28
L_8c6e24:
	b_s L_8c6dc4
	.global L_8c6e26
L_8c6e26:
	add r14,r14,0x460
L_8c6e2a:
	st_s r13,[r14]
L_8c6e2c:
	mov_s r1,0x100606c
L_8c6e32:
	mov_s r0,0x20
L_8c6e34:
	bl.d L_8dcc10
L_8c6e38:
	mov_s r2,r13
	.global L_8c6e3a
L_8c6e3a:
	mov_s r0,0x1
	.global L_8c6e3c
L_8c6e3c:
	b.d L_8c022c
L_8c6e40:
	add_s sp,sp,0x20
L_8c6e42:
	nop_s
