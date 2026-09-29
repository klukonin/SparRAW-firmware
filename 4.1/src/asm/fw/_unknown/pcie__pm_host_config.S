/* pcie__pm_host_config @ 0x8dc264, 320 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   pcie_pm_host_config:: LnkCtl=0x%x usage7=0x%x
 * Зовут его: pcie__serdes_init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit2, hwd_pcie__is_l1_state, hwd_pcie__toggle_882f80_bits, hwd_pcie_config_lnkctl, hwd_pcie_l1_pm_sub_ctl_get, hwd_pcie_lnkctl_set, pcie__dbi_write_seq
 */
	.section .text.pcie__pm_host_config,"ax",@progbits
	.global pcie__pm_host_config
pcie__pm_host_config:
	.global L_8dc264
L_8dc264:
	push_s blink
L_8dc266:
	bl L_8c02bc
L_8dc26a:
	mov_s r14,0x882500
L_8dc270:
	ld_s r0,[r14,0x54]
L_8dc272:
	sub_s sp,sp,0xc
L_8dc274:
	bset_s r0,r0,0x3
L_8dc276:
	st_s r0,[r14,0x54]
L_8dc278:
	mov_s r13,0x1e8480
	.global L_8dc27e
L_8dc27e:
	/* bl.d 0x008ce310 */
	.byte 0x96,0x08,0x2f,0xf9
L_8dc282:
	/* _sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dc284:
	brne_s r0,0,L_8dc288
L_8dc286:
	brne_s r13,0,L_8dc27e
	.global L_8dc288
L_8dc288:
	brne_s r0,0,L_8dc29a
L_8dc28a:
	mov_s r3,blink
L_8dc28c:
	mov_s r2,0x1003464
L_8dc292:
	mov_s r0,0x0
L_8dc294:
	bl.d L_8edfcc
L_8dc298:
	mov_s r1,r0
	.global L_8dc29a
L_8dc29a:
	mov_s r13,sp
L_8dc29c:
	bl.d L_8ceb10
L_8dc2a0:
	mov_s r0,r13
L_8dc2a2:
	add_s r15,sp,0x4
L_8dc2a4:
	bl.d L_8ce958
L_8dc2a8:
	mov_s r0,r15
L_8dc2aa:
	mov_s r1,0x11
L_8dc2ac:
	asl_s r1,r1,0x13
L_8dc2ae:
	ld r16,[r1, 0x1c]
L_8dc2b2:
	ld_s r0,[sp,0x0]
L_8dc2b4:
	bbit0 r16,0x1,L_8dc328
L_8dc2b8:
	lsr r1,r16,0x2
L_8dc2bc:
	bmsk_s r1,r1,0x0
L_8dc2be:
	lsr r2,r16,0x3
L_8dc2c2:
	bmsk_s r2,r2,0x0
L_8dc2c4:
	asl_s r2,r2
L_8dc2c6:
	bic r0,r0,0x3
L_8dc2ca:
	bclr_s r1,r1,0x1
L_8dc2cc:
	or_s r0,r0,r1
L_8dc2ce:
	or_s r0,r0,r2
L_8dc2d0:
	lsr r1,r16,0x4
L_8dc2d4:
	bmsk_s r1,r1,0x0
L_8dc2d6:
	asl_s r1,r1,0x8
L_8dc2d8:
	bclr_s r0,r0,0x8
L_8dc2da:
	or_s r0,r0,r1
L_8dc2dc:
	st_s r0,[sp,0x0]
L_8dc2de:
	bl.d L_8ceb40
L_8dc2e2:
	mov_s r0,r13
L_8dc2e4:
	lsr r0,r16,0x8
L_8dc2e8:
	bmsk_s r0,r0,0x0
L_8dc2ea:
	ld_s r1,[sp,0x4]
L_8dc2ec:
	lsr r2,r16,0x7
L_8dc2f0:
	bmsk_s r2,r2,0x0
L_8dc2f2:
	asl_s r2,r2
L_8dc2f4:
	bic r1,r1,0x3
L_8dc2f8:
	bclr_s r0,r0,0x1
L_8dc2fa:
	or_s r0,r0,r1
L_8dc2fc:
	or_s r2,r2,r0
L_8dc2fe:
	lsr r0,r16,0x6
L_8dc302:
	bmsk_s r0,r0,0x0
L_8dc304:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8dc306:
	lsr r1,r16,0x5
L_8dc30a:
	bmsk_s r1,r1,0x0
L_8dc30c:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_8dc30e:
	bic r2,r2,0xc
L_8dc312:
	bclr_s r0,r0,0x3
L_8dc314:
	or_s r2,r2,r0
L_8dc316:
	or_s r1,r1,r2
L_8dc318:
	st_s r1,[sp,0x4]
L_8dc31a:
	bl.d L_8ce98c
L_8dc31e:
	mov_s r0,r15
L_8dc320:
	bl.d L_8ce85c
L_8dc324:
	mov_s r0,0x1
L_8dc326:
	b_s L_8dc384
	.global L_8dc328
L_8dc328:
	bmsk r3,r0,0x0
L_8dc32c:
	/* asl_s r3,r3,0x2 */
	.byte 0x02,0xbb
