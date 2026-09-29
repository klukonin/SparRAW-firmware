/* IF_GAIN__GAIN @ 0x8d565c, 1288 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   IF_GAIN::GAIN NOT-CONVERGED  ina_rssi_adc_db=%d   ; rx_packet_rssi_db=%d  (%d iterations)
 * Зовут его: if_gain
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, approx_magnitude, fw_log_emit3, fw_sysassert_fatal, hwd_abif__caf_lpbk_mode, hwd_abif__rx_table_config_ifrx_ctrl, hwd_abif__tx_table_config_dac_fssel, hwd_abif__tx_table_config_iftx_ctrl, hwd_phy__rx_cal_corr, hwd_phy__rx_enable, hwd_phy__rx_ina_det_mode
 * Глобалы (через gp): 0x800229
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global IF_GAIN__GAIN
IF_GAIN__GAIN:
	.global L_8d565c
L_8d565c:
	push_s blink
L_8d565e:
	bl L_8c01b8
L_8d5662:
	st.a r0,[sp,-0x6c]
L_8d5666:
	st_s r1,[sp,0x4]
L_8d5668:
	st_s r2,[sp,0x8]
L_8d566a:
	mov_s r14,r3
L_8d566c:
	ldb r16,[r3]
L_8d5670:
	ldb r22,[r3, 0x1]
L_8d5674:
	ldb_s r0,[r3,0x4]
L_8d5676:
	ldb r24,[r3, 0x2]
L_8d567a:
	st_s r0,[sp,0xc]
L_8d567c:
	ldb r20,[r3, 0x6]
L_8d5680:
	ldb_s r0,[r3,0xe]
L_8d5682:
	ldb r23,[r3, 0x7]
L_8d5686:
	st_s r0,[sp,0x10]
L_8d5688:
	ldb_s r0,[r3,0xf]
L_8d568a:
	brhs.d r24,0x13,L_8d56da
L_8d568e:
	st_s r0,[sp,0x14]
	.global L_8d5690
L_8d5690:
	ld_s r0,[sp,0xc]
L_8d5692:
	brhs r0,0x12,L_8d56e8
	.global L_8d5696
L_8d5696:
	mov_s r0,0x801954
L_8d569c:
	ldb r0,[r0,r24]
L_8d56a0:
	mov_s r1,0x801968
L_8d56a6:
	st_s r0,[sp,0x18]
L_8d56a8:
	ld_s r0,[sp,0xc]
L_8d56aa:
	ldb_s r0,[r1,r0]
L_8d56ac:
	st_s r0,[sp,0x1c]
L_8d56ae:
	ld_s r0,[sp,0x0]
L_8d56b0:
	breq_s r0,0,L_8d56f6
L_8d56b2:
	breq r0,0x1,L_8d5718
L_8d56b6:
	mov_s r0,blink
L_8d56b8:
	mov_s r1,0x1309
L_8d56be:
	mov_s r2,0x7f
L_8d56c0:
	st_s r2,[sp,0x20]
L_8d56c2:
	mov_s r2,0xff
L_8d56c4:
	st_s r2,[sp,0x24]
L_8d56c6:
	mov_s r13,0x0
L_8d56c8:
	mov_s r19,r13
L_8d56ca:
	mov_s r25,r13
L_8d56cc:
	st_s r13,[sp,0x28]
L_8d56ce:
	mov_s r21,r13
L_8d56d0:
	st_s r13,[sp,0x2c]
L_8d56d2:
	st_s r13,[sp,0x30]
L_8d56d4:
	b.d L_8d5afc
L_8d56d8:
	mov_s r17,r13
	.global L_8d56da
L_8d56da:
	mov_s r0,blink
L_8d56dc:
	mov_s r1,0x147e
L_8d56e2:
	bl L_8c9b28
L_8d56e6:
	b_s L_8d5690
	.global L_8d56e8
L_8d56e8:
	mov_s r0,blink
L_8d56ea:
	mov_s r1,0x147f
L_8d56f0:
	bl L_8c9b28
L_8d56f4:
	b_s L_8d5696
	.global L_8d56f6
L_8d56f6:
	bl.d L_8d3100
L_8d56fa:
	mov_s r0,0x1
	.global L_8d56fc
L_8d56fc:
	mov_s r0,0x7f
L_8d56fe:
	st_s r0,[sp,0x20]
L_8d5700:
	mov_s r0,0xff
L_8d5702:
	st_s r0,[sp,0x24]
L_8d5704:
	mov_s r13,0x0
L_8d5706:
	mov_s r19,r13
L_8d5708:
	mov_s r25,r13
L_8d570a:
	st_s r13,[sp,0x28]
L_8d570c:
	mov_s r21,r13
L_8d570e:
	st_s r13,[sp,0x2c]
L_8d5710:
	st_s r13,[sp,0x30]
L_8d5712:
	b.d L_8d597c
L_8d5716:
	mov_s r17,r13
	.global L_8d5718
L_8d5718:
	bl.d L_8d21d0
L_8d571c:
	mov_s r0,0x1
L_8d571e:
	ld_s r0,[sp,0x4]
L_8d5720:
	cmp_s r0,0x1
L_8d5722:
	mov.eq r0,0xffff
L_8d572a:
	mov.eq r1,0x7
L_8d572e:
	mov.eq r3,0x4d2
L_8d5736:
	bl.eq.d L_8d2f88
L_8d573a:
	mov.eq r2,0xa
L_8d573e:
	b_s L_8d56fc
	.global L_8d5740
L_8d5740:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d5742:
	extb_s r0,r0
L_8d5744:
	st_s r0,[sp,0x28]
L_8d5746:
	ld_s r1,[sp,0x18]
L_8d5748:
	mov_s r0,0x1
L_8d574a:
	bl.d L_8d2e48
L_8d574e:
	mov_s r2,r1
L_8d5750:
	mov_s r0,r16
L_8d5752:
	bl.d L_8cfc80
L_8d5756:
	ld_s r1,[sp,0x1c]
L_8d5758:
	add1 r15,r20,r20
L_8d575c:
	add_s r15,r15,0x80197c
L_8d5762:
	mov_s r0,r16
L_8d5764:
	mov_s r1,0x1
L_8d5766:
	bl.d L_8cfcb4
L_8d576a:
	ldb_s r2,[r15]
L_8d576c:
	mov_s r0,r16
L_8d576e:
	mov_s r1,0x2
L_8d5770:
	bl.d L_8cfcb4
L_8d5774:
	ldb_s r2,[r15,0x1]
L_8d5776:
	mov_s r0,r16
L_8d5778:
	mov_s r1,0x3
L_8d577a:
	bl.d L_8cfcb4
L_8d577e:
	ldb_s r2,[r15,0x2]
L_8d5780:
	mov_s r0,r22
L_8d5782:
	mov_s r1,0x1
L_8d5784:
	bl.d L_8cf0f8
L_8d5788:
	ldb_s r2,[r15]
L_8d578a:
	mov_s r0,r22
L_8d578c:
	mov_s r1,0x2
L_8d578e:
	bl.d L_8cf0f8
L_8d5792:
	ldb_s r2,[r15,0x1]
L_8d5794:
	mov_s r0,r22
L_8d5796:
	mov_s r1,0x3
L_8d5798:
	bl.d L_8cf0f8
L_8d579c:
	ldb_s r2,[r15,0x2]
L_8d579e:
	bl.d L_8ce5e8
L_8d57a2:
	mov_s r0,0x0
L_8d57a4:
	bl.d L_8ce5e8
L_8d57a8:
	mov_s r0,0x1
L_8d57aa:
	ldb_s r0,[gp,0xa5]
L_8d57ac:
	breq_s r0,0,L_8d57c0
L_8d57ae:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8d57b0:
	add2_s r0,r0,r0
L_8d57b2:
	mov lp_count,r0
L_8d57b6:
	nop_s
L_8d57b8:
	lp L_8d57c0
L_8d57bc:
	nop_s
L_8d57be:
	nop_s
	.global L_8d57c0
L_8d57c0:
	ld_s r0,[sp,0x4]
L_8d57c2:
	breq_s r0,0,L_8d57e4
L_8d57c4:
	breq r0,0x1,L_8d585c
L_8d57c8:
	cmp_s r0,0x2
L_8d57ca:
	beq_s L_8d589c
L_8d57cc:
	mov_s r0,blink
L_8d57ce:
	mov_s r1,0x130a
L_8d57d4:
	bl.d L_8c9b28
L_8d57d8:
	mov r18,0x0
L_8d57dc:
	mov_s r1,0x0
L_8d57de:
	b.d L_8d5978
L_8d57e2:
	mov_s r15,0x0
	.global L_8d57e4
L_8d57e4:
	mov_s r13,0x0
L_8d57e6:
	bset_s r13,r13,0xf
L_8d57e8:
	bl.d L_8d219c
L_8d57ec:
	mov_s r0,0x0
L_8d57ee:
	bl.d L_8d23a0
L_8d57f2:
	add_s r0,sp,0x34
L_8d57f4:
	ldw.x r0,[sp, 0x34]
L_8d57f8:
	ldw.x r1,[sp, 0x38]
L_8d57fc:
	cmp_s r0,0x0
L_8d57fe:
	add.ge r0,r0,0x2
L_8d5802:
	asr.ge r0,r0,0x2
L_8d5806:
	bge_s L_8d5810
L_8d5808:
	rsub r2,r0,0x2
L_8d580c:
	/* asr_s r2,r2,0x2 */
	.byte 0x42,0xba
