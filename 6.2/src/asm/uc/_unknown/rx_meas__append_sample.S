/* rx_meas__append_sample @ 0x928854, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__bi2_event_step, bti_bi2__track_best_metric, rx_flow__handle_frame, rx_flow_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_meas__append_sample
rx_meas__append_sample:
	.global L_928854
L_928854:
	push_s blink
L_928856:
	bl L_920234
L_92885a:
	mov_s r13,r0
L_92885c:
	breq_s r1,0,L_928862
L_92885e:
	ld_s r1,[r1]
L_928860:
	b_s L_9288a6
	.global L_928862
L_928862:
	ld_s r0,[gp,-0x44]
L_928864:
	and r0,r0,0xffff0fff
L_92886c:
	bset r1,r0,0xc
L_928870:
	bset_s r1,r1,0xe
L_928872:
	bset_s r1,r1,0xf
L_928874:
	or r0,r0,0x1d00d000
L_92887c:
	st.as r1,[gp,-0x11]
L_928880:
	mov_s r32,r0
L_928882:
	st.ab r0,[r25,0x4]
L_928886:
	bclr r25,r25,0xa
L_92888a:
	nop_s
L_92888c:
	nop_s
L_92888e:
	nop_s
L_928890:
	lsr r0,r40,0x9
L_928894:
	bmsk_s r0,r0,0xa
L_928896:
	sub r1,r0,0x800
L_92889e:
	cmp r0,0x3ff
L_9288a2:
	mov.ls r1,r0
	.global L_9288a6
L_9288a6:
	ld_s r0,[r13,0x58]
L_9288a8:
	add2 r2,r13,r0
L_9288ac:
	st_s r1,[r2,0x5c]
L_9288ae:
	mov_s r1,0x883000
L_9288b4:
	ld_s r1,[r1,0x6c]
L_9288b6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9288b8:
	bmsk_s r1,r1,0x5
L_9288ba:
	st r1,[r2, 0xac]
L_9288be:
	ld r1,[r13, 0xfc]
L_9288c2:
	st_s r0,[r13,0x58]
L_9288c4:
	brne r0,r1,L_928936
L_9288c8:
	ld_s r0,[gp,-0x44]
L_9288ca:
	add r14,r13,0x18
L_9288ce:
	and r0,r0,0xffff0fff
L_9288d6:
	bset r1,r0,0xc
L_9288da:
	bset_s r1,r1,0xe
L_9288dc:
	st.as r1,[gp,-0x11]
L_9288e0:
	or r0,r0,0x1d005000
L_9288e8:
	mov_s r32,r0
L_9288ea:
	st.ab r0,[r25,0x4]
L_9288ee:
	bclr r25,r25,0xa
L_9288f2:
	nop_s
L_9288f4:
	nop_s
L_9288f6:
	nop_s
L_9288f8:
	st r40,[r14]
L_9288fc:
	ld_s r0,[gp,-0x44]
L_9288fe:
	and r0,r0,0xffff0fff
L_928906:
	bset r1,r0,0xd
L_92890a:
	bset_s r1,r1,0xe
L_92890c:
	or r0,r0,0x1d006000
L_928914:
	st.as r1,[gp,-0x11]
L_928918:
	mov_s r32,r0
L_92891a:
	st.ab r0,[r25,0x4]
L_92891e:
	bclr r25,r25,0xa
L_928922:
	nop_s
L_928924:
	nop_s
L_928926:
	nop_s
L_928928:
	st r40,[r14, 0x4]
L_92892c:
	mov_s r0,0x1
L_92892e:
	st_s r0,[r13,0xc]
L_928930:
	bl.d L_9216f8
L_928934:
	mov_s r0,0x0
	.global L_928936
L_928936:
	b L_9202a4
L_92893a:
	nop_s
