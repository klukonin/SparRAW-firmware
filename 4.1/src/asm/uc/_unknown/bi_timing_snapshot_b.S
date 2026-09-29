/* bi_timing_snapshot_b @ 0x922b84, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_ap_mon_if__trigger
 * Зовёт сам: bi__tsf_delta64, uc_read_tsf64
 */
	.section .text.bi_timing_snapshot_b,"ax",@progbits
	.global bi_timing_snapshot_b
bi_timing_snapshot_b:
	.global L_922b84
L_922b84:
	st.a r13,[sp,-0x8]
L_922b88:
	st_s r14,[sp,0x4]
L_922b8a:
	mov_s r14,blink
L_922b8c:
	mov_s r13,0x801de8
L_922b92:
	ld_s r0,[r13,0x44]
L_922b94:
	bl.d L_924544
L_922b98:
	ld r1,[r13, 0x48]
L_922b9c:
	st r0,[r13, 0x4c]
L_922ba0:
	bl.d L_930cb0
L_922ba4:
	add2 r0,r13,0x11
L_922ba8:
	ld.as r2,[gp,-0x11]
L_922bac:
	and r2,r2,0xffff0fff
L_922bb4:
	bset r1,r2,0xe
L_922bb8:
	or r2,r2,0x1d004000
L_922bc0:
	st.as r1,[gp,-0x11]
L_922bc4:
	mov r32,r2
L_922bc8:
	st.ab r2,[r25,0x4]
L_922bcc:
	bclr r25,r25,0xa
L_922bd0:
	nop_s
L_922bd2:
	nop_s
L_922bd4:
	mov 0x0,0x0
L_922bd8:
	bmsk r5,r40,0x19
L_922bdc:
	mov r7,0x801de8
L_922be4:
	ld r3,[r7, 0x64]
L_922be8:
	breq.d r3,0x0,L_922c48
L_922bec:
	st r5,[r7, 0x60]
L_922bf0:
	ld r0,[r7, 0x4c]
L_922bf4:
	brhs r0,0x168f0,L_922c0c
L_922bfc:
	ld r2,[r7, 0x50]
L_922c00:
	add r2,r2,0x1
L_922c04:
	b.d L_922c20
L_922c08:
	st r2,[r7, 0x50]
	.global L_922c0c
L_922c0c:
	brhs 0x1b710,r0,L_922c20
L_922c14:
	ld r1,[r7, 0x54]
L_922c18:
	add r1,r1,0x1
L_922c1c:
	st r1,[r7, 0x54]
	.global L_922c20
L_922c20:
	ld r3,[r7, 0x58]
L_922c24:
	cmp r3,r0
L_922c28:
	mov.cc r4,r0
L_922c2c:
	mov.cs r4,r3
L_922c30:
	st r4,[r7, 0x58]
L_922c34:
	ld r4,[r7, 0x5c]
L_922c38:
	cmp r4,r0
L_922c3c:
	mov.hi r0,r4
L_922c40:
	b.d L_922c50
L_922c44:
	st r0,[r7, 0x5c]
	.global L_922c48
L_922c48:
	mov r5,-0x1
L_922c4c:
	st r5,[r7, 0x58]
	.global L_922c50
L_922c50:
	mov r4,0x80088c
L_922c58:
	ldb r3,[r4, 0x50]
L_922c5c:
	mov r6,0x1
L_922c60:
	/* asl_s r3,r3,0x3 */
	.byte 0x03,0xbb
L_922c62:
	st r6,[r7, 0x64]
L_922c66:
	ld r6,[r7, 0x44]
L_922c6a:
	add2_s r3,r3,r3
L_922c6c:
	add r4,r4,r3
L_922c70:
	ld r5,[r7, 0x48]
L_922c74:
	st r6,[r4, 0x8]
L_922c78:
	st r5,[r4, 0xc]
L_922c7c:
	mov_s blink,r14
L_922c7e:
	ld_s r14,[sp,0x4]
L_922c80:
	j.d [blink]
L_922c84:
	ld.ab r13,[sp,0x8]
