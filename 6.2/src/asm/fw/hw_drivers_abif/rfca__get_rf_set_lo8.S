/* rfca__get_rf_set_lo8 @ 0x8ce82c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__get_module_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfca__get_rf_set_lo8
rfca__get_rf_set_lo8:
	.global L_8ce82c
L_8ce82c:
	mov_s r0,0x889480
L_8ce832:
	ld_s r0,[r0,0x8]
L_8ce834:
	j_s.d [blink]
L_8ce836:
	extb_s r0,r0
