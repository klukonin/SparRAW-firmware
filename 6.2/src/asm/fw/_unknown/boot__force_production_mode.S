/* boot__force_production_mode @ 0x8cadec, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__force_production_mode
boot__force_production_mode:
	.global L_8cadec
L_8cadec:
	mov_s r1,0x1
L_8cadee:
	mov_s r0,0x880a3c
L_8cadf4:
	j_s.d [blink]
L_8cadf6:
	st_s r1,[r0,0x7c]
