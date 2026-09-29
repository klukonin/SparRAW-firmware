/* fwq_tx__queue_step @ 0x8e5620, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__add_packet, fwq_tx__enable_queue, tx_api__call_vmethod_04
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set32_s0_w4, fw_sysassert_fatal, fwq_tx__bits_set32_s4_w28, list__find_entry_d, llist__pop_front, ps__mark_data_pending
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__queue_step
fwq_tx__queue_step:
	.global L_8e5620
L_8e5620:
	push_s blink
L_8e5622:
	bl L_8c01e0
L_8e5626:
	mov_s r13,r0
L_8e5628:
	mov_s r14,0x0
	.global L_8e562a
L_8e562a:
	ld_s r0,[r13,0x4c]
L_8e562c:
	ld_s r1,[r0,0x8]
L_8e562e:
	jl_s.d [r1]
L_8e5630:
	mov_s r0,r13
L_8e5632:
	mov_s r15,r0
L_8e5634:
	brne r0,0x1,L_8e5672
L_8e5638:
	bl.d L_8e2674
L_8e563c:
	ld_s r0,[r13,0x30]
L_8e563e:
	mov_s r14,r0
L_8e5640:
	add r0,r13,0x34
L_8e5644:
	bl.d L_8c25f4
L_8e5648:
	mov_s r1,r14
L_8e564a:
	ld_s r0,[r13,0x4]
L_8e564c:
	brne r0,0x1,L_8e565a
L_8e5650:
	ldb_s r1,[r14,0xb]
L_8e5652:
	ldb_s r0,[r14,0xa]
L_8e5654:
	bl.d L_8c2a90
L_8e5658:
	bmsk_s r1,r1,0x5
	.global L_8e565a
L_8e565a:
	ld_s r1,[r13]
L_8e565c:
	ld_s r0,[r1,0x4]
L_8e565e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5660:
	st_s r0,[r1,0x4]
L_8e5662:
	ld_s r2,[r14,0x18]
L_8e5664:
	breq_s r2,0,L_8e5670
L_8e5666:
	ld_s r0,[r14,0x1c]
L_8e5668:
	jl_s.d [r2]
L_8e566a:
	mov_s r1,0x1
L_8e566c:
	mov_s r0,0x0
L_8e566e:
	st_s r0,[r14,0x18]
	.global L_8e5670
L_8e5670:
	mov_s r14,0x1
	.global L_8e5672
L_8e5672:
	breq r15,0x1,L_8e562a
L_8e5676:
	b.d L_8c024c
L_8e567a:
	mov_s r0,r14
L_8e567c:
	push_s blink
L_8e567e:
	bl.d L_8c01e0
L_8e5682:
	mov_s r1,0x0
L_8e5684:
	ld_s r2,[r0,0x30]
L_8e5686:
	mov_s r15,r0
L_8e5688:
	ld_s r0,[r2]
L_8e568a:
	sub_s sp,sp,0x18
L_8e568c:
	sub.f r0,r0,0x0
L_8e5690:
	mov.ne r0,0x1
L_8e5694:
	extb.f 0x0,r0
L_8e5698:
	mov.eq r0,r1
L_8e569c:
	beq_s L_8e5720
L_8e569e:
	ld_s r13,[r2,0x4]
L_8e56a0:
	add_s r14,sp,0x8
L_8e56a2:
	breq_s r13,0,L_8e56c8
	.global L_8e56a4
L_8e56a4:
	st_s r13,[r14]
L_8e56a6:
	add_s r13,r13,0x24
L_8e56a8:
	st_s r13,[r14,0x4]
L_8e56aa:
	ld_s r0,[sp,0x8]
L_8e56ac:
	mov_s r3,0x0
L_8e56ae:
	ldw_s r2,[r0,0xc]
L_8e56b0:
	bmsk.f 0x0,r2,0x2
L_8e56b4:
	st_s r3,[sp,0x14]
L_8e56b6:
	beq_s L_8e56e6
L_8e56b8:
	mov_s r1,0x2
L_8e56ba:
	add_s r0,sp,0x14
L_8e56bc:
	bl.d L_8ed370
L_8e56c0:
	btst_s r2,0x0
L_8e56c2:
	beq_s L_8e56d6
L_8e56c4:
	mov_s r1,r3
L_8e56c6:
	b_s L_8e56e2
	.global L_8e56c8
L_8e56c8:
	mov_s r0,blink
L_8e56ca:
	mov_s r1,0x11d6
L_8e56d0:
	bl L_8c9b28
L_8e56d4:
	b_s L_8e56a4
	.global L_8e56d6
L_8e56d6:
	btst_s r2,0x2
L_8e56d8:
	mov.ne r1,0x1
L_8e56dc:
	btst.eq r2,0x1
L_8e56e0:
	beq_s L_8e56e6
	.global L_8e56e2
L_8e56e2:
	bl L_8ed508
	.global L_8e56e6
L_8e56e6:
	ld_s r1,[sp,0x14]
L_8e56e8:
	bbit0 r2,0x3,L_8e56f6
L_8e56ec:
	bmsk_s r1,r1,0x3
L_8e56ee:
	bset_s r1,r1,0x2
L_8e56f0:
	add_s r0,sp,0x14
L_8e56f2:
	bl L_8ed370
	.global L_8e56f6
L_8e56f6:
	ld_s r2,[sp,0x8]
L_8e56f8:
	ld r0,[r15, 0x8c]
L_8e56fc:
	ldb_s r1,[r2,0xa]
L_8e56fe:
	ldb_s r13,[r2,0xb]
L_8e5700:
	st_s r1,[sp,0x0]
L_8e5702:
	ld_s r1,[sp,0x14]
L_8e5704:
	ldb r4,[r2, 0x10]
L_8e5708:
	st_s r1,[sp,0x4]
L_8e570a:
	ld_s r1,[r0]
L_8e570c:
	ldw_s r2,[r2,0x8]
L_8e570e:
	mov_s r3,0x0
L_8e5710:
	ld_s r14,[r1,0x4]
L_8e5712:
	mov_s r5,r3
L_8e5714:
	ld_s r1,[sp,0xc]
L_8e5716:
	mov r6,0x1
L_8e571a:
	jl_s.d [r14]
L_8e571c:
	bmsk r7,r13,0x5
	.global L_8e5720
L_8e5720:
	b.d L_8c024c
L_8e5724:
	add_s sp,sp,0x18
L_8e5726:
	nop_s
