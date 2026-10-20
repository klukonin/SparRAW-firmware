/* uc_isr_l2_task2 @ 0x9212c0, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l2_task__entry
 */
	.section .text.uc_isr_l2_task2,"ax",@progbits
	.global uc_isr_l2_task2
uc_isr_l2_task2:
L_9212c0:
	push_s r12
L_9212c2:
	st.a mhi,[sp,-0x4]
L_9212c6:
	st.a mlo,[sp,-0x4]
L_9212ca:
	push_s r0
L_9212cc:
	push_s r1
L_9212ce:
	push_s r2
L_9212d0:
	push_s r3
L_9212d2:
	st.a r4,[sp,-0x4]
L_9212d6:
	st.a r5,[sp,-0x4]
L_9212da:
	st.a r6,[sp,-0x4]
L_9212de:
	st.a r7,[sp,-0x4]
L_9212e2:
	st.a r8,[sp,-0x4]
L_9212e6:
	st.a r9,[sp,-0x4]
L_9212ea:
	st.a r10,[sp,-0x4]
L_9212ee:
	st.a r11,[sp,-0x4]
L_9212f2:
	st.a lp_count,[sp,-0x4]
L_9212f6:
	lr r12,[0x2]
L_9212fa:
	push_s r12
L_9212fc:
	lr r12,[0x3]
L_921300:
	push_s r12
L_921302:
	push_s blink
L_921304:
	bl.d L_929ec4
L_921308:
	mov_s r0,0x2
L_92130a:
	pop_s blink
L_92130c:
	pop_s r12
L_92130e:
	sr r12,[0x3]
L_921312:
	pop_s r12
L_921314:
	sr r12,[0x2]
L_921318:
	pop_s r12
L_92131a:
	mov_s lp_count,r12
L_92131c:
	ld.ab r11,[sp,0x4]
L_921320:
	ld.ab r10,[sp,0x4]
L_921324:
	ld.ab r9,[sp,0x4]
L_921328:
	ld.ab r8,[sp,0x4]
L_92132c:
	ld.ab r7,[sp,0x4]
L_921330:
	ld.ab r6,[sp,0x4]
L_921334:
	ld.ab r5,[sp,0x4]
L_921338:
	ld.ab r4,[sp,0x4]
L_92133c:
	pop_s r3
L_92133e:
	pop_s r2
L_921340:
	pop_s r1
L_921342:
	pop_s r0
L_921344:
	pop_s r12
L_921346:
	mulu64 r12,0x1
L_92134a:
	mov 0x0,mlo
L_92134e:
	pop_s r12
L_921350:
	sr r12,[0x12]
L_921354:
	pop_s r12
L_921356:
	j.f [ilink2]
L_92135a:
	nop_s
