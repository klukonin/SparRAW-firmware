/* hwf_calib__acquire_hw @ 0x8d3870, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_flows_calibration_manager.c
 * Зовут его: calib_lo_power_step, calib_mngr_step_a, calib_mngr_step_b, calib_silent_rssi__vt18, hwf_calib__prepare_hw, hwf_calib__setup_loopback
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, get_reg88a204_s1_w32, hwd_abif__get_88af00, hwd_abif__get_88af80, hwd_phy__get_883180, hwd_phy__get_884100, hwd_phy_get_rx_swap_iq, hwd_phy_get_tx_swap_iq, ut_hw_drivers_cmd_0x128, ut_hw_drivers_cmd_0x129
 */
	.section .text.hwf_calib__acquire_hw,"ax",@progbits
	.global hwf_calib__acquire_hw
hwf_calib__acquire_hw:
	.global L_8d3870
L_8d3870:
	push_s blink
L_8d3872:
	bl L_8c02c0
L_8d3876:
	mov_s r13,0x84264c
L_8d387c:
	ld_s r0,[r13]
L_8d387e:
	brne r0,0x0,L_8d394e
	.global L_8d3882
L_8d3882:
	mov_s r0,0x1
L_8d3884:
	bl.d L_8cf964
L_8d3888:
	st_s r0,[r13]
L_8d388a:
	bl.d L_8ccac8
L_8d388e:
	st_s r0,[r13,0x4]
L_8d3890:
	bl.d L_8cef3c
L_8d3894:
	st_s r0,[r13,0x8]
L_8d3896:
	bl.d L_8cc668
L_8d389a:
	st_s r0,[r13,0xc]
L_8d389c:
	bl.d L_8cc6cc
L_8d38a0:
	st_s r0,[r13,0x10]
L_8d38a2:
	bl.d L_8cf9f0
L_8d38a6:
	stb_s r0,[r13,0x14]
L_8d38a8:
	st_s r0,[r13,0x18]
L_8d38aa:
	mov_s r14,0x883000
L_8d38b0:
	ld_s r0,[r14,0x48]
L_8d38b2:
	lsr_s r0,r0,0xf
L_8d38b4:
	bmsk_s r0,r0,0x0
L_8d38b6:
	st_s r0,[r13,0x1c]
L_8d38b8:
	ld_s r0,[r14,0x48]
L_8d38ba:
	bmsk_s r0,r0,0xe
L_8d38bc:
	bl.d L_8cb90c
L_8d38c0:
	stw_s r0,[r13,0x20]
L_8d38c2:
	st_s r0,[r13,0x24]
L_8d38c4:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d38c6:
	brhs r0,0x10,L_8d38da
L_8d38ca:
	ldb.x r0,[0x802dcc,r0]
L_8d38d2:
	add r1,pcl,0xa
L_8d38d6:
	add1_s r1,r1,r0
L_8d38d8:
	j_s [r1]
	.global L_8d38da
L_8d38da:
	mov_s r0,blink
L_8d38dc:
	mov_s r2,0x101762c
L_8d38e2:
	mov_s r1,0x142b
L_8d38e8:
	bl.d L_8c82c0
L_8d38ec:
	mov_s r3,0x90
L_8d38ee:
	bl L_8cb8c8
L_8d38f2:
	bl.d L_8cbe4c
L_8d38f6:
	st_s r0,[r13,0x28]
L_8d38f8:
	stb r0,[r13, 0x2c]
L_8d38fc:
	ld_s r0,[r14,0x10]
L_8d38fe:
	mov_s r15,0x84268c
L_8d3904:
	lsr_s r0,r0,0x2
L_8d3906:
	bmsk_s r0,r0,0x0
L_8d3908:
	st_s r0,[r13,0x30]
L_8d390a:
	ld_s r0,[r14,0x4]
L_8d390c:
	lsr_s r0,r0
L_8d390e:
	bmsk_s r0,r0,0x0
L_8d3910:
	bl.d L_8cef4c
L_8d3914:
	st_s r0,[r13,0x34]
L_8d3916:
	bl.d L_8cefb0
L_8d391a:
	st_s r0,[r13,0x38]
L_8d391c:
	st_s r0,[r13,0x3c]
L_8d391e:
	ld_s r0,[r14,0x10]
L_8d3920:
	mov_s r14,0x884000
L_8d3926:
	bmsk_s r0,r0,0x0
L_8d3928:
	st_s r0,[r13,0x40]
L_8d392a:
	ld_s r0,[r14,0x8]
L_8d392c:
	bmsk_s r0,r0,0x0
L_8d392e:
	st_s r0,[r13,0x44]
L_8d3930:
	bl.d L_8d00d8
L_8d3934:
	add3 r0,r13,0x9
L_8d3938:
	ld_s r0,[r14,0x70]
L_8d393a:
	bmsk_s r0,r0,0x1
L_8d393c:
	bl.d L_8ccfa4
L_8d3940:
	stb_s r0,[r15,0xb]
L_8d3942:
	bl.d L_8cd008
L_8d3946:
	st_s r0,[r13,0x4c]
L_8d3948:
	b.d L_8c032c
L_8d394c:
	stb_s r0,[r15,0x10]
	.global L_8d394e
L_8d394e:
	mov_s r0,blink
L_8d3950:
	mov_s r2,0x101762c
L_8d3956:
	mov_s r1,0x12de
L_8d395c:
	bl.d L_8c82c0
L_8d3960:
	mov_s r3,0x7a
L_8d3962:
	b_s L_8d3882
