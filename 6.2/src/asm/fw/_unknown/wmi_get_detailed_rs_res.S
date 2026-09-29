/* wmi_get_detailed_rs_res @ 0x8dd310, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   connection ID [%d] out of range
 *   get conn obj,  ID = %d
 *   conn ID = %d
 *   <<---- [HOST EVENT] WMI_GET_DETAILED_RS_RES_EVENTID  cid=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, conn_mgr__by_cid, fw_log_emit1, mem_pool__alloc_locked, memcpy_fw, memset0_words, rs__copy_detailed_result, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_get_detailed_rs_res
wmi_get_detailed_rs_res:
	.global L_8dd310
L_8dd310:
	push_s blink
L_8dd312:
	bl L_8c01d8
L_8dd316:
	sub_s sp,sp,0x24
L_8dd318:
	mov_s r16,r0
L_8dd31a:
	mov_s r14,r1
L_8dd31c:
	bl.d L_8c33d0
L_8dd320:
	mov_s r17,r2
L_8dd322:
	mov_s r13,r0
L_8dd324:
	bl.d L_8c1cd8
L_8dd328:
	mov_s r1,0x24
L_8dd32a:
	ldb_s r0,[r14]
L_8dd32c:
	stb_s r0,[r13]
L_8dd32e:
	mov_s r0,0x1
L_8dd330:
	stb_s r0,[r13,0x1]
L_8dd332:
	ldb_s r2,[r14]
L_8dd334:
	brlt r2,0x8,L_8dd346
L_8dd338:
	mov_s r1,0x1006618
L_8dd33e:
	bl.d L_8dcc10
L_8dd342:
	mov_s r0,0x5
L_8dd344:
	b_s L_8dd394
	.global L_8dd346
L_8dd346:
	mov_s r1,0x1006798
L_8dd34c:
	bl.d L_8dcc10
L_8dd350:
	mov_s r0,0x25
L_8dd352:
	bl.d L_8cbffc
L_8dd356:
	ldb_s r0,[r14]
L_8dd358:
	mov.f r14,r0
L_8dd35c:
	beq_s L_8dd394
L_8dd35e:
	mov_s r1,0x10067b0
L_8dd364:
	mov_s r0,0x25
L_8dd366:
	bl.d L_8dcc10
L_8dd36a:
	ldb_s r2,[r14,0x8]
L_8dd36c:
	add3 r1,r14,0xe
L_8dd370:
	add_s r15,sp,0x4
L_8dd372:
	bl.d L_8ccb48
L_8dd376:
	mov_s r0,r15
L_8dd378:
	ldw r1,[sp, 0x20]
L_8dd37c:
	ldw r0,[sp, 0x1e]
L_8dd380:
	asl_s r1,r1,0x10
L_8dd382:
	or_s r0,r0,r1
L_8dd384:
	breq_s r0,0,L_8dd394
L_8dd386:
	add_s r0,r13,0x2
L_8dd388:
	mov_s r1,r15
L_8dd38a:
	bl.d L_8c0380
L_8dd38e:
	mov_s r2,0x1f
L_8dd390:
	mov_s r0,0x0
L_8dd392:
	stb_s r0,[r13,0x1]
	.global L_8dd394
L_8dd394:
	mov_s r1,0x10067c0
L_8dd39a:
	mov_s r0,0x25
L_8dd39c:
	bl.d L_8dcc10
L_8dd3a0:
	ldb_s r2,[r13]
L_8dd3a2:
	mov_s r2,0x0
L_8dd3a4:
	st_s r2,[sp,0x0]
L_8dd3a6:
	mov_s r0,r16
L_8dd3a8:
	mov_s r1,r13
L_8dd3aa:
	mov_s r3,0x1922
L_8dd3b0:
	mov r4,0x24
L_8dd3b4:
	mov r5,r17
L_8dd3b8:
	mov_s r6,r2
L_8dd3ba:
	bl.d L_8e4fc4
L_8dd3be:
	mov_s r7,r2
L_8dd3c0:
	b.d L_8c023c
L_8dd3c4:
	add_s sp,sp,0x24
L_8dd3c6:
	nop_s
