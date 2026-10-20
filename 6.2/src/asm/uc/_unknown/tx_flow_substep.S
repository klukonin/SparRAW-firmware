/* tx_flow_substep @ 0x92fbc0, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_sta__flow_loop
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, rate_search__commit_mcs, rate_search__reset_stats
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_flow_substep
tx_flow_substep:
	.global L_92fbc0
L_92fbc0:
	push_s blink
L_92fbc2:
	bl.d L_920230
L_92fbc6:
	mov_s r5,r0
L_92fbc8:
	ldb_s r13,[r0]
L_92fbca:
	mov_s r1,0x802670
L_92fbd0:
	mul64 r13,0x2c
L_92fbd4:
	mov_s r0,mlo
L_92fbd6:
	add_s r14,r1,r0
L_92fbd8:
	ldb_s r3,[r14,0x1c]
L_92fbda:
	mul64 r13,0x26
L_92fbde:
	add_s r1,r1,r3
L_92fbe0:
	add r6,r1,r0
L_92fbe4:
	mov_s r0,0x8027d0
L_92fbea:
	add_s r15,r3,r0
L_92fbec:
	mov_s r2,mlo
L_92fbee:
	stb_s r3,[r14,0x1b]
L_92fbf0:
	add r4,r15,r2
L_92fbf4:
	ldb r1,[r6]
L_92fbf8:
	ldb r15,[r4, 0xd]
L_92fbfc:
	brge r1,r15,L_92fc0e
L_92fc00:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_92fc02:
	add1_s r13,r13,r13
L_92fc04:
	add r2,r13,0x802610
L_92fc0c:
	b_s L_92fcbc
	.global L_92fc0e
L_92fc0e:
	add_s r2,r2,r0
L_92fc10:
	brne r3,0x1,L_92fc38
L_92fc14:
	ldb_s r3,[r14,0x1]
L_92fc16:
	ldb_s r0,[r2,0x1b]
L_92fc18:
	mul64_s r0,r3
L_92fc1a:
	ldb_s r3,[r14,0xe]
L_92fc1c:
	mov_s r0,mlo
L_92fc1e:
	mul64 r3,0x64
L_92fc22:
	brge r0,mlo,L_92fc38
L_92fc26:
	mov_s r1,0x2
L_92fc28:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_92fc2a:
	add1_s r13,r13,r13
L_92fc2c:
	add r0,r13,0x802614
L_92fc34:
	st_s r1,[r0]
L_92fc36:
	b_s L_92fcbe
	.global L_92fc38
L_92fc38:
	ldb r7,[r14, 0x1c]
L_92fc3c:
	ldw_s r3,[r2,0x24]
L_92fc3e:
	ldw_s r0,[r2,0x22]
L_92fc40:
	asl_s r3,r3,0x10
L_92fc42:
	or_s r0,r0,r3
L_92fc44:
	norm r0,r0
L_92fc48:
	rsub r3,r0,0x1e
L_92fc4c:
	brne r3,r7,L_92fc56
L_92fc50:
	ldb r2,[r4]
L_92fc54:
	b_s L_92fc58
	.global L_92fc56
L_92fc56:
	ldb_s r2,[r2,0x1a]
	.global L_92fc58
L_92fc58:
	ldb r0,[r6, 0xd]
L_92fc5c:
	mul64 r0,0x64
L_92fc60:
	mov_s r0,mlo
L_92fc62:
	mul64_s r2,r1
L_92fc64:
	brge mlo,r0,L_92fc8a
L_92fc68:
	bl.d L_92fd8c
L_92fc6c:
	mov_s r0,r5
L_92fc6e:
	mov_s r1,0x3
L_92fc70:
	asl_s r0,r13,0x2
L_92fc72:
	add1_s r0,r0,r0
L_92fc74:
	add r2,r0,0x802614
L_92fc7c:
	st_s r1,[r2]
	.global L_92fc7e
L_92fc7e:
	ld_s r0,[gp,-0x4]
L_92fc80:
	bset r0,r0,r13
L_92fc84:
	st.as r0,[gp,-0x1]
L_92fc88:
	b_s L_92fcbe
	.global L_92fc8a
L_92fc8a:
	ldb r2,[r4]
L_92fc8e:
	mul64_s r2,r1
L_92fc90:
	mov_s r1,0x1
L_92fc92:
	cmp_s r0,mlo
L_92fc94:
	sub.gt r1,r1,r1
L_92fc98:
	bl.d L_93003c
L_92fc9c:
	mov_s r0,r5
L_92fc9e:
	asl_s r2,r13,0x2
L_92fca0:
	add1_s r2,r2,r2
L_92fca2:
	add_s r2,r2,0x802610
L_92fca8:
	brne r0,0x1,L_92fcb2
L_92fcac:
	mov_s r1,0x5
L_92fcae:
	st_s r1,[r2,0x4]
L_92fcb0:
	b_s L_92fc7e
	.global L_92fcb2
L_92fcb2:
	ldb_s r0,[r14,0x1c]
L_92fcb4:
	brne r0,0xa,L_92fcbc
L_92fcb8:
	mov_s r0,0x2
L_92fcba:
	st_s r0,[r2]
	.global L_92fcbc
L_92fcbc:
	ld_s r1,[r2,0x4]
	.global L_92fcbe
L_92fcbe:
	b.d L_92029c
L_92fcc2:
	mov_s r0,r1
