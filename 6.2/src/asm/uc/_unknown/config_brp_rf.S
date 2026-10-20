/* config_brp_rf @ 0x925050, 1608 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HH config_brp_rf rf_id %d (0x%8x) sta_id = %d
 *   HH Overriding rfmodule%d phase = 0x%x etype_1 = 0x%x
 * Зовут его: brp_init__flow, brp_responder_flow_enter
 * Зовёт сам: __ld_r24_to_r13_ret, __st_r24_to_r13, brp__select_cfg_by_snr, brp__write_reg_pair, brp_rf__store_cfg, brp_rf__store_module_byte, popcount8, rfca__get_rf_mask_uc, rfca__select_rf_uc, uc_log__emit3, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global config_brp_rf
config_brp_rf:
	.global L_925050
L_925050:
	push_s blink
L_925052:
	bl L_92020c
L_925056:
	sub_s sp,sp,0x54
L_925058:
	st_s r0,[sp,0x10]
L_92505a:
	st_s r1,[sp,0x0]
L_92505c:
	mov_s r0,0x80066c
L_925062:
	st_s r0,[sp,0x18]
L_925064:
	mov_s r0,r1
L_925066:
	ld_s r1,[sp,0x18]
L_925068:
	mov r18,0x0
L_92506c:
	add_s r1,r1,r0
L_92506e:
	ldb_s r0,[r1,0xc]
L_925070:
	mov r23,0x801ff4
L_925078:
	lsr_s r0,r0,0x6
L_92507a:
	cmp_s r0,0x2
L_92507c:
	mov_s r0,0x1
L_92507e:
	sub_s.ne r0,r0,r0
L_925080:
	bl.d L_928c68
L_925084:
	st_s r0,[sp,0x4]
L_925086:
	st_s r0,[sp,0x8]
L_925088:
	ld_s r1,[sp,0x10]
L_92508a:
	mov_s r0,0x0
L_92508c:
	bset r0,r0,r1
L_925090:
	st_s r0,[sp,0x1c]
L_925092:
	extb_s r0,r0
L_925094:
	bl.d L_928b8c
L_925098:
	mov_s r1,r18
L_92509a:
	ld_s r2,[sp,0x10]
L_92509c:
	mov_s r1,0x100089c
L_9250a2:
	ld_s r3,[sp,0x1c]
L_9250a4:
	mov_s r0,0x20
L_9250a6:
	bl.d L_92d338
L_9250aa:
	ld r4,[sp]
L_9250ae:
	mov_s r0,0x80088c
L_9250b4:
	st_s r0,[sp,0x20]
L_9250b6:
	ldb r0,[r23]
L_9250ba:
	brhs.d r0,0x1,L_9250d0
L_9250be:
	stb r18,[r23, 0x2]
L_9250c2:
	mov_s r13,r18
L_9250c4:
	st_s r13,[sp,0x14]
L_9250c6:
	mov r24,r18
L_9250ca:
	mov r17,r18
L_9250ce:
	b_s L_925146
	.global L_9250d0
L_9250d0:
	mov_s r14,r18
L_9250d2:
	mov_s r13,r18
L_9250d4:
	st_s r13,[sp,0x14]
L_9250d6:
	mov r24,r18
L_9250da:
	mov r17,r18
	.global L_9250de
L_9250de:
	ld_s r0,[sp,0x20]
L_9250e0:
	ld_s r1,[sp,0x10]
L_9250e2:
	mov_s r15,0x801c94
L_9250e8:
	ld r4,[r0]
L_9250ec:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_9250ee:
	add1 r2,r1,r14
L_9250f2:
	add_s r2,r2,r15
L_9250f4:
	ldb_s r0,[r2,0x1]
L_9250f6:
	mov_s r3,0x0
L_9250f8:
	bset r3,r3,r0
L_9250fc:
	breq r4,0x0,L_9251d6
L_925100:
	ldb_s r1,[r15,r1]
L_925102:
	add_s r0,sp,0x40
L_925104:
	ldb.x r4,[r23, 0x1]
L_925108:
	ldb_s r2,[r2]
L_92510a:
	bl.d L_922d2c
L_92510e:
	ld r5,[sp, 0x4]
L_925112:
	ld_s r1,[sp,0x40]
L_925114:
	ld_s r2,[sp,0x44]
L_925116:
	or r17,r17,r1
L_92511a:
	ld_s r0,[sp,0x48]
L_92511c:
	ld_s r3,[sp,0x14]
L_92511e:
	or r24,r24,r2
L_925122:
	or_s r3,r3,r0
L_925124:
	or_s r1,r1,r2
L_925126:
	or.f r0,r0,r1
L_92512a:
	st_s r3,[sp,0x14]
L_92512c:
	or_s r13,r13,r0
L_92512e:
	beq_s L_92513c
	.global L_925130
L_925130:
	ldb r0,[r23, 0x2]
L_925134:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925136:
	extb_s r0,r0
L_925138:
	stb r0,[r23, 0x2]
	.global L_92513c
L_92513c:
	ldb r0,[r23]
L_925140:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_925142:
	brlo r14,r0,L_9250de
	.global L_925146
L_925146:
	ld_s r0,[sp,0x18]
L_925148:
	mov_s r1,r0
L_92514a:
	st_s r13,[r0,0x14]
L_92514c:
	ld_s r0,[r0,0x18]
L_92514e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925150:
	st_s r0,[r1,0x18]
L_925152:
	mov_s r0,0x857800
L_925158:
	st_s r0,[sp,0x24]
L_92515a:
	ld_s r0,[sp,0x10]
L_92515c:
	mov_s r1,0x85776c
L_925162:
	ld.as r0,[r1,r0]
L_925166:
	tst_s r0,r13
L_925168:
	beq_s L_9251da
	.global L_92516a
L_92516a:
	mov_s r0,0x0
L_92516c:
	st_s r0,[sp,0x28]
L_92516e:
	mov_s r0,0x800824
L_925174:
	st_s r0,[sp,0x2c]
L_925176:
	ld_s r0,[sp,0x28]
L_925178:
	st_s r0,[sp,0x30]
L_92517a:
	mov_s r2,r0
L_92517c:
	mov_s r1,r0
L_92517e:
	mov_s r16,r0
L_925180:
	b_s L_92518e
	.global L_925182
L_925182:
	ld_s r0,[sp,0x30]
L_925184:
	brge r0,r3,L_92518a
L_925188:
	st_s r3,[sp,0x30]
	.global L_92518a
L_92518a:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_92518c:
	/* add_s r2,0x3 */
	.byte 0x03,0xe2
	.global L_92518e
