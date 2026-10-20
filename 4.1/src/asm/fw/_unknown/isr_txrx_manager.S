/* isr_txrx_manager @ 0x8c1098, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: txrx_mgr__handle_dma_irq
 */
	.section .text.isr_txrx_manager,"ax",@progbits
	.global isr_txrx_manager
isr_txrx_manager:
L_8c1098:
	push_s r12
L_8c109a:
	st.a mhi,[sp,-0x4]
L_8c109e:
	st.a mlo,[sp,-0x4]
L_8c10a2:
	push_s r0
L_8c10a4:
	push_s r1
L_8c10a6:
	push_s r2
L_8c10a8:
	push_s r3
L_8c10aa:
	st.a r4,[sp,-0x4]
L_8c10ae:
	st.a r5,[sp,-0x4]
L_8c10b2:
	st.a r6,[sp,-0x4]
L_8c10b6:
	st.a r7,[sp,-0x4]
L_8c10ba:
	st.a r8,[sp,-0x4]
L_8c10be:
	st.a r9,[sp,-0x4]
L_8c10c2:
	st.a r10,[sp,-0x4]
L_8c10c6:
	st.a r11,[sp,-0x4]
L_8c10ca:
	st.a lp_count,[sp,-0x4]
L_8c10ce:
	lr r12,[0x2]
L_8c10d2:
	push_s r12
L_8c10d4:
	lr r12,[0x3]
L_8c10d8:
	push_s r12
L_8c10da:
	push_s blink
L_8c10dc:
	bl L_8c7de0
L_8c10e0:
	pop_s blink
L_8c10e2:
	pop_s r12
L_8c10e4:
	sr r12,[0x3]
L_8c10e8:
	pop_s r12
L_8c10ea:
	sr r12,[0x2]
L_8c10ee:
	pop_s r12
L_8c10f0:
	mov_s lp_count,r12
L_8c10f2:
	ld.ab r11,[sp,0x4]
L_8c10f6:
	ld.ab r10,[sp,0x4]
L_8c10fa:
	ld.ab r9,[sp,0x4]
L_8c10fe:
	ld.ab r8,[sp,0x4]
L_8c1102:
	ld.ab r7,[sp,0x4]
L_8c1106:
	ld.ab r6,[sp,0x4]
L_8c110a:
	ld.ab r5,[sp,0x4]
L_8c110e:
	ld.ab r4,[sp,0x4]
L_8c1112:
	pop_s r3
L_8c1114:
	pop_s r2
L_8c1116:
	pop_s r1
L_8c1118:
	pop_s r0
L_8c111a:
	pop_s r12
L_8c111c:
	mulu64 r12,0x1
L_8c1120:
	mov 0x0,mlo
L_8c1124:
	pop_s r12
L_8c1126:
	sr r12,[0x12]
L_8c112a:
	pop_s r12
L_8c112c:
	j.f [ilink1]
