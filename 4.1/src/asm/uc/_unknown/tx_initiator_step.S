/* tx_initiator_step @ 0x93466c, 536 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_initiator_flow
 * Зовёт сам: __ld_r20_to_r13_ret_uc, __st_r20_to_r13_uc, bf__trigger_if_pending, bf_metrics__reset_and_stamp, bf_pending__set_bit, mac__program_tx_rate, obj__set_field18_from_tbl_801130, rate_search__current_mcs, rgf_reg_881800, tx__pick_slot_for_peer, tx_flow_size_step, tx_initiator__reset_slot_counters
 * Глобалы (через gp): 0x80056c, 0x8005b8, 0x8005e0, 0x800608
 */
	.section .text.tx_initiator_step,"ax",@progbits
	.global tx_initiator_step
tx_initiator_step:
	.global L_93466c
L_93466c:
	push_s blink
L_93466e:
	bl L_9201fc
L_934672:
	mov_s r14,r0
L_934674:
	mov_s r0,0x8009c0
L_93467a:
	ld_s r1,[r0,0x8]
L_93467c:
	mov_s r13,0x0
L_93467e:
	mov_s r0,0x8010e8
L_934684:
	stb.a r13,[sp,-0x4]
L_934688:
	bbit0 r1,0x9,L_934690
L_93468c:
	ldb_s r0,[r0,0x16]
L_93468e:
	b_s L_934692
	.global L_934690
L_934690:
	ldb_s r0,[r0,0x14]
	.global L_934692
L_934692:
	mov_s r18,r0
L_934694:
	mov_s r0,0x801a18
L_93469a:
	ld_s r1,[r0,0x60]
L_93469c:
	mov_s r2,0x8011a4
L_9346a2:
	ld_s r0,[r1]
L_9346a4:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9346a6:
	add3_s r0,r0,r0
L_9346a8:
	ld_s r2,[r2,r0]
L_9346aa:
	ld_s r0,[r1,0x4]
L_9346ac:
	ld.as r17,[gp,0x11]
L_9346b0:
	bbit0 r2,r0,L_9346c6
L_9346b4:
	mov_s r1,0x800444
L_9346ba:
	ldb_s r0,[r1]
L_9346bc:
	brne r0,0x1,L_9346c6
L_9346c0:
	bl.d L_926c54
L_9346c4:
	stb_s r13,[r1]
	.global L_9346c6
L_9346c6:
	ld_s r0,[r14]
L_9346c8:
	mov_s r15,0x8016d8
L_9346ce:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9346d0:
	add1_s r0,r0,r0
L_9346d2:
	ld_s r0,[r15,r0]
L_9346d4:
	sub.f r0,r0,0x0
L_9346d8:
	mov.ne r0,0x1
L_9346dc:
	extb.f 0x0,r0
L_9346e0:
	add r20,r15,0x4
L_9346e4:
	beq_s L_9346ea
L_9346e6:
	st.as r13,[gp,0x11]
	.global L_9346ea
L_9346ea:
	bl.d L_937598
L_9346ee:
	mov_s r0,r14
L_9346f0:
	bl L_934884
L_9346f4:
	brne_s r0,0,L_93470c
L_9346f6:
	ld_s r0,[gp,0xe0]
L_9346f8:
	st.as r17,[gp,0x11]
L_9346fc:
	bclr_s r0,r0,0x8
L_9346fe:
	st.as r0,[gp,0x38]
L_934702:
	mov_s r0,0x0
L_934704:
	bl.d L_9372dc
L_934708:
	mov_s r1,r0
L_93470a:
	b_s L_93487e
	.global L_93470c
L_93470c:
	mov_s r0,0x80
L_93470e:
	bset_s r0,r0,0x19
L_934710:
	mov_s r32,r0
L_934712:
	st.ab r0,[r25,0x4]
L_934716:
	bclr r25,r25,0xa
L_93471a:
	ld_s r0,[gp,-0x58]
L_93471c:
	ld.as r1,[gp,0x11]
L_934720:
	or_s r0,r0,r1
L_934722:
	st.as r0,[gp,-0x16]
L_934726:
	mov_s r1,0x886f00
L_93472c:
	mov_s r16,r1
L_93472e:
	st_s r0,[r1,0x5c]
L_934730:
	mov_s r1,sp
L_934732:
	bl.d L_934c08
L_934736:
	mov_s r0,r14
L_934738:
	mov_s r19,r0
L_93473a:
	ld_s r0,[r14]
L_93473c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93473e:
	add1_s r0,r0,r0
L_934740:
	ld_s r0,[r15,r0]
L_934742:
	sub.f r0,r0,0x0
L_934746:
	mov.ne r0,0x1
L_93474a:
	extb.f 0x0,r0
L_93474e:
	mov_s r0,r14
L_934750:
	beq_s L_934758
L_934752:
	bl L_93448c
L_934756:
	b_s L_93475c
	.global L_934758
L_934758:
	bl L_934354
	.global L_93475c
L_93475c:
	ld_s r0,[r14]
L_93475e:
	mov_s r2,0x857838
L_934764:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_934766:
	add2_s r0,r0,r0
L_934768:
	add r15,r2,0x11
L_93476c:
	add r1,r2,0x10
L_934770:
	add_s r2,r2,r0
L_934772:
	ldb_s r0,[r2,0x10]
L_934774:
	cmp_s r0,r18
L_934776:
	mov.lt r13,0x0
L_93477a:
	blt_s L_934794
L_93477c:
	ld_s r0,[gp,0xb8]
