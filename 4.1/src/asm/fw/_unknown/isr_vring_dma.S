/* isr_vring_dma @ 0x8c1304, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwd_dma__bad_cause, vring_schdlr__isr_dispatch
 */
	.section .text.isr_vring_dma,"ax",@progbits
	.global isr_vring_dma
isr_vring_dma:
L_8c1304:
	push_s r12
L_8c1306:
	st.a mhi,[sp,-0x4]
L_8c130a:
	st.a mlo,[sp,-0x4]
L_8c130e:
	push_s r0
L_8c1310:
	push_s r1
L_8c1312:
	push_s r2
L_8c1314:
	push_s r3
L_8c1316:
	st.a r4,[sp,-0x4]
L_8c131a:
	st.a r5,[sp,-0x4]
L_8c131e:
	st.a r6,[sp,-0x4]
L_8c1322:
	st.a r7,[sp,-0x4]
L_8c1326:
	st.a r8,[sp,-0x4]
L_8c132a:
	st.a r9,[sp,-0x4]
L_8c132e:
	st.a r10,[sp,-0x4]
L_8c1332:
	st.a r11,[sp,-0x4]
L_8c1336:
	st.a lp_count,[sp,-0x4]
L_8c133a:
	lr r12,[0x2]
L_8c133e:
	push_s r12
L_8c1340:
	lr r12,[0x3]
L_8c1344:
	push_s r12
L_8c1346:
	push_s blink
L_8c1348:
	bl L_8cd978
L_8c134c:
	bl L_8e738c
L_8c1350:
	pop_s blink
L_8c1352:
	pop_s r12
L_8c1354:
	sr r12,[0x3]
L_8c1358:
	pop_s r12
L_8c135a:
	sr r12,[0x2]
L_8c135e:
	pop_s r12
L_8c1360:
	mov_s lp_count,r12
L_8c1362:
	ld.ab r11,[sp,0x4]
L_8c1366:
	ld.ab r10,[sp,0x4]
L_8c136a:
	ld.ab r9,[sp,0x4]
L_8c136e:
	ld.ab r8,[sp,0x4]
L_8c1372:
	ld.ab r7,[sp,0x4]
L_8c1376:
	ld.ab r6,[sp,0x4]
L_8c137a:
	ld.ab r5,[sp,0x4]
L_8c137e:
	ld.ab r4,[sp,0x4]
L_8c1382:
	pop_s r3
L_8c1384:
	pop_s r2
L_8c1386:
	pop_s r1
L_8c1388:
	pop_s r0
L_8c138a:
	pop_s r12
L_8c138c:
	mulu64 r12,0x1
L_8c1390:
	mov 0x0,mlo
L_8c1394:
	pop_s r12
L_8c1396:
	sr r12,[0x12]
L_8c139a:
	pop_s r12
L_8c139c:
	j.f [ilink1]
