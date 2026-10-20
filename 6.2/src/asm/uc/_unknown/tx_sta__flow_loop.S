/* tx_sta__flow_loop @ 0x939e88, 512 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_sta__run_txop
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bitstream__push, mac__prepare_txrx_window, memset0_words_uc, rate_search__pick_tx_params, rx__program_mac_and_wait, rx_flow__run, sxd_hal__wait_slot2_busy2, tx__cca_check_and_send, tx_flow_substep, tx_mtp_queue_gate
 * Глобалы (через gp): 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_sta__flow_loop
tx_sta__flow_loop:
	.global L_939e88
L_939e88:
	push_s blink
L_939e8a:
	bl.d L_920230
L_939e8e:
	mov_s r1,0x8
L_939e90:
	sub_s sp,sp,0x8
L_939e92:
	mov_s r14,r0
L_939e94:
	bl.d L_920a84
L_939e98:
	mov_s r0,sp
L_939e9a:
	mov_s r15,0x0
L_939e9c:
	b_s L_939fca
	.global L_939e9e
L_939e9e:
	and.f 0x0,r0,0xe00
L_939ea6:
	bne_s L_939ee8
L_939ea8:
	bmsk.f 0x0,r0,0x4
L_939eac:
	bne_s L_939fc2
L_939eae:
	bbit1 r0,0x7,L_939ef0
L_939eb2:
	mov_s r0,0x802978
L_939eb8:
	bl.d L_938b90
L_939ebc:
	ld_s r0,[r0,0x78]
L_939ebe:
	cmp_s r15,0x0
L_939ec0:
	beq_s L_939fc0
L_939ec2:
	ld_s r0,[r14]
L_939ec4:
	mov_s r1,0x802610
L_939eca:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_939ecc:
	add1_s r0,r0,r0
L_939ece:
	ld_s r0,[r1,r0]
L_939ed0:
	sub.f r0,r0,0x0
L_939ed4:
	mov.ne r0,0x1
L_939ed8:
	extb.f 0x0,r0
L_939edc:
	beq_s L_939fa4
L_939ede:
	mov_s r0,r14
L_939ee0:
	bl.d L_9301fc
L_939ee4:
	mov_s r1,0x0
L_939ee6:
	b_s L_939fb6
	.global L_939ee8
L_939ee8:
	bclr_s r0,r0,0x8
L_939eea:
	st.as r0,[gp,0x34]
L_939eee:
	b_s L_939fd8
	.global L_939ef0
L_939ef0:
	ld_s r0,[r14]
L_939ef2:
	mov_s r1,0x802610
L_939ef8:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_939efa:
	add1_s r0,r0,r0
L_939efc:
	ld_s r0,[r1,r0]
L_939efe:
	sub.f r0,r0,0x0
L_939f02:
	mov.ne r0,0x1
L_939f06:
	extb.f 0x0,r0
L_939f0a:
	bne_s L_939f58
L_939f0c:
	mov_s r0,0x801498
L_939f12:
	ld_s r0,[r0,0x8]
L_939f14:
	mov_s r13,0x8021b8
L_939f1a:
	bbit0 r0,0x9,L_939f22
L_939f1e:
	ldb_s r1,[r13,0xb]
L_939f20:
	b_s L_939f24
	.global L_939f22
L_939f22:
	ldb_s r1,[r13,0x9]
	.global L_939f24
L_939f24:
	mov_s r0,sp
L_939f26:
	mov_s r2,0x1
L_939f28:
	bl.d L_93cd00
L_939f2c:
	ld_s r3,[r13,0xc]
L_939f2e:
	breq r0,0x1,L_939f40
	.global L_939f32
L_939f32:
	bl L_939aa4
L_939f36:
	ld_s r0,[gp,0xd0]
L_939f38:
	bclr_s r0,r0,0x7
L_939f3a:
	st.as r0,[gp,0x34]
L_939f3e:
	b_s L_939fc0
	.global L_939f40
L_939f40:
	ld_s r0,[r13,0x20]
L_939f42:
	bbit0 r0,0x3,L_939f70
L_939f46:
	ld_s r1,[r14]
L_939f48:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_939f4a:
	add2_s r1,r1,r1
L_939f4c:
	add_s r1,r1,0x857e38
L_939f52:
	ldb_s r0,[r1,0x11]
L_939f54:
	bset_s r0,r0,0x3
L_939f56:
	b_s L_939fa0
	.global L_939f58
L_939f58:
	mov_s r0,r14
L_939f5a:
	bl.d L_9301fc
L_939f5e:
	mov_s r1,0x1
L_939f60:
	brne r0,0x2,L_939f32
L_939f64:
	mov_s r0,0x8021b8
L_939f6a:
	ld_s r0,[r0,0x20]
L_939f6c:
	bbit1 r0,0x1,L_939f7e
	.global L_939f70
L_939f70:
	mov_s r0,r14
L_939f72:
	mov_s r1,0x1
L_939f74:
	mov_s r2,r1
L_939f76:
	bl.d L_924d00
L_939f7a:
	mov_s r3,0x0
L_939f7c:
	b_s L_939fca
	.global L_939f7e
L_939f7e:
	ld_s r1,[r14]
L_939f80:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_939f82:
	add2_s r1,r1,r1
L_939f84:
	add_s r1,r1,0x857e38
L_939f8a:
	ldb_s r0,[r1,0x11]
L_939f8c:
	bset_s r0,r0,0x1
L_939f8e:
	b_s L_939fa0
	.global L_939f90
L_939f90:
	ld_s r1,[r14]
L_939f92:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_939f94:
	add2_s r1,r1,r1
L_939f96:
	add_s r1,r1,0x857e38
L_939f9c:
	ldb_s r0,[r1,0x11]
L_939f9e:
	bset_s r0,r0,0x0
	.global L_939fa0
L_939fa0:
	stb_s r0,[r1,0x11]
L_939fa2:
	b_s L_939f70
	.global L_939fa4
L_939fa4:
	mov_s r0,sp
L_939fa6:
	mov_s r3,0x8021b8
L_939fac:
	ldb_s r1,[r3,0x9]
L_939fae:
	mov_s r2,0x0
L_939fb0:
	bl.d L_93cd00
L_939fb4:
	ld_s r3,[r3,0xc]
	.global L_939fb6
L_939fb6:
	mov_s r1,0x1
L_939fb8:
	mov_s r0,0x8006bc
L_939fbe:
	st_s r1,[r0]
	.global L_939fc0
L_939fc0:
	mov_s r15,0x0
	.global L_939fc2
L_939fc2:
	ld_s r0,[gp,0xd0]
L_939fc4:
	bmsk.f 0x0,r0,0x4
L_939fc8:
	bne_s L_93a018
	.global L_939fca
L_939fca:
	ld_s r0,[gp,0xd0]
L_939fcc:
	mov_s r1,r0
L_939fce:
	bic r1,r1,-0x141
L_939fd2:
	cmp r1,0x100
L_939fd6:
	beq_s L_939e9e
	.global L_939fd8
L_939fd8:
	ld_s r0,[r14]
L_939fda:
	mov_s r1,0x857e49
L_939fe0:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_939fe2:
	add2_s r0,r0,r0
L_939fe4:
	ldb_s r0,[r1,r0]
L_939fe6:
	brne_s r0,0,L_939ff4
L_939fe8:
	mov_s r0,0x80141c
L_939fee:
	ld_s r0,[r0,0x8]
L_939ff0:
	bbit0 r0,0x1,L_93a012
	.global L_939ff4
L_939ff4:
	mov_s r0,0x80242c
L_939ffa:
	ldw_s r0,[r0,0x8]
L_939ffc:
	cmp_s r0,0x0
L_939ffe:
	mov.eq r0,r14
L_93a002:
	mov.eq r1,0x1
L_93a006:
	mov.eq r2,r1
L_93a00a:
	bl.eq.d L_924d00
L_93a00e:
	mov.eq r3,0x0
	.global L_93a012
L_93a012:
	b.d L_92029c
L_93a016:
	add_s sp,sp,0x8
	.global L_93a018
L_93a018:
	ld_s r0,[r14]
L_93a01a:
	mov_s r1,0x802610
L_93a020:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93a022:
	add1_s r0,r0,r0
L_93a024:
	ld_s r0,[r1,r0]
L_93a026:
	sub.f r0,r0,0x0
L_93a02a:
	mov.ne r0,0x1
L_93a02e:
	extb.f 0x0,r0
L_93a032:
	beq_s L_93a04a
L_93a034:
	bl.d L_92fbc0
L_93a038:
	mov_s r0,r14
L_93a03a:
	brne r0,0x2,L_93a04a
L_93a03e:
	mov_s r0,0x8021b8
L_93a044:
	ld_s r0,[r0,0x20]
L_93a046:
	bbit1 r0,0x0,L_939f90
	.global L_93a04a
L_93a04a:
	mov_s r0,0x2
L_93a04c:
	bset_s r0,r0,0x19
L_93a04e:
	mov_s r32,r0
L_93a050:
	st.ab r0,[r25,0x4]
L_93a054:
	bclr r25,r25,0xa
L_93a058:
	bl.d L_936cc8
L_93a05c:
	ldw_s r0,[gp,-0x1e]
L_93a05e:
	breq_s r0,0,L_93a070
L_93a060:
	bl.d L_930dd4
L_93a064:
	mov_s r15,0x1
L_93a066:
	mov_s r0,0x8006bc
L_93a06c:
	st_s r15,[r0,0x4]
L_93a06e:
	b_s L_939fca
	.global L_93a070
L_93a070:
	mov_s r0,r14
L_93a072:
	bl.d L_920b58
L_93a076:
	mov_s r1,0x2
L_93a078:
	mov_s r1,0x802210
L_93a07e:
	ld_s r0,[r1,0xc]
L_93a080:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93a082:
	st_s r0,[r1,0xc]
L_93a084:
	b_s L_939fca
L_93a086:
	nop_s
