/* TX_API__handle_completed_packets @ 0x8cb2c0, 384 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::handle_completed_packets() TX WB from DMA #%d for %d packets.
 *   TX_API::handle_completed_packets() metadata_p=0x%06x
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 *   TX_API::handle_completed_packets() - status %d.
 *   TX_API::handle_completed_packets() - m_pending_peer_pm_list.add2tail(0x%x)
 * Зовут его: TX_CTRL_API__flush_connection, tx_api__handle_completions_by_kind
 * Зовёт сам: FWQ_TX_AVAILABILITY__remove_packet, TX_API__free_memory, __ld_r18_to_r13_ret, __st_r18_to_r13, conn_mgr__by_cid, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, fwq_tx__handle_completion, llist__init, llist__insert, llist__pop_front
 * Глобалы (через gp): 0x800404, 0x800458
 */
	.section .text.TX_API__handle_completed_packets,"ax",@progbits
	.global TX_API__handle_completed_packets
TX_API__handle_completed_packets:
	.global L_8cb2c0
L_8cb2c0:
	push_s blink
L_8cb2c2:
	bl L_8c02b4
L_8cb2c6:
	sub_s sp,sp,0x14
L_8cb2c8:
	mov_s r15,r0
L_8cb2ca:
	mov_s r0,sp
L_8cb2cc:
	bl.d L_8de5c4
L_8cb2d0:
	mov_s r17,r0
L_8cb2d2:
	mov_s r0,r15
L_8cb2d4:
	bl.d L_8ca540
L_8cb2d8:
	mov_s r1,r17
L_8cb2da:
	ld r0,[r15, 0x8c]
L_8cb2de:
	ld_s r1,[r0]
L_8cb2e0:
	ld_s r1,[r1,0x14]
L_8cb2e2:
	jl_s [r1]
L_8cb2e4:
	mov_s r3,r0
L_8cb2e6:
	ld r4,[sp]
L_8cb2ea:
	mov_s r2,0x1014ec0
L_8cb2f0:
	mov_s r0,0x7
L_8cb2f2:
	bl.d L_8edff8
L_8cb2f6:
	mov_s r1,0x2
L_8cb2f8:
	b_s L_8cb426
	.global L_8cb2fa
L_8cb2fa:
	bl.d L_8de2d4
L_8cb2fe:
	mov_s r0,r17
L_8cb300:
	mov.f r14,r0
L_8cb304:
	add_s r13,sp,0xc
L_8cb306:
	beq_s L_8cb348
	.global L_8cb308
L_8cb308:
	st_s r14,[r13]
L_8cb30a:
	add r0,r14,0x1c
L_8cb30e:
	st_s r0,[r13,0x4]
L_8cb310:
	ldb_s r13,[r14,0x11]
L_8cb312:
	mov_s r0,r15
L_8cb314:
	bl.d L_8e5a78
L_8cb318:
	mov_s r1,r13
L_8cb31a:
	mov_s r2,0x1014f08
L_8cb320:
	mov_s r0,0x7
L_8cb322:
	mov_s r1,0x2
L_8cb324:
	bl.d L_8edfcc
L_8cb328:
	mov_s r3,r14
L_8cb32a:
	mov_s r0,0x842530
L_8cb330:
	brne r15,r0,L_8cb398
L_8cb334:
	brhs r13,0x5,L_8cb398
L_8cb338:
	ldb.x r13,[0x802b0c,r13]
L_8cb340:
	add r0,pcl,0x8
L_8cb344:
	add1_s r0,r0,r13
L_8cb346:
	j_s [r0]
	.global L_8cb348
L_8cb348:
	mov_s r0,blink
L_8cb34a:
	mov_s r2,0x1014d54
L_8cb350:
	mov_s r1,0x11d6
L_8cb356:
	bl.d L_8c82c0
L_8cb35a:
	mov_s r3,0xaa
L_8cb35c:
	b_s L_8cb308
L_8cb35e:
	ld_s r0,[gp,-0x120]
L_8cb360:
	mov_s r13,0x0
L_8cb362:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb364:
	st.as r0,[gp,-0x48]
L_8cb368:
	b_s L_8cb398
L_8cb36a:
	ld_s r0,[gp,-0x130]
L_8cb36c:
	mov_s r13,0x1
