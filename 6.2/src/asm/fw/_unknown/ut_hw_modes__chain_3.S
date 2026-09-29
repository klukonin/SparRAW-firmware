/* ut_hw_modes__chain_3 @ 0x8d7500, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, deep_sleep_exit, init_rf_hw, rf__restore_if_needed, silent_rssi__calibrate_single_rf_module
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_abif__dvs_if_splitter_enable, hwd_abif__dvs_lo_splitter_enable, hwd_abif__dvs_rf_activate, hwd_abif__dvs_rfca_cmd_enable, rfc__write_field_434_2ec33
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_modes__chain_3
ut_hw_modes__chain_3:
	.global L_8d7500
L_8d7500:
	push_s blink
L_8d7502:
	push_s r13
L_8d7504:
	bl.d L_8ce6b8
L_8d7508:
	mov_s r13,r0
L_8d750a:
	bl.d L_8ce794
L_8d750e:
	mov_s r0,r13
L_8d7510:
	bl.d L_8ce838
L_8d7514:
	mov_s r0,r13
L_8d7516:
	mov_s r0,r13
L_8d7518:
	bl.d L_8ce910
L_8d751c:
	mov_s r1,0x0
L_8d751e:
	cmp_s r13,0x0
L_8d7520:
	bl.ne L_8d414c
L_8d7524:
	b L_8c025c
