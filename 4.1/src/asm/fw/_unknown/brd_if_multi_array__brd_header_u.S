/* brd_if_multi_array__brd_header_u @ 0x8dcc60, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::brd_header_u: entry idx_entry=%d, offset_bytes=%d, length_lines=%d
 * Зовут его: brd_if_multi_array__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit3
 */
	.section .text.brd_if_multi_array__brd_header_u,"ax",@progbits
	.global brd_if_multi_array__brd_header_u
brd_if_multi_array__brd_header_u:
	.global L_8dcc60
L_8dcc60:
	push_s blink
L_8dcc62:
	bl L_8c02bc
L_8dcc66:
	mov_s r15,r0
L_8dcc68:
	mov_s r16,r1
L_8dcc6a:
	mov_s r14,0x0
L_8dcc6c:
	mov_s r13,0xa
	.global L_8dcc6e
L_8dcc6e:
	add3 r0,r15,r14
L_8dcc72:
	ld r4,[r0]
L_8dcc76:
	mov_s r2,0x10091c8
L_8dcc7c:
	ld r5,[r0, 0x4]
L_8dcc80:
	mov_s r0,0x0
L_8dcc82:
	mov_s r1,r16
L_8dcc84:
	bl.d L_8ee034
L_8dcc88:
	mov_s r3,r14
L_8dcc8a:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dcc8c:
	/* brhs.d r13,0x1,0x008dcc6e */
	.byte 0xe3,0x0d,0x75,0x90
L_8dcc90:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8dcc92:
	b L_8c0324
L_8dcc96:
	nop_s
