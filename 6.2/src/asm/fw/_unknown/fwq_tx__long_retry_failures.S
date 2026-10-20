/* fwq_tx__long_retry_failures @ 0x8c66ac, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx::long_retry_failures for packet 0x%x. Long retry is %d. Timer set in %d Msec
 * Зовут его: tx_api__call_vmethod_04
 * Зовёт сам: FWQ_TX_AVAILABILITY__remove_packet, __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3, iter__init, iter__next, link_lost_diag__dump_false_alarms, list__find_entry_d, list__has_items, tx_list__remove, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__long_retry_failures
fwq_tx__long_retry_failures:
	.global L_8c66ac
L_8c66ac:
	push_s blink
L_8c66ae:
	bl L_8c01d4
L_8c66b2:
	sub_s sp,sp,0x4
L_8c66b4:
	mov_s r17,r0
L_8c66b6:
	mov_s r18,r1
L_8c66b8:
	mov_s r13,0x0
L_8c66ba:
	mov_s r15,sp
L_8c66bc:
	bl.d L_8e5df4
L_8c66c0:
	mov_s r0,r15
L_8c66c2:
	mov_s r16,r13
L_8c66c4:
	b_s L_8c6780
	.global L_8c66c6
L_8c66c6:
	mov_s r13,r14
L_8c66c8:
	b_s L_8c6780
	.global L_8c66ca
L_8c66ca:
	bl.d L_8df438
L_8c66ce:
	mov_s r0,r15
L_8c66d0:
	mov_s r13,r0
L_8c66d2:
	breq_s r14,0,L_8c66f2
L_8c66d4:
	mov_s r0,r18
L_8c66d6:
	bl.d L_8e2884
L_8c66da:
	mov_s r1,r14
L_8c66dc:
	add3 r0,r17,0x8
L_8c66e0:
	bl.d L_8c25f4
L_8c66e4:
	mov_s r1,r14
L_8c66e6:
	ldb_s r1,[r14,0xb]
L_8c66e8:
	ldb_s r0,[r14,0xa]
L_8c66ea:
	bl.d L_8e26a4
L_8c66ee:
	bmsk_s r1,r1,0x5
L_8c66f0:
	mov_s r14,0x0
	.global L_8c66f2
L_8c66f2:
	ldb_s r0,[r13,0x11]
L_8c66f4:
	brne_s r0,0,L_8c6724
	.global L_8c66f6
L_8c66f6:
	bl.d L_8cdcb8
L_8c66fa:
	mov_s r0,r15
L_8c66fc:
	brne_s r0,0,L_8c66ca
L_8c66fe:
	breq_s r14,0,L_8c671c
L_8c6700:
	mov_s r0,r18
L_8c6702:
	bl.d L_8e2884
L_8c6706:
	mov_s r1,r14
L_8c6708:
	ldb_s r1,[r14,0xb]
L_8c670a:
	ldb_s r0,[r14,0xa]
L_8c670c:
	bl.d L_8e26a4
L_8c6710:
	bmsk_s r1,r1,0x5
L_8c6712:
	add3 r0,r17,0x8
L_8c6716:
	bl.d L_8c25f4
L_8c671a:
	mov_s r1,r14
	.global L_8c671c
L_8c671c:
	mov_s r0,r16
L_8c671e:
	b.d L_8c0234
L_8c6722:
	add_s sp,sp,0x4
	.global L_8c6724
L_8c6724:
	ldb_s r3,[r13,0x13]
L_8c6726:
	brlt r3,0x1,L_8c66f6
L_8c672a:
	ldb_s r1,[r13,0xa]
L_8c672c:
	ld r0,[r17, 0x14]
L_8c6730:
	bbit1 r0,r1,L_8c66c6
L_8c6734:
	mov_s r1,0x1018c3c
L_8c673a:
	ldb r4,[r13, 0x12]
L_8c673e:
	mov_s r0,0x27
L_8c6740:
	bl.d L_8dcd00
L_8c6744:
	mov_s r2,r13
L_8c6746:
	bl L_8c8678
L_8c674a:
	ldb_s r0,[r13,0x13]
L_8c674c:
	ldb_s r14,[r13,0x12]
L_8c674e:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8c6750:
	stb_s r0,[r13,0x13]
L_8c6752:
	mov_s r0,0x1cf14
L_8c6758:
	mov_s r1,r17
L_8c675a:
	mov_s r2,r13
L_8c675c:
	mov_s r3,0x1
L_8c675e:
	asl r4,r14,0xa
L_8c6762:
	mov r5,0x0
L_8c6766:
	bl.d L_8e0c0c
L_8c676a:
	mov r6,r5
L_8c676e:
	st_s r0,[r13,0x14]
L_8c6770:
	ldb_s r0,[r13,0x11]
L_8c6772:
	cmp r0,0xfd
L_8c6776:
	beq_s L_8c677c
L_8c6778:
	mov_s r0,0xfe
L_8c677a:
	stb_s r0,[r13,0x11]
	.global L_8c677c
L_8c677c:
	mov r16,0x1
	.global L_8c6780
L_8c6780:
	mov_s r14,r13
L_8c6782:
	b_s L_8c66f6
