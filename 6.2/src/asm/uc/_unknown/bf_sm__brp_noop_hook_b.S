/* bf_sm__brp_noop_hook_b @ 0x93cc8c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__on_brp_init, bf_sm__on_brp_resp
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__brp_noop_hook_b
bf_sm__brp_noop_hook_b:
	.global L_93cc8c
L_93cc8c:
	j_s [blink]
L_93cc8e:
	nop_s
