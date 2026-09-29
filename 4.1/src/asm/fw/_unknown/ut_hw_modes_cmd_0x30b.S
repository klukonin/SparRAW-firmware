/* ut_hw_modes_cmd_0x30b @ 0x8d521c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: rgf_reg_88af00
 */
	.section .text.ut_hw_modes_cmd_0x30b,"ax",@progbits
	.global ut_hw_modes_cmd_0x30b
ut_hw_modes_cmd_0x30b:
	.global L_8d521c
L_8d521c:
	push_s blink
L_8d521e:
	brne r0,0x1,L_8d522a
L_8d5222:
	bl.d L_8cb7d4
L_8d5226:
	mov_s r0,0x1
L_8d5228:
	b_s L_8d5240
	.global L_8d522a
L_8d522a:
	bl.d L_8cb7d4
L_8d522e:
	mov_s r0,0x0
L_8d5230:
	nop_s
L_8d5232:
	nop_s
L_8d5234:
	nop_s
L_8d5236:
	nop_s
L_8d5238:
	nop_s
L_8d523a:
	nop_s
L_8d523c:
	nop_s
L_8d523e:
	nop_s
	.global L_8d5240
L_8d5240:
	pop_s blink
L_8d5242:
	j_s [blink]
