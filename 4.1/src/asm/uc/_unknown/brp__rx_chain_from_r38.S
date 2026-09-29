/* brp__rx_chain_from_r38 @ 0x9235f0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_flow_step
 */
	.section .text.brp__rx_chain_from_r38,"ax",@progbits
	.global brp__rx_chain_from_r38
brp__rx_chain_from_r38:
	.global L_9235f0
L_9235f0:
	mov_s r0,r38
L_9235f2:
	bbit0 r0,0xb,L_9235fe
L_9235f6:
	lsr r0,r38,0x8
L_9235fa:
	bmsk_s r0,r0,0x2
L_9235fc:
	b_s L_923600
	.global L_9235fe
L_9235fe:
	mov_s r0,0x8
	.global L_923600
L_923600:
	mov_s r1,0x800734
L_923606:
	ldb_s r1,[r1,0x18]
L_923608:
	cmp_s r0,r1
L_92360a:
	mov_s r0,0x0
L_92360c:
	bne_s L_923626
L_92360e:
	mov_s r0,r37
L_923610:
	bbit1 r0,0x10,L_923622
L_923614:
	mov_s r0,r37
L_923616:
	bbit1 r0,0x0,L_923622
L_92361a:
	mov_s r0,r37
L_92361c:
	btst_s r0,0x18
L_92361e:
	mov_s r0,0x0
L_923620:
	beq_s L_923624
	.global L_923622
L_923622:
	mov_s r0,0x1
	.global L_923624
L_923624:
	extb_s r0,r0
	.global L_923626
L_923626:
	j_s [blink]
