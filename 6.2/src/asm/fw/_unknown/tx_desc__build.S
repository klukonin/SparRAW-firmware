/* tx_desc__build @ 0x8ca4d8, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ring__post_frame
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set32_s0_w4, bits__set32_s16_w4, bits__set32_s24_w7, tx_desc__bits_set32_s0_w10, tx_desc__bits_set32_s22_w5, tx_desc__set_lifetime
 * Глобалы (через gp): 0x80036c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_desc__build
tx_desc__build:
	.global L_8ca4d8
L_8ca4d8:
	push_s blink
L_8ca4da:
	bl L_8c01dc
L_8ca4de:
	mov_s r13,r1
L_8ca4e0:
	mov_s r14,r2
L_8ca4e2:
	mov_s r15,r3
L_8ca4e4:
	mov r16,r5
L_8ca4e8:
	ld_s r2,[r13,0x4]
L_8ca4ea:
	mov_s r1,r7
L_8ca4ec:
	bclr_s r2,r2,0x17
L_8ca4ee:
	bclr_s r2,r2,0x1f
L_8ca4f0:
	st_s r2,[r13,0x4]
L_8ca4f2:
	brne r6,0x0,L_8ca506
L_8ca4f6:
	bmsk_s r1,r1,0x6
L_8ca4f8:
	add_s r0,r13,0x4
L_8ca4fa:
	bl L_8ed484
L_8ca4fe:
	ld_s r0,[r13,0x4]
L_8ca500:
	bset_s r0,r0,0x1f
L_8ca502:
	st_s r0,[r13,0x4]
L_8ca504:
	b_s L_8ca51e
	.global L_8ca506
L_8ca506:
	ld_s r1,[sp,0x14]
L_8ca508:
	breq_s r1,0,L_8ca51e
L_8ca50a:
	bset_s r2,r2,0x17
L_8ca50c:
	st_s r2,[r13,0x4]
L_8ca50e:
	bl.d L_8cc490
L_8ca512:
	ld_s r0,[gp,0x1e8]
L_8ca514:
	bmsk r1,r0,0x9
L_8ca518:
	mov_s r0,r13
L_8ca51a:
	bl L_8ed334
	.global L_8ca51e
L_8ca51e:
	ld_s r0,[r13]
L_8ca520:
	bmsk r1,r16,0x4
L_8ca524:
	bset_s r0,r0,0x1b
L_8ca526:
	st_s r0,[r13]
L_8ca528:
	mov_s r0,r13
L_8ca52a:
	bl L_8ed454
L_8ca52e:
	ld_s r0,[r13,0x4]
L_8ca530:
	ldb_s r1,[sp,0x18]
L_8ca532:
	bset_s r0,r0,0x14
L_8ca534:
	st_s r0,[r13,0x4]
L_8ca536:
	bmsk_s r1,r1,0x3
L_8ca538:
	add_s r0,r13,0x4
L_8ca53a:
	bl L_8ed3f4
L_8ca53e:
	ld_s r1,[r13,0x4]
L_8ca540:
	bset_s r1,r1,0x4
L_8ca542:
	st_s r1,[r13,0x4]
L_8ca544:
	bmsk r1,r15,0x3
L_8ca548:
	bl L_8ed370
L_8ca54c:
	b.d L_8c0244
L_8ca550:
	st_s r14,[r13,0xc]
L_8ca552:
	nop_s
