/* brd_if_multi_array__physical_section_header_u__print2log @ 0x8dcc98, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::physical_section_header_u::print2log: header_value=0x%X, base_addr=0x%X
 *   [NNL] rf_vector=0x%X, block_length=%d [dwords],physical_section_type=%d
 *   [NNL] data_format=0%d, sector_mask=0x%X, rf_base_address=0x%X
 * Зовут его: brd_if__check_section_header, brd_if_multi_array__check_physical_section_validity, brd_if_multi_array__get_block_info
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, fw_log__emit3
 */
	.section .text.brd_if_multi_array__physical_section_header_u__print2log,"ax",@progbits
	.global brd_if_multi_array__physical_section_header_u__print2log
brd_if_multi_array__physical_section_header_u__print2log:
	.global L_8dcc98
L_8dcc98:
	push_s blink
L_8dcc9a:
	bl L_8c02c0
L_8dcc9e:
	mov_s r13,r0
L_8dcca0:
	mov_s r15,r1
L_8dcca2:
	mov_s r2,0x1009358
L_8dcca8:
	ld r4,[r0, 0x4]
L_8dccac:
	mov_s r0,0x0
L_8dccae:
	bl.d L_8edff8
L_8dccb2:
	ld_s r3,[r13]
L_8dccb4:
	ld_s r14,[r13]
L_8dccb6:
	mov_s r2,0x10093b4
L_8dccbc:
	lsr r0,r14,0x8
L_8dccc0:
	bmsk r4,r0,0xb
L_8dccc4:
	ldb_s r3,[r13]
L_8dccc6:
	mov_s r0,0x0
L_8dccc8:
	mov_s r1,r15
L_8dccca:
	lsr_s r14,r14,0x14
L_8dcccc:
	bl.d L_8ee034
L_8dccd0:
	bmsk r5,r14,0x3
L_8dccd4:
	ld_s r0,[r13]
L_8dccd6:
	mov_s r2,0x10093fc
L_8dccdc:
	lsr r3,r0,0x18
L_8dcce0:
	lsr r4,r0,0x1a
L_8dcce4:
	ld r5,[r13, 0x4]
L_8dcce8:
	mov_s r0,0x0
L_8dccea:
	mov_s r1,r15
L_8dccec:
	bl.d L_8ee034
L_8dccf0:
	bmsk_s r3,r3,0x1
L_8dccf2:
	b L_8c032c
L_8dccf6:
	nop_s
