/* internal_tx__flow_sm2 @ 0x939100, 900 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_isr
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, direct_tx__program_cmd34, direct_tx__send_after_delay, gp0__arm_usec_b, handle_bf_triggers, internal_tx__clear_pending, itx__rr_pick_pending_b, itx__wait_ack, itx__wait_cts_b, mac__cmd_29000001, mac__program_rx_window
 * Глобалы (через gp): 0x800570, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__flow_sm2
internal_tx__flow_sm2:
	.global L_939100
L_939100:
	push_s blink
L_939102:
	bl L_920234
L_939106:
	sub_s sp,sp,0x8
L_939108:
	bl.d L_927f00
L_93910c:
	mov_s r0,sp
L_93910e:
	brne_s r0,0,L_93911a
L_939110:
	bl.d L_9394d0
L_939114:
	mov_s r0,0x8
L_939116:
	b L_93947e
	.global L_93911a
L_93911a:
	ld_s r1,[sp,0x0]
L_93911c:
	mov_s r14,0x80111c
L_939122:
	asl_s r0,r1,0x4
L_939124:
	add2_s r0,r0,r0
L_939126:
	ld_s r0,[r14,r0]
L_939128:
	brne_s r0,0,L_939134
L_93912a:
	bl.d L_9394d0
L_93912e:
	mov_s r0,r1
L_939130:
	b L_93947e
	.global L_939134
L_939134:
	ld_s r0,[gp,-0x34]
L_939136:
	cmp_s r0,0x1
L_939138:
	bl.eq.d L_934e18
L_93913c:
	mov.eq r0,r1
L_939140:
	bl.d L_9384d4
L_939144:
	mov_s r0,0x1
L_939146:
	ld_s r1,[sp,0x0]
L_939148:
	mov_s r13,r0
L_93914a:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93914c:
	add2_s r1,r1,r1
L_93914e:
	add_s r1,r1,0x857e38
L_939154:
	ldw_s r0,[r1]
L_939156:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_939158:
	stw_s r0,[r1]
L_93915a:
	mov_s r1,0x857000
L_939160:
	ld_s r0,[r1]
L_939162:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_939164:
	st_s r0,[r1]
L_939166:
	ld_s r0,[gp,0x48]
L_939168:
	st.as r0,[r1,0x71]
L_93916c:
	mov_s r0,0x0
L_93916e:
	st_s r0,[r13,0x8]
L_939170:
	ld_s r0,[sp,0x0]
L_939172:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_939174:
	add2_s r0,r0,r0
L_939176:
	ld_s r0,[r14,r0]
L_939178:
	norm r0,r0
L_93917c:
	rsub r1,r0,0x1e
L_939180:
	st_s r1,[r13,0x4]
L_939182:
	bl.d L_928384
L_939186:
	mov_s r0,0x12
L_939188:
	mov_s r0,0x15000028
L_93918e:
	mov_s r32,r0
L_939190:
	st.ab r0,[r25,0x4]
L_939194:
	bclr r25,r25,0xa
L_939198:
	mov_s r0,0x14000007
L_93919e:
	mov_s r32,r0
L_9391a0:
	st.ab r0,[r25,0x4]
L_9391a4:
	bclr r25,r25,0xa
L_9391a8:
	mov_s r0,0x10
L_9391aa:
	bl.d L_9257a8
L_9391ae:
	mov_s r1,r0
L_9391b0:
	bl.d L_92d8e8
L_9391b4:
	mov_s r0,0x0
	.global L_9391b6
L_9391b6:
	mov_s r0,r43
L_9391b8:
	bbit0 r0,0x1f,L_9391b6
L_9391bc:
	mov_s r0,r51
L_9391be:
	bmsk r1,r0,0x3
L_9391c2:
	st.as r1,[gp,0x38]
L_9391c6:
	lsr_s r0,r0,0x4
L_9391c8:
	st.as r0,[gp,0x39]
	.global L_9391cc
L_9391cc:
	mov_s r0,r45
L_9391ce:
	bbit0 r0,0x1f,L_9391cc
L_9391d2:
	ld_s r0,[sp,0x0]
L_9391d4:
	mov_s r1,0xb
L_9391d6:
	bl.d L_938218
L_9391da:
	mov_s r2,0x0
L_9391dc:
	ld_s r0,[gp,-0x44]
L_9391de:
	and r0,r0,0xffff0fff
L_9391e6:
	bset r1,r0,0xd
L_9391ea:
	bset_s r1,r1,0xf
L_9391ec:
	or r0,r0,0x1d00a000
L_9391f4:
	st.as r1,[gp,-0x11]
L_9391f8:
	mov_s r32,r0
L_9391fa:
	st.ab r0,[r25,0x4]
L_9391fe:
	bclr r25,r25,0xa
L_939202:
	bl L_936870
L_939206:
	bl L_936520
L_93920a:
	mov_s r1,r40
L_93920c:
	mov_s r0,r42
L_93920e:
	bbit1 r0,0xe,L_939216
L_939212:
	bbit1 r1,0x18,L_939242
	.global L_939216
L_939216:
	mov_s r0,r45
L_939218:
	bbit0 r0,0x1f,L_939216
L_93921c:
	mov_s r0,0x29000002
L_939222:
	mov_s r32,r0
L_939224:
	st.ab r0,[r25,0x4]
L_939228:
	bclr r25,r25,0xa
L_93922c:
	ld_s r1,[sp,0x0]
L_93922e:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_939230:
	add2_s r1,r1,r1
L_939232:
	add_s r1,r1,0x857e38
L_939238:
	ldb_s r0,[r1,0x9]
L_93923a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93923c:
	b.d L_93947e
L_939240:
	stb_s r0,[r1,0x9]
	.global L_939242
L_939242:
	ld_s r0,[sp,0x0]
L_939244:
	mov_s r1,0x80110c
L_93924a:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93924c:
	add2_s r0,r0,r0
L_93924e:
	ld_s r1,[r1,r0]
L_939250:
	mov_s r0,0x5
L_939252:
	mov_s r2,0x0
L_939254:
	bl.d L_92f798
L_939258:
	mov_s r3,r2
L_93925a:
	mov_s r0,0x19000001
L_939260:
	mov_s r32,r0
L_939262:
	st.ab r0,[r25,0x4]
L_939266:
	bclr r25,r25,0xa
L_93926a:
	mov_s r0,0x18
L_93926c:
	asl_s r0,r0,0x18
L_93926e:
	mov_s r32,r0
L_939270:
	st.ab r0,[r25,0x4]
L_939274:
	bclr r25,r25,0xa
L_939278:
	bl.d L_936544
L_93927c:
	mov_s r0,0x6
L_93927e:
	ld_s r1,[sp,0x0]
L_939280:
	mov_s r0,0x801108
L_939286:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_939288:
	add2_s r1,r1,r1
L_93928a:
	ld_s r1,[r0,r1]
L_93928c:
	add_s r14,r0,0x4
L_93928e:
	bl.d L_92f42c
L_939292:
	mov_s r0,0x1
L_939294:
	bl L_9364c8
L_939298:
	mov_s r1,0x8006e0
L_93929e:
	st_s r0,[r1]
L_9392a0:
	bl.d L_9361bc
L_9392a4:
	mov_s r0,0x5
L_9392a6:
	ld_s r0,[gp,0x178]
L_9392a8:
	mov_s r1,0x802944
L_9392ae:
	bclr_s r0,r0,0x18
L_9392b0:
	ld_s r1,[r1]
L_9392b2:
	bclr_s r0,r0,0x19
L_9392b4:
	asl_s r1,r1,0x18
L_9392b6:
	or_s r0,r0,r1
L_9392b8:
	st.as r0,[gp,0x5e]
L_9392bc:
	mov_s r1,0x889480
L_9392c2:
	st_s r0,[r1,0x8]
L_9392c4:
	bl L_93dfb0
L_9392c8:
	cmp_s r0,0x0
L_9392ca:
	ld_s r1,[sp,0x0]
L_9392cc:
	beq_s L_9393f4
L_9392ce:
	asl_s r0,r1,0x4
L_9392d0:
	add2_s r0,r0,r0
L_9392d2:
	ld_s r1,[r14,r0]
L_9392d4:
	mov_s r0,0x1
L_9392d6:
	mov_s r2,r0
L_9392d8:
	bl.d L_92f798
L_9392dc:
	mov_s r3,0x0
L_9392de:
	mov_s r0,r13
L_9392e0:
	mov_s r1,0x1
L_9392e2:
	mov_s r2,0x0
L_9392e4:
	bl.d L_9396a0
L_9392e8:
	mov_s r3,r2
L_9392ea:
	mov_s r0,0x20000400
L_9392f0:
	mov_s r32,r0
L_9392f2:
	st.ab r0,[r25,0x4]
L_9392f6:
	bclr r25,r25,0xa
L_9392fa:
	bl.d L_928384
L_9392fe:
	mov_s r0,0xc
L_939300:
	mov_s r0,0x2008000
L_939306:
	mov_s r32,r0
L_939308:
	st.ab r0,[r25,0x4]
L_93930c:
	bclr r25,r25,0xa
L_939310:
	mov_s r0,0x19000001
L_939316:
	mov_s r32,r0
L_939318:
	st.ab r0,[r25,0x4]
L_93931c:
	bclr r25,r25,0xa
	.global L_939320
L_939320:
	mov_s r0,r45
L_939322:
	bbit0 r0,0x1f,L_939320
L_939326:
	mov_s r0,0x802f80
L_93932c:
	ldb r0,[r0,0x179]
L_939334:
	cmp_s r0,0x1
L_939336:
	mov.eq r0,0x18000400
L_93933e:
	mov.ne r0,0x18
L_939342:
	asl.ne r0,r0,0x18
L_939346:
	mov_s r32,r0
L_939348:
	st.ab r0,[r25,0x4]
L_93934c:
	bclr r25,r25,0xa
L_939350:
	bl.d L_936544
L_939354:
	mov_s r0,0x6
L_939356:
	ld_s r0,[sp,0x0]
L_939358:
	mov_s r1,0x801108
L_93935e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_939360:
	add2_s r0,r0,r0
L_939362:
	ld_s r1,[r1,r0]
L_939364:
	bl.d L_92f42c
L_939368:
	mov_s r0,0x1
L_93936a:
	ld_s r0,[sp,0x0]
L_93936c:
	mov_s r13,0x857e38
L_939372:
	stb r0,[gp, -0xe6]
L_939376:
	bl.d L_9361bc
L_93937a:
	mov_s r0,0x5
L_93937c:
	ld_s r0,[gp,0x178]
L_93937e:
	mov_s r1,0x802944
L_939384:
	bclr_s r0,r0,0x18
L_939386:
	ld_s r1,[r1]
L_939388:
	bclr_s r0,r0,0x19
L_93938a:
	asl_s r1,r1,0x18
L_93938c:
	or_s r0,r0,r1
L_93938e:
	st.as r0,[gp,0x5e]
L_939392:
	mov_s r1,0x889480
L_939398:
	st_s r0,[r1,0x8]
L_93939a:
	bl L_93dbb0
L_93939e:
	ld_s r2,[sp,0x0]
L_9393a0:
	mov_s r14,0x8010d0
L_9393a6:
	extb_s r1,r2
L_9393a8:
	breq_s r0,0,L_9393de
L_9393aa:
	mov_s r0,0x0
L_9393ac:
	bl.d L_925698
L_9393b0:
	mov_s r2,0x1f
L_9393b2:
	bl.d L_9394d0
L_9393b6:
	ld_s r0,[sp,0x0]
L_9393b8:
	mov_s r0,0x857180
L_9393be:
	ld_s r1,[sp,0x0]
L_9393c0:
	add2_s r0,r0,r1
L_9393c2:
	ld_s r2,[r0,0x4]
L_9393c4:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_9393c6:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_9393c8:
	st_s r2,[r0,0x4]
L_9393ca:
	ldb_s r0,[r14,0x1c]
L_9393cc:
	add2_s r1,r1,r1
L_9393ce:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9393d0:
	extb_s r0,r0
L_9393d2:
	stb_s r0,[r14,0x1c]
L_9393d4:
	add_s r13,r13,r1
L_9393d6:
	ldw_s r0,[r13,0x2]
L_9393d8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9393da:
	stw_s r0,[r13,0x2]
L_9393dc:
	b_s L_93941c
	.global L_9393de
L_9393de:
	ldb_s r0,[r14,0x1d]
L_9393e0:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_9393e2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9393e4:
	extb_s r0,r0
L_9393e6:
	add2_s r2,r2,r2
L_9393e8:
	stb_s r0,[r14,0x1d]
L_9393ea:
	add_s r13,r13,r2
L_9393ec:
	ldb_s r0,[r13,0x8]
L_9393ee:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9393f0:
	stb_s r0,[r13,0x8]
L_9393f2:
	b_s L_939414
	.global L_9393f4
L_9393f4:
	asl_s r0,r1,0x2
L_9393f6:
	add2_s r0,r0,r0
L_9393f8:
	add_s r0,r0,0x857e38
L_9393fe:
	ldb_s r2,[r0,0x7]
L_939400:
	extb_s r1,r1
L_939402:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_939404:
	stb_s r2,[r0,0x7]
L_939406:
	mov_s r2,0x8010d0
L_93940c:
	ldb_s r0,[r2,0x1d]
L_93940e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_939410:
	extb_s r0,r0
L_939412:
	stb_s r0,[r2,0x1d]
	.global L_939414
L_939414:
	mov_s r0,0x1
L_939416:
	bl.d L_925698
L_93941a:
	mov_s r2,0x1f
	.global L_93941c
L_93941c:
	mov_s r0,0x0
L_93941e:
	bset_s r0,r0,0x1d
L_939420:
	mov_s r32,r0
L_939422:
	st.ab r0,[r25,0x4]
L_939426:
	bclr r25,r25,0xa
L_93942a:
	mov_s r0,0x801498
L_939430:
	ld_s r0,[r0,0x8]
L_939432:
	mov_s r3,0x8021b8
L_939438:
	bbit0 r0,0x9,L_939440
L_93943c:
	ldb_s r13,[r3,0xa]
L_93943e:
	b_s L_939442
	.global L_939440
L_939440:
	ldb_s r13,[r3,0x8]
	.global L_939442
L_939442:
	ld_s r0,[sp,0x0]
L_939444:
	asl_s r1,r0,0x2
L_939446:
	add2_s r1,r1,r1
L_939448:
	add_s r1,r1,0x857e38
L_93944e:
	ldb_s r2,[r1,0x7]
L_939450:
	brlt r2,r13,L_939478
L_939454:
	ld_s r2,[r3,0x20]
L_939456:
	bbit0 r2,0x4,L_939466
L_93945a:
	ldb_s r2,[r1,0x11]
L_93945c:
	bset_s r2,r2,0x5
L_93945e:
	stb_s r2,[r1,0x11]
L_939460:
	mov_s r2,0x0
L_939462:
	stb_s r2,[r1,0x7]
L_939464:
	stb_s r2,[r1,0x9]
	.global L_939466
L_939466:
	mov_s r3,0x857000
L_93946c:
	ld_s r2,[r3,0x4]
L_93946e:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_939470:
	st_s r2,[r3,0x4]
L_939472:
	ldb_s r2,[r1,0x6]
L_939474:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_939476:
	stb_s r2,[r1,0x6]
	.global L_939478
L_939478:
	bl.d L_928750
L_93947c:
	mov_s r1,0x0
	.global L_93947e
L_93947e:
	b.d L_9202a4
L_939482:
	add_s sp,sp,0x8
