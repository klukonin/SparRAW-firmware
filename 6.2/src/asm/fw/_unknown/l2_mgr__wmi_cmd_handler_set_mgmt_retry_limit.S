/* l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit @ 0x8ec35c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_set_mgmt_retry_limit, mng_retry_limit:%d
 *   MGMT RETRY LIMIT[%d] out of range [1...254]
 *   <<---- [HOST EVENT] WMI_SET_MGMT_RETRY_LIMIT_EVENT
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit1, mem_pool__alloc_locked, memset0_words, tx_api__set_mgmt_retry_limit, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit
l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit:
	.global L_8ec35c
L_8ec35c:
	push_s blink
L_8ec35e:
	bl L_8c01dc
L_8ec362:
	sub_s sp,sp,0x4
L_8ec364:
	mov_s r14,r0
L_8ec366:
	mov_s r16,r1
L_8ec368:
	mov_s r15,r2
L_8ec36a:
	mov_s r1,0x100e320
L_8ec370:
	mov_s r0,0x2b
L_8ec372:
	bl.d L_8dcc10
L_8ec376:
	ldb_s r2,[r14]
L_8ec378:
	bl.d L_8c33d0
L_8ec37c:
	mov_s r0,r15
L_8ec37e:
	mov_s r13,r0
L_8ec380:
	bl.d L_8c1cd8
L_8ec384:
	mov_s r1,0x4
L_8ec386:
	mov_s r0,0x1
L_8ec388:
	stb_s r0,[r13]
L_8ec38a:
	ldb_s r2,[r14]
L_8ec38c:
	cmp r2,0xfe
L_8ec390:
	bgt_s L_8ec394
L_8ec392:
	brne_s r2,0,L_8ec3a2
	.global L_8ec394
L_8ec394:
	mov_s r1,0x100e364
L_8ec39a:
	bl.d L_8dcc10
L_8ec39e:
	mov_s r0,0xb
L_8ec3a0:
	b_s L_8ec3ae
	.global L_8ec3a2
L_8ec3a2:
	sub_s r0,r2,0x1
L_8ec3a4:
	bl.d L_8e6900
L_8ec3a8:
	extb_s r0,r0
L_8ec3aa:
	mov_s r0,0x0
L_8ec3ac:
	stb_s r0,[r13]
	.global L_8ec3ae
L_8ec3ae:
	mov_s r1,0x100e390
L_8ec3b4:
	bl.d L_8dcba8
L_8ec3b8:
	mov_s r0,0x2b
L_8ec3ba:
	mov_s r2,0x0
L_8ec3bc:
	st_s r2,[sp,0x0]
L_8ec3be:
	mov_s r0,r15
L_8ec3c0:
	mov_s r1,r13
L_8ec3c2:
	mov_s r3,0x1930
L_8ec3c8:
	mov r4,0x4
L_8ec3cc:
	mov r5,r16
L_8ec3d0:
	mov_s r6,r2
L_8ec3d2:
	bl.d L_8e4fc4
L_8ec3d6:
	mov_s r7,r2
L_8ec3d8:
	b.d L_8c0244
L_8ec3dc:
	add_s sp,sp,0x4
L_8ec3de:
	nop_s