L_92518e:
	brhs r1,0x20,L_9251f6
L_925192:
	lsr r14,r1,0x2
L_925196:
	mov_s r3,0xf
L_925198:
	asl_s r3,r3,r1
L_92519a:
	tst_s r3,r13
L_92519c:
	add r0,sp,r14
L_9251a0:
	stb r18,[r0, 0x4c]
L_9251a4:
	beq_s L_92518a
L_9251a6:
	ld_s r3,[sp,0x28]
L_9251a8:
	bset r3,r3,r14
L_9251ac:
	extb_s r3,r3
L_9251ae:
	st_s r3,[sp,0x28]
L_9251b0:
	ld_s r3,[sp,0x20]
L_9251b2:
	ld_s r3,[r3]
L_9251b4:
	breq_s r3,0,L_9251e6
L_9251b6:
	add_s r3,r1,0x4
L_9251b8:
	cmp_s r1,r3
L_9251ba:
	mov_s r3,0x0
L_9251bc:
	bhs_s L_925182
L_9251be:
	mov_s r15,r1
	.global L_9251c0
L_9251c0:
	bbit0 r13,r15,L_9251cc
L_9251c4:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_9251c6:
	extb_s r3,r3
L_9251c8:
	stb r3,[r0, 0x4c]
	.global L_9251cc
L_9251cc:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_9251ce:
	add_s r14,r1,0x4
L_9251d0:
	brlo r15,r14,L_9251c0
