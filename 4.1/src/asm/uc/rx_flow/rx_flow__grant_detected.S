/* rx_flow__grant_detected @ 0x92eac0, 904 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SYSTEM
 *   GRANT DETECTED!!
 * Зовут его: rx_flow__handle_frame
 * Зовёт сам: grant_detect_step, power_mngr_peer_update
 * Глобалы (через gp): 0x800534, 0x800548, 0x800604
 */
	.section .text.rx_flow__grant_detected,"ax",@progbits
	.global rx_flow__grant_detected
rx_flow__grant_detected:
	.global L_92eac0
L_92eac0:
	st.a r13,[sp,-0x14]
L_92eac4:
	st blink,[sp, 0x4]
L_92eac8:
	st r16,[sp, 0x10]
L_92eacc:
	mov_s r16,r1
L_92eace:
	ld.as r1,[gp,-0x29]
L_92ead2:
	st_s r15,[sp,0xc]
L_92ead4:
	st r14,[sp, 0x8]
L_92ead8:
	brne.d r1,0x1,L_92eaec
L_92eadc:
	mov r13,r0
L_92eae0:
	ld.as r11,[gp,-0x28]
L_92eae4:
	b.d L_92ed08
L_92eae8:
	st.as r11,[gp,-0x29]
	.global L_92eaec
L_92eaec:
	brlo r1,0x2,L_92eaf8
L_92eaf0:
	sub r1,r1,0x1
L_92eaf4:
	st.as r1,[gp,-0x29]
	.global L_92eaf8
L_92eaf8:
	and.f 0x0,r36,0x6
L_92eafc:
	beq_s L_92ec78
L_92eafe:
	lsr r2,r38,0x10
L_92eb02:
	bmsk.f r2,r2,0x1
L_92eb06:
	beq_s L_92eb18
L_92eb08:
	cmp_s r2,0x1
L_92eb0a:
	bne_s L_92ec78
L_92eb0c:
	mov r0,0x0
L_92eb10:
	b.d L_92ee08
L_92eb14:
	st r0,[r16]
	.global L_92eb18
L_92eb18:
	lsr r11,r36,0x13
L_92eb1c:
	bmsk r11,r11,0x4
L_92eb20:
	st r11,[r13, 0x8]
L_92eb24:
	mov r0,r38
L_92eb28:
	bbit1 r0,0x19,L_92eb34
L_92eb2c:
	mov r4,r36
L_92eb30:
	bbit0 r4,0x12,L_92eb3c
	.global L_92eb34
L_92eb34:
	b.d L_92ee08
L_92eb38:
	mov r0,0x2
	.global L_92eb3c
L_92eb3c:
	lsr r0,r39,0x8
L_92eb40:
	bmsk_s r0,r0,0x5
L_92eb42:
	cmp_s r0,0x8
L_92eb44:
	mov_s r15,0x1
L_92eb46:
	sub_s.ne r15,r15,r15
L_92eb48:
	mov_s r14,r36
L_92eb4a:
	cmp_s r15,0x0
L_92eb4c:
	btst.eq r14,0x11
L_92eb50:
	bne L_92eba4
	.global L_92eb54
L_92eb54:
	mov r7,r53
L_92eb58:
	bbit0 r7,0x3,L_92eb54
L_92eb5c:
	mov r5,r53
L_92eb60:
	bbit1 r5,0x5,L_92eb70
L_92eb64:
	mov r6,0x0
L_92eb68:
	b.d L_92eb78
L_92eb6c:
	st.as r6,[gp,0x8]
	.global L_92eb70
L_92eb70:
	mov r10,0x1
L_92eb74:
	st.as r10,[gp,0x8]
	.global L_92eb78
L_92eb78:
	mov_s r1,0x1c000008
L_92eb7e:
	mov_s r32,r1
L_92eb80:
	st.ab r1,[r25,0x4]
L_92eb84:
	bclr r25,r25,0xa
L_92eb88:
	b L_92ec28
	.global L_92eb8c
L_92eb8c:
	ld_s r3,[r13,0xc]
L_92eb8e:
	bset_s r3,r3,0xa
L_92eb90:
	st r3,[r13, 0xc]
L_92eb94:
	ldb r4,[r11, -0xff]
L_92eb98:
	add r4,r4,0x1
L_92eb9c:
	b.d L_92ec28
