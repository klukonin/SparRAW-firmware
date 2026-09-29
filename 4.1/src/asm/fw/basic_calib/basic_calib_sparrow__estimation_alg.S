/* basic_calib_sparrow__estimation_alg @ 0x8c85d0, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_calib_sparrow::estimation_alg correction NEEDED - BB temperature
 *   basic_calib_sparrow::estimation_alg correction NEEDED - RF temperature
 *   basic_calib_sparrow::estimation_alg correction NEEDED - ONLINE Estimation
 *   basic_calib.cpp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.basic_calib_sparrow__estimation_alg,"ax",@progbits
	.global basic_calib_sparrow__estimation_alg
basic_calib_sparrow__estimation_alg:
	.byte 0xcf
	.byte 0xfb
	.global fwlog_basic_calib_sparrow_estimation_alg_corre
fwlog_basic_calib_sparrow_estimation_alg_corre:
L_8c85d2:
	nop_s
L_8c85d4:
	sub_s sp,sp,0x4
L_8c85d6:
	push_s blink
L_8c85d8:
	bl L_8c02bc
L_8c85dc:
	mov_s r14,r1
L_8c85de:
	mov_s r13,r0
L_8c85e0:
	mov r0,-0x1
L_8c85e4:
	st.a r0,[sp,-0x8]
L_8c85e8:
	st_s r0,[sp,0x4]
L_8c85ea:
	ld_s r0,[r13,0x8]
L_8c85ec:
	add_s r2,sp,0x4
L_8c85ee:
	ld_s r3,[r0,0x2c]
L_8c85f0:
	mov_s r1,sp
L_8c85f2:
	jl_s.d [r3]
L_8c85f4:
	mov_s r0,r13
L_8c85f6:
	btst_s r14,0x0
L_8c85f8:
	btst.eq r14,0x1
L_8c85fc:
	btst.eq r14,0x2
L_8c8600:
	beq_s L_8c8696
L_8c8602:
	btst_s r14,0x0
L_8c8604:
	mov.eq r16,0x0
L_8c8608:
	beq_s L_8c8630
L_8c860a:
	lsr r1,r14,0x4
L_8c860e:
	ld_s r0,[r13,0x8]
L_8c8610:
	sexb_s r1,r1
L_8c8612:
	ld_s r15,[r0,0x14]
L_8c8614:
	mov_s r0,r13
L_8c8616:
	ld_s r2,[sp,0x0]
L_8c8618:
	jl_s.d [r15]
L_8c861a:
	mov_s r3,r13
L_8c861c:
	mov.f r16,r0
L_8c8620:
	beq_s L_8c8630
L_8c8622:
	mov_s r2,0x1008ad4
L_8c8628:
	mov_s r0,0x6
L_8c862a:
	bl.d L_8edfb0
L_8c862e:
	mov_s r1,0x2
	.global L_8c8630
L_8c8630:
	mov_s r15,0x0
L_8c8632:
	bbit0 r14,0x1,L_8c865c
L_8c8636:
	lsr r1,r14,0xc
L_8c863a:
	sexb_s r1,r1
L_8c863c:
	ld_s r0,[r13,0x8]
L_8c863e:
	add_s r3,r13,0x4
L_8c8640:
	ld_s r15,[r0,0x14]
L_8c8642:
	mov_s r0,r13
L_8c8644:
	jl_s.d [r15]
L_8c8646:
	ld_s r2,[sp,0x4]
L_8c8648:
	mov.f r15,r0
L_8c864c:
	beq_s L_8c865c
L_8c864e:
	mov_s r2,0x1008b1c
L_8c8654:
	mov_s r0,0x6
L_8c8656:
	bl.d L_8edfb0
L_8c865a:
	mov_s r1,0x2
	.global L_8c865c
L_8c865c:
	btst_s r14,0x2
L_8c865e:
	mov.eq r14,0x0
L_8c8662:
	beq_s L_8c8680
L_8c8664:
	ld_s r0,[r13,0x8]
L_8c8666:
	ld_s r1,[r0,0x28]
L_8c8668:
	jl_s.d [r1]
L_8c866a:
	mov_s r0,r13
L_8c866c:
	mov.f r14,r0
L_8c8670:
	beq_s L_8c8680
L_8c8672:
	mov_s r2,0x1008b64
L_8c8678:
	mov_s r0,0x6
L_8c867a:
	bl.d L_8edfb0
L_8c867e:
	mov_s r1,0x2
	.global L_8c8680
L_8c8680:
	mov_s r0,0x0
L_8c8682:
	cmp r16,0x0
L_8c8686:
	cmp.eq r15,0x0
L_8c868a:
	cmp.eq r14,0x0
L_8c868e:
	beq_s L_8c8692
L_8c8690:
	mov_s r0,0x1
	.global L_8c8692
L_8c8692:
	extb_s r0,r0
L_8c8694:
	b_s L_8c8698
	.global L_8c8696
L_8c8696:
	mov_s r0,0x1
	.global L_8c8698
L_8c8698:
	brne r0,0x1,L_8c86d2
L_8c869c:
	ld_s r0,[sp,0x0]
L_8c869e:
	st_s r0,[r13]
L_8c86a0:
	ld_s r0,[sp,0x4]
L_8c86a2:
	st_s r0,[r13,0x4]
L_8c86a4:
	ld_s r0,[r13,0x8]
L_8c86a6:
	ld_s r1,[r0,0x24]
L_8c86a8:
	jl_s.d [r1]
L_8c86aa:
	mov_s r0,r13
L_8c86ac:
	breq_s r0,0,L_8c86ca
L_8c86ae:
	breq r0,0x1,L_8c86ce
L_8c86b2:
	mov_s r0,blink
L_8c86b4:
	mov_s r2,0x1008ac4
L_8c86ba:
	mov_s r1,0x12e7
L_8c86c0:
	bl.d L_8c82c0
L_8c86c4:
	mov_s r3,0x83
L_8c86c6:
	mov_s r0,0x0
L_8c86c8:
	b_s L_8c86d4
	.global L_8c86ca
L_8c86ca:
	mov_s r0,0x2
L_8c86cc:
	b_s L_8c86d4
	.global L_8c86ce
L_8c86ce:
	mov_s r0,0x3
L_8c86d0:
	b_s L_8c86d4
	.global L_8c86d2
L_8c86d2:
	mov_s r0,0x1
	.global L_8c86d4
L_8c86d4:
	mov_s r12,0x8
L_8c86d6:
	b.d L_8c0326
L_8c86da:
	add_s sp,sp,0x8
