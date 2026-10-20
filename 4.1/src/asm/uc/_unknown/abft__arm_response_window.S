/* abft__arm_response_window @ 0x92c810, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder_worker
 */
	.section .text.abft__arm_response_window,"ax",@progbits
	.global abft__arm_response_window
abft__arm_response_window:
	.global L_92c810
L_92c810:
	push_s r13
L_92c812:
	mov_s r13,blink
L_92c814:
	mov_s r1,0x4d00000a
L_92c81a:
	mov_s r32,r1
L_92c81c:
	st.ab r1,[r25,0x4]
L_92c820:
	bclr r25,r25,0xa
L_92c824:
	nop_s
L_92c826:
	nop_s
L_92c828:
	nop_s
L_92c82a:
	mov_s r2,r55
L_92c82c:
	ldw r0,[0x802060]
L_92c834:
	mov_s blink,r13
L_92c836:
	cmp_s r2,r0
L_92c838:
	rlc r0,0x0
L_92c83c:
	j.d [blink]
L_92c840:
	pop_s r13
L_92c842:
	nop_s
