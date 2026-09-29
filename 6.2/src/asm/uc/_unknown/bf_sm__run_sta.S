/* bf_sm__run_sta @ 0x921940, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_isr, l1__rx_then_check_bf_abort, rx_flow__run_and_check_bf_abort, rx_funcs__rx_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_sm__clear_slot_diag, bf_sm__dispatch_by_state
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__run_sta
bf_sm__run_sta:
	.global L_921940
L_921940:
	push_s blink
L_921942:
	bl L_920234
L_921946:
	mov_s r13,r0
L_921948:
	mov_s r14,0x801ffc
L_92194e:
	asl_s r1,r13,0x2
L_921950:
	add2_s r1,r1,r1
L_921952:
	ld_s r1,[r14,r1]
L_921954:
	mov_s r0,0x0
L_921956:
	cmp_s r1,0xa
L_921958:
	mov_s r1,0x1
L_92195a:
	sub_s.ne r1,r1,r1
L_92195c:
	b_s L_92197c
	.global L_92195e
L_92195e:
	bl.d L_921fa8
L_921962:
	mov_s r0,r13
L_921964:
	asl_s r1,r13,0x2
L_921966:
	add2_s r1,r1,r1
L_921968:
	add_s r2,r14,r1
L_92196a:
	ld_s r2,[r2,0x4]
L_92196c:
	ld_s r1,[r14,r1]
L_92196e:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_921970:
	or_s r1,r1,r2
L_921972:
	mov_s r2,0x802110
L_921978:
	st_s r1,[r2,0x10]
L_92197a:
	mov_s r1,0x0
	.global L_92197c
L_92197c:
	cmp_s r0,0x2
L_92197e:
	cmp.ne r0,0x3
L_921982:
	bne_s L_92195e
L_921984:
	bl.d L_9218f4
L_921988:
	mov_s r1,r13
L_92198a:
	b L_9202a4
L_92198e:
	nop_s
