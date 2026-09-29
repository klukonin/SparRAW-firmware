/* link_lost_diag_part2 @ 0x8f2250, 252 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ====================================================================
 *   =========== LLD(Link Lost Diagnostic Part 2)           =============
 *   MARLON-M TEMP has not been MEASURED.
 *   MARLON-M TEMP MEASURED (%d).
 *   MARLON-M TEMP CHECK: HIGH (%d) !!!
 *   MARLON-M TEMP CHECK: VERY HIGH (%d) !!!
 *   MARLON-R rfc_idx=%d TEMP has not been MEASURED.
 *   MARLON-R rfc_idx=%d TEMP MEASURED (%d).
 * Зовут его: mlme_sm__disconnect_ev_handle
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_calib__check_g8000a4, fw_divmod_signed, fw_log_emit0, fw_log_emit1, link_lost_diag__rx_status, rf__get_connected_mask, temp__get_rf_by_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag_part2
link_lost_diag_part2:
	.global L_8f2250
L_8f2250:
	push_s blink
L_8f2252:
	bl.d L_8c01dc
L_8f2256:
	mov_s r0,0x20
L_8f2258:
	mov_s r13,0x1000cbc
L_8f225e:
	bl.d L_8dcba8
L_8f2262:
	mov_s r1,r13
L_8f2264:
	mov_s r1,0x1000e18
L_8f226a:
	bl.d L_8dcba8
L_8f226e:
	mov_s r0,0x20
L_8f2270:
	mov_s r0,0x20
L_8f2272:
	bl.d L_8dcba8
L_8f2276:
	mov_s r1,r13
L_8f2278:
	bl.d L_8f4680
L_8f227c:
	mov r16,-0x1
L_8f2280:
	bl.d L_8cb91c
L_8f2284:
	mov_s r0,0x0
L_8f2286:
	mov_s r15,r0
L_8f2288:
	brne r0,r16,L_8f229a
L_8f228c:
	mov_s r1,0x1000e60
L_8f2292:
	bl.d L_8dcba8
L_8f2296:
	mov_s r0,0x20
L_8f2298:
	b_s L_8f22d0
	.global L_8f229a
L_8f229a:
	bl.d L_8c02dc
L_8f229e:
	mov r1,0x3e8
L_8f22a2:
	cmp_s r15,0x15f90
L_8f22a8:
	mov_s r2,r0
L_8f22aa:
	bge_s L_8f22b4
L_8f22ac:
	mov_s r1,0x1000e88
L_8f22b2:
	b_s L_8f22ca
	.global L_8f22b4
L_8f22b4:
	brge r15,0x186a0,L_8f22c4
L_8f22bc:
	mov_s r1,0x1000ea8
L_8f22c2:
	b_s L_8f22ca
	.global L_8f22c4
L_8f22c4:
	mov_s r1,0x1000ecc
	.global L_8f22ca
L_8f22ca:
	bl.d L_8dcc10
L_8f22ce:
	mov_s r0,0x20
	.global L_8f22d0
L_8f22d0:
	mov_s r14,0x0
L_8f22d2:
	b_s L_8f22e2
	.global L_8f22d4
L_8f22d4:
	mov_s r1,0x1000ef4
L_8f22da:
	bl.d L_8dcba8
L_8f22de:
	mov_s r0,0x20
	.global L_8f22e0
L_8f22e0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8f22e2
L_8f22e2:
	brhs r14,0x8,L_8f233a
L_8f22e6:
	mov_s r0,0x8042c8
L_8f22ec:
	bl L_8ccb38
L_8f22f0:
	bbit0 r0,r14,L_8f22e0
L_8f22f4:
	mov_s r0,r14
L_8f22f6:
	bl.d L_8cca40
L_8f22fa:
	mov_s r1,0x0
L_8f22fc:
	mov_s r13,r0
L_8f22fe:
	breq r0,r16,L_8f22d4
L_8f2302:
	bl.d L_8c02dc
L_8f2306:
	mov r1,0x3e8
L_8f230a:
	cmp_s r13,0x11170
L_8f2310:
	mov_s r2,r0
L_8f2312:
	bge_s L_8f231c
L_8f2314:
	mov_s r1,0x1000f24
L_8f231a:
	b_s L_8f2332
	.global L_8f231c
L_8f231c:
	brge r15,0x13880,L_8f232c
L_8f2324:
	mov_s r1,0x1000f4c
L_8f232a:
	b_s L_8f2332
	.global L_8f232c
L_8f232c:
	mov_s r1,0x1000f78
	.global L_8f2332
L_8f2332:
	bl.d L_8dcc10
L_8f2336:
	mov_s r0,0x20
L_8f2338:
	b_s L_8f22e0
	.global L_8f233a
L_8f233a:
	mov_s r1,0x1000fac
L_8f2340:
	bl.d L_8dcba8
L_8f2344:
	mov_s r0,0x20
L_8f2346:
	b L_8c0244
L_8f234a:
	nop_s
