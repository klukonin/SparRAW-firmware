/* pcp_psc_sm__send_usol_psc_resp_sm @ 0x8e5d48, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SCAN_COMPLETE_EVENTID status %d, devid %d
 * Зовут его: low_sme__wmi_scan_cmd_handler, scan_mngr__scan_done, wmi_abort_scan
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, host_if__send_pair, l2mgr__pending_op_clear, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_psc_sm__send_usol_psc_resp_sm
pcp_psc_sm__send_usol_psc_resp_sm:
	.global L_8e5d48
L_8e5d48:
	push_s blink
L_8e5d4a:
	bl L_8c01e0
L_8e5d4e:
	mov_s r14,r0
L_8e5d50:
	bl.d L_8c32d8
L_8e5d54:
	mov_s r15,r1
L_8e5d56:
	mov_s r13,r0
L_8e5d58:
	st_s r14,[r0]
L_8e5d5a:
	mov_s r1,0x100eb24
L_8e5d60:
	mov_s r0,0x2b
L_8e5d62:
	mov_s r2,r14
L_8e5d64:
	bl.d L_8dcc80
L_8e5d68:
	mov_s r3,r15
L_8e5d6a:
	mov_s r0,r13
L_8e5d6c:
	mov_s r1,0xa
L_8e5d6e:
	bset_s r1,r1,0xc
L_8e5d70:
	mov_s r2,0x4
L_8e5d72:
	mov_s r3,r15
L_8e5d74:
	mov r4,0x0
L_8e5d78:
	mov r5,r4
L_8e5d7c:
	bl.d L_8e5474
L_8e5d80:
	mov r6,r4
L_8e5d84:
	bl.d L_8c6a30
L_8e5d88:
	mov_s r0,0x0
L_8e5d8a:
	b L_8c024c
L_8e5d8e:
	nop_s
