/* conn_mgr__by_cid @ 0x8c9e44, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr.cpp
 * Зовут его: LMAC_IF__rs_started, STREAM_MGR__ADD, STREAM_MGR__ready_for_modify, TX_API__callback_and_release, TX_API__handle_completed_packets, ageing_detector__drop_connection, bad_beacons_detector__handle_bcons_info, conn_mgr__awake_peer_ntf, conn_mgr__foreach_active_link, conn_mgr__foreach_link_arm_timer
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.conn_mgr__by_cid,"ax",@progbits
	.global conn_mgr__by_cid
conn_mgr__by_cid:
	.global L_8c9e44
L_8c9e44:
	push_s blink
L_8c9e46:
	push_s r13
L_8c9e48:
	brhs.d r0,0x8,L_8c9e5c
L_8c9e4c:
	mov_s r13,r0
	.global L_8c9e4e
L_8c9e4e:
	mov_s r0,0x80469c
L_8c9e54:
	add3_s r0,r0,r13
L_8c9e56:
	b.d L_8c033c
L_8c9e5a:
	ld_s r0,[r0,0x4]
	.global L_8c9e5c
L_8c9e5c:
	mov_s r0,blink
L_8c9e5e:
	mov_s r2,0x100a878
L_8c9e64:
	mov_s r1,0x11c9
L_8c9e6a:
	bl.d L_8c82c0
L_8c9e6e:
	mov_s r3,0x2c
L_8c9e70:
	b_s L_8c9e4e
L_8c9e72:
	nop_s
