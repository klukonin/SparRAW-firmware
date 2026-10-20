/* abft__arm_response_window @ 0x9305e8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__respond_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global abft__arm_response_window
abft__arm_response_window:
	.global L_9305e8
L_9305e8:
	push_s r13
L_9305ea:
	mov_s r13,blink
L_9305ec:
	mov_s r1,0x4d00000a
L_9305f2:
	mov_s r32,r1
L_9305f4:
	st.ab r1,[r25,0x4]
L_9305f8:
	bclr r25,r25,0xa
L_9305fc:
	nop_s
L_9305fe:
	nop_s
L_930600:
	nop_s
L_930602:
	mov_s r2,r55
L_930604:
	ldw r0,[0x80167c]
L_93060c:
	mov_s blink,r13
L_93060e:
	cmp_s r2,r0
L_930610:
	rlc r0,0x0
L_930614:
	j.d [blink]
L_930618:
	pop_s r13
L_93061a:
	nop_s
