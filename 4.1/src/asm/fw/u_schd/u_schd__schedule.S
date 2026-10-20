/* u_schd__schedule @ 0x8dc92c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   u_schd.cpp
 * Зовут его: PS_ASSOC_SM__ps_schd_reenter_extend, WMI_ADD_CIPHER_KEY_CMD, assoc_ready_check_trig, ba_setup_sm__addba_req_sent, ba_setup_sm__arm_timer, ba_setup_sm__on_ready_to_run, calib_engine_sm__check_correction_needed, calib_mngr__schedule_scheme_step, channels_switch_sm__action_allocate_radio, channels_switch_sm__action_start_dwelling
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_read_timer, fw_sysassert_fatal, u_schd__insert
 */
	.section .text.u_schd__schedule,"ax",@progbits
	.global u_schd__schedule
u_schd__schedule:
	.global L_8dc92c
L_8dc92c:
	push_s blink
L_8dc92e:
	bl L_8c02a8
L_8dc932:
	mov_s r21,r0
L_8dc934:
	mov_s r20,r1
L_8dc936:
	mov_s r19,r2
L_8dc938:
	mov_s r18,r3
L_8dc93a:
	mov_s r13,r4
L_8dc93c:
	mov r16,r5
L_8dc940:
	brlo.d r13,0x11,L_8dc988
L_8dc944:
	mov r17,r6
	.global L_8dc948
L_8dc948:
	lr r14,[0xa]
L_8dc94c:
	bclr r0,r14,0x1
L_8dc950:
	flag r0
L_8dc954:
	bl.d L_8e4694
L_8dc958:
	lsr_s r13,r13,0x4
L_8dc95a:
	add r5,r13,r0
L_8dc95e:
	mov_s r0,0x1
L_8dc960:
	mov_s r1,r21
L_8dc962:
	mov_s r2,r20
L_8dc964:
	mov_s r3,r19
L_8dc966:
	mov r4,r18
L_8dc96a:
	mov r6,r16
L_8dc96e:
	bl.d L_8dc99c
L_8dc972:
	mov r7,r17
L_8dc976:
	lr r1,[0xa]
L_8dc97a:
	bic r14,r14,-0x3
L_8dc97e:
	or_s r14,r14,r1
L_8dc980:
	flag r14
L_8dc984:
	b L_8c02fc
	.global L_8dc988
L_8dc988:
	mov_s r0,blink
L_8dc98a:
	mov_s r2,0x1001708
L_8dc990:
	mov_s r1,0x68
L_8dc992:
	bset_s r1,r1,0xc
L_8dc994:
	bl.d L_8c82c0
L_8dc998:
	mov_s r3,0xfc
L_8dc99a:
	b_s L_8dc948
