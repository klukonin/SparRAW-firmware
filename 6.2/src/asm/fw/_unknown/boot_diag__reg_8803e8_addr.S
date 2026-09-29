/* boot_diag__reg_8803e8_addr @ 0x8cc168, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_diag_magic
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot_diag__reg_8803e8_addr
boot_diag__reg_8803e8_addr:
	.global L_8cc168
L_8cc168:
	mov_s r0,0x8803e8
L_8cc16e:
	j_s [blink]
