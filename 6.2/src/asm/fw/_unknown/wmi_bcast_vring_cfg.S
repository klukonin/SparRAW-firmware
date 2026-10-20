/* wmi_bcast_vring_cfg @ 0x8fb4e0, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BCAST NEW VRING: %d
 *   TX max_msdu_size = %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit1, fw_sysassert_fatal, init_bcast_queue, mid__type_of, mid_list__by_mid_fw, stream_mgr__add_bcast_vring, stream_mgr__delete_vring, vring__configure_tx, vring_ctx__alloc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_bcast_vring_cfg
wmi_bcast_vring_cfg:
	.global L_8fb4e0
L_8fb4e0:
	push_s blink
L_8fb4e2:
	bl L_8c01d4
L_8fb4e6:
	ldb_s r14,[r0,0x10]
L_8fb4e8:
	mov_s r13,r0
L_8fb4ea:
	sub_s sp,sp,0x10
L_8fb4ec:
	brhs.d r14,0xa,L_8fb506
L_8fb4f0:
	mov_s r16,r1
L_8fb4f2:
	ld_s r0,[r13]
L_8fb4f4:
	breq_s r0,0,L_8fb51e
L_8fb4f6:
	breq r0,0x1,L_8fb510
L_8fb4fa:
	brne r0,0x2,L_8fb510
L_8fb4fe:
	bl.d L_8c8ebc
L_8fb502:
	mov_s r0,r14
L_8fb504:
	b_s L_8fb586
	.global L_8fb506
L_8fb506:
	mov_s r1,0x11f6
L_8fb50c:
	mov_s r0,blink
L_8fb50e:
	b_s L_8fb518
	.global L_8fb510
L_8fb510:
	mov_s r0,blink
L_8fb512:
	mov_s r1,0x11d1
	.global L_8fb518
L_8fb518:
	bl L_8c9b28
L_8fb51c:
	b_s L_8fb586
	.global L_8fb51e
L_8fb51e:
	mov_s r1,0x100db88
L_8fb524:
	mov_s r0,0x2b
L_8fb526:
	bl.d L_8dcc10
L_8fb52a:
	mov_s r2,r14
L_8fb52c:
	bl L_8c3490
L_8fb530:
	mov_s r1,0x100db9c
L_8fb536:
	mov_s r18,r0
L_8fb538:
	ldw_s r15,[r13,0xe]
L_8fb53a:
	mov_s r0,0x2b
L_8fb53c:
	bl.d L_8dcc10
L_8fb540:
	mov_s r2,r15
L_8fb542:
	bl.d L_8cc3dc
L_8fb546:
	mov_s r0,r16
L_8fb548:
	mov.f r17,r0
L_8fb54c:
	beq_s L_8fb58c
	.global L_8fb54e
L_8fb54e:
	mov_s r0,r15
L_8fb550:
	bl.d L_8d973c
L_8fb554:
	mov_s r1,r14
L_8fb556:
	mov_s r15,0x1
L_8fb558:
	bl.d L_8ccecc
L_8fb55c:
	mov_s r0,r17
L_8fb55e:
	ldb r5,[r13, 0x11]
L_8fb562:
	st_s r15,[sp,0x0]
L_8fb564:
	st_s r0,[sp,0x4]
L_8fb566:
	st r16,[sp, 0x8]
L_8fb56a:
	st_s r15,[sp,0xc]
L_8fb56c:
	mov_s r0,r18
L_8fb56e:
	mov_s r1,r14
L_8fb570:
	mov_s r2,0x0
L_8fb572:
	mov_s r3,r2
L_8fb574:
	mov_s r4,r2
L_8fb576:
	mov_s r6,r2
L_8fb578:
	bl.d L_8e6024
L_8fb57c:
	mov_s r7,r2
L_8fb57e:
	add_s r1,r13,0x4
L_8fb580:
	bl.d L_8c2720
L_8fb584:
	mov_s r0,r18
	.global L_8fb586
L_8fb586:
	b.d L_8c0234
L_8fb58a:
	add_s sp,sp,0x10
	.global L_8fb58c
L_8fb58c:
	mov_s r0,blink
L_8fb58e:
	mov_s r1,0x5b
L_8fb590:
	/* bl.d 0x008c9b28 */
	.byte 0x9a,0x0d,0x2f,0xe7
L_8fb594:
	/* _asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8fb596:
	b_s L_8fb54e
