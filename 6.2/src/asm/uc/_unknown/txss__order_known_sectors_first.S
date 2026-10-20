/* txss__order_known_sectors_first @ 0x938088, 316 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss__set_sweep_param
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, memcpy_uc, uc_shl64, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss__order_known_sectors_first
txss__order_known_sectors_first:
	.global L_938088
L_938088:
	push_s blink
L_93808a:
	bl L_92021c
L_93808e:
	mov_s r20,r0
L_938090:
	mov_s r17,r1
L_938092:
	mov_s r0,0x80218c
L_938098:
	ldb_s r15,[r0,0x8]
L_93809a:
	mov_s r13,0x0
L_93809c:
	st.a r13,[sp,-0x10]
L_9380a0:
	st_s r13,[sp,0x4]
L_9380a2:
	st_s r13,[sp,0x8]
L_9380a4:
	st_s r13,[sp,0xc]
L_9380a6:
	brne r15,0x0,L_93812e
L_9380aa:
	mov_s r0,r17
L_9380ac:
	mov_s r1,r20
L_9380ae:
	bl.d L_920330
L_9380b2:
	mov_s r2,0x40
L_9380b4:
	b_s L_93817a
	.global L_9380b6
L_9380b6:
	norm r0,r15
L_9380ba:
	rsub r18,r0,0x1e
L_9380be:
	asl r0,r18,0x4
L_9380c2:
	add2_s r0,r0,r0
L_9380c4:
	mov_s r1,0x80110c
L_9380ca:
	ld_s r0,[r1,r0]
L_9380cc:
	lsr_s r0,r0,0x8
L_9380ce:
	bmsk r16,r0,0xe
L_9380d2:
	cmp r16,0x40
L_9380d6:
	bmsk r19,r0,0x5
L_9380da:
	bhs_s L_9380e6
	.global L_9380dc
L_9380dc:
	cmp r16,0x40
L_9380e0:
	bhs_s L_9380f0
L_9380e2:
	mov_s r14,sp
L_9380e4:
	b_s L_9380f2
	.global L_9380e6
L_9380e6:
	mov_s r0,blink
L_9380e8:
	bl.d L_926618
L_9380ec:
	mov_s r1,0x5d
L_9380ee:
	b_s L_9380dc
	.global L_9380f0
L_9380f0:
	add_s r14,sp,0x8
	.global L_9380f2
L_9380f2:
	mov_s r0,0x1
L_9380f4:
	mov_s r1,0x0
L_9380f6:
	bl.d L_920458
L_9380fa:
	mov_s r2,r19
L_9380fc:
	mov_s r5,r0
L_9380fe:
	mov_s r4,r1
L_938100:
	ld_s r1,[r14]
L_938102:
	ld_s r0,[r14,0x4]
L_938104:
	and r6,r1,r5
L_938108:
	and r2,r0,r4
L_93810c:
	or.f 0x0,r6,r2
L_938110:
	bne_s L_93812a
L_938112:
	or r1,r1,r5
L_938116:
	or r0,r0,r4
L_93811a:
	st_s r1,[r14]
L_93811c:
	st_s r0,[r14,0x4]
L_93811e:
	add r12,r17,r13
L_938122:
	stb r16,[r12]
L_938126:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_938128:
	extb_s r13,r13
	.global L_93812a
L_93812a:
	bclr r15,r15,r18
	.global L_93812e
L_93812e:
	brne_s r15,0,L_9380b6
L_938130:
	mov_s r15,0x0
L_938132:
	b_s L_938140
	.global L_938134
L_938134:
	bic r2,r2,r4
L_938138:
	bic_s r0,r0,r1
L_93813a:
	st_s r2,[r14]
L_93813c:
	st_s r0,[r14,0x4]
	.global L_93813e
L_93813e:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_938140
L_938140:
	cmp_s r15,0x40
L_938142:
	bge L_93817a
L_938146:
	ld_s r1,[sp,0x0]
L_938148:
	ld_s r0,[sp,0x4]
L_93814a:
	or.f 0x0,r1,r0
L_93814e:
	add r16,r20,r15
L_938152:
	bne_s L_93815e
L_938154:
	ld_s r1,[sp,0x8]
L_938156:
	ld_s r0,[sp,0xc]
L_938158:
	or.f 0x0,r1,r0
L_93815c:
	beq_s L_93816a
	.global L_93815e
L_93815e:
	ldb r2,[r16]
L_938162:
	cmp_s r2,0x40
L_938164:
	bhs_s L_938180
L_938166:
	mov_s r14,sp
L_938168:
	b_s L_938184
	.global L_93816a
L_93816a:
	mov_s r12,0x40
L_93816c:
	rsub r2,r15,r12
L_938170:
	add r0,r17,r13
L_938174:
	bl.d L_920330
L_938178:
	mov_s r1,r16
	.global L_93817a
L_93817a:
	b.d L_920274
L_93817e:
	add_s sp,sp,0x10
	.global L_938180
L_938180:
	bmsk_s r2,r2,0x5
L_938182:
	add_s r14,sp,0x8
	.global L_938184
L_938184:
	mov_s r0,0x1
L_938186:
	bl.d L_920458
L_93818a:
	mov_s r1,0x0
L_93818c:
	mov_s r4,r0
L_93818e:
	ld_s r2,[r14]
L_938190:
	ld_s r0,[r14,0x4]
L_938192:
	and r5,r4,r2
L_938196:
	and r3,r1,r0
L_93819a:
	or.f 0x0,r5,r3
L_93819e:
	bne_s L_938134
L_9381a0:
	cmp_s r13,0x40
L_9381a2:
	bge_s L_9381b4
	.global L_9381a4
L_9381a4:
	ldb r0,[r16]
L_9381a8:
	add r12,r17,r13
L_9381ac:
	stb_s r0,[r12]
L_9381ae:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_9381b0:
	extb_s r13,r13
L_9381b2:
	b_s L_93813e
	.global L_9381b4
L_9381b4:
	mov_s r0,blink
L_9381b6:
	mov_s r1,0x1463
L_9381bc:
	bl L_926618
L_9381c0:
	b_s L_9381a4
L_9381c2:
	nop_s
