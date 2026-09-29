/* isr_vec10__ack_mac_icr @ 0x8c08f0, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: mac_icr__read_cause_887014
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global isr_vec10__ack_mac_icr
isr_vec10__ack_mac_icr:
	.global L_8c08f0
L_8c08f0:
	push_s r12
L_8c08f2:
	st.a mhi,[sp,-0x4]
L_8c08f6:
	st.a mlo,[sp,-0x4]
L_8c08fa:
	push_s r0
L_8c08fc:
	push_s r1
L_8c08fe:
	push_s r2
L_8c0900:
	push_s r3
L_8c0902:
	st.a r4,[sp,-0x4]
L_8c0906:
	st.a r5,[sp,-0x4]
L_8c090a:
	st.a r6,[sp,-0x4]
L_8c090e:
	st.a r7,[sp,-0x4]
L_8c0912:
	st.a r8,[sp,-0x4]
L_8c0916:
	st.a r9,[sp,-0x4]
L_8c091a:
	st.a r10,[sp,-0x4]
L_8c091e:
	st.a r11,[sp,-0x4]
L_8c0922:
	st.a lp_count,[sp,-0x4]
L_8c0926:
	lr r12,[0x2]
L_8c092a:
	push_s r12
L_8c092c:
	lr r12,[0x3]
L_8c0930:
	push_s r12
L_8c0932:
	push_s blink
L_8c0934:
	bl L_8dd8b8
L_8c0938:
	mov_s r1,0x887000
L_8c093e:
	st_s r0,[r1,0x10]
L_8c0940:
	pop_s blink
L_8c0942:
	pop_s r12
L_8c0944:
	sr r12,[0x3]
L_8c0948:
	pop_s r12
L_8c094a:
	sr r12,[0x2]
L_8c094e:
	pop_s r12
L_8c0950:
	mov_s lp_count,r12
L_8c0952:
	ld.ab r11,[sp,0x4]
L_8c0956:
	ld.ab r10,[sp,0x4]
L_8c095a:
	ld.ab r9,[sp,0x4]
L_8c095e:
	ld.ab r8,[sp,0x4]
L_8c0962:
	ld.ab r7,[sp,0x4]
L_8c0966:
	ld.ab r6,[sp,0x4]
L_8c096a:
	ld.ab r5,[sp,0x4]
L_8c096e:
	ld.ab r4,[sp,0x4]
L_8c0972:
	pop_s r3
L_8c0974:
	pop_s r2
L_8c0976:
	pop_s r1
L_8c0978:
	pop_s r0
L_8c097a:
	pop_s r12
L_8c097c:
	mulu64 r12,0x1
L_8c0980:
	mov 0x0,mlo
L_8c0984:
	pop_s r12
L_8c0986:
	sr r12,[0x12]
L_8c098a:
	pop_s r12
L_8c098c:
	j.f [ilink1]
