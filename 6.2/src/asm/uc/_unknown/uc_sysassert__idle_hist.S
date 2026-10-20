/* uc_sysassert__idle_hist @ 0x926478, 416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   IDLE SM histogram on SYSASSERT (%d iterations with 16 CLK delay):
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_IDLE_STATE]   = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_CCA1_STATE]   = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_CCA2_STATE]   = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_CCA_RX_STATE] = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_CCA_NAV_STATE]= %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_SIFS_STATE]   = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_TX_STATE]     = %d
 * Зовут его: uc_sysassert
 * Зовёт сам: uc_log__emit1, uc_sysassert__read_hw_state3
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_sysassert__idle_hist
uc_sysassert__idle_hist:
	.global L_926478
L_926478:
	st.a r13,[sp,-0x10]
L_92647c:
	st blink,[sp, 0x4]
L_926480:
	st_s r14,[sp,0x8]
L_926482:
	ld.as r8,[gp,-0x11]
L_926486:
	st_s r15,[sp,0xc]
L_926488:
	and r8,r8,0xffff0fff
L_926490:
	st.as r8,[gp,-0x11]
L_926494:
	or r8,r8,0x1d000000
L_92649c:
	mov r32,r8
L_9264a0:
	st.ab r8,[r25,0x4]
L_9264a4:
	bclr r25,r25,0xa
L_9264a8:
	nop_s
L_9264aa:
	nop_s
L_9264ac:
	nop_s
L_9264ae:
	mov_s r15,0x800758
L_9264b4:
	mov_s r13,0x800768
L_9264ba:
	mov_s r14,0x4e20
	.global L_9264c0
L_9264c0:
	nop_s
L_9264c2:
	nop_s
L_9264c4:
	nop_s
L_9264c6:
	nop_s
L_9264c8:
	nop_s
L_9264ca:
	nop_s
L_9264cc:
	nop_s
L_9264ce:
	nop_s
L_9264d0:
	nop_s
L_9264d2:
	nop_s
L_9264d4:
	nop_s
L_9264d6:
	nop_s
L_9264d8:
	nop_s
L_9264da:
	nop_s
L_9264dc:
	nop_s
L_9264de:
	nop_s
L_9264e0:
	bmsk r3,r40,0x2
L_9264e4:
	add1 r4,r15,r3
L_9264e8:
	ldw r5,[r4]
L_9264ec:
	add r5,r5,0x1
L_9264f0:
	bl.d L_929ae4
L_9264f4:
	stw r5,[r4]
L_9264f8:
	brge r0,0x3,L_926510
L_9264fc:
	add2 r6,r13,r0
L_926500:
	ld r7,[r6]
L_926504:
	add r7,r7,0x1
L_926508:
	b.d L_926518
L_92650c:
	st r7,[r6]
	.global L_926510
L_926510:
	ld_s r2,[r13,0xc]
L_926512:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_926514:
	st r2,[r13, 0xc]
	.global L_926518
L_926518:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_92651a:
	brhs r14,0x1,L_9264c0
L_92651e:
	mov_s r1,0x10002f4
L_926524:
	mov r2,0x4e20
L_92652c:
	bl.d L_92d1d0
L_926530:
	mov r0,0x20
L_926534:
	mov_s r1,0x1000338
L_92653a:
	mov_s r0,0x20
L_92653c:
	bl.d L_92d1d0
L_926540:
	ldw r2,[r15]
L_926544:
	mov_s r1,0x1000374
L_92654a:
	mov_s r0,0x20
L_92654c:
	bl.d L_92d1d0
L_926550:
	ldw r2,[r15, 0x2]
L_926554:
	mov_s r1,0x10003b0
L_92655a:
	mov_s r0,0x20
L_92655c:
	bl.d L_92d1d0
L_926560:
	ldw r2,[r15, 0x4]
L_926564:
	mov_s r1,0x10003ec
L_92656a:
	mov_s r0,0x20
L_92656c:
	bl.d L_92d1d0
L_926570:
	ldw r2,[r15, 0x6]
L_926574:
	mov_s r1,0x1000428
L_92657a:
	mov_s r0,0x20
L_92657c:
	bl.d L_92d1d0
L_926580:
	ldw r2,[r15, 0x8]
L_926584:
	mov_s r1,0x1000464
L_92658a:
	mov_s r0,0x20
L_92658c:
	bl.d L_92d1d0
L_926590:
	ldw r2,[r15, 0xa]
L_926594:
	mov_s r1,0x10004a0
L_92659a:
	mov_s r0,0x20
L_92659c:
	bl.d L_92d1d0
L_9265a0:
	ldw r2,[r15, 0xc]
L_9265a4:
	mov_s r1,0x10004dc
L_9265aa:
	mov_s r0,0x20
L_9265ac:
	bl.d L_92d1d0
L_9265b0:
	ldw r2,[r15, 0xe]
L_9265b4:
	mov_s r1,0x1000518
L_9265ba:
	mov_s r2,0x4e20
L_9265c0:
	bl.d L_92d1d0
L_9265c4:
	mov r0,0x20
L_9265c8:
	mov_s r1,0x1000560
L_9265ce:
	mov_s r0,0x20
L_9265d0:
	bl.d L_92d1d0
L_9265d4:
	ld r2,[r13]
L_9265d8:
	mov_s r1,0x1000584
L_9265de:
	mov_s r0,0x20
L_9265e0:
	bl.d L_92d1d0
L_9265e4:
	ld r2,[r13, 0x4]
L_9265e8:
	mov_s r1,0x10005a8
L_9265ee:
	mov_s r0,0x20
L_9265f0:
	bl.d L_92d1d0
L_9265f4:
	ld r2,[r13, 0x8]
L_9265f8:
	mov_s r1,0x10005cc
L_9265fe:
	mov_s r0,0x20
L_926600:
	bl.d L_92d1d0
L_926604:
	ld r2,[r13, 0xc]
L_926608:
	ld blink,[sp, 0x4]
L_92660c:
	ld_s r14,[sp,0x8]
L_92660e:
	ld_s r15,[sp,0xc]
L_926610:
	j.d [blink]
L_926614:
	ld.ab r13,[sp,0x10]
