/* mac_indirect__write_entry @ 0x8c46a4, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__data_port_open, parse_ese, rf_chain_dist_config, rx_chain__configure, rx_chain__configure_b, rx_desc__fill_defaults, rx_macq__program_ba_win, rx_queue__setup_ring, sw_vring__ba_agreed, sw_vring__program_ba_win
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bf_w_s0_w2, bf_w_s2_w2, bf_w_s4_w3, bf_w_s4_w5
 */
	.section .text.mac_indirect__write_entry,"ax",@progbits
	.global mac_indirect__write_entry
mac_indirect__write_entry:
	.global L_8c46a4
L_8c46a4:
	push_s blink
L_8c46a6:
	bl.d L_8c02b8
L_8c46aa:
	mov_s r8,r1
L_8c46ac:
	sub_s sp,sp,0x8
L_8c46ae:
	mov_s r14,r0
L_8c46b0:
	mov_s r1,r2
L_8c46b2:
	mov_s r15,r3
L_8c46b4:
	mov_s r2,r4
L_8c46b6:
	mov_s r13,0x0
L_8c46b8:
	stw r13,[sp, 0x4]
L_8c46bc:
	stw r13,[sp, 0x6]
L_8c46c0:
	bmsk_s r1,r1,0x2
L_8c46c2:
	add_s r0,sp,0x4
L_8c46c4:
	bl.d L_8e84ec
L_8c46c8:
	st_s r13,[sp,0x0]
L_8c46ca:
	bmsk r1,r2,0x1
L_8c46ce:
	bl.d L_8e8330
L_8c46d2:
	mov.f r3,r7
L_8c46d6:
	bmsk r1,r15,0x1
L_8c46da:
	mov_s r0,sp
L_8c46dc:
	bl.d L_8e84a4
L_8c46e0:
	mov r17,r6
L_8c46e4:
	bmsk r1,r8,0x4
L_8c46e8:
	bl L_8e8504
L_8c46ec:
	ldw r0,[sp, 0x4]
L_8c46f0:
	mov_s r2,0x886600
L_8c46f6:
	asl_s r0,r0,0x10
L_8c46f8:
	bset r1,r0,0x1f
L_8c46fc:
	or r0,r5,r1
L_8c4700:
	st_s r0,[r2,0xc]
L_8c4702:
	beq_s L_8c4760
	.global L_8c4704
L_8c4704:
	add r1,r13,r17
L_8c4708:
	bmsk_s r1,r1,0x1
L_8c470a:
	mov_s r0,sp
L_8c470c:
	bl.d L_8e8330
L_8c4710:
	mov_s r16,r3
L_8c4712:
	ld_s r0,[sp,0x0]
L_8c4714:
	cmp_s r15,0x2
L_8c4716:
	st_s r0,[r2,0x10]
L_8c4718:
	mov_s r1,0x1
L_8c471a:
	sub.eq r1,r1,r1
L_8c471e:
	mov_s r0,0x2
L_8c4720:
	add1_s r0,r0,r1
L_8c4722:
	mov_s r1,0x0
L_8c4724:
	cmp_s r0,0x0
L_8c4726:
	mov.hi lp_count,r0
L_8c472a:
	lphi L_8c473e
L_8c472e:
	mov_s r3,0x886614
L_8c4734:
	ld.ab r0,[r14,0x4]
L_8c4738:
	add2_s r3,r3,r1
L_8c473a:
	st_s r0,[r3]
L_8c473c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8c473e
L_8c473e:
	st 0x40000000,[r2, 0x8]
L_8c4746:
	sync
	.global L_8c474a
L_8c474a:
	mov_s r2,0x886600
L_8c4750:
	ld_s r0,[r2,0x8]
L_8c4752:
	bbit1 r0,0x1d,L_8c474a
L_8c4756:
	sub r3,r16,0x1
L_8c475a:
	/* brhs.d r3,0x1,0x008c4704 */
	.byte 0xad,0x0b,0x75,0x80
L_8c475e:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c4760
L_8c4760:
	b.d L_8c031c
L_8c4764:
	add_s sp,sp,0x8
L_8c4766:
	nop_s
