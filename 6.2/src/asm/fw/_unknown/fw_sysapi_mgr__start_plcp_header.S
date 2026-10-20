/* fw_sysapi_mgr__start_plcp_header @ 0x8f73b0, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   plcp_header_cmd_start: Enter
 *   fw_sysapi_mgr::start_plcp_header: Rejecting sysapi request since previous command is still not completed (prev request_type=%d, new request type=%d)
 * Зовут его: hw_sysapi_plcp_header
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r16_to_r13_ret, __st_r16_to_r13, channel_est__clamp_64, channel_est__stack_args, field_set_0x00__8dbe88, fw_log_emit0, fw_log_emit2, fw_sysapi_mgr__phy_rx_statistics_cmd_start, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__start_sysapi_cmd, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__start_plcp_header
fw_sysapi_mgr__start_plcp_header:
	.global L_8f73b0
L_8f73b0:
	push_s blink
L_8f73b2:
	bl L_8c01dc
L_8f73b6:
	sub_s sp,sp,0x20
L_8f73b8:
	mov_s r13,r0
L_8f73ba:
	mov_s r15,r1
L_8f73bc:
	mov_s r14,r2
L_8f73be:
	mov_s r16,r3
L_8f73c0:
	mov_s r1,0x1012658
L_8f73c6:
	bl.d L_8dcba8
L_8f73ca:
	mov_s r0,0x20
L_8f73cc:
	mov_s r0,r13
L_8f73ce:
	mov_s r1,r15
L_8f73d0:
	bl.d L_8f7490
L_8f73d4:
	mov_s r2,r14
L_8f73d6:
	mov_s r0,r13
L_8f73d8:
	mov_s r1,0x2
L_8f73da:
	bl.d L_8f9a20
L_8f73de:
	mov_s r2,r16
L_8f73e0:
	brne_s r0,0,L_8f740c
L_8f73e2:
	mov_s r0,sp
L_8f73e4:
	bl.d L_8c1cd8
L_8f73e8:
	mov_s r1,0x20
L_8f73ea:
	ld_s r2,[r13]
L_8f73ec:
	mov_s r1,0x1012678
L_8f73f2:
	mov_s r0,0x20
L_8f73f4:
	bl.d L_8dcc80
L_8f73f8:
	mov_s r3,0x2
L_8f73fa:
	ld_s r1,[r13,0x20]
L_8f73fc:
	mov_s r2,sp
L_8f73fe:
	add r4,r13,0x4
L_8f7402:
	mov_s r0,r13
L_8f7404:
	bl.d L_8f8948
L_8f7408:
	mov_s r3,0x20
L_8f740a:
	b_s L_8f7442
	.global L_8f740c
L_8f740c:
	add3 r0,r13,0xd
L_8f7410:
	bl.d L_8c1cd8
L_8f7414:
	mov_s r1,0x20
L_8f7416:
	mov_s r0,0x37448
L_8f741c:
	st_s r0,[r13,0x34]
L_8f741e:
	mov_s r2,0x37450
L_8f7424:
	mov_s r0,r13
L_8f7426:
	bl.d L_8f9070
L_8f742a:
	mov_s r1,r14
L_8f742c:
	mov_s r0,sp
L_8f742e:
	mov_s r1,r15
L_8f7430:
	bl.d L_8c0380
L_8f7434:
	mov_s r2,0x8
L_8f7436:
	ld_s r1,[sp,0x0]
L_8f7438:
	mov_s r0,0x2a
L_8f743a:
	ld_s r2,[sp,0x4]
L_8f743c:
	bl.d L_8dbe54
L_8f7440:
	mov_s r3,0x0
	.global L_8f7442
L_8f7442:
	b.d L_8c0244
L_8f7446:
	add_s sp,sp,0x20
L_8f7448:
	b.d L_8f7344
L_8f744c:
	st_s r1,[r0,0x20]
L_8f744e:
	nop_s
L_8f7450:
	push_s blink
L_8f7452:
	push_s r13
L_8f7454:
	mov.f r13,r0
L_8f7458:
	beq_s L_8f7480
	.global L_8f745a
L_8f745a:
	ld_s r1,[r13]
L_8f745c:
	mov_s r0,0x0
L_8f745e:
	st_s r0,[r13,0x10]
L_8f7460:
	brne r1,0x2,L_8f746c
L_8f7464:
	ld_s r1,[r13,0x20]
L_8f7466:
	cmp_s r1,0x2
L_8f7468:
	mov.eq r0,0x1
	.global L_8f746c
L_8f746c:
	extb.f 0x0,r0
L_8f7470:
	mov.ne r0,0x2b
L_8f7474:
	bl.ne.d L_8dbe88
L_8f7478:
	mov.ne r1,0x3
L_8f747c:
	b L_8c025c
	.global L_8f7480
L_8f7480:
	mov_s r0,blink
L_8f7482:
	mov_s r1,0x145e
L_8f7488:
	bl L_8c9b28
L_8f748c:
	b_s L_8f745a
L_8f748e:
	nop_s
