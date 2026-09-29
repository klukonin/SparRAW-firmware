/* uc_read_tsf_lo @ 0x9315e8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt, bf_metrics__reset_and_stamp, bf_sm__check_request_timeout, bf_sm__check_sta_timeout, bi__remaining_time_us, bi_window_transition_prep, bti__bi2_event_step, bti_worker__bti_transmitter_beacon_sweep_flow, grant_detect_step, l1_bi_trigger_step
 */
	.section .text.uc_read_tsf_lo,"ax",@progbits
	.global uc_read_tsf_lo
uc_read_tsf_lo:
	.global L_9315e8
L_9315e8:
	push_s r13
L_9315ea:
	mov_s r13,blink
L_9315ec:
	mov_s r0,0x4d000005
L_9315f2:
	mov_s r32,r0
L_9315f4:
	st.ab r0,[r25,0x4]
L_9315f8:
	bclr r25,r25,0xa
L_9315fc:
	nop_s
L_9315fe:
	nop_s
L_931600:
	nop_s
L_931602:
	mov_s r0,r55
L_931604:
	mov_s blink,r13
L_931606:
	j_s.d [blink]
L_931608:
	pop_s r13
L_93160a:
	nop_s
