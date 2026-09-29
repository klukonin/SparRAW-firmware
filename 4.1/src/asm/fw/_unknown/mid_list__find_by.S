/* mid_list__find_by @ 0x8c9e74, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SW_TX_MGMT_API__send_packet, WMI_ADD_CIPHER_KEY_CMD, discovery__handle_rx_frame, discovery_handle_probe_req, discovery_handle_probe_resp, l2mgr__disconnect_sta, mid__link_acquisition_action, wmi_handler_pxmt_range_cfg
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, iter__has_more, iter__init, iter__next, memcmp_fw
 */
	.section .text.mid_list__find_by,"ax",@progbits
	.global mid_list__find_by
mid_list__find_by:
	.global L_8c9e74
L_8c9e74:
	add r2,r0,0x18
L_8c9e78:
	mov_s r0,r1
L_8c9e7a:
	b.d L_8c9e80
L_8c9e7e:
	mov_s r1,r2
	.global L_8c9e80
L_8c9e80:
	push_s blink
L_8c9e82:
	bl L_8c02c0
L_8c9e86:
	sub_s sp,sp,0x4
L_8c9e88:
	mov_s r15,r0
L_8c9e8a:
	mov_s r14,sp
L_8c9e8c:
	bl.d L_8e1138
L_8c9e90:
	mov_s r0,r14
L_8c9e92:
	b_s L_8c9eaa
	.global L_8c9e94
L_8c9e94:
	bl.d L_8db188
L_8c9e98:
	mov_s r0,r14
L_8c9e9a:
	mov_s r13,r0
L_8c9e9c:
	add r1,r0,0x10
L_8c9ea0:
	mov_s r0,r15
L_8c9ea2:
	bl.d L_8da014
L_8c9ea6:
	mov_s r2,0x6
L_8c9ea8:
	breq_s r0,0,L_8c9eb4
	.global L_8c9eaa
L_8c9eaa:
	bl.d L_8cb674
L_8c9eae:
	mov_s r0,r14
L_8c9eb0:
	brne_s r0,0,L_8c9e94
L_8c9eb2:
	mov_s r13,0x0
	.global L_8c9eb4
L_8c9eb4:
	mov_s r0,r13
L_8c9eb6:
	b.d L_8c032c
L_8c9eba:
	add_s sp,sp,0x4
