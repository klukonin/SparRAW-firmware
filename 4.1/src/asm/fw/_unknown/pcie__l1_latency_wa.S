/* pcie__l1_latency_wa @ 0x8e8648, 532 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Setting L1 enter latency to 16us - EP under switch
 *   Setting L1 enter latency to 16us - EP under serdes
 *   BUG_5663_WA Disabling L0s - EP under switch
 *   BUG_5663_WA Disabling L0s - EP under serdes
 *   Setting low power entrence count to 0x20 - EP under switch
 *   Setting low power entrence count to 0x20 - EP under serdes
 * Зовут его: tail_pcie__l1_latency_wa
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s27_w5, fw_log__emit0, get_reg8825bc_bit3_inv, get_reg_8825c0, hwd_pcie_dbi_write, hwd_pcie_l1_sub_timing_config, pcie__set_l1_bit11, pcie_serdes_step
 */
	.section .text.pcie__l1_latency_wa,"ax",@progbits
	.global pcie__l1_latency_wa
pcie__l1_latency_wa:
	.global L_8e8648
L_8e8648:
	push_s blink
L_8e864a:
	bl L_8c02bc
L_8e864e:
	bl.d L_8ce774
L_8e8652:
	sub_s sp,sp,0x18
L_8e8654:
	bl.d L_8ce720
L_8e8658:
	mov_s r13,r0
L_8e865a:
	lsr_s r0,r0
L_8e865c:
	bmsk_s r0,r0,0x0
L_8e865e:
	or.f 0x0,r0,r13
L_8e8662:
	mov_s r14,0x0
L_8e8664:
	beq_s L_8e86a4
L_8e8666:
	add r16,sp,0x4
L_8e866a:
	mov_s r0,0x40
L_8e866c:
	mov_s r1,r14
L_8e866e:
	mov_s r2,0x1
L_8e8670:
	mov_s r3,r14
L_8e8672:
	mov_s r4,r14
L_8e8674:
	mov_s r5,r2
L_8e8676:
	bl.d L_8eaa64
L_8e867a:
	mov r6,r16
L_8e867e:
	mov_s r0,r16
L_8e8680:
	mov_s r1,r14
L_8e8682:
	bl.d L_8e8474
L_8e8686:
	mov_s r2,r14
L_8e8688:
	st_s r14,[sp,0x0]
L_8e868a:
	mov_s r0,0x40
L_8e868c:
	ld_s r1,[sp,0x4]
L_8e868e:
	mov_s r3,0x1
L_8e8690:
	mov_s r4,r14
L_8e8692:
	mov_s r5,r14
L_8e8694:
	mov r6,0x1
L_8e8698:
	bl.d L_8eab94
L_8e869c:
	mov r7,0x1
L_8e86a0:
	bl L_8ce9ac
	.global L_8e86a4
L_8e86a4:
	mov_s r15,0xc7ffffff
L_8e86aa:
	add r16,sp,0x10
L_8e86ae:
	brne_s r13,0,L_8e86ec
L_8e86b0:
	mov_s r2,0x1001518
L_8e86b6:
	mov_s r0,0x0
L_8e86b8:
	bl.d L_8edfb0
L_8e86bc:
	mov_s r1,0x2
L_8e86be:
	mov r0,0x70c
L_8e86c2:
	mov_s r1,0x0
L_8e86c4:
	mov_s r2,0x0
L_8e86c6:
	mov_s r3,0x0
L_8e86c8:
	mov r4,0x0
L_8e86cc:
	mov r5,0x1
L_8e86d0:
	bl.d L_8eaa64
L_8e86d4:
	mov r6,r16
L_8e86d8:
	ld_s r1,[sp,0x10]
L_8e86da:
	st_s r14,[sp,0x0]
L_8e86dc:
	and_s r1,r1,r15
L_8e86de:
	bset_s r1,r1,0x1d
L_8e86e0:
	st_s r1,[sp,0x10]
L_8e86e2:
	mov r0,0x70c
L_8e86e6:
	mov_s r2,0x0
L_8e86e8:
	mov_s r3,0x0
L_8e86ea:
	b_s L_8e8724
	.global L_8e86ec
L_8e86ec:
	mov_s r2,0x100154c
L_8e86f2:
	mov_s r0,0x0
L_8e86f4:
	bl.d L_8edfb0
L_8e86f8:
	mov_s r1,0x2
L_8e86fa:
	mov r0,0x70c
L_8e86fe:
	mov_s r1,0x0
L_8e8700:
	mov_s r2,0x1
L_8e8702:
	mov_s r3,0x0
L_8e8704:
	mov r4,0x0
L_8e8708:
	mov_s r5,r2
L_8e870a:
	bl.d L_8eaa64
L_8e870e:
	mov r6,r16
L_8e8712:
	ld_s r1,[sp,0x10]
L_8e8714:
	st_s r14,[sp,0x0]
L_8e8716:
	and_s r1,r1,r15
L_8e8718:
	bset_s r1,r1,0x1d
L_8e871a:
	st_s r1,[sp,0x10]
L_8e871c:
	mov r0,0x70c
L_8e8720:
	mov_s r2,0x0
L_8e8722:
	mov_s r3,0x1
	.global L_8e8724
L_8e8724:
	mov r4,0x0
L_8e8728:
	mov r5,r4
