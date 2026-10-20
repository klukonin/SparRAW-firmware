/* POWER_MNGR__system_state_evt_handler @ 0x8e3714, 308 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   POWER_MNGR::system_state_evt_handler() enter_cnt=%d, enter_l1ss_cnt=%d, no_l1_exit_int_cnt=%d
 *   POWER_MNGR::system_state_evt_handler SYS_STATE_EVT_PAUSE_PSM
 *   POWER_MNGR::system_state_evt_handler SYS_STATE_EVT_RESUME_PSM
 *   power_management.cpp
 * Зовут его: L2MGR__system_state_evt_handler, power_mgr_ut, ps_cfg__apply_profile, ps_cfg__load_profile
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit0, fw_log__emit3, fw_sysassert_fatal, power_mngr__recalc_aw, set_g_80035c, set_g_80035c_8e1934, set_g_80040c_x2, set_g_80040c_x2_8c80bc, stats_timer_exp
 */
	.section .text.POWER_MNGR__system_state_evt_handler,"ax",@progbits
	.global POWER_MNGR__system_state_evt_handler
POWER_MNGR__system_state_evt_handler:
	.global L_8e3714
L_8e3714:
	push_s blink
L_8e3716:
	bl L_8c02b0
L_8e371a:
	mov_s r14,r0
L_8e371c:
	mov_s r17,r1
L_8e371e:
	mov_s r16,r2
L_8e3720:
	mov_s r19,r3
L_8e3722:
	mov_s r13,0x0
L_8e3724:
	mov_s r3,0x803590
L_8e372a:
	ld r4,[r3, 0x28]
L_8e372e:
	mov_s r2,0x1002114
L_8e3734:
	ld r5,[r3, 0x34]
L_8e3738:
	mov_s r0,0xe
L_8e373a:
	mov_s r1,0x2
L_8e373c:
	bl.d L_8ee034
L_8e3740:
	ld_s r3,[r3,0x24]
L_8e3742:
	mov r18,0x80353c
L_8e374a:
	brhs.d r14,0x19,L_8e37e6
L_8e374e:
	ld.as r15,[gp,-0x16]
L_8e3752:
	ldb.x r10,[0x801898,r14]
L_8e375a:
	add r0,pcl,0xc
L_8e375e:
	add1 r0,r0,r10
L_8e3762:
	j_s [r0]
	.global L_8e3764
L_8e3764:
	mov_s r1,r13
L_8e3766:
	b_s L_8e37fc
L_8e3768:
	cmp r17,0x0
L_8e376c:
	mov_s r14,0x8
L_8e376e:
	bl.ne.d L_8dc190
L_8e3772:
	mov.ne r0,0x1
L_8e3776:
	cmp r17,0x1
L_8e377a:
	cmp.eq r16,0x0
L_8e377e:
	bne_s L_8e37f8
L_8e3780:
	bl.d L_8e1934
L_8e3784:
	add r15,r18,0x3c
L_8e3788:
	b_s L_8e37f8
	.global L_8e378a
L_8e378a:
	mov_s r1,0x1
L_8e378c:
	b_s L_8e37fc
L_8e378e:
	bl.d L_8e1928
L_8e3792:
	mov_s r15,r18
L_8e3794:
	b_s L_8e3764
L_8e3796:
	bl.d L_8c7984
L_8e379a:
	mov_s r14,0x17
L_8e379c:
	bl.d L_8c7460
L_8e37a0:
	mov_s r0,r13
L_8e37a2:
	b_s L_8e378a
L_8e37a4:
	bl.d L_8c80bc
L_8e37a8:
	mov_s r14,0x18
L_8e37aa:
	b_s L_8e3764
L_8e37ac:
	mov_s r2,0x1002174
L_8e37b2:
	mov_s r0,r13
L_8e37b4:
	bl.d L_8edfb0
L_8e37b8:
	mov_s r1,0x1
L_8e37ba:
	ld_s r0,[gp,-0x44]
L_8e37bc:
	st_s r13,[r0]
L_8e37be:
	bl.d L_8c7460
L_8e37c2:
	mov_s r0,r13
L_8e37c4:
	mov_s r14,0x11
L_8e37c6:
	b_s L_8e3764
L_8e37c8:
	mov_s r14,0x12
L_8e37ca:
	mov_s r2,0x10021b4
L_8e37d0:
	mov_s r0,r13
L_8e37d2:
	bl.d L_8edfb0
L_8e37d6:
	mov_s r1,0x2
L_8e37d8:
	mov_s r1,0x1
L_8e37da:
	ld_s r0,[gp,-0x44]
L_8e37dc:
	st_s r1,[r0]
L_8e37de:
	b_s L_8e3764
L_8e37e0:
	mov_s r1,r13
L_8e37e2:
	mov_s r13,0x1
L_8e37e4:
	b_s L_8e37fc
	.global L_8e37e6
L_8e37e6:
	mov_s r0,blink
L_8e37e8:
	mov_s r2,0x10021f4
L_8e37ee:
	mov_s r1,0x21
L_8e37f0:
	asl_s r1,r1,0x8
L_8e37f2:
	bl.d L_8c82c0
L_8e37f6:
	mov_s r3,0xf2
	.global L_8e37f8
L_8e37f8:
	mov_s r1,0x0
L_8e37fa:
	mov_s r13,r1
	.global L_8e37fc
L_8e37fc:
	brne_s r13,0,L_8e3818
L_8e37fe:
	ld_s r0,[gp,-0x44]
L_8e3800:
	ld_s r0,[r0]
L_8e3802:
	breq_s r0,0,L_8e3806
L_8e3804:
	breq_s r1,0,L_8e380c
	.global L_8e3806
L_8e3806:
	ld_s r0,[r15,0x8]
L_8e3808:
	ld_s r1,[r0,0x10]
L_8e380a:
	b_s L_8e3810
	.global L_8e380c
L_8e380c:
	ld_s r0,[r15,0x8]
L_8e380e:
	ld_s r1,[r0,0xc]
	.global L_8e3810
L_8e3810:
	jl_s.d [r1]
L_8e3812:
	mov_s r0,r15
L_8e3814:
	st.as r15,[gp,-0x16]
	.global L_8e3818
L_8e3818:
	/* sub_s r14,r14,0x6 */
	.byte 0x66,0xbe
L_8e381a:
	brhs r14,0x13,L_8e3844
L_8e381e:
	ldb.x r14,[0x8018b4,r14]
L_8e3826:
	add r0,pcl,0xa
L_8e382a:
	add1_s r0,r0,r14
L_8e382c:
	j_s [r0]
L_8e382e:
	ld_s r0,[gp,-0x58]
L_8e3830:
	ld_s r1,[r0,0x8]
L_8e3832:
	ld_s r3,[r1,0x8]
L_8e3834:
	mov_s r1,0x1
	.global L_8e3836
L_8e3836:
	jl_s.d [r3]
L_8e3838:
	mov_s r2,r19
L_8e383a:
	b_s L_8e3844
	.global L_8e383c
L_8e383c:
	cmp r16,0x0
L_8e3840:
	bl.ne L_8dd500
	.global L_8e3844
L_8e3844:
	b L_8c030c
