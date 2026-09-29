/* isr_pll_unlock @ 0x8c0a20, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PLL5 UNLOCK interrupt!!!
 *   interrupt_handlers.c
 *   FS8 UNLOCK interrupt!!!
 * Зовёт сам: fw_log__emit0, fw_sysassert_fatal
 * Глобалы (через gp): 0x8001f0, 0x800217, 0x800224, 0x800286
 */
	.section .text.isr_pll_unlock,"ax",@progbits
	.global isr_pll_unlock
isr_pll_unlock:
L_8c0a20:
	push_s r12
L_8c0a22:
	st.a mhi,[sp,-0x4]
L_8c0a26:
	st.a mlo,[sp,-0x4]
L_8c0a2a:
	push_s r0
L_8c0a2c:
	push_s r1
L_8c0a2e:
	push_s r2
L_8c0a30:
	push_s r3
L_8c0a32:
	st.a r4,[sp,-0x4]
L_8c0a36:
	st.a r5,[sp,-0x4]
L_8c0a3a:
	st.a r6,[sp,-0x4]
L_8c0a3e:
	st.a r7,[sp,-0x4]
L_8c0a42:
	st.a r8,[sp,-0x4]
L_8c0a46:
	st.a r9,[sp,-0x4]
L_8c0a4a:
	st.a r10,[sp,-0x4]
L_8c0a4e:
	st.a r11,[sp,-0x4]
L_8c0a52:
	push_s r13
L_8c0a54:
	st.a lp_count,[sp,-0x4]
L_8c0a58:
	lr r12,[0x2]
L_8c0a5c:
	push_s r12
L_8c0a5e:
	lr r12,[0x3]
L_8c0a62:
	push_s r12
L_8c0a64:
	push_s blink
L_8c0a66:
	mov_s r0,0x889400
L_8c0a6c:
	ld_s r13,[r0,0x74]
L_8c0a6e:
	st_s r13,[r0,0x70]
L_8c0a70:
	bbit0 r13,0x2,L_8c0aa4
L_8c0a74:
	ldw_s r0,[gp,0x80]
L_8c0a76:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0a78:
	stw.as r0,[gp,0x40]
L_8c0a7c:
	ldb_s r0,[gp,0xb4]
L_8c0a7e:
	breq_s r0,0,L_8c0aa4
L_8c0a80:
	mov_s r2,0x10004f4
L_8c0a86:
	mov_s r0,0x0
L_8c0a88:
	bl.d L_8edfb0
L_8c0a8c:
	mov_s r1,r0
L_8c0a8e:
	mov_s r0,blink
L_8c0a90:
	mov_s r2,0x1000250
L_8c0a96:
	mov_s r1,0x12ec
L_8c0a9c:
	bl.d L_8c82c0
L_8c0aa0:
	mov r3,0x270
	.global L_8c0aa4
L_8c0aa4:
	bbit0 r13,0x7,L_8c0ad8
L_8c0aa8:
	ldw_s r0,[gp,0x116]
L_8c0aaa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0aac:
	stw.as r0,[gp,0x8b]
L_8c0ab0:
	ldb_s r0,[gp,0xa7]
L_8c0ab2:
	breq_s r0,0,L_8c0ad8
L_8c0ab4:
	mov_s r2,0x1000510
L_8c0aba:
	mov_s r0,0x0
L_8c0abc:
	bl.d L_8edfb0
L_8c0ac0:
	mov_s r1,r0
L_8c0ac2:
	mov_s r0,blink
L_8c0ac4:
	mov_s r2,0x1000250
L_8c0aca:
	mov_s r1,0x12ee
L_8c0ad0:
	bl.d L_8c82c0
L_8c0ad4:
	mov r3,0x278
	.global L_8c0ad8
L_8c0ad8:
	pop_s blink
L_8c0ada:
	pop_s r12
L_8c0adc:
	sr r12,[0x3]
L_8c0ae0:
	pop_s r12
L_8c0ae2:
	sr r12,[0x2]
L_8c0ae6:
	pop_s r12
L_8c0ae8:
	mov_s lp_count,r12
L_8c0aea:
	pop_s r13
L_8c0aec:
	ld.ab r11,[sp,0x4]
L_8c0af0:
	ld.ab r10,[sp,0x4]
L_8c0af4:
	ld.ab r9,[sp,0x4]
L_8c0af8:
	ld.ab r8,[sp,0x4]
L_8c0afc:
	ld.ab r7,[sp,0x4]
L_8c0b00:
	ld.ab r6,[sp,0x4]
L_8c0b04:
	ld.ab r5,[sp,0x4]
L_8c0b08:
	ld.ab r4,[sp,0x4]
L_8c0b0c:
	pop_s r3
L_8c0b0e:
	pop_s r2
L_8c0b10:
	pop_s r1
L_8c0b12:
	pop_s r0
L_8c0b14:
	pop_s r12
L_8c0b16:
	mulu64 r12,0x1
L_8c0b1a:
	mov 0x0,mlo
L_8c0b1e:
	pop_s r12
L_8c0b20:
	sr r12,[0x12]
L_8c0b24:
	pop_s r12
L_8c0b26:
	.byte 0x20,0x20
