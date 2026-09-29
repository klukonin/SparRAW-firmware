/* wmi_set_passphrase_handler @ 0x8e7e50, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_set_passphrase_handler: SSID LEN %d, PASSPHARSE LEN %d for devid %d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, dashboard__store_passphrase, dashboard__store_ssid, fw_log__emit3, mid__set_ssid, mid_list__by_mid
 */
	.section .text.wmi_set_passphrase_handler,"ax",@progbits
	.global wmi_set_passphrase_handler
wmi_set_passphrase_handler:
	.global L_8e7e50
L_8e7e50:
	push_s blink
L_8e7e52:
	bl L_8c02bc
L_8e7e56:
	mov_s r13,r0
L_8e7e58:
	mov_s r16,r1
L_8e7e5a:
	bl.d L_8ca1b0
L_8e7e5e:
	mov_s r0,r1
L_8e7e60:
	add_s r0,r0,0x48
L_8e7e62:
	add3 r14,r13,0xc
L_8e7e66:
	mov_s r1,r13
L_8e7e68:
	bl.d L_8e2100
L_8e7e6c:
	ldb_s r2,[r14]
L_8e7e6e:
	mov_s r15,0x8033dc
L_8e7e74:
	add r1,r13,0x20
L_8e7e78:
	mov_s r0,r15
L_8e7e7a:
	bl.d L_8e5954
L_8e7e7e:
	ldb_s r2,[r14,0x1]
L_8e7e80:
	mov_s r0,r15
L_8e7e82:
	mov_s r1,r13
L_8e7e84:
	bl.d L_8e5a14
L_8e7e88:
	ldb_s r2,[r14]
L_8e7e8a:
	mov_s r2,0x100a0ec
L_8e7e90:
	ldb r4,[r14, 0x1]
L_8e7e94:
	mov_s r0,0x0
L_8e7e96:
	ldb_s r3,[r14]
L_8e7e98:
	mov_s r1,0x2
L_8e7e9a:
	bl.d L_8ee034
L_8e7e9e:
	mov r5,r16
L_8e7ea2:
	b L_8c0324
L_8e7ea6:
	nop_s
