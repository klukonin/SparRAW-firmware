/* rm_ch_switch_sm__switch_on @ 0x8e33c8, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm::switch_on. call channel_switch for channel %d
 *   rm_ch_switch_sm::switch_on. call ucode RX_ON. [init_tsf = %d][rx_sync_tsf = %d][tsf = 0x%x]
 * Зовёт сам: CALIB_MNGR__system_state_evt_handler, __ld_r13_ret, fw_log__emit1, fw_log__emit3, lmac_if_send_cmd_0x01, mid_list__by_mid, rm_ch_switch__program_mac, rm_ch_switch__resume_tx_queue
 * Глобалы (через gp): 0x8002e8
 */
	.section .text.rm_ch_switch_sm__switch_on,"ax",@progbits
	.global rm_ch_switch_sm__switch_on
rm_ch_switch_sm__switch_on:
	.byte 0x4f
	.byte 0xee
	.global fwlog_rm_ch_switch_sm_switch_on_call_ucode_RX_
fwlog_rm_ch_switch_sm_switch_on_call_ucode_RX_:
L_8e33ca:
	nop_s
L_8e33cc:
	push_s blink
L_8e33ce:
	push_s r13
L_8e33d0:
	mov_s r13,r0
L_8e33d2:
	ld_s r0,[r0,0x34]
L_8e33d4:
	or r0,r0,0x18
L_8e33d8:
	st_s r0,[r13,0x34]
L_8e33da:
	ld_s r0,[r13,0x28]
L_8e33dc:
	ld_s r3,[r13,0x30]
L_8e33de:
	breq_s r0,0,L_8e33f0
L_8e33e0:
	mov_s r2,0x1016170
L_8e33e6:
	mov_s r0,0x8
L_8e33e8:
	mov_s r1,0x2
L_8e33ea:
	bl.d L_8edfcc
L_8e33ee:
	ld_s r3,[r3]
	.global L_8e33f0
L_8e33f0:
	ld_s r0,[gp,0x178]
L_8e33f2:
	ld_s r1,[r13,0x30]
L_8e33f4:
	brne_s r0,0,L_8e33fe
L_8e33f6:
	mov_s r0,0x1
L_8e33f8:
	bl.d L_8e3614
L_8e33fc:
	ld_s r1,[r1]
	.global L_8e33fe
L_8e33fe:
	ld_s r0,[r13,0x38]
L_8e3400:
	bset_s r0,r0,0x3
L_8e3402:
	st_s r0,[r13,0x38]
L_8e3404:
	mov_s r0,0x886e80
L_8e340a:
	ld r5,[r0, 0x38]
L_8e340e:
	ld_s r0,[r13,0x28]
L_8e3410:
	ld_s r3,[r13,0x30]
L_8e3412:
	breq_s r0,0,L_8e3428
L_8e3414:
	mov_s r2,0x10161b0
L_8e341a:
	ld r4,[r3, 0xc]
L_8e341e:
	mov_s r0,0x8
L_8e3420:
	mov_s r1,0x2
L_8e3422:
	bl.d L_8ee034
L_8e3426:
	ld_s r3,[r3,0x14]
	.global L_8e3428
L_8e3428:
	ld_s r1,[r13,0x30]
L_8e342a:
	ld_s r0,[r1]
L_8e342c:
	st_s r0,[r13,0x3c]
L_8e342e:
	bl.d L_8ca1b0
L_8e3432:
	ldb r0,[r1, 0x24]
L_8e3436:
	bl L_8c31c8
L_8e343a:
	ld_s r3,[r13,0x30]
L_8e343c:
	ld r4,[r3, 0x14]
L_8e3440:
	ld_s r0,[r3,0x18]
L_8e3442:
	ld_s r1,[r3,0x1c]
L_8e3444:
	ld_s r2,[r3,0x20]
L_8e3446:
	bl.d L_8d8a14
L_8e344a:
	ld_s r3,[r3,0xc]
L_8e344c:
	ld_s r0,[r13,0x30]
L_8e344e:
	bl.d L_8e2728
L_8e3452:
	ld_s r0,[r0,0x8]
L_8e3454:
	b L_8c033c
