/* state_sm_803424__action_cmp12 @ 0x8cb4d0, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HOST EVENT (WMI_TOF_FTM_PER_DEST_RES_EVENTID=0x1990) ABORT report action flags  %d, status %d
 * Зовут его: state_sm_803424__action_8f0500, state_sm_803424__action_8f0534
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ftm__set_shared_active_flag, fw_log_emit2, host_if__send_pair, low_sme__send_evt2sw, tof_mgr__ftm_req_done
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_803424__action_cmp12
state_sm_803424__action_cmp12:
	.global L_8cb4d0
L_8cb4d0:
	push_s blink
L_8cb4d2:
	bl L_8c01dc
L_8cb4d6:
	mov_s r13,r1
L_8cb4d8:
	mov_s r15,r2
L_8cb4da:
	cmp_s r2,0x1
L_8cb4dc:
	cmp.ne r15,0x2
L_8cb4e0:
	bne_s L_8cb534
L_8cb4e2:
	bl.d L_8cb544
L_8cb4e6:
	mov_s r0,0x2
L_8cb4e8:
	mov r16,0x0
L_8cb4ec:
	breq_s r13,0,L_8cb534
L_8cb4ee:
	bl L_8c32d8
L_8cb4f2:
	mov_s r14,r0
L_8cb4f4:
	ld_s r0,[r13,0x10]
L_8cb4f6:
	mov_s r2,0x1
L_8cb4f8:
	st_s r0,[r14,0x4]
L_8cb4fa:
	ldw_s r0,[r13,0x14]
L_8cb4fc:
	mov_s r1,0x101a09c
L_8cb502:
	stw_s r0,[r14,0x8]
L_8cb504:
	ldb_s r0,[r13,0x1c]
L_8cb506:
	stb r16,[r14, 0x18]
L_8cb50a:
	st_s r0,[r14]
L_8cb50c:
	stb_s r2,[r14,0xa]
L_8cb50e:
	stb_s r2,[r14,0xb]
L_8cb510:
	mov_s r0,0x2b
L_8cb512:
	bl.d L_8dcc80
L_8cb516:
	mov_s r3,r2
L_8cb518:
	mov_s r0,r14
L_8cb51a:
	mov_s r1,0x1995
L_8cb520:
	mov_s r2,0x20
L_8cb522:
	mov_s r3,r16
L_8cb524:
	mov r4,r16
L_8cb528:
	mov r5,r16
L_8cb52c:
	bl.d L_8e5474
L_8cb530:
	mov r6,r16
	.global L_8cb534
L_8cb534:
	ld_s r0,[gp,-0x74]
L_8cb536:
	mov_s r1,r13
L_8cb538:
	bl.d L_8cb2bc
L_8cb53c:
	mov_s r2,r15
L_8cb53e:
	b.d L_8c0244
L_8cb542:
	mov_s r0,0x1
