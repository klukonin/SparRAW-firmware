/* ut_hw_modes_cmd_0x30c @ 0x8d51d0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler
 * Зовёт сам: rgf_reg_880c00_8cd568, rgf_reg_880c00_8cd5b8
 */
	.section .text.ut_hw_modes_cmd_0x30c,"ax",@progbits
	.global ut_hw_modes_cmd_0x30c
ut_hw_modes_cmd_0x30c:
	.global L_8d51d0
L_8d51d0:
	push_s blink
L_8d51d2:
	brne r0,0x1,L_8d51dc
L_8d51d6:
	bl L_8cd568
L_8d51da:
	b_s L_8d51e0
	.global L_8d51dc
L_8d51dc:
	bl L_8cd5b8
	.global L_8d51e0
L_8d51e0:
	pop_s blink
L_8d51e2:
	j_s [blink]
