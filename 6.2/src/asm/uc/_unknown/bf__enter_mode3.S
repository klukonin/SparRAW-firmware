/* bf__enter_mode3 @ 0x920cb8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__brp_init_result, bf_sm__txss_init_result
 * Зовёт сам: __ld_r13_to_r13_ret, bf__pause_sta_tx, internal_tx__check_idle
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__enter_mode3
bf__enter_mode3:
	.global L_920cb8
L_920cb8:
	push_s blink
L_920cba:
	push_s r13
L_920cbc:
	mov_s r13,r1
L_920cbe:
	st.as r1,[gp,-0x2e]
L_920cc2:
	bl.d L_92bd30
L_920cc6:
	mov_s r0,0x3
L_920cc8:
	mov_s r0,0x3
L_920cca:
	bl.d L_92ba54
L_920cce:
	mov_s r1,r13
L_920cd0:
	b L_9202ac
