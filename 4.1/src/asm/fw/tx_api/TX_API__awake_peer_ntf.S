/* TX_API__awake_peer_ntf @ 0x8c3658, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_api.cpp
 *   TX_API::awake_peer_ntf() - m_pending_peer_pm_list.remove_this(0x%x) - sending again
 * Зовут его: ps_assoc_mgr__set_awake_tsf
 * Зовёт сам: FWQ_TX_AVAILABILITY__remove_packet, __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, fw_sysassert_fatal, fwq_tx__enqueue, iter__has_more, iter__init, iter__next, llist__remove
 */
	.section .text.TX_API__awake_peer_ntf,"ax",@progbits
	.global TX_API__awake_peer_ntf
TX_API__awake_peer_ntf:
	.global L_8c3658
L_8c3658:
	push_s blink
L_8c365a:
	bl L_8c02b8
L_8c365e:
	sub_s sp,sp,0x4
L_8c3660:
	mov_s r17,r0
L_8c3662:
	mov_s r15,sp
L_8c3664:
	mov r16,0x842404
L_8c366c:
	mov_s r0,r15
L_8c366e:
	bl.d L_8e1138
L_8c3672:
	mov_s r1,r16
L_8c3674:
	b_s L_8c3688
	.global L_8c3676
L_8c3676:
	bl.d L_8db188
L_8c367a:
	mov_s r0,r15
L_8c367c:
	ldb_s r13,[r0,0xa]
L_8c367e:
	brge.d r13,0x8,L_8c3696
L_8c3682:
	mov_s r14,r0
	.global L_8c3684
L_8c3684:
	bbit1 r17,r13,L_8c36ae
	.global L_8c3688
L_8c3688:
	bl.d L_8cb674
L_8c368c:
	mov_s r0,r15
L_8c368e:
	brne_s r0,0,L_8c3676
L_8c3690:
	b.d L_8c031c
L_8c3694:
	add_s sp,sp,0x4
	.global L_8c3696
L_8c3696:
	mov_s r0,blink
L_8c3698:
	mov_s r2,0x1014cd4
L_8c369e:
	mov_s r1,0x134b
L_8c36a4:
	bl.d L_8c82c0
L_8c36a8:
	mov r3,0x296
L_8c36ac:
	b_s L_8c3684
	.global L_8c36ae
L_8c36ae:
	mov_s r2,0x10151d4
L_8c36b4:
	mov_s r0,0x7
L_8c36b6:
	mov_s r1,0x2
L_8c36b8:
	bl.d L_8edfcc
L_8c36bc:
	mov_s r3,r14
L_8c36be:
	mov_s r0,r16
L_8c36c0:
	bl.d L_8de4ec
L_8c36c4:
	mov_s r1,r14
L_8c36c6:
	ldb_s r1,[r14,0xb]
L_8c36c8:
	mov_s r0,r13
L_8c36ca:
	bl.d L_8de304
L_8c36ce:
	bmsk_s r1,r1,0x5
L_8c36d0:
	ldb_s r2,[r14,0xb]
L_8c36d2:
	add r0,r16,0xc
L_8c36d6:
	lsr_s r2,r2,0x6
L_8c36d8:
	bl.d L_8c2460
L_8c36dc:
	mov_s r1,r14
L_8c36de:
	b_s L_8c3688
