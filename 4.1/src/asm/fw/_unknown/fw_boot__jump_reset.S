/* fw_boot__jump_reset @ 0x8c1b0c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_boot__clear_bss
 */
	.section .text.fw_boot__jump_reset,"ax",@progbits
	.global fw_boot__jump_reset
fw_boot__jump_reset:
	.global L_8c1b0c
L_8c1b0c:
	/* j 0x00000114 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x14,0x01
