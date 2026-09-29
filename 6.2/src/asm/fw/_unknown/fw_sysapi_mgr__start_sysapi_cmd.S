/* fw_sysapi_mgr__start_sysapi_cmd @ 0x8f9a20, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_sysapi_mgr::start_sysapi_cmd: Rejecting sysapi request  since prev cmd is still running
 * Зовут его: channel_estimation_cmd_start, fw_sysapi_mgr__get_flush_statistics_cmd_start, fw_sysapi_mgr__mac_ampdu_statistics_cmd_start, fw_sysapi_mgr__phy_rx_statistics_cmd_start, fw_sysapi_mgr__start_energy_statistics, fw_sysapi_mgr__start_plcp_header, get_rx_pkt_phy_data_cmd_start, sched__apply_entry
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_req__is_claimable, fw_log_emit0, fw_sysapi__zero_and_fill, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__start_sysapi_cmd
fw_sysapi_mgr__start_sysapi_cmd:
	.global L_8f9a20
L_8f9a20:
	push_s blink
L_8f9a22:
	bl L_8c01dc
L_8f9a26:
	mov_s r14,r0
L_8f9a28:
	mov_s r16,r1
L_8f9a2a:
	mov_s r15,r2
L_8f9a2c:
	mov_s r13,0x0
L_8f9a2e:
	bl.d L_8f5cac
L_8f9a32:
	mov_s r1,r13
L_8f9a34:
	breq_s r0,0,L_8f9a46
L_8f9a36:
	mov_s r1,0x1012444
L_8f9a3c:
	bl.d L_8dcba8
L_8f9a40:
	mov_s r0,0x10
L_8f9a42:
	mov_s r0,r13
L_8f9a44:
	b_s L_8f9a72
	.global L_8f9a46
L_8f9a46:
	bl.d L_8f7ffc
L_8f9a4a:
	mov_s r0,r14
L_8f9a4c:
	mov_s r0,0x1
L_8f9a4e:
	st r16,[r14]
L_8f9a52:
	st_s r0,[r14,0x18]
L_8f9a54:
	mov_s r16,r0
L_8f9a56:
	st_s r13,[r14,0x1c]
L_8f9a58:
	ld_s r0,[r15,0x4]
L_8f9a5a:
	ld_s r1,[r15]
L_8f9a5c:
	st_s r0,[r14,0x8]
L_8f9a5e:
	mov_s r0,0x2
L_8f9a60:
	st_s r1,[r14,0x4]
L_8f9a62:
	st_s r0,[r14,0x20]
L_8f9a64:
	add r1,r14,0x24
L_8f9a68:
	mov_s r0,r13
L_8f9a6a:
	bl.d L_8e9900
L_8f9a6e:
	mov_s r2,r13
L_8f9a70:
	mov_s r0,r16
	.global L_8f9a72
L_8f9a72:
	b L_8c0244
L_8f9a76:
	nop_s
