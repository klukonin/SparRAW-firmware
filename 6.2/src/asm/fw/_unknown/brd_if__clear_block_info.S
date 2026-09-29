/* brd_if__clear_block_info @ 0x8c6790, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if__clear_block_info_thunk, brd_if_multi_array__get_block_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if__clear_block_info
brd_if__clear_block_info:
	.global L_8c6790
L_8c6790:
	mov r1,-0x1
L_8c6794:
	st_s r1,[r0]
L_8c6796:
	st_s r1,[r0,0x4]
L_8c6798:
	mov_s r1,0x0
L_8c679a:
	st_s r1,[r0,0x8]
L_8c679c:
	st_s r1,[r0,0xc]
L_8c679e:
	st_s r1,[r0,0x10]
L_8c67a0:
	j_s.d [blink]
L_8c67a2:
	st_s r1,[r0,0x14]
