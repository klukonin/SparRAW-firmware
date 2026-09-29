/* scan_mngr__clean_all_lists @ 0x8ea324, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::clean_all_lists() m_scanned_list (size: %d)
 *   [NNL] m_scan_pend_list (size: %d)
 *   scan_mngr::clean_all_lists() from scan list:  ADDR-%04X%08X system_states: %d
 *   scan_mngr::clean_all_lists() from pending list:  ADDR-%04X%08X system_states: %d
 *   scan_mngr::clean_all_lists() p_dband_info->conn_ptr: %d already free
 *   scan_mngr::clean_all_lists() FREE DBAND pending elements  0x%X
 *   scan_mngr::clean_all_lists() reset_active_probs
 * Зовут его: scan_mngr__scan_done, scan_mngr__sm_dwelling_ended
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__link_down_evt, free_dband_info, fw_log__emit0, fw_log__emit1, fw_log__emit3, get_g_80469c, llist__pop_front, u_schd__cancel
 */
	.section .text.scan_mngr__clean_all_lists,"ax",@progbits
	.global scan_mngr__clean_all_lists
scan_mngr__clean_all_lists:
	.global L_8ea324
L_8ea324:
	push_s blink
L_8ea326:
	bl.d L_8c02c0
L_8ea32a:
	mov_s r1,0x2
L_8ea32c:
	mov_s r13,r0
L_8ea32e:
	add r15,r0,0xc
L_8ea332:
	mov_s r2,0x1012e28
L_8ea338:
	mov_s r0,0x9
L_8ea33a:
	bl.d L_8edfcc
L_8ea33e:
	ld_s r3,[r15]
L_8ea340:
	mov_s r2,0x1012e60
L_8ea346:
	mov_s r0,0x9
L_8ea348:
	mov_s r1,0x2
L_8ea34a:
	bl.d L_8edfcc
L_8ea34e:
	ld_s r3,[r13]
L_8ea350:
	b_s L_8ea378
	.global L_8ea352
L_8ea352:
	bl.d L_8de2d4
L_8ea356:
	mov_s r0,r15
L_8ea358:
	ld r4,[r0, 0x8]
L_8ea35c:
	mov_s r14,r0
L_8ea35e:
	ldb r5,[r0, 0x39]
L_8ea362:
	mov_s r2,0x1012e84
L_8ea368:
	mov_s r0,0x9
L_8ea36a:
	mov_s r1,0x2
L_8ea36c:
	bl.d L_8ee034
L_8ea370:
	ldw_s r3,[r14,0xc]
L_8ea372:
	bl.d L_8ebb88
L_8ea376:
	mov_s r0,r14
	.global L_8ea378
L_8ea378:
	ld_s r0,[r15]
L_8ea37a:
	sub.f r0,r0,0x0
L_8ea37e:
	mov.ne r0,0x1
L_8ea382:
	extb.f 0x0,r0
L_8ea386:
	bne_s L_8ea352
L_8ea388:
	b_s L_8ea3f0
	.global L_8ea38a
L_8ea38a:
	bl.d L_8de2d4
L_8ea38e:
	mov_s r0,r13
L_8ea390:
	mov_s r14,r0
L_8ea392:
	ld_s r0,[r0,0x40]
L_8ea394:
	breq_s r0,0,L_8ea39e
L_8ea396:
	bl L_8c7794
L_8ea39a:
	mov_s r0,0x0
L_8ea39c:
	st_s r0,[r14,0x40]
	.global L_8ea39e
L_8ea39e:
	ld_s r0,[r14,0x3c]
L_8ea3a0:
	breq_s r0,0,L_8ea3da
L_8ea3a2:
	ld r4,[r14, 0x8]
L_8ea3a6:
	mov_s r2,0x1012ed4
L_8ea3ac:
	ldb r5,[r14, 0x39]
L_8ea3b0:
	mov_s r0,0x9
L_8ea3b2:
	mov_s r1,0x2
L_8ea3b4:
	bl.d L_8ee034
L_8ea3b8:
	ldw_s r3,[r14,0xc]
L_8ea3ba:
	bl.d L_8d7030
L_8ea3be:
	ld_s r0,[r14,0x3c]
L_8ea3c0:
	ld_s r3,[r14,0x3c]
L_8ea3c2:
	brne_s r0,0,L_8ea3cc
L_8ea3c4:
	bl.d L_8d79cc
L_8ea3c8:
	mov_s r0,r3
L_8ea3ca:
	b_s L_8ea3da
	.global L_8ea3cc
L_8ea3cc:
	mov_s r2,0x1012f28
L_8ea3d2:
	mov_s r0,0x9
L_8ea3d4:
	bl.d L_8edfcc
L_8ea3d8:
	mov_s r1,0x1
	.global L_8ea3da
L_8ea3da:
	mov_s r2,0x1012f70
L_8ea3e0:
	mov_s r0,0x9
L_8ea3e2:
	mov_s r1,0x2
L_8ea3e4:
	bl.d L_8edfcc
L_8ea3e8:
	mov_s r3,r14
L_8ea3ea:
	bl.d L_8ebb88
L_8ea3ee:
	mov_s r0,r14
	.global L_8ea3f0
L_8ea3f0:
	ld_s r0,[r13]
L_8ea3f2:
	sub.f r0,r0,0x0
L_8ea3f6:
	mov.ne r0,0x1
L_8ea3fa:
	extb.f 0x0,r0
L_8ea3fe:
	bne_s L_8ea38a
L_8ea400:
	mov_s r2,0x1012fb0
L_8ea406:
	mov_s r0,0x9
L_8ea408:
	bl.d L_8edfb0
L_8ea40c:
	mov_s r1,0x2
L_8ea40e:
	mov_s r0,0x0
L_8ea410:
	b.d L_8c032c
L_8ea414:
	stb r0,[r13, 0x8c]
