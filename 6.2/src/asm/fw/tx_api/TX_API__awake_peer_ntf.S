/* TX_API__awake_peer_ntf @ 0x8c406c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::awake_peer_ntf() - m_pending_peer_pm_list.remove_this(0x%x) - sending again
 *   awake_peer_ntf:add_packet() failure
 * Зовут его: ps_assoc_mgr__shallow_sleep_enter
 * Зовёт сам: FWQ_TX_AVAILABILITY__remove_packet, __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, fwq_tx__add_packet, iter__init, iter__next, list__has_items, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_API__awake_peer_ntf
TX_API__awake_peer_ntf:
	.global L_8c406c
L_8c406c:
	push_s blink
L_8c406e:
	bl L_8c01d8
L_8c4072:
	sub_s sp,sp,0x4
L_8c4074:
	mov_s r17,r0
L_8c4076:
	mov_s r15,sp
L_8c4078:
	mov r16,0x842148
L_8c4080:
	mov_s r0,r15
L_8c4082:
	bl.d L_8e5df4
L_8c4086:
	mov_s r1,r16
L_8c4088:
	b_s L_8c409c
	.global L_8c408a
L_8c408a:
	bl.d L_8df438
L_8c408e:
	mov_s r0,r15
L_8c4090:
	ldb_s r13,[r0,0xa]
L_8c4092:
	brge.d r13,0x8,L_8c40aa
L_8c4096:
	mov_s r14,r0
	.global L_8c4098
L_8c4098:
	bbit1 r17,r13,L_8c40b8
	.global L_8c409c
L_8c409c:
	bl.d L_8cdcb8
L_8c40a0:
	mov_s r0,r15
L_8c40a2:
	brne_s r0,0,L_8c408a
L_8c40a4:
	b.d L_8c023c
L_8c40a8:
	add_s sp,sp,0x4
	.global L_8c40aa
L_8c40aa:
	mov_s r0,blink
L_8c40ac:
	mov_s r1,0x134b
L_8c40b2:
	bl L_8c9b28
L_8c40b6:
	b_s L_8c4098
	.global L_8c40b8
L_8c40b8:
	mov_s r1,0x10185c4
L_8c40be:
	mov_s r0,0x27
L_8c40c0:
	bl.d L_8dcc10
L_8c40c4:
	mov_s r2,r14
L_8c40c6:
	mov_s r0,r16
L_8c40c8:
	bl.d L_8e2884
L_8c40cc:
	mov_s r1,r14
L_8c40ce:
	ldb_s r1,[r14,0xb]
L_8c40d0:
	mov_s r0,r13
L_8c40d2:
	bl.d L_8e26a4
L_8c40d6:
	bmsk_s r1,r1,0x5
L_8c40d8:
	ldb_s r2,[r14,0xb]
L_8c40da:
	add r0,r16,0xc
L_8c40de:
	lsr_s r2,r2,0x6
L_8c40e0:
	bl.d L_8c2af4
L_8c40e4:
	mov_s r1,r14
L_8c40e6:
	brne_s r0,0,L_8c409c
L_8c40e8:
	mov_s r1,0x1018618
L_8c40ee:
	bl.d L_8dcba8
L_8c40f2:
	mov_s r0,0x17
L_8c40f4:
	b_s L_8c409c
L_8c40f6:
	nop_s
