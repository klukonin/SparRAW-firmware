/* low_sme__wmi_scan_cmd_handler @ 0x8e7b18, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   low_sme::wmi_scan_cmd_handler cmd.direct_scan_mac_addr: ADDR-%04X%08X
 *   [NNL] cmd.dwell_time: %d, cmd->force_scan_interval %d
 *   [NNL] cmd.scan_type: %d, cmd->num_channels %d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd, tx_probe__send_scan_complete
 */
	.section .text.low_sme__wmi_scan_cmd_handler,"ax",@progbits
	.global low_sme__wmi_scan_cmd_handler
low_sme__wmi_scan_cmd_handler:
	.global L_8e7b18
L_8e7b18:
	push_s blink
L_8e7b1a:
	bl L_8c02c4
L_8e7b1e:
	mov_s r13,r0
L_8e7b20:
	ld_s r0,[gp,-0xa4]
L_8e7b22:
	mov_s r14,r1
L_8e7b24:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e7b26:
	st.as r0,[gp,-0x29]
L_8e7b2a:
	mov_s r2,0x100a3d0
L_8e7b30:
	ldw_s r0,[r13,0x2]
L_8e7b32:
	ldw r4,[r13]
L_8e7b36:
	asl_s r0,r0,0x10
L_8e7b38:
	or r4,r4,r0
L_8e7b3c:
	mov_s r0,0x9
L_8e7b3e:
	mov_s r1,0x2
L_8e7b40:
	bl.d L_8edff8
L_8e7b44:
	ldw_s r3,[r13,0x4]
L_8e7b46:
	mov_s r2,0x100a418
L_8e7b4c:
	ldw_s r0,[r13,0xa]
L_8e7b4e:
	ldw_s r3,[r13,0x8]
L_8e7b50:
	asl_s r0,r0,0x10
L_8e7b52:
	or_s r3,r3,r0
L_8e7b54:
	ldw_s r0,[r13,0xe]
L_8e7b56:
	ldw r4,[r13, 0xc]
L_8e7b5a:
	asl_s r0,r0,0x10
L_8e7b5c:
	or r4,r4,r0
L_8e7b60:
	mov_s r0,0x9
L_8e7b62:
	bl.d L_8edff8
L_8e7b66:
	mov_s r1,0x2
L_8e7b68:
	mov_s r2,0x100a450
L_8e7b6e:
	ldb r4,[r13, 0x11]
L_8e7b72:
	mov_s r0,0x9
L_8e7b74:
	mov_s r1,0x2
L_8e7b76:
	bl.d L_8edff8
L_8e7b7a:
	ldb_s r3,[r13,0x10]
L_8e7b7c:
	bl.d L_8f29dc
L_8e7b80:
	mov_s r0,r14
L_8e7b82:
	breq_s r0,0,L_8e7b94
L_8e7b84:
	ldb_s r0,[r13,0x11]
L_8e7b86:
	brlt r0,0x1,L_8e7b94
L_8e7b8a:
	mov_s r0,r13
L_8e7b8c:
	bl.d L_8f3710
L_8e7b90:
	mov_s r1,r14
L_8e7b92:
	b_s L_8e7b9c
	.global L_8e7b94
L_8e7b94:
	mov_s r0,0x3
L_8e7b96:
	bl.d L_8f0980
L_8e7b9a:
	mov_s r1,r14
	.global L_8e7b9c
L_8e7b9c:
	b L_8c0334
