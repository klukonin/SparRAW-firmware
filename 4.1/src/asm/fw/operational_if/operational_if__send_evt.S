/* operational_if__send_evt @ 0x8e0874, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   operational_if.cpp
 * Зовут его: discovery__rx_pkt_handler, host_if__send_scan_complete, l2_mgr__send_pcp_start_status_evt, l2mgr__send_ba_status_evt, l2mgr__send_data_port_open_evt, l2mgr__send_disconnect_evt, l2mgr__send_discovery_started, l2mgr__send_discovery_stopped, l2mgr__send_host_event, l2mgr__send_listen_started
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_sysassert_fatal, operational_if__mbox_ptr
 */
	.section .text.operational_if__send_evt,"ax",@progbits
	.global operational_if__send_evt
operational_if__send_evt:
	.global L_8e0874
L_8e0874:
	push_s blink
L_8e0876:
	bl L_8c02ac
L_8e087a:
	mov_s r20,r0
L_8e087c:
	mov_s r19,r1
L_8e087e:
	mov_s r13,r2
L_8e0880:
	mov_s r18,r3
L_8e0882:
	mov.f r16,r4
L_8e0886:
	mov r17,r5
L_8e088a:
	cmp.eq r17,0x0
L_8e088e:
	bne_s L_8e089a
L_8e0890:
	add r0,r13,0x10
L_8e0894:
	cmp r0,0x100
L_8e0898:
	bhi_s L_8e08b6
	.global L_8e089a
L_8e089a:
	bl L_8d6e80
L_8e089e:
	mov_s r1,r19
L_8e08a0:
	ld_s r14,[r0,0x70]
L_8e08a2:
	mov_s r0,r20
L_8e08a4:
	mov_s r2,r13
L_8e08a6:
	mov_s r3,r18
L_8e08a8:
	mov r4,r16
L_8e08ac:
	jl_s.d [r14]
L_8e08ae:
	mov r5,r17
L_8e08b2:
	b L_8c0304
	.global L_8e08b6
L_8e08b6:
	mov_s r0,blink
L_8e08b8:
	mov_s r2,0x1003e14
L_8e08be:
	mov_s r1,0x61
L_8e08c0:
	bset_s r1,r1,0xc
L_8e08c2:
	bl.d L_8c82c0
L_8e08c6:
	mov_s r3,0x7e
