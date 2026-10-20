/* iter__next @ 0x8db188, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__awake_peer_ntf, TX_API__flush_pending_peer_pm_connection, conn_mgr__find_in_ranking_list, conn_mgr__find_reusable_cid, conn_mgr__ranking_remove, frag_8ca038, fwq_tx__find_packet, fwq_tx__flush_list_packets_by_cid, fwq_tx__long_retry_failures, ie_list__first
 */
	.section .text.iter__next,"ax",@progbits
	.global iter__next
iter__next:
	.global L_8db188
L_8db188:
	mov_s r1,r0
L_8db18a:
	ld_s r0,[r0]
L_8db18c:
	breq_s r0,0,L_8db192
L_8db18e:
	ld_s r2,[r0]
L_8db190:
	st_s r2,[r1]
	.global L_8db192
L_8db192:
	j_s [blink]
