/* l2_mgr__pcp_start_flow @ 0x8dc544, 284 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCP Start failed, MAC address error
 *   PCP Start handle channel id %d  bcon_interval_msec %d networkType = %x
 *   PBSS PCP Start DMG Information flow start networkType = %d WMI_NETTYPE_P2P = %d.
 *   PCP Start failed, BSS not ready or channel is not valid bss_mode: %d, bss_state:%d, channel:%d
 * Зовут его: l2_mgr__pcp_start
 * Зовёт сам: RADIO_MGR__set_primary_channel, __ld_r20_to_r13_ret, __st_r20_to_r13, bss_set_active, bss_set_mode, frag_8e1924, fw_log__emit0, fw_log__emit2, fw_log__emit3, l2_mgr__send_pcp_start_status_evt, mac_parser__set_886260, mid__log_network_type
 * Глобалы (через gp): 0x8002c0, 0x8003e4
 */
	.section .text.l2_mgr__pcp_start_flow,"ax",@progbits
	.global l2_mgr__pcp_start_flow
l2_mgr__pcp_start_flow:
	.global L_8dc544
L_8dc544:
	push_s blink
L_8dc546:
	bl L_8c02ac
L_8dc54a:
	mov_s r13,r0
L_8dc54c:
	mov_s r19,r1
L_8dc54e:
	mov_s r1,0x0
L_8dc550:
	st.as r1,[r0,0xb8]
L_8dc554:
	ldw_s r0,[r0,0xa]
L_8dc556:
	mov_s r20,r3
L_8dc558:
	bxor r0,r0,0x0
L_8dc55c:
	mov_s r14,r2
L_8dc55e:
	mov r17,r4
L_8dc562:
	bbit1 r0,0x0,L_8dc57a
L_8dc566:
	mov_s r2,0x100b82c
L_8dc56c:
	bl.d L_8edfb0
L_8dc570:
	mov_s r0,0xb
L_8dc572:
	mov_s r0,0x1
L_8dc574:
	bl.d L_8f0770
L_8dc578:
	ldb_s r1,[r13,0x10]
	.global L_8dc57a
L_8dc57a:
	mov_s r0,r13
L_8dc57c:
	bl.d L_8e1b34
L_8dc580:
	mov_s r1,r19
L_8dc582:
	stb_s r14,[r13,0x11]
L_8dc584:
	add3 r14,r13,0x9
L_8dc588:
	ld_s r1,[r14,0x4]
L_8dc58a:
	mov r16,0x8033dc
L_8dc592:
	ld r18,[r16]
L_8dc596:
	cmp_s r1,0x2
L_8dc598:
	cmp.ne r18,0x3
L_8dc59c:
	beq_s L_8dc63a
L_8dc59e:
	mov_s r15,0x0
L_8dc5a0:
	mov_s r2,0x100b850
L_8dc5a6:
	ld.as r4,[gp,0x54]
L_8dc5aa:
	mov_s r0,0xb
L_8dc5ac:
	mov_s r1,0x2
L_8dc5ae:
	mov_s r3,r18
L_8dc5b0:
	bl.d L_8ee034
L_8dc5b4:
	mov r5,r19
L_8dc5b8:
	ldb r5,[r13, 0x10]
L_8dc5bc:
	mov_s r0,r18
L_8dc5be:
	ld.as r3,[gp,0x54]
L_8dc5c2:
	mov_s r1,r15
L_8dc5c4:
	mov_s r2,r15
L_8dc5c6:
	bl.d L_8e1ed8
L_8dc5ca:
	mov_s r4,r15
L_8dc5cc:
	stb r18,[r14, 0x4c]
L_8dc5d0:
	cmp r19,0x10
L_8dc5d4:
	mov_s r0,r14
L_8dc5d6:
	mov_s r1,0x3
L_8dc5d8:
	mov.ne r1,0x2
L_8dc5dc:
	bl L_8c4594
L_8dc5e0:
	stb r17,[r14, 0x54]
L_8dc5e4:
	mov_s r0,r13
L_8dc5e6:
	bl.d L_8eef18
L_8dc5ea:
	add r0,r0,0x234
L_8dc5ee:
	mov_s r0,r14
L_8dc5f0:
	bl.d L_8e1924
L_8dc5f4:
	mov_s r1,r20
L_8dc5f6:
	ld r0,[r16, 0x8c]
L_8dc5fa:
	breq_s r0,0,L_8dc61a
L_8dc5fc:
	mov_s r2,0x100b898
L_8dc602:
	mov_s r0,0xb
L_8dc604:
	mov_s r1,0x2
L_8dc606:
	mov_s r3,r19
L_8dc608:
	bl.d L_8edff8
L_8dc60c:
	mov r4,0x20
L_8dc610:
	brne r19,0x20,L_8dc61a
L_8dc614:
	bl.d L_8d53d8
L_8dc618:
	ldb_s r0,[r13,0x10]
	.global L_8dc61a
L_8dc61a:
	bl.d L_8c456c
L_8dc61e:
	mov_s r0,r14
L_8dc620:
	ld_s r0,[gp,0x274]
L_8dc622:
	cmp_s r0,0x0
L_8dc624:
	mov.ne r1,0x3f02
L_8dc62c:
	bl.ne.d L_8dbae4
L_8dc630:
	mov.ne r0,0x2
L_8dc634:
	ldb_s r1,[r13,0x10]
L_8dc636:
	mov_s r0,0x0
L_8dc638:
	b_s L_8dc656
	.global L_8dc63a
L_8dc63a:
	ld r4,[r14, 0x4]
L_8dc63e:
	mov_s r2,0x100b8ec
L_8dc644:
	ld_s r3,[r14,0x8]
L_8dc646:
	mov_s r0,0xb
L_8dc648:
	mov_s r1,0x0
L_8dc64a:
	bl.d L_8ee034
L_8dc64e:
	mov r5,r18
L_8dc652:
	ldb_s r1,[r13,0x10]
L_8dc654:
	mov_s r0,0x1
	.global L_8dc656
L_8dc656:
	bl L_8f0770
L_8dc65a:
	b L_8c0304
L_8dc65e:
	nop_s
