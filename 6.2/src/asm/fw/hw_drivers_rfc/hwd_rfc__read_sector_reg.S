/* hwd_rfc__read_sector_reg @ 0x8d3850, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_get, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc__read_sector_reg
hwd_rfc__read_sector_reg:
	.global L_8d3850
L_8d3850:
	push_s blink
L_8d3852:
	push_s r13
L_8d3854:
	mov_s r13,r3
L_8d3856:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8d3858:
	add1_s r1,r1,r1
L_8d385a:
	cmp_s r2,0x0
L_8d385c:
	add.ne r1,r1,0x8080
L_8d3864:
	add.eq r1,r1,0x10080
L_8d386c:
	lsr_s r1,r1,0x3
L_8d386e:
	bl.d L_8d3588
L_8d3872:
	bic r1,r1,0x3
L_8d3876:
	mov_s r1,r0
L_8d3878:
	add1 r0,r13,r13
L_8d387c:
	lsr r0,r1,r0
L_8d3880:
	b.d L_8c025c
L_8d3884:
	bmsk_s r0,r0,0x2
L_8d3886:
	nop_s
