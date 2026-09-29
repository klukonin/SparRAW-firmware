/* aw__fold_peer_masks @ 0x924ec0, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__collect_awake_peers
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw__fold_peer_masks
aw__fold_peer_masks:
	.global L_924ec0
L_924ec0:
	cmp_s r1,0x0
L_924ec2:
	jeq_s [blink]
L_924ec4:
	mov r11,0x857e49
L_924ecc:
	mov r10,0x803118
	.global L_924ed4
L_924ed4:
	norm r8,r1
L_924ed8:
	rsub r9,r8,0x1e
L_924edc:
	extb r9,r9
L_924ee0:
	asl r7,r9,0x2
L_924ee4:
	add2 r7,r7,r7
L_924ee8:
	ldb r3,[r11,r7]
L_924eec:
	asl r6,0x1,r9
L_924ef4:
	breq_s r3,0,L_924f18
L_924ef6:
	ldb r5,[r0]
L_924efa:
	or r5,r5,r6
L_924efe:
	stb r5,[r0]
L_924f02:
	ldb r4,[r2]
L_924f06:
	or r4,r4,r6
L_924f0a:
	stb r4,[r2]
L_924f0e:
	ldb r3,[r10, 0xa]
L_924f12:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_924f14:
	stb r3,[r10, 0xa]
	.global L_924f18
L_924f18:
	bic r1,r1,r6
L_924f1c:
	extb.f r1,r1
L_924f20:
	jeq [blink]
L_924f24:
	b_s L_924ed4
L_924f26:
	nop_s
