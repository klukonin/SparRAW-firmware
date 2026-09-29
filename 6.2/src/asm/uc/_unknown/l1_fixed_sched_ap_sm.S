/* l1_fixed_sched_ap_sm @ 0x92c66c, 384 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l1_fixed_sched_ap_sm state unexpected event %d in state %d
 * Зовут его: l1_fixed_sched__event_entry, l1_task__main_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fsched__arm_slot_from_cfg, fsched__log_phase, fsched__run_tx_slot_twice, fsched__rx_slot, fsched_ap__start_slot, l1_fixed_sched_ap__ev4_state2, l1_fixed_sched_ap__ev4_state4, peer_masks__apply_op, rx_flow__run_and_check_bf_abort, sxd_hal__write_qset_field
 * Глобалы (через gp): 0x8005bc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_fixed_sched_ap_sm
l1_fixed_sched_ap_sm:
	.global L_92c66c
L_92c66c:
	push_s blink
L_92c66e:
	bl L_920234
L_92c672:
	mov_s r14,r0
L_92c674:
	mov_s r13,0x1
	.global L_92c676
L_92c676:
	bl.d L_92b398
L_92c67a:
	mov_s r0,r14
L_92c67c:
	sub_s r1,r14,0x1
L_92c67e:
	cmp_s r1,0x4
L_92c680:
	bhi L_92c7a6
L_92c684:
	ldb r1,[0x8017e0,r1]
L_92c68c:
	add r0,pcl,0x8
L_92c690:
	add1_s r0,r0,r1
L_92c692:
	j_s [r0]
L_92c694:
	mov_s r13,0x0
L_92c696:
	mov_s r0,0x802f80
L_92c69c:
	mov_s r1,0x1
L_92c69e:
	bl.d L_934bb0
L_92c6a2:
	mov_s r2,r13
L_92c6a4:
	mov_s r2,0x80064c
L_92c6aa:
	ld_s r0,[r2]
L_92c6ac:
	cmp_s r0,0x4
L_92c6ae:
	cmp.ne r0,0x7
L_92c6b2:
	bne_s L_92c6c6
L_92c6b4:
	ldb_s r0,[gp,-0xee]
L_92c6b6:
	mov_s r3,0x9
L_92c6b8:
	mov_s r1,0x8007d4
L_92c6be:
	add2_s r1,r1,r0
L_92c6c0:
	stb_s r3,[r1,0x2]
L_92c6c2:
	mov_s r0,0x1
L_92c6c4:
	stb_s r0,[r2,0x5]
	.global L_92c6c6
L_92c6c6:
	st_s r13,[r2]
L_92c6c8:
	stb_s r13,[r2,0x6]
L_92c6ca:
	mov_s r13,0x0
L_92c6cc:
	mov_s r14,r13
L_92c6ce:
	b_s L_92c7a6
L_92c6d0:
	mov_s r13,0x80064c
L_92c6d6:
	ld_s r0,[r13]
L_92c6d8:
	brne r0,0x1,L_92c6ee
L_92c6dc:
	mov_s r14,0x0
L_92c6de:
	mov_s r0,0x1
L_92c6e0:
	bl.d L_926310
L_92c6e4:
	stb_s r0,[r13,0x4]
L_92c6e6:
	stb_s r14,[r13,0x4]
	.global L_92c6e8
L_92c6e8:
	mov_s r13,0x0
L_92c6ea:
	mov_s r14,r13
L_92c6ec:
	b_s L_92c7a6
	.global L_92c6ee
L_92c6ee:
	brne r0,0x6,L_92c6f8
L_92c6f2:
	bl L_92843c
L_92c6f6:
	b_s L_92c76c
	.global L_92c6f8
L_92c6f8:
	mov_s r2,0x0
L_92c6fa:
	ldb_s r0,[gp,-0xee]
L_92c6fc:
	mov_s r3,0xf
L_92c6fe:
	mov_s r1,0x8007d4
L_92c704:
	add2_s r1,r1,r0
L_92c706:
	stb_s r3,[r1,0x2]
L_92c708:
	bl.d L_926310
L_92c70c:
	stb_s r2,[r13,0x4]
L_92c70e:
	b_s L_92c6e8
L_92c710:
	ldw_s r0,[gp,0x94]
L_92c712:
	mov_s r14,0x4
L_92c714:
	brne_s r0,0,L_92c726
L_92c716:
	ldb_s r0,[gp,-0xee]
L_92c718:
	mov_s r2,0xa
L_92c71a:
	mov_s r1,0x8007d4
L_92c720:
	add2_s r1,r1,r0
L_92c722:
	stb_s r2,[r1,0x2]
L_92c724:
	b_s L_92c782
	.global L_92c726
L_92c726:
	mov_s r1,0x80064c
L_92c72c:
	ld_s r0,[r1]
L_92c72e:
	brne r0,0x2,L_92c738
	.global L_92c732
L_92c732:
	bl L_935e74
L_92c736:
	b_s L_92c76c
	.global L_92c738
L_92c738:
	brne r0,0x4,L_92c742
L_92c73c:
	bl L_938880
L_92c740:
	b_s L_92c76c
	.global L_92c742
L_92c742:
	brne_s r0,0,L_92c74a
L_92c744:
	bl L_935a6c
L_92c748:
	b_s L_92c76c
	.global L_92c74a
L_92c74a:
	brne r0,0x1,L_92c762
L_92c74e:
	ldb_s r0,[r1,0x5]
L_92c750:
	mov_s r2,0x0
L_92c752:
	breq_s r0,0,L_92c75a
L_92c754:
	st_s r14,[r1]
L_92c756:
	stb_s r2,[r1,0x5]
L_92c758:
	b_s L_92c75e
	.global L_92c75a
L_92c75a:
	mov_s r0,0x2
L_92c75c:
	st_s r0,[r1]
	.global L_92c75e
L_92c75e:
	mov_s r14,0x4
L_92c760:
	b_s L_92c76e
	.global L_92c762
L_92c762:
	brne r0,0x6,L_92c772
L_92c766:
	mov_s r0,0x2
L_92c768:
	st_s r0,[r1]
L_92c76a:
	b_s L_92c732
	.global L_92c76c
L_92c76c:
	mov_s r14,r0
	.global L_92c76e
L_92c76e:
	mov_s r13,0x0
L_92c770:
	b_s L_92c7a6
	.global L_92c772
L_92c772:
	brne r0,0x7,L_92c7a6
L_92c776:
	bl L_938a18
L_92c77a:
	b_s L_92c76c
L_92c77c:
	ldw_s r0,[gp,0x94]
L_92c77e:
	mov_s r14,0x5
L_92c780:
	brne_s r0,0,L_92c794
	.global L_92c782
L_92c782:
	mov_s r13,0x0
L_92c784:
	mov_s r1,0x9ab
L_92c78a:
	bl.d L_934f54
L_92c78e:
	mov_s r0,r13
L_92c790:
	mov_s r14,r13
L_92c792:
	b_s L_92c7a6
	.global L_92c794
L_92c794:
	mov_s r0,0x80064c
L_92c79a:
	ld_s r0,[r0]
L_92c79c:
	brne r0,0x5,L_92c7a6
L_92c7a0:
	bl L_92b3bc
L_92c7a4:
	b_s L_92c76c
	.global L_92c7a6
L_92c7a6:
	breq_s r13,0,L_92c7cc
L_92c7a8:
	mov_s r1,0x10007b8
L_92c7ae:
	mov_s r3,0x80064c
L_92c7b4:
	mov_s r0,0x0
L_92c7b6:
	mov_s r2,r14
L_92c7b8:
	bl.d L_92d27c
L_92c7bc:
	ld_s r3,[r3]
L_92c7be:
	mov_s r0,blink
L_92c7c0:
	mov_s r1,0x1578
L_92c7c6:
	bl L_926618
L_92c7ca:
	b_s L_92c7ce
	.global L_92c7cc
L_92c7cc:
	mov_s r13,0x1
	.global L_92c7ce
L_92c7ce:
	ldb_s r0,[gp,-0xee]
L_92c7d0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c7d2:
	extb_s r0,r0
L_92c7d4:
	brlt.d r0,0x10,L_92c7e2
L_92c7d8:
	stb r0,[gp, -0xee]
L_92c7dc:
	mov_s r0,0x0
L_92c7de:
	stb r0,[gp, -0xee]
	.global L_92c7e2
L_92c7e2:
	cmp_s r14,0x0
L_92c7e4:
	bne_s L_92c676
L_92c7e6:
	b L_9202a4
L_92c7ea:
	nop_s
