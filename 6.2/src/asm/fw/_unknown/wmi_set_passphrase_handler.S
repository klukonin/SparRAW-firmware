/* wmi_set_passphrase_handler @ 0x8ece64, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_set_passphrase_handler: SSID LEN %d, PASSPHARSE LEN %d for devid %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, dashboard__store_passphrase, dashboard__store_ssid, fw_log_emit3, mid__set_ssid, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_passphrase_handler
wmi_set_passphrase_handler:
	.global L_8ece64
L_8ece64:
	push_s blink
L_8ece66:
	bl L_8c01dc
L_8ece6a:
	mov_s r13,r0
L_8ece6c:
	mov_s r16,r1
L_8ece6e:
	bl.d L_8cc3dc
L_8ece72:
	mov_s r0,r1
L_8ece74:
	add_s r0,r0,0x48
L_8ece76:
	add3 r14,r13,0xc
L_8ece7a:
	mov_s r1,r13
L_8ece7c:
	bl.d L_8e70a8
L_8ece80:
	ldb_s r2,[r14]
L_8ece82:
	mov_s r15,0x803b80
L_8ece88:
	add r1,r13,0x20
L_8ece8c:
	mov_s r0,r15
L_8ece8e:
	bl.d L_8eac90
L_8ece92:
	ldb_s r2,[r14,0x1]
L_8ece94:
	mov_s r0,r15
L_8ece96:
	mov_s r1,r13
L_8ece98:
	bl.d L_8eace8
L_8ece9c:
	ldb_s r2,[r14]
L_8ece9e:
	mov_s r1,0x100b698
L_8ecea4:
	ldb_s r2,[r14]
L_8ecea6:
	mov_s r0,0x20
L_8ecea8:
	ldb_s r3,[r14,0x1]
L_8eceaa:
	bl.d L_8dcd00
L_8eceae:
	mov r4,r16
L_8eceb2:
	b L_8c0244
L_8eceb6:
	nop_s
