/* pcp_start__cancel_timer @ 0x8d53d8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__pcp_start_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__cancel
 */
	.section .text.pcp_start__cancel_timer,"ax",@progbits
	.global pcp_start__cancel_timer
pcp_start__cancel_timer:
	.global L_8d53d8
L_8d53d8:
	push_s blink
L_8d53da:
	bl L_8c02c4
L_8d53de:
	mov_s r14,r0
L_8d53e0:
	ld_s r0,[gp,-0x84]
L_8d53e2:
	mov_s r13,0x0
L_8d53e4:
	breq_s r0,0,L_8d53ee
L_8d53e6:
	bl L_8c7794
L_8d53ea:
	st.as r13,[gp,-0x21]
	.global L_8d53ee
L_8d53ee:
	add2 r0,gp,r14
L_8d53f2:
	st.as r13,[r0,-0x35]
L_8d53f6:
	mov_s r0,0x1
L_8d53f8:
	b.d L_8c0334
L_8d53fc:
	st.as r0,[gp,-0x20]
