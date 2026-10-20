/* ps_assoc_mgr__shallow_sleep_enter @ 0x8e13c8, 284 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_EVT_SHALLOW_SLEEP_ENTER ps_assoc_mgr:: set m_awake_tsf_64 0x%08x%08x, curr_tsf-0x%08x
 * Зовёт сам: PS_NONASSOC_SM__ps_reenter_done, TX_API__awake_peer_ntf, __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__handle_event, conn_mgr__start_all_detector_services, evt_ring__push_1c, fw_log_emit3, hwd_dma__get_rings_with_data, mid__state_is_2_or_3, mids__count_active_conns, ps_assoc_mgr__aw_ie_reception
 * Глобалы (через gp): 0x8002b4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_assoc_mgr__shallow_sleep_enter
ps_assoc_mgr__shallow_sleep_enter:
	.global L_8e13c8
L_8e13c8:
	push_s blink
L_8e13ca:
	bl L_8c01d8
L_8e13ce:
	mov_s r13,r0
L_8e13d0:
	mov_s r15,r1
L_8e13d2:
	mov_s r14,r2
L_8e13d4:
	mov_s r0,r1
L_8e13d6:
	bl.d L_8e14e4
L_8e13da:
	mov_s r1,r2
L_8e13dc:
	sub.f r15,r15,0x2
L_8e13e0:
	mov_s r0,0x886e80
L_8e13e6:
	ld r17,[r0, 0x38]
L_8e13ea:
	beq_s L_8e1404
L_8e13ec:
	breq r15,0x1,L_8e1494
L_8e13f0:
	breq r15,0x2,L_8e14c2
L_8e13f4:
	cmp_s r15,0x3
L_8e13f6:
	mov.eq r0,r13
L_8e13fa:
	bl.eq.d L_8c3e9c
L_8e13fe:
	mov.eq r1,r14
L_8e1402:
	b_s L_8e14dc
	.global L_8e1404
L_8e1404:
	mov_s r13,0x0
L_8e1406:
	bl.d L_8da488
L_8e140a:
	mov_s r0,r13
L_8e140c:
	ldb_s r1,[r14,0x2]
L_8e140e:
	breq_s r0,0,L_8e142e
L_8e1410:
	breq_s r1,0,L_8e1416
L_8e1412:
	ldb_s r0,[r14,0x4]
L_8e1414:
	breq_s r0,0,L_8e142a
	.global L_8e1416
L_8e1416:
	bl L_8cb8b0
L_8e141a:
	brne r0,0x1,L_8e1424
L_8e141e:
	bl L_8d078c
L_8e1422:
	brne_s r0,0,L_8e1428
	.global L_8e1424
L_8e1424:
	mov_s r13,0x0
L_8e1426:
	b_s L_8e142a
	.global L_8e1428
L_8e1428:
	mov_s r13,0x1
	.global L_8e142a
L_8e142a:
	extb_s r0,r13
L_8e142c:
	b_s L_8e1446
	.global L_8e142e
L_8e142e:
	brne_s r1,0,L_8e1438
L_8e1430:
	bl L_8cb8b0
L_8e1434:
	breq r0,0x1,L_8e143c
	.global L_8e1438
L_8e1438:
	mov_s r0,r13
L_8e143a:
	b_s L_8e1444
	.global L_8e143c
L_8e143c:
	bl L_8d078c
L_8e1440:
	breq_s r0,0,L_8e1438
L_8e1442:
	mov_s r0,0x1
	.global L_8e1444
L_8e1444:
	extb_s r0,r0
	.global L_8e1446
L_8e1446:
	ldb_s r1,[r14,0x4]
L_8e1448:
	ldb_s r15,[r14,0x2]
L_8e144a:
	not_s r13,r1
L_8e144c:
	and r16,r13,r15
L_8e1450:
	brne_s r0,0,L_8e147e
L_8e1452:
	bl L_8cd080
L_8e1456:
	ld_s r1,[r0]
L_8e1458:
	ld_s r2,[r1,0x1c]
L_8e145a:
	jl_s.d [r2]
L_8e145c:
	not r1,r16
L_8e1460:
	bl L_8cd080
L_8e1464:
	ld_s r1,[r0]
L_8e1466:
	ld_s r2,[r1,0x20]
L_8e1468:
	jl_s.d [r2]
L_8e146a:
	mov_s r1,r16
L_8e146c:
	ldb_s r0,[r14,0x2]
L_8e146e:
	ldb_s r1,[r14,0x4]
L_8e1470:
	asl_s r0,r0,0x10
L_8e1472:
	add_s r1,r1,r0
L_8e1474:
	mov_s r0,0x12
L_8e1476:
	bl.d L_8e0b2c
L_8e147a:
	mov_s r2,r17
L_8e147c:
	b_s L_8e1486
	.global L_8e147e
L_8e147e:
	ld_s r0,[gp,0x130]
L_8e1480:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e1482:
	st.as r0,[gp,0x4c]
	.global L_8e1486
L_8e1486:
	bl.d L_8c406c
L_8e148a:
	and r0,r13,r15
L_8e148e:
	bl L_8c40f8
L_8e1492:
	b_s L_8e14dc
	.global L_8e1494
L_8e1494:
	ld_s r1,[r14]
L_8e1496:
	ld_s r0,[r14,0x4]
L_8e1498:
	st_s r1,[r13]
L_8e149a:
	st_s r0,[r13,0x4]
L_8e149c:
	ld_s r2,[r13,0x4]
L_8e149e:
	mov_s r1,0x100231c
L_8e14a4:
	ld_s r3,[r13]
L_8e14a6:
	mov_s r0,0x2e
L_8e14a8:
	bl.d L_8dcd00
L_8e14ac:
	mov r4,r17
L_8e14b0:
	ld_s r1,[r13]
L_8e14b2:
	mov_s r0,0xc
L_8e14b4:
	bl.d L_8e0b2c
L_8e14b8:
	mov_s r2,r17
L_8e14ba:
	add r0,r13,0xc
L_8e14be:
	mov_s r1,0x3
L_8e14c0:
	b_s L_8e14d2
	.global L_8e14c2
L_8e14c2:
	mov_s r0,0xd
L_8e14c4:
	mov_s r1,0x0
L_8e14c6:
	bl.d L_8e0b2c
L_8e14ca:
	mov_s r2,r17
L_8e14cc:
	add r0,r13,0xc
L_8e14d0:
	mov_s r1,0x4
	.global L_8e14d2
L_8e14d2:
	mov_s r2,0x0
L_8e14d4:
	mov_s r3,r2
L_8e14d6:
	bl.d L_8d9b6c
L_8e14da:
	mov_s r4,r2
	.global L_8e14dc
L_8e14dc:
	b L_8c023c
L_8e14e0:
	j_s [blink]
L_8e14e2:
	nop_s
