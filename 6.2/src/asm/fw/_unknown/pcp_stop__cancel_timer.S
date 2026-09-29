/* pcp_stop__cancel_timer @ 0x8d8778, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcp_stop__flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_stop__cancel_timer
pcp_stop__cancel_timer:
	.global L_8d8778
L_8d8778:
	push_s blink
L_8d877a:
	bl L_8c01e4
L_8d877e:
	mov_s r14,r0
L_8d8780:
	ld_s r0,[gp,-0x98]
L_8d8782:
	mov_s r13,0x0
L_8d8784:
	breq_s r0,0,L_8d878e
L_8d8786:
	bl L_8c8de0
L_8d878a:
	st.as r13,[gp,-0x26]
	.global L_8d878e
L_8d878e:
	add2 r0,gp,r14
L_8d8792:
	st.as r13,[r0,-0x39]
L_8d8796:
	b.d L_8c0254
L_8d879a:
	st.as r13,[gp,-0x25]
L_8d879e:
	nop_s
