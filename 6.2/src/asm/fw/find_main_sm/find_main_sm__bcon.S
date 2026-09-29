/* find_main_sm__bcon @ 0x8f13f8, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::bcon()
 *   FIND_SM:: dband info pool is empty !!!! %x
 *   FIND_SM:: DMG Beacon info added: ADDR-%04X%08X
 * Зовут его: state_sm_8030f4__action_8f14d0
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, alloc_dband_info, find_main_sm__bcon_args, find_main_sm__bcon_step, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, hexdump_words, list__find_entry_d, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_main_sm__bcon
find_main_sm__bcon:
	.global L_8f13f8
L_8f13f8:
	push_s blink
L_8f13fa:
	bl L_8c01d8
L_8f13fe:
	mov_s r16,r0
L_8f1400:
	ld_s r15,[r1,0x8]
L_8f1402:
	mov_s r13,r1
L_8f1404:
	/* add_s r15,0x4 */
	.byte 0x04,0xe7
L_8f1406:
	mov_s r1,0x1017c3c
L_8f140c:
	bl.d L_8dcba8
L_8f1410:
	mov_s r0,0x2c
L_8f1412:
	add r17,r16,0x18
L_8f1416:
	mov_s r0,r17
L_8f1418:
	bl.d L_8f8574
L_8f141c:
	mov_s r1,r15
L_8f141e:
	brne_s r0,0,L_8f1448
	.global L_8f1420
L_8f1420:
	mov_s r0,0x805524
L_8f1426:
	ld_s r1,[r0,0xc]
L_8f1428:
	ld_s r0,[r0,0x10]
L_8f142a:
	cmp_s r1,r0
L_8f142c:
	mov_s r0,0x1
L_8f142e:
	sub.cs r0,r0,r0
L_8f1432:
	breq_s r0,0,L_8f1454
L_8f1434:
	bl L_8e9524
L_8f1438:
	mov_s r1,0x1017c54
L_8f143e:
	mov_s r2,r0
L_8f1440:
	bl.d L_8dcc10
L_8f1444:
	mov_s r0,0x1c
L_8f1446:
	b_s L_8f14be
	.global L_8f1448
L_8f1448:
	mov_s r0,blink
L_8f144a:
	mov_s r1,0x35
L_8f144c:
	bl.d L_8c9b28
L_8f1450:
	bset_s r1,r1,0xc
L_8f1452:
	b_s L_8f1420
	.global L_8f1454
L_8f1454:
	bl L_8f0cf8
L_8f1458:
	mov.f r14,r0
L_8f145c:
	beq_s L_8f14c2
	.global L_8f145e
L_8f145e:
	ldw_s r2,[r15,0x4]
L_8f1460:
	mov_s r1,0x1017c80
L_8f1466:
	mov_s r0,0x29
L_8f1468:
	bl.d L_8dcc80
L_8f146c:
	ld_s r3,[r15]
L_8f146e:
	ld_s r0,[r13,0x8]
L_8f1470:
	bl.d L_8c9790
L_8f1474:
	ld_s r1,[r13,0x30]
L_8f1476:
	add r0,r14,0x8
L_8f147a:
	mov_s r1,r15
L_8f147c:
	bl.d L_8c0380
L_8f1480:
	mov_s r2,0x6
L_8f1482:
	ld_s r1,[r13,0xc]
L_8f1484:
	breq_s r1,0,L_8f149e
L_8f1486:
	ldb_s r2,[r1,0x9]
L_8f1488:
	brlt r2,0x1,L_8f149e
L_8f148c:
	add r0,r14,0x10
L_8f1490:
	bl.d L_8c0380
L_8f1494:
	ld_s r1,[r1,0xc]
L_8f1496:
	ld_s r0,[r13,0xc]
L_8f1498:
	ldb_s r0,[r0,0x9]
L_8f149a:
	stb r0,[r14, 0x30]
	.global L_8f149e
L_8f149e:
	ld r0,[r16, 0x10]
L_8f14a2:
	mov_s r1,r15
L_8f14a4:
	ld_s r0,[r0,0x48]
L_8f14a6:
	mov_s r2,0x0
L_8f14a8:
	mov r4,0xffff
L_8f14b0:
	bl.d L_8da8fc
L_8f14b4:
	mov_s r3,r2
L_8f14b6:
	mov_s r0,r17
L_8f14b8:
	bl.d L_8c25f4
L_8f14bc:
	mov_s r1,r14
	.global L_8f14be
L_8f14be:
	b L_8c023c
	.global L_8f14c2
L_8f14c2:
	mov_s r0,blink
L_8f14c4:
	mov_s r1,0x4
L_8f14c6:
	bl.d L_8c9b28
L_8f14ca:
	bset_s r1,r1,0xc
L_8f14cc:
	b_s L_8f145e
L_8f14ce:
	nop_s
