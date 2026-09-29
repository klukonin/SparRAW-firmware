/* l2mgr__send_pbss_leave_evt @ 0x8f89ec, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PBSS_LEAVE_EVENTID pbss leave event done. CID: %d
 * Зовут его: mlme_sm__disconnect_ev_handle
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_pbss_leave_evt
l2mgr__send_pbss_leave_evt:
	.global L_8f89ec
L_8f89ec:
	push_s blink
L_8f89ee:
	bl L_8c01e0
L_8f89f2:
	bl.d L_8c32d8
L_8f89f6:
	mov_s r13,r0
L_8f89f8:
	mov_s r14,r0
L_8f89fa:
	ld_s r0,[r13,0x18]
L_8f89fc:
	add r1,r13,0x1c
L_8f8a00:
	ld_s r0,[r0,0x14]
L_8f8a02:
	stb_s r0,[r14,0x6]
L_8f8a04:
	ldb_s r15,[r13,0x8]
L_8f8a06:
	mov_s r0,r14
L_8f8a08:
	stb_s r15,[r14,0x7]
L_8f8a0a:
	bl.d L_8c0380
L_8f8a0e:
	mov_s r2,0x6
L_8f8a10:
	mov_s r1,0x100d268
L_8f8a16:
	mov_s r0,0x2b
L_8f8a18:
	bl.d L_8dcc10
L_8f8a1c:
	mov_s r2,r15
L_8f8a1e:
	ld_s r3,[r13,0x18]
L_8f8a20:
	mov_s r0,r14
L_8f8a22:
	mov_s r1,0x16
L_8f8a24:
	mov_s r2,0xa
L_8f8a26:
	ldb_s r3,[r3,0x10]
L_8f8a28:
	mov r4,0x0
L_8f8a2c:
	mov r5,r4
L_8f8a30:
	bl.d L_8e5474
L_8f8a34:
	mov r6,r4
L_8f8a38:
	b L_8c024c
