/* tail_low_sme__termination_check @ 0x8ee89c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: low_sme__termination_check
 */
	.section .text.tail_low_sme__termination_check,"ax",@progbits
	.global tail_low_sme__termination_check
tail_low_sme__termination_check:
L_8ee89c:
	j_s [blink]
	.global sub_8ee89e
sub_8ee89e:
L_8ee89e:
	nop_s
L_8ee8a0:
	b.d L_8e426c
L_8ee8a4:
	mov_s r0,0x0
L_8ee8a6:
	nop_s
