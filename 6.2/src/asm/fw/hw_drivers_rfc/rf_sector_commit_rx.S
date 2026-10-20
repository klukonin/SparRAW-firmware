/* rf_sector_commit_rx @ 0x8d37dc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, hwf_sector_rf_chain_set, txrx_sel
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_sector_commit_rx
rf_sector_commit_rx:
	.global L_8d37dc
L_8d37dc:
	push_s blink
L_8d37de:
	bl L_8c01e4
L_8d37e2:
	cmp_s r1,0x7f
L_8d37e4:
	mov_s r14,r0
L_8d37e6:
	mov_s r13,r1
L_8d37e8:
	bgt_s L_8d37fa
	.global L_8d37ea
L_8d37ea:
	mov_s r0,r14
L_8d37ec:
	mov_s r1,0x2
L_8d37ee:
	mov_s r2,r13
L_8d37f0:
	bl.d L_8d415c
L_8d37f4:
	mov_s r3,0x0
L_8d37f6:
	b L_8c0254
	.global L_8d37fa
L_8d37fa:
	mov_s r0,blink
L_8d37fc:
	mov_s r1,0x114d
L_8d3802:
	bl L_8c9b28
L_8d3806:
	b_s L_8d37ea
