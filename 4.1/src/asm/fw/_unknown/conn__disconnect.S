/* conn__disconnect @ 0x8eb190, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn::disconnect reason=%d, cid=%d
 * Зовут его: ageing_detector__drop_connection, bad_beacons_detector__handle_bcons_info, disconnect_by_peer, link_lost_ntf__disconnect, mid__disconnect_cmd, mlme_notify, mlme_sm__disconnect_log, pbss__del_sta, pbss__disconnect_by_peer, stream_mgr__on_delba_rx
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event, conn__cancel_retry_timer, fw_log__emit2, lm_if__disable_link_loss_monitoring
 */
	.section .text.conn__disconnect,"ax",@progbits
	.global conn__disconnect
conn__disconnect:
	.global L_8eb190
L_8eb190:
	push_s blink
L_8eb192:
	bl L_8c02c0
L_8eb196:
	mov_s r13,r0
L_8eb198:
	mov_s r14,r1
L_8eb19a:
	mov_s r15,r2
L_8eb19c:
	mov_s r2,0x100e2a8
L_8eb1a2:
	ldb r4,[r0, 0x8]
L_8eb1a6:
	mov_s r0,0xd
L_8eb1a8:
	mov_s r1,0x2
L_8eb1aa:
	bl.d L_8edff8
L_8eb1ae:
	mov_s r3,r14
L_8eb1b0:
	bl.d L_8c7950
L_8eb1b4:
	add2 r0,r13,0x19
L_8eb1b8:
	add2 r0,r13,0x3f
L_8eb1bc:
	mov_s r1,0x8
L_8eb1be:
	mov_s r2,r14
L_8eb1c0:
	mov_s r3,r15
L_8eb1c2:
	bl.d L_8d6a1c
L_8eb1c6:
	mov r4,0x0
L_8eb1ca:
	bl.d L_8c5b30
L_8eb1ce:
	mov_s r0,r13
L_8eb1d0:
	b L_8c032c
