/* calib_silent_rssi__step @ 0x8e3988, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, calib_silent_rssi_sparrow__run_calibration_fragment, rf_mask__count_modules
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_silent_rssi__step
calib_silent_rssi__step:
	.global L_8e3988
L_8e3988:
	sub_s sp,sp,0x4
L_8e398a:
	push_s blink
L_8e398c:
	bl L_8c01d0
L_8e3990:
	mov_s r18,r1
L_8e3992:
	mov_s r19,r0
L_8e3994:
	mov_s r17,r2
L_8e3996:
	bl.d L_8ccb04
L_8e399a:
	mov_s r0,r2
L_8e399c:
	add r16,r0,0x1
L_8e39a0:
	extb r16,r16
L_8e39a4:
	brlt.d r16,0x1,L_8e39d4
L_8e39a8:
	mov_s r15,0x1
L_8e39aa:
	sub r13,r16,0x1
L_8e39ae:
	extb_s r13,r13
L_8e39b0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e39b2:
	mov_s r14,r15
	.global L_8e39b4
L_8e39b4:
	mov_s r0,r19
L_8e39b6:
	mov_s r1,r18
L_8e39b8:
	mov_s r2,r14
L_8e39ba:
	mov_s r3,r16
L_8e39bc:
	bl.d L_8e3864
L_8e39c0:
	mov r4,r17
L_8e39c4:
	cmp_s r0,0x1
L_8e39c6:
	mov.ne r15,r0
L_8e39ca:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e39cc:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e39ce:
	brhs.d r13,0x1,L_8e39b4
L_8e39d2:
	extb_s r14,r14
	.global L_8e39d4
L_8e39d4:
	mov_s r0,r15
L_8e39d6:
	mov_s r12,0x8
L_8e39d8:
	b L_8c022e
