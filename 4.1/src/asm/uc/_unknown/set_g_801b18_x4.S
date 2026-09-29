/* set_g_801b18_x4 @ 0x92836c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 */
	.section .text.set_g_801b18_x4,"ax",@progbits
	.global set_g_801b18_x4
set_g_801b18_x4:
	.global L_92836c
L_92836c:
	mov_s r1,0x0
L_92836e:
	mov_s r0,0x801b08
L_928374:
	st_s r1,[r0,0x10]
L_928376:
	st_s r1,[r0,0x14]
L_928378:
	st_s r1,[r0,0x18]
L_92837a:
	j_s.d [blink]
L_92837c:
	st_s r1,[r0,0x1c]
L_92837e:
	nop_s
