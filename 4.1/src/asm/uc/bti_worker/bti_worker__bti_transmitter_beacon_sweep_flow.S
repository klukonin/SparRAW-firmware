/* bti_worker__bti_transmitter_beacon_sweep_flow @ 0x923de0, 1564 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bti_worker::bti_transmitter_beacon_sweep_flow() randomize beacon
 *   bti_worker::bti_transmitter_beacon_sweep_flow() current_tsf: 0x%08x, Next tsf: 0x%08x, uniform_random: %d
 *   Beacons delay due to NAV started at 0x%08x
 *   bti_worker.cpp
 * Зовут его: bi__decide_beacon_kind
 * Зовёт сам: bcon_sweep_step_a, bcon_sweep_step_b, bcon_txss_sweep_step, beacon_tx__build_slot_bitmap, bi__remaining_time_us, bi_cfg__tick_counters, bi_ctrl__program_mac_bcon, rw_g_800994, set_tsf_event, shl64, tx_ctx__next_slot, uc_read_tsf_lo
 * Глобалы (через gp): 0x800604, 0x800608
 */
	.section .text.bti_worker__bti_transmitter_beacon_sweep_flow,"ax",@progbits
	.global bti_worker__bti_transmitter_beacon_sweep_flow
bti_worker__bti_transmitter_beacon_sweep_flow:
	.global L_923de0
L_923de0:
	st.a r13,[sp,-0x18]
L_923de4:
	st blink,[sp, 0x4]
L_923de8:
	st_s r14,[sp,0x8]
L_923dea:
	st_s r15,[sp,0xc]
L_923dec:
	st r16,[sp, 0x10]
L_923df0:
	st r17,[sp, 0x14]
L_923df4:
	sub_s sp,sp,0x8
L_923df6:
	mov_s r17,r0
L_923df8:
	mov r8,0x10
L_923dfc:
	mov r13,0x801438
L_923e04:
	ld r7,[r13]
L_923e08:
	st.as r8,[gp,0x37]
L_923e0c:
	cmp r7,0x2
L_923e10:
	mov r5,0x0
L_923e14:
	bne.d L_923f4c
L_923e18:
	st.as r5,[gp,0x38]
L_923e1c:
	ld r10,[r17]
L_923e20:
	cmp r10,0x0
L_923e24:
	bne_s L_923f4c
L_923e26:
	mov_s r14,0x80209c
L_923e2c:
	ldb_s r1,[r14,0x4]
L_923e2e:
	mov r5,0x1002fd0
L_923e36:
	bbit0 r1,0x2,L_923e64
L_923e3a:
	bmsk r5,r5,0x13
L_923e3e:
	or r4,r5,0xa2000000
L_923e46:
	ld r5,[r14]
L_923e4a:
	mov_s r0,0x8020b0
L_923e50:
	extb r2,r5
L_923e54:
	add2 r0,r0,r2
L_923e58:
	st r4,[r0]
L_923e5c:
	add r5,r5,0x1
L_923e60:
	st r5,[r14]
	.global L_923e64
L_923e64:
	ld.as r6,[gp,-0x11]
L_923e68:
	and r6,r6,0xfff0ffff
L_923e70:
	bset r8,r6,0x11
L_923e74:
	or r6,r6,0x1d020000
L_923e7c:
	st.as r8,[gp,-0x11]
L_923e80:
	mov r32,r6
L_923e84:
	st.ab r6,[r25,0x4]
L_923e88:
	bclr r25,r25,0xa
L_923e8c:
	nop_s
L_923e8e:
	nop_s
L_923e90:
	nop_s
L_923e92:
	mov_s r3,r47
L_923e94:
	mulu64 r3,0xbd
L_923e98:
	mov r0,mhi
L_923e9c:
	add r15,r0,0xa
L_923ea0:
	or r2,r15,0x30000000
L_923ea8:
	mov r32,r2
L_923eac:
	st.ab r2,[r25,0x4]
L_923eb0:
	bclr r25,r25,0xa
L_923eb4:
	bl L_9315e8
L_923eb8:
	mov_s r1,0x0
L_923eba:
	mov_s r16,r0
