/* bi_rx__start_rx_window @ 0x9210b0, 784 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__slot_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bi_rx__send_response, mac__cmd_29000001, mac__read_time_88c120, mac__select_all_sectors_and_wait, mac__set_mode_0000, mac__set_rf_chain_state, mac_evt__enable_bit_sync_b, rx__mac_prepare, rx_flow__run, sxd_hal__wait_slot2_busy2
 * Глобалы (через gp): 0x8005f4, 0x8005f8, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_rx__start_rx_window
bi_rx__start_rx_window:
	.global L_9210b0
L_9210b0:
	push_s blink
L_9210b2:
	bl L_920230
L_9210b6:
	push_s r0
L_9210b8:
	bl.d L_92948c
L_9210bc:
	mov_s r14,r1
L_9210be:
	cmp_s r14,0x0
L_9210c0:
	mov.ne r1,0x1ef0
L_9210c8:
	mov.eq r1,0x13fb
L_9210d0:
	brhs r0,r1,L_9210da
	.global L_9210d4
L_9210d4:
	b.d L_92132e
L_9210d8:
	mov_s r13,0x0
	.global L_9210da
L_9210da:
	cmp_s r14,0x0
L_9210dc:
	mov_s r13,0x26
L_9210de:
	mov.eq r13,0x15
L_9210e2:
	ld_s r0,[sp,0x0]
L_9210e4:
	mov_s r1,0x80110c
L_9210ea:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9210ec:
	add2_s r0,r0,r0
L_9210ee:
	ld_s r15,[r1,r0]
L_9210f0:
	mov_s r1,0x2
L_9210f2:
	bset_s r1,r1,0xd
L_9210f4:
	mov_s r0,0x0
L_9210f6:
	st.as r0,[gp,0x34]
L_9210fa:
	ld_s r0,[gp,-0x44]
L_9210fc:
	st.as r1,[gp,0x33]
L_921100:
	and r0,r0,0xffff0fff
L_921108:
	bset r1,r0,0xd
L_92110c:
	bset_s r1,r1,0xf
L_92110e:
	st.as r1,[gp,-0x11]
L_921112:
	or r0,r0,0x1d00a000
L_92111a:
	mov_s r32,r0
L_92111c:
	st.ab r0,[r25,0x4]
L_921120:
	bclr r25,r25,0xa
L_921124:
	bl L_936870
L_921128:
	bl L_936520
L_92112c:
	mov_s r0,0x1f006000
L_921132:
	mov_s r32,r0
L_921134:
	st.ab r0,[r25,0x4]
L_921138:
	bclr r25,r25,0xa
L_92113c:
	mov_s r0,0x38000300
L_921142:
	mov_s r32,r0
L_921144:
	st.ab r0,[r25,0x4]
L_921148:
	bclr r25,r25,0xa
L_92114c:
	mov_s r0,0x3600003f
L_921152:
	mov_s r32,r0
L_921154:
	st.ab r0,[r25,0x4]
L_921158:
	bclr r25,r25,0xa
L_92115c:
	mov_s r0,0x6000105
L_921162:
	mov_s r32,r0
L_921164:
	st.ab r0,[r25,0x4]
L_921168:
	bclr r25,r25,0xa
L_92116c:
	mov_s r1,r40
L_92116e:
	mov_s r0,r42
L_921170:
	bbit1 r0,0xe,L_921178
L_921174:
	bbit1 r1,0x18,L_92118c
	.global L_921178
L_921178:
	mov_s r0,0x29000002
L_92117e:
	mov_s r32,r0
L_921180:
	st.ab r0,[r25,0x4]
L_921184:
	bclr r25,r25,0xa
L_921188:
	mov_s r0,0x1
L_92118a:
	b_s L_92118e
	.global L_92118c
L_92118c:
	mov_s r0,0x0
	.global L_92118e
L_92118e:
	breq_s r0,0,L_92119e
L_921190:
	bl L_92f2bc
	.global L_921194
L_921194:
	mov_s r0,r45
L_921196:
	bbit0 r0,0x1f,L_921194
L_92119a:
	mov_s r0,0x0
L_92119c:
	b_s L_9212da
	.global L_92119e
L_92119e:
	breq_s r14,0,L_9211b0
L_9211a0:
	mov_s r0,0x20000400
L_9211a6:
	mov_s r32,r0
L_9211a8:
	st.ab r0,[r25,0x4]
L_9211ac:
	bclr r25,r25,0xa
	.global L_9211b0
L_9211b0:
	mov_s r0,0x37000005
L_9211b6:
	mov_s r32,r0
L_9211b8:
	st.ab r0,[r25,0x4]
L_9211bc:
	bclr r25,r25,0xa
L_9211c0:
	mov_s r0,0x37000002
L_9211c6:
	mov_s r32,r0
L_9211c8:
	st.ab r0,[r25,0x4]
L_9211cc:
	bclr r25,r25,0xa
L_9211d0:
	or r15,r15,0x3f000000
L_9211d8:
	mov_s r32,r15
L_9211da:
	st.ab r15,[r25,0x4]
L_9211de:
	bclr r25,r25,0xa
L_9211e2:
	mov_s r0,0x3e
L_9211e4:
	asl_s r0,r0,0x18
L_9211e6:
	mov_s r32,r0
L_9211e8:
	st.ab r0,[r25,0x4]
L_9211ec:
	bclr r25,r25,0xa
L_9211f0:
	mov_s r0,0x37000020
L_9211f6:
	mov_s r32,r0
L_9211f8:
	st.ab r0,[r25,0x4]
L_9211fc:
	bclr r25,r25,0xa
L_921200:
	mov_s r1,0x8022c8
L_921206:
	ld_s r0,[r1,0xc]
L_921208:
	bset_s r13,r13,0x18
L_92120a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92120c:
	st_s r0,[r1,0xc]
L_92120e:
	ld_s r0,[gp,0x178]
L_921210:
	mov_s r1,0x802940
L_921216:
	bclr_s r0,r0,0x18
L_921218:
	ld_s r1,[r1]
L_92121a:
	bclr_s r0,r0,0x19
L_92121c:
	asl_s r1,r1,0x18
L_92121e:
	or_s r0,r0,r1
L_921220:
	st.as r0,[gp,0x5e]
L_921224:
	mov_s r1,0x889480
L_92122a:
	st_s r0,[r1,0x8]
L_92122c:
	bset_s r13,r13,0x1a
L_92122e:
	bset_s r13,r13,0x1c
L_921230:
	mov_s r32,r13
L_921232:
	st.ab r13,[r25,0x4]
L_921236:
	bclr r25,r25,0xa
L_92123a:
	mov_s r0,0x14000007
L_921240:
	mov_s r32,r0
L_921242:
	st.ab r0,[r25,0x4]
L_921246:
	bclr r25,r25,0xa
L_92124a:
	mov_s r0,0x2008000
L_921250:
	mov_s r32,r0
L_921252:
	st.ab r0,[r25,0x4]
L_921256:
	bclr r25,r25,0xa
L_92125a:
	mov_s r0,0x19000001
L_921260:
	mov_s r32,r0
L_921262:
	st.ab r0,[r25,0x4]
L_921266:
	bclr r25,r25,0xa
L_92126a:
	ld_s r0,[sp,0x0]
L_92126c:
	mov_s r1,0x0
L_92126e:
	mov_s r2,0x9
L_921270:
	bl.d L_939530
L_921274:
	mov_s r3,r14
L_921276:
	bl.d L_936544
L_92127a:
	mov_s r0,0x6
L_92127c:
	mov_s r0,0x0
L_92127e:
	bl.d L_9366dc
L_921282:
	bset_s r0,r0,0xf
L_921284:
	mov_s r1,0x8010b0
L_92128a:
	ldb_s r0,[r1,0xf]
L_92128c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92128e:
	extb_s r0,r0
L_921290:
	stb_s r0,[r1,0xf]
L_921292:
	bl.d L_936588
L_921296:
	mov_s r0,0x6
L_921298:
	mov_s r0,0x14
L_92129a:
	asl_s r0,r0,0x18
L_92129c:
	mov_s r32,r0
L_92129e:
	st.ab r0,[r25,0x4]
L_9212a2:
	bclr r25,r25,0xa
L_9212a6:
	ld_s r0,[sp,0x0]
L_9212a8:
	mov_s r1,0x801108
L_9212ae:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9212b0:
	add2_s r0,r0,r0
L_9212b2:
	ld_s r1,[r1,r0]
L_9212b4:
	bl.d L_92f42c
L_9212b8:
	mov_s r0,0x1
L_9212ba:
	ld_s r0,[gp,0x178]
L_9212bc:
	mov_s r1,0x802944
L_9212c2:
	bclr_s r0,r0,0x18
L_9212c4:
	ld_s r1,[r1]
L_9212c6:
	bclr_s r0,r0,0x19
L_9212c8:
	asl_s r1,r1,0x18
L_9212ca:
	or_s r0,r0,r1
L_9212cc:
	st.as r0,[gp,0x5e]
L_9212d0:
	mov_s r1,0x889480
L_9212d6:
	st_s r0,[r1,0x8]
L_9212d8:
	mov_s r0,0x1
	.global L_9212da
L_9212da:
	brne_s r0,0,L_9212f0
L_9212dc:
	ldb_s r0,[gp,-0xf6]
L_9212de:
	st.as 0x800,[gp,0x34]
L_9212e6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9212e8:
	b.d L_9210d4
L_9212ec:
	stb r0,[gp, -0xf6]
	.global L_9212f0
L_9212f0:
	breq_s r14,0,L_92132c
L_9212f2:
	bl.d L_936cc8
L_9212f6:
	ldw_s r0,[gp,-0x20]
L_9212f8:
	breq_s r0,0,L_921310
L_9212fa:
	bl L_930dd4
L_9212fe:
	breq_s r0,0,L_921306
L_921300:
	mov_s r0,r36
L_921302:
	bbit1 r0,0x8,L_92130a
	.global L_921306
L_921306:
	mov_s r13,0x0
L_921308:
	b_s L_92130c
	.global L_92130a
L_92130a:
	mov_s r13,0x1
	.global L_92130c
L_92130c:
	extb_s r13,r13
L_92130e:
	b_s L_92131c
	.global L_921310
L_921310:
	ld_s r1,[sp,0x0]
L_921312:
	mov_s r0,0x1
L_921314:
	bl.d L_925698
L_921318:
	mov_s r2,0x1f
L_92131a:
	mov_s r13,0x0
	.global L_92131c
L_92131c:
	mov_s r0,0x0
L_92131e:
	bset_s r0,r0,0x1d
L_921320:
	mov_s r32,r0
L_921322:
	st.ab r0,[r25,0x4]
L_921326:
	bclr r25,r25,0xa
L_92132a:
	b_s L_92132e
	.global L_92132c
L_92132c:
	mov_s r13,0x1
	.global L_92132e
L_92132e:
	mov_s r0,0x14000100
L_921334:
	mov_s r32,r0
L_921336:
	st.ab r0,[r25,0x4]
L_92133a:
	bclr r25,r25,0xa
L_92133e:
	ldw_s r0,[gp,0xcc]
L_921340:
	or r0,r0,0xdc0000
L_921348:
	mov_s r32,r0
L_92134a:
	st.ab r0,[r25,0x4]
L_92134e:
	bclr r25,r25,0xa
L_921352:
	ld_s r0,[gp,0xcc]
L_921354:
	lsr_s r0,r0,0x10
L_921356:
	or r0,r0,0xdc0000
L_92135e:
	mov_s r32,r0
L_921360:
	st.ab r0,[r25,0x4]
L_921364:
	bclr r25,r25,0xa
L_921368:
	ldw_s r0,[gp,0xd0]
L_92136a:
	or r0,r0,0xdc0000
L_921372:
	mov_s r32,r0
L_921374:
	st.ab r0,[r25,0x4]
L_921378:
	bclr r25,r25,0xa
L_92137c:
	ld_s r0,[gp,0xd0]
L_92137e:
	lsr_s r0,r0,0x10
L_921380:
	or r0,r0,0xdc0000
L_921388:
	mov_s r32,r0
L_92138a:
	st.ab r0,[r25,0x4]
L_92138e:
	bclr r25,r25,0xa
L_921392:
	mov_s r0,0x0
L_921394:
	st.as r0,[gp,0x33]
L_921398:
	st.as r0,[gp,0x34]
L_92139c:
	mov_s r1,0x802978
L_9213a2:
	st_s r0,[r1,0xc]
L_9213a4:
	st_s r0,[r1,0x48]
L_9213a6:
	mov_s r0,0x81
L_9213a8:
	asl_s r0,r0,0x12
L_9213aa:
	mov_s r32,r0
L_9213ac:
	st.ab r0,[r25,0x4]
L_9213b0:
	bclr r25,r25,0xa
L_9213b4:
	bl L_93e0dc
L_9213b8:
	mov_s r0,r13
L_9213ba:
	b.d L_92029c
L_9213be:
	add_s sp,sp,0x4
