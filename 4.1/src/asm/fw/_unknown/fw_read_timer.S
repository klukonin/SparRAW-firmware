/* fw_read_timer @ 0x8e4694, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__halt, TEMPERATURE_SERVICE__radio_locked_cb, basic_if__mailbox_send, calib_engine__on_start, calib_engine__step, calib_silent_rssi__vt1c, detector__arm_timer, detector__init_common, discovery_handle_probe_req, discovery_handle_probe_resp
 * Зовёт сам: tail_get_reg_880254
 */
	.section .text.fw_read_timer,"ax",@progbits
	.global fw_read_timer
fw_read_timer:
	.global L_8e4694
L_8e4694:
	b.d L_8c9f5c
L_8e4698:
	add_s r0,gp,0x70
L_8e469a:
	nop_s
