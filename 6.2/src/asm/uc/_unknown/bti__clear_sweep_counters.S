/* bti__clear_sweep_counters @ 0x930dc8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__clear_sweep_counters
bti__clear_sweep_counters:
	.global L_930dc8
L_930dc8:
	mov_s r0,0x802a6c
L_930dce:
	b.d L_920a84
L_930dd2:
	mov_s r1,0x24
