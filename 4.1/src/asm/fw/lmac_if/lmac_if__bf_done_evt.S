/* lmac_if__bf_done_evt @ 0x8d8218, 348 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Manually failling the BF for debug
 *   BF DONE: OK. Flow type: BF_SUBFLOWS_DONE_DTI_TXSS
 *   BF DONE: OK. Flow type: BF_SUBFLOWS_DONE_DTI_TXSS_BRP
 *   BF DONE: OK. Flow type: BF_SUBFLOWS_DONE_ABFT_TXSS
 *   [NNL] CID=%2d STATE=%3d SUBSTATE=%3d
 *       DSH DBG: TX Sector: %d RX Sector: %d
 *       BF DONE: FAILED(ABORTED) CID=%2d STATE=%3d SUBSTATE=%3d
 *       MY TX SECTOR=%d     OTHER TX SECTOR=%d
 * Зовут его: lmac_if__abft_notify_evt, lmac_if__bf_done_and_new_link
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, tail_pcie__set_event_bit_8e351c, tail_pcie__set_event_bit_8e3520
 * Глобалы (через gp): 0x8002e4, 0x8002f8, 0x800304
 */
	.section .text.lmac_if__bf_done_evt,"ax",@progbits
	.global lmac_if__bf_done_evt
lmac_if__bf_done_evt:
	.global L_8d8218
L_8d8218:
	push_s blink
L_8d821a:
	bl L_8c02c4
L_8d821e:
	mov_s r14,r0
L_8d8220:
	ld_s r0,[gp,0x188]
L_8d8222:
	mov_s r13,0x0
L_8d8224:
	breq_s r0,0,L_8d824c
L_8d8226:
	ld_s r0,[gp,0x174]
L_8d8228:
	ld.as r1,[gp,0x65]
L_8d822c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d822e:
	st.as r0,[gp,0x5d]
L_8d8232:
	brne r0,r1,L_8d823c
L_8d8236:
	st.as r13,[gp,0x5d]
L_8d823a:
	b_s L_8d824c
	.global L_8d823c
L_8d823c:
	mov_s r2,0x1003f34
L_8d8242:
	mov_s r0,r13
L_8d8244:
	bl.d L_8edfb0
L_8d8248:
	mov_s r1,0x1
L_8d824a:
	st_s r13,[r14,0xc]
	.global L_8d824c
L_8d824c:
	ld_s r0,[r14,0xc]
L_8d824e:
	brne r0,0x1,L_8d82b2
L_8d8252:
	ld_s r0,[r14,0x10]
L_8d8254:
	brne_s r0,0,L_8d825e
L_8d8256:
	mov_s r2,0x1003f58
L_8d825c:
	b_s L_8d8268
	.global L_8d825e
L_8d825e:
	brne r0,0x1,L_8d8272
L_8d8262:
	mov_s r2,0x1003f8c
	.global L_8d8268
L_8d8268:
	mov_s r0,0x0
L_8d826a:
	bl.d L_8edfb0
L_8d826e:
	mov_s r1,0x2
L_8d8270:
	b_s L_8d827e
	.global L_8d8272
L_8d8272:
	brne r0,0x2,L_8d827e
L_8d8276:
	mov_s r2,0x1003fc4
L_8d827c:
	b_s L_8d8268
	.global L_8d827e
L_8d827e:
	ldb r4,[r14, 0x1a]
L_8d8282:
	mov_s r2,0x1003ff8
L_8d8288:
	ldb r5,[r14, 0x1b]
L_8d828c:
	mov_s r0,0x0
L_8d828e:
	mov_s r1,0x2
L_8d8290:
	bl.d L_8ee034
L_8d8294:
	ldb_s r3,[r14,0x4]
L_8d8296:
	mov_s r2,0x1004020
L_8d829c:
	ldb r4,[r14, 0x5]
L_8d82a0:
	mov_s r0,0x0
L_8d82a2:
	mov_s r1,0x2
L_8d82a4:
	bl.d L_8edff8
L_8d82a8:
	ldb_s r3,[r14,0x6]
L_8d82aa:
	bl.d L_8e3520
L_8d82ae:
	mov_s r13,0x1
L_8d82b0:
	b_s L_8d8308
	.global L_8d82b2
L_8d82b2:
	brne_s r0,0,L_8d82e4
L_8d82b4:
	ldb r4,[r14, 0x1a]
L_8d82b8:
	mov_s r2,0x100404c
L_8d82be:
	ldb r5,[r14, 0x1b]
L_8d82c2:
	mov_s r0,0x0
L_8d82c4:
	mov_s r1,0x1
L_8d82c6:
	bl.d L_8ee034
L_8d82ca:
	ldb_s r3,[r14,0x4]
L_8d82cc:
	mov_s r2,0x1004088
L_8d82d2:
	ldb r4,[r14, 0x8]
L_8d82d6:
	mov_s r0,0x0
L_8d82d8:
	mov_s r1,0x1
L_8d82da:
	bl.d L_8edff8
L_8d82de:
	ldb_s r3,[r14,0x6]
L_8d82e0:
	mov_s r13,0x1
L_8d82e2:
	b_s L_8d8308
	.global L_8d82e4
L_8d82e4:
	mov_s r13,0x0
L_8d82e6:
	brne r0,0x2,L_8d8308
L_8d82ea:
	mov_s r13,0x1
L_8d82ec:
	ldb r4,[r14, 0x1a]
L_8d82f0:
	mov_s r2,0x10040b4
L_8d82f6:
	ldb r5,[r14, 0x1b]
L_8d82fa:
	mov_s r0,0x0
L_8d82fc:
	mov_s r1,r13
L_8d82fe:
	bl.d L_8ee034
L_8d8302:
	ldb_s r3,[r14,0x4]
L_8d8304:
	bl L_8e351c
	.global L_8d8308
L_8d8308:
	breq r13,0x0,L_8d836e
L_8d830c:
	ld_s r3,[r14,0x1c]
L_8d830e:
	breq r3,0x20,L_8d8358
L_8d8312:
	sub_s r1,r3,0x1
L_8d8314:
	brhs r1,0x10,L_8d8360
L_8d8318:
	ldb.x r1,[0x801b88,r1]
L_8d8320:
	add r0,pcl,0x8
L_8d8324:
	add1_s r0,r0,r1
L_8d8326:
	j_s [r0]
L_8d8328:
	mov_s r2,0x10040f4
L_8d832e:
	b_s L_8d833e
L_8d8330:
	mov_s r2,0x1004134
L_8d8336:
	b_s L_8d833e
L_8d8338:
	mov_s r2,0x1004178
	.global L_8d833e
L_8d833e:
	mov_s r0,0x0
L_8d8340:
	bl.d L_8edfb0
L_8d8344:
	mov_s r1,0x2
L_8d8346:
	b_s L_8d836e
L_8d8348:
	mov_s r2,0x10041bc
L_8d834e:
	b_s L_8d833e
L_8d8350:
	mov_s r2,0x10041f8
L_8d8356:
	b_s L_8d833e
	.global L_8d8358
L_8d8358:
	mov_s r2,0x1004228
L_8d835e:
	b_s L_8d833e
	.global L_8d8360
L_8d8360:
	mov_s r2,0x1004274
L_8d8366:
	mov_s r0,0x0
L_8d8368:
	bl.d L_8edfcc
L_8d836c:
	mov_s r1,r0
	.global L_8d836e
L_8d836e:
	b L_8c0334
L_8d8372:
	nop_s
