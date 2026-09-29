/* ie_list__first @ 0x8cbfc8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__probe_req_in_search, ieee80211_mgt_information_response_construct, state_sm_8030f4__action_8f76d8, wmi_add_debug_tx_pckt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie_list__first
ie_list__first:
	.global L_8cbfc8
L_8cbfc8:
	push_s blink
L_8cbfca:
	bl L_8c01e4
L_8cbfce:
	sub_s sp,sp,0x4
L_8cbfd0:
	mov_s r14,r1
L_8cbfd2:
	mov_s r13,sp
L_8cbfd4:
	add r1,r0,0x18
L_8cbfd8:
	bl.d L_8e5df4
L_8cbfdc:
	mov_s r0,r13
L_8cbfde:
	b_s L_8cbfec
	.global L_8cbfe0
L_8cbfe0:
	bl.d L_8df438
L_8cbfe4:
	mov_s r0,r13
L_8cbfe6:
	ldb_s r1,[r0,0x8]
L_8cbfe8:
	breq r14,r1,L_8cbff6
	.global L_8cbfec
L_8cbfec:
	bl.d L_8cdcb8
L_8cbff0:
	mov_s r0,r13
L_8cbff2:
	brne_s r0,0,L_8cbfe0
L_8cbff4:
	mov_s r0,0x0
	.global L_8cbff6
L_8cbff6:
	b.d L_8c0254
L_8cbffa:
	add_s sp,sp,0x4
