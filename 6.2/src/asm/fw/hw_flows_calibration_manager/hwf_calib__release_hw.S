/* hwf_calib__release_hw @ 0x8d64c0, 296 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib__log_if_nonzero, calib__release_hw_thunk, calib_sar__enable_path, calib_silent_rssi_sparrow__correction_alg, hwf_calib__restore_path
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, hw_modes__set_loopback, hwd_abif__caf_lpbk_mode, hwd_abif__rx_prepare_ifrx_pwdn, hwd_abif__rx_table_index_force_mode, hwd_abif__sar_dc_config_rgf_mode, hwd_abif__tx_table_index_force_mode, hwd_phy__rx_agc_index_force_mode, hwd_phy__rx_agc_steps_disable, hwd_phy__rx_enable
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_calib__release_hw
hwf_calib__release_hw:
	.global L_8d64c0
L_8d64c0:
	push_s blink
L_8d64c2:
	bl L_8c01e4
L_8d64c6:
	mov_s r14,0x842390
L_8d64cc:
	ld_s r0,[r14]
L_8d64ce:
	brne r0,0x1,L_8d6534
	.global L_8d64d2
L_8d64d2:
	mov_s r13,0x0
L_8d64d4:
	st_s r13,[r14]
L_8d64d6:
	bl.d L_8d219c
L_8d64da:
	mov_s r0,r13
L_8d64dc:
	bl.d L_8d21d0
L_8d64e0:
	mov_s r0,r13
L_8d64e2:
	bl.d L_8ce5e8
L_8d64e6:
	mov_s r0,r13
L_8d64e8:
	bl.d L_8d7560
L_8d64ec:
	mov_s r0,r13
L_8d64ee:
	bl L_8d2b38
L_8d64f2:
	bl.d L_8cee2c
L_8d64f6:
	ldb r0,[r14, 0x2c]
L_8d64fa:
	bl.d L_8d1bc0
L_8d64fe:
	ld_s r0,[r14,0xc]
L_8d6500:
	bl.d L_8d2630
L_8d6504:
	ld_s r0,[r14,0x4]
L_8d6506:
	bl.d L_8cf91c
L_8d650a:
	ld_s r0,[r14,0x8]
L_8d650c:
	ld_s r0,[r14,0x1c]
L_8d650e:
	bl.d L_8d2218
L_8d6512:
	ldb r1,[r14, 0x20]
L_8d6516:
	bl.d L_8d2260
L_8d651a:
	ld_s r0,[r14,0x18]
L_8d651c:
	ld_s r0,[r14,0x24]
L_8d651e:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d6520:
	brhs r0,0x10,L_8d6588
L_8d6524:
	ldb.x r0,[0x8036dc,r0]
L_8d652c:
	add r1,pcl,0x8
L_8d6530:
	add1_s r1,r1,r0
L_8d6532:
	j_s [r1]
	.global L_8d6534
L_8d6534:
	mov_s r0,blink
L_8d6536:
	mov_s r1,0x12df
L_8d653c:
	bl L_8c9b28
L_8d6540:
	b_s L_8d64d2
L_8d6542:
	mov_s r0,0x1
L_8d6544:
	bl.d L_8d76ec
L_8d6548:
	mov_s r1,r0
L_8d654a:
	ld_s r0,[r14,0x34]
L_8d654c:
	cmp_s r0,0x0
L_8d654e:
	bl.ne L_8d2be4
L_8d6552:
	b_s L_8d6594
L_8d6554:
	bl.d L_8d7560
L_8d6558:
	mov_s r0,0x1
L_8d655a:
	ld_s r0,[r14,0x30]
L_8d655c:
	breq_s r0,0,L_8d6594
L_8d655e:
	b_s L_8d6582
L_8d6560:
	ld_s r0,[r14,0x28]
L_8d6562:
	mov_s r1,r13
L_8d6564:
	cmp_s r0,0x0
L_8d6566:
	mov_s r0,0x1
L_8d6568:
	mov_s r2,r13
L_8d656a:
	beq_s L_8d6572
L_8d656c:
	bl L_8d7358
L_8d6570:
	b_s L_8d6576
	.global L_8d6572
L_8d6572:
	bl L_8d7528
	.global L_8d6576
L_8d6576:
	ld_s r0,[r14,0x30]
L_8d6578:
	cmp_s r0,0x0
L_8d657a:
	bl.ne L_8d2be4
L_8d657e:
	ld_s r0,[r14,0x34]
L_8d6580:
	breq_s r0,0,L_8d6594
	.global L_8d6582
L_8d6582:
	bl L_8d2ba4
L_8d6586:
	b_s L_8d6594
	.global L_8d6588
L_8d6588:
	mov_s r0,blink
L_8d658a:
	mov_s r1,0x115c
L_8d6590:
	bl L_8c9b28
	.global L_8d6594
L_8d6594:
	bl.d L_8d21d0
L_8d6598:
	ld_s r0,[r14,0x44]
L_8d659a:
	bl.d L_8d219c
L_8d659e:
	ld_s r0,[r14,0x40]
L_8d65a0:
	mov_s r0,0x0
L_8d65a2:
	bl.d L_8cf5a8
L_8d65a6:
	ldb_s r1,[r14,0x14]
L_8d65a8:
	ld_s r0,[r14,0x10]
L_8d65aa:
	bl.d L_8cf5a8
L_8d65ae:
	ldb_s r1,[r14,0x14]
L_8d65b0:
	mov_s r13,0x8423d0
L_8d65b6:
	mov_s r0,0x0
L_8d65b8:
	bl.d L_8cfef8
L_8d65bc:
	ldb_s r1,[r13,0x10]
L_8d65be:
	ld_s r0,[r14,0x4c]
L_8d65c0:
	bl.d L_8cfef8
L_8d65c4:
	ldb_s r1,[r13,0x10]
L_8d65c6:
	bl.d L_8d2c98
L_8d65ca:
	ld_s r0,[r14,0x3c]
L_8d65cc:
	bl.d L_8d2c1c
L_8d65d0:
	ld_s r0,[r14,0x38]
L_8d65d2:
	ldb_s r0,[r13,0x8]
L_8d65d4:
	ldb_s r1,[r13,0x9]
L_8d65d6:
	bl.d L_8d2e48
L_8d65da:
	ldb_s r2,[r13,0xa]
L_8d65dc:
	bl.d L_8d30f4
L_8d65e0:
	ldb_s r0,[r13,0xb]
L_8d65e2:
	b L_8c0254
L_8d65e6:
	nop_s
