/* bf__abort_to_state11 @ 0x924fd0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r13_ret_uc, bf__clear_pending_and_notify, bf_state__set
 */
	.section .text.bf__abort_to_state11,"ax",@progbits
	.global bf__abort_to_state11
bf__abort_to_state11:
	.global L_924fd0
L_924fd0:
	push_s blink
L_924fd2:
	push_s r13
L_924fd4:
	bl.d L_924fb8
L_924fd8:
	mov_s r13,r0
L_924fda:
	mov_s r0,r13
L_924fdc:
	bl.d L_9283c8
L_924fe0:
	mov_s r1,0x11
L_924fe2:
	b L_92028c
L_924fe6:
	nop_s
