/* uc_wait_event_busy @ 0x931808, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder_substep, bti__bi2_event_step, bti_worker__bti_transmitter_beacon_sweep_flow, bti_worker_bi2_step, mac__prepare_txrx_window, mac__select_all_sectors_and_wait, mac_mode__wait_ppdu_and_kick, mac_mode__wait_ppdu_and_kick_b, mac_mode__wait_ppdu_and_kick_c, mac_mode__wait_ppdu_and_kick_d
 */
	.section .text.uc_wait_event_busy,"ax",@progbits
	.global uc_wait_event_busy
uc_wait_event_busy:
	.global L_931808
L_931808:
	st.a r13,[sp,-0x8]
L_93180c:
	st_s r14,[sp,0x4]
L_93180e:
	mov_s r14,blink
L_931810:
	tst r42,r0
L_931814:
	mov r13,r0
L_931818:
	bne.d L_931870
L_93181c:
	mov.ne r0,0x1
L_931820:
	cmp r1,0x0
L_931824:
	beq.d L_93185c
L_931828:
	mov.eq r2,r13
L_93182c:
	or r1,r1,0x23010000
L_931834:
	mov r32,r1
L_931838:
	st.ab r1,[r25,0x4]
L_93183c:
	bclr r25,r25,0xa
L_931840:
	mov_s r3,0x2000200
L_931846:
	mov_s r32,r3
L_931848:
	st.ab r3,[r25,0x4]
L_93184c:
	bclr r25,r25,0xa
L_931850:
	bset r2,r13,0x9
L_931854:
	nop_s
L_931856:
	nop_s
L_931858:
	mov 0x0,0x0
	.global L_93185c
L_93185c:
	tst r42,r2
L_931860:
	beq L_93185c
L_931864:
	and r2,r42,r13
L_931868:
	sub.f r0,r2,0x0
L_93186c:
	mov.ne r0,0x1
	.global L_931870
L_931870:
	mov_s blink,r14
L_931872:
	ld_s r14,[sp,0x4]
L_931874:
	j.d [blink]
L_931878:
	ld.ab r13,[sp,0x8]
