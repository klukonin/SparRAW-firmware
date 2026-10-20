/* fw_vector_08 @ 0x8c12b8, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: pring__isr_dispatch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_08
fw_vector_08:
	.global L_8c12b8
L_8c12b8:
	push_s r12
L_8c12ba:
	st.a mhi,[sp,-0x4]
L_8c12be:
	st.a mlo,[sp,-0x4]
L_8c12c2:
	push_s r0
L_8c12c4:
	push_s r1
L_8c12c6:
	push_s r2
L_8c12c8:
	push_s r3
L_8c12ca:
	st.a r4,[sp,-0x4]
L_8c12ce:
	st.a r5,[sp,-0x4]
L_8c12d2:
	st.a r6,[sp,-0x4]
L_8c12d6:
	st.a r7,[sp,-0x4]
L_8c12da:
	st.a r8,[sp,-0x4]
L_8c12de:
	st.a r9,[sp,-0x4]
L_8c12e2:
	st.a r10,[sp,-0x4]
L_8c12e6:
	st.a r11,[sp,-0x4]
L_8c12ea:
	st.a lp_count,[sp,-0x4]
L_8c12ee:
	lr r12,[0x2]
L_8c12f2:
	push_s r12
L_8c12f4:
	lr r12,[0x3]
L_8c12f8:
	push_s r12
L_8c12fa:
	push_s blink
L_8c12fc:
	bl L_8ebf00
L_8c1300:
	pop_s blink
L_8c1302:
	pop_s r12
L_8c1304:
	sr r12,[0x3]
L_8c1308:
	pop_s r12
L_8c130a:
	sr r12,[0x2]
L_8c130e:
	pop_s r12
L_8c1310:
	mov_s lp_count,r12
L_8c1312:
	ld.ab r11,[sp,0x4]
L_8c1316:
	ld.ab r10,[sp,0x4]
L_8c131a:
	ld.ab r9,[sp,0x4]
L_8c131e:
	ld.ab r8,[sp,0x4]
L_8c1322:
	ld.ab r7,[sp,0x4]
L_8c1326:
	ld.ab r6,[sp,0x4]
L_8c132a:
	ld.ab r5,[sp,0x4]
L_8c132e:
	ld.ab r4,[sp,0x4]
L_8c1332:
	pop_s r3
L_8c1334:
	pop_s r2
L_8c1336:
	pop_s r1
L_8c1338:
	pop_s r0
L_8c133a:
	pop_s r12
L_8c133c:
	mulu64 r12,0x1
L_8c1340:
	mov 0x0,mlo
L_8c1344:
	pop_s r12
L_8c1346:
	sr r12,[0x12]
L_8c134a:
	pop_s r12
L_8c134c:
	j.f [ilink1]
