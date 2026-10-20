/* FWQ_TX_AVAILABILITY__remove_packet @ 0x8de304, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FWQ_TX_AVAILABILITY::remove_packet cid=%d, mcs=%d
 *   [NNL] availability_vec=0x%03x, packet_cnt[%d]=%d,
 *   [NNL] dp_availability_vec=0x%03x, dp_packet_cnt[%d]=%d,
 *   fwq_tx_availability.cpp
 * Зовут его: TX_API__awake_peer_ntf, TX_API__callback_and_release, TX_API__handle_completed_packets
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.FWQ_TX_AVAILABILITY__remove_packet,"ax",@progbits
	.global FWQ_TX_AVAILABILITY__remove_packet
FWQ_TX_AVAILABILITY__remove_packet:
	.global L_8de304
L_8de304:
	push_s blink
L_8de306:
	bl L_8c02b8
L_8de30a:
	mov_s r16,r0
L_8de30c:
	mov_s r17,r1
L_8de30e:
	mov_s r2,0x1015960
L_8de314:
	mov_s r0,0x7
L_8de316:
	mov_s r1,0x2
L_8de318:
	mov_s r3,r16
L_8de31a:
	bl.d L_8edff8
L_8de31e:
	mov r4,r17
L_8de322:
	brge r16,0x9,L_8de39c
	.global L_8de326
L_8de326:
	add r13,r16,0x857040
L_8de32e:
	ldb_s r0,[r13,0x1c]
L_8de330:
	mov_s r14,0x857000
L_8de336:
	breq r0,0x0,L_8de3b2
	.global L_8de33a
L_8de33a:
	ldb_s r0,[r13,0x1c]
L_8de33c:
	sub r5,r0,0x1
L_8de340:
	extb.f r5,r5
L_8de344:
	stb r5,[r13, 0x1c]
L_8de348:
	ld_s r3,[r14,0x68]
L_8de34a:
	bne_s L_8de352
L_8de34c:
	bclr r3,r3,r16
L_8de350:
	st_s r3,[r14,0x68]
	.global L_8de352
L_8de352:
	mov_s r2,0x10158dc
L_8de358:
	mov_s r0,0x7
L_8de35a:
	mov_s r1,0x2
L_8de35c:
	bl.d L_8ee034
L_8de360:
	mov r4,r16
L_8de364:
	brlt r17,0x1,L_8de398
L_8de368:
	add r0,r16,0x857060
L_8de370:
	ldb_s r13,[r0,0xc]
L_8de372:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8de374:
	extb.f r13,r13
L_8de378:
	stb_s r13,[r0,0xc]
L_8de37a:
	ld_s r3,[r14,0x78]
L_8de37c:
	bne_s L_8de384
L_8de37e:
	bclr r3,r3,r16
L_8de382:
	st_s r3,[r14,0x78]
	.global L_8de384
L_8de384:
	mov_s r2,0x1015910
L_8de38a:
	mov_s r0,0x7
L_8de38c:
	mov_s r1,0x2
L_8de38e:
	mov r4,r16
L_8de392:
	bl.d L_8ee034
L_8de396:
	mov_s r5,r13
	.global L_8de398
L_8de398:
	b L_8c031c
	.global L_8de39c
L_8de39c:
	mov_s r0,blink
L_8de39e:
	mov_s r2,0x1015948
L_8de3a4:
	mov_s r1,0x134f
L_8de3aa:
	bl.d L_8c82c0
L_8de3ae:
	mov_s r3,0x2e
L_8de3b0:
	b_s L_8de326
	.global L_8de3b2
L_8de3b2:
	mov_s r0,blink
L_8de3b4:
	mov_s r2,0x1015948
L_8de3ba:
	mov_s r1,0x134d
L_8de3c0:
	bl.d L_8c82c0
L_8de3c4:
	mov_s r3,0x2f
L_8de3c6:
	b_s L_8de33a
