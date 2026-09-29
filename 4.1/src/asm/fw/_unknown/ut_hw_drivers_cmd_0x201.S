/* ut_hw_drivers_cmd_0x201 @ 0x8cd560, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm__reset_analog_block
 * Зовёт сам: car__enable_pll3_and_wait
 */
	.section .text.ut_hw_drivers_cmd_0x201,"ax",@progbits
	.global ut_hw_drivers_cmd_0x201
ut_hw_drivers_cmd_0x201:
	.global L_8cd560
L_8cd560:
	b.d L_8cd478
L_8cd564:
	mov_s r0,0x1
L_8cd566:
	nop_s
