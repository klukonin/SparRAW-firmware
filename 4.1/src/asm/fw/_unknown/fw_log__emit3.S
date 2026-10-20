/* fw_log__emit3 @ 0x8ee034, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: FWQ_TX_AVAILABILITY__add_packet, FWQ_TX_AVAILABILITY__remove_packet, IF_GAIN__GAIN, POWER_MNGR__system_state_evt_handler, PS_CONNECTION__psc_complete, RADIO_MGR__lock_secondary, SW_TX_MGMT_API__send_packet, TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters, TEMPERATURE_SERVICE__radio_locked_cb, TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__commit
 */
	.section .text.fw_log__emit3,"ax",@progbits
	.global fw_log__emit3
fw_log__emit3:
	.global L_8ee034
L_8ee034:
	push_s blink
L_8ee036:
	bl.d L_8c02c0
L_8ee03a:
	mov_s r6,r2
L_8ee03c:
	mov_s r15,0x843900
L_8ee042:
	add_s r2,r15,0x4
L_8ee044:
	ldb_s r2,[r2,r0]
L_8ee046:
	mov_s r13,r4
L_8ee048:
	mov r4,r5
L_8ee04c:
	bbit0 r2,r1,L_8ee07c
L_8ee050:
	ld_s r14,[r15]
L_8ee052:
	add_s r2,r14,0x3
L_8ee054:
	bmsk_s r2,r2,0x9
L_8ee056:
	add2 r2,r15,r2
L_8ee05a:
	st r4,[r2, 0x14]
L_8ee05e:
	add_s r2,r14,0x2
L_8ee060:
	bmsk_s r2,r2,0x9
L_8ee062:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8ee064:
	add2 r2,r15,r2
L_8ee068:
	bmsk_s r14,r14,0x9
L_8ee06a:
	st_s r13,[r2,0x14]
L_8ee06c:
	add2_s r15,r15,r14
L_8ee06e:
	st_s r3,[r15,0x14]
L_8ee070:
	mov_s r2,r6
L_8ee072:
	mov_s r3,0x3
L_8ee074:
	bl.d L_8ee134
L_8ee078:
	mov r4,0x0
	.global L_8ee07c
L_8ee07c:
	b L_8c032c
