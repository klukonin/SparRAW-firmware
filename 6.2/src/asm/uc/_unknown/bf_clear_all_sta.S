/* bf_clear_all_sta @ 0x9218b4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bf_clear_all_sta() tail: %d, head: %d, non_idle_mask: 0x%x
 * Зовут его: ucode_cmd_0x24_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf__reset_sta, uc_log__emit3
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_clear_all_sta
bf_clear_all_sta:
	.global L_9218b4
L_9218b4:
	push_s blink
L_9218b6:
	bl L_920234
L_9218ba:
	b_s L_9218e2
	.global L_9218bc
L_9218bc:
	ld_s r0,[r14,0x34]
L_9218be:
	mov_s r1,0x1000d3c
L_9218c4:
	ld_s r2,[r14,0x44]
L_9218c6:
	norm r0,r0
L_9218ca:
	ld_s r3,[r14,0x40]
L_9218cc:
	rsub r13,r0,0x1e
L_9218d0:
	ld r4,[r14, 0x34]
L_9218d4:
	bl.d L_92d338
L_9218d8:
	mov_s r0,0x20
L_9218da:
	mov_s r0,r13
L_9218dc:
	bl.d L_92210c
L_9218e0:
	mov_s r1,0x0
	.global L_9218e2
L_9218e2:
	mov_s r14,0x80207c
L_9218e8:
	ld_s r1,[r14,0x44]
L_9218ea:
	ld_s r0,[r14,0x40]
L_9218ec:
	brlo r0,r1,L_9218bc
L_9218f0:
	b L_9202a4
