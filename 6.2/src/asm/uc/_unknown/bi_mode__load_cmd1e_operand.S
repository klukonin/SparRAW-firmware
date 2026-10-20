/* bi_mode__load_cmd1e_operand @ 0x9364ec, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_mode__load_cmd1e_operand
bi_mode__load_cmd1e_operand:
	.global L_9364ec
L_9364ec:
	push_s blink
L_9364ee:
	mov_s r0,0x886d80
L_9364f4:
	st 0xc0a0f1e,[r0, 0x8]
L_9364fc:
	mov_s r0,0x1e010004
L_936502:
	mov_s r32,r0
L_936504:
	st.ab r0,[r25,0x4]
L_936508:
	bclr r25,r25,0xa
L_93650c:
	mov_s r0,0x1e010001
L_936512:
	mov_s r32,r0
L_936514:
	st.ab r0,[r25,0x4]
L_936518:
	bclr r25,r25,0xa
L_93651c:
	pop_s blink
L_93651e:
	j_s [blink]
