/* hwf_calib_sar_alg @ 0x8d60bc, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_CALIB_SAR_ALG reached CALIB_SAR_MAX_ITER(%d)
 *   hwf_calib_sar_alg() SAR_DC_FINE:: PostCal DC ==> NON CONVERGED
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, calib_sar_step, calib_sar_step2, fw_log_emit0, fw_log_emit1, hwd_phy__rx_sar_measurement_completed, hwd_phy__rx_sar_measurement_start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_calib_sar_alg
hwf_calib_sar_alg:
	.global L_8d60bc
L_8d60bc:
	push_s blink
L_8d60be:
	bl L_8c01d4
L_8d60c2:
	mov_s r16,r0
L_8d60c4:
	mov_s r18,r1
L_8d60c6:
	mov_s r17,r2
L_8d60c8:
	mov_s r15,0x0
L_8d60ca:
	mov_s r13,0x1
L_8d60cc:
	mov_s r14,r15
L_8d60ce:
	b_s L_8d60ee
	.global L_8d60d0
L_8d60d0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d60d2:
	bl.d L_8d2958
L_8d60d6:
	extb_s r14,r14
L_8d60d8:
	bl L_8d2920
L_8d60dc:
	mov_s r0,r17
L_8d60de:
	mov_s r1,r13
L_8d60e0:
	mov_s r2,0x1
L_8d60e2:
	bl.d L_8d6134
L_8d60e6:
	mov_s r3,r18
L_8d60e8:
	mov_s r15,r0
L_8d60ea:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d60ec:
	sexb_s r13,r13
	.global L_8d60ee
L_8d60ee:
	brne_s r15,0,L_8d60f4
L_8d60f0:
	brlt r14,0x5,L_8d60d0
	.global L_8d60f4
L_8d60f4:
	brne r14,0x5,L_8d6106
L_8d60f8:
	mov_s r1,0x101c968
L_8d60fe:
	mov_s r0,0x16
L_8d6100:
	bl.d L_8dcc10
L_8d6104:
	mov_s r2,r14
	.global L_8d6106
L_8d6106:
	cmp r16,0x0
L_8d610a:
	bl.eq.d L_8d47e4
L_8d610e:
	mov.eq r0,0xd
L_8d6112:
	mov_s r0,0x0
L_8d6114:
	brne_s r15,0,L_8d6128
L_8d6116:
	mov_s r13,0x2
L_8d6118:
	mov_s r1,0x101c99c
L_8d611e:
	bl.d L_8dcba8
L_8d6122:
	mov_s r0,0x16
L_8d6124:
	mov_s r0,r13
L_8d6126:
	b_s L_8d612e
	.global L_8d6128
L_8d6128:
	cmp_s r14,0x1
L_8d612a:
	mov.gt r0,0x1
	.global L_8d612e
L_8d612e:
	b L_8c0234
L_8d6132:
	nop_s
