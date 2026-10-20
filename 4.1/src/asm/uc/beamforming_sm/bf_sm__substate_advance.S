/* bf_sm__substate_advance @ 0x922654, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bf_pending__set_bit, bf_sm__advance_if_slot33, bf_sm__assert_and_clear, bf_sm__reset_sta_rate, bf_sm__substate_result_by_slot, bf_state__set, bf_substate_sm__is_state_9_11, bf_substate_sm__step, mid_vring_mask_update
 */
	.section .text.bf_sm__substate_advance,"ax",@progbits
	.global bf_sm__substate_advance
bf_sm__substate_advance:
L_922654:
	mov_s r0,0x0
L_922656:
	/* b_s 0x00922726 */
	.byte 0x69,0xf0
L_922658:
	mov_s r0,r14
L_92265a:
	bl.d L_9221bc
L_92265e:
	mov_s r1,0x0
L_922660:
	mov_s r0,0x3
L_922662:
	bl.d L_928cb4
L_922666:
	mov_s r1,r14
L_922668:
	mov_s r0,r14
L_92266a:
	bl.d L_9283c8
L_92266e:
	mov_s r1,0x3
L_922670:
	mov_s r0,0x5
L_922672:
	stb_s r0,[r13,0x9]
L_922674:
	/* b_s 0x00922712 */
	.byte 0x4f,0xf0
L_922676:
	bl.d L_935dd4
L_92267a:
	mov_s r0,r14
L_92267c:
	breq_s r0,0,L_9226ba
L_92267e:
	breq r0,0x2,L_9226b2
L_922682:
	brne r0,0x1,L_9226ba
L_922686:
	b_s L_922698
L_922688:
	bl.d L_93635c
L_92268c:
	mov_s r0,r14
L_92268e:
	breq_s r0,0,L_9226ba
L_922690:
	breq r0,0x2,L_9226b2
L_922694:
	brne r0,0x1,L_9226ae
	.global L_922698
L_922698:
	mov_s r0,0x801034
L_92269e:
	ldb_s r0,[r0]
L_9226a0:
	btst r0,r14
L_9226a4:
	mov_s r0,r14
L_9226a6:
	mov_s r1,0x9
L_9226a8:
	mov.eq r1,0xd
L_9226ac:
	b_s L_9226b6
	.global L_9226ae
L_9226ae:
	brne r0,0x3,L_9226ba
	.global L_9226b2
L_9226b2:
	mov_s r0,r14
L_9226b4:
	mov_s r1,0xb
	.global L_9226b6
L_9226b6:
	bl L_9283c8
	.global L_9226ba
L_9226ba:
	bl.d L_921f58
L_9226be:
	mov_s r0,0x0
L_9226c0:
	/* b_s 0x00922824 */
	.byte 0xb2,0xf0
L_9226c2:
	mov_s r0,r14
L_9226c4:
	bl.d L_9221bc
L_9226c8:
	mov_s r1,0x0
L_9226ca:
	mov_s r0,r14
L_9226cc:
	mov_s r1,0x9
L_9226ce:
	b_s L_9226e6
L_9226d0:
	bl.d L_922c88
L_9226d4:
	mov_s r0,r14
L_9226d6:
	cmp_s r0,0x0
L_9226d8:
	/* beq_s 0x00922824 */
	.byte 0xa6,0xf2
L_9226da:
	breq r0,0x2,L_9226f6
L_9226de:
	/* brne r0,0x1,0x00922712 */
	.byte 0x37,0x08,0x51,0x00
	.global L_9226e2
L_9226e2:
	mov_s r0,r14
L_9226e4:
	mov_s r1,0xd
	.global L_9226e6
L_9226e6:
	bl L_9283c8
L_9226ea:
	/* b_s 0x00922712 */
	.byte 0x15,0xf0
L_9226ec:
	bl.d L_923388
L_9226f0:
	mov_s r0,r14
L_9226f2:
	brne r0,0x2,L_9226fc
	.global L_9226f6
L_9226f6:
	mov_s r0,r14
L_9226f8:
	mov_s r1,0xe
L_9226fa:
	b_s L_9226e6
	.global L_9226fc
L_9226fc:
	breq r0,0x1,L_9226e2
