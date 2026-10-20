/* mlme_sm__disconnect_ev_handle_8f26a8 @ 0x8f26a8, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Associate REQ accompanied.
 *   Handle disconnect State %d (reason %d)
 *   Send disassociate to remote!!!
 *   mlme_sm::disconnect_ev_handle()  remove_request 0x%x ,locked: 0x%x
 *   MLME_UNLOCK_RADIO - unlocking radio 0x%x
 *   MLME_UNLOCK_RADIO - remove request 0x%x
 * Зовёт сам: RADIO_MGR__remove_request, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, l2_mgr__is_busy_flag_set, mem_pool__free_thunk, mgmt_pkt__release, mlme_notify, mlme_sm__send_disassoc, radio_mgr__call_method_10
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__disconnect_ev_handle_8f26a8
mlme_sm__disconnect_ev_handle_8f26a8:
	.global L_8f26a8
L_8f26a8:
	push_s blink
L_8f26aa:
	bl L_8c01dc
L_8f26ae:
	mov_s r14,r0
L_8f26b0:
	mov.f r13,r1
L_8f26b4:
	mov_s r16,r2
L_8f26b6:
	mov_s r15,r3
L_8f26b8:
	beq_s L_8f26d2
L_8f26ba:
	mov_s r1,0x1011734
L_8f26c0:
	bl.d L_8dcba8
L_8f26c4:
	mov_s r0,0x2a
L_8f26c6:
	bl.d L_8cb180
L_8f26ca:
	mov_s r0,r13
L_8f26cc:
	bl.d L_8cb15c
L_8f26d0:
	mov_s r0,r13
	.global L_8f26d2
L_8f26d2:
	ldb_s r2,[r14]
L_8f26d4:
	mov_s r1,0x1011750
L_8f26da:
	mov_s r0,0x2a
L_8f26dc:
	bl.d L_8dcc80
L_8f26e0:
	mov_s r3,r16
L_8f26e2:
	ld_s r0,[r14,0xc]
L_8f26e4:
	brne r0,0x1,L_8f271e
L_8f26e8:
	mov_s r0,0x803c20
L_8f26ee:
	ldb_s r0,[r0,0x8]
L_8f26f0:
	breq_s r0,0,L_8f26fe
L_8f26f2:
	brne r0,0x1,L_8f271e
L_8f26f6:
	bl.d L_8c64f4
L_8f26fa:
	mov_s r0,0x5
L_8f26fc:
	brne_s r0,0,L_8f271e
	.global L_8f26fe
L_8f26fe:
	mov_s r1,0x1011778
L_8f2704:
	bl.d L_8dcba8
L_8f2708:
	mov_s r0,0x2a
L_8f270a:
	breq_s r15,0,L_8f2714
L_8f270c:
	ld_s r1,[r14,0x20]
L_8f270e:
	mov_s r0,0x1
L_8f2710:
	st.as r0,[r1,0x52]
	.global L_8f2714
L_8f2714:
	mov_s r0,r14
L_8f2716:
	mov_s r1,r16
L_8f2718:
	bl.d L_8f6bc0
L_8f271c:
	mov_s r2,r15
	.global L_8f271e
L_8f271e:
	ld_s r2,[r14,0x10]
L_8f2720:
	mov_s r1,0x1011798
L_8f2726:
	mov_s r0,0x20
L_8f2728:
	mov_s r13,0x0
L_8f272a:
	st_s r13,[r14,0xc]
L_8f272c:
	bl.d L_8dcc80
L_8f2730:
	ld_s r3,[r14,0x8]
L_8f2732:
	ld_s r2,[r14,0x10]
L_8f2734:
	breq_s r2,0,L_8f2760
L_8f2736:
	ld_s r0,[r14,0x8]
L_8f2738:
	breq_s r0,0,L_8f274e
L_8f273a:
	mov_s r1,0x101159c
L_8f2740:
	bl.d L_8dcc10
L_8f2744:
	mov_s r0,0x2c
L_8f2746:
	bl.d L_8ea800
L_8f274a:
	ld_s r0,[r14,0x10]
L_8f274c:
	b_s L_8f2760
	.global L_8f274e
L_8f274e:
	mov_s r1,0x10115c8
L_8f2754:
	bl.d L_8dcc10
L_8f2758:
	mov_s r0,0x2c
L_8f275a:
	bl.d L_8e2798
L_8f275e:
	ld_s r0,[r14,0x10]
	.global L_8f2760
L_8f2760:
	ld_s r0,[r14,0x14]
L_8f2762:
	st_s r13,[r14,0x10]
L_8f2764:
	st_s r13,[r14,0x8]
L_8f2766:
	breq_s r0,0,L_8f276e
L_8f2768:
	bl L_8c8de0
L_8f276c:
	st_s r13,[r14,0x14]
	.global L_8f276e
L_8f276e:
	ld_s r1,[r14,0x20]
L_8f2770:
	mov_s r0,r14
L_8f2772:
	ldb_s r1,[r1,0x8]
L_8f2774:
	mov_s r2,0x3
L_8f2776:
	mov_s r3,0x1
L_8f2778:
	bl.d L_8de394
L_8f277c:
	mov r4,0x0
L_8f2780:
	ld_s r0,[r14,0x2c]
L_8f2782:
	breq_s r0,0,L_8f278a
L_8f2784:
	bl L_8cb15c
L_8f2788:
	st_s r13,[r14,0x2c]
	.global L_8f278a
L_8f278a:
	b L_8c0244
L_8f278e:
	nop_s
