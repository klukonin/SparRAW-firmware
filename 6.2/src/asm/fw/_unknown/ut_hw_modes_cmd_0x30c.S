/* ut_hw_modes_cmd_0x30c @ 0x8d7c70, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler
 * Зовёт сам: pcie__clear_880c50_b2, pcie__set_880c50_b12
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_modes_cmd_0x30c
ut_hw_modes_cmd_0x30c:
	.global L_8d7c70
L_8d7c70:
	push_s blink
L_8d7c72:
	brne r0,0x1,L_8d7c7c
L_8d7c76:
	bl L_8d03f4
L_8d7c7a:
	b_s L_8d7c80
	.global L_8d7c7c
L_8d7c7c:
	bl L_8d0444
	.global L_8d7c80
L_8d7c80:
	pop_s blink
L_8d7c82:
	j_s [blink]
