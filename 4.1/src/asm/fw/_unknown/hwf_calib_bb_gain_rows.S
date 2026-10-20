/* hwf_calib_bb_gain_rows @ 0x8d2064, 1056 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *         Reference row wasn't found. cntr = %d, indexs = %x, dc = %x
 *         Gain measure is out of BOUND VGA_INDEX_%d, vga_idx_vec = %x, sat/quant = %x
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf_calib_bb_gain_alg
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, calib_bb_gain__pack_row, calib_row_step, calib_vga_coarse, frag_8d93cc, fw_log__emit3, hwd_abif__set_agc_column, memcpy_fw
 */
	.section .text.hwf_calib_bb_gain_rows,"ax",@progbits
	.global hwf_calib_bb_gain_rows
hwf_calib_bb_gain_rows:
	.global L_8d2064
L_8d2064:
	sub_s sp,sp,0x20
L_8d2066:
	push_s blink
L_8d2068:
	bl L_8c0298
L_8d206c:
	sub sp,sp,0x98
L_8d2070:
	mov_s r17,r0
L_8d2072:
	st r0,[sp, 0xd0]
L_8d2076:
	mov_s r18,r1
L_8d2078:
	mov_s r21,r2
L_8d207a:
	st_s r3,[sp,0x40]
L_8d207c:
	st r4,[sp, 0x44]
L_8d2080:
	st r5,[sp, 0x48]
L_8d2084:
	st r5,[sp, 0xe4]
L_8d2088:
	st r6,[sp, 0x4c]
L_8d208c:
	st r6,[sp, 0xe8]
L_8d2090:
	st r7,[sp, 0x3c]
L_8d2094:
	st r7,[sp, 0xec]
L_8d2098:
	mov_s r13,0x1
L_8d209a:
	mov_s r0,0x802f14
L_8d20a0:
	ld_s r0,[r0,0x4]
L_8d20a2:
	st_s r13,[sp,0x58]
L_8d20a4:
	st_s r0,[sp,0x5c]
L_8d20a6:
	mov r19,0x0
L_8d20aa:
	stb r19,[sp, 0x6c]
L_8d20ae:
	add_s r14,sp,0x5c
L_8d20b0:
	mov_s r0,sp
L_8d20b2:
	add3 r1,sp,0x1d
L_8d20b6:
	bl.d L_8c0460
L_8d20ba:
	mov_s r2,0xc
L_8d20bc:
	st_s r13,[sp,0xc]
L_8d20be:
	st r19,[sp, 0x10]
L_8d20c2:
	add3 r23,sp,0xe
L_8d20c6:
	st r23,[sp, 0x14]
L_8d20ca:
	add3 r0,sp,0x10
L_8d20ce:
	st_s r0,[sp,0x50]
L_8d20d0:
	st_s r0,[sp,0x18]
L_8d20d2:
	ld r5,[sp, 0x40]
L_8d20d6:
	mov_s r0,0x28
L_8d20d8:
	ld r6,[sp, 0x44]
L_8d20dc:
	mov_s r1,r14
L_8d20de:
	mov_s r2,r17
L_8d20e0:
	mov_s r3,r18
L_8d20e2:
	mov r4,r21
L_8d20e6:
	bl.d L_8d1fb8
L_8d20ea:
	ld r7,[sp, 0x48]
L_8d20ee:
	ld_s r0,[sp,0x58]
L_8d20f0:
	b_s L_8d20f6
	.global L_8d20f2
L_8d20f2:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d20f4:
	extb_s r13,r13
	.global L_8d20f6
L_8d20f6:
	cmp_s r13,0x4
L_8d20f8:
	bhi L_8d2478
L_8d20fc:
	cmp_s r0,0x1
L_8d20fe:
	bne L_8d2478
L_8d2102:
	mov r20,0x1
L_8d2106:
	stb r20,[sp, 0x7c]
L_8d210a:
	stb r20,[sp, 0x7d]
L_8d210e:
	ld_s r0,[sp,0x5c]
L_8d2110:
	st r19,[sp, 0x78]
L_8d2114:
	st_s r0,[sp,0x64]
L_8d2116:
	add2 r24,sp,0x19
