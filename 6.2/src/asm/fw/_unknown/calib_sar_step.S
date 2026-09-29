/* calib_sar_step @ 0x8d6134, 636 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_sar_alg
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, fw_ashr64, hwd_abif__rx_rgf_sar_dc_load, hwd_abif__rx_rgf_update_sar_dc, hwd_phy__read_sar_sample, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_sar_step
calib_sar_step:
	.global L_8d6134
L_8d6134:
	push_s blink
L_8d6136:
	bl L_8c01b8
L_8d613a:
	st.a r0,[sp,-0xb8]
L_8d613e:
	st_s r2,[sp,0x4]
L_8d6140:
	st_s r3,[sp,0x8]
L_8d6142:
	sub r16,r0,r1
L_8d6146:
	extb r16,r16
L_8d614a:
	mov r18,0x0
L_8d614e:
	mov r24,r18
L_8d6152:
	mov r23,r18
L_8d6156:
	mov_s r0,0x803800
L_8d615c:
	ld_s r2,[r0]
L_8d615e:
	ld_s r1,[r0,0x4]
L_8d6160:
	st_s r2,[sp,0x28]
L_8d6162:
	st_s r1,[sp,0x2c]
L_8d6164:
	ld_s r1,[r0,0x8]
L_8d6166:
	ld_s r0,[r0,0xc]
L_8d6168:
	st_s r1,[sp,0x30]
L_8d616a:
	st_s r0,[sp,0x34]
L_8d616c:
	mov_s r15,r18
L_8d616e:
	mov_s r25,r15
L_8d6170:
	st r18,[sp, 0xc]
L_8d6174:
	b_s L_8d6194
	.global L_8d6176
L_8d6176:
	add.f r0,r20,0x4
L_8d617a:
	adc r1,r14,0x0
L_8d617e:
	bl.d L_8c0620
L_8d6182:
	mov_s r2,0x3
L_8d6184:
	mov_s r2,r0
L_8d6186:
	mov_s r0,r1
	.global L_8d6188
L_8d6188:
	add.f r24,r24,r2
L_8d618c:
	adc r23,r23,r0
	.global L_8d6190
L_8d6190:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d6192:
	extb_s r15,r15
	.global L_8d6194
L_8d6194:
	cmp_s r15,0x8
L_8d6196:
	bge L_8d62a0
L_8d619a:
	ld_s r0,[sp,0x0]
L_8d619c:
	add_s r13,sp,0x18
L_8d619e:
	add r17,r0,0x1
L_8d61a2:
	mov_s r0,0x853820
L_8d61a8:
	st_s r0,[sp,0x10]
L_8d61aa:
	mov_s r0,r15
L_8d61ac:
	bl.d L_8d2474
L_8d61b0:
	mov_s r1,r13
L_8d61b2:
	asl_s r0,r15,0x4
L_8d61b4:
	add_s r0,r0,sp
L_8d61b6:
	add_s r0,r0,0x38
L_8d61b8:
	mov_s r1,r13
L_8d61ba:
	bl.d L_8c0380
L_8d61be:
	mov_s r2,0x10
L_8d61c0:
	ld_s r13,[sp,0x1c]
L_8d61c2:
	mov_s r0,0x0
L_8d61c4:
	ld_s r1,[sp,0x0]
L_8d61c6:
	ld r22,[sp, 0x18]
L_8d61ca:
	bset r0,r0,r1
L_8d61ce:
	ld r20,[sp, 0x20]
L_8d61d2:
	ld_s r14,[sp,0x24]
L_8d61d4:
	mov_s r21,r0
L_8d61d6:
	brlt.d r13,0x0,L_8d61f0
L_8d61da:
	asr r19,r0,0x1f
L_8d61de:
	add.f r0,r21,r22
L_8d61e2:
	adc r1,r19,r13
L_8d61e6:
	bl.d L_8c0620
L_8d61ea:
	mov_s r2,r17
L_8d61ec:
	sexb_s r0,r0
L_8d61ee:
	b_s L_8d6204
	.global L_8d61f0
L_8d61f0:
	sub.f r0,r21,r22
L_8d61f4:
	sbc r1,r19,r13
L_8d61f8:
	bl.d L_8c0620
L_8d61fc:
	mov_s r2,r17
L_8d61fe:
	rsub r2,r0,0x0
L_8d6202:
	sexb_s r0,r2
	.global L_8d6204
L_8d6204:
	ld_s r1,[sp,0x10]
L_8d6206:
	add_s r1,r1,r15
L_8d6208:
	st_s r1,[sp,0x14]
L_8d620a:
	brlt.d r14,0x0,L_8d6222
L_8d620e:
	stb_s r0,[r1,0x10]
L_8d6210:
	add.f r0,r21,r20
L_8d6214:
	adc r1,r19,r14
L_8d6218:
	bl.d L_8c0620
L_8d621c:
	mov_s r2,r17
L_8d621e:
	sexb_s r0,r0
L_8d6220:
	b_s L_8d6236
	.global L_8d6222
L_8d6222:
	sub.f r0,r21,r20
L_8d6226:
	sbc r1,r19,r14
L_8d622a:
	bl.d L_8c0620
L_8d622e:
	mov_s r2,r17
L_8d6230:
	rsub r2,r0,0x0
L_8d6234:
	sexb_s r0,r2
	.global L_8d6236
L_8d6236:
	ld_s r1,[sp,0x14]
L_8d6238:
	stb_s r0,[r1,0x18]
L_8d623a:
	ld_s r0,[sp,0x4]
L_8d623c:
	breq r0,0x0,L_8d6190
L_8d6240:
	brlt r13,0x0,L_8d6258
L_8d6244:
	add.f r0,r22,0x4
L_8d6248:
	adc r1,r13,0x0
L_8d624c:
	bl.d L_8c0620
L_8d6250:
	mov_s r2,0x3
L_8d6252:
	mov_s r2,r0
L_8d6254:
	mov_s r13,r1
L_8d6256:
	b_s L_8d6272
	.global L_8d6258
L_8d6258:
	rsub.f r0,r22,0x4
L_8d625c:
	mov_s r1,0x0
L_8d625e:
	sbc r1,r1,r13
L_8d6262:
	bl.d L_8c0620
L_8d6266:
	mov_s r2,0x3
L_8d6268:
	rsub.f r2,r0,0x0
L_8d626c:
	mov_s r13,0x0
L_8d626e:
	sbc r13,r13,r1
	.global L_8d6272
L_8d6272:
	ld_s r0,[sp,0xc]
L_8d6274:
	add.f r25,r25,r2
L_8d6278:
	adc r0,r0,r13
L_8d627c:
	cmp_s r14,0x0
L_8d627e:
	bge.d L_8d6176
L_8d6282:
	st_s r0,[sp,0xc]
L_8d6284:
	rsub.f r0,r20,0x4
L_8d6288:
	mov_s r1,0x0
L_8d628a:
	sbc r1,r1,r14
L_8d628e:
	bl.d L_8c0620
L_8d6292:
	mov_s r2,0x3
L_8d6294:
	rsub.f r2,r0,0x0
L_8d6298:
	mov_s r0,0x0
L_8d629a:
	sbc r0,r0,r1
L_8d629e:
	b_s L_8d6188
	.global L_8d62a0
L_8d62a0:
	mov_s r13,0x0
L_8d62a2:
	b_s L_8d62c6
	.global L_8d62a4
L_8d62a4:
	add.f r0,r15,r14
L_8d62a8:
	adc r1,r1,r17
L_8d62ac:
	bl.d L_8c0620
L_8d62b0:
	mov_s r2,r16
L_8d62b2:
	sexb_s r0,r0
	.global L_8d62b4
L_8d62b4:
	stb r0,[r19, 0x30]
L_8d62b8:
	abs_s r0,r0
L_8d62ba:
	max r0,r0,r18
L_8d62be:
	extb r18,r0
L_8d62c2:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d62c4:
	extb_s r13,r13
	.global L_8d62c6
L_8d62c6:
	brge r13,0x8,L_8d6360
L_8d62ca:
	asl_s r15,r13,0x4
L_8d62cc:
	add_s r15,r15,sp
L_8d62ce:
	ld_s r0,[r15,0x38]
L_8d62d0:
	ld r4,[r15, 0x3c]
L_8d62d4:
	ld_s r1,[sp,0xc]
L_8d62d6:
	sub.f r5,r25,r0
L_8d62da:
	sub r2,r16,0x1
L_8d62de:
	sbc.f r1,r1,r4
L_8d62e2:
	mov_s r14,0x0
L_8d62e4:
	bset r14,r14,r2
L_8d62e8:
	bmi.d L_8d6302
L_8d62ec:
	asr r17,r14,0x1f
L_8d62f0:
	add.f r0,r14,r5
L_8d62f4:
	adc r1,r1,r17
L_8d62f8:
	bl.d L_8c0620
L_8d62fc:
	mov_s r2,r16
L_8d62fe:
	sexb_s r0,r0
L_8d6300:
	b_s L_8d6320
	.global L_8d6302
L_8d6302:
	ld_s r2,[sp,0xc]
L_8d6304:
	sub.f r0,r0,r25
L_8d6308:
	sbc r1,r4,r2
L_8d630c:
	add.f r0,r0,r14
L_8d6310:
	adc r1,r1,r17
L_8d6314:
	bl.d L_8c0620
L_8d6318:
	mov_s r2,r16
L_8d631a:
	rsub r2,r0,0x0
L_8d631e:
	sexb_s r0,r2
	.global L_8d6320
L_8d6320:
	add r19,sp,r13
L_8d6324:
	stb r0,[r19, 0x28]
L_8d6328:
	abs_s r0,r0
L_8d632a:
	max r0,r0,r18
L_8d632e:
	extb r18,r0
L_8d6332:
	ld_s r0,[r15,0x44]
L_8d6334:
	ld_s r2,[r15,0x40]
L_8d6336:
	sub.f r15,r24,r2
L_8d633a:
	sbc.f r1,r23,r0
L_8d633e:
	bpl L_8d62a4
L_8d6342:
	sub.f r2,r2,r24
L_8d6346:
	sbc r1,r0,r23
L_8d634a:
	add.f r0,r2,r14
L_8d634e:
	adc r1,r1,r17
L_8d6352:
	bl.d L_8c0620
L_8d6356:
	mov_s r2,r16
L_8d6358:
	rsub r2,r0,0x0
L_8d635c:
	sexb_s r0,r2
L_8d635e:
	b_s L_8d62b4
	.global L_8d6360
L_8d6360:
	ld_s r1,[sp,0x8]
L_8d6362:
	asl r0,r18
L_8d6366:
	cmp_s r1,r0
L_8d6368:
	mov.lt r15,0x0
L_8d636c:
	blt_s L_8d6372
L_8d636e:
	nop_s
L_8d6370:
	mov_s r15,0x1
	.global L_8d6372
L_8d6372:
	brne_s r15,0,L_8d63a2
L_8d6374:
	mov_s r14,0x0
L_8d6376:
	mov_s r13,0x8
	.global L_8d6378
L_8d6378:
	add r2,sp,r14
L_8d637c:
	mov_s r0,r14
L_8d637e:
	mov_s r1,0x0
L_8d6380:
	bl.d L_8cefdc
L_8d6384:
	ldb.x r2,[r2, 0x28]
L_8d6388:
	add r2,sp,r14
L_8d638c:
	ldb.x r2,[r2, 0x30]
L_8d6390:
	mov_s r0,r14
L_8d6392:
	bl.d L_8cefdc
L_8d6396:
	mov_s r1,0x1
L_8d6398:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d639a:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d639c:
	brhs.d r13,0x1,L_8d6378
L_8d63a0:
	extb_s r14,r14
	.global L_8d63a2
L_8d63a2:
	bl L_8cefc8
L_8d63a6:
	mov_s r0,r15
L_8d63a8:
	b.d L_8c01fc
L_8d63ac:
	add sp,sp,0xb8
