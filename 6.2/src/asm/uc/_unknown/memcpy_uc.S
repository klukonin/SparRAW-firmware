/* memcpy_uc @ 0x920330, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__reset_sta_slot, brp__select_cfg_by_snr, internal_tx__flow_sm4, notify_aoa, peer_slots__scan_by_masks, phy_params__snapshot, rs_end, sched_cfg__merge_update, ss__copy_cfg_from_cmd, txrx_umac_if_config_pmc_triggers_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global memcpy_uc
memcpy_uc:
	.global L_920330
L_920330:
	mov.f lp_count,r2
L_920334:
	or r4,r0,r1
L_920338:
	jeq [blink]
L_92033c:
	and.f 0x0,r4,0x3
L_920340:
	lsr r4,r2,0x3
L_920344:
	bne L_9203c8
L_920348:
	lsr.f lp_count,r4
L_92034c:
	sub r1,r1,0x4
L_920350:
	sub r3,r0,0x4
L_920354:
	lpne L_920378
L_920358:
	ld.a r4,[r1,0x4]
L_92035c:
	ld.a r5,[r1,0x4]
L_920360:
	ld.a r6,[r1,0x4]
L_920364:
	ld.a r7,[r1,0x4]
L_920368:
	st.a r4,[r3,0x4]
L_92036c:
	st.a r5,[r3,0x4]
L_920370:
	st.a r6,[r3,0x4]
L_920374:
	st.a r7,[r3,0x4]
	.global L_920378
L_920378:
	bcs.d L_9203a4
L_92037c:
	and.f 0x0,r2,0x4
L_920380:
	bne.d L_9203bc
	.global L_920384
L_920384:
	and.f lp_count,r2,0x3
	.global L_920388
L_920388:
	add r1,r1,0x3
L_92038c:
	jeq [blink]
L_920390:
	add r3,r3,0x3
L_920394:
	lp L_9203a0
L_920398:
	ldb.a r4,[r1,0x1]
L_92039c:
	stb.a r4,[r3,0x1]
	.global L_9203a0
L_9203a0:
	j [blink]
	.global L_9203a4
L_9203a4:
	ld.a r4,[r1,0x4]
L_9203a8:
	ld.a r5,[r1,0x4]
L_9203ac:
	st.a r4,[r3,0x4]
L_9203b0:
	beq.d L_920384
L_9203b4:
	st.a r5,[r3,0x4]
L_9203b8:
	and.f lp_count,r2,0x3
	.global L_9203bc
L_9203bc:
	ld.a r4,[r1,0x4]
L_9203c0:
	b.d L_920388
L_9203c4:
	st.a r4,[r3,0x4]
	.global L_9203c8
L_9203c8:
	sub r1,r1,0x1
L_9203cc:
	sub r3,r0,0x1
L_9203d0:
	lp L_9203dc
L_9203d4:
	ldb.a r4,[r1,0x1]
L_9203d8:
	stb.a r4,[r3,0x1]
	.global L_9203dc
L_9203dc:
	j [blink]