L_923ebc:
	mov r0,r15
L_923ec0:
	bl.d L_920438
L_923ec4:
	mov r2,0xa
L_923ec8:
	ld r4,[r13, 0x18]
L_923ecc:
	add.f r4,r4,r0
L_923ed0:
	ld_s r2,[r13,0x1c]
L_923ed2:
	st r4,[r13, 0x18]
L_923ed6:
	adc r1,r1,r2
L_923eda:
	st_s r1,[r13,0x1c]
L_923edc:
	bl.d L_930c28
L_923ee0:
	add r0,r13,0x18
L_923ee4:
	ldb r2,[r14, 0x4]
L_923ee8:
	mov r7,0x1003014
L_923ef0:
	bbit0.d r2,0x2,L_923f4c
L_923ef4:
	ld r4,[r13, 0x18]
L_923ef8:
	ld r8,[r14]
L_923efc:
	mov_s r0,0x8020b0
L_923f02:
	add r3,r8,0x3
L_923f06:
	extb_s r3,r3
L_923f08:
	add2 r3,r0,r3
L_923f0c:
	st_s r15,[r3]
L_923f0e:
	add r5,r8,0x2
L_923f12:
	extb r5,r5
L_923f16:
	add2 r5,r0,r5
L_923f1a:
	st r4,[r5]
L_923f1e:
	add r6,r8,0x1
L_923f22:
	extb r6,r6
L_923f26:
	add2 r6,r0,r6
L_923f2a:
	st r16,[r6]
L_923f2e:
	bmsk r7,r7,0x13
L_923f32:
	or r7,r7,0xae000000
L_923f3a:
	extb r1,r8
L_923f3e:
	add2_s r0,r0,r1
L_923f40:
	st r7,[r0]
L_923f44:
	add r8,r8,0x4
L_923f48:
	st r8,[r14]
	.global L_923f4c
L_923f4c:
	bl L_92a5ec
L_923f50:
	bl L_92a608
L_923f54:
	breq r0,0x0,L_92400c
L_923f58:
	mov_s r3,0x857000
L_923f5e:
	ld r4,[r3, 0x44]
L_923f62:
	mov_s r14,0x800688
L_923f68:
	ld r9,[r14]
L_923f6c:
	add r4,r4,0x1
L_923f70:
	mov r13,0x802030
L_923f78:
	brne.d r9,0x0,L_923ff0
L_923f7c:
	st r4,[r3, 0x44]
L_923f80:
	bl L_9315e8
L_923f84:
	mov_s r3,0x1
L_923f86:
	st_s r3,[r14]
L_923f88:
	mov_s r3,0x80209c
L_923f8e:
	ldb r5,[r3, 0x4]
L_923f92:
	mov_s r1,0x1003080
L_923f98:
	btst r5,0x2
L_923f9c:
	beq.d L_9243e4
L_923fa0:
	st_s r0,[r13,0x48]
L_923fa2:
	ld_s r2,[r3]
L_923fa4:
	mov r7,0x8020b0
L_923fac:
	add r4,r2,0x1
L_923fb0:
	extb r4,r4
L_923fb4:
	add2 r4,r7,r4
L_923fb8:
	st r0,[r4]
L_923fbc:
	bmsk_s r1,r1,0x13
L_923fbe:
	or r1,r1,0xa6000000
L_923fc6:
	extb r11,r2
L_923fca:
	add2 r11,r7,r11
L_923fce:
	st r1,[r11]
L_923fd2:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_923fd4:
	st_s r2,[r3]
L_923fd6:
	add_s sp,sp,0x8
L_923fd8:
	ld blink,[sp, 0x4]
L_923fdc:
	ld_s r14,[sp,0x8]
L_923fde:
	ld_s r15,[sp,0xc]
L_923fe0:
	ld r16,[sp, 0x10]
L_923fe4:
	ld r17,[sp, 0x14]
L_923fe8:
	j.d [blink]
L_923fec:
	ld.ab r13,[sp,0x18]
	.global L_923ff0
L_923ff0:
	bl L_9315e8
L_923ff4:
	ld r7,[r13, 0x48]
L_923ff8:
	sub r0,r0,r7
