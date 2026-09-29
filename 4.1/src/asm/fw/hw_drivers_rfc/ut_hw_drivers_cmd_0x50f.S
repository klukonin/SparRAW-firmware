/* ut_hw_drivers_cmd_0x50f @ 0x8d0ae4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_get
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_rfc_read_rgf
 */
	.section .text.ut_hw_drivers_cmd_0x50f,"ax",@progbits
	.global ut_hw_drivers_cmd_0x50f
ut_hw_drivers_cmd_0x50f:
	.global L_8d0ae4
L_8d0ae4:
	push_s blink
L_8d0ae6:
	bl L_8c02bc
L_8d0aea:
	mov_s r16,r0
L_8d0aec:
	mov_s r14,r3
L_8d0aee:
	asl_s r13,r1,0x6
L_8d0af0:
	add1_s r13,r13,r13
L_8d0af2:
	breq_s r2,0,L_8d0b12
L_8d0af4:
	add r0,r13,0x8000
L_8d0afc:
	lsr_s r0,r0,0x3
L_8d0afe:
	bic r1,r0,0x3
L_8d0b02:
	bl.d L_8d04fc
L_8d0b06:
	mov_s r0,r16
L_8d0b08:
	add_s r13,r13,0x8020
L_8d0b0e:
	mov_s r15,r0
L_8d0b10:
	b_s L_8d0b2e
	.global L_8d0b12
L_8d0b12:
	add r0,r13,0x10000
L_8d0b1a:
	lsr_s r0,r0,0x3
L_8d0b1c:
	bic r1,r0,0x3
L_8d0b20:
	bl.d L_8d04fc
L_8d0b24:
	mov_s r0,r16
L_8d0b26:
	mov_s r15,r0
L_8d0b28:
	add_s r13,r13,0x10020
	.global L_8d0b2e
L_8d0b2e:
	lsr_s r13,r13,0x3
L_8d0b30:
	bic r1,r13,0x3
L_8d0b34:
	bl.d L_8d04fc
L_8d0b38:
	mov_s r0,r16
L_8d0b3a:
	brge.d r14,0x10,L_8d0b48
L_8d0b3e:
	asl_s r1,r14
L_8d0b40:
	extb_s r1,r1
L_8d0b42:
	lsr_s r0,r0,r1
L_8d0b44:
	bmsk_s r0,r0,0x1
L_8d0b46:
	b_s L_8d0b54
	.global L_8d0b48
L_8d0b48:
	sub r1,r1,0x20
L_8d0b4c:
	extb_s r1,r1
L_8d0b4e:
	lsr_s r15,r15,r1
L_8d0b50:
	bmsk r0,r15,0x1
	.global L_8d0b54
L_8d0b54:
	b L_8c0324
