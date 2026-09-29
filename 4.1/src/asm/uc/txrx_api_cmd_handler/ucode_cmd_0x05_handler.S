/* ucode_cmd_0x05_handler @ 0x935208, 412 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r19_to_r13_ret_uc, __st_r19_to_r13_uc, bf_sm__clear_sta, bf_w_s0_w4_uc, bf_w_s4_w4_uc, bf_w_s8_w15_uc, memset0_words_uc, shallow_sleep_step
 */
	.section .text.ucode_cmd_0x05_handler,"ax",@progbits
	.global ucode_cmd_0x05_handler
ucode_cmd_0x05_handler:
	.global L_935208
L_935208:
	push_s blink
L_93520a:
	bl L_920200
L_93520e:
	mov_s r14,r0
L_935210:
	ld_s r1,[r0,0xc]
L_935212:
	mov_s r13,0x801190
L_935218:
	ldb_s r0,[r0,0x8]
L_93521a:
	add r17,r13,0x30
L_93521e:
	add r16,r13,0x2e
L_935222:
	add r19,r13,0x2c
L_935226:
	add r18,r13,0x24
L_93522a:
	add r15,r13,0xc
L_93522e:
	brne r1,0x0,L_9352d4
L_935232:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_935234:
	add3_s r0,r0,r0
L_935236:
	add_s r0,r0,r13
L_935238:
	bl.d L_92166c
L_93523c:
	mov_s r1,0x48
L_93523e:
	ldb_s r1,[r14,0x8]
L_935240:
	add r3,r14,0x20
L_935244:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_935246:
	add3_s r1,r1,r1
L_935248:
	add_s r1,r1,r13
L_93524a:
	ldw_s r0,[r1,0x2]
L_93524c:
	bset_s r0,r0,0x1
L_93524e:
	stw_s r0,[r1,0x2]
L_935250:
	ldb_s r1,[r14,0x8]
L_935252:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_935254:
	add3_s r1,r1,r1
L_935256:
	add_s r1,r1,r13
L_935258:
	ldw_s r0,[r1,0x2]
L_93525a:
	bset_s r0,r0,0x0
L_93525c:
	stw_s r0,[r1,0x2]
L_93525e:
	ldb_s r0,[r14,0x8]
L_935260:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_935262:
	add3_s r0,r0,r0
L_935264:
	ldw_s r1,[r14,0xa]
L_935266:
	add_s r15,r15,r0
L_935268:
	st_s r1,[r15]
L_93526a:
	ldb_s r0,[r14,0x8]
L_93526c:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_93526e:
	add3_s r0,r0,r0
L_935270:
	ld_s r1,[r14,0x10]
L_935272:
	add_s r0,r0,r18
L_935274:
	st_s r1,[r0]
L_935276:
	ldb_s r0,[r14,0x8]
L_935278:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_93527a:
	add3_s r0,r0,r0
L_93527c:
	ldw_s r1,[r14,0x18]
L_93527e:
	add_s r0,r0,r19
L_935280:
	stw_s r1,[r0]
L_935282:
	ldb_s r0,[r14,0x8]
L_935284:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_935286:
	add3_s r0,r0,r0
L_935288:
	ldw_s r1,[r14,0x1a]
L_93528a:
	add_s r0,r0,r16
L_93528c:
	stw_s r1,[r0]
L_93528e:
	ldb_s r0,[r14,0x8]
L_935290:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_935292:
	add3_s r0,r0,r0
L_935294:
	ldw_s r1,[r14,0x1c]
L_935296:
	add_s r0,r0,r17
L_935298:
	stw_s r1,[r0]
L_93529a:
	ldb_s r2,[r14,0x8]
L_93529c:
	mov_s r0,0x8011d6
L_9352a2:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_9352a4:
	sub_s r15,r0,0x2
L_9352a6:
	add3_s r2,r2,r2
L_9352a8:
	ldb_s r1,[r3]
L_9352aa:
	add_s r15,r15,r2
L_9352ac:
	stb_s r1,[r15]
L_9352ae:
	ldb_s r2,[r14,0x8]
L_9352b0:
	sub_s r15,r0,0x1
L_9352b2:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_9352b4:
	ldb_s r1,[r3,0x1]
L_9352b6:
	add3_s r2,r2,r2
L_9352b8:
	add_s r15,r15,r2
L_9352ba:
	stb_s r1,[r15]
