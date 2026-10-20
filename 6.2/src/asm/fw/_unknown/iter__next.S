/* iter__next @ 0x8df438, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__awake_peer_ntf, TX_API__flush_pending_peer_pm_connection, conn_mgr__find_in_ranking_list_fw, conn_mgr__find_reusable_cid, conn_mgr__first_active, conn_mgr__ranking_remove, find_main_sm__bcon_step, ftm__session_step, fwq_tx__find_packet, fwq_tx__flush_list_packets_by_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global iter__next
iter__next:
	.global L_8df438
L_8df438:
	mov_s r1,r0
L_8df43a:
	ld_s r0,[r0]
L_8df43c:
	breq_s r0,0,L_8df442
L_8df43e:
	ld_s r2,[r0]
L_8df440:
	st_s r2,[r1]
	.global L_8df442
L_8df442:
	j_s [blink]
