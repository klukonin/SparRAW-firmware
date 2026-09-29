/* fw_sysapi_mgr__send_evt2host @ 0x8f8948, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_sysapi_mgr::send_evt2host(): m_ut_wmi_context is ut_module_id=0x%x, ut_subtype_id=0x%x, host_if_p=0x%x
 * Зовут его: channel_estimation_cmd_start, field_rw_0x20__8f3538, fw_sysapi__send_measure_evt, fw_sysapi_mgr__channel_estimation_cmd_complete, fw_sysapi_mgr__mac_ampdu_statistics_cmd_start, fw_sysapi_mgr__phy_rx_statistics_cmd_start, fw_sysapi_mgr__start_energy_statistics, fw_sysapi_mgr__start_plcp_header, get_rx_pkt_phy_data_cmd_complete, get_rx_pkt_phy_data_cmd_start
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit3, memcpy_fw, memset0_words, ut__begin_response, wmi_evt__send_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__send_evt2host
fw_sysapi_mgr__send_evt2host:
	.global L_8f8948
L_8f8948:
	push_s blink
L_8f894a:
	bl L_8c01d8
L_8f894e:
	mov_s r14,r0
L_8f8950:
	mov_s r16,r1
L_8f8952:
	mov_s r17,r2
L_8f8954:
	mov_s r15,r3
L_8f8956:
	mov_s r13,r4
L_8f8958:
	ld r4,[r0, 0x8]
L_8f895c:
	mov_s r1,0x10124a0
L_8f8962:
	ldw_s r2,[r14,0x4]
L_8f8964:
	mov_s r0,0x25
L_8f8966:
	bl.d L_8dcd00
L_8f896a:
	ldw_s r3,[r14,0x6]
L_8f896c:
	ld_s r0,[r13,0x4]
L_8f896e:
	ldw_s r1,[r13]
L_8f8970:
	bl.d L_8eae60
L_8f8974:
	ldw_s r2,[r13,0x2]
L_8f8976:
	mov_s r13,r0
L_8f8978:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8f897a:
	bl.d L_8c1cd8
L_8f897e:
	mov_s r1,0xec
L_8f8980:
	st r16,[r13, 0x4]
L_8f8984:
	add r0,r13,0x8
L_8f8988:
	mov_s r1,r17
L_8f898a:
	bl.d L_8c0380
L_8f898e:
	mov_s r2,r15
L_8f8990:
	add r2,r15,0x8
L_8f8994:
	ld_s r0,[r14,0x8]
L_8f8996:
	extw_s r2,r2
L_8f8998:
	bl.d L_8eae78
L_8f899c:
	mov_s r1,r13
L_8f899e:
	b L_8c023c
L_8f89a2:
	nop_s
