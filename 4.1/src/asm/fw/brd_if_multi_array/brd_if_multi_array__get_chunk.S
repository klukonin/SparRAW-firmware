/* brd_if_multi_array__get_chunk @ 0x8c8bf4, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_chunk: chunk overflows its block boundaries, chunk_idx=%d,full_chunk_size_bytes=%d,cur_chunk_size_bytes=%d
 *   brd_if_multi_array::get_chunk: chunk overflows its block boundaries, chunks_end_bytes=%d, block_size_bytes=%d
 *   brd_if_multi_array.cpp
 * Зовут его: brd_if_multi_array__get_chunk_in_address_data_pairs_format, brd_if_multi_array__get_chunk_in_data_only_format
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, brd_if__block_info__print2log, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.brd_if_multi_array__get_chunk,"ax",@progbits
	.global brd_if_multi_array__get_chunk
brd_if_multi_array__get_chunk:
	.global L_8c8bf4
L_8c8bf4:
	push_s blink
L_8c8bf6:
	bl L_8c02b0
L_8c8bfa:
	mov_s r17,r0
L_8c8bfc:
	mov_s r14,r1
L_8c8bfe:
	mov_s r15,r2
L_8c8c00:
	mov r19,r5
L_8c8c04:
	cmp r4,0x0
L_8c8c08:
	mov_s r0,0x1
L_8c8c0a:
	mov_s r2,0x4
L_8c8c0c:
	sub_s.ne r0,r0,r0
L_8c8c0e:
	add2_s r2,r2,r0
L_8c8c10:
	mulu64 r2,r3
L_8c8c14:
	mov r4,mlo
L_8c8c18:
	mulu64 mlo,r15
L_8c8c1c:
	ld_s r0,[r14,0x10]
L_8c8c1e:
	mov_s r1,mlo
L_8c8c20:
	add r16,r0,r1
L_8c8c24:
	mulu64 r3,r15
L_8c8c28:
	ld_s r13,[r14,0xc]
L_8c8c2a:
	mov_s r0,mlo
L_8c8c2c:
	cmp_s r0,r13
L_8c8c2e:
	sub.cs r13,r13,r0
L_8c8c32:
	mov.cc r13,0x0
L_8c8c36:
	cmp_s r3,r13
L_8c8c38:
	mov.cs r13,r3
L_8c8c3c:
	mulu64 r13,r2
L_8c8c40:
	ld_s r0,[r14,0x14]
L_8c8c42:
	add r18,mlo,r1
L_8c8c46:
	brhs.d r0,r18,L_8c8c90
L_8c8c4a:
	mov r5,mlo
L_8c8c4e:
	mov_s r2,0x1009a90
L_8c8c54:
	mov_s r0,0x0
L_8c8c56:
	mov_s r1,r0
L_8c8c58:
	bl.d L_8ee034
L_8c8c5c:
	mov_s r3,r15
L_8c8c5e:
	mov_s r2,0x1009b14
L_8c8c64:
	ld r4,[r14, 0x14]
L_8c8c68:
	mov_s r0,0x0
L_8c8c6a:
	mov_s r1,r0
L_8c8c6c:
	bl.d L_8edff8
L_8c8c70:
	mov_s r3,r18
L_8c8c72:
	mov_s r0,r14
L_8c8c74:
	bl.d L_8dccf8
L_8c8c78:
	mov_s r1,0x0
L_8c8c7a:
	mov_s r0,blink
L_8c8c7c:
	mov_s r2,0x1009220
L_8c8c82:
	mov_s r1,0x1354
L_8c8c88:
	bl.d L_8c82c0
L_8c8c8c:
	mov r3,0x1cf
	.global L_8c8c90
L_8c8c90:
	st r13,[r19]
L_8c8c94:
	ld r0,[r17, 0x4]
L_8c8c98:
	add_s r0,r0,0x8
L_8c8c9a:
	b.d L_8c030c
L_8c8c9e:
	add_s r0,r0,r16
