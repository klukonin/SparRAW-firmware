/* calib_silent_rssi_sparrow__run_calibration_fragment @ 0x8e3864, 292 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calibrate_single_rf_module_gain() took %d usec; target_rfc_idx=0x%x
 *   calib_silent_rssi_sparrow::run_calibration_fragment(): RF RX gain calibration failed to reach 1dB accuracy. target_rfc_idx=%d of rf_targets_num=%d, rf_targets_vec=0x%x
 *   calib_silent_rssi_sparrow::run_calibration_fragment(): total_frags=%d must be equal to rf_targets_num=%d+1, rf_targets_vec=0x%x
 *   calib_silent_rssi_sparrow::run_calibration_fragment(): Last fragment detected. Running baseband AGC gain calibration
 *   calib_silent_rssi_sparrow::run_calibration_fragment(): Baseband gain calibration failed to reach %ddB accuracy. rf_targets_num=%d, rf_targets_vec=0x%x
 *   calib_silent_rssi_sparrow::run_calibration_fragment(): Bad fragment index. cur_frag=%d, total_frags=%d, rf_targets_vec=0x%x
 * Зовут его: calib_silent_rssi__step, calib_silent_rssi_sparrow__correction_alg
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bitmap__expand_byte4_to_list, calibrate_baseband_gain, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, rf_mask__count_modules, silent_rssi__calibrate_single_rf_module, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_silent_rssi_sparrow__run_calibration_fragment
calib_silent_rssi_sparrow__run_calibration_fragment:
	.global L_8e3864
L_8e3864:
	sub_s sp,sp,0x4
L_8e3866:
	push_s blink
L_8e3868:
	bl L_8c01d4
L_8e386c:
	sub_s sp,sp,0x8
L_8e386e:
	mov_s r17,r1
L_8e3870:
	mov_s r18,r0
L_8e3872:
	mov_s r15,r2
L_8e3874:
	mov_s r14,r3
L_8e3876:
	mov_s r13,r4
L_8e3878:
	bl.d L_8ccb04
L_8e387c:
	mov_s r0,r13
L_8e387e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e3880:
	brne r14,r0,L_8e38f4
	.global L_8e3884
L_8e3884:
	mov_s r1,0x802224
L_8e388a:
	ld_s r0,[r1,0x8]
L_8e388c:
	ld_s r1,[r1,0xc]
L_8e388e:
	st_s r0,[sp,0x0]
L_8e3890:
	st_s r1,[sp,0x4]
L_8e3892:
	mov_s r1,sp
L_8e3894:
	bl.d L_8ccafc
L_8e3898:
	mov_s r0,r13
L_8e389a:
	brhs.d r15,r14,L_8e391e
L_8e389e:
	mov r16,0x2
L_8e38a2:
	sub r0,sp,0x1
L_8e38a6:
	bl.d L_8e9524
L_8e38aa:
	ldb_s r15,[r0,r15]
L_8e38ac:
	mov_s r16,r0
L_8e38ae:
	mov_s r0,r18
L_8e38b0:
	mov_s r1,r17
L_8e38b2:
	mov_s r2,r15
L_8e38b4:
	bl.d L_8c58c4
L_8e38b8:
	mov_s r3,r13
L_8e38ba:
	bl.d L_8e9524
L_8e38be:
	mov_s r14,r0
L_8e38c0:
	sub r0,r0,r16
L_8e38c4:
	asl_s r2,r0,0x4
L_8e38c6:
	mov_s r1,0x10096f8
L_8e38cc:
	mov_s r0,0x26
L_8e38ce:
	bl.d L_8dcc80
L_8e38d2:
	mov_s r3,r15
L_8e38d4:
	breq r14,0x1,L_8e397c
L_8e38d8:
	bl.d L_8ccb04
L_8e38dc:
	mov_s r0,r13
L_8e38de:
	mov_s r3,r0
L_8e38e0:
	mov_s r1,0x100973c
L_8e38e6:
	ldb r4,[r13, 0x4]
L_8e38ea:
	mov_s r0,0x16
L_8e38ec:
	bl.d L_8dcd00
L_8e38f0:
	mov_s r2,r15
L_8e38f2:
	b_s L_8e397c
	.global L_8e38f4
L_8e38f4:
	bl.d L_8ccb04
L_8e38f8:
	mov_s r0,r13
L_8e38fa:
	mov_s r5,r0
L_8e38fc:
	mov_s r1,0x10097e4
L_8e3902:
	ldb r4,[r13, 0x4]
L_8e3906:
	mov_s r0,0x0
L_8e3908:
	mov_s r2,r14
L_8e390a:
	bl.d L_8dcd00
L_8e390e:
	mov_s r3,r5
L_8e3910:
	mov_s r0,blink
L_8e3912:
	mov_s r1,0x1458
L_8e3918:
	bl L_8c9b28
L_8e391c:
	b_s L_8e3884
	.global L_8e391e
L_8e391e:
	brne r15,r14,L_8e395a
L_8e3922:
	mov_s r1,0x1009864
L_8e3928:
	bl.d L_8dcba8
L_8e392c:
	mov_s r0,0x26
L_8e392e:
	mov_s r0,r18
L_8e3930:
	mov_s r1,r17
L_8e3932:
	bl.d L_8c5708
L_8e3936:
	mov_s r2,r13
L_8e3938:
	mov_s r14,r0
L_8e393a:
	breq r0,0x1,L_8e397c
L_8e393e:
	bl.d L_8ccb04
L_8e3942:
	mov_s r0,r13
L_8e3944:
	mov_s r3,r0
L_8e3946:
	mov_s r1,0x10098dc
L_8e394c:
	ldb r4,[r13, 0x4]
L_8e3950:
	mov_s r0,0x16
L_8e3952:
	bl.d L_8dcd00
L_8e3956:
	mov_s r2,0x1
L_8e3958:
	b_s L_8e397c
	.global L_8e395a
L_8e395a:
	mov_s r1,0x1009974
L_8e3960:
	ldb r4,[r13, 0x4]
L_8e3964:
	mov_s r0,0x0
L_8e3966:
	mov_s r2,r15
L_8e3968:
	bl.d L_8dcd00
L_8e396c:
	mov_s r3,r14
L_8e396e:
	mov_s r0,blink
L_8e3970:
	mov_s r1,0x145a
L_8e3976:
	bl.d L_8c9b28
L_8e397a:
	mov_s r14,r16
	.global L_8e397c
L_8e397c:
	mov_s r0,r14
L_8e397e:
	mov_s r12,0x8
L_8e3980:
	b.d L_8c0236
L_8e3984:
	add_s sp,sp,0x8
L_8e3986:
	nop_s
