/* operational_if__alloc_evt @ 0x8c2b68, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__send_scan_complete, l2_mgr__send_pcp_start_status_evt, l2mgr__send_ba_status_evt, l2mgr__send_data_port_open_evt, l2mgr__send_disconnect_evt, l2mgr__send_discovery_started, l2mgr__send_discovery_stopped, l2mgr__send_host_event, l2mgr__send_listen_started, l2mgr__send_notify_req_done
 * Зовёт сам: basic_if__alloc_mbox_slot, operational_if__mbox_ptr
 */
	.section .text.operational_if__alloc_evt,"ax",@progbits
	.global operational_if__alloc_evt
operational_if__alloc_evt:
	.global L_8c2b68
L_8c2b68:
	push_s blink
L_8c2b6a:
	bl L_8d6e80
L_8c2b6e:
	bl L_8c2c38
L_8c2b72:
	pop_s blink
L_8c2b74:
	j_s [blink]
L_8c2b76:
	nop_s
