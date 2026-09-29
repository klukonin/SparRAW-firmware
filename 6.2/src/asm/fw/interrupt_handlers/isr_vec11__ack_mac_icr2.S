/* isr_vec11__ack_mac_icr2 @ 0x8c0990, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: mac_icr__read_cause_887030
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global isr_vec11__ack_mac_icr2
isr_vec11__ack_mac_icr2:
	.global L_8c0990
L_8c0990:
	push_s r12
L_8c0992:
	st.a mhi,[sp,-0x4]
L_8c0996:
	st.a mlo,[sp,-0x4]
L_8c099a:
	push_s r0
L_8c099c:
	push_s r1
L_8c099e:
	push_s r2
L_8c09a0:
	push_s r3
L_8c09a2:
	st.a r4,[sp,-0x4]
L_8c09a6:
	st.a r5,[sp,-0x4]
L_8c09aa:
	st.a r6,[sp,-0x4]
L_8c09ae:
	st.a r7,[sp,-0x4]
L_8c09b2:
	st.a r8,[sp,-0x4]
L_8c09b6:
	st.a r9,[sp,-0x4]
L_8c09ba:
	st.a r10,[sp,-0x4]
L_8c09be:
	st.a r11,[sp,-0x4]
L_8c09c2:
	st.a lp_count,[sp,-0x4]
L_8c09c6:
	lr r12,[0x2]
L_8c09ca:
	push_s r12
L_8c09cc:
	lr r12,[0x3]
L_8c09d0:
	push_s r12
L_8c09d2:
	push_s blink
L_8c09d4:
	bl L_8dd8c4
L_8c09d8:
	mov_s r1,0x887000
L_8c09de:
	st_s r0,[r1,0x2c]
L_8c09e0:
	pop_s blink
L_8c09e2:
	pop_s r12
L_8c09e4:
	sr r12,[0x3]
L_8c09e8:
	pop_s r12
L_8c09ea:
	sr r12,[0x2]
L_8c09ee:
	pop_s r12
L_8c09f0:
	mov_s lp_count,r12
L_8c09f2:
	ld.ab r11,[sp,0x4]
L_8c09f6:
	ld.ab r10,[sp,0x4]
L_8c09fa:
	ld.ab r9,[sp,0x4]
L_8c09fe:
	ld.ab r8,[sp,0x4]
L_8c0a02:
	ld.ab r7,[sp,0x4]
L_8c0a06:
	ld.ab r6,[sp,0x4]
L_8c0a0a:
	ld.ab r5,[sp,0x4]
L_8c0a0e:
	ld.ab r4,[sp,0x4]
L_8c0a12:
	pop_s r3
L_8c0a14:
	pop_s r2
L_8c0a16:
	pop_s r1
L_8c0a18:
	pop_s r0
L_8c0a1a:
	pop_s r12
L_8c0a1c:
	mulu64 r12,0x1
L_8c0a20:
	mov 0x0,mlo
L_8c0a24:
	pop_s r12
L_8c0a26:
	sr r12,[0x12]
L_8c0a2a:
	pop_s r12
L_8c0a2c:
	j.f [ilink1]
