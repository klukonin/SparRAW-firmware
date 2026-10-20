/* uc_isr_l2_task3 @ 0x928b38, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l2_task__entry
 */
	.section .text.uc_isr_l2_task3,"ax",@progbits
	.global uc_isr_l2_task3
uc_isr_l2_task3:
L_928b38:
	push_s r12
L_928b3a:
	st.a mhi,[sp,-0x4]
L_928b3e:
	st.a mlo,[sp,-0x4]
L_928b42:
	push_s r0
L_928b44:
	push_s r1
L_928b46:
	push_s r2
L_928b48:
	push_s r3
L_928b4a:
	st.a r4,[sp,-0x4]
L_928b4e:
	st.a r5,[sp,-0x4]
L_928b52:
	st.a r6,[sp,-0x4]
L_928b56:
	st.a r7,[sp,-0x4]
L_928b5a:
	st.a r8,[sp,-0x4]
L_928b5e:
	st.a r9,[sp,-0x4]
L_928b62:
	st.a r10,[sp,-0x4]
L_928b66:
	st.a r11,[sp,-0x4]
L_928b6a:
	st.a lp_count,[sp,-0x4]
L_928b6e:
	lr r12,[0x2]
L_928b72:
	push_s r12
L_928b74:
	lr r12,[0x3]
L_928b78:
	push_s r12
L_928b7a:
	push_s blink
L_928b7c:
	bl.d L_929ec4
L_928b80:
	mov_s r0,0x3
L_928b82:
	pop_s blink
L_928b84:
	pop_s r12
L_928b86:
	sr r12,[0x3]
L_928b8a:
	pop_s r12
L_928b8c:
	sr r12,[0x2]
L_928b90:
	pop_s r12
L_928b92:
	mov_s lp_count,r12
L_928b94:
	ld.ab r11,[sp,0x4]
L_928b98:
	ld.ab r10,[sp,0x4]
L_928b9c:
	ld.ab r9,[sp,0x4]
L_928ba0:
	ld.ab r8,[sp,0x4]
L_928ba4:
	ld.ab r7,[sp,0x4]
L_928ba8:
	ld.ab r6,[sp,0x4]
L_928bac:
	ld.ab r5,[sp,0x4]
L_928bb0:
	ld.ab r4,[sp,0x4]
L_928bb4:
	pop_s r3
L_928bb6:
	pop_s r2
L_928bb8:
	pop_s r1
L_928bba:
	pop_s r0
L_928bbc:
	pop_s r12
L_928bbe:
	mulu64 r12,0x1
L_928bc2:
	mov 0x0,mlo
L_928bc6:
	pop_s r12
L_928bc8:
	sr r12,[0x12]
L_928bcc:
	pop_s r12
L_928bce:
	j.f [ilink2]
L_928bd2:
	nop_s
