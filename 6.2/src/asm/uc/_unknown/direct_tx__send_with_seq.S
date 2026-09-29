/* direct_tx__send_with_seq @ 0x9382b0, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__send_response
 * Зовёт сам: direct_tx__issue_cmd_33, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx__send_with_seq
direct_tx__send_with_seq:
	.global L_9382b0
L_9382b0:
	push_s blink
L_9382b2:
	asl r33,r1,0x4
L_9382b6:
	ld.as r1,[gp,-0x5]
L_9382ba:
	/* sub_s r1,r1,0x4 */
	.byte 0x64,0xb9
L_9382bc:
	st.as r1,[gp,-0x5]
L_9382c0:
	breq_s r2,0,L_9382d0
L_9382c2:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9382c4:
	add2_s r0,r0,r0
L_9382c6:
	add r1,r0,0x801134
L_9382ce:
	b_s L_9382d6
	.global L_9382d0
L_9382d0:
	mov_s r1,0x8006c4
	.global L_9382d6
L_9382d6:
	ldw_s r0,[r1]
L_9382d8:
	bset r34,r0,0x18
L_9382dc:
	ldw_s r0,[r1,0x2]
L_9382de:
	bset r34,r0,0x18
L_9382e2:
	ldw_s r0,[r1,0x4]
L_9382e4:
	bset r34,r0,0x18
L_9382e8:
	ld_s r0,[gp,-0x14]
L_9382ea:
	sub_s r0,r0,0xc
L_9382ec:
	st.as r0,[gp,-0x5]
L_9382f0:
	mov_s r0,0x33000443
L_9382f6:
	mov_s r32,r0
L_9382f8:
	st.ab r0,[r25,0x4]
L_9382fc:
	bclr r25,r25,0xa
L_938300:
	bl L_925874
L_938304:
	ld_s r0,[gp,-0x14]
L_938306:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_938308:
	st.as r0,[gp,-0x5]
L_93830c:
	mov_s r0,0x33000123
L_938312:
	mov_s r32,r0
L_938314:
	st.ab r0,[r25,0x4]
L_938318:
	bclr r25,r25,0xa
L_93831c:
	bl L_925874
L_938320:
	mov_s r0,0x886544
L_938326:
	ld_s r0,[r0]
L_938328:
	mov_s r2,0x886500
L_93832e:
	bmsk_s r0,r0,0xb
L_938330:
	add_s r1,r0,0x1
L_938332:
	asl_s r1,r1,0x10
L_938334:
	and r1,r1,0xfff0000
L_93833c:
	bset_s r1,r1,0x1c
L_93833e:
	st_s r1,[r2,0x44]
L_938340:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_938342:
	bset r34,r0,0x18
L_938346:
	ld_s r0,[gp,-0x14]
L_938348:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_93834a:
	bl.d L_925774
L_93834e:
	st.as r0,[gp,-0x5]
L_938352:
	pop_s blink
L_938354:
	j_s [blink]
L_938356:
	nop_s
