/* brd_if__section_info @ 0x8e0fd8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if::section_info::print2log: section_type=%d, blocks_count=%d
 *   [NNL] offset_bytes=%d, size_bytes=%d
 * Зовут его: brd_if_multi_array__get_block_info
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if__section_info
brd_if__section_info:
	.global L_8e0fd8
L_8e0fd8:
	push_s blink
L_8e0fda:
	bl L_8c01e4
L_8e0fde:
	mov_s r13,r0
L_8e0fe0:
	mov_s r14,r1
L_8e0fe2:
	ld_s r2,[r13]
L_8e0fe4:
	mov_s r1,0x100b2f4
L_8e0fea:
	asl_s r0,r14,0x4
L_8e0fec:
	bl.d L_8dcc80
L_8e0ff0:
	ld_s r3,[r13,0x4]
L_8e0ff2:
	mov_s r1,0x100b338
L_8e0ff8:
	ld_s r2,[r13,0x8]
L_8e0ffa:
	asl_s r0,r14,0x4
L_8e0ffc:
	bl.d L_8dcc80
L_8e1000:
	ld_s r3,[r13,0xc]
L_8e1002:
	b L_8c0254
L_8e1006:
	nop_s
