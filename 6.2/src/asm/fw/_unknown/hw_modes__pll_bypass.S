/* hw_modes__pll_bypass @ 0x8d7748, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, ut_hw_modes_cmd_0x304_fw
 * Зовёт сам: hwd_abif__rosc_ctrl, hwd_abif__xtal_ctrl, ut_hw_drivers_cmd_0x203
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_modes__pll_bypass
hw_modes__pll_bypass:
	.global L_8d7748
L_8d7748:
	push_s blink
L_8d774a:
	bl.d L_8ceddc
L_8d774e:
	mov_s r0,0x1
L_8d7750:
	bl L_8d03d8
L_8d7754:
	bl.d L_8cffc4
L_8d7758:
	mov_s r0,0x0
L_8d775a:
	pop_s blink
L_8d775c:
	j_s [blink]
L_8d775e:
	nop_s
