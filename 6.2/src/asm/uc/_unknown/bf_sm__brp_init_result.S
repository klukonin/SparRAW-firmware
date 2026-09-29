/* bf_sm__brp_init_result @ 0x922494, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo
 * Зовёт сам: __ld_r13_to_r13_ret, bf__enter_mode3
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__brp_init_result
bf_sm__brp_init_result:
	.global L_922494
L_922494:
	push_s blink
L_922496:
	push_s r13
L_922498:
	mov_s r1,r0
L_92249a:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92249c:
	add2_s r0,r0,r0
L_92249e:
	mov_s r2,0x802000
L_9224a4:
	ld_s r0,[r2,r0]
L_9224a6:
	mov_s r13,0x0
L_9224a8:
	breq_s r0,0,L_9224b6
L_9224aa:
	breq r0,0x30,L_9224c4
L_9224ae:
	breq r0,0x31,L_9224c8
	.global L_9224b2
L_9224b2:
	mov_s r0,0x2
L_9224b4:
	b_s L_9224d8
	.global L_9224b6
L_9224b6:
	stb r13,[gp, -0xf8]
L_9224ba:
	bl.d L_920cb8
L_9224be:
	mov_s r0,0x9
L_9224c0:
	mov_s r0,r13
L_9224c2:
	b_s L_9224d8
	.global L_9224c4
L_9224c4:
	mov_s r0,0x1
L_9224c6:
	b_s L_9224d8
	.global L_9224c8
L_9224c8:
	ldb_s r0,[gp,-0xf8]
L_9224ca:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9224cc:
	extb_s r0,r0
L_9224ce:
	brge.d r0,0x4,L_9224b2
L_9224d2:
	stb r0,[gp, -0xf8]
L_9224d6:
	mov_s r0,0x4
	.global L_9224d8
L_9224d8:
	b L_9202ac
