/* hwd_rfc_sector_x16_state_set @ 0x8d3da0, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_sector_x16_state_set(): TX sector# %d activated (settings applied to current RF chain HW)
 *   hwd_rfc_sector_x16_state_set(): RX sector# %d activated (settings applied to current RF chain HW)
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit1, hwd_rfc_read_rgf, rf_sector_commit_rx, rf_sector_commit_tx, rfc_field_write, ut_hw_drivers_cmd_0x507, ut_hw_drivers_cmd_0x508
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_sector_x16_state_set
hwd_rfc_sector_x16_state_set:
	.global L_8d3da0
L_8d3da0:
	push_s blink
L_8d3da2:
	bl L_8c01d0
L_8d3da6:
	mov_s r17,r0
L_8d3da8:
	mov_s r18,r1
L_8d3daa:
	mov.f r15,r2
L_8d3dae:
	mov_s r16,r3
L_8d3db0:
	mov r19,r4
L_8d3db4:
	mov_s r13,r5
L_8d3db6:
	asl_s r14,r1,0x6
L_8d3db8:
	add1_s r14,r14,r14
L_8d3dba:
	beq_s L_8d3dc6
L_8d3dbc:
	add r0,r14,0x8080
L_8d3dc4:
	b_s L_8d3dce
	.global L_8d3dc6
L_8d3dc6:
	add r0,r14,0x10080
	.global L_8d3dce
L_8d3dce:
	lsr_s r0,r0,0x3
L_8d3dd0:
	bic r1,r0,0x3
L_8d3dd4:
	bl.d L_8d3588
L_8d3dd8:
	mov_s r0,r17
L_8d3dda:
	bmsk r1,r16,0x0
L_8d3dde:
	add_s r1,r1,0x1c
L_8d3de0:
	bclr r2,r0,r1
L_8d3de4:
	asl r3,r19,r1
L_8d3de8:
	breq_s r15,0,L_8d3e1c
L_8d3dea:
	add_s r14,r14,0x8080
L_8d3df0:
	lsr_s r14,r14,0x3
L_8d3df2:
	bic r1,r14,0x3
L_8d3df6:
	mov_s r0,r17
L_8d3df8:
	bl.d L_8d4308
L_8d3dfc:
	or_s r2,r2,r3
L_8d3dfe:
	brge r13,0x10,L_8d3e54
L_8d3e02:
	mov_s r0,r17
L_8d3e04:
	bl.d L_8d40d8
L_8d3e08:
	mov_s r1,r18
L_8d3e0a:
	mov_s r0,r17
L_8d3e0c:
	mov_s r1,r18
L_8d3e0e:
	bl.d L_8d4104
L_8d3e12:
	mov_s r2,r13
L_8d3e14:
	mov_s r1,0x101e72c
L_8d3e1a:
	b_s L_8d3e4c
	.global L_8d3e1c
L_8d3e1c:
	add_s r14,r14,0x10080
L_8d3e22:
	lsr_s r14,r14,0x3
L_8d3e24:
	bic r1,r14,0x3
L_8d3e28:
	mov_s r0,r17
L_8d3e2a:
	bl.d L_8d4308
L_8d3e2e:
	or_s r2,r2,r3
L_8d3e30:
	brge r13,0x10,L_8d3e54
L_8d3e34:
	mov_s r0,r17
L_8d3e36:
	bl.d L_8d37dc
L_8d3e3a:
	mov_s r1,r18
L_8d3e3c:
	mov_s r0,r17
L_8d3e3e:
	mov_s r1,r18
L_8d3e40:
	bl.d L_8d3808
L_8d3e44:
	mov_s r2,r13
L_8d3e46:
	mov_s r1,0x101e790
	.global L_8d3e4c
L_8d3e4c:
	mov_s r0,0x20
L_8d3e4e:
	bl.d L_8dcc10
L_8d3e52:
	mov_s r2,r18
	.global L_8d3e54
L_8d3e54:
	b L_8c022c
