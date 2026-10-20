/* rx_flow__run @ 0x930dd4, 2296 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__start_rx_window, rx__handle_status_flags, rx_funcs__rx_flow, tx_sta__flow_loop, tx_sta__wait_slot_and_tx, txss_init__send_fdbk_wait_ack, txss_init__wait_rss, txss_resp__wait_fdbk, txss_resp__wait_iss_end
 * Зовёт сам: mac__load_tx_key, mac__wait_event_r42_or_r40, mtp__get_tx_permission, mtp_queue__byte_by_index, rx__mac_prepare, rx_flow__accumulate_busy_time, rx_flow__handle_frame, rx_flow__latch_phy_8014e8__930da4, rx_flow__measure_snr_select_best, rx_flow_step, rx_funcs__handle_ppdu_report, rx_mode__configure
 * Глобалы (через gp): 0x800530, 0x800534, 0x800568, 0x80056c, 0x800574, 0x800578, 0x8005f4, 0x8005f8, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_flow__run
rx_flow__run:
	.global L_930dd4
L_930dd4:
	st.a r13,[sp,-0x1c]
L_930dd8:
	st blink,[sp, 0x4]
L_930ddc:
	st_s r14,[sp,0x8]
L_930dde:
	st_s r15,[sp,0xc]
L_930de0:
	st r16,[sp, 0x10]
L_930de4:
	st r17,[sp, 0x14]
L_930de8:
	st r18,[sp, 0x18]
L_930dec:
	mov r4,0xeeee09
L_930df4:
	mov r32,r4
L_930df8:
	st.ab r4,[r25,0x4]
L_930dfc:
	bclr r25,r25,0xa
L_930e00:
	ld r0,[0x800748]
L_930e08:
	lr r0,[r0]
L_930e0c:
	bmsk_s r0,r0,0x17
L_930e0e:
	mov_s r32,r0
L_930e10:
	st.ab r0,[r25,0x4]
L_930e14:
	bclr r25,r25,0xa
L_930e18:
	mov r6,0x0
L_930e1c:
	st.as r6,[gp,-0x10]
L_930e20:
	ld.as r1,[gp,-0x11]
L_930e24:
	mov r17,0x1
L_930e28:
	and r1,r1,0xffff0fff
L_930e30:
	st.as r1,[gp,-0x11]
L_930e34:
	or r1,r1,0x1d000000
L_930e3c:
	mov r32,r1
L_930e40:
	st.ab r1,[r25,0x4]
L_930e44:
	bclr r25,r25,0xa
L_930e48:
	nop_s
L_930e4a:
	nop_s
L_930e4c:
	mov 0x0,0x0
L_930e50:
	bl L_92ed50
L_930e54:
	bmsk r4,r40,0x2
L_930e58:
	st.as r4,[gp,0x2]
L_930e5c:
	mov r3,0x0
L_930e60:
	st.as r3,[gp,0x11]
L_930e64:
	brne.d r4,0x5,L_930e98
L_930e68:
	st.as r3,[gp,0x10]
L_930e6c:
	mov r5,0x4d000000
L_930e74:
	mov r32,r5
L_930e78:
	st.ab r5,[r25,0x4]
L_930e7c:
	bclr r25,r25,0xa
L_930e80:
	nop_s
L_930e82:
	nop_s
L_930e84:
	mov 0x0,0x0
L_930e88:
	mov r5,r55
L_930e8c:
	ld.as r4,[gp,0x2]
L_930e90:
	cmp r5,0x120
L_930e94:
	mov.cc r17,0x0
	.global L_930e98
L_930e98:
	cmp r4,0x0
L_930e9c:
	mov.eq r17,0x0
L_930ea0:
	cmp.ne r17,0x0
L_930ea4:
	bne_s L_930ebc
L_930ea6:
	mov_s r1,0x8022c8
L_930eac:
	ld r4,[r1, 0x48]
L_930eb0:
	add r4,r4,0x1
L_930eb4:
	b.d L_930f08
L_930eb8:
	st r4,[r1, 0x48]
	.global L_930ebc
L_930ebc:
	mov r6,0x1f006000
L_930ec4:
	mov r32,r6
L_930ec8:
	st.ab r6,[r25,0x4]
L_930ecc:
	bclr r25,r25,0xa
L_930ed0:
	mov_s r2,0x38000300
L_930ed6:
	mov_s r32,r2
L_930ed8:
	st.ab r2,[r25,0x4]
L_930edc:
	bclr r25,r25,0xa
L_930ee0:
	mov_s r3,0x3600003f
L_930ee6:
	mov_s r32,r3
L_930ee8:
	st.ab r3,[r25,0x4]
L_930eec:
	bclr r25,r25,0xa
L_930ef0:
	mov r4,0x6000101
L_930ef8:
	mov r32,r4
L_930efc:
	st.ab r4,[r25,0x4]
L_930f00:
	bclr r25,r25,0xa
L_930f04:
	mov r17,0x1
	.global L_930f08
L_930f08:
	mov r7,0x4d000000
L_930f10:
	mov r32,r7
L_930f14:
	st.ab r7,[r25,0x4]
L_930f18:
	bclr r25,r25,0xa
L_930f1c:
	nop_s
L_930f1e:
	nop_s
L_930f20:
	nop_s
L_930f22:
	st.as r55,[gp,0x3]
L_930f26:
	ld.as r2,[gp,-0x11]
L_930f2a:
	and r2,r2,0xffff0fff
L_930f32:
	or r1,r2,0xa000
L_930f3a:
	or r2,r2,0x1d00a000
L_930f42:
	st.as r1,[gp,-0x11]
L_930f46:
	mov_s r32,r2
L_930f48:
	st.ab r2,[r25,0x4]
L_930f4c:
	bclr r25,r25,0xa
L_930f50:
	nop_s
L_930f52:
	nop_s
L_930f54:
	nop_s
L_930f56:
	mov_s r3,r40
L_930f58:
	lsr r13,r3,0x8
L_930f5c:
	bmsk_s r13,r13,0x5
L_930f5e:
	lsr_s r3,r3,0x10
L_930f60:
	bmsk r6,r3,0x5
L_930f64:
	sub r6,r6,r13
L_930f68:
	bmsk r6,r6,0x5
L_930f6c:
	brhs r6,0x2,L_931008
	.global L_930f70
L_930f70:
	ld.as r14,[gp,0x14]
L_930f74:
	mov_s r1,0x8
L_930f76:
	bmsk_s r14,r14,0x5
L_930f78:
	mov r5,0x802288
L_930f80:
	st r1,[r5]
L_930f84:
	ld r15,[0x8029f0]
L_930f8c:
	mov r18,0x0
L_930f90:
	ld r3,[r5, 0x10]
L_930f94:
	st r18,[r5, 0xc]
L_930f98:
	bic r3,r3,-0x9
L_930f9c:
	bset r3,r3,0x1f
L_930fa0:
	st r3,[r5, 0x10]
L_930fa4:
	breq.d r13,r14,L_931018
L_930fa8:
	mov r16,0x1
L_930fac:
	st.as r13,[gp,0x14]
L_930fb0:
	mov r8,0x20d2000
L_930fb8:
	mov r32,r8
L_930fbc:
	st.ab r8,[r25,0x4]
L_930fc0:
	bclr r25,r25,0xa
L_930fc4:
	mov r4,r40
L_930fc8:
	bbit1 r4,0x18,L_930fe8
L_930fcc:
	mov_s r0,0x0
L_930fce:
	bset_s r0,r0,0x10
L_930fd0:
	mov r1,0x0
L_930fd4:
	bl.d L_93675c
L_930fd8:
	bset r1,r1,0x18
L_930fdc:
	ld.as r5,[gp,0x14]
L_930fe0:
	add r5,r5,0x1
L_930fe4:
	st.as r5,[gp,0x14]
	.global L_930fe8
L_930fe8:
	ld_s r0,[gp,0x4c]
L_930fea:
	mov r9,0xeeee04
L_930ff2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_930ff4:
	st.as r0,[gp,0x13]
L_930ff8:
	mov r32,r9
L_930ffc:
	st.ab r9,[r25,0x4]
L_931000:
	bclr r25,r25,0xa
L_931004:
	b L_931364
	.global L_931008
L_931008:
	mov r0,blink
L_93100c:
	bl.d L_926618
L_931010:
	mov r1,0x44
L_931014:
	b L_930f70
	.global L_931018
L_931018:
	ld.as r9,[gp,-0x11]
L_93101c:
	and r9,r9,0xffff0fff
L_931024:
	st.as r9,[gp,-0x11]
L_931028:
	or r9,r9,0x1d000000
L_931030:
	mov r32,r9
L_931034:
	st.ab r9,[r25,0x4]
L_931038:
	bclr r25,r25,0xa
L_93103c:
	nop_s
L_93103e:
	nop_s
L_931040:
	nop_s
L_931042:
	bmsk r3,r40,0x2
L_931046:
	mov_s r32,r3
L_931048:
	st.ab r3,[r25,0x4]
L_93104c:
	bclr r25,r25,0xa
L_931050:
	bmsk r4,r40,0x2
L_931054:
	cmp r4,0x5
L_931058:
	bhi L_931218
L_93105c:
	ld.as r2,[0x801944,r4]
L_931064:
	j_s [r2]
L_931066:
	ld.as r11,[gp,-0x11]
L_93106a:
	and r11,r11,0xffff0fff
L_931072:
	or r10,r11,0xa000
L_93107a:
	or r5,r11,0x1d00a000
L_931082:
	st.as r10,[gp,-0x11]
L_931086:
	mov r32,r5
L_93108a:
	st.ab r5,[r25,0x4]
L_93108e:
	bclr r25,r25,0xa
L_931092:
	nop_s
L_931094:
	nop_s
L_931096:
	nop_s
L_931098:
	lsr r9,r40,0x10
L_93109c:
	bmsk r9,r9,0x5
L_9310a0:
	cmp_s r14,r9
L_9310a2:
	bne L_931218
L_9310a6:
	mov r10,0x8022c8
L_9310ae:
	ld r2,[r10, 0x40]
L_9310b2:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_9310b4:
	st r2,[0x853924]
L_9310bc:
	b.d L_931364
L_9310c0:
	st r2,[r10, 0x40]
L_9310c4:
	mov_s r0,0x1
L_9310c6:
	mov_s r1,0x1
L_9310c8:
	bl.d L_936594
L_9310cc:
	mov r2,0x4
L_9310d0:
	bmsk r6,r40,0x2
L_9310d4:
	breq r6,0x2,L_931108
L_9310d8:
	mov r9,0x8022c8
L_9310e0:
	ld r2,[r9, 0x44]
L_9310e4:
	mov r16,0x0
L_9310e8:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_9310ea:
	st r2,[r9, 0x44]
L_9310ee:
	mov_s r0,0xeeee05
L_9310f4:
	mov r32,r0
L_9310f8:
	st.ab r0,[r25,0x4]
L_9310fc:
	bclr r25,r25,0xa
L_931100:
	mov_s r13,0x800638
L_931106:
	b_s L_931224
	.global L_931108
L_931108:
	ld.as r7,[gp,-0x12]
L_93110c:
	or r7,r7,0x27007300
L_931114:
	mov r32,r7
L_931118:
	st.ab r7,[r25,0x4]
L_93111c:
	bclr r25,r25,0xa
L_931120:
	mov r5,0x2004000
L_931128:
	mov r32,r5
L_93112c:
	st.ab r5,[r25,0x4]
L_931130:
	bclr r25,r25,0xa
L_931134:
	nop_s
L_931136:
	nop_s
L_931138:
	nop_s
L_93113a:
	mov_s r0,0x9
L_93113c:
	asl r0,r0,0xb
L_931140:
	bl.d L_9366e8
L_931144:
	mov r1,0x0
L_931148:
	and r4,r42,0x4000
L_931150:
	rsub.f r4,r4,0x1
L_931154:
	mov.cs r4,0x0
L_931158:
	brne r4,0x1,L_931180
L_93115c:
	ld r9,[0x801424]
L_931164:
	bbit0 r9,0x1,L_931180
L_931168:
	bmsk r6,r40,0x2
L_93116c:
	brne r6,0x2,L_931180
L_931170:
	ld r11,[0x8837b0]
L_931178:
	btst r11,0x1
L_93117c:
	bl.ne L_92d688
	.global L_931180
L_931180:
	ld.as r10,[gp,-0x11]
L_931184:
	and r10,r10,0xffff0fff
L_93118c:
	or r0,r10,0xa000
L_931194:
	or r6,r10,0x1d00a000
L_93119c:
	st.as r0,[gp,-0x11]
L_9311a0:
	mov r32,r6
L_9311a4:
	st.ab r6,[r25,0x4]
L_9311a8:
	bclr r25,r25,0xa
L_9311ac:
	nop_s
L_9311ae:
	nop_s
L_9311b0:
	nop_s
L_9311b2:
	ld.as r2,[gp,-0x12]
L_9311b6:
	or r2,r2,0x27007300
L_9311be:
	mov_s r32,r2
L_9311c0:
	st.ab r2,[r25,0x4]
L_9311c4:
	bclr r25,r25,0xa
L_9311c8:
	mov r6,0x2004000
L_9311d0:
	mov r32,r6
L_9311d4:
	st.ab r6,[r25,0x4]
L_9311d8:
	bclr r25,r25,0xa
L_9311dc:
	nop_s
L_9311de:
	nop_s
L_9311e0:
	mov 0x0,0x0
	.global L_9311e4
L_9311e4:
	mov r0,r42
L_9311e8:
	bbit1 r0,0xe,L_9311f4
L_9311ec:
	mov r5,r49
L_9311f0:
	bbit0 r5,0xd,L_9311e4
	.global L_9311f4
L_9311f4:
	bl.d L_930da4
L_9311f8:
	mov r3,r49
L_9311fc:
	lsr r0,r40,0x8
L_931200:
	bmsk_s r0,r0,0x5
L_931202:
	lsr r13,r40,0x10
L_931206:
	bmsk_s r13,r13,0x5
L_931208:
	sub r8,r13,r0
L_93120c:
	bmsk r8,r8,0x5
L_931210:
	brhs r8,0x2,L_9312a0
	.global L_931214
L_931214:
	breq r13,r14,L_9312b0
	.global L_931218
L_931218:
	mov r13,0x800638
L_931220:
	brne r18,0x1,L_93122c
	.global L_931224
L_931224:
	ld_s r0,[r13]
L_931226:
	cmp_s r0,0x0
L_931228:
	bl.ne L_924960
	.global L_93122c
L_93122c:
	mov r7,0x0
L_931230:
	st r7,[r13]
L_931234:
	cmp r17,0x0
L_931238:
	cmp.eq r16,0x1
L_93123c:
	beq_s L_93136c
L_93123e:
	cmp r16,0x0
L_931242:
	bne_s L_9313c0
	.global L_931244
L_931244:
	mov r4,r37
L_931248:
	bbit1 r4,0x18,L_931254
L_93124c:
	mov r3,r38
L_931250:
	bbit0 r3,0x0,L_931274
	.global L_931254
L_931254:
	mov_s r2,r39
L_931256:
	bbit0 r2,0xf,L_931274
L_93125a:
	mov_s r1,r42
L_93125c:
	bbit0 r1,0x10,L_931274
L_931260:
	mov r5,0x8021e0
L_931268:
	ld r4,[r5]
L_93126c:
	bset r4,r4,0x1
L_931270:
	st r4,[r5]
	.global L_931274
L_931274:
	bl L_92f2bc
L_931278:
	mov_s r0,0x0
L_93127a:
	mov_s r1,r0
L_93127c:
	mov r2,r0
L_931280:
	bl.d L_934590
L_931284:
	mov r3,r0
L_931288:
	mov r6,0x20d2800
L_931290:
	mov r32,r6
L_931294:
	st.ab r6,[r25,0x4]
L_931298:
	bclr r25,r25,0xa
L_93129c:
	b L_931484
	.global L_9312a0
L_9312a0:
	mov r0,blink
L_9312a4:
	bl.d L_926618
L_9312a8:
	mov r1,0x45
L_9312ac:
	b L_931214
	.global L_9312b0
L_9312b0:
	mov_s r1,0xeeee07
L_9312b6:
	mov_s r32,r1
L_9312b8:
	st.ab r1,[r25,0x4]
L_9312bc:
	bclr r25,r25,0xa
L_9312c0:
	mov r32,r14
L_9312c4:
	st.ab r14,[r25,0x4]
L_9312c8:
	bclr r25,r25,0xa
L_9312cc:
	mov r4,0x8022c8
L_9312d4:
	ld r11,[r4, 0x40]
L_9312d8:
	mov_s r3,0x8006a4
L_9312de:
	add r11,r11,0x1
L_9312e2:
	ld_s r2,[r3]
L_9312e4:
	st r11,[r4, 0x40]
L_9312e8:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_9312ea:
	st_s r2,[r3]
L_9312ec:
	mov r6,0x853800
L_9312f4:
	ld r7,[0x801424]
L_9312fc:
	st.as r11,[r6,0x49]
L_931300:
	ld r5,[0x8025d8]
L_931308:
	bbit0.d r7,0x1,L_93133c
L_93130c:
	mov r18,0x1
L_931310:
	bbit0 r5,0x1,L_931328
L_931314:
	ld r10,[r4, 0x58]
L_931318:
	add r10,r10,0x1
L_93131c:
	st r10,[r4, 0x58]
L_931320:
	b.d L_931364
L_931324:
	st.as r10,[r6,0x4f]
	.global L_931328
L_931328:
	ld r2,[r4, 0x54]
L_93132c:
	add r2,r2,0x1
L_931330:
	st r2,[r4, 0x54]
L_931334:
	b.d L_931364
L_931338:
	st.as r2,[r6,0x4d]
	.global L_93133c
L_93133c:
	bbit0 r5,0x0,L_931354
L_931340:
	ld r1,[r4, 0x5c]
L_931344:
	add r1,r1,0x1
L_931348:
	st r1,[r4, 0x5c]
L_93134c:
	b.d L_931364
L_931350:
	st.as r1,[r6,0x4c]
	.global L_931354
L_931354:
	ld r8,[r4, 0x50]
L_931358:
	add r8,r8,0x1
L_93135c:
	st r8,[r4, 0x50]
L_931360:
	st.as r8,[r6,0x4b]
	.global L_931364
L_931364:
	b.d L_931218
L_931368:
	mov r16,0x0
	.global L_93136c
L_93136c:
	mov r6,0xeeee06
L_931374:
	mov r32,r6
L_931378:
	st.ab r6,[r25,0x4]
L_93137c:
	bclr r25,r25,0xa
L_931380:
	ld.as r4,[gp,0x14]
L_931384:
	mov_s r13,0x8022c8
L_93138a:
	add r4,r4,0x1
L_93138e:
	ld r6,[r13, 0x3c]
L_931392:
	st.as r4,[gp,0x14]
L_931396:
	add r6,r6,0x1
L_93139a:
	st r6,[r13, 0x3c]
L_93139e:
	st r6,[0x857034]
L_9313a6:
	mov_s r0,0x0
L_9313a8:
	bl.d L_9366dc
L_9313ac:
	bset r0,r0,0x10
L_9313b0:
	ld r5,[r13, 0x4c]
L_9313b4:
	add r5,r5,0x1
L_9313b8:
	b.d L_931244
L_9313bc:
	st r5,[r13, 0x4c]
	.global L_9313c0
L_9313c0:
	ld.as r1,[gp,0x14]
L_9313c4:
	ld.as r4,[gp,0x34]
L_9313c8:
	add r1,r1,0x1
L_9313cc:
	bbit0.d r4,0x2,L_93140c
L_9313d0:
	st.as r1,[gp,0x14]
L_9313d4:
	mov r0,0x0
L_9313d8:
	bl.d L_92f4bc
L_9313dc:
	ld r1,[r15]
L_9313e0:
	ld_s r3,[r15]
L_9313e2:
	/* asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_9313e4:
	add2_s r3,r3,r3
L_9313e6:
	add_s r3,r3,0x801104
L_9313ec:
	ldb r1,[r3, 0x4b]
L_9313f0:
	breq_s r1,0,L_93140c
L_9313f2:
	ld r4,[r3, 0x18]
L_9313f6:
	ld_s r2,[r15,0x4]
L_9313f8:
	bbit0 r4,r2,L_93140c
L_9313fc:
	bl.d L_9294ac
L_931400:
	add r0,r3,0x38
L_931404:
	ld_s r0,[r15,0xc]
L_931406:
	bset_s r0,r0,0xb
L_931408:
	st r0,[r15, 0xc]
	.global L_93140c
L_93140c:
	ld.as r7,[gp,0x33]
L_931410:
	and.f 0x0,r7,0x7e0
L_931418:
	beq L_931424
L_93141c:
	bl L_9316cc
L_931420:
	b L_93148c
	.global L_931424
L_931424:
	bbit0 r7,0x1,L_93146c
L_931428:
	ld.as r7,[gp,-0x11]
L_93142c:
	and r7,r7,0xffff0fff
L_931434:
	or r6,r7,0x3000
L_93143c:
	or r7,r7,0x1d003000
L_931444:
	st.as r6,[gp,-0x11]
L_931448:
	mov r32,r7
L_93144c:
	st.ab r7,[r25,0x4]
L_931450:
	bclr r25,r25,0xa
L_931454:
	nop_s
L_931456:
	nop_s
L_931458:
	mov 0x0,0x0
L_93145c:
	extw r1,r40
L_931460:
	bl.d L_931acc
L_931464:
	mov r0,r15
L_931468:
	b L_93148c
	.global L_93146c
L_93146c:
	bl.d L_931f04
L_931470:
	mov r0,r15
L_931474:
	ld.as r4,[gp,0x34]
L_931478:
	and.f 0x0,r4,0x3001000
L_931480:
	beq L_93148c
	.global L_931484
L_931484:
	b.d L_9316b0
L_931488:
	mov r16,0x0
	.global L_93148c
L_93148c:
	ld.as r3,[gp,-0x10]
L_931490:
	breq_s r3,0,L_9314a0
L_931492:
	mov_s r14,0x8022c8
L_931498:
	b.d L_931680
L_93149c:
	mov r13,0x0
	.global L_9314a0
L_9314a0:
	ld_s r1,[r15,0xc]
L_9314a2:
	bbit1 r1,0x0,L_9314b4
L_9314a6:
	mov_s r14,0x8022c8
L_9314ac:
	b.d L_931668
L_9314b0:
	mov r13,0x0
	.global L_9314b4
L_9314b4:
	ld.as r9,[gp,0x34]
L_9314b8:
	ld r0,[r15]
L_9314bc:
	bbit0.d r9,0x1e,L_931510
L_9314c0:
	ld_s r13,[r15,0x4]
L_9314c2:
	asl_s r3,r0,0x2
L_9314c4:
	add1_s r3,r3,r3
L_9314c6:
	ld r3,[r3,0x802610]
L_9314ce:
	asl_s r13,r13,0x10
L_9314d0:
	sub.f r3,r3,0x0
L_9314d4:
	mov.ne r3,0x1
L_9314d8:
	extb.f 0x0,r3
L_9314dc:
	beq.d L_9314f4
L_9314e0:
	bset r13,r13,0x2
L_9314e4:
	bl L_92ff68
L_9314e8:
	asl r0,r0,0x8
L_9314ec:
	b.d L_9314f8
L_9314f0:
	or r14,r0,0x3
	.global L_9314f4
L_9314f4:
	mov r14,0x0
	.global L_9314f8
L_9314f8:
	mov r7,0x1b001111
L_931500:
	mov r32,r7
L_931504:
	st.ab r7,[r25,0x4]
L_931508:
	bclr r25,r25,0xa
L_93150c:
	b L_931584
	.global L_931510
L_931510:
	ld r8,[r15, 0x24]
L_931514:
	ld_s r3,[r15,0x8]
L_931516:
	mov_s r14,0x0
L_931518:
	brne.d r8,0x2,L_931530
L_93151c:
	asl r13,r13,0x10
L_931520:
	or r13,r13,0x103
	.global L_931524
L_931524:
	bset r13,r13,0x5
L_931528:
	b.d L_931540
L_93152c:
	asl r14,r3,0x10
	.global L_931530
L_931530:
	cmp r8,0x1
L_931534:
	beq.d L_931524
L_931538:
	or.eq r13,r13,0x3
L_93153c:
	bset r13,r13,0x0
	.global L_931540
L_931540:
	ld.as r8,[gp,0x33]
L_931544:
	bbit0 r8,0x1,L_931570
L_931548:
	asl_s r2,r0,0x2
L_93154a:
	add1_s r2,r2,r2
L_93154c:
	ld r1,[r2,0x802610]
L_931554:
	sub.f r1,r1,0x0
L_931558:
	mov.ne r1,0x1
L_93155c:
	extb.f 0x0,r1
L_931560:
	beq L_931570
L_931564:
	bl L_92ff68
L_931568:
	asl_s r0,r0,0x8
L_93156a:
	or r0,r0,0x3
L_93156e:
	or_s r14,r14,r0
	.global L_931570
L_931570:
	mov r9,0x1b001111
L_931578:
	mov r32,r9
L_93157c:
	st.ab r9,[r25,0x4]
L_931580:
	bclr r25,r25,0xa
	.global L_931584
L_931584:
	or r13,r13,0x16000000
L_93158c:
	mov r32,r13
L_931590:
	st.ab r13,[r25,0x4]
L_931594:
	bclr r25,r25,0xa
L_931598:
	or r14,r14,0x17000000
L_9315a0:
	mov r32,r14
L_9315a4:
	st.ab r14,[r25,0x4]
L_9315a8:
	bclr r25,r25,0xa
L_9315ac:
	nop_s
L_9315ae:
	nop_s
L_9315b0:
	mov 0x0,0x0
	.global L_9315b4
L_9315b4:
	mov_s r3,r43
L_9315b6:
	bbit0 r3,0x1f,L_9315b4
L_9315ba:
	mov r11,r51
L_9315be:
	bmsk r5,r11,0x3
L_9315c2:
	st.as r5,[gp,0x38]
L_9315c6:
	lsr r11,r11,0x4
L_9315ca:
	st.as r11,[gp,0x39]
L_9315ce:
	lsr r13,r43,0x10
L_9315d2:
	bmsk_s r13,r13,0x4
L_9315d4:
	asl_s r0,r13,0x4
L_9315d6:
	or r0,r0,0x3e000000
L_9315de:
	mov_s r32,r0
L_9315e0:
	st.ab r0,[r25,0x4]
L_9315e4:
	bclr r25,r25,0xa
L_9315e8:
	mov r7,0x37000020
L_9315f0:
	mov r32,r7
L_9315f4:
	st.ab r7,[r25,0x4]
L_9315f8:
	bclr r25,r25,0xa
L_9315fc:
	mov_s r14,0x8022c8
L_931602:
	ld r9,[r14, 0xc]
L_931606:
	ld.as r8,[gp,0x5e]
L_93160a:
	add r9,r9,0x1
L_93160e:
	st r9,[r14, 0xc]
L_931612:
	ld r9,[0x802940]
L_93161a:
	and r8,r8,0xfcffffff
L_931622:
	asl r9,r9,0x18
L_931626:
	or r8,r8,r9
L_93162a:
	st.as r8,[gp,0x5e]
L_93162e:
	st r8,[0x889488]
L_931636:
	ld r9,[r15, 0xc]
L_93163a:
	mov_s r0,r15
L_93163c:
	lsr r8,r9,0xb
L_931640:
	bmsk r8,r8,0x0
L_931644:
	asl r8,r8,0xc
L_931648:
	bclr r9,r9,0xc
L_93164c:
	or r8,r8,r9
L_931650:
	st r8,[r15, 0xc]
L_931654:
	bl.d L_93e8c4
L_931658:
	mov r1,r13
L_93165c:
	ld_s r3,[r15,0xc]
L_93165e:
	mov_s r13,0x0
L_931660:
	bclr_s r3,r3,0xc
L_931662:
	bset_s r3,r3,0x5
L_931664:
	st r3,[r15, 0xc]
	.global L_931668
L_931668:
	ld r0,[0x802298]
L_931670:
	lsr_s r0,r0
L_931672:
	mov_s r1,r36
L_931674:
	mov_s r2,r37
L_931676:
	mov_s r3,r38
L_931678:
	bl.d L_934590
L_93167c:
	bmsk r0,r0,0x0
	.global L_931680
L_931680:
	ld r7,[r14, 0x3c]
L_931684:
	st r13,[0x8006a4]
L_93168c:
	add r7,r7,0x1
L_931690:
	st r7,[r14, 0x3c]
L_931694:
	st r7,[0x857034]
L_93169c:
	mov r8,0x20d2800
L_9316a4:
	mov r32,r8
L_9316a8:
	st.ab r8,[r25,0x4]
L_9316ac:
	bclr r25,r25,0xa
	.global L_9316b0
L_9316b0:
	ld blink,[sp, 0x4]
L_9316b4:
	mov_s r0,r16
L_9316b6:
	ld_s r14,[sp,0x8]
L_9316b8:
	ld_s r15,[sp,0xc]
L_9316ba:
	ld r16,[sp, 0x10]
L_9316be:
	ld r17,[sp, 0x14]
L_9316c2:
	ld r18,[sp, 0x18]
L_9316c6:
	j_s.d [blink]
L_9316c8:
	ld.ab r13,[sp,0x1c]
