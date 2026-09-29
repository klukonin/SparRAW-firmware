/* bf_sm__on_brp_init @ 0x9224dc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__dispatch_by_state
 * Зовёт сам: __ld_r13_to_r13_ret, bf_sm__brp_noop_hook_a, bf_sm__brp_noop_hook_b, brp_init__flow, g_80212c__reset
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__on_brp_init
bf_sm__on_brp_init:
	.global L_9224dc
L_9224dc:
	push_s blink
L_9224de:
	push_s r13
L_9224e0:
	asl_s r1,r0,0x2
L_9224e2:
	add2_s r1,r1,r1
L_9224e4:
	mov_s r2,0x802000
L_9224ea:
	ld_s r1,[r2,r1]
L_9224ec:
	breq_s r1,0,L_9224f6
L_9224ee:
	breq r1,0x30,L_922502
L_9224f2:
	mov_s r13,0x2
L_9224f4:
	b_s L_922504
	.global L_9224f6
L_9224f6:
	bl.d L_935208
L_9224fa:
	mov_s r13,0x0
L_9224fc:
	bl L_922728
L_922500:
	b_s L_922504
	.global L_922502
L_922502:
	mov_s r13,0x1
	.global L_922504
L_922504:
	breq_s r13,0,L_92250e
L_922506:
	bl L_93cc8c
L_92250a:
	bl L_92b1d8
	.global L_92250e
L_92250e:
	b.d L_9202ac
L_922512:
	mov_s r0,r13
