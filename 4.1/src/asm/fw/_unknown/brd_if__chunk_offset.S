/* brd_if__chunk_offset @ 0x8c4894, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_chunk_in_data_only_format
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bit_length, fw_div_unsigned
 */
	.section .text.brd_if__chunk_offset,"ax",@progbits
	.global brd_if__chunk_offset
brd_if__chunk_offset:
	.global L_8c4894
L_8c4894:
	push_s blink
L_8c4896:
	bl.d L_8c02b8
L_8c489a:
	mov_s r6,r2
L_8c489c:
	mov_s r15,r1
L_8c489e:
	mov_s r16,r3
L_8c48a0:
	mov_s r13,r4
L_8c48a2:
	mov r17,r5
L_8c48a6:
	bl.d L_8c6c38
L_8c48aa:
	mov_s r1,r13
L_8c48ac:
	mov_s r14,r0
L_8c48ae:
	mov_s r0,r6
L_8c48b0:
	mulu64 r0,r15
L_8c48b4:
	mov_s r15,mlo
L_8c48b6:
	mov_s r0,r15
L_8c48b8:
	bl.d L_8c03b4
L_8c48bc:
	mov_s r1,r14
L_8c48be:
	mulu64 r0,r14
L_8c48c2:
	sub r15,r15,mlo
L_8c48c6:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8c48c8:
	add1_s r0,r0,r0
L_8c48ca:
	mov_s r1,0x0
L_8c48cc:
	mov_s r2,r1
L_8c48ce:
	b_s L_8c48d4
	.global L_8c48d0
L_8c48d0:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c48d2:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_8c48d4
L_8c48d4:
	brhs r2,0x6,L_8c48e2
L_8c48d8:
	bbit0 r13,r2,L_8c48d0
L_8c48dc:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c48de:
	brhs r15,r1,L_8c48d0
	.global L_8c48e2
L_8c48e2:
	stb r2,[r17]
L_8c48e6:
	b.d L_8c031c
L_8c48ea:
	add_s r0,r0,r16
