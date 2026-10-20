/* low_sme__send_evt2sw @ 0x8e5474, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CID %d is not secured - fake key installation
 * Зовут его: TX_API__post_tx_payload, discovery__rx_pkt_handler, host_if__periodic_notif_handler, host_if__send_scan_complete, l2_mgr__send_pcp_start_status_evt, l2_mgr__tof_ftm_req, l2_mgr__tof_get_capabilities, l2mgr__send_data_port_open_evt, l2mgr__send_disconnect_evt, l2mgr__send_discovery_started
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, conn__sec_mode_not_1, conn_mgr__by_cid, fw_log_emit1, fw_sysassert_fatal, install_key_handle, low_sme__send_evt2_body, tx_api__ctx_8041f0, u_schd__add, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global low_sme__send_evt2sw
low_sme__send_evt2sw:
	.global L_8e5474
L_8e5474:
	push_s blink
L_8e5476:
	bl L_8c01c8
L_8e547a:
	mov_s r21,r0
L_8e547c:
	mov_s r20,r1
L_8e547e:
	mov_s r13,r2
L_8e5480:
	mov_s r19,r3
L_8e5482:
	mov.f r16,r4
L_8e5486:
	mov r17,r5
L_8e548a:
	mov r18,r6
L_8e548e:
	cmp.eq r17,0x0
L_8e5492:
	bne_s L_8e549e
L_8e5494:
	add r0,r13,0x10
L_8e5498:
	cmp r0,0x100
L_8e549c:
	bhi_s L_8e54be
	.global L_8e549e
L_8e549e:
	bl L_8d9f7c
L_8e54a2:
	mov_s r1,r20
L_8e54a4:
	ld_s r14,[r0,0x78]
L_8e54a6:
	mov_s r0,r21
L_8e54a8:
	mov_s r2,r13
L_8e54aa:
	mov_s r3,r19
L_8e54ac:
	mov r4,r16
L_8e54b0:
	mov r5,r17
L_8e54b4:
	jl_s.d [r14]
L_8e54b6:
	mov r6,r18
L_8e54ba:
	b L_8c021c
	.global L_8e54be
L_8e54be:
	mov_s r0,blink
L_8e54c0:
	mov_s r1,0x61
L_8e54c2:
	bl.d L_8c9b28
L_8e54c6:
	bset_s r1,r1,0xc
L_8e54c8:
	b_s L_8e549e
L_8e54ca:
	nop_s
L_8e54cc:
	push_s blink
L_8e54ce:
	bl L_8c01c8
L_8e54d2:
	sub_s sp,sp,0x4
L_8e54d4:
	mov_s r13,r0
L_8e54d6:
	mov_s r14,r1
L_8e54d8:
	mov_s r21,r2
L_8e54da:
	mov_s r20,r3
L_8e54dc:
	mov r19,r4
L_8e54e0:
	mov r18,r5
L_8e54e4:
	mov r16,r6
L_8e54e8:
	ld.as r15,[gp,-0x5b]
L_8e54ec:
	breq r1,0x15,L_8e5536
L_8e54f0:
	breq r14,0x1002,L_8e5512
L_8e54f8:
	brne r14,0x100a,L_8e5540
L_8e5500:
	mov_s r0,0x2d9c4
L_8e5506:
	mov_s r1,0x0
L_8e5508:
	mov_s r2,r1
L_8e550a:
	bl.d L_8c3248
L_8e550e:
	mov_s r3,0x1
L_8e5510:
	b_s L_8e5540
	.global L_8e5512
L_8e5512:
	bl.d L_8cbffc
L_8e5516:
	ldb_s r0,[r13,0x13]
L_8e5518:
	bl.d L_8da5f8
L_8e551c:
	mov_s r17,r0
L_8e551e:
	brne_s r0,0,L_8e5540
L_8e5520:
	mov_s r1,0x100ba20
L_8e5526:
	mov_s r0,0x2e
L_8e5528:
	bl.d L_8dcc10
L_8e552c:
	ldb_s r2,[r13,0x13]
L_8e552e:
	bl.d L_8f5a5c
L_8e5532:
	mov_s r0,r17
L_8e5534:
	b_s L_8e5540
	.global L_8e5536
L_8e5536:
	bl.d L_8cbffc
L_8e553a:
	ldb_s r0,[r13,0x9]
L_8e553c:
	bl L_8f5a5c
	.global L_8e5540
L_8e5540:
	mov_s r0,0x804c34
L_8e5546:
	ld_s r0,[r0,0x8]
L_8e5548:
	breq_s r15,0,L_8e556a
L_8e554a:
	st r16,[sp]
L_8e554e:
	mov_s r1,r13
L_8e5550:
	mov_s r2,0x0
L_8e5552:
	mov_s r3,r14
L_8e5554:
	mov r4,r21
L_8e5558:
	mov r5,r20
L_8e555c:
	mov r6,r19
L_8e5560:
	bl.d L_8e4fc4
L_8e5564:
	mov r7,r18
L_8e5568:
	b_s L_8e5574
	.global L_8e556a
L_8e556a:
	mov_s r1,r13
L_8e556c:
	mov_s r2,r19
L_8e556e:
	bl.d L_8cb1bc
L_8e5572:
	mov_s r3,r18
	.global L_8e5574
L_8e5574:
	b.d L_8c021c
L_8e5578:
	add_s sp,sp,0x4
L_8e557a:
	nop_s
