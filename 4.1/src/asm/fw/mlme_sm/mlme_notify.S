/* mlme_notify @ 0x8da490, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mlme_notify: CID %d protocol_reason %x <mlme_event %x>
 *   mlme_sm.cpp
 * Зовут его: mlme_sm__assoc_reject_ev_handle, mlme_sm__assoc_req_handle, mlme_sm__assoc_resp_event, mlme_sm__assoc_resp_start, mlme_sm__association_timeout_ev_handle, mlme_sm__disconnect_ev_handle, mlme_sm__handle_disassoc
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, conn__disconnect, conn_mgr__by_cid, conn_msm__inject_ntf_assoc_done, conn_sm__inject_event, disconnect_by_peer, fw_log__emit3, fw_sysassert_fatal, mlme__inject_evt4
 */
	.section .text.mlme_notify,"ax",@progbits
	.global mlme_notify
mlme_notify:
	.global L_8da490
L_8da490:
	push_s blink
L_8da492:
	bl.d L_8c02b4
L_8da496:
	mov_s r0,r1
L_8da498:
	mov_s r18,r1
L_8da49a:
	mov_s r17,r2
L_8da49c:
	bl.d L_8c9e44
L_8da4a0:
	mov_s r16,r3
L_8da4a2:
	mov.f r13,r0
L_8da4a6:
	beq_s L_8da4dc
	.global L_8da4a8
L_8da4a8:
	ld_s r14,[r13,0xc]
L_8da4aa:
	breq_s r14,0,L_8da4f4
	.global L_8da4ac
L_8da4ac:
	mov_s r2,0x100f25c
L_8da4b2:
	mov_s r0,0xa
L_8da4b4:
	mov_s r1,0x2
L_8da4b6:
	mov_s r3,r18
L_8da4b8:
	mov r4,r17
L_8da4bc:
	bl.d L_8ee034
L_8da4c0:
	mov r5,r16
L_8da4c4:
	sub r15,r16,0x1
L_8da4c8:
	brhs r15,0x5,L_8da548
L_8da4cc:
	ldb.x r15,[0x802000,r15]
L_8da4d4:
	add r0,pcl,0x8
L_8da4d8:
	add1_s r0,r0,r15
L_8da4da:
	j_s [r0]
	.global L_8da4dc
L_8da4dc:
	mov_s r0,blink
L_8da4de:
	mov_s r2,0x100f220
L_8da4e4:
	mov_s r1,0x1203
L_8da4ea:
	bl.d L_8c82c0
L_8da4ee:
	mov r3,0x480
L_8da4f2:
	b_s L_8da4a8
	.global L_8da4f4
L_8da4f4:
	mov_s r0,blink
L_8da4f6:
	mov_s r2,0x100f220
L_8da4fc:
	mov_s r1,0x1204
L_8da502:
	bl.d L_8c82c0
L_8da506:
	mov r3,0x482
L_8da50a:
	b_s L_8da4ac
L_8da50c:
	ldb_s r0,[r14,0x10]
L_8da50e:
	mov_s r1,r13
L_8da510:
	mov_s r2,0x0
L_8da512:
	bl.d L_8eb22c
L_8da516:
	mov_s r3,r17
L_8da518:
	mov_s r0,r13
L_8da51a:
	mov_s r1,0x0
L_8da51c:
	b_s L_8da522
L_8da51e:
	mov_s r0,r13
L_8da520:
	mov_s r1,0x6
	.global L_8da522
L_8da522:
	bl.d L_8eb190
L_8da526:
	mov_s r2,r17
L_8da528:
	b_s L_8da548
L_8da52a:
	bl.d L_8da480
L_8da52e:
	mov_s r0,r13
L_8da530:
	b_s L_8da548
L_8da532:
	bl.d L_8da460
L_8da536:
	mov_s r0,r13
L_8da538:
	b_s L_8da548
L_8da53a:
	mov_s r0,r13
L_8da53c:
	mov_s r1,0x2
L_8da53e:
	mov_s r2,0x0
L_8da540:
	mov_s r3,r2
L_8da542:
	bl.d L_8d6b78
L_8da546:
	mov_s r4,r2
	.global L_8da548
L_8da548:
	b.d L_8c0314
