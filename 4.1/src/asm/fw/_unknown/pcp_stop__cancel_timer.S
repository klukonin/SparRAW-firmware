/* pcp_stop__cancel_timer @ 0x8d5400, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcp_stop__flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__cancel
 */
	.section .text.pcp_stop__cancel_timer,"ax",@progbits
	.global pcp_stop__cancel_timer
pcp_stop__cancel_timer:
	.global L_8d5400
L_8d5400:
	push_s blink
L_8d5402:
	bl L_8c02c4
L_8d5406:
	mov_s r14,r0
L_8d5408:
	ld_s r0,[gp,-0x84]
L_8d540a:
	mov_s r13,0x0
L_8d540c:
	breq_s r0,0,L_8d5416
L_8d540e:
	bl L_8c7794
L_8d5412:
	st.as r13,[gp,-0x21]
	.global L_8d5416
L_8d5416:
	add2 r0,gp,r14
L_8d541a:
	st.as r13,[r0,-0x35]
L_8d541e:
	b.d L_8c0334
L_8d5422:
	st.as r13,[gp,-0x20]
L_8d5426:
	nop_s
