/* l2_mgr__wmi_cmd_handler_new_sta @ 0x8ec2b8, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_new_sta:  DST MAC: ADDR-%04X%08X
 *   NEW_STA_CMD recieved in local mode
 *   NEW_STA: found STA, inject new_sta event
 *   NEW_STA: STA doesn't exist
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit2, l2mgr__send_disconnect_evt, mid_list__by_mid_fw, mid_list__find_by
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__wmi_cmd_handler_new_sta
l2_mgr__wmi_cmd_handler_new_sta:
	.global L_8ec2b8
L_8ec2b8:
	push_s blink
L_8ec2ba:
	bl L_8c01e0
L_8ec2be:
	mov_s r13,r0
L_8ec2c0:
	mov_s r15,r1
L_8ec2c2:
	ldb_s r0,[r13,0x5]
L_8ec2c4:
	ldb_s r2,[r13,0x4]
L_8ec2c6:
	asl_s r0,r0,0x8
L_8ec2c8:
	or_s r2,r2,r0
L_8ec2ca:
	ldb_s r0,[r13,0x1]
L_8ec2cc:
	ldb_s r3,[r13]
L_8ec2ce:
	asl_s r0,r0,0x8
L_8ec2d0:
	or_s r3,r3,r0
L_8ec2d2:
	ldb_s r0,[r13,0x2]
L_8ec2d4:
	mov_s r1,0x100e428
L_8ec2da:
	asl_s r0,r0,0x10
L_8ec2dc:
	or_s r3,r3,r0
L_8ec2de:
	ldb_s r0,[r13,0x3]
L_8ec2e0:
	asl_s r0,r0,0x18
L_8ec2e2:
	or_s r3,r3,r0
L_8ec2e4:
	bl.d L_8dcc80
L_8ec2e8:
	mov_s r0,0x2b
L_8ec2ea:
	mov_s r0,0x803c20
L_8ec2f0:
	ldb_s r0,[r0,0x8]
L_8ec2f2:
	brne_s r0,0,L_8ec2fe
L_8ec2f4:
	mov_s r1,0x100e464
L_8ec2fa:
	mov_s r0,0xb
L_8ec2fc:
	b_s L_8ec336
	.global L_8ec2fe
L_8ec2fe:
	bl.d L_8cc3dc
L_8ec302:
	mov_s r0,r15
L_8ec304:
	bl.d L_8cc024
L_8ec308:
	mov_s r1,r13
L_8ec30a:
	mov.f r14,r0
L_8ec30e:
	beq_s L_8ec32e
L_8ec310:
	mov_s r1,0x100e488
L_8ec316:
	bl.d L_8dcba8
L_8ec31a:
	mov_s r0,0x2b
L_8ec31c:
	add3 r0,r14,0x1e
L_8ec320:
	mov_s r1,0xb
L_8ec322:
	mov_s r2,r13
L_8ec324:
	mov_s r3,0x0
L_8ec326:
	bl.d L_8d9b6c
L_8ec32a:
	mov_s r4,r3
L_8ec32c:
	b_s L_8ec346
	.global L_8ec32e
L_8ec32e:
	mov_s r1,0x100e4b4
L_8ec334:
	mov_s r0,0x2b
	.global L_8ec336
L_8ec336:
	bl L_8dcba8
L_8ec33a:
	mov_s r0,r13
L_8ec33c:
	mov_s r1,0x1
L_8ec33e:
	mov_s r2,0x6
L_8ec340:
	bl.d L_8e538c
L_8ec344:
	mov_s r3,r15
	.global L_8ec346
L_8ec346:
	b L_8c024c
L_8ec34a:
	nop_s
