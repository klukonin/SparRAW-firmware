/* memcpy_uc @ 0x920310, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_sweep_step_b, bi_mode__load_qset_table, bi_window_transition_prep, brp_copy_step, get_selected_rf_sector_index_cmd_handler, rx_funcs_copy_step, txss_copy_step, txss_func__reorder_sectors, uc_send_evt__bf_done, uc_send_evt__get_rf_sector_done
 */
	.section .text.memcpy_uc,"ax",@progbits
	.global memcpy_uc
memcpy_uc:
	.global L_920310
L_920310:
	mov.f lp_count,r2
L_920314:
	or r4,r0,r1
L_920318:
	jeq [blink]
L_92031c:
	and.f 0x0,r4,0x3
L_920320:
	lsr r4,r2,0x3
L_920324:
	bne L_9203a8
L_920328:
	lsr.f lp_count,r4
L_92032c:
	sub r1,r1,0x4
L_920330:
	sub r3,r0,0x4
L_920334:
	lpne L_920358
L_920338:
	ld.a r4,[r1,0x4]
L_92033c:
	ld.a r5,[r1,0x4]
L_920340:
	ld.a r6,[r1,0x4]
L_920344:
	ld.a r7,[r1,0x4]
L_920348:
	st.a r4,[r3,0x4]
L_92034c:
	st.a r5,[r3,0x4]
L_920350:
	st.a r6,[r3,0x4]
L_920354:
	st.a r7,[r3,0x4]
	.global L_920358
L_920358:
	bcs.d L_920384
L_92035c:
	and.f 0x0,r2,0x4
L_920360:
	bne.d L_92039c
	.global L_920364
L_920364:
	and.f lp_count,r2,0x3
	.global L_920368
L_920368:
	add r1,r1,0x3
L_92036c:
	jeq [blink]
L_920370:
	add r3,r3,0x3
L_920374:
	lp L_920380
L_920378:
	ldb.a r4,[r1,0x1]
L_92037c:
	stb.a r4,[r3,0x1]
	.global L_920380
L_920380:
	j [blink]
	.global L_920384
L_920384:
	ld.a r4,[r1,0x4]
L_920388:
	ld.a r5,[r1,0x4]
L_92038c:
	st.a r4,[r3,0x4]
L_920390:
	beq.d L_920364
L_920394:
	st.a r5,[r3,0x4]
L_920398:
	and.f lp_count,r2,0x3
	.global L_92039c
L_92039c:
	ld.a r4,[r1,0x4]
L_9203a0:
	b.d L_920368
L_9203a4:
	st.a r4,[r3,0x4]
	.global L_9203a8
L_9203a8:
	sub r1,r1,0x1
L_9203ac:
	sub r3,r0,0x1
L_9203b0:
	lp L_9203bc
L_9203b4:
	ldb.a r4,[r1,0x1]
L_9203b8:
	stb.a r4,[r3,0x1]
	.global L_9203bc
L_9203bc:
	j [blink]
