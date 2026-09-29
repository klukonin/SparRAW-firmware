/* peer_slots__scan_by_masks @ 0x93cd2c, 432 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__dispatch
 * Зовёт сам: memcpy_uc, memset0_words_uc, uc_read_tsf_lo, uc_send_evt__mac_monitor
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global peer_slots__scan_by_masks
peer_slots__scan_by_masks:
	.global L_93cd2c
L_93cd2c:
	st.a r13,[sp,-0x18]
L_93cd30:
	st blink,[sp, 0x4]
L_93cd34:
	st_s r14,[sp,0x8]
L_93cd36:
	ld.as r9,[gp,-0xa]
L_93cd3a:
	st r16,[sp, 0x10]
L_93cd3e:
	cmp r9,0x1
L_93cd42:
	st_s r15,[sp,0xc]
L_93cd44:
	bne.d L_93cec4
L_93cd48:
	st r17,[sp, 0x14]
L_93cd4c:
	bl.d L_9364c8
L_93cd50:
	mov r13,0x0
L_93cd54:
	ldb r6,[0x8030a9]
L_93cd5c:
	mov_s r15,0x801030
L_93cd62:
	ldb r14,[r15, 0x91]
L_93cd66:
	mov lp_count,0x8
L_93cd6a:
	mov_s r1,r13
L_93cd6c:
	lp L_93cdd4
L_93cd70:
	add r2,gp,r1
L_93cd74:
	ldb r3,[r2, 0xac]
L_93cd78:
	brne_s r3,0,L_93cd98
L_93cd7a:
	ldb r5,[0x802194]
L_93cd82:
	asl r0,0x1,r1
L_93cd8a:
	tst r5,r0
L_93cd8e:
	beq_s L_93cd98
L_93cd90:
	tst r0,r6
L_93cd94:
	beq L_93cda0
	.global L_93cd98
L_93cd98:
	b.d L_93cdc0
L_93cd9c:
	add r2,gp,r1
	.global L_93cda0
L_93cda0:
	ldb r4,[r2, 0xa4]
L_93cda4:
	breq r4,0x0,L_93cdc4
L_93cda8:
	ldb r3,[r2, 0x9c]
L_93cdac:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_93cdae:
	extb_s r3,r3
L_93cdb0:
	brlt.d r3,0xb,L_93cdc4
L_93cdb4:
	stb r3,[r2, 0x9c]
L_93cdb8:
	or_s r0,r0,r14
L_93cdba:
	extb_s r14,r0
L_93cdbc:
	stb r0,[r15, 0x91]
	.global L_93cdc0
L_93cdc0:
	stb r13,[r2, 0x9c]
	.global L_93cdc4
L_93cdc4:
	add r4,gp,r1
L_93cdc8:
	stb r13,[r4, 0xac]
L_93cdcc:
	stb r13,[r4, 0xa4]
L_93cdd0:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93cdd2:
	extb_s r1,r1
	.global L_93cdd4
L_93cdd4:
	ldb r8,[r15, 0x50]
L_93cdd8:
	mov r16,0x1
L_93cddc:
	cmp r8,0x0
L_93cde0:
	sub.ne r16,r16,r16
L_93cde4:
	asl r16,r16,0x3
L_93cde8:
	add2 r16,r16,r16
L_93cdec:
	ld.a r11,[r16,r15]
L_93cdf0:
	mov r0,0x853940
L_93cdf8:
	ld r10,[r16, 0x4]
L_93cdfc:
	add2 r1,r15,0x15
L_93ce00:
	ld r9,[r16, 0x8]
L_93ce04:
	mov r17,0x80
L_93ce08:
	ld r8,[r16, 0xc]
L_93ce0c:
	st r11,[r15, 0x58]
L_93ce10:
	st r10,[r15, 0x5c]
L_93ce14:
	st r9,[r15, 0x60]
L_93ce18:
	st r8,[r15, 0x64]
L_93ce1c:
	ld r11,[r16, 0x10]
L_93ce20:
	ld r10,[r16, 0x14]
L_93ce24:
	ld r9,[r16, 0x18]
L_93ce28:
	ld r8,[r16, 0x1c]
L_93ce2c:
	st r11,[r15, 0x68]
L_93ce30:
	st r10,[r15, 0x6c]
L_93ce34:
	st r9,[r15, 0x70]
L_93ce38:
	st r8,[r15, 0x74]
L_93ce3c:
	ld r11,[r16, 0x20]
L_93ce40:
	ld r10,[r16, 0x24]
L_93ce44:
	st r11,[r15, 0x78]
L_93ce48:
	st r10,[r15, 0x7c]
L_93ce4c:
	bl.d L_920330
L_93ce50:
	mov r2,r17
L_93ce54:
	mov r0,r16
L_93ce58:
	bl.d L_920a84
L_93ce5c:
	mov r1,0x28
L_93ce60:
	add2 r0,r15,0x15
L_93ce64:
	bl.d L_920a84
L_93ce68:
	mov r1,r17
L_93ce6c:
	st r17,[r15, 0x54]
L_93ce70:
	stb r13,[r16, 0x26]
L_93ce74:
	stb r13,[r16, 0x14]
L_93ce78:
	mov r10,-0x100
L_93ce7c:
	st r10,[r16, 0x18]
L_93ce80:
	stb r13,[r16, 0x1c]
L_93ce84:
	st r10,[r16, 0x20]
L_93ce88:
	ld r7,[0x85398c]
L_93ce90:
	stb r14,[r15, 0x91]
L_93ce94:
	st.as r7,[gp,-0x27]
L_93ce98:
	bl.d L_927530
L_93ce9c:
	mov r0,0x1
L_93cea0:
	st.as r13,[gp,-0xa]
L_93cea4:
	st r13,[0x8006e0]
L_93ceac:
	st r13,[0x800634]
L_93ceb4:
	st r13,[0x800638]
L_93cebc:
	st r13,[0x80063c]
	.global L_93cec4
L_93cec4:
	ld blink,[sp, 0x4]
L_93cec8:
	ld_s r14,[sp,0x8]
L_93ceca:
	ld_s r15,[sp,0xc]
L_93cecc:
	ld r16,[sp, 0x10]
L_93ced0:
	ld r17,[sp, 0x14]
L_93ced4:
	j.d [blink]
L_93ced8:
	ld.ab r13,[sp,0x18]
