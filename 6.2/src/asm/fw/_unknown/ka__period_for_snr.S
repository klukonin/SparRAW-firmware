/* ka__period_for_snr @ 0x8c6b4c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__task
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ka__period_for_snr
ka__period_for_snr:
	.global L_8c6b4c
L_8c6b4c:
	push_s r13
L_8c6b4e:
	push_s r14
L_8c6b50:
	ld_s r13,[r0,0x34]
L_8c6b52:
	ldb r14,[r0, 0x30]
L_8c6b56:
	mov_s r0,r13
L_8c6b58:
	add r0,r0,0x1a4
L_8c6b5c:
	ld.as r0,[r0,r14]
L_8c6b60:
	cmp_s r1,0x0
L_8c6b62:
	cmp.ne r2,0x0
L_8c6b66:
	beq_s L_8c6b80
L_8c6b68:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8c6b6a:
	add3_s r14,r14,r14
L_8c6b6c:
	add_s r13,r13,r14
L_8c6b6e:
	ld_s r1,[r13,0x14]
L_8c6b70:
	brge r3,r1,L_8c6b78
L_8c6b74:
	ld_s r0,[r13,0x10]
L_8c6b76:
	b_s L_8c6b80
	.global L_8c6b78
L_8c6b78:
	ld_s r1,[r13,0x18]
L_8c6b7a:
	brge r1,r3,L_8c6b80
L_8c6b7e:
	ld_s r0,[r13,0xc]
	.global L_8c6b80
L_8c6b80:
	pop_s r14
L_8c6b82:
	j_s.d [blink]
L_8c6b84:
	pop_s r13
L_8c6b86:
	nop_s
