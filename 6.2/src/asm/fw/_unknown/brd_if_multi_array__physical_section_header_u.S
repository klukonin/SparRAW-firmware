/* brd_if_multi_array__physical_section_header_u @ 0x8e0f4c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::physical_section_header_u::print2log: header_value=0x%X, base_addr=0x%X
 *   [NNL] rf_vector=0x%X, block_length=%d [dwords],physical_section_type=%d
 *   [NNL] data_format=0%d, sector_mask=0x%X, rf_base_address=0x%X
 * Зовут его: brd_if__check_section_header, brd_if_multi_array, brd_if_multi_array__get_block_info
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__physical_section_header_u
brd_if_multi_array__physical_section_header_u:
	.global L_8e0f4c
L_8e0f4c:
	push_s blink
L_8e0f4e:
	bl L_8c01e0
L_8e0f52:
	mov_s r13,r0
L_8e0f54:
	mov_s r15,r1
L_8e0f56:
	ld_s r2,[r13]
L_8e0f58:
	mov_s r1,0x100a85c
L_8e0f5e:
	asl_s r0,r15,0x4
L_8e0f60:
	bl.d L_8dcc80
L_8e0f64:
	ld_s r3,[r13,0x4]
L_8e0f66:
	ld_s r14,[r13]
L_8e0f68:
	mov_s r1,0x100a8b8
L_8e0f6e:
	lsr r3,r14,0x8
L_8e0f72:
	ldb_s r2,[r13]
L_8e0f74:
	bmsk_s r3,r3,0xb
L_8e0f76:
	asl_s r0,r15,0x4
L_8e0f78:
	lsr_s r14,r14,0x14
L_8e0f7a:
	bl.d L_8dcd00
L_8e0f7e:
	bmsk r4,r14,0x3
L_8e0f82:
	ld_s r3,[r13]
L_8e0f84:
	mov_s r1,0x100a900
L_8e0f8a:
	lsr r2,r3,0x18
L_8e0f8e:
	lsr_s r3,r3,0x1a
L_8e0f90:
	ld r4,[r13, 0x4]
L_8e0f94:
	asl_s r0,r15,0x4
L_8e0f96:
	bl.d L_8dcd00
L_8e0f9a:
	bmsk_s r2,r2,0x1
L_8e0f9c:
	b L_8c024c
