/* power_mngr__defaults_addr @ 0x8cc1f4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__defaults_addr
power_mngr__defaults_addr:
	.global L_8cc1f4
L_8cc1f4:
	mov_s r0,0x803d90
L_8cc1fa:
	j_s [blink]
