/* tx_sta__run_txop @ 0x93a088, 456 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_initiator_flow_fixed_scheduling, tx_non_data_flow_fixed_scheduling, tx_slot__dispatch
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, bf_metrics__reset_and_stamp, bf_pending__set_bit, handle_bf_triggers, mac__select_rf_module_cmd31, rx__check_mode_2, rx__handle_status_flags, tx__pick_slot_for_peer, tx_initiator__reset_slot_counters, tx_sta__flow_loop, tx_sta__wait_slot_and_tx
 * Глобалы (через gp): 0x800564, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_sta__run_txop
tx_sta__run_txop:
	.global L_93a088
L_93a088:
	push_s blink
L_93a08a:
	bl L_92021c
L_93a08e:
	mov_s r14,r0
L_93a090:
	mov_s r0,0x801498
L_93a096:
	ld_s r1,[r0,0x8]
L_93a098:
	mov_s r15,0x0
L_93a09a:
	mov_s r0,0x8021b8
L_93a0a0:
	stb.a r15,[sp,-0x4]
L_93a0a4:
	bbit0 r1,0x9,L_93a0ac
L_93a0a8:
	ldb_s r0,[r0,0xa]
L_93a0aa:
	b_s L_93a0ae
	.global L_93a0ac
L_93a0ac:
	ldb_s r0,[r0,0x8]
	.global L_93a0ae
L_93a0ae:
	mov_s r16,r0
L_93a0b0:
	ld.as r19,[gp,0xf]
L_93a0b4:
	bl.d L_93db98
L_93a0b8:
	mov_s r0,r14
L_93a0ba:
	bl L_93a250
L_93a0be:
	ld_s r13,[r14]
L_93a0c0:
	brne_s r0,0,L_93a0d8
L_93a0c2:
	ld_s r0,[gp,0xd0]
L_93a0c4:
	st.as r19,[gp,0xf]
L_93a0c8:
	bclr_s r0,r0,0x8
L_93a0ca:
	st.as r0,[gp,0x34]
L_93a0ce:
	mov_s r0,0x0
L_93a0d0:
	bl.d L_93cfdc
L_93a0d4:
	mov_s r1,r0
L_93a0d6:
	b_s L_93a248
	.global L_93a0d8
L_93a0d8:
	mov_s r0,0x802978
L_93a0de:
	ld_s r1,[r0,0x78]
L_93a0e0:
	mov_s r0,0x80111c
L_93a0e6:
	ld_s r2,[r1]
L_93a0e8:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_93a0ea:
	add2_s r2,r2,r2
L_93a0ec:
	ld_s r2,[r0,r2]
L_93a0ee:
	ld_s r0,[r1,0x4]
L_93a0f0:
	bbit0 r2,r0,L_93a106
L_93a0f4:
	mov_s r1,0x80044b
L_93a0fa:
	ldb_s r0,[r1]
L_93a0fc:
	brne r0,0x1,L_93a106
L_93a100:
	bl.d L_92930c
L_93a104:
	stb_s r15,[r1]
	.global L_93a106
L_93a106:
	asl_s r0,r13,0x2
L_93a108:
	add1_s r0,r0,r0
L_93a10a:
	add r17,r0,0x802610
L_93a112:
	ld r0,[r17]
L_93a116:
	sub.f r0,r0,0x0
L_93a11a:
	mov.ne r0,0x1
L_93a11e:
	extb.f 0x0,r0
L_93a122:
	beq_s L_93a128
L_93a124:
	st.as r15,[gp,0xf]
	.global L_93a128
L_93a128:
	mov_s r0,0x80
L_93a12a:
	bset_s r0,r0,0x19
L_93a12c:
	mov_s r32,r0
L_93a12e:
	st.ab r0,[r25,0x4]
L_93a132:
	bclr r25,r25,0xa
L_93a136:
	ld_s r0,[gp,-0x60]
L_93a138:
	ld.as r1,[gp,0xf]
L_93a13c:
	or_s r0,r0,r1
L_93a13e:
	st.as r0,[gp,-0x18]
L_93a142:
	mov_s r1,0x886f00
L_93a148:
	mov_s r18,r1
L_93a14a:
	st_s r0,[r1,0x5c]
L_93a14c:
	mov_s r1,sp
L_93a14e:
	bl.d L_93a5fc
L_93a152:
	mov_s r0,r14
L_93a154:
	mov_s r20,r0
L_93a156:
	ld r0,[r17]
L_93a15a:
	sub.f r0,r0,0x0
L_93a15e:
	mov.ne r0,0x1
L_93a162:
	extb.f 0x0,r0
L_93a166:
	mov_s r0,r14
L_93a168:
	beq_s L_93a170
L_93a16a:
	bl L_939e88
L_93a16e:
	b_s L_93a174
	.global L_93a170
L_93a170:
	bl L_939d3c
	.global L_93a174
L_93a174:
	asl_s r15,r13,0x2
L_93a176:
	add2_s r15,r15,r15
L_93a178:
	add_s r15,r15,0x857e38
L_93a17e:
	ldb_s r0,[r15,0x10]
L_93a180:
	cmp_s r0,r16
L_93a182:
	mov_s r0,0x0
L_93a184:
	blt_s L_93a19c
L_93a186:
	mov_s r0,0x8021b8
L_93a18c:
	ld_s r0,[r0,0x20]
L_93a18e:
	bbit0 r0,0x2,L_93a198
L_93a192:
	ldb_s r0,[r15,0x11]
L_93a194:
	bset_s r0,r0,0x2
L_93a196:
	stb_s r0,[r15,0x11]
	.global L_93a198
L_93a198:
	mov_s r0,0x0
L_93a19a:
	stb_s r0,[r15,0x10]
	.global L_93a19c
L_93a19c:
	mov_s r16,r0
L_93a19e:
	mov_s r0,0x0
L_93a1a0:
	bl.d L_93cfdc
L_93a1a4:
	mov_s r1,r0
L_93a1a6:
	mov_s r0,r13
L_93a1a8:
	bl.d L_928750
L_93a1ac:
	mov_s r1,0x1
L_93a1ae:
	ldb_s r0,[r15,0x11]
L_93a1b0:
	bic r0,r0,-0xc0
L_93a1b4:
	sub.f r0,r0,0x0
L_93a1b8:
	mov.ne r0,0x1
L_93a1bc:
	extb.f r15,r0
L_93a1c0:
	bne_s L_93a1e8
L_93a1c2:
	ld r0,[r17, 0x4]
L_93a1c6:
	cmp_s r0,0x3
L_93a1c8:
	cmp.ne r0,0x4
L_93a1cc:
	cmp.ne r0,0x5
L_93a1d0:
	bne_s L_93a1d6
L_93a1d2:
	mov r16,0x1
	.global L_93a1d6
L_93a1d6:
	extb.f 0x0,r16
L_93a1da:
	beq_s L_93a1e8
L_93a1dc:
	bl.d L_92fd74
L_93a1e0:
	mov_s r0,r13
L_93a1e2:
	bl.d L_9216f8
L_93a1e6:
	mov_s r0,0x2
	.global L_93a1e8
L_93a1e8:
	mov_s r0,0x802210
L_93a1ee:
	ld_s r0,[r0,0x14]
L_93a1f0:
	breq_s r0,0,L_93a200
L_93a1f2:
	mov_s r1,0x857180
L_93a1f8:
	add2_s r1,r1,r13
L_93a1fa:
	ld_s r0,[r1,0x4]
L_93a1fc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93a1fe:
	st_s r0,[r1,0x4]
	.global L_93a200
L_93a200:
	brne_s r15,0,L_93a208
L_93a202:
	ldb_s r0,[sp,0x0]
L_93a204:
	brne r0,0x1,L_93a218
	.global L_93a208
L_93a208:
	bl L_93d28c
L_93a20c:
	mov_s r0,0x803134
L_93a212:
	bl.d L_936e04
L_93a216:
	mov_s r1,r13
	.global L_93a218
L_93a218:
	ld.as r1,[gp,0xf]
L_93a21c:
	ld_s r0,[gp,-0x60]
L_93a21e:
	bic_s r0,r0,r1
L_93a220:
	st.as r0,[gp,-0x18]
L_93a224:
	st r0,[r18, 0x5c]
L_93a228:
	st.as r19,[gp,0xf]
L_93a22c:
	brne r20,0x0,L_93a23a
L_93a230:
	extb_s r1,r13
L_93a232:
	mov_s r0,0x0
L_93a234:
	bl.d L_925698
L_93a238:
	ldb_s r2,[r14,0x4]
	.global L_93a23a
L_93a23a:
	mov_s r0,0x0
L_93a23c:
	bset_s r0,r0,0x1d
L_93a23e:
	mov_s r32,r0
L_93a240:
	st.ab r0,[r25,0x4]
L_93a244:
	bclr r25,r25,0xa
	.global L_93a248
L_93a248:
	b.d L_920274
L_93a24c:
	add_s sp,sp,0x4
L_93a24e:
	nop_s
