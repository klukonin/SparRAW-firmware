/* txss__store_sector_ranking @ 0x93e210, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_init__flow, txss_resp__flow
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, memcpy_uc, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss__store_sector_ranking
txss__store_sector_ranking:
	.global L_93e210
L_93e210:
	push_s blink
L_93e212:
	bl L_920224
L_93e216:
	sub_s sp,sp,0x3c
L_93e218:
	mov_s r17,r0
L_93e21a:
	mov_s r18,r1
L_93e21c:
	mov_s r13,0x0
L_93e21e:
	mov_s r14,0x80212c
L_93e224:
	add3 r16,r14,0x9
L_93e228:
	mov_s r15,0x5
	.global L_93e22a
L_93e22a:
	rsub r0,r13,0x4
L_93e22e:
	ld.as r1,[r16,r0]
L_93e232:
	asl_s r0,r13,0x2
L_93e234:
	add1_s r0,r0,r0
L_93e236:
	add_s r0,r0,sp
L_93e238:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93e23a:
	add1_s r1,r1,r1
L_93e23c:
	add_s r1,r1,r14
L_93e23e:
	add_s r1,r1,0xc
L_93e240:
	bl.d L_920330
L_93e244:
	mov_s r2,0xc
L_93e246:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_93e248:
	brhs.d r15,0x1,L_93e22a
L_93e24c:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_93e24e:
	mov lp_count,0x5
L_93e252:
	mov_s r1,0x0
L_93e254:
	lp L_93e260
L_93e258:
	add2 r12,r16,r1
L_93e25c:
	st_s r1,[r12]
L_93e25e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_93e260
L_93e260:
	add r0,r14,0xc
L_93e264:
	mov_s r1,sp
L_93e266:
	bl.d L_920330
L_93e26a:
	mov_s r2,0x3c
L_93e26c:
	breq r18,0x0,L_93e27e
L_93e270:
	breq r18,0x1,L_93e2a2
L_93e274:
	mov_s r0,blink
L_93e276:
	bl.d L_926618
L_93e27a:
	mov_s r1,0x1f
L_93e27c:
	b_s L_93e2b8
	.global L_93e27e
L_93e27e:
	mul64 r17,0x3c
L_93e282:
	add r1,r14,0xc
L_93e286:
	add r0,mlo,0x857c1c
L_93e28e:
	bl.d L_920330
L_93e292:
	mov_s r2,0x3c
L_93e294:
	ldb r1,[r14, 0x66]
L_93e298:
	bset r1,r1,r17
L_93e29c:
	stb r1,[r14, 0x66]
L_93e2a0:
	b_s L_93e2b8
	.global L_93e2a2
L_93e2a2:
	mul64 r17,0x3c
L_93e2a6:
	add r1,r14,0xc
L_93e2aa:
	add r0,mlo,0x857a00
L_93e2b2:
	bl.d L_920330
L_93e2b6:
	mov_s r2,0x3c
	.global L_93e2b8
L_93e2b8:
	b.d L_920284
L_93e2bc:
	add_s sp,sp,0x3c
L_93e2be:
	nop_s
L_93e2c0:
	ldb r0,[0x80072c]
L_93e2c8:
	sub.f r0,r0,0x1
L_93e2cc:
	beq L_93e338
L_93e2d0:
	lr r0,[0x7b]
L_93e2d4:
	and r1,r0,0xff
L_93e2dc:
	sub.f 0x0,r1,0x1
L_93e2e0:
	beq L_93e308
L_93e2e4:
	sub.f 0x0,r1,0x4
L_93e2e8:
	beq L_93e308
L_93e2ec:
	flag 0x1
L_93e2f0:
	mov 0x0,0x0
L_93e2f4:
	mov 0x0,0x0
L_93e2f8:
	mov 0x0,0x0
L_93e2fc:
	mov 0x0,0x0
L_93e300:
	mov 0x0,0x0
L_93e304:
	mov 0x0,0x0
	.global L_93e308
L_93e308:
	lr r0,[0x7d]
L_93e30c:
	and r1,r0,0xff
L_93e314:
	sub.f 0x0,r1,0x0
L_93e318:
	bne L_93e338
L_93e31c:
	flag 0x1
L_93e320:
	mov 0x0,0x0
L_93e324:
	mov 0x0,0x0
L_93e328:
	mov 0x0,0x0
L_93e32c:
	mov 0x0,0x0
L_93e330:
	mov 0x0,0x0
L_93e334:
	mov 0x0,0x0
	.global L_93e338
L_93e338:
	j [blink]
