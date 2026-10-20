/* power_mgr_ut__dispatch @ 0x8e8774, 296 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mgr_ut, ps_cfg__apply_profile_0, ps_cfg__apply_profile_1, sys_state__broadcast
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal, power_mngr__recalc_aw, power_mngr__set_ps_ctx_d90, power_mngr__set_ps_ctx_da0, ps_cfg__clear_ps_flags, ps_cfg__set_ps_flags, stats_timer_exp
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mgr_ut__dispatch
power_mgr_ut__dispatch:
	.global L_8e8774
L_8e8774:
	push_s blink
L_8e8776:
	bl L_8c01d4
L_8e877a:
	mov_s r14,r0
L_8e877c:
	mov_s r17,r1
L_8e877e:
	mov_s r16,r2
L_8e8780:
	mov_s r18,r3
L_8e8782:
	mov_s r13,0x0
L_8e8784:
	brhs.d r0,0x19,L_8e880a
L_8e8788:
	ld.as r15,[gp,-0x19]
L_8e878c:
	ldb.x r10,[0x801bb4,r14]
L_8e8794:
	add r0,pcl,0xa
L_8e8798:
	add1 r0,r0,r10
L_8e879c:
	j_s [r0]
	.global L_8e879e
L_8e879e:
	mov_s r1,r13
L_8e87a0:
	b_s L_8e8818
L_8e87a2:
	cmp r17,0x0
L_8e87a6:
	mov_s r14,0x8
L_8e87a8:
	bl.ne.d L_8e0288
L_8e87ac:
	mov.ne r0,0x1
L_8e87b0:
	cmp r17,0x1
L_8e87b4:
	cmp.eq r16,0x0
L_8e87b8:
	bne_s L_8e8814
L_8e87ba:
	mov_s r15,0x803d30
L_8e87c0:
	bl L_8e6798
L_8e87c4:
	b_s L_8e8814
	.global L_8e87c6
L_8e87c6:
	mov_s r1,0x1
L_8e87c8:
	b_s L_8e8818
L_8e87ca:
	mov_s r15,0x803d18
L_8e87d0:
	bl L_8e678c
L_8e87d4:
	b_s L_8e879e
L_8e87d6:
	bl.d L_8c8fc0
L_8e87da:
	mov_s r14,0x17
L_8e87dc:
	bl.d L_8c8a34
L_8e87e0:
	mov_s r0,r13
L_8e87e2:
	b_s L_8e87c6
L_8e87e4:
	bl.d L_8c9944
L_8e87e8:
	mov_s r14,0x18
L_8e87ea:
	b_s L_8e879e
L_8e87ec:
	ld_s r0,[gp,-0x50]
L_8e87ee:
	st_s r13,[r0]
L_8e87f0:
	bl.d L_8c8a34
L_8e87f4:
	mov_s r0,r13
L_8e87f6:
	mov_s r14,0x11
L_8e87f8:
	b_s L_8e879e
L_8e87fa:
	mov_s r14,0x12
L_8e87fc:
	mov_s r1,0x1
L_8e87fe:
	ld_s r0,[gp,-0x50]
L_8e8800:
	st_s r1,[r0]
L_8e8802:
	b_s L_8e879e
L_8e8804:
	mov_s r1,r13
L_8e8806:
	mov_s r13,0x1
L_8e8808:
	b_s L_8e8818
	.global L_8e880a
L_8e880a:
	mov_s r0,blink
L_8e880c:
	mov_s r1,0x21
L_8e880e:
	bl.d L_8c9b28
L_8e8812:
	asl_s r1,r1,0x8
	.global L_8e8814
L_8e8814:
	mov_s r1,0x0
L_8e8816:
	mov_s r13,r1
	.global L_8e8818
L_8e8818:
	brne_s r13,0,L_8e8834
L_8e881a:
	ld_s r0,[gp,-0x50]
L_8e881c:
	ld_s r0,[r0]
L_8e881e:
	breq_s r0,0,L_8e8822
L_8e8820:
	breq_s r1,0,L_8e8828
	.global L_8e8822
L_8e8822:
	ld_s r0,[r15,0x8]
L_8e8824:
	ld_s r1,[r0,0x10]
L_8e8826:
	b_s L_8e882c
	.global L_8e8828
L_8e8828:
	ld_s r0,[r15,0x8]
L_8e882a:
	ld_s r1,[r0,0xc]
	.global L_8e882c
L_8e882c:
	jl_s.d [r1]
L_8e882e:
	mov_s r0,r15
L_8e8830:
	st.as r15,[gp,-0x19]
	.global L_8e8834
L_8e8834:
	/* sub_s r14,r14,0x6 */
	.byte 0x66,0xbe
L_8e8836:
	brhs r14,0x13,L_8e8860
L_8e883a:
	ldb.x r14,[0x801bd0,r14]
L_8e8842:
	add r0,pcl,0xa
L_8e8846:
	add1_s r0,r0,r14
L_8e8848:
	j_s [r0]
L_8e884a:
	ld_s r0,[gp,-0x64]
L_8e884c:
	ld_s r1,[r0,0x8]
L_8e884e:
	ld_s r3,[r1,0x8]
L_8e8850:
	mov_s r1,0x1
	.global L_8e8852
L_8e8852:
	jl_s.d [r3]
L_8e8854:
	mov_s r2,r18
L_8e8856:
	b_s L_8e8860
	.global L_8e8858
L_8e8858:
	cmp r16,0x0
L_8e885c:
	bl.ne L_8e16d8
	.global L_8e8860
L_8e8860:
	b L_8c0234
L_8e8864:
	ld_s r0,[gp,-0x64]
L_8e8866:
	ld_s r1,[r0,0x8]
L_8e8868:
	ld_s r3,[r1,0x8]
L_8e886a:
	mov_s r1,0x0
L_8e886c:
	jl_s.d [r3]
L_8e886e:
	mov_s r2,r18
L_8e8870:
	b_s L_8e8858
L_8e8872:
	ld_s r0,[gp,-0x64]
L_8e8874:
	ld_s r1,[r0,0x8]
L_8e8876:
	ld_s r3,[r1,0x8]
L_8e8878:
	mov_s r1,0x3
L_8e887a:
	b_s L_8e8852
L_8e887c:
	ld_s r0,[gp,-0x64]
L_8e887e:
	ld_s r1,[r0,0x8]
L_8e8880:
	ld_s r3,[r1,0x8]
L_8e8882:
	mov_s r1,0x4
L_8e8884:
	b_s L_8e8852
L_8e8886:
	ld_s r0,[gp,-0x64]
L_8e8888:
	ld_s r1,[r0,0x8]
L_8e888a:
	ld_s r3,[r1,0x8]
L_8e888c:
	mov_s r1,0x6
L_8e888e:
	b_s L_8e8852
L_8e8890:
	ld_s r0,[gp,-0x64]
L_8e8892:
	ld_s r1,[r0,0x8]
L_8e8894:
	ld_s r3,[r1,0x8]
L_8e8896:
	mov_s r1,0x7
L_8e8898:
	b_s L_8e8852
L_8e889a:
	nop_s
