/* hw_modes__enable_pll @ 0x8d4c70, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, ut_hw_modes_cmd_0x303
 * Зовёт сам: abif__power_up_analog, hwd__wait_pll_lock, set_reg_889480_8cd1d4, set_reg_88af00
 */
	.section .text.hw_modes__enable_pll,"ax",@progbits
	.global hw_modes__enable_pll
hw_modes__enable_pll:
	.global L_8d4c70
L_8d4c70:
	push_s blink
L_8d4c72:
	bl L_8cd1d4
L_8d4c76:
	bl.d L_8cd590
L_8d4c7a:
	mov_s r0,0x14
L_8d4c7c:
	bl.d L_8cb7c0
L_8d4c80:
	mov_s r0,0x0
L_8d4c82:
	bl.d L_8cbbc0
L_8d4c86:
	mov_s r0,0x0
L_8d4c88:
	pop_s blink
L_8d4c8a:
	j_s [blink]
