/* hwd_pcie_exit_l1 @ 0x8d12ac, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   hwd_pcie_exit_l1: PERST ASSERTED !!!
 * Зовут его: fw_vector_16, hwd_dma__raise_host_fw_int, hwd_pcie__set_low_power, pcie__force_clear_l0s, pcie__set_event_bit, pcie_serdes__init_seq, rm_main_sm__enter_primary_non_locked, sm_pring__timeout
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, hwd_pcie__get_882b80, hwd_pcie__is_ep_under_serdes, hwd_pcie__is_l1_state
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie_exit_l1
hwd_pcie_exit_l1:
	.global L_8d12ac
L_8d12ac:
	push_s blink
L_8d12ae:
	bl L_8c01e0
L_8d12b2:
	bl.d L_8d1470
L_8d12b6:
	mov_s r13,r0
L_8d12b8:
	mov_s r15,r0
L_8d12ba:
	brne r13,0x0,L_8d1310
L_8d12be:
	mov_s r0,0x50
L_8d12c0:
	mov lp_count,r0
L_8d12c4:
	nop_s
L_8d12c6:
	lp L_8d12ce
L_8d12ca:
	nop_s
L_8d12cc:
	nop_s
	.global L_8d12ce
L_8d12ce:
	mov_s r2,0x1e8480
	.global L_8d12d4
L_8d12d4:
	/* bl.d 0x008d1054 */
	.byte 0x82,0x0d,0xef,0xff
L_8d12d8:
	/* _sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8d12da:
	bl.d L_8d1428
L_8d12de:
	mov_s r1,r0
L_8d12e0:
	mov_s r14,r0
L_8d12e2:
	cmp_s r1,0x0
L_8d12e4:
	cmp.eq r14,0x1
L_8d12e8:
	bne_s L_8d12ec
L_8d12ea:
	brne_s r2,0,L_8d12d4
	.global L_8d12ec
L_8d12ec:
	cmp_s r1,0x0
L_8d12ee:
	cmp.eq r14,0x1
L_8d12f2:
	bne_s L_8d1302
L_8d12f4:
	mov_s r2,blink
L_8d12f6:
	mov_s r1,0x101dbf4
L_8d12fc:
	bl.d L_8dcc10
L_8d1300:
	mov_s r0,0x0
	.global L_8d1302
L_8d1302:
	brne_s r14,0,L_8d1310
L_8d1304:
	mov_s r1,0x101dc24
L_8d130a:
	bl.d L_8dcba8
L_8d130e:
	mov_s r0,0x11
	.global L_8d1310
L_8d1310:
	bclr r14,r13,0x0
L_8d1314:
	breq_s r15,0,L_8d1334
L_8d1316:
	brne_s r14,0,L_8d132a
	.global L_8d1318
L_8d1318:
	mov_s r1,0x882500
L_8d131e:
	ld_s r0,[r1,0x54]
L_8d1320:
	/* asl_s r13,r13,0x3 */
	.byte 0x03,0xbd
L_8d1322:
	bclr_s r0,r0,0x3
L_8d1324:
	or_s r13,r13,r0
L_8d1326:
	st_s r13,[r1,0x54]
L_8d1328:
	b_s L_8d138c
	.global L_8d132a
L_8d132a:
	mov_s r0,blink
L_8d132c:
	bl.d L_8c9b28
L_8d1330:
	mov_s r1,0xac
L_8d1332:
	b_s L_8d1318
	.global L_8d1334
L_8d1334:
	breq_s r13,0,L_8d136c
L_8d1336:
	brne_s r14,0,L_8d1358
	.global L_8d1338
L_8d1338:
	mov_s r15,0x882000
L_8d133e:
	ld_s r0,[r15,0x28]
L_8d1340:
	asl r1,r13,0x13
L_8d1344:
	bclr_s r0,r0,0x13
L_8d1346:
	or_s r0,r0,r1
L_8d1348:
	st_s r0,[r15,0x28]
L_8d134a:
	brne_s r14,0,L_8d1362
	.global L_8d134c
L_8d134c:
	ld_s r0,[r15,0x24]
L_8d134e:
	asl_s r13,r13,0x18
L_8d1350:
	bclr_s r0,r0,0x18
L_8d1352:
	or_s r13,r13,r0
L_8d1354:
	st_s r13,[r15,0x24]
L_8d1356:
	b_s L_8d138c
	.global L_8d1358
L_8d1358:
	mov_s r0,blink
L_8d135a:
	bl.d L_8c9b28
L_8d135e:
	mov_s r1,0xac
L_8d1360:
	b_s L_8d1338
	.global L_8d1362
L_8d1362:
	mov_s r0,blink
L_8d1364:
	bl.d L_8c9b28
L_8d1368:
	mov_s r1,0xac
L_8d136a:
	b_s L_8d134c
	.global L_8d136c
L_8d136c:
	brne_s r14,0,L_8d1390
	.global L_8d136e
L_8d136e:
	mov_s r15,0x882000
L_8d1374:
	ld_s r1,[r15,0x24]
L_8d1376:
	asl r0,r13,0x18
L_8d137a:
	bclr_s r1,r1,0x18
L_8d137c:
	or_s r0,r0,r1
L_8d137e:
	st_s r0,[r15,0x24]
L_8d1380:
	brne_s r14,0,L_8d139a
	.global L_8d1382
L_8d1382:
	ld_s r0,[r15,0x28]
L_8d1384:
	asl_s r13,r13,0x13
L_8d1386:
	bclr_s r0,r0,0x13
L_8d1388:
	or_s r0,r0,r13
L_8d138a:
	st_s r0,[r15,0x28]
	.global L_8d138c
L_8d138c:
	b L_8c024c
	.global L_8d1390
L_8d1390:
	mov_s r0,blink
L_8d1392:
	bl.d L_8c9b28
L_8d1396:
	mov_s r1,0xac
L_8d1398:
	b_s L_8d136e
	.global L_8d139a
L_8d139a:
	mov_s r0,blink
L_8d139c:
	bl.d L_8c9b28
L_8d13a0:
	mov_s r1,0xac
L_8d13a2:
	b_s L_8d1382
