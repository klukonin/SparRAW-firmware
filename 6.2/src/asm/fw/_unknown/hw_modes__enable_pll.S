/* hw_modes__enable_pll @ 0x8d772c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, hw__pll_mode_switch
 * Зовёт сам: abif__mask_pll_unlock_irq, abif__power_up_analog, hwd__wait_pll_lock, hwd_abif__adc_clk_ctrl
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_modes__enable_pll
hw_modes__enable_pll:
	.global L_8d772c
L_8d772c:
	push_s blink
L_8d772e:
	bl L_8d00f4
L_8d7732:
	bl.d L_8d041c
L_8d7736:
	mov_s r0,0x14
L_8d7738:
	bl.d L_8ce4ec
L_8d773c:
	mov_s r0,0x0
L_8d773e:
	bl.d L_8cec90
L_8d7742:
	mov_s r0,0x0
L_8d7744:
	pop_s blink
L_8d7746:
	j_s [blink]
