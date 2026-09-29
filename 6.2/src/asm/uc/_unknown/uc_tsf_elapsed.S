/* uc_tsf_elapsed @ 0x92483c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_bi_step
 * Зовёт сам: __ld_r13_to_r13_ret, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_tsf_elapsed
uc_tsf_elapsed:
	.global L_92483c
L_92483c:
	push_s blink
L_92483e:
	push_s r13
L_924840:
	bl.d L_9364c8
L_924844:
	mov_s r13,r0
L_924846:
	b.d L_9202ac
L_92484a:
	sub_s r0,r0,r13
