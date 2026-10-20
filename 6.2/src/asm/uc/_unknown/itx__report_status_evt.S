/* itx__report_status_evt @ 0x926c34, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow
 * Зовёт сам: uc_evt__send_22
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__report_status_evt
itx__report_status_evt:
	.global L_926c34
L_926c34:
	extw r9,r1
L_926c38:
	mov r7,0x80242c
L_926c40:
	stw r1,[r7, 0x18]
L_926c44:
	asl r5,r0,0x2
L_926c48:
	add2 r5,r5,r5
L_926c4c:
	ld r6,[r5,0x802354]
L_926c54:
	stw r0,[r7, 0x14]
L_926c58:
	cmp r6,0x1
L_926c5c:
	mov r6,0x1
L_926c60:
	sub.ne r6,r6,r6
L_926c64:
	extb.f r6,r6
L_926c68:
	mov r8,0x0
L_926c6c:
	beq.d L_926c80
L_926c70:
	st r8,[r7, 0x10]
L_926c74:
	mov r4,0x8
L_926c78:
	b.d L_926c84
L_926c7c:
	stb r4,[r7, 0x16]
	.global L_926c80
L_926c80:
	stb r8,[r7, 0x16]
	.global L_926c84
L_926c84:
	breq_s r2,0,L_926c90
L_926c86:
	mov_s r3,0x2
L_926c88:
	b.d L_926ca4
L_926c8c:
	st r3,[r7, 0xc]
	.global L_926c90
L_926c90:
	breq r6,0x0,L_926ca0
L_926c94:
	mov r1,0x1
L_926c98:
	b.d L_926ca4
L_926c9c:
	st r1,[r7, 0xc]
	.global L_926ca0
L_926ca0:
	st r8,[r7, 0xc]
	.global L_926ca4
L_926ca4:
	brge r9,0x2,L_926cbc
L_926ca8:
	cmp r6,0x0
L_926cac:
	cmp.eq r2,0x0
L_926cb0:
	beq_s L_926cbc
L_926cb2:
	mov_s r0,0x1
L_926cb4:
	st r0,[r7, 0x10]
L_926cb8:
	stb r8,[r7, 0x16]
	.global L_926cbc
L_926cbc:
	b.d L_9275ec
L_926cc0:
	add r0,r7,0xc
