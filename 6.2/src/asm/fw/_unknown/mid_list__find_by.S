/* mid_list__find_by @ 0x8cc024, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SW_TX_MGMT_API__send_packet, discovery_handle_probe_req, discovery_handle_probe_resp, dmg_bcon__rx_handler, handle_packet_splitmac, l2_mgr__wmi_cmd_handler_del_sta, l2_mgr__wmi_cmd_handler_new_sta, l2mgr__disconnect_sta, mid__link_acquisition_action, scan_mngr__dband_beacon_ind
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, iter__init, iter__next, list__has_items, memcmp_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_list__find_by
mid_list__find_by:
	.global L_8cc024
L_8cc024:
	add r2,r0,0x18
L_8cc028:
	mov_s r0,r1
L_8cc02a:
	b.d L_8cc030
L_8cc02e:
	mov_s r1,r2
	.global L_8cc030
L_8cc030:
	push_s blink
L_8cc032:
	bl L_8c01e0
L_8cc036:
	sub_s sp,sp,0x4
L_8cc038:
	mov_s r15,r0
L_8cc03a:
	mov_s r14,sp
L_8cc03c:
	bl.d L_8e5df4
L_8cc040:
	mov_s r0,r14
L_8cc042:
	b_s L_8cc05a
	.global L_8cc044
L_8cc044:
	bl.d L_8df438
L_8cc048:
	mov_s r0,r14
L_8cc04a:
	mov_s r13,r0
L_8cc04c:
	add r1,r0,0x1c
L_8cc050:
	mov_s r0,r15
L_8cc052:
	bl.d L_8ddf4c
L_8cc056:
	mov_s r2,0x6
L_8cc058:
	breq_s r0,0,L_8cc064
	.global L_8cc05a
L_8cc05a:
	bl.d L_8cdcb8
L_8cc05e:
	mov_s r0,r14
L_8cc060:
	brne_s r0,0,L_8cc044
L_8cc062:
	mov_s r13,0x0
	.global L_8cc064
L_8cc064:
	mov_s r0,r13
L_8cc066:
	b.d L_8c024c
L_8cc06a:
	add_s sp,sp,0x4
