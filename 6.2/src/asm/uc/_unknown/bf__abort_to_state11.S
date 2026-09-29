/* bf__abort_to_state11 @ 0x9258c8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x0f_handler
 * Зовёт сам: __ld_r13_to_r13_ret, bf__clear_pending_and_notify, bf_sm__set_sta_state
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__abort_to_state11
bf__abort_to_state11:
	.global L_9258c8
L_9258c8:
	push_s blink
L_9258ca:
	push_s r13
L_9258cc:
	bl.d L_9258b0
L_9258d0:
	mov_s r13,r0
L_9258d2:
	mov_s r0,r13
L_9258d4:
	bl.d L_92b220
L_9258d8:
	mov_s r1,0x11
L_9258da:
	b L_9202ac
L_9258de:
	nop_s
