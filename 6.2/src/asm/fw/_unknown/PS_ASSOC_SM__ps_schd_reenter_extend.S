/* PS_ASSOC_SM__ps_schd_reenter_extend @ 0x8e1598, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_ASSOC_SM::ps_schd_reenter_extend handle: 0x%x
 * Зовёт сам: PS_ASSOC_SM__ps_cancel_schd_reenter, __ld_r13_to_r13_ret, fw_log_emit1, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global PS_ASSOC_SM__ps_schd_reenter_extend
PS_ASSOC_SM__ps_schd_reenter_extend:
	.global L_8e1598
L_8e1598:
	push_s blink
L_8e159a:
	mov_s r1,r0
L_8e159c:
	mov_s r0,0x21544
L_8e15a2:
	ld.as r4,[gp,-0x16]
L_8e15a6:
	mov_s r2,0x0
L_8e15a8:
	mov_s r3,0x1
L_8e15aa:
	mov_s r5,r2
L_8e15ac:
	bl.d L_8e0c0c
L_8e15b0:
	mov_s r6,r2
L_8e15b2:
	st.as r0,[gp,-0x18]
L_8e15b6:
	pop_s blink
L_8e15b8:
	j_s [blink]
L_8e15ba:
	nop_s
L_8e15bc:
	push_s blink
L_8e15be:
	push_s r13
L_8e15c0:
	mov_s r13,r0
L_8e15c2:
	ldb_s r0,[r0]
L_8e15c4:
	brne r0,0x3,L_8e15f8
L_8e15c8:
	bl.d L_8e12e4
L_8e15cc:
	mov_s r0,r13
L_8e15ce:
	mov_s r0,0x21514
L_8e15d4:
	ld.as r4,[gp,-0x15]
L_8e15d8:
	mov_s r1,r13
L_8e15da:
	mov_s r2,0x0
L_8e15dc:
	mov_s r3,0x1
L_8e15de:
	mov_s r5,r2
L_8e15e0:
	bl.d L_8e0c0c
L_8e15e4:
	mov_s r6,r2
L_8e15e6:
	mov_s r2,r0
L_8e15e8:
	st.as r0,[gp,-0x17]
L_8e15ec:
	mov_s r1,0x100242c
L_8e15f2:
	bl.d L_8dcc10
L_8e15f6:
	mov_s r0,0x2e
	.global L_8e15f8
L_8e15f8:
	b L_8c025c
