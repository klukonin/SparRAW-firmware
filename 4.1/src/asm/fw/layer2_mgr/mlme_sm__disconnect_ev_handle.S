/* mlme_sm__disconnect_ev_handle @ 0x8eb368, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Associate REQ accompanied.
 *   Handle disconnect State %d (reason %d)
 *   Send disassociate to remote!!!
 *   mlme_sm::disconnect_ev_handle()  remove_request 0x%x ,locked: 0x%x
 *   MLME_UNLOCK_RADIO - unlocking radio 0x%x
 *   MLME_UNLOCK_RADIO - remove request 0x%x
 * Зовёт сам: RADIO_MGR__remove_request, RADIO_MGR__unlock, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, mgmt_buf__free, mgmt_pkt__release, mlme_notify, mlme_sm__send_disassoc, u_schd__cancel
 */
	.section .text.mlme_sm__disconnect_ev_handle,"ax",@progbits
	.global mlme_sm__disconnect_ev_handle
mlme_sm__disconnect_ev_handle:
L_8eb368:
	push_s blink
L_8eb36a:
	bl L_8c02bc
L_8eb36e:
	mov_s r14,r0
L_8eb370:
	mov.f r13,r1
L_8eb374:
	mov_s r16,r2
L_8eb376:
	mov_s r15,r3
L_8eb378:
	beq_s L_8eb394
L_8eb37a:
	mov_s r2,0x100f5e8
L_8eb380:
	mov_s r0,0xa
L_8eb382:
	bl.d L_8edfb0
L_8eb386:
	mov_s r1,0x2
L_8eb388:
	bl.d L_8c955c
L_8eb38c:
	mov_s r0,r13
L_8eb38e:
	bl.d L_8c9538
L_8eb392:
	mov_s r0,r13
	.global L_8eb394
L_8eb394:
	ldb_s r3,[r14]
L_8eb396:
	mov_s r2,0x100f604
L_8eb39c:
	mov_s r0,0xa
L_8eb39e:
	mov_s r1,0x2
L_8eb3a0:
	bl.d L_8edff8
L_8eb3a4:
	mov r4,r16
L_8eb3a8:
	ld_s r0,[r14,0x30]
L_8eb3aa:
	brne r0,0x1,L_8eb3d0
L_8eb3ae:
	mov_s r2,0x100f62c
L_8eb3b4:
	mov_s r0,0xa
L_8eb3b6:
	bl.d L_8edfb0
L_8eb3ba:
	mov_s r1,0x2
L_8eb3bc:
	breq_s r15,0,L_8eb3c6
L_8eb3be:
	ld_s r1,[r14,0x3c]
L_8eb3c0:
	mov_s r0,0x1
L_8eb3c2:
	st.as r0,[r1,0x5a]
	.global L_8eb3c6
L_8eb3c6:
	mov_s r0,r14
L_8eb3c8:
	mov_s r1,r16
L_8eb3ca:
	bl.d L_8ee7fc
L_8eb3ce:
	mov_s r2,r15
	.global L_8eb3d0
L_8eb3d0:
	mov_s r13,0x0
L_8eb3d2:
	st_s r13,[r14,0x30]
L_8eb3d4:
	mov_s r2,0x100f64c
L_8eb3da:
	ld r4,[r14, 0x2c]
L_8eb3de:
	mov_s r0,r13
L_8eb3e0:
	mov_s r1,0x2
L_8eb3e2:
	bl.d L_8edff8
L_8eb3e6:
	ld_s r3,[r14,0x34]
L_8eb3e8:
	ld_s r3,[r14,0x34]
L_8eb3ea:
	breq_s r3,0,L_8eb41a
L_8eb3ec:
	ld_s r0,[r14,0x2c]
L_8eb3ee:
	breq_s r0,0,L_8eb406
L_8eb3f0:
	mov_s r2,0x100f448
L_8eb3f6:
	mov_s r0,0xc
L_8eb3f8:
	bl.d L_8edfcc
L_8eb3fc:
	mov_s r1,0x2
L_8eb3fe:
	bl.d L_8e54d8
L_8eb402:
	ld_s r0,[r14,0x34]
L_8eb404:
	b_s L_8eb41a
	.global L_8eb406
L_8eb406:
	mov_s r2,0x100f474
L_8eb40c:
	mov_s r0,0xc
L_8eb40e:
	bl.d L_8edfcc
L_8eb412:
	mov_s r1,0x2
L_8eb414:
	bl.d L_8de444
L_8eb418:
	ld_s r0,[r14,0x34]
	.global L_8eb41a
L_8eb41a:
	ld_s r0,[r14,0x38]
L_8eb41c:
	st_s r13,[r14,0x34]
L_8eb41e:
	st_s r13,[r14,0x2c]
L_8eb420:
	breq_s r0,0,L_8eb428
L_8eb422:
	bl L_8c7794
L_8eb426:
	st_s r13,[r14,0x38]
	.global L_8eb428
L_8eb428:
	ld_s r1,[r14,0x3c]
L_8eb42a:
	mov_s r0,r14
L_8eb42c:
	ldb_s r1,[r1,0x8]
L_8eb42e:
	mov_s r2,0x3
L_8eb430:
	mov_s r3,0x1
L_8eb432:
	bl.d L_8da490
L_8eb436:
	mov r4,0x0
L_8eb43a:
	ld_s r0,[r14,0x48]
L_8eb43c:
	breq_s r0,0,L_8eb444
L_8eb43e:
	bl L_8c9538
L_8eb442:
	st_s r13,[r14,0x48]
	.global L_8eb444
L_8eb444:
	b L_8c0324