L_93477e:
	bbit0 r0,0x2,L_934788
L_934782:
	ldb_s r0,[r2,0x11]
L_934784:
	bset_s r0,r0,0x2
L_934786:
	stb_s r0,[r2,0x11]
	.global L_934788
L_934788:
	ld_s r0,[r14]
L_93478a:
	mov_s r13,0x0
L_93478c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93478e:
	add2_s r0,r0,r0
L_934790:
	add_s r1,r1,r0
L_934792:
	stb_s r13,[r1]
	.global L_934794
L_934794:
	mov_s r0,0x0
L_934796:
	bl.d L_9372dc
L_93479a:
	mov_s r1,r0
L_93479c:
	ld_s r0,[r14]
L_93479e:
	bl.d L_926840
L_9347a2:
	mov_s r1,0x1
L_9347a4:
	ld_s r0,[r14]
L_9347a6:
	asl_s r1,r0,0x2
L_9347a8:
	add1_s r1,r1,r1
L_9347aa:
	ld r1,[r20,r1]
L_9347ae:
	cmp_s r1,0x3
L_9347b0:
	cmp.ne r1,0x4
L_9347b4:
	cmp.ne r1,0x5
L_9347b8:
	bne_s L_9347bc
L_9347ba:
	mov_s r13,0x1
	.global L_9347bc
L_9347bc:
	extb.f 0x0,r13
L_9347c0:
	beq_s L_9347d4
L_9347c2:
	asl_s r1,r0,0x2
L_9347c4:
	add2_s r1,r1,r1
L_9347c6:
	ldb_s r1,[r15,r1]
L_9347c8:
	brne_s r1,0,L_9347d4
L_9347ca:
	bl L_92c01c
L_9347ce:
	bl.d L_921f58
L_9347d2:
	mov_s r0,0x1
	.global L_9347d4
L_9347d4:
	mov_s r13,0x801118
L_9347da:
	ld_s r0,[r13,0x14]
L_9347dc:
	ld_s r1,[r14]
L_9347de:
	breq_s r0,0,L_9347ee
L_9347e0:
	mov_s r0,0x857180
L_9347e6:
	add2_s r0,r0,r1
L_9347e8:
	ld_s r1,[r0,0x1c]
L_9347ea:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9347ec:
	st_s r1,[r0,0x1c]
	.global L_9347ee
L_9347ee:
	ld_s r0,[r14]
L_9347f0:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9347f2:
	add2_s r0,r0,r0
L_9347f4:
	ldb_s r1,[r15,r0]
L_9347f6:
	brne_s r1,0,L_9347fe
L_9347f8:
	ldb_s r0,[sp,0x0]
L_9347fa:
	brne r0,0x1,L_93484e
	.global L_9347fe
L_9347fe:
	ld_s r0,[gp,0x90]
L_934800:
	st_s r1,[r0,0x14]
L_934802:
	bl.d L_92c278
L_934806:
	ld_s r0,[r14]
L_934808:
	ld.as r1,[gp,0x24]
L_93480c:
	st_s r0,[r1,0x18]
L_93480e:
	mov_s r0,0x80090c
L_934814:
	ldw_s r1,[r0,0x24]
L_934816:
	ld_s r0,[gp,0x90]
L_934818:
	st_s r1,[r0,0x20]
L_93481a:
	ld_s r1,[r13]
L_93481c:
	ld_s r0,[gp,0x90]
L_93481e:
	st_s r1,[r0,0x24]
L_934820:
	ld_s r1,[r13,0x4]
L_934822:
	ld_s r0,[gp,0x90]
L_934824:
	st_s r1,[r0,0x28]
L_934826:
	ld_s r1,[r13,0x8]
L_934828:
	ld_s r0,[gp,0x90]
L_93482a:
	st_s r1,[r0,0x2c]
L_93482c:
	ld_s r1,[r13,0xc]
L_93482e:
	ld_s r0,[gp,0x90]
L_934830:
	st_s r1,[r0,0x30]
L_934832:
	mov_s r1,0x800fb0
L_934838:
	ldb_s r2,[r1]
L_93483a:
	ld_s r0,[gp,0x90]
L_93483c:
	st_s r2,[r0,0x34]
L_93483e:
	ldb_s r1,[r1,0x1]
L_934840:
	ld_s r0,[gp,0x90]
L_934842:
	st_s r1,[r0,0x38]
L_934844:
	bl.d L_931ef8
L_934848:
	mov_s r0,0x0
L_93484a:
	bl L_9374b4
	.global L_93484e
L_93484e:
	ld.as r1,[gp,0x11]
L_934852:
	ld_s r0,[gp,-0x58]
L_934854:
	bic_s r0,r0,r1
L_934856:
	st.as r0,[gp,-0x16]
L_93485a:
	st r0,[r16, 0x5c]
L_93485e:
	st.as r17,[gp,0x11]
L_934862:
	brne r19,0x0,L_934870
L_934866:
	ldb_s r1,[r14]
L_934868:
	mov_s r0,0x0
L_93486a:
	bl.d L_924db8
L_93486e:
	ldb_s r2,[r14,0x4]
	.global L_934870
L_934870:
	mov_s r0,0x0
L_934872:
	bset_s r0,r0,0x1d
L_934874:
	mov_s r32,r0
L_934876:
	st.ab r0,[r25,0x4]
L_93487a:
	bclr r25,r25,0xa
	.global L_93487e
L_93487e:
	b.d L_920254
L_934882:
	add_s sp,sp,0x4
