/* wmi_handler_get_ssid @ 0x8f2d2c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_SSID_EVENTID for devid %d.
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, mid__copy_ssid, mid_list__by_mid, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.wmi_handler_get_ssid,"ax",@progbits
	.global wmi_handler_get_ssid
wmi_handler_get_ssid:
	.global L_8f2d2c
L_8f2d2c:
	push_s blink
L_8f2d2e:
	bl L_8c02c4
L_8f2d32:
	bl.d L_8c2b68
L_8f2d36:
	mov_s r14,r0
L_8f2d38:
	mov_s r13,r0
L_8f2d3a:
	bl.d L_8ca1b0
L_8f2d3e:
	mov_s r0,r14
L_8f2d40:
	add_s r0,r0,0x48
L_8f2d42:
	bl.d L_8ca928
L_8f2d46:
	add_s r1,r13,0x4
L_8f2d48:
	st_s r0,[r13]
L_8f2d4a:
	mov_s r2,0x100cc7c
L_8f2d50:
	mov_s r0,0xb
L_8f2d52:
	mov_s r1,0x2
L_8f2d54:
	bl.d L_8edfcc
L_8f2d58:
	mov_s r3,r14
L_8f2d5a:
	mov_s r0,r13
L_8f2d5c:
	mov_s r1,0x1828
L_8f2d62:
	mov_s r2,0x24
L_8f2d64:
	mov_s r3,0x0
L_8f2d66:
	mov_s r4,r3
L_8f2d68:
	bl.d L_8e0874
L_8f2d6c:
	mov_s r5,r3
L_8f2d6e:
	b L_8c0334
L_8f2d72:
	nop_s