L_92eba0:
	stb r4,[r11, -0xff]
	.global L_92eba4
L_92eba4:
	mov_s r0,0x801ed0
L_92ebaa:
	ld.as r3,[r0,0x51]
L_92ebae:
	mov r8,0x1
L_92ebb2:
	cmp_s r15,0x0
L_92ebb4:
	cmp.ne r3,0x0
L_92ebb8:
	beq L_92ebf4
L_92ebbc:
	mov r7,0x0
L_92ebc0:
	ld r4,[0x801418]
L_92ebc8:
	st.as r7,[gp,0x8]
L_92ebcc:
	asl r2,0x1,r4
L_92ebd4:
	bl.d L_9302a4
L_92ebd8:
	mov r1,0x4
L_92ebdc:
	mov r4,0x8016f0
L_92ebe4:
	ldb r1,[r4, -0xfd]
L_92ebe8:
	add r1,r1,0x1
L_92ebec:
	b.d L_92ebf8
L_92ebf0:
	stb r1,[r4, -0xfd]
	.global L_92ebf4
L_92ebf4:
	st.as r8,[gp,0x8]
	.global L_92ebf8
L_92ebf8:
	bbit0 r14,0x11,L_92ec28
L_92ebfc:
	mov r11,0x8016f0
L_92ec04:
	ldb r2,[r11, -0x100]
L_92ec08:
	add r2,r2,0x1
L_92ec0c:
	stb r2,[r11, -0x100]
L_92ec10:
	ldw r0,[0x804028]
L_92ec18:
	bbit1 r0,0x4,L_92eb8c
L_92ec1c:
	ldb r5,[r11, -0xfe]
L_92ec20:
	add r5,r5,0x1
L_92ec24:
	stb r5,[r11, -0xfe]
	.global L_92ec28
L_92ec28:
	ld.as r8,[gp,0x8]
L_92ec2c:
	brne r8,0x1,L_92ec6c
L_92ec30:
	breq_s r15,0,L_92ec64
L_92ec32:
	ld r9,[0x801418]
L_92ec3a:
	mov_s r0,0x801ed0
L_92ec40:
	asl r2,0x1,r9
L_92ec48:
	bl.d L_9302a4
L_92ec4c:
	mov r1,0x3
L_92ec50:
	mov r7,0x80088c
L_92ec58:
	ldb r6,[r7, 0x90]
L_92ec5c:
	add r6,r6,0x1
L_92ec60:
	stb r6,[r7, 0x90]
	.global L_92ec64
L_92ec64:
	b.d L_92ee08
L_92ec68:
	mov r0,0x1
	.global L_92ec6c
L_92ec6c:
	ld.as r1,[gp,-0x32]
L_92ec70:
	add r1,r1,0x1
L_92ec74:
	st.as r1,[gp,-0x32]
	.global L_92ec78
L_92ec78:
	mov_s r1,r37
L_92ec7a:
	bbit0 r1,0x0,L_92ed10
L_92ec7e:
	mov_s r2,0x0
L_92ec80:
	st r2,[r16]
L_92ec84:
	mov_s r3,0x80088c
L_92ec8a:
	ldw r2,[r3, 0xac]
L_92ec8e:
	mov r9,0x0
L_92ec92:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_92ec94:
	stw r2,[r3, 0xac]
L_92ec98:
	ld.as r2,[gp,0x37]
L_92ec9c:
	and r1,r2,0x8
L_92eca0:
	or.f 0x0,r1,r9
L_92eca4:
	bne_s L_92eccc
L_92eca6:
	mov r5,0x801458
L_92ecae:
	ld r0,[r5, 0x6c]
L_92ecb2:
	mov r6,0x857000
L_92ecba:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92ecbc:
	st r0,[r5, 0x6c]
L_92ecc0:
	ld r0,[r6, 0x40]
L_92ecc4:
	add r0,r0,0x1
L_92ecc8:
	st r0,[r6, 0x40]
	.global L_92eccc
L_92eccc:
	ld r10,[0x801418]
L_92ecd4:
	asl r10,r10,0x2
L_92ecd8:
	add2 r10,r10,r10
L_92ecdc:
	ldb r4,[r10,0x857849]
L_92ece4:
	brne r4,0x0,L_92ed08
L_92ece8:
	ldb r0,[0x801a09]
L_92ecf0:
	mov r1,0x0
L_92ecf4:
	bl.d L_92a558
