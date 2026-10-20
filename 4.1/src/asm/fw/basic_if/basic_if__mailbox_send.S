/* basic_if__mailbox_send @ 0x8e048c, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_if.cpp
 * Зовут его: basic_if__post_event, send_cmd2_lmac
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, fw_mailbox__write, fw_read_timer, fw_sysassert_fatal, mailbox_debug_dump, mbox_ring__advance
 */
	.section .text.basic_if__mailbox_send,"ax",@progbits
	.global basic_if__mailbox_send
basic_if__mailbox_send:
	.global L_8e048c
L_8e048c:
	push_s blink
L_8e048e:
	bl L_8c02a4
L_8e0492:
	mov_s r15,r0
L_8e0494:
	mov.f r13,r1
L_8e0498:
	mov_s r16,r2
L_8e049a:
	mov_s r17,r3
L_8e049c:
	mov r21,r4
L_8e04a0:
	mov r18,r5
L_8e04a4:
	mov r19,r6
L_8e04a8:
	mov r20,r7
L_8e04ac:
	beq_s L_8e053a
	.global L_8e04ae
L_8e04ae:
	add_s r14,r15,0x4
L_8e04b0:
	bl.d L_8d739c
L_8e04b4:
	mov_s r0,r14
L_8e04b6:
	brne_s r0,0,L_8e04ce
L_8e04b8:
	bl.d L_8d9ba8
L_8e04bc:
	mov_s r0,r14
L_8e04be:
	mov_s r0,blink
L_8e04c0:
	mov_s r2,0x100269c
L_8e04c6:
	mov_s r1,0xc4
L_8e04c8:
	bl.d L_8c82c0
L_8e04cc:
	mov_s r3,0x3b
	.global L_8e04ce
L_8e04ce:
	sub_s r13,r13,0x10
L_8e04d0:
	stw r16,[r13, 0x4]
L_8e04d4:
	ldw_s.x r0,[r15]
L_8e04d6:
	stw_s r0,[r13]
L_8e04d8:
	mov_s r0,0x0
L_8e04da:
	stb_s r0,[r13,0x6]
L_8e04dc:
	ld r22,[r14, 0xc]
L_8e04e0:
	mov_s r16,r0
L_8e04e2:
	ldw r0,[r22, 0x4]
L_8e04e6:
	brge r0,r21,L_8e04ee
L_8e04ea:
	breq r19,0x0,L_8e054c
	.global L_8e04ee
L_8e04ee:
	stw r21,[r13, 0x2]
L_8e04f2:
	stb r21,[r13, 0x7]
L_8e04f6:
	stb r18,[r13, 0x8]
L_8e04fa:
	stb r16,[r13, 0x9]
L_8e04fe:
	bl.d L_8e4694
L_8e0502:
	stw r17,[r13, 0xa]
L_8e0506:
	st_s r0,[r13,0xc]
L_8e0508:
	bmsk r0,r19,0x0
L_8e050c:
	ldw_s r1,[r13,0x6]
L_8e050e:
	asl_s r0,r0
L_8e0510:
	bclr_s r0,r0,0x2
L_8e0512:
	bmsk r2,r20,0x0
L_8e0516:
	bic r1,r1,0x6
L_8e051a:
	or_s r0,r0,r1
L_8e051c:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_8e051e:
	or_s r2,r2,r0
L_8e0520:
	stw_s r2,[r13,0x6]
L_8e0522:
	ldw_s.x r0,[r15]
L_8e0524:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e0526:
	stw_s r0,[r15]
L_8e0528:
	mov_s r0,r14
L_8e052a:
	bl.d L_8c9198
L_8e052e:
	mov_s r1,r13
L_8e0530:
	ld_s r1,[r14]
L_8e0532:
	b.d L_8c02f4
L_8e0536:
	st r1,[r22, 0xc]
	.global L_8e053a
L_8e053a:
	mov_s r0,blink
L_8e053c:
	mov_s r2,0x100269c
L_8e0542:
	mov_s r1,0xc3
L_8e0544:
	bl.d L_8c82c0
L_8e0548:
	mov_s r3,0x37
L_8e054a:
	b_s L_8e04ae
	.global L_8e054c
L_8e054c:
	brne r20,0x0,L_8e04ee
L_8e0550:
	mov_s r0,blink
L_8e0552:
	mov_s r2,0x100269c
L_8e0558:
	mov_s r1,0xc5
L_8e055a:
	bl.d L_8c82c0
L_8e055e:
	mov_s r3,0x4c
