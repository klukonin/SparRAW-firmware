/* brd_if_multi_array__get_chunk_in_data_only_format @ 0x8c9c60, 252 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_chunk_in_data_only_format: chunk data overflows its block boundaries, chunk_idx=%d, brd_block_end_addr=%d, p_brd_data_value=%d
 *   brd_if_multi_array::get_chunk_in_data_only_format: board_file_start_address=%d, chunk_start_addr=%d, num_actual_values=%d
 *   brd_if_multi_array.cpp
 * Зовут его: brd_if_multi_array__get_chunk_8c9b3c
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, brd_if__block_info__print2log, brd_if__chunk_offset, brd_if_multi_array__get_chunk, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.brd_if_multi_array__get_chunk_in_data_only_format,"ax",@progbits
	.global brd_if_multi_array__get_chunk_in_data_only_format
brd_if_multi_array__get_chunk_in_data_only_format:
	.global L_8c9c60
L_8c9c60:
	push_s blink
L_8c9c62:
	bl L_8c02ac
L_8c9c66:
	mov_s r17,r0
L_8c9c68:
	mov_s r16,r2
L_8c9c6a:
	mov_s r18,r3
L_8c9c6c:
	mov r20,r4
L_8c9c70:
	ld_s r0,[r0,0x4]
L_8c9c72:
	mov r19,r5
L_8c9c76:
	ld_s r15,[r1,0x8]
L_8c9c78:
	add_s r0,r0,0x8
L_8c9c7a:
	add_s r15,r15,r0
L_8c9c7c:
	mov_s r13,0x0
L_8c9c7e:
	ld.a r0,[r15,0x8]
L_8c9c82:
	stb.a r13,[sp,-0x8]
L_8c9c86:
	lsr r4,r0,0x1a
L_8c9c8a:
	mov r5,sp
L_8c9c8e:
	mov_s r0,r17
L_8c9c90:
	mov_s r1,r3
L_8c9c92:
	mov_s r2,r19
L_8c9c94:
	bl.d L_8c4894
L_8c9c98:
	ld_s r3,[r15,0x4]
L_8c9c9a:
	mov_s r14,r0
L_8c9c9c:
	ld_s r0,[r15]
L_8c9c9e:
	st_s r13,[sp,0x4]
L_8c9ca0:
	lsr r4,r0,0x18
L_8c9ca4:
	add r5,sp,0x4
L_8c9ca8:
	mov_s r0,r17
L_8c9caa:
	mov_s r1,r16
L_8c9cac:
	mov_s r2,r18
L_8c9cae:
	mov_s r3,r19
L_8c9cb0:
	bl.d L_8c8bf4
L_8c9cb4:
	bmsk r4,r4,0x1
L_8c9cb8:
	mov_s r19,r0
L_8c9cba:
	mov_s r5,r0
L_8c9cbc:
	b_s L_8c9cec
	.global L_8c9cbe
L_8c9cbe:
	ldb_s r0,[sp,0x0]
L_8c9cc0:
	brhs r0,0x6,L_8c9cec
L_8c9cc4:
	rsub lp_count,r0,0x6
L_8c9cc8:
	lp L_8c9cec
L_8c9ccc:
	ld_s r1,[r15]
L_8c9cce:
	lsr_s r1,r1,0x1a
L_8c9cd0:
	bbit0 r1,r0,L_8c9ce8
L_8c9cd4:
	add3 r1,r20,r13
L_8c9cd8:
	st_s r14,[r1]
L_8c9cda:
	ld.ab r2,[r5,0x4]
L_8c9cde:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8c9ce0:
	st_s r2,[r1,0x4]
L_8c9ce2:
	ld_s r1,[sp,0x4]
L_8c9ce4:
	brhs r13,r1,L_8c9cec
	.global L_8c9ce8
L_8c9ce8:
	/* add_s r14,0x4 */
	.byte 0x04,0xe6
L_8c9cea:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8c9cec
L_8c9cec:
	ld_s r0,[sp,0x4]
L_8c9cee:
	brlo r13,r0,L_8c9cbe
L_8c9cf2:
	ld r0,[r17, 0x4]
L_8c9cf6:
	ld r1,[r16, 0x10]
L_8c9cfa:
	add_s r0,r0,0x8
L_8c9cfc:
	ld r13,[r16, 0x14]
L_8c9d00:
	add_s r0,r0,r1
L_8c9d02:
	add_s r13,r13,r0
L_8c9d04:
	brhs r13,r5,L_8c9d54
L_8c9d08:
	mov_s r2,0x1009b84
L_8c9d0e:
	mov_s r0,0x0
L_8c9d10:
	mov_s r1,r0
L_8c9d12:
	mov_s r3,r18
L_8c9d14:
	bl.d L_8ee034
L_8c9d18:
	mov_s r4,r13
L_8c9d1a:
	ld r3,[r17, 0x4]
L_8c9d1e:
	mov_s r2,0x1009c1c
L_8c9d24:
	add_s r3,r3,0x8
L_8c9d26:
	ld r5,[sp, 0x4]
L_8c9d2a:
	mov_s r0,0x0
L_8c9d2c:
	mov_s r1,r0
L_8c9d2e:
	bl.d L_8ee034
L_8c9d32:
	mov r4,r19
L_8c9d36:
	mov_s r0,r16
L_8c9d38:
	bl.d L_8dccf8
L_8c9d3c:
	mov_s r1,0x0
L_8c9d3e:
	mov_s r0,blink
L_8c9d40:
	mov_s r2,0x1009220
L_8c9d46:
	mov_s r1,0x1351
L_8c9d4c:
	bl.d L_8c82c0
L_8c9d50:
	mov r3,0x1b1
	.global L_8c9d54
L_8c9d54:
	ld_s r0,[sp,0x4]
L_8c9d56:
	b.d L_8c0304
L_8c9d5a:
	add_s sp,sp,0x8
