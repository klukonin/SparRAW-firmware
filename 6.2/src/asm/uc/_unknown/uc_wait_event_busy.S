/* uc_wait_event_busy @ 0x9366e8, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_resp__parse_fdbk, bti__bi2_event_step, bti_worker__bti_transmitter_beacon_sweep_flow, bti_worker_bi2_step, mac__prepare_txrx_window, mac__select_all_sectors_and_wait, rx__arm_window, rx__arm_window_b, rx__arm_window_c, rx__ppdu_is_ack
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_wait_event_busy
uc_wait_event_busy:
	.global L_9366e8
L_9366e8:
	st.a r13,[sp,-0x8]
L_9366ec:
	st_s r14,[sp,0x4]
L_9366ee:
	mov_s r14,blink
L_9366f0:
	tst r42,r0
L_9366f4:
	mov r13,r0
L_9366f8:
	bne.d L_936750
L_9366fc:
	mov.ne r0,0x1
L_936700:
	cmp r1,0x0
L_936704:
	beq.d L_93673c
L_936708:
	mov.eq r2,r13
L_93670c:
	or r1,r1,0x23010000
L_936714:
	mov r32,r1
L_936718:
	st.ab r1,[r25,0x4]
L_93671c:
	bclr r25,r25,0xa
L_936720:
	mov_s r3,0x2000200
L_936726:
	mov_s r32,r3
L_936728:
	st.ab r3,[r25,0x4]
L_93672c:
	bclr r25,r25,0xa
L_936730:
	bset r2,r13,0x9
L_936734:
	nop_s
L_936736:
	nop_s
L_936738:
	mov 0x0,0x0
	.global L_93673c
L_93673c:
	tst r42,r2
L_936740:
	beq L_93673c
L_936744:
	and r2,r42,r13
L_936748:
	sub.f r0,r2,0x0
L_93674c:
	mov.ne r0,0x1
	.global L_936750
L_936750:
	mov_s blink,r14
L_936752:
	ld_s r14,[sp,0x4]
L_936754:
	j.d [blink]
L_936758:
	ld.ab r13,[sp,0x8]
