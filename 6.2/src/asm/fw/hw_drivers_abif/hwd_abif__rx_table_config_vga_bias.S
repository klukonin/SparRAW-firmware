/* hwd_abif__rx_table_config_vga_bias @ 0x8cf2cc, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_abif__rx_table_config_vga_bias_all_rows
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_vga_bias
hwd_abif__rx_table_config_vga_bias:
	.global L_8cf2cc
L_8cf2cc:
	push_s blink
L_8cf2ce:
	bl L_8c01e0
L_8cf2d2:
	mov_s r14,r0
L_8cf2d4:
	cmp_s r0,0x40
L_8cf2d6:
	mov_s r13,r1
L_8cf2d8:
	bge.d L_8cf320
L_8cf2dc:
	mov_s r15,r2
	.global L_8cf2de
L_8cf2de:
	brge r13,0x6,L_8cf32c
L_8cf2e2:
	brlt r13,0x1,L_8cf32c
	.global L_8cf2e6
L_8cf2e6:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cf2e8:
	extb_s r13,r13
L_8cf2ea:
	mov_s r0,0x801af4
L_8cf2f0:
	ld.as r0,[r0,r13]
L_8cf2f4:
	mov_s r1,0x800550
L_8cf2fa:
	add2_s r0,r0,r14
L_8cf2fc:
	sub r1,r1,0x20
L_8cf300:
	add_s r1,r1,r13
L_8cf302:
	ldb r2,[r1, 0x34]
L_8cf306:
	mov_s r1,0x88a208
L_8cf30c:
	add2_s r1,r1,r0
L_8cf30e:
	ld_s r3,[r1]
L_8cf310:
	mov_s r0,0xf
L_8cf312:
	asl_s r0,r0,r2
L_8cf314:
	bic_s r3,r3,r0
L_8cf316:
	asl_s r15,r15,r2
L_8cf318:
	or_s r15,r15,r3
L_8cf31a:
	st_s r15,[r1]
L_8cf31c:
	b L_8c024c
	.global L_8cf320
L_8cf320:
	mov_s r0,blink
L_8cf322:
	mov_s r1,0x97
L_8cf324:
	/* bl.d 0x008c9b28 */
	.byte 0x06,0x08,0x6f,0xfd
L_8cf328:
	/* _asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8cf32a:
	b_s L_8cf2de
	.global L_8cf32c
L_8cf32c:
	mov_s r0,blink
L_8cf32e:
	mov_s r1,0x12e4
L_8cf334:
	bl L_8c9b28
L_8cf338:
	b_s L_8cf2e6
L_8cf33a:
	nop_s
