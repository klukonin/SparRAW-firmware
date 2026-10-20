/* ps_conn_mgr__report_psc_transitions @ 0x8c3614, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_conn_mgr__dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, g_dbg_psc_transition
 */
	.section .text.ps_conn_mgr__report_psc_transitions,"ax",@progbits
	.global ps_conn_mgr__report_psc_transitions
ps_conn_mgr__report_psc_transitions:
L_8c3614:
	mov_s r1,0x2
	.global sub_8c3616
sub_8c3616:
L_8c3616:
	nop_s
	.global L_8c3618
L_8c3618:
	push_s blink
L_8c361a:
	bl L_8c02c4
L_8c361e:
	ldb_s r1,[r0,0x1]
L_8c3620:
	ldb_s r13,[r0,0x2]
L_8c3622:
	or_s r13,r13,r1
L_8c3624:
	ldb r14,[gp, 0xec]
L_8c3628:
	b_s L_8c3650
	.global L_8c362a
L_8c362a:
	norm r0,r14
L_8c362e:
	rsub r2,r0,0x1e
L_8c3632:
	extb_s r2,r2
L_8c3634:
	mul64 r2,0xf4
L_8c3638:
	bclr r14,r14,r2
L_8c363c:
	asr r1,r13,r2
L_8c3640:
	extb_s r14,r14
L_8c3642:
	add r0,mlo,0x80361c
L_8c364a:
	bl.d L_8c3560
L_8c364e:
	bmsk_s r1,r1,0x0
	.global L_8c3650
L_8c3650:
	brne_s r14,0,L_8c362a
L_8c3652:
	b L_8c0334
L_8c3656:
	nop_s
