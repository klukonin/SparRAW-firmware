/* ucode_cmd_0x16_handler @ 0x930dd4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: memcpy_uc
 */
	.section .text.ucode_cmd_0x16_handler,"ax",@progbits
	.global ucode_cmd_0x16_handler
ucode_cmd_0x16_handler:
	.global L_930dd4
L_930dd4:
	mov_s r1,r0
L_930dd6:
	mov_s r0,gp
L_930dd8:
	/* add r0,r0,0x28 */
	.byte 0x80,0x20,0x00,0x0a
L_930ddc:
	b.d L_920310
L_930de0:
	mov_s r2,0x4
L_930de2:
	nop_s
