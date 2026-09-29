/* hwf_calib_sar_alg @ 0x8d31ac, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_CALIB_SAR_ALG reached CALIB_SAR_MAX_ITER(%d)
 *   hwf_calib_sar_alg() SAR_DC_FINE:: PostCal DC ==> NON CONVERGED
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_sar__vt1c, hwf_calib_all, power_mngr_on_unassoc_start
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, calib_sar_step, calib_sar_step2, fw_log__emit0, fw_log__emit1, hwd_phy__rgf_885000_8cfc0c, phy__wait_sar_done
 */
	.section .text.hwf_calib_sar_alg,"ax",@progbits
	.global hwf_calib_sar_alg
hwf_calib_sar_alg:
	.global L_8d31ac
L_8d31ac:
	push_s blink
L_8d31ae:
	bl L_8c02b4
L_8d31b2:
	mov_s r16,r0
L_8d31b4:
	mov_s r18,r1
L_8d31b6:
	mov_s r17,r2
L_8d31b8:
	mov_s r15,0x0
L_8d31ba:
	mov_s r13,0x1
L_8d31bc:
	mov_s r14,r15
L_8d31be:
	b_s L_8d31de
	.global L_8d31c0
L_8d31c0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d31c2:
	bl.d L_8cfc0c
L_8d31c6:
	extb_s r14,r14
L_8d31c8:
	bl L_8cfbc8
L_8d31cc:
	mov_s r0,r17
L_8d31ce:
	mov_s r1,r13
L_8d31d0:
	mov_s r2,0x1
L_8d31d2:
	bl.d L_8d327c
L_8d31d6:
	mov_s r3,r18
L_8d31d8:
	mov_s r15,r0
L_8d31da:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d31dc:
	sexb_s r13,r13
	.global L_8d31de
L_8d31de:
	brne_s r15,0,L_8d31e4
L_8d31e0:
	brlt r14,0x5,L_8d31c0
	.global L_8d31e4
L_8d31e4:
	brne r14,0x5,L_8d31f8
L_8d31e8:
	mov_s r2,0x1017b44
L_8d31ee:
	mov_s r0,0x6
L_8d31f0:
	mov_s r1,0x1
L_8d31f2:
	bl.d L_8edfcc
L_8d31f6:
	mov_s r3,r14
	.global L_8d31f8
L_8d31f8:
	cmp r16,0x0
L_8d31fc:
	bl.eq.d L_8d1734
L_8d3200:
	mov.eq r0,0xd
L_8d3204:
	mov_s r0,0x0
L_8d3206:
	brne_s r15,0,L_8d321c
L_8d3208:
	mov_s r13,0x2
L_8d320a:
	mov_s r2,0x1017b78
L_8d3210:
	mov_s r0,0x6
L_8d3212:
	bl.d L_8edfb0
L_8d3216:
	mov_s r1,0x1
L_8d3218:
	mov_s r0,r13
L_8d321a:
	b_s L_8d3222
	.global L_8d321c
L_8d321c:
	cmp_s r14,0x1
L_8d321e:
	mov.gt r0,0x1
	.global L_8d3222
L_8d3222:
	b L_8c0314
L_8d3226:
	nop_s
