/* bf_substate_sm__is_state_9_11 @ 0x93635c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beamforming_substate_sm.c
 * Зовут его: bf_sm__substate_advance
 * Зовёт сам: __ld_r13_ret_uc, uc_sysassert
 */
	.section .text.bf_substate_sm__is_state_9_11,"ax",@progbits
	.global bf_substate_sm__is_state_9_11
bf_substate_sm__is_state_9_11:
	.global L_93635c
L_93635c:
	push_s blink
L_93635e:
	push_s r13
L_936360:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_936362:
	add1_s r0,r0,r0
L_936364:
	mov_s r1,0x800ef8
L_93636a:
	ld_s r0,[r1,r0]
L_93636c:
	mov_s r13,0x0
L_93636e:
	breq r0,0x9,L_93638e
L_936372:
	breq r0,0xa,L_936392
L_936376:
	breq r0,0xb,L_936396
L_93637a:
	mov_s r0,blink
L_93637c:
	mov_s r2,0x1000ba0
L_936382:
	mov_s r1,0x1a
L_936384:
	bl.d L_925548
L_936388:
	mov_s r3,0x80
L_93638a:
	mov_s r0,r13
L_93638c:
	b_s L_936398
	.global L_93638e
L_93638e:
	mov_s r0,0x1
L_936390:
	b_s L_936398
	.global L_936392
L_936392:
	mov_s r0,0x3
L_936394:
	b_s L_936398
	.global L_936396
L_936396:
	mov_s r0,0x2
	.global L_936398
L_936398:
	b L_92028c
