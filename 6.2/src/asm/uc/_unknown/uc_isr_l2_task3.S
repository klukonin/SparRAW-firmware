/* uc_isr_l2_task3 @ 0x92b938, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l2_task__entry
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_isr_l2_task3
uc_isr_l2_task3:
	.global L_92b938
L_92b938:
	push_s r12
L_92b93a:
	st.a mhi,[sp,-0x4]
L_92b93e:
	st.a mlo,[sp,-0x4]
L_92b942:
	push_s r0
L_92b944:
	push_s r1
L_92b946:
	push_s r2
L_92b948:
	push_s r3
L_92b94a:
	st.a r4,[sp,-0x4]
L_92b94e:
	st.a r5,[sp,-0x4]
L_92b952:
	st.a r6,[sp,-0x4]
L_92b956:
	st.a r7,[sp,-0x4]
L_92b95a:
	st.a r8,[sp,-0x4]
L_92b95e:
	st.a r9,[sp,-0x4]
L_92b962:
	st.a r10,[sp,-0x4]
L_92b966:
	st.a r11,[sp,-0x4]
L_92b96a:
	st.a lp_count,[sp,-0x4]
L_92b96e:
	lr r12,[0x2]
L_92b972:
	push_s r12
L_92b974:
	lr r12,[0x3]
L_92b978:
	push_s r12
L_92b97a:
	push_s blink
L_92b97c:
	bl.d L_92d010
L_92b980:
	mov_s r0,0x3
L_92b982:
	pop_s blink
L_92b984:
	pop_s r12
L_92b986:
	sr r12,[0x3]
L_92b98a:
	pop_s r12
L_92b98c:
	sr r12,[0x2]
L_92b990:
	pop_s r12
L_92b992:
	mov_s lp_count,r12
L_92b994:
	ld.ab r11,[sp,0x4]
L_92b998:
	ld.ab r10,[sp,0x4]
L_92b99c:
	ld.ab r9,[sp,0x4]
L_92b9a0:
	ld.ab r8,[sp,0x4]
L_92b9a4:
	ld.ab r7,[sp,0x4]
L_92b9a8:
	ld.ab r6,[sp,0x4]
L_92b9ac:
	ld.ab r5,[sp,0x4]
L_92b9b0:
	ld.ab r4,[sp,0x4]
L_92b9b4:
	pop_s r3
L_92b9b6:
	pop_s r2
L_92b9b8:
	pop_s r1
L_92b9ba:
	pop_s r0
L_92b9bc:
	pop_s r12
L_92b9be:
	mulu64 r12,0x1
L_92b9c2:
	mov 0x0,mlo
L_92b9c6:
	pop_s r12
L_92b9c8:
	sr r12,[0x12]
L_92b9cc:
	pop_s r12
L_92b9ce:
	j.f [ilink2]
L_92b9d2:
	nop_s
