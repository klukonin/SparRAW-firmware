/* bf_sm__on_txss_init @ 0x93b8d0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__dispatch_by_state
 * Зовёт сам: __ld_r13_to_r13_ret, bf_txss__reset_report_ctx, g_80212c__reset, txss_init__flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__on_txss_init
bf_sm__on_txss_init:
	.global L_93b8d0
L_93b8d0:
	push_s blink
L_93b8d2:
	push_s r13
L_93b8d4:
	mov_s r13,r0
L_93b8d6:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93b8d8:
	add2_s r0,r0,r0
L_93b8da:
	mov_s r1,0x802000
L_93b8e0:
	ld_s r0,[r1,r0]
L_93b8e2:
	breq_s r0,0,L_93b8ec
L_93b8e4:
	breq r0,0x5,L_93b8fa
L_93b8e8:
	mov_s r13,0x2
L_93b8ea:
	b_s L_93b8fc
	.global L_93b8ec
L_93b8ec:
	bl L_92ebfc
L_93b8f0:
	bl.d L_93bc90
L_93b8f4:
	mov_s r0,r13
L_93b8f6:
	mov_s r13,0x0
L_93b8f8:
	b_s L_93b8fc
	.global L_93b8fa
L_93b8fa:
	mov_s r13,0x1
	.global L_93b8fc
L_93b8fc:
	cmp_s r13,0x0
L_93b8fe:
	bl.ne L_92b1d8
L_93b902:
	b.d L_9202ac
L_93b906:
	mov_s r0,r13
