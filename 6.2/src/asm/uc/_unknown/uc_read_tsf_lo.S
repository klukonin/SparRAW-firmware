/* uc_read_tsf_lo @ 0x9364c8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt, bf_metrics__reset_and_stamp, bi__after_enter_aw, bi__after_enter_dti, bi__bti_timer_step, bi__latch_tsf_and_reset, bi__remaining_time_us, bi_rx__slot_handler, brp_initiator_brp_transaction_flow, bti__bi2_event_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_read_tsf_lo
uc_read_tsf_lo:
	.global L_9364c8
L_9364c8:
	push_s r13
L_9364ca:
	mov_s r13,blink
L_9364cc:
	mov_s r0,0x4d000005
L_9364d2:
	mov_s r32,r0
L_9364d4:
	st.ab r0,[r25,0x4]
L_9364d8:
	bclr r25,r25,0xa
L_9364dc:
	nop_s
L_9364de:
	nop_s
L_9364e0:
	nop_s
L_9364e2:
	mov_s r0,r55
L_9364e4:
	mov_s blink,r13
L_9364e6:
	j_s.d [blink]
L_9364e8:
	pop_s r13
L_9364ea:
	nop_s
