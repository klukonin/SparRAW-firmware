/* conn_main_sm__action_8c3c60 @ 0x8c3c60, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCP AP after association. Set conection ID: %d, AID: %d
 * Зовёт сам: __ld_r13_to_r13_ret, conn_main_sm__action_step_b, fw_log_emit2, power_mngr__check_mode, sm__defer_call
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_8c3c60
conn_main_sm__action_8c3c60:
	.global L_8c3c60
L_8c3c60:
	push_s blink
L_8c3c62:
	push_s r13
L_8c3c64:
	mov_s r13,r0
L_8c3c66:
	ld_s r0,[r0,0x38]
L_8c3c68:
	brne_s r0,0,L_8c3c76
L_8c3c6a:
	mov_s r0,0x1
L_8c3c6c:
	st_s r0,[r13,0x38]
L_8c3c6e:
	ld_s r0,[r13,0x8]
L_8c3c70:
	bl.d L_8ddb18
L_8c3c74:
	add_s r0,r0,0x70
	.global L_8c3c76
L_8c3c76:
	ld_s r0,[r13,0x34]
L_8c3c78:
	cmp_s r0,0x0
L_8c3c7a:
	mov.ne r0,r13
L_8c3c7e:
	mov.ne r1,0x6
L_8c3c82:
	sub_s.ne r2,r2,r2
L_8c3c84:
	mov.ne r3,r2
L_8c3c88:
	bl.ne.d L_8e7044
L_8c3c8c:
	mov.ne r4,r2
L_8c3c90:
	ld_s r1,[r13,0x8]
L_8c3c92:
	mov_s r0,0x0
L_8c3c94:
	ld_s r2,[r1,0x18]
L_8c3c96:
	ld_s r2,[r2,0x50]
L_8c3c98:
	cmp_s r2,0x2
L_8c3c9a:
	cmp.ne r2,0x3
L_8c3c9e:
	mov.eq r0,0x1
L_8c3ca2:
	extb.f 0x0,r0
L_8c3ca6:
	bne_s L_8c3cb0
L_8c3ca8:
	bl.d L_8e24e0
L_8c3cac:
	mov_s r0,0x1
L_8c3cae:
	b_s L_8c3cd2
	.global L_8c3cb0
L_8c3cb0:
	mov_s r0,0x803c20
L_8c3cb6:
	ldb_s r0,[r0,0x8]
L_8c3cb8:
	brne_s r0,0,L_8c3cd2
L_8c3cba:
	ldb_s r0,[r1,0x8]
L_8c3cbc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c3cbe:
	stb_s r0,[r1,0x9]
L_8c3cc0:
	ld_s r3,[r13,0x8]
L_8c3cc2:
	mov_s r1,0x1011ad0
L_8c3cc8:
	ldb_s r2,[r3,0x8]
L_8c3cca:
	mov_s r0,0x2b
L_8c3ccc:
	bl.d L_8dcc80
L_8c3cd0:
	ldb_s r3,[r3,0x9]
	.global L_8c3cd2
L_8c3cd2:
	b L_8c025c
L_8c3cd6:
	nop_s
