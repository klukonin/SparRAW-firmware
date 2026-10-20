/* aw_tbtt_set_step @ 0x930b08, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt
 * Зовёт сам: aw__compute_next_tbtt, memset0_words_uc
 */
	.section .text.aw_tbtt_set_step,"ax",@progbits
	.global aw_tbtt_set_step
aw_tbtt_set_step:
	.global L_930b08
L_930b08:
	st.a r13,[sp,-0x14]
L_930b0c:
	st blink,[sp, 0x4]
L_930b10:
	st_s r14,[sp,0x8]
L_930b12:
	st_s r15,[sp,0xc]
L_930b14:
	st r16,[sp, 0x10]
L_930b18:
	mov_s r15,r0
L_930b1a:
	ld r10,[r2]
L_930b1e:
	mov_s r14,r2
L_930b20:
	mov r13,r1
L_930b24:
	breq.d r10,0x0,L_930bc8
L_930b28:
	ld r3,[r1]
L_930b2c:
	brne.d r3,0x0,L_930b6c
L_930b30:
	ldb r4,[r14, 0x4]
L_930b34:
	brne r4,0x1,L_930bc8
L_930b38:
	ld.as r1,[r15,0x4b]
L_930b3c:
	ld r11,[r14, 0x8]
L_930b40:
	sub r1,r1,r11
L_930b44:
	brhs r1,0x80000000,L_930bc8
L_930b4c:
	mov_s r0,0x1
L_930b4e:
	st_s r0,[r13]
L_930b50:
	ld r5,[r14, 0x8]
L_930b54:
	mov r1,0x0
L_930b58:
	ld r8,[r14, 0xc]
L_930b5c:
	st r5,[r13, 0x4]
L_930b60:
	st r8,[r13, 0x8]
L_930b64:
	b.d L_930bc4
L_930b68:
	st r1,[r14]
	.global L_930b6c
L_930b6c:
	brne r4,0x0,L_930b8c
L_930b70:
	mov r16,0x0
L_930b74:
	mov r0,r13
L_930b78:
	bl.d L_92166c
L_930b7c:
	mov r1,0xc
L_930b80:
	st r16,[r13]
L_930b84:
	b.d L_930bc4
L_930b88:
	st r16,[r14]
	.global L_930b8c
L_930b8c:
	brne r4,0x1,L_930bc8
L_930b90:
	ld.as r2,[r15,0x4b]
L_930b94:
	ld r4,[r14, 0x8]
L_930b98:
	sub r2,r2,r4
L_930b9c:
	brhs r2,0x80000000,L_930bc8
L_930ba4:
	mov r6,0x1
L_930ba8:
	st r6,[r13]
L_930bac:
	ld r7,[r14, 0x8]
L_930bb0:
	mov r5,0x0
L_930bb4:
	ld r9,[r14, 0xc]
L_930bb8:
	st r7,[r13, 0x4]
L_930bbc:
	st r9,[r13, 0x8]
L_930bc0:
	st r5,[r14]
	.global L_930bc4
L_930bc4:
	ld r3,[r13]
	.global L_930bc8
L_930bc8:
	cmp r3,0x0
L_930bcc:
	mov.ne r0,r15
L_930bd0:
	bl.ne.d L_93096c
L_930bd4:
	mov.ne r1,r13
L_930bd8:
	ld blink,[sp, 0x4]
L_930bdc:
	ld_s r14,[sp,0x8]
L_930bde:
	ld_s r15,[sp,0xc]
L_930be0:
	ld r16,[sp, 0x10]
L_930be4:
	j.d [blink]
L_930be8:
	ld.ab r13,[sp,0x14]
