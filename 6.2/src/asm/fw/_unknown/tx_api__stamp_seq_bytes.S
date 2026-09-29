/* tx_api__stamp_seq_bytes @ 0x8c84ec, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__send_packet
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__stamp_seq_bytes
tx_api__stamp_seq_bytes:
	.global L_8c84ec
L_8c84ec:
	push_s r13
L_8c84ee:
	mov_s r3,0x0
L_8c84f0:
	b_s L_8c851a
	.global L_8c84f2
L_8c84f2:
	add_s r12,r0,r3
L_8c84f4:
	stb_s r1,[r12]
L_8c84f6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c84f8:
	extb_s r1,r1
L_8c84fa:
	add_s r13,r3,0x1
L_8c84fc:
	add_s r13,r13,r0
L_8c84fe:
	stb_s r1,[r13]
L_8c8500:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c8502:
	extb_s r1,r1
L_8c8504:
	add_s r13,r3,0x2
L_8c8506:
	add_s r13,r13,r0
L_8c8508:
	stb_s r1,[r13]
L_8c850a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c850c:
	extb_s r1,r1
L_8c850e:
	add_s r13,r3,0x3
L_8c8510:
	add_s r13,r13,r0
L_8c8512:
	stb_s r1,[r13]
L_8c8514:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c8516:
	extb_s r1,r1
L_8c8518:
	/* add_s r3,0x4 */
	.byte 0x04,0xe3
	.global L_8c851a
L_8c851a:
	bic r13,r2,0x3
L_8c851e:
	brlo r3,r13,L_8c84f2
	.global L_8c8522
L_8c8522:
	bmsk r13,r2,0x1
L_8c8526:
	brhs r3,r13,L_8c8536
L_8c852a:
	add_s r12,r0,r3
L_8c852c:
	stb_s r1,[r12]
L_8c852e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c8530:
	extb_s r1,r1
L_8c8532:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8c8534:
	b_s L_8c8522
	.global L_8c8536
L_8c8536:
	j_s.d [blink]
L_8c8538:
	pop_s r13
L_8c853a:
	nop_s
