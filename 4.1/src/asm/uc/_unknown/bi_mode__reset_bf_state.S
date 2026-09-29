/* bi_mode__reset_bf_state @ 0x9222a0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: bf_sm__reset_slot_table, memset0_words_uc
 */
	.section .text.bi_mode__reset_bf_state,"ax",@progbits
	.global bi_mode__reset_bf_state
bi_mode__reset_bf_state:
	.global L_9222a0
L_9222a0:
	push_s blink
L_9222a2:
	bl L_928380
L_9222a6:
	mov_s r0,0x21
L_9222a8:
	stw.as r0,[gp,-0x5f]
L_9222ac:
	stw.as r0,[gp,-0x60]
L_9222b0:
	mov_s r1,0x80
L_9222b2:
	mov_s r0,0x8010e8
L_9222b8:
	stb_s r1,[r0,0x8]
L_9222ba:
	mov_s r0,0x857838
L_9222c0:
	bl.d L_92166c
L_9222c4:
	mov_s r1,0xa0
L_9222c6:
	pop_s blink
L_9222c8:
	j_s [blink]
L_9222ca:
	nop_s
