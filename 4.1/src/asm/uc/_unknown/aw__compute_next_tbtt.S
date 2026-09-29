/* aw__compute_next_tbtt @ 0x93096c, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_tbtt_set_step
 * Зовёт сам: get_reg_886d64_93256c, uc_divmod_signed
 */
	.section .text.aw__compute_next_tbtt,"ax",@progbits
	.global aw__compute_next_tbtt
aw__compute_next_tbtt:
	.global L_93096c
L_93096c:
	st.a r13,[sp,-0xc]
L_930970:
	st blink,[sp, 0x4]
L_930974:
	st_s r14,[sp,0x8]
L_930976:
	mov_s r14,r0
L_930978:
	bl.d L_93256c
L_93097c:
	mov r13,r1
L_930980:
	ld.as r3,[r14,0x4b]
L_930984:
	ld_s r1,[r13,0x4]
L_930986:
	extb_s r0,r0
L_930988:
	sub r3,r3,r1
L_93098c:
	brlt.d r0,0x1,L_9309b0
L_930990:
	lsr r3,r3,0xa
L_930994:
	brhs r3,0x3f,L_9309b0
L_930998:
	mov r4,0x0
	.global L_93099c
L_93099c:
	sub.f r3,r3,r0
L_9309a0:
	bhi.d L_93099c
L_9309a4:
	add.cc r4,r4,0x1
L_9309a8:
	b.d L_930a10
L_9309ac:
	ldw r2,[r13, 0x8]
	.global L_9309b0
L_9309b0:
	breq r0,0x0,L_9309fc
L_9309b4:
	mov r4,0x0
L_9309b8:
	norm.f r11,r3
L_9309bc:
	sub r4,r4,0x1
L_9309c0:
	mov.mi r11,r4
L_9309c4:
	norm.f r10,r0
L_9309c8:
	mov.mi r10,r4
L_9309cc:
	sub.f r4,r10,r11
L_9309d0:
	mov.mi r4,0x0
L_9309d4:
	add lp_count,r4,0x1
L_9309d8:
	asl.pl r0,r0,r4
L_9309dc:
	mov r4,0x0
L_9309e0:
	lp L_9309f4
L_9309e4:
	sub.f r3,r3,r0
L_9309e8:
	bset.cc r4,r4,lp_count
L_9309ec:
	add.cs r3,r3,r0
L_9309f0:
	lsr r0,r0
	.global L_9309f4
L_9309f4:
	b.d L_930a0c
L_9309f8:
	ror r4,r4
	.global L_9309fc
L_9309fc:
	mov r1,r0
L_930a00:
	bl.d L_9203c0
L_930a04:
	mov r0,r3
L_930a08:
	mov r4,r0
	.global L_930a0c
L_930a0c:
	ldw r2,[r13, 0x8]
	.global L_930a10
L_930a10:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_930a12:
	and r2,r2,r4
L_930a16:
	st.as r2,[r14,0x53]
L_930a1a:
	ldw_s r0,[r13,0xa]
L_930a1c:
	brhs r2,r0,L_930a2c
L_930a20:
	mov r4,0x1
L_930a24:
	b.d L_930a34
L_930a28:
	st r4,[r13]
	.global L_930a2c
L_930a2c:
	mov r5,0x2
L_930a30:
	st r5,[r13]
	.global L_930a34
L_930a34:
	ld blink,[sp, 0x4]
L_930a38:
	ld_s r14,[sp,0x8]
L_930a3a:
	j_s.d [blink]
L_930a3c:
	ld.ab r13,[sp,0xc]
