/* ut_hw_modes_cmd_0x30b @ 0x8d7cc4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: abif__set_ctrl48_bit18
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_modes_cmd_0x30b
ut_hw_modes_cmd_0x30b:
	.global L_8d7cc4
L_8d7cc4:
	push_s blink
L_8d7cc6:
	brne r0,0x1,L_8d7cd2
L_8d7cca:
	bl.d L_8ce500
L_8d7cce:
	mov_s r0,0x1
L_8d7cd0:
	b_s L_8d7ce8
	.global L_8d7cd2
L_8d7cd2:
	bl.d L_8ce500
L_8d7cd6:
	mov_s r0,0x0
L_8d7cd8:
	nop_s
L_8d7cda:
	nop_s
L_8d7cdc:
	nop_s
L_8d7cde:
	nop_s
L_8d7ce0:
	nop_s
L_8d7ce2:
	nop_s
L_8d7ce4:
	nop_s
L_8d7ce6:
	nop_s
	.global L_8d7ce8
L_8d7ce8:
	pop_s blink
L_8d7cea:
	j_s [blink]
