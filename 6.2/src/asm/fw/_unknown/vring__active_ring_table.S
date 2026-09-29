/* vring__active_ring_table @ 0x8cd080, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2, STREAM_MGR__ADD, ba__send_status_report_for_vring, ba_sm__action_8c4394, l2_mgr__scan_complete_handle, l2_mgr__wmi_scan_cmd, mlme_sm__disconnect_ev_handle, ps__sta_has_pending_data, ps_assoc_mgr__shallow_sleep_enter, rm_main_sm__enter_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__active_ring_table
vring__active_ring_table:
	.global L_8cd080
L_8cd080:
	ld_s r0,[gp,-0x118]
L_8cd082:
	brne r0,0x1,L_8cd08e
L_8cd086:
	mov_s r0,0x804e64
L_8cd08c:
	b_s L_8cd094
	.global L_8cd08e
L_8cd08e:
	mov_s r0,0x804dbc
	.global L_8cd094
L_8cd094:
	j_s [blink]
L_8cd096:
	nop_s
