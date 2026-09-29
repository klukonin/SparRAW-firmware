/* brd_if__section_info__print2log @ 0x8dcd34, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if::section_info::print2log: section_type=%d, blocks_count=%d
 *   [NNL] offset_bytes=%d, size_bytes=%d
 * Зовут его: brd_if_multi_array__get_block_info
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2
 */
	.section .text.brd_if__section_info__print2log,"ax",@progbits
	.global brd_if__section_info__print2log
brd_if__section_info__print2log:
	.global L_8dcd34
L_8dcd34:
	push_s blink
L_8dcd36:
	bl L_8c02c4
L_8dcd3a:
	mov_s r13,r0
L_8dcd3c:
	mov_s r14,r1
L_8dcd3e:
	mov_s r2,0x1009d98
L_8dcd44:
	ld r4,[r0, 0x4]
L_8dcd48:
	mov_s r0,0x0
L_8dcd4a:
	bl.d L_8edff8
L_8dcd4e:
	ld_s r3,[r13]
L_8dcd50:
	mov_s r2,0x1009ddc
L_8dcd56:
	ld r4,[r13, 0xc]
L_8dcd5a:
	mov_s r0,0x0
L_8dcd5c:
	mov_s r1,r14
L_8dcd5e:
	bl.d L_8edff8
L_8dcd62:
	ld_s r3,[r13,0x8]
L_8dcd64:
	b L_8c0334
