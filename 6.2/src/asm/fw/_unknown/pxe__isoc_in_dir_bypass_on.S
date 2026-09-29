/* pxe__isoc_in_dir_bypass_on @ 0x8f7d10, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_15
 * Зовёт сам: WBE_DRIVER__pxe_isoc_in_dir_bypass
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pxe__isoc_in_dir_bypass_on
pxe__isoc_in_dir_bypass_on:
	.global L_8f7d10
L_8f7d10:
	b.d L_8f7eb0
L_8f7d14:
	mov_s r0,0x1
L_8f7d16:
	nop_s