L_9251d4:
	b_s L_925182
	.global L_9251d6
L_9251d6:
	or_s r13,r13,r3
L_9251d8:
	b_s L_925130
	.global L_9251da
L_9251da:
	mov_s r0,blink
L_9251dc:
	mov_s r1,0x5
L_9251de:
	bl.d L_926618
L_9251e2:
	asl_s r1,r1,0xa
L_9251e4:
	b_s L_92516a
	.global L_9251e6
L_9251e6:
	ld_s r0,[sp,0x2c]
L_9251e8:
	ld_s r0,[r0]
L_9251ea:
	lsr_s r0,r0,0x18
L_9251ec:
	bmsk_s r0,r0,0x2
L_9251ee:
	asl_s r0,r0,r2
L_9251f0:
	or r16,r16,r0
L_9251f4:
	b_s L_92518a
	.global L_9251f6
L_9251f6:
	ld_s r0,[sp,0x30]
L_9251f8:
	mov_s r14,0x0
L_9251fa:
	stb r0,[gp, -0xf3]
L_9251fe:
	ld_s r0,[sp,0x20]
L_925200:
	mov_s r19,r14
L_925202:
	ld_s r0,[r0]
L_925204:
	cmp_s r0,0x0
L_925206:
	mov.eq r20,r14
L_92520a:
	beq_s L_92536a
L_92520c:
	st_s r14,[sp,0x34]
L_92520e:
	st_s r14,[sp,0x38]
L_925210:
	mov_s r22,r14
L_925212:
	mov_s r20,r14
L_925214:
	b_s L_925220
	.global L_925216
L_925216:
	ld_s r0,[sp,0x34]
L_925218:
	add r19,r19,0x1
L_92521c:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_92521e:
	st_s r0,[sp,0x34]
	.global L_925220
L_925220:
	brhs r19,0x8,L_9252ac
L_925224:
	add r0,sp,r19
L_925228:
	ldb r0,[r0, 0x4c]
L_92522c:
	brlt.d r0,0x1,L_925254
L_925230:
	st_s r0,[sp,0x3c]
L_925232:
	brhs r19,0x4,L_925240
L_925236:
	add r20,r20,0x1
L_92523a:
	extb r20,r20
L_92523e:
	b_s L_925248
	.global L_925240
L_925240:
	add r22,r22,0x1
L_925244:
	extb r22,r22
	.global L_925248
L_925248:
	ld_s r0,[sp,0x20]
L_92524a:
	ld_s r1,[sp,0x34]
L_92524c:
	ldb_s r0,[r0,0x7]
L_92524e:
	asl_s r0,r0,r1
L_925250:
	or r16,r16,r0
	.global L_925254
L_925254:
	ld_s r0,[sp,0x30]
L_925256:
	ld_s r1,[sp,0x3c]
L_925258:
	mov_s r15,0x0
L_92525a:
	sub r21,r0,r1
L_92525e:
	extb r21,r21
	.global L_925262
L_925262:
	brlt r21,0x1,L_925216
L_925266:
	ld_s r0,[sp,0x3c]
L_925268:
	brlt r0,0x1,L_925216
L_92526c:
	add2 r0,r15,r19
L_925270:
	mov_s r1,0x0
L_925272:
	bset r1,r1,r0
L_925276:
	and r0,r1,r13
L_92527a:
	sub.f r0,r0,0x0
L_92527e:
	mov.ne r0,0x1
L_925282:
	extb.f 0x0,r0
L_925286:
	bne_s L_925296
L_925288:
	ld_s r0,[sp,0x38]
L_92528a:
	sub r21,r21,0x1
L_92528e:
	or_s r0,r0,r1
L_925290:
	st_s r0,[sp,0x38]
L_925292:
	extb r21,r21
	.global L_925296
L_925296:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_925298:
	cmp_s r15,0x4
L_92529a:
	mov.hi r0,blink
L_92529e:
	mov.hi r1,0x13fd
L_9252a6:
	bl.hi L_926618
L_9252aa:
	b_s L_925262
	.global L_9252ac
