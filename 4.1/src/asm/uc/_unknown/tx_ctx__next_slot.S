/* tx_ctx__next_slot @ 0x933414, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder_worker, bi_mode_init_sequence, bti_worker__bti_transmitter_beacon_sweep_flow, internal_tx_step, rx_funcs__rx_flow, tx_initiator_flow, tx_rate_select_and_program, ucode_cmd__queue_delete
 */
	.section .text.tx_ctx__next_slot,"ax",@progbits
	.global tx_ctx__next_slot
tx_ctx__next_slot:
	.global L_933414
L_933414:
	push_s r13
L_933416:
	mov_s r2,0x801a18
L_93341c:
	ld_s r1,[r2,0x68]
L_93341e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_933420:
	bmsk r13,r1,0x0
L_933424:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_933426:
	add1_s r13,r13,r13
L_933428:
	add_s r3,r13,r2
L_93342a:
	breq_s r0,0,L_933430
L_93342c:
	st_s r1,[r2,0x68]
L_93342e:
	st_s r3,[r2,0x60]
	.global L_933430
L_933430:
	mov_s r1,0x0
L_933432:
	st_s r1,[r3,0xc]
L_933434:
	mov_s r0,0xff
L_933436:
	st_s r0,[r3,0x4]
L_933438:
	st_s r1,[r3,0x1c]
L_93343a:
	st_s r1,[r3,0x20]
L_93343c:
	mov_s r0,0x80087c
L_933442:
	ld_s r0,[r0]
L_933444:
	st_s r1,[r3,0x2c]
L_933446:
	st_s r0,[r3,0x28]
L_933448:
	mov_s r0,0xf
L_93344a:
	st_s r0,[r3,0x18]
L_93344c:
	mov_s r0,r3
L_93344e:
	j_s.d [blink]
L_933450:
	pop_s r13
L_933452:
	nop_s