L_8d211a:
	st_s r0,[sp,0x68]
L_8d211c:
	add3 r25,sp,0xd
L_8d2120:
	mov_s r0,0x28
L_8d2122:
	mov_s r1,0x0
L_8d2124:
	bl.d L_8cc050
L_8d2128:
	ld_s r2,[sp,0x50]
L_8d212a:
	stb_s r13,[sp,0x6c]
L_8d212c:
	st r19,[sp, 0x90]
L_8d2130:
	mov_s r0,0x4
L_8d2132:
	stb r0,[sp, 0x94]
L_8d2136:
	brne r13,0x4,L_8d2140
L_8d213a:
	mov_s r0,0x3
L_8d213c:
	stb r0,[sp, 0x94]
	.global L_8d2140
L_8d2140:
	cmp_s r13,0x1
L_8d2142:
	mov_s r15,0x0
L_8d2144:
	ld_s r0,[sp,0x58]
L_8d2146:
	bne_s L_8d229e
L_8d2148:
	mov_s r22,r15
L_8d214a:
	b_s L_8d2260
	.global L_8d214c
L_8d214c:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d214e:
	ld_s r0,[sp,0x64]
L_8d2150:
	extb_s r15,r15
L_8d2152:
	st_s r0,[sp,0x60]
L_8d2154:
	add_s r14,sp,0x60
L_8d2156:
	mov_s r0,sp
L_8d2158:
	add3 r1,sp,0x1d
L_8d215c:
	bl.d L_8c0460
L_8d2160:
	mov_s r2,0xc
L_8d2162:
	ldb_s r0,[sp,0x6c]
L_8d2164:
	st r19,[sp, 0xc]
L_8d2168:
	st_s r0,[sp,0x10]
L_8d216a:
	st r23,[sp, 0x14]
L_8d216e:
	add2 r16,sp,0x21
L_8d2172:
	st r16,[sp, 0x18]
L_8d2176:
	ld r5,[sp, 0x40]
L_8d217a:
	mov_s r0,0x28
L_8d217c:
	ld r6,[sp, 0x44]
L_8d2180:
	mov_s r1,r14
L_8d2182:
	mov_s r2,r17
L_8d2184:
	mov_s r3,r18
L_8d2186:
	mov r4,r21
L_8d218a:
	bl.d L_8d1fb8
L_8d218e:
	ld r7,[sp, 0x48]
L_8d2192:
	mov_s r0,sp
L_8d2194:
	add2 r1,sp,0x39
L_8d2198:
	bl.d L_8c0460
L_8d219c:
	mov_s r2,0x10
L_8d219e:
	ld_s r0,[sp,0x70]
L_8d21a0:
	mov_s r2,r14
L_8d21a2:
	ld_s r1,[sp,0x74]
L_8d21a4:
	mov_s r3,r17
L_8d21a6:
	ld r6,[sp, 0x40]
L_8d21aa:
	mov r4,r18
L_8d21ae:
	mov r5,r21
L_8d21b2:
	bl.d L_8d93cc
L_8d21b6:
	ld r7,[sp, 0x44]
L_8d21ba:
	ld r0,[sp, 0xf0]
L_8d21be:
	ld_s r1,[sp,0x70]
L_8d21c0:
	st_s r0,[sp,0x0]
L_8d21c2:
	ld_s r0,[sp,0x74]
L_8d21c4:
	st_s r1,[sp,0x4]
L_8d21c6:
	st_s r0,[sp,0x8]
L_8d21c8:
	ld_s r0,[sp,0x7c]
L_8d21ca:
	mov_s r2,r21
L_8d21cc:
	ld_s r1,[sp,0x78]
L_8d21ce:
	st_s r1,[sp,0xc]
L_8d21d0:
	st_s r0,[sp,0x10]
L_8d21d2:
	st r25,[sp, 0x14]
L_8d21d6:
	st_s r14,[sp,0x18]
L_8d21d8:
	st r24,[sp, 0x1c]
L_8d21dc:
	add3 r0,sp,0x11
L_8d21e0:
	st_s r0,[sp,0x20]
L_8d21e2:
	add3 r0,sp,0x12
L_8d21e6:
	st_s r0,[sp,0x24]
