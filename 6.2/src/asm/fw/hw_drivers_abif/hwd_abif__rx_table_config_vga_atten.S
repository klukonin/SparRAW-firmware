/* hwd_abif__rx_table_config_vga_atten @ 0x8cf250, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_vga_gain_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_vga_atten
hwd_abif__rx_table_config_vga_atten:
	.global L_8cf250
L_8cf250:
	push_s blink
L_8cf252:
	bl L_8c01dc
L_8cf256:
	mov_s r15,r0
L_8cf258:
	mov_s r14,r1
L_8cf25a:
	mov_s r13,r2
L_8cf25c:
	brge.d r1,0x5,L_8cf2a4
L_8cf260:
	mov_s r16,r3
L_8cf262:
	brlt r14,0x1,L_8cf2a4
	.global L_8cf266
L_8cf266:
	brge r13,0x2,L_8cf2b0
	.global L_8cf26a
L_8cf26a:
	cmp_s r15,0x40
L_8cf26c:
	bge L_8cf2be
	.global L_8cf270
L_8cf270:
	breq r14,0x1,L_8cf2a0
L_8cf274:
	rsub r0,r14,0x4
L_8cf278:
	extb_s r0,r0
L_8cf27a:
	add2_s r0,r0,r13
L_8cf27c:
	add r1,r0,0x800530
L_8cf284:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cf286:
	add2_s r13,r13,r15
L_8cf288:
	mov_s r0,0x88a208
L_8cf28e:
	add2_s r0,r0,r13
L_8cf290:
	ld_s r2,[r0]
L_8cf292:
	ldb_s r1,[r1,0x4]
L_8cf294:
	bclr r2,r2,r1
L_8cf298:
	asl r3,r16,r1
L_8cf29c:
	or_s r2,r2,r3
L_8cf29e:
	st_s r2,[r0]
	.global L_8cf2a0
L_8cf2a0:
	b L_8c0244
	.global L_8cf2a4
L_8cf2a4:
	mov_s r0,blink
L_8cf2a6:
	mov_s r1,0x13
L_8cf2a8:
	bl.d L_8c9b28
L_8cf2ac:
	asl_s r1,r1,0x8
L_8cf2ae:
	b_s L_8cf266
	.global L_8cf2b0
L_8cf2b0:
	mov_s r0,blink
L_8cf2b2:
	mov_s r1,0x1301
L_8cf2b8:
	bl L_8c9b28
L_8cf2bc:
	b_s L_8cf26a
	.global L_8cf2be
L_8cf2be:
	mov_s r0,blink
L_8cf2c0:
	mov_s r1,0x1302
L_8cf2c6:
	bl L_8c9b28
L_8cf2ca:
	b_s L_8cf270
