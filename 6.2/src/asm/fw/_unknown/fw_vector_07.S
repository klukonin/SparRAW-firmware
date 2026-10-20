/* fw_vector_07 @ 0x8da03c, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_07
fw_vector_07:
	.global L_8da03c
L_8da03c:
	push_s r12
L_8da03e:
	st.a mhi,[sp,-0x4]
L_8da042:
	st.a mlo,[sp,-0x4]
L_8da046:
	push_s r0
L_8da048:
	push_s r1
L_8da04a:
	push_s r2
L_8da04c:
	push_s r3
L_8da04e:
	st.a r4,[sp,-0x4]
L_8da052:
	st.a r5,[sp,-0x4]
L_8da056:
	st.a r6,[sp,-0x4]
L_8da05a:
	st.a r7,[sp,-0x4]
L_8da05e:
	st.a r8,[sp,-0x4]
L_8da062:
	st.a r9,[sp,-0x4]
L_8da066:
	st.a r10,[sp,-0x4]
L_8da06a:
	st.a r11,[sp,-0x4]
L_8da06e:
	st.a lp_count,[sp,-0x4]
L_8da072:
	lr r12,[0x2]
L_8da076:
	push_s r12
L_8da078:
	lr r12,[0x3]
L_8da07c:
	push_s r12
L_8da07e:
	push_s blink
L_8da080:
	mov_s r0,blink
L_8da082:
	mov_s r1,0x11ad
L_8da088:
	bl L_8c9b28
L_8da08c:
	pop_s blink
L_8da08e:
	pop_s r12
L_8da090:
	sr r12,[0x3]
L_8da094:
	pop_s r12
L_8da096:
	sr r12,[0x2]
L_8da09a:
	pop_s r12
L_8da09c:
	mov_s lp_count,r12
L_8da09e:
	ld.ab r11,[sp,0x4]
L_8da0a2:
	ld.ab r10,[sp,0x4]
L_8da0a6:
	ld.ab r9,[sp,0x4]
L_8da0aa:
	ld.ab r8,[sp,0x4]
L_8da0ae:
	ld.ab r7,[sp,0x4]
L_8da0b2:
	ld.ab r6,[sp,0x4]
L_8da0b6:
	ld.ab r5,[sp,0x4]
L_8da0ba:
	ld.ab r4,[sp,0x4]
L_8da0be:
	pop_s r3
L_8da0c0:
	pop_s r2
L_8da0c2:
	pop_s r1
L_8da0c4:
	pop_s r0
L_8da0c6:
	pop_s r12
L_8da0c8:
	mulu64 r12,0x1
L_8da0cc:
	mov 0x0,mlo
L_8da0d0:
	pop_s r12
L_8da0d2:
	sr r12,[0x12]
L_8da0d6:
	pop_s r12
L_8da0d8:
	j.f [ilink2]
