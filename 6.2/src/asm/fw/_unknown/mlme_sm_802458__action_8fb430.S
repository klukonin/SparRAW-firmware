/* mlme_sm_802458__action_8fb430 @ 0x8fb430, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   waitfor_ctrl_assoc_resp_ev_handle. State %d
 *   waitfor_ctrl_assoc_resp_ev_handle, starting assoc res timer.
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit1, u_schd__schedule
 * Глобалы (через gp): 0x8002ec
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8fb430
mlme_sm_802458__action_8fb430:
	.global L_8fb430
L_8fb430:
	push_s blink
L_8fb432:
	bl L_8c01e0
L_8fb436:
	mov_s r13,r0
L_8fb438:
	mov_s r1,0x101183c
L_8fb43e:
	mov_s r0,0x2a
L_8fb440:
	bl.d L_8dcc10
L_8fb444:
	ldb_s r2,[r13]
L_8fb446:
	mov_s r14,0x1
L_8fb448:
	st_s r14,[r13,0xc]
L_8fb44a:
	ld_s r0,[gp,0x168]
L_8fb44c:
	mulu64 r0,0x3e8
L_8fb450:
	ld_s r0,[r13,0x18]
L_8fb452:
	mov_s r15,mlo
L_8fb454:
	brne_s r0,0,L_8fb47a
L_8fb456:
	mov_s r1,0x101186c
L_8fb45c:
	bl.d L_8dcba8
L_8fb460:
	mov_s r0,0x2a
L_8fb462:
	mov_s r0,0x3207c
L_8fb468:
	mov_s r1,r13
L_8fb46a:
	mov_s r2,0x0
L_8fb46c:
	mov_s r3,r14
L_8fb46e:
	mov_s r4,r15
L_8fb470:
	mov_s r5,r2
L_8fb472:
	bl.d L_8e0c0c
L_8fb476:
	mov_s r6,r2
L_8fb478:
	st_s r0,[r13,0x18]
	.global L_8fb47a
L_8fb47a:
	b L_8c024c
L_8fb47e:
	nop_s
