/* tx_macq_api_step @ 0x8d986c, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_pools
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, tx_macq__config_ring_params, tx_macq__setup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_macq_api_step
tx_macq_api_step:
	.global L_8d986c
L_8d986c:
	push_s blink
L_8d986e:
	bl.d L_8c01e4
L_8d9872:
	mov_s r0,0x1e
L_8d9874:
	mov_s r13,0x806214
L_8d987a:
	stb r0,[r13, -0x16]
L_8d987e:
	sub r0,r13,0x20
L_8d9882:
	mov r1,0x1ca
L_8d9886:
	mov_s r2,0x8
L_8d9888:
	mov_s r3,0x50aa
L_8d988e:
	mov r4,0x8a
L_8d9892:
	bl.d L_8e29b8
L_8d9896:
	mov r5,0x200
L_8d989a:
	mov_s r14,0x8031e8
L_8d98a0:
	ldb_s r3,[r14,0x1d]
L_8d98a2:
	mov_s r2,0x1
L_8d98a4:
	cmp_s r3,0x0
L_8d98a6:
	sub_s.ne r2,r2,r2
L_8d98a8:
	cmp_s r3,0x1
L_8d98aa:
	mov_s r3,0x1
L_8d98ac:
	sub_s.ne r3,r3,r3
L_8d98ae:
	sub r0,r13,0x20
L_8d98b2:
	mov_s r1,0x9
L_8d98b4:
	mov r4,0x7
L_8d98b8:
	mov r5,0x0
L_8d98bc:
	mov r6,r5
L_8d98c0:
	bl.d L_8d944c
L_8d98c4:
	mov r7,r5
L_8d98c8:
	mov_s r0,0x1a
L_8d98ca:
	stb r0,[r13, -0x56]
L_8d98ce:
	sub3 r0,r13,0xc
L_8d98d2:
	mov r1,0x1c2
L_8d98d6:
	mov_s r2,0x8
L_8d98d8:
	mov_s r3,0x5
L_8d98da:
	asl_s r3,r3,0xc
L_8d98dc:
	mov r4,0xaa
L_8d98e0:
	bl.d L_8e29b8
L_8d98e4:
	mov r5,0x500
L_8d98e8:
	ldb_s r3,[r14,0x15]
L_8d98ea:
	mov_s r2,0x1
L_8d98ec:
	cmp_s r3,0x0
L_8d98ee:
	sub_s.ne r2,r2,r2
L_8d98f0:
	cmp_s r3,0x1
L_8d98f2:
	mov_s r3,0x1
L_8d98f4:
	sub_s.ne r3,r3,r3
L_8d98f6:
	sub3 r0,r13,0xc
L_8d98fa:
	mov_s r1,0x8
L_8d98fc:
	mov r4,0x7
L_8d9900:
	mov r5,0x0
L_8d9904:
	mov r6,r5
L_8d9908:
	bl.d L_8d944c
L_8d990c:
	mov r7,r5
L_8d9910:
	b L_8c0254
