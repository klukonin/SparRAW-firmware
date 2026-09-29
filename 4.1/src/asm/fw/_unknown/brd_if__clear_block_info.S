/* brd_if__clear_block_info @ 0x8c5a0c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_block_info, tail_brd_if__clear_block_info
 */
	.section .text.brd_if__clear_block_info,"ax",@progbits
	.global brd_if__clear_block_info
brd_if__clear_block_info:
	.global L_8c5a0c
L_8c5a0c:
	mov r1,-0x1
L_8c5a10:
	st_s r1,[r0]
L_8c5a12:
	st_s r1,[r0,0x4]
L_8c5a14:
	mov_s r1,0x0
L_8c5a16:
	st_s r1,[r0,0x8]
L_8c5a18:
	st_s r1,[r0,0xc]
L_8c5a1a:
	st_s r1,[r0,0x10]
L_8c5a1c:
	j_s.d [blink]
L_8c5a1e:
	st_s r1,[r0,0x14]
