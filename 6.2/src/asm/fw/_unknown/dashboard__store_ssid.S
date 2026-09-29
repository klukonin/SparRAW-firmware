/* dashboard__store_ssid @ 0x8eace8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_set_passphrase_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dashboard__store_ssid
dashboard__store_ssid:
	.global L_8eace8
L_8eace8:
	push_s blink
L_8eacea:
	bl L_8c01e4
L_8eacee:
	mov_s r13,r0
L_8eacf0:
	mov_s r14,r2
L_8eacf2:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8eacf4:
	bl.d L_8c0380
L_8eacf8:
	ldw_s r2,[r13,0x26]
L_8eacfa:
	b.d L_8c0254
L_8eacfe:
	stw_s r14,[r13,0x26]
