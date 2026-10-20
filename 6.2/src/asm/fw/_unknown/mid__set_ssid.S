/* mid__set_ssid @ 0x8e70a8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__connect, l2_mgr__wmi_cmd_handler_set_ssid, mid__reset_bss_defaults, wmi_set_passphrase_handler
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__set_ssid
mid__set_ssid:
	.global L_8e70a8
L_8e70a8:
	push_s blink
L_8e70aa:
	mov_s r3,0x0
L_8e70ac:
	st_s r3,[r0,0x48]
L_8e70ae:
	breq_s r2,0,L_8e70bc
L_8e70b0:
	brhs r2,0x21,L_8e70bc
L_8e70b4:
	st_s r2,[r0,0x48]
L_8e70b6:
	bl.d L_8c0380
L_8e70ba:
	add_s r0,r0,0x26
	.global L_8e70bc
L_8e70bc:
	pop_s blink
L_8e70be:
	j_s [blink]
