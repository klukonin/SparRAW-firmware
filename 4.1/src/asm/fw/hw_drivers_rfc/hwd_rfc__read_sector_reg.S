/* hwd_rfc__read_sector_reg @ 0x8d07c8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_get, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r13_ret, hwd_rfc_read_rgf
 */
	.section .text.hwd_rfc__read_sector_reg,"ax",@progbits
	.global hwd_rfc__read_sector_reg
hwd_rfc__read_sector_reg:
	.global L_8d07c8
L_8d07c8:
	push_s blink
L_8d07ca:
	push_s r13
L_8d07cc:
	mov_s r13,r3
L_8d07ce:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8d07d0:
	add1_s r1,r1,r1
L_8d07d2:
	cmp_s r2,0x0
L_8d07d4:
	add.ne r1,r1,0x8080
L_8d07dc:
	add.eq r1,r1,0x10080
L_8d07e4:
	lsr_s r1,r1,0x3
L_8d07e6:
	bl.d L_8d04fc
L_8d07ea:
	bic r1,r1,0x3
L_8d07ee:
	mov_s r1,r0
L_8d07f0:
	add1 r0,r13,r13
L_8d07f4:
	lsr r0,r1,r0
L_8d07f8:
	b.d L_8c033c
L_8d07fc:
	bmsk_s r0,r0,0x2
L_8d07fe:
	nop_s
