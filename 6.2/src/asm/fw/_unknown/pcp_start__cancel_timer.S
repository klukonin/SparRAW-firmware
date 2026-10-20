/* pcp_start__cancel_timer @ 0x8d8750, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__pcp_start_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_start__cancel_timer
pcp_start__cancel_timer:
	.global L_8d8750
L_8d8750:
	push_s blink
L_8d8752:
	bl L_8c01e4
L_8d8756:
	mov_s r14,r0
L_8d8758:
	ld_s r0,[gp,-0x98]
L_8d875a:
	mov_s r13,0x0
L_8d875c:
	breq_s r0,0,L_8d8766
L_8d875e:
	bl L_8c8de0
L_8d8762:
	st.as r13,[gp,-0x26]
	.global L_8d8766
L_8d8766:
	add2 r0,gp,r14
L_8d876a:
	st.as r13,[r0,-0x39]
L_8d876e:
	mov_s r0,0x1
L_8d8770:
	b.d L_8c0254
L_8d8774:
	st.as r0,[gp,-0x25]
