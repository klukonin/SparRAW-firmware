/* tx_macq__setup @ 0x8d944c, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: init_bcast_queue, tx_macq_api_step, tx_queue_mgr__create_queue
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, ba_sm__addba_at_08, fw_sysassert_fatal, mac_ring_enable, qh__write_or_conn_alloc, sm_pring__all_wb_done_evt, tx_macq__setup_params
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_macq__setup
tx_macq__setup:
	.global L_8d944c
L_8d944c:
	push_s blink
L_8d944e:
	bl L_8c01cc
L_8d9452:
	sub_s sp,sp,0x70
L_8d9454:
	mov_s r14,r0
L_8d9456:
	mov_s r15,r1
L_8d9458:
	mov_s r20,r3
L_8d945a:
	mov r17,r4
L_8d945e:
	ldb_s r0,[r0,0xc]
L_8d9460:
	mov r16,r6
L_8d9464:
	mov r18,r5
L_8d9468:
	mov r19,r7
L_8d946c:
	brne r0,0x1,L_8d94d0
	.global L_8d9470
L_8d9470:
	stb_s r15,[r14,0xb]
L_8d9472:
	stw 0x1f28,[r14, 0x6]
L_8d947a:
	mov_s r0,r14
L_8d947c:
	mov_s r1,0x0
L_8d947e:
	mov_s r2,r20
L_8d9480:
	mov_s r3,0xa
L_8d9482:
	bl.d L_8c6e44
L_8d9486:
	mov_s r4,r1
L_8d9488:
	mov_s r13,sp
L_8d948a:
	mov_s r0,r14
L_8d948c:
	bl.d L_8c3180
L_8d9490:
	mov_s r1,r13
L_8d9492:
	mov_s r0,r14
L_8d9494:
	mov_s r1,r13
L_8d9496:
	mov_s r2,r16
L_8d9498:
	mov_s r3,r17
L_8d949a:
	mov r4,r18
L_8d949e:
	mov r5,r19
L_8d94a2:
	bl.d L_8c4540
L_8d94a6:
	mov r6,0x1
L_8d94aa:
	ldb_s r0,[r14,0xa]
L_8d94ac:
	mov_s r1,0x14
L_8d94ae:
	mov_s r2,r13
L_8d94b0:
	bl.d L_8ea5b0
L_8d94b4:
	mov_s r3,r18
L_8d94b6:
	cmp_s r15,0x5
L_8d94b8:
	cmp.ne r15,0x6
L_8d94bc:
	beq_s L_8d94c6
L_8d94be:
	ldb_s r0,[r14,0xa]
L_8d94c0:
	bl.d L_8ea438
L_8d94c4:
	mov_s r1,0x0
	.global L_8d94c6
L_8d94c6:
	mov_s r0,0x2
L_8d94c8:
	stb_s r0,[r14,0xc]
L_8d94ca:
	b.d L_8c0224
L_8d94ce:
	add_s sp,sp,0x70
	.global L_8d94d0
L_8d94d0:
	mov_s r0,blink
L_8d94d2:
	mov_s r1,0x127b
L_8d94d8:
	bl L_8c9b28
L_8d94dc:
	b_s L_8d9470
L_8d94de:
	nop_s
