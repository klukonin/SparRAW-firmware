/* brd_if_multi_array__get_board_file_format_version @ 0x8c9a84, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_board_file_format_version: brd_format_vp=0x%X, brd_format_value=0x%X
 * Зовут его: brd_if_multi_array__verify_board_file_format_version
 * Зовёт сам: __ld_r13_ret, fw_log__emit2
 */
	.section .text.brd_if_multi_array__get_board_file_format_version,"ax",@progbits
	.global brd_if_multi_array__get_board_file_format_version
brd_if_multi_array__get_board_file_format_version:
	.global L_8c9a84
L_8c9a84:
	push_s blink
L_8c9a86:
	push_s r13
L_8c9a88:
	ld_s r13,[r0,0x4]
L_8c9a8a:
	breq_s r13,0,L_8c9ab0
L_8c9a8c:
	ld_s r3,[r13]
L_8c9a8e:
	breq_s r1,0,L_8c9aa2
L_8c9a90:
	mov_s r2,0x1009080
L_8c9a96:
	ld r4,[r13, 0x4]
L_8c9a9a:
	mov_s r0,0x0
L_8c9a9c:
	bl.d L_8edff8
L_8c9aa0:
	mov_s r1,0x2
	.global L_8c9aa2
L_8c9aa2:
	ld_s r0,[r13]
L_8c9aa4:
	brne r0,0xbdf0bdf0,L_8c9ab0
L_8c9aac:
	ld_s r0,[r13,0x4]
L_8c9aae:
	b_s L_8c9ab4
	.global L_8c9ab0
L_8c9ab0:
	mov r0,-0x1
	.global L_8c9ab4
L_8c9ab4:
	b L_8c033c