L_923ffc:
	cmp r0,0x7530
L_924004:
	blt.d L_9243e4
L_924008:
	st r0,[r13, 0x4c]
	.global L_92400c
L_92400c:
	ld.as r3,[gp,-0x12]
L_924010:
	or r3,r3,0x27007e00
L_924018:
	mov r32,r3
L_92401c:
	st.ab r3,[r25,0x4]
L_924020:
	bclr r25,r25,0xa
L_924024:
	mov_s r2,0x2004002
L_92402a:
	mov_s r32,r2
L_92402c:
	st.ab r2,[r25,0x4]
L_924030:
	bclr r25,r25,0xa
L_924034:
	bl.d L_933414
L_924038:
	mov r0,0x1
L_92403c:
	mov_s r13,r0
L_92403e:
	mov_s r0,0x1e
L_924040:
	bl.d L_932e00
L_924044:
	st r0,[r13, 0x4]
L_924048:
	bl.d L_932ee0
L_92404c:
	mov r0,sp
L_924050:
	bl L_933280
L_924054:
	mov_s r0,0x2
L_924056:
	bset_s r0,r0,0xe
L_924058:
	bl.d L_931808
L_92405c:
	mov r1,0x0
L_924060:
	mov r6,r42
L_924064:
	btst r6,0xe
L_924068:
	bne L_9243e4
L_92406c:
	mov r11,0x801a9c
L_924074:
	ld r3,[r11, 0x5c]
L_924078:
	mov_s r0,sp
L_92407a:
	asl_s r2,r3,0x3
L_92407c:
	sub_s r2,r2,r3
L_92407e:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_924080:
	add r10,r11,0x1a
L_924084:
	ldw r3,[r10,r2]
L_924088:
	add r1,r11,r2
L_92408c:
	bl.d L_930dec
L_924090:
	add r2,r11,0x38
L_924094:
	ldw r7,[sp, 0x2]
L_924098:
	ldw r0,[sp, 0x4]
L_92409c:
	mov r5,0x801ca8
L_9240a4:
	add r7,r7,r0
L_9240a8:
	ld r0,[r5, 0x40]
L_9240ac:
	mov r4,0x14000100
L_9240b4:
	add r0,r0,r7
L_9240b8:
	st r0,[r5, 0x40]
L_9240bc:
	mov r32,r4
L_9240c0:
	st.ab r4,[r25,0x4]
L_9240c4:
	bclr r25,r25,0xa
L_9240c8:
	mov_s r2,sp
L_9240ca:
	mov_s r0,r13
L_9240cc:
	mov_s r1,0x5
L_9240ce:
	mov_s r3,0x0
L_9240d0:
	mov r4,0x0
L_9240d4:
	bl.d L_935a4c
L_9240d8:
	mov r5,0x0
L_9240dc:
	cmp r0,0x0
L_9240e0:
	beq.d L_924390
L_9240e4:
	mov_s r14,0x0
L_9240e6:
	ldb r2,[0x80142c]
L_9240ee:
	mov_s r13,0x801e68
L_9240f4:
	rsub.f r1,r2,0x1
L_9240f8:
	mov_s r15,0x1
L_9240fa:
	mov.cs r1,0x0
L_9240fe:
	stb_s r1,[r13,0x1]
L_924100:
	st r14,[0x800688]
L_924108:
	bl.d L_932e9c
L_92410c:
	stb r15,[r13, 0x1a]
L_924110:
	mov r10,0x801a9c
L_924118:
	ld r1,[r10, 0x5c]
L_92411c:
	ld r9,[r10, 0x54]
L_924120:
	add r1,r1,0x1
L_924124:
	brne.d r1,r9,L_924130
L_924128:
	st r1,[r10, 0x5c]
L_92412c:
	st r14,[r10, 0x5c]
	.global L_924130
L_924130:
	mov r5,0x2040010
L_924138:
	mov r32,r5
L_92413c:
	st.ab r5,[r25,0x4]
L_924140:
	bclr r25,r25,0xa
L_924144:
	mov r5,0x801458
L_92414c:
	ld r11,[r5, 0x18]
L_924150:
	add r11,r11,0x1
