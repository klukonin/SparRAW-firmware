/* hwm__reset_analog_block @ 0x8d4ca4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, WBE_DRIVER__pcie_boot_init, ut_hw_modes_cmd_0x303
 * Зовёт сам: abif__power_up_analog, hwd_abif__set_889800_8cd1f4, set_reg_88af00, ut_hw_drivers_cmd_0x201
 */
	.section .text.hwm__reset_analog_block,"ax",@progbits
	.global hwm__reset_analog_block
hwm__reset_analog_block:
	.global L_8d4ca4
L_8d4ca4:
	push_s blink
L_8d4ca6:
	bl.d L_8cbbc0
L_8d4caa:
	mov_s r0,0x1
L_8d4cac:
	bl.d L_8cb7c0
L_8d4cb0:
	mov_s r0,0x1
L_8d4cb2:
	bl L_8cd1f4
L_8d4cb6:
	bl L_8cd560
L_8d4cba:
	pop_s blink
L_8d4cbc:
	j_s [blink]
L_8d4cbe:
	nop_s
