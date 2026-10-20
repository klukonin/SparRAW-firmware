/* deep_sleep_enter @ 0x8c87c0, 480 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   deep_sleep_enter: No L1 exit interrupt When: LTSSM State 0x%x, L1SS state: 0x%x, AUX_CLK_IS_SYS_CLK: %d
 * Зовут его: u_schd__run
 * Зовёт сам: POWER_MNGR__halt, __ld_r17_to_r13_ret, __st_r17_to_r13, deep_sleep__host_evt_mbox_pending, evt_ring__push_1c, fw_log_emit3, hwd_pcie__get_882b80, hwd_pcie__get_882fd4_bit19, hwd_pcie__get_88b0c0_state4, hwd_pcie__get_ltssm_state, hwd_pcie__set_low_power, hwd_pcie_ltssm_is_l1_idle
 * Глобалы (через gp): 0x800420, 0x800490, 0x800494
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global deep_sleep_enter
deep_sleep_enter:
	.global L_8c87c0
L_8c87c0:
	push_s blink
L_8c87c2:
	bl L_8c01d8
L_8c87c6:
	sub_s sp,sp,0x10
L_8c87c8:
	mov_s r15,sp
L_8c87ca:
	mov_s r14,0x0
L_8c87cc:
	mov_s r0,r14
L_8c87ce:
	mov_s r1,r15
L_8c87d0:
	bl.d L_8e9900
L_8c87d4:
	mov_s r2,r14
L_8c87d6:
	bl L_8cc1fc
L_8c87da:
	mov_s r13,r0
L_8c87dc:
	ld_s r0,[gp,-0x64]
L_8c87de:
	ld_s r1,[r0,0x8]
L_8c87e0:
	ld_s r1,[r1,0x28]
L_8c87e2:
	jl_s [r1]
L_8c87e4:
	mov_s r16,r0
L_8c87e6:
	ld_s r0,[gp,-0x64]
L_8c87e8:
	ld_s r1,[r0,0x8]
L_8c87ea:
	ld_s r1,[r1,0x18]
L_8c87ec:
	jl_s [r1]
L_8c87ee:
	breq_s r0,0,L_8c87f6
L_8c87f0:
	bl L_8d160c
L_8c87f4:
	b_s L_8c8998
	.global L_8c87f6
L_8c87f6:
	ld_s r0,[gp,-0x64]
L_8c87f8:
	ld_s r1,[r0,0x8]
L_8c87fa:
	ld_s r1,[r1,0x14]
L_8c87fc:
	jl_s [r1]
L_8c87fe:
	breq_s r0,0,L_8c8804
L_8c8800:
	breq r16,0x0,L_8c880e
	.global L_8c8804
L_8c8804:
	st.as r14,[gp,-0xe]
L_8c8808:
	st.as r14,[gp,-0xf]
L_8c880c:
	b_s L_8c8998
	.global L_8c880e
L_8c880e:
	ld_s r0,[r13]
L_8c8810:
	bbit1 r0,0xc,L_8c8862
L_8c8814:
	bl L_8da608
L_8c8818:
	ld.as r1,[gp,-0xe]
L_8c881c:
	breq_s r0,0,L_8c883c
L_8c881e:
	ld_s r0,[gp,0x310]
L_8c8820:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c8822:
	st.as r14,[gp,-0xf]
L_8c8826:
	brhs.d r1,r0,L_8c8862
L_8c882a:
	st.as r1,[gp,-0xe]
L_8c882e:
	mov_s r0,0xa
L_8c8830:
	mov r1,0x3eb
	.global L_8c8834
L_8c8834:
	bl.d L_8e0b2c
L_8c8838:
	ld_s r2,[sp,0x0]
L_8c883a:
	b_s L_8c8998
	.global L_8c883c
L_8c883c:
	ld.as r2,[gp,-0xf]
L_8c8840:
	cmp_s r1,0x0
L_8c8842:
	cmp.eq r2,0x0
L_8c8846:
	beq_s L_8c8862
L_8c8848:
	st.as r14,[gp,-0xe]
L_8c884c:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c884e:
	ld_s r0,[gp,0x30c]
L_8c8850:
	st.as r2,[gp,-0xf]
L_8c8854:
	cmp_s r2,r0
L_8c8856:
	mov.cs r1,0x3ec
L_8c885e:
	mov_s r0,0xa
L_8c8860:
	blo_s L_8c8834
	.global L_8c8862
L_8c8862:
	st.as r14,[gp,-0xe]
L_8c8866:
	st.as r14,[gp,-0xf]
L_8c886a:
	ld_s r0,[r13]
L_8c886c:
	bbit0 r0,0xc,L_8c88c0
L_8c8870:
	ld_s r0,[gp,-0x64]
L_8c8872:
	ld_s r2,[r0,0x8]
L_8c8874:
	ld_s r2,[r2,0x24]
L_8c8876:
	jl_s.d [r2]
L_8c8878:
	add_s r1,sp,0x8
L_8c887a:
	mov_s r0,0x0
L_8c887c:
	mov_s r1,r15
L_8c887e:
	bl.d L_8e9900
L_8c8882:
	mov_s r2,r0
L_8c8884:
	ld_s r3,[sp,0x0]
L_8c8886:
	ld_s r1,[sp,0x8]
L_8c8888:
	sub.f r14,r3,r1
L_8c888c:
	ld_s r0,[sp,0x4]
L_8c888e:
	ld_s r2,[sp,0xc]
L_8c8890:
	sbc r0,r0,r2
L_8c8894:
	cmp_s r0,0x80000000
L_8c889a:
	cmp.eq r14,0x0
L_8c889e:
	bcs L_8c8998
L_8c88a2:
	ld_s r0,[gp,-0x7c]
L_8c88a4:
	sub r14,r1,r3
L_8c88a8:
	ldw_s r3,[r0]
L_8c88aa:
	ld_s r0,[gp,0x29c]
L_8c88ac:
	add_s r3,r3,r0
L_8c88ae:
	brlo r14,r3,L_8c8998
L_8c88b2:
	sub.f r1,r1,r0
L_8c88b6:
	mov_s r3,0x0
L_8c88b8:
	sbc r2,r2,r3
L_8c88bc:
	st_s r1,[sp,0x8]
L_8c88be:
	st_s r2,[sp,0xc]
	.global L_8c88c0
L_8c88c0:
	lr r15,[0xa]
L_8c88c4:
	bic r0,r15,0x6
L_8c88c8:
	flag r0
L_8c88cc:
	bl L_8d1088
L_8c88d0:
	brne r0,0x1,L_8c898a
L_8c88d4:
	ld_s r0,[r13,0x4]
L_8c88d6:
	bbit0 r0,0x2,L_8c88e6
L_8c88da:
	ld_s r0,[r13]
L_8c88dc:
	btst_s r0,0x5
L_8c88de:
	bl.ne.d L_8d77dc
L_8c88e2:
	mov.ne r0,0x1
	.global L_8c88e6
L_8c88e6:
	bl L_8d15a4
L_8c88ea:
	bl L_8d160c
L_8c88ee:
	ld_s r1,[r13]
L_8c88f0:
	ld_s r2,[sp,0x8]
L_8c88f2:
	bbit0 r1,0xc,L_8c890c
L_8c88f6:
	ld_s r0,[gp,-0xac]
L_8c88f8:
	cmp_s r0,0x0
L_8c88fa:
	btst.ne r1,0x8
L_8c88fe:
	bne_s L_8c890c
L_8c8900:
	mov_s r0,r2
L_8c8902:
	bl.d L_8e9a48
L_8c8906:
	ld_s r1,[sp,0xc]
L_8c8908:
	bl L_8e9a78
	.global L_8c890c
L_8c890c:
	mov_s r14,0x803d10
L_8c8912:
	ld_s r0,[r14,0x38]
L_8c8914:
	ld_s r1,[sp,0x8]
L_8c8916:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c8918:
	st_s r0,[r14,0x38]
L_8c891a:
	mov_s r0,0xa
L_8c891c:
	bl.d L_8e0b2c
L_8c8920:
	ld_s r2,[sp,0x0]
L_8c8922:
	bl L_8d13ec
L_8c8926:
	brne r0,0x5,L_8c8930
L_8c892a:
	ld_s r0,[r14,0x3c]
L_8c892c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c892e:
	st_s r0,[r14,0x3c]
	.global L_8c8930
L_8c8930:
	bl L_8d1428
L_8c8934:
	brne_s r0,0,L_8c893c
L_8c8936:
	ld_s r0,[r14,0x40]
L_8c8938:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c893a:
	st_s r0,[r14,0x40]
	.global L_8c893c
L_8c893c:
	ld_s r0,[r13]
L_8c893e:
	ld_s r1,[sp,0x8]
L_8c8940:
	lsr_s r0,r0,0xb
L_8c8942:
	bmsk_s r0,r0,0x0
L_8c8944:
	bl.d L_8c89a0
L_8c8948:
	ld_s r2,[sp,0xc]
L_8c894a:
	bl L_8d1070
L_8c894e:
	brne_s r0,0,L_8c898a
L_8c8950:
	bl L_8d1428
L_8c8954:
	brne r0,0x1,L_8c898a
L_8c8958:
	bl L_8d163c
L_8c895c:
	brne_s r0,0,L_8c8986
L_8c895e:
	bl L_8d13fc
L_8c8962:
	bl.d L_8d13ec
L_8c8966:
	mov_s r17,r0
L_8c8968:
	bl.d L_8d1070
L_8c896c:
	mov_s r16,r0
L_8c896e:
	mov_s r4,r0
L_8c8970:
	mov_s r1,0x1001f10
L_8c8976:
	mov_s r0,0xe
L_8c8978:
	mov_s r2,r17
L_8c897a:
	bl.d L_8dcd00
L_8c897e:
	mov_s r3,r16
L_8c8980:
	ld_s r0,[r14,0x48]
L_8c8982:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c8984:
	st_s r0,[r14,0x48]
	.global L_8c8986
L_8c8986:
	bl L_8d161c
	.global L_8c898a
L_8c898a:
	lr r0,[0xa]
L_8c898e:
	bic r15,r15,-0x7
L_8c8992:
	or_s r0,r0,r15
L_8c8994:
	flag r0
	.global L_8c8998
L_8c8998:
	b.d L_8c023c
L_8c899c:
	add_s sp,sp,0x10
L_8c899e:
	nop_s
