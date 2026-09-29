/* list__has_items @ 0x8cdcb8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__awake_peer_ntf, TX_API__flush_pending_peer_pm_connection, conn_mgr__find_in_ranking_list_fw, conn_mgr__find_reusable_cid, conn_mgr__first_active, conn_mgr__ranking_remove, find_main_sm__bcon_step, ftm__session_step, fwq_tx__find_packet, fwq_tx__flush_list_packets_by_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global list__has_items
list__has_items:
	.global L_8cdcb8
L_8cdcb8:
	ld_s r0,[r0]
L_8cdcba:
	sub.f r0,r0,0x0
L_8cdcbe:
	j_s.d [blink]
L_8cdcc0:
	mov.ne r0,0x1
