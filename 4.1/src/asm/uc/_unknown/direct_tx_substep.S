/* direct_tx_substep @ 0x93336c, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__send_response
 * Зовёт сам: direct_tx__issue_cmd_33, uc_wait_direct_tx_ready
 */
	.section .text.direct_tx_substep,"ax",@progbits
	.global direct_tx_substep
direct_tx_substep:
	.global L_93336c
L_93336c:
	push_s blink
L_93336e:
	asl r33,r1,0x4
L_933372:
	ld.as r1,[gp,-0x6]
L_933376:
	/* sub_s r1,r1,0x4 */
	.byte 0x64,0xb9
L_933378:
	st.as r1,[gp,-0x6]
L_93337c:
	breq_s r2,0,L_93338c
L_93337e:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_933380:
	add3_s r0,r0,r0
L_933382:
	add r1,r0,0x8011bc
L_93338a:
	b_s L_933392
	.global L_93338c
L_93338c:
	mov_s r1,0x80066c
	.global L_933392
L_933392:
	ldw_s r0,[r1]
L_933394:
	bset r34,r0,0x18
L_933398:
	ldw_s r0,[r1,0x2]
L_93339a:
	bset r34,r0,0x18
L_93339e:
	ldw_s r0,[r1,0x4]
L_9333a0:
	bset r34,r0,0x18
L_9333a4:
	ld_s r0,[gp,-0x18]
L_9333a6:
	sub_s r0,r0,0xc
L_9333a8:
	st.as r0,[gp,-0x6]
L_9333ac:
	mov_s r0,0x33000443
L_9333b2:
	mov_s r32,r0
L_9333b4:
	st.ab r0,[r25,0x4]
L_9333b8:
	bclr r25,r25,0xa
L_9333bc:
	bl L_924f7c
L_9333c0:
	ld_s r0,[gp,-0x18]
L_9333c2:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_9333c4:
	st.as r0,[gp,-0x6]
L_9333c8:
	mov_s r0,0x33000123
L_9333ce:
	mov_s r32,r0
L_9333d0:
	st.ab r0,[r25,0x4]
L_9333d4:
	bclr r25,r25,0xa
L_9333d8:
	bl L_924f7c
L_9333dc:
	mov_s r0,0x886544
L_9333e2:
	ld_s r0,[r0]
L_9333e4:
	mov_s r2,0x886500
L_9333ea:
	bmsk_s r0,r0,0xb
L_9333ec:
	add_s r1,r0,0x1
L_9333ee:
	asl_s r1,r1,0x10
L_9333f0:
	and r1,r1,0xfff0000
L_9333f8:
	bset_s r1,r1,0x1c
L_9333fa:
	st_s r1,[r2,0x44]
L_9333fc:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9333fe:
	bset r34,r0,0x18
L_933402:
	ld_s r0,[gp,-0x18]
L_933404:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_933406:
	bl.d L_924e6c
L_93340a:
	st.as r0,[gp,-0x6]
L_93340e:
	pop_s blink
L_933410:
	j_s [blink]
L_933412:
	nop_s
