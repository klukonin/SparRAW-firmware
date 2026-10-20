/* macq_desc__read_uc @ 0x9245b0, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_bcast_flow
 * Зовёт сам: qh__reset_desc_window, qh__wait_desc_window_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_desc__read_uc
macq_desc__read_uc:
	.global L_9245b0
L_9245b0:
	st.a r13,[sp,-0x8]
L_9245b4:
	st_s r14,[sp,0x4]
L_9245b6:
	sub_s sp,sp,0x8
L_9245b8:
	mov_s r5,r0
L_9245ba:
	ld_s r0,[sp,0x4]
L_9245bc:
	mov r14,blink
L_9245c0:
	bic r0,r0,0x3
L_9245c4:
	ror r0,r0,0x4
L_9245c8:
	bic r0,r0,0x7
L_9245cc:
	or r0,r0,0x6
L_9245d0:
	ror r0,r0,0x1c
L_9245d4:
	bl.d L_924480
L_9245d8:
	st r0,[sp, 0x4]
L_9245dc:
	ldw r1,[sp, 0x4]
L_9245e0:
	mov_s r13,0x886800
L_9245e6:
	asl_s r1,r1,0x10
L_9245e8:
	st.as r1,[r13,-0x7d]
L_9245ec:
	st.as r5,[r13,-0x7c]
L_9245f0:
	ldb r2,[gp, -0xde]
L_9245f4:
	brne_s r2,0,L_924600
L_9245f6:
	st.as 0xc0000000,[r13,-0x7e]
L_9245fe:
	b_s L_924608
	.global L_924600
L_924600:
	st.as 0x40000000,[r13,-0x7e]
	.global L_924608
L_924608:
	sync
	.global L_92460c
L_92460c:
	ld.as r3,[r13,-0x7e]
L_924610:
	bbit1 r3,0x1d,L_92460c
L_924614:
	ld.as r4,[r13,-0x7a]
L_924618:
	bl L_9246b0
L_92461c:
	mov_s r0,r4
L_92461e:
	mov_s blink,r14
L_924620:
	add_s sp,sp,0x8
L_924622:
	ld_s r14,[sp,0x4]
L_924624:
	j.d [blink]
L_924628:
	ld.ab r13,[sp,0x8]
