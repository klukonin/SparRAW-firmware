/* brp_restore_sectors @ 0x923574, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brp_restore_sectors %u
 * Зовут его: mac_mode__switch_sequence
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, brp__write_reg_pair, rfca__get_rf_mask_uc, rfca__select_rf_uc, sector_mem__addr_of, uc_log__emit1
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_restore_sectors
brp_restore_sectors:
	.global L_923574
L_923574:
	push_s blink
L_923576:
	bl L_92022c
L_92357a:
	sub_s sp,sp,0x4
L_92357c:
	mov_s r16,r0
L_92357e:
	mov_s r0,0x80218c
L_923584:
	bl.d L_928c68
L_923588:
	ldb_s r15,[r0,0x8]
L_92358a:
	st_s r0,[sp,0x0]
L_92358c:
	mov_s r1,0x1000b84
L_923592:
	mov_s r0,0x0
L_923594:
	bl.d L_92d1d0
L_923598:
	mov_s r2,r16
L_92359a:
	mov_s r0,0x0
L_92359c:
	bset r0,r0,r16
L_9235a0:
	extb_s r0,r0
L_9235a2:
	bl.d L_928b8c
L_9235a6:
	mov_s r1,0x0
L_9235a8:
	b_s L_923664
	.global L_9235aa
L_9235aa:
	norm r0,r15
L_9235ae:
	rsub r14,r0,0x1e
L_9235b2:
	bclr r15,r15,r14
L_9235b6:
	extb_s r13,r14
L_9235b8:
	bl.d L_922e14
L_9235bc:
	mov_s r0,r13
L_9235be:
	add_s r13,r13,0x60
L_9235c0:
	extb_s r13,r13
L_9235c2:
	mul64 r16,0xe0
L_9235c6:
	/* asl_s r13,r13,0x6 */
	.byte 0x06,0xbd
L_9235c8:
	add1_s r13,r13,r13
L_9235ca:
	add r0,r13,0x10020
L_9235d2:
	mov_s r1,mlo
L_9235d4:
	mul64 r14,0x1c
L_9235d8:
	lsr_s r0,r0,0x3
L_9235da:
	bic r0,r0,0x3
L_9235de:
	add_s r1,r1,mlo
L_9235e0:
	add r14,r1,0x8008c0
L_9235e8:
	bl.d L_92f9d8
L_9235ec:
	ld_s r1,[r14]
L_9235ee:
	add r0,r13,0x10000
L_9235f6:
	lsr_s r0,r0,0x3
L_9235f8:
	bic r0,r0,0x3
L_9235fc:
	bl.d L_92f9d8
L_923600:
	ld_s r1,[r14,0x4]
L_923602:
	add r0,r13,0x10060
L_92360a:
	lsr_s r0,r0,0x3
L_92360c:
	bic r0,r0,0x3
L_923610:
	bl.d L_92f9d8
L_923614:
	ld_s r1,[r14,0x8]
L_923616:
	add r0,r13,0x10040
L_92361e:
	lsr_s r0,r0,0x3
L_923620:
	bic r0,r0,0x3
L_923624:
	bl.d L_92f9d8
L_923628:
	ld_s r1,[r14,0xc]
L_92362a:
	add r0,r13,0x100a0
L_923632:
	lsr_s r0,r0,0x3
L_923634:
	bic r0,r0,0x3
L_923638:
	bl.d L_92f9d8
L_92363c:
	ld_s r1,[r14,0x10]
L_92363e:
	add r0,r13,0x10080
L_923646:
	lsr_s r0,r0,0x3
L_923648:
	bic r0,r0,0x3
L_92364c:
	bl.d L_92f9d8
L_923650:
	ld_s r1,[r14,0x14]
L_923652:
	add r1,r16,0x801ed4
L_92365a:
	ldb_s r0,[r1,0x5]
L_92365c:
	extb_s r15,r15
L_92365e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923660:
	extb_s r0,r0
L_923662:
	stb_s r0,[r1,0x5]
	.global L_923664
L_923664:
	brne r15,0x0,L_9235aa
L_923668:
	ld_s r0,[sp,0x0]
L_92366a:
	bl.d L_928b8c
L_92366e:
	mov_s r1,0x0
L_923670:
	b.d L_920294
L_923674:
	add_s sp,sp,0x4
L_923676:
	nop_s
