/* l2_mgr__connect_next @ 0x8e4c24, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__connect_multi_omni, mid__link_acquis_step, probe_resp_ind
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__connect_next
l2_mgr__connect_next:
	.global L_8e4c24
L_8e4c24:
	push_s blink
L_8e4c26:
	bl.d L_8c01e0
L_8e4c2a:
	mov_s r4,r0
L_8e4c2c:
	mov_s r15,0x0
L_8e4c2e:
	b_s L_8e4c32
	.global L_8e4c30
L_8e4c30:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8e4c32
L_8e4c32:
	mov_s r0,r4
L_8e4c34:
	add r0,r0,0x1c4
L_8e4c38:
	ldb_s r0,[r0,r2]
L_8e4c3a:
	brge r15,r0,L_8e4c86
L_8e4c3e:
	asl_s r0,r2,0x4
L_8e4c40:
	asl_s r13,r15,0x2
L_8e4c42:
	add2_s r0,r0,r0
L_8e4c44:
	add2_s r13,r13,r13
L_8e4c46:
	add_s r13,r13,r0
L_8e4c48:
	add3 r3,r4,0x10
L_8e4c4c:
	add_s r3,r3,r13
L_8e4c4e:
	ldb_s r0,[r3,0x4]
L_8e4c50:
	ldb_s r14,[r1]
L_8e4c52:
	brne r0,r14,L_8e4c30
L_8e4c56:
	ldb_s r0,[r3,0x5]
L_8e4c58:
	ldb_s r14,[r1,0x1]
L_8e4c5a:
	brne r0,r14,L_8e4c30
L_8e4c5e:
	ldb_s r0,[r3,0x6]
L_8e4c60:
	ldb_s r14,[r1,0x2]
L_8e4c62:
	brne r0,r14,L_8e4c30
L_8e4c66:
	ldb_s r0,[r3,0x7]
L_8e4c68:
	ldb_s r14,[r1,0x3]
L_8e4c6a:
	brne r0,r14,L_8e4c30
L_8e4c6e:
	ldb_s r0,[r3,0x8]
L_8e4c70:
	ldb_s r14,[r1,0x4]
L_8e4c72:
	brne r0,r14,L_8e4c30
L_8e4c76:
	ldb_s r3,[r3,0x9]
L_8e4c78:
	ldb_s r0,[r1,0x5]
L_8e4c7a:
	brne r3,r0,L_8e4c30
L_8e4c7e:
	add2 r0,r4,0x21
L_8e4c82:
	add_s r0,r0,r13
L_8e4c84:
	b_s L_8e4c88
	.global L_8e4c86
L_8e4c86:
	mov_s r0,0x0
	.global L_8e4c88
L_8e4c88:
	b L_8c024c
