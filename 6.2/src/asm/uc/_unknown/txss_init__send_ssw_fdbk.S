/* txss_init__send_ssw_fdbk @ 0x93c0d4, 548 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_init__send_fdbk_wait_ack
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bits__set_u8_s0_w5_uc, bits__uc_set32_s4_w4, direct_tx__issue_cmd_33, direct_tx__program_cmd34, mac__program_tx_common, mac__set_rf_chain_state__with_sta_sector, mac_evt__enable_bit_sync_b, sls__bits_uc_set32_s2_w2, sls__bits_uc_set32_s8_w4, tx_fifo__write_bytes
 * Глобалы (через gp): 0x8005f4, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss_init__send_ssw_fdbk
txss_init__send_ssw_fdbk:
	.global L_93c0d4
L_93c0d4:
	push_s blink
L_93c0d6:
	bl L_920234
L_93c0da:
	sub_s sp,sp,0x18
L_93c0dc:
	mov_s r13,r1
L_93c0de:
	mov_s r14,r2
L_93c0e0:
	mov_s r0,0x20000400
L_93c0e6:
	mov_s r32,r0
L_93c0e8:
	st.ab r0,[r25,0x4]
L_93c0ec:
	bclr r25,r25,0xa
L_93c0f0:
	breq_s r14,0,L_93c13a
L_93c0f2:
	mov_s r0,0x3e
L_93c0f4:
	asl_s r0,r0,0x18
L_93c0f6:
	mov_s r32,r0
L_93c0f8:
	st.ab r0,[r25,0x4]
L_93c0fc:
	bclr r25,r25,0xa
L_93c100:
	mov_s r0,0x37000020
L_93c106:
	mov_s r32,r0
L_93c108:
	st.ab r0,[r25,0x4]
L_93c10c:
	bclr r25,r25,0xa
L_93c110:
	mov_s r1,0x8022c8
L_93c116:
	ld_s r0,[r1,0xc]
L_93c118:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93c11a:
	st_s r0,[r1,0xc]
L_93c11c:
	ld_s r0,[gp,0x178]
L_93c11e:
	mov_s r1,0x802940
L_93c124:
	bclr_s r0,r0,0x18
L_93c126:
	ld_s r1,[r1]
L_93c128:
	bclr_s r0,r0,0x19
L_93c12a:
	asl_s r1,r1,0x18
L_93c12c:
	or_s r0,r0,r1
L_93c12e:
	st.as r0,[gp,0x5e]
L_93c132:
	mov_s r1,0x889480
L_93c138:
	st_s r0,[r1,0x8]
	.global L_93c13a
L_93c13a:
	mov_s r0,0x886d00
L_93c140:
	ld_s r0,[r0]
L_93c142:
	extw_s r0,r0
L_93c144:
	lsr r1,r0,0x8
L_93c148:
	mov_s r0,0x80158c
L_93c14e:
	ld_s r0,[r0,0x14]
L_93c150:
	add_s r0,r0,r1
L_93c152:
	bset_s r0,r0,0x18
L_93c154:
	bset_s r0,r0,0x1a
L_93c156:
	bset_s r0,r0,0x1c
L_93c158:
	mov_s r32,r0
L_93c15a:
	st.ab r0,[r25,0x4]
L_93c15e:
	bclr r25,r25,0xa
L_93c162:
	mov_s r0,0x14000007
L_93c168:
	mov_s r32,r0
L_93c16a:
	st.ab r0,[r25,0x4]
L_93c16e:
	bclr r25,r25,0xa
L_93c172:
	mov_s r3,0x0
L_93c174:
	mov_s r0,sp
L_93c176:
	mov_s r1,r3
L_93c178:
	bl.d L_93e390
L_93c17c:
	stw r3,[sp]
L_93c180:
	mov_s r1,0x1
L_93c182:
	bl.d L_93e3d8
L_93c186:
	mov_s r2,sp
L_93c188:
	mov_s r1,0x6
L_93c18a:
	bl L_93e3f0
L_93c18e:
	mov_s r1,0x9
L_93c190:
	bl L_93e420
L_93c194:
	mov_s r0,0x80212c
L_93c19a:
	ldb_s r14,[r0,0x1]
L_93c19c:
	ldb_s r1,[r0]
L_93c19e:
	/* asl_s r14,r14,0x6 */
	.byte 0x06,0xbe
L_93c1a0:
	or_s r1,r1,r14
L_93c1a2:
	stb_s r1,[sp,0x10]
L_93c1a4:
	ld_s r1,[r0,0x8]
L_93c1a6:
	stb r3,[sp, 0x12]
L_93c1aa:
	sub_s r1,r1,0x13
L_93c1ac:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93c1ae:
	stb r1,[sp, 0x11]
L_93c1b2:
	mov_s r1,r3
L_93c1b4:
	stb_s r1,[r2,0x13]
L_93c1b6:
	lsr_s r1,r1,0x8
L_93c1b8:
	stb_s r1,[r2,0x14]
L_93c1ba:
	lsr_s r1,r1,0x8
L_93c1bc:
	stb_s r1,[r2,0x15]
L_93c1be:
	lsr_s r1,r1,0x8
L_93c1c0:
	stb_s r1,[r2,0x16]
L_93c1c2:
	ldb r0,[r0, 0x68]
L_93c1c6:
	bbit0 r0,r13,L_93c1d4
L_93c1ca:
	add r0,sp,0x13
