/* hwd_spi_read @ 0x8f9294, 336 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SPI READ: waited %d usec for interface !!!
 *   SPI LOCK FAILED (GUI_LOCK_CNT=%d GUI_UNLOCK_CNT=%d)
 *   SPI LOCK FAILED (FW last locked)
 *   SPI LOCK FAILED (FW last released)
 *   SPI LOCK FAILED (owner 0x%X)
 * Зовут его: boot__load_from_flash
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, hwd_spi__poll_done, hwd_spi__release_lock
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_spi_read
hwd_spi_read:
	.global L_8f9294
L_8f9294:
	push_s blink
L_8f9296:
	bl L_8c01d4
L_8f929a:
	sub_s sp,sp,0x4
L_8f929c:
	mov_s r17,r0
L_8f929e:
	mov_s r15,r1
L_8f92a0:
	mov_s r16,r2
L_8f92a2:
	mov_s r0,0x4c4b40
L_8f92a8:
	bl.d L_8f9248
L_8f92ac:
	mov_s r13,0x64
L_8f92ae:
	cmp_s r0,0x0
L_8f92b0:
	beq_s L_8f9378
L_8f92b2:
	mov_s r0,0x65
	.global L_8f92b4
L_8f92b4:
	mov_s r18,r0
L_8f92b6:
	mov_s r0,0x50
L_8f92b8:
	mov lp_count,r0
L_8f92bc:
	nop_s
L_8f92be:
	lp L_8f92c6
L_8f92c2:
	nop_s
L_8f92c4:
	nop_s
	.global L_8f92c6
L_8f92c6:
	mov_s r14,0x880180
L_8f92cc:
	ld_s r0,[r14,0x28]
L_8f92ce:
	and r0,r0,0x20000000
L_8f92d6:
	cmp_s r0,0x0
L_8f92d8:
	mov_s r0,0x1
L_8f92da:
	sub_s.ne r0,r0,r0
L_8f92dc:
	extb.f 0x0,r0
L_8f92e0:
	bne_s L_8f92ec
L_8f92e2:
	sub r0,r18,0x1
L_8f92e6:
	brhs.d r0,0x1,L_8f92b4
L_8f92ea:
	/* _sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
	.global L_8f92ec
L_8f92ec:
	cmp_s r13,0x64
L_8f92ee:
	beq_s L_8f9302
L_8f92f0:
	mov_s r1,0x101ed60
L_8f92f6:
	mov_s r12,0x64
L_8f92f8:
	rsub r2,r13,r12
L_8f92fc:
	bl.d L_8dcc10
L_8f9300:
	mov_s r0,0x10
	.global L_8f9302
L_8f9302:
	ld_s r0,[r14,0x28]
L_8f9304:
	bbit1 r0,0x1d,L_8f93ca
	.global L_8f9308
L_8f9308:
	brlo 0x100,r15,L_8f93d6
	.global L_8f9310
L_8f9310:
	st r17,[r14, 0x30]
L_8f9314:
	or r0,r15,0x3030000
L_8f931c:
	st_s r0,[r14,0x2c]
L_8f931e:
	st 0xc0000000,[r14, 0x28]
	.global L_8f9326
L_8f9326:
	ld_s r0,[r14,0x28]
L_8f9328:
	bbit1 r0,0x1d,L_8f9326
L_8f932c:
	asr_s r0,r15,0x2
L_8f932e:
	mov_s r1,0x0
L_8f9330:
	mov_s r3,0x8800a8
L_8f9336:
	cmp_s r0,0x0
L_8f9338:
	mov_s r2,r3
L_8f933a:
	mov.hi lp_count,r0
L_8f933e:
	lphi L_8f9350
L_8f9342:
	ld_s r0,[r2]
L_8f9344:
	add2 r12,r16,r1
L_8f9348:
	st_s r0,[r12]
L_8f934a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f934c:
	add2 r2,r3,r1
	.global L_8f9350
L_8f9350:
	add2 r0,r16,r1
L_8f9354:
	ld_s r1,[r2]
L_8f9356:
	bmsk_s r15,r15,0x1
L_8f9358:
	st_s r1,[sp,0x0]
L_8f935a:
	mov_s r1,0x0
L_8f935c:
	cmp_s r15,0x0
L_8f935e:
	mov.hi lp_count,r15
L_8f9362:
	lphi L_8f9370
L_8f9366:
	ldb r2,[sp,r1]
L_8f936a:
	add_s r12,r0,r1
L_8f936c:
	stb_s r2,[r12]
L_8f936e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8f9370
L_8f9370:
	bl L_8f93e4
L_8f9374:
	mov_s r0,0x1
L_8f9376:
	b_s L_8f93c4
	.global L_8f9378
L_8f9378:
	mov_s r13,0x880a3c
L_8f937e:
	ld_s r2,[r13,0x3c]
L_8f9380:
	mov_s r1,0x101ed8c
L_8f9386:
	mov_s r0,0x0
L_8f9388:
	bl.d L_8dcc80
L_8f938c:
	ld_s r3,[r13,0x40]
L_8f938e:
	ld_s r2,[r13,0x4c]
L_8f9390:
	brne r2,0x1234,L_8f93a6
L_8f9398:
	mov_s r1,0x101edc0
	.global L_8f939e
L_8f939e:
	bl.d L_8dcba8
L_8f93a2:
	mov_s r0,0x0
L_8f93a4:
	b_s L_8f93c2
	.global L_8f93a6
L_8f93a6:
	brne r2,0x4321,L_8f93b6
L_8f93ae:
	mov_s r1,0x101ede4
L_8f93b4:
	b_s L_8f939e
	.global L_8f93b6
L_8f93b6:
	mov_s r1,0x101ee08
L_8f93bc:
	bl.d L_8dcc10
L_8f93c0:
	mov_s r0,0x0
	.global L_8f93c2
L_8f93c2:
	mov_s r0,0x0
	.global L_8f93c4
L_8f93c4:
	b.d L_8c0234
L_8f93c8:
	add_s sp,sp,0x4
	.global L_8f93ca
L_8f93ca:
	mov_s r0,blink
L_8f93cc:
	mov_s r1,0x1e
L_8f93ce:
	bl.d L_8c9b28
L_8f93d2:
	bset_s r1,r1,0xc
L_8f93d4:
	b_s L_8f9308
	.global L_8f93d6
L_8f93d6:
	mov_s r0,blink
L_8f93d8:
	mov_s r1,0xea
L_8f93da:
	bl.d L_8c9b28
L_8f93de:
	bset_s r1,r1,0xc
L_8f93e0:
	b_s L_8f9310
L_8f93e2:
	nop_s
