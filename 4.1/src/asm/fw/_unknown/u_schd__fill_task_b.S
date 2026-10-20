/* u_schd__fill_task_b @ 0x8e204c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__insert
 */
	.section .text.u_schd__fill_task_b,"ax",@progbits
	.global u_schd__fill_task_b
u_schd__fill_task_b:
	.global L_8e204c
L_8e204c:
	st_s r1,[r0,0xc]
L_8e204e:
	st_s r2,[r0,0x10]
L_8e2050:
	st_s r3,[r0,0x14]
L_8e2052:
	mov_s r1,0x0
L_8e2054:
	j_s.d [blink]
L_8e2056:
	st_s r1,[r0]