L_924154:
	st r11,[r5, 0x18]
L_924158:
	stb r15,[r17, 0x4]
L_92415c:
	ldb r8,[r13, 0x1]
L_924160:
	brne r8,0x0,L_924170
	.global L_924164
L_924164:
	mov r3,r42
L_924168:
	bbit0 r3,0x7,L_924164
L_92416c:
	b L_924390
	.global L_924170
L_924170:
	mov r6,0x3c000004
L_924178:
	mov r32,r6
L_92417c:
	st.ab r6,[r25,0x4]
L_924180:
	bclr r25,r25,0xa
L_924184:
	mov r6,0x14000400
L_92418c:
	mov r32,r6
L_924190:
	st.ab r6,[r25,0x4]
L_924194:
	bclr r25,r25,0xa
L_924198:
	mov r9,r42
L_92419c:
	bbit0 r9,0x7,L_9241b4
L_9241a0:
	mov_s r0,blink
L_9241a2:
	mov_s r2,0x1002fc0
L_9241a8:
	mov r1,0x75
L_9241ac:
	bl.d L_925548
L_9241b0:
	mov r3,0x177
	.global L_9241b4
L_9241b4:
	mov r4,r42
L_9241b8:
	bbit0 r4,0x7,L_9241b4
L_9241bc:
	mov r4,0x14000000
L_9241c4:
	mov r32,r4
L_9241c8:
	st.ab r4,[r25,0x4]
L_9241cc:
	bclr r25,r25,0xa
L_9241d0:
	ld r13,[0x801b04]
L_9241d8:
	mov r7,0x52000000
L_9241e0:
	add r13,r13,0x1ef
L_9241e4:
	mov r32,r7
L_9241e8:
	st.ab r7,[r25,0x4]
L_9241ec:
	bclr r25,r25,0xa
L_9241f0:
	mov r8,0x52000000
L_9241f8:
	mov r32,r8
L_9241fc:
	st.ab r8,[r25,0x4]
L_924200:
	bclr r25,r25,0xa
L_924204:
	mov r9,0x49000040
L_92420c:
	mov r32,r9
L_924210:
	st.ab r9,[r25,0x4]
L_924214:
	bclr r25,r25,0xa
L_924218:
	or r13,r13,0x4f000000
L_924220:
	mov r32,r13
L_924224:
	st.ab r13,[r25,0x4]
L_924228:
	bclr r25,r25,0xa
L_92422c:
	mov_s r0,0x52000308
L_924232:
	mov_s r32,r0
L_924234:
	st.ab r0,[r25,0x4]
L_924238:
	bclr r25,r25,0xa
L_92423c:
	ld r13,[0x801afc]
L_924244:
	mov_s r1,0x53
L_924246:
	add r13,r13,0xa5
L_92424a:
	asl_s r1,r1,0x18
L_92424c:
	mov r32,r1
L_924250:
	st.ab r1,[r25,0x4]
L_924254:
	bclr r25,r25,0xa
L_924258:
	mov_s r2,0x53
L_92425a:
	asl_s r2,r2,0x18
L_92425c:
	mov r32,r2
L_924260:
	st.ab r2,[r25,0x4]
L_924264:
	bclr r25,r25,0xa
L_924268:
	mov_s r3,0x49000080
L_92426e:
	mov_s r32,r3
L_924270:
	st.ab r3,[r25,0x4]
L_924274:
	bclr r25,r25,0xa
L_924278:
	or r13,r13,0x50000000
L_924280:
	mov r32,r13
L_924284:
	st.ab r13,[r25,0x4]
L_924288:
	bclr r25,r25,0xa
L_92428c:
	mov r4,0x5300090c
L_924294:
	mov r32,r4
L_924298:
	st.ab r4,[r25,0x4]
L_92429c:
	bclr r25,r25,0xa
L_9242a0:
	mov r5,0x54000000
L_9242a8:
	mov r32,r5
L_9242ac:
	st.ab r5,[r25,0x4]
L_9242b0:
	bclr r25,r25,0xa
L_9242b4:
	mov r6,0x54000000
L_9242bc:
	mov r32,r6
L_9242c0:
	st.ab r6,[r25,0x4]
