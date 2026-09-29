/* hwd_rfc__read_sector_chain @ 0x8d3954, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_get, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc__read_sector_chain
hwd_rfc__read_sector_chain:
	.global L_8d3954
L_8d3954:
	push_s blink
L_8d3956:
	bl L_8c01d8
L_8d395a:
	mov_s r17,r0
L_8d395c:
	mov_s r14,r3
L_8d395e:
	asl_s r13,r1,0x6
L_8d3960:
	add1_s r13,r13,r13
L_8d3962:
	breq_s r2,0,L_8d3998
L_8d3964:
	add r0,r13,0x80a0
L_8d396c:
	lsr_s r0,r0,0x3
L_8d396e:
	bic r1,r0,0x3
L_8d3972:
	bl.d L_8d3588
L_8d3976:
	mov_s r0,r17
L_8d3978:
	mov_s r16,r0
L_8d397a:
	add r0,r13,0x8040
L_8d3982:
	lsr_s r0,r0,0x3
L_8d3984:
	bic r1,r0,0x3
L_8d3988:
	bl.d L_8d3588
L_8d398c:
	mov_s r0,r17
L_8d398e:
	add_s r13,r13,0x8060
L_8d3994:
	mov_s r15,r0
L_8d3996:
	b_s L_8d39ca
	.global L_8d3998
L_8d3998:
	add r0,r13,0x100a0
L_8d39a0:
	lsr_s r0,r0,0x3
L_8d39a2:
	bic r1,r0,0x3
L_8d39a6:
	bl.d L_8d3588
L_8d39aa:
	mov_s r0,r17
L_8d39ac:
	mov_s r16,r0
L_8d39ae:
	add r0,r13,0x10040
L_8d39b6:
	lsr_s r0,r0,0x3
L_8d39b8:
	bic r1,r0,0x3
L_8d39bc:
	bl.d L_8d3588
L_8d39c0:
	mov_s r0,r17
L_8d39c2:
	mov_s r15,r0
L_8d39c4:
	add_s r13,r13,0x10060
	.global L_8d39ca
L_8d39ca:
	lsr_s r13,r13,0x3
L_8d39cc:
	bic r1,r13,0x3
L_8d39d0:
	bl.d L_8d3588
L_8d39d4:
	mov_s r0,r17
L_8d39d6:
	mov_s r1,0x0
L_8d39d8:
	bset r1,r1,r14
L_8d39dc:
	and r2,r1,r16
L_8d39e0:
	lsr_s r2,r2,r14
L_8d39e2:
	and_s r15,r15,r1
L_8d39e4:
	lsr_s r15,r15,r14
L_8d39e6:
	and_s r0,r0,r1
L_8d39e8:
	lsr_s r0,r0,r14
L_8d39ea:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_8d39ec:
	add1_s r2,r2,r15
L_8d39ee:
	add_s r0,r0,r2
L_8d39f0:
	b.d L_8c023c
L_8d39f4:
	extb_s r0,r0
L_8d39f6:
	nop_s
