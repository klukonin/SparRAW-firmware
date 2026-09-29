/* uc_isr_vec16 @ 0x921360, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_isr_vec16,"ax",@progbits
	.global uc_isr_vec16
uc_isr_vec16:
L_921360:
	j_s [blink]
	.global sub_921362
sub_921362:
L_921362:
	nop_s
