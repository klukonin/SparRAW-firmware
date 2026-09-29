/* hwd_phy_pwr @ 0x9297f0, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hwd_phy_pwr ON: phy_tx_power_ack =%d,phy_rx_power_ack = %d,phy_ldpc_power_ack=%d
 * Зовут его: hw__bring_up_phy_dma
 * Зовёт сам: uc_log__emit3, uc_log__emit_snapshot, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_pwr
hwd_phy_pwr:
	.global L_9297f0
L_9297f0:
	st.a r13,[sp,-0x14]
L_9297f4:
	st blink,[sp, 0x4]
L_9297f8:
	st_s r14,[sp,0x8]
L_9297fa:
	st_s r15,[sp,0xc]
L_9297fc:
	bclr.f r13,r0,0x0
L_929800:
	st r16,[sp, 0x10]
L_929804:
	bne.d L_9298c8
L_929808:
	mov r15,r0
	.global L_92980c
L_92980c:
	brne r13,0x0,L_9298d8
	.global L_929810
L_929810:
	brne r13,0x0,L_9298e8
	.global L_929814
L_929814:
	mov r5,0x881000
L_92981c:
	ld.as r4,[r5,-0xe2]
L_929820:
	asl_s r3,r15
L_929822:
	bclr r4,r4,0x0
L_929826:
	or r4,r4,r15
L_92982a:
	bclr r4,r4,0x1
L_92982e:
	or r3,r3,r4
L_929832:
	bclr_s r3,r3,0x2
L_929834:
	asl_s r2,r15,0x2
L_929836:
	or_s r2,r2,r3
L_929838:
	st.as r2,[r5,-0xe2]
L_92983c:
	mov lp_count,0xc8
L_929840:
	mov 0x0,0x0
L_929844:
	lp L_92986c
L_929848:
	ld.as r16,[r5,-0xe1]
L_92984c:
	bmsk r14,r16,0x0
L_929850:
	lsr r13,r16
L_929854:
	lsr r16,r16,0x2
L_929858:
	bmsk_s r13,r13,0x0
L_92985a:
	bmsk r16,r16,0x0
L_92985e:
	cmp_s r15,r14
L_929860:
	cmp.eq r15,r13
L_929864:
	cmp.eq r15,r16
L_929868:
	beq_s L_92986c
L_92986a:
	nop_s
	.global L_92986c
L_92986c:
	cmp_s r15,r14
L_92986e:
	cmp.eq r15,r13
L_929872:
	cmp.eq r15,r16
L_929876:
	beq_s L_929894
L_929878:
	mov r1,0x10028f4
L_929880:
	bl.d L_92d13c
L_929884:
	mov r0,0x0
L_929888:
	mov_s r0,blink
L_92988a:
	mov_s r1,0x1334
L_929890:
	bl L_926618
	.global L_929894
L_929894:
	cmp_s r15,r14
L_929896:
	cmp.eq r15,r16
L_92989a:
	cmp.eq r15,r13
L_92989e:
	beq_s L_9298b4
L_9298a0:
	mov_s r1,0x1002abc
L_9298a6:
	mov_s r0,0x9
L_9298a8:
	mov_s r2,r14
L_9298aa:
	mov_s r3,r13
L_9298ac:
	bl.d L_92d338
L_9298b0:
	mov r4,r16
	.global L_9298b4
L_9298b4:
	ld blink,[sp, 0x4]
L_9298b8:
	ld_s r14,[sp,0x8]
L_9298ba:
	ld_s r15,[sp,0xc]
L_9298bc:
	ld r16,[sp, 0x10]
L_9298c0:
	j.d [blink]
L_9298c4:
	ld.ab r13,[sp,0x14]
	.global L_9298c8
L_9298c8:
	mov r0,blink
L_9298cc:
	bl.d L_926618
L_9298d0:
	mov r1,0xaf
L_9298d4:
	b L_92980c
	.global L_9298d8
L_9298d8:
	mov r0,blink
L_9298dc:
	bl.d L_926618
L_9298e0:
	mov r1,0xb0
L_9298e4:
	b L_929810
	.global L_9298e8
L_9298e8:
	mov r0,blink
L_9298ec:
	bl.d L_926618
L_9298f0:
	mov r1,0xb1
L_9298f4:
	b_s L_929814
L_9298f6:
	nop_s
