/* TX_INTERNAL_API__connection @ 0x8cb604, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FWQ Flush notify: flush pend musk[0x%x] MGMT_Q[%d] L2_Q[%d]
 *   TX_INTERNAL_API::connection is flushed (cid = %d)
 * Зовут его: notify_conn_flush_done
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_log_emit3, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_INTERNAL_API__connection
TX_INTERNAL_API__connection:
	.global L_8cb604
L_8cb604:
	push_s blink
L_8cb606:
	bl.d L_8c01dc
L_8cb60a:
	mov r4,0x1
L_8cb60e:
	mov_s r13,r0
L_8cb610:
	mov_s r15,0x842148
L_8cb616:
	mov_s r14,0x0
L_8cb618:
	ld_s r3,[r15,0x20]
L_8cb61a:
	bset r14,r14,r0
L_8cb61e:
	and_s r3,r3,r14
L_8cb620:
	cmp_s r3,0x0
L_8cb622:
	mov_s r3,0x1
L_8cb624:
	mov r16,0x842274
L_8cb62c:
	ld r0,[r16, 0x14]
L_8cb630:
	sub_s.ne r3,r3,r3
L_8cb632:
	and_s r0,r0,r14
L_8cb634:
	cmp_s r0,0x0
L_8cb636:
	sub.ne r4,r4,r4
L_8cb63a:
	mov_s r1,0x1018134
L_8cb640:
	mov_s r0,0x27
L_8cb642:
	bl.d L_8dcd00
L_8cb646:
	ld.as r2,[gp,-0x34]
L_8cb64a:
	ld_s r0,[gp,-0xd0]
L_8cb64c:
	tst_s r0,r14
L_8cb64e:
	beq_s L_8cb698
L_8cb650:
	ld_s r0,[r15,0x20]
L_8cb652:
	and_s r0,r0,r14
L_8cb654:
	cmp_s r0,0x0
L_8cb656:
	mov_s r0,0x1
L_8cb658:
	sub_s.ne r0,r0,r0
L_8cb65a:
	extb.f 0x0,r0
L_8cb65e:
	beq_s L_8cb698
L_8cb660:
	ld r0,[r16, 0x14]
L_8cb664:
	and_s r0,r0,r14
L_8cb666:
	cmp_s r0,0x0
L_8cb668:
	mov_s r0,0x1
L_8cb66a:
	sub_s.ne r0,r0,r0
L_8cb66c:
	extb.f 0x0,r0
L_8cb670:
	beq_s L_8cb698
L_8cb672:
	mov_s r1,0x1018170
L_8cb678:
	mov_s r0,0x27
L_8cb67a:
	bl.d L_8dcc10
L_8cb67e:
	mov_s r2,r13
L_8cb680:
	ld_s r0,[gp,-0xd0]
L_8cb682:
	mov_s r1,r13
L_8cb684:
	bic_s r0,r0,r14
L_8cb686:
	st.as r0,[gp,-0x34]
L_8cb68a:
	mov_s r0,0x33468
L_8cb690:
	mov_s r2,0x0
L_8cb692:
	bl.d L_8c3248
L_8cb696:
	mov_s r3,0x1
	.global L_8cb698
L_8cb698:
	b L_8c0244
