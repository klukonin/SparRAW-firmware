/* l2mgr__send_disconnect_evt @ 0x8e538c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_DISCONNECT_EVENTID wmi reason %d, protocol reason %d
 * Зовут его: host_if__connect_rf_kill, l2_mgr__wmi_cmd_handler_del_sta, l2_mgr__wmi_cmd_handler_new_sta, l2mgr__disconnect_sta, mlme_sm_802458__action_8c7de0, mlme_sm_802458__action_8c7e88, mlme_sm__disconnect_ev_handle, wmi_connect
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit2, host_if__send_pair, l2mgr__pending_op_clear, low_sme__send_evt2sw, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_disconnect_evt
l2mgr__send_disconnect_evt:
	.global L_8e538c
L_8e538c:
	push_s blink
L_8e538e:
	bl L_8c01d8
L_8e5392:
	mov_s r17,r0
L_8e5394:
	mov_s r15,r1
L_8e5396:
	mov_s r13,r2
L_8e5398:
	bl.d L_8c32d8
L_8e539c:
	mov_s r16,r3
L_8e539e:
	mov_s r14,r0
L_8e53a0:
	stw.ab r15,[r0,0x2]
L_8e53a4:
	mov_s r1,r17
L_8e53a6:
	bl.d L_8c0380
L_8e53aa:
	mov_s r2,0x6
L_8e53ac:
	brhs.d r13,0x9,L_8e53d4
L_8e53b0:
	mov_s r2,0x7
L_8e53b2:
	ldb.x r13,[0x8023fc,r13]
L_8e53ba:
	add r0,pcl,0xa
L_8e53be:
	add1_s r0,r0,r13
L_8e53c0:
	j_s [r0]
L_8e53c2:
	mov_s r2,0x3
L_8e53c4:
	b_s L_8e53d4
L_8e53c6:
	mov_s r2,0x2
L_8e53c8:
	b_s L_8e53d4
L_8e53ca:
	mov_s r2,0x4
L_8e53cc:
	b_s L_8e53d4
L_8e53ce:
	mov_s r2,0xd
L_8e53d0:
	b_s L_8e53d4
L_8e53d2:
	mov_s r2,0x6
	.global L_8e53d4
L_8e53d4:
	stb_s r2,[r14,0x8]
L_8e53d6:
	mov_s r0,0x0
L_8e53d8:
	stb_s r0,[r14,0x9]
L_8e53da:
	mov_s r1,0x100d2b4
L_8e53e0:
	mov_s r0,0x2b
L_8e53e2:
	bl.d L_8dcc80
L_8e53e6:
	mov_s r3,r15
L_8e53e8:
	mov_s r0,r14
L_8e53ea:
	mov_s r1,0x3
L_8e53ec:
	bset_s r1,r1,0xc
L_8e53ee:
	mov_s r2,0xa
L_8e53f0:
	mov_s r3,r16
L_8e53f2:
	mov r4,0x0
L_8e53f6:
	mov r5,r4
L_8e53fa:
	bl.d L_8e5474
L_8e53fe:
	mov r6,r4
L_8e5402:
	bl.d L_8c6a30
L_8e5406:
	mov_s r0,0x2
L_8e5408:
	bl.d L_8c6a30
L_8e540c:
	mov_s r0,0x1
L_8e540e:
	bl.d L_8c6a30
L_8e5412:
	mov_s r0,0x5
L_8e5414:
	b L_8c023c
