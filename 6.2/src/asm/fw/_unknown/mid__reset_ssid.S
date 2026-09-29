/* mid__reset_ssid @ 0x8c4df8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__reset_bss_defaults
 * Зовёт сам: memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__reset_ssid
mid__reset_ssid:
	.global L_8c4df8
L_8c4df8:
	add r0,r0,0x103
L_8c4dfc:
	b.d L_8c1cd8
L_8c4e00:
	mov_s r1,0x4
L_8c4e02:
	nop_s
