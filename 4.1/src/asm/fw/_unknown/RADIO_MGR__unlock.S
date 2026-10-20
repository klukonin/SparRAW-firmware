/* RADIO_MGR__unlock @ 0x8e54d8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RADIO_MGR::unlock. Handle:0x%x
 * Зовут его: TEMPERATURE_SERVICE__radio_locked_cb, calib_engine_sm__check_correction_needed, channels_switch_sm__action_scan_complete, find_main_sm__stop, l2_mgr__channel_locked_cb, l2_mgr__high_false_alarm_secondary_lock_cb, maintain_sm__fbf_failed, maintain_sm__release_radio_after_bf_evt, mlme_sm__assoc_reject_ev_handle, mlme_sm__association_timeout_ev_handle
 * Зовёт сам: __ld_r13_ret, fw_log__emit1
 */
	.section .text.RADIO_MGR__unlock,"ax",@progbits
	.global RADIO_MGR__unlock
RADIO_MGR__unlock:
	.global L_8e54d8
L_8e54d8:
	push_s blink
L_8e54da:
	push_s r13
L_8e54dc:
	mov_s r13,r0
L_8e54de:
	mov_s r2,0x1015c38
L_8e54e4:
	mov_s r0,0x8
L_8e54e6:
	mov_s r1,0x2
L_8e54e8:
	bl.d L_8edfcc
L_8e54ec:
	mov_s r3,r13
L_8e54ee:
	ld_s r0,[gp,-0x30]
L_8e54f0:
	ld_s r1,[r0]
L_8e54f2:
	ld_s r2,[r1,0x10]
L_8e54f4:
	jl_s.d [r2]
L_8e54f6:
	mov_s r1,r13
L_8e54f8:
	b L_8c033c
