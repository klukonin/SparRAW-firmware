/* dashboard__store_ssid @ 0x8e5a14, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_set_passphrase_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_fw
 */
	.section .text.dashboard__store_ssid,"ax",@progbits
	.global dashboard__store_ssid
dashboard__store_ssid:
	.global L_8e5a14
L_8e5a14:
	push_s blink
L_8e5a16:
	bl L_8c02c4
L_8e5a1a:
	mov_s r13,r0
L_8e5a1c:
	mov_s r14,r2
L_8e5a1e:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e5a20:
	bl.d L_8c0460
L_8e5a24:
	ldw_s r2,[r13,0x26]
L_8e5a26:
	b.d L_8c0334
L_8e5a2a:
	stw_s r14,[r13,0x26]
