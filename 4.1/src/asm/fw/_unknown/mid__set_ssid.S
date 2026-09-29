/* mid__set_ssid @ 0x8e2100, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__connect, l2_mgr__wmi_cmd_handler_set_ssid, l2mgr_mac_start_step, wmi_set_passphrase_handler
 * Зовёт сам: memcpy_fw
 */
	.section .text.mid__set_ssid,"ax",@progbits
	.global mid__set_ssid
mid__set_ssid:
	.global L_8e2100
L_8e2100:
	push_s blink
L_8e2102:
	mov_s r3,0x0
L_8e2104:
	st_s r3,[r0,0x48]
L_8e2106:
	breq_s r2,0,L_8e2114
L_8e2108:
	brhs r2,0x21,L_8e2114
L_8e210c:
	st_s r2,[r0,0x48]
L_8e210e:
	bl.d L_8c0460
L_8e2112:
	add_s r0,r0,0x26
	.global L_8e2114
L_8e2114:
	pop_s blink
L_8e2116:
	j_s [blink]
