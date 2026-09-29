/* txq_ring_param_config_queue @ 0x8ea4b8, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txq_ring_param_config_queue (payload_length_lines %d)(max_msdu_size_bytes %d)(PTP_PAYLOAD_PIPE_LEN_BYTE %d)
 * Зовут его: tx_macq__config_ring_params
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set32_s0_w12, bits__set32_s0_w4, bits__set32_s12_w12, bits__set32_s16_w12, bits__set32_s28_w4, bits__set32_s4_w12, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global txq_ring_param_config_queue
txq_ring_param_config_queue:
	.global L_8ea4b8
L_8ea4b8:
	push_s blink
L_8ea4ba:
	bl L_8c01e0
L_8ea4be:
	mov_s r14,r0
L_8ea4c0:
	mov_s r15,r1
L_8ea4c2:
	mov_s r13,r2
L_8ea4c4:
	ldw_s r2,[r2,0x4]
L_8ea4c6:
	brne r3,0x4,L_8ea54a
L_8ea4ca:
	brlt r2,0x3000,L_8ea542
L_8ea4d2:
	ldw_s r1,[r13,0x6]
L_8ea4d4:
	add_s r1,r1,r2
L_8ea4d6:
	brlt 0x5200,r1,L_8ea542
	.global L_8ea4de
L_8ea4de:
	/* add_s r15,0x7 */
	.byte 0x07,0xe7
L_8ea4e0:
	lsr_s r15,r15,0x3
L_8ea4e2:
	ldw_s r2,[r13,0x6]
L_8ea4e4:
	add r0,r15,0x9
L_8ea4e8:
	brhs r0,r2,L_8ea56c
	.global L_8ea4ec
L_8ea4ec:
	ldw_s r0,[r13,0xa]
L_8ea4ee:
	brlt r0,0x6,L_8ea58a
	.global L_8ea4f2
L_8ea4f2:
	ldw_s r0,[r13,0x4]
L_8ea4f4:
	bmsk r1,r15,0xb
L_8ea4f8:
	stw_s r0,[r14]
L_8ea4fa:
	ldw_s r0,[r13,0x4]
L_8ea4fc:
	stw_s r0,[r14,0x2]
L_8ea4fe:
	ldw_s r0,[r13,0x4]
L_8ea500:
	stw_s r0,[r14,0x6]
L_8ea502:
	ldw_s r0,[r13,0x6]
L_8ea504:
	stw_s r0,[r14,0x4]
L_8ea506:
	add r0,r14,0x8
L_8ea50a:
	bl L_8ed340
L_8ea50e:
	ldw_s r1,[r13,0x8]
L_8ea510:
	bmsk_s r1,r1,0xb
L_8ea512:
	bl L_8ed3a0
L_8ea516:
	ldw_s r0,[r13,0x8]
L_8ea518:
	stb_s r0,[r14,0xb]
L_8ea51a:
	ldw_s r1,[r13,0x8]
L_8ea51c:
	add r0,r14,0xc
L_8ea520:
	lsr_s r1,r1,0x8
L_8ea522:
	bmsk_s r1,r1,0x3
L_8ea524:
	bl L_8ed370
L_8ea528:
	ldw_s r1,[r13,0x8]
L_8ea52a:
	bmsk_s r1,r1,0xb
L_8ea52c:
	bl L_8ed3e8
L_8ea530:
	ldw_s r1,[r13,0xa]
L_8ea532:
	bmsk_s r1,r1,0xb
L_8ea534:
	bl L_8ed4f0
L_8ea538:
	mov_s r1,0x0
L_8ea53a:
	bl L_8ed4a8
L_8ea53e:
	b L_8c024c
	.global L_8ea542
L_8ea542:
	mov_s r0,blink
L_8ea544:
	mov_s r1,0x20
L_8ea546:
	bset_s r1,r1,0xc
L_8ea548:
	b_s L_8ea566
	.global L_8ea54a
L_8ea54a:
	brlt r2,0x2000,L_8ea55e
L_8ea552:
	ldw_s r0,[r13,0x6]
L_8ea554:
	add_s r0,r0,r2
L_8ea556:
	brge 0x5200,r0,L_8ea4de
	.global L_8ea55e
L_8ea55e:
	mov_s r0,blink
L_8ea560:
	mov_s r1,0x1557
	.global L_8ea566
L_8ea566:
	bl L_8c9b28
L_8ea56a:
	b_s L_8ea4de
	.global L_8ea56c
L_8ea56c:
	mov_s r1,0x101346c
L_8ea572:
	mov_s r0,0x0
L_8ea574:
	mov_s r3,r15
L_8ea576:
	bl.d L_8dcd00
L_8ea57a:
	mov r4,0x9
L_8ea57e:
	mov_s r0,blink
L_8ea580:
	mov_s r1,0x24
L_8ea582:
	bl.d L_8c9b28
L_8ea586:
	bset_s r1,r1,0xc
L_8ea588:
	b_s L_8ea4ec
	.global L_8ea58a
L_8ea58a:
	mov_s r0,blink
L_8ea58c:
	mov_s r1,0x21
L_8ea58e:
	bl.d L_8c9b28
L_8ea592:
	bset_s r1,r1,0xc
L_8ea594:
	b_s L_8ea4f2
L_8ea596:
	nop_s
