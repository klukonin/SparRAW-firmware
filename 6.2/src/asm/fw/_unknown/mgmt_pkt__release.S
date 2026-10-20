/* mgmt_pkt__release @ 0x8cb180, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__rx_pkt_handler, mlme_sm_802458__action_8c7de0, mlme_sm_802458__action_8f0f4c, mlme_sm_802458__action_8f1080, mlme_sm_802458__action_8f20bc, mlme_sm_802458__action_8f2444, mlme_sm__assoc_reject_ev_handle, mlme_sm__data_port_open_ev_handle, mlme_sm__disconnect_ev_handle_8f26a8, rx_pkt_handler
 * Зовёт сам: __ld_r13_to_r13_ret, mgmt_pkt__clear
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_pkt__release
mgmt_pkt__release:
	.global L_8cb180
L_8cb180:
	push_s blink
L_8cb182:
	push_s r13
L_8cb184:
	mov_s r13,r0
L_8cb186:
	mov_s r0,0x842840
L_8cb18c:
	bl.d L_8cb160
L_8cb190:
	ld_s r1,[r13,0xc]
L_8cb192:
	mov_s r0,0x0
L_8cb194:
	b.d L_8c025c
L_8cb198:
	st_s r0,[r13,0xc]
L_8cb19a:
	nop_s
