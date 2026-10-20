/* aw_worker__collect_awake_peers @ 0x925ea4, 704 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   aw_worker.cpp
 * Зовут его: aw_worker__begin_window
 * Зовёт сам: aw__fold_peer_masks, aw__foreach_awake_peer, get_reg_881c84, memset0_words_uc, peer__aid_mismatch_flag, power_mngr_peer_update, uc_sysassert
 * Глобалы (через gp): 0x800574
 */
	.section .text.aw_worker__collect_awake_peers,"ax",@progbits
	.global aw_worker__collect_awake_peers
aw_worker__collect_awake_peers:
	.global L_925ea4
L_925ea4:
	st.a r13,[sp,-0x2c]
L_925ea8:
	st blink,[sp, 0x4]
L_925eac:
	st_s r14,[sp,0x8]
L_925eae:
	st_s r15,[sp,0xc]
L_925eb0:
	st r16,[sp, 0x10]
L_925eb4:
	st r17,[sp, 0x14]
L_925eb8:
	st r18,[sp, 0x18]
L_925ebc:
	st r19,[sp, 0x1c]
L_925ec0:
	st r20,[sp, 0x20]
L_925ec4:
	st r21,[sp, 0x24]
L_925ec8:
	st r22,[sp, 0x28]
L_925ecc:
	sub_s sp,sp,0xc
L_925ece:
	mov_s r16,r0
L_925ed0:
	mov r21,0x0
L_925ed4:
	st r21,[r0]
L_925ed8:
	mov r0,sp
L_925edc:
	bl.d L_92166c
L_925ee0:
	mov r1,0x8
L_925ee4:
	mov r20,0x801ed0
L_925eec:
	mov_s r0,r20
L_925eee:
	mov_s r1,r21
L_925ef0:
	bl.d L_9302a4
L_925ef4:
	mov r2,r21
L_925ef8:
	mov r22,0x800fcc
L_925f00:
	bl.d L_926b90
L_925f04:
	ldb r18,[r22, 0x68]
L_925f08:
	mov.f r14,r0
L_925f0c:
	beq L_925fbc
L_925f10:
	add r19,sp,0x8
L_925f14:
	mov r17,0x802080
	.global L_925f1c
L_925f1c:
	norm r0,r14
L_925f20:
	rsub r15,r0,0x1e
L_925f24:
	extb_s r15,r15
L_925f26:
	mov_s r0,r15
L_925f28:
	bl.d L_9374d0
L_925f2c:
	mov r1,r19
L_925f30:
	ld r4,[sp, 0x8]
L_925f34:
	mov r13,r0
L_925f38:
	breq.d r4,0x0,L_925f90
L_925f3c:
	bclr r14,r14,r15
L_925f40:
	brge r13,0x8,L_925f74
	.global L_925f44
L_925f44:
	ldb r10,[r16]
L_925f48:
	asl r3,0x1,r13
L_925f50:
	or r10,r10,r3
L_925f54:
	stb r10,[r16]
L_925f58:
	ldb r11,[sp]
L_925f5c:
	add_s r13,r13,r17
L_925f5e:
	or r11,r11,r3
L_925f62:
	ldb_s r0,[r13]
L_925f64:
	stb r11,[sp]
L_925f68:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925f6a:
	stb_s r0,[r13]
L_925f6c:
	brne r14,0x0,L_925f1c
L_925f70:
	b L_925fbc
	.global L_925f74
L_925f74:
	mov_s r0,blink
L_925f76:
	mov_s r2,0x10032b0
L_925f7c:
	mov r1,0x141f
L_925f84:
	bl.d L_925548
L_925f88:
	mov r3,0x8c
L_925f8c:
	b L_925f44
	.global L_925f90
L_925f90:
	ldb r6,[r16, 0x1]
L_925f94:
	or r6,r6,r18
L_925f98:
	breq.d r18,0x0,L_925fac
L_925f9c:
	stb r6,[r16, 0x1]
L_925fa0:
	ld r7,[sp, 0x4]
L_925fa4:
	bset r7,r7,0x19
L_925fa8:
	st r7,[sp, 0x4]
	.global L_925fac
L_925fac:
	ldb r8,[r17, 0x9]
L_925fb0:
	add r8,r8,0x1
L_925fb4:
	stb r8,[r17, 0x9]
L_925fb8:
	brne r14,0x0,L_925f1c
	.global L_925fbc
L_925fbc:
	mov_s r13,0x857000
L_925fc2:
	ld r6,[r13, 0x68]
L_925fc6:
	breq r6,0x0,L_92603c
L_925fca:
	ldb r1,[r16]
L_925fce:
	mov r5,0x802080
L_925fd6:
	or r1,r1,r6
L_925fda:
	stb r1,[r16]
L_925fde:
	ld r4,[r13, 0x68]
L_925fe2:
	ld_s r1,[sp,0x4]
L_925fe4:
	extb r6,r4
L_925fe8:
	ror r2,r1,0x10
L_925fec:
	mov r7,-0x200
