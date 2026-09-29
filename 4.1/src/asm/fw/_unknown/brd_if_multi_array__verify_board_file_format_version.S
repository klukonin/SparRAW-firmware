/* brd_if_multi_array__verify_board_file_format_version @ 0x8e70dc, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::verify_board_file_format_version: Board File Format Version 0x%X is different from expected 0x%X
 *   brd_if_multi_array::verify_board_file_format_version: Board File Format Version matches expected version= 0x%X
 * Зовут его: brd_if_multi_array__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, brd_if_multi_array__get_board_file_format_version, fw_log__emit1, fw_log__emit2
 */
	.section .text.brd_if_multi_array__verify_board_file_format_version,"ax",@progbits
	.global brd_if_multi_array__verify_board_file_format_version
brd_if_multi_array__verify_board_file_format_version:
	.global L_8e70dc
L_8e70dc:
	push_s blink
L_8e70de:
	bl L_8c02c4
L_8e70e2:
	mov_s r14,r0
L_8e70e4:
	bl.d L_8c9a84
L_8e70e8:
	mov_s r13,r1
L_8e70ea:
	breq r0,0x20000000,L_8e7118
L_8e70f2:
	mov_s r0,r14
L_8e70f4:
	mov_s r13,0x0
L_8e70f6:
	bl.d L_8c9a84
L_8e70fa:
	mov_s r1,0x0
L_8e70fc:
	mov_s r3,r0
L_8e70fe:
	mov_s r2,0x10090e0
L_8e7104:
	mov_s r0,0x0
L_8e7106:
	mov r4,0x20000000
L_8e710e:
	bl.d L_8edff8
L_8e7112:
	mov_s r1,0x2
L_8e7114:
	mov_s r0,r13
L_8e7116:
	b_s L_8e712e
	.global L_8e7118
L_8e7118:
	breq_s r13,0,L_8e712c
L_8e711a:
	mov_s r2,0x1009158
L_8e7120:
	mov_s r0,0x0
L_8e7122:
	mov_s r1,0x2
L_8e7124:
	mov_s r3,0x0
L_8e7126:
	bl.d L_8edfcc
L_8e712a:
	bset_s r3,r3,0x1d
	.global L_8e712c
L_8e712c:
	mov_s r0,0x1
	.global L_8e712e
L_8e712e:
	b L_8c0334
L_8e7132:
	nop_s
