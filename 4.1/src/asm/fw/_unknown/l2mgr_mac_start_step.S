/* l2mgr_mac_start_step @ 0x8c43dc, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_started_log, l2mgr__stop_discovery
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bcon_tx_build_step, bf_b_s2_w5, bf_u16_s7_w5, bf_w_s0_w5, bf_w_s5_w5, bss_set_mode, build_vendor_ie, l2mgr__apply_mac_address, l2mgr__build_mac_config, l2mgr__set_edca_defaults
 * Глобалы (через gp): 0x8002c0
 */
	.section .text.l2mgr_mac_start_step,"ax",@progbits
	.global l2mgr_mac_start_step
l2mgr_mac_start_step:
	.global L_8c43dc
L_8c43dc:
	push_s blink
L_8c43de:
	bl L_8c02b8
L_8c43e2:
	sub_s sp,sp,0x4
L_8c43e4:
	mov_s r13,r0
L_8c43e6:
	mov_s r17,r2
L_8c43e8:
	mov_s r16,r3
L_8c43ea:
	bl.d L_8e15f0
L_8c43ee:
	mov_s r15,r4
L_8c43f0:
	mov_s r0,r13
L_8c43f2:
	bl.d L_8c4594
L_8c43f6:
	mov_s r1,r15
L_8c43f8:
	mov_s r0,0xa
L_8c43fa:
	add3 r14,r13,0x8
L_8c43fe:
	ld_s r1,[r13]
L_8c4400:
	stw_s r0,[r14,0xe]
L_8c4402:
	add_s r1,r1,0xa
L_8c4404:
	bl.d L_8e17b4
L_8c4408:
	mov_s r0,r13
L_8c440a:
	bl.d L_8c44a4
L_8c440e:
	mov_s r0,r13
L_8c4410:
	mov_s r0,r13
L_8c4412:
	bl.d L_8c44c0
L_8c4416:
	mov_s r1,r15
L_8c4418:
	bl.d L_8c4498
L_8c441c:
	mov_s r0,r13
L_8c441e:
	mov_s r0,r13
L_8c4420:
	bl.d L_8c42d4
L_8c4424:
	mov_s r1,0x1
L_8c4426:
	mov_s r0,r13
L_8c4428:
	mov_s r1,r17
L_8c442a:
	bl.d L_8e2100
L_8c442e:
	mov_s r2,r16
L_8c4430:
	bl.d L_8d6724
L_8c4434:
	mov_s r0,r13
L_8c4436:
	bl.d L_8c458c
L_8c443a:
	mov_s r0,r13
L_8c443c:
	ldb r1,[sp, 0x3]
L_8c4440:
	ldb r0,[sp, 0x2]
L_8c4444:
	asl_s r1,r1,0x8
L_8c4446:
	or_s r0,r0,r1
L_8c4448:
	bic r1,r0,0x30
L_8c444c:
	stb r1,[sp, 0x2]
L_8c4450:
	lsr_s r1,r1,0x8
L_8c4452:
	stb r1,[sp, 0x3]
L_8c4456:
	mov_s r1,0x14
L_8c4458:
	mov_s r0,sp
L_8c445a:
	bl L_8e8510
L_8c445e:
	add r0,sp,0x1
L_8c4462:
	bl L_8e81c8
L_8c4466:
	mov_s r1,0xc
L_8c4468:
	mov_s r0,sp
L_8c446a:
	bl L_8e8354
L_8c446e:
	add r0,sp,0x1
L_8c4472:
	bl L_8e824c
L_8c4476:
	mov_s r1,sp
L_8c4478:
	bl.d L_8e211c
L_8c447c:
	mov_s r0,r13
L_8c447e:
	ld_s r1,[r13]
L_8c4480:
	mov_s r0,r13
L_8c4482:
	ld_s r1,[r1,0x14]
L_8c4484:
	bl.d L_8e2284
L_8c4488:
	mov_s r2,0x0
L_8c448a:
	ld_s r0,[gp,0x150]
L_8c448c:
	stw_s r0,[r14,0x10]
L_8c448e:
	ld_s r0,[gp,0x150]
L_8c4490:
	stw_s r0,[r14,0xe]
L_8c4492:
	b.d L_8c031c
L_8c4496:
	add_s sp,sp,0x4
