/* isr_instruction_error @ 0x8c0774, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   interrupt_handlers.c
 * Зовёт сам: fw_sysassert_fatal, instruction_error__report
 */
	.section .text.isr_instruction_error,"ax",@progbits
	.global isr_instruction_error
isr_instruction_error:
L_8c0774:
	push_s r12
L_8c0776:
	st.a mhi,[sp,-0x4]
L_8c077a:
	st.a mlo,[sp,-0x4]
L_8c077e:
	push_s r0
L_8c0780:
	push_s r1
L_8c0782:
	push_s r2
L_8c0784:
	push_s r3
L_8c0786:
	st.a r4,[sp,-0x4]
L_8c078a:
	st.a r5,[sp,-0x4]
L_8c078e:
	st.a r6,[sp,-0x4]
L_8c0792:
	st.a r7,[sp,-0x4]
L_8c0796:
	st.a r8,[sp,-0x4]
L_8c079a:
	st.a r9,[sp,-0x4]
L_8c079e:
	st.a r10,[sp,-0x4]
L_8c07a2:
	st.a r11,[sp,-0x4]
L_8c07a6:
	st.a lp_count,[sp,-0x4]
L_8c07aa:
	lr r12,[0x2]
L_8c07ae:
	push_s r12
L_8c07b0:
	lr r12,[0x3]
L_8c07b4:
	push_s r12
L_8c07b6:
	push_s blink
L_8c07b8:
	mov_s r0,blink
L_8c07ba:
	bl.d L_8c3ad4
L_8c07be:
	mov_s r1,ilink2
L_8c07c0:
	mov_s r0,blink
L_8c07c2:
	mov_s r2,0x1000250
L_8c07c8:
	mov_s r1,0x11a8
L_8c07ce:
	bl.d L_8c82c0
L_8c07d2:
	mov_s r3,0x67
L_8c07d4:
	pop_s blink
L_8c07d6:
	pop_s r12
L_8c07d8:
	sr r12,[0x3]
L_8c07dc:
	pop_s r12
L_8c07de:
	sr r12,[0x2]
L_8c07e2:
	pop_s r12
L_8c07e4:
	mov_s lp_count,r12
L_8c07e6:
	ld.ab r11,[sp,0x4]
L_8c07ea:
	ld.ab r10,[sp,0x4]
L_8c07ee:
	ld.ab r9,[sp,0x4]
L_8c07f2:
	ld.ab r8,[sp,0x4]
L_8c07f6:
	ld.ab r7,[sp,0x4]
L_8c07fa:
	ld.ab r6,[sp,0x4]
L_8c07fe:
	ld.ab r5,[sp,0x4]
L_8c0802:
	ld.ab r4,[sp,0x4]
L_8c0806:
	pop_s r3
L_8c0808:
	pop_s r2
L_8c080a:
	pop_s r1
L_8c080c:
	pop_s r0
L_8c080e:
	pop_s r12
L_8c0810:
	mulu64 r12,0x1
L_8c0814:
	mov 0x0,mlo
L_8c0818:
	pop_s r12
L_8c081a:
	sr r12,[0x12]
L_8c081e:
	pop_s r12
L_8c0820:
	j.f [ilink1]
