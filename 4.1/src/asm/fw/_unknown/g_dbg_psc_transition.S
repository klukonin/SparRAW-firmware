/* g_dbg_psc_transition @ 0x8c3560, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   g_dbg_psc_transition INCREASE_PS
 *   g_dbg_psc_transition DECREASE_PS
 * Зовут его: ps_conn_mgr__report_psc_transitions
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit0
 * Глобалы (через gp): 0x800250, 0x800251, 0x80030c, 0x800310
 */
	.section .text.g_dbg_psc_transition,"ax",@progbits
	.global g_dbg_psc_transition
g_dbg_psc_transition:
	.global L_8c3560
L_8c3560:
	push_s blink
L_8c3562:
	bl L_8c02c4
L_8c3566:
	mov_s r13,r0
L_8c3568:
	mov_s r0,r1
L_8c356a:
	ld.as r1,[gp,0x67]
L_8c356e:
	breq_s r1,0,L_8c35b6
L_8c3570:
	ld_s r0,[gp,0x1a0]
L_8c3572:
	breq r0,0x0,L_8c3600
L_8c3576:
	mov_s r14,0x0
L_8c3578:
	brne r0,0x1,L_8c3590
L_8c357c:
	mov_s r2,0x1002930
L_8c3582:
	mov_s r0,0xe
L_8c3584:
	bl.d L_8edfb0
L_8c3588:
	mov_s r1,0x2
L_8c358a:
	add_s r0,r13,0x4
L_8c358c:
	mov_s r1,0x0
L_8c358e:
	b_s L_8c35a6
	.global L_8c3590
L_8c3590:
	brne r0,0x2,L_8c35b0
L_8c3594:
	mov_s r2,0x1002954
L_8c359a:
	mov_s r0,0xe
L_8c359c:
	bl.d L_8edfb0
L_8c35a0:
	mov_s r1,0x2
L_8c35a2:
	add_s r0,r13,0x4
L_8c35a4:
	mov_s r1,0x1
	.global L_8c35a6
L_8c35a6:
	mov_s r2,0x0
L_8c35a8:
	mov_s r3,r2
L_8c35aa:
	bl.d L_8d6a1c
L_8c35ae:
	mov_s r4,r2
	.global L_8c35b0
L_8c35b0:
	st.as r14,[gp,0x68]
L_8c35b4:
	b_s L_8c3600
	.global L_8c35b6
L_8c35b6:
	ld_s r1,[r13]
L_8c35b8:
	breq_s r1,0,L_8c3600
L_8c35ba:
	mov_s r1,0x0
L_8c35bc:
	add r3,r13,0x20
L_8c35c0:
	breq_s r0,0,L_8c35de
L_8c35c2:
	ldb_s r2,[r3,0x18]
L_8c35c4:
	ldb_s r0,[gp,0xe1]
L_8c35c6:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c35c8:
	extb_s r2,r2
L_8c35ca:
	stb_s r2,[r3,0x18]
L_8c35cc:
	brlt.d r2,r0,L_8c3600
L_8c35d0:
	stb_s r1,[r3,0x19]
L_8c35d2:
	add_s r0,r13,0x4
L_8c35d4:
	ldb_s r1,[r0]
L_8c35d6:
	brne r1,0x4,L_8c3600
L_8c35da:
	mov_s r1,0x1
L_8c35dc:
	b_s L_8c35f6
	.global L_8c35de
L_8c35de:
	ldb_s r2,[r3,0x19]
L_8c35e0:
	stb_s r1,[r3,0x18]
L_8c35e2:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c35e4:
	ldb_s r0,[gp,0xe0]
L_8c35e6:
	extb_s r2,r2
L_8c35e8:
	brlt.d r2,r0,L_8c3600
L_8c35ec:
	stb_s r2,[r3,0x19]
L_8c35ee:
	add_s r0,r13,0x4
L_8c35f0:
	ldb_s r2,[r0]
L_8c35f2:
	brne r2,0x2,L_8c3600
	.global L_8c35f6
L_8c35f6:
	mov_s r2,0x0
L_8c35f8:
	mov_s r3,r2
L_8c35fa:
	bl.d L_8d6a1c
L_8c35fe:
	mov_s r4,r2
	.global L_8c3600
L_8c3600:
	b L_8c0334
