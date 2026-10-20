/* uc_vector_10 @ 0x9205c4, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l2_task__entry
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_vector_10
uc_vector_10:
	.global L_9205c4
L_9205c4:
	push_s r12
L_9205c6:
	st.a mhi,[sp,-0x4]
L_9205ca:
	st.a mlo,[sp,-0x4]
L_9205ce:
	push_s r0
L_9205d0:
	push_s r1
L_9205d2:
	push_s r2
L_9205d4:
	push_s r3
L_9205d6:
	st.a r4,[sp,-0x4]
L_9205da:
	st.a r5,[sp,-0x4]
L_9205de:
	st.a r6,[sp,-0x4]
L_9205e2:
	st.a r7,[sp,-0x4]
L_9205e6:
	st.a r8,[sp,-0x4]
L_9205ea:
	st.a r9,[sp,-0x4]
L_9205ee:
	st.a r10,[sp,-0x4]
L_9205f2:
	st.a r11,[sp,-0x4]
L_9205f6:
	st.a lp_count,[sp,-0x4]
L_9205fa:
	lr r12,[0x2]
L_9205fe:
	push_s r12
L_920600:
	lr r12,[0x3]
L_920604:
	push_s r12
L_920606:
	push_s blink
L_920608:
	bl.d L_92d010
L_92060c:
	mov_s r0,0x1
L_92060e:
	pop_s blink
L_920610:
	pop_s r12
L_920612:
	sr r12,[0x3]
L_920616:
	pop_s r12
L_920618:
	sr r12,[0x2]
L_92061c:
	pop_s r12
L_92061e:
	mov_s lp_count,r12
L_920620:
	ld.ab r11,[sp,0x4]
L_920624:
	ld.ab r10,[sp,0x4]
L_920628:
	ld.ab r9,[sp,0x4]
L_92062c:
	ld.ab r8,[sp,0x4]
L_920630:
	ld.ab r7,[sp,0x4]
L_920634:
	ld.ab r6,[sp,0x4]
L_920638:
	ld.ab r5,[sp,0x4]
L_92063c:
	ld.ab r4,[sp,0x4]
L_920640:
	pop_s r3
L_920642:
	pop_s r2
L_920644:
	pop_s r1
L_920646:
	pop_s r0
L_920648:
	pop_s r12
L_92064a:
	mulu64 r12,0x1
L_92064e:
	mov 0x0,mlo
L_920652:
	pop_s r12
L_920654:
	sr r12,[0x12]
L_920658:
	pop_s r12
L_92065a:
	j.f [ilink2]
L_92065e:
	nop_s
