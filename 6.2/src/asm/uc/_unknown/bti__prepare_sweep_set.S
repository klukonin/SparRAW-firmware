/* bti__prepare_sweep_set @ 0x935b9c, 368 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__dispatch_sweep_step
 * Зовёт сам: bti_transmitter_bi2_flow, bti_worker__bti_transmitter_beacon_sweep_flow, mac__cmd_0f_step, uc_tx__is_idle
 * Глобалы (через gp): 0x80059c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__prepare_sweep_set
bti__prepare_sweep_set:
	.global L_935b9c
L_935b9c:
	st.a r13,[sp,-0x8]
L_935ba0:
	st_s r14,[sp,0x4]
L_935ba2:
	ldb r2,[gp, -0xf7]
L_935ba6:
	mov_s r13,r0
L_935ba8:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_935baa:
	mov r6,0x857800
L_935bb2:
	ldb r7,[r6, -0xc4]
L_935bb6:
	extb_s r2,r2
L_935bb8:
	mov r14,blink
L_935bbc:
	brne.d r2,r7,L_935bcc
L_935bc0:
	stb r2,[gp, -0xf7]
L_935bc4:
	mov r2,0x0
L_935bc8:
	stb r2,[gp, -0xf7]
	.global L_935bcc
L_935bcc:
	ld r8,[0x8014c0]
L_935bd4:
	breq r8,0x0,L_935c04
L_935bd8:
	brlt r7,0x2,L_935c04
L_935bdc:
	mov r0,0x801024
L_935be4:
	ld r9,[r0]
L_935be8:
	bmsk r11,r2,0xe
L_935bec:
	ror r9,r9,0x8
L_935bf0:
	and r9,r9,0xffff8000
L_935bf8:
	or r11,r11,r9
L_935bfc:
	ror r11,r11,0x18
L_935c00:
	st r11,[r0]
	.global L_935c04
L_935c04:
	mov r4,0x801694
L_935c0c:
	ldb r8,[r4, 0x48]
L_935c10:
	add r5,r4,0x8
L_935c14:
	add r12,r5,r8
L_935c18:
	ld r0,[r6, -0x50]
L_935c1c:
	stb r8,[r12]
L_935c20:
	add1_s r0,r0,r2
L_935c22:
	ldb r10,[r0, 0x1]
L_935c26:
	ldb r6,[r0]
L_935c2a:
	mov_s r3,0xff
L_935c2c:
	sub r10,r10,r6
L_935c30:
	add r10,r10,0x1
L_935c34:
	extb r10,r10
L_935c38:
	stb r10,[r4, 0x48]
L_935c3c:
	add r10,r10,r5
L_935c40:
	stb r3,[r10]
L_935c44:
	stb r2,[r4, 0x49]
L_935c48:
	st_s r1,[r13]
L_935c4a:
	mov_s r2,0x6
L_935c4c:
	brne.d r1,0x0,L_935c60
L_935c50:
	stb_s r2,[r13,0x4]
L_935c52:
	mov r7,0x1
L_935c56:
	stb r7,[0x802f14]
L_935c5e:
	ld_s r1,[r13]
	.global L_935c60
L_935c60:
	brne r1,0x0,L_935c84
L_935c64:
	bl L_93c658
L_935c68:
	mov r0,0x802f80
L_935c70:
	bl.d L_92e438
L_935c74:
	ld.as r1,[gp,0x1d]
L_935c78:
	mov r5,0x0
L_935c7c:
	b.d L_935c8c
L_935c80:
	st.as r5,[gp,0x1d]
	.global L_935c84
L_935c84:
	mov r4,0x1
L_935c88:
	st.as r4,[gp,0x1d]
	.global L_935c8c
L_935c8c:
	ld r0,[0x8022a8]
L_935c94:
	breq r0,0x0,L_935cec
L_935c98:
	mov r6,0xf000001
L_935ca0:
	mov r32,r6
L_935ca4:
	st.ab r6,[r25,0x4]
L_935ca8:
	bclr r25,r25,0xa
L_935cac:
	ld.as r5,[gp,-0x11]
L_935cb0:
	and r5,r5,0xfffff0ff
L_935cb8:
	or r6,r5,0x300
L_935cc0:
	or r5,r5,0x1d000300
L_935cc8:
	st.as r6,[gp,-0x11]
L_935ccc:
	mov r32,r5
L_935cd0:
	st.ab r5,[r25,0x4]
L_935cd4:
	bclr r25,r25,0xa
L_935cd8:
	nop_s
L_935cda:
	nop_s
L_935cdc:
	nop_s
L_935cde:
	mov r7,r41
L_935ce2:
	bbit0 r7,0x1e,L_935cec
L_935ce6:
	ld_s r1,[r13]
L_935ce8:
	brne r1,0x1,L_935cf8
	.global L_935cec
L_935cec:
	bl.d L_923b50
L_935cf0:
	mov r0,r13
L_935cf4:
	b L_935d00
	.global L_935cf8
L_935cf8:
	bl.d L_923cb4
L_935cfc:
	mov r0,r13
	.global L_935d00
L_935d00:
	ldb_s r0,[r13,0x4]
L_935d02:
	mov_s blink,r14
L_935d04:
	ld_s r14,[sp,0x4]
L_935d06:
	j_s.d [blink]
L_935d08:
	ld.ab r13,[sp,0x8]
