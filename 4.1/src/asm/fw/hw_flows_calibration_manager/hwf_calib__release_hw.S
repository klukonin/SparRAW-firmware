/* hwf_calib__release_hw @ 0x8d3738, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_flows_calibration_manager.c
 * Зовут его: calib__log_if_nonzero, calib_lo_leakage__vt20, calib_sar__enable_path, calib_silent_rssi__vt20, hwf_calib__restore_path, tail_hwf_calib__release_hw
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, hw_modes__set_loopback, hwd_abif__rgf_88a000_8ccfb0, hwd_abif__rgf_88a200_8cc674, hwd_abif__rgf_88a200_8cca94, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_88ae60_flags, hwd_phy__mode_flags_by_index, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_883000_8cf52c
 */
	.section .text.hwf_calib__release_hw,"ax",@progbits
	.global hwf_calib__release_hw
hwf_calib__release_hw:
	.global L_8d3738
L_8d3738:
	push_s blink
L_8d373a:
	bl L_8c02c4
L_8d373e:
	mov_s r13,0x84264c
L_8d3744:
	ld_s r0,[r13]
L_8d3746:
	brne r0,0x1,L_8d37ac
	.global L_8d374a
L_8d374a:
	mov_s r14,0x0
L_8d374c:
	st_s r14,[r13]
L_8d374e:
	bl.d L_8cf4c8
L_8d3752:
	mov_s r0,r14
L_8d3754:
	bl.d L_8cf4fc
L_8d3758:
	mov_s r0,r14
L_8d375a:
	bl.d L_8cb8d8
L_8d375e:
	mov_s r0,r14
L_8d3760:
	bl.d L_8d4c0c
L_8d3764:
	mov_s r0,r14
L_8d3766:
	bl L_8cfcdc
L_8d376a:
	bl.d L_8cbd8c
L_8d376e:
	ldb r0,[r13, 0x2c]
L_8d3772:
	bl.d L_8ceed4
L_8d3776:
	ld_s r0,[r13,0xc]
L_8d3778:
	bl.d L_8cf958
L_8d377c:
	ld_s r0,[r13,0x4]
L_8d377e:
	bl.d L_8cca94
L_8d3782:
	ld_s r0,[r13,0x8]
L_8d3784:
	ld_s r0,[r13,0x1c]
L_8d3786:
	bl.d L_8cf52c
L_8d378a:
	ldb r1,[r13, 0x20]
L_8d378e:
	bl.d L_8cf588
L_8d3792:
	ld_s r0,[r13,0x18]
L_8d3794:
	ld_s r0,[r13,0x24]
L_8d3796:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d3798:
	brhs r0,0x10,L_8d3808
L_8d379c:
	ldb.x r0,[0x802ddc,r0]
L_8d37a4:
	add r1,pcl,0x8
L_8d37a8:
	add1_s r1,r1,r0
L_8d37aa:
	j_s [r1]
	.global L_8d37ac
L_8d37ac:
	mov_s r0,blink
L_8d37ae:
	mov_s r2,0x101762c
L_8d37b4:
	mov_s r1,0x12df
L_8d37ba:
	bl.d L_8c82c0
L_8d37be:
	mov_s r3,0xaa
L_8d37c0:
	b_s L_8d374a
L_8d37c2:
	mov_s r0,0x1
L_8d37c4:
	bl.d L_8d4c30
L_8d37c8:
	mov_s r1,r0
L_8d37ca:
	ld_s r0,[r13,0x34]
L_8d37cc:
	cmp_s r0,0x0
L_8d37ce:
	bl.ne L_8cfd88
L_8d37d2:
	b_s L_8d381c
L_8d37d4:
	bl.d L_8d4c0c
L_8d37d8:
	mov_s r0,0x1
L_8d37da:
	ld_s r0,[r13,0x30]
L_8d37dc:
	breq_s r0,0,L_8d381c
L_8d37de:
	b_s L_8d3802
L_8d37e0:
	ld_s r0,[r13,0x28]
L_8d37e2:
	mov_s r1,r14
L_8d37e4:
	cmp_s r0,0x0
L_8d37e6:
	mov_s r0,0x1
L_8d37e8:
	mov_s r2,r14
L_8d37ea:
	beq_s L_8d37f2
L_8d37ec:
	bl L_8d4aa8
L_8d37f0:
	b_s L_8d37f6
	.global L_8d37f2
L_8d37f2:
	bl L_8d4bd4
	.global L_8d37f6
L_8d37f6:
	ld_s r0,[r13,0x30]
L_8d37f8:
	cmp_s r0,0x0
L_8d37fa:
	bl.ne L_8cfd88
L_8d37fe:
	ld_s r0,[r13,0x34]
L_8d3800:
	breq_s r0,0,L_8d381c
	.global L_8d3802
L_8d3802:
	bl L_8cfd48
L_8d3806:
	b_s L_8d381c
	.global L_8d3808
L_8d3808:
	mov_s r0,blink
L_8d380a:
	mov_s r2,0x101762c
L_8d3810:
	mov_s r1,0x115c
L_8d3816:
	bl.d L_8c82c0
L_8d381a:
	mov_s r3,0xe1
	.global L_8d381c
L_8d381c:
	bl.d L_8cf4fc
L_8d3820:
	ld_s r0,[r13,0x44]
L_8d3822:
	bl.d L_8cf4c8
L_8d3826:
	ld_s r0,[r13,0x40]
L_8d3828:
	mov_s r0,0x0
L_8d382a:
	bl.d L_8cc674
L_8d382e:
	ldb_s r1,[r13,0x14]
L_8d3830:
	ld_s r0,[r13,0x10]
L_8d3832:
	bl.d L_8cc674
L_8d3836:
	ldb_s r1,[r13,0x14]
L_8d3838:
	mov_s r14,0x84268c
L_8d383e:
	mov_s r0,0x0
L_8d3840:
	bl.d L_8ccfb0
L_8d3844:
	ldb_s r1,[r14,0x10]
L_8d3846:
	ld_s r0,[r13,0x4c]
L_8d3848:
	bl.d L_8ccfb0
L_8d384c:
	ldb_s r1,[r14,0x10]
L_8d384e:
	bl.d L_8cfe5c
L_8d3852:
	ld_s r0,[r13,0x3c]
L_8d3854:
	bl.d L_8cfdc0
L_8d3858:
	ld_s r0,[r13,0x38]
L_8d385a:
	ldb_s r0,[r14,0x8]
L_8d385c:
	ldb_s r1,[r14,0x9]
L_8d385e:
	bl.d L_8d006c
L_8d3862:
	ldb_s r2,[r14,0xa]
L_8d3864:
	bl.d L_8d037c
L_8d3868:
	ldb_s r0,[r14,0xb]
L_8d386a:
	b L_8c0334
L_8d386e:
	nop_s
