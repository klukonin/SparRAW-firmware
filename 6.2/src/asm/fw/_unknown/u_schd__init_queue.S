/* u_schd__init_queue @ 0x8d9118, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__run
 * Зовёт сам: __ld_r13_to_r13_ret, llist__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__init_queue
u_schd__init_queue:
	.global L_8d9118
L_8d9118:
	push_s blink
L_8d911a:
	push_s r13
L_8d911c:
	bl.d L_8e293c
L_8d9120:
	mov_s r13,r0
L_8d9122:
	ld_s r0,[r13,0x10]
L_8d9124:
	ld_s r2,[r0,0x4]
L_8d9126:
	mov_s r0,r13
L_8d9128:
	jl_s.d [r2]
L_8d912a:
	mov_s r1,0x0
L_8d912c:
	b.d L_8c025c
L_8d9130:
	st_s r0,[r13,0xc]
L_8d9132:
	nop_s
