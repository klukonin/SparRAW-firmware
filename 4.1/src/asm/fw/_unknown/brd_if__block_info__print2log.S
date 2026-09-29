/* brd_if__block_info__print2log @ 0x8dccf8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if::block_info::print2log: section_type=%d, block_index=%d, chip_id=%d
 *   [NNL] offset_bytes=%d, size_bytes=%d, settings_count=%d
 * Зовут его: brd_if_multi_array__get_chunk, brd_if_multi_array__get_chunk_in_data_only_format
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit3
 */
	.section .text.brd_if__block_info__print2log,"ax",@progbits
	.global brd_if__block_info__print2log
brd_if__block_info__print2log:
	.global L_8dccf8
L_8dccf8:
	push_s blink
L_8dccfa:
	bl L_8c02c4
L_8dccfe:
	mov_s r13,r0
L_8dcd00:
	mov_s r14,r1
L_8dcd02:
	ld r4,[r0, 0x4]
L_8dcd06:
	mov_s r2,0x1009e04
L_8dcd0c:
	ld r5,[r0, 0x8]
L_8dcd10:
	mov_s r0,0x0
L_8dcd12:
	bl.d L_8ee034
L_8dcd16:
	ld_s r3,[r13]
L_8dcd18:
	mov_s r2,0x1009e50
L_8dcd1e:
	ld r4,[r13, 0x14]
L_8dcd22:
	mov_s r0,0x0
L_8dcd24:
	ld r5,[r13, 0xc]
L_8dcd28:
	mov_s r1,r14
L_8dcd2a:
	bl.d L_8ee034
L_8dcd2e:
	ld_s r3,[r13,0x10]
L_8dcd30:
	b L_8c0334
