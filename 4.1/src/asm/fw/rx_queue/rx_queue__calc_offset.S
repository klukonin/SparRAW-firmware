/* rx_queue__calc_offset @ 0x8df8b0, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_queue.c
 * Зовут его: rx_macq__program_ba_win
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s0_w12, bf_w_s0_w4, bf_w_s12_w12, bf_w_s16_w12, bf_w_s29_w3, bf_w_s4_w12, fw_sysassert_fatal
 */
	.section .text.rx_queue__calc_offset,"ax",@progbits
	.global rx_queue__calc_offset
rx_queue__calc_offset:
	.global L_8df8b0
L_8df8b0:
	push_s blink
L_8df8b2:
	/* bl.d 0x008c02bc */
	.byte 0x0e,0x0a,0x6f,0xf0
L_8df8b6:
	/* _add_s r1,0x7 */
	.byte 0x07,0xe1
L_8df8b8:
	mov_s r14,r0
L_8df8ba:
	mov_s r0,0x886400
L_8df8c0:
	ld_s r0,[r0]
L_8df8c2:
	mov_s r13,r2
L_8df8c4:
	bmsk_s r0,r0,0x9
L_8df8c6:
	lsr r15,r1,0x3
L_8df8ca:
	ldw_s r1,[r2,0x6]
L_8df8cc:
	add_s r0,r0,r15
L_8df8ce:
	brhs.d r0,r1,L_8df944
L_8df8d2:
	mov_s r16,r3
	.global L_8df8d4
L_8df8d4:
	ldw_s r1,[r13,0x4]
L_8df8d6:
	mov_s r0,0x3
L_8df8d8:
	asl_s r0,r0,0xa
L_8df8da:
	brne r16,0x3,L_8df96c
L_8df8de:
	brlt r1,r0,L_8df95a
L_8df8e2:
	ldw_s r0,[r13,0x6]
L_8df8e4:
	add_s r1,r1,r0
L_8df8e6:
	brlt 0x2000,r1,L_8df95a
	.global L_8df8ee
L_8df8ee:
	ldw_s r0,[r13,0x4]
L_8df8f0:
	bmsk r1,r15,0xb
L_8df8f4:
	stw_s r0,[r14]
L_8df8f6:
	ldw_s r0,[r13,0x4]
L_8df8f8:
	stw_s r0,[r14,0x2]
L_8df8fa:
	ldw_s r0,[r13,0x4]
L_8df8fc:
	stw_s r0,[r14,0x6]
L_8df8fe:
	ldw_s r0,[r13,0x6]
L_8df900:
	stw_s r0,[r14,0x4]
L_8df902:
	add r0,r14,0x8
L_8df906:
	bl L_8e8318
L_8df90a:
	ldw_s r1,[r13,0x8]
L_8df90c:
	bmsk_s r1,r1,0xb
L_8df90e:
	bl L_8e8378
L_8df912:
	ldw_s r0,[r13,0x8]
L_8df914:
	stb_s r0,[r14,0xb]
L_8df916:
	ldw_s r1,[r13,0x8]
L_8df918:
	add r0,r14,0xc
L_8df91c:
	lsr_s r1,r1,0x8
L_8df91e:
	bmsk_s r1,r1,0x3
L_8df920:
	bl L_8e8348
L_8df924:
	ldw_s r1,[r13,0x8]
L_8df926:
	bmsk_s r1,r1,0xb
L_8df928:
	bl L_8e83c0
L_8df92c:
	ld_s r1,[r14,0xc]
L_8df92e:
	bclr_s r1,r1,0x1c
L_8df930:
	st_s r1,[r14,0xc]
L_8df932:
	ldw_s r1,[r13,0xa]
L_8df934:
	bmsk_s r1,r1,0xb
L_8df936:
	bl L_8e84c8
L_8df93a:
	mov_s r1,0x0
L_8df93c:
	bl L_8e8498
L_8df940:
	b L_8c0324
	.global L_8df944
L_8df944:
	mov_s r0,blink
L_8df946:
	mov_s r2,0x1010150
L_8df94c:
	mov_s r1,0x1b
L_8df94e:
	bset_s r1,r1,0xc
L_8df950:
	bl.d L_8c82c0
L_8df954:
	mov r3,0x1d4
L_8df958:
	b_s L_8df8d4
	.global L_8df95a
L_8df95a:
	mov_s r0,blink
L_8df95c:
	mov_s r2,0x1010150
L_8df962:
	mov_s r1,0x1c
L_8df964:
	bset_s r1,r1,0xc
L_8df966:
	mov r3,0x1db
L_8df96a:
	b_s L_8df98c
	.global L_8df96c
L_8df96c:
	brlt r1,r0,L_8df97c
L_8df970:
	ldw_s r0,[r13,0x6]
L_8df972:
	add_s r0,r0,r1
L_8df974:
	brge 0x3000,r0,L_8df8ee
	.global L_8df97c
L_8df97c:
	mov_s r0,blink
L_8df97e:
	mov_s r2,0x1010150
L_8df984:
	mov_s r1,0x1c
L_8df986:
	bset_s r1,r1,0xc
L_8df988:
	mov r3,0x1e0
	.global L_8df98c
L_8df98c:
	bl L_8c82c0
L_8df990:
	b_s L_8df8ee
L_8df992:
	nop_s
