/* rx_macq__build_ba_desc @ 0x8e4448, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__program_ba_win
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set32_s0_w12, bits__set32_s0_w4, bits__set32_s12_w12, bits__set32_s16_w12, bits__set32_s29_w3, bits__set32_s4_w12, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__build_ba_desc
rx_macq__build_ba_desc:
	.global L_8e4448
L_8e4448:
	push_s blink
L_8e444a:
	bl.d L_8c01dc
L_8e444e:
	/* _add_s r1,0x7 */
	.byte 0x07,0xe1
L_8e4450:
	mov_s r14,r0
L_8e4452:
	mov_s r0,0x886400
L_8e4458:
	ld_s r0,[r0]
L_8e445a:
	mov_s r13,r2
L_8e445c:
	bmsk_s r0,r0,0x9
L_8e445e:
	lsr r15,r1,0x3
L_8e4462:
	ldw_s r1,[r2,0x6]
L_8e4464:
	add_s r0,r0,r15
L_8e4466:
	brhs.d r0,r1,L_8e44dc
L_8e446a:
	mov_s r16,r3
	.global L_8e446c
L_8e446c:
	ldw_s r1,[r13,0x4]
L_8e446e:
	mov_s r0,0x3
L_8e4470:
	asl_s r0,r0,0xa
L_8e4472:
	brne r16,0x3,L_8e44f0
L_8e4476:
	brlt r1,r0,L_8e44e8
L_8e447a:
	ldw_s r0,[r13,0x6]
L_8e447c:
	add_s r1,r1,r0
L_8e447e:
	brlt 0x2000,r1,L_8e44e8
	.global L_8e4486
L_8e4486:
	ldw_s r0,[r13,0x4]
L_8e4488:
	bmsk r1,r15,0xb
L_8e448c:
	stw_s r0,[r14]
L_8e448e:
	ldw_s r0,[r13,0x4]
L_8e4490:
	stw_s r0,[r14,0x2]
L_8e4492:
	ldw_s r0,[r13,0x4]
L_8e4494:
	stw_s r0,[r14,0x6]
L_8e4496:
	ldw_s r0,[r13,0x6]
L_8e4498:
	stw_s r0,[r14,0x4]
L_8e449a:
	add r0,r14,0x8
L_8e449e:
	bl L_8ed340
L_8e44a2:
	ldw_s r1,[r13,0x8]
L_8e44a4:
	bmsk_s r1,r1,0xb
L_8e44a6:
	bl L_8ed3a0
L_8e44aa:
	ldw_s r0,[r13,0x8]
L_8e44ac:
	stb_s r0,[r14,0xb]
L_8e44ae:
	ldw_s r1,[r13,0x8]
L_8e44b0:
	add r0,r14,0xc
L_8e44b4:
	lsr_s r1,r1,0x8
L_8e44b6:
	bmsk_s r1,r1,0x3
L_8e44b8:
	bl L_8ed370
L_8e44bc:
	ldw_s r1,[r13,0x8]
L_8e44be:
	bmsk_s r1,r1,0xb
L_8e44c0:
	bl L_8ed3e8
L_8e44c4:
	ld_s r1,[r14,0xc]
L_8e44c6:
	bclr_s r1,r1,0x1c
L_8e44c8:
	st_s r1,[r14,0xc]
L_8e44ca:
	ldw_s r1,[r13,0xa]
L_8e44cc:
	bmsk_s r1,r1,0xb
L_8e44ce:
	bl L_8ed4f0
L_8e44d2:
	mov_s r1,0x0
L_8e44d4:
	bl L_8ed4c0
L_8e44d8:
	b L_8c0244
	.global L_8e44dc
L_8e44dc:
	mov_s r0,blink
L_8e44de:
	mov_s r1,0x1b
L_8e44e0:
	bl.d L_8c9b28
L_8e44e4:
	bset_s r1,r1,0xc
L_8e44e6:
	b_s L_8e446c
	.global L_8e44e8
L_8e44e8:
	mov_s r0,blink
L_8e44ea:
	mov_s r1,0x1c
L_8e44ec:
	bset_s r1,r1,0xc
L_8e44ee:
	b_s L_8e4508
	.global L_8e44f0
L_8e44f0:
	brlt r1,r0,L_8e4500
L_8e44f4:
	ldw_s r0,[r13,0x6]
L_8e44f6:
	add_s r0,r0,r1
L_8e44f8:
	brge 0x3000,r0,L_8e4486
	.global L_8e4500
L_8e4500:
	mov_s r0,blink
L_8e4502:
	mov_s r1,0x1502
	.global L_8e4508
L_8e4508:
	bl L_8c9b28
L_8e450c:
	b_s L_8e4486
L_8e450e:
	nop_s
