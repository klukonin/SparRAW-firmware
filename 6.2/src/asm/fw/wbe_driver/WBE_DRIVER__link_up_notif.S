/* WBE_DRIVER__link_up_notif @ 0x8f5ea8, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::link_up_notif: DEV2_LINK_UP : 0x%x
 *   WBE_DRIVER::link_up_notif: DEV3_LINK_UP :0x%x
 *   WBE_DRIVER::link_up_notif: COPY_SHADOW_DONE 0x%x
 * Зовут его: fw_vector_16
 * Зовёт сам: fw_log_emit1, fw_sysassert_fatal, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global WBE_DRIVER__link_up_notif
WBE_DRIVER__link_up_notif:
	.global L_8f5ea8
L_8f5ea8:
	push_s blink
L_8f5eaa:
	ldb r1,[gp, 0xcf]
L_8f5eae:
	bset r1,r1,r0
L_8f5eb2:
	extb_s r2,r1
L_8f5eb4:
	stb r1,[gp, 0xcf]
L_8f5eb8:
	breq_s r0,0,L_8f5ece
L_8f5eba:
	breq r0,0x1,L_8f5ed6
L_8f5ebe:
	breq r0,0x2,L_8f5ede
L_8f5ec2:
	mov_s r0,blink
L_8f5ec4:
	mov_s r1,0x6b
L_8f5ec6:
	bl.d L_8c9b28
L_8f5eca:
	bset_s r1,r1,0xc
L_8f5ecc:
	b_s L_8f5eea
	.global L_8f5ece
L_8f5ece:
	mov_s r1,0x1003684
L_8f5ed4:
	b_s L_8f5ee4
	.global L_8f5ed6
L_8f5ed6:
	mov_s r1,0x10036b4
L_8f5edc:
	b_s L_8f5ee4
	.global L_8f5ede
L_8f5ede:
	mov_s r1,0x10036e4
	.global L_8f5ee4
L_8f5ee4:
	bl.d L_8dcc10
L_8f5ee8:
	mov_s r0,0x2f
	.global L_8f5eea
L_8f5eea:
	ldb r2,[gp, 0xcf]
L_8f5eee:
	brne r2,0x7,L_8f5f0e
L_8f5ef2:
	mov_s r1,0x10036e4
L_8f5ef8:
	bl.d L_8dcc10
L_8f5efc:
	mov_s r0,0x2f
L_8f5efe:
	mov_s r0,0x35e6c
L_8f5f04:
	mov_s r1,0x0
L_8f5f06:
	mov_s r2,r1
L_8f5f08:
	bl.d L_8c3248
L_8f5f0c:
	mov_s r3,0x2
	.global L_8f5f0e
L_8f5f0e:
	pop_s blink
L_8f5f10:
	j_s [blink]
L_8f5f12:
	nop_s
