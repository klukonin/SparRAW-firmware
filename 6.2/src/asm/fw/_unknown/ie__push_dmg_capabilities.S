/* ie__push_dmg_capabilities @ 0x8e1fd4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ieee80211_mgt_information_response_construct, mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies, mgmt_tx__assoc_resp_tlv, mgmt_tx__probe_resp_ies, mgmt_tx__probe_resp_ies_8d8378
 * Зовёт сам: __ld_r13_to_r13_ret, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__push_dmg_capabilities
ie__push_dmg_capabilities:
	.global L_8e1fd4
L_8e1fd4:
	push_s blink
L_8e1fd6:
	push_s r13
L_8e1fd8:
	mov_s r3,r2
L_8e1fda:
	mov_s r2,0x11
L_8e1fdc:
	mov_s r13,0x94
L_8e1fde:
	stb_s r13,[r0]
L_8e1fe0:
	stb_s r2,[r0,0x1]
L_8e1fe2:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e1fe4:
	bl.d L_8c0380
L_8e1fe8:
	stb_s r3,[r1,0x6]
L_8e1fea:
	b.d L_8c025c
L_8e1fee:
	mov_s r0,0x13
