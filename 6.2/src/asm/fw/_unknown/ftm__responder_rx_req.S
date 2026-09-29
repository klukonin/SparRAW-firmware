/* ftm__responder_rx_req @ 0x8cb3bc, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FTM Responder , MAC: ADDR-%04X%08X
 *   FTMr recevied. Station is not enabled as FTM responder.
 * Зовут его: ftm__responder_rx_req__with_ctx, stream_mgr__action
 * Зовёт сам: __ld_r14_to_r13_ret, __ld_r22_to_r13_ret, __st_r14_to_r13, __st_r22_to_r13, basic_sm__handle_event, bits__set16h_s0_w2, conn_mgr__by_cid, ftm__is_responder_enabled, ftm__send_ucode_session_cfg, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm__responder_rx_req
ftm__responder_rx_req:
	.global L_8cb3bc
L_8cb3bc:
	push_s blink
L_8cb3be:
	bl L_8c01c4
L_8cb3c2:
	mov_s r17,r0
L_8cb3c4:
	mov_s r13,r1
L_8cb3c6:
	mov_s r14,r2
L_8cb3c8:
	bl.d L_8cbffc
L_8cb3cc:
	mov_s r0,r3
L_8cb3ce:
	mov_s r16,r0
L_8cb3d0:
	add r3,r0,0x1c
L_8cb3d4:
	ldw_s r2,[r3,0x4]
L_8cb3d6:
	mov_s r1,0x1019b18
L_8cb3dc:
	mov_s r0,0x2b
L_8cb3de:
	bl.d L_8dcc80
L_8cb3e2:
	ld_s r3,[r3]
L_8cb3e4:
	bl.d L_8da560
L_8cb3e8:
	mov_s r0,r17
L_8cb3ea:
	mov r18,0x0
L_8cb3ee:
	sub r21,r14,0x3
L_8cb3f2:
	brne_s r0,0,L_8cb402
L_8cb3f4:
	mov_s r1,0x1019b3c
L_8cb3fa:
	bl.d L_8dcba8
L_8cb3fe:
	mov_s r0,0x2b
L_8cb400:
	b_s L_8cb470
	.global L_8cb402
L_8cb402:
	add r19,r13,0x3
L_8cb406:
	mov r22,r18
L_8cb40a:
	mov r17,r18
L_8cb40e:
	mov_s r13,r18
L_8cb410:
	b_s L_8cb456
	.global L_8cb412
L_8cb412:
	add r1,r19,r13
L_8cb416:
	ldb r20,[r1]
L_8cb41a:
	cmp r20,0xce
L_8cb41e:
	ldb_s r15,[r1,0x1]
L_8cb420:
	bne_s L_8cb440
L_8cb422:
	mov_s r14,0x8577b8
L_8cb428:
	add2 r0,r14,0x19
L_8cb42c:
	bl.d L_8c0380
L_8cb430:
	mov_s r2,r15
L_8cb432:
	mov_s r1,0x1
L_8cb434:
	add1 r0,r14,0x33
L_8cb438:
	bl.d L_8ed2d4
L_8cb43c:
	add r18,r13,r19
	.global L_8cb440
L_8cb440:
	cmp r20,0x26
L_8cb444:
	mov.eq r0,0x1
L_8cb448:
	mov.eq r22,r0
L_8cb44c:
	mov.eq r17,r0
L_8cb450:
	sub r21,r21,r15
L_8cb454:
	add_s r13,r13,r15
	.global L_8cb456
L_8cb456:
	brhs r21,0x3,L_8cb412
L_8cb45a:
	breq r18,0x0,L_8cb474
	.global L_8cb45e
L_8cb45e:
	ldb r0,[r16, 0x8]
L_8cb462:
	mov_s r1,0x1
L_8cb464:
	mov_s r2,r18
L_8cb466:
	mov_s r3,r17
L_8cb468:
	bl.d L_8db81c
L_8cb46c:
	mov r4,r22
	.global L_8cb470
L_8cb470:
	b L_8c0214
	.global L_8cb474
L_8cb474:
	mov_s r0,blink
L_8cb476:
	mov_s r1,0x1486
L_8cb47c:
	bl L_8c9b28
L_8cb480:
	b_s L_8cb45e
L_8cb482:
	nop_s
	.global L_8cb484
L_8cb484:
	push_s blink
L_8cb486:
	bl L_8c01e4
L_8cb48a:
	mov_s r14,r0
L_8cb48c:
	ld_s r0,[r1]
L_8cb48e:
	mov_s r13,r1
L_8cb490:
	cmp_s r0,0x2
L_8cb492:
	cmp.ne r0,0x1
L_8cb496:
	bne_s L_8cb4ba
L_8cb498:
	bl.d L_8cbffc
L_8cb49c:
	ldw_s r0,[r13,0x8]
L_8cb49e:
	cmp_s r0,0x0
L_8cb4a0:
	add.ne r0,r0,0x164
L_8cb4a8:
	mov.ne r1,0x3
L_8cb4ac:
	mov.ne r2,r13
L_8cb4b0:
	sub_s.ne r3,r3,r3
L_8cb4b2:
	bl.ne.d L_8d9b6c
L_8cb4b6:
	mov.ne r4,r3
	.global L_8cb4ba
L_8cb4ba:
	ld_s r0,[r13,0x4]
L_8cb4bc:
	cmp_s r0,0x0
L_8cb4be:
	cmp.ne r0,0x1
L_8cb4c2:
	bl.eq.d L_8da560
L_8cb4c6:
	mov.eq r0,r14
L_8cb4ca:
	b L_8c0254
L_8cb4ce:
	nop_s
