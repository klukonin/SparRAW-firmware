/* tx_initiator__build_tx_vector @ 0x933e90, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_flows_optimized_size.c
 * Зовут его: tx_initiator_flow
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, uc_divmod_signed, uc_sysassert
 * Глобалы (через gp): 0x8005fc, 0x800600
 */
	.section .text.tx_initiator__build_tx_vector,"ax",@progbits
	.global tx_initiator__build_tx_vector
tx_initiator__build_tx_vector:
	.global L_933e90
L_933e90:
	push_s blink
L_933e92:
	bl L_92020c
L_933e96:
	mov_s r14,r0
L_933e98:
	mov_s r16,r1
L_933e9a:
	mov_s r0,0xf000001
L_933ea0:
	mov_s r32,r0
L_933ea2:
	st.ab r0,[r25,0x4]
L_933ea6:
	bclr r25,r25,0xa
L_933eaa:
	ld_s r0,[gp,-0x44]
L_933eac:
	and r0,r0,0xfffff0ff
L_933eb4:
	st.as r0,[gp,-0x11]
L_933eb8:
	or r0,r0,0x1d000000
L_933ec0:
	mov_s r32,r0
L_933ec2:
	st.ab r0,[r25,0x4]
L_933ec6:
	bclr r25,r25,0xa
L_933eca:
	nop_s
L_933ecc:
	nop_s
L_933ece:
	nop_s
L_933ed0:
	lsr r13,r41,0x8
L_933ed4:
	bmsk_s r13,r13,0x3
L_933ed6:
	lsr r15,r41,0x10
L_933eda:
	bmsk_s r15,r15,0x4
L_933edc:
	st_s r15,[r14]
L_933ede:
	brhs.d r13,0x7,L_933eee
L_933ee2:
	sub_s r14,r13,0x1
L_933ee4:
	mov_s r0,r14
L_933ee6:
	bl.d L_9203c0
L_933eea:
	mov_s r1,0x3
L_933eec:
	b_s L_933ef2
	.global L_933eee
L_933eee:
	bmsk r1,r14,0x0
	.global L_933ef2
L_933ef2:
	cmp_s r13,0x0
L_933ef4:
	mov.eq r0,0x0
L_933ef8:
	beq_s L_933f8a
L_933efa:
	brne r16,0x1,L_933f88
L_933efe:
	brhs r14,0x8,L_933f76
L_933f02:
	ldb.x r14,[0x800cc0,r14]
L_933f0a:
	add r0,pcl,0xc
L_933f0e:
	add1_s r0,r0,r14
L_933f10:
	/* j_s.d r0 */
	.byte 0x20,0x78
L_933f12:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
L_933f14:
	mov_s r0,0x801a18
L_933f1a:
	add2 r1,r0,r1
L_933f1e:
	st_s r15,[r1,0x6c]
L_933f20:
	ld_s r2,[r0,0x6c]
L_933f22:
	ld_s r1,[r0,0x70]
L_933f24:
	bset_s r2,r2,0x18
L_933f26:
	asl_s r1,r1,0x8
L_933f28:
	bset_s r2,r2,0x1c
L_933f2a:
	ld_s r0,[r0,0x74]
L_933f2c:
	or_s r1,r1,r2
	.global L_933f2e
L_933f2e:
	asl_s r0,r0,0x10
L_933f30:
	or_s r0,r0,r1
L_933f32:
	b_s L_933f6a
L_933f34:
	mov_s r0,0x801a18
L_933f3a:
	add2 r1,r0,r1
L_933f3e:
	st_s r15,[r1,0x78]
L_933f40:
	ld_s r2,[r0,0x78]
L_933f42:
	ld_s r1,[r0,0x7c]
L_933f44:
	bset_s r2,r2,0x19
L_933f46:
	bset_s r2,r2,0x1c
L_933f48:
	asl_s r1,r1,0x8
L_933f4a:
	or_s r1,r1,r2
L_933f4c:
	ld r0,[r0, 0x80]
L_933f50:
	b_s L_933f2e
L_933f52:
	add2 r0,gp,r1
L_933f56:
	st.as r15,[r0,0x35]
L_933f5a:
	ld_s r0,[gp,0xd4]
L_933f5c:
	ld.as r1,[gp,0x36]
L_933f60:
	bset_s r0,r0,0x18
L_933f62:
	bset_s r0,r0,0x19
L_933f64:
	bset_s r0,r0,0x1c
L_933f66:
	asl_s r1,r1,0x8
L_933f68:
	or_s r0,r0,r1
	.global L_933f6a
L_933f6a:
	mov_s r32,r0
L_933f6c:
	st.ab r0,[r25,0x4]
L_933f70:
	bclr r25,r25,0xa
L_933f74:
	b_s L_933f88
	.global L_933f76
L_933f76:
	mov_s r0,blink
L_933f78:
	mov_s r2,0x1001d54
L_933f7e:
	mov_s r1,0x8e
L_933f80:
	bl.d L_925548
L_933f84:
	mov r3,0x1b7
	.global L_933f88
L_933f88:
	mov_s r0,0x1
	.global L_933f8a
L_933f8a:
	b L_920274
L_933f8e:
	nop_s