L_8d21e8:
	add2 r0,sp,0x25
L_8d21ec:
	st_s r0,[sp,0x28]
L_8d21ee:
	st_s r13,[sp,0x2c]
L_8d21f0:
	add_s r0,sp,0x6c
L_8d21f2:
	st_s r0,[sp,0x30]
L_8d21f4:
	st r20,[sp, 0x34]
L_8d21f8:
	add_s r0,sp,0x58
L_8d21fa:
	st_s r0,[sp,0x38]
L_8d21fc:
	ld_s r3,[sp,0x40]
L_8d21fe:
	mov_s r0,r17
L_8d2200:
	ld r4,[sp, 0x44]
L_8d2204:
	mov_s r1,r18
L_8d2206:
	ld r5,[sp, 0x48]
L_8d220a:
	ld r6,[sp, 0x4c]
L_8d220e:
	bl.d L_8d2590
L_8d2212:
	ld r7,[sp, 0x3c]
L_8d2216:
	mov_s r22,r0
L_8d2218:
	ld_s r0,[sp,0x60]
L_8d221a:
	ld_s r1,[sp,0x70]
L_8d221c:
	st_s r0,[sp,0x68]
L_8d221e:
	ld r0,[sp, 0x84]
L_8d2222:
	st_s r1,[sp,0x78]
L_8d2224:
	st r0,[sp, 0x88]
L_8d2228:
	ld_s r0,[sp,0x74]
L_8d222a:
	st_s r0,[sp,0x7c]
L_8d222c:
	mov r20,0x0
L_8d2230:
	breq r15,0x14,L_8d2238
L_8d2234:
	ld_s r0,[sp,0x58]
L_8d2236:
	b_s L_8d2260
	.global L_8d2238
L_8d2238:
	mov_s r0,r14
L_8d223a:
	bl.d L_8e46fc
L_8d223e:
	mov_s r1,0x1
L_8d2240:
	mov_s r4,r0
L_8d2242:
	mov_s r0,r16
L_8d2244:
	bl.d L_8e46fc
L_8d2248:
	mov_s r1,r20
L_8d224a:
	mov_s r5,r0
L_8d224c:
	mov_s r2,0x1017be8
L_8d2252:
	mov_s r0,0x6
L_8d2254:
	mov_s r1,r20
L_8d2256:
	bl.d L_8ee034
L_8d225a:
	mov_s r3,r15
L_8d225c:
	mov_s r0,0x2
L_8d225e:
	st_s r0,[sp,0x58]
	.global L_8d2260
L_8d2260:
	cmp r22,0x0
L_8d2264:
	cmp.eq r0,0x1
L_8d2268:
	beq_s L_8d214c
L_8d226a:
	ld r22,[sp, 0xf4]
L_8d226e:
	ldb_s r1,[sp,0x60]
L_8d2270:
	ld r20,[sp, 0x70]
L_8d2274:
	stb r1,[r22, 0x4]
L_8d2278:
	ldb r1,[sp, 0x61]
L_8d227c:
	st r20,[r22]
L_8d2280:
	stb r1,[r22, 0x5]
L_8d2284:
	ldb r1,[sp, 0x62]
L_8d2288:
	stb r1,[r22, 0x6]
L_8d228c:
	ldb r1,[sp, 0x63]
L_8d2290:
	stb r1,[r22, 0x7]
L_8d2294:
	ld r1,[sp, 0x84]
L_8d2298:
	st r1,[sp, 0x8c]
L_8d229c:
	b_s L_8d22b4
	.global L_8d229e
L_8d229e:
	ld r22,[sp, 0xf4]
L_8d22a2:
	ld r1,[r22, 0x4]
L_8d22a6:
	ld r20,[r22]
L_8d22aa:
	st_s r1,[sp,0x60]
L_8d22ac:
	ld r1,[sp, 0x8c]
L_8d22b0:
	st r1,[sp, 0x84]
	.global L_8d22b4
L_8d22b4:
	add r1,r22,0x3
L_8d22b8:
	st_s r1,[sp,0x54]
L_8d22ba:
	mov_s r15,0x1
L_8d22bc:
	b_s L_8d22d6
	.global L_8d22be
