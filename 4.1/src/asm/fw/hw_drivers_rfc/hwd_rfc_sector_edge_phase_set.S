/* hwd_rfc_sector_edge_phase_set @ 0x8d0b58, 356 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_sector_edge_phase_set(): Before Update: phs_h_val=0x%8x, phs_l_val=0x%8x, edge_num=%d
 *   hwd_rfc_sector_edge_phase_set(): After Update: phs_h_val=0x%8x, phs_l_val=0x%8x, field_position=%d
 *   hwd_rfc_sector_edge_phase_set(): TX sector# %d activated (settings applied to current RF chain HW)
 *   hwd_rfc_sector_edge_phase_set(): RX sector# %d activated (settings applied to current RF chain HW)
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log__emit1, fw_log__emit3, hwd_rfc_read_rgf, rf_sector_commit_rx, rf_sector_commit_tx, rfc_field_write
 */
	.section .text.hwd_rfc_sector_edge_phase_set,"ax",@progbits
	.global hwd_rfc_sector_edge_phase_set
hwd_rfc_sector_edge_phase_set:
	.global L_8d0b58
L_8d0b58:
	push_s blink
L_8d0b5a:
	bl L_8c02a8
L_8d0b5e:
	mov_s r18,r0
L_8d0b60:
	mov_s r17,r1
L_8d0b62:
	mov.f r15,r2
L_8d0b66:
	mov_s r19,r3
L_8d0b68:
	mov r16,r4
L_8d0b6c:
	mov r20,r5
L_8d0b70:
	asl_s r14,r1,0x6
L_8d0b72:
	add1_s r14,r14,r14
L_8d0b74:
	beq_s L_8d0ba0
L_8d0b76:
	add r0,r14,0x8000
L_8d0b7e:
	lsr_s r0,r0,0x3
L_8d0b80:
	bic r1,r0,0x3
L_8d0b84:
	bl.d L_8d04fc
L_8d0b88:
	mov_s r0,r18
L_8d0b8a:
	mov_s r13,r0
L_8d0b8c:
	add r0,r14,0x8020
L_8d0b94:
	lsr_s r0,r0,0x3
L_8d0b96:
	bic r4,r0,0x3
L_8d0b9a:
	mov_s r0,r18
L_8d0b9c:
	mov_s r1,r4
L_8d0b9e:
	b_s L_8d0bc6
	.global L_8d0ba0
L_8d0ba0:
	add r0,r14,0x10000
L_8d0ba8:
	lsr_s r0,r0,0x3
L_8d0baa:
	bic r1,r0,0x3
L_8d0bae:
	bl.d L_8d04fc
L_8d0bb2:
	mov_s r0,r18
L_8d0bb4:
	mov_s r13,r0
L_8d0bb6:
	add r0,r14,0x10020
L_8d0bbe:
	lsr_s r0,r0,0x3
L_8d0bc0:
	bic r1,r0,0x3
L_8d0bc4:
	mov_s r0,r18
	.global L_8d0bc6
L_8d0bc6:
	bl L_8d04fc
L_8d0bca:
	mov_s r2,0x10192a8
L_8d0bd0:
	mov_s r21,r0
L_8d0bd2:
	mov_s r0,0x0
L_8d0bd4:
	mov_s r1,0x2
L_8d0bd6:
	mov_s r3,r13
L_8d0bd8:
	mov r4,r21
L_8d0bdc:
	bl.d L_8ee034
L_8d0be0:
	mov r5,r19
L_8d0be4:
	bmsk r0,r16,0x1
L_8d0be8:
	asl r1,r19
L_8d0bec:
	brge.d r19,0x10,L_8d0c08
L_8d0bf0:
	mov_s r2,0x3
L_8d0bf2:
	extb r5,r1
L_8d0bf6:
	asl r2,r2,r5
L_8d0bfa:
	bic r1,r21,r2
L_8d0bfe:
	asl r0,r0,r5
L_8d0c02:
	or r21,r0,r1
L_8d0c06:
	b_s L_8d0c1c
	.global L_8d0c08
L_8d0c08:
	sub r5,r1,0x20
L_8d0c0c:
	extb r5,r5
L_8d0c10:
	asl r2,r2,r5
L_8d0c14:
	bic_s r13,r13,r2
L_8d0c16:
	asl r0,r0,r5
L_8d0c1a:
	or_s r13,r13,r0
	.global L_8d0c1c
L_8d0c1c:
	mov_s r2,0x1019308
L_8d0c22:
	mov_s r0,0x0
L_8d0c24:
	mov_s r1,0x2
L_8d0c26:
	mov_s r3,r13
L_8d0c28:
	bl.d L_8ee034
L_8d0c2c:
	mov r4,r21
L_8d0c30:
	breq_s r15,0,L_8d0c70
L_8d0c32:
	add r0,r14,0x8000
L_8d0c3a:
	lsr_s r0,r0,0x3
L_8d0c3c:
	bic r1,r0,0x3
L_8d0c40:
	mov_s r0,r18
L_8d0c42:
	bl.d L_8d113c
L_8d0c46:
	mov_s r2,r13
L_8d0c48:
	add_s r14,r14,0x8020
L_8d0c4e:
	lsr_s r14,r14,0x3
L_8d0c50:
	bic r1,r14,0x3
L_8d0c54:
	mov_s r0,r18
L_8d0c56:
	bl.d L_8d113c
L_8d0c5a:
	mov_s r2,r21
L_8d0c5c:
	breq r20,0x0,L_8d0cb6
L_8d0c60:
	mov_s r0,r18
L_8d0c62:
	bl.d L_8d0ef4
L_8d0c66:
	mov_s r1,r17
L_8d0c68:
	mov_s r2,0x101936c
L_8d0c6e:
	b_s L_8d0cac
	.global L_8d0c70
L_8d0c70:
	add r0,r14,0x10000
L_8d0c78:
	lsr_s r0,r0,0x3
L_8d0c7a:
	bic r1,r0,0x3
L_8d0c7e:
	mov_s r0,r18
L_8d0c80:
	bl.d L_8d113c
L_8d0c84:
	mov_s r2,r13
L_8d0c86:
	add_s r14,r14,0x10020
L_8d0c8c:
	lsr_s r14,r14,0x3
L_8d0c8e:
	bic r1,r14,0x3
L_8d0c92:
	mov_s r0,r18
L_8d0c94:
	bl.d L_8d113c
L_8d0c98:
	mov_s r2,r21
L_8d0c9a:
	breq r20,0x0,L_8d0cb6
L_8d0c9e:
	mov_s r0,r18
L_8d0ca0:
	bl.d L_8d073c
L_8d0ca4:
	mov_s r1,r17
L_8d0ca6:
	mov_s r2,0x10193d0
	.global L_8d0cac
L_8d0cac:
	mov_s r0,0x0
L_8d0cae:
	mov_s r1,0x2
L_8d0cb0:
	bl.d L_8edfcc
L_8d0cb4:
	mov_s r3,r17
	.global L_8d0cb6
L_8d0cb6:
	b L_8c02fc
L_8d0cba:
	nop_s
