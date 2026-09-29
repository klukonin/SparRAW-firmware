/* conn_mgr__by_cid @ 0x8cbffc, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: LMAC_IF__rs_started, STREAM_MGR__ADD, TX_API__callback_and_release, TX_API__handle_completed_packets, ageing_detector__drop_connection, bad_beacons_detector__handle_bcons_info, conn__check_bad_link, conn_mgr__bi_evt_all_conns, conn_mgr__rearm_all_detectors, conn_mgr__resume_all_vrings
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__by_cid
conn_mgr__by_cid:
	.global L_8cbffc
L_8cbffc:
	push_s blink
L_8cbffe:
	push_s r13
L_8cc000:
	brhs.d r0,0x8,L_8cc014
L_8cc004:
	mov_s r13,r0
	.global L_8cc006
L_8cc006:
	mov_s r0,0x854080
L_8cc00c:
	add3_s r0,r0,r13
L_8cc00e:
	b.d L_8c025c
L_8cc012:
	ld_s r0,[r0,0x4]
	.global L_8cc014
L_8cc014:
	mov_s r0,blink
L_8cc016:
	mov_s r1,0x11c9
L_8cc01c:
	bl L_8c9b28
L_8cc020:
	b_s L_8cc006
L_8cc022:
	nop_s
