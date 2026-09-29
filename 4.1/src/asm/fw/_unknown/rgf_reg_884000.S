/* rgf_reg_884000 @ 0x8d0318, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_power_step, calib_mngr_step_b
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_divmod_signed
 */
	.section .text.rgf_reg_884000,"ax",@progbits
	.global rgf_reg_884000
rgf_reg_884000:
	.global L_8d0318
L_8d0318:
	push_s blink
L_8d031a:
	bl L_8c02bc
L_8d031e:
	mov_s r14,r1
L_8d0320:
	mov_s r16,r2
L_8d0322:
	asl r1,r0,0x10
L_8d0326:
	brlt.d r0,0x1,L_8d0332
L_8d032a:
	mov r13,0x528
L_8d032e:
	add_s r0,r1,r13
L_8d0330:
	b_s L_8d0336
	.global L_8d0332
L_8d0332:
	sub r0,r1,r13
	.global L_8d0336
L_8d0336:
	mov_s r1,0xa5
L_8d0338:
	/* bl.d 0x008c03bc */
	.byte 0x86,0x08,0x2f,0xf8
L_8d033c:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8d033e:
	mov_s r15,r0
L_8d0340:
	asl r0,r14,0x10
L_8d0344:
	cmp_s r14,0x0
L_8d0346:
	add.gt r0,r0,r13
L_8d034a:
	sub.le r0,r0,r13
L_8d034e:
	mov_s r1,0xa5
L_8d0350:
	/* bl.d 0x008c03bc */
	.byte 0x6e,0x08,0x2f,0xf8
L_8d0354:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8d0356:
	mov_s r2,0x884000
L_8d035c:
	st r16,[r2, 0x68]
L_8d0360:
	extw_s r1,r0
L_8d0362:
	ld_s r0,[r2,0x6c]
L_8d0364:
	asl_s r1,r1,0x10
L_8d0366:
	and r0,r0,0xffff0000
L_8d036e:
	or_s r0,r0,r15
L_8d0370:
	extw_s r0,r0
L_8d0372:
	or_s r0,r0,r1
L_8d0374:
	st_s r0,[r2,0x6c]
L_8d0376:
	b L_8c0324
L_8d037a:
	nop_s
