/* bcon_sweep__next_sector @ 0x930e94, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_sweep_step_b, bcon_txss_sweep_step
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc
 */
	.section .text.bcon_sweep__next_sector,"ax",@progbits
	.global bcon_sweep__next_sector
bcon_sweep__next_sector:
	.global L_930e94
L_930e94:
	push_s blink
L_930e96:
	bl.d L_920210
L_930e9a:
	mov_s r4,r0
L_930e9c:
	mov_s r3,0x801c9c
L_930ea2:
	ldb_s r0,[r3,0xc]
L_930ea4:
	cmp_s r0,0x0
L_930ea6:
	mov_s r0,0x0
L_930ea8:
	beq_s L_930f30
	.global L_930eaa
L_930eaa:
	mov_s r13,0x801cbc
L_930eb0:
	ld_s r0,[r13,0x28]
L_930eb2:
	ld_s r1,[r13,0x20]
L_930eb4:
	rsub r2,r0,0x1
L_930eb8:
	add2 r14,r1,r2
L_930ebc:
	ld_s r2,[r14]
L_930ebe:
	mov_s r15,0x1
L_930ec0:
	bbit1 r2,0x1f,L_930ef4
L_930ec4:
	brne_s r2,0,L_930ef8
L_930ec6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_930ec8:
	st_s r0,[r13,0x28]
L_930eca:
	brne r0,0x2,L_930eaa
L_930ece:
	ldb_s r2,[r3,0xe]
L_930ed0:
	add_s r1,r1,0xc
L_930ed2:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_930ed4:
	extb_s r2,r2
L_930ed6:
	st_s r1,[r13,0x20]
L_930ed8:
	ldw_s r1,[r13,0x24]
L_930eda:
	mov_s r0,0x0
L_930edc:
	stb_s r2,[r3,0xe]
L_930ede:
	st_s r0,[r13,0x28]
L_930ee0:
	brne r2,r1,L_930eaa
L_930ee4:
	ldw_s r1,[r13,0x26]
L_930ee6:
	stb_s r0,[r3,0xe]
L_930ee8:
	brne_s r1,0,L_930f30
L_930eea:
	stw_s r15,[r13,0x26]
L_930eec:
	add r0,r3,0x10
L_930ef0:
	st_s r0,[r13,0x20]
L_930ef2:
	b_s L_930eaa
	.global L_930ef4
L_930ef4:
	mov_s r0,0x0
L_930ef6:
	b_s L_930efe
	.global L_930ef8
L_930ef8:
	norm r0,r2
L_930efc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_930efe
L_930efe:
	rsub r15,r0,0x1f
L_930f02:
	bclr r2,r2,r15
L_930f06:
	st_s r2,[r14]
L_930f08:
	ld_s r2,[r13,0x28]
L_930f0a:
	ld_s r1,[r1,0x8]
L_930f0c:
	/* asl_s r2,r2,0x5 */
	.byte 0x05,0xba
L_930f0e:
	add_s r0,r0,r2
L_930f10:
	add_s r0,r0,r1
L_930f12:
	bmsk_s r0,r0,0x5
L_930f14:
	stb_s r0,[r3,0xd]
L_930f16:
	ldb_s r0,[r3,0xc]
L_930f18:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_930f1a:
	extb_s r0,r0
L_930f1c:
	stb_s r0,[r3,0xc]
L_930f1e:
	ldw r0,[r4, 0x2]
L_930f22:
	ldw r1,[r4, 0x4]
L_930f26:
	add_s r0,r0,r1
L_930f28:
	ld_s r1,[r13,0x2c]
L_930f2a:
	sub_s r1,r1,r0
L_930f2c:
	mov_s r0,0x1
L_930f2e:
	st_s r1,[r13,0x2c]
	.global L_930f30
L_930f30:
	b L_92027c
