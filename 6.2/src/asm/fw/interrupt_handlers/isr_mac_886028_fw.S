/* isr_mac_886028_fw @ 0x8c0a30, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwd_phy__rx_enable
 * Глобалы (через gp): 0x800310
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global isr_mac_886028_fw
isr_mac_886028_fw:
	.global L_8c0a30
L_8c0a30:
	push_s r12
L_8c0a32:
	st.a mhi,[sp,-0x4]
L_8c0a36:
	st.a mlo,[sp,-0x4]
L_8c0a3a:
	push_s r0
L_8c0a3c:
	push_s r1
L_8c0a3e:
	push_s r2
L_8c0a40:
	push_s r3
L_8c0a42:
	st.a r4,[sp,-0x4]
L_8c0a46:
	st.a r5,[sp,-0x4]
L_8c0a4a:
	st.a r6,[sp,-0x4]
L_8c0a4e:
	st.a r7,[sp,-0x4]
L_8c0a52:
	st.a r8,[sp,-0x4]
L_8c0a56:
	st.a r9,[sp,-0x4]
L_8c0a5a:
	st.a r10,[sp,-0x4]
L_8c0a5e:
	st.a r11,[sp,-0x4]
L_8c0a62:
	st.a lp_count,[sp,-0x4]
L_8c0a66:
	lr r12,[0x2]
L_8c0a6a:
	push_s r12
L_8c0a6c:
	lr r12,[0x3]
L_8c0a70:
	push_s r12
L_8c0a72:
	push_s blink
L_8c0a74:
	ld_s r0,[gp,0x18c]
L_8c0a76:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0a78:
	st.as r0,[gp,0x63]
L_8c0a7c:
	bl.d L_8d219c
L_8c0a80:
	mov_s r0,0x0
L_8c0a82:
	mov_s r0,0x886e00
L_8c0a88:
	st 0x8000,[r0, 0x2c]
L_8c0a90:
	mov r1,-0x1
L_8c0a94:
	mov_s r0,0x886000
L_8c0a9a:
	st_s r1,[r0,0x28]
L_8c0a9c:
	pop_s blink
L_8c0a9e:
	pop_s r12
L_8c0aa0:
	sr r12,[0x3]
L_8c0aa4:
	pop_s r12
L_8c0aa6:
	sr r12,[0x2]
L_8c0aaa:
	pop_s r12
L_8c0aac:
	mov_s lp_count,r12
L_8c0aae:
	ld.ab r11,[sp,0x4]
L_8c0ab2:
	ld.ab r10,[sp,0x4]
L_8c0ab6:
	ld.ab r9,[sp,0x4]
L_8c0aba:
	ld.ab r8,[sp,0x4]
L_8c0abe:
	ld.ab r7,[sp,0x4]
L_8c0ac2:
	ld.ab r6,[sp,0x4]
L_8c0ac6:
	ld.ab r5,[sp,0x4]
L_8c0aca:
	ld.ab r4,[sp,0x4]
L_8c0ace:
	pop_s r3
L_8c0ad0:
	pop_s r2
L_8c0ad2:
	pop_s r1
L_8c0ad4:
	pop_s r0
L_8c0ad6:
	pop_s r12
L_8c0ad8:
	mulu64 r12,0x1
L_8c0adc:
	mov 0x0,mlo
L_8c0ae0:
	pop_s r12
L_8c0ae2:
	sr r12,[0x12]
L_8c0ae6:
	pop_s r12
L_8c0ae8:
	j.f [ilink1]
