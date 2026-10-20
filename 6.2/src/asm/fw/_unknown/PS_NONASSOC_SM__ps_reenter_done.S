/* PS_NONASSOC_SM__ps_reenter_done @ 0x8e14e4, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_NONASSOC_SM::ps_reenter_done state = %d
 * Зовут его: ps_assoc_mgr__shallow_sleep_enter
 * Зовёт сам: PS_CONNECTION__awake_peer_ntf, basic_sm__handle_event, fw_log_emit1, fw_sysassert_fatal, m_connect_devid, ps_conn_mgr__notify_all, ps_connection_mgr__on_assoc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global PS_NONASSOC_SM__ps_reenter_done
PS_NONASSOC_SM__ps_reenter_done:
	.global L_8e14e4
L_8e14e4:
	brhs r0,0x8,L_8e1510
L_8e14e8:
	ldb.x r10,[0x801d54,r0]
L_8e14f0:
	add r2,pcl,0xa
L_8e14f4:
	add1 r2,r2,r10
L_8e14f8:
	j_s [r2]
L_8e14fa:
	b.d L_8c3d50
L_8e14fe:
	extb_s r0,r1
L_8e1500:
	b.d L_8c9024
L_8e1504:
	extb_s r0,r1
L_8e1506:
	b.d L_8c4028
L_8e150a:
	mov_s r0,r1
L_8e150c:
	b L_8c5c20
	.global L_8e1510
L_8e1510:
	j_s [blink]
L_8e1512:
	nop_s
L_8e1514:
	ld.as r1,[gp,-0x17]
L_8e1518:
	breq_s r1,0,L_8e1540
L_8e151a:
	mov_s r1,0x0
L_8e151c:
	st.as r1,[gp,-0x17]
L_8e1520:
	ldb_s r2,[r0]
L_8e1522:
	cmp_s r2,0x3
L_8e1524:
	mov.eq r2,r0
L_8e1528:
	mov.eq r3,r1
L_8e152c:
	beq.d L_8d9b6c
L_8e1530:
	mov.eq r4,r1
L_8e1534:
	mov_s r0,blink
L_8e1536:
	mov_s r1,0x2112
L_8e153c:
	b L_8c9b28
	.global L_8e1540
L_8e1540:
	j_s [blink]
L_8e1542:
	nop_s
L_8e1544:
	ld.as r1,[gp,-0x18]
L_8e1548:
	breq_s r1,0,L_8e1570
L_8e154a:
	mov_s r1,0x0
L_8e154c:
	st.as r1,[gp,-0x18]
L_8e1550:
	ldb_s r2,[r0]
L_8e1552:
	cmp_s r2,0x2
L_8e1554:
	mov.eq r2,r0
L_8e1558:
	mov.eq r3,r1
L_8e155c:
	beq.d L_8d9b6c
L_8e1560:
	mov.eq r4,r1
L_8e1564:
	mov_s r1,0x10023c4
L_8e156a:
	b.d L_8dcc10
L_8e156e:
	mov_s r0,0xe
	.global L_8e1570
L_8e1570:
	j_s [blink]
L_8e1572:
	nop_s
