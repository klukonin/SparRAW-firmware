/* basic_sm__do_transition @ 0x8ca2d0, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   %s evt:%s state:%s
 *   %s evt:%s state:%s bad evt_table_ptr
 *   evt_table_ptr:%08x
 * Зовут его: basic_sm__handle_event
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit1, fwq_tx__long_retry_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global basic_sm__do_transition
basic_sm__do_transition:
	.global L_8ca2d0
L_8ca2d0:
	push_s blink
L_8ca2d2:
	bl L_8c01d4
L_8ca2d6:
	mov_s r13,r0
L_8ca2d8:
	mov_s r14,r1
L_8ca2da:
	mov_s r18,r2
L_8ca2dc:
	ld_s r2,[r0,0x4]
L_8ca2de:
	mov r16,r4
L_8ca2e2:
	ldb_s r0,[r2,0x1]
L_8ca2e4:
	mov_s r17,r3
L_8ca2e6:
	ldb_s r15,[r13]
L_8ca2e8:
	mulu64 r0,r1
L_8ca2ec:
	ld_s r0,[r2,0x4]
L_8ca2ee:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8ca2f0:
	add_s r15,r15,mlo
L_8ca2f2:
	add2 r1,r15,r15
L_8ca2f6:
	ldb_s r0,[r0,r1]
L_8ca2f8:
	ldb_s r1,[r13,0x3]
L_8ca2fa:
	stb_s r0,[r13]
L_8ca2fc:
	stb_s r14,[r13,0x1]
L_8ca2fe:
	breq_s r1,0,L_8ca31c
L_8ca300:
	ld_s r3,[r2,0xc]
L_8ca302:
	mov_s r1,0x10019ec
L_8ca308:
	ld.as r5,[r3,r14]
L_8ca30c:
	ld_s r3,[r2,0x8]
L_8ca30e:
	ld.as r4,[r3,r0]
L_8ca312:
	mov_s r0,0x25
L_8ca314:
	ld_s r2,[r2,0x10]
L_8ca316:
	bl.d L_8dce84
L_8ca31a:
	mov_s r3,r5
	.global L_8ca31c
L_8ca31c:
	ld_s r2,[r13,0x4]
L_8ca31e:
	ld_s r0,[r2,0x4]
L_8ca320:
	brhs r0,0x800000,L_8ca354
L_8ca328:
	ld_s r0,[r2,0xc]
L_8ca32a:
	mov_s r1,0x1001a00
L_8ca330:
	ld.as r3,[r0,r14]
L_8ca334:
	ld_s r0,[r2,0x8]
L_8ca336:
	ldb_s r14,[r13]
L_8ca338:
	ld.as r4,[r0,r14]
L_8ca33c:
	mov_s r0,0x25
L_8ca33e:
	bl.d L_8dce84
L_8ca342:
	ld_s r2,[r2,0x10]
L_8ca344:
	mov_s r1,0x1001a28
L_8ca34a:
	ld_s r2,[r13,0x4]
L_8ca34c:
	mov_s r0,0x25
L_8ca34e:
	bl.d L_8dcc10
L_8ca352:
	ld_s r2,[r2,0x4]
	.global L_8ca354
L_8ca354:
	ld_s r0,[r13,0x4]
L_8ca356:
	add2_s r15,r15,r15
L_8ca358:
	ld_s r1,[r0,0x4]
L_8ca35a:
	mov_s r2,r17
L_8ca35c:
	add r10,r1,r15
L_8ca360:
	ldb r0,[r10, 0x1]
L_8ca364:
	ldb_s r14,[r1,r15]
L_8ca366:
	asl_s r0,r0,0x8
L_8ca368:
	or_s r14,r14,r0
L_8ca36a:
	ldb r0,[r10, 0x2]
L_8ca36e:
	mov_s r1,r18
L_8ca370:
	asl_s r0,r0,0x10
L_8ca372:
	or_s r14,r14,r0
L_8ca374:
	ldb r0,[r10, 0x3]
L_8ca378:
	asl_s r0,r0,0x18
L_8ca37a:
	or_s r14,r14,r0
L_8ca37c:
	mov_s r0,r13
L_8ca37e:
	jl_s.d [r14]
L_8ca380:
	mov_s r3,r16
L_8ca382:
	b L_8c0234
L_8ca386:
	nop_s
