/* host_if__periodic_notif_handler @ 0x8e0a20, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_NOTIFY_REQ_DONE_EVENTID periodic_notif_handler().
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, host_if__send_pair, l2mgr__arm_notify_timer, link_stats__fill_sta_entry, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__periodic_notif_handler
host_if__periodic_notif_handler:
	.global L_8e0a20
L_8e0a20:
	push_s blink
L_8e0a22:
	bl L_8c01e4
L_8e0a26:
	mov_s r13,r0
L_8e0a28:
	mov_s r0,0x0
L_8e0a2a:
	bl.d L_8c32d8
L_8e0a2e:
	st_s r0,[r13,0x74]
L_8e0a30:
	mov_s r14,r0
L_8e0a32:
	mov_s r0,r13
L_8e0a34:
	bl.d L_8ca554
L_8e0a38:
	mov_s r1,r14
L_8e0a3a:
	mov_s r1,0x10143cc
L_8e0a40:
	bl.d L_8dcba8
L_8e0a44:
	mov_s r0,0x2b
L_8e0a46:
	ld_s r0,[r13,0x4]
L_8e0a48:
	mov_s r1,0x1863
L_8e0a4e:
	ld_s r3,[r0,0x18]
L_8e0a50:
	mov_s r0,r14
L_8e0a52:
	mov_s r2,0x2c
L_8e0a54:
	ldb_s r3,[r3,0x10]
L_8e0a56:
	mov r4,0x0
L_8e0a5a:
	mov r5,r4
L_8e0a5e:
	bl.d L_8e5474
L_8e0a62:
	mov r6,r4
L_8e0a66:
	ld_s r0,[r13,0x70]
L_8e0a68:
	cmp_s r0,0x0
L_8e0a6a:
	bl.ne.d L_8e48a4
L_8e0a6e:
	mov.ne r0,r13
L_8e0a72:
	b L_8c0254
L_8e0a76:
	nop_s
