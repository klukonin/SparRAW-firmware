/* hwd_rfc_sector_edge_gain_set @ 0x8d39f8, 408 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_sector_edge_gain_set(): TX sector# %d activated (settings applied to current RF chain HW)
 *   hwd_rfc_sector_edge_gain_set(): RX sector# %d activated (settings applied to current RF chain HW)
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, fw_log_emit1, hwd_rfc_read_rgf, rf_sector_commit_rx, rf_sector_commit_tx, rfc_field_write, ut_hw_drivers_cmd_0x507, ut_hw_drivers_cmd_0x508
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_sector_edge_gain_set
hwd_rfc_sector_edge_gain_set:
	.global L_8d39f8
L_8d39f8:
	push_s blink
L_8d39fa:
	bl L_8c01c0
L_8d39fe:
	mov_s r19,r0
L_8d3a00:
	mov_s r20,r1
L_8d3a02:
	mov.f r22,r2
L_8d3a06:
	mov_s r14,r3
L_8d3a08:
	mov r18,r4
L_8d3a0c:
	mov_s r15,r5
L_8d3a0e:
	asl_s r13,r1,0x6
L_8d3a10:
	add1_s r13,r13,r13
L_8d3a12:
	beq_s L_8d3a4a
L_8d3a14:
	add r0,r13,0x80a0
L_8d3a1c:
	lsr_s r0,r0,0x3
L_8d3a1e:
	bic r1,r0,0x3
L_8d3a22:
	bl.d L_8d3588
L_8d3a26:
	mov_s r0,r19
L_8d3a28:
	mov_s r23,r0
L_8d3a2a:
	add r0,r13,0x8040
L_8d3a32:
	lsr_s r0,r0,0x3
L_8d3a34:
	bic r1,r0,0x3
L_8d3a38:
	bl.d L_8d3588
L_8d3a3c:
	mov_s r0,r19
L_8d3a3e:
	mov_s r16,r0
L_8d3a40:
	add r0,r13,0x8060
L_8d3a48:
	b_s L_8d3a7e
	.global L_8d3a4a
L_8d3a4a:
	add r0,r13,0x100a0
L_8d3a52:
	lsr_s r0,r0,0x3
L_8d3a54:
	bic r1,r0,0x3
L_8d3a58:
	bl.d L_8d3588
L_8d3a5c:
	mov_s r0,r19
L_8d3a5e:
	mov_s r23,r0
L_8d3a60:
	add r0,r13,0x10040
L_8d3a68:
	lsr_s r0,r0,0x3
L_8d3a6a:
	bic r1,r0,0x3
L_8d3a6e:
	bl.d L_8d3588
L_8d3a72:
	mov_s r0,r19
L_8d3a74:
	mov_s r16,r0
L_8d3a76:
	add r0,r13,0x10060
	.global L_8d3a7e
L_8d3a7e:
	lsr_s r0,r0,0x3
L_8d3a80:
	bic r1,r0,0x3
L_8d3a84:
	bl.d L_8d3588
L_8d3a88:
	mov_s r0,r19
L_8d3a8a:
	and r2,r18,0x4
L_8d3a8e:
	lsr_s r2,r2,0x2
L_8d3a90:
	and r1,r18,0x2
L_8d3a94:
	lsr r21,r1
L_8d3a98:
	bmsk r18,r18,0x0
L_8d3a9c:
	mov_s r1,0x0
L_8d3a9e:
	bset r1,r1,r14
L_8d3aa2:
	not_s r3,r1
L_8d3aa4:
	and r23,r23,r3
L_8d3aa8:
	asl_s r2,r2,r14
L_8d3aaa:
	and r16,r16,r3
L_8d3aae:
	asl r21,r21,r14
L_8d3ab2:
	and r17,r0,r3
L_8d3ab6:
	asl r18,r18,r14
L_8d3aba:
	breq r22,0x0,L_8d3b22
L_8d3abe:
	add r0,r13,0x80a0
L_8d3ac6:
	lsr_s r0,r0,0x3
L_8d3ac8:
	bic r1,r0,0x3
L_8d3acc:
	mov_s r0,r19
L_8d3ace:
	bl.d L_8d4308
L_8d3ad2:
	or r2,r2,r23
L_8d3ad6:
	add r0,r13,0x8040
L_8d3ade:
	lsr_s r0,r0,0x3
L_8d3ae0:
	bic r1,r0,0x3
L_8d3ae4:
	mov_s r0,r19
L_8d3ae6:
	bl.d L_8d4308
L_8d3aea:
	or r2,r21,r16
L_8d3aee:
	add_s r13,r13,0x8060
L_8d3af4:
	lsr_s r13,r13,0x3
L_8d3af6:
	bic r1,r13,0x3
L_8d3afa:
	mov_s r0,r19
L_8d3afc:
	bl.d L_8d4308
L_8d3b00:
	or r2,r18,r17
L_8d3b04:
	brge r15,0x10,L_8d3b8c
L_8d3b08:
	mov_s r0,r19
L_8d3b0a:
	bl.d L_8d40d8
L_8d3b0e:
	mov_s r1,r20
L_8d3b10:
	mov_s r0,r19
L_8d3b12:
	mov_s r1,r20
L_8d3b14:
	bl.d L_8d4104
L_8d3b18:
	mov_s r2,r15
L_8d3b1a:
	mov_s r1,0x101e410
L_8d3b20:
	b_s L_8d3b84
	.global L_8d3b22
L_8d3b22:
	add r0,r13,0x100a0
L_8d3b2a:
	lsr_s r0,r0,0x3
L_8d3b2c:
	bic r1,r0,0x3
L_8d3b30:
	mov_s r0,r19
L_8d3b32:
	bl.d L_8d4308
L_8d3b36:
	or r2,r2,r23
L_8d3b3a:
	add r0,r13,0x10040
L_8d3b42:
	lsr_s r0,r0,0x3
L_8d3b44:
	bic r1,r0,0x3
L_8d3b48:
	mov_s r0,r19
L_8d3b4a:
	bl.d L_8d4308
L_8d3b4e:
	or r2,r21,r16
L_8d3b52:
	add_s r13,r13,0x10060
L_8d3b58:
	lsr_s r13,r13,0x3
L_8d3b5a:
	bic r1,r13,0x3
L_8d3b5e:
	mov_s r0,r19
L_8d3b60:
	bl.d L_8d4308
L_8d3b64:
	or r2,r18,r17
L_8d3b68:
	brge r15,0x10,L_8d3b8c
L_8d3b6c:
	mov_s r0,r19
L_8d3b6e:
	bl.d L_8d37dc
L_8d3b72:
	mov_s r1,r20
L_8d3b74:
	mov_s r0,r19
L_8d3b76:
	mov_s r1,r20
L_8d3b78:
	bl.d L_8d3808
L_8d3b7c:
	mov_s r2,r15
L_8d3b7e:
	mov_s r1,0x101e474
	.global L_8d3b84
L_8d3b84:
	mov_s r0,0x20
L_8d3b86:
	bl.d L_8dcc10
L_8d3b8a:
	mov_s r2,r20
	.global L_8d3b8c
L_8d3b8c:
	b L_8c020c
