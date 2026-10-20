/* tx_flow_substep @ 0x92bdc8, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_flow_size_step
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, rate_search__commit_mcs, rate_search__reset_stats
 */
	.section .text.tx_flow_substep,"ax",@progbits
	.global tx_flow_substep
tx_flow_substep:
	.global L_92bdc8
L_92bdc8:
	push_s blink
L_92bdca:
	bl.d L_920210
L_92bdce:
	mov_s r5,r0
L_92bdd0:
	ldb_s r13,[r0]
L_92bdd2:
	mov_s r1,0x801738
L_92bdd8:
	mul64 r13,0x2c
L_92bddc:
	mov_s r0,mlo
L_92bdde:
	add_s r14,r1,r0
L_92bde0:
	ldb_s r3,[r14,0x1c]
L_92bde2:
	mul64 r13,0x26
L_92bde6:
	add_s r1,r1,r3
L_92bde8:
	add r6,r1,r0
L_92bdec:
	mov_s r0,0x801898
L_92bdf2:
	add_s r15,r3,r0
L_92bdf4:
	mov_s r2,mlo
L_92bdf6:
	stb_s r3,[r14,0x1b]
L_92bdf8:
	add r4,r15,r2
L_92bdfc:
	ldb r1,[r6]
L_92be00:
	ldb r15,[r4, 0xd]
L_92be04:
	brge r1,r15,L_92be16
L_92be08:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_92be0a:
	add1_s r13,r13,r13
L_92be0c:
	add r2,r13,0x8016d8
L_92be14:
	b_s L_92bec4
	.global L_92be16
L_92be16:
	add_s r2,r2,r0
L_92be18:
	brne r3,0x1,L_92be40
L_92be1c:
	ldb_s r3,[r14,0x1]
L_92be1e:
	ldb_s r0,[r2,0x1b]
L_92be20:
	mul64_s r0,r3
L_92be22:
	ldb_s r3,[r14,0xe]
L_92be24:
	mov_s r0,mlo
L_92be26:
	mul64 r3,0x64
L_92be2a:
	brge r0,mlo,L_92be40
L_92be2e:
	mov_s r1,0x2
L_92be30:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_92be32:
	add1_s r13,r13,r13
L_92be34:
	add r0,r13,0x8016dc
L_92be3c:
	st_s r1,[r0]
L_92be3e:
	b_s L_92bec6
	.global L_92be40
L_92be40:
	ldb r7,[r14, 0x1c]
L_92be44:
	ldw_s r3,[r2,0x24]
L_92be46:
	ldw_s r0,[r2,0x22]
L_92be48:
	asl_s r3,r3,0x10
L_92be4a:
	or_s r0,r0,r3
L_92be4c:
	norm r0,r0
L_92be50:
	rsub r3,r0,0x1e
L_92be54:
	brne r3,r7,L_92be5e
L_92be58:
	ldb r2,[r4]
L_92be5c:
	b_s L_92be60
	.global L_92be5e
L_92be5e:
	ldb_s r2,[r2,0x1a]
	.global L_92be60
L_92be60:
	ldb r0,[r6, 0xd]
L_92be64:
	mul64 r0,0x64
L_92be68:
	mov_s r0,mlo
L_92be6a:
	mul64_s r2,r1
L_92be6c:
	brge mlo,r0,L_92be92
L_92be70:
	bl.d L_92c034
L_92be74:
	mov_s r0,r5
L_92be76:
	mov_s r1,0x3
L_92be78:
	asl_s r0,r13,0x2
L_92be7a:
	add1_s r0,r0,r0
L_92be7c:
	add r2,r0,0x8016dc
L_92be84:
	st_s r1,[r2]
	.global L_92be86
L_92be86:
	ld_s r0,[gp,-0x8]
L_92be88:
	bset r0,r0,r13
L_92be8c:
	st.as r0,[gp,-0x2]
L_92be90:
	b_s L_92bec6
	.global L_92be92
L_92be92:
	ldb r2,[r4]
L_92be96:
	mul64_s r2,r1
L_92be98:
	mov_s r1,0x1
L_92be9a:
	cmp_s r0,mlo
L_92be9c:
	sub.gt r1,r1,r1
L_92bea0:
	bl.d L_92c29c
L_92bea4:
	mov_s r0,r5
L_92bea6:
	asl_s r2,r13,0x2
L_92bea8:
	add1_s r2,r2,r2
L_92beaa:
	add_s r2,r2,0x8016d8
L_92beb0:
	brne r0,0x1,L_92beba
L_92beb4:
	mov_s r1,0x5
L_92beb6:
	st_s r1,[r2,0x4]
L_92beb8:
	b_s L_92be86
	.global L_92beba
L_92beba:
	ldb_s r0,[r14,0x1c]
L_92bebc:
	brne r0,0xa,L_92bec4
L_92bec0:
	mov_s r0,0x2
L_92bec2:
	st_s r0,[r2]
	.global L_92bec4
L_92bec4:
	ld_s r1,[r2,0x4]
	.global L_92bec6
L_92bec6:
	b.d L_92027c
L_92beca:
	mov_s r0,r1
