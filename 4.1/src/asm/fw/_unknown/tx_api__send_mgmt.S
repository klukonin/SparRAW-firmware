/* tx_api__send_mgmt @ 0x8e0c44, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SW_TX_MGMT_API__link_up_evt, ba__send_addba_resp, ba_sm__send_addba_req, ba_sm__send_delba, find_main_sm__bf_ntf, find_main_sm__probe_req, find_main_sm__probe_req_in_search, mlme_sm__send_disassoc, pcp_psc_sm__build_psc_resp, sta_psc_sm__build_psc_req
 * Зовёт сам: TX_API__send_packet, __ld_r14_to_r13_ret, __st_r14_to_r13, get_g_800240
 */
	.section .text.tx_api__send_mgmt,"ax",@progbits
	.global tx_api__send_mgmt
tx_api__send_mgmt:
	.global L_8e0c44
L_8e0c44:
	push_s blink
L_8e0c46:
	bl.d L_8c02c4
L_8e0c4a:
	mov_s r10,r0
L_8e0c4c:
	sub_s sp,sp,0xc
L_8e0c4e:
	mov_s r13,r5
L_8e0c50:
	bl.d L_8ca1a4
L_8e0c54:
	mov_s r14,r6
L_8e0c56:
	mov_s r5,r0
L_8e0c58:
	mov_s r0,0x0
L_8e0c5a:
	st_s r0,[sp,0x0]
L_8e0c5c:
	st_s r13,[sp,0x4]
L_8e0c5e:
	st_s r14,[sp,0x8]
L_8e0c60:
	mov_s r0,r10
L_8e0c62:
	mov r6,0x0
L_8e0c66:
	bl.d L_8e0c74
L_8e0c6a:
	mov r7,r6
L_8e0c6e:
	b.d L_8c0334
L_8e0c72:
	add_s sp,sp,0xc
