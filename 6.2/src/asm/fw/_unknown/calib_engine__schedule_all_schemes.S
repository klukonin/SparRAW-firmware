/* calib_engine__schedule_all_schemes @ 0x8e91d4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__run_requested
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib_mngr__schedule_scheme_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__schedule_all_schemes
calib_engine__schedule_all_schemes:
	.global L_8e91d4
L_8e91d4:
	push_s blink
L_8e91d6:
	bl L_8c01e0
L_8e91da:
	mov_s r15,r0
L_8e91dc:
	mov_s r14,0x0
L_8e91de:
	mov_s r13,0x6
	.global L_8e91e0
L_8e91e0:
	asl_s r0,r14,0x2
L_8e91e2:
	add1_s r0,r0,r0
L_8e91e4:
	add_s r1,r15,0x4
L_8e91e6:
	add_s r1,r1,r0
L_8e91e8:
	mov_s r0,r14
L_8e91ea:
	bl.d L_8e498c
L_8e91ee:
	mov_s r2,0x1
L_8e91f0:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e91f2:
	/* brhs.d r13,0x1,0x008e91e0 */
	.byte 0xf1,0x0d,0x75,0x90
L_8e91f6:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e91f8:
	b L_8c024c
