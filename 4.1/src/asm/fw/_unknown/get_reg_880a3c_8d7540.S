/* get_reg_880a3c_8d7540 @ 0x8d7540, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__system_state_evt_handler, WBE_DRIVER__pcie_boot_init, calib_mngr__engine_start, calib_mngr__init_schemes, host_if__hw_ready_for_wmi, lmac_if__lmac_ready_evt, temp_sense__sample_if_due, temp_sense__stop
 */
	.section .text.get_reg_880a3c_8d7540,"ax",@progbits
	.global get_reg_880a3c_8d7540
get_reg_880a3c_8d7540:
	.global L_8d7540
L_8d7540:
	mov_s r0,0x880a3c
L_8d7546:
	ld_s r0,[r0]
L_8d7548:
	cmp_s r0,0x1
L_8d754a:
	mov_s r0,0x1
L_8d754c:
	j_s.d [blink]
L_8d754e:
	sub_s.ne r0,r0,r0
