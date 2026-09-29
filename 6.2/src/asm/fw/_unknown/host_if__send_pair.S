/* host_if__send_pair @ 0x8c32d8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__periodic_notif_handler, host_if__send_scan_complete, l2_mgr__send_pcp_start_status_evt, l2_mgr__tof_ftm_req, l2_mgr__tof_get_capabilities, l2mgr__send_data_port_open_evt, l2mgr__send_disconnect_evt, l2mgr__send_discovery_started, l2mgr__send_discovery_stopped, l2mgr__send_host_event
 * Зовёт сам: mem_pool__alloc_locked, tx_api__ctx_8041f0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__send_pair
host_if__send_pair:
	.global L_8c32d8
L_8c32d8:
	push_s blink
L_8c32da:
	bl L_8d9f7c
L_8c32de:
	bl L_8c33d0
L_8c32e2:
	pop_s blink
L_8c32e4:
	j_s [blink]
L_8c32e6:
	nop_s
