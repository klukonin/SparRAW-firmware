/* l2_mgr__scan_complete_handle @ 0x8e45fc, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::scan_complete_handle()
 *   l2_mgr::scan_complete_handle allow_cids for MID#%d (cids=0x%x)
 *   channels_switch_sm::scan_rm_lock_timeout_cb()
 *   channels_switch_sm::scan_wd_timeout_cb()
 * Зовут его: scan_mngr__scan_done
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__handle_event, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, mid_list__by_mid_fw, mid_list__find_by_kind
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__scan_complete_handle
l2_mgr__scan_complete_handle:
	.global L_8e45fc
L_8e45fc:
	push_s blink
L_8e45fe:
	bl L_8c01d8
L_8e4602:
	sub_s sp,sp,0x4
L_8e4604:
	bl.d L_8cc484
L_8e4608:
	mov_s r16,r1
L_8e460a:
	mov_s r17,r0
L_8e460c:
	mov_s r1,0x100f844
L_8e4612:
	bl.d L_8dcba8
L_8e4616:
	mov_s r0,0x29
L_8e4618:
	mov_s r15,sp
L_8e461a:
	mov_s r0,r15
L_8e461c:
	bl.d L_8e5dfc
L_8e4620:
	mov_s r1,r17
L_8e4622:
	b_s L_8e463e
	.global L_8e4624
L_8e4624:
	bl.d L_8df444
L_8e4628:
	mov_s r0,r15
L_8e462a:
	bl L_8cc3dc
L_8e462e:
	mov.f r13,r0
L_8e4632:
	beq_s L_8e465a
	.global L_8e4634
L_8e4634:
	mov_s r0,r13
L_8e4636:
	bl.d L_8cc424
L_8e463a:
	mov_s r1,0x1
L_8e463c:
	brne_s r0,0,L_8e4668
	.global L_8e463e
L_8e463e:
	bl.d L_8cdcc4
L_8e4642:
	mov_s r0,r15
L_8e4644:
	brne_s r0,0,L_8e4624
L_8e4646:
	cmp r16,0x0
L_8e464a:
	mov.ne r0,0x3
L_8e464e:
	bl.ne.d L_8e8a14
L_8e4652:
	sub_s.ne r1,r1,r1
L_8e4654:
	b.d L_8c023c
L_8e4658:
	add_s sp,sp,0x4
	.global L_8e465a
L_8e465a:
	mov_s r0,blink
L_8e465c:
	mov_s r1,0x16c4
L_8e4662:
	bl L_8c9b28
L_8e4666:
	b_s L_8e4634
	.global L_8e4668
L_8e4668:
	cmp r16,0x0
L_8e466c:
	bl.ne.d L_8e2cbc
L_8e4670:
	add3.ne r0,r0,0xe
L_8e4674:
	ldb r14,[r13, 0x24]
L_8e4678:
	mov_s r1,0x100f864
L_8e467e:
	ldb_s r2,[r13,0x10]
L_8e4680:
	mov_s r0,0x29
L_8e4682:
	bl.d L_8dcc80
L_8e4686:
	mov_s r3,r14
L_8e4688:
	bl L_8cd080
L_8e468c:
	ld_s r1,[r0]
L_8e468e:
	ld_s r2,[r1,0x20]
L_8e4690:
	jl_s.d [r2]
L_8e4692:
	mov_s r1,r14
L_8e4694:
	b_s L_8e463e
L_8e4696:
	nop_s
L_8e4698:
	push_s blink
L_8e469a:
	push_s r13
L_8e469c:
	mov_s r13,r0
L_8e469e:
	mov_s r1,0x1017634
L_8e46a4:
	bl.d L_8dcba8
L_8e46a8:
	mov_s r0,0x19
L_8e46aa:
	mov_s r2,0x0
L_8e46ac:
	st_s r2,[r13,0x10]
L_8e46ae:
	mov_s r0,r13
L_8e46b0:
	mov_s r1,0x7
L_8e46b2:
	mov_s r3,r2
L_8e46b4:
	bl.d L_8d9b6c
L_8e46b8:
	mov_s r4,r2
L_8e46ba:
	b L_8c025c
L_8e46be:
	nop_s
L_8e46c0:
	push_s blink
L_8e46c2:
	push_s r13
L_8e46c4:
	mov_s r13,r0
L_8e46c6:
	mov_s r1,0x1017664
L_8e46cc:
	bl.d L_8dcba8
L_8e46d0:
	mov_s r0,0x19
L_8e46d2:
	mov_s r2,0x0
L_8e46d4:
	st_s r2,[r13,0x18]
L_8e46d6:
	mov_s r0,r13
L_8e46d8:
	mov_s r1,0x7
L_8e46da:
	mov_s r3,r2
L_8e46dc:
	bl.d L_8d9b6c
L_8e46e0:
	mov_s r4,r2
L_8e46e2:
	b L_8c025c
L_8e46e6:
	nop_s
L_8e46e8:
	mov_s r1,r0
L_8e46ea:
	ld_s r0,[gp,-0x40]
L_8e46ec:
	ld_s r2,[r0]
L_8e46ee:
	ld_s r2,[r2,0x24]
L_8e46f0:
	j_s [r2]
L_8e46f2:
	nop_s
