/* u_schd__init_queue @ 0x8d6088, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__large_task_warn
 * Зовёт сам: __ld_r13_ret, llist__init
 */
	.section .text.u_schd__init_queue,"ax",@progbits
	.global u_schd__init_queue
u_schd__init_queue:
	.global L_8d6088
L_8d6088:
	push_s blink
L_8d608a:
	push_s r13
L_8d608c:
	bl.d L_8de5c4
L_8d6090:
	mov_s r13,r0
L_8d6092:
	ld_s r0,[r13,0x10]
L_8d6094:
	ld_s r2,[r0,0x4]
L_8d6096:
	mov_s r0,r13
L_8d6098:
	jl_s.d [r2]
L_8d609a:
	mov_s r1,0x0
L_8d609c:
	b.d L_8c033c
L_8d60a0:
	st_s r0,[r13,0xc]
L_8d60a2:
	nop_s
