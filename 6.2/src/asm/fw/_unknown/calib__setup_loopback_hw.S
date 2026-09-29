/* calib__setup_loopback_hw @ 0x8d63b0, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd__args_to_regs_default, hwd_abif__caf_lpbk_mode, hwd_abif__rx_prepare_ifrx_pwdn, hwd_abif__rx_rgf_sar_dc_load, hwd_abif__rx_table_index_force_mode, hwd_abif__sar_cal_dc_rgf_clear_all, hwd_abif__sar_dc_config_rgf_mode, hwd_phy__rx_agc_steps_disable, hwd_phy__rx_enable, hwd_phy__rx_ina_det_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib__setup_loopback_hw
calib__setup_loopback_hw:
	.global L_8d63b0
L_8d63b0:
	push_s blink
L_8d63b2:
	bl L_8c01dc
L_8d63b6:
	mov_s r13,r1
L_8d63b8:
	mov_s r15,r2
L_8d63ba:
	mov_s r14,r3
L_8d63bc:
	cmp_s r0,0x0
L_8d63be:
	mov r16,r4
L_8d63c2:
	bl.ne L_8d65e8
L_8d63c6:
	breq_s r13,0,L_8d6412
L_8d63c8:
	bl.d L_8ce5e8
L_8d63cc:
	mov_s r0,0x0
L_8d63ce:
	bl.d L_8d7560
L_8d63d2:
	mov_s r0,0x0
L_8d63d4:
	mov_s r0,0x8042c8
L_8d63da:
	bl L_8ccb3c
L_8d63de:
	bl L_8d3380
L_8d63e2:
	bl.d L_8d33ec
L_8d63e6:
	mov_s r0,0x0
L_8d63e8:
	bl.d L_8cee2c
L_8d63ec:
	mov_s r0,0x7
L_8d63ee:
	bl.d L_8d7560
L_8d63f2:
	mov_s r0,0x1
L_8d63f4:
	bl.d L_8cf91c
L_8d63f8:
	mov_s r0,0x1
L_8d63fa:
	bl L_8cf900
L_8d63fe:
	bl L_8cefc8
L_8d6402:
	mov_s r0,0x0
L_8d6404:
	bl.d L_8cf5a8
L_8d6408:
	mov_s r1,0x3f
L_8d640a:
	mov_s r0,0x1
L_8d640c:
	bl.d L_8cf5a8
L_8d6410:
	mov_s r1,0x3f
	.global L_8d6412
L_8d6412:
	breq_s r15,0,L_8d6440
L_8d6414:
	bl.d L_8d219c
L_8d6418:
	mov_s r0,0x0
L_8d641a:
	bl.d L_8d21d0
L_8d641e:
	mov_s r0,0x0
L_8d6420:
	bl L_8d2b38
L_8d6424:
	bl L_8d2ba4
L_8d6428:
	bl.d L_8d2260
L_8d642c:
	mov_s r0,0x1
L_8d642e:
	bl.d L_8d2630
L_8d6432:
	mov_s r0,0x0
L_8d6434:
	bl.d L_8d1bc0
L_8d6438:
	mov_s r0,0x1
L_8d643a:
	bl.d L_8d219c
L_8d643e:
	mov_s r0,0x1
	.global L_8d6440
L_8d6440:
	breq_s r14,0,L_8d645a
L_8d6442:
	mov r4,0x0
L_8d6446:
	bset r4,r4,r16
L_8d644a:
	asr r5,r4,0x1f
L_8d644e:
	mov_s r0,0x1
L_8d6450:
	mov_s r1,0x0
L_8d6452:
	mov_s r2,r0
L_8d6454:
	bl.d L_8d28ec
L_8d6458:
	mov_s r3,r1
	.global L_8d645a
L_8d645a:
	b L_8c0244
L_8d645e:
	nop_s
