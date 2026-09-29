/* fw_vector_04 @ 0x8c1064, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: isr_880b50__dispatch_causes
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_04
fw_vector_04:
	.global L_8c1064
L_8c1064:
	push_s r12
L_8c1066:
	st.a mhi,[sp,-0x4]
L_8c106a:
	st.a mlo,[sp,-0x4]
L_8c106e:
	push_s r0
L_8c1070:
	push_s r1
L_8c1072:
	push_s r2
L_8c1074:
	push_s r3
L_8c1076:
	st.a r4,[sp,-0x4]
L_8c107a:
	st.a r5,[sp,-0x4]
L_8c107e:
	st.a r6,[sp,-0x4]
L_8c1082:
	st.a r7,[sp,-0x4]
L_8c1086:
	st.a r8,[sp,-0x4]
L_8c108a:
	st.a r9,[sp,-0x4]
L_8c108e:
	st.a r10,[sp,-0x4]
L_8c1092:
	st.a r11,[sp,-0x4]
L_8c1096:
	st.a lp_count,[sp,-0x4]
L_8c109a:
	lr r12,[0x2]
L_8c109e:
	push_s r12
L_8c10a0:
	lr r12,[0x3]
L_8c10a4:
	push_s r12
L_8c10a6:
	push_s blink
L_8c10a8:
	bl L_8c161c
L_8c10ac:
	pop_s blink
L_8c10ae:
	pop_s r12
L_8c10b0:
	sr r12,[0x3]
L_8c10b4:
	pop_s r12
L_8c10b6:
	sr r12,[0x2]
L_8c10ba:
	pop_s r12
L_8c10bc:
	mov_s lp_count,r12
L_8c10be:
	ld.ab r11,[sp,0x4]
L_8c10c2:
	ld.ab r10,[sp,0x4]
L_8c10c6:
	ld.ab r9,[sp,0x4]
L_8c10ca:
	ld.ab r8,[sp,0x4]
L_8c10ce:
	ld.ab r7,[sp,0x4]
L_8c10d2:
	ld.ab r6,[sp,0x4]
L_8c10d6:
	ld.ab r5,[sp,0x4]
L_8c10da:
	ld.ab r4,[sp,0x4]
L_8c10de:
	pop_s r3
L_8c10e0:
	pop_s r2
L_8c10e2:
	pop_s r1
L_8c10e4:
	pop_s r0
L_8c10e6:
	pop_s r12
L_8c10e8:
	mulu64 r12,0x1
L_8c10ec:
	mov 0x0,mlo
L_8c10f0:
	pop_s r12
L_8c10f2:
	sr r12,[0x12]
L_8c10f6:
	pop_s r12
L_8c10f8:
	j.f [ilink1]
