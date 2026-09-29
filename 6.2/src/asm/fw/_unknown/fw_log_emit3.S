/* fw_log_emit3 @ 0x8dcd00, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: FWQ_TX_AVAILABILITY__remove_packet, IF_GAIN__GAIN, PS_CONNECTION__awake_peer_ntf, PS_CONNECTION__psc_complete_8e1794, STREAM_MGR__ADD, SW_TX_MGMT_API__send_packet, TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters, TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters, TX_API__send_packet, TX_INTERNAL_API__connection
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_log_emit3
fw_log_emit3:
	.global L_8dcd00
L_8dcd00:
	push_s blink
L_8dcd02:
	bl L_8c01dc
L_8dcd06:
	sub_s sp,sp,0x8
L_8dcd08:
	bmsk r14,r0,0x3
L_8dcd0c:
	lsr_s r0,r0,0x4
L_8dcd0e:
	mov_s r13,0x843900
L_8dcd14:
	add_s r15,r13,0x4
L_8dcd16:
	ldb_s r14,[r15,r14]
L_8dcd18:
	bmsk_s r0,r0,0x1
L_8dcd1a:
	mov_s r16,r1
L_8dcd1c:
	mov_s r1,r4
L_8dcd1e:
	bbit0 r14,r0,L_8dcd88
L_8dcd22:
	ld_s r0,[r13]
L_8dcd24:
	add_s r14,r0,0x4
L_8dcd26:
	bmsk_s r14,r14,0x9
L_8dcd28:
	add2 r14,r13,r14
L_8dcd2c:
	st_s r1,[r14,0x14]
L_8dcd2e:
	add_s r1,r0,0x3
L_8dcd30:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8dcd32:
	bmsk_s r1,r1,0x9
L_8dcd34:
	bmsk_s r0,r0,0x9
L_8dcd36:
	add2 r1,r13,r1
L_8dcd3a:
	st_s r3,[r1,0x14]
L_8dcd3c:
	add2 r0,r13,r0
L_8dcd40:
	st_s r2,[r0,0x14]
L_8dcd42:
	mov_s r1,sp
L_8dcd44:
	mov_s r0,0x0
L_8dcd46:
	bl.d L_8e9900
L_8dcd4a:
	mov_s r2,r0
L_8dcd4c:
	ld_s r1,[sp,0x4]
L_8dcd4e:
	mov_s r0,0xff
L_8dcd50:
	cmp_s r1,r0
L_8dcd52:
	mov.cc r2,r0
L_8dcd56:
	ld_s r0,[r13]
L_8dcd58:
	mov.cs r2,r1
L_8dcd5c:
	add_s r1,r0,0x1
L_8dcd5e:
	bmsk_s r1,r1,0x9
L_8dcd60:
	ld_s r3,[sp,0x0]
L_8dcd62:
	add2 r1,r13,r1
L_8dcd66:
	st_s r3,[r1,0x14]
L_8dcd68:
	bmsk r1,r16,0x13
L_8dcd6c:
	or r1,r1,0xac000000
L_8dcd74:
	extb_s r2,r2
L_8dcd76:
	asl_s r2,r2,0x12
L_8dcd78:
	or_s r1,r1,r2
L_8dcd7a:
	bmsk r2,r0,0x9
L_8dcd7e:
	add2 r2,r13,r2
L_8dcd82:
	st_s r1,[r2,0x14]
L_8dcd84:
	/* add_s r0,0x5 */
	.byte 0x05,0xe0
L_8dcd86:
	st_s r0,[r13]
	.global L_8dcd88
L_8dcd88:
	b.d L_8c0244
L_8dcd8c:
	add_s sp,sp,0x8
L_8dcd8e:
	nop_s
