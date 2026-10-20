/* iter__init @ 0x8e1138, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__awake_peer_ntf, TX_API__flush_pending_peer_pm_connection, conn_mgr__find_in_ranking_list, conn_mgr__find_reusable_cid, conn_mgr__ranking_remove, frag_8ca038, fwq_tx__find_packet, fwq_tx__flush_list_packets_by_cid, fwq_tx__long_retry_failures, ie_list__first
 */
	.section .text.iter__init,"ax",@progbits
	.global iter__init
iter__init:
	.global L_8e1138
L_8e1138:
	ld_s r1,[r1,0x4]
L_8e113a:
	j_s.d [blink]
L_8e113c:
	st_s r1,[r0]
L_8e113e:
	nop_s
