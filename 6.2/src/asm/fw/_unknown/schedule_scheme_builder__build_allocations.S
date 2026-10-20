/* schedule_scheme_builder__build_allocations @ 0x8c52cc, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   schedule_scheme_builder::build_allocations. Number of slots in cmd: %d
 * Зовут его: wmi_ese_cfg
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r22_to_r13_ret, __st_r22_to_r13, add_bcon, cid_pair__matches, fw_log_emit1, mac__get_beacon_interval_us, mac__get_bi_start_tsf, mid__apply_app_ies, sched__build_alloc_entry, sched__slot_start_offset, schedule__build_allocation_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global schedule_scheme_builder__build_allocations
schedule_scheme_builder__build_allocations:
	.global L_8c52cc
L_8c52cc:
	push_s blink
L_8c52ce:
	bl L_8c01c4
L_8c52d2:
	mov_s r14,r0
L_8c52d4:
	mov_s r17,r1
L_8c52d6:
	ldw_s r0,[r1,0x2]
L_8c52d8:
	ldb r20,[r1, 0x4]
L_8c52dc:
	btst_s r0,0x0
L_8c52de:
	cmp.ne r20,0x0
L_8c52e2:
	bne_s L_8c52ec
L_8c52e4:
	bl.d L_8c68a0
L_8c52e8:
	mov_s r0,r14
L_8c52ea:
	b_s L_8c53f0
	.global L_8c52ec
L_8c52ec:
	btst_s r0,0x2
L_8c52ee:
	bl.ne.d L_8c68a0
L_8c52f2:
	mov.ne r0,r14
L_8c52f6:
	mov_s r13,0x1
L_8c52f8:
	mov_s r0,0x803c00
L_8c52fe:
	st_s r13,[r14,0xc]
L_8c5300:
	ld_s r0,[r0,0x10]
L_8c5302:
	breq_s r0,0,L_8c5310
L_8c5304:
	st 0xbb8,[r14, 0x14]
L_8c530c:
	mov_s r0,0x0
L_8c530e:
	stb_s r0,[r14,0x4]
	.global L_8c5310
L_8c5310:
	mov_s r1,0x1014450
L_8c5316:
	mov_s r0,0x2b
L_8c5318:
	bl.d L_8dcc10
L_8c531c:
	mov_s r2,r20
L_8c531e:
	ldb r1,[r17, 0x1]
L_8c5322:
	mov_s r15,0x0
L_8c5324:
	ld_s r0,[r14]
L_8c5326:
	brne_s r1,0,L_8c532e
L_8c5328:
	ld_s r0,[r0,0x4]
L_8c532a:
	stb_s r13,[r0]
L_8c532c:
	b_s L_8c5346
	.global L_8c532e
L_8c532e:
	mov_s r1,0x2
L_8c5330:
	ld_s r0,[r0,0x4]
L_8c5332:
	bl.d L_8c3414
L_8c5336:
	stb_s r1,[r0]
L_8c5338:
	mov_s r15,r0
L_8c533a:
	mov_s r0,0x90
L_8c533c:
	stb_s r0,[r15]
L_8c533e:
	add2 r0,r20,r20
L_8c5342:
	add1_s r0,r0,r0
L_8c5344:
	stb_s r0,[r15,0x1]
	.global L_8c5346
L_8c5346:
	bl L_8e457c
L_8c534a:
	bl.d L_8e456c
L_8c534e:
	mov_s r1,r0
L_8c5350:
	add r18,r0,r1
L_8c5354:
	brlt.d r20,0x1,L_8c53c6
L_8c5358:
	mov_s r0,0x0
L_8c535a:
	mov_s r1,r20
	.global L_8c535c
L_8c535c:
	mov_s r21,r0
L_8c535e:
	mov_s r19,r1
L_8c5360:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8c5362:
	add2_s r0,r0,r0
L_8c5364:
	add r13,r17,0x10
L_8c5368:
	add_s r13,r13,r0
L_8c536a:
	mov_s r0,r14
L_8c536c:
	bl.d L_8cb818
L_8c5370:
	mov_s r1,r13
L_8c5372:
	mov_s r22,r0
L_8c5374:
	mov_s r0,r14
L_8c5376:
	bl.d L_8ccc48
L_8c537a:
	mov_s r1,r13
L_8c537c:
	mov_s r16,r0
L_8c537e:
	breq_s r15,0,L_8c539a
L_8c5380:
	add r1,r16,r18
L_8c5384:
	add2 r0,r21,r21
L_8c5388:
	add1_s r0,r0,r0
L_8c538a:
	add_s r2,r15,0x2
L_8c538c:
	add r4,r2,r0
L_8c5390:
	mov_s r0,r14
L_8c5392:
	mov_s r2,r22
L_8c5394:
	bl.d L_8c2ca4
L_8c5398:
	mov_s r3,r13
	.global L_8c539a
L_8c539a:
	ldb_s r1,[r13,0xe]
L_8c539c:
	mov_s r0,r14
L_8c539e:
	bl.d L_8da62c
L_8c53a2:
	ldb_s r2,[r13,0xf]
L_8c53a4:
	cmp_s r0,0x0
L_8c53a6:
	mov.ne r0,r14
L_8c53aa:
	mov.ne r1,r16
L_8c53ae:
	mov.ne r2,r22
L_8c53b2:
	bl.ne.d L_8c2cf8
L_8c53b6:
	mov.ne r3,r13
L_8c53ba:
	sub r1,r19,0x1
L_8c53be:
	brhs.d r1,0x1,L_8c535c
L_8c53c2:
	add r0,r21,0x1
	.global L_8c53c6
L_8c53c6:
	breq_s r15,0,L_8c53ea
L_8c53c8:
	ldw r0,[r17, 0x2]
L_8c53cc:
	bbit0 r0,0x3,L_8c53ea
L_8c53d0:
	add2 r2,r20,r20
L_8c53d4:
	add1_s r2,r2,r2
L_8c53d6:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8c53d8:
	extw_s r2,r2
L_8c53da:
	ld_s r0,[r14,0x10]
L_8c53dc:
	mov_s r1,0x0
L_8c53de:
	bl.d L_8e61c0
L_8c53e2:
	mov_s r3,r15
L_8c53e4:
	bl.d L_8c2778
L_8c53e8:
	ld_s r0,[r14,0x10]
	.global L_8c53ea
L_8c53ea:
	bl.d L_8e0d48
L_8c53ee:
	mov_s r0,r14
	.global L_8c53f0
L_8c53f0:
	b.d L_8c0214
L_8c53f4:
	mov_s r0,0x0
L_8c53f6:
	nop_s
