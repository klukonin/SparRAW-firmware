/* uc_isr_l2_task1__body @ 0x921198, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l2_task__entry
 */
	.section .text.uc_isr_l2_task1__body,"ax",@progbits
	.global uc_isr_l2_task1__body
uc_isr_l2_task1__body:
	.byte 0x48
	.byte 0xb1
	.global sub_92119a
sub_92119a:
L_92119a:
	st.a r6,[sp,-0x4]
L_92119e:
	st.a r7,[sp,-0x4]
L_9211a2:
	st.a r8,[sp,-0x4]
L_9211a6:
	st.a r9,[sp,-0x4]
L_9211aa:
	st.a r10,[sp,-0x4]
L_9211ae:
	st.a r11,[sp,-0x4]
L_9211b2:
	st.a lp_count,[sp,-0x4]
L_9211b6:
	lr r12,[0x2]
L_9211ba:
	push_s r12
L_9211bc:
	lr r12,[0x3]
L_9211c0:
	push_s r12
L_9211c2:
	push_s blink
L_9211c4:
	bl.d L_929ec4
L_9211c8:
	mov_s r0,0x1
L_9211ca:
	pop_s blink
L_9211cc:
	pop_s r12
L_9211ce:
	sr r12,[0x3]
L_9211d2:
	pop_s r12
L_9211d4:
	sr r12,[0x2]
L_9211d8:
	pop_s r12
L_9211da:
	mov_s lp_count,r12
L_9211dc:
	ld.ab r11,[sp,0x4]
L_9211e0:
	ld.ab r10,[sp,0x4]
L_9211e4:
	ld.ab r9,[sp,0x4]
L_9211e8:
	ld.ab r8,[sp,0x4]
L_9211ec:
	ld.ab r7,[sp,0x4]
L_9211f0:
	ld.ab r6,[sp,0x4]
L_9211f4:
	ld.ab r5,[sp,0x4]
L_9211f8:
	ld.ab r4,[sp,0x4]
L_9211fc:
	pop_s r3
L_9211fe:
	pop_s r2
L_921200:
	pop_s r1
L_921202:
	pop_s r0
