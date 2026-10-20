/* rx_flow__phy_override @ 0x92a0c4, 416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Глобалы (через gp): 0x800568, 0x8005c8
 */
	.section .text.rx_flow__phy_override,"ax",@progbits
	.global rx_flow__phy_override
rx_flow__phy_override:
	.global L_92a0c4
L_92a0c4:
	st.a r13,[sp,-0x10]
L_92a0c8:
	st_s r14,[sp,0x4]
L_92a0ca:
	st_s r15,[sp,0x8]
L_92a0cc:
	st r16,[sp, 0xc]
L_92a0d0:
	sub_s sp,sp,0x40
L_92a0d2:
	mov r6,0x883000
L_92a0da:
	ld r16,[r6, 0x6c]
L_92a0de:
	ld r5,[0x8016b4]
L_92a0e6:
	mov_s r15,0x0
L_92a0e8:
	st r5,[r6, 0x6c]
L_92a0ec:
	ldb r10,[0x8010f0]
L_92a0f4:
	mov_s r14,0x883800
L_92a0fa:
	cmp r10,0x0
L_92a0fe:
	mov_s r8,r15
L_92a100:
	bls.d L_92a1a4
L_92a104:
	mov r10,r15
	.global L_92a108
L_92a108:
	ld r6,[r14, 0x30]
L_92a10c:
	mov_s r13,0x8014f0
L_92a112:
	ld r7,[r14, 0x30]
L_92a116:
	bmsk r6,r6,0x6
L_92a11a:
	ld r9,[r14, 0x30]
L_92a11e:
	bmsk r7,r7,0x6
L_92a122:
	ld_s r1,[r14,0x30]
L_92a124:
	bmsk r9,r9,0x6
L_92a128:
	ld_s r2,[r14,0x30]
L_92a12a:
	bmsk_s r1,r1,0x6
L_92a12c:
	ld_s r3,[r14,0x30]
L_92a12e:
	bmsk_s r2,r2,0x6
L_92a130:
	ld r4,[r14, 0x30]
L_92a134:
	bmsk_s r3,r3,0x6
L_92a136:
	ld r5,[r14, 0x30]
L_92a13a:
	bmsk r4,r4,0x6
L_92a13e:
	ld.as r6,[r13,r6]
L_92a142:
	ld.as r0,[r13,r7]
L_92a146:
	bmsk r5,r5,0x6
L_92a14a:
	ld.as r11,[r13,r9]
L_92a14e:
	add_s r0,r0,r6
L_92a150:
	ld.as r1,[r13,r1]
L_92a154:
	add r11,r11,r0
L_92a158:
	ld.as r0,[r13,r2]
L_92a15c:
	ld.as r2,[r13,r3]
L_92a160:
	add r11,r11,r1
L_92a164:
	ld.as r3,[r13,r4]
L_92a168:
	add_s r2,r2,r0
L_92a16a:
	ld.as r4,[r13,r5]
L_92a16e:
	add_s r3,r3,r2
L_92a170:
	mov r6,r42
L_92a174:
	add r4,r4,r3
L_92a178:
	bbit1.d r6,0xe,L_92a19c
L_92a17c:
	add r4,r4,r11
L_92a180:
	add_s r15,r15,r4
L_92a182:
	add2 r1,sp,r10
L_92a186:
	ldb r0,[0x8010f0]
L_92a18e:
	add r8,r8,0x8
L_92a192:
	st_s r15,[r1]
L_92a194:
	brlo.d r8,r0,L_92a108
L_92a198:
	add r10,r10,0x1
	.global L_92a19c
L_92a19c:
	mov r6,0x883000
	.global L_92a1a4
L_92a1a4:
	ld.as r5,[r14,0xbb]
L_92a1a8:
	mov r0,0x8010dc
L_92a1b0:
	lsr r5,r5,0x9
L_92a1b4:
	bmsk r5,r5,0x8
L_92a1b8:
	sub r11,r5,0x200
L_92a1c0:
	cmp r5,0xff
L_92a1c4:
	mov.le r11,r5
L_92a1c8:
	add r11,r11,0x2
L_92a1cc:
	asr r11,r11,0x2
L_92a1d0:
	st r11,[r0, 0x8]
L_92a1d4:
	st r16,[r6, 0x6c]
L_92a1d8:
	stb r8,[0x800879]
L_92a1e0:
	breq r8,0x0,L_92a254
L_92a1e4:
	norm r10,r10
L_92a1e8:
	rsub r11,r10,0x1e
L_92a1ec:
	asl r7,0x1,r11
L_92a1f4:
	sub r7,r7,0x1
L_92a1f8:
	norm r8,r8
L_92a1fc:
	rsub r2,r8,0x1e
L_92a200:
	add2 r4,sp,r7
L_92a204:
	ld r9,[r4]
L_92a208:
	rsub r1,r2,0x7
L_92a20c:
	asl r9,r9,r1
L_92a210:
	mov r7,0x800fcc
L_92a218:
	ld r3,[r7, 0x4]
L_92a21c:
	st r9,[r0, 0x4]
L_92a220:
	mov r10,0x1
L_92a224:
	brlo.d r9,r3,L_92a240
L_92a228:
	stw.as r10,[gp,0x50]
L_92a22c:
	st.as r0,[gp,0x10]
L_92a230:
	add_s sp,sp,0x40
L_92a232:
	ld_s r14,[sp,0x4]
L_92a234:
	ld_s r15,[sp,0x8]
L_92a236:
	ld r16,[sp, 0xc]
L_92a23a:
	j_s.d [blink]
L_92a23c:
	ld.ab r13,[sp,0x10]
	.global L_92a240
L_92a240:
	st.as r7,[gp,0x10]
L_92a244:
	add_s sp,sp,0x40
L_92a246:
	ld_s r14,[sp,0x4]
L_92a248:
	ld_s r15,[sp,0x8]
L_92a24a:
	ld r16,[sp, 0xc]
L_92a24e:
	j_s.d [blink]
L_92a250:
	ld.ab r13,[sp,0x10]
	.global L_92a254
L_92a254:
	add_s sp,sp,0x40
L_92a256:
	ld_s r14,[sp,0x4]
L_92a258:
	ld_s r15,[sp,0x8]
L_92a25a:
	ld r16,[sp, 0xc]
L_92a25e:
	j_s.d [blink]
L_92a260:
	ld.ab r13,[sp,0x10]
