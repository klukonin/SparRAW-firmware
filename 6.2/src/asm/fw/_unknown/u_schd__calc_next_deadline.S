/* u_schd__calc_next_deadline @ 0x8cc4c8, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__arm_timer
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, time_cmp, u_schd__deadline_less
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__calc_next_deadline
u_schd__calc_next_deadline:
	.global L_8cc4c8
L_8cc4c8:
	push_s blink
L_8cc4ca:
	bl L_8c01d4
L_8cc4ce:
	sub_s sp,sp,0x4
L_8cc4d0:
	mov_s r15,r0
L_8cc4d2:
	mov_s r17,r1
L_8cc4d4:
	mov r18,0x0
L_8cc4d8:
	mov_s r13,r18
L_8cc4da:
	b_s L_8cc4e8
	.global L_8cc4dc
L_8cc4dc:
	st_s r1,[r15]
L_8cc4de:
	st r13,[r17]
L_8cc4e2:
	mov r18,0x1
	.global L_8cc4e6
L_8cc4e6:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8cc4e8
L_8cc4e8:
	brge r13,0x2,L_8cc52a
L_8cc4ec:
	mov_s r14,0x803c54
L_8cc4f2:
	add2_s r14,r14,r13
L_8cc4f4:
	mov_s r1,sp
L_8cc4f6:
	bl.d L_8cc28c
L_8cc4fa:
	ld_s r0,[r14]
L_8cc4fc:
	ld_s r14,[r14]
L_8cc4fe:
	mov_s r16,r0
L_8cc500:
	ld_s r0,[r14,0x10]
L_8cc502:
	ld_s r2,[r0,0x4]
L_8cc504:
	mov_s r0,r14
L_8cc506:
	jl_s.d [r2]
L_8cc508:
	mov_s r1,0x0
L_8cc50a:
	st_s r0,[r14,0xc]
L_8cc50c:
	breq r16,0x0,L_8cc4e6
L_8cc510:
	ld_s r1,[sp,0x0]
L_8cc512:
	breq r18,0x0,L_8cc4dc
L_8cc516:
	bl.d L_8e91bc
L_8cc51a:
	ld_s r0,[r15]
L_8cc51c:
	brne r0,0x1,L_8cc4e6
L_8cc520:
	ld_s r0,[sp,0x0]
L_8cc522:
	st_s r0,[r15]
L_8cc524:
	st r13,[r17]
L_8cc528:
	b_s L_8cc4e6
	.global L_8cc52a
L_8cc52a:
	mov_s r0,r18
L_8cc52c:
	b.d L_8c0234
L_8cc530:
	add_s sp,sp,0x4
L_8cc532:
	nop_s
