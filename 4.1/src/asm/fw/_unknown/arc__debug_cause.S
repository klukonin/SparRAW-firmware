/* arc__debug_cause @ 0x8e96d0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: instruction_error__report
 */
	.section .text.arc__debug_cause,"ax",@progbits
	.global arc__debug_cause
arc__debug_cause:
	.global L_8e96d0
L_8e96d0:
	lr r0,[0x5]
L_8e96d4:
	lsr_s r0,r0,0x3
L_8e96d6:
	j_s.d [blink]
L_8e96d8:
	extb_s r0,r0
L_8e96da:
	nop_s
