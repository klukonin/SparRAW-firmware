/* fwq_tx__long_retry_failures @ 0x8c5938, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx::long_retry_failures for packet 0x%x. Long retry is %d. Timer set in %d Msec
 * Зовут его: fwq_tx__handle_completion
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit3, iter__has_more, iter__init, iter__next, link_lost_diag__dump_false_alarms, llist__insert, llist__remove, u_schd__schedule
 */
	.section .text.fwq_tx__long_retry_failures,"ax",@progbits
	.global fwq_tx__long_retry_failures
fwq_tx__long_retry_failures:
	.global L_8c5938
L_8c5938:
	push_s blink
L_8c593a:
	bl L_8c02b4
L_8c593e:
	sub_s sp,sp,0x4
L_8c5940:
	mov_s r17,r0
L_8c5942:
	mov_s r18,r1
L_8c5944:
	mov_s r13,0x0
L_8c5946:
	mov_s r15,sp
L_8c5948:
	bl.d L_8e1138
L_8c594c:
	mov_s r0,r15
L_8c594e:
	mov_s r16,r13
L_8c5950:
	b_s L_8c59fc
	.global L_8c5952
L_8c5952:
	mov_s r13,r14
L_8c5954:
	b_s L_8c59fc
	.global L_8c5956
L_8c5956:
	bl.d L_8db188
L_8c595a:
	mov_s r0,r15
L_8c595c:
	mov_s r13,r0
L_8c595e:
	breq_s r14,0,L_8c5974
L_8c5960:
	mov_s r0,r18
L_8c5962:
	bl.d L_8de4ec
L_8c5966:
	mov_s r1,r14
L_8c5968:
	add3 r0,r17,0x8
L_8c596c:
	bl.d L_8c1fc4
L_8c5970:
	mov_s r1,r14
L_8c5972:
	mov_s r14,0x0
	.global L_8c5974
L_8c5974:
	ldb_s r0,[r13,0x11]
L_8c5976:
	brne_s r0,0,L_8c599c
	.global L_8c5978
L_8c5978:
	bl.d L_8cb674
L_8c597c:
	mov_s r0,r15
L_8c597e:
	brne_s r0,0,L_8c5956
L_8c5980:
	breq_s r14,0,L_8c5994
L_8c5982:
	mov_s r0,r18
L_8c5984:
	bl.d L_8de4ec
L_8c5988:
	mov_s r1,r14
L_8c598a:
	add3 r0,r17,0x8
L_8c598e:
	bl.d L_8c1fc4
L_8c5992:
	mov_s r1,r14
	.global L_8c5994
L_8c5994:
	mov_s r0,r16
L_8c5996:
	b.d L_8c0314
L_8c599a:
	add_s sp,sp,0x4
	.global L_8c599c
L_8c599c:
	ldb r4,[r13, 0x13]
L_8c59a0:
	brlt r4,0x1,L_8c5978
L_8c59a4:
	ldb_s r1,[r13,0xa]
L_8c59a6:
	ld r0,[r17, 0x14]
L_8c59aa:
	bbit1 r0,r1,L_8c5952
L_8c59ae:
	mov_s r2,0x1015808
L_8c59b4:
	ldb r5,[r13, 0x12]
L_8c59b8:
	mov_s r0,0x7
L_8c59ba:
	mov_s r1,0x2
L_8c59bc:
	bl.d L_8ee034
L_8c59c0:
	mov_s r3,r13
L_8c59c2:
	bl L_8eae60
L_8c59c6:
	ldb_s r0,[r13,0x13]
L_8c59c8:
	ldb_s r14,[r13,0x12]
L_8c59ca:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8c59cc:
	stb_s r0,[r13,0x13]
L_8c59ce:
	mov_s r0,0x19408
L_8c59d4:
	mov_s r1,r17
L_8c59d6:
	mov_s r2,r13
L_8c59d8:
	mov_s r3,0x1
L_8c59da:
	asl r4,r14,0xa
L_8c59de:
	mov r5,0x0
L_8c59e2:
	bl.d L_8dc92c
L_8c59e6:
	mov r6,r5
L_8c59ea:
	st_s r0,[r13,0x14]
L_8c59ec:
	ldb_s r0,[r13,0x11]
L_8c59ee:
	cmp r0,0xfd
L_8c59f2:
	beq_s L_8c59f8
L_8c59f4:
	mov_s r0,0xfe
L_8c59f6:
	stb_s r0,[r13,0x11]
	.global L_8c59f8
L_8c59f8:
	mov r16,0x1
	.global L_8c59fc
L_8c59fc:
	mov_s r14,r13
L_8c59fe:
	b_s L_8c5978
