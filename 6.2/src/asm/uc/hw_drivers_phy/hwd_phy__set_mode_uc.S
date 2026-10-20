/* hwd_phy__set_mode_uc @ 0x9299d8, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__set_normal_mode
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__set_mode_uc
hwd_phy__set_mode_uc:
	.global L_9299d8
L_9299d8:
	st.a r13,[sp,-0xc]
L_9299dc:
	st blink,[sp, 0x4]
L_9299e0:
	brne.d r0,0x1,L_929a10
L_9299e4:
	st_s r14,[sp,0x8]
L_9299e6:
	mov r4,0x883000
L_9299ee:
	ld.as r0,[r4,0x70]
L_9299f2:
	bic r0,r0,0x3f
L_9299f6:
	or r0,r0,0x21
L_9299fa:
	st.as r0,[r4,0x70]
L_9299fe:
	ld.as r1,[r4,0x71]
L_929a02:
	bic r1,r1,0x3f
L_929a06:
	or r1,r1,0x21
L_929a0a:
	st.as r1,[r4,0x71]
L_929a0e:
	b_s L_929a98
	.global L_929a10
L_929a10:
	ldb r3,[gp, -0xeb]
L_929a14:
	bic.f r3,r3,0x3f
L_929a18:
	bne L_929aa4
	.global L_929a1c
L_929a1c:
	mov_s r13,0x883000
L_929a22:
	ld.as r2,[r13,0x70]
L_929a26:
	ldb r8,[gp, -0xeb]
L_929a2a:
	bic r9,r2,0x3f
L_929a2e:
	or r8,r8,r9
L_929a32:
	st.as r8,[r13,0x70]
L_929a36:
	ldb r1,[gp, -0xe9]
L_929a3a:
	bic.f r1,r1,0x3f
L_929a3e:
	bne_s L_929ab4
	.global L_929a40
L_929a40:
	ld.as r10,[r13,0x71]
L_929a44:
	ldb r5,[gp, -0xe9]
L_929a48:
	bic r4,r10,0x3f
L_929a4c:
	or r4,r4,r5
L_929a50:
	st.as r4,[r13,0x71]
L_929a54:
	ldb r11,[gp, -0xea]
L_929a58:
	bic.f r11,r11,0x3f
L_929a5c:
	bne L_929ac4
	.global L_929a60
L_929a60:
	ld.as r2,[r13,0x70]
L_929a64:
	mov_s r14,0xfffff03f
L_929a6a:
	ldb r3,[gp, -0xea]
L_929a6e:
	and_s r2,r2,r14
L_929a70:
	/* asl_s r3,r3,0x6 */
	.byte 0x06,0xbb
L_929a72:
	or_s r2,r2,r3
L_929a74:
	st.as r2,[r13,0x70]
L_929a78:
	ldb_s r0,[gp,-0xe8]
L_929a7a:
	bic.f r0,r0,0x3f
L_929a7e:
	bne_s L_929ad4
	.global L_929a80
L_929a80:
	ld.as r6,[r13,0x71]
L_929a84:
	ldb r7,[gp, -0xe8]
L_929a88:
	and r6,r6,r14
L_929a8c:
	asl r7,r7,0x6
L_929a90:
	or r6,r6,r7
L_929a94:
	st.as r6,[r13,0x71]
	.global L_929a98
L_929a98:
	ld blink,[sp, 0x4]
L_929a9c:
	ld_s r14,[sp,0x8]
L_929a9e:
	j_s.d [blink]
L_929aa0:
	ld.ab r13,[sp,0xc]
	.global L_929aa4
L_929aa4:
	mov r0,blink
L_929aa8:
	bl.d L_926618
L_929aac:
	mov r1,0xac
L_929ab0:
	b L_929a1c
	.global L_929ab4
L_929ab4:
	mov r0,blink
L_929ab8:
	bl.d L_926618
L_929abc:
	mov r1,0xac
L_929ac0:
	b L_929a40
	.global L_929ac4
L_929ac4:
	mov r0,blink
L_929ac8:
	bl.d L_926618
L_929acc:
	mov r1,0xac
L_929ad0:
	b L_929a60
	.global L_929ad4
L_929ad4:
	mov r0,blink
L_929ad8:
	bl.d L_926618
L_929adc:
	mov r1,0xac
L_929ae0:
	b_s L_929a80
L_929ae2:
	nop_s
