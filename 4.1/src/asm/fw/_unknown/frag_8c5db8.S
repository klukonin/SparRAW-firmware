/* frag_8c5db8 @ 0x8c5db8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__task
 */
	.section .text.frag_8c5db8,"ax",@progbits
	.global frag_8c5db8
frag_8c5db8:
	.global L_8c5db8
L_8c5db8:
	push_s r13
L_8c5dba:
	push_s r14
L_8c5dbc:
	ld_s r13,[r0,0x34]
L_8c5dbe:
	ldb r14,[r0, 0x30]
L_8c5dc2:
	mov_s r0,r13
L_8c5dc4:
	add r0,r0,0x1a4
L_8c5dc8:
	ld.as r0,[r0,r14]
L_8c5dcc:
	cmp_s r1,0x0
L_8c5dce:
	cmp.ne r2,0x0
L_8c5dd2:
	beq_s L_8c5dec
L_8c5dd4:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8c5dd6:
	add3_s r14,r14,r14
L_8c5dd8:
	add_s r13,r13,r14
L_8c5dda:
	ld_s r1,[r13,0x14]
L_8c5ddc:
	brge r3,r1,L_8c5de4
L_8c5de0:
	ld_s r0,[r13,0x10]
L_8c5de2:
	b_s L_8c5dec
	.global L_8c5de4
L_8c5de4:
	ld_s r1,[r13,0x18]
L_8c5de6:
	brge r1,r3,L_8c5dec
L_8c5dea:
	ld_s r0,[r13,0xc]
	.global L_8c5dec
L_8c5dec:
	pop_s r14
L_8c5dee:
	j_s.d [blink]
L_8c5df0:
	pop_s r13
L_8c5df2:
	nop_s
