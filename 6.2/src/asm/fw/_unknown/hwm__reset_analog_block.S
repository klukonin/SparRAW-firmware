/* hwm__reset_analog_block @ 0x8d7760, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, fw_main, hw__pll_mode_switch
 * Зовёт сам: abif__ack_unmask_pll_unlock_irq, abif__power_up_analog, car__enable_pll3_and_wait_on, hwd_abif__adc_clk_ctrl
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm__reset_analog_block
hwm__reset_analog_block:
	.global L_8d7760
L_8d7760:
	push_s blink
L_8d7762:
	bl.d L_8cec90
L_8d7766:
	mov_s r0,0x1
L_8d7768:
	bl.d L_8ce4ec
L_8d776c:
	mov_s r0,0x1
L_8d776e:
	bl L_8d0114
L_8d7772:
	bl L_8d03ec
L_8d7776:
	pop_s blink
L_8d7778:
	j_s [blink]
L_8d777a:
	nop_s