L_9242c4:
	bclr r25,r25,0xa
L_9242c8:
	mov r7,0x49000100
L_9242d0:
	mov r32,r7
L_9242d4:
	st.ab r7,[r25,0x4]
L_9242d8:
	bclr r25,r25,0xa
L_9242dc:
	mov r8,0x51000339
L_9242e4:
	mov r32,r8
L_9242e8:
	st.ab r8,[r25,0x4]
L_9242ec:
	bclr r25,r25,0xa
L_9242f0:
	mov r9,0x5400030c
L_9242f8:
	mov r32,r9
L_9242fc:
	st.ab r9,[r25,0x4]
L_924300:
	bclr r25,r25,0xa
L_924304:
	ld.as r2,[gp,-0x11]
L_924308:
	and r2,r2,0xffff0fff
L_924310:
	st.as r2,[gp,-0x11]
L_924314:
	or r2,r2,0x1d000000
L_92431c:
	mov r32,r2
L_924320:
	st.ab r2,[r25,0x4]
L_924324:
	bclr r25,r25,0xa
L_924328:
	nop_s
L_92432a:
	nop_s
L_92432c:
	mov 0x0,0x0
L_924330:
	bmsk r0,r40,0x2
L_924334:
	brne r0,0x5,L_9243b4
	.global L_924338
L_924338:
	mov_s r0,0x5
L_92433a:
	mov_s r1,r0
L_92433c:
	bl.d L_9316b4
L_924340:
	mov r2,0x4
L_924344:
	nop_s
L_924346:
	nop_s
L_924348:
	mov 0x0,0x0
L_92434c:
	mov r4,r42
L_924350:
	bbit0 r4,0xe,L_9243cc
	.global L_924354
L_924354:
	ld r1,[0x801b00]
L_92435c:
	or r1,r1,0x51000000
L_924364:
	mov r32,r1
L_924368:
	st.ab r1,[r25,0x4]
L_92436c:
	bclr r25,r25,0xa
L_924370:
	mov_s r0,0x5400090a
L_924376:
	mov_s r32,r0
L_924378:
	st.ab r0,[r25,0x4]
L_92437c:
	bclr r25,r25,0xa
L_924380:
	mov_s r1,0x5200000e
L_924386:
	mov_s r32,r1
L_924388:
	st.ab r1,[r25,0x4]
L_92438c:
	bclr r25,r25,0xa
	.global L_924390
L_924390:
	mov r4,0x0
L_924394:
	st.as r4,[gp,0x37]
L_924398:
	st.as r4,[gp,0x38]
L_92439c:
	add_s sp,sp,0x8
L_92439e:
	ld blink,[sp, 0x4]
L_9243a2:
	ld_s r14,[sp,0x8]
L_9243a4:
	ld_s r15,[sp,0xc]
L_9243a6:
	ld r16,[sp, 0x10]
L_9243aa:
	ld r17,[sp, 0x14]
L_9243ae:
	j_s.d [blink]
L_9243b0:
	ld.ab r13,[sp,0x18]
	.global L_9243b4
L_9243b4:
	mov_s r0,blink
L_9243b6:
	mov_s r2,0x1002fc0
L_9243bc:
	mov r1,0x77
L_9243c0:
	bl.d L_925548
L_9243c4:
	mov r3,0x186
L_9243c8:
	b L_924338
	.global L_9243cc
L_9243cc:
	mov_s r0,blink
L_9243ce:
	mov_s r2,0x1002fc0
L_9243d4:
	mov r1,0x84
L_9243d8:
	bl.d L_925548
L_9243dc:
	mov r3,0x18b
L_9243e0:
	b L_924354
	.global L_9243e4
L_9243e4:
	add_s sp,sp,0x8
L_9243e6:
	ld blink,[sp, 0x4]
L_9243ea:
	ld_s r14,[sp,0x8]
L_9243ec:
	ld_s r15,[sp,0xc]
L_9243ee:
	ld r16,[sp, 0x10]
L_9243f2:
	ld r17,[sp, 0x14]
L_9243f6:
	j_s.d [blink]
L_9243f8:
	ld.ab r13,[sp,0x18]
