/* aw_worker__collect_awake_peers @ 0x927a44, 704 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__start_window
 * Зовёт сам: aw__fold_peer_masks, aw__walk_peer_bits_noop, aw_worker__read_dma_881c84, memset0_words_uc, peer_masks__apply_op, peer_masks__or_into_8571c4, sta__get_sweep_byte, uc_sysassert
 * Глобалы (через gp): 0x800570
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw_worker__collect_awake_peers
aw_worker__collect_awake_peers:
	.global L_927a44
L_927a44:
	st.a r13,[sp,-0x2c]
L_927a48:
	st blink,[sp, 0x4]
L_927a4c:
	st_s r14,[sp,0x8]
L_927a4e:
	st_s r15,[sp,0xc]
L_927a50:
	st r16,[sp, 0x10]
L_927a54:
	st r17,[sp, 0x14]
L_927a58:
	st r18,[sp, 0x18]
L_927a5c:
	st r19,[sp, 0x1c]
L_927a60:
	st r20,[sp, 0x20]
L_927a64:
	st r21,[sp, 0x24]
L_927a68:
	st r22,[sp, 0x28]
L_927a6c:
	sub_s sp,sp,0xc
L_927a6e:
	mov_s r16,r0
L_927a70:
	mov r21,0x0
L_927a74:
	st r21,[r0]
L_927a78:
	mov r0,sp
L_927a7c:
	bl.d L_920a84
L_927a80:
	mov r1,0x8
L_927a84:
	mov r20,0x802f80
L_927a8c:
	mov_s r0,r20
L_927a8e:
	mov_s r1,r21
L_927a90:
	bl.d L_934bb0
L_927a94:
	mov r2,r21
L_927a98:
	mov r22,0x80212c
L_927aa0:
	bl.d L_928f9c
L_927aa4:
	ldb r18,[r22, 0x68]
L_927aa8:
	mov.f r14,r0
L_927aac:
	beq L_927b50
L_927ab0:
	add r19,sp,0x8
L_927ab4:
	mov r17,0x803118
	.global L_927abc
L_927abc:
	norm r0,r14
L_927ac0:
	rsub r15,r0,0x1e
L_927ac4:
	extb_s r15,r15
L_927ac6:
	mov_s r0,r15
L_927ac8:
	bl.d L_93dad0
L_927acc:
	mov r1,r19
L_927ad0:
	ld r4,[sp, 0x8]
L_927ad4:
	mov r13,r0
L_927ad8:
	breq.d r4,0x0,L_927b24
L_927adc:
	bclr r14,r14,r15
L_927ae0:
	brge r13,0x8,L_927b14
	.global L_927ae4
L_927ae4:
	ldb r10,[r16]
L_927ae8:
	asl r2,0x1,r13
L_927af0:
	or r10,r10,r2
L_927af4:
	stb r10,[r16]
L_927af8:
	ldb r11,[sp]
L_927afc:
	add_s r13,r13,r17
L_927afe:
	or r11,r11,r2
L_927b02:
	ldb_s r0,[r13]
L_927b04:
	stb r11,[sp]
L_927b08:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_927b0a:
	stb_s r0,[r13]
L_927b0c:
	brne r14,0x0,L_927abc
L_927b10:
	b L_927b50
	.global L_927b14
L_927b14:
	mov_s r0,blink
L_927b16:
	mov_s r1,0x141f
L_927b1c:
	bl L_926618
L_927b20:
	b L_927ae4
	.global L_927b24
L_927b24:
	ldb r6,[r16, 0x1]
L_927b28:
	or r6,r6,r18
L_927b2c:
	breq.d r18,0x0,L_927b40
L_927b30:
	stb r6,[r16, 0x1]
L_927b34:
	ld r7,[sp, 0x4]
L_927b38:
	bset r7,r7,0x19
L_927b3c:
	st r7,[sp, 0x4]
	.global L_927b40
L_927b40:
	ldb r8,[r17, 0x9]
L_927b44:
	add r8,r8,0x1
L_927b48:
	stb r8,[r17, 0x9]
L_927b4c:
	brne r14,0x0,L_927abc
	.global L_927b50
L_927b50:
	mov_s r14,0x857000
L_927b56:
	ld r5,[r14, 0x50]
L_927b5a:
	breq r5,0x0,L_927bd0
L_927b5e:
	ldb r1,[r16]
L_927b62:
	mov r6,0x803118
L_927b6a:
	or r1,r1,r5
L_927b6e:
	stb r1,[r16]
L_927b72:
	ld r4,[r14, 0x50]
L_927b76:
	ld_s r1,[sp,0x4]
L_927b78:
	extb r8,r4
L_927b7c:
	ror r3,r1,0x10
L_927b80:
	mov r7,-0x200
L_927b84:
	and r3,r3,r7
L_927b88:
	or r3,r3,r8
L_927b8c:
	ror r3,r3,0x10
L_927b90:
	bbit0.d r4,0x8,L_927bc4
L_927b94:
	st_s r3,[sp,0x4]
L_927b96:
	ldb r1,[r16, 0x1]
L_927b9a:
	or r1,r1,r18
L_927b9e:
	stb r1,[r16, 0x1]
L_927ba2:
	ld_s r2,[sp,0x4]
L_927ba4:
	lsr r4,r2,0x10
L_927ba8:
	ror r2,r2,0x10
L_927bac:
	bmsk r4,r4,0x8
L_927bb0:
	and r2,r2,r7
L_927bb4:
	bset r4,r4,0x8
L_927bb8:
	or r2,r2,r4
L_927bbc:
	ror r2,r2,0x10
L_927bc0:
	st r2,[sp, 0x4]
	.global L_927bc4
L_927bc4:
	ldb r3,[r6, 0x8]
L_927bc8:
	add r3,r3,0x1
L_927bcc:
	stb r3,[r6, 0x8]
	.global L_927bd0
L_927bd0:
	add r2,sp,0x3
L_927bd4:
	mov r0,r16
L_927bd8:
	bl.d L_924ec0
L_927bdc:
	mov r1,r18
L_927be0:
	ld.as r9,[gp,0x12]
L_927be4:
	breq r9,0x0,L_927c1c
L_927be8:
	ld r2,[0x8014c0]
L_927bf0:
	mov r5,0x803118
L_927bf8:
	breq r2,0x0,L_927c0c
L_927bfc:
	ldb r1,[r16]
L_927c00:
	or r1,r1,r9
L_927c04:
	stb r1,[r16]
L_927c08:
	ld.as r9,[gp,0x12]
	.global L_927c0c
L_927c0c:
	ldb r2,[r5, 0xb]
L_927c10:
	stb r9,[sp, 0x2]
L_927c14:
	add r2,r2,0x1
L_927c18:
	stb r2,[r5, 0xb]
	.global L_927c1c
L_927c1c:
	ld r9,[0x800718]
L_927c24:
	breq.d r9,0x0,L_927c48
L_927c28:
	ldb r4,[r16]
L_927c2c:
	ldb r3,[gp, -0xe0]
L_927c30:
	or r3,r3,r4
L_927c34:
	stb r3,[r16]
L_927c38:
	ldb r3,[gp, -0xe0]
L_927c3c:
	stb r21,[gp, -0xe0]
L_927c40:
	stb r3,[sp, 0x1]
L_927c44:
	ldb r4,[r16]
	.global L_927c48
L_927c48:
	ldb r13,[r20,0x128]
L_927c50:
	ldb r0,[r16, 0x1]
L_927c54:
	and r4,r4,r13
L_927c58:
	stb r4,[r16]
L_927c5c:
	and r0,r0,r13
L_927c60:
	stb r0,[r16, 0x1]
L_927c64:
	stb r13,[sp, 0x5]
L_927c68:
	bl.d L_9263d0
L_927c6c:
	mov r0,r13
L_927c70:
	bl.d L_9263b8
L_927c74:
	mov r0,r13
L_927c78:
	ld r1,[r20, 0x20]
L_927c7c:
	ldb r9,[r22, 0x68]
L_927c80:
	cmp_s r1,0x2
L_927c82:
	mov_s r1,0x1
L_927c84:
	sub.ne r1,r1,r1
L_927c88:
	extb.f 0x0,r1
L_927c8c:
	norm r9,r9
L_927c90:
	beq.d L_927cbc
L_927c94:
	rsub r8,r9,0x1e
L_927c98:
	asl r8,r8,0x2
L_927c9c:
	add2 r8,r8,r8
L_927ca0:
	ldb r5,[r8,0x857e49]
L_927ca8:
	brne r5,0x0,L_927cbc
L_927cac:
	st r21,[r16]
L_927cb0:
	ld r11,[sp, 0x4]
L_927cb4:
	bset r11,r11,0x1a
L_927cb8:
	st r11,[sp, 0x4]
	.global L_927cbc
L_927cbc:
	ld r6,[sp]
L_927cc0:
	ld r8,[sp, 0x4]
L_927cc4:
	st r6,[r14, 0x3c]
L_927cc8:
	st r8,[r14, 0x40]
L_927ccc:
	ld r0,[r16]
L_927cd0:
	add_s sp,sp,0xc
L_927cd2:
	sub.f r0,r0,0x0
L_927cd6:
	ld blink,[sp, 0x4]
L_927cda:
	mov.ne r0,0x1
L_927cde:
	ld_s r14,[sp,0x8]
L_927ce0:
	ld_s r15,[sp,0xc]
L_927ce2:
	ld r16,[sp, 0x10]
L_927ce6:
	ld r17,[sp, 0x14]
L_927cea:
	ld r18,[sp, 0x18]
L_927cee:
	ld r19,[sp, 0x1c]
L_927cf2:
	ld r20,[sp, 0x20]
L_927cf6:
	ld r21,[sp, 0x24]
L_927cfa:
	ld r22,[sp, 0x28]
L_927cfe:
	j_s.d [blink]
L_927d00:
	ld.ab r13,[sp,0x2c]
