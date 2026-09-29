/* l2mgr__send_notify_req_done @ 0x8dc7d0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_NOTIFY_REQ_DONE_EVENTID periodic_notif_handler().
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fill_statistics_to_host, fw_log__emit0, l2mgr__arm_notify_timer, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_notify_req_done,"ax",@progbits
	.global l2mgr__send_notify_req_done
l2mgr__send_notify_req_done:
L_8dc7d0:
	push_s blink
L_8dc7d2:
	bl L_8c02c4
L_8dc7d6:
	mov_s r13,r0
L_8dc7d8:
	mov_s r0,0x0
L_8dc7da:
	bl.d L_8c2b68
L_8dc7de:
	st_s r0,[r13,0x40]
L_8dc7e0:
	mov_s r14,r0
L_8dc7e2:
	mov_s r0,r13
L_8dc7e4:
	bl.d L_8c88d4
L_8dc7e8:
	mov_s r1,r14
L_8dc7ea:
	mov_s r2,0x1010f54
L_8dc7f0:
	mov_s r0,0xb
L_8dc7f2:
	bl.d L_8edfb0
L_8dc7f6:
	mov_s r1,0x2
L_8dc7f8:
	ld_s r0,[r13,0x4]
L_8dc7fa:
	mov_s r1,0x1863
L_8dc800:
	ld_s r3,[r0,0xc]
L_8dc802:
	mov_s r0,r14
L_8dc804:
	mov_s r2,0x2c
L_8dc806:
	ldb_s r3,[r3,0x10]
L_8dc808:
	mov r4,0x0
L_8dc80c:
	bl.d L_8e0874
L_8dc810:
	mov r5,r4
L_8dc814:
	ld_s r0,[r13,0x3c]
L_8dc816:
	cmp_s r0,0x0
L_8dc818:
	bl.ne.d L_8dfbe8
L_8dc81c:
	mov.ne r0,r13
L_8dc820:
	b L_8c0334
