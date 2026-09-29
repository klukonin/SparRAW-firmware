/* rf_sector__program_selected @ 0x937448, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report, rx_funcs__identify_peer, set_selected_rf_sector_index_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_w_s0_w6_uc, bf_w_s6_w2_uc
 */
	.section .text.rf_sector__program_selected,"ax",@progbits
	.global rf_sector__program_selected
rf_sector__program_selected:
	.global L_937448
L_937448:
	push_s blink
L_93744a:
	bl.d L_920210
L_93744e:
	mov_s r4,r2
L_937450:
	mov_s r14,0x8010e8
L_937456:
	ld_s r13,[r14,0x1c]
L_937458:
	asl_s r2,r0,0x3
L_93745a:
	add3_s r2,r2,r2
L_93745c:
	add_s r2,r2,0x801190
L_937462:
	ld.as r15,[gp,-0x4]
L_937466:
	or r15,r15,0x30
L_93746a:
	breq_s r13,0,L_93747a
L_93746c:
	ldb r13,[r14, 0x20]
L_937470:
	asl r14,r13,0x8
L_937474:
	or_s r14,r14,r15
L_937476:
	st_s r14,[r2,0x8]
L_937478:
	b_s L_937488
	.global L_93747a
L_93747a:
	asl r13,r1,0x8
L_93747e:
	or_s r13,r13,r15
L_937480:
	st_s r13,[r2,0x8]
L_937482:
	extb_s r13,r1
L_937484:
	stb r1,[r14, 0x20]
	.global L_937488
L_937488:
	mov_s r2,0x800fb0
L_93748e:
	stb_s r13,[r2]
L_937490:
	brne r3,0x1,L_9374ae
L_937494:
	mul64 r0,0x3c
L_937498:
	bmsk_s r1,r1,0x5
L_93749a:
	add r0,mlo,0x857400
L_9374a2:
	bl L_937994
L_9374a6:
	bmsk r1,r4,0x1
L_9374aa:
	bl L_9379e8
	.global L_9374ae
L_9374ae:
	b L_92027c
L_9374b2:
	nop_s
