/* calib_silent_rssi__flag_step @ 0x8d33c4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg
 * Зовёт сам: __ld_r13_to_r13_ret, hwd__program_rf_regs_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_silent_rssi__flag_step
calib_silent_rssi__flag_step:
	.global L_8d33c4
L_8d33c4:
	push_s blink
L_8d33c6:
	push_s r13
L_8d33c8:
	mov_s r13,0x0
L_8d33ca:
	st.a r13,[sp,-0x8]
L_8d33ce:
	cmp_s r3,0x0
L_8d33d0:
	mov_s r3,0x1
L_8d33d2:
	sub_s.ne r3,r3,r3
L_8d33d4:
	/* asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_8d33d6:
	st_s r3,[sp,0x4]
L_8d33d8:
	mov_s r3,r13
L_8d33da:
	mov_s r4,r13
L_8d33dc:
	mov_s r5,r13
L_8d33de:
	mov_s r6,r13
L_8d33e0:
	bl.d L_8d4338
L_8d33e4:
	mov_s r7,r13
L_8d33e6:
	b.d L_8c025c
L_8d33ea:
	add_s sp,sp,0x8
