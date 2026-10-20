/* hwd__setup_pair @ 0x8d33f8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_RFC_POWERDOWN_DEEP_ENTRY
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc_powerdown_deep_all_rfs_fw, hwm_analog_select_active_rf_module, silent_rssi__calibrate_single_rf_module
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, hwd_rfc_write_core_fw, rfc__write_core_reg6
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd__setup_pair
hwd__setup_pair:
	.global L_8d33f8
L_8d33f8:
	push_s blink
L_8d33fa:
	push_s r13
L_8d33fc:
	mov_s r13,r0
L_8d33fe:
	mov_s r0,0x0
L_8d3400:
	bl.d L_8d32a4
L_8d3404:
	mov_s r1,0x1
L_8d3406:
	mov_s r0,r13
L_8d3408:
	mov_s r1,0x8
L_8d340a:
	mov_s r2,0x0
L_8d340c:
	bl.d L_8d415c
L_8d3410:
	mov_s r3,0x0
L_8d3412:
	mov_s r1,0x101e304
L_8d3418:
	bl.d L_8dcba8
L_8d341c:
	mov_s r0,0x21
L_8d341e:
	b L_8c025c
L_8d3422:
	nop_s
