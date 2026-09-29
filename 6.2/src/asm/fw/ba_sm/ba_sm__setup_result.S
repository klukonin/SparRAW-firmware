/* ba_sm__setup_result @ 0x8c42a4, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ADDBA RESP send: tid %d , token %d, STATUS REFUSED
 * Зовут его: stream_mgr__action
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, frame__build_addba_resp, fw_log_emit2, mgmt_tx__begin_frame, tx_api__send_mgmt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__setup_result
ba_sm__setup_result:
	.global L_8c42a4
L_8c42a4:
	push_s blink
L_8c42a6:
	bl L_8c01dc
L_8c42aa:
	mov_s r13,r0
L_8c42ac:
	mov_s r14,r1
L_8c42ae:
	mov_s r15,0x0
L_8c42b0:
	bl.d L_8c3414
L_8c42b4:
	push_s r15
L_8c42b6:
	mov_s r16,r0
L_8c42b8:
	mov_s r1,sp
L_8c42ba:
	ld_s r2,[r14,0x18]
L_8c42bc:
	mov_s r3,r14
L_8c42be:
	bl.d L_8e9c7c
L_8c42c2:
	mov r4,0xd
L_8c42c6:
	ld_s r0,[sp,0x0]
L_8c42c8:
	ldb_s r3,[r13,0x3]
L_8c42ca:
	add_s r0,r0,r16
L_8c42cc:
	lsr_s r3,r3,0x2
L_8c42ce:
	ldb_s r1,[r13,0x2]
L_8c42d0:
	mov_s r2,r15
L_8c42d2:
	bmsk_s r3,r3,0x3
L_8c42d4:
	mov_s r4,r15
L_8c42d6:
	mov r5,0x1
L_8c42da:
	bl.d L_8f4e30
L_8c42de:
	mov_s r6,r15
L_8c42e0:
	ld_s r1,[sp,0x0]
L_8c42e2:
	mov_s r2,0x1
L_8c42e4:
	add_s r0,r0,r1
L_8c42e6:
	st_s r0,[sp,0x0]
L_8c42e8:
	extw r4,r0
L_8c42ec:
	mov_s r0,r14
L_8c42ee:
	mov_s r1,r15
L_8c42f0:
	mov_s r3,r16
L_8c42f2:
	mov_s r5,r15
L_8c42f4:
	bl.d L_8e5874
L_8c42f8:
	mov_s r6,r15
L_8c42fa:
	ldb_s r2,[r13,0x3]
L_8c42fc:
	mov_s r1,0x10106bc
L_8c4302:
	lsr_s r2,r2,0x2
L_8c4304:
	mov_s r0,0x2b
L_8c4306:
	bmsk_s r2,r2,0x3
L_8c4308:
	bl.d L_8dcc80
L_8c430c:
	ldb_s r3,[r13,0x2]
L_8c430e:
	b.d L_8c0244
L_8c4312:
	add_s sp,sp,0x4
