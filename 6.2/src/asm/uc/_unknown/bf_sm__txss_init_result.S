/* bf_sm__txss_init_result @ 0x93b840, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf__enter_mode3, bf__store_flow_status, bf_sm__set_state, internal_tx__check_idle, uc_sysassert
 * Глобалы (через gp): 0x8005fc, 0x8005fd, 0x8005fe
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__txss_init_result
bf_sm__txss_init_result:
	.global L_93b840
L_93b840:
	push_s blink
L_93b842:
	bl L_920234
L_93b846:
	mov_s r14,r0
L_93b848:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93b84a:
	mov_s r1,0x802000
L_93b850:
	add2_s r0,r0,r0
L_93b852:
	ld_s r1,[r1,r0]
L_93b854:
	brhs.d r1,0x9,L_93b8b2
L_93b858:
	mov_s r13,0x0
L_93b85a:
	ldb.x r1,[0x801830,r1]
L_93b862:
	add r0,pcl,0xa
L_93b866:
	add1_s r0,r0,r1
L_93b868:
	j_s [r0]
L_93b86a:
	mov_s r0,r14
L_93b86c:
	bl.d L_92af2c
L_93b870:
	mov_s r1,0x3
L_93b872:
	mov_s r0,0x3
L_93b874:
	bl.d L_920cb8
L_93b878:
	mov_s r1,r14
L_93b87a:
	b_s L_93b8ba
L_93b87c:
	ldb_s r0,[gp,0xd4]
L_93b87e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93b880:
	extb_s r0,r0
L_93b882:
	brlt.d r0,0x4,L_93b8ba
L_93b886:
	stb r0,[gp, 0xd4]
L_93b88a:
	b_s L_93b8aa
L_93b88c:
	ldb_s r0,[gp,0xd5]
L_93b88e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93b890:
	extb_s r0,r0
L_93b892:
	brlt.d r0,0x4,L_93b8ba
L_93b896:
	stb r0,[gp, 0xd5]
L_93b89a:
	b_s L_93b8aa
L_93b89c:
	ldb_s r0,[gp,0xd6]
L_93b89e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93b8a0:
	extb_s r0,r0
L_93b8a2:
	brlt.d r0,0x4,L_93b8ba
L_93b8a6:
	stb r0,[gp, 0xd6]
	.global L_93b8aa
L_93b8aa:
	mov_s r13,0x2
L_93b8ac:
	b_s L_93b8ba
L_93b8ae:
	mov_s r13,0x1
L_93b8b0:
	b_s L_93b8ba
	.global L_93b8b2
L_93b8b2:
	mov_s r0,blink
L_93b8b4:
	bl.d L_926618
L_93b8b8:
	mov_s r1,0x19
	.global L_93b8ba
L_93b8ba:
	brne_s r13,0,L_93b8ca
L_93b8bc:
	bl.d L_92bd30
L_93b8c0:
	mov_s r0,0x3
L_93b8c2:
	mov_s r0,r14
L_93b8c4:
	bl.d L_9357cc
L_93b8c8:
	mov_s r1,0x0
	.global L_93b8ca
L_93b8ca:
	b.d L_9202a4
L_93b8ce:
	mov_s r0,r13