L_9352bc:
	ldb_s r2,[r14,0x8]
L_9352be:
	ldb_s r1,[r3,0x2]
L_9352c0:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_9352c2:
	add3_s r2,r2,r2
L_9352c4:
	add_s r0,r0,r2
L_9352c6:
	stb_s r1,[r0]
L_9352c8:
	ldb_s r0,[r14,0x8]
L_9352ca:
	mov_s r1,0x5
L_9352cc:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9352ce:
	add3_s r0,r0,r0
L_9352d0:
	add_s r0,r0,r13
L_9352d2:
	stw_s r1,[r0]
	.global L_9352d4
L_9352d4:
	ldw_s r1,[r14,0x2]
L_9352d6:
	ldb_s r2,[r14,0x8]
L_9352d8:
	bmsk_s r1,r1,0xe
L_9352da:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_9352dc:
	add3_s r2,r2,r2
L_9352de:
	add_s r2,r2,r13
L_9352e0:
	add r0,r2,0x8
L_9352e4:
	bl L_9379f4
L_9352e8:
	ldb_s r1,[r14]
L_9352ea:
	ldb_s r2,[r14,0x8]
L_9352ec:
	bmsk_s r1,r1,0x3
L_9352ee:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_9352f0:
	add3_s r2,r2,r2
L_9352f2:
	add_s r2,r2,r13
L_9352f4:
	add r0,r2,0x8
L_9352f8:
	bl L_937988
L_9352fc:
	ldb_s r0,[r14,0x8]
L_9352fe:
	mov_s r1,0x3
L_935300:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_935302:
	add3_s r0,r0,r0
L_935304:
	add_s r2,r13,r0
L_935306:
	add r0,r2,0x8
L_93530a:
	bl L_9379d0
L_93530e:
	ldw_s r1,[r14,0x6]
L_935310:
	ldb_s r2,[r14,0x8]
L_935312:
	bmsk_s r1,r1,0xe
L_935314:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_935316:
	add3_s r2,r2,r2
L_935318:
	add_s r2,r2,r13
L_93531a:
	add_s r0,r2,0x4
L_93531c:
	bl L_9379f4
L_935320:
	ldb_s r1,[r14,0x4]
L_935322:
	ldb_s r2,[r14,0x8]
L_935324:
	bmsk_s r1,r1,0x3
L_935326:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_935328:
	add3_s r2,r2,r2
L_93532a:
	add_s r2,r2,r13
L_93532c:
	add_s r0,r2,0x4
L_93532e:
	bl L_937988
L_935332:
	ldb_s r2,[r14,0x8]
L_935334:
	mov_s r1,0x2
L_935336:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_935338:
	add3_s r2,r2,r2
L_93533a:
	add_s r2,r2,r13
L_93533c:
	add_s r0,r2,0x4
L_93533e:
	bl L_9379d0
L_935342:
	ld_s r0,[r14,0xc]
L_935344:
	brne r0,0x1,L_9353a0
L_935348:
	ldb_s r0,[r14,0x8]
L_93534a:
	mov_s r2,0x80090c
L_935350:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_935352:
	add3_s r0,r0,r0
L_935354:
	add_s r13,r13,r0
L_935356:
	ldw_s r0,[r13,0x2]
L_935358:
	mov_s r1,0x0
L_93535a:
	bclr_s r0,r0,0x0
L_93535c:
	stw_s r0,[r13,0x2]
L_93535e:
	ldb_s r0,[r2,0x11]
L_935360:
	ldb_s r3,[r14,0x8]
L_935362:
	bclr r0,r0,r3
L_935366:
	stb_s r0,[r2,0x11]
L_935368:
	ldb_s r2,[r14,0x8]
L_93536a:
	add r0,r2,0x80064c
L_935372:
	stb_s r1,[r0]
L_935374:
	lr r13,[0xa]
L_935378:
	bclr r0,r13,0x1
L_93537c:
	flag r0
L_935380:
	bl.d L_9229c4
L_935384:
	ldb_s r0,[r14,0x8]
L_935386:
	mov_s r0,0x801ed0
L_93538c:
	bl.d L_937304
L_935390:
	ldb_s r1,[r14,0x8]
L_935392:
	lr r0,[0xa]
L_935396:
	bic r13,r13,-0x3
L_93539a:
	or_s r0,r0,r13
L_93539c:
	flag r0
	.global L_9353a0
L_9353a0:
	b L_92025c
