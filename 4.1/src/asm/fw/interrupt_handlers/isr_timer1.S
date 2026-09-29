/* isr_timer1 @ 0x8d6f4c, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   interrupt_handlers.c
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.isr_timer1,"ax",@progbits
	.global isr_timer1
isr_timer1:
L_8d6f4c:
	push_s r12
L_8d6f4e:
	st.a mhi,[sp,-0x4]
L_8d6f52:
	st.a mlo,[sp,-0x4]
L_8d6f56:
	push_s r0
L_8d6f58:
	push_s r1
L_8d6f5a:
	push_s r2
L_8d6f5c:
	push_s r3
L_8d6f5e:
	st.a r4,[sp,-0x4]
L_8d6f62:
	st.a r5,[sp,-0x4]
L_8d6f66:
	st.a r6,[sp,-0x4]
L_8d6f6a:
	st.a r7,[sp,-0x4]
L_8d6f6e:
	st.a r8,[sp,-0x4]
L_8d6f72:
	st.a r9,[sp,-0x4]
L_8d6f76:
	st.a r10,[sp,-0x4]
L_8d6f7a:
	st.a r11,[sp,-0x4]
L_8d6f7e:
	st.a lp_count,[sp,-0x4]
L_8d6f82:
	lr r12,[0x2]
L_8d6f86:
	push_s r12
L_8d6f88:
	lr r12,[0x3]
L_8d6f8c:
	push_s r12
L_8d6f8e:
	push_s blink
L_8d6f90:
	mov_s r0,blink
L_8d6f92:
	mov_s r2,0x1000250
L_8d6f98:
	mov_s r1,0x11ad
L_8d6f9e:
	bl.d L_8c82c0
L_8d6fa2:
	mov r3,0x2bf
L_8d6fa6:
	pop_s blink
L_8d6fa8:
	pop_s r12
L_8d6faa:
	sr r12,[0x3]
L_8d6fae:
	pop_s r12
L_8d6fb0:
	sr r12,[0x2]
L_8d6fb4:
	pop_s r12
L_8d6fb6:
	mov_s lp_count,r12
L_8d6fb8:
	ld.ab r11,[sp,0x4]
L_8d6fbc:
	ld.ab r10,[sp,0x4]
L_8d6fc0:
	ld.ab r9,[sp,0x4]
L_8d6fc4:
	ld.ab r8,[sp,0x4]
L_8d6fc8:
	ld.ab r7,[sp,0x4]
L_8d6fcc:
	ld.ab r6,[sp,0x4]
L_8d6fd0:
	ld.ab r5,[sp,0x4]
L_8d6fd4:
	ld.ab r4,[sp,0x4]
L_8d6fd8:
	pop_s r3
L_8d6fda:
	pop_s r2
L_8d6fdc:
	pop_s r1
L_8d6fde:
	pop_s r0
L_8d6fe0:
	pop_s r12
L_8d6fe2:
	mulu64 r12,0x1
L_8d6fe6:
	mov 0x0,mlo
L_8d6fea:
	pop_s r12
L_8d6fec:
	sr r12,[0x12]
L_8d6ff0:
	pop_s r12
L_8d6ff2:
	j.f [ilink2]
L_8d6ff6:
	nop_s
