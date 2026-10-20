/* stream_mgr__info_req @ 0x8d5428, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Information request -Ignored sta_idx %d, isn't active.
 *   CID[%d] Handle Information Req from for ADDR-%04X%08X
 *   CID [%d]:Ignore Information request, my addr: ADDR-%04X%08X
 * Зовут его: stream_mgr__rx_action
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__by_cid, fw_log__emit1, fw_log__emit3, stream_mgr__send_info_response
 */
	.section .text.stream_mgr__info_req,"ax",@progbits
	.global stream_mgr__info_req
stream_mgr__info_req:
	.global L_8d5428
L_8d5428:
	push_s blink
L_8d542a:
	bl L_8c02c0
L_8d542e:
	mov_s r15,r2
L_8d5430:
	add_s r13,r0,0x2
L_8d5432:
	bl.d L_8c9e44
L_8d5436:
	mov_s r0,r2
L_8d5438:
	mov.f r14,r0
L_8d543c:
	bne_s L_8d5450
L_8d543e:
	mov_s r2,0x100e51c
L_8d5444:
	mov_s r0,0xb
L_8d5446:
	mov_s r1,0x2
L_8d5448:
	bl.d L_8edfcc
L_8d544c:
	mov_s r3,r15
L_8d544e:
	b_s L_8d54e8
	.global L_8d5450
L_8d5450:
	ldw r4,[r13, 0x4]
L_8d5454:
	mov_s r2,0x100e554
L_8d545a:
	ld r5,[r13]
L_8d545e:
	mov_s r0,0xb
L_8d5460:
	mov_s r1,0x2
L_8d5462:
	bl.d L_8ee034
L_8d5466:
	mov_s r3,r15
L_8d5468:
	ldb_s r1,[r13]
L_8d546a:
	mov_s r2,0xff
L_8d546c:
	ld_s r0,[r14,0xc]
L_8d546e:
	add r3,r0,0xa
L_8d5472:
	brne r1,r2,L_8d5494
L_8d5476:
	ldb_s r1,[r13,0x1]
L_8d5478:
	brne r1,r2,L_8d5494
L_8d547c:
	ldb_s r1,[r13,0x2]
L_8d547e:
	brne r1,r2,L_8d5494
L_8d5482:
	ldb_s r1,[r13,0x3]
L_8d5484:
	brne r1,r2,L_8d5494
L_8d5488:
	ldb_s r1,[r13,0x4]
L_8d548a:
	brne r1,r2,L_8d5494
L_8d548e:
	ldb_s r1,[r13,0x5]
L_8d5490:
	breq r1,r2,L_8d54c4
	.global L_8d5494
L_8d5494:
	ldb_s r2,[r13]
L_8d5496:
	ldb_s r1,[r3]
L_8d5498:
	brne r2,r1,L_8d54d0
L_8d549c:
	ldb_s r2,[r13,0x1]
L_8d549e:
	ldb_s r1,[r3,0x1]
L_8d54a0:
	brne r2,r1,L_8d54d0
L_8d54a4:
	ldb_s r2,[r13,0x2]
L_8d54a6:
	ldb_s r1,[r3,0x2]
L_8d54a8:
	brne r2,r1,L_8d54d0
L_8d54ac:
	ldb_s r2,[r13,0x3]
L_8d54ae:
	ldb_s r1,[r3,0x3]
L_8d54b0:
	brne r2,r1,L_8d54d0
L_8d54b4:
	ldb_s r2,[r13,0x4]
L_8d54b6:
	ldb_s r1,[r3,0x4]
L_8d54b8:
	brne r2,r1,L_8d54d0
L_8d54bc:
	ldb_s r2,[r13,0x5]
L_8d54be:
	ldb_s r1,[r3,0x5]
L_8d54c0:
	brne r2,r1,L_8d54d0
	.global L_8d54c4
L_8d54c4:
	add_s r3,r13,0x7
L_8d54c6:
	mov_s r1,r14
L_8d54c8:
	bl.d L_8d54ec
L_8d54cc:
	mov_s r2,r13
L_8d54ce:
	b_s L_8d54e8
	.global L_8d54d0
L_8d54d0:
	ldw r4,[r3, 0x4]
L_8d54d4:
	mov_s r2,0x100e58c
L_8d54da:
	ld r5,[r3]
L_8d54de:
	mov_s r0,0xb
L_8d54e0:
	mov_s r1,0x2
L_8d54e2:
	bl.d L_8ee034
L_8d54e6:
	mov_s r3,r15
	.global L_8d54e8
L_8d54e8:
	b L_8c032c
