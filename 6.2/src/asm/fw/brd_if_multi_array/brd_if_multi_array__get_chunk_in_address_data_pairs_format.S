/* brd_if_multi_array__get_chunk_in_address_data_pairs_format @ 0x8cbcd8, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_chunk_in_address_data_pairs_format: Buffer overrun occured. p_brd_line=0x%X, brd_block_end_addr=0x%X
 * Зовут его: brd_if_multi_array__get_chunk_8cbbc4
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, brd_if__parse_chunk_header, brd_if_multi_array__get_chunk, fw_log_emit2, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__get_chunk_in_address_data_pairs_format
brd_if_multi_array__get_chunk_in_address_data_pairs_format:
	.global L_8cbcd8
L_8cbcd8:
	push_s blink
L_8cbcda:
	bl L_8c01d4
L_8cbcde:
	mov_s r15,r0
L_8cbce0:
	mov_s r16,r2
L_8cbce2:
	mov_s r2,r3
L_8cbce4:
	mov r17,r4
L_8cbce8:
	mov_s r13,0x0
L_8cbcea:
	push_s r13
L_8cbcec:
	ld_s r0,[r0,0x48]
L_8cbcee:
	mov r18,r6
L_8cbcf2:
	ld_s r1,[r1,0x8]
L_8cbcf4:
	add_s r0,r0,0x8
L_8cbcf6:
	add_s r1,r1,0x8
L_8cbcf8:
	ld_s r14,[r1,r0]
L_8cbcfa:
	mov_s r3,r5
L_8cbcfc:
	lsr_s r14,r14,0x18
L_8cbcfe:
	mov r5,sp
L_8cbd02:
	mov_s r0,r15
L_8cbd04:
	mov_s r1,r16
L_8cbd06:
	bl.d L_8ca760
L_8cbd0a:
	bmsk r4,r14,0x1
L_8cbd0e:
	mov_s r14,r0
L_8cbd10:
	ld_s r0,[sp,0x0]
L_8cbd12:
	brlo r0,0x1,L_8cbd42
	.global L_8cbd16
L_8cbd16:
	ld_s r1,[r14]
L_8cbd18:
	add3 r0,r17,r13
L_8cbd1c:
	st_s r1,[r0]
L_8cbd1e:
	ld_s r3,[r14,0x4]
L_8cbd20:
	st_s r3,[r0,0x4]
L_8cbd22:
	breq r18,0x0,L_8cbd38
L_8cbd26:
	mov_s r0,r15
L_8cbd28:
	mov_s r1,r14
L_8cbd2a:
	ld_s r2,[r14]
L_8cbd2c:
	mov r4,0x0
L_8cbd30:
	bl.d L_8c7444
L_8cbd34:
	mov r5,r18
	.global L_8cbd38
L_8cbd38:
	ld_s r0,[sp,0x0]
L_8cbd3a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cbd3c:
	brlo.d r13,r0,L_8cbd16
L_8cbd40:
	add_s r14,r14,0x8
	.global L_8cbd42
L_8cbd42:
	ld_s r0,[r15,0x48]
L_8cbd44:
	ld r1,[r16, 0x10]
L_8cbd48:
	add_s r0,r0,0x8
L_8cbd4a:
	ld r3,[r16, 0x14]
L_8cbd4e:
	add_s r0,r0,r1
L_8cbd50:
	add_s r3,r3,r0
L_8cbd52:
	cmp_s r14,r3
L_8cbd54:
	mov_s r0,0x1
L_8cbd56:
	sub.ls r0,r0,r0
L_8cbd5a:
	breq_s r0,0,L_8cbd76
L_8cbd5c:
	mov_s r1,0x100b19c
L_8cbd62:
	mov_s r0,0x0
L_8cbd64:
	bl.d L_8dcc80
L_8cbd68:
	mov_s r2,r14
L_8cbd6a:
	mov_s r0,blink
L_8cbd6c:
	mov_s r1,0x1352
L_8cbd72:
	bl L_8c9b28
	.global L_8cbd76
L_8cbd76:
	ld_s r0,[sp,0x0]
L_8cbd78:
	b.d L_8c0234
L_8cbd7c:
	add_s sp,sp,0x4
L_8cbd7e:
	nop_s
