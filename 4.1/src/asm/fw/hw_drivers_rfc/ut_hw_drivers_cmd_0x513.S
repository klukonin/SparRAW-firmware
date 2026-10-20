/* ut_hw_drivers_cmd_0x513 @ 0x8d0cbc, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_get
 * Зовёт сам: __ld_r13_ret, hwd_rfc_read_rgf
 */
	.section .text.ut_hw_drivers_cmd_0x513,"ax",@progbits
	.global ut_hw_drivers_cmd_0x513
ut_hw_drivers_cmd_0x513:
	.global L_8d0cbc
L_8d0cbc:
	push_s blink
L_8d0cbe:
	push_s r13
L_8d0cc0:
	mov_s r13,r3
L_8d0cc2:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8d0cc4:
	add1_s r1,r1,r1
L_8d0cc6:
	cmp_s r2,0x0
L_8d0cc8:
	add.ne r1,r1,0x8080
L_8d0cd0:
	add.eq r1,r1,0x10080
L_8d0cd8:
	lsr_s r1,r1,0x3
L_8d0cda:
	bl.d L_8d04fc
L_8d0cde:
	bic r1,r1,0x3
L_8d0ce2:
	bmsk_s r13,r13,0x0
L_8d0ce4:
	add_s r13,r13,0x1c
L_8d0ce6:
	mov_s r1,0x0
L_8d0ce8:
	bset r1,r1,r13
L_8d0cec:
	and_s r0,r0,r1
L_8d0cee:
	lsr_s r0,r0,r13
L_8d0cf0:
	b.d L_8c033c
L_8d0cf4:
	extb_s r0,r0
L_8d0cf6:
	nop_s
