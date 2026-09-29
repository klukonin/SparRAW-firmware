/* fw_log_emit0 @ 0x8dcba8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__system_state_evt_handler, CALIB_MNGR__update_pcp_ap, CALIB_MNGR__update_sys_state, FWQ_TX_AVAILABILITY__init, LMAC_IF__rs_started, PS_CONNECTION__awake_peer_ntf, RADIO_MGR__unset_primary_channel, SW_TX_MGMT_API__link_up_evt, SW_TX_MGMT_API__send_packet, TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_log_emit0
fw_log_emit0:
	.global L_8dcba8
L_8dcba8:
	push_s blink
L_8dcbaa:
	bl.d L_8c01e4
L_8dcbae:
	bmsk r2,r0,0x3
L_8dcbb2:
	mov_s r13,r1
L_8dcbb4:
	lsr_s r0,r0,0x4
L_8dcbb6:
	mov_s r14,0x843900
L_8dcbbc:
	add_s r1,r14,0x4
L_8dcbbe:
	ldb_s r1,[r1,r2]
L_8dcbc0:
	bmsk_s r0,r0,0x1
L_8dcbc2:
	sub_s sp,sp,0x8
L_8dcbc4:
	bbit0 r1,r0,L_8dcc08
L_8dcbc8:
	mov_s r1,sp
L_8dcbca:
	mov_s r0,0x0
L_8dcbcc:
	bl.d L_8e9900
L_8dcbd0:
	mov_s r2,r0
L_8dcbd2:
	ld_s r1,[sp,0x4]
L_8dcbd4:
	mov_s r0,0xff
L_8dcbd6:
	cmp_s r1,r0
L_8dcbd8:
	mov.cc r2,r0
L_8dcbdc:
	ld_s r0,[r14]
L_8dcbde:
	mov.cs r2,r1
L_8dcbe2:
	add_s r1,r0,0x1
L_8dcbe4:
	bmsk_s r1,r1,0x9
L_8dcbe6:
	ld_s r3,[sp,0x0]
L_8dcbe8:
	add2 r1,r14,r1
L_8dcbec:
	st_s r3,[r1,0x14]
L_8dcbee:
	bmsk_s r13,r13,0x13
L_8dcbf0:
	bset_s r13,r13,0x1d
L_8dcbf2:
	bset_s r13,r13,0x1f
L_8dcbf4:
	extb_s r2,r2
L_8dcbf6:
	asl_s r2,r2,0x12
L_8dcbf8:
	or_s r13,r13,r2
L_8dcbfa:
	bmsk r1,r0,0x9
L_8dcbfe:
	add2 r1,r14,r1
L_8dcc02:
	st_s r13,[r1,0x14]
L_8dcc04:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8dcc06:
	st_s r0,[r14]
	.global L_8dcc08
L_8dcc08:
	b.d L_8c0254
L_8dcc0c:
	add_s sp,sp,0x8
L_8dcc0e:
	nop_s
