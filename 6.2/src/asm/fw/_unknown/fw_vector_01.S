/* fw_vector_01 @ 0x8c13ec, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   IntHandlerMemoryException!!!
 *   IntHandlerMemoryException blink=0x%X
 *   IntHandlerMemoryException sp=%d, ilink1=0x%X, ilink2=0x%X
 * Зовёт сам: fw_log_emit0, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_01
fw_vector_01:
	.global L_8c13ec
L_8c13ec:
	push_s r12
L_8c13ee:
	st.a mhi,[sp,-0x4]
L_8c13f2:
	st.a mlo,[sp,-0x4]
L_8c13f6:
	push_s r0
L_8c13f8:
	push_s r1
L_8c13fa:
	push_s r2
L_8c13fc:
	push_s r3
L_8c13fe:
	st.a r4,[sp,-0x4]
L_8c1402:
	st.a r5,[sp,-0x4]
L_8c1406:
	st.a r6,[sp,-0x4]
L_8c140a:
	st.a r7,[sp,-0x4]
L_8c140e:
	st.a r8,[sp,-0x4]
L_8c1412:
	st.a r9,[sp,-0x4]
L_8c1416:
	st.a r10,[sp,-0x4]
L_8c141a:
	st.a r11,[sp,-0x4]
L_8c141e:
	st.a lp_count,[sp,-0x4]
L_8c1422:
	lr r12,[0x2]
L_8c1426:
	push_s r12
L_8c1428:
	lr r12,[0x3]
L_8c142c:
	push_s r12
L_8c142e:
	push_s blink
L_8c1430:
	mov_s r1,0x10001e0
L_8c1436:
	bl.d L_8dcba8
L_8c143a:
	mov_s r0,0x0
L_8c143c:
	mov_s r2,blink
L_8c143e:
	mov_s r1,0x1000200
L_8c1444:
	bl.d L_8dcc10
L_8c1448:
	mov_s r0,0x0
L_8c144a:
	mov_s r2,sp
L_8c144c:
	mov_s r3,ilink1
L_8c144e:
	mov r4,ilink2
L_8c1452:
	mov_s r1,0x1000228
L_8c1458:
	bl.d L_8dcd00
L_8c145c:
	mov_s r0,0x0
L_8c145e:
	mov_s r0,blink
L_8c1460:
	mov_s r1,0x11a7
L_8c1466:
	bl L_8c9b28
L_8c146a:
	pop_s blink
L_8c146c:
	pop_s r12
L_8c146e:
	sr r12,[0x3]
L_8c1472:
	pop_s r12
L_8c1474:
	sr r12,[0x2]
L_8c1478:
	pop_s r12
L_8c147a:
	mov_s lp_count,r12
L_8c147c:
	ld.ab r11,[sp,0x4]
L_8c1480:
	ld.ab r10,[sp,0x4]
L_8c1484:
	ld.ab r9,[sp,0x4]
L_8c1488:
	ld.ab r8,[sp,0x4]
L_8c148c:
	ld.ab r7,[sp,0x4]
L_8c1490:
	ld.ab r6,[sp,0x4]
L_8c1494:
	ld.ab r5,[sp,0x4]
L_8c1498:
	ld.ab r4,[sp,0x4]
L_8c149c:
	pop_s r3
L_8c149e:
	pop_s r2
L_8c14a0:
	pop_s r1
L_8c14a2:
	pop_s r0
L_8c14a4:
	pop_s r12
L_8c14a6:
	mulu64 r12,0x1
L_8c14aa:
	mov 0x0,mlo
L_8c14ae:
	pop_s r12
L_8c14b0:
	sr r12,[0x12]
L_8c14b4:
	pop_s r12
L_8c14b6:
	j.f [ilink1]
L_8c14ba:
	nop_s