L_8d22be:
	ld r0,[sp, 0xf8]
L_8d22c2:
	asl_s r1,r13,0x5
L_8d22c4:
	add_s r0,r0,r1
L_8d22c6:
	sub r0,r0,0x24
L_8d22ca:
	add2_s r0,r0,r15
L_8d22cc:
	st r19,[r0]
	.global L_8d22d0
L_8d22d0:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d22d2:
	extb_s r15,r15
L_8d22d4:
	ld_s r0,[sp,0x58]
	.global L_8d22d6
L_8d22d6:
	add r25,sp,r13
L_8d22da:
	ldb r1,[r25, 0xcf]
L_8d22de:
	cmp_s r15,r1
L_8d22e0:
	bgt L_8d20f2
L_8d22e4:
	cmp_s r0,0x1
L_8d22e6:
	bne_s L_8d20f2
L_8d22e8:
	ld_s r0,[sp,0x54]
L_8d22ea:
	ldb_s r0,[r0,r13]
L_8d22ec:
	breq r15,r0,L_8d22be
L_8d22f0:
	add3 r16,sp,0xc
L_8d22f4:
	brlo.d r13,0x2,L_8d23c8
L_8d22f8:
	add2 r24,sp,0x21
L_8d22fc:
	cmp_s r0,0x2
L_8d22fe:
	cmp.ne r0,0x1
L_8d2302:
	cmp.eq r15,0x4
L_8d2306:
	bne_s L_8d23c8
L_8d2308:
	ld r0,[r22, 0x4]
L_8d230c:
	cmp_s r13,0x4
L_8d230e:
	st_s r0,[sp,0x60]
L_8d2310:
	ld r0,[sp, 0x8c]
L_8d2314:
	st r0,[sp, 0x84]
L_8d2318:
	mov.eq r0,0x3
L_8d231c:
	mov.eq r14,0x2
L_8d2320:
	beq_s L_8d2332
L_8d2322:
	cmp_s r13,0x3
L_8d2324:
	mov_s r14,0x2
L_8d2326:
	mov.eq r0,0x4
L_8d232a:
	mov.ne r0,0x4
L_8d232e:
	mov.ne r14,0x3
	.global L_8d2332
L_8d2332:
	add r2,sp,r0
L_8d2336:
	add r1,sp,r14
L_8d233a:
	ldb r2,[r2, 0x5f]
L_8d233e:
	ldb r1,[r1, 0x5f]
L_8d2342:
	brge r2,r1,L_8d234c
L_8d2346:
	stb r14,[sp, 0x94]
L_8d234a:
	b_s L_8d2352
	.global L_8d234c
L_8d234c:
	stb r0,[sp, 0x94]
L_8d2350:
	mov_s r14,r0
	.global L_8d2352
L_8d2352:
	add r0,sp,r14
L_8d2356:
	ldb r1,[r0, 0x5f]
L_8d235a:
	brlt r1,0x1,L_8d23c8
L_8d235e:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8d2360:
	stb r1,[r0, 0x5f]
L_8d2364:
	stb_s r14,[sp,0x6c]
L_8d2366:
	mov_s r0,sp
L_8d2368:
	add3 r1,sp,0x1d
L_8d236c:
	bl.d L_8c0460
L_8d2370:
	mov_s r2,0xc
L_8d2372:
	st r19,[sp, 0xc]
L_8d2376:
	st_s r14,[sp,0x10]
L_8d2378:
	st r23,[sp, 0x14]
L_8d237c:
	st r24,[sp, 0x18]
L_8d2380:
	ld r5,[sp, 0x40]
L_8d2384:
	mov_s r0,0x28
L_8d2386:
	ld r6,[sp, 0x44]
L_8d238a:
	mov_s r1,r16
L_8d238c:
	mov_s r2,r17
L_8d238e:
	mov_s r3,r18
L_8d2390:
	mov r4,r21
L_8d2394:
	bl.d L_8d1fb8
L_8d2398:
	ld r7,[sp, 0x48]
L_8d239c:
	mov_s r0,sp
L_8d239e:
	add2 r1,sp,0x39
L_8d23a2:
	bl.d L_8c0460