L_9252ac:
	ld_s r0,[sp,0x38]
L_9252ae:
	mov_s r1,0x801f94
L_9252b4:
	st_s r0,[r1,0x64]
L_9252b6:
	ld_s r0,[sp,0x14]
L_9252b8:
	ld_s r1,[sp,0x38]
L_9252ba:
	or r0,r0,r24
L_9252be:
	or r0,r0,r17
L_9252c2:
	tst_s r0,r1
L_9252c4:
	bne_s L_9252ea
	.global L_9252c6
L_9252c6:
	ld_s r0,[sp,0x38]
L_9252c8:
	brge.d r22,r20,L_925328
L_9252cc:
	or r17,r17,r0
L_9252d0:
	brlt r22,0x1,L_925316
L_9252d4:
	mov_s r15,0x0
L_9252d6:
	sub r19,r20,r22
L_9252da:
	ld_s r0,[sp,0x28]
L_9252dc:
	extb r19,r19
L_9252e0:
	bic r0,r0,-0xf1
L_9252e4:
	asr r21,r0,0x4
L_9252e8:
	b_s L_925312
	.global L_9252ea
L_9252ea:
	mov_s r0,blink
L_9252ec:
	mov_s r1,0x13fc
L_9252f2:
	bl L_926618
L_9252f6:
	b_s L_9252c6
	.global L_9252f8
L_9252f8:
	bbit1 r21,r15,L_92530c
L_9252fc:
	add_s r0,r15,0x4
L_9252fe:
	bset r14,r14,r0
L_925302:
	extb_s r14,r14
L_925304:
	sub r19,r19,0x1
L_925308:
	extb r19,r19
	.global L_92530c
L_92530c:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_92530e:
	brhs r15,0x5,L_92531a
	.global L_925312
L_925312:
	brge r19,0x1,L_9252f8
	.global L_925316
L_925316:
	mov_s r19,r14
L_925318:
	b_s L_92536a
	.global L_92531a
L_92531a:
	mov_s r0,blink
L_92531c:
	mov_s r1,0x13fe
L_925322:
	bl L_926618
L_925326:
	b_s L_925312
	.global L_925328
L_925328:
	brge r20,r22,L_925364
L_92532c:
	brlt r20,0x1,L_925364
L_925330:
	mov_s r15,0x0
L_925332:
	sub r19,r22,r20
L_925336:
	extb r19,r19
L_92533a:
	ld_s r0,[sp,0x28]
L_92533c:
	bmsk r20,r0,0x3
L_925340:
	b_s L_925360
	.global L_925342
L_925342:
	mov_s r0,0x0
L_925344:
	bset r0,r0,r15
L_925348:
	tst r20,r0
L_92534c:
	bne_s L_92535a
L_92534e:
	or_s r0,r0,r14
L_925350:
	extb_s r14,r0
L_925352:
	sub r19,r19,0x1
L_925356:
	extb r19,r19
	.global L_92535a
L_92535a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_92535c:
	brhs r15,0x5,L_9253c8
	.global L_925360
L_925360:
	brge r19,0x1,L_925342
	.global L_925364
L_925364:
	mov_s r19,r14
L_925366:
	mov r20,r22
	.global L_92536a
L_92536a:
	stb r20,[gp, -0xf4]
L_92536e:
	mov_s r14,0x0
L_925370:
	mov_s r15,r14
L_925372:
	b_s L_925398
	.global L_925374
L_925374:
	bbit0 r19,r14,L_925394
L_925378:
	mov_s r0,0x7
L_92537a:
	asl_s r0,r0,r15
L_92537c:
	tst r0,r16
L_925380:
	mov.ne r0,blink
L_925384:
	mov.ne r1,0x13fb
L_92538c:
	bl.ne L_926618
L_925390:
	bset r16,r16,r15
	.global L_925394
L_925394:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_925396:
	/* add_s r15,0x3 */
	.byte 0x03,0xe7
	.global L_925398
L_925398:
	brlo r14,0x8,L_925374
L_92539c:
	extw_s r1,r13
