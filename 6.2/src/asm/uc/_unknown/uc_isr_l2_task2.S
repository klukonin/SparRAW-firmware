/* uc_isr_l2_task2 @ 0x920704, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l2_task__entry
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_isr_l2_task2
uc_isr_l2_task2:
	.global L_920704
L_920704:
	push_s r12
L_920706:
	st.a mhi,[sp,-0x4]
L_92070a:
	st.a mlo,[sp,-0x4]
L_92070e:
	push_s r0
L_920710:
	push_s r1
L_920712:
	push_s r2
L_920714:
	push_s r3
L_920716:
	st.a r4,[sp,-0x4]
L_92071a:
	st.a r5,[sp,-0x4]
L_92071e:
	st.a r6,[sp,-0x4]
L_920722:
	st.a r7,[sp,-0x4]
L_920726:
	st.a r8,[sp,-0x4]
L_92072a:
	st.a r9,[sp,-0x4]
L_92072e:
	st.a r10,[sp,-0x4]
L_920732:
	st.a r11,[sp,-0x4]
L_920736:
	st.a lp_count,[sp,-0x4]
L_92073a:
	lr r12,[0x2]
L_92073e:
	push_s r12
L_920740:
	lr r12,[0x3]
L_920744:
	push_s r12
L_920746:
	push_s blink
L_920748:
	bl.d L_92d010
L_92074c:
	mov_s r0,0x2
L_92074e:
	pop_s blink
L_920750:
	pop_s r12
L_920752:
	sr r12,[0x3]
L_920756:
	pop_s r12
L_920758:
	sr r12,[0x2]
L_92075c:
	pop_s r12
L_92075e:
	mov_s lp_count,r12
L_920760:
	ld.ab r11,[sp,0x4]
L_920764:
	ld.ab r10,[sp,0x4]
L_920768:
	ld.ab r9,[sp,0x4]
L_92076c:
	ld.ab r8,[sp,0x4]
L_920770:
	ld.ab r7,[sp,0x4]
L_920774:
	ld.ab r6,[sp,0x4]
L_920778:
	ld.ab r5,[sp,0x4]
L_92077c:
	ld.ab r4,[sp,0x4]
L_920780:
	pop_s r3
L_920782:
	pop_s r2
L_920784:
	pop_s r1
L_920786:
	pop_s r0
L_920788:
	pop_s r12
L_92078a:
	mulu64 r12,0x1
L_92078e:
	mov 0x0,mlo
L_920792:
	pop_s r12
L_920794:
	sr r12,[0x12]
L_920798:
	pop_s r12
L_92079a:
	j.f [ilink2]
L_92079e:
	nop_s
