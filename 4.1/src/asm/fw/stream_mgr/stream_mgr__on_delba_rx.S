/* stream_mgr__on_delba_rx @ 0x8c75a8, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr.cpp
 *   DELBA frame from STA %d for TID %d.
 *   Reason: %d. (36-LEAV,37-END_BA,38-UNKNWN_BA,39-T/O)
 *   DELBA -> DISCONNECT
 *   Initiator DELBA message - moved on thru Driver.
 *   <<---- [HOST EVENT] WMI_DELBA_EVENTID for midid %d.
 * Зовут его: stream_mgr__rx_action
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, conn__disconnect, conn_mgr__by_cid, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, operational_if__alloc_evt, operational_if__send_evt, stream_mgr__find_vring_by_cid, ul_stream__ba_sm_evt
 */
	.section .text.stream_mgr__on_delba_rx,"ax",@progbits
	.global stream_mgr__on_delba_rx
stream_mgr__on_delba_rx:
	.global L_8c75a8
L_8c75a8:
	push_s blink
L_8c75aa:
	bl L_8c02b8
L_8c75ae:
	mov_s r14,r0
L_8c75b0:
	mov_s r16,r1
L_8c75b2:
	ldb_s r0,[r0,0x3]
L_8c75b4:
	bl.d L_8cab10
L_8c75b8:
	lsr_s r0,r0,0x4
L_8c75ba:
	mov.f r13,r0
L_8c75be:
	bne_s L_8c75d8
L_8c75c0:
	mov_s r0,blink
L_8c75c2:
	mov_s r2,0x100e398
L_8c75c8:
	mov_s r1,0x1296
L_8c75ce:
	bl.d L_8c82c0
L_8c75d2:
	mov r3,0x1c0
L_8c75d6:
	b_s L_8c76b8
	.global L_8c75d8
L_8c75d8:
	mov_s r2,0x100e418
L_8c75de:
	ldb r4,[r13, 0x4]
L_8c75e2:
	mov_s r0,0xb
L_8c75e4:
	mov_s r1,0x2
L_8c75e6:
	bl.d L_8edff8
L_8c75ea:
	mov_s r3,r16
L_8c75ec:
	mov_s r2,0x100e43c
L_8c75f2:
	mov_s r0,0xb
L_8c75f4:
	mov_s r1,0x2
L_8c75f6:
	bl.d L_8edfcc
L_8c75fa:
	ldw_s r3,[r14,0x4]
L_8c75fc:
	bl.d L_8c9e44
L_8c7600:
	mov_s r0,r16
L_8c7602:
	mov.f r15,r0
L_8c7606:
	beq_s L_8c7628
	.global L_8c7608
L_8c7608:
	ldb_s r0,[r13,0x7]
L_8c760a:
	brne r0,0x9,L_8c7640
L_8c760e:
	mov_s r2,0x100e470
L_8c7614:
	mov_s r0,0xb
L_8c7616:
	bl.d L_8edfb0
L_8c761a:
	mov_s r1,0x2
L_8c761c:
	mov_s r0,r15
L_8c761e:
	mov_s r1,0x3
L_8c7620:
	bl.d L_8eb190
L_8c7624:
	mov_s r2,r1
L_8c7626:
	b_s L_8c76b8
	.global L_8c7628
L_8c7628:
	mov_s r0,blink
L_8c762a:
	mov_s r2,0x100e398
L_8c7630:
	mov_s r1,0x1297
L_8c7636:
	bl.d L_8c82c0
L_8c763a:
	mov r3,0x1c9
L_8c763e:
	b_s L_8c7608
	.global L_8c7640
L_8c7640:
	ldb_s r1,[r14,0x3]
L_8c7642:
	lsr r0,r1,0x3
L_8c7646:
	bmsk r17,r0,0x0
L_8c764a:
	mov_s r3,0x0
L_8c764c:
	bbit0 r1,0x3,L_8c76a8
L_8c7650:
	mov_s r2,0x100e484
L_8c7656:
	mov_s r0,0xb
L_8c7658:
	bl.d L_8edfb0
L_8c765c:
	mov_s r1,0x2
L_8c765e:
	bl L_8c2b68
L_8c7662:
	mov_s r13,r0
L_8c7664:
	ldb_s r0,[r14,0x3]
L_8c7666:
	stb r17,[r13, 0x1]
L_8c766a:
	lsr_s r0,r0,0x4
L_8c766c:
	asl_s r1,r0,0x4
L_8c766e:
	bmsk r0,r16,0x3
L_8c7672:
	or_s r0,r0,r1
L_8c7674:
	stb_s r0,[r13]
L_8c7676:
	ldw_s r0,[r14,0x4]
L_8c7678:
	mov_s r2,0x100e4b4
L_8c767e:
	stw_s r0,[r13,0x2]
L_8c7680:
	ld_s r3,[r15,0xc]
L_8c7682:
	mov_s r0,0xb
L_8c7684:
	mov_s r1,0x2
L_8c7686:
	bl.d L_8edfcc
L_8c768a:
	ldb_s r3,[r3,0x10]
L_8c768c:
	ld_s r3,[r15,0xc]
L_8c768e:
	mov_s r0,r13
L_8c7690:
	mov_s r1,0x1826
L_8c7696:
	mov_s r2,0x4
L_8c7698:
	ldb_s r3,[r3,0x10]
L_8c769a:
	mov r4,0x0
L_8c769e:
	bl.d L_8e0874
L_8c76a2:
	mov r5,0x0
L_8c76a6:
	b_s L_8c76b8
	.global L_8c76a8
L_8c76a8:
	st r3,[r13, 0xc0]
L_8c76ac:
	ldw_s r2,[r14,0x4]
L_8c76ae:
	mov_s r0,r13
L_8c76b0:
	mov_s r1,0x5
L_8c76b2:
	bl.d L_8d6afc
L_8c76b6:
	mov_s r4,r3
	.global L_8c76b8
L_8c76b8:
	b L_8c031c
