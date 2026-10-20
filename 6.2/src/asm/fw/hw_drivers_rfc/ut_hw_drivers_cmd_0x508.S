/* ut_hw_drivers_cmd_0x508 @ 0x8d4104, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd__program_rf_regs_seq, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, hwf_sector_rf_chain_set
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers_cmd_0x508
ut_hw_drivers_cmd_0x508:
	.global L_8d4104
L_8d4104:
	push_s blink
L_8d4106:
	bl L_8c01dc
L_8d410a:
	mov_s r16,r0
L_8d410c:
	cmp_s r1,0x7f
L_8d410e:
	mov_s r13,r1
L_8d4110:
	mov_s r14,r2
L_8d4112:
	bgt_s L_8d4130
	.global L_8d4114
L_8d4114:
	brge r14,0x10,L_8d413e
	.global L_8d4118
L_8d4118:
	bmsk_s r14,r14,0x3
L_8d411a:
	asl_s r3,r14,0x7
L_8d411c:
	bmsk r2,r13,0x6
L_8d4120:
	mov_s r0,r16
L_8d4122:
	mov_s r1,0xa
L_8d4124:
	or_s r2,r2,r3
L_8d4126:
	bl.d L_8d415c
L_8d412a:
	mov_s r3,0x0
L_8d412c:
	b L_8c0244
	.global L_8d4130
L_8d4130:
	mov_s r0,blink
L_8d4132:
	mov_s r1,0x1556
L_8d4138:
	bl L_8c9b28
L_8d413c:
	b_s L_8d4114
	.global L_8d413e
L_8d413e:
	mov_s r0,blink
L_8d4140:
	mov_s r1,0x115b
L_8d4146:
	bl L_8c9b28
L_8d414a:
	b_s L_8d4118
