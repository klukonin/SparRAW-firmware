/* hwf_calib__acquire_hw @ 0x8d65e8, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, abif__get_rx_table_index_force_val, fw_sysassert_fatal, hwd_abif__get_88af00, hwd_abif__rx_prepared_ifrx_pwdn_get, hwd_abif__rx_table_index_force_en_get, hwd_abif__sar_dc_config_rgf_mode_get, hwd_abif__tx_table_index_force_en_get, hwd_abif__tx_table_index_force_val_get, hwd_abif__uses_rgf_88af80_8ce614, hwd_phy__dbg_clk_enable_get
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_calib__acquire_hw
hwf_calib__acquire_hw:
	.global L_8d65e8
L_8d65e8:
	push_s blink
L_8d65ea:
	bl L_8c01e0
L_8d65ee:
	mov_s r13,0x842390
L_8d65f4:
	ld_s r0,[r13]
L_8d65f6:
	brne r0,0x0,L_8d66be
	.global L_8d65fa
L_8d65fa:
	mov_s r0,0x1
L_8d65fc:
	bl.d L_8d263c
L_8d6600:
	st_s r0,[r13]
L_8d6602:
	bl.d L_8cf948
L_8d6606:
	st_s r0,[r13,0x4]
L_8d6608:
	bl.d L_8d1c20
L_8d660c:
	st_s r0,[r13,0x8]
L_8d660e:
	bl.d L_8cf59c
L_8d6612:
	st_s r0,[r13,0xc]
L_8d6614:
	bl.d L_8cf5ec
L_8d6618:
	st_s r0,[r13,0x10]
L_8d661a:
	bl.d L_8d26bc
L_8d661e:
	stb_s r0,[r13,0x14]
L_8d6620:
	st_s r0,[r13,0x18]
L_8d6622:
	mov_s r14,0x883000
L_8d6628:
	ld_s r0,[r14,0x48]
L_8d662a:
	lsr_s r0,r0,0xf
L_8d662c:
	bmsk_s r0,r0,0x0
L_8d662e:
	st_s r0,[r13,0x1c]
L_8d6630:
	ld_s r0,[r14,0x48]
L_8d6632:
	bmsk_s r0,r0,0xe
L_8d6634:
	bl.d L_8ce614
L_8d6638:
	stw_s r0,[r13,0x20]
L_8d663a:
	st_s r0,[r13,0x24]
L_8d663c:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d663e:
	brhs r0,0x10,L_8d6652
L_8d6642:
	ldb.x r0,[0x8036cc,r0]
L_8d664a:
	add r1,pcl,0xa
L_8d664e:
	add1_s r1,r1,r0
L_8d6650:
	j_s [r1]
	.global L_8d6652
L_8d6652:
	mov_s r0,blink
L_8d6654:
	mov_s r1,0x142b
L_8d665a:
	bl L_8c9b28
L_8d665e:
	bl L_8ce5d8
L_8d6662:
	bl.d L_8ceec0
L_8d6666:
	st_s r0,[r13,0x28]
L_8d6668:
	stb r0,[r13, 0x2c]
L_8d666c:
	ld_s r0,[r14,0x10]
L_8d666e:
	mov_s r15,0x8423d0
L_8d6674:
	lsr_s r0,r0,0x2
L_8d6676:
	bmsk_s r0,r0,0x0
L_8d6678:
	st_s r0,[r13,0x30]
L_8d667a:
	ld_s r0,[r14,0x4]
L_8d667c:
	lsr_s r0,r0
L_8d667e:
	bmsk_s r0,r0,0x0
L_8d6680:
	bl.d L_8d1c30
L_8d6684:
	st_s r0,[r13,0x34]
L_8d6686:
	bl.d L_8d1c90
L_8d668a:
	st_s r0,[r13,0x38]
L_8d668c:
	st_s r0,[r13,0x3c]
L_8d668e:
	ld_s r0,[r14,0x10]
L_8d6690:
	mov_s r14,0x884000
L_8d6696:
	bmsk_s r0,r0,0x0
L_8d6698:
	st_s r0,[r13,0x40]
L_8d669a:
	ld_s r0,[r14,0x8]
L_8d669c:
	bmsk_s r0,r0,0x0
L_8d669e:
	st_s r0,[r13,0x44]
L_8d66a0:
	bl.d L_8d2ea0
L_8d66a4:
	add3 r0,r13,0x9
L_8d66a8:
	ld_s r0,[r14,0x70]
L_8d66aa:
	bmsk_s r0,r0,0x1
L_8d66ac:
	bl.d L_8cfeec
L_8d66b0:
	stb_s r0,[r15,0xb]
L_8d66b2:
	bl.d L_8cff3c
L_8d66b6:
	st_s r0,[r13,0x4c]
L_8d66b8:
	b.d L_8c024c
L_8d66bc:
	stb_s r0,[r15,0x10]
	.global L_8d66be
L_8d66be:
	mov_s r0,blink
L_8d66c0:
	mov_s r1,0x12de
L_8d66c6:
	bl L_8c9b28
L_8d66ca:
	b_s L_8d65fa