L_8d23a6:
	mov_s r2,0x10
L_8d23a8:
	ld_s r0,[sp,0x70]
L_8d23aa:
	mov_s r2,r16
L_8d23ac:
	ld_s r1,[sp,0x74]
L_8d23ae:
	mov_s r3,r17
L_8d23b0:
	ld r6,[sp, 0x40]
L_8d23b4:
	mov r4,r18
L_8d23b8:
	mov r5,r21
L_8d23bc:
	bl.d L_8d93cc
L_8d23c0:
	ld r7,[sp, 0x44]
L_8d23c4:
	ld r20,[sp, 0x70]
	.global L_8d23c8
L_8d23c8:
	stb_s r13,[sp,0x6c]
L_8d23ca:
	stb r15,[r25, 0x5f]
L_8d23ce:
	mov_s r0,sp
L_8d23d0:
	add3 r1,sp,0x1d
L_8d23d4:
	bl.d L_8c0460
L_8d23d8:
	mov_s r2,0xc
L_8d23da:
	st r19,[sp, 0xc]
L_8d23de:
	st_s r13,[sp,0x10]
L_8d23e0:
	st r23,[sp, 0x14]
L_8d23e4:
	st r24,[sp, 0x18]
L_8d23e8:
	ld r5,[sp, 0x40]
L_8d23ec:
	mov_s r0,0x28
L_8d23ee:
	ld r6,[sp, 0x44]
L_8d23f2:
	mov_s r1,r16
L_8d23f4:
	mov_s r2,r17
L_8d23f6:
	mov_s r3,r18
L_8d23f8:
	mov r4,r21
L_8d23fc:
	bl.d L_8d1fb8
L_8d2400:
	ld r7,[sp, 0x48]
L_8d2404:
	mov_s r0,sp
L_8d2406:
	add2 r1,sp,0x39
L_8d240a:
	bl.d L_8c0460
L_8d240e:
	mov_s r2,0x10
L_8d2410:
	ld_s r0,[sp,0x70]
L_8d2412:
	mov_s r2,r16
L_8d2414:
	ld_s r1,[sp,0x74]
L_8d2416:
	mov_s r3,r17
L_8d2418:
	ld r6,[sp, 0x40]
L_8d241c:
	mov r4,r18
L_8d2420:
	mov r5,r21
L_8d2424:
	bl.d L_8d93cc
L_8d2428:
	ld r7,[sp, 0x44]
L_8d242c:
	ldb_s r0,[sp,0x74]
L_8d242e:
	brne_s r0,0,L_8d2436
L_8d2430:
	ldb r0,[sp, 0x75]
L_8d2434:
	breq_s r0,0,L_8d2460
	.global L_8d2436
L_8d2436:
	mov_s r0,r16
L_8d2438:
	bl.d L_8e46fc
L_8d243c:
	mov_s r1,0x1
L_8d243e:
	mov_s r4,r0
L_8d2440:
	ldb_s r0,[sp,0x74]
L_8d2442:
	mov_s r2,0x1017c2c
L_8d2448:
	ldb r1,[sp, 0x75]
L_8d244c:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8d244e:
	add r5,r0,r1
L_8d2452:
	mov_s r0,0x6
L_8d2454:
	mov_s r1,0x1
L_8d2456:
	bl.d L_8ee034
L_8d245a:
	mov_s r3,r13
L_8d245c:
	mov_s r0,0x2
L_8d245e:
	st_s r0,[sp,0x58]
	.global L_8d2460
L_8d2460:
	ld r1,[sp, 0xf8]
L_8d2464:
	asl_s r0,r13,0x5
L_8d2466:
	add_s r1,r1,r0
L_8d2468:
	ld_s r0,[sp,0x70]
L_8d246a:
	sub r1,r1,0x24
L_8d246e:
	sub r0,r0,r20
L_8d2472:
	add2_s r1,r1,r15
L_8d2474:
	st_s r0,[r1]
L_8d2476:
	b_s L_8d22d0
	.global L_8d2478
L_8d2478:
	mov_s r12,0x24
L_8d247a:
	b.d L_8c02de
L_8d247e:
	add sp,sp,0x98
L_8d2482:
	nop_s
