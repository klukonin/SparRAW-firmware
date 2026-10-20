/* iter__init @ 0x8e5df4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__awake_peer_ntf, TX_API__flush_pending_peer_pm_connection, conn_mgr__find_in_ranking_list_fw, conn_mgr__find_reusable_cid, conn_mgr__first_active, conn_mgr__ranking_remove, find_main_sm__bcon_step, ftm__session_step, fwq_tx__find_packet, fwq_tx__flush_list_packets_by_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global iter__init
iter__init:
	.global L_8e5df4
L_8e5df4:
	ld_s r1,[r1,0x4]
L_8e5df6:
	j_s.d [blink]
L_8e5df8:
	st_s r1,[r0]
L_8e5dfa:
	nop_s
