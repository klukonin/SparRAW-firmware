/* uc_isr_l1_task2 @ 0x920664, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l1_task__entry
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_isr_l1_task2
uc_isr_l1_task2:
	.global L_920664
L_920664:
	push_s r12
L_920666:
	st.a mhi,[sp,-0x4]
L_92066a:
	st.a mlo,[sp,-0x4]
L_92066e:
	push_s r0
L_920670:
	push_s r1
L_920672:
	push_s r2
L_920674:
	push_s r3
L_920676:
	st.a r4,[sp,-0x4]
L_92067a:
	st.a r5,[sp,-0x4]
L_92067e:
	st.a r6,[sp,-0x4]
L_920682:
	st.a r7,[sp,-0x4]
L_920686:
	st.a r8,[sp,-0x4]
L_92068a:
	st.a r9,[sp,-0x4]
L_92068e:
	st.a r10,[sp,-0x4]
L_920692:
	st.a r11,[sp,-0x4]
L_920696:
	st.a lp_count,[sp,-0x4]
L_92069a:
	lr r12,[0x2]
L_92069e:
	push_s r12
L_9206a0:
	lr r12,[0x3]
L_9206a4:
	push_s r12
L_9206a6:
	push_s blink
L_9206a8:
	bl.d L_92c974
L_9206ac:
	mov_s r0,0x2
L_9206ae:
	pop_s blink
L_9206b0:
	pop_s r12
L_9206b2:
	sr r12,[0x3]
L_9206b6:
	pop_s r12
L_9206b8:
	sr r12,[0x2]
L_9206bc:
	pop_s r12
L_9206be:
	mov_s lp_count,r12
L_9206c0:
	ld.ab r11,[sp,0x4]
L_9206c4:
	ld.ab r10,[sp,0x4]
L_9206c8:
	ld.ab r9,[sp,0x4]
L_9206cc:
	ld.ab r8,[sp,0x4]
L_9206d0:
	ld.ab r7,[sp,0x4]
L_9206d4:
	ld.ab r6,[sp,0x4]
L_9206d8:
	ld.ab r5,[sp,0x4]
L_9206dc:
	ld.ab r4,[sp,0x4]
L_9206e0:
	pop_s r3
L_9206e2:
	pop_s r2
L_9206e4:
	pop_s r1
L_9206e6:
	pop_s r0
L_9206e8:
	pop_s r12
L_9206ea:
	mulu64 r12,0x1
L_9206ee:
	mov 0x0,mlo
L_9206f2:
	pop_s r12
L_9206f4:
	sr r12,[0x12]
L_9206f8:
	pop_s r12
L_9206fa:
	j.f [ilink1]
L_9206fe:
	nop_s
