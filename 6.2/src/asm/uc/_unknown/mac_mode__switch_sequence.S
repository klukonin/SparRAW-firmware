/* mac_mode__switch_sequence @ 0x9273c0, 288 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, brp_restore_sectors, mac__program_13ab6680, mac__program_13ab6680_b, rf__power_seq_and_save, tof__set_tx_rx_offset_regs
 * Глобалы (через gp): 0x8005bc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_mode__switch_sequence
mac_mode__switch_sequence:
	.global L_9273c0
L_9273c0:
	push_s blink
L_9273c2:
	bl L_920230
L_9273c6:
	mov_s r14,r0
L_9273c8:
	or r0,r0,0xaa00
L_9273d0:
	mov_s r32,r0
L_9273d2:
	st.ab r0,[r25,0x4]
L_9273d6:
	bclr r25,r25,0xa
L_9273da:
	mov_s r0,0x800738
L_9273e0:
	ld_s r0,[r0,0x10]
L_9273e2:
	lr r0,[r0]
L_9273e6:
	bmsk_s r0,r0,0x17
L_9273e8:
	mov_s r32,r0
L_9273ea:
	st.ab r0,[r25,0x4]
L_9273ee:
	bclr r25,r25,0xa
L_9273f2:
	mov_s r13,0x8006a8
L_9273f8:
	breq r14,0x0,L_92745a
L_9273fc:
	ldb_s r0,[r13,0x1]
L_9273fe:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_927400:
	bl.d L_93c904
L_927404:
	stb_s r0,[r13,0x1]
L_927406:
	bl.d L_93c888
L_92740a:
	mov_s r0,0x1
L_92740c:
	mov_s r0,0x0
L_92740e:
	bset_s r0,r0,0x18
L_927410:
	mov_s r32,r0
L_927412:
	st.ab r0,[r25,0x4]
L_927416:
	bclr r25,r25,0xa
L_92741a:
	mov_s r0,0x20c0010
L_927420:
	mov_s r32,r0
L_927422:
	st.ab r0,[r25,0x4]
L_927426:
	bclr r25,r25,0xa
L_92742a:
	mov_s r1,0x2
L_92742c:
	mov_s r0,0x886d80
L_927432:
	st_s r1,[r0,0x50]
L_927434:
	sync
L_927438:
	mov_s r1,0x2
L_92743a:
	mov_s r0,0x886d80
L_927440:
	st_s r1,[r0,0x64]
L_927442:
	sync
L_927446:
	mov_s r1,0x4
L_927448:
	mov_s r0,0x886d80
L_92744e:
	st_s r1,[r0,0x64]
L_927450:
	sync
L_927454:
	mov_s r0,0x1
L_927456:
	stb_s r0,[r13]
L_927458:
	b_s L_9274da
	.global L_92745a
L_92745a:
	ldb_s r0,[r13,0x2]
L_92745c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92745e:
	bl.d L_93c8e0
L_927462:
	stb_s r0,[r13,0x2]
L_927464:
	ldw_s r0,[gp,0x94]
L_927466:
	breq_s r0,0,L_927478
L_927468:
	mov_s r0,0x1ffffff
L_92746e:
	mov_s r32,r0
L_927470:
	st.ab r0,[r25,0x4]
L_927474:
	bclr r25,r25,0xa
	.global L_927478
L_927478:
	mov_s r15,0x0
L_92747a:
	bl.d L_93c888
L_92747e:
	mov_s r0,r15
L_927480:
	mov_s r0,0x8006b4
L_927486:
	ldb_s r13,[r0,0x4]
L_927488:
	b_s L_9274a0
	.global L_92748a
L_92748a:
	norm r0,r13
L_92748e:
	rsub r14,r0,0x1e
L_927492:
	extb_s r14,r14
L_927494:
	bl.d L_923574
L_927498:
	mov_s r0,r14
L_92749a:
	bclr r13,r13,r14
L_92749e:
	extb_s r13,r13
	.global L_9274a0
L_9274a0:
	brne_s r13,0,L_92748a
L_9274a2:
	mov_s r0,0x800694
L_9274a8:
	ld_s r0,[r0]
L_9274aa:
	mov_s r1,0x800698
L_9274b0:
	bl.d L_929d10
L_9274b4:
	ld_s r1,[r1]
L_9274b6:
	mov_s r1,0x4
L_9274b8:
	mov_s r0,0x886d80
L_9274be:
	st_s r1,[r0,0x50]
L_9274c0:
	sync
L_9274c4:
	mov_s r1,0x4
L_9274c6:
	mov_s r0,0x886d80
L_9274cc:
	st_s r1,[r0,0x64]
L_9274ce:
	sync
L_9274d2:
	mov_s r0,0x8006a8
L_9274d8:
	stb_s r15,[r0]
	.global L_9274da
L_9274da:
	b L_92029c
L_9274de:
	nop_s
