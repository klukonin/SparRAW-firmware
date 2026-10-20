/* low_sme__wmi_scan_cmd_handler @ 0x8ecb1c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   low_sme::wmi_scan_cmd_handler cmd.direct_scan_mac_addr: ADDR-%04X%08X
 *   [NNL] cmd.dwell_time: %d, cmd->force_scan_interval %d
 *   [NNL] cmd.scan_type: %d, cmd->num_channels %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd, pcp_psc_sm__send_usol_psc_resp_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global low_sme__wmi_scan_cmd_handler
low_sme__wmi_scan_cmd_handler:
	.global L_8ecb1c
L_8ecb1c:
	push_s blink
L_8ecb1e:
	bl L_8c01e4
L_8ecb22:
	mov_s r13,r0
L_8ecb24:
	ld_s r0,[gp,-0xb4]
L_8ecb26:
	mov_s r14,r1
L_8ecb28:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ecb2a:
	st.as r0,[gp,-0x2d]
L_8ecb2e:
	mov_s r1,0x100b970
L_8ecb34:
	ldw_s r0,[r13,0x2]
L_8ecb36:
	ldw_s r3,[r13]
L_8ecb38:
	asl_s r0,r0,0x10
L_8ecb3a:
	or_s r3,r3,r0
L_8ecb3c:
	mov_s r0,0x29
L_8ecb3e:
	bl.d L_8dcc80
L_8ecb42:
	ldw_s r2,[r13,0x4]
L_8ecb44:
	mov_s r1,0x100b9b8
L_8ecb4a:
	ldw_s r0,[r13,0xa]
L_8ecb4c:
	ldw_s r2,[r13,0x8]
L_8ecb4e:
	asl_s r0,r0,0x10
L_8ecb50:
	or_s r2,r2,r0
L_8ecb52:
	ldw_s r0,[r13,0xe]
L_8ecb54:
	ldw_s r3,[r13,0xc]
L_8ecb56:
	asl_s r0,r0,0x10
L_8ecb58:
	or_s r3,r3,r0
L_8ecb5a:
	bl.d L_8dcc80
L_8ecb5e:
	mov_s r0,0x29
L_8ecb60:
	ldb_s r2,[r13,0x10]
L_8ecb62:
	mov_s r1,0x100b9f0
L_8ecb68:
	mov_s r0,0x29
L_8ecb6a:
	bl.d L_8dcc80
L_8ecb6e:
	ldb_s r3,[r13,0x11]
L_8ecb70:
	bl.d L_8ebbc8
L_8ecb74:
	mov_s r0,r14
L_8ecb76:
	breq_s r0,0,L_8ecb88
L_8ecb78:
	ldb_s r0,[r13,0x11]
L_8ecb7a:
	brlt r0,0x1,L_8ecb88
L_8ecb7e:
	mov_s r0,r13
L_8ecb80:
	bl.d L_8eca58
L_8ecb84:
	mov_s r1,r14
L_8ecb86:
	b_s L_8ecb90
	.global L_8ecb88
L_8ecb88:
	mov_s r0,0x3
L_8ecb8a:
	bl.d L_8e5d48
L_8ecb8e:
	mov_s r1,r14
	.global L_8ecb90
L_8ecb90:
	b L_8c0254
