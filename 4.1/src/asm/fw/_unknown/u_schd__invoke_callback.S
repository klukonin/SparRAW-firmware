/* u_schd__invoke_callback @ 0x8c5804, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__reschedule
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.u_schd__invoke_callback,"ax",@progbits
	.global u_schd__invoke_callback
u_schd__invoke_callback:
	.global L_8c5804
L_8c5804:
	push_s blink
L_8c5806:
	push_s r13
L_8c5808:
	mov_s r13,r0
L_8c580a:
	ld_s r0,[r0,0x10]
L_8c580c:
	ld_s r2,[r0,0x4]
L_8c580e:
	mov_s r0,r13
L_8c5810:
	jl_s.d [r2]
L_8c5812:
	mov_s r1,0x0
L_8c5814:
	ld_s r1,[r13,0xc]
L_8c5816:
	cmp_s r0,r1
L_8c5818:
	mov_s r0,0x1
L_8c581a:
	b.d L_8c033c
L_8c581e:
	sub.eq r0,r0,r0
L_8c5822:
	nop_s
