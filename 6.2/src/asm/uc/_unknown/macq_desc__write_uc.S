/* macq_desc__write_uc @ 0x92462c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_bcast_flow
 * Зовёт сам: qh__reset_desc_window, qh__wait_desc_window_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_desc__write_uc
macq_desc__write_uc:
	.global L_92462c
L_92462c:
	st.a r13,[sp,-0x8]
L_924630:
	st blink,[sp, 0x4]
L_924634:
	sub_s sp,sp,0x8
L_924636:
	mov_s r5,r0
L_924638:
	ld_s r0,[sp,0x4]
L_92463a:
	mov_s r4,r1
L_92463c:
	bic r0,r0,0x3
L_924640:
	bset r0,r0,0x0
L_924644:
	ror r0,r0,0x4
L_924648:
	bic r0,r0,0x7
L_92464c:
	or r0,r0,0x6
L_924650:
	ror r0,r0,0x1c
L_924654:
	bl.d L_924480
L_924658:
	st r0,[sp, 0x4]
L_92465c:
	ldw r1,[sp, 0x4]
L_924660:
	mov_s r13,0x886800
L_924666:
	asl_s r1,r1,0x10
L_924668:
	or r1,r1,0x80000008
L_924670:
	st.as r1,[r13,-0x7d]
L_924674:
	st.as r5,[r13,-0x7c]
L_924678:
	st.as r4,[r13,-0x7a]
L_92467c:
	ldb r2,[gp, -0xde]
L_924680:
	brne_s r2,0,L_92468c
L_924682:
	st.as 0xc0000000,[r13,-0x7e]
L_92468a:
	b_s L_924694
	.global L_92468c
L_92468c:
	st.as 0x40000000,[r13,-0x7e]
	.global L_924694
L_924694:
	sync
	.global L_924698
L_924698:
	ld.as r3,[r13,-0x7e]
L_92469c:
	bbit1 r3,0x1d,L_924698
L_9246a0:
	bl L_9246b0
L_9246a4:
	add_s sp,sp,0x8
L_9246a6:
	ld blink,[sp, 0x4]
L_9246aa:
	j_s.d [blink]
L_9246ac:
	ld.ab r13,[sp,0x8]
