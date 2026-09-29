/* uc_isr_l1_task2 @ 0x921220, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l1_task__entry
 */
	.section .text.uc_isr_l1_task2,"ax",@progbits
	.global uc_isr_l1_task2
uc_isr_l1_task2:
L_921220:
	push_s r12
L_921222:
	st.a mhi,[sp,-0x4]
L_921226:
	st.a mlo,[sp,-0x4]
L_92122a:
	push_s r0
L_92122c:
	push_s r1
L_92122e:
	push_s r2
L_921230:
	push_s r3
L_921232:
	st.a r4,[sp,-0x4]
L_921236:
	st.a r5,[sp,-0x4]
L_92123a:
	st.a r6,[sp,-0x4]
L_92123e:
	st.a r7,[sp,-0x4]
L_921242:
	st.a r8,[sp,-0x4]
L_921246:
	st.a r9,[sp,-0x4]
L_92124a:
	st.a r10,[sp,-0x4]
L_92124e:
	st.a r11,[sp,-0x4]
L_921252:
	st.a lp_count,[sp,-0x4]
L_921256:
	lr r12,[0x2]
L_92125a:
	push_s r12
L_92125c:
	lr r12,[0x3]
L_921260:
	push_s r12
L_921262:
	push_s blink
L_921264:
	bl.d L_929738
L_921268:
	mov_s r0,0x2
L_92126a:
	pop_s blink
L_92126c:
	pop_s r12
L_92126e:
	sr r12,[0x3]
L_921272:
	pop_s r12
L_921274:
	sr r12,[0x2]
L_921278:
	pop_s r12
L_92127a:
	mov_s lp_count,r12
L_92127c:
	ld.ab r11,[sp,0x4]
L_921280:
	ld.ab r10,[sp,0x4]
L_921284:
	ld.ab r9,[sp,0x4]
L_921288:
	ld.ab r8,[sp,0x4]
L_92128c:
	ld.ab r7,[sp,0x4]
L_921290:
	ld.ab r6,[sp,0x4]
L_921294:
	ld.ab r5,[sp,0x4]
L_921298:
	ld.ab r4,[sp,0x4]
L_92129c:
	pop_s r3
L_92129e:
	pop_s r2
L_9212a0:
	pop_s r1
L_9212a2:
	pop_s r0
L_9212a4:
	pop_s r12
L_9212a6:
	mulu64 r12,0x1
L_9212aa:
	mov 0x0,mlo
L_9212ae:
	pop_s r12
L_9212b0:
	sr r12,[0x12]
L_9212b4:
	pop_s r12
L_9212b6:
	j.f [ilink1]
L_9212ba:
	nop_s
