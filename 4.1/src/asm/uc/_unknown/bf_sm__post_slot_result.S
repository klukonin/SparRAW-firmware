/* bf_sm__post_slot_result @ 0x9233b0, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__post_and_dispatch
 * Зовёт сам: __ld_r13_ret_uc, bf_sm__reset_slot_table, bf_sm__state_action, brp_flow_step, stub_ret_93076c, stub_ret_937088
 */
	.section .text.bf_sm__post_slot_result,"ax",@progbits
	.global bf_sm__post_slot_result
bf_sm__post_slot_result:
	.global L_9233b0
L_9233b0:
	push_s blink
L_9233b2:
	push_s r13
L_9233b4:
	mov_s r13,r0
L_9233b6:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9233b8:
	add1_s r0,r0,r0
L_9233ba:
	mov_s r2,0x800ef8
L_9233c0:
	ld_s r0,[r2,r0]
L_9233c2:
	mov_s r1,0x1
L_9233c4:
	breq_s r0,0,L_9233d2
L_9233c6:
	cmp_s r0,0x33
L_9233c8:
	mov.eq r13,r1
L_9233cc:
	mov.ne r13,0x2
L_9233d0:
	b_s L_9233e6
	.global L_9233d2
L_9233d2:
	mov_s r0,r13
L_9233d4:
	bl.d L_9281a0
L_9233d8:
	mov_s r1,0xa
L_9233da:
	bl L_93076c
L_9233de:
	bl.d L_923400
L_9233e2:
	mov_s r0,r13
L_9233e4:
	mov_s r13,0x0
	.global L_9233e6
L_9233e6:
	breq_s r13,0,L_9233fa
L_9233e8:
	bl L_937088
L_9233ec:
	bl L_928380
L_9233f0:
	mov_s r1,0x0
L_9233f2:
	mov_s r0,0x80100c
L_9233f8:
	stw_s r1,[r0,0x24]
	.global L_9233fa
L_9233fa:
	b.d L_92028c
L_9233fe:
	mov_s r0,r13
