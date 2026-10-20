/* ut_hw_drivers_cmd_0x513 @ 0x8d3d64, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_get
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers_cmd_0x513
ut_hw_drivers_cmd_0x513:
	.global L_8d3d64
L_8d3d64:
	push_s blink
L_8d3d66:
	push_s r13
L_8d3d68:
	mov_s r13,r3
L_8d3d6a:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8d3d6c:
	add1_s r1,r1,r1
L_8d3d6e:
	cmp_s r2,0x0
L_8d3d70:
	add.ne r1,r1,0x8080
L_8d3d78:
	add.eq r1,r1,0x10080
L_8d3d80:
	lsr_s r1,r1,0x3
L_8d3d82:
	bl.d L_8d3588
L_8d3d86:
	bic r1,r1,0x3
L_8d3d8a:
	bmsk_s r13,r13,0x0
L_8d3d8c:
	add_s r13,r13,0x1c
L_8d3d8e:
	mov_s r1,0x0
L_8d3d90:
	bset r1,r1,r13
L_8d3d94:
	and_s r0,r0,r1
L_8d3d96:
	lsr_s r0,r0,r13
L_8d3d98:
	b.d L_8c025c
L_8d3d9c:
	extb_s r0,r0
L_8d3d9e:
	nop_s
