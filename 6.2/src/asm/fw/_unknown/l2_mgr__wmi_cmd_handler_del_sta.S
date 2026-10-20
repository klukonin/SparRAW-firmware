/* l2_mgr__wmi_cmd_handler_del_sta @ 0x8ec184, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_del_sta: reason:%d  DST MAC: ADDR-%04X%08X
 *   DEL_STA_CMD recieved in local mode
 *   DEL_STA not-exist STA
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit3, l2mgr__pending_op_set, l2mgr__send_disconnect_evt, mid_list__by_mid_fw, mid_list__find_by
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__wmi_cmd_handler_del_sta
l2_mgr__wmi_cmd_handler_del_sta:
	.global L_8ec184
L_8ec184:
	push_s blink
L_8ec186:
	bl L_8c01e4
L_8ec18a:
	mov_s r13,r0
L_8ec18c:
	mov_s r14,r1
L_8ec18e:
	mov_s r1,0x100e4d0
L_8ec194:
	ldw_s r0,[r13,0x2]
L_8ec196:
	ldw r4,[r13]
L_8ec19a:
	asl_s r0,r0,0x10
L_8ec19c:
	or r4,r4,r0
L_8ec1a0:
	ldw_s r2,[r13,0x6]
L_8ec1a2:
	mov_s r0,0x2b
L_8ec1a4:
	bl.d L_8dcd00
L_8ec1a8:
	ldw_s r3,[r13,0x4]
L_8ec1aa:
	mov_s r0,0x803c20
L_8ec1b0:
	ldb_s r0,[r0,0x8]
L_8ec1b2:
	brne_s r0,0,L_8ec1be
L_8ec1b4:
	mov_s r1,0x100e514
L_8ec1ba:
	mov_s r0,0xb
L_8ec1bc:
	b_s L_8ec1ec
	.global L_8ec1be
L_8ec1be:
	bl.d L_8e6358
L_8ec1c2:
	mov_s r0,0x5
L_8ec1c4:
	bl.d L_8cc3dc
L_8ec1c8:
	mov_s r0,r14
L_8ec1ca:
	bl.d L_8cc024
L_8ec1ce:
	mov_s r1,r13
L_8ec1d0:
	breq_s r0,0,L_8ec1e4
L_8ec1d2:
	add r0,r0,0xf0
L_8ec1d6:
	mov_s r1,0xd
L_8ec1d8:
	mov_s r2,r13
L_8ec1da:
	mov_s r3,0x0
L_8ec1dc:
	bl.d L_8d9b6c
L_8ec1e0:
	mov_s r4,r3
L_8ec1e2:
	b_s L_8ec1fc
	.global L_8ec1e4
L_8ec1e4:
	mov_s r1,0x100e538
L_8ec1ea:
	mov_s r0,0x1b
	.global L_8ec1ec
L_8ec1ec:
	bl L_8dcba8
L_8ec1f0:
	mov_s r0,r13
L_8ec1f2:
	mov_s r1,0x1
L_8ec1f4:
	mov_s r2,0x2
L_8ec1f6:
	bl.d L_8e538c
L_8ec1fa:
	mov_s r3,r14
	.global L_8ec1fc
L_8ec1fc:
	b L_8c0254
