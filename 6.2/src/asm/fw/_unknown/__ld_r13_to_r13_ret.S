/* __ld_r13_to_r13_ret @ 0x8c025c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__update_pcp_ap, PS_ASSOC_SM__ps_schd_reenter_extend, PS_CONNECTION__psc_complete_8e1794, RADIO_MGR__remove_request, RADIO_MGR__unset_primary_channel, SDP__hwd_sdp_is_gpio_sdp, SDP__hwd_sdp_is_int_ctrl_sdp, TEMPERATURE_SERVICE__timer_exp_handler, TX_API__flush_pending_peer_pm_connection, alloc_dband_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __ld_r13_to_r13_ret
__ld_r13_to_r13_ret:
	.global L_8c025c
L_8c025c:
	mov_s r12,0x4
	.global L_8c025e
L_8c025e:
	mov_s r13,0x4
L_8c0260:
	b_s L_8c0298
L_8c0262:
	nop_s
L_8c0264:
	mov_s r12,0x4
L_8c0266:
	b_s L_8c029c
	.global L_8c0268
L_8c0268:
	ld gp,[sp, 0x34]
	.global L_8c026c
L_8c026c:
	ld r25,[sp, 0x30]
	.global L_8c0270
L_8c0270:
	ld r24,[sp, 0x2c]
	.global L_8c0274
L_8c0274:
	ld r23,[sp, 0x28]
	.global L_8c0278
L_8c0278:
	ld r22,[sp, 0x24]
	.global L_8c027c
L_8c027c:
	ld r21,[sp, 0x20]
	.global L_8c0280
L_8c0280:
	ld r20,[sp, 0x1c]
	.global L_8c0284
L_8c0284:
	ld r19,[sp, 0x18]
	.global L_8c0288
L_8c0288:
	ld r18,[sp, 0x14]
	.global L_8c028c
L_8c028c:
	ld r17,[sp, 0x10]
	.global L_8c0290
L_8c0290:
	ld r16,[sp, 0xc]
	.global L_8c0294
L_8c0294:
	ld_s r15,[sp,0x8]
	.global L_8c0296
L_8c0296:
	ld_s r14,[sp,0x4]
	.global L_8c0298
L_8c0298:
	ld.ab r13,[sp,r13]
	.global L_8c029c
L_8c029c:
	ld.ab blink,[sp,r12]
L_8c02a0:
	j_s [blink]
L_8c02a2:
	nop_s
