/* bti_transmitter_bi2_flow @ 0x923b50, 316 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__prepare_sweep_set
 * Зовёт сам: bf_gpc__program_mac_by_mode_b, bti__bi2_event_step, bti__r54_event_bit6, bti_bi2__gp2_end_flag, bti_bi2__track_best_metric, bti_tx__program_bi2_regs, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti_transmitter_bi2_flow
bti_transmitter_bi2_flow:
	.global L_923b50
L_923b50:
	st.a r13,[sp,-0x10]
L_923b54:
	st blink,[sp, 0x4]
L_923b58:
	ld_s r2,[r0]
L_923b5a:
	st_s r15,[sp,0xc]
L_923b5c:
	st r14,[sp, 0x8]
L_923b60:
	breq.d r2,0x1,L_923b70
L_923b64:
	mov r14,r0
L_923b68:
	bl L_936e40
L_923b6c:
	cmp_s r0,0x0
L_923b6e:
	beq_s L_923c7c
	.global L_923b70
L_923b70:
	mov_s r15,0x804010
L_923b76:
	ldw_s r1,[r15,0x2]
L_923b78:
	cmp_s r1,0x4
L_923b7a:
	mov.cs r1,0x4
L_923b7e:
	sub.cc r1,r1,0x4
L_923b82:
	mulu64 r1,0xa5
L_923b86:
	mov r7,0x52000000
L_923b8e:
	mov_s r13,mlo
L_923b90:
	mov r32,r7
L_923b94:
	st.ab r7,[r25,0x4]
L_923b98:
	bclr r25,r25,0xa
L_923b9c:
	mov r4,0x52000000
L_923ba4:
	mov r32,r4
L_923ba8:
	st.ab r4,[r25,0x4]
L_923bac:
	bclr r25,r25,0xa
L_923bb0:
	mov r5,0x49000040
L_923bb8:
	mov r32,r5
L_923bbc:
	st.ab r5,[r25,0x4]
L_923bc0:
	bclr r25,r25,0xa
L_923bc4:
	or r13,r13,0x4f000000
L_923bcc:
	mov r32,r13
L_923bd0:
	st.ab r13,[r25,0x4]
L_923bd4:
	bclr r25,r25,0xa
L_923bd8:
	mov r6,0x5200090c
L_923be0:
	mov r32,r6
L_923be4:
	st.ab r6,[r25,0x4]
L_923be8:
	bclr r25,r25,0xa
L_923bec:
	bl L_923ca8
L_923bf0:
	rsub.f r0,r0,0x1
L_923bf4:
	mov.cs r0,0x0
L_923bf8:
	extb.f 0x0,r0
L_923bfc:
	mov_s r13,0x802f14
L_923c02:
	beq_s L_923c64
L_923c04:
	ldb_s r0,[r13,0x1]
L_923c06:
	breq_s r0,0,L_923c3c
L_923c08:
	ldw r8,[r15, 0x2]
L_923c0c:
	rsub r1,r8,0x4
L_923c10:
	mulu64 r1,0xa5
L_923c14:
	cmp r8,0x4
L_923c18:
	mov.cs r15,mlo
L_923c1c:
	mov.cc r15,0x4
L_923c20:
	bl.d L_92eac0
L_923c24:
	mov r0,r15
L_923c28:
	ldb_s r2,[r13,0x1f]
L_923c2a:
	cmp_s r2,0x0
L_923c2c:
	bl.ne.d L_930774
L_923c30:
	mov.ne r0,r15
L_923c34:
	bl L_92bf2c
L_923c38:
	brne r0,0x0,L_923c54
	.global L_923c3c
L_923c3c:
	bl.d L_93dc80
L_923c40:
	mov r0,r14
L_923c44:
	ld blink,[sp, 0x4]
L_923c48:
	ld_s r14,[sp,0x8]
L_923c4a:
	ld_s r15,[sp,0xc]
L_923c4c:
	j.d [blink]
L_923c50:
	ld.ab r13,[sp,0x10]
	.global L_923c54
L_923c54:
	mov r0,blink
L_923c58:
	bl.d L_926618
L_923c5c:
	mov r1,0x86
L_923c60:
	b L_923c3c
	.global L_923c64
L_923c64:
	ldw_s r3,[r13,0x1c]
L_923c66:
	ld blink,[sp, 0x4]
L_923c6a:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_923c6c:
	stw_s r3,[r13,0x1c]
L_923c6e:
	mov_s r3,0x4
L_923c70:
	stb_s r3,[r14,0x4]
L_923c72:
	ld_s r14,[sp,0x8]
L_923c74:
	ld_s r15,[sp,0xc]
L_923c76:
	j_s.d [blink]
L_923c78:
	ld.ab r13,[sp,0x10]
	.global L_923c7c
L_923c7c:
	ld blink,[sp, 0x4]
L_923c80:
	ld_s r14,[sp,0x8]
L_923c82:
	ld_s r15,[sp,0xc]
L_923c84:
	j.d [blink]
L_923c88:
	ld.ab r13,[sp,0x10]
