/* uc_tsf_elapsed @ 0x924568, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_bi_step, perform_shallow_sleep
 * Зовёт сам: __ld_r13_ret_uc, uc_read_tsf_lo
 */
	.section .text.uc_tsf_elapsed,"ax",@progbits
	.global uc_tsf_elapsed
uc_tsf_elapsed:
	.global L_924568
L_924568:
	push_s blink
L_92456a:
	push_s r13
L_92456c:
	bl.d L_9315e8
L_924570:
	mov_s r13,r0
L_924572:
	b.d L_92028c
L_924576:
	sub_s r0,r0,r13
