/* l2mgr__send_pbss_joined_evt @ 0x8f6dac, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PBSS_JOINED_EVENTID for Direct Connection AID %d. fake key installation
 * Зовут его: mlme_sm__association_done
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw, memcpy_fw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_pbss_joined_evt
l2mgr__send_pbss_joined_evt:
	.global L_8f6dac
L_8f6dac:
	push_s blink
L_8f6dae:
	bl L_8c01e0
L_8f6db2:
	mov_s r13,r0
L_8f6db4:
	bl.d L_8c32d8
L_8f6db8:
	ld_s r15,[r0,0x18]
L_8f6dba:
	mov_s r14,r0
L_8f6dbc:
	bl.d L_8c1cd8
L_8f6dc0:
	mov_s r1,0xc
L_8f6dc2:
	add r1,r13,0x1c
L_8f6dc6:
	add_s r0,r14,0x2
L_8f6dc8:
	bl.d L_8c0380
L_8f6dcc:
	mov_s r2,0x6
L_8f6dce:
	ld_s r0,[r15,0x14]
L_8f6dd0:
	mov_s r1,0x100d398
L_8f6dd6:
	stb_s r0,[r14,0x8]
L_8f6dd8:
	ldb_s r0,[r13,0x8]
L_8f6dda:
	stb_s r0,[r14,0x9]
L_8f6ddc:
	ldb r0,[r15, 0x94]
L_8f6de0:
	stb_s r0,[r14]
L_8f6de2:
	mov_s r0,0x2b
L_8f6de4:
	bl.d L_8dcc10
L_8f6de8:
	ldb_s r2,[r13,0x9]
L_8f6dea:
	mov_s r0,r14
L_8f6dec:
	mov_s r1,0x15
L_8f6dee:
	mov_s r2,0xc
L_8f6df0:
	ldb_s r3,[r15,0x10]
L_8f6df2:
	mov r4,0x0
L_8f6df6:
	mov r5,r4
L_8f6dfa:
	bl.d L_8e5474
L_8f6dfe:
	mov r6,r4
L_8f6e02:
	b L_8c024c
L_8f6e06:
	nop_s
