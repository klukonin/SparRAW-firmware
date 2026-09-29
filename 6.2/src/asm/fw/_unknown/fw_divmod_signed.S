/* fw_divmod_signed @ 0x8c02dc, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters, ba_sm__lookup_stream, basic_calib__check_g8000a4, fw_divmod_unsigned, handle_omni_sector_info, hwd_phy__rx_cal_corr_config, hwd_phy__tx_singen_config, link_lost_diag_part2, lmac_if__evt_first_field, marlon_r_if_class__init_board_file_interface
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_divmod_signed
fw_divmod_signed:
	.global L_8c02dc
L_8c02dc:
	lsr.f r8,r1,0x1f
L_8c02e0:
	rsub.ne r1,r1,0x0
L_8c02e4:
	asr.f r3,r0,0x1f
L_8c02e8:
	rsub.ne r0,r0,0x0
L_8c02ec:
	xor r8,r8,r3
	.global L_8c02f0
L_8c02f0:
	mov.f r2,r1
L_8c02f4:
	beq.d L_8c0344
L_8c02f8:
	mov_s r1,r0
L_8c02fa:
	mov_s r0,0x0
L_8c02fc:
	sub_s r3,r0,0x1
L_8c02fe:
	norm.f r5,r1
L_8c0302:
	mov.mi r5,r3
L_8c0306:
	norm.f r6,r2
L_8c030a:
	mov.mi r6,r3
L_8c030e:
	sub.f r3,r6,r5
L_8c0312:
	mov.mi r3,0x0
L_8c0316:
	add lp_count,r3,0x1
L_8c031a:
	asl.pl r2,r2,r3
L_8c031e:
	lp L_8c0332
L_8c0322:
	sub.f r1,r1,r2
L_8c0326:
	bset.cc r0,r0,lp_count
L_8c032a:
	add.cs r1,r1,r2
L_8c032e:
	lsr r2,r2
	.global L_8c0332
L_8c0332:
	lsr.f r8,r8
L_8c0336:
	ror r0,r0
L_8c033a:
	rsub.cs r0,r0,0x0
L_8c033e:
	j_s.d [blink]
L_8c0340:
	rsub.ne r1,r1,0x0
	.global L_8c0344
L_8c0344:
	/* j 0x0000064c */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x4c,0x06