L_8d580e:
	neg_s r0,r2
	.global L_8d5810
L_8d5810:
	cmp_s r1,0x0
L_8d5812:
	add.ge r1,r1,0x2
L_8d5816:
	asr.ge r1,r1,0x2
L_8d581a:
	bge_s L_8d5824
L_8d581c:
	rsub r2,r1,0x2
L_8d5820:
	/* asr_s r2,r2,0x2 */
	.byte 0x42,0xba
L_8d5822:
	neg_s r1,r2
	.global L_8d5824
L_8d5824:
	bl L_8d6490
L_8d5828:
	bl.d L_8d6dcc
L_8d582c:
	mov_s r1,0x10
L_8d582e:
	brlt r0,0x0,L_8d5838
L_8d5832:
	add_s r13,r13,r0
L_8d5834:
	asr_s r13,r13,0x10
L_8d5836:
	b_s L_8d583e
	.global L_8d5838
L_8d5838:
	sub_s r13,r13,r0
L_8d583a:
	asr_s r13,r13,0x10
L_8d583c:
	neg_s r13,r13
	.global L_8d583e
L_8d583e:
	ld_s r15,[sp,0x10]
L_8d5840:
	sexb_s r13,r13
L_8d5842:
	sub_s r15,r15,r13
L_8d5844:
	sexb_s r15,r15
