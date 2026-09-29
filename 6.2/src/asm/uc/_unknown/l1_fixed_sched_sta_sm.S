/* l1_fixed_sched_sta_sm @ 0x92c840, 308 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l1_fixed_sched_sta_sm state unexpected event %d in state %d
 * Зовут его: l1_fixed_sched__event_entry, l1_task__main_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, delay_800_iters, fsched__log_phase, get_mem_857744_x2, rx_flow__run_and_check_bf_abort, sxd_hal__write_qset_field, uc_log__emit2, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_fixed_sched_sta_sm
l1_fixed_sched_sta_sm:
	.global L_92c840
L_92c840:
	push_s blink
L_92c842:
	bl L_920230
L_92c846:
	mov_s r13,r0
L_92c848:
	mov_s r15,0x1
	.global L_92c84a
L_92c84a:
	bl.d L_92b398
L_92c84e:
	mov_s r0,r13
L_92c850:
	sub_s r1,r13,0x1
L_92c852:
	brhs r1,0x4,L_92c91a
L_92c856:
	add r0,pcl,0x18
L_92c85a:
	ldb.x r1,[0x8017e8,r1]
L_92c862:
	mov_s r14,0x80064c
L_92c868:
	add1_s r0,r0,r1
L_92c86a:
	j_s [r0]
L_92c86c:
	mov_s r15,0x0
L_92c86e:
	st_s r15,[r14]
L_92c870:
	b_s L_92c918
L_92c872:
	ld_s r0,[r14]
L_92c874:
	mov_s r13,0x0
L_92c876:
	brne r0,0x2,L_92c886
L_92c87a:
	mov_s r0,0x1
L_92c87c:
	bl.d L_926310
L_92c880:
	stb_s r0,[r14,0x4]
L_92c882:
	stb_s r13,[r14,0x4]
L_92c884:
	b_s L_92c89a
	.global L_92c886
L_92c886:
	stb_s r13,[r14,0x4]
L_92c888:
	ldb_s r0,[gp,-0xee]
L_92c88a:
	mov_s r2,0xf
L_92c88c:
	mov_s r1,0x8007d4
L_92c892:
	add2_s r1,r1,r0
L_92c894:
	bl.d L_926310
L_92c898:
	stb_s r2,[r1,0x2]
	.global L_92c89a
L_92c89a:
	cmp_s r0,0x2
L_92c89c:
	mov_s r13,0x0
L_92c89e:
	mov.ne r15,r13
L_92c8a2:
	bne_s L_92c91a
L_92c8a4:
	mov_s r0,0x4
L_92c8a6:
	st_s r0,[r14]
L_92c8a8:
	ldb_s r0,[gp,-0xee]
L_92c8aa:
	mov_s r2,0x1
L_92c8ac:
	mov_s r1,0x8007d4
L_92c8b2:
	add2_s r1,r1,r0
L_92c8b4:
	stb_s r2,[r1,0x2]
L_92c8b6:
	mov_s r0,0x20d2800
L_92c8bc:
	mov_s r32,r0
L_92c8be:
	st.ab r0,[r25,0x4]
L_92c8c2:
	bclr r25,r25,0xa
L_92c8c6:
	mov_s r15,0x0
L_92c8c8:
	mov_s r13,0x3
L_92c8ca:
	b_s L_92c91a
L_92c8cc:
	ld_s r0,[r14]
L_92c8ce:
	mov_s r13,0x3
L_92c8d0:
	brne r0,0x4,L_92c91a
L_92c8d4:
	bl.d L_938a64
L_92c8d8:
	mov_s r15,0x0
L_92c8da:
	mov_s r13,r0
L_92c8dc:
	mov_s r0,0x2
L_92c8de:
	st_s r0,[r14]
L_92c8e0:
	b_s L_92c91a
L_92c8e2:
	ld_s r0,[r14]
L_92c8e4:
	mov_s r13,0x4
L_92c8e6:
	brne_s r0,0,L_92c90a
L_92c8e8:
	mov_s r0,0x801be8
L_92c8ee:
	bl.d L_927a34
L_92c8f2:
	mov_s r15,0x0
L_92c8f4:
	sub r0,r0,0xc8
L_92c8f8:
	mulu64 r0,0xa5
L_92c8fc:
	mov_s r0,0x0
L_92c8fe:
	bl.d L_934f54
L_92c902:
	mov_s r1,mlo
L_92c904:
	mov_s r0,0x1
L_92c906:
	st_s r0,[r14]
L_92c908:
	b_s L_92c918
	.global L_92c90a
L_92c90a:
	cmp_s r0,0x1
L_92c90c:
	cmp.ne r0,0x2
L_92c910:
	bne_s L_92c91a
L_92c912:
	mov_s r15,0x0
L_92c914:
	mov_s r0,0x2
L_92c916:
	st_s r0,[r14]
	.global L_92c918
L_92c918:
	mov_s r13,r15
	.global L_92c91a
L_92c91a:
	breq_s r15,0,L_92c940
L_92c91c:
	mov_s r1,0x10007f4
L_92c922:
	mov_s r3,0x80064c
L_92c928:
	mov_s r0,0x0
L_92c92a:
	mov_s r2,r13
L_92c92c:
	bl.d L_92d27c
L_92c930:
	ld_s r3,[r3]
L_92c932:
	mov_s r0,blink
L_92c934:
	mov_s r1,0x1579
L_92c93a:
	bl L_926618
L_92c93e:
	b_s L_92c942
	.global L_92c940
L_92c940:
	mov_s r15,0x1
	.global L_92c942
L_92c942:
	ldb_s r0,[gp,-0xee]
L_92c944:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c946:
	extb_s r0,r0
L_92c948:
	brlt.d r0,0x10,L_92c956
L_92c94c:
	stb r0,[gp, -0xee]
L_92c950:
	mov_s r0,0x0
L_92c952:
	stb r0,[gp, -0xee]
	.global L_92c956
L_92c956:
	ld_s r0,[gp,-0x34]
L_92c958:
	asl_s r1,r13,0x4
L_92c95a:
	bset_s r0,r0,0x16
L_92c95c:
	bset_s r0,r0,0x17
L_92c95e:
	or_s r0,r0,r1
L_92c960:
	bset_s r0,r0,0x1f
L_92c962:
	mov_s r32,r0
L_92c964:
	st.ab r0,[r25,0x4]
L_92c968:
	bclr r25,r25,0xa
L_92c96c:
	cmp_s r13,0x0
L_92c96e:
	bne_s L_92c84a
L_92c970:
	b L_92029c
