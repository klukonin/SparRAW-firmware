/* conn_mgr__find_reusable_cid @ 0x8c656c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   No CID index to reuse found.
 *   Found linked CID %d to reuse, state %x.
 * Зовут его: conn_mgr__alloc_cid
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn_mgr__link_down_evt, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, iter__init, iter__next, list__has_items, stream_mgr__check_vring, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__find_reusable_cid
conn_mgr__find_reusable_cid:
	.global L_8c656c
L_8c656c:
	push_s blink
L_8c656e:
	bl L_8c01dc
L_8c6572:
	sub_s sp,sp,0x4
L_8c6574:
	mov_s r15,sp
L_8c6576:
	mov r16,0x854000
L_8c657e:
	mov_s r0,r15
L_8c6580:
	bl.d L_8e5df4
L_8c6584:
	mov_s r1,r16
L_8c6586:
	b_s L_8c65a2
	.global L_8c6588
L_8c6588:
	bl.d L_8df438
L_8c658c:
	mov_s r0,r15
L_8c658e:
	ld_s r13,[r0,0x8]
L_8c6590:
	mov_s r14,r0
L_8c6592:
	breq_s r13,0,L_8c65ba
	.global L_8c6594
L_8c6594:
	ld_s r0,[r14,0x8]
L_8c6596:
	ldb r3,[r0,0x124]
L_8c659e:
	brlo r3,0x4,L_8c65c6
	.global L_8c65a2
L_8c65a2:
	bl.d L_8cdcb8
L_8c65a6:
	mov_s r0,r15
L_8c65a8:
	brne_s r0,0,L_8c6588
L_8c65aa:
	mov_s r1,0x100bd48
L_8c65b0:
	bl.d L_8dcba8
L_8c65b4:
	mov_s r0,0x1b
L_8c65b6:
	mov_s r0,0x0
L_8c65b8:
	b_s L_8c65f6
	.global L_8c65ba
L_8c65ba:
	mov_s r0,blink
L_8c65bc:
	mov_s r1,0xd2
L_8c65be:
	bl.d L_8c9b28
L_8c65c2:
	bset_s r1,r1,0xc
L_8c65c4:
	b_s L_8c6594
	.global L_8c65c6
L_8c65c6:
	ld_s r0,[r13,0x48]
L_8c65c8:
	brne_s r0,0,L_8c65a2
L_8c65ca:
	mov_s r1,0x100bd68
L_8c65d0:
	mov_s r0,0x2b
L_8c65d2:
	bl.d L_8dcc80
L_8c65d6:
	ldb_s r2,[r13,0x8]
L_8c65d8:
	mov_s r0,r16
L_8c65da:
	bl.d L_8e2884
L_8c65de:
	mov_s r1,r14
L_8c65e0:
	mov_s r0,0x0
L_8c65e2:
	st_s r0,[r14,0x8]
L_8c65e4:
	add2 r0,r16,0x1b
L_8c65e8:
	bl.d L_8caed0
L_8c65ec:
	mov_s r1,r14
L_8c65ee:
	bl.d L_8daae8
L_8c65f2:
	mov_s r0,r13
L_8c65f4:
	mov_s r0,0x1
	.global L_8c65f6
L_8c65f6:
	b.d L_8c0244
L_8c65fa:
	add_s sp,sp,0x4
