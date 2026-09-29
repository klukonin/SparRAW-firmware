/* uc_isr_l1_task0 @ 0x9207c0, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l1_task__entry
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_isr_l1_task0
uc_isr_l1_task0:
	.global L_9207c0
L_9207c0:
	push_s r12
L_9207c2:
	st.a mhi,[sp,-0x4]
L_9207c6:
	st.a mlo,[sp,-0x4]
L_9207ca:
	push_s r0
L_9207cc:
	push_s r1
L_9207ce:
	push_s r2
L_9207d0:
	push_s r3
L_9207d2:
	st.a r4,[sp,-0x4]
L_9207d6:
	st.a r5,[sp,-0x4]
L_9207da:
	st.a r6,[sp,-0x4]
L_9207de:
	st.a r7,[sp,-0x4]
L_9207e2:
	st.a r8,[sp,-0x4]
L_9207e6:
	st.a r9,[sp,-0x4]
L_9207ea:
	st.a r10,[sp,-0x4]
L_9207ee:
	st.a r11,[sp,-0x4]
L_9207f2:
	st.a lp_count,[sp,-0x4]
L_9207f6:
	lr r12,[0x2]
L_9207fa:
	push_s r12
L_9207fc:
	lr r12,[0x3]
L_920800:
	push_s r12
L_920802:
	push_s blink
L_920804:
	bl.d L_92c974
L_920808:
	mov_s r0,0x0
L_92080a:
	pop_s blink
L_92080c:
	pop_s r12
L_92080e:
	sr r12,[0x3]
L_920812:
	pop_s r12
L_920814:
	sr r12,[0x2]
L_920818:
	pop_s r12
L_92081a:
	mov_s lp_count,r12
L_92081c:
	ld.ab r11,[sp,0x4]
L_920820:
	ld.ab r10,[sp,0x4]
L_920824:
	ld.ab r9,[sp,0x4]
L_920828:
	ld.ab r8,[sp,0x4]
L_92082c:
	ld.ab r7,[sp,0x4]
L_920830:
	ld.ab r6,[sp,0x4]
L_920834:
	ld.ab r5,[sp,0x4]
L_920838:
	ld.ab r4,[sp,0x4]
L_92083c:
	pop_s r3
L_92083e:
	pop_s r2
L_920840:
	pop_s r1
L_920842:
	pop_s r0
L_920844:
	pop_s r12
L_920846:
	mulu64 r12,0x1
L_92084a:
	mov 0x0,mlo
L_92084e:
	pop_s r12
L_920850:
	sr r12,[0x12]
L_920854:
	pop_s r12
L_920856:
	j.f [ilink1]
L_92085a:
	nop_s
