/* mid__copy_ssid @ 0x8ca928, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_is_ssid_approved, find_main_sm__bf_ntf, host_if__get_status_hal, mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies, mgmt_tx__probe_req_ies, mgmt_tx__probe_resp_ies, wmi_handler_get_ssid
 * Зовёт сам: __ld_r13_ret, memcpy_fw
 */
	.section .text.mid__copy_ssid,"ax",@progbits
	.global mid__copy_ssid
mid__copy_ssid:
	.global L_8ca928
L_8ca928:
	push_s blink
L_8ca92a:
	push_s r13
L_8ca92c:
	mov_s r13,r0
L_8ca92e:
	ld_s r2,[r13,0x48]
L_8ca930:
	mov_s r0,r1
L_8ca932:
	breq_s r2,0,L_8ca93c
L_8ca934:
	bl.d L_8c0460
L_8ca938:
	add r1,r13,0x26
	.global L_8ca93c
L_8ca93c:
	b.d L_8c033c
L_8ca940:
	ld_s r0,[r13,0x48]
L_8ca942:
	nop_s
