/* mem_pool__free_thunk @ 0x8cb15c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__rx_pkt_handler, l2mgr__send_host_event, mlme__ctrl_new_sta_timeout_cb, mlme_sm_802458__action_8c7de0, mlme_sm_802458__action_8f1080, mlme_sm_802458__action_8f20bc, mlme_sm_802458__action_8f2444, mlme_sm__association_timeout_ev_handle, mlme_sm__check_field_2c, mlme_sm__data_port_open_ev_handle
 * Зовёт сам: mem_pool__free__8cb19c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__free_thunk
mem_pool__free_thunk:
	.global L_8cb15c
L_8cb15c:
	b L_8cb19c