L_92539e:
	cmp_s r1,0x0
L_9253a0:
	bset r0,r16,0x1c
L_9253a4:
	mov.eq r0,r16
L_9253a8:
	and r2,r13,0xffff0000
L_9253b0:
	cmp_s r2,0x0
L_9253b2:
	bset r1,r0,0x1d
L_9253b6:
	mov.ne r15,r1
L_9253ba:
	mov.eq r15,r0
L_9253be:
	ld_s r0,[sp,0x20]
L_9253c0:
	ld_s r0,[r0]
L_9253c2:
	breq_s r0,0,L_9253d6
L_9253c4:
	ld_s r13,[sp,0x14]
L_9253c6:
	b_s L_9253fa
	.global L_9253c8
L_9253c8:
	mov_s r0,blink
L_9253ca:
	mov_s r1,0x13ff
L_9253d0:
	bl L_926618
L_9253d4:
	b_s L_925360
	.global L_9253d6
L_9253d6:
	ld_s r0,[sp,0x2c]
L_9253d8:
	ld_s r1,[r0]
L_9253da:
	lsr r0,r1,0x15
L_9253de:
	bmsk_s r0,r0,0x2
L_9253e0:
	btst_s r1,0x15
L_9253e2:
	mov.ne r17,r13
L_9253e6:
	mov.eq r17,0x0
L_9253ea:
	btst_s r0,0x1
L_9253ec:
	mov.ne r24,r13
L_9253f0:
	mov.eq r24,0x0
L_9253f4:
	btst_s r0,0x2
L_9253f6:
	mov.eq r13,0x0
	.global L_9253fa
L_9253fa:
	ld_s r0,[sp,0x18]
L_9253fc:
	ld_s r0,[r0,0x4]
L_9253fe:
	breq_s r0,0,L_92540c
L_925400:
	ld_s r0,[sp,0x10]
L_925402:
	ld_s r1,[sp,0x0]
L_925404:
	bl.d L_9213d0
L_925408:
	ldb r2,[r23, 0x2]
	.global L_92540c
L_92540c:
	ld_s r0,[sp,0x18]
L_92540e:
	ld_s r0,[r0,0x4]
L_925410:
	breq_s r0,0,L_925418
L_925412:
	bl.d L_9213c0
L_925416:
	ld_s r0,[sp,0x0]
	.global L_925418
L_925418:
	ld_s r0,[sp,0x18]
L_92541a:
	ld_s r14,[sp,0x2c]
L_92541c:
	ldb_s r1,[r0,0x9]
L_92541e:
	ld_s r0,[sp,0x1c]
L_925420:
	tst_s r1,r0
L_925422:
	ld_s r0,[sp,0x10]
L_925424:
	add3_s r14,r14,r0
L_925426:
	bne_s L_925438
L_925428:
	st r18,[r14, 0x8]
L_92542c:
	st r18,[r14, 0xc]
L_925430:
	mov_s r15,0x0
L_925432:
	mov_s r13,r15
L_925434:
	mov_s r24,r15
L_925436:
	mov_s r17,r15
	.global L_925438
L_925438:
	ld_s r0,[sp,0x24]
L_92543a:
	ldb r0,[r0, -0x4b]
L_92543e:
	mov r16,0xc0
L_925442:
	brne_s r0,0,L_925496
L_925444:
	mov_s r0,0x8006b4
L_92544a:
	bl.d L_92828c
L_92544e:
	ldb_s r0,[r0,0x4]
L_925450:
	brge.d r0,0x2,L_925496
L_925454:
	ld_s r1,[r14,0x8]
L_925456:
	ld_s r2,[sp,0x0]
L_925458:
	mov_s r0,0x80110c
L_92545e:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_925460:
	add2_s r2,r2,r2
L_925462:
	ld_s r0,[r0,r2]
L_925464:
	lsr_s r0,r0,0x8
L_925466:
	extb_s r0,r0
L_925468:
	mul64 r0,r16
L_92546c:
	add r0,mlo,0x8020
L_925474:
	mov r18,mlo
