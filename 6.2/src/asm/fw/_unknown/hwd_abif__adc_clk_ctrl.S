/* hwd_abif__adc_clk_ctrl @ 0x8ce4ec, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__enable_pll, hwm__reset_analog_block
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__adc_clk_ctrl
hwd_abif__adc_clk_ctrl:
	.global L_8ce4ec
L_8ce4ec:
	mov_s r1,0x88af00
L_8ce4f2:
	cmp_s r0,0x1
L_8ce4f4:
	mov_s r0,0x0
L_8ce4f6:
	mov.ne r0,0x1
L_8ce4fa:
	st_s r0,[r1,0x8]
L_8ce4fc:
	j_s [blink]
L_8ce4fe:
	nop_s
