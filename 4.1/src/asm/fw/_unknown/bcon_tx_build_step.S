/* bcon_tx_build_step @ 0x8c42d4, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr_mac_start_step, tx_bcon__update_bcon
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_b_s0_w2, bf_b_s2_w4, bf_b_s5_w3, bf_u16_s6_w6, bf_u16_s6_w7, bf_u16_s7_w3, bf_u16_s7_w6, bss_bi_ctrl_PCP_ready_set
 */
	.section .text.bcon_tx_build_step,"ax",@progbits
	.global bcon_tx_build_step
bcon_tx_build_step:
	.global L_8c42d4
L_8c42d4:
	push_s blink
L_8c42d6:
	bl.d L_8c02c4
L_8c42da:
	mov_s r2,r0
L_8c42dc:
	mov_s r3,r1
L_8c42de:
	mov_s r14,0x0
L_8c42e0:
	add3 r13,r0,0x20
L_8c42e4:
	add r0,r13,0xb
L_8c42e8:
	mov_s r1,r14
L_8c42ea:
	bl L_8e8240
L_8c42ee:
	bl L_8e81f8
L_8c42f2:
	add_s r0,r13,0x7
L_8c42f4:
	mov_s r1,0x1
L_8c42f6:
	bl L_8e81bc
L_8c42fa:
	ldb_s r0,[r13,0x7]
L_8c42fc:
	bclr_s r0,r0,0x6
L_8c42fe:
	bclr r1,r0,0x0
L_8c4302:
	ld_s r0,[r2,0x8]
L_8c4304:
	stb_s r1,[r13,0x7]
L_8c4306:
	cmp_s r0,0x2
L_8c4308:
	cmp.ne r0,0x3
L_8c430c:
	mov.ne r0,r14
L_8c4310:
	bne_s L_8c4314
L_8c4312:
	mov_s r0,0x1
	.global L_8c4314
L_8c4314:
	extb.f 0x0,r0
L_8c4318:
	mov_s r0,0x1
L_8c431a:
	sub_s.ne r0,r0,r0
L_8c431c:
	asl_s r0,r0
L_8c431e:
	bclr_s r1,r1,0x1
L_8c4320:
	or_s r1,r1,r0
L_8c4322:
	ldb_s r0,[r13,0x9]
L_8c4324:
	stb_s r1,[r13,0x7]
L_8c4326:
	bclr_s r0,r0,0x5
L_8c4328:
	stb_s r0,[r13,0x9]
L_8c432a:
	mov_s r0,0x857280
L_8c4330:
	ld_s r0,[r0,0x18]
L_8c4332:
	cmp_s r0,0x0
L_8c4334:
	mov_s r1,0x3
L_8c4336:
	mov.eq r1,0xf
L_8c433a:
	bmsk_s r1,r1,0x3
L_8c433c:
	add r0,r13,0x8
L_8c4340:
	bl.d L_8e8240
L_8c4344:
	cmp_s r3,0x0
L_8c4346:
	ldb_s r0,[r13,0x8]
L_8c4348:
	mov_s r1,0x0
L_8c434a:
	bset_s r0,r0,0x6
L_8c434c:
	stb_s r0,[r13,0x8]
L_8c434e:
	add r0,r13,0xb
L_8c4352:
	bl L_8e81a4
L_8c4356:
	add r0,r13,0xa
L_8c435a:
	mov_s r1,0x4
L_8c435c:
	bl L_8e827c
L_8c4360:
	add r0,r13,0x8
L_8c4364:
	mov_s r1,0x0
L_8c4366:
	bl L_8e81d4
L_8c436a:
	add_s r0,r13,0x7
L_8c436c:
	bl L_8e8240
L_8c4370:
	mov.ne r0,r2
L_8c4374:
	bl.ne.d L_8c4298
L_8c4378:
	mov.ne r1,0x1
L_8c437c:
	add r0,r13,0x9
L_8c4380:
	mov_s r1,0x1
L_8c4382:
	bl L_8e81b0
L_8c4386:
	b L_8c0334
L_8c438a:
	nop_s
