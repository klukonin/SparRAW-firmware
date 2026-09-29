/* ucode_cmd_0x13_handler @ 0x92fcc4, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   enable RS = %d
 *   RS is active, aborting cid =%d
 *   restarting RS=%d
 *   disable RS cid= %d
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_uc, rs_abort, rs_start, uc_log__emit1, ucode_pm__set_busy_flag
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x13_handler
ucode_cmd_0x13_handler:
	.global L_92fcc4
L_92fcc4:
	push_s blink
L_92fcc6:
	bl L_920234
L_92fcca:
	ldb_s r2,[r0,0x1]
L_92fccc:
	mov_s r13,r0
L_92fcce:
	mov_s r14,0x0
L_92fcd0:
	breq r2,0x0,L_92fd4e
L_92fcd4:
	mov_s r1,0x10013d0
L_92fcda:
	bl.d L_92d1d0
L_92fcde:
	mov_s r0,0x20
L_92fce0:
	ldb_s r2,[r13]
L_92fce2:
	mov_s r1,0x802610
L_92fce8:
	asl_s r0,r2,0x2
L_92fcea:
	add1_s r0,r0,r0
L_92fcec:
	ld_s r0,[r1,r0]
L_92fcee:
	sub.f r0,r0,0x0
L_92fcf2:
	mov.ne r0,0x1
L_92fcf6:
	extb.f 0x0,r0
L_92fcfa:
	beq_s L_92fd10
L_92fcfc:
	mov_s r1,0x10013e0
L_92fd02:
	bl.d L_92d1d0
L_92fd06:
	mov_s r0,0x20
L_92fd08:
	bl.d L_92fb80
L_92fd0c:
	ldb_s r0,[r13]
L_92fd0e:
	mov_s r14,0x1
	.global L_92fd10
L_92fd10:
	ld_s r0,[gp,-0x8]
L_92fd12:
	ldb_s r1,[r13]
L_92fd14:
	bset r0,r0,r1
L_92fd18:
	st.as r0,[gp,-0x2]
L_92fd1c:
	ldb_s r0,[r13]
L_92fd1e:
	add_s r1,r13,0x2
L_92fd20:
	mul64 r0,0x26
L_92fd24:
	add r0,mlo,0x8027d0
L_92fd2c:
	bl.d L_920330
L_92fd30:
	mov_s r2,0x26
L_92fd32:
	brne r14,0x1,L_92fd6e
L_92fd36:
	mov_s r1,0x1001400
L_92fd3c:
	mov_s r0,0x20
L_92fd3e:
	bl.d L_92d1d0
L_92fd42:
	mov_s r2,r14
L_92fd44:
	ldb_s r0,[r13]
L_92fd46:
	bl.d L_9300ec
L_92fd4a:
	mov_s r1,0x0
L_92fd4c:
	b_s L_92fd6e
	.global L_92fd4e
L_92fd4e:
	mov_s r1,0x1001414
L_92fd54:
	mov_s r0,0x20
L_92fd56:
	bl.d L_92d1d0
L_92fd5a:
	ldb_s r2,[r13]
L_92fd5c:
	ld_s r0,[gp,-0x8]
L_92fd5e:
	ldb_s r1,[r13]
L_92fd60:
	bclr r0,r0,r1
L_92fd64:
	st.as r0,[gp,-0x2]
L_92fd68:
	bl.d L_93c874
L_92fd6c:
	mov_s r0,r14
	.global L_92fd6e
L_92fd6e:
	b L_9202a4
L_92fd72:
	nop_s