L_925ff0:
	and r2,r2,r7
L_925ff4:
	or r2,r2,r6
L_925ff8:
	ror r2,r2,0x10
L_925ffc:
	bbit0.d r4,0x8,L_926030
L_926000:
	st_s r2,[sp,0x4]
L_926002:
	ldb r1,[r16, 0x1]
L_926006:
	or r1,r1,r18
L_92600a:
	stb r1,[r16, 0x1]
L_92600e:
	ld_s r3,[sp,0x4]
L_926010:
	lsr r4,r3,0x10
L_926014:
	ror r3,r3,0x10
L_926018:
	bmsk r4,r4,0x8
L_92601c:
	and r3,r3,r7
L_926020:
	bset r4,r4,0x8
L_926024:
	or r3,r3,r4
L_926028:
	ror r3,r3,0x10
L_92602c:
	st r3,[sp, 0x4]
	.global L_926030
L_926030:
	ldb r4,[r5, 0x8]
L_926034:
	add r4,r4,0x1
L_926038:
	stb r4,[r5, 0x8]
	.global L_92603c
L_92603c:
	add r2,sp,0x3
L_926040:
	mov r0,r16
L_926044:
	bl.d L_924880
L_926048:
	mov r1,r18
L_92604c:
	ld.as r9,[gp,0x13]
L_926050:
	breq r9,0x0,L_926088
L_926054:
	ld r2,[0x8009e8]
L_92605c:
	mov r5,0x802080
L_926064:
	breq r2,0x0,L_926078
L_926068:
	ldb r2,[r16]
L_92606c:
	or r2,r2,r9
L_926070:
	stb r2,[r16]
L_926074:
	ld.as r9,[gp,0x13]
	.global L_926078
L_926078:
	ldb r3,[r5, 0xb]
L_92607c:
	stb r9,[sp, 0x2]
L_926080:
	add r3,r3,0x1
L_926084:
	stb r3,[r5, 0xb]
	.global L_926088
L_926088:
	ld r9,[0x80068c]
L_926090:
	breq.d r9,0x0,L_9260b4
L_926094:
	ldb r5,[r16]
L_926098:
	ldb r4,[gp, -0xe6]
L_92609c:
	or r4,r4,r5
L_9260a0:
	stb r4,[r16]
L_9260a4:
	ldb r3,[gp, -0xe6]
L_9260a8:
	stb r21,[gp, -0xe6]
L_9260ac:
	stb r3,[sp, 0x1]
L_9260b0:
	ldb r5,[r16]
	.global L_9260b4
L_9260b4:
	ldb r0,[r20,0x128]
L_9260bc:
	ldb r1,[r16, 0x1]
L_9260c0:
	and r5,r5,r0
L_9260c4:
	stb r5,[r16]
L_9260c8:
	and r1,r1,r0
L_9260cc:
	stb r1,[r16, 0x1]
L_9260d0:
	bl.d L_9251d4
L_9260d4:
	stb r0,[sp, 0x5]
L_9260d8:
	ld r2,[r20, 0x20]
L_9260dc:
	ldb r9,[r22, 0x68]
L_9260e0:
	cmp_s r2,0x2
L_9260e2:
	mov_s r2,0x1
L_9260e4:
	sub.ne r2,r2,r2
L_9260e8:
	extb.f 0x0,r2
L_9260ec:
	norm r9,r9
L_9260f0:
	beq.d L_92611c
L_9260f4:
	rsub r8,r9,0x1e
L_9260f8:
	asl r8,r8,0x2
L_9260fc:
	add2 r8,r8,r8
L_926100:
	ldb r5,[r8,0x857849]
L_926108:
	brne r5,0x0,L_92611c
L_92610c:
	st r21,[r16]
L_926110:
	ld r11,[sp, 0x4]
L_926114:
	bset r11,r11,0x1a
L_926118:
	st r11,[sp, 0x4]
	.global L_92611c
L_92611c:
	ld r6,[sp]
L_926120:
	ld r8,[sp, 0x4]
L_926124:
	st r6,[r13, 0x54]
L_926128:
	st r8,[r13, 0x58]
L_92612c:
	ld r0,[r16]
L_926130:
	add_s sp,sp,0xc
L_926132:
	sub.f r0,r0,0x0
L_926136:
	ld blink,[sp, 0x4]
L_92613a:
	mov.ne r0,0x1
L_92613e:
	ld_s r14,[sp,0x8]
L_926140:
	ld_s r15,[sp,0xc]
L_926142:
	ld r16,[sp, 0x10]
L_926146:
	ld r17,[sp, 0x14]
L_92614a:
	ld r18,[sp, 0x18]
L_92614e:
	ld r19,[sp, 0x1c]
L_926152:
	ld r20,[sp, 0x20]
L_926156:
	ld r21,[sp, 0x24]
L_92615a:
	ld r22,[sp, 0x28]
L_92615e:
	j_s.d [blink]
L_926160:
	ld.ab r13,[sp,0x2c]
