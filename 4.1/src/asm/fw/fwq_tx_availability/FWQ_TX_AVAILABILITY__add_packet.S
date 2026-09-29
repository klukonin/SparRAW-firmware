/* FWQ_TX_AVAILABILITY__add_packet @ 0x8c23b8, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FWQ_TX_AVAILABILITY::add_packet cid=%d, mcs=%d
 *   [NNL] availability_vec=0x%03x, packet_cnt[%d]=%d,
 *   [NNL] dp_availability_vec=0x%03x, dp_packet_cnt[%d]=%d,
 *   fwq_tx_availability.cpp
 * Зовут его: fwq_tx__send_next
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.FWQ_TX_AVAILABILITY__add_packet,"ax",@progbits
	.global FWQ_TX_AVAILABILITY__add_packet
FWQ_TX_AVAILABILITY__add_packet:
	.global L_8c23b8
L_8c23b8:
	push_s blink
L_8c23ba:
	bl L_8c02b8
L_8c23be:
	mov_s r16,r0
L_8c23c0:
	mov_s r17,r1
L_8c23c2:
	mov_s r2,0x10158ac
L_8c23c8:
	mov_s r0,0x7
L_8c23ca:
	mov_s r1,0x2
L_8c23cc:
	mov_s r3,r16
L_8c23ce:
	bl.d L_8edff8
L_8c23d2:
	mov r4,r17
L_8c23d6:
	brge r16,0x9,L_8c244a
	.global L_8c23da
L_8c23da:
	add r1,r16,0x857040
L_8c23e2:
	ldb_s r0,[r1,0x1c]
L_8c23e4:
	mov_s r14,0x857000
L_8c23ea:
	add r5,r0,0x1
L_8c23ee:
	extb r5,r5
L_8c23f2:
	stb r5,[r1, 0x1c]
L_8c23f6:
	mov_s r13,0x0
L_8c23f8:
	ld_s r3,[r14,0x68]
L_8c23fa:
	bset r13,r13,r16
L_8c23fe:
	or_s r3,r3,r13
L_8c2400:
	st_s r3,[r14,0x68]
L_8c2402:
	mov_s r2,0x10158dc
L_8c2408:
	mov_s r0,0x7
L_8c240a:
	mov_s r1,0x2
L_8c240c:
	bl.d L_8ee034
L_8c2410:
	mov r4,r16
L_8c2414:
	brlt r17,0x1,L_8c2446
L_8c2418:
	add r1,r16,0x857060
L_8c2420:
	ldb_s r0,[r1,0xc]
L_8c2422:
	ld_s r3,[r14,0x78]
L_8c2424:
	add r5,r0,0x1
L_8c2428:
	extb r5,r5
L_8c242c:
	stb r5,[r1, 0xc]
L_8c2430:
	or_s r3,r3,r13
L_8c2432:
	st_s r3,[r14,0x78]
L_8c2434:
	mov_s r2,0x1015910
L_8c243a:
	mov_s r0,0x7
L_8c243c:
	mov_s r1,0x2
L_8c243e:
	bl.d L_8ee034
L_8c2442:
	mov r4,r16
	.global L_8c2446
L_8c2446:
	b L_8c031c
	.global L_8c244a
L_8c244a:
	mov_s r0,blink
L_8c244c:
	mov_s r2,0x1015948
L_8c2452:
	mov_s r1,0x134e
L_8c2458:
	bl.d L_8c82c0
L_8c245c:
	mov_s r3,0x14
L_8c245e:
	b_s L_8c23da
