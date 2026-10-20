/* direct_tx_step @ 0x929488, 452 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_program_c
 * Зовёт сам: direct_tx__build_desc, direct_tx__issue_cmd_33, direct_tx__program_cmd34, direct_tx__push_payload, get_g_80087c, mac__build_tx_common_params, mac__program_tx_common, mac__select_sector_and_wait_b, uc_spin_until_event, uc_wait_direct_tx_ready
 * Глобалы (через gp): 0x800604, 0x800610, 0x800614
 */
	.section .text.direct_tx_step,"ax",@progbits
	.global direct_tx_step
direct_tx_step:
	.global L_929488
L_929488:
	st.a r13,[sp,-0x8]
L_92948c:
	st blink,[sp, 0x4]
L_929490:
	sub_s sp,sp,0x18
L_929492:
	mov_s r13,r0
L_929494:
	ld.as r9,[gp,-0x4]
L_929498:
	ldb r10,[r0, 0xb]
L_92949c:
	or r1,r9,0x30
L_9294a0:
	asl r10,r10,0x8
L_9294a4:
	mov_s r0,0x1
L_9294a6:
	or r1,r1,r10
L_9294aa:
	mov_s r2,0x0
L_9294ac:
	bl.d L_92bb2c
L_9294b0:
	mov r3,r2
L_9294b4:
	mov r9,0x15000000
L_9294bc:
	mov r32,r9
L_9294c0:
	st.ab r9,[r25,0x4]
L_9294c4:
	bclr r25,r25,0xa
L_9294c8:
	mov_s r0,0x14000007
L_9294ce:
	mov_s r32,r0
L_9294d0:
	st.ab r0,[r25,0x4]
L_9294d4:
	bclr r25,r25,0xa
L_9294d8:
	mov r1,sp
L_9294dc:
	bl.d L_92902c
L_9294e0:
	mov r0,r13
L_9294e4:
	mov r0,0x10
L_9294e8:
	bl.d L_924ea8
L_9294ec:
	mov r1,0x18
L_9294f0:
	bl L_92a3c0
L_9294f4:
	mov_s r1,0x2008000
L_9294fa:
	mov_s r32,r1
L_9294fc:
	st.ab r1,[r25,0x4]
L_929500:
	bclr r25,r25,0xa
L_929504:
	ld.as r11,[gp,0x37]
L_929508:
	mov r8,0x0
L_92950c:
	and r0,r11,0x10
L_929510:
	or.f 0x0,r0,r8
L_929514:
	beq L_929554
L_929518:
	ld.as r7,[gp,0x3a]
L_92951c:
	ld.as r6,[gp,0x3b]
L_929520:
	bic r7,r7,-0x3
L_929524:
	cmp r7,0x2
L_929528:
	mov r7,0x1
L_92952c:
	sub.ne r7,r7,r7
L_929530:
	asl r7,r7,0x6
L_929534:
	or r7,r7,0x19800830
L_92953c:
	asl r6,r6,0xe
L_929540:
	or r6,r6,r7
L_929544:
	mov r32,r6
L_929548:
	st.ab r6,[r25,0x4]
L_92954c:
	bclr r25,r25,0xa
L_929550:
	b L_929564
	.global L_929554
L_929554:
	mov_s r2,0x19000001
L_92955a:
	mov_s r32,r2
L_92955c:
	st.ab r2,[r25,0x4]
L_929560:
	bclr r25,r25,0xa
	.global L_929564
L_929564:
	mov r10,r45
L_929568:
	bbit0 r10,0x1f,L_929564
L_92956c:
	ld.as r9,[gp,0x37]
L_929570:
	mov r7,0x0
L_929574:
	and r8,r9,0x10
L_929578:
	or.f 0x0,r8,r7
L_92957c:
	beq_s L_929590
L_92957e:
	mov_s r3,0x18
L_929580:
	asl_s r3,r3,0x18
L_929582:
	mov_s r32,r3
L_929584:
	st.ab r3,[r25,0x4]
L_929588:
	bclr r25,r25,0xa
L_92958c:
	b L_9295a4
	.global L_929590
L_929590:
	mov r4,0x18001000
L_929598:
	mov r32,r4
L_92959c:
	st.ab r4,[r25,0x4]
L_9295a0:
	bclr r25,r25,0xa
	.global L_9295a4
L_9295a4:
	mov_s r13,sp
L_9295a6:
	mov_s r0,r13
L_9295a8:
	bl.d L_924ef4
L_9295ac:
	mov r1,0xa
L_9295b0:
	ld.as r2,[gp,-0x6]
L_9295b4:
	mov r5,0x33000443
L_9295bc:
	sub r2,r2,0x6
L_9295c0:
	st.as r2,[gp,-0x6]
L_9295c4:
	mov r32,r5
L_9295c8:
	st.ab r5,[r25,0x4]
L_9295cc:
	bclr r25,r25,0xa
L_9295d0:
	bl L_924f7c
L_9295d4:
	ldb r34,[r13, 0x10]
L_9295d8:
	ldb r34,[r13, 0x11]
L_9295dc:
	ldb r34,[r13, 0x12]
L_9295e0:
	ld.as r5,[gp,-0x6]
L_9295e4:
	sub r5,r5,0x3
L_9295e8:
	st.as r5,[gp,-0x6]
L_9295ec:
	ldb r33,[r13, 0x13]
L_9295f0:
	ldb_s r0,[r13,0x14]
L_9295f2:
	asl_s r0,r0,0x8
L_9295f4:
	or r33,r33,r0
L_9295f8:
	ldb_s r0,[r13,0x15]
L_9295fa:
	asl_s r0,r0,0x10
L_9295fc:
	or r33,r33,r0
L_929600:
	ldb_s r0,[r13,0x16]
L_929602:
	asl_s r0,r0,0x18
L_929604:
	or r33,r33,r0
L_929608:
	ld.as r3,[gp,-0x6]
L_92960c:
	sub r3,r3,0x4
L_929610:
	st.as r3,[gp,-0x6]
L_929614:
	ldb r34,[r13, 0x17]
L_929618:
	ld.as r4,[gp,-0x6]
L_92961c:
	sub r4,r4,0x1
L_929620:
	bl.d L_924e6c
L_929624:
	st.as r4,[gp,-0x6]
L_929628:
	bl.d L_931664
L_92962c:
	mov r0,0x6
L_929630:
	bl L_930f34
L_929634:
	mov r0,0x0
L_929638:
	bl.d L_9317fc
L_92963c:
	bset r0,r0,0xf
L_929640:
	add_s sp,sp,0x18
L_929642:
	ld blink,[sp, 0x4]
L_929646:
	j_s.d [blink]
L_929648:
	ld.ab r13,[sp,0x8]
