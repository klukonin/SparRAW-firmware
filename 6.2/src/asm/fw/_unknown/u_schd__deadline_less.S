/* u_schd__deadline_less @ 0x8cc28c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__calc_next_deadline, u_schd__pop_expired
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__deadline_less
u_schd__deadline_less:
	.global L_8cc28c
L_8cc28c:
	push_s blink
L_8cc28e:
	push_s r13
L_8cc290:
	ld_s r2,[r0,0x4]
L_8cc292:
	mov_s r13,r1
L_8cc294:
	cmp_s r2,0x0
L_8cc296:
	mov.eq r0,0x0
L_8cc29a:
	beq_s L_8cc2a8
L_8cc29c:
	ld_s r1,[r0,0x10]
L_8cc29e:
	ld_s r3,[r1,0x4]
L_8cc2a0:
	jl_s.d [r3]
L_8cc2a2:
	ld_s r1,[r2,0x8]
L_8cc2a4:
	st_s r0,[r13]
L_8cc2a6:
	mov_s r0,0x1
	.global L_8cc2a8
L_8cc2a8:
	b L_8c025c
