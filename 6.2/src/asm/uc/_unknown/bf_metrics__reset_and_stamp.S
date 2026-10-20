/* bf_metrics__reset_and_stamp @ 0x93d28c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow, tx_sta__run_txop
 * Зовёт сам: __ld_r13_to_r13_ret, memset0_words_uc, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_metrics__reset_and_stamp
bf_metrics__reset_and_stamp:
	.global L_93d28c
L_93d28c:
	push_s blink
L_93d28e:
	push_s r13
L_93d290:
	mov_s r13,0x802210
L_93d296:
	mov_s r0,r13
L_93d298:
	bl.d L_920a84
L_93d29c:
	mov_s r1,0x18
L_93d29e:
	bl L_9364c8
L_93d2a2:
	b.d L_9202ac
L_93d2a6:
	st_s r0,[r13,0x10]