L_92ecf8:
	mov r2,r1
L_92ecfc:
	cmp_s r0,0x0
L_92ecfe:
	mov_s r0,0x3
L_92ed00:
	b.d L_92ee08
L_92ed04:
	mov.eq r0,0x7
	.global L_92ed08
L_92ed08:
	b.d L_92ee08
L_92ed0c:
	mov r0,0x0
	.global L_92ed10
L_92ed10:
	mov r6,r37
L_92ed14:
	bbit0 r6,0x10,L_92eda0
L_92ed18:
	and.f 0x0,r38,0x1f00000
L_92ed20:
	beq.d L_92ed48
L_92ed24:
	mov_s r0,0x0
L_92ed26:
	ld r11,[0x801418]
L_92ed2e:
	asl r11,r11,0x3
L_92ed32:
	add3 r11,r11,r11
L_92ed36:
	add r11,r11,0x801190
L_92ed3e:
	ldw r1,[r11, 0x2]
L_92ed42:
	bclr_s r1,r1,0x1
L_92ed44:
	stw r1,[r11, 0x2]
	.global L_92ed48
L_92ed48:
	st r0,[r16]
L_92ed4c:
	ldw r9,[0x804012]
L_92ed54:
	breq r9,0x0,L_92ed88
L_92ed58:
	mov r7,0x15000000
L_92ed60:
	mov r32,r7
L_92ed64:
	st.ab r7,[r25,0x4]
L_92ed68:
	bclr r25,r25,0xa
L_92ed6c:
	mov r8,0x14000007
L_92ed74:
	mov r32,r8
L_92ed78:
	st.ab r8,[r25,0x4]
L_92ed7c:
	bclr r25,r25,0xa
L_92ed80:
	b.d L_92ee08
L_92ed84:
	mov r0,0x8
	.global L_92ed88
L_92ed88:
	mov r8,0x8014dc
L_92ed90:
	ldw r1,[r8, 0x6]
L_92ed94:
	add r1,r1,0x1
L_92ed98:
	b.d L_92ee08
L_92ed9c:
	stw r1,[r8, 0x6]
	.global L_92eda0
L_92eda0:
	mov r5,r37
L_92eda4:
	bbit0 r5,0xa,L_92ee1c
L_92eda8:
	mov r5,0x80209c
L_92edb0:
	ldb r0,[r5, 0x4]
L_92edb4:
	mov r2,0x10010e8
L_92edbc:
	bbit0.d r0,0x2,L_92edec
L_92edc0:
	mov r7,0x0
L_92edc4:
	bmsk_s r2,r2,0x13
L_92edc6:
	ld r3,[r5]
L_92edca:
	or r2,r2,0xa2000000
L_92edd2:
	extb r6,r3
L_92edd6:
	mov r4,0x8020b0
L_92edde:
	add2 r6,r4,r6
L_92ede2:
	st r2,[r6]
L_92ede6:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_92ede8:
	st r3,[r5]
	.global L_92edec
L_92edec:
	mov r10,0x801458
L_92edf4:
	ld r9,[r10, 0x74]
L_92edf8:
	mov r0,0x9
L_92edfc:
	add r9,r9,0x1
L_92ee00:
	st r9,[r10, 0x74]
L_92ee04:
	st r7,[r16]
	.global L_92ee08
L_92ee08:
	ld blink,[sp, 0x4]
L_92ee0c:
	ld_s r14,[sp,0x8]
L_92ee0e:
	ld_s r15,[sp,0xc]
L_92ee10:
	ld r16,[sp, 0x10]
L_92ee14:
	j.d [blink]
L_92ee18:
	ld.ab r13,[sp,0x14]
	.global L_92ee1c
L_92ee1c:
	mov r11,0x801418
L_92ee24:
	ld r3,[r11, 0x10]
L_92ee28:
	btst_s r3,0x4
L_92ee2a:
	beq_s L_92ed08
L_92ee2c:
	ld r7,[r13]
L_92ee30:
	ld r8,[r11]
L_92ee34:
	cmp r8,r7
L_92ee38:
	bne_s L_92ed08
L_92ee3a:
	ld.as r3,[gp,0x3]
L_92ee3e:
	st_s r3,[r13,0x8]
L_92ee40:
	b.d L_92ee08
L_92ee44:
	mov_s r0,0x2
L_92ee46:
	nop_s
