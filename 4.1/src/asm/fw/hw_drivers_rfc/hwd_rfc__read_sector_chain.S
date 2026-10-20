/* hwd_rfc__read_sector_chain @ 0x8d08bc, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_get, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_rfc_read_rgf
 */
	.section .text.hwd_rfc__read_sector_chain,"ax",@progbits
	.global hwd_rfc__read_sector_chain
hwd_rfc__read_sector_chain:
	.global L_8d08bc
L_8d08bc:
	push_s blink
L_8d08be:
	bl L_8c02b8
L_8d08c2:
	mov_s r17,r0
L_8d08c4:
	mov_s r14,r3
L_8d08c6:
	asl_s r13,r1,0x6
L_8d08c8:
	add1_s r13,r13,r13
L_8d08ca:
	breq_s r2,0,L_8d0900
L_8d08cc:
	add r0,r13,0x80a0
L_8d08d4:
	lsr_s r0,r0,0x3
L_8d08d6:
	bic r1,r0,0x3
L_8d08da:
	bl.d L_8d04fc
L_8d08de:
	mov_s r0,r17
L_8d08e0:
	mov_s r16,r0
L_8d08e2:
	add r0,r13,0x8040
L_8d08ea:
	lsr_s r0,r0,0x3
L_8d08ec:
	bic r1,r0,0x3
L_8d08f0:
	bl.d L_8d04fc
L_8d08f4:
	mov_s r0,r17
L_8d08f6:
	add_s r13,r13,0x8060
L_8d08fc:
	mov_s r15,r0
L_8d08fe:
	b_s L_8d0932
	.global L_8d0900
L_8d0900:
	add r0,r13,0x100a0
L_8d0908:
	lsr_s r0,r0,0x3
L_8d090a:
	bic r1,r0,0x3
L_8d090e:
	bl.d L_8d04fc
L_8d0912:
	mov_s r0,r17
L_8d0914:
	mov_s r16,r0
L_8d0916:
	add r0,r13,0x10040
L_8d091e:
	lsr_s r0,r0,0x3
L_8d0920:
	bic r1,r0,0x3
L_8d0924:
	bl.d L_8d04fc
L_8d0928:
	mov_s r0,r17
L_8d092a:
	mov_s r15,r0
L_8d092c:
	add_s r13,r13,0x10060
	.global L_8d0932
L_8d0932:
	lsr_s r13,r13,0x3
L_8d0934:
	bic r1,r13,0x3
L_8d0938:
	bl.d L_8d04fc
L_8d093c:
	mov_s r0,r17
L_8d093e:
	mov_s r1,0x0
L_8d0940:
	bset r1,r1,r14
L_8d0944:
	and r2,r1,r16
L_8d0948:
	lsr_s r2,r2,r14
L_8d094a:
	and_s r15,r15,r1
L_8d094c:
	lsr_s r15,r15,r14
L_8d094e:
	and_s r0,r0,r1
L_8d0950:
	lsr_s r0,r0,r14
L_8d0952:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_8d0954:
	add1_s r2,r2,r15
L_8d0956:
	add_s r0,r0,r2
L_8d0958:
	b.d L_8c031c
L_8d095c:
	extb_s r0,r0
L_8d095e:
	nop_s
