/* calibrate_baseband_gain @ 0x8c5708, 444 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_silent_rssi_sparrow::calibrate_baseband_gain(): At least one RF module should be attached and enabled rfc_enabled_vec=0x%x, %d,%d
 *   calibrate_baseband_gain: Trigger AGC Calibration, Omni RF (%d) gain == MAX %d [RF mode Diversity]
 *   calibrate_baseband_gain: Trigger AGC Calibration, ALL Omni RFs (0x%x) gain == MIN %d [RF mode Diversity]
 *   calibrate_baseband_gain(): Trigger AGC Calibration, Omni RF 0 gain is %d [RF mode Single]
 * Зовут его: calib_silent_rssi_sparrow__run_calibration_fragment
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bit_iter__has_more, bitmap__alloc_bit, calib_silent_rssi_sparrow__find_agc_start, calib_silent_rssi_sparrow__set_agc_start_val, field_set_0x00__8e5dfc, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, hwd_abif__dvs_rfca_cmd_enable
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calibrate_baseband_gain
calibrate_baseband_gain:
	.global L_8c5708
L_8c5708:
	sub_s sp,sp,0x4
L_8c570a:
	push_s blink
L_8c570c:
	bl L_8c01d0
L_8c5710:
	sub_s sp,sp,0x8
L_8c5712:
	and.f 0x0,r1,0xfff00000
L_8c571a:
	mov_s r13,r0
L_8c571c:
	beq_s L_8c5724
L_8c571e:
	bl L_8e62a4
L_8c5722:
	b_s L_8c5728
	.global L_8c5724
L_8c5724:
	bl L_8e7200
	.global L_8c5728
L_8c5728:
	bl L_8ce9c4
L_8c572c:
	mov_s r18,r0
L_8c572e:
	mov_s r0,0x8042c8
L_8c5734:
	bl.d L_8ccb3c
L_8c5738:
	mov_s r17,r0
L_8c573a:
	mov.f r14,r0
L_8c573e:
	beq_s L_8c57ca
	.global L_8c5740
L_8c5740:
	mov_s r15,sp
L_8c5742:
	mov_s r0,r15
L_8c5744:
	bl.d L_8e5dfc
L_8c5748:
	mov_s r1,r14
L_8c574a:
	b_s L_8c5786
	.global L_8c574c
L_8c574c:
	bl.d L_8df444
L_8c5750:
	mov_s r0,r15
L_8c5752:
	mov_s r16,r0
L_8c5754:
	cmp_s r0,0x8
L_8c5756:
	mov.cc r0,blink
L_8c575a:
	mov.cc r1,0x1487
L_8c5762:
	bl.cc L_8c9b28
L_8c5766:
	mov_s r0,0x0
L_8c5768:
	bset r0,r0,r16
L_8c576c:
	extb_s r0,r0
L_8c576e:
	bl.d L_8ce910
L_8c5772:
	mov_s r1,0x0
L_8c5774:
	mov_s r0,r13
L_8c5776:
	mov_s r1,0x0
L_8c5778:
	mov_s r2,0x2
L_8c577a:
	mov_s r3,r1
L_8c577c:
	mov r4,0x4
L_8c5780:
	bl.d L_8c6c2c
L_8c5784:
	mov_s r5,r1
	.global L_8c5786
L_8c5786:
	bl.d L_8cdcc4
L_8c578a:
	mov_s r0,r15
L_8c578c:
	brne_s r0,0,L_8c574c
L_8c578e:
	mov_s r0,r18
L_8c5790:
	mov_s r1,0x0
L_8c5792:
	bl.d L_8ce910
L_8c5796:
	mov_s r16,r1
L_8c5798:
	add3 r18,r13,0x14
L_8c579c:
	ldb r0,[r18, 0x1c]
L_8c57a0:
	st_s r0,[sp,0x4]
L_8c57a2:
	bl.d L_8ccb3c
L_8c57a6:
	mov_s r0,r17
L_8c57a8:
	mov_s r2,r16
L_8c57aa:
	b_s L_8c57b4
	.global L_8c57ac
L_8c57ac:
	sub_s r1,r0,0x1
L_8c57ae:
	and_s r0,r0,r1
L_8c57b0:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c57b2:
	extw_s r2,r2
	.global L_8c57b4
L_8c57b4:
	brne_s r0,0,L_8c57ac
L_8c57b6:
	ld r0,[r17,0x468]
L_8c57be:
	extb r19,r2
L_8c57c2:
	brne r0,0x3,L_8c57ea
L_8c57c6:
	mov_s r15,0x1
L_8c57c8:
	b_s L_8c587c
	.global L_8c57ca
L_8c57ca:
	mov_s r1,0x10099f0
L_8c57d0:
	mov_s r0,0x0
L_8c57d2:
	mov_s r2,r14
L_8c57d4:
	mov_s r3,r0
L_8c57d6:
	bl.d L_8dcd00
L_8c57da:
	mov_s r4,r0
L_8c57dc:
	mov_s r0,blink
L_8c57de:
	mov_s r1,0x1459
L_8c57e4:
	bl L_8c9b28
L_8c57e8:
	b_s L_8c5740
	.global L_8c57ea
L_8c57ea:
	cmp_s r0,0x2
L_8c57ec:
	cmp.ne r0,0x1
L_8c57f0:
	bne_s L_8c5860
L_8c57f2:
	bl.d L_8ccb3c
L_8c57f6:
	mov_s r0,r17
L_8c57f8:
	mov_s r1,r0
L_8c57fa:
	bl.d L_8e5dfc
L_8c57fe:
	mov_s r0,r15
L_8c5800:
	mov r16,0x0
L_8c5804:
	b_s L_8c581c
	.global L_8c5806
L_8c5806:
	bl.d L_8df444
L_8c580a:
	mov_s r0,r15
L_8c580c:
	mov_s r2,r0
L_8c580e:
	add r0,r13,0x30
L_8c5812:
	ldb_s r0,[r0,r2]
L_8c5814:
	breq r0,0xf,L_8c5828
L_8c5818:
	breq r0,0x1,L_8c5856
	.global L_8c581c
L_8c581c:
	bl.d L_8cdcc4
L_8c5820:
	mov_s r0,r15
L_8c5822:
	brne_s r0,0,L_8c5806
L_8c5824:
	mov_s r15,0x0
L_8c5826:
	b_s L_8c5838
	.global L_8c5828
L_8c5828:
	mov_s r15,0x1
L_8c582a:
	mov_s r1,0x1009a78
L_8c5830:
	mov_s r0,0x26
L_8c5832:
	bl.d L_8dcc80
L_8c5836:
	mov_s r3,0xf
	.global L_8c5838
L_8c5838:
	brne r19,r16,L_8c587c
L_8c583c:
	mov_s r15,0x1
L_8c583e:
	ldb r2,[r17,0x470]
L_8c5846:
	mov_s r1,0x1009adc
L_8c584c:
	mov_s r0,0x26
L_8c584e:
	bl.d L_8dcc80
L_8c5852:
	mov_s r3,r15
L_8c5854:
	b_s L_8c587c
	.global L_8c5856
L_8c5856:
	add r16,r16,0x1
L_8c585a:
	extb r16,r16
L_8c585e:
	b_s L_8c581c
	.global L_8c5860
L_8c5860:
	ldb r2,[r13, 0x30]
L_8c5864:
	cmp_s r2,0x1
L_8c5866:
	cmp.ne r2,0xf
L_8c586a:
	mov_s r15,0x0
L_8c586c:
	bne_s L_8c587c
L_8c586e:
	mov_s r15,0x1
L_8c5870:
	mov_s r1,0x1009b48
L_8c5876:
	bl.d L_8dcc10
L_8c587a:
	mov_s r0,0x26
	.global L_8c587c
L_8c587c:
	cmp_s r15,0x0
L_8c587e:
	mov.eq r15,0x1
L_8c5882:
	beq_s L_8c589a
L_8c5884:
	ldb r1,[r18, 0x14]
L_8c5888:
	add r4,sp,0x4
L_8c588c:
	ldb r2,[r18, 0x1c]
L_8c5890:
	mov_s r0,r13
L_8c5892:
	bl.d L_8ca5e8
L_8c5896:
	mov_s r3,0x1
L_8c5898:
	mov_s r15,r0
	.global L_8c589a
L_8c589a:
	mov_s r2,0x0
L_8c589c:
	b_s L_8c58a6
	.global L_8c589e
L_8c589e:
	sub_s r0,r14,0x1
L_8c58a0:
	and_s r14,r14,r0
L_8c58a2:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c58a4:
	extw_s r2,r2
	.global L_8c58a6
L_8c58a6:
	brne_s r14,0,L_8c589e
L_8c58a8:
	extb_s r2,r2
L_8c58aa:
	mov_s r0,r13
L_8c58ac:
	bl.d L_8ea8d8
L_8c58b0:
	ld_s r1,[sp,0x4]
L_8c58b2:
	ld_s r0,[r13,0x50]
L_8c58b4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c58b6:
	st_s r0,[r13,0x50]
L_8c58b8:
	mov_s r0,r15
L_8c58ba:
	mov_s r12,0x8
L_8c58bc:
	b.d L_8c022e
L_8c58c0:
	add_s sp,sp,0x8
L_8c58c2:
	nop_s
