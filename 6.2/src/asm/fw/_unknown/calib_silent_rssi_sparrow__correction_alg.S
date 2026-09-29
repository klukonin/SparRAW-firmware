/* calib_silent_rssi_sparrow__correction_alg @ 0x8c766c, 1640 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   class_calib_lo_power::correction_alg undefined lo power configuration state: %d
 *   LO LEAKAGE RESULTS: I=%d Q=%d, gain = %d
 *   BB GAIN DC::VGA_DC_FINE:: RxGainIndex=%d ======== CAL_NON_CONVERGED ====
 *   calib_silent_rssi_sparrow::correction_alg(0x%x, %d, %d)
 *   calib_silent_rssi_sparrow::correction_alg(): Running FULL Silent RSSI Calibration. rf_targets_vec=0x%x, alg_mode=0x%x
 *   calib_silent_rssi_sparrow::correction_alg() Bad p_est_info=NULL argument. alg_mode=0x%x, cur_frag=%d, total_frags=%d
 *   calib_silent_rssi_sparrow::correction_alg(): Running fragmented Silent RSSI Calibration. total_frags=%d, cur_frag=%d, alg_mode=0x%x
 *   Silent RSSI calibration took %d usec
 * Зовут его: calib_engine__on_ready_for_correction, hwf_calib_all
 * Зовёт сам: Calib__Measure_VGA_Gains, __ld_r16_to_r13_ret, __ld_r18_to_r13_ret, __ld_r20_to_r13_ret, __st_r16_to_r13, __st_r18_to_r13, __st_r20_to_r13, calib__log_if_nonzero, calib__release_hw_thunk, calib__results_addr_800a28, calib__results_addr_800a34, calib__setup_loopback_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_silent_rssi_sparrow__correction_alg
calib_silent_rssi_sparrow__correction_alg:
	.global L_8c766c
L_8c766c:
	sub_s sp,sp,0x4
L_8c766e:
	push_s blink
L_8c7670:
	bl L_8c01d4
L_8c7674:
	mov_s r16,r1
L_8c7676:
	mov_s r13,r0
L_8c7678:
	mov.f r14,r3
L_8c767c:
	mov_s r18,r2
L_8c767e:
	mov r17,r4
L_8c7682:
	beq_s L_8c76b4
	.global L_8c7684
L_8c7684:
	ld_s r0,[r13,0x24]
L_8c7686:
	ld_s r2,[r0,0x18]
L_8c7688:
	mov_s r0,r13
L_8c768a:
	jl_s.d [r2]
L_8c768c:
	mov_s r1,r16
L_8c768e:
	ld_s r0,[r13,0x24]
L_8c7690:
	mov_s r1,r16
L_8c7692:
	ld_s r15,[r0,0x1c]
L_8c7694:
	mov_s r0,r13
L_8c7696:
	mov_s r2,r18
L_8c7698:
	mov_s r3,r14
L_8c769a:
	jl_s.d [r15]
L_8c769c:
	mov r4,r17
L_8c76a0:
	mov_s r17,r0
L_8c76a2:
	ld_s r0,[r13,0x24]
L_8c76a4:
	ld_s r2,[r0,0x20]
L_8c76a6:
	mov_s r0,r13
L_8c76a8:
	jl_s.d [r2]
L_8c76aa:
	mov_s r1,r16
L_8c76ac:
	mov_s r0,r17
L_8c76ae:
	mov_s r12,0x8
L_8c76b0:
	b L_8c0236
	.global L_8c76b4
L_8c76b4:
	mov_s r0,blink
L_8c76b6:
	mov_s r1,0x81
L_8c76b8:
	bl.d L_8c9b28
L_8c76bc:
	bset_s r1,r1,0xc
L_8c76be:
	b_s L_8c7684
L_8c76c0:
	sub_s sp,sp,0x4
L_8c76c2:
	push_s blink
L_8c76c4:
	mov_s r2,0x800518
L_8c76ca:
	ldb_s r0,[r2,0x2]
L_8c76cc:
	ldb_s r1,[r2,0x1]
L_8c76ce:
	bl.d L_8d60bc
L_8c76d2:
	ldb_s r2,[r2]
L_8c76d4:
	pop_s blink
L_8c76d6:
	j_s.d [blink]
L_8c76d8:
	add_s sp,sp,0x4
L_8c76da:
	nop_s
L_8c76dc:
	sub_s sp,sp,0x4
L_8c76de:
	push_s blink
L_8c76e0:
	bl L_8c01dc
L_8c76e4:
	bl.d L_8cc3a4
L_8c76e8:
	mov_s r14,r0
L_8c76ea:
	bl.d L_8cc390
L_8c76ee:
	mov_s r13,r0
L_8c76f0:
	ld_s r2,[r14,0x28]
L_8c76f2:
	mov_s r16,r0
L_8c76f4:
	breq_s r2,0,L_8c7724
L_8c76f6:
	breq r2,0x1,L_8c7716
L_8c76fa:
	mov_s r1,0x100a2f0
L_8c7700:
	bl.d L_8dcc10
L_8c7704:
	mov_s r0,0x6
L_8c7706:
	mov_s r0,blink
L_8c7708:
	mov_s r1,0x142c
L_8c770e:
	bl L_8c9b28
L_8c7712:
	mov_s r0,0x2
L_8c7714:
	b_s L_8c774a
	.global L_8c7716
L_8c7716:
	bl L_8cc3a8
L_8c771a:
	mov_s r1,0x8004cc
L_8c7720:
	ldb_s r14,[r1,r0]
L_8c7722:
	b_s L_8c7738
	.global L_8c7724
L_8c7724:
	bl L_8cc3a8
L_8c7728:
	mov.f r14,r0
L_8c772c:
	cmp.eq r13,0xe
L_8c7730:
	bne_s L_8c7738
L_8c7732:
	bl L_8cc394
L_8c7736:
	b_s L_8c773c
	.global L_8c7738
L_8c7738:
	bl L_8cc39c
	.global L_8c773c
L_8c773c:
	mov_s r2,r0
L_8c773e:
	mov_s r0,r14
L_8c7740:
	mov_s r1,r13
L_8c7742:
	bl.d L_8dc64c
L_8c7746:
	mov_s r3,r16
L_8c7748:
	mov_s r0,0x1
	.global L_8c774a
L_8c774a:
	mov_s r12,0x8
L_8c774c:
	b L_8c0246
L_8c7750:
	sub_s sp,sp,0x4
L_8c7752:
	push_s blink
L_8c7754:
	bl.d L_8c01dc
L_8c7758:
	mov_s r4,r2
L_8c775a:
	mov_s r16,r0
L_8c775c:
	mov_s r0,0x40
L_8c775e:
	st.a r0,[sp,-0x78]
L_8c7762:
	st_s r0,[sp,0x4]
L_8c7764:
	mov_s r0,0x0
L_8c7766:
	mov_s r1,0x20
L_8c7768:
	st_s r1,[sp,0x8]
L_8c776a:
	mov_s r1,0x1
L_8c776c:
	st_s r1,[sp,0xc]
L_8c776e:
	mov_s r15,0x10
L_8c7770:
	st_s r15,[sp,0x10]
L_8c7772:
	st_s r1,[sp,0x14]
L_8c7774:
	mov_s r14,0x8
L_8c7776:
	st_s r14,[sp,0x18]
L_8c7778:
	st_s r1,[sp,0x1c]
L_8c777a:
	mov_s r13,0x4
L_8c777c:
	st_s r13,[sp,0x20]
L_8c777e:
	st_s r1,[sp,0x24]
L_8c7780:
	mov_s r2,0x2
L_8c7782:
	st_s r2,[sp,0x28]
L_8c7784:
	st_s r1,[sp,0x2c]
L_8c7786:
	st_s r1,[sp,0x30]
L_8c7788:
	st_s r1,[sp,0x34]
L_8c778a:
	st_s r0,[sp,0x38]
L_8c778c:
	st_s r0,[sp,0x3c]
L_8c778e:
	st_s r15,[sp,0x40]
L_8c7790:
	st_s r1,[sp,0x44]
L_8c7792:
	st_s r14,[sp,0x48]
L_8c7794:
	st_s r1,[sp,0x4c]
L_8c7796:
	st_s r13,[sp,0x50]
L_8c7798:
	st_s r1,[sp,0x54]
L_8c779a:
	st_s r2,[sp,0x58]
L_8c779c:
	st_s r1,[sp,0x5c]
L_8c779e:
	st_s r1,[sp,0x60]
L_8c77a0:
	st_s r1,[sp,0x64]
L_8c77a2:
	st_s r0,[sp,0x68]
L_8c77a4:
	st_s r0,[sp,0x6c]
L_8c77a6:
	st_s r0,[sp,0x70]
L_8c77a8:
	st_s r0,[sp,0x74]
L_8c77aa:
	cmp r4,0x1
L_8c77ae:
	cmp.eq r3,0x1
L_8c77b2:
	bne_s L_8c77de
	.global L_8c77b4
L_8c77b4:
	mov_s r13,sp
L_8c77b6:
	add_s r14,sp,0x4
L_8c77b8:
	add_s r3,sp,0x8
L_8c77ba:
	mov_s r0,r16
L_8c77bc:
	mov_s r1,r13
L_8c77be:
	bl.d L_8e4cd4
L_8c77c2:
	mov_s r2,r14
L_8c77c4:
	ld_s r0,[sp,0x0]
L_8c77c6:
	brlo r0,0x4,L_8c77ec
L_8c77ca:
	cmp_s r0,0x7b
L_8c77cc:
	bhi_s L_8c77ec
L_8c77ce:
	ld_s r0,[sp,0x4]
L_8c77d0:
	brlo r0,0x4,L_8c77ec
L_8c77d4:
	cmp_s r0,0x7b
L_8c77d6:
	bhi_s L_8c77ec
L_8c77d8:
	mov r16,0x0
L_8c77dc:
	b_s L_8c7844
	.global L_8c77de
L_8c77de:
	mov_s r0,blink
L_8c77e0:
	mov_s r1,0x1162
L_8c77e6:
	bl L_8c9b28
L_8c77ea:
	b_s L_8c77b4
	.global L_8c77ec
L_8c77ec:
	mov_s r0,0x0
L_8c77ee:
	bl.d L_8cf5a8
L_8c77f2:
	mov_s r1,r0
L_8c77f4:
	mov_s r0,0x1
L_8c77f6:
	bl.d L_8cf5a8
L_8c77fa:
	mov_s r1,0x3f
L_8c77fc:
	mov_s r0,0x1c
L_8c77fe:
	mov_s r1,0x0
L_8c7800:
	bl.d L_8cfdbc
L_8c7804:
	mov_s r2,0x1
L_8c7806:
	mov_s r0,0x1c
L_8c7808:
	mov_s r1,0x1
L_8c780a:
	bl.d L_8cfdbc
L_8c780e:
	mov_s r2,0x1
L_8c7810:
	mov_s r0,0x1c
L_8c7812:
	mov_s r1,0x0
L_8c7814:
	bl.d L_8cfd50
L_8c7818:
	ldb_s r2,[sp,0x0]
L_8c781a:
	mov_s r0,0x1c
L_8c781c:
	mov_s r1,0x1
L_8c781e:
	bl.d L_8cfd50
L_8c7822:
	ldb_s r2,[sp,0x4]
L_8c7824:
	mov_s r0,0x0
L_8c7826:
	bl.d L_8cfef8
L_8c782a:
	mov_s r1,r0
L_8c782c:
	mov_s r0,0x1
L_8c782e:
	bl.d L_8cfef8
L_8c7832:
	mov_s r1,0x1c
L_8c7834:
	add_s r3,sp,0x40
L_8c7836:
	mov_s r0,r16
L_8c7838:
	mov_s r1,r13
L_8c783a:
	bl.d L_8e4cd4
L_8c783e:
	mov_s r2,r14
L_8c7840:
	mov r16,0x1
	.global L_8c7844
L_8c7844:
	mov_s r14,0x0
L_8c7846:
	mov_s r13,0x1e
	.global L_8c7848
L_8c7848:
	mov_s r0,r14
L_8c784a:
	mov_s r1,0x0
L_8c784c:
	bl.d L_8cfdbc
L_8c7850:
	mov_s r2,r16
L_8c7852:
	mov_s r0,r14
L_8c7854:
	mov_s r1,0x1
L_8c7856:
	bl.d L_8cfdbc
L_8c785a:
	mov_s r2,r16
L_8c785c:
	mov_s r0,r14
L_8c785e:
	mov_s r1,0x0
L_8c7860:
	bl.d L_8cfd50
L_8c7864:
	ldb_s r2,[sp,0x0]
L_8c7866:
	mov_s r0,r14
L_8c7868:
	mov_s r1,0x1
L_8c786a:
	bl.d L_8cfd50
L_8c786e:
	ldb_s r2,[sp,0x4]
L_8c7870:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8c7872:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c7874:
	brhs.d r13,0x1,L_8c7848
L_8c7878:
	extb_s r14,r14
L_8c787a:
	ld_s r2,[sp,0x0]
L_8c787c:
	mov_s r1,0x101c848
L_8c7882:
	ld_s r3,[sp,0x4]
L_8c7884:
	mov_s r0,0x26
L_8c7886:
	bl.d L_8dcd00
L_8c788a:
	mov r4,r16
L_8c788e:
	mov_s r0,0x1
L_8c7890:
	mov_s r12,0x8
L_8c7892:
	b.d L_8c0246
L_8c7896:
	add_s sp,sp,0x78
L_8c7898:
	sub_s sp,sp,0x4
L_8c789a:
	push_s blink
L_8c789c:
	bl.d L_8d5b64
L_8c78a0:
	lsr r0,r1,0x14
L_8c78a4:
	pop_s blink
L_8c78a6:
	j_s.d [blink]
L_8c78a8:
	add_s sp,sp,0x4
L_8c78aa:
	nop_s
L_8c78ac:
	sub_s sp,sp,0x4
L_8c78ae:
	push_s blink
L_8c78b0:
	bl.d L_8c01d4
L_8c78b4:
	lsr r0,r1,0x14
L_8c78b8:
	sub_s sp,sp,0x8
L_8c78ba:
	mov_s r16,r2
L_8c78bc:
	mov_s r17,r3
L_8c78be:
	and.f 0x0,r1,0xfff00000
L_8c78c6:
	mov_s r13,0x1
L_8c78c8:
	bne_s L_8c7912
L_8c78ca:
	bl.d L_8d4a08
L_8c78ce:
	mov_s r14,0x1e
L_8c78d0:
	ldb r4,[gp, 0xf8]
L_8c78d4:
	mov_s r0,0x0
L_8c78d6:
	mov_s r1,r0
L_8c78d8:
	mov_s r2,r0
L_8c78da:
	bl.d L_8d6a64
L_8c78de:
	mov_s r3,r13
L_8c78e0:
	mov_s r0,r13
L_8c78e2:
	bl.d L_8d66cc
L_8c78e6:
	mov_s r1,0x3f
L_8c78e8:
	mov_s r13,r0
L_8c78ea:
	mov_s r15,0xb
	.global L_8c78ec
L_8c78ec:
	mov_s r0,0x0
L_8c78ee:
	bl.d L_8cf5a8
L_8c78f2:
	mov_s r1,r0
L_8c78f4:
	mov_s r0,0x1
L_8c78f6:
	bl.d L_8cf5a8
L_8c78fa:
	mov_s r1,r14
L_8c78fc:
	mov_s r2,sp
L_8c78fe:
	mov_s r0,0xff
L_8c7900:
	bl.d L_8d6ca0
L_8c7904:
	mov_s r1,0xd
L_8c7906:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8c7908:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c790a:
	brhs.d r15,0x1,L_8c78ec
L_8c790e:
	extb_s r14,r14
L_8c7910:
	b_s L_8c79e0
	.global L_8c7912
L_8c7912:
	cmp r0,0xdc
L_8c7916:
	bne_s L_8c7934
L_8c7918:
	ldb r4,[gp, 0xf8]
L_8c791c:
	mov_s r0,0x0
L_8c791e:
	mov_s r1,r0
L_8c7920:
	mov_s r2,r0
L_8c7922:
	bl.d L_8d6a64
L_8c7926:
	mov_s r3,r13
L_8c7928:
	mov_s r0,r13
L_8c792a:
	bl.d L_8d66cc
L_8c792e:
	mov_s r1,0x3f
L_8c7930:
	mov_s r13,r0
L_8c7932:
	b_s L_8c79e0
	.global L_8c7934
L_8c7934:
	brne r0,0x1,L_8c79e0
L_8c7938:
	ldb r4,[gp, 0xf8]
L_8c793c:
	mov_s r0,0x0
L_8c793e:
	mov_s r1,r0
L_8c7940:
	mov_s r2,r0
L_8c7942:
	bl.d L_8d6a64
L_8c7946:
	mov_s r3,r13
L_8c7948:
	mov_s r1,0x800510
L_8c794e:
	ldb r18,[r1, 0x3]
L_8c7952:
	ldb_s r15,[r1,0x2]
L_8c7954:
	sub r14,r18,r15
L_8c7958:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c795a:
	extb_s r14,r14
L_8c795c:
	mov_s r0,r14
L_8c795e:
	bl.d L_8c02d4
L_8c7962:
	mov_s r1,r17
L_8c7964:
	extb_s r0,r0
L_8c7966:
	mulu64 r0,r17
L_8c796a:
	sub.f r1,r14,mlo
L_8c796e:
	mov.ne r1,0x1
L_8c7972:
	add_s r0,r0,r1
L_8c7974:
	extb_s r0,r0
L_8c7976:
	breq r14,0x1,L_8c7986
L_8c797a:
	sub r1,r16,0x1
L_8c797e:
	mulu64 r1,r0
L_8c7982:
	add_s r15,r15,mlo
L_8c7984:
	extb_s r15,r15
	.global L_8c7986
L_8c7986:
	sub_s r1,r15,0x1
L_8c7988:
	add_s r0,r0,r1
L_8c798a:
	min r0,r0,r18
L_8c798e:
	extb_s r0,r0
L_8c7990:
	brlt r0,r15,L_8c79e0
L_8c7994:
	sub_s r0,r0,r15
L_8c7996:
	extb_s r0,r0
L_8c7998:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8c799a
L_8c799a:
	mov_s r16,r0
L_8c799c:
	mov_s r14,0x0
L_8c799e:
	b_s L_8c79d0
	.global L_8c79a0
L_8c79a0:
	ldb r2,[gp, 0xf8]
L_8c79a4:
	mov_s r0,r15
L_8c79a6:
	ldb r3,[gp, 0xf9]
L_8c79aa:
	mov_s r1,r14
L_8c79ac:
	bl.d L_8d67d8
L_8c79b0:
	mov r4,0x4
L_8c79b4:
	mov.f r13,r0
L_8c79b8:
	cmp.ne r13,0x1
L_8c79bc:
	beq_s L_8c79cc
L_8c79be:
	mov_s r1,0x100a254
L_8c79c4:
	mov_s r0,0x16
L_8c79c6:
	bl.d L_8dcc10
L_8c79ca:
	mov_s r2,r15
	.global L_8c79cc
L_8c79cc:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c79ce:
	extb_s r14,r14
	.global L_8c79d0
L_8c79d0:
	brlt r14,0x2,L_8c79a0
L_8c79d4:
	sub r0,r16,0x1
L_8c79d8:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8c79da:
	brhs.d r0,0x1,L_8c799a
L_8c79de:
	extb_s r15,r15
	.global L_8c79e0
L_8c79e0:
	mov_s r0,r13
L_8c79e2:
	mov_s r12,0x8
L_8c79e4:
	b.d L_8c0236
L_8c79e8:
	add_s sp,sp,0x8
L_8c79ea:
	nop_s
L_8c79ec:
	sub_s sp,sp,0x4
L_8c79ee:
	push_s blink
L_8c79f0:
	bl L_8c01cc
L_8c79f4:
	sub_s sp,sp,0x10
L_8c79f6:
	mov_s r19,r1
L_8c79f8:
	mov_s r13,r0
L_8c79fa:
	mov_s r20,r2
L_8c79fc:
	mov_s r17,r3
L_8c79fe:
	mov r18,r4
L_8c7a02:
	mov_s r1,0x1009524
L_8c7a08:
	mov_s r0,0x26
L_8c7a0a:
	mov_s r2,r19
L_8c7a0c:
	mov_s r3,r20
L_8c7a0e:
	bl.d L_8dcd00
L_8c7a12:
	mov r4,r17
L_8c7a16:
	breq r18,0x0,L_8c7aa0
	.global L_8c7a1a
L_8c7a1a:
	bl L_8e9524
L_8c7a1e:
	and.f 0x0,r19,0xfff00000
L_8c7a26:
	mov_s r16,r0
L_8c7a28:
	bne_s L_8c7ac2
L_8c7a2a:
	mov_s r0,0x8042c8
L_8c7a30:
	bl L_8ccb3c
L_8c7a34:
	mov_s r15,r0
L_8c7a36:
	mov_s r1,r0
L_8c7a38:
	mov r4,0x0
L_8c7a3c:
	b_s L_8c7a4a
	.global L_8c7a3e
L_8c7a3e:
	sub_s r0,r1,0x1
L_8c7a40:
	and_s r1,r1,r0
L_8c7a42:
	add r4,r4,0x1
L_8c7a46:
	extw r4,r4
	.global L_8c7a4a
L_8c7a4a:
	brne_s r1,0,L_8c7a3e
L_8c7a4c:
	mov_s r0,sp
L_8c7a4e:
	mov_s r17,r0
L_8c7a50:
	mov_s r14,0x0
L_8c7a52:
	mov_s r1,r14
L_8c7a54:
	mov_s r2,0x3
L_8c7a56:
	bl.d L_8c182c
L_8c7a5a:
	mov_s r3,r15
L_8c7a5c:
	ld_s r0,[r13,0x50]
L_8c7a5e:
	brne_s r0,0,L_8c7a82
L_8c7a60:
	stb_s r14,[sp,0xc]
L_8c7a62:
	add_s r1,sp,0xc
L_8c7a64:
	bl.d L_8ce910
L_8c7a68:
	mov_s r0,r15
L_8c7a6a:
	mov_s r0,r14
L_8c7a6c:
	mov_s r1,0x7f
L_8c7a6e:
	mov_s r2,r14
L_8c7a70:
	bl.d L_8d33c4
L_8c7a74:
	mov_s r3,r14
L_8c7a76:
	ldb_s r0,[sp,0xc]
L_8c7a78:
	bl.d L_8ce910
L_8c7a7c:
	mov_s r1,r14
L_8c7a7e:
	mov r18,r17
	.global L_8c7a82
L_8c7a82:
	ldb r2,[r18, 0x4]
L_8c7a86:
	mov_s r1,0x100955c
L_8c7a8c:
	mov_s r0,0x26
L_8c7a8e:
	bl.d L_8dcc80
L_8c7a92:
	mov_s r3,r19
L_8c7a94:
	mov_s r0,r13
L_8c7a96:
	mov_s r1,r19
L_8c7a98:
	bl.d L_8e3988
L_8c7a9c:
	mov_s r2,r18
L_8c7a9e:
	b_s L_8c7ae6
	.global L_8c7aa0
L_8c7aa0:
	mov_s r1,0x10095d4
L_8c7aa6:
	mov_s r0,0x0
L_8c7aa8:
	mov_s r2,r19
L_8c7aaa:
	mov_s r3,r20
L_8c7aac:
	bl.d L_8dcd00
L_8c7ab0:
	mov r4,r17
L_8c7ab4:
	mov_s r0,blink
L_8c7ab6:
	mov_s r1,0x145b
L_8c7abc:
	bl L_8c9b28
L_8c7ac0:
	b_s L_8c7a1a
	.global L_8c7ac2
L_8c7ac2:
	mov_s r1,0x100964c
L_8c7ac8:
	mov_s r0,0x26
L_8c7aca:
	mov_s r2,r17
L_8c7acc:
	mov_s r3,r20
L_8c7ace:
	bl.d L_8dcd00
L_8c7ad2:
	mov r4,r19
L_8c7ad6:
	mov_s r0,r13
L_8c7ad8:
	mov_s r1,r19
L_8c7ada:
	mov_s r2,r20
L_8c7adc:
	mov_s r3,r17
L_8c7ade:
	bl.d L_8e3864
L_8c7ae2:
	mov r4,r18
	.global L_8c7ae6
L_8c7ae6:
	bl.d L_8e9524
L_8c7aea:
	mov_s r17,r0
L_8c7aec:
	sub r0,r0,r16
L_8c7af0:
	asl_s r2,r0,0x4
L_8c7af2:
	mov_s r1,0x10096d0
L_8c7af8:
	bl.d L_8dcc10
L_8c7afc:
	mov_s r0,0x26
L_8c7afe:
	mov_s r0,r17
L_8c7b00:
	mov_s r12,0x8
L_8c7b02:
	b.d L_8c0226
L_8c7b06:
	add_s sp,sp,0x10
L_8c7b08:
	sub_s sp,sp,0x4
L_8c7b0a:
	push_s blink
L_8c7b0c:
	mov_s r0,0x1
L_8c7b0e:
	mov_s r1,r0
L_8c7b10:
	mov_s r2,r0
L_8c7b12:
	mov_s r3,r0
L_8c7b14:
	bl.d L_8d6a64
L_8c7b18:
	mov r4,0xa
L_8c7b1c:
	mov_s r0,0x3f
L_8c7b1e:
	mov_s r1,r0
L_8c7b20:
	bl.d L_8d6948
L_8c7b24:
	mov_s r2,0x1
L_8c7b26:
	mov_s r0,0x1
L_8c7b28:
	bl.d L_8d6b20
L_8c7b2c:
	mov_s r1,r0
L_8c7b2e:
	bl.d L_8cf91c
L_8c7b32:
	mov_s r0,0x1
L_8c7b34:
	mov_s r0,0x800518
L_8c7b3a:
	ldb r4,[r0]
L_8c7b3e:
	mov_s r0,0x1
L_8c7b40:
	mov_s r1,r0
L_8c7b42:
	mov_s r2,r0
L_8c7b44:
	bl.d L_8d63b0
L_8c7b48:
	mov_s r3,r0
L_8c7b4a:
	pop_s blink
L_8c7b4c:
	j_s.d [blink]
L_8c7b4e:
	add_s sp,sp,0x4
L_8c7b50:
	sub_s sp,sp,0x4
L_8c7b52:
	j_s.d [blink]
L_8c7b54:
	add_s sp,sp,0x4
L_8c7b56:
	nop_s
L_8c7b58:
	sub_s sp,sp,0x4
L_8c7b5a:
	push_s blink
L_8c7b5c:
	bl L_8d65e8
L_8c7b60:
	bl.d L_8d219c
L_8c7b64:
	mov_s r0,0x0
L_8c7b66:
	bl.d L_8d21d0
L_8c7b6a:
	mov_s r0,0x0
L_8c7b6c:
	bl.d L_8ce5e8
L_8c7b70:
	mov_s r0,0x0
L_8c7b72:
	bl.d L_8d7560
L_8c7b76:
	mov_s r0,0x0
L_8c7b78:
	bl L_8d2b38
L_8c7b7c:
	mov_s r0,0x1
L_8c7b7e:
	mov_s r1,0x1c
L_8c7b80:
	bl.d L_8d7358
L_8c7b84:
	mov_s r2,0x3f
L_8c7b86:
	mov_s r0,0x1c
L_8c7b88:
	mov_s r1,0x0
L_8c7b8a:
	bl.d L_8cfdbc
L_8c7b8e:
	mov_s r2,0x0
L_8c7b90:
	mov_s r0,0x1c
L_8c7b92:
	mov_s r1,0x1
L_8c7b94:
	bl.d L_8cfdbc
L_8c7b98:
	mov_s r2,0x0
L_8c7b9a:
	bl L_8d2be4
L_8c7b9e:
	bl.d L_8d21d0
L_8c7ba2:
	mov_s r0,0x1
L_8c7ba4:
	mov_s r0,0x0
L_8c7ba6:
	bl.d L_8cfef8
L_8c7baa:
	mov_s r1,0x1c
L_8c7bac:
	mov_s r0,0x1
L_8c7bae:
	bl.d L_8cfef8
L_8c7bb2:
	mov_s r1,0x1c
L_8c7bb4:
	bl L_8d2ba4
L_8c7bb8:
	mov_s r0,0x0
L_8c7bba:
	bl.d L_8cf5a8
L_8c7bbe:
	mov_s r1,0x3f
L_8c7bc0:
	mov_s r0,0x1
L_8c7bc2:
	bl.d L_8cf5a8
L_8c7bc6:
	mov_s r1,0x3f
L_8c7bc8:
	bl.d L_8d1bc0
L_8c7bcc:
	mov_s r0,0x1
L_8c7bce:
	mov_s r0,0x0
L_8c7bd0:
	bset_s r0,r0,0xf
L_8c7bd2:
	mov_s r1,0x1
L_8c7bd4:
	bl.d L_8d2418
L_8c7bd8:
	mov_s r2,0x65
L_8c7bda:
	mov_s r0,0x65
L_8c7bdc:
	mov_s r1,0x0
L_8c7bde:
	bl.d L_8d3090
L_8c7be2:
	mov_s r2,0x6
L_8c7be4:
	bl.d L_8d3100
L_8c7be8:
	mov_s r0,0x1
L_8c7bea:
	bl.d L_8d2c1c
L_8c7bee:
	mov_s r0,0x4
L_8c7bf0:
	pop_s blink
L_8c7bf2:
	j_s.d [blink]
L_8c7bf4:
	add_s sp,sp,0x4
L_8c7bf6:
	nop_s
L_8c7bf8:
	sub_s sp,sp,0x4
L_8c7bfa:
	push_s blink
L_8c7bfc:
	bl.d L_8d5d98
L_8c7c00:
	lsr r0,r1,0x14
L_8c7c04:
	pop_s blink
L_8c7c06:
	j_s.d [blink]
L_8c7c08:
	add_s sp,sp,0x4
L_8c7c0a:
	nop_s
L_8c7c0c:
	sub_s sp,sp,0x4
L_8c7c0e:
	push_s blink
L_8c7c10:
	bl.d L_8d4d90
L_8c7c14:
	lsr r0,r1,0x14
L_8c7c18:
	pop_s blink
L_8c7c1a:
	j_s.d [blink]
L_8c7c1c:
	add_s sp,sp,0x4
L_8c7c1e:
	nop_s
L_8c7c20:
	sub_s sp,sp,0x4
L_8c7c22:
	push_s blink
L_8c7c24:
	bl L_8d65e8
L_8c7c28:
	bl.d L_8d219c
L_8c7c2c:
	mov_s r0,0x0
L_8c7c2e:
	bl.d L_8d21d0
L_8c7c32:
	mov_s r0,0x0
L_8c7c34:
	bl.d L_8ce5e8
L_8c7c38:
	mov_s r0,0x0
L_8c7c3a:
	bl.d L_8d7560
L_8c7c3e:
	mov_s r0,0x0
L_8c7c40:
	bl L_8d2b38
L_8c7c44:
	bl L_8d2ba4
L_8c7c48:
	bl.d L_8d7560
L_8c7c4c:
	mov_s r0,0x1
L_8c7c4e:
	bl.d L_8d219c
L_8c7c52:
	mov_s r0,0x1
L_8c7c54:
	bl.d L_8d2630
L_8c7c58:
	mov_s r0,0x0
L_8c7c5a:
	pop_s blink
L_8c7c5c:
	j_s.d [blink]
L_8c7c5e:
	add_s sp,sp,0x4
L_8c7c60:
	sub_s sp,sp,0x4
L_8c7c62:
	push_s blink
L_8c7c64:
	mov_s r0,0x1
L_8c7c66:
	bl.d L_8d6460
L_8c7c6a:
	mov_s r1,r0
L_8c7c6c:
	pop_s blink
L_8c7c6e:
	j_s.d [blink]
L_8c7c70:
	add_s sp,sp,0x4
L_8c7c72:
	nop_s
L_8c7c74:
	sub_s sp,sp,0x4
L_8c7c76:
	j_s.d [blink]
L_8c7c78:
	add_s sp,sp,0x4
L_8c7c7a:
	nop_s
L_8c7c7c:
	sub_s sp,sp,0x4
L_8c7c7e:
	push_s blink
L_8c7c80:
	mov_s r0,0x0
L_8c7c82:
	mov_s r1,r0
L_8c7c84:
	bl.d L_8d7358
L_8c7c88:
	mov_s r2,r0
L_8c7c8a:
	bl.d L_8d3100
L_8c7c8e:
	mov_s r0,0x0
L_8c7c90:
	bl L_8d64c0
L_8c7c94:
	pop_s blink
L_8c7c96:
	j_s.d [blink]
L_8c7c98:
	add_s sp,sp,0x4
L_8c7c9a:
	nop_s
L_8c7c9c:
	sub_s sp,sp,0x4
L_8c7c9e:
	push_s blink
L_8c7ca0:
	bl.d L_8d5eec
L_8c7ca4:
	lsr r0,r1,0x14
L_8c7ca8:
	pop_s blink
L_8c7caa:
	j_s.d [blink]
L_8c7cac:
	add_s sp,sp,0x4
L_8c7cae:
	nop_s
L_8c7cb0:
	sub_s sp,sp,0x4
L_8c7cb2:
	push_s blink
L_8c7cb4:
	bl.d L_8d4e04
L_8c7cb8:
	lsr r0,r1,0x14
L_8c7cbc:
	pop_s blink
L_8c7cbe:
	j_s.d [blink]
L_8c7cc0:
	add_s sp,sp,0x4
L_8c7cc2:
	nop_s
L_8c7cc4:
	sub_s sp,sp,0x4
L_8c7cc6:
	push_s blink
L_8c7cc8:
	bl L_8d64c0
L_8c7ccc:
	pop_s blink
L_8c7cce:
	j_s.d [blink]
L_8c7cd0:
	add_s sp,sp,0x4
L_8c7cd2:
	nop_s
