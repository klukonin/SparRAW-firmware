/* brd_section_info__reset @ 0x8c67a4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if__section_info_reset_thunk, brd_if_multi_array__find_section, brd_if_multi_array__get_section_info_8ccb84
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_section_info__reset
brd_section_info__reset:
	.global L_8c67a4
L_8c67a4:
	mov r1,-0x1
L_8c67a8:
	st_s r1,[r0]
L_8c67aa:
	mov_s r1,0x0
L_8c67ac:
	st_s r1,[r0,0x4]
L_8c67ae:
	st_s r1,[r0,0x8]
L_8c67b0:
	st_s r1,[r0,0xc]
L_8c67b2:
	j_s.d [blink]
L_8c67b4:
	stb_s r1,[r0,0x14]
L_8c67b6:
	nop_s
