/* brd_if__block_info @ 0x8e0fa0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if::block_info::print2log: section_type=%d, block_index=%d, chip_id=%d
 *   [NNL] offset_bytes=%d, size_bytes=%d, settings_count=%d
 * Зовут его: brd_if_multi_array__get_chunk, brd_if_multi_array__get_chunk_in_data_only_format
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if__block_info
brd_if__block_info:
	.global L_8e0fa0
L_8e0fa0:
	push_s blink
L_8e0fa2:
	bl L_8c01e4
L_8e0fa6:
	mov_s r13,r0
L_8e0fa8:
	mov_s r14,r1
L_8e0faa:
	ld r4,[r0, 0x8]
L_8e0fae:
	mov_s r1,0x100b360
L_8e0fb4:
	ld_s r2,[r13]
L_8e0fb6:
	asl_s r0,r14,0x4
L_8e0fb8:
	bl.d L_8dcd00
L_8e0fbc:
	ld_s r3,[r13,0x4]
L_8e0fbe:
	mov_s r1,0x100b3ac
L_8e0fc4:
	ld r4,[r13, 0xc]
L_8e0fc8:
	asl_s r0,r14,0x4
L_8e0fca:
	ld_s r2,[r13,0x10]
L_8e0fcc:
	bl.d L_8dcd00
L_8e0fd0:
	ld_s r3,[r13,0x14]
L_8e0fd2:
	b L_8c0254
L_8e0fd6:
	nop_s
