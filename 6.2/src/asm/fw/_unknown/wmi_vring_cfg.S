/* wmi_vring_cfg @ 0x8fc198, 972 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   NEW VRING (TID %d) to CID %d cannot be proceed - CID is not exist.
 *   NEW VRING (TID %d) to CID %d cannot be proceed, Conn is disconnecting
 *   DELETE VRING (TID %d), CID %d.
 *   NEW VRING (TID %d) to CID %d.
 *   encap_trans_type = %d, TX max_mpdu_size = %d, agg_max_wsize = %d
 *   lifetime_en = %d, u_to_resolution = %d, aggr_en = %d
 *   requested MSDU size = %d to big (%d)
 *   OOB mode force to MAX MSDU size = %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: STREAM_MGR__ADD, __ld_r21_to_r13_ret, __st_r21_to_r13, conn_mgr__by_cid, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, l2mgr__send_vring_cfg_done, list__insert_obj__8c1cc0, stream_mgr__delete_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_vring_cfg
wmi_vring_cfg:
	.global L_8fc198
L_8fc198:
	push_s blink
L_8fc19a:
	bl L_8c01c8
L_8fc19e:
	ldb_s r15,[r0,0x10]
L_8fc1a0:
	mov_s r13,r0
L_8fc1a2:
	sub_s sp,sp,0x18
L_8fc1a4:
	brhs.d r15,0xa,L_8fc1d0
L_8fc1a8:
	mov_s r20,r1
L_8fc1aa:
	ldb_s r14,[r13,0x11]
L_8fc1ac:
	mov_s r0,r14
L_8fc1ae:
	bic r0,r0,-0xf1
L_8fc1b2:
	asr r21,r0,0x4
L_8fc1b6:
	brhs r21,0x7,L_8fc1de
	.global L_8fc1ba
L_8fc1ba:
	bl.d L_8cbffc
L_8fc1be:
	bmsk r0,r14,0x3
L_8fc1c2:
	mov.f r16,r0
L_8fc1c6:
	bne_s L_8fc206
L_8fc1c8:
	mov_s r1,0x100d994
L_8fc1ce:
	b_s L_8fc1ec
	.global L_8fc1d0
L_8fc1d0:
	mov_s r0,blink
L_8fc1d2:
	mov_s r1,0x11da
L_8fc1d8:
	bl L_8c9b28
L_8fc1dc:
	b_s L_8fc356
	.global L_8fc1de
L_8fc1de:
	mov_s r0,blink
L_8fc1e0:
	mov_s r1,0x11db
L_8fc1e6:
	bl L_8c9b28
L_8fc1ea:
	b_s L_8fc1ba
	.global L_8fc1ec
L_8fc1ec:
	mov_s r0,0x1b
L_8fc1ee:
	mov_s r2,r21
L_8fc1f0:
	bl.d L_8dcc80
L_8fc1f4:
	bmsk r3,r14,0x3
L_8fc1f8:
	mov_s r0,r15
L_8fc1fa:
	mov_s r1,0x0
L_8fc1fc:
	mov_s r2,0x1
L_8fc1fe:
	bl.d L_8f8e98
L_8fc202:
	mov_s r3,r20
L_8fc204:
	b_s L_8fc356
	.global L_8fc206
L_8fc206:
	ldb r0,[r16,0x124]
L_8fc20e:
	brne r0,0x8,L_8fc21a
L_8fc212:
	mov_s r1,0x100d9d8
L_8fc218:
	b_s L_8fc1ec
	.global L_8fc21a
L_8fc21a:
	add3 r0,r16,0x1e
L_8fc21e:
	ldb_s r1,[r0]
L_8fc220:
	breq r1,0x2,L_8fc22a
L_8fc224:
	ld_s r0,[r0,0xc]
L_8fc226:
	cmp_s r0,0x0
L_8fc228:
	beq_s L_8fc35c
	.global L_8fc22a
L_8fc22a:
	ld_s r0,[r13]
L_8fc22c:
	breq_s r0,0,L_8fc250
L_8fc22e:
	cmp_s r0,0x1
L_8fc230:
	beq_s L_8fc34a
L_8fc232:
	cmp_s r0,0x2
L_8fc234:
	bne_s L_8fc34a
L_8fc236:
	mov_s r1,0x100da20
L_8fc23c:
	mov_s r0,0x2b
L_8fc23e:
	mov_s r2,r21
L_8fc240:
	bl.d L_8dcc80
L_8fc244:
	bmsk r3,r14,0x3
L_8fc248:
	bl.d L_8c8ebc
L_8fc24c:
	ldb_s r0,[r13,0x10]
L_8fc24e:
	b_s L_8fc356
	.global L_8fc250
L_8fc250:
	mov_s r1,0x100da40
L_8fc256:
	mov_s r0,0x2b
L_8fc258:
	mov_s r2,r21
L_8fc25a:
	bl.d L_8dcc80
L_8fc25e:
	bmsk r3,r14,0x3
L_8fc262:
	bl L_8c3490
L_8fc266:
	mov_s r19,r0
L_8fc268:
	ldb_s r0,[r13,0x16]
L_8fc26a:
	ldw_s r14,[r13,0xe]
L_8fc26c:
	mov_s r18,r0
L_8fc26e:
	stb r0,[sp, 0x11]
L_8fc272:
	ldb_s r0,[r13,0x15]
L_8fc274:
	mov_s r1,0x100da60
L_8fc27a:
	stb_s r0,[sp,0x10]
L_8fc27c:
	ldb r4,[r13, 0x17]
L_8fc280:
	mov_s r0,0x2b
L_8fc282:
	ldb_s r2,[r13,0x12]
L_8fc284:
	bl.d L_8dcd00
L_8fc288:
	mov_s r3,r14
L_8fc28a:
	ld r17,[sp, 0x10]
L_8fc28e:
	mov_s r1,0x100daa4
L_8fc294:
	lsr r4,r17
L_8fc298:
	mov_s r0,0x2b
L_8fc29a:
	bmsk r2,r17,0x0
L_8fc29e:
	bmsk r3,r18,0x5
L_8fc2a2:
	bl.d L_8dcd00
L_8fc2a6:
	bmsk r4,r4,0x0
L_8fc2aa:
	ldb_s r0,[r13,0x17]
L_8fc2ac:
	brne_s r0,0,L_8fc2de
L_8fc2ae:
	brge 0x1f28,r14,L_8fc2de
L_8fc2b6:
	mov_s r1,0x100dadc
L_8fc2bc:
	mov_s r0,0x1b
L_8fc2be:
	mov_s r3,0x1f28
L_8fc2c4:
	bl.d L_8dcc80
L_8fc2c8:
	mov_s r2,r14
L_8fc2ca:
	mov_s r0,r15
L_8fc2cc:
	mov_s r1,0x0
L_8fc2ce:
	mov_s r2,0x1
L_8fc2d0:
	bl.d L_8f8e98
L_8fc2d4:
	mov_s r3,r20
	.global L_8fc2d6
L_8fc2d6:
	bl.d L_8cb204
L_8fc2da:
	mov_s r0,r19
L_8fc2dc:
	b_s L_8fc356
	.global L_8fc2de
L_8fc2de:
	bl.d L_8ccfd8
L_8fc2e2:
	mov_s r0,r15
L_8fc2e4:
	mov_s r20,r0
L_8fc2e6:
	mov_s r0,0x803c00
L_8fc2ec:
	ld_s r0,[r0,0xc]
L_8fc2ee:
	breq_s r0,0,L_8fc304
L_8fc2f0:
	mov_s r14,0x1f28
L_8fc2f6:
	mov_s r1,0x100db04
L_8fc2fc:
	mov_s r0,0x1b
L_8fc2fe:
	bl.d L_8dcc10
L_8fc302:
	mov_s r2,r14
	.global L_8fc304
L_8fc304:
	stw r14,[r20, 0x6]
L_8fc308:
	mov_s r0,0x0
L_8fc30a:
	extb r3,r21
L_8fc30e:
	ldb r5,[r13, 0x12]
L_8fc312:
	st_s r0,[sp,0x0]
L_8fc314:
	st_s r0,[sp,0x4]
L_8fc316:
	st_s r0,[sp,0x8]
L_8fc318:
	st_s r0,[sp,0xc]
L_8fc31a:
	mov_s r0,r19
L_8fc31c:
	mov_s r1,r15
L_8fc31e:
	mov_s r2,r16
L_8fc320:
	mov r4,0x0
L_8fc324:
	bmsk r6,r18,0x5
L_8fc328:
	bl.d L_8e6024
L_8fc32c:
	bmsk r7,r17,0x0
L_8fc330:
	add_s r1,r13,0x4
L_8fc332:
	mov_s r0,r19
L_8fc334:
	bl.d L_8c2dc4
L_8fc338:
	mov_s r2,r14
L_8fc33a:
	breq_s r0,0,L_8fc356
L_8fc33c:
	mov_s r1,0x100db2c
L_8fc342:
	bl.d L_8dcba8
L_8fc346:
	mov_s r0,0x1b
L_8fc348:
	b_s L_8fc2d6
	.global L_8fc34a
L_8fc34a:
	mov_s r0,blink
L_8fc34c:
	mov_s r1,0x11dc
L_8fc352:
	bl L_8c9b28
	.global L_8fc356
L_8fc356:
	b.d L_8c021c
L_8fc35a:
	add_s sp,sp,0x18
	.global L_8fc35c
L_8fc35c:
	mov_s r1,0x100db40
L_8fc362:
	b_s L_8fc1ec
L_8fc364:
	st.a blink,[sp,-0x4]
L_8fc368:
	mov_s r0,0x8009a8
L_8fc36e:
	bl L_8c1cc0
L_8fc372:
	mov_s r0,0x800a40
L_8fc378:
	bl L_8c1cc0
L_8fc37c:
	mov_s r0,0x800ac0
L_8fc382:
	bl L_8c1cc0
L_8fc386:
	mov_s r0,0x800af0
L_8fc38c:
	bl L_8c1cc0
L_8fc390:
	mov_s r0,0x800b28
L_8fc396:
	bl L_8c1cc0
L_8fc39a:
	mov_s r0,0x800b6c
L_8fc3a0:
	bl L_8c1cc0
L_8fc3a4:
	mov_s r0,0x800b90
L_8fc3aa:
	bl L_8c1cc0
L_8fc3ae:
	mov_s r0,0x800bb8
L_8fc3b4:
	bl L_8c1cc0
L_8fc3b8:
	mov_s r0,0x800bc4
L_8fc3be:
	bl L_8c1cc0
L_8fc3c2:
	mov_s r0,0x800bd0
L_8fc3c8:
	bl L_8c1cc0
L_8fc3cc:
	mov_s r0,0x800c10
L_8fc3d2:
	bl L_8c1cc0
L_8fc3d6:
	mov_s r0,0x800c1c
L_8fc3dc:
	bl L_8c1cc0
L_8fc3e0:
	mov_s r0,0x800c28
L_8fc3e6:
	bl L_8c1cc0
L_8fc3ea:
	mov_s r0,0x800c58
L_8fc3f0:
	bl L_8c1cc0
L_8fc3f4:
	mov_s r0,0x800dbc
L_8fc3fa:
	bl L_8c1cc0
L_8fc3fe:
	mov_s r0,0x800e20
L_8fc404:
	bl L_8c1cc0
L_8fc408:
	mov_s r0,0x80100c
L_8fc40e:
	bl L_8c1cc0
L_8fc412:
	mov_s r0,0x801018
L_8fc418:
	bl L_8c1cc0
L_8fc41c:
	mov_s r0,0x801024
L_8fc422:
	bl L_8c1cc0
L_8fc426:
	mov_s r0,0x801030
L_8fc42c:
	bl L_8c1cc0
L_8fc430:
	mov_s r0,0x80106c
L_8fc436:
	bl L_8c1cc0
L_8fc43a:
	mov_s r0,0x8010bc
L_8fc440:
	bl L_8c1cc0
L_8fc444:
	mov_s r0,0x801118
L_8fc44a:
	bl L_8c1cc0
L_8fc44e:
	mov_s r0,0x801140
L_8fc454:
	bl L_8c1cc0
L_8fc458:
	mov_s r0,0x80130c
L_8fc45e:
	bl L_8c1cc0
L_8fc462:
	mov_s r0,0x80135c
L_8fc468:
	bl L_8c1cc0
L_8fc46c:
	mov_s r0,0x8013b8
L_8fc472:
	bl L_8c1cc0
L_8fc476:
	mov_s r0,0x8013e0
L_8fc47c:
	bl L_8c1cc0
L_8fc480:
	mov_s r0,0x8013ec
L_8fc486:
	bl L_8c1cc0
L_8fc48a:
	mov_s r0,0x8013f8
L_8fc490:
	bl L_8c1cc0
L_8fc494:
	mov_s r0,0x801404
L_8fc49a:
	bl L_8c1cc0
L_8fc49e:
	mov_s r0,0x8014a4
L_8fc4a4:
	bl L_8c1cc0
L_8fc4a8:
	mov_s r0,0x80150c
L_8fc4ae:
	bl L_8c1cc0
L_8fc4b2:
	mov_s r0,0x8015e4
L_8fc4b8:
	bl L_8c1cc0
L_8fc4bc:
	mov_s r0,0x8015f0
L_8fc4c2:
	bl L_8c1cc0
L_8fc4c6:
	mov_s r0,0x8015fc
L_8fc4cc:
	bl L_8c1cc0
L_8fc4d0:
	mov_s r0,0x801644
L_8fc4d6:
	bl L_8c1cc0
L_8fc4da:
	mov_s r0,0x8016a8
L_8fc4e0:
	bl L_8c1cc0
L_8fc4e4:
	mov_s r0,0x8016e4
L_8fc4ea:
	bl L_8c1cc0
L_8fc4ee:
	mov_s r0,0x8016f0
L_8fc4f4:
	bl L_8c1cc0
L_8fc4f8:
	mov_s r0,0x8016fc
L_8fc4fe:
	bl L_8c1cc0
L_8fc502:
	mov_s r0,0x801708
L_8fc508:
	bl L_8c1cc0
L_8fc50c:
	mov_s r0,0x80175c
L_8fc512:
	bl L_8c1cc0
L_8fc516:
	mov_s r0,0x801790
L_8fc51c:
	bl L_8c1cc0
L_8fc520:
	mov_s r0,0x80179c
L_8fc526:
	bl L_8c1cc0
L_8fc52a:
	mov_s r0,0x8017d8
L_8fc530:
	bl L_8c1cc0
L_8fc534:
	mov_s r0,0x801818
L_8fc53a:
	bl L_8c1cc0
L_8fc53e:
	mov_s r0,0x801924
L_8fc544:
	bl L_8c1cc0
L_8fc548:
	mov_s r0,0x801b2c
L_8fc54e:
	bl L_8c1cc0
L_8fc552:
	nop_s
L_8fc554:
	jl 0x1ca0
L_8fc55c:
	ld.ab blink,[sp,0x4]
L_8fc560:
	j [blink]