L_8e872c:
	mov r6,0x1
L_8e8730:
	bl.d L_8eab94
L_8e8734:
	mov r7,r6
L_8e8738:
	brne_s r13,0,L_8e8778
L_8e873a:
	mov_s r2,0x1001580
L_8e8740:
	mov_s r0,0x0
L_8e8742:
	bl.d L_8edfb0
L_8e8746:
	mov_s r1,0x2
L_8e8748:
	st_s r14,[sp,0x14]
L_8e874a:
	add r16,sp,0x14
L_8e874e:
	mov_s r0,0x7c
L_8e8750:
	mov_s r1,0x0
L_8e8752:
	mov_s r2,0x0
L_8e8754:
	mov_s r3,0x0
L_8e8756:
	mov r4,0x0
L_8e875a:
	mov r5,0x1
L_8e875e:
	bl.d L_8eaa64
L_8e8762:
	mov r6,r16
L_8e8766:
	bl.d L_8f0c30
L_8e876a:
	mov_s r0,r16
L_8e876c:
	ld_s r1,[sp,0x14]
L_8e876e:
	st_s r14,[sp,0x0]
L_8e8770:
	mov_s r0,0x7c
L_8e8772:
	mov_s r2,0x0
L_8e8774:
	mov_s r3,0x0
L_8e8776:
	b_s L_8e87b4
	.global L_8e8778
L_8e8778:
	mov_s r2,0x10015ac
L_8e877e:
	mov_s r0,0x0
L_8e8780:
	bl.d L_8edfb0
L_8e8784:
	mov_s r1,0x2
L_8e8786:
	st_s r14,[sp,0x14]
L_8e8788:
	add r16,sp,0x14
L_8e878c:
	mov_s r0,0x7c
L_8e878e:
	mov_s r1,0x0
L_8e8790:
	mov_s r2,0x1
L_8e8792:
	mov_s r3,0x0
L_8e8794:
	mov r4,0x0
L_8e8798:
	mov r5,0x1
L_8e879c:
	bl.d L_8eaa64
L_8e87a0:
	mov r6,r16
L_8e87a4:
	bl.d L_8f0c30
L_8e87a8:
	mov_s r0,r16
L_8e87aa:
	ld_s r1,[sp,0x14]
L_8e87ac:
	st_s r14,[sp,0x0]
L_8e87ae:
	mov_s r0,0x7c
L_8e87b0:
	mov_s r2,0x0
L_8e87b2:
	mov_s r3,0x1
	.global L_8e87b4
L_8e87b4:
	mov r4,0x0
L_8e87b8:
	mov r5,r4
L_8e87bc:
	mov r6,0x1
L_8e87c0:
	bl.d L_8eab94
L_8e87c4:
	mov r7,r6
L_8e87c8:
	add r16,sp,0x8
L_8e87cc:
	brne_s r13,0,L_8e880a
L_8e87ce:
	mov_s r2,0x10015d8
L_8e87d4:
	mov_s r0,0x0
L_8e87d6:
	bl.d L_8edfb0
L_8e87da:
	mov_s r1,0x2
L_8e87dc:
	mov r0,0x708
L_8e87e0:
	mov_s r1,0x0
L_8e87e2:
	mov_s r2,0x0
L_8e87e4:
	mov_s r3,0x0
L_8e87e6:
	mov r4,0x0
L_8e87ea:
	mov r5,0x1
L_8e87ee:
	bl.d L_8eaa64
L_8e87f2:
	mov r6,r16
L_8e87f6:
	ld_s r1,[sp,0x8]
L_8e87f8:
	st_s r14,[sp,0x0]
L_8e87fa:
	bmsk_s r1,r1,0x17
L_8e87fc:
	bset_s r1,r1,0x1d
L_8e87fe:
	st_s r1,[sp,0x8]
L_8e8800:
	mov r0,0x708
L_8e8804:
	mov_s r2,0x0
L_8e8806:
	mov_s r3,0x0
L_8e8808:
	b_s L_8e8844
	.global L_8e880a
L_8e880a:
	mov_s r2,0x1001614
L_8e8810:
	mov_s r0,0x0
L_8e8812:
	bl.d L_8edfb0
L_8e8816:
	mov_s r1,0x2
L_8e8818:
	mov r0,0x708
L_8e881c:
	mov_s r1,0x0
L_8e881e:
	mov_s r2,0x1
L_8e8820:
	mov_s r3,0x0
L_8e8822:
	mov r4,0x0
L_8e8826:
	mov r5,0x1
L_8e882a:
	bl.d L_8eaa64
L_8e882e:
	mov r6,r16
L_8e8832:
	ld_s r1,[sp,0x8]
L_8e8834:
	st_s r14,[sp,0x0]
L_8e8836:
	bmsk_s r1,r1,0x17
L_8e8838:
	bset_s r1,r1,0x1d
L_8e883a:
	st_s r1,[sp,0x8]
L_8e883c:
	mov r0,0x708
L_8e8840:
	mov_s r2,0x0
L_8e8842:
	mov_s r3,0x1
	.global L_8e8844
L_8e8844:
	mov r4,0x0
L_8e8848:
	mov r5,r4
L_8e884c:
	mov r6,0x1
L_8e8850:
	bl.d L_8eab94
L_8e8854:
	mov r7,r6
L_8e8858:
	b.d L_8c0324
