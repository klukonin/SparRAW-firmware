/* fwq_tx__init @ 0x8d92e0, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__setup_queue_pair
 * Зовёт сам: FWQ_TX_AVAILABILITY__init, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, fwq_tx__enable_queue, llist__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__init
fwq_tx__init:
	.global L_8d92e0
L_8d92e0:
	push_s blink
L_8d92e2:
	bl L_8c01e0
L_8d92e6:
	mov.f r13,r2
L_8d92ea:
	mov_s r14,r0
L_8d92ec:
	mov_s r15,r1
L_8d92ee:
	beq_s L_8d9334
	.global L_8d92f0
L_8d92f0:
	st_s r15,[r14,0x4]
L_8d92f2:
	st_s r13,[r14]
L_8d92f4:
	mov_s r15,0x0
L_8d92f6:
	st_s r15,[r14,0x10]
L_8d92f8:
	bl.d L_8e293c
L_8d92fc:
	add r0,r14,0x34
L_8d9300:
	bl.d L_8e293c
L_8d9304:
	add3 r0,r14,0x8
L_8d9308:
	mov_s r13,0x2
	.global L_8d930a
L_8d930a:
	asl_s r1,r15,0x2
L_8d930c:
	add1_s r1,r1,r1
L_8d930e:
	add r0,r14,0x18
L_8d9312:
	bl.d L_8e293c
L_8d9316:
	add_s r0,r0,r1
L_8d9318:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d931a:
	brhs.d r13,0x1,L_8d930a
L_8d931e:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d9320:
	ld_s r0,[r14,0x4]
L_8d9322:
	cmp_s r0,0x1
L_8d9324:
	bl.eq L_8d9084
L_8d9328:
	mov_s r0,r14
L_8d932a:
	bl.d L_8e787c
L_8d932e:
	mov_s r1,0x0
L_8d9330:
	b L_8c024c
	.global L_8d9334
L_8d9334:
	mov_s r0,blink
L_8d9336:
	mov_s r1,0x1212
L_8d933c:
	bl L_8c9b28
L_8d9340:
	b_s L_8d92f0
L_8d9342:
	nop_s
