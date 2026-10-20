/* calib_engine__schedule_all_schemes @ 0x8e4334, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__start_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib_mngr__schedule_scheme_step
 */
	.section .text.calib_engine__schedule_all_schemes,"ax",@progbits
	.global calib_engine__schedule_all_schemes
calib_engine__schedule_all_schemes:
	.global L_8e4334
L_8e4334:
	push_s blink
L_8e4336:
	bl L_8c02c0
L_8e433a:
	mov_s r15,r0
L_8e433c:
	mov_s r14,0x0
L_8e433e:
	mov_s r13,0x6
	.global L_8e4340
L_8e4340:
	asl_s r0,r14,0x2
L_8e4342:
	add1_s r0,r0,r0
L_8e4344:
	add_s r1,r15,0x4
L_8e4346:
	add_s r1,r1,r0
L_8e4348:
	mov_s r0,r14
L_8e434a:
	bl.d L_8dfcd4
L_8e434e:
	mov_s r2,0x1
L_8e4350:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e4352:
	/* brhs.d r13,0x1,0x008e4340 */
	.byte 0xf1,0x0d,0x75,0x90
L_8e4356:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e4358:
	b L_8c032c
