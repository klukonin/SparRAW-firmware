/* hwd_abif__dvs_rfca_cmd_enable @ 0x8ce910, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters, UT_HW_DRIVERS_cmd_handler, calib_silent_rssi_sparrow__correction_alg, calibrate_baseband_gain, handle_omni_sector_info, hw_sysapi_rfc_fetch_rgf_util, hwd__args_to_regs, hwd_rfc_powerdown_deep_all_rfs_fw, hwd_rfc_powerup_deep_all_rfs_fw, hwd_rfc_read_calibrate
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__dvs_rfca_cmd_enable
hwd_abif__dvs_rfca_cmd_enable:
	.global L_8ce910
L_8ce910:
	push_s blink
L_8ce912:
	bl L_8c01dc
L_8ce916:
	mov_s r15,r0
L_8ce918:
	mov_s r16,r1
L_8ce91a:
	mov lp_count,0x30d40
L_8ce922:
	mov_s r14,0x889080
L_8ce928:
	lp L_8ce934
L_8ce92c:
	ld_s r0,[r14,0x4c]
L_8ce92e:
	btst_s r0,0x1d
L_8ce930:
	beq_s L_8ce934
L_8ce932:
	nop_s
	.global L_8ce934
L_8ce934:
	ld_s r0,[r14,0x4c]
L_8ce936:
	bbit0 r0,0x1d,L_8ce952
L_8ce93a:
	mov_s r1,0x101eee4
L_8ce940:
	bl.d L_8dcba8
L_8ce944:
	mov_s r0,0x0
L_8ce946:
	mov_s r0,blink
L_8ce948:
	mov_s r1,0x13fa
L_8ce94e:
	bl L_8c9b28
	.global L_8ce952
L_8ce952:
	mov_s r13,0x889480
L_8ce958:
	ld_s r0,[r13,0x8]
L_8ce95a:
	lsr_s r0,r0,0x8
L_8ce95c:
	extb_s r2,r0
L_8ce95e:
	breq r16,0x0,L_8ce966
L_8ce962:
	stb r0,[r16]
	.global L_8ce966
L_8ce966:
	breq r15,r2,L_8ce9b6
L_8ce96a:
	mov lp_count,0x30d40
L_8ce972:
	nop_s
L_8ce974:
	lp L_8ce980
L_8ce978:
	ld_s r0,[r14,0x4c]
L_8ce97a:
	btst_s r0,0x1d
L_8ce97c:
	beq_s L_8ce980
L_8ce97e:
	nop_s
	.global L_8ce980
L_8ce980:
	ld_s r0,[r14,0x4c]
L_8ce982:
	bbit0 r0,0x1d,L_8ce99e
L_8ce986:
	mov_s r1,0x101eee4
L_8ce98c:
	bl.d L_8dcba8
L_8ce990:
	mov_s r0,0x0
L_8ce992:
	mov_s r0,blink
L_8ce994:
	mov_s r1,0x136e
L_8ce99a:
	bl L_8c9b28
	.global L_8ce99e
L_8ce99e:
	mov_s r12,r15
L_8ce9a0:
	bic.f r12,r12,0xff
L_8ce9a4:
	bne_s L_8ce9ba
	.global L_8ce9a6
L_8ce9a6:
	ld_s r0,[r13,0x8]
L_8ce9a8:
	asl_s r15,r15,0x8
L_8ce9aa:
	and r0,r0,0xffff00ff
L_8ce9b2:
	or_s r15,r15,r0
L_8ce9b4:
	st_s r15,[r13,0x8]
	.global L_8ce9b6
L_8ce9b6:
	b L_8c0244
	.global L_8ce9ba
L_8ce9ba:
	mov_s r0,blink
L_8ce9bc:
	bl.d L_8c9b28
L_8ce9c0:
	mov_s r1,0xac
L_8ce9c2:
	b_s L_8ce9a6
