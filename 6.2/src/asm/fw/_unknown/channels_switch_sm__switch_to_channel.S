/* channels_switch_sm__switch_to_channel @ 0x8c5e64, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Switching to channel %d
 * Зовут его: CALIB_MNGR__system_state_evt_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, chan_sw__set_active_channel, fw_log_emit1, hwm__apply_channel_config, hwm_analog_channel_switch__thunk_arg1_zero, power_mngr__check_mode
 * Глобалы (через gp): 0x800250, 0x800252
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__switch_to_channel
channels_switch_sm__switch_to_channel:
	.global L_8c5e64
L_8c5e64:
	push_s blink
L_8c5e66:
	bl.d L_8c01e4
L_8c5e6a:
	mov_s r1,0x0
L_8c5e6c:
	mov_s r13,r0
L_8c5e6e:
	ld_s r0,[gp,-0xc8]
L_8c5e70:
	brne r13,r0,L_8c5e8e
L_8c5e74:
	ldb_s r0,[gp,0xcc]
L_8c5e76:
	breq_s r0,0,L_8c5e8e
L_8c5e78:
	ld_s r0,[gp,-0x14]
L_8c5e7a:
	cmp_s r0,0x3
L_8c5e7c:
	cmp.ne r0,0x4
L_8c5e80:
	mov.ne r0,r1
L_8c5e84:
	bne_s L_8c5ed0
L_8c5e86:
	ldb_s r0,[gp,0xce]
L_8c5e88:
	cmp_s r0,0x0
L_8c5e8a:
	mov_s r0,0x0
L_8c5e8c:
	bne_s L_8c5ed0
	.global L_8c5e8e
L_8c5e8e:
	mov_s r1,0x1009384
L_8c5e94:
	mov_s r0,0x26
L_8c5e96:
	bl.d L_8dcc10
L_8c5e9a:
	mov_s r2,r13
L_8c5e9c:
	mov_s r14,0x1
L_8c5e9e:
	stb r14,[gp, 0xcc]
L_8c5ea2:
	st.as r13,[gp,-0x32]
L_8c5ea6:
	bl.d L_8e639c
L_8c5eaa:
	mov_s r0,r13
L_8c5eac:
	bl.d L_8d73ec
L_8c5eb0:
	mov_s r0,r13
L_8c5eb2:
	bl.d L_8d7b2c
L_8c5eb6:
	mov_s r0,r14
L_8c5eb8:
	ldb_s r0,[gp,0xce]
L_8c5eba:
	breq r0,0x1,L_8c5ec8
L_8c5ebe:
	ld_s r0,[gp,-0x14]
L_8c5ec0:
	cmp_s r0,0x3
L_8c5ec2:
	cmp.ne r0,0x4
L_8c5ec6:
	bne_s L_8c5ece
	.global L_8c5ec8
L_8c5ec8:
	bl.d L_8e24e0
L_8c5ecc:
	mov_s r0,0x0
	.global L_8c5ece
L_8c5ece:
	mov_s r0,0x1
	.global L_8c5ed0
L_8c5ed0:
	b L_8c0254
