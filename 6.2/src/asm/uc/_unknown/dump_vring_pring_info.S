/* dump_vring_pring_info @ 0x929320, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   VRING #%d PRING #%d debug info:
 *   VRING: sw_head %d sw_head_4_rd %d sw_tail %d
 *   PRING: sw_head %d sw_head_4_rd %d sw_tail %d
 *   PRING: hw_head %d hw_tail %d
 *   PRING: hw_wb_head %d hw_wb_tail %d
 *   descq valid = %d
 * Зовут его: dump_mac_buffer_bases
 * Зовёт сам: uc_log__emit1, uc_log__emit2, uc_log__emit3
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dump_vring_pring_info
dump_vring_pring_info:
	.global L_929320
L_929320:
	st.a r13,[sp,-0x8]
L_929324:
	st blink,[sp, 0x4]
L_929328:
	mov_s r13,r0
L_92932a:
	mov_s r1,0x1002d40
L_929330:
	mov_s r0,0x20
L_929332:
	mov_s r2,r13
L_929334:
	bl.d L_92d27c
L_929338:
	mov r3,0x0
L_92933c:
	mov_s r1,0x1002d60
L_929342:
	asl_s r13,r13,0x8
L_929344:
	add r5,r13,0x440c0c0
L_92934c:
	lsr r4,r5,0x3
L_929350:
	bic r4,r4,0x3
L_929354:
	ld r2,[r4]
L_929358:
	bmsk r5,r5,0x4
L_92935c:
	lsr r2,r2,r5
L_929360:
	extw_s r2,r2
L_929362:
	add r4,r13,0x440c120
L_92936a:
	lsr r6,r4,0x3
L_92936e:
	bic r6,r6,0x3
L_929372:
	ld r3,[r6]
L_929376:
	bmsk r4,r4,0x4
L_92937a:
	lsr r3,r3,r4
L_92937e:
	extw_s r3,r3
L_929380:
	add_s r13,r13,0x440c100
L_929386:
	lsr r7,r13,0x3
L_92938a:
	bic r7,r7,0x3
L_92938e:
	ld r4,[r7]
L_929392:
	bmsk_s r13,r13,0x4
L_929394:
	lsr r4,r4,r13
L_929398:
	extw r4,r4
L_92939c:
	bl.d L_92d338
L_9293a0:
	mov r0,0x20
L_9293a4:
	mov_s r13,0x881000
L_9293aa:
	ld.as r2,[r13,0xc4]
L_9293ae:
	mov_s r1,0x1002d90
L_9293b4:
	ld.as r3,[r13,0xc6]
L_9293b8:
	extw_s r2,r2
L_9293ba:
	ld.as r4,[r13,0xba]
L_9293be:
	extw_s r3,r3
L_9293c0:
	extw r4,r4
L_9293c4:
	bl.d L_92d338
L_9293c8:
	mov r0,0x20
L_9293cc:
	ld.as r2,[r13,0xc0]
L_9293d0:
	mov_s r1,0x1002dc0
L_9293d6:
	ld.as r3,[r13,0xc2]
L_9293da:
	mov_s r0,0x20
L_9293dc:
	bmsk r2,r2,0x3
L_9293e0:
	bl.d L_92d27c
L_9293e4:
	bmsk r3,r3,0x3
L_9293e8:
	ld.as r2,[r13,0xc1]
L_9293ec:
	mov_s r1,0x1002de0
L_9293f2:
	ld.as r3,[r13,0xc3]
L_9293f6:
	mov_s r0,0x20
L_9293f8:
	bmsk r2,r2,0x3
L_9293fc:
	bl.d L_92d27c
L_929400:
	bmsk r3,r3,0x3
L_929404:
	ld.as r2,[r13,0x4d]
L_929408:
	mov_s r1,0x1002e04
L_92940e:
	mov_s r0,0x20
L_929410:
	bl.d L_92d1d0
L_929414:
	bmsk r2,r2,0x3
L_929418:
	ld blink,[sp, 0x4]
L_92941c:
	j.d [blink]
L_929420:
	ld.ab r13,[sp,0x8]
