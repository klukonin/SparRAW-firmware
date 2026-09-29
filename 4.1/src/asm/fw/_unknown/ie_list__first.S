/* ie_list__first @ 0x8c9e10, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__probe_req, find_main_sm__probe_req_in_search, ieee80211_mgt_information_response_construct, wmi_handler_add_debug_tx_pckt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__has_more, iter__init, iter__next
 */
	.section .text.ie_list__first,"ax",@progbits
	.global ie_list__first
ie_list__first:
	.global L_8c9e10
L_8c9e10:
	push_s blink
L_8c9e12:
	bl L_8c02c4
L_8c9e16:
	sub_s sp,sp,0x4
L_8c9e18:
	mov_s r14,r1
L_8c9e1a:
	mov_s r13,sp
L_8c9e1c:
	add r1,r0,0x18
L_8c9e20:
	bl.d L_8e1138
L_8c9e24:
	mov_s r0,r13
L_8c9e26:
	b_s L_8c9e34
	.global L_8c9e28
L_8c9e28:
	bl.d L_8db188
L_8c9e2c:
	mov_s r0,r13
L_8c9e2e:
	ldb_s r1,[r0,0x8]
L_8c9e30:
	breq r14,r1,L_8c9e3e
	.global L_8c9e34
L_8c9e34:
	bl.d L_8cb674
L_8c9e38:
	mov_s r0,r13
L_8c9e3a:
	brne_s r0,0,L_8c9e28
L_8c9e3c:
	mov_s r0,0x0
	.global L_8c9e3e
L_8c9e3e:
	b.d L_8c0334
L_8c9e42:
	add_s sp,sp,0x4
