/* brd_if__clear_section_info @ 0x8c5a20, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__find_section, brd_if_multi_array__get_section_info, tail_brd_if__clear_section_info
 */
	.section .text.brd_if__clear_section_info,"ax",@progbits
	.global brd_if__clear_section_info
brd_if__clear_section_info:
	.global L_8c5a20
L_8c5a20:
	mov r1,-0x1
L_8c5a24:
	st_s r1,[r0]
L_8c5a26:
	mov_s r1,0x0
L_8c5a28:
	st_s r1,[r0,0x4]
L_8c5a2a:
	st_s r1,[r0,0x8]
L_8c5a2c:
	j_s.d [blink]
L_8c5a2e:
	st_s r1,[r0,0xc]
