/* mlme_sm__disconnect_ev_handle @ 0x8f25c8, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   L2MGR - CID %d disconnect done (reason = %d).
 *   L2MGR align PN# while disconnection CID %d!!!
 * Зовут его: WBE_DRIVER__link_down_notif
 * Зовёт сам: RADIO_MGR__unset_primary_channel, __ld_r18_to_r13_ret, __st_r18_to_r13, cnt_handler__clear_all, conn__alloc_and_link__thunk_0_1_0, conn_mgr__link_down_evt, dashboard__on_disconnect, fw_log_emit1, fw_log_emit2, fw_status__set_state, fw_sysassert_fatal, l2_mgr__chk_sys_idle
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__disconnect_ev_handle
mlme_sm__disconnect_ev_handle:
	.global L_8f25c8
L_8f25c8:
	push_s blink
L_8f25ca:
	bl L_8c01d4
L_8f25ce:
	mov_s r14,r0
L_8f25d0:
	mov_s r15,r1
L_8f25d2:
	ldb r16,[r0, 0x8]
L_8f25d6:
	ld_s r0,[r0,0x18]
L_8f25d8:
	extb_s r13,r1
L_8f25da:
	ldb_s r0,[r0,0x10]
L_8f25dc:
	bl.d L_8cc3dc
L_8f25e0:
	mov_s r17,r0
L_8f25e2:
	breq_s r0,0,L_8f2644
	.global L_8f25e4
L_8f25e4:
	ldb_s r2,[r14,0x8]
L_8f25e6:
	mov_s r1,0x100d304
L_8f25ec:
	mov_s r0,0x2b
L_8f25ee:
	bl.d L_8dcc80
L_8f25f2:
	mov_s r3,r13
L_8f25f4:
	cmp_s r13,0x1
L_8f25f6:
	bl.eq L_8f2250
L_8f25fa:
	ldb_s r1,[r14,0x8]
L_8f25fc:
	mov_s r0,0x0
L_8f25fe:
	bset r0,r0,r1
L_8f2602:
	bl.d L_8cd080
L_8f2606:
	extb r18,r0
L_8f260a:
	ld_s r1,[r0]
L_8f260c:
	ld_s r2,[r1,0x20]
L_8f260e:
	jl_s.d [r2]
L_8f2610:
	mov_s r1,r18
L_8f2612:
	mov_s r1,0x100d334
L_8f2618:
	mov_s r0,0x2b
L_8f261a:
	bl.d L_8dcc10
L_8f261e:
	ldb_s r2,[r14,0x8]
L_8f2620:
	ldb_s r0,[r14,0x8]
L_8f2622:
	mov_s r1,0x0
L_8f2624:
	bl.d L_8ea360
L_8f2628:
	mov_s r2,r1
L_8f262a:
	ld_s r0,[r14,0x18]
L_8f262c:
	bl.d L_8cc424
L_8f2630:
	mov_s r1,0x1
L_8f2632:
	cmp_s r0,0x0
L_8f2634:
	bl.eq L_8da730
L_8f2638:
	ld_s r0,[r14,0x28]
L_8f263a:
	breq_s r0,0,L_8f2652
L_8f263c:
	bl.d L_8f89ec
L_8f2640:
	mov_s r0,r14
L_8f2642:
	b_s L_8f2664
	.global L_8f2644
L_8f2644:
	mov_s r0,blink
L_8f2646:
	mov_s r1,0x16c1
L_8f264c:
	bl L_8c9b28
L_8f2650:
	b_s L_8f25e4
	.global L_8f2652
L_8f2652:
	add r0,r14,0x1c
L_8f2656:
	ld_s r3,[r14,0x18]
L_8f2658:
	lsr r1,r15,0x10
L_8f265c:
	mov_s r2,r13
L_8f265e:
	bl.d L_8e538c
L_8f2662:
	ldb_s r3,[r3,0x10]
	.global L_8f2664
L_8f2664:
	bl L_8f6424
L_8f2668:
	bl.d L_8daae8
L_8f266c:
	mov_s r0,r14
L_8f266e:
	bl.d L_8e8634
L_8f2672:
	mov_s r0,0x4
L_8f2674:
	bl.d L_8da488
L_8f2678:
	mov_s r0,r17
L_8f267a:
	brne_s r0,0,L_8f2684
L_8f267c:
	ld_s r0,[r14,0x28]
L_8f267e:
	cmp_s r0,0x0
L_8f2680:
	bl.eq L_8ea87c
	.global L_8f2684
L_8f2684:
	bl.d L_8e9110
L_8f2688:
	mov_s r0,0x0
L_8f268a:
	bl.d L_8eab88
L_8f268e:
	mov_s r0,r16
L_8f2690:
	bl L_8c6508
L_8f2694:
	ld_s r0,[r14,0x28]
L_8f2696:
	cmp_s r0,0x0
L_8f2698:
	mov.eq r0,0x8
L_8f269c:
	bl.eq.d L_8e8a14
L_8f26a0:
	mov.eq r1,r16
L_8f26a4:
	b L_8c0234
