/* ucode_cmd_0x11_handler @ 0x930294, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: memcpy_uc
 */
	.section .text.ucode_cmd_0x11_handler,"ax",@progbits
	.global ucode_cmd_0x11_handler
ucode_cmd_0x11_handler:
	.global L_930294
L_930294:
	mov_s r1,r0
L_930296:
	mov_s r0,0x8016b4
L_93029c:
	b.d L_920310
L_9302a0:
	mov_s r2,0x10
L_9302a2:
	nop_s