L_8cb36e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb370:
	st.as r0,[gp,-0x4c]
L_8cb374:
	b_s L_8cb398
L_8cb376:
	ld_s r0,[gp,-0x124]
L_8cb378:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb37a:
	st.as r0,[gp,-0x49]
L_8cb37e:
	mov_s r13,0x2
L_8cb380:
	b_s L_8cb398
L_8cb382:
	ld_s r0,[gp,-0x128]
L_8cb384:
	mov_s r13,0x3
L_8cb386:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb388:
	st.as r0,[gp,-0x4a]
L_8cb38c:
	b_s L_8cb398
L_8cb38e:
	ld_s r0,[gp,-0x12c]
L_8cb390:
	mov_s r13,0x4
L_8cb392:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb394:
	st.as r0,[gp,-0x4b]
	.global L_8cb398
L_8cb398:
	mov r18,0x842404
L_8cb3a0:
	add r0,r18,0xc
L_8cb3a4:
	mov r16,0x1
L_8cb3a8:
	brne r15,r0,L_8cb3ec
L_8cb3ac:
	mov_s r2,0x1014f40
L_8cb3b2:
	mov_s r0,0x7
L_8cb3b4:
	mov_s r1,0x2
L_8cb3b6:
	bl.d L_8edfcc
L_8cb3ba:
	mov_s r3,r13
L_8cb3bc:
	brne r13,0x5,L_8cb3e6
L_8cb3c0:
	ld_s r0,[gp,-0x134]
L_8cb3c2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb3c4:
	st.as r0,[gp,-0x4d]
L_8cb3c8:
	mov_s r0,r18
L_8cb3ca:
	bl.d L_8c1fc4
L_8cb3ce:
	mov_s r1,r14
L_8cb3d0:
	mov_s r2,0x1014f70
L_8cb3d6:
	mov_s r0,0x7
L_8cb3d8:
	mov_s r1,0x2
L_8cb3da:
	bl.d L_8edfcc
L_8cb3de:
	mov_s r3,r14
L_8cb3e0:
	mov r16,0x0
L_8cb3e4:
	b_s L_8cb3ec
	.global L_8cb3e6
L_8cb3e6:
	cmp r13,0xff
L_8cb3ea:
	bne_s L_8cb40e
	.global L_8cb3ec
L_8cb3ec:
	brne r16,0x1,L_8cb424
L_8cb3f0:
	ld r18,[r14, 0x18]
L_8cb3f4:
	ld_s r0,[sp,0x10]
L_8cb3f6:
	breq r18,0x0,L_8cb420
L_8cb3fa:
	mov_s r16,r0
L_8cb3fc:
	bl.d L_8c9e44
L_8cb400:
	ldb_s r0,[r14,0xa]
L_8cb402:
	mov_s r3,r18
L_8cb404:
	mov_s r2,r0
L_8cb406:
	mov_s r0,r16
L_8cb408:
	jl_s.d [r3]
L_8cb40a:
	mov_s r1,r13
L_8cb40c:
	b_s L_8cb424
	.global L_8cb40e
L_8cb40e:
	cmp r13,0xfe
L_8cb412:
	beq_s L_8cb3ec
L_8cb414:
	ldb_s r1,[r14,0xb]
L_8cb416:
	ldb_s r0,[r14,0xa]
L_8cb418:
	bl.d L_8de304
L_8cb41c:
	bmsk_s r1,r1,0x5
L_8cb41e:
	b_s L_8cb3ec
	.global L_8cb420
L_8cb420:
	bl L_8c94c4
	.global L_8cb424
L_8cb424:
	brne_s r13,0,L_8cb432
	.global L_8cb426
L_8cb426:
	ld_s r0,[sp,0x0]
L_8cb428:
	cmp_s r0,0x0
L_8cb42a:
	bne_s L_8cb2fa
L_8cb42c:
	b.d L_8c0314
L_8cb430:
	add_s sp,sp,0x14
	.global L_8cb432
L_8cb432:
	ld_s r0,[gp,0x294]
L_8cb434:
	breq_s r0,0,L_8cb426
L_8cb436:
	ld_s r0,[gp,0x2e8]
L_8cb438:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb43a:
	st.as r0,[gp,0xba]
L_8cb43e:
	b_s L_8cb426
