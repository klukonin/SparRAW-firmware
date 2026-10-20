/* isr_icr_88701c_mask @ 0x8c08c4, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: get_reg_887030
 */
	.section .text.isr_icr_88701c_mask,"ax",@progbits
	.global isr_icr_88701c_mask
isr_icr_88701c_mask:
L_8c08c4:
	push_s r12
L_8c08c6:
	st.a mhi,[sp,-0x4]
L_8c08ca:
	st.a mlo,[sp,-0x4]
L_8c08ce:
	push_s r0
L_8c08d0:
	push_s r1
L_8c08d2:
	push_s r2
L_8c08d4:
	push_s r3
L_8c08d6:
	st.a r4,[sp,-0x4]
L_8c08da:
	st.a r5,[sp,-0x4]
L_8c08de:
	st.a r6,[sp,-0x4]
L_8c08e2:
	st.a r7,[sp,-0x4]
L_8c08e6:
	st.a r8,[sp,-0x4]
L_8c08ea:
	st.a r9,[sp,-0x4]
L_8c08ee:
	st.a r10,[sp,-0x4]
L_8c08f2:
	st.a r11,[sp,-0x4]
L_8c08f6:
	st.a lp_count,[sp,-0x4]
L_8c08fa:
	lr r12,[0x2]
L_8c08fe:
	push_s r12
L_8c0900:
	lr r12,[0x3]
L_8c0904:
	push_s r12
L_8c0906:
	push_s blink
L_8c0908:
	bl L_8d9b38
L_8c090c:
	mov_s r1,0x887000
L_8c0912:
	st_s r0,[r1,0x2c]
L_8c0914:
	pop_s blink
L_8c0916:
	pop_s r12
L_8c0918:
	sr r12,[0x3]
L_8c091c:
	pop_s r12
L_8c091e:
	sr r12,[0x2]
L_8c0922:
	pop_s r12
L_8c0924:
	mov_s lp_count,r12
L_8c0926:
	ld.ab r11,[sp,0x4]
L_8c092a:
	ld.ab r10,[sp,0x4]
L_8c092e:
	ld.ab r9,[sp,0x4]
L_8c0932:
	ld.ab r8,[sp,0x4]
L_8c0936:
	ld.ab r7,[sp,0x4]
L_8c093a:
	ld.ab r6,[sp,0x4]
L_8c093e:
	ld.ab r5,[sp,0x4]
L_8c0942:
	ld.ab r4,[sp,0x4]
L_8c0946:
	pop_s r3
L_8c0948:
	pop_s r2
L_8c094a:
	pop_s r1
L_8c094c:
	pop_s r0
L_8c094e:
	pop_s r12
L_8c0950:
	mulu64 r12,0x1
L_8c0954:
	mov 0x0,mlo
L_8c0958:
	pop_s r12
L_8c095a:
	sr r12,[0x12]
L_8c095e:
	pop_s r12
L_8c0960:
	j.f [ilink1]
