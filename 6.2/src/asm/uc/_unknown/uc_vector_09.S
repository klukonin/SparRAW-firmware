/* uc_vector_09 @ 0x92085c, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l1_task__entry
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_vector_09
uc_vector_09:
	.global L_92085c
L_92085c:
	push_s r12
L_92085e:
	st.a mhi,[sp,-0x4]
L_920862:
	st.a mlo,[sp,-0x4]
L_920866:
	push_s r0
L_920868:
	push_s r1
L_92086a:
	push_s r2
L_92086c:
	push_s r3
L_92086e:
	st.a r4,[sp,-0x4]
L_920872:
	st.a r5,[sp,-0x4]
L_920876:
	st.a r6,[sp,-0x4]
L_92087a:
	st.a r7,[sp,-0x4]
L_92087e:
	st.a r8,[sp,-0x4]
L_920882:
	st.a r9,[sp,-0x4]
L_920886:
	st.a r10,[sp,-0x4]
L_92088a:
	st.a r11,[sp,-0x4]
L_92088e:
	st.a lp_count,[sp,-0x4]
L_920892:
	lr r12,[0x2]
L_920896:
	push_s r12
L_920898:
	lr r12,[0x3]
L_92089c:
	push_s r12
L_92089e:
	push_s blink
L_9208a0:
	bl.d L_92c974
L_9208a4:
	mov_s r0,0x1
L_9208a6:
	pop_s blink
L_9208a8:
	pop_s r12
L_9208aa:
	sr r12,[0x3]
L_9208ae:
	pop_s r12
L_9208b0:
	sr r12,[0x2]
L_9208b4:
	pop_s r12
L_9208b6:
	mov_s lp_count,r12
L_9208b8:
	ld.ab r11,[sp,0x4]
L_9208bc:
	ld.ab r10,[sp,0x4]
L_9208c0:
	ld.ab r9,[sp,0x4]
L_9208c4:
	ld.ab r8,[sp,0x4]
L_9208c8:
	ld.ab r7,[sp,0x4]
L_9208cc:
	ld.ab r6,[sp,0x4]
L_9208d0:
	ld.ab r5,[sp,0x4]
L_9208d4:
	ld.ab r4,[sp,0x4]
L_9208d8:
	pop_s r3
L_9208da:
	pop_s r2
L_9208dc:
	pop_s r1
L_9208de:
	pop_s r0
L_9208e0:
	pop_s r12
L_9208e2:
	mulu64 r12,0x1
L_9208e6:
	mov 0x0,mlo
L_9208ea:
	pop_s r12
L_9208ec:
	sr r12,[0x12]
L_9208f0:
	pop_s r12
L_9208f2:
	j.f [ilink1]
L_9208f6:
	nop_s
