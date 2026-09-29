/* marlon_r_if_class__config_brp_sectors @ 0x8e32b4, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: marlon_r_if__read_step
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, hwd_abif__dvs_rfca_cmd_enable, rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global marlon_r_if_class__config_brp_sectors
marlon_r_if_class__config_brp_sectors:
	.global L_8e32b4
L_8e32b4:
	push_s blink
L_8e32b6:
	bl.d L_8c01c8
L_8e32ba:
	mov_s r1,0x0
L_8e32bc:
	mov_s r17,r0
L_8e32be:
	b_s L_8e32c8
	.global L_8e32c0
L_8e32c0:
	sub_s r2,r0,0x1
L_8e32c2:
	and_s r0,r0,r2
L_8e32c4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e32c6:
	extw_s r1,r1
	.global L_8e32c8
L_8e32c8:
	brne_s r0,0,L_8e32c0
L_8e32ca:
	brlt.d r1,0x1,L_8e33a8
L_8e32ce:
	mov_s r0,0x1
L_8e32d0:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8e32d2:
	extw_s r1,r1
L_8e32d4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e32d6
L_8e32d6:
	mov_s r21,r0
L_8e32d8:
	mov_s r19,r1
L_8e32da:
	cmp_s r0,0x1
L_8e32dc:
	sub r1,r17,0x1
L_8e32e0:
	mov.le r2,r17
L_8e32e4:
	ble_s L_8e32f6
L_8e32e6:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e32e8:
	extw_s r0,r0
L_8e32ea:
	mov_s lp_count,r0
L_8e32ec:
	mov_s r2,r17
L_8e32ee:
	lp L_8e32f6
L_8e32f2:
	and_s r2,r2,r1
L_8e32f4:
	sub_s r1,r2,0x1
	.global L_8e32f6
L_8e32f6:
	bic r13,r2,r1
L_8e32fa:
	extb_s r13,r13
L_8e32fc:
	mov_s r0,r13
L_8e32fe:
	mov_s r14,0x0
L_8e3300:
	bl.d L_8ce910
L_8e3304:
	mov_s r1,r14
L_8e3306:
	mov r20,0x6
L_8e330a:
	mov_s r15,0x13
L_8e330c:
	asl_s r15,r15,0x9
L_8e330e:
	cmp_s r13,0x8
L_8e3310:
	mov.gt r14,0x4
L_8e3314:
	lsr.gt r13,r13,0x4
L_8e3318:
	brlt r13,0x3,L_8e3322
L_8e331c:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_8e331e:
	extb_s r14,r14
L_8e3320:
	lsr_s r13,r13,0x2
	.global L_8e3322
L_8e3322:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e3324:
	add_s r14,r14,r13
L_8e3326:
	extb_s r14,r14
L_8e3328:
	mov_s r0,0x85776c
L_8e332e:
	ld.as r16,[r0,r14]
L_8e3332:
	mov_s r0,r16
L_8e3334:
	mov_s r13,0x0
L_8e3336:
	b_s L_8e3340
	.global L_8e3338
L_8e3338:
	sub_s r1,r0,0x1
L_8e333a:
	and_s r0,r0,r1
L_8e333c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e333e:
	extw_s r13,r13
	.global L_8e3340
L_8e3340:
	brne_s r0,0,L_8e3338
L_8e3342:
	mov_s r14,0x0
L_8e3344:
	breq_s r13,0,L_8e339a
	.global L_8e3346
L_8e3346:
	mov r18,0x0
L_8e334a:
	bset r18,r18,r14
L_8e334e:
	tst r18,r16
L_8e3352:
	beq_s L_8e3396
L_8e3354:
	add r1,r15,0x14
L_8e3358:
	mov_s r0,0x0
L_8e335a:
	bl.d L_8d4308
L_8e335e:
	mov_s r2,r18
L_8e3360:
	add r1,r15,0x8
L_8e3364:
	mov_s r0,0x0
L_8e3366:
	bl.d L_8d4308
L_8e336a:
	mov_s r2,r18
L_8e336c:
	lsr r0,r14,0x2
L_8e3370:
	add1_s r0,r0,r0
L_8e3372:
	asl r2,r20,r0
L_8e3376:
	add r1,r15,0x10
L_8e337a:
	cmp_s r14,0xf
L_8e337c:
	add.ls r2,r2,0x10000000
L_8e3384:
	add.hi r2,r2,0x20000000
L_8e338c:
	bl.d L_8d4308
L_8e3390:
	mov_s r0,0x0
L_8e3392:
	add_s r15,r15,0x18
L_8e3394:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
	.global L_8e3396
L_8e3396:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e3398:
	brne_s r13,0,L_8e3346
	.global L_8e339a
L_8e339a:
	sub r1,r19,0x1
L_8e339e:
	add r0,r21,0x1
L_8e33a2:
	brhs.d r1,0x1,L_8e32d6
L_8e33a6:
	extw_s r0,r0
	.global L_8e33a8
L_8e33a8:
	b L_8c021c
