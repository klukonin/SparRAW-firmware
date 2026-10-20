/* periodic_service__tick @ 0x8e4828, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: periodic_service__run, periodic_service__start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, timer_task__cancel, u_schd__now, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global periodic_service__tick
periodic_service__tick:
	.global L_8e4828
L_8e4828:
	push_s blink
L_8e482a:
	bl L_8c01e0
L_8e482e:
	mov_s r13,r0
L_8e4830:
	bl.d L_8e9524
L_8e4834:
	mov_s r15,r1
L_8e4836:
	ld_s r0,[r13,0x28]
L_8e4838:
	cmp_s r0,0x0
L_8e483a:
	mov_s r0,0x0
L_8e483c:
	bne_s L_8e48a0
L_8e483e:
	ld_s r1,[r13,0x14]
L_8e4840:
	ld_s r2,[r13,0x8]
L_8e4842:
	ld_s r14,[r13,0x18]
L_8e4844:
	sub r0,r14,r1
L_8e4848:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e484a:
	breq_s r2,0,L_8e4854
L_8e484c:
	ld_s r2,[r13]
L_8e484e:
	cmp_s r0,r2
L_8e4850:
	mov.cs r14,r1
	.global L_8e4854
L_8e4854:
	mov r0,-0x1
L_8e4858:
	brne r15,r0,L_8e4872
L_8e485c:
	brne r14,r0,L_8e4864
L_8e4860:
	ld_s r15,[r13]
L_8e4862:
	b_s L_8e4872
	.global L_8e4864
L_8e4864:
	bl L_8e9524
L_8e4868:
	sub_s r0,r0,r14
L_8e486a:
	ld_s r1,[r13]
L_8e486c:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e486e:
	sub r15,r1,r0
	.global L_8e4872
L_8e4872:
	brlt r15,0x11,L_8e4896
L_8e4876:
	bl.d L_8c8e74
L_8e487a:
	mov_s r0,r13
L_8e487c:
	mov_s r0,0x5b8c
L_8e4882:
	mov_s r1,r13
L_8e4884:
	mov_s r2,0x0
L_8e4886:
	ld_s r3,[r13,0x4]
L_8e4888:
	mov_s r4,r15
L_8e488a:
	mov_s r5,r2
L_8e488c:
	bl.d L_8e0c0c
L_8e4890:
	mov_s r6,r2
L_8e4892:
	st_s r0,[r13,0x10]
L_8e4894:
	b_s L_8e489e
	.global L_8e4896
L_8e4896:
	ld_s r0,[r13,0x2c]
L_8e4898:
	ld_s r1,[r0,0x10]
L_8e489a:
	jl_s.d [r1]
L_8e489c:
	mov_s r0,r13
	.global L_8e489e
L_8e489e:
	ld_s r0,[r13,0x10]
	.global L_8e48a0
L_8e48a0:
	b L_8c024c
