/* bf_sm__advance_if_slot33 @ 0x923388, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__substate_advance
 * Зовёт сам: __ld_r13_ret_uc, bf_sm__reset_slot_table
 */
	.section .text.bf_sm__advance_if_slot33,"ax",@progbits
	.global bf_sm__advance_if_slot33
bf_sm__advance_if_slot33:
	.global L_923388
L_923388:
	push_s blink
L_92338a:
	push_s r13
L_92338c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92338e:
	add1_s r0,r0,r0
L_923390:
	mov_s r1,0x800ef8
L_923396:
	ld_s r0,[r1,r0]
L_923398:
	mov_s r13,0x1
L_92339a:
	cmp_s r0,0x33
L_92339c:
	sub.eq r13,r13,r13
L_9233a0:
	add.f r13,r13,0x1
L_9233a4:
	bl.ne L_928380
L_9233a8:
	b.d L_92028c
L_9233ac:
	mov_s r0,r13
L_9233ae:
	nop_s
