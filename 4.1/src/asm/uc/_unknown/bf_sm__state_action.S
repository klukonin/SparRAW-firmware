/* bf_sm__state_action @ 0x9281a0, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__post_slot_result, bf_substate__txss_step_by_slot, bf_substate_sm__step
 * Зовёт сам: __ld_r13_ret_uc, bf__clear_sta_bit_state34
 */
	.section .text.bf_sm__state_action,"ax",@progbits
	.global bf_sm__state_action
bf_sm__state_action:
	.global L_9281a0
L_9281a0:
	push_s blink
L_9281a2:
	sub_s r2,r1,0x3
L_9281a4:
	push_s r13
L_9281a6:
	brhs.d r2,0x8,L_928200
L_9281aa:
	mov_s r3,r1
L_9281ac:
	ldb.x r2,[0x800bd0,r2]
L_9281b4:
	add r1,pcl,0x8
L_9281b8:
	add1_s r1,r1,r2
L_9281ba:
	j_s [r1]
L_9281bc:
	mov_s r1,0x0
L_9281be:
	mov_s r2,0x80100c
L_9281c4:
	stw_s r1,[r2,0x24]
L_9281c6:
	asl_s r1,r0,0x3
L_9281c8:
	add3_s r1,r1,r1
L_9281ca:
	add_s r1,r1,0x801190
L_9281d0:
	ldw_s r13,[r1,0x2c]
L_9281d2:
	mov_s r3,0x3
	.global L_9281d4
L_9281d4:
	stw_s r13,[r2,0x1c]
L_9281d6:
	ldw_s r13,[r1,0x2e]
L_9281d8:
	ldw_s r1,[r1,0x30]
L_9281da:
	stw_s r13,[r2,0x1e]
L_9281dc:
	stw_s r1,[r2,0x20]
L_9281de:
	b_s L_928200
L_9281e0:
	mov_s r3,0x9
L_9281e2:
	asl_s r1,r0,0x3
L_9281e4:
	add3_s r1,r1,r1
L_9281e6:
	add_s r1,r1,0x801190
L_9281ec:
	mov_s r2,0x80100c
L_9281f2:
	ldw_s r13,[r1,0x2c]
L_9281f4:
	b_s L_9281d4
L_9281f6:
	mov_s r2,0x0
L_9281f8:
	mov_s r1,0x80100c
L_9281fe:
	stw_s r2,[r1,0x24]
	.global L_928200
L_928200:
	bl.d L_92b678
L_928204:
	mov_s r1,r3
L_928206:
	b L_92028c
L_92820a:
	nop_s
