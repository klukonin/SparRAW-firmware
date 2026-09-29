/* txrx_mgr__handle_dma_irq @ 0x8c9604, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_05
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, hwd_dma__uses_rgf_881c00_8d07d4, hwd_dma__uses_rgf_881c00_8d0b44, u_schd__add, vring_hw__read_status_bit
 * Глобалы (через gp): 0x80033c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global txrx_mgr__handle_dma_irq
txrx_mgr__handle_dma_irq:
	.global L_8c9604
L_8c9604:
	push_s blink
L_8c9606:
	bl L_8c01e0
L_8c960a:
	bl L_8d07d4
L_8c960e:
	ld.as r1,[gp,0x6e]
L_8c9612:
	bmsk r15,r0,0xb
L_8c9616:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c9618:
	st.as r1,[gp,0x6e]
L_8c961c:
	lsr r1,r0,0xc
L_8c9620:
	bmsk_s r1,r1,0xb
L_8c9622:
	and.f 0x0,r0,0xf0000000
L_8c962a:
	cmp.eq r1,0x0
L_8c962e:
	bne_s L_8c9664
	.global L_8c9630
L_8c9630:
	mov_s r14,r15
L_8c9632:
	b_s L_8c9648
	.global L_8c9634
L_8c9634:
	mov_s r0,0x29c40
	.global L_8c963a
L_8c963a:
	mov_s r1,r13
L_8c963c:
	mov_s r2,0x0
L_8c963e:
	bl.d L_8c3248
L_8c9642:
	mov_s r3,0x1
L_8c9644:
	bclr r14,r14,r13
	.global L_8c9648
L_8c9648:
	breq_s r14,0,L_8c9672
L_8c964a:
	norm r0,r14
L_8c964e:
	rsub r13,r0,0x1e
L_8c9652:
	bl.d L_8d0798
L_8c9656:
	mov_s r0,r13
L_8c9658:
	brne r0,0x1,L_8c9634
L_8c965c:
	mov_s r0,0x23a0c
L_8c9662:
	b_s L_8c963a
	.global L_8c9664
L_8c9664:
	mov_s r0,blink
L_8c9666:
	mov_s r1,0x1207
L_8c966c:
	bl L_8c9b28
L_8c9670:
	b_s L_8c9630
	.global L_8c9672
L_8c9672:
	mov_s r0,r15
L_8c9674:
	bl.d L_8d0b44
L_8c9678:
	mov_s r1,0x1
L_8c967a:
	b L_8c024c
L_8c967e:
	nop_s
