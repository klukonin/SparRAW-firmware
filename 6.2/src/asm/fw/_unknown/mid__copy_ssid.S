/* mid__copy_ssid @ 0x8ccc98, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_is_ssid_approved, find_main_sm__bf_ntf, host_if__get_status_hal, mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies, mgmt_tx__probe_resp_ies_8d8378, scan_mngr__dband_beacon_ind, wmi_get_ssid
 * Зовёт сам: __ld_r13_to_r13_ret, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__copy_ssid
mid__copy_ssid:
	.global L_8ccc98
L_8ccc98:
	push_s blink
L_8ccc9a:
	push_s r13
L_8ccc9c:
	mov_s r13,r0
L_8ccc9e:
	ld_s r2,[r13,0x48]
L_8ccca0:
	mov_s r0,r1
L_8ccca2:
	breq_s r2,0,L_8cccac
L_8ccca4:
	bl.d L_8c0380
L_8ccca8:
	add r1,r13,0x26
	.global L_8cccac
L_8cccac:
	b.d L_8c025c
L_8cccb0:
	ld_s r0,[r13,0x48]
L_8cccb2:
	nop_s