L_8d5846:
	abs_s r0,r15
L_8d5848:
	extb r18,r0
L_8d584c:
	ld_s r0,[sp,0x14]
L_8d584e:
	brge.d r0,r18,L_8d5896
L_8d5852:
	lsr r1,r15,0x1f
	.global L_8d5856
L_8d5856:
	mov r21,0x0
L_8d585a:
	b_s L_8d5978
	.global L_8d585c
L_8d585c:
	bl.d L_8d2630
L_8d5860:
	mov_s r0,0x0
L_8d5862:
	bl.d L_8d219c
L_8d5866:
	mov_s r0,0x1
L_8d5868:
	mov_s r0,0xf0
L_8d586a:
	mov lp_count,r0
L_8d586e:
	nop_s
L_8d5870:
	lp L_8d5878
L_8d5874:
	nop_s
L_8d5876:
	nop_s
	.global L_8d5878
L_8d5878:
	bl.d L_8d6064
L_8d587c:
	mov_s r0,0x4
L_8d587e:
	ld_s r15,[sp,0x10]
L_8d5880:
	mov_s r17,r0
L_8d5882:
	sub_s r15,r15,r0
L_8d5884:
	sexb_s r15,r15
L_8d5886:
	abs_s r0,r15
L_8d5888:
	extb r18,r0
L_8d588c:
	ld_s r0,[sp,0x14]
L_8d588e:
	brlt.d r0,r18,L_8d5856
L_8d5892:
	lsr r1,r15,0x1f
	.global L_8d5896
L_8d5896:
	mov r21,0x1
L_8d589a:
	b_s L_8d5978
	.global L_8d589c
L_8d589c:
	bl.d L_8d2630
L_8d58a0:
	mov_s r0,0x2
L_8d58a2:
	bl.d L_8d219c
L_8d58a6:
	mov_s r0,0x1
L_8d58a8:
	bl L_8d2ae4
L_8d58ac:
	mov_s r0,0x3
L_8d58ae:
	mov r1,0x1ef
L_8d58b2:
	mov_s r2,0xa
L_8d58b4:
	bl.d L_8d2f88
L_8d58b8:
	mov r3,0x4d2
L_8d58bc:
	mov r0,0x140
