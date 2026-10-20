/* mid__lookup_for_tx @ 0x8c7548, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_send_packet_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, iter__init, iter__next, list__has_items, mid__copy_mac_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__lookup_for_tx
mid__lookup_for_tx:
	.global L_8c7548
L_8c7548:
	push_s blink
L_8c754a:
	bl L_8c01dc
L_8c754e:
	add r15,r0,0x18
L_8c7552:
	ld_s r0,[r15]
L_8c7554:
	mov_s r13,r1
L_8c7556:
	sub.f r0,r0,0x0
L_8c755a:
	mov.ne r0,0x1
L_8c755e:
	extb.f 0x0,r0
L_8c7562:
	sub_s sp,sp,0x4
L_8c7564:
	mov_s r16,r2
L_8c7566:
	beq_s L_8c7596
	.global L_8c7568
L_8c7568:
	mov_s r14,sp
L_8c756a:
	mov_s r0,r14
L_8c756c:
	bl.d L_8e5df4
L_8c7570:
	mov_s r1,r15
L_8c7572:
	b_s L_8c7580
	.global L_8c7574
L_8c7574:
	bl.d L_8df438
L_8c7578:
	mov_s r0,r14
L_8c757a:
	ldb_s r1,[r0,0x8]
L_8c757c:
	breq r13,r1,L_8c75a4
	.global L_8c7580
L_8c7580:
	bl.d L_8cdcb8
L_8c7584:
	mov_s r0,r14
L_8c7586:
	brne_s r0,0,L_8c7574
L_8c7588:
	mov_s r0,blink
L_8c758a:
	mov_s r1,0x11ee
L_8c7590:
	bl L_8c9b28
L_8c7594:
	b_s L_8c75aa
	.global L_8c7596
L_8c7596:
	mov_s r0,blink
L_8c7598:
	mov_s r1,0x11ed
L_8c759e:
	bl L_8c9b28
L_8c75a2:
	b_s L_8c7568
	.global L_8c75a4
L_8c75a4:
	bl.d L_8c75b0
L_8c75a8:
	mov_s r1,r16
	.global L_8c75aa
L_8c75aa:
	b.d L_8c0244
L_8c75ae:
	add_s sp,sp,0x4
