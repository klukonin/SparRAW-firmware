/* tof_mgr__ftm_req_done @ 0x8cb2bc, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tof_mgr::ftm_req_done() ftm_obj not in active list
 * Зовут его: ftm__set_shared_active_flag, state_sm_803424__action_cmp12
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, discovery__rx_stop, free_ftm_session, ftm__session_step, fw_log_emit0, mid_list__by_mid_fw, radio_mgr__call_method_10, tof__next_request, tof_mgr__alloc_entry, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof_mgr__ftm_req_done
tof_mgr__ftm_req_done:
	.global L_8cb2bc
L_8cb2bc:
	push_s blink
L_8cb2be:
	bl L_8c01dc
L_8cb2c2:
	mov.f r15,r1
L_8cb2c6:
	mov_s r13,r0
L_8cb2c8:
	beq_s L_8cb34a
L_8cb2ca:
	add r16,r13,0xc
L_8cb2ce:
	add r2,r15,0x10
L_8cb2d2:
	bl.d L_8e4bc8
L_8cb2d6:
	mov_s r1,r16
L_8cb2d8:
	mov.f r14,r0
L_8cb2dc:
	bne_s L_8cb2ec
L_8cb2de:
	mov_s r1,0x10198cc
L_8cb2e4:
	bl.d L_8dcba8
L_8cb2e8:
	mov_s r0,0x2b
L_8cb2ea:
	b_s L_8cb34a
	.global L_8cb2ec
L_8cb2ec:
	mov_s r0,r16
L_8cb2ee:
	bl.d L_8e2884
L_8cb2f2:
	mov_s r1,r14
L_8cb2f4:
	bl.d L_8e0b58
L_8cb2f8:
	mov_s r0,r13
L_8cb2fa:
	mov r16,0x0
L_8cb2fe:
	brne_s r0,0,L_8cb31a
L_8cb300:
	mov_s r0,r13
L_8cb302:
	bl.d L_8cb380
L_8cb306:
	ldb_s r1,[r15,0x1c]
L_8cb308:
	mov_s r0,0x806518
L_8cb30e:
	mov_s r1,0x7
L_8cb310:
	mov_s r2,0x0
L_8cb312:
	mov_s r3,r2
L_8cb314:
	bl.d L_8d9b6c
L_8cb318:
	mov_s r4,r2
	.global L_8cb31a
L_8cb31a:
	mov_s r0,r13
L_8cb31c:
	bl.d L_8cb05c
L_8cb320:
	mov_s r1,r14
L_8cb322:
	bl.d L_8cc3dc
L_8cb326:
	mov_s r0,0x0
L_8cb328:
	ld_s r0,[r0,0x4c]
L_8cb32a:
	cmp_s r0,0x2
L_8cb32c:
	mov_s r0,0x1
L_8cb32e:
	sub_s.ne r0,r0,r0
L_8cb330:
	extb.f 0x0,r0
L_8cb334:
	bne_s L_8cb34a
L_8cb336:
	mov_s r13,0x806518
L_8cb33c:
	bl.d L_8ea800
L_8cb340:
	ld_s r0,[r13,0x8]
L_8cb342:
	bl L_8f80ec
L_8cb346:
	st r16,[r13, 0x8]
	.global L_8cb34a
L_8cb34a:
	b L_8c0244
L_8cb34e:
	nop_s
