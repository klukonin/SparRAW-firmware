/* timer_list__insert_sorted @ 0x92e788, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_list__insert_by_prio
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global timer_list__insert_sorted
timer_list__insert_sorted:
	.global L_92e788
L_92e788:
	push_s blink
L_92e78a:
	bl.d L_920230
L_92e78e:
	mov_s r3,0x0
L_92e790:
	mov_s r14,0x8017b8
L_92e796:
	add2_s r14,r14,r1
L_92e798:
	ld_s r1,[r14]
L_92e79a:
	ld_s r13,[r0]
L_92e79c:
	breq_s r1,0,L_92e7b6
	.global L_92e79e
L_92e79e:
	ld_s r15,[r1]
L_92e7a0:
	breq_s r2,0,L_92e7a8
L_92e7a2:
	brlo r15,r13,L_92e7ac
L_92e7a6:
	b_s L_92e7b6
	.global L_92e7a8
L_92e7a8:
	brhs r13,r15,L_92e7b6
	.global L_92e7ac
L_92e7ac:
	ld_s r15,[r1,0x8]
L_92e7ae:
	breq_s r15,0,L_92e7ba
L_92e7b0:
	mov_s r3,r1
L_92e7b2:
	mov_s r1,r15
L_92e7b4:
	b_s L_92e79e
	.global L_92e7b6
L_92e7b6:
	mov_s r15,r1
L_92e7b8:
	mov_s r1,r3
	.global L_92e7ba
L_92e7ba:
	st_s r15,[r0,0x8]
L_92e7bc:
	brne_s r1,0,L_92e7c2
L_92e7be:
	st_s r0,[r14]
L_92e7c0:
	b_s L_92e7c4
	.global L_92e7c2
L_92e7c2:
	st_s r0,[r1,0x8]
	.global L_92e7c4
L_92e7c4:
	b L_92029c
