/* rx_get_required_response @ 0x932e40, 1468 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_get_required_response: received QoS/QoS-Null/BAR frame from disconnected sta_id-%d, midbrp_sta_en (0x%x), midbrp_sta_prev (0x%x),
 *   [NNL] tsf-0x%x, NO_RESPONSE required
 *   rx_get_required_response: received QoS-Null frame from disconnected sta_id-%d, midbrp_sta_en (0x%x), midbrp_sta_prev (0x%x),
 *   rx_get_required_response: received QoS frame from disconnected sta_id-%d, midbrp_sta_en (0x%x), midbrp_sta_prev (0x%x),
 *   SYSTEM
 *   rx_get_required_response:: ignoring grant due to BF trigger %d for sta %d
 * Зовут его: rx_flow__handle_frame
 * Зовёт сам: brp__split_id, field_rw_0x178__920ef4, grant_detect_step, mac__read_tsf64_uc, peer_masks__apply_op, uc_log__emit1, uc_log__emit2, uc_log__emit3, uc_read_tsf_lo
 * Глобалы (через gp): 0x800538, 0x800544, 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_get_required_response
rx_get_required_response:
	.global L_932e40
L_932e40:
	st.a r13,[sp,-0x24]
L_932e44:
	st blink,[sp, 0x4]
L_932e48:
	st_s r14,[sp,0x8]
L_932e4a:
	st_s r15,[sp,0xc]
L_932e4c:
	st r16,[sp, 0x10]
L_932e50:
	st r17,[sp, 0x14]
L_932e54:
	st r18,[sp, 0x18]
L_932e58:
	st r19,[sp, 0x1c]
L_932e5c:
	ld.as r10,[gp,-0xd]
L_932e60:
	mov r13,r0
L_932e64:
	st r20,[sp, 0x20]
L_932e68:
	brne.d r10,0x2,L_932e84
L_932e6c:
	mov_s r20,r1
L_932e6e:
	ldb r1,[0x802194]
L_932e76:
	breq_s r1,0,L_932e84
L_932e78:
	mov r0,0x801c18
L_932e80:
	bl L_9356cc
	.global L_932e84
L_932e84:
	ld.as r3,[gp,-0x2a]
L_932e88:
	brne r3,0x1,L_932e98
L_932e8c:
	ld.as r5,[gp,-0x29]
L_932e90:
	b.d L_933274
L_932e94:
	st.as r5,[gp,-0x2a]
	.global L_932e98
L_932e98:
	brlo r3,0x2,L_932ea4
L_932e9c:
	sub r3,r3,0x1
L_932ea0:
	st.as r3,[gp,-0x2a]
	.global L_932ea4
L_932ea4:
	and.f 0x0,r36,0x6
L_932ea8:
	beq L_9331d0
L_932eac:
	lsr r4,r38,0x10
L_932eb0:
	bmsk.f r4,r4,0x1
L_932eb4:
	beq L_932ecc
L_932eb8:
	cmp r4,0x1
L_932ebc:
	bne L_9331d0
L_932ec0:
	mov r7,0x0
L_932ec4:
	b.d L_933274
L_932ec8:
	st r7,[r20]
	.global L_932ecc
L_932ecc:
	ld r9,[0x8014c0]
L_932ed4:
	breq r9,0x0,L_932f00
L_932ed8:
	ld r2,[0x802288]
L_932ee0:
	mov r9,0x80212c
L_932ee8:
	ldb r3,[r9, 0x68]
L_932eec:
	asl r5,0x1,r2
L_932ef4:
	tst r3,r5
L_932ef8:
	beq.d L_932f08
L_932efc:
	mov r14,0x1
	.global L_932f00
L_932f00:
	b.d L_932f14
L_932f04:
	mov r14,0x0
	.global L_932f08
L_932f08:
	ldb r4,[r9, 0x69]
L_932f0c:
	tst r4,r5
L_932f10:
	beq L_932f00
	.global L_932f14
L_932f14:
	lsr r5,r36,0x13
L_932f18:
	bmsk r5,r5,0x4
L_932f1c:
	st r5,[r13, 0x8]
L_932f20:
	mov r11,r38
L_932f24:
	bbit1.d r11,0x19,L_932f30
L_932f28:
	extb_s r14,r14
L_932f2a:
	mov_s r2,r36
L_932f2c:
	bbit0 r2,0x12,L_932fd0
	.global L_932f30
L_932f30:
	breq r14,0x0,L_932f74
L_932f34:
	bl L_9364c8
L_932f38:
	mov r6,0x80212c
L_932f40:
	mov_s r13,r0
L_932f42:
	ldb r4,[r6, 0x69]
L_932f46:
	mov_s r1,0x1000fc0
L_932f4c:
	ld r2,[0x802288]
L_932f54:
	mov r0,0x10
L_932f58:
	ldb r3,[r6, 0x68]
	.global L_932f5c
L_932f5c:
	bl L_92d338
L_932f60:
	mov_s r1,0x1001048
L_932f66:
	mov_s r0,0x10
L_932f68:
	bl.d L_92d1d0
L_932f6c:
	mov r2,r13
L_932f70:
	b L_933274
	.global L_932f74
L_932f74:
	mov r6,r36
L_932f78:
	bbit0 r6,0x1,L_932fc8
L_932f7c:
	ld r9,[0x802288]
L_932f84:
	mov r14,0x802f80
L_932f8c:
	ldb r6,[r14,0x178]
L_932f94:
	asl r15,0x1,r9
L_932f9c:
	tst r6,r15
L_932fa0:
	beq.d L_932fc8
L_932fa4:
	mov r7,0x1
L_932fa8:
	st r7,[r13, 0x34]
L_932fac:
	and r2,r38,0x4000000
L_932fb4:
	bl.d L_9364c8
L_932fb8:
	st r2,[r13, 0x38]
L_932fbc:
	ld_s r1,[r13,0x38]
L_932fbe:
	mov_s r0,r14
L_932fc0:
	bl.d L_920ef4
L_932fc4:
	mov r2,r15
	.global L_932fc8
L_932fc8:
	b.d L_933378
L_932fcc:
	mov r0,0x2
	.global L_932fd0
L_932fd0:
	lsr r7,r39,0x8
L_932fd4:
	bmsk r7,r7,0x5
L_932fd8:
	cmp r7,0x8
L_932fdc:
	mov r17,0x1
L_932fe0:
	sub.ne r17,r17,r17
L_932fe4:
	mov r16,r36
L_932fe8:
	cmp r17,0x0
L_932fec:
	btst.eq r16,0x11
L_932ff0:
	bne L_93303c
L_932ff4:
	mov r10,0x800628
L_932ffc:
	st 0xff31,[r10]
	.global L_933004
L_933004:
	mov_s r0,r53
L_933006:
	bbit0 r0,0x3,L_933004
L_93300a:
	mov r5,0x0
L_93300e:
	st r5,[0x800628]
L_933016:
	mov r5,r53
L_93301a:
	btst r5,0x5
L_93301e:
	mov_s r1,0x0
L_933020:
	mov.ne r1,0x1
L_933024:
	st.as r1,[gp,0x7]
L_933028:
	mov_s r3,0x1c000008
L_93302e:
	mov_s r32,r3
L_933030:
	st.ab r3,[r25,0x4]
L_933034:
	bclr r25,r25,0xa
L_933038:
	b L_9330f8
	.global L_93303c
L_93303c:
	mov_s r15,0x802f80
L_933042:
	ld.as r3,[r15,0x51]
L_933046:
	mov r18,0x1
L_93304a:
	cmp r17,0x0
L_93304e:
	cmp.ne r3,0x0
L_933052:
	beq_s L_93307c
L_933054:
	mov r4,0x0
L_933058:
	st.as r4,[gp,0x7]
L_93305c:
	ld r5,[0x802288]
L_933064:
	mov r0,r15
L_933068:
	asl r2,0x1,r5
L_933070:
	bl.d L_934bb0
L_933074:
	mov r1,0x4
L_933078:
	b L_933080
	.global L_93307c
L_93307c:
	st.as r18,[gp,0x7]
	.global L_933080
L_933080:
	bbit0 r16,0x11,L_9330f8
L_933084:
	mov r19,0x802288
L_93308c:
	breq r14,0x0,L_9330b4
L_933090:
	bl L_9364c8
L_933094:
	mov_s r3,0x80212c
L_93309a:
	mov_s r13,r0
L_93309c:
	mov_s r1,0x1001070
L_9330a2:
	ldb r4,[r3, 0x69]
L_9330a6:
	mov_s r0,0x10
L_9330a8:
	ld r2,[r19]
L_9330ac:
	b.d L_932f5c
L_9330b0:
	ldb r3,[r3, 0x68]
	.global L_9330b4
L_9330b4:
	ldw r7,[0x804028]
L_9330bc:
	bbit0 r7,0x4,L_9330cc
L_9330c0:
	ld r8,[r13, 0xc]
L_9330c4:
	bset r8,r8,0xa
L_9330c8:
	st r8,[r13, 0xc]
	.global L_9330cc
L_9330cc:
	st r18,[r13, 0x34]
L_9330d0:
	and r6,r38,0x4000000
L_9330d8:
	st r6,[r13, 0x38]
L_9330dc:
	bl.d L_9364c8
L_9330e0:
	ld r18,[r19]
L_9330e4:
	mov r0,r15
L_9330e8:
	asl r2,0x1,r18
L_9330f0:
	bl.d L_920ef4
L_9330f4:
	ld r1,[r13, 0x38]
	.global L_9330f8
L_9330f8:
	ld.as r6,[gp,0x7]
L_9330fc:
	brne r6,0x1,L_9331c4
L_933100:
	breq r17,0x0,L_93313c
L_933104:
	ld r5,[0x802288]
L_93310c:
	mov r0,0x802f80
L_933114:
	asl r2,0x1,r5
L_93311c:
	bl.d L_934bb0
L_933120:
	mov r1,0x3
L_933124:
	mov r5,0x801030
L_93312c:
	ldb r4,[r5, 0x90]
L_933130:
	add r4,r4,0x1
L_933134:
	b.d L_9331bc
L_933138:
	stb r4,[r5, 0x90]
	.global L_93313c
L_93313c:
	bbit1 r16,0x11,L_9331bc
L_933140:
	mov_s r15,0x802288
L_933146:
	breq_s r14,0,L_933174
L_933148:
	mov r9,r36
L_93314c:
	bbit0 r9,0x1,L_933174
L_933150:
	bl L_9364c8
L_933154:
	mov r5,0x80212c
L_93315c:
	mov_s r13,r0
L_93315e:
	mov_s r1,0x10010f0
L_933164:
	ldb r4,[r5, 0x69]
L_933168:
	mov_s r0,0x10
L_93316a:
	ld_s r2,[r15]
L_93316c:
	b.d L_932f5c
L_933170:
	ldb r3,[r5, 0x68]
	.global L_933174
L_933174:
	ld r8,[r15]
L_933178:
	mov r14,0x802f80
L_933180:
	asl r15,0x1,r8
L_933188:
	ldb r8,[r14,0x178]
L_933190:
	tst r8,r15
L_933194:
	beq.d L_9331bc
L_933198:
	mov r4,0x1
L_93319c:
	st r4,[r13, 0x34]
L_9331a0:
	and r3,r38,0x4000000
L_9331a8:
	bl.d L_9364c8
L_9331ac:
	st r3,[r13, 0x38]
L_9331b0:
	ld_s r1,[r13,0x38]
L_9331b2:
	mov_s r0,r14
L_9331b4:
	bl.d L_920ef4
L_9331b8:
	mov r2,r15
	.global L_9331bc
L_9331bc:
	b.d L_933378
L_9331c0:
	mov r0,0x1
	.global L_9331c4
L_9331c4:
	ld.as r6,[gp,-0x31]
L_9331c8:
	add r6,r6,0x1
L_9331cc:
	st.as r6,[gp,-0x31]
	.global L_9331d0
L_9331d0:
	mov_s r0,r37
L_9331d2:
	bbit0 r0,0x0,L_93327c
L_9331d6:
	mov_s r0,0x0
L_9331d8:
	bl.d L_9364c8
L_9331dc:
	st r0,[r20]
L_9331e0:
	sub r0,r0,0xe
L_9331e4:
	mov r8,0x801030
L_9331ec:
	ldw r7,[r8, 0xb4]
L_9331f0:
	st r0,[0x8006e0]
L_9331f8:
	ld.as r9,[gp,0x33]
L_9331fc:
	add r7,r7,0x1
L_933200:
	and r5,r9,0x8
L_933204:
	mov r4,0x0
L_933208:
	or.f 0x0,r5,r4
L_93320c:
	bne.d L_93323c
L_933210:
	stw r7,[r8, 0xb4]
L_933214:
	mov r11,0x8022c8
L_93321c:
	ld r8,[r11, 0x70]
L_933220:
	mov r0,0x857000
L_933228:
	add r8,r8,0x1
L_93322c:
	ld r9,[r0, 0x2c]
L_933230:
	st r8,[r11, 0x70]
L_933234:
	add r9,r9,0x1
L_933238:
	st r9,[r0, 0x2c]
	.global L_93323c
L_93323c:
	ld r1,[0x802288]
L_933244:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_933246:
	add2_s r1,r1,r1
L_933248:
	ldb r10,[r1,0x857e49]
L_933250:
	brne r10,0x0,L_933274
L_933254:
	ldb r0,[0x802969]
L_93325c:
	mov r1,0x0
L_933260:
	bl.d L_92db88
L_933264:
	mov r2,r1
L_933268:
	cmp_s r0,0x0
L_93326a:
	mov_s r0,0x3
L_93326c:
	b.d L_933378
L_933270:
	mov.eq r0,0x7
	.global L_933274
L_933274:
	b.d L_933378
L_933278:
	mov r0,0x0
	.global L_93327c
L_93327c:
	mov r2,r37
L_933280:
	bbit0 r2,0x10,L_933300
L_933284:
	and.f 0x0,r38,0x1f00000
L_93328c:
	beq.d L_9332b0
L_933290:
	mov_s r0,0x0
L_933292:
	ld r2,[0x802288]
L_93329a:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_93329c:
	add2_s r2,r2,r2
L_93329e:
	add_s r2,r2,0x801104
L_9332a4:
	ldw r10,[r2, 0x2]
L_9332a8:
	bclr r10,r10,0x1
L_9332ac:
	stw r10,[r2, 0x2]
	.global L_9332b0
L_9332b0:
	st r0,[r20]
L_9332b4:
	ldw r11,[0x804012]
L_9332bc:
	breq r11,0x0,L_9332ec
L_9332c0:
	mov_s r1,0x15
L_9332c2:
	asl_s r1,r1,0x18
L_9332c4:
	mov r32,r1
L_9332c8:
	st.ab r1,[r25,0x4]
L_9332cc:
	bclr r25,r25,0xa
L_9332d0:
	mov r6,0x14000007
L_9332d8:
	mov r32,r6
L_9332dc:
	st.ab r6,[r25,0x4]
L_9332e0:
	bclr r25,r25,0xa
L_9332e4:
	b.d L_933378
L_9332e8:
	mov r0,0x8
	.global L_9332ec
L_9332ec:
	mov_s r2,0x80242c
L_9332f2:
	ldw_s r1,[r2,0x6]
L_9332f4:
	add r1,r1,0x1
L_9332f8:
	b.d L_933378
L_9332fc:
	stw r1,[r2, 0x6]
	.global L_933300
L_933300:
	mov r7,r37
L_933304:
	bbit0 r7,0xa,L_93339c
L_933308:
	ld.as r3,[gp,-0xd]
L_93330c:
	brne r3,0x2,L_933358
L_933310:
	ld r3,[0x802288]
L_933318:
	asl r4,r3,0x2
L_93331c:
	add2 r4,r4,r4
L_933320:
	ldb r2,[r4,0x857e49]
L_933328:
	breq_s r2,0,L_93333c
L_93332a:
	mov_s r1,0x1001168
L_933330:
	bl.d L_92d27c
L_933334:
	mov r0,0x22
L_933338:
	b L_933274
	.global L_93333c
L_93333c:
	ldw r4,[0x804012]
L_933344:
	ld.as r11,[gp,0x34]
L_933348:
	stw r4,[0x8005c0]
L_933350:
	bset r11,r11,0xc
L_933354:
	st.as r11,[gp,0x34]
	.global L_933358
L_933358:
	mov r8,0x8022c8
L_933360:
	ld r7,[r8, 0x78]
L_933364:
	mov r6,0x0
L_933368:
	add r7,r7,0x1
L_93336c:
	st r7,[r8, 0x78]
L_933370:
	st r6,[r20]
L_933374:
	mov r0,0x9
	.global L_933378
L_933378:
	ld blink,[sp, 0x4]
L_93337c:
	ld_s r14,[sp,0x8]
L_93337e:
	ld_s r15,[sp,0xc]
L_933380:
	ld r16,[sp, 0x10]
L_933384:
	ld r17,[sp, 0x14]
L_933388:
	ld r18,[sp, 0x18]
L_93338c:
	ld r19,[sp, 0x1c]
L_933390:
	ld r20,[sp, 0x20]
L_933394:
	j.d [blink]
L_933398:
	ld.ab r13,[sp,0x24]
	.global L_93339c
L_93339c:
	mov r10,0x802288
L_9333a4:
	ld r8,[r10, 0x10]
L_9333a8:
	bbit0 r8,0x4,L_9333c4
L_9333ac:
	ld r2,[r13]
L_9333b0:
	ld r0,[r10]
L_9333b4:
	brne r0,r2,L_9333c4
L_9333b8:
	ld.as r5,[gp,0x4]
L_9333bc:
	b.d L_932fc8
L_9333c0:
	st r5,[r13, 0x8]
	.global L_9333c4
L_9333c4:
	mov r11,r37
L_9333c8:
	btst r11,0x11
L_9333cc:
	beq L_933274
L_9333d0:
	ld r0,[0x8029f0]
L_9333d8:
	bl.d L_934dc8
L_9333dc:
	ld r0,[r0, 0x2c]
L_9333e0:
	mov r10,0x8022c8
L_9333e8:
	ld r9,[r10, 0x7c]
L_9333ec:
	add r9,r9,0x1
L_9333f0:
	st r9,[r10, 0x7c]
L_9333f4:
	b.d L_933378
L_9333f8:
	mov_s r0,0x0
L_9333fa:
	nop_s
