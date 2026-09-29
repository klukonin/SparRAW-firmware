/* hwd_rfc_sector_edge_gain_set @ 0x8d0960, 388 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_sector_edge_gain_set(): TX sector# %d activated (settings applied to current RF chain HW)
 *   hwd_rfc_sector_edge_gain_set(): RX sector# %d activated (settings applied to current RF chain HW)
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, fw_log__emit1, hwd_rfc_read_rgf, rf_sector_commit_rx, rf_sector_commit_tx, rfc_field_write
 */
	.section .text.hwd_rfc_sector_edge_gain_set,"ax",@progbits
	.global hwd_rfc_sector_edge_gain_set
hwd_rfc_sector_edge_gain_set:
	.global L_8d0960
L_8d0960:
	push_s blink
L_8d0962:
	bl L_8c02a0
L_8d0966:
	mov_s r18,r0
L_8d0968:
	mov_s r19,r1
L_8d096a:
	mov.f r22,r2
L_8d096e:
	mov_s r14,r3
L_8d0970:
	mov_s r15,r4
L_8d0972:
	mov r20,r5
L_8d0976:
	asl_s r13,r1,0x6
L_8d0978:
	add1_s r13,r13,r13
L_8d097a:
	beq_s L_8d09b2
L_8d097c:
	add r0,r13,0x80a0
L_8d0984:
	lsr_s r0,r0,0x3
L_8d0986:
	bic r1,r0,0x3
L_8d098a:
	bl.d L_8d04fc
L_8d098e:
	mov_s r0,r18
L_8d0990:
	mov_s r23,r0
L_8d0992:
	add r0,r13,0x8040
L_8d099a:
	lsr_s r0,r0,0x3
L_8d099c:
	bic r1,r0,0x3
L_8d09a0:
	bl.d L_8d04fc
L_8d09a4:
	mov_s r0,r18
L_8d09a6:
	mov_s r16,r0
L_8d09a8:
	add r0,r13,0x8060
L_8d09b0:
	b_s L_8d09e6
	.global L_8d09b2
L_8d09b2:
	add r0,r13,0x100a0
L_8d09ba:
	lsr_s r0,r0,0x3
L_8d09bc:
	bic r1,r0,0x3
L_8d09c0:
	bl.d L_8d04fc
L_8d09c4:
	mov_s r0,r18
L_8d09c6:
	mov_s r23,r0
L_8d09c8:
	add r0,r13,0x10040
L_8d09d0:
	lsr_s r0,r0,0x3
L_8d09d2:
	bic r1,r0,0x3
L_8d09d6:
	bl.d L_8d04fc
L_8d09da:
	mov_s r0,r18
L_8d09dc:
	mov_s r16,r0
L_8d09de:
	add r0,r13,0x10060
	.global L_8d09e6
L_8d09e6:
	lsr_s r0,r0,0x3
L_8d09e8:
	bic r1,r0,0x3
L_8d09ec:
	bl.d L_8d04fc
L_8d09f0:
	mov_s r0,r18
L_8d09f2:
	and r2,r15,0x4
L_8d09f6:
	lsr_s r2,r2,0x2
L_8d09f8:
	and r1,r15,0x2
L_8d09fc:
	lsr r21,r1
L_8d0a00:
	bmsk r17,r15,0x0
L_8d0a04:
	mov_s r1,0x0
L_8d0a06:
	bset r1,r1,r14
L_8d0a0a:
	not_s r15,r1
L_8d0a0c:
	and r3,r15,r23
L_8d0a10:
	asl_s r2,r2,r14
L_8d0a12:
	and r16,r16,r15
L_8d0a16:
	asl r21,r21,r14
L_8d0a1a:
	and_s r15,r15,r0
L_8d0a1c:
	asl r17,r17,r14
L_8d0a20:
	breq r22,0x0,L_8d0a7c
L_8d0a24:
	add r0,r13,0x80a0
L_8d0a2c:
	lsr_s r0,r0,0x3
L_8d0a2e:
	bic r1,r0,0x3
L_8d0a32:
	mov_s r0,r18
L_8d0a34:
	bl.d L_8d113c
L_8d0a38:
	or_s r2,r2,r3
L_8d0a3a:
	add r0,r13,0x8040
L_8d0a42:
	lsr_s r0,r0,0x3
L_8d0a44:
	bic r1,r0,0x3
L_8d0a48:
	mov_s r0,r18
L_8d0a4a:
	bl.d L_8d113c
L_8d0a4e:
	or r2,r21,r16
L_8d0a52:
	add_s r13,r13,0x8060
L_8d0a58:
	lsr_s r13,r13,0x3
L_8d0a5a:
	bic r1,r13,0x3
L_8d0a5e:
	mov_s r0,r18
L_8d0a60:
	bl.d L_8d113c
L_8d0a64:
	or r2,r17,r15
L_8d0a68:
	breq r20,0x0,L_8d0ade
L_8d0a6c:
	mov_s r0,r18
L_8d0a6e:
	bl.d L_8d0ef4
L_8d0a72:
	mov_s r1,r19
L_8d0a74:
	mov_s r2,0x10191e0
L_8d0a7a:
	b_s L_8d0ad4
	.global L_8d0a7c
L_8d0a7c:
	add r0,r13,0x100a0
L_8d0a84:
	lsr_s r0,r0,0x3
L_8d0a86:
	bic r4,r0,0x3
L_8d0a8a:
	mov_s r0,r18
L_8d0a8c:
	mov_s r1,r4
L_8d0a8e:
	bl.d L_8d113c
L_8d0a92:
	or_s r2,r2,r3
L_8d0a94:
	add r0,r13,0x10040
L_8d0a9c:
	lsr_s r0,r0,0x3
L_8d0a9e:
	bic r1,r0,0x3
L_8d0aa2:
	mov_s r0,r18
L_8d0aa4:
	bl.d L_8d113c
L_8d0aa8:
	or r2,r21,r16
L_8d0aac:
	add_s r13,r13,0x10060
L_8d0ab2:
	lsr_s r13,r13,0x3
L_8d0ab4:
	bic r1,r13,0x3
L_8d0ab8:
	mov_s r0,r18
L_8d0aba:
	bl.d L_8d113c
L_8d0abe:
	or r2,r17,r15
L_8d0ac2:
	breq r20,0x0,L_8d0ade
L_8d0ac6:
	mov_s r0,r18
L_8d0ac8:
	bl.d L_8d073c
L_8d0acc:
	mov_s r1,r19
L_8d0ace:
	mov_s r2,0x1019244
	.global L_8d0ad4
L_8d0ad4:
	mov_s r0,0x0
L_8d0ad6:
	mov_s r1,0x2
L_8d0ad8:
	bl.d L_8edfcc
L_8d0adc:
	mov_s r3,r19
	.global L_8d0ade
L_8d0ade:
	b L_8c02ec
L_8d0ae2:
	nop_s
