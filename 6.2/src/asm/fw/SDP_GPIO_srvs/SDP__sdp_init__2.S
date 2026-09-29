/* SDP__sdp_init__2 @ 0x8f83c0, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Configuring SDP %d
 *   SDP::sdp_init() the following sdp port is input enabled but output at init value is defined (should be UNDEF): %d
 *   SDP::sdp_init() the following sdp port is output enabled but also interrupt enabled: %d
 * Зовут его: sdp__set_level_and_init, sdp_gpio__boot_init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_sysassert_fatal, gpio__set_pin_func_and_dump, hwd_sdp_drive_value, sdp__init_int_ctrl, sdp__set_defined_bit, sdp__set_int_ctrl_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SDP__sdp_init__2
SDP__sdp_init__2:
	.global L_8f83c0
L_8f83c0:
	push_s blink
L_8f83c2:
	bl L_8c01dc
L_8f83c6:
	mov_s r14,r0
L_8f83c8:
	mov_s r15,0x800c34
L_8f83ce:
	add2_s r15,r15,r0
L_8f83d0:
	ld_s r13,[r15]
L_8f83d2:
	mov_s r1,0x1008f24
L_8f83d8:
	mov_s r0,0x20
L_8f83da:
	bl.d L_8dcc10
L_8f83de:
	bmsk r2,r13,0x4
L_8f83e2:
	ld_s r0,[r15]
L_8f83e4:
	lsr_s r0,r0,0x5
L_8f83e6:
	bmsk_s r0,r0,0x2
L_8f83e8:
	breq r0,0x4,L_8f83f4
L_8f83ec:
	bl.d L_8f4294
L_8f83f0:
	bmsk r1,r13,0x4
	.global L_8f83f4
L_8f83f4:
	ld_s r15,[r15]
L_8f83f6:
	lsr r0,r15,0x8
L_8f83fa:
	bmsk_s r0,r0,0x0
L_8f83fc:
	bl.d L_8f43d4
L_8f8400:
	bmsk r1,r13,0x4
L_8f8404:
	brne r14,0x4,L_8f841c
L_8f8408:
	mov_s r0,0x13880
L_8f840e:
	mov lp_count,r0
L_8f8412:
	nop_s
L_8f8414:
	lp L_8f841c
L_8f8418:
	nop_s
L_8f841a:
	nop_s
	.global L_8f841c
L_8f841c:
	mov_s r0,0x800c34
L_8f8422:
	ld.as r0,[r0,r14]
L_8f8426:
	lsr_s r0,r0,0x9
L_8f8428:
	bmsk.f r16,r0,0x1
L_8f842c:
	cmp.ne r16,0x1
L_8f8430:
	bne_s L_8f8474
L_8f8432:
	bbit1 r15,0x8,L_8f8452
L_8f8436:
	mov_s r1,0x1008f38
L_8f843c:
	mov_s r0,0x0
L_8f843e:
	bl.d L_8dcc10
L_8f8442:
	bmsk r2,r13,0x4
L_8f8446:
	mov_s r0,blink
L_8f8448:
	mov_s r1,0x1416
L_8f844e:
	bl L_8c9b28
	.global L_8f8452
L_8f8452:
	mov_s r0,r16
L_8f8454:
	bl.d L_8f4258
L_8f8458:
	bmsk r1,r13,0x4
L_8f845c:
	brne r14,0x4,L_8f8474
L_8f8460:
	mov_s r0,0x13880
L_8f8466:
	mov lp_count,r0
L_8f846a:
	nop_s
L_8f846c:
	lp L_8f8474
L_8f8470:
	nop_s
L_8f8472:
	nop_s
	.global L_8f8474
L_8f8474:
	mov_s r0,0x800c34
L_8f847a:
	ld.as r14,[r0,r14]
L_8f847e:
	lsr_s r14,r14,0xb
L_8f8480:
	bmsk.f r14,r14,0x1
L_8f8484:
	cmp.ne r14,0x1
L_8f8488:
	bne_s L_8f84bc
L_8f848a:
	bbit0 r15,0x8,L_8f84aa
L_8f848e:
	mov_s r1,0x1008fac
L_8f8494:
	mov_s r0,0x0
L_8f8496:
	bl.d L_8dcc10
L_8f849a:
	bmsk r2,r13,0x4
L_8f849e:
	mov_s r0,blink
L_8f84a0:
	mov_s r1,0x1413
L_8f84a6:
	bl L_8c9b28
	.global L_8f84aa
L_8f84aa:
	mov_s r0,r14
L_8f84ac:
	bl.d L_8f42fc
L_8f84b0:
	bmsk r1,r13,0x4
L_8f84b4:
	bl.d L_8f42e4
L_8f84b8:
	bmsk r0,r13,0x4
	.global L_8f84bc
L_8f84bc:
	b L_8c0244
