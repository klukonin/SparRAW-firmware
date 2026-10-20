/* phy_params__snapshot @ 0x93cedc, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report, sls__rx_ssw_frame
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, memcpy_uc, uc_shl64
 * Глобалы (через gp): 0x800560, 0x8005b2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global phy_params__snapshot
phy_params__snapshot:
	.global L_93cedc
L_93cedc:
	push_s blink
L_93cede:
	bl L_920228
L_93cee2:
	mov_s r17,r0
L_93cee4:
	mov_s r14,0x804010
L_93ceea:
	ldw_s r0,[r14,0x12]
L_93ceec:
	mov_s r16,r1
L_93ceee:
	bmsk_s r0,r0,0x1
L_93cef0:
	mov_s r15,0x8021f8
L_93cef6:
	stb_s r0,[r15,0xd]
L_93cef8:
	ldw_s r0,[r14,0x10]
L_93cefa:
	mov_s r13,0x8020f0
L_93cf00:
	lsr_s r0,r0,0xa
L_93cf02:
	stb_s r0,[r15,0xc]
L_93cf04:
	ldw_s r2,[r14,0x10]
L_93cf06:
	ldb_s r0,[r13,0xe]
L_93cf08:
	lsr_s r2,r2,0xa
L_93cf0a:
	cmp_s r2,0x40
L_93cf0c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93cf0e:
	stb_s r0,[r13,0xe]
L_93cf10:
	bhs_s L_93cf28
L_93cf12:
	mov_s r0,0x1
L_93cf14:
	bl.d L_920458
L_93cf18:
	mov_s r1,0x0
L_93cf1a:
	ld_s r3,[r13,0x10]
L_93cf1c:
	ld_s r2,[r13,0x14]
L_93cf1e:
	or_s r0,r0,r3
L_93cf20:
	or_s r1,r1,r2
L_93cf22:
	st_s r0,[r13,0x10]
L_93cf24:
	st_s r1,[r13,0x14]
L_93cf26:
	b_s L_93cf40
	.global L_93cf28
L_93cf28:
	sub r2,r2,0x40
L_93cf2c:
	mov_s r0,0x1
L_93cf2e:
	bl.d L_920458
L_93cf32:
	mov_s r1,0x0
L_93cf34:
	ld_s r3,[r13,0x18]
L_93cf36:
	ld_s r2,[r13,0x1c]
L_93cf38:
	or_s r0,r0,r3
L_93cf3a:
	or_s r1,r1,r2
L_93cf3c:
	st_s r0,[r13,0x18]
L_93cf3e:
	st_s r1,[r13,0x1c]
	.global L_93cf40
L_93cf40:
	mov_s r1,0x857800
L_93cf46:
	ldb r2,[r1, -0xc4]
L_93cf4a:
	ldb_s r0,[r14,0x13]
L_93cf4c:
	brlt.d r2,0x2,L_93cf68
L_93cf50:
	bmsk_s r0,r0,0x5
L_93cf52:
	mov_s r2,0x801024
L_93cf58:
	ld_s r2,[r2]
L_93cf5a:
	ld r1,[r1, -0x50]
L_93cf5e:
	lsr_s r2,r2,0x8
L_93cf60:
	bmsk_s r2,r2,0xe
L_93cf62:
	add1_s r1,r1,r2
L_93cf64:
	ldb_s r1,[r1]
L_93cf66:
	add_s r0,r0,r1
	.global L_93cf68
L_93cf68:
	st r0,[r17]
L_93cf6c:
	ldb_s r0,[r14,0x13]
L_93cf6e:
	add r1,r15,0xc
L_93cf72:
	lsr_s r0,r0,0x6
L_93cf74:
	st r0,[r16]
L_93cf78:
	mov_s r0,r15
L_93cf7a:
	bl.d L_920330
L_93cf7e:
	mov_s r2,0xc
L_93cf80:
	ldw_s r0,[gp,0x8a]
L_93cf82:
	mov_s r14,0x801014
L_93cf88:
	breq_s r0,0,L_93cfca
L_93cf8a:
	ld.as r15,[gp,0xe]
L_93cf8e:
	mov_s r0,0x80212c
L_93cf94:
	mov_s r1,r15
L_93cf96:
	bl.d L_920330
L_93cf9a:
	mov_s r2,0xc
L_93cf9c:
	ld_s r0,[r15,0x8]
L_93cf9e:
	st_s r0,[r13,0x8]
L_93cfa0:
	ldb_s r0,[r14,0xd]
L_93cfa2:
	brne_s r0,0,L_93cfac
L_93cfa4:
	ldw_s r1,[r14,0x8]
L_93cfa6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93cfa8:
	stw_s r1,[r14,0x8]
L_93cfaa:
	b_s L_93cfc0
	.global L_93cfac
L_93cfac:
	cmp r0,0x80
L_93cfb0:
	bge_s L_93cfba
L_93cfb2:
	ld_s r1,[r14]
L_93cfb4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93cfb6:
	st_s r1,[r14]
L_93cfb8:
	b_s L_93cfc0
	.global L_93cfba
L_93cfba:
	ld_s r1,[r14,0x4]
L_93cfbc:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93cfbe:
	st_s r1,[r14,0x4]
	.global L_93cfc0
L_93cfc0:
	ldb_s r1,[r14,0xc]
L_93cfc2:
	min r0,r1,r0
L_93cfc6:
	stb_s r0,[r14,0xc]
L_93cfc8:
	b_s L_93cfd0
	.global L_93cfca
L_93cfca:
	ldw_s r0,[r14,0xa]
L_93cfcc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93cfce:
	stw_s r0,[r14,0xa]
	.global L_93cfd0
L_93cfd0:
	mov_s r0,0x0
L_93cfd2:
	b.d L_92028c
L_93cfd6:
	stw.as r0,[gp,0x45]
L_93cfda:
	nop_s
