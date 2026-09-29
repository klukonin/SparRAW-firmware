/* u_schd__schedule @ 0x8e0c0c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_ASSOC_SM__ps_schd_reenter_extend, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, assoc_ready_check_trig, ba_setup_sm__action_8f99e4, ba_setup_sm__addba_req_retry_timeout_cb, ba_setup_sm__addba_req_sent, ba_setup_sm__addba_resp, calib_engine__on_frag_done, calib_mngr__schedule_scheme_step, channel_est__clamp_64
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_sysassert_fatal, u_schd__insert_timer, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__schedule
u_schd__schedule:
	.global L_8e0c0c
L_8e0c0c:
	push_s blink
L_8e0c0e:
	bl L_8c01c8
L_8e0c12:
	mov_s r21,r0
L_8e0c14:
	mov_s r20,r1
L_8e0c16:
	mov_s r19,r2
L_8e0c18:
	mov_s r18,r3
L_8e0c1a:
	mov_s r14,r4
L_8e0c1c:
	mov r16,r5
L_8e0c20:
	brlo.d r14,0x11,L_8e0c68
L_8e0c24:
	mov r17,r6
	.global L_8e0c28
L_8e0c28:
	lr r13,[0xa]
L_8e0c2c:
	bclr r0,r13,0x1
L_8e0c30:
	flag r0
L_8e0c34:
	bl.d L_8e9524
L_8e0c38:
	lsr_s r14,r14,0x4
L_8e0c3a:
	add r5,r14,r0
L_8e0c3e:
	mov_s r0,0x1
L_8e0c40:
	mov_s r1,r21
L_8e0c42:
	mov_s r2,r20
L_8e0c44:
	mov_s r3,r19
L_8e0c46:
	mov r4,r18
L_8e0c4a:
	mov r6,r16
L_8e0c4e:
	bl.d L_8e0c74
L_8e0c52:
	mov r7,r17
L_8e0c56:
	lr r1,[0xa]
L_8e0c5a:
	bic r13,r13,-0x3
L_8e0c5e:
	or_s r13,r13,r1
L_8e0c60:
	flag r13
L_8e0c64:
	b L_8c021c
	.global L_8e0c68
L_8e0c68:
	mov_s r0,blink
L_8e0c6a:
	mov_s r1,0x68
L_8e0c6c:
	bl.d L_8c9b28
L_8e0c70:
	bset_s r1,r1,0xc
L_8e0c72:
	b_s L_8e0c28
