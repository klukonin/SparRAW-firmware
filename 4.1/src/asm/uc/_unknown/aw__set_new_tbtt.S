/* aw__set_new_tbtt @ 0x930770, 508 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Set new AW. TBTT TSF: %x, tbtt_start_time: %x
 * Зовут его: perform_bti_pm_cfg
 * Зовёт сам: aw__compute_tbtt_from_hw, aw__set_tbtt_offset, aw_tbtt_set_step, calc_awake_tsf, get_reg_886d64_93256c, uc_read_tsf_lo
 */
	.section .text.aw__set_new_tbtt,"ax",@progbits
	.global aw__set_new_tbtt
aw__set_new_tbtt:
	.global L_930770
L_930770:
	st.a r13,[sp,-0x2c]
L_930774:
	st blink,[sp, 0x4]
L_930778:
	st_s r14,[sp,0x8]
L_93077a:
	st_s r15,[sp,0xc]
L_93077c:
	st r16,[sp, 0x10]
L_930780:
	st r17,[sp, 0x14]
L_930784:
	st r18,[sp, 0x18]
L_930788:
	st r21,[sp, 0x24]
L_93078c:
	st r22,[sp, 0x28]
L_930790:
	mov r18,r0
L_930794:
	bl.d L_9315e8
L_930798:
	add3 r21,r0,0x9
L_93079c:
	mov_s r13,r0
L_93079e:
	add r1,r18,0x12c
L_9307a6:
	mov r22,0x0
L_9307aa:
	mov_s r0,r22
L_9307ac:
	bl.d L_9325ac
L_9307b0:
	mov r2,r22
L_9307b4:
	ld.as r6,[r18,0x4b]
L_9307b8:
	st r19,[sp, 0x1c]
L_9307bc:
	sub r6,r6,r13
L_9307c0:
	cmp r6,0x2710
L_9307c8:
	bls.d L_9307f8
L_9307cc:
	st r20,[sp, 0x20]
L_9307d0:
	bl L_93256c
L_9307d4:
	add r5,r18,0x200
L_9307dc:
	ld r1,[r5, -0xd4]
L_9307e0:
	asl r0,r0,0xa
L_9307e4:
	ld r2,[r5, -0xd0]
L_9307e8:
	sub.f r1,r1,r0
L_9307ec:
	sbc r2,r2,r22
L_9307f0:
	st r1,[r5, -0xd4]
L_9307f4:
	st.as r2,[r18,0x4c]
	.global L_9307f8
L_9307f8:
	add r1,r18,0x20
L_9307fc:
	add r2,r18,0x2c
L_930800:
	bl.d L_930b08
L_930804:
	mov r0,r18
L_930808:
	ldb r13,[0x801034]
L_930810:
	breq r13,0x0,L_93088c
L_930814:
	add r16,r18,0x200
L_93081c:
	add3 r19,r18,0x9
L_930820:
	add3 r20,r18,0x15
	.global L_930824
L_930824:
	norm r4,r13
L_930828:
	rsub r2,r4,0x1e
L_93082c:
	asl r14,0x1,r2
L_930834:
	not r17,r14
L_930838:
	and r13,r13,r17
L_93083c:
	asl_s r15,r2,0x2
L_93083e:
	add1_s r15,r15,r15
L_930840:
	add r1,r19,r15
L_930844:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_930846:
	add_s r2,r2,r20
L_930848:
	bl.d L_930b08
L_93084c:
	mov r0,r18
L_930850:
	ldb r6,[r16, -0xd8]
L_930854:
	extb r13,r13
L_930858:
	ld r8,[r21,r15]
L_93085c:
	and r6,r6,r17
L_930860:
	breq.d r8,0x2,L_930870
L_930864:
	stb r6,[r16, -0xd8]
L_930868:
	or r6,r6,r14
L_93086c:
	stb r6,[r16, -0xd8]
	.global L_930870
L_930870:
	ldb r7,[r16, -0xd7]
L_930874:
	and r7,r7,r17
L_930878:
	brne.d r8,0x0,L_930888
L_93087c:
	stb r7,[r16, -0xd7]
L_930880:
	or r14,r14,r7
L_930884:
	stb r14,[r16, -0xd7]
	.global L_930888
L_930888:
	brne r13,0x0,L_930824
	.global L_93088c
L_93088c:
	ld r0,[r18, 0x20]
L_930890:
	cmp r0,0x0
L_930894:
	bl.ne.d L_924434
L_930898:
	mov.ne r0,r18
L_93089c:
	ld r5,[r18, 0x44]
L_9308a0:
	breq r5,0x0,L_930940
L_9308a4:
	ld.as r11,[r18,0x4b]
L_9308a8:
	ld r10,[r18, 0x3c]
L_9308ac:
	brlo r11,r10,L_930940
L_9308b0:
	mov r9,0x80209c
L_9308b8:
	ldb r2,[r9, 0x4]
L_9308bc:
	mov r5,0x1002e34
L_9308c4:
	bbit0 r2,0x2,L_930910
L_9308c8:
	ld r4,[r9]
L_9308cc:
	mov r8,0x8020b0
L_9308d4:
	add r3,r4,0x2
L_9308d8:
	extb_s r3,r3
L_9308da:
	add2 r3,r8,r3
L_9308de:
	st r10,[r3]
L_9308e2:
	add r3,r4,0x1
L_9308e6:
	extb_s r3,r3
L_9308e8:
	add2 r3,r8,r3
L_9308ec:
	st r11,[r3]
L_9308f0:
	bmsk r5,r5,0x13
L_9308f4:
	or r5,r5,0xaa000000
L_9308fc:
	extb r1,r4
L_930900:
	add2 r1,r8,r1
L_930904:
	st r5,[r1]
L_930908:
	add r4,r4,0x3
L_93090c:
	st r4,[r9]
	.global L_930910
L_930910:
	mov r0,0x801eb8
L_930918:
	bl.d L_930488
L_93091c:
	ldw r1,[r18, 0x40]
L_930920:
	st r22,[r18, 0x44]
L_930924:
	mov r7,0x801ed0
L_93092c:
	ldw.as r2,[r7,0xae]
L_930930:
	add r2,r2,0x1
L_930934:
	stw.as r2,[r7,0xae]
L_930938:
	ld r6,[r18, 0x40]
L_93093c:
	stw.as r6,[r7,0xaf]
	.global L_930940
L_930940:
	ld blink,[sp, 0x4]
L_930944:
	ld_s r14,[sp,0x8]
L_930946:
	ld_s r15,[sp,0xc]
L_930948:
	ld r16,[sp, 0x10]
L_93094c:
	ld r17,[sp, 0x14]
L_930950:
	ld r18,[sp, 0x18]
L_930954:
	ld r19,[sp, 0x1c]
L_930958:
	ld r20,[sp, 0x20]
L_93095c:
	ld r21,[sp, 0x24]
L_930960:
	ld r22,[sp, 0x28]
L_930964:
	j.d [blink]
L_930968:
	ld.ab r13,[sp,0x2c]
