/* uc_vector_03 @ 0x92b89c, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l1_task__entry
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_vector_03
uc_vector_03:
	.global L_92b89c
L_92b89c:
	push_s r12
L_92b89e:
	st.a mhi,[sp,-0x4]
L_92b8a2:
	st.a mlo,[sp,-0x4]
L_92b8a6:
	push_s r0
L_92b8a8:
	push_s r1
L_92b8aa:
	push_s r2
L_92b8ac:
	push_s r3
L_92b8ae:
	st.a r4,[sp,-0x4]
L_92b8b2:
	st.a r5,[sp,-0x4]
L_92b8b6:
	st.a r6,[sp,-0x4]
L_92b8ba:
	st.a r7,[sp,-0x4]
L_92b8be:
	st.a r8,[sp,-0x4]
L_92b8c2:
	st.a r9,[sp,-0x4]
L_92b8c6:
	st.a r10,[sp,-0x4]
L_92b8ca:
	st.a r11,[sp,-0x4]
L_92b8ce:
	st.a lp_count,[sp,-0x4]
L_92b8d2:
	lr r12,[0x2]
L_92b8d6:
	push_s r12
L_92b8d8:
	lr r12,[0x3]
L_92b8dc:
	push_s r12
L_92b8de:
	push_s blink
L_92b8e0:
	bl.d L_92c974
L_92b8e4:
	mov_s r0,0x3
L_92b8e6:
	pop_s blink
L_92b8e8:
	pop_s r12
L_92b8ea:
	sr r12,[0x3]
L_92b8ee:
	pop_s r12
L_92b8f0:
	sr r12,[0x2]
L_92b8f4:
	pop_s r12
L_92b8f6:
	mov_s lp_count,r12
L_92b8f8:
	ld.ab r11,[sp,0x4]
L_92b8fc:
	ld.ab r10,[sp,0x4]
L_92b900:
	ld.ab r9,[sp,0x4]
L_92b904:
	ld.ab r8,[sp,0x4]
L_92b908:
	ld.ab r7,[sp,0x4]
L_92b90c:
	ld.ab r6,[sp,0x4]
L_92b910:
	ld.ab r5,[sp,0x4]
L_92b914:
	ld.ab r4,[sp,0x4]
L_92b918:
	pop_s r3
L_92b91a:
	pop_s r2
L_92b91c:
	pop_s r1
L_92b91e:
	pop_s r0
L_92b920:
	pop_s r12
L_92b922:
	mulu64 r12,0x1
L_92b926:
	mov 0x0,mlo
L_92b92a:
	pop_s r12
L_92b92c:
	sr r12,[0x12]
L_92b930:
	pop_s r12
L_92b932:
	j.f [ilink1]
L_92b936:
	nop_s
