/* assoc_ready_check_trig @ 0x8c3db0, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   assoc_ready_check_trig: actual=%d,req=%d
 *   mid::assoc_ready_check_trig. No resources. midid:%d
 *   assoc_ready_check_trig: for MID %d set PCP_ready = %d, current PCP_ready %d
 * Зовут его: conn_main_sm__action_8c9050, conn_main_sm__action_8da6b0, mem_resource__check_timeout_cb
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bss_bi_ctrl_PCP_ready_set, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, mid__count_active_conns, pcp_restart, u_schd__schedule
 * Глобалы (через gp): 0x8002f4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global assoc_ready_check_trig
assoc_ready_check_trig:
	.global L_8c3db0
L_8c3db0:
	push_s blink
L_8c3db2:
	bl L_8c01dc
L_8c3db6:
	mov_s r14,r0
L_8c3db8:
	add3 r13,r0,0x9
L_8c3dbc:
	ld_s r1,[r13,0x8]
L_8c3dbe:
	mov_s r0,0x0
L_8c3dc0:
	cmp_s r1,0x2
L_8c3dc2:
	cmp.ne r1,0x3
L_8c3dc6:
	mov.eq r0,0x1
L_8c3dca:
	extb.f 0x0,r0
L_8c3dce:
	beq_s L_8c3e8c
L_8c3dd0:
	ld_s r0,[gp,0x170]
L_8c3dd2:
	breq r0,0x0,L_8c3e8c
L_8c3dd6:
	breq r13,0x0,L_8c3e58
	.global L_8c3dda
L_8c3dda:
	ldb r0,[r13,0x10c]
L_8c3de2:
	mov_s r15,0x1
L_8c3de4:
	bic.f r0,r0,-0x31
L_8c3de8:
	sub.eq r15,r15,r15
L_8c3dec:
	bl.d L_8cc66c
L_8c3df0:
	mov_s r0,r14
L_8c3df2:
	ldb_s r1,[r14,0x11]
L_8c3df4:
	mov_s r2,r15
L_8c3df6:
	cmp_s r0,r1
L_8c3df8:
	rlc r16,0x0
L_8c3dfc:
	mov_s r1,0x100c988
L_8c3e02:
	mov_s r0,0x2b
L_8c3e04:
	bl.d L_8dcc80
L_8c3e08:
	mov_s r3,r16
L_8c3e0a:
	breq r15,r16,L_8c3e8c
L_8c3e0e:
	mov_s r0,0x842304
L_8c3e14:
	ld_s r1,[r0,0xc]
L_8c3e16:
	ld_s r0,[r0,0x10]
L_8c3e18:
	cmp_s r1,r0
L_8c3e1a:
	mov_s r0,0x1
L_8c3e1c:
	sub.cs r0,r0,r0
L_8c3e20:
	breq_s r0,0,L_8c3e66
L_8c3e22:
	ld.as r0,[r14,0xaa]
L_8c3e26:
	brne_s r0,0,L_8c3e8c
L_8c3e28:
	mov_s r1,0x100c9b4
L_8c3e2e:
	mov_s r0,0x2b
L_8c3e30:
	bl.d L_8dcc10
L_8c3e34:
	ldb_s r2,[r14,0x10]
L_8c3e36:
	mov_s r0,L_8c6264-0x8c0000
L_8c3e3c:
	mov_s r1,r14
L_8c3e3e:
	mov_s r2,0x0
L_8c3e40:
	mov_s r3,0x1
L_8c3e42:
	mov r4,0x2710
L_8c3e4a:
	mov_s r5,r2
L_8c3e4c:
	bl.d L_8e0c0c
L_8c3e50:
	mov_s r6,r2
L_8c3e52:
	st.as r0,[r14,0xaa]
L_8c3e56:
	b_s L_8c3e8c
	.global L_8c3e58
L_8c3e58:
	mov_s r0,blink
L_8c3e5a:
	mov_s r1,0x11f3
L_8c3e60:
	bl L_8c9b28
L_8c3e64:
	b_s L_8c3dda
	.global L_8c3e66
L_8c3e66:
	mov_s r1,0x100c9e8
L_8c3e6c:
	mov_s r0,0x2b
L_8c3e6e:
	ldb_s r2,[r14,0x10]
L_8c3e70:
	mov_s r3,r16
L_8c3e72:
	bl.d L_8dcd00
L_8c3e76:
	mov r4,r16
L_8c3e7a:
	mov_s r0,r13
L_8c3e7c:
	bl.d L_8c4be8
L_8c3e80:
	mov_s r1,r16
L_8c3e82:
	mov_s r0,r14
L_8c3e84:
	bl.d L_8f7018
L_8c3e88:
	add r0,r0,0x234
	.global L_8c3e8c
L_8c3e8c:
	b L_8c0244
