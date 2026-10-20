/* isr_pring_dma @ 0x8c126c, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: pring__isr_dispatch
 */
	.section .text.isr_pring_dma,"ax",@progbits
	.global isr_pring_dma
isr_pring_dma:
L_8c126c:
	push_s r12
L_8c126e:
	st.a mhi,[sp,-0x4]
L_8c1272:
	st.a mlo,[sp,-0x4]
L_8c1276:
	push_s r0
L_8c1278:
	push_s r1
L_8c127a:
	push_s r2
L_8c127c:
	push_s r3
L_8c127e:
	st.a r4,[sp,-0x4]
L_8c1282:
	st.a r5,[sp,-0x4]
L_8c1286:
	st.a r6,[sp,-0x4]
L_8c128a:
	st.a r7,[sp,-0x4]
L_8c128e:
	st.a r8,[sp,-0x4]
L_8c1292:
	st.a r9,[sp,-0x4]
L_8c1296:
	st.a r10,[sp,-0x4]
L_8c129a:
	st.a r11,[sp,-0x4]
L_8c129e:
	st.a lp_count,[sp,-0x4]
L_8c12a2:
	lr r12,[0x2]
L_8c12a6:
	push_s r12
L_8c12a8:
	lr r12,[0x3]
L_8c12ac:
	push_s r12
L_8c12ae:
	push_s blink
L_8c12b0:
	bl L_8e72fc
L_8c12b4:
	pop_s blink
L_8c12b6:
	pop_s r12
L_8c12b8:
	sr r12,[0x3]
L_8c12bc:
	pop_s r12
L_8c12be:
	sr r12,[0x2]
L_8c12c2:
	pop_s r12
L_8c12c4:
	mov_s lp_count,r12
L_8c12c6:
	ld.ab r11,[sp,0x4]
L_8c12ca:
	ld.ab r10,[sp,0x4]
L_8c12ce:
	ld.ab r9,[sp,0x4]
L_8c12d2:
	ld.ab r8,[sp,0x4]
L_8c12d6:
	ld.ab r7,[sp,0x4]
L_8c12da:
	ld.ab r6,[sp,0x4]
L_8c12de:
	ld.ab r5,[sp,0x4]
L_8c12e2:
	ld.ab r4,[sp,0x4]
L_8c12e6:
	pop_s r3
L_8c12e8:
	pop_s r2
L_8c12ea:
	pop_s r1
L_8c12ec:
	pop_s r0
L_8c12ee:
	pop_s r12
L_8c12f0:
	mulu64 r12,0x1
L_8c12f4:
	mov 0x0,mlo
L_8c12f8:
	pop_s r12
L_8c12fa:
	sr r12,[0x12]
L_8c12fe:
	pop_s r12
L_8c1300:
	j.f [ilink1]
