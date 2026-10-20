/* aw__fold_peer_masks @ 0x924880, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__collect_awake_peers
 */
	.section .text.aw__fold_peer_masks,"ax",@progbits
	.global aw__fold_peer_masks
aw__fold_peer_masks:
	.global L_924880
L_924880:
	cmp_s r1,0x0
L_924882:
	jeq_s [blink]
L_924884:
	mov r11,0x857849
L_92488c:
	mov r10,0x802080
	.global L_924894
L_924894:
	norm r8,r1
L_924898:
	rsub r9,r8,0x1e
L_92489c:
	extb r9,r9
L_9248a0:
	asl r7,r9,0x2
L_9248a4:
	add2 r7,r7,r7
L_9248a8:
	ldb r3,[r11,r7]
L_9248ac:
	asl r6,0x1,r9
L_9248b4:
	breq_s r3,0,L_9248d8
L_9248b6:
	ldb r5,[r0]
L_9248ba:
	or r5,r5,r6
L_9248be:
	stb r5,[r0]
L_9248c2:
	ldb r4,[r2]
L_9248c6:
	or r4,r4,r6
L_9248ca:
	stb r4,[r2]
L_9248ce:
	ldb r3,[r10, 0xa]
L_9248d2:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_9248d4:
	stb r3,[r10, 0xa]
	.global L_9248d8
L_9248d8:
	bic r1,r1,r6
L_9248dc:
	extb.f r1,r1
L_9248e0:
	jeq [blink]
L_9248e4:
	b_s L_924894
L_9248e6:
	nop_s
