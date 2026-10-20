/* arc__debug_cause @ 0x8c3b50, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: instruction_error__report
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global arc__debug_cause
arc__debug_cause:
	.global L_8c3b50
L_8c3b50:
	lr r0,[0x5]
L_8c3b54:
	lsr_s r0,r0,0x3
L_8c3b56:
	j_s.d [blink]
L_8c3b58:
	extb_s r0,r0
L_8c3b5a:
	nop_s
