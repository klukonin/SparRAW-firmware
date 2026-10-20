/* rx__switch_to_rx_mode @ 0x9248e8, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_flow_step, rx_funcs__handle_ppdu_report
 * Зовёт сам: hw_modes_mac__switch_core
 * Глобалы (через gp): 0x800528
 */
	.section .text.rx__switch_to_rx_mode,"ax",@progbits
	.global rx__switch_to_rx_mode
rx__switch_to_rx_mode:
	.global L_9248e8
L_9248e8:
	push_s r13
L_9248ea:
	mov_s r13,blink
L_9248ec:
	bl L_927944
L_9248f0:
	mov_s r2,0x4d
L_9248f2:
	asl_s r2,r2,0x18
L_9248f4:
	mov r32,r2
L_9248f8:
	st.ab r2,[r25,0x4]
L_9248fc:
	bclr r25,r25,0xa
L_924900:
	nop_s
L_924902:
	nop_s
L_924904:
	nop_s
L_924906:
	mov_s r1,r55
L_924908:
	cmp r1,0x500
L_92490c:
	st r1,[0x8014e8]
L_924914:
	bhi_s L_924918
L_924916:
	brne_s r1,0,L_924930
	.global L_924918
L_924918:
	mov_s r3,0x1f000601
L_92491e:
	mov_s r32,r3
L_924920:
	st.ab r3,[r25,0x4]
L_924924:
	bclr r25,r25,0xa
L_924928:
	ld_s r0,[gp,0x0]
L_92492a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92492c:
	st.as r0,[gp,0x0]
	.global L_924930
L_924930:
	mov_s blink,r13
L_924932:
	j_s.d [blink]
L_924934:
	pop_s r13
L_924936:
	nop_s
