/* ut_hw_drivers_cmd_0x50f @ 0x8d3b90, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_get
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers_cmd_0x50f
ut_hw_drivers_cmd_0x50f:
	.global L_8d3b90
L_8d3b90:
	push_s blink
L_8d3b92:
	bl L_8c01dc
L_8d3b96:
	mov_s r16,r0
L_8d3b98:
	mov_s r14,r3
L_8d3b9a:
	asl_s r13,r1,0x6
L_8d3b9c:
	add1_s r13,r13,r13
L_8d3b9e:
	breq_s r2,0,L_8d3bbe
L_8d3ba0:
	add r0,r13,0x8000
L_8d3ba8:
	lsr_s r0,r0,0x3
L_8d3baa:
	bic r1,r0,0x3
L_8d3bae:
	bl.d L_8d3588
L_8d3bb2:
	mov_s r0,r16
L_8d3bb4:
	add_s r13,r13,0x8020
L_8d3bba:
	mov_s r15,r0
L_8d3bbc:
	b_s L_8d3bda
	.global L_8d3bbe
L_8d3bbe:
	add r0,r13,0x10000
L_8d3bc6:
	lsr_s r0,r0,0x3
L_8d3bc8:
	bic r1,r0,0x3
L_8d3bcc:
	bl.d L_8d3588
L_8d3bd0:
	mov_s r0,r16
L_8d3bd2:
	mov_s r15,r0
L_8d3bd4:
	add_s r13,r13,0x10020
	.global L_8d3bda
L_8d3bda:
	lsr_s r13,r13,0x3
L_8d3bdc:
	bic r1,r13,0x3
L_8d3be0:
	bl.d L_8d3588
L_8d3be4:
	mov_s r0,r16
L_8d3be6:
	brge.d r14,0x10,L_8d3bf4
L_8d3bea:
	asl_s r1,r14
L_8d3bec:
	extb_s r1,r1
L_8d3bee:
	lsr_s r0,r0,r1
L_8d3bf0:
	bmsk_s r0,r0,0x1
L_8d3bf2:
	b_s L_8d3c00
	.global L_8d3bf4
L_8d3bf4:
	sub r1,r1,0x20
L_8d3bf8:
	extb_s r1,r1
L_8d3bfa:
	lsr_s r15,r15,r1
L_8d3bfc:
	bmsk r0,r15,0x1
	.global L_8d3c00
L_8d3c00:
	b L_8c0244
