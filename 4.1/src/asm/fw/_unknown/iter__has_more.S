/* iter__has_more @ 0x8cb674, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__awake_peer_ntf, TX_API__flush_pending_peer_pm_connection, conn_mgr__find_in_ranking_list, conn_mgr__find_reusable_cid, conn_mgr__ranking_remove, frag_8ca038, fwq_tx__find_packet, fwq_tx__flush_list_packets_by_cid, fwq_tx__long_retry_failures, ie_list__first
 */
	.section .text.iter__has_more,"ax",@progbits
	.global iter__has_more
iter__has_more:
	.global L_8cb674
L_8cb674:
	ld_s r0,[r0]
L_8cb676:
	sub.f r0,r0,0x0
L_8cb67a:
	j_s.d [blink]
L_8cb67c:
	mov.ne r0,0x1
