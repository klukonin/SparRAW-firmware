/* uc_log__emit3 @ 0x92d338, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: arc_protect_addr_uc, bf_clear_all_sta, bf_init_sm, bf_sm__process_request_fifo, bti_worker__bti_transmitter_beacon_sweep_flow, config_brp_rf, dump_mac_buffer_bases, dump_vring_pring_info, handle_bf_triggers, hwd_phy_pwr
 * Зовёт сам: uc_sysassert__snapshot_mac
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_log__emit3
uc_log__emit3:
	.global L_92d338
L_92d338:
	st.a r13,[sp,-0xc]
L_92d33c:
	st blink,[sp, 0x4]
L_92d340:
	st_s r14,[sp,0x8]
L_92d342:
	bmsk r5,r0,0x3
L_92d346:
	lsr_s r0,r0,0x4
L_92d348:
	mov_s r14,0x803234
L_92d34e:
	add r10,r14,0x4
L_92d352:
	ldb r11,[r10,r5]
L_92d356:
	bmsk_s r0,r0,0x1
L_92d358:
	sub sp,sp,0x8
L_92d35c:
	bbit0.d r11,r0,L_92d3f0
L_92d360:
	mov_s r13,r1
L_92d362:
	ld r5,[r14]
L_92d366:
	mov_s r0,0x0
L_92d368:
	add r6,r5,0x4
L_92d36c:
	extb r6,r6
L_92d370:
	add2 r6,r14,r6
L_92d374:
	st r4,[r6, 0x14]
L_92d378:
	add r1,r5,0x3
L_92d37c:
	extb_s r1,r1
L_92d37e:
	add2 r1,r14,r1
L_92d382:
	st_s r3,[r1,0x14]
L_92d384:
	add r5,r5,0x2
L_92d388:
	extb r5,r5
L_92d38c:
	add2 r5,r14,r5
L_92d390:
	st r2,[r5, 0x14]
L_92d394:
	mov r1,sp
L_92d398:
	bl.d L_93756c
L_92d39c:
	mov r2,r0
L_92d3a0:
	ld_s r0,[sp,0x4]
L_92d3a2:
	mov_s r2,0xff
L_92d3a4:
	cmp r0,0xff
L_92d3a8:
	mov.cc r6,r2
L_92d3ac:
	ld r7,[r14]
L_92d3b0:
	mov.cs r6,r0
L_92d3b4:
	add r1,r7,0x1
L_92d3b8:
	extb_s r1,r1
L_92d3ba:
	ld r8,[sp]
L_92d3be:
	add2 r1,r14,r1
L_92d3c2:
	st r8,[r1, 0x14]
L_92d3c6:
	bmsk_s r13,r13,0x13
L_92d3c8:
	or r13,r13,0xac000000
L_92d3d0:
	extb r6,r6
L_92d3d4:
	asl r6,r6,0x12
L_92d3d8:
	or r13,r13,r6
L_92d3dc:
	extb r9,r7
L_92d3e0:
	add2 r9,r14,r9
L_92d3e4:
	st r13,[r9, 0x14]
L_92d3e8:
	add r7,r7,0x5
L_92d3ec:
	st r7,[r14]
	.global L_92d3f0
L_92d3f0:
	add_s sp,sp,0x8
L_92d3f2:
	ld blink,[sp, 0x4]
L_92d3f6:
	ld_s r14,[sp,0x8]
L_92d3f8:
	j.d [blink]
L_92d3fc:
	ld.ab r13,[sp,0xc]
