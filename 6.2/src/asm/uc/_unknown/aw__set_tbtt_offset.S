/* aw__set_tbtt_offset @ 0x934dbc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw__set_tbtt_offset
aw__set_tbtt_offset:
	.global L_934dbc
L_934dbc:
	stw_s r1,[r0,0x10]
L_934dbe:
	mul64 r1,0xa5
L_934dc2:
	j_s.d [blink]
L_934dc4:
	st mlo,[r0, 0xc]
