/* FWQ_TX_AVAILABILITY__remove_packet @ 0x8e26a4, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [NNL] dp_availability_vec=0x%03x, dp_packet_cnt[%d]=%d,
 * Зовут его: TX_API__awake_peer_ntf, TX_API__callback_and_release, TX_API__handle_completed_packets, fwq_tx__long_retry_failures
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global FWQ_TX_AVAILABILITY__remove_packet
FWQ_TX_AVAILABILITY__remove_packet:
	.global L_8e26a4
L_8e26a4:
	push_s blink
L_8e26a6:
	bl L_8c01dc
L_8e26aa:
	mov_s r13,r0
L_8e26ac:
	brge.d r0,0x9,L_8e2706
L_8e26b0:
	mov_s r16,r1
	.global L_8e26b2
L_8e26b2:
	add r14,r13,0x857040
L_8e26ba:
	ldb_s r0,[r14,0x4]
L_8e26bc:
	mov_s r15,0x857000
L_8e26c2:
	breq_s r0,0,L_8e2714
	.global L_8e26c4
L_8e26c4:
	ldb_s r0,[r14,0x4]
L_8e26c6:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e26c8:
	extb.f r0,r0
L_8e26cc:
	stb_s r0,[r14,0x4]
L_8e26ce:
	bne_s L_8e26d8
L_8e26d0:
	ld_s r0,[r15,0x50]
L_8e26d2:
	bclr r0,r0,r13
L_8e26d6:
	st_s r0,[r15,0x50]
	.global L_8e26d8
L_8e26d8:
	brlt r16,0x1,L_8e2702
L_8e26dc:
	ldb_s r0,[r14,0x14]
L_8e26de:
	sub r4,r0,0x1
L_8e26e2:
	extb.f r4,r4
L_8e26e6:
	stb r4,[r14, 0x14]
L_8e26ea:
	ld_s r2,[r15,0x60]
L_8e26ec:
	bne_s L_8e26f4
L_8e26ee:
	bclr r2,r2,r13
L_8e26f2:
	st_s r2,[r15,0x60]
	.global L_8e26f4
L_8e26f4:
	mov_s r1,0x1018cac
L_8e26fa:
	mov_s r0,0x27
L_8e26fc:
	bl.d L_8dcd00
L_8e2700:
	mov_s r3,r13
	.global L_8e2702
L_8e2702:
	b L_8c0244
	.global L_8e2706
L_8e2706:
	mov_s r0,blink
L_8e2708:
	mov_s r1,0x134f
L_8e270e:
	bl L_8c9b28
L_8e2712:
	b_s L_8e26b2
	.global L_8e2714
L_8e2714:
	mov_s r0,blink
L_8e2716:
	mov_s r1,0x134d
L_8e271c:
	bl L_8c9b28
L_8e2720:
	b_s L_8e26c4
L_8e2722:
	nop_s
