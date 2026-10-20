/* fw_vector_13 @ 0x8c0aec, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PLL5 UNLOCK interrupt!!!
 *   FS8 UNLOCK interrupt!!!
 * Зовёт сам: fw_log_emit0, fw_sysassert_fatal
 * Глобалы (через gp): 0x800208, 0x800234, 0x80023f, 0x80029a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_13
fw_vector_13:
	.global L_8c0aec
L_8c0aec:
	push_s r12
L_8c0aee:
	st.a mhi,[sp,-0x4]
L_8c0af2:
	st.a mlo,[sp,-0x4]
L_8c0af6:
	push_s r0
L_8c0af8:
	push_s r1
L_8c0afa:
	push_s r2
L_8c0afc:
	push_s r3
L_8c0afe:
	st.a r4,[sp,-0x4]
L_8c0b02:
	st.a r5,[sp,-0x4]
L_8c0b06:
	st.a r6,[sp,-0x4]
L_8c0b0a:
	st.a r7,[sp,-0x4]
L_8c0b0e:
	st.a r8,[sp,-0x4]
L_8c0b12:
	st.a r9,[sp,-0x4]
L_8c0b16:
	st.a r10,[sp,-0x4]
L_8c0b1a:
	st.a r11,[sp,-0x4]
L_8c0b1e:
	push_s r13
L_8c0b20:
	st.a lp_count,[sp,-0x4]
L_8c0b24:
	lr r12,[0x2]
L_8c0b28:
	push_s r12
L_8c0b2a:
	lr r12,[0x3]
L_8c0b2e:
	push_s r12
L_8c0b30:
	push_s blink
L_8c0b32:
	mov_s r0,0x889400
L_8c0b38:
	ld_s r13,[r0,0x74]
L_8c0b3a:
	st_s r13,[r0,0x70]
L_8c0b3c:
	bbit0 r13,0x2,L_8c0b64
L_8c0b40:
	ldw_s r0,[gp,0x84]
L_8c0b42:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0b44:
	stw.as r0,[gp,0x42]
L_8c0b48:
	ldb_s r0,[gp,0xbb]
L_8c0b4a:
	breq_s r0,0,L_8c0b64
L_8c0b4c:
	mov_s r1,0x10004f4
L_8c0b52:
	bl.d L_8dcba8
L_8c0b56:
	mov_s r0,0x0
L_8c0b58:
	mov_s r0,blink
L_8c0b5a:
	mov_s r1,0x12ec
L_8c0b60:
	bl L_8c9b28
	.global L_8c0b64
L_8c0b64:
	bbit0 r13,0x7,L_8c0b8c
L_8c0b68:
	ldw_s r0,[gp,0x116]
L_8c0b6a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0b6c:
	stw.as r0,[gp,0x8b]
L_8c0b70:
	ldb_s r0,[gp,0xb0]
L_8c0b72:
	breq_s r0,0,L_8c0b8c
L_8c0b74:
	mov_s r1,0x1000510
L_8c0b7a:
	bl.d L_8dcba8
L_8c0b7e:
	mov_s r0,0x0
L_8c0b80:
	mov_s r0,blink
L_8c0b82:
	mov_s r1,0x12ee
L_8c0b88:
	bl L_8c9b28
	.global L_8c0b8c
L_8c0b8c:
	pop_s blink
L_8c0b8e:
	pop_s r12
L_8c0b90:
	sr r12,[0x3]
L_8c0b94:
	pop_s r12
L_8c0b96:
	sr r12,[0x2]
L_8c0b9a:
	pop_s r12
L_8c0b9c:
	mov_s lp_count,r12
L_8c0b9e:
	pop_s r13
L_8c0ba0:
	ld.ab r11,[sp,0x4]
L_8c0ba4:
	ld.ab r10,[sp,0x4]
L_8c0ba8:
	ld.ab r9,[sp,0x4]
L_8c0bac:
	ld.ab r8,[sp,0x4]
L_8c0bb0:
	ld.ab r7,[sp,0x4]
L_8c0bb4:
	ld.ab r6,[sp,0x4]
L_8c0bb8:
	ld.ab r5,[sp,0x4]
L_8c0bbc:
	ld.ab r4,[sp,0x4]
L_8c0bc0:
	pop_s r3
L_8c0bc2:
	pop_s r2
L_8c0bc4:
	pop_s r1
L_8c0bc6:
	pop_s r0
L_8c0bc8:
	pop_s r12
L_8c0bca:
	mulu64 r12,0x1
L_8c0bce:
	mov 0x0,mlo
L_8c0bd2:
	pop_s r12
L_8c0bd4:
	sr r12,[0x12]
L_8c0bd8:
	pop_s r12
L_8c0bda:
	j.f [ilink1]
L_8c0bde:
	nop_s