L_925478:
	lsr_s r0,r0,0x3
L_92547a:
	bl.d L_92f9d8
L_92547e:
	bic r0,r0,0x3
L_925482:
	add r0,r18,0x8000
L_92548a:
	lsr_s r0,r0,0x3
L_92548c:
	bic r0,r0,0x3
L_925490:
	bl.d L_92f9d8
L_925494:
	ld_s r1,[r14,0xc]
	.global L_925496
L_925496:
	ldb_s r0,[sp,0x0]
L_925498:
	add_s r0,r0,0x60
L_92549a:
	extb_s r0,r0
L_92549c:
	mul64 r0,r16
L_9254a0:
	add r0,mlo,0x10020
L_9254a8:
	lsr_s r0,r0,0x3
L_9254aa:
	mov r18,mlo
L_9254ae:
	bic r0,r0,0x3
L_9254b2:
	bl.d L_92f9d8
L_9254b6:
	ld_s r1,[r14,0x8]
L_9254b8:
	add r0,r18,0x10000
L_9254c0:
	lsr_s r0,r0,0x3
L_9254c2:
	bic r0,r0,0x3
L_9254c6:
	bl.d L_92f9d8
L_9254ca:
	ld_s r1,[r14,0xc]
L_9254cc:
	ld_s r0,[sp,0x10]
L_9254ce:
	ld_s r1,[r14,0x8]
L_9254d0:
	mul64 r0,0xe0
L_9254d4:
	ld_s r2,[sp,0x0]
L_9254d6:
	mov_s r0,mlo
L_9254d8:
	mul64 r2,0x1c
L_9254dc:
	add_s r0,r0,mlo
L_9254de:
	add r16,r0,0x8008c0
L_9254e6:
	ld_s r0,[r14,0xc]
L_9254e8:
	st r1,[r16]
L_9254ec:
	st r0,[r16, 0x4]
L_9254f0:
	add r0,r18,0x10060
L_9254f8:
	lsr_s r0,r0,0x3
L_9254fa:
	bic r0,r0,0x3
L_9254fe:
	bl.d L_92f9d8
L_925502:
	mov_s r1,r17
L_925504:
	st r17,[r16, 0x8]
L_925508:
	add r0,r18,0x10040
L_925510:
	lsr_s r0,r0,0x3
L_925512:
	bic r0,r0,0x3
L_925516:
	bl.d L_92f9d8
L_92551a:
	mov_s r1,r24
L_92551c:
	st r24,[r16, 0xc]
L_925520:
	add r0,r18,0x100a0
L_925528:
	lsr_s r0,r0,0x3
L_92552a:
	bic r0,r0,0x3
L_92552e:
	bl.d L_92f9d8
L_925532:
	mov_s r1,r13
L_925534:
	st r13,[r16, 0x10]
L_925538:
	add r0,r18,0x10080
L_925540:
	lsr_s r0,r0,0x3
L_925542:
	bic r0,r0,0x3
L_925546:
	bl.d L_92f9d8
L_92554a:
	mov_s r1,r15
L_92554c:
	ld_s r0,[gp,-0x44]
L_92554e:
	st r15,[r16, 0x14]
L_925552:
	and r0,r0,0xfff0ffff
L_92555a:
	bset r1,r0,0x10
L_92555e:
	bset_s r1,r1,0x11
L_925560:
	st.as r1,[gp,-0x11]
L_925564:
	or r0,r0,0x1d030000
L_92556c:
	mov_s r32,r0
L_92556e:
	st.ab r0,[r25,0x4]
L_925572:
	bclr r25,r25,0xa
L_925576:
	nop_s
L_925578:
	nop_s
L_92557a:
	nop_s
	.global L_92557c
L_92557c:
	mov_s r0,r47
L_92557e:
	bbit1 r0,0x11,L_92557c
L_925582:
	mov_s r3,0x80066c
L_925588:
	ld_s r0,[r3]
L_92558a:
	cmp_s r0,0x0
L_92558c:
	beq_s L_92568a
L_92558e:
	ldb_s r13,[r3,0x8]
