/* hwd_phy__rx_cal_corr @ 0x8d23a0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, ber_test__measure, calib_battery__prepare, calib_lo_leakage_step, hwf_dc_calib_fix_dac1, hwf_vga_dc__measure
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_sysassert_fatal, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_cal_corr
hwd_phy__rx_cal_corr:
	.global L_8d23a0
L_8d23a0:
	push_s blink
L_8d23a2:
	bl L_8c01e0
L_8d23a6:
	mov.f r14,r0
L_8d23aa:
	beq_s L_8d240c
	.global L_8d23ac
L_8d23ac:
	mov_s r0,r14
L_8d23ae:
	bl.d L_8c1cd8
L_8d23b2:
	mov_s r1,0x8
L_8d23b4:
	mov_s r15,0x883000
L_8d23ba:
	ld_s r0,[r15,0x10]
L_8d23bc:
	mov_s r13,0x883680
L_8d23c2:
	bset_s r0,r0,0x3
L_8d23c4:
	st_s r0,[r15,0x10]
L_8d23c6:
	mov lp_count,0x30d40
L_8d23ce:
	nop_s
L_8d23d0:
	lp L_8d23dc
L_8d23d4:
	ld_s r0,[r13,0x6c]
L_8d23d6:
	btst_s r0,0x0
L_8d23d8:
	bne_s L_8d23dc
L_8d23da:
	nop_s
	.global L_8d23dc
L_8d23dc:
	ld_s r0,[r13,0x6c]
L_8d23de:
	bbit1 r0,0x0,L_8d23fa
L_8d23e2:
	mov_s r1,0x101d828
L_8d23e8:
	bl.d L_8dcba8
L_8d23ec:
	mov_s r0,0x0
L_8d23ee:
	mov_s r0,blink
L_8d23f0:
	mov_s r1,0x1559
L_8d23f6:
	bl L_8c9b28
	.global L_8d23fa
L_8d23fa:
	ld_s r0,[r13,0x64]
L_8d23fc:
	st_s r0,[r14]
L_8d23fe:
	ld_s r0,[r13,0x68]
L_8d2400:
	st_s r0,[r14,0x4]
L_8d2402:
	ld_s r0,[r15,0x10]
L_8d2404:
	bclr_s r0,r0,0x3
L_8d2406:
	st_s r0,[r15,0x10]
L_8d2408:
	b L_8c024c
	.global L_8d240c
L_8d240c:
	mov_s r0,blink
L_8d240e:
	mov_s r1,0xe0
L_8d2410:
	bl.d L_8c9b28
L_8d2414:
	bset_s r1,r1,0xc
L_8d2416:
	b_s L_8d23ac
