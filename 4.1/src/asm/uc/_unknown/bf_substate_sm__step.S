/* bf_substate_sm__step @ 0x935dd4, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beamforming_substate_sm.c
 * Зовут его: bf_sm__substate_advance
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf__enter_mode3, bf_sm__state_action, bf_substate__next_step, bf_substate__set, uc_res_886f00__acquire, uc_sysassert
 * Глобалы (через gp): 0x80060c, 0x80060d, 0x80060e
 */
	.section .text.bf_substate_sm__step,"ax",@progbits
	.global bf_substate_sm__step
bf_substate_sm__step:
	.global L_935dd4
L_935dd4:
	push_s blink
L_935dd6:
	bl L_920210
L_935dda:
	asl_s r13,r0,0x2
L_935ddc:
	add1_s r13,r13,r13
L_935dde:
	add_s r13,r13,0x800ef4
L_935de4:
	ld_s r1,[r13,0x4]
L_935de6:
	mov_s r15,r0
L_935de8:
	brhs.d r1,0x9,L_935e5c
L_935dec:
	mov_s r14,0x0
L_935dee:
	ldb.x r1,[0x800bc4,r1]
L_935df6:
	add r0,pcl,0xa
L_935dfa:
	add1_s r0,r0,r1
L_935dfc:
	j_s [r0]
L_935dfe:
	mov_s r0,r15
L_935e00:
	bl.d L_9281a0
L_935e04:
	mov_s r1,0x3
L_935e06:
	mov_s r0,0x3
L_935e08:
	bl.d L_9218f4
L_935e0c:
	mov_s r1,r15
L_935e0e:
	b_s L_935e6c
L_935e10:
	ldb_s r0,[gp,0xe4]
L_935e12:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935e14:
	extb_s r0,r0
L_935e16:
	brlt.d r0,0x4,L_935e6c
L_935e1a:
	stb r0,[gp, 0xe4]
L_935e1e:
	mov_s r14,0x2
L_935e20:
	b_s L_935e6c
L_935e22:
	ldb_s r0,[r13,0x9]
L_935e24:
	brne r0,0x5,L_935e4e
L_935e28:
	ldb_s r0,[gp,0xe5]
L_935e2a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935e2c:
	extb_s r0,r0
L_935e2e:
	brlt.d r0,0x4,L_935e4e
L_935e32:
	stb r0,[gp, 0xe5]
L_935e36:
	b_s L_935e4c
L_935e38:
	ldb_s r0,[r13,0x9]
L_935e3a:
	brne r0,0x5,L_935e4e
L_935e3e:
	ldb_s r0,[gp,0xe6]
L_935e40:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935e42:
	extb_s r0,r0
L_935e44:
	brlt.d r0,0x4,L_935e4e
L_935e48:
	stb r0,[gp, 0xe6]
	.global L_935e4c
L_935e4c:
	mov_s r14,0x2
	.global L_935e4e
L_935e4e:
	ldb_s r0,[r13,0x9]
L_935e50:
	bl L_921910
L_935e54:
	stb_s r0,[r13,0x9]
L_935e56:
	b_s L_935e6c
L_935e58:
	mov_s r14,0x1
L_935e5a:
	b_s L_935e6c
	.global L_935e5c
L_935e5c:
	mov_s r0,blink
L_935e5e:
	mov_s r2,0x1000ba0
L_935e64:
	mov_s r1,0x19
L_935e66:
	bl.d L_925548
L_935e6a:
	mov_s r3,0x50
	.global L_935e6c
L_935e6c:
	brne_s r14,0,L_935e7c
L_935e6e:
	bl.d L_928f2c
L_935e72:
	mov_s r0,0x3
L_935e74:
	mov_s r0,r15
L_935e76:
	bl.d L_930dc4
L_935e7a:
	mov_s r1,0x0
	.global L_935e7c
L_935e7c:
	b.d L_92027c
L_935e80:
	mov_s r0,r14
L_935e82:
	nop_s
