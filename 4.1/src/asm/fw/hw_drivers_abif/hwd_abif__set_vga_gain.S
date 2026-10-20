/* hwd_abif__set_vga_gain @ 0x8cc278, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_vga_gain_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__set_vga_gain,"ax",@progbits
	.global hwd_abif__set_vga_gain
hwd_abif__set_vga_gain:
	.global L_8cc278
L_8cc278:
	push_s blink
L_8cc27a:
	bl L_8c02bc
L_8cc27e:
	mov_s r15,r0
L_8cc280:
	mov_s r14,r1
L_8cc282:
	mov_s r13,r2
L_8cc284:
	brge.d r1,0x5,L_8cc2cc
L_8cc288:
	mov_s r16,r3
L_8cc28a:
	brlt r14,0x1,L_8cc2cc
	.global L_8cc28e
L_8cc28e:
	brge r13,0x2,L_8cc2e2
	.global L_8cc292
L_8cc292:
	cmp_s r15,0x40
L_8cc294:
	bge L_8cc2fa
	.global L_8cc298
L_8cc298:
	breq r14,0x1,L_8cc2c8
L_8cc29c:
	rsub r0,r14,0x4
L_8cc2a0:
	extb_s r0,r0
L_8cc2a2:
	add2_s r0,r0,r13
L_8cc2a4:
	add r1,r0,0x8004f8
L_8cc2ac:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cc2ae:
	add2_s r13,r13,r15
L_8cc2b0:
	mov_s r0,0x88a208
L_8cc2b6:
	add2_s r0,r0,r13
L_8cc2b8:
	ld_s r2,[r0]
L_8cc2ba:
	ldb_s r1,[r1,0x4]
L_8cc2bc:
	bclr r2,r2,r1
L_8cc2c0:
	asl r3,r16,r1
L_8cc2c4:
	or_s r2,r2,r3
L_8cc2c6:
	st_s r2,[r0]
	.global L_8cc2c8
L_8cc2c8:
	b L_8c0324
	.global L_8cc2cc
L_8cc2cc:
	mov_s r0,blink
L_8cc2ce:
	mov_s r2,0x1019954
L_8cc2d4:
	mov_s r1,0x13
L_8cc2d6:
	asl_s r1,r1,0x8
L_8cc2d8:
	bl.d L_8c82c0
L_8cc2dc:
	mov r3,0x55d
L_8cc2e0:
	b_s L_8cc28e
	.global L_8cc2e2
L_8cc2e2:
	mov_s r0,blink
L_8cc2e4:
	mov_s r2,0x1019954
L_8cc2ea:
	mov_s r1,0x1301
L_8cc2f0:
	bl.d L_8c82c0
L_8cc2f4:
	mov r3,0x55e
L_8cc2f8:
	b_s L_8cc292
	.global L_8cc2fa
L_8cc2fa:
	mov_s r0,blink
L_8cc2fc:
	mov_s r2,0x1019954
L_8cc302:
	mov_s r1,0x1302
L_8cc308:
	bl.d L_8c82c0
L_8cc30c:
	mov r3,0x55f
L_8cc310:
	b_s L_8cc298
L_8cc312:
	nop_s
