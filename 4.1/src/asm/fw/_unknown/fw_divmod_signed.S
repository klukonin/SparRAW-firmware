/* fw_divmod_signed @ 0x8c03bc, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters, calib_base__vt2c, fw_div_unsigned, fw_scheduled_dti__update_ie, hwd_phy__rgf_883000_8cf74c, parse_ese, rgf_reg_884000
 */
	.section .text.fw_divmod_signed,"ax",@progbits
	.global fw_divmod_signed
fw_divmod_signed:
	.global L_8c03bc
L_8c03bc:
	lsr.f r8,r1,0x1f
L_8c03c0:
	rsub.ne r1,r1,0x0
L_8c03c4:
	asr.f r3,r0,0x1f
L_8c03c8:
	rsub.ne r0,r0,0x0
L_8c03cc:
	xor r8,r8,r3
	.global L_8c03d0
L_8c03d0:
	mov.f r2,r1
L_8c03d4:
	beq.d L_8c0424
L_8c03d8:
	mov_s r1,r0
L_8c03da:
	mov_s r0,0x0
L_8c03dc:
	sub_s r3,r0,0x1
L_8c03de:
	norm.f r5,r1
L_8c03e2:
	mov.mi r5,r3
L_8c03e6:
	norm.f r6,r2
L_8c03ea:
	mov.mi r6,r3
L_8c03ee:
	sub.f r3,r6,r5
L_8c03f2:
	mov.mi r3,0x0
L_8c03f6:
	add lp_count,r3,0x1
L_8c03fa:
	asl.pl r2,r2,r3
L_8c03fe:
	lp L_8c0412
L_8c0402:
	sub.f r1,r1,r2
L_8c0406:
	bset.cc r0,r0,lp_count
L_8c040a:
	add.cs r1,r1,r2
L_8c040e:
	lsr r2,r2
	.global L_8c0412
L_8c0412:
	lsr.f r8,r8
L_8c0416:
	ror r0,r0
L_8c041a:
	rsub.cs r0,r0,0x0
L_8c041e:
	j_s.d [blink]
L_8c0420:
	rsub.ne r1,r1,0x0
	.global L_8c0424
L_8c0424:
	/* j 0x0000072c */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x2c,0x07
