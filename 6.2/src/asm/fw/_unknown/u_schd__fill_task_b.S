/* u_schd__fill_task_b @ 0x8e6f88, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__insert_timer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__fill_task_b
u_schd__fill_task_b:
	.global L_8e6f88
L_8e6f88:
	st_s r1,[r0,0xc]
L_8e6f8a:
	st_s r2,[r0,0x10]
L_8e6f8c:
	st_s r3,[r0,0x14]
L_8e6f8e:
	mov_s r1,0x0
L_8e6f90:
	j_s.d [blink]
L_8e6f92:
	st_s r1,[r0]
