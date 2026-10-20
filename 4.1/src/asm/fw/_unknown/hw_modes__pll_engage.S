/* hw_modes__pll_engage @ 0x8d4c58, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, ut_hw_modes_cmd_0x304
 * Зовёт сам: abif__set_88afa4_bit0_and_wait, abif__set_88afa4_bit1_and_wait, hwd__wait_pll_lock
 */
	.section .text.hw_modes__pll_engage,"ax",@progbits
	.global hw_modes__pll_engage
hw_modes__pll_engage:
	.global L_8d4c58
L_8d4c58:
	push_s blink
L_8d4c5a:
	bl.d L_8cd088
L_8d4c5e:
	mov_s r0,0x1
L_8d4c60:
	bl.d L_8cd590
L_8d4c64:
	mov_s r0,0x14
L_8d4c66:
	bl.d L_8cbd30
L_8d4c6a:
	mov_s r0,0x0
L_8d4c6c:
	pop_s blink
L_8d4c6e:
	j_s [blink]
