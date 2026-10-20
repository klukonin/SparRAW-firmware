/* ucode_cmd_0x08_handler @ 0x93aea8, 848 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bit_scan_msb, field_set_0x00__920cd4, field_set_0x00__92ebe0, mac__program_tx_with_qid, mac__set_chain_mask_924f00, mac_q__tx_ppdu_cmd08, macq__probe_empty, tx_ctx__alloc_next, uc_evt__enqueue, uc_evt_queue__peek_field04
 * Глобалы (через gp): 0x800564, 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x08_handler
ucode_cmd_0x08_handler:
	.global L_93aea8
L_93aea8:
	push_s blink
L_93aeaa:
	bl L_920224
L_93aeae:
	mov_s r14,r0
L_93aeb0:
	bl.d L_9384d4
L_93aeb4:
	mov_s r0,0x1
L_93aeb6:
	mov_s r15,r0
L_93aeb8:
	ldb_s r0,[r14]
L_93aeba:
	st_s r0,[r15,0x4]
L_93aebc:
	ld_s r0,[r14,0x8]
L_93aebe:
	cmp_s r0,0x4
L_93aec0:
	mov_s r13,0x0
L_93aec2:
	bne_s L_93afca
L_93aec4:
	ldb_s r13,[r14]
L_93aec6:
	ldb r16,[r14, 0x1]
L_93aeca:
	bl.d L_92dab8
L_93aece:
	mov_s r0,r13
L_93aed0:
	cmp_s r0,0x0
L_93aed2:
	beq_s L_93afc0
	.global L_93aed4
L_93aed4:
	mov_s r0,0x886500
L_93aeda:
	ld_s r0,[r0,0x6c]
L_93aedc:
	bmsk.f 0x0,r0,0x3
L_93aee0:
	mov.ne r0,blink
L_93aee4:
	bl.ne.d L_926618
L_93aee8:
	mov.ne r1,0x3
L_93aeec:
	mov_s r0,0x1c000006
L_93aef2:
	mov_s r32,r0
L_93aef4:
	st.ab r0,[r25,0x4]
L_93aef8:
	bclr r25,r25,0xa
L_93aefc:
	asl_s r0,r13,0x4
L_93aefe:
	or r0,r0,0x46004008
L_93af06:
	mov_s r32,r0
L_93af08:
	st.ab r0,[r25,0x4]
L_93af0c:
	bclr r25,r25,0xa
L_93af10:
	mov_s r1,0x8022c8
L_93af16:
	ld_s r0,[r1,0x14]
L_93af18:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93af1a:
	st_s r0,[r1,0x14]
	.global L_93af1c
L_93af1c:
	mov_s r0,r53
L_93af1e:
	bbit0 r0,0x2,L_93af1c
L_93af22:
	ld_s r0,[gp,-0x44]
L_93af24:
	and r0,r0,0xfff0ffff
L_93af2c:
	bset r1,r0,0x10
L_93af30:
	or r0,r0,0x1d010000
L_93af38:
	st.as r1,[gp,-0x11]
L_93af3c:
	mov_s r32,r0
L_93af3e:
	st.ab r0,[r25,0x4]
L_93af42:
	bclr r25,r25,0xa
L_93af46:
	nop_s
L_93af48:
	nop_s
L_93af4a:
	nop_s
	.global L_93af4c
L_93af4c:
	mov_s r0,r47
L_93af4e:
	bbit1 r0,0x0,L_93af4c
L_93af52:
	asl r0,r16,0x8
L_93af56:
	bset_s r0,r0,0x1a
L_93af58:
	bset_s r0,r0,0x1e
L_93af5a:
	or_s r13,r13,r0
L_93af5c:
	bset_s r13,r13,0x13
L_93af5e:
	bset_s r13,r13,0x15
L_93af60:
	mov_s r32,r13
L_93af62:
	st.ab r13,[r25,0x4]
L_93af66:
	bclr r25,r25,0xa
L_93af6a:
	mov_s r0,0x45000001
L_93af70:
	mov_s r32,r0
L_93af72:
	st.ab r0,[r25,0x4]
L_93af76:
	bclr r25,r25,0xa
L_93af7a:
	mov_s r0,0x460001f1
L_93af80:
	mov_s r32,r0
L_93af82:
	st.ab r0,[r25,0x4]
L_93af86:
	bclr r25,r25,0xa
L_93af8a:
	bl.d L_92d93c
L_93af8e:
	ld_s r0,[r15,0x4]
	.global L_93af90
L_93af90:
	mov_s r0,r43
L_93af92:
	bbit0 r0,0x1f,L_93af90
L_93af96:
	mov_s r0,r51
L_93af98:
	bmsk r1,r0,0x3
L_93af9c:
	st.as r1,[gp,0x38]
L_93afa0:
	lsr_s r0,r0,0x4
L_93afa2:
	st.as r0,[gp,0x39]
	.global L_93afa6
L_93afa6:
	mov_s r0,r45
L_93afa8:
	bbit0 r0,0x1f,L_93afa6
L_93afac:
	mov_s r0,r43
L_93afae:
	btst_s r0,0x1b
L_93afb0:
	beq L_93b1f4
L_93afb4:
	ldb_s r0,[r14,0x1]
L_93afb6:
	bl.d L_937840
L_93afba:
	ldb_s r1,[r14]
L_93afbc:
	b L_93b1f4
	.global L_93afc0
L_93afc0:
	mov_s r0,blink
L_93afc2:
	bl.d L_926618
L_93afc6:
	mov_s r1,0x7
L_93afc8:
	b_s L_93aed4
	.global L_93afca
L_93afca:
	brne r0,0x3,L_93b01a
L_93afce:
	ldb_s r0,[r14]
L_93afd0:
	bl.d L_93a6d8
L_93afd4:
	ldb_s r1,[r14,0x1]
L_93afd6:
	bl.d L_92d93c
L_93afda:
	ld_s r0,[r15,0x4]
	.global L_93afdc
L_93afdc:
	mov_s r0,r43
L_93afde:
	bbit0 r0,0x1f,L_93afdc
L_93afe2:
	mov_s r0,r51
L_93afe4:
	bmsk r1,r0,0x3
L_93afe8:
	st.as r1,[gp,0x38]
L_93afec:
	lsr_s r0,r0,0x4
L_93afee:
	st.as r0,[gp,0x39]
	.global L_93aff2
L_93aff2:
	mov_s r0,r45
L_93aff4:
	bbit0 r0,0x1f,L_93aff2
L_93aff8:
	ld_s r0,[r14,0x4]
L_93affa:
	cmp_s r0,0x3
L_93affc:
	bne L_93b1f4
L_93b000:
	mov_s r0,r43
L_93b002:
	btst_s r0,0x1b
L_93b004:
	beq L_93b1f4
L_93b008:
	mov_s r1,0x802940
L_93b00e:
	ldb_s r2,[r14]
L_93b010:
	ld_s r0,[r1,0x8]
L_93b012:
	bset r0,r0,r2
L_93b016:
	st_s r0,[r1,0x8]
L_93b018:
	b_s L_93b1f4
	.global L_93b01a
L_93b01a:
	brne r0,0x1,L_93b09c
L_93b01e:
	ld_s r0,[gp,-0x34]
L_93b020:
	brne r0,0x2,L_93b02c
L_93b024:
	bl.d L_926808
L_93b028:
	st.as r13,[gp,-0xd]
	.global L_93b02c
L_93b02c:
	ld_s r0,[r14,0x10]
L_93b02e:
	bbit0 r0,0x1,L_93b05c
L_93b032:
	ldb_s r0,[r14]
L_93b034:
	bl.d L_93a6d8
L_93b038:
	ldb_s r1,[r14,0x1]
L_93b03a:
	bl.d L_92d93c
L_93b03e:
	ld_s r0,[r15,0x4]
	.global L_93b040
L_93b040:
	mov_s r0,r43
L_93b042:
	bbit0 r0,0x1f,L_93b040
L_93b046:
	mov_s r0,r51
L_93b048:
	bmsk r1,r0,0x3
L_93b04c:
	st.as r1,[gp,0x38]
L_93b050:
	lsr_s r0,r0,0x4
L_93b052:
	st.as r0,[gp,0x39]
	.global L_93b056
L_93b056:
	mov_s r0,r45
L_93b058:
	bbit0 r0,0x1f,L_93b056
	.global L_93b05c
L_93b05c:
	ld_s r0,[r14,0x4]
L_93b05e:
	brne r0,0x3,L_93b07c
L_93b062:
	ldb_s r0,[r14,0x1]
L_93b064:
	mov_s r1,0x801124
L_93b06a:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93b06c:
	add2_s r0,r0,r0
L_93b06e:
	ld_s r2,[r1,r0]
L_93b070:
	mov_s r1,0x802940
L_93b076:
	ld_s r0,[r1,0x8]
L_93b078:
	bic_s r0,r0,r2
L_93b07a:
	st_s r0,[r1,0x8]
	.global L_93b07c
L_93b07c:
	bl L_927320
L_93b080:
	mov_s r13,r0
L_93b082:
	ldb_s r0,[r14]
L_93b084:
	bl.d L_9364c8
L_93b088:
	st_s r0,[r13]
L_93b08a:
	st_s r0,[r13,0x4]
L_93b08c:
	mov_s r3,0x0
L_93b08e:
	st_s r3,[r13,0x8]
L_93b090:
	mov_s r0,r13
L_93b092:
	mov_s r1,0x8
L_93b094:
	bl.d L_927958
L_93b098:
	mov_s r2,0xc
L_93b09a:
	mov_s r13,0x1
	.global L_93b09c
L_93b09c:
	ld_s r1,[r14,0xc]
L_93b09e:
	ldb_s r0,[r14]
L_93b0a0:
	lsr_s r1,r1,0x6
L_93b0a2:
	bmsk r2,r1,0x0
L_93b0a6:
	mov_s r1,0x802228
L_93b0ac:
	add1_s r0,r0,r0
L_93b0ae:
	add_s r0,r0,r1
L_93b0b0:
	stb_s r2,[r0]
L_93b0b2:
	ld_s r2,[r14,0xc]
L_93b0b4:
	ldb_s r0,[r14]
L_93b0b6:
	lsr_s r2,r2,0x5
L_93b0b8:
	add1_s r0,r0,r0
L_93b0ba:
	add_s r3,r1,0x1
L_93b0bc:
	add_s r3,r3,r0
L_93b0be:
	bmsk_s r2,r2,0x0
L_93b0c0:
	stb_s r2,[r3]
L_93b0c2:
	ldb_s r0,[r14]
L_93b0c4:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_93b0c6:
	add1_s r0,r0,r0
L_93b0c8:
	ldb_s r2,[r14,0x1]
L_93b0ca:
	add_s r1,r1,r0
L_93b0cc:
	stb_s r2,[r1]
L_93b0ce:
	ld_s r0,[r14,0x4]
L_93b0d0:
	cmp_s r0,0x0
L_93b0d2:
	cmp.ne r0,0x1
L_93b0d6:
	beq_s L_93b0e6
L_93b0d8:
	breq r0,0x3,L_93b106
L_93b0dc:
	mov_s r0,blink
L_93b0de:
	bl.d L_926618
L_93b0e2:
	mov_s r1,0x83
L_93b0e4:
	b_s L_93b1f4
	.global L_93b0e6
L_93b0e6:
	mov r18,0x800414
L_93b0ee:
	ldb_s r0,[r14,0x1]
L_93b0f0:
	mov_s r15,0x801104
L_93b0f6:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93b0f8:
	add2_s r0,r0,r0
L_93b0fa:
	add r1,r15,0x14
L_93b0fe:
	add r17,r1,r0
L_93b102:
	mov_s r1,0x4
L_93b104:
	b_s L_93b160
	.global L_93b106
L_93b106:
	ldb_s r0,[r14,0x1]
L_93b108:
	mov_s r15,0x801104
L_93b10e:
	add r2,r15,0x18
L_93b112:
	brne r0,0x8,L_93b120
L_93b116:
	mov_s r0,0xff
L_93b118:
	brne_s r13,0,L_93b11c
L_93b11a:
	ldb_s r0,[r14]
	.global L_93b11c
L_93b11c:
	st.as r0,[gp,-0x30]
	.global L_93b120
L_93b120:
	ldb_s r1,[r14,0x1]
L_93b122:
	mov r18,0x800424
L_93b12a:
	asl_s r0,r1,0x4
L_93b12c:
	add2_s r0,r0,r0
L_93b12e:
	add r17,r2,r0
L_93b132:
	mov r16,0x6
L_93b136:
	brge.d r1,0x8,L_93b150
L_93b13a:
	ldb_s r2,[r14]
L_93b13c:
	ld_s r0,[r14,0x8]
L_93b13e:
	brne_s r0,0,L_93b14c
L_93b140:
	mov_s r0,0x801be8
L_93b146:
	bl L_920cd4
L_93b14a:
	b_s L_93b15e
	.global L_93b14c
L_93b14c:
	breq r0,0x1,L_93b154
	.global L_93b150
L_93b150:
	mov_s r1,r16
L_93b152:
	b_s L_93b162
	.global L_93b154
L_93b154:
	mov_s r0,0x801be8
L_93b15a:
	bl L_92ebe0
	.global L_93b15e
L_93b15e:
	mov_s r1,r16
	.global L_93b160
L_93b160:
	ldb_s r2,[r14]
	.global L_93b162
L_93b162:
	add r16,r15,0x24
L_93b166:
	add r4,r15,0x1c
L_93b16a:
	mov_s r3,0x0
L_93b16c:
	bset r3,r3,r2
L_93b170:
	breq_s r13,0,L_93b17c
L_93b172:
	ld_s r0,[gp,0x3c]
L_93b174:
	bic_s r0,r0,r3
L_93b176:
	st.as r0,[gp,0xf]
L_93b17a:
	ldb_s r2,[r14]
	.global L_93b17c
L_93b17c:
	ld r3,[r18]
L_93b180:
	mov_s r0,0x0
L_93b182:
	bset r0,r0,r2
L_93b186:
	cmp_s r13,0x0
L_93b188:
	bic.ne r3,r3,r0
L_93b18c:
	or.eq r3,r3,r0
L_93b190:
	mov_s r0,0x886d8c
L_93b196:
	add2_s r0,r0,r1
L_93b198:
	st r3,[r18]
L_93b19c:
	st_s r3,[r0]
L_93b19e:
	ldb_s r2,[r14]
L_93b1a0:
	mov_s r1,0x0
L_93b1a2:
	ld r0,[r17]
L_93b1a6:
	bset r1,r1,r2
L_93b1aa:
	cmp_s r13,0x0
L_93b1ac:
	bic.ne r0,r0,r1
L_93b1b0:
	or.eq r0,r0,r1
L_93b1b4:
	st r0,[r17]
L_93b1b8:
	ldb_s r0,[r14,0x1]
L_93b1ba:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93b1bc:
	add2_s r0,r0,r0
L_93b1be:
	add_s r15,r15,r0
L_93b1c0:
	ld_s r0,[r15,0x14]
L_93b1c2:
	ld_s r1,[r15,0x1c]
L_93b1c4:
	or_s r0,r0,r1
L_93b1c6:
	ld_s r1,[r15,0x18]
L_93b1c8:
	or_s r0,r0,r1
L_93b1ca:
	st_s r0,[r15,0x20]
L_93b1cc:
	ldb_s r0,[r14,0x1]
L_93b1ce:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93b1d0:
	add2_s r0,r0,r0
L_93b1d2:
	bl.d L_92d034
L_93b1d6:
	ld r0,[r4,r0]
L_93b1da:
	ldb_s r1,[r14,0x1]
L_93b1dc:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_93b1de:
	add2_s r1,r1,r1
L_93b1e0:
	add_s r1,r1,r16
L_93b1e2:
	st_s r0,[r1]
L_93b1e4:
	ld_s r0,[r14,0x8]
L_93b1e6:
	brne_s r0,0,L_93b1f4
L_93b1e8:
	ld_s r0,[r14,0x4]
L_93b1ea:
	brne r0,0x3,L_93b1f4
L_93b1ee:
	mov_s r0,0x1
L_93b1f0:
	stb r0,[gp, -0xdd]
	.global L_93b1f4
L_93b1f4:
	b L_920284
