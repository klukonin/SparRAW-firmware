/* sched_bitmap__next_set_bit @ 0x92ff78, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rate_search__reset_stats, rs_start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sched_bitmap__next_set_bit
sched_bitmap__next_set_bit:
	.global L_92ff78
L_92ff78:
	push_s blink
L_92ff7a:
	bl.d L_920230
L_92ff7e:
	mul64 r0,0x2c
L_92ff82:
	mov_s r1,0x80268c
L_92ff88:
	ldb r1,[r1,mlo]
L_92ff8c:
	mov_s r14,0x0
L_92ff8e:
	mul64 r0,0x26
L_92ff92:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92ff94:
	rsub r2,r1,0x20
L_92ff98:
	mov r3,-0x1
L_92ff9c:
	cmp_s r1,0x0
L_92ff9e:
	lsr r13,r3,r2
L_92ffa2:
	add r15,mlo,0x8027d0
L_92ffaa:
	mov.ne r1,r13
L_92ffae:
	mov.eq r1,r3
L_92ffb2:
	ldw_s r0,[r15,0x24]
L_92ffb4:
	ldw_s r13,[r15,0x22]
L_92ffb6:
	asl_s r0,r0,0x10
L_92ffb8:
	or_s r13,r13,r0
L_92ffba:
	bic_s r13,r13,r1
L_92ffbc:
	b_s L_92ffc0
	.global L_92ffbe
L_92ffbe:
	mov_s r13,r0
	.global L_92ffc0
L_92ffc0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_92ffc2:
	ldw_s r1,[r15,0x24]
L_92ffc4:
	ldw_s r0,[r15,0x22]
L_92ffc6:
	asl_s r1,r1,0x10
L_92ffc8:
	or_s r0,r0,r1
L_92ffca:
	norm r0,r0
L_92ffce:
	rsub r1,r0,0x1e
L_92ffd2:
	brlo r1,r14,L_92ffe2
	.global L_92ffd6
L_92ffd6:
	lsr_s r0,r13
L_92ffd8:
	bbit0 r13,0x1,L_92ffbe
L_92ffdc:
	b.d L_92029c
L_92ffe0:
	mov_s r0,r14
	.global L_92ffe2
L_92ffe2:
	mov_s r0,blink
L_92ffe4:
	bl.d L_926618
L_92ffe8:
	mov_s r1,0x1
L_92ffea:
	b_s L_92ffd6
