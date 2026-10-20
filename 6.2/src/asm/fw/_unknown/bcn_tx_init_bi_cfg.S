/* bcn_tx_init_bi_cfg @ 0x8c45d4, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bcn_tx_init_bi_cfg(): discovery_mode = %x
 * Зовут его: lmac_if__build_bcon_cfg
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bcn_tx_init_bi_cfg
bcn_tx_init_bi_cfg:
	.global L_8c45d4
L_8c45d4:
	sub_s sp,sp,0x8
L_8c45d6:
	push_s blink
L_8c45d8:
	push_s r13
L_8c45da:
	st_s r1,[sp,0x8]
L_8c45dc:
	ldb r1,[sp, 0xb]
L_8c45e0:
	st_s r2,[sp,0xc]
L_8c45e2:
	lsr_s r1,r1,0x5
L_8c45e4:
	add3 r2,r0,0x8
L_8c45e8:
	stb_s r1,[r2,0x14]
L_8c45ea:
	ldw r1,[sp, 0xc]
L_8c45ee:
	ldb r3,[sp, 0xb]
L_8c45f2:
	lsr_s r1,r1,0x6
L_8c45f4:
	bmsk_s r1,r1,0x5
L_8c45f6:
	stb_s r1,[r2,0x15]
L_8c45f8:
	ldb r1,[sp, 0x9]
L_8c45fc:
	asl_s r3,r3,0x8
L_8c45fe:
	lsr_s r1,r1,0x2
L_8c4600:
	bmsk_s r1,r1,0x3
L_8c4602:
	stb_s r1,[r2,0x17]
L_8c4604:
	mov_s r1,0x0
L_8c4606:
	stb_s r1,[r2,0x18]
L_8c4608:
	ldb r1,[sp, 0xa]
L_8c460c:
	or_s r1,r1,r3
L_8c460e:
	lsr_s r1,r1,0x6
L_8c4610:
	bmsk_s r1,r1,0x6
L_8c4612:
	stb_s r1,[r2,0x19]
L_8c4614:
	ldb_s r1,[sp,0x8]
L_8c4616:
	ld_s r3,[r0,0x64]
L_8c4618:
	bmsk r13,r1,0x0
L_8c461c:
	bclr_s r3,r3,0x0
L_8c461e:
	or_s r3,r3,r13
L_8c4620:
	lsr_s r1,r1
L_8c4622:
	bmsk_s r1,r1,0x0
L_8c4624:
	asl_s r1,r1
L_8c4626:
	bclr_s r3,r3,0x1
L_8c4628:
	or_s r3,r3,r1
L_8c462a:
	ldb r1,[sp, 0xd]
L_8c462e:
	bic r3,r3,0xc
L_8c4632:
	lsr_s r1,r1,0x4
L_8c4634:
	bmsk_s r1,r1,0x0
L_8c4636:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_8c4638:
	or_s r3,r3,r1
L_8c463a:
	st_s r3,[r0,0x64]
L_8c463c:
	ldb r1,[sp, 0x9]
L_8c4640:
	ldb_s r0,[sp,0x8]
L_8c4642:
	asl_s r1,r1,0x8
L_8c4644:
	or_s r0,r0,r1
L_8c4646:
	lsr_s r0,r0,0x7
L_8c4648:
	bmsk_s r0,r0,0x2
L_8c464a:
	stb_s r0,[r2,0x1a]
L_8c464c:
	mov_s r1,0x1004ad8
L_8c4652:
	lsr_s r2,r3
L_8c4654:
	mov_s r0,0x25
L_8c4656:
	bl.d L_8dcc10
L_8c465a:
	bmsk_s r2,r2,0x0
L_8c465c:
	mov_s r12,0xc
L_8c465e:
	b L_8c025e
L_8c4662:
	nop_s
