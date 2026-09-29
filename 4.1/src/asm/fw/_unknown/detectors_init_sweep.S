/* detectors_init_sweep @ 0x8d64a0, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bad_beacons_detector__init, ka_necessity_detector__init, mem_pool__init, memset0_words, tx_ppdu_ageing_timeout_detector__init
 */
	.section .text.detectors_init_sweep,"ax",@progbits
	.global detectors_init_sweep
detectors_init_sweep:
	.global L_8d64a0
L_8d64a0:
	push_s blink
L_8d64a2:
	bl.d L_8c02bc
L_8d64a6:
	mov_s r1,0x33
L_8d64a8:
	mov_s r14,0x8046f0
L_8d64ae:
	mov_s r0,r14
L_8d64b0:
	/* bl.d 0x008c1a78 */
	.byte 0xca,0x0d,0xaf,0xf5
L_8d64b4:
	/* _asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8d64b6:
	mov_s r13,0x804628
L_8d64bc:
	add2 r0,r13,0x2d
L_8d64c0:
	mov_s r1,r14
L_8d64c2:
	mov r2,0x198
L_8d64c6:
	bl.d L_8c6c70
L_8d64ca:
	mov_s r3,0x8
L_8d64cc:
	mov_s r0,r13
L_8d64ce:
	bl.d L_8c1a78
L_8d64d2:
	mov_s r1,0x60
L_8d64d4:
	add3 r0,r13,0xc
L_8d64d8:
	mov_s r1,r13
L_8d64da:
	mov_s r2,0xc
L_8d64dc:
	bl.d L_8c6c70
L_8d64e0:
	mov_s r3,0x8
L_8d64e2:
	add2 r0,r13,0x1d
L_8d64e6:
	bl.d L_8c1a78
L_8d64ea:
	mov_s r1,0x40
L_8d64ec:
	mov_s r13,0x0
L_8d64ee:
	mov r16,0x8
	.global L_8d64f2
L_8d64f2:
	mul64 r13,0xa4
L_8d64f6:
	mov_s r1,r13
L_8d64f8:
	mov_s r14,0x857060
L_8d64fe:
	add r15,mlo,0x8053b0
L_8d6506:
	mov_s r0,r15
L_8d6508:
	bl.d L_8d6140
L_8d650c:
	add r2,r14,0x1c
L_8d6510:
	add2 r0,r15,0x15
L_8d6514:
	mov_s r1,r13
L_8d6516:
	bl.d L_8d60a4
L_8d651a:
	add r2,r14,0x1c
L_8d651e:
	add3 r0,r15,0x13
L_8d6522:
	mov_s r1,r13
L_8d6524:
	bl.d L_8d5f8c
L_8d6528:
	add r2,r14,0x1c
L_8d652c:
	sub r16,r16,0x1
L_8d6530:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d6532:
	brhs.d r16,0x1,L_8d64f2
L_8d6536:
	extb_s r13,r13
L_8d6538:
	b L_8c0324
