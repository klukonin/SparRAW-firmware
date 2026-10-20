/* TX_API__flush_pending_peer_pm_connection @ 0x8c9058, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::flush_pending_peer_pm_connection for cid=%d
 *   TX_API::flush_pending_peer_pm_connection - marking 0x%x to remove
 *   TX_API::flush_pending_peer_pm_connection iter tx_metadata_p->m_cid=%d
 * Зовут его: TX_CTRL_API__flush_connection
 * Зовёт сам: TX_API__callback_and_release, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, iter__has_more, iter__init, iter__next
 */
	.section .text.TX_API__flush_pending_peer_pm_connection,"ax",@progbits
	.global TX_API__flush_pending_peer_pm_connection
TX_API__flush_pending_peer_pm_connection:
	.global L_8c9058
L_8c9058:
	push_s blink
L_8c905a:
	bl.d L_8c02bc
L_8c905e:
	mov_s r1,0x2
L_8c9060:
	sub_s sp,sp,0x4
L_8c9062:
	mov_s r16,r0
L_8c9064:
	mov_s r2,0x1014e00
L_8c906a:
	mov_s r0,0x7
L_8c906c:
	bl.d L_8edfcc
L_8c9070:
	mov_s r3,r16
L_8c9072:
	mov_s r15,sp
L_8c9074:
	mov_s r1,0x842404
L_8c907a:
	bl.d L_8e1138
L_8c907e:
	mov_s r0,r15
L_8c9080:
	mov_s r14,0x0
L_8c9082:
	b_s L_8c9094
	.global L_8c9084
L_8c9084:
	mov_s r2,0x1014e34
L_8c908a:
	mov_s r0,0x7
L_8c908c:
	mov_s r1,0x2
L_8c908e:
	bl.d L_8edfcc
L_8c9092:
	mov_s r3,r14
	.global L_8c9094
L_8c9094:
	mov_s r13,r14
L_8c9096:
	b_s L_8c90c0
	.global L_8c9098
L_8c9098:
	bl.d L_8db188
L_8c909c:
	mov_s r0,r15
L_8c909e:
	mov_s r14,r0
L_8c90a0:
	mov_s r2,0x1014e78
L_8c90a6:
	mov_s r0,0x7
L_8c90a8:
	mov_s r1,0x2
L_8c90aa:
	bl.d L_8edfcc
L_8c90ae:
	ldb_s r3,[r14,0xa]
L_8c90b0:
	breq_s r13,0,L_8c90ba
L_8c90b2:
	bl.d L_8c4ca8
L_8c90b6:
	mov_s r0,r13
L_8c90b8:
	mov_s r13,0x0
	.global L_8c90ba
L_8c90ba:
	ldb_s r0,[r14,0xa]
L_8c90bc:
	breq r0,r16,L_8c9084
	.global L_8c90c0
L_8c90c0:
	bl.d L_8cb674
L_8c90c4:
	mov_s r0,r15
L_8c90c6:
	brne_s r0,0,L_8c9098
L_8c90c8:
	cmp_s r13,0x0
L_8c90ca:
	bl.ne.d L_8c4ca8
L_8c90ce:
	mov.ne r0,r13
L_8c90d2:
	b.d L_8c0324
L_8c90d6:
	add_s sp,sp,0x4
