/* fwq_tx__init @ 0x8d62c0, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx.cpp
 * Зовут его: dma_mgr__setup_queue_pair
 * Зовёт сам: FWQ_TX_AVAILABILITY__init, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, fwq_tx__enable_queue, llist__init
 */
	.section .text.fwq_tx__init,"ax",@progbits
	.global fwq_tx__init
fwq_tx__init:
	.global L_8d62c0
L_8d62c0:
	push_s blink
L_8d62c2:
	bl L_8c02c0
L_8d62c6:
	mov.f r13,r2
L_8d62ca:
	mov_s r14,r0
L_8d62cc:
	mov_s r15,r1
L_8d62ce:
	beq_s L_8d6314
	.global L_8d62d0
L_8d62d0:
	st_s r15,[r14,0x4]
L_8d62d2:
	st_s r13,[r14]
L_8d62d4:
	mov_s r15,0x0
L_8d62d6:
	st_s r15,[r14,0x10]
L_8d62d8:
	bl.d L_8de5c4
L_8d62dc:
	add r0,r14,0x34
L_8d62e0:
	bl.d L_8de5c4
L_8d62e4:
	add3 r0,r14,0x8
L_8d62e8:
	mov_s r13,0x2
	.global L_8d62ea
L_8d62ea:
	asl_s r1,r15,0x2
L_8d62ec:
	add1_s r1,r1,r1
L_8d62ee:
	add r0,r14,0x18
L_8d62f2:
	bl.d L_8de5c4
L_8d62f6:
	add_s r0,r0,r1
L_8d62f8:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d62fa:
	/* brhs.d r13,0x1,0x008d62ea */
	.byte 0xf3,0x0d,0x75,0x90
L_8d62fe:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d6300:
	ld_s r0,[r14,0x4]
L_8d6302:
	cmp_s r0,0x1
L_8d6304:
	bl.eq L_8d5f68
L_8d6308:
	mov_s r0,r14
L_8d630a:
	bl.d L_8e2624
L_8d630e:
	mov_s r1,0x0
L_8d6310:
	b L_8c032c
	.global L_8d6314
L_8d6314:
	mov_s r0,blink
L_8d6316:
	mov_s r2,0x1015730
L_8d631c:
	mov_s r1,0x1212
L_8d6322:
	bl.d L_8c82c0
L_8d6326:
	mov r3,0x171
L_8d632a:
	b_s L_8d62d0
