/* low_sme__handle_rf_kill @ 0x8cb4fc, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   low_sme::handle_rf_kill(is_graceful=%d)
 *   Setting m_termination_events[DISCONNECT]=1, m_termination_events=0x%x
 *   Setting m_termination_events[SCAN_ABORT]=1, m_termination_events=0x%x
 *   Setting m_termination_events[PCP_STOP]=2, m_termination_events=0x%x
 * Зовут его: rf_kill_sm__on_w_disable__enabled
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, l2_mgr__pcp_stop, l2_mgr__scan_abort, l2mgr__wmi_disconnect_log, mid__state_is_2_or_3, mid_list__by_mid
 * Глобалы (через gp): 0x800170
 */
	.section .text.low_sme__handle_rf_kill,"ax",@progbits
	.global low_sme__handle_rf_kill
low_sme__handle_rf_kill:
	.global L_8cb4fc
L_8cb4fc:
	push_s blink
L_8cb4fe:
	bl.d L_8c02c0
L_8cb502:
	mov_s r1,0x2
L_8cb504:
	mov_s r15,r0
L_8cb506:
	mov_s r2,0x100a2d4
L_8cb50c:
	mov_s r13,0x0
L_8cb50e:
	mov_s r0,r13
L_8cb510:
	bl.d L_8edfcc
L_8cb514:
	mov_s r3,r15
L_8cb516:
	ld_s r0,[gp,0x0]
L_8cb518:
	mov_s r2,0x100a2fc
L_8cb51e:
	bset r3,r0,0x0
L_8cb522:
	st.as r3,[gp,0x0]
L_8cb526:
	mov_s r0,r13
L_8cb528:
	bl.d L_8edfcc
L_8cb52c:
	mov_s r1,0x2
L_8cb52e:
	bl.d L_8eb448
L_8cb532:
	mov_s r0,r15
L_8cb534:
	ld_s r0,[gp,0x0]
L_8cb536:
	mov_s r2,0x100a344
L_8cb53c:
	bset r3,r0,0x1
L_8cb540:
	st.as r3,[gp,0x0]
L_8cb544:
	mov_s r0,r13
L_8cb546:
	bl.d L_8edfcc
L_8cb54a:
	mov_s r1,0x2
L_8cb54c:
	bl L_8efed8
L_8cb550:
	b_s L_8cb586
	.global L_8cb552
L_8cb552:
	bl.d L_8ca1b0
L_8cb556:
	mov_s r0,r13
L_8cb558:
	mov.f r14,r0
L_8cb55c:
	beq_s L_8cb584
L_8cb55e:
	bl.d L_8d73c4
L_8cb562:
	ldb_s r0,[r14,0x10]
L_8cb564:
	breq_s r0,0,L_8cb584
L_8cb566:
	ld_s r0,[gp,0x0]
L_8cb568:
	mov_s r2,0x100a38c
L_8cb56e:
	bset r3,r0,0x2
L_8cb572:
	st.as r3,[gp,0x0]
L_8cb576:
	mov_s r0,0x0
L_8cb578:
	bl.d L_8edfcc
L_8cb57c:
	mov_s r1,0x2
L_8cb57e:
	bl.d L_8eef70
L_8cb582:
	ldb_s r0,[r14,0x10]
	.global L_8cb584
L_8cb584:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8cb586
L_8cb586:
	brlt r13,0x1,L_8cb552
L_8cb58a:
	b L_8c032c
L_8cb58e:
	nop_s
