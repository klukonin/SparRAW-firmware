/* u_schd__now @ 0x8e9524, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__halt, TEMPERATURE_SERVICE__timer_exp_handler, calib_engine__on_ready_for_correction, calib_engine__on_start, calib_silent_rssi_sparrow__correction_alg, calib_silent_rssi_sparrow__find_rf_gain, calib_silent_rssi_sparrow__run_calibration_fragment, conn__snapshot_step, detector__arm_timer, detector__init_common
 * Зовёт сам: u_schd__now_hw_timer_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__now
u_schd__now:
	.global L_8e9524
L_8e9524:
	b.d L_8cc100
L_8e9528:
	add_s r0,gp,0x74
L_8e952a:
	nop_s
