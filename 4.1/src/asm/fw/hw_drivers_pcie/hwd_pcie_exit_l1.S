/* hwd_pcie_exit_l1 @ 0x8ce578, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   hwd_pcie_exit_l1: PERST ASSERTED !!!
 *   hw_drivers_pcie.c
 * Зовут его: hwd_dma__kick_channel, hwd_pcie__set_low_power, isr_pcie_main, pcie__force_clear_l0s, pcie__l1_sub_timing_setup, pcie__set_event_bit, sm_pring__timeout
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, get_reg8825bc_bit3_inv, hwd_pcie__get_882b80, hwd_pcie__is_l1_state
 */
	.section .text.hwd_pcie_exit_l1,"ax",@progbits
	.global hwd_pcie_exit_l1
hwd_pcie_exit_l1:
	.global L_8ce578
L_8ce578:
	push_s blink
L_8ce57a:
	bl L_8c02c0
L_8ce57e:
	bl.d L_8ce774
L_8ce582:
	mov_s r13,r0
L_8ce584:
	mov_s r15,r0
L_8ce586:
	brne r13,0x0,L_8ce5e0
L_8ce58a:
	mov_s r0,0x50
L_8ce58c:
	mov lp_count,r0
L_8ce590:
	nop_s
L_8ce592:
	lp L_8ce59a
L_8ce596:
	nop_s
L_8ce598:
	nop_s
	.global L_8ce59a
L_8ce59a:
	mov_s r2,0x1e8480
	.global L_8ce5a0
L_8ce5a0:
	/* bl.d 0x008ce310 */
	.byte 0x72,0x0d,0xef,0xff
L_8ce5a4:
	/* _sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8ce5a6:
	bl.d L_8ce72c
L_8ce5aa:
	mov_s r1,r0
L_8ce5ac:
	mov_s r14,r0
L_8ce5ae:
	cmp_s r1,0x0
L_8ce5b0:
	cmp.eq r14,0x1
L_8ce5b4:
	bne_s L_8ce5b8
L_8ce5b6:
	brne_s r2,0,L_8ce5a0
	.global L_8ce5b8
L_8ce5b8:
	cmp_s r1,0x0
L_8ce5ba:
	cmp.eq r14,0x1
L_8ce5be:
	bne_s L_8ce5d0
L_8ce5c0:
	mov_s r3,blink
L_8ce5c2:
	mov_s r2,0x1018a44
L_8ce5c8:
	mov_s r0,0x0
L_8ce5ca:
	bl.d L_8edfcc
L_8ce5ce:
	mov_s r1,r0
	.global L_8ce5d0
L_8ce5d0:
	brne_s r14,0,L_8ce5e0
L_8ce5d2:
	mov_s r2,0x1018a74
L_8ce5d8:
	mov_s r0,0x1
L_8ce5da:
	bl.d L_8edfb0
L_8ce5de:
	mov_s r1,r0
	.global L_8ce5e0
L_8ce5e0:
	bclr r14,r13,0x0
L_8ce5e4:
	breq_s r15,0,L_8ce60e
L_8ce5e6:
	brne_s r14,0,L_8ce5fa
	.global L_8ce5e8
L_8ce5e8:
	mov_s r1,0x882500
L_8ce5ee:
	ld_s r0,[r1,0x54]
L_8ce5f0:
	/* asl_s r13,r13,0x3 */
	.byte 0x03,0xbd
L_8ce5f2:
	bclr_s r0,r0,0x3
L_8ce5f4:
	or_s r13,r13,r0
L_8ce5f6:
	st_s r13,[r1,0x54]
L_8ce5f8:
	b_s L_8ce67a
	.global L_8ce5fa
L_8ce5fa:
	mov_s r0,blink
L_8ce5fc:
	mov_s r2,0x1018a0c
L_8ce602:
	mov_s r1,0xac
L_8ce604:
	bl.d L_8c82c0
L_8ce608:
	mov r3,0x2e2
L_8ce60c:
	b_s L_8ce5e8
	.global L_8ce60e
L_8ce60e:
	breq_s r13,0,L_8ce65a
L_8ce610:
	brne_s r14,0,L_8ce632
	.global L_8ce612
L_8ce612:
	mov_s r15,0x882000
L_8ce618:
	ld_s r0,[r15,0x28]
L_8ce61a:
	asl r1,r13,0x13
L_8ce61e:
	bclr_s r0,r0,0x13
L_8ce620:
	or_s r0,r0,r1
L_8ce622:
	st_s r0,[r15,0x28]
L_8ce624:
	brne_s r14,0,L_8ce646
	.global L_8ce626
L_8ce626:
	ld_s r0,[r15,0x24]
L_8ce628:
	asl_s r13,r13,0x18
L_8ce62a:
	bclr_s r0,r0,0x18
L_8ce62c:
	or_s r13,r13,r0
L_8ce62e:
	st_s r13,[r15,0x24]
L_8ce630:
	b_s L_8ce67a
	.global L_8ce632
L_8ce632:
	mov_s r0,blink
L_8ce634:
	mov_s r2,0x1018a0c
L_8ce63a:
	mov_s r1,0xac
L_8ce63c:
	bl.d L_8c82c0
L_8ce640:
	mov r3,0x2e7
L_8ce644:
	b_s L_8ce612
	.global L_8ce646
L_8ce646:
	mov_s r0,blink
L_8ce648:
	mov_s r2,0x1018a0c
L_8ce64e:
	mov_s r1,0xac
L_8ce650:
	bl.d L_8c82c0
L_8ce654:
	mov r3,0x2e9
L_8ce658:
	b_s L_8ce626
	.global L_8ce65a
L_8ce65a:
	brne_s r14,0,L_8ce67e
	.global L_8ce65c
L_8ce65c:
	mov_s r15,0x882000
L_8ce662:
	ld_s r1,[r15,0x24]
L_8ce664:
	asl r0,r13,0x18
L_8ce668:
	bclr_s r1,r1,0x18
L_8ce66a:
	or_s r0,r0,r1
L_8ce66c:
	st_s r0,[r15,0x24]
L_8ce66e:
	brne_s r14,0,L_8ce692
	.global L_8ce670
L_8ce670:
	ld_s r0,[r15,0x28]
L_8ce672:
	asl_s r13,r13,0x13
L_8ce674:
	bclr_s r0,r0,0x13
L_8ce676:
	or_s r0,r0,r13
L_8ce678:
	st_s r0,[r15,0x28]
	.global L_8ce67a
L_8ce67a:
	b L_8c032c
	.global L_8ce67e
L_8ce67e:
	mov_s r0,blink
L_8ce680:
	mov_s r2,0x1018a0c
L_8ce686:
	mov_s r1,0xac
L_8ce688:
	bl.d L_8c82c0
L_8ce68c:
	mov r3,0x2ec
L_8ce690:
	b_s L_8ce65c
	.global L_8ce692
L_8ce692:
	mov_s r0,blink
L_8ce694:
	mov_s r2,0x1018a0c
L_8ce69a:
	mov_s r1,0xac
L_8ce69c:
	bl.d L_8c82c0
L_8ce6a0:
	mov r3,0x2ee
L_8ce6a4:
	b_s L_8ce670
L_8ce6a6:
	nop_s
