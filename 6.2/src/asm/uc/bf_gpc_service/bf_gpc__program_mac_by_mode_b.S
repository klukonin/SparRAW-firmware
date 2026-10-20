/* bf_gpc__program_mac_by_mode_b @ 0x92eac0, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_transmitter_bi2_flow
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_gpc__program_mac_by_mode_b
bf_gpc__program_mac_by_mode_b:
	.global L_92eac0
L_92eac0:
	st.a r13,[sp,-0xc]
L_92eac4:
	mov_s r13,0x802f14
L_92eaca:
	ldb_s r1,[r13,0x3]
L_92eacc:
	st_s r14,[sp,0x8]
L_92eace:
	lsr_s r1,r1,0x2
L_92ead0:
	bmsk r1,r1,0x3
L_92ead4:
	st blink,[sp, 0x4]
L_92ead8:
	brlo.d r1,0x4,L_92eb50
L_92eadc:
	mov r14,r0
	.global L_92eae0
L_92eae0:
	mov_s r2,0x80167c
L_92eae6:
	sub_s r2,r2,0x8
L_92eae8:
	ldw.as r3,[r2,r1]
L_92eaec:
	ldb_s r0,[r13,0x3]
L_92eaee:
	ldb_s r2,[r13,0x2]
L_92eaf0:
	asl_s r0,r0,0x8
L_92eaf2:
	or_s r2,r2,r0
L_92eaf4:
	lsr r2,r2,0x7
L_92eaf8:
	bmsk r5,r2,0x2
L_92eafc:
	add r5,r5,0x1
L_92eb00:
	mulu64 r5,r3
L_92eb04:
	add r4,mlo,0x5cd
L_92eb0c:
	sub r4,r4,r14
L_92eb10:
	or r4,r4,0x51000000
L_92eb18:
	mov r32,r4
L_92eb1c:
	st.ab r4,[r25,0x4]
L_92eb20:
	bclr r25,r25,0xa
L_92eb24:
	mov_s r3,0x5400070e
L_92eb2a:
	mov_s r32,r3
L_92eb2c:
	st.ab r3,[r25,0x4]
L_92eb30:
	bclr r25,r25,0xa
L_92eb34:
	mov_s r2,0x49000100
L_92eb3a:
	mov_s r32,r2
L_92eb3c:
	st.ab r2,[r25,0x4]
L_92eb40:
	bclr r25,r25,0xa
L_92eb44:
	ld blink,[sp, 0x4]
L_92eb48:
	ld_s r14,[sp,0x8]
L_92eb4a:
	j_s.d [blink]
L_92eb4c:
	ld.ab r13,[sp,0xc]
	.global L_92eb50
L_92eb50:
	mov_s r0,blink
L_92eb52:
	mov_s r1,0x1471
L_92eb58:
	bl L_926618
L_92eb5c:
	ldb_s r1,[r13,0x3]
L_92eb5e:
	lsr_s r1,r1,0x2
L_92eb60:
	b.d L_92eae0
L_92eb64:
	bmsk_s r1,r1,0x3
L_92eb66:
	nop_s