L_8dc32e:
	lsr_s r2,r0
L_8dc330:
	bmsk_s r2,r2,0x0
L_8dc332:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_8dc334:
	bic r13,r16,0xc
L_8dc338:
	bclr_s r3,r3,0x3
L_8dc33a:
	or_s r3,r3,r13
L_8dc33c:
	lsr_s r0,r0,0x8
L_8dc33e:
	bmsk_s r0,r0,0x0
L_8dc340:
	asl_s r13,r0,0x4
L_8dc342:
	ld_s r0,[sp,0x4]
L_8dc344:
	or_s r2,r2,r3
L_8dc346:
	bmsk r3,r0,0x0
L_8dc34a:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8dc34c:
	bic r2,r2,0x30
L_8dc350:
	bclr_s r13,r13,0x5
L_8dc352:
	or_s r2,r2,r13
L_8dc354:
	or_s r3,r3,r2
L_8dc356:
	lsr_s r2,r0
L_8dc358:
	bmsk_s r2,r2,0x0
L_8dc35a:
	/* asl_s r2,r2,0x6 */
	.byte 0x06,0xba
L_8dc35c:
	lsr r13,r0,0x2
L_8dc360:
	bmsk_s r13,r13,0x0
L_8dc362:
	/* asl_s r13,r13,0x7 */
	.byte 0x07,0xbd
L_8dc364:
	bic r3,r3,0xc0
L_8dc368:
	bclr_s r2,r2,0x7
L_8dc36a:
	or_s r2,r2,r3
L_8dc36c:
	or_s r2,r2,r13
L_8dc36e:
	lsr_s r0,r0,0x3
L_8dc370:
	bmsk_s r0,r0,0x0
L_8dc372:
	asl_s r0,r0,0x8
L_8dc374:
	bclr_s r2,r2,0x8
L_8dc376:
	bclr_s r2,r2,0x1
L_8dc378:
	bclr_s r0,r0,0x1
L_8dc37a:
	or_s r0,r0,r2
L_8dc37c:
	bset r16,r0,0x1
L_8dc380:
	st r16,[r1, 0x1c]
	.global L_8dc384
L_8dc384:
	ld_s r0,[r14,0x54]
L_8dc386:
	mov_s r2,0x1003494
L_8dc38c:
	bclr_s r0,r0,0x3
L_8dc38e:
	st_s r0,[r14,0x54]
L_8dc390:
	ld_s r3,[sp,0x0]
L_8dc392:
	mov_s r0,0xe
L_8dc394:
	mov_s r1,0x2
L_8dc396:
	bl.d L_8edff8
L_8dc39a:
	mov r4,r16
L_8dc39e:
	b.d L_8c0324
L_8dc3a2:
	add_s sp,sp,0xc
