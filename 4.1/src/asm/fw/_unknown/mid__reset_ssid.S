/* mid__reset_ssid @ 0x8c4498, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr_mac_start_step
 * Зовёт сам: memset0_words
 */
	.section .text.mid__reset_ssid,"ax",@progbits
	.global mid__reset_ssid
mid__reset_ssid:
	.global L_8c4498
L_8c4498:
	add r0,r0,0x103
L_8c449c:
	b.d L_8c1a78
L_8c44a0:
	mov_s r1,0x4
L_8c44a2:
	nop_s
