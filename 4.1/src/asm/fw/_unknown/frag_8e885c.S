/* frag_8e885c @ 0x8e885c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: low_sme__termination_check
 */
	.section .text.frag_8e885c,"ax",@progbits
	.global frag_8e885c
frag_8e885c:
L_8e885c:
	add_s sp,sp,0x18
	.global sub_8e885e
sub_8e885e:
L_8e885e:
	nop_s
L_8e8860:
	b.d L_8e426c
L_8e8864:
	mov_s r0,0x1
	.byte 0x00
	.byte 0x00