L_8d58c0:
	mov lp_count,r0
L_8d58c4:
	nop_s
L_8d58c6:
	lp L_8d58ce
L_8d58ca:
	nop_s
L_8d58cc:
	nop_s
	.global L_8d58ce
L_8d58ce:
	bl L_8d3024
L_8d58d2:
	mov r0,0x140
L_8d58d6:
	mov lp_count,r0
L_8d58da:
	nop_s
L_8d58dc:
	lp L_8d58e4
L_8d58e0:
	nop_s
L_8d58e2:
	nop_s
	.global L_8d58e4
L_8d58e4:
	bl.d L_8d219c
L_8d58e8:
	mov_s r0,0x0
L_8d58ea:
	bl L_8d2b00
L_8d58ee:
	bl.d L_8d25e8
L_8d58f2:
	add_s r0,sp,0x34
L_8d58f4:
	bl L_8d2ae4
L_8d58f8:
	mov_s r0,0x883700
L_8d58fe:
	ld_s r0,[r0,0x8]
L_8d5900:
	mov_s r1,0x7
L_8d5902:
	bmsk_s r0,r0,0x5
L_8d5904:
	st_s r0,[sp,0x30]
L_8d5906:
	ldw r0,[sp, 0x48]
L_8d590a:
	mov_s r2,0xa
L_8d590c:
	st_s r0,[sp,0x2c]
L_8d590e:
	mov_s r0,0xffff
L_8d5914:
	bl.d L_8d2f88
L_8d5918:
	mov r3,0x4d2
L_8d591c:
	bl.d L_8d2630
L_8d5920:
	mov_s r0,0x0
L_8d5922:
	bl.d L_8d219c
L_8d5926:
	mov_s r0,0x1
L_8d5928:
	mov_s r0,0xa0
L_8d592a:
	mov lp_count,r0
L_8d592e:
	nop_s
L_8d5930:
	lp L_8d5938
L_8d5934:
	nop_s
L_8d5936:
	nop_s
	.global L_8d5938
L_8d5938:
	bl.d L_8d6064
L_8d593c:
	mov_s r0,0x4
L_8d593e:
	mov_s r17,r0
L_8d5940:
	mov_s r0,0x1
L_8d5942:
	mov_s r1,0xa
L_8d5944:
	mov_s r2,r0
L_8d5946:
	bl.d L_8d2f88
L_8d594a:
	mov_s r3,0x64
L_8d594c:
	bl L_8d3024
L_8d5950:
	ld_s r15,[sp,0x10]
L_8d5952:
	sub r15,r15,r17
L_8d5956:
	sexb_s r15,r15
L_8d5958:
	abs_s r0,r15
L_8d595a:
	extb r18,r0
L_8d595e:
	ld_s r0,[sp,0x48]
L_8d5960:
	lsr r1,r15,0x1f
L_8d5964:
	breq r0,0x3,L_8d596c
	.global L_8d5968
L_8d5968:
	mov_s r0,0x0
L_8d596a:
	b_s L_8d5974
	.global L_8d596c
L_8d596c:
	ld_s r0,[sp,0x14]
L_8d596e:
	brlt r0,r18,L_8d5968
L_8d5972:
	mov_s r0,0x1
	.global L_8d5974
L_8d5974:
	extb r21,r0
	.global L_8d5978
L_8d5978:
	brne r21,0x1,L_8d59b2
	.global L_8d597c
L_8d597c:
	brne r21,0x0,L_8d5988
L_8d5980:
	ld_s r0,[sp,0x28]
L_8d5982:
	cmp_s r0,0x7
L_8d5984:
	blt L_8d5740
	.global L_8d5988
L_8d5988:
	ld_s r0,[sp,0x8]
L_8d598a:
	cmp r0,0xff
L_8d598e:
	bne_s L_8d5b02
L_8d5990:
	ld_s r0,[sp,0x0]
L_8d5992:
	cmp_s r0,0x1
L_8d5994:
	mov.eq r0,0xffff
L_8d599c:
	mov.eq r1,0xa
L_8d59a0:
	mov.eq r3,0x4d2
L_8d59a8:
	bl.eq.d L_8d2f88
L_8d59ac:
	mov.eq r2,r1
L_8d59b0:
	b_s L_8d5b32
	.global L_8d59b2
L_8d59b2:
	brne r21,0x0,L_8d59bc
