/* isr_memory_error @ 0x8c13a0, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   IntHandlerMemoryException!!!
 *   IntHandlerMemoryException blink=0x%X
 *   IntHandlerMemoryException sp=%d, ilink1=0x%X, ilink2=0x%X
 *   interrupt_handlers.c
 * Зовёт сам: fw_log__emit0, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.isr_memory_error,"ax",@progbits
	.global isr_memory_error
isr_memory_error:
L_8c13a0:
	push_s r12
L_8c13a2:
	st.a mhi,[sp,-0x4]
L_8c13a6:
	st.a mlo,[sp,-0x4]
L_8c13aa:
	push_s r0
L_8c13ac:
	push_s r1
L_8c13ae:
	push_s r2
L_8c13b0:
	push_s r3
L_8c13b2:
	st.a r4,[sp,-0x4]
L_8c13b6:
	st.a r5,[sp,-0x4]
L_8c13ba:
	st.a r6,[sp,-0x4]
L_8c13be:
	st.a r7,[sp,-0x4]
L_8c13c2:
	st.a r8,[sp,-0x4]
L_8c13c6:
	st.a r9,[sp,-0x4]
L_8c13ca:
	st.a r10,[sp,-0x4]
L_8c13ce:
	st.a r11,[sp,-0x4]
L_8c13d2:
	st.a lp_count,[sp,-0x4]
L_8c13d6:
	lr r12,[0x2]
L_8c13da:
	push_s r12
L_8c13dc:
	lr r12,[0x3]
L_8c13e0:
	push_s r12
L_8c13e2:
	push_s blink
L_8c13e4:
	mov_s r2,0x10001cc
L_8c13ea:
	mov_s r0,0x0
L_8c13ec:
	bl.d L_8edfb0
L_8c13f0:
	mov_s r1,r0
L_8c13f2:
	mov_s r3,blink
L_8c13f4:
	mov_s r2,0x10001ec
L_8c13fa:
	mov_s r0,0x0
L_8c13fc:
	bl.d L_8edfcc
L_8c1400:
	mov_s r1,r0
L_8c1402:
	mov_s r3,sp
L_8c1404:
	mov r4,ilink1
L_8c1408:
	mov r5,ilink2
L_8c140c:
	mov_s r2,0x1000214
L_8c1412:
	mov_s r0,0x0
L_8c1414:
	bl.d L_8ee034
L_8c1418:
	mov_s r1,r0
L_8c141a:
	mov_s r0,blink
L_8c141c:
	mov_s r2,0x1000250
L_8c1422:
	mov_s r1,0x11a7
L_8c1428:
	bl.d L_8c82c0
L_8c142c:
	mov_s r3,0x60
L_8c142e:
	pop_s blink
L_8c1430:
	pop_s r12
L_8c1432:
	sr r12,[0x3]
L_8c1436:
	pop_s r12
L_8c1438:
	sr r12,[0x2]
L_8c143c:
	pop_s r12
L_8c143e:
	mov_s lp_count,r12
L_8c1440:
	ld.ab r11,[sp,0x4]
L_8c1444:
	ld.ab r10,[sp,0x4]
L_8c1448:
	ld.ab r9,[sp,0x4]
L_8c144c:
	ld.ab r8,[sp,0x4]
L_8c1450:
	ld.ab r7,[sp,0x4]
L_8c1454:
	ld.ab r6,[sp,0x4]
L_8c1458:
	ld.ab r5,[sp,0x4]
L_8c145c:
	ld.ab r4,[sp,0x4]
L_8c1460:
	pop_s r3
L_8c1462:
	pop_s r2
L_8c1464:
	pop_s r1
L_8c1466:
	pop_s r0
L_8c1468:
	pop_s r12
L_8c146a:
	mulu64 r12,0x1
L_8c146e:
	mov 0x0,mlo
L_8c1472:
	pop_s r12
L_8c1474:
	sr r12,[0x12]
L_8c1478:
	pop_s r12
L_8c147a:
	j.f [ilink1]
L_8c147e:
	nop_s
