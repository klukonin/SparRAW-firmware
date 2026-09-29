/* rf_sector_commit_rx @ 0x8d073c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_rfc.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, hwf_sector_rf_chain_set, rf_sector_params_write, txrx_sel
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_rfc_write_core
 */
	.section .text.rf_sector_commit_rx,"ax",@progbits
	.global rf_sector_commit_rx
rf_sector_commit_rx:
	.global L_8d073c
L_8d073c:
	push_s blink
L_8d073e:
	bl L_8c02bc
L_8d0742:
	cmp_s r1,0x7f
L_8d0744:
	mov_s r16,r0
L_8d0746:
	mov_s r13,r1
L_8d0748:
	bgt_s L_8d075a
	.global L_8d074a
L_8d074a:
	mov_s r0,r16
L_8d074c:
	mov_s r1,0x2
L_8d074e:
	mov_s r2,r13
L_8d0750:
	bl.d L_8d0f80
L_8d0754:
	mov_s r3,0x0
L_8d0756:
	b L_8c0324
	.global L_8d075a
L_8d075a:
	mov_s r0,blink
L_8d075c:
	mov_s r2,0x1018f58
L_8d0762:
	mov_s r1,0x114d
L_8d0768:
	bl.d L_8c82c0
L_8d076c:
	mov_s r3,0xab
L_8d076e:
	b_s L_8d074a
