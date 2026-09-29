/* rx_meas__finish_with_8830ec @ 0x92893c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__bi2_event_step, bti_bi2__track_best_metric, rx_flow__handle_frame, rx_flow_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_meas__finish_with_8830ec
rx_meas__finish_with_8830ec:
	.global L_92893c
L_92893c:
	push_s blink
L_92893e:
	bl L_920234
L_928942:
	mov_s r13,r0
L_928944:
	mov_s r0,0x883080
L_92894a:
	ld_s r0,[r0,0x6c]
L_92894c:
	add r14,r13,0x18
L_928950:
	st_s r0,[r13,0x54]
L_928952:
	ld_s r0,[gp,-0x44]
L_928954:
	and r0,r0,0xffff0fff
L_92895c:
	bset r1,r0,0xc
L_928960:
	bset_s r1,r1,0xe
L_928962:
	or r0,r0,0x1d005000
L_92896a:
	st.as r1,[gp,-0x11]
L_92896e:
	mov_s r32,r0
L_928970:
	st.ab r0,[r25,0x4]
L_928974:
	bclr r25,r25,0xa
L_928978:
	nop_s
L_92897a:
	nop_s
L_92897c:
	nop_s
L_92897e:
	st r40,[r14]
L_928982:
	ld_s r0,[gp,-0x44]
L_928984:
	and r0,r0,0xffff0fff
L_92898c:
	bset r1,r0,0xd
L_928990:
	bset_s r1,r1,0xe
L_928992:
	or r0,r0,0x1d006000
L_92899a:
	st.as r1,[gp,-0x11]
L_92899e:
	mov_s r32,r0
L_9289a0:
	st.ab r0,[r25,0x4]
L_9289a4:
	bclr r25,r25,0xa
L_9289a8:
	nop_s
L_9289aa:
	nop_s
L_9289ac:
	nop_s
L_9289ae:
	st r40,[r14, 0x4]
L_9289b2:
	mov_s r0,0x1
L_9289b4:
	st_s r0,[r13,0xc]
L_9289b6:
	bl.d L_9216f8
L_9289ba:
	mov_s r0,0x0
L_9289bc:
	b L_9202a4
