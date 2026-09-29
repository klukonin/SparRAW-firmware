/* mgmt_buf__free @ 0x8c9538, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__rx_pkt_handler, mlme__free_assoc_buf, mlme_sm__assoc_req_handle, mlme_sm__association_timeout_ev_handle, mlme_sm__disconnect_ev_handle, mlme_sm__handle_disassoc, rx_mgmt__action_no_ack, rx_pkt_handler, rx_pkt_srvs__dispatch, rx_pkt_srvs__distribute_data
 * Зовёт сам: mem_pool__free_8062c4
 */
	.section .text.mgmt_buf__free,"ax",@progbits
	.global mgmt_buf__free
mgmt_buf__free:
	.global L_8c9538
L_8c9538:
	b L_8c9578
