/* ie__push_dmg_capabilities @ 0x8ef87c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ieee80211_mgt_information_response_construct, mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies, mgmt_tx__assoc_resp_tlv, mgmt_tx__probe_req_ies, mgmt_tx__probe_resp_ies
 * Зовёт сам: __ld_r13_ret, memcpy_fw
 */
	.section .text.ie__push_dmg_capabilities,"ax",@progbits
	.global ie__push_dmg_capabilities
ie__push_dmg_capabilities:
	.global L_8ef87c
L_8ef87c:
	push_s blink
L_8ef87e:
	push_s r13
L_8ef880:
	mov_s r3,r2
L_8ef882:
	mov_s r2,0x11
L_8ef884:
	mov_s r13,0x94
L_8ef886:
	stb_s r13,[r0]
L_8ef888:
	stb_s r2,[r0,0x1]
L_8ef88a:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8ef88c:
	bl.d L_8c0460
L_8ef890:
	stb_s r3,[r1,0x6]
L_8ef892:
	b.d L_8c033c
L_8ef896:
	mov_s r0,0x13
