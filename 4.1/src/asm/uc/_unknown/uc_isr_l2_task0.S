/* uc_isr_l2_task0 @ 0x921374, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l2_task__entry
 */
	.section .text.uc_isr_l2_task0,"ax",@progbits
	.global uc_isr_l2_task0
uc_isr_l2_task0:
L_921374:
	push_s r12
L_921376:
	st.a mhi,[sp,-0x4]
L_92137a:
	st.a mlo,[sp,-0x4]
L_92137e:
	push_s r0
L_921380:
	push_s r1
L_921382:
	push_s r2
L_921384:
	push_s r3
L_921386:
	st.a r4,[sp,-0x4]
L_92138a:
	st.a r5,[sp,-0x4]
L_92138e:
	st.a r6,[sp,-0x4]
L_921392:
	st.a r7,[sp,-0x4]
L_921396:
	st.a r8,[sp,-0x4]
L_92139a:
	st.a r9,[sp,-0x4]
L_92139e:
	st.a r10,[sp,-0x4]
L_9213a2:
	st.a r11,[sp,-0x4]
L_9213a6:
	st.a lp_count,[sp,-0x4]
L_9213aa:
	lr r12,[0x2]
L_9213ae:
	push_s r12
L_9213b0:
	lr r12,[0x3]
L_9213b4:
	push_s r12
L_9213b6:
	push_s blink
L_9213b8:
	bl.d L_929ec4
L_9213bc:
	mov_s r0,0x0
L_9213be:
	pop_s blink
L_9213c0:
	pop_s r12
L_9213c2:
	sr r12,[0x3]
L_9213c6:
	pop_s r12
L_9213c8:
	sr r12,[0x2]
L_9213cc:
	pop_s r12
L_9213ce:
	mov_s lp_count,r12
L_9213d0:
	ld.ab r11,[sp,0x4]
L_9213d4:
	ld.ab r10,[sp,0x4]
L_9213d8:
	ld.ab r9,[sp,0x4]
L_9213dc:
	ld.ab r8,[sp,0x4]
L_9213e0:
	ld.ab r7,[sp,0x4]
L_9213e4:
	ld.ab r6,[sp,0x4]
L_9213e8:
	ld.ab r5,[sp,0x4]
L_9213ec:
	ld.ab r4,[sp,0x4]
L_9213f0:
	pop_s r3
L_9213f2:
	pop_s r2
L_9213f4:
	pop_s r1
L_9213f6:
	pop_s r0
L_9213f8:
	pop_s r12
L_9213fa:
	mulu64 r12,0x1
L_9213fe:
	mov 0x0,mlo
L_921402:
	pop_s r12
