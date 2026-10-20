/* list__find_entry_d @ 0x8c25f4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ADD, TX_API__handle_completed_packets, conn_mgr__add_to_rinking_list, find_main_sm__bcon, ftm_mngr, fwq_tx__add_packet, fwq_tx__flush_list_packets_by_cid, fwq_tx__handle_completion, fwq_tx__long_retry_failures, fwq_tx__queue_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global list__find_entry_d
list__find_entry_d:
	.global L_8c25f4
L_8c25f4:
	push_s blink
L_8c25f6:
	bl L_8c01e4
L_8c25fa:
	mov.f r13,r1
L_8c25fe:
	mov_s r14,r0
L_8c2600:
	beq_s L_8c2610
	.global L_8c2602
L_8c2602:
	ld_s r0,[r13,0x4]
L_8c2604:
	brne_s r0,0,L_8c261a
	.global L_8c2606
L_8c2606:
	ld_s r0,[r14]
L_8c2608:
	breq_s r0,0,L_8c2624
L_8c260a:
	ld_s r0,[r14,0x8]
L_8c260c:
	st_s r13,[r0]
L_8c260e:
	b_s L_8c2626
	.global L_8c2610
L_8c2610:
	mov_s r0,blink
L_8c2612:
	bl.d L_8c9b28
L_8c2616:
	mov_s r1,0xd3
L_8c2618:
	b_s L_8c2602
	.global L_8c261a
L_8c261a:
	mov_s r0,blink
L_8c261c:
	bl.d L_8c9b28
L_8c2620:
	mov_s r1,0xd4
L_8c2622:
	b_s L_8c2606
	.global L_8c2624
L_8c2624:
	st_s r13,[r14,0x4]
	.global L_8c2626
L_8c2626:
	mov_s r0,0x0
L_8c2628:
	st_s r13,[r14,0x8]
L_8c262a:
	st_s r0,[r13]
L_8c262c:
	ld_s r0,[r14]
L_8c262e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c2630:
	st_s r0,[r14]
L_8c2632:
	b.d L_8c0254
L_8c2636:
	st_s r14,[r13,0x4]
