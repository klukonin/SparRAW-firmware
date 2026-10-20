/* mlme_notify @ 0x8de394, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mlme_notify: CID %d protocol_reason %x <mlme_event %x>
 * Зовут его: mlme_sm_802458__action_8f0f4c, mlme_sm_802458__action_8f102c, mlme_sm_802458__action_8f1080, mlme_sm_802458__action_8f20bc, mlme_sm_802458__action_8f2444, mlme_sm__assoc_reject_ev_handle, mlme_sm__association_timeout_ev_handle, mlme_sm__data_port_open_ev_handle, mlme_sm__disconnect_ev_handle_8f26a8
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_sm__handle_event__r1_4_r2_0, conn__disconnect, conn__sm_handle_event, conn_mgr__by_cid, disconnect_by_peer, fw_log_emit3, fw_sysassert_fatal, wmi__host_cmd_at_124
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_notify
mlme_notify:
	.global L_8de394
L_8de394:
	push_s blink
L_8de396:
	bl.d L_8c01d4
L_8de39a:
	mov_s r0,r1
L_8de39c:
	mov_s r18,r1
L_8de39e:
	mov_s r17,r2
L_8de3a0:
	bl.d L_8cbffc
L_8de3a4:
	mov_s r16,r3
L_8de3a6:
	mov.f r13,r0
L_8de3aa:
	beq_s L_8de3dc
	.global L_8de3ac
L_8de3ac:
	ld_s r14,[r13,0x18]
L_8de3ae:
	breq_s r14,0,L_8de3ea
	.global L_8de3b0
L_8de3b0:
	mov_s r1,0x1011378
L_8de3b6:
	mov_s r0,0x2a
L_8de3b8:
	mov_s r2,r18
L_8de3ba:
	mov_s r3,r17
L_8de3bc:
	bl.d L_8dcd00
L_8de3c0:
	mov r4,r16
L_8de3c4:
	sub r15,r16,0x1
L_8de3c8:
	brhs r15,0x5,L_8de434
L_8de3cc:
	ldb.x r15,[0x80254c,r15]
L_8de3d4:
	add r0,pcl,0x8
L_8de3d8:
	add1_s r0,r0,r15
L_8de3da:
	j_s [r0]
	.global L_8de3dc
L_8de3dc:
	mov_s r0,blink
L_8de3de:
	mov_s r1,0x1203
L_8de3e4:
	bl L_8c9b28
L_8de3e8:
	b_s L_8de3ac
	.global L_8de3ea
L_8de3ea:
	mov_s r0,blink
L_8de3ec:
	mov_s r1,0x1204
L_8de3f2:
	bl L_8c9b28
L_8de3f6:
	b_s L_8de3b0
L_8de3f8:
	ldb_s r0,[r14,0x10]
L_8de3fa:
	mov_s r1,r13
L_8de3fc:
	mov_s r2,0x0
L_8de3fe:
	bl.d L_8f2584
L_8de402:
	mov_s r3,r17
L_8de404:
	mov_s r0,r13
L_8de406:
	mov_s r1,0x0
L_8de408:
	b_s L_8de40e
L_8de40a:
	mov_s r0,r13
L_8de40c:
	mov_s r1,0x6
	.global L_8de40e
L_8de40e:
	bl.d L_8f2540
L_8de412:
	mov_s r2,r17
L_8de414:
	b_s L_8de434
L_8de416:
	bl.d L_8de384
L_8de41a:
	mov_s r0,r13
L_8de41c:
	b_s L_8de434
L_8de41e:
	bl.d L_8de364
L_8de422:
	mov_s r0,r13
L_8de424:
	b_s L_8de434
L_8de426:
	mov_s r0,r13
L_8de428:
	mov_s r1,0x2
L_8de42a:
	mov_s r2,0x0
L_8de42c:
	mov_s r3,r2
L_8de42e:
	bl.d L_8d9cc0
L_8de432:
	mov_s r4,r2
	.global L_8de434
L_8de434:
	b.d L_8c0234
L_8de438:
	mov_s r0,0x0
L_8de43a:
	nop_s
