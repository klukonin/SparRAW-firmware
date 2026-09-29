/* TX_INTERNAL_API__connection @ 0x8c95e8, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FWQ Flush notify: flush pend musk[0x%x] MGMT_Q[%d] L2_Q[%d]
 *   TX_INTERNAL_API::connection is flushed (cid = %d)
 * Зовут его: notify_conn_flush_done
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit3, u_schd__add
 */
	.section .text.TX_INTERNAL_API__connection,"ax",@progbits
	.global TX_INTERNAL_API__connection
TX_INTERNAL_API__connection:
	.global L_8c95e8
L_8c95e8:
	push_s blink
L_8c95ea:
	bl.d L_8c02bc
L_8c95ee:
	mov r4,0x1
L_8c95f2:
	mov_s r13,r0
L_8c95f4:
	mov_s r15,0x842404
L_8c95fa:
	mov_s r14,0x0
L_8c95fc:
	bset r14,r14,r0
L_8c9600:
	ld_s r0,[r15,0x20]
L_8c9602:
	mov r16,0x842530
L_8c960a:
	and_s r0,r0,r14
L_8c960c:
	cmp_s r0,0x0
L_8c960e:
	ld r0,[r16, 0x14]
L_8c9612:
	sub.ne r4,r4,r4
L_8c9616:
	and_s r0,r0,r14
L_8c9618:
	cmp_s r0,0x0
L_8c961a:
	mov r5,0x1
L_8c961e:
	sub.ne r5,r5,r5
L_8c9622:
	mov_s r2,0x1014c64
L_8c9628:
	mov_s r0,0x7
L_8c962a:
	mov_s r1,0x2
L_8c962c:
	bl.d L_8ee034
L_8c9630:
	ld.as r3,[gp,-0x30]
L_8c9634:
	ld_s r0,[gp,-0xc0]
L_8c9636:
	tst_s r0,r14
L_8c9638:
	beq_s L_8c9684
L_8c963a:
	ld_s r0,[r15,0x20]
L_8c963c:
	and_s r0,r0,r14
L_8c963e:
	cmp_s r0,0x0
L_8c9640:
	mov_s r0,0x1
L_8c9642:
	sub_s.ne r0,r0,r0
L_8c9644:
	extb.f 0x0,r0
L_8c9648:
	beq_s L_8c9684
L_8c964a:
	ld r0,[r16, 0x14]
L_8c964e:
	and_s r0,r0,r14
L_8c9650:
	cmp_s r0,0x0
L_8c9652:
	mov_s r0,0x1
L_8c9654:
	sub_s.ne r0,r0,r0
L_8c9656:
	extb.f 0x0,r0
L_8c965a:
	beq_s L_8c9684
L_8c965c:
	mov_s r2,0x1014ca0
L_8c9662:
	mov_s r0,0x7
L_8c9664:
	mov_s r1,0x2
L_8c9666:
	bl.d L_8edfcc
L_8c966a:
	mov_s r3,r13
L_8c966c:
	ld_s r0,[gp,-0xc0]
L_8c966e:
	mov_s r1,r13
L_8c9670:
	bic_s r0,r0,r14
L_8c9672:
	st.as r0,[gp,-0x30]
L_8c9676:
	mov_s r0,0x2bcac
L_8c967c:
	mov_s r2,0x0
L_8c967e:
	bl.d L_8c2ac8
L_8c9682:
	mov_s r3,0x1
	.global L_8c9684
L_8c9684:
	b L_8c0324
