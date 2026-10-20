/* aoa__validate_request @ 0x8e9680, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   num_of_dest not match capabilities , num_of_dest = %d
 *   num_of_aoa_measures not match capabilities , num_of_aoa_measures = %d
 *   burst_duration not match capabilities ,  burst_duration = %d
 *   burst_period not match capabilities ,  burst_period = %d
 *   initial_token not match capabilities , initial_token = %d
 *   num_of_bursts_exp not match capabilities , num_of_bursts_exp =  %d
 *   num_of_ftm_per_burst not match capabilities , num_of_ftm_per_burst =  %d
 *   asap not match capabilities , asap %d
 * Зовут его: l2_mgr__tof_ftm_req
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ftm__ctx_addr, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global aoa__validate_request
aoa__validate_request:
	.global L_8e9680
L_8e9680:
	push_s blink
L_8e9682:
	bl L_8c01e4
L_8e9686:
	bl.d L_8ccf04
L_8e968a:
	mov_s r13,r0
L_8e968c:
	add_s r0,r0,0x24
L_8e968e:
	ldw_s r2,[r13,0x6]
L_8e9690:
	ldb_s r1,[r0,0x1]
L_8e9692:
	breq r2,r1,L_8e969e
L_8e9696:
	mov_s r1,0x100e698
L_8e969c:
	b_s L_8e9704
	.global L_8e969e
L_8e969e:
	ldb_s r3,[r13,0x4]
L_8e96a0:
	ld_s r1,[r0,0xc]
L_8e96a2:
	breq r3,r1,L_8e96b2
L_8e96a6:
	mov_s r1,0x100e6d0
L_8e96ac:
	mov_s r0,0x2b
L_8e96ae:
	mov_s r2,r3
L_8e96b0:
	b_s L_8e9706
	.global L_8e96b2
L_8e96b2:
	brlt.d r2,0x1,L_8e96fa
L_8e96b6:
	mov_s r1,0x0
	.global L_8e96b8
L_8e96b8:
	asl_s r3,r1,0x4
L_8e96ba:
	add_s r3,r3,r13
L_8e96bc:
	ldb_s r2,[r3,0x11]
L_8e96be:
	ldw_s r14,[r0,0x6]
L_8e96c0:
	brne r2,r14,L_8e96fe
L_8e96c4:
	ldw_s r2,[r3,0x12]
L_8e96c6:
	ld_s r14,[r0,0x18]
L_8e96c8:
	brne r2,r14,L_8e9710
L_8e96cc:
	ldb_s r2,[r3,0xe]
L_8e96ce:
	ld_s r14,[r0,0x10]
L_8e96d0:
	brne r2,r14,L_8e9718
L_8e96d4:
	ldb_s r2,[r3,0x10]
L_8e96d6:
	ld_s r14,[r0,0x14]
L_8e96d8:
	brne r2,r14,L_8e9720
L_8e96dc:
	ldb_s r2,[r3,0xf]
L_8e96de:
	ldb_s r14,[r0,0x2]
L_8e96e0:
	brne r2,r14,L_8e9728
L_8e96e4:
	ldb_s r2,[r3,0xd]
L_8e96e6:
	bbit0 r2,0x1,L_8e9730
L_8e96ea:
	bbit1 r2,0x2,L_8e973e
L_8e96ee:
	bbit1 r2,0x3,L_8e974c
L_8e96f2:
	ldw_s r2,[r13,0x6]
L_8e96f4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e96f6:
	brlt r1,r2,L_8e96b8
	.global L_8e96fa
L_8e96fa:
	mov_s r0,0x1
L_8e96fc:
	b_s L_8e970c
	.global L_8e96fe
L_8e96fe:
	mov_s r1,0x100e718
	.global L_8e9704
L_8e9704:
	mov_s r0,0x2b
	.global L_8e9706
L_8e9706:
	bl L_8dcc10
L_8e970a:
	mov_s r0,0x0
	.global L_8e970c
L_8e970c:
	b L_8c0254
	.global L_8e9710
L_8e9710:
	mov_s r1,0x100e758
L_8e9716:
	b_s L_8e9704
	.global L_8e9718
L_8e9718:
	mov_s r1,0x100e794
L_8e971e:
	b_s L_8e9704
	.global L_8e9720
L_8e9720:
	mov_s r1,0x100e7d0
L_8e9726:
	b_s L_8e9704
	.global L_8e9728
L_8e9728:
	mov_s r1,0x100e814
L_8e972e:
	b_s L_8e9704
	.global L_8e9730
L_8e9730:
	mov_s r1,0x100e860
L_8e9736:
	mov_s r0,0x2b
L_8e9738:
	bic r2,r2,-0x3
L_8e973c:
	b_s L_8e9706
	.global L_8e973e
L_8e973e:
	mov_s r1,0x100e888
L_8e9744:
	mov_s r0,0x2b
L_8e9746:
	bic r2,r2,-0x5
L_8e974a:
	b_s L_8e9706
	.global L_8e974c
L_8e974c:
	mov_s r1,0x100e8b0
L_8e9752:
	mov_s r0,0x2b
L_8e9754:
	bic r2,r2,-0x9
L_8e9758:
	b_s L_8e9706
L_8e975a:
	nop_s
