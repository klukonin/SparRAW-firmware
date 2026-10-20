/* u_schd__timer_set_fields @ 0x8e6114, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__insert_timer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__timer_set_fields
u_schd__timer_set_fields:
	.global L_8e6114
L_8e6114:
	st_s r1,[r0,0x8]
L_8e6116:
	mov_s r1,0x1
L_8e6118:
	stb_s r1,[r0,0x19]
L_8e611a:
	j_s.d [blink]
L_8e611c:
	stb r4,[r0, 0x18]
