/* rf_sector_commit_tx @ 0x8d0ef4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_rfc.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, hwf_sector_rf_chain_set, rf_sector_params_write, txrx_sel
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_rfc_write_core
 */
	.section .text.rf_sector_commit_tx,"ax",@progbits
	.global rf_sector_commit_tx
rf_sector_commit_tx:
	.global L_8d0ef4
L_8d0ef4:
	push_s blink
L_8d0ef6:
	bl L_8c02bc
L_8d0efa:
	cmp_s r1,0x7f
L_8d0efc:
	mov_s r16,r0
L_8d0efe:
	mov_s r13,r1
L_8d0f00:
	bgt_s L_8d0f12
	.global L_8d0f02
L_8d0f02:
	mov_s r0,r16
L_8d0f04:
	mov_s r1,0x3
L_8d0f06:
	mov_s r2,r13
L_8d0f08:
	bl.d L_8d0f80
L_8d0f0c:
	mov_s r3,0x0
L_8d0f0e:
	b L_8c0324
	.global L_8d0f12
L_8d0f12:
	mov_s r0,blink
L_8d0f14:
	mov_s r2,0x1018f58
L_8d0f1a:
	mov_s r1,0x1150
L_8d0f20:
	bl.d L_8c82c0
L_8d0f24:
	mov_s r3,0xc0
L_8d0f26:
	b_s L_8d0f02
