/* hw_modes__pll_bypass @ 0x8d4c8c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, ut_hw_modes_cmd_0x304
 * Зовёт сам: abif__set_88afa4_bit0_and_wait, abif__set_88afa4_bit1_and_wait, ut_hw_drivers_cmd_0x203
 */
	.section .text.hw_modes__pll_bypass,"ax",@progbits
	.global hw_modes__pll_bypass
hw_modes__pll_bypass:
	.global L_8d4c8c
L_8d4c8c:
	push_s blink
L_8d4c8e:
	bl.d L_8cbd30
L_8d4c92:
	mov_s r0,0x1
L_8d4c94:
	bl L_8cd54c
L_8d4c98:
	bl.d L_8cd088
L_8d4c9c:
	mov_s r0,0x0
L_8d4c9e:
	pop_s blink
L_8d4ca0:
	j_s [blink]
L_8d4ca2:
	nop_s
