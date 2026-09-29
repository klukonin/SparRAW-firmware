/* vring_schd__disconnect_notify @ 0x8c91b8, 328 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI Disconnect MID:[%d] reason = %d  protocol %d
 *   Not found another to run, so #%d V-ring is re-connected now.
 * Зовут его: discovery_handle_probe_req, dpal__cpl_timeout_evt, low_sme__handle_rf_kill
 * Зовёт сам: __ld_r15_to_r13_ret, __ld_r17_to_r13_ret, __st_r15_to_r13, __st_r17_to_r13, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, hwd_dma__get_881c80, list__find_entry_d, llist__pop_front, macq_hw__disable_queue_fw, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__disconnect_notify
vring_schd__disconnect_notify:
	.global L_8c91b8
L_8c91b8:
	push_s blink
L_8c91ba:
	bl L_8c01e0
L_8c91be:
	mov.f r15,r0
L_8c91c2:
	mov.ne r15,0x1
L_8c91c6:
	mov_s r14,0x0
L_8c91c8:
	b_s L_8c91f6
	.global L_8c91ca
L_8c91ca:
	bl.d L_8cc3dc
L_8c91ce:
	mov_s r0,r14
L_8c91d0:
	mov.f r13,r0
L_8c91d4:
	beq_s L_8c91f4
L_8c91d6:
	mov_s r1,0x100d600
L_8c91dc:
	mov_s r0,0x2b
L_8c91de:
	mov_s r2,r14
L_8c91e0:
	add_s r3,r15,0x1
L_8c91e2:
	bl.d L_8dcd00
L_8c91e6:
	mov r4,0x3
L_8c91ea:
	mov_s r0,r13
L_8c91ec:
	add_s r1,r15,0x1
L_8c91ee:
	bl.d L_8c9110
L_8c91f2:
	mov_s r2,0x3
	.global L_8c91f4
L_8c91f4:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8c91f6
L_8c91f6:
	brlt r14,0x1,L_8c91ca
L_8c91fa:
	b L_8c024c
L_8c91fe:
	nop_s
L_8c9200:
	push_s blink
L_8c9202:
	bl.d L_8c01d8
L_8c9206:
	mul64 r0,0x3c
L_8c920a:
	mov_s r16,r0
L_8c920c:
	mov_s r13,0x804dbc
L_8c9212:
	add r0,r13,0x28
L_8c9216:
	add r17,r0,mlo
L_8c921a:
	ld r14,[r17, 0x14]
L_8c921e:
	breq_s r14,0,L_8c9252
	.global L_8c9220
L_8c9220:
	mov_s r0,r14
L_8c9222:
	mov_s r15,0x0
L_8c9224:
	bl.d L_8eaa38
L_8c9228:
	mov_s r1,r15
L_8c922a:
	st r15,[r17, 0x14]
L_8c922e:
	breq r16,0x1,L_8c92dc
L_8c9232:
	mov_s r3,0x2
L_8c9234:
	b_s L_8c9248
	.global L_8c9236
L_8c9236:
	asl_s r1,r3,0x2
L_8c9238:
	add1_s r1,r1,r1
L_8c923a:
	add r0,r13,0x10
L_8c923e:
	add r4,r0,r1
L_8c9242:
	ld r15,[r4, 0x4]
L_8c9246:
	brne_s r15,0,L_8c9260
	.global L_8c9248
L_8c9248:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8c924a:
	cmp r3,-0x1
L_8c924e:
	bne_s L_8c9236
L_8c9250:
	b_s L_8c927a
	.global L_8c9252
L_8c9252:
	mov_s r0,blink
L_8c9254:
	mov_s r1,0x12af
L_8c925a:
	bl L_8c9b28
L_8c925e:
	b_s L_8c9220
	.global L_8c9260
L_8c9260:
	mov_s r0,r13
L_8c9262:
	bl.d L_8c655c
L_8c9266:
	ldb_s r1,[r15,0xa]
L_8c9268:
	brne_s r0,0,L_8c9248
L_8c926a:
	bl.d L_8e2674
L_8c926e:
	mov_s r0,r4
L_8c9270:
	mov_s r0,r13
L_8c9272:
	mov_s r1,r15
L_8c9274:
	bl.d L_8c7160
L_8c9278:
	mov_s r2,r17
	.global L_8c927a
L_8c927a:
	ld_s r1,[r14,0x20]
L_8c927c:
	cmp_s r1,0x1
L_8c927e:
	mov_s r1,0x1
L_8c9280:
	sub_s.ne r1,r1,r1
L_8c9282:
	ldb_s r0,[r14,0x9]
L_8c9284:
	brne r1,0x1,L_8c92ce
L_8c9288:
	bl L_8d0894
L_8c928c:
	brne r0,0x1,L_8c92ce
L_8c9290:
	brne_s r15,0,L_8c929c
L_8c9292:
	mov_s r0,r13
L_8c9294:
	bl.d L_8c655c
L_8c9298:
	ldb_s r1,[r14,0xa]
L_8c929a:
	breq_s r0,0,L_8c92b4
	.global L_8c929c
L_8c929c:
	ldb_s r1,[r14,0xb]
L_8c929e:
	add r0,r13,0x10
L_8c92a2:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8c92a4:
	add1_s r1,r1,r1
L_8c92a6:
	add_s r0,r0,r1
L_8c92a8:
	bl.d L_8c25f4
L_8c92ac:
	mov_s r1,r14
L_8c92ae:
	mov_s r0,0x2
L_8c92b0:
	st_s r0,[r14,0x24]
L_8c92b2:
	b_s L_8c92dc
	.global L_8c92b4
L_8c92b4:
	mov_s r1,0x100bc3c
L_8c92ba:
	mov_s r0,0x27
L_8c92bc:
	bl.d L_8dcc10
L_8c92c0:
	ldb_s r2,[r14,0x9]
L_8c92c2:
	mov_s r0,r13
L_8c92c4:
	mov_s r1,r14
L_8c92c6:
	bl.d L_8c7160
L_8c92ca:
	mov_s r2,r17
L_8c92cc:
	b_s L_8c92dc
	.global L_8c92ce
L_8c92ce:
	add_s r0,r13,0x4
L_8c92d0:
	bl.d L_8c25f4
L_8c92d4:
	mov_s r1,r14
L_8c92d6:
	bl.d L_8d85d4
L_8c92da:
	mov_s r0,r14
	.global L_8c92dc
L_8c92dc:
	mov_s r0,L_8e23a4-0x8c0000
L_8c92e2:
	ldb_s r1,[r14,0x9]
L_8c92e4:
	mov_s r2,0x0
L_8c92e6:
	bl.d L_8c3248
L_8c92ea:
	mov_s r3,0x1
L_8c92ec:
	ld r0,[r17, 0x14]
L_8c92f0:
	cmp_s r0,0x0
L_8c92f2:
	bl.eq.d L_8d0c9c
L_8c92f6:
	mov.eq r0,r16
L_8c92fa:
	b L_8c023c
L_8c92fe:
	nop_s
