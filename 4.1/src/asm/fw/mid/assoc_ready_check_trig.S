/* assoc_ready_check_trig @ 0x8c33f4, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   assoc_ready_check_trig: actual=%d,req=%d
 *   mid::assoc_ready_check_trig. No resources. midid:%d
 *   mid.cpp
 *   assoc_ready_check_trig: for MID %d set PCP_ready = %d, current PCP_ready %d
 * Зовут его: check_memory_resource_timeout_cb, conn_msm__on_ntf_disc_complete, conn_msm__on_ntf_key_installed
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bss_bi_ctrl_PCP_ready_set, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, mid_list__count_free, pcp_restart, u_schd__schedule
 * Глобалы (через gp): 0x8002e0
 */
	.section .text.assoc_ready_check_trig,"ax",@progbits
	.global assoc_ready_check_trig
assoc_ready_check_trig:
	.global L_8c33f4
L_8c33f4:
	push_s blink
L_8c33f6:
	bl L_8c02bc
L_8c33fa:
	mov_s r14,r0
L_8c33fc:
	add3 r13,r0,0x9
L_8c3400:
	ld_s r1,[r13,0x8]
L_8c3402:
	mov_s r0,0x0
L_8c3404:
	cmp_s r1,0x2
L_8c3406:
	cmp.ne r1,0x3
L_8c340a:
	mov.eq r0,0x1
L_8c340e:
	extb.f 0x0,r0
L_8c3412:
	beq_s L_8c34e4
L_8c3414:
	ld_s r0,[gp,0x170]
L_8c3416:
	breq r0,0x0,L_8c34e4
L_8c341a:
	breq r13,0x0,L_8c34a2
	.global L_8c341e
L_8c341e:
	ldb r0,[r13,0x10c]
L_8c3426:
	mov_s r15,0x1
L_8c3428:
	bic.f r0,r0,-0x31
L_8c342c:
	sub.eq r15,r15,r15
L_8c3430:
	bl.d L_8ca464
L_8c3434:
	mov_s r0,r14
L_8c3436:
	ldb_s r1,[r14,0x11]
L_8c3438:
	mov_s r2,0x100b46c
L_8c343e:
	cmp_s r0,r1
L_8c3440:
	rlc r16,0x0
L_8c3444:
	mov_s r0,0xb
L_8c3446:
	mov_s r1,0x2
L_8c3448:
	mov_s r3,r15
L_8c344a:
	bl.d L_8edff8
L_8c344e:
	mov r4,r16
L_8c3452:
	breq r15,r16,L_8c34e4
L_8c3456:
	mov_s r0,0x8425c0
L_8c345c:
	ld_s r1,[r0,0xc]
L_8c345e:
	ld_s r0,[r0,0x10]
L_8c3460:
	cmp_s r1,r0
L_8c3462:
	mov_s r0,0x1
L_8c3464:
	sub.cs r0,r0,r0
L_8c3468:
	breq_s r0,0,L_8c34ba
L_8c346a:
	ld.as r0,[r14,0xb8]
L_8c346e:
	brne_s r0,0,L_8c34e4
L_8c3470:
	mov_s r2,0x100b498
L_8c3476:
	mov_s r0,0xb
L_8c3478:
	mov_s r1,0x2
L_8c347a:
	bl.d L_8edfcc
L_8c347e:
	ldb_s r3,[r14,0x10]
L_8c3480:
	mov_s r0,0x5554
L_8c3486:
	mov_s r1,r14
L_8c3488:
	mov_s r2,0x0
L_8c348a:
	mov_s r3,0x1
L_8c348c:
	mov r4,0x2710
L_8c3494:
	mov_s r5,r2
L_8c3496:
	bl.d L_8dc92c
L_8c349a:
	mov_s r6,r2
L_8c349c:
	st.as r0,[r14,0xb8]
L_8c34a0:
	b_s L_8c34e4
	.global L_8c34a2
L_8c34a2:
	mov_s r0,blink
L_8c34a4:
	mov_s r2,0x100aedc
L_8c34aa:
	mov_s r1,0x11f3
L_8c34b0:
	bl.d L_8c82c0
L_8c34b4:
	mov r3,0x4e0
L_8c34b8:
	b_s L_8c341e
	.global L_8c34ba
L_8c34ba:
	mov_s r2,0x100b4cc
L_8c34c0:
	mov_s r0,0xb
L_8c34c2:
	mov_s r1,0x2
L_8c34c4:
	ldb_s r3,[r14,0x10]
L_8c34c6:
	mov r4,r16
L_8c34ca:
	bl.d L_8ee034
L_8c34ce:
	mov r5,r16
L_8c34d2:
	mov_s r0,r13
L_8c34d4:
	bl.d L_8c4298
L_8c34d8:
	mov_s r1,r16
L_8c34da:
	mov_s r0,r14
L_8c34dc:
	bl.d L_8eee64
L_8c34e0:
	add r0,r0,0x234
	.global L_8c34e4
L_8c34e4:
	b L_8c0324
