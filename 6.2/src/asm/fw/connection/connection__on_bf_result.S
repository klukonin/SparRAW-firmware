/* connection__on_bf_result @ 0x8c54ec, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__abft_notify_evt
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn__threshold_to_offset, connection__bf_id_at_6c, connection__cmp_bf_id, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global connection__on_bf_result
connection__on_bf_result:
	.global L_8c54ec
L_8c54ec:
	push_s blink
L_8c54ee:
	bl L_8c01dc
L_8c54f2:
	mov.f r13,r1
L_8c54f6:
	mov_s r16,r0
L_8c54f8:
	mov_s r14,0x0
L_8c54fa:
	bne_s L_8c5504
L_8c54fc:
	mov_s r1,0x80103c
L_8c5502:
	b_s L_8c550e
	.global L_8c5504
L_8c5504:
	brne r13,0x1,L_8c5516
L_8c5508:
	mov_s r1,0x80104c
	.global L_8c550e
L_8c550e:
	bl.d L_8c7528
L_8c5512:
	mov_s r0,r16
L_8c5514:
	mov_s r14,r0
	.global L_8c5516
L_8c5516:
	brhs r13,0x3,L_8c5544
	.global L_8c551a
L_8c551a:
	breq_s r13,0,L_8c552c
L_8c551c:
	mov_s r0,r16
L_8c551e:
	bl.d L_8e75a4
L_8c5522:
	mov_s r1,r14
L_8c5524:
	bl.d L_8e75e8
L_8c5528:
	mov_s r0,r16
L_8c552a:
	mov_s r14,r0
	.global L_8c552c
L_8c552c:
	add3 r15,r16,0x30
L_8c5530:
	stb_s r14,[r15,0xd]
L_8c5532:
	ld_s r0,[gp,-0x174]
L_8c5534:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c5536:
	st.as r0,[gp,-0x5d]
L_8c553a:
	ldb_s r0,[r15,0xd]
L_8c553c:
	b.d L_8c0244
L_8c5540:
	stb r0,[gp, 0xc3]
	.global L_8c5544
L_8c5544:
	mov_s r0,blink
L_8c5546:
	mov_s r1,0x11c1
L_8c554c:
	bl L_8c9b28
L_8c5550:
	b_s L_8c551a
L_8c5552:
	nop_s
