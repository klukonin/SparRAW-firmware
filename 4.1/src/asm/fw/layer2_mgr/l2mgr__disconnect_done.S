/* l2mgr__disconnect_done @ 0x8eb270, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   L2MGR - CID %d disconnect done (reason = %d).
 *   L2MGR align PN# while disconnection CID %d!!!
 *   layer2_mgr.cpp
 * Зовут его: l2_mgr__link_up_evt
 * Зовёт сам: L2MGR__system_state_evt_handler, RADIO_MGR__unset_primary_channel, __ld_r17_to_r13_ret, __st_r17_to_r13, cnt_handler__clear_all, conn_mgr__link_down_evt, dashboard__on_disconnect, fw_log__emit1, fw_log__emit2, l2_mgr__chk_sys_idle, l2mgr__send_disconnect_evt, l2mgr__send_pbss_leave_evt
 */
	.section .text.l2mgr__disconnect_done,"ax",@progbits
	.global l2mgr__disconnect_done
l2mgr__disconnect_done:
	.global L_8eb270
L_8eb270:
	push_s blink
L_8eb272:
	bl L_8c02b8
L_8eb276:
	mov_s r14,r0
L_8eb278:
	mov_s r15,r1
L_8eb27a:
	ldb r16,[r0, 0x8]
L_8eb27e:
	ld_s r0,[r0,0xc]
L_8eb280:
	extb r17,r1
L_8eb284:
	ldb_s r13,[r0,0x10]
L_8eb286:
	bl.d L_8ca1b0
L_8eb28a:
	mov_s r0,r13
L_8eb28c:
	ldb_s r3,[r14,0x8]
L_8eb28e:
	mov_s r2,0x100c414
L_8eb294:
	mov_s r0,0xb
L_8eb296:
	mov_s r1,0x2
L_8eb298:
	bl.d L_8edff8
L_8eb29c:
	mov r4,r17
L_8eb2a0:
	cmp r17,0x1
L_8eb2a4:
	bl.eq L_8eac48
L_8eb2a8:
	ldb_s r1,[r14,0x8]
L_8eb2aa:
	mov_s r0,0x0
L_8eb2ac:
	bset r0,r0,r1
L_8eb2b0:
	bl.d L_8c2fe4
L_8eb2b4:
	extb_s r0,r0
L_8eb2b6:
	mov_s r2,0x100c444
L_8eb2bc:
	mov_s r0,0xb
L_8eb2be:
	mov_s r1,0x2
L_8eb2c0:
	bl.d L_8edfcc
L_8eb2c4:
	ldb_s r3,[r14,0x8]
L_8eb2c6:
	ldb_s r0,[r14,0x8]
L_8eb2c8:
	mov_s r1,0x0
L_8eb2ca:
	bl.d L_8e4fc8
L_8eb2ce:
	mov_s r2,r1
L_8eb2d0:
	ld_s r0,[r14,0xc]
L_8eb2d2:
	bl.d L_8ca1f8
L_8eb2d6:
	mov_s r1,0x1
L_8eb2d8:
	cmp_s r0,0x0
L_8eb2da:
	bl.eq L_8d762c
L_8eb2de:
	ld_s r0,[r14,0x1c]
L_8eb2e0:
	breq_s r0,0,L_8eb2ea
L_8eb2e2:
	bl.d L_8f0720
L_8eb2e6:
	mov_s r0,r14
L_8eb2e8:
	b_s L_8eb2fc
	.global L_8eb2ea
L_8eb2ea:
	add r0,r14,0x10
L_8eb2ee:
	ld_s r3,[r14,0xc]
L_8eb2f0:
	lsr r1,r15,0x10
L_8eb2f4:
	mov_s r2,r17
L_8eb2f6:
	bl.d L_8f051c
L_8eb2fa:
	ldb_s r3,[r3,0x10]
	.global L_8eb2fc
L_8eb2fc:
	bl L_8d99e0
L_8eb300:
	bl.d L_8d79cc
L_8eb304:
	mov_s r0,r14
L_8eb306:
	bl.d L_8e35cc
L_8eb30a:
	mov_s r0,0x4
L_8eb30c:
	bl.d L_8d73c4
L_8eb310:
	mov_s r0,r13
L_8eb312:
	brne_s r0,0,L_8eb31c
L_8eb314:
	ld_s r0,[r14,0x1c]
L_8eb316:
	cmp_s r0,0x0
L_8eb318:
	bl.eq L_8e5568
	.global L_8eb31c
L_8eb31c:
	bl.d L_8e426c
L_8eb320:
	mov_s r0,0x0
L_8eb322:
	bl.d L_8e5820
L_8eb326:
	mov_s r0,r16
L_8eb328:
	bl L_8c5838
L_8eb32c:
	ld_s r0,[r14,0x1c]
L_8eb32e:
	cmp_s r0,0x0
L_8eb330:
	mov.eq r0,0x8
L_8eb334:
	bl.eq.d L_8e3a08
L_8eb338:
	mov.eq r1,0x0
L_8eb33c:
	breq r17,0x1,L_8eb350
L_8eb340:
	breq r17,0x0,L_8eb348
	.global L_8eb344
L_8eb344:
	b L_8c031c
	.global L_8eb348
L_8eb348:
	bl.d L_8d73c4
L_8eb34c:
	mov_s r0,r13
L_8eb34e:
	brne_s r0,0,L_8eb344
	.global L_8eb350
L_8eb350:
	mov_s r0,blink
L_8eb352:
	mov_s r2,0x100c474
L_8eb358:
	mov_s r1,0x11d7
L_8eb35e:
	bl.d L_8c8208
L_8eb362:
	mov r3,0x1d9
L_8eb366:
	b_s L_8eb344
