/* bits__lowest_set_bit8 @ 0x8d6fec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bits__lowest_set_bit8
bits__lowest_set_bit8:
	.global L_8d6fec
L_8d6fec:
	sub_s r1,r0,0x1
L_8d6fee:
	bic_s r0,r0,r1
L_8d6ff0:
	j_s.d [blink]
L_8d6ff2:
	extb_s r0,r0
