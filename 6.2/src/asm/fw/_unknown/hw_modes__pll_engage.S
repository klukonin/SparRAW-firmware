/* hw_modes__pll_engage @ 0x8d7714, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, ut_hw_modes_cmd_0x304_fw
 * Зовёт сам: hwd__wait_pll_lock, hwd_abif__rosc_ctrl, hwd_abif__xtal_ctrl
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_modes__pll_engage
hw_modes__pll_engage:
	.global L_8d7714
L_8d7714:
	push_s blink
L_8d7716:
	bl.d L_8cffc4
L_8d771a:
	mov_s r0,0x1
L_8d771c:
	bl.d L_8d041c
L_8d7720:
	mov_s r0,0x14
L_8d7722:
	bl.d L_8ceddc
L_8d7726:
	mov_s r0,0x0
L_8d7728:
	pop_s blink
L_8d772a:
	j_s [blink]
