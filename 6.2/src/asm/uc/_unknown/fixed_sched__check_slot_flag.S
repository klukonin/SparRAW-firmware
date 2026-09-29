/* fixed_sched__check_slot_flag @ 0x922458, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 * Зовёт сам: __ld_r13_to_r13_ret, fixed_sched__slot_word8, fsched__cur_entry_byte0, macq__kick_queue_tx, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__check_slot_flag
fixed_sched__check_slot_flag:
	.global L_922458
L_922458:
	push_s blink
L_92245a:
	push_s r13
L_92245c:
	mov_s r13,r0
L_92245e:
	ldb r0,[r0, 0x2d]
L_922462:
	brne_s r0,0,L_922486
	.global L_922464
L_922464:
	bl.d L_927dbc
L_922468:
	mov_s r0,r13
L_92246a:
	mov_s r3,r0
L_92246c:
	bl.d L_927d78
L_922470:
	mov_s r0,r13
L_922472:
	mov_s r2,r0
L_922474:
	mov_s r0,r3
L_922476:
	bl.d L_925a48
L_92247a:
	mov_s r1,0x0
L_92247c:
	mov_s r0,0x1
L_92247e:
	b.d L_9202ac
L_922482:
	stb r0,[r13, 0x2d]
	.global L_922486
L_922486:
	mov_s r0,blink
L_922488:
	mov_s r1,0x158e
L_92248e:
	bl L_926618
L_922492:
	b_s L_922464
