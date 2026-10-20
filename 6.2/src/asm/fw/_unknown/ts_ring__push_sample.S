/* ts_ring__push_sample @ 0x8dd6d4, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_802f58__on_evt_latency_timer_in_active
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, conn__get_cid_via_field8, ts_ring__time_delta_a_thunk, ts_ring__time_delta_b_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ts_ring__push_sample
ts_ring__push_sample:
	.global L_8dd6d4
L_8dd6d4:
	push_s blink
L_8dd6d6:
	bl L_8c01d8
L_8dd6da:
	mov_s r17,r0
L_8dd6dc:
	mov_s r16,r1
L_8dd6de:
	mov_s r15,0x805260
L_8dd6e4:
	mov_s r14,0x8052e0
L_8dd6ea:
	ldb_s r13,[r14,0x2]
L_8dd6ec:
	bl.d L_8cc3bc
L_8dd6f0:
	bmsk_s r13,r13,0x4
L_8dd6f2:
	add2 r13,r15,r13
L_8dd6f6:
	st_s r0,[r13]
L_8dd6f8:
	bl.d L_8cc3c0
L_8dd6fc:
	mov_s r0,r17
L_8dd6fe:
	mov_s r13,r0
L_8dd700:
	bl.d L_8cbec0
L_8dd704:
	ld r0,[r16, 0x10]
L_8dd708:
	ldb_s r1,[r14,0x1]
L_8dd70a:
	ldb_s r2,[r14,0x2]
L_8dd70c:
	breq r2,r1,L_8dd734
L_8dd710:
	sub r0,r2,r1
L_8dd714:
	extb lp_count,r0
L_8dd718:
	lp L_8dd734
L_8dd71c:
	bmsk r0,r1,0x4
L_8dd720:
	ld.as r3,[r15,r0]
L_8dd724:
	sub r0,r3,r13
L_8dd728:
	bbit1 r0,0x1f,L_8dd730
L_8dd72c:
	brne r13,r3,L_8dd734
	.global L_8dd730
L_8dd730:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8dd732:
	extb_s r1,r1
	.global L_8dd734
L_8dd734:
	sub r0,r2,r1
L_8dd738:
	extb_s r0,r0
L_8dd73a:
	stb_s r0,[r14]
L_8dd73c:
	add_s r0,r2,0x1
L_8dd73e:
	extb_s r0,r0
L_8dd740:
	stb_s r0,[r14,0x2]
L_8dd742:
	sub_s r0,r0,r1
L_8dd744:
	bmsk.f 0x0,r0,0x4
L_8dd748:
	stb_s r1,[r14,0x1]
L_8dd74a:
	bne_s L_8dd752
L_8dd74c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8dd74e:
	extb_s r1,r1
L_8dd750:
	stb_s r1,[r14,0x1]
	.global L_8dd752
L_8dd752:
	b L_8c023c
L_8dd756:
	nop_s
