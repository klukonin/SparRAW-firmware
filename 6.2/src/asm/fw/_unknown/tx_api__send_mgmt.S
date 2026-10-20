/* tx_api__send_mgmt @ 0x8e5874, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SW_TX_MGMT_API__link_up_evt, ba_sm__send_addba_req, ba_sm__send_delba, ba_sm__setup_result, find_main_sm__bf_ntf, find_main_sm__probe_req_in_search, mlme_sm__send_disassoc, pcp_psc_sm__build_psc_resp, sta_psc_sm__build_psc_req, state_sm_8030f4__action_8f76d8
 * Зовёт сам: TX_API__send_packet, __ld_r14_to_r13_ret, __st_r14_to_r13, tx_api__get_mgmt_retry_limit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__send_mgmt
tx_api__send_mgmt:
	.global L_8e5874
L_8e5874:
	push_s blink
L_8e5876:
	bl.d L_8c01e4
L_8e587a:
	mov_s r10,r0
L_8e587c:
	sub_s sp,sp,0xc
L_8e587e:
	mov_s r13,r5
L_8e5880:
	bl.d L_8cc3d0
L_8e5884:
	mov_s r14,r6
L_8e5886:
	mov_s r5,r0
L_8e5888:
	mov_s r0,0x0
L_8e588a:
	st_s r0,[sp,0x0]
L_8e588c:
	st_s r13,[sp,0x4]
L_8e588e:
	st_s r14,[sp,0x8]
L_8e5890:
	mov_s r0,r10
L_8e5892:
	mov r6,0x0
L_8e5896:
	bl.d L_8e58a4
L_8e589a:
	mov r7,r6
L_8e589e:
	b.d L_8c0254
L_8e58a2:
	add_s sp,sp,0xc
