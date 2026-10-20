/* arc__program_action_point @ 0x920f10, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SYSTEM
 * Зовут его: arc_protect_addr_uc
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global arc__program_action_point
arc__program_action_point:
	.global L_920f10
L_920f10:
	st.a r13,[sp,-0x8]
L_920f14:
	st_s r14,[sp,0x4]
L_920f16:
	mov_s r13,r0
L_920f18:
	mov r8,0x1000000
L_920f20:
	sr r8,[0x5]
L_920f24:
	ld r0,[r0]
L_920f28:
	brhs.d r0,0x2,L_920f88
L_920f2c:
	mov r14,blink
	.global L_920f30
L_920f30:
	ld r4,[r13, 0x10]
L_920f34:
	ld r5,[r13, 0xc]
L_920f38:
	asl r4,r4,0x4
L_920f3c:
	ld_s r3,[r13,0x14]
L_920f3e:
	or r4,r4,r5
L_920f42:
	/* asl_s r3,r3,0x6 */
	.byte 0x06,0xbb
L_920f44:
	ld_s r2,[r13,0x18]
L_920f46:
	or r3,r3,r4
L_920f4a:
	/* asl_s r2,r2,0x7 */
	.byte 0x07,0xba
L_920f4c:
	ld_s r1,[r13,0x1c]
L_920f4e:
	or_s r2,r2,r3
L_920f50:
	asl_s r1,r1,0x8
L_920f52:
	or_s r1,r1,r2
L_920f54:
	ld r10,[r13, 0x4]
L_920f58:
	add1_s r0,r0,r0
L_920f5a:
	add r6,r0,0x220
L_920f62:
	sr r10,[r6]
L_920f66:
	ld r9,[r13, 0x8]
L_920f6a:
	add r7,r0,0x221
L_920f72:
	sr r9,[r7]
L_920f76:
	add r0,r0,0x222
L_920f7a:
	sr r1,[r0]
L_920f7e:
	mov_s blink,r14
L_920f80:
	ld_s r14,[sp,0x4]
L_920f82:
	j_s.d [blink]
L_920f84:
	ld.ab r13,[sp,0x8]
	.global L_920f88
L_920f88:
	mov r0,blink
L_920f8c:
	bl.d L_926618
L_920f90:
	mov r1,0xf6
L_920f94:
	b.d L_920f30
L_920f98:
	ld_s r0,[r13]
L_920f9a:
	nop_s
