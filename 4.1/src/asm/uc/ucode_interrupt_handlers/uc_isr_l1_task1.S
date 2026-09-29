/* uc_isr_l1_task1 @ 0x9214ac, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l1_task__entry
 */
	.section .text.uc_isr_l1_task1,"ax",@progbits
	.global uc_isr_l1_task1
uc_isr_l1_task1:
L_9214ac:
	push_s r12
L_9214ae:
	st.a mhi,[sp,-0x4]
L_9214b2:
	st.a mlo,[sp,-0x4]
L_9214b6:
	push_s r0
L_9214b8:
	push_s r1
L_9214ba:
	push_s r2
L_9214bc:
	push_s r3
L_9214be:
	st.a r4,[sp,-0x4]
L_9214c2:
	st.a r5,[sp,-0x4]
L_9214c6:
	st.a r6,[sp,-0x4]
L_9214ca:
	st.a r7,[sp,-0x4]
L_9214ce:
	st.a r8,[sp,-0x4]
L_9214d2:
	st.a r9,[sp,-0x4]
L_9214d6:
	st.a r10,[sp,-0x4]
L_9214da:
	st.a r11,[sp,-0x4]
L_9214de:
	st.a lp_count,[sp,-0x4]
L_9214e2:
	lr r12,[0x2]
L_9214e6:
	push_s r12
L_9214e8:
	lr r12,[0x3]
L_9214ec:
	push_s r12
L_9214ee:
	push_s blink
L_9214f0:
	bl.d L_929738
L_9214f4:
	mov_s r0,0x1
L_9214f6:
	pop_s blink
L_9214f8:
	pop_s r12
L_9214fa:
	sr r12,[0x3]
L_9214fe:
	pop_s r12
L_921500:
	sr r12,[0x2]
L_921504:
	pop_s r12
L_921506:
	mov_s lp_count,r12
L_921508:
	ld.ab r11,[sp,0x4]
L_92150c:
	ld.ab r10,[sp,0x4]
L_921510:
	ld.ab r9,[sp,0x4]
L_921514:
	ld.ab r8,[sp,0x4]
L_921518:
	ld.ab r7,[sp,0x4]
L_92151c:
	ld.ab r6,[sp,0x4]
L_921520:
	ld.ab r5,[sp,0x4]
L_921524:
	ld.ab r4,[sp,0x4]
L_921528:
	pop_s r3
L_92152a:
	pop_s r2
L_92152c:
	pop_s r1
L_92152e:
	pop_s r0
L_921530:
	pop_s r12
L_921532:
	mulu64 r12,0x1
L_921536:
	mov 0x0,mlo
L_92153a:
	pop_s r12
L_92153c:
	sr r12,[0x12]
L_921540:
	pop_s r12
L_921542:
	.byte 0x20,0x20
