/* set_reg_88af00 @ 0x8cb7c0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__enable_pll, hwm__reset_analog_block
 */
	.section .text.set_reg_88af00,"ax",@progbits
	.global set_reg_88af00
set_reg_88af00:
	.global L_8cb7c0
L_8cb7c0:
	mov_s r1,0x88af00
L_8cb7c6:
	cmp_s r0,0x1
L_8cb7c8:
	mov_s r0,0x0
L_8cb7ca:
	mov.ne r0,0x1
L_8cb7ce:
	st_s r0,[r1,0x8]
L_8cb7d0:
	j_s [blink]
L_8cb7d2:
	nop_s
