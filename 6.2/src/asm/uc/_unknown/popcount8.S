/* popcount8 @ 0x92828c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_initiator_brp_transaction_flow, brp_responder_flow_enter, config_brp_rf
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global popcount8
popcount8:
	.global L_92828c
L_92828c:
	mov_s r1,r0
L_92828e:
	mov_s r0,0x0
L_928290:
	mov_s r2,r0
L_928292:
	b_s L_9282a0
	.global L_928294
L_928294:
	bbit0 r1,r2,L_92829c
L_928298:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92829a:
	extb_s r0,r0
	.global L_92829c
L_92829c:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_92829e:
	extb_s r2,r2
	.global L_9282a0
L_9282a0:
	brlt r2,0x8,L_928294
L_9282a4:
	j_s [blink]
L_9282a6:
	nop_s
