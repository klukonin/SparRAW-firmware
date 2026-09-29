/* calib_engine__on_calib_done @ 0x8c562c, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r17_to_r13_ret, __st_r17_to_r13, calib_cfg__get_scheme, calib_mngr__engine_step, calib_mngr__schedule_scheme_step, fw_sysassert_fatal
 * Глобалы (через gp): 0x800252
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__on_calib_done
calib_engine__on_calib_done:
	.global L_8c562c
L_8c562c:
	push_s blink
L_8c562e:
	ld_s r2,[r0,0x2c]
L_8c5630:
	mov_s r1,r0
L_8c5632:
	breq_s r2,0,L_8c563a
L_8c5634:
	ld_s r0,[r1,0x30]
L_8c5636:
	jl_s.d [r2]
L_8c5638:
	ld_s r1,[r1,0x34]
	.global L_8c563a
L_8c563a:
	pop_s blink
L_8c563c:
	j_s [blink]
L_8c563e:
	nop_s
L_8c5640:
	push_s blink
L_8c5642:
	push_s r13
L_8c5644:
	brhs.d r0,0x6,L_8c5672
L_8c5648:
	mov_s r13,r0
	.global L_8c564a
L_8c564a:
	mov_s r0,0x804924
L_8c5650:
	ldb_s r0,[r0,r13]
L_8c5652:
	breq_s r0,0,L_8c566e
L_8c5654:
	ldb_s r0,[gp,0xce]
L_8c5656:
	bl.d L_8cc6bc
L_8c565a:
	ld.as r1,[gp,-0x5]
L_8c565e:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c5660:
	asl_s r1,r13,0x2
L_8c5662:
	add1_s r1,r1,r1
L_8c5664:
	add_s r1,r1,r0
L_8c5666:
	mov_s r0,r13
L_8c5668:
	bl.d L_8e498c
L_8c566c:
	mov_s r2,0x0
	.global L_8c566e
L_8c566e:
	b L_8c025c
	.global L_8c5672
L_8c5672:
	mov_s r0,blink
L_8c5674:
	mov_s r1,0x95
L_8c5676:
	bl.d L_8c9b28
L_8c567a:
	bset_s r1,r1,0xc
L_8c567c:
	b_s L_8c564a
L_8c567e:
	nop_s
L_8c5680:
	push_s blink
L_8c5682:
	bl L_8c01d8
L_8c5686:
	brhs.d r0,0x6,L_8c56f0
L_8c568a:
	mov_s r16,r0
	.global L_8c568c
L_8c568c:
	mov r17,0x0
L_8c5690:
	mov_s r0,0x804924
L_8c5696:
	add2 r0,r0,r16
L_8c569a:
	st r17,[r0, 0x8]
L_8c569e:
	ldb_s r0,[gp,0xce]
L_8c56a0:
	bl.d L_8cc6bc
L_8c56a4:
	ld.as r1,[gp,-0x5]
L_8c56a8:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c56aa:
	asl r1,r16,0x2
L_8c56ae:
	add1_s r1,r1,r1
L_8c56b0:
	add_s r1,r1,r0
L_8c56b2:
	mul64 r16,0x44
L_8c56b6:
	add r0,mlo,0x804944
L_8c56be:
	ldb_s r2,[r0]
L_8c56c0:
	cmp_s r2,0x0
L_8c56c2:
	mov_s r2,0x1
L_8c56c4:
	sub_s.ne r2,r2,r2
L_8c56c6:
	extb.f 0x0,r2
L_8c56ca:
	beq_s L_8c56fc
L_8c56cc:
	ld_s r3,[r1]
L_8c56ce:
	ldw r4,[r1, 0xa]
L_8c56d2:
	lsr_s r3,r3
L_8c56d4:
	extb_s r3,r3
L_8c56d6:
	mov r5,0x5640
L_8c56de:
	ld_s r1,[r1,0x4]
L_8c56e0:
	mov_s r2,0x1
L_8c56e2:
	mov r6,r16
L_8c56e6:
	bl.d L_8e79c0
L_8c56ea:
	mov r7,r17
L_8c56ee:
	b_s L_8c5704
	.global L_8c56f0
L_8c56f0:
	mov_s r0,blink
L_8c56f2:
	mov_s r1,0x94
L_8c56f4:
	bl.d L_8c9b28
L_8c56f8:
	bset_s r1,r1,0xc
L_8c56fa:
	b_s L_8c568c
	.global L_8c56fc
L_8c56fc:
	mov_s r0,r16
L_8c56fe:
	bl.d L_8e498c
L_8c5702:
	mov_s r2,r17
	.global L_8c5704
L_8c5704:
	b L_8c023c