L_925590:
	mov_s r2,0xfbf1fbf5
L_925596:
	mov_s r14,0xe40c2275
L_92559c:
	ld_s r3,[sp,0x10]
L_92559e:
	mov_s r0,0x30ffffff
L_9255a4:
	mov_s r1,0xb1cca053
L_9255aa:
	mov_s r15,0x0
L_9255ac:
	brne r3,r13,L_9255ba
L_9255b0:
	st_s r2,[sp,0xc]
L_9255b2:
	mov_s r16,r1
L_9255b4:
	mov_s r17,r0
L_9255b6:
	mov_s r15,r2
L_9255b8:
	b_s L_9255c2
	.global L_9255ba
L_9255ba:
	st_s r15,[sp,0xc]
L_9255bc:
	mov_s r14,r15
L_9255be:
	mov_s r16,r15
L_9255c0:
	mov_s r17,r15
	.global L_9255c2
L_9255c2:
	mov_s r1,0x10008cc
L_9255c8:
	mov_s r0,0x20
L_9255ca:
	ld_s r2,[sp,0x10]
L_9255cc:
	mov_s r3,r14
L_9255ce:
	bl.d L_92d338
L_9255d2:
	ld r4,[sp, 0xc]
L_9255d6:
	ldb_s r13,[sp,0x0]
L_9255d8:
	add_s r13,r13,0x60
L_9255da:
	extb_s r13,r13
L_9255dc:
	/* asl_s r13,r13,0x6 */
	.byte 0x06,0xbd
L_9255de:
	add1_s r13,r13,r13
L_9255e0:
	add r0,r13,0x10060
L_9255e8:
	lsr_s r0,r0,0x3
L_9255ea:
	bic r0,r0,0x3
L_9255ee:
	bl.d L_92f9d8
L_9255f2:
	mov_s r1,0x0
L_9255f4:
	add r0,r13,0x10040
L_9255fc:
	lsr_s r0,r0,0x3
L_9255fe:
	bic r0,r0,0x3
L_925602:
	bl.d L_92f9d8
L_925606:
	ld_s r1,[sp,0xc]
L_925608:
	add r0,r13,0x100a0
L_925610:
	lsr_s r0,r0,0x3
L_925612:
	bic r0,r0,0x3
L_925616:
	bl.d L_92f9d8
L_92561a:
	mov_s r1,r15
L_92561c:
	add r0,r13,0x10000
L_925624:
	lsr_s r0,r0,0x3
L_925626:
	bic r0,r0,0x3
L_92562a:
	bl.d L_92f9d8
L_92562e:
	mov_s r1,r14
L_925630:
	add r0,r13,0x10020
L_925638:
	lsr_s r0,r0,0x3
L_92563a:
	bic r0,r0,0x3
L_92563e:
	bl.d L_92f9d8
L_925642:
	mov_s r1,r16
L_925644:
	add r0,r13,0x10080
L_92564c:
	lsr_s r0,r0,0x3
L_92564e:
	bic r0,r0,0x3
L_925652:
	bl.d L_92f9d8
L_925656:
	mov_s r1,r17
L_925658:
	ld_s r0,[gp,-0x44]
L_92565a:
	and r0,r0,0xfff0ffff
L_925662:
	bset r1,r0,0x10
L_925666:
	bset_s r1,r1,0x11
L_925668:
	or r0,r0,0x1d030000
L_925670:
	st.as r1,[gp,-0x11]
L_925674:
	mov_s r32,r0
L_925676:
	st.ab r0,[r25,0x4]
L_92567a:
	bclr r25,r25,0xa
L_92567e:
	nop_s
L_925680:
	nop_s
L_925682:
	nop_s
	.global L_925684
L_925684:
	mov_s r0,r47
L_925686:
	bbit1 r0,0x11,L_925684
	.global L_92568a
L_92568a:
	ld_s r0,[sp,0x8]
L_92568c:
	bl.d L_928b8c
L_925690:
	mov_s r1,0x0
L_925692:
	b.d L_920254
L_925696:
	add_s sp,sp,0x54
