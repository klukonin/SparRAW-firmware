/* brd_if_multi_array__verify_board_file_format_version @ 0x8ebd18, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::verify_board_file_format_version: Board File Format Version 0x%X is different from expected 0x%X
 *   brd_if_multi_array::verify_board_file_format_version: Board File Format Version matches expected version= 0x%X
 * Зовут его: brd_if_multi_array__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, brd_if_multi_array__get_board_file_format_version, fw_log_emit1, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__verify_board_file_format_version
brd_if_multi_array__verify_board_file_format_version:
	.global L_8ebd18
L_8ebd18:
	push_s blink
L_8ebd1a:
	bl L_8c01e4
L_8ebd1e:
	mov_s r14,r0
L_8ebd20:
	bl.d L_8cbafc
L_8ebd24:
	mov_s r13,r1
L_8ebd26:
	breq r0,0x20000000,L_8ebd4e
L_8ebd2e:
	mov_s r0,r14
L_8ebd30:
	mov_s r13,0x0
L_8ebd32:
	bl.d L_8cbafc
L_8ebd36:
	mov_s r1,r13
L_8ebd38:
	mov_s r2,r0
L_8ebd3a:
	mov_s r1,0x100a684
L_8ebd40:
	mov_s r0,0x20
L_8ebd42:
	mov_s r3,0x0
L_8ebd44:
	bl.d L_8dcc80
L_8ebd48:
	bset_s r3,r3,0x1d
L_8ebd4a:
	mov_s r0,r13
L_8ebd4c:
	b_s L_8ebd62
	.global L_8ebd4e
L_8ebd4e:
	breq_s r13,0,L_8ebd60
L_8ebd50:
	mov_s r1,0x100a6fc
L_8ebd56:
	mov_s r0,0x20
L_8ebd58:
	mov_s r2,0x0
L_8ebd5a:
	bl.d L_8dcc10
L_8ebd5e:
	bset_s r2,r2,0x1d
	.global L_8ebd60
L_8ebd60:
	mov_s r0,0x1
	.global L_8ebd62
L_8ebd62:
	b L_8c0254
L_8ebd66:
	nop_s
