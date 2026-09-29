/* conn_mgr__allocate_cid_db_element @ 0x8c36c0, 236 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::allocate_cid_db_element() CID %d::::: 0x%x status %d.
 *   No free CID resource found.
 *   Found #%d V-ring to run.
 * Зовут его: conn_mgr__activate_conn
 * Зовёт сам: __ld_r14_to_r13_ret, __ld_r17_to_r13_ret, __st_r14_to_r13, __st_r17_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit3, llist__pop_front, vring_schd__bind_if_free, vring_schd__is_vring_ready
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__allocate_cid_db_element
conn_mgr__allocate_cid_db_element:
	.global L_8c36c0
L_8c36c0:
	push_s blink
L_8c36c2:
	bl.d L_8c01e4
L_8c36c6:
	mov_s r2,r1
L_8c36c8:
	mov_s r13,0x0
L_8c36ca:
	b_s L_8c36ce
	.global L_8c36cc
L_8c36cc:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c36ce
L_8c36ce:
	brhs.d r13,0x8,L_8c3708
L_8c36d2:
	st_s r13,[r2]
L_8c36d4:
	mov_s r3,0x854080
L_8c36da:
	add3 r14,r3,r13
L_8c36de:
	ld_s r1,[r14]
L_8c36e0:
	brne_s r1,0,L_8c36cc
L_8c36e2:
	st_s r0,[r14,0x4]
L_8c36e4:
	ld_s r1,[r2]
L_8c36e6:
	mov_s r13,0x1
L_8c36e8:
	add3 r0,r3,r1
L_8c36ec:
	st_s r13,[r0]
L_8c36ee:
	ld_s r2,[r2]
L_8c36f0:
	mov_s r1,0x100bd90
L_8c36f6:
	add3_s r3,r3,r2
L_8c36f8:
	ld r4,[r3]
L_8c36fc:
	mov_s r0,0x2b
L_8c36fe:
	bl.d L_8dcd00
L_8c3702:
	ld_s r3,[r3,0x4]
L_8c3704:
	mov_s r0,r13
L_8c3706:
	b_s L_8c3716
	.global L_8c3708
L_8c3708:
	mov_s r1,0x100bdd0
L_8c370e:
	bl.d L_8dcba8
L_8c3712:
	mov_s r0,0x1b
L_8c3714:
	mov_s r0,0x0
	.global L_8c3716
L_8c3716:
	b L_8c0254
L_8c371a:
	nop_s
L_8c371c:
	push_s blink
L_8c371e:
	bl L_8c01d8
L_8c3722:
	mov_s r0,0x804e3c
L_8c3728:
	ld_s r2,[r0,0x24]
L_8c372a:
	mov_s r17,r0
L_8c372c:
	bic_s r2,r2,r1
L_8c372e:
	st_s r2,[r0,0x24]
L_8c3730:
	ld_s r0,[r0,0x20]
L_8c3732:
	mov_s r14,0x804dbc
L_8c3738:
	brlo.d r0,0x1,L_8c37a8
L_8c373c:
	mov_s r15,0x0
	.global L_8c373e
L_8c373e:
	mul64 r15,0x3c
L_8c3742:
	add r0,r14,0x28
L_8c3746:
	add r16,r0,mlo
L_8c374a:
	ld r0,[r16, 0x14]
L_8c374e:
	brne_s r0,0,L_8c379e
L_8c3750:
	mov_s r3,0x2
L_8c3752:
	b_s L_8c3766
	.global L_8c3754
L_8c3754:
	asl_s r0,r3,0x2
L_8c3756:
	add1_s r0,r0,r0
L_8c3758:
	add r1,r14,0x10
L_8c375c:
	add r4,r1,r0
L_8c3760:
	ld r13,[r4, 0x4]
L_8c3764:
	brne_s r13,0,L_8c3770
	.global L_8c3766
L_8c3766:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8c3768:
	cmp r3,-0x1
L_8c376c:
	bne_s L_8c3754
L_8c376e:
	b_s L_8c379e
	.global L_8c3770
L_8c3770:
	mov_s r0,r14
L_8c3772:
	bl.d L_8c655c
L_8c3776:
	ldb_s r1,[r13,0xa]
L_8c3778:
	brne_s r0,0,L_8c3766
L_8c377a:
	ldb_s r0,[r13,0x8]
L_8c377c:
	brne r15,r0,L_8c3766
L_8c3780:
	bl.d L_8e2674
L_8c3784:
	mov_s r0,r4
L_8c3786:
	mov_s r1,0x100bbc8
L_8c378c:
	mov_s r0,0x27
L_8c378e:
	bl.d L_8dcc10
L_8c3792:
	ldb_s r2,[r13,0x9]
L_8c3794:
	mov_s r0,r14
L_8c3796:
	mov_s r1,r13
L_8c3798:
	bl.d L_8c7160
L_8c379c:
	mov_s r2,r16
	.global L_8c379e
L_8c379e:
	ld r0,[r17, 0x20]
L_8c37a2:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8c37a4:
	brlo r15,r0,L_8c373e
	.global L_8c37a8
L_8c37a8:
	b L_8c023c
