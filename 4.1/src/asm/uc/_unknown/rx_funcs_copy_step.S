/* rx_funcs_copy_step @ 0x937238, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report, rx_funcs__identify_peer
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_w_s0_w6_uc, bf_w_s6_w2_uc, memcpy_uc
 * Глобалы (через gp): 0x800568, 0x8005c8
 */
	.section .text.rx_funcs_copy_step,"ax",@progbits
	.global rx_funcs_copy_step
rx_funcs_copy_step:
	.global L_937238
L_937238:
	push_s blink
L_93723a:
	bl L_920214
L_93723e:
	mov_s r13,r1
L_937240:
	mov_s r3,0x804010
L_937246:
	ldw_s r1,[r3,0x12]
L_937248:
	mov_s r14,r0
L_93724a:
	bmsk_s r1,r1,0x1
L_93724c:
	mov_s r2,0x8010d0
L_937252:
	add r0,r2,0xc
L_937256:
	bl L_9379e8
L_93725a:
	ldw_s r1,[r3,0x10]
L_93725c:
	lsr_s r1,r1,0xa
L_93725e:
	bl L_937994
L_937262:
	ldb_s r0,[r3,0x13]
L_937264:
	add r1,r2,0xc
L_937268:
	bmsk_s r0,r0,0x5
L_93726a:
	st_s r0,[r14]
L_93726c:
	ldb_s r0,[r3,0x13]
L_93726e:
	lsr_s r0,r0,0x6
L_937270:
	st_s r0,[r13]
L_937272:
	mov_s r0,r2
L_937274:
	bl.d L_920310
L_937278:
	mov_s r2,0xc
L_93727a:
	ldw_s r0,[gp,0xa0]
L_93727c:
	mov_s r13,0x80086c
L_937282:
	breq_s r0,0,L_9372ca
L_937284:
	ld.as r14,[gp,0x10]
L_937288:
	mov_s r0,0x800fcc
L_93728e:
	mov_s r1,r14
L_937290:
	bl.d L_920310
L_937294:
	mov_s r2,0xc
L_937296:
	ld_s r1,[r14,0x8]
L_937298:
	mov_s r0,0x800fa0
L_93729e:
	st_s r1,[r0,0x8]
L_9372a0:
	ldb_s r1,[r13,0xd]
L_9372a2:
	brne_s r1,0,L_9372ac
L_9372a4:
	ldw_s r0,[r13,0x8]
L_9372a6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9372a8:
	stw_s r0,[r13,0x8]
L_9372aa:
	b_s L_9372c0
	.global L_9372ac
L_9372ac:
	cmp r1,0x80
L_9372b0:
	bge_s L_9372ba
L_9372b2:
	ld_s r0,[r13]
L_9372b4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9372b6:
	st_s r0,[r13]
L_9372b8:
	b_s L_9372c0
	.global L_9372ba
L_9372ba:
	ld_s r0,[r13,0x4]
L_9372bc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9372be:
	st_s r0,[r13,0x4]
	.global L_9372c0
L_9372c0:
	ldb_s r0,[r13,0xc]
L_9372c2:
	min r1,r0,r1
L_9372c6:
	stb_s r1,[r13,0xc]
L_9372c8:
	b_s L_9372d0
	.global L_9372ca
L_9372ca:
	ldw_s r0,[r13,0xa]
L_9372cc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9372ce:
	stw_s r0,[r13,0xa]
	.global L_9372d0
L_9372d0:
	mov_s r0,0x0
L_9372d2:
	b.d L_920284
L_9372d6:
	stw.as r0,[gp,0x50]
L_9372da:
	nop_s
