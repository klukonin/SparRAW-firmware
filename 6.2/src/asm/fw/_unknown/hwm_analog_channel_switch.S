/* hwm_analog_channel_switch @ 0x8d73f4, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    ====== hwm_ANALOG_CHANNEL_SWITCH  channel_num[1..4]=%d ======
 * Зовут его: hw_sysapi_rx_omni_sector_set, hwm_analog_channel_switch__thunk_arg1_zero
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, channel__check_range, fw_log_emit1, hwd_abif__dvs_rfca_cmd_enable, hwd_abif__fs_off, hwd_abif__fs_on, hwd_abif__rfc_clk_ctrl, hwd_abif__rgf_889380, hwd_rfc_powerdown_deep_all_rfs_fw, hwd_rfc_powerup_deep_all_rfs_fw, hwm_analog__prepare_buf
 * Глобалы (через gp): 0x800458, 0x80045c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm_analog_channel_switch
hwm_analog_channel_switch:
	.global L_8d73f4
L_8d73f4:
	push_s blink
L_8d73f6:
	bl L_8c01d4
L_8d73fa:
	mov_s r17,r0
L_8d73fc:
	mov_s r16,r1
L_8d73fe:
	mov_s r18,r2
L_8d7400:
	ld_s r0,[gp,0x2d4]
L_8d7402:
	mov_s r15,0x0
L_8d7404:
	cmp_s r0,0x0
L_8d7406:
	mov.ne r15,0xa
	.global L_8d740a
L_8d740a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d740c:
	bl.d L_8d3424
L_8d7410:
	extb_s r15,r15
L_8d7412:
	bl.d L_8ced8c
L_8d7416:
	mov_s r0,0x1
L_8d7418:
	bl.d L_8ced74
L_8d741c:
	mov_s r0,0x0
L_8d741e:
	bl L_8cea04
L_8d7422:
	cmp r16,0x0
L_8d7426:
	mov.ne r0,r17
L_8d742a:
	mov.ne r1,r16
L_8d742e:
	bl.ne.d L_8cfadc
L_8d7432:
	mov.ne r2,r18
L_8d7436:
	bl.d L_8cea38
L_8d743a:
	mov_s r0,r17
L_8d743c:
	bl.d L_8d24fc
L_8d7440:
	mov_s r0,r17
L_8d7442:
	mov_s r0,0x7d
L_8d7444:
	asl_s r0,r0,0x8
L_8d7446:
	mov lp_count,r0
L_8d744a:
	nop_s
L_8d744c:
	lp L_8d7454
L_8d7450:
	nop_s
L_8d7452:
	nop_s
	.global L_8d7454
L_8d7454:
	bl.d L_8ced74
L_8d7458:
	mov_s r0,0x1
L_8d745a:
	mov r0,0x190
L_8d745e:
	mov lp_count,r0
L_8d7462:
	nop_s
L_8d7464:
	lp L_8d746c
L_8d7468:
	nop_s
L_8d746a:
	nop_s
	.global L_8d746c
L_8d746c:
	bl.d L_8ced8c
L_8d7470:
	mov_s r0,0x0
L_8d7472:
	mov_s r13,0x8042c8
L_8d7478:
	bl.d L_8ccb3c
L_8d747c:
	mov_s r0,r13
L_8d747e:
	cmp_s r0,0x0
L_8d7480:
	ble.d L_8d74e4
L_8d7484:
	mov.le r14,0x1
L_8d7488:
	bl L_8d34c0
L_8d748c:
	cmp_s r15,0xa
L_8d748e:
	mov_s r2,0x1
L_8d7490:
	sub.lt r2,r2,r2
L_8d7494:
	mov_s r0,r13
L_8d7496:
	bl.d L_8c6d00
L_8d749a:
	mov_s r1,r17
L_8d749c:
	mov.f r14,r0
L_8d74a0:
	bne_s L_8d74b2
L_8d74a2:
	ld_s r0,[gp,0x2d8]
L_8d74a4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d74a6:
	st.as r0,[gp,0xb6]
L_8d74aa:
	bl.d L_8e2960
L_8d74ae:
	mov_s r0,0x0
L_8d74b0:
	b_s L_8d74d4
	.global L_8d74b2
L_8d74b2:
	ld r0,[r13,0x46c]
L_8d74ba:
	breq_s r0,0,L_8d74d4
L_8d74bc:
	bl.d L_8ccb3c
L_8d74c0:
	mov_s r0,r13
L_8d74c2:
	bl.d L_8ce910
L_8d74c6:
	mov_s r1,0x0
L_8d74c8:
	mov_s r0,0x0
L_8d74ca:
	mov r1,0x44c
L_8d74ce:
	bl.d L_8d4308
L_8d74d2:
	mov_s r2,0x1
	.global L_8d74d4
L_8d74d4:
	brne r14,0x1,L_8d74e4
L_8d74d8:
	bl.d L_8ccb1c
L_8d74dc:
	mov_s r0,r13
L_8d74de:
	bl.d L_8ce910
L_8d74e2:
	mov_s r1,0x0
	.global L_8d74e4
L_8d74e4:
	brne_s r14,0,L_8d74ec
L_8d74e6:
	cmp_s r15,0xa
L_8d74e8:
	ble L_8d740a
	.global L_8d74ec
L_8d74ec:
	mov_s r1,0x101d064
L_8d74f2:
	add r2,r17,0x1
L_8d74f6:
	bl.d L_8dcc10
L_8d74fa:
	mov_s r0,0x21
L_8d74fc:
	b L_8c0234
