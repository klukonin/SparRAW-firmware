/* mgmt_tx__begin_frame @ 0x8e4be4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba__send_addba_resp, ba_sm__send_addba_req, ba_sm__send_delba, ieee80211_mgt_information_response_construct, pcp_psc_sm__build_psc_resp, sta_psc_sm__build_psc_req, wmi_handler_rcp_addba_resp, wmi_handler_rcp_delba
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mgmt_tx__build_mac_header
 */
	.section .text.mgmt_tx__begin_frame,"ax",@progbits
	.global mgmt_tx__begin_frame
mgmt_tx__begin_frame:
	.global L_8e4be4
L_8e4be4:
	push_s blink
L_8e4be6:
	bl.d L_8c02c4
L_8e4bea:
	add_s r3,r3,0x10
L_8e4bec:
	mov_s r14,r0
L_8e4bee:
	mov_s r13,r1
L_8e4bf0:
	mov_s r0,r2
L_8e4bf2:
	mov_s r1,r14
L_8e4bf4:
	bl.d L_8ec5c0
L_8e4bf8:
	mov_s r2,r4
L_8e4bfa:
	mov_s r0,0x18
L_8e4bfc:
	b.d L_8c0334
L_8e4c00:
	st_s r0,[r13]
L_8e4c02:
	nop_s
