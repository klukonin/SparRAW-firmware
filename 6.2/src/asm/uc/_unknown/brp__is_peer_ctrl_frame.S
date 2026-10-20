/* brp__is_peer_ctrl_frame @ 0x9232d4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_responder_flow_enter
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__is_peer_ctrl_frame
brp__is_peer_ctrl_frame:
	.global L_9232d4
L_9232d4:
	mov_s r0,r38
L_9232d6:
	bbit0 r0,0xb,L_9232e2
L_9232da:
	lsr r0,r38,0x8
L_9232de:
	bmsk_s r0,r0,0x2
L_9232e0:
	b_s L_9232e4
	.global L_9232e2
L_9232e2:
	mov_s r0,0x8
	.global L_9232e4
L_9232e4:
	mov_s r1,0x800864
L_9232ea:
	ldb_s r1,[r1,0x18]
L_9232ec:
	cmp_s r0,r1
L_9232ee:
	mov_s r0,0x0
L_9232f0:
	bne_s L_923310
L_9232f2:
	mov_s r0,r37
L_9232f4:
	bbit1 r0,0x10,L_92330c
L_9232f8:
	mov_s r0,r37
L_9232fa:
	bbit1 r0,0x0,L_92330c
L_9232fe:
	mov_s r0,r37
L_923300:
	bbit1 r0,0xa,L_92330c
L_923304:
	mov_s r0,r37
L_923306:
	btst_s r0,0x18
L_923308:
	mov_s r0,0x0
L_92330a:
	beq_s L_92330e
	.global L_92330c
L_92330c:
	mov_s r0,0x1
	.global L_92330e
L_92330e:
	extb_s r0,r0
	.global L_923310
L_923310:
	j_s [blink]
L_923312:
	nop_s
