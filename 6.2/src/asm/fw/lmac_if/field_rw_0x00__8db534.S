/* field_rw_0x00__8db534 @ 0x8db534, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__action_8f2f0c, maintain_sm__reset_rate_params
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_rw_0x00__8db534
field_rw_0x00__8db534:
	.global L_8db534
L_8db534:
	push_s blink
L_8db536:
	bl L_8c01d4
L_8db53a:
	mov_s r14,r1
L_8db53c:
	mov_s r13,r2
L_8db53e:
	mov_s r15,r3
L_8db540:
	mov r16,r4
L_8db544:
	mov r17,r5
L_8db548:
	bl.d L_8c3284
L_8db54c:
	mov r18,r6
L_8db550:
	bmsk_s r14,r14,0x0
L_8db552:
	ld_s r1,[r0]
L_8db554:
	asl_s r2,r14,0x3
L_8db556:
	bclr_s r1,r1,0x3
L_8db558:
	or_s r2,r2,r1
L_8db55a:
	bmsk_s r13,r13,0x0
L_8db55c:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8db55e:
	bclr_s r2,r2,0x2
L_8db560:
	or_s r2,r2,r13
L_8db562:
	bmsk_s r15,r15,0x0
L_8db564:
	asl_s r15,r15
L_8db566:
	bclr_s r2,r2,0x1
L_8db568:
	or_s r2,r2,r15
L_8db56a:
	bmsk r1,r16,0x0
L_8db56e:
	bclr_s r2,r2,0x0
L_8db570:
	or_s r2,r2,r1
L_8db572:
	bmsk r1,r17,0x0
L_8db576:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8db578:
	bclr_s r2,r2,0x4
L_8db57a:
	or_s r2,r2,r1
L_8db57c:
	bmsk r1,r18,0x0
L_8db580:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8db582:
	bclr_s r2,r2,0x5
L_8db584:
	or_s r1,r1,r2
L_8db586:
	st_s r1,[r0]
L_8db588:
	mov_s r1,0x14
L_8db58a:
	mov_s r2,0x4
L_8db58c:
	bl.d L_8e5204
L_8db590:
	mov_s r3,0x0
L_8db592:
	b L_8c0234
L_8db596:
	nop_s
