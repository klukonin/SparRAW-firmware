/* mac__enable_880bc0_b0 @ 0x8da8f4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: mac__set_880bc0_b0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__enable_880bc0_b0
mac__enable_880bc0_b0:
	.global L_8da8f4
L_8da8f4:
	b.d L_8e860c
L_8da8f8:
	mov_s r0,0x1
L_8da8fa:
	nop_s
