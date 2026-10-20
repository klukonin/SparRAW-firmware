/* wmi_handler_sw_tx_req @ 0x8f3430, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW failed TX MGMT: too big packet.
 *   HOST SW TX: Sending [type = %d, sub_type = %d]
 *   [NNL] [GO = %d, is_probe_resp = %d ]
 *   HOST SW TX: DST MAC: ADDR-%04X%08X
 *   SW TX PROBE RESP IGNORED: FW handle this presp !.
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: SW_TX_MGMT_API__send_packet, TX_API__alloc_tx_payload, TX_API__free_memory, __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit0, fw_log__emit2, l2mgr__send_sw_tx_complete, memcpy_fw, mid_list__by_mid, send_sw_packet
 */
	.section .text.wmi_handler_sw_tx_req,"ax",@progbits
	.global wmi_handler_sw_tx_req
wmi_handler_sw_tx_req:
	.global L_8f3430
L_8f3430:
	push_s blink
L_8f3432:
	bl L_8c02b4
L_8f3436:
	mov_s r14,r0
L_8f3438:
	ldw_s r0,[r0,0x6]
L_8f343a:
	cmp r0,0x500
L_8f343e:
	mov_s r17,r1
L_8f3440:
	ble_s L_8f345a
L_8f3442:
	mov_s r2,0x100cd68
L_8f3448:
	mov_s r0,0xb
L_8f344a:
	bl.d L_8edfb0
L_8f344e:
	mov_s r1,0x1
L_8f3450:
	mov_s r0,0x1
L_8f3452:
	bl.d L_8f0b44
L_8f3456:
	mov_s r1,r17
L_8f3458:
	b_s L_8f3564
	.global L_8f345a
L_8f345a:
	bl.d L_8c2c80
L_8f345e:
	mov r18,0x1
L_8f3462:
	mov_s r13,r0
L_8f3464:
	add r1,r14,0x8
L_8f3468:
	bl.d L_8c0460
L_8f346c:
	ldw_s r2,[r14,0x6]
L_8f346e:
	bl.d L_8ca1b0
L_8f3472:
	mov_s r0,r17
L_8f3474:
	mov_s r16,r0
L_8f3476:
	ldw_s r3,[r13]
L_8f3478:
	ldb r15,[r0, 0x9c]
L_8f347c:
	lsr r0,r3,0x4
L_8f3480:
	bmsk r4,r0,0x3
L_8f3484:
	cmp r4,0x5
L_8f3488:
	sub.ne r18,r18,r18
L_8f348c:
	mov_s r2,0x100cd8c
L_8f3492:
	lsr_s r3,r3,0x2
L_8f3494:
	mov_s r0,0xb
L_8f3496:
	mov_s r1,0x2
L_8f3498:
	bl.d L_8edff8
L_8f349c:
	bmsk_s r3,r3,0x1
L_8f349e:
	mov_s r2,0x100cdbc
L_8f34a4:
	mov_s r0,0xb
L_8f34a6:
	mov_s r1,0x2
L_8f34a8:
	mov_s r3,r15
L_8f34aa:
	bl.d L_8edff8
L_8f34ae:
	mov r4,r18
L_8f34b2:
	mov_s r0,r16
L_8f34b4:
	add r0,r0,0x234
L_8f34b8:
	ld_s r2,[r0,0x8]
L_8f34ba:
	ld_s r3,[r2,0x78]
L_8f34bc:
	mov_s r1,0x0
L_8f34be:
	brne_s r3,0,L_8f34ec
L_8f34c0:
	ld_s r3,[r2,0x6c]
L_8f34c2:
	cmp_s r3,0x0
L_8f34c4:
	cmp.ne r3,0x3
L_8f34c8:
	bne_s L_8f34de
L_8f34ca:
	ldb r1,[r2, 0x8d]
L_8f34ce:
	brne r1,0x1,L_8f34d8
L_8f34d2:
	ld_s r1,[r2,0x78]
L_8f34d4:
	breq r1,0x1,L_8f34dc
	.global L_8f34d8
L_8f34d8:
	mov_s r1,0x0
L_8f34da:
	b_s L_8f34de
	.global L_8f34dc
L_8f34dc:
	mov_s r1,0x1
	.global L_8f34de
L_8f34de:
	extb.f 0x0,r1
L_8f34e2:
	bne_s L_8f34ec
L_8f34e4:
	ld_s r1,[r0,0x70]
L_8f34e6:
	cmp_s r1,0x0
L_8f34e8:
	mov_s r1,0x0
L_8f34ea:
	beq_s L_8f34ee
	.global L_8f34ec
L_8f34ec:
	mov_s r1,0x1
	.global L_8f34ee
L_8f34ee:
	extb.f 0x0,r1
L_8f34f2:
	bne_s L_8f34fc
L_8f34f4:
	cmp_s r15,0x0
L_8f34f6:
	cmp.ne r18,0x0
L_8f34fa:
	beq_s L_8f350c
	.global L_8f34fc
L_8f34fc:
	ldw_s r3,[r14,0x6]
L_8f34fe:
	mov_s r1,r14
L_8f3500:
	mov_s r2,r13
L_8f3502:
	bl.d L_8f0a94
L_8f3506:
	mov r4,r17
L_8f350a:
	b_s L_8f3564
	.global L_8f350c
L_8f350c:
	mov_s r2,0x100cde4
L_8f3512:
	ldw_s r0,[r14,0x2]
L_8f3514:
	ldw r4,[r14]
L_8f3518:
	asl_s r0,r0,0x10
L_8f351a:
	or r4,r4,r0
L_8f351e:
	mov_s r0,0xb
L_8f3520:
	mov_s r1,0x1
L_8f3522:
	bl.d L_8edff8
L_8f3526:
	ldw_s r3,[r14,0x4]
L_8f3528:
	ldw_s r0,[r13]
L_8f352a:
	lsr_s r0,r0,0x4
L_8f352c:
	bmsk_s r0,r0,0x3
L_8f352e:
	breq r0,0x5,L_8f3548
L_8f3532:
	mov r4,0x30b44
L_8f353a:
	mov_s r0,r14
L_8f353c:
	mov_s r1,r17
L_8f353e:
	mov_s r2,r13
L_8f3540:
	bl.d L_8e0b38
L_8f3544:
	ldw_s r3,[r14,0x6]
L_8f3546:
	b_s L_8f3564
	.global L_8f3548
L_8f3548:
	mov_s r2,0x100ce08
L_8f354e:
	mov_s r0,0x7
L_8f3550:
	bl.d L_8edfb0
L_8f3554:
	mov_s r1,0x1
L_8f3556:
	mov_s r0,0x0
L_8f3558:
	bl.d L_8f0b44
L_8f355c:
	mov_s r1,r17
L_8f355e:
	bl.d L_8c94c4
L_8f3562:
	mov_s r0,r13
	.global L_8f3564
L_8f3564:
	b L_8c0314
