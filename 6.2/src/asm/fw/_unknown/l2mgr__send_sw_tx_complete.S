/* l2mgr__send_sw_tx_complete @ 0x8f8e50, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SW_TX_COMPLETE_EVENTID for devid %d (status %d).
 * Зовут его: wmi_sw_tx_req
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, host_if__send_pair, low_sme__send_evt2sw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_sw_tx_complete
l2mgr__send_sw_tx_complete:
	.global L_8f8e50
L_8f8e50:
	push_s blink
L_8f8e52:
	bl L_8c01e0
L_8f8e56:
	mov_s r14,r0
L_8f8e58:
	bl.d L_8c32d8
L_8f8e5c:
	mov_s r15,r1
L_8f8e5e:
	mov_s r13,r0
L_8f8e60:
	bl.d L_8c1cd8
L_8f8e64:
	mov_s r1,0x4
L_8f8e66:
	stb_s r14,[r13]
L_8f8e68:
	mov_s r1,0x100dc84
L_8f8e6e:
	mov_s r0,0x2b
L_8f8e70:
	mov_s r2,r15
L_8f8e72:
	bl.d L_8dcc80
L_8f8e76:
	mov_s r3,r14
L_8f8e78:
	mov_s r0,r13
L_8f8e7a:
	mov_s r1,0x182b
L_8f8e80:
	mov_s r2,0x4
L_8f8e82:
	mov_s r3,r15
L_8f8e84:
	mov r4,0x0
L_8f8e88:
	mov r5,r4
L_8f8e8c:
	bl.d L_8e5474
L_8f8e90:
	mov r6,r4
L_8f8e94:
	b L_8c024c
