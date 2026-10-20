/* brd_if_multi_array__get_board_file_format_version @ 0x8cbafc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_board_file_format_version: brd_format_vp=0x%X, brd_format_value=0x%X
 * Зовут его: brd_if_multi_array__verify_board_file_format_version
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__get_board_file_format_version
brd_if_multi_array__get_board_file_format_version:
	.global L_8cbafc
L_8cbafc:
	push_s blink
L_8cbafe:
	push_s r13
L_8cbb00:
	ld_s r13,[r0,0x48]
L_8cbb02:
	breq_s r13,0,L_8cbb24
L_8cbb04:
	ld_s r2,[r13]
L_8cbb06:
	breq_s r1,0,L_8cbb16
L_8cbb08:
	mov_s r1,0x100a624
L_8cbb0e:
	mov_s r0,0x20
L_8cbb10:
	bl.d L_8dcc80
L_8cbb14:
	ld_s r3,[r13,0x4]
	.global L_8cbb16
L_8cbb16:
	ld_s r0,[r13]
L_8cbb18:
	brne r0,0xbdf0bdf0,L_8cbb24
L_8cbb20:
	ld_s r0,[r13,0x4]
L_8cbb22:
	b_s L_8cbb28
	.global L_8cbb24
L_8cbb24:
	mov r0,-0x1
	.global L_8cbb28
L_8cbb28:
	b L_8c025c
