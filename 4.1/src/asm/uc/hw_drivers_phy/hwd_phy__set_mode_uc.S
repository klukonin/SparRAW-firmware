/* hwd_phy__set_mode_uc @ 0x927340, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: dma_mac_substep
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_phy__set_mode_uc,"ax",@progbits
	.global hwd_phy__set_mode_uc
hwd_phy__set_mode_uc:
	.global L_927340
L_927340:
	st.a r13,[sp,-0xc]
L_927344:
	st blink,[sp, 0x4]
L_927348:
	brne.d r0,0x1,L_927378
L_92734c:
	st_s r14,[sp,0x8]
L_92734e:
	mov r5,0x883000
L_927356:
	ld.as r1,[r5,0x70]
L_92735a:
	bic r1,r1,0x3f
L_92735e:
	or r1,r1,0x21
L_927362:
	st.as r1,[r5,0x70]
L_927366:
	ld.as r2,[r5,0x71]
L_92736a:
	bic r2,r2,0x3f
L_92736e:
	or r2,r2,0x21
L_927372:
	st.as r2,[r5,0x71]
L_927376:
	b_s L_927404
	.global L_927378
L_927378:
	ldb r4,[gp, -0xee]
L_92737c:
	bic.f r4,r4,0x3f
L_927380:
	bne L_927410
	.global L_927384
L_927384:
	mov_s r14,0x883000
L_92738a:
	ld.as r3,[r14,0x70]
L_92738e:
	ldb r9,[gp, -0xee]
L_927392:
	bic r10,r3,0x3f
L_927396:
	or r9,r9,r10
L_92739a:
	st.as r9,[r14,0x70]
L_92739e:
	ldb r2,[gp, -0xec]
L_9273a2:
	bic.f r2,r2,0x3f
L_9273a6:
	bne_s L_927428
	.global L_9273a8
L_9273a8:
	ld.as r11,[r14,0x71]
L_9273ac:
	ldb r6,[gp, -0xec]
L_9273b0:
	bic r5,r11,0x3f
L_9273b4:
	or r5,r5,r6
L_9273b8:
	st.as r5,[r14,0x71]
L_9273bc:
	ldb_s r0,[gp,-0xed]
L_9273be:
	bic.f r0,r0,0x3f
L_9273c2:
	bne_s L_927440
	.global L_9273c4
L_9273c4:
	ld.as r3,[r14,0x70]
L_9273c8:
	mov_s r13,0xfffff03f
L_9273ce:
	ldb r4,[gp, -0xed]
L_9273d2:
	and_s r3,r3,r13
L_9273d4:
	asl r4,r4,0x6
L_9273d8:
	or r3,r3,r4
L_9273dc:
	st.as r3,[r14,0x70]
L_9273e0:
	ldb r1,[gp, -0xeb]
L_9273e4:
	bic.f r1,r1,0x3f
L_9273e8:
	bne L_927458
	.global L_9273ec
L_9273ec:
	ld.as r7,[r14,0x71]
L_9273f0:
	ldb r8,[gp, -0xeb]
L_9273f4:
	and r7,r7,r13
L_9273f8:
	asl r8,r8,0x6
L_9273fc:
	or r7,r7,r8
L_927400:
	st.as r7,[r14,0x71]
	.global L_927404
L_927404:
	ld blink,[sp, 0x4]
L_927408:
	ld_s r14,[sp,0x8]
L_92740a:
	j_s.d [blink]
L_92740c:
	ld.ab r13,[sp,0xc]
	.global L_927410
L_927410:
	mov_s r0,blink
L_927412:
	mov_s r2,0x1003448
L_927418:
	mov r1,0xac
L_92741c:
	bl.d L_925548
L_927420:
	mov r3,0x204
L_927424:
	b L_927384
	.global L_927428
L_927428:
	mov_s r0,blink
L_92742a:
	mov_s r2,0x1003448
L_927430:
	mov r1,0xac
L_927434:
	bl.d L_925548
L_927438:
	mov r3,0x205
L_92743c:
	b L_9273a8
	.global L_927440
L_927440:
	mov_s r0,blink
L_927442:
	mov_s r2,0x1003448
L_927448:
	mov r1,0xac
L_92744c:
	bl.d L_925548
L_927450:
	mov r3,0x206
L_927454:
	b L_9273c4
	.global L_927458
L_927458:
	mov_s r0,blink
L_92745a:
	mov_s r2,0x1003448
L_927460:
	mov r1,0xac
L_927464:
	bl.d L_925548
L_927468:
	mov r3,0x207
L_92746c:
	b_s L_9273ec
L_92746e:
	nop_s
