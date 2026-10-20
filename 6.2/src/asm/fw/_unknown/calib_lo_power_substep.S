/* calib_lo_power_substep @ 0x8d530c, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_corr__estimate_and_apply_rx_gain
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, calib_lo_power_measure, hwd_abif__rx_table_index_force_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo_power_substep
calib_lo_power_substep:
	.global L_8d530c
L_8d530c:
	push_s blink
L_8d530e:
	bl L_8c01c8
L_8d5312:
	sub_s sp,sp,0x10
L_8d5314:
	mov_s r17,r0
L_8d5316:
	mov_s r14,r1
L_8d5318:
	mov_s r16,r2
L_8d531a:
	ldb r21,[gp, 0xa0]
L_8d531e:
	mov_s r0,0x0
L_8d5320:
	mov_s r20,r0
L_8d5322:
	mov_s r15,0xff
L_8d5324:
	mov_s r2,r0
L_8d5326:
	mov_s r18,r15
L_8d5328:
	mov_s r13,r15
L_8d532a:
	mov_s r19,r0
L_8d532c:
	b_s L_8d533a
	.global L_8d532e
L_8d532e:
	mov_s r14,r15
	.global L_8d5330
L_8d5330:
	mov r20,0x1
	.global L_8d5334
L_8d5334:
	mov_s r2,r13
L_8d5336:
	mov_s r18,r0
L_8d5338:
	mov_s r19,r1
	.global L_8d533a
L_8d533a:
	brne r20,0x0,L_8d53a4
L_8d533e:
	mov_s r0,0x0
L_8d5340:
	bl.d L_8cf5a8
L_8d5344:
	mov_s r1,r0
L_8d5346:
	mov_s r0,0x1
L_8d5348:
	bl.d L_8cf5a8
L_8d534c:
	mov_s r1,r14
L_8d534e:
	add_s r2,sp,0x8
L_8d5350:
	mov_s r0,r14
L_8d5352:
	bl.d L_8d6ca0
L_8d5356:
	mov_s r1,r21
L_8d5358:
	ld_s r2,[sp,0x8]
L_8d535a:
	mov_s r0,0x0
L_8d535c:
	brlt.d r2,0x0,L_8d5368
L_8d5360:
	bset_s r0,r0,0xf
L_8d5362:
	add_s r0,r0,r2
L_8d5364:
	asr_s r0,r0,0x10
L_8d5366:
	b_s L_8d536e
	.global L_8d5368
L_8d5368:
	sub_s r0,r0,r2
L_8d536a:
	asr_s r0,r0,0x10
L_8d536c:
	neg_s r0,r0
	.global L_8d536e
L_8d536e:
	sexb_s r0,r0
L_8d5370:
	sub r1,r16,r0
L_8d5374:
	sexb_s r1,r1
L_8d5376:
	abs_s r0,r1
L_8d5378:
	cmp_s r1,0x0
L_8d537a:
	extb_s r0,r0
L_8d537c:
	mov.eq r13,r2
L_8d5380:
	beq_s L_8d5330
L_8d5382:
	brlt r18,r0,L_8d532e
L_8d5386:
	rsub r3,r19,0x0
L_8d538a:
	breq r1,r3,L_8d532e
L_8d538e:
	brlt r1,0x1,L_8d5398
L_8d5392:
	sub_s r3,r14,0x1
L_8d5394:
	extb_s r3,r3
L_8d5396:
	b_s L_8d539c
	.global L_8d5398
L_8d5398:
	add_s r3,r14,0x1
L_8d539a:
	extb_s r3,r3
	.global L_8d539c
L_8d539c:
	mov_s r13,r2
L_8d539e:
	mov_s r15,r14
L_8d53a0:
	mov_s r14,r3
L_8d53a2:
	b_s L_8d5334
	.global L_8d53a4
L_8d53a4:
	stb_s r14,[sp,0x0]
L_8d53a6:
	ld_s r1,[sp,0x0]
L_8d53a8:
	st r2,[r17, 0x4]
L_8d53ac:
	st r1,[r17]
L_8d53b0:
	b.d L_8c021c
L_8d53b4:
	add_s sp,sp,0x10
L_8d53b6:
	nop_s
