/* u_schd__calc_next_deadline @ 0x8ca2a0, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__arm_timer
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, time_cmp, u_schd__deadline_less
 */
	.section .text.u_schd__calc_next_deadline,"ax",@progbits
	.global u_schd__calc_next_deadline
u_schd__calc_next_deadline:
	.global L_8ca2a0
L_8ca2a0:
	push_s blink
L_8ca2a2:
	bl L_8c02b4
L_8ca2a6:
	sub_s sp,sp,0x4
L_8ca2a8:
	mov_s r15,r0
L_8ca2aa:
	mov_s r17,r1
L_8ca2ac:
	mov r18,0x0
L_8ca2b0:
	mov_s r13,r18
L_8ca2b2:
	b_s L_8ca2c0
	.global L_8ca2b4
L_8ca2b4:
	st_s r1,[r15]
L_8ca2b6:
	st r13,[r17]
L_8ca2ba:
	mov r18,0x1
	.global L_8ca2be
L_8ca2be:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8ca2c0
L_8ca2c0:
	brge r13,0x2,L_8ca302
L_8ca2c4:
	mov_s r14,0x8034a8
L_8ca2ca:
	add2_s r14,r14,r13
L_8ca2cc:
	mov_s r1,sp
L_8ca2ce:
	bl.d L_8ca070
L_8ca2d2:
	ld_s r0,[r14]
L_8ca2d4:
	ld_s r14,[r14]
L_8ca2d6:
	mov_s r16,r0
L_8ca2d8:
	ld_s r0,[r14,0x10]
L_8ca2da:
	ld_s r2,[r0,0x4]
L_8ca2dc:
	mov_s r0,r14
L_8ca2de:
	jl_s.d [r2]
L_8ca2e0:
	mov_s r1,0x0
L_8ca2e2:
	st_s r0,[r14,0xc]
L_8ca2e4:
	breq r16,0x0,L_8ca2be
L_8ca2e8:
	ld_s r1,[sp,0x0]
L_8ca2ea:
	breq r18,0x0,L_8ca2b4
L_8ca2ee:
	bl.d L_8e431c
L_8ca2f2:
	ld_s r0,[r15]
L_8ca2f4:
	brne r0,0x1,L_8ca2be
L_8ca2f8:
	ld_s r0,[sp,0x0]
L_8ca2fa:
	st_s r0,[r15]
L_8ca2fc:
	st r13,[r17]
L_8ca300:
	b_s L_8ca2be
	.global L_8ca302
L_8ca302:
	mov_s r0,r18
L_8ca304:
	b.d L_8c0314
L_8ca308:
	add_s sp,sp,0x4
L_8ca30a:
	nop_s
