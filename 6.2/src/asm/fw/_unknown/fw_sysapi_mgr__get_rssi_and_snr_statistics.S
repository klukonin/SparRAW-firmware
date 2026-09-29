/* fw_sysapi_mgr__get_rssi_and_snr_statistics @ 0x8f3780, 332 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_sysapi_mgr::get_rssi_and_snr_statistics(): | rssi_idx %d | rssi_adc %d | rssi_ant %d
 *   [NNL] | snr_adc_val %d | agc_row_val %d | g_zero_db_row %d
 *   [NNL] | g_calib_if_gain_txrx_target %d
 *   fw_sysapi_mgr::get_rssi_and_snr_statistics(): | samples_num %d | rssi_adc_min %d | rssi_adc_max %d
 *   [NNL] | rssi_ant_min %d | rssi_ant_max %d
 *   [NNL] | snr_adc_min %d | snr_adc_max %d | use_rssi_locked %d
 * Зовут его: scan_mngr__dwelling_done
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, fw_log_emit1, fw_log_emit2, fw_log_emit3, phy__get_88306c_6bit, phy_rx__read_rssi_adc, phy_rx__read_rssi_adc_locked, rx_energy__calc_rssi_q4, sysapi_mgr__stats_lut_find_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__get_rssi_and_snr_statistics
fw_sysapi_mgr__get_rssi_and_snr_statistics:
	.global L_8f3780
L_8f3780:
	push_s blink
L_8f3782:
	bl L_8c01c4
L_8f3786:
	st.a r0,[sp,-0x8]
L_8f378a:
	st_s r2,[sp,0x4]
L_8f378c:
	mov_s r17,r3
L_8f378e:
	mov r21,r4
L_8f3792:
	mov_s r13,r5
L_8f3794:
	st 0xffffff,[r13, 0x10]
L_8f379c:
	st 0xff000001,[r13, 0x14]
L_8f37a4:
	st 0xffffff,[r13, 0x18]
L_8f37ac:
	st 0xff000001,[r13, 0x1c]
L_8f37b4:
	st 0xffffff,[r13, 0x20]
L_8f37bc:
	st 0xff000001,[r13, 0x24]
L_8f37c4:
	st_s r1,[r13,0x28]
L_8f37c6:
	brlo.d r1,0x1,L_8f388e
L_8f37ca:
	mov_s r15,0x0
	.global L_8f37cc
L_8f37cc:
	mov_s r22,r1
L_8f37ce:
	cmp r17,0x0
L_8f37d2:
	cmp.ne r21,0x0
L_8f37d6:
	beq_s L_8f37e2
L_8f37d8:
	ld.as r14,[r17,r15]
L_8f37dc:
	ld.as r18,[r21,r15]
L_8f37e0:
	b_s L_8f37f8
	.global L_8f37e2
L_8f37e2:
	ld_s r0,[sp,0x4]
L_8f37e4:
	breq_s r0,0,L_8f37ec
L_8f37e6:
	bl L_8d2208
L_8f37ea:
	b_s L_8f37f0
	.global L_8f37ec
L_8f37ec:
	bl L_8d21f8
	.global L_8f37f0
L_8f37f0:
	bl.d L_8d25b4
L_8f37f4:
	mov_s r14,r0
L_8f37f6:
	mov_s r18,r0
	.global L_8f37f8
L_8f37f8:
	mov r20,0x800508
L_8f3800:
	ldb r2,[r20]
L_8f3804:
	mov_s r0,r14
L_8f3806:
	mov_s r1,r18
L_8f3808:
	bl.d L_8d1b70
L_8f380c:
	ldb r3,[gp, 0xa3]
L_8f3810:
	mov_s r19,r0
L_8f3812:
	ld_s r0,[r13,0x14]
L_8f3814:
	max r0,r14,r0
L_8f3818:
	st_s r0,[r13,0x14]
L_8f381a:
	ld_s r0,[r13,0x10]
L_8f381c:
	min r0,r14,r0
L_8f3820:
	st_s r0,[r13,0x10]
L_8f3822:
	ld_s r0,[sp,0x0]
L_8f3824:
	bl.d L_8f2038
L_8f3828:
	mov_s r1,r14
L_8f382a:
	mov_s r16,r0
L_8f382c:
	ld_s r0,[r13,0x1c]
L_8f382e:
	mov_s r1,0x1012ae8
L_8f3834:
	max r0,r16,r0
L_8f3838:
	st_s r0,[r13,0x1c]
L_8f383a:
	ld_s r0,[r13,0x18]
L_8f383c:
	mov_s r2,r15
L_8f383e:
	min r0,r16,r0
L_8f3842:
	st_s r0,[r13,0x18]
L_8f3844:
	ld_s r0,[r13,0x20]
L_8f3846:
	mov_s r3,r14
L_8f3848:
	min r0,r19,r0
L_8f384c:
	st_s r0,[r13,0x20]
L_8f384e:
	ld_s r0,[r13,0x24]
L_8f3850:
	max r0,r19,r0
L_8f3854:
	st_s r0,[r13,0x24]
L_8f3856:
	mov_s r0,0x20
L_8f3858:
	bl.d L_8dcd00
L_8f385c:
	mov r4,r19
L_8f3860:
	mov_s r1,0x1012b40
L_8f3866:
	ldb r4,[r20]
L_8f386a:
	mov_s r0,0x20
L_8f386c:
	mov_s r2,r16
L_8f386e:
	bl.d L_8dcd00
L_8f3872:
	mov_s r3,r18
L_8f3874:
	mov_s r1,0x1012b7c
L_8f387a:
	mov_s r0,0x20
L_8f387c:
	bl.d L_8dcc10
L_8f3880:
	ldb r2,[gp, 0xa3]
L_8f3884:
	sub r1,r22,0x1
L_8f3888:
	brhs.d r1,0x1,L_8f37cc
L_8f388c:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8f388e
L_8f388e:
	ld r4,[r13, 0x14]
L_8f3892:
	mov_s r1,0x1012ba4
L_8f3898:
	ld_s r2,[r13,0x28]
L_8f389a:
	mov_s r0,0x20
L_8f389c:
	bl.d L_8dcd00
L_8f38a0:
	ld_s r3,[r13,0x10]
L_8f38a2:
	mov_s r1,0x1012c08
L_8f38a8:
	ld_s r2,[r13,0x20]
L_8f38aa:
	mov_s r0,0x20
L_8f38ac:
	bl.d L_8dcc80
L_8f38b0:
	ld_s r3,[r13,0x24]
L_8f38b2:
	mov_s r1,0x1012c34
L_8f38b8:
	ld_s r2,[r13,0x18]
L_8f38ba:
	mov_s r0,0x20
L_8f38bc:
	ld_s r3,[r13,0x1c]
L_8f38be:
	bl.d L_8dcd00
L_8f38c2:
	ld r4,[sp, 0x4]
L_8f38c6:
	b.d L_8c0214
L_8f38ca:
	add_s sp,sp,0x8
