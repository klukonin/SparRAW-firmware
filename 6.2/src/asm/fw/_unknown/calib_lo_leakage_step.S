/* calib_lo_leakage_step @ 0x8c839c, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_leakage__sweep
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, abif__get_rx_table_index_force_val, hwd_abif__rx_table_config_vga_dc, hwd_abif__rx_table_index_force_mode, hwd_abif__rx_table_read_vga_dc, hwd_phy__rx_cal_corr, hwd_phy__rx_cal_corr_config
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo_leakage_step
calib_lo_leakage_step:
	.global L_8c839c
L_8c839c:
	push_s blink
L_8c839e:
	bl L_8c01c8
L_8c83a2:
	sub_s sp,sp,0x8
L_8c83a4:
	mov_s r16,r1
L_8c83a6:
	bl.d L_8cf5ec
L_8c83aa:
	mov_s r14,0x4
L_8c83ac:
	mov_s r20,r0
L_8c83ae:
	mov_s r0,0x0
L_8c83b0:
	bset_s r0,r0,0xf
L_8c83b2:
	mov_s r1,0x1
L_8c83b4:
	bl.d L_8d2418
L_8c83b8:
	mov_s r2,0x0
L_8c83ba:
	mov_s r0,0x0
L_8c83bc:
	bl.d L_8cf5a8
L_8c83c0:
	mov_s r1,0x0
L_8c83c2:
	mov_s r0,0x1
L_8c83c4:
	bl.d L_8cf5a8
L_8c83c8:
	mov_s r1,r20
L_8c83ca:
	mov_s r0,sp
L_8c83cc:
	bl.d L_8d23a0
L_8c83d0:
	mov_s r17,r0
L_8c83d2:
	ld_s r0,[sp,0x4]
L_8c83d4:
	mov_s r13,0x0
L_8c83d6:
	bset_s r13,r13,0xe
L_8c83d8:
	cmp_s r0,0x0
L_8c83da:
	add.ge r0,r0,r13
L_8c83de:
	asr.ge r0,r0,0xf
L_8c83e2:
	bge_s L_8c83ec
L_8c83e4:
	sub r1,r13,r0
L_8c83e8:
	asr_s r1,r1,0xf
L_8c83ea:
	neg_s r0,r1
	.global L_8c83ec
L_8c83ec:
	abs_s r15,r0
L_8c83ee:
	cmp_s r15,0x5
L_8c83f0:
	mov r19,0x1
L_8c83f4:
	sub.ls r19,r19,r19
L_8c83f8:
	mov r18,0x1
L_8c83fc:
	mov r21,0x4
	.global L_8c8400
L_8c8400:
	mov_s r0,r20
L_8c8402:
	mov_s r1,r18
L_8c8404:
	bl.d L_8cf718
L_8c8408:
	mov_s r2,0x1
L_8c840a:
	sub r1,r16,0x1
L_8c840e:
	add_s r1,r1,r18
L_8c8410:
	stb_s r0,[r1]
L_8c8412:
	sub r21,r21,0x1
L_8c8416:
	add r18,r18,0x1
L_8c841a:
	brhs.d r21,0x1,L_8c8400
L_8c841e:
	extb r18,r18
L_8c8422:
	b_s L_8c84be
	.global L_8c8424
L_8c8424:
	sub r0,r16,0x20
L_8c8428:
	ld_s r1,[sp,0x4]
L_8c842a:
	extb_s r15,r15
L_8c842c:
	cmp_s r1,0x0
L_8c842e:
	add.ge r1,r1,r13
L_8c8432:
	asr.ge r1,r1,0xf
L_8c8436:
	bge_s L_8c8440
L_8c8438:
	sub r2,r13,r1
L_8c843c:
	asr_s r2,r2,0xf
L_8c843e:
	neg_s r1,r2
	.global L_8c8440
L_8c8440:
	add r18,r0,r14
L_8c8444:
	ldb r3,[r18, 0x1f]
L_8c8448:
	cmp_s r1,0x5
L_8c844a:
	add.gt r3,r3,0x1
L_8c844e:
	min.gt r3,r3,0x1f
L_8c8452:
	sub.le r3,r3,0x1
L_8c8456:
	max.le r3,r3,0x0
L_8c845a:
	extb_s r3,r3
L_8c845c:
	mov_s r0,r20
L_8c845e:
	mov_s r1,r14
L_8c8460:
	bl.d L_8cf36c
L_8c8464:
	mov_s r2,0x1
L_8c8466:
	mov_s r0,0x0
L_8c8468:
	bl.d L_8cf5a8
L_8c846c:
	mov_s r1,r0
L_8c846e:
	mov_s r0,0x1
L_8c8470:
	bl.d L_8cf5a8
L_8c8474:
	mov_s r1,r20
L_8c8476:
	bl.d L_8d23a0
L_8c847a:
	mov_s r0,r17
L_8c847c:
	ld_s r0,[sp,0x4]
L_8c847e:
	cmp_s r0,0x0
L_8c8480:
	add.ge r0,r0,r13
L_8c8484:
	asr.ge r0,r0,0xf
L_8c8488:
	bge_s L_8c8492
L_8c848a:
	sub r1,r13,r0
L_8c848e:
	asr_s r1,r1,0xf
L_8c8490:
	neg_s r0,r1
	.global L_8c8492
L_8c8492:
	abs_s r0,r0
L_8c8494:
	cmp_s r15,r0
L_8c8496:
	mov.cc r15,r0
L_8c849a:
	bhs_s L_8c84aa
L_8c849c:
	mov_s r0,r20
L_8c849e:
	mov_s r1,r14
L_8c84a0:
	mov_s r2,0x1
L_8c84a2:
	bl.d L_8cf36c
L_8c84a6:
	ldb r3,[r18, 0x1f]
	.global L_8c84aa
L_8c84aa:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8c84ac:
	extb_s r14,r14
L_8c84ae:
	brlo.d r15,0x6,L_8c84ba
L_8c84b2:
	mov_s r0,0x0
L_8c84b4:
	cmp_s r14,0x0
L_8c84b6:
	mov.gt r0,0x1
	.global L_8c84ba
L_8c84ba:
	extb r19,r0
	.global L_8c84be
L_8c84be:
	brne r19,0x0,L_8c8424
L_8c84c2:
	mov_s r0,0x0
L_8c84c4:
	bset_s r0,r0,0xf
L_8c84c6:
	mov_s r1,0x1
L_8c84c8:
	bl.d L_8d2418
L_8c84cc:
	mov_s r2,0x65
L_8c84ce:
	b.d L_8c021c
L_8c84d2:
	add_s sp,sp,0x8
