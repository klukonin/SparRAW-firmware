/* u_schd__cancel @ 0x8c8de0, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_ASSOC_SM__ps_cancel_schd_reenter, WBE_DRIVER__link_down_notif, ba_setup_sm__addba_resp, ba_setup_sm__close_addba_req_retry_timeout_event, ba_setup_sm__close_addba_resp_timeout, ba_setup_sm__close_ba_setup_global_timeout, calib_engine__cancel_timer, calib_engine__on_abort, channel_est__clamp_64, channels_switch__check_g800104
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal, mem_pool__free_locked, tx_list__remove, u_schd__arm_timer
 * Глобалы (через gp): 0x80025c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__cancel
u_schd__cancel:
	.global L_8c8de0
L_8c8de0:
	push_s blink
L_8c8de2:
	bl L_8c01d4
L_8c8de6:
	mov.f r13,r0
L_8c8dea:
	beq_s L_8c8e5c
	.global L_8c8dec
L_8c8dec:
	ldb_s r0,[r13,0x19]
L_8c8dee:
	breq r0,0x0,L_8c8e68
	.global L_8c8df2
L_8c8df2:
	mov_s r1,0x0
L_8c8df4:
	lr r17,[0xa]
L_8c8df8:
	bclr r0,r17,0x1
L_8c8dfc:
	flag r0
L_8c8e00:
	mov_s r14,0x0
L_8c8e02:
	b_s L_8c8e36
	.global L_8c8e04
L_8c8e04:
	ld_s r2,[r13,0x4]
L_8c8e06:
	mov_s r15,0x803c54
L_8c8e0c:
	add2_s r15,r15,r14
L_8c8e0e:
	ld_s r0,[r15]
L_8c8e10:
	brne r2,r0,L_8c8e34
L_8c8e14:
	ld r16,[r0, 0x4]
L_8c8e18:
	bl.d L_8e2884
L_8c8e1c:
	mov_s r1,r13
L_8c8e1e:
	ld_s r0,[r15]
L_8c8e20:
	ld_s r1,[r0,0x4]
L_8c8e22:
	ldb_s r0,[gp,0xd8]
L_8c8e24:
	mov r18,0x1
L_8c8e28:
	brne r14,r0,L_8c8e32
L_8c8e2c:
	cmp_s r1,r16
L_8c8e2e:
	bl.ne L_8e249c
	.global L_8c8e32
L_8c8e32:
	mov_s r1,r18
	.global L_8c8e34
L_8c8e34:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8c8e36
L_8c8e36:
	brlt r14,0x2,L_8c8e04
L_8c8e3a:
	brne_s r1,0,L_8c8e44
L_8c8e3c:
	ld_s r0,[r13,0x4]
L_8c8e3e:
	bl.d L_8e2884
L_8c8e42:
	mov_s r1,r13
	.global L_8c8e44
L_8c8e44:
	lr r1,[0xa]
L_8c8e48:
	and r0,r17,0x2
L_8c8e4c:
	or_s r0,r0,r1
L_8c8e4e:
	flag r0
L_8c8e52:
	bl.d L_8cb028
L_8c8e56:
	mov_s r0,r13
L_8c8e58:
	b L_8c0234
	.global L_8c8e5c
L_8c8e5c:
	mov_s r0,blink
L_8c8e5e:
	mov_s r1,0x69
L_8c8e60:
	bl.d L_8c9b28
L_8c8e64:
	bset_s r1,r1,0xc
L_8c8e66:
	b_s L_8c8dec
	.global L_8c8e68
L_8c8e68:
	mov_s r0,blink
L_8c8e6a:
	mov_s r1,0x6a
L_8c8e6c:
	bl.d L_8c9b28
L_8c8e70:
	bset_s r1,r1,0xc
L_8c8e72:
	b_s L_8c8df2
