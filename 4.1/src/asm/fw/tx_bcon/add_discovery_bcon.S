/* add_discovery_bcon @ 0x8c22e4, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_bcon.cpp
 *   add_discovery_bcon: MID[%d], scan_type %d, length %d
 * Зовут его: find_mng__add_bcon, scan_mngr__sm_ready_for_dwelling
 * Зовёт сам: TX_API__alloc_tx_payload, TX_API__send_dband_bcon, __ld_r18_to_r13_ret, __st_r18_to_r13, bf_b_s4_w2, bf_b_s5_w3, bf_u16_s7_w3, bf_u16_s7_w6, fw_log__emit3, fw_sysassert_fatal, lmac_if__send_bcon_mgt, memcpy_fw
 */
	.section .text.add_discovery_bcon,"ax",@progbits
	.global add_discovery_bcon
add_discovery_bcon:
	.global L_8c22e4
L_8c22e4:
	push_s blink
L_8c22e6:
	bl L_8c02b4
L_8c22ea:
	mov_s r13,r0
L_8c22ec:
	mov_s r18,r1
L_8c22ee:
	mov_s r0,0x0
L_8c22f0:
	bl.d L_8c2c80
L_8c22f4:
	st.a r0,[sp,-0xc]
L_8c22f8:
	mov.f r15,r0
L_8c22fc:
	beq_s L_8c2336
	.global L_8c22fe
L_8c22fe:
	mov_s r14,r13
L_8c2300:
	add r14,r14,0x14f
L_8c2304:
	ldb_s r0,[r14]
L_8c2306:
	mov_s r1,0x0
L_8c2308:
	bset_s r0,r0,0x1
L_8c230a:
	stb_s r0,[r14]
L_8c230c:
	add_s r0,r14,0x5
L_8c230e:
	bl.d L_8e8264
L_8c2312:
	cmp r18,0x3
L_8c2316:
	mov_s r0,r14
L_8c2318:
	mov_s r1,0x1
L_8c231a:
	bl L_8e81bc
L_8c231e:
	add_s r0,r14,0x3
L_8c2320:
	bl L_8e827c
L_8c2324:
	add_s r0,r14,0x1
L_8c2326:
	mov_s r1,0x0
L_8c2328:
	bl L_8e81d4
L_8c232c:
	beq_s L_8c234c
L_8c232e:
	mov r16,0x2
L_8c2332:
	mov_s r17,r1
L_8c2334:
	b_s L_8c2366
	.global L_8c2336
L_8c2336:
	mov_s r0,blink
L_8c2338:
	mov_s r2,0x1012990
L_8c233e:
	mov_s r1,0x124f
L_8c2344:
	bl.d L_8c82c0
L_8c2348:
	mov_s r3,0x4f
L_8c234a:
	b_s L_8c22fe
	.global L_8c234c
L_8c234c:
	ldb_s r0,[r14]
L_8c234e:
	mov_s r2,0x3
L_8c2350:
	bset_s r0,r0,0x0
L_8c2352:
	stb_s r0,[r14]
L_8c2354:
	mov_s r0,r14
L_8c2356:
	mov_s r1,r2
L_8c2358:
	bl.d L_8e81bc
L_8c235c:
	mov_s r16,r2
L_8c235e:
	ld.as r0,[r13,0x8f]
L_8c2362:
	add2 r17,r0,0x19
	.global L_8c2366
L_8c2366:
	mov_s r1,sp
L_8c2368:
	mov_s r0,r15
L_8c236a:
	mov_s r2,r13
L_8c236c:
	bl.d L_8e4c34
L_8c2370:
	mov_s r3,0x0
L_8c2372:
	ld r5,[sp]
L_8c2376:
	mov_s r2,0x10129d8
L_8c237c:
	ldb_s r3,[r13,0x10]
L_8c237e:
	mov_s r0,0xc
L_8c2380:
	mov_s r1,0x2
L_8c2382:
	bl.d L_8ee034
L_8c2386:
	mov r4,r18
L_8c238a:
	mov_s r0,r15
L_8c238c:
	ldw r1,[sp]
L_8c2390:
	mov_s r2,0x0
L_8c2392:
	bl.d L_8e0748
L_8c2396:
	mov_s r3,0x1
L_8c2398:
	add_s r0,sp,0x4
L_8c239a:
	mov_s r1,r14
L_8c239c:
	bl.d L_8c0460
L_8c23a0:
	mov_s r2,0x8
L_8c23a2:
	ld_s r2,[sp,0x4]
L_8c23a4:
	mov_s r0,0x0
L_8c23a6:
	ld_s r3,[sp,0x8]
L_8c23a8:
	mov_s r1,r16
L_8c23aa:
	bl.d L_8d80dc
L_8c23ae:
	mov r4,r17
L_8c23b2:
	b.d L_8c0314
L_8c23b6:
	add_s sp,sp,0xc