L_93c1ce:
	mov_s r1,0x10
L_93c1d0:
	bl L_93e348
	.global L_93c1d4
L_93c1d4:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_93c1d6:
	add2_s r13,r13,r13
L_93c1d8:
	stb_s r3,[r2,0x17]
L_93c1da:
	add_s r13,r13,0x801104
L_93c1e0:
	ldw_s r0,[r13,0x30]
L_93c1e2:
	stw_s r0,[r2,0x4]
L_93c1e4:
	ldw_s r0,[r13,0x32]
L_93c1e6:
	stw_s r0,[r2,0x6]
L_93c1e8:
	ldw_s r0,[r13,0x34]
L_93c1ea:
	stw_s r0,[r2,0x8]
L_93c1ec:
	mov_s r0,0x10
L_93c1ee:
	bl.d L_9257a8
L_93c1f2:
	mov_s r1,0x18
L_93c1f4:
	bl L_92d990
L_93c1f8:
	mov_s r0,0x2008000
L_93c1fe:
	mov_s r32,r0
L_93c200:
	st.ab r0,[r25,0x4]
L_93c204:
	bclr r25,r25,0xa
L_93c208:
	ld_s r0,[gp,0xcc]
L_93c20a:
	and r1,r0,0x10
L_93c20e:
	mov_s r0,0x0
L_93c210:
	or.f 0x0,r1,r0
L_93c214:
	beq_s L_93c236
L_93c216:
	ld_s r0,[gp,0xe0]
L_93c218:
	ld.as r1,[gp,0x39]
L_93c21c:
	bic r0,r0,-0x3
L_93c220:
	cmp_s r0,0x2
L_93c222:
	mov_s r0,0x1
L_93c224:
	sub_s.ne r0,r0,r0
L_93c226:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_93c228:
	or r0,r0,0x19800830
L_93c230:
	asl_s r1,r1,0xe
L_93c232:
	or_s r0,r0,r1
L_93c234:
	b_s L_93c23c
	.global L_93c236
L_93c236:
	mov_s r0,0x19000001
	.global L_93c23c
L_93c23c:
	mov_s r32,r0
L_93c23e:
	st.ab r0,[r25,0x4]
L_93c242:
	bclr r25,r25,0xa
	.global L_93c246
L_93c246:
	mov_s r0,r45
L_93c248:
	bbit0 r0,0x1f,L_93c246
L_93c24c:
	ld_s r0,[gp,0xcc]
L_93c24e:
	and r1,r0,0x10
L_93c252:
	mov_s r0,0x0
L_93c254:
	or.f 0x0,r1,r0
L_93c258:
	mov_s r0,0x18
L_93c25a:
	asl.ne r0,r0,0x18
L_93c25e:
	mov.eq r0,0x18001000
L_93c266:
	mov_s r32,r0
L_93c268:
	st.ab r0,[r25,0x4]
L_93c26c:
	bclr r25,r25,0xa
L_93c270:
	mov_s r13,sp
L_93c272:
	mov_s r0,r13
L_93c274:
	bl.d L_9257f4
L_93c278:
	mov_s r1,0xa
L_93c27a:
	ld_s r0,[gp,-0x14]
L_93c27c:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_93c27e:
	st.as r0,[gp,-0x5]
L_93c282:
	mov_s r0,0x33000443
L_93c288:
	mov_s r32,r0
L_93c28a:
	st.ab r0,[r25,0x4]
L_93c28e:
	bclr r25,r25,0xa
L_93c292:
	bl L_925874
L_93c296:
	ldb r34,[r13, 0x10]
L_93c29a:
	ldb r34,[r13, 0x11]
L_93c29e:
	ldb r34,[r13, 0x12]
L_93c2a2:
	ld_s r0,[gp,-0x14]
L_93c2a4:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_93c2a6:
	st.as r0,[gp,-0x5]
L_93c2aa:
	ldb r33,[r13, 0x13]
L_93c2ae:
	ldb_s r1,[r13,0x14]
L_93c2b0:
	asl_s r1,r1,0x8
L_93c2b2:
	or r33,r33,r1
L_93c2b6:
	ldb_s r1,[r13,0x15]
L_93c2b8:
	asl_s r1,r1,0x10
L_93c2ba:
	or r33,r33,r1
L_93c2be:
	ldb_s r1,[r13,0x16]
L_93c2c0:
	asl_s r1,r1,0x18
L_93c2c2:
	or r33,r33,r1
L_93c2c6:
	ld_s r0,[gp,-0x14]
L_93c2c8:
	/* sub_s r0,r0,0x4 */
	.byte 0x64,0xb8
L_93c2ca:
	st.as r0,[gp,-0x5]
L_93c2ce:
	ldb r34,[r13, 0x17]
L_93c2d2:
	ld_s r0,[gp,-0x14]
L_93c2d4:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_93c2d6:
	bl.d L_925774
L_93c2da:
	st.as r0,[gp,-0x5]
L_93c2de:
	bl.d L_936544
L_93c2e2:
	mov_s r0,0x6
L_93c2e4:
	bl L_935928
L_93c2e8:
	mov_s r0,0x0
L_93c2ea:
	bl.d L_9366dc
L_93c2ee:
	bset_s r0,r0,0xf
L_93c2f0:
	mov_s r0,0x1
L_93c2f2:
	b.d L_9202a4
L_93c2f6:
	add_s sp,sp,0x18
