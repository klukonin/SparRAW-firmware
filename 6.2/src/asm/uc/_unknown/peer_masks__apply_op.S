/* peer_masks__apply_op @ 0x934bb0, 420 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__collect_awake_peers, bi_rx__slot_handler, l1_fixed_sched_ap_sm, rx_flow__handle_frame, rx_get_required_response
 * Зовёт сам: mac__read_bi_start_tsf64_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global peer_masks__apply_op
peer_masks__apply_op:
	.global L_934bb0
L_934bb0:
	st.a r13,[sp,-0x10]
L_934bb4:
	st blink,[sp, 0x4]
L_934bb8:
	st_s r14,[sp,0x8]
L_934bba:
	st_s r15,[sp,0xc]
L_934bbc:
	sub sp,sp,0x8
L_934bc0:
	breq.d r1,0x0,L_934bf4
L_934bc4:
	mov_s r14,r0
L_934bc6:
	breq r1,0x1,L_934c0c
L_934bca:
	breq r1,0x2,L_934c30
L_934bce:
	breq r1,0x3,L_934c20
L_934bd2:
	brne r1,0x4,L_934c3c
L_934bd6:
	ld.as r7,[r14,0x4f]
L_934bda:
	add_s sp,sp,0x8
L_934bdc:
	or r7,r7,r2
L_934be0:
	st.as r7,[r14,0x4f]
L_934be4:
	ld blink,[sp, 0x4]
L_934be8:
	ld_s r14,[sp,0x8]
L_934bea:
	ld_s r15,[sp,0xc]
L_934bec:
	j.d [blink]
L_934bf0:
	ld.ab r13,[sp,0x10]
	.global L_934bf4
L_934bf4:
	mov_s r2,0x0
L_934bf6:
	st.as r2,[r14,0x4d]
L_934bfa:
	st.as r2,[r14,0x4e]
L_934bfe:
	st.as r2,[r14,0x4f]
L_934c02:
	mov_s r1,0x1
L_934c04:
	b.d L_934c3c
L_934c08:
	st.as r1,[r14,0x50]
	.global L_934c0c
L_934c0c:
	not r8,r2
L_934c10:
	ld.as r6,[r14,0x4e]
L_934c14:
	extb r8,r8
L_934c18:
	and r6,r6,r8
L_934c1c:
	st.as r6,[r14,0x4e]
	.global L_934c20
L_934c20:
	ld.as r5,[r14,0x4d]
L_934c24:
	or r5,r5,r2
L_934c28:
	b.d L_934c3c
L_934c2c:
	st.as r5,[r14,0x4d]
	.global L_934c30
L_934c30:
	ld.as r4,[r14,0x4e]
L_934c34:
	or r4,r4,r2
L_934c38:
	st.as r4,[r14,0x4e]
	.global L_934c3c
L_934c3c:
	ld r2,[0x8014c0]
L_934c44:
	add r13,r14,0x200
L_934c4c:
	brne r2,0x0,L_934d00
L_934c50:
	mov_s r1,sp
L_934c52:
	mov_s r15,0x0
L_934c54:
	mov r0,r15
L_934c58:
	bl.d L_9374e8
L_934c5c:
	mov r2,0x1
L_934c60:
	ld r3,[r13, -0xd4]
L_934c64:
	ld r2,[r13, -0xd0]
L_934c68:
	ld_s r0,[sp,0x4]
L_934c6a:
	ld r4,[sp]
L_934c6e:
	cmp_s r2,r0
L_934c70:
	cmp.eq r3,r4
L_934c74:
	mov r8,0x1
L_934c78:
	sub.ls r8,r8,r8
L_934c7c:
	mov_s r1,0x857000
L_934c82:
	ld r9,[r1, 0x40]
L_934c86:
	asl r3,r8,0x1b
L_934c8a:
	bclr r9,r9,0x1b
L_934c8e:
	or r9,r9,r3
L_934c92:
	st r9,[r1, 0x40]
L_934c96:
	ld r5,[r14, 0x20]
L_934c9a:
	ldb r11,[r13, -0xcc]
L_934c9e:
	cmp r5,0x0
L_934ca2:
	ldb r0,[r13, -0xcb]
L_934ca6:
	cmp.ne r8,0x1
L_934caa:
	bne_s L_934cd0
L_934cac:
	ldb r10,[0x802194]
L_934cb4:
	ldb r9,[r13, -0xd7]
L_934cb8:
	and r10,r10,r9
L_934cbc:
	or r11,r11,r10
L_934cc0:
	stb r11,[r13, -0xcc]
L_934cc4:
	or r0,r0,r10
L_934cc8:
	b.d L_934ce8
L_934ccc:
	stb r0,[r13, -0xcb]
	.global L_934cd0
L_934cd0:
	ldb r1,[r13, -0xc8]
L_934cd4:
	ldb r2,[r13, -0xc7]
L_934cd8:
	or r1,r1,r11
L_934cdc:
	stb r1,[r13, -0xcc]
L_934ce0:
	or r2,r2,r0
L_934ce4:
	stb r2,[r13, -0xcb]
	.global L_934ce8
L_934ce8:
	stb r15,[r13, -0xc8]
L_934cec:
	stb r15,[r13, -0xc7]
L_934cf0:
	add_s sp,sp,0x8
L_934cf2:
	ld blink,[sp, 0x4]
L_934cf6:
	ld_s r14,[sp,0x8]
L_934cf8:
	ld_s r15,[sp,0xc]
L_934cfa:
	j_s.d [blink]
L_934cfc:
	ld.ab r13,[sp,0x10]
	.global L_934d00
L_934d00:
	ldb r1,[r13, -0xd7]
L_934d04:
	ldb r7,[0x802194]
L_934d0c:
	ldb r4,[r13, -0xcc]
L_934d10:
	and r7,r7,r1
L_934d14:
	or r4,r4,r7
L_934d18:
	ldb r6,[r13, -0xcb]
L_934d1c:
	stb r4,[r13, -0xcc]
L_934d20:
	or r6,r6,r7
L_934d24:
	stb r6,[r13, -0xcb]
L_934d28:
	ldb r3,[r13, -0xc8]
L_934d2c:
	not r0,r7
L_934d30:
	and_s r3,r3,r0
L_934d32:
	ldb r5,[r13, -0xc7]
L_934d36:
	stb r3,[r13, -0xc8]
L_934d3a:
	and r5,r5,r0
L_934d3e:
	stb r5,[r13, -0xc7]
L_934d42:
	add_s sp,sp,0x8
L_934d44:
	ld blink,[sp, 0x4]
L_934d48:
	ld_s r14,[sp,0x8]
L_934d4a:
	ld_s r15,[sp,0xc]
L_934d4c:
	j.d [blink]
L_934d50:
	ld.ab r13,[sp,0x10]
