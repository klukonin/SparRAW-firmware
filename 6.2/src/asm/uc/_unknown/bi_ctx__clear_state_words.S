/* bi_ctx__clear_state_words @ 0x92ae0c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_ctx__set_active
 * Зовёт сам: memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_ctx__clear_state_words
bi_ctx__clear_state_words:
	.global L_92ae0c
L_92ae0c:
	mov r0,0x802f32
L_92ae14:
	b.d L_920a84
L_92ae18:
	mov_s r1,0x2
L_92ae1a:
	nop_s
