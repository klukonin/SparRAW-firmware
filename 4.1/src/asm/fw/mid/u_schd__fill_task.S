/* u_schd__fill_task @ 0x8e1444, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__insert
 */
	.section .text.u_schd__fill_task,"ax",@progbits
	.global u_schd__fill_task
u_schd__fill_task:
	.global L_8e1444
L_8e1444:
	push_s r13
L_8e1446:
	st_s r1,[r0,0x8]
L_8e1448:
	st_s r2,[r0,0x18]
L_8e144a:
	st_s r3,[r0,0x1c]
L_8e144c:
	mov_s r1,0x1
L_8e144e:
	st_s r1,[r0,0x24]
L_8e1450:
	stw r4,[r0, 0x20]
L_8e1454:
	j_s.d [blink]
L_8e1456:
	pop_s r13
