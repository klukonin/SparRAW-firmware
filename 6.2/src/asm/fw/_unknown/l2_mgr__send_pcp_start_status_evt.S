/* l2_mgr__send_pcp_start_status_evt @ 0x8f8a3c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::send_pcp_start_status_evt(WMI_FW_STATUS_FAILURE): number_of_pcps = %d
 *   l2_mgr::send_pcp_start_status_evt: last PCP removed
 *   <<---- [HOST EVENT] WMI_PCP_STARTED_EVENTID for midid %d, status %d  <ts: %d>.
 * Зовут его: l2_mgr__pcp_start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit3, host_if__send_pair, l2_mgr__has_active_pcp, l2mgr__pending_op_clear, low_sme__send_evt2sw, memset0_words, u_schd__now
 * Глобалы (через gp): 0x80025a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__send_pcp_start_status_evt
l2_mgr__send_pcp_start_status_evt:
	.global L_8f8a3c
L_8f8a3c:
	push_s blink
L_8f8a3e:
	bl L_8c01e0
L_8f8a42:
	mov_s r13,r0
L_8f8a44:
	bl.d L_8c32d8
L_8f8a48:
	mov_s r15,r1
L_8f8a4a:
	mov_s r14,r0
L_8f8a4c:
	brne r13,0x1,L_8f8a78
L_8f8a50:
	ldb_s r0,[gp,0xd6]
L_8f8a52:
	mov_s r1,0x100ec90
L_8f8a58:
	sub_s r2,r0,0x1
L_8f8a5a:
	extb_s r2,r2
L_8f8a5c:
	stb r2,[gp, 0xd6]
L_8f8a60:
	bl.d L_8dcc10
L_8f8a64:
	mov_s r0,0x1b
L_8f8a66:
	bl L_8da47c
L_8f8a6a:
	brne_s r0,0,L_8f8a78
L_8f8a6c:
	mov_s r1,0x100ece0
L_8f8a72:
	bl.d L_8dcba8
L_8f8a76:
	mov_s r0,0x2b
	.global L_8f8a78
L_8f8a78:
	mov_s r0,r14
L_8f8a7a:
	bl.d L_8c1cd8
L_8f8a7e:
	mov_s r1,0x4
L_8f8a80:
	bl.d L_8e9524
L_8f8a84:
	stb_s r13,[r14]
L_8f8a86:
	mov_s r4,r0
L_8f8a88:
	mov_s r1,0x100ed14
L_8f8a8e:
	mov_s r0,0x2b
L_8f8a90:
	mov_s r2,r15
L_8f8a92:
	bl.d L_8dcd00
L_8f8a96:
	mov_s r3,r13
L_8f8a98:
	mov_s r0,r14
L_8f8a9a:
	mov_s r1,0x1918
L_8f8aa0:
	mov_s r2,0x4
L_8f8aa2:
	mov_s r3,r15
L_8f8aa4:
	mov r4,0x0
L_8f8aa8:
	mov r5,r4
L_8f8aac:
	bl.d L_8e5474
L_8f8ab0:
	mov r6,r4
L_8f8ab4:
	bl.d L_8c6a30
L_8f8ab8:
	mov_s r0,0x3
L_8f8aba:
	b L_8c024c
L_8f8abe:
	nop_s
