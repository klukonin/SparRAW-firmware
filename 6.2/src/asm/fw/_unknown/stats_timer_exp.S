/* stats_timer_exp @ 0x8e0288, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stats_timer_exp:: L1 WA: %d Took %d usec
 * Зовут его: link_stats__report, power_mgr_ut__dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, hwd_dma__get_rings_with_data, hwd_pcie__toggle_882f80_bits, pcie__l1ss_config, u_schd__now
 * Глобалы (через gp): 0x80040c, 0x800410
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stats_timer_exp
stats_timer_exp:
	.global L_8e0288
L_8e0288:
	push_s blink
L_8e028a:
	bl L_8c01e4
L_8e028e:
	mov_s r14,r0
L_8e0290:
	mov_s r0,0x11
L_8e0292:
	asl_s r0,r0,0x13
L_8e0294:
	ld_s r13,[r0,0x1c]
L_8e0296:
	bbit0 r13,0x3,L_8e0336
L_8e029a:
	ld_s r0,[gp,0x28c]
L_8e029c:
	breq r0,0x0,L_8e0336
L_8e02a0:
	bl L_8d078c
L_8e02a4:
	ld.as r1,[gp,0xa2]
L_8e02a8:
	breq_s r0,0,L_8e02dc
L_8e02aa:
	brne_s r14,0,L_8e02dc
L_8e02ac:
	brne r1,0x0,L_8e0336
L_8e02b0:
	bl L_8e9524
L_8e02b4:
	btst_s r13,0x8
L_8e02b6:
	mov_s r14,r0
L_8e02b8:
	btst.eq r13,0x7
L_8e02bc:
	btst.eq r13,0x6
L_8e02c0:
	btst.eq r13,0x5
L_8e02c4:
	beq_s L_8e02d2
L_8e02c6:
	mov_s r0,0x0
L_8e02c8:
	mov_s r1,r0
L_8e02ca:
	mov_s r2,r0
L_8e02cc:
	bl.d L_8d0d90
L_8e02d0:
	mov_s r3,r0
	.global L_8e02d2
L_8e02d2:
	bl.d L_8d1554
L_8e02d6:
	mov_s r0,0x0
L_8e02d8:
	mov_s r0,0x1
L_8e02da:
	b_s L_8e031a
	.global L_8e02dc
L_8e02dc:
	brne r1,0x1,L_8e0336
L_8e02e0:
	bl L_8e9524
L_8e02e4:
	mov_s r14,r0
L_8e02e6:
	bl.d L_8d1554
L_8e02ea:
	mov_s r0,0x1
L_8e02ec:
	btst_s r13,0x8
L_8e02ee:
	btst.eq r13,0x7
L_8e02f2:
	btst.eq r13,0x6
L_8e02f6:
	btst.eq r13,0x5
L_8e02fa:
	beq_s L_8e0318
L_8e02fc:
	lsr r0,r13,0x8
L_8e0300:
	lsr r1,r13,0x7
L_8e0304:
	lsr r2,r13,0x6
L_8e0308:
	lsr r3,r13,0x5
L_8e030c:
	bmsk_s r0,r0,0x0
L_8e030e:
	bmsk_s r1,r1,0x0
L_8e0310:
	bmsk_s r2,r2,0x0
L_8e0312:
	bl.d L_8d0d90
L_8e0316:
	bmsk_s r3,r3,0x0
	.global L_8e0318
L_8e0318:
	mov_s r0,0x0
	.global L_8e031a
L_8e031a:
	bl.d L_8e9524
L_8e031e:
	st.as r0,[gp,0xa2]
L_8e0322:
	sub_s r0,r0,r14
L_8e0324:
	ld.as r2,[gp,0xa2]
L_8e0328:
	asl_s r3,r0,0x4
L_8e032a:
	mov_s r1,0x1003754
L_8e0330:
	bl.d L_8dcc80
L_8e0334:
	mov_s r0,0x2e
	.global L_8e0336
L_8e0336:
	b L_8c0254
L_8e033a:
	nop_s
