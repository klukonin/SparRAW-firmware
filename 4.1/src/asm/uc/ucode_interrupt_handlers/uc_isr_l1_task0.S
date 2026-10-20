/* uc_isr_l1_task0 @ 0x921410, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l1_task__entry
 */
	.section .text.uc_isr_l1_task0,"ax",@progbits
	.global uc_isr_l1_task0
uc_isr_l1_task0:
L_921410:
	push_s r12
L_921412:
	st.a mhi,[sp,-0x4]
L_921416:
	st.a mlo,[sp,-0x4]
L_92141a:
	push_s r0
L_92141c:
	push_s r1
L_92141e:
	push_s r2
L_921420:
	push_s r3
L_921422:
	st.a r4,[sp,-0x4]
L_921426:
	st.a r5,[sp,-0x4]
L_92142a:
	st.a r6,[sp,-0x4]
L_92142e:
	st.a r7,[sp,-0x4]
L_921432:
	st.a r8,[sp,-0x4]
L_921436:
	st.a r9,[sp,-0x4]
L_92143a:
	st.a r10,[sp,-0x4]
L_92143e:
	st.a r11,[sp,-0x4]
L_921442:
	st.a lp_count,[sp,-0x4]
L_921446:
	lr r12,[0x2]
L_92144a:
	push_s r12
L_92144c:
	lr r12,[0x3]
L_921450:
	push_s r12
L_921452:
	push_s blink
L_921454:
	bl.d L_929738
L_921458:
	mov_s r0,0x0
L_92145a:
	pop_s blink
L_92145c:
	pop_s r12
L_92145e:
	sr r12,[0x3]
L_921462:
	pop_s r12
L_921464:
	sr r12,[0x2]
L_921468:
	pop_s r12
L_92146a:
	mov_s lp_count,r12
L_92146c:
	ld.ab r11,[sp,0x4]
L_921470:
	ld.ab r10,[sp,0x4]
L_921474:
	ld.ab r9,[sp,0x4]
L_921478:
	ld.ab r8,[sp,0x4]
L_92147c:
	ld.ab r7,[sp,0x4]
L_921480:
	ld.ab r6,[sp,0x4]
L_921484:
	ld.ab r5,[sp,0x4]
L_921488:
	ld.ab r4,[sp,0x4]
L_92148c:
	pop_s r3
L_92148e:
	pop_s r2
L_921490:
	pop_s r1
L_921492:
	pop_s r0
L_921494:
	pop_s r12
L_921496:
	mulu64 r12,0x1
L_92149a:
	mov 0x0,mlo
L_92149e:
	pop_s r12
L_9214a0:
	sr r12,[0x12]
L_9214a4:
	pop_s r12
L_9214a6:
	j.f [ilink1]
L_9214aa:
	nop_s
