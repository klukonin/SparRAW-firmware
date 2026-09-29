/* bf__init_globals @ 0x9219c8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: g_80212c__reset, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__init_globals
bf__init_globals:
	.global L_9219c8
L_9219c8:
	push_s blink
L_9219ca:
	bl L_92b1d8
L_9219ce:
	mov_s r0,0x21
L_9219d0:
	stw.as r0,[gp,-0x5d]
L_9219d4:
	stw.as r0,[gp,-0x5e]
L_9219d8:
	mov_s r1,0x80
L_9219da:
	mov_s r0,0x8021b8
L_9219e0:
	stb_s r1,[r0]
L_9219e2:
	mov_s r0,0x857e38
L_9219e8:
	bl.d L_920a84
L_9219ec:
	mov_s r1,0xa0
L_9219ee:
	pop_s blink
L_9219f0:
	j_s [blink]
L_9219f2:
	nop_s
