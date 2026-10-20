/* bf_substate__dispatch_by_state @ 0x922850, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__step_by_state
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_state__set, bf_substate__brp_mode_by_slot, bf_substate__txss_by_slot, bf_substate__txss_step_by_slot, brp__apply_slot_mcs
 * Глобалы (через gp): 0x8005d2
 */
	.section .text.bf_substate__dispatch_by_state,"ax",@progbits
	.global bf_substate__dispatch_by_state
bf_substate__dispatch_by_state:
	.global L_922850
L_922850:
	push_s blink
L_922852:
	bl L_920210
L_922856:
	asl_s r15,r0,0x2
L_922858:
	add1_s r15,r15,r15
L_92285a:
	add_s r15,r15,0x800ef4
L_922860:
	ld_s r1,[r15,0x4]
L_922862:
	mov_s r14,r0
L_922864:
	ld_s r0,[r15]
L_922866:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_922868:
	or_s r0,r0,r1
L_92286a:
	bmsk_s r0,r0,0xb
L_92286c:
	or r0,r0,0xfcf000
L_922874:
	mov_s r32,r0
L_922876:
	st.ab r0,[r25,0x4]
L_92287a:
	bclr r25,r25,0xa
L_92287e:
	ld_s r0,[r15]
L_922880:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_922882:
	brlo r0,0x8,L_92288a
L_922886:
	mov_s r13,0x0
L_922888:
	b_s L_922928
	.global L_92288a
L_92288a:
	ldw.x.as r0,[0x800c58,r0]
L_922892:
	add r1,pcl,0xa
L_922896:
	add1_s r1,r1,r0
L_922898:
	j_s [r1]
L_92289a:
	bl.d L_935e84
L_92289e:
	mov_s r0,r14
L_9228a0:
	mov_s r13,r0
L_9228a2:
	brne r0,0x1,L_922928
L_9228a6:
	asl_s r0,r14,0x3
L_9228a8:
	add3_s r0,r0,r0
L_9228aa:
	mov_s r1,0x8011d4
L_9228b0:
	ldb_s r0,[r1,r0]
L_9228b2:
	brne_s r0,0,L_9228f0
L_9228b4:
	mov_s r1,0x0
L_9228b6:
	ldw_s r0,[gp,0xaa]
L_9228b8:
	bset r1,r1,r14
L_9228bc:
	tst_s r0,r1
L_9228be:
	bne_s L_922918
L_9228c0:
	mov_s r0,0x80102c
L_9228c6:
	ldb_s r0,[r0,0x8]
L_9228c8:
	tst_s r0,r1
L_9228ca:
	beq_s L_922918
L_9228cc:
	mov_s r0,r14
L_9228ce:
	bl.d L_9283c8
L_9228d2:
	mov_s r1,0x9
L_9228d4:
	b_s L_922928
L_9228d6:
	bl.d L_93639c
L_9228da:
	mov_s r0,r14
L_9228dc:
	mov_s r13,r0
L_9228de:
	brne r0,0x1,L_922928
L_9228e2:
	asl_s r0,r14,0x3
L_9228e4:
	add3_s r0,r0,r0
L_9228e6:
	mov_s r1,0x8011d4
L_9228ec:
	ldb_s r0,[r1,r0]
L_9228ee:
	breq_s r0,0,L_9228f8
	.global L_9228f0
L_9228f0:
	bl.d L_9258d0
L_9228f4:
	mov_s r0,r14
L_9228f6:
	b_s L_922918
	.global L_9228f8
L_9228f8:
	asl_s r0,r14,0x2
L_9228fa:
	add1_s r0,r0,r0
L_9228fc:
	mov_s r1,0x800efe
L_922902:
	ldb_s r0,[r1,r0]
L_922904:
	brlt r0,0x1,L_922918
L_922908:
	ldw_s r0,[gp,0xaa]
L_92290a:
	bbit1 r0,r14,L_922918
L_92290e:
	mov_s r0,r14
L_922910:
	bl.d L_9283c8
L_922914:
	mov_s r1,0xa
L_922916:
	b_s L_922928
	.global L_922918
L_922918:
	mov_s r13,0x3
L_92291a:
	b_s L_922928
L_92291c:
	bl.d L_922cd0
L_922920:
	mov_s r0,r14
	.global L_922922
L_922922:
	mov_s r13,r0
L_922924:
	breq r0,0x1,L_922918
	.global L_922928
L_922928:
	ld_s r0,[r15,0x4]
L_92292a:
	ld_s r1,[r15]
L_92292c:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_92292e:
	or_s r0,r0,r1
L_922930:
	bmsk_s r0,r0,0xb
L_922932:
	or r0,r0,0xfcc000
L_92293a:
	mov_s r32,r0
L_92293c:
	st.ab r0,[r25,0x4]
L_922940:
	bclr r25,r25,0xa
L_922944:
	mov_s r0,0x52
L_922946:
	asl_s r0,r0,0x18
L_922948:
	mov_s r32,r0
L_92294a:
	st.ab r0,[r25,0x4]
L_92294e:
	bclr r25,r25,0xa
L_922952:
	mov_s r0,0x53
L_922954:
	asl_s r0,r0,0x18
L_922956:
	mov_s r32,r0
L_922958:
	st.ab r0,[r25,0x4]
L_92295c:
	bclr r25,r25,0xa
L_922960:
	b.d L_92027c