L_8d59b6:
	ld_s r0,[sp,0x28]
L_8d59b8:
	breq r0,0x7,L_8d59c8
	.global L_8d59bc
L_8d59bc:
	ld_s r0,[sp,0x8]
L_8d59be:
	cmp_s r0,0x3
L_8d59c0:
	beq_s L_8d5aa4
L_8d59c2:
	bgt_s L_8d59de
L_8d59c4:
	breq_s r0,0,L_8d59e8
L_8d59c6:
	b_s L_8d5af4
	.global L_8d59c8
L_8d59c8:
	ld_s r3,[sp,0x30]
L_8d59ca:
	mov_s r1,0x101cc2c
L_8d59d0:
	mov_s r0,0x16
L_8d59d2:
	mov_s r2,r17
L_8d59d4:
	bl.d L_8dcd00
L_8d59d8:
	ld r4,[sp, 0x28]
L_8d59dc:
	b_s L_8d597c
	.global L_8d59de
L_8d59de:
	breq r0,0x6,L_8d59ee
L_8d59e2:
	cmp r0,0xff
L_8d59e6:
	bne_s L_8d5af4
	.global L_8d59e8
L_8d59e8:
	mov r21,0x1
L_8d59ec:
	b_s L_8d597c
	.global L_8d59ee
L_8d59ee:
	brne r23,0x1,L_8d5a6a
L_8d59f2:
	ld_s r0,[sp,0x24]
L_8d59f4:
	brlt r0,r18,L_8d5a00
L_8d59f8:
	ld_s r0,[sp,0x20]
L_8d59fa:
	neg_s r0,r0
L_8d59fc:
	brne r15,r0,L_8d5a6a
	.global L_8d5a00
L_8d5a00:
	add1 r0,r19,r19
L_8d5a04:
	add r17,r0,0x80197c
L_8d5a0c:
	mov_s r0,r16
L_8d5a0e:
	mov r21,0x1
L_8d5a12:
	mov_s r1,r21
L_8d5a14:
	bl.d L_8cfcb4
L_8d5a18:
	ldb r2,[r17]
L_8d5a1c:
	mov_s r0,r16
L_8d5a1e:
	mov_s r1,0x2
L_8d5a20:
	bl.d L_8cfcb4
L_8d5a24:
	ldb r2,[r17, 0x1]
L_8d5a28:
	mov_s r0,r16
L_8d5a2a:
	mov_s r1,0x3
L_8d5a2c:
	bl.d L_8cfcb4
L_8d5a30:
	ldb r2,[r17, 0x2]
L_8d5a34:
	mov_s r0,r22
L_8d5a36:
	mov_s r1,r21
L_8d5a38:
	bl.d L_8cf0f8
L_8d5a3c:
	ldb r2,[r17]
L_8d5a40:
	mov_s r0,r22
L_8d5a42:
	mov_s r1,0x2
L_8d5a44:
	bl.d L_8cf0f8
L_8d5a48:
	ldb r2,[r17, 0x1]
L_8d5a4c:
	mov_s r0,r22
L_8d5a4e:
	mov_s r1,0x3
L_8d5a50:
	bl.d L_8cf0f8
L_8d5a54:
	ldb r2,[r17, 0x2]
L_8d5a58:
	bl.d L_8ce5e8
L_8d5a5c:
	mov_s r0,0x0
L_8d5a5e:
	bl.d L_8ce5e8
L_8d5a62:
	mov_s r0,r21
L_8d5a64:
	mov r20,r19
L_8d5a68:
	b_s L_8d5a98
	.global L_8d5a6a
L_8d5a6a:
	lsr r0,r23
L_8d5a6e:
	max r0,r0,0x1
L_8d5a72:
	extb r23,r0
L_8d5a76:
	brne_s r1,0,L_8d5a82
L_8d5a78:
	add r0,r23,r20
L_8d5a7c:
	min r0,r0,0xf
L_8d5a80:
	b_s L_8d5a8c
	.global L_8d5a82
L_8d5a82:
	sub r0,r20,r23
L_8d5a86:
	sexb_s r0,r0
L_8d5a88:
	max r0,r0,0x1
	.global L_8d5a8c
L_8d5a8c:
	extb_s r0,r0
L_8d5a8e:
	mov r19,r20
L_8d5a92:
	mov r25,r17
L_8d5a96:
	mov_s r20,r0
	.global L_8d5a98
L_8d5a98:
	st_s r15,[sp,0x20]
