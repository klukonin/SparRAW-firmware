/* rm_ch_switch_sm__switch_on @ 0x8e84c0, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm::switch_on. call channel_switch for channel %d
 *   rm_ch_switch_sm::switch_on. call ucode RX_ON. [init_tsf = %d][rx_sync_tsf = %d][tsf = 0x%x]
 * Зовёт сам: CALIB_MNGR__system_state_evt_handler, __ld_r13_to_r13_ret, fw_log_emit1, fw_log_emit3, lmac_if_send_cmd_0x01, mid_list__by_mid_fw, rm_ch_switch__program_mac, rm_ch_switch__resume_tx_queue
 * Глобалы (через gp): 0x8002fc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__switch_on
rm_ch_switch_sm__switch_on:
	.global L_8e84c0
L_8e84c0:
	push_s blink
L_8e84c2:
	push_s r13
L_8e84c4:
	mov_s r13,r0
L_8e84c6:
	ld_s r0,[r0,0x10]
L_8e84c8:
	or r0,r0,0x18
L_8e84cc:
	st_s r0,[r13,0x10]
L_8e84ce:
	ldb_s r0,[r13,0x3]
L_8e84d0:
	ld_s r2,[r13,0xc]
L_8e84d2:
	breq_s r0,0,L_8e84e2
L_8e84d4:
	mov_s r1,0x10194bc
L_8e84da:
	mov_s r0,0x28
L_8e84dc:
	bl.d L_8dcc10
L_8e84e0:
	ld_s r2,[r2]
	.global L_8e84e2
L_8e84e2:
	ld_s r0,[gp,0x178]
L_8e84e4:
	ld_s r1,[r13,0xc]
L_8e84e6:
	brne_s r0,0,L_8e84f0
L_8e84e8:
	mov_s r0,0x1
L_8e84ea:
	bl.d L_8e8688
L_8e84ee:
	ld_s r1,[r1]
	.global L_8e84f0
L_8e84f0:
	ld_s r0,[r13,0x14]
L_8e84f2:
	bset_s r0,r0,0x3
L_8e84f4:
	st_s r0,[r13,0x14]
L_8e84f6:
	mov_s r0,0x886e80
L_8e84fc:
	ld r4,[r0, 0x38]
L_8e8500:
	ldb_s r0,[r13,0x3]
L_8e8502:
	ld_s r3,[r13,0xc]
L_8e8504:
	breq_s r0,0,L_8e8516
L_8e8506:
	ld_s r2,[r3,0x14]
L_8e8508:
	mov_s r1,0x10194fc
L_8e850e:
	mov_s r0,0x28
L_8e8510:
	bl.d L_8dcd00
L_8e8514:
	ld_s r3,[r3,0xc]
	.global L_8e8516
L_8e8516:
	ld_s r1,[r13,0xc]
L_8e8518:
	ld_s r0,[r1]
L_8e851a:
	st_s r0,[r13,0x18]
L_8e851c:
	bl.d L_8cc3dc
L_8e8520:
	ldb r0,[r1, 0x24]
L_8e8524:
	bl L_8c3ac0
L_8e8528:
	ld_s r3,[r13,0xc]
L_8e852a:
	ld r4,[r3, 0x14]
L_8e852e:
	ld_s r0,[r3,0x18]
L_8e8530:
	ld_s r1,[r3,0x1c]
L_8e8532:
	ld_s r2,[r3,0x20]
L_8e8534:
	bl.d L_8dbd2c
L_8e8538:
	ld_s r3,[r3,0xc]
L_8e853a:
	ld_s r0,[r13,0xc]
L_8e853c:
	bl.d L_8e7948
L_8e8540:
	ld_s r0,[r0,0x8]
L_8e8542:
	b L_8c025c
L_8e8546:
	nop_s
