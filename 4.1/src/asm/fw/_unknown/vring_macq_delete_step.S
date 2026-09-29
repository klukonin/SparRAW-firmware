/* vring_macq_delete_step @ 0x8de670, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__on_macq_delete_ntf
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bf_w_s0_w4, bf_w_s12_w12, bf_w_s16_w4, bf_w_s4_w12, mac_ring_disable, memset0_words, vring_macq_delete__program_ba_win, vring_macq_delete__program_macq
 */
	.section .text.vring_macq_delete_step,"ax",@progbits
	.global vring_macq_delete_step
vring_macq_delete_step:
	.global L_8de670
L_8de670:
	push_s blink
L_8de672:
	bl L_8c02b8
L_8de676:
	mov_s r14,r0
L_8de678:
	mov_s r15,r1
L_8de67a:
	mov_s r13,0x805c0c
L_8de680:
	mov_s r0,r13
L_8de682:
	bl.d L_8e5130
L_8de686:
	ldb_s r1,[r14]
L_8de688:
	ld_s r0,[r13,0x40]
L_8de68a:
	bmsk r17,r0,0x0
L_8de68e:
	lsr_s r0,r0,0x10
L_8de690:
	bmsk r16,r0,0x3
L_8de694:
	add r0,r13,0x10
L_8de698:
	bl.d L_8c1a78
L_8de69c:
	mov_s r1,0x10
L_8de69e:
	add r0,r13,0x20
L_8de6a2:
	bl.d L_8c1a78
L_8de6a6:
	mov_s r1,0x10
L_8de6a8:
	add r0,r13,0x30
L_8de6ac:
	bl.d L_8c1a78
L_8de6b0:
	mov_s r1,0x10
L_8de6b2:
	add3 r0,r13,0x8
L_8de6b6:
	bl.d L_8c1a78
L_8de6ba:
	mov_s r1,0x30
L_8de6bc:
	ld_s r1,[r13,0x40]
L_8de6be:
	bclr_s r1,r1,0x0
L_8de6c0:
	or r0,r17,r1
L_8de6c4:
	st_s r0,[r13,0x40]
L_8de6c6:
	add3 r0,r13,0x8
L_8de6ca:
	mov_s r1,r16
L_8de6cc:
	bl L_8e83cc
L_8de6d0:
	ldw_s r0,[r13,0x6]
L_8de6d2:
	stw_s r0,[r13]
L_8de6d4:
	stw_s r0,[r13,0x2]
L_8de6d6:
	ld_s r0,[r13,0xc]
L_8de6d8:
	lsr_s r0,r0,0x10
L_8de6da:
	bmsk r1,r0,0xb
L_8de6de:
	add r0,r13,0x8
L_8de6e2:
	bl L_8e8378
L_8de6e6:
	stb_s r1,[r13,0xb]
L_8de6e8:
	lsr_s r1,r1,0x8
L_8de6ea:
	add r0,r13,0xc
L_8de6ee:
	bl L_8e8348
L_8de6f2:
	bmsk r1,r15,0xb
L_8de6f6:
	bl L_8e84c8
L_8de6fa:
	mov_s r0,r13
L_8de6fc:
	bl.d L_8e5288
L_8de700:
	ldb_s r1,[r14]
L_8de702:
	ldb_s r0,[r14,0x1]
L_8de704:
	cmp_s r0,0x5
L_8de706:
	cmp.ne r0,0x6
L_8de70a:
	beq_s L_8de712
L_8de70c:
	bl.d L_8e508c
L_8de710:
	ldb_s r0,[r14]
	.global L_8de712
L_8de712:
	mov_s r0,0x1
L_8de714:
	b.d L_8c031c
L_8de718:
	stb_s r0,[r14,0x2]
L_8de71a:
	nop_s