L_8d5a9a:
	st r18,[sp, 0x24]
L_8d5a9e:
	mov r17,r25
L_8d5aa2:
	b_s L_8d597c
	.global L_8d5aa4
L_8d5aa4:
	mov_s r0,r15
L_8d5aa6:
	bl.d L_8d561c
L_8d5aaa:
	mov_s r1,r14
L_8d5aac:
	ldb r24,[r14, 0x2]
L_8d5ab0:
	ldb_s r0,[r14,0x4]
L_8d5ab2:
	brhs.d r24,0x13,L_8d5ad8
L_8d5ab6:
	st_s r0,[sp,0xc]
	.global L_8d5ab8
L_8d5ab8:
	ld_s r0,[sp,0xc]
L_8d5aba:
	brhs r0,0x12,L_8d5ae6
	.global L_8d5abe
L_8d5abe:
	mov_s r0,0x801954
L_8d5ac4:
	ldb r0,[r0,r24]
L_8d5ac8:
	mov_s r1,0x801968
L_8d5ace:
	st_s r0,[sp,0x18]
L_8d5ad0:
	ld_s r0,[sp,0xc]
L_8d5ad2:
	ldb_s r0,[r1,r0]
L_8d5ad4:
	st_s r0,[sp,0x1c]
L_8d5ad6:
	b_s L_8d597c
	.global L_8d5ad8
L_8d5ad8:
	mov_s r0,blink
L_8d5ada:
	mov_s r1,0x1529
L_8d5ae0:
	bl L_8c9b28
L_8d5ae4:
	b_s L_8d5ab8
	.global L_8d5ae6
L_8d5ae6:
	mov_s r0,blink
L_8d5ae8:
	mov_s r1,0x1553
L_8d5aee:
	bl L_8c9b28
L_8d5af2:
	b_s L_8d5abe
	.global L_8d5af4
L_8d5af4:
	mov_s r0,blink
L_8d5af6:
	mov_s r1,0x130b
	.global L_8d5afc
L_8d5afc:
	bl L_8c9b28
L_8d5b00:
	b_s L_8d597c
	.global L_8d5b02
L_8d5b02:
	bl.d L_8d219c
L_8d5b06:
	mov_s r0,0x0
L_8d5b08:
	bl.d L_8d3100
L_8d5b0c:
	mov_s r0,0x0
L_8d5b0e:
	ld_s r0,[sp,0x0]
L_8d5b10:
	brne r0,0x1,L_8d5b2c
L_8d5b14:
	ld_s r0,[sp,0x4]
L_8d5b16:
	brne r0,0x1,L_8d5b2c
L_8d5b1a:
	mov_s r0,0x2
L_8d5b1c:
	mov_s r1,0xa
L_8d5b1e:
	mov_s r2,r1
L_8d5b20:
	bl.d L_8d2f88
L_8d5b24:
	mov r3,0x4d2
L_8d5b28:
	bl L_8d3024
	.global L_8d5b2c
L_8d5b2c:
	bl.d L_8d21d0
L_8d5b30:
	mov_s r0,0x0
	.global L_8d5b32
L_8d5b32:
	ld_s r0,[sp,0x30]
L_8d5b34:
	stb r17,[r14, 0x9]
L_8d5b38:
	stb_s r0,[r14,0xa]
L_8d5b3a:
	ld_s r0,[sp,0x2c]
L_8d5b3c:
	stb_s r13,[r14,0x8]
L_8d5b3e:
	stw_s r0,[r14,0xc]
L_8d5b40:
	ld_s r0,[sp,0x18]
L_8d5b42:
	stb r24,[r14, 0x2]
L_8d5b46:
	stb_s r0,[r14,0x3]
L_8d5b48:
	ld_s r0,[sp,0xc]
L_8d5b4a:
	stb r20,[r14, 0x6]
L_8d5b4e:
	stb_s r0,[r14,0x4]
L_8d5b50:
	ld_s r0,[sp,0x1c]
L_8d5b52:
	stb r23,[r14, 0x7]
L_8d5b56:
	stb_s r0,[r14,0x5]
L_8d5b58:
	ld_s r0,[sp,0x28]
L_8d5b5a:
	stb_s r0,[r14,0x10]
L_8d5b5c:
	b.d L_8c01fc
L_8d5b60:
	add_s sp,sp,0x6c
L_8d5b62:
	nop_s
