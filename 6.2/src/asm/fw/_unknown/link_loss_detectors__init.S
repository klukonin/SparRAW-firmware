/* link_loss_detectors__init @ 0x8d94f0, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bad_beacons_detector__init, detector__init_per_cid_a, detector__init_per_cid_b, mem_pool__init, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_loss_detectors__init
link_loss_detectors__init:
	.global L_8d94f0
L_8d94f0:
	push_s blink
L_8d94f2:
	bl.d L_8c01dc
L_8d94f6:
	mov_s r1,0xd
L_8d94f8:
	mov_s r13,0x85400c
L_8d94fe:
	add3 r0,r13,0x19
L_8d9502:
	bl.d L_8c1cd8
L_8d9506:
	asl_s r1,r1,0x8
L_8d9508:
	add2 r0,r13,0x2d
L_8d950c:
	add3 r1,r13,0x19
L_8d9510:
	mov r2,0x1a0
L_8d9514:
	bl.d L_8c7cf8
L_8d9518:
	mov_s r3,0x8
L_8d951a:
	mov_s r0,r13
L_8d951c:
	bl.d L_8c1cd8
L_8d9520:
	mov_s r1,0x60
L_8d9522:
	add3 r0,r13,0xc
L_8d9526:
	mov_s r1,r13
L_8d9528:
	mov_s r2,0xc
L_8d952a:
	bl.d L_8c7cf8
L_8d952e:
	mov_s r3,0x8
L_8d9530:
	add2 r0,r13,0x1d
L_8d9534:
	bl.d L_8c1cd8
L_8d9538:
	mov_s r1,0x40
L_8d953a:
	mov_s r13,0x0
L_8d953c:
	mov r16,0x8
	.global L_8d9540
L_8d9540:
	mul64 r13,0xa4
L_8d9544:
	mov_s r1,r13
L_8d9546:
	mov_s r14,0x857060
L_8d954c:
	add r15,mlo,0x854e00
L_8d9554:
	sub r0,r15,0x2c
L_8d9558:
	bl.d L_8d91b4
L_8d955c:
	add_s r2,r14,0x4
L_8d955e:
	add r0,r15,0x28
L_8d9562:
	mov_s r1,r13
L_8d9564:
	bl.d L_8d9134
L_8d9568:
	add_s r2,r14,0x4
L_8d956a:
	add2 r0,r15,0x1b
L_8d956e:
	mov_s r1,r13
L_8d9570:
	bl.d L_8d90a8
L_8d9574:
	add_s r2,r14,0x4
L_8d9576:
	sub r16,r16,0x1
L_8d957a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d957c:
	brhs.d r16,0x1,L_8d9540
L_8d9580:
	extb_s r13,r13
L_8d9582:
	b L_8c0244
L_8d9586:
	nop_s
