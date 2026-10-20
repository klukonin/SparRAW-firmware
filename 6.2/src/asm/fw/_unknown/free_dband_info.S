/* free_dband_info @ 0x8f31a0, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   free_dband_info()
 *   ftm_main_sm::ftm_link_timeout_cb()
 *   [TOF] ftm_req_send_wb: no valid connection found
 *   [TOF] Send WB Error, no FTM session SM (status %d).
 * Зовут его: find_main_sm__stop, scan_mngr__clean_all_lists, scan_mngr__prob_done, state_sm_8030f4__action_8f9994
 * Зовёт сам: TX_API__free_memory, __ld_r13_to_r13_ret, __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit1, stream_mgr__check_vring, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global free_dband_info
free_dband_info:
	.global L_8f31a0
L_8f31a0:
	push_s blink
L_8f31a2:
	push_s r13
L_8f31a4:
	mov_s r13,r0
L_8f31a6:
	mov_s r1,0x1016f84
L_8f31ac:
	bl.d L_8dcba8
L_8f31b0:
	mov_s r0,0x2d
L_8f31b2:
	mov_s r0,0x805524
L_8f31b8:
	bl.d L_8caed0
L_8f31bc:
	mov_s r1,r13
L_8f31be:
	b L_8c025c
L_8f31c2:
	nop_s
L_8f31c4:
	push_s blink
L_8f31c6:
	push_s r13
L_8f31c8:
	mov_s r13,r0
L_8f31ca:
	mov_s r1,0x101a004
L_8f31d0:
	bl.d L_8dcba8
L_8f31d4:
	mov_s r0,0x2b
L_8f31d6:
	mov_s r2,0x0
L_8f31d8:
	st_s r2,[r13,0x10]
L_8f31da:
	mov_s r0,r13
L_8f31dc:
	mov_s r1,0x6
L_8f31de:
	mov_s r3,r2
L_8f31e0:
	bl.d L_8d9b6c
L_8f31e4:
	mov_s r4,r2
L_8f31e6:
	b L_8c025c
L_8f31ea:
	nop_s
L_8f31ec:
	push_s blink
L_8f31ee:
	bl.d L_8c01e0
L_8f31f2:
	mov_s r3,r1
L_8f31f4:
	mov_s r14,r0
L_8f31f6:
	brne_s r2,0,L_8f320e
L_8f31f8:
	mov_s r1,0x1019b74
L_8f31fe:
	bl.d L_8dcba8
L_8f3202:
	mov_s r0,0x2b
L_8f3204:
	breq_s r14,0,L_8f3250
	.global L_8f3206
L_8f3206:
	bl.d L_8cb10c
L_8f320a:
	mov_s r0,r14
L_8f320c:
	b_s L_8f3250
	.global L_8f320e
L_8f320e:
	add.f r13,r2,0x164
L_8f3216:
	bne_s L_8f3228
L_8f3218:
	mov_s r1,0x1019ba8
L_8f321e:
	mov_s r0,0x2b
L_8f3220:
	bl.d L_8dcc10
L_8f3224:
	mov_s r2,r3
L_8f3226:
	b_s L_8f3206
	.global L_8f3228
L_8f3228:
	ld_s r0,[r13,0x1c]
L_8f322a:
	mov_s r15,0x0
L_8f322c:
	brne_s r3,0,L_8f3248
L_8f322e:
	breq_s r0,0,L_8f3248
L_8f3230:
	ld_s r0,[r13,0xc]
L_8f3232:
	breq_s r0,0,L_8f323a
L_8f3234:
	bl L_8c8de0
L_8f3238:
	st_s r15,[r13,0xc]
	.global L_8f323a
L_8f323a:
	mov_s r0,r13
L_8f323c:
	mov_s r1,0x1
L_8f323e:
	mov_s r2,r13
L_8f3240:
	mov_s r3,0x0
L_8f3242:
	bl.d L_8d9b6c
L_8f3246:
	mov_s r4,r3
	.global L_8f3248
L_8f3248:
	bl.d L_8cb10c
L_8f324c:
	mov_s r0,r14
L_8f324e:
	st_s r15,[r13,0x14]
	.global L_8f3250
L_8f3250:
	b L_8c024c
