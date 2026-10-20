/* boot_diag__reg_8802bc_addr @ 0x8cc6b4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_diag_magic
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot_diag__reg_8802bc_addr
boot_diag__reg_8802bc_addr:
	.global L_8cc6b4
L_8cc6b4:
	mov_s r0,0x8802bc
L_8cc6ba:
	j_s [blink]
