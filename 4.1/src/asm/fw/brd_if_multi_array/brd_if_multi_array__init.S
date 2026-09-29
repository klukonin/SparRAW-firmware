/* brd_if_multi_array__init @ 0x8d5ec4, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::init: Required Board File Size=%d bytes, board file buffer size=%d bytes
 *   brd_if_multi_array::init: Board File Buffer overflow error. Loaded board file size=%d bytes exceeds allocated board file buffer size=%d bytes
 *   brd_if_multi_array.cpp
 * Зовут его: marlon_r_if_class__init_board_file_interface
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, brd_if__scan_sections, brd_if_multi_array__brd_header_u, brd_if_multi_array__verify_board_file_format_version, fw_log__emit2, fw_sysassert_fatal, map_tx_sectors
 */
	.section .text.brd_if_multi_array__init,"ax",@progbits
	.global brd_if_multi_array__init
brd_if_multi_array__init:
	.global L_8d5ec4
L_8d5ec4:
	push_s blink
L_8d5ec6:
	bl.d L_8c02b8
L_8d5eca:
	mov_s r3,0x0
L_8d5ecc:
	mov_s r13,r0
L_8d5ece:
	mov_s r16,r2
L_8d5ed0:
	st_s r1,[r0,0x4]
L_8d5ed2:
	st_s r2,[r0,0x8]
L_8d5ed4:
	st_s r3,[r0,0xc]
L_8d5ed6:
	mov_s r2,r3
	.global L_8d5ed8
L_8d5ed8:
	add3 r0,r13,r2
L_8d5edc:
	add.f r2,r2,0x1
L_8d5ee0:
	st_s r3,[r0,0x10]
L_8d5ee2:
	st_s r3,[r0,0x14]
L_8d5ee4:
	beq_s L_8d5ed8
L_8d5ee6:
	cmp_s r1,0x0
L_8d5ee8:
	cmp.ne r16,0x0
L_8d5eec:
	mov_s r0,0x0
L_8d5eee:
	beq_s L_8d5f62
L_8d5ef0:
	mov_s r0,r13
L_8d5ef2:
	mov_s r14,0x1
L_8d5ef4:
	bl.d L_8e70dc
L_8d5ef8:
	mov_s r1,r14
L_8d5efa:
	breq_s r0,0,L_8d5f5a
L_8d5efc:
	ld_s r15,[r13,0x4]
L_8d5efe:
	add_s r15,r15,0x8
L_8d5f00:
	mov_s r0,r15
L_8d5f02:
	bl.d L_8dcc60
L_8d5f06:
	mov_s r1,0x2
L_8d5f08:
	mov_s r0,r13
L_8d5f0a:
	mov_s r1,r15
L_8d5f0c:
	bl.d L_8c5d68
L_8d5f10:
	mov_s r2,0xa
L_8d5f12:
	mov_s r17,r0
L_8d5f14:
	mov_s r2,0x1009268
L_8d5f1a:
	mov_s r0,0x0
L_8d5f1c:
	mov_s r1,0x2
L_8d5f1e:
	mov_s r3,r17
L_8d5f20:
	bl.d L_8edff8
L_8d5f24:
	mov r4,r16
L_8d5f28:
	ld_s r0,[r13,0x8]
L_8d5f2a:
	brlo r0,r17,L_8d5f32
L_8d5f2e:
	st_s r14,[r13,0xc]
L_8d5f30:
	b_s L_8d5f5a
	.global L_8d5f32
L_8d5f32:
	mov_s r2,0x10092c8
L_8d5f38:
	mov_s r0,0x0
L_8d5f3a:
	mov_s r1,r0
L_8d5f3c:
	mov_s r3,r17
L_8d5f3e:
	bl.d L_8edff8
L_8d5f42:
	mov r4,r16
L_8d5f46:
	mov_s r0,blink
L_8d5f48:
	mov_s r2,0x1009220
L_8d5f4e:
	mov_s r1,0x1367
L_8d5f54:
	bl.d L_8c82c0
L_8d5f58:
	mov_s r3,0x53
	.global L_8d5f5a
L_8d5f5a:
	bl.d L_8d9cc4
L_8d5f5e:
	mov_s r0,r13
L_8d5f60:
	ld_s r0,[r13,0xc]
	.global L_8d5f62
L_8d5f62:
	b L_8c031c
L_8d5f66:
	nop_s
