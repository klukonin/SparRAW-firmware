/* mgmt_tx__begin_frame @ 0x8e9c7c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__send_addba_req, ba_sm__send_delba, ba_sm__setup_result, ieee80211_mgt_information_response_construct, pcp_psc_sm__build_psc_resp, sta_psc_sm__build_psc_req, tx_mgmt_ftm_req, wmi_rcp_addba_resp, wmi_rcp_delba
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mgmt_tx__build_mac_header
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__begin_frame
mgmt_tx__begin_frame:
	.global L_8e9c7c
L_8e9c7c:
	push_s blink
L_8e9c7e:
	bl.d L_8c01e4
L_8e9c82:
	add_s r3,r3,0x1c
L_8e9c84:
	mov_s r14,r0
L_8e9c86:
	mov_s r13,r1
L_8e9c88:
	mov_s r0,r2
L_8e9c8a:
	mov_s r1,r14
L_8e9c8c:
	bl.d L_8d7db8
L_8e9c90:
	mov_s r2,r4
L_8e9c92:
	mov_s r0,0x18
L_8e9c94:
	b.d L_8c0254
L_8e9c98:
	st_s r0,[r13]
L_8e9c9a:
	nop_s
