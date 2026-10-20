/* brd_if_multi_array__get_chunk_in_address_data_pairs_format @ 0x8c9bc8, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_chunk_in_address_data_pairs_format: Buffer overrun occured. p_brd_line=0x%X, brd_block_end_addr=0x%X
 *   brd_if_multi_array.cpp
 * Зовут его: brd_if_multi_array__get_chunk_8c9b3c
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, brd_if_multi_array__get_chunk, fw_log__emit2, fw_sysassert_fatal
 */
	.section .text.brd_if_multi_array__get_chunk_in_address_data_pairs_format,"ax",@progbits
	.global brd_if_multi_array__get_chunk_in_address_data_pairs_format
brd_if_multi_array__get_chunk_in_address_data_pairs_format:
	.global L_8c9bc8
L_8c9bc8:
	push_s blink
L_8c9bca:
	bl.d L_8c02bc
L_8c9bce:
	mov_s r6,r3
L_8c9bd0:
	mov_s r14,r0
L_8c9bd2:
	mov_s r15,r2
L_8c9bd4:
	mov_s r13,0x0
L_8c9bd6:
	push_s r13
L_8c9bd8:
	ld_s r0,[r0,0x4]
L_8c9bda:
	mov_s r3,r5
L_8c9bdc:
	ld_s r1,[r1,0x8]
L_8c9bde:
	add_s r0,r0,0x8
L_8c9be0:
	add_s r1,r1,0x8
L_8c9be2:
	ld_s r0,[r1,r0]
L_8c9be4:
	mov r16,r4
L_8c9be8:
	lsr r4,r0,0x18
L_8c9bec:
	mov r5,sp
L_8c9bf0:
	mov_s r0,r14
L_8c9bf2:
	mov_s r1,r2
L_8c9bf4:
	mov_s r2,r6
L_8c9bf6:
	bl.d L_8c8bf4
L_8c9bfa:
	bmsk r4,r4,0x1
L_8c9bfe:
	mov_s r3,r0
L_8c9c00:
	ld_s r0,[sp,0x0]
L_8c9c02:
	brlo r0,0x1,L_8c9c1c
	.global L_8c9c06
L_8c9c06:
	ld_s r1,[r3]
L_8c9c08:
	add3 r0,r16,r13
L_8c9c0c:
	st_s r1,[r0]
L_8c9c0e:
	ld_s r1,[r3,0x4]
L_8c9c10:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8c9c12:
	st_s r1,[r0,0x4]
L_8c9c14:
	ld_s r0,[sp,0x0]
L_8c9c16:
	brlo.d r13,r0,L_8c9c06
L_8c9c1a:
	add_s r3,r3,0x8
	.global L_8c9c1c
L_8c9c1c:
	ld_s r0,[r14,0x4]
L_8c9c1e:
	ld_s r1,[r15,0x10]
L_8c9c20:
	add_s r0,r0,0x8
L_8c9c22:
	ld_s r13,[r15,0x14]
L_8c9c24:
	add_s r0,r0,r1
L_8c9c26:
	add_s r13,r13,r0
L_8c9c28:
	cmp_s r3,r13
L_8c9c2a:
	mov_s r0,0x1
L_8c9c2c:
	sub.ls r0,r0,r0
L_8c9c30:
	breq_s r0,0,L_8c9c58
L_8c9c32:
	mov_s r2,0x1009c98
L_8c9c38:
	mov_s r0,0x0
L_8c9c3a:
	mov_s r1,r0
L_8c9c3c:
	bl.d L_8edff8
L_8c9c40:
	mov_s r4,r13
L_8c9c42:
	mov_s r0,blink
L_8c9c44:
	mov_s r2,0x1009220
L_8c9c4a:
	mov_s r1,0x1352
L_8c9c50:
	bl.d L_8c82c0
L_8c9c54:
	mov r3,0x177
	.global L_8c9c58
L_8c9c58:
	ld_s r0,[sp,0x0]
L_8c9c5a:
	b.d L_8c0324
L_8c9c5e:
	add_s sp,sp,0x4
