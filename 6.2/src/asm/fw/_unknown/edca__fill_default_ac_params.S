/* edca__fill_default_ac_params @ 0x8e63f4, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__set_edca_defaults
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bits__set16h_s0_w4, bits__set16h_s5_w2, bits__set8_s0_w4, bits__set8_s4_w4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global edca__fill_default_ac_params
edca__fill_default_ac_params:
	.global L_8e63f4
L_8e63f4:
	push_s blink
L_8e63f6:
	bl L_8c01e4
L_8e63fa:
	mov_s r13,r0
L_8e63fc:
	mov_s r14,0x0
L_8e63fe:
	b_s L_8e640a
	.global L_8e6400
L_8e6400:
	mov_s r0,0x28
L_8e6402:
	stw_s r0,[r2,0x18]
L_8e6404:
	mov_s r14,0x0
	.global L_8e6406
L_8e6406:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e6408:
	extb_s r14,r14
	.global L_8e640a
L_8e640a:
	brhs r14,0x4,L_8e64b8
L_8e640e:
	add2 r2,r13,r14
L_8e6412:
	ldw_s r0,[r2,0x16]
L_8e6414:
	bmsk r1,r14,0x1
L_8e6418:
	bclr_s r0,r0,0x4
L_8e641a:
	stw_s r0,[r2,0x16]
L_8e641c:
	add r0,r2,0x16
L_8e6420:
	bl.d L_8ed328
L_8e6424:
	mov_s r3,0x0
L_8e6426:
	ldw_s r1,[r2,0x16]
L_8e6428:
	bclr_s r1,r1,0x7
L_8e642a:
	stw_s r1,[r2,0x16]
L_8e642c:
	breq_s r14,0,L_8e6456
L_8e642e:
	breq r14,0x1,L_8e6482
L_8e6432:
	breq r14,0x2,L_8e649e
L_8e6436:
	brne r14,0x3,L_8e6406
L_8e643a:
	mov_s r1,0x2
L_8e643c:
	bl L_8ed2ec
L_8e6440:
	add r0,r2,0x17
L_8e6444:
	bl L_8ed238
L_8e6448:
	mov_s r1,0x3
L_8e644a:
	bl L_8ed2a4
L_8e644e:
	mov_s r0,0x10
L_8e6450:
	stw_s r0,[r2,0x18]
L_8e6452:
	mov_s r14,r1
L_8e6454:
	b_s L_8e6406
	.global L_8e6456
L_8e6456:
	mov_s r1,0x3
L_8e6458:
	bl L_8ed2ec
L_8e645c:
	mov_s r1,0x4
L_8e645e:
	add r0,r2,0x17
L_8e6462:
	bl L_8ed238
L_8e6466:
	mov_s r1,0xa
L_8e6468:
	bl L_8ed2a4
L_8e646c:
	mov_s r1,0x803c00
L_8e6472:
	ld_s r0,[r1,0xc]
L_8e6474:
	brne_s r0,0,L_8e6400
L_8e6476:
	ld_s r0,[r1,0x10]
L_8e6478:
	brne_s r0,0,L_8e6400
L_8e647a:
	mov_s r14,r3
	.global L_8e647c
L_8e647c:
	mov_s r0,0x40
L_8e647e:
	stw_s r0,[r2,0x18]
L_8e6480:
	b_s L_8e6406
	.global L_8e6482
L_8e6482:
	mov_s r1,0x7
L_8e6484:
	bl.d L_8ed2ec
L_8e6488:
	mov_s r14,0x1
L_8e648a:
	add r0,r2,0x17
L_8e648e:
	mov_s r1,0x4
L_8e6490:
	bl L_8ed238
L_8e6494:
	mov_s r1,0xa
L_8e6496:
	bl L_8ed2a4
L_8e649a:
	stw_s r3,[r2,0x18]
L_8e649c:
	b_s L_8e6406
	.global L_8e649e
L_8e649e:
	mov_s r14,0x2
L_8e64a0:
	mov_s r1,r14
L_8e64a2:
	bl L_8ed2ec
L_8e64a6:
	add r0,r2,0x17
L_8e64aa:
	mov_s r1,0x3
L_8e64ac:
	bl L_8ed238
L_8e64b0:
	mov_s r1,0x4
L_8e64b2:
	bl L_8ed2a4
L_8e64b6:
	b_s L_8e647c
	.global L_8e64b8
L_8e64b8:
	b L_8c0254
