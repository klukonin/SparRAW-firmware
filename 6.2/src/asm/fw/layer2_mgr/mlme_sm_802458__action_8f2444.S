/* mlme_sm_802458__action_8f2444 @ 0x8f2444, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Handle disassociate State %d (reason %d)
 *   clearing disassoc pkt
 *   clearing saved assoc request
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, mem_pool__free_thunk, mgmt_pkt__release, mlme_notify
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8f2444
mlme_sm_802458__action_8f2444:
	.global L_8f2444
L_8f2444:
	push_s blink
L_8f2446:
	bl L_8c01e0
L_8f244a:
	mov.f r13,r1
L_8f244e:
	mov_s r14,r0
L_8f2450:
	beq_s L_8f24b2
	.global L_8f2452
L_8f2452:
	ld_s r3,[r13,0xc]
L_8f2454:
	mov_s r1,0x10116e8
L_8f245a:
	ldb_s r2,[r14]
L_8f245c:
	mov_s r0,0x2a
L_8f245e:
	bl.d L_8dcc80
L_8f2462:
	ldw r3,[r3, 0xcc]
L_8f2466:
	mov_s r15,0x0
L_8f2468:
	st_s r15,[r14,0xc]
L_8f246a:
	ld_s r1,[r14,0x20]
L_8f246c:
	mov_s r0,r14
L_8f246e:
	ld_s r2,[r13,0xc]
L_8f2470:
	mov_s r3,0x2
L_8f2472:
	ldb_s r1,[r1,0x8]
L_8f2474:
	ldw r2,[r2, 0xcc]
L_8f2478:
	bl.d L_8de394
L_8f247c:
	mov_s r4,r15
L_8f247e:
	mov_s r1,0x1011404
L_8f2484:
	bl.d L_8dcba8
L_8f2488:
	mov_s r0,0x2a
L_8f248a:
	bl.d L_8cb180
L_8f248e:
	mov_s r0,r13
L_8f2490:
	bl.d L_8cb15c
L_8f2494:
	mov_s r0,r13
L_8f2496:
	ld_s r0,[r14,0x2c]
L_8f2498:
	breq_s r0,0,L_8f24ae
L_8f249a:
	mov_s r1,0x1011714
L_8f24a0:
	bl.d L_8dcba8
L_8f24a4:
	mov_s r0,0x2a
L_8f24a6:
	bl.d L_8cb15c
L_8f24aa:
	ld_s r0,[r14,0x2c]
L_8f24ac:
	st_s r15,[r14,0x2c]
	.global L_8f24ae
L_8f24ae:
	b L_8c024c
	.global L_8f24b2
L_8f24b2:
	mov_s r0,blink
L_8f24b4:
	mov_s r1,0x11fe
L_8f24ba:
	bl L_8c9b28
L_8f24be:
	b_s L_8f2452
