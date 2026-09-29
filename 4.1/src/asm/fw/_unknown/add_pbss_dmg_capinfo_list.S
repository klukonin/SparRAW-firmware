/* add_pbss_dmg_capinfo_list @ 0x8c2498, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   add_pbss_dmg_capinfo_list() AID = %d
 *   AID = %d, was not added to PBSS sta list
 *   AID = %d, was added to PBSS sta list MAC ADDR: ADDR-%04X%08X
 *   VERIFY AID = %d, was added to PBSS sta list MAC ADDR: ADDR-%04X%08X
 * Зовут его: pbss_sta_list_update
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_log__emit3, memcpy_fw
 */
	.section .text.add_pbss_dmg_capinfo_list,"ax",@progbits
	.global add_pbss_dmg_capinfo_list
add_pbss_dmg_capinfo_list:
	.global L_8c2498
L_8c2498:
	push_s blink
L_8c249a:
	bl L_8c02c4
L_8c249e:
	mov_s r13,r0
L_8c24a0:
	mov_s r14,r1
L_8c24a2:
	mov_s r2,0x100b0d8
L_8c24a8:
	mov_s r0,0xb
L_8c24aa:
	mov_s r1,0x2
L_8c24ac:
	bl.d L_8edfcc
L_8c24b0:
	ldb_s r3,[r14,0x6]
L_8c24b2:
	add3 r0,r13,0xc
L_8c24b6:
	ldb_s r3,[r14,0x6]
L_8c24b8:
	mul64 r3,0x11
L_8c24bc:
	add_s r0,r0,mlo
L_8c24be:
	ldb_s r1,[r0,0x15]
L_8c24c0:
	brne r3,r1,L_8c24d6
L_8c24c4:
	mov_s r2,0x100b100
L_8c24ca:
	mov_s r0,0xb
L_8c24cc:
	bl.d L_8edfcc
L_8c24d0:
	mov_s r1,0x2
L_8c24d2:
	mov_s r0,0x0
L_8c24d4:
	b_s L_8c2564
	.global L_8c24d6
L_8c24d6:
	add_s r0,r0,0xf
L_8c24d8:
	mov_s r1,r14
L_8c24da:
	bl.d L_8c0460
L_8c24de:
	mov_s r2,0x11
L_8c24e0:
	ldb_s r0,[r14,0x5]
L_8c24e2:
	ldb r4,[r14, 0x4]
L_8c24e6:
	asl_s r0,r0,0x8
L_8c24e8:
	or r4,r4,r0
L_8c24ec:
	ldb_s r0,[r14,0x1]
L_8c24ee:
	ldb r5,[r14]
L_8c24f2:
	asl_s r0,r0,0x8
L_8c24f4:
	or r5,r5,r0
L_8c24f8:
	ldb_s r0,[r14,0x2]
L_8c24fa:
	mov_s r2,0x100b12c
L_8c2500:
	asl_s r0,r0,0x10
L_8c2502:
	or r5,r5,r0
L_8c2506:
	ldb_s r0,[r14,0x3]
L_8c2508:
	mov_s r1,0x2
L_8c250a:
	asl_s r0,r0,0x18
L_8c250c:
	or r5,r5,r0
L_8c2510:
	mov_s r0,0xb
L_8c2512:
	bl.d L_8ee034
L_8c2516:
	ldb_s r3,[r14,0x6]
L_8c2518:
	ldb_s r0,[r14,0x6]
L_8c251a:
	mov_s r2,0x100b16c
L_8c2520:
	mul64 r0,0x11
L_8c2524:
	add_s r13,r13,mlo
L_8c2526:
	ldb r0,[r13, 0x74]
L_8c252a:
	ldb r4,[r13, 0x73]
L_8c252e:
	asl_s r0,r0,0x8
L_8c2530:
	or r4,r4,r0
L_8c2534:
	ldb r0,[r13, 0x70]
L_8c2538:
	ldb r5,[r13, 0x6f]
L_8c253c:
	asl_s r0,r0,0x8
L_8c253e:
	or r5,r5,r0
L_8c2542:
	ldb r0,[r13, 0x71]
L_8c2546:
	mov_s r1,0x2
L_8c2548:
	asl_s r0,r0,0x10
L_8c254a:
	or r5,r5,r0
L_8c254e:
	ldb r0,[r13, 0x72]
L_8c2552:
	asl_s r0,r0,0x18
L_8c2554:
	or r5,r5,r0
L_8c2558:
	mov_s r0,0xb
L_8c255a:
	bl.d L_8ee034
L_8c255e:
	ldb r3,[r13, 0x75]
L_8c2562:
	mov_s r0,0x1
	.global L_8c2564
L_8c2564:
	b L_8c0334
