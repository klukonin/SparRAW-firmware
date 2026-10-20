/* brd_if__chunk_offset @ 0x8c5410, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_chunk_in_data_only_format
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bit_length, fw_divmod_unsigned
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if__chunk_offset
brd_if__chunk_offset:
	.global L_8c5410
L_8c5410:
	push_s blink
L_8c5412:
	bl.d L_8c01d8
L_8c5416:
	mov_s r6,r2
L_8c5418:
	mov_s r15,r1
L_8c541a:
	mov_s r16,r3
L_8c541c:
	mov_s r13,r4
L_8c541e:
	mov r17,r5
L_8c5422:
	bl.d L_8c7cd4
L_8c5426:
	mov_s r1,r13
L_8c5428:
	mov_s r14,r0
L_8c542a:
	mov_s r0,r6
L_8c542c:
	mulu64 r0,r15
L_8c5430:
	mov_s r15,mlo
L_8c5432:
	mov_s r0,r15
L_8c5434:
	bl.d L_8c02d4
L_8c5438:
	mov_s r1,r14
L_8c543a:
	mulu64 r0,r14
L_8c543e:
	sub r15,r15,mlo
L_8c5442:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8c5444:
	add1_s r0,r0,r0
L_8c5446:
	mov_s r1,0x0
L_8c5448:
	mov_s r2,r1
L_8c544a:
	b_s L_8c5450
	.global L_8c544c
L_8c544c:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c544e:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_8c5450
L_8c5450:
	brhs r2,0x6,L_8c545e
L_8c5454:
	bbit0 r13,r2,L_8c544c
L_8c5458:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c545a:
	brhs r15,r1,L_8c544c
	.global L_8c545e
L_8c545e:
	stb r2,[r17]
L_8c5462:
	b.d L_8c023c
L_8c5466:
	add_s r0,r0,r16
