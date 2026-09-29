/* brd_if_multi_array__get_chunk_8c9b3c @ 0x8c9b3c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_chunk: Access to non-initialized Board File Interface
 *   brd_if_multi_array::get_chunk: Bad arguments
 *   SYSTEM
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, brd_if_multi_array__get_chunk_in_address_data_pairs_format, brd_if_multi_array__get_chunk_in_data_only_format, div_round_up, fw_log__emit0
 */
	.section .text.brd_if_multi_array__get_chunk_8c9b3c,"ax",@progbits
	.global brd_if_multi_array__get_chunk_8c9b3c
brd_if_multi_array__get_chunk_8c9b3c:
	.byte 0x4f
	.byte 0xfb
	.global fwlog_brd_if_multi_array_get_chunk_Access_to_n
fwlog_brd_if_multi_array_get_chunk_Access_to_n:
L_8c9b3e:
	nop_s
L_8c9b40:
	push_s blink
L_8c9b42:
	bl L_8c02b4
L_8c9b46:
	mov_s r13,r0
L_8c9b48:
	mov_s r15,r1
L_8c9b4a:
	mov_s r14,r2
L_8c9b4c:
	ld_s r0,[r0,0xc]
L_8c9b4e:
	mov r18,r4
L_8c9b52:
	mov_s r16,r3
L_8c9b54:
	mov r17,r5
L_8c9b58:
	brne_s r0,0,L_8c9b6c
L_8c9b5a:
	mov_s r2,0x1009d18
	.global L_8c9b60
L_8c9b60:
	mov_s r13,0x0
L_8c9b62:
	mov_s r0,r13
L_8c9b64:
	bl.d L_8edfb0
L_8c9b68:
	mov_s r1,r13
L_8c9b6a:
	b_s L_8c9bc2
	.global L_8c9b6c
L_8c9b6c:
	cmp r18,0x0
L_8c9b70:
	cmp.ne r17,0x0
L_8c9b74:
	cmp.ne r15,0x0
L_8c9b78:
	cmp.ne r14,0x0
L_8c9b7c:
	beq_s L_8c9b8a
L_8c9b7e:
	mov_s r0,r14
L_8c9b80:
	bl.d L_8c9d5c
L_8c9b84:
	mov_s r1,r17
L_8c9b86:
	brhs r0,r16,L_8c9b92
	.global L_8c9b8a
L_8c9b8a:
	mov_s r2,0x1009d68
L_8c9b90:
	b_s L_8c9b60
	.global L_8c9b92
L_8c9b92:
	ld_s r1,[r13,0x4]
L_8c9b94:
	ld_s r0,[r15,0x8]
L_8c9b96:
	add_s r1,r1,0x8
L_8c9b98:
	add_s r0,r0,0x8
L_8c9b9a:
	ld_s r0,[r0,r1]
L_8c9b9c:
	mov_s r2,r14
L_8c9b9e:
	and.f 0x0,r0,0x3000000
L_8c9ba6:
	mov_s r0,r13
L_8c9ba8:
	mov_s r1,r15
L_8c9baa:
	mov_s r3,r16
L_8c9bac:
	mov r4,r18
L_8c9bb0:
	mov r5,r17
L_8c9bb4:
	bne_s L_8c9bbc
L_8c9bb6:
	bl L_8c9bc8
L_8c9bba:
	b_s L_8c9bc0
	.global L_8c9bbc
L_8c9bbc:
	bl L_8c9c60
	.global L_8c9bc0
L_8c9bc0:
	mov_s r13,r0
	.global L_8c9bc2
L_8c9bc2:
	b.d L_8c0314
L_8c9bc6:
	mov_s r0,r13
