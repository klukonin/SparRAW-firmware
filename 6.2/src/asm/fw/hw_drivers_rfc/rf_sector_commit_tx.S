/* rf_sector_commit_tx @ 0x8d40d8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, hwf_sector_rf_chain_set, txrx_sel
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_sector_commit_tx
rf_sector_commit_tx:
	.global L_8d40d8
L_8d40d8:
	push_s blink
L_8d40da:
	bl L_8c01e4
L_8d40de:
	cmp_s r1,0x7f
L_8d40e0:
	mov_s r14,r0
L_8d40e2:
	mov_s r13,r1
L_8d40e4:
	bgt_s L_8d40f6
	.global L_8d40e6
L_8d40e6:
	mov_s r0,r14
L_8d40e8:
	mov_s r1,0x3
L_8d40ea:
	mov_s r2,r13
L_8d40ec:
	bl.d L_8d415c
L_8d40f0:
	mov_s r3,0x0
L_8d40f2:
	b L_8c0254
	.global L_8d40f6
L_8d40f6:
	mov_s r0,blink
L_8d40f8:
	mov_s r1,0x1150
L_8d40fe:
	bl L_8c9b28
L_8d4102:
	b_s L_8d40e6
