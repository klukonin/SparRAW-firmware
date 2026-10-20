/* mlme_sm_8027a0__action_8f24d8 @ 0x8f24d8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    DISCONNECT flow started m_graceful = %d.
 *   disc_wd_timeout_cb()- Timer Expired
 * Зовёт сам: STREAM_MGR, __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit1, wait_for_disconnect
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_8027a0__action_8f24d8
mlme_sm_8027a0__action_8f24d8:
	.global L_8f24d8
L_8f24d8:
	push_s blink
L_8f24da:
	push_s r13
L_8f24dc:
	mov_s r13,r0
L_8f24de:
	stb_s r1,[r0,0x14]
L_8f24e0:
	stw_s r2,[r0,0x16]
L_8f24e2:
	ld_s r0,[r0,0xc]
L_8f24e4:
	mov_s r3,0x1
L_8f24e6:
	bset_s r0,r0,0x1
L_8f24e8:
	st_s r0,[r13,0xc]
L_8f24ea:
	mov_s r2,0x0
L_8f24ec:
	st_s r2,[r13,0x10]
L_8f24ee:
	cmp_s r1,0x2
L_8f24f0:
	cmp.ne r1,0x7
L_8f24f4:
	cmp.ne r1,0x1
L_8f24f8:
	bne_s L_8f24fe
L_8f24fa:
	st_s r3,[r13,0x10]
L_8f24fc:
	mov_s r2,0x1
	.global L_8f24fe
L_8f24fe:
	mov_s r1,0x1011bc4
L_8f2504:
	bl.d L_8dcc10
L_8f2508:
	mov_s r0,0x2b
L_8f250a:
	ld_s r0,[r13,0x8]
L_8f250c:
	ld_s r1,[r13,0x10]
L_8f250e:
	ld_s r0,[r0,0x8]
L_8f2510:
	bl.d L_8e2808
L_8f2514:
	ldb_s r2,[r13,0x14]
L_8f2516:
	b L_8c025c
L_8f251a:
	nop_s
L_8f251c:
	push_s blink
L_8f251e:
	bl L_8c01e4
L_8f2522:
	mov_s r13,r0
L_8f2524:
	mov_s r14,0x0
L_8f2526:
	st_s r14,[r0,0x1c]
L_8f2528:
	mov_s r1,0x1011cb4
L_8f252e:
	bl.d L_8dcba8
L_8f2532:
	mov_s r0,0x1b
L_8f2534:
	st_s r14,[r13,0x18]
L_8f2536:
	bl.d L_8fb3c8
L_8f253a:
	mov_s r0,r13
L_8f253c:
	b L_8c0254
