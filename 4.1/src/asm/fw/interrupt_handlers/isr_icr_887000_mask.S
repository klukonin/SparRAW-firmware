/* isr_icr_887000_mask @ 0x8c0824, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: get_reg_887014
 */
	.section .text.isr_icr_887000_mask,"ax",@progbits
	.global isr_icr_887000_mask
isr_icr_887000_mask:
L_8c0824:
	push_s r12
L_8c0826:
	st.a mhi,[sp,-0x4]
L_8c082a:
	st.a mlo,[sp,-0x4]
L_8c082e:
	push_s r0
L_8c0830:
	push_s r1
L_8c0832:
	push_s r2
L_8c0834:
	push_s r3
L_8c0836:
	st.a r4,[sp,-0x4]
L_8c083a:
	st.a r5,[sp,-0x4]
L_8c083e:
	st.a r6,[sp,-0x4]
L_8c0842:
	st.a r7,[sp,-0x4]
L_8c0846:
	st.a r8,[sp,-0x4]
L_8c084a:
	st.a r9,[sp,-0x4]
L_8c084e:
	st.a r10,[sp,-0x4]
L_8c0852:
	st.a r11,[sp,-0x4]
L_8c0856:
	st.a lp_count,[sp,-0x4]
L_8c085a:
	lr r12,[0x2]
L_8c085e:
	push_s r12
L_8c0860:
	lr r12,[0x3]
L_8c0864:
	push_s r12
L_8c0866:
	push_s blink
L_8c0868:
	bl L_8d9b2c
L_8c086c:
	mov_s r1,0x887000
L_8c0872:
	st_s r0,[r1,0x10]
L_8c0874:
	pop_s blink
L_8c0876:
	pop_s r12
L_8c0878:
	sr r12,[0x3]
L_8c087c:
	pop_s r12
L_8c087e:
	sr r12,[0x2]
L_8c0882:
	pop_s r12
L_8c0884:
	mov_s lp_count,r12
L_8c0886:
	ld.ab r11,[sp,0x4]
L_8c088a:
	ld.ab r10,[sp,0x4]
L_8c088e:
	ld.ab r9,[sp,0x4]
L_8c0892:
	ld.ab r8,[sp,0x4]
L_8c0896:
	ld.ab r7,[sp,0x4]
L_8c089a:
	ld.ab r6,[sp,0x4]
L_8c089e:
	ld.ab r5,[sp,0x4]
L_8c08a2:
	ld.ab r4,[sp,0x4]
L_8c08a6:
	pop_s r3
L_8c08a8:
	pop_s r2
L_8c08aa:
	pop_s r1
L_8c08ac:
	pop_s r0
L_8c08ae:
	pop_s r12
L_8c08b0:
	mulu64 r12,0x1
L_8c08b4:
	mov 0x0,mlo
L_8c08b8:
	pop_s r12
L_8c08ba:
	sr r12,[0x12]
L_8c08be:
	pop_s r12
L_8c08c0:
	j.f [ilink1]
