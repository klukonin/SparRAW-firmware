/* u_schd__invoke_callback @ 0x8c64d4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__reschedule
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__invoke_callback
u_schd__invoke_callback:
	.global L_8c64d4
L_8c64d4:
	push_s blink
L_8c64d6:
	push_s r13
L_8c64d8:
	mov_s r13,r0
L_8c64da:
	ld_s r0,[r0,0x10]
L_8c64dc:
	ld_s r2,[r0,0x4]
L_8c64de:
	mov_s r0,r13
L_8c64e0:
	jl_s.d [r2]
L_8c64e2:
	mov_s r1,0x0
L_8c64e4:
	ld_s r1,[r13,0xc]
L_8c64e6:
	cmp_s r0,r1
L_8c64e8:
	mov_s r0,0x1
L_8c64ea:
	b.d L_8c025c
L_8c64ee:
	sub.eq r0,r0,r0
L_8c64f2:
	nop_s
