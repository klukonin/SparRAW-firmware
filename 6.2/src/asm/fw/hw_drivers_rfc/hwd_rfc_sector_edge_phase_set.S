/* hwd_rfc_sector_edge_phase_set @ 0x8d3c04, 352 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log_emit1, fw_log_emit3, hwd_rfc_read_rgf, rf_sector_commit_rx, rf_sector_commit_tx, rfc_field_write, ut_hw_drivers_cmd_0x507, ut_hw_drivers_cmd_0x508
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_sector_edge_phase_set
hwd_rfc_sector_edge_phase_set:
	.global L_8d3c04
L_8d3c04:
	push_s blink
L_8d3c06:
	bl L_8c01c8
L_8d3c0a:
	mov_s r19,r0
L_8d3c0c:
	mov_s r20,r1
L_8d3c0e:
	mov.f r16,r2
L_8d3c12:
	mov_s r21,r3
L_8d3c14:
	mov r18,r4
L_8d3c18:
	mov r17,r5
L_8d3c1c:
	asl_s r13,r1,0x6
L_8d3c1e:
	add1_s r13,r13,r13
L_8d3c20:
	beq_s L_8d3c42
L_8d3c22:
	add r0,r13,0x8000
L_8d3c2a:
	lsr_s r0,r0,0x3
L_8d3c2c:
	bic r1,r0,0x3
L_8d3c30:
	bl.d L_8d3588
L_8d3c34:
	mov_s r0,r19
L_8d3c36:
	mov_s r15,r0
L_8d3c38:
	add r0,r13,0x8020
L_8d3c40:
	b_s L_8d3c60
	.global L_8d3c42
L_8d3c42:
	add r0,r13,0x10000
L_8d3c4a:
	lsr_s r0,r0,0x3
L_8d3c4c:
	bic r1,r0,0x3
L_8d3c50:
	bl.d L_8d3588
L_8d3c54:
	mov_s r0,r19
L_8d3c56:
	mov_s r15,r0
L_8d3c58:
	add r0,r13,0x10020
	.global L_8d3c60
L_8d3c60:
	lsr_s r0,r0,0x3
L_8d3c62:
	bic r1,r0,0x3
L_8d3c66:
	bl.d L_8d3588
L_8d3c6a:
	mov_s r0,r19
L_8d3c6c:
	mov_s r14,r0
L_8d3c6e:
	mov_s r1,0x101e4d8
L_8d3c74:
	mov_s r0,0x20
L_8d3c76:
	mov_s r2,r15
L_8d3c78:
	mov_s r3,r14
L_8d3c7a:
	bl.d L_8dcd00
L_8d3c7e:
	mov r4,r21
L_8d3c82:
	bmsk r2,r18,0x1
L_8d3c86:
	asl r1,r21
L_8d3c8a:
	brge.d r21,0x10,L_8d3ca2
L_8d3c8e:
	mov_s r0,0x3
L_8d3c90:
	extb r4,r1
L_8d3c94:
	asl r0,r0,r4
L_8d3c98:
	bic_s r14,r14,r0
L_8d3c9a:
	asl r2,r2,r4
L_8d3c9e:
	or_s r14,r14,r2
L_8d3ca0:
	b_s L_8d3cb6
	.global L_8d3ca2
L_8d3ca2:
	sub r4,r1,0x20
L_8d3ca6:
	extb r4,r4
L_8d3caa:
	asl r0,r0,r4
L_8d3cae:
	bic_s r15,r15,r0
L_8d3cb0:
	asl r2,r2,r4
L_8d3cb4:
	or_s r15,r15,r2
	.global L_8d3cb6
L_8d3cb6:
	mov_s r1,0x101e538
L_8d3cbc:
	mov_s r0,0x20
L_8d3cbe:
	mov_s r2,r15
L_8d3cc0:
	bl.d L_8dcd00
L_8d3cc4:
	mov_s r3,r14
L_8d3cc6:
	breq r16,0x0,L_8d3d12
L_8d3cca:
	add r0,r13,0x8000
L_8d3cd2:
	lsr_s r0,r0,0x3
L_8d3cd4:
	bic r1,r0,0x3
L_8d3cd8:
	mov_s r0,r19
L_8d3cda:
	bl.d L_8d4308
L_8d3cde:
	mov_s r2,r15
L_8d3ce0:
	add_s r13,r13,0x8020
L_8d3ce6:
	lsr_s r13,r13,0x3
L_8d3ce8:
	bic r1,r13,0x3
L_8d3cec:
	mov_s r0,r19
L_8d3cee:
	bl.d L_8d4308
L_8d3cf2:
	mov_s r2,r14
L_8d3cf4:
	brge r17,0x10,L_8d3d60
L_8d3cf8:
	mov_s r0,r19
L_8d3cfa:
	bl.d L_8d40d8
L_8d3cfe:
	mov_s r1,r20
L_8d3d00:
	mov_s r0,r19
L_8d3d02:
	mov_s r1,r20
L_8d3d04:
	bl.d L_8d4104
L_8d3d08:
	mov_s r2,r17
L_8d3d0a:
	mov_s r1,0x101e59c
L_8d3d10:
	b_s L_8d3d58
	.global L_8d3d12
L_8d3d12:
	add r0,r13,0x10000
L_8d3d1a:
	lsr_s r0,r0,0x3
L_8d3d1c:
	bic r1,r0,0x3
L_8d3d20:
	mov_s r0,r19
L_8d3d22:
	bl.d L_8d4308
L_8d3d26:
	mov_s r2,r15
L_8d3d28:
	add_s r13,r13,0x10020
L_8d3d2e:
	lsr_s r13,r13,0x3
L_8d3d30:
	bic r1,r13,0x3
L_8d3d34:
	mov_s r0,r19
L_8d3d36:
	bl.d L_8d4308
L_8d3d3a:
	mov_s r2,r14
L_8d3d3c:
	brge r17,0x10,L_8d3d60
L_8d3d40:
	mov_s r0,r19
L_8d3d42:
	bl.d L_8d37dc
L_8d3d46:
	mov_s r1,r20
L_8d3d48:
	mov_s r0,r19
L_8d3d4a:
	mov_s r1,r20
L_8d3d4c:
	bl.d L_8d3808
L_8d3d50:
	mov_s r2,r17
L_8d3d52:
	mov_s r1,0x101e600
	.global L_8d3d58
L_8d3d58:
	mov_s r0,0x20
L_8d3d5a:
	bl.d L_8dcc10
L_8d3d5e:
	mov_s r2,r20
	.global L_8d3d60
L_8d3d60:
	b L_8c021c
