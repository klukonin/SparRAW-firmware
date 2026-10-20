/* maintain_sm__action_8dcf84 @ 0x8dcf84, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   trigger long term BF, maximal_goodput:%u
 * Зовёт сам: __ld_r13_to_r13_ret, bf_lt__get_max_goodput, fw_log_emit1, maintain_sm__lock_radio
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8dcf84
maintain_sm__action_8dcf84:
	.global L_8dcf84
L_8dcf84:
	push_s blink
L_8dcf86:
	push_s r13
L_8dcf88:
	mov_s r13,r0
L_8dcf8a:
	bl.d L_8cc3cc
L_8dcf8e:
	add_s r0,r0,0x2c
L_8dcf90:
	mov_s r2,r0
L_8dcf92:
	mov_s r1,0x1014688
L_8dcf98:
	bl.d L_8dcc10
L_8dcf9c:
	mov_s r0,0x20
L_8dcf9e:
	bl.d L_8e2904
L_8dcfa2:
	mov_s r0,r13
L_8dcfa4:
	b L_8c025c
