/* isr_vring_dma_fw @ 0x8c1350, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwd_dma__bad_cause, vring_schdlr__isr_dispatch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global isr_vring_dma_fw
isr_vring_dma_fw:
	.global L_8c1350
L_8c1350:
	push_s r12
L_8c1352:
	st.a mhi,[sp,-0x4]
L_8c1356:
	st.a mlo,[sp,-0x4]
L_8c135a:
	push_s r0
L_8c135c:
	push_s r1
L_8c135e:
	push_s r2
L_8c1360:
	push_s r3
L_8c1362:
	st.a r4,[sp,-0x4]
L_8c1366:
	st.a r5,[sp,-0x4]
L_8c136a:
	st.a r6,[sp,-0x4]
L_8c136e:
	st.a r7,[sp,-0x4]
L_8c1372:
	st.a r8,[sp,-0x4]
L_8c1376:
	st.a r9,[sp,-0x4]
L_8c137a:
	st.a r10,[sp,-0x4]
L_8c137e:
	st.a r11,[sp,-0x4]
L_8c1382:
	st.a lp_count,[sp,-0x4]
L_8c1386:
	lr r12,[0x2]
L_8c138a:
	push_s r12
L_8c138c:
	lr r12,[0x3]
L_8c1390:
	push_s r12
L_8c1392:
	push_s blink
L_8c1394:
	bl L_8d072c
L_8c1398:
	bl L_8ebf90
L_8c139c:
	pop_s blink
L_8c139e:
	pop_s r12
L_8c13a0:
	sr r12,[0x3]
L_8c13a4:
	pop_s r12
L_8c13a6:
	sr r12,[0x2]
L_8c13aa:
	pop_s r12
L_8c13ac:
	mov_s lp_count,r12
L_8c13ae:
	ld.ab r11,[sp,0x4]
L_8c13b2:
	ld.ab r10,[sp,0x4]
L_8c13b6:
	ld.ab r9,[sp,0x4]
L_8c13ba:
	ld.ab r8,[sp,0x4]
L_8c13be:
	ld.ab r7,[sp,0x4]
L_8c13c2:
	ld.ab r6,[sp,0x4]
L_8c13c6:
	ld.ab r5,[sp,0x4]
L_8c13ca:
	ld.ab r4,[sp,0x4]
L_8c13ce:
	pop_s r3
L_8c13d0:
	pop_s r2
L_8c13d2:
	pop_s r1
L_8c13d4:
	pop_s r0
L_8c13d6:
	pop_s r12
L_8c13d8:
	mulu64 r12,0x1
L_8c13dc:
	mov 0x0,mlo
L_8c13e0:
	pop_s r12
L_8c13e2:
	sr r12,[0x12]
L_8c13e6:
	pop_s r12
L_8c13e8:
	j.f [ilink1]
