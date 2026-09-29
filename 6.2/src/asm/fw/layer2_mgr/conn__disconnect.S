/* conn__disconnect @ 0x8f2540, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn::disconnect reason=%d, cid=%d
 * Зовут его: ageing_detector__drop_connection, bad_beacons_detector__handle_bcons_info, disconnect_by_peer, lm_sm__action_8dab0c, mid__disconnect_cmd, mlme_notify, mlme_sm_8027a0__action_8f6b94, pbss__del_sta, pbss__disconnect_by_peer, stream_mgr__delba_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, conn__check_field_50, fw_log_emit2, lm_if__disable_link_loss_monitoring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__disconnect
conn__disconnect:
	.global L_8f2540
L_8f2540:
	push_s blink
L_8f2542:
	bl L_8c01e0
L_8f2546:
	mov_s r13,r0
L_8f2548:
	mov_s r14,r1
L_8f254a:
	mov_s r15,r2
L_8f254c:
	mov_s r1,0x101030c
L_8f2552:
	mov_s r0,0x2d
L_8f2554:
	mov_s r2,r14
L_8f2556:
	bl.d L_8dcc80
L_8f255a:
	ldb_s r3,[r13,0x8]
L_8f255c:
	bl.d L_8c8f90
L_8f2560:
	add3 r0,r13,0xe
L_8f2564:
	mov_s r0,r13
L_8f2566:
	add r0,r0,0x124
L_8f256a:
	mov_s r1,0x8
L_8f256c:
	mov_s r2,r14
L_8f256e:
	mov_s r3,r15
L_8f2570:
	bl.d L_8d9b6c
L_8f2574:
	mov r4,0x0
L_8f2578:
	bl.d L_8c68d4
L_8f257c:
	mov_s r0,r13
L_8f257e:
	b L_8c024c
L_8f2582:
	nop_s
